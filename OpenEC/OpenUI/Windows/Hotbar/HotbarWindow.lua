local HotbarWindow = {
  OnInitialize = function ()
    OpenCore.Window:RestorePosition(OpenCore:GetActiveDialog())
  end,
  
  OnShutdown = function ()
    OpenCore.Window:SavePosition(OpenCore:GetActiveDialog())
  end,
  
  OnHandleLButtonDown = function ()
    WindowSetMoving(WindowGetParent(SystemData.ActiveWindow.name), true)
  end,
  
  OnHandleLButtonUp = function ()
    WindowSetMoving(WindowGetParent(SystemData.ActiveWindow.name), false)
  end
}

OpenUI.HotbarWindow = HotbarWindow