----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

MainMenuWindow = {}
MainMenuWindow.TID ={}
MainMenuWindow.TID.MAIN_MENU	 = 1049755	-- Main Menu
MainMenuWindow.TID.LOG_OUT		 = 3000128	-- Log Out
MainMenuWindow.TID.EXIT_GAME	 = 1077859	-- Exit Game
MainMenuWindow.TID.USER_SETTINGS = 1077814	-- User Settings
MainMenuWindow.TID.BUG_REPORT	 = 1077790	-- Bug Report
MainMenuWindow.TID.HELP          = 1061037  -- Help
MainMenuWindow.TID.MACROS        = 3000172	-- Macros 
MainMenuWindow.TID.ACTIONS       = 1079812	-- Actions 
MainMenuWindow.TID.AGENTS        = 1154762	-- Agents Settings 
MainMenuWindow.TID.UOSTORE     	 = 1157353	-- Ultima Store 


----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

----------------------------------------------------------------
-- MainMenuWindow Functions
----------------------------------------------------------------

-- OnInitialize Handler
function MainMenuWindow.Initialize()
	
	WindowSetAlpha( "MainMenuWindow", 1.00 )
	WindowSetAlpha( "MainMenuWindow", 1.00 )
	
	-- Label & Button Titles
	WindowUtils.SetWindowTitle("MainMenuWindow",GetStringFromTid(MainMenuWindow.TID.MAIN_MENU))
	
	LabelSetText("MainMenuWindowLogOutItemText", GetStringFromTid(MainMenuWindow.TID.LOG_OUT) )
	LabelSetText("MainMenuWindowExitGameItemText", GetStringFromTid(MainMenuWindow.TID.EXIT_GAME) )
	LabelSetText("MainMenuWindowUserSettingsItemText", GetStringFromTid(MainMenuWindow.TID.USER_SETTINGS) )
	LabelSetText("MainMenuWindowAgentsSettingsItemText", GetStringFromTid(MainMenuWindow.TID.AGENTS) )
	LabelSetText("MainMenuWindowMacrosItemText", GetStringFromTid(MainMenuWindow.TID.MACROS) )
	LabelSetText("MainMenuWindowActionsItemText", GetStringFromTid(MainMenuWindow.TID.ACTIONS) )
	LabelSetText("MainMenuWindowHelpItemText", GetStringFromTid(MainMenuWindow.TID.HELP) )
	
	LabelSetText("MainMenuWindowBugReportItemText", GetStringFromTid(MainMenuWindow.TID.BUG_REPORT) )
	
	LabelSetText("MainMenuWindowBugReportItemText", GetStringFromTid(MainMenuWindow.TID.BUG_REPORT) )
	LabelSetText("MainMenuWindowDebugWindowItemText", GetStringFromTid(289))
	
	LabelSetText("MainMenuWindowCWindowItemText", GetStringFromTid(192))
	
	WindowClearAnchors("MainMenuWindow")
	WindowAddAnchor("MainMenuWindow", "center", "ResizeWindow", "center", 100, 0)
	
	--WindowUtils.RestoreWindowPosition("MainMenuWindow")
	WindowSetShowing("MainMenuWindowChrome_UO_WindowCloseButton", false)
	WindowClearAnchors("MainMenuWindowChrome_UO_TitleBar_WindowTitle")
	WindowAddAnchor("MainMenuWindowChrome_UO_TitleBar_WindowTitle", "center", "MainMenuWindowChrome_UO_TitleBar", "center", 0, 0 )

end

-- OnShutdown Handler
function MainMenuWindow.Shutdown()
	MainMenuWindow.notnow = nil
end

function MainMenuWindow.OnShown()
    AnimatedImageStartAnimation( "MainMenuWindowFlamestrike", 1, true, false, 0.0 ) 
end

function MainMenuWindow.OnLogOut()	
	-- Broadcast the event
	if (Interface.CanLogout > Interface.TimeSinceLogin) then

		local okayButton = { textTid=UO_StandardDialog.TID_OKAY , callback=function()BroadcastEvent( SystemData.Events.LOG_OUT )end }
		local cancelButton = { text=GetStringFromTid(UO_StandardDialog.TID_CANCEL)}
		local DestroyConfirmWindow = 
		{
		    windowName = "LogOutWarning",
			titleTid = 1155274,
			bodyTid  = 1155273 ,
			buttons = { okayButton, cancelButton },
			closeCallback = cancelButton.callback,
			destroyDuplicate = true,
		}
		UO_StandardDialog.CreateDialog(DestroyConfirmWindow)	
		WindowSetDimensions("LogOutWarningDialog", 350, 300)
		return
	end
	BroadcastEvent( SystemData.Events.LOG_OUT )
end

function MainMenuWindow.OnOpenUserSettings()	
	ToggleWindowByName("SettingsWindow")
	WindowSetShowing("MainMenuWindow",false)
end

function MainMenuWindow.OnOpenMacros()	
	ToggleWindowByName("MacroWindow")
	WindowSetShowing("MainMenuWindow",false)
end

function MainMenuWindow.OnOpenActions()	
	ToggleWindowByName("ActionsWindow")
	WindowSetShowing("MainMenuWindow",false)
end

function MainMenuWindow.OnOpenBugReportItem()	
	ToggleWindowByName("BugReportWindow")
	WindowSetShowing("MainMenuWindow",false)
end

function MainMenuWindow.OnOpenHelp()
    BroadcastEvent( SystemData.Events.REQUEST_OPEN_HELP_MENU )
	WindowSetShowing("MainMenuWindow",false)
end

function MainMenuWindow.OnOpenUOStore()
    BroadcastEvent( SystemData.Events.UO_STORE_REQUEST )
	WindowSetShowing("MainMenuWindow",false)
end

function MainMenuWindow.ToggleSettingsWindow()	
	ToggleWindowByName("SettingsWindow")	
end

function MainMenuWindow.ToggleBugReportWindow()	
	ToggleWindowByName("BugReportWindow")	
end

function MainMenuWindow.OnToggleAgentsSettings()
	ToggleWindowByName("OrganizerWindow")	
	WindowSetShowing("MainMenuWindow",false)
end

function MainMenuWindow.OnToggleDebugWindow()	
	ToggleWindowByName("MountsListWindow")	
	WindowSetShowing("MainMenuWindow",false)
end

function MainMenuWindow.OnToggleCreditsWindow()	
	ToggleWindowByName("CreditsWindow")	
	WindowSetShowing("MainMenuWindow",false)
end