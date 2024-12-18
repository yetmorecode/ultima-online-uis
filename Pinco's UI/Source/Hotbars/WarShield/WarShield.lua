----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

WarShield = {}

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function WarShield.OnInitialize()

	-- current window name
	local windowName = "WarShield"

	-- restore the window position
	WindowUtils.RestoreWindowPosition()

	-- do we have a saved window position?
	if WindowUtils.CanRestorePosition(windowName) then

		-- reload the window position
		WindowUtils.RestoreWindowPosition(windowName)

	else
		-- reset the anchors
		WindowClearAnchors(windowName)

		-- is the classic status active?
		if Interface.Settings.StatusWindowStyle == 0 then
			
			-- anchor to the top-right of the status window
			WindowAddAnchor(windowName, "topright", "StatusWindow", "topleft", 0, -30)

		-- is the advanced status active?
		elseif Interface.Settings.StatusWindowStyle == 1 then

			-- anchor to the advanced status stamina area
			WindowAddAnchor(windowName, "bottomleft", "AdvancedStatusWindowSTAM", "bottomleft", -50, 50)

		else
			-- anchor to the botom-left of the game window
			WindowAddAnchor(windowName, "bottomleft", "ResizeWindow", "bottomright", 0, 20)
		end

		-- move in the same position but without anchors
		WindowUtils.ClearAnchorsWithoutMoving(windowName)
	end

	-- hide the handle to move the window
	WindowSetShowing(windowName .. "Handle", false)
end

function WarShield.Shutdown()

	-- save the window position
	WindowUtils.SaveWindowPosition("WarShield")
end

function WarShield.ToggleWarShield()

	-- is the war/peace shield enabled?
	if Interface.Settings.WarShield and not DoesWindowExist("WarShield") then

		-- create the war/peace shield
		CreateWindow("WarShield", true)

	elseif not Interface.Settings.WarShield and DoesWindowExist("WarShield") then

		-- remove the war shield
		DestroyWindow("WarShield")
	end
end

function WarShield.ShieldOver()

	-- get the keybinding for the toggle war/peace action
	local bindingText = SystemData.Settings.Keybindings["MELEE_ATTACK"]

	-- do we have a keybinding?
	if IsValidWString(bindingText) then

		-- create the "binding: <key>" line for the tooltip
		bindingText = L"\n" .. GetStringFromTid(Hotbar.TID_BINDING).. L" " .. bindingText
	end		

	-- base tooltip mesage
	local message = GetStringFromTid(1079841) .. L"\n\n"  -- Toggle War/Peace mode

	-- get the current war/peace status
	if WindowData.PlayerStatus.InWarMode then

		-- set the current status message to war
		message = message .. ReplaceTokens(GetStringFromTid(1071518), {GetStringFromTid(3000086)}) -- Current Setting: ~1_VAL~ War

	else -- set the current status message to peace
		message = message .. ReplaceTokens(GetStringFromTid(1071518), {GetStringFromTid(3000085)}) -- Current Setting: ~1_VAL~ Peace
	end

	-- initialize the item properties data
	local itemData = {	windowName = "WarShield",
						itemId = 1234,
						itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
						title =	GetStringFromTid(3002081), -- War/Peace
						binding = bindingText, -- As defined above
						body = message }
						
	-- show the tooltip
	ItemProperties.SetActiveItem(itemData)

	-- is the handle to move the window invisible?
	if not WindowGetShowing("WarShieldHandle") then

		-- show the handle
		WindowSetShowing("WarShieldHandle", true)
	end
end

function WarShield.AbilityContext()

	-- cleanup the context menu
	ContextMenu.CleanUp()

	-- create the context menu line to assign the hotkey to war/peace toggle
	ContextMenu.CreateLuaContextMenuItem({tid = HotbarSystem.TID_ASSIGN_HOTKEY, returnCode = HotbarSystem.ContextReturnCodes.ASSIGN_KEY, param = {type = "MELEE_ATTACK", recordKey = 5, windowName = SystemData.ActiveWindow.name} })

	-- show the context menu
	ContextMenu.ActivateLuaContextMenu(CharacterAbilities.ContextMenuCallback)
end

function WarShield.ContextMenuCallback(returnCode, param)

	-- assign key context menu callback
	if returnCode == HotbarSystem.ContextReturnCodes.ASSIGN_KEY then

		-- set the current key to be recorded
		SettingsWindow.CurKeyIndex = param.recordKey
	
		-- show the assign hotkey info tooltip
		WindowUtils.ShowAssignHotkeyInfo(param.windowName)
		
		-- enable the key recording flags
		SettingsWindow.RecordingKey = true
		SystemData.IsRecordingSettings = true

		-- enable the key recording
		BroadcastEvent( SystemData.Events.INTERFACE_RECORD_KEY )
	end
end

function WarShield.ShieldOnLButtonDown(flags)

	-- pressing CTRL and drag, allows to move the status with the snap
	if flags == WindowUtils.ButtonFlags.CONTROL then

		-- enable the snapping
		SnapUtils.StartWindowSnap(WindowUtils.GetActiveDialog())
	end
end

function WarShield.ShieldOverend()

	-- clear the item properties
	ItemProperties.ClearMouseOverItem()

	-- hide the handle to move the window
	WindowSetShowing("WarShieldHandle", false)
end