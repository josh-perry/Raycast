local class = require("libs/middleclass/middleclass")
local Game = class("Game")

local player = {}
local map = {
  {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,2,2,2,2,2,0,0,0,0,3,0,3,0,3,0,0,0,1},
  {1,0,0,0,0,0,2,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,2,0,0,0,2,0,0,0,0,3,0,0,0,3,0,0,0,1},
  {1,0,0,0,0,0,2,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,2,2,0,2,2,0,0,0,0,3,0,3,0,3,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1},
  {1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1},
  {1,4,4,4,4,4,4,4,4,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1},
  {1,4,0,4,0,0,0,0,4,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1},
  {1,4,0,0,0,0,5,0,4,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1},
  {1,4,0,4,0,0,0,0,4,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1},
  {1,4,0,4,4,4,4,4,4,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1},
  {1,4,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1},
  {1,4,4,4,4,4,4,4,4,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1},
  {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
}

local colors = {
  {255, 100, 255},
  {100, 255, 100},
  {255, 255, 100},
  {255, 100, 100},
  {100, 255, 255},
  {0, 0, 0}
}

local light_colors = {
  {255, 200, 255},
  {200, 255, 200},
  {255, 255, 200},
  {255, 200, 200},
  {200, 255, 255},
  {50, 50, 50}
}

local screen_width = love.graphics:getWidth()
local screen_height = love.graphics:getHeight()

function Game:initialize()
  player.x = 3
  player.y = 3
  player.dir_x = -1
  player.dir_y = 0
  player.plane_x = 0
  player.plane_y = 0.66
  player.move_speed = 5
  player.turn_speed = 3

  self.time = 0
  self.old_time = 0
end

function Game:update(dt)
  -- Forwards
  if love.keyboard.isDown("w") then
    local new_x = player.x + player.dir_x * (player.move_speed * dt)
    local new_y = player.y + player.dir_y * (player.move_speed * dt)

    if map[math.floor(new_x)][math.floor(player.y)] == 0 then
      player.x = new_x
    end

    if map[math.floor(player.x)][math.floor(new_y)] == 0 then
      player.y = new_y
    end
  end

  -- Left
  if love.keyboard.isDown("a") then
    self:turn_player(dt, player.turn_speed)
  end

  if love.keyboard.isDown("d") then
    self:turn_player(dt, -player.turn_speed)
  end
end

function Game:turn_player(dt, speed)
  local amount = speed * dt

  local old_dir_x = player.dir_x
  local old_dir_y = player.dir_y

  player.dir_x = old_dir_x * math.cos(amount) -
                 old_dir_y * math.sin(amount)
  player.dir_y = old_dir_x * math.sin(amount) +
                 old_dir_y * math.cos(amount)

   local old_plane_x = player.plane_x
   local old_plane_y = player.plane_y

   player.plane_x = old_plane_x * math.cos(amount) -
                    old_plane_y * math.sin(amount)
   player.plane_y = old_plane_x * math.sin(amount) +
                    old_plane_y * math.cos(amount)
end

function Game:draw_sky()
  love.graphics.setColor(100, 150, 255)
  love.graphics.rectangle("fill", 0, 0, screen_width, screen_height / 2)
end

function Game:draw_ground()
    love.graphics.setColor(50, 50, 50)
    love.graphics.rectangle("fill", 0, screen_height / 2, screen_width, screen_height / 2)
end

function Game:draw()
  local w = screen_width
  local h = screen_height

  self:draw_sky()
  self:draw_ground()

  for x = 1, w do
    local cam_x = 2 * x / w - 1
    local ray_x = player.x
    local ray_y = player.y
    local ray_dir_x = player.dir_x + player.plane_x * cam_x
    local ray_dir_y = player.dir_y + player.plane_y * cam_x

    -- Map cell the ray is currently in
    local map_x = math.floor(ray_x)
    local map_y = math.floor(ray_y)

    local side_dist_x = nil
    local side_dist_y = nil

    local delta_dist_x = math.sqrt(1 + (ray_dir_y * ray_dir_y) / (ray_dir_x * ray_dir_x))
    local delta_dist_y = math.sqrt(1 + (ray_dir_x * ray_dir_x) / (ray_dir_y * ray_dir_y))

    local perp_wall_dist = nil

    local step_x = nil
    local step_y = nil

    local hit = false
    local side = nil

    if ray_dir_x < 0 then
      step_x = -1
      side_dist_x = (ray_x - map_x) * delta_dist_x
    else
      step_x = 1
      side_dist_x = (map_x + 1 - ray_x) * delta_dist_x
    end

    if ray_dir_y < 0 then
      step_y = -1
      side_dist_y = (ray_y - map_y) * delta_dist_y
    else
      step_y = 1
      side_dist_y = (map_y + 1 - ray_y) * delta_dist_y
    end

    while not hit do
      if side_dist_x < side_dist_y then
        side_dist_x = side_dist_x + delta_dist_x
        map_x = map_x + step_x
        side = 0
      else
        side_dist_y = side_dist_y + delta_dist_y
        map_y = map_y + step_y
        side = 1
      end

      if map[map_x][map_y] > 0 then
        hit = true
      end
    end

    if side == 0 then
      perp_wall_dist = (map_x - ray_x + (1 - step_x) / 2) / ray_dir_x
    else
      perp_wall_dist = (map_y - ray_y + (1 - step_y) / 2) / ray_dir_y
    end

    local line_height = math.floor(h / perp_wall_dist)

    local draw_start = -line_height / 2 + h / 2
    local draw_end = line_height / 2 + h / 2

    if draw_start < 0 then
      draw_start = 0
    end

    if draw_end >= h then
      draw_end = h - 1
    end

    local c = colors[map[map_x][map_y] + 1]

    if side == 1 then
      c = light_colors[map[map_x][map_y] + 1]
    end

    love.graphics.setColor(c)
    love.graphics.line(x, draw_start, x, draw_end)
  end
end

function Game:keypressed(key, unicode)
end

return Game
