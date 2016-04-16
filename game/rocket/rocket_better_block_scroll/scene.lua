local Scene = require("lib/scene")
local Quad = require("lib/quad")
local Block = require("game/rocket/rocket_better_block_scroll/block")
local Ground = require("game/rocket/rocket_better_block_scroll/ground")
local Rocket = require("game/rocket/rocket_better_block_scroll/rocket")
local RocketActor = require("game/rocket/rocket_better_block_scroll/rocketActor")

local rocketGame = {}
rocketGame.new = function()
  local scene = {}
  local rocketGame = {}
  local actors = {}
  local meterSize = 128
  local gravity = 9.81
  local rocket = nil

--  local addGround = function()
--    local ground = {}
--    ground.body = love.physics.newBody(rocketGame.world, 800/2, 600-32) 
--    ground.shape = love.physics.newRectangleShape(800, 64) --make a rectangle with a width of 650 and a height of 50
--    ground.fixture = love.physics.newFixture(ground.body, ground.shape); --attach shape to body

--    ground.draw = function()
--      love.graphics.setColor(72, 160, 14) -- set the drawing color to green for the ground
--      love.graphics.polygon("fill", ground.body:getWorldPoints(ground.shape:getPoints())) -- draw a "filled in" polygon using the ground's coordinates

--      love.graphics.setColor(255, 255, 255)
--      local v1, v2 = ground.body:getWorldPoints(ground.shape:getPoints())
--    end

--    ground.update = function(deltaTime)

--    end

--    return ground
--  end

  local onBegin = function()
    love.graphics.setBackgroundColor(94, 169, 255)

    love.physics.setMeter(meterSize) --the height of a meter our worlds will be 64px
    rocketGame.world = love.physics.newWorld(0, gravity * meterSize, true) --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81

    actors[#actors + 1] = RocketActor.new({ 
      position = { x = 400, y = 1200 },
      gfx = Ground.gfx,
      shape = Ground.getShape(rocketGame.world),
      controller = Ground.controller(),
      renderer = Ground.renderer(),
    })

    for i = 1, 500 do
      actors[#actors + 1] = RocketActor.new({ 
        position = { x = math.random() * 800, y = math.random() * 600 },
        gfx = Block.gfx,
        shape = Block.getShape(rocketGame.world),
        controller = Block.controller(),
        renderer = Block.renderer(),
      })
    end

    rocket = RocketActor.new({ 
      position = { x = 200, y = 100 }, 
      gfx = Rocket.gfx,
      shape = Rocket.getShape(rocketGame.world),
      controller = Rocket.controller(),
      renderer = Rocket.renderer(),
    })
    actors[#actors + 1] = rocket
  end

  local onUpdate = function(deltaTime)
    rocketGame.world:update(deltaTime)

    for key, actor in pairs(actors) do
      actor.update(deltaTime)
    end
  end

  local onDraw = function()
    for key, actor in pairs(actors) do
      actor.draw(0, rocket.position.y - 300)
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
