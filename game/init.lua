-- SPDX-License-Identifier: MIT
-- Copyright (c) 2025 nilgoat <nil@goat.sex>

--- @module game
local game = {
   state = require("game.state"),
   assets = require("game.assets"),
   screen = require("game.screen"),
}

local sprite = require("game.sprite")

function game.init(c)
   c.state.bg = sprite.new(c.assets.sprite.bg_dungeon)
end

function game.update(dt, c)
   c.state.bg:update(dt)
   c.state:update(dt)
end

function game.draw(c)
   c.screen:prepare()

   c.state.bg:draw()
   c.state:draw()

   c.screen:present()
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

function game.mousemoved(x, y, dx, dy, istouch, c)
   -- sx, sy = c.screen:translate(x, y)
end

function game.mousepressed(x, y, button, c)
   local x, y = c.screen:translate(x, y)
   c.state:action_slap(c.assets, x, y)
end

function game.mousereleased(x, y, button, c) end

function game.resize(w, h, c)
   c.screen:resize(w, h)
end

return game
