-- SPDX-License-Identifier: MIT
-- Copyright (c) 2025 nilgoat <nil@goat.sex>

local game = require("game")

-- overall game context, tracking initialized assets, state, etc
local context

function love.load()
   local textypes = love.graphics.getTextureTypes()
   if not textypes.array then
      error("array texture type is unsupported on this platform")
   end

   love.graphics.setBackgroundColor(0, 0, 0)

   context = {
      assets = game.assets.load(),
      state = game.state.new(),
      screen = game.screen.new(960, 540),
   }

   game.init(context)
end

function love.update(dt) game.update(dt, context) end
function love.draw() game.draw(context) end
function love.keypressed(key) game.keypressed(key, context) end
function love.keyreleased(key) game.keyreleased(key, context) end
function love.mousemoved(x, y, dx, dy, istouch) game.mousemoved(x, y, dx, dy, istouch, context) end
function love.mousepressed(x, y, button) game.mousepressed(x, y, button, context) end
function love.mousereleased(x, y, button) game.mousereleased(x, y, button, context) end
function love.resize(w, h) game.resize(w, h, context) end
