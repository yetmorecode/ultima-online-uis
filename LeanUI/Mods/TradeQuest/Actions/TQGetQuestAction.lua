local this = {}

TQGetQuestAction = this

this.requested = false
this.accepted = false
this.timer = 0

function this.OnStart(manager)
  this.requested = false
  this.accepted = false
  this.timer = 0
end

function this.OnUpdate(manager, timePassed) 
  this.timer = this.timer + timePassed

  if not this.requested and this.timer > 1.5 then
    this.RequestQuest(manager.quest.GetNearestTradeMinister())
    this.requested = true
  end
  
  if this.requested and not this.accepted and this.timer > 3 then
    this.AcceptQuest()
    this.accepted = true
  end
  
  if this.requested and this.accepted and this.timer > 4 then
    RegisterWindowData(WindowData.PlayerEquipmentSlot.Type, EquipmentData.EQPOS_BACKPACK)
  
    local id = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
    RegisterWindowData(WindowData.ContainerWindow.Type, id)
      
    local ctId = nil
    local data = WindowData.ContainerWindow[id]
    for i=1, data.numItems do
      local item = data.ContainedItems[i]
      RegisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
      
      local prop = ItemProperties.GetObjectProperties(item.objectId, nil, "")
      for propIndex = 1, table.getn(prop) do
        if wstring.find(prop[propIndex], L"TRADE") then
          ctId = item.objectId
          break
        end
      end
      
      --UnregisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
    end
    
    if ctId ~= nil then
      -- Got the container for the quest
      manager.AdvanceQuest()
    end
  end
  
  if this.timer > 6 then
    -- reset and try again
    this.OnStart(manager)
  end
end

function this.RequestQuest(id)
  Debug.PrintToChat("Requesting trade quest "..id)
  RequestContextMenu(id)
  WindowData.ContextMenu.returnCode = 350
  BroadcastEvent(SystemData.Events.CONTEXT_MENU_SELECTED)
end

function this.AcceptQuest()
  if GumpData == nil then
    return
  end
  
  -- TradeQuest gump
  local gump = GumpData.Gumps[9195]
  
  if gump ~= nil then
    -- Press "ok" button
    local id = WindowGetId(gump.windowName)
    GenericGumpOnClicked(id, gump.Buttons[1])
    
    TradeQuestWindow.Update()
  end
  
end
