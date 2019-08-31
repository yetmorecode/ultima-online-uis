----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

OverheadText = {}

----------------------------------------------------------------
-- *** Local Variables
----------------------------------------------------------------
OverheadText.QuestMarkers = {}
OverheadText.KillMarkers = {}
OverheadText.ActiveIdList = {}
OverheadText.FadeTimeId = {}
OverheadText.TimePassed = {}
OverheadText.AlphaStart = 1
OverheadText.AlphaDiff = 0.01
OverheadText.FadeStartTime = 4

OverheadText.FontIndex = 4
OverheadText.NameFontIndex = 4
OverheadText.SpellsFontIndex = 4
OverheadText.DamageFontIndex = 4

OverheadText.ChatData = {}
--how long the overhead chats will stay on screen (in sec's)
OverheadText.OverheadAlive = 10
OverheadText.MaxOverheadHeight = 150

OverheadText.LastSeeName = {}

OverheadText.hasHoverbar = {}

OverheadText.maxHoverbars = 20

OverheadText.mouseOverId = 0

OverheadText.GetsOverhead = {
	false, -- System
	true,  -- Say
	false, -- Private
	false, -- Custom
	true,  -- Emote
	true,  -- Gesture
	true,  -- Whisper
	true,  -- Yell
	false, -- Party
	false, -- Guild
	false, -- Alliance
	false, -- GM message
	false, -- private message
	false, -- global chat message
	false, -- you see
	false, -- note to self
	false, -- damage filter
}

OverheadText.CustomMessageHues = {}
OverheadText.CustomMessageHues.PINK = 23
OverheadText.CustomMessageHues.RED = 33
OverheadText.CustomMessageHues.LIGHTBLUE = 1152
OverheadText.CustomMessageHues.GREEN = 1270

----------------------------------------------------------------
-- OverheadText Functions
----------------------------------------------------------------
function OverheadText.InitializeEvents()
    -- we only want to register for these events once so we dont get the event for every instance of the name window
    WindowRegisterEventHandler("Root", SystemData.Events.SHOWNAMES_UPDATED, "OverheadText.HandleSettingsUpdate")
    WindowRegisterEventHandler("Root", SystemData.Events.SHOWNAMES_FLASH_TEMP, "OverheadText.HandleFlashTempNames")
    WindowRegisterEventHandler("Root", SystemData.Events.USER_SETTINGS_UPDATED, "OverheadText.UpdateSettings")
    
    OverheadText.UpdateSettings()
end

function OverheadText.Initialize()
	local this = SystemData.ActiveWindow.name
	local mobileId = SystemData.DynamicWindowId

	WindowSetId(this, mobileId)
	
	OverheadText.FadeTimeId[mobileId] = OverheadText.AlphaStart
	OverheadText.TimePassed[mobileId] = 0
	OverheadText.ActiveIdList[mobileId] = true

	OverheadText.ChatData[mobileId] = {}
	OverheadText.ChatData[mobileId].numVisibleChat = 0
	OverheadText.ChatData[mobileId].timePassed = {}
	OverheadText.ChatData[mobileId].timePassed[1] = 0
	OverheadText.ChatData[mobileId].timePassed[2] = 0
	OverheadText.ChatData[mobileId].timePassed[3] = 0
	OverheadText.ChatData[mobileId].showName = true

	-- if we don't have to show names, we don't...
	if SystemData.Settings.GameOptions.showNames ~= SystemData.Settings.GameOptions.SHOWNAMES_NONE then
		Interface.GetMobileNameData(mobileId)
		OverheadText.UpdateName(mobileId)
	else
		OverheadText.HideName(mobileId)
	end
	
	WindowSetShowing(this.."Chat1", false)
	WindowSetShowing(this.."Chat2", false)
	WindowSetShowing(this.."Chat3", false)
end

function OverheadText.Shutdown()
	local this = SystemData.ActiveWindow.name
	local mobileId = WindowGetId(this)
	
	OverheadText.FadeTimeId[mobileId] = nil
	OverheadText.TimePassed[mobileId] = nil
	OverheadText.ActiveIdList[mobileId] = nil
	OverheadText.ChatData[mobileId] = nil
	OverheadText.LastSeeName[mobileId] = nil
	
	if (OverheadText.mouseOverId == mobileId) then
		OverheadText.NameOnMouseOverEnd()
	end
	
	if DoesWindowExist("OverheadTextWindow_"..mobileId) then
		DetachWindowFromWorldObject( mobileId, "OverheadTextWindow_"..mobileId )
	end
end

function OverheadText.HandleSettingsUpdate()
	for i, id in pairs(OverheadText.ActiveIdList) do
		local windowName = "OverheadTextWindow_"..i
		if (SystemData.Settings.GameOptions.showNames == SystemData.Settings.GameOptions.SHOWNAMES_NONE) then
			OverheadText.HideName(i)
		elseif (SystemData.Settings.GameOptions.showNames == SystemData.Settings.GameOptions.SHOWNAMES_APPROACHING or SystemData.Settings.GameOptions.showNames == SystemData.Settings.GameOptions.SHOWNAMES_ALL) then
			OverheadText.ShowName(i)
		end
	end
end

-- Used in the Macro Action 'All Names'
-- If the Show Names setting isn't set on 'Always', it will show all the names temporarily on the screen.
function OverheadText.HandleFlashTempNames()
	for i, id in pairs(OverheadText.ActiveIdList) do
		OverheadText.UpdateName(i)
		OverheadText.ShowName(i)
	end
end

function OverheadText.UpdateSettings()
	local userSetting = SystemData.Settings.Interface.OverheadChatFadeDelay
	
	if (userSetting == 1) then
		OverheadText.OverheadAlive = 5
	elseif (userSetting == 2) then
		OverheadText.OverheadAlive = 10
	elseif (userSetting == 3) then
		OverheadText.OverheadAlive = 30
	elseif (userSetting == 4) then
		OverheadText.OverheadAlive = 60
	elseif (userSetting == 5) then
		OverheadText.OverheadAlive = 300
	elseif (userSetting == 6) then
		OverheadText.OverheadAlive = 0
	else
		OverheadText.OverheadAlive = 5
	end
end

function OverheadText.GetFreeHoverbarID()

	-- looping all the possible IDs in search of a free one
	for i = 1, OverheadText.maxHoverbars do
		
		local found = false

		-- searching if the ID is free
		for mobileId, id in pairs(OverheadText.hasHoverbar) do
			
			-- do we have this ID?
			if id == i then
				found = true
				break
			end
		end
		
		-- if we haven't found the ID, then the ID is free
		if not found then 
			return i
		end
	end

	return -1
end

function OverheadText.CreatePlayerHoverbar()

	-- get the player ID
	local mobileId = GetPlayerID()

	-- is the mobile ID valid?
	if not IsValidID(mobileId) then
		return
	end

	-- bar window
	local hoverBar = "Hoverbar_"..mobileId

	-- is the bar already there?
	if DoesWindowExist(hoverBar) then
		return
	end

	-- get a free bar ID
	local barId = OverheadText.GetFreeHoverbarID()

	-- if we have -1 as bar ID, means that we have too many bars already, so we exceed the cap for the player bar
	if barId == -1 then
		barId = OverheadText.maxHoverbars + 1
	end
	
	-- player name window
	local windowName = "OverheadTextWindow_"..mobileId

	-- player overhead chat window
	local overheadChatWindow = windowName.."Chat1"
	
	-- does the window exist?
	if not DoesWindowExist(windowName) then

		CreateWindowFromTemplate(windowName, "OverheadTextWindow", "Root")
		AttachWindowToWorldObject( mobileId, windowName )
		WindowSetScale(windowName, Interface.Settings.OverhedTextSize)

		OverheadText.FadeTimeId[mobileId] = OverheadText.AlphaStart
		OverheadText.TimePassed[mobileId] = 0
		OverheadText.ActiveIdList[mobileId] = true

		OverheadText.ChatData[mobileId] = {}
		OverheadText.ChatData[mobileId].numVisibleChat = 0
		OverheadText.ChatData[mobileId].timePassed = {}
		OverheadText.ChatData[mobileId].timePassed[1] = 0
		OverheadText.ChatData[mobileId].timePassed[2] = 0
		OverheadText.ChatData[mobileId].timePassed[3] = 0
		OverheadText.ChatData[mobileId].showName = false

		WindowSetShowing(windowName.."Chat1", false)
		WindowSetShowing(windowName.."Chat2", false)
		WindowSetShowing(windowName.."Chat3", false)

		OverheadText.HideName(mobileId)
	end

	-- create the bar
	CreateWindowFromTemplate(hoverBar, "PlayerOverheadHealthbar", "Root")

	-- associate the mobile ID to the window
	WindowSetId(hoverBar, mobileId)

	-- mobile name window
	local mobileName = "OverheadTextWindow_"..mobileId

	-- attach the bar on top of the mobile
	--AttachWindowToWorldObject(mobileId, hoverBar)
	WindowAddAnchor(hoverBar, "bottom", mobileName, "bottom", 0, 0)

	-- initialize the heath bar
	StatusBarSetCurrentValue( hoverBar.."HealthBar", WindowData.PlayerStatus.CurrentHealth )	
	StatusBarSetMaximumValue( hoverBar.."HealthBar", WindowData.PlayerStatus.MaxHealth )

	-- initialize the mana bar
	StatusBarSetCurrentValue( hoverBar.."ManaBar", WindowData.PlayerStatus.CurrentMana )	
	StatusBarSetMaximumValue( hoverBar.."ManaBar", WindowData.PlayerStatus.MaxMana )

	-- coloring mana bar
	WindowSetTintColor(hoverBar.."ManaBar", 0, 0, 255)

	-- initialize the stamina bar
	StatusBarSetCurrentValue( hoverBar.."StaminaBar", WindowData.PlayerStatus.CurrentStamina )	
	StatusBarSetMaximumValue( hoverBar.."StaminaBar", WindowData.PlayerStatus.MaxStamina )

	-- coloring mana bar
	WindowSetTintColor(hoverBar.."StaminaBar", 255, 242, 0)

	-- initialize the health bar BG
	StatusBarSetCurrentValue( hoverBar.."HealthBG", 100 )	
	StatusBarSetMaximumValue( hoverBar.."HealthBG", 100 )

	-- coloring the health bar background
	WindowSetTintColor(hoverBar.."HealthBG", 30, 30, 30)

	-- initialize the mana bar BG
	StatusBarSetCurrentValue( hoverBar.."ManaBG", 100 )	
	StatusBarSetMaximumValue( hoverBar.."ManaBG", 100 )

	-- coloring the mana bar background
	WindowSetTintColor(hoverBar.."ManaBG", 30, 30, 30)

	-- initialize the stamina bar BG
	StatusBarSetCurrentValue( hoverBar.."StaminaBG", 100 )	
	StatusBarSetMaximumValue( hoverBar.."StaminaBG", 100 )

	-- coloring the stamina bar background
	WindowSetTintColor(hoverBar.."StaminaBG", 30, 30, 30)

	-- making the background slightly bigger so it will work as a border for the healthbar
	WindowSetScale(hoverBar.."HealthBG", WindowGetScale(hoverBar.."HealthBar") + 0.05)
	WindowSetScale(hoverBar.."ManaBG", WindowGetScale(hoverBar.."HealthBar") + 0.05)
	WindowSetScale(hoverBar.."StaminaBG", WindowGetScale(hoverBar.."HealthBar") + 0.05)

	-- load the bar to the array
	OverheadText.hasHoverbar[mobileId] = barId
	
	-- update the name
	OverheadText.UpdateHoverbarName(mobileId)

	-- the bar still exist? (if it has been converted into a boss bar it will not)
	if DoesWindowExist(hoverBar) then

		-- update status
		OverheadText.UpdateHoverbarStatus(mobileId)

		-- update bar color
		HealthBarColor.UpdateHealthBarColor(hoverBar.."HealthBar", mobileId == GetPlayerID() and WindowData.PlayerStatus.VisualStateId or WindowData.HealthBarColor[mobileId].VisualStateId)

		-- unhighlight the bar selected
		OverheadText.UnhighlightHoverbars(hoverBar)
	end

	-- if the overhead name is visible, we hide it
	OverheadText.HideName(mobileId)
end

function OverheadText.CreateHoverbar(mobileId)

	-- is the mobile ID valid?
	if not IsValidID(mobileId) or mobileId == BossBar.GetActiveBoss() then
		return
	end

	-- bar window
	local hoverBar = "Hoverbar_"..mobileId

	-- is the bar already there?
	if DoesWindowExist(hoverBar) then
		return
	end

	-- get a free bar ID
	local barId = OverheadText.GetFreeHoverbarID()

	-- if we have -1 as bar ID, means that we have too many bars already
	if barId == -1 then
		return
	end

	-- mobile name window
	local mobileName = "OverheadTextWindow_"..mobileId.."Chat1"

	-- is the mobile name window already there?
	if not DoesWindowExist(mobileName) then
		return
	end

	-- create the bar
	CreateWindowFromTemplate(hoverBar, "OverheadHealthbar", "Root")

	-- associate the mobile ID to the window
	WindowSetId(hoverBar, mobileId)

	-- attach the bar on top of the mobile
	--AttachWindowToWorldObject(mobileId, hoverBar)
	WindowAddAnchor(hoverBar, "top", mobileName, "bottom", 0, 0)

	-- initialize the bar
	StatusBarSetCurrentValue( hoverBar.."HealthBar", 100 )	
	StatusBarSetMaximumValue( hoverBar.."HealthBar", 100 )

	-- initialize the bar BG
	StatusBarSetCurrentValue( hoverBar.."BG", 100 )	
	StatusBarSetMaximumValue( hoverBar.."BG", 100 )

	-- coloring the bar background
	WindowSetTintColor(hoverBar.."BG", 30, 30, 30)

	-- making the background slightly bigger so it will work as a border for the healthbar
	WindowSetScale(hoverBar.."BG", WindowGetScale(hoverBar.."HealthBar") + 0.05)

	-- load the bar to the array
	OverheadText.hasHoverbar[mobileId] = barId

	-- get the mobile data for the specified ID
	local mobileData = Interface.ActiveMobilesOnScreen[mobileId]

	-- we must not register the mobile data of invulnerable npcs
	if not IsMobileInvulnerable(mobileId) then
		
		-- does the status needs to be registered and the mobile is NOT invulnerable?
		if not mobileData.invulnerable and not Interface.VerifyMobileData(mobileId, WindowData.MobileStatus[mobileId]) then
			Interface.GetMobileData(mobileId)
		end
	end

	-- does the name needs to be registered 
	if not Interface.VerifyMobileName(mobileId, WindowData.MobileName[mobileId]) then
		Interface.GetMobileNameData(mobileId)
	end
	
	-- update the name
	OverheadText.UpdateHoverbarName(mobileId)

	-- update status
	OverheadText.UpdateHoverbarStatus(mobileId)

	-- update bar color
	HealthBarColor.UpdateHealthBarColor(hoverBar.."HealthBar", WindowData.HealthBarColor[mobileId].VisualStateId)

	-- unhighlight the bar selected
	OverheadText.UnhighlightHoverbars(hoverBar)

	-- if the overhead name is visible, we hide it
	OverheadText.HideName(mobileId)
end

function OverheadText.HandleHealthBarStateUpdate(mobileId)

	-- is the mobile ID valid?
	if not IsValidID(mobileId) then
		return
	end

	-- bar window
	local hoverBar = SystemData.ActiveWindow.name

	-- is the bar already there?
	if not DoesWindowExist(hoverBar) then
		return
	end

	-- get the enabled status
	local enabled = IsHealthBarEnabled(mobileId)

	-- toggle the healthbar based on the status
	WindowSetShowing(hoverBar, enabled)
end

function OverheadText.UpdateHoverbarNameColor(mobileId)
	
	-- is the mobile ID valid?
	if not IsValidID(mobileId) then
		return
	end

	-- bar window
	local hoverBar = "Hoverbar_" .. mobileId

	-- is the bar already there?
	if not DoesWindowExist(hoverBar) then
		return
	end

	-- get the mobile data for the specified ID
	local mobileData = Interface.ActiveMobilesOnScreen[mobileId]
	
	-- no mobile data (this should not happen since we have all the data for the mobiles on screen)
	if not mobileData then
		return
	end

	-- coloring the name
	NameColor.UpdateLabelNameColor(hoverBar .. "Name", mobileData.notoriety)
end

function OverheadText.UpdateHoverbarName(mobileId)
	
	-- is the mobile ID valid?
	if not IsValidID(mobileId) then
		return
	end

	-- bar window
	local hoverBar = "Hoverbar_"..mobileId

	-- is the bar already there?
	if not DoesWindowExist(hoverBar) then
		return
	end

	-- is the mobile status available?
	if mobileId ~= GetPlayerID() and not Interface.VerifyMobileName(mobileId, WindowData.MobileStatus[mobileId]) then

		-- we must not register the mobile data of invulnerable npcs
		if not IsMobileInvulnerable(mobileId) then
		
			-- does the status needs to be registered and the mobile is NOT invulnerable?
			if not mobileData or not mobileData.invulnerable and not Interface.VerifyMobileData(mobileId, WindowData.MobileStatus[mobileId]) then
				Interface.GetMobileData(mobileId)
			end
		end

		-- does the name needs to be registered 
		if not Interface.VerifyMobileName(mobileId, WindowData.MobileName[mobileId]) then
			Interface.GetMobileNameData(mobileId)
		end
	end

	-- get the mobile data for the specified ID
	local mobileData = Interface.ActiveMobilesOnScreen[mobileId]
	
	-- no mobile data (this should not happen since we have all the data for the mobiles on screen)
	if not mobileData then

		-- try again in a short time
		Interface.ExecuteWhenAvailable(
		{
			name = "hoverbarNameUpdate" .. mobileId,
			check = function() return Interface.ActiveMobilesOnScreen[mobileId] ~= nil end, 
			callback = function() OverheadText.UpdateHoverbarName(mobileId) end, 
			removeOnComplete = true
		})

	else
		-- write the name on the label
		LabelSetText(hoverBar .. "Name", mobileData.name)

		-- update the name color
		OverheadText.UpdateHoverbarNameColor(mobileId)
	end
end

function OverheadText.HoverbarColorUpdate(mobileId)

	-- bar window
	local hoverBar = "Hoverbar_" .. mobileId

	-- is the bar already there?
	if not DoesWindowExist(hoverBar) then
		return
	end

	-- do we have the healthbar colors yet?
	if WindowData.HealthBarColor[mobileId] then

		-- update bar color
		HealthBarColor.UpdateHealthBarColor(hoverBar .. "HealthBar", WindowData.HealthBarColor[mobileId].VisualStateId)

	else -- update as soon as we have them
		Interface.ExecuteWhenAvailable(
		{
			name = "UpdateHoverbarColors" .. mobileId,
			check = function() return WindowData.HealthBarColor[mobileId] ~= nil end, 
			callback = function() HealthBarColor.UpdateHealthBarColor(hoverBar .. "HealthBar", WindowData.HealthBarColor[mobileId].VisualStateId) end, 
			removeOnComplete = true
		})

		-- update the healthbar color with a default color
		HealthBarColor.UpdateHealthBarColor(hoverBar .. "HealthBar", 0)
	end
end

OverheadText.HighlightDelta = 0
function OverheadText.UpdateStatusTimer(timePassed)
	
	-- get the mobile ID
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)

	-- is the mobile ID valid?
	if not IsValidID(mobileId) then
		return
	end

	-- are the hoverbar active?
	if not Interface.Settings.HoverbarsActive and Interface.Settings.StatusWindowStyle ~= 3 then
	
		-- destroy the hoverbar
		OverheadText.DestroyHoverbarByID(mobileId)
		return
	end

	-- bar window
	local hoverBar = SystemData.ActiveWindow.name

	-- is the bar already there?
	if not DoesWindowExist(hoverBar) then
		return
	end

	-- is the mouse over this bar? or is the player status and the option to always show the text is active?
	if WindowUtils.GetTopmostDialog(SystemData.MouseOverWindow.name) == hoverBar or (mobileId == GetPlayerID() and SystemData.Settings.GameOptions.showStrLabel) then
	
		-- highlight the bar
		OverheadText.HighlightHoverbars(hoverBar)
	end

	-- limit the highlight check once per second
	OverheadText.HighlightDelta = OverheadText.HighlightDelta + timePassed
	if OverheadText.HighlightDelta >= 1 then

		-- reset the highlight check timer
		OverheadText.HighlightDelta = 0

		-- scan all highlit bars
		for mob, _ in pairs(OverheadText.HightlightBars) do

			
			if	(OverheadText.mouseOverId ~= mob and TargetWindow.TargetId ~= mob and mob ~= GetPlayerID()) or  -- is the bar no longer under the mouse cursor or the current target?
				(OverheadText.mouseOverId ~= mob and TargetWindow.TargetId ~= mob and mob == GetPlayerID() and SystemData.Settings.GameOptions.showStrLabel == false)  -- is the bar no longer under the mouse cursor or the current target and is the player ID and the numbers on status are disabled?
			then

				-- remove the highlight
				OverheadText.UnhighlightHoverbars("Hoverbar_"..mob)
			end
		end
	end
end

function OverheadText.UpdateHoverbarStatus(mobileId)
	
	-- is the mobile ID valid?
	if not IsValidID(mobileId) then
		return
	end

	-- bar window
	local hoverBar = "Hoverbar_" .. mobileId
	
	-- is the bar already there?
	if not DoesWindowExist(hoverBar) then
		return
	end
	
	-- get the mobile distance
	local dist = GetDistanceFromPlayer(mobileId)

	-- is the mobile visible?
	if dist < 0 or dist > 15 then
				
		-- destroy the hoverbar
		OverheadText.DestroyHoverbarByID(mobileId)
		return
	end

	-- mobile name window
	local mobileName = "OverheadTextWindow_" .. mobileId .. "Chat1"

	-- is the mobile name window already there?
	if not DoesWindowExist(mobileName) then
		OverheadText.DestroyHoverbarByID(mobileId)
		return
	end
		
	-- fix the bar anchors
	WindowClearAnchors(hoverBar)
	WindowAddAnchor(hoverBar, "top", mobileName, "bottom", 0, 0)

	-- if the overhead name is visible, we hide it
	OverheadText.HideName(mobileId)

	-- is the mobile status available?
	if mobileId ~= GetPlayerID() and not Interface.VerifyMobileData(mobileId, WindowData.MobileStatus[mobileId]) then

		-- we must not register the mobile data of invulnerable npcs
		if not IsMobileInvulnerable(mobileId) then
		
			-- does the status needs to be registered and the mobile is NOT invulnerable?
			if not mobileData.invulnerable and not Interface.VerifyMobileData(mobileId, WindowData.MobileStatus[mobileId]) then
				Interface.GetMobileData(mobileId)
			end
		end

		-- does the name needs to be registered 
		if not Interface.VerifyMobileName(mobileId, WindowData.MobileName[mobileId]) then
			Interface.GetMobileNameData(mobileId)
		end
	end

	-- get the mobile data for the specified ID
	local mobileStatus = Interface.ActiveMobilesOnScreen[mobileId]
	
	-- do we have the mobile data?
	if not mobileStatus or not mobileStatus.maxHealth or mobileStatus.maxHealth == 0 then

		-- update the mobiles on screen data
		Interface.UpdateMobileOnScreenStatus(mobileId)

		-- try again in a short time
		Interface.ExecuteWhenAvailable(
		{
			name = "hoverbarStatusUpdate" .. mobileId,
			check = function() return Interface.ActiveMobilesOnScreen[mobileId] ~= nil end, 
			callback = function() OverheadText.UpdateHoverbarStatus(mobileId) end, 
			removeOnComplete = true,
		})
		
		return
	end

	-- is this the player hoverbar?
	if mobileId ~= GetPlayerID() then

		-- update healthbar
		StatusBarSetMaximumValue(hoverBar .. "HealthBar", mobileStatus.maxHealth)
		StatusBarSetCurrentValue(hoverBar .. "HealthBar", mobileStatus.curHealth)	

		-- Update percentage
		LabelSetText(hoverBar .. "Perc", mobileStatus.perc .. L"%")

	else -- player hoverbar
		
		-- mobile name window
		local mobileName = "OverheadTextWindow_"..GetPlayerID()

		-- clear the bar position
		WindowClearAnchors(hoverBar)

		-- attach the bar on top of the mobile name or first chat line
		if DoesWindowExist(mobileName.. "Chat1") then
			WindowAddAnchor(hoverBar, "top", mobileName.. "Chat3", "bottom", 0, 0)
		else
			WindowAddAnchor(hoverBar, "top", mobileName, "bottom", 0, 0)
		end

		-- update healthbar
		StatusBarSetMaximumValue(hoverBar .. "HealthBar", mobileStatus.maxHealth)
		StatusBarSetCurrentValue(hoverBar .. "HealthBar", mobileStatus.curHealth)	

		-- poisoned: while the bar became green, this overlay remains red and indicates how many HP are left when the poison is over (if not cured)
		if WindowData.PlayerStatus.VisualStateId == 1 and StatusWindow.PoisonDamage then
			WindowSetShowing(hoverBar.."HealthBarPoison", true)

			-- mortal strike applied?
			if BuffDebuff.ActiveBuffs[1027] then
				WindowSetTintColor(hoverBar.."HealthBarPoison", 255, 255, 0)
			else
				WindowSetTintColor(hoverBar.."HealthBarPoison", 255 , 0, 0)
			end

			StatusBarSetMaximumValue( hoverBar.."HealthBarPoison", WindowData.PlayerStatus.MaxHealth )
			StatusBarSetCurrentValue( hoverBar.."HealthBarPoison", WindowData.PlayerStatus.CurrentHealth - StatusWindow.PoisonDamage.totalDamage)
		else
			WindowSetShowing(hoverBar.."HealthBarPoison", false)
		end

		-- Update percentage
		LabelSetText(hoverBar .. "HealthPerc", mobileStatus.perc .. L"%")

		-- update mana
		StatusBarSetCurrentValue(hoverBar .. "ManaBar", WindowData.PlayerStatus.CurrentMana)	
		StatusBarSetMaximumValue(hoverBar .. "ManaBar", WindowData.PlayerStatus.MaxMana)

		-- get the mana percentage
		perc = (WindowData.PlayerStatus.CurrentMana / WindowData.PlayerStatus.MaxMana) * 100
		perc = math.floor(perc)

		-- Update percentage
		if perc then
			LabelSetText(hoverBar .. "ManaPerc", perc .. L"%")
		end

		-- update stamina
		StatusBarSetCurrentValue(hoverBar .. "StaminaBar", WindowData.PlayerStatus.CurrentStamina)	
		StatusBarSetMaximumValue(hoverBar .. "StaminaBar", WindowData.PlayerStatus.MaxStamina)

		-- get the mana percentage
		perc = (WindowData.PlayerStatus.CurrentStamina / WindowData.PlayerStatus.MaxStamina) * 100
		perc = math.floor(perc)

		-- Update percentage
		if perc then
			LabelSetText(hoverBar .. "StaminaPerc", perc .. L"%")
		end

		-- Update values
		LabelSetText(hoverBar .. "HealthValue", WindowData.PlayerStatus.CurrentHealth .. L" / " .. WindowData.PlayerStatus.MaxHealth)
		LabelSetText(hoverBar .. "ManaValue", WindowData.PlayerStatus.CurrentMana .. L" / " .. WindowData.PlayerStatus.MaxMana)
		LabelSetText(hoverBar .. "StaminaValue", WindowData.PlayerStatus.CurrentStamina .. L" / " .. WindowData.PlayerStatus.MaxStamina)
	end
end

function OverheadText.DestroyHoverbarByID(mobileId)

	-- is the mobile ID valid?
	if not IsValidID(mobileId) then
		return
	end
	
	-- bar window
	local hoverBar = "Hoverbar_"..mobileId

	-- does the bar exist?
	if DoesWindowExist(hoverBar) then

		-- remove the bar from the awway
		OverheadText.hasHoverbar[mobileId] = nil

		-- detach the bar from the world object
		DetachWindowFromWorldObject(mobileId, hoverBar)

		-- destroy the window
		DestroyWindow(hoverBar)
	end
end

function OverheadText.DestroyPlayerHoverbar()

	-- get the player ID
	local mobileId = GetPlayerID()

	-- bar window
	local hoverBar = "Hoverbar_"..mobileId

	-- is the bar exist?
	if not DoesWindowExist(hoverBar) then
		return
	end

	-- remove the bar from the awway
	OverheadText.hasHoverbar[mobileId] = nil

	-- destroy the window
	DestroyWindow(hoverBar)
end

function OverheadText.GetHoverbarByID(barId)

	for mobileId, id in pairs(OverheadText.hasHoverbar) do
		if barId == id then
			return "Hoverbar_"..mobileId
		end
	end
end

OverheadText.HoverBarCurrentShift = 0
function OverheadText.ShiftHoverbar(x, y, delta)
	
	-- hoverbar name
	local hoverBar = SystemData.ActiveWindow.name

	-- get the mobile ID
	local mobileId = WindowGetId(hoverBar)

	-- get the bar ID
	local currBarID = OverheadText.hasHoverbar[mobileId]

	-- get the overlapping bars list
	local overlappingBars = OverheadText.GetOverlappingHoverbars(hoverBar)

	-- do we have overlapping bars?
	if #overlappingBars < 1 then
		return
	end
	
	-- adding current bar to the list
	table.insert(overlappingBars, 1, mobileId)

	-- get the min and max bar ID we have
	local min, max = OverheadText.GetMinMaxIds(overlappingBars)

	-- scroll down
	if delta < 0 then
		
		-- if the current selection is 0 or less than the min, we initialize it to the max value
		if OverheadText.HoverBarCurrentShift == 0 or OverheadText.HoverBarCurrentShift <= min or OverheadText.HoverBarCurrentShift == 1 then
			OverheadText.HoverBarCurrentShift = OverheadText.maxHoverbars + 2
		end
		
		-- scan the bar shift array (+1 because the player bar can always exceed the cap)
		for barId = OverheadText.maxHoverbars + 1, 1, -1 do
			
			-- if the current bar ID is less than our min, we can continue
			if barId < min then
				continue
			end

			-- is this the current topmost bar?
			if barId == OverheadText.HoverBarCurrentShift then
				continue
			end

			-- does this ID is part of the overlapping array?
			if not OverheadText.IsInTheOverlappingGroup(overlappingBars, barId) then
				continue
			end

			-- is this the current bar ID less than the one that is active?
			if barId < OverheadText.HoverBarCurrentShift then
				
				-- we found a good one, so we highlight it and bring it to top
				
				-- get the current hoverbar name
				local currSelected = OverheadText.GetHoverbarByID(OverheadText.HoverBarCurrentShift)
				
				-- does the old selection window exists?
				if DoesWindowExist(currSelected) then
					
					-- reset the bar layer
					WindowSetLayer(currSelected, Window.Layers.BACKGROUND)
				end

				-- get the new selection name
				local newSelect = OverheadText.GetHoverbarByID(barId)

				-- update the mouse over ID
				OverheadText.mouseOverId = WindowGetId(newSelect)

				-- bring the hoverbar overlay
				WindowSetLayer(newSelect, Window.Layers.DEFAULT)

				-- highlight the bar
				OverheadText.HighlightHoverbars(newSelect)

				-- update the current shift
				OverheadText.HoverBarCurrentShift = barId

				-- all done!
				return
			end
		end

	else -- scroll up

		-- if the current selection is 0 or less than the min, we initialize it to the max value
		if OverheadText.HoverBarCurrentShift >= max or OverheadText.HoverBarCurrentShift == OverheadText.maxHoverbars + 1 then
			OverheadText.HoverBarCurrentShift = 0
		end
		
		-- scan the bar shift array (+1 because the player bar can always exceed the cap)
		for barId = 1, OverheadText.maxHoverbars + 1 do
		
			-- is this the current topmost bar?
			if barId == OverheadText.HoverBarCurrentShift then
				continue
			end

			-- does this ID is part of the overlapping array?
			if not OverheadText.IsInTheOverlappingGroup(overlappingBars, barId) then
				continue
			end

			-- is this the current bar ID less than the one that is active?
			if barId > OverheadText.HoverBarCurrentShift then
				
				-- we found a good one, so we highlight it and bring it to top
				
				-- get the current hoverbar name
				local currSelected = OverheadText.GetHoverbarByID(OverheadText.HoverBarCurrentShift)
				
				-- does the old selection window exists?
				if DoesWindowExist(currSelected) then
					
					-- reset the bar layer
					WindowSetLayer(currSelected, Window.Layers.POPUP)
				end

				-- get the new selection name
				local newSelect = OverheadText.GetHoverbarByID(barId)

				-- update the mouse over ID
				OverheadText.mouseOverId = WindowGetId(newSelect)

				-- bring the hoverbar overlay
				WindowSetLayer(newSelect, Window.Layers.OVERLAY)

				-- highlight the bar
				OverheadText.HighlightHoverbars(newSelect)

				-- update the current shift
				OverheadText.HoverBarCurrentShift = barId

				-- all done!
				return
			end
		end
	end
end

function OverheadText.IsInTheOverlappingGroup(overlappingArray, barId)

	-- get the bar name
	local newSelect = OverheadText.GetHoverbarByID(barId)

	-- do we have a valid window?
	if not DoesWindowExist(newSelect) then
		return false
	end

	-- get the mobile ID
	local mobileId = WindowGetId(newSelect)

	-- scanning all overlapping bars to get the min and max ids
	for i = 1, #overlappingArray do
		
		-- current mobile ID
		local currMobileId = overlappingArray[i]

		-- is this the mobile we're looking for?
		if currMobileId == mobileId then
			return true
		end
	end

	return false
end

function OverheadText.GetMinMaxIds(overlappingArray)
	
	local min = 0
	local max = 0
	
	-- scanning all overlapping bars to get the min and max ids
	for i = 1, #overlappingArray do
		
		-- current mobile ID
		local mobileId = overlappingArray[i]

		-- get the current bar ID
		local barId = OverheadText.hasHoverbar[mobileId]

		if min == 0 or min > barId then
			min = barId
		end

		if max == 0 or max < barId then
			max = barId
		end
	end

	return min, max
end

OverheadText.NameParsed = {}

function OverheadText.UpdateName(mobileId)

	-- Player and object names are not displayed
	if (OverheadText.ChatData[mobileId] == nil) then
		return
	end
	if (OverheadText.ChatData[mobileId].showName == false) then
		return
	end

	local windowName = "OverheadTextWindow_"..mobileId
	
	--If windowName does not exist exit funciton
	if (DoesWindowExist( windowName) == false) then
		return
	end

	-- do we have the mobile name data?
	if not Interface.VerifyMobileName(mobileId, WindowData.MobileName[mobileId]) then
		Interface.GetMobileNameData(mobileId)
	end

	-- add the creation time	
	OverheadText.NameParsed[mobileId] = Interface.TimeSinceLogin

	-- we show the name as soon as it's available
	Interface.ExecuteWhenAvailable(
	{
		name = "overheadNameUpdate" .. mobileId,
		check = function() return Interface.VerifyMobileName(mobileId, WindowData.MobileName[mobileId]) ~= nil end, 
		callback = function() OverheadText.UpdateNameCorrectly(mobileId) OverheadText.NameParsed[mobileId] = nil end,
		removeOnComplete = true
	})
end

function OverheadText.UpdateNameCorrectly(mobileId)

	-- overhead name window name
	local windowName = "OverheadTextWindow_"..mobileId

	--- the mobile is gone and so the window
	if (DoesWindowExist( windowName) == false) then
		OverheadText.NameParsed[mobileId] = nil
		return
	end

	-- get the mobile name and notoriety
	local mobName = GetMobileName(mobileId, false, true)
	local noto = GetMobileNotoriety(mobileId)

	-- do we have a valid name?
	if IsValidWString(mobName) then	

		-- is the mobile the player?
		local mobileIsPlayer = mobileId == GetPlayerID()

		-- we can ignore the player
		if not mobileIsPlayer then

			-- if the quest log has never been scanned we skip the quest marker part
			if QuestLog.QuestLogScannedAtLeastOnce and not QuestLog.ScanInProgress then

				-- does this mobile already have a quest marker (or has already been checked)?
				if not OverheadText.MobileHasQuestMarker(mobileId) and not OverheadText.MobileHasKillMarker(mobileId) then

					-- is the mobile a questgiver?
					if IsQuestGiver(mobileId) then

						-- does the quest giver already has a quest marker?
						if not OverheadText.MobileHasQuestMarker(mobileId) then
					
							-- add the quest marker
							OverheadText.AddQuestMarkerToMobile(mobileId)
						end

					-- this mobile requires a kill marker?
					elseif QuestLog.HasKillMarker(mobName) then
				
						-- does the mobile already has a kill marker?
						if not OverheadText.MobileHasKillMarker(mobileId) then
					
							-- add the kill marker
							OverheadText.AddKillMarkerToMobile(mobileId)
						end

					else -- we add a -1 to the array so we make sure we don't check this mobile again
						OverheadText.QuestMarkers[mobileId] = -1
					end
				end
			end

			-- adding the "You see xxx" line to the chat when the name appears
			if (not OverheadText.LastSeeName[mobileId]) then
				local passa = Interface.Settings.chat_SavedFilter[noto]

				if MobileHealthBar.IgnoredMobile(mobileId) then -- check for names to ignore
					passa  = false
				end
				if not Interface.Settings.chat_SavedFilter[9] and IsFarmAnimal(mobileId) then -- farm animals filter
					passa = false
				end
				if not Interface.Settings.chat_SavedFilter[10] and IsSummon(mobileId) then -- summons filter
					passa = false
				end
				if passa then	-- printing if has not been filtered
					if (not OverheadText.LastSeeName[mobileId]) then
						PrintWStringToChatWindow(GetStringFromTid(3002000) ..mobName,15) -- you see
					end
					OverheadText.LastSeeName[mobileId] = true -- filter to exclude duplicates of the same mobile name
				end
			end
		end
		
		-- initializing overhead name label with the correct font
		local labelName = windowName .. "Name"

		-- write the name
		LabelSetText(labelName, towstring(mobName))

		-- update the label font
		LabelSetFont(labelName, FontSelector.Fonts[OverheadText.NameFontIndex].fontName .. "_16", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)

		-- get the label text dimensions
		local x, y = LabelGetTextDimensions(labelName)

		-- scale the label to the player preferences
		WindowSetScale(windowName, Interface.Settings.OverhedTextSize)

		-- update the label dimensions
		WindowSetDimensions(windowName, x, y)

		-- coloring the label based on notoriety
		if (mobileId == Interface.CurrentHonor) then
			NameColor.UpdateLabelNameColor(labelName, NameColor.Notoriety.HONORED)
		else
			NameColor.UpdateLabelNameColor(labelName, noto)
		end

		OverheadText.UpdateOverheadAnchors(mobileId)

	else
		--Destroy the entire overhead text window if the mobile status is not there anymore.
		--Player probably teleported and we didn't delete the mobiles name.
  		if DoesWindowExist( windowName) then
			DestroyWindow(windowName)
		end

		-- remove the quest marker
		OverheadText.RemoveQuestMarkerFromMobile(mobileId)
		OverheadText.RemoveKillMarkerFromMobile(mobileId)
	end
end

OverheadText.QuestMarkerDelta = 0
function OverheadText.Update( timePassed )

	-- scan all the active quest markers
	for mobileId, markWindow in pairs(OverheadText.QuestMarkers) do
		
		-- is the mobile out of sight?
		if not IsMobileVisible(mobileId) then

			-- remove the quest marker
			OverheadText.RemoveQuestMarkerFromMobile(mobileId)
		end

		-- is the marker a valid window?
		if DoesWindowExist(markWindow) then

			-- has this NPC marker been disabled?
			if QuestLog.DisabledQuestMarkers[mobileId] then
				OverheadText.RemoveQuestMarkerFromMobile(mobileId)

			-- is the quest reward marker inactive?
			elseif not WindowGetShowing(markWindow .. "Reward") and not WindowGetShowing(markWindow .. "Reward_Grayed") and not WindowGetShowing(markWindow .. "Escort") then

				-- is the quest log full?
				if QuestLog.QuestCount >= QuestLog.QuestCap then
					WindowSetShowing(markWindow .. "Quest", false)
					WindowSetShowing(markWindow .. "Quest_Grayed", true)
				else
					WindowSetShowing(markWindow .. "Quest", true)
					WindowSetShowing(markWindow .. "Quest_Grayed", false)
				end
			end
		end
	end

	-- scan all the active quest markers
	for mobileId, markWindow in pairs(OverheadText.KillMarkers) do

		-- is the mobile out of sight?
		if not IsMobileVisible(mobileId) then

			-- remove the quest marker
			OverheadText.RemoveKillMarkerFromMobile(mobileId)
		end
	end

	-- is it time to check if we have all the quest markers?
	if OverheadText.QuestMarkerDelta > 2 and QuestLog.QuestLogScannedAtLeastOnce and not QuestLog.ScanInProgress then

		-- scan all the mobiles on screen
		for mobileId, _ in pairs(Interface.ActiveMobilesOnScreen) do
			
			-- get the mobile name
			local mobName = GetMobileName(mobileId, false, true)

			-- we ignore the player
			if mobileId ~= GetPlayerID() then

				-- does this mobile already have a quest marker (or has already been checked)?
				if not OverheadText.MobileHasQuestMarker(mobileId) and not OverheadText.MobileHasKillMarker(mobileId) and not QuestLog.DisabledQuestMarkers[mobileId] then

					-- is the mobile a questgiver?
					if IsQuestGiver(mobileId) then

						-- does the quest giver already has a quest marker?
						if not OverheadText.MobileHasQuestMarker(mobileId) then
					
							-- add the quest marker
							OverheadText.AddQuestMarkerToMobile(mobileId)
						end

					-- this mobile requires a kill marker?
					elseif QuestLog.HasKillMarker(mobName) then
					
						-- does the mobile already has a kill marker?
						if not OverheadText.MobileHasKillMarker(mobileId) then
					
							-- add the kill marker
							OverheadText.AddKillMarkerToMobile(mobileId)
						end

					else -- we add a -1 to the array so we make sure we don't check this mobile again
						OverheadText.QuestMarkers[mobileId] = -1
					end

				-- update the marker for the reward
				elseif OverheadText.QuestMarkers[mobileId] ~= -1 then

					-- does the mobile has a kill marker and shouldn't?
					if OverheadText.MobileHasKillMarker(mobileId) then

						-- is the creature still in the list?
						if not QuestLog.HasKillMarker(mobName) then

							-- remove the kill marker
							OverheadText.RemoveKillMarkerFromMobile(mobileId)
						end
					
					else
						-- quest marker window name
						local markWindow = "QuestMarker_"..mobileId

						-- do the NPC has an active quest?
						local activeQuest, completed, escort = QuestLog.NPCHasActiveQuest(mobileId)
						
						-- is this an escort quest and not completed? we show the shield marker
						if escort then
							WindowSetShowing(markWindow .. "Escort", true)
							WindowSetShowing(markWindow .. "Kill", false)
							WindowSetShowing(markWindow .. "Quest", false)
							WindowSetShowing(markWindow .. "Quest_Grayed", false)
							WindowSetShowing(markWindow .. "Reward", false)
							WindowSetShowing(markWindow .. "Reward_Grayed", false)

						-- if we have an active quest we show the question mark (blue if the quest is completed)
						elseif activeQuest then
							WindowSetShowing(markWindow .. "Kill", false)
							WindowSetShowing(markWindow .. "Quest", false)
							WindowSetShowing(markWindow .. "Quest_Grayed", false)
							WindowSetShowing(markWindow .. "Reward", completed == true)
							WindowSetShowing(markWindow .. "Reward_Grayed", not completed)
							WindowSetShowing(markWindow .. "Escort", false)
						end
					end
				end
			end
		end

		-- reset the timer
		OverheadText.QuestMarkerDelta = 0
	end

	-- update the timer for quest markers
	OverheadText.QuestMarkerDelta = OverheadText.QuestMarkerDelta + timePassed
	
	--timer for overhead msg
	
	if OverheadText.OverheadAlive ~= 0 then
		for id, data in pairs(OverheadText.ChatData) do
			for index, totalTimePassed in pairs(data.timePassed) do
				if totalTimePassed ~= nil then
					data.timePassed[index] = totalTimePassed + timePassed
					if data.timePassed[index] >= OverheadText.OverheadAlive then
						local windowName = "OverheadTextWindow_"..id
						local overheadChatWindow = windowName.."Chat"..index
						
						if not DoesWindowExist(overheadChatWindow) then
							continue
						end

						WindowSetShowing(overheadChatWindow, false)
						LabelSetText( overheadChatWindow, L"")
						
						data.timePassed[index] = nil
						data.numVisibleChat = data.numVisibleChat - 1
						if (data.numVisibleChat < 0) then
							data.numVisibleChat = 0
						end	
					end
				end
			end
		end
	end

	if (SystemData.Settings.GameOptions.showNames ~= SystemData.Settings.GameOptions.SHOWNAMES_ALL) then
		for i, id in pairs(OverheadText.ActiveIdList) do
			local mobileId = i

			-- is the mobile ID valid?
			if not IsValidID(mobileId) then
				continue
			end
			if (OverheadText.FadeTimeId[i] ~= nil) then
				OverheadText.TimePassed[i] = OverheadText.TimePassed[i] + timePassed
				if (OverheadText.TimePassed[i] > OverheadText.FadeStartTime) then
					local windowName = "OverheadTextWindow_"..i
					OverheadText.FadeTimeId[i] = OverheadText.FadeTimeId[i] - OverheadText.AlphaDiff
					if (OverheadText.FadeTimeId[i] <= 0) then
						--Hide Name Window
						OverheadText.HideName(i)
					else
						local labelName = windowName.."Name"
						WindowSetFontAlpha(labelName, OverheadText.FadeTimeId[i])
						
					end
				end
			end
		end
	end
end

function OverheadText.ShowName(mobileId)
	if (not OverheadText.ChatData[mobileId] or OverheadText.ChatData[mobileId].showName == false) then
		return
	end

	if OverheadText.hasHoverbar[mobileId] then
		return
	end
	
	OverheadText.FadeTimeId[mobileId] = OverheadText.AlphaStart
	OverheadText.TimePassed[mobileId] = 0
	
	local windowName = "OverheadTextWindow_"..mobileId
	if not DoesWindowExist(windowName) then
		return
	end

	WindowSetShowing(windowName.."Name", true)
	LabelSetFont(windowName.."Name", FontSelector.Fonts[OverheadText.NameFontIndex].fontName .. "_16", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	WindowSetFontAlpha(windowName.."Name", 1)
	
	OverheadText.UpdateOverheadAnchors(mobileId)
end

function OverheadText.OverheadNameVisible(mobileId)
	local windowName = "OverheadTextWindow_"..mobileId

	if not DoesWindowExist(windowName) then
		return false
	end

	return WindowGetShowing(windowName.."Name")
end

function OverheadText.HideName(mobileId)
	OverheadText.FadeTimeId[mobileId] = nil
	OverheadText.TimePassed[mobileId] = nil
	
	local windowName = "OverheadTextWindow_"..mobileId
	if not DoesWindowExist(windowName) then
		return
	end

	WindowSetShowing(windowName.."Name", false)
	
	OverheadText.UpdateOverheadAnchors(mobileId)
end

function OverheadText.UpdateOverheadAnchors(mobileId)
	
	-- is the mobile ID valid?
	if not IsValidID(mobileId) then
		return
	end

	local windowName = "OverheadTextWindow_"..mobileId
	local overheadNameWindow = windowName.."Name"
	local overheadChat1Window = windowName.."Chat1"
	local overheadChat2Window = windowName.."Chat2"
	local overheadChat3Window = windowName.."Chat3"
	WindowSetHandleInput(overheadNameWindow, Interface.Settings.clickableNames)
	WindowSetScale(windowName, Interface.Settings.OverhedTextSize)
	
	if (DoesWindowExist(windowName) == true) then
		-- NOTE: Player and object names are not displayed, do not anchor chat window to name window.
		if (WindowGetShowing(overheadNameWindow) == true and OverheadText.ChatData[mobileId].showName == true) then
			WindowClearAnchors(overheadChat1Window)
			WindowAddAnchor(overheadChat1Window, "top", overheadNameWindow, "bottom", 0, -10)
			WindowClearAnchors(overheadChat2Window)
			WindowAddAnchor(overheadChat2Window, "top", overheadChat1Window, "bottom", 0, 0)
			WindowClearAnchors(overheadChat3Window)
			WindowAddAnchor(overheadChat3Window, "top", overheadChat2Window, "bottom", 0, 0)
		else
			WindowClearAnchors(overheadChat1Window)
			WindowAddAnchor(overheadChat1Window, "bottom", windowName, "bottom", 0, 0)
			WindowClearAnchors(overheadChat2Window)
			WindowAddAnchor(overheadChat2Window, "top", overheadChat1Window, "bottom", 0, 0)
			WindowClearAnchors(overheadChat3Window)
			WindowAddAnchor(overheadChat3Window, "top", overheadChat2Window, "bottom", 0, 0)
		end
	end
end

function OverheadText.OnShown()
	local this = SystemData.ActiveWindow.name
	local mobileId = WindowGetId(this)
	local labelName = this.."Name"
	
	-- if names are not being displayed, keep name hidden
	if (SystemData.Settings.GameOptions.showNames == SystemData.Settings.GameOptions.SHOWNAMES_NONE) then
		OverheadText.HideName(mobileId)
		return
	end
	
    -- window was shown so reset the timers and the font alpha	
	OverheadText.FadeTimeId[mobileId] = OverheadText.AlphaStart
	OverheadText.TimePassed[mobileId] = 0

	WindowSetFontAlpha( labelName, OverheadText.AlphaStart)
end

function OverheadText.HoverbarOnLClick()
	
	-- hoverbar window name
	local this = SystemData.ActiveWindow.name

	-- is the bar already there?
	if not DoesWindowExist(this) then
		return
	end

	-- get the mobile ID
	local mobileId = WindowGetId(this)

	-- is the mobile ID valid?
	if not IsValidID(mobileId) then
		return
	end

	-- click the mobile
	HandleSingleLeftClkTarget(mobileId)
		
	if SystemData.DragItem.DragType == SystemData.DragItem.TYPE_NONE and IsMobile(mobileId) and mobileId ~= GetPlayerID() then
		
		-- create a pinned bar
		MobileHealthBar.CreateBar(mobileId, true)
	end
end

function OverheadText.NameOnLClick()
	local this = SystemData.ActiveWindow.name
	local parent = WindowGetParent(this)
	local mobileId = WindowGetId(parent)
	
	--Let the targeting manager handle single left click on the target
	if VerifyMobileID(mobileId) then
		--If player has a targeting cursor up and they target the overhead name
		--send a event telling the client they selected a target
		--Let player select there window as there target
		HandleSingleLeftClkTarget(mobileId)
		
		if (SystemData.DragItem.DragType == SystemData.DragItem.TYPE_NONE and IsMobile(mobileId)) then

			-- create a pinned bar
			MobileHealthBar.CreateBar(mobileId, true)
		end
	end
end

function OverheadText.OnLButtonUp()
	if (SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM) then
		local this = SystemData.ActiveWindow.name
		local parent = WindowGetParent(this)
		local mobileId = WindowGetId(parent)
	    DragSlotDropObjectToObject(mobileId)
	end
end

function OverheadText.HoverbarOnDblClick()

	-- hoverbar window name
	local this = SystemData.ActiveWindow.name

	-- is the bar already there?
	if not DoesWindowExist(this) then
		return
	end

	-- get the mobile ID
	local mobileId = WindowGetId(this)

	-- is the mobile ID valid?
	if not IsValidID(mobileId) then
		return
	end
	
	-- dbl click the mobile
	UserActionUseItem(mobileId, false)
end

function OverheadText.NameOnDblClick()
	local this = SystemData.ActiveWindow.name
	local parent = WindowGetParent(this)
	local mobileId = WindowGetId(parent)
	
	UserActionUseItem(mobileId,false)
end

function OverheadText.HoverbarOnMouseOver()

	-- hoverbar window name
	local this = SystemData.ActiveWindow.name
	
	-- is the bar already there?
	if not DoesWindowExist(this) then
		return
	end

	-- get the mobile ID
	local mobileId = WindowGetId(this)
	
	-- is the mobile ID valid?
	if not IsValidID(mobileId) then
		return
	end

	-- highlight the bar
	OverheadText.HighlightHoverbars(this)
	
	-- set the mouse over ID
	OverheadText.mouseOverId = mobileId

	--[[ properties disabled because they are annoying

		-- create the item properties array
		local itemData =
		{
			windowName = this,
			itemId = mobileId,
			itemType = WindowData.ItemProperties.TYPE_ITEM,
		}					

		-- show the item properties
		ItemProperties.SetActiveItem(itemData)

		-- set the hover ID
		
	--]]
end

function OverheadText.HoverbarOnMouseOverEnd()

	-- clear item properties and hover ID
	ItemProperties.ClearMouseOverItem()
	OverheadText.mouseOverId = 0

	-- hoverbar window name
	local this = SystemData.ActiveWindow.name

	-- is the bar already there?
	if not DoesWindowExist(this) then
		return
	end

	-- remove the highlight from the bar
	OverheadText.UnhighlightHoverbars(this)
end

function OverheadText.NameOnMouseOver()
	local this = SystemData.ActiveWindow.name
	local parent = WindowGetParent(this)
	local mobileId = WindowGetId(parent)
	local itemData =
	{
		windowName = this,
		itemId = mobileId,
		itemType = WindowData.ItemProperties.TYPE_ITEM,
	}					
	ItemProperties.SetActiveItem(itemData)
	OverheadText.mouseOverId = mobileId
end

function OverheadText.NameOnMouseOverEnd()
	ItemProperties.ClearMouseOverItem()
	OverheadText.mouseOverId = 0
end

function OverheadText.ShowOverheadText()
	if SystemData.TextSourceID == -1 then
		return
	end
	
	if (not OverheadText.GetsOverhead[SystemData.TextChannelID]) then
		return
	end
	
	local senderText = tostring(SystemData.Text)
	if TextParsing.PoisonMessages[SystemData.TextID] and not Interface.Settings.noPoisonOthers then
		return
	end
	
	-- hide all the taming mastery messages unless they come from the player itself
	if TextParsing.TamingMasteryMessages[SystemData.Text] and SystemData.TextSourceID ~= GetPlayerID() then
		return
	end
	
	local spell = SpellsInfo.SpellsData[tostring(SystemData.Text)]
	local IsSpell = spell ~= nil
	if (IsSpell and Interface.Settings.DisableSpells) then
		SystemData.Text = L""
		return
	end
	
	if (IsSpell and Interface.Settings.ShowSpellName) then
		SystemData.Text = SystemData.Text .. L" [" .. towstring(spell.name) .. L"]"
	end
	
	local windowName = "OverheadTextWindow_"..SystemData.TextSourceID	
	local overheadChatWindow = windowName.."Chat1"
	
	if OverheadText.ChatData[SystemData.TextSourceID] == nil then
	    if (DoesWindowExist(windowName) == false) then
			-- Cases where this would hit are for either the player or non-mobile object
			SystemData.DynamicWindowId = SystemData.TextSourceID
			CreateWindowFromTemplate(windowName, "OverheadTextWindow", "Root")
			AttachWindowToWorldObject( SystemData.TextSourceID, windowName )
			WindowSetScale(windowName, Interface.Settings.OverhedTextSize)
			OverheadText.ChatData[SystemData.TextSourceID].showName = false
			OverheadText.HideName(SystemData.TextSourceID)
		end
	end
	
	-- if there are other chats move them all up one
	if (OverheadText.ChatData[SystemData.TextSourceID].numVisibleChat > 0) then
		for i=OverheadText.ChatData[SystemData.TextSourceID].numVisibleChat+1, 2, -1 do 
			if (i <= 3) then
				local oldWindow = windowName.."Chat"..(i-1)
				local newWindow = windowName.."Chat"..i
				
				local text = LabelGetText(oldWindow)
				if (fontName == FontSelector.Fonts[OverheadText.SpellsFontIndex].fontName) then
					LabelSetFont(newWindow, FontSelector.Fonts[OverheadText.SpellsFontIndex].fontName .. "_16", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
				else
					LabelSetFont(newWindow, FontSelector.Fonts[OverheadText.FontIndex].fontName .. "_16", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
				end
				local r,g,b = LabelGetTextColor(oldWindow)
				if not r or not g or not b then
					r = 255
					g = 255
					b = 255
				end
				LabelSetText(newWindow,text)
				LabelSetTextColor(newWindow,r,g,b)
				WindowSetShowing(newWindow,true)
				WindowSetScale(newWindow, Interface.Settings.OverhedTextSize)
				WindowSetScale(oldWindow, Interface.Settings.OverhedTextSize)
				OverheadText.ChatData[SystemData.TextSourceID].timePassed[i] = OverheadText.ChatData[SystemData.TextSourceID].timePassed[i-1]
			end
		end
	end
	if (OverheadText.ChatData[SystemData.TextSourceID].numVisibleChat < 3) then
		OverheadText.ChatData[SystemData.TextSourceID].numVisibleChat = OverheadText.ChatData[SystemData.TextSourceID].numVisibleChat + 1
	end
		
	OverheadText.ChatData[SystemData.TextSourceID].timePassed[1] = 0
	

	local default = ChatSettings.ChannelColors[SystemData.TextChannelID]
	local color = {r= default.r, g=default.g, b=default.b}

	if (type(SystemData.TextColor) == "table") then
		color.r = SystemData.TextColor.r
		color.g  = SystemData.TextColor.g
		color.b  = SystemData.TextColor.b
	elseif (SystemData.TextColor and SystemData.TextColor ~= 0) then
		color.r,color.g,color.b = HueRGBAValue(SystemData.TextColor)
	end
	
	if (IsSpell) then
		LabelSetFont(overheadChatWindow, FontSelector.Fonts[OverheadText.SpellsFontIndex].fontName .. "_16", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	else
		LabelSetFont(overheadChatWindow, FontSelector.Fonts[OverheadText.FontIndex].fontName .. "_16", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	end
	
	LabelSetTextColor( overheadChatWindow, color.r, color.g, color.b)
	LabelSetText( overheadChatWindow, SystemData.Text)
	
	if (WindowGetShowing(overheadChatWindow) == false) then
		OverheadText.UpdateOverheadAnchors(SystemData.TextSourceID)
		WindowSetShowing(overheadChatWindow, true)
	end
end

function OverheadText.OnOverheadChatShutdown()
    local windowName = SystemData.ActiveWindow.name
    local id = WindowGetId(windowName)
    
    OverheadText.ChatData[id] = nil
	OverheadText.DestroyHoverbarByID(id)
end

function OverheadText.GetHoverbarDiagonalPoints(windowName)

	-- does the bar exist?
	if not DoesWindowExist(windowName) then
		return
	end

	-- get the top-left x and y
	local topX, topY = WindowGetScreenPosition( windowName ) 
    
	-- get the window dimensions
    local width, height = WindowGetDimensions( windowName ) 

	-- calculate the bottom-right x and y
	local bottomX = topX + width
	local bottomY = topY + height

	return topX, topY, bottomX, bottomY
end

function OverheadText.GetOverlappingHoverbars(windowName)

	-- does the bar exist?
	if not DoesWindowExist(windowName) then
		return
	end

	-- get the top-left and bottom-right x and y of the main bar
	local topX, topY, bottomX, bottomY = OverheadText.GetHoverbarDiagonalPoints(windowName)

	-- hoverbars that are overlapping the main bar
	local bars = {}

	-- scan the existing bars
	for mobileId, _ in pairs(OverheadText.hasHoverbar) do
		
		-- bar window
		local hoverBar = "Hoverbar_"..mobileId

		-- is the main bar? we must skip it
		if windowName == hoverBar then
			continue
		end

		-- get the top-left and bottom-right x and y of the bar
		local barTopX, barTopY, barBottomX, barBottomY = OverheadText.GetHoverbarDiagonalPoints(hoverBar)

		-- check if the x of the bar (left or right side) is inside the main bar
		if	(barTopX >= topX and barTopX <= bottomX) or 
			(barBottomX >= topX and barBottomX <= bottomX) 
		then
			
			-- check if the y of the bar (top or bottom) is inside the main bar
			if	(barTopY >= topY and barTopY <= bottomY) or 
				(barBottomY >= topY and barBottomY <= bottomY) 
			then
				
				-- add the hoverbar in the
				table.insert(bars, mobileId)
			end
		end
	end

	return bars
end

OverheadText.HightlightBars = {}
function OverheadText.HighlightHoverbars(windowName)

	-- does the bar exist?
	if not DoesWindowExist(windowName) then
		return
	end

	-- alpha level 100% for highlight
	local alpha = 1

	-- get the mobile ID
	local mobileId = WindowGetId(windowName)

	-- is the mobile ID valid?
	if not IsValidID(mobileId) then
		return
	end

	-- is this the player hoverbar?
	if mobileId ~= GetPlayerID() then

		-- set the alpha to the window and texts
		WindowSetAlpha(windowName, alpha)
		WindowSetFontAlpha(windowName.."Name", alpha)
		WindowSetFontAlpha(windowName.."Perc", alpha)

	else -- player hoverbar
		WindowSetAlpha(windowName, alpha)
		WindowSetFontAlpha(windowName.."Name", alpha)

		WindowSetFontAlpha(windowName.."HealthPerc", alpha)
		WindowSetFontAlpha(windowName.."HealthValue", alpha)

		WindowSetFontAlpha(windowName.."ManaPerc", alpha)
		WindowSetFontAlpha(windowName.."ManaValue", alpha)

		WindowSetFontAlpha(windowName.."StaminaPerc", alpha)
		WindowSetFontAlpha(windowName.."StaminaValue", alpha)
	end

	-- save the bar ID
	OverheadText.HightlightBars[mobileId] = true
end

function OverheadText.UnhighlightHoverbars(windowName)

	-- does the bar exist?
	if not DoesWindowExist(windowName) then
		return
	end

	-- alpha level 50% for all bars
	local alpha = 0.3

	-- get the mobile ID
	local mobileId = WindowGetId(windowName)

	-- is the mobile ID valid?
	if not IsValidID(mobileId) then
		return
	end

	-- let the current terget highlight
	if mobileId == WindowData.CurrentTarget.TargetId then
		return
	end

	-- is this the player hoverbar?
	if mobileId ~= GetPlayerID() then

		-- set the alpha to the window and texts
		WindowSetAlpha(windowName, alpha)
		WindowSetFontAlpha(windowName.."Name", 3)
		WindowSetFontAlpha(windowName.."Perc", alpha )

	else -- player hoverbar
	
		WindowSetAlpha(windowName, alpha)
		WindowSetFontAlpha(windowName.."Name", 2.5)
		
		WindowSetFontAlpha(windowName.."HealthPerc", alpha)
		WindowSetFontAlpha(windowName.."HealthValue", alpha)

		WindowSetFontAlpha(windowName.."ManaPerc", alpha)
		WindowSetFontAlpha(windowName.."ManaValue", alpha)

		WindowSetFontAlpha(windowName.."StaminaPerc", alpha)
		WindowSetFontAlpha(windowName.."StaminaValue", alpha)
	end

	-- remove the highlighted bars
	OverheadText.HightlightBars[mobileId] = nil
end

function OverheadText.AddQuestMarkerToMobile(mobileId)
	
	-- is the mobile visible?
	if not IsMobileVisible(mobileId) then
		return
	end

	-- quest marker window name
	local markWindow = "QuestMarker_"..mobileId

	-- create the quest marker objerct
	CreateWindowFromTemplate(markWindow, "QuestMarker", "Root")

	-- do the NPC has an active quest?
	local activeQuest, completed, escort = QuestLog.NPCHasActiveQuest(mobileId)
			
	-- is this an escort quest and not completed? we show the shield marker
	if escort then
		WindowSetShowing(markWindow .. "Kill", false)
		WindowSetShowing(markWindow .. "Escort", true)
		WindowSetShowing(markWindow .. "Quest", false)
		WindowSetShowing(markWindow .. "Quest_Grayed", false)
		WindowSetShowing(markWindow .. "Reward", false)
		WindowSetShowing(markWindow .. "Reward_Grayed", false)

	-- if we have an active quest we show the question mark (blue if the quest is completed)
	elseif activeQuest then
		WindowSetShowing(markWindow .. "Quest", false)
		WindowSetShowing(markWindow .. "Quest_Grayed", false)
		WindowSetShowing(markWindow .. "Reward", completed == true)
		WindowSetShowing(markWindow .. "Reward_Grayed", not completed)
		WindowSetShowing(markWindow .. "Escort", false)
		WindowSetShowing(markWindow .. "Kill", false)
	
	else -- hide the marker we don't need
		WindowSetShowing(markWindow .. "Reward", false)
		WindowSetShowing(markWindow .. "Reward_Grayed", false)
		WindowSetShowing(markWindow .. "Escort", false)
		WindowSetShowing(markWindow .. "Kill", false)

		-- is the quest log full?
		if QuestLog.QuestCount >= QuestLog.QuestCap then
			WindowSetShowing(markWindow .. "Quest", false)
			WindowSetShowing(markWindow .. "Quest_Grayed", true)
		else
			WindowSetShowing(markWindow .. "Quest", true)
			WindowSetShowing(markWindow .. "Quest_Grayed", false)
		end
	end

	-- put the quest marker over the mobile
	AttachWindowToWorldObject(mobileId, markWindow)

	-- save the quest marker name
	OverheadText.QuestMarkers[mobileId] = markWindow
end

function OverheadText.AddKillMarkerToMobile(mobileId)
	
	-- quest marker window name
	local markWindow = "QuestMarker_"..mobileId

	-- create the quest marker objerct
	CreateWindowFromTemplate(markWindow, "QuestMarker", "Root")
	
	-- hide what we don't need
	WindowSetShowing(markWindow .. "Kill", true)
	WindowSetShowing(markWindow .. "Escort", false)
	WindowSetShowing(markWindow .. "Quest", false)
	WindowSetShowing(markWindow .. "Quest_Grayed", false)
	WindowSetShowing(markWindow .. "Reward", false)
	WindowSetShowing(markWindow .. "Reward_Grayed", false)

	-- put the quest marker over the mobile
	AttachWindowToWorldObject(mobileId, markWindow)

	-- save the quest marker name
	OverheadText.KillMarkers[mobileId] = markWindow
end

function OverheadText.RemoveQuestMarkerFromMobile(mobileId)
	
	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return
	end

	-- quest marker window name
	local markWindow = "QuestMarker_"..mobileId

	-- does the marker exist?
	if DoesWindowNameExist(markWindow) then

		-- detach the marker from the mobile
  		DetachWindowFromWorldObject(mobileId, markWindow)

		-- destroy the marker window
  		DestroyWindow(markWindow)
  	end

	-- remove the marker from the array
	OverheadText.QuestMarkers[mobileId] = nil
end

function OverheadText.RemoveKillMarkerFromMobile(mobileId)
	
	-- quest marker window name
	local markWindow = "QuestMarker_"..mobileId

	-- does the marker exist?
	if DoesWindowNameExist(markWindow) then

		-- detach the marker from the mobile
  		DetachWindowFromWorldObject(mobileId, markWindow)

		-- destroy the marker window
  		DestroyWindow(markWindow)
  	end

	-- remove the marker from the array
	OverheadText.KillMarkers[mobileId] = nil
end

function OverheadText.MobileHasQuestMarker(mobileId)

	-- check if the marker exist
	return OverheadText.QuestMarkers[mobileId] ~= nil
end

function OverheadText.MobileHasKillMarker(mobileId)

	-- check if the marker exist
	return OverheadText.KillMarkers[mobileId] ~= nil
end