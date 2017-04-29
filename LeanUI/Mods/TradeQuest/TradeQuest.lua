local this = {}

TradeQuest = this

LoadResources(
  "./UserInterface/"..SystemData.Settings.Interface.customUiName.."/Mods/TradeQuest/Window", 
  "TradeQuestWindow.xml", 
  "TradeQuestWindow.xml"
)

this.active = false

function this.Initialize() 
  LeanWindowManager.CreateWindow("TradeQuestWindow", false, {
    description = L"Overview of trade quest items & progress"
  })
end

function this.Shutdown() 
  DestroyWindow("TradeQuestWindow")
end

function this.Start()
  Quest.Initialize(this)
  
  TradeQuestWindow.Update()
  Quest.Start()
  
end

function this.OnStart(manager) 
  ContextMenu.HideWindow = true
  this.active = true
end

function this.OnStop(manager)
  ContextMenu.HideWindow = false
  Move.Stop()
  
  this.active = false
end

function this.OnUpdate(manager, timePassed)
  TradeQuestWindow.Update()
end

function this.GetActions()
  return {
    TQRecallAction,
    TQGetQuestAction,
    TQBoSAction,
    TQMoveToShopAction,
    TQShopAction,
    TQMoveToGateAction,
    TQGateAction,
    TQMoveToAltShopAction,
    TQShopAction,
    TQMoveToDestinationAction,
    TQSubmitCrateAction
  }
end



function this.GetContainerId()
  local id = Player.BackpackId
  
  if id == nil then
    return nil
  end
  
  RegisterWindowData(WindowData.ContainerWindow.Type, id)
    
  local ctId = nil
  local data = WindowData.ContainerWindow[id]
  
  if data == nil then
    return nil
  end
  
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
  
  --UnregisterWindowData(WindowData.ContainerWindow.Type, id)
  
  return ctId
end

function this.GetContainerInfo()
  local ct = this.GetContainerId()
  
  if ct ~= nil then
    return Item.GetObjectInfo(ct)
  end
end

function this.GetItems()
  local id = Player.BackpackId
  RegisterWindowData(WindowData.ContainerWindow.Type, id)
    
  local tradeDealProps = nil
  local merchantId = this.tailor
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
  
  if tradeDealProps ~= nil then
    local items = {}
    
    for propIndex = 7, table.getn(tradeDealProps)-1 do
      local p = tradeDealProps[propIndex]
      
      local colon = wstring.find(p, L":")
      local slash = wstring.find(p, L"/")
      local name = wstring.sub(p, 1, colon-1)
      local stock = tonumber(wstring.sub(p, colon+1, slash-1))
      local need = tonumber(wstring.sub(p, slash+1))
      name = wstring.gsub(name, L"-", L"")
    
      local missing = 0
      if need > stock then
        missing = need - stock
      end
    
      table.insert(items, 1, {
        name = name,
        stock = stock,
        needed = need,
        missing = missing
      })
    end
    
    return items
  else
    return nil
  end    
end

function this.GetMissingItems()
  local all = this.GetItems()
  local items = {}
  
  if all == nil then
    return nil
  end
  
  for i,item in ipairs(all) do
    if item.missing > 0 then
      table.insert(items, 1, item)
    end  
  end
  
  return items
end

function this.HasMissing()
  local items = this.GetMissingItems()
  local num = table.getn(items)
  
  if num > 0 then
    return true
  else
    return false
  end
end

function this.GetDestination()
  -- Find destination city
  local id = Player.BackpackId
  
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
    
    return nil
  end
  
  local destination = wstring.sub(tradeDealProps[3], 19)
  
  return destination
end

function this.GetNearestTradeMinister()

  local ids = {
    {"New Magincia", 6009195, 3676, 2255},
    {"Moonglow", 64584811, 4416, 1037},
    {"Britain", 8752843, 1438, 1759},
    {"Yew", 7251398, 622, 1043},
    {"Minoc", 8078769, 2499, 399},
    {"Trinsic", 7640897, 2058, 2851},
    {"Skara Brae", 7640854, 649, 2238},
    {"Vesper", 6009166, 3004, 836},
    {"Jhelom", 7640828, 1377, 3876}
  }
  
  for i, data in ipairs(ids) do
    if this.InArea(data[3], data[4]) then
      Debug.PrintToChat(data[1])
      
      return data[2]
    end
  end

  return nil
end

function this.GetNearestShop()
  local ids = {
    {"NM", 13585175, 3707, 2247},
    {"Britain", 12359361, 1471, 1686},
    {"Trinsic", 11888596, 1983, 2839},
    {"Yew", 6036684, 516, 998},
    {"Skara Brae", 11842635, 650, 2184},
    {"Jhelom", 10740993, 1360, 3792},
    {"Minoc", 7236788, 2530, 557},
    {"Vesper", 12490684, 2846, 884},
    {"Moonglow", 10968955, 4454, 1062}
  }

  for i, data in ipairs(ids) do
    if this.InArea(data[3], data[4]) then
      Debug.PrintToChat(data[1])
      
      return data[2]
    end
  end

  return nil
end

function this.InArea(x,y)
  local dist = 10
  
  if math.abs(WindowData.PlayerLocation.x - x) < dist and math.abs(WindowData.PlayerLocation.y - y) < dist then
    return true
  else
    return false
  end
end