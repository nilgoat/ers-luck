-- SPDX-License-Identifier: MIT
-- Copyright (c) 2025 nilgoat <nil@goat.sex>

local game = require("game")

local assets
local state

function love.load()
   local textypes = love.graphics.getTextureTypes()
   if not textypes.array then
      error("array texture type is unsupported on this platform")
   end

   love.graphics.setBackgroundColor(0.2, 0.2, 0.2, 1)

   assets = game.assets.load()
   state = game.state.new()
end

function love.update(dt) game.update(dt, assets, state) end
function love.draw() game.draw(assets, state) end
