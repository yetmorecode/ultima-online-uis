
----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

MacroEditWindow = {}

MacroEditWindow.TID_EDIT_MACRO = 1111854
MacroEditWindow.TID_REPEAT = 1079431 -- "Enable Repeating"
MacroEditWindow.TID_REPEAT_TIMES = 1079432 -- "Repeat this many times:"
MacroEditWindow.TID_MACRO_ICON_TOOLTIP = 1078507
MacroEditWindow.TID_MACRO_DRAG_TOOLTIP = 1078508
MacroEditWindow.TID_MACRO_DRAG_EQUIP_TOOLTIP = 1078617
MacroEditWindow.TID_MACRO_DRAG_TARGET_BY_RESOURCE_TOOLTIP = 1079429

MacroEditWindow.MACRO_SCROLLWINDOW_WIDTH = 310
MacroEditWindow.MACRO_ACTION_WIDTH = 50

MacroEditWindow.Macro = {}
MacroEditWindow.Macro.NumActionsCreated = 0

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function MacroEditWindow.Initialize()

	-- current window name
	local windowName = SystemData.ActiveWindow.name	

	-- add the ok button text
	ButtonSetText(windowName .. "OKButton", GetStringFromTid(ActionEditWindow.TID_OK))

	-- add window title
	WindowUtils.SetWindowTitle("ActionEditMacro", GetStringFromTid(MacroEditWindow.TID_EDIT_MACRO))

	-- attach the ok button function to the window close event
	Interface.OnCloseCallBack[windowName] = MacroEditWindow.MacroEditOK

	-- restore the window position
	WindowUtils.RestoreWindowPosition(windowName, false, "MacroEditWindow", true)
end

function MacroEditWindow.Shutdown()

	-- current window name
	local windowName = SystemData.ActiveWindow.name	
		
	-- save the window position
	WindowUtils.SaveWindowPosition(windowName, false, "MacroEditWindow")
end

function MacroEditWindow.UpdateMacroActionList(editWindow, hotbarId, itemIndex)

	-- get the number of elements of the macro
	local numActions = UserActionMacroGetNumActions(hotbarId, itemIndex)

	-- scan all elements
	for i = 1, numActions do

		-- element name
		local actionWindowName = editWindow .. "MacroActionsScrollChildItem" .. i

		-- is this a new action?
		if i > MacroEditWindow.Macro.NumActionsCreated then
			
			-- create a new element
			CreateWindowFromTemplate(actionWindowName, "MacroActionDef", editWindow .. "ActionsScrollChild")

			-- attach the ID to the element
			WindowSetId(actionWindowName, i)

			-- hide the hotkey background (not used inside macros)
			WindowSetShowing(actionWindowName .. "HotkeyBackground", false)
			
			-- increase the number of active elements
			MacroEditWindow.Macro.NumActionsCreated = MacroEditWindow.Macro.NumActionsCreated + 1

		else -- clear the action in the slot
			HotbarSystem.ClearActionIcon(actionWindowName, hotbarId, itemIndex, i)
		end
		
		-- reset the anchors for the element
		WindowClearAnchors(actionWindowName)

		-- is this the first element?
		if i == 1 then

			-- anchor the element on the top-left of the window
         	WindowAddAnchor( actionWindowName, "topleft", editWindow.."ActionsScrollChild", "topleft", 0, 0)    

		else -- any other elements are anchored to the previous one
        	WindowAddAnchor(actionWindowName, "right", editWindow .. "MacroActionsScrollChildItem" .. (i - 1), "left", 0, 0)
		end
		
		-- register the action in the slot
		HotbarSystem.RegisterAction(actionWindowName, hotbarId, itemIndex, i)

		-- showing the background
		WindowSetShowing(actionWindowName .. "SquareIconBG", true)

		-- is the slot enabled?
		if UserActionIsTargetModeCompat(hotbarId, itemIndex, i) then

			-- disable the disabled mask
			WindowSetShowing(actionWindowName .. "Disabled", false)

			-- enable the button
			ButtonSetDisabledFlag(actionWindowName, false)

		else -- disable the slot
			WindowSetShowing(actionWindowName .. "Disabled", true)
			ButtonSetDisabledFlag(actionWindowName, true)
		end
	end
	
	-- empty button element slot
	local emptyButtonName = editWindow.."ActionsScrollChildEmptyButton"

	-- destroy the empty slot
	if DoesWindowExist(emptyButtonName) then
		DestroyWindow(emptyButtonName)
	end

	-- create the empty slot
	CreateWindowFromTemplate(emptyButtonName, "EmptyActionButtonDef", editWindow .. "ActionsScrollChild")

	-- clear slot anchors
	WindowClearAnchors(emptyButtonName)

	-- attach the ID to the slot
	WindowSetId(emptyButtonName, numActions + 1)

	-- is this the first element?
	if numActions == 0 then
		
		-- attach the slot to the top-left of the window
		WindowAddAnchor(emptyButtonName, "topleft", editWindow .. "ActionsScrollChild", "topleft", 0, 0)

	else -- attach the slot to the previous element
		WindowAddAnchor(emptyButtonName, "right", editWindow .. "MacroActionsScrollChildItem" .. numActions, "left", 0, 0)
	end
		
	-- update the scroll window
	HorizontalScrollWindowUpdateScrollRect(editWindow .. "Actions")

	-- we scroll to the last element
	WindowUtils.ScrollToElementInHorizontalScrollWindow(MacroEditWindow.scrollToSlot or emptyButtonName, editWindow .. "Actions", editWindow .. "ActionsScrollChild")
end

function MacroEditWindow.UpdateMacroEdit(editWindow, hotbarId, itemIndex)

	-- macro element name
    local currentMacroWindowName = "MacroScrollWindowScrollChildItem" .. itemIndex
	
	-- is the macro window open?
	if DoesWindowExist(currentMacroWindowName) then

		-- show the highlight border
		WindowSetShowing(currentMacroWindowName .. "Highlight", true)
	end

	-- set repeat button text
	LabelSetText(editWindow .. "RepeatToggleLabel", GetStringFromTid(MacroEditWindow.TID_REPEAT))

	-- "repeat" text
	LabelSetText(editWindow .. "RepeatText", GetStringFromTid(MacroEditWindow.TID_REPEAT_TIMES))
	
	-- get the amount of repetitions
	local count = UserActionMacroGetRepeatCount(hotbarId, itemIndex)

	-- show the number of repetitions
	LabelSetText( editWindow .. "RepeatVal", towstring(tostring(count)) )

	-- calculate the slider position
	local position = ( count - 2 ) / 8.0

	-- set the slider position
	SliderBarSetCurrentPosition( editWindow .. "RepeatSliderBar", position )

	-- turn the button into a checkbox
	ButtonSetStayDownFlag( editWindow .. "RepeatToggleButton", true )
	ButtonSetCheckButtonFlag( editWindow .. "RepeatToggleButton", true )

	-- is the repetition active?
	local bRepeat = UserActionMacroGetRepeatEnabled( hotbarId, itemIndex )

	-- update the flag on the checkbox
	ButtonSetPressedFlag( editWindow.."RepeatToggleButton", bRepeat )
	
	-- get the macro name
	local macroName = UserActionMacroGetName(hotbarId, itemIndex)

	-- update the macro name
	TextEditBoxSetText(editWindow.."NameEntry", macroName)
	
	-- get the macro's icon ID
	local iconId = UserActionGetIconId(hotbarId, itemIndex, 0)

	-- get the icon data
	local texture, x, y = GetIconData(iconId)

	-- draw the macro icon
	DynamicImageSetTexture( editWindow .. "NameIcon", texture, x, y )
	
	-- draw the macro background
	DynamicImageSetTexture( editWindow.."NameIconBG", MiniTexturePack.DB[Interface.Settings.MTP_Current].texture .. "Icon", x, y )
	
	-- set the scroll position to the beginning
	HorizontalScrollWindowSetOffset(editWindow.."Actions", 0)
	
	-- update the actions list
	MacroEditWindow.UpdateMacroActionList(editWindow, hotbarId, itemIndex)
end

function MacroEditWindow.MacroEditOK()
	
	-- current hotbar ID
	local hotbarId = ActionEditWindow.CurEditItem.hotbarId

	-- get the current item index (which is the macro ID)
	local itemIndex = ActionEditWindow.CurEditItem.itemIndex

	-- get the number of actions for this macro
	local numActions = UserActionMacroGetNumActions(hotbarId, itemIndex)
	
	-- is the macro empty?
	if numActions == 0 then
		
		-- delete the macro
		MacroSystemDeleteMacroItem(itemIndex)

	-- does the edit window exist?
	elseif DoesWindowExist(ActionEditWindow.CurEditItem.windowName) then

		-- get the slidebar position
		local position = SliderBarGetCurrentPosition( ActionEditWindow.CurEditItem.windowName .. "RepeatSliderBar" )

		-- calculate the number of repetitions
		local count = math.floor( ( position * 8 ) + 2 )

		-- update the macro with the repeat count
		UserActionMacroSetRepeatCount( hotbarId, itemIndex, count )

		-- is the repetition active?
		local repeats = ButtonGetPressedFlag( ActionEditWindow.CurEditItem.windowName .. "RepeatToggleButton" )

		-- save the repeat flag
		UserActionMacroSetRepeatEnabled( hotbarId, itemIndex, repeats )
		
		-- update the macro name
		UserActionMacroSetName(hotbarId, itemIndex, ActionEditMacroNameEntry.Text)
	end
	
	-- update the macro list window
	MacroWindow.DisplayMacroList()

	-- refresh the hotbar slot of this macro
	HotbarSystem.UpdateMacroReferenceSlot(itemIndex)
	
	-- clear all slots
	MacroEditWindow.ClearAllActions()

	-- close any edit subwindow if it exists
	if (ActionEditWindow.CurEditMacroItem ~= nil) then
		WindowSetShowing(ActionEditWindow.CurEditMacroItem.windowName, false)
		ActionEditWindow.CurEditMacroItem = nil
	end

	-- macro element name
    local currentMacroWindowName = "MacroScrollWindowScrollChildItem" .. itemIndex
	
	-- is the macro window open?
	if DoesWindowExist(currentMacroWindowName) then

		-- hide the highlight border
		WindowSetShowing(currentMacroWindowName .. "Highlight", false)
	end

	-- save the window position
	WindowUtils.SaveWindowPosition(ActionEditWindow.CurEditItem.windowName, false, "MacroEditWindow")
	
	-- hide the edit window
	WindowSetShowing(ActionEditWindow.CurEditItem.windowName, false)
	
	-- clear the current edit data
	ActionEditWindow.CurEditItem = nil
	
	-- close the actions window
	WindowSetShowing("ActionsWindow", false) 
	
	-- close the icon picker window (if is open)
	if DoesWindowExist("MacroIconPickerWindow") then
	    DestroyWindow("MacroIconPickerWindow")
	end

	-- is the macro window open?
	if DoesWindowExist(currentMacroWindowName) then

		-- scroll to the macro in the list
		WindowUtils.ScrollToElementInScrollWindow( currentMacroWindowName, "MacroScrollWindow", "MacroScrollWindowScrollChild", 50 )
	end
end

function MacroEditWindow.ClearAllActions()

	-- scan all existing elements
	for i = 1, MacroEditWindow.Macro.NumActionsCreated + 1 do

		-- element name
		local actionWindowName = "ActionEditMacro" .. "MacroActionsScrollChildItem" .. i

		-- does the slot exist?
		if DoesWindowExist(actionWindowName) then

			-- clear the slot
			HotbarSystem.ClearActionIcon(actionWindowName, hotbarId, itemIndex, i, true)

			-- destroy the slot
			DestroyWindow(actionWindowName)
		end
	end

	-- reset the actions count
	MacroEditWindow.Macro.NumActionsCreated = 0
end

function MacroEditWindow.MacroActionLButtonDown()

	-- current slot window name
	local slotName = SystemData.ActiveWindow.name

	-- parent window name
	local parent = WindowUtils.GetActiveDialog()

	-- get the macro data
	local hotbarId, itemIndex, subIndex = ActionEditWindow.GetCurrentEditData()

	-- get the element subIndex
	subIndex = WindowGetId(slotName)
	
	-- drag the element in the slot
	DragSlotSetExistingActionMouseClickData(hotbarId, itemIndex, subIndex)

	-- clear all slots
	MacroEditWindow.ClearAllActions()

	-- update the actions list
	MacroEditWindow.UpdateMacroActionList(parent, hotbarId, itemIndex)
end

function MacroEditWindow.MacroActionLButtonUp(auto)
	
	-- are we dragging something?
	if (SystemData.DragItem.DragType ~= SystemData.DragItem.TYPE_NONE) then

		-- slot window name
		local slotName = SystemData.ActiveWindow.name

		-- parent window name
		local parent = WindowUtils.GetActiveDialog()

		-- current action macro data
		local hotbarId, itemIndex, subIndex = ActionEditWindow.GetCurrentEditData()

		-- initialize the ability ID
		local actionIndex

		-- is the auto-drag active?
		if type(auto) == "boolean" and auto == true and Spellbook.DragSpell then

			-- override slot name
			slotName = "ActionEditMacroActionsScrollChildEmptyButton"

			-- override parent
			parent = "ActionEditMacro"
			
			-- override hotbar ID
			hotbarId = SystemData.MacroSystem.STATIC_MACRO_ID

			-- override macro ID
			itemIndex = Spellbook.DragSpell.macroIndex

			-- override current action edit data
			ActionEditWindow.CurEditItem = {}
			ActionEditWindow.CurEditItem.hotbarId = hotbarId
			ActionEditWindow.CurEditItem.itemIndex = itemIndex

			-- override the sub index
			subIndex = 1

			-- set the action ID
			actionIndex = Spellbook.DragSpell.abilityId

		else
			-- set the current action ID
			actionIndex = WindowGetId(slotName)
		end

		-- are we dragging a pet summoning ball? this kind of item cannot be used in macros.
		if SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM and SystemData.DragItem.itemType == Actions.PetBallType and SystemData.DragItem.itemHueId == 0 and ItemProperties.DoesItemHasProperty(SystemData.DragItem.itemId, 1054131) then   -- a crystal ball of pet summoning: [charges: ~1_charges~] : [linked pet: ~2_petName~]
			return
		end
		
		-- drop the action in the slot
	    local dropSuccess = DragSlotDropAction(hotbarId, itemIndex, actionIndex)

		-- get the action type
        local actionType = UserActionGetType(hotbarId, itemIndex, actionIndex)
	    
		-- get the action ID
	    local actionId = UserActionGetId(hotbarId, itemIndex, actionIndex)

		-- is the action ID 0?
		if actionId == 0 and ActionsWindow.LastDrag ~= 0 then

			-- we use the last dragged action
			actionId = ActionsWindow.LastDrag
			
			-- reset the last dragged action
			ActionsWindow.LastDrag = 0

			-- do we have a valid action data?
			if ActionsWindow.ActionData[actionId] then

				-- get the type from the action data
				actionType = ActionsWindow.ActionData[actionId].type
			end
		end
		
		-- is this the item properties slot?
	    if ActionsWindow.CustomEdit(actionId) and actionId == 5752 then

			-- cancel the action drop
			dropSuccess = false
		end

		-- is the drop successful?
	    if dropSuccess then		

			-- save the slot to scroll to
			MacroEditWindow.scrollToSlot = slotName

			-- update the actions list
            MacroEditWindow.UpdateMacroActionList("ActionEditMacro", hotbarId, itemIndex)

			 -- open the actions window
    		WindowSetShowing("ActionsWindow", true)

	    	-- does this action requires to open an edit window?
			local _, openEdit = pcall(ActionsWindow.InitializeActionSlotCallback, {actionId, actionType, slotName, hotbarId, itemIndex, actionIndex})

			-- if it does we open the edit window
			if openEdit then
				ActionEditWindow.OpenEditWindow(actionId, actionType, slotName, hotbarId, itemIndex, actionIndex)
			end
		end

		-- is this an automated macro creation?
		if Spellbook.DragSpell then

			-- do we have a macro creation warning?
			if DoesWindowExist("SpellWarningDialog") then

				-- destroy the warning popup
				DestroyWindow("SpellWarningDialog")
			end

			-- are we dragging a spell?
			if Spellbook.DragSpell.isSpell then
				
				-- update the spellbook tab
				Spellbook.ShowTab(Spellbook.GetActiveTab(Spellbook.DragSpell.spellbookId), "Spellbook_" .. Spellbook.DragSpell.spellbookId ) 

			-- are we dragging a skill?
			elseif Spellbook.DragSpell.isSkill then

				-- is the skill window visible?
				if DoesWindowExist("SkillWindow") and WindowGetShowing("SkillWindow") then

					-- update the skill tab
					SkillsWindow.ShowTab(SkillsWindow.CurrentTab)
				end
			end

			-- reset the automated macro creation data
			Spellbook.DragSpell = nil

			-- save and close the macro edit window
			MacroEditWindow.MacroEditOK()
		end
	end
end

function MacroEditWindow.MacroActionRButtonUp()

	-- current window name
	local windowName = SystemData.ActiveWindow.name

	-- get the action ID
	local actionIndex = WindowGetId(windowName)

	-- get the hotbar ID
	local hotbarId = ActionEditWindow.CurEditItem.hotbarId

	-- get the macro ID
	local itemIndex = ActionEditWindow.CurEditItem.itemIndex

	-- reset the context menu
	ContextMenu.CleanUp()

	-- create the context menu
	HotbarSystem.CreateUserActionContextMenuOptions(hotbarId, itemIndex, actionIndex, windowName)
	
	-- show the context menu
	ContextMenu.ActivateLuaContextMenu(MacroEditWindow.ContextMenuCallback)
end

function MacroEditWindow.ContextMenuCallback(returnCode, param)

	-- do we have the parameters?
	if (param ~= nil) then

		-- has the context menu been handled?
		local bHandled = HotbarSystem.ContextMenuCallback(returnCode, param) 
		
		-- if the context menu wasn't handled then check for macro action specific options
		if bHandled == false then

			-- clear action
			if returnCode == HotbarSystem.ContextReturnCodes.CLEAR_ITEM then
				
				-- remove the action
				UserActionMacroRemoveAction(param.HotbarId, param.ItemIndex, param.SubIndex)

				-- clear the mouse over target for the slot
				HotbarSystem.UpdateTargetMouseOver(param.HotbarId, param.ItemIndex, param.SubIndex, nil)

				-- clear the slot
				HotbarSystem.ClearActionIcon(actionWindowName, param.HotbarId, param.ItemIndex, param.SubIndex)

				-- clear all slots
				MacroEditWindow.ClearAllActions()

				-- update the actions list
				MacroEditWindow.UpdateMacroActionList("ActionEditMacro", param.HotbarId, param.ItemIndex)
			end
		end
	end	
end

function MacroEditWindow.MacroActionMouseOver()
	
	-- basic IDs for the hotbar items
	local hotbarId = ActionEditWindow.CurEditItem.hotbarId
	local itemIndex = ActionEditWindow.CurEditItem.itemIndex	
	local subIndex = WindowGetId(SystemData.ActiveWindow.name)
	local fakeId = 1234 -- fake item id used to show plain text

	-- current window name
	local slotWindow = SystemData.ActiveWindow.name
	
	-- get the action ID
	local actionId = UserActionGetId(hotbarId, itemIndex, subIndex)

	-- getting the current slot action type
	local actionType = UserActionGetType(hotbarId, itemIndex, subIndex)

	-- no binding here
	local bindingText = L""

	-- default target text
	local targetText = L""

	-- does the action requires a target?
	if (( UserActionHasTargetType(hotbarId, itemIndex, subIndex) ) and ( SystemData.Settings.GameOptions.legacyTargeting == false )) then
		
		-- getting the target type actually set
		local targetType = UserActionGetTargetType(hotbarId, itemIndex, subIndex, slotWindow)

		-- get the string name of the current target
		local targetString = Hotbar.TargetTypeToWStringName(targetType)

		-- if we have a string name we attach it to the prefix
		if IsValidWString(targetString) then
			-- "target:" text prefix + target name
			targetText = GetStringFromTid(Hotbar.TID_TARGET) .. L" " .. targetString
		end
	end

	-- setting the level of details to short by default
	local detailType = ItemProperties.DETAIL_SHORT

	-- if the player have set it so, we give more details
	if (SystemData.Settings.Interface.showTooltips) then

		detailType = ItemProperties.DETAIL_LONG
	end

	-- mount blockbar has a specific text to show
	if hotbarId == Interface.MountBlockbar then
		
		-- reset the window properties array (if different from the one last we have seen)
		pcall(ItemProperties.ResetWindowDataProperties, fakeId)

		-- item properties params array
		local itemData = {	
							windowName = slotWindow,
							itemId = fakeId,
							itemLoc = {hotbarId=hotbarId, itemIndex=itemIndex},
							binding = bindingText, -- As defined above
							itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
							detail = detailType,
							title = GetStringFromTid(290),
							body = GetStringFromTid(291),
						}

		-- showing the properties
		ItemProperties.SetActiveItem(itemData)

		return

	-- items (non-stackable). actionId is the item id
	elseif actionType == SystemData.UserAction.TYPE_USE_ITEM then

		-- reset the window properties array (if different from the one last we have seen)
		pcall(ItemProperties.ResetWindowDataProperties, actionId)

		-- if the slot is enabled, we just show the info about the skill
		if DoesPlayerHaveItem(actionId) then
		
			-- item properties params array
			local itemData = { 
								windowName = slotWindow,
								itemId = actionId,
								itemType = WindowData.ItemProperties.TYPE_ITEM,
								detail = detailType,
								itemLoc = {hotbarId=hotbarId, itemIndex=itemIndex},
								binding = bindingText,
								myTarget = targetText, 
							}
			-- showing the properties
			ItemProperties.SetActiveItem(itemData)

			return

		else -- if the slot is NOT enabled, we must show why
			
			-- reset the window properties array (if different from the one last we have seen)
			pcall(ItemProperties.ResetWindowDataProperties, fakeId)

			-- item name
			local name = Interface.LoadSetting(slotWindow.."ItemName", L"")	

			-- default desc value
			local desc = L""

			-- You cannot use this ability while dead.
			if Interface.IsPlayerDead then
				desc = desc .. GetStringFromTid(1060169) .. L"\n"

			-- You cannot use this ability while frozen.
			elseif (CustomBuffs.StunTime > 0 or BuffDebuff.Timers[1037]) then	
				desc = desc .. GetStringFromTid(502646) .. L"\n"

			-- item not available 
			else
				desc = desc .. GetStringFromTid(1094717) -- (Not Available)
			end

			-- item properties params array
			local itemData = { 
								windowName = slotWindow,
								itemId = fakeId,
								detail = detailType,
								itemLoc = {hotbarId=hotbarId, itemIndex=itemIndex},
								itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
								binding = bindingText ,
								myTarget = targetText,
								title =	name,
								body = desc
							}

			-- showing the properties
			ItemProperties.SetActiveItem(itemData)	

			return
		end

	-- items (stackable). actionId is the object type
	elseif actionType == SystemData.UserAction.TYPE_USE_OBJECTTYPE then

		-- getting the id of an item of that type
		local itemId = UserActionGetNextObjectId(actionId)

		-- if the slot is enabled, we just show the info about the skill
		if IsValidID(itemId) then

			-- reset the window properties array (if different from the one last we have seen)
			pcall(ItemProperties.ResetWindowDataProperties, itemId)

			-- item properties params array
			local itemData = { 
								windowName = slotWindow,
								itemId = itemId,
								itemType = WindowData.ItemProperties.TYPE_ITEM,
								detail = detailType,
								itemLoc = {hotbarId=hotbarId, itemIndex=itemIndex},
								binding = bindingText,
								myTarget = targetText, 
							}
			-- showing the properties
			ItemProperties.SetActiveItem(itemData)

			return
		else -- if the slot is NOT enabled, we must show why
			
			-- reset the window properties array (if different from the one last we have seen)
			pcall(ItemProperties.ResetWindowDataProperties, fakeId)

			-- item name
			local name = Interface.LoadSetting(slotWindow.."ItemName", L"")	
			
			-- default desc value
			local desc = L""

			-- You cannot use this ability while dead.
			if Interface.IsPlayerDead then
				desc = desc .. GetStringFromTid(1060169) .. L"\n"

			-- You cannot use this ability while frozen.
			elseif (CustomBuffs.StunTime > 0 or BuffDebuff.Timers[1037]) then	
				desc = desc .. GetStringFromTid(502646) .. L"\n"

			-- item not available 
			else
				desc = desc .. GetStringFromTid(1094717) -- (Not Available)
			end

			-- item properties params array
			local itemData = { 
								windowName = slotWindow,
								itemId = fakeId,
								detail = detailType,
								itemLoc = {hotbarId=hotbarId, itemIndex=itemIndex},
								itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
								binding = bindingText ,
								myTarget = targetText,
								title =	name,
								body = desc
							}

			-- showing the properties
			ItemProperties.SetActiveItem(itemData)	

			return
		end

	-- virtues
	elseif actionType == SystemData.UserAction.TYPE_INVOKE_VIRTUE then

		-- getting the action data record for the current action
		local actionData = ActionsWindow.ActionData[actionId]

		-- get the current virtue id
		local itemId = actionData.invokeId

		-- reset the window properties array (if different from the one last we have seen)
		pcall(ItemProperties.ResetWindowDataProperties, itemId)

		-- item properties params array
		local itemData = { 
							windowName = slotWindow,
							itemId = itemId,
							itemType = WindowData.ItemProperties.TYPE_ACTION,
							actionType = actionType,
							detail = detailType,
							itemLoc = {hotbarId=hotbarId, itemIndex=itemIndex},
							binding = bindingText,
							myTarget = targetText,
						}

		-- showing the properties
		ItemProperties.SetActiveItem(itemData)	

		return

	-- weapons abilities
	elseif actionType == SystemData.UserAction.TYPE_WEAPON_ABILITY then
		
		-- if the slot is enabled, we just show the info about the weapon ability as it is
		if Hotbar.IsSlotEnabled(hotbarId, itemIndex) then
			
			-- reset the window properties array (if different from the one last we have seen)
			pcall(ItemProperties.ResetWindowDataProperties, actionId)

			-- item properties params array
			local itemData = { 
								windowName = slotWindow,
								itemId = actionId,
								itemType = WindowData.ItemProperties.TYPE_ACTION,
								actionType = actionType,
								detail = detailType,
								itemLoc = {hotbarId=hotbarId, itemIndex=itemIndex},
								binding = bindingText, 
								myTarget = targetText, 
							}

			-- showing the properties
			ItemProperties.SetActiveItem(itemData)	

			return

		else -- if the slot is NOT enabled, we must show why
			
			-- reset the window properties array (if different from the one last we have seen)
			pcall(ItemProperties.ResetWindowDataProperties, fakeId)

			-- get the correct action ID
			actionId = EquipmentData.GetWeaponAbilityId(actionId) + CharacterAbilities.WEAPONABILITY_OFFSET

			-- item properties params array
			local itemData = Hotbar.GetDisabledInfoArray(actionId, actionType, targetType, detailType, slotWindow)
			
			-- adding the missing data
			itemData.windowName = slotWindow
			itemData.itemId = fakeId
			itemData.itemLoc = {hotbarId=hotbarId, itemIndex=itemIndex}
			itemData.binding = bindingText 
			itemData.myTarget = targetText

			-- showing the properties
			ItemProperties.SetActiveItem(itemData)	

			return
		end

	-- spells
	elseif actionType == SystemData.UserAction.TYPE_SPELL then
		
		-- if the slot is enabled, we just show the info about the spell as it is
		if Hotbar.IsSlotEnabled(hotbarId, itemIndex) then
			
			-- reset the window properties array (if different from the one last we have seen)
			pcall(ItemProperties.ResetWindowDataProperties, actionId)

			-- item properties params array
			local itemData = { 
								windowName = slotWindow,
								itemId = actionId,
								itemType = WindowData.ItemProperties.TYPE_ACTION,
								actionType = actionType,
								detail = detailType,
								itemLoc = {hotbarId=hotbarId, itemIndex=itemIndex},
								binding = bindingText, 
								myTarget = targetText, 
							}

			-- showing the properties
			ItemProperties.SetActiveItem(itemData)	

			return

		else -- if the slot is NOT enabled, we must show why
			
			-- reset the window properties array (if different from the one last we have seen)
			pcall(ItemProperties.ResetWindowDataProperties, fakeId)

			-- item properties params array
			local itemData = Hotbar.GetDisabledInfoArray(actionId, actionType, targetType, detailType, slotWindow)
			
			-- adding the missing data
			itemData.windowName = slotWindow
			itemData.itemId = fakeId
			itemData.itemLoc = {hotbarId=hotbarId, itemIndex=itemIndex}
			itemData.binding = bindingText 
			itemData.myTarget = targetText

			-- showing the properties
			ItemProperties.SetActiveItem(itemData)	

			return
		end

	elseif HotbarSystem.IsHotbarMacro(actionType) then
			
		-- reset the window properties array (if different from the one last we have seen)
		pcall(ItemProperties.ResetWindowDataProperties, fakeId)

		-- the ID is the macro ID of when it was dropped on the slot, this function will give us the real ID
		local macroIndex = MacroSystemGetMacroIndexById(actionId)

		-- get the macro name
		local macroName = UserActionMacroGetName(SystemData.MacroSystem.STATIC_MACRO_ID, macroIndex)

		-- get the macro binding
		bindingText = UserActionMacroGetBinding(SystemData.MacroSystem.STATIC_MACRO_ID, macroIndex) or L""

		-- item properties params array
		local itemData = {	
							windowName = slotWindow,
							itemId = fakeId,
							itemLoc = {hotbarId=hotbarId, itemIndex=itemIndex},
							binding = bindingText, -- As defined above
							itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
							detail = detailType,
							binding = bindingStr,
							title = macroName,
							body = L"",
						}

		-- showing the properties
		ItemProperties.SetActiveItem(itemData)

		return

	-- Skills
	elseif actionType == SystemData.UserAction.TYPE_SKILL then
		
		-- if the slot is enabled, we just show the info about the skill
		if Hotbar.IsSlotEnabled(hotbarId, itemIndex) then

			-- reset the window properties array (if different from the one last we have seen)
			pcall(ItemProperties.ResetWindowDataProperties, actionId + 1)

			-- we add before the binding the current skill value
			local skillValue = L"\n".. GetStringFromTid(1062298) .. L" " .. SkillsWindow.FormatSkillValue(GetSkillValue(actionId+1, SystemData.Settings.Interface.SkillsWindowShowModified, true)) .. L"%" -- Current Value:
			bindingText = skillValue ..L"\n\n"..bindingText
			
			-- item properties params array
			local itemData = { 
								windowName = slotWindow,
								itemId = actionId + 1 ,
								itemType = WindowData.ItemProperties.TYPE_ACTION,
								actionType = actionType,
								detail = detailType,
								itemLoc = {hotbarId=hotbarId, itemIndex=itemIndex},
								binding = bindingText, 
								myTarget = targetText, 
							}

			-- showing the properties
			ItemProperties.SetActiveItem(itemData)	

			return

		else -- if the slot is NOT enabled, we must show why
			
			-- reset the window properties array (if different from the one last we have seen)
			pcall(ItemProperties.ResetWindowDataProperties, fakeId)

			-- skill name
			local name = GetStringFromTid(WindowData.SkillsCSV[actionId].NameTid)	

			-- default desc value
			local desc = L""

			-- You cannot use this ability while dead.
			if Interface.IsPlayerDead then
				desc = desc .. GetStringFromTid(1060169) .. L"\n"
			end

			-- item properties params array
			local itemData = { 
								windowName = slotWindow,
								itemId = fakeId,
								detail = detailType,
								itemLoc = {hotbarId=hotbarId, itemIndex=itemIndex},
								itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
								binding = bindingText ,
								myTarget = targetText,
								title =	name,
								body = desc
							}

			-- showing the properties
			ItemProperties.SetActiveItem(itemData)	

			return
		end

	-- player stats
	elseif (actionType == SystemData.UserAction.TYPE_PLAYER_STATS) then
		
		-- reset the window properties array (if different from the one last we have seen)
		pcall(ItemProperties.ResetWindowDataProperties, actionId)

		-- no need to show the binding for stats
		bindingText = L""	

		-- item properties params array
		local itemData = { 
							windowName = slotWindow,
							itemId = actionId,
							itemType = WindowData.ItemProperties.TYPE_ACTION,
							actionType = actionType,
							detail = detailType,
							itemLoc = {hotbarId=hotbarId, itemIndex=itemIndex},
							binding = bindingText, 
							myTarget = targetText, 
						}

		-- showing the properties
		ItemProperties.SetActiveItem(itemData)	

		return

	-- all the other actions
	elseif ActionsWindow.isAction(actionType) then
		
		-- player backpack action
		if (actionId == 5011) then
			
			-- we use its specific function for this
			ItemProperties.OnPlayerBackpackMouseover()

			return
		end

		-- getting the action data for the current action
		local actionData = ActionsWindow.ActionData[actionId]

		-- if there is no action data something is wrong and it's better to get out
		if not actionData then
			return
		end

		-- default name value
		local name = L""

		-- default description value
		local desc = L""

		-- mass organizer
		if (actionId == 5732) then
			
			-- we use the organize ID for the name in this action
			name = ReplaceTokens(GetStringFromTid(1155442), {towstring( Organizer.ActiveOrganizer ) } ) -- Organizer ~1_NAME~

			-- we show the organizer name into the description
			if IsValidWString(Organizer.Organizers_Desc[Organizer.ActiveOrganizer]) then
				desc = desc .. L"\n\n" .. ReplaceTokens(GetStringFromTid(1154934), {Organizer.Organizers_Desc[Organizer.ActiveOrganizer]}) -- \\nCurrent: ~1_NAME~
			end
		
		-- TID name
		elseif (actionData.nameTid) then
			name = GetStringFromTid(actionData.nameTid)

		else -- string name

			name = actionData.nameString
		end

		-- show the detailed description only if it's enabled
		if detailType == ItemProperties.DETAIL_LONG then

			-- TID description
			if (not actionData.detailTid) then
				desc = actionData.detailString

			else -- string description

				desc = GetStringFromTid(actionData.detailTid)
			end
		end

		-- boat command actions cannot be used while piloting a ship
		if ((actionId >= 37 and actionId <= 50) or (actionId >= 5150 and actionId <= 5153)) and Interface.IsPilotingAShip then

			desc = desc .. L"\n\n" .. GetStringFromTid(264)
		end

		-- delay
		if actionType == SystemData.UserAction.TYPE_DELAY then

			-- add the delay value
			desc = desc .. L"\n\n" .. ReplaceTokens(GetStringFromTid(310), {towstring( UserActionDelayGetDelay(hotbarId, itemIndex, subIndex) ) } ) 
		end

		-- target resource
		if actionType == SystemData.UserAction.TYPE_TARGET_BY_RESOURCE then

			-- get the object ID
			local objectId = UserActionTargetByResourceGetUseObjectInstanceId(hotbarId, itemIndex, subIndex)
			
			-- do we have a valid object ID?
			if IsValidID(objectId) then

				-- get the resource data
				local resource = ActionEditWindow.ResourceType[UserActionTargetByResourceGetResourceType(hotbarId, itemIndex, subIndex) + 1]

				-- do we have a resource?
				if resource then

					-- add the delay value
					desc = desc .. L"\n\n" .. ReplaceTokens(GetStringFromTid(312), {GetStringFromTid( resource.tid ) } )
				end
			end
		end

		-- command
		if actionId == 57 and actionType == SystemData.UserAction.TYPE_SPEECH_USER_COMMAND then

			-- add the delay value
			desc = desc .. L"\n\n" .. ReplaceTokens(GetStringFromTid(311), {towstring( UserActionSpeechGetText(hotbarId, itemIndex, subIndex) ) } ) 
		end

		-- crat item
		if actionId == 6010 then

			-- getting the current setting
			local command = UserActionSpeechGetText(hotbarId, itemIndex, subIndex)

			-- do we have a command set?
			if command and wstring.find(command, L",", 1, true) then

				-- remove the first part of the command
				local itemTid = wstring.gsub(command, L"script Actions.CraftItem[(]", L"")

				-- remove everything after the comma (that separates the first parameter)
				itemTid = wstring.sub(itemTid, 1, wstring.find(itemTid, L",", 1, true) - 1)

				-- add the current item name
				desc = desc .. L"\n\n" .. ReplaceTokens(GetStringFromTid(659), { GetStringFromTid(tonumber(itemTid)) }) .. L"\n"

			else -- there is no item set!
				desc = desc .. L"\n\n" ..GetStringFromTid(661) .. L"\n"
			end
		end

		-- reset the window properties array (if different from the one last we have seen)
		pcall(ItemProperties.ResetWindowDataProperties, fakeId)

		local itemData = {
							windowName = slotWindow,
							itemId = fakeId,
							detail = ItemProperties.DETAIL_LONG,
							itemLoc = {hotbarId=hotbarId, itemIndex=itemIndex},
							itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
							binding = bindingText, -- As defined above
							title =	name,
							body = desc,
						 }	
		-- showing the properties
		ItemProperties.SetActiveItem(itemData)	

		return
	end	
end

function MacroEditWindow.MacroActionMouseOverEnd()
	
	-- clear the item properties
	ItemProperties.ClearMouseOverItem()
end

function MacroEditWindow.MacroEditIcon()

	-- current window name
	local parentName = SystemData.ActiveWindow.name

	-- is the icon picker visible?
	if not DoesWindowExist("MacroIconPickerWindow") then

		-- create icon picker window
		CreateWindowFromTemplate("MacroIconPickerWindow", "MacroPickerWindowTemplate", "Root")

		-- get the macro's icon ID
		MacroPickerWindow.activeIcon = UserActionGetIconId(ActionEditWindow.CurEditItem.hotbarId, ActionEditWindow.CurEditItem.itemIndex, 0)

		-- find the page of the active icon
		MacroPickerWindow.FindCurrentPage()

		-- draw icons list
		MacroPickerWindow.DrawMacroTable("MacroIconPickerWindow")

	else -- close the icon picker window
		DestroyWindow("MacroIconPickerWindow")

		return
	end
	
	-- clear icon picker window anchors
	WindowClearAnchors("MacroIconPickerWindow")

	-- anchor the icon picker to the edit window
	WindowAddAnchor( "MacroIconPickerWindow", "topleft", parentName, "bottomleft", 0, 0)

	-- show the icon picker
	WindowSetShowing("MacroIconPickerWindow", true)
	
	-- set the callback function to the icon picker
	MacroPickerWindow.SetAfterMacroSelectionFunction(function() MacroEditWindow.MacroEditIconCallback(MacroPickerWindow.MacroSelected) end)
end

function MacroEditWindow.MacroEditIconCallback(newIconId)

	-- get the hotbar id
	local hotbarId = ActionEditWindow.CurEditItem.hotbarId

	-- get macro ID
	local itemIndex = ActionEditWindow.CurEditItem.itemIndex

	-- set the icon to the macro
	UserActionSetIconId(hotbarId, itemIndex, 0, newIconId)

	-- get the icon data
	local texture, x, y = GetIconData(newIconId)

	-- draw the icon
	DynamicImageSetTexture( "ActionEditMacroNameIcon", texture, x, y )
	
	-- destroy the icon picker window
	DestroyWindow("MacroIconPickerWindow")
end

function MacroEditWindow.EmptyButtonMouseOver()

	-- empty button window name
	local buttonName = SystemData.ActiveWindow.name

	-- get the empty slot tooltip text
	local text = GetStringFromTid(MacroEditWindow.TID_MACRO_DRAG_TOOLTIP)

	-- create the tooltip
	Tooltips.CreateTextOnlyTooltip(buttonName, text)
end

function MacroEditWindow.MacroIconMouseOver()

	-- macro icon window name
	local buttonName = SystemData.ActiveWindow.name

	-- get the tooltip text
	local text = GetStringFromTid(MacroEditWindow.TID_MACRO_ICON_TOOLTIP)

	-- create the tooltip
	Tooltips.CreateTextOnlyTooltip(buttonName, text)
end

function MacroEditWindow.UpdateSliderBar()

	-- get the number of repetition slidebar value
	local position = SliderBarGetCurrentPosition(ActionEditWindow.CurEditItem.windowName .. "RepeatSliderBar")

	-- calculate the correct value
	local count = math.floor(( position * 8 ) + 2)

	-- show the slider bar value
	LabelSetText(ActionEditWindow.CurEditItem.windowName .. "RepeatVal", towstring(count))
end
