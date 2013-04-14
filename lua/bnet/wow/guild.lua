--- Blizzard Battle.net Community Platform API Library.
-- Easily retrieve various types of data from Blizzard's API in the format of Lua tables.
-- Implements the Guild Resources section of the API.
-- @module bnet.wow.guild
-- @alias wow

--[[
This is just here so LuaDoc recognises this as a module.
module("bnet.wow.guild")
]]

local wow, url_absolute, debugprint, wipe, createRef, decompress, splitPath, joinPath, Get, Set, GetCache, SetCache = ...

local HALF_HOUR = 0.5 * 60 * 60 -- Number of seconds in half an hour

--- Retrieve a guild profile table.
-- <br/> See :SendRequest for return values. See :SendRequest and :SendRequestRaw for more information on the locale and forceRefresh parameters.
-- @param realm (string) The realm of the guild.
-- @param guild (string) The name of the guild.
-- @param fields (string, optional) A list of comma-separated fields to query.
-- @param locale (string, optional) The locale to retrieve the data in.
-- @param forceRefresh (boolean, optional) If true, send a request regardless of cached results.
function wow:GetGuildProfile(realm, guild, fields, locale, forceRefresh)
	realm, guild = realm:lower(), guild:lower()
	local cachePath = joinPath(realm, guild, fields)
	return self:SendRequest(url_absolute("/api/wow/guild/", ("%s/%s"):format(realm, guild)), fields, nil, "guildProfile", cachePath, HALF_HOUR, forceRefresh)
end