local WindowService = {
  Initialize = function (self)
  
  end,
  
  Shutdown = function (self)
  
  end,
  
  GetActiveWindowName = function (self)
    return SystemData.ActiveWindow.name
  end,
  
  GetActiveDialog = function (self)
    return self:GetTopmostDialog(SystemData.ActiveWindow.name)
  end,
  
  GetTopmostDialog = function (self, window)
    local current = window
    local dialog
    repeat
      dialog = current
      current = WindowGetParent(current)
    until (current == nil or current == "Root") 
    return dialog
  end,
  
  SavePosition = function (self, window)
    local x, y = WindowGetScreenPosition(window)
    local scale = OpenCore.Client:GetScale()
    x = math.floor(x / scale + 0.5)
    y = math.floor(y / scale + 0.5)
    local width, height = WindowGetDimensions(window)
    local windowPositions = SystemData.Settings.Interface.WindowPositions
    local position = nil
    for i, name in pairs(windowPositions.Names) do
      if window == name then
        position = i
        break
      end
    end
    if position == nil then
      position = table.getn(windowPositions.Names) + 1
      windowPositions.Names[position] = window
    end
    windowPositions.WindowPosX[position] = x
    windowPositions.WindowPosY[position] = y
    windowPositions.WindowWidth[position] = width
    windowPositions.WindowHeight[position] = height
  end,
  
  RestorePosition = function (self, window)
    local windowPositions = SystemData.Settings.Interface.WindowPositions
    local position = nil
    for i, name in pairs(windowPositions.Names) do
      if window == name then
        position = i
        break
      end
    end
    if position ~= nil then
      local x = windowPositions.WindowPosX[position]
      local y = windowPositions.WindowPosY[position]
      local width = windowPositions.WindowWidth[position]
      local height = windowPositions.WindowHeight[position]
      if x ~= nil and y ~= nil then      
        WindowClearAnchors(window)
        WindowAddAnchor(window, "topleft", "Root", "topleft", x, y) 
      end
      if width ~= nil and height ~= nil then
        WindowSetDimensions(window, width, height)
      end      
    end
  end
}

OpenCore:RegisterServiceClass("Window.WindowService", "Window", WindowService)