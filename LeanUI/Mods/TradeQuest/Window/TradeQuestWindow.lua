local this = {}

TradeQuestWindow = this

this.wnd = "TradeQuestWindow"
this.quest = TradeQuest

this.prices = {
  -- Misc
  { "Cartography", 1141298854, 2.5 },
  { "Arms Lore",   1141298854, 1.5 },
  { "Begging",     1141298854, 3 },
  { "Camping",     1141298854, 3 },
  { "Forensics",            1141298854, 0 },
  { "Item Identification",  1141298854, 0 },
  { "Taste Identification", 1141298854, 0 },
  -- Bard
  { "Discordance",  1141298854, 5 },
  { "Peacemaking",  1141298854, 9 },
  { "Provocation",  1141298854, 5 },
  { "Musicianship", 1141298854, 2.5 },
  -- Thief
  { "Stealing", 1154786211, 4 },
  { "Poisoning", 1154786211, 6 },
  { "Hiding", 1154786211, 2 },
  { "Remove Trap", 1154786211, 1 },
  { "Lock Picking", 1154786211, 5 },
  { "Detecting Hidden", 1154786211, 1 },
  { "Snooping", 1154786211, 1 },
  { "Stealth", 1154786211, 4 },
  -- Wilderness
  { "Animal Lore",   1141298854, 2 },
  { "Fishing",       1141298854, 6 },
  { "Herding",       1141298854, 0 },
  { "Veterinary",    1141298854, 0 },
  { "Tracking",      1141298854, 0 },
  { "Animal Taming", 1141298854, 25 },
  -- Mage
  { "Magery", 1091308903, 15 },
  { "Meditation", 1091308903, 0 },
  { "Imbuing", 1091308903, 18 },
  { "Spellweaving", 1091308903, 5 },
  { "Mysticism", 1091308903, 7 },
  { "Necromancy", 1091308903, 8 },
  { "Spirit Speak", 1091308903, 3 },
  { "Eval Intelligence", 1091308903, 3.5 },
  { "Resisting Spells", 1091308903, 0 },
  -- Crafting
  { "Tailoring", 1158211106, 0 },
  { "Carpentry", 1158211106, 1.5 },
  { "Cooking", 1158211106, 2 },
  { "Alchemy", 1158211106, 0 },
  { "Fletching", 1158211106, 0 },
  { "Inscription", 1158211106, 0 },
  { "Mining", 1158211106, 0 },
  { "Blacksmithing", 1158211106, 0 },
  { "Lumberjacking", 1158211106, 1 },
  { "Tinkering", 1158211106, 3 },
  -- Combat
  { "Chivalry",      1091308903, 10 },
  { "Anatomy",       1091308903, 5 },
  { "Tactics",       1091308903, 7 },
  { "Healing",       1091308903, 6 },
  { "Ninjitsu",      1091308903, 10 },
  { "Bushido",       1091308903, 13 },
  { "Parrying",      1091308903, 5 },
  { "Throwing",      1091308903, 2.5 },
  { "Archery",       1091308903, 4 },
  { "Focus",         1091308903, 0 },
  { "Fencing",       1091308903, 0 },
  { "Wrestling",     1091308903, 4 },
  { "Swordsmanship", 1091308903, 4 },
  { "Mace Fighting", 1091308903, 1 }
}

function this.Initialize() 
  this.Update()
  WindowUtils.RestoreWindowPosition(this.wnd)
  
  ButtonSetText(this.wnd.."StartButton", L"Start")
  ButtonSetText(this.wnd.."StopButton", L"Stop")
  ButtonSetText(this.wnd.."MoveButton", L"Move")
  ButtonSetText(this.wnd.."RateButton", L"Rate")
end

function this.Update()

  local button = this.wnd.."Icon"
  local data = this.quest.GetContainerInfo()
  
  if data ~= nil then
    local destination = this.quest.GetDestination()
    LabelSetText(this.wnd.."Title", L"Deliver to " .. destination)
    LabelSetText(this.wnd.."Action", L"")
    
    local xOffset = 0
    local yOffset = 0
    
    if data.iconName ~= nil then
      ButtonSetTexture(button, Button.ButtonState.NORMAL, data.iconName, xOffset, yOffset)
      ButtonSetTexture(button, Button.ButtonState.HIGHLIGHTED, data.iconName, xOffset, yOffset)
      ButtonSetTexture(button, Button.ButtonState.PRESSED, data.iconName, xOffset, yOffset)
      ButtonSetTexture(button, Button.ButtonState.PRESSED_HIGHLIGHTED, data.iconName, xOffset, yOffset)
      WindowSetShowing(button, true)
    end
    
    local hue = data.hue
    WindowSetTintColor(button, hue.r - 30, hue.g - 30, hue.b - 30)
    WindowSetScale(button, data.iconScale * 0.9)
    
    local items = this.quest.GetItems()
    local numItems = table.getn(items)
    local missing = 0
    for i,row in ipairs(items) do
      local row = this.wnd.."Item"..i
      local item = items[i]
      
      LabelSetText(row.."Pos", L""..i..L".")
      LabelSetText(row.."Name", L""..item.name)
      LabelSetText(row.."Qty", L""..item.stock..L" / "..item.needed)
      
      if item.stock ~= item.needed then
        missing = missing + 1
      end
      
      WindowSetShowing(row, true)
    end 
    
    LabelSetText(this.wnd.."Status1", L"" .. (numItems - missing) .. L" / " .. numItems)
    LabelSetText(this.wnd.."Status2", L"" .. math.floor(Quest.time * 100))
  else
    WindowSetShowing(button, false)
    LabelSetText(this.wnd.."Title", L"You don't carry a trade order")
    LabelSetText(this.wnd.."Action", L"")
    LabelSetText(this.wnd.."Status1", L"")
    LabelSetText(this.wnd.."Status2", L"")
    
    for i = 1, 5 do
      local row = this.wnd.."Item"..i
      WindowSetShowing(row, false)
    end
  end
  
  
  ButtonSetDisabledFlag(this.wnd.."StartButton", TradeQuest.active)
  ButtonSetDisabledFlag(this.wnd.."StopButton", not TradeQuest.active)
end

function this.OnStart()
  TradeQuest.Start()
end

function this.OnStop()
  Quest.Stop()
end

function this.OnMoveToContainer()
  local id = Player.BackpackId
  
  if id == nil then
    return nil
  end
  
  RegisterWindowData(WindowData.ContainerWindow.Type, id)
    
  local data = WindowData.ContainerWindow[id]
  if data == nil then
    return nil
  end
  
  local total = 0
  local sum = 0
  local cost = 0 
  
  for i=1, data.numItems do
    local item = data.ContainedItems[i]
    RegisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
    
    local prop = ItemProperties.GetObjectProperties(item.objectId, nil, "")
    if wstring.find(prop[1], L"Scroll Of Transcendence") then
      local sot = wstring.sub(prop[4], 8, wstring.len(prop[4]) - 13)
      local skill = wstring.sub(sot, 0, wstring.len(sot) - 4)
      local points = tonumber(wstring.sub(sot, wstring.len(sot) - 3, wstring.len(sot)))
      local price = 0
      local book = 0
      
      for j=1, #this.prices do
        if towstring(this.prices[j][1]) == skill then
          price = points / 5.0 * this.prices[j][3]
          book = this.prices[j][2]
        end
      end
      
      total = total + 1
      sum = sum + points
      cost = cost + price
      
      if book > 0 and points < 5.0 then
        Debug.PrintToChat(L"Moving " .. wstring.format(L"%.1f", points) .. L" " .. skill .. L" to " .. book)
        Item.MoveToContainer(item.objectId, book, 1)
      end
      
    end
    --UnregisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
  end
  
  --UnregisterWindowData(WindowData.ContainerWindow.Type, id)
  
  Debug.PrintToChat(L"" .. total .. L" scrolls, " .. wstring.format(L"%.1f", sum) .. L" pts, " .. wstring.format(L"%.1f", cost) .. L"m") 
 
end

function this.OnRateScrolls()
  local id = Player.BackpackId
  
  if id == nil then
    return nil
  end
  
  RegisterWindowData(WindowData.ContainerWindow.Type, id)
    
  local data = WindowData.ContainerWindow[id]
  if data == nil then
    return nil
  end
  
  local total = 0
  local sum = 0
  local cost = 0 
  
  for i=1, data.numItems do
    local item = data.ContainedItems[i]
    RegisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
    
    local prop = ItemProperties.GetObjectProperties(item.objectId, nil, "")
    if wstring.find(prop[1], L"Scroll Of Transcendence") then
      local sot = wstring.sub(prop[4], 8, wstring.len(prop[4]) - 13)
      local skill = wstring.sub(sot, 0, wstring.len(sot) - 4)
      local points = tonumber(wstring.sub(sot, wstring.len(sot) - 3, wstring.len(sot)))
      local price = 0
      
      for j=1, #this.prices do
        if towstring(this.prices[j][1]) == skill then
          price = points / 5.0 * this.prices[j][3]
        end
      end
      
      total = total + 1
      sum = sum + points
      cost = cost + price
      
      Debug.PrintToChat(L"" .. wstring.format(L"%.1f", points) .. L" - " .. skill .. L" - " .. wstring.format(L"%.2f", price) .. L"m")
    end
    --UnregisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
  end
  
  --UnregisterWindowData(WindowData.ContainerWindow.Type, id)
  
  Debug.PrintToChat(L"" .. total .. L" scrolls, " .. wstring.format(L"%.1f", sum) .. L" pts, " .. wstring.format(L"%.1f", cost) .. L"m") 
 
end

function this.Shutdown() 
  WindowUtils.SaveWindowPosition(this.wnd)
end

