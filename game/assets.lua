-- SPDX-License-Identifier: MIT
-- Copyright (c) 2025 nilgoat <nil@goat.sex>

--- @module game.assets
local assets = {}

local function process_states(states)
   local s = {}

   if not states then
      return s
   end

   for name, data in pairs(states) do
      local frames = {}
      local delay = data.delay or 0
      for _, frame in ipairs(data.frames) do
         table.insert(frames, frame)
      end
      s[name] = {
         frames = frames,
         nframes = #frames,
         delay = delay,
         next = data.next,
      }
   end

   -- TODO
   -- could do some validation, making sure next states are valid, frames are
   -- within range, delays are positive, etc

   return s
end

local function load_sprite(path, sprite_data)
   local files = {}
   for _, f in ipairs(sprite_data.files) do
      table.insert(files, path .. f)
   end

   -- TODO
   -- everything is a 2d array texture, even for single frame sprites. it might
   -- be more reasonable to use different texture types, and the tradeoffs
   -- should be investigated.
   local texture = love.graphics.newArrayImage(files)
   local states = process_states(sprite_data.states)

   return {
      texture = texture,
      states = states,
   }
end

function assets.load()
   if not love.filesystem.getInfo("assets", "directory") then
      error("assets folder could not be found")
   end

   local loaded = {
      -- loaded sprite data
      sprite = {},
   }

   local function _load(module_path)
      local p = string.gsub(module_path, "%.", "/") .. "/"
      local m = require(module_path)
      loaded.sprite_data = load_sprite(p, m)
   end

   -- TODO
   -- hardcoding paths, but could do something more dynamic / handle errors
   _load("assets.handslap")
   _load("assets.items")
   _load("assets.lucky")
   _load("assets.bg_dungeon")

   return loaded
end

return assets
