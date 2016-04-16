local Scene = require("lib/scene")
local Quad = require("lib/quad")
local Rocket = require("game/rocket/rocket_fuel/rocket")
local RocketActor = require("game/rocket/rocket_fuel/rocketActor")

local rocketGame = {}
rocketGame.new = function()
  local scene = {}
  local rocketGame = {}
  local actors = {}
  local meterSize = 128
  local gravity = 9.81


  local addGround = function()
    local ground = {}
    ground.body = love.physics.newBody(rocketGame.world, 800/2, 600-32) 
    ground.shape = love.physics.newRectangleShape(800, 64) --make a rectangle with a width of 650 and a height of 50
    ground.fixture = love.physics.newFixture(ground.body, ground.shape); --attach shape to body

    ground.draw = function()
      love.graphics.setColor(72, 160, 14) -- set the drawing color to green for the ground
      love.graphics.polygon("fill", ground.body:getWorldPoints(ground.shape:getPoints())) -- draw a "filled in" polygon using the ground's coordinates

      love.graphics.setColor(255, 255, 255)
      local v1, v2 = ground.body:getWorldPoints(ground.shape:getPoints())
    end

    ground.update = function(deltaTime)

    end

    return ground
  end

  local addBlock = function(position, rotation)
    local block = {}
    block.body = love.physics.newBody(rocketGame.world, position.x, position.y, "dynamic") 
    block.shape = love.physics.newRectangleShape(0, 0, 64, 64, rotation) --make a rectangle with a width of 650 and a height of 50
    block.fixture = love.physics.newFixture(block.body, block.shape); --attach shape to body

    block.draw = function()
      love.graphics.setColor(255, 255, 255) -- set the drawing color to green for the ground
      love.graphics.polygon("fill", block.body:getWorldPoints(block.shape:getPoints())) -- draw a "filled in" polygon using the ground's coordinates

      love.graphics.setColor(255, 255, 255)
      local v1, v2 = block.body:getWorldPoints(block.shape:getPoints())
    end

    block.update = function(deltaTime)

    end

    return block
  end

  local onBegin = function()
    love.graphics.setBackgroundColor(94, 169, 255)

    love.physics.setMeter(meterSize) --the height of a meter our worlds will be 64px
    rocketGame.world = love.physics.newWorld(0, gravity * meterSize, true) --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81

    actors[#actors + 1] = addGround()
    actors[#actors + 1] = addBlock({x = 200, y = 300}, 45)
    actors[#actors + 1] = addBlock({x = 200, y = 400}, 60)
    actors[#actors + 1] = addBlock({x = 300, y = 200}, 75)
    actors[#actors + 1] = addBlock({x = 300, y = 300}, 45)
    

    actors[#actors + 1] = RocketActor.new({ 
        position = { x = 200, y = 100 }, 
        gfx = Rocket.gfx,
        shape = Rocket.getShape(rocketGame.world),
        controller = Rocket.controller(),
        renderer = Rocket.renderer(),
      })
  end

  local onUpdate = function(deltaTime)
    rocketGame.world:update(deltaTime)

    for key, actor in pairs(actors) do
      actor.update(deltaTime)
    end
  end

  local onDraw = function()
    for key, actor in pairs(actors) do
      actor.draw()
    end
  end

  local onMouseReleased = function(x, y, button)

  end

  local onMousePressed = function(x, y, button)

  end

  local onStop = function()

  end

  scene = Scene.new(onBegin, onUpdate, onDraw, onMouseReleased, onMousePressed, onStop)

  return scene
end

return rocketGame 
