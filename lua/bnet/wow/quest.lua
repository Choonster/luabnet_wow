--- Implements the Quest section of the API
-- @alias wow

local wow, url_absolute, debugprint, wipe, createRef, decompress, splitPath, joinPath, assertString, assertNumber, Get, Set, GetCache, SetCache = ...

local THIRTY_DAYS = 30 * 24 * 60 * 60 -- Number of seconds in thirty days

--- Retrieve information about a quest.
-- @number questID The questID to query.
-- @string[opt] locale The locale to retrieve the data in.
-- @bool[opt] forceRefresh If true, send a request regardless of cached results.
-- @treturn bool success: Did the query succeed?
-- @treturn Proxy result: A proxy to the decoded JSON data.
-- @treturn number code: The HTTP response status code. If no request was sent, this will be 304.
-- @treturn string status: The full HTTP response status. If no request was sent, this will be "No request sent".
-- @treturn table headers: The HTTP headers of the response. If no request was sent, this will be nil.
-- @treturn number time: The number of seconds between the function being called and the results being returned, calculated with os.time().
-- @treturn number clock: The number of seconds of CPU time used between the function being called and the results being returned, calculated with os.clock().
function wow:GetQuestInfo(questID, locale, forceRefresh)
	local cachePath = questID
	return self:SendRequest(url.absolute("/api/wow/quest/", questID), nil, locale, "questInfo", cachePath, THIRTY_DAYS, forceRefresh)
end