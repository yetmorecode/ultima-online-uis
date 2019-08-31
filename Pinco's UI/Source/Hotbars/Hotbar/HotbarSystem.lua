----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

HotbarSystem = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------
HotbarSystem.RegisteredSpellIcons = {}

HotbarSystem.HighlightSpellIconInput = {}
HotbarSystem.HighlightSpellIconInput.highlightSpellID = 0
HotbarSystem.HighlightSpellIconInput.highlightSpellEnabled = 0

HotbarSystem.CurRequestInfoItem = nil

HotbarSystem.ContextReturnCodes = {}
HotbarSystem.ContextReturnCodes.CLEAR_ITEM = 1
HotbarSystem.ContextReturnCodes.ASSIGN_KEY = 2
HotbarSystem.ContextReturnCodes.NEW_HOTBAR = 3
HotbarSystem.ContextReturnCodes.DESTROY_HOTBAR = 4
HotbarSystem.ContextReturnCodes.DESTROY_HOTBAR_GROUP = 5
HotbarSystem.ContextReturnCodes.TARGET_SELF = 6
HotbarSystem.ContextReturnCodes.TARGET_CURRENT = 7
HotbarSystem.ContextReturnCodes.TARGET_CURSOR = 8
HotbarSystem.ContextReturnCodes.TARGET_OBJECT_ID = 9
HotbarSystem.ContextReturnCodes.TARGET_MOUSEOVER = 10
HotbarSystem.ContextReturnCodes.EDIT_ITEM = 11
HotbarSystem.ContextReturnCodes.ENABLE_REPEAT = 12
HotbarSystem.ContextReturnCodes.DISABLE_REPEAT = 13
HotbarSystem.ContextReturnCodes.LOCK_HOTBAR = 14
HotbarSystem.ContextReturnCodes.MINI_TEXTURE_PACK = 15
HotbarSystem.ContextReturnCodes.BORDER_TEXTURE = 16
HotbarSystem.ContextReturnCodes.TOGGLE_ALERT = 17
HotbarSystem.ContextReturnCodes.TOGGLE_CHARGES = 18
HotbarSystem.ContextReturnCodes.AGENT_ORGANIZER = 19
HotbarSystem.ContextReturnCodes.AGENT_UNDRESS = 20
HotbarSystem.ContextReturnCodes.ENABLE_AUTOHIDE = 21
HotbarSystem.ContextReturnCodes.DISABLE_AUTOHIDE = 22

HotbarSystem.ContextReturnCodes.SPELL_FAMILIAR = 25
HotbarSystem.ContextReturnCodes.SPELL_ENCHANT = 26
HotbarSystem.ContextReturnCodes.SPELL_ANIMAL_FORM = 27
HotbarSystem.ContextReturnCodes.SPELL_SPELL_TRIGGER = 28
HotbarSystem.ContextReturnCodes.SPELL_POLYMORPH = 29
HotbarSystem.ContextReturnCodes.SPELL_COMBAT_TRAINING = 30

HotbarSystem.ContextReturnCodes.SECURITY_OWNER = 35
HotbarSystem.ContextReturnCodes.SECURITY_COOWNER = 36
HotbarSystem.ContextReturnCodes.SECURITY_FRIEND = 37
HotbarSystem.ContextReturnCodes.SECURITY_GUILD = 38
HotbarSystem.ContextReturnCodes.SECURITY_ANYONE = 39

HotbarSystem.ContextReturnCodes.MACRO_EXPORT = 50
HotbarSystem.ContextReturnCodes.MACRO_IMPORT = 51

HotbarSystem.ContextReturnCodes.SETDOCKSPOTFILTER = 55

HotbarSystem.ContextReturnCodes.TARGETFILTER_INNOCENT = 62
HotbarSystem.ContextReturnCodes.TARGETFILTER_FRIEND = 63
HotbarSystem.ContextReturnCodes.TARGETFILTER_ATTACKABLE = 64
HotbarSystem.ContextReturnCodes.TARGETFILTER_CRIMINAL = 65
HotbarSystem.ContextReturnCodes.TARGETFILTER_ENEMY = 66
HotbarSystem.ContextReturnCodes.TARGETFILTER_MURDER = 67
HotbarSystem.ContextReturnCodes.TARGETFILTER_INVULNERABLE = 68
HotbarSystem.ContextReturnCodes.TARGETFILTER_HONORED = 69

HotbarSystem.ContextReturnCodes.TARGETFILTER_NEUTRALS = 70
HotbarSystem.ContextReturnCodes.TARGETFILTER_SUMMONS = 71
HotbarSystem.ContextReturnCodes.TARGETFILTER_BOSSES = 72
HotbarSystem.ContextReturnCodes.TARGETFILTER_PLAYERS = 73
HotbarSystem.ContextReturnCodes.TARGETFILTER_PETS = 74

HotbarSystem.ContextReturnCodes.TARGETFILTER_POISONEDONLY = 75
HotbarSystem.ContextReturnCodes.TARGETFILTER_IGNOREMORTALSTRIKED = 76

HotbarSystem.ContextReturnCodes.TRACKING_SHOWGUMP = 90
HotbarSystem.ContextReturnCodes.TRACKING_ANIMALS = 91
HotbarSystem.ContextReturnCodes.TRACKING_MONSTERS = 92
HotbarSystem.ContextReturnCodes.TRACKING_NPCS = 93
HotbarSystem.ContextReturnCodes.TRACKING_PLAYERS = 94

HotbarSystem.ContextReturnCodes.TARGETCORPSE_UNLOOTED = 101
HotbarSystem.ContextReturnCodes.TARGETCORPSE_LOOTRANGE = 102
HotbarSystem.ContextReturnCodes.TARGETCORPSE_REANIMABLE = 103

HotbarSystem.TID_CLEAR_ITEM = 1077858
HotbarSystem.TID_ASSIGN_HOTKEY = 1078019
HotbarSystem.TID_NEW_HOTBAR = 1078020
HotbarSystem.TID_DESTROY_HOTBAR = 1078026
HotbarSystem.TID_DESTROY_CONFIRM = 1078027
HotbarSystem.TID_CURSOR = 1078071
HotbarSystem.TID_SELF = 1078072
HotbarSystem.TID_CURRENT = 1078073
HotbarSystem.TID_OBJECT_ID = 1094772
HotbarSystem.TID_TARGET = 1078074
HotbarSystem.TID_EDIT_ITEM = 1078196
HotbarSystem.TID_ENABLE_REPEAT = 1079431 -- "Enable Repeating"
HotbarSystem.TID_DISABLE_REPEAT = 1079433 -- "Disable Repeating"
HotbarSystem.TID_LOCK_HOTBAR = 1115431
HotbarSystem.TID_UNLOCK_HOTBAR = 1115432
HotbarSystem.TID_MACRO_EXPORT = 307
HotbarSystem.TID_MACRO_IMPORT = 308

----------------------------------------------------------------
-- MainMenuWindow Functions
----------------------------------------------------------------

HotbarSystem.STATIC_HOTBAR_ID = 1
HotbarSystem.MAX_HOTBAR_ID = 5000

HotbarSystem.TID_ASSIGN_HOTKEY_DESC = 1078096
HotbarSystem.TID_REQUEST_TARGET_ID_DESC = 1094788

-- TEMP VARIABLES
HotbarSystem.OffsetX = 0
HotbarSystem.OffsetY = 0
HotbarSystem.OffsetIncrement = 60

HotbarSystem.FlamingShotCooldownStop = false

--[[
HotbarSystem.RejuvenateCooldown = 0
HotbarSystem.EtherealBurstCooldown = 0
HotbarSystem.WhisperingCooldown = 0
HotbarSystem.PlayingTheOddsCooldown = 0
HotbarSystem.FlamingShotCooldown = 0
HotbarSystem.WarcryCooldown = 0
HotbarSystem.CalledShotCooldown = 0
--]]

HotbarSystem.ReflectionCooldown = 0
HotbarSystem.EtherealVoyageCooldown = 0
HotbarSystem.AttunementCooldown = 0
HotbarSystem.EvasionCooldown = 0
HotbarSystem.StunTime = 0
HotbarSystem.GrapeDelayTime = 0
HotbarSystem.AppleDelayTime = 0
HotbarSystem.HealPotDelayTime = 0
HotbarSystem.BandageDelayTime = 0 -- Starts off at 0 since no bandages have been used yet

HotbarSystem.SkillDelayTimeMax = 0
HotbarSystem.SkillDelayTime = 0

HotbarSystem.OldBandageDelayTime = 0
HotbarSystem.OldSkillDelayTime = 0

HotbarSystem.MacroToUpdate = {}
HotbarSystem.RegisteredSlot = {}

HotbarSystem.WARNINGLEVEL = 10

HotbarSystem.TalismanTimers = {}

HotbarSystem.ItemsEnabledOnParalyze = {
	[3846] = true,
	[3847] = true,
	[3848] = true,
	[3849] = true,
	[3850] = true,
	[3851] = true,
	[3852] = true,
	[3853] = true,
	[3854] = true,
	[10248] = true,
	[10249] = true,
}


function HotbarSystem.Initialize()

	-- setup the assign key description window
	CreateWindow("AssignHotkeyInfo", false)
	LabelSetText("AssignHotkeyInfoText", GetStringFromTid(HotbarSystem.TID_ASSIGN_HOTKEY_DESC))
	local x, y = LabelGetTextDimensions("AssignHotkeyInfoText")
	WindowSetDimensions("AssignHotkeyInfo", x + 16, y + 16)
	
	-- setup the "Request Target ID" description window
	CreateWindow("RequestTargetIdInfo",false)
	LabelSetText("RequestTargetIdInfoText",GetStringFromTid(HotbarSystem.TID_REQUEST_TARGET_ID_DESC))
	local x, y = LabelGetTextDimensions( "RequestTargetIdInfoText" )
	WindowSetDimensions("RequestTargetIdInfo", x + 16, y + 16)
		
	-- create all the hotbars
	for index, hotbarId in pairs(SystemData.Hotbar.HotbarIds) do
		if hotbarId == 0 then
			HotbarUnregister(hotbarId)
			SystemData.Hotbar.HotbarIds[index] = nil
			continue
		end
		HotbarSystem.SpawnNewHotbar(hotbarId)
	end

	-- registering all the hotbars events	
	WindowRegisterEventHandler( "Root", SystemData.Events.MACRO_CHANGED, "HotbarSystem.UpdateMacroReferenceSlot")
	WindowRegisterEventHandler( "Root", SystemData.Events.HOTBAR_HIGHLIGHT_SPELL_ICON, "HotbarSystem.HighlightSpellIcon")
	WindowRegisterEventHandler( "Root", SystemData.Events.HOTBAR_UNHIGHLIGHT_SPELL_ICON, "HotbarSystem.UnhighlightSpellIcon")
	--WindowRegisterEventHandler( "Root", WindowData.ObjectTypeQuantity.Event, "HotbarSystem.UpdateQuantity")
	--WindowRegisterEventHandler( "Root", SystemData.Events.OBJECT_DELAY_TIME, "HotbarSystem.UpdateDelayTime")
	WindowRegisterEventHandler( "Root", SystemData.Events.UPDATE_ACTION_ITEM, "HotbarSystem.HandleUpdateActionItem")
end

function HotbarSystem.Shutdown()
end

-- register the spell for highlight (work for spells like lightning strike that gets highlighted on use like weapon abilities)
function HotbarSystem.RegisterSpellIcon(iconWindow,spellId)
	HotbarSystem.RegisteredSpellIcons[iconWindow] = spellId	
end

-- unregister the spell for highlight (work for spells like lightning strike that gets highlighted on use like weapon abilities)
function HotbarSystem.UnregisterSpellIcon(iconWindow)
	HotbarSystem.RegisteredSpellIcons[iconWindow] = nil	
end

function HotbarSystem.HighlightSpellIcon()

	-- get the spell ID
	local spellId = SystemData.HotbarSystem.HighlightSpellIconInput.highlightSpellID

	-- do we have a valid spell ID?
	if not IsValidID(spellId) then
		return
	end

	-- get the highlight status
	local highlightEnabled = SystemData.HotbarSystem.HighlightSpellIconInput.highlightSpellEnabled

	-- scan all the registerd spells
	for iconWindow, id in pairs(HotbarSystem.RegisteredSpellIcons) do

		-- Is this the spell we're looking for?
		if id == spellId then

			-- is the highlight enabled?
			if (highlightEnabled ~= 0) then

				-- we color the icon in green
				WindowSetTintColor(iconWindow.."SquareIcon", 0, 255, 0)
			end
		end
	end
end

function HotbarSystem.UnhighlightSpellIcon()

	-- get the spell ID
	local spellId = SystemData.HotbarSystem.UnhighlightSpellIconInput.highlightSpellID

	-- do we have a valid spell ID?
	if not IsValidID(spellId) then
		return
	end

	-- get the highlight status
	local highlightEnabled = SystemData.HotbarSystem.UnhighlightSpellIconInput.highlightSpellEnabled

	-- scan all the registerd spells
	for iconWindow, id in pairs(HotbarSystem.RegisteredSpellIcons) do

		-- Is this the spell we're looking for?
		if id == spellId then

			-- is the highlight status disabled?
			if (highlightEnabled == 0) then	

				-- remove the highlight
				WindowSetTintColor(iconWindow.."SquareIcon", 255, 255, 255)
			end
		end
	end
end

function HotbarSystem.DestroyHotbar(hotbarId)

	-- make sure the hotbar exist
	if not Hotbar.DoesHotbarExist(hotbarId, true) then
		return
	end

	-- is this the pet controls bar?
	local petControlsBar = Interface.PetControlsBar == hotbarId

	-- is this the mount blockbar?
	local mountBlockbar = Interface.MountBlockbar == hotbarId

	-- is this the menu bar?
	local menuBar = Interface.MenuBar == hotbarId

	-- is this the static bar? (the first hotbar and can't be destroyed)
	local isStatic = hotbarId == HotbarSystem.STATIC_HOTBAR_ID

	-- this bars CANNOT be destroyed for any reason
	if petControlsBar or mountBlockbar or menuBar or isStatic then
		return
	end

	-- hotbar window name
	local hotbar = "Hotbar" .. hotbarId

	-- clearing all the slots
	for i = 1, 12 do
		
		-- slot window name
		local element = hotbar.."Button"..i

		-- removing the hotkey
		HotbarSystem.UnbindKey(hotbarId, i, SystemData.BindType.BINDTYPE_HOTBAR)

		-- deleting all the slot settings
		Interface.DeleteSetting( element .. "Custom" )
		Interface.DeleteSetting( element .. "CustomTXT" )
		Interface.DeleteSetting( element .. "ItemName" )
		Interface.DeleteSetting( element .. "EnableAlert" )
		Interface.DeleteSetting( element .. "EnableCharges" )

		-- removing the target mouse over for the slot
		HotbarSystem.UpdateTargetMouseOver(hotbarId, i, 0, nil)
	end

	-- removing all the settings for the hotbar
	Interface.DeleteSetting( hotbar .. "_IsBlockbar" )
	Interface.DeleteSetting( hotbar .."SC" )
	Interface.DeleteSetting( hotbar .."ALP")
	Interface.DeleteSetting( hotbar .."NameVrev")
	Interface.DeleteSetting( hotbar .."NameHrev")
	Interface.DeleteSetting( hotbar .."NameH")
	Interface.DeleteSetting( hotbar .."NameV")
	Interface.DeleteSetting( hotbar .."SizeW")
	Interface.DeleteSetting( hotbar .."SizeH")
	Interface.DeleteSetting( hotbar .."HandleColor")
	Interface.DeleteSetting( hotbar .."LeftToRight")
	Interface.DeleteSetting( hotbar .."LockWithHandle")
	Interface.DeleteSetting( hotbar .."Closed")
	Interface.DeleteSetting( hotbar .."Fade")
	Interface.DeleteSetting( hotbar .."ReverseText")
		
	-- removing the window position and sizes
	WindowUtils.ClearWindowPosition(hotbar)

	-- unregistering the hotbar
	HotbarUnregister(hotbarId)

	-- destroying the window
	DestroyWindow(hotbar)
end

function HotbarSystem.DestroyHotbarGroup(windowName)
	
	-- make sure the window exist
	if not DoesWindowExist(windowName) then
		return
	end

	-- getting all the elements of the group
	local grp, cnt = Hotbar.FindHotbarGroup(windowName)
	
	-- parsing all the group elements
	for hbar, _ in pairs(grp) do
		
		-- getting the hotbar ID
		local hotbarId = WindowGetId(hbar)

		-- destroying the hotbar
		HotbarSystem.DestroyHotbar(hotbarId)
	end
end

function HotbarSystem.SpawnNewHotbar(hotbarId, slots, isBlockbar)

	-- this variable indicates that we have created a new index and we have to set the initial position
	local setPosition = false

	-- do we have a valid hotbar ID?
	if (not IsValidID(hotbarId) or not Hotbar.DoesHotbarExist(hotbarId)) then

		-- we get a new id
		hotbarId = HotbarSystem.GetNextHotbarId()

		-- we create the hotbar with the ID we obtained
		HotbarRegisterNew(hotbarId)

		-- the hotbar need to be positioned (since it's new)
		setPosition = true
		
		-- set the new hotbars default to unlocked
		SystemData.Hotbar[hotbarId].Locked = false
	end

	-- hotbar window name
	local hotbar = "Hotbar" .. hotbarId

	-- are we creating a blockbar? if yes we save the setting
	if isBlockbar then
		Interface.SaveSetting(hotbar .. "_IsBlockbar", true)
	end

	-- assigning the ID to the dynamic window so the hotbar can be initialized	
	SystemData.DynamicWindowId = hotbarId

	-- creating the window
	CreateWindowFromTemplate(hotbar, "Hotbar", "Root")

	-- assigning the ID to the window
	WindowSetId(hotbar, hotbarId)

	-- hotbars need to have their position generated when created for the first time
	if (setPosition == true) then

		-- is this a blockbar?
		if Interface.LoadSetting(hotbar .. "_IsBlockbar", false) then

			-- resizing to 1x1 slot
			WindowSetDimensions(hotbar, Hotbar.BUTTON_SIZE, Hotbar.BUTTON_SIZE)

			-- processing the resize
			Hotbar.OnResizeEnd(hotbar)

			-- locking the blockbar
			Hotbar.SetLocked(hotbarId, true)

		-- if this is NOT a macro
		elseif (hotbarId ~= HotbarSystem.STATIC_HOTBAR_ID) then

			-- clearing the current anchors
			WindowClearAnchors(hotbar)

			-- moving the hotbar to the starting position (top-left corner of the game window, then it moves down for each bar created)
			WindowAddAnchor(hotbar, "topleft", "ResizeWindow", "topleft", HotbarSystem.OffsetX, HotbarSystem.OffsetY)

			-- getting the numeric values of the position
			local x, y = WindowGetOffsetFromParent(hotbar)

			-- removing the anchors
			WindowClearAnchors(hotbar)

			-- moving the window to the position manually
			WindowSetOffsetFromParent(hotbar, x, y)
		
			-- increasing the starting posizion offset (so the next bar won't overlap)
			HotbarSystem.OffsetY = HotbarSystem.OffsetY + HotbarSystem.OffsetIncrement
			
			-- when we get to the bottom, we start over from the top
			if (HotbarSystem.OffsetY > 800) then
			    
				-- reset offset Y
				HotbarSystem.OffsetY = 0

				-- increasing the offset X by the hotbar width
			    HotbarSystem.OffsetX =  HotbarSystem.OffsetX + HotbarSystem.OffsetIncrement

				-- if we reached the end of the screen, we reset the X too
			    if HotbarSystem.OffsetX > 1200 then
					HotbarSystem.OffsetX = 0
			    end
			end
		end
	end

	-- do we have a number of slots specified?
	if IsValidID(slots) then

		-- we resize the bar to match the required number of slots
		WindowSetDimensions(hotbar, Hotbar.BUTTON_SIZE * slots, Hotbar.BUTTON_SIZE)

		-- process the resizing
		Hotbar.OnResizeEnd(hotbar)
	end

	return hotbarId
end

function HotbarSystem.GetNextHotbarId()
	
	-- by default there is always 1 hotbar so the first possible id is 2
	local newHotbarId = 2
	
	-- we start to process IDs from 2 to the maximum possible
	while newHotbarId ~= HotbarSystem.MAX_HOTBAR_ID do

		-- if there is no hotbar with the current ID then we have found one free
		if not Hotbar.DoesHotbarExist(newHotbarId, false) then
			return newHotbarId
		end
		
		-- increasing the id and try again
		newHotbarId = newHotbarId + 1
	end
	
	-- it should never reach this point, is just for safety
	return newHotbarId
end

function HotbarSystem.RegisterAction(element, hotbarId, itemIndex, subIndex)
	
	-- make sure the hotbar exist and the ids are valids
	if (hotbarId ~= SystemData.MacroSystem.STATIC_MACRO_ID and not Hotbar.DoesHotbarExist(hotbarId, true)) or not IsValidID(itemIndex) or not DoesWindowExist(element) then
		return
	end

	-- if it's not a macro we check if the slot has something inside first otherwise is all pointless
	if hotbarId ~= SystemData.MacroSystem.STATIC_MACRO_ID and not HotbarHasItem(hotbarId, itemIndex) then
		return
	end

	-- the element has already been registed
	if HotbarSystem.RegisteredSlot[element] then
		return
	end

	-- getting the action ID
	local actionId = UserActionGetId(hotbarId, itemIndex, subIndex)

	-- is this a valid action id? if not the slot is empty
	if not IsValidID(actionId) then
		return
	end
	
	-- getting the action type
	local actionType = UserActionGetType(hotbarId, itemIndex, subIndex)

	-- fixing the old boats commands. If the function returns true then the action has been remove.
	if ActionsWindow.OldBoatCommandsFix(element, hotbarId, itemIndex, subIndex, actionId, actionType) then
		return
	end

	-- getting the icon ID
	local iconId = UserActionGetIconId(hotbarId, itemIndex, subIndex)

	-- is the slot disabled?
	local disabled = not UserActionIsTargetModeCompat(hotbarId, itemIndex, subIndex)
	
	-- is this a macro?
	if HotbarSystem.IsHotbarMacro(actionType) then
		
		-- get the real macro id
		local macroIndex = MacroSystemGetMacroIndexById(iconId)

		-- update the disabled flag with the macro data
		disabled = not UserActionIsTargetModeCompat(SystemData.MacroSystem.STATIC_MACRO_ID, macroIndex, 0)

	-- is this a stat?
	elseif (actionType == SystemData.UserAction.TYPE_PLAYER_STATS) then

		-- getting the stat name from the ID
		local statName = CharacterSheet.GetStatNameById(actionId)

		-- checking if the icon is correct
		if iconId ~= CharacterSheet.AttributesDef[statName].iconId then

			-- icon incorrect, we replace it with the right one
			iconId = CharacterSheet.AttributesDef[statName].iconId
			UserActionSetIconId(hotbarId, itemIndex, subIndex, iconId)
		end

	-- is that an item?
	elseif HotbarSystem.IsHotbarItem(actionType) then  
	
		-- loading object ID for items
		local objectID = 0

		-- stackable items (actionID = type)
		if actionType == SystemData.UserAction.TYPE_USE_OBJECTTYPE then

			-- setting the object ID
			objectID = UserActionGetNextObjectId(actionId)
				
		-- normal item (actionID = item id). Make sure the player has the item or we won't have any info about it.
		elseif actionType == SystemData.UserAction.TYPE_USE_ITEM and DoesPlayerHaveItem(actionId) then
				
			-- setting the object ID
			objectID = actionId
		end
		
		-- is a valid item?
		if IsValidID(objectID) and DoesPlayerHaveItem(objectID) then

			-- getting the item name
			local itemName = GetItemName(objectID)

			-- if the name is valid, we save it
			if IsValidWString(itemName) then
				Interface.SaveSetting(element.."ItemName", itemName)
			end
			
			-- updating the icon (so that colors and all will be correct)
			EquipmentData.UpdateItemIcon(element.."SquareIcon", objectID)
		else
			-- getting object type and hue
			local objectType, hue = UserActionUseObjectTypeGetObjectTypeHue(actionId) 
				
			-- update the icon with what we know		
			EquipmentData.DrawObjectIconAtWindowDimensions(objectType, hue, element.."SquareIcon")
		end
	end

	-- updating the texture
	HotbarSystem.UpdateActionButton(hotbarId, itemIndex, subIndex, element, actionType, actionId, iconId, disabled)

	-- updating the target
	HotbarSystem.UpdateTargetTypeIndicator(element, hotbarId, itemIndex, subIndex)

	-- flag that prevents multiple registrations of the same element (otherwise it will be registered continuously)
	HotbarSystem.RegisteredSlot[element] = true
end

function HotbarSystem.UpdateActionButton(hotbarId, itemIndex, subIndex, element, actionType, actionId, iconId, bDisabled )

	-- make sure the element exist
	if not DoesWindowExist(element) then
		return
	end
	
	-- element windows names
	local elementIcon = element.."SquareIcon"
	local elementHotkey = element.."Hotkey"
	local elementOverlay = element.."Overlay"
	local elementAlert = element.."Alert"
	local elementDisabled = element.."Disabled"
	
	-- disable alert by default (or the drag window will show it active)
	if DoesWindowExist(elementAlert) then
		WindowSetShowing(elementAlert, false)
	end

	-- disable disabled status by default (or the drag window will show it active)
	if DoesWindowExist(elementDisabled) then
		WindowSetShowing(elementDisabled, false)
	end

	-- is this an hotbar and the slot have something inside? (or the drag window)
	if (subIndex == 0 and HotbarHasItem(hotbarId, itemIndex)) or element == "DragWindowAction" then
		
		-- loading the border and background texture
		HotbarSystem.SetCustomTextureNBorder(element)

		-- showing the background
		WindowSetShowing(elementIcon .."BG", true)

		-- is this a dragged slot?
		if element == "DragWindowAction" then

			-- initialize objectID
			local objectID = 0

			-- stackable items (actionID = type)
			if actionType == SystemData.UserAction.TYPE_USE_OBJECTTYPE then

				-- setting the object ID
				objectID = UserActionGetNextObjectId(actionId)

				if IsValidID(objectID) then

					-- updating the icon (so that colors and all will be correct)
					EquipmentData.UpdateItemIcon(element.."SquareIcon", objectID)
				else
					-- getting object type and hue
					local objectType, hue = UserActionUseObjectTypeGetObjectTypeHue(actionId) 

					-- update the icon with what we know		
					EquipmentData.DrawObjectIconAtWindowDimensions(objectType, hue, element.."SquareIcon")
				end

			-- normal item (actionID = item id).
			elseif actionType == SystemData.UserAction.TYPE_USE_ITEM then
				
				-- setting the object ID
				objectID = actionId

				if IsValidID(objectID) and DoesPlayerHaveItem(objectID) then

					-- updating the icon (so that colors and all will be correct)
					EquipmentData.UpdateItemIcon(element.."SquareIcon", objectID)
				else
					-- getting object type and hue
					local objectType, hue = UserActionUseObjectTypeGetObjectTypeHue(actionId) 

					-- update the icon with what we know		
					EquipmentData.DrawObjectIconAtWindowDimensions(objectType, hue, element.."SquareIcon")
				end
			end
		end
	end
	
	-- is this a weapon ability?
	if (actionType == SystemData.UserAction.TYPE_WEAPON_ABILITY and element ~= "DragWindowAction") then
		
		-- registering the slot so that when we activate the ability it will get highlighted
		EquipmentData.RegisterWeaponAbilitySlot(element, actionId)

	-- is this anything else but an item?
	elseif not HotbarSystem.IsHotbarItem(actionType) then

		-- show the right icon
		HotbarSystem.SetHotbarIcon(element, iconId)

		-- is this a spell?
		if (actionType == SystemData.UserAction.TYPE_SPELL) then
		
			-- register the slot for highlight (for spells like lightning strike)
			HotbarSystem.RegisterSpellIcon(element, actionId)
		end
	end
end

function HotbarSystem.UpdateTargetTypeIndicator(element, hotbarId, itemIndex, subIndex)

	-- does the element exist?
	if not DoesWindowExist(element) then
		return
	end

	-- element border name
	local elementOverlay = element.."Overlay"

	-- update the border and background texture
	HotbarSystem.SetCustomTextureNBorder(element)

	-- reset the border color
	WindowSetTintColor(elementOverlay, 0, 0, 0)

	-- does this item requires a target?
	if (UserActionHasTargetType(hotbarId, itemIndex, subIndex) and SystemData.Settings.GameOptions.legacyTargeting == false) then
		
		-- is this a sub-action of a macro?
		if subIndex ~= 0 then
			
			-- the element name must change
			element = "Macro_" .. itemIndex .. "_" .. subIndex
		end

		-- get the target type for the current slot
	    local targetType = UserActionGetTargetType(hotbarId, itemIndex, subIndex, element)
		
		-- get the border color for the current target type
		local tintColor = Interface.Settings.TargetTypeTintColors[targetType]
	    
		-- applying the color to the border
	    WindowSetTintColor(elementOverlay, tintColor.r, tintColor.g, tintColor.b)

	else -- no target support for the slot

		-- get the border color for the "NO target" type
		local tintColor = Interface.Settings.TargetTypeTintColors[SystemData.Hotbar.TargetType.TARGETTYPE_NONE]
		
		-- applying the color to the border
	    WindowSetTintColor(elementOverlay, tintColor.r, tintColor.g, tintColor.b)
	end
end

function HotbarSystem.ClearActionIcon(element, hotbarId, itemIndex, subIndex, shutdown)

	-- does the element exist?
	if not DoesWindowExist(element) then
		return
	end

	-- window elements name
	local elementIcon = element.."SquareIcon"
	local elementHotkey = element.."Hotkey"
	
	-- was the cooldown active?
	if (DoesWindowExist(element.."Cooldown")) then
		
		-- remove the timer text
		LabelSetText(element.."BandageTime", L"")

		-- demoving the cooldown window
		DestroyWindow(element.."Cooldown")

		-- re-enabling the hotkey
		WindowSetShowing(element .. "Hotkey", true)

		-- restoring the disabled mask layer
		WindowSetLayer(element.."Disabled", Window.Layers.OVERLAY)
	end

	-- deleting all the slot settings
	if not shutdown then
		Interface.DeleteSetting( element .. "Custom" )
		Interface.DeleteSetting( element .. "CustomTXT" )
		Interface.DeleteSetting( element .. "ItemName" )
		Interface.DeleteSetting( element .. "EnableAlert" )
		Interface.DeleteSetting( element .. "EnableCharges" )
	end
	
	-- remove the spell from the highlight list (like lightning strike)
	HotbarSystem.UnregisterSpellIcon(element)

	-- resetting the icon texture dimensions
	DynamicImageSetTextureDimensions(elementIcon, 50, 50)

	-- resetting the slot dimensions
	WindowSetDimensions(elementIcon, 50, 50)

	-- removing the icon
	DynamicImageSetTexture(elementIcon, "", 0, 0 )

	-- restoring the icon scale
	DynamicImageSetTextureScale(elementIcon, 0.78 )	

	-- resetting the icon color
	WindowSetTintColor(elementIcon, 255, 255, 255)

	-- resetting the icon alpha
	WindowSetAlpha(elementIcon, 1.0)
	
	-- removing the background
    WindowSetShowing(elementIcon .."BG", false)

	-- removing the quantity text
    LabelSetText(element.."Quantity", L"")
	
	-- removing the alert highlight
	WindowSetShowing(element.."Alert", false)

	-- re-enabling the slot
	WindowSetShowing(element.."Disabled", false)
	ButtonSetDisabledFlag(element, false)
	
	--Clear the label text when the players stats icon is cleared
	LabelSetText(element.."Stats", L"")
	LabelSetText(element.."StatsTop", L"")
	LabelSetText(element.."StatsBottom", L"")
	
	-- clear the weapon ability slot (if this was a weapon ability)
	EquipmentData.UnregisterWeaponAbilitySlot(element)		

	-- restoring the border color
	HotbarSystem.UpdateTargetTypeIndicator(element, hotbarId, itemIndex, subIndex)

	-- setting the element as unregistered
	HotbarSystem.RegisteredSlot[element] = nil
end

function HotbarSystem.SetHotbarIcon(element, iconId)

	-- make sure the element exist
	if not DoesWindowExist(element) then
		return
	end	
	
	-- is a valid icon id?
	if not iconId then
		return
	end
	
	-- element icon window name
	local elementIcon = element.."SquareIcon"
	local elementBG = elementIcon.."BG"

	-- getting the icon informations
	local texture, x, y = GetIconData( iconId )

	-- setting the icon dimensions
	DynamicImageSetTextureDimensions(elementIcon, 50, 50)

	-- setting the window dimensions
	WindowSetDimensions(elementIcon, 50, 50)

	-- is the icon 620? (empty slot)
	if (iconId == 620) then

		-- setting the icon = to the background
		DynamicImageSetTexture( elementIcon, MiniTexturePack.DB[Interface.Settings.MTP_Current].texture .. "Icon", 0, 0 )

		-- scaling the icon correctly
		DynamicImageSetTextureScale(elementIcon, 0.78 )

		-- hiding the backgrupd (icon and background are the same)
		WindowSetShowing(elementBG, false)
	
	else -- another icon
		
		-- drawing the texture
		DynamicImageSetTexture( elementIcon, texture, x, y )		

		-- scaling the icon correctly
		DynamicImageSetTextureScale(elementIcon, 0.78 )

		-- showing the background (custom texture pack)
		WindowSetShowing(elementBG, true)
	end
end

function HotbarSystem.UpdatePlayerStatLabel(element, id)
	
	-- we got compressed parameters instead of the element so we have to decompress it
	if type(element) == "table" then
		id = element[2]
		element = element[1]
	end

	-- getting the stat name
	local statsName = CharacterSheet.GetStatNameById(id)
	
	-- flag that indicates this stat is from the loyalty status gump
	CharacterSheet.LoyaltyInHotbar = CharacterSheet.isInLoyaltyRating(statsName)

	-- is that bank gold action?
	CharacterSheet.BankGoldInHotbar = statsName == "BankGold"

	-- reset the labels content
	LabelSetText(element.."Stats", L"")
	LabelSetText(element.."StatsTop", L"")
	LabelSetText(element.."StatsBottom", L"")

	-- does this stat have a separator?
	if (CharacterSheet.AttributesDef[statsName].separator) then

		-- initialize the current value name
		local curVal = statsName

		-- initialize max value name
		local maxVal = string.gsub(statsName, "Current", "")

		-- getting the top (current) value for the stat
		local topValue = WindowData.PlayerStatus[curVal] or 0
		
		-- getting the bottom (max) value for the stat
		local bottomValue = WindowData.PlayerStatus["Max"..maxVal] or 0

		-- is this stt the weight?		
		if ((statsName == "Weight")) then

			-- if the top value is near the warning level we have to highlight the slot by changing the icon
			if (topValue >= (bottomValue - HotbarSystem.WARNINGLEVEL)) then
				HotbarSystem.SetHotbarIcon(element, CharacterSheet.AttributesDef[statsName].warningIconId)	

			else -- otherwise we reset the icon to normal
				HotbarSystem.SetHotbarIcon(element, CharacterSheet.AttributesDef[statsName].iconId)
			end
		end
		
		-- writing the current value
		LabelSetText(element.."StatsTop", towstring(topValue)  )

		-- writing the bottom value
		LabelSetText(element.."StatsBottom", towstring(bottomValue) )

	else -- stat without a separator

		-- getting the current value for the stat
		local currValue = WindowData.PlayerStatus[statsName]

		-- preventing problems by setting to 0 nil a value
		if currValue == nil then
			currValue = 0
		end
		
		-- getting the cap value for the stat
		local capValue = WindowData.PlayerStatus["Max"..statsName]

		-- preventing problems by setting to 0 nil a value
		if capValue == nil then
			capValue = 0
		end

		-- is this stat the player damage?
		if statsName == "Damage" then
			local labelString = towstring(currValue) .. L"-" .. towstring(capValue)
			
			-- updating the label text
			LabelSetText(element.."Stats", labelString )

		-- tithings or gold?
		elseif statsName == "TithingPoints" or statsName == "Gold" or statsName == "BankGold" then 
			
			-- we just replace some thousands spots with K
			local labelString = Knumber(currValue)

			-- updating the label text
			LabelSetText(element.."Stats", labelString )

		-- does this stat need to show a fixed cap?
		elseif (CharacterSheet.AttributesDef[statsName].cap) then
			
			-- getting the fixed cap value
			local cap = CharacterSheet.AttributesDef[statsName].cap

			-- showing the current value on top
			LabelSetText(element.."StatsTop", towstring(currValue)  )

			-- showing the cap at the bottom
			LabelSetText(element.."StatsBottom", towstring(cap) )	

		-- is there a variable cap?
		elseif IsValidID(capValue) then
			
			-- showing the current value on top
			LabelSetText(element.."StatsTop", towstring(currValue)  )

			-- showing the cap at the bottom
			LabelSetText(element.."StatsBottom", towstring(capValue) )	

		else -- for any other cases...

			-- the current value is a number?
			if type(currValue) == "number" then

				-- se set the number replacing thousands with K
				LabelSetText(element.."Stats", Knumber(currValue) )

			else -- if the current value is a string we show it as it is

				LabelSetText(element.."Stats", towstring(currValue) )
			end
		end
	end
end

function HotbarSystem.DestroyCooldown(element)
	
	-- does the cooldown still exist?
	if DoesWindowExist(element.."Cooldown") then
			
		-- destroy the cooldown animation
		DestroyWindow(element.."Cooldown")

		-- showing the hotkey
		WindowSetShowing(element .. "Hotkey", true)
			
		-- enabling the slot
		WindowSetShowing(element.."Disabled", false)	
		ButtonSetDisabledFlag(element, false)					

		-- restoring the disabled mask layer
		WindowSetLayer(element.."Disabled", Window.Layers.OVERLAY)

		-- removing the timer text
		LabelSetText(element.."BandageTime", L"")
	end
end

function HotbarSystem.UpdateCooldownSlot(element, cooldownTimer, alphaMod, cooldownLabel, forceReset)

	-- is the time up?
	if (cooldownTimer <= 0) then
		
		-- does the cooldown still exist?
		if DoesWindowExist(element.."Cooldown") then
			
			-- destroy the cooldown animation
			DestroyWindow(element.."Cooldown")

			-- showing the hotkey
			WindowSetShowing(element .. "Hotkey", true)
			
			-- enabling the slot
			WindowSetShowing(element.."Disabled", false)	
			ButtonSetDisabledFlag(element, false)					

			-- restoring the disabled mask layer
			WindowSetLayer(element.."Disabled", Window.Layers.OVERLAY)

			-- removing the timer text
			LabelSetText(element.."BandageTime", L"")
		end

	else -- timer is still going or just started
		
		-- do we have to reset the animation?
		if forceReset then
			
			-- making sure the cooldown animation still exist
			if DoesWindowExist(element.."Cooldown") then

				-- destroy the animation
				DestroyWindow(element.."Cooldown")
			end
		end

		-- do we have a different value to show instead of the timer?
		if IsValidWString(cooldownLabel) then

			-- update the timer with the custom value
			LabelSetText(element.."BandageTime", cooldownLabel)

		else -- update the timer with the current value
			LabelSetText(element.."BandageTime", StringUtils.SecondsCooldown(cooldownTimer, false))
		end

		-- using the text custom color
		LabelSetTextColor(element.."BandageTime", Interface.Settings.HB_CountdownTimer.r, Interface.Settings.HB_CountdownTimer.g, Interface.Settings.HB_CountdownTimer.b)

		-- making sure the cooldown not exist
		if not DoesWindowExist(element .. "Cooldown") then

			-- creating the cooldown item
			CreateWindowFromTemplate(element .. "Cooldown", "CooldownEffect", element)

			-- starting cooldown animation
			AnimatedImageStartAnimation(element .. "Cooldown", 2, false, false, 0)

			-- setting the animation speed based on the cooldown lenght
			AnimatedImageSetPlaySpeed(element .. "Cooldown", math.max(1, math.floor(Cooldown.Frames/cooldownTimer)) )

			-- setting the base alpha for the cooldown
			WindowSetAlpha(element .. "Cooldown", 0.65)

			-- hiding the hotkey
			WindowSetShowing(element .. "Hotkey", false)
			WindowSetShowing(element.."HotkeyBackground", false)

			-- disabling the slot
			WindowSetShowing(element.."Disabled", true)	
			ButtonSetDisabledFlag(element, true)					

			-- positioning the timer text
			WindowClearAnchors(element.."BandageTime")
			WindowAddAnchor(element.."BandageTime", "topleft", element, "topleft", 0, 15)

			-- bringing the time text on top
			WindowSetLayer(element.."BandageTime", Window.Layers.OVERLAY)

			-- bringing the disabled mask down
			WindowSetLayer(element.."Disabled", Window.Layers.SECONDARY)	
			
		else -- the cooldown is active so we update it

			-- calculating the alpha based on the time left (0.8 max, 0.3 min)
			local alpha = ((cooldownTimer * alphaMod) / 100) / 10
			if alpha > 0.8 then
				alpha = 0.8
			elseif alpha < 0.3 then
				alpha = 0.3
			end

			-- updating the alpha
			WindowSetAlpha(element .. "Cooldown", alpha)

			-- hiding the hotkey
			WindowSetShowing(element .. "Hotkey", false)
			WindowSetShowing(element.."HotkeyBackground", false)

			-- disabling the slot
			WindowSetShowing(element.."Disabled", true)	
			ButtonSetDisabledFlag(element, true)		
		end
	end
end

function HotbarSystem.HandleUpdateActionItem()
	
	-- update the current edited macro actions list when an item is moved out
	if (SystemData.UpdateActionItem.hotbarId == SystemData.MacroSystem.STATIC_MACRO_ID) then
		MacroEditWindow.UpdateMacroActionList("ActionEditMacro", SystemData.UpdateActionItem.hotbarId, SystemData.UpdateActionItem.itemIndex)

	else -- update the hotbar when an item is moved out
		Hotbar.ClearHotbarItem(SystemData.UpdateActionItem.hotbarId, SystemData.UpdateActionItem.itemIndex)
		Hotbar.SetHotbarItem(SystemData.UpdateActionItem.hotbarId, SystemData.UpdateActionItem.itemIndex)
	end
end

function HotbarSystem.UpdateTargetMouseOver(hotbarId, slotId, subId, param)
	
	-- is the interface started?
	if not Interface.started then
		return
	end

	-- is the target mouseover array initialized?
	if not HotbarSystem.TargetMouseOver then
		HotbarSystem.TargetMouseOver = {}
	end

	-- this happens when a macro gets deleted
	if subId == "all" then
		
		-- first we remove the macro data of all the sub slots (all the data of the deleted macro)
		for element, paramS in pairs(HotbarSystem.TargetMouseOver) do

			-- is this part of the deleted macro?
			if paramS.ItemIndex == slotId then
				HotbarSystem.TargetMouseOver[element] = nil
			end
		end

		-- initialize new array
		local newArray = {}

		-- now we have to check all the macros and do a -1 (since the all the macros indexes get reduced by 1)
		for element, paramS in pairs(HotbarSystem.TargetMouseOver) do
			
			-- this is not a macro so we can copy it as it is
			if paramS.SubIndex == 0  then 
				newArray[element] = table.copy(paramS)
				continue
			end

			 -- this macro id is inferior to the one of the deleted maro, so we can copy it as it is
			if paramS.ItemIndex < slotId  then
				newArray[element] = table.copy(paramS)
				continue
			end

			 -- this macro data needs to be reworked
			if paramS.ItemIndex > slotId  then
				
				-- reduce the index by 1
				paramS.ItemIndex = paramS.ItemIndex - 1

				-- update the element name
				local newElement = "Macro_" .. paramS.ItemIndex .. "_" .. paramS.SubIndex
				param.SlotWindow = newElement
				
				-- copy the new data to the new array
				newArray[newElement] = table.copy(paramS)
			end
		end

		-- now we recreate the TargetMouseOver array
		HotbarSystem.TargetMouseOver = {}
		HotbarSystem.TargetMouseOver = table.copy(newArray)

	-- update a macro action
	elseif subId ~= 0 then
		HotbarSystem.TargetMouseOver["Macro_" .. slotId .. "_" .. subId] = param

	else -- update a normal hotbar action
		local element = "Hotbar"..hotbarId.."Button"..slotId
		HotbarSystem.TargetMouseOver[element] = param
	end
	UserSettingsChanged()
end

-- update one bar at turn
function HotbarSystem.UpdateHotbar(timePassed)
	
	-- if the interface is not started we wait
	if not Interface.started then
		return
	end

	-- checking if the bandage timer has been reset
	local forceBandageReset = HotbarSystem.BandageDelayTime > HotbarSystem.OldBandageDelayTime

	-- checking if the skill timer has been reset
	local forceSkillReset = HotbarSystem.SkillDelayTime > HotbarSystem.OldSkillDelayTime

	-- backup the current skill time for future check for resets
	HotbarSystem.OldSkillDelayTime = HotbarSystem.SkillDelayTime

	-- backup the current bandage time for future check for resets
	HotbarSystem.OldBandageDelayTime = HotbarSystem.BandageDelayTime

	-- hotbar window name
	local hotbar = SystemData.ActiveWindow.name

	-- get the hotbar id
	local hotbarId = WindowGetId(hotbar)

	-- make sure the hotbar exist and the id is correct
	if not Hotbar.DoesHotbarExist(hotbarId, true) then
		return
	end

	-- is the bar visible?
	if Hotbar.IsShrunken(hotbarId, false) then
		return
	end

	-- has this hotbar just being released from dragging? (and is not still being dragged around)
	if Hotbar.JustReleased[hotbar] and not WindowGetMoving(hotbar) then

		-- increase the timer
		Hotbar.JustReleased[hotbar].timer = Hotbar.JustReleased[hotbar].timer + timePassed

		-- if the time is up, we can remove it from the list
		if Hotbar.JustReleased[hotbar].timer > Hotbar.ReleaseTimeBeforeUse then
			Hotbar.JustReleased[hotbar] = nil
		end
	end

	-- is this the mount blockbar?
	if hotbarId == Interface.MountBlockbar then
		pcall(HotbarSystem.HandleMountsBlockbarVisibility)
	end

	-- scanning all items for update
	for itemIndex = 1, Hotbar.NUM_BUTTONS do
		
		-- default value for hotbars
		local subIndex = 0

		-- slot window name
		local element = hotbar .. "Button" .. itemIndex

		-- is the slot existing and the element visible?
		if not DoesWindowExist(element) or not WindowGetShowing(element) then
			continue
		end

		-- make sure the hotbar really has something in this slot
		if HotbarHasItem(hotbarId, itemIndex) then

			-- updating target mouse over for the slot
			pcall(HotbarSystem.UpdateSlotTargetMouseOver, {hotbarId, itemIndex, 0, element})

			-- disable the glowing for drag items (if it's time...)
			pcall(HotbarSystem.HandleDragGlowing, element)

			-- getting the current action type
			local actionType = UserActionGetType(hotbarId, itemIndex, subIndex)

			-- getting the current action ID
			local actionId = UserActionGetId(hotbarId, itemIndex, subIndex)

			-- clear old actions
			if actionId == 5008 or actionId == 5754 or actionId == 5755 then -- old chat button, big map and server lines

				-- clearing the slot for good
				HotbarClearItem(hotbarId, itemIndex)

				-- remove the action from the slot
				HotbarSystem.ClearActionIcon(element, hotbarId, itemIndex, 0)
				continue
			end

			-- loading object ID, type and hue for items
			local objectID = 0
			local objectType = 0
			local hue = 0

			-- stackable items (actionID = type)
			if actionType == SystemData.UserAction.TYPE_USE_OBJECTTYPE then
			
				-- getting object type and hue
				objectType, hue = UserActionUseObjectTypeGetObjectTypeHue(actionId) 

				-- setting the object ID
				objectID = UserActionGetNextObjectId(actionId)
				
			-- normal item (actionID = item id). Make sure the player has the item or we won't have any info about it.
			elseif actionType == SystemData.UserAction.TYPE_USE_ITEM then

				-- getting the item info
				local itemData = Interface.GetObjectInfoData(actionId)

				-- making sure we have the info
				if itemData then

					-- getting object type
					objectType = itemData.objectType

					-- getting hue id
					hue = itemData.hueId
				end
				
				-- setting the object ID
				objectID = actionId

			-- player backpack action
			elseif actionId ~= 5011 then
				
				-- getting the player backpack id
				objectID = GetBackpackID(GetPlayerID())
			end

			-- is a player stat?
			if actionType == SystemData.UserAction.TYPE_PLAYER_STATS then
				pcall(HotbarSystem.UpdatePlayerStatLabel, {element, actionId})

			-- is this a weapon special ability?
			elseif actionType == SystemData.UserAction.TYPE_WEAPON_ABILITY then
				pcall(HotbarSystem.UpdateWeaponSpecialSlot, {element, actionId})

			-- war mode action: we highlight when war mode is active
			elseif	actionType == SystemData.UserAction.TYPE_TOGGLE_WAR_MODE or
					actionType == SystemData.UserAction.TYPE_WAR_MODE
			then
				WindowSetShowing(element.."Alert", WindowData.PlayerStatus.InWarMode)

			-- always run action: highlight when active
			elseif actionType == SystemData.UserAction.TYPE_TOGGLE_ALWAYS_RUN then
				WindowSetShowing(element.."Alert", SystemData.Settings.GameOptions.alwaysRun)
			
			-- skills
			elseif actionType == SystemData.UserAction.TYPE_SKILL then
				
				-- disable the alert if the element is not highlighted
				WindowSetShowing(element.."Alert", HotbarSystem.GlowingItems[element] ~= nil)
				
				-- enabling the slot (disabled if the player is dead)
				WindowSetShowing(element.."Disabled", Interface.IsPlayerDead)
				ButtonSetDisabledFlag(element, Interface.IsPlayerDead)
				
				-- showing the cooldown
				HotbarSystem.UpdateCooldownSlot(element, HotbarSystem.SkillDelayTime, HotbarSystem.SkillDelayTimeMax, nil, forceSkillReset)

			-- spells
			elseif actionType == SystemData.UserAction.TYPE_SPELL then
				
				-- showing evasion cooldown
				if actionId == 403 and HotbarSystem.EvasionCooldown > 0 then -- EVASION
					HotbarSystem.UpdateCooldownSlot(element, HotbarSystem.EvasionCooldown, 16)
						
				-- showing attunement cooldown
				elseif actionId == 604 and HotbarSystem.AttunementCooldown > 0 then -- ATTUNEMENT
					HotbarSystem.UpdateCooldownSlot(element, HotbarSystem.AttunementCooldown, 120)
						
				-- showing ethereal voyage cooldown
				elseif actionId == 613 and HotbarSystem.EtherealVoyageCooldown > 0 then -- ETHEREAL VOYAGE
					HotbarSystem.UpdateCooldownSlot(element, HotbarSystem.EtherealVoyageCooldown, 300)	
				
				-- showing reflection cooldown
				elseif actionId == 36 and HotbarSystem.ReflectionCooldown > 0 then -- MAGIC REFLECTION
					HotbarSystem.UpdateCooldownSlot(element, HotbarSystem.ReflectionCooldown, 30)

				-- showing called shot cooldown
				elseif actionId == 732 and HotbarSystem.CalledShotCooldown and HotbarSystem.CalledShotCooldown > 0 then -- CALLED SHOT
					HotbarSystem.UpdateCooldownSlot(element, HotbarSystem.CalledShotCooldown, 60)

				-- showing warcry cooldown
				elseif actionId == 717 and HotbarSystem.WarcryCooldown and HotbarSystem.WarcryCooldown > 0 then -- WARCRY
					HotbarSystem.UpdateCooldownSlot(element, HotbarSystem.WarcryCooldown, 1200)

				-- showing flaming shot cooldown
				elseif actionId == 723 and HotbarSystem.FlamingShotCooldown and HotbarSystem.FlamingShotCooldown > 0 then -- FLAMING SHOT
					HotbarSystem.UpdateCooldownSlot(element, HotbarSystem.FlamingShotCooldown, 10)

				-- showing playing the odds cooldown
				elseif actionId == 724 and HotbarSystem.PlayingTheOddsCooldown and HotbarSystem.PlayingTheOddsCooldown > 0 then -- PLAYING THE ODDS
					HotbarSystem.UpdateCooldownSlot(element, HotbarSystem.PlayingTheOddsCooldown, 90)

				-- showing whispering cooldown
				elseif actionId == 743 and HotbarSystem.WhisperingCooldown and HotbarSystem.WhisperingCooldown > 0 then -- WHISPERING
					HotbarSystem.UpdateCooldownSlot(element, HotbarSystem.WhisperingCooldown, SpellsInfo.GetMasterySpellCooldown(actionId))

				-- showing Ethereal Burst Cooldown
				elseif actionId == 708 and HotbarSystem.EtherealBurstCooldown and HotbarSystem.EtherealBurstCooldown > 0 then -- ETHEREAL BURST
					HotbarSystem.UpdateCooldownSlot(element, HotbarSystem.EtherealBurstCooldown, SpellsInfo.GetMasterySpellCooldown(actionId))

				-- showing rejuveneate Cooldown
				elseif actionId == 719 and HotbarSystem.RejuvenateCooldown and HotbarSystem.RejuvenateCooldown > 0 then -- REJUVENATE
					HotbarSystem.UpdateCooldownSlot(element, HotbarSystem.RejuvenateCooldown, SpellsInfo.GetMasterySpellCooldown(actionId))

				else -- remove the remaining cooldown mask
					HotbarSystem.DestroyCooldown(element)
				end

				-- updating the slot based on availability
				pcall(HotbarSystem.UpdateSpellSlot, {element, actionId})

			-- is this a macro?
			elseif HotbarSystem.IsHotbarMacro(actionType) then
				
				-- get an updated ID
				local macroIndex = MacroSystemGetMacroIndexById(actionId)
				
				-- is the macro in the update list?
				if HotbarSystem.MacroToUpdate[actionId] then
					
					-- if macroIndex is invalid then the macro was deleted
					if not IsValidID(macroIndex) then
					
						-- clearing the slot
						HotbarSystem.ClearActionIcon(element, hotbarId, itemIndex, subIndex, true)
						HotbarClearItem(hotbarId, itemIndex)
				
					else -- the macro is the same, we check if the icon is changed

						-- get the macro icon ID
						local macroIconId = UserActionGetIconId(SystemData.MacroSystem.STATIC_MACRO_ID, macroIndex, 0)

						-- update the slot 
						HotbarSystem.UpdateActionButton(hotbarId, itemIndex, subIndex, element, actionType, actionId, macroIconId, false)
					end

					-- remove the macro from the update list
					HotbarSystem.MacroToUpdate[actionId] = nil
				end

			-- bod request/bribe
			elseif actionId == 5117 or actionId == 5118 then
				
				-- disable the alert if the element is not highlighted
				WindowSetShowing(element.."Alert", HotbarSystem.GlowingItems[element] ~= nil)

				-- make sure we have a target id and the target is a bod dealer
				if IsValidID(TargetWindow.TargetId) and IsBodDealer(TargetWindow.TargetId) then

					-- enable the button
					WindowSetShowing(element.."Disabled", false)
					ButtonSetDisabledFlag(element, false)

				else
					-- disable the button
					WindowSetShowing(element.."Disabled", true)
					ButtonSetDisabledFlag(element, true)
				end

			elseif (actionType == SystemData.UserAction.TYPE_USE_OBJECTTYPE and (objectType == 3617 or objectType == 3817) and HotbarSystem.BandageDelayTime > 0) or -- BANDAGES
					 actionType == SystemData.UserAction.TYPE_BANDAGE_SELF or
					 actionType == SystemData.UserAction.TYPE_BANDAGE_SELECTED_TARGET
			then 

				-- update quantity
				HotbarSystem.UpdateQuantityNChargesForSlot(element, actionId, actionType, objectID, objectType, hue)
				
				-- showing the cooldown
				HotbarSystem.UpdateCooldownSlot(element, HotbarSystem.BandageDelayTime, 7, nil, forceBandageReset)

			-- healing potion
			elseif actionType == SystemData.UserAction.TYPE_USE_OBJECTTYPE and objectType == 3852 and HotbarSystem.HealPotDelayTime > 0  then
				
				-- update quantity
				HotbarSystem.UpdateQuantityNChargesForSlot(element, actionId, actionType, objectID, objectType, hue)

				-- showing the cooldown
				HotbarSystem.UpdateCooldownSlot(element, HotbarSystem.HealPotDelayTime, 10)

			-- enchanted apple
			elseif actionType == SystemData.UserAction.TYPE_USE_OBJECTTYPE and objectType == 12248 and hue == 1160 and HotbarSystem.AppleDelayTime > 0 then
				
				-- update quantity
				HotbarSystem.UpdateQuantityNChargesForSlot(element, actionId, actionType, objectID, objectType, hue)

				-- showing the cooldown
				HotbarSystem.UpdateCooldownSlot(element, HotbarSystem.AppleDelayTime, 30)

			-- grapes of wrash
			elseif actionType == SystemData.UserAction.TYPE_USE_OBJECTTYPE and objectType == 12247 and hue == 1154 and HotbarSystem.GrapeDelayTime > 0 then
				
				-- update quantity
				HotbarSystem.UpdateQuantityNChargesForSlot(element, actionId, actionType, objectID, objectType, hue)

				-- showing the cooldown
				HotbarSystem.UpdateCooldownSlot(element, HotbarSystem.GrapeDelayTime, 120)

			-- talismans
			elseif actionType == SystemData.UserAction.TYPE_USE_OBJECTTYPE and (objectType == 12120 or objectType == 12121 or objectType == 12122 or objectType == 12123 or objectType == 4246) then
			
				-- do we need to show the charges?
				if Interface.LoadSetting( element .. "EnableCharges", false) then
					HotbarSystem.UpdateQuantityNChargesForSlot(element, actionId, actionType, objectID, objectType, hue)
				end

				-- getting the talisman timer for this slot if we have one saved (this will work as backup if we fail to get the properties)
				local time = HotbarSystem.TalismanTimers[element]

				-- charge time initialize
				local chargeTime = time

				-- getting the talisman property
				local props = Interface.GetItemPropertiesData( objectID, "talisman properties scan for hotbar slot update" )

				-- making sure we have the props
				if props  then

					-- splitting the properties array
					local params = ItemProperties.BuildParamsArray( props )
					
					-- parsing the properties TID
					for j, prop in pairsByIndex(props.PropertiesTids) do

						-- is this a lifespan TID?
						if ItemPropertiesInfo.LifeSpanTid[prop] then
							
							-- getting the token string ID
							local token = ItemPropertiesInfo.LifeSpanTid[prop]

							-- getting the time value
							local val = tostring(params[prop][token])
							
							-- converting the charge time to number
							chargeTime = tonumber(val)
							break
						end
					end
				end
				
				-- the time is now the remaining time we got from properties
				time = chargeTime

				-- do we have a timer?
				if time then

					-- updating the time in the array for backup
					HotbarSystem.TalismanTimers[element] = time

					-- if the time is less than 0, we remove the backup
					if time <= 0 then
						HotbarSystem.TalismanTimers[element] = nil
						time = nil
					end
				end

				-- do we have a time?
				if not IsValidID(time) then

					-- removing the cooldown timer if present
					HotbarSystem.UpdateCooldownSlot(element, 0)

					-- the button will be disabled when the player is paralyze except for certain items
					local disabledOnParalyze = IsPlayerParalyzed() and (not IsValidID(Interface.TrapBoxID) or objectID ~= Interface.TrapBoxID ) and not (HotbarSystem.ItemsEnabledOnParalyze[objectType])

					-- the button get disabled if the player doesn't have the item, is dead or is paralyzed
					local buttonEnabled = (IsValidID(objectID) and DoesPlayerHaveItem(objectID)) and not Interface.IsPlayerDead and not disabledOnParalyze

					-- disable the alert if the element is not highlighted
					WindowSetShowing(element.."Alert", HotbarSystem.GlowingItems[element] ~= nil)

					-- remove any timer remained
					LabelSetText(element.."BandageTime", L"")

					-- get the current hotkey
					local key = LabelGetText(element.."Hotkey")

					-- toggle the hotkey for disabled items and items without an hotkey
					WindowSetShowing(element .. "Hotkey", buttonEnabled and IsValidWString(key))
					WindowSetShowing(element.."HotkeyBackground", buttonEnabled and IsValidWString(key))

					-- updating the button status
					WindowSetShowing(element.."Disabled", not buttonEnabled)
					ButtonSetDisabledFlag(element, not buttonEnabled)

				else -- we have a timer

					-- converting to a wstring adding h/m/s based on the time remaining
					local timer = StringUtils.CountDownSeconds(math.floor(time))
					
					-- adding the cooldown
					HotbarSystem.UpdateCooldownSlot(element, time, 1800, timer)
				end

			-- is this a boat command?
			elseif ActionsWindow.IsABoatCommand(actionId, actionType) then

				-- determine if the action is enabled
				local buttonEnabled = Actions.IsActionEnabled(actionId, actionType, hotbarId, itemIndex)

				-- disable the alert if the element is not highlighted
				WindowSetShowing(element .. "Alert", HotbarSystem.GlowingItems[element] ~= nil)

				-- toggle the hotkey for disabled items and items without an hotkey
				WindowSetShowing(element .. "Hotkey", buttonEnabled and IsValidWString(key))
				WindowSetShowing(element .. "HotkeyBackground", buttonEnabled and IsValidWString(key))

				-- updating the button status
				WindowSetShowing(element .. "Disabled", Interface.IsPilotingAShip or not buttonEnabled)
				ButtonSetDisabledFlag(element, Interface.IsPilotingAShip or not buttonEnabled)

			-- all the other actions
			elseif ActionsWindow.isAction(actionType) then

				-- determine if the action is enabled
				local buttonEnabled = Actions.IsActionEnabled(actionId, actionType, hotbarId, itemIndex)

				-- get the current hotkey
				local key = LabelGetText(element .. "Hotkey")

				-- toggle the hotkey for disabled items and items without an hotkey
				WindowSetShowing(element .. "Hotkey", buttonEnabled and IsValidWString(key))
				WindowSetShowing(element .. "HotkeyBackground", buttonEnabled and IsValidWString(key))

				-- updating the button status
				WindowSetShowing(element .. "Disabled", not buttonEnabled)
				ButtonSetDisabledFlag(element, not buttonEnabled)

			-- does the player still has the item?
			elseif HotbarSystem.IsHotbarItem(actionType) then
				
				-- the button will be disabled when the player is paralyze except for certain items
				local disabledOnParalyze = IsPlayerParalyzed() and (not IsValidID(Interface.TrapBoxID) or objectID ~= Interface.TrapBoxID ) and not (HotbarSystem.ItemsEnabledOnParalyze[objectType])

				-- the button get disabled if the player doesn't have the item, is dead or is paralyzed
				local buttonEnabled = (IsValidID(objectID) and DoesPlayerHaveItem(objectID)) and not Interface.IsPlayerDead and not disabledOnParalyze

				-- is a valid object and the player still has it?
				if IsValidID(objectID) and (DoesPlayerHaveItem(objectID) or objectID == SystemData.DragItem.itemId) then

					-- updating the icon (so that colors and all will be correct)
					EquipmentData.UpdateItemIcon(element.."SquareIcon", objectID)

				else -- update the icon with what we know					
					EquipmentData.DrawObjectIconAtWindowDimensions(objectType, hue, element.."SquareIcon")
				end
				
				local showAlert, alertAlpha = HotbarSystem.UpdateQuantityNChargesForSlot(element, actionId, actionType, objectID, objectType, hue)

				-- is the alert enabled?
				if not Interface.LoadSetting( element .. "EnableAlert", false) then

					-- disable the alert if the element is not highlighted
					WindowSetShowing(element.."Alert", HotbarSystem.GlowingItems[element] ~= nil)

				else -- alert enabled
					
					-- showing alert
					WindowSetShowing(element.."Alert", HotbarSystem.GlowingItems[element] ~= nil or showAlert)

					-- setting the alpha for the alert
					WindowSetAlpha(element.."Alert", alertAlpha)
				end

				-- remove any timer remained
				LabelSetText(element.."BandageTime", L"")

				-- get the current hotkey
				local key = LabelGetText(element.."Hotkey")

				-- toggle the hotkey for disabled items and items without an hotkey
				WindowSetShowing(element .. "Hotkey", buttonEnabled and IsValidWString(key))
				WindowSetShowing(element.."HotkeyBackground", buttonEnabled and IsValidWString(key))

				-- updating the button status
				WindowSetShowing(element.."Disabled", not buttonEnabled)
				ButtonSetDisabledFlag(element, not buttonEnabled)
			end
		end
	end
end

function HotbarSystem.HandleMountsBlockbarVisibility()

	-- is the interface fully started?
	if not Interface.started or not Interface.MountBlockbar then
		return
	end

	-- mount blockbar window name
	local mountBlockbar = "Hotbar" .. Interface.MountBlockbar

	-- toggle the mount blockbar visibility with the mount list window
	if DoesWindowExist(mountBlockbar) and DoesWindowExist("MountsListWindow") then
		WindowSetShowing(mountBlockbar, WindowGetShowing("MountsListWindow"))
	end
end

function HotbarSystem.HandleDragGlowing(element)

	-- getting the dragged item/action id
	local dragId = SystemData.DragItem.actionId

	-- if it's not registered in the dragItem, we get the last drag (if available)
	if not IsValidID(dragId) and ActionsWindow.LastDrag then
		dragId = ActionsWindow.LastDrag
	end
	
	-- getting the params of the glowing item
	local param = HotbarSystem.GlowingItems[element]

	-- if we do have the params, we process them
	if param then
		
		-- is the one we need to terminate?
		if param.dragAction and param.dragAction == HotbarSystem.TerminateGlow then
			HotbarSystem.StopGlowSlot(element)
			return
		end

		-- as this slot being glowing for too long?
		if (Interface.TimeSinceLogin > param.timer) then
			HotbarSystem.StopGlowSlot(element)
		end
	end
end

function HotbarSystem.UpdateSlotTargetMouseOver(hotbarId, itemIndex, subIndex, element)

	-- we got compressed parameters instead of the element so we have to decompress it
	if type(hotbarId) == "table" then
		element = hotbarId[4]
		subIndex = hotbarId[3]
		itemIndex = hotbarId[2]
		hotbarId = hotbarId[1]
	end

	-- make sure the hotbar exist and the id is correct
	if hotbarId ~= SystemData.MacroSystem.STATIC_MACRO_ID and not Hotbar.DoesHotbarExist(hotbarId, true) then
		return
	end

	-- does the element exist? (if it's a macro it doesn't exist)
	if hotbarId ~= SystemData.MacroSystem.STATIC_MACRO_ID and not DoesWindowExist(element) then
		return
	end

	-- is this action using target mouse over?
	if HotbarSystem.TargetMouseOver and HotbarSystem.TargetMouseOver[element] then

		-- does the slot have something inside? (only for hotbars)
		if hotbarId ~= SystemData.MacroSystem.STATIC_MACRO_ID and not HotbarHasItem(hotbarId, itemIndex) then

			-- if not, why does it have a target mouse over? better unregister it...
			HotbarSystem.UpdateTargetMouseOver(hotbarId, itemIndex, subIndex, nil)
		end

		-- does this action requires a target?
		if UserActionHasTargetType(hotbarId, itemIndex, subIndex) then
					
			-- do we have a current hover for item properties?
			local mouseOverTarget = WindowData.ItemProperties.CurrentHover

			-- do we have a current hover for the hoverbars?
			if mouseOverTarget == 0 then

				-- is the mouse over an hoverbar?
				if IsValidID(OverheadText.mouseOverId) then
					mouseOverTarget = OverheadText.mouseOverId

				-- is the mouse over a boss bar?
				elseif IsValidID(BossBar.MouseOverId) then
					mouseOverTarget = BossBar.MouseOverId

				-- healthbar mouse over
				elseif IsValidID(MobileHealthBar.mouseOverId) then
					mouseOverTarget = MobileHealthBar.mouseOverId
				end
			end

			-- make sure the mouse over ID is not nil
			if not mouseOverTarget then 
				mouseOverTarget = 0
			end

			-- update the target with the mouse over id
			UserActionSetTargetId(hotbarId, itemIndex, subIndex, mouseOverTarget)

		else -- if not, why does it have a target mouse over? better unregister it...
			HotbarSystem.UpdateTargetMouseOver(hotbarId, itemIndex, subIndex, nil)
		end

		-- updating the target
		HotbarSystem.UpdateTargetTypeIndicator(element, hotbarId, itemIndex, subIndex)
	end
end

function HotbarSystem.HandleUpdateTargetMouseOver()
	
	-- is there any target mouse over active?
	if HotbarSystem.TargetMouseOver then
		
		-- scanning all the elements with mouse over active
		for element, param in pairs(HotbarSystem.TargetMouseOver) do

			-- making sure it's a macro
			if param.SubIndex ~= 0 then

				-- updating the target
				pcall(HotbarSystem.UpdateSlotTargetMouseOver, {param.HotbarId, param.ItemIndex, param.SubIndex, element})
			end
		end
	end
end


function HotbarSystem.InitializeTargetMouseOver()
	
	-- is the interface started?
	if not Interface.started then
		return
	end

	-- is there any target mouse over active?
	if HotbarSystem.TargetMouseOver then
		
		-- scanning all the elements with mouse over active
		for element, param in pairs(HotbarSystem.TargetMouseOver) do

			-- making sure it's a macro
			if param.SubIndex == 0 then

				-- updating the target
				pcall(HotbarSystem.UpdateSlotTargetMouseOver, {param.HotbarId, param.ItemIndex, param.SubIndex, element})
			end
		end
	end

	-- mark the targets as initialized
	HotbarSystem.TargetInitialized = true
end

function HotbarSystem.HandleUpdatehotbarsKeybinding()
	
	-- parsing all hotbars
	for index, hotbarId in pairs(SystemData.Hotbar.HotbarIds) do
	
		-- does the hotbar exist?
		if not Hotbar.DoesHotbarExist(hotbarId, true) then
			continue
		end

		-- is the hotbar closed?
		if Hotbar.IsShrunken(hotbarId, false) then		
			continue
		end

		-- parsing all slots
		for slot = 1, Hotbar.NUM_BUTTONS do
			HotbarSystem.UpdateBindingToSlot(hotbarId, slot)
		end
	end
end

function HotbarSystem.UpdateWeaponSpecialSlot(element, id)

	-- we got compressed parameters instead of the element so we have to decompress it
	if type(element) == "table" then
		id = element[2]
		element = element[1]
	end

	-- making sure the slot exist
	if not DoesWindowExist(element) then
		return
	end

	-- getting the correct ability ID
	local abilityId = EquipmentData.GetWeaponAbilityId(id)

	-- determining if the ability can be used, and if not the reason why
	local canUse, reason = AbilitiesInfo.AbilityEnabled(abilityId) 

	-- disabling/enabling slot depending on if the ability can be used
	WindowSetShowing(element.."Disabled", not canUse)
	ButtonSetDisabledFlag(element, not canUse)

	-- the alert is not used for weapon abilities, so we use it only to highlight duplicates
	WindowSetShowing(element.."Alert", HotbarSystem.GlowingItems[element] ~= nil)

	-- if the ability can't be used because of the lack of mana we color the disabled window in blue
	if not canUse and reason == AbilitiesInfo.DisabledReason.LOW_MANA then
		WindowSetTintColor(element.."Disabled", 0, 0, 255)
	
	else -- reset to the default white color
		WindowSetTintColor(element.."Disabled", 255,255,255)
	end
end

function HotbarSystem.UpdateSpellSlot(element, id)

	-- we got compressed parameters instead of the element so we have to decompress it
	if type(element) == "table" then
		id = element[2]
		element = element[1]
	end

	-- making sure the slot exist
	if not DoesWindowExist(element) then
		return
	end

	-- determining if the spell can be used, and if not the reason why
	local canUse, reason = SpellsInfo.SpellEnabled(id) 

	-- disabling/enabling slot depending on if the spell can be used
	WindowSetShowing(element.."Disabled", not canUse)
	ButtonSetDisabledFlag(element, not canUse)

	-- the alert is not used for spells, so we use it only to highlight duplicates
	WindowSetShowing(element.."Alert", HotbarSystem.GlowingItems[element] ~= nil)

	-- if the ability can't be used because of the lack of mana we color the disabled window in blue
	if not canUse and reason == SpellsInfo.DisabledReason.LOW_MANA then
		WindowSetTintColor(element.."Disabled", 0, 0, 255)
	
	else -- reset to the default white color
		WindowSetTintColor(element.."Disabled", 255,255,255)
	end
end

function HotbarSystem.UpdateMacroReferenceSlot(macroIndex)
	local id = WindowData.UpdateInstanceId

	-- do we have a valid id as parameter?
	if IsValidID(macroIndex) then
		id = macroIndex
	end
	
	-- is the array empty?
	if not HotbarSystem.MacroToUpdate then
		HotbarSystem.MacroToUpdate = {}
	end

	-- adding the ID to the update queue
	HotbarSystem.MacroToUpdate[id] = true
end

function HotbarSystem.CreateUserActionContextMenuOptions(hotbarId, itemIndex, subIndex, slotWindow)

	-- make sure the hotbar and slot exist
	if (hotbarId ~= SystemData.MacroSystem.STATIC_MACRO_ID and not Hotbar.DoesHotbarExist(hotbarId, true)) or not IsValidID(itemIndex) or not DoesWindowExist(slotWindow) then
		return
	end

	-- getting the current action type
	local actionType = UserActionGetType(hotbarId, itemIndex, subIndex)

	-- getting the current action ID
	local actionId = UserActionGetId(hotbarId, itemIndex, subIndex)

	-- preparing the params array
	local param = {HotbarId = hotbarId, ItemIndex = itemIndex, SubIndex = subIndex, SlotWindow = slotWindow, ActionId = actionId, ActionType = actionType}
	
	-- items context action
	if HotbarSystem.IsHotbarItem(actionType) and subIndex == 0 then
		
		-- disable quantity alert
		if Interface.LoadSetting( slotWindow .. "EnableAlert", false) then
			ContextMenu.CreateLuaContextMenuItem({tid = 1155010, returnCode = HotbarSystem.ContextReturnCodes.TOGGLE_ALERT, param = param})
			
		else -- enable quantity alert
			ContextMenu.CreateLuaContextMenuItem({tid = 1155009, returnCode = HotbarSystem.ContextReturnCodes.TOGGLE_ALERT, param = param})
		end
		
		-- disable charges alert
		if Interface.LoadSetting( slotWindow .. "EnableCharges", false) then
			ContextMenu.CreateLuaContextMenuItem({tid = 269, returnCode = HotbarSystem.ContextReturnCodes.TOGGLE_CHARGES, param = param})
			
		else -- enable charges alert
			ContextMenu.CreateLuaContextMenuItem({tid = 268, returnCode = HotbarSystem.ContextReturnCodes.TOGGLE_CHARGES, param = param})
		end

		-- get the object type and hue for the item in the slot
		local objectType = UserActionUseObjectTypeGetObjectTypeHue(actionId)

		-- is this a spell scroll?
		if SpellsInfo.ScrollsToSpellID[objectType] then

			-- get the scroll's spell ID
			local spellId = SpellsInfo.ScrollsToSpellID[objectType]

			if	spellId == 56  or -- polymorph
				spellId == 112 or -- summon familiar
				spellId == 681 or -- enchant
				spellId == 686 or -- spell trigger
				spellId == 744	  -- combat training
			then 
		
				-- creating the context submenu for the spell
				Spellbook.CreateSpellContext(spellId, param, true)
			end
		end
	end

	-- is this the tracking skill?
	if actionType == SystemData.UserAction.TYPE_SKILL and actionId == SkillsWindow.SkillsID.TRACKING then
		
		-- get the current default selection
		local currentSelection = Interface.ForceTracking

		-- filling the sub-menu
		local subMenu = 
		{
			{ tid = 1078861, returnCode = HotbarSystem.ContextReturnCodes.TRACKING_SHOWGUMP, param = param, pressed = currentSelection == 0 },
			{ tid = 1018087, returnCode = HotbarSystem.ContextReturnCodes.TRACKING_ANIMALS, param = param, pressed = currentSelection == 1 },
			{ tid = 1018088, returnCode = HotbarSystem.ContextReturnCodes.TRACKING_MONSTERS, param = param, pressed = currentSelection == 2 },
			{ tid = 1018089, returnCode = HotbarSystem.ContextReturnCodes.TRACKING_NPCS, param = param, pressed = currentSelection == 3 },
			{ tid = 1018090, returnCode = HotbarSystem.ContextReturnCodes.TRACKING_PLAYERS, param = param, pressed = currentSelection == 4 },
		}

		ContextMenu.CreateLuaContextMenuItem({ tid = 578, subMenuOptions = subMenu })
	end

	-- smart next, smart nearest, target severely injured mobile
	if (actionId == 5201 or actionId == 5202 or actionId == 5204) then
	
		-- getting the current setting
		local notoString = UserActionSpeechGetText(hotbarId, itemIndex, subIndex)

		-- cleaning the extra code we don't need (based on the action)
		if actionId == 5201 then
			notoString = wstring.gsub(notoString, L"script Actions.NextTarget[(]", L"")

		elseif actionId == 5202 then
			notoString = wstring.gsub(notoString, L"script Actions.NearTarget[(]", L"")
			
		elseif actionId == 5204 then
			notoString = wstring.gsub(notoString, L"script Actions.InjuredMobile[(]\"", L"")
		end

		notoString = wstring.gsub(notoString, L"[)]", L"")
		notoString = wstring.gsub(towstring(notoString), L"\"", L"")

		-- convert to string
		notoString = tostring(notoString)
		
		-- make sure the noto string is formatted correctly
		notoString = Actions.VerifyNotorietyString(notoString)

		-- add the noto string to the parameters
		param["notoString"] = notoString
		
		-- filling the sub-menu
		local subMenu = 
		{
			{ tid = 1154822, returnCode = HotbarSystem.ContextReturnCodes.TARGETFILTER_INNOCENT, param = param, pressed = Actions.IsNotorietyEnabled(notoString, NameColor.NotorietyFilters.INNOCENT) },
			{ tid = 1078866, returnCode = HotbarSystem.ContextReturnCodes.TARGETFILTER_FRIEND, param = param, pressed = Actions.IsNotorietyEnabled(notoString, NameColor.NotorietyFilters.FRIEND) },
			{ tid = 1154823, returnCode = HotbarSystem.ContextReturnCodes.TARGETFILTER_ATTACKABLE, param = param, pressed = Actions.IsNotorietyEnabled(notoString, NameColor.NotorietyFilters.CANATTACK) },
			{ tid = 1153802, returnCode = HotbarSystem.ContextReturnCodes.TARGETFILTER_CRIMINAL, param = param, pressed = Actions.IsNotorietyEnabled(notoString, NameColor.NotorietyFilters.CRIMINAL) },
			{ tid = 1095164, returnCode = HotbarSystem.ContextReturnCodes.TARGETFILTER_ENEMY, param = param, pressed = Actions.IsNotorietyEnabled(notoString, NameColor.NotorietyFilters.ENEMY) },
			{ tid = 1154824, returnCode = HotbarSystem.ContextReturnCodes.TARGETFILTER_MURDER, param = param, pressed = Actions.IsNotorietyEnabled(notoString, NameColor.NotorietyFilters.MURDERER) },
			{ tid = 3000509, returnCode = HotbarSystem.ContextReturnCodes.TARGETFILTER_INVULNERABLE, param = param, pressed = Actions.IsNotorietyEnabled(notoString, NameColor.NotorietyFilters.INVULNERABLE) },
			ContextMenu.EmptyLine,
			{ tid = 550,	 returnCode = HotbarSystem.ContextReturnCodes.TARGETFILTER_HONORED, param = param, pressed = Actions.IsNotorietyEnabled(notoString, NameColor.NotorietyFilters.HONORED) },
			{ tid = 1154825, returnCode = HotbarSystem.ContextReturnCodes.TARGETFILTER_NEUTRALS, param = param, pressed = Actions.IsNotorietyEnabled(notoString, NameColor.NotorietyFilters.NEUTRALS) },
			{ tid = 1154826, returnCode = HotbarSystem.ContextReturnCodes.TARGETFILTER_SUMMONS, param = param, pressed = Actions.IsNotorietyEnabled(notoString, NameColor.NotorietyFilters.SUMMONS) },
			{ tid = 432,	 returnCode = HotbarSystem.ContextReturnCodes.TARGETFILTER_BOSSES, param = param, pressed = Actions.IsNotorietyEnabled(notoString, NameColor.NotorietyFilters.BOSSES) },
			{ tid = 440,	 returnCode = HotbarSystem.ContextReturnCodes.TARGETFILTER_PLAYERS, param = param, pressed = Actions.IsNotorietyEnabled(notoString, NameColor.NotorietyFilters.PLAYERS) },
			{ tid = 439,	 returnCode = HotbarSystem.ContextReturnCodes.TARGETFILTER_PETS, param = param, pressed = Actions.IsNotorietyEnabled(notoString, NameColor.NotorietyFilters.PETS) },
			ContextMenu.EmptyLine,
			{ tid = 551,	 returnCode = HotbarSystem.ContextReturnCodes.TARGETFILTER_POISONEDONLY, param = param, pressed = Actions.IsNotorietyEnabled(notoString, NameColor.NotorietyFilters.POISONEDONLY) },
			{ tid = 552,	 returnCode = HotbarSystem.ContextReturnCodes.TARGETFILTER_IGNOREMORTALSTRIKED, param = param, pressed = Actions.IsNotorietyEnabled(notoString, NameColor.NotorietyFilters.IGNOREMORTALSTRIKED) },
		}

		ContextMenu.CreateLuaContextMenuItem({tid = 3000173, subMenuOptions = subMenu}) -- filters
	end

	-- nearest corpse
	if actionId == 5210 then
	
		-- getting the current setting
		local flagsString = UserActionSpeechGetText(hotbarId, itemIndex, subIndex)

		-- cleaning the extra code we don't need
		flagsString = wstring.gsub(flagsString, L"script Actions.TargetClosestCorpse[(]", L"")

		flagsString = wstring.gsub(flagsString, L"[)]", L"")
		flagsString = wstring.gsub(towstring(flagsString), L"\"", L"")

		-- convert to string
		flagsString = tostring(flagsString)
		
		-- make sure the flags string is formatted correctly
		flagsString = Actions.VerifyClosestCorpseFlags(flagsString)
		
		-- add the flags string to the parameters
		param["flagsString"] = flagsString
		
		-- filling the sub-menu
		local subMenu = 
		{
			{ tid = 590, returnCode = HotbarSystem.ContextReturnCodes.TARGETCORPSE_UNLOOTED, param = param, pressed = Actions.IsFlagEnabled(flagsString, Actions.ClosestCorpseFlags.UNLOOTED) },
			{ tid = 591, returnCode = HotbarSystem.ContextReturnCodes.TARGETCORPSE_LOOTRANGE, param = param, pressed = Actions.IsFlagEnabled(flagsString, Actions.ClosestCorpseFlags.LOOTRANGE) },
			{ tid = 592, returnCode = HotbarSystem.ContextReturnCodes.TARGETCORPSE_REANIMABLE, param = param, pressed = Actions.IsFlagEnabled(flagsString, Actions.ClosestCorpseFlags.REANIMABLE) },
		}

		ContextMenu.CreateLuaContextMenuItem({tid = 3000173, subMenuOptions = subMenu}) -- filters
	end

	-- security setting for house items
	if (actionId == 5751) then

		-- getting the current setting
		local speech = UserActionSpeechGetText(hotbarId, itemIndex, subIndex)

		-- cleaning the extra code we don't need
		speech = wstring.gsub(speech, L"script Actions.ChangeSecurity[(]\"", L"")
		speech = wstring.gsub(speech, L"\"[)]", L"")

		-- filling the sub-menu
		local subMenu = {
		{tid = 1061277, returnCode = HotbarSystem.ContextReturnCodes.SECURITY_OWNER, param = param, pressed = speech == L"owner" },
		{tid = 1061278, returnCode = HotbarSystem.ContextReturnCodes.SECURITY_COOWNER, param = param, pressed = speech == L"coowner" },
		{tid = 1061279, returnCode = HotbarSystem.ContextReturnCodes.SECURITY_FRIEND, param = param, pressed = speech == L"friend" },
		{tid = 1063455, returnCode = HotbarSystem.ContextReturnCodes.SECURITY_GUILD, param = param, pressed = speech == L"guild" },
		{tid = 1061626, returnCode = HotbarSystem.ContextReturnCodes.SECURITY_ANYONE, param = param, pressed = speech == L"anyone" } }

		ContextMenu.CreateLuaContextMenuItem({tid = 20, subMenuOptions = subMenu})
	end
	
	-- set mobile bar filter
	if (actionId == 5757) then

		-- getting the current setting
		local speech = UserActionSpeechGetText(hotbarId, itemIndex, subIndex)

		-- cleaning the extra code we don't need
		speech = wstring.gsub(speech, L"script MobileBarsDockspot.FilterListSelectByName[(]L\"", L"")
		speech = wstring.gsub(speech, L"\"[)]", L"")

		-- get the correct ID for the filter
		local id = MobileBarsDockspot.GetFilterIDByName(speech)

		-- initialize the sub-menu
		local subMenu = {}

		-- scan all the filters
		for name, data in pairs(MobileBarsDockspot.SavedFilters) do

			-- copying the params
			local currParam = table.copy(param)

			-- store the filter name
			currParam.filterName = name

			-- add the filter to the sub-menu
			table.insert(subMenu, {str = FormatProperly(name), returnCode = HotbarSystem.ContextReturnCodes.SETDOCKSPOTFILTER, param = currParam, pressed = data.id == id })
		end

		ContextMenu.CreateLuaContextMenuItem({tid = 1156592, subMenuOptions = subMenu}) -- Filter
	end
	
	-- if is not a blockbar, enable the clear item option
	if not Interface.LoadSetting("Hotbar" .. hotbarId .. "_IsBlockbar", false) then
		ContextMenu.CreateLuaContextMenuItem({tid = HotbarSystem.TID_CLEAR_ITEM, returnCode = HotbarSystem.ContextReturnCodes.CLEAR_ITEM, param = param})
	end
	
	-- target settings
	if (( UserActionHasTargetType(hotbarId, itemIndex, subIndex) ) and ( SystemData.Settings.GameOptions.legacyTargeting == false )) then

		-- get the target type limitation
		local noSelf, cursorOnly = GetActionTargetTypes(actionId, actionType)

		-- getting the target type actually set
		local targetType = UserActionGetTargetType(hotbarId, itemIndex, subIndex, slotWindow)

		-- initialize pressed flags array
		local pressed = { false, false, false, false, false }

		-- highlight the flag for the target type in use
		pressed[targetType+1] = true
		
		local subMenu = {}

		-- filling the menu only with target cursor
		if (cursorOnly) then
			subMenu = { {tid = HotbarSystem.TID_CURSOR, returnCode = HotbarSystem.ContextReturnCodes.TARGET_CURSOR, param = param, pressed = pressed[1+SystemData.Hotbar.TargetType.TARGETTYPE_CURSOR] } }
			
		-- filling the sub menu with all but target self
		elseif (noSelf) then
			subMenu =	{
						{tid = HotbarSystem.TID_CURSOR, returnCode = HotbarSystem.ContextReturnCodes.TARGET_CURSOR, param = param, pressed = pressed[1+SystemData.Hotbar.TargetType.TARGETTYPE_CURSOR] },
						{tid = HotbarSystem.TID_OBJECT_ID, returnCode = HotbarSystem.ContextReturnCodes.TARGET_OBJECT_ID, param = param, pressed = pressed[1+SystemData.Hotbar.TargetType.TARGETTYPE_OBJECT_ID] },
						{tid = HotbarSystem.TID_CURRENT, returnCode = HotbarSystem.ContextReturnCodes.TARGET_CURRENT, param = param, pressed = pressed[1+SystemData.Hotbar.TargetType.TARGETTYPE_CURRENT] },
						{str = GetStringFromTid(280), returnCode = HotbarSystem.ContextReturnCodes.TARGET_MOUSEOVER, param = param, pressed = pressed[1+SystemData.Hotbar.TargetType.TARGETTYPE_MOUSEOVER] } 
						}

		else -- filling the sub menu array with all targets
			subMenu =	{
						{tid = HotbarSystem.TID_SELF, returnCode = HotbarSystem.ContextReturnCodes.TARGET_SELF, param  =param, pressed = pressed[1+SystemData.Hotbar.TargetType.TARGETTYPE_SELF] },
						{tid = HotbarSystem.TID_CURSOR, returnCode = HotbarSystem.ContextReturnCodes.TARGET_CURSOR, param = param, pressed = pressed[1+SystemData.Hotbar.TargetType.TARGETTYPE_CURSOR] },
						{tid = HotbarSystem.TID_OBJECT_ID, returnCode = HotbarSystem.ContextReturnCodes.TARGET_OBJECT_ID, param = param, pressed = pressed[1+SystemData.Hotbar.TargetType.TARGETTYPE_OBJECT_ID] },
						{tid = HotbarSystem.TID_CURRENT, returnCode = HotbarSystem.ContextReturnCodes.TARGET_CURRENT, param = param, pressed = pressed[1+SystemData.Hotbar.TargetType.TARGETTYPE_CURRENT] },
						{str = GetStringFromTid(280), returnCode = HotbarSystem.ContextReturnCodes.TARGET_MOUSEOVER, param = param, pressed = pressed[1+SystemData.Hotbar.TargetType.TARGETTYPE_MOUSEOVER] } 
						}
		end

		ContextMenu.CreateLuaContextMenuItem({tid = HotbarSystem.TID_TARGET, subMenuOptions = subMenu}) 
	end	
	
	-- if it's a macro we add edit and repeat options
	if HotbarSystem.IsHotbarMacro(actionType) then

		-- getting the real macro id (not the one saved on the hotbar that could be wrong since it's the one the macro had when was dropped)
		local macroIndex = MacroSystemGetMacroIndexById(actionId)
		
		-- copy the current parameters and make new ones for the macro editing
		local macroParam = table.copy(param)

		-- macro editor settings
		macroParam.HotbarId = SystemData.MacroSystem.STATIC_MACRO_ID
		macroParam.ItemIndex = macroIndex
		macroParam.ActionId = macroIndex
		
		-- edit macro
		ContextMenu.CreateLuaContextMenuItem({tid = HotbarSystem.TID_EDIT_ITEM, returnCode = HotbarSystem.ContextReturnCodes.EDIT_ITEM, param = macroParam})
		
		-- repeat
		if not UserActionMacroGetRepeatEnabled(param.HotbarId, param.ItemIndex) then
			ContextMenu.CreateLuaContextMenuItem({tid = HotbarSystem.TID_ENABLE_REPEAT, returnCode = HotbarSystem.ContextReturnCodes.ENABLE_REPEAT, param = macroParam})

		else -- disable repeat
			ContextMenu.CreateLuaContextMenuItem({tid = HotbarSystem.TID_DISABLE_REPEAT, returnCode = HotbarSystem.ContextReturnCodes.DISABLE_REPEAT, param = macroParam })
		end
	end		
	
	-- spells specific context for auto-selection
	if	actionType == SystemData.UserAction.TYPE_SPELL and
		actionId == 56  or -- polymorph
		actionId == 112 or -- summon familiar
		actionId == 503 or -- animal form
		actionId == 681 or -- enchant
		actionId == 686 or -- spell trigger
		actionId == 744	   -- combat training
	then 
		
		-- creating the context submenu for the spell
		Spellbook.CreateSpellContext(actionId, param, true)
	end
	
	-- actions specific context
	if ActionsWindow.isAction(actionType) then
		
		local actionData = ActionsWindow.ActionData[actionId]

		-- if the action has an edit window then it can be edited
		if (actionData and actionData.editWindow) then

			ContextMenu.CreateLuaContextMenuItem({tid = HotbarSystem.TID_EDIT_ITEM, returnCode = HotbarSystem.ContextReturnCodes.EDIT_ITEM, param = param})
		end

		-- mass organizer
		if (actionId == 5732) then

			-- initializing sub menu array
			local subMenu = {}

			-- listing all the organizers
			for i = 1, Organizer.Organizers do

				-- organizer: number
				local name = ReplaceTokens(GetStringFromTid(1155442), {towstring( i ) } )

				-- organizer name
				if (Organizer.Organizers_Desc[i] ~= L"") then
					name = Organizer.Organizers_Desc[i]
				end

				-- update the params with the agent ID
				param.SelectedAgent = i

				-- sub menu record
				item = {str = name, returnCode = HotbarSystem.ContextReturnCodes.AGENT_ORGANIZER, param = table.copy(param), pressed = Organizer.ActiveOrganizer == i }
				table.insert(subMenu, item)
			end
					
			ContextMenu.CreateLuaContextMenuItem({tid = 1155130, subMenuOptions = subMenu}) -- Select Organizer
		
		-- undress agent
		elseif (actionId == 5733) then
			
			-- initializing sub menu array
			local subMenu = {}

			-- listing all the undress agents
			for i = 1, Organizer.Undresses do

				-- Undress agent : number
				local name = L"Use Undress " .. i

				-- undress agent name
				if (Organizer.Undresses_Desc[i] ~= L"") then
					name = Organizer.Undresses_Desc[i]
				end

				-- update the params with the agent ID
				param.SelectedAgent = i

				-- sub menu record
				item = {str = name, returnCode = HotbarSystem.ContextReturnCodes.AGENT_UNDRESS, param = table.copy(param), pressed = Organizer.ActiveUndress == i }
				table.insert(subMenu, item)
			end
					
			ContextMenu.CreateLuaContextMenuItem({tid = 1155232, subMenuOptions = subMenu}) -- Select Undress
		end
	end
end

function HotbarSystem.ContextMenuCallback(returnCode,param)
	local bHandled = true
	
	-- change to target self
	if (returnCode == HotbarSystem.ContextReturnCodes.TARGET_SELF) then
		UserActionSetTargetType(param.HotbarId, param.ItemIndex, param.SubIndex, SystemData.Hotbar.TargetType.TARGETTYPE_SELF)
		HotbarSystem.UpdateTargetMouseOver(param.HotbarId, param.ItemIndex, param.SubIndex, nil)
		HotbarSystem.UpdateTargetTypeIndicator(param.SlotWindow, param.HotbarId, param.ItemIndex, param.SubIndex)

	-- change to target current
	elseif (returnCode == HotbarSystem.ContextReturnCodes.TARGET_CURRENT) then
		UserActionSetTargetType(param.HotbarId, param.ItemIndex, param.SubIndex, SystemData.Hotbar.TargetType.TARGETTYPE_CURRENT)
		HotbarSystem.UpdateTargetMouseOver(param.HotbarId, param.ItemIndex, param.SubIndex, nil)
		HotbarSystem.UpdateTargetTypeIndicator(param.SlotWindow, param.HotbarId, param.ItemIndex, param.SubIndex)

		-- change to target cursor
	elseif (returnCode == HotbarSystem.ContextReturnCodes.TARGET_CURSOR) then
		UserActionSetTargetType(param.HotbarId, param.ItemIndex, param.SubIndex, SystemData.Hotbar.TargetType.TARGETTYPE_CURSOR)
		HotbarSystem.UpdateTargetMouseOver(param.HotbarId, param.ItemIndex, param.SubIndex, nil)
		HotbarSystem.UpdateTargetTypeIndicator(param.SlotWindow, param.HotbarId, param.ItemIndex, param.SubIndex)

	-- change to target mouse over
	elseif (returnCode == HotbarSystem.ContextReturnCodes.TARGET_MOUSEOVER) then
		UserActionSetTargetId(param.HotbarId, param.ItemIndex, param.SubIndex, WindowData.ItemProperties.CurrentHover)
		UserActionSetTargetType(param.HotbarId, param.ItemIndex, param.SubIndex, SystemData.Hotbar.TargetType.TARGETTYPE_OBJECT_ID)
		HotbarSystem.UpdateTargetMouseOver(param.HotbarId, param.ItemIndex, param.SubIndex, param)
		HotbarSystem.UpdateTargetTypeIndicator(param.SlotWindow, param.HotbarId, param.ItemIndex, param.SubIndex)

	-- change to target stored
	elseif (returnCode == HotbarSystem.ContextReturnCodes.TARGET_OBJECT_ID) then
		HotbarSystem.RequestTargetInfo(param.SlotWindow, param.HotbarId, param.ItemIndex, param.SubIndex)

	-- edit an action/macro
	elseif (returnCode == HotbarSystem.ContextReturnCodes.EDIT_ITEM) then
		WindowSetShowing("ActionsWindow", true) -- Open the actions window
		ActionEditWindow.OpenEditWindow(param.ActionId, param.ActionType, param.SlotWindow, param.HotbarId, param.ItemIndex, param.SubIndex)

	-- enabble macro repeat
	elseif (returnCode == HotbarSystem.ContextReturnCodes.ENABLE_REPEAT) then
		UserActionMacroSetRepeatEnabled(param.HotbarId, param.ItemIndex, true)

	-- disable macro repeat
	elseif (returnCode == HotbarSystem.ContextReturnCodes.DISABLE_REPEAT) then
		UserActionMacroSetRepeatEnabled(param.HotbarId, param.ItemIndex, false)

	-- default enchant (spell) menu selection
	elseif (returnCode == HotbarSystem.ContextReturnCodes.SPELL_ENCHANT) then
		Interface.ForceEnchant = param.SelectedSpellOption
		Interface.SaveSetting("ForceEnchant", Interface.ForceEnchant)

	-- default summon familiar (spell) menu selection
	elseif (returnCode == HotbarSystem.ContextReturnCodes.SPELL_FAMILIAR) then
		Interface.ForceFamiliar = param.SelectedSpellOption
		Interface.SaveSetting("ForceFamiliar", Interface.ForceFamiliar )

	-- default animal form (spell) menu selection
	elseif (returnCode == HotbarSystem.ContextReturnCodes.SPELL_ANIMAL_FORM) then
		Interface.ForceAnimal = param.SelectedSpellOption
		Interface.SaveSetting("ForceAnimal", Interface.ForceAnimal)

	-- default polymorph (spell) menu selection
	elseif (returnCode == HotbarSystem.ContextReturnCodes.SPELL_POLYMORPH) then
		Interface.ForcePolymorph = param.SelectedSpellOption
		Interface.SaveSetting("ForcePolymorph", Interface.ForcePolymorph )

	-- default spell trigger (spell) menu selection
	elseif (returnCode == HotbarSystem.ContextReturnCodes.SPELL_SPELL_TRIGGER) then
		Interface.ForceSpellTrigger = param.SelectedSpellOption
		Interface.SaveSetting("ForceSpellTrigger", Interface.ForceSpellTrigger)

	-- default spell combat training (spell) menu selection
	elseif (returnCode == HotbarSystem.ContextReturnCodes.SPELL_COMBAT_TRAINING) then
		Interface.ForceTraining = param.SelectedSpellOption
		Interface.SaveSetting("ForceTraining", Interface.ForceTraining)

	-- toggle alert
	elseif (returnCode == HotbarSystem.ContextReturnCodes.TOGGLE_ALERT) then
		
		-- toggle alert flag
		Interface.SaveSetting( param.SlotWindow .. "EnableAlert", not Interface.LoadSetting( param.SlotWindow .. "EnableAlert", false ) )

		-- disabled
		if not Interface.LoadSetting( param.SlotWindow .. "EnableAlert", false) then
			WindowSetShowing(param.SlotWindow.."Alert",false)
		end

	-- toggle charges
	elseif (returnCode == HotbarSystem.ContextReturnCodes.TOGGLE_CHARGES) then
		
		-- toggle charges flag
		Interface.SaveSetting( param.SlotWindow .. "EnableCharges", not Interface.LoadSetting( param.SlotWindow .. "EnableCharges", false ) )

	-- security setting: owner
	elseif (returnCode == HotbarSystem.ContextReturnCodes.SECURITY_OWNER) then	
		local cb = ReplaceTokens(ActionsWindow.ActionData[5751].callback, {L"\"owner\""})
		UserActionSpeechSetText(param.HotbarId, param.ItemIndex, param.SubIndex, cb)

	-- security setting: co-owner
	elseif (returnCode == HotbarSystem.ContextReturnCodes.SECURITY_COOWNER) then	
		local cb = ReplaceTokens(ActionsWindow.ActionData[5751].callback, {L"\"coowner\""})
		UserActionSpeechSetText(param.HotbarId, param.ItemIndex, param.SubIndex, cb)

	-- security setting: friend
	elseif (returnCode == HotbarSystem.ContextReturnCodes.SECURITY_FRIEND) then	
		local cb = ReplaceTokens(ActionsWindow.ActionData[5751].callback, {L"\"friend\""})
		UserActionSpeechSetText(param.HotbarId, param.ItemIndex, param.SubIndex, cb)

	-- security setting: guild
	elseif (returnCode == HotbarSystem.ContextReturnCodes.SECURITY_GUILD) then	
		local cb = ReplaceTokens(ActionsWindow.ActionData[5751].callback, {L"\"guild\""})
		UserActionSpeechSetText(param.HotbarId, param.ItemIndex, param.SubIndex, cb)

	-- security setting: anyone
	elseif (returnCode == HotbarSystem.ContextReturnCodes.SECURITY_ANYONE) then	
		local cb = ReplaceTokens(ActionsWindow.ActionData[5751].callback, {L"\"anyone\""})
		UserActionSpeechSetText(param.HotbarId, param.ItemIndex, param.SubIndex, cb)
		
	-- mass organizer
	elseif (returnCode == HotbarSystem.ContextReturnCodes.AGENT_ORGANIZER) then
		Organizer.ActiveOrganizer = param.SelectedAgent
		Interface.SaveSetting( "OrganizerActiveOrganizer" , Organizer.ActiveOrganizer )

	-- undress agent
	elseif (returnCode == HotbarSystem.ContextReturnCodes.AGENT_UNDRESS) then
		Organizer.ActiveUndress = param.SelectedAgent
		Interface.SaveSetting( "OrganizerActiveUndress" , Organizer.ActiveUndress )

	-- set mobile bar filter
	elseif (returnCode == HotbarSystem.ContextReturnCodes.SETDOCKSPOTFILTER) then
		local cb = ReplaceTokens(ActionsWindow.ActionData[5757].callback, {L"L\"" .. param.filterName .. L"\""})
		UserActionSpeechSetText(param.HotbarId, param.ItemIndex, param.SubIndex, cb)

	-- Target filters
	elseif HotbarSystem.IsTargetInjuredCallback(returnCode) then	

		-- get the noto id
		local noto = returnCode - 60

		-- toggle the filter
		if Actions.IsNotorietyEnabled(param.notoString, noto) then
			param.notoString = string.setChar(param.notoString, noto, 0)
		else
			param.notoString = string.setChar(param.notoString, noto, 1)
		end
		
		-- save the new filter for the action
		local cb = ReplaceTokens(ActionsWindow.ActionData[param.ActionId].callback, { L"\"" .. towstring(param.notoString) .. L"\"" })
		UserActionSpeechSetText(param.HotbarId, param.ItemIndex, param.SubIndex, cb)

	-- tracking default target
	elseif HotbarSystem.IsTrackingCallback(returnCode) then

		-- get the target id
		local targ = returnCode - 90

		-- store the default target
		Interface.ForceTracking = targ

		-- save the new selection
		Interface.SaveSetting("ForceTracking", Interface.ForceTracking)

	-- target corpse
	elseif HotbarSystem.IsTargetCorpseCallback(returnCode) then

		-- get the filter id
		local flagID = returnCode - 100

		-- toggle the filter
		if Actions.IsFlagEnabled(param.flagsString, flagID) then
			param.flagsString = string.setChar(param.flagsString, flagID, 0)
		else
			param.flagsString = string.setChar(param.flagsString, flagID, 1)
		end

		-- save the new filter for the action
		local cb = ReplaceTokens(ActionsWindow.ActionData[param.ActionId].callback, { L"\"" .. towstring(param.flagsString) .. L"\"" })
		UserActionSpeechSetText(param.HotbarId, param.ItemIndex, param.SubIndex, cb)

	else -- other cases are handled by the default empty slot routine
		bHandled = false
	end
	
	return bHandled
end

function HotbarSystem.IsTargetInjuredCallback(returnCode)
	return returnCode >= HotbarSystem.ContextReturnCodes.TARGETFILTER_INNOCENT and returnCode <= HotbarSystem.ContextReturnCodes.TARGETFILTER_IGNOREMORTALSTRIKED
end

function HotbarSystem.IsTrackingCallback(returnCode)
	return returnCode >= HotbarSystem.ContextReturnCodes.TRACKING_SHOWGUMP and returnCode <= HotbarSystem.ContextReturnCodes.TRACKING_PLAYERS
end

function HotbarSystem.IsTargetCorpseCallback(returnCode)
	return returnCode >= HotbarSystem.ContextReturnCodes.TARGETCORPSE_UNLOOTED and returnCode <= HotbarSystem.ContextReturnCodes.TARGETCORPSE_REANIMABLE
end

function HotbarSystem.RequestTargetInfo(windowName, hotbarId, itemIndex, subIndex)
	
	-- make sure the window exist
	if not DoesWindowExist(windowName) then
		return
	end

	-- loading the data to be used when the target is received
	HotbarSystem.CurRequestInfoItem =
	{
		windowName = windowName,
		hotbarId = hotbarId,
		itemIndex = itemIndex,				
		subIndex = subIndex,
	}

	-- fires up the target request
	RequestTargetInfo(HotbarSystem.RequestTargetInfoReceived)
	
	-- show the text describing what the user must do
	WindowClearAnchors("RequestTargetIdInfo")
	WindowAddAnchor("RequestTargetIdInfo", "topright", windowName, "bottomleft", 0, -6)
	WindowSetShowing("RequestTargetIdInfo", true)
end

function HotbarSystem.RequestTargetInfoReceived(objectId)
	
	-- making sure the target ID is valid and that we have the data array
	if (IsValidID(objectId) and HotbarSystem.CurRequestInfoItem ~= nil) then
		
		-- updating the stored target on the slot
		UserActionSetTargetId(HotbarSystem.CurRequestInfoItem.hotbarId, HotbarSystem.CurRequestInfoItem.itemIndex, HotbarSystem.CurRequestInfoItem.subIndex, objectId)

		-- updating the target type in the slot
		UserActionSetTargetType(HotbarSystem.CurRequestInfoItem.hotbarId, HotbarSystem.CurRequestInfoItem.itemIndex, HotbarSystem.CurRequestInfoItem.subIndex, SystemData.Hotbar.TargetType.TARGETTYPE_OBJECT_ID)

		-- updating the target colors
		HotbarSystem.UpdateTargetTypeIndicator(HotbarSystem.CurRequestInfoItem.windowName, HotbarSystem.CurRequestInfoItem.hotbarId, HotbarSystem.CurRequestInfoItem.itemIndex, HotbarSystem.CurRequestInfoItem.subIndex)
	end
	
	-- hiding the text instructions
	WindowSetShowing("RequestTargetIdInfo", false)
end

function HotbarSystem.ReplaceKey(oldHotbarId, oldItemIndex, oldType, hotbarId, itemIndex, type, key, shortKey)

	-- remove the current hotkey
	HotbarSystem.UnbindKey(oldHotbarId, oldItemIndex, oldType)

	-- assign the new hotkey
	HotbarSystem.BindKey(hotbarId, itemIndex, type, key, shortKey)
	
	-- update the settings
	BroadcastEvent( SystemData.Events.KEYBINDINGS_UPDATED )

	-- update the bindings for hotbars
	HotbarSystem.UpdateHotbars()

	-- update tab
	SettingsWindow.ForceSelectTab(SettingsWindow.ActiveTab)
end

function HotbarSystem.BindKey(hotbarId, itemIndex, type, key, shortKey)

	-- slot window name
	local element = "Hotbar"..hotbarId.."Button"..itemIndex
	
	-- getting the action ID
	local actionId = UserActionGetId(hotbarId, itemIndex, 0)

	-- getting the action type
	local actionType = UserActionGetType(Hotbar.RecordingHotbar, Hotbar.RecordingSlot, 0)
	
	-- is this a weapon ability?
	if actionType == SystemData.UserAction.TYPE_WEAPON_ABILITY and type ~= SystemData.BindType.BINDTYPE_SETTINGS then
		
		-- hotkey ID on settings window for ability 1
		local setId = 10

		-- if it's the ability 2 we change it
		if actionId == 2 then
			setId = 11
		end

		-- changing the hotkey inside the settings
		SettingsWindow.Keybindings[setId].newValue = key

		-- updating the settings
		BroadcastEvent( SystemData.Events.KEYBINDINGS_UPDATED )

		-- updating the text inside settings window
		SettingsWindow.UpdateKeyBindings()

		-- removing the hotkey in the slot
		SystemData.Hotbar[hotbarId].Bindings[itemIndex] = L""
		SystemData.Hotbar[hotbarId].BindingDisplayStrings[itemIndex] = L""

		-- updating the text in the slot
		HotbarSystem.UpdateBinding(element, key, shortKey)

	-- is this an action with a setting hotkey?
	elseif ActionsWindow.isAction(actionType) and ActionsWindow.ActionData[actionId] and ActionsWindow.ActionData[actionId].settingKeyBinding then
		
		-- getting the setting's hotkey ID
		local setId = SettingsWindow.GetKeybindingIDByType(ActionsWindow.ActionData[actionId].settingKeyBinding)

		-- changing the hotkey inside the settings
		SettingsWindow.Keybindings[setId].newValue = key

		-- updating the settings
		BroadcastEvent( SystemData.Events.KEYBINDINGS_UPDATED )

		-- updating the text inside settings window
		SettingsWindow.UpdateKeyBindings()

		-- removing the hotkey in the slot
		SystemData.Hotbar[hotbarId].Bindings[itemIndex] = L""
		SystemData.Hotbar[hotbarId].BindingDisplayStrings[itemIndex] = L""

		-- updating the text in the slot
		HotbarSystem.UpdateBinding(element, key, shortKey)

	-- hotkey inside settings window
	elseif type == SystemData.BindType.BINDTYPE_SETTINGS then
		
		-- changing the hotkey inside the settings
		SettingsWindow.Keybindings[itemIndex].newValue = key

		-- updating the settings
		BroadcastEvent( SystemData.Events.KEYBINDINGS_UPDATED )

		-- updating the text inside settings window
		SettingsWindow.UpdateKeyBindings()

		-- updating the text in the slot
		HotbarSystem.UpdateBinding(element, key, shortKey)

	-- hotkey in the hotbar slot
	elseif type == SystemData.BindType.BINDTYPE_HOTBAR or hotbarId == Interface.MountBlockbar then

		-- changing the hotkey for the hotbar slot
		SystemData.Hotbar[hotbarId].Bindings[itemIndex] = key
		SystemData.Hotbar[hotbarId].BindingDisplayStrings[itemIndex] = shortKey
		
		-- updating the hotkey in the settings
		HotbarUpdateBinding(hotbarId, itemIndex, key)

		-- updating the text in the slot
		HotbarSystem.UpdateBinding(element, key, shortKey)
	
	-- hotkey for a macro
	elseif type == SystemData.BindType.BINDTYPE_MACRO then

		-- changing the hotkey to a macro
		UserActionMacroUpdateBinding(hotbarId, itemIndex, key)

		-- macro list hotkey text
		local MacroLabel = "MacroScrollWindowScrollChildItem"..itemIndex.."Binding"

		-- is the macro label visible?
		if DoesWindowExist(MacroLabel) then

			-- do we have a valid hotkey?
			if IsValidWString(key) then
			
				-- update the macro text
				MacroWindow.UpdateBindingText(MacroLabel, key)

			else -- setting the macro text to "no keybinding"
				LabelSetText(MacroLabel, GetStringFromTid(MacroWindow.TID_NO_KEYBINDING))
			end
		end

		-- updating the text in the slot
		HotbarSystem.UpdateBinding(element, key, shortKey)
	end
end

function HotbarSystem.UpdateBindingToSlot(hotbarId, slot)

	-- we got compressed parameters instead of the hotbar id so we have to decompress it
	if type(hotbarId) == "table" then
		slot = hotbarId[2]
		hotbarId = hotbarId[1]
	end

	-- make sure the hotbar exist and the id is correct
	if not Hotbar.DoesHotbarExist(hotbarId, true) or not IsValidID(slot) then
		return
	end

	-- hotbar window name
	local hotbar = "Hotbar" .. hotbarId

	-- slot window name
	local element = hotbar .. "Button" .. slot

	-- is the slot visible?
	if not WindowGetShowing(element) then
		return
	end

	-- getting the slot hotkey
	local key = SystemData.Hotbar[hotbarId].BindingDisplayStrings[slot]
	local key2 = SystemData.Hotbar[hotbarId].Bindings[slot]

	-- getting the slot action id
	local actionId = UserActionGetId(hotbarId, slot, 0)
	
	-- do we have a valid action ID or it's an empty slot?
	if IsValidID(actionId) then 
		
		-- getting the slot action type
		local actionType = UserActionGetType(hotbarId, slot, 0)

		-- is this a weapon ability?
		if actionType == SystemData.UserAction.TYPE_WEAPON_ABILITY  then

			-- setting hotkey for ability 1
			local setId = 10

			-- if it's the ability 2 we update it
			if actionId == 2 then
				setId = 11
			end

			-- getting the key from settings
			key = SystemData.Settings.Keybindings[SettingsWindow.Keybindings[setId].type]

			-- key 2 is not available for settings hotkey
			key2 = L""

		-- is this a macro?
		elseif HotbarSystem.IsHotbarMacro(actionType) and (Interface.MountBlockbar ~= hotbarId) then

			-- getting the real macro ID
			local macroIndex = MacroSystemGetMacroIndexById(actionId)

			-- getting the key from the macro
			key = UserActionMacroGetBinding(SystemData.MacroSystem.STATIC_MACRO_ID, macroIndex) or L""

			-- key 2 is not available for macro's hotkey
			key2 = L""

		-- is this an action?
		elseif ActionsWindow.isAction(actionType) then

			-- does this action have a settings hotkey?
			if ActionsWindow.ActionData[actionId] and ActionsWindow.ActionData[actionId].settingKeyBinding then
				
				-- getting the setting's hotkey type
				local keyType = ActionsWindow.ActionData[actionId].settingKeyBinding

				-- getting the key from settings
				key = SystemData.Settings.Keybindings[keyType]

				-- key 2 is not available for settings hotkey
				key2 = L""
			end
		end
	end

	-- updating the text and color on the slot
	HotbarSystem.UpdateBinding(element, key, key2)
end

function HotbarSystem.UpdateBinding(element, key, key2)

	-- make sure the window exist
	if not DoesWindowExist(element) then
		return
	end

	-- get the formatted key and color
	local key, color = WindowUtils.FormatBindings(key, key2, true)
	
	-- default hotkey text color
	LabelSetTextColor(element.."Hotkey", color.r, color.g, color.b)
	
	-- filling the hotkey text
	LabelSetText(element.."Hotkey", key)

	-- clearing the hotkey text position
	WindowClearAnchors(element.."Hotkey")

	-- positioning the text correctly
	WindowAddAnchor(element.."Hotkey", "topleft", element, "topleft", -5, 0)	

	-- if there is an hotkey we show the background behind it to make it easier to read
	if IsValidWString(key) then
		WindowSetShowing(element.."HotkeyBackground", true)
	else
		WindowSetShowing(element.."HotkeyBackground", false)
	end
end

function HotbarSystem.UnbindKey(hotbarId, itemIndex, type)

	-- is this a setting hotkey?
	if type == SystemData.BindType.BINDTYPE_SETTINGS and IsValidID(itemIndex) then
		
		-- remove the key from settings
		SettingsWindow.Keybindings[itemIndex].newValue = L""

		-- updating settings window
		SettingsWindow.UpdateKeyBindings()
		
	-- is this a hotbar slot hotkey?
	elseif type == SystemData.BindType.BINDTYPE_HOTBAR and IsValidID(hotbarId) and IsValidID(itemIndex) then
		
		-- remove the key from the slot
		SystemData.Hotbar[hotbarId].Bindings[itemIndex] = L""
		SystemData.Hotbar[hotbarId].BindingDisplayStrings[itemIndex] = L""
		
		-- updating the slot 
		HotbarUpdateBinding(hotbarId, itemIndex, L"")

		-- slot window name
		local element = "Hotbar"..hotbarId.."Button"..itemIndex

		-- updating the hotkey text
		HotbarSystem.UpdateBinding(element, L"", SystemData.Hotbar[hotbarId].Bindings[itemIndex])
		
	elseif type == SystemData.BindType.BINDTYPE_MACRO and IsValidID(hotbarId) and IsValidID(itemIndex) then
		
		-- update the hotkey in the macro
		UserActionMacroUpdateBinding(hotbarId, itemIndex, L"")

		-- macro window item
		local MacroLabel = "MacroScrollWindowScrollChildItem"..itemIndex.."Binding"

		if DoesWindowExist(MacroLabel) then

			-- reset the text color
			LabelSetTextColor( MacroLabel, 243, 227, 49 )

			-- update the macro text
			LabelSetText(MacroLabel, GetStringFromTid(MacroWindow.TID_NO_KEYBINDING))
		end
	end
end

function HotbarSystem.GetKeyName(hotbarId, itemIndex, type)
	
	-- is a setting's hotkey?
	if (type == SystemData.BindType.BINDTYPE_SETTINGS) then
		
		-- scan all keys to find the duplicate
		for type, key in pairs(SystemData.Settings.Keybindings) do

			-- is this the hotkey?
			if key == SystemData.RecordedKey then
				
				-- get the key name
				local keyName = GetStringFromTid(SettingsWindow.GetKeyBindingNameFromType(type))

				-- remove the ":" at the end
				if wstring.len(keyName) > 0 then
					keyName = wstring.sub(keyName, 1, wstring.len(keyName) - 1)
				end

				-- return the name
				return keyName
			end
		end

	-- is an hotbar hotkey?
	elseif (type == SystemData.BindType.BINDTYPE_HOTBAR) then

		-- if it's the mount blockbar, we return "Mount/Dismount" instead of the hotbar id and slot number
		if hotbarId == Interface.MountBlockbar and itemIndex == 1 then
			return GetStringFromTid(290)

		else -- we return hotbar id and slot number
			return GetStringFromTid( Hotbar.TID_HOTBAR )..L" "..hotbarId..L"  "..GetStringFromTid( Hotbar.TID_SLOT )..L" "..itemIndex
		end

	-- is a macro hotkey?
	elseif (type == SystemData.BindType.BINDTYPE_MACRO) then

		-- get the macro name
		local macroName = UserActionMacroGetName(SystemData.MacroSystem.STATIC_MACRO_ID, itemIndex)

		-- is this a spellbook hotkey?
		if wstring.find(macroName, L"SpellbookHotkey", 1, true) then

			-- get the spell ID from the macro name
			local spellID = tonumber(tostring(wstring.gsub(macroName, L"SpellbookHotkey", L"")))
			
			-- getting the spell's data
			local _, _, tid = GetAbilityData(spellID)

			 -- Spell: <spell name>
			return ReplaceTokens(GetStringFromTid(305), {GetStringFromTid(tid)}) 

		-- is this a skill hotkey?
		elseif wstring.find(macroName, L"SkillHotkey", 1, true) then

			local skillID = tonumber(tostring(wstring.gsub(macroName, L"SkillHotkey", L"")))

			-- Skill: <skill name>
			return ReplaceTokens(GetStringFromTid(1071345), {WindowData.SkillList[skillID].skillName})  -- Skill: ~1_val~

		else -- return the macro name
			return GetStringFromTid(MacroWindow.TID_MACROCOLON) .. L"  " .. macroName
		end
	end
end

function HotbarSystem.SetActionOnHotbar(actionType, actionId, actionIcon, hotbarNum, buttonNum)
	
	-- make sure the parameters are correct
	if not IsValidID(hotbarNum) or not IsValidID(buttonNum) or not IsValidID(actionId) or not Hotbar.DoesHotbarExist(hotbarNum) then
		return
	end

	-- assign the action to the slot
    HotbarCreateNewAction(actionType, actionId, actionIcon, hotbarNum, buttonNum)

	-- slot window name
    local element = "Hotbar"..hotbarNum.."Button"..buttonNum

	-- registering the element
    HotbarSystem.RegisterAction(element, hotbarNum, buttonNum, 0)

	-- initialize the slot basic functions
	pcall(ActionsWindow.InitializeActionSlotCallback, {actionId, actionType, element, hotbarNum, buttonNum, 0})
end

function HotbarSystem.UpdateHotbars()

	-- scan all the hotbars
	for index, hotbarId in pairs(SystemData.Hotbar.HotbarIds) do
		
		-- current hotbar name
		local this = "Hotbar"..hotbarId

		-- making sure the hotbar is not closed
		if not Hotbar.IsShrunken(hotbarId, false) then

			-- scanning all the slots
			for slot = 1, Hotbar.NUM_BUTTONS do

				-- current slot window name
				local element = this.."Button"..slot

				-- update the hotkey
				HotbarSystem.UpdateBindingToSlot(hotbarId, slot)

				-- update the target colors
				HotbarSystem.UpdateTargetTypeIndicator(element, hotbarId, slot, 0)
			end	
		end
	end
end

-- check if an unique action is already in the hotbars
function HotbarSystem.ActionAlreadyInHotbar(actionId, scantype, itemData)
	
	-- scanning all hotbars
	for index, hotbarId in pairs(SystemData.Hotbar.HotbarIds) do
		
		-- we don't need to check the mount blockbar
		if hotbarId == Interface.MountBlockbar then
			continue
		end

		-- scanning all buttons
		for slot = 1, Hotbar.NUM_BUTTONS do
			
			-- is this an empty slot?
			if not HotbarHasItem(hotbarId, slot) then
				continue
			end

			-- current action id
			local currActionId = UserActionGetId(hotbarId, slot, 0)
			
			-- current action type
			local actionType = UserActionGetType(hotbarId, slot, 0)
			
			-- we're looking for an action and the current action ID is the one we're looking for
			if actionId == currActionId and (type(scantype) == "string" and scantype == "action" and ActionsWindow.isAction(actionType)) then
				return true, "Hotbar" .. hotbarId .. "Button" .. slot
			end

			-- we're looking for an item
			if (type(scantype) == "string" and scantype == "item" and HotbarSystem.IsHotbarItem(actionType)) then
				
				-- stackable item
				if actionType == SystemData.UserAction.TYPE_USE_OBJECTTYPE  then
					
					-- get the object type and hue for the item in the slot
					local objectType, hue = UserActionUseObjectTypeGetObjectTypeHue(currActionId)

					-- the object type and hue are the one we're looking for!
					if itemData.type == objectType and itemData.hue ==  hue then
						return true, "Hotbar" .. hotbarId .. "Button" .. slot
					end

				-- normal item
				elseif actionType == SystemData.UserAction.TYPE_USE_ITEM then

					-- the item in the slot IS the item we're looking for
					if actionId == currActionId then
						return true, "Hotbar" .. hotbarId .. "Button" .. slot
					end
				end
			end

			-- we're looking for a specific type of action, if the ID and type are the one we're looking for we've found it! invokeId
			if actionId == currActionId and (type(scantype) == "number" and scantype == actionType) then
				return true, "Hotbar" .. hotbarId .. "Button" .. slot
			end
		end
	end
	return false
end

function HotbarSystem.IsHotbarItem(type)
	
	-- is an item? (stackable or not)
	if type == SystemData.UserAction.TYPE_USE_ITEM or type == SystemData.UserAction.TYPE_USE_OBJECTTYPE then
		return true
	end
end

function HotbarSystem.IsHotbarMacro(type)
	
	-- is a macro?
	if type == SystemData.UserAction.TYPE_MACRO_REFERENCE or type == SystemData.UserAction.TYPE_MACRO then
		return true
	end
end

HotbarSystem.GlowingItems = {}
HotbarSystem.TerminateGlow = nil
-- make a slot glow for a certain time or until the player is dragging a certain action
function HotbarSystem.GlowSlotWarning(curElement, time, dragAction)

	-- no duplicate effects allowed
	if not curElement or HotbarSystem.GlowingItems[curElement] then
		return
	end

	-- remove the terminate glow request
	HotbarSystem.TerminateGlow = nil

	-- register the glowing item
	HotbarSystem.GlowingItems[curElement] = { timer = Interface.TimeSinceLogin + time, dragAction = dragAction }
	
	-- enable the alert highlight on the slot
	WindowSetShowing(curElement .. "Alert", true)
end

-- stop glowing slot
function HotbarSystem.StopGlowSlot(curElement)
	
	-- the slot is not glowing
	if not HotbarSystem.GlowingItems[curElement] then
		return
	end

	-- disabling the alert highlight
	WindowSetShowing(curElement.."Alert", false)

	-- removing the glowing request
	HotbarSystem.GlowingItems[curElement] = nil
end

function HotbarSystem.GetChargesForItem(objectID)

	-- is a valid object and the player still has it?
	if not IsValidID(objectID) then
		return
	end
	
	-- default value
	local charges = -1

	-- do we have the charges on buffer?
	if HotbarSystem.QuantityChargesBuffer[objectID] then

		-- it's been less than a second from the last check?
		if HotbarSystem.QuantityChargesBuffer[objectID].timeStamp > Interface.TimeSinceLogin then
			
			-- we return the charges we have on buffer
			return HotbarSystem.QuantityChargesBuffer[objectID].qta
		end
	end

	-- getting the item props
	local props = Interface.GetItemPropertiesData(objectID, "container items uses scan")
		
	-- do we have the properties?
	if props then

		-- build the TID params array
		local params = ItemProperties.BuildParamsArray(props)
		
		-- searching for the charges TID
		for tid, token in pairs(ItemPropertiesInfo.ChargesTid) do

			-- not this one...
			if not params[tid] then
				continue
			end

			-- getting the charges value
			local val = tostring(params[tid][token])
			
			-- converting to number
			charges = tonumber(val)
			break
		end
	end

	return charges
end

function HotbarSystem.StartConsumableCooldowns(objectType, hue)

	-- make sure the object type is valid
	if not IsValidID(objectType) then
		return
	end

	-- healing potion
	if objectType == 3852 then
		HotbarSystem.HealPotDelayTime = 10

	-- enchanted apples
	elseif objectType == 12248 and hue == 1160 then
		HotbarSystem.AppleDelayTime = 30

	-- grapes of wrath
	elseif objectType == 12247 and hue == 1154 then
		HotbarSystem.GrapeDelayTime = 120
	end
end

HotbarSystem.QuantityChargesBuffer = {}
function HotbarSystem.UpdateQuantityNChargesForSlot(element, actionId, actionType, objectID, objectType, hue)

	-- is a valid action?
	if not IsValidID(actionId) then
		return
	end

	-- not an item?
	if not HotbarSystem.IsHotbarItem(actionType) then
		return
	end

	-- base setting for alert (if enabled)
	local alertAlpha = 1
	local showAlert = false

	-- if the slot is disabled, we don't need to do anything here
	if WindowGetShowing(element.."Disabled") then

		-- remove the quantity text
		LabelSetText(element.."Quantity", L"")

		return showAlert, alertAlpha
	end

	-- default quantity label text
	local chargesQuantityText = L""

	-- is this slot showing charges instead of quantity?
	if Interface.LoadSetting(element .. "EnableCharges", false) then
					
		-- getting the charges
		local charges = HotbarSystem.GetChargesForItem(objectID)
		
		-- do we have charges to show and is less than 10?
		if IsValidID(charges) and charges < 10 then

			-- we scale the alpha with the  charges remaining
			alertAlpha = 1 - (charges / 10)

			-- enable the alert
			showAlert = true
		end
		
		-- add a K if the charges are more than 1000
		chargesQuantityText = Knumber(charges)

		-- save the current value for the next check, the update can only be done once a second
		HotbarSystem.QuantityChargesBuffer[objectID] = {qta = charges, timeStamp = Interface.TimeSinceLogin + 1}

		-- set the charges/quantity
		LabelSetText(element.."Quantity", chargesQuantityText)

	-- showing quantity (only for stackable items)
	elseif actionType == SystemData.UserAction.TYPE_USE_OBJECTTYPE then

		-- get the current quantity
		local oldQta = -1

		-- if the quantity label has a number, we get it
		if LabelGetText(element.."Quantity") ~= L"" then
			oldQta = tonumber(LabelGetText(element.."Quantity"))
		end

		-- initialize quantity
		local qta = 0

		-- do we have the charges on buffer and it's been more than a second from the last check?
		if HotbarSystem.QuantityChargesBuffer[actionId] and HotbarSystem.QuantityChargesBuffer[actionId].timeStamp > Interface.TimeSinceLogin then

			-- use the stored quantity
			qta = HotbarSystem.QuantityChargesBuffer[actionId].qta
		else
			-- get the new quantity
			qta = GetQuantityForItem(actionId)
			
			-- save the current value for the next check, the update can only be done once a second
			HotbarSystem.QuantityChargesBuffer[actionId] = {qta = qta, timeStamp = Interface.TimeSinceLogin + 1}
		end

		-- if we have valid quantities, we check if the item has been used and the amount has lost 1
		if (oldQta >= 0 and qta >= 0) and (Interface.LastItem == objectID and qta == oldQta - 1) then
						
			-- we start the cooldown for that item type (if it has one)
			HotbarSystem.StartConsumableCooldowns(objectType, hue)
		end

		-- do we have charges to show and is less than 10?
		if IsValidID(qta) and qta < 20 then

			-- we scale the alpha with the  charges remaining
			alertAlpha = 1 - (qta / 20)

			-- enable the alert
			showAlert = true
		end
		
		-- do we have a valid quantity amount?
		if qta > 0 then
			chargesQuantityText = Knumber(qta)
		end

		-- set the charges/quantity
		LabelSetText(element.."Quantity", chargesQuantityText)

	-- showing quantity (only for other items)
	elseif actionType == SystemData.UserAction.TYPE_USE_ITEM then
	
		-- get the current quantity
		local oldQta = -1

		-- if the quantity label has a number, we get it
		if LabelGetText(element.."Quantity") ~= L"" then
			oldQta = tonumber(LabelGetText(element.."Quantity"))
		end

		-- initialize quantity
		local qta = 0

		-- do we have the charges on buffer and it's been more than a second from the last check?
		if HotbarSystem.QuantityChargesBuffer[objectID] and HotbarSystem.QuantityChargesBuffer[objectID].timeStamp > Interface.TimeSinceLogin then
			
			-- use the stored quantity
			qta = HotbarSystem.QuantityChargesBuffer[objectID].qta

		-- the object is a spellbook? 
		elseif not Actions.IsSpellbook(objectType) and not ContainersInfo.IsValidContainer(objectID) then
		
			-- count the items in the backpack
			qta = ContainerWindow.GetItemQuantity(objectType, hue)

			-- save the current value for the next check, the update can only be done once a second
			HotbarSystem.QuantityChargesBuffer[objectID] = {qta = qta, timeStamp = Interface.TimeSinceLogin + 1}

		-- is this a spellbook?
		elseif Actions.IsSpellbook(objectType) then

			-- get the spells number instead
			qta = Actions.SpellbookCountSpells(objectID)
			
			-- save the current value for the next check, the update can only be done once a second
			HotbarSystem.QuantityChargesBuffer[objectID] = {qta = qta, timeStamp = Interface.TimeSinceLogin + 1}
		end
		
		-- if we have valid quantities, we check if the item has been used and the amount has lost 1
		if (oldQta >= 0 and qta >= 0) and (Interface.LastItem == objectID and qta == oldQta - 1) then
						
			-- we start the cooldown for that item type (if it has one)
			HotbarSystem.StartConsumableCooldowns(objectType, hue)
		end

		-- do we have charges to show and is less than 10?
		if IsValidID(qta) and qta < 20 then

			-- we scale the alpha with the  charges remaining
			alertAlpha = 1 - (qta / 20)

			-- enable the alert
			showAlert = true
		end
		
		-- do we have a valid quantity amount?
		if qta > 0 then
			chargesQuantityText = Knumber(qta)
		end

		-- showing the quantity only if the amount is greater than 1
		if qta > 1 and qta ~= oldQta then
		
			-- set the charges/quantity
			LabelSetText(element.."Quantity", chargesQuantityText)
		end
	end

	return showAlert, alertAlpha
end

function HotbarSystem.SetCustomTextureNBorder(element)
	
	-- make sure the element exist
	if not DoesWindowExist(element) then
		return
	end

	local elementIcon = element.."SquareIcon"
	local elementOverlay = element.."Overlay"

	-- get the saved border for this slot
	local custom = Interface.LoadSetting( element .. "Custom", Interface.Settings.MTP_CurrentBorder )

	-- verify the border exist
	if not MiniTexturePack.Overlays[custom] then
		custom = Interface.Settings.MTP_CurrentBorder
	end

	-- if the border exist, we update it with the custom one
	if DoesWindowExist(elementOverlay) then
		DynamicImageSetTexture(elementOverlay,	MiniTexturePack.Overlays[custom].texture, 0, 0)
	end

	-- get the saved texture for this slot
	custom = Interface.LoadSetting( element .. "CustomTXT", nil, 0 )

	-- verify the texture exist
	if custom and not MiniTexturePack.DB[custom] then
		custom = nil
	end

	-- do we have a saved texture?
	if (custom) then

		-- we apply the saved texture to the background
		if DoesWindowExist(elementIcon) then
			DynamicImageSetTexture( elementIcon .."BG", MiniTexturePack.DB[custom].texture .. "Icon", 0, 0 )
		end

	else -- no texture saved

		-- we apply the default texture as background
		if DoesWindowExist(elementIcon) then
			DynamicImageSetTexture( elementIcon .."BG", MiniTexturePack.DB[Interface.Settings.MTP_Current].texture .. "Icon", 0, 0 )
		end
	end	
end