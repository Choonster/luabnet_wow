--- Blizzard Battle.net Community Platform API Library
-- Easily retrieve various types of data from Blizzard's API in the format of Lua tables.
-- @class: module
-- @name: bnet.wow.quest
-- Implements the Quest Resources section of the API.

--[[
This is just here so LuaDoc recognises this as a module.
module("bnet.wow.quest")
]]

local wow, url_absolute, debugprint, wipe, createRef, decompress, splitPath, joinPath, Get, Set, GetCache, SetCache = ...

local THIRTY_DAYS = 30 * 24 * 60 * 60 -- Number of seconds in thirty days

--- Retrieve information about a quest.
-- <br/> See :SendRequest for return values. See :SendRequest and :SendRequestRaw for more information on the locale and forceRefresh parameters.
-- @param questID (number or string) The questID to query.
-- @param locale (string, optional) The locale to retrieve the data in.
-- @param forceRefresh (boolean, optional) If true, send a request regardless of cached results.
function wow:GetQuestInfo(questID, locale, forceRefresh)
	local cachePath = questID
	return self:SendRequest(url.absolute("/api/wow/quest/", questID), nil, locale, "questInfo", cachePath, THIRTY_DAYS, forceRefresh)
end