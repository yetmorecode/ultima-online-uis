local ContextMenuService = {

  --
  -- Public
  --
  
  EVENT_MENU_SHOW = 1,
  EVENT_MENU_HIDE = 2,
  
  AddMenuItem = function (self, alias, label, handler)
    if type(label) == "string" then
      label = StringToWString(label)
    end
    self.MenuItems[alias] = OpenCore.Classes.ContextMenu.MenuItem:Create(alias, label, handler)
  end,
  
  RemoveMenuItem = function (self, alias)
    self.MenuItems[alias] = nil
  end,

  GetItems = function (self)
    return self.MenuItems
  end,
  
  TriggerItem = function (self, alias)
    if self.MenuItems[alias] ~= nil then
      local handler = self.MenuItems[alias]:GetHandler()
      handler()
    end
  end,
  
  AddListener = function (self, alias, listener) 
    self.Listeners[alias] = listener
  end,
  
  RemoveListener = function (self, alias)
    self.Listeners[alias] = nil
  end,
  
  -- 
  -- Private
  --
  
  MenuItems = {},
  Listeners = {},
  
  Initialize = function (self)
    LoadResources( 
      "./UserInterface/"..SystemData.Settings.Interface.customUiName.."/OpenCore/ContextMenu", 
      "ContextMenuWindow.xml", 
      "ContextMenuWindow.xml" 
    )
    -- We need to create the global name "MainMenuWindow" as this is the hardcoded callback into the UI code
    ContextMenuWindow = {}
    ContextMenuWindow.OnShow = function ()
      self:NotifyShown ()
    end
    ContextMenuWindow.OnHide = function ()
      self:NotifyHidden ()
    end
    CreateWindow("ContextMenu", false)
  end,
  
  NotifyShown = function (self)
    for alias, listener in pairs(self.Listeners) do
      pcall(listener, self.EVENT_MENU_SHOW)
    end
  end,
  
  NotifyHidden = function (self)
    for alias, listener in pairs(self.Listeners) do
      pcall(listener, self.EVENT_MENU_HIDE)
    end
  end
}

OpenCore:RegisterServiceClass("ContextMenu.ContextMenuService", "ContextMenu", ContextMenuService)