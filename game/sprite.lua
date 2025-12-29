-- SPDX-License-Identifier: MIT
-- Copyright (c) 2025 nilgoat <nil@goat.sex>

--- @module game.state
local sprite = {}

-- class table
local Sprite = {}

--- process animations
-- @param dt number: time since last update in seconds
-- @return boolean: true if animation is still playing, false if finished
function Sprite:update(dt)
   if not self.state then
      return false
   end

   local state = self.data.states[self.state]

   self.timer = self.timer + dt
   if self.timer < state.delay then
      return true
   end

   self.timer = self.timer - state.delay

   if self.index < state.nframes then
      self.index = self.index + 1
      self.frame = state.frames[self.index]
      return true
   end

   if state.next then
      self.state = state.next
      self.index = 1
      self.frame = state.frames[self.index]
      return true
   end

   self.state = nil
   return false
end

--- draw this sprite using its associated texture
-- @int[opt=0] rot rotation to apply in radians
-- @int[opt=1] scale factor to scale the sprite by
function Sprite:draw(rot, scale)
   local x, y = self.x + self.ox, self.y + self.oy
   love.graphics.drawLayer(self.data.texture, self.frame, x, y, rot, scale, scale)
end

--- create a new sprite instance
-- @param sprite_data loaded sprite data (from assets)
-- @int[opt=0] x horizontal position
-- @int[opt=0] y vertical position
-- @return Sprite
function sprite.new(sprite_data, x, y)
   local self = {
      x = x or 0,
      y = y or 0,
      ox = sprite_data.ox,
      oy = sprite_data.oy,
      -- the frame (layer) of the texture to draw
      frame = 1,
      -- the current frame index for the current state
      index = 1,
      -- timer to track delays between frames
      timer = 0,
      state = sprite_data.default,
      data = sprite_data,
   }
   setmetatable(self, { __index = Sprite })
   return self
end

return sprite
