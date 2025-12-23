-- SPDX-License-Identifier: MIT
-- Copyright (c) 2025 nilgoat <nil@goat.sex>

--- @module game.state
local state = {}

-- class table
local State = {}

function State:anim_play(name, sprite, x, y, jiggle)
   self.anim[name] = {
      sprite = sprite,
      frame = 1,
      x = x,
      y = y,
      jiggle = jiggle or false,
      angle = 0,
      ox = 0,
      oy = 0,
   }
end

local TAU = math.pi * 2

local function angle_update(angle, dt)
   angle = angle + dt
   if angle > TAU then
      angle = angle - angle
   end
   return angle
end

function State:anim_update(dt)
   for name, anim in pairs(self.anim) do
      local sprite = anim.sprite

      if anim.jiggle then
         anim.angle = angle_update(anim.angle, dt * 3)
         anim.oy = math.sin(anim.angle) * 20
      end

      local rate = sprite.rates[math.floor(anim.frame)]
      anim.frame = anim.frame + dt * rate
      if anim.frame >= sprite.nframes + 1 then
         if anim.sprite.loop then
            anim.frame = 1
         else
            self.anim[name] = nil
         end
      end
   end
end

function state.new()
   local self = {
      anim = {},
      lucky = 1,
   }
   setmetatable(self, { __index = State })
   return self
end

return state
