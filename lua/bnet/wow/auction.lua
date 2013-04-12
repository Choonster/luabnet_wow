--- Blizzard Battle.net Community Platform API Library
-- Easily retrieve various types of data from Blizzard's API in the format of Lua tables.
-- @class: module
-- @name: bnet.wow.auction
-- Implements the Auction Resources section of the API.

--[[
This is just here so LuaDoc recognises this as a module.
module("bnet.wow.auction")
]]

local wow, url_absolute, debugprint, wipe, createRef, decompress, splitPath, joinPath, Get, Set, GetCache, SetCache = ...

local json_decode = require("json").decode

local time, clock, difftime = os.time, os.clock, os.difftime

local ONE_HOUR = 60 * 60 -- Number of seconds in an hour

-- Retrieve a URL pointing to the most recent auction data dump. -- No longer public
local function GetURL(self, realm, forceRefresh)
	local cachePath = realm
	return self:SendRequest(url_absolute("/api/wow/auction/data/", realm), nil, locale, "auctionURL", cachePath, ONE_HOUR, forceRefresh)
end

local function decodeAll(str)
	local t = {}
	print("decoding", str:sub(-25))
	local count = 0
	for obj in str:gmatch("%b{}") do
		count = count + 1
		t[count] = json_decode(obj)
	end
	print("decoded", ("%d matches"):format(num))
	return t
end

local MATCHSTRING = [[{%s*"realm":(%b{}),%s*"alliance":{"auctions":(%b[])},%s*"horde":{"auctions":(%b[])},%s*"neutral":{"auctions":(%b[])}%s*}]] -- Defined here rather than in the function for readability.

local function splitAndDecode(JSON)
	print("splitting")
	local realm, alliance, horde, neutral = JSON:match(MATCHSTRING)
	local result = {}
	result.realm = json_decode(realm)
	result.alliance = { auctions = decodeAll(alliance) }
	result.horde    = { auctions = decodeAll(horde)    }
	result.neutral  = { auctions = decodeAll(neutral)  }
	return result
end

--- Retrieve an auction data dump.
-- Due to the extremely large size of these dumps, this request will often take a long time to process. Using a faster decompression library will speed this up slightly.
-- <br/> See :SendRequest for return values. See :SendRequest and :SendRequestRaw for more information on the forceRefresh parameter.
-- @param realm (string) The realm to get auction data for.
-- @param forceRefresh (boolean, optional) If true, send a request regardless of cached results.
function wow:GetAuctionData(realm, forceRefresh)
	local startTime = time()
	local startClock = clock()
	local reqType = "auctionData"
	
	realm = realm:lower()
	
	local dataPath = joinPath(realm, "data")
	
	local success, aucURL, code, status, headers = GetURL(self, realm, forceRefresh)
	
	local resultJSON;
	if code == 200 then
		success, resultJSON, code, status, headers = self:SendRequestRaw(self:GetPath(aucURL), nil, reqType, nil, forceRefresh)
			 -- The If-Modified-Since header is taken care of in GetURL so we can use nil as the lastModified argument here
	end
	
	local result;
	if code == 200 then
		success = true
		print("request success")
		result = splitAndDecode(resultJSON)
		SetCache(self, reqType, dataPath, result)
	elseif code == 304 then
		success = true
		print(304, status)
		result = GetCache(self, reqType, dataPath)
	else
		success = false
		print("request failed")
		result = (resultJSON and resultJSON ~= "") and json_decode(resultJSON).reason or resultJSON
	end
	
	return success, result, code, status, headers, difftime(time(), startTime), difftime(clock(), startClock)
end