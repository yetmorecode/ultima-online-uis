
Actions = {}

Actions.WarMode = 0

Actions.SpellbookTypes = {}
Actions.SpellbookTypes.Magery = 3834
Actions.SpellbookTypes.Chivalry = 8786
Actions.SpellbookTypes.Necromancy = 8787
Actions.SpellbookTypes.Bushido = 9100
Actions.SpellbookTypes.Ninjitsu = 9120
Actions.SpellbookTypes.Spellweaving = 11600
Actions.SpellbookTypes.Mysticism = 11677

Actions.PetBallType = 3630

function Actions.ToggleMainMenu()

	-- toggle the main menu visibility
	WindowSetShowing("MainMenuWindow", not WindowGetShowing("MainMenuWindow"))
end

function Actions.ToggleWarMode()

	-- toggle the war mode
	UserActionToggleWarMode()
end

function Actions.ToggleInventoryWindow()

	-- get the player backpack ID
	local objectId = GetBackpackID(GetPlayerID())
	
	-- are we dragging an object?
	if SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM then

		-- drop the object inside the backpack
	    DragSlotDropObjectToObject(GetPlayerID())

	else -- not dragging an object
		
		-- backpack window name
		local windowName = "ContainerWindow_" .. objectId
		
		-- is the backpack already open?
		if WindowGetShowing(windowName) then

			-- close the backpack
			DestroyWindow(windowName)

			-- flag the backpack as closed
			Interface.BackpackOpen = false

			-- save the setting
			Interface.SaveSetting("BackpackOpen", Interface.BackpackOpen)

		else -- backpack closed

			-- open the backpack
			UserActionUseItem(objectId, false)
		end
	end
end

function Actions.ToggleMapWindow()

	-- is the minimap open?
	if SystemData.Settings.Interface.mapMode ~= MapCommon.MAP_HIDDEN and MapCommon.GetActiveMap() ~= "AtlasWindow" then
	
		-- switch to atlas
		AtlasWindow.ShowAtlas()

	-- is the atlas open?
	elseif MapCommon.GetActiveMap() == "AtlasWindow" then

		-- return to the minimap
		AtlasWindow.HideAtlas()

	else -- if the minimap is closed we open it
		MapWindow.ShowMap()
	end	
end

function Actions.ToggleGuildWindow()

	-- initialize the search variables
	local gumpID
	local typ

	-- scan all the open gumps
    for k, v in pairs(GumpsParsing.ParsedGumps) do

		-- check if the gump type is a guild gump
		if	v == "GuildMenu" or 
			v == "GuildMenuMyGuild" or 
			v == "GuildMenuDiplomacy" or 
			v == "GuildMenuRoster"  or 
			v == "GuildMenuAdvSearch" or 
			v == "GuildMenuPlayerDetails" or 
			v == "GuildMenuRelationship"  or 
			v == "GuildMenuCreate"  or 
			v == "GuildMenuWar" then

			-- store the gump ID
			gumpID = k

			-- store the gump type
			typ = v

			break
		end
    end
   
	-- is the guild gump closed?
	if gumpID then

		-- is this the create guild menu?
		if typ == "GuildMenuCreate" then

			-- press the cancel button
			GumpsParsing.PressButton(gumpID, 2)

		else -- for any other guild gump we just right-click it
			GenericGumpOnRClicked(WindowGetId(GumpData.Gumps[gumpID].windowName)) 
		end

	else  -- if the gump is closed, we open it
		BroadcastEvent(SystemData.Events.REQUEST_OPEN_GUILD_WINDOW)
	end
end

function Actions.ToggleSkillsWindow()

	-- toggle the skill window
	SkillsWindow.ToggleSkillsWindow()
end

function Actions.ToggleVirtuesWindow()

	-- initialize the search variable
    local gumpID

	-- scan all the open gumps
    for k, v in pairs(GumpsParsing.ParsedGumps) do

		-- is this the virtues gump?
		if v == "VirtuesGump" then

			-- store the gump id
			gumpID = k

			break
		end
    end
   
   -- is the virtue gump open?
    if gumpID then

		-- press the cancel button
		GumpsParsing.PressButton(gumpID, 2)
		
	else -- if the gump is closed, we open it
		BroadcastEvent(SystemData.Events.REQUEST_OPEN_VIRTUES_LIST)
	end
end

function Actions.ToggleQuestWindow()

	-- initialize the search variable
    local gumpID

	-- scan all the open gumps
    for k, v in pairs(GumpsParsing.ParsedGumps) do

		-- is this the quest log gump?
		if v == "QuestLog" then

			-- store the gump ID
			gumpID = k

			break
		end
    end
   
	-- is the quest log open?
	if gumpID then

		-- press the ok button
		GumpsParsing.PressButton(gumpID, 1)
		
	else -- if the gump is closed, we open it
		BroadcastEvent(SystemData.Events.REQUEST_OPEN_QUEST_LOG)
	end
end

function Actions.ToggleHelpWindow()
    
	-- initialize the search variable
    local gumpID

	-- scan all the open gumps
    for k, v in pairs(GumpsParsing.ParsedGumps) do

		-- is this the help menu?
		if v == "HelpMenu" then

			-- store the gump ID
			gumpID = k

			break
		end
    end
   
	-- is the gump already open?
    if gumpID then

		-- right-click and close the gump
		GenericGumpOnRClicked(WindowGetId(GumpData.Gumps[gumpID].windowName)) 
	
	else -- if the gump is closed, we open it 
		BroadcastEvent(SystemData.Events.REQUEST_OPEN_HELP_MENU)
	end
end

function Actions.ToggleUOStoreWindow()

	-- flag that the next gump will be the store gump
	GenericGump.NextisShop = true

	-- open the store gump
    BroadcastEvent(SystemData.Events.UO_STORE_REQUEST)
end

function Actions.TogglePaperdollWindow()
	
	-- get the player ID
	local playerId = GetPlayerID()

	-- player paperdoll window name
	local windowName = "PaperdollWindow" .. playerId

	-- is the paperdoll already open?
	if DoesWindowExist(windowName) then

		-- close the paperdoll
		DestroyWindow(windowName)

		-- flag the paperdoll as closed
		Interface.PaperdollOpen = false

		-- save the setting
		Interface.SaveSetting("PaperdollOpen", Interface.PaperdollOpen)

	else -- paperdoll closed

		-- open the paperdoll from the player context menu
	    ContextMenu.RequestContextAction(playerId, ContextMenu.DefaultValues.OpenPaperdoll)
	end
end

function Actions.ToggleFoliage() 

	-- toggle the foliage setting
	SystemData.Settings.Resolution.displayFoliage = not SystemData.Settings.Resolution.displayFoliage

	-- save the settings
	UserSettingsChanged()

	-- update the settings window
	SettingsWindow.UpdateSettings()
end

function Actions.ToggleSound()

	-- toggle the sound setting
	SystemData.Settings.Sound.master.enabled = not SystemData.Settings.Sound.master.enabled
	
	-- save the settings
	UserSettingsChanged()

	-- update the settings window
	SettingsWindow.UpdateSettings()
end

function Actions.ToggleSoundEffects()
	
	-- toggle the sfx setting
	SystemData.Settings.Sound.effects.enabled = not SystemData.Settings.Sound.effects.enabled
	
	-- save the settings
	UserSettingsChanged()

	-- update the settings window
	SettingsWindow.UpdateSettings()
end

function Actions.ToggleMusic()
	
	-- toggle the music setting
	SystemData.Settings.Sound.music.enabled = not SystemData.Settings.Sound.music.enabled
	
	-- save the settings
	UserSettingsChanged()

	-- update the settings window
	SettingsWindow.UpdateSettings()
end

function Actions.ToggleFootsteps()

	-- toggle the footsteps setting
	SystemData.Settings.Sound.footsteps.enabled = not SystemData.Settings.Sound.footsteps.enabled
	
	-- save the settings
	UserSettingsChanged()

	-- update the settings window
	SettingsWindow.UpdateSettings()
end

function Actions.ToggleEnglishNames()

	-- if the client is already in english, changing the option is pointless
	if SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU then
		return
	end

	-- toggle the english names setting
	SystemData.Settings.Language.englishNames = not SystemData.Settings.Language.englishNames

	-- save the settings
	UserSettingsChanged()

	-- reload the interface
	InterfaceCore.ReloadUI()
end

function Actions.ToggleCharacterSheet()

	-- toggle the character sheet
	ToggleWindowByName("CharacterSheet")
end

function Actions.ToggleCharacterAbilities()

	-- toggle the character abilities
	ToggleWindowByName("CharacterAbilities")
end

function Actions.IgnorePlayer()

	-- show the target cursor to target the player to ignore
	RequestTargetInfo(Actions.Ignore)
end

function Actions.Ignore(Id)

	-- is the target a mobile?
	if IsMobile(Id) then

		-- is the mobile already in the ignore list?
		if not table.contains(WindowData.IgnoreIdList, Id) then

			-- get the mobile name
			local mobileName = GetMobileName(Id)

			-- add the mobile to the ignore list
			AddPlayerToIgnoreList(Id, mobileName, SettingsWindow.IGNORE_LIST_ALL)

			-- is the settings window closed?
			if not WindowGetShowing("SettingsWindow") then

				-- show the settings window
				ToggleWindowByName("SettingsWindow")
			end
		
			-- force select the filters tab
			SettingsWindow.ForceSelectTab(10)

			-- show an overhead message to warn the player who's being ignored
			SendOverheadText(ReplaceTokens(GetStringFromTid(1155098), { WindowData.MobileName[Id].MobName }), OverheadText.CustomMessageHues.RED) -- ~1_NAME~ will be ignored.

		else -- warn the player that the target is already being ignored
			SendOverheadText(ReplaceTokens(GetStringFromTid(581), { WindowData.MobileName[Id].MobName }), OverheadText.CustomMessageHues.RED)
		end

	else -- warn the player that the target cannot be ignored
		SendOverheadText(GetStringFromTid(1154926), OverheadText.CustomMessageHues.RED) -- You can ignore only Players!
	end
end

function Actions.ToggleUserSettings()	
	
	-- toggle the settings window
	ToggleWindowByName("SettingsWindow")
end

function Actions.ToggleActions()

	-- toggle the actions window
	ToggleWindowByName("ActionsWindow")
end

function Actions.ToggleMacros()

	-- toggle the macros window
	ToggleWindowByName("MacroWindow")
end

function Actions.AllRelease()

	-- create the buttons data
	local OKButton = { textTid = UO_StandardDialog.TID_OKAY, callback = function() Actions.ReleaseAll = true end } -- OK
	local cancelButton = { textTid = UO_StandardDialog.TID_CANCEL } -- Cancel

	-- create the dialog data
	local PetReleaseConfirmWindow = 
				{
					windowName = "PetReleaseConfirm",
					bodyTid = 582,
					titleTid = 1155582, -- Warning!
					buttons = { OKButton, cancelButton },
					closeCallback = cancelButton.callback,
					destroyDuplicate = true,
				}

	-- create the confirm dialog
	UO_StandardDialog.CreateDialog(PetReleaseConfirmWindow)
end

Actions.DeltaRelease = 0
Actions.DelayRelease = 0.3
Actions.ReleasedPetName = L"AbandonedPet"
function Actions.ReleasePet(timePassed)

	-- are we releasing all pets?
	if Actions.ReleaseAll then

		-- update the time
		Actions.DeltaRelease = Actions.DeltaRelease + timePassed

		-- is it time to release another?
		if Actions.DeltaRelease > Actions.DelayRelease then

			-- restart timer
			Actions.DeltaRelease = 0

			-- get the current riding pet
			local ridingPet = IsRiding(true)

			-- scan the pets we have
			for i, mobileId in pairsByIndex(WindowData.Pets.PetId) do

				-- if this is not a pet or is the current mount we can move on
				if not IsObjectIdPet(mobileId) or ridingPet == mobileId then
					continue
				end

				-- is the healthbar enabled and is a mobile?
				if IsHealthBarEnabled(mobileId) and IsMobile(mobileId) then
					
					-- get the mobile name
					local name = GetMobileName(mobileId)
				
					-- do we have a valid name?
					if IsValidWString(name) then
	
						-- has the pet already been renamed?
						if wstring.lower(name) ~= wstring.lower(Actions.ReleasedPetName) then
						
							-- increase the dealy (since it will take about 1 second to rename the pet)
							Actions.DelayRelease = 1
						
							-- rename the pet
							Actions.ForceRenamePet(mobileId, Actions.ReleasedPetName)

							-- we can get out and wait for the rename to take effect.
							return
						end
						
						-- say <pet name> release
						SendChat(ChatSettings.Channels[SystemData.ChatLogFilters.SAY].serverCmd, name .. L" release")

						-- restore the delay
						Actions.DelayRelease = 0.3

						-- close the pet healthbar
						MobileHealthBar.CloseBarByID(mobileId)
					end
				end
			end

			-- if we got here there are no more pets --
			
			-- stop the releaseing
			Actions.ReleaseAll = nil

			-- reset the delay
			Actions.DelayRelease = 0.3
		end
	end
end

function Actions.ForceRenamePet(mobileId, newName)
	
	-- do we have a valid pet ID?
	if not IsValidID(mobileId) or not IsObjectIdPet(mobileId) then
		return
	end

	-- set the pet ID to rename
	WindowData.Pets.RenameId = mobileId

	-- set the new pet name
	WindowData.Pets.Name = tostring(newName)

	-- rename the pet
	BroadcastEvent(SystemData.Events.RENAME_MOBILE)	
end

function Actions.TargetBoss()

	-- get the current boss ID
	local currBoss = BossBar.GetActiveBoss()

	-- do we have a valid boss ID?
	if IsValidID(currBoss) then

		-- target the boos
		HandleSingleLeftClkTarget(currBoss)
	end
end

function Actions.PrevTarget()

	-- get the ID of the last target (current one)
	local max = #TargetWindow.PreviousTargets

	-- do we have a valid target?
	if TargetWindow.HasValidTarget() then

		-- we remove the current target from the array
		table.remove(TargetWindow.PreviousTargets, max)
	end

	-- get the ID of a previous target
	local previous = Actions.SearchValidPrevTarget()

	-- do we have a previous target?
	if (previous and previous.id ~= WindowData.CurrentTarget.TargetId) then

		-- target
		HandleSingleLeftClkTarget(previous.id)
	end
end

function Actions.SearchValidPrevTarget()
	
	-- get the number of previous targets
	local max = #TargetWindow.PreviousTargets

	-- scan all previous targets
	for i = max, 1, -1 do
		
		-- is this a valid target (not the same we have now)?
		if (TargetWindow.PreviousTargets[i] ~= WindowData.CurrentTarget.TargetId and IsMobile(TargetWindow.PreviousTargets[i])) then

			-- found it
			return {id=TargetWindow.PreviousTargets[i], idx=i}
		end
	end
end

Actions.nxt = 1
function Actions.NextTarget(notoString)

	-- make sure the noto string is formatted correctly
	notoString = Actions.VerifyNotorietyString(notoString)

	-- make sure the current index do not exceed the current number of mobiles
	if Actions.nxt > table.countElements(Interface.ActiveMobilesOnScreen) then
		Actions.nxt = 1	
	end

	-- scanning all mobiles on screen
	for mobileId, mobileData in pairs(Interface.ActiveMobilesOnScreen) do

		-- is this target allowed and the index is the next one?
		if Actions.TargetAllowedCustom(mobileId, notoString) and mobileData.index and mobileData.index > Actions.nxt then
			
			-- is this the current target?
			if (IsValidID(TargetWindow.TargetId) and WindowData.CurrentTarget.TargetId ~= mobileId) or not IsValidID(TargetWindow.TargetId) then

				-- target the mobile
				HandleSingleLeftClkTarget(mobileId)

				-- increase the index for next
				Actions.nxt = mobileData.index + 1

				return
			end
		end
	end

	-- since we haven't found anything, we reset the index to 1
	Actions.nxt = 1
end

function Actions.TargetAllowedCustom(mobileId, notoString)

	-- is this the player?
	if (mobileId == GetPlayerID()) then
		return false
	end

	-- get the mobile name data
	local data = Interface.GetMobileNameData(mobileId)

	-- if we have no data then we can get out
	if not data then
		return false
	end
		
	-- get the mobile name
	local mobName = GetMobileName(mobileId)

	-- get the mobile notoriety
	local noto = GetMobileNotoriety(mobileId)
	
	-- mobiles that should be ignored
	if MobileHealthBar.IgnoredMobile(mobileId) then
		return false

	-- is this a player pet?
	elseif IsObjectIdPet(mobileId) then
		return false

	-- is the mobile visible?
	elseif not IsMobileVisible(mobileId) then
		return false

	-- do we want only poisoned mobiles and the mobile is not poisoned?
	elseif Actions.IsNotorietyEnabled(notoString, NameColor.NotorietyFilters.POISONEDONLY) and not IsMobilePoisoned(mobileId) then
		return false

	-- do we have to ignore mortal striked mobiles?
	elseif Actions.IsNotorietyEnabled(notoString, NameColor.NotorietyFilters.IGNOREMORTALSTRIKED) and IsMobileMortalStriked(mobileId) then
		return false

	-- is the farm animals filter active?
	elseif (not Actions.IsNotorietyEnabled(notoString, NameColor.NotorietyFilters.NEUTRALS) and (Interface.ActiveMobilesOnScreen[mobileId] and Interface.ActiveMobilesOnScreen[mobileId].isNeutralAnimal == true) and mobileId ~= Interface.CurrentHonor) then
	
		-- we check if a mobile is wounded
		local isWounded = false
		local curr, max, dead = GetMobileHealth(mobileId)
		if curr == max then
			return false
		end

	-- is the summon filter active?
	elseif (not Actions.IsNotorietyEnabled(notoString, NameColor.NotorietyFilters.SUMMONS) and (Interface.ActiveMobilesOnScreen[mobileId] and Interface.ActiveMobilesOnScreen[mobileId].isSummon == true) and mobileId ~= Interface.CurrentHonor) then
		return false

	-- is the boss filter active?
	elseif (not Actions.IsNotorietyEnabled(notoString, NameColor.NotorietyFilters.BOSSES) and (Interface.ActiveMobilesOnScreen[mobileId] and Interface.ActiveMobilesOnScreen[mobileId].isBoss == true) and mobileId ~= Interface.CurrentHonor) then
		return false

	-- is the players filter active?
	elseif (not Actions.IsNotorietyEnabled(notoString, NameColor.NotorietyFilters.PLAYERS) and (Interface.ActiveMobilesOnScreen[mobileId] and Interface.ActiveMobilesOnScreen[mobileId].isPlayer == true) and mobileId ~= Interface.CurrentHonor) then
		return false

	-- is the other players pets filter active?
	elseif (not Actions.IsNotorietyEnabled(notoString, NameColor.NotorietyFilters.PETS) and (Interface.ActiveMobilesOnScreen[mobileId] and Interface.ActiveMobilesOnScreen[mobileId].isSomeonePet == true) and mobileId ~= Interface.CurrentHonor) then
		return false

	-- is the notoriety filter active for the current action?
	elseif not Actions.IsNotorietyEnabled(notoString, noto) then
		return false
	end

	return true
end

function Actions.IsNotorietyEnabled(notoString, noto)
	
	-- each digit in the string is a notoriety (ex. 2 = innocent). If it's 1 is enabled, if it's 0 is disabled.
	-- check NameColor.NotorietyFilters to learn all the indexes
	return tonumber(string.getChar(notoString, noto)) == 1
end

function Actions.VerifyNotorietyString(notoString)

	-- do we have the notoriety filter string?
	if not notoString then

		-- initialize a notoriety string
		notoString = ""

	else -- make sure the value is a string
		notoString = tostring(notoString)
	end

	-- initialize the new string
	local newString = ""

	-- scan all the characters in the string
	for i = 1, string.len(notoString) do

		-- get the character
		local num = string.getChar(notoString, i)
		
		-- if there is an e (like e+015), we need to remove the esponential values entirely by exiting the cycle
		if num == "e" then
			break

		-- if we have a "." we move to the next character because the number might have been converted to esponential
		elseif num == "." then
			continue

		-- if the character is not 0 or 1 or not a number, we replace it with 1 and move forward
		elseif not tonumber(num) or (tonumber(num) ~= 0 and tonumber(num) ~= 1) then
			num = 0
		end

		newString = newString .. num
	end

	-- update the noto string
	notoString = newString

	-- do we have less numbers than notorieties? disable the missing notorieties
	while string.len(notoString) < table.countElements(NameColor.NotorietyFilters) do
		notoString = notoString .. "0"
	end

	return notoString
end

function Actions.NearTarget(notoString)

	-- make sure the noto string is formatted correctly
	notoString = Actions.VerifyNotorietyString(notoString)
	
	-- sorted array
	local currentSort = {}

	-- array index
	local i = 1

	-- scanning all mobiles on screen
	for mobileId, _ in pairs(Interface.ActiveMobilesOnScreen) do
		
		-- is the mobile allowed?
		if Actions.TargetAllowedCustom(mobileId, notoString) then

			-- add the target to the list
			currentSort[i] = mobileId

			-- increase the index
			i = i + 1
		end
	end

	-- sort the array by distance
	local pos = 1
	while pos <= #currentSort do
		if (pos == 1 or GetDistanceFromPlayer(currentSort[pos]) >= GetDistanceFromPlayer(currentSort[pos-1])) then
			pos = pos + 1
		else
			local swap = currentSort[pos]
			currentSort[pos] = currentSort[pos-1]
			currentSort[pos-1] = swap
			pos = pos - 1
		end
	end
	
	-- target the first in position
	for i, mobileId in pairsByKeys(currentSort) do

		-- target
		HandleSingleLeftClkTarget(mobileId)
		return
	end
end

function Actions.InjuredFollower()
	
	-- initialize the variables
	local lowerId = 0
	local lowerHP = -1

	-- scan all pets
	for i, mobileId in pairsByIndex(WindowData.Pets.PetId) do

		-- is the pet on sight?
		if IsHealthBarEnabled(mobileId) and IsMobileVisible(mobileId) then

			-- get the mobile health status
			local curHealth, maxHealth, dead, perc = GetMobileHealth(mobileId)
				
			-- is the mobile wounded?
			if perc and perc < 100 then

				-- is this mobile having less health than the current one (if we have one)?
				if perc < lowerHP or lowerHP == -1 then
					lowerHP = perc
					lowerId = mobileId
				end
			end
		end
	end

	-- if we have found a valid target, we target it
	if IsValidID(lowerId) then
		HandleSingleLeftClkTarget(lowerId)

	else -- no injured mobiles found
		SendOverheadText(GetStringFromTid(547), OverheadText.CustomMessageHues.RED)
	end
end

function Actions.InjuredParty()

	-- initialize the variables
	local lowerId = 0
	local lowerHP = -1

	-- scan all party members
	for i, member in pairsByIndex(WindowData.PartyMember) do

		-- get the mobile ID
		local mobileId = member.memberId

		-- is this any member but the player?
		if IsValidID(mobileId) and mobileId ~= GetPlayerID() then

			-- get the mobile health status
			local curHealth, maxHealth, dead, perc = GetMobileHealth(mobileId)
				
			-- is the mobile wounded?
			if perc and perc < 100 then

				-- is this mobile having less health than the current one (if we have one)?
				if perc < lowerHP or lowerHP == -1 then
					lowerHP = perc
					lowerId = mobileId
				end
			end
		end
	end

	-- if we have found a valid target, we target it
	if IsValidID(lowerId) then
		HandleSingleLeftClkTarget(lowerId)

	else -- no injured mobiles found
		SendOverheadText(GetStringFromTid(548), OverheadText.CustomMessageHues.RED)
	end
end

function Actions.InjuredMobile(notoString)

	-- make sure the noto string is formatted correctly
	notoString = Actions.VerifyNotorietyString(notoString)
	
	-- initialize the variables
	local lowerHP = -1
	local lowerID = 0

	-- scanning all mobiles on screen
	for mobileId, mobileData in pairs(Interface.ActiveMobilesOnScreen) do
		
		-- is not a pet or a party member and the target is allowed?
		if not IsPartyMember(mobileId) and not IsObjectIdPet(mobileId) and Actions.TargetAllowedCustom(mobileId, notoString) then

			-- get the mobile health status
			local curHealth, maxHealth, dead, perc = GetMobileHealth(mobileId)
			
			-- is the mobile wounded?
			if perc and perc < 100 then

				-- is this mobile having less health than the current one (if we have one)?
				if perc < lowerHP or lowerHP == -1 then
					lowerHP = perc
					lowerId = mobileId
				end
			end
		end
	end

	-- if we have found a valid target, we target it
	if IsValidID(lowerId) then
		HandleSingleLeftClkTarget(lowerId)

	else -- no injured mobiles found
		SendOverheadText(GetStringFromTid(549), OverheadText.CustomMessageHues.RED)
	end
end

function Actions.TargetFirstContainerObject(targetId)
	
	-- do we have the container ID?
	if not targetId then

		-- warn the user to target a container first
		SendOverheadText(GetStringFromTid(1154961), OverheadText.CustomMessageHues.RED)  -- Target a container first!

		return
	end

	-- get the container data
	local data = Interface.GetContainersData(targetId)

	-- do we have the container data?
	if not data then

		-- warn the user to open the container first
		SendOverheadText(GetStringFromTid(1154962), OverheadText.CustomMessageHues.RED) -- Open the container first!

		return
	end

	-- do we have items inside the containers? 
	if #data.ContainedItems <= 0 then

		-- warn the user that the container is empty
		SendOverheadText(GetStringFromTid(583), OverheadText.CustomMessageHues.RED)

		return
	end

	-- target the first object inside the container
	HandleSingleLeftClkTarget(data.ContainedItems[1].objectId)
end

function Actions.TargetType()

	-- send an overhead message to target the item type
	SendOverheadText(GetStringFromTid(1154964), OverheadText.CustomMessageHues.LIGHTBLUE) -- Target the item type.
	
	-- show the cursor target
	RequestTargetInfo(Actions.TypeRequestTargetInfoReceived)
end

function Actions.TypeRequestTargetInfoReceived(objectId)

	-- get the item data of the targeted item
	local itemData = Interface.GetObjectInfoData(objectId)

	-- do we have the item data?
	if itemData then
		
		-- get the action data
		local actionData = ActionsWindow.ActionData[Actions.ActionEditRequest.ActionId]

		-- create the command string
		local speechText = ReplaceTokens(actionData.callback, { towstring(itemData.objectType), towstring(itemData.hueId) })
		
		-- save the command string
		UserActionSpeechSetText(Actions.ActionEditRequest.HotbarId, Actions.ActionEditRequest.ItemIndex, Actions.ActionEditRequest.SubIndex, speechText)
	
	else -- no item data

		-- send the chat message "invalid item"
		ChatPrint(GetStringFromTid(1154965), SystemData.ChatLogFilters.SYSTEM) -- Invalid item.

		-- create the command string with 0 as item type and hue (so the action won't generate any errors)
		local speechText = ReplaceTokens(actionData.callback, { towstring(0), towstring(0) })

		-- save the command string
		UserActionSpeechSetText(Actions.ActionEditRequest.HotbarId, Actions.ActionEditRequest.ItemIndex, Actions.ActionEditRequest.SubIndex, speechText)
	end

	-- clear the action edit request data
	Actions.ActionEditRequest = {}
end

function Actions.TargetByType(type, hue)
	
	-- search the backpack for the item type + hue
	local id = ContainerWindow.GetItemIDByType(type, hue, false)

	-- if we have found it we target it
	if IsValidID(id) then
		HandleSingleLeftClkTarget(id)
	end
end

function Actions.TargetDefaultPet(id)
	
	-- store the ID of the default pet (1 to 5)
	Actions.DefaultRecordID = id
	
	-- show a message to target the pet
	SendOverheadText(GetStringFromTid(1154969), OverheadText.CustomMessageHues.LIGHTBLUE) -- Target the pet

	-- show the cursor target
	RequestTargetInfo(Actions.SetDefaultPet)
end

function Actions.SetDefaultPet(objectId)
	
	-- is this a mobile?
	if IsMobile(objectId) then
	
		-- is this a player's pet?
		if IsObjectIdPet(objectId) then

			-- create the pet variable name
			local petVar =  "DefaultPet" .. Actions.DefaultRecordID

			-- store the pet ID
			Interface[petVar] = objectId

			-- save the new ID
			Interface.SaveSetting(petVar, Interface[petVar])

			-- warn the player that the pet ID has been stored
			ChatPrint(ReplaceTokens(GetStringFromTid(1154971), { towstring(Actions.DefaultRecordID) }), SystemData.ChatLogFilters.SYSTEM) -- Default pet ~1_NUM~ stored!

		else -- warn the player that the target is not his pet
			ChatPrint(GetStringFromTid(1154970), SystemData.ChatLogFilters.SYSTEM) -- This is not yours!
		end

	else -- warn the player that the target is not good
		ChatPrint(GetStringFromTid(500330), SystemData.ChatLogFilters.SYSTEM) -- That's not an animal!
	end
	
	-- delete the default pet ID variable
	Actions.DefaultRecordID = nil
end

function Actions.TargetDefaultItem(id)

	-- store the ID of the default item (1 to 5)
	Actions.DefaultRecordID = id
	
	-- show a message to target the item
	SendOverheadText(GetStringFromTid(1154972), OverheadText.CustomMessageHues.LIGHTBLUE) -- Target the item

	-- show the cursor target
	RequestTargetInfo(Actions.SetDefaultItem)
end

function Actions.SetDefaultItem(objectId)
	
	-- create the item variable name
	local itemVar =  "DefaultObject" .. Actions.DefaultRecordID

	-- store the pet ID
	Interface[itemVar] = objectId

	-- save the new ID
	Interface.SaveSetting(petVar, Interface[itemVar])

	-- warn the player that the pet ID has been stored
	ChatPrint(ReplaceTokens(GetStringFromTid(1154973), { towstring(Actions.DefaultRecordID) }), SystemData.ChatLogFilters.SYSTEM) -- Default object ~1_NUM~ stored!
	
	-- delete the default pet ID variable
	Actions.DefaultRecordID = nil
end

function Actions.TargetPetball()

	-- is this an hotbar slot?
	if Actions.ActionEditRequest.SubIndex == 0 then

		-- clear the hotbar slot
		Actions.ClearEditingActionSlot()

		-- warn the player that this can only be used inside a macro
		ChatPrint(GetStringFromTid(1154963), SystemData.ChatLogFilters.SYSTEM)  -- This action can only be used inside of a macro.

		return
	end

	-- show a message to target the item
	SendOverheadText(GetStringFromTid(1155434), OverheadText.CustomMessageHues.LIGHTBLUE) -- Target the pet summoning ball.

	-- show the cursor target
	RequestTargetInfo(Actions.PetballRequestTargetInfoReceived)
end

function Actions.PetballRequestTargetInfoReceived(objectId)

	-- get the targeted item type
	local objectType = GetItemType(objectId)

	-- is it a valid pet ball?
	if IsValidID(objectId) and objectType == Actions.PetBallType then

		-- is the object inside the player's backpack?
		if DoesPlayerHaveItem(objectId) then
			
			-- create the command string
			local speechText = L"script HandleSingleLeftClkTarget(" .. objectId .. L")"

			-- store the command string
			UserActionSpeechSetText(Actions.ActionEditRequest.HotbarId, Actions.ActionEditRequest.ItemIndex, Actions.ActionEditRequest.SubIndex, speechText)

		else -- the object is not inside the player's backpack
			ChatPrint(GetStringFromTid(1154975), SystemData.ChatLogFilters.SYSTEM) -- The pet summoning crystal ball must be in your backpack!
		end

	else -- invalid object or not a pet ball
		ChatPrint(GetStringFromTid(1154974), SystemData.ChatLogFilters.SYSTEM) -- This is not a pet summoning crystal ball!
	end

	-- clear the action edit request data
	Actions.ActionEditRequest = {}
end

function Actions.TargetMount()

	-- bard slayer instruments
	if Actions.ActionEditRequest.ActionId >= 5800 and Actions.ActionEditRequest.ActionId < 5900 then
		SendOverheadText(GetStringFromTid(1155119), OverheadText.CustomMessageHues.LIGHTBLUE) -- Target the instrument.

	-- boat wheel
	elseif Actions.ActionEditRequest.ActionId == 5156 then
		SendOverheadText(GetStringFromTid(1154977), OverheadText.CustomMessageHues.LIGHTBLUE) -- Target the boat wheel.

	-- drop into container
	elseif Actions.ActionEditRequest.ActionId == 5736 then
		SendOverheadText(GetStringFromTid(1154978), OverheadText.CustomMessageHues.LIGHTBLUE) -- Target the container.

	-- mounts actions
	elseif Actions.ActionEditRequest.ActionId >= 5600 and Actions.ActionEditRequest.ActionId < 5700 then
		SendOverheadText(GetStringFromTid(1154976), OverheadText.CustomMessageHues.LIGHTBLUE) -- Target your mount.
	end

	-- show the cursor target
	RequestTargetInfo(Actions.MountRequestTargetInfoReceived)
end

function Actions.MountRequestTargetInfoReceived(objectId)
	
	-- initialize the command string
	local speechText = L""

	-- is this a pet and we're editing a mount actions?
	if IsObjectIdPet(objectId) and (Actions.ActionEditRequest.ActionId >= 5600 and Actions.ActionEditRequest.ActionId < 5700) then

		-- create the command string
		speechText = L"script HandleSingleLeftClkTarget(" .. objectId .. L")"

	-- is this the boat wheel action and we have a valid target?
	elseif IsValidID(objectId) and Actions.ActionEditRequest.ActionId == 5156 then

		-- create the command string
		speechText = L"script HandleSingleLeftClkTarget(" .. objectId .. L")"

	-- is this a bard slayer action and the player has the targeted item inside the backpack?
	elseif IsValidID(objectId) and DoesPlayerHaveItem(objectId) and (Actions.ActionEditRequest.ActionId >= 5800 and Actions.ActionEditRequest.ActionId < 5900) then

		-- create the command string
		speechText = L"script HandleSingleLeftClkTarget(" .. objectId .. L")"

	-- is this the drop into container action and we have a valid target?
	elseif IsValidID(objectId) and Actions.ActionEditRequest.ActionId == 5736 then

		-- create the command string
		speechText = L"script DragSlotDropObjectToObject(" .. objectId .. L")"

	else -- invalid target
		ChatPrint(GetStringFromTid(1149667), SystemData.ChatLogFilters.SYSTEM) -- Invalid target
	end

	-- store the command string
	UserActionSpeechSetText(Actions.ActionEditRequest.HotbarId, Actions.ActionEditRequest.ItemIndex, Actions.ActionEditRequest.SubIndex, speechText)

	-- clear the action edit request data
	Actions.ActionEditRequest = {}
end

function Actions.IgnoreActionSelf()
	
	-- toggle the ignore action on self setting
	SystemData.Settings.GameOptions.ignoreMouseActionsOnSelf = not SystemData.Settings.GameOptions.ignoreMouseActionsOnSelf

	-- is the setting enabed?
	if SystemData.Settings.GameOptions.ignoreMouseActionsOnSelf then
		ChatPrint(GetStringFromTid(1155102), SystemData.ChatLogFilters.SYSTEM) -- Ignore mouse actions on self enabled!

    else -- setting disabled
		ChatPrint(GetStringFromTid(1155435), SystemData.ChatLogFilters.SYSTEM) -- Ignore Mouse Actions On Self Disabled!
    end

	-- save the setting
    UserSettingsChanged()
end

function Actions.EnablePVPWarning()

	-- trigger the player context menu action
	ContextMenu.RequestContextAction(GetPlayerID(), ContextMenu.DefaultValues.EnablePVPWarning)
end

function Actions.ReleaseCoownership()

	-- trigger the player context menu action
	ContextMenu.RequestContextAction(GetPlayerID(), ContextMenu.DefaultValues.ReleaseCoOwnership)
end

function Actions.LeaveHouse()

	-- trigger the player context menu action
	ContextMenu.RequestContextAction(GetPlayerID(), ContextMenu.DefaultValues.LeaveHouse)
end

function Actions.QuestConversation()

	-- trigger the player context menu action
	ContextMenu.RequestContextAction(GetPlayerID(), ContextMenu.DefaultValues.QuestConversation)
end

function Actions.ViewQuestLog()

	-- trigger the player context menu action
	ContextMenu.RequestContextAction(GetPlayerID(), ContextMenu.DefaultValues.ViewQuestLog)
end

function Actions.CancelQuest()

	-- trigger the player context menu action
	ContextMenu.RequestContextAction(GetPlayerID(), ContextMenu.DefaultValues.CancelQuest)
end

function Actions.QuestItem()

	-- trigger the player context menu action
	ContextMenu.RequestContextAction(GetPlayerID(), ContextMenu.DefaultValues.QuestItem)
end

function Actions.InsuranceMenu()

	-- trigger the player context menu action
	ContextMenu.RequestContextAction(GetPlayerID(), ContextMenu.DefaultValues.InsuranceMenu)
end

function Actions.ToggleItemInsurance()

	-- trigger the player context menu action
	ContextMenu.RequestContextAction(GetPlayerID(), ContextMenu.DefaultValues.ToggleItemInsurance)
end

function Actions.TitlesMenu()

	-- trigger the player context menu action
	ContextMenu.RequestContextAction(GetPlayerID(), ContextMenu.DefaultValues.TitlesMenu)
end

function Actions.CancelProtection()

	-- trigger the player context menu action
	ContextMenu.RequestContextAction(GetPlayerID(), ContextMenu.DefaultValues.CancelProtection)
end

function Actions.VoidPool()

	-- trigger the player context menu action
	ContextMenu.RequestContextAction(GetPlayerID(), ContextMenu.DefaultValues.VoidPool)
end

function Actions.ToggleVendorSearch()

	-- trigger the player context menu action
	ContextMenu.RequestContextAction(GetPlayerID(), ContextMenu.DefaultValues.VendorSearch)
end

function Actions.SiegeBlessItem()

	-- trigger the player context menu action
	ContextMenu.RequestContextAction(GetPlayerID(), ContextMenu.DefaultValues.SiegeBless)
end

function Actions.ToggleTrades(fromSettings)

	-- is this the settings call? (the value has been set in that case)
	if not fromSettings then

		-- invert the current value
		Interface.Settings.AllowTrades = not Interface.Settings.AllowTrades

		-- save the new value
		Interface.SaveSetting("AllowTrades", Interface.Settings.AllowTrade)
	end

	-- is the setting active?
	if Interface.Settings.AllowTrades then

		-- enable the trades
		ContextMenu.RequestContextAction(GetPlayerID(), ContextMenu.DefaultValues.AllowTrades)

	else -- disable trades
		ContextMenu.RequestContextAction(GetPlayerID(), ContextMenu.DefaultValues.RefuseTrades)
	end
end

function Actions.ToggleFriendRequests(fromSettings)

	-- is this the settings call? (the value has been set in that case)
	if not fromSettings then

		-- invert the current value
		Interface.Settings.AllowFriendRequests = not Interface.Settings.AllowFriendRequests

		-- save the new value
		Interface.SaveSetting("AllowFriendRequests", Interface.Settings.AllowFriendRequests)
	end

	-- is the setting active?
	if Interface.Settings.AllowFriendRequests then

		-- enable the friend requests
		ContextMenu.RequestContextAction(GetPlayerID(), ContextMenu.DefaultValues.AcceptFriendRequests)

	else -- disable the friend requests
		ContextMenu.RequestContextAction(GetPlayerID(), ContextMenu.DefaultValues.RefuseFriendRequests)
	end
end

function Actions.ExportContainerItems()

	-- send an overhead message to target the container
	SendOverheadText(GetStringFromTid(1154960), OverheadText.CustomMessageHues.LIGHTBLUE)  -- Target the container

	-- show the cursor target
	RequestTargetInfo(Actions.RequestContItems)
end

function Actions.RequestContItems(objectId)

	-- do we have a valid ID and the container is open?
	if not IsValidID(objectId) or not ContainerWindow.OpenContainers[objectId] then

		-- warn the player to open the container first
		SendOverheadText(GetStringFromTid(1154962), OverheadText.CustomMessageHues.RED) -- Open the container first!

		return
	end

	-- get the container name
	local name = tostring(WindowData.ContainerWindow[objectId].containerName)
	
	-- do we have a valid name?
	if not IsValidString(name) then

		-- use the object ID as container name
		name = towstring(objectId)
	end
	
	-- initialize the items list
	local output = L"\r\n\r\n"

	-- get items list from the container
	local AllItems = ContainerWindow.ScanQuantities(objectId, true)
	
	-- scan all the items 
	for objectType, hueItems in pairs(AllItems) do

		-- scan all the hue of this object type available
		for hueID, itemIds in pairs(hueItems) do

			-- scan all the item id of this object type & hue
			for itemID, amount in pairs(itemIds) do

				-- get the item properties
				local props = ItemProperties.GetObjectProperties(itemID, nil, "Actions - Request Container items list")

				-- do we have the item properties?
				if props then

					-- scan all the properties
					for i = 1, #props do

						-- do we have a valid property?
						if IsValidWString(props[i]) then

							-- add the property to the list
							output = output .. props[i] .. L"\r\n"
						end
					end

					-- add a separator betweeen the items in the list
					output = output .. L"#####################\r\n\r\n\r\n"
				end
			end
		end
	end

	-- output text file name
	local fileName = "logs/Containers/[" .. GetClockString()  .. "] " .. name .. " Items.txt"

	-- create the text file
	CreateTextFile(fileName, output)
	
	-- show in chat a message with the file name
	ChatPrint(ReplaceTokens(GetStringFromTid(1155125), { towstring(fileName) }), SystemData.ChatLogFilters.SYSTEM)  -- The container items list has been saved into the file ~1_FILE~ inside the "Logs" directory of the game.
end

function Actions.CloseAllContainers()

	-- scan all the open containers
	for id, value in pairs(ContainerWindow.OpenContainers) do

		-- close the container if it's NOT the player backpack
		if id ~= ContainerWindow.PlayerBackpack then
			DestroyWindow("ContainerWindow_"..id)
		end
	end
end

function Actions.CloseAllCorpses()

	-- scan all the open containers
	for id, value in pairs(ContainerWindow.OpenContainers) do

		-- get the container data
		local data = Interface.GetContainersData(id)

		-- do we have the container data?
		if not data then
			continue
		end

		-- get the container name
		local itemName = wstring.lower(GetItemName(id))

		-- do we have a valid name?
		if IsValidWString(itemName) then 

			-- is this NOT flagged as a corpse when it should?
			if not data.isCorpse and IsCorpse(id) then

				-- update the flag
				WindowData.ContainerWindow[id].isCorpse = true 
			end
		end 

		-- is this a corpse?
		if data.isCorpse then

			-- close the container
			DestroyWindow("ContainerWindow_" .. id)
		end
	end
end

Actions.MassOrganize = false
function Actions.MassOrganizerStart()

	-- reset the organizer bag
	ContainerWindow.OrganizeBag = nil

	-- is the vacuum turned off?
	if Actions.MassOrganize == false then

		-- set the organizer bag (if there is one, if not, the backpack will be used)
		ContainerWindow.OrganizeBag = Organizer.Organizers_Cont[Organizer.ActiveOrganizer]

		-- turn off the organizer (in case it was on)
		ContainerWindow.Organize = false

		-- turn on the vacuum
		Actions.MassOrganize = true

	else -- if the vacuum is active, we turn it off
		Actions.MassOrganize = false
	end
end

function Actions.MassOrganizer(timePassed)
	
	-- is the mass organizer active and we can pick up an object?
	if (Actions.MassOrganize == true and ContainerWindow.CanPickUp == true and SystemData.DragItem.DragType ~= SystemData.DragItem.TYPE_ITEM) then
		
		-- acquire the bag in which to drop the loot
		local OrganizeBag = ContainerWindow.OrganizeBag

		-- no bag specified or unavailable?
		if not IsValidID(OrganizeBag) or not DoesPlayerHaveItem(OrganizeBag) then
			
			-- we drop all inside the loot bag or the player backpack if we have no loot bag
			OrganizeBag = inlineIf(IsValidID(Interface.LootBoxID) and DoesPlayerHaveItem(Interface.LootBoxID), Interface.LootBoxID, ContainerWindow.PlayerBackpack)
		end

		-- scan all open containers
		for id, value in pairs(ContainerWindow.OpenContainers) do

			-- does the container has a window and is not the backpack or the hotbag?
			if (DoesWindowExist("ContainerWindow_" .. id) and id ~= ContainerWindow.PlayerBackpack and id ~= ContainerWindow.OrganizeBag) then
				
				-- getting the container data
				local containerData = Interface.GetContainersData(id, true)

				-- do we have the container data?
				if not Interface.VerifyContainer(id, containerData) then
					return
				end

				-- getting the number of items from the container too loot
				local numItems = containerData.numItems

				-- is there something in the container?
				for i = 1, numItems  do
					
					-- getting the first item ID
					local itemId = containerData.ContainedItems[i].objectId

					-- get the item weight
					local weight = GetItemWeight(itemId)

					-- do we have a weight and is higher that the cap the player has set in the settings?
					if weight and weight > Interface.Settings.AutoLootMaxWeight then
						continue
					end

					-- getting the item data
					local itemData = Interface.GetObjectInfoData(itemId)

					-- do we have the item data?
					if (itemData) then

						-- is this a finders keepers item?
						if ContainerWindow.FindersKeepersActiveItems[itemId] then
							
							-- take the item
							MoveItemToContainer(itemId, itemData.quantity, OrganizeBag)

							-- ready for the next item
							return
						end

						-- do we have items in this organizer?
						if (Organizer.Organizer[Organizer.ActiveOrganizer]) then

							-- parsing the organizer items
							for j = 1,  Organizer.Organizers_Items[Organizer.ActiveOrganizer] do

								-- organizer item record
								local itemL = Organizer.Organizer[Organizer.ActiveOrganizer][j]

								-- is this item compatible with the one on the organizer?
								if	(itemL.type > 0 and itemL.type == itemData.objectType and itemL.hue == itemData.hueId) or
									(itemL.id > 0 and itemL.id == itemId)
								then
						
									-- if the item is gold we drop it inside the main level of the backpack no matter what
									if itemData.objectType == 3821 and OrganizeBag ~= ContainerWindow.PlayerBackpack then
										MoveItemToContainer(itemId, itemData.quantity, ContainerWindow.PlayerBackpack)

									else -- any other item we move in the chosen container
										MoveItemToContainer(itemId, itemData.quantity, OrganizeBag)
									end

									-- ready for the next item
									return
								end
							end
						end	
					end
				end

				-- do we have to close the container when finished? 
				if Organizer.Organizers_CloseCont[Organizer.ActiveOrganizer] then
					
					-- close the container
					DestroyWindow("ContainerWindow_" .. id)
				end
			end
		end

		-- warn the player the vacuum is completed
		ChatPrint(GetStringFromTid(595), SystemData.ChatLogFilters.SYSTEM)

		-- if we end up here there is nothing else to move, so we can turn off the organizer
		Actions.MassOrganize = false
	end
end

Actions.AutoLoadShurikens = false
function Actions.LoadShuri(itemId)

	-- are we already loading shurikens?
	if Actions.AutoLoadShurikens then
		return
	end

	-- get the ninja belt ID
	local BeltId = itemId or PaperdollWindow.GetPaperdollSlotID(GetPlayerID(), 15)

	-- do we have a ninja belt equipped (or passed by parameter)?
	if not IsValidID(BeltId) then
		
		-- search the belt inside the player backpack
		BeltId = ContainerWindow.GetItemIDByType({ 10128, 10203 })
	end

	-- do we have a valid belt ID now?
	if not IsValidID(BeltId) then

		-- no ninja belt available
		ChatPrint(GetStringFromTid(587), SystemData.ChatLogFilters.SYSTEM)

		return
	end
		
	-- get the ninja belt uses
	local uses = Actions.GetNinjaBeltUses(BeltId)
		
	-- is the belt with less than 10 charges?
	if uses and uses < 10 then

		-- store the belt ID
		Actions.BeltMenuRequest = BeltId

		-- start loading the ammunitions
		Actions.AutoLoadShurikens = true

		-- send the chat message "loading shurikens..."
		ChatPrint(GetStringFromTid(584), SystemData.ChatLogFilters.SYSTEM)

	else -- warn the player that the belt is already full
		ChatPrint(GetStringFromTid(1063302), SystemData.ChatLogFilters.SYSTEM) -- You cannot add any more shuriken.
	end
end

Actions.Nextshuri = 0
function Actions.Shuriken(timePassed)
	
	-- is the auto-load process active?
	if Actions.AutoLoadShurikens then

		-- increase the timer
		Actions.Nextshuri = Actions.Nextshuri + timePassed

		-- is it time to load another shuriken?
		if Actions.Nextshuri >= 0.5 then

			-- reset the timer
			Actions.Nextshuri = 0
			
			-- get the ninja belt uses
			local uses = Actions.GetNinjaBeltUses(Actions.BeltMenuRequest)

			-- do we have less than 10 shuriken loaded?
			if uses and uses < 10 then

				-- is the cursor target active?
				if DoesPlayerHasCursorTarget() then

					-- get the shuriken item ID
					local shuri = ContainerWindow.GetItemIDByType({ 10156 })

					-- do we have a valid ID?
					if IsValidID(shuri) then

						-- target the shuriken
						HandleSingleLeftClkTarget(shuri)

					else -- we don't have any more shurikens inside the backpack

						-- disable the loading process
						Actions.StopLoadingShurikens()

						-- send the chat message "not enough shurikens"
						ChatPrint(GetStringFromTid(586), SystemData.ChatLogFilters.SYSTEM)
					end

				else -- trigger the "load shuriken" context menu action
					ContextMenu.RequestContextAction(Actions.BeltMenuRequest, ContextMenu.DefaultValues.LoadShuriken)
				end

			else -- the belt is fully laoded
				
				-- disable the loading process
				Actions.StopLoadingShurikens()

				-- send the chat message "not enough shurikens"
				ChatPrint(GetStringFromTid(585), SystemData.ChatLogFilters.SYSTEM)
			end
		end
	end
end

function Actions.StopLoadingShurikens()

	-- is the cursor target active?
	if DoesPlayerHasCursorTarget() then

		-- remove the cursor target
		CancelCursorTarget()
	end	

	-- disable the loading process
	Actions.AutoLoadShurikens = false
end

function Actions.GetNinjaBeltUses(BeltId)

	-- get the belt properties
	local props = Interface.GetItemPropertiesData(BeltId, "container items weight scan")

	-- do we have the belt properties?
	if props then

		-- build the properties parameters array
		local params = ItemProperties.BuildParamsArray(props)

		-- scan all the properties
		for tid, data in pairs(params) do

			-- is this the charges properties?
			if ItemPropertiesInfo.ChargesTid[tid] then

				-- get the param ID for the charges
				local token = ItemPropertiesInfo.ChargesTid[tid]

				-- get the uses amount
				return tonumber(tostring(data[token]))
			end
		end
	end
end

Actions.KeepAlive = false
Actions.KeepAliveDelta = 0
function Actions.ToggleKeepAlive( )

	-- toggle the afk mode
	Actions.KeepAlive = not Actions.KeepAlive 

	-- reset the afk mode timer
	Actions.KeepAliveDelta = 0

	-- has the afk mode been activated?
	if Actions.KeepAlive then

		-- create the animation
		CreateWindowFromTemplate("SleepEffect_a", "SleepEffect", "Root")

		-- set the animation color
		WindowSetTintColor("SleepEffect_a", 0, 204, 255)

		-- attach the animation to the player
		AttachWindowToWorldObject(GetPlayerID(), "SleepEffect_a")

		-- start the animation
		AnimatedImageStartAnimation("SleepEffect_a", 1, true, false, 0.0)

		-- type "." to refresh the player status
		SendChat(ChatSettings.Channels[SystemData.ChatLogFilters.SAY].serverCmd, L"; ." )

	else -- disable afk mode

		-- stop the animation
		AnimatedImageStopAnimation("SleepEffect_a")

		-- delete the animation object
		DestroyWindow("SleepEffect_a")
	end
end

function Actions.KeepAliveMan(timePassed)

	-- is the afk mode active?
	if Actions.KeepAlive then

		-- increase the timer
		Actions.KeepAliveDelta = Actions.KeepAliveDelta + timePassed

		-- is it time to refresh the player status?
		if Actions.KeepAliveDelta >= 300 then

			-- reset the timer
			Actions.KeepAliveDelta = 0

			-- type "." to refresh the player status
			SendChat(ChatSettings.Channels[SystemData.ChatLogFilters.SAY].serverCmd, L"; ." )
		end
	end
end

function Actions.DressHolding()

	-- drop the object on the paperdoll (this way it will be equipped if the slot for the item is empty)
	DragSlotDropObjectToPaperdoll(GetPlayerID())
end

function Actions.DropHolding()
	
	-- drop the object inside the player backpack (first slot available)
	DragSlotDropObjectToObjectAtIndex(ContainerWindow.PlayerBackpack, 0)
end

function Actions.ToggleTrapBox()

	-- do we have a valid trap box already?
	if IsValidID(Interface.TrapBoxID) then

		-- store the old trap box ID
		Interface.oldTrapBoxID = Interface.TrapBoxID

		-- remove the trapbox ID
		Interface.TrapBoxID = 0

		-- delete the trap box saved ID
		Interface.DeleteSetting("TrapBoxID")

		-- update the object color for the trap box
		ContainerWindow.UpdateObject("ContainerWindow_" .. ContainerWindow.PlayerBackpack, Interface.oldTrapBoxID)

		-- warn the player that the trap box has been unset
		ChatPrint(GetStringFromTid(1155144), SystemData.ChatLogFilters.SYSTEM) -- Trap Box un-set!

	else -- no trap box at the moment
		
		-- ask the player to target the trap box
		SendOverheadText(GetStringFromTid(1155145), OverheadText.CustomMessageHues.LIGHTBLUE) -- Target your trap box

		-- show the cursor target
		RequestTargetInfo(Actions.TrapboxTargetReceived)
	end
end

function Actions.TrapboxTargetReceived(objectId)

	-- do we have a valid object ID?
	if not IsValidID(objectId) then

		-- warn the player that the target is invalid
		ChatPrint(GetStringFromTid(1149667), SystemData.ChatLogFilters.SYSTEM) -- Invalid target

		return
	end
	
	-- is the target a container?
	if not IsContainer(objectId) then

		-- warn the player that the target is not a container
		ChatPrint(GetStringFromTid(1155159), SystemData.ChatLogFilters.SYSTEM) -- This is not an accessible container!

		return
	end

	-- get the object type
	local objectType = GetItemType(objectId)
	
	-- does the player has the item inside the backpack and it's NOT the backpack?
	if objectId ~= ContainerWindow.PlayerBackpack and IsInPlayerBackPack(objectId) then

		-- the trapbox can only be a crate
		if objectType == 2473 or objectType == 3644 or objectType == 3645 or objectType == 3646 or objectType == 3647 or objectType == 3710 then

			-- set the new trap box ID
			Interface.TrapBoxID = objectId

			-- save the trap box ID
			Interface.SaveSetting("TrapBoxID", Interface.TrapBoxID )

			-- update the trap box color
			ContainerWindow.UpdateObject("ContainerWindow_" .. ContainerWindow.PlayerBackpack, Interface.TrapBoxID)

			-- warn that the trap box has been set
			ChatPrint(GetStringFromTid(1155147), SystemData.ChatLogFilters.SYSTEM) -- Trap Box Set!

		else -- not a crate
			ChatPrint(GetStringFromTid(1155146), SystemData.ChatLogFilters.SYSTEM) -- Only crates can be used as trapped boxes!
		end

	else -- the player targeted his backpack or a container that is not inside his backpack
		ChatPrint(GetStringFromTid(1155148), SystemData.ChatLogFilters.SYSTEM) -- The trapped box must be in your backpack!
	end
end

function Actions.ToggleLootbag()

	-- do we have a valid loot box already?
	if IsValidID(Interface.LootBoxID) then

		-- store the old loot box ID
		Interface.oldLootBoxID = Interface.LootBoxID

		-- remove the current loot box ID
		Interface.LootBoxID = 0

		-- delete the loot box saved ID
		Interface.DeleteSetting("LootBoxID")

		-- update the old loot box color
		ContainerWindow.UpdateObject("ContainerWindow_" .. ContainerWindow.PlayerBackpack, Interface.oldLootBoxID)

		-- warn the player that the trap box has been unset
		ChatPrint(GetStringFromTid(1155152), SystemData.ChatLogFilters.SYSTEM) -- Loot Bag un-set!
	
	else -- no loot bag at the moment

		-- ask the player to target the loot bag
		SendOverheadText(GetStringFromTid(1155153), OverheadText.CustomMessageHues.LIGHTBLUE) -- Target your loot bag

		-- show the cursor target
		RequestTargetInfo(Actions.LootbagTargetReceived)
	end
end

function Actions.LootbagTargetReceived(objectId)
	
	-- do we have a valid object ID?
	if not IsValidID(objectId) then

		-- warn the player that the target is invalid
		ChatPrint(GetStringFromTid(1149667), SystemData.ChatLogFilters.SYSTEM) -- Invalid target

		return
	end

	-- is the target a container?
	if not IsContainer(objectId) then

		-- warn the player that the target is not a container
		ChatPrint(GetStringFromTid(1155159), SystemData.ChatLogFilters.SYSTEM) -- This is not an accessible container!

		return
	end

	-- does the player has the item inside the backpack and it's NOT the backpack?
	if objectId ~= ContainerWindow.PlayerBackpack and IsInPlayerBackPack(objectId) then

		-- set the new loot bag ID
		Interface.LootBoxID = objectId

		-- save the loot bag ID
		Interface.SaveSetting("LootBoxID", Interface.LootBoxID)

		-- update the loot bag color
		ContainerWindow.UpdateObject("ContainerWindow_" .. ContainerWindow.PlayerBackpack, Interface.LootBoxID)

		-- warn that the loot bag has been set
		ChatPrint(GetStringFromTid(1155154), SystemData.ChatLogFilters.SYSTEM) -- Loot Bag Set!
		
	else  -- the player targeted his backpack or a container that is not inside his backpack
		ChatPrint(GetStringFromTid(1155156), SystemData.ChatLogFilters.SYSTEM) -- You cannot set this container as a loot bag!
	end
end

function Actions.ToggleAlphaMode()

	-- is the scale mode active?
	if WindowUtils.ToggleScale then

		-- deactivate the scale mode
		Actions.ToggleScaleMode()
	end

	-- toggle the alpha mode
    WindowUtils.ToggleAlpha = not WindowUtils.ToggleAlpha 

	-- save the alpha mode status
	Interface.SaveSetting("ToggleAlpha", WindowUtils.ToggleAlpha)

	-- show the new alpha mode status
   	ChatPrint(GetStringFromTid(inlineIf(WindowUtils.ToggleAlpha, 1155160, 1155161)), SystemData.ChatLogFilters.SYSTEM) -- Alpha Mode Enabled/Disabled!
end

function Actions.ToggleScaleMode()

	-- is the alpha mode active?
	if WindowUtils.ToggleAlpha then

		-- deactivate the alpha mode
		Actions.ToggleAlphaMode()
	end

	-- toggle the scale mode
    WindowUtils.ToggleScale = not WindowUtils.ToggleScale 

	-- save the new scale mode status
	Interface.SaveSetting("ToggleScale", WindowUtils.ToggleScale)

	-- show the new alpha mode status
   	ChatPrint(GetStringFromTid(inlineIf(WindowUtils.ToggleScale, 1155166, 1155167)), SystemData.ChatLogFilters.SYSTEM) -- Scale Mode Enabled/Disabled!
end

Actions.ObjectHandleContext = {}
Actions.ObjectHandleContext.CHANGETYPE = 1
Actions.ObjectHandleContext.SETFILTER = 2
Actions.ObjectHandleContext.ADDFILTER = 3
Actions.ObjectHandleContext.REMOVEFILTERS = 4
function Actions.ObjectHandleContextMenu()
    
	-- reset the context menu
	ContextMenu.CleanUp()

	-- scan all the possible filters
    for filter = 1, #SettingsWindow.ObjectHandles do

		-- add the filter to the context menu
        ContextMenu.CreateLuaContextMenuItem({ tid = SettingsWindow.ObjectHandles[filter].tid, returnCode = Actions.ObjectHandleContext.CHANGETYPE, param = SettingsWindow.ObjectHandles[filter].id, pressed = SystemData.Settings.GameOptions.objectHandleFilter == SettingsWindow.ObjectHandles[filter].id })
    end    

	-- add an empty line to the context menu
    ContextMenu.CreateLuaContextMenuItem(ContextMenu.EmptyLine)
    
	-- do we have a valid filter active?
    if IsValidWString(ObjectHandleWindow.CurrentFilter) then

		-- add the option to add an additional filter
		ContextMenu.CreateLuaContextMenuItem({ tid = 1154850, returnCode = Actions.ObjectHandleContext.ADDFILTER })

		-- add the option to remove all filters
		ContextMenu.CreateLuaContextMenuItem({ tid = 1154849, returnCode = Actions.ObjectHandleContext.REMOVEFILTERS })

	else
		-- add the option to set a filter
		ContextMenu.CreateLuaContextMenuItem({ tid = 1062476, returnCode = Actions.ObjectHandleContext.SETFILTER })
    end

	-- show the context menu
    ContextMenu.ActivateLuaContextMenu(Actions.ObjectHandleContextMenuCallback)
end

function Actions.ObjectHandleContextMenuCallback(returnCode, param)
	
	-- set the first filter to the object handles
	if returnCode == Actions.ObjectHandleContext.SETFILTER then

		-- create the input box data
		local rdata = { title = GetStringFromTid(1062476), subtitle = GetStringFromTid(1155172), callfunction = Actions.ObjectHandleSetFilter, id = 2 } -- Set Filter // -- If you set a filter only the items/mobiles that contains the specified text in their name will be shown. This action also allows you to set a text filter in order to quickly find an item or a mobile.

		-- create the input box
		RenameWindow.Create(rdata)

	-- add an additional filter
	elseif returnCode == Actions.ObjectHandleContext.ADDFILTER then

		-- create the input box data
		local rdata = { title = GetStringFromTid(1062476), subtitle = GetStringFromTid(1155172), callfunction = Actions.ObjectHandleSetFilter, id = 3 } -- Set Filter // -- If you set a filter only the items/mobiles that contains the specified text in their name will be shown. This action also allows you to set a text filter in order to quickly find an item or a mobile.

		-- create the input box
		RenameWindow.Create(rdata)

	-- remove all filters
	elseif returnCode == Actions.ObjectHandleContext.REMOVEFILTERS then

		-- remove the filters
		ObjectHandleWindow.CurrentFilter = nil

	-- change the object handle type
	elseif returnCode == Actions.ObjectHandleContext.CHANGETYPE then

		-- set the new object handle type
		SystemData.Settings.GameOptions.objectHandleFilter = param

		-- store the setting (since the default variable get reset when the client closes)
		Interface.Settings.objectHandleFilter = param

		-- save the setting
		Interface.SaveSetting("objectHandleFilter", Interface.Settings.objectHandleFilter)

		-- save the changes
		UserSettingsChanged()
	end
end

function Actions.ObjectHandleSetFilter(j, newval)

	-- set the first object handle filter
	if j == 2 then
		ObjectHandleWindow.CurrentFilter = newval

	-- add an additional object handle filter
	elseif j == 3 then
		ObjectHandleWindow.CurrentFilter = ObjectHandleWindow.CurrentFilter .. L"|" .. newval
	end
end

Actions.ClosestCorpseFlags = {}
Actions.ClosestCorpseFlags.UNLOOTED = 1
Actions.ClosestCorpseFlags.LOOTRANGE = 2
Actions.ClosestCorpseFlags.REANIMABLE = 3

Actions.BonesIDs = { 3786, 3787, 3788, 3789, 3790, 3791, 3792, 3793, 3794  }

function Actions.TargetClosestCorpse(flags)

	-- make sure the time since the last object update is less than 10 seconds
	if Interface.ActiveItemsTimeFromLastUpdate > 10 then

		-- ask the player to update the object list first
		ChatPrint(GetStringFromTid(588), SystemData.ChatLogFilters.SYSTEM)

		return
	end

	-- verify and fix the flags string
	flags = Actions.VerifyClosestCorpseFlags(flags)

	-- do we need only unlooted corpses?
	local unlootedOnly = Actions.IsFlagEnabled(flags, Actions.ClosestCorpseFlags.UNLOOTED)

	-- do we need only corpses in looting range?
	local lootRangeOnly = Actions.IsFlagEnabled(flags, Actions.ClosestCorpseFlags.LOOTRANGE)

	-- do we need only reanimable corpses?
	local reanimableOnly = Actions.IsFlagEnabled(flags, Actions.ClosestCorpseFlags.REANIMABLE)

	-- variables to store the closest corpse
	local closestID
	local closestDistance

	-- scan the active objects list
	for objectId, data in pairs(Interface.ActiveItemsOnScreen) do
	
		-- is the item in the ignore list and we want only unlooted corpses?
		if unlootedOnly and ContainerWindow.IgnoreItems[objectId] then
			continue
		end

		-- get the distance from the player
		local distance = GetDistanceFromPlayer(objectId)
		
		-- do we want only corpses in looting range?
		if lootRangeOnly and distance > 2 then
			continue
		end

		-- make sure the item is a corpse
		if data.isCorpse then

			-- do we want only corpses that can be re-animated and the corpse type ID is bones?
			if reanimableOnly and table.contains(Actions.BonesIDs, data.type) then
				continue
			end

			-- if we don't have a closer item yet or this item is closer than then one we have we store it
			if not closestDistance or distance < closestDistance then
				closestDistance = distance
				closestID = objectId
			end
		end
	end

	-- have we found the closest corpse?
	if IsValidID(closestID) then

		-- target the corpse
		HandleSingleLeftClkTarget(closestID)

	else -- no corpses in range
		ChatPrint(GetStringFromTid(589), SystemData.ChatLogFilters.SYSTEM)
	end
end

function Actions.IsFlagEnabled(flags, flagId)
	
	-- each digit in the string is a flag (ex. 2 = only loot range). If it's 1 is enabled, if it's 0 is disabled.
	-- check Actions.ClosestCorpseFlags to learn all the indexes
	return tonumber(string.getChar(flags, flagId)) == 1
end

function Actions.VerifyClosestCorpseFlags(flags)
	
	-- do we have the flags filter string?
	if not flags then

		-- initialize a flags string
		flags = ""

	else -- make sure the value is a string
		flags = tostring(flags)
	end

	-- initialize the new string
	local newString = ""

	-- scan all the characters in the string
	for i = 1, string.len(flags) do

		-- get the character
		local num = string.getChar(flags, i)
		
		-- if there is an e (like e+015), we need to remove the esponential values entirely by exiting the cycle
		if num == "e" then
			break

		-- if we have a "." we move to the next character because the number might have been converted to esponential
		elseif num == "." then
			continue

		-- if the character is not 0 or 1 or not a number, we replace it with 1 and move forward
		elseif not tonumber(num) or (tonumber(num) ~= 0 and tonumber(num) ~= 1) then
			num = 0
		end

		newString = newString .. num
	end

	-- update the noto string
	flags = newString

	-- do we have less numbers than flags? disable the missing flags
	while string.len(flags) < table.countElements(Actions.ClosestCorpseFlags) do
		flags = flags .. "0"
	end

	return flags
end

function Actions.GetHealthbar()

	-- is the player the current target?
	if TargetWindow.TargetId == GetPlayerID() then

		-- player can't have an healthbar
		ChatPrint(GetStringFromTid(1155175), SystemData.ChatLogFilters.SYSTEM) -- You cannot get your own healthbar, you have the status bar!

		return
	end

	-- do we have a valid current target and is a mobile?
	if TargetWindow.HasValidTarget() and WindowData.CurrentTarget.TargetType == TargetWindow.MobileType then

		-- pin the current target healthbar
		MobileHealthBar.CreateBar(TargetWindow.TargetId, true)

	else -- warn the player that he has no valid current target
		ChatPrint(GetStringFromTid(1149667), SystemData.ChatLogFilters.SYSTEM ) -- invalid target
	end	
end

function Actions.GetTypeID()

	-- show the target item request text overhead
	SendOverheadText(GetStringFromTid(1154972), OverheadText.CustomMessageHues.LIGHTBLUE) -- Target the item

	-- send the target request
	RequestTargetInfo(Actions.ItemIDRequestTargetInfoReceived)
end

function Actions.ItemIDRequestTargetInfoReceived(objectId)

	-- do we have a valid ID?
	if not IsValidID(objectId) then

		-- send the error message
		ChatPrint(GetStringFromTid(1155183), SystemData.ChatLogFilters.SYSTEM)  -- You should target a dynamic item!

		return
	end
	
	-- object type variable
	local objectType 

	-- text to send overhead
	local finalText = L""
	
	-- is the target a mobile?
	if IsMobile(objectId) then 
		
		-- get the body ID
		objectType = GetMobileBodyID(objectId)
		
		-- convert the ID in hexadecimal
		local hexnum = WindowUtils.Dec2Hex(objectType)

		-- complete the text to show overhead
		finalText = ReplaceTokens(GetStringFromTid(414), { objectType .. L" ( 0x" .. towstring(hexnum) .. L" )" } )

	else -- get the item type ID
		objectType = GetItemType(objectId)

		-- convert the ID in hexadecimal
		local hexnum = WindowUtils.Dec2Hex(objectType)

		-- complete the text to show overhead
		finalText = ReplaceTokens(GetStringFromTid(1155184), { objectType .. L" ( 0x" .. towstring(hexnum) .. L" )" } ) -- The item type ID is: ~1_ID~

		-- bonsai seed type name
		local bonsai = L""

		-- common seed
		if (objectType == 10460 or objectType == 10463) then
			bonsai =  GetStringFromTid(1063338) .. L" " .. GetStringFromTid(1030460) -- common
		
		-- uncommon seed
		elseif (objectType == 10461 or objectType == 10464) then
			bonsai =  GetStringFromTid(1063339) .. L" " .. GetStringFromTid(1030460) -- uncommon
		
		-- rare seed
		elseif (objectType == 10462 or objectType == 10465) then
			bonsai = GetStringFromTid(1063340) .. L" " .. GetStringFromTid(1030460) -- rare
		
		-- exceptional seed
		elseif (objectType == 10466) then
			bonsai =  GetStringFromTid(1063341) .. L" " .. GetStringFromTid(1030460) -- exceptional
		
		-- exotic seed
		elseif (objectType == 10467) then
			bonsai =  GetStringFromTid(1063342) .. L" " .. GetStringFromTid(1030460) -- exotic
		end

		-- do we have the bonsai seed type?
		if bonsai ~= L"" then

			-- add the bonsai seed type to the end of the text to show
			finalText = finalText .. L" - " .. wstring.titleCase(bonsai)
		end
	end

	-- send the text overhead
	SendOverheadText(finalText, OverheadText.CustomMessageHues.RED)
end

function Actions.GetHueID()

	-- show the target item request text overhead
	SendOverheadText(GetStringFromTid(1154972), OverheadText.CustomMessageHues.LIGHTBLUE) -- Target the item

	-- send the target request
	RequestTargetInfo(Actions.ColorRequestTargetInfoReceived)
end

function Actions.ColorRequestTargetInfoReceived(objectId)

	-- do we have a valid ID?
	if not IsValidID(objectId) then

		-- send the error message
		ChatPrint(GetStringFromTid(1155183), SystemData.ChatLogFilters.SYSTEM)  -- You should target a dynamic item!

		return
	end

	-- is the target a mobile?
	if IsMobile(objectId) then 
		
		-- get the hue ID and rgb
		local hueId, hue = GetMobileHue(objectId)

		-- show the hue ID
		SendOverheadText(ReplaceTokens(GetStringFromTid(416), { towstring(hueId) }), OverheadText.CustomMessageHues.RED)

		-- show the hue RGB
		SendOverheadText(L"R:".. hue.r .. L" G:" .. hue.g .. L" B:" .. hue.b, OverheadText.CustomMessageHues.RED)

	else -- item target

		-- get the item hue ID
		local hueId, hue = GetItemHue(objectId)

		-- show the hue ID
		SendOverheadText(ReplaceTokens(GetStringFromTid(1155185), { towstring(hueId) }), OverheadText.CustomMessageHues.RED) -- The item color ID is: ~1_ID~
		
		-- show the hue RGB
		SendOverheadText(L"R:".. hue.r .. L" G:" .. hue.g .. L" B:" .. hue.b, OverheadText.CustomMessageHues.RED)
		
		-- does this color have a name?
		if HuesInfo.Data[hueId] then

			-- show the known color name
			SendOverheadText(ReplaceTokens(GetStringFromTid(1155186), { HuesInfo.Data[hueId] }), OverheadText.CustomMessageHues.RED) -- Known As: ~1_NAME~
			
			-- determine if this hue is obtainable from a dye tub
			local tubs = DyeTubs.DetermineDyeTub(hueId)

			-- dye tub wstring name
			local dyeTub = L""

			-- scan the dye tubs types we obtained
			for type, _ in pairs(tubs) do

				-- is this the normal/furniture dye tub?
				if type == DyeTubs.TubsTypes.Plain then

					-- dye tub name to show
					local dyeTubName = FormatProperly(GetStringFromTid(1060813)) .. L", " .. GetStringFromTid(1044502) -- plain -- Furniture

					-- append the dyetub name to the list
					dyeTub = wstring.appendWithSeparator(dyeTub, dyeTubName, L", ")
					
				-- is this the special dye tub?
				elseif type == DyeTubs.TubsTypes.Special then

					-- dye tub name to show
					local dyeTubName = GetStringFromTid(23)

					-- append the dyetub name to the list
					dyeTub = wstring.appendWithSeparator(dyeTub, dyeTubName, L", ")

				-- is this the leather dye tub?
				elseif type == DyeTubs.TubsTypes.Leather then

					-- dye tub name to show
					local dyeTubName = GetStringFromTid(1062235) .. L", " .. GetStringFromTid(1028901) .. L", " .. GetStringFromTid(24) -- Leather -- Runebook

					-- append the dyetub name to the list
					dyeTub = wstring.appendWithSeparator(dyeTub, dyeTubName, L", ")

				-- is this the metal dye tub?
				elseif type == DyeTubs.TubsTypes.Metal then

					-- dye tub name to show
					local dyeTubName = GetStringFromTid(25)

					-- append the dyetub name to the list
					dyeTub = wstring.appendWithSeparator(dyeTub, dyeTubName, L", ")
				end
			end

			-- have we found a valid dye tub name?
			if IsValidWString(dyeTub) then

				-- show the dye tub name
				SendOverheadText(ReplaceTokens(GetStringFromTid(22), { dyeTub }), OverheadText.CustomMessageHues.RED)
			end
		end
	end
end

function Actions.IgnoreTargettedItem()
	
	-- ask the player to target the item to ignore
	SendOverheadText(GetStringFromTid(1155220), OverheadText.CustomMessageHues.LIGHTBLUE) -- Target the item to ignore.

	-- show the cursor target
	RequestTargetInfo(Actions.IgnoreItemRequestTargetInfoReceived)
end

function Actions.IgnoreItemRequestTargetInfoReceived(objectId)

	-- do we have a valid target (not a mobile) and the target is not in the ignore list?
	if IsValidID(objectId) and not IsMobile(objectId) and not ContainerWindow.IgnoreItems[objectId] then

		-- add the item to the ignore list for 30 minutes
    	ContainerWindow.IgnoreItems[objectId] = Interface.Clock.Timestamp + 1800
	end
	
	-- warn the player that the item will be ignored for 30 minutes
	ChatPrint(GetStringFromTid(1155221), SystemData.ChatLogFilters.SYSTEM) -- The item will be ignored for 30 minutes.
end

function Actions.ClearIgnoreList()

	-- clear the ignore items list
    ContainerWindow.IgnoreItems = {}

	-- warn the player that the ignored items list is now empty
    ChatPrint(GetStringFromTid(1155224), SystemData.ChatLogFilters.SYSTEM) -- Ignore items list is now clear!
end

function Actions.ToggleBlockPaperdolls()

	-- toggle the block others paperdoll setting
	Interface.Settings.BlockOthersPaperdoll = not Interface.Settings.BlockOthersPaperdoll

	-- save the setting
	Interface.SaveSetting("BlockOthersPaperdoll", Interface.Settings.BlockOthersPaperdoll)

	-- show the message to confirm the changes
	ChatPrint(GetStringFromTid(inlineIf(Interface.Settings.BlockOthersPaperdoll, 1155226, 1155227)), SystemData.ChatLogFilters.SYSTEM)  -- Other paperdolls enabled/disabled!
end

function Actions.UndressMe()
	
	-- remove the current undress bag
	Actions.OrganizeBag = nil

	-- is the undress agent active?
	if Actions.Undress then

		-- turn off the undress agent
		Actions.Undress = false
		
	else -- agent inactive

		-- do we have a valid undress bag for the active agent?
		if IsValidID(Organizer.Undresses_Cont[Organizer.ActiveUndress]) and DoesPlayerHaveItem(Organizer.Undresses_Cont[Organizer.ActiveUndress]) then

			-- store the ID of the container to use
			Actions.OrganizeBag = Organizer.Undresses_Cont[Organizer.ActiveUndress]

			-- activate the undress agent
			Actions.Undress = true

		else -- we don't have a container set
				
			-- ask the player to target the container to use
			SendOverheadText(GetStringFromTid(1154773), OverheadText.CustomMessageHues.LIGHTBLUE)  -- Target the hotbag.
			
			-- show the cursor target
			RequestTargetInfo(Actions.UndressTargetInfoReceived)
		end
	end
end

function Actions.UndressTargetInfoReceived(objectId)
	
	-- do we have a valid target container
	if not IsValidID(objectId) or not IsContainer(objectId) then

		-- warn the player the target is not valid
		ChatPrint(GetStringFromTid(1149667), SystemData.ChatLogFilters.SYSTEM) -- Invalid target

		return
	end

	-- use the target container as undress bag
	Actions.OrganizeBag = objectId

	-- activate the undress agent
	Actions.Undress = true
end

function Actions.UndressAgent(timePassed)

	-- is the undress agent active and we can pick up an object?
	if (Actions.Undress == true and ContainerWindow.CanPickUp == true and SystemData.DragItem.DragType ~= SystemData.DragItem.TYPE_ITEM) then
	
		-- get the player ID
		local paperdollId = GetPlayerID()

		-- get the player paperdoll items list
		local paperdollData = PaperdollWindow.ItemsList[paperdollId]

		-- do we have the item list?
		if not paperdollData then

			-- generate the items list since it's currently unavailable
			paperdollData = Interface.GetPaperdollData(paperdollId)
		end

		-- acquire the bag in which to drop the items
		local OrganizeBag = Actions.OrganizeBag

		-- no bag specified or unavailable?
		if not IsValidID(OrganizeBag) or not DoesPlayerHaveItem(OrganizeBag) then

			-- we use the player backpack
			OrganizeBag = ContainerWindow.PlayerBackpack
		end

		-- scan all the paperdoll slots
		for index = 1, paperdollData.numSlots  do

			-- get the object ID for the slot
			local objectId = PaperdollWindow.GetPaperdollSlotID(paperdollId, index)

			-- is this a valid object ID?
			if IsValidID(objectId) then

				-- scan the items specified in the undress agent
				for _, itemL in pairs(Organizer.Undress[Organizer.ActiveUndress]) do

					-- is this an item we need to move?
					if IsValidID(itemL.id) and itemL.id == objectId then

						-- drop the item in the bag
						MoveItemToContainer(objectId, 1, OrganizeBag)

						return
					end
				end
			end
		end
		
		-- warn the player the vacuum is completed
		ChatPrint(GetStringFromTid(596), SystemData.ChatLogFilters.SYSTEM)

		-- turn off the undress agent
		Actions.Undress = false
	end
end

function Actions.ReimbueLast()
	
	-- is the imbuing gump open?
	if GumpsParsing.ParsedGumps[GenericGump.IMBUING_GUMPID] then

		-- press re-imbue last
		GumpsParsing.PressButton(GenericGump.IMBUING_GUMPID, 2)

	else -- send a warning to open the gump first
		ChatPrint(GetStringFromTid(1155370), SystemData.ChatLogFilters.SYSTEM) -- Use the imbuing skill first!
	end	
end

function Actions.ImbueLast()

	-- is the imbuing gump open?
	if GumpsParsing.ParsedGumps[GenericGump.IMBUING_GUMPID] then

		-- press imbue last
		GumpsParsing.PressButton(GenericGump.IMBUING_GUMPID, 4)

	else -- send a warning to open the gump first
		ChatPrint(GetStringFromTid(1155370), SystemData.ChatLogFilters.SYSTEM) -- Use the imbuing skill first!
	end	
end

function Actions.UnravelItem()

	-- is the imbuing gump open?
	if GumpsParsing.ParsedGumps[GenericGump.IMBUING_GUMPID] then

		-- press unrave item
		GumpsParsing.PressButton(GenericGump.IMBUING_GUMPID, 5)

	else -- send a warning to open the gump first
		ChatPrint(GetStringFromTid(1155370), SystemData.ChatLogFilters.SYSTEM) -- Use the imbuing skill first!
	end	
end

function Actions.UnravelContainer()

	-- is the imbuing gump open?
	if GumpsParsing.ParsedGumps[GenericGump.IMBUING_GUMPID] then

		-- press unravel container
		GumpsParsing.PressButton(GenericGump.IMBUING_GUMPID, 6)

	else -- send a warning to open the gump first
		ChatPrint(GetStringFromTid(1155370), SystemData.ChatLogFilters.SYSTEM) -- Use the imbuing skill first!
	end	
end

function Actions.EnhanceItem()

	-- crafting gump ID
	local gumpID = GenericGump.CRAFTING_GUMPID

	-- is the crafting gump open?
	if GumpsParsing.ParsedGumps[gumpID] then

		-- tools without the enhance button
		if	GumpsParsing.ParsedGumps[gumpID] == "AlchemyMenu" or
			GumpsParsing.ParsedGumps[gumpID] == "CookingMenu" or
			GumpsParsing.ParsedGumps[gumpID] == "CartographyMenu" or
			GumpsParsing.ParsedGumps[gumpID] == "InscriptionMenu" or
			GumpsParsing.ParsedGumps[gumpID] == "GlassblowingMenu"
		then
			-- warn the player that he can't enhance anything with the current tool
			ChatPrint(GetStringFromTid(1155383), SystemData.ChatLogFilters.SYSTEM) -- You cannot enhance anything with this tool.

		-- bowcraft uses button 10
		elseif GumpsParsing.ParsedGumps[gumpID] == "BowcraftMenu" then
			GumpsParsing.PressButton(gumpID, 10)

		-- blacksmith, carpentry and tailoring uses button 18
		elseif	GumpsParsing.ParsedGumps[gumpID] == "BlacksmithMenu" or
				GumpsParsing.ParsedGumps[gumpID] == "CarpentryMenu" or
				GumpsParsing.ParsedGumps[gumpID] == "TailoringMenu"
		then
			GumpsParsing.PressButton(gumpID, 18)

		-- masonry uses button 15
		elseif GumpsParsing.ParsedGumps[gumpID] == "MasonryMenu" then
			GumpsParsing.PressButton(gumpID, 15)

		-- tinkering uses button 16
		elseif GumpsParsing.ParsedGumps[gumpID] == "TinkeringMenu" then
			GumpsParsing.PressButton(gumpID, 16)
		end

	else -- crafting gump closed
		ChatPrint(GetStringFromTid(1155432), SystemData.ChatLogFilters.SYSTEM) -- Use a crafting tool first!
	end	
end

function Actions.SmeltItem()

	-- crafting gump ID
	local gumpID = GenericGump.CRAFTING_GUMPID

	-- is the crafting gump open?
	if GumpsParsing.ParsedGumps[gumpID] then

		-- is this the blacksmith crafting gump?
		if GumpsParsing.ParsedGumps[gumpID] == "BlacksmithMenu" then
			GumpsParsing.PressButton(gumpID, 4)

		else -- unavailable for any other profession
			ChatPrint(GetStringFromTid(1155384), SystemData.ChatLogFilters.SYSTEM) -- This works only for blacksmithing!
		end

	else -- crafting gump closed
		ChatPrint(GetStringFromTid(1155432), SystemData.ChatLogFilters.SYSTEM) -- Use a crafting tool first!
	end	
end

function Actions.AlterItem()
	
	-- crafting gump ID
	local gumpID = GenericGump.CRAFTING_GUMPID

	-- is the crafting gump open?
	if GumpsParsing.ParsedGumps[gumpID] then

		-- tools without the alter button
		if	GumpsParsing.ParsedGumps[gumpID] == "AlchemyMenu" or
			GumpsParsing.ParsedGumps[gumpID] == "CookingMenu" or
			GumpsParsing.ParsedGumps[gumpID] == "BowcraftMenu" or
			GumpsParsing.ParsedGumps[gumpID] == "CartographyMenu" or
			GumpsParsing.ParsedGumps[gumpID] == "InscriptionMenu" or
			GumpsParsing.ParsedGumps[gumpID] == "MasonryMenu" or
			GumpsParsing.ParsedGumps[gumpID] == "GlassblowingMenu"
		then

			ChatPrint(GetStringFromTid(1155382), SystemData.ChatLogFilters.SYSTEM) -- You cannot alter anything with this tool.

		-- carpentry, tailoring and tinkering uses button 5
		elseif	GumpsParsing.ParsedGumps[gumpID] == "CarpentryMenu" or
				GumpsParsing.ParsedGumps[gumpID] == "TailoringMenu" or
				GumpsParsing.ParsedGumps[gumpID] == "TinkeringMenu"
		then
			GumpsParsing.PressButton(gumpID, 5)

		-- blacksmith uses button 6
		elseif GumpsParsing.ParsedGumps[gumpID] == "BlacksmithMenu" then
			GumpsParsing.PressButton(gumpID, 6)
		end

	else -- crafting gump closed 
		ChatPrint(GetStringFromTid(1155432), SystemData.ChatLogFilters.SYSTEM) -- Use a crafting tool first!
	end	
end

function Actions.MakeLast()

	-- crafting gump ID
	local gumpID = GenericGump.CRAFTING_GUMPID

	-- is the crafting gump open?
	if GumpsParsing.ParsedGumps[gumpID] then

		-- press make last
		GumpsParsing.PressButton(gumpID, 2)
	
	else -- crafting gump closed 
		ChatPrint(GetStringFromTid(1155432), SystemData.ChatLogFilters.SYSTEM) -- Use a crafting tool first!
	end	
end

function Actions.RepairItem()
	
	-- crafting gump ID
	local gumpID = GenericGump.CRAFTING_GUMPID

	-- is the crafting gump open?
	if GumpsParsing.ParsedGumps[gumpID] then
		
		-- tools without the repair button
		if	GumpsParsing.ParsedGumps[gumpID] == "AlchemyMenu" or
			GumpsParsing.ParsedGumps[gumpID] == "CookingMenu" or
			GumpsParsing.ParsedGumps[gumpID] == "CartographyMenu" or
			GumpsParsing.ParsedGumps[gumpID] == "InscriptionMenu"
		then
			ChatPrint(GetStringFromTid(1155433), SystemData.ChatLogFilters.SYSTEM) -- You cannot repair anything with this tool!

		-- tools that uses the button 4
		elseif  GumpsParsing.ParsedGumps[gumpID] == "CarpentryMenu" or
				GumpsParsing.ParsedGumps[gumpID] == "TailoringMenu" or
				GumpsParsing.ParsedGumps[gumpID] == "BowcraftMenu" or
				GumpsParsing.ParsedGumps[gumpID] == "TinkeringMenu" or
				GumpsParsing.ParsedGumps[gumpID] == "MasonryMenu" or
				GumpsParsing.ParsedGumps[gumpID] == "GlassblowingMenu"
		then
			GumpsParsing.PressButton(gumpID, 4)

		-- blacksmith uses the button 5
		elseif GumpsParsing.ParsedGumps[gumpID] == "BlacksmithMenu" then
			GumpsParsing.PressButton(gumpID, 5)
		end

	else -- crafting gump closed 
		ChatPrint(GetStringFromTid(1155432), SystemData.ChatLogFilters.SYSTEM) -- Use a crafting tool first!
	end	
end

function Actions.CloseCraftGump()

	-- crafting gump ID
	local gumpID = GenericGump.CRAFTING_GUMPID

	-- is the crafting gump open?
	if GumpsParsing.ParsedGumps[gumpID] then

		-- press exit
		GumpsParsing.PressButton(gumpID, 1)
	
	else -- crafting gump closed 
		ChatPrint(GetStringFromTid(1155432), SystemData.ChatLogFilters.SYSTEM) -- Use a crafting tool first!
	end	
end

function Actions.SetCraftItem()

	-- is the crafting item details open?
	if not GumpData.Gumps[GenericGump.CRAFTING_ITEM_DETAILS_GUMPID] then
	
		-- warn the player to open the crafting item details first
		ChatPrint(GetStringFromTid(657), SystemData.ChatLogFilters.SYSTEM)

		return
	end	

	-- get the crafting skill name
	local skillName = GumpsParsing.ParsedGumps[GenericGump.CRAFTING_ITEM_DETAILS_GUMPID]

	-- get the item TID
	local itemTid, materials = GumpsParsing.GetCraftingToolActiveItemData()
	
	-- get the current item data
	local itemData = CraftingInfo.ToolMap[skillName][itemTid]

	-- make sure the item exist
	if not itemData then

		-- send an error to the player to report this problem
		Debug.Print("MISSING ITEM FROM TOOL: " .. skillName .. " REPORT THIS AS BUG!!!")

		return
	end

	-- default item instance
	local instance = 1

	-- does this item have multiple instances?
	if itemData.index2 then

		-- scan the materials of the first instance.
		for matTid, _ in pairs(itemData.materials) do

			-- if the first material in the first item instance is not in the current gump item materials list, then is the second instance for sure
			if not materials[matTid] then
				instance = 2

				break
			end
		end
	end

	-- create the command string
	local speechText = L"script Actions.CraftItem(" .. itemTid .. L", " .. instance .. L", \"" .. towstring(skillName) .. L"\")"

	-- save the command string
	UserActionSpeechSetText(Actions.ActionEditRequest.HotbarId, Actions.ActionEditRequest.ItemIndex, Actions.ActionEditRequest.SubIndex, speechText)

	-- click the back button
	GumpsParsing.PressButton(GenericGump.CRAFTING_ITEM_DETAILS_GUMPID, 1)

	-- warn the player to open the crafting item details first
	ChatPrint(ReplaceTokens(GetStringFromTid(659), { GetStringFromTid(itemTid) }), SystemData.ChatLogFilters.SYSTEM)
end

function Actions.CraftItem(itemTid, instance, skillName)

	-- no item set?
	if not IsValidID(itemTid) then
		
		-- warn the player to set the item to craft first
		ChatPrint(GetStringFromTid(658), SystemData.ChatLogFilters.SYSTEM)

		return
	end

	-- crafting gump ID
	local gumpID = GenericGump.CRAFTING_GUMPID

	-- is the crafting gump open?
	if not GumpsParsing.ParsedGumps[gumpID] then
	
		-- crafting gump closed 
		ChatPrint(GetStringFromTid(1155432), SystemData.ChatLogFilters.SYSTEM) -- Use a crafting tool first!

		return
	end	

	-- get the crafting skill name
	local currSkillName = GumpsParsing.ParsedGumps[GenericGump.CRAFTING_GUMPID]

	-- are we using the correct tool?
	if currSkillName ~= skillName then
		
		-- get the correct skill name
		local correctSkill = GumpsParsing.CraftingToolToolTypeToSkill(skillName)
		
		-- warnt the player that he's using the wrong tool 
		ChatPrint(ReplaceTokens(GetStringFromTid(660), { GetStringFromTid(correctSkill) }), SystemData.ChatLogFilters.SYSTEM)

		return
	end

	-- get the current item data
	local itemData = CraftingInfo.ToolMap[skillName][itemTid]

	-- make sure the item data exist
	if not itemData then
		return
	end

	-- get the categories button start ID
	local startId = GumpsParsing.MapCraftingToolGetFirstCatButton(GenericGump.CRAFTING_GUMPID)

	-- get the number of categories in this tool
	local totalCat = CraftingInfo.ToolMap[skillName].totalCategories

	-- get the item page for the instance
	local category = inlineIf(not instance or instance == 1, itemData.category, itemData.category2)

	-- get the item index for the instance
	local itemIndex = inlineIf(not instance or instance == 1, itemData.index, itemData.index2)

	-- get the item page for the instance
	local page = inlineIf(not instance or instance == 1, itemData.page, itemData.page2)

	-- get the offset from the prev/next page button
	local pageBtnOffset = inlineIf(page == 1, 0, ((page - 2) * 2) + 2)

	-- calculate the button ID
	local btnId = startId + totalCat + GumpsParsing.ToolMaterialsCount(skillName) + (itemIndex * 2) + pageBtnOffset + GumpsParsing.ToolHasEnhance(skillName)
	
	-- are we in the wrong category?
	if GumpsParsing.CraftingToolCurrentCategory ~= category then
		
		-- go to the right category
		GumpsParsing.PressButton(GenericGump.CRAFTING_GUMPID, startId + category)

		-- update the current category
		GumpsParsing.CraftingToolCurrentCategory = category
	end
	
	-- click the craft item button as soon as the gump is back up
	Interface.ExecuteWhenAvailable({ name = "GetCraftingToolItemDetails", check = function() return GumpsParsing.ParsedGumps[GenericGump.CRAFTING_GUMPID] ~= nil end, callback = function() GumpsParsing.PressButton(GenericGump.CRAFTING_GUMPID, btnId - 1) GumpsParsing.CraftingToolAutoDetails = nil end, maxTime = Interface.TimeSinceLogin + 1, removeOnComplete = true })
end

function Actions.SendPrivateMSG(message)

	-- send a note to self in chat
	ChatPrint(message, 16)
end

function Actions.CustomBuff(id, name, cooldown)

	-- initialize the custom buff data
	WindowData.BuffDebuffSystem.CurrentBuffId = 15000 + id
	WindowData.BuffDebuff.TimerSeconds = cooldown
	WindowData.BuffDebuff.HasTimer = true
	WindowData.BuffDebuff.NameVectorSize = 1
	WindowData.BuffDebuff.ToolTipVectorSize = 1
	WindowData.BuffDebuff.IsBeingRemoved = false
	WindowData.BuffDebuff.NameWStringVector = { [1] = name }
	WindowData.BuffDebuff.ToolTipWStringVector = { [1] = L"" }

	-- show the custom buff
	BuffDebuff.ShouldCreateNewBuff()		
end

function Actions.SpellbookCountSpells(id)

	-- do we have a valid ID?
	if not IsValidID(id) then
		return 0
	end

	-- get the spellbook data
	local data = WindowData.Spellbook[id]

	-- do we have the spellbook data?
	if not data then

		-- retrieve the spellbook data
		data = Interface.GetItemSpellbookData(id)
	end

	-- initialize the spells count
	local spells = 0

	-- do we have the spellbook data now?
	if data then

		-- scan all the spells in the book
		for _, spell in pairsByKeys(data.spells) do
		
			-- is the spell enabled?
			if spell == 1 then

				-- increase the spells count
				spells = spells + 1
			end
		end
	end

	-- no spells? maybe we did not get the info...
	if spells == 0 then
		
		-- get the TID params
		local hasspells, params = ItemProperties.DoesItemHasProperty( id, 1042886 )  -- ~1_NUMBERS_OF_SPELLS~ Spells

		-- do we have the property?
		if hasspells then

			-- get the spells number
			spells = tonumber(params[1])
		end
	end

	return spells
end

function Actions.SearchFullSpellbook(bookType)

	-- initialize the spellbooks list
	local spellbooks = {}
	
	-- the backpack items are unavailable?
	if not Interface.BackPackItems then
		Interface.BackPackItems = ContainerWindow.ScanQuantities(ContainerWindow.PlayerBackpack, true)
	end

	-- scan all the items 
	for objectType, hueItems in pairs(Interface.BackPackItems) do

		-- scan all the hue of this object type available
		for hueID, itemIds in pairs(hueItems) do

			-- scan all the item id of this object type & hue
			for itemId, amount in pairs(itemIds) do

				-- is this an item of the right type?
				if (objectType == bookType) then

					-- count the spells in the spellbook
					spellbooks[itemId] = Actions.SpellbookCountSpells(itemId)
				end
			end
		end
	end

	-- did we find any book?
	if table.countElements(spellbooks) <= 0 then

		-- check if we have the book equipped
		local bookId = ContainerWindow.GetEquippedItemIDByType(bookType)
		
		-- did we find the book? (we can only show a spellbook that is equipped if it has already been open)
		if IsValidID(bookId) and Spellbook.OpenSpellbooks[bookId] then

			-- count the spells in the spellbook
			spellbooks[bookId] = Actions.SpellbookCountSpells(bookId)
		end
	end
	
	-- initialize the fullest spellbook id and spell count
	local topId = 0
	local topNum = 0

	-- scan all the spellbooks we have
	for itemId, spells in pairs(spellbooks) do

		-- is the number of spells greater than the one we have?
		if spells > topNum then

			-- pick this as the best spellbook
			topId = itemId
		end
	end
	
	-- did we found a spellbook?
	if IsValidID(topId) then

		-- open the best spellbook
		Actions.OpenSpellbook(topId)

	else -- no spellbook
		ChatPrint(GetStringFromTid(603), SystemData.ChatLogFilters.SYSTEM)
	end
end

function Actions.OpenSpellbook(id)

	-- spellbook window name
	local this = "Spellbook_" .. id
	
	-- is the spellbook already open?
	if not Spellbook.IsSpellbookOpen(id) and not DoesWindowExist(this) then

		-- set the window creation ID to the spellbook ID
		SystemData.DynamicWindowId = id

		-- create the spellbook window
		CreateWindowFromTemplate(this, "Spellbook", "Root")
	end

	-- set the window name and item ID to update
	SystemData.ActiveWindow.name = this
	WindowData.UpdateInstanceId = id

	-- showing the spellbook
	WindowSetShowing(this, true)

	-- trigger the shown event for the spellbook
	Spellbook.OnShown()

	-- update the spells list
	Spellbook.UpdateSpells()
end

function Actions.ChangeSecurity(type)

	-- store the security type to use
	Actions.SecType = type

	-- ask the player to target the item to change security settings
	SendOverheadText(GetStringFromTid(21), OverheadText.CustomMessageHues.LIGHTBLUE)

	-- show the cursor target
	RequestTargetInfo(Actions.ChangeSecurityGetGump)
end

function Actions.ChangeSecurityGetGump(objectId)

	-- do we have a valid item ID?
	if IsValidID(objectId) then

		-- open the security settings gump for the 
		Interface.AddTodoList({name = "change security delayed context call", func = function() ContextMenu.RequestContextAction(objectId, ContextMenu.DefaultValues.SetSecurity) end, time = Interface.TimeSinceLogin + 0.5})
	end
end

function Actions.SetSecurity(gumpID)

	-- get the security type to set
	local secType = Actions.SecType
	
	-- owner
	if secType == "owner" then
		GumpsParsing.PressButton(gumpID, 1)

	-- coowner
	elseif (secType == "coowner") then
		GumpsParsing.PressButton(gumpID, 2)

	-- friend
	elseif (secType == "friend") then
		GumpsParsing.PressButton(gumpID, 3)

	-- guild
	elseif (secType == "guild") then
		GumpsParsing.PressButton(gumpID, 4)

	-- anyone
	elseif (secType == "anyone") then
		GumpsParsing.PressButton(gumpID, 5)


	else -- owner by default
		GumpsParsing.PressButton(gumpID, 1)
	end

	-- remove the stored security type
	Actions.SecType = nil
end

function Actions.RetrieveTarget()
	
	-- ask the player to target the locked down item to retrieve
	SendOverheadText(GetStringFromTid(221), OverheadText.CustomMessageHues.LIGHTBLUE)
	
	-- show the cursor target
	RequestTargetInfo(Actions.RetrieveTargetInfoReceived)
end

function Actions.RetrieveTargetInfoReceived(objectId)

	-- do we have a valid item ID?
	if IsValidID(objectId) then

		-- use the context menu on the item to retrieve it
		ContextMenu.RequestContextAction(objectId, ContextMenu.DefaultValues.Retrieve)
	end
end

function Actions.ToggleItemProperties()

	-- toggle the properties
	Interface.DisableProps = not Interface.DisableProps

	-- save the setting
	Interface.SaveSetting("DisableProps", Interface.DisableProps)

	-- clear the item properties (if there are any active)
	ItemProperties.ClearMouseOverItem()
end

function Actions.Snoop()
	
	-- ask the player to target the mobile
	SendOverheadText(GetStringFromTid(502014), OverheadText.CustomMessageHues.LIGHTBLUE) -- Select the victim
	
	-- show the cursor target
	RequestTargetInfo(Actions.SnoopTarget)
end

function Actions.SnoopTarget(mobileId)

	-- is the target a valid mobile and the mobile has a paperdoll?
	if IsValidID(mobileId) and IsMobile(mobileId) and HasPaperdoll(mobileId) then

		-- get the mobile backpack ID
		local backpack = GetBackpackID(mobileId)

		-- does the mobile has a valid backpack?
		if IsValidID(backpack) then

			-- store the snoop target
			Interface.SnoopTarget = backpack

			-- save the snoop target
			Interface.SaveSetting("SnoopTarget", Interface.SnoopTarget)
		end
	end
end

function Actions.ToggleBookLogging()

	-- toggle the book logging setting
	Interface.Settings.ToggleBookLog = not Interface.Settings.ToggleBookLog

	-- save the book logging setting
	Interface.SaveSetting("ToggleBookLog", Interface.Settings.ToggleBookLog)

	-- show the new book logging status in chat
	ChatPrint(GetStringFromTid(inlineIf(Interface.Settings.ToggleBookLog, 215, 216)), SystemData.ChatLogFilters.SYSTEM)

	-- update the settings window (if visible)
    SettingsWindow.UpdateSettings()
end

function Actions.TargetWeaponType()

	-- is this action in an hotbar?
	if Actions.ActionEditRequest.SubIndex == 0 then
		
		-- remove the action from the hotbar
		Actions.ClearEditingActionSlot()

	else -- the action is in a macro slot

		-- ask the player to target the weapon type
		SendOverheadText(GetStringFromTid(220), OverheadText.CustomMessageHues.LIGHTBLUE)
		
		-- show the cursor target
		RequestTargetInfo(Actions.WeaponRequestTargetInfoReceived)
	end		
end

function Actions.WeaponRequestTargetInfoReceived(objectId)

	-- do we have a valid target?
	if not IsValidID(objectId) then

		-- warn the player the target is invalid
		ChatPrint(GetStringFromTid(1149667), SystemData.ChatLogFilters.SYSTEM) -- Invalid target

		--remove the action from the macro
		Actions.ClearEditingActionSlot()

		-- clear the action edit data
		Actions.ActionEditRequest = {}

		return
	end

	-- get the object type
	local objectType = GetItemType(objectId)

	-- do we have a valid object type?
	if IsValidID(objectType) then

		-- create the command string for the action
		local speechText = L"script Actions.PickBestWeaponByType(" .. objectType .. L", " .. objectId .. L", " .. Actions.ActionEditRequest.HotbarId .. L", " .. Actions.ActionEditRequest.ItemIndex .. L", " .. Actions.ActionEditRequest.SubIndex.. L")"

		-- save the command string
		UserActionSpeechSetText(Actions.ActionEditRequest.HotbarId, Actions.ActionEditRequest.ItemIndex, Actions.ActionEditRequest.SubIndex, speechText)

	else -- invalid type, remove the action from the macro
		Actions.ClearEditingActionSlot()
	end
	
	-- clear the action edit data
	Actions.ActionEditRequest = {}
end

function Actions.IsTalisman(obj)

	-- talismans object types
	return obj == 12120 or obj == 12121 or obj == 12122 or obj == 12123 or obj == 4246
end

function Actions.IsSpellbook(obj)

	-- spellbook object types
	return obj == 3834 or obj == 8787 or obj == 11677 or obj == 11600
end

function Actions.PickBestWeaponGetCompatibleItems(WType)

	-- creating a list of compatible items
	local compatible = {}

	-- the backpack items are unavailable?
	if not Interface.BackPackItems then
		Interface.BackPackItems = ContainerWindow.ScanQuantities(ContainerWindow.PlayerBackpack, true)
	end

	-- scan all the items 
	for objType, hueItems in pairs(Interface.BackPackItems) do
		
		-- is this object type compatible?
		if (objType == WType or (Actions.IsTalisman(WType) and Actions.IsTalisman(objType)) or (Actions.IsSpellbook(WType) and Actions.IsSpellbook(objType))) then

			-- scan all the hue of this object type available
			for hueID, itemIds in pairs(hueItems) do

				-- scan all the item id of this object type & hue
				for id, amount in pairs(itemIds) do

					-- add the item to the compatible list
					table.insert(compatible, id)
				end
			end
		end
	end

	-- get the currently equipped item for the main hand
	local mHand = PaperdollWindow.GetPaperdollSlotID(GetPlayerID(), 4)

	-- do we have a valid item?
	if IsValidID(mHand) then

		-- get the item type
		local objType = GetItemType(mHand)

		-- is the item type compatible with the type we're looking for?
		if objType == WType or (Actions.IsSpellbook(WType) and Actions.IsSpellbook(objType)) then

			-- add the item to the compatible items list
			table.insert(compatible, mHand)
		end
	end

	-- get the currently equipped item for the off-hand
	local oHand = PaperdollWindow.GetPaperdollSlotID(GetPlayerID(), 10)

	-- do we have a valid item?
	if IsValidID(oHand) then

		-- get the item type
		local objType = GetItemType(oHand)

		-- is the item type compatible with the type we're looking for?
		if objType == WType or (Actions.IsSpellbook(WType) and Actions.IsSpellbook(objType)) then

			-- add the item to the compatible items list
			table.insert(compatible, oHand)
		end
	end
	
	-- get the currently equipped talisman
	local talis = PaperdollWindow.GetPaperdollSlotID(GetPlayerID(), 12)

	-- do we have a valid item?
	if IsValidID(talis) or (Actions.IsSpellbook(WType) and Actions.IsSpellbook(objType)) then

		-- get the item type
		local objType = GetItemType(talis)

		-- are we looking for a talisman and we have a talisman equipped in this slot?
		if Actions.IsTalisman(WType) and Actions.IsTalisman(objType) then

			-- add the item to the compatible items list
			table.insert(compatible, talis)
		end
	end

	return compatible
end

function Actions.PickBestWeaponByType(WType, default, hotbar, slot, index)

	-- clear the equip action of the macro
	Actions.ClearEquipAction(hotbar, slot, index + 1)
	
	-- creating a list of compatible items we have available
	local compatible = Actions.PickBestWeaponGetCompatibleItems(WType)

	-- do we have compatible items?
	if #compatible <= 0 then

		-- warn the player that he has no comaptible weapons
		ChatPrint(GetStringFromTid(605), SystemData.ChatLogFilters.SYSTEM) 

		return
	end
	
	-- do we have the current target?
	if not TargetWindow.HasValidTarget() or WindowData.CurrentTarget.TargetType ~= TargetWindow.MobileType then

		-- if there is no target, we equip the default weapon
		UserActionEquipItemsAddItem(hotbar, slot, index + 1, default, WType)

		return
	end

	-- get the mobile info from the currently loaded data
	local mobileInfo = Actions.GetMobileInfo(TargetWindow.TargetId)
	
	-- get the slayers table
	local slayers = mobileInfo.slayers

	-- get the opposite slayers table
	local opposlayers = mobileInfo.oppositeslayers

	-- determine if the creature has a slayer
	local noSlayer = not mobileInfo.slayers or (mobileInfo.slayers and mobileInfo.slayers[1] == L"None")

	-- First we need to check if it's a weapon or a spellbok, then if it's a weapon we need to check the best damage.
		
	-- check if the default is a weapon		
	local gumpType = ItemPropertiesInfo.GetGumpTypeByItemData(default, Interface.GetObjectInfoData(default))
		
	-- is the default item a weapon?
	local isWeapon = gumpType == ItemPropertiesInfo.Types.Ranged_Weapon or gumpType == ItemPropertiesInfo.Types.Weapon
		
	-- we check the objects to find the best match.
	if not isWeapon then  -- SPELLBOOK or TALISMAN
		
		-- get the best spellbook (or talisman) ID	
		local bestBook = Actions.GetCompatibleSpellbook(mobileInfo, WType, default, slayers, opposlayers, noSlayer, compatible)
		
		-- add the spellbook to the equip action
		UserActionEquipItemsAddItem(hotbar, slot, index + 1, bestBook, WType)
			
	else -- WEAPON
		
		-- get the best weapon ID
		local bestWeapon = Actions.GetCompatibleWeapon(mobileInfo, WType, default, slayers, opposlayers, noSlayer, compatible)

		-- add the spellbook to the equip action
		UserActionEquipItemsAddItem(hotbar, slot, index + 1, bestWeapon, WType)
	end
end

function Actions.GetCompatibleSpellbook(mobileInfo, WType, default, slayers, opposlayers, noSlayer, compatible)

	-- if we don't have the mobile info data we can use the default
	if mobileInfo.nodata then
		return default
	end

	-- if there is no slayer, then the default book is the best.
	if noSlayer then
		return default

	else -- we have a slayer

		-- scan all the compatible items
		for _, item in pairsByIndex(compatible) do

			-- get the item properties data for the item
			local data = Interface.GetItemPropertiesData(item, "best spellbook info")

			-- create the properties params array
			local props, count = ItemProperties.BuildParamsArray(data, true)
			
			-- do we have the item properties?
			if not props then
				continue
			end

			-- old slayers conversion
			for tid, _ in pairs(props) do

				-- is this an old slayer?
				if ItemPropertiesInfo.OldSlayerConversion[tid] then

					-- get the new slayer name
					local newTid = ItemPropertiesInfo.OldSlayerConversion[tid]

					-- update the properties
					props[newTid] = props[tid]

					-- remove the old slayer property
					props[tid] = nil
				end
			end

			-- we search for lesser slayers first

			-- scan the slayers
			for _, slayer in pairsByIndex(slayers) do

				-- scan all the know slayers names
				for tid, dt in pairs(ItemPropertiesInfo.Slayers) do

					-- is this the slayer we're looking for? (making sure it's a lesser slayer)
					if not dt.super and dt.stringName == string.lower(tostring(slayer)) then

						-- do we have this slayer in the properties of the item?
						if props[tid] then
							
							-- we found the best match!
							return item
						end
					end
				end
			end
						
			-- scan the slayers
			for _, slayer in pairsByIndex(slayers) do

				-- scan all the know slayers names
				for tid, dt in pairs(ItemPropertiesInfo.Slayers) do
					
					-- is this the slayer we're looking for? (making sure it's a super slayer)
					if dt.super and dt.stringName == string.lower(tostring(slayer)) then
						
						-- do we have this slayer in the properties of the item?
						if props[tid] then
							
							-- we found the best match!
							return item
						end
					end
				end
			end
		end
				
		-- nothing has been found so we equip the default item
		return default
	end
end

function Actions.GetCompatibleWeapon(mobileInfo, WType, default, slayers, opposlayers, noSlayer, compatible)

	-- if we don't have the mobile info data we can use the default
	if mobileInfo.nodata then
		return default
	end

	-- create a new compatible table (to add the one best fitted by damage type)
	local newCompatible = {}
						
	-- do we have no slayer?
	if noSlayer then

		-- we consider all the compatible weapons
		newCompatible = table.copy(compatible)
				
	else -- we have a slayer

		-- scan all the compatible items
		for _, item in pairsByIndex(compatible) do

			-- get the item properties data for the item
			local data = Interface.GetItemPropertiesData(item, "best weapon info")

			-- create the properties params array
			local props, count = ItemProperties.BuildParamsArray(data, true)

			-- do we have the item properties?
			if not props then
				continue
			end

			-- old slayers conversion
			for tid, _ in pairs(props) do

				-- is this an old slayer?
				if ItemPropertiesInfo.OldSlayerConversion[tid] then

					-- get the new slayer name
					local newTid = ItemPropertiesInfo.OldSlayerConversion[tid]

					-- update the properties
					props[newTid] = props[tid]

					-- remove the old slayer property
					props[tid] = nil
				end
			end

			-- flag that indicates that we have found a slayer and we can move to the next item
			local found = false
					
			-- we search for lesser slayers first
			-- scan the slayers
			for _, slayer in pairsByIndex(slayers) do

				-- scan all the know slayers names
				for tid, dt in pairs(ItemPropertiesInfo.Slayers) do

					-- is this the slayer we're looking for? (making sure it's a lesser slayer)
					if not dt.super and dt.stringName == string.lower(tostring(slayer)) then

						-- do we have this slayer in the properties of the item?
						if props[tid] and not table.contains(newCompatible, item) then
										
							-- add the item to the new compatibles list
							table.insert(newCompatible, item)

							-- flag that we have found a slayer
							found = true

							break
						end
					end
				end

				-- if we have found the slayer we can stop searching the slayers
				if found then
					break
				end
			end

			-- if we have found the slayer we can move to the next item
			if found then
				break
			end

			-- scan the slayers
			for _, slayer in pairsByIndex(slayers) do

				-- scan all the know slayers names
				for tid, dt in pairs(ItemPropertiesInfo.Slayers) do

					-- is this the slayer we're looking for? (making sure it's a super slayer)
					if dt.super and dt.stringName == string.lower(tostring(slayer)) then

						-- do we have this slayer in the properties of the item?
						if props[tid] and not table.contains(newCompatible, item) then
											
							-- add the item to the new compatibles list
							table.insert(newCompatible, item)

							-- flag that we have found a slayer
							found = true

							break
						end
					end
				end

				-- if we have found the slayer we can stop searching the slayers
				if found then
					break
				end
			end

			-- if we have found the slayer we can move to the next item
			if found then
				break
			end
						
			-- scan the opposite slayers
			for _, slayer in pairsByIndex(opposlayers) do

				-- scan all the know slayers names
				for tid, dt in pairs(ItemPropertiesInfo.Slayers) do

					-- is this the opposite slayer we're looking for?
					if dt.stringName == string.lower(tostring(slayer)) then

						-- if this item does NOT have the slayer, then it's compatible
						if not props[tid] and not table.contains(newCompatible, item) then
							
							-- add the item to the new compatibles list
							table.insert(newCompatible, item)
						end
					end
				end
			end
		end
					
		-- if we don't find any slayers weapons in the compatible list, then we consider all the compatible items
		if #newCompatible <= 0 then
			newCompatible = table.copy(compatible)
		end
	end

	-- at this point the new compatible list contains either a list of weapons with the slayer property we need
	-- or a list of all the compatible weapons minus the opposite slayers.
			
	-- this table is used to sort the weapons by damage type
	local advanced = {}

	-- scan all the new compatible items
	for _, item in pairsByIndex(newCompatible) do

		-- get the item properties data for the item
		local data = Interface.GetItemPropertiesData(item, "best weapon info")

		-- create the properties params array
		local props, count = ItemProperties.BuildParamsArray(data, true)
		
		-- do we have the item properties?
		if not props then
			continue
		end

		-- get the damage types of the weapon
		local damages = Actions.GetWeaponDamage(props)
				
		-- now we have to get the highest damage type that the weapon has
		local max, typ = Actions.GetHigherDamage(damages)
				
		-- now we list all the weapons per damage type and on each damage type
		-- per each damage type we add 1 weapon per damage % (the highest)
		if not advanced[typ] or advanced[typ].damage < max then
			advanced[typ] = { id = item, damage = max }
		end
	end
			
	-- do we have the list of weapons
	if table.countElements(advanced) > 0 then

		-- at this point we have a list of all the best compatible weapon we can use
		-- so we just need to determine the lowest resistance of the target and get the best weapon based on that
		local min, typ = Actions.GetMinRes(mobileInfo)
				
		-- check if we have the weapon that deals more damage to the target lowest resistance
		if advanced[typ] then
			return advanced[typ].id
					
		else -- in this case we don't have an item that matches the lower resistance of the target, so we just get one randomly from the one we have.

			-- scan all the items
			for dmgType, dt in pairs(advanced) do

				-- pick the first one
				return dt.id
			end
		end
	end

	-- nothing has been found so we equip the default item
	return default
end

function Actions.GetWeaponDamage(props)

	-- do we have the item properties?
	if not props then
		return {}
	end
	
	-- variable that contains the damage types of the weapon
	local damages = {}
				
	-- damages type TID
	local phys = 1060403 -- physical damage
	local fire = 1060405 -- fire damage
	local cold = 1060404 -- cold damage
	local pois = 1060406 -- poison damage
	local ener = 1060407 -- energy damage

	-- make sure there is a value to avoid errors
	props[phys] = inlineIf(not props[phys], { 0, 0 }, props[phys])
	props[fire] = inlineIf(not props[fire], { 0, 0 }, props[fire])
	props[cold] = inlineIf(not props[cold], { 0, 0 }, props[cold])
	props[pois] = inlineIf(not props[pois], { 0, 0 }, props[pois])
	props[ener] = inlineIf(not props[ener], { 0, 0 }, props[ener])

	-- get the damage value
	damages.physical = tonumber(props[phys][1])
	damages.fire = tonumber(props[fire][1])
	damages.cold = tonumber(props[cold][1])
	damages.poison = tonumber(props[pois][1])
	damages.energy = tonumber(props[ener][1])

	return damages
end

function Actions.GetItemResistances(props)

	-- do we have the item properties?
	if not props then
		return {}
	end

	-- scan the refinement resistances
	for t, data in pairs(ItemPropertiesInfo.RefinementsResistProperties) do

		-- does this item has this refinement resistance?
		if props[t] then

			-- convert the refinement into a normal resistance
			props[data.trueTid] = props[t]
		end
	end
	
	-- variable that contains the resistance types of the weapon
	local res = {}
				
	-- resistances type TID
	local phys = 1060448 -- physical resistance
	local fire = 1060447 -- fire resistance
	local cold = 1060445 -- cold resistance
	local pois = 1060449 -- poison resistance
	local ener = 1060446 -- energy resistance
	
	-- make sure there is a value to avoid errors
	props[phys] = inlineIf(not props[phys], { 0, 0 }, props[phys])
	props[fire] = inlineIf(not props[fire], { 0, 0 }, props[fire])
	props[cold] = inlineIf(not props[cold], { 0, 0 }, props[cold])
	props[pois] = inlineIf(not props[pois], { 0, 0 }, props[pois])
	props[ener] = inlineIf(not props[ener], { 0, 0 }, props[ener])

	-- get the resistances value
	res.physical = tonumber(props[phys][1])
	res.fire = tonumber(props[fire][1])
	res.cold = tonumber(props[cold][1])
	res.poison = tonumber(props[pois][1])
	res.energy = tonumber(props[ener][1])

	return res
end

function Actions.GetMinRes(mobileInfo)

	-- start by setting the phisical res as the lowest
	local min = mobileInfo.physical

	-- pick the lowest between physical and fire
	min = math.min(min, mobileInfo.fire)

	-- pick the lowest between the current lowest and cold
	min = math.min(min, mobileInfo.cold)

	-- pick the lowest between the current lowest and poison
	min = math.min(min, mobileInfo.poison)

	-- pick the lowest between the current lowest and energy
	min = math.min(min, mobileInfo.energy)
	
	-- find the lowest resistance name
	local resType = "physical"
	if min == mobileInfo.fire then
		resType = "fire"
	elseif min == mobileInfo.cold then
		resType = "cold"
	elseif min == mobileInfo.poison then
		resType = "poison"
	elseif min == mobileInfo.energy then
		resType = "energy"
	end
	
	return min, resType
end

function Actions.GetHigherDamage(damages)

	-- start by setting the phisical res as the highest
	local max = damages.physical

	-- pick the highest between the current lowest and fire
	max = math.max(max, damages.fire)

	-- pick the highest between the current lowest and cold
	max = math.max(max, damages.cold)

	-- pick the highest between the current lowest and poison
	max = math.max(max, damages.poison)

	-- pick the highest between the current lowest and energy
	max = math.max(max, damages.energy)
	
	-- find the highest damage name
	local dmgType = "physical"
	if max == damages.fire then
		dmgType = "fire"
	elseif max == damages.cold then
		dmgType = "cold"
	elseif max == damages.poison then
		dmgType = "poison"
	elseif max == damages.energy then
		dmgType = "energy"
	end
	
	return max, dmgType
end

function Actions.GetMobileInfo(mobileId)

	-- current mobile record
	local mobileStatus = Interface.ActiveMobilesOnScreen[mobileId]

	-- initialize the creature data
	local creatureData

	-- do we have the mobile status?
	if mobileStatus and mobileStatus.DBName then
	
		-- get the data from the DB
		creatureData = mobileStatus.DBName[1]
	end

	-- do we have the creature data?
	if not creatureData then

		-- try to find the data from the DB
		creatureData = CreaturesDB.FindCompatibleCreatures(mobileId, true)

		-- we use the first record (if available, otherwise it will be nil)
		creatureData = creatureData[1]
	end

	-- initialize the data to be returned
	local info = { physical = 0, fire = 0, cold = 0, poison = 0, energy = 0, slayers = { L"None" }, oppositeslayers = { L"None" }, nodata = true  }
	
	-- does the mobile have a paperdoll and we don't have the data from the DB OR is a player?
	if HasPaperdoll(mobileId) and (not creatureData or IsPlayer(mobileId)) then
	
		-- do we have the paperdoll items properties for the current mobile?
		if not PaperdollWindow.ItemsProps[mobileId] then

			-- open the paperdoll to get the data
			ContextMenu.RequestContextAction(mobileId, ContextMenu.DefaultValues.OpenPaperdoll)

			-- make sure the paperdoll is blocked
			Interface.BlockThisPaperdoll[mobileId] = true

			-- get the paperdoll items properties
			ItemProperties.RegisterPaperdollProperties(mobileId)
		end

		-- do we have the items properties for the mobile? (if not the paperdoll has to be opened manually)
		if PaperdollWindow.ItemsProps[mobileId] then

			-- initializing the paperdoll data
			local paperdollData = Interface.GetPaperdollData(mobileId)

			-- scan all the paperdoll slots
			for index = 1, paperdollData.numSlots do
				
				-- get the stored properties for the current item
				local props = PaperdollWindow.ItemsProps[mobileId][index]

				-- if we don't have the properties there is no item in this slot
				if not props then
					continue
				end

				-- get the resistances for this item
				local itemRes = Actions.GetItemResistances(props)

				-- add the current item resistances to the total
				info.physical = info.physical + itemRes.physical
				info.fire = info.fire + itemRes.fire
				info.cold = info.cold + itemRes.cold
				info.poison = info.poison + itemRes.poison
				info.energy = info.energy + itemRes.energy

				-- remove the NO DATA flag
				info.nodata = nil
			end
		end
	
	-- we have the data from the DB or from animals lore?
	elseif creatureData or AnimalLore.KnownPetsType[mobileId] then
		
		-- do we know the exact resistances for this creatue?
		if AnimalLore.KnownPetsType[mobileId] then

			-- scan the creature stats
			for res, value in pairs(AnimalLore.KnownPetsType[mobileId]) do

				-- make sure the property name is compatible
				res = string.lower(res)

				-- make sure is a resistance, we don't need other stats
				if not info[res] then
					continue
				end

				-- store the stat value in the creature info
				info[res] = value
			end

			-- remove the NO DATA flag
			info.nodata = nil

		-- does the creatuer in this area has different stats?
		elseif (KnownAreas[MapCommon.CurrentArea] and KnownAreas[MapCommon.CurrentArea].SubAreas[MapCommon.CurrentSubArea] and KnownAreas[MapCommon.CurrentArea].SubAreas[MapCommon.CurrentSubArea].LocalStats) then

			-- scan the local stats
			for res, range in pairs(KnownAreas[MapCommon.CurrentArea].SubAreas[MapCommon.CurrentSubArea].LocalStats) do
				
				-- make sure is a resistance, we don't need other stats
				if not info[res] then
					continue
				end

				-- get the min res from the range
				local stat = wstring.sub(range, 1, wstring.find(range, "[-]", 1, true) - 1)

				-- store the stat value in the creature info
				info[res] = tonumber(stat)
			end

			-- remove the NO DATA flag
			info.nodata = nil

		else -- default creature data

			-- scan the creature stats
			for res, data in pairs(creatureData) do

				-- make sure is a resistance, we don't need other stats
				if not info[res] then
					continue
				end

				-- store the stat value in the creature info
				info[res] = data.min
			end

			-- remove the NO DATA flag
			info.nodata = nil
		end

		-- do we have the creature data from the DB?
		if creatureData then
			
			-- store the slayers for the creature (since those are tables they won't be stored properly in the cycle)
			info.slayers = table.copy(creatureData.slayers)
			info.oppositeslayers = table.copy(creatureData.oppositeslayers)
		end
	end

	return info
end

function Actions.GatherSeeds()

	-- is the plant gump closed
	if not (GumpsParsing.ParsedGumps[GenericGump.PLANT_GUMPID] or GumpsParsing.ParsedGumps[GenericGump.PLANT_REPRODUCTION_GUMPID]) then

		-- ask the player to open the plant gump first
		SendOverheadText(GetStringFromTid(225), OverheadText.CustomMessageHues.LIGHTBLUE)

		return
	end

	-- flag to keep gathering
	Actions.GetSeeds = true

	-- is the plant reproduction tab open?
	if not GumpData.Gumps[GenericGump.PLANT_REPRODUCTION_GUMPID] then

		-- press the button to open the reproduction gump
		GumpsParsing.PressButton(GenericGump.PLANT_GUMPID, 1)

	else -- gather the first seed
		GumpsParsing.PressButton(GenericGump.PLANT_REPRODUCTION_GUMPID, 1)
	end
end

function Actions.GatherResources()

	-- is the plant gump closed
	if not (GumpsParsing.ParsedGumps[GenericGump.PLANT_GUMPID] or GumpsParsing.ParsedGumps[GenericGump.PLANT_REPRODUCTION_GUMPID]) then

		-- ask the player to open the plant gump first
		SendOverheadText(GetStringFromTid(225), OverheadText.CustomMessageHues.LIGHTBLUE)

		return
	end

	-- flag to gather resources
	Actions.GetResources = true

	-- is the plant reproduction tab open?
	if not GumpData.Gumps[GenericGump.PLANT_REPRODUCTION_GUMPID] then

		-- press the button to open the reproduction gump
		GumpsParsing.PressButton(GenericGump.PLANT_GUMPID, 1)

	else -- gather the first resource
		GumpsParsing.PressButton(GenericGump.PLANT_REPRODUCTION_GUMPID, 6)
	end
end

Actions.BoatDirections = 
{
	[0] = {name = L"North";};
	[4] = {name = L"South";};
	[2] = {name = L"East"; };
	[6] = {name = L"West"; };
	
	North = 0;
	South = 4;
	East  = 2;
	West  = 6;
}

Actions.BoatCommands = 
{
	BackLeft 		= 	0;
	Back 			= 	1;
	BackRight 		= 	2;
	Right 			= 	3;
	ForwardRight	= 	4;
	Forward 		= 	5;
	ForwardLeft 	= 	6;
	Left 			= 	7;
	
	TurnLeft		= 	8;
	TurnRight		= 	9;
	TurnAround		= 	10;
	
	SlowForward		= 	11;
	ForwardOne		= 	12;
	SlowBack		= 	13;
	BackOne			= 	14;
	
	[0] = L"Backward Left";
	[1] = L"Backwards";
	[2] = L"Backward Right";
	[3] = L"Right";
	[4] = L"Forward Right";
	[5] = L"Forward";
	[6] = L"Forward Left";
	[7] = L"Left";

	[8] = L"Port";
	[9] = L"Starboard";
	[10]= L"Come About";
	
	[11]= L"Slow Forward";
	[12]= L"Forward One";
	[13]= L"Slow Back";
	[14]= L"Back One";
	  
}

Actions.BoatCommandsTids = 
{
	[0] = { nameTid = 1079315; detailTid = 1115169; };
	[1] = { nameTid = 1079317; detailTid = 1115171; };
	[2] = { nameTid = 1079316; detailTid = 1115170; };
	[3] = { nameTid = 1079319; detailTid = 1115173; };
	[4] = { nameTid = 1079314; detailTid = 1115167; };
	[5] = { nameTid = 1079325; detailTid = 1115168; };
	[6] = { nameTid = 1079313; detailTid = 1115166; };
	[7] = { nameTid = 1079318; detailTid = 1115172; };
}

function Actions.GetBoatCommandNameTid(defaultCommand)

	-- are the smart boat commands active and we have the boat direction?
	if Interface.Settings.SmartBoatCommands and Interface.LastBoatDirection then

		-- calculate the boat direction for the requested command
		local dir = (defaultCommand + 1 + Interface.LastBoatDirection) % 8

		-- return the boat command
		return Actions.BoatCommandsTids[dir].nameTid

	else -- if the smart commands are off or we don't have the direction, we return the default command
		return Actions.BoatCommandsTids[defaultCommand].nameTid
	end
end

function Actions.GetBoatCommandDetailTid(defaultCommand)

	-- are the smart boat commands active and we have the boat direction?
	if Interface.Settings.SmartBoatCommands and Interface.LastBoatDirection then

		-- calculate the boat direction for the requested command
		local dir = (defaultCommand + 1 + Interface.LastBoatDirection) % 8

		-- return the boat command
		return Actions.BoatCommandsTids[dir].detailTid

	else -- if the smart commands are off or we don't have the direction, we return the default command
		return Actions.BoatCommandsTids[defaultCommand].detailTid
	end
end

function Actions.BoatCommand(defaultCommand)

	-- are the smart boat commands active and the current command is a direction?
	if Interface.Settings.SmartBoatCommands and defaultCommand < 8 then

		-- get the command direction
		local dir = (defaultCommand + 1 + (Interface.LastBoatDirection or 0) ) % 8

		-- by default we do not specify any speed
		local speed = L""

		-- MAX SPEED: fast + <command>
		if Interface.BoatSpeed == 1 then
			speed = L"Fast "

		-- NORMAL SPEED: <command>
		elseif Interface.BoatSpeed == 0 then
			speed = L""

		-- SLOW SPEED: slow + <command>
		elseif Interface.BoatSpeed == -1 then
			speed = L"Slow "

		-- 1 STEP: one + <command>
		elseif Interface.BoatSpeed == -2 then
			speed = L"One "
		end
		
		-- say the command
		SendChat(ChatSettings.Channels[SystemData.ChatLogFilters.SAY].serverCmd, speed .. Actions.BoatCommands[dir])
		
	-- are the smart boat commands active and this is the speed control?
	elseif Interface.Settings.SmartBoatCommands and defaultCommand == 11 or defaultCommand == 13 then -- speed control
		
		-- SPEED:
		-- 1 	-> fast (not available in game)
		-- 0 	-> normal
		-- -1	-> slow
		-- -2	-> one step at time
		
		-- increase speed
		if defaultCommand == 11 then

			-- is the speed below 0?
			if Interface.BoatSpeed < 0 then

				-- warn the player the speed has been increased
				SendOverheadText(GetStringFromTid(246), OverheadText.CustomMessageHues.LIGHTBLUE)

				-- increase the speed
				Interface.BoatSpeed = Interface.BoatSpeed + 1

			else -- we are at max speed
				SendOverheadText(GetStringFromTid(248), OverheadText.CustomMessageHues.LIGHTBLUE)
			end

		-- decrease speed
		elseif defaultCommand == 13 then -- slow

			-- can we go slower?
			if Interface.BoatSpeed > -2 then

				-- warn the player that the speed has been decreased
				SendOverheadText(GetStringFromTid(247), OverheadText.CustomMessageHues.LIGHTBLUE)

				-- decrease the boat speed
				Interface.BoatSpeed = Interface.BoatSpeed - 1

			else -- we are at min speed
				SendOverheadText(GetStringFromTid(249), OverheadText.CustomMessageHues.LIGHTBLUE)
			end
		end

		-- save the current boat speed
		Interface.SaveSetting("BoatSpeed", Interface.BoatSpeed)

	else -- any other cases, we just say the default boat command
		SendChat(ChatSettings.Channels[SystemData.ChatLogFilters.SAY].serverCmd, Actions.BoatCommands[defaultCommand])
	end
end

function Actions.FixSmartBoatDirections()

	-- is the player on a boat?
	if not PlayerIsOnBoat() then

		-- warn the player that he must be on a boat to do this
		SendOverheadText(GetStringFromTid(245), OverheadText.CustomMessageHues.RED)

		return
	end

	-- determinate the boat direction
	local hasLocation = Actions.GetBoatDirection()

	-- do we have a direction?
	if hasLocation then

		-- create the buttons callback
		local OKButton = { textTid = UO_StandardDialog.TID_OKAY, callback=function() Actions.FixSmartBoatDirectionsStart() end } -- OK
		local cancelButton = { textTid = UO_StandardDialog.TID_CANCEL } -- Cancel

		-- creat the dialog data
		local DestroyConfirmWindow = 
		{
			windowName = "ConfirmBoatDirectionManual",
			titleTid = 243,
			bodyTid  = 244,
			buttons = { OKButton, cancelButton },
			closeCallback = cancelButton.callback,
			destroyDuplicate = true,
		}

		-- show the dialog
		UO_StandardDialog.CreateDialog(DestroyConfirmWindow)

	else -- begin a silent direction detection
		Actions.FixSmartBoatDirectionsStart()
	end
end

function Actions.FixSmartBoatDirectionsStart(silent)

	-- is the direction fix already enabled?
	if Actions.FixSmartBoatDirectionsEnabled then
		return
	end

	-- do we need to do this without messages?
	if not silent then

		-- ask the player to move toward the front of the boat
		SendOverheadText(GetStringFromTid(239), OverheadText.CustomMessageHues.LIGHTBLUE)
	end

	-- store the player location
	Actions.boatStartX = WindowData.PlayerLocation.x
	Actions.boatStartY = WindowData.PlayerLocation.y

	-- flag that we are fixing the boat direction
	Actions.FixSmartBoatDirectionsEnabled = true
end

function Actions.FixSmartBoatDirectionsComplete(silent)

	-- is the boat direction fix disabled?
	if not Actions.FixSmartBoatDirectionsEnabled then
		return
	end

	-- remove the boat direction fix flag
	Actions.FixSmartBoatDirectionsEnabled = nil

	-- get the amount of tiles the player have walked
	local dx = Actions.boatStartX - WindowData.PlayerLocation.x 
	local dy = Actions.boatStartY - WindowData.PlayerLocation.y

	-- if the player didn't move, we do nothing
	if dx == 0 and dy == 0 then

		-- do we need to do this without messages?
		if not silent then

			-- warn the player that he should move to fix the boat direction
			ChatPrint(GetStringFromTid(604), SystemData.ChatLogFilters.SYSTEM)
		end

		return
	end

	-- the player moved along the X axis?
	if dx == 0 then

		-- if the Y is greater then 0 then the player moved north
		if dy > 0 then

			-- store the boat direction
			Interface.LastBoatDirection = Actions.BoatDirections.North

		else -- if the Y is negative, the player moved south

			-- store the boat direction
			Interface.LastBoatDirection = Actions.BoatDirections.South
		end

	else -- the player moved along the Y axis

		-- if the X is greater then 0 then the player moved west
		if dx > 0 then

			-- store the boat direction
			Interface.LastBoatDirection = Actions.BoatDirections.West

		else -- if the X is negative, the player moved east 
			
			-- store the boat direction
			Interface.LastBoatDirection = Actions.BoatDirections.East
		end
	end

	-- save the new boat direction
	Interface.SaveSetting("LastBoatDirection", Interface.LastBoatDirection)

	-- fix the actions list
	ActionsWindow.InitActionData()

	-- do we need to do this without messages?
	if not silent then
		
		-- tell the player what direction we detected
		SendOverheadText(ReplaceTokens(GetStringFromTid(240), { Actions.BoatDirections[Interface.LastBoatDirection].name }), OverheadText.CustomMessageHues.LIGHTBLUE)
	end
end

function Actions.GetBoatDirection()

	-- do we have the boat direction?
	if Interface.LastBoatDirection then

		-- tell the player the current boat direction
		SendOverheadText(ReplaceTokens(GetStringFromTid(241), { Actions.BoatDirections[Interface.LastBoatDirection].name }), OverheadText.CustomMessageHues.LIGHTBLUE)

		return true

	else -- tell the player we don't know the current boat direction
		SendOverheadText(GetStringFromTid(242), OverheadText.CustomMessageHues.LIGHTBLUE)

		return false
	end
end

function Actions.EquipLast(slots, hotbar, slot, index)
	
	-- clear the equip action
	Actions.ClearEquipAction(hotbar, slot, index + 1)
	
	-- scan all the slots we want to re-equip
	for _, slotID in pairsByIndex(slots) do

		-- get the last unequipped item from this slot
		local item = Interface.UnequipItems[slotID]

		-- do we have a valid item?
		if IsValidID(Interface.UnequipItems[item]) then

			-- get the unequipped object type
			local objectType = GetItemType(item)

			-- do we have a valid object type?
			if IsValidID(objectType) then

				-- add the item to the equip action
				UserActionEquipItemsAddItem(hotbar, slot, index + 1, item, objectType)
			end
		end
	end
end

function Actions.NearestSoS()

	-- do we have any SOS available?
	if not Interface.SOSWaypoints then

		-- warn the player that there are no SOS in this facet
		SendOverheadText(GetStringFromTid(265), OverheadText.CustomMessageHues.RED)

		return
	end

	-- initialize the nearest sos variables
	local nearestId
	local nearestDist

	-- scan all the SOS
	for sosId, wpData in pairs(Interface.SOSWaypoints) do

		-- is this SOS in the right facet?
		if wpData.facet ~= WindowData.PlayerLocation.facet then
			continue
		end

		-- get the X locations of the player and the SOS
		local x1 = math.min(wpData.x, WindowData.PlayerLocation.x)
		local x2 = math.max(wpData.x, WindowData.PlayerLocation.x)
		
		-- get the Y locations of the player and the SOS
		local y1 = math.min(wpData.y, WindowData.PlayerLocation.y)
		local y2 = math.max(wpData.y, WindowData.PlayerLocation.y)
		
		-- calculate the distance between 2 points
		local dist = math.sqrt(math.pow(x2 - x1, 2) + math.pow(y2 - y1, 2))

		-- is this the closest we have found or is the first?
		if not nearestDist or dist < nearestDist then

			-- store this SOS distance and ID
			nearestDist = dist
			nearestId = sosId
		end
	end

	-- do we have a closest SOS?
	if nearestId then

		-- get the SOS waypoint data
		local wp = Interface.SOSWaypoints[nearestId]

		-- magnetize the compass
		MapWindow.MagnetizeLocation(wp.x, wp.y, wp.facet, nearestId)

	else -- there are no SOS in this map
		SendOverheadText(GetStringFromTid(265), OverheadText.CustomMessageHues.RED)
	end
end

function Actions.NearestTmap()

	-- do we have any tmap available?
	if not Interface.TmapWaypoints then

		-- warn the player that there are no tmap in this facet
		SendOverheadText(GetStringFromTid(580), OverheadText.CustomMessageHues.RED)

		return
	end

	-- initialize the nearest tmap variables
	local nearestId
	local nearestDist

	-- scan all the SOS
	for itemId, wpData in pairs(Interface.TmapWaypoints) do

		-- is this SOS in the right facet?
		if wpData.facet ~= WindowData.PlayerLocation.facet then
			continue
		end

		-- get the X locations of the player and the tmap
		local x1 = math.min(wpData.x, WindowData.PlayerLocation.x)
		local x2 = math.max(wpData.x, WindowData.PlayerLocation.x)
		
		-- get the Y locations of the player and the tmap
		local y1 = math.min(wpData.y, WindowData.PlayerLocation.y)
		local y2 = math.max(wpData.y, WindowData.PlayerLocation.y)
		
		-- calculate the distance between 2 points
		local dist = math.sqrt(math.pow(x2 - x1, 2) + math.pow(y2 - y1, 2))

		-- is this the closest we have found or is the first?
		if not nearestDist or dist < nearestDist then

			-- store this tmap distance and ID
			nearestDist = dist
			nearestId = itemId
		end
	end

	-- do we have a closest tmap?
	if nearestId then

		-- get the tmap waypoint data
		local wp = Interface.TmapWaypoints[nearestId]

		-- magnetize the compass
		MapWindow.MagnetizeLocation(wp.x, wp.y, wp.facet, nearestId)

	else -- there are no tmaps in this map
		SendOverheadText(GetStringFromTid(580), OverheadText.CustomMessageHues.RED)
	end
end

function Actions.ToggleItemPreview()

	-- is the item preview window alrady available?
	if not DoesWindowExist("ItemPreviewGrid") then
		CreateWindow("ItemPreviewGrid", false)
	end

	-- toggle the window visibility
	WindowSetShowing("ItemPreviewGrid", not WindowGetShowing("ItemPreviewGrid"))
end

function Actions.ClearEditingActionSlot()
	
	-- is this an hotbar slot?
	if Actions.ActionEditRequest.SubIndex == 0 then

		-- hotbar slot window name
		local slotWindow = "Hotbar" .. Actions.ActionEditRequest.HotbarId .. "Button" .. Actions.ActionEditRequest.ItemIndex

		-- remove the action from the hotbar
		HotbarSystem.ClearActionIcon(slotWindow, Actions.ActionEditRequest.HotbarId, Actions.ActionEditRequest.ItemIndex, Actions.ActionEditRequest.SubIndex)

		-- clear the slot 
		HotbarClearItem(Actions.ActionEditRequest.HotbarId, Actions.ActionEditRequest.ItemIndex)

	else -- macro slot

		-- clear the macro slot
		UserActionMacroRemoveAction(Actions.ActionEditRequest.HotbarId, Actions.ActionEditRequest.ItemIndex, Actions.ActionEditRequest.SubIndex)

		-- update the macro actions list
		MacroEditWindow.UpdateMacroActionList("ActionEditMacro", Actions.ActionEditRequest.HotbarId, Actions.ActionEditRequest.ItemIndex)
	end
end

function Actions.ClearEquipAction(hotbar, slot, index)

	-- get the equip action items count
	local numItems = UserActionEquipItemsGetNumItems(hotbar, slot, index)

	-- scan all the items in the equip action
	for i = 1, numItems do

		-- get the object ID
		local objectId = UserActionEquipItemsGetItem(hotbar, slot, index, i - 1)

		-- do we have a valid object ID?
		if IsValidID(objectId) then

			-- remove the object
			UserActionEquipItemsRemoveItem(hotbar, slot, index, objectId)
		end
	end
end

Actions.DisabledReasons = 
{
	[1155432] = { 6002, 6003, 6004, 6005, 6006, 6009, 6010 }, -- Use a crafting tool first!
	[1155370] = { 6000, 6001, 6007, 6008 }, -- Use the imbuing skill first!
	[1155382] = { 6002 }, -- You cannot alter anything with this tool.
	[1155383] = { 6003 }, -- You cannot enhance anything with this tool.
	[1155433] = { 6004 }, -- You cannot repair anything with this tool!
	[1155175] = { 6200 }, -- You cannot get your own healthbar, you have the status bar!
	[597] = { 11, 20, 67, 6200, 6203 }, -- requires a current target
	[588] = { 5210 }, -- requires an updated items list
	[598] = { 5736, 5737, 5738 }, -- requires the player to drag an object
	[599] = { 5209 }, -- requires the boss bar to be active
	[1060169] = { 5951, 5952, 5953, 5954, 5955, 5956, 5957, 8, 9, 10, 86, 87, 14, 67, 68, 29, 30, 31, 32, 33, 34, 35, 36, 5120, 5121, 5122, 5123, 4137, 4139, 5733, 5733, 5736, 5737, 5738, 5950 }, -- You cannot use this ability while dead.
	[601] = { 29, 30, 31, 32, 33, 34, 35, 36, 5123 }, -- no pets in sight
	[225] = { 5959, 5960 }, -- requires the plant gump
	[19] =  { 5750 }, -- requires the moongate gump
	[245] = { 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 5150, 5151, 5152, 5153, 5154, 5155 }, -- get on a boat first
}

function Actions.IsActionEnabled(actionId, actionType, hotbarId, itemIndex)
	
	-- we get the stored target id
	local objID = UserActionGetTargetId(hotbarId, itemIndex, 0)

	-- does this action requires the crafing gump?
	if table.contains(Actions.DisabledReasons[1155432], actionId) and not GumpsParsing.ParsedGumps[GenericGump.CRAFTING_GUMPID] then
		return false, 1155432 -- Use a crafting tool first!

	-- does this action requires the imbuing gump?
	elseif table.contains(Actions.DisabledReasons[1155370], actionId) and not GumpsParsing.ParsedGumps[GenericGump.IMBUING_GUMPID] then
		return false, 1155370 -- Use the imbuing skill first!

	-- does this action requires a tool with the enhance button?
	elseif table.contains(Actions.DisabledReasons[1155383], actionId) then

		-- none of this tools support enhance
		if	GumpsParsing.ParsedGumps[GenericGump.CRAFTING_GUMPID] == "AlchemyMenu" or
			GumpsParsing.ParsedGumps[GenericGump.CRAFTING_GUMPID] == "CookingMenu" or
			GumpsParsing.ParsedGumps[GenericGump.CRAFTING_GUMPID] == "CartographyMenu" or
			GumpsParsing.ParsedGumps[GenericGump.CRAFTING_GUMPID] == "InscriptionMenu" or
			GumpsParsing.ParsedGumps[GenericGump.CRAFTING_GUMPID] == "GlassblowingMenu"
		then
			return false, 1155383 -- You cannot enhance anything with this tool.
		end

	-- does this action requires a tool with the alter button?
	elseif table.contains(Actions.DisabledReasons[1155382], actionId) then

		-- none of this tools support alter
		if	GumpsParsing.ParsedGumps[GenericGump.CRAFTING_GUMPID] == "AlchemyMenu" or
			GumpsParsing.ParsedGumps[GenericGump.CRAFTING_GUMPID] == "CookingMenu" or
			GumpsParsing.ParsedGumps[GenericGump.CRAFTING_GUMPID] == "BowcraftMenu" or
			GumpsParsing.ParsedGumps[GenericGump.CRAFTING_GUMPID] == "CartographyMenu" or
			GumpsParsing.ParsedGumps[GenericGump.CRAFTING_GUMPID] == "InscriptionMenu" or
			GumpsParsing.ParsedGumps[GenericGump.CRAFTING_GUMPID] == "MasonryMenu" or
			GumpsParsing.ParsedGumps[GenericGump.CRAFTING_GUMPID] == "GlassblowingMenu"
		then
			return false, 1155382 -- You cannot alter anything with this tool.
		end

	-- does this action requires a tool with the repair button?
	elseif table.contains(Actions.DisabledReasons[1155433], actionId) then

		-- none of this tools support repair
		if	GumpsParsing.ParsedGumps[GenericGump.CRAFTING_GUMPID] == "AlchemyMenu" or
			GumpsParsing.ParsedGumps[GenericGump.CRAFTING_GUMPID] == "CookingMenu" or
			GumpsParsing.ParsedGumps[GenericGump.CRAFTING_GUMPID] == "CartographyMenu" or
			GumpsParsing.ParsedGumps[GenericGump.CRAFTING_GUMPID] == "InscriptionMenu"
		then
			return false, 1155433 -- You cannot repair anything with this tool!
		end

	-- does this action requires a current target?
	elseif table.contains(Actions.DisabledReasons[597], actionId) and not TargetWindow.HasValidTarget() then
		return false, 597 -- requires a current target

	-- does this action requires a current target that is not the player?
	elseif table.contains(Actions.DisabledReasons[1155175], actionId) and TargetWindow.TargetId == GetPlayerID() then
		return false, 1155175 -- You cannot get your own healthbar, you have the status bar!

	-- does this action requires an updated items list?
	elseif table.contains(Actions.DisabledReasons[588], actionId) and Interface.ActiveItemsTimeFromLastUpdate > 10 then
		return false, 588 -- requires an updated items list

	-- does this action requires the player to drag an object?
	elseif table.contains(Actions.DisabledReasons[598], actionId) and SystemData.DragItem.DragType ~= SystemData.DragItem.TYPE_ITEM then
		return false, 598 -- requires the player to drag an object

	-- does this action requires the boss bar to be active?
	elseif table.contains(Actions.DisabledReasons[599], actionId) and not IsValidID(BossBar.GetActiveBoss()) then
		return false, 599 -- requires the boss bar to be active

	-- does this action requires the player to be on a boat?
	elseif table.contains(Actions.DisabledReasons[245], actionId) and not PlayerIsOnBoat() then
		return false, 245 -- get on a boat first

	-- does this action requires the plant gump?
	elseif table.contains(Actions.DisabledReasons[225], actionId) and not (GumpsParsing.ParsedGumps[GenericGump.PLANT_GUMPID] or GumpsParsing.ParsedGumps[GenericGump.PLANT_REPRODUCTION_GUMPID]) then
		return false, 225 -- requires the plant gump

	-- does this action requires the moongate gump?
	elseif table.contains(Actions.DisabledReasons[19], actionId) and not GumpsParsing.ParsedGumps[Moongate.GumpId] then
		return false, 19 -- requires the moongate gump

	-- this action cannot be used while dead?
	elseif (actionType == SystemData.UserAction.TYPE_EQUIP_ITEMS or 
			actionType == SystemData.UserAction.TYPE_EQUIP_LAST_WEAPON or 
			actionType == SystemData.UserAction.TYPE_UNEQUIP_ITEMS or 
			actionType == SystemData.UserAction.TYPE_ARM_DISARM or 
			table.contains(Actions.DisabledReasons[1060169], actionId)) and 
			Interface.IsPlayerDead 
	then
		return false, 1060169 -- You cannot use this ability while dead.

	-- does this action requires pets in sight?
	elseif table.contains(Actions.DisabledReasons[601], actionId) and GetControllableFollowersCount() <= 0 then
		return false, 601 -- You cannot use this ability while dead.

	-- is this a stored target action but there is no stored target?
	elseif actionType == SystemData.UserAction.TYPE_TARGET_BY_OBJECT_ID and not IsValidID(objID) then
		return false, 600 -- no stored target

	-- to dismount you need to be mounted
	elseif actionType == SystemData.UserAction.TYPE_DISMOUNT and not IsRiding(true) then
		return false, 602 -- not mounted
	end
	
	return true
end