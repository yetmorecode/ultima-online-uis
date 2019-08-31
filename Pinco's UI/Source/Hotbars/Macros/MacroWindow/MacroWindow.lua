---------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

MacroWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------
MacroWindow.MacroSelected = nil
MacroWindow.CreatedItems = {}
MacroWindow.RecordingIndex = 0
MacroWindow.RecordingKey = false

MacroWindow.TID_MACRO = 3000394
MacroWindow.TID_MACROS = 3000172 
MacroWindow.TID_NOMACRO = 1078292
MacroWindow.TID_MACROCOLON = 1094841 -- "Macro:"
MacroWindow.TID_CREATE = 1077830
MacroWindow.TID_DESTROY_MACRO = 1078351
MacroWindow.TID_NO_KEYBINDING = 1078509
MacroWindow.TID_BINDING_CONFLICT_TITLE = 1079169
MacroWindow.TID_BINDING_CONFLICT_BODY = 1079170
MacroWindow.TID_BINDING_CONFLICT_QUESTION = 1094839
MacroWindow.TID_YES = 1049717
MacroWindow.TID_NO = 1049718

MacroWindow.ActiveTab = 1

----------------------------------------------------------------
-- Macro Functions
----------------------------------------------------------------

-- The macrolist is treated internally as a hotbar that you cant actually use

-- OnInitialize Handler
function MacroWindow.Initialize()

	-- flag the window to be destroyed on close
	Interface.DestroyWindowOnClose["MacroWindow"] = true

	-- attach the close function
	Interface.OnCloseCallBack["MacroWindow"] = MacroWindow.OnClose

	-- set the window title
	WindowUtils.SetWindowTitle("MacroWindow", GetStringFromTid(MacroWindow.TID_MACROS))

	-- set the button text
	ButtonSetText("AddMacroButton", GetStringFromTid(MacroWindow.TID_CREATE))
    
	-- set the "No Macros" text
    LabelSetText("MacroScrollWindowNoMacros", GetStringFromTid(MacroWindow.TID_NOMACRO))
    
	-- tabs text
	ButtonSetText( "MacroWindowMacrosTabButton", GetStringFromTid( MacroWindow.TID_MACROS ) )
	ButtonSetText( "MacroWindowImportTabButton", GetStringFromTid( 306 ) )

	-- reset the tabs
	MacroWindow.ClearStates()

	-- select the macro list tab
	MacroWindow.OnMacroTab()

	-- restore window position
	WindowUtils.RestoreWindowPosition("MacroWindow")
end

function MacroWindow.Shutdown()

	-- save window position
	WindowUtils.SaveWindowPosition("MacroWindow")
end

function MacroWindow.ClearStates()

	-- reset the button pressed status
	ButtonSetPressedFlag( "MacroWindowMacrosTabButton", false )
	ButtonSetPressedFlag( "MacroWindowImportTabButton", false )

	-- remove the disabled status
	ButtonSetDisabledFlag( "MacroWindowMacrosTabButton", false )
	ButtonSetDisabledFlag( "MacroWindowImportTabButton", false )

	-- show the tab
	WindowSetShowing( "MacroWindowMacrosTabButtonTab", true )
	WindowSetShowing( "MacroWindowImportTabButtonTab", true )
end

function MacroWindow.OnMacroTab()

	-- reset all tabs
	MacroWindow.ClearStates()

	-- activate the macro tab
	ButtonSetDisabledFlag( "MacroWindowMacrosTabButton", true )
	WindowSetShowing( "MacroWindowMacrosTabButtonTab", false )

	-- set the active tab
	MacroWindow.ActiveTab = 1

	-- update the macro list
	MacroWindow.DisplayMacroList()
end

function MacroWindow.OnImportTab()

	-- reset all tabs
	MacroWindow.ClearStates()

	-- activate the macro tab
	ButtonSetDisabledFlag( "MacroWindowImportTabButton", true )
	WindowSetShowing( "MacroWindowImportTabButtonTab", false )

	-- set the active tab
	MacroWindow.ActiveTab = 2

	-- update the import list
	MacroWindow.DisplayMacroList()

	-- hide the macro edit
	WindowSetShowing("ActionEditMacro", false) 

	-- hide the actions window
	ToggleWindowByName("ActionsWindow")
end

function MacroWindow.OnShown()

	-- update the macro list
	MacroWindow.DisplayMacroList()
end

function MacroWindow.AddMacro()

	-- generate a new macro ID
	local macroIndex = MacroSystemAddMacroItem()

	-- set the new macro default name
	UserActionMacroSetName(SystemData.MacroSystem.STATIC_MACRO_ID, macroIndex, GetStringFromTid(MacroWindow.TID_MACRO) .. macroIndex)

	-- set the macro default icon
	UserActionSetIconId(SystemData.MacroSystem.STATIC_MACRO_ID, macroIndex, 0)

	-- open the macro edit window
	ActionEditWindow.OpenEditWindow(macroIndex, SystemData.UserAction.TYPE_MACRO, nil, SystemData.MacroSystem.STATIC_MACRO_ID)
    
	-- open the actions window
	if not WindowGetShowing("ActionsWindow") then
		ToggleWindowByName("ActionsWindow")
	end
end

function MacroWindow.DisplayMacroList()

	-- is the window active?
	if not DoesWindowExist("MacroWindow") then
		return
	end

	-- clear the list
	MacroWindow.ClearAll()

	-- populate macros list
	if MacroWindow.ActiveTab == 1 then

		-- get the macros number
   		local numMacros = MacroSystemGetNumMacros()
   	
		-- initialize previous macro element
		local lastMacro

		-- scan all macros
		for i = 1, numMacros do

			-- get macro name
			local macroName = UserActionMacroGetName(SystemData.MacroSystem.STATIC_MACRO_ID, i)

			-- if the macro is a spellbook/skill hotkey or the mount blockbar macro, we hide it
			if (wstring.find(macroName, L"SpellbookHotkey", 1, true) or wstring.find(macroName, L"SkillHotkey", 1, true) or wstring.find(macroName, L"MountBlockbarMacro", 1, true)) and not Interface.DebugMode  then
				continue
			end

			-- element name
    		local currentMacroWindowName = "MacroScrollWindowScrollChildItem" .. i
    	
			-- is this a new macro?
    		if not DoesWindowExist(currentMacroWindowName)  then

				-- create a new element
    			CreateWindowFromTemplate( currentMacroWindowName, "MacroItemTemplate", "MacroScrollWindowScrollChild" )
			
				-- add the element to the existing elements array
				table.insert(MacroWindow.CreatedItems, currentMacroWindowName)
			end

			-- hide the highlight border
			WindowSetShowing(currentMacroWindowName .. "Highlight", false)

			-- set the element ID
    		WindowSetId(currentMacroWindowName, i)

			-- set the element icon ID
    		WindowSetId(currentMacroWindowName .. "SquareIcon", i)

			-- reset element anchors
			WindowClearAnchors(currentMacroWindowName)

			-- is this the first element?
			if (i == 1 or #MacroWindow.CreatedItems == 1) then

				-- anchor the element to the top-left of the window
         		WindowAddAnchor( currentMacroWindowName, "topleft", "MacroScrollWindowScrollChild", "topleft", 10, 0)

			else -- anchor the element to the previous one
        		WindowAddAnchor( currentMacroWindowName, "bottomleft", lastMacro, "topleft", 0, 0)
			end

			-- store the element name
			lastMacro = currentMacroWindowName

			-- get the icon ID
			local iconId = UserActionGetIconId(SystemData.MacroSystem.STATIC_MACRO_ID, i, 0)

			-- get the icon data
			local iconTexture, x, y = GetIconData(iconId)

			-- draw the macro icon
			DynamicImageSetTexture(currentMacroWindowName.."SquareIcon", iconTexture, x, y)

			-- draw the icon background
			DynamicImageSetTexture( currentMacroWindowName.."SquareIconBG", MiniTexturePack.DB[Interface.Settings.MTP_Current].texture .. "Icon", x, y )
        
			-- is the macro enabled? (it always should...)
			if UserActionIsTargetModeCompat(SystemData.MacroSystem.STATIC_MACRO_ID, i, 0) then

				-- enable the macro button
				WindowSetShowing(currentMacroWindowName.."Disabled", false)

				-- enable the macro name
				LabelSetTextColor( currentMacroWindowName.."Name", 255, 255, 255 )

			else -- disable the macro button
				WindowSetShowing(currentMacroWindowName.."Disabled", true)

				-- disable the macro name
				LabelSetTextColor( currentMacroWindowName.."Name", 128, 128, 128 )
			end
		
			-- update the macro name
			LabelSetText(currentMacroWindowName .. "Name", macroName)

			-- get the macro hotkey
			local bindingStr = UserActionMacroGetBinding(SystemData.MacroSystem.STATIC_MACRO_ID, i)

			-- do we have an hotkey?
			if (bindingStr ~= L"") then

				-- update the hotkey text color
				MacroWindow.UpdateBindingText(currentMacroWindowName.."Binding", bindingStr)

			else -- reset the label text color
				LabelSetTextColor( currentMacroWindowName .. "Binding", 243, 227, 49 )

				-- reset the hotkey text to "NO KEYBINDING"
				LabelSetText(currentMacroWindowName .. "Binding", GetStringFromTid(MacroWindow.TID_NO_KEYBINDING))
			end		
		end

	-- populate import list
	elseif MacroWindow.ActiveTab == 2 then
		
		-- do we have any exported macro?
		if MacroWindow.ExportedMacros then

			-- current macros count
			local i = 0

			-- initialize previous macro element
			local lastMacro

			-- scan all exported macros
			for macroName, data in pairs(MacroWindow.ExportedMacros) do

				-- increase the count
				i = i + 1

				-- element name
    			local currentMacroWindowName = "MacroScrollWindowScrollChildItem" .. i
    	
				-- is this a new macro?
    			if not DoesWindowExist(currentMacroWindowName) then

					-- create a new element
    				CreateWindowFromTemplate( currentMacroWindowName, "MacroItemTemplate", "MacroScrollWindowScrollChild" )
			
					-- add the element to the existing elements array
					table.insert(MacroWindow.CreatedItems, currentMacroWindowName)
				end

				-- hide the highlight border
				WindowSetShowing(currentMacroWindowName .. "Highlight", false)

				-- set the element ID
    			WindowSetId(currentMacroWindowName, i)

				-- set the element icon ID
    			WindowSetId(currentMacroWindowName .. "SquareIcon", i)

				-- reset element anchors
				WindowClearAnchors(currentMacroWindowName)

				-- is this the first element?
				if (i == 1 or #MacroWindow.CreatedItems == 1) then

					-- anchor the element to the top-left of the window
         			WindowAddAnchor( currentMacroWindowName, "topleft", "MacroScrollWindowScrollChild", "topleft", 10, 0)

				else -- anchor the element to the previous one
        			WindowAddAnchor( currentMacroWindowName, "bottomleft", lastMacro, "topleft", 0, 0)
				end

				-- store the element name
				lastMacro = currentMacroWindowName

				-- get the icon ID
				local iconId = MacroWindow.ExportedMacros[macroName].iconId

				-- get the icon data
				local iconTexture, x, y = GetIconData(iconId)

				-- draw the macro icon
				DynamicImageSetTexture(currentMacroWindowName.."SquareIcon", iconTexture, x, y)

				-- draw the icon background
				DynamicImageSetTexture( currentMacroWindowName.."SquareIconBG", MiniTexturePack.DB[Interface.Settings.MTP_Current].texture .. "Icon", x, y )
        
				-- is the macro enabled? (it always should...)
				if UserActionIsTargetModeCompat(SystemData.MacroSystem.STATIC_MACRO_ID, i, 0) then

					-- enable the macro button
					WindowSetShowing(currentMacroWindowName.."Disabled", false)

					-- enable the macro name
					LabelSetTextColor( currentMacroWindowName.."Name", 255, 255, 255 )

				else -- disable the macro button
					WindowSetShowing(currentMacroWindowName.."Disabled", true)

					-- disable the macro name
					LabelSetTextColor( currentMacroWindowName.."Name", 128, 128, 128 )
				end
		
				-- update the macro name
				LabelSetText(currentMacroWindowName .. "Name", macroName)

				-- reset the label color
				LabelSetTextColor( currentMacroWindowName .. "Binding", 243, 227, 49 )

				-- set the macro owner's name
				LabelSetText(currentMacroWindowName .. "Binding", ReplaceTokens(GetStringFromTid(313), {data.ownerName}) )
			end
		end
	end

	-- do we have any visible macro?
	if numMacros == 0 or #MacroWindow.CreatedItems == 0 then

		-- show the "NO MACROS" text
   		WindowSetShowing("MacroScrollWindowNoMacros", true)

   	else -- hide the "NO MACROS" text
		WindowSetShowing("MacroScrollWindowNoMacros", false)
	end
        
    -- reset the scrollbar position to top
	ScrollWindowSetOffset( "MacroScrollWindow", 0 )

	-- update scrollable area 
    ScrollWindowUpdateScrollRect("MacroScrollWindow")
end  

function MacroWindow.OnScroll(pos)
	
	-- is the macro edit active?
	if not WindowGetShowing("ActionEditMacro") then
		return
	end

	-- default slot size
	local slotSize = 50

	-- current window width
	local _, maxOffset = WindowGetDimensions("ActionEditMacro" .. "Actions")

	-- is the position bigger than the width?
	if pos > maxOffset then

		-- cap the position to the width
		pos = maxOffset 
	end

	-- element name
    local currentMacroWindowName = "MacroScrollWindowScrollChildItem" .. ActionEditWindow.CurEditItem.itemIndex
	
	-- does the slot still exist?
	if DoesWindowExist(currentMacroWindowName) then

		-- get the position of the element
		local _, y = WindowGetOffsetFromParent(currentMacroWindowName)

		-- hide the highlight border if it's out of the visible scrollable area
		WindowSetShowing(currentMacroWindowName .. "Highlight", y >= pos and y <= pos + (slotSize * 5) - 30 )
	end
end

function MacroWindow.ClearAll()

	 -- search for unused elements
    for i, currentMacroWindowName in pairsByIndex(MacroWindow.CreatedItems) do

		-- does the element exist?
		if DoesWindowExist(currentMacroWindowName) then
			
			-- destroy the element
			DestroyWindow(currentMacroWindowName)
		end
    end

	-- reset the elements count
	MacroWindow.CreatedItems = {}
end

function MacroWindow.UpdateBindingText(element, key)

	-- make sure the window exist
	if not DoesWindowExist(element) then
		return
	end

	-- get the formatted key and color
	local key, color = WindowUtils.FormatBindings(key)
	
	-- default hotkey text color
	LabelSetTextColor(element, color.r, color.g, color.b)
	
	-- update the hotkey name
	LabelSetText(element, key)
end

function MacroWindow.PickupMacro(flags)

	-- can't drag macros from the import list
	if MacroWindow.ActiveTab == 2 then
		return
	end

	-- get the macro ID from the window
	local macroIndex = WindowGetId(SystemData.ActiveWindow.name)

	-- calculate the right macro ID
	local macroId = UserActionGetId(SystemData.MacroSystem.STATIC_MACRO_ID, macroIndex, 0)

	-- get the macro icon ID
	local iconId = UserActionGetIconId(SystemData.MacroSystem.STATIC_MACRO_ID, macroIndex, 0)
	
	-- is CONTROL pressed?
	if flags == SystemData.ButtonFlags.CONTROL then

		-- preventing the player from dropping duplicate actions (only certain generic actions can be used multiple times)
		local alreadyInBar, existingSlot = HotbarSystem.ActionAlreadyInHotbar(macroId, SystemData.UserAction.TYPE_MACRO_REFERENCE )

		-- is the macro already in the hotbars?
		if alreadyInBar then

			-- return an error message
			ChatPrint(GetStringFromTid(285), SystemData.ChatLogFilters.SYSTEM)

			-- make the slot glow to highlight the duplicate
			if alreadyInBar then
				HotbarSystem.GlowSlotWarning(existingSlot, 5, i, macroId)
			end

			return
		end

		-- create a new blockbar
		local blockBar = HotbarSystem.SpawnNewHotbar(_, 1, true)
		
		-- add the macro to the blockbar
		HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_MACRO_REFERENCE, macroId, iconId, blockBar, 1)
		
		-- forcing the blockbar to follow the mouse cursor
		WindowUtils.FollowMouseCursor("Hotbar" .. blockBar, Hotbar.BUTTON_SIZE, Hotbar.BUTTON_SIZE, -30, -15, false, true, false)

		-- setting the window movable
		WindowSetMoving("Hotbar" .. blockBar, true)
		
    else -- preventing the player from dropping duplicate actions (only certain generic actions can be used multiple times)
		local alreadyInBar, existingSlot = HotbarSystem.ActionAlreadyInHotbar(macroId, SystemData.UserAction.TYPE_MACRO_REFERENCE )

		-- is the macro already in the hotbars?
		if alreadyInBar then
			
			-- highlight the macro in the current hotbar slot
			HotbarSystem.GlowSlotWarning(existingSlot, 5, macroId)
		end

		-- begin the dragging
		DragSlotSetActionMouseClickData(SystemData.UserAction.TYPE_MACRO_REFERENCE, macroId, iconId)
	end
end

function MacroWindow.OnItemRButtonUp()

	-- current slot window name
	local slotWindow = SystemData.ActiveWindow.name

	-- current macro ID
	local macroIndex = WindowGetId(slotWindow)
	
	-- reset the context menu
	ContextMenu.CleanUp()

	-- macro list current active
	if MacroWindow.ActiveTab == 1 then

		-- get macro name
		local macroName = UserActionMacroGetName(SystemData.MacroSystem.STATIC_MACRO_ID, macroIndex)

		-- get the context options from the hotbar system
		HotbarSystem.CreateUserActionContextMenuOptions(SystemData.MacroSystem.STATIC_MACRO_ID, macroIndex, 0, slotWindow)
	
		-- add the context option to "ASSIGN KEY"
		ContextMenu.CreateLuaContextMenuItem({tid = HotbarSystem.TID_ASSIGN_HOTKEY, returnCode = HotbarSystem.ContextReturnCodes.ASSIGN_KEY, param = macroIndex})

		-- if the macro with the same name has already been exported, we flag that is a duplicate so we can ask for overwrite later
		local duplicate = MacroWindow.ExportedMacros and MacroWindow.ExportedMacros[macroName] ~= nil

		-- add the context option to "EXPORT MACRO"
		ContextMenu.CreateLuaContextMenuItem({tid = HotbarSystem.TID_MACRO_EXPORT, returnCode = HotbarSystem.ContextReturnCodes.MACRO_EXPORT, param = {macroIndex = macroIndex, macroName = macroName, duplicate = duplicate}})

	-- import list current active
	elseif MacroWindow.ActiveTab == 2 then

		-- element name
    	local currentMacroWindowName = "MacroScrollWindowScrollChildItem" .. macroIndex

		-- get macro name
		local macroName = LabelGetText(currentMacroWindowName .. "Name")

		-- add the "CLEAR ITEM" context option
		ContextMenu.CreateLuaContextMenuItem({tid = HotbarSystem.TID_CLEAR_ITEM, returnCode = HotbarSystem.ContextReturnCodes.CLEAR_ITEM, param = macroIndex})

		-- get the existing macro ID
		local macroID = MacroWindow.GetMacroId(macroName)

		-- if the macro with the same name has already been inported, we flag that is a duplicate so we can ask for overwrite later
		local duplicate = macroID ~= 0

		-- add the context option to "IMPORT MACRO"
		ContextMenu.CreateLuaContextMenuItem({tid = HotbarSystem.TID_MACRO_IMPORT, returnCode = HotbarSystem.ContextReturnCodes.MACRO_IMPORT, param = {macroIndex = macroIndex, macroID = macroID, duplicate = duplicate}})
	end

	-- show the context menu
	ContextMenu.ActivateLuaContextMenu(MacroWindow.ContextMenuCallback)
end

function MacroWindow.ContextMenuCallback(returnCode, param)

	-- do we have any parameters?
	if (param ~= nil) then

		-- is the context action being handeld by the hotbar system?
		local bHandled = HotbarSystem.ContextMenuCallback(returnCode, param) 
		
		-- if it wasnt handled then check for macro specific options
		if (bHandled == false) then

			-- delete macro
			if returnCode == HotbarSystem.ContextReturnCodes.CLEAR_ITEM then

				-- OK button callback function
                local okayButton 
				
				-- macro list current active
				if MacroWindow.ActiveTab == 1 then

					-- create the OK button callback
					okayButton = { textTid=UO_StandardDialog.TID_OKAY, callback=function() HotbarSystem.UpdateTargetMouseOver(SystemData.MacroSystem.STATIC_MACRO_ID,param.ItemIndex,"all", nil) MacroSystemDeleteMacroItem(param.ItemIndex) MacroWindow.DisplayMacroList() if WindowGetId("ActionEditMacro") == param.ItemIndex then WindowSetShowing("ActionEditMacro", false) ToggleWindowByName("ActionsWindow") end end }

				-- import list current active
				elseif MacroWindow.ActiveTab == 2 then

					-- element name
    				local currentMacroWindowName = "MacroScrollWindowScrollChildItem" .. param

					-- get macro name
					local macroName = LabelGetText(currentMacroWindowName .. "Name")

					-- create the OK button callback
					okayButton = { textTid=UO_StandardDialog.TID_OKAY, callback=function() MacroWindow.ExportedMacros[macroName] = nil MacroWindow.DisplayMacroList() end }
				end

				-- CANCEL button callback function
                local cancelButton = { textTid=UO_StandardDialog.TID_CANCEL }				

				-- create the confirm dialog data
				local DestroyConfirmWindow = 
				{
				    windowName = "MacroWindow",
					titleTid = HotbarSystem.TID_CLEAR_ITEM,
					bodyTid = MacroWindow.TID_DESTROY_MACRO,
                    buttons = { okayButton, cancelButton },
					closeCallback = cancelButton.callback,
					destroyDuplicate = true,
				}
				
				-- show the confirm dialog
				UO_StandardDialog.CreateDialog(DestroyConfirmWindow)			

			-- assign hotkey
			elseif (returnCode == HotbarSystem.ContextReturnCodes.ASSIGN_KEY) then

				-- show the assign hotkey info tooltip
				WindowUtils.ShowAssignHotkeyInfo("MacroScrollWindowScrollChildItem" .. param)
				
				-- enable recording
				MacroWindow.RecordingIndex = param
				MacroWindow.RecordingKey = true

				-- start the recording process
				BroadcastEvent(SystemData.Events.INTERFACE_RECORD_KEY)			
				
			-- import macro
			elseif returnCode == HotbarSystem.ContextReturnCodes.MACRO_IMPORT then

				-- is this a duplicate macro?
				if param.duplicate then

					-- OK function callback
					local okayButton = { textTid=UO_StandardDialog.TID_OKAY, callback=function() MacroSystemDeleteMacroItem(param.macroID) MacroWindow.ImportMacro(param.macroIndex) end }
					
					-- CANCEL button callback function
					local cancelButton = { textTid = UO_StandardDialog.TID_CANCEL }				

					-- create the confirm dialog data
					local OverwriteConfirmWindow = 
					{
						windowName = "OverwriteMacroWindow",
						titleTid = 314,
						bodyTid = 315,
						buttons = { okayButton, cancelButton },
						closeCallback = cancelButton.callback,
						destroyDuplicate = true,
					}
				
					-- show the confirm dialog
					UO_StandardDialog.CreateDialog(OverwriteConfirmWindow)

				else -- import the macro
					MacroWindow.ImportMacro(param.macroIndex)
				end

			-- export macro
			elseif (returnCode == HotbarSystem.ContextReturnCodes.MACRO_EXPORT) then

				-- is this a duplicate macro?
				if param.duplicate then

					-- OK function callback
					local okayButton = { textTid=UO_StandardDialog.TID_OKAY, callback=function() MacroWindow.ExportMacro(param.macroIndex) end }
					
					-- CANCEL button callback function
					local cancelButton = { textTid = UO_StandardDialog.TID_CANCEL }				

					-- create the confirm dialog data
					local OverwriteConfirmWindow = 
					{
						windowName = "OverwriteMacroWindow",
						titleTid = 314,
						bodyTid = 315,
						buttons = { okayButton, cancelButton },
						closeCallback = cancelButton.callback,
						destroyDuplicate = true,
					}
				
					-- show the confirm dialog
					UO_StandardDialog.CreateDialog(OverwriteConfirmWindow)

				else -- export the macro
					MacroWindow.ExportMacro(param.macroIndex)
				end
			end
		end
	end
end

function MacroWindow.ImportMacro(itemIndex)

	-- element name
    local currentMacroWindowName = "MacroScrollWindowScrollChildItem" .. itemIndex

	-- get macro name
	local macroName = LabelGetText(currentMacroWindowName .. "Name")

	-- get a new macro ID
	local macroIndex = MacroSystemAddMacroItem()
	
	-- set the macro name
	UserActionMacroSetName(SystemData.MacroSystem.STATIC_MACRO_ID, macroIndex, macroName)
				
	-- set the macro icon
	UserActionSetIconId(SystemData.MacroSystem.STATIC_MACRO_ID, macroIndex, 0, MacroWindow.ExportedMacros[macroName].iconId)

	-- is the repeat enabled?
	UserActionMacroSetRepeatEnabled( SystemData.MacroSystem.STATIC_MACRO_ID, macroIndex, MacroWindow.ExportedMacros[macroName].repeatEnabled )

	-- set the macro loops count
	UserActionMacroGetRepeatCount( SystemData.MacroSystem.STATIC_MACRO_ID, macroIndex, MacroWindow.ExportedMacros[macroName].repeatCount )

	-- open the macro edit window
	ActionEditWindow.OpenEditWindow(macroIndex, SystemData.UserAction.TYPE_MACRO, nil, SystemData.MacroSystem.STATIC_MACRO_ID)

	-- hide the macro edit window
	WindowSetShowing("ActionEditMacro", false)

	-- initialize the drag&drop cycle
	Interface.ImportMacro = macroIndex
	Interface.ImportMacroData = MacroWindow.ExportedMacros[macroName]
	Interface.ImportMacroStep = 0
end

function MacroWindow.ExportMacro(itemIndex)

	-- initialize the array
	if not MacroWindow.ExportedMacros then
		MacroWindow.ExportedMacros = {}
	end

	-- initialize the macro data to export
	local macroData = {}
				
	-- default macro ID
	local hotbarId = SystemData.MacroSystem.STATIC_MACRO_ID

	-- get macro name
	local macroName = UserActionMacroGetName(hotbarId, itemIndex)

	-- get the macro's icon ID
	macroData.iconId = UserActionGetIconId(hotbarId, itemIndex, 0)

	-- macro owner's ID
	macroData.ownerName = GetMobileName(GetPlayerID())

	-- is the repeat enabled?
	macroData.repeatEnabled = UserActionMacroGetRepeatEnabled( hotbarId, itemIndex )

	-- get the macro loops count
	macroData.repeatCount = UserActionMacroGetRepeatCount( hotbarId, itemIndex )

	-- initialize the elements list
	macroData.Elements = {}

	-- get the number of elements of the macro
	local numActions = UserActionMacroGetNumActions(hotbarId, itemIndex)

	-- scan all elements
	for subIndex = 1, numActions do

		-- initialize the slot element
		macroData.Elements[subIndex] = {}

		-- getting the action icon ID
		macroData.Elements[subIndex].iconId = UserActionGetIconId(hotbarId, itemIndex, subIndex)

		-- getting the current action type
		macroData.Elements[subIndex].actionType = UserActionGetType(hotbarId, itemIndex, subIndex)

		-- getting the current action ID
		macroData.Elements[subIndex].actionId = UserActionGetId(hotbarId, itemIndex, subIndex)

		-- getting the target type for the action
		macroData.Elements[subIndex].targetType = Hotbar.IsAMouseOverTarget("Macro_" .. itemIndex .. "_" .. subIndex, UserActionGetTargetType(hotbarId, itemIndex, subIndex))

		-- is this a stored target?
		if macroData.Elements[subIndex].targetType == SystemData.Hotbar.TargetType.TARGETTYPE_OBJECT_ID then

			-- get the target ID
			macroData.Elements[subIndex].storedTarget = UserActionGetTargetId(hotbarId, itemIndex, subIndex)
		end

		-- getting the callback text from the saved action
		macroData.Elements[subIndex].callback = UserActionSpeechGetText(hotbarId, itemIndex, subIndex)

		-- is this an item?
		if HotbarSystem.IsHotbarItem(macroData.Elements[subIndex].actionType) then

			-- getting object type and hue
			macroData.Elements[subIndex].objectType, macroData.Elements.hue = UserActionUseObjectTypeGetObjectTypeHue(macroData.Elements[subIndex].actionId) 

		-- is this an unequip action?
		elseif macroData.Elements[subIndex].actionType == SystemData.UserAction.TYPE_UNEQUIP_ITEMS then

			-- initialize the unequip slots
			macroData.Elements[subIndex].UnequipSlots = {}

			-- scan all unequip slots
			for i, unequipSlot in pairsByIndex(ActionEditWindow.UnEquip.Slots) do
							
				-- save the current slot flag
				macroData.Elements[subIndex].UnequipSlots[i] = UserActionFindSlot(hotbarId, itemIndex, subIndex, unequipSlot.slot)
			end

		-- is this an equip action?
		elseif (macroData.Elements[subIndex].actionType == SystemData.UserAction.TYPE_EQUIP_ITEMS) then
						
			-- initialize the equip items
			macroData.Elements[subIndex].EquipSlots = {}

			-- get the items count for this action
			local numItems = UserActionEquipItemsGetNumItems(hotbarId, itemIndex, subIndex)

			-- do we have a valid amount of items?
			if IsValidID(numItems) then

				-- scan all items
				for i = 1, numItems do

					-- get the object ID
					local objectId = UserActionEquipItemsGetItem(hotbarId, itemIndex, subIndex, i - 1)

					-- get the object type
					local objectType = GetItemType(objectId) 

					-- save the item ID
					macroData.Elements[subIndex].EquipSlots[i] = {objectId = objectId, objectType = objectType} 
				end
			end

		-- is this an arm/disarm action?
		elseif (macroData.Elements[subIndex].actionType == SystemData.UserAction.TYPE_ARM_DISARM) then

			-- get the slot ID
			macroData.Elements[subIndex].armDisarmSlot = UserActionArmDisarmGetSlotNumber(hotbarId, itemIndex, subIndex)

		-- is this a target resource action?
		elseif (macroData.Elements[subIndex].actionType == SystemData.UserAction.TYPE_TARGET_BY_RESOURCE) then
						
			-- initialize the target resource data
			macroData.Elements[subIndex].TargetResource = {}

			-- get the tool ID
			macroData.Elements[subIndex].TargetResource.objectId = UserActionTargetByResourceGetUseObjectInstanceId(hotbarId, itemIndex, subIndex)

			-- get the resource type
			macroData.Elements[subIndex].TargetResource.resourceType = UserActionTargetByResourceGetResourceType(hotbarId, itemIndex, subIndex)

			-- get the resource category
			macroData.Elements[subIndex].TargetResource.resourceCategory = UserActionTargetByResourceGetResourceCategory(hotbarId, itemIndex, subIndex)

		-- is this a delay?
		elseif (macroData.Elements[subIndex].actionType == SystemData.UserAction.TYPE_DELAY) then

			-- get the delay
			macroData.Elements[subIndex].delay = UserActionDelayGetDelay(hotbarId, itemIndex, subIndex)
		end

		-- export the macro
		MacroWindow.ExportedMacros[macroName] = macroData
	end
end

function MacroWindow.KeyRecorded()

	-- are we recording an hotkey?
	if MacroWindow.RecordingKey == true then

		-- turn off the recording
	    MacroWindow.RecordingKey = false

		-- hide the hotkey tooltip
		WindowSetShowing("AssignHotkeyInfo", false)

		-- is this a setting key conflict?
		if SystemData.BindingConflictType == SystemData.BindType.BINDTYPE_SETTINGS then

			-- scan all keys to find the duplicate
			for type, key in pairs(SystemData.Settings.Keybindings) do

				-- is this the hotkey?
				if key == SystemData.RecordedKey then

					-- update the conflict item index
					_, SystemData.BindingConflictItemIndex = SettingsWindow.GetKeyBindingNameFromType(type)
					break
				end
			end
		end

		-- if we're trying to replace the same slot of the same hotbar is not a conflict.
		if SystemData.BindingConflictHotbarId == SystemData.MacroSystem.STATIC_MACRO_ID and SystemData.BindingConflictItemIndex == MacroWindow.RecordingIndex then
			SystemData.BindingConflictType = SystemData.BindType.BINDTYPE_NONE
		end

		-- is there a conflict?
		if SystemData.BindingConflictType ~= SystemData.BindType.BINDTYPE_NONE then

			-- initialize the dialog text
			local body = GetStringFromTid( MacroWindow.TID_BINDING_CONFLICT_BODY )..L"\n\n"..HotbarSystem.GetKeyName(SystemData.BindingConflictHotbarId, SystemData.BindingConflictItemIndex, SystemData.BindingConflictType)..L"\n\n"..GetStringFromTid( MacroWindow.TID_BINDING_CONFLICT_QUESTION )
			
			-- YES button callback
			local yesButton = { textTid = MacroWindow.TID_YES,
								callback =	function()
											HotbarSystem.ReplaceKey(
												SystemData.BindingConflictHotbarId, SystemData.BindingConflictItemIndex, SystemData.BindingConflictType,
												SystemData.MacroSystem.STATIC_MACRO_ID, MacroWindow.RecordingIndex, SystemData.BindType.BINDTYPE_MACRO,
												SystemData.RecordedKey, L"")
											end
							  }

			-- no button callback
			local noButton = { textTid = MacroWindow.TID_NO }

			-- dialog data
			local windowData = 
			{
				windowName = "MacroWindow", 
				titleTid = MacroWindow.TID_BINDING_CONFLICT_TITLE, 
				body = body, 
				buttons = { yesButton, noButton },
				closeCallback = noButton.callback,
				destroyDuplicate = true,
			}

			-- show the dialog
			UO_StandardDialog.CreateDialog( windowData )

	    else -- no conflict, assign the hotkey
            UserActionMacroUpdateBinding(SystemData.MacroSystem.STATIC_MACRO_ID, MacroWindow.RecordingIndex, SystemData.RecordedKey)

			-- macro keybinding text
		    local MacroLabel = "MacroScrollWindowScrollChildItem" .. MacroWindow.RecordingIndex .. "Binding"

			-- does the label exist?
			if DoesWindowExist(MacroLabel) then

				-- do we have an hotkey?
				if (SystemData.RecordedKey ~= L"") then
					
					-- update the binding text and color
					MacroWindow.UpdateBindingText(MacroLabel, SystemData.RecordedKey)

				else -- reset the label color
					LabelSetTextColor( MacroLabel, 243, 227, 49 )

					-- reset the text to: NO KEYBINDING
					LabelSetText(MacroLabel, GetStringFromTid(MacroWindow.TID_NO_KEYBINDING))
				end
			end
		end

		-- are we recording a spellbook key?
		if MacroWindow.RecordingKeySpellbook then

			-- is the spellbook visible?
			if DoesWindowExist(MacroWindow.RecordingKeySpellbook) then

				-- get the tab ID
				local id = WindowGetId(MacroWindow.RecordingKeySpellbook)

				-- update the spellbook tab
				Spellbook.ShowTab(Spellbook.GetActiveTab(id), MacroWindow.RecordingKeySpellbook ) 
			end

			-- reset the spellbook hotkey recording
			MacroWindow.RecordingKeySpellbook = nil
		end

		-- are we recording a skill hotkey?
		if MacroWindow.RecordingKeySkill then

			-- is the skill window visible?
			if DoesWindowExist("SkillWindow") and WindowGetShowing("SkillWindow") then

				-- update the skill window tab
				SkillsWindow.ShowTab(SkillsWindow.CurrentTab) 
			end

			-- reset the skill hotkey recording
			MacroWindow.RecordingKeySkill = nil
		end

		-- update the bindings for hotbars
		HotbarSystem.UpdateHotbars()
	end
end

function MacroWindow.KeyCancelRecord()

	-- are we recording something?
	if MacroWindow.RecordingKey == true then

		-- stop the recording
	    MacroWindow.RecordingKey = false

		-- hide the tooltip
		WindowSetShowing("AssignHotkeyInfo", false)
	end
end

function MacroWindow.GetMacroId(macro)

	-- is this a valid macro name?
	if not IsValidWString(macro) then
		return 0
	end

	-- get the number of macros
	local numMacros = MacroSystemGetNumMacros()

	-- scan all macros
	for i = 1, numMacros do

		-- get the macro name
		local macroName = UserActionMacroGetName(SystemData.MacroSystem.STATIC_MACRO_ID, i)

		-- is this the macro we're looking for?
		if macro == macroName then
			return i
		end
	end
	return 0
end