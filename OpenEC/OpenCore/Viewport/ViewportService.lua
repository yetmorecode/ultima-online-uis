local ViewportService = {
  Initialize = function (self)
    WindowRegisterEventHandler("Root", SystemData.Events.VIEWPORT_CHANGED, "OpenCore.Viewport.OnViewportChanged" )
  end,
  
  Shutdown = function (self)
  
  end,
  
  OnViewportChanged = function ()
    self = OpenCore.Viewport
  end,
  
  UpdatePosition = function (self, x, y, width, height)
    UpdateViewport(width, height, x, y)
  end,
  
  SetFullscreen = function (self)
    self:UpdatePosition(0, 0, 1, 1)
  end,
  
  IsEnabled = function (self)
    return SystemData.Settings.Resolution.viewportEnabled == true
  end,
  
  GetPosition = function (self)
    local p = SystemData.Settings.Resolution.viewportPos
    return p.x, p.y
  end,
  
  GetSize = function (self)
    local s = SystemData.Settings.Resolution.viewportSize
    return s.x, s.y
  end
}

OpenCore:RegisterServiceClass("Viewport.ViewportService", "Viewport", ViewportService)