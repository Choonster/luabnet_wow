--- Implements the Realm section of the API
-- @alias wow

local wow, url_absolute, debugprint, wipe, createRef, decompress, splitPath, joinPath, Get, Set, GetCache, SetCache = ...

--- Retrieve realm status data.
-- These results are never cached.
-- @string realms A comma separated list of realms to query. If nil or omitted, all realms will be queried.
-- @treturn bool success: Did the query succeed?
-- @treturn tab result: The decoded JSON data.
-- @treturn number code: The HTTP response status code. If no request was sent, this will be 304.
-- @treturn string status: The full HTTP response status. If no request was sent, this will be "No request sent".
-- @treturn table headers: The HTTP headers of the response. If no request was sent, this will be nil.
-- @treturn number time: The number of seconds between the function being called and the results being returned, calculated with os.time().
-- @treturn number clock: The number of seconds of CPU time used between the function being called and the results being returned, calculated with os.clock().
function wow:GetRealmStatus(realms)
	return self:SendRequest("/api/wow/realm/status", realms and ("&realms=%s"):format(realms), nil, "realmStatus", nil, nil, true)
		-- Realm status can change constantly, so we don't cache these results
end