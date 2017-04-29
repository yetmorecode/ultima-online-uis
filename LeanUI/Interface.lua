----------------------------------------------------------------
-- Global functions
----------------------------------------------------------------

function ToggleWindowByName( wndName, btnName, toggleFunction, onOpenFunction, onCloseFunction )
	local showing = WindowGetShowing( wndName )
	showing = not showing	
	WindowSetShowing( wndName, showing )
	
	if (btnName ~= "") then
		ButtonSetPressedFlag( btnName, showing )
	end
	
	if( onOpenFunction ~= nil and showing == true ) then
	    onOpenFunction()
	elseif( onCloseFunction ~= nil and showing == false ) then
	    onCloseFunction()
	end
end

----------------------------------------------------------------
-- In-Game Interface Initialization Variables
----------------------------------------------------------------

Interface.TID = { accept=1013076, cancel=1011012 }

-- In the future, this could be exposed by c++:
Interface.PLAYWINDOWSET = 2

Interface.EnableSnapping = true
Interface.ArcaneFocusLevel = 0
Interface.TimeSinceLogin = 0

function Interface.CreatePlayWindowSet()
	--Builds the data for player
	UOBuildTableFromCSV("Data/GameData/playerstats.csv", "PlayerStatsDataCSV")
	
	CreateWindow( "ResizeWindow", true )
	CreateWindow( "MainMenuWindow", false )
	CreateWindow( "SettingsWindow", false )
	CreateWindow( "CharacterAbilities", false )
	CreateWindow( "ItemProperties", false )
	CreateWindow( "MacroWindow", false )	
	CreateWindow( "MenuBarWindow", false )
	CreateWindow( "ContextMenu", false )
	CreateWindow( "ActionsWindow", false )
	CreateWindow( "ActionEditText", false )
	CreateWindow( "ActionEditSlider", false )
	CreateWindow( "ActionEditMacro", false )
	CreateWindow( "ActionEditEquip", false )
	CreateWindow( "ActionEditUnEquip", false )
	CreateWindow( "ActionEditArmDisarm", false )
	CreateWindow( "ActionEditTargetByResource", false )
	CreateWindow( "ActionEditTargetByObjectId", false )
	CreateWindow( "StatusWindow", true)
	CreateWindow( "TargetWindow", false)
	CreateWindow( "MapWindow", false)
	CreateWindow( "RadarWindow", false)
	CreateWindow( "PetWindow", true )
	CreateWindow( "CharacterSheet", false )
	
	CreateWindow( "SkillsWindow", false)
	CreateWindow( "OrganizerWindow", false)
				
	WindowRegisterEventHandler( "Root", SystemData.Events.CHARACTER_SETTINGS_UPDATED, "Interface.RetrieveCharacterSettings")
	WindowRegisterEventHandler( "Root", SystemData.Events.WINDOWS_SETTINGS_UPDATED, "Interface.UpdateWindowsSettings")
	WindowRegisterEventHandler( "Root", SystemData.Events.OPEN_CRIMINAL_NOTIFICATION_GUMP, "Interface.ShowCriminalNotificationGump")
	WindowRegisterEventHandler( "Root", SystemData.Events.SHOW_PARTY_INVITE, "Interface.ShowPartyInvite")
	
	HotbarSystem.Initialize()
	GGManager.Initialize()	
	DamageWindow.Initialize()
	EquipmentData.Initialize()
	HealthBarManager.Initialize()
	ObjectHandleWindow.Initialize()
	OverheadText.InitializeEvents()
  StaticTextWindow.Initialize()
  MapCommon.Initialize()
  QueryWindow.Initialize()
  CreaturesDB.Initialize()
  Organizer.Initialize()
   
  LegacyRunebookLoader.Initialize()
  
  Player.Initialize()
   
  -- Extra UI
  AdvancedBuff.Initialize()
  BuffDebuff.Initialize()
    
	WindowRegisterEventHandler( "Root", SystemData.Events.DEBUGPRINT_TO_CONSOLE, "Interface.OnDebugPrint")
end

function Interface.InitBugReport()
	ToggleWindowByName( "BugReportWindow", "", MainMenuWindow.ToggleBugReportWindow )
end

Interface.oneThreshold = 0
Interface.threeThreshold = 0
Interface.ms250Threshold = 0


Interface.FixedChat = false

function Interface.Update(timePassed)
	Interface.TimeSinceLogin = Interface.TimeSinceLogin + timePassed
	
	-- Pre runs
	ContextMenu.Update(timePassed)
	ContainerWindow.UpdatePickupTimer(timePassed)
	DamageWindow.UpdateTime(timePassed)
	ResizeWindow.Update(timePassed)
	StaticTextWindow.Update( timePassed )
	WindowUtils.Update( timePassed )
	MenuBarWindow.Update(timePassed)
	
	--MapCommon.Update(timePassed)

	-- 250ms Interval
	Interface.ms250Threshold = Interface.ms250Threshold + timePassed
	if Interface.ms250Threshold > 0.25 then
		GumpsParsing.CheckGumpType(Interface.ms250Threshold)
		BuffDebuff.Update(Interface.ms250Threshold)
		HotbarSystem.Update(Interface.ms250Threshold)
		OverheadText.Update(Interface.ms250Threshold)
		
		Item.UpdateMoveItems(Interface.ms250Threshold)
		
		Interface.ms250Threshold = 0
	end 

	-- One second interval runs
	Interface.oneThreshold = Interface.oneThreshold + timePassed
	if Interface.oneThreshold > 1 then
		Interface.oneThreshold = 0
	end 
	
	-- Three second interval runs
	Interface.threeThreshold = Interface.threeThreshold + timePassed
	if Interface.threeThreshold > 3 then
		Interface.threeThreshold = 0
		
		PetWindow.UpdateTimes()
	end 
	
	-- Post runs
	timePassed = 0.0001
	ContextMenu.Update(timePassed)
	ContainerWindow.UpdatePickupTimer(timePassed)
	
	
	-- Single time chat override fix
	if Interface.FixedChat then
		return
	end
	
	if ChatWindow ~= nil then
		--WindowSetShowing("ChatWindow", false)
		
		WindowUnregisterEventHandler("ChatWindow", SystemData.Events.CHAT_ENTER_START)
		WindowUnregisterEventHandler("ChatWindow", SystemData.Events.TEXT_ARRIVED)
		LogDisplayRemoveLog("ChatWindowChatLogDisplay", "Chat")
		DestroyWindow("ChatWindow")
		DestroyWindow("ChatWindowInputTextButton")
		
		Interface.FixedChat = true
	end
end

function Interface.Shutdown()
	EquipmentData.Shutdown()
	HotbarSystem.Shutdown()
	BuffDebuff.Shutdown()
	
	MapCommon.Shutdown()
	UOUnloadCSVTable("PlayerStatsDataCSV")
end

function Interface.OnDebugPrint()
	Debug.PrintToDebugConsole(DebugData.DebugString)
end

function Interface.RetrieveCharacterSettings()
	--WindowUtils.RetrieveWindowSettings()
end

function Interface.UpdateWindowsSettings()
	WindowUtils.SendWindowSettings()
end

function Interface.ShowCriminalNotificationGump()
	local okButton = { textTid = Interface.TID.accept, callback = Interface.AcceptCriminalNotification }
	local cancelButton = { textTid = Interface.TID.cancel, callback = nil }
	local windowData = 
	{
		windowName = "ShowCriminalNotification", 
		titleTid = 1111873, -- "Warning"
		bodyTid = 3000032, -- This may flag you criminal!
		buttons = { okButton, cancelButton }
	}
	UO_StandardDialog.CreateDialog( windowData )	
end

function Interface.ShowPartyInvite()
	CreateWindow( "PartyInviteWindow", true )
end

function Interface.AcceptCriminalNotification()
	AcceptCriminalNotification()		
end