--- Blizzard Battle.net Community Platform API Library.
-- Easily retrieve various types of data from Blizzard's API in the format of Lua tables.
-- Implements the Item Resources section of the API.
-- @module bnet.wow.item
-- @alias wow

--[[
This is just here so LuaDoc recognises this as a module.
module("bnet.wow.item")
]]

local wow, url_absolute, debugprint, wipe, createRef, decompress, splitPath, joinPath, Get, Set, GetCache, SetCache = ...

local THIRTY_DAYS = 30 * 24 * 60 * 60 -- Number of seconds in thirty days

-- tools:SendRequest(path, fields, locale, reqType, cachePath, expires, forceRefresh)

--- Retrieve item information.
-- <br/> See :SendRequest for return values. See :SendRequest and :SendRequestRaw for more information on the locale and forceRefresh parameters.
-- @param itemID (string or number) The itemID to query.
-- @param locale (string, optional) The locale to retrieve the data in.
-- @param forceRefresh (boolean, optional) If true, send a request regardless of cached results.
function wow:GetItemInfo(itemID, locale, forceRefresh)
	local cachePath = itemID
	return self:SendRequest(url_absolute("/api/wow/item/", itemID), nil, locale, "itemInfo", cachePath, THIRTY_DAYS, forceRefresh)
end

--- Retrieve item set information.
-- <br/> See :SendRequest for return values. See :SendRequest and :SendRequestRaw for more information on the locale and forceRefresh parameters.
-- @param setID (string or number) The setID to query.
-- @param locale (string, optional) The locale to retrieve the data in.
-- @param forceRefresh (boolean, optional) If true, send a request regardless of cached results.
function wow:GetItemInfo(setID, locale, forceRefresh)
	local cachePath = setID
	return self:SendRequest(url_absolute("/api/wow/item/set/", setID), nil, locale, "itemSetInfo", cachePath, THIRTY_DAYS, forceRefresh)
end