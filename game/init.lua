-- SPDX-License-Identifier: MIT
-- Copyright (c) 2025 nilgoat <nil@goat.sex>

--- @module game
local game = {
   state = require("game.state"),
   assets = require("game.assets"),
}

local sprite = require("game.sprite")

local canvas
local scale = 1
local width, height = 960, 540
local ox, oy = 0, 0

function game.init(assets, state)
   canvas = love.graphics.newCanvas(960, 540)
   canvas:setFilter("linear", "nearest")

   state.bg = sprite.new(assets.sprite.bg_dungeon)
end

function game.update(dt, assets, state)
   state.bg:update(dt)
   state:update(dt)
end

function game.draw(assets, state)
   love.graphics.setCanvas(canvas)
   love.graphics.clear(0.2, 0.2, 0.2)

   state.bg:draw()
   state:draw()

   love.graphics.setCanvas()
   love.graphics.draw(canvas, math.floor(ox), math.floor(oy), 0, scale, scale)
end

function game.keypressed(key, assets, state)
   --[[
   if key == "left" then
      state.lucky = state.lucky - 1
      if state.lucky < 1 then
         state.lucky = assets.lucky.nframes
      end
   elseif key == "right" then
      state.lucky = state.lucky + 1
      if state.lucky > assets.lucky.nframes then
         state.lucky = 1
      end
   ]]
   if key == "space" then
      state:action_slap(assets, 840, 270)
   end
end

function game.keyreleased(key, assets, state) end

function game.resize(w, h)
   local sx = w / width
   local sy = h / height
   scale = math.max(1, math.min(sx, sy))
   ox = (w - width * scale) / 2
   oy = (h - height * scale) / 2
end

return game
