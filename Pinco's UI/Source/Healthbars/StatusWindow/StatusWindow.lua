----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

StatusWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

StatusWindow.Skills = 
{
	[1]  = { sop = false, TCName = L"alchemy" },
	[2]  = { sop = true, TCName = L"anatomy" },
	[3]  = { sop = true, TCName = L"animallore" },
	[4]  = { sop = true, TCName = L"animaltaming" },
	[5]  = { sop = true, TCName = L"archery" },
	[6]  = { sop = false, TCName = L"armslore" },
	[7]  = { sop = false, TCName = L"begging" },
	[8]  = { sop = true, TCName = L"blacksmith" },
	[9]  = { sop = true, TCName = L"bushido" },
	[10] = { sop = false, TCName = L"camping" },
	[11] = { sop = false, TCName = L"carpentry" },
	[12] = { sop = false, TCName = L"cartography" },
	[13] = { sop = true, TCName = L"chivalry" },
	[14] = { sop = false, TCName = L"cooking" },
	[15] = { sop = false, TCName = L"detecthidden" },
	[16] = { sop = true, TCName = L"discordance" },
	[17] = { sop = true, TCName = L"evalint" },
	[18] = { sop = true, TCName = L"fencing" },
	[19] = { sop = true, TCName = L"fishing" },
	[20] = { sop = false, TCName = L"fletching" },
	[21] = { sop = true, TCName = L"focus" },
	[22] = { sop = false, TCName = L"forensics" },
	[23] = { sop = true, TCName = L"healing" },
	[24] = { sop = false, TCName = L"herding" },
	[25] = { sop = false, TCName = L"hiding" },
	[26] = { sop = true, TCName = L"imbuing" },
	[27] = { sop = false, TCName = L"inscribe" },
	[28] = { sop = false, TCName = L"itemid" },
	[29] = { sop = false, TCName = L"lockpicking" },
	[30] = { sop = false, TCName = L"lumberjacking" },
	[31] = { sop = true, TCName = L"macing" },
	[32] = { sop = true, TCName = L"magery" },
	[33] = { sop = true, TCName = L"magicresist" },
	[34] = { sop = true, TCName = L"meditation" },
	[35] = { sop = false, TCName = L"mining" },
	[36] = { sop = true, TCName = L"musicianship" },
	[37] = { sop = true, TCName = L"mysticism" },
	[38] = { sop = true, TCName = L"necromancy" },
	[39] = { sop = true, TCName = L"ninjitsu" },
	[40] = { sop = true, TCName = L"parry" },
	[41] = { sop = true, TCName = L"peacemaking" },
	[42] = { sop = false, TCName = L"poisoning" },
	[43] = { sop = true, TCName = L"provocation" },
	[44] = { sop = false, TCName = L"removetrap" },
	[45] = { sop = false, TCName = L"snooping" },
	[46] = { sop = true, TCName = L"spellweaving" },
	[47] = { sop = true, TCName = L"spiritspeak" },
	[48] = { sop = true, TCName = L"stealing" },
	[49] = { sop = true, TCName = L"stealth" },
	[50] = { sop = true, TCName = L"swords" },
	[51] = { sop = true, TCName = L"tactics" },
	[52] = { sop = true, TCName = L"tailoring" },
	[53] = { sop = false, TCName = L"tasteid" },
	[54] = { sop = true, TCName = L"throwing" },
	[55] = { sop = false, TCName = L"tinkering" },
	[56] = { sop = false, TCName = L"tracking" },
	[57] = { sop = true, TCName = L"veterinary" },
	[58] = { sop = true, TCName = L"wrestling" },
}

StatusWindow.Locked = false
StatusWindow.HPLocked = true
StatusWindow.MANALocked = true
StatusWindow.STAMLocked = true

StatusWindow.DisableDelta = 0

StatusWindow.prevHP = 0
StatusWindow.prevMana = 0
StatusWindow.prevStam = 0
StatusWindow.prevAlwaysRun = SystemData.Settings.GameOptions.alwaysRun

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function StatusWindow.Initialize()

	-- classic status
	if Interface.Settings.StatusWindowStyle == 0 then

		-- main window name
		local windowName = "StatusWindow"

		-- load the locked status
		StatusWindow.Locked = Interface.LoadSetting(windowName .. "Locked", StatusWindow.Locked)

		-- create the status window
		CreateWindow(windowName, true)

		-- do we have a saved window position?
		if WindowUtils.CanRestorePosition(windowName) then

			-- reload the window position
			WindowUtils.RestoreWindowPosition(windowName)

		else
			-- reset the anchors
			WindowClearAnchors(windowName)

			-- anchor on the top-left of the game area
			WindowAddAnchor(windowName, "topleft", "ResizeWindow", "topleft", 10, 30)
		end

		-- reload the scale
		WindowUtils.LoadScale(windowName)

		-- update the lock status
		StatusWindow.SetLockButtonTexture(windowName .. "Lock", StatusWindow.Locked)

		-- initialize the lag bar
		StatusWindow.InitializeLagBar(windowName)

		-- initialize the hp/mana/stamina text on the bars
		StatusWindow.ToggleStrLabel()

	-- advanced status
	elseif Interface.Settings.StatusWindowStyle == 1 then

		-- main window name
		local windowNameHP = "AdvancedStatusWindowHP"
		local windowNameMANA = "AdvancedStatusWindowMANA"
		local windowNameSTAM = "AdvancedStatusWindowSTAM"

		-- load the locked status
		StatusWindow.HPLocked = Interface.LoadSetting("StatusWindowHPLocked", StatusWindow.HPLocked)
		StatusWindow.MANALocked = Interface.LoadSetting("StatusWindowMANALocked", StatusWindow.MANALocked)
		StatusWindow.STAMLocked = Interface.LoadSetting("StatusWindowSTAMLocked", StatusWindow.STAMLocked)

		-- cerate the advanced status windows
		CreateWindow(windowNameHP, true)
		CreateWindow(windowNameMANA, true)
		CreateWindow(windowNameSTAM, true)

		-- do we have a saved window position?
		if WindowUtils.CanRestorePosition(windowNameHP) then

			-- reload the window position
			WindowUtils.RestoreWindowPosition(windowNameHP)

		else
			-- reset the anchors
			WindowClearAnchors(windowNameHP)

			-- anchor on the bottom left of the screen
			WindowAddAnchor(windowNameHP, "bottomleft", "Root", "bottomleft", 0,0)
		end

		-- do we have a saved window position?
		if WindowUtils.CanRestorePosition(windowNameMANA) then

			-- reload the window position
			WindowUtils.RestoreWindowPosition(windowNameMANA)

		else
			-- reset the anchors
			WindowClearAnchors(windowNameMANA)

			-- anchor on the bottom right of the screen
			WindowAddAnchor(windowNameMANA, "bottomright", "Root", "bottomright", 0,0)
		end

		-- do we have a saved window position?
		if WindowUtils.CanRestorePosition(windowNameSTAM) then

			-- reload the window position
			WindowUtils.RestoreWindowPosition(windowNameSTAM)

		else
			-- reset the anchors
			WindowClearAnchors(windowNameSTAM)

			-- anchor on top of the menu hotbar
			WindowAddAnchor(windowNameSTAM, "Bottom", "Root", "bottom", 0, -54)

			-- move the stamina bar in the same position but without anchors
			WindowUtils.ClearAnchorsWithoutMoving(windowNameSTAM)
		end

		-- reload the scale
		WindowUtils.LoadScale(windowNameHP)
		WindowUtils.LoadScale(windowNameMANA)
		WindowUtils.LoadScale(windowNameSTAM)

		-- update the lock status
		StatusWindow.SetLockButtonTexture(windowNameHP .. "Lock", StatusWindow.HPLocked)
		StatusWindow.SetLockButtonTexture(windowNameMANA .. "Lock", StatusWindow.HPLocked)
		StatusWindow.SetLockButtonTexture(windowNameSTAM .. "Lock", StatusWindow.HPLocked)

		-- initialize the lag bar
		StatusWindow.InitializeLagBar(windowNameSTAM)

		-- initialize the hp/mana/stamina text on the bars
		StatusWindow.ToggleStrLabel()

		-- HP pool size data
		StatusWindow.HPHeight = 193
		StatusWindow.HPWidth = 200
		StatusWindow.LastHPHeight = -2

		-- MANA pool size data
		StatusWindow.MPHeight = 193
		StatusWindow.MPWidth = 200
		StatusWindow.LastMPHeight = -2

	-- diablo status
	elseif Interface.Settings.StatusWindowStyle == 2 then
		
		-- create the diablo status windows
		CreateWindow("DiabloHP", true)
		CreateWindow("DiabloMANA", true)
		CreateWindow("DiabloSTAM", true)
		CreateWindow("DiabloStatusWindow", true)

		-- create the botom border
		CreateWindowFromTemplate("DiabloBottomBorderBG", "DiabloBottomBorder", "Root")

		-- cerate always run button
		CreateWindowFromTemplate("DiabloAlwaysRunrBT", "DiabloAlwaysRun", "Root")

		-- restore the portrait window position
		WindowUtils.RestoreWindowPosition("DiabloStatusWindow")

		-- get the parchment texture data
		local texture, xSize, ySize = RequestGumpArt(1250)

		-- set the HP text parchment size
		WindowSetDimensions("DiabloHPTextBackground", xSize * 0.5, ySize * 0.5)

		-- set the HP text parchment texture
		DynamicImageSetTexture("DiabloHPTextBackground", texture, 0, 0)

		-- set the HP text parchment scale
		DynamicImageSetTextureScale("DiabloHPTextBackground", 0.5)

		-- set the MANA text parchment size
		WindowSetDimensions("DiabloMANATextBackground", xSize * 0.5, ySize * 0.5)

		-- set the MANA text parchment texture
		DynamicImageSetTexture("DiabloMANATextBackground", texture, 0, 0)

		-- set the MANA text parchment scale
		DynamicImageSetTextureScale("DiabloMANATextBackground", 0.5)

		-- set the locked status
		StatusWindow.SetLockButtonTexture("DiabloStatusWindowLock", StatusWindow.Locked)

		-- HP pool size data
		StatusWindow.HPWidth = 192
		StatusWindow.HPHeight = 177
		StatusWindow.LastHPHeight = -2

		-- MANA pool size data
		StatusWindow.MPWidth = 192
		StatusWindow.MPHeight = 177
		StatusWindow.LastMPHeight = -2
		
	-- overhead status
	elseif Interface.Settings.StatusWindowStyle == 3 then
		
		-- create the player overhead status
		OverheadText.CreatePlayerHoverbar()

	-- party status
	elseif Interface.Settings.StatusWindowStyle == 4 then

		-- update the party count (since now it has to include the player)
		MobileBarsDockspot.UpdatePartyCount()
	end

	-- only if the staus is not overhead or party bar
	if Interface.Settings.StatusWindowStyle < 3 then

		-- update the notoriety aura
		pcall(StatusWindow.UpdateGlowingStatus)
	
		-- initialize the player status
		StatusWindow.UpdateStatus()

		-- toggle the status buttons visibility
		StatusWindow.ToggleButtons()
	end

	-- toggle the war shield
	WarShield.ToggleWarShield()

	-- flag the status as initialized
	StatusWindow.Initialized = true
end

function StatusWindow.Shutdown()

	-- save the status position
	StatusWindow.SaveWindowPositions()	
end

function StatusWindow.SaveWindowPositions()
	
	-- classic status
	if Interface.Settings.StatusWindowStyle == 0 and DoesWindowExist("StatusWindow") then

		-- save the window position
		WindowUtils.SaveWindowPosition("StatusWindow")

	-- advanced status
	elseif Interface.Settings.StatusWindowStyle == 1 and DoesWindowExist("AdvancedStatusWindowHP") then

		-- save the windows position
		WindowUtils.SaveWindowPosition("AdvancedStatusWindowHP")
		WindowUtils.SaveWindowPosition("AdvancedStatusWindowMANA")
		WindowUtils.SaveWindowPosition("AdvancedStatusWindowSTAM")

	-- diablo status
	elseif Interface.Settings.StatusWindowStyle == 2 and DoesWindowExist("DiabloStatusWindow") then

		-- save the window position
		WindowUtils.SaveWindowPosition("DiabloStatusWindow")
	end
end

function StatusWindow.TcToolsShutdown()
	
	-- save the window position
	WindowUtils.SaveWindowPosition("TCTOOLSWindow")
end

function StatusWindow.Latency_OnMouseOver()

	-- do we have the latency data?
	if Interface.Latency and Interface.Latency.lag and Interface.Latency.ploss then

		-- create the tooltip with the latency data
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, ReplaceTokens(GetStringFromTid(1155254), {towstring(Interface.Latency.lag).. L"ms", towstring(Interface.Latency.ploss) } )) -- Latency: ~1_LAG~\nPacket Loss: ~2_PLOSS~
	end
end

function StatusWindow.LockTooltip()

	-- is the status locked?
	if StatusWindow.Locked then

		-- show the unlock message
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1155250)) -- Unlock Status Window

	else -- show the lock message
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1155251)) -- Lock Status Window
	end
end

function StatusWindow.Lock()

	-- invert the locked status
	StatusWindow.Locked = not StatusWindow.Locked 

	-- save the locked status
	Interface.SaveSetting("StatusWindowLocked", StatusWindow.Locked)
	
	-- update the lock button texture
	StatusWindow.SetLockButtonTexture(SystemData.ActiveWindow.name, StatusWindow.Locked)
end

function StatusWindow.LockTooltipHP()
	
	-- is the HP locked?
	if StatusWindow.HPLocked then

		-- show the unlock message
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1155255)) -- Unlock HP Status Window

	else -- show the lock message
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1155256)) -- Lock HP Status Window
	end
end

function StatusWindow.LockHP()

	-- invert the lock status
	StatusWindow.HPLocked = not StatusWindow.HPLocked 

	-- save the locked status
	Interface.SaveSetting("StatusWindowHPLocked", StatusWindow.HPLocked)
	
	-- update the lock button texture
	StatusWindow.SetLockButtonTexture(SystemData.ActiveWindow.name, StatusWindow.HPLocked)
end

function StatusWindow.LockTooltipMANA()
	
	-- is the mana locked?
	if StatusWindow.MANALocked then

		-- show the unlock message
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1155257)) -- Unlock Mana Status Window

	else  -- show the lock message
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1155258)) -- Lock Mana Status Window
	end
end

function StatusWindow.LockMANA()

	-- invert the lock status
	StatusWindow.MANALocked = not StatusWindow.MANALocked 

	-- save the locked status
	Interface.SaveSetting("StatusWindowMANALocked", StatusWindow.MANALocked)

	-- update the lock button texture
	StatusWindow.SetLockButtonTexture(SystemData.ActiveWindow.name, StatusWindow.MANALocked)
end

function StatusWindow.LockTooltipSTAM()
	
	-- is the stamina locked?
	if StatusWindow.STAMLocked then

		-- show the unlock message
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1155259)) -- Unlock Stamina Status Window

	else -- show the lock message
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1155260)) -- Lock Stamina Status Window
	end
end

function StatusWindow.LockSTAM()

	-- invert the lock status
	StatusWindow.STAMLocked = not StatusWindow.STAMLocked 

	-- save the locked status
	Interface.SaveSetting("StatusWindowSTAMLocked", StatusWindow.STAMLocked)
	
	-- update the lock button texture
	StatusWindow.SetLockButtonTexture(SystemData.ActiveWindow.name, StatusWindow.STAMLocked)
end

function StatusWindow.MenuTooltip()
	
	-- set the tooltip text
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1155252)) -- Show Character Menu
end

function StatusWindow.Menu()

	-- open the player context menu
	RequestContextMenu(GetPlayerID(), true)
end

function StatusWindow.UpdateLatency()
	
	-- classic style
	if Interface.Settings.StatusWindowStyle == 0 then

		-- bar window name
		local barName = "StatusWindowLagBar"

		-- get the bar dimensions
		local w, h = WindowGetDimensions(barName)

		-- default color: green
		local hue = { r = 0, g = 255, b = 0 }

		-- do we have less than 250ms?
		if Interface.Latency.lag < 250 then

			-- set maximum bar dimension
			h = 52

		-- do we have less than 650ms?
		elseif Interface.Latency.lag < 650 then

			-- bar color: yellow
			hue = { r = 255, g = 255, b = 0}

			-- set half of the bar dimensions
			h = 28
		else

			-- bar color: red
			hue = { r = 255, g = 0, b = 0 }

			-- set the bar dimension as 1/4 of the whole size
			h = 14
		end
		
		-- set the bar color
		WindowSetTintColor(barName, hue.r, hue.g, hue.b)

		-- update the bar dimensions
		WindowSetDimensions(barName, w, h)
		
	-- advanced style
	elseif Interface.Settings.StatusWindowStyle == 1 then

		-- bar window name
		local barName = "AdvancedStatusWindowSTAMLagBar"

		-- get the bar dimensions
		local w, h = WindowGetDimensions(barName)

		-- default color: green
		local hue = { r = 0, g = 255, b = 0 }
		
		-- default color: green
		local hue = { r = 0, g = 255, b = 0 }

		-- do we have less than 250ms?
		if Interface.Latency.lag < 250 then

			-- set maximum bar dimension
			w = 148

		-- do we have less than 650ms?
		elseif Interface.Latency.lag < 650 then

			-- bar color: yellow
			hue = { r = 255, g = 255, b = 0}

			-- set half of the bar dimensions
			w = 74
		else

			-- bar color: red
			hue = { r = 255, g = 0, b = 0 }

			-- set the bar dimension as 1/4 of the whole size
			w = 37
		end
		
		-- set the bar color
		WindowSetTintColor(barName, hue.r, hue.g, hue.b)

		-- update the bar dimensions
		WindowSetDimensions(barName, w, h)

	-- diablo style
	elseif Interface.Settings.StatusWindowStyle == 2 then

		-- bar window name
		local barName = "DiabloStatusWindowLagBar"

		-- get the bar dimensions
		local w, h = WindowGetDimensions(barName)

		-- default color: green
		local hue = { r = 0, g = 255, b = 0 }
		
		-- default color: green
		local hue = { r = 0, g = 255, b = 0 }

		-- do we have less than 250ms?
		if Interface.Latency.lag < 250 then

			-- set maximum bar dimension
			w = 140

		-- do we have less than 650ms?
		elseif Interface.Latency.lag < 650 then

			-- bar color: yellow
			hue = { r = 255, g = 255, b = 0}

			-- set half of the bar dimensions
			w = 66
		else

			-- bar color: red
			hue = { r = 255, g = 0, b = 0 }

			-- set the bar dimension as 1/4 of the whole size
			w = 29
		end
		
		-- set the bar color
		WindowSetTintColor(barName, hue.r, hue.g, hue.b)

		-- update the bar dimensions
		WindowSetDimensions(barName, w, h)
	end
end

function StatusWindow.ClickOutside()

	-- disable the clickable area
	WindowSetHandleInput("AdvancedStatusWindowSTAM", false)

	-- flag that the area has been disabled
	StatusWindow.TempDisabled = true
end

function StatusWindow.EnableInput(timePassed)

	-- is the area disabled?
	if StatusWindow.TempDisabled then

		-- increase the timer
		StatusWindow.DisableDelta = StatusWindow.DisableDelta + timePassed

		-- is 1 second passed since the last check?
		if StatusWindow.DisableDelta > 1 then

			-- re-enable the clickable area
			WindowSetHandleInput("AdvancedStatusWindowSTAM", true)

			-- remove the temporary disabled flag
			StatusWindow.TempDisabled = nil

			-- reset the timer
			StatusWindow.DisableDelta = 0
		end
	end

	-- do we have poison damage?
	if StatusWindow.PoisonDamage and StatusWindow.PoisonDamage.totalDamage > 0 then

		-- is it time for the poison tick?
		if StatusWindow.PoisonDamage.nextTick <= Interface.TimeSinceLogin then

			-- update the poison damage
			StatusWindow.PoisonDamage.totalDamage = StatusWindow.PoisonDamage.totalDamage - StatusWindow.PoisonDamage.damagePerTick

			-- update the next poison tick timer
			StatusWindow.PoisonDamage.nextTick = Interface.TimeSinceLogin + StatusWindow.PoisonDamage.tick
		end
	end
end

function StatusWindow.ResetSkills(timePassed)

	-- scan all the TC skills
	if StatusWindow.TCResetSkills ~= nil then

		-- scan all the skills starting from the last one we reset
		for id = StatusWindow.TCResetSkills, #StatusWindow.Skills do

			-- set the new skill to reset ID
			StatusWindow.TCResetSkills = id

			-- get the skill value
			local skillValue = GetSkillValue(id, false, true)

			-- is the skill greater than 0?
			if skillValue > 0 then

				-- set the skill to 0
				SendChat(ChatSettings.Channels[SystemData.ChatLogFilters.SAY].serverCmd, L"/say set " .. StatusWindow.Skills[id].TCName .. L" " .. 0)

				return
			end
		end

		-- no more skills to reset.
		StatusWindow.TCResetSkills = nil
	end
end

function StatusWindow.CheckStatChanges()

	-- is the HP changed?
	if StatusWindow.prevHP ~= WindowData.PlayerStatus.CurrentHealth then

		-- store the current hp
		StatusWindow.prevHP = WindowData.PlayerStatus.CurrentHealth

		-- trigger the HP change event
		Interface.OnHPChange(StatusWindow.prevHP)
	end

	-- is the mana changed?
	if StatusWindow.prevMana ~= WindowData.PlayerStatus.CurrentMana then

		-- store the current mana
		StatusWindow.prevMana = WindowData.PlayerStatus.CurrentMana

		-- trigger the mana change event
		Interface.OnManaChange(StatusWindow.prevMana)
	end

	-- is the stamina changed?
	if StatusWindow.prevStam ~= WindowData.PlayerStatus.CurrentStamina then

		-- store the current stamina
		StatusWindow.prevStam = WindowData.PlayerStatus.CurrentStamina

		-- trigger the stamina change event
		Interface.OnStamChange(StatusWindow.prevStam)
	end

	-- is the always run status changed?
	if StatusWindow.prevAlwaysRun ~= SystemData.Settings.GameOptions.alwaysRun then

		-- store the current stamina
		StatusWindow.prevAlwaysRun = SystemData.Settings.GameOptions.alwaysRun
	end
end

function StatusWindow.UpdateStatus()
	
	-- current player status
	local mobileStatus = Interface.ActiveMobilesOnScreen[GetPlayerID()]

	-- do we have the player status?
	if not mobileStatus then

		Interface.ExecuteWhenAvailable(
		{
			name = "WaitForPlayerStatusForUpdate", 
			check = function() return Interface.ActiveMobilesOnScreen[GetPlayerID()] ~= nil and Interface.ActiveMobilesOnScreen[GetPlayerID()].maxHealth ~= nil end, 
			callback = function() StatusWindow.UpdateStatus() end, 
			removeOnComplete = true
		})

		return
	end

	-- do we have the player status?
	if not mobileStatus.maxHealth then

		-- update the active mobiles data
		pcall(Interface.UpdateMobileOnScreenStatus, GetPlayerID())
	end
	
	-- handle the hp/mana/stamina change event
	StatusWindow.CheckStatChanges()

	-- classic style
	if Interface.Settings.StatusWindowStyle == 0 then

		-- main window name
		local windowName = "StatusWindow"

		-- is the status visible?
		if not DoesWindowExist(windowName) then
			return
		end

		-- set the maximum values for the bars
		StatusBarSetMaximumValue(windowName .. "HealthBar", mobileStatus.maxHealth)
		StatusBarSetMaximumValue(windowName .. "ManaBar", mobileStatus.maxMana)
		StatusBarSetMaximumValue(windowName .. "StaminaBar", mobileStatus.maxStamina)	

		-- set the current values into the bars
		StatusBarSetCurrentValue(windowName .. "HealthBar", mobileStatus.curHealth)
		StatusBarSetCurrentValue(windowName .. "ManaBar", mobileStatus.curMana)
		StatusBarSetCurrentValue(windowName .. "StaminaBar", mobileStatus.curStamina)

		-- update the healthbar color
		HealthBarColor.UpdateHealthBarColor(windowName .. "HealthBar", WindowData.PlayerStatus.VisualStateId)

		-- poisoned: while the bar became green, this overlay remains red and indicates how many HP are left when the poison is over (if not cured)
		if WindowData.PlayerStatus.VisualStateId == 1 and StatusWindow.PoisonDamage then

			-- show the poison overlay
			WindowSetShowing(windowName .. "HealthBarPoison", true)

			-- mortal strike applied?
			if BuffDebuff.ActiveBuffs[1027] then

				-- color the bar in yellow
				WindowSetTintColor(windowName .. "HealthBarPoison", 255, 255, 0)

			else -- color he bar in red
				WindowSetTintColor(windowName .. "HealthBarPoison", 255 , 0, 0)
			end

			-- set the bar max value same as the normal hp bar
			StatusBarSetMaximumValue(windowName .. "HealthBarPoison", mobileStatus.maxHealth)

			-- set the current bar value as the HP - the total poison damage
			StatusBarSetCurrentValue(windowName .. "HealthBarPoison", mobileStatus.curHealth - StatusWindow.PoisonDamage.totalDamage)

		else -- hide the poison bar
			WindowSetShowing(windowName .. "HealthBarPoison", false)
		end

		-- is the player dead?
		if Interface.IsPlayerDead then

			-- hide the normal portrait
			WindowSetShowing(windowName .. "Portrait", false)

			-- show the dead portrait
			WindowSetShowing(windowName .. "Dead", true)

		else
			-- show the normal portrait
			WindowSetShowing(windowName .. "Portrait", true)

			-- hide the dead portrait
			WindowSetShowing(windowName .. "Dead", false)

			-- update the portrait
			StatusWindow.UpdatePortrait(windowName)
		end

	-- advanced status
	elseif Interface.Settings.StatusWindowStyle == 1 then
		
		-- main window name
		local windowName = "AdvancedStatusWindow"

		-- is the status visible?
		if not DoesWindowExist(windowName .. "HPFill") then
			return
		end
		
		-- update the HP pool color
		HealthBarColor.UpdateVerticalHealthBarColor(windowName .. "HPFill", WindowData.PlayerStatus.VisualStateId)

		-- update the health bar
		StatusWindow.SetHealth(windowName, mobileStatus.curHealth, mobileStatus.maxHealth)
		
		-- set the max value for the stamina
		StatusBarSetMaximumValue(windowName .. "STAMFill", mobileStatus.maxStamina)

		-- set the current stamina value
		StatusBarSetCurrentValue(windowName .. "STAMFill", mobileStatus.curStamina)

		-- set the mana pool color
		HealthBarColor.UpdateVerticalHealthBarColor(windowName .. "MANAFill", HealthBarColor.HealthVisualState.Mana - 1)

		-- update the mana pool
		StatusWindow.SetMana(windowName, mobileStatus.curMana, mobileStatus.maxMana)

		-- toggle the always run status
		ButtonSetPressedFlag(windowName .. "STAMAlwaysRun", SystemData.Settings.GameOptions.alwaysRun)

		-- is the player dead?
		if Interface.IsPlayerDead then

			-- hide the normal portrait
			WindowSetShowing(windowName .. "STAMPortrait", false)

			-- show the dead portrait
			WindowSetShowing(windowName .. "STAMDead", true)

		else
			-- show the normal portrait
			WindowSetShowing(windowName .. "STAMPortrait", true)

			-- hide the dead portrait
			WindowSetShowing(windowName .. "STAMDead", false)

			-- update the portrait
			StatusWindow.UpdatePortrait(windowName .. "STAM")
		end
	
	-- diablo status
	elseif Interface.Settings.StatusWindowStyle == 2 then

		-- main window name
		local windowName = "Diablo"

		-- is the status visible?
		if not DoesWindowExist(windowName .. "HPFill") then
			return
		end
		
		-- update the HP pool color
		HealthBarColor.UpdateVerticalHealthBarColor(windowName .. "HPFill", WindowData.PlayerStatus.VisualStateId)

		-- update the health bar
		StatusWindow.SetHealth(windowName, mobileStatus.curHealth, mobileStatus.maxHealth)
		
		-- set the stamina color
		HealthBarColor.UpdateHealthBarColor(windowName .. "STAMFill", HealthBarColor.HealthVisualState.Stamina - 1)

		-- set the max value for the stamina
		StatusBarSetMaximumValue(windowName .. "STAMFill", mobileStatus.maxStamina)

		-- set the current stamina value
		StatusBarSetCurrentValue(windowName .. "STAMFill", mobileStatus.curStamina)

		-- set the mana pool color
		HealthBarColor.UpdateVerticalHealthBarColor(windowName .. "MANAFill", HealthBarColor.HealthVisualState.Mana - 1)

		-- update the mana pool
		StatusWindow.SetMana(windowName, mobileStatus.curMana, mobileStatus.maxMana)

		-- toggle the always run status
		ButtonSetPressedFlag(windowName .. "AlwaysRunrBT", SystemData.Settings.GameOptions.alwaysRun)

		-- window name for the portrait and buttons
		windowName = windowName .. "StatusWindow"

		-- is the player dead?
		if Interface.IsPlayerDead then

			-- hide the normal portrait
			WindowSetShowing(windowName .. "Portrait", false)

			-- show the dead portrait
			WindowSetShowing(windowName .. "Dead", true)

		else
			-- show the normal portrait
			WindowSetShowing(windowName .. "Portrait", true)

			-- hide the dead portrait
			WindowSetShowing(windowName .. "Dead", false)

			-- update the portrait
			StatusWindow.UpdatePortrait(windowName)
		end
	end

	-- update the notoriety aura
	pcall(StatusWindow.UpdateGlowingStatus)
	
	-- update hp/mana/stamina numbers
	StatusWindow.UpdateLabelContent()
end

function StatusWindow.OnLButtonUp()

	-- are we dragging an item?
	if SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM then

		-- drop the item inside the backpack
	    DragSlotDropObjectToObject(GetPlayerID())

	else
		-- is the classic status moving?
		if Interface.Settings.StatusWindowStyle == 0 and WindowGetMoving("StatusWindow") then

			-- stop the moving
			WindowSetMoving("StatusWindow", false)
			
		-- is the diablo status moving?
		elseif Interface.Settings.StatusWindowStyle == 20 and WindowGetMoving("DiabloStatusWindow") then
			
			-- stop the moving
			WindowSetMoving("DiabloStatusWindow", false)

		else -- simple click

			-- target the player
			HandleSingleLeftClkTarget(GetPlayerID())
		end
	end
end

function StatusWindow.OnLButtonDown(flags)

	-- have we clicked a part of the diablo status and is not locked?
	if DoesWindowExist("DiabloStatusWindow") and string.find(SystemData.ActiveWindow.name, "DiabloStatusWindow", 1, true) and not StatusWindow.Locked then
		
		-- pressing CTRL and drag, allows to move the status with the snap
		if flags == WindowUtils.ButtonFlags.CONTROL then

			-- enable the snapping
			SnapUtils.StartWindowSnap("DiabloStatusWindow")

		else -- just move the status
			WindowSetMoving("DiabloStatusWindow", true)
		end
		
	-- have we clicked the status window and is not locked?
	elseif WindowUtils.GetActiveDialog() == "StatusWindow" and not StatusWindow.Locked then

		-- pressing CTRL and drag, allows to move the status with the snap
		if flags == WindowUtils.ButtonFlags.CONTROL then

			-- enable the snapping
			SnapUtils.StartWindowSnap("StatusWindow")

		else -- just move the status
			WindowSetMoving("StatusWindow", true)
		end
	end
end

function StatusWindow.OnHPLButtonUp()

	-- stop moving the HP pool
	WindowSetMoving("AdvancedStatusWindowHP", false)

	-- target the player
	HandleSingleLeftClkTarget(GetPlayerID())
end

function StatusWindow.OnHPLButtonDown(flags)

	-- is the HP pool locked?
	if not StatusWindow.HPLocked then

		-- pressing CTRL and drag, allows to move the status with the snap
		if flags == WindowUtils.ButtonFlags.CONTROL then

			-- enable the snapping
			SnapUtils.StartWindowSnap("AdvancedStatusWindowHP")

		else -- just move the status
			WindowSetMoving("AdvancedStatusWindowHP", true)
		end
	end
end

function StatusWindow.OnMLANAButtonUp()

	-- stop moving the mana pool
	WindowSetMoving("AdvancedStatusWindowMANA", false)

	-- target the player
	HandleSingleLeftClkTarget(GetPlayerID())
end

function StatusWindow.OnMANALButtonDown(flags)

	-- is the mana pool locked?
	if not StatusWindow.MANALocked then

		-- pressing CTRL and drag, allows to move the status with the snap
		if flags == WindowUtils.ButtonFlags.CONTROL then

			-- enable the snapping
			SnapUtils.StartWindowSnap("AdvancedStatusWindowMANA")

		else -- just move the status
			WindowSetMoving("AdvancedStatusWindowMANA", true)
		end
	end
end

function StatusWindow.OnSTAMLButtonUp()

	-- stop moving the stamina bar
	WindowSetMoving("AdvancedStatusWindowSTAM", false)

	-- target the player
	HandleSingleLeftClkTarget(GetPlayerID())
end

function StatusWindow.OnSTAMLButtonDown(flags)

	-- is the stamina bar locked?
	if not StatusWindow.STAMLocked then

		-- pressing CTRL and drag, allows to move the status with the snap
		if flags == WindowUtils.ButtonFlags.CONTROL then

			-- enable the snapping
			SnapUtils.StartWindowSnap("AdvancedStatusWindowSTAM")

		else -- just move the status
			WindowSetMoving("AdvancedStatusWindowSTAM", true)
		end
	end
end

function StatusWindow.GuardsButton_OnLButtonUp()

	-- call the guards
	SendChat(ChatSettings.Channels[SystemData.ChatLogFilters.SAY].serverCmd, L"/say Guards ! Help Me !!!")
end

function StatusWindow.GuardsButton_OnMouseOver()

	-- initialize the tooltip text
	local itemData = 
	{ 
		windowName = SystemData.ActiveWindow.name,
		itemId = 1234,
		itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
		title =	GetStringFromTid(1155253), -- Call the guards to aid you.
	}
					
	-- show the tooltip
	ItemProperties.SetActiveItem(itemData)
end

function StatusWindow.OnRButtonUp()

	-- get the player context menu
	RequestContextMenu(GetPlayerID())
end

function StatusWindow.UpdateLabelContent()

	-- current player status
	local mobileStatus = Interface.ActiveMobilesOnScreen[GetPlayerID()]

	-- do we have the player status?
	if not mobileStatus then

		Interface.ExecuteWhenAvailable(
		{
			name = "WaitForPlayerStatusForUpdate", 
			check = function() return Interface.ActiveMobilesOnScreen[GetPlayerID()] ~= nil and Interface.ActiveMobilesOnScreen[GetPlayerID()].maxHealth ~= nil end, 
			callback = function() StatusWindow.UpdateStatus() end, 
			removeOnComplete = true
		})

		return
	end

	-- do we have the player status?
	if not mobileStatus.maxHealth then

		-- update the active mobiles data
		pcall(Interface.UpdateMobileOnScreenStatus, GetPlayerID())
	end

	-- calculate hp percent
	local hpPerc = math.round((mobileStatus.curHealth / mobileStatus.maxHealth) * 100, 0)

	-- calculate mana percent
	local manaPerc = math.round(((mobileStatus.curMana or 1) / (mobileStatus.maxMana or 1)) * 100, 0)

	-- calculate stamina percent
	local stamPerc = math.round(((mobileStatus.curStamina or 1) / (mobileStatus.maxStamina or 1)) * 100, 0)

	-- hp string
	local healthStr = mobileStatus.curHealth .. L"/" .. mobileStatus.maxHealth

	-- mana string
	local manaStr = (mobileStatus.curMana or 1) .. L"/" .. (mobileStatus.maxMana or 1)

	-- stamina string
	local staminaStr = (mobileStatus.curStamina or 1) .. L"/" .. (mobileStatus.maxStamina or 1)

	-- classic status
	if Interface.Settings.StatusWindowStyle == 0 then

		-- main window name
		local windowName = "StatusWindow"

		-- set hp text
		LabelSetText(windowName .. "HealthTooltip", healthStr)

		-- set the health percentage
		LabelSetText(windowName .. "HealthPerc", hpPerc .. L"%")

		-- scale the text color to become red when is near 0 for HP
		WindowUtils.ScaleTextRedByPerc(windowName .. "HealthTooltip", hpPerc)
		WindowUtils.ScaleTextRedByPerc(windowName .. "HealthPerc", hpPerc)

		-- set mana text
		LabelSetText(windowName .. "ManaTooltip", manaStr)

		-- set the mana percentage
		LabelSetText(windowName .. "ManaPerc", manaPerc .. L"%")

		-- scale the text color to become red when is near 0 for MANA
		WindowUtils.ScaleTextRedByPerc(windowName .. "ManaTooltip", manaPerc)
		WindowUtils.ScaleTextRedByPerc(windowName .. "ManaPerc", manaPerc)

		-- set stamina text
		LabelSetText(windowName .. "StaminaTooltip", staminaStr)

		-- set the stamina percentage
		LabelSetText(windowName .. "StaminaPerc", stamPerc .. L"%")

		-- scale the text color to become red when is near 0 for STAMINA
		WindowUtils.ScaleTextRedByPerc(windowName .. "StaminaTooltip", stamPerc)
		WindowUtils.ScaleTextRedByPerc(windowName .. "StaminaPerc", stamPerc)

	-- advanced style
	elseif Interface.Settings.StatusWindowStyle == 1 then

		-- hp label
		local healthLabelName = "AdvancedStatusWindowHPHealthTooltip"

		-- mana label
		local manaLabelName = "AdvancedStatusWindowMANAManaTooltip"

		-- stamina label
		local staminaLabelName = "AdvancedStatusWindowSTAMStaminaTooltip"

		-- set the HP text
		LabelSetText(healthLabelName, healthStr)

		-- scale the text color to become red when is near 0 for HP
		WindowUtils.ScaleTextRedByPerc(healthLabelName, hpPerc)

		-- set the MANA text
		LabelSetText(manaLabelName, manaStr)

		-- scale the text color to become red when is near 0 for MANA
		WindowUtils.ScaleTextRedByPerc(manaLabelName, manaPerc)

		-- set the STAMINA text
		LabelSetText(staminaLabelName, staminaStr)

		-- scale the text color to become red when is near 0 for STAMINA
		WindowUtils.ScaleTextRedByPerc(staminaLabelName, stamPerc)
		
	-- diablo style
	elseif Interface.Settings.StatusWindowStyle == 2 then
		
		-- hp label
		local healthLabelName = "DiabloHPLabel"

		-- mana label
		local manaLabelName = "DiabloMANALabel"

		-- stamina label
		local staminaLabelName = "DiabloSTAMLabel"

		-- set the HP text
		LabelSetText(healthLabelName, healthStr)

		-- scale the text color to become red when is near 0 for HP
		WindowUtils.ScaleTextRedByPerc(healthLabelName, hpPerc)

		-- set the MANA text
		LabelSetText(manaLabelName, manaStr)

		-- scale the text color to become red when is near 0 for MANA
		WindowUtils.ScaleTextRedByPerc(manaLabelName, manaPerc)

		-- set the STAMINA text
		LabelSetText(staminaLabelName, staminaStr)

		-- scale the text color to become red when is near 0 for STAMINA
		WindowUtils.ScaleTextRedByPerc(staminaLabelName, stamPerc)
	end
end

function StatusWindow.OnMouseOver()

	-- do we have the properties of something else?
	if not ItemProperties.IsCurrentHover(GetPlayerID()) then

		-- reset the item properties array
		ItemProperties.ResetWindowDataPropertiesFull()
	end

	-- set the player properties data
	local itemData =
	{
		windowName = SystemData.ActiveWindow.name,
		itemId = GetPlayerID(),
		itemType = WindowData.ItemProperties.TYPE_ITEM,
	}

	-- show the item properties
	ItemProperties.SetActiveItem(itemData)	

	-- do we have the hp/mana/stamina labels active?
	if SystemData.Settings.GameOptions.showStrLabel == false then

		-- classic style
		if Interface.Settings.StatusWindowStyle == 0 then

			-- show the labels
			WindowSetShowing("StatusWindowHealthTooltip", true)
			WindowSetShowing("StatusWindowManaTooltip", true)
			WindowSetShowing("StatusWindowStaminaTooltip", true)

			-- show the percent values
			WindowSetShowing("StatusWindowHealthPerc", true)
			WindowSetShowing("StatusWindowManaPerc", true)
			WindowSetShowing("StatusWindowStaminaPerc", true)

		-- advanced style
		elseif Interface.Settings.StatusWindowStyle == 1 then

			-- show the labels
			WindowSetShowing("AdvancedStatusWindowHPHealthTooltip", true)
			WindowSetShowing("AdvancedStatusWindowMANAManaTooltip", true)
			WindowSetShowing("AdvancedStatusWindowSTAMStaminaTooltip", true)
		end
	end
	
end

function StatusWindow.OnMouseOverEnd()

	-- clear the mouse over properties
	ItemProperties.ClearMouseOverItem()

	-- do we have the hp/mana/stamina labels active?
	if SystemData.Settings.GameOptions.showStrLabel == false then

		-- classic style
		if Interface.Settings.StatusWindowStyle == 0 then

			-- hide the labels
			WindowSetShowing("StatusWindowHealthTooltip", false)
			WindowSetShowing("StatusWindowManaTooltip", false)
			WindowSetShowing("StatusWindowStaminaTooltip", false)

			-- hide the percent values
			WindowSetShowing("StatusWindowHealthPerc", false)
			WindowSetShowing("StatusWindowManaPerc", false)
			WindowSetShowing("StatusWindowStaminaPerc", false)

		-- advanced style
		elseif Interface.Settings.StatusWindowStyle == 1 then

			-- hide the labels
			WindowSetShowing("AdvancedStatusWindowHPHealthTooltip", false)
			WindowSetShowing("AdvancedStatusWindowMANAManaTooltip", false)
			WindowSetShowing("AdvancedStatusWindowSTAMStaminaTooltip", false)
		end
	end
end

function StatusWindow.ToggleStrLabel()

	-- classic style
	if Interface.Settings.StatusWindowStyle == 0 then

		-- show the hp/mana/stamina values
		WindowSetShowing("StatusWindowHealthTooltip", SystemData.Settings.GameOptions.showStrLabel)
		WindowSetShowing("StatusWindowManaTooltip", SystemData.Settings.GameOptions.showStrLabel)
		WindowSetShowing("StatusWindowStaminaTooltip", SystemData.Settings.GameOptions.showStrLabel)

		-- show the hp/mana/stamina percent
		WindowSetShowing("StatusWindowHealthPerc", SystemData.Settings.GameOptions.showStrLabel)
		WindowSetShowing("StatusWindowManaPerc", SystemData.Settings.GameOptions.showStrLabel)
		WindowSetShowing("StatusWindowStaminaPerc", SystemData.Settings.GameOptions.showStrLabel)

	-- advanced style
	elseif Interface.Settings.StatusWindowStyle == 1 then
		
		-- show the hp/mana/stamina values
		WindowSetShowing("AdvancedStatusWindowHPHealthTooltip", SystemData.Settings.GameOptions.showStrLabel)
		WindowSetShowing("AdvancedStatusWindowMANAManaTooltip", SystemData.Settings.GameOptions.showStrLabel)
		WindowSetShowing("AdvancedStatusWindowSTAMStaminaTooltip", SystemData.Settings.GameOptions.showStrLabel)
	end
end

function StatusWindow.OnMouseDlbClk()

	-- do we have the cursor target?
	if not DoesPlayerHasCursorTarget() then
		
		-- double click the player
		UserActionUseItem(GetPlayerID(), false)
	end
end

function StatusWindow.TCTools()

	-- reset the context menu
	ContextMenu.CleanUp()

	local flg = 0

	-- if we have bonus stat we disable the stats settings
	if WindowData.PlayerStatus["IncreaseStr"] > 0 or WindowData.PlayerStatus["IncreaseDex"] > 0 or WindowData.PlayerStatus["IncreaseInt"] > 0 then
		flg = 1
	end

	-- create the stats sub-menu
	local subMenu = 
	{
		{ tid = 1154884, returnCode = "str" },
		{ tid = 1154885, returnCode = "dex" },
		{ tid = 1154886, returnCode = "int" },
	}

	-- create the stats context menu
	ContextMenu.CreateLuaContextMenuItem({ tid = 1154883, subMenuOptions = subMenu, flags = flg }) -- Stat Settings
	
	-- add an empty line
	ContextMenu.CreateLuaContextMenuItem(ContextMenu.EmptyLine)

	-- create the reset all skills context menu
	ContextMenu.CreateLuaContextMenuItem({ tid = 294, returnCode = "resetSkills" })
	
	-- misc skills sub-menu
	subMenu = 
	{
		{ tid = WindowData.SkillsCSV[7].NameTid , returnCode = 7  },
		{ tid = WindowData.SkillsCSV[22].NameTid, returnCode = 22 },
		{ tid = WindowData.SkillsCSV[28].NameTid, returnCode = 28 },
		{ tid = WindowData.SkillsCSV[53].NameTid, returnCode = 53 },
	}

	-- create the misc skills context menu
	ContextMenu.CreateLuaContextMenuItem({ tid = 1154889, subMenuOptions = subMenu }) -- Adjust Miscellaneous Skill
	
	-- combat skills sub-menu
	subMenu = 
	{
		{ tid = WindowData.SkillsCSV[2].NameTid , returnCode = 2  },
		{ tid = WindowData.SkillsCSV[5].NameTid , returnCode = 5  },
		{ tid = WindowData.SkillsCSV[18].NameTid, returnCode = 18 },
		{ tid = WindowData.SkillsCSV[21].NameTid, returnCode = 21 },
		{ tid = WindowData.SkillsCSV[23].NameTid, returnCode = 23 },
		{ tid = WindowData.SkillsCSV[31].NameTid, returnCode = 31 },
		{ tid = WindowData.SkillsCSV[40].NameTid, returnCode = 40 },
		{ tid = WindowData.SkillsCSV[50].NameTid, returnCode = 50 },
		{ tid = WindowData.SkillsCSV[51].NameTid, returnCode = 51 },
		{ tid = WindowData.SkillsCSV[58].NameTid, returnCode = 58 },
		{ tid = WindowData.SkillsCSV[54].NameTid, returnCode = 54 },
	}

	-- create the combat skills context menu
	ContextMenu.CreateLuaContextMenuItem({ tid = 1154890, subMenuOptions = subMenu }) -- Adjust Combat Skill
	
	-- crafting skills sub-menu
	subMenu = 
	{
		{ tid = WindowData.SkillsCSV[1].NameTid , returnCode = 1  },
		{ tid = WindowData.SkillsCSV[6].NameTid , returnCode = 6  },
		{ tid = WindowData.SkillsCSV[8].NameTid , returnCode = 8  },
		{ tid = WindowData.SkillsCSV[11].NameTid, returnCode = 11 },
		{ tid = WindowData.SkillsCSV[12].NameTid, returnCode = 12 },
		{ tid = WindowData.SkillsCSV[14].NameTid, returnCode = 14 },
		{ tid = WindowData.SkillsCSV[20].NameTid, returnCode = 20 },
		{ tid = WindowData.SkillsCSV[27].NameTid, returnCode = 27 },
		{ tid = WindowData.SkillsCSV[30].NameTid, returnCode = 30 },
		{ tid = WindowData.SkillsCSV[35].NameTid, returnCode = 35 },
		{ tid = WindowData.SkillsCSV[52].NameTid, returnCode = 52 },
		{ tid = WindowData.SkillsCSV[55].NameTid, returnCode = 55 },
	}

	-- create the crafting skills context menu
	ContextMenu.CreateLuaContextMenuItem({tid = 1154891, subMenuOptions = subMenu}) -- Adjust Crafting Skill
	
	-- crafting skills sub-menu
	subMenu = 
	{
		{ tid = WindowData.SkillsCSV[9].NameTid,  returnCode = 9  },
		{ tid = WindowData.SkillsCSV[13].NameTid, returnCode = 13 },
		{ tid = WindowData.SkillsCSV[17].NameTid, returnCode = 17 },
		{ tid = WindowData.SkillsCSV[32].NameTid, returnCode = 32 },
		{ tid = WindowData.SkillsCSV[33].NameTid, returnCode = 33 },
		{ tid = WindowData.SkillsCSV[34].NameTid, returnCode = 34 },
		{ tid = WindowData.SkillsCSV[38].NameTid, returnCode = 38 },
		{ tid = WindowData.SkillsCSV[39].NameTid, returnCode = 39 },
		{ tid = WindowData.SkillsCSV[46].NameTid, returnCode = 46 },
		{ tid = WindowData.SkillsCSV[47].NameTid, returnCode = 47 },
		{ tid = WindowData.SkillsCSV[37].NameTid, returnCode = 37 },
		{ tid = WindowData.SkillsCSV[26].NameTid, returnCode = 26 },
	}

	-- create the magic skills context menu
	ContextMenu.CreateLuaContextMenuItem({ tid = 1154892, subMenuOptions = subMenu }) -- Adjust Magic Skill
	
	-- wild skills sub-menu
	subMenu = 
	{
		{ tid = WindowData.SkillsCSV[3].NameTid , returnCode = 3  },
		{ tid = WindowData.SkillsCSV[4].NameTid , returnCode = 4  },
		{ tid = WindowData.SkillsCSV[10].NameTid, returnCode = 10 },
		{ tid = WindowData.SkillsCSV[19].NameTid, returnCode = 19 },
		{ tid = WindowData.SkillsCSV[24].NameTid, returnCode = 24 },
		{ tid = WindowData.SkillsCSV[56].NameTid, returnCode = 56 },
		{ tid = WindowData.SkillsCSV[57].NameTid, returnCode = 57 },
	}

	-- create the wild skills context menu
	ContextMenu.CreateLuaContextMenuItem({ tid = 1154893, subMenuOptions = subMenu }) -- Adjust Wild Skill
	
	-- thief skills sub-menu
	subMenu = 
	{
		{ tid = WindowData.SkillsCSV[15].NameTid, returnCode = 15 },
		{ tid = WindowData.SkillsCSV[25].NameTid, returnCode = 25 },
		{ tid = WindowData.SkillsCSV[29].NameTid, returnCode = 29 },
		{ tid = WindowData.SkillsCSV[42].NameTid, returnCode = 42 },
		{ tid = WindowData.SkillsCSV[44].NameTid, returnCode = 44 },
		{ tid = WindowData.SkillsCSV[45].NameTid, returnCode = 45 },
		{ tid = WindowData.SkillsCSV[48].NameTid, returnCode = 48 },
		{ tid = WindowData.SkillsCSV[49].NameTid, returnCode = 49 },
	}

	-- create the thief skills context menu
	ContextMenu.CreateLuaContextMenuItem({ tid = 1155469, subMenuOptions = subMenu }) -- Adjust Thief Skill
	
	-- bard skills sub-menu
	subMenu = 
	{
		{ tid = WindowData.SkillsCSV[16].NameTid, returnCode = 16 },
		{ tid = WindowData.SkillsCSV[36].NameTid, returnCode = 36 },
		{ tid = WindowData.SkillsCSV[41].NameTid, returnCode = 41 },
		{ tid = WindowData.SkillsCSV[43].NameTid, returnCode = 43 },
	}

	-- create the bard skills context menu
	ContextMenu.CreateLuaContextMenuItem({ tid = 1154894, subMenuOptions = subMenu })-- Adjust Bard Skill
	
	-- add an empty line
	ContextMenu.CreateLuaContextMenuItem(ContextMenu.EmptyLine)
	
	-- bank skills sub-menu
	subMenu = 
	{
			{tid = 1154896, flags=Interface.ArteReceived,		returnCode = "arte"		},
			{tid = 1154897, flags=Interface.ResReceived,		returnCode = "res"		},
			{tid = 1154898, flags=Interface.AirReceived,		returnCode = "air"		},
			{tid = 1154899, flags=Interface.SeedsReceived,		returnCode = "seeds"	},
			{tid = 271	  , flags=Interface.MasteriesReceived,  returnCode = "master"	},
	}

	-- have all the items been claimed?
	if (Interface.ArteReceived + Interface.ResReceived + Interface.AirReceived + Interface.SeedsReceived) >=4 then

		-- disable the add items in bank context menu
		ContextMenu.CreateLuaContextMenuItem({ tid = 1154895, flags = 1 }) -- Add Items in Bank

	else -- create the bank items context menu
		ContextMenu.CreateLuaContextMenuItem({ tid = 1154895, subMenuOptions = subMenu }) -- Add Items in Bank
	end
	
	-- create the tokens in backpack context menu
	ContextMenu.CreateLuaContextMenuItem({ tid = 1154900, flags = Interface.TokensReceived, returnCode = "tokens" }) -- Add Tokens In Backpack
	
	-- add an empty line
	ContextMenu.CreateLuaContextMenuItem(ContextMenu.EmptyLine)
	
	-- create the grow plant context menu
	ContextMenu.CreateLuaContextMenuItem({ tid = 1155470, returnCode = "grow" }) -- Grow Plant
	
	-- show the context menu
	ContextMenu.ActivateLuaContextMenu(StatusWindow.TCContextMenuCallback)
end

function StatusWindow.TCContextMenuCallback(returnCode, param)

	-- give artifact
	if returnCode == "arte" then

		-- say: give arties
		SendChat(ChatSettings.Channels[SystemData.ChatLogFilters.SAY].serverCmd, L"/say give arties")

		-- flag the collected
		Interface.ArteReceived = 1

		-- save the flag
		Interface.SaveSetting("ArteReceived" , Interface.ArteReceived)

	-- give resources
	elseif returnCode == "res" then

		-- say: give resources
		SendChat(ChatSettings.Channels[SystemData.ChatLogFilters.SAY].serverCmd, L"/say give resources")

		-- flag the collected
		Interface.ResReceived = 1

		-- save the flag
		Interface.SaveSetting("ResReceived" , Interface.ResReceived)

	-- give air freshner
	elseif returnCode == "air" then

		-- say: give air
		SendChat(ChatSettings.Channels[SystemData.ChatLogFilters.SAY].serverCmd, L"/say give air")

		-- flag the collected
		Interface.AirReceived = 1

		-- save the flag
		Interface.SaveSetting("AirReceived" , Interface.AirReceived)

	-- give seeds
	elseif returnCode == "seeds" then

		-- say: give seeds
		SendChat(ChatSettings.Channels[SystemData.ChatLogFilters.SAY].serverCmd, L"/say give seeds")

		-- flag the collected
		Interface.SeedsReceived = 1

		-- save the flag
		Interface.SaveSetting("SeedsReceived" , Interface.SeedsReceived)

	-- give masteries books
	elseif returnCode == "master" then

		-- say: give masteries
		SendChat(ChatSettings.Channels[SystemData.ChatLogFilters.SAY].serverCmd, L"/say give masteries")

		-- flag the collected
		Interface.MasteriesReceived = 1

		-- save the flag
		Interface.SaveSetting("MasteriesReceived" , Interface.MasteriesReceived)

	-- give tokens
	elseif returnCode == "tokens" then

		-- say: give tokens
		SendChat(ChatSettings.Channels[SystemData.ChatLogFilters.SAY].serverCmd, L"/say give tokens")

		-- flag the collected
		Interface.TokensReceived = 1

		-- save the flag
		Interface.SaveSetting("TokensReceived" , Interface.TokensReceived)

	-- grow plant command
	elseif returnCode == "grow" then

		-- initialize the buttons
		local okayButton = { textTid = UO_StandardDialog.TID_OKAY, callback = function() SendChat(ChatSettings.Channels[SystemData.ChatLogFilters.SAY].serverCmd, L"/say Grow_Plant") end }
		local cancelButton = { text = GetStringFromTid(1154902)} -- Not now

		-- dialog data
		local GrowPlantWindow = 
		{
			windowName = "GrowPlant",
			titleTid = 1155470, -- Grow Plant
			bodyTid  = 1154901, -- Open the gump of a plant locked down then press <b>OKAY<b> to make it grow!
			buttons = { okayButton, cancelButton },
			closeCallback = cancelButton.callback,
			destroyDuplicate = true,
		}

		-- create the dialog
		UO_StandardDialog.CreateDialog(GrowPlantWindow)

	-- set strength
	elseif returnCode == "str" then

		-- if we have bonus stat we can get out
		if WindowData.PlayerStatus["IncreaseStr"] > 0 or WindowData.PlayerStatus["IncreaseDex"] > 0 or WindowData.PlayerStatus["IncreaseInt"] > 0 then
			return
		end
		
		-- get the current stats values
		local currStr = WindowData.PlayerStatus["Strength"]
		local currDex = WindowData.PlayerStatus["Dexterity"]
		local currInt = WindowData.PlayerStatus["Intelligence"]

		-- get the available stats points
		local max = 255 - (currStr + currDex + currInt)

		-- calculate how many points we can invest for the stat
		max = max + currStr

		-- are the available points greater than 125?
		if max >= 125 then

			-- set the points to 125
			max = 125
		end

		-- initialize the text entry data
		local rdata = { title = GetStringFromTid(1077833), subtitle = ReplaceTokens(GetStringFromTid(1154798), {towstring(10),  towstring(max) }), callfunction=StatusWindow.EditStr, min = 10, max = max, id = L"str" } -- STRENGTH // Enter a value between ~1_MIN~ - ~2_MAX~

		-- create the text entry dialog
		RenameWindow.Create(rdata)

	-- set dexterity
	elseif returnCode == "dex" then

		-- if we have bonus stat we can get out
		if WindowData.PlayerStatus["IncreaseStr"] > 0 or WindowData.PlayerStatus["IncreaseDex"] > 0 or WindowData.PlayerStatus["IncreaseInt"] > 0 then
			return
		end

		-- get the current stats values
		local currStr = WindowData.PlayerStatus["Strength"]
		local currDex = WindowData.PlayerStatus["Dexterity"]
		local currInt = WindowData.PlayerStatus["Intelligence"]

		-- get the available stats points
		local max = 255 - (currStr + currDex + currInt)

		-- calculate how many points we can invest for the stat
		max = max + currDex

		-- are the available points greater than 125?
		if max >= 125 then

			-- set the points to 125
			max = 125
		end

		-- initialize the text entry data
		local rdata = { title = GetStringFromTid(1077834), subtitle = ReplaceTokens(GetStringFromTid(1154798), { towstring(10),  towstring(max) }), callfunction=StatusWindow.EditStr, min = 10, max = max, id = L"dex" } -- DEXTERITY // Enter a value between ~1_MIN~ - ~2_MAX~

		-- create the text entry dialog
		RenameWindow.Create(rdata)

	-- set intelligence
	elseif returnCode == "int" then

		-- get the current stats values
		local currStr = WindowData.PlayerStatus["Strength"]
		local currDex = WindowData.PlayerStatus["Dexterity"]
		local currInt = WindowData.PlayerStatus["Intelligence"]

		-- get the available stats points
		local max = 255 - (currStr + currDex + currInt)

		-- calculate how many points we can invest for the stat
		max = max + currInt

		-- are the available points greater than 125?
		if max >= 125 then

			-- set the points to 125
			max = 125
		end

		-- initialize the text entry data
		local rdata = { title = GetStringFromTid(1077834), subtitle = ReplaceTokens(GetStringFromTid(1154798), { towstring(10),  towstring(max) }), callfunction=StatusWindow.EditStr, min = 10, max = max, id = L"int" } -- INTELLIGENCE // Enter a value between ~1_MIN~ - ~2_MAX~

		-- create the text entry dialog
		RenameWindow.Create(rdata)

	-- do we have to reset all the skills?
	elseif returnCode == "resetSkills" then

		-- set the first skill ID to reset
		StatusWindow.TCResetSkills = 1

	-- do we have a numeric code?
	elseif tonumber(returnCode) ~= nil and tonumber(returnCode) > 0 then

		-- default max skill
		local max = 100

		-- is this a PS skill?
		if StatusWindow.Skills[returnCode] and StatusWindow.Skills[returnCode].sop == true then

			-- set the max skill to 120
			max = 120
		end

		-- initialize the text entry data
		local rdata = { title = GetStringFromTid(WindowData.SkillsCSV[returnCode].NameTid), subtitle = ReplaceTokens(GetStringFromTid(1154798), {towstring(0), towstring(max) }), callfunction=StatusWindow.EditSkill, min = 0, max = max, id = returnCode } -- Enter a value between ~1_MIN~ - ~2_MAX~
		
		-- create the text entry dialog
		RenameWindow.Create(rdata)
	end
end

function StatusWindow.EditSkill(id, value, max, min)

	-- do we have a valid value?
	if tonumber(value) then
		
		-- is the value less than min?
		if tonumber(value) < min then

			-- se the skill to min
			value = min
		end

		-- is the value greater than max?
		if tonumber(value) > max then

			-- set the value to max
			value = max
		end

		-- format the skill value
		value = wstring.format(L"%.01f", value)

		-- set the skill up
		SoulstoneGump.SetSkillState(WindowData.SkillsCSV[id].NameTid, 0)
		
		-- wait a short while to set the skill (so the arrow up will be applied)
		Interface.AddTodoList({ name = "TC TOOLS set skill", func = function() SendChat(ChatSettings.Channels[SystemData.ChatLogFilters.SAY].serverCmd, L"/say set " .. StatusWindow.Skills[id].TCName .. L" " .. value) end, time = Interface.TimeSinceLogin + 0.5 })
	end
end 

function StatusWindow.EditStr(id, value, max, min)
	
	-- do we have a valid value?
	if tonumber(value) then

		-- is the value less than min?
		if tonumber(value) < min then

			-- se the skill to min
			value = min
		end

		-- is the value greater than max?
		if tonumber(value) > max then

			-- set the value to max
			value = max
		end

		-- set the stat value
		SendChat(ChatSettings.Channels[SystemData.ChatLogFilters.SAY].serverCmd, L"/say set " .. id .. L" " .. value)
	end
end

function StatusWindow.TCToolsTooltip()

	-- set the tooltip text
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1154887)) -- Test Center Tools Allows you to quickly customize your character. Use the character copy in the help menu from your shard to import a character to TC.
end

function StatusWindow.TCToolsOver()
	
	-- is the tc tools handle hidden?
	if not WindowGetShowing("TCTOOLSWindowIMG") then

		-- show the tc tools handle
		WindowSetShowing("TCTOOLSWindowIMG", true)
	end
end

function StatusWindow.TCToolsOverend()

	-- hide the tc tools handle
	WindowSetShowing("TCTOOLSWindowIMG", false)
end

function StatusWindow.TCToolsOnLButtonDown(flags)

	-- pressing CTRL and drag, allows to move the status with the snap
	if flags == WindowUtils.ButtonFlags.CONTROL then

		-- enable the snapping
		SnapUtils.StartWindowSnap(WindowUtils.GetActiveDialog())
	end
end

function StatusWindow.SetMana(windowName, current, maximum)

	-- is the maximum 0 or we don't have the height?
	if maximum == 0 or not StatusWindow.MPHeight then
		return
	end

	-- calculate the max height for the bar
    local height = math.ceil((StatusWindow.MPHeight * current ) / maximum)

	-- is the height different from the current height?
    if height ~= StatusWindow.LastMPHeight then

		-- store the height
        StatusWindow.LastMPHeight = height

		-- update the mana pool height
        WindowSetDimensions(windowName .. "MANAFill", StatusWindow.MPWidth, height)
    end
end

function StatusWindow.SetHealth(windowName, current, maximum)

	-- is the maximum 0 or we don't have the height?
	if maximum == 0 or not StatusWindow.HPHeight then
		return
	end

	-- calculate the max height for the bar
    local height = math.ceil((StatusWindow.HPHeight * current ) / maximum)
	
	-- is the height different from the current height?
    if height ~= StatusWindow.LastHPHeight then

		-- store the height
        StatusWindow.LastHPHeight = height

		-- set the HP pool size
        WindowSetDimensions(windowName .. "HPFill", StatusWindow.HPWidth, height)
		
		-- poisoned: while the bar became green, this overlay remains red and indicates how many HP are left when the poison is over (if not cured)
		if WindowData.PlayerStatus.VisualStateId == 1 and StatusWindow.PoisonDamage then

			-- show the poison overlay
			WindowSetShowing(windowName .. "HPFillPoison", true)

			-- mortal strike applied?
			if BuffDebuff.ActiveBuffs[1027] then

				-- color the bar orangish
				WindowSetTintColor(windowName .. "HPFillPoison", 138 , 60, 13)

			else -- set the bar red
				WindowSetTintColor(windowName .. "HPFillPoison", 255, 0, 0)
			end
			
			-- calculate the height of the poisonoed HP pool
			height = math.ceil((StatusWindow.HPHeight * (current - StatusWindow.PoisonDamage.totalDamage)) / maximum)

			-- update the poisoned overlay size
			WindowSetDimensions(windowName .. "HPFillPoison", StatusWindow.HPWidth, height)

		else -- hide the poison overlay
			WindowSetShowing(windowName .. "HPFillPoison", false)
		end
    end
end

function StatusWindow.ChangeStyle(style, forced)

	-- do we have a different status?
	if Interface.Settings.StatusWindowStyle == style or forced then
		return
	end

	-- save the status position
	StatusWindow.SaveWindowPositions()	

	-- classic status
	if Interface.Settings.StatusWindowStyle == 0 and DoesWindowExist("StatusWindow") then

		-- destroy the status
		DestroyWindow("StatusWindow")

	-- advanced status
	elseif Interface.Settings.StatusWindowStyle == 1 and DoesWindowExist("AdvancedStatusWindowHP") then

		-- destroy the status
		DestroyWindow("AdvancedStatusWindowHP")
		DestroyWindow("AdvancedStatusWindowMANA")
		DestroyWindow("AdvancedStatusWindowSTAM")

	-- diablo status
	elseif Interface.Settings.StatusWindowStyle == 2 and DoesWindowExist("DiabloStatusWindow") then

		-- destroy the status
		DestroyWindow("DiabloStatusWindow")
		DestroyWindow("DiabloBottomBorderBG")
		DestroyWindow("DiabloHP")
		DestroyWindow("DiabloMANA")
		DestroyWindow("DiabloSTAM")
		DestroyWindow("DiabloAlwaysRunrBT")

	-- player overhead status
	elseif Interface.Settings.StatusWindowStyle == 3  then

		-- destroy the existing status
		OverheadText.DestroyPlayerHoverbar()
	end

	-- set the new status style
	Interface.Settings.StatusWindowStyle = style

	-- save the new status
	Interface.SaveSetting("StatusWindowStyle", Interface.Settings.StatusWindowStyle)
       
	-- re-initialize the status
	StatusWindow.Initialize()
end

function StatusWindow.ToggleButtons()

	-- classic status
	if Interface.Settings.StatusWindowStyle == 0 then

		-- show/hide the buttons based on the setting
		WindowSetShowing("StatusWindowGuardsButton", Interface.Settings.StatusButtons)
		WindowSetShowing("StatusWindowMenu", Interface.Settings.StatusButtons)
		WindowSetShowing("StatusWindowRedButton", Interface.Settings.StatusButtons)
		WindowSetShowing("StatusWindowGreenButton", Interface.Settings.StatusButtons)
		WindowSetShowing("StatusWindowBlueButton", Interface.Settings.StatusButtons)
	
	-- advanced status
	elseif Interface.Settings.StatusWindowStyle == 1 then

		-- show/hide the buttons based on the setting
		WindowSetShowing("AdvancedStatusWindowSTAMGuardsButton", Interface.Settings.StatusButtons)
		WindowSetShowing("AdvancedStatusWindowSTAMMenu", Interface.Settings.StatusButtons)
		WindowSetShowing("AdvancedStatusWindowSTAMRedButton", Interface.Settings.StatusButtons)
		WindowSetShowing("AdvancedStatusWindowSTAMGreenButton", Interface.Settings.StatusButtons)
		WindowSetShowing("AdvancedStatusWindowSTAMBlueButton", Interface.Settings.StatusButtons)

	-- diablo status
	elseif Interface.Settings.StatusWindowStyle == 2 then

		-- show/hide the buttons based on the setting
		WindowSetShowing("DiabloStatusWindowGuardsButton", Interface.Settings.StatusButtons)
		WindowSetShowing("DiabloStatusWindowRedButton", Interface.Settings.StatusButtons)
		WindowSetShowing("DiabloStatusWindowGreenButton", Interface.Settings.StatusButtons)
		WindowSetShowing("DiabloStatusWindowBlueButton", Interface.Settings.StatusButtons)
	end
end

function StatusWindow.UpdateGlowingStatus()

	-- is the notoriety aura disabled?
	if not Interface.Settings.AuraEnabled then

		-- remove the notoriety aura
		StatusWindow.RemoveNotorietyAura()

		-- show the wreath
		StatusWindow.ToggleWreath()

	-- is the notoriety aura enable?
	elseif Interface.Settings.AuraEnabled then

		-- remove the wreath
		StatusWindow.ToggleWreath(true)

		-- default style
		local statusStyle = "StatusWindow" -- default

		-- default anchor
		local anchorY = 12

		-- is the advanced status active?
		if Interface.Settings.StatusWindowStyle == 1 then

			-- set the correct window name
			statusStyle = "AdvancedStatusWindowSTAM"

		-- is the diablo style active?
		elseif Interface.Settings.StatusWindowStyle == 2 then

			-- set the correct window name
			statusStyle = "DiabloStatusWindow"

			-- set the correct anchor
			anchorY = 11
		end

		-- does the status window exist?
		if not DoesWindowExist(statusStyle) then
			return
		end

		-- is the glowing effect missing?
		if not DoesWindowExist("GlowingEffectAnimHealth") then

			-- create the glowing effect
			CreateWindowFromTemplate("GlowingEffectAnimHealth", "StatusGlowingEffect", statusStyle)

			-- reset the glowing effect anchors
			WindowClearAnchors("GlowingEffectAnimHealth")

			-- anchor the glowing effect to the status portrait
			WindowAddAnchor("GlowingEffectAnimHealth", "center", statusStyle .. "PortraitBg", "center", 14, anchorY)

			-- start the glowing animation
			AnimatedImageStartAnimation("GlowingEffectAnimHealth", 1, true, false, 0.0)  
			
			-- set the glowing animation speed
			AnimatedImageSetPlaySpeed("GlowingEffectAnimHealth", 10)
		end

		-- is the glowing effect scale different from the status scale?
		if WindowGetScale("GlowingEffectAnimHealth") ~= WindowGetScale(statusStyle) then

			-- scale the glowing effect correctly with the status
			WindowSetScale("GlowingEffectAnimHealth", WindowGetScale(statusStyle))
		end

		-- get the player notoriety
		local noto = Interface.ActiveMobilesOnScreen[GetPlayerID()] and Interface.ActiveMobilesOnScreen[GetPlayerID()].notoriety or 1

		-- set the glowing effect correct color with the notoriety
		WindowSetTintColor("GlowingEffectAnimHealth", NameColor.AuraColors[noto].r, NameColor.AuraColors[noto].g, NameColor.AuraColors[noto].b)
	end
end

function StatusWindow.ToggleWreath(remove)
	
	-- default style
	local statusStyle = "StatusWindow"

	-- default anchor
	local anchorY = 12

	-- is the advanced status active?
	if Interface.Settings.StatusWindowStyle == 1 then

		-- set the correct window name
		statusStyle = "AdvancedStatusWindowSTAM"

	-- is the diablo style active?
	elseif Interface.Settings.StatusWindowStyle == 2 then

		-- set the correct window name
		statusStyle = "DiabloStatusWindow"
	end

	-- does the status window exist?
	if not DoesWindowExist(statusStyle) then
		return
	end

	-- get the contributor data
	local contributor = CreditsWindow.GetContributorData(GetPlayerID())

	-- wreath window name
	local wreath = statusStyle .."PortraitWreath"

	-- do we have to remove the wreath?
	if remove then

		-- does the wreath exist?
		if DoesWindowExist(wreath) then

			-- destroy the wreath
			DestroyWindow(wreath)
		end

	-- is this a contributor?
	elseif contributor then

		-- does the wreath already exist?
		if not DoesWindowExist(wreath) then

			-- create wreath image
			CreateWindowFromTemplate(wreath, "WreathTemplate", statusStyle)

			-- anchor the wreath to the portrait
			WindowAddAnchor(wreath, "center", statusStyle .."Portrait", "center", 0, 0)

			-- get the color for the contributor perk
			local perkColor = CreditsWindow.ContributionPerks[contributor.perk]

			-- color the wreath
			WindowSetTintColor(wreath, perkColor.r, perkColor.g, perkColor.b)

			-- set the contributor title
			LabelSetText(wreath .. "Text", CreditsWindow.ContributionPerksName[contributor.perk])
		end
	end
end

function StatusWindow.ClassicStatusAsianFix()
	
	-- do we have the client in an asian language?
	if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
		
		-- clear the text location on the classic status
		WindowClearAnchors("StatusWindowHealthTooltip")
		WindowClearAnchors("StatusWindowManaTooltip")
		WindowClearAnchors("StatusWindowStaminaTooltip")

		-- set the new position of the text in the classic status
		WindowAddAnchor("StatusWindowHealthBar", "top", healthBarName, "top", 0, -6)
		WindowAddAnchor("StatusWindowManaBar", "top", manaBarName, "top", 0, -6)
		WindowAddAnchor("StatusWindowStaminaBar", "top", staminaBarName, "top", 0, -6)
	end
end

function StatusWindow.SetLockButtonTexture(button, locked)

	-- do we have the a valid button?
	if not DoesWindowExist(button) then
		return
	end

	-- default texture
	local texture = "UnLock"

	-- is the window locked?
	if locked then

		-- lock texture name
		texture = "Lock"
	end
	
	-- change the texture
	ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL, texture, 0,0)
	ButtonSetTexture(button,InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, texture, 0,0)
	ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED, texture, 0,0)
	ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, texture, 0,0)
end

function StatusWindow.RemoveNotorietyAura()

	-- do we have the aura active?
	if DoesWindowExist("GlowingEffectAnimHealth") then

		-- destroy the aura
		DestroyWindow("GlowingEffectAnimHealth")
	end
end

function StatusWindow.InitializeLagBar(windowName)
	
	-- do we have the a valid window?
	if not DoesWindowExist(windowName) then
		return
	end

	-- get the current lag bar dimensions
	local w, h = WindowGetDimensions(windowName .. "LagBar")

	-- set the lag bar starting color to green
	WindowSetTintColor(windowName .. "LagBar", 0, 255, 0)

	-- we need to resize the lag bar so it will be shown properly...
	-- increase the width by 1
	WindowSetDimensions(windowName .. "LagBar", w + 1, h)

	-- restore the lag bar width
	WindowSetDimensions(windowName .. "LagBar", w, h)
end

function StatusWindow.UpdatePortrait(windowName)

	-- get the contributor data
	local contributor = CreditsWindow.GetContributorData(GetPlayerID())

	-- do we have a contributor porrtait?
	if contributor and IsValidString(contributor.portrait) then

		-- get the contributor portrait
		local texture = contributor.portrait

		-- draw the texture
		CircleImageSetTexture(windowName .. "Portrait", texture, 32, 32)
		
		-- set the texture scale
		CircleImageSetTextureScale(windowName .. "Portrait", 0.843)

		return
	end

	-- do we have the paperdoll texture?
	if not SystemData.PaperdollTexture[GetPlayerID()] then
		return
	end

	-- get the texture data
	local textureData = SystemData.PaperdollTexture[GetPlayerID()]	
		
	-- initialize the texture position and scale variable
	local x, y, scale

	-- are we using the legacy paperdolls?
	if textureData.IsLegacy == 1 then

		-- set the positions for the legacy portrait
		x, y = -88, 10

		-- set the legacy portrait scale
		scale = 1.75

	else -- normal paperdolls

		-- set the positions for the legacy portrait
		x, y = -11, -191

		-- set the legacy portrait scale
		scale = 0.75
	end

	-- get the player gender
	local gender = GetMobileGender(GetPlayerID())

	-- get the player race
	local race = GetMobileGender(GetPlayerID())

	-- is the player female?
	if gender == 1 then

		-- is the player a gargoyle?
		if race == PaperdollWindow.GARGOYLE then
			
			-- upcate the portrait
			CircleImageSetTexture(windowName .. "Portrait", "paperdoll_texture" .. GetPlayerID(), x - textureData.xOffset + 8, y - textureData.yOffset - 22)

			-- update the scale
			CircleImageSetTextureScale(windowName .. "Portrait", InterfaceCore.scale * scale - 0.2)

		else -- any other race

			-- upcate the portrait
			CircleImageSetTexture(windowName .. "Portrait", "paperdoll_texture" .. GetPlayerID(), x - textureData.xOffset + 8, y - textureData.yOffset - 18)

			-- update the scale
			CircleImageSetTextureScale(windowName .. "Portrait", InterfaceCore.scale * scale)
		end

	else -- the player is male

		-- is the player an elf?
		if race == PaperdollWindow.ELF then

			-- upcate the portrait
			CircleImageSetTexture(windowName .. "Portrait", "paperdoll_texture" .. GetPlayerID(), x - textureData.xOffset - 3, y - textureData.yOffset - 5)

			-- update the scale
			CircleImageSetTextureScale(windowName .. "Portrait", InterfaceCore.scale * scale - 0.1)
		
		else -- any other race

			-- upcate the portrait
			CircleImageSetTexture(windowName .. "Portrait", "paperdoll_texture" .. GetPlayerID(), x - textureData.xOffset - 3, y - textureData.yOffset - 5)

			-- update the scale
			CircleImageSetTextureScale(windowName .. "Portrait", InterfaceCore.scale * scale)
		end
	end
end

function StatusWindow.RunButton_OnMouseOver()

	-- get the always run binding key
	local bindingText = SystemData.Settings.Keybindings["TOGGLE_ALWAYS_RUN"]

	-- do we have a valid key?
	if IsValidWString(bindingText) then

		-- set the binding text
		bindingText = L"\n" .. GetStringFromTid(Hotbar.TID_BINDING).. L" " .. bindingText
	end		

	-- create the item properties data
	local itemData = 
	{ 
		windowName = SystemData.ActiveWindow.name,
		itemId = 1234,
		itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
		binding = bindingText,
		titleTid = 1113150, -- Toggle Always Run
		bodyTid = 1115296 -- Your character will always run when using the right mouse button, regardless of mouse distance from your character.
	} 
			
	-- show the item properties
	ItemProperties.SetActiveItem(itemData)
end

function StatusWindow.RunButton_OnLButtonUp()

	-- invert the always run flag
	SystemData.Settings.GameOptions.alwaysRun = not SystemData.Settings.GameOptions.alwaysRun

	-- save the character profile
	UserSettingsChanged()

	-- toggle the pressed flag of the button based on if the always run is active or not
	ButtonSetPressedFlag(SystemData.ActiveWindow.name, SystemData.Settings.GameOptions.alwaysRun)
end

function StatusWindow.AlwaysRunContext()

	-- reset the context menu
	ContextMenu.CleanUp()

	-- create the params for the context menu
	local param = { type = "TOGGLE_ALWAYS_RUN", recordKey = 46, windowName = SystemData.ActiveWindow.name }

	-- create the context menu
	ContextMenu.CreateLuaContextMenuItem({tid = HotbarSystem.TID_ASSIGN_HOTKEY, returnCode = HotbarSystem.ContextReturnCodes.ASSIGN_KEY, param = param})

	-- show the context menu
	ContextMenu.ActivateLuaContextMenu(StatusWindow.AlwaysRunContextCallback)
end

function StatusWindow.AlwaysRunContextCallback(returnCode, param)

	-- is this the assign key option?
	if returnCode == HotbarSystem.ContextReturnCodes.ASSIGN_KEY then

		-- get the key index to assign
		SettingsWindow.CurKeyIndex = param.recordKey

		-- show the assign hotkey info tooltip
		WindowUtils.ShowAssignHotkeyInfo(param.windowName)
		
		-- flag that we are recording a settings key
		SettingsWindow.RecordingKey = true
		
		-- flag that we are recording a key
		SystemData.IsRecordingSettings = true

		-- begin the recording
		BroadcastEvent(SystemData.Events.INTERFACE_RECORD_KEY)
	end
end

function StatusWindow.UopdateStatusGuardsButton(guardedArea)
	
	-- make sure the value is true/false
	guardedArea = guardedArea == true

	-- are the status buttons enabled?
	if Interface.Settings.StatusButtons then					
		
		-- toggle the guards button
		WindowSetShowing("StatusWindowGuardsButton", guardedArea)
		WindowSetShowing("AdvancedStatusWindowSTAMGuardsButton", guardedArea)
		WindowSetShowing("DiabloStatusWindowGuardsButton", guardedArea)

	else -- disable the guards button
		WindowSetShowing("StatusWindowGuardsButton", false)
		WindowSetShowing("AdvancedStatusWindowSTAMGuardsButton", false)		
		WindowSetShowing("DiabloStatusWindowGuardsButton", false)
	end
end