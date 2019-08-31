
----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

ActionEditWindow = {}

ActionEditWindow.CurEditItem = nil
ActionEditWindow.CurEditMacroItem = nil

ActionEditWindow.TID_OK = 3000093
ActionEditWindow.TID_ADDEQUIPPED = 1114891
ActionEditWindow.TID_CLEARITEMLIST = 1154967

ActionEditWindow.RESOURCE_TID = 1079438 --Choose a resource

ActionEditWindow.Equip = {}
ActionEditWindow.Equip.CurrentItems = {}
ActionEditWindow.Equip.RegisteredObjects = {}

ActionEditWindow.ArmDisarmMaxLength = 4

ActionEditWindow.UnEquip = {}
ActionEditWindow.UnEquip.Slots = {}
ActionEditWindow.UnEquip.Slots[1] = { slot = EquipmentData.EQPOS_HEAD, x = 0, y = 0, texture = "slot_1" }
ActionEditWindow.UnEquip.Slots[2] = { slot = EquipmentData.EQPOS_NECK, x = 0, y = 0, texture = "slot_2"}
ActionEditWindow.UnEquip.Slots[3] = { slot = EquipmentData.EQPOS_ARMS, x = 0, y = 0, texture = "slot_3"}
ActionEditWindow.UnEquip.Slots[4] = { slot = EquipmentData.EQPOS_RIGHTHAND, x = 0, y = 0, texture = "slot_4"}
ActionEditWindow.UnEquip.Slots[5] = { slot = EquipmentData.EQPOS_FINGER1, x = 0, y = 0, texture = "slot_5"}
ActionEditWindow.UnEquip.Slots[6] = { slot = EquipmentData.EQPOS_LEGS, x = 0, y = 0, texture = "slot_6"}
ActionEditWindow.UnEquip.Slots[7] = { slot = EquipmentData.EQPOS_EARS, x = 0, y = 0, texture = "slot_7"}
ActionEditWindow.UnEquip.Slots[8] = { slot = EquipmentData.EQPOS_CHEST,  x = 0, y = 0, texture = "slot_8"}
ActionEditWindow.UnEquip.Slots[9] = { slot = EquipmentData.EQPOS_LWRIST, x = 0, y = 0, texture = "slot_9"}
ActionEditWindow.UnEquip.Slots[10] = { slot = EquipmentData.EQPOS_LEFTHAND, x = 0, y = 0, texture = "slot_10"}
ActionEditWindow.UnEquip.Slots[11] = { slot = EquipmentData.EQPOS_HANDS, x = 0, y = 0, texture = "slot_11" }
ActionEditWindow.UnEquip.Slots[12] = { slot = EquipmentData.EQPOS_TALISMAN, x = 0, y = 0, texture = "slot_12" }
ActionEditWindow.UnEquip.Slots[13] = { slot = EquipmentData.EQPOS_FEET, x = 0, y = 0, texture = "slot_13" }
ActionEditWindow.UnEquip.Slots[14] = { slot = EquipmentData.EQPOS_TORSO, x = 0, y = 0, texture = "slot_14"  }
ActionEditWindow.UnEquip.Slots[15] = { slot = EquipmentData.EQPOS_WAIST, x = 0, y = 0 , texture = "slot_15" }
ActionEditWindow.UnEquip.Slots[16] = { slot = EquipmentData.EQPOS_ABOVECHEST, x = 0, y = 0, texture = "slot_16"  }
ActionEditWindow.UnEquip.Slots[17] = { slot = EquipmentData.EQPOS_CAPE, x = 0, y = 0, texture = "slot_17"  }
ActionEditWindow.UnEquip.Slots[18] = { slot = EquipmentData.EQPOS_DRESS, x = 0, y = 0, texture = "slot_18"  }
ActionEditWindow.UnEquip.Slots[19] = { slot = EquipmentData.EQPOS_SKIRT, x = 0, y = 0, texture = "slot_19"  }

ActionEditWindow.UnEquip.selected = {}

ActionEditWindow.ResourceRegisteredObject = 0

ActionEditWindow.ResourceType = {}
ActionEditWindow.ResourceType[1] = { resourceType = SystemData.UserAction.ERESOURCE_ORE, tid = 1079434 }
ActionEditWindow.ResourceType[2] = { resourceType = SystemData.UserAction.ERESOURCE_SAND, tid = 1044625 }
ActionEditWindow.ResourceType[3] = { resourceType = SystemData.UserAction.ERESOURCE_WOOD, tid = 1079435 }
ActionEditWindow.ResourceType[4] = { resourceType = SystemData.UserAction.ERESOURCE_GRAVE, tid = 1079436 }
ActionEditWindow.ResourceType[5] = { resourceType = SystemData.UserAction.ERESOURCE_RED_MUSHROOM, tid = 1079437 }
ActionEditWindow.ResourceType[6] = { resourceType = SystemData.UserAction.ERESOURCE_WATER, tid = 1115912 }
ActionEditWindow.ResourceType[7] = { resourceType = SystemData.UserAction.ERESOURCE_LAVA, tid = 1153112 }

ActionEditWindow.ResourceCategory = {}
--This category is for the "bladed" script attach chopping wood and getting red mushrooms
ActionEditWindow.ResourceCategory[1] = { 3, 5 }
--This category is for the "mining" script used for mining ore, sand and graves
ActionEditWindow.ResourceCategory[2] = { 1, 2, 4 }
--This category is for the "fishing" script used for water and lava
ActionEditWindow.ResourceCategory[3] = { 6, 7 }
----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function ActionEditWindow.Initialize()

	-- current window name
	local windowName = SystemData.ActiveWindow.name
		
	-- does this edit window has the ok button?
	if DoesWindowExist(windowName .. "OKButton") then

		-- set the OK button text
		ButtonSetText(windowName .. "OKButton", GetStringFromTid(ActionEditWindow.TID_OK))
	end
	
	-- is this an unequip action?
	if windowName == "ActionEditText" then

		-- add the enter callback
		Interface.OnKeyEnterCallback[windowName] = function() ActionEditWindow.TextEditOK() end
	end

	-- is this an unequip action?
	if windowName == "ActionEditSlider" then

		-- add the enter callback
		Interface.OnKeyEnterCallback[windowName] = function() ActionEditWindow.SliderEditOK() end
	end

	-- is this an equip action?
	if windowName == "ActionEditEquip" then
		
		-- add the update object event
		WindowRegisterEventHandler("ActionEditEquip", WindowData.ObjectInfo.Event, "ActionEditWindow.EquipUpdateObject")

		-- set the "Add Equipped" button text
		ButtonSetText(windowName .. "AddEquippedButton", GetStringFromTid(ActionEditWindow.TID_ADDEQUIPPED))

		-- set the "Clear items list" button text
		ButtonSetText(windowName .. "ClearButton", GetStringFromTid(ActionEditWindow.TID_CLEARITEMLIST))

		-- add the enter callback
		Interface.OnKeyEnterCallback[windowName] = function() ActionEditWindow.EquipItemOK() end
	end
	
	-- is this an unequip action?
	if windowName == "ActionEditUnEquip" then

		-- create the unequip slots
		ActionEditWindow.CreateUnequipSlots(windowName)

		-- add the enter callback
		Interface.OnKeyEnterCallback[windowName] = function() ActionEditWindow.UnEquipOK() end
	end
	
	-- is this a arm/disarm action?
	if windowName == "ActionEditArmDisarm" then

		-- create the arm/disarm slots 
		ActionEditWindow.CreateArmDisarmSlots(windowName)

		-- add the enter callback
		Interface.OnKeyEnterCallback[windowName] = function() ActionEditWindow.ArmDisarmOK() end
	end
	
	-- is this the target by resource action?
	if windowName == "ActionEditTargetByResource" then

		-- hide the resource type button, label and combo
		WindowSetShowing(windowName .. "ResourceButton", false)
		WindowSetShowing(windowName .. "ResourceLabel", false)
		WindowSetShowing(windowName .. "ResourceCombo", false)

		-- set the resource type label
		LabelSetText(windowName .. "ResourceLabel", GetStringFromTid(ActionEditWindow.RESOURCE_TID))

		-- load the resources types data table
		UOBuildTableFromCSV("Data/GameData/resourcetype.csv", "ResourceTypeDataCSV")

		-- add the update object event
		WindowRegisterEventHandler("ActionEditTargetByResource", WindowData.ObjectInfo.Event, "ActionEditWindow.TargetByResourceUpdateObject")

		-- add the enter callback
		Interface.OnKeyEnterCallback[windowName] = function() ActionEditWindow.TargetByResourceOK() end
	end
	
	-- add the escape callback
	Interface.OnKeyEscapeCallback[windowName] = function(windowName) ActionEditWindow.HideEditWindow(windowName) end
end

function ActionEditWindow.Shutdown()
	
	-- current window name
	local this = SystemData.ActiveWindow.name

	-- remove the callbacks
	Interface.OnKeyEscapeCallback[this] = nil
	Interface.OnKeyEnterCallback[this] = nil

	-- unload the resources types data table
	UOUnloadCSVTable("ResourceTypeDataCSV")
end

function ActionEditWindow.HideEditWindow(windowName)

	-- do we have the parameter?
	if not windowName then

		-- use the active dialog instead
		windowName = WindowUtils.GetActiveDialog()
	end

	-- prevent the main menu from opening (since this function is always triggered by the ESCAPE button)
	MainMenuWindow.notnow = true

	-- hide the edit window
	WindowSetShowing(windowName, false)
end

function ActionEditWindow.UpdateTextEdit(editWindow, hotbarId, itemIndex, subIndex, actionId)

	-- get the current action custom text
	local speechText = UserActionSpeechGetText(hotbarId, itemIndex, subIndex)
	
	-- do we have a valid string?
	if IsValidWString(speechText) then

		-- send chat message action
		if actionId == 5170 then

			-- remove the function call data so the user can just type the text (that will be added as parameter later)
			speechText = wstring.gsub(speechText, L"\" %)", L"")
			speechText = wstring.gsub(speechText, L"script SendChat%(ChatSettings.Channels%[SystemData.ChatLogFilters.SAY%].serverCmd, L\"/c ", L"" )
			
		-- send guild message action
		elseif actionId == 5171 then

			-- remove the function call data so the user can just type the text (that will be added as parameter later)
			speechText = wstring.gsub(speechText, L"\"[ %)", L"")	
			speechText = wstring.gsub(speechText, L"script SendChat%(ChatSettings.Channels%[SystemData.ChatLogFilters.SAY%].serverCmd, L\"/g ", L"" )
			
		-- send alliance message action
		elseif actionId == 5172 then

			-- remove the function call data so the user can just type the text (that will be added as parameter later)
			speechText = wstring.gsub(speechText, L"\" %)", L"")
			speechText = wstring.gsub(speechText, L"script SendChat%(ChatSettings.Channels%[SystemData.ChatLogFilters.SAY%].serverCmd, L\"/a ", L"" )
			
		-- send party message action
		elseif actionId == 5173 then

			-- remove the function call data so the user can just type the text (that will be added as parameter later)
			speechText = wstring.gsub(speechText, L"\" %)", L"")
			speechText = wstring.gsub(speechText, L"script SendChat%(ChatSettings.Channels%[SystemData.ChatLogFilters.SAY%].serverCmd, L\"/p ", L"" )

		-- send note to self message action
		elseif actionId == 5174 then	

			-- remove the function call data so the user can just type the text (that will be added as parameter later)
			speechText = wstring.gsub(speechText, L"\" %)", L"")
			speechText = wstring.gsub(speechText,  L"script Actions.SendPrivateMSG%(L\"", L"")
			
		-- custom buff actions 
		elseif actionId > 15000 and actionId < 15100 then

			-- get the custom buff ID
			local id = actionId - 15000

			-- remove the function call data so the user can just type the text (that will be added as parameter later)
			speechText = wstring.gsub(speechText,  L"script Actions.CustomBuff%(" .. id .. L", L\"", L"")
			speechText = wstring.gsub(speechText,  L"%)", L"")
			speechText = wstring.gsub(speechText,  L"\" \, ", L"|")
		end
	end

	-- update the text line with the text we have
	TextEditBoxSetText(editWindow .. "Entry", speechText)

	-- focus the text line
	WindowAssignFocus(editWindow .. "Entry", true)
end

function ActionEditWindow.OpenEditWindow(actionId, actionType, anchorWindow, hotbarId, itemIndex, subIndex)
	
	-- subIndex default parameter is 0 (unless is a macro)
	if (subIndex == nil) then
		subIndex = 0
	end
	
	-- make sure the hotbar and slot exist
	if hotbarId ~= SystemData.MacroSystem.STATIC_MACRO_ID and not Hotbar.DoesHotbarExist(hotbarId, true) then
		return
	end
	
	-- is a valid action id?
	if not IsValidID(actionId) then
		return
	end
	
	-- acquiring action data
	local actionData = ActionsWindow.ActionData[actionId]

	-- macros uses its own action data
	if (actionType == SystemData.UserAction.TYPE_MACRO_REFERENCE or actionType == SystemData.UserAction.TYPE_MACRO) then
		actionData = ActionsWindow.ActionData[18]

		-- for macros the item index IS the macro id
		itemIndex = actionId
	end
	
	-- invalid action data
	if actionData == nil then
		return
	end

	-- edit window name
	local windowName = "ActionEdit"

	-- if there is an edit window, we attach the name to what we already have
	if actionData.editWindow then
		windowName = windowName .. actionData.editWindow
	end
		
	-- working the actions data (and is not the command action)
	if ActionsWindow.isAction(actionType) and actionId ~= 57 then
	
		-- equip best weapon (macro only)
		if (actionId == 4137) then

			-- used after the function is called to save the callback
			Actions.ActionEditRequest = { ActionId = actionId, HotbarId = hotbarId, ItemIndex = itemIndex, SubIndex = subIndex }

			-- function to begin the callback edit
			Actions.TargetWeaponType()

			return -- handled in another (non default) way...

		-- target by type
		elseif actionId == 5207 then
			
			-- used after the function is called to save the callback
			Actions.ActionEditRequest = { ActionId = actionId, HotbarId = hotbarId, ItemIndex = itemIndex, SubIndex = subIndex }

			-- function to begin the callback edit
			Actions.TargetType()

			return -- handled in another (non default) way...

		-- target petball (macro only)
		elseif actionId >= 5500 and actionId < 5600 then
			
			-- used after the function is called to save the callback
			Actions.ActionEditRequest = { ActionId = actionId, HotbarId = hotbarId, ItemIndex = itemIndex, SubIndex = subIndex }

			-- function to begin the callback edit
			Actions.TargetPetball()

			return -- handled in another (non default) way...

		-- target mount, bard instruments, boat wheel, and drop into container
		-- all this actions uses the same function to set the callback
		elseif (actionId >= 5600 and actionId < 5700) or (actionId >= 5800 and actionId < 5900) or actionId == 5156 or actionId == 5736 then

			-- used after the function is called to save the callback
			Actions.ActionEditRequest = { ActionId = actionId, HotbarId = hotbarId, ItemIndex = itemIndex, SubIndex = subIndex }

			-- function to begin the callback edit
			Actions.TargetMount()

			return -- handled in another (non default) way...

		-- craft item action
		elseif actionId == 6010 then

			-- used after the function is called to save the callback
			Actions.ActionEditRequest = { ActionId = actionId, HotbarId = hotbarId, ItemIndex = itemIndex, SubIndex = subIndex }

			-- function to begin the callback edit
			Actions.SetCraftItem()

			return -- handled in another (non default) way...
		end
	end
	
	-- make sure there is an edit window
	if DoesWindowExist(windowName) then 
	
		-- setting the id for the window
		WindowSetId(windowName, actionId)
		
		-- if there is no sub index, this action is not within a macro
		if (subIndex == 0) and (actionType == SystemData.UserAction.TYPE_MACRO_REFERENCE or actionType == SystemData.UserAction.TYPE_MACRO) then
			
			-- is the macro edit window already open?
			if DoesWindowExist("ActionEditMacro") and WindowGetShowing("ActionEditMacro") then

				-- save the changes before editing another macro
				MacroEditWindow.MacroEditOK()
			end

			-- show the edit window
			WindowSetShowing(windowName, true)

			-- update the current edit data
			ActionEditWindow.CurEditItem = 
			{
				windowName = windowName,
				hotbarId = hotbarId,
				itemIndex = itemIndex,
				type = actionType,
				actionId = actionId
			}
		
		else -- otherwise this is a macro action so open it in a sub window
		
			-- show the edit window
			WindowSetShowing(windowName, true)

			-- update the current edit data
			ActionEditWindow.CurEditMacroItem =
			{
				windowName = windowName,
				hotbarId = hotbarId,
				itemIndex = itemIndex,				
				subIndex = subIndex,
				type = actionType,
				actionId = actionId
			}
		end

		-- does this edit window has the ok button?
		if DoesWindowExist(windowName .. "OKButton") then

			-- toggle ok button based on the actionData setting
			if actionData.hideOK ~= nil and actionData.hideOK == true then
				WindowSetShowing(windowName .. "OKButton", false)
			else
				WindowSetShowing(windowName .. "OKButton", true)
			end	
		end

		-- set the parameter info label by TID
		if actionData.paramInfoTid ~= nil then
			LabelSetText(windowName .. "ParamInfo", GetStringFromTid(actionData.paramInfoTid))

		-- set the parameter info label by wstring
		elseif actionData.paramInfoText ~= nil then
			LabelSetText(windowName .. "ParamInfo", actionData.paramInfoText)
		end	

		-- anchor it to the window passed in
		if anchorWindow ~= nil and windowName ~= "ActionEditMacro" then
			WindowClearAnchors(windowName)
			WindowAddAnchor(windowName, "topleft", anchorWindow, "bottomleft", 0, -10)	

		-- anchor the macro edit window to the macro window (if it's visible)
		elseif windowName == "ActionEditMacro" and DoesWindowExist("MacroWindow") then
			WindowClearAnchors(windowName)
			WindowAddAnchor(windowName, "topright", "MacroWindow", "topleft", 0, 0)	
		end

		-- speech type action (excluding the equip last slot): textbox (exclude equip last and target first container item)
		if UserActionIsSpeechType(hotbarId, itemIndex, subIndex) == true and actionId ~= 4139 and actionId ~= 5206 then
			ActionEditWindow.UpdateTextEdit(windowName, hotbarId, itemIndex, subIndex, actionId)

		-- delay action: input box dialog
		elseif actionType == SystemData.UserAction.TYPE_DELAY then

			-- create the input box parameters
			local param = { HotbarId = hotbarId, ItemIndex = itemIndex, SubIndex = subIndex }
			local rdata = { title = GetStringFromTid(3002103), subtitle = GetStringFromTid(1155371), callfunction=ActionEditWindow.CustomDelay, id = param }

			-- show the input box
			RenameWindow.Create(rdata)

			-- hide the action edit window
			WindowSetShowing(windowName, false)

		-- macro edit window
		elseif actionType == SystemData.UserAction.TYPE_MACRO or actionType == SystemData.UserAction.TYPE_MACRO_REFERENCE then
			MacroEditWindow.UpdateMacroEdit(windowName, hotbarId, actionId)

		-- equip items list
		elseif actionType == SystemData.UserAction.TYPE_EQUIP_ITEMS then

			-- clear the equip list
			ActionEditWindow.ClearAllEquipSlots()

			-- show the equip list
			ActionEditWindow.UpdateEquipItemEdit(windowName, hotbarId, itemIndex, subIndex)

		-- unequip items list
		elseif actionType == SystemData.UserAction.TYPE_UNEQUIP_ITEMS or actionId == 4139 then
			ActionEditWindow.UpdateUnequipEdit(windowName, hotbarId, itemIndex, subIndex)

			-- is this the equip last action?
			if actionId == 4139 then

				-- getting the callback text from the saved action
				local speechText = UserActionSpeechGetText(hotbarId, itemIndex, subIndex)

				-- marking the selected unequip slots
				pcall(ActionEditWindow.TickUnequipSlotFromCallback, speechText)
			end

		-- arm/disarm slot ticks
		elseif actionType == SystemData.UserAction.TYPE_ARM_DISARM then
			ActionEditWindow.UpdateArmDisarmEdit(windowName, hotbarId, itemIndex, subIndex)

		-- target by resource: insert a tool and pick the resource with the dropdown list
		elseif actionType == SystemData.UserAction.TYPE_TARGET_BY_RESOURCE then
			ActionEditWindow.UpdateTargetByResourceEdit(windowName, hotbarId, itemIndex, subIndex)

		-- target stored: target something and store the value (target first container item uses this for the command line)
		elseif actionType == SystemData.UserAction.TYPE_TARGET_BY_OBJECT_ID or actionId == 5206 then
			ActionEditWindow.UpdateTargetByObjectId()
		end
	end
end

function ActionEditWindow.TickUnequipSlotFromCallback(speechText)

	-- current edit window name
	local windowName = "ActionEditUnEquip"

	-- do we have the parameters already or is the action just being dropped?
	if not wstring.find(speechText, L"{", 1, true) then
		return
	end
	
	-- getting the text between {}
	speechText = wstring.sub(speechText, wstring.find(speechText, L"{", 1, true) + 1)
	speechText = wstring.sub(speechText, 1, wstring.find(speechText, L"}", 1, true) - 1)

	-- separating the text with the comma and creating an array with all the words (equipment slots)
	local slots = string.split(tostring(speechText), ",")

	-- parsing all the slots to find out which one are selected
	for i = 1, #slots do
				
		-- getting the slot id
		local slot = tonumber(slots[i])

		-- is this a valid slot?
		if IsValidID(slot) then

			-- getting which slot is selected
			for id, data in pairs(ActionEditWindow.UnEquip.Slots) do

				-- slot found
				if id == slot then
				
					-- putting a tick into the button
					ButtonSetPressedFlag(windowName .. "ActionsScrollChildSlot" .. id .. "Button", true)

					-- flagging the slot as ticked in the window
					ActionEditWindow.UnEquip.selected[id] = true
				end
			end
		end
	end
end

function ActionEditWindow.CustomDelay(param, text)

	-- get the custom delay value (given from the input box)
	local delayValue = tonumber(text) or 0

	-- do we have a valid delay (> 0) ?
	if IsValidID(delayValue) then

		-- update the delay value
		UserActionDelaySetDelay(param.HotbarId, param.ItemIndex, param.SubIndex, delayValue)
	end
end

function ActionEditWindow.GetCurrentEditData()

	-- initialize the hotbar data variables
	local hotbarId
	local itemIndex
	local subIndex
	local actionId

	-- is this an edit call from an hotbar item?
	if ActionEditWindow.CurEditItem ~= nil then

		-- get the hotbar data
	    hotbarId = ActionEditWindow.CurEditItem.hotbarId
	    itemIndex = ActionEditWindow.CurEditItem.itemIndex
	    subIndex = 0 

		-- get the action ID
		actionId = ActionEditWindow.CurEditItem.actionId
        
	    -- do we have a sub-index too? (this happens when we edit a text inside a macro AFTER editing the macro from an hobar)
	    if ActionEditWindow.CurEditMacroItem ~= nil and WindowGetShowing(ActionEditWindow.CurEditMacroItem.windowName) then 
		    subIndex = ActionEditWindow.CurEditMacroItem.subIndex

			-- get the action ID from the macro item that we are editing
			actionId = ActionEditWindow.CurEditMacroItem.actionId
	    end
		
		-- is the edit window currently visible?
		if not WindowGetShowing(ActionEditWindow.CurEditItem.windowName) then

			-- clear the edit data
			ActionEditWindow.CurEditItem = nil
		end

	-- is this an edit call from a macro? (this is just for automated calls)
	elseif ActionEditWindow.CurEditMacroItem ~= nil then

		-- get the macro data
		hotbarId = ActionEditWindow.CurEditMacroItem.hotbarId
	    itemIndex = ActionEditWindow.CurEditMacroItem.itemIndex
	    subIndex = ActionEditWindow.CurEditMacroItem.subIndex

		-- get the action ID
		actionId = ActionEditWindow.CurEditMacroItem.actionId

	    -- is the edit window currently visible?
		if not WindowGetShowing(ActionEditWindow.CurEditMacroItem.windowName) then

			-- clear the edit data
			ActionEditWindow.CurEditMacroItem = nil
		end
	end

	-- get the action data
	local actionData = ActionsWindow.ActionData[actionId]
	
	return hotbarId, itemIndex, subIndex, actionId, actionData
end

function ActionEditWindow.TextEditOK()

	-- current window name
	local windowName = WindowUtils.GetActiveDialog()

	-- get the data for the element we're editing
	local hotbarId, itemIndex, subIndex, actionId = ActionEditWindow.GetCurrentEditData()
	
	-- get the text from the textbox
	local speechText = ActionEditTextEntry.Text

	-- do we have a valid string?
	if IsValidWString(speechText) then

		-- send chat message action
		if actionId == 5170 then

			-- build the action function call for the given text
			speechText = L"script SendChat(ChatSettings.Channels[SystemData.ChatLogFilters.SAY].serverCmd, L\"/c " .. speechText ..  L"\" )"

		-- send guild message action
		elseif actionId == 5171 then
			
			-- build the action function call for the given text
			speechText = L"script SendChat(ChatSettings.Channels[SystemData.ChatLogFilters.SAY].serverCmd, L\"/g " .. speechText ..   L"\" )"

		-- send alliance message action
		elseif actionId == 5172 then

			-- build the action function call for the given text
			speechText = L"script SendChat(ChatSettings.Channels[SystemData.ChatLogFilters.SAY].serverCmd, L\"/a " .. speechText ..   L"\" )"

		-- send party message action
		elseif actionId == 5173 then

			-- build the action function call for the given text
			speechText = L"script SendChat(ChatSettings.Channels[SystemData.ChatLogFilters.SAY].serverCmd, L\"/p " .. speechText ..   L"\" )"

		-- send note to self message action
		elseif actionId == 5174 then

			-- build the action function call for the given text
			speechText = L"script Actions.SendPrivateMSG(L\"" ..  speechText .. L"\" )"

		-- custom buff actions 
		elseif actionId > 15000 and actionId < 15100 then

			-- split the string to create the function parameters
			speechText = wstring.gsub(speechText, L"|", L"\" \, ")

			-- calculate the custom buff ID
			local id = actionId - 15000

			-- build the action function call
			speechText = L"script Actions.CustomBuff(" .. id .. L", L\"" .. speechText .. L")"
		end
	end

	-- update the action text
	UserActionSpeechSetText(hotbarId, itemIndex, subIndex, speechText)
	
	-- hide the edit window
	WindowSetShowing(windowName, false)	
end

-- SLIDER
function ActionEditWindow.UpdateSliderEdit(editWindow, hotbarId, itemIndex, subIndex)
	
	-- current action source type (hotbar or macro)
	local typ = ActionEditWindow.CurEditItem.type

	-- is this a macro and not an action?
	if ActionEditWindow.CurEditMacroItem ~= nil and ActionEditWindow.CurEditMacroItem.windowName == editWindow then

		-- set the source type to macro
		typ = ActionEditWindow.CurEditMacroItem.type
	end
	
	-- get the current action data
	local actionData = ActionsWindow.GetActionDataForType(typ)
	
	-- get the current delay value
	local delayValue = UserActionDelayGetDelay(hotbarId, itemIndex, subIndex)

	-- calculate the correct slider position
	local sliderValue = (delayValue / (actionData.sliderMax - actionData.sliderMin)) + actionData.sliderMin

	-- update the slider position
	SliderBarSetCurrentPosition(editWindow .. "Slider", sliderValue)

	-- update the slider text
	LabelSetText(editWindow .. "Value", wstring.format(L"%.1f", delayValue))
end

function ActionEditWindow.SliderEditOK()

	-- current window name
	local windowName = WindowUtils.GetActiveDialog()

	-- get the data for the element we're editing
	local hotbarId, itemIndex, subIndex = ActionEditWindow.GetCurrentEditData()
	
	-- get the slider value
	local sliderValue = SliderBarGetCurrentPosition(windowName .. "Slider")

	-- calculate the correct slider value
	local delayValue = (sliderValue - actionData.sliderMin) * (actionData.sliderMax - actionData.sliderMin)
	
	-- save the slider value
	UserActionDelaySetDelay(hotbarId, itemIndex, subIndex, delayValue)
	
	-- hide the edit window
	WindowSetShowing(windowName, false)
end

function ActionEditWindow.SliderUpdate()

	-- current window name
	local windowName = WindowUtils.GetActiveDialog()
	
	-- current action source type (hotbar or macro)
	local typ = ActionEditWindow.CurEditItem.type

	-- is this a macro and not an action?
	if ActionEditWindow.CurEditMacroItem ~= nil and ActionEditWindow.CurEditMacroItem.windowName == editWindow then

		-- set the source type to macro
		typ = ActionEditWindow.CurEditMacroItem.type
	end

	-- get the current action data
	local actionData = ActionsWindow.GetActionDataForType(typ)
	
	-- get the current slider value
	local sliderValue = SliderBarGetCurrentPosition(windowName .. "Slider")

	-- calculate the real value of the slider
	local delayValue = (sliderValue - actionData.sliderMin) * (actionData.sliderMax - actionData.sliderMin)
	
	-- show the value on the label
	LabelSetText(windowName .. "Value", wstring.format(L"%.1f", delayValue))
end

-- EQUIP
function ActionEditWindow.ClearAllEquipSlots()

	-- scan all the existing elements
	for equipWindowName, _ in pairs(ActionEditWindow.Equip.CurrentItems) do

		-- destroy the element
		DestroyWindow(equipWindowName)
	end

	-- reset the created items table
	ActionEditWindow.Equip.CurrentItems = {}
end

function ActionEditWindow.UpdateEquipItemEdit(windowName, hotbarId, itemIndex, subIndex)
	
	-- unregister the item
	ActionEditWindow.UnregisterEquipItems(windowName)
	
	-- get the amount of items for this action
	local numItems = UserActionEquipItemsGetNumItems(hotbarId, itemIndex, subIndex)
	
	-- do we have any item?
	if IsValidID(numItems) then

		-- scan all the items
		for i = 1, numItems do

			-- get the object ID
			local objectId = UserActionEquipItemsGetItem(hotbarId, itemIndex, subIndex, i - 1)

			-- do we have a valid object ID?
			if IsValidID(objectId) then

				-- current element name
				local equipWindowName = windowName .. "EquipActionsScrollChildItem" .. i

				-- does the element already exist?
				if not DoesWindowExist(equipWindowName) then
					
					-- create the element
					CreateWindowFromTemplate(equipWindowName, "EquipButtonDef", windowName .. "ActionsScrollChild")

					-- add the element to the table
					ActionEditWindow.Equip.CurrentItems[equipWindowName] = true
				end
				
				-- clear the current element anchors
				WindowClearAnchors(equipWindowName)

				-- set the element ID
				WindowSetId(equipWindowName, i)
				
				-- get the object info (otherwise the icon won't be visible)
				local itemData = Interface.GetObjectInfoData(objectId)

				-- store the object ID in the registered objects list
				ActionEditWindow.Equip.RegisteredObjects[i] = objectId
				
				-- update the icon window with the image of the object
				ActionEditWindow.UpdateEquipIcon(equipWindowName, objectId)	

				-- is this the first element?
				if i == 1 then

					-- anchor to the top-left of the main window
					WindowAddAnchor(equipWindowName, "topleft", windowName .. "ActionsScrollChild", "topleft", 0, 0)

				else -- anchor on the right of the previous element
					WindowAddAnchor(equipWindowName, "right", windowName .. "EquipActionsScrollChildItem" .. (i - 1), "left", 0, 0)
				end
			end
		end
		
		-- do we have less than 5 items?
		if numItems <= 5 then

			-- reset the scroll position to the first elment
			HorizontalScrollWindowSetOffset(windowName .. "Actions", 0)
		end
	end

	-- create an empty element at the end
	ActionEditWindow.EquipCreateEmpty(windowName, numItems)
	
	-- update the scroll area size
	HorizontalScrollWindowUpdateScrollRect(windowName .. "Actions")
end

function ActionEditWindow.EquipCreateEmpty(windowName, numItems)

	-- empty button at the end window name
	local emptyButtonName = windowName .. "ActionsScrollChildEmptyButton"

	-- clear the empty button acnhors
	WindowClearAnchors(emptyButtonName)

	-- do we have NO items in the list?
	if not numItems or numItems == 0 then

		-- anchor to the top-left of the main window
		WindowAddAnchor(emptyButtonName, "topleft", windowName .. "ActionsScrollChild", "topleft", 0, 0)

	else -- anchor on the right of the previous element
		WindowAddAnchor(emptyButtonName, "right", windowName .. "EquipActionsScrollChildItem" .. numItems, "left", 0, 0)
	end
end

function ActionEditWindow.EquipItemAddEquipped()

	-- get the current window name
	local parent = WindowUtils.GetActiveDialog()

	-- get the current action location
	local hotbarId, itemIndex, subIndex = ActionEditWindow.GetCurrentEditData()

	-- add the equipped items to the list
	UserActionEquipItemsAddEquippedItems(hotbarId, itemIndex, subIndex)

	-- update the equipped items list
	ActionEditWindow.UpdateEquipItemEdit(parent, hotbarId, itemIndex, subIndex)
end

function ActionEditWindow.EquipClearEquipped()

	-- main equip window
	local parent = "ActionEditEquip"

	-- get the action location
	local hotbarId, itemIndex, subIndex = ActionEditWindow.GetCurrentEditData()
	
	-- scan all the registered objects	
	for i, objectId in pairsByIndex(ActionEditWindow.Equip.RegisteredObjects) do
		
		-- element window name
		local windowName = parent .. "EquipActionsScrollChildItem" .. i
		
		-- remove the object from the list
		UserActionEquipItemsRemoveItem(hotbarId, itemIndex, subIndex, objectId)

		-- remove the element from the list
		ActionEditWindow.Equip.CurrentItems[windowName] = nil

		-- remove the element from the registered objets
		ActionEditWindow.Equip.RegisteredObjects[i] = nil

		-- destroy the element
		DestroyWindow(windowName) 
	end

	-- reset the created items table
	ActionEditWindow.Equip.CurrentItems = {}

	-- unregister equip object id data
	ActionEditWindow.UnregisterEquipItems()

	-- create an empty element at the end
	ActionEditWindow.EquipCreateEmpty(parent, 0)

	-- update the scroll area size
	HorizontalScrollWindowUpdateScrollRect(parent .. "Actions")

	-- reset the scroll position to the first elment
	HorizontalScrollWindowSetOffset(parent .. "Actions", 0)
end

function ActionEditWindow.EquipUpdateObject()

	-- current window name
	local windowName = SystemData.ActiveWindow.name

	-- get the ID of the item to update
	local updateId = WindowData.UpdateInstanceId

	-- get the current action location
	local hotbarId, itemIndex, subIndex = ActionEditWindow.GetCurrentEditData()

	-- do we have the action location?
	if not hotbarId or not itemIndex or not subIndex then
		return
	end

	-- get the ID of the item to update
	local _, index = table.contains(ActionEditWindow.Equip.RegisteredObjects, updateId)
		
	-- do we have the item?
	if IsValidID(index) then
	
		-- object element window name
		local equipWindowName = windowName .. "EquipActionsScrollChildItem" .. index

		-- update the object icon
		ActionEditWindow.UpdateEquipIcon(equipWindowName, updateId)
	end
end

function ActionEditWindow.EquipLButtonUp()

	-- current window name
	local parent = WindowUtils.GetActiveDialog()

	-- get the action location
	local hotbarId, itemIndex, subIndex = ActionEditWindow.GetCurrentEditData()
	
	-- are we dragging an item?
	if SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM then	

		-- get the item ID
	    local itemId = SystemData.DragItem.itemId

		-- get the item type
	    local itemType = SystemData.DragItem.itemType

		-- check if the item is of the correct type for the action
		if DragSlotDropObjectToSource() then		

			-- add the item to the action
		    if UserActionEquipItemsAddItem(hotbarId, itemIndex, subIndex, itemId, itemType) then

				-- update the items list if the item has been added correctly
			    ActionEditWindow.UpdateEquipItemEdit(parent, hotbarId, itemIndex, subIndex)
		    end
		end
	end
end

function ActionEditWindow.UpdateEquipIcon(windowName, objectId)

	-- do we have a valid window name and object id?
	if IsValidID(objectId) and IsValidString(windowName) then

		-- does the player has the item?
		if DoesPlayerHaveItem(objectId) then

			-- icon window name
			local elementIcon = windowName .. "SquareIcon"

			-- get the object data (otherwise the icon won't show)
			local item = Interface.GetObjectInfoData(objectId)

			-- update the icon
			EquipmentData.UpdateItemIcon(elementIcon, item)
		end
	end
end

function ActionEditWindow.EquipRButtonUp()

	-- main equip window
	local parent = "ActionEditEquip"

	-- get the action location
	local hotbarId, itemIndex, subIndex = ActionEditWindow.GetCurrentEditData()

	-- slot window ID
	local slot = WindowGetId(SystemData.ActiveWindow.name)

	-- create the params for the context menu
	local param = { HotbarId = hotbarId, ItemIndex = itemIndex , SubIndex = subIndex, WindowName = parent, Slot = slot }	
	
	-- reset the context menu
	ContextMenu.CleanUp()

	-- add the "Clear Item" option for the context menu
	ContextMenu.CreateLuaContextMenuItem({ tid = HotbarSystem.TID_CLEAR_ITEM, returnCode = HotbarSystem.ContextReturnCodes.CLEAR_ITEM, param = param })
	
	-- show the context menu
	ContextMenu.ActivateLuaContextMenu(ActionEditWindow.Equip.ContextMenuCallback)
end

function ActionEditWindow.Equip.ContextMenuCallback(returnCode, param)

	-- do we have the parameters?
	if param then
		
		-- is this the clear item action?
		if returnCode == HotbarSystem.ContextReturnCodes.CLEAR_ITEM then

			-- get the object ID to remove
			local objectId = ActionEditWindow.Equip.RegisteredObjects[param.Slot]

			-- do we have a valid ID?
			if IsValidID(objectId) then

				-- remove the item from the action
				UserActionEquipItemsRemoveItem(param.HotbarId, param.ItemIndex, param.SubIndex, objectId)

				-- unregister the object
				UnregisterWindowData(WindowData.ObjectInfo.Type, objectId)

				-- remove the object from the registered objects list
				ActionEditWindow.Equip.RegisteredObjects[param.Slot] = nil

				-- delete all items slots (so we can re-create them from clean)
				ActionEditWindow.ClearAllEquipSlots()

				-- update the objects list
				ActionEditWindow.UpdateEquipItemEdit(param.WindowName, param.HotbarId, param.ItemIndex, param.SubIndex)
			end
		end
	end
end

function ActionEditWindow.EquipMouseOver()

	-- create the tooltip for the empty equip slot
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(MacroEditWindow.TID_MACRO_DRAG_EQUIP_TOOLTIP))
end

function ActionEditWindow.EquipItemMouseOver()

	-- current window name
	local this = SystemData.ActiveWindow.name

	-- slot window ID
	local slot = WindowGetId(this)
	
	-- get the object ID
	local objectId = ActionEditWindow.Equip.RegisteredObjects[slot]

	-- do we have a valid ID and the player has it?
	if IsValidID(objectId) and DoesPlayerHaveItem(objectId) then
	
		-- item properties params array
		local itemData = 
		{ 
			windowName = this,
			itemId = objectId,
			itemType = WindowData.ItemProperties.TYPE_ITEM,
			detail = detailType,
		}

		-- showing the properties
		ItemProperties.SetActiveItem(itemData)
	end
end

function ActionEditWindow.UnregisterEquipItems()

	-- scan all registered objects
	for i, itemId in pairs(ActionEditWindow.Equip.RegisteredObjects) do

		-- unregister the item
		UnregisterWindowData(WindowData.ObjectInfo.Type, itemId)

		-- remove the item from the table
		ActionEditWindow.Equip.RegisteredObjects[i] = nil
	end
end

function ActionEditWindow.EquipItemOK()

	-- current edit window name
	local windowName = "ActionEditEquip"

	--Unregister equip object id data
	ActionEditWindow.UnregisterEquipItems()

	-- hide the edit window
	WindowSetShowing(windowName, false)	
end

-- UNEQUIP
function ActionEditWindow.CreateUnequipSlots(windowName)

	-- main scrollable window name
	local parent = windowName .. "ActionsScrollChild"

	-- scan all the unequip slots
	for i, data in pairsByIndex(ActionEditWindow.UnEquip.Slots) do

		-- current slot name
		local unequipWindowName = parent .. "Slot" .. i

		-- current slot icon
		local elementIcon = unequipWindowName .. "SquareIcon"

		-- previous slot name
		local prevUnequipWindowName = parent .. "Slot" .. i - 1

		-- create the slot
		CreateWindowFromTemplate(unequipWindowName, "UnequipButtonDef", parent)

		-- set the slot ID
		WindowSetId(unequipWindowName, i)

		-- turn the button into a checkbox
		ButtonSetStayDownFlag(unequipWindowName .. "Button", true)

		-- set the icon texture
		DynamicImageSetTexture(elementIcon, data.texture, data.x, data.y)

		-- set the icon bg based on the selected mini texture pack
		DynamicImageSetTexture(elementIcon .. "BG", MiniTexturePack.DB[Interface.Settings.MTP_Current].texture .. "Icon", 0, 0 )
		
		-- is this the first slot?
		if i == 1 then

			-- anchor to the top-left of the main window
			WindowAddAnchor(unequipWindowName, "topleft", parent, "topleft", 0, 0)

		else -- anchor to the previous item
			WindowAddAnchor(unequipWindowName, "bottom", prevUnequipWindowName, "top", 0, 0)
		end
	end
end

function ActionEditWindow.UpdateUnequipEdit(windowName, hotbarId, itemIndex, subIndex)
	
	-- scan all the unequip slots
	for i, data in pairsByIndex(ActionEditWindow.UnEquip.Slots) do
		
		-- current slot window name
		local buttonWindowName = windowName .. "ActionsScrollChildSlot" .. i .. "Button"
		
		-- flag if the slot is selected or not
		ActionEditWindow.UnEquip.selected[i] = UserActionFindSlot(hotbarId, itemIndex, subIndex, data.slot) == true	

		-- toggle the button flag
		ButtonSetPressedFlag(buttonWindowName, ActionEditWindow.UnEquip.selected[i])
	end
end

function ActionEditWindow.UnequipPosSelected()

	-- current window name
	local this = SystemData.ActiveWindow.name

	-- get the slot ID
	local id = WindowGetId(this)
	
	-- get the action location
	local hotbarId, itemIndex, subIndex = ActionEditWindow.GetCurrentEditData()

	-- is the slot checked?
	if ActionEditWindow.UnEquip.selected[id] then

		-- set the slot as un-checked
		ActionEditWindow.UnEquip.selected[id] = false

		-- uncheck the slot
		UserActionRemoveSlot(hotbarId, itemIndex, subIndex, ActionEditWindow.UnEquip.Slots[id].slot)

	else -- unchecked slot
		
		-- set the slot as selected
		ActionEditWindow.UnEquip.selected[id] = true

		-- select the slot
		UserActionAddSlot(hotbarId, itemIndex, subIndex, ActionEditWindow.UnEquip.Slots[id].slot)
	end
	
	-- update the checked flag on the button
	ButtonSetPressedFlag(this .. "Button", ActionEditWindow.UnEquip.selected[id])
end

function ActionEditWindow.UnEquipOK()

	-- get the current window name
	local windowName = "ActionEditUnEquip"

	-- get the action ID
	local actionId = WindowGetId(windowName)

	-- initialize the slots list parameter (for equip last action)
	local speechText = L""

	-- scan all the unequip slots
	for i, data in pairsByIndex(ActionEditWindow.UnEquip.Slots) do

		-- uncheck the button
		ButtonSetPressedFlag(windowName .. "ActionsScrollChildSlot" .. i .. "Button", false)

		-- is this the equip last action and the slot is selected?
		if actionId == 4139 and ActionEditWindow.UnEquip.selected[i] then

			-- if it's not the first element we add the comma
			if IsValidWString(speechText) then
				speechText = speechText .. L", "
			end

			-- add the slot to the params list
			speechText = speechText .. towstring(i)
		end

		-- remove the selection flag from the slot
		ActionEditWindow.UnEquip.selected[i] = nil
	end

	-- get the action location
	local hotbarId, itemIndex, subIndex, _, actionData = ActionEditWindow.GetCurrentEditData()

	-- is this the equip last action? (the normal unequip action is auto-saved when the slot is checked/unchecked)
	if actionId == 4139 then
	
		-- create the full command string for the action
		speechText = ReplaceTokens(actionData.callback, { speechText, towstring(hotbarId), towstring(itemIndex), towstring(subIndex) })

		-- save the command string
		UserActionSpeechSetText(hotbarId, itemIndex, subIndex, speechText)
	end

	-- hide the edit window
	WindowSetShowing(windowName, false)	
end

-- ARM/DISARM
function ActionEditWindow.CreateArmDisarmSlots(windowName)
	
	-- initialize the previous line slot name
	local prevLineSlot

	-- scan all the unequip slots
	for i, data in pairsByIndex(ActionEditWindow.UnEquip.Slots) do

		-- slot window name
		local armWindowName = windowName .. "Slot" .. i

		-- previous slot
		local prevSlot = windowName .. "Slot" .. i - 1

		-- slot icon
		local elementIcon = armWindowName .. "SquareIcon"

		-- create the slot
		CreateWindowFromTemplate(armWindowName, "ArmDisarmButtonDef", windowName)

		-- set the id to the slot
		WindowSetId(armWindowName, i)

		-- turn the button into a checkbox
		ButtonSetStayDownFlag(armWindowName .. "Button", true)

		-- set the slot icon
		DynamicImageSetTexture(elementIcon, data.texture, data.x, data.y)

		-- set the icon bg based on the selected mini texture pack
		DynamicImageSetTexture(elementIcon .. "BG", MiniTexturePack.DB[Interface.Settings.MTP_Current].texture .. "Icon", 0, 0)
		
		-- is this the first slot?
		if i == 1 then

			-- anchor to the top-left of the main window
			WindowAddAnchor(armWindowName, "bottomleft", windowName.."ParamInfo", "topleft", 0, 30)
			
			-- store this slot as the first of this line
			prevLineSlot = armWindowName

		else -- other slots
				
			-- is this the first slot of the line?
			if i % (ActionEditWindow.ArmDisarmMaxLength) == 1 then

				-- anchor at the bottom of the first slot of the previous line
				WindowAddAnchor(armWindowName, "bottom", prevLineSlot, "top", 0, 0)

				-- store this slot as the first of this line
				prevLineSlot = armWindowName

			else -- any other slot will be anchored to the right of the previous one
				WindowAddAnchor(armWindowName, "right", prevSlot, "left", 0 , 0)
			end
		end
	end
end

function ActionEditWindow.UpdateArmDisarmEdit(windowName, hotbarId, itemIndex, subIndex)

	-- current edit window name
	local windowName = "ActionEditArmDisarm"

	-- get the slot to edit
	local slotNumber = UserActionArmDisarmGetSlotNumber(hotbarId, itemIndex, subIndex)

	-- getting which slot is selected
	for id, data in pairs(ActionEditWindow.UnEquip.Slots) do

		--  slot window name
		local buttonWindowName = windowName .. "Slot" .. id .. "Button"

		-- slot found
		if id == slotNumber then

			-- check the button
			ButtonSetPressedFlag(buttonWindowName, true)
			
		else -- if it's not the slot we're looking for, we uncheck it (only 1 slot can be active at time)
			ButtonSetPressedFlag(buttonWindowName, false)
		end
	end
end

function ActionEditWindow.ArmDisarmSelectSlot()

	-- current edit window name
	local windowName = "ActionEditArmDisarm"

	-- current slot window name
	local currSlot = SystemData.ActiveWindow.name

	-- get the action location
	local hotbarId, itemIndex, subIndex = ActionEditWindow.GetCurrentEditData()

	-- get the slot to edit
	local slotNumber = WindowGetId(currSlot)

	-- save the selected slot
	UserActionArmDisarmSelectSlot(hotbarId, itemIndex, subIndex, slotNumber)

	-- getting which slot is selected
	for id, data in pairs(ActionEditWindow.UnEquip.Slots) do

		--  slot window name
		local buttonWindowName = windowName .. "Slot" .. id .. "Button"

		-- slot found
		if id == slotNumber then

			-- check the button
			ButtonSetPressedFlag(buttonWindowName, true)
			
		else -- if it's not the slot we're looking for, we uncheck it (only 1 slot can be active at time)
			ButtonSetPressedFlag(buttonWindowName, false)
		end
	end
end

function ActionEditWindow.ArmDisarmOK()

	-- current edit window name
	local windowName = "ActionEditArmDisarm"

	-- hide the edit window
	WindowSetShowing(windowName, false)
end

-- TARGET BY RESOURCE
function ActionEditWindow.TargetByResourceUpdateObject()

	-- current window name
	local windowName = SystemData.ActiveWindow.name

	-- ID of the item to update
	local updateId = WindowData.UpdateInstanceId

	-- get the action location
	local hotbarId, itemIndex, subIndex = ActionEditWindow.GetCurrentEditData()
	
	-- do we have the action location?
	if not hotbarId or not itemIndex or not subIndex then
		return
	end

	-- get the object ID used in this action
	local objectId = UserActionTargetByResourceGetUseObjectInstanceId(hotbarId, itemIndex, subIndex)

	-- do we have a valid object ID and it's the object that needs to be updated?
	if IsValidID(objectId) and updateId == objectId then

		-- update the object icon
		ActionEditWindow.UpdateTargetByResourceIcon(windowName, objectId)

		-- get the type category of resource affected by this item
		local resourceCategory = UserActionTargetByResourceGetResourceCategory(hotbarId, itemIndex, subIndex)

		-- do we have a valid category?
		if IsValidID(resourceCategory) then

			-- get the resource type affected by this item
			local resourceType = UserActionTargetByResourceGetResourceType(hotbarId, itemIndex, subIndex)

			-- update the list of resources inside the combo
			ActionEditWindow.TargetByResourceResetComboBox(windowName, resourceType, resourceCategory)
		end
	end
end

function ActionEditWindow.UpdateTargetByResourceIcon(windowName, objectId)

	-- resource button name
	local resourceButtonName = windowName .. "ResourceButton"

	-- empty button name
	local emptyButtonName = windowName .. "EmptyButton"

	-- icon name
	local elementIcon = resourceButtonName .. "SquareIcon"
	
	-- do we have a valid object ID?
	if IsValidID(objectId) then	
	
		-- get the object data
		local item = Interface.GetObjectInfoData(objectId)

		-- update the object icon
		EquipmentData.UpdateItemIcon(elementIcon, item)

		-- show the resource button
		WindowSetShowing(resourceButtonName, true)

		-- hide the empty button
		WindowSetShowing(emptyButtonName, false)
	end
end

function ActionEditWindow.UpdateTargetByResourceEdit(windowName, hotbarId, itemIndex, subIndex)
	
	-- resource button name
	local resourceButtonName = windowName .. "ResourceButton"

	-- empty button name
	local emptyButtonName = windowName .. "EmptyButton"

	-- icon name
	local elementIcon = resourceButtonName .. "SquareIcon"
	
	-- show the empty button
	WindowSetShowing(emptyButtonName, true)

	-- hide the resource button
	WindowSetShowing(resourceButtonName, false)
		
	-- get the object ID used in this action
	local objectId = UserActionTargetByResourceGetUseObjectInstanceId(hotbarId, itemIndex, subIndex)
		
	-- do we have a valid object ID?
	if IsValidID(objectId) then

		-- get the object data (or we won't be able to see the icon)
		Interface.GetObjectInfoData(objectId)

		-- set the item as registered object
		ActionEditWindow.ResourceRegisteredObject = objectId

		-- update the object icon
		ActionEditWindow.UpdateTargetByResourceIcon(windowName, objectId)

		-- get the type category of resource affected by this item
		local resourceCategory = UserActionTargetByResourceGetResourceCategory(hotbarId, itemIndex, subIndex)

		-- get the resource type affected by this item
		local resourceType = UserActionTargetByResourceGetResourceType(hotbarId, itemIndex, subIndex)
		
		-- do we have a resoruce type and category?
		if resourceType and IsValidID(resourceCategory) then

			-- show the resource name label
			WindowSetShowing(windowName .. "ResourceLabel", true)

			-- update the list of resources inside the combo
			ActionEditWindow.TargetByResourceResetComboBox(windowName, resourceType, resourceCategory)
		end
	end
end

function ActionEditWindow.TargetByResourceLButtonUp()

	-- current window name
	local windowName = SystemData.ActiveWindow.name

	-- get the edit window name
	local parent = WindowUtils.GetActiveDialog()

	-- get the action location
	local hotbarId, itemIndex, subIndex = ActionEditWindow.GetCurrentEditData()
	
	-- are we dragging an item?
	if SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM then	

		-- get the ID of the item we are dragging
	    local id = SystemData.DragItem.itemId

		-- get the object type of the item we are dragging
	    local objectType = SystemData.DragItem.itemType
		
		-- is this a sledge hammer? only the prospector tool works here
		if wstring.lower(GetItemName(id)) == wstring.lower(GetStringFromTid(1024020)) then -- sledge hammer
			return
		end

		-- scan all the accepted object types
		for i, data in pairsByIndex(WindowData.ResourceTypeDataCSV) do
		
			-- is this the object we are trying to drop?
			if data.ObjectType == objectType then

				-- verify if it can be dropped in the slot 
			    if DragSlotDropObjectToSource() then

					-- get the resource category for the tool
					local currentCategory = data.Category

					-- get the resource type for the toolt
				    local resourceTypeNum = ActionEditWindow.ResourceCategory[currentCategory][1]

					-- get the default resource type for the tool
				    local defaultResource = ActionEditWindow.ResourceType[resourceTypeNum].resourceType

					-- set the object ID in the slot
				    UserActionTargetByResourceSetUseObjectInstanceId(hotbarId, itemIndex, subIndex, id)

					-- set the resource type in the slot
				    UserActionTargetByResourceSetResourceType(hotbarId, itemIndex, subIndex, defaultResource)

					-- set the resource category in the slot
				    UserActionTargetByResourceSetResourceCategory(hotbarId, itemIndex, subIndex, currentCategory)
    				
					-- update the action edit window visual
				    ActionEditWindow.UpdateTargetByResourceEdit(parent, hotbarId, itemIndex, subIndex)
				end

				return -- job is done
			end
		end
	end
end

function ActionEditWindow.TargetByResourceResetComboBox(windowName, resourceTypeSelected , currentCategory)

	-- combo window name	
	local comboName = windowName .. "ResourceCombo"

	-- resource label window name
	local labelName = windowName .. "ResourceLabel"

	-- clear the combo
	ComboBoxClearMenuItems(comboName)
	
	-- hide the resource label
	WindowSetShowing(labelName, false)

	-- hide the combo
	WindowSetShowing(comboName, false)
	
	-- get the current category
	local resourceCategory = ActionEditWindow.ResourceCategory[currentCategory]
	
	-- do we have the category data table?
	if resourceCategory then

		-- show the resource label
		WindowSetShowing(labelName, true)

		-- show the combo
		WindowSetShowing(comboName, true)

		-- scan all the reources
		for i, resource in pairs(resourceCategory) do

			-- add the resource to the combo list
			ComboBoxAddMenuItem(comboName, GetStringFromTid(ActionEditWindow.ResourceType[resource].tid))

			-- is this the selected resource type?
			if resourceTypeSelected == ActionEditWindow.ResourceType[resource].resourceType then

				-- select the current element
				ComboBoxSetSelectedMenuItem(comboName, i)
			end
		end
	end
end

function ActionEditWindow.TargetByResourceMouseOver()

	-- show the tooltip "drag the tool and select the resource"
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(MacroEditWindow.TID_MACRO_DRAG_TARGET_BY_RESOURCE_TOOLTIP))
end

function ActionEditWindow.TargetByResourceOK()

	-- current edit window name
	local windowName = "ActionEditTargetByResource"

	-- combo window name
	local comboName = windowName .. "ResourceCombo"

	-- get the action location
	local hotbarId, itemIndex, subIndex = ActionEditWindow.GetCurrentEditData()
	
	-- get the type category of resource affected by this item
	local resourceCategory = UserActionTargetByResourceGetResourceCategory(hotbarId, itemIndex, subIndex)

	-- do we have a valid category?
	if IsValidID(resourceCategory) then

		-- get the selected resource from the combo
		local selectedItem = ComboBoxGetSelectedMenuItem(comboName)

		-- get the ID of the selected resource
		local resourceSelected = ActionEditWindow.ResourceCategory[resourceCategory][selectedItem]

		-- get the type for the selected resource
		local resourceType = ActionEditWindow.ResourceType[resourceSelected].resourceType
		
		-- save the resource type
		UserActionTargetByResourceSetResourceType(hotbarId, itemIndex, subIndex, resourceType)
	end
	
	-- hide the edit window
	WindowSetShowing(windowName, false)
end

-- STORE TARGET
function ActionEditWindow.UpdateTargetByObjectId()
	
	-- request the cursor target
	RequestTargetInfo(ActionEditWindow.RequestTargetInfoReceived)
end

function ActionEditWindow.RequestTargetInfoReceived(objectId)
	
	-- get the data for the element we're editing
	local hotbarId, itemIndex, subIndex, actionId, actionData = ActionEditWindow.GetCurrentEditData()

	-- do we have a valid object ID?
	if IsValidID(objectId) then

		-- is this the target first container object action?
		if actionId == 5206 then

			-- is the target a container?
			if not IsContainer(objectId) then

				-- warn the player that this is not a valid container
				ChatPrint(GetStringFromTid(1155159), SystemData.ChatLogFilters.SYSTEM) -- This is not an accessible container!

				-- reset the object ID
				objectId = 0
			end

			-- create the command string
			local speechText = ReplaceTokens(actionData.callback, { towstring(objectId) })

			-- save the command string
			UserActionSpeechSetText(hotbarId, itemIndex, subIndex, speechText)
		else

			-- store the object ID in the action
			UserActionSetTargetId(hotbarId, itemIndex, subIndex, objectId)

			-- update the action target type
			UserActionSetTargetType(hotbarId, itemIndex, subIndex, SystemData.Hotbar.TargetType.TARGETTYPE_OBJECT_ID)
		end
	end
	
	-- hide the edit window
	WindowSetShowing("ActionEditTargetByObjectId", false)
end

function ActionEditWindow.SlotMouseOver()

	-- get the slot ID
	local SlotNum =  WindowGetId(SystemData.ActiveWindow.name)

	-- get the TID string
	local text = GetStringFromTid( PaperdollWindow.BlankSlot[SlotNum].SlotNameTid )

	-- create the tooltip
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, text)
end

function ActionEditWindow.IsRegisteredObject(objectID)
	
	-- is this the object?
	if ActionEditWindow.ResourceRegisteredObject == objectID then
		return true
	end

	-- scan all registered objects
	for i, itemId in pairs(ActionEditWindow.Equip.RegisteredObjects) do

		-- is this the object we're looking for?
		if itemId == objectID then
			return true
		end
	end

	return false
end