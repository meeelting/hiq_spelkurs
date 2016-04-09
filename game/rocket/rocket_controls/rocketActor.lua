local collision = require("lib/collision")

local Actor = {}


local params_example = {
  position = { x = 100, y = 100 },
  draw = function() end  
}

Actor.new = function(params)
  
  local actor = {
    position = params.position,
    gfx = params.gfx,
    shape = params.shape,
    drawShape = true,
  }
  
  actor.shape.body:setPosition(actor.position.x, actor.position.y)
  
  actor.update = function(deltatime)    
    
  end
  
  actor.draw = function() 
    local x, y = actor.shape.body:getPosition()
    local lx, ly = actor.shape.body:getLocalCenter( )
    print(lx, ly)
    actor.position = { x = x , y = y }
    actor.gfx.drawRotated(actor.position.x, actor.position.y, actor.shape.body:getAngle())
    
    if actor.drawShape then
      love.graphics.setColor(0, 255, 255, 128) -- set the drawing color to green for the ground
      for i = 1, #actor.shape.shapes do
        love.graphics.polygon("fill", actor.shape.body:getWorldPoints(actor.shape.shapes[i]:getPoints())) 
      end

      love.graphics.setColor(255, 255, 255)
    end

  end
  
  return actor
end

return Actor