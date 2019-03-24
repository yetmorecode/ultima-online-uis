OverheadTextService = Class.define({

  --
  -- Public
  --
  AddNameListener = function (self, alias, listener)
    self.NameListeners[alias] = listener
  end,
  
  RemoveNameListener = function (self, alias)
    self.NameListeners[alias] = nil
  end,
  
  AddChatListener = function (self, alias, listener)
    self.ChatListeners[alias] = listener
  end,
  
  RemoveChatListener = function (self, alias) 
    self.ChatListeners[alias] = nil
  end,

  --
  -- Private
  --
  
  -- Listeners for Name updates
  NameListeners = {},
  -- Listeners for Chat updates
  ChatListeners = {},
  -- Mobile ID to Name cache
  NameCache = {},
  
  Initialize = function (self)
    ModuleSetEnabled("UO_ChatWindow", true)
    LoadResources( 
      "./UserInterface/"..SystemData.Settings.Interface.customUiName.."/GameServices/OverheadTextService", 
      "OverheadText.xml", 
      "OverheadText.xml" 
    )
    
    WindowRegisterEventHandler("Root", WindowData.MobileName.Event, "OverheadText.HandleMobileNameUpdate")
    
    OverheadText = {}
    OverheadText.Initialize = function () 
      self:InitializeWindow() 
      --DestroyWindow("OverheadTextWindow_"..SystemData.DynamicWindowId)
    end
    OverheadText.Shutdown = function () 
      self:ShutdownWindow() 
    end
    OverheadText.OnOverheadChatShutdown = function ()
      self:ShutdownWindow()
    end
    OverheadText.OnShown = function () 
      self:OnShown() 
    end
    OverheadText.HandleMobileNameUpdate = function ()
      self:HandleMobileNameUpdate()
    end
    OverheadText.ShowOverheadText = function ()
      self:ShowOverheadText()
    end
    
  end,
  
  Shutdown = function (self)
  
  end,
  
  InitializeWindow = function (self)
    local mobileId = SystemData.DynamicWindowId
    RegisterWindowData (WindowData.MobileName.Type, mobileId)  
    self:NotifyNameListeners (mobileId)
  end,
  
  ShutdownWindow = function (self)
    local windowName = SystemData.ActiveWindow.name
    local mobileId = tonumber (string.match (windowName, "([0-9]+)"))
    UnregisterWindowData (WindowData.MobileName.Type, mobileId)
  end,
  
  HandleMobileNameUpdate = function (self)
    local mobileId = WindowData.UpdateInstanceId
    self:NotifyNameListeners (mobileId)
  end,
  
  UpdateName = function (self, mobileId)
    local data = WindowData.MobileName[mobileId]
    if (data ~= nil and data.MobName ~= nil and data.MobName ~= L"") then
      self:NotifyNameListeners (mobileId)
    end  
  end,
  
  ShowOverheadText = function (self) 
    if SystemData.TextSourceID ~= -1 then
      self:NotifyChatListeners (SystemData.TextSourceID, SystemData.Text)  
    end
  end,
  
  OnShown = function (self) 
    
  end,
  
  NotifyNameListeners = function (self, mobileId)
    local mobileData = WindowData.MobileName[mobileId]
    if (mobileData == nil or mobileData.MobName == nil or mobileData.MobName == L"") then
      return
    end
    
    self.NameCache[mobileId] = mobileData.MobName
    local parameter = {
      Id = mobileId,
      Name = mobileData.MobName,
      Notoriety = mobileData.Notoriety
    } 
    for alias, listener in pairs(self.NameListeners) do
      pcall(listener, mobileId, mobileData.MobName, parameter)
    end
  end,
  
  NotifyChatListeners = function (self, mobileId, text)
    local parameter = {
      Id = mobileId,
      Text = text
    }
    for alias, listener in pairs(self.ChatListeners) do
      pcall(listener, mobileId, text, parameter)
    end
  end
})