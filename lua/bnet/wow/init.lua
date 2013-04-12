--- Blizzard Battle.net Community Platform API Library
-- Easily retrieve various types of data from Blizzard's API in the format of Lua tables.
-- @class: module
-- @name: bnet.wow
-- This module is used to create new copies of the main library.

--[[
This is just here so LuaDoc recognises this as a module.
module("bnet.wow")
]]


local unpack = unpack

local tablex = require("pl.tablex")
local url_absolute = require("socket.url").absolute

local toolsbase = require("bnet.tools")
local tools = toolsbase.module
local debugprint, wipe, createRef, decompress, splitPath, joinPath = unpack(toolsbase.publicFuncs)
local privateFuncs = assert(toolsbase["wow&&privateFuncs"], "Unable to load private functions.") -- We need to access the privateFuncs key using the wow&& prefix due to metamethod restrictions.
local Get, Set, GetCache, SetCache, InitCache, GetCacheTable, SetCacheTable = unpack(privateFuncs)

local GAME = "wow"

local modules = {
	"character",
	"guild",
	"realm",
	"auction",
	"item",
	"pvp",
	"data",
	"quest",
	"recipe",
}

local wow = tablex.deepcopy(tools)

local funcTable = {wow, url_absolute, debugprint, wipe, createRef, decompress, splitPath, joinPath, Get, Set, GetCache, SetCache}
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
-- <br /><br />
-- Optionally use an existing table and register your public/private application keys (given to you by Blizzard).
-- If you don't register your keys here, you can register them later with wow:RegisterKeys.
-- <br /><br />
-- Each copy of the library will have a full set of methods from each each sub-module as well as all methods from the tools module.
-- <br /><br />
-- You will be unable to set the value of keys used by library methods.
-- @param base A table to use as the base of the new copy. (table, optional)
-- @param publicKey Your public application key. (string, optional)
-- @param privateKey Your private application key. (string, optional)
-- @return wow: A new copy of the library. (table)
-- @usage local wowbase = require("bnet.wow")
-- <br />local wow = wowbase:New(nil, "xxxxxxxxxxxxxxxxx", "xxxxxxxxxxxxxxxxx") -- Create a new copy without an existing base table and register your keys.
-- <br /><br />local success, auctionData, code, status, headers = wow:GetAuctionData("Frostmourne") -- Retrieve auction data for the Frostmourne realm.
-- <br />assert(success, auctionData) -- If the request failed, auctionData will contain the reason for failure instead of the query result.
-- <br />for k, v in pairs(auctionData) do
-- <br />	print(k, v)
-- <br />end
-- @usage local wowbase = require("bnet.wow")
-- <br />local t = { stuff = "more stuff" }
-- <br />t = wowbase:New(t)
-- -- Create a new copy of the module using the existing table t as the base. This preserves any existing data in t.
-- <br /><br />assert(t.stuff == "more stuff")
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