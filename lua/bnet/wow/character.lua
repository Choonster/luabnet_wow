--- Implements the Character section of the API
-- @alias wow

local wow, url_absolute, debugprint, wipe, createRef, decompress, splitPath, joinPath, Get, Set, GetCache, SetCache = ...

local HALF_HOUR = 0.5 * 60 * 60 -- Number of seconds in half an hour

-- tools:SendRequest(path, fields, locale, reqType, cachePath, expires, forceRefresh)

--- Retrieve a character profile table, optionally with the specified fields and locale.
-- @string realm The realm of the character.
-- @string character The name of the character.
-- @string[opt] fields A list of comma-separated fields to query.
-- @string[opt] locale The locale to retrieve the data in.
-- @bool[opt] forceRefresh If true, send a request regardless of cached results.
-- @treturn bool success: Did the query succeed?
-- @treturn tab result: The decoded JSON data.
-- @treturn number code: The HTTP response status code. If no request was sent, this will be 304.
-- @treturn string status: The full HTTP response status. If no request was sent, this will be "No request sent".
-- @treturn table headers: The HTTP headers of the response. If no request was sent, this will be nil.
-- @treturn number time: The number of seconds between the function being called and the results being returned, calculated with os.time().
-- @treturn number clock: The number of seconds of CPU time used between the function being called and the results being returned, calculated with os.clock().
function wow:GetCharacterProfile(realm, character, fields, locale, forceRefresh)
	realm, character = realm:lower(), character:lower()
	local cachePath = joinPath(realm, character, fields)
	return self:SendRequest(url_absolute("/api/wow/character/", ("%s/%s"):format(realm, character)), fields, locale, "charProfile", cachePath, HALF_HOUR, forceRefresh)
end