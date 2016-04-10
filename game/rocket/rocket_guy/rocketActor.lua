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
    drawShape = true,
    verticalSpeed = 15000,
    horizontalSpeed = 2000,
  }
  printvar(params)
  actor.gfx = actor.gfx_settings.happy
  
  actor.shape.body:setPosition(actor.position.x, actor.position.y)
  
  actor.update = function(deltatime)        
    if love.keyboard.isDown("up") then      
      actor.shape.body:applyForce(0, -actor.verticalSpeed * deltatime)
    end
    
    if love.keyboard.isDown("left") then
      actor.shape.body:applyForce(-actor.horizontalSpeed * deltatime, 0)
    end
    
    if love.keyboard.isDown("right") then
      actor.shape.body:applyForce(actor.horizontalSpeed * deltatime, 0)
    end
    
    local vx, vy = actor.shape.body:getLinearVelocity()
    if (vy < -200) then
      actor.gfx = actor.gfx_settings.happy
    elseif (vy < -150) then
      actor.gfx = actor.gfx_settings.yay
    elseif (vy < -100) then
      actor.gfx = actor.gfx_settings.normal
    end

  end
  
  actor.draw = function() 
    local x, y = actor.shape.body:getPosition()
    local lx, ly = actor.shape.body:getLocalCenter( )
    
    actor.position = { x = x , y = y }
    printvar(actor.gfx)
    printvar(actor.gfx_settings)
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