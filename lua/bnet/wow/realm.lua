--- Blizzard Battle.net Community Platform API Library
-- Easily retrieve various types of data from Blizzard's API in the format of Lua tables.
-- @class: module
-- @name: bnet.wow.realm
-- Implements the Realm Resources section of the API.

--[[
This is just here so LuaDoc recognises this as a module.
module("bnet.wow.realm")
]]

local wow, url_absolute, debugprint, wipe, createRef, decompress, splitPath, joinPath, Get, Set, GetCache, SetCache = ...

--- Retrieve realm status data.
-- <br/> See :SendRequest for return values.
-- @param realms (string, optional) A comma separated list of realms to query. If nil or omitted, all realms will be queried.
function wow:GetRealmStatus(realms)
	return self:SendRequest("/api/wow/realm/status", realms and ("&realms=%s"):format(realms), nil, "realmStatus", nil, nil, true)
		-- Realm status can change constantly, so we don't cache these results
end