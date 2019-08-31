
----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

BossBar = {}
BossBar.MouseOverId = 0
BossBar.InitializeTime = 0

function BossBar.Initialize()
	
	-- reset all the data
	BossBar.ResetBossBar()
end

function BossBar.ResetBossBar()

	-- boss bar window name
	local windowName = "BossBarWindow"

	-- initialize the healthbar
	StatusBarSetMaximumValue(windowName .. "Fill", 100)
	StatusBarSetCurrentValue(windowName .. "Fill", 100)

	-- initialize the labels
	LabelSetText(windowName .. "HealthPerc", L"100%")
	LabelSetText(windowName .. "NameLabel", L"")

	-- hide the name block
	BossBar.HideName()

	-- hide the window
	WindowSetShowing("BossBarWindow", false)

	-- reset initialize time
	BossBar.InitializeTime = 0
end

function BossBar.HideName()

	-- hide the name label
	WindowSetShowing("BossBarWindowNameLabel", false)

	-- hide the name background
	WindowSetShowing("BossBarWindowName", false)
end

function BossBar.ShowName()

	-- show the name label
	WindowSetShowing("BossBarWindowNameLabel", true)

	-- show the name background
	WindowSetShowing("BossBarWindowName", true)
end

function BossBar.OnMouseOver()
	
	-- show the boss name
	BossBar.ShowName()

	-- boss bar window name
	local windowName = "BossBarWindow"

	-- get the current boss ID
	BossBar.MouseOverId = WindowGetId(windowName)
end

function BossBar.OnMouseOverEnd()

	-- hide the boss name
	BossBar.HideName()

	-- remove the mouse over id
	BossBar.MouseOverId = 0
end

function BossBar.OnClick()

	-- boss bar window name
	local windowName = "BossBarWindow"

	-- get the mobile ID
	local mobileId = WindowGetId(windowName)
	
	-- Do we have a valid ID?
	if not IsValidID(mobileId) then
		return
	end

	-- target the boos
	HandleSingleLeftClkTarget(mobileId)
		
	-- if we're not dragging anything, we allow the player to create a normal healthbar for the boss
	if SystemData.DragItem.DragType == SystemData.DragItem.TYPE_NONE then

		-- create a pinned bar if the drag is successful
		WindowUtils.BeginDrag(callback, objectId)
	end
end

function BossBar.OnDBLClick()

	-- does the player has a cursor target?
	if DoesPlayerHasCursorTarget() then

		-- execute single click instead
		BossBar.OnClick()

		return
	end

	-- boss bar window name
	local windowName = "BossBarWindow"

	-- get the mobile ID
	local mobileId = WindowGetId(windowName)
	
	-- Do we have a valid ID?
	if not IsValidID(mobileId) then
		return
	end

	UserActionUseItem(mobileId, false)
end

function BossBar.AttachBossBar(mobileId)
	
	-- Do we have a valid ID?
	if not IsValidID(mobileId) and not IsMobileInvulnerable(mobileId) or mobileId == GetPlayerID() then
		return
	end
	
	-- boss bar window name
	local windowName = "BossBarWindow"

	-- attach the ID to the window
	WindowSetId("BossBarWindow", mobileId)

	-- register the boss bar
	BossBar.RegisterBossBar(mobileId)

	-- update the boss portrait based on the name
	BossBar.UpdatePortrait()

	-- update name
	BossBar.UpdateName(mobileId)

	-- update status
	BossBar.UpdateStatus(mobileId)

	-- update bar color
	BossBar.HandleHealthBarColorUpdate(mobileId)

	-- showing the bar
	WindowSetShowing(windowName, true)

	-- save the time has been initialized
	BossBar.InitializeTime = Interface.TimeSinceLogin + 1

	-- make sure there is no hoverbar for the boss
	OverheadText.DestroyHoverbarByID(mobileId)
end

function BossBar.RegisterBossBar(mobileId)
	
	-- Do we have a valid ID?
	if not IsValidID(mobileId) then
		return
	end

	-- does the status needs to be registered and the mobile is NOT invulnerable?
	if not IsMobileInvulnerable(mobileId) and not Interface.VerifyMobileData(mobileId, WindowData.MobileStatus[mobileId]) then
		Interface.GetMobileData(mobileId)
	end

	-- does the name needs to be registered 
	if not Interface.VerifyMobileName(mobileId, WindowData.MobileName[mobileId]) then
		Interface.GetMobileNameData(mobileId)
	end
end

function BossBar.UpdatePortrait()

	-- boss bar window name
	local windowName = "BossBarWindow"

	-- get the mobile ID
	local mobileId = WindowGetId(windowName)

	-- draw the correct portrait (it takes a short time to get the correct data)
	Interface.AddTodoList({name = "target window draw portrait", func = function() SetPortraitImage(mobileId, windowName .. "Portrait") end, time = Interface.TimeSinceLogin + 0.2})
end

function BossBar.GetActiveBoss()
	
	-- boss bar window name
	local windowName = "BossBarWindow"

	return WindowGetId(windowName)
end

function BossBar.UpdateStatus(mobileId)
	
	-- boss bar window name
	local windowName = "BossBarWindow"

	-- is the mobile ID valid?
	if not IsValidID(mobileId) or mobileId ~= BossBar.GetActiveBoss() then
		return
	end

	-- is the mobile status available?
	if not Interface.VerifyMobileData(mobileId, WindowData.MobileStatus[mobileId]) then

		-- register the boss bar
		BossBar.RegisterBossBar(mobileId)
	end
	
	-- current mobile data record
	local mobileStatus = Interface.ActiveMobilesOnScreen[mobileId]

	-- do we have the mobile data?
	if not mobileStatus or not mobileStatus.maxHealth or mobileStatus.maxHealth == 0 then

		-- update the mobiles on screen data
		Interface.UpdateMobileOnScreenStatus(mobileId)

		-- try again in a short time
		Interface.ExecuteWhenAvailable(
		{
			name = "bossStatusUpdate" .. mobileId,
			check = function() return Interface.ActiveMobilesOnScreen[mobileId] ~= nil end, 
			callback = function() BossBar.UpdateStatus(mobileId) end, 
			removeOnComplete = true,
		})

		return
	end

	-- update the bar
	StatusBarSetMaximumValue(windowName .. "Fill", mobileStatus.maxHealth)
	StatusBarSetCurrentValue(windowName .. "Fill", mobileStatus.curHealth)	

	-- Update percentage
	LabelSetText(windowName .. "HealthPerc", mobileStatus.perc .. L"%")

	-- update the portrait
	BossBar.UpdatePortrait()
end

function BossBar.UpdateName(mobileId)
	
	-- is the mobile ID valid?
	if not IsValidID(mobileId) or mobileId ~= BossBar.GetActiveBoss() then
		return
	end

	-- is the mobile status available?
	if not Interface.VerifyMobileName(mobileId, WindowData.MobileStatus[mobileId]) then

		-- register the boss bar
		BossBar.RegisterBossBar(mobileId)
	end

	-- get the mobile data for the specified ID
	local mobileData = Interface.ActiveMobilesOnScreen[mobileId]
	
	-- no mobile data (this should not happen since we have all the data for the mobiles on screen)
	if not mobileData or not mobileData.name then

		-- try again in a short time
		Interface.ExecuteWhenAvailable(
		{
			name = "bossNameUpdate" .. mobileId,
			check = function() return Interface.ActiveMobilesOnScreen[mobileId] ~= nil end, 
			callback = function() BossBar.UpdateName(mobileId) end, 
			removeOnComplete = true
		})

		return
	end

	-- boss bar window name
	local windowName = "BossBarWindow"

	-- write the name on the label
	LabelSetText(windowName .. "NameLabel", mobileData.name)

	-- update name color
	BossBar.UpdateNameColor(mobileId)
end

function BossBar.UpdateNameColor(mobileId)
	
	-- is the mobile ID valid?
	if not IsValidID(mobileId) or mobileId ~= BossBar.GetActiveBoss() then
		return
	end

	-- get the mobile data for the specified ID
	local mobileData = Interface.ActiveMobilesOnScreen[mobileId]
	
	-- no mobile data (this should not happen since we have all the data for the mobiles on screen)
	if not mobileData then
		return
	end

	-- boss bar window name
	local windowName = "BossBarWindow"

	-- coloring the name
	NameColor.UpdateLabelNameColor(windowName .. "NameLabel", mobileData.notoriety)
end

function BossBar.HandleHealthBarColorUpdate(mobileId)

	-- is the mobile ID valid?
	if not IsValidID(mobileId) or mobileId ~= BossBar.GetActiveBoss() then
		return
	end

	-- boss bar window name
	local windowName = "BossBarWindow"

	-- do we have the healthbar colors yet?
	if WindowData.HealthBarColor[mobileId] then

		-- update bar color
		HealthBarColor.UpdateHealthBarColor(windowName .. "Fill", WindowData.HealthBarColor[mobileId].VisualStateId)

	else -- update as soon as we have them
		Interface.ExecuteWhenAvailable(
		{
			name = "UpdateBossColors" .. mobileId,
			check = function() return WindowData.HealthBarColor[mobileId] ~= nil end, 
			callback = function() HealthBarColor.UpdateHealthBarColor(windowName .. "Fill", WindowData.HealthBarColor[mobileId].VisualStateId) end, 
			removeOnComplete = true
		})

		-- update the healthbar color with a default color
		HealthBarColor.UpdateHealthBarColor(windowName .. "Fill", 0)
	end
end

function BossBar.HandleHealthBarStateUpdate(mobileId)

	-- is the mobile ID valid?
	if not IsValidID(mobileId) or mobileId ~= BossBar.GetActiveBoss() then
		return
	end

	-- boss bar window name
	local windowName = "BossBarWindow"
	
	-- is the right update ID?
	if mobileId == WindowGetId(windowName) then

		-- get the enabled status
		local enabled = IsHealthBarEnabled(mobileId)

		-- toggle the healthbar based on the status
		WindowSetShowing(windowName, enabled)
	end
end