----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

TargetWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

TargetWindow.TargetId = 0
TargetWindow.TargetType = 0
TargetWindow.MobileType = 2
TargetWindow.ObjectType = 3
TargetWindow.CorpseType = 4

TargetWindow.Buttons = {}

TargetWindow.Delta = 0
TargetWindow.DeltaC = 0
TargetWindow.DeltaHealth = 0

TargetWindow.CurrentCreature = nil

TargetWindow.PreviousTargets = {}

TargetWindow.Locked = true

TargetWindow.KnownPlayers = {} 
TargetWindow.KnownTamable = {}

TargetWindow.ContextData = nil

TargetWindow.Invulnerable_Text = L">>" .. wstring.upper(GetStringFromTid(3000509)) .. L"<<"

TargetWindow.GetContextTries = {}
TargetWindow.LastContextId = 0

TargetWindow.RefreshHealth = false

TargetWindow.TrainSkillIcon = 
{
	[3006000] = 02001; -- Train Alchemy
	[3006001] = 02002; -- Train Anatomy
	[3006002] = 02003; -- Train Animal Lore
	[3006035] = 02004; -- Train Animal Taming
	[3006031] = 02005; -- Train Archery
	[3006004] = 02006; -- Train Arms Lore
	[3006006] = 02007; -- Train Begging
	[3006007] = 02008; -- Train Blacksmithing
	[3006052] = 02009; -- Train Bushido
	[3006010] = 02010; -- Train Camping
	[3006011] = 02011; -- Train Carpentry
	[3006012] = 02012; -- Train Cartography
	[3006051] = 02013; -- Train Chivalry
	[3006013] = 02014; -- Train Cooking
	[3006014] = 02015; -- Train Detect Hidden
	[3006015] = 02016; -- Train Discordance
	[3006016] = 02017; -- Train Evaluating Intelligence
	[3006042] = 02018; -- Train Fencing
	[3006018] = 02019; -- Train Fishing
	[3006008] = 02020; -- Train Bowcraft/Fletching
	[3006050] = 02021; -- Train Focus
	[3006019] = 02022; -- Train Forensic Evaluation
	[3006017] = 02023; -- Train Healing
	[3006020] = 02024; -- Train Herding
	[3006021] = 02025; -- Train Hiding
	[3006023] = 02026; -- Train Inscription
	[3006003] = 02027; -- Train Item Identification
	[3006024] = 02028; -- Train Lockpicking
	[3006044] = 02029; -- Train Lumberjacking
	[3006041] = 02030; -- Train Mace Fighting
	[3006025] = 02031; -- Train Magery
	[3006026] = 02032; -- Train Resisting Spells
	[3006046] = 02033; -- Train Meditation
	[3006045] = 02034; -- Train Mining
	[3006029] = 02035; -- Train Musicianship
	[3006049] = 02036; -- Train Necromancy
	[3006053] = 02037; -- Train Ninjitsu
	[3006005] = 02038; -- Train Parrying
	[3006009] = 02039; -- Train Peacemaking
	[3006030] = 02040; -- Train Poisoning
	[3006022] = 02041; -- Train Provocation
	[3006048] = 02042; -- Train Remove Trap
	[3006028] = 02043; -- Train Snooping
	[3006032] = 02045; -- Train Spirit Speak
	[3006033] = 02046; -- Train Stealing
	[3006047] = 02047; -- Train Stealth
	[3006040] = 02048; -- Train Swordsmanship
	[3006027] = 02049; -- Train Tactics
	[3006034] = 02050; -- Train Tailoring
	[3006036] = 02051; -- Train Taste Identification
	[3006037] = 02052; -- Train Tinkering
	[3006038] = 02053; -- Train Tracking
	[3006039] = 02054; -- Train Veterinary
	[3006043] = 02055; -- Train Wrestling
	[3006055] = 02056; -- Train Mysticism
	[3006056] = 02057; -- Train Imbuing
	[3006057] = 02058; -- Train Throwing
}

TargetWindow.OtherContextIcons = 
{
	[ContextMenu.DefaultValues.EnablePVPWarning] = 875500; -- PVP Warning
	[ContextMenu.DefaultValues.ReleaseCoOwnership] = 875501; -- Release Co-Ownership
	[ContextMenu.DefaultValues.LeaveHouse] = 875502; -- Leave House
	[ContextMenu.DefaultValues.QuestConversation] = 875503; -- Quest Conversation
	[ContextMenu.DefaultValues.ViewQuestLog] = 875504; -- Quest Log
	[ContextMenu.DefaultValues.CancelQuest] = 875505; -- Cancel Quest
	[ContextMenu.DefaultValues.QuestItem] = 875506; -- Quest Item
	[ContextMenu.DefaultValues.InsuranceMenu] = 875507; -- Insurance Menu
	[ContextMenu.DefaultValues.ToggleItemInsurance] = 875508; -- Toggle Insurance
	[ContextMenu.DefaultValues.TitlesMenu] = 875509; -- Title Menu
	[ContextMenu.DefaultValues.CancelProtection] = 875511; -- Cancel Protection
	[ContextMenu.DefaultValues.VoidPool] = 875512; -- Void Pool
	[ContextMenu.DefaultValues.AllowTrades] = 875513; -- toggle trades
	[ContextMenu.DefaultValues.RefuseTrades] = 875513; -- toggle trades
	[ContextMenu.DefaultValues.SiegeBless] = 875514; -- siege bless
	[ContextMenu.DefaultValues.Retrieve] = 875608; -- retrieve
	[ContextMenu.DefaultValues.SetSecurity] = 875126; -- set security
	[ContextMenu.DefaultValues.ShipSecurity] = 875126; -- ship security
	[ContextMenu.DefaultValues.PermanentRepairs] = 200218; -- permanent repair
	[ContextMenu.DefaultValues.RenameShip] = 875122; -- rename ship
	[ContextMenu.DefaultValues.RenamePet] = 875122; -- rename pet
	[ContextMenu.DefaultValues.OpenBackpackPet] = 875101; -- pet backpack
}

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function TargetWindow.Initialize()

	-- target window name
	local this = "TargetWindow"

	-- healthbar window name
	local healthbar = this .. "HealthBar"

	-- initializing bar
    StatusBarSetCurrentValue(healthbar, 0)
	StatusBarSetMaximumValue(healthbar, 100)

	-- setting the lock status and button graphics
	TargetWindow.Locked = Interface.LoadSetting("TargetWindowLocked", TargetWindow.Locked)
	
	-- update the lock button texture
	TargetWindow.UpdateLockButtonTexture()
	
	-- restore the saved window position
	WindowUtils.RestoreWindowPosition("TargetWindow")

	-- load the scale for the target
	WindowUtils.LoadScale("TargetWindow")
end

function TargetWindow.Shutdown()

	-- save the current window position
	WindowUtils.SaveWindowPosition("TargetWindow")
	
	-- remove the current target
	ClearCurrentTarget()
end

function TargetWindow.ClearPreviousTarget()

	-- target window name
	local this = "TargetWindow"

	-- reset the current target buttons
	TargetWindow.DestroyButtons()
	
	-- do we have a current target set?
	if IsValidID(TargetWindow.TargetId) then

		-- hide the target window
		WindowSetShowing(this, false)

		-- unregister the target data
		TargetWindow.UnregisterPreviousTargetData()

		-- is the target a mobile?
		if TargetWindow.TargetType == TargetWindow.MobileType then

			-- get the ID of the previous target stored
			local max = #TargetWindow.PreviousTargets

			-- is the previous stored target different current target?
			if TargetWindow.PreviousTargets[max] ~= TargetWindow.TargetId then

				-- store the target for the next/previous action
				table.insert(TargetWindow.PreviousTargets, TargetWindow.TargetId) 
			end
		end

		-- reset the name
		LabelSetText(this .. "Name", L"")

		-- reset the hits percent
		LabelSetText(this .. "Hits", L"")

		-- reset the healthbar
		StatusBarSetCurrentValue(this .. "HealthBar", 0)

		-- remove the texture from the portrait
		CircleImageSetTexture(this .. "Portrait", "", 0, 0)

		-- remove the texture for the object 
		DynamicImageSetTexture(this .. "Object", "", 0, 0 )

		-- does the wreath exist?
		if DestroyWindow(this .."PortraitWreath") then

			-- destroy the wreath
			DestroyWindow(this .."PortraitWreath")
		end

		-- unhighlight the hoverbar for this target
		OverheadText.UnhighlightHoverbars("Hoverbar_" .. TargetWindow.TargetId)

		-- unhighlight the current target bar
		MobileHealthBar.Unhighlight(TargetWindow.TargetId)

		-- reset the target type
		TargetWindow.TargetType = 0

		-- reset the target ID
		TargetWindow.TargetId = 0

		-- remove the refresh health flag
		TargetWindow.RefreshHealth = false
	end
end	

function TargetWindow.RegisterCurrentTargetData()

	-- do we have a valid current target?
	if not IsValidID(TargetWindow.TargetId) then
		return
	end

	-- does the status needs to be registered and the mobile is NOT invulnerable?
	if not IsMobileInvulnerable(TargetWindow.TargetId) and not Interface.VerifyMobileData(TargetWindow.TargetId, WindowData.MobileStatus[TargetWindow.TargetId]) then
		Interface.GetMobileData(TargetWindow.TargetId)
	end

	-- does the name needs to be registered 
	if not Interface.VerifyMobileName(TargetWindow.TargetId, WindowData.MobileName[TargetWindow.TargetId]) then
		Interface.GetMobileNameData(TargetWindow.TargetId)
	end
end

function TargetWindow.UnregisterPreviousTargetData()
	
	-- do we have a valid target?
	if IsValidID(TargetWindow.TargetId) then

		-- is the target a mobile?
		if (TargetWindow.TargetType == TargetWindow.MobileType) then

			-- clearing the windowdata if possible
			UnregisterWindowData(WindowData.MobileName.Type, TargetWindow.TargetId)
			UnregisterWindowData(WindowData.MobileStatus.Type, TargetWindow.TargetId)
			UnregisterWindowData(WindowData.HealthBarColor.Type, TargetWindow.TargetId)

		-- is the target a corpse or an item?
		elseif (TargetWindow.TargetType == TargetWindow.ObjectType or
			   TargetWindow.TargetType == TargetWindow.CorpseType) then

			-- clearing the windowdata if possible
			UnregisterWindowData(WindowData.ObjectInfo.Type,TargetWindow.TargetId)	
		end
	end
end

function TargetWindow.UpdateTarget()
	
	-- reset the target context data (used to call the context menu)
	TargetWindow.ContextData = nil

	-- do we have an invalid active target or a new target?
	if not IsValidID(TargetWindow.TargetId) or TargetWindow.TargetId ~= WindowData.CurrentTarget.TargetId then

		-- reset the context entries count for the target
		TargetWindow.GetContextTries[TargetWindow.TargetId] = nil
	end

	-- clear the previous target
	TargetWindow.ClearPreviousTarget()
	
	-- is the target a mobile?
	if WindowData.CurrentTarget.TargetType == TargetWindow.MobileType then

		-- update the mobile target
		TargetWindow.UpdateMobile()
	
	-- is the target an object?
	elseif WindowData.CurrentTarget.TargetType == TargetWindow.ObjectType then

		-- update the object target
		TargetWindow.UpdateObject()

	-- is the target a corpse?
	elseif WindowData.CurrentTarget.TargetType == TargetWindow.CorpseType then
		
		-- update the corpse target
		TargetWindow.UpdateCorpse()
	end
end

function TargetWindow.UpdateMobile()
	
	-- target window name
	local this = "TargetWindow"

	-- do we have an invalid active target or a new target?
	if not IsValidID(TargetWindow.TargetId) or TargetWindow.TargetId ~= WindowData.CurrentTarget.TargetId then

		-- update the target type
		TargetWindow.TargetType = TargetWindow.MobileType

		-- updating the window target id
		TargetWindow.TargetId = WindowData.CurrentTarget.TargetId

		-- show the target window
		WindowSetShowing(this, true)

		-- fade-in animation while the data are loading
		WindowStartAlphaAnimation(this, Window.AnimationType.SINGLE, 0.1, 1, 1, true, 0, 1)
		Interface.AddTodoList({name = "stop target fade-in", func = function() WindowStopAlphaAnimation(this) end, time = Interface.TimeSinceLogin + 1})

		-- remove the texture for the object 
		DynamicImageSetTexture(this .. "Object", "", 0, 0 )
		
		-- register the target data
		TargetWindow.RegisterCurrentTargetData()

		-- initialize the target name and status after a short delay so we are sure we have all the data
		Interface.ExecuteWhenAvailable(
		{
			name = "InitializeTarget" .. TargetWindow.TargetId,
			check = function() return MobileHealthBar.CheckAllDataIsAvailable(TargetWindow.TargetId) end, 
			callback = function() TargetWindow.UpdateName(TargetWindow.TargetId)  TargetWindow.UpdateStatus(TargetWindow.TargetId) TargetWindow.TintHealthBar(TargetWindow.TargetId) end, 
			removeOnComplete = true,
			delay = Interface.TimeSinceLogin + 0.5
		})
	
		-- wreath window name
		local wreath = this .."PortraitWreath"

		-- get the contributor data
		local contributor = CreditsWindow.GetContributorData(TargetWindow.TargetId)

		-- is this a contributor?
		if contributor then

			-- does the wreath already exist?
			if not DoesWindowExist(wreath) then

				-- create wreath image
				CreateWindowFromTemplate(wreath, "WreathTemplate", this)

				-- anchor the wreath to the portrait
				WindowAddAnchor(wreath, "center", this .."Portrait", "center", 2, 10)

				-- get the color for the contributor perk
				local perkColor = CreditsWindow.ContributionPerks[contributor.perk]

				-- color the wreath
				WindowSetTintColor(wreath, perkColor.r, perkColor.g, perkColor.b)

				-- set the contributor title
				LabelSetText(wreath .. "Text", CreditsWindow.ContributionPerksName[contributor.perk])
			end

		-- does the wreath exist and is not a contributor?
		elseif DoesWindowExist(wreath) then

			-- destroy the wreath
			DestroyWindow(wreath)
		end

		-- getting the compatible creatures list with the current mobile
		local creatureData = CreaturesDB.FindCompatibleCreatures(TargetWindow.TargetId, true)
		
		-- we pick the first in the list (if there are more we can't determine an exact match...)
		TargetWindow.CurrentCreature = creatureData[1]

		-- draw the correct portrait (it takes a short time to get the correct data)
		Interface.AddTodoList({name = "target window draw portrait", func = function() SetPortraitImage(TargetWindow.TargetId, this .."Portrait") end, time = Interface.TimeSinceLogin + 0.5})
		
		-- highlight the hoverbar
		OverheadText.HighlightHoverbars("Hoverbar_" .. TargetWindow.TargetId)

		-- highlight the current target bar
		MobileHealthBar.Highlight(WindowData.CurrentTarget.TargetId)

		-- update the target buttons
		TargetWindow.UpdateButtons()
	end
	
	-- get the ID of the previous target stored
	local max = #TargetWindow.PreviousTargets

	-- is the previous stored target different current target?
	if TargetWindow.PreviousTargets[max] ~= TargetWindow.TargetId then

		-- store the target for the next/previous action
		table.insert(TargetWindow.PreviousTargets, TargetWindow.TargetId) 
	end
end

function TargetWindow.UpdateObject()

	-- target window name
	local this = "TargetWindow"

	-- name label
	local targetName = this .. "Name"

	-- object image window
	local objectImage = this .. "Object"

	-- reset the current target buttons
	TargetWindow.DestroyButtons()

	-- remove the hp percentage text
	LabelSetText(this .."Hits", L"")
	
	-- do we have an invalid active target or a new target?
	if not IsValidID(TargetWindow.TargetId) or TargetWindow.TargetId ~= WindowData.CurrentTarget.TargetId then

		-- update the target type
		TargetWindow.TargetType = TargetWindow.MobileType

		-- updating the window target id
		TargetWindow.TargetId = WindowData.CurrentTarget.TargetId

		-- show the target window
		WindowSetShowing(this, true)

		-- fade-in animation while the data are loading
		WindowStartAlphaAnimation(this, Window.AnimationType.SINGLE, 0.1, 1, 1, true, 0, 1)
		Interface.AddTodoList({name = "stop target fade-in", func = function() WindowStopAlphaAnimation(this) WindowSetAlpha(this, 1) end, time = Interface.TimeSinceLogin + 1})
				
		-- set the healthbar to 0
		StatusBarSetCurrentValue(this .. "HealthBar", 0)

		-- remove the texture from the portrait
		CircleImageSetTexture(this .. "Portrait", "", 0, 0)

		-- set the item name
		LabelSetText(targetName, GetItemName(TargetWindow.TargetId))

		-- set the text gray
		NameColor.UpdateLabelNameColor(targetName, NameColor.Notoriety.NONE)
		
		-- reset the item texture scale
		DynamicImageSetTextureScale(objectImage, 1)

		-- reset the item window to default size
		WindowSetDimensions(objectImage, 50, 50)	

		-- draw the correct icon (it takes a short time to get the correct data)
		Interface.AddTodoList({name = "target window draw object", func = function() EquipmentData.DrawObjectIconAtWindowDimensions(GetItemType(TargetWindow.TargetId), GetItemHue(TargetWindow.TargetId), objectImage, 50, 50, 1) end, time = Interface.TimeSinceLogin + 1})

		-- acquire the item properties for the item
		local dt = Interface.GetItemPropertiesData(TargetWindow.TargetId, "Get item intensity info for listview")	

		-- do we have the properties?
		if dt then
				
			-- filling the TID props array
			props = ItemProperties.BuildParamsArray(dt, true)
		end

		-- do we have the item properties?
		if props then

			-- scan all the health props
			for tid, _ in pairs(ItemPropertiesInfo.MastHealthTid) do

				-- do we have the health prop?
				if props[tid] then
					
					-- flag that we need to update the health
					TargetWindow.RefreshHealth = true
					break
				end
			end
		end
	end
end

--Corpse will show the portrait of the mobile, but use the item properites for the name
function TargetWindow.UpdateCorpse()
	
	-- target window name
	local this = "TargetWindow"

	-- name label
	local targetName = this .. "Name"

	-- reset the current target buttons
	TargetWindow.DestroyButtons()

	-- remove the hp percentage text
	LabelSetText(this .."Hits", L"")

	-- do we have an invalid active target or a new target?
	if not IsValidID(TargetWindow.TargetId) or TargetWindow.TargetId ~= WindowData.CurrentTarget.TargetId then

		-- update the target type
		TargetWindow.TargetType = TargetWindow.MobileType

		-- updating the window target id
		TargetWindow.TargetId = WindowData.CurrentTarget.TargetId

		-- show the target window
		WindowSetShowing(this, true)

		-- fade-in animation while the data are loading
		WindowStartAlphaAnimation(this, Window.AnimationType.SINGLE, 0.1, 1, 1, true, 0, 1)
		Interface.AddTodoList({name = "stop target fade-in", func = function() WindowStopAlphaAnimation(this) end, time = Interface.TimeSinceLogin + 1})
				
		-- set the healthbar to 0
		StatusBarSetCurrentValue(this .. "HealthBar", 0)

		-- remove the texture for the object 
		DynamicImageSetTexture(this .. "Object", "", 0, 0 )

		-- set the item name
		LabelSetText(targetName, GetItemName(TargetWindow.TargetId))

		-- remove the texture from the portrait
		CircleImageSetTexture(this .. "Portrait", "", 0, 0)

		-- set the text gray
		NameColor.UpdateLabelNameColor(targetName, NameColor.Notoriety.NONE)
		
		-- draw the correct portrait (it takes a short time to get the correct data)
		Interface.AddTodoList({name = "target window draw portrait", func = function() SetPortraitImage(TargetWindow.TargetId, this .."Portrait") end, time = Interface.TimeSinceLogin + 0.5})
	end
end

function TargetWindow.UpdateStatus(mobileId)	

	-- is this mobile the current target?
	if not TargetWindow.HasValidTarget() or mobileId ~= TargetWindow.TargetId then
		return
	end

	-- target window name
	local this = "TargetWindow"

	-- healthbar window name
	local healthbar = this .. "HealthBar"

	-- hp % label
	local hpPerc = this .. "Hits"

	-- current mobile data record
	local mobileStatus = Interface.ActiveMobilesOnScreen[mobileId]

	-- do we have the mobile data?
	if not mobileStatus or not mobileStatus.maxHealth or mobileStatus.maxHealth == 0 then
		
		-- update the mobiles on screen data
		Interface.UpdateMobileOnScreenStatus(mobileId)

		-- try again in a short time
		Interface.ExecuteWhenAvailable(
		{
			name = "targetStatusUpdate" .. mobileId,
			check = function() return Interface.ActiveMobilesOnScreen[mobileId] ~= nil end, 
			callback = function() TargetWindow.UpdateStatus(mobileId) end, 
			removeOnComplete = true,
		})

		return
	end

	-- invulnerables can skip all 
	if mobileStatus.invulnerable then

		-- set the healthbar to 0
		StatusBarSetCurrentValue(this .. "HealthBar", 0)

		-- update the hits percent to "Invulnerable"
		LabelSetText(hpPerc, TargetWindow.Invulnerable_Text)

		-- set the text yellow
		NameColor.UpdateLabelNameColor(targetName, NameColor.Notoriety.INVULNERABLE)

		return
	end

	-- is the mobile status available?
	if not Interface.VerifyMobileData(mobileId, WindowData.MobileStatus[mobileId]) then

		-- register the target data
		TargetWindow.RegisterCurrentTargetData()
	end
		
	-- update the bar status
	StatusBarSetMaximumValue(healthbar, mobileStatus.maxHealth)
	StatusBarSetCurrentValue(healthbar, mobileStatus.curHealth )	

	-- build the percent string
	local percString = GetStringFromTid(1053042) .. L": " .. mobileStatus.perc or 100

	-- update the percentage text
	LabelSetText(hpPerc, percString .. L"%")

	-- scale the text color to become red when is near 0
	WindowUtils.ScaleTextRedByPerc(hpPerc, mobileStatus.perc)
end

function TargetWindow.UpdateName(mobileId)	

	-- is this mobile the current target?
	if not TargetWindow.HasValidTarget() or mobileId ~= TargetWindow.TargetId then
		return
	end

	-- target window name
	local this = "TargetWindow"

	-- is the mobile status available?
	if not Interface.VerifyMobileName(mobileId, WindowData.MobileStatus[mobileId]) then

		-- register the target data
		TargetWindow.RegisterCurrentTargetData()
	end

	-- get the mobile data for the specified ID
	local mobileData = Interface.ActiveMobilesOnScreen[mobileId]
	
	-- no mobile data (this should not happen since we have all the data for the mobiles on screen)
	if not mobileData then

		-- try again in a short time
		Interface.ExecuteWhenAvailable(
		{
			name = "targetNameUpdate" .. mobileId,
			check = function() return Interface.ActiveMobilesOnScreen[mobileId] ~= nil end, 
			callback = function()  TargetWindow.UpdateName(mobileId) end, 
			removeOnComplete = true
		})

		return
	end

	-- get the mobile name (without titles)
	local name = mobileData.cleanName

	-- do we have a valid title?
	if IsValidWString(mobileData.title) then

		-- append the title to the second line of the name
		name = wstring.appendWithSeparator(name, mobileData.title, L"\n")
	end

	-- write the name (and title) to the label
	LabelSetText(this .. "Name", FormatProperly(name))

	-- update the name text color
	NameColor.UpdateLabelNameColor("TargetWindowName", mobileData.notoriety)
end

function TargetWindow.TintHealthBar(mobileId)

	-- is this mobile the current target?
	if not TargetWindow.HasValidTarget() or mobileId ~= TargetWindow.TargetId then
		return
	end

	-- target window name
	local this = "TargetWindow"

	-- healthbar window name
	local healthbar = this .. "HealthBar"

	-- do we have the healthbar colors yet?
	if WindowData.HealthBarColor[mobileId] then
		
		-- update the healthbar color
		HealthBarColor.UpdateHealthBarColor(healthbar, mobileId == GetPlayerID() and WindowData.PlayerStatus.VisualStateId or WindowData.HealthBarColor[mobileId].VisualStateId)

	else -- update as soon as we have them
		Interface.ExecuteWhenAvailable(
		{
			name = "UpdateTargetColors" .. mobileId,
			check = function() return WindowData.HealthBarColor[mobileId] ~= nil end, 
			callback = function() HealthBarColor.UpdateHealthBarColor(healthbar, mobileId == GetPlayerID() and WindowData.PlayerStatus.VisualStateId or WindowData.HealthBarColor[mobileId].VisualStateId) end, 
			removeOnComplete = true
		})

		-- update the healthbar color with a default color
		HealthBarColor.UpdateHealthBarColor(healthbar, 0)
	end
end

function TargetWindow.UpdateObjectInfo(objectId)
	
	-- is this mobile the current target?
	if not TargetWindow.HasValidTarget() or objectId ~= TargetWindow.TargetId then
		return
	end

	-- update the name label
	LabelSetText("TargetWindowName", GetItemName(objectId))
end

function TargetWindow.ForceUpdate(timePassed)

	-- if the interface is shutting down we can avoid everything in here
	if Interface.goingDown then
		return
	end

	-- target window name
	local this = "TargetWindow"

	-- distance window name
	local distanceLabel = this .. "Distance"

	-- do we have a valid target?
	if TargetWindow.HasValidTarget() then

		-- update the timers
		TargetWindow.Delta = TargetWindow.Delta + timePassed
		TargetWindow.DeltaC = TargetWindow.DeltaC + timePassed

		-- is it time to update the buttons?
		if TargetWindow.DeltaC > 1 then

			-- reset the timer
			TargetWindow.DeltaC = 0

			-- do we have any buttons?
			if #TargetWindow.Buttons <= 0 then

				-- draw the buttons
				TargetWindow.UpdateButtons()

			else -- refresh the buttons status
				TargetWindow.RefreshButtons()
			end
		end
	end

	-- has the status been updated in the last second?
	if TargetWindow.TargetType == TargetWindow.MobileType and TargetWindow.TargetId ~= GetPlayerID() and (not Interface.LastStatusUpdate[TargetWindow.TargetId] or Interface.LastStatusUpdate[TargetWindow.TargetId] + 1 < Interface.TimeSinceLogin) then

		-- forcefully unregister the status
		Interface.UnregisterWindowData(WindowData.MobileStatus.Type, TargetWindow.TargetId)

		-- re-register the status
		Interface.GetMobileData(TargetWindow.TargetId)
	end

	-- get the distance from the player
	local dist = GetDistanceFromPlayer(TargetWindow.TargetId)

	-- is the target NOT the player or an item that belongs to him and it's in a 25 tiles range?
	if not DoesPlayerHaveItem(TargetWindow.TargetId) and TargetWindow.TargetId ~= GetPlayerID() and dist and (dist >= 0 or dist < 35) then

		-- make the label a bit transparent
		WindowSetFontAlpha(distanceLabel, 0.7)

		-- write the distance in the label
		LabelSetText(distanceLabel, ReplaceTokens(GetStringFromTid(1154905), {towstring(dist)})) -- Distance: ~1_NUM~

	else -- hide the distance label
		WindowSetFontAlpha(distanceLabel, 0)
	end

	-- do we have to update the health?
	if TargetWindow.RefreshHealth then

		-- increase the health update timer
		TargetWindow.DeltaHealth = TargetWindow.DeltaHealth + timePassed
		
		-- is it time to update the buttons?
		if TargetWindow.DeltaHealth > 1 then

			-- acquire the item properties for the item
			local dt = Interface.GetItemPropertiesData(TargetWindow.TargetId, "Get item intensity info for listview")	

			-- do we have the properties?
			if dt then
				
				-- filling the TID props array
				props = ItemProperties.BuildParamsArray(dt, true)
			end

			-- do we have the item properties?
			if props then

				-- scan all the health props
				for tid, _ in pairs(ItemPropertiesInfo.MastHealthTid) do

					-- do we have the health prop?
					if props[tid] then
						
						-- healthbar window name
						local healthbar = this .. "HealthBar"

						-- hp % label
						local hpPerc = this .. "Hits"

						-- get the health percent
						local perc = tonumber(props[tid][1])

						-- update the bar status
						StatusBarSetMaximumValue(healthbar, 100)
						StatusBarSetCurrentValue(this .. "HealthBar", perc)

						-- build the percent string
						local percString = GetStringFromTid(1053042) .. L": " .. perc

						-- update the percentage text
						LabelSetText(hpPerc, percString .. L"%")

						-- scale the text color to become red when is near 0
						WindowUtils.ScaleTextRedByPerc(hpPerc, perc)

						-- get the hue data
						local hue = HealthBarColor.BarColor[HealthBarColor.HealthVisualState.Default]

						-- color the bar
						WindowSetTintColor(healthbar, hue.r, hue.g, hue.b)

						break
					end
				end
			end

		end
	end
end

function TargetWindow.RefreshButtons()

	-- scan all the buttons
	for i, slot  in pairsByIndex(TargetWindow.Buttons) do

		-- get the slot id
		local id = WindowGetId(slot)

		-- buy sell and bank works only in an 8 tiles radius
		if (id == 110 or id == 111 or id == 120) then

			-- is the player further than 8 tiles?
			if GetDistanceFromPlayer(WindowData.CurrentTarget.TargetId) > 8 then

				-- disable the button
				ButtonSetDisabledFlag(slot, true)
				WindowSetShowing(slot .. "Disabled", true)

			else -- enable the button
				ButtonSetDisabledFlag(slot, false)
				WindowSetShowing(slot .. "Disabled", false)
			end
		end
		
		if id == 301 then -- taming

			-- taming works only in a 3 tiles radius
			if GetDistanceFromPlayer(TargetWindow.TargetId) > 3 then

				-- disable the button
				ButtonSetDisabledFlag(slot, true)
				WindowSetShowing(slot .. "Disabled", true)

			else -- enable the button
				ButtonSetDisabledFlag(slot, false)
				WindowSetShowing(slot .. "Disabled", false)
				
				-- the button should be visible only if the creature is tamable
				if TargetWindow.CurrentCreature and TargetWindow.CurrentCreature.tamable then

					-- get the taming skill level
					local skillLevel = GetSkillValue(SkillsWindow.SkillsID.ANIMAL_TAMING, true)

					-- do we have enough taming to tame the creature?
					if skillLevel < TargetWindow.CurrentCreature.tamable then

						-- disable the button
						ButtonSetDisabledFlag(slot, true)
						WindowSetShowing(slot .. "Disabled", true)

					else -- enable the button
						ButtonSetDisabledFlag(slot, false)
						WindowSetShowing(slot .. "Disabled", false)
					end
				end
			end
		end
	end
end

function TargetWindow.GetActionsList()

	-- do we have the context menu data?
	if TargetWindow.ContextData and #TargetWindow.ContextData > 0 then

		-- does the context menu data belongs to the current target?
		if TargetWindow.ContextData.id == TargetWindow.TargetId then

			-- store the last context menu ID
			TargetWindow.LastContextId = TargetWindow.ContextData.id

			-- return the context data
			return TargetWindow.ContextData
		end
	end
end

function TargetWindow.DestroyButtons()

	-- scan the current buttons
	for i, button in pairsByIndex(TargetWindow.Buttons) do

		-- does the button exist?
		if DoesWindowExist(button) then

			-- destroy the button
			DestroyWindow(button)
		end
	end

	-- clear the buttons array
	TargetWindow.Buttons  = {}
end

function TargetWindow.HasValidTarget()

	-- if we have a valid target ID and the window is visible, then the target is valid
	if (IsValidID(TargetWindow.TargetId) and WindowGetShowing("TargetWindow")) then
		return true
	end
	return false
end

function TargetWindow.UpdateButtons()

	-- do we have a valid target?
	if not TargetWindow.HasValidTarget() then
		return
	end

	-- function available only for mobiles and objects
	if TargetWindow.TargetType ~= TargetWindow.MobileType and TargetWindow.TargetType ~= TargetWindow.ObjectType then
		return
	end

	-- destroy the existing buttons
	TargetWindow.DestroyButtons()
	
	-- are the buttons enabled?
	if not Interface.Settings.EnableContextButtons then
		return
	end

	-- the max number of buttons per line is 5
	local maxButtonsPerLine = 5

	-- get the context menu elements
	local menuItems = TargetWindow.AcquireContextContent()
	
	-- if menuitems is nil there might be no actions or we didn't get the context menu content from the server and wel'll have to retry
	if not menuItems then
		return
	end

	-- first button of the line
	local firstButton

	-- scan all the menu items
	for i, element in pairsByIndex(menuItems) do

		-- get the icon ID for the element
		local iconId = TargetWindow.GetActionsIconId(element)

		-- make sure we have a valid icon, this shouldn't happen but you never know...
		if not IsValidID(iconId) then
			continue
		end

		-- draw the button, the function will return the first button of the line name
		local fb = TargetWindow.DrawActinButton(iconId, menuItems[i].returnCode, menuItems[i].tid, firstButton, maxButtonsPerLine)

		-- do we have the new first button of the line name?
		if IsValidString(fb) then

			-- update the first button name
			firstButton = fb
		end
	end

	-- update the button status
	TargetWindow.RefreshButtons()
end

function TargetWindow.AcquireContextContent()

	-- trying to acquire the stored context data for the target (if we already stored it)
	local menuItems = TargetWindow.GetActionsList(TargetWindow.TargetId)
	
	-- do we have the menu items?
	if not menuItems then

		-- we count the tries made to acquire the context menu, if greater than 10 we should stop trying...
		if TargetWindow.GetContextTries[TargetWindow.TargetId] and TargetWindow.GetContextTries[TargetWindow.TargetId] >= 10 then
			return
		end

		-- opening the context menu to retrieve the contents
		local result = RequestContextMenu(TargetWindow.TargetId, false)

		 -- context menu is busy we have to retry another time
		if result == "not now" then
			return
		end
		
		-- clear up the context menu
		ContextMenu.CleanUp()

		-- initializing or incrementing the number of tries
		if not TargetWindow.GetContextTries[TargetWindow.TargetId] then
			TargetWindow.GetContextTries[TargetWindow.TargetId] = 0

		else -- increase the number of tries
			TargetWindow.GetContextTries[TargetWindow.TargetId] = TargetWindow.GetContextTries[TargetWindow.TargetId] + 1
		end

		-- we can't update the buttons right away because the data requires a small amount of time to arrive, so we call a delayed update...
		Interface.AddTodoList({name = "target window delayed context buttons update", func = function() TargetWindow.UpdateButtons() end, time = Interface.TimeSinceLogin + 0.2})

		return
	end

	return menuItems
end

function TargetWindow.GetActionsIconId(menuItem)

	-- do we have the menu items?
	if not menuItem then
		return
	end

	-- 10000000 is the basic starting id for all target window menu actions
	local iconId = 10000000 + menuItem.returnCode 

	-- train skill id
	if menuItem.tid and TargetWindow.TrainSkillIcon[menuItem.tid] then
		iconId = 10000000 + TargetWindow.TrainSkillIcon[menuItem.tid]

	-- any other known action id
	elseif TargetWindow.OtherContextIcons[menuItem.returnCode] then
		iconId = TargetWindow.OtherContextIcons[menuItem.returnCode]
	end

	return iconId
end

function TargetWindow.DrawActinButton(iconId, returnCode, tid, firstButton, maxButtonsPerLine)

	-- do we have a valid icon ID?
	if not IsValidID(iconId) then
		return false
	end

	-- verify iconId
	local name, x, y = GetIconData(iconId)

	-- if the string is invalid, we don't have the texture for the button
	if not IsValidString(name) then
		return false
	end
	
	-- icon scale
	local scale = 0.9

	-- get the icon dimensions
	local newWidth, newHeight = UOGetTextureSize("icon" .. iconId)

	-- button name
	local slot = "TargetWindow" .. iconId .. "Button"

	-- create the button
	CreateWindowFromTemplate(slot, "TargetWindowBigButtonTemplate", "Root")

	-- set the action ID to the button
	WindowSetId(slot, returnCode)

	-- set the tid to the icon (for redraw purpose)
	WindowSetId(slot .. "Icon", tid)

	-- main window to dock the buttons to
	local dock = "TargetWindow"

	-- is this the very first button?
	if #TargetWindow.Buttons <= 0 then

		-- anchor the button to the bottom left of the target window
		WindowAddAnchor(slot, "bottomleft", dock, "topleft", 35, 0)

		-- update the first button of the line name
		firstButton = slot

	-- checking if it's the first button of a new line
	elseif #TargetWindow.Buttons % maxButtonsPerLine == 0 then

		-- anchor to the bottom of the first button of the previous line
		WindowAddAnchor(slot, "bottomleft", firstButton, "topleft", 0, 0)

		-- update the first button of the line name
		firstButton = slot

	else -- any other button, anchor to the right of the previous button
		WindowAddAnchor(slot, "topright", TargetWindow.Buttons[#TargetWindow.Buttons], "topleft", 5, 0)
	end

	-- add the button to the buttons table
	table.insert(TargetWindow.Buttons, slot)

	-- enabling the button
	ButtonSetDisabledFlag(slot, false)
	WindowSetShowing(slot .. "Disabled", false)

	-- drawing the icon and scaling
	DynamicImageSetTextureDimensions(slot .. "Icon", newWidth * scale, newHeight * scale)
	WindowSetDimensions(slot.. "Icon", newWidth*scale, newHeight*scale)
	DynamicImageSetTexture(slot .. "Icon", name, x, y )
	DynamicImageSetTextureScale(slot .. "Icon", scale)

	-- applying the same scale of the target window to the button
	local tscale = WindowGetScale("TargetWindow")
	WindowSetScale(slot, tscale - (tscale / 4))

	return firstButton
end

--When players double clice on the target window, send a request object use packet
function TargetWindow.OnItemDblClicked()

	-- do we have a cursor target? do nothing then
	if DoesPlayerHasCursorTarget() then
		return
	end

	-- use the item/mobile
	UserActionUseItem(TargetWindow.TargetId, false)
end

function TargetWindow.OnRClick()

	-- get the context menu for the target
	RequestContextMenu(TargetWindow.TargetId)
end

function TargetWindow.OnLClick()

	-- are we dragging an item?
	if SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM then

		-- drop the item on the item/give to the mobile
	    DragSlotDropObjectToObject(TargetWindow.TargetId)

	else --Let the targeting manager handle single left click on the target
		HandleSingleLeftClkTarget(TargetWindow.TargetId)
	end
end

function TargetWindow.OnMouseOver()

	-- do we have a valid target ID and it's not the one on the current item properties?
	if IsValidID(TargetWindow.TargetId) and TargetWindow.TargetId ~= WindowGetId("ItemProperties") then

		-- reset the item properties array
		ItemProperties.ResetWindowDataPropertiesFull()
	end

	-- initialize the item properties array
	local itemData =
	{
		windowName = "TargetWindow",
		itemId = TargetWindow.TargetId,
		itemType = WindowData.ItemProperties.TYPE_ITEM,
	}		
	
	-- show the item properties
	ItemProperties.SetActiveItem(itemData)	
end

function TargetWindow.OnMouseOverEnd()

	-- clear the item properties
	ItemProperties.ClearMouseOverItem()
end

function TargetWindow.ButtonsUse()

	-- get the button window name
	local wind = SystemData.ActiveWindow.name

	-- is the button enabled?
	if ButtonGetDisabledFlag(wind) then
		return
	end

	-- execute the action for the button
	ContextMenu.RequestContextAction(TargetWindow.TargetId, WindowGetId(wind))
end

function TargetWindow.OnMoveStart(flags)

	-- target window name
	local this = "TargetWindow"

	-- is the target window locked?
	if not TargetWindow.Locked then

		-- start moving the window
		WindowSetMoving(this, true)

		-- pressing ALT allows to move the target without snapping
		if flags ~= WindowUtils.ButtonFlags.ALT then
			SnapUtils.StartWindowSnap(this)
		end
	end
end

function TargetWindow.Lock()

	-- invert the current lock status
	TargetWindow.Locked = not TargetWindow.Locked 

	-- save the new lock status
	Interface.SaveSetting("TargetWindowLocked", TargetWindow.Locked)
	
	-- update the lock button texture
	TargetWindow.UpdateLockButtonTexture()
end

function TargetWindow.UpdateLockButtonTexture()
	
	-- target window name
	local this = "TargetWindow"

	-- lock button name
	local lockButton = this .. "Lock"

	-- default lock texture?
	local texture = "Lock"

	-- is the target window unlocked?
	if not TargetWindow.Locked  then

		-- change the texture for unlocked
		texture = "UnLock"
	end
	
	-- draw the texture
	ButtonSetTexture(lockButton, InterfaceCore.ButtonStates.STATE_NORMAL, texture, 0,0)
	ButtonSetTexture(lockButton,InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, texture, 0,0)
	ButtonSetTexture(lockButton, InterfaceCore.ButtonStates.STATE_PRESSED, texture, 0,0)
	ButtonSetTexture(lockButton, InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, texture, 0,0)
end

function TargetWindow.LockTooltip()

	-- is the target window locked?
	if TargetWindow.Locked then
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,GetStringFromTid(1154903)) -- unlock

	else -- the target window is unlocked
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1154904)) -- lock
	end
end

function TargetWindow.ButtonTooltip()

	-- get the window button name
	local button = SystemData.ActiveWindow.name

	-- get the button TID
	local id = WindowGetId(button .. "Icon") 

	-- do we have a valid TID?
	if IsValidID(id) then

		-- show the tooltip
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(id))
	end
end

function TargetWindow.UseTargetContext(contextAction)

	-- use the target window context menu action
	ContextMenu.RequestContextAction(TargetWindow.TargetId, contextAction)
end