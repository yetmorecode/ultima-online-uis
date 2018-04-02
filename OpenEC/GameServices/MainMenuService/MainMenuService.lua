MainMenuService = Class.define({
  
  --
  -- Public
  --
  
  EVENT_MENU_SHOW = 1,
  EVENT_MENU_HIDE = 2,
  
  AddMenuItem = function (self, alias, label, handler)
    self.MenuItems[alias] = {
      Alias = alias,
      Label = label,
      Handler = handler
    }
  end,
  
  RemoveMenuItem = function (self, alias)
    self.MenuItems[alias] = nil
  end,

  GetMenuItems = function (self)
    return self.MenuItems
  end,
  
  TriggerItem = function (self, alias)
    if self.MenuItems[alias] ~= nil then
      local handler = self.MenuItems[alias].Handler
      handler()
    end
  end,
  
  AddMainMenuListener = function (self, alias, listener) 
    self.MainMenuListeners[alias] = listener
  end,
  
  RemoveMainMenuListener = function (self, alias)
    self.MainMenuListeners[alias] = nil
  end,
  
  -- 
  -- Private
  --
  
  MenuItems = {},
  MainMenuListeners = {},
  
  Initialize = function (self)
    LoadResources( 
      "./UserInterface/"..SystemData.Settings.Interface.customUiName.."/GameServices/MainMenuService", 
      "MainMenuWindow.xml", 
      "MainMenuWindow.xml" 
    )
    MainMenuWindow = {}
    MainMenuWindow.OnShow = function ()
      self:NotifyShown ()
    end
    MainMenuWindow.OnHide = function ()
      self:NotifyHidden ()
    end
    CreateWindow("MainMenuWindow", false)
  end,
  
  NotifyShown = function (self)
    for alias, listener in pairs(self.MainMenuListeners) do
      pcall(listener, self.EVENT_MENU_SHOW)
    end
  end,
  
  NotifyHidden = function (self)
    for alias, listener in pairs(self.MainMenuListeners) do
      pcall(listener, self.EVENT_MENU_HIDE)
    end
  end
})
