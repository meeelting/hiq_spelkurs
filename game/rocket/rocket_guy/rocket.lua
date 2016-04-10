--local Collision = require("lib/collision")
--local Vector = require("lib/vector")
local Quad = require("lib/quad")


local Rocket = {}
Rocket.speed = 150

local image = "gfx/goose/turbulentGoose_down.png"
Rocket.quad = Quad.new({
  image = "gfx/rocket/rocket.png",
  rows = 6, --along x
  columns = 1, --along y
  scale = {4, 4},
})

Rocket.gfx = {
  normal = Rocket.quad.getRenderable(0, 0),
  yay = Rocket.quad.getRenderable(1, 0),
  happy = Rocket.quad.getRenderable(2, 0),
  scared = Rocket.quad.getRenderable(4, 0),
  thinking = Rocket.quad.getRenderable(3, 0)
}

Rocket.controller = function(params)
 
  return function(actor, deltaTime)  
    
  end
  
end

Rocket.getShape = function(world) 
  local shape = {}
  shape.body = love.physics.newBody(world, 0, 0, "dynamic") 

  --non relative coordinates
  local offsetX, offsetY = 0, 4

  shape.shapes = {}
  local width = 15
  local height = 22
  
  --rectangle
  table.insert(shape.shapes, love.physics.newPolygonShape(
    width, -height + 5,
    width, height + 5,
    -width, height + 5,
    -width, -height  + 5
  ))

  --hat, triangle
  table.insert(shape.shapes, love.physics.newPolygonShape(
      width, 0 - 14,
      0, -15 - 14,
      -width, 0 - 14))
  
  --fins, triangl-ey
  table.insert(shape.shapes, love.physics.newPolygonShape(
      width + 8, 0 + 18,
      0, -15 + 12,
      -width - 8, 0 + 18))
  
  --fins ending, bottom square piece
  table.insert(shape.shapes, love.physics.newPolygonShape(
      width + 8, 0 + 18,
      width + 8, height + 5,
       -width - 8, height + 5,
       -width - 8, 0 + 18
    ))

  shape.fixtures = {}
  for i = 1, #shape.shapes do
    table.insert(shape.fixtures, love.physics.newFixture(shape.body, shape.shapes[i]))
  end
  

  return shape
end

return Rocket