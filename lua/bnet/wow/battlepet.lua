--- Blizzard Battle.net Community Platform API Library
-- Easily retrieve various types of data from Blizzard's API in the format of Lua tables.
-- @class: module
-- @name: bnet.wow.battlepet
-- Implements the Battle Pet section of the API.

--[[
This is just here so LuaDoc recognises this as a module.
module("bnet.wow.battlepet")
]]

local wow, url_absolute, debugprint, wipe, createRef, decompress, splitPath, joinPath, Get, Set, GetCache, SetCache = ...

local THIRTY_DAYS = 30 * 24 * 60 * 60 -- Number of seconds in thirty days

-- tools:SendRequest(path, fields, locale, reqType, cachePath, expires, forceRefresh)

--- Retrieve information about a Battle Pet Ability.
-- <br/> See :SendRequest for return values. See :SendRequest and :SendRequestRaw for more information on the locale and forceRefresh parameters.
-- @param abilityID (string or number) The abilityID to query.
-- @param locale (string, optional) The locale to retrieve the data in.
-- @param forceRefresh (boolean, optional) If true, send a request regardless of cached results.
function wow:GetBattlePetAbilityInfo(abilityID, locale, forceRefresh)
	local cachePath = abilityID
	return self:SendRequest(url_absolute("/api/wow/battlePet/ability/", abilityID), nil, locale, "battlePetAbilityInfo", cachePath, THIRTY_DAYS, forceRefresh)
end

--- Retrieve information about a Battle Pet Species.
-- <br/> See :SendRequest for return values. See :SendRequest and :SendRequestRaw for more information on the locale and forceRefresh parameters.
-- @param speciesID (string or number) The speciesID to query.
-- @param locale (string, optional) The locale to retrieve the data in.
-- @param forceRefresh (boolean, optional) If true, send a request regardless of cached results.
function wow:GetBattlePetSpeciesInfo(speciesID, locale, forceRefresh)
	local cachePath = speciesID
	return self:SendRequest(url_absolute("/api/wow/battlePet/species/", speciesID), nil, locale, "battlePetSpeciesInfo", cachePath, THIRTY_DAYS, forceRefresh)
end

--- Retrieve the stats of a Battle Pet Species.
-- <br/> See :SendRequest for return values. See :SendRequest and :SendRequestRaw for more information on the forceRefresh parameter.
-- @param speciesID (string or number) The speciesID to retrieve stats for.
-- @param level (string or number, optional) The level of the pet.
-- @param breedID (string or number, optional) The breed of the pet.
-- @param qualityID (string or number, optional) The quality of the pet.
-- @param forceRefresh (boolean, optional) If true, send a request regardless of cached results.
function wow:GetBattlePetSpeciesStats(speciesID, level, breedID, qualityID, forceRefresh)
	local levelStr = level and ("&level=%d"):format(level) or ""
	local breedStr = breedID and ("&breedId=%d"):format(size) or ""
	local qualityStr = qualityID and ("&qualityId=%d"):format(qualityID) or ""
	
	local query = levelStr .. breedStr .. qualityStr
	
	local cachePath = joinPath(speciesID, query)
	
	return self:SendRequest(url_absolute("/api/wow/battlePet/stats/", speciesID), query, nil, "battlePetSpeciesStats", cachePath, THIRTY_DAYS, forceRefresh)
end