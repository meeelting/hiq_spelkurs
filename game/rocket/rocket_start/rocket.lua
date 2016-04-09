--local Collision = require("lib/collision")
--local Vector = require("lib/vector")
local Quad = require("lib/quad")


local Rocket = {}
Rocket.speed = 150

local image = "gfx/goose/turbulentGoose_down.png"
Rocket.quad = Quad.new({
  image = "gfx/rocket/rocket.png",
  rows = 4, --along x
  columns = 1, --along y
  scale = {4, 4},
})

Rocket.gfx = {
  normal = Rocket.quad.getRenderable(0, 0),
  happy = Rocket.quad.getRenderable(1, 0),
  scared = Rocket.quad.getRenderable(2, 0),
  thinking = Rocket.quad.getRenderable(3, 0)
}

Rocket.controller = function(params)
 
  return function(actor, deltaTime)  
    
  end
  
end

Rocket.screenBoundaryCollision = function(Rocket) 
  
  --Collision vs bottom
  if Rocket.position.y + Rocket.size.h2 > Rocket.graphics.getHeight() then
    
    --Goose dies from this
    
  end
  
  return
end


return Rocket