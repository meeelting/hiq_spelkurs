local Imagelib = require("lib/imagelib")

local Quad = {}

--params example = {
--  image = "gfx/image.png",
--  rows = 1, --along x
--  columns = 10, --along y
--  scale = {2, 2},
--}

Quad.new = function(params)
  local quad = {}
  quad.image = Imagelib.getImage(params.image)
  quad.width = quad.image:getWidth() / params.rows
  quad.height = quad.image:getHeight() / params.columns
  quad.scale = params.scale
  
  quad.getRenderable = function(column, row)
    local quadPart = love.graphics.newQuad(column * quad.width, row * quad.height, quad.width, quad.height, quad.image:getDimensions())    
    return { 
      id = column .. "_" .. row,
      quad = quad,
      quadPart = quadPart,
      draw = function(x, y)
        love.graphics.draw(quad.image, quadPart, x, y, 0, quad.scale[1], quad.scale[2])
      end,
      
      drawRotated = function(x, y, rotation) 
--        love.graphics.circle("fill", x, y, 30, 30)
        love.graphics.draw(quad.image, quadPart, x, y, rotation, quad.scale[1], quad.scale[2], (quad.image:getWidth() / params.rows) / 2, (quad.image:getHeight() / params.columns) / 2)
      end
    }
    
  end
  
  return quad  
end

return Quad