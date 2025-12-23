-- SPDX-License-Identifier: MIT
-- Copyright (c) 2025 nilgoat <nil@goat.sex>

--- @module game.state
local state = {}

-- class table
local State = {}

function State:anim_play(name, sprite, x, y)
   self.anim[name] = {
      sprite = sprite,
      frame = 1,
      x = x,
      y = y,
   }
end

function State:anim_update(dt)
   for name, anim in pairs(self.anim) do
      local sprite = anim.sprite
      local rate = sprite.rates[math.floor(anim.frame)]
      anim.frame = anim.frame + dt * rate
      if anim.frame >= sprite.nframes + 1 then
         self.anim[name] = nil
      end
   end
end

function state.new()
   local self = {
      anim = {},
   }
   setmetatable(self, { __index = State })
   return self
end

return state
