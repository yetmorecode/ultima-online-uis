local HotbarService = {
  Initialize = function (self)
    OpenCore:Chat(SystemData.Hotbar)
  end,
  
  Shutdown = function (self)
  
  end,
  
  CreateHotbar = function (self, start)
    start = start or 1
    local id = self:GetNextHotbarIdFrom(start)
    if id ~= nil then
      HotbarRegisterNew(id)
    end
  end,
  
  DestroyHotbar = function (self, id)
    --for i=1,12 do
    --  HotbarSystem.UnbindKey(hotbarId, i, SystemData.BindType.BINDTYPE_HOTBAR)
    --end
    HotbarUnregister(id)
  end,
  
  GetHotbar = function (self, id)
    return SystemData.Hotbar[id]
  end,
  
  GetHotbarIds = function (self)
    return SystemData.Hotbar.HotbarIds
  end,
  
  GetNextHotbarIdFrom = function (self, start)
    local newHotbarId = start
    while newHotbarId ~= 2000 do
      local found = false
      for index, hotbarId in pairs(SystemData.Hotbar.HotbarIds) do
        if( hotbarId == newHotbarId ) then
          found = true
        end
      end
      if( found ~= true ) then
        break
      end
      newHotbarId = newHotbarId + 1
    end
    return newHotbarId
  end
}

OpenCore:RegisterServiceClass("Hotbar.HotbarService", "Hotbar", HotbarService)