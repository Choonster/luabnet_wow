--- Creates new copies of the library.
-- This documentation only covers the arguments and return types of the library's methods. See the [API documentation](http://blizzard.github.io/api-wow-docs/) for full explanation of the returned data and query fields.
--
-- All methods that send a request to the API decode the JSON into the equivalent Lua table structures and then return a read-only proxy to the decoded data.
-- This proxy is a regular table with its __index, __pairs and __ipairs metamethods pointing to the original data.
-- Access to nested tables also returns a proxy rather than the raw table.
-- @module Main
-- @alias wowbase

local unpack = unpack

local deepcopy = require("pl.tablex").deepcopy
local url_absolute = require("socket.url").absolute

local toolsbase = require("bnet.tools")
local tools = toolsbase.module
local debugprint, wipe, createProxy, decompress, splitPath, joinPath, assertString, assertNumber = unpack(toolsbase.publicFuncs)
local privateFuncs = assert(toolsbase["wow&&privateFuncs"], "Unable to load private functions.") -- We need to access the privateFuncs key using the wow&& prefix due to metamethod restrictions.
local Get, Set, GetCache, SetCache, InitCache, GetCacheTable, SetCacheTable, ResetCacheTable = unpack(privateFuncs)

local GAME = "wow"

local modules = {
	"achievement",
	"auction",
	"battlepet",
	"challengemode",
	"character",
	"data",
	"guild",
	"item",
	"pvp",
	"quest",
	"realm",
	"recipe",
	"spell",
}

local wow = deepcopy(tools)

local funcTable = {wow, url_absolute, debugprint, wipe, createProxy, decompress, splitPath, joinPath, assertString, assertNumber, Get, Set, GetCache, SetCache}
for _, name in ipairs(modules) do
	local path = assert(package.searchpath("bnet.wow.".. name, package.path)) -- Find the path to each module file. This is standard in 5.2 and implemented by Penlight utils in 5.1
	local func = assert(loadfile(path, "t")) -- Lua 5.1 will ignore the second argument, Lua 5.2 uses it as the mode ("t" is text only, no binary chunks).
	func(unpack(funcTable))  -- Pass the wow table and basic functions to the file
end

local meta = {
	__index = wow,
	__newindex = function(t, key, value)
		if wow[key] then
			error(("Attempt to set the value of a reserved key: %q."):format(tostring(key)))
		else
			rawset(t, key, value)
		end
	end,
	__metatable = false
}

local wowbase = {}

--- Create a new copy of the library.
--
-- Optionally use an existing table and register your public/private application keys (given to you by Blizzard).
-- If the existing table has a metatable, it will be replaced.
-- If you don't register your keys here, you can register them later with wow:RegisterKeys.
-- 
-- Each copy of the library will have a full set of methods from each each sub-module as well as all methods from the [tools](http://choonster.github.com/luabnet_tools) module.
--
-- You will be unable to set the value of keys used by library methods.
--
-- @tparam[opt] table base A table to use as the base of the new copy. 
-- @string[opt] publicKey Your public application key.
-- @string[opt] privateKey Your private application key.
-- @treturn table wow: A new copy of the library.
-- @usage local wowbase = require("bnet.wow")
-- local wow = wowbase:New(nil, "xxxxxxxxxxxxxxxxx", "xxxxxxxxxxxxxxxxx") -- Create a new copy without an existing base table and register your keys.
-- local success, auctionData, code, status, headers = wow:GetAuctionData("Frostmourne") -- Retrieve auction data for the Frostmourne realm.
-- assert(success, auctionData) -- If the request failed, auctionData will contain the reason for failure instead of the query result.
-- for k, v in pairs(auctionData) do
-- 	print(k, v)
-- end
-- @usage local wowbase = require("bnet.wow")
-- local t = { stuff = "more stuff" }
-- t = wowbase:New(t)
-- -- Create a new copy of the module using the existing table t as the base. This preserves any existing data in t.
-- assert(t.stuff == "more stuff")
function wowbase:New(base, publicKey, privateKey)
	base = base or {}
	base = setmetatable(base, meta)
	Set(base, {})
	Set(base, "GAME", GAME)
	base:SetLocale("us", "en_US")
	base:RegisterKeys(publicKey, privateKey)
	base:EnableDebug(true)
	return base
end

return wowbase