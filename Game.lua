local class = require("libs/middleclass/middleclass")
local Game = class("Game")


function Game:initialize()
end

function Game:update(dt)
end

function Game:draw()
  love.graphics.setColor(255, 0, 255)
  love.graphics.rectangle("fill", 10, 10, 100, 100)
end

function Game:keypressed(key, unicode)
  print(unicode)
end

return Game
