--- Blizzard Battle.net Community Platform API Library.
-- Easily retrieve various types of data from Blizzard's API in the format of Lua tables.
-- Implements the Data Resources section of the API
-- @module bnet.wow.data
-- @alias wow

--[[
This is just here so LuaDoc recognises this as a module.
module("bnet.wow.data")
]]

local wow, url_absolute, debugprint, wipe, createRef, decompress, splitPath, joinPath, Get, Set, GetCache, SetCache = ...

local THIRTY_DAYS = 30 * 24 * 60 * 60 -- Number of seconds in thirty days

-- tools:SendRequest(path, fields, locale, reqType, cachePath, expires, forceRefresh)

--- Retrieve a list of Battlegroups.
-- <br/> See :SendRequest for return values. See :SendRequest and :SendRequestRaw for more information on the forceRefresh parameter.
-- @param forceRefresh (boolean, optional) If true, send a request regardless of cached results.
function wow:GetBattlegroups(forceRefresh)
	local cachePath = "battlegroups"
	return self:SendRequest("/api/wow/data/battlegroups/", nil, nil, "battlegroups", cachePath, THIRTY_DAYS, forceRefresh)
end

--- Retrieve a list of character races.
-- <br/> See :SendRequest for return values. See :SendRequest and :SendRequestRaw for more information on the locale and forceRefresh parameters.
-- @param locale (string, optional) The locale to retrieve the data in.
-- @param forceRefresh (boolean, optional) If true, send a request regardless of cached results.
function wow:GetCharacterRaces(locale, forceRefresh)
	local cachePath = "charRaces"
	return self:SendRequest("/api/wow/data/character/races", nil, locale, "charRaces", cachePath, THIRTY_DAYS, forceRefresh)
end

--- Retrieve a list of character classes.
-- <br/> See :SendRequest for return values. See :SendRequest and :SendRequestRaw for more information on the locale and forceRefresh parameters.
-- @param locale (string, optional) The locale to retrieve the data in.
-- @param forceRefresh (boolean, optional) If true, send a request regardless of cached results.
function wow:GetCharacterClasses(locale, forceRefresh)
	local cachePath = "charClasses"
	return self:SendRequest("/api/wow/data/character/classes", nil, locale, "charClasses", cachePath, THIRTY_DAYS, forceRefresh)
end

--- Retrieve a list of character achievements.
-- <br/> See :SendRequest for return values. See :SendRequest and :SendRequestRaw for more information on the locale and forceRefresh parameters.
-- @param locale (string, optional) The locale to retrieve the data in.
-- @param forceRefresh (boolean, optional) If true, send a request regardless of cached results.
function wow:GetCharacterAchievements(locale, forceRefresh)
	local cachePath = "charAchievements"
	return self:SendRequest("/api/wow/data/character/achievements", nil, locale, "charAchievements", cachePath, THIRTY_DAYS, forceRefresh)
end

--- Retrieve a list of guild rewards.
-- <br/> See :SendRequest for return values. See :SendRequest and :SendRequestRaw for more information on the locale and forceRefresh parameters.
-- @param locale (string, optional) The locale to retrieve the data in.
-- @param forceRefresh (boolean, optional) If true, send a request regardless of cached results.
function wow:GetGuildRewards(locale, forceRefresh)
	local cachePath = "guildRewards"
	return self:SendRequest("/api/wow/data/guild/rewards", nil, locale, "guildRewards", cachePath, THIRTY_DAYS, forceRefresh)
end

--- Retrieve a list of guild perks.
-- <br/> See :SendRequest for return values. See :SendRequest and :SendRequestRaw for more information on the locale and forceRefresh parameters.
-- @param locale (string, optional) The locale to retrieve the data in.
-- @param forceRefresh (boolean, optional) If true, send a request regardless of cached results.
function wow:GetGuildPerks(locale, forceRefresh)
	local cachePath = "guildPerks"
	return self:SendRequest("/api/wow/data/guild/perks", nil, locale, "guildPerks", cachePath, THIRTY_DAYS, forceRefresh)
end

--- Retrieve a list of guild achievements.
-- <br/> See :SendRequest for return values. See :SendRequest and :SendRequestRaw for more information on the locale and forceRefresh parameters.
-- @param locale (string, optional) The locale to retrieve the data in.
-- @param forceRefresh (boolean, optional) If true, send a request regardless of cached results.
function wow:GetGuildAchievements(locale, forceRefresh)
	local cachePath = "guildAchievements"
	return self:SendRequest("/api/wow/data/guild/achievements", nil, locale, "guildAchievements", cachePath, THIRTY_DAYS, forceRefresh)
end

--- Retrieve a list of item classes.
-- <br/> See :SendRequest for return values. See :SendRequest and :SendRequestRaw for more information on the locale and forceRefresh parameters.
-- @param locale (string, optional) The locale to retrieve the data in.
-- @param forceRefresh (boolean, optional) If true, send a request regardless of cached results.
function wow:GetItemClasses(locale, forceRefresh)
	local cachePath = "itemClasses"
	return self:SendRequest("/api/wow/data/item/classes", nil, locale, "itemClasses", cachePath, THIRTY_DAYS, forceRefresh)
end

--- Retrieve a list of talents, specs and glyphs for each class.
-- <br/> See :SendRequest for return values. See :SendRequest and :SendRequestRaw for more information on the locale and forceRefresh parameters.
-- @param locale (string, optional) The locale to retrieve the data in.
-- @param forceRefresh (boolean, optional) If true, send a request regardless of cached results.
function wow:GetTalents(locale, forceRefresh)
	local cachePath = "talents"
	return self:SendRequest("/api/wow/data/talents", nil, locale, "talents", cachePath, THIRTY_DAYS, forceRefresh)
end

--- Retrieve a list of battle pet types (including what they are strong and weak against).
-- <br/> See :SendRequest for return values. See :SendRequest and :SendRequestRaw for more information on the locale and forceRefresh parameters.
-- @param locale (string, optional) The locale to retrieve the data in.
-- @param forceRefresh (boolean, optional) If true, send a request regardless of cached results.
function wow:GetBattlePetTypes(locale, forceRefresh)
	local cachePath = "battlePetTypes"
	return self:SendRequest("/api/wow/data/pet/types", nil, locale, "battlePetTypes", cachePath, THIRTY_DAYS, forceRefresh)
end
