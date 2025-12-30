-- SPDX-License-Identifier: MIT
-- Copyright (c) 2025 nilgoat <nil@goat.sex>

--- @module game.screen
local screen = {}

-- class table
local Screen = {}

function Screen:prepare()
   love.graphics.setCanvas(self.canvas)
   love.graphics.clear(0.2, 0.2, 0.2)
end

function Screen:present()
   love.graphics.setCanvas()
   love.graphics.draw(self.canvas, math.floor(self.ox), math.floor(self.oy),
      0, self.scale, self.scale)
end

function Screen:resize(w, h)
   local sx = w / self.width
   local sy = h / self.height
   self.scale = math.max(1, math.min(sx, sy))
   self.ox = (w - self.width * self.scale) / 2
   self.oy = (h - self.height * self.scale) / 2
end

--- translates window coordinates to screen space
function Screen:translate(x, y)
   return (x - self.ox) / self.scale, (y - self.oy) / self.scale
end

function screen.new(w, h)
   local canvas = love.graphics.newCanvas(w, h)
   canvas:setFilter("linear", "nearest")
   local self = {
      canvas = canvas,
      width = w,
      height = h,
      scale = 1,
      ox = 0,
      oy = 0,
   }
   setmetatable(self, { __index = Screen })
   return self
end

return screen
