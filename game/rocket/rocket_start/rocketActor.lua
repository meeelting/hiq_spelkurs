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
    
    
  }
  
  
  actor.update = function(deltatime)    
    
  end
  
  actor.draw = function() 
    actor.gfx.draw(actor.position.x, actor.position.y)
  end
  
  return actor
end

return Actor