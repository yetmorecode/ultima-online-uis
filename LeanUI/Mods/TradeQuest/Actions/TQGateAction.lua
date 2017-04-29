local this = {}

TQGateAction = this

this.open = false
this.selected = false
this.gated = false

this.timer = 0

-- NM gate
this.gate = 1077034226

function this.OnStart(manager)
  this.open = false
  this.selected = false
  this.gated = false
  this.timer = 0
end

function this.OnUpdate(manager, timePassed)
  this.timer = this.timer + timePassed
  
  if not this.open and this.timer > 1 then
    this.OpenGate()
    this.open = true
  end
  
  if this.open and not this.selected and this.timer > 3 and GumpData.Gumps[600] ~= nil then
    this.SelectGate()
    this.selected = true
  end
  
  if this.selected and not this.gated and this.timer > 4 then
    this.Gate()
    this.gated = true
  end
  
  if this.gated and this.timer > 6 then
    manager.AdvanceQuest()
  end
  
  if this.timer > 10 then
    this.open = false
    this.selected = false
    this.gated = false
    this.timer = 0
  end
end

function this.OpenGate()

  HandleSingleLeftClkTarget(this.gate)
  
  local x,y = WindowGetScreenPosition("TargetWindow")
  local w,h = WindowGetDimensions("TargetWindow")
  
  Debug.PrintToChat(L""..x..L":"..y..L" - "..w..L":"..h)
  Mouse.MoveTo(x + w/2, y + h/2)

  MouseLClick()
  MouseLClick()
end

function this.SelectGate()
  -- Find destination city
  RegisterWindowData(WindowData.PlayerEquipmentSlot.Type, EquipmentData.EQPOS_BACKPACK)
  
  local id = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
  RegisterWindowData(WindowData.ContainerWindow.Type, id)
    
  local tradeDealProps = nil
  local data = WindowData.ContainerWindow[id]
  for i=1, data.numItems do
    local item = data.ContainedItems[i]
    RegisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
    
    local prop = ItemProperties.GetObjectProperties(item.objectId, nil, "")
    for propIndex = 1, table.getn(prop) do
      if wstring.find(prop[propIndex], L"TRADE") then
        tradeDealProps = prop
        break
      end
    end
    
    --UnregisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
  end
  
  if tradeDealProps == nil then
    return
  end
  
  local destination = wstring.sub(tradeDealProps[3], 19)
  Debug.PrintToChat(destination)
  
  local d
  if destination == L"Vesper" then
    d = L"Minoc"
  else
    d = destination
  end
  
  local gates = {
    L"Moonglow",
    L"Britain",
    L"Jhelom",
    L"Yew",
    L"Minoc",
    L"Trinsic",
    L"Skara Brae",
  }
  
  for i,name in ipairs(gates) do
    if name == d then
      -- change this if no SA account / red to (num facets) + i
      ButtonSetPressedFlag(GumpData.Gumps[600].Buttons[8 + i], true)
    end
  end 
end

function this.Gate()
  GumpsParsing.PressButton(600, 1)
  --ButtonSetPressedFlag(GumpData.Gumps[600].Buttons[1], true)
  --Mouse.LClick(99, 273)
end
