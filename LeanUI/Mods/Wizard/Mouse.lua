local this = {}

Mouse = this

this.SCREEN_POINTS = 65532

function this.Center(xOffset, yOffset)
  local x = SystemData.screenResolution.x / 2 + xOffset
  local y = SystemData.screenResolution.y / 2 + yOffset
  this.MoveTo(x, y)
end

function this.MoveTo(x, y) 
  MoveMouseAbs(x / SystemData.screenResolution.x * 65532, y / SystemData.screenResolution.y * 65532)
end

function this.LClick(x, y)
  this.MoveTo(x,y)
  MouseLClick()
end