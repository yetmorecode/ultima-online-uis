local this = {}

ObjectScanner = this

this.enabled = false

this.timePassed = 0


this.lastX = 0
this.lastY = 0
this.checkLocationTimer = 0
this.checkLocationDelay = 2.5


function this.Initialize ()

end

function this.Enable()
  this.enabled = true
end

function this.Disable()
  this.enabled = false
end

function this.Update (timePassed)
  if not this.enabled then
    this.checkLocationTimer = this.checkLocationTimer + timePassed
    return
  end

	if this.checkLocationTimer > this.checkLocationDelay then
    this.checkLocationTimer = 0
		DICtrlShift()
	else
		this.checkLocationTimer = this.checkLocationTimer + timePassed
	end
end