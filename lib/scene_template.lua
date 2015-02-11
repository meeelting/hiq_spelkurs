local Scene = require("lib/scene")

local templateScene = {}
templateScene.new = function()
  local scene = {}
  
  local onBegin = function()
  
  end

  local onUpdate = function(deltaTime)
    
  end
  
  local onDraw = function()
    
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

return templateScene 
