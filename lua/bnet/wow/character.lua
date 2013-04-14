--- Blizzard Battle.net Community Platform API Library.
-- Easily retrieve various types of data from Blizzard's API in the format of Lua tables.
-- Implements the Character Resources section of the API.
-- @module bnet.wow.character
-- @alias wow

local wow, url_absolute, debugprint, wipe, createRef, decompress, splitPath, joinPath, Get, Set, GetCache, SetCache = ...

local HALF_HOUR = 0.5 * 60 * 60 -- Number of seconds in half an hour

-- tools:SendRequest(path, fields, locale, reqType, cachePath, expires, forceRefresh)

--- Retrieve a character profile table, optionally with the specified fields and locale.
-- <br/> See :SendRequest for return values. See :SendRequest and :SendRequestRaw for more information on the locale and forceRefresh parameters.
-- @param realm (string) The realm of the character.
-- @param character (string) The name of the character.
-- @param fields (string, optional) A list of comma-separated fields to query.
-- @param locale (string, optional) The locale to retrieve the data in.
-- @param forceRefresh (boolean, optional) If true, send a request regardless of cached results.
function wow:GetCharacterProfile(realm, character, fields, locale, forceRefresh)
	realm, character = realm:lower(), character:lower()
	local cachePath = joinPath(realm, character, fields)
	return self:SendRequest(url_absolute("/api/wow/character/", ("%s/%s"):format(realm, character)), fields, locale, "charProfile", cachePath, HALF_HOUR, forceRefresh)
end