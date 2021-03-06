local Collision = require("lib/collision")
local Vector = require("lib/vector")

local Paddle = {}

Paddle.gfx = {
  image = "gfx/paddle.png",
}

Paddle.speed = 150

Paddle.collision = {}
Paddle.collision.ball = function(paddle, ball)
  --We intersect the two boxes to find out what way to bounce the ball,
  --and how much to adjust the balls position so that the rectangle doesn't keep intersecting the ball.
  local overlap = Collision.boxOverlap(ball.box, paddle.box)
  
  if overlap.x > overlap.y then -- bounce vertically
    ball.direction.y = -ball.direction.y
    
    if ball.position.y < paddle.position.y then
      ball.position.y = ball.position.y - overlap.y 
    else 
      ball.position.y = ball.position.y + overlap.y
    end
    
    local u, v = Vector.sub(ball.position.x, ball.position.y, paddle.position.x, paddle.position.y)
    ball.direction.x, ball.direction.y = Vector.normalize(u, v)
    
  elseif overlap.x < overlap.y then -- bounce horizontally
    ball.direction.x = -ball.direction.x
    
    if ball.position.x < paddle.position.x then
      ball.position.x = ball.position.x - overlap.x 
    else 
      ball.position.x = ball.position.x + overlap.x
    end    
    
  end  
end

Paddle.screenBoundaryCollision = function(paddle) 
    
  local change = { 
    position =  { x = 0, y = 0 },
    direction = { x = paddle.direction.x, y = paddle.direction.y },
  }
  
  --Collision vs right side
  if paddle.position.x + paddle.size.w2 > love.graphics.getWidth()  then
    change.direction.x = -paddle.direction.x
    local distanceFromCollision = love.graphics.getWidth() - (paddle.position.x + paddle.size.w2)      
    change.position.x = distanceFromCollision
    
  end
  
  --Collision vs left
  local left = 0
  if paddle.position.x - paddle.size.w2 < left then
    change.direction.x = -paddle.direction.x      
    local distanceFromCollision = (paddle.position.x - paddle.size.w2) - left
    change.position.x = -distanceFromCollision
    
  end
  
  return change
end

Paddle.Player = function()  
  return function(actor, deltaTime)        
    actor.direction.x = 0
    
    local left_key = love.keyboard.isDown("a")
    local right_key = love.keyboard.isDown("d")
    
    if left_key and right_key then
      actor.direction.x = 0
    elseif left_key then
      actor.direction.x = -1  
    elseif right_key then
      actor.direction.x = 1
    end        
    
    local change = Paddle.screenBoundaryCollision(actor)        
    actor.position.x = actor.position.x + change.position.x
    actor.position.y = actor.position.y + change.position.y
  end
end

return Paddle