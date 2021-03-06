local collision = require("lib/collision")

local Actor = {}

local angleToRadian = 0.0174532925

local params_example = {
  position = { x = 100, y = 100 },
  draw = function() end  
}

Actor.new = function(params)
  
  local actor = {
    position = params.position,
    gfx_settings = params.gfx,
    gfx = params.gfx.normal,
    shape = params.shape,
    drawShape = false,
    verticalSpeed = 15000,
    horizontalSpeed = 2000,
    controller = params.controller
  }
  actor.gfx = actor.gfx_settings.happy
  
  actor.shape.body:setPosition(actor.position.x, actor.position.y)
  
  actor.update = function(deltatime)            
    actor.controller(actor, deltatime)
  end
  
  actor.draw = function() 
    local x, y = actor.shape.body:getPosition()
    local lx, ly = actor.shape.body:getLocalCenter( )
    
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