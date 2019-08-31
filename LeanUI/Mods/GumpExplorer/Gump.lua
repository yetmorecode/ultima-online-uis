Gump = Class.extend(UOObject, {
  id = 0,
  data = nil,
  
  GetData = function (self)
    if self.data == nil then
      if GumpData == nil or GumpData.Gumps == nil then
        Debug.PrintToChat(L"No open gumps - try opening a generic gump")
        return
      end
      
      if GumpData.Gumps[self.id] ~= nil then
        self.data = GumpData.Gumps[self.id]
      else
        Debug.PrintToChat(L"Gump " .. self.id .. L" does not exist")
      end
    end
    return self.data
  end,
  
  GetId = function (self)
    return self.id
  end,
  
  GetWindowName = function (self)
    if self:HasWindow() then
      local data = self:GetData()
      return data.windowName    
    end
  end,
  
  HasButton = function (self)
    local data = self:GetData()
    if data ~= nil then
      return data.Buttons ~= nil    
    end
  end,
  
  HasLabel = function (self)
    local data = self:GetData()
    if data ~= nil then
      return data.Labels ~= nil    
    end
  end,
  
  HasTextEntry = function (self)
    local data = self:GetData()
    if data ~= nil then
      return data.TextEntry ~= nil    
    end
  end,
  
  HasWindow = function (self)
    local data = self:GetData()
    if data ~= nil then
      return data.windowName ~= nil    
    end
  end,
  
  SetId = function (self, id)
    self.id = id
  end
})