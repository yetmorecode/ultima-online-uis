--
-- OpenEC root UI lifecycle methods
--
-- The functions here are called by UOSA on booting, updating and shutting down the UI.
-- They are the very entry points into the lua UI code and responsible to delegate
-- further into the lua UI layer.
--

function Interface.CreatePlayWindowSet()
  DebugService.PrintToChat("OpenEC version 0.1")

  -- Register OpenEC standard update loops
  Bootstrap.InitializeUpdateLoops()
  
  -- Register OpenEC standard services
  Bootstrap.InitializeServices()
  
  -- Listen to mobile name and chat updates..
  OverheadTextService:AddNameListener("test", function (mobileId, name)
    DebugService.PrintToChat(L"You see: " .. name .. L" (" .. mobileId .. L")")
  end)
  OverheadTextService:AddChatListener("test", function (mobileId, text, extra)
    DebugService.PrintToChat(L"Chat: " .. text .. L" (" .. mobileId .. L")")
  end)
  
  MainMenuService:AddMainMenuListener("test", function (event)
    if event == MainMenuService.EVENT_MENU_SHOW then
      DebugService.PrintToChat("MainMenu shown..")
    else
      DebugService.PrintToChat("MainMenu hidden..")
    end
  end)
end

function Interface.Update(timePassed)
  UpdateLoopService:OnUpdate (timePassed)
  if SystemData.UpdateProcessed.Time > 0.1 then
    DebugService.PrintToChat("WARNING: Update took too long: " .. SystemData.UpdateProcessed.Time)
  end
end

function Interface.Shutdown()

end