local Game = require("Game")


function love.load()
  Game = Game:new()
end

function love.draw()
  Game:draw()
end

function love.update(dt)
  Game:update(dt)
end

function love.keypressed(key, unicode)
  Game:keypressed(key, unicode)
end
