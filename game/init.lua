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
local sx, sy = 0, 0

function game.init(c)
   canvas = love.graphics.newCanvas(960, 540)
   canvas:setFilter("linear", "nearest")

   c.state.bg = sprite.new(c.assets.sprite.bg_dungeon)
end

function game.update(dt, c)
   c.state.bg:update(dt)
   c.state:update(dt)
end

function game.draw(c)
   love.graphics.setCanvas(canvas)
   love.graphics.clear(0.2, 0.2, 0.2)

   c.state.bg:draw()
   c.state:draw()

   love.graphics.setCanvas()
   love.graphics.draw(canvas, math.floor(ox), math.floor(oy), 0, scale, scale)
end

function game.keypressed(key, c)
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
   if key == "space" then
      state:action_slap(assets, 840, 270)
   end
   ]]
end

function game.keyreleased(key, c) end

local function screen_scale(x, y)
   return (x - ox) / scale, (y - oy) / scale
end

function game.mousemoved(x, y, dx, dy, istouch, c)
   sx, sy = screen_scale(x, y)
end

function game.mousepressed(x, y, button, c)
   local _x, _y = screen_scale(x, y)
   c.state:action_slap(c.assets, _x, _y)
end

function game.mousereleased(x, y, button, c) end

function game.resize(w, h, c)
   local sx = w / width
   local sy = h / height
   scale = math.max(1, math.min(sx, sy))
   ox = (w - width * scale) / 2
   oy = (h - height * scale) / 2
end

return game
