local this = {

  nextTry = 1,
  checkTimer = -1,
  callback = nil,

  targetX = 3676,
  targetY = 2252
}

TQRecallAction = this

function this.OnUpdate(manager, timePassed)
  if this.nextTry > 0 then
    this.nextTry = this.nextTry - timePassed
    
    if this.checkTimer > 0 then
      this.checkTimer = this.checkTimer - timePassed
      return
    else
      if this.InArea(this.targetX, this.targetY) then
        manager.AdvanceQuest()
      end 
    end
    
    return
  else
    DIKey1()
    this.checkTimer = 1
    this.nextTry = 6
  end
  
  
end

function this.InArea(x,y)
  local dist = 8
  
  if math.abs(WindowData.PlayerLocation.x - x) < dist and math.abs(WindowData.PlayerLocation.y - y) < dist then
    return true
  else
    return false
  end
end