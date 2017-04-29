DarkGuardians = {}

local this = DarkGuardians

this.tickTimer = 0
this.tickInterval = 0.25

this.respawnTimer = 0
this.killTimer = 0
this.Spawned = false
this.Precast = false
this.PrecastHit = false
this.Postcast = false

this.AreaX = 365
this.AreaY = 15
this.IsInArea = false

function this.Initialize()
	OverheadText.AddTextArrivedHandler(this.NewText)
end

function this.Update(timePassed)
  
	if not this.InArea() then
		return
	end
	
	this.tickTimer = this.tickTimer + timePassed
	
	if this.Spawned then
		this.killTimer = this.killTimer + timePassed
	else
		this.respawnTimer = this.respawnTimer + timePassed
	end
	
	if this.tickTimer > this.tickInterval then
		this.tickTimer = 0
		
		if this.Spawned then
			if not this.PrecastHit and this.killTimer > 0.25 then
				this.Print("Hit 1")
				MouseLClick()
				this.PrecastHit = true
				this.Precast = false
			end
			
			if not this.Postcast and this.killTimer > 1.25 then
				DIKey2()
				this.Print("Hit 2")
				this.Postcast = true
				
				this.Spawned = false
				this.Precast = false
				this.PrecastHit = false
				this.Postcast = false
				this.respawnTimer = 0
			end
			
			-- Timeout after 5 seconds
			if this.killTimer > 5 then
				this.Print("Timeout")
				this.Spawned = false
				this.Precast = false
				this.PrecastHit = false
				this.Postcast = false
				this.respawnTimer = 0
			end
		else
			if not this.Precast and this.respawnTimer > 55 then
				this.Print("Precast")
				DIKey1()
				this.Precast = true
			end
		end
	end
end

function this.Shutdown()
	
end

function this.InArea()
	if math.abs(this.AreaX - WindowData.PlayerLocation.x) < 5 and math.abs(this.AreaY - WindowData.PlayerLocation.y) < 5 then
		if this.IsInArea == false then
			this.Print("Entering area")
			this.IsInArea = true
		end
	
		return true
	else
		if this.IsInArea == true then
			this.Print("Leaving area")
			this.IsInArea = false
		end
	
		return false
	end  
end

function this.NewText(text)
	if not this.Spawned then
		if wstring.find(text, L"A Dark Guardian") then
			Debug.PrintToChat(text)
			this.Spawned = true
			this.killTimer = 0
			this.PrecastHit = false
			this.Postcast = false
		end
	end
end

function this.Print(message)
	if type(message) == "string" then
		message = StringToWString(message)
	end
	
	Debug.PrintToChat(L"[Dark Guardians] " .. message)
end