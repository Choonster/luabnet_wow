--- Blizzard Battle.net Community Platform API Library
-- Easily retrieve various types of data from Blizzard's API in the format of Lua tables.
-- @class: module
-- @name: bnet.wow.pvp
-- Implements the PVP Resources section of the API.

--[[
This is just here so LuaDoc recognises this as a module.
module("bnet.wow.pvp")
]]

local wow, url_absolute, debugprint, wipe, createRef, decompress, splitPath, joinPath, Get, Set, GetCache, SetCache = ...

local HALF_HOUR = 0.5 * 60 * 60 -- Number of seconds in half an hour


--- Retrieve arena team information.
-- <br/> See :SendRequest for return values. See :SendRequest and :SendRequestRaw for more information on the forceRefresh parameter.
-- @param realm (string) The realm of the team.
-- @param teamSize (number) The size of the team. For a 2v2 team, use 2 as the team size.
-- @param team (string) The name of the team.
-- @param locale (string, optional) The locale to retrieve the data in.
-- @param forceRefresh (boolean, optional) If true, send a request regardless of cached results.
function wow:GetArenaTeamInfo(realm, teamSize, team, locale, forceRefresh)
	realm, team = realm:lower(), team:lower()
	local teamSizeStr = teamSize .. "v" .. teamSize
	
	local cachePath = joinPath(realm, teamSizeStr, team)
	
	return self:SendRequest(url_absolute("/api/wow/arena/", ("%s/%s/%s"):format(realm, teamSizeStr, team)), nil, locale, "arenaTeam", cachePath, HALF_HOUR, forceRefresh)
end

--- Retrieve the Arena Ladder for the battlegroup.
-- <br/> See :SendRequest for return values. See :SendRequest and :SendRequestRaw for more information on the forceRefresh parameter.
-- @param battlegroup (string) The Battlegroup to query.
-- @param teamSize (number) The size of the team. For a 2v2 team, use 2 as the team size.
-- @param page (number, optional) Which page of results to return (defaults to 1)
-- @param size (number, optional) How many results to return per page (defaults to 50)
-- @param ascending (boolean, optional) Whether to return the results in ascending order. Defaults to true if omitted.
-- @param forceRefresh (boolean, optional) If true, send a request regardless of cached results.
function wow:GetArenaLadder(battlegroup, teamSize, page, size, ascending, locale forceRefresh)
	battlegroup = battlegroup:lower()
	local teamSizeStr = teamSize .. "v" .. teamSize
	
	local pageStr = page and ("&page=%d"):format(page) or ""
	local sizeStr = size and ("&size=%d"):format(size) or ""
	local ascStr  = ascending ~= nil and ("&asc=%s"):format(tostring(not not ascending)) or ""
	local query = pageStr .. sizeStr .. ascStr
	
	local cachePath = joinPath(battlegroup, teamSizeStr, query)
	
	return self:SendRequest(url_absolute("/api/wow/pvp/arena/", ("%s/%s"):format(battlegroup, teamSizeStr)), query, locale, "arenaLadder", cachePath, HALF_HOUR, forceRefresh)
end

--- Retrieve the Rated Battleground Ladder for the region.
-- <br/> See :SendRequest for return values. See :SendRequest and :SendRequestRaw for more information on the forceRefresh parameter.
-- @param page (number, optional) Which page of results to return (defaults to 1)
-- @param size (number, optional) How many results to return per page (defaults to 50)
-- @param ascending (boolean, optional) Whether to return the results in ascending order. Defaults to true if omitted.
-- @param forceRefresh (boolean, optional) If true, send a request regardless of cached results.
function wow:GetRatedBGLadder(page, size, ascending, locale, forceRefresh)
	local pageStr = page and ("&page=%d"):format(page) or ""
	local sizeStr = size and ("&size=%d"):format(size) or ""
	local ascStr  = ascending ~= nil and ("&asc=%s"):format(tostring(not not ascending)) or ""
	local query = pageStr .. sizeStr .. ascStr
	
	local cachePath = query
	
	return self:SendRequest("/api/wow/pvp/ratedbg/ladder", query, locale, "ratedBGLadder", cachePath, HALF_HOUR, forceRefresh)
end