-- SPDX-License-Identifier: MIT
-- Copyright (c) 2025 nilgoat <nil@goat.sex>

--- @module game
local game = {
   state = require("game.state"),
   assets = require("game.assets"),
}

function game.init(assets, state)
   state:anim_play("item", assets.items, 460, 100, true)
end

function game.update(dt, assets, state)
   state:anim_update(dt)
end

function game.draw(assets, state)
   love.graphics.drawLayer(assets.bg_dungeon.image, 1, 0, 0)
   love.graphics.drawLayer(assets.lucky.image, state.lucky, 0, 0)

   for _, anim in pairs(state.anim) do
      local sprite, x, y = anim.sprite, anim.x + anim.ox, anim.y + anim.oy
      love.graphics.drawLayer(sprite.image, math.floor(anim.frame), x, y)
   end
end

function game.keypressed(key, assets, state)
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
   elseif key == "space" then
      state:anim_play("slap", assets.handslap, 740, 180)
   end
end

function game.keyreleased(key, assets, state) end

return game
