--- Implements the Battle Pet section of the API
-- @alias wow

local wow, url_absolute, debugprint, wipe, createRef, decompress, splitPath, joinPath, assertString, assertNumber, Get, Set, GetCache, SetCache = ...

local THIRTY_DAYS = 30 * 24 * 60 * 60 -- Number of seconds in thirty days

--- Retrieve information about a Battle Pet Ability.
-- @number abilityID The abilityID to query.
-- @string[opt] locale The locale to retrieve the data in.
-- @bool[opt] forceRefresh If true, send a request regardless of cached results.
-- @treturn bool success: Did the query succeed?
-- @treturn Proxy result: A proxy to the decoded JSON data.
-- @treturn number code: The HTTP response status code. If no request was sent, this will be 304.
-- @treturn string status: The full HTTP response status. If no request was sent, this will be "No request sent".
-- @treturn table headers: The HTTP headers of the response. If no request was sent, this will be nil.
-- @treturn number time: The number of seconds between the function being called and the results being returned, calculated with os.time().
-- @treturn number clock: The number of seconds of CPU time used between the function being called and the results being returned, calculated with os.clock().
function wow:GetBattlePetAbilityInfo(abilityID, locale, forceRefresh)
	local cachePath = abilityID
	return self:SendRequest(url_absolute("/api/wow/battlePet/ability/", abilityID), nil, locale, "battlePetAbilityInfo", cachePath, THIRTY_DAYS, forceRefresh)
end

--- Retrieve information about a Battle Pet Species.
-- @number speciesID The speciesID to query.
-- @string[opt] locale The locale to retrieve the data in.
-- @bool[opt] forceRefresh If true, send a request regardless of cached results.
-- @treturn bool success: Did the query succeed?
-- @treturn Proxy result: A proxy to the decoded JSON data.
-- @treturn number code: The HTTP response status code. If no request was sent, this will be 304.
-- @treturn string status: The full HTTP response status. If no request was sent, this will be "No request sent".
-- @treturn table headers: The HTTP headers of the response. If no request was sent, this will be nil.
-- @treturn number time: The number of seconds between the function being called and the results being returned, calculated with os.time().
-- @treturn number clock: The number of seconds of CPU time used between the function being called and the results being returned, calculated with os.clock().
function wow:GetBattlePetSpeciesInfo(speciesID, locale, forceRefresh)
	local cachePath = speciesID
	return self:SendRequest(url_absolute("/api/wow/battlePet/species/", speciesID), nil, locale, "battlePetSpeciesInfo", cachePath, THIRTY_DAYS, forceRefresh)
end

--- Retrieve the stats of a Battle Pet Species.
-- See :SendRequest for return values. See :SendRequest and :SendRequestRaw for more information on the forceRefresh parameter.
-- @number speciesID The speciesID to retrieve stats for.
-- @number[opt] level The level of the pet.
-- @number[opt] breedID The breed of the pet.
-- @number[opt] qualityID The quality of the pet.
-- @bool[opt] forceRefresh If true, send a request regardless of cached results.
-- @treturn bool success: Did the query succeed?
-- @treturn Proxy result: A proxy to the decoded JSON data.
-- @treturn number code: The HTTP response status code. If no request was sent, this will be 304.
-- @treturn string status: The full HTTP response status. If no request was sent, this will be "No request sent".
-- @treturn table headers: The HTTP headers of the response. If no request was sent, this will be nil.
-- @treturn number time: The number of seconds between the function being called and the results being returned, calculated with os.time().
-- @treturn number clock: The number of seconds of CPU time used between the function being called and the results being returned, calculated with os.clock().
function wow:GetBattlePetSpeciesStats(speciesID, level, breedID, qualityID, forceRefresh)
	local levelStr = level and ("&level=%d"):format(level) or ""
	local breedStr = breedID and ("&breedId=%d"):format(size) or ""
	local qualityStr = qualityID and ("&qualityId=%d"):format(qualityID) or ""
	
	local query = levelStr .. breedStr .. qualityStr
	
	local cachePath = joinPath(speciesID, query)
	
	return self:SendRequest(url_absolute("/api/wow/battlePet/stats/", speciesID), query, nil, "battlePetSpeciesStats", cachePath, THIRTY_DAYS, forceRefresh)
end