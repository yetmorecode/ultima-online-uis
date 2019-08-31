----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

SkillsWindow = { }

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

-- TIDs
-- TODO: Add TIDs for each of the skill groups - TODO - remove all of these, except for TID_SKILLS

TID_SKILLS = 3000084
TID_SKILLINCREASE_TOK = 3000260 --"Your skill in ~1skillname~ has increased by ~2changeamount~.  It is now ~3newvalue~."
TID_SKILLDECREASE_TOK = 3000261 --"Your skill in ~1skillname~ has decreased by ~2changeamount~.  It is now ~3newvalue~."

-- Contents and order for each page. The numbers are the skills
-- as assigned in /Runtime/GameData/skilldata.csv
local tab1 = { 7,  22, 28, 53 } -- misc
local tab2 = { 2, 5, 18, 21, 23, 31, 40, 50, 51, 58, 54 } -- combat
local tab3 = { 1, 6, 8, 11, 12, 14, 20, 27, 30, 35, 52, 55 } -- trade
local tab4 = { 9, 13, 17, 32, 33, 34, 38, 39, 46, 47, 37, 26 } -- magic
local tab5 = { 3, 4, 10, 19, 24, 56, 57 } -- wild
local tab6 = { 15, 25, 29, 42, 44, 45, 48, 49 } -- thief
local tab7 = { 16, 36, 41, 43 } -- bard
local tabContents = { tab1, tab2, tab3, tab4, tab5, tab6, tab7 }
SkillsWindow.maxskill_index = 57

SkillsWindow.CUSTOM_TAB_NUM = 8
SkillsWindow.ContextReturnCodes = {}
SkillsWindow.ContextReturnCodes.ADD_TO_CUSTOM = 1
SkillsWindow.ContextReturnCodes.REMOVE_CUSTOM = 2
SkillsWindow.ContextReturnCodes.ASSIGN_KEY = 3
SkillsWindow.ContextReturnCodes.TARGET_SELF = 5
SkillsWindow.ContextReturnCodes.TARGET_CURRENT = 6
SkillsWindow.ContextReturnCodes.TARGET_CURSOR = 7
SkillsWindow.ContextReturnCodes.TARGET_OBJECT_ID = 8
SkillsWindow.ContextReturnCodes.TARGET_MOUSEOVER = 9
SkillsWindow.ContextReturnCodes.SET_AUTOLOCK = 10
SkillsWindow.ContextReturnCodes.CLEAR_AUTOLOCK = 11
SkillsWindow.TID_ADD_TO_CUSTOM = 1078498
SkillsWindow.TID_REMOVE_CUSTOM = 1078499
SkillsWindow.TID_CUSTOM_HELP = 1078500
SkillsWindow.NUM_SKILLS_PER_TAB = 12

SkillsWindow.SessionGains = {}
SkillsWindow.ROT = {}

SkillsWindow.RegisterComplete = false

-- boolean to make sure we have initialized the window 
local SkillsWindowInitialized = 0

-- this gets set equal to WindowData.SkillsWindow[id] 
local data = 0

-- SkillDataMode 0 = real skill value, 1 = skill with mods
SkillsWindow.SkillDataMode = 0

-- SkillCapMode  0 = don't show skill caps, 1 = show skill caps
SkillsWindow.SkillCapMode = 0

-- SkillsTracker  0 = don't show Skills Tracker, 1 = show Skills Tracker
SkillsWindow.SkillsTrackerMode = 0

local oldSkillValues = {}
local hasSkillValues = false

SkillsWindow.Delta = 0

SkillsWindow.SkillTargetVals = {}

SkillsWindow.MaxSkillCap = 720

----------------------------------------------------------------
-- MainMenuWindow Functions
----------------------------------------------------------------

function SkillsWindow.InitializeRot()
	SkillsWindow.RotInitialized = true	
	SkillsWindow.ROT = LoadSaveStructureWithPlayerID(SkillsWindow.RotSaved)
end

-- OnInitialize Handler
function SkillsWindow.Initialize()
	--Debug.PrintToDebugConsole(L"SkillsWindow.Initialize")

	if SkillsWindowInitialized == 1 then
		--Debug.PrintToDebugConsole(L"SkillsWindow.Initialize: already initialized, returning")
		return
	end

	--Debug.PrintToDebugConsole(L"SkillsWindow.Initialize: WindowData.SkillsCSV[1].ID =  "..towstring(tostring(WindowData.SkillsCSV[1].ID)))
	--Debug.PrintToDebugConsole(L"SkillsWindow.Initialize: WindowData.SkillsCSV[1].NameTid =  "..towstring(tostring(WindowData.SkillsCSV[1].NameTid)))
	--Debug.PrintToDebugConsole(L"SkillsWindow.Initialize: WindowData.SkillsCSV[1].ShowIcon =  "..towstring(tostring(WindowData.SkillsCSV[1].ShowIcon)))
	
	WindowRegisterEventHandler("SkillsWindow", SystemData.Events.TOGGLE_SKILLS_TRACKER_WINDOW, "SkillsWindow.SkillsTrackerToggleLButtonUp")
	
	local this = "SkillsWindow"
	
	tabContents[SkillsWindow.CUSTOM_TAB_NUM] = SystemData.Settings.Interface.CustomSkills
    
    SkillsWindow.SkillCapMode = (SystemData.Settings.Interface.SkillsWindowShowCaps and 1 or 0)
    SkillsWindow.SkillDataMode = (SystemData.Settings.Interface.SkillsWindowShowModified and 1 or 0)
	
	local id = SystemData.DynamicWindowId
	WindowSetId(this, id)

	if (WindowData.SkillsWindow ~= nil) then
		data = WindowData.SkillsWindow[id]
	end
		
	WindowRegisterEventHandler( this, WindowData.SkillDynamicData.Event, "SkillsWindow.UpdateSkill")
	
	WindowUtils.SetActiveDialogTitle(GetStringFromTid(TID_SKILLS))

	--ButtonSetText( "SkillsWindowTabButton1", L"MISC" )
	ButtonSetText( "SkillsWindowTabButton1", GetStringFromTid(1078117) )  -- "Misc"
	--Debug.PrintToDebugConsole(L"SkillsWindow.Initialize: Misc tab name =  "..GetStringFromTid(1077759))

	ButtonSetText( "SkillsWindowTabButton2", GetStringFromTid(1077760) ) -- "Combat"
	ButtonSetText( "SkillsWindowTabButton3", GetStringFromTid(1077761) ) -- "Trade"
	ButtonSetText( "SkillsWindowTabButton4", GetStringFromTid(1077762) ) -- "Magic"
	ButtonSetText( "SkillsWindowTabButton5", GetStringFromTid(1077763) ) -- "Wild"
	--ButtonSetText( "SkillsWindowTabButton6", GetStringFromTid(1077764) ) -- "Thieving"
	ButtonSetText( "SkillsWindowTabButton6", GetStringFromTid(1078116) ) -- "Thief"
	ButtonSetText( "SkillsWindowTabButton7", GetStringFromTid(1077765) ) -- "Bard"
	ButtonSetText( "SkillsWindowTabButton8", GetStringFromTid(1077766) ) -- "Custom"

	ButtonSetText( "SkillsWindowSkillsLock", GetStringFromTid(1154796))
	ButtonSetText( "SkillsWindowSkillsDown", GetStringFromTid(1154797))
	
	-- Set the active tab to "MISC"
	data = {}
	data.activeTab = Interface.LoadSetting("SkillTab", 1)
	SkillsWindow.CurrentTab = data.activeTab
	data.numTabs = #tabContents
	--Debug.PrintToDebugConsole(L"SkillsWindow.Initialize: data.numTabs =  "..towstring(tostring(data.numTabs)))

	SkillsWindowInitialized = 1
	
	WindowName = "SkillsWindow"
	showing = WindowGetShowing(WindowName)
	if (showing) then
		--Debug.PrintToDebugConsole(L"SkillsWindow.Initialize: calling ShowTab() ")
		SkillsWindow.ShowTab(data.activeTab)
	end	
	
	SkillsWindow.UpdateSkillValueTypeToggleButtonText()	
	SkillsWindow.UpdateSkillCapToggleButtonText()
	SkillsWindow.UpdateSkillsTrackerToggleButtonText()
	
	SkillsWindow.UpdateTotalSkillPoints()
	WindowUtils.RestoreWindowPosition("SkillsWindow")
	
	hasSkillValues = false
	
	LabelSetText("SkillsWindowCustomHelp",GetStringFromTid(SkillsWindow.TID_CUSTOM_HELP))
	WindowSetShowing("SkillsWindowCustomHelp", false)
	
	for i=1,58 do
		SkillsWindow.SkillTargetVals[i] = Interface.LoadSetting("SkillTargetVals_"..i, nil, 0)
	end
end


function SkillsWindow.UpdateTotalSkillPoints()
	--	Debug.PrintToDebugConsole(L"SkillsWindow.UpdateTotalSkillPoints")
	local SkillPointsUsed = 0
	for i=0,SkillsWindow.maxskill_index do
		if WindowData.SkillDynamicData and WindowData.SkillDynamicData[i] then
			SkillPointsUsed = SkillPointsUsed + WindowData.SkillDynamicData[i].RealSkillValue
		end
	end
	SkillPointsUsed = SkillPointsUsed / 10

	local SkillPointsUsedStr = string.format("%.0f", SkillPointsUsed) -- truncate off any decimal places
	
	LabelSetText("SkillsWindowTotalSkillPoints", GetStringFromTid(1077767)..towstring(SkillPointsUsedStr)..L"/"..towstring(tostring(SkillsWindow.MaxSkillCap))) -- "Skill Points Used: "
end

function SkillsWindow.DoNothing()
	local doNothing = 0
end

function SkillsWindow.ToggleSkillsWindow()
	--Debug.PrintToDebugConsole(L"SkillsWindow.ToggleSkillsWindow")
	
	if SkillsWindowInitialized == 0 then
		-- error
		Debug.PrintToDebugConsole(L"SkillsWindow.ToggleSkillsWindow: window not initialized, returning")
		return
	end
	
	ToggleWindowByName("SkillsWindow")

	WindowName = "SkillsWindow"
	showing = WindowGetShowing(WindowName)
	if (showing) then
		--Debug.PrintToDebugConsole(L"SkillsWindow.ToggleSkillsWindow: data.activeTab = "..towstring(tostring(data.activeTab)))
		--Debug.PrintToDebugConsole(L"SkillsWindow.ToggleSkillsWindow: data.numTabs = "..towstring(tostring(data.numTabs)))
		--Debug.PrintToDebugConsole(L"SkillsWindow.ToggleSkillsWindow: calling UpdateSkill() ")
		SkillsWindow.UpdateAllSkills()
	end	
end

function SkillsWindow.OnUpdate(timepassed)
	SkillsWindow.Delta = SkillsWindow.Delta + timepassed
	if SkillsWindow.Delta >= 1 then
		SkillsWindow.ShowTab(SkillsWindow.CurrentTab)
		SkillsWindow.Delta = 0
	end
end

-- Makes all the other tabs selectable
function SkillsWindow.EnableAllTabs(parent)
	--Debug.PrintToDebugConsole(L"SkillsWindow.EnableAllTabs "..towstring(tostring(data.numTabs)))

	for i = 1, data.numTabs do
		tabName = parent.."TabButton"..i
		WindowSetShowing(tabName.."Tab", true)
		ButtonSetDisabledFlag(tabName, false)
	end
end

-- Makes the current tab the live one, and unselectable
function SkillsWindow.DisableTab(parent, tabNum)
	--Debug.PrintToDebugConsole(L"SkillsWindow.DisableTab ")

	-- TODO -- make sure the tab number passed in is a valid tab
	
	tabName = parent.."TabButton"..tostring(tabNum)

	--Debug.PrintToDebugConsole(L"SkillsWindow.DisableTab: window name =  "..towstring(tabName))
	WindowSetShowing(tabName.."TabSelected", true)
	ButtonSetDisabledFlag(tabName, true);
end
	
function SkillsWindow.UpdateAllSkills()

	SkillsWindow.CheckAllSkillsForUpdate()
	SkillsWindow.SaveCurrentSkillValues()

	if not SkillsWindow.RegisterComplete then
		return
	end
	
	WindowName = "SkillsWindow"
	showing = WindowGetShowing(WindowName)
	if (showing) then
		SkillsWindow.ShowTab(data.activeTab)
		SkillsWindow.UpdateTotalSkillPoints()
	end
end
	
-- Called when a minimodel event causes a refresh
function SkillsWindow.UpdateSkill()

	local skillId = WindowData.UpdateInstanceId
	if SkillsWindow.CheckSkillForUpdate(skillId) then
		SkillsWindow.SaveCurrentSkillValue(skillId)
		
		-- if updateOff is on then don't try and draw the active tab stuff.
		if not SkillsWindow.RegisterComplete then
			return
		end
		
		WindowName = "SkillsWindow"
		showing = WindowGetShowing(WindowName)
		if (showing) then
			SkillsWindow.ShowTab(data.activeTab)
			SkillsWindow.UpdateTotalSkillPoints()
		end
	end
end

-- Force the active tab to be something
function SkillsWindow.ForceActiveTabSetting (tabnum)
	--Debug.PrintToDebugConsole(L"SkillsWindow.ForceActiveTabSetting tabnum = "..towstring(tostring(tabnum)))

	data.activeTab = tabnum
	SkillsWindow.CurrentTab = data.activeTab
end

-- Refresh the current page and fetch the skill data
function SkillsWindow.ShowTab(tabnum)
	--Debug.PrintToDebugConsole(L"SkillsWindow.ShowTab ")

	WindowName = "SkillsWindow"
	showing = WindowGetShowing(WindowName)
	if (showing) then
		doNothing = 0
	else
		--Debug.PrintToDebugConsole(L"SkillsWindow.ShowTab(): aborting because window ain't open ")
		do return end
	end
	
	local this = "SkillsWindow"

	-- Make sure we always display something    
	if tabnum == nil then
		--Debug.PrintToDebugConsole(L"SkillsWindow.ShowTab(): Forcing tabnum = 1 ")
		tabnum = 1
		SkillsWindow.ForceActiveTabSetting (tabnum)
	end

	-- Update tab buttons to highlight the correct one
	SkillsWindow.EnableAllTabs(this)
	SkillsWindow.DisableTab(this, tabnum)

	-- Hide all tab windows
	for i=1, data.numTabs do
		local tabWindowName = "SkillsWindowTabWindow"..tostring(i)
		WindowSetShowing(tabWindowName, false)
	end

	-- Change the active tab if needed
	if data.activeTab ~= tabnum then
		--Debug.PrintToDebugConsole(L"SkillsWindow.ShowTab():Changing tabnum from = "..towstring(tostring(data.activeTab))..L"to "..towstring(tostring(data.tabnum)))
		
		data.activeTab = tabnum
		SkillsWindow.CurrentTab = data.activeTab
		Interface.SaveSetting("SkillTab", tabnum)
	end

	-- show selected tab window
	local tabWindowName = "SkillsWindowTabWindow"..tostring(tabnum)
	WindowSetShowing(tabWindowName, true)
	
	-- Force a refetch of data and a redraw of the tab
	-- Fill out all the information for each skill
	local activeContents = tabContents[tabnum]
	numItemsInTab = #activeContents
	--Debug.PrintToDebugConsole(L"SkillsWindow.ShowTab():numItemsInTab = "..towstring(tostring(numItemsInTab)))
	
	for i=1,SkillsWindow.NUM_SKILLS_PER_TAB do
		local base = "SkillsWindowTabWindow"..tostring(tabnum).."Entry"..tostring(i)

		if i <= numItemsInTab then
			local skillId = activeContents[i]

			local serverId = WindowData.SkillsCSV[skillId].ServerId
			
			local iconPath = base .. "IconGraphic"
			local namePath = base .. "Name"
			local titlePath = base .. "Title"
			local valuePath = base .. "Value"
			local bindingPath = base .. "Hotkey"
			local ROTPath = base .. "ROT"
			local buttonPath = base .. "SkillStateButton"
			local helpPath = base .. "HelpButton"
			
			-- Fetch the information
			local iconId = WindowData.SkillsCSV[skillId].IconId
			
			--Debug.PrintToDebugConsole(L"SkillsWindow.ShowTab():i = "..towstring(tostring(i)))
			--Debug.PrintToDebugConsole(L"SkillsWindow.ShowTab():iconId = "..towstring(tostring(iconId )))
			--Debug.PrintToDebugConsole(L"SkillsWindow.ShowTab():skillId = "..towstring(tostring(skillId)))
			--Debug.PrintToDebugConsole(L"SkillsWindow.ShowTab():i = "..towstring(tostring(i)))
			
			local iconTexture, x, y = GetIconData(iconId)
			local displayName = GetStringFromTid(WindowData.SkillsCSV[skillId].NameTid)	
			
			local skillLevel = nil
			if (SkillsWindow.SkillDataMode == 0) then
				skillLevel = GetSkillValue(serverId, false)
			else
				skillLevel = GetSkillValue(serverId, true)
			end
			
			local skillLevelCap = WindowData.SkillDynamicData[serverId].SkillCap

			if (SkillsWindow.SkillTargetVals[serverId]) then
				skillLevelCap = SkillsWindow.SkillTargetVals[serverId]
				
			end

			local skillState = WindowData.SkillDynamicData[serverId].SkillState

			--Debug.PrintToDebugConsole(L"SkillsWindow.ShowTab():skill = "..towstring(tostring(skillLevel)))
			--Debug.PrintToDebugConsole(L"SkillsWindow.ShowTab():cap = "..towstring(tostring(skillLevelCap)))

			-- Display the information
			DynamicImageSetTexture(iconPath, iconTexture, x, y)
			DynamicImageSetTexture(iconPath.."BG", MiniTexturePack.DB[Interface.Settings.MTP_Current].texture .. "Icon", 0, 0 )
			
			--Debug.PrintToDebugConsole(L"SkillsWindow.ShowTab():iconPath = "..towstring(iconPath))
			
			local titleString = SkillsWindow.GetSkillTitle (WindowData.SkillDynamicData[serverId].RealSkillValue)
			--Debug.PrintToDebugConsole(L"SkillsWindow.ShowTab():titleString = "..titleString)

			LabelSetText(namePath, displayName)
			LabelSetText(titlePath, titleString)
			

			-- Clean up the number so it works as a percentage
			local skillFormatted = SkillsWindow.FormatSkillValue(skillLevel)
			if (SkillsWindow.SkillCapMode == 0) then
				if skillLevel ~= nil then
					LabelSetText(valuePath, skillFormatted..L"%")		
				else
					-- This shouldn't happen unless it misregisters the skills
					LabelSetText(valuePath, L"---.-%")
				end	
			else	
				-- want to show skill caps	
				local capFormatted = SkillsWindow.FormatSkillValue(skillLevelCap / 10)
				if skillLevel ~= nil then
					LabelSetText(valuePath, skillFormatted..L"/"..capFormatted..L"%")		
				else
					-- This shouldn't happen unless it misregisters the skills
					LabelSetText(valuePath, L"---.-/---.-%")
				end
			end

			-- updating the key binding text
			if (WindowData.SkillsCSV[skillId].DragIcon == 1) then
				local macroId = MacroWindow.GetMacroId(L"SkillHotkey" .. serverId)
				local bindingStr = UserActionMacroGetBinding(SystemData.MacroSystem.STATIC_MACRO_ID,macroId)
				
				if (macroId ~= 0 and IsValidWString(bindingStr)) then
					--LabelSetText(currentMacroWindowName.."Binding",bindingStr)
					LabelSetTextColor( bindingPath, 243, 227, 49 )
					MacroWindow.UpdateBindingText(bindingPath,bindingStr)
				else
					LabelSetTextColor( bindingPath, 243, 227, 49 )
					LabelSetText(bindingPath,GetStringFromTid(MacroWindow.TID_NO_KEYBINDING) )
				end	
			else
				LabelSetText(bindingPath,GetStringFromTid(MacroWindow.TID_NO_KEYBINDING) )
				WindowSetShowing(bindingPath, false)
			end
			
			-- updating rot timer
			if Interface.SiegeRules then
				LabelSetText(ROTPath, L"")
				if not SkillsWindow.ROT then
					SkillsWindow.RotSaved = CreateSaveStructureWithPlayerID(SkillsWindow.RotSaved)
					SkillsWindow.InitializeRot()
				end
				if SkillsWindow.ROT[serverId] then
					local seconds = SkillsWindow.ROT[serverId] - Interface.Clock.Timestamp
									
					if seconds > 0 then
						local min = math.floor(seconds/60)
						if min > 0 then
							local prefix = ""
							if (seconds - (min * 60) > 0) then
								prefix = ">"
							end
							timer = towstring(prefix .. tostring(min)	.. "m")
						else
							timer = towstring(tostring(seconds)	.. "s")
						end
						
						LabelSetText(ROTPath, L"ROT: " .. timer)
					end
				end
			end
			
			-- for the main icon button
			WindowSetId(base.."Icon", i)	-- Make sure the button knows which one it is
			--Debug.PrintToDebugConsole(L"SkillsWindow.ShowTab():button name = "..towstring(base.."Icon"))
			--Debug.PrintToDebugConsole(L"SkillsWindow.ShowTab():button id = "..towstring(tostring(i)))

			-- for the skill state button and help button
			WindowSetId(buttonPath, i)	-- Make sure the button knows which one it is
			WindowSetId(helpPath, i)
			--Debug.PrintToDebugConsole(L"SkillsWindow.ShowTab():button name = "..towstring(buttonPath))
			--Debug.PrintToDebugConsole(L"SkillsWindow.ShowTab():button id = "..towstring(tostring(i)))

			SkillsWindow.SetStateButton(buttonPath, skillState)
			
			WindowSetShowing(base, true)
		else
			-- Don't show empty skill entries
			WindowSetShowing(base, false)
		end
	end
	
	-- show help text if this is custom tab and its empty
	if (data.activeTab == SkillsWindow.CUSTOM_TAB_NUM and numItemsInTab == 0) then
		WindowSetShowing("SkillsWindowCustomHelp", true)
	else
		WindowSetShowing("SkillsWindowCustomHelp", false)
	end
end

-- OnShutdown Handler
function SkillsWindow.Shutdown()
	for i=0,SkillsWindow.maxskill_index do  
		UnregisterWindowData(WindowData.SkillDynamicData.Type, i)
	end
	
	WindowUtils.SaveWindowPosition("SkillsWindow")	
end

-- OnLButtonDown Handler
function SkillsWindow.SkillLButtonDown(flags)
    if (SystemData.DragItem.DragType == SystemData.DragItem.TYPE_NONE) then
	    -- Player is dragging an icon

	    -- button number is its location on the screen (1 = top of left column, 2 = 2nd in left column, etc with left column done first before starting through the right column)
	    local buttonNum = WindowGetId( SystemData.ActiveWindow.name)

	    local tab = data.activeTab
	    local activeContent = tabContents[tab]
    	
	    -- skillIndex is the line index in the csv file for this skill
	    local skillIndex = activeContent[buttonNum]
	    local skillId = WindowData.SkillsCSV[skillIndex].ServerId
	    local iconId = WindowData.SkillsCSV[skillIndex].IconId
    	
	    --Debug.PrintToDebugConsole(L"SkillsWindow.SkillLButtonDown(): iconId = "..towstring(tostring(iconId)))
    	
	    if (WindowData.SkillsCSV[skillIndex].DragIcon == 1) then
		    if (skillId ~= nil) then	
				if flags == WindowUtils.ButtonFlags.CONTROL then

					-- get the blockbar id
					local blockBar = HotbarSystem.SpawnNewHotbar(_, 1, true)
					
					-- adding the ability to the blockbar
					HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_SKILL, skillId,iconId, blockBar,  1)
					
					-- forcing the blockbar to follow the mouse cursor
					WindowUtils.FollowMouseCursor("Hotbar" .. blockBar, Hotbar.BUTTON_SIZE, Hotbar.BUTTON_SIZE, -30, -15, false, true, true)

					-- setting the window movable
					WindowSetMoving("Hotbar" .. blockBar, true)
					
				else		
					DragSlotSetActionMouseClickData(SystemData.UserAction.TYPE_SKILL,skillId,iconId)
				end
		    end
	    else
		    --Debug.PrintToDebugConsole(L"SkillsWindow.SkillLButtonDown(): Not allowed to drag index = "..towstring(tostring(skillIndex)))
	    end
	end       
end

-- OnLButtonUP Handler
function SkillsWindow.SkillsLockLButtonUp()
	if (not SkillsWindow.LockAll and not SkillsWindow.DownAll) then
		SkillsWindow.CurrentIndex = 1
		SkillsWindow.LockAll = true
	end
end
function SkillsWindow.SkillsDownLButtonUp()
	if (not SkillsWindow.LockAll and not SkillsWindow.DownAll) then
		SkillsWindow.CurrentIndex = 1
		SkillsWindow.DownAll = true
	end
end

function SkillsWindow.LockSkills()
	if (SkillsWindow.LockAll) then
		if (SkillsWindow.CurrentIndex > 0 and SkillsWindow.CurrentIndex < 59) then
			local serverId = WindowData.SkillsCSV[SkillsWindow.CurrentIndex].ServerId
			WindowData.SkillDynamicData[serverId].SkillState = 2
			ReturnWindowData.SkillSystem.SkillId = serverId
			ReturnWindowData.SkillSystem.SkillButtonState = 2
			BroadcastEvent(SystemData.Events.SKILLS_ACTION_SKILL_STATE_CHANGE)
			SkillsWindow.CurrentIndex = SkillsWindow.CurrentIndex  + 1
		else
			SkillsWindow.CurrentIndex = -1
			SkillsWindow.LockAll = false
			SkillsWindow.ShowTab(SkillsWindow.CurrentTab)
		end
	end
end

function SkillsWindow.DownSkills()
	if (SkillsWindow.DownAll) then
		if (SkillsWindow.CurrentIndex > 0 and SkillsWindow.CurrentIndex < 59) then
			local serverId = WindowData.SkillsCSV[SkillsWindow.CurrentIndex].ServerId
			WindowData.SkillDynamicData[serverId].SkillState = 1
			ReturnWindowData.SkillSystem.SkillId = serverId
			ReturnWindowData.SkillSystem.SkillButtonState = 1
			BroadcastEvent(SystemData.Events.SKILLS_ACTION_SKILL_STATE_CHANGE)
			SkillsWindow.CurrentIndex = SkillsWindow.CurrentIndex  + 1
		else
			SkillsWindow.CurrentIndex = -1
			SkillsWindow.DownAll = false
			SkillsWindow.ShowTab(SkillsWindow.CurrentTab)
		end
	end
end

-- OnLButtonUP Handler
function SkillsWindow.SkillLButtonUp()
	-- Player is using a skill by single clicking on an icon

	--Debug.PrintToDebugConsole(L"SkillsWindow.SkillLButtonUp()")
	--Debug.PrintToDebugConsole(L"SkillsWindow.SkillLButtonUp(): window name = "..towstring(SystemData.ActiveWindow.name))

	local buttonNum = WindowGetId( SystemData.ActiveWindow.name)
	--Debug.PrintToDebugConsole(L"SkillsWindow.SkillLButtonUp(): button = "..towstring(tostring(buttonNum)))

	-- button number is its location on the screen (1 = top of left column, 2 = 2nd in left column, etc with left column done first before starting through the right column)

	local tab = data.activeTab
	--Debug.PrintToDebugConsole(L"SkillsWindow.SkillLButtonDown(): window name = "..towstring(SystemData.ActiveWindow.name))
	local activeContent = tabContents[tab]
	-- skillIndex is the line index in the csv file for this skill
	local skillIndex = activeContent[buttonNum]
	
	local skillId = WindowData.SkillsCSV[skillIndex].ServerId

	--Debug.PrintToDebugConsole(L"SkillsWindow.SkillLButtonDown(): tab = "..towstring(tostring(tab)))
	--Debug.PrintToDebugConsole(L"SkillsWindow.SkillLButtonDown(): skillIndex = "..towstring(tostring(skillIndex)))
	--Debug.PrintToDebugConsole(L"SkillsWindow.SkillLButtonDown(): skillId = "..towstring(tostring(skillId)))
	
	-- if the skill icon is not dragable, then it can't be directly used
	if (WindowData.SkillsCSV[skillIndex].DragIcon == 1) then
		SkillsWindow.UseSkill(skillId)
	else
	    PrintTidToChatWindow(500014,SystemData.ChatLogFilters.SYSTEM)
	end		
end

function SkillsWindow.UseSkill(skillId)
	-- skillId is the server id for the skill
	--Debug.PrintToDebugConsole(L"SkillsWindow.UseSkill(): serverId = "..towstring(tostring(skillId)))
	UserActionUseSkill(skillId)
end

-- OnMouseOver Handler
function SkillsWindow.SkillMouseOver()
	local buttonNum = WindowGetId( SystemData.ActiveWindow.name)
	local tab = data.activeTab
	local activeContent = tabContents[tab]
	local skillIndex = activeContent[buttonNum]
	
	-- NOTE: Need to fix this. Id 0 is also a null check, so no tooltip for Alchemy
	local skillId = WindowData.SkillsCSV[skillIndex].ServerId + 1

	local serverId = WindowData.SkillsCSV[skillIndex].ServerId

	local macroId = MacroWindow.GetMacroId(L"SkillHotkey" .. serverId)
	local bindingText = UserActionMacroGetBinding(SystemData.MacroSystem.STATIC_MACRO_ID,macroId)
	local targetText = L""
	if (macroId ~= 0 and IsValidWString(bindingText)) then
		bindingText = L"\n" .. GetStringFromTid(Hotbar.TID_BINDING).. L" " .. bindingText

		local slotWindow = "Macro_" .. macroId .. "_1"
		local targetType = UserActionGetTargetType(SystemData.MacroSystem.STATIC_MACRO_ID, macroId, 1, slotWindow)

		targetText = GetStringFromTid(Hotbar.TID_TARGET) -- "Target:"
		if targetType == 1 then -- Current
			targetText = targetText..L" "..GetStringFromTid(HotbarSystem.TID_CURRENT)
		elseif targetType == 2 then -- Cursor
			targetText = targetText..L" "..GetStringFromTid(HotbarSystem.TID_CURSOR)
		elseif targetType == 3 then -- Self
			targetText = targetText..L" "..GetStringFromTid(HotbarSystem.TID_SELF)
		elseif targetType == 4 then -- Object Id
			targetText = targetText..L" "..GetStringFromTid(HotbarSystem.TID_OBJECT_ID)
		elseif targetType == 5 then -- Mouse Over
			targetText = targetText..L" "..GetStringFromTid(280)
		else
			targetText = L"" -- Bad case; forget about it.
		end
	end

	local itemData = { windowName = this,
						itemId = skillId,
						itemType = WindowData.ItemProperties.TYPE_ACTION,
						actionType = SystemData.UserAction.TYPE_SKILL,
						binding = bindingText, -- As defined above
						myTarget = targetText,
						detail = ItemProperties.DETAIL_LONG }
	ItemProperties.SetActiveItem(itemData)
end

-- Tab Handler
function SkillsWindow.ToggleTab()
	-- Get the number of the tab clicked, which should be the last character of its name
	-- NOTE: Obviously, this won't work if you have more than ten tabs
	tab_clicked = tonumber (string.sub( SystemData.ActiveWindow.name, -1, -1))
	SkillsWindow.ShowTab(tab_clicked)
	currentTab = tab_clicked  
end

-- Returns the graphic for the skill state button based on the state
function SkillsWindow.SetStateButton(button, val)
	if val == 0 then
	    WindowSetDimensions(button, 22, 22)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL, "arrowup", 0, 0)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED, "arrowup", 0, 0)		
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, "arrowup", 24, 0)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "arrowup", 24, 0)		
	elseif val == 1 then
	    WindowSetDimensions(button, 22, 22)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL, "arrowdown", 0, 0)		
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED, "arrowdown", 0, 0)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "arrowdown", 24 , 0)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, "arrowdown", 24 , 0)
	elseif val == 2 then
	    WindowSetDimensions(button, 22, 22)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL, "Lock_Button", 0, 0)
		ButtonSetTexture(button,InterfaceCore.ButtonStates.STATE_PRESSED, "Lock_Button", 0, 0)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "Lock_Button", 24, 0)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, "Lock_Button", 24, 0)
	end
end

-- Cycle through the states of the skill state button (Up, Down, Lock)
function SkillsWindow.CycleLButtonUp()
	--Debug.PrintToDebugConsole(L"SkillsWindow.CycleLButtonUp():")
	tab = data.activeTab
	buttonNum = WindowGetId(SystemData.ActiveWindow.name)
	activeContent = tabContents[tab]
	skillId = activeContent[buttonNum]
	
	local state = WindowData.SkillDynamicData[WindowData.SkillsCSV[skillId].ServerId].SkillState
	--Debug.PrintToDebugConsole(L"SkillsWindow.CycleLButtonUp():window name = "..towstring(SystemData.ActiveWindow.name))
	--Debug.PrintToDebugConsole(L"SkillsWindow.CycleLButtonUp():tab = "..towstring(tostring(tab)))
	--Debug.PrintToDebugConsole(L"SkillsWindow.CycleLButtonUp():entry = "..towstring(tostring(buttonNum)))
	--Debug.PrintToDebugConsole(L"SkillsWindow.CycleLButtonUp():skill id = "..towstring(tostring(skillId)))
	--Debug.PrintToDebugConsole(L"SkillsWindow.CycleLButtonUp():server id = "..towstring(tostring(WindowData.SkillsCSV[skillId].ServerId)))
	--Debug.PrintToDebugConsole(L"SkillsWindow.CycleLButtonUp():state = "..towstring(tostring(WindowData.SkillDynamicData[WindowData.SkillsCSV[skillId].ServerId].SkillState)))
 
	state = state + 1

	if (state > 2) then
		state = 0
	end
	
	-- CJT - why is the WindowData being changed from the LUA side? -- need to verify if server sends a confirmation
	WindowData.SkillDynamicData[WindowData.SkillsCSV[skillId].ServerId].SkillState = state
	
	buttonPath = "SkillsWindowTabWindow"..tostring(tab).."Entry"..tostring(buttonNum).."SkillStateButton"
	
	SkillsWindow.SetStateButton(buttonPath, state)
	
	-- tell the server that we had a skill state change
	--Debug.PrintToDebugConsole(L"SkillsWindow.CycleLButtonUp():skill = "..towstring(tostring(WindowData.SkillsCSV[skillId].ServerId)))
	--Debug.PrintToDebugConsole(L"SkillsWindow.CycleLButtonUp():state = "..towstring(tostring(state)))


	ReturnWindowData.SkillSystem.SkillId = WindowData.SkillsCSV[skillId].ServerId
	ReturnWindowData.SkillSystem.SkillButtonState = state
	BroadcastEvent(SystemData.Events.SKILLS_ACTION_SKILL_STATE_CHANGE)

	-- do we have the soulstone gump active?
	if DoesWindowExist("SoulstoneGump") and SoulstoneGump.currentGumpData ~= nil then

		-- update the gump
		SoulstoneGump.SetGumpType(SoulstoneGump.currentGumpData)
	end
end

function SkillsWindow.CycleMouseOver()
	local text = GetStringFromTid(1112103)
	local buttonName = SystemData.ActiveWindow.name
	Tooltips.CreateTextOnlyTooltip(buttonName, text)
end

-- Format an integer so it looks like "000.0" 
function SkillsWindow.FormatSkillValue(skillLevel)
	
	return wstring.format(L"%.1f", towstring(skillLevel))
end

function SkillsWindow.GetSkillTitle (skillLevel)

	local titleString = L""
	
	local level = skillLevel/100
	
	if (level > 2) then
		if ((level >= 3) and (level < 4)) then
			titleString = L"("..GetStringFromTid(1077474)..L")" -- "Neophyte"
		elseif ((level >= 4) and (level < 5)) then
			titleString = L"("..GetStringFromTid(1077475)..L")"-- "Novice"
		elseif ((level >= 5) and (level < 6)) then
			titleString = L"("..GetStringFromTid(1077476)..L")" -- "Apprentice"
		elseif ((level >= 6) and (level < 7)) then
			titleString = L"("..GetStringFromTid(1077477)..L")"  -- "Journeyman"
		elseif ((level >= 7) and (level < 8)) then
			titleString = L"("..GetStringFromTid(1077478)..L")" -- "Expert"
		elseif ((level >= 8) and (level < 9)) then
			titleString = L"("..GetStringFromTid(1077479)..L")" -- "Adept"
		elseif ((level >= 9) and (level < 10)) then
			titleString = L"("..GetStringFromTid(1077480)..L")"  -- "Master"
		elseif (level >= 10) and (level < 11)  then
			titleString = L"("..GetStringFromTid(1079309)..L")" -- "Grandmaster"
		elseif (level >= 11) and (level < 12)  then
			titleString = L"("..GetStringFromTid(1079272)..L")" -- "Elder"
		elseif (level >= 12)   then
			titleString = L"("..GetStringFromTid(1079273)..L")" -- "Legendary"
		end		
	end
	
	--Debug.PrintToDebugConsole(L"SkillsWindow.GetSkillTitle():titleString = "..titleString)
	return titleString
end -- function SkillsWindow.GetSkillTitle



function SkillsWindow.SkillValueTypeToggleLButtonUp()
	--Debug.PrintToDebugConsole(L"SkillsWindow.SkillValueTypeToggleLButtonUp():  ")

	if (SkillsWindow.SkillDataMode == 0) then
		SkillsWindow.SkillDataMode = 1
	else
		SkillsWindow.SkillDataMode = 0
	end
    
    SystemData.Settings.Interface.SkillsWindowShowModified = (SkillsWindow.SkillDataMode == 1)

	SkillsWindow.UpdateSkillValueTypeToggleButtonText()	
	SkillsWindow.ShowTab(data.activeTab)
	
	if (DoesWindowExist("SkillsTrackerWindow")) then
		SkillsTracker.Update()
	end
end -- SkillsWindowHidden.SkillValueTypeToggleLButtonUp

function SkillsWindow.UpdateSkillValueTypeToggleButtonText()
	if (SkillsWindow.SkillDataMode == 0) then
		ButtonSetText( "SkillsWindowSkillValueTypeToggleButton", GetStringFromTid(1077768) ) -- "Show Modified"
	else
		ButtonSetText( "SkillsWindowSkillValueTypeToggleButton", GetStringFromTid(1077769) ) -- "Show Real"
	end
end

function SkillsWindow.SkillCapToggleLButtonUp()
	--Debug.PrintToDebugConsole(L"SkillsWindow.SkillValueCapToggleLButtonUp():  ")

	if (SkillsWindow.SkillCapMode == 0) then
		SkillsWindow.SkillCapMode = 1
	else
		SkillsWindow.SkillCapMode = 0
	end
    
    SystemData.Settings.Interface.SkillsWindowShowCaps = (SkillsWindow.SkillCapMode == 1)

	SkillsWindow.UpdateSkillCapToggleButtonText()	
	
	SkillsWindow.ShowTab(data.activeTab)
	
	if (DoesWindowExist("SkillsTrackerWindow")) then
		SkillsTracker.Update()
	end
end -- SkillsWindowHidden.SkillValueCapToggleLButtonUp

function SkillsWindow.UpdateSkillCapToggleButtonText()
	--Debug.PrintToDebugConsole(L"SkillsWindow.UpdateSkillCapToggleButtonText():  SkillCapMode = "..towstring(tostring(SkillsWindow.SkillCapMode)))

	if (SkillsWindow.SkillCapMode == 0) then
		ButtonSetText( "SkillsWindowSkillCapToggleButton", GetStringFromTid(1078113) ) -- "Show Caps"
	else
		ButtonSetText( "SkillsWindowSkillCapToggleButton", GetStringFromTid(1078114) ) -- "Hide Caps"
	end
end

function SkillsWindow.SkillsTrackerToggleLButtonUp()
	if (SkillsWindow.SkillsTrackerMode == 0) then
		SkillsWindow.SkillsTrackerMode = 1
		CreateWindow("SkillsTrackerWindow", true)
	else
		SkillsWindow.SkillsTrackerMode = 0
		DestroyWindow("SkillsTrackerWindow")
	end
	Interface.SaveSetting( "ShowTracker" , SkillsWindow.SkillsTrackerMode == 1 )
	SkillsWindow.UpdateSkillsTrackerToggleButtonText()	
end

function SkillsWindow.UpdateSkillsTrackerToggleButtonText()
	if (SkillsWindow.SkillsTrackerMode == 0) then
		ButtonSetText( "SkillsWindowSkillsTrackerToggleButton", GetStringFromTid(1111937) ) -- "Show Tracker"
		SkillsWindow.SkillsTrackerMode = 0
	else
		ButtonSetText( "SkillsWindowSkillsTrackerToggleButton", GetStringFromTid(1111938) ) -- "Hide Tracker"
		SkillsWindow.SkillsTrackerMode = 1
	end
end

function SkillsWindow.CheckSkillForUpdate(skill)
	if oldSkillValues[skill] ~= nil and WindowData.SkillDynamicData[skill] ~= nil then
		CharacterAbilities.UpdateWeaponAbilities()
		local oldSkillValue = oldSkillValues[skill]
		local newSkillValue = WindowData.SkillDynamicData[skill].RealSkillValue
		local skillId = WindowData.SkillList[skill].CSVId
		local serverId = WindowData.SkillsCSV[skillId].ServerId
		if not SkillsWindow.SessionGains[skill] then
			SkillsWindow.SessionGains[skill] = 0
		end
		if (SkillsWindow.SkillTargetVals[serverId]) then
			if (newSkillValue > SkillsWindow.SkillTargetVals[serverId] and WindowData.SkillDynamicData[WindowData.SkillsCSV[skillId].ServerId].SkillState ~= 1) then
				WindowData.SkillDynamicData[WindowData.SkillsCSV[skillId].ServerId].SkillState = 1
				ReturnWindowData.SkillSystem.SkillId = WindowData.SkillsCSV[skillId].ServerId
				ReturnWindowData.SkillSystem.SkillButtonState = 2
				BroadcastEvent(SystemData.Events.SKILLS_ACTION_SKILL_STATE_CHANGE)
				local skillName = WindowData.SkillList[skill].skillName
			end
			
			if (newSkillValue == SkillsWindow.SkillTargetVals[serverId] and WindowData.SkillDynamicData[WindowData.SkillsCSV[skillId].ServerId].SkillState ~= 2) then
				WindowData.SkillDynamicData[WindowData.SkillsCSV[skillId].ServerId].SkillState = 2
				ReturnWindowData.SkillSystem.SkillId = WindowData.SkillsCSV[skillId].ServerId
				ReturnWindowData.SkillSystem.SkillButtonState = 2
				BroadcastEvent(SystemData.Events.SKILLS_ACTION_SKILL_STATE_CHANGE)
				local skillName = WindowData.SkillList[skill].skillName
			end
			SkillsWindow.ShowTab(data.activeTab)
		end
	
		local oldSkillValue = oldSkillValues[skill] / 10
		local newSkillValue = WindowData.SkillDynamicData[skill].RealSkillValue / 10
		if oldSkillValue > newSkillValue then
			local skillValueDiff = SkillsWindow.FormatSkillValue(oldSkillValue - newSkillValue)..L"%"
			local skillName = WindowData.SkillList[skill].skillName
			local text = ReplaceTokens(GetStringFromTid(TID_SKILLDECREASE_TOK), {skillName, skillValueDiff, SkillsWindow.FormatSkillValue(newSkillValue)..L"%"})
			if (Interface.Settings.chat_useNewChat) then
				local logVal = {text = text, channel = SystemData.ChatLogFilters.SYSTEM, color = Interface.Settings.SpecialColor, sourceId = 0, sourceName = "", ignore = false, category = 0, timeStamp = towstring(string.format("%02.f", Interface.Clock.h) .. ":" .. string.format("%02.f", Interface.Clock.m) .. ":" .. string.format("%02.f", Interface.Clock.s))}
				table.insert(NewChatWindow.Messages, logVal)
				NewChatWindow.UpdateLog()
			else
				PrintWStringToChatWindow(text,SystemData.ChatLogFilters.SYSTEM)
			end
			if (DoesWindowExist("SkillsTrackerWindow")) then
				SkillsTracker.Update()
			end
			
			-- do we have the soulstone gump active?
			if DoesWindowExist("SoulstoneGump") and SoulstoneGump.currentGumpData ~= nil then

				-- update the gump
				SoulstoneGump.SetGumpType(SoulstoneGump.currentGumpData)
			end

			return 1
		end

		if oldSkillValue < newSkillValue then
			local skillValueDiff = SkillsWindow.FormatSkillValue(newSkillValue - oldSkillValue)..L"%"
			local skillName = WindowData.SkillList[skill].skillName
			local text = ReplaceTokens(GetStringFromTid(TID_SKILLINCREASE_TOK), {skillName, skillValueDiff, SkillsWindow.FormatSkillValue(newSkillValue)..L"%"})
			
			if Interface.SiegeRules then 
				if not SkillsWindow.ROT then
					SkillsWindow.RotSaved = CreateSaveStructureWithPlayerID(SkillsWindow.RotSaved)
					SkillsWindow.InitializeRot()
				end
				if newSkillValue < 700 then
					SkillsWindow.ROT[serverId] = nil
				elseif newSkillValue < 800 then
					SkillsWindow.ROT[serverId] = Interface.Clock.Timestamp + 300
				elseif newSkillValue < 900 then
					SkillsWindow.ROT[serverId] = Interface.Clock.Timestamp + 480	
				elseif newSkillValue < 1000 then
					SkillsWindow.ROT[serverId] = Interface.Clock.Timestamp + 720
				elseif newSkillValue < 1200 then
					SkillsWindow.ROT[serverId] = Interface.Clock.Timestamp + 900
				else
					SkillsWindow.ROT[serverId] = nil
				end
			end
			
			if (Interface.Settings.chat_useNewChat) then
				local logVal = {text = text, channel = SystemData.ChatLogFilters.SYSTEM, color = Interface.Settings.SpecialColor, sourceId = 0, sourceName = "", ignore = false, category = 0, timeStamp = towstring(string.format("%02.f", Interface.Clock.h) .. ":" .. string.format("%02.f", Interface.Clock.m) .. ":" .. string.format("%02.f", Interface.Clock.s))}
				table.insert(NewChatWindow.Messages, logVal)
				NewChatWindow.UpdateLog()
			else
				PrintWStringToChatWindow(text,SystemData.ChatLogFilters.SYSTEM)
			end
			if (DoesWindowExist("SkillsTrackerWindow")) then
				SkillsTracker.Update()
			end
			
			if skill == 35 then
				TargetWindow.UpdateButtons()
			end

			-- do we have the soulstone gump active?
			if DoesWindowExist("SoulstoneGump") and SoulstoneGump.currentGumpData ~= nil then

				-- update the gump
				SoulstoneGump.SetGumpType(SoulstoneGump.currentGumpData)
			end
			
			return 1
		end
	else
			SkillsWindow.SaveCurrentSkillValue(skill)
	end
	return 0
end

function SkillsWindow.CheckAllSkillsForUpdate()
	if hasSkillValues then
		for i = 1, #tabContents do

			local tab = tabContents[i]
			
			for i = 1, #tab do

				local skill = tab[i]
				SkillsWindow.CheckSkillForUpdate(WindowData.SkillsCSV[skill].ServerId)
			end
		end
	end
end

function SkillsWindow.SaveCurrentSkillValue(skill)
	oldSkillValues[skill] = WindowData.SkillDynamicData[skill].RealSkillValue
end

function SkillsWindow.SaveCurrentSkillValues()

	hasSkillValues = true
	for i = 1, #tabContents do

		local tab = tabContents[i]
		for i = 1, #tab do

			local skill = tab[i]
			SkillsWindow.SaveCurrentSkillValue(WindowData.SkillsCSV[skill].ServerId)
		end
	end
end

function SkillsWindow.ContextMenuCallback(returnCode,param)
	if returnCode >= SkillsWindow.ContextReturnCodes.ASSIGN_KEY and returnCode < SkillsWindow.ContextReturnCodes.SET_AUTOLOCK then
		if returnCode == SkillsWindow.ContextReturnCodes.ASSIGN_KEY then
			returnCode = returnCode - 1
		end
		Hotbar.ContextMenuCallback(returnCode,param)
		return
	end
	if (param ~= nil) then
		if (returnCode == SkillsWindow.ContextReturnCodes.REMOVE_CUSTOM) then
			local newTabContents = {}
			local newIndex = 1
			for index, item in pairs(tabContents[SkillsWindow.CUSTOM_TAB_NUM]) do
				if (item ~= param) then
					newTabContents[newIndex] = item
					newIndex = newIndex + 1
				end
			end
			SystemData.Settings.Interface.CustomSkills = newTabContents
			tabContents[SkillsWindow.CUSTOM_TAB_NUM] = SystemData.Settings.Interface.CustomSkills
			SkillsWindow.ShowTab(SkillsWindow.CUSTOM_TAB_NUM)
			if (DoesWindowExist("SkillsTrackerWindow")) then
				SkillsTracker.Update()
			end
		elseif (returnCode == SkillsWindow.ContextReturnCodes.ADD_TO_CUSTOM) then
			local found = false
			for index, item in pairs(tabContents[SkillsWindow.CUSTOM_TAB_NUM]) do
				if (item == param) then
					found = true
				end
			end
			if (found == false) then
				local nextSlot = #tabContents[SkillsWindow.CUSTOM_TAB_NUM] + 1		
				tabContents[SkillsWindow.CUSTOM_TAB_NUM][nextSlot] = param
			end
			if (DoesWindowExist("SkillsTrackerWindow")) then
				SkillsTracker.Update()
			end
		elseif (returnCode == SkillsWindow.ContextReturnCodes.CLEAR_AUTOLOCK) then
			SkillsWindow.SkillTargetVals[param] = nil
			Interface.DeleteSetting( "SkillTargetVals_"..param )
			SkillsWindow.ShowTab(data.activeTab)
			SkillsTracker.Update()
		elseif (returnCode == SkillsWindow.ContextReturnCodes.SET_AUTOLOCK) then
		
			local serverId = WindowData.SkillsCSV[param].ServerId
			local max = WindowData.SkillDynamicData[serverId].SkillCap / 10
			local rdata = {title=GetStringFromTid(WindowData.SkillsCSV[param].NameTid), subtitle=ReplaceTokens(GetStringFromTid(1154798), {L"0", towstring(max)}), callfunction=SkillsWindow.SetAutoLock, min = 0, max = max, id=serverId} -- Enter a value between ~1_MIN~ - ~2_MAX~
			RenameWindow.Create(rdata)
		end 
	end
end

function SkillsWindow.SetAutoLock(id, value, max, min)
	if (tonumber(value)  ~= nil) then
		if tonumber(value) < min then
			value = min
		end
		if tonumber(value) > max then
			value = max
		end
		SkillsWindow.SkillTargetVals[id] = tonumber(value) * 10
		Interface.SaveSetting("SkillTargetVals_"..id, tonumber(value) * 10)
		
		
		if (WindowData.SkillDynamicData[WindowData.SkillsCSV[id].ServerId].RealSkillValue > tonumber(value) * 10) then
			WindowData.SkillDynamicData[WindowData.SkillsCSV[id].ServerId].SkillState = 1
			ReturnWindowData.SkillSystem.SkillId = WindowData.SkillsCSV[id].ServerId
			ReturnWindowData.SkillSystem.SkillButtonState = 1
			BroadcastEvent(SystemData.Events.SKILLS_ACTION_SKILL_STATE_CHANGE)
		end
	
		if (WindowData.SkillDynamicData[WindowData.SkillsCSV[id].ServerId].RealSkillValue == tonumber(value) * 10) then
			WindowData.SkillDynamicData[WindowData.SkillsCSV[id].ServerId].SkillState = 2
			ReturnWindowData.SkillSystem.SkillId = WindowData.SkillsCSV[id].ServerId
			ReturnWindowData.SkillSystem.SkillButtonState = 2
			BroadcastEvent(SystemData.Events.SKILLS_ACTION_SKILL_STATE_CHANGE)
		end
		
		if (WindowData.SkillDynamicData[WindowData.SkillsCSV[id].ServerId].RealSkillValue < tonumber(value) * 10) then
			WindowData.SkillDynamicData[WindowData.SkillsCSV[id].ServerId].SkillState = 0
			ReturnWindowData.SkillSystem.SkillId = WindowData.SkillsCSV[id].ServerId
			ReturnWindowData.SkillSystem.SkillButtonState = 0
			BroadcastEvent(SystemData.Events.SKILLS_ACTION_SKILL_STATE_CHANGE)
		end
		SkillsWindow.ShowTab(data.activeTab)
		SkillsTracker.Update()
	end
end

function SkillsWindow.SkillRButtonUp()
	local buttonNum = WindowGetId(SystemData.ActiveWindow.name)
	local param = tabContents[data.activeTab][buttonNum]
	local serverId = WindowData.SkillsCSV[param].ServerId

	-- reset the context menu
	ContextMenu.CleanUp()

	if (SkillsWindow.SkillTargetVals[serverId] and SkillsWindow.SkillTargetVals[serverId] > 0) then
		ContextMenu.CreateLuaContextMenuItem({tid = 1154800, returnCode = SkillsWindow.ContextReturnCodes.CLEAR_AUTOLOCK, param = serverId})
	else
		ContextMenu.CreateLuaContextMenuItem({tid = 1154799, returnCode = SkillsWindow.ContextReturnCodes.SET_AUTOLOCK, param = param})
	end
	
	if (data.activeTab == SkillsWindow.CUSTOM_TAB_NUM) then
		ContextMenu.CreateLuaContextMenuItem({tid = SkillsWindow.TID_REMOVE_CUSTOM, returnCode = SkillsWindow.ContextReturnCodes.REMOVE_CUSTOM, param = param})		
	else
		-- check to see if we can add it
		if (#tabContents[SkillsWindow.CUSTOM_TAB_NUM] == SkillsWindow.NUM_SKILLS_PER_TAB) then
			flags = ContextMenu.GREYEDOUT
		end
		
		ContextMenu.CreateLuaContextMenuItem({tid = SkillsWindow.TID_ADD_TO_CUSTOM, returnCode = SkillsWindow.ContextReturnCodes.ADD_TO_CUSTOM, param = param})		
	end

	ContextMenu.CreateLuaContextMenuItem({ str = L""})

	local params = {isSkill =  true, abilityId = serverId, iconId = WindowData.SkillsCSV[param].IconId, windowName = SystemData.ActiveWindow.name}
	ContextMenu.CreateLuaContextMenuItem({tid = HotbarSystem.TID_ASSIGN_HOTKEY, returnCode = SkillsWindow.ContextReturnCodes.ASSIGN_KEY, param = params})

	local macroId = MacroWindow.GetMacroId(L"SkillHotkey" .. serverId)
	-- if we have an hidden macro for the spell hotkey we can also change the target type (except for legacy targeting)
	if macroId ~= 0  and ( SystemData.Settings.GameOptions.legacyTargeting == false) then
		local hotbarId = SystemData.MacroSystem.STATIC_MACRO_ID
		local itemIndex = macroId
		local subIndex = 1 -- our hidden macro have only 1 action inside: the spell we are analyzing.
		local notarget = false
		local noSelf = false
		local cursorOnly = false
		local slotWindow = "Macro_" .. macroId .. "_1"
		local actionType = UserActionGetType(hotbarId, itemIndex, subIndex)
		local param = {HotbarId=hotbarId, ItemIndex=itemIndex, SubIndex=subIndex, SlotWindow=slotWindow, ActionType=actionType}

		local notarget = false
		if (serverId == 46 or serverId== 32 or serverId== 56 or serverId== 38 or serverId== 21 or serverId== 47) then -- meditation, spirit speak, imbuing, tracking, hiding, stealth
			notarget=true
		end

		if (( UserActionHasTargetType(hotbarId,itemIndex,subIndex) ) and (not notarget)) then
			local targetType = UserActionGetTargetType(hotbarId, itemIndex, subIndex, slotWindow)

			local pressed = { false, false, false, false, false }

			pressed[targetType+1] = true
		
			-- creating the proper context sub-menu for the targeting
			local subMenu = {
				{tid = HotbarSystem.TID_SELF,returnCode=SkillsWindow.ContextReturnCodes.TARGET_SELF,param=param,pressed=pressed[1+SystemData.Hotbar.TargetType.TARGETTYPE_SELF] },
				{tid = HotbarSystem.TID_CURSOR,returnCode=SkillsWindow.ContextReturnCodes.TARGET_CURSOR,param=param,pressed=pressed[1+SystemData.Hotbar.TargetType.TARGETTYPE_CURSOR] },
				{tid = HotbarSystem.TID_OBJECT_ID,returnCode=SkillsWindow.ContextReturnCodes.TARGET_OBJECT_ID,param=param,pressed=pressed[1+SystemData.Hotbar.TargetType.TARGETTYPE_OBJECT_ID] },
				{tid = HotbarSystem.TID_CURRENT,returnCode=SkillsWindow.ContextReturnCodes.TARGET_CURRENT,param=param,pressed=pressed[1+SystemData.Hotbar.TargetType.TARGETTYPE_CURRENT] },
				{ str = GetStringFromTid(280),returnCode=SkillsWindow.ContextReturnCodes.TARGET_MOUSEOVER,param=param,pressed=pressed[1+SystemData.Hotbar.TargetType.TARGETTYPE_MOUSEOVER] } }
		
				
			ContextMenu.CreateLuaContextMenuItem({tid = 283, subMenuOptions = subMenu }) 
		end
	end
	ContextMenu.ActivateLuaContextMenu(SkillsWindow.ContextMenuCallback)
end

function SkillsWindow.ToggleHelpButton()
	tab = data.activeTab
	buttonNum = WindowGetId(SystemData.ActiveWindow.name)
	activeContent = tabContents[tab]
	skillId = activeContent[buttonNum]
	SkillsInfo.DisplayId = skillId
	SkillsInfo.UpdateGump(skillId)
	--Debug.PrintToDebugConsole(L"Ids: "..buttonNum..L", "..skillId)

	WindowSetShowing("SkillsInfo", true)
end

function SkillsWindow.MoreInfoOnMouseOver()
	local btnName = SystemData.ActiveWindow.name
	local text = GetStringFromTid(1115246) -- "More Info"
	
	Tooltips.CreateTextOnlyTooltip(btnName, text)
end

function SkillsWindow.AssignHotkey(abilityId, iconId, windowName)

	-- searching if there is already a macro for this spell
	local numMacros = MacroSystemGetNumMacros()
	local macroIndex 
	for i=1,numMacros do
		local macroName = UserActionMacroGetName(SystemData.MacroSystem.STATIC_MACRO_ID,i)
		if macroName == L"SkillHotkey" .. abilityId then
			macroIndex = i
			break
		end
	end
	if not macroIndex then
		macroIndex = SkillsWindow.CreateMacro(abilityId, iconId, windowName)
		SkillsWindow.HandleAssignHotkey(windowName, macroIndex)
	else
		SkillsWindow.HandleAssignHotkey(windowName, macroIndex)
	end
end

function SkillsWindow.HandleAssignHotkey(windowName, macroIndex)

	-- show the assign hotkey info tooltip
	WindowUtils.ShowAssignHotkeyInfo(windowName)
	
	MacroWindow.RecordingKeySkill = true
	MacroWindow.RecordingIndex = macroIndex
	MacroWindow.RecordingKey = true
	BroadcastEvent( SystemData.Events.INTERFACE_RECORD_KEY )
end

function SkillsWindow.CreateMacro(abilityId, iconId, spellbookId, windowName)
	local macroIndex = MacroSystemAddMacroItem()
	
	UserActionMacroSetName(SystemData.MacroSystem.STATIC_MACRO_ID,macroIndex,L"SkillHotkey" .. abilityId)
	UserActionSetIconId(SystemData.MacroSystem.STATIC_MACRO_ID,macroIndex,0,iconId)

	local prevActions = WindowGetShowing("ActionsWindow")
	ActionEditWindow.OpenEditWindow(macroIndex,SystemData.UserAction.TYPE_MACRO,nil,SystemData.MacroSystem.STATIC_MACRO_ID)
	WindowSetShowing("ActionEditMacro", false)
	WindowSetShowing("ActionsWindow", prevActions)
	Spellbook.DragSpell = {type = SystemData.UserAction.TYPE_SKILL, abilityId = abilityId, iconId = iconId, macroIndex = macroIndex}

	local Warning = 
	{
		windowName = "SpellWarning",
		titleTid = 281,
		bodyTid  = 284,
		destroyDuplicate = true,
	}
	UO_StandardDialog.CreateDialog(Warning)	
	return macroIndex
end

function SkillsWindow.CreateMacroCycle()
	if Spellbook.DragSpell and SystemData.DragItem.DragType == SystemData.DragItem.TYPE_NONE then
		DragSlotSetActionMouseClickData(SystemData.UserAction.TYPE_SKILL, Spellbook.DragSpell.abilityId, Spellbook.DragSpell.iconId)

	elseif Spellbook.DragSpell and SystemData.DragItem.DragType ~= SystemData.DragItem.TYPE_NONE then

		MacroEditWindow.MacroActionLButtonUp(true)
	end
end

function SkillsWindow.GetSkillDistance(skillID)

	-- is the skill animal lore?
	if skillID == SkillsWindow.SkillsID.ANIMAL_LORE then
		return 12

	-- is the skill animal taming?
	elseif skillID == SkillsWindow.SkillsID.ANIMAL_TAMING then
		return 3

	-- is the skill begging?
	elseif skillID == SkillsWindow.SkillsID.BEGGING then
		return 4

	-- is the skill item ID?
	elseif skillID == SkillsWindow.SkillsID.ITEM_IDENTIFICATION then
		return 3

	-- is the skill taste ID?
	elseif skillID == SkillsWindow.SkillsID.TASTE_IDENTIFICATION then
		return 1

	-- is the skill anatomy?
	elseif skillID == SkillsWindow.SkillsID.ANATOMY then
		return 8

	-- is the skill arms lore?
	elseif skillID == SkillsWindow.SkillsID.ARMS_LORE then
		return 3

	-- is the skill stealing?
	elseif skillID == SkillsWindow.SkillsID.STEALING then
		return 2

	-- is the skill discordance/provocation/peacemaking?
	elseif skillID == SkillsWindow.SkillsID.DISCORDANCE or skillID == SkillsWindow.SkillsID.PROVOCATION or skillID == SkillsWindow.SkillsID.PEACEMAKING then
		return 8 + math.max((GetSkillValue(skillID, true) / 15), 1)
	end
end

function SkillsWindow.CreateSkillsTable()

	-- initialize the skills ID table
	SkillsWindow.SkillsID = {}

	-- scan the skills CSV
	for _, data in pairsByIndex(WindowData.SkillsCSV) do

		-- format the skill name all upper case and without spaces
		local formatSkillName = tostring(wstring.gsub(wstring.upper(data.SkillName), L" ", L"_"))
		
		-- store the skill ID
		SkillsWindow.SkillsID[formatSkillName] = data.ServerId
	end
end