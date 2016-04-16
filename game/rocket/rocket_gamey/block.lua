local Quad = require("lib/quad")

local Block = {}

Block.quad = Quad.new({
  image = "gfx/rocket/box.png",
  rows = 3, --along x
  columns = 1, --along y
  scale = {4, 4},
})

Block.gfx = {
  normal = Block.quad.getRenderable(0, 0),
  red = Block.quad.getRenderable(1, 0),
  yellow = Block.quad.getRenderable(2, 0), 
}

Block.controller = function(params)
  local unset = true
  return function(actor, deltaTime)  
    if unset then
      unset = false
      
      local t = math.random(os.time()) % 3
      
      if t == 0 then
        actor.gfx = Block.gfx.red  
      end
      
      if t == 1 then
        actor.gfx = Block.gfx.normal
      end
      
      if t == 2 then
        actor.gfx = Block.gfx.yellow
      end

    end
  end
end

Block.renderer = function()
  return function(actor)        
  
  end
end

Block.getShape = function(world)
  local shape = {}
  shape.body = love.physics.newBody(world, 0, 0, "dynamic") 

  --non relative coordinates
  local offsetX, offsetY = 0, 0

  shape.shapes = {}
  local width = 32
  local height = 32
  
  --rectangle
  table.insert(shape.shapes, love.physics.newPolygonShape(
    width, -height,
    width, height,
    -width, height,
    -width, -height
  ))

  shape.fixtures = {}
  for i = 1, #shape.shapes do
    table.insert(shape.fixtures, love.physics.newFixture(shape.body, shape.shapes[i]))
  end
  
  return shape
end

return Block