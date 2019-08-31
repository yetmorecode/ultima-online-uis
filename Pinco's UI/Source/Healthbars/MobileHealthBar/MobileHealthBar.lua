----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

MobileHealthBar = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

MobileHealthBar.DefaultWidth = 160

MobileHealthBar.DefaultButtonWidth = 32

MobileHealthBar.PropertiesButtonVisibility = 0.2

MobileHealthBar.CurrentTarget = 0

MobileHealthBar.CurrentHover = ""

MobileHealthBar.HealthbarsType = { NORMAL = 1, PARTY = 2, PET = 3, INVULNERABLE = 4 }

MobileHealthBar.ActiveBars = {}

MobileHealthBar.PinnedOrder = {}

MobileHealthBar.ButtonsData = {
	["Bod"] = {titleTid = 3006152, bodyTid = 1154853, availableCallback = function(mobileId) return IsBodDealer(mobileId) end, callback = function(mobileId) ContextMenu.RequestContextAction(mobileId, ContextMenu.DefaultValues.BodRequest) end},
	["Bribe"] = {titleTid = 1155267, bodyTid = 1155268, availableCallback = function(mobileId) return IsBodDealer(mobileId) end, callback = function(mobileId) ContextMenu.RequestContextAction(mobileId, ContextMenu.DefaultValues.Bribe) end},
	["Bank"] = {titleTid = 1023083, bodyTid = 1154855, maxDistance = 8, callback = function(mobileId) ContextMenu.RequestContextAction(mobileId, ContextMenu.DefaultValues.OpenBankbox) end},
	["Buy"] = {titleTid = 386, bodyTid = 387, maxDistance = 8, callback = function(mobileId) ContextMenu.RequestContextAction(mobileId, ContextMenu.DefaultValues.VendorBuy) end},
	["Sell"] = {titleTid = 388, bodyTid = 389, maxDistance = 8, callback = function(mobileId) ContextMenu.RequestContextAction(mobileId, ContextMenu.DefaultValues.VendorSell) end},
	["Stable"] = {titleTid = 1154997, bodyTid = 392, maxDistance = 12, callback = function(mobileId) ContextMenu.RequestContextAction(mobileId, ContextMenu.DefaultValues.StablePet) end},
	["Inventory"] = {tooltipFunction = function(mobileId) MobileHealthBar.InventoryTooltip(mobileId) end, maxDistance = 2, callback = function(mobileId) local bakcpackId = GetBackpackID(mobileId) if IsValidID(bakcpackId) then UserActionUseItem(bakcpackId, false) end end},
	["MobileProperties"] = {tooltipFunction = function(mobileId) MobileHealthBar.MobilePropertiesTooltip(mobileId) end },
	["QuestGiver"] = {titleTid = 1072269, bodyTid = 391 },
	["PinBar"] = {tooltipFunction = function(mobileId) MobileHealthBar.PinTooltip(mobileId) end, callback = function(mobileId) MobileHealthBar.TogglePinBar(mobileId) end },
	["Crown"] = {titleTid = 1154872, bodyTid = 404 },
	["Stop"] = {titleTid = 3006112, bodyTid = 393, maxDistance = 12, callback = function(mobileId) ContextMenu.RequestContextAction(mobileId, ContextMenu.DefaultValues.PetStop) end},
	["Stay"] = {titleTid = 3006114, bodyTid = 394, maxDistance = 12, callback = function(mobileId) ContextMenu.RequestContextAction(mobileId, ContextMenu.DefaultValues.PetStay) end},
	["Follow"] = {titleTid = 3006108, bodyTid = 395, maxDistance = 12, callback = function(mobileId) ContextMenu.RequestContextAction(mobileId, ContextMenu.DefaultValues.PetFollow) ForceExecuteTarget(GetPlayerID()) end},
	["Guard"] = {titleTid = 3006107, bodyTid = 396, maxDistance = 12, callback = function(mobileId) ContextMenu.RequestContextAction(mobileId, ContextMenu.DefaultValues.PetGuard) end},
	["Kill"] = {titleTid = 3006111, bodyTid = 397, maxDistance = 12, callback = function(mobileId) ContextMenu.RequestContextAction(mobileId, ContextMenu.DefaultValues.PetKill) end},
	["AnimalLore"] = {titleTid = 1044062, bodyTid = 1002008, maxDistance = 12, callback = function(mobileId) UserActionUseSkill(WindowData.SkillsCSV[3].ServerId) ForceExecuteTarget(mobileId) end},
	["Rename"] = {titleTid = 1155270, bodyTid = 398, callback = function(mobileId) ContextMenu.RequestContextAction(mobileId, ContextMenu.DefaultValues.RenamePet) end},
	["Veterinary"] = {titleTid = 1002167, bodyTid = 399, availableCallback = function(mobileId) return MobileHealthBar.BandageAvailability(mobileId, true) end, callback = function(mobileId) UserActionUseItem(ContainerWindow.GetItemIDByType(3617), false) ForceExecuteTarget(mobileId) end},
	
	["RedButton"] = {tooltipFunction = function(mobileId) MobileHealthBar.SpellTooltip(mobileId, MobileHealthBar.GetButtonSpellID(mobileId, "Red")) end, availableCallback = function(mobileId) if not IsValidID(MobileHealthBar.GetButtonSpellID(mobileId, "Red")) then MobileHealthBar.InitializeButtons(mobileId) end return true end, callback = function(mobileId) UserActionCastSpellOnId(MobileHealthBar.GetButtonSpellID(mobileId, "Red"), mobileId) end},
	["GreenButton"] = {tooltipFunction = function(mobileId) MobileHealthBar.SpellTooltip(mobileId, MobileHealthBar.GetButtonSpellID(mobileId, "Green")) end, availableCallback = function(mobileId) if not IsValidID(MobileHealthBar.GetButtonSpellID(mobileId, "Green")) then MobileHealthBar.InitializeButtons(mobileId) end return true end, callback = function(mobileId) UserActionCastSpellOnId(MobileHealthBar.GetButtonSpellID(mobileId, "Green"), mobileId) end},
	["BlueButton"] = {tooltipFunction = function(mobileId) MobileHealthBar.SpellTooltip(mobileId, MobileHealthBar.GetButtonSpellID(mobileId, "Blue")) end, availableCallback = function(mobileId) if not IsValidID(MobileHealthBar.GetButtonSpellID(mobileId, "Blue")) then MobileHealthBar.InitializeButtons(mobileId) end return true end, callback = function(mobileId) UserActionCastSpellOnId(MobileHealthBar.GetButtonSpellID(mobileId, "Blue"), mobileId) end},
	["GoldButton"] = {tooltipFunction = function(mobileId) MobileHealthBar.SkillTooltip(mobileId, MobileHealthBar.GetButtonSpellID(mobileId, "Gold")) end, availableCallback = function(mobileId) if not IsValidID(MobileHealthBar.GetButtonSpellID(mobileId, "Gold")) then MobileHealthBar.InitializeButtons(mobileId) end return true end, callback = function(mobileId) MobileHealthBar.UseSkill(MobileHealthBar.GetButtonSpellID(mobileId, "Gold"), mobileId) end},
	["PurpleButton"] = {tooltipFunction = function(mobileId) MobileHealthBar.ItemTooltip(mobileId, MobileHealthBar.GetButtonSpellID(mobileId, "Purple")) end, availableCallback = function(mobileId) if not IsValidID(MobileHealthBar.GetButtonSpellID(mobileId, "Purple")) then MobileHealthBar.InitializeButtons(mobileId) end return true end, callback = function(mobileId) UserActionUseItem(ContainerWindow.GetItemIDByType(MobileHealthBar.GetButtonSpellID(mobileId, "Purple")), false) ForceExecuteTarget(mobileId) end},
	
	["MassDispel"] = {titleTid = 3002064, bodyTid = 400, callback = function(mobileId) UserActionCastSpellOnId(54, mobileId) end},
	["Release"] = {titleTid = 3006118, bodyTid = 401, callback = function(mobileId) ContextMenu.RequestContextAction(mobileId, ContextMenu.DefaultValues.PetRelease) end},
	["Healing"] = {titleTid = 1002082, bodyTid = 402, availableCallback = function(mobileId) return MobileHealthBar.BandageAvailability(mobileId, false) end, callback = function(mobileId) UserActionUseItem(ContainerWindow.GetItemIDByType(3617), false) ForceExecuteTarget(mobileId) end},
	["Resurrection"] = {titleTid = 3002069, bodyTid = 403, availableCallback = function(mobileId) return (Interface.ActiveMobilesOnScreen[mobileId] and Interface.ActiveMobilesOnScreen[mobileId].dead and GetDistanceFromPlayer(mobileId) <= 1) end, callback = function(mobileId) UserActionCastSpellOnId(59, mobileId) end},
	["Attack"] = {titleTid = 409, bodyTid = 410, callback = function(mobileId) MobileHealthBar.QueryCriminalAction(mobileId, function() SendChat(ChatSettings.Channels[SystemData.ChatLogFilters.SAY].serverCmd, L"All Kill") ForceExecuteTarget(mobileId) end) end},
	["Honor"] = {titleTid = 1012017, bodyTid = 411, callback = function(mobileId) UserActionInvokeVirtue(1) ForceExecuteTarget(mobileId) end},
	["Wod"] = {titleTid = 1071039, bodyTid = 412, availableCallback = function(mobileId) local circleLimit = (Interface.ArcaneFocusLevel or 0) * 5 if (circleLimit <= 0) then circleLimit = 0 end return (Interface.ActiveMobilesOnScreen[mobileId] and Interface.ActiveMobilesOnScreen[mobileId].perc <= circleLimit) end, callback = function(mobileId) MobileHealthBar.QueryCriminalAction(mobileId, function() MobileHealthBar.CastWod(mobileId) end) end},
}

MobileHealthBar.KnownInventory = {}
MobileHealthBar.LastInventoryRequest = {}

MobileHealthBar.mouseOverId = 0

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function MobileHealthBar.InitializeSummons()

	-- flag the summons table as initialized
	MobileHealthBar.SummonTimerInitialized = true
	
	-- create the saving structure for the summons timer
	MobileHealthBar.SummonTimer = LoadSaveStructureWithPlayerID(MobileHealthBar.SummonTimers)
end

function MobileHealthBar.InitializePetPowerHour()

	-- mark the pet power hours table as initialized
	MobileHealthBar.PetPowerHourInitialized = true

	-- create the saving structure for the pet power hour
	MobileHealthBar.PetPowerHour = LoadSaveStructureWithPlayerID(MobileHealthBar.PetPowerHours)
end

function MobileHealthBar.CreateBar(mobileId, pinBar)

	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return
	end

	-- we already have a bar for this mobile
	if MobileHealthBar.ActiveBars[mobileId] then

		-- since the bar already exist, we only pin it down
		if pinBar then
			MobileHealthBar.PinBar(mobileId)
		end

		return
	end

	-- register the window data for the mobile
	MobileHealthBar.RegisterBar(mobileId)

	-- get the mobile data for the specified ID
	local mobileData = Interface.ActiveMobilesOnScreen[mobileId]

	-- no mobile data (this should not happen since we have all the data for the mobiles on screen)
	if not mobileData then
		return
	end

	-- create the data record for the healthbar window
	local barData = {}

	-- get the template for the bar
	local barTemplate = "MobileHealthBar_"

	-- healthbar window name
	barData.windowName = "MobileBar_" .. mobileId

	-- default height for the bar
	barData.defaultHeight = MobileHealthBar.DefaultHeight

	-- is this a player pet?
	if IsObjectIdPet(mobileId) then

		-- update the template name
		barTemplate = barTemplate .. "PET"

		-- set the bar type
		barData.type = MobileHealthBar.HealthbarsType.PET

		-- create the healthbar
		CreateWindowFromTemplate(barData.windowName, barTemplate, "Root")

		-- default height for the bar
		barData.expandedHeight = barData.defaultHeight

		-- does the pet requires a progress bar?
		if IsValidID(AnimalLore.GetProgressID(mobileId, mobileData.name)) then

			-- default height for the bar
			barData.defaultHeight = MobileHealthBar.PetBarHeight
		end

		-- do we want to see small buttons and the buttons are not disabled?
		if Interface.Settings.HealthbarsSmallButtons and not Interface.Settings.DisableButtons then

			-- create the small buttons
			CreateWindowFromTemplate(barData.windowName .. "ButtonsBar", "ButtonsBarTemplate", barData.windowName)

			-- reset the buttons bar anchors
			WindowClearAnchors(barData.windowName .. "ButtonsBar")

			-- anchor the buttons bar to the bottom of the healthbar
			WindowAddAnchor(barData.windowName .. "ButtonsBar", "bottom", barData.windowName, "bottom", 0, 0)
		end

		-- toggle the star
		MobileHealthBar.ManagePetPowerHour(mobileId)

	-- is this the player? (the player uses the same bar as the party but slightly different)
	elseif mobileId == GetPlayerID() and Interface.Settings.StatusWindowStyle == 4 then
		
		-- update the template name
		barTemplate = barTemplate .. "PLAYER"

		-- set the bar type
		barData.type = MobileHealthBar.HealthbarsType.PARTY

		-- create the healthbar
		CreateWindowFromTemplate(barData.windowName, barTemplate, "Root")
		
		-- default height for the bar
		barData.defaultHeight = MobileHealthBar.PartyBarHeight

		-- default height for the bar
		barData.expandedHeight = barData.defaultHeight

		-- flag this bar as a party member bar
		barData.PartyMember = true

		-- toggle the party leader flag
		WindowSetShowing(barData.windowName .. "Crown", mobileData.isPartyLeader == true)

		-- do we want to see small buttons and the buttons are not disabled?
		if Interface.Settings.HealthbarsSmallButtons and not Interface.Settings.DisableButtons then

			-- create the small buttons
			CreateWindowFromTemplate(barData.windowName .. "ButtonsBar", "ButtonsBarTemplate", barData.windowName)

			-- reset the buttons bar anchors
			WindowClearAnchors(barData.windowName .. "ButtonsBar")

			-- anchor the buttons bar to the bottom of the healthbar
			WindowAddAnchor(barData.windowName .. "ButtonsBar", "bottom", barData.windowName, "bottom", 0, 0)
		end

	-- is this a party member?
	elseif IsPartyMember(mobileId) then
		
		-- update the template name
		barTemplate = barTemplate .. "PARTY"

		-- set the bar type
		barData.type = MobileHealthBar.HealthbarsType.PARTY

		-- create the healthbar
		CreateWindowFromTemplate(barData.windowName, barTemplate, "Root")
		
		-- default height for the bar
		barData.defaultHeight = MobileHealthBar.PartyBarHeight

		-- default height for the bar
		barData.expandedHeight = barData.defaultHeight

		-- flag this bar as a party member bar
		barData.PartyMember = true

		-- toggle the party leader flag
		WindowSetShowing(barData.windowName .. "Crown", mobileData.isPartyLeader == true)

		-- do we want to see small buttons and the buttons are not disabled?
		if Interface.Settings.HealthbarsSmallButtons and not Interface.Settings.DisableButtons then

			-- create the small buttons
			CreateWindowFromTemplate(barData.windowName .. "ButtonsBar", "ButtonsBarTemplate", barData.windowName)

			-- reset the buttons bar anchors
			WindowClearAnchors(barData.windowName .. "ButtonsBar")

			-- anchor the buttons bar to the bottom of the healthbar
			WindowAddAnchor(barData.windowName .. "ButtonsBar", "bottom", barData.windowName, "bottom", 0, 0)
		end
		
	else -- anyone else

		-- update the template name
		barTemplate = barTemplate .. "OTHERS"

		-- set the bar type
		barData.type = MobileHealthBar.HealthbarsType.NORMAL

		-- default height for the bar
		barData.expandedHeight = barData.defaultHeight

		-- create the healthbar
		CreateWindowFromTemplate(barData.windowName, barTemplate, "Root")

		-- toggle the title and healthbar based on if the mobile is invulnerable or not
		WindowSetShowing(barData.windowName .. "Title", mobileData.invulnerable == true)
		WindowSetShowing(barData.windowName .. "HealthBar", not mobileData.invulnerable)
		WindowSetShowing(barData.windowName .. "HealthBarPerc", not mobileData.invulnerable)

		-- do we want to see small buttons and the buttons are not disabled?
		if Interface.Settings.HealthbarsSmallButtons and not Interface.Settings.DisableButtons then
			
			-- is the mobile invulnerable?
			if mobileData.invulnerable then

				-- default height for the bar - the height for the small buttons that are not available for invulnerable
				barData.defaultHeight = barData.defaultHeight - 20

			else
				-- create the small buttons
				CreateWindowFromTemplate(barData.windowName .. "ButtonsBar", "ButtonsBarTemplate", barData.windowName)

				-- reset the buttons bar anchors
				WindowClearAnchors(barData.windowName .. "ButtonsBar")

				-- anchor the buttons bar to the bottom of the healthbar
				WindowAddAnchor(barData.windowName .. "ButtonsBar", "bottom", barData.windowName, "bottom", 0, 0)
			end
		end

		-- toggle the invulnerable parts based on if the mobile is invulnerable or not
		MobileHealthBar.ToggleInvulnerable(mobileId)
	end

	-- pin button name
	local pinButton = barData.windowName .. "PinBar"

	-- does this bar have the pin button?
	if DoesWindowExist(pinButton) then

		-- hide the pin button (is visible only when you put the mouse over the healthbar)
		WindowSetShowing(pinButton, false)
	end
	
	-- toggle the questgiver flag
	WindowSetShowing(barData.windowName .. "QuestGiver", mobileData.isQuestGiver == true)

	-- attach the mobile ID to the bar
	WindowSetId(barData.windowName, mobileId)

	-- buttons are visible only in an enlarged bar so they are hidden at creation
	WindowSetShowing(barData.windowName .. "Buttons", false)

	-- make the properties button less visible
	WindowSetAlpha(barData.windowName .. "MobileProperties", MobileHealthBar.PropertiesButtonVisibility)

	-- make the bar snappable
	SnapUtils.SnappableWindows[barData.windowName] = true

	-- store the time of creation of the bar
	barData.creationTime = Interface.TimeSinceLogin

	-- create the data for this new healthbar
	MobileHealthBar.ActiveBars[mobileId] = barData

	-- do we have to pin the bar?
	if pinBar or (Interface.Settings.AutoPinHonored and Interface.CurrentHonor == mobileId) then
		MobileHealthBar.PinBar(mobileId)

	else -- by default the bar is not locked on the watchlist
		barData.pinned = false
	end
	
	-- fix the bar dimensions
	MobileHealthBar.Retract(barData.windowName)

	-- initialize the bar name, status for the time the bar has appeared
	Interface.ExecuteWhenAvailable(
	{
		name = "InitializeBar" .. mobileId,
		check = function() return MobileHealthBar.CheckAllDataIsAvailable(mobileId) end, 
		callback = function() MobileHealthBar.UpdateBarName(mobileId)  MobileHealthBar.UpdateBarStatus(mobileId) end, 
		removeOnComplete = true,
		delay = Interface.TimeSinceLogin + 0.5
	})
	
	-- initialize the bar status (enabled/disabled)
	MobileHealthBar.UpdateHealthBarState(mobileId)

	-- return the bar data
	return MobileHealthBar.ActiveBars[mobileId]
end

function MobileHealthBar.CheckAllDataIsAvailable(mobileId)

	-- get the mobile data for the specified ID
	local mobileData = Interface.ActiveMobilesOnScreen[mobileId]
	
	-- no mobile data?
	if not mobileData and mobileId ~= GetPlayerID() then
	
		-- update the mobile name data
		Interface.UpdateMobileOnScreenName(mobileId)

		-- update the mobile status data
		Interface.UpdateMobileOnScreenStatus(mobileId)

		return false
	end

	-- start to check if the name is ready
	local ready = Interface.VerifyMobileName(mobileId, WindowData.MobileName[mobileId]) ~= nil
	
	-- no need to update invulnerable mobiles status
	if IsMobileInvulnerable(mobileId) then
		return ready 
	end
	
	return ready
end

function MobileHealthBar.Shutdown()
	
	-- if the interface is shutting down we can avoid everything in here
	if Interface.goingDown then
		return
	end

	-- get the current window name
	local windowName = WindowUtils.GetActiveDialog()

	-- get the mobile ID
	local mobileId = WindowGetId(windowName)

	-- create a variable as pointer for the bar record
	local barData = MobileHealthBar.ActiveBars[mobileId]

	-- if the bar don't exist, we can get out (this should NEVER happen here)
	if not barData then
		return
	end

	-- was this bar docked to a grid slot?
	if barData.dockGrid then

		-- resize the grid slot before closing the bar
		MobileBarsDockspot.ResizeGridSlot(barData.dockGrid)
	end

	-- make sure any other animations are stopped
	WindowStopAlphaAnimation(barData.windowName)

	-- make the bar not snappable
	SnapUtils.SnappableWindows[barData.windowName] = nil

	-- remove the bar record
	MobileHealthBar.ActiveBars[mobileId] = nil

	-- is the mobile arrow over this mobile?
	if MobileHealthBar.mouseOverId == mobileId then

		-- reset the mobile arrow ID
		MobileHealthBar.mouseOverId = 0
	end
end

function MobileHealthBar.ToggleInvulnerable(mobileId)
	
	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return
	end

	-- create a variable as pointer for the bar record
	local barData = MobileHealthBar.ActiveBars[mobileId]
	
	-- if the bar don't exist, we can get out
	if not barData or not barData.windowName or not DoesWindowExist(barData.windowName) then
		return
	end

	-- is this bar for pets or party?
	if barData.type ~= MobileHealthBar.HealthbarsType.NORMAL then
		return
	end

	-- get the mobile data for the specified ID
	local mobileData = Interface.ActiveMobilesOnScreen[mobileId]

	-- no mobile data (this should not happen since we have all the data for the mobiles on screen)
	if not mobileData then
		return
	end
	
	-- default height for the bar
	barData.defaultHeight = MobileHealthBar.DefaultHeight

	-- do we want to see small buttons and the buttons are not disabled?
	if Interface.Settings.HealthbarsSmallButtons and not Interface.Settings.DisableButtons then

		-- is the mobile invulnerable?
		if mobileData.invulnerable then

			-- default height for the bar - the height for the small buttons that are not available for invulnerable
			barData.defaultHeight = barData.defaultHeight - 20

			-- destroy the buttons bar if it exist
			if DoesWindowExist(barData.windowName .. "ButtonsBar") then
				DestroyWindow(barData.windowName .. "ButtonsBar")
			end

		-- is this not invulnerable and the buttons bar don't exist?
		elseif not DoesWindowExist(barData.windowName .. "ButtonsBar") then
			
			-- create the small buttons
			CreateWindowFromTemplate(barData.windowName .. "ButtonsBar", "ButtonsBarTemplate", barData.windowName)

			-- reset the buttons bar anchors
			WindowClearAnchors(barData.windowName .. "ButtonsBar")

			-- anchor the buttons bar to the bottom of the healthbar
			WindowAddAnchor(barData.windowName .. "ButtonsBar", "bottom", barData.windowName, "bottom", 0, 0)
		end
	end

	-- expanded height for the bars
	barData.expandedHeight = barData.defaultHeight

	-- toggle the title and healthbar based on if the mobile is invulnerable or not
	WindowSetShowing(barData.windowName .. "Title", mobileData.invulnerable)
	WindowSetShowing(barData.windowName .. "HealthBar", not mobileData.invulnerable)
	WindowSetShowing(barData.windowName .. "HealthBarPerc", not mobileData.invulnerable)
	
	-- fix the bar dimensions
	MobileHealthBar.Retract(barData.windowName)

	-- is the mobile NOT invulnerable?
	if not mobileData.invulnerable then

		-- update the status
		MobileHealthBar.UpdateBarStatus(mobileId)
	end
end

function MobileHealthBar.UpdateHealthBarState(mobileId)

	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return
	end

	-- create a variable as pointer for the bar record
	local barData = MobileHealthBar.ActiveBars[mobileId]

	-- if the bar don't exist, we can get out
	if not barData or not barData.windowName or not DoesWindowExist(barData.windowName) then
		return
	end
	
	-- get the availability status
	barData.disabled = not IsHealthBarEnabled(mobileId) or not IsMobileVisible(mobileId)

	if not barData.disabled then
		
		-- register the window data for the mobile
		MobileHealthBar.RegisterBar(mobileId)

		-- update the status
		Interface.UpdateMobileOnScreenStatus(mobileId)
	end
	
	-- toggle the disabled status
	MobileHealthBar.ToggleDisabled(mobileId)
end

function MobileHealthBar.UpdateBarName(mobileId)

	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return
	end

	-- is the mobile status available?
	if not Interface.VerifyMobileName(mobileId, WindowData.MobileStatus[mobileId]) then

		-- register the bar again
		MobileHealthBar.RegisterBar(mobileId)
	end

	-- get the mobile data for the specified ID
	local mobileData = Interface.ActiveMobilesOnScreen[mobileId]
	
	-- no mobile data (this should not happen since we have all the data for the mobiles on screen)
	if not mobileData then

		-- try again in a short time
		Interface.ExecuteWhenAvailable(
		{
			name = "mobileNameUpdate" .. mobileId,
			check = function() return Interface.ActiveMobilesOnScreen[mobileId] ~= nil end, 
			callback = function() MobileHealthBar.UpdateBarName(mobileId) end, 
			removeOnComplete = true
		})

		return
	end

	--[[ does the mobile flags check have failed?
	if mobileData.failCheckFlag then

		-- update the name flags as soon as the properties are available
		Interface.ExecuteWhenAvailable(
		{
			name = "mobileOnScreenFlagsUpdate" .. mobileId,
			check = function() return Interface.GetItemPropertiesData(mobileId) ~= nil end, 
			callback = function() if not Interface.ActiveMobilesOnScreen[mobileId] then return end Interface.UpdateMobileOnScreenNameFlags(mobileId, true) MobileHealthBar.UpdateBarName(mobileId) end, 
			failCallback = function() if not Interface.ActiveMobilesOnScreen[mobileId] then return end Interface.ActiveMobilesOnScreen[mobileId].failCheckFlag = true end,
			removeOnComplete = true
		})
	end --]]
	
	-- create a variable as pointer for the bar record
	local barData = MobileHealthBar.ActiveBars[mobileId]
	
	-- if the bar don't exist, we can get out
	if not barData or not barData.windowName or not DoesWindowExist(barData.windowName) then
		return
	end
	
	-- if the notoriety is missing, we lack the name data
	if not mobileData.notoriety then

		-- acquire the name data
		Interface.UpdateMobileOnScreenName(mobileId)

	else -- make sure the name is complete
		Interface.UpdateMobileOnScreenCleanName(mobileId)
	end

	-- do we have a valid notoriety?
	if mobileData.notoriety and mobileData.notoriety ~= NameColor.Notoriety.NONE and barData.storedNotoriety ~= mobileData.notoriety then

		-- store the notortiety value
		barData.storedNotoriety = mobileData.notoriety

		-- is this a normal bar?
		if barData.type == MobileHealthBar.HealthbarsType.NORMAL then

			-- toggle the invulnerable parts based on if the mobile is invulnerable or not
			MobileHealthBar.ToggleInvulnerable(mobileId)
		end
	end

	-- update the healthbar name text
	MobileHealthBar.UpdateBarNameText(mobileId)

	-- update healthbar name colors (after a short delay to avoid glitches)
	Interface.ExecuteWhenAvailable(
	{
		name = "mobileBarUpdateColors" .. mobileId,
		check = function() return (Interface.ActiveMobilesOnScreen[mobileId] ~= nil and Interface.ActiveMobilesOnScreen[mobileId].notoriety and Interface.ActiveMobilesOnScreen[mobileId].notoriety ~= NameColor.Notoriety.NONE) or barData.storedNotoriety end, 
		callback = function() MobileHealthBar.UpdateBarNameColor(mobileId) end, 
		removeOnComplete = true
	})
end

function MobileHealthBar.UpdateBarNameText(mobileId)

	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return
	end

	-- create a variable as pointer for the bar record
	local barData = MobileHealthBar.ActiveBars[mobileId]
	
	-- if the bar don't exist, we can get out
	if not barData or not barData.windowName or not DoesWindowExist(barData.windowName) then
		return
	end

	-- get the mobile data for the specified ID
	local mobileData = Interface.ActiveMobilesOnScreen[mobileId]
	
	-- no mobile data (this should not happen since we have all the data for the mobiles on screen)
	if not mobileData then
		return
	end

	-- invulnerable mobiles has 2 labels: name and title split in 2 lines
	if mobileData.invulnerable then
	
		-- is this a player vendor?
		if mobileData.isPlayerVendor then

			-- update the mobile name
			WindowUtils.FitTextToLabel(barData.windowName .. "Name", mobileData.name)

			-- get the shop name
			local prop = ItemProperties.GetObjectPropertiesParamsForTid(mobileId, 1062449, "is player vendor?")
			
			-- do we have the shop name?
			if prop then

				-- write the shop name on the second line
				WindowUtils.FitTextToLabel(barData.windowName .. "Title", prop[1])
			end

		else -- any other invulnerable NPC 

			-- update the mobile name
			WindowUtils.FitTextToLabel(barData.windowName .. "Name", mobileData.cleanName)

			-- update the NPC title
			WindowUtils.FitTextToLabel(barData.windowName .. "Title", mobileData.title)
		end

	else -- all other bars

		-- update the mobile name
		WindowUtils.FitTextToLabel(barData.windowName .. "Name", mobileData.name)
	end
end

function MobileHealthBar.UpdateBarNameColor(mobileId)

	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return
	end

	-- create a variable as pointer for the bar record
	local barData = MobileHealthBar.ActiveBars[mobileId]

	-- if the bar don't exist, we can get out
	if not barData or not barData.windowName or not DoesWindowExist(barData.windowName) then
		return
	end

	-- get the mobile data for the specified ID
	local mobileData = Interface.ActiveMobilesOnScreen[mobileId]

	-- no mobile data (this should not happen since we have all the data for the mobiles on screen)
	if not mobileData then
		return
	end

	-- invulnerable mobiles has 2 labels: name and title split in 2 lines
	if mobileData.invulnerable then
		
		-- force the notoriety color for invulnerables
		barData.storedNotoriety = NameColor.Notoriety.INVULNERABLE

		-- color the name
		NameColor.UpdateLabelNameColor(barData.windowName .. "Name", barData.storedNotoriety)

		-- color the title
		NameColor.UpdateLabelNameColor(barData.windowName .. "Title", barData.storedNotoriety)

	else -- any other bar

		-- color the name
		NameColor.UpdateLabelNameColor(barData.windowName .. "Name", barData.storedNotoriety)
	end

	-- update the frame color based on the notoriety
	NameColor.UpdateImageNameColor(barData.windowName .. "Frame", barData.storedNotoriety)
	NameColor.UpdateImageNameColor(barData.windowName .. "FrameHighlight", barData.storedNotoriety)

	-- if this bar is supposed to be highlighted, we don't change the transparency of the frame
	if MobileHealthBar.CurrentTarget ~= mobileId and mobileId ~= TargetWindow.TargetId then
		
		-- hide the highlight frame
		WindowSetShowing(barData.windowName .. "FrameHighlight", false)

	else -- save the ID of the current highlighted bar
		MobileHealthBar.CurrentTarget = mobileId
	end

	-- save the last time the text colors were update
	barData.lastColorUpdate = Interface.TimeSinceLogin
end

function MobileHealthBar.UpdateBarStatus(mobileId)

	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return
	end

	-- is the mobile status available?
	if mobileId ~= GetPlayerID() and not Interface.VerifyMobileData(mobileId, WindowData.MobileStatus[mobileId]) then

		-- register the bar again
		MobileHealthBar.RegisterBar(mobileId)
	end

	-- create a variable as pointer for the bar record
	local barData = MobileHealthBar.ActiveBars[mobileId]

	-- if the bar don't exist or is disabled, we can get out
	if not barData or not barData.windowName or not DoesWindowExist(barData.windowName) or barData.disabled or barData.type == MobileHealthBar.HealthbarsType.INVULNERABLE then
		return
	end

	-- healthbar background window name
	local healthbar = barData.windowName .. "HealthBar"

	-- initialize the healthbar background
	StatusBarSetBackgroundTint(healthbar, 200, 200, 200)

	-- initializing percentage label at 0%
	LabelSetText(healthbar .. "Perc", L"0%")

	-- current mobile data record
	local mobileStatus = Interface.ActiveMobilesOnScreen[mobileId]
	
	-- do we have the mobile data?
	if not mobileStatus or not mobileStatus.maxHealth or mobileStatus.maxHealth == 0 then

		-- update the bar status to 100%
		StatusBarSetMaximumValue(healthbar, 100)
		StatusBarSetCurrentValue(healthbar, 100)	

		-- show that we don't have the mobile data
		LabelSetText(healthbar .. "Perc", GetStringFromTid(527))

		-- set the bar in an appropriate color for the missing data
		HealthBarColor.UpdateHealthBarColor(healthbar, HealthBarColor.HealthVisualState.NoData - 1)

		-- update the mobiles on screen data
		Interface.UpdateMobileOnScreenStatus(mobileId)

		-- try again in a short time
		Interface.ExecuteWhenAvailable(
		{
			name = "mobileStatusUpdate" .. mobileId,
			check = function() return Interface.ActiveMobilesOnScreen[mobileId] ~= nil end, 
			callback = function() Interface.GetMobileData(mobileId) MobileHealthBar.UpdateBarStatus(mobileId) end, 
			removeOnComplete = true,
		})

		return
	end

	-- no need to update invulnerable mobiles status
	if mobileStatus.invulnerable then
		return
	end

	-- update the mobile health
	MobileHealthBar.UpdateBarStatusHealth(mobileId)

	-- is this mobile a party member?
	if IsPartyMember(mobileId) then
		
		-- mana bar window name
		local manabar = barData.windowName .. "ManaBar"

		-- initialize the mana bar background
		StatusBarSetBackgroundTint(manabar, 200, 200, 200)

		-- initializing percentage label at 0%
		LabelSetText(manabar .. "Perc", L"0%")

		-- mana bar window name
		local staminabar = barData.windowName .. "StaminaBar"

		-- initialize the stamina bar background
		StatusBarSetBackgroundTint(staminabar, 200, 200, 200)

		-- initializing percentage label at 0%
		LabelSetText(staminabar .. "Perc", L"0%")

		-- update the mana bar
		MobileHealthBar.UpdateBarStatusMana(mobileId)

		-- update the stamina bar
		MobileHealthBar.UpdateBarStatusStamina(mobileId)

		-- toggle the party leader flag
		WindowSetShowing(barData.windowName .. "Crown", mobileStatus.isPartyLeader == true)
	end

	-- is the mobile a pet?
	if IsObjectIdPet(mobileId) then

		-- start to check the if it's a summon
		MobileHealthBar.DelayedSummonCheck(mobileStatus.name, mobileId)
		
		-- reset the summon timer text
		if DoesWindowExist(barData.windowName .. "SummonTimerPerc") then
			LabelSetText(barData.windowName .. "SummonTimerPerc", L"0")
		end

		-- reset the pet progress perc
		if DoesWindowExist(barData.windowName .. "PetProgressPerc") then
			LabelSetText(barData.windowName .. "PetProgressPerc", L"0")
		end

		-- does this mobile have a summon timer active?
		if MobileHealthBar.SummonTimer and MobileHealthBar.SummonTimer[mobileId] then

			-- is the bar size incorrect?
			if barData.defaultHeight ~= MobileHealthBar.PetBarHeight then

				-- change the default height for the bar
				barData.defaultHeight = MobileHealthBar.PetBarHeight

				-- retract the bar so it will be resized properly
				MobileHealthBar.Retract(barData.windowName)

				-- flag the bar is not been resized (for default size)
				barData.resized = nil
			end

			-- update summon timer bar
			MobileHealthBar.ManageSummonTime(mobileId)

		else -- no summon timer

			-- clear the summon timer bar
			MobileHealthBar.ClearSummonTimerBar(mobileId)

			-- has the bar already been resized for default size?
			if not barData.resized then

				-- retract the bar so it will be resized properly
				MobileHealthBar.Retract(barData.windowName)

				-- flag the bar as resized
				barData.resized = true
			end
		end

		-- update the pet power hour star status
		MobileHealthBar.ManagePetPowerHour(mobileId)

		-- does the pet requires a progress bar?
		if IsValidID(AnimalLore.GetProgressID(mobileId, mobileStatus.name)) then
	
			-- is the bar size incorrect?
			if barData.defaultHeight ~= MobileHealthBar.PetBarHeight then

				-- change the default height for the bar
				barData.defaultHeight = MobileHealthBar.PetBarHeight

				-- retract the bar so it will be resized properly
				MobileHealthBar.Retract(barData.windowName)

				-- flag the bar is not been resized (for default size)
				barData.resized = nil
			end

			-- update the progress status
			MobileHealthBar.UpdateBarStatusPetProgress(mobileId)

		else -- is the pet progress bar visible (while it shouldn't)?

			-- remove the pet progress bar
			MobileHealthBar.ClearPetProgressBar(mobileId)

			-- has the bar already been resized for default size?
			if not barData.resized then

				-- retract the bar so it will be resized properly
				MobileHealthBar.Retract(barData.windowName)

				-- flag the bar as resized
				barData.resized = true
			end
		end
	end
end

function MobileHealthBar.UpdateBarStatusHealth(mobileId)

	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return
	end
	
	-- current mobile data record
	local mobileStatus = Interface.ActiveMobilesOnScreen[mobileId]

	-- do we have the mobile data?
	if not mobileStatus or not mobileStatus.maxHealth then
		
		-- update the status
		Interface.UpdateMobileOnScreenStatus(mobileId)

		return
	end

	-- create a variable as pointer for the bar record
	local barData = MobileHealthBar.ActiveBars[mobileId]

	-- if the bar don't exist or is disabled, we can get out
	if not barData or not barData.windowName or not DoesWindowExist(barData.windowName) or barData.disabled then
		return
	end

	-- healthbar window name
	local healthbar = barData.windowName .. "HealthBar"

	-- update the bar status
	StatusBarSetMaximumValue(healthbar, mobileStatus.maxHealth)
	StatusBarSetCurrentValue(healthbar, mobileStatus.curHealth)	
	
	-- do we have the hp percent?
	if mobileStatus.perc then

		-- update the hp percentage
		LabelSetText(healthbar .. "Perc", towstring(mobileStatus.perc) .. L"%")

		-- scale the text color to become red when is near 0
		WindowUtils.ScaleTextRedByPerc(healthbar .. "Perc", mobileStatus.perc)
	end

	-- is this the player bar?
	if mobileId == GetPlayerID() then
		
		-- if we don't have the player health value label, the bar has been created with the wrong template somehow...
		if not DoesWindowExist(healthbar .. "Value") then

			-- close the healthbar
			MobileHealthBar.CloseBarByID(mobileId, "Player party bar with wrong template")

			return
		end

		-- update the hp percentage
		LabelSetText(healthbar .. "Value", towstring(mobileStatus.curHealth) .. L" / " .. towstring(mobileStatus.maxHealth))

		-- scale the text color to become red when is near 0
		WindowUtils.ScaleTextRedByPerc(healthbar .. "Value", mobileStatus.perc)
	end

	-- update the healthbar color
	MobileHealthBar.UpdateHealthBarColor(mobileId)
end

function MobileHealthBar.UpdateBarStatusMana(mobileId)

	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return
	end
	
	-- current mobile data record
	local mobileStatus = Interface.ActiveMobilesOnScreen[mobileId]

	-- do we have the mobile data?
	if not mobileStatus or not mobileStatus.maxMana then

		-- update the status
		Interface.UpdateMobileOnScreenStatus(mobileId)

		return
	end

	-- create a variable as pointer for the bar record
	local barData = MobileHealthBar.ActiveBars[mobileId]

	-- if the bar don't exist or is disabled, we can get out
	if not barData or not barData.windowName or not DoesWindowExist(barData.windowName) or barData.disabled then
		return
	end

	-- mana bar window name
	local manabar = barData.windowName .. "ManaBar"

	-- set the bar color
	HealthBarColor.UpdateHealthBarColor(manabar, HealthBarColor.HealthVisualState.Mana - 1)

	-- update the bar status
	StatusBarSetMaximumValue(manabar, mobileStatus.maxMana)
	StatusBarSetCurrentValue(manabar, mobileStatus.curMana)

	-- calculate the percent value
	local perc = math.floor((mobileStatus.curMana / mobileStatus.maxMana) * 100)

	-- do we have a valid percent?
	if math.isINF(perc) or math.isNAN(perc) or perc < 0 or perc > 100 then

		-- if it's invalid, we use 0 as default
		perc = 0
	end

	-- is this the player bar?
	if mobileId == GetPlayerID() then
		
		-- update the hp percentage
		LabelSetText(manabar .. "Value", towstring(mobileStatus.curMana) .. L" / " .. towstring(mobileStatus.maxMana))

		-- scale the text color to become red when is near 0
		WindowUtils.ScaleTextRedByPerc(manabar .. "Value", perc)
	end

	-- update the mana percentage
	LabelSetText(manabar .. "Perc", towstring(perc) .. L"%")

	-- scale the text color to become red when is near 0
	WindowUtils.ScaleTextRedByPerc(manabar .. "Perc", perc)
end

function MobileHealthBar.UpdateBarStatusStamina(mobileId)

	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return
	end
	
	-- current mobile data record
	local mobileStatus = Interface.ActiveMobilesOnScreen[mobileId]

	-- do we have the mobile data?
	if not mobileStatus or not mobileStatus.maxStamina then

		-- update the status
		Interface.UpdateMobileOnScreenStatus(mobileId)

		return
	end

	-- create a variable as pointer for the bar record
	local barData = MobileHealthBar.ActiveBars[mobileId]

	-- if the bar don't exist or is disabled, we can get out
	if not barData or not barData.windowName or not DoesWindowExist(barData.windowName) or barData.disabled then
		return
	end

	-- stamina bar window name
	local staminahbar = barData.windowName .. "StaminaBar"
	
	-- set the bar color
	HealthBarColor.UpdateHealthBarColor(staminahbar, HealthBarColor.HealthVisualState.Stamina - 1)

	-- update the bar status
	StatusBarSetMaximumValue(staminahbar, mobileStatus.maxStamina)
	StatusBarSetCurrentValue(staminahbar, mobileStatus.curStamina)	

	-- calculate the percent value
	local perc =  math.floor((mobileStatus.curStamina / mobileStatus.maxStamina) * 100)

	-- do we have a valid percent?
	if math.isINF(perc) or math.isNAN(perc) or perc < 0 or perc > 100 then

		-- if it's invalid, we use 0 as default
		perc = 0
	end

	-- is this the player bar?
	if mobileId == GetPlayerID() then
		
		-- update the hp percentage
		LabelSetText(staminahbar .. "Value", towstring(mobileStatus.curStamina) .. L" / " .. towstring(mobileStatus.maxStamina))

		-- scale the text color to become red when is near 0
		WindowUtils.ScaleTextRedByPerc(staminahbar .. "Value", perc)
	end

	-- update the stamina percentage
	LabelSetText(staminahbar .. "Perc", towstring(perc) .. L"%")

	-- scale the text color to become red when is near 0
	WindowUtils.ScaleTextRedByPerc(staminahbar .. "Perc", perc)
end

function MobileHealthBar.UpdateBarStatusPetProgress(mobileId)

	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return
	end

	-- current mobile data record
	local mobileStatus = Interface.ActiveMobilesOnScreen[mobileId]

	-- do we have the mobile data?
	if not mobileStatus then
		return
	end

	-- create a variable as pointer for the bar record
	local barData = MobileHealthBar.ActiveBars[mobileId]

	-- if the bar don't exist or is disabled, we can get out
	if not barData or not barData.windowName or not DoesWindowExist(barData.windowName) or barData.disabled then
		return
	end
	
	-- is the base height for the bar wrong?
	if barData.defaultHeight ~= MobileHealthBar.PetBarHeight then

		-- change the default height for the bar
		barData.defaultHeight = MobileHealthBar.PetBarHeight

		-- retract the bar so it will be resized properly
		MobileHealthBar.Retract(barData.windowName)
	end

	-- progress bar window name
	local progressbar = barData.windowName .. "PetProgress"

	-- progress bar percentage
	local progressbarPerc = progressbar .. "Perc"

	-- does the progress bar exist?
	if not DoesWindowExist(progressbarPerc) then
		return
	end

	-- show the bar
	WindowSetShowing(progressbar, true)
	WindowSetShowing(progressbarPerc, true)

	-- initialize the progress bar background
	StatusBarSetBackgroundTint(progressbar, 200, 200, 200)

	-- color the bar
	StatusBarSetForegroundTint(progressbar, 106, 106, 255)

	-- get the progress percent
	local progress = AnimalLore.PetProgress[AnimalLore.GetProgressID(mobileId, mobileStatus.name)].perc

	-- update the bar status
	StatusBarSetMaximumValue(progressbar, 100)
	StatusBarSetCurrentValue(progressbar, tonumber(progress))

	-- set the progress text
	LabelSetText(progressbarPerc, progress)
end

function MobileHealthBar.ManageSummonTime(mobileId)

	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return
	end

	-- current mobile data record
	local mobileStatus = Interface.ActiveMobilesOnScreen[mobileId]

	-- do we have the mobile data?
	if not mobileStatus then
		return
	end

	-- create a variable as pointer for the bar record
	local barData = MobileHealthBar.ActiveBars[mobileId]

	-- if the bar don't exist or is disabled, we can get out
	if not barData or not barData.windowName or not DoesWindowExist(barData.windowName) or barData.disabled then
		return
	end
	
	-- is the base height for the bar wrong?
	if barData.defaultHeight ~= MobileHealthBar.PetBarHeight then

		-- change the default height for the bar
		barData.defaultHeight = MobileHealthBar.PetBarHeight

		-- retract the bar so it will be resized properly
		MobileHealthBar.Retract(barData.windowName)
	end

	-- progress bar window name
	local summonBar = barData.windowName .. "SummonTimer"

	-- progress bar percentage
	local summonBarPerc = summonBar .. "Perc"

	-- show the bar
	WindowSetShowing(summonBar, true)
	WindowSetShowing(summonBarPerc, true)

	-- initialize the progress bar background
	StatusBarSetBackgroundTint(summonBar, 200, 200, 200)

	-- color the bar
	StatusBarSetForegroundTint(summonBar, 106, 106, 255)

	-- get the progress percent
	local progress = MobileHealthBar.SummonTimer[mobileId]
	
	-- do we have a maximum for the bar set already?
	if StatusBarGetMaximumValue(summonBar) == 0 then

		-- set the maximum as the current value
		StatusBarSetMaximumValue(summonBar, tonumber(progress))
	end

	-- update the bar status
	StatusBarSetCurrentValue(summonBar, tonumber(progress))	

	-- set the progress text
	LabelSetText(summonBarPerc, StringUtils.CountDownSeconds(tonumber(progress)))
end

function MobileHealthBar.ClearPetProgressBar(mobileId)

	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return
	end
	
	-- create a variable as pointer for the bar record
	local barData = MobileHealthBar.ActiveBars[mobileId]

	-- if the bar don't exist, we can get out
	if not barData or not barData.windowName or not DoesWindowExist(barData.windowName) then
		return
	end

	-- reset the progress bar
	if DoesWindowExist(barData.windowName .. "PetProgress") then
		WindowSetShowing(barData.windowName .. "PetProgress", false)
		WindowSetShowing(barData.windowName .. "PetProgressPerc", false)
		LabelSetText(barData.windowName .. "PetProgressPerc", L"" )
	end
end

function MobileHealthBar.ClearSummonTimerBar(mobileId)

	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return
	end
	
	-- create a variable as pointer for the bar record
	local barData = MobileHealthBar.ActiveBars[mobileId]

	-- if the bar don't exist, we can get out
	if not barData or not barData.windowName or not DoesWindowExist(barData.windowName) then
		return
	end

	-- reset the summon timer bar
	if DoesWindowExist(barData.windowName .. "SummonTimer") then
		WindowSetShowing(barData.windowName .. "SummonTimer", false)
		WindowSetShowing(barData.windowName .. "SummonTimerPerc", false)
		LabelSetText(barData.windowName .. "SummonTimerPerc", L"" )
	end
end

function MobileHealthBar.UpdateHealthBarColor(mobileId)
	
	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return
	end
	
	-- current mobile data record
	local mobileStatus = Interface.ActiveMobilesOnScreen[mobileId]

	-- do we have the mobile data?
	if not mobileStatus then
		return
	end

	-- no need to update invulnerable mobiles status
	if mobileStatus.invulnerable then
		return
	end

	-- create a variable as pointer for the bar record
	local barData = MobileHealthBar.ActiveBars[mobileId]

	-- if the bar don't exist, we can get out
	if not barData or not barData.windowName or not DoesWindowExist(barData.windowName) or barData.disabled then
		return
	end

	-- health bar window name
	local healthbar = barData.windowName .. "HealthBar"
		
	-- do we have the healthbar colors yet?
	if WindowData.HealthBarColor[mobileId] then
		
		-- update the healthbar color
		HealthBarColor.UpdateHealthBarColor(healthbar, mobileId == GetPlayerID() and WindowData.PlayerStatus.VisualStateId or WindowData.HealthBarColor[mobileId].VisualStateId)

	else -- update as soon as we have them
		Interface.ExecuteWhenAvailable(
		{
			name = "UpdateBarColors" .. mobileId,
			check = function() return WindowData.HealthBarColor[mobileId] ~= nil end, 
			callback = function() HealthBarColor.UpdateHealthBarColor(healthbar, mobileId == GetPlayerID() and WindowData.PlayerStatus.VisualStateId or WindowData.HealthBarColor[mobileId].VisualStateId) end, 
			removeOnComplete = true
		})

		-- update the healthbar color with a default color
		HealthBarColor.UpdateHealthBarColor(healthbar, 0)
	end
end

function MobileHealthBar.ForceUpdatePetProgress()

	-- scan all the progress we know for our pets
	for progressID, pet in pairs(AnimalLore.PetProgress) do

		-- do we have the pet ID?
		if IsValidID(pet.id) then
		
			-- update the pet progress
			MobileHealthBar.UpdateBarStatusPetProgress(pet.id)

		else -- update pet progress bar based on pet name

			-- scan all the active healthbars
			for mobileId, data in pairs(MobileHealthBar.ActiveBars) do

				-- is this a pet healthbar?
				if IsObjectIdPet(mobileId) and Interface.ActiveMobilesOnScreen[mobileId] then

					-- get the pet name
					local mobName = wstring.lower(Interface.ActiveMobilesOnScreen[mobileId].name)

					-- is this the pet we're looking for?
					if mobName == pet.name then
						
						-- update the pet progress
						MobileHealthBar.UpdateBarStatusPetProgress(mobileId)
					end
				end
			end
		end
	end
end

function MobileHealthBar.InitializeButtons(mobileId)

	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return
	end

	-- create a variable as pointer for the bar record
	local barData = MobileHealthBar.ActiveBars[mobileId]

	-- if the bar don't exist, we can get out
	if not barData or not barData.windowName or not DoesWindowExist(barData.windowName) then
		return
	end

	-- get the mobile data for the specified ID
	local mobileData = Interface.ActiveMobilesOnScreen[mobileId]

	-- no mobile data (this should not happen since we have all the data for the mobiles on screen)
	if not mobileData then
		return
	end

	-- update the flags (like vendor, questgiver, etc...)
	Interface.UpdateMobileOnScreenNameFlags(mobileId, true)

	-- toggle the questgiver flag
	WindowSetShowing(barData.windowName .. "QuestGiver", mobileData.isQuestGiver == true)

	-- buttons container
	local mainButtonsWindow = barData.windowName .. "Buttons"

	-- main window scale
	local scale = WindowGetScale(barData.windowName)

	-- this tabele will have the main index as the row and the value as the buttons window name
	barData.buttons = {}

	-- count the created buttons
	local newButtons = 0

	-- is the mobile invulnerable?
	if mobileData.invulnerable then

		-- create the buttons for the invulnerable mobile
		MobileHealthBar.CreateInvulnerableButtons(mobileId)

	-- is this mobile a pet?
	elseif IsObjectIdPet(mobileId) then
		
		-- create the pet buttons
		MobileHealthBar.CreatePetButtons(mobileId)
	
	-- is this a party member?
	elseif IsPartyMember(mobileId) then

		-- create the party buttons
		MobileHealthBar.CreatePartyButtons(mobileId)

	else -- any other healthbar
		
		-- create the buttons for the mobile
		MobileHealthBar.CreateOthersButtons(mobileId)
	end

	-- do we have any button?
	if #barData.buttons > 0 then

		-- calculate the expanded bar height based on how many buttons lines we have
		barData.expandedHeight = barData.defaultHeight + (#barData.buttons * 40) + 5

		-- is this a pet bar?
		if IsObjectIdPet(mobileId) and not mobileData.isSummon and not IsValidID(AnimalLore.GetProgressID(mobileId, mobileData.name)) then

			-- increase the margin (without the progress bar there are some glitches on the bottom)
			barData.expandedHeight = barData.expandedHeight + 15

		-- is this a party member?
		elseif IsPartyMember(mobileId) then

			-- increase the margin
			barData.expandedHeight = barData.expandedHeight + 5
		end

	else -- no buttons
		barData.expandedHeight = barData.defaultHeight
	end

	-- this will be used to calculate the space between the buttons
	local spacing = 0

	-- element to be used as anchor point for the first element of the line
	local anchorElement = mainButtonsWindow

	-- previous button of the same line
	local prevButton

	-- scan all buttons lines
	for line, buttonsInLine in pairsByIndex(barData.buttons) do

		-- scan all buttons for the current line
		for index, buttonName in pairsByIndex(buttonsInLine) do
			
			-- is this the first button of the line?
			if index == 1 then

				-- get the button dimensions
				local x, h = WindowGetDimensions(buttonName)

				-- calculating the space between buttons for this row
				spacing = (MobileHealthBar.DefaultWidth - (x * #buttonsInLine)) / (#buttonsInLine + 1)

				-- is this the first line?
				if line == 1 then

					-- anchor the button to the top left of the buttons container
					WindowAddAnchor(buttonName, "topleft", anchorElement, "topleft", spacing, 0)

				else -- other lines

					-- anchor the button to a new line
					WindowAddAnchor(buttonName, "topleft", anchorElement, "topleft", spacing, ((line - 1) * (h + 5)))
				end

				-- store the button name as previous button
				prevButton = buttonName

			else -- other buttons of the row

				-- anchor the button to the 
				WindowAddAnchor(buttonName, "topright", prevButton, "topleft", spacing, 0)

				-- store the button name as previous button
				prevButton = buttonName
			end
		end
	end
end

function MobileHealthBar.CreateSingleButton(mobileId, buttonName, buttonTemplate, line)

	-- do we have valid parameters?
	if not IsValidID(mobileId) or not IsValidString(buttonName) or not IsValidString(buttonTemplate) or not IsValidID(line) then
		return
	end

	-- create a variable as pointer for the bar record
	local barData = MobileHealthBar.ActiveBars[mobileId]

	-- if the bar don't exist or is disabled, we can get out
	if not barData or not barData.windowName or not DoesWindowExist(barData.windowName) or barData.disabled then
		return
	end

	-- buttons container
	local mainButtonsWindow = barData.windowName .. "Buttons"

	-- bank button name
	local finalButtonName = mainButtonsWindow .. buttonName

	-- main window scale
	local scale = WindowGetScale(barData.windowName)

	-- do we have to create the buy button?
	if not DoesWindowExist(finalButtonName) then
		
		-- create the button
		CreateWindowFromTemplate(finalButtonName, buttonTemplate, mainButtonsWindow)

		-- scale the button with the main window
		WindowSetScale(finalButtonName, scale)
	
	else -- the button already exist

		-- clear the anchors
		WindowClearAnchors(finalButtonName)
	end

	-- is this the red/green/blue button?
	if string.find(buttonTemplate, "Red", 1, true) or string.find(buttonTemplate, "Green", 1, true) or string.find(buttonTemplate, "Blue", 1, true) then

		-- draw the red button
		MobileHealthBar.DrawSpellIcon(mobileId, finalButtonName, string.gsub(buttonTemplate, "ButtonTemplate", ""))
	end

	-- do we have the buttons table?
	if not barData.buttons then
		barData.buttons = {}
	end

	-- do we have the record for the requested line?
	if not barData.buttons[line] then
		barData.buttons[line] = {}
	end

	-- insert the buy button in the line
	table.insert(barData.buttons[line], finalButtonName)
end

function MobileHealthBar.CreateInvulnerableButtons(mobileId)

	-- get the mobile data for the specified ID
	local mobileData = Interface.ActiveMobilesOnScreen[mobileId]

	-- no mobile data (this should not happen since we have all the data for the mobiles on screen)
	if not mobileData then
		return
	end

	-- create a variable as pointer for the bar record
	local barData = MobileHealthBar.ActiveBars[mobileId]

	-- if the bar don't exist, we can get out
	if not barData or not barData.windowName or not DoesWindowExist(barData.windowName) then
		return
	end

	-- buttons container
	local mainButtonsWindow = barData.windowName .. "Buttons"

	-- is the mobile invulnerable?
	if mobileData.invulnerable then

		-- is this mobile a shopkeeper?
		if mobileData.isShopkeeper then

			-- create buy button
			MobileHealthBar.CreateSingleButton(mobileId, "Buy", "BuyIconTemplate", 1)

			-- create sell button
			MobileHealthBar.CreateSingleButton(mobileId, "Sell", "SellIconTemplate", 1)
		end

		-- is this mobile a banker?
		if mobileData.isBanker then
		
			-- create bank button
			MobileHealthBar.CreateSingleButton(mobileId, "Bank", "BankIconTemplate", 1)
		end

		-- is this mobile a stable master?
		if mobileData.isStableMaster then
		
			-- create stable button
			MobileHealthBar.CreateSingleButton(mobileId, "Stable", "StableIconTemplate", 1)
		end

		-- is this mobile a bod dealer?
		if mobileData.isBodDealer then

			-- does the player has the skill to get the bods?
			if IsBodDealer(mobileId) then

				-- create bod button
				MobileHealthBar.CreateSingleButton(mobileId, "Bod", "BodIconTemplate", 2)

				-- create bribe button
				MobileHealthBar.CreateSingleButton(mobileId, "Bribe", "BribeIconTemplate", 2)

			else -- destroy the buttons
				DestroyWindow(mainButtonsWindow .. "Bod")
				DestroyWindow(mainButtonsWindow .. "Bribe")
			end
		end
	end
end

function MobileHealthBar.CreatePetButtons(mobileId)

	-- get the mobile data for the specified ID
	local mobileData = Interface.ActiveMobilesOnScreen[mobileId]

	-- no mobile data (this should not happen since we have all the data for the mobiles on screen)
	if not mobileData then
		return
	end

	-- create a variable as pointer for the bar record
	local barData = MobileHealthBar.ActiveBars[mobileId]

	-- if the bar don't exist, we can get out
	if not barData or not barData.windowName or not DoesWindowExist(barData.windowName) then
		return
	end

	-- buttons container
	local mainButtonsWindow = barData.windowName .. "Buttons"
	
	-- is this mobile a pet?
	if IsObjectIdPet(mobileId) then

		-- is this a controllable summon or not a summon?
		if (not mobileData.isSummon or (mobileData.isSummon and mobileData.isControllableSummon)) and not mobileData.isFamiliar then

			-- create stay button
			MobileHealthBar.CreateSingleButton(mobileId, "Stay", "StayIconTemplate", 1)

			-- create stop button
			MobileHealthBar.CreateSingleButton(mobileId, "Stop", "StopIconTemplate", 1)

			-- create follow button
			MobileHealthBar.CreateSingleButton(mobileId, "Follow", "FollowIconTemplate", 1)

			-- create guard button
			MobileHealthBar.CreateSingleButton(mobileId, "Guard", "GuardIconTemplate", 1)

			-- create kill button
			MobileHealthBar.CreateSingleButton(mobileId, "Kill", "KillIconTemplate", 1)

			-- default line for the red green blue buttons
			local rgbLine = 3

			-- limit the rename button to the normal pets
			if not mobileData.isSummon then

				-- create rename button
				MobileHealthBar.CreateSingleButton(mobileId, "Rename", "RenameIconTemplate", 2)
				
			 -- summons red green buttons goes on the second line instead of the third (if they don't have the inventory or they are not controllable summons)
			elseif not mobileData.hasAccessibleInventory and not mobileData.isControllableSummon then
				rgbLine = 2
			end

			-- create red button
			MobileHealthBar.CreateSingleButton(mobileId, "RedButton", "RedButtonTemplate", rgbLine)

			-- create green button
			MobileHealthBar.CreateSingleButton(mobileId, "GreenButton", "GreenButtonTemplate", rgbLine)

			-- create blue button
			MobileHealthBar.CreateSingleButton(mobileId, "BlueButton", "BlueButtonTemplate", rgbLine)
		end

		-- does this pet has an inventory?
		if mobileData.hasAccessibleInventory then

			-- the button by default is in the second line
			local line = 2

			-- if it's a familiar it goes on the first line
			if mobileData.isFamiliar then
				line = 1
			end

			-- create inventory button
			MobileHealthBar.CreateSingleButton(mobileId, "Inventory", "PetInventoryIconTemplate", line)

		else -- destroy the button
			DestroyWindow(mainButtonsWindow .. "Inventory")
		end

		-- does the player has 66+ magery and is a summon?
		if mobileData.isSummon and not mobileData.isControllableSummon and GetSkillValue(SkillsWindow.SkillsID.MAGERY, true) >= 66 then

			-- the button by default is in the second line
			local line = 2

			-- if the summon is not controllable, it goes on the first
			if not mobileData.isControllableSummon then
				line = 1
			end

			-- create mass dispel button
			MobileHealthBar.CreateSingleButton(mobileId, "MassDispel", "MassDispelIconTemplate", line)

		else -- destroy the button
			DestroyWindow(mainButtonsWindow .. "MassDispel")
		end

		-- is this a controllable summon or a pet
		if (mobileData.isSummon and mobileData.isControllableSummon) or mobileData.isFamiliar then

			-- the button by default is in the second line
			local line = 2

			-- if is a familiar, it goes on the first
			if mobileData.isFamiliar then
				line = 1
			end

			-- create mass dispel button
			MobileHealthBar.CreateSingleButton(mobileId, "Release", "ReleaseIconTemplate", line)

		else -- destroy the button
			DestroyWindow(mainButtonsWindow .. "Release")
		end

		-- does the player has animal lore and is not a summon?
		if not mobileData.isSummon and GetSkillValue(SkillsWindow.SkillsID.ANIMAL_LORE, true) > 0 then

			-- create animal lore button
			MobileHealthBar.CreateSingleButton(mobileId, "AnimalLore", "AnimalLoreIconTemplate", 2)

		else -- destroy the button
			DestroyWindow(mainButtonsWindow .. "AnimalLore")
		end

		-- does the player has veterinary and is not a summon?
		if not mobileData.isSummon and GetSkillValue(SkillsWindow.SkillsID.VETERINARY, true) > 0 then

			-- create veterinary button
			MobileHealthBar.CreateSingleButton(mobileId, "Veterinary", "VeterinaryIconTemplate", 2)

		else -- destroy the button
			DestroyWindow(mainButtonsWindow .. "Veterinary")
		end
	end
end

function MobileHealthBar.CreatePartyButtons(mobileId)

	-- get the mobile data for the specified ID
	local mobileData = Interface.ActiveMobilesOnScreen[mobileId]

	-- no mobile data (this should not happen since we have all the data for the mobiles on screen)
	if not mobileData then
		return
	end

	-- create a variable as pointer for the bar record
	local barData = MobileHealthBar.ActiveBars[mobileId]

	-- if the bar don't exist, we can get out
	if not barData or not barData.windowName or not DoesWindowExist(barData.windowName) then
		return
	end

	-- buttons container
	local mainButtonsWindow = barData.windowName .. "Buttons"

	-- is this a party member?
	if IsPartyMember(mobileId) then

		-- default line for the red green blue buttons
		local rgbLine = 1

		-- does the player has healing?
		if GetSkillValue(SkillsWindow.SkillsID.HEALING, true) > 0 then

			-- create healing button
			MobileHealthBar.CreateSingleButton(mobileId, "Healing", "HealingIconTemplate", 1)

			-- move the red, green, blue buttons to line 2
			rgbLine = 2

		else -- destroy the button
			DestroyWindow(mainButtonsWindow .. "Healing")
		end

		-- does the player has 80+ magery?
		if mobileData.dead and GetSkillValue(SkillsWindow.SkillsID.MAGERY, true) >= 80 then

			-- create resurrection button
			MobileHealthBar.CreateSingleButton(mobileId, "Resurrection", "ResurrectionIconTemplate", 1)

			-- move the red, green, blue buttons to line 2
			rgbLine = 2

		else -- destroy the button
			DestroyWindow(mainButtonsWindow .. "Resurrection")
		end

		-- create red button
		MobileHealthBar.CreateSingleButton(mobileId, "RedButton", "RedButtonTemplate", rgbLine)

		-- create green button
		MobileHealthBar.CreateSingleButton(mobileId, "GreenButton", "GreenButtonTemplate", rgbLine)

		-- create blue button
		MobileHealthBar.CreateSingleButton(mobileId, "BlueButton", "BlueButtonTemplate", rgbLine)
	end
end

function MobileHealthBar.CreateOthersButtons(mobileId)

	-- get the mobile data for the specified ID
	local mobileData = Interface.ActiveMobilesOnScreen[mobileId]

	-- no mobile data (this should not happen since we have all the data for the mobiles on screen)
	if not mobileData then
		return
	end

	-- create a variable as pointer for the bar record
	local barData = MobileHealthBar.ActiveBars[mobileId]

	-- if the bar don't exist, we can get out
	if not barData or not barData.windowName or not DoesWindowExist(barData.windowName) then
		return
	end

	-- buttons container
	local mainButtonsWindow = barData.windowName .. "Buttons"

	-- default line for the red green blue buttons
	local rgbLine = 1

	-- check if the player has controllable summons and the mobile is not a friend
	if GetControllableFollowersCount() > 0 and mobileData.notoriety ~= NameColor.Notoriety.FRIEND then

		-- create kill button
		MobileHealthBar.CreateSingleButton(mobileId, "Attack", "KillIconTemplate", 1)

		-- move the red, green, blue buttons to line 2
		rgbLine = 2

	else -- destroy the button
		DestroyWindow(mainButtonsWindow .. "Attack")
	end

	-- does the player has 50+ bushido and the mobile is not a friend?
	if GetSkillValue(SkillsWindow.SkillsID.BUSHIDO, true) >= 50 and mobileData.notoriety ~= NameColor.Notoriety.FRIEND then

		-- create honor button
		MobileHealthBar.CreateSingleButton(mobileId, "Honor", "HonorIconTemplate", 1)

		-- move the red, green, blue buttons to line 2
		rgbLine = 2

	else -- destroy the button
		DestroyWindow(mainButtonsWindow .. "Honor")
	end

	-- does the player has 80+ spellweaving and the mobile is not a friend?
	if GetSkillValue(SkillsWindow.SkillsID.SPELLWEAVING, true) >= 80 and mobileData.notoriety ~= NameColor.Notoriety.FRIEND then

		-- create wod button
		MobileHealthBar.CreateSingleButton(mobileId, "Wod", "WodIconTemplate", 1)

		-- move the red, green, blue buttons to line 2
		rgbLine = 2

	else -- destroy the button
		DestroyWindow(mainButtonsWindow .. "Wod")
	end

	-- does the player has animal lore and is not a mobile with paperdoll?
	if not HasPaperdoll(mobileId) and GetSkillValue(SkillsWindow.SkillsID.ANIMAL_LORE, true) > 0 then

		-- create animal lore button
		MobileHealthBar.CreateSingleButton(mobileId, "AnimalLore", "AnimalLoreIconTemplate", 1)

		-- move the red, green, blue buttons to line 2
		rgbLine = 2

	else -- destroy the button
		DestroyWindow(mainButtonsWindow .. "AnimalLore")
	end

	-- can the mobile be healed? with what skill?
	local isHealAble, mainHealSkill = MobileHealthBar.IsEligibleForHealings(mobileId)

	-- can the mobile be healed?
	if isHealAble then

		-- humanoid, can be healed with healing
		if mainHealSkill == "Healing" then

			-- does the player has healing?
			if GetSkillValue(SkillsWindow.SkillsID.HEALING, true) > 0 then

				-- create healing button
				MobileHealthBar.CreateSingleButton(mobileId, "Healing", "HealingIconTemplate", 1)

				-- move the red, green, blue buttons to line 2
				rgbLine = 2

			else -- destroy the button
				DestroyWindow(mainButtonsWindow .. "Healing")
			end

			-- does the player has 80+ magery?
			if mobileData.dead and GetSkillValue(SkillsWindow.SkillsID.MAGERY, true) >= 80 then

				-- create resurrection button
				MobileHealthBar.CreateSingleButton(mobileId, "Resurrection", "ResurrectionIconTemplate", 1)

				-- move the red, green, blue buttons to line 2
				rgbLine = 2

			else -- destroy the button
				DestroyWindow(mainButtonsWindow .. "Resurrection")
			end

		else -- someone's pet, can be healed with veterinary
				
			-- does the player has veterinary and is not a summon?
			if not mobileData.isSummon and GetSkillValue(SkillsWindow.SkillsID.VETERINARY, true) > 0 then

				-- create veterinary button
				MobileHealthBar.CreateSingleButton(mobileId, "Veterinary", "VeterinaryIconTemplate", 1)

				-- move the red, green, blue buttons to line 2
				rgbLine = 2

			else -- destroy the button
				DestroyWindow(mainButtonsWindow .. "Veterinary")
			end
		end
	end

	-- create red button
	MobileHealthBar.CreateSingleButton(mobileId, "RedButton", "RedButtonTemplate", rgbLine)

	-- create green button
	MobileHealthBar.CreateSingleButton(mobileId, "GreenButton", "GreenButtonTemplate", rgbLine)

	-- create blue button
	MobileHealthBar.CreateSingleButton(mobileId, "BlueButton", "BlueButtonTemplate", rgbLine)

end

function MobileHealthBar.DrawSpellIcon(mobileId, buttonWindow, buttonName)

	-- spell icon name
	local spellIcon = buttonWindow .. "SquareIcon"

	-- get the spell ID for the red button
	local spellId = MobileHealthBar.GetButtonSpellID(mobileId, buttonName)
	
	-- no spell specified, we can destroy the button
	if not IsValidID(spellId) then
			
		-- delete the icon
		DynamicImageSetTexture(spellIcon, "", 0, 0 )

	else
		-- get the icon ID
		local iconId = GetAbilityData(spellId)

		-- get the icon informations
		local texture, x, y = GetIconData(iconId)

		-- draw the icon
		DynamicImageSetTexture(spellIcon, texture, x, y)
	end
end

function MobileHealthBar.GetButtonSpellID(mobileId, buttonName)

	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return
	end

	-- get which red button spell to use for the selected mobile
	local buttonDef = Interface.LoadSetting(buttonName .. "ButtonDef_" .. mobileId, Interface[buttonName .. "Def"])
	
	-- do we have a default value? (if not the buttonName is wrong)
	if not buttonDef then
		return
	end 

	-- get the spell ID
	return Interface.Settings[buttonName .. "Button" .. tostring(buttonDef)]
end

function MobileHealthBar.OnButtonClick()

	-- get the current window name
	local windowName = WindowUtils.GetActiveDialog()

	-- get the button window name
	local buttonWindow = SystemData.ActiveWindow.name

	-- get the mobile ID
	local mobileId = WindowGetId(windowName)
	
	-- is this a call from the status window?
	if string.find(windowName, "StatusWindow", 1, true) then

		-- get the player ID
		mobileId = GetPlayerID()
	end

	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return
	end

	-- scan all the possible buttons
	for name, data in pairs(MobileHealthBar.ButtonsData) do

		-- is this the current button?
		if string.find(buttonWindow, name, 1, true) then
			
			-- execute the callback
			data.callback(mobileId)

			break
		end
	end
end

function MobileHealthBar.OnMouseOver()

	-- get the current window name
	local windowName = WindowUtils.GetActiveDialog()

	-- get the button window name
	local buttonWindow = SystemData.ActiveWindow.name
	
	-- does the window still exist and is showing?
	if not DoesWindowExist(windowName) or not WindowGetShowing(windowName) then
		return
	end

	-- get the mobile ID
	local mobileId = WindowGetId(windowName)

	-- is this a call from the status window?
	if string.find(windowName, "StatusWindow", 1, true) then

		-- get the player ID
		mobileId = GetPlayerID()
	end

	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return
	end

	-- keep the mobile bar expanded
	MobileHealthBar.Expand()

	-- scan all the possible tooltips
	for name, data in pairs(MobileHealthBar.ButtonsData) do

		-- is this the current button?
		if string.find(buttonWindow, name, 1, true) then
		
			-- does this button has a custom function for the tooltip?
			if data.tooltipFunction ~= nil then
				
				-- call the custom function
				data.tooltipFunction(mobileId)

			else -- normal tooltip
				
				-- default title
				local title = L""

				-- if we have the TID for the title, we get that instead of the empty string
				if data.titleTid then
					title = GetStringFromTid(data.titleTid)
				end

				-- default body text
				local body = L""

				-- if we have the TID for the body, we get that instead of the empty string
				if data.bodyTid then
					body = GetStringFromTid(data.bodyTid)
				end

				-- create the item properties data
				local itemData = 
				{ 
					windowName = buttonWindow,
					itemId = 5555,
					itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
					title =	title,
					body = body
				}
			
				-- show the tooltip
				ItemProperties.SetActiveItem(itemData)
			end

			break
		end
	end
end

function MobileHealthBar.PetPowerHourManager(timePassed)

	-- if the interface is shutting down we can avoid everything in here
	if Interface.goingDown then
		return
	end

	-- do we have pet power hours?
	if MobileHealthBar.PetPowerHour then
		
		-- scan all the pet power hours we have
		for mobileID, timeLeft in pairs(MobileHealthBar.PetPowerHour) do

			-- decrease the time remaining on the power hour
			MobileHealthBar.PetPowerHour[mobileID] = timeLeft - 1

			-- is the time over?
			if MobileHealthBar.PetPowerHour[mobileID] <= 0 then

				-- remove the pet power hour from the list
				MobileHealthBar.PetPowerHour[mobileID] = nil
				
				-- update the star on the healthbar
				MobileHealthBar.ManagePetPowerHour(mobileId)
			end
		end
	end
end

function MobileHealthBar.SummonsManager(timePassed)

	-- if the interface is shutting down we can avoid everything in here
	if Interface.goingDown then
		return
	end

	-- do we have active summon timers?
    if not MobileHealthBar.SummonTimer then
		return
	end
	
	-- scan all the summon timers we have
	for mobileId, remainingTime in pairs(MobileHealthBar.SummonTimer) do
		
		-- update the remaining time
		MobileHealthBar.SummonTimer[mobileId] = remainingTime - 1

		-- is the time over?
		if MobileHealthBar.SummonTimer[mobileId] <= 0 then

			-- close the healthbar
			MobileHealthBar.CloseBarByID(mobileId, "Summon time's up")

			-- remove the summon timer
			MobileHealthBar.SummonTimer[mobileId] = nil

			continue

		else -- update the progress bar
			MobileHealthBar.ManageSummonTime(mobileId)
		end
	end
end

function MobileHealthBar.DockspotDuplicateHandle()

	-- scan all the healthbars in search of a duplicate in the grid slot (not the rightMobileId mobile)
	for mobileId, barData in pairs(MobileHealthBar.ActiveBars) do

		-- is this an orphan bar (without dockspot)?
		if not barData.dockspot or not barData.dockGrid then
		
			-- close the healthbar
			MobileHealthBar.CloseBarByID(mobileId, "Remove duplicate")

			continue
		end

		-- remove duplicates for this bar's slot
		MobileHealthBar.RemoveDuplicateOnTheGrid(barData.dockspot, barData.dockGrid, mobileId)
	end
end

function MobileHealthBar.RemoveDuplicateOnTheGrid(dockspotName, dockGrid, rightMobileId)

	-- scan all the healthbars in search of a duplicate in the grid slot (not the rightMobileId mobile)
	for mobileId, barData in pairs(MobileHealthBar.ActiveBars) do

		-- we skip the rightful mobile
		if mobileId == rightMobileId then
			continue
		end

		-- is this bar in the dockspot we need to check?
		if barData.dockspot == dockspotName then

			-- we found a duplicate!
			if barData.dockGrid == dockGrid then
				
				-- resize the grid slot before removing the bar from it
				MobileBarsDockspot.ResizeGridSlot(barData.dockGrid)

				-- reset the grid for this bar
				barData.dockGrid = nil

				-- remove the anchoring for the bar (it will automatically be anchored to the right place later)
				WindowClearAnchors(barData.windowName)
			end
		end
	end
end

function MobileHealthBar.DockToGrid(mobileId)

	-- create a variable as pointer for the bar record
	local barData = MobileHealthBar.ActiveBars[mobileId]

	-- if the bar don't exist or is disabled, we can get out
	if not barData then
		return
	end

	-- create a variable as pointer for the dockspot record
	local dockspotData = MobileBarsDockspot.Dockspots[barData.dockspot]

	-- if the dockspot don't exist we can get out
	if not dockspotData or not DoesWindowExist(barData.dockGrid) or dockspotData.stopUpdate then
		return
	end

	-- reset the bar scale
	WindowSetScale(barData.windowName, InterfaceCore.scale)

	-- load the saved scale/alpha
	WindowUtils.LoadScale(barData.windowName)

	-- kick any other bar out of the grid spot we need to place this one
	MobileHealthBar.RemoveDuplicateOnTheGrid(barData.dockspot, barData.dockGrid, mobileId)
	
	-- is this bar already anchored somewhere?
	if WindowGetAnchorCount(barData.windowName) > 0 then
	
		-- get the anchor data for the bar
		local point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor(barData.windowName, 1)
		
		-- the bar is already anchored to the right grid slot? we can get out
		if relativeTo == barData.dockGrid then
			return
		end		
	end

	-- is the bar NOT pinned and it has been recently created?
	if not barData.pinned and Interface.TimeSinceLogin < barData.creationTime + 1 then

		-- fade-in animation while the data are loading
		WindowStartAlphaAnimation(barData.windowName, Window.AnimationType.SINGLE, 0.1, 1, 1, true, 0, 1)
		Interface.AddTodoList({name = "stop healthbars fade-in", func = function() if DoesWindowExist(barData.windowName) then WindowStopAlphaAnimation(barData.windowName) end end, time = Interface.TimeSinceLogin + 1})

	-- is the bar pinned and it has been recently created?
	elseif barData.pinned and Interface.TimeSinceLogin < barData.creationTime + 1 then
		
		-- blink the bar for a short time
		WindowStartAlphaAnimation(barData.windowName, Window.AnimationType.LOOP, 0, 1, 0.5, true, 0, 2)
		Interface.AddTodoList({name = "stop healthbars blinking", func = function() if DoesWindowExist(barData.windowName) then WindowStopAlphaAnimation(barData.windowName) end end, time = Interface.TimeSinceLogin + 3})
	end
	
	-- clear the bar anchors
	WindowClearAnchors(barData.windowName)

	-- anchor the bar to the grid slot
	WindowAddAnchor(barData.windowName, "topleft", barData.dockGrid, "topleft", 0, 0)

	-- make the slot of the same size of the bar
	WindowSetDimensions(barData.dockGrid, MobileHealthBar.DefaultWidth, barData.defaultHeight)
end

function MobileHealthBar.DelayedSummonCheck(mobName, mobileId)
	
	-- do we have a valid mobile name?
	if not IsValidWString(mobName) then

		-- try again in a short time
		Interface.ExecuteWhenAvailable(
		{
			name = "SummonCheckUpdate" .. mobileId,
			check = function() return IsValidWString(GetMobileName(mobileId)) end, 
			callback = function() MobileHealthBar.DelayedSummonCheck(GetMobileName(mobileId), mobileId) end, 
			removeOnComplete = true
		})

		return
	end

	-- check if this is a player summon
	local isSumm, name = IsMySummon(mobName, mobileId)
	
	-- is this a player summon?
	if isSumm then

		-- initialize the summons timers based on the skill levels
		CreaturesDB.updateSummonTimes()

		-- do we have the summon timers table?
		if not MobileHealthBar.SummonTimer then

			-- create the summon timers save structure
			MobileHealthBar.SummonTimers = CreateSaveStructureWithPlayerID(MobileHealthBar.SummonTimers)

			-- initialize the summon timers table
			MobileHealthBar.InitializeSummons()
		end

		-- do we have a timer for this summon?
		if MobileHealthBar.SummonTimer[mobileId] == nil then

			-- set the remaining time for the summon
			MobileHealthBar.SummonTimer[mobileId] = CreaturesDB.SummonTimes[wstring.lower(name)]
		end

		-- is this a controllable summon?
		if ControllableSummonsList[wstring.lower(name)] then

			-- flag the creature as controllable summon
			if Interface.ActiveMobilesOnScreen[mobileId] then
				Interface.ActiveMobilesOnScreen[mobileId].isControllableSummon = true
			end
		end
		
		-- flag this creature as a summon
		Interface.ActiveMobilesOnScreen[mobileId].isSummon = true

		-- mark this as NON boss
		Interface.ActiveMobilesOnScreen[mobileId].isBoss = false

	--  is this the player necro familiar?
	elseif CreaturesDB.IsFamiliar(wstring.lower(mobName)) and IsObjectIdPet(mobileId) then
		
		-- flag the creature as familiar summon
		if Interface.ActiveMobilesOnScreen[mobileId] then
			Interface.ActiveMobilesOnScreen[mobileId].isFamiliar = true
		end

		-- flag this creature as a summon
		Interface.ActiveMobilesOnScreen[mobileId].isSummon = true

		-- mark this as NON boss
		Interface.ActiveMobilesOnScreen[mobileId].isBoss = false
	end
end

function MobileHealthBar.BarUpdate(timePassed)

	-- get the current window name
	local windowName = WindowUtils.GetActiveDialog()

	-- get the mobile ID
	local mobileId = WindowGetId(windowName)

	-- get the mobile data for the specified ID
	local mobileData = Interface.ActiveMobilesOnScreen[mobileId]

	-- create a variable as pointer for the bar record
	local barData = MobileHealthBar.ActiveBars[mobileId]
	
	-- if the bar don't exist, we can get out
	if not barData or not barData.windowName or not DoesWindowExist(barData.windowName) then
		return
	end

	-- has the status been updated in the last second?
	if mobileId ~= GetPlayerID() and (not Interface.LastStatusUpdate[mobileId] or Interface.LastStatusUpdate[mobileId] + 1 < Interface.TimeSinceLogin) then

		-- forcefully unregister the status
		Interface.UnregisterWindowData(WindowData.MobileStatus.Type, mobileId)

		-- re-register the status
		Interface.GetMobileData(mobileId)
	end

	-- is it time for a forced update of the colors (to avoid a glitch that makes all labels white)
	if barData.lastColorUpdate and Interface.TimeSinceLogin > barData.lastColorUpdate + 10 then

		-- update colors
		MobileHealthBar.UpdateBarNameColor(mobileId)

		-- update status (to fix percentages)
		MobileHealthBar.UpdateBarStatus(mobileId)
	end

	-- sometimes the event to re-enable the bar doesn't work properly so we have to handle this manually
	if barData.disabled and IsMobileVisible(mobileId) then

		-- remove the disabled flag
		barData.disabled = false

		-- re-enable the bar
		MobileHealthBar.ToggleDisabled(mobileId)

		-- refresh the dockspot
		MobileBarsDockspot.UpdateDockspotBars(barData.dockspot)	
	end

	-- has at lest passed 3 seconds from the creation?
	if Interface.TimeSinceLogin > barData.creationTime + 3 then
	
		-- check if the window transparency is broken (yet another glitch...)
		if WindowGetFontAlpha(barData.windowName) < 1 or WindowGetAlpha(barData.windowName) < 1 then

			-- stop the current animation
			WindowStopAlphaAnimation(barData.windowName)
		end
	end

	-- is the bar enlarged and we have the cursor targt?
	if DoesPlayerHasCursorTarget() and WindowUtils.GetTopmostDialog(SystemData.MouseOverWindow.name) == windowName and barData.enlarged then

		-- retract the bar
		MobileHealthBar.Retract(barData.windowName)

	-- is the bar normal and we have the cursor over without a target?
	elseif not DoesPlayerHasCursorTarget() and WindowUtils.GetTopmostDialog(SystemData.MouseOverWindow.name) == windowName and not barData.enlarged then

		-- expand the bar
		MobileHealthBar.Expand()
	end

	-- is the bar disabled and the mouse is over the window?
	if barData.disabled and WindowUtils.GetTopmostDialog(SystemData.MouseOverWindow.name) == windowName then

		-- pin button name
		local pinButton = barData.windowName .. "PinBar"

		-- does this bar have the pin button?
		if DoesWindowExist(pinButton) and (not Interface.Settings.AutoPinHonored or mobileId ~= Interface.CurrentHonor) then

			-- show the pin button
			WindowSetShowing(pinButton, true)

			-- as soon as the mouse is out of the area, we hide the button again
			Interface.ExecuteWhenAvailable(
			{
				name = "HidePinFor" .. mobileId,
				check = function() return WindowUtils.GetTopmostDialog(SystemData.MouseOverWindow.name) ~= barData.windowName end, 
				callback = function() WindowSetShowing(pinButton, false) end, 
				removeOnComplete = true
			})
		end
	end
end

function MobileHealthBar.ButtonAvailabilityUpdate(timePassed)
	
	-- get the button window name
	local buttonWindow = SystemData.ActiveWindow.name

	-- get the current window name
	local windowName = WindowUtils.GetActiveDialog()

	-- get the mobile ID
	local mobileId = WindowGetId(windowName)

		-- buttons window container
	local buttonsContainer = WindowGetParent(buttonWindow)
	
	-- does the window still exist and is showing?
	if not DoesWindowExist(buttonWindow) or not WindowGetShowing(buttonsContainer) then
		return
	end

	-- create a variable as pointer for the bar record
	local barData = MobileHealthBar.ActiveBars[mobileId]
	
	-- if the bar don't exist, we can get out
	if not barData or not barData.windowName or not DoesWindowExist(barData.windowName) then
		return
	end
	
	-- is the buttons area visible?
	if WindowGetShowing(barData.windowName .. "Buttons") then

		-- scan all the possible buttons
		for name, data in pairs(MobileHealthBar.ButtonsData) do

			-- is this the current button?
			if string.find(buttonWindow, name, 1, true) then
			
				-- does the availability check has a custom function?
				if data.availableCallback ~= nil then

					-- call the custom function and check the result
					if not data.availableCallback(mobileId) then

						-- disable the button
						MobileHealthBar.DisableButton(buttonWindow)

					else -- enable the button
						MobileHealthBar.EnableButton(buttonWindow)
					end

				-- check by distance
				elseif tonumber(data.maxDistance) then
				
					-- get the distance from the player
					local distance = GetDistanceFromPlayer(mobileId)

					-- is the distance greater than max and less than 0 (mobile out of range)?
					if distance < 0 or distance > data.maxDistance then

						-- disable the button
						MobileHealthBar.DisableButton(buttonWindow)

					else -- enable the button
						MobileHealthBar.EnableButton(buttonWindow)
					end
				end
			end
		end
	end
end

function MobileHealthBar.EnableButton(buttonWindow)

	-- does the button exist?
	if DoesWindowExist(buttonWindow) then

		-- remove the gray out from the button
		WindowSetTintColor(buttonWindow, 255, 255, 255)

		-- enable the button input
		WindowSetHandleInput(buttonWindow, true)
	end
end

function MobileHealthBar.DisableButton(buttonWindow)

	-- does the button exist?
	if DoesWindowExist(buttonWindow) then

		-- gray out the button
		WindowSetTintColor(buttonWindow, 128, 128, 128)

		-- disable the button input
		WindowSetHandleInput(buttonWindow, false)
	end
end

function MobileHealthBar.InventoryTooltip(mobileId)

	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return
	end

	-- get the container ID
	local backpackId = GetBackpackID(mobileId)
		
	-- do we have already item properties active?
	if backpackId ~= WindowGetId("ItemProperties") and WindowGetShowing("ItemProperties") then

		-- reset the item properties array
		ItemProperties.ResetWindowDataPropertiesFull()
	end
		
	-- create the item properties data
	local itemData = 
	{
		windowName = SystemData.ActiveWindow.name,
		itemId = backpackId,
		itemType = WindowData.ItemProperties.TYPE_ITEM
	}
		
	-- show the tooltip
	ItemProperties.SetActiveItem(itemData)
end

function MobileHealthBar.PinTooltip(mobileId)

	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return
	end

	-- create a variable as pointer for the bar record
	local barData = MobileHealthBar.ActiveBars[mobileId]

	-- if the bar don't exist, we can get out (this should NEVER happen here)
	if not barData then
		return
	end

	-- initialize TIDs
	local titleTid = 405
	local bodyTid = 406

	-- is the healthbar pinned?
	if barData.pinned then

		-- change the TIDs for the un-pin tooltip
		titleTid = 407
		bodyTid = 408
	end
		
	-- create the item properties data
	local itemData = 
	{ 
		windowName = SystemData.ActiveWindow.name,
		itemId = 1234,
		itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
		title =	GetStringFromTid(titleTid),
		body = GetStringFromTid(bodyTid)
	}
		
	-- show the tooltip
	ItemProperties.SetActiveItem(itemData)
end

function MobileHealthBar.SkillTooltip(mobileId, skillId)

	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return
	end
	
	-- get the skill name TID
	local skillTid = GetSkillTID(skillId)

	-- create the item properties data
	local itemData = 
	{ 
		windowName = SystemData.ActiveWindow.name,
		itemId = 1234,
		itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
		title = GetStringFromTid(skillTid),
		body = GetStringFromTid(519)
	}
							
	-- show the tooltip
	ItemProperties.SetActiveItem(itemData)
end

function MobileHealthBar.SpellTooltip(mobileId, spellId)

	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return
	end

	-- get the spell info
	local icon, serverId, tid, desctid = GetAbilityData(spellId)

	-- do we have the spell name?
	if not IsValidID(tid) then
		tid = 1011051 -- NONE
	end

	-- create the item properties data
	local itemData = 
	{ 
		windowName = SystemData.ActiveWindow.name,
		itemId = 1234,
		itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
		title =	GetStringFromTid(tid),
		body = GetStringFromTid(1154873) -- Right Click to switch spell
	}
							
	-- show the tooltip
	ItemProperties.SetActiveItem(itemData)
end

function MobileHealthBar.ItemTooltip(mobileId, objectType)

	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return
	end
	
	-- create the item properties data
	local itemData = 
	{ 
		windowName = SystemData.ActiveWindow.name,
		itemId = 1234,
		itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
		title =	GetStringFromTid(Interface.PurpleButtonItems[objectType].Tid),
		body = GetStringFromTid(1154873) -- Right Click to switch spell
	}
							
	-- show the tooltip
	ItemProperties.SetActiveItem(itemData)
end

function MobileHealthBar.SpellChangeContext()
	
	-- get the current window name
	local windowName = WindowUtils.GetActiveDialog()

	-- get the mobile ID
	local mobileId = WindowGetId(windowName)

	-- is this a call from the status window?
	if string.find(windowName, "StatusWindow", 1, true) then

		-- get the player ID
		mobileId = GetPlayerID()
	end

	-- button window name
	local buttonWindow = SystemData.ActiveWindow.name

	-- reset the context menu
	ContextMenu.CleanUp()

	-- button type name: red/green/blue
	local buttonType

	-- is this the red button?
	if string.find(buttonWindow, "Red", 1, true) then

		-- set the button type
		buttonType = "Red"

	-- is this the green button?
	elseif string.find(buttonWindow, "Green", 1, true) then
		
		-- set the button type
		buttonType = "Green"

	-- is this the blue button?
	elseif string.find(buttonWindow, "Blue", 1, true) then
	
		-- set the button type
		buttonType = "Blue"

	-- is this the gold button?
	elseif string.find(buttonWindow, "Gold", 1, true) then
	
		-- set the button type
		buttonType = "Gold"

	-- is this the gold button?
	elseif string.find(buttonWindow, "Purple", 1, true) then
	
		-- set the button type
		buttonType = "Purple"
	end

	-- get the saved button definition
	local buttonDef = Interface.LoadSetting(buttonType .. "ButtonDef_" .. mobileId, Interface[buttonType .. "Def"])
		
	-- gold button is for skills
	if buttonType == "Gold" then

		-- scan the skills
		for i = 1, Interface.Settings.GoldCount do

			-- get the skill ID
			local skillId = Interface.Settings[buttonType .. "Button" .. i]

			-- create the context menu entry
			ContextMenu.CreateLuaContextMenuItem({tid = GetSkillTID(skillId), returnCode = mobileId, param = {buttonType, i}, pressed = buttonDef == i})
		end

	-- purple button is for items
	elseif buttonType == "Purple" then

		-- scan the items
		for i = 1, Interface.Settings.PurpleCount do

			-- get the item type ID
			local objectType = Interface.Settings[buttonType .. "Button" .. i]

			-- create the context menu entry
			ContextMenu.CreateLuaContextMenuItem({tid = Interface.PurpleButtonItems[objectType].Tid, returnCode = mobileId, param = {buttonType, i}, pressed = buttonDef == i})
		end

	else
		-- scan the 3 spells
		for i = 1, 3 do

			-- get the spell ID
			local spellId = Interface.Settings[buttonType .. "Button" .. i]

			-- get the spell name
			local icon, serverId, tid, desctid = GetAbilityData(spellId)

			-- do we have a valid spell name?
			if not IsValidID(tid) then
				tid = 1011051 -- NONE
			end
	
			-- create the context menu entry
			ContextMenu.CreateLuaContextMenuItem({tid = tid, returnCode = mobileId, param = {buttonType, i}, pressed = buttonDef == i})
		end
	end

	-- show the context menu
	ContextMenu.ActivateLuaContextMenu(MobileHealthBar.SpellContextCallback)
end

function MobileHealthBar.SpellContextCallback(mobileId, param)

	-- do we have a valid parameters?
	if not param or not IsValidID(mobileId) then
		return
	end
	
	-- button type (red, green, blue)
	local buttonType = param[1]

	-- button choice 1,2,3...
	local buttonID = param[2]

	-- if the mobile is not a pet, a party member or the player itself, we change the default values (so we won't clutter the character profile)
	if not IsPartyMember(mobileId) and not IsObjectIdPet(mobileId) and mobileId ~= GetPlayerID() then

		-- se the default choice ID
		Interface[buttonType .. "Def"] = buttonID

		-- save the default choice
		Interface.SaveSetting(buttonType .. "Def", buttonID)

	else -- save the choice for the specified mobile
		Interface.SaveSetting(buttonType .. "ButtonDef_" .. mobileId, buttonID)
	end
end

function MobileHealthBar.ManagePetPowerHour(mobileId)

	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return
	end

	-- create a variable as pointer for the bar record
	local barData = MobileHealthBar.ActiveBars[mobileId]

	-- if the bar don't exist, we can get out
	if not barData or not barData.windowName or not DoesWindowExist(barData.windowName) then
		return
	end
	
	-- if the pet power hour table has not been initialized, we do it now
	if not MobileHealthBar.PetPowerHourInitialized then
		MobileHealthBar.InitializePetPowerHour()
	end

	-- is the mobile a pet?
	if IsObjectIdPet(mobileId) then

		-- is the pet power hour array empty?
		if not MobileHealthBar.PetPowerHour then

			-- create the pet power hour table
			MobileHealthBar.PetPowerHours = CreateSaveStructureWithPlayerID(MobileHealthBar.PetPowerHours)

			-- initialize the pet power hour array
			MobileHealthBar.InitializePetPowerHour()
		end

		-- does the pet has the power hour?
		if MobileHealthBar.PetPowerHour[mobileId] and MobileHealthBar.PetPowerHour[mobileId] > 0 then

			-- show the star
			WindowSetShowing(barData.windowName .. "Star", true)

		else -- hide the star
			WindowSetShowing(barData.windowName .. "Star", false)
		end
	end
end

function MobileHealthBar.Star_OnMouseOver()

	-- get the current window name
	local windowName = WindowUtils.GetActiveDialog()

	-- get the mobile ID
	local mobileId = WindowGetId(windowName)

	-- create a variable as pointer for the bar record
	local barData = MobileHealthBar.ActiveBars[mobileId]

	-- if the bar don't exist or is disabled, we can get out
	if not barData or barData.disabled or not MobileHealthBar.PetPowerHour then
		return
	end

	-- get the pet power hour time
	local powerHour = MobileHealthBar.PetPowerHour[mobileId]

	-- does the pet has the power hour active?
	if powerHour then
		
		-- get the time left on the power hour
		local timer = towstring(StringUtils.SecondsToClock(powerHour, false))

		-- create the tooltip
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, ReplaceTokens(GetStringFromTid(279), {timer}))
	end
end

function MobileHealthBar.MobilePropertiesTooltip(mobileId)

	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return
	end
	
	-- do we have already item properties active?
	if mobileId ~= WindowGetId("ItemProperties") and WindowGetShowing("ItemProperties") then

		-- reset the item properties array
		ItemProperties.ResetWindowDataPropertiesFull()
	end
	
	-- create the item properties data
	local itemData = 
	{
		windowName = SystemData.ActiveWindow.name,
		itemId = mobileId,
		itemType = WindowData.ItemProperties.TYPE_ITEM,
	}
					 
	-- show the tooltip
	ItemProperties.SetActiveItem(itemData)
end

function MobileHealthBar.OnLButtonUp()

	-- get the current window name
	local windowName = WindowUtils.GetActiveDialog()

	-- get the mobile ID
	local mobileId = WindowGetId(windowName)

	-- create a variable as pointer for the bar record
	local barData = MobileHealthBar.ActiveBars[mobileId]

	-- if the bar don't exist or is disabled, we can get out
	if not barData or barData.disabled then
		return
	end

	-- are e dragging an item?
	if SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM then

		-- give the item to the mobile
	    DragSlotDropObjectToObject(mobileId)

	else -- execute the single click on the mobile
		HandleSingleLeftClkTarget(mobileId)
	end
end

function MobileHealthBar.OnLButtonDblClk()
	
	-- get the current window name
	local windowName = WindowUtils.GetActiveDialog()

	-- get the mobile ID
	local mobileId = WindowGetId(windowName)

	-- create a variable as pointer for the bar record
	local barData = MobileHealthBar.ActiveBars[mobileId]

	-- if the bar don't exist or is disabled, we can get out
	if not barData or barData.disabled or DoesPlayerHasCursorTarget() then
		return
	end

	-- use the mobile
	UserActionUseItem(mobileId, false)
end

function MobileHealthBar.OnRButtonUp()
	
	-- get the current window name
	local windowName = WindowUtils.GetActiveDialog()

	-- get the mobile ID
	local mobileId = WindowGetId(windowName)

	-- create a variable as pointer for the bar record
	local barData = MobileHealthBar.ActiveBars[mobileId]

	-- if the bar don't exist or is disabled, we can get out
	if not barData then
		return
	end

	-- do we have the right-click to close option?
	if Interface.Settings.LegacyCloseStyle and barData.pinned and (not Interface.Settings.AutoPinHonored or Interface.CurrentHonor ~= mobileId or barData.disabled) then

		-- unpin the bar
		MobileHealthBar.UnPinBar(mobileId)
		
	 -- activate the context menu for the mobile
	elseif not barData.disabled then
		RequestContextMenu(mobileId)
	end
end

function MobileHealthBar.RegisterBar(mobileId)

	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return
	end

	-- create a variable as pointer for the bar record
	local barData = MobileHealthBar.ActiveBars[mobileId]

	-- if the bar don't exist, we can get out
	if not barData or not barData.windowName or not DoesWindowExist(barData.windowName) then
		return
	end

	-- does the status needs to be registered and the mobile is NOT invulnerable?
	if mobileId ~= GetPlayerID() and not IsMobileInvulnerable(mobileId) and not Interface.VerifyMobileData(mobileId, WindowData.MobileStatus[mobileId]) then
		Interface.GetMobileData(mobileId)
	end

	-- does the name needs to be registered 
	if not Interface.VerifyMobileName(mobileId, WindowData.MobileName[mobileId]) then
		Interface.GetMobileNameData(mobileId)
	end
end

function MobileHealthBar.ToggleDisabled(mobileId)

	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return
	end

	-- create a variable as pointer for the bar record
	local barData = MobileHealthBar.ActiveBars[mobileId]

	-- if the bar don't exist, we can get out
	if not barData or not barData.windowName or not DoesWindowExist(barData.windowName) then
		return
	end

	-- make sure the window still exist
	if not DoesWindowExist(barData.windowName) then
		return
	end
	
	-- is the bar pinned?
	if not barData.pinned and barData.disabled then
	
		-- do we have the dockspot name and the dockspot update is stopped? or is a party member and we should NOT leave the disabled bars around?
		if barData.dockspot and not MobileBarsDockspot.Dockspots[barData.dockspot].stopUpdate and (not IsPartyMember(mobileId) or (IsPartyMember(mobileId) and not MobileBarsDockspot.Dockspots[barData.dockspot].leaveDisabledBars)) then

			-- close the window (only the pinned bars stays on screen when disabled)
			MobileHealthBar.CloseBarByID(mobileId, "Close unpinned disabled bar")

			return
		end
	end

	-- toggle the disabled layout
	WindowSetShowing(barData.windowName .. "Disabled", barData.disabled)

	-- has the bar been enabled?
	if not barData.disabled and Interface.TimeSinceLogin > barData.creationTime + 1 then

		-- initialize the bar name, status for the time the bar has appeared
		Interface.ExecuteWhenAvailable(
		{
			name = "Re-InitializeBar" .. mobileId,
			check = function() return Interface.VerifyMobileData(mobileId, WindowData.MobileStatus[mobileId]) ~= nil end, 
			callback = function() MobileHealthBar.UpdateBarName(mobileId)  MobileHealthBar.UpdateBarStatus(mobileId) end, 
			failCallback = function() MobileHealthBar.RegisterBar(mobileId) end,
			removeOnComplete = true,
			delay = Interface.TimeSinceLogin + 1
		})
	end

	-- refresh the dockspot
	MobileBarsDockspot.UpdateDockspotBars(barData.dockspot)	
end

function MobileHealthBar.Highlight(mobileId)
	
	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return
	end

	-- create a variable as pointer for the bar record
	local barData = MobileHealthBar.ActiveBars[mobileId]

	-- if the bar don't exist, we can get out
	if not barData or not barData.windowName or not DoesWindowExist(barData.windowName) then
		return
	end

	-- unhighlight the previous bar
	MobileHealthBar.Unhighlight()

	-- save the ID of the current highlighted bar
	MobileHealthBar.CurrentTarget = mobileId

	-- show the highlight frame
	WindowSetShowing(barData.windowName .. "FrameHighlight", true)
end

function MobileHealthBar.Unhighlight()

	-- get the mobile ID
	local mobileId = MobileHealthBar.CurrentTarget

	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return
	end

	-- create a variable as pointer for the bar record
	local barData = MobileHealthBar.ActiveBars[mobileId]

	-- if the bar don't exist, we can get out
	if not barData or not barData.windowName or not DoesWindowExist(barData.windowName) then
		return
	end

	-- remove the ID of the current highlighted bar
	MobileHealthBar.CurrentTarget = 0

	-- hide the highlight frame
	WindowSetShowing(barData.windowName .. "FrameHighlight", false)
end

function MobileHealthBar.Expand()

	-- get the current window name
	local windowName = WindowUtils.GetActiveDialog()

	-- get the mobile ID
	local mobileId = WindowGetId(windowName)

	-- create a variable as pointer for the bar record
	local barData = MobileHealthBar.ActiveBars[mobileId]

	-- if the bar don't exist, we can get out
	if not barData or barData.disabled then
		return
	end

	-- set the mouse over mobile
	MobileHealthBar.mouseOverId = mobileId

	-- update name
	MobileHealthBar.UpdateBarName(mobileId)  

	-- update status
	MobileHealthBar.UpdateBarStatus(mobileId)

	-- do we have the dockspot name?
	if barData.dockspot then

		-- pause the update while a bar is expanded
		MobileBarsDockspot.Dockspots[barData.dockspot].stopUpdate = true
	end

	-- make the properties button fully visible
	WindowSetAlpha(barData.windowName .. "MobileProperties", 1)

	-- pin button name
	local pinButton = barData.windowName .. "PinBar"

	-- does this bar have the pin button?
	if DoesWindowExist(pinButton) and (not Interface.Settings.AutoPinHonored or mobileId ~= Interface.CurrentHonor) then

		-- show the pin button
		WindowSetShowing(pinButton, true)

		-- default texture is green (for pin)
		local pinTexture = "PinGreen"

		-- is the bar already pinned?
		if barData.pinned then

			-- change the pin to red (for un-pin)
			pinTexture = "PinRed"
		end

		-- do we have the pin button?
		if DoesWindowExist(pinButton) then

			-- update the healthbar pin texture
			ButtonSetTexture(pinButton, Button.ButtonState.NORMAL, pinTexture, 0, 0 )
			ButtonSetTexture(pinButton, Button.ButtonState.HIGHLIGHTED, pinTexture, 0, 0 )
		end
	end

	-- if the player has a target (or is casting a spell), is pointless to show the buttons
	if DoesPlayerHasCursorTarget() or WindowGetShowing("CastBarWindow") or Interface.Settings.DisableButtons or Interface.Settings.HealthbarsSmallButtons then
		return
	end

	-- update the buttons for the bar
	MobileHealthBar.InitializeButtons(mobileId)

	-- enlarge the current bar
	WindowSetDimensions(windowName, MobileHealthBar.DefaultWidth, barData.expandedHeight)

	-- is the bar attached to a grid slot?
	if DoesWindowExist(barData.dockGrid) then

		-- enlarge the bar slot
		WindowSetDimensions(barData.dockGrid, MobileHealthBar.DefaultWidth, barData.expandedHeight)
	end

	-- refresh the anchors to match the new size
	WindowForceProcessAnchors(windowName)

	-- show the buttons
	WindowSetShowing(windowName .. "Buttons", true)

	-- flag the bar as Enlarged
	barData.enlarged = true
end

function MobileHealthBar.Retract(windowName)

	-- get the current window name (if not specified as parameter)
	if not IsValidString(windowName) then
		windowName = WindowUtils.GetActiveDialog()

		-- remove the mouse over mobile
		MobileHealthBar.mouseOverId = 0
	end

	-- get the mobile ID
	local mobileId = WindowGetId(windowName)

	-- create a variable as pointer for the bar record
	local barData = MobileHealthBar.ActiveBars[mobileId]

	-- if the bar don't exist, we can get out
	if not barData then
		return
	end

	-- make the properties button less visible
	WindowSetAlpha(barData.windowName .. "MobileProperties", MobileHealthBar.PropertiesButtonVisibility)

	-- pin button name
	local pinButton = barData.windowName .. "PinBar"

	-- does this bar have the pin button?
	if DoesWindowExist(pinButton) then

		-- hide the pin button
		WindowSetShowing(pinButton, false)
	end

	-- shrink the bar to its original size
	WindowSetDimensions(barData.windowName, MobileHealthBar.DefaultWidth, barData.defaultHeight)

	-- is the bar attached to a grid slot?
	if DoesWindowExist(barData.dockGrid) then
		
		-- shrink the bar slot
		WindowSetDimensions(barData.dockGrid, MobileHealthBar.DefaultWidth, barData.defaultHeight)
	end

	-- do we have the dockspot name?
	if barData.dockspot then
	
		-- recover the update process while a bar is back to be normal
		MobileBarsDockspot.Dockspots[barData.dockspot].stopUpdate = DoesWindowExist(barData.dockspot  .. "Settings")
	end

	-- refresh the anchors to match the new size
	WindowForceProcessAnchors(barData.windowName)

	-- hide the buttons
	WindowSetShowing(barData.windowName .. "Buttons", false)
	
	-- is the mouse over the mobile of this window?
	if WindowUtils.GetTopmostDialog(ItemProperties.GetCurrentWindow()) == barData.windowName then

		-- remove the item properties (if they are showing)
		ItemProperties.ClearMouseOverItem()
	end

	-- flag the bar as normal
	barData.enlarged = nil
end

function MobileHealthBar.TogglePin()

	-- get the current window name
	local windowName = WindowUtils.GetActiveDialog()
	
	-- do we have a valid window?
	if not DoesWindowExist(windowName) then
		return
	end

	-- get the mobile ID
	local mobileId = WindowGetId(windowName)

	-- create a variable as pointer for the bar record
	local barData = MobileHealthBar.ActiveBars[mobileId]

	-- if the bar don't exist, we can get out
	if not barData then
		return
	end
	
	-- pin button name
	local pinButton = windowName .. "PinBar"

	-- does this bar have the pin button and it's not the honor target bar?
	if DoesWindowExist(pinButton) then
		
		-- new showing status for the pin
		local showing = not WindowGetShowing(pinButton)

		-- is this the honor target?
		if Interface.Settings.AutoPinHonored and mobileId == Interface.CurrentHonor then

			-- can't unpin the honor target
			showing = false
		end

		-- hide the pin button
		WindowSetShowing(pinButton, showing)

		-- do we have the dockspot name?
		if barData.dockspot then

			-- pause the update while a bar has the mouse over
			MobileBarsDockspot.Dockspots[barData.dockspot].stopUpdate = WindowGetShowing(pinButton)
		end
	end
end

function MobileHealthBar.BandageAvailability(mobileId, veterinary)
	
	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return false
	end

	-- get the mobile data for the specified ID
	local mobileStatus = Interface.ActiveMobilesOnScreen[mobileId]

	-- no mobile data (this should not happen since we have all the data for the mobiles on screen)
	if not mobileStatus then
		return
	end

	-- is the mobile in range?
	if GetDistanceFromPlayer(mobileId) < 0 or GetDistanceFromPlayer(mobileId) > 2 then
		return false
	end

	-- does the mobile has mortal strike applied?
	if IsMobileMortalStriked(mobileId) then
		return false
	end

	-- player skill level
	local skillLevel
	local secondarySkillLevel

	-- is this a veterinary check?
	if veterinary then

		-- get the veterinary skill level
		skillLevel = GetSkillValue(SkillsWindow.SkillsID.VETERINARY, true)

		-- get the animal lore skill level
		secondarySkillLevel = GetSkillValue(SkillsWindow.SkillsID.ANIMAL_LORE, true)

	else -- healing check

		-- get the healing skill level
		skillLevel = GetSkillValue(SkillsWindow.SkillsID.HEALING, true)

		-- get the anatomy skill level
		secondarySkillLevel = GetSkillValue(SkillsWindow.SkillsID.ANATOMY, true)
	end
	
	-- is the mobile alive and not poisoned? (any skill level will do for a simple heal)
	if (mobileStatus.curHealth >= 0 and mobileStatus.curHealth < mobileStatus.maxHealth) and not mobileStatus.dead and not IsMobilePoisoned(mobileId) then

		return true

	-- is the mobile alive and poisoned and primary and secondary skill greater than 60? (min for healing poisons)
	elseif not mobileStatus.dead and IsMobilePoisoned(mobileId) and skillLevel >= 60 and secondarySkillLevel >= 60 then

		return true

	-- is the mobile dead and the primary and secondary skill greater than 80? (min for resurect)
	elseif mobileStatus.dead and skillLevel >= 80 and secondarySkillLevel >= 80	then

		return true
	end

	return false
end

function MobileHealthBar.CloseBarByID(mobileId, reason)
	--Debug.Print(reason)

	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return false
	end
	
	-- create a variable as pointer for the bar record
	local barData = MobileHealthBar.ActiveBars[mobileId]

	-- if the bar don't exist, we can get out
	if not barData then
		return
	end

	-- is this bar part of the mobiles list?
	if barData.type == MobileHealthBar.HealthbarsType.INVULNERABLE or barData.type == MobileHealthBar.HealthbarsType.NORMAL then

		-- update the mobiles count
		Interface.AddTodoList({name = "update mobiles count", func = function() MobileBarsDockspot.UpdateMobilesCount() end, time = Interface.TimeSinceLogin + 1})

	-- is this a party bar?
	elseif barData.type == MobileHealthBar.HealthbarsType.PARTY then

		-- update the mobiles count
		Interface.AddTodoList({name = "update party count", func = function() MobileBarsDockspot.UpdatePartyCount() end, time = Interface.TimeSinceLogin + 1})

	-- is this a pet bar?
	elseif barData.type == MobileHealthBar.HealthbarsType.PET then

		-- update the pets count
		Interface.AddTodoList({name = "update party count", func = function() MobileBarsDockspot.UpdatePetsCount() end, time = Interface.TimeSinceLogin + 1})
	end

	-- restore the default grid size
	MobileBarsDockspot.ResizeGridSlot(barData.dockGrid, barData.dockspot)

	-- destroy the healthbar
	DestroyWindow(barData.windowName)
end

function MobileHealthBar.TogglePinBar(mobileId)

	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return false
	end
	
	-- create a variable as pointer for the bar record
	local barData = MobileHealthBar.ActiveBars[mobileId]

	-- if the bar don't exist, we can get out
	if not barData then
		return
	end

	-- pin button name
	local pinButton = barData.windowName .. "PinBar"
	
	-- does the pin button exist? (pin unsupported for this bar)
	if not DoesWindowExist(pinButton) then
		return
	end
	
	-- unpin the bar
	if barData.pinned then
		MobileHealthBar.UnPinBar(mobileId)

	else -- pin the bar
		MobileHealthBar.PinBar(mobileId)
	end

	-- default texture is green (for pin)
	local pinTexture = "PinGreen"

	-- is the bar already pinned?
	if barData.pinned then

		-- change the pin to red (for un-pin)
		pinTexture = "PinRed"
	end

	-- do we have the pin button?
	if DoesWindowExist(pinButton) then

		-- update the healthbar pin texture
		ButtonSetTexture(pinButton, Button.ButtonState.NORMAL, pinTexture, 0, 0 )
		ButtonSetTexture(pinButton, Button.ButtonState.HIGHLIGHTED, pinTexture, 0, 0 )
	end
end

function MobileHealthBar.PinBar(mobileId)

	-- do we have a valid ID?
	if not IsValidID(mobileId) or IsObjectIdPet(mobileId) or IsPartyMember(mobileId) then
		return
	end

	-- create a variable as pointer for the bar record
	local barData = MobileHealthBar.ActiveBars[mobileId]

	-- if the bar don't exist or is already pinned, we can get out
	if not barData or barData.pinned then
		return
	end

	if not MobileBarsDockspot.StoredPinnedBars then
		MobileBarsDockspot.StoredPinnedBars = {}
	end

	-- search if the bar is already pinned
	for i, mob in pairsByIndex(MobileHealthBar.PinnedOrder) do

		-- is the bar already inside the table?
		if mobileId == mob then
			
			-- flag the bar as pinned
			barData.pinned = true

			return
		end
	end
	
	-- shall we replace the first pinned bar?
	local replace = MobileHealthBar.ReplaceFirstPinned()

	-- grid ID to put the bar in
	local gridId

	-- default first slot ID
	local firstID = 1
		
	-- do we have a valid honor target?
	if Interface.Settings.AutoPinHonored and IsValidID(Interface.CurrentHonor) and MobileHealthBar.ActiveBars[Interface.CurrentHonor] and Interface.CurrentHonor ~= mobileId then
			
		-- the first slot ID will be the 2 instead of 1 (the 1 is reserved for honor bar)
		firstID = 2
	end

	-- do we have to replace the first one?
	if replace then

		-- unpin the last bar of the list
		MobileHealthBar.UnPinBar(MobileHealthBar.PinnedOrder[#MobileHealthBar.PinnedOrder])

		-- insert the new bar at the first position
		table.insert(MobileHealthBar.PinnedOrder, firstID, mobileId)

		-- change the pinned status
		barData.pinned = true

	else -- insert the new bar into the array

		-- insert the new bar at the beginning
		table.insert(MobileHealthBar.PinnedOrder, firstID, mobileId)

		-- change the pinned status
		barData.pinned = true

		-- store the pinned mobile
		MobileBarsDockspot.StoredPinnedBars[mobileId] = true
	end

	-- old dockspot name (if there is one)
	local oldDockspot

	-- do we have the dockspot name?
	if barData.dockspot then

		-- store the old dockspot
		oldDockspot = barData.dockspot

		-- pause the update while a bar is expanded
		MobileBarsDockspot.Dockspots[barData.dockspot].stopUpdate = nil
	end

	-- change the dockspot
	barData.dockspot = MobileBarsDockspot.DockspotDefaultNames[MobileBarsDockspot.DockspotType.PINNED]

	-- retract the bar
	MobileHealthBar.Retract(barData.windowName)

	-- store the time of creation of the bar
	barData.creationTime = Interface.TimeSinceLogin

	-- refresh the old dockspot
	MobileBarsDockspot.UpdateDockspotBars(oldDockspot)

	-- refresh the pinned
	MobileBarsDockspot.UpdateDockspotBars(barData.dockspot)	
end

function MobileHealthBar.UnPinBar(mobileId)

	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return
	end

	-- scan pinned order array
	for i, mob in pairsByIndex(MobileHealthBar.PinnedOrder) do

		-- is this the mobile to remove?
		if mob == mobileId then
			
			-- remove the mobile from the table
			table.remove(MobileHealthBar.PinnedOrder, i)

			break
		end
	end

	-- create a variable as pointer for the bar record
	local barData = MobileHealthBar.ActiveBars[mobileId]

	-- if the bar don't exist, we can get out
	if not barData then
		return
	end

	-- retract the bar
	MobileHealthBar.Retract(barData.windowName)

	-- change the pinned status
	barData.pinned = false

	-- remove the pinned mobile from the stored list
	MobileBarsDockspot.StoredPinnedBars[mobileId] = nil
	
	-- refresh the pinned dockspot
	MobileBarsDockspot.UpdateDockspotBars(barData.dockspot)

	-- close the bar (it will be re-created in the right dockspot automatically)
	MobileHealthBar.CloseBarByID(mobileId, "Unpin bar")
end

function MobileHealthBar.ReplaceFirstPinned()
	
	-- will another pinned bar exceed the cap?
	if #MobileHealthBar.PinnedOrder + 1 > MobileBarsDockspot.PinnedBarsCap then

		-- the next pinned bar will replace the first one
		return true
	end

	return false
end

function MobileHealthBar.IsEligibleForHealings(mobileId)

	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return false
	end

	-- get the mobile data for the specified ID
	local mobileData = Interface.ActiveMobilesOnScreen[mobileId]

	-- no mobile data (this should not happen since we have all the data for the mobiles on screen)
	if not mobileData then
		return false
	end

	-- is the player on felucca or a siege rules shard? with felucca rules you can heal everyone with the risk of becoming criminal
	local isFelucca = WindowData.PlayerLocation.facet == 0 or Interface.SiegeRules

	-- notoriety that can always be healed everywhere
	local canAlwaysHeal = mobileData.notoriety == NameColor.Notoriety.INNOCENT or mobileData.notoriety == NameColor.Notoriety.FRIEND or mobileData.notoriety == NameColor.Notoriety.CRIMINAL

	-- can the target be healed?
	if canAlwaysHeal or isFelucca then

		-- does the mobile has the paperdoll (is human/elf/gargoyle)?
		if HasPaperdoll(mobileId) then

			-- the target can be healed, with healing
			return true, "Healing"

		elseif mobileData.isSomeonePet then
			
			-- the target can be healed, with veterinary
			return true, "Veterinary"
		end
	end
end

function MobileHealthBar.QueryCriminalAction(mobileId, callback)
	
	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return
	end

	-- get the mobile data for the specified ID
	local mobileData = Interface.ActiveMobilesOnScreen[mobileId]

	-- no mobile data (this should not happen since we have all the data for the mobiles on screen)
	if not mobileData then
		return
	end

	-- is the mobile friendly and the player wants a warning before criminal actions?
	if	(mobileData.notoriety == NameColor.Notoriety.INNOCENT or mobileData.notoriety == NameColor.Notoriety.FRIEND) and 
		SystemData.Settings.GameOptions.queryBeforeCriminalAction
	then
		
		-- initialize the button data
		local okayButton = { textTid = 1013076, callback = callback }
        local cancelButton = { textTid = UO_StandardDialog.TID_CANCEL }

		-- initialize the dialog data
		local ConfirmWindow = 
		{
			windowName = "Warning" .. mobileId,
			titleTid = 1111873,
			bodyTid  = 3000032,
			buttons = { okayButton, cancelButton },
			destroyDuplicate = true,
		}

		-- create the dialog
		UO_StandardDialog.CreateDialog(ConfirmWindow)

		return
	end

	-- execute the callback
	callback()
end

function MobileHealthBar.CastWod(mobileId)

	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return
	end

	-- cast wod on the mobile
	UserActionCastSpellOnId(614, mobileId)
end

function MobileHealthBar.CloseAllHealthbars(allBars)

	-- scan all the active healthbars
	for mobileId, data in pairs(MobileHealthBar.ActiveBars) do

		-- is the bar pinned or we have to destroy all healthbars?
		if data.pinned or allBars then

			-- close the bar (it will be re-created in the right dockspot automatically)
			MobileHealthBar.CloseBarByID(mobileId, "Close all healthbars")
		end
	end

	-- clear the pinned order
	MobileHealthBar.PinnedOrder = {}
end

function MobileHealthBar.IgnoredMobile(mobileID)

	-- do we have a valid mobile ID?
	if not IsValidID(mobileID) then
		return false
	end

	-- make sure the name is lower case
	local name = wstring.lower(GetMobileName(mobileID))

	-- do we have th name?
	if not IsValidWString(name) then
		return false
	end

	-- is this a great ape barrel?
	if name == L"barrel" and GetMobileNotoriety(mobileID) == NameColor.Notoriety.CANATTACK then
		return true
	end

	-- is the mobile a mannequin?
	if wstring.find(name, L"a mannequin", 1, true) ~= nil and IsMobileInvulnerable(mobileID) then
		return true
	end

	-- is the mobile a house parrot?
	if wstring.find(name, L"the parrot", 1, true) ~= nil and IsMobileInvulnerable(mobileID) then
		return true
	end

	-- is this a statue?
	if IsMobileInvulnerable(mobileID) and ItemProperties.DoesItemHasProperty(mobileID, 1076202) then -- Sculpted by ~1_Name~
		return true
	end

	return false
end

function MobileHealthBar.GetMobileIDByWindowName(windowName)

	-- do we have a valid string?
	if not IsValidString(windowName) then
		return
	end
	
	-- scan all the active healthbars
	for mobileId, barData in pairs(MobileHealthBar.ActiveBars) do

		-- is this the bar we're looking for?
		if barData.windowName == windowName then
			return mobileId
		end
	end
end

function MobileHealthBar.HealthbarTypeToString(hbType)

	-- scan the type table
	for name, typ in pairs(MobileHealthBar.HealthbarsType) do
		
		-- is this the type we're looking for?
		if hbType == typ then
			return name
		end
	end
end

function MobileHealthBar.UpdateBarSizes()

	-- are the small buttons active?
	if not Interface.Settings.DisableButtons and Interface.Settings.HealthbarsSmallButtons then

		-- size with small buttons
		MobileHealthBar.DefaultHeight = 55
		MobileHealthBar.PetBarHeight = 70
		MobileHealthBar.PartyBarHeight = 85

	else -- size without small buttons
		MobileHealthBar.DefaultHeight = 35
		MobileHealthBar.PetBarHeight = 50
		MobileHealthBar.PartyBarHeight = 65
	end
end

function MobileHealthBar.UseSkill(skillId, mobileId)
	
	-- do we have a skill iD?
	if not skillId then
		return
	end

	-- is the skill SNOOPING?
	if skillId == 28 then

		-- get the mobile backpack ID
		local backpack = GetBackpackID(mobileId)

		-- do we have a valid backpack ID?
		if IsValidID(backpack) then

			-- try to open the mobile backpack
			UserActionUseItem(backpack, true)
		end

	else -- other skills

		-- use the skill
		UserActionUseSkill(skillId)

		-- force to target the mobile
		ForceExecuteTarget(mobileId)
	end
end