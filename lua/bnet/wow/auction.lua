--- Blizzard Battle.net Community Platform API Library
-- Easily retrieve various types of data from Blizzard's API in the format of Lua tables.
-- Implements the Auction Resources section of the API.
-- @module bnet.wow.auction
-- @alias wow

--[[
This is just here so LuaDoc recognises this as a module.
module("bnet.wow.auction")
]]

local wow, url_absolute, debugprint, wipe, createRef, decompress, splitPath, joinPath, Get, Set, GetCache, SetCache = ...

local json_decode = require("json").decode

local time, clock, difftime = os.time, os.clock, os.difftime
local match = string.match

local ONE_HOUR = 60 * 60 -- Number of seconds in an hour

-- Retrieve a URL pointing to the most recent auction data dump. -- No longer public
local function GetURL(self, realm, forceRefresh)
	local cachePath = realm
	return self:SendRequest(url_absolute("/api/wow/auction/data/", realm), nil, locale, "auctionURL", cachePath, ONE_HOUR, forceRefresh)
end

--[[
-- LuaJSON 1.3 and later fixes the "stack overflow (too many captures)" error when decoding large JSON strings like the auction data dumps.
-- This removes the need for manual decoding of the dumps, so this section is no longer needed.

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
--]]

-- Get the path section of an absolute URL. (no longer public)
-- Primarily used in :GetAuctionData to convert an absolute URL returned by :GetAuctionDataURL into a path for :SendRequestRaw.
-- @param URL (string) An absolute URL. Must contain the current host as returned by :GetHost.
-- @return path: (string) The path section of the URL.
local function GetPath(self, URL)
	debugprint("URL:", URL)
	return match(URL, self:GetHost() .. "(%/.+)$")
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
	local urlCachePath = realm
	
	local aucRequestType = "url"
	
	local success, aucURL, code, status, headers = self:SendRequest(url_absolute("/api/wow/auction/data/", realm), nil, locale, "auctionURL", , ONE_HOUR, forceRefresh)
	
	local result;
	if code == 200 then
		-- success, resultJSON, code, status, headers = self:SendRequestRaw(self:GetPath(aucURL), nil, reqType, nil, forceRefresh) -- Manual decoding no longer necessary, see the comments above.
		success, result, code, status, headers = self:SendRequest(GetPath(self, aucURL), nil, reqType, nil, forceRefresh)
			-- The If-Modified-Since header is taken care of in GetURL so we can use nil as the lastModified argument here
		aucRequestType = "data"
	end
	
	if code == 200 then -- If both the URL and data requests returned 200, set success to true and cache the result
		success = true
		print("request success")
		--result = splitAndDecode(resultJSON)
		SetCache(self, reqType, dataPath, result)
	elseif code == 304 then -- If the URL request returned 304 (HTTP Not Modified or no request sent), set success to true and return the cached result
		success = true
		print(304, status)
		result = GetCache(self, reqType, dataPath)
	else -- If either the URL or data request returned a different status, set success to false
		success = false
		print("request failed")
		result = result or aucURL -- Depending on which request failed, either result or aucURL will be an error message
	end
	--]]
	
	return success, createRef(result), code, status, headers, difftime(time(), startTime), difftime(clock(), startClock), aucRequestType
end