--
-- OpenEC root UI lifecycle methods
--
-- The functions here are called by UOSA on booting, updating and shutting down the UI.
-- They are the very entry points into the lua UI code and responsible to delegate
-- further into the lua UI layer.
--

-- TODO: remove
ModuleSetEnabled("UO_ChatWindow", true)

if not DebugWindow.logging then
  DebugWindow.ToggleLogging()
end

function Interface.CreatePlayWindowSet()
  OpenCore:Initialize()
  OpenCore:PrintBanner()
  
  WindowSetShowing("DebugWindow", true)
  
  OpenCore.MainMenu:AddMenuItem("Settings", "Settings", function () 
    
  end)
  
  RegisterWindowData(WindowData.PlayerStatus.Type,0)
  OpenCore.MainMenu:AddMenuItem("Help", "Help", function () 
    RequestContextMenu(OpenCore.Player:GetPlayerId())
  end)
  
  OpenCore.ContextMenu:AddListener("test", function (event) 
    if event == OpenCore.ContextMenu.EVENT_MENU_SHOW then
      CreateWindow("OpenUI.ContextMenuWindow", true)  
    else
      DestroyWindow("OpenUI.ContextMenuWindow")
    end
  end)
  
  
  OpenCore.MainMenu:AddMenuItem("Exit", "Exit Game", function () 
    OpenCore.Client:Quit() 
  end)
  OpenCore.MainMenu:AddMenuItem("Logout", "Logout", function () 
    OpenCore.Client:Logout() 
  end)
  OpenCore.MainMenu:AddListener("test", function (event) 
    if event == OpenCore.MainMenu.EVENT_MENU_SHOW then
      CreateWindow("OpenUI.MainMenuWindow", true)  
    else
      DestroyWindow("OpenUI.MainMenuWindow")
    end
  end)
  
  OpenCore.OverheadText:AddChatListener("test", function (source, text) 
    OpenCore:Chat(text) 
  end)
  OpenCore.OverheadText:AddNameListener("est", function (mobile, name, data) 
    local windowName = "OpenUI.Windows.OverheadText." .. mobile
    LabelSetText(windowName..".Label", name)
    local textColor = OpenUI.OverheadWindow.NameColors[data.Notoriety]
    if textColor then
      LabelSetTextColor(windowName..".Label", textColor.r, textColor.g, textColor.b)
    end
  end)
  OpenCore.OverheadText:AddWindowListener("test", function (service, event, mobile, data)
    local windowName = "OpenUI.Windows.OverheadText." .. mobile
    
    if event == OpenCore.OverheadText.EVENT_WINDOW_INITIALIZE then
      if not DoesWindowExist(windowName) then
        CreateWindowFromTemplate(windowName, "OpenUI.OverheadWindow", "Root")
      end
      AttachWindowToWorldObject(mobile, windowName)
      if data.MobName and data.MobName ~= L"" then
        local name = data.MobName
        LabelSetText(windowName..".Label", name)
        --local x, y = LabelGetTextDimensions(windowName..".Label")
        --WindowSetDimensions(windowName, x, y)
        local textColor = OpenUI.OverheadWindow.NameColors[data.Notoriety]
        if textColor then
          LabelSetTextColor(windowName..".Label", textColor.r, textColor.g, textColor.b)
        end
      end    
    else
      if DoesWindowExist(windowName) then
        DestroyWindow(windowName)
      end
    end
  end)
  
  --OpenCore.Player:Debug()
  OpenCore.Player:AddStatusListener("test", function (player)
    --OpenCore:Chat("update stats: " .. player:GetStamina() .. " / " .. player:GetMaxStamina())
  end)
  
  --OpenCore.Hotbar:DestroyHotbar(1000)
  --OpenCore.Hotbar:DestroyHotbar(1001)
  
end

chatHack = false
function Interface.Update(timePassed)
  if chatHack then
    
    LogDisplayAddLog("ChatWindowChatLogDisplay", "UiLog", true)
    for index = 1, 5 do      
      LogDisplaySetFilterState("ChatWindowChatLogDisplay", "UiLog", index, true)
    end
    chatHack = false
  end
end

function Interface.Shutdown()

end