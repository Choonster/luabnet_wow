--- Blizzard Battle.net Community Platform API Library
-- Easily retrieve various types of data from Blizzard's API in the format of Lua tables.
-- @class: module
-- @name: bnet.wow.recipe
-- Implements the Recipe Reources section of the API.

--[[
This is just here so LuaDoc recognises this as a module.
module("bnet.wow.recipe")
]]

local wow, url_absolute, debugprint, wipe, createRef, decompress, splitPath, joinPath, Get, Set, GetCache, SetCache = ...

local THIRTY_DAYS = 30 * 24 * 60 * 60 -- Number of seconds in thirty days

--- Retrieve recipe information.
-- <br/> See :SendRequest for return values. See :SendRequest and :SendRequestRaw for more information on the locale and forceRefresh parameters.
-- @param recipeID (number or string) The recipeID to query
-- @param locale (string, optional) The locale to retrieve the data in.
-- @param forceRefresh (boolean, optional) If true, send a request regardless of cached results.
function wow:GetRecipeInfo(recipeID, locale, forceRefresh)
	local cachePath = recipeID
	return self:SendRequest(url_absolute("/api/wow/recipe/", recipeID), nil, locale, "recipeInfo", cachePath, HALF_HOUR, forceRefresh)
end