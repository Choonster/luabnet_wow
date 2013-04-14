--- Blizzard Battle.net Community Platform API Library.
-- Easily retrieve various types of data from Blizzard's API in the format of Lua tables.
-- Implements the Spell section of the API.
-- @module bnet.wow.spell
-- @alias wow

--[[
This is just here so LuaDoc recognises this as a module.
module("bnet.wow.spell")
]]

local wow, url_absolute, debugprint, wipe, createRef, decompress, splitPath, joinPath, Get, Set, GetCache, SetCache = ...

local THIRTY_DAYS = 30 * 24 * 60 * 60 -- Number of seconds in thirty days

-- tools:SendRequest(path, fields, locale, reqType, cachePath, expires, forceRefresh)

--- Retrieve spell information.
-- <br/> See :SendRequest for return values. See :SendRequest and :SendRequestRaw for more information on the locale and forceRefresh parameters.
-- @param spellID (string or number) The spellID to query.
-- @param locale (string, optional) The locale to retrieve the data in.
-- @param forceRefresh (boolean, optional) If true, send a request regardless of cached results.
function wow:GetItemInfo(spellID, locale, forceRefresh)
	local cachePath = spellID
	return self:SendRequest(url_absolute("/api/wow/spell/", spellID), nil, locale, "spellInfo", cachePath, THIRTY_DAYS, forceRefresh)
end