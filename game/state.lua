-- SPDX-License-Identifier: MIT
-- Copyright (c) 2025 nilgoat <nil@goat.sex>

--- @module game.state
local state = {}

-- class table
local State = {}

local sprite = require("game.sprite")

function State:update(dt)
   for name, sprite in pairs(self.anim) do
      if not sprite:update(dt) then
         self.anim[name] = nil
      end
   end
end

function State:draw()
   for _, sprite in pairs(self.anim) do
      sprite:draw()
   end
end

function State:action_slap(assets, x, y)
   self.anim.slap = sprite.new(assets.sprite.handslap, x, y)
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
