----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

PaperdollWindow = {}

PaperdollWindow.MenuRequest = 0
PaperdollWindow.CurrentBG = ""
PaperdollWindow.TID = {}
PaperdollWindow.TID.CLOTHING	= 1077861	--CLOTHING
PaperdollWindow.TID.ARMOR		= 1077862	--ARMOR
PaperdollWindow.TID.PAPERDOLL	= 1077863 	--PAPERDOLL
PaperdollWindow.TID.PROFILE 	= 1078990   --PROFILE

PaperdollWindow.PAPERDOLLSLOTID 	= {}

PaperdollWindow.PAPERDOLLSLOTID.FEET 		= 13
PaperdollWindow.PAPERDOLLSLOTID.HEAD 		= 1
PaperdollWindow.PAPERDOLLSLOTID.SHIRT 		= 14   
PaperdollWindow.PAPERDOLLSLOTID.PANTS 		= 19 
PaperdollWindow.PAPERDOLLSLOTID.KILT		= 11
PaperdollWindow.PAPERDOLLSLOTID.WINGARMOR   = 17
PaperdollWindow.PAPERDOLLSLOTID.TALONS		= 13

PaperdollWindow.GargoyleDisabledSlots = {
	[PaperdollWindow.PAPERDOLLSLOTID.SHIRT] = true,
	[PaperdollWindow.PAPERDOLLSLOTID.PANTS] = true,
	[PaperdollWindow.PAPERDOLLSLOTID.HEAD] = true,
	}

PaperdollWindow.GargoyleSpecialSlots = {
	[PaperdollWindow.PAPERDOLLSLOTID.KILT] = 11,
	[PaperdollWindow.PAPERDOLLSLOTID.WINGARMOR] = 16,
	[PaperdollWindow.PAPERDOLLSLOTID.TALONS] = 13,
}

PaperdollWindow.WeaponSlots = {
	[4] = true, -- main hand
	[10] = true, -- off-hand/two handed weapon
}

PaperdollWindow.ArmorSlotsList = {
	[1] = true, -- head
	[2] = true, -- neck
	[3] = true, -- sleeves
	[6] = true, -- legs
	[8] = true, -- chest
	[11] = true, -- gloves/kilt
}

PaperdollWindow.HUMAN = 1
PaperdollWindow.ELF = 2
PaperdollWindow.GARGOYLE = 3

PaperdollWindow.WINDOWSCALE = 1

PaperdollWindow.Organize = false
PaperdollWindow.OrganizeBag = nil
PaperdollWindow.OrganizeParent = nil
PaperdollWindow.CanPickUp = true
PaperdollWindow.TimePassedSincePickUp = 0
PaperdollWindow.BlockClosing = false

PaperdollWindow.EmptySlotAlpha = 0.5
PaperdollWindow.FullSlotAlpha = 1

PaperdollWindow.CurrentBG = "blackBG"

PaperdollWindow.ItemsList = {}
PaperdollWindow.ItemsProps = {} -- used for the item comparison, and other players stats

PaperdollWindow.ScanDelta = 0
PaperdollWindow.ScanDeltaTime = 30

PaperdollWindow.PaperdollsName = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------
ItemSlot = {}
ItemSlot.NUM_BUTTONS = 12

ItemSlot.BUTTONSTATE_EMPTY = 0
ItemSlot.BUTTONSTATE_NORMAL = 1
ItemSlot.BUTTONSTATE_ACTIVE = 2
ItemSlot.BUTTONSTATE_DISABLED = 3

ItemSlot.ItemIds = {}
ItemSlot.ObjectTypes = {}
ItemSlot.ButtonStates = {}

PaperdollWindow.OpenPaperdolls = {}
PaperdollWindow.ActivePaperdollImage = 0
PaperdollWindow.ActivePaperdollObject = 0

PaperdollWindow.Locked = false

PaperdollWindow.BlankSlot = {}
PaperdollWindow.BlankSlot[1]  = { SlotNameTid = 1079897, SlotDescTid = 1079916 }
PaperdollWindow.BlankSlot[2]  = { SlotNameTid = 1079898, SlotDescTid = 1079916 }
PaperdollWindow.BlankSlot[3]  = { SlotNameTid = 1079899, SlotDescTid = 1079916 }
PaperdollWindow.BlankSlot[4]  = { SlotNameTid = 1079900, SlotDescTid = 1079917 }
PaperdollWindow.BlankSlot[5]  = { SlotNameTid = 1079901, SlotDescTid = 1079918 }
PaperdollWindow.BlankSlot[6]  = { SlotNameTid = 1079902, SlotDescTid = 1079916 }
PaperdollWindow.BlankSlot[7]  = { SlotNameTid = 1079903, SlotDescTid = 1079919 }
PaperdollWindow.BlankSlot[8]  = { SlotNameTid = 1079904, SlotDescTid = 1079916 }
PaperdollWindow.BlankSlot[9]  = { SlotNameTid = 1079905, SlotDescTid = 1079920 }
PaperdollWindow.BlankSlot[10] = { SlotNameTid = 1079906, SlotDescTid = 1079917 }
PaperdollWindow.BlankSlot[11] = { SlotNameTid = 1079907, SlotDescTid = 1079916, SlotNameTidTwo = 1115375}
PaperdollWindow.BlankSlot[12] = { SlotNameTid = 1079908, SlotDescTid = 1079921 }
PaperdollWindow.BlankSlot[13] = { SlotNameTid = 1079909, SlotDescTid = nil, SlotNameTidTwo = 1115377}
PaperdollWindow.BlankSlot[14] = { SlotNameTid = 1079910, SlotDescTid = nil }
PaperdollWindow.BlankSlot[15] = { SlotNameTid = 1079911, SlotDescTid = nil }
PaperdollWindow.BlankSlot[16] = { SlotNameTid = 1079912, SlotDescTid = nil }
PaperdollWindow.BlankSlot[17] = { SlotNameTid = 1079913, SlotDescTid = nil, SlotNameTidTwo = 1115376 }
PaperdollWindow.BlankSlot[18] = { SlotNameTid = 1079914, SlotDescTid = nil }
PaperdollWindow.BlankSlot[19] = { SlotNameTid = 1079915, SlotDescTid = nil }


---------------------------------------------------------------------

function PaperdollWindow.Initialize()	

	-- get the player ID
	local playerId = GetPlayerID()

	-- paperdoll owner ID
	local mobileId = SystemData.Paperdoll.Id

	-- current window name
	local windowName = "PaperdollWindow" .. mobileId

	-- initializing the ids
	WindowSetId(windowName, mobileId)
	WindowSetId(windowName.."ToggleInventory", mobileId)

	-- window basic features
	Interface.DestroyWindowOnClose[windowName] = true
	SnapUtils.SnappableWindows[windowName] = true

	-- default scale
	WindowSetScale(windowName, SystemData.Settings.Interface.customUiScale * 0.70)
	WindowUtils.LoadScale( windowName )

	-- adding to the open paperdolls list and saving the name (only available when you open it the first time)
	PaperdollWindow.OpenPaperdolls[mobileId] = true
	PaperdollWindow.PaperdollsName[mobileId] = SystemData.Paperdoll.Name

	-- hiding the paperdoll until we're ready to show it
	WindowSetShowing(windowName, false)
		
	-- toggle the buttons: abilities, character sheet, lock and help (only available for the player)
	WindowSetShowing(windowName .. "ToggleCharacterSheet", mobileId == playerId)
	WindowSetShowing(windowName .. "ToggleCharacterAbilities", mobileId == playerId)
	WindowSetShowing(windowName .. "ToggleLock", mobileId == playerId)
	WindowSetShowing(windowName .. "HelpButton", mobileId == playerId)

	-- initializing the paperdoll data
	local paperdollData = Interface.GetPaperdollData(mobileId)

	-- is this the player paperdoll?
	if mobileId == playerId then

		-- the paperdoll has been blocked (external call when target self), no need to show
		if Interface.BlockThisPaperdoll[mobileId] then
			WindowSetOffsetFromParent(windowName, -1000, -1000)
			DestroyWindow(windowName)

		else
			-- highlighting the backpack button if the backpack is open
			local backpackId = GetBackpackID(mobileId)
			local backpackName = "ContainerWindow_"..backpackId
			if DoesWindowExist(backpackName) and WindowGetShowing(backpackName) then
				ButtonSetPressedFlag( windowName.."ToggleInventory", true )
			end		
		
			-- highlight the character sheet button if it's open
			ButtonSetPressedFlag( windowName.."ToggleCharacterSheet", WindowGetShowing("CharacterSheet"))

			-- highlight the character abilities button if it's open
			ButtonSetPressedFlag( windowName.."ToggleCharacterAbilities", WindowGetShowing("CharacterAbilities"))

			-- loading saved position or apply the first positioning location
			WindowUtils.RestoreWindowPosition(windowName, false, "pdollself", true)
			PaperdollWindow.PlayerPaperdollFirstPositioning()

			-- saving the flag of the paperdoll open
			Interface.PaperdollOpen = true
			Interface.SaveSetting( "PaperdollOpen", Interface.PaperdollOpen)

			-- initialize the durability check flag for the player's paperdoll
			PaperdollWindow.GotDamage = true

			-- highlight the lock button if the paperdoll is locked
			ButtonSetPressedFlag(windowName .. "ToggleLock", PaperdollWindow.Locked)

			-- applying the custom name frame texture
			PaperdollWindow.SwitchLabelTexture(id)

			-- applying the background based on where the player is
			PaperdollWindow.SwitchBG()

			-- showing the paperdoll
			WindowSetShowing(windowName, true)	
		end

	else -- other characters paperdoll

		-- hide the profile button if the mobile is not a player (NPCs don't have profiles)
		WindowSetShowing(windowName .. "ToggleProfile", IsPlayer(mobileId))

		-- if the paperdoll has been blocked, we set its position out of screen so the player won't see it flickering around.
		if Interface.BlockThisPaperdoll[mobileId] or Interface.Settings.BlockOthersPaperdoll then
			WindowSetOffsetFromParent(windowName, -1000, -1000)
			DestroyWindow(windowName)

		-- do we have the player vendor window active?
		elseif mobileId == PlayerVendor.MobileId then

			-- clear the current position
			WindowClearAnchors(windowName)

			-- anchor the paperdoll inside the player vendor gump
			WindowAddAnchor(windowName, "topleft", "PlayerVendorItems", "topright", 0, -60)

			-- make the window NOT movable
			WindowSetMovable(windowName, false)
			
			-- backpack button window name
			local inventoryName = windowName .. "ToggleInventory"

			-- hide the backpack button
			WindowSetShowing(inventoryName, false)

			-- flag the paperdoll for the player vendor as open
			PlayerVendor.PaperdollOpen = true
		else
			-- restoring the saved position for other characters paperdolls.
			PaperdollWindow.VerifyPosition(windowName)
			WindowUtils.RestoreWindowPosition(windowName, false, "PaperdollOthers", true )

			-- showing the paperdoll
			WindowSetShowing(windowName, true)
		end
	end

	-- the paperdoll first gets created with item slots
	PaperdollWindow.UpdatePaperdoll(mobileId)
end

function PaperdollWindow.LockTooltip()

	-- is the paperdoll locked?
	if (PaperdollWindow.Locked) then
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1154924)) -- Unlock Paperdoll Window
	else
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1154925)) -- Lock Paperdoll Window
	end
end

function PaperdollWindow.SwitchBG()
	
	-- is the interface already started?
	if not Interface.started then

		-- try again in a short while
		Interface.ExecuteWhenAvailable(
		{
			name = "PaperdollSwitchBG",
			check = function() return Interface.started end, 
			callback = function() PaperdollWindow.SwitchBG() end, 
			removeOnComplete = true
		})

		return
	end

	-- player paperdoll window
	local windowName = "PaperdollWindow" .. GetPlayerID()

	-- is the paperdoll open?
	if not DoesWindowExist(windowName) then
		return
	end

	-- if the option is enabled we change the bg of the paperdoll
	if Interface.Settings.EnablePaperdollBG then
		
		-- determining the player location
		local area = MapCommon.CurrentArea
		local subarea = MapCommon.CurrentSubArea
		local bridge = (subarea and subarea == "Bridges") or area == "Bridges"
		local docks = (subarea and subarea == "Docks") or area == "Guarded Docks" or area == "Unguarded Docks"
		local onBoat = MapCommon.OnWater and MapCommon.IsBoatFacet() and not bridge and not docks

		if not onBoat then
			
			-- sub area determined by the position on the map
			if (subarea and KnownAreas[area] and KnownAreas[area].SubAreas[subarea] and KnownAreas[area].SubAreas[subarea].bg and KnownAreas[area].SubAreas[subarea].bg ~= "") then
				if (PaperdollWindow.CurrentBG ~= KnownAreas[area].SubAreas[subarea].bg) then
					PaperdollWindow.CurrentBG = KnownAreas[area].SubAreas[subarea].bg
					DynamicImageSetTexture( windowName.."BGBG", KnownAreas[area].SubAreas[subarea].bg, 0, 0 )
				end
			
			-- bank
			elseif (subarea and subarea == "Banks") then
				PaperdollWindow.CurrentBG = "bankBG"
				DynamicImageSetTexture( windowName.."BGBG", "bankBG", 0, 0 )

			-- main area determined by the position on the map
			elseif (area and KnownAreas[area] and KnownAreas[area].MainBg and KnownAreas[area].MainBg ~= "") then
				if (PaperdollWindow.CurrentBG ~= KnownAreas[area].MainBg) then
					PaperdollWindow.CurrentBG = KnownAreas[area].MainBg
					DynamicImageSetTexture( windowName.."BGBG", KnownAreas[area].MainBg, 0, 0 )
				end

			-- random wilderness
			elseif (PaperdollWindow.CurrentBG ~= "wildBG") then
				PaperdollWindow.CurrentBG = "wildBG"
				DynamicImageSetTexture( windowName.."BGBG", "wildBG", 0, 0 )
			end

		-- the player is on the middle of the sea (on a boat)
		elseif (PaperdollWindow.CurrentBG ~= "seaBG") then
			PaperdollWindow.CurrentBG = "seaBG"
			DynamicImageSetTexture( windowName.."BGBG", "seaBG", 0, 0 )
		end

	else -- option disabled, the default black background will be applied
		PaperdollWindow.CurrentBG = "blackBG"
		DynamicImageSetTexture( windowName.."BGBG", "blackBG", 0, 0 )
	end
end

function PaperdollWindow.SwitchLabelTexture(id)

	-- do we have a valid ID?
	if not IsValidID(id) then
		
		-- scan all paperdolls
		for id, val in pairs(PaperdollWindow.OpenPaperdolls) do

			-- update the texture
			PaperdollWindow.switchTextureForID(id)
		end

	else -- single paperdoll update
		PaperdollWindow.switchTextureForID(id)
	end
end

function PaperdollWindow.Lock()

	-- invert the lock status
	PaperdollWindow.Locked = not PaperdollWindow.Locked 
	
	-- save lock status
	Interface.SaveSetting( "PdollWindowLocked", PaperdollWindow.Locked  )

	-- get the paperdoll ID
	local paperdollId = WindowGetId(WindowUtils.GetActiveDialog())

	-- get the paperdoll window name
	local windowName = "PaperdollWindow" .. paperdollId

	-- highlight the lock button
	ButtonSetPressedFlag(windowName .. "ToggleLock", PaperdollWindow.Locked)
end

function PaperdollWindow.CloseWindow()
	
	-- safety block to prevent window closing
	if PaperdollWindow.BlockClosing then
		PaperdollWindow.BlockClosing = false
		return
	end

	-- get the paperdoll ID
	local id = WindowGetId(WindowUtils.GetActiveDialog())

	-- is this the player ID?
	if (id == GetPlayerID()) then

		-- flag the player paperdoll as closed
		Interface.PaperdollOpen = false

		-- save the flag
		Interface.SaveSetting( "PaperdollOpen", Interface.PaperdollOpen)
	end

	-- close the paperdoll
	UO_DefaultWindow.CloseDialog()
end

function PaperdollWindow.Shutdown()

	-- get the paperdoll ID
	local paperdollId = WindowGetId(WindowUtils.GetActiveDialog())

	-- current paperdoll window name
	local windowName = "PaperdollWindow" .. paperdollId

	-- is this the player paperdoll?
	if paperdollId == GetPlayerID() then

		-- reset the BG settings, needs to be updated when the paperdoll will be open once again
		PaperdollWindow.CurrentBG = ""

		-- do we have to block the paperdoll?
		if not Interface.BlockThisPaperdoll[playerId] then

			-- save player paperdoll position
			WindowUtils.SaveWindowPosition(windowName, false, "pdollself")

			-- blocking the undress agent (in case has been activated), and removing the relative warning
			PaperdollWindow.Organize = false
			if (DoesWindowExist("UndressWarningDialog")) then
				DestroyWindow("UndressWarningDialog")
			end
		end

	else -- other characters paperdoll

		-- saving the position (only in case the paperdolls are not blocked and the paperdoll is not related to the player vendor window)
		if not (Interface.BlockThisPaperdoll[paperdollId] or Interface.Settings.BlockOthersPaperdoll) and paperdollId ~= PlayerVendor.MobileId then
			WindowUtils.SaveWindowPosition(windowName, false, "PaperdollOthers")
		end

		-- flag the player vendor paperdoll as closed
		if paperdollId ~= PlayerVendor.MobileId then
			PlayerVendor.PaperdollOpen = false
		end

		-- paperdoll has been blocked and close correctly and we can reset the flag
		Interface.BlockThisPaperdoll[paperdollId] = nil

		-- removing the items list for this paperdoll
		PaperdollWindow.ItemsList[paperdollId] = nil
	end

	-- reset the block flag for the current paperdoll
	Interface.BlockThisPaperdoll[paperdollId] = nil
		
	-- clear the item properties if the cursor was over a paperdoll item
	if (ItemProperties.GetCurrentWindow() == windowName) then
		ItemProperties.ClearMouseOverItem()
	end

	-- send to the server the close paperdoll message	
	ClosePaperdoll(paperdollId)

	-- clearing all the related arrays
	SnapUtils.SnappableWindows[windowName] = nil
	PaperdollWindow.OpenPaperdolls[paperdollId] = nil
	PaperdollWindow.PaperdollsName[paperdollId] = nil
end

function PaperdollWindow.OnMouseDrag(flags)

	-- get the paperdoll ID
	local paperdollId = WindowGetId(WindowUtils.GetActiveDialog())

	-- is this paperdoll tied to the player vendor window?
	if paperdollId == PlayerVendor.MobileId then
		return
	end

	-- current paperdoll window name
	local windowName = "PaperdollWindow" .. paperdollId

	-- is this the player ID?
	if paperdollId == GetPlayerID() then

		-- is the paperdoll locked?
		if not PaperdollWindow.Locked then

			-- pressing SHIFT allows to move the window without snapping
			if flags ~= WindowUtils.ButtonFlags.SHIFT then
				SnapUtils.StartWindowSnap(windowName, PaperdollWindow.WINDOWSCALE)
			end

			-- start moving the paperdoll
			WindowSetMoving(windowName, true)

		else -- stop moving the paperdoll
			WindowSetMoving(windowName, false)
		end
	end
end

function PaperdollWindow.UpdatePaperdoll(mobileId)

	-- current paperdoll window name
	local windowName = "PaperdollWindow" .. mobileId

	-- we must avoid to update hidden windows
	if not DoesWindowExist(windowName) or not WindowGetShowing(windowName) then
		return
	end

	-- get the paperdoll data
	local paperdollData = Interface.GetPaperdollData(mobileId)

	-- do we have the paperdoll data?
	if not paperdollData then
		return
	end

	-- filling the name at the bottom
	PaperdollWindow.UpdateName(mobileId)

	-- updating the paperdoll scale
	WindowUtils.LoadScale( windowName )

	-- initializing variables
	local race = GetMobileRace(mobileId)
	
	-- drawing the characer in the paperdoll
	PaperdollWindow.DrawCharacterTexture(mobileId, windowName, race)

	-- drawing basic slot images
	PaperdollWindow.initializeSlots(windowName, race, paperdollData)

	-- storing the item properties for comparison and other players stats
	ItemProperties.RegisterPaperdollProperties(mobileId)

	-- updating the durabilities
	PaperdollWindow.UpdateSlotsDurability(mobileId, windowName, paperdollData)
end

function PaperdollWindow.GetMouseSlotId()

	-- get the paperdoll ID
	local paperdollId = WindowGetId(WindowUtils.GetActiveDialog())

	-- current paperdoll window name
	local windowName = "PaperdollWindow" .. paperdollId

	-- current slot ID
	local slotId = GetPaperdollObject(paperdollId, WindowGetScale(windowName))

	return paperdollId, slotId
end

function PaperdollWindow.OnPaperdollTextureLButtonDown(flags)

	-- get the current mouse over slot and paperdoll ID
	local paperdollId, slotId = PaperdollWindow.GetMouseSlotId()
	
	-- do we have a valid item?
	if not IsValidID(slotId) then	
		return
	end

	-- do we have a cursor target?
	if DoesPlayerHasCursorTarget() then

		-- target the item
        HandleSingleLeftClkTarget(slotId)
		return
	end
	
	-- is CONTROL pressed and the player own the item?
	if flags == WindowUtils.ButtonFlags.CONTROL and DoesPlayerHaveItem(slotId) then

		-- create a blockbar
		local blockBar = HotbarSystem.SpawnNewHotbar(_, 1, true)
			
		-- drag the item into the blockbar
		HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_USE_ITEM, slotId, GetItemIcon(slotId), blockBar,  1)
			
		-- forcing the blockbar to follow the mouse cursor
		WindowUtils.FollowMouseCursor("Hotbar" .. blockBar, Hotbar.BUTTON_SIZE, Hotbar.BUTTON_SIZE, -30, -15, false, true, false)

		-- setting the window movable
		WindowSetMoving("Hotbar" .. blockBar, true)

	else -- dragging the item
		DragSlotSetObjectMouseClickData(slotId, SystemData.DragSource.SOURCETYPE_PAPERDOLL)
	end
end

function PaperdollWindow.OnPaperdollTextureLButtonUp()

	-- get the current mouse over slot and paperdoll ID
	local paperdollId, slotId = PaperdollWindow.GetMouseSlotId()

	-- are we dragging an item?
	if SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM then

		-- do we have a valid item?
		if IsValidID(slotId) then

			-- drop the item INTO the equipped item
			DragSlotDropObjectToPaperdollEquipment(slotId)

		else -- equip the item
			DragSlotDropObjectToPaperdoll(paperdollId)
		end

		-- flag to force re-check durabilities
		Interface.AddTodoList({name = "paperdoll delayed durability check", func = function() PaperdollWindow.GotDamage = true end, time = Interface.TimeSinceLogin + 1})
	end
end

function PaperdollWindow.OnPaperdollTextureLButtonDblClk()

	-- get the current mouse over slot and paperdoll ID
	local paperdollId, slotId = PaperdollWindow.GetMouseSlotId()

	-- do we have a valid item?
	if not IsValidID(slotId) then	
		return
	end

	-- use the item
	UserActionUseItem(slotId, false)
end

function PaperdollWindow.OnPaperdollTextureRButtonDown()

	-- get the current mouse over slot and paperdoll ID
	local paperdollId, slotId = PaperdollWindow.GetMouseSlotId()

	-- do we have a valid item?
	if IsValidID(slotId) then	

		-- store the paperdoll menu request
		PaperdollWindow.MenuRequest = slotId

		-- get the context menu
		RequestContextMenu(slotId)
	end
end
			
function PaperdollWindow.OnPaperdollTextureMouseOver()

	-- get the current mouse over slot and paperdoll ID
	local paperdollId, slotId = PaperdollWindow.GetMouseSlotId()
	
	-- do we have a valid paperdoll ID?
	if IsValidID(paperdollId) then	

		-- set the current active paperdoll ID
		PaperdollWindow.ActivePaperdollImage = paperdollId
	end
end

function PaperdollWindow.OnPaperdollTextureMouseEnd()

	-- reset the current over data
	PaperdollWindow.ActivePaperdollImage = 0
	PaperdollWindow.ActivePaperdollObject = 0
	
	-- clear the item properties
	ItemProperties.ClearMouseOverItem()
end

function PaperdollWindow.SlotLButtonDown(flags)

	-- current slot ID
	local slotIndex = WindowGetId(SystemData.ActiveWindow.name)

	-- current paperdoll ID
	local paperdollId = WindowGetId(WindowUtils.GetActiveDialog())

	-- make sure we have the paperdoll data
	if not IsValidID(paperdollId) or not slotIndex then
		return
	end

	-- current item ID
	local slotId = WindowData.Paperdoll[paperdollId][slotIndex].slotId
	
	-- do we have a valid item?
	if not IsValidID(slotId) then	
		return
	end

	-- do we have a cursor target?
	if DoesPlayerHasCursorTarget() then

		-- target the item
		HandleSingleLeftClkTarget(slotId)		

		return
	end

	-- is CONTROL pressed and the player own the item?
	if flags == WindowUtils.ButtonFlags.CONTROL and DoesPlayerHaveItem(slotId) then

		-- create a blockbar
		local blockBar = HotbarSystem.SpawnNewHotbar(_, 1, true)
			
		-- drag the item into the blockbar
		HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_USE_ITEM, slotId, GetItemIcon(slotId), blockBar,  1)
		
		-- forcing the blockbar to follow the mouse cursor
		WindowUtils.FollowMouseCursor("Hotbar" .. blockBar, Hotbar.BUTTON_SIZE, Hotbar.BUTTON_SIZE, -30, -15, false, true, false)

		-- setting the window movable
		WindowSetMoving("Hotbar" .. blockBar, true)

	else -- dragging the item
		DragSlotSetObjectMouseClickData(slotId, SystemData.DragSource.SOURCETYPE_PAPERDOLL)
	end
end

function PaperdollWindow.SlotLButtonUp()

	-- current slot ID
	local slotIndex = WindowGetId(SystemData.ActiveWindow.name)

	-- current paperdoll ID
	local paperdollId = WindowGetId(WindowUtils.GetActiveDialog())

	-- do we have the paperdoll data?
	if not WindowData.Paperdoll[PaperdollId] or not WindowData.Paperdoll[PaperdollId][SlotNum] then
		return
	end

	-- current item ID
	local objectId = WindowData.Paperdoll[paperdollId][slotIndex].slotId
	
	-- are we dragging something?
	if (SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM) then

		-- do we have a valid object ID?
		if IsValidID(objectId) then

			-- drop the item INTO the equipped item
			DragSlotDropObjectToPaperdollEquipment(objectId)

		else -- equip the item
			DragSlotDropObjectToPaperdoll(paperdollId)
		end

		-- flag to force re-check durabilities
		Interface.AddTodoList({name = "paperdoll delayed durability check", func = function() PaperdollWindow.GotDamage = true end, time = Interface.TimeSinceLogin + 1})
	end
end

function PaperdollWindow.SlotLButtonDblClk()
	
	-- current paperdoll window
    local dialog = WindowUtils.GetActiveDialog()

	-- current paperdoll ID
	local PaperdollId = WindowGetId(dialog)

	-- current slot ID
	local SlotNum = WindowGetId(SystemData.ActiveWindow.name)

	-- do we have the paperdoll data?
	if not WindowData.Paperdoll[PaperdollId] or not WindowData.Paperdoll[PaperdollId][SlotNum] then
		return
	end

	-- current item ID
	local SlotId = WindowData.Paperdoll[PaperdollId][SlotNum].slotId	
	
	-- do we have a valid item?
	if not IsValidID(SlotId) then	
		return
	end

	-- use the item
	UserActionUseItem(SlotId, false)
end

function PaperdollWindow.SlotRButtonDown()
	
	-- current slot ID
	local slotIndex = WindowGetId(SystemData.ActiveWindow.name)

	-- current paperdoll ID
	local paperdollId = WindowGetId(WindowUtils.GetActiveDialog())

	-- current item ID
	local slotId = WindowData.Paperdoll[paperdollId][slotIndex].slotId

	-- is this the player paperdoll and we have a valid item ID?
	if paperdollId == GetPlayerID() and IsValidID(slotId) then
		
		-- store the paperdoll menu request
		PaperdollWindow.MenuRequest = slotId

		-- prevent the paperdoll from closing
		PaperdollWindow.BlockClosing = true

		-- get the context menu
		RequestContextMenu(slotId)
	end
end

function PaperdollWindow.ItemMouseOver()
	
	-- current paperdoll window
    local dialog = WindowUtils.GetActiveDialog()

	-- current paperdoll ID
	local PaperdollId = WindowGetId(dialog)

	-- current slot ID
	local SlotNum = WindowGetId(SystemData.ActiveWindow.name)

	-- do we have the paperdoll data?
	if not WindowData.Paperdoll[PaperdollId] or not WindowData.Paperdoll[PaperdollId][SlotNum] then
		return
	end

	-- current item ID
	local SlotId = WindowData.Paperdoll[PaperdollId][SlotNum].slotId	

	-- initialize item data variable
	local itemData

	-- initialize properties title
	local slotTitle

	-- get mobile race
	local race = GetMobileRace(PaperdollId)
	
	-- do we have a valid item?
	if IsValidID(SlotId) then

		-- is this a different item from the one it's showing?
		if SlotId ~= WindowGetId("ItemProperties") then

			-- reset the item properties array
			ItemProperties.ResetWindowDataPropertiesFull()
		end

		-- initialize properties data
		itemData = {
			windowName = dialog .. "ItemSlotButton" .. SlotNum,
			itemId = SlotId,
			itemType = WindowData.ItemProperties.TYPE_ITEM,
			detail = ItemProperties.DETAIL_LONG,
			data = WindowData.Paperdoll[PaperdollId][SlotNum],
			paperdollId = PaperdollId,
			paperdoll = SlotNum
		}

	else -- description for empty slots
		local EmptySlotBodyText		
		
		-- gargoyle disabled slots have no text to show
		if PaperdollWindow.GargoyleDisabledSlots[SlotNum] and race == PaperdollWindow.GARGOYLE then 
			slotTitle = L""

		 -- gargoyle specific slot title
		elseif PaperdollWindow.GargoyleSpecialSlots[index] and race == PaperdollWindow.GARGOYLE then
			slotTitle =	GetStringFromTid( PaperdollWindow.BlankSlot[SlotNum].SlotNameTidTwo)	

		else -- title for every other slot
			slotTitle =	GetStringFromTid( PaperdollWindow.BlankSlot[SlotNum].SlotNameTid )	
		end			
		
		-- description for the slot
		if (PaperdollWindow.BlankSlot[SlotNum].SlotDescTid and slotTitle ~= L"") then			
			EmptySlotBodyText = GetStringFromTid(  PaperdollWindow.BlankSlot[SlotNum].SlotDescTid )

		else -- no title and no description either
			EmptySlotBodyText = L""			
		end
		
		-- generating the item properties for the text we created
		itemData = {
			windowName = dialog .. "ItemSlotButton" .. SlotNum,
			itemId = SlotNum,
			itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
			binding = L"",
			detail = ItemProperties.DETAIL_LONG,
			title = slotTitle,
			body = EmptySlotBodyText,
		}	
	end
	
	-- activating the item properties window
	ItemProperties.SetActiveItem(itemData)
end

function PaperdollWindow.BlockPaperdolls(timePassed)

	-- scan all open paperdolls
	for id, _ in pairs(PaperdollWindow.OpenPaperdolls) do

		-- closing the hidden paperdolls
		if (Interface.Settings.BlockOthersPaperdoll and id ~= GetPlayerID()) then

			-- destroy the paperdoll
			DestroyWindow("PaperdollWindow" .. id)

			-- remove the paperdoll data
			PaperdollWindow.OpenPaperdolls[id] = nil
			
		-- context menu call to open a paperdoll without showing it
		elseif Interface.BlockThisPaperdoll[id] then
		
			-- destroy the paperdoll
			DestroyWindow("PaperdollWindow" .. id)

			-- remove the paperdoll data
			PaperdollWindow.OpenPaperdolls[id] = nil
			
			-- did we have a context menu call for this paperdoll?
			if Interface.BlockThisPaperdollMenuCall then
				Interface.AddTodoList({name = "open paperdoll context menu call", func = function() ContextMenu.RequestContextAction(id, Interface.BlockThisPaperdollMenuCall) Interface.BlockThisPaperdollMenuCall = 0 end, time = Interface.TimeSinceLogin + 2})
			end
		end
	end
end

function PaperdollWindow.OnUpdate(timePassed)
	
	-- do we have the cursor over the paperdoll image?
	if IsValidID(PaperdollWindow.ActivePaperdollImage) then

		-- paperdoll window name
		local windowName = "PaperdollWindow" .. PaperdollWindow.ActivePaperdollImage

		-- is the paperdoll open?
		if not DoesWindowExist(windowName) then

			-- reset the active image ID
			PaperdollWindow.ActivePaperdollImage = 0

			return
		end

		-- get the selected slot from the texture image (NOT THE SLOTS)
		local SlotId = GetPaperdollObject(PaperdollWindow.ActivePaperdollImage, WindowGetScale(windowName))
		
		-- is the item ID changed?
		if IsValidID(SlotId) and (PaperdollWindow.ActivePaperdollObject == 0 or PaperdollWindow.ActivePaperdollObject ~= SlotId) then
			
			-- clearing the current item properties if it's another item
		    if SlotId ~= WindowGetId("ItemProperties") then

				-- reset the item properties array
				ItemProperties.ResetWindowDataPropertiesFull()
			end
			
			-- item ID of the mouse over object
			PaperdollWindow.ActivePaperdollObject = SlotId
			
			-- get the slot ID
			local slotIndex = PaperdollWindow.GetSlotIdByItemId(SlotId, PaperdollWindow.ActivePaperdollImage)

			-- initialize the item properties data for the item
			local itemData = { windowName = windowName .. "Texture",
								itemId = SlotId,
								itemType = WindowData.ItemProperties.TYPE_ITEM,
								detail = ItemProperties.DETAIL_LONG }
			
			-- showing the item properties
			ItemProperties.SetActiveItem(itemData)

		-- we're pointing in a blank spot of the paperdoll texture so we clear the item properties
		elseif not IsValidID(SlotId)  and PaperdollWindow.ActivePaperdollObject ~= 0 then

			-- reset the mouse over item ID
			PaperdollWindow.ActivePaperdollObject = 0

			-- clear the item properties
			ItemProperties.ClearMouseOverItem()
		end
	end
end

function PaperdollWindow.ToggleInventoryWindow()
	
	-- current paperdoll ID
	local id = WindowGetId(WindowUtils.GetActiveDialog())

	-- paperdoll window name
	local windowName = "PaperdollWindow" .. id

	-- backpack button window name
	local inventoryName = windowName .. "ToggleInventory"

	-- the inventory button is disabled (the target has no inventory)
	if ButtonGetDisabledFlag(inventoryName) then
		return
	end

	-- do we have a cursor target?
	if DoesPlayerHasCursorTarget() then

		-- target the player backpack
		HandleSingleLeftClkTarget(ContainerWindow.PlayerBackpack)

		-- highlight the inventory button
		ButtonSetPressedFlag(inventoryName, true)

	-- are we dragging an item?
	elseif SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM then

		-- drop the item in the player backpack
	    DragSlotDropObjectToObject(GetPlayerID())

		-- highlight the inventory button
	    ButtonSetPressedFlag(inventoryName, true)
	
	else
		-- get the backpack ID
		local backpackId = GetBackpackID(id)

		-- is this the player paperdoll?
		if id == GetPlayerID() then

			-- toggle the player backpack
			Actions.ToggleInventoryWindow()	

		-- do we have a valid backpack ID?
		elseif IsValidID(backpackId) then

			-- backpack window name
			local backpackName = "ContainerWindow_" .. backpackId

			-- is the container already open?
			if (DoesWindowExist(backpackName) and WindowGetShowing(backpackName)) then
				
				-- close the container
				DestroyWindow(backpackName)

			else -- open/pickpocket the backpack
				UserActionUseItem(backpackId, false)
			end
			
			-- highlight the button if the backpack is open
			Interface.AddTodoList({name = "open backpack delayed button highlight", func = function() ButtonSetPressedFlag(windowName .. "ToggleInventory", (DoesWindowExist(backpackName) and WindowGetShowing(backpackName))) end, time = Interface.TimeSinceLogin + 0.5})
		end
	end		
end

function PaperdollWindow.ToggleProfile()

	-- get the paperdoll ID
	local paperdollId = WindowGetId(WindowUtils.GetActiveDialog())

	-- only player have profiles
	if paperdollId ~= GetPlayerID() and not IsPlayer(paperdollId) then
		return
	end

	-- current paperdoll window name
	local windowName = "PaperdollWindow" .. paperdollId	

	-- is the profile window open?
	local isShowing = WindowGetShowing("ProfileWindow")

	-- the profile is closed
	if not isShowing then

		-- set the active profile ID
		SystemData.ActiveObject.Id = paperdollId

		-- setting the mobile ID in the profile window
		ProfileWindow.ProfileId = paperdollId

		-- update the profile
		ProfileWindow.UpdateProfile()
	end

	-- invert the showing status
	isShowing = not isShowing

	-- toggle the profile window
	WindowSetShowing("ProfileWindow", isShowing)
	
	-- the edit area is only visible for the player
	WindowSetShowing(windowName .. "ProfileEdit", paperdollId == GetPlayerID())

	-- is the profile window visible?
	if isShowing then
		
		-- reset the account age text
		LabelSetText(ProfileWindow.WindowName .. "Age", L"")

		-- reset the player name and title
		if (LabelGetText(windowName .. "TitleName") ~= nil) then
			LabelSetText(ProfileWindow.WindowName .. "CharName", LabelGetText(windowName .. "TitleName"))
		end

		-- load the window position
		WindowUtils.RestoreWindowPosition(ProfileWindow.WindowName)

		-- setting the mobile ID in the profile window
		ProfileWindow.ProfileId = paperdollId

		-- update the profile
		ProfileWindow.UpdateProfile()
		
	else -- save the profile text and close the window
		ProfileWindow.Close()
	end
end

function PaperdollWindow.OnMouseOverToggleCharacterAbilities()

	-- current tooltip text
	local text = GetStringFromTid(1112228) -- Character Abilities

	-- create the abilities tooltip
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, text)
end

function PaperdollWindow.OnMouseOverToggleCharacterSheet()

	-- current tooltip text
	local text = GetStringFromTid(1077437) -- Character Sheet

	-- create character sheet tooltip
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, text)
end

function PaperdollWindow.ToggleCharacterSheet()

	-- current paperdoll ID
	local id = WindowGetId(WindowUtils.GetActiveDialog())

	-- current paperdoll window name
	local windowName = "PaperdollWindow" .. id

	-- character sheet button name
	local characterSheetName = windowName .. "ToggleCharacterSheet"

	-- is the button disabled?
	if ButtonGetDisabledFlag(characterSheetName) then
		return
	end

	-- is this the player paperdoll?
	if id == GetPlayerID() then

		-- toggle the character sheet
		ToggleWindowByName("CharacterSheet", characterSheetName)
	end
end

function PaperdollWindow.ToggleCharacterAbilities()

	-- get the paperdoll ID
	local id = WindowGetId(WindowUtils.GetActiveDialog())

	-- current paperdoll window name
	local windowName = "PaperdollWindow" .. id

	-- character abilities button name
	local characterAbilitiesName = windowName .. "ToggleCharacterAbilities"

	-- is the button disabled?
	if ButtonGetDisabledFlag(characterAbilitiesName) then
		return
	end

	-- is this the player paperdoll?
	if id == GetPlayerID() then

		-- toggle the character abilities
		ToggleWindowByName("CharacterAbilities", characterAbilitiesName)
	end
end

function PaperdollWindow.ToggleProfileTooltip()
	
	-- create the profile button tooltip
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(3000179)) -- Profile
end

function PaperdollWindow.UpdateCharProfile(id)

	-- is this the active profile?
    if WindowData.CharProfile and id == WindowData.CharProfile.Id then
	
		-- profile window name
		local windowName = ProfileWindow.WindowName 
       
	   -- is this the player ID?
		if id == GetPlayerID() then
		
			-- enabling the writable are for the player and hide the readonly area
			WindowSetShowing(ProfileWindow.WindowName .. "ProfileView", false)
			WindowSetShowing(ProfileWindow.WindowName .. "ProfileEdit", true)	
			
			-- loading the player profile text
			TextEditBoxSetText(windowName .."ProfileEditScrollWChildText", WindowData.CharProfile.Info)
            
			-- acquiring the account age
			local months = tostring(wstring.match(WindowData.CharProfile.Age, L"%d+"))
			
			-- if we've been able to determine the age, we start to format the value
			if tonumber(months) then

				-- get the months amount
				local age = tonumber(months)

				-- counting the account years
				local year = math.floor(age / 12)

				-- counting the months (minus the months used for the years)
				local months = age - (year * 12)
				
				-- clear the TID text from \n
				finalText = GetStringFromTid(1154917) -- This account is:\\n
				finalText = wstring.sub(finalText, 1, -4) .. L"\n"
				
				-- are the number of years > 0?
				if year > 0 then

					-- are the number of months > 0?
					if months > 0 then
						finalText = finalText .. ReplaceTokens(GetStringFromTid(1154918), {towstring(year), towstring(months)}) -- ~1_YEARS~ years and ~2_MONTHS~ months old.

					else
						finalText = finalText .. ReplaceTokens(GetStringFromTid(1154919), {towstring(year)}) -- ~1_YEARS~ years old.
					end

				else -- show only the months
					finalText = finalText  .. ReplaceTokens(GetStringFromTid(1154920), {towstring(months)}) -- ~1_MONTHS~ months old.
				end

			else -- we don't know the account age
				finalText = GetStringFromTid(1155426) -- Cannot determine this account's age.
			end
			
			-- adding the age text to the profile
			LabelSetText(windowName .. "Age", finalText)

		else -- enabling the readonly area and disabling the writable area
			WindowSetShowing(ProfileWindow.WindowName.."ProfileEdit", false)		
			WindowSetShowing(ProfileWindow.WindowName.."ProfileView", true)

			-- loading the character profile
			LabelSetText(windowName.."ProfileViewScrollChildText", WindowData.CharProfile.Info)

			-- can't see the age if it's not the player
			LabelSetText(windowName .. "Age", L"")
			
			-- updating the scroll area
			ScrollWindowUpdateScrollRect(windowName .. "ProfileViewScroll")
		end

		-- flagging the profile as loaded
		ProfileWindow.ProfileLoaded = true
		ProfileWindow.Retries = 0

    else -- the profile has not been loaded, we'll have to retry

		-- enabling the readonly area and disabling the writable area for now...
		WindowSetShowing(ProfileWindow.WindowName.."ProfileEdit",false)		
		WindowSetShowing(ProfileWindow.WindowName.."ProfileView",true)

		-- set the profile as NOT loaded
		ProfileWindow.ProfileLoaded = false
    end
end

function PaperdollWindow.OnMouseOverToggleInventory()

	-- current window name
	local buttonName = SystemData.ActiveWindow.name

	-- current paperdoll ID
	local paperdollId = WindowGetId(buttonName)
	
	-- is this the player paperdoll?
	if paperdollId == GetPlayerID() then

		-- show the backpack properties
		ItemProperties.OnPlayerBackpackMouseover()
	end
end

-- Scan the properties to update the character sheet
function PaperdollWindow.ScanProperties()

	-- initialize player ID
	local playerId = GetPlayerID()

	-- initializing the paperdoll data
	local paperdollData = Interface.GetPaperdollData(playerId)
	if not paperdollData then
		return
	end

	-- do we have the item properties for the player's items?
	if not PaperdollWindow.ItemsProps[playerId] then
	
		-- storing the item properties for comparison and other players stats
		ItemProperties.RegisterPaperdollProperties(playerId)
	end
	
	-- updating the slayers buff/debuff
	PaperdollWindow.UpdateSlayersBuff(paperdollData, playerId)

	-- loading weapon specific properties
	PaperdollWindow.GetWeaponsProperties(paperdollData, playerId)

	-- loading the rest of the properties
	PaperdollWindow.GetEquipmentProperties(paperdollData, playerId)
end

function PaperdollWindow.ConverttoYesNoTID(boolValue)
	if (boolValue) then
		return GetStringFromTid(1046362) -- Yes
	else
		return GetStringFromTid(1046363) -- No
	end
end

function PaperdollWindow.GetEquipmentProperties(paperdollData, paperdollId)
	local nightsight = WindowData.PlayerStatus["Race"] == PaperdollWindow.ELF  -- night sight is always active for elves
	local medable = true -- medable by default, to be verified for each piece
	local hphya = 0 -- hit physical area
	local hfira = 0 -- hit fire area
	local hcola = 0 -- hit cold area
	local hpoia = 0 -- hit poison area
	local henea = 0 -- hit energy area
	
	local hf = 0 -- hit fireball
	local hh = 0 -- hit arm
	local hl = 0 -- hit lightning
	local hma = 0 -- hit magic arrow
	local hd = 0 -- hit dispel
	local hc = 0 -- hit curse
	
	local vel = 0 -- velocity
	local splinter = 0 -- splinter weapon
	
	local hll = 0 -- hit life leech
	local hml = 0 -- hit mana leech
	local hsl = 0 -- hit stamina leech
	
	local hmd = 0 -- hit mana drain
	local hfat = 0 -- hit fatigue

	local totalCF = 0 -- casting focus
	local totalSC = 0 -- soul charge
	
	local totalDE = 0 -- DamageEater
	local totalKE = 0 -- KineticEater
	local totalFE = 0 -- FireEater
	local totalCE = 0 -- ColdEater
	local totalPE = 0 -- PoisonEater
	local totalEE = 0 -- EnergyEater
	
	local totalKR = 0 -- KineticResonance
	local totalFR = 0 -- FireResonance
	local totalCR = 0 -- ColdResonance 
	local totalPR = 0 -- PoisonResonance
	local totalER = 0 -- EnergyResonance

	local hla = {}
	local hld = {}

	-- scan the whole equipment
	for index = 1, paperdollData.numSlots  do

		-- current slot item ID
		local objectId = paperdollData[index].slotId

		-- get the item type
		local objectType = GetItemType(objectId)

		-- do we have a valid object ID?
		if IsValidID(objectId) then

			if not nightsight then
				nightsight = ItemProperties.DoesItemHasProperty( objectId, 1015168, paperdollId, index )  -- Night Sight
			end

			-- if 1 piece is not medable, then the whole item set is considered not medable.
			if PaperdollWindow.ArmorSlotsList[index] and medable then
				local mageArmor = ItemProperties.DoesItemHasProperty( objectId, 1060437, paperdollId, index ) -- mage armor

				-- if we don't have the mage armor property, we check if it's a medable type of item
				if not mageArmor then
					medable = ItemPropertiesInfo.IsMedable(objectType)
				end
			end

			-- getting hit lower attack
			local hasHLA, value = ItemProperties.DoesItemHasProperty( objectId, 1060424, paperdollId, index ) -- hit lower attack
			if hasHLA then
				table.insert(hla, SecondsValueToNumber(value[1]))
			end

			-- getting hit lower defense
			local hasHLD, value = ItemProperties.DoesItemHasProperty( objectId, 1060425, paperdollId, index ) -- hit lower defense
			if hasHLD then
				table.insert(hld, SecondsValueToNumber(value[1]))
			end

			splinter = splinter + ItemProperties.GetPropertyValue( objectId, 1112857, true, paperdollId, index ) -- splintering weapon
			hf = hf + ItemProperties.GetPropertyValue( objectId, 1060420, true, paperdollId, index ) -- hit fireball
			hh = hh + ItemProperties.GetPropertyValue( objectId, 1060421, true, paperdollId, index ) -- hit harm
			hl = hl + ItemProperties.GetPropertyValue( objectId, 1060423, true, paperdollId, index ) -- hit lightning
			hma = hma + ItemProperties.GetPropertyValue( objectId, 1060426, true, paperdollId, index ) -- hit magic arrow
			hd = hd + ItemProperties.GetPropertyValue( objectId, 1060417, true, paperdollId, index ) -- hit dispel
			hc = hc + ItemProperties.GetPropertyValue( objectId, 1113712, true, paperdollId, index ) -- hit curse
			vel = vel + ItemProperties.GetPropertyValue( objectId, 1072793, true, paperdollId, index ) -- Velocity
			hll = hll + ItemProperties.GetPropertyValue( objectId, 1060422, true, paperdollId, index ) -- hit life leech
			hml = hml + ItemProperties.GetPropertyValue( objectId, 1060427, true, paperdollId, index ) -- hit mana leech
			hsl = hsl + ItemProperties.GetPropertyValue( objectId, 1060430, true, paperdollId, index ) -- hit stamina leech
			hmd = hmd + ItemProperties.GetPropertyValue( objectId, 1113699, true, paperdollId, index ) -- hit mana drain
			hfat = hfat + ItemProperties.GetPropertyValue( objectId, 1113700, true, paperdollId, index ) -- hit fatigue
			hphya = hphya + ItemProperties.GetPropertyValue( objectId, 1060428, true, paperdollId, index ) -- hit physical area 
			hfira = hfira + ItemProperties.GetPropertyValue( objectId, 1060419, true, paperdollId, index ) -- hit fire area
			hcola = hcola + ItemProperties.GetPropertyValue( objectId, 1060416, true, paperdollId, index ) -- hit cold area
			hpoia = hpoia + ItemProperties.GetPropertyValue( objectId, 1060429, true, paperdollId, index ) -- hit poison area
			henea = henea + ItemProperties.GetPropertyValue( objectId, 1060418, true, paperdollId, index ) -- hit energy area
			totalCF = totalCF + ItemProperties.GetPropertyValue( objectId, 1113696, true, paperdollId, index ) -- Casting Focus
			totalSC = totalSC + ItemProperties.GetPropertyValue( objectId, 1113630, true, paperdollId, index ) -- Soul Charge
			totalDE = totalDE + ItemProperties.GetPropertyValue( objectId, 1113598, true, paperdollId, index ) -- Damage Eater
			totalKE = totalKE + ItemProperties.GetPropertyValue( objectId, 1113597, true, paperdollId, index ) -- Kinetic Eater
			totalFE = totalFE + ItemProperties.GetPropertyValue( objectId, 1113593, true, paperdollId, index ) -- Fire Eater
			totalCE = totalCE + ItemProperties.GetPropertyValue( objectId, 1113594, true, paperdollId, index ) -- Cold Eater
			totalPE = totalPE + ItemProperties.GetPropertyValue( objectId, 1113595, true, paperdollId, index ) -- Poison Eater
			totalEE = totalEE + ItemProperties.GetPropertyValue( objectId, 1113596, true, paperdollId, index ) -- Energy Eater
			totalKR = totalKR + ItemProperties.GetPropertyValue( objectId, 1113695, true, paperdollId, index ) -- Kinetic Resonance
			totalFR = totalFR + ItemProperties.GetPropertyValue( objectId, 1113691, true, paperdollId, index ) -- Fire Resonance
			totalCR = totalCR + ItemProperties.GetPropertyValue( objectId, 1113692, true, paperdollId, index ) -- Cold Resonance
			totalPR = totalPR + ItemProperties.GetPropertyValue( objectId, 1113693, true, paperdollId, index ) -- Poison Resonance
			totalER = totalER + ItemProperties.GetPropertyValue( objectId, 1113694, true, paperdollId, index ) -- Energy Resonance
		end
	end

	-- filling the character sheet array
	PaperdollWindow.GetHitLowerAttackChance(hla)
	PaperdollWindow.GetHitLowerDefenseChance(hld)

	-- passive casting focus from inscription
	local skillLevel = GetSkillValue(SkillsWindow.SkillsID.INSCRIPTION, false)
	local inscribe = math.floor(skillLevel - 50 ) / 10
	if (inscribe < 0) then
		inscribe = 0
	end

	-- update the item properties for the player
	WindowData.PlayerStatus["NightSight"] = PaperdollWindow.ConverttoYesNoTID(nightsight)
	WindowData.PlayerStatus["Medable"] = PaperdollWindow.ConverttoYesNoTID(medable)
	WindowData.PlayerStatus["SplinteringWeapon"] = splinter
	WindowData.PlayerStatus["HitHarm"] = hh
	WindowData.PlayerStatus["HitDispel"] = hd 
	WindowData.PlayerStatus["HitCurse"] = hc
	WindowData.PlayerStatus["HitLifeLeech"] = hll
	WindowData.PlayerStatus["HitManaLeech"] = hml
	WindowData.PlayerStatus["HitStaminaLeech"] = hsl
	WindowData.PlayerStatus["HitManaDrain"] = hmd
	WindowData.PlayerStatus["HitFatigue"] = hfat
	WindowData.PlayerStatus["Velocity"] = vel
	WindowData.PlayerStatus["HitFireball"] = hf
	WindowData.PlayerStatus["HitMagicArrow"] = hma
	WindowData.PlayerStatus["HitLightning"] = hl
	WindowData.PlayerStatus["HitPhysicalArea"] = hphya
	WindowData.PlayerStatus["HitFireArea"] = hfira
	WindowData.PlayerStatus["HitColdArea"] = hcola
	WindowData.PlayerStatus["HitPoisonArea"] = hpoia
	WindowData.PlayerStatus["HitEnergyArea"] = henea
	WindowData.PlayerStatus["KineticResonance"] = totalKR
	WindowData.PlayerStatus["FireResonance"] = totalFR
	WindowData.PlayerStatus["ColdResonance"] = totalCR
	WindowData.PlayerStatus["PoisonResonance"] = totalPR
	WindowData.PlayerStatus["EnergyResonance"] = totalER
	WindowData.PlayerStatus["DamageEater"] = totalDE
	WindowData.PlayerStatus["KineticEater"] = totalKE
	WindowData.PlayerStatus["FireEater"] = totalFE
	WindowData.PlayerStatus["ColdEater"] = totalCE
	WindowData.PlayerStatus["PoisonEater"] = totalPE
	WindowData.PlayerStatus["EnergyEater"] = totalEE
	WindowData.PlayerStatus["CastingFocus"] = totalCF + inscribe
	WindowData.PlayerStatus["SoulCharge"] = totalSC
end

function PaperdollWindow.GetWeaponsProperties(paperdollData, paperdollId)

	-- initialize the flags
	local reactPara, battleLust, bloodDrink, balanced, sc, scH = false

	-- initialize the weapon speed
	local speed = 0

	-- scan the weapons slots
	for index, _ in pairs(PaperdollWindow.WeaponSlots) do

		-- get the slot object ID
		local objectId = paperdollData[index].slotId

		-- do we have a valid object ID?
		if IsValidID(objectId) then
			
			if not reactPara then
				reactPara = ItemProperties.DoesItemHasProperty( objectId, 1112364, paperdollId, index, paperdollId, index ) -- reactive paralyze
			end

			if not battleLust then
				battleLust = ItemProperties.DoesItemHasProperty( objectId, 1113710, paperdollId, index ) -- Battle Lust
			end

			if not bloodDrink then
				bloodDrink = ItemProperties.DoesItemHasProperty( objectId, 1113591, paperdollId, index ) -- Blood Drinker
			end

			if not balanced then
				balanced = ItemProperties.DoesItemHasProperty( objectId, 1072792, paperdollId, index ) -- balanced
			end

			-- getting weapon speed
			local hasSpeed, value = ItemProperties.DoesItemHasProperty( objectId, 1061167, paperdollId, index ) -- weapon speed
			if speed == 0 and hasSpeed then
				speed = SecondsValueToNumber(value[1])
			end

			if hasSpeed then -- weapon
				sc = ItemProperties.DoesItemHasProperty( objectId, 1060482, paperdollId, index ) -- spell channeling
			
			else -- shield
				scH = ItemProperties.DoesItemHasProperty( objectId, 1060482, paperdollId, index ) -- spell channeling
			end
		end
	end

	-- filling the character sheet array
	PaperdollWindow.GetPlayerSwingSpeed(speed)

	-- update the item properties for the player
	WindowData.PlayerStatus["ReactiveParalyze"] = PaperdollWindow.ConverttoYesNoTID(reactPara)
	WindowData.PlayerStatus["BattleLust"] = PaperdollWindow.ConverttoYesNoTID(battleLust)
	WindowData.PlayerStatus["BloodDrinker"] = PaperdollWindow.ConverttoYesNoTID(bloodDrink)
	WindowData.PlayerStatus["Balanced"] = PaperdollWindow.ConverttoYesNoTID(balanced)
	WindowData.PlayerStatus["SpellChannelingW"] = PaperdollWindow.ConverttoYesNoTID(sc)
	WindowData.PlayerStatus["SpellChannelingS"] = PaperdollWindow.ConverttoYesNoTID(scH)
end

function PaperdollWindow.GetActiveSlayersOnItem(objectId, slayerToRemove, paperdollId, index)

	-- is this a valid object ID?
	if not IsValidID(objectId) then

		-- remove the slayer
		return slayerToRemove
	end

	-- scan all slayers
	for tid, data in pairs(ItemPropertiesInfo.Slayers) do

		-- does the item has the slayer properties?
		if ItemProperties.DoesItemHasProperty( objectId, tid, paperdollId, index) then
			
			-- if the slayer was in the removal list, we must stop it
			if slayerToRemove[tid] then
				slayerToRemove[tid] = nil
			end

			-- slayer or super slayer buff?
			if data.super then
				Interface.ActiveSuperSlayers[tid] = data.buffId
			else
				Interface.ActiveSlayers[tid] = data.buffId
			end

			-- opposite slayer buff
			if data.opposite then
				Interface.ActiveOppositeSlayers[data.opposite] = ItemPropertiesInfo.Slayers[data.opposite].debuffId
			end
			if data.opposite2 then
				Interface.ActiveOppositeSlayers[data.opposite2] = ItemPropertiesInfo.Slayers[data.opposite].debuffId
			end
		end
	end

	-- remove the slayer
	return slayerToRemove
end

function PaperdollWindow.UpdateSlayersBuff(paperdollData, paperdollId)

	-- adding all the slayers to the removal array, the ones to keep will be removed from the array later
	local slayerToRemove = {}
	for tid, buffId in pairs(Interface.ActiveSuperSlayers) do
		slayerToRemove[tid] = buffId
	end
	for tid, buffId in pairs(Interface.ActiveSlayers) do
		slayerToRemove[tid] = buffId
	end
	for tid, buffId in pairs(Interface.ActiveOppositeSlayers) do
		slayerToRemove[tid] = buffId
	end

	-- reset the active slayer/super slayer and opposite slayer
	Interface.ActiveSlayers = {}
	Interface.ActiveSuperSlayers = {}
	Interface.ActiveOppositeSlayers = {}

	-- searching for active slayer to remove from the removal array
	for index = 1, paperdollData.numSlots  do
		local objectId = paperdollData[index].slotId
		slayerToRemove = PaperdollWindow.GetActiveSlayersOnItem(objectId, slayerToRemove, paperdollId, index )
	end

	-- removing the slayers buffs that are not active
	for tid, buffId in pairs(slayerToRemove) do
		if not Interface.ActiveSuperSlayers[tid] and not Interface.ActiveSlayers[tid] and not Interface.ActiveOppositeSlayers[tid] then
			CustomBuffs.Remove(buffId, true)
		end
	end

	-- activating the super slayer buffs
	for tid, buffId in pairs(Interface.ActiveSuperSlayers) do
		if not BuffDebuff.ActiveBuffs[buffId] then
			local desc = ReplaceTokens(GetStringFromTid(100), {GetStringFromTid(102), FormatProperly(GetStringFromTid(tid))} )
			if buffId == 94 then -- eodon slayer
				desc = GetStringFromTid(275)
			end
			CustomBuffs.Create(buffId, FormatProperly(GetStringFromTid(tid)), desc, 0, true)
		end
	end

	-- activating the normal slayer buffs
	for tid, buffId in pairs(Interface.ActiveSlayers) do
		if not BuffDebuff.ActiveBuffs[buffId] then
			local desc = ReplaceTokens(GetStringFromTid(100), {GetStringFromTid(103), FormatProperly(GetStringFromTid(tid))} )
			if buffId == 94 then -- eodon slayer
				desc = GetStringFromTid(275)
			end
			CustomBuffs.Create(buffId, FormatProperly(GetStringFromTid(tid)), desc, 0, true)
		end
	end

	-- activating the opposite slayer debuff
	for tid, buffId in pairs(Interface.ActiveOppositeSlayers) do
		if not BuffDebuff.ActiveBuffs[buffId] then
			local desc = ""
			local title = ""
			if tid < 900000 then
				desc = GetStringFromTid(tid)
				title = GetStringFromTid(276)
			else
				desc = ReplaceTokens(GetStringFromTid(101), {FormatProperly(GetStringFromTid(tid))})
				title = FormatProperly(GetStringFromTid(tid))
			end
			CustomBuffs.Create(buffId, title, desc, 0, true)
		end
	end
end

function PaperdollWindow.GetPlayerSwingSpeed(speed)

	-- is the interface started?
	if not Interface.started then
		return
	end

	-- do we have a speed value?
	if speed > 0 then

		-- calculating the swing speed
		local totSSI = tonumber(WindowData.PlayerStatus["SwingSpeedIncrease"])
		local stamTicks = math.floor(WindowData.PlayerStatus.CurrentStamina / 30)

		-- update the player swing speed value
		WindowData.PlayerStatus["SwingSpeed"] = string.format("%.2f", math.max(1.25, math.floor((speed * 4 - stamTicks) * (100 / (100 + totSSI)))/4))

	else -- no weapon is equipped, the swing speed is 1.25s for wrestling
		WindowData.PlayerStatus["SwingSpeed"] = 1.25
	end
end

function PaperdollWindow.GetHitLowerAttackChance(hla)
	
	-- hit lower attack success chance found
	if (#hla > 0) then 
		
		-- hit lower attack can only be found on weapons and shields so there can't be more than 2 values
		if (#hla > 1) then
			
			-- calculate the hit lower attack chance
			local total = tonumber(hla[1]) + tonumber(hla[2])
			local perc = (tonumber(hla[1]) * tonumber(hla[2])) / 100
			total = total - perc

			-- update the hit lower attack
			WindowData.PlayerStatus["HitLowerAttack"] = total

		else -- update the hit lower attack
			WindowData.PlayerStatus["HitLowerAttack"] = tonumber(hla[1])
		end

	else -- set the hit lower attack to 0
		WindowData.PlayerStatus["HitLowerAttack"] = 0
	end
end

function PaperdollWindow.GetHitLowerDefenseChance(hld)
	
	-- hit lower defense success chance found
	if (#hld > 0) then 

		-- hit lower defense can only be found on weapons and shields so there can't be more than 2 values
		if (#hld > 1) then

			-- calculate the hot lower defense percentage
			local total = tonumber(hld[1]) + tonumber(hld[2])
			local perc = (tonumber(hld[1]) * tonumber(hld[2])) / 100
			total = total - perc

			-- update the hit lower defense
			WindowData.PlayerStatus["HitLowerDefense"] = total

		else -- update the hit lower defense
			WindowData.PlayerStatus["HitLowerDefense"] = tonumber(hld[1])
		end

	else -- set the hit lower defense 0
		WindowData.PlayerStatus["HitLowerDefense"] = 0
	end
end

PaperdollWindow.GotDamage = false
function PaperdollWindow.UpdateDurabilities(timePassed)
	
	-- scan the open paperdolls
	for id, _  in pairs(WindowData.Paperdoll) do
		
		-- is the paperdoll open?
		if DoesWindowExist("PaperdollWindow" .. id) and WindowGetShowing("PaperdollWindow" .. id) and (id ~= GetPlayerID() or PaperdollWindow.GotDamage) then

			-- scanning the items to update the durability data
			for index = 1, WindowData.Paperdoll[id].numSlots  do
				
				-- get the object ID
				local objectId = WindowData.Paperdoll[id][index].slotId

				-- do we have a valid item ID?
				if IsValidID(objectId) then
					
					-- get the durability value
					local dur = ItemProperties.GetObjectPropertiesParamsForTid( objectId, 1060639, "getting durability values" ) -- durability ~1_val~ / ~2_val~

					-- do we have a durability value?
					if dur then		
						
						-- get the current durability
						local actual = tonumber(dur[1])

						-- get the max durability
						local max = tonumber(dur[2])
						
						-- triggering some events for the player item damaged
						if WindowData.Paperdoll[id][index].Durability then

							-- is this the player paperdoll?
							if id == GetPlayerID() then 

								-- trigger the item damaged event
								if WindowData.Paperdoll[id][index].Durability.Current ~= actual then
									Interface.OnItemDamaged(WindowData.Paperdoll[id][index], index, actual - WindowData.Paperdoll[id][index].Durability.Current)
								end

								-- trigger the item max durability damage event
								if WindowData.Paperdoll[id][index].Durability.Max ~= max then
									Interface.OnItemSeverelyDamaged(WindowData.Paperdoll[id][index], index, max - WindowData.Paperdoll[id][index].Durability.Max)
								end
							end
						end

						-- saving the durability
						WindowData.Paperdoll[id][index].Durability = {Current=actual, Max=max}

					else -- empty slot
						WindowData.Paperdoll[id][index].Durability = nil
					end
				end
			end
			-- updating the paperdoll
			PaperdollWindow.UpdatePaperdoll(id)
		end
	end
end

-- used for manual updating the durabilities
function PaperdollWindow.GetDurabilities(mobileId)

	-- get the paperdoll data
	local paperdollData = Interface.GetPaperdollData(mobileId)
	if not paperdollData then
		return
	end

	-- scanning the equipped items for durabilities
	for index = 1, paperdollData.numSlots  do
		
		-- get the current item ID
		local objectId = paperdollData[index].slotId

		-- do we have a valid item ID?
		if IsValidID(objectId) then
			
			-- get the current durability
			local dur = ItemProperties.GetObjectPropertiesParamsForTid( objectId, 1060639, "getting durability values" ) -- durability ~1_val~ / ~2_val~

			-- do we have the durability
			if dur then		

				-- get the current durability
				local actual = tonumber(dur[1])

				-- get the max durability
				local max = tonumber(dur[2])
								
				-- update the durability for the slot
				paperdollData[index].Durability = {Current=actual, Max=max}

			else -- remove the durability for the slot
				paperdollData[index].Durability = nil
			end
		end
	end
end

-- function for storing the paperdoll items
function PaperdollWindow.ItemsCheck(paperdollId)

	-- get the paperdoll data
	local paperdollData = Interface.GetPaperdollData(paperdollId)
	if not paperdollData then
		return
	end

	-- initializing the array
	if not PaperdollWindow.ItemsList[paperdollId] then
		PaperdollWindow.ItemsList[paperdollId] = {}
	end
		
	-- initialize the unequip and equip array
	local unequipped = {}
	local equipped = {}

	-- get the number of slots for the current paperdoll
	PaperdollWindow.ItemsList[paperdollId].numSlots = paperdollData.numSlots

	-- get the backpack ID for the current paperdoll
	PaperdollWindow.ItemsList[paperdollId].backpackId = paperdollData.backpackId

	-- scanning the paperdoll
	for index = 1, paperdollData.numSlots  do

		-- do we have the item in the slot and it's different from the one we have?
		if not PaperdollWindow.ItemsList[paperdollId][index] or PaperdollWindow.ItemsList[paperdollId][index] ~= paperdollData[index].slotId then
			
			-- storing the item changes to trigger the events later
			-- item in the slot has changed
			if PaperdollWindow.ItemsList[paperdollId][index] ~= 0 and PaperdollWindow.ItemsList[paperdollId][index] ~= paperdollData[index].slotId then
				table.insert(unequipped, {paperdollId=paperdollId, itemId=PaperdollWindow.ItemsList[paperdollId][index], slot=index})
				table.insert(equipped, {paperdollId=paperdollId, itemId=paperdollData[index].slotId, slot=index})
					
			-- slot is empty
			elseif paperdollData[index].slotId == 0 then
				table.insert(unequipped, {paperdollId=paperdollId, itemId=PaperdollWindow.ItemsList[paperdollId][index], slot=index})

			-- any other case
			else
				table.insert(equipped, {paperdollId=paperdollId, itemId=paperdollData[index].slotId, slot=index})
			end

			-- storing the item id
			PaperdollWindow.ItemsList[paperdollId][index] = paperdollData[index].slotId
		end
	end

	-- 1 or more items have been unequipped - event call
	if #unequipped > 0 then
		Interface.OnItemsUnequip(paperdollId, unequipped)
	end

	-- 1 or more items have been equipped - event call
	if #equipped > 0 then
		Interface.OnItemsEquip(paperdollId, equipped)
	end
	
	-- equipment is changed, we need to update the durabilities and the character sheet if it's the player paperdoll.
	if #equipped > 0 or #unequipped > 0 then

		-- flag that an item has been damaged
		PaperdollWindow.GotDamage = true

		-- is this the player paperdoll?
		if GetPlayerID() == paperdollId then
		
			-- scan the player paperdoll
			PaperdollWindow.ScanProperties()
		end
	end
end

function PaperdollWindow.UpdateName(id)

	-- do we have the paperdoll name for the ID?
	if PaperdollWindow.PaperdollsName[id] ~= nil then

		-- get the paperdoll window name
		local windowName = "PaperdollWindow" .. id
		
		-- removing the commas from the name
		PaperdollWindow.PaperdollsName[id] = wstring.gsub(PaperdollWindow.PaperdollsName[id], L", ", L"")
		
		-- acquiring the real player name (ONLY THE NAME) from the properties
		local params = ItemProperties.GetObjectPropertiesParamsForTid(id, 1050045, "get player properties") -- ~1_PREFIX~~2_NAME~~3_SUFFIX~

		-- initialize the name variable
		local name 

		-- do we have the item properties?
		if params then

			-- use the name from the properties
			name = params[2]

		else -- if we can't get only the name we just show what we have
			LabelSetText(windowName .. "TitleName", PaperdollWindow.PaperdollsName[id])
			return
		end

		-- trying to find where the name is in the string to separate the titles
		local namePos = wstring.find(wstring.lower(PaperdollWindow.PaperdollsName[id]), wstring.lower(name), 1, true)
			
		if not namePos then -- we can't separate the name, we show what we have
			LabelSetText(windowName .. "TitleName", PaperdollWindow.PaperdollsName[id])
			return
		end
			
		-- having successfully found the name, now we can separate prefix and suffix
		local prefix = wstring.trim(wstring.sub(PaperdollWindow.PaperdollsName[id] ,1, namePos - 1))
		local suffix = wstring.trim(wstring.sub(PaperdollWindow.PaperdollsName[id], namePos + wstring.len(name) ))
		
		-- initialize the final name
		local finalName = name

		-- get the name prefix
		if prefix and wstring.len(prefix) > 0 then
			finalName = FormatProperly(prefix) .. L"\n" .. finalName
		end
		
		-- get the name suffix
		if suffix and wstring.len(suffix) > 0 then
			finalName = finalName .. L"\n" .. FormatProperly(suffix)
		end

		-- update the label name
		LabelSetText(windowName .. "TitleName", finalName)
	end
end

function PaperdollWindow.initializeSlots(windowName, race, paperdollData)

	-- scan all the paperdoll slits
	for index = 1, paperdollData.numSlots do

		-- slot window name
		local button = windowName.."ItemSlotButton"..index

		-- removing the basic pictures from the slot
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL, "", 0, 0)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "", 0, 0)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED, "", 0, 0)
		ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_DISABLED, "", 0, 0)
			
		-- disabled slots for gargoyle
		if PaperdollWindow.GargoyleDisabledSlots[index] and race == PaperdollWindow.GARGOYLE then 
			DynamicImageSetTexture(button .. "SquareLayer", "", 0, 0)
			CircleImageSetTexture(button .. "RoundLayer", "", 0, 0 )	

		-- gargoyle specific image slot
		elseif PaperdollWindow.GargoyleSpecialSlots[index] and race == PaperdollWindow.GARGOYLE then 
			local slotIndex = PaperdollWindow.GargoyleSpecialSlots[index]
			DynamicImageSetTexture(button .. "SquareLayer", "slot_" .. slotIndex .. "_garg", 0, 0)
			CircleImageSetTexture(button .. "RoundLayer", "", 0, 0 )	
		
		-- talisman layer needs a round picture
		elseif index == 12 then 
			DynamicImageSetTexture(button .. "SquareLayer", "", 0, 0)
			CircleImageSetTexture(button .. "RoundLayer", "slot_" .. index .. "_round", 18, 18 )

		else -- every other slot
			DynamicImageSetTexture(button .. "SquareLayer", "slot_" .. index, 0, 0)
			CircleImageSetTexture(button .. "RoundLayer", "", 0, 0 )	
		end

		-- disabling the item icons if the option is active and there is an item in the slot
		if not Interface.Settings.ShowPaperdollIcons and (not paperdollData[index] or paperdollData[index].slotId == 0) then
			WindowSetAlpha(button .. "SquareLayer", PaperdollWindow.EmptySlotAlpha)	
			WindowSetAlpha(button .. "RoundLayer", PaperdollWindow.EmptySlotAlpha)	
		end
	end
end

function PaperdollWindow.switchTextureForID(id)

	-- do we have a valid ID?
	if not IsValidID(id) then
		return
	end

	-- paperdoll window name
	local windowName = "PaperdollWindow"..id
			
	-- does the paperdoll window exist and is visible?
	if DoesWindowExist(windowName) and WindowGetShowing(windowName) then

		-- applying the new texture and font with related color
		DynamicImageSetTexture(windowName .."TitleBg", MiniTexturePack.DB[Interface.Settings.MTP_Current].texture .. "Label", 0, 0 )
		LabelSetTextColor(windowName .."TitleName", MiniTexturePack.DB[Interface.Settings.MTP_Current].PaperdollLabelColor.r, MiniTexturePack.DB[Interface.Settings.MTP_Current].PaperdollLabelColor.g, MiniTexturePack.DB[Interface.Settings.MTP_Current].PaperdollLabelColor.b)
				
		-- get the race for the current paperdoll
		local race = GetMobileRace(id)

		-- get paperdoll data
		local paperdollData = Interface.GetPaperdollData(id)
		if not paperdollData then
			return
		end

		-- applying the new slot images (if the items icons are disabled)
		if not Interface.Settings.ShowPaperdollIcons then
			PaperdollWindow.applySlotTexture(windowName, race, paperdollData)
		end

		-- refresh the paperdoll
		PaperdollWindow.UpdatePaperdoll(id)
	end
end

function PaperdollWindow.applySlotTexture(windowName, race, paperdollData)

	-- scan all paperdoll slots
	for index = 1, paperdollData.numSlots  do

		-- current slot window name
		local button = windowName.."ItemSlotButton"..index
		
		-- removing the current image
		DynamicImageSetTexture(button.."SquareBg", "", 0, 0 )
		CircleImageSetTexture(button.."RoundBg", "", 24, 24 )
		
		-- nothing to do on disabled slots (gargoyle only)
		if PaperdollWindow.GargoyleDisabledSlots[index] and race == PaperdollWindow.GARGOYLE then 
			continue
			
		-- talisman round slot
		elseif index == 12 then 
			CircleImageSetTexture(button.."RoundBg", MiniTexturePack.DB[Interface.Settings.MTP_Current].texture .. "Icon", 24, 24 )

		else -- other slots
			DynamicImageSetTexture(button.."SquareBg", MiniTexturePack.DB[Interface.Settings.MTP_Current].texture .. "Icon", 0, 0 )
		end
	end	
end

function PaperdollWindow.PlayerPaperdollFirstPositioning()
	
	-- paperdoll window name
	local windowName = "PaperdollWindow" .. GetPlayerID()

	-- does the paperdoll exist?
	if not DoesWindowExist(windowName) then
		return
	end

	-- works also if there is no saved position
	if (Interface.PaperdollFirstPositioning or not WindowUtils.CanRestorePosition("pdollself"))  then
		
		-- first we anchor it just outside the bottom right border of the game window
		WindowClearAnchors(windowName)
		WindowAddAnchor(windowName, "bottomright", "ResizeWindow", "bottomleft", 0, -50)

		-- now we acquire the x-y position (so we can clear the anchor and it won't be blocked there)
		local x, y= WindowGetOffsetFromParent(windowName)

		-- finally we clear the anchors and position to x-y manually
		WindowClearAnchors(windowName)
		WindowSetOffsetFromParent(windowName, x,y)

		-- reset the first positioning flag (in case is the first positioning)
		Interface.PaperdollFirstPositioning = nil
	end
end

function PaperdollWindow.VerifyPosition(windowName)

	-- this part exist in case there is no saved position, so it won't appear out of screen
	local x, y = WindowGetOffsetFromParent(windowName)

	-- is the paperdoll outside the screen?
	if x < 0 and y < 0 then

		-- first we anchor it to the right border of the game window
		WindowClearAnchors(windowName)
		WindowAddAnchor(windowName,  "right", "ResizeWindow", "right", 0, 0)

		-- now we acquire the x-y position (so we can clear the anchor and it won't be blocked there)
		x, y = WindowGetOffsetFromParent(windowName)

		-- finally we clear the anchors and position to x-y manually
		WindowClearAnchors(windowName)
		WindowSetOffsetFromParent(windowName, x, y)
	end	
end

function PaperdollWindow.SetDurabilityColorToSlot(paperdollData, index, elem)
	
	-- current paperdoll window name
	local windowName = WindowGetParent(WindowGetParent(elem))

	-- default slot (color for 100% durability item)
	WindowSetTintColor(elem, 0, 255, 0)

	-- do we have the durability?
	if paperdollData[index].Durability then

		-- showing the damage highlight
		WindowSetShowing(elem, true)

		-- getting the item durability
		local curr = paperdollData[index].Durability.Current
		local max = paperdollData[index].Durability.Max

		-- determining the percentage
		local perc = math.floor((curr/max)*100)
	
		-- percentage of red inside the color
		local percRed = math.floor((curr/((max*70)/100))*100)

		-- calculating the green and blue values
		local gb = math.floor(2.55 * percRed)
		
		-- above 50% we do nothing
		if perc > 50 then

		-- starts to get damaged (yellow)
		elseif perc > 35 then
			WindowSetTintColor(elem, 255, 255, 0)

		-- light red to bright red (for seriously damaged items)
		else
			WindowSetTintColor(elem, 255, gb, gb)
		end

		-- item completely broken, we show the crack image		
		local elementSquareBroken =  windowName .. "ItemSlotButton" .. tostring(index) .. "SquareBroken"
		local elementRoundBroken =  windowName .. "ItemSlotButton" .. tostring(index) .. "RoundBroken"

		if perc == 0 and curr == 0 then
			if index == 12 then -- round for talisman
				WindowSetShowing(elementRoundBroken, true)

			else -- square for the rest
				WindowSetShowing(elementSquareBroken, true)
			end
		end
	end
end

function PaperdollWindow.UpdateSlotsDurability(mobileId, windowName, paperdollData)

	-- acquiring the durabilities and storing the info about the items for later use
	PaperdollWindow.GetDurabilities(mobileId)
	PaperdollWindow.ItemsCheck(mobileId)

	-- scan all slots
	for index = 1, paperdollData.numSlots  do

		-- setting the slot names
		local element = windowName.."ItemSlotButton"..tostring(index)
		local elementIcon = windowName.."ItemSlotButton"..tostring(index).."SquareIcon"
		local elementBg =  windowName.."ItemSlotButton"..tostring(index).."SquareBg"
		local elementRoundBg =  windowName.."ItemSlotButton"..tostring(index).."RoundBg"
		local elementSquareDMG =  windowName.."ItemSlotButton"..tostring(index).."SquareDamage"
		local elementRoundDMG =  windowName.."ItemSlotButton"..tostring(index).."RoundDamage"
		local elementSquareBroken =  windowName.."ItemSlotButton"..tostring(index).."SquareBroken"
		local elementRoundBroken =  windowName.."ItemSlotButton"..tostring(index).."RoundBroken"

		-- initializing the image based on the selected option to show the durability on the full slot or only over the item
		if Interface.Settings.PaperdollFullSlotDurability then
			DynamicImageSetTexture(elementSquareDMG, "square_damage_FULL", 0, 0 )
			CircleImageSetTexture(elementRoundDMG, "round_damage_FULL", 16, 16 )
			
		else  -- only the item
			DynamicImageSetTexture(elementSquareDMG, "square_damage", 0, 0 )
			CircleImageSetTexture(elementRoundDMG, "round_damage", 16, 16 )
		end

		-- remove the texture
		DynamicImageSetTexture(elementBg, "", 0, 0 )
		CircleImageSetTexture(elementRoundBg, "", 24, 24 )

		-- starting invisible
		WindowSetShowing(element, false)
		WindowSetShowing(elementSquareDMG, false)
		WindowSetShowing(elementRoundDMG, false)
		WindowSetShowing(elementSquareBroken, false)
		WindowSetShowing(elementRoundBroken, false)

		-- disabled slots for gargoyle
		if PaperdollWindow.GargoyleDisabledSlots[index] and race == PaperdollWindow.GARGOYLE then 
			WindowSetShowing(elementBg, false)	
			WindowSetShowing(elementRoundBg, false)
		
		-- talisman round slot
		elseif index == 12 then 
			CircleImageSetTexture(elementRoundBg, MiniTexturePack.DB[Interface.Settings.MTP_Current].texture .. "Icon", 24, 24 )

		else -- every other slot
			DynamicImageSetTexture(elementBg, MiniTexturePack.DB[Interface.Settings.MTP_Current].texture .. "Icon", 0, 0 )
		end

		-- drawing empty slot
		if (paperdollData[index].slotId == 0) then
			
			-- resetting the slot variables
			ItemSlot.ButtonStates[index] = ItemSlot.BUTTONSTATE_EMPTY
			ItemSlot.ItemIds[index] = 0
			ItemSlot.ObjectTypes[index] = 0	

			-- hiding the item icon
			WindowSetShowing(elementIcon, false)
				
			-- applying the empty slot alpha when the option to show item icons is off
			if not Interface.Settings.ShowPaperdollIcons then
				WindowSetAlpha(element .. "SquareLayer", PaperdollWindow.EmptySlotAlpha)
				WindowSetAlpha(element .. "RoundLayer", PaperdollWindow.EmptySlotAlpha )
			end

		else -- drawing slot with an item
			
			-- setting the default transparency
			WindowSetAlpha(element .. "SquareLayer", PaperdollWindow.FullSlotAlpha)
			WindowSetAlpha(element .. "RoundLayer", PaperdollWindow.FullSlotAlpha )

			if Interface.Settings.ShowPaperdollIcons then
				-- removing the texture to fit the item icon
				DynamicImageSetTexture(element .. "SquareLayer", "", 0, 0)
				CircleImageSetTexture(element .. "RoundLayer", "", 0, 0 )

			else -- transparency when the item icon is disabled for the default slot image
				WindowSetAlpha(elementSquareDMG, 0.7)
				WindowSetAlpha(elementRoundDMG, 0.7)
			end

			-- adding the item to the arrays
			ItemSlot.ButtonStates[index] = ItemSlot.BUTTONSTATE_NORMAL
			ItemSlot.ItemIds[index] = paperdollData[index].slotId
			ItemSlot.ObjectTypes[index] = paperdollData[index].slotTextureName

			-- hiding the backgrounds default slot picture
			WindowSetShowing(elementBg, false)
			WindowSetShowing(elementRoundBg, false)

			-- variable to store the type of slot (square or round) used
			local elem = elementSquareDMG

			-- preparing the damaged item ROUND image for the talisman and hiding the square
			if index == 12 then
				WindowSetShowing(elementSquareDMG, false)

				WindowSetShowing(elementRoundBg, true)	
				WindowSetShowing(elementRoundDMG, true)
				elem = elementRoundDMG

				-- centering the item icon (if the icons are enabled)
				if Interface.Settings.ShowPaperdollIcons then
					WindowClearAnchors(elementIcon)
					WindowAddAnchor(elementIcon, "center", elementRoundDMG, "center", 0, 2)
				end

			-- preparing the damaged item SQUARE image for the rest of the slot and hiding the round
			else
				WindowSetShowing(elementRoundDMG, false)

				WindowSetShowing(elementBg, true)
				WindowSetShowing(elementSquareDMG, true)
				
				-- centering the item icon (if the icons are enabled)
				if Interface.Settings.ShowPaperdollIcons then
					WindowClearAnchors(elementIcon)
					WindowAddAnchor(elementIcon, "center", elementSquareDMG, "center", 0, 2)
				end
			end

			-- drawing the item icon
			if Interface.Settings.ShowPaperdollIcons then
				EquipmentData.UpdateItemIcon(elementIcon, paperdollData[index])			
			end

			-- showing the item icon
			WindowSetShowing(elementIcon, Interface.Settings.ShowPaperdollIcons)

			-- coloring the slot based on durability
			PaperdollWindow.SetDurabilityColorToSlot(paperdollData, index, elem)
		end

		-- showing the slot
		WindowSetShowing(element, true)
	end
end

function PaperdollWindow.DrawCharacterTexture(mobileId, windowName, race)

	-- paperdoll texture
	local textureData = SystemData.PaperdollTexture[mobileId]

	-- no texture, something is gone really bad if this happens...
	if not textureData then
		return
	end

	-- get the mobile gender
	local gender = GetMobileGender(mobileId)

	-- initilizing texture variable names
	local TextureName = windowName.."Texture" 
	local LegacyTextureName = windowName.."LegacyTexture" 

	-- acquiring window and texture dimensions
	local texWidth, texHeight = WindowGetDimensions(windowName)
	local newWidth, newHeight = textureData.Width, textureData.Height

	-- Check if the paperdoll texture has changed by comparing the window dimensions with the texture dimensions
	if texWidth ~= newWidth or texHeight ~= newHeight then
		
		-- variable to store the name of the texture to show
		local visibleTextures
		
		-- is this legacy paperdoll?
		if textureData.IsLegacy == 1 then

			-- update the legacy texture name
			visibleTextures = LegacyTextureName

			-- hiding the default texture
			WindowSetShowing(TextureName, false)
			WindowSetHandleInput(TextureName, false)
			DynamicImageSetTexture(TextureName, "", 0, 0)

			-- legacy texture needs a double size
			newWidth = newWidth * 2
			newHeight = newHeight * 2

		else -- update the default texture name
			visibleTextures = TextureName

			-- hiding the legacy texture
			WindowSetShowing(LegacyTextureName, false)
			WindowSetHandleInput(LegacyTextureName, false)
			DynamicImageSetTexture(LegacyTextureName, "", 0, 0)
		end

		-- showing and resizing the right texture
		WindowSetShowing(visibleTextures, true)
		WindowSetHandleInput(visibleTextures, true)
		WindowSetDimensions(visibleTextures, newWidth, newHeight)
		WindowClearAnchors(visibleTextures)

		-- internal texture image name
		local paperdollTextureName = "paperdoll_texture"..mobileId

		-- setting the character position in the window based on race and gender
		if race == PaperdollWindow.GARGOYLE then

			--[[ GARGOYLE FEMALE --]]
			if gender == 1 then
				WindowAddAnchor(visibleTextures, "center", windowName, "topleft", textureData.xOffset - 10, textureData.yOffset + 30)	
				DynamicImageSetTexture(visibleTextures, paperdollTextureName, 0, 0)

			else --[[ GARGOYLE MALE --]]
				WindowAddAnchor(visibleTextures, "center", windowName, "topleft", textureData.xOffset, textureData.yOffset + 30)	
				DynamicImageSetTexture(visibleTextures, paperdollTextureName, 0, 0)
			end

		elseif race == PaperdollWindow.HUMAN then

			--[[ HUMAN FEMALE --]]
			if gender == 1 then
				WindowAddAnchor(visibleTextures, "center", windowName, "topleft", textureData.xOffset -5, textureData.yOffset + 30)	
				DynamicImageSetTexture(visibleTextures, paperdollTextureName, 0, 0)

			else --[[ HUMAN MALE --]]
				WindowAddAnchor(visibleTextures, "center", windowName, "topleft", textureData.xOffset +5, textureData.yOffset + 30 )	
				DynamicImageSetTexture(visibleTextures, paperdollTextureName, 0, 0)
			end

		elseif race == PaperdollWindow.ELF then

			--[[ ELF FEMALE --]]
			if gender == 1 then
				WindowAddAnchor(visibleTextures, "center", windowName, "topleft", textureData.xOffset -5, textureData.yOffset + 30)	
				DynamicImageSetTexture(visibleTextures, paperdollTextureName, 0, 0)
			else

			--[[ ELF MALE --]]
				WindowAddAnchor(visibleTextures, "center", windowName, "topleft", textureData.xOffset +5, textureData.yOffset + 30)	
				DynamicImageSetTexture(visibleTextures, paperdollTextureName, 0, 0)
			end
		end
	end
end

function PaperdollWindow.GetPaperdollSlotID(mobileId, index)

	-- is this a valid mobile?
	if not IsValidID(mobileId) then
		return 0
	end

	-- do we have the index?
	if not index then
		return
	end

	-- get the item list for the paperdoll
	local paperdollData = PaperdollWindow.ItemsList[mobileId]

	-- do we have the list?
	if not paperdollData then

		-- load the paperdoll data
		paperdollData = Interface.GetPaperdollData(mobileId)

		-- do we have the data? return the ID
		if paperdollData then
			return paperdollData[index].slotId
		end

	else -- we return the ID we have stored
		return paperdollData[index]
	end

	-- probably the paperdoll is not accessible
	return 0
end

function PaperdollWindow.GetSlotIdByItemId(itemId, mobileId)

	-- is this a valid item?
	if not IsValidID(itemId) then
		return
	end

	-- get the item list for the paperdoll
	local paperdollData = Interface.GetPaperdollData(mobileId)

	-- scan the whole equipment
	for index = 1, paperdollData.numSlots do

		-- is this the item id we have?
		if paperdollData[index].slotId == itemId then
			return index
		end
	end
end