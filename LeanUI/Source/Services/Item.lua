local this = {}

Item = this

this.ContainerQueque = {}
this.BackpackQueque = {}
this.PickupQueque = {}
this.MoveCooldown = 0
this.MoveCooldownBase = 1.0

function this.Initialize()

end

-- Public APIs

function this.FindInContainerByType(container, type) 
  RegisterWindowData(WindowData.ContainerWindow.Type, container)
  
  local data = WindowData.ContainerWindow[container]
  for i=1, data.numItems do
    local item = data.ContainedItems[i]
    local info = this.GetObjectInfo(item.objectId)
    
    if info.objectType == type then
      return item.objectId
    end    
  end

  return nil
end

function this.FindInContainerByName(container, name)
  RegisterWindowData(WindowData.ContainerWindow.Type, container)
  
  local data = WindowData.ContainerWindow[container]
  for i=1, data.numItems do
    local item = data.ContainedItems[i]
    local info = this.GetObjectInfo(item.objectId)
    
    if info.name == name then
      return item.objectId
    end    
  end

  return nil
end

--
--
-- objectType
-- name
-- quantity
-- iconId, iconName
-- 
function this.GetObjectInfo(id)
  local info = WindowData.ObjectInfo[id]
  
  if info ~= nil then
    return info
  end
  
  RegisterWindowData(WindowData.ObjectInfo.Type, id)
  info = WindowData.ObjectInfo[id]
  
  return info
end

function this.GetRating(id)

    RegisterWindowData(WindowData.ObjectInfo.Type, id)
    local properties = ItemProperties.GetObjectProperties(id, {}, "")
    
    local neutral = {
      score = 0, hue = { r = 0, g = 0, b = 0 }
    }
    
    if properties == nil then
      return neutral
    end
    
    --Debug.PrintToChat("object " .. id .. ":")
    --Debug.DumpToChat("WindowData.ObjectInfo["..id.."]", WindowData.ObjectInfo[id])
    
    local cursed = false
    
    local legendary = false
    local greater = false
    local major = false
    
    local resists = 0
    local phy = 0
    local fire = 0
    local cold = 0
    local poi  = 0
    local ener = 0
    
    local resource = false
    local key = false
    
    local di = 0
    local hci = 0
    local dci = 0
    local ep = 0
    local luck = 0
    
    local sdi = 0
    
    local hla = 0
    local hld = 0
    local splintering = 0
    
    local name = properties[1]
    
    local named = false
    local patterns = {
      L"Soles Of Providence",
      L"Tangle"
    }
    for i,pat in ipairs(patterns) do
      if wstring.find(name, pat) then
        named = true 
      end  
    end
    
    
    local tmp
    for propIndex = 2, table.getn(properties) do
      local p = properties[propIndex]
      
      if wstring.find(p, L"Cursed") then
        cursed = true
      end
      
      if wstring.find(p, L"Taint") or wstring.find(p, L"Corruption") or wstring.find(p, L"Dread Horn Mane") then
        resource = true
      end
      
      if wstring.find(p, L"Legendary Artifact") then
        legendary = true
      end
      
      if wstring.find(p, L"Greater Artifact") then
        greater = true
      end
      
      if (wstring.find(p, L"Irk") and wstring.find(p, L"Brain")) or wstring.find(p, L"Lissith") then
        key = true
      end
      
      tmp = wstring.match(p, L"Physical Resist (%d+)%%")
      if tmp ~= nil then
        phy = tonumber(tmp)
      end
      tmp = wstring.match(p, L"Fire Resist (%d+)%%")
      if tmp ~= nil then
        fire = tonumber(tmp)
      end
      tmp = wstring.match(p, L"Cold Resist (%d+)%%")
      if tmp ~= nil then
        cold = tonumber(tmp)
      end
      tmp = wstring.match(p, L"Poison Resist (%d+)%%")
      if tmp ~= nil then
        poi = tonumber(tmp)
      end
      tmp = wstring.match(p, L"Energy Resist (%d+)%%")
      if tmp ~= nil then
        ener = tonumber(tmp)
      end
      
      tmp = wstring.match(p, L"Hit Lower Attack (%d+)%%")
      if tmp ~= nil then
        hla = tonumber(tmp)
      end
      tmp = wstring.match(p, L"Hit Lower Defense (%d+)%%")
      if tmp ~= nil then
        hld = tonumber(tmp)
      end
      
      tmp = wstring.match(p, L"Splintering Weapon (%d+)%%")
      if tmp ~= nil then
        splintering = tonumber(tmp)
      end
      tmp = wstring.match(p, L"Enhance Potions (%d+)%%")
      if tmp ~= nil then
        ep = tonumber(tmp)
      end
      tmp = wstring.match(p, L"Luck (%d+)")
      if tmp ~= nil then
        luck = tonumber(tmp)
      end
      
      tmp = wstring.match(p, L"Spell Damage Increase (%d+)%%")
      if tmp ~= nil then
        sdi = tonumber(tmp)
      else
        tmp = wstring.match(p, L"Damage Increase (%d+)%%")
        if tmp ~= nil then
          di = tonumber(tmp)
        end
      end
      
      tmp = wstring.match(p, L"Hit Chance Increase (%d+)%%")
      if tmp ~= nil then
        hci = tonumber(tmp)
      end
      tmp = wstring.match(p, L"Defense Chance Increase (%d+)%%")
      if tmp ~= nil then
        dci = tonumber(tmp)
      end
    end
    
    resists = phy + fire + cold + poi + ener
    
    local best = {
      score = 100, hue = { r = 0, g = 255, b = 0 }
    }
    local good = {
      score = 50, hue = { r = 50, g = 200, b = 50 }
    }
    local check = {
      score = 1, hue = { r = 255, g = 120, b = 0 }
    }    
    local worst = {
      score = -100, hue = { r = 255, g = 50, b = 50 }
    }
    
    if cursed then
      return worst
    end
    
    if legendary or key or (hla >= 25 and hld >= 25 and splintering >= 20) or luck >= 150 or named then
      return best
    end
    
    if resists >= 100 or resource or (sdi >= 18 and di == 0) or (hci >= 15 and dci >= 15) then
      return good
    end
    
    if greater or resists >= 85 or (sdi >= 15 and di == 0) or hci >= 15 or dci >= 15 then
      return check
    end
    
    --UnregisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
    
    return neutral
end

function this.GetShopByName(name)
  return "none"
end

function this.GetTypeByName(name)

  local types = {}
  types[6812] = L"Flax Bundle"
  types[3576] = L"Pile Of Wool"
  types[5991] = L"Cloth"
  types[3577] = L"Bale Of Cotton"
  types[3989] = L"Bolt Of Cloth"
  types[5990] = L"Cut Cloth"
  types[4000] = L"Spool Of Thread"
  
  for t,n in pairs(types) do
    if n == name then
      return t
    end
  end
  
  return nil
end

function this.MoveToContainer(sourceContainer, destinationContainer, amount)
  local item = {
    source = sourceContainer,
    destination =  destinationContainer,
    amount = amount
  }
  table.insert(this.ContainerQueque, 1, item)
end

function this.UpdateMoveItems(timePassed)
  if this.MoveCooldown > 0 then
    this.MoveCooldown = this.MoveCooldown - timePassed
    return
  end
  
  -- Move to container items
  if table.getn(this.ContainerQueque) > 0 then
    local top = table.remove(this.ContainerQueque)
    
    --Debug.PrintToChat("moving " .. top.amount .. " " .. top.source .. " to " .. top.destination)
    MoveItemToContainer(top.source, top.amount, top.destination)
  end
  
  -- Move to backpack items (todo)
  
  -- Pickup items (todo)
  
  this.MoveCooldown = this.MoveCooldownBase
end

