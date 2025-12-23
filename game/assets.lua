-- SPDX-License-Identifier: MIT
-- Copyright (c) 2025 nilgoat <nil@goat.sex>

--- @module game.assets
local assets = {}

local function load_sprite(path, sprite_data)
   local files = {}
   for _, f in ipairs(sprite_data.frames) do
      table.insert(files, path .. f)
   end
   local image = love.graphics.newArrayImage(files)

   local durations = sprite_data.durations or {}
   local d_ty = type(durations)
   if d_ty == "number" then
      local t = {}
      for _ = 1, #files do
         table.insert(t, durations)
      end
      durations = t
   elseif d_ty == "table" then
      for i = 1, #files do
         if not durations[i] then
            durations[i] = 0
         end
      end
   end

   -- convert frame duration to rate for use mutiplying against delta time
   local rates = {}
   for _, v in ipairs(durations) do
      if v > 0 then
         table.insert(rates, 1 / v)
      end
   end

   return {
      image = image,
      nframes = #files,
      rates = rates,
   }
end

function assets.load()
   if not love.filesystem.getInfo("assets", "directory") then
      error("assets folder could not be found")
   end

   local t = {}

   -- TODO
   -- hardcoding paths, but could do something more dynamic / handle errors
   t.handslap = load_sprite("assets/handslap/", require("assets.handslap"))
   t.bg_dungeon = load_sprite("assets/bg_dungeon/", require("assets.bg_dungeon"))

   return t
end

return assets
