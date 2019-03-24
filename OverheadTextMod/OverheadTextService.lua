OverheadTextService = Class.define({

  Initialize = function (self)
    WindowRegisterEventHandler("Root", WindowData.MobileName.Event, "OverheadTextService.HandleNameUpdate")
    DebugService.PrintToChat (" .. started OverheadTextService")
  end,
  
  Shutdown = function (self)
  
  end,
  
  HandleNameUpdate = function ()
    local mobile = WindowData.UpdateInstanceId
    local data = WindowData.MobileName[mobile]
    
    if (data.MobName ~= nil) then
      DebugService.PrintToChat (L"mobile: " .. data.MobName)
    end
  end
})