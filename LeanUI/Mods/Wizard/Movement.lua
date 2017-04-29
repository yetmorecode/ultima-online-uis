
Move = {}
Move.isMoving = false
Move.targetX = 0
Move.targetY = 0
Move.targetTolerance = 2
Move.targetDirection = ""
Move.callbackFn = function () end
Move.pathCallbackFn = function () end

Move.currentPath = nil
Move.currentPathItem = 1

Move.idleTimer = 0
Move.idleX = 0
Move.idleY = 0

local this = Move

function Move.Stop()
  if this.isMoving and this.targetDirection ~= nil then
    this.StopDirection(this.targetDirection)
    this.isMoving = false
  end
end

function Move.To(x, y, tolerance, callback, walking)
  this.targetX = x
  this.targetY = y
  
  if tolerance ~= nil then
    this.targetTolerance = tolerance
  end
  
  if walking ~= nil and walking ~= false then
    --this.SetRunning(false)
  else
    --this.SetRunning(true)
  end
  
  this.callbackFn = callback

  this.isMoving = true
  
  --Debug.PrintToChat(L""..dx..L":"..dy)
end

function Move.Path(path, callback)

  --for i,point in ipairs(path) do
  --  Debug.PrintToChat(L""..i..L": "..point.x..L"-"..point.y)
  --end
  
 this.currentPath = path
 this.currentPathItem = 1
 this.pathCallbackFn = callback
 
 local start = this.currentPath[this.currentPathItem]
 Move.To(start.x, start.y, 2, Move.AdvanceCurrentPath)
end

function Move.AdvanceCurrentPath()
  local max = table.getn(this.currentPath) - 1
  local i = this.currentPathItem
  
  if i > max then
    -- End reached
    if this.pathCallbackFn ~= nil then
      this.pathCallbackFn()
    end
  
    return
  end
  
  local tol = 2
  
  this.currentPathItem = this.currentPathItem + 1
  local start = this.currentPath[this.currentPathItem]
  --Debug.PrintToChat(""..i.."/"..max.." - "..start.x..":"..start.y)
  
  if start.tolerance ~= nil then
    tol = start.tolerance
  end
  
  local x = start.x
  local y = start.y
  
  -- Pseudo random target destination to make it look more human
  if start.random ~= nil then
    local rand = math.floor(math.random(start.random) - start.random/2)
    
    x = x + rand
    if rand > 0 then
      y = y + rand
    else
      y = y - rand
    end
  end
  
  local walking = false
  if tol == 0 then
    walking = true
  end
  
  Move.To(x, y, tol, Move.AdvanceCurrentPath, walking)
end

function Move.Update(timePassed)
  if not this.isMoving then
    return
  end
  
  
  
  local cx = WindowData.PlayerLocation.x
  local cy = WindowData.PlayerLocation.y
  
  if (cx == Move.idleX and cy == Move.idleY) then
    Move.idleTimer = Move.idleTimer + timePassed
  else
    Move.idleTimer = 0
    Move.idleX = cx
    Move.idleY = cy
  end
  
  local dx = cx - this.targetX
  local dy = cy - this.targetY
  
  local adx = math.abs(dx)
  local ady = math.abs(dy)
  
  --Debug.PrintToChat(L"delta: "..dx..L":"..dy)
  
  if adx <= this.targetTolerance and ady <= this.targetTolerance then
    --Debug.PrintToChat(L"end moving: "..adx..L":"..ady)
    this.isMoving = false
    this.StopDirection(this.targetDirection)
    
    if this.callbackFn ~= nil then
      this.callbackFn()
    end
    
  else 
    this.UpdateFar(dx, dy)
  end
end

function Move.UpdateFar(dx, dy)
  local first = ""
  if math.abs(dy) <= this.targetTolerance then
    first = ""
  else
    if dy > this.targetTolerance then
      first = "N"
    else
      first = "S"
    end
  end

  local second = ""
  if math.abs(dx) <= this.targetTolerance then
    second = ""
  else
    if dx > this.targetTolerance then
      second = "W"
    else
      second = "E"
    end
  end

  local direction = first .. second
  
  --Debug.PrintToChat(direction)
  
  if direction ~= this.targetDirection or Move.idleTimer > 1.0 then
    Move.idleTimer = 0
    this.StopDirection(this.targetDirection)
    
    if direction ~= "" then
      this.StartDirection(direction)
    end
  end
end

function Move.UpdateClose()

end

function Move.StartDirection(direction)
  local fn = "Move"..direction.."Down"
  _G[fn]()
  this.targetDirection = direction
end

function Move.StopDirection(direction)
  if direction == ""  then
    return
  end
  
  local fn = "Move"..direction.."Up"
  _G[fn]()
  this.targetDirection = ""
end

function Move.SetRunning(running) 
  if SystemData.Settings.GameOptions.alwaysRun ~= running then
      if running then
        Debug.PrintToChat(" change running")
      else
        Debug.PrintToChat(" change walking")
      end
      
      SystemData.Settings.GameOptions.alwaysRun = not SystemData.Settings.GameOptions.alwaysRun
      UserSettingsChanged()
    end
end