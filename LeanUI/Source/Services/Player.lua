local this = {}

Player = this

this.Id = nil
this.BackpackId = nil

function this.Initialize()

end

function this.UpdateData()
  if this.Id ~= nil and this.BackpackId ~= nil then
    return
  end
  
  this.Id = WindowData.PlayerStatus.PlayerId
  if WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK] ~= nil then
    this.BackpackId = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
  else
    this.BackpackId = nil
  end  
  
  --Debug.PrintToChat("Player " .. this.Id)
  --Debug.PrintToChat("Backpack " .. this.BackpackId)
end

function this.ShowPosition()
  local t = ""
  t = t .. "x = " ..  WindowData.PlayerLocation.x
  t = t .. ", y = " ..  WindowData.PlayerLocation.y
  t = t .. ", z = " ..  WindowData.PlayerLocation.z
  
  Debug.PrintToOverhead(t)
  Debug.PrintToChat(t)
end

function this.IsParalyzed()
  return BuffDebuff.BuffWindowId[1037]
end

function this.IsInvisible()
  return BuffDebuff.BuffWindowId[1036] or BuffDebuff.BuffWindowId[1012]
end

function this.DumpBackpack()
  local id = Player.BackpackId
  if id == nil then
    return nil
  end
  RegisterWindowData(WindowData.ContainerWindow.Type, id)
  local data = WindowData.ContainerWindow[id]
  if data == nil then
    return
  end
  
  for i=1, data.numItems do
    local item = data.ContainedItems[i]
    RegisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
    
    local info = Item.GetObjectInfo(item.objectId)
    item.objectType = info.objectType
    local prop = ItemProperties.GetObjectProperties(item.objectId, nil, "")
    item.name = prop[1]
    Debug.DumpToChat("item["..i.."]", item)
  end
end