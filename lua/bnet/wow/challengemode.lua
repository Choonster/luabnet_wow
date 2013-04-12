--- Blizzard Battle.net Community Platform API Library
-- Easily retrieve various types of data from Blizzard's API in the format of Lua tables.
-- @class: module
-- @name: bnet.wow.challengemode
-- Implements the Challenge Mode section of the API.

--[[
This is just here so LuaDoc recognises this as a module.
module("bnet.wow.challengemode")
]]

local wow, url_absolute, debugprint, wipe, createRef, decompress, splitPath, joinPath, Get, Set, GetCache, SetCache = ...

local HALF_HOUR = 0.5 * 60 * 60 -- Number of seconds in half an hour

-- tools:SendRequest(path, fields, locale, reqType, cachePath, expires, forceRefresh)

--- Retrieve the Challenge Mode Leaderboard for the realm.
-- <br/> See :SendRequest for return values. See :SendRequest and :SendRequestRaw for more information on the locale and forceRefresh parameters.
-- @param realm (string) The name or slug of the realm.
-- @param locale (string, optional) The locale to retrieve the data in.
-- @param forceRefresh (boolean, optional) If true, send a request regardless of cached results.
function wow:GetChallengeModeRealmLeaderboard(realm, locale, forceRefresh)
	local cachePath = realm
	return self:SendRequest(url_absolute("/api/wow/challenge/", realm), nil, locale, "challengeModeLeaderboard", cachePath, HALF_HOUR, forceRefresh)
end

--- Retrieve the Challenge Mode Leaderboard for the region.
-- <br/> See :SendRequest for return values. See :SendRequest and :SendRequestRaw for more information on the locale and forceRefresh parameters.
-- @param locale (string, optional) The locale to retrieve the data in.
-- @param forceRefresh (boolean, optional) If true, send a request regardless of cached results.
function wow:GetChallengeModeRegionLeaderboard(locale, forceRefresh)
	local cachePath = "region"
	return self:SendRequest("/api/wow/challenge/region", nil, locale, "challengeModeLeaderboard", cachePath, HALF_HOUR, forceRefresh)
end