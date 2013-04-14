--- Blizzard Battle.net Community Platform API Library.
-- Easily retrieve various types of data from Blizzard's API in the format of Lua tables.
-- Implements the Achievement section of the API.
-- @module bnet.wow.achievement
-- @alias wow

local wow, url_absolute, debugprint, wipe, createRef, decompress, splitPath, joinPath, Get, Set, GetCache, SetCache = ...

local THIRTY_DAYS = 30 * 24 * 60 * 60 -- Number of seconds in thirty days

--- Retrieve achievement information.
-- See :SendRequest for return values. See :SendRequest and :SendRequestRaw for more information on the locale and forceRefresh parameters.
-- @param achievementID (string or number) The achievemntID to query.
-- @param locale (string, optional) The locale to retrieve the data in.
-- @param forceRefresh (boolean, optional) If true, send a request regardless of cached results.
function wow:GetAchievementInfo(achievementID, locale, forceRefresh)
	local cachePath = achievementID
	return self:SendRequest(url_absolute("/api/wow/achievemnt/", achievementID), nil, locale, "achievemntInfo", cachePath, THIRTY_DAYS, forceRefresh)
end