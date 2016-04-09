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

Rocket.getShape = function(world) 
  local shape = {}
  shape.body = love.physics.newBody(world, 0, 0, "dynamic") 

  --non relative coordinates
  local triangle_width = 15
  local body_height = 56
  local body_butt_start = 40
  local body_butt_mid = 48
  local body_butt_end = 56
  local body_butt_width = 22
  local offsetX, offsetY = 30, 4

  shape.shapes = {}
  table.insert(shape.shapes, love.physics.newPolygonShape(
      offsetX, offsetY, 
      triangle_width + offsetX, triangle_width + offsetY, 
      triangle_width + offsetX, body_height + offsetY,
      -triangle_width + offsetX, body_height + offsetY,
      -triangle_width + offsetX, triangle_width + offsetY
    ))

  table.insert(shape.shapes, love.physics.newPolygonShape(
      triangle_width + offsetX, body_butt_start + offsetY, 
      body_butt_width + offsetX, body_butt_mid + offsetY, 
      body_butt_width + offsetX, body_butt_end + offsetY, 
      -body_butt_width + offsetX, body_butt_end + offsetY,
      -body_butt_width + offsetX, body_butt_mid + offsetY, 
      -triangle_width + offsetX, body_butt_start + offsetY
    ))

  shape.fixtures = {}
  for i = 1, #shape.shapes do
    table.insert(shape.fixtures, love.physics.newFixture(shape.body, shape.shapes[i]))
  end
  
--    block.draw = function()
--      love.graphics.setColor(0, 255, 255) -- set the drawing color to green for the ground
--      for i = 1, #block.shapes do
--        love.graphics.polygon("fill", block.body:getWorldPoints(block.shapes[i]:getPoints())) 
--      end

--      love.graphics.setColor(255, 255, 255)
--    end

--    block.update = function(deltaTime)

--    end

  return shape
end

return Rocket