-- SPDX-License-Identifier: MIT
-- Copyright (c) 2025 nilgoat <nil@goat.sex>

--- @module game
local game = {
   state = require("game.state"),
   assets = require("game.assets"),
}

function game.update(dt, assets, state)
   state:anim_update(dt)

   if not state.anim.slap then
      state:anim_play("slap", assets.handslap, 0, 0)
   end
end

function game.draw(assets, state)
   love.graphics.drawLayer(assets.bg_dungeon.image, 1, 0, 0)

   for _, anim in pairs(state.anim) do
      local sprite, x, y = anim.sprite, anim.x, anim.y
      love.graphics.drawLayer(sprite.image, math.floor(anim.frame), x, y)
   end
end

return game
