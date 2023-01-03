--- Implements the PvP section of the API
-- @alias wow

local wow, url_absolute, debugprint, wipe, createRef, decompress, splitPath, joinPath, assertString, assertNumber, Get, Set, GetCache, SetCache = ...

local HALF_HOUR = 0.5 * 60 * 60 -- Number of seconds in half an hour


--- Retrieve arena team information.
-- @string realm The realm of the team.
-- @number teamSize The size of the team. For a 2v2 team, use 2 as the team size.
-- @string team The name of the team.
-- @string[opt] locale The locale to retrieve the data in.
-- @bool[opt] forceRefresh If true, send a request regardless of cached results.
-- @treturn bool success: Did the query succeed?
-- @treturn Proxy result: A proxy to the decoded JSON data.
-- @treturn number code: The HTTP response status code. If no request was sent, this will be 304.
-- @treturn string status: The full HTTP response status. If no request was sent, this will be "No request sent".
-- @treturn table headers: The HTTP headers of the response. If no request was sent, this will be nil.
-- @treturn number time: The number of seconds between the function being called and the results being returned, calculated with os.time().
-- @treturn number clock: The number of seconds of CPU time used between the function being called and the results being returned, calculated with os.clock().
function wow:GetArenaTeamInfo(realm, teamSize, team, locale, forceRefresh)
	realm, team = realm:lower(), team:lower()
	local teamSizeStr = teamSize .. "v" .. teamSize
	
	local cachePath = joinPath(realm, teamSizeStr, team)
	
	return self:SendRequest(url_absolute("/api/wow/arena/", ("%s/%s/%s"):format(realm, teamSizeStr, team)), nil, locale, "arenaTeam", cachePath, HALF_HOUR, forceRefresh)
end

--- Retrieve the Arena Ladder for the battlegroup.
-- @string battlegroup The Battlegroup to query.
-- @number teamSize The size of the team. For a 2v2 team, use 2 as the team size.
-- @number[opt=1] page Which page of results to return
-- @number[opt=50] size How many results to return per page
-- @bool[opt=true] ascending Whether to return the results in ascending order. Defaults to true if omitted.
-- @string[opt] locale The locale to retrieve the data in.
-- @bool[opt] forceRefresh If true, send a request regardless of cached results.
-- @treturn bool success: Did the query succeed?
-- @treturn Proxy result: A proxy to the decoded JSON data.
-- @treturn number code: The HTTP response status code. If no request was sent, this will be 304.
-- @treturn string status: The full HTTP response status. If no request was sent, this will be "No request sent".
-- @treturn table headers: The HTTP headers of the response. If no request was sent, this will be nil.
-- @treturn number time: The number of seconds between the function being called and the results being returned, calculated with os.time().
-- @treturn number clock: The number of seconds of CPU time used between the function being called and the results being returned, calculated with os.clock().
function wow:GetArenaLadder(battlegroup, teamSize, page, size, ascending, locale, forceRefresh)
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
-- @number[opt=1] page Which page of results to return
-- @number[opt=50] size How many results to return per page
-- @bool[opt=true] ascending Whether to return the results in ascending order.
-- @string[opt] locale The locale to retrieve the data in.
-- @bool[opt] forceRefresh If true, send a request regardless of cached results.
-- @treturn bool success: Did the query succeed?
-- @treturn Proxy result: A proxy to the decoded JSON data.
-- @treturn number code: The HTTP response status code. If no request was sent, this will be 304.
-- @treturn string status: The full HTTP response status. If no request was sent, this will be "No request sent".
-- @treturn table headers: The HTTP headers of the response. If no request was sent, this will be nil.
-- @treturn number time: The number of seconds between the function being called and the results being returned, calculated with os.time().
-- @treturn number clock: The number of seconds of CPU time used between the function being called and the results being returned, calculated with os.clock().
function wow:GetRatedBGLadder(page, size, ascending, locale, forceRefresh)
	local pageStr = page and ("&page=%d"):format(page) or ""
	local sizeStr = size and ("&size=%d"):format(size) or ""
	local ascStr  = ascending ~= nil and ("&asc=%s"):format(tostring(not not ascending)) or ""
	local query = pageStr .. sizeStr .. ascStr
	
	local cachePath = query
	
	return self:SendRequest("/api/wow/pvp/ratedbg/ladder", query, locale, "ratedBGLadder", cachePath, HALF_HOUR, forceRefresh)
end