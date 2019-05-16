local this = {}

LootManager = this

this.timePassed = 0
this.queue = {}
this.queueSize = 0

this.lootDelay = 1.1
this.time = 0

this.delayedContainer = {}
this.delayedContainerSize = 0
this.checkContainerDelay = 10
this.checkContainerTimer = 0

this.isLooting = false
this.hasLootedCurrentLocation = false
this.lastX = 0
this.lastY = 0
this.checkLocationTimer = 0
this.checkLocationDelay = 1.25

this.Rules = {}

function this.Initialize ()
	CreateWindow("LootWindow", false)
end

function this.Update (timePassed)
	local this = LootManager
	if this.checkLocationTimer > this.checkLocationDelay then
		this.CheckLocation()
		this.checkLocationTimer = 0

    --m(16000, 16000)
		--DICtrlShift()
	else
		this.checkLocationTimer = this.checkLocationTimer + timePassed
	end
	
	if this.queueSize > 0 and this.timePassed > this.lootDelay then
		this.timePassed = 0
		
		--local item = this.queue[this.queueSize]
		
		--this.Loot(item.id)
		
		--this.queueSize = this.queueSize - 1
	else
		this.timePassed = this.timePassed + timePassed
	end
	
	if this.checkContainerTimer > this.checkContainerDelay then
		this.checkContainerTimer = 0
		--this.checkContainer()
	else
		this.checkContainerTimer = this.checkContainerTimer + timePassed
	end 
	
	this.time = this.time + timePassed
end

function this.CheckLocation()
	local this = LootManager

	local playerX = WindowData.PlayerLocation.x
	local playerY = WindowData.PlayerLocation.y
	local changedLocation = this.lastX ~= playerX or this.lastY ~= playerY
	
	if changedLocation then
		this.hasLootedCurrentLocation = false
		this.lastX = playerX
		this.lastY = playerY
	end	
	
	if this.hasLootedCurrentLocation then
		--return false
	end
	
	--Debug.PrintToChat(L"[LM] Checking Loot at " .. playerX .. L":" .. playerY)
	for key,data in pairs(this.queue) do
		if GetDistanceFromPlayer(data.container) < 3 then
			Debug.PrintToChat(L"[LM] Found near me: " .. data.id)
			this.Loot(data.id)
			return false
		end
	end
	
	this.hasLootedCurrentLocation = true
	return false
end

function this.checkContainer()
	
	--Inspection.dumpToChat("ct", WindowData.ContainerWindow)
	for key,container in pairs(WindowData.ContainerWindow) do 
		Debug.PrintToChat(L"check container " .. key)
		--Inspection.dumpToChat("ct", WindowData.ContainerWindow)
		--if WindowData.ContainerWindow[container.id] ~= nil and WindowData.ContainerWindow[container.id].numItems > 0 then
			--Debug.PrintToChat(L"container contents for " .. container.id)
			
			--this.delayedContainer[i] = nil
		--end
	end
	
	-- rebuild
end

function this.CheckLoot(item) 
	if wstring.find(item.name, L"Treasure Map") then
		return true
	end
	
	if wstring.find(item.name, L"Crushed Crystal Pieces") then
    return true
  end
	
	-- Gold
	if item.objectType == 3821 then
		return true
	end
	
	return false
end

function this.AddContainer(id)
	local data = WindowData.ContainerWindow[id]
	local numItems = data.numItems
	local foundLoot = false
	for i=1, numItems do
	    local objectId = data.ContainedItems[i].objectId
	    
	    RegisterWindowData(WindowData.ObjectInfo.Type, objectId)
		local item = WindowData.ObjectInfo[objectId]
		if wstring.len(item.name) > 0 then
			--Debug.PrintToChat(L"  item " .. id .. L" (" .. item.name .. L" x" ..item.quantity .. L")")
		else
			--Debug.PrintToChat(L"  item " .. id .. L" (" .. item.objectType .. L" x" ..item.quantity .. L")")
		end
		
		if this.CheckLoot(item) then
			this.AddItem(id, objectId, item)
			foundLoot = true
		end
		
		UnregisterWindowData(WindowData.ObjectInfo.Type, objectId)
    end
    
    if foundLoot then
    	if DoesWindowExist("LootWindow") then
			LootWindow.Update()
		end
	end
end

function this.AddItem(containerId, itemId, itemInfo)
	local idx = this.queueSize + 1
	this.queue[itemId] = {
		id = itemId,
		container = containerId,
		itemInfo = itemInfo
	}
	--this.queueSize = this.queueSize + 1
	--Debug.PrintToChat(L"[LM] Added item " .. itemId)
end

function this.Loot(id)
	local queueSize = 0
	for key,value in pairs(this.queue) do
		queueSize = queueSize + 1
	end

	Debug.PrintToChat(L"[LM] Looting item " .. id)
	this.queue[id] = nil
	DragSlotAutoPickupObject(id)
	if DoesWindowExist("LootWindow") then
		LootWindow.Update()
	end
end

function this.NewRule()
  local rule = { 
    Name = L"", 
    ItemHue = "0", 
    BorderHue = "1266", 
    BorderHueAlpha = ".8", 
    BackgroundHue = "1266", 
    BackgroundHueAlpha = ".2", 
    Conditions = {}
  }
  
  this.Rules.insert(this.Rules, rule)
  
  return rule
end

function this.SaveRules()
  local s = "<Rules>"

  for i = 1, #this.Rules do
    local rule = this.Rules[i]
    s = s .. "<Rule>"
    s = s .. "Name=" .. (rule.Name or "N/A") .. ","
    s = s .. "ItemHue=" .. (rule.ItemHue or "0") .. ","
    s = s .. "BorderHue=" .. (rule.BorderHue or "0") .. ","
    s = s .. "BorderHueAlpha=" .. (rule.BorderHueAlpha or ".5") .. ","
    s = s .. "BackgroundHue=" .. (rule.BackgroundHue or "0") .. ","
    s = s .. "BackgroundHueAlpha=" .. (rule.BackgroundHueAlpha or ".5") .. ","


    s = s .. "<Conditions>"
    for j = 1, #rule.Conditions do
      local condition = rule.Conditions[j]
      s = s .. "<Condition>"
      s = s .. "Property=" .. condition.Property .. ","
      s = s .. "Operator=" .. condition.Operator .. ","
      s = s .. "Value=" .. condition.Value
      s = s .. "</Condition>"
    end 
    s = s .. "</Conditions></Rule>"
  end
  s = s .. "</Rules>"

  Interface.SaveString( "LootConfigurationRules", s )

end

function this.LoadRules()
  local s = Interface.LoadString("LootConfigurationRules", nil)

  if not s then
    return
  end
  
  local t = {}
  for rule in string.gmatch(s, "<Rule>.-</Rule>") do 
    local r = { Conditions = {}}
    local ruleTemp = string.match(rule, "<Rule>(.-)<Conditions>")

    for prop in string.gmatch(ruleTemp, "([^,]+)") do
      local k, v = string.match(tostring(prop), "(.+)=(.+)")
      r[k] = v
    end
  
    for condition in string.gmatch(rule, "<Condition>(.-)</Condition>") do 
      local c = {}
      for prop in string.gmatch(condition, "([^,]+)") do
        local k, v = string.match(tostring(prop), "(.+)=(.+)")
        c[k] = v
      end
      table.insert(r.Conditions, c)
    end
    table.insert(t, r)
  end

  this.Rules = t
end