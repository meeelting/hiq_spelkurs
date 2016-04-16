local Scene = require("lib/scene")
local Quad = require("lib/quad")
local Block = require("game/rocket/rocket_gamey/block")
local BlockBig = require("game/rocket/rocket_gamey/blockBig")
local Ground = require("game/rocket/rocket_gamey/ground")
local Rocket = require("game/rocket/rocket_gamey/rocket")
local RocketActor = require("game/rocket/rocket_gamey/rocketActor")

local rocketGame = {}
rocketGame.new = function()
  local scene = {}
  local rocketGame = {}
  local actors = {}
  local meterSize = 256
  local gravity = 9.81
  local rocket = nil
  
  local spawnSkyThing = function(x, y)
    actors[#actors + 1] = RocketActor.new({ 
      position = { x = x, y = y },
      gfx = BlockBig.gfx,
      shape = BlockBig.getShape(rocketGame.world),
      controller = BlockBig.controller(),
      renderer = BlockBig.renderer(),
    })
  
    local blocks = 2 + math.random(5)
    for i = 1, blocks do
      actors[#actors + 1] = RocketActor.new({ 
        position = { x = x + (-100 + math.random(200)), y = y + (-300 + math.random(200)) },
        gfx = Block.gfx,
        shape = Block.getShape(rocketGame.world),
        controller = Block.controller(),
        renderer = Block.renderer(),
      })
    end

  end

  local onBegin = function()
    love.graphics.setBackgroundColor(94, 169, 255)

    love.physics.setMeter(meterSize) --the height of a meter our worlds will be 64px
    rocketGame.world = love.physics.newWorld(0, gravity * meterSize, true) --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81

    actors[#actors + 1] = RocketActor.new({ 
      position = { x = 400, y = 600 },
      gfx = Ground.gfx,
      shape = Ground.getShape(rocketGame.world),
      controller = Ground.controller(),
      renderer = Ground.renderer(),
    })

    local y, yClimb = 0, -450
    for i = 1, 50 do
      spawnSkyThing(math.random() * 800, (yClimb * i) + 200)
    end

--      actors[#actors + 1] = RocketActor.new({ 
--        position = { x = math.random() * 800, y = math.random() * 600 },
--        gfx = Block.gfx,
--        shape = Block.getShape(rocketGame.world),
--        controller = Block.controller(),
--        renderer = Block.renderer(),
--      })

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
