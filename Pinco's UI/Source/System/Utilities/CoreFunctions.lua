
function IsPlayerDead()
	
	-- get the player data
	local mobileData = Interface.GetMobileData(GetPlayerID())

	-- get the player status data
	local statusData = Interface.GetPlayerStatusData()

	-- do we ahve the data?
	if not mobileData then
		return false
	end
	
	-- if the player health is greater than 0, then he's not dead
	if statusData.CurrentHealth > 0 then
		return false
	end

	return mobileData.IsDead == true
end

function IsContainer(id)

	-- is this a valid ID?
	if not IsValidID(id) then
		return false
	end

	-- is this a mobile?
	if IsMobile(id) then

		-- is this a pet?
		if IsObjectIdPet(id) then

			-- get the pet backpack id
			local backpackId = GetBackpackID(id)

			-- do we have a valid ID?
			if IsValidID(backpackId) then
				return true
			end

			return false
		end

		return false
	end
	
	-- do we have the container informations?
	if not ContainersInfo.IsValidContainer(id) then
		return false

	else
		return true
	end
end

function GetPlayerBankID()

	-- do we have the player bank ID?
	if IsValidObject(ContainerWindow.PlayerBank) then
		return ContainerWindow.PlayerBank
	end
	
	-- default value is 0
	local bank = 0

	-- load the bank slot for the player
	local equipData = Interface.GetPlayerEquipmentData(EquipmentData.EQPOS_BANK)

	-- do we have the slot data?
	if equipData then

		-- get the slot object ID
		bank = equipData.objectId

		-- store the bank ID
		ContainerWindow.PlayerBank = bank
	end

	return bank
end

function GetBackpackID(mobileId)

	-- is this a valid ID?
	if not IsValidID(mobileId) then
		return 0
	end

	-- is this the player ID?
	if mobileId == GetPlayerID() then

		-- do we have the player backpack ID yet?
		if IsValidObject(ContainerWindow.PlayerBackpack) then
			return ContainerWindow.PlayerBackpack
		end

		-- load the backpack slot for the player
		local equipData = Interface.GetPlayerEquipmentData(EquipmentData.EQPOS_BACKPACK)

		-- do we have the slot data?
		if equipData then

			-- get the slot object ID
			return equipData.objectId
		end

		-- do we have a valid backpack ID?
		if not IsValidID(backpack) then

			-- get the paperdoll data
			local paperdollData = Interface.GetPaperdollData(mobileId)

			-- do we have the paperdoll data?
			if paperdollData then

				-- get the backpack ID from the paperdoll
				return paperdollData.backpackId
			end
		end

	else -- any other mobile
		
		-- get the paperdoll data
		local paperdollData = Interface.GetPaperdollData(mobileId)

		-- do we have the paperdoll data?
		if paperdollData then

			-- get the backpack ID from the paperdoll
			return paperdollData.backpackId
		end
	end

	return 0
end

function IsCorpse(id, info)
	
	-- do we have a valid ID?
	if not IsValidID(id) then
		return false
	end

	-- get the container data
	local contData = Interface.GetContainersData(id)
	
	-- do we have the container data?
	if not contData then
		return false

	else -- we have the container data
		
		-- get the container name
		local itemName = wstring.lower(contData.containerName)

		-- check if we have a valid container name and is not a corpse
		if IsValidWString(itemName) and not contData.isCorpse then
			
			-- add a space at the end of the name to make the match work properly
			itemName = itemName .. L" "

			-- default corpse string
			local wstr = L"corpse"
			
			-- change the string based on the language (using Orc Corpse from the cliloc as base)
			if SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_JPN and not SystemData.Settings.Language.englishNames then
				wstr = wstring.sub(GetStringFromTid(1035717), -3)
			elseif SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_CHINESE_TRADITIONAL and not SystemData.Settings.Language.englishNames then
				wstr = wstring.sub(GetStringFromTid(1035717), -2)
			elseif SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_KOR and not SystemData.Settings.Language.englishNames then
				wstr = wstring.sub(GetStringFromTid(1035717), -4)
			end

			-- add the pattern to the string to search
			wstr = L"%W" .. wstr .. L"%W"

			-- is the string inside the item name?
			if wstring.match(itemName, wstr) then

				-- fix the flag on the container data
				WindowData.ContainerWindow[id].isCorpse = true
			end
		end

		return contData.isCorpse
	end
end

function IsVendor(mobileId)

	-- do we have a valid mobile ID?
	if not IsValidID(mobileId) then
		return false
	end

	-- is this a player pet or the player character?
	if IsObjectIdPet(mobileId) or mobileId == GetPlayerID() then
		return false
	end

	-- is the mobile invulnerable?
	if not IsMobileInvulnerable(mobileId) then
		return false
	end

	-- get the object info
	local itemData = Interface.GetObjectInfoData(mobileId)

	-- do we have the object info?
	if not itemData then
		return false
	end

	return itemData and itemData.sellContainerId ~= nil
end

function IsPlayerVendor(mobileId)

	-- do we have a valid mobile ID?
	if not IsValidID(mobileId) then
		return false
	end

	-- is this a player pet or the player character?
	if IsObjectIdPet(mobileId) or mobileId == GetPlayerID() then
		return false
	end

	-- is the mobile invulnerable?
	if not IsMobileInvulnerable(mobileId) then
		return false
	end

	-- get the shop name properties, if we have it, it's a player vendor
	local prop = ItemProperties.GetObjectPropertiesParamsForTid(mobileId, 1062449, "is player vendor?") -- Shop Name: ~1_NAME~
	
	return prop ~= nil
end

function IsBodDealer(mobileId, skillCheck)
	
	-- make sure the interface has been initialized first
	if not CreaturesDB.NPCProfession then
		return
	end

	-- do we have a valid mobile ID?
	if not IsValidID(mobileId) then
		return false
	end

	-- is this a player pet or the player character?
	if IsObjectIdPet(mobileId) or mobileId == GetPlayerID() then
		return false
	end

	-- is the mobile invulnerable?
	if not IsMobileInvulnerable(mobileId) then
		return false
	end

	-- by default we check if the player has the crafting skill to get the bod
	if skillCheck == nil then
		skillCheck = true
	end

	-- get the mobile name
	local mobileName = GetMobileName(mobileId)

	-- NON BOD dealers with profession title
	if CreaturesDB.NPCNameFakeProfession[mobileName] then
		return false
	end

	-- named bod dealers
	if CreaturesDB.NPCNameProfession[mobileName] then

		-- if we don't have to check the skill then we've found the answer...
		if not skillCheck then
			return true
		end

		-- if the player has the skill 0.1 or greater he can get bods from this NPC.
		return GetSkillValue(CreaturesDB.NPCNameProfession[mobileName], false) > 0
	end

	-- get th mobile title
	local title = GetNameTitle(mobileName)
	
	-- do we have a valid title?
	if IsValidWString(title) then
		
		-- get the skill ID for the NPC title
		local skillID = CreaturesDB.NPCProfession[title]

		-- do we have a skill ID?
		if skillID then
				
			-- blacksmith guildmasters and instructors of new haven don't give bods for unknown reasons...
			if skillID == SkillsWindow.SkillsID.BLACKSMITH and (wstring.find(title, L"Guildmaster", 1, true) or wstring.find(title, L"Guildmistress", 1, true) or wstring.find(title, L"Instructor", 1, true)) and MapCommon.CurrentArea == "New Haven" then
				return false
			end

			-- cook, blacksmith, cooking and tailor in ter mur has no bods
			if (skillID == SkillsWindow.SkillsID.BLACKSMITH or skillID == SkillsWindow.SkillsID.TAILORING or skillID == SkillsWindow.SkillsID.COOKING) and MapCommon.CurrentArea == "Royal City" then
				return false
			end

			-- if we don't have to check the skill then we've found the answer...
			if not skillCheck then
				return true
			end

			-- if the player has the skill 0.1 or greater he can get bods from this NPC.
			return GetSkillValue(skillID, false) > 0
		end
	end

	return false
end

function IsQuestGiver(mobileId)

	-- do we have a valid mobile ID?
	if not IsValidID(mobileId) then
		return false
	end

	-- is this a player pet or the player character?
	if IsObjectIdPet(mobileId) or mobileId == GetPlayerID() then
		return false
	end

	-- is the mobile an old quest giver?
	if IsOldQuestGiver(mobileId) then
		return true
	end

	-- if it's a vendor is definitely not a player
	if IsPlayerVendor(mobileId) then
		return false
	end

	-- get the mobile name (lower caption)
	local name = wstring.lower(GetMobileName(mobileId))

	-- do we have a valid mobile name?
	if not IsValidWString(name) then
		return false
	end

	-- scan the waypoint for the mobile name
	for waypointId = 1, WindowData.WaypointList.waypointCount do	
		--, , WindowData.PlayerLocation.z
		-- get the waypoint data
		local wtype, wflags, wname, wfacet, wx, wy, wz = UOGetWaypointInfo(waypointId) 

		-- the quest givers waypoints are the type 4, so if it's not of that type we can skip to the next
		if wtype ~= 4 then
			continue
		end

		-- is the waypoint in another facet?
		if WindowData.PlayerLocation.facet ~= wfacet then
			continue
		end

		-- get the distance between the player and the waypoint
		local distance = GetDistanceBetweenPoints(wx, wy, WindowData.PlayerLocation.x, WindowData.PlayerLocation.y)
	
		-- is the waypoint way ouf ot screen?
		if distance > 30 then
			continue
		end

		-- remove the quotes from the name and make it lower caption
		wname = wstring.lower(wstring.sub(wname, 2, wstring.len(wname) -1))

		-- is the mobile the same of the one on the waypoint?
		if name == wname then
			return true
		end
	end
end

function IsOldQuestGiver(mobileId)

	-- do we have a valid mobile ID?
	if not IsValidID(mobileId) then
		return false
	end

	-- is this a player pet or the player character?
	if IsObjectIdPet(mobileId) or mobileId == GetPlayerID() then
		return false
	end

	-- is the mobile invulnerable?
	if not IsMobileInvulnerable(mobileId) then
		return false
	end

	-- get the mobile name (lower caption)
	local name = wstring.lower(GetMobileName(mobileId))

	-- do we have a valid name?
	if not IsValidWString(name) then
		return false
	end

	-- get th mobile title
	local title = wstring.lower(GetNameTitle(name))

	-- scan the old quest givers list
	for npcName, _ in pairs(CreaturesDB.Names.OldQuestGivers) do

		-- does the npc name or the title match the one on the list?
		if npcName == name or title == npcName then
			return true
		end
	end

	return false
end

function IsBanker(mobileId)

	-- do we have a valid mobile ID?
	if not IsValidID(mobileId) then
		return false
	end

	-- is this a player pet or the player character?
	if IsObjectIdPet(mobileId) or mobileId == GetPlayerID() then
		return false
	end

	-- is the mobile invulnerable?
	if not IsMobileInvulnerable(mobileId) then
		return false
	end

	-- get th mobile title
	local title = GetNameTitle(GetMobileName(mobileId))

	-- is the title a banker title?
	return CreaturesDB.BankersTitle[title] ~= nil
end

function IsPartyMember(mobileId)

	-- do we have a valid mobile ID?
	if not IsValidID(mobileId) then
		return false, 0
	end

	-- do we have the party members array?
	if not WindowData.PartyMember then
		return false, 0
	end

	-- is this the player character? we consider the player a party member only if the status is the party status
	if mobileId == GetPlayerID() then
		return Interface.Settings.StatusWindowStyle == 4, 0
	end

	-- is the mobile a pet?
	if IsObjectIdPet(mobileId) then
		return false, 0
	end

	-- is there a party leader? if not we're not in party
	if not IsValidID(WindowData.PartyMember.partyLeaderId) then
		return false, 0
	end

	-- is the mobile invulnerable?
	if IsMobileInvulnerable(mobileId) then
		return false, 0
	end

	-- scan all party members
	for i, member in pairsByIndex(WindowData.PartyMember) do

		-- get the member mobile ID
		local memberId = member.memberId

		-- is this the party member we're looking for?
		if IsValidID(memberId) and mobileId == memberId then
			return true, i
		end
	end

	return false, 0
end

function IsTamable(mobileId)
	
	-- do we have a valid mobile ID?
	if not IsValidID(mobileId) then
		return false
	end

	-- do we already know if this mobile is tamable?
	if TargetWindow.KnownTamable[mobileId] ~= nil then
		return TargetWindow.KnownTamable[mobileId]
	end

	-- is this a player pet or the player character?
	if IsObjectIdPet(mobileId) or mobileId == GetPlayerID() then
		TargetWindow.KnownTamable[mobileId] = false
		return false
	end

	-- is the mobile invulnerable?
	if IsMobileInvulnerable(mobileId) then
		TargetWindow.KnownTamable[mobileId] = false
		return false
	end

	-- is this someone else pet?
	if IsSomeonePet(mobileId) then
		TargetWindow.KnownTamable[mobileId] = false
		return false
	end

	-- get the mobile name
	local name = GetMobileType(mobileId)

	-- is the mobile inside the creatures DB?
	if CreaturesDB[name] then

		-- check if the mobile is flagged as tamable in the DB
		TargetWindow.KnownTamable[mobileId] = CreaturesDB[name].tamable

		return CreaturesDB[name].tamable

	else -- worst case scenario: we have to open the context menu and see if it has the "Tame" option
		
		-- open the context menu and determine if it has the tame option
		RequestContextMenu(mobileId, false)

		-- return what we know (hopefully the menu has already opened and we got the data)
		return TargetWindow.KnownTamable[mobileId] 
	end
end

function IsPlayer(mobileId)
	
	-- do we have a valid mobile ID?
	if not IsValidID(mobileId) then
		return false
	end

	-- already parsed, we return what we know
	if TargetWindow.KnownPlayers[mobileId] ~= nil then
		return TargetWindow.KnownPlayers[mobileId]
	end

	-- if it's not a mobile or is the player is a big NO
	if not IsMobile(mobileId) or mobileId == GetPlayerID() then
		TargetWindow.KnownPlayers[mobileId] = false
		return false
	end

	-- a pet is not a player
	if IsObjectIdPet(mobileId) then
		return false
	end

	-- if it's a party member then is a player for sure
	if IsPartyMember(mobileId) then
		return true
	end

	-- is the mobile invulnerable?
	if IsMobileInvulnerable(mobileId) then
		return false
	end
	
	-- no paperdoll? it's not a player
	if not HasPaperdoll(mobileId) then
		TargetWindow.KnownPlayers[mobileId] = false
		return false
	end

	-- get the mobile notoriety
	local noto = GetMobileNotoriety(mobileId)

	-- the can attack notoriety (much like the invulnerable), is only for npcs
	if  noto == NameColor.Notoriety.CANATTACK then
		TargetWindow.KnownPlayers[mobileId] = false
		return false
	end

	-- if it's not a siege rules shard and the mobile is a murderer (red) and we are not in felucca, then it's not a player
	if not Interface.SiegeRules and noto == NameColor.Notoriety.MURDERER and WindowData.PlayerLocation.facet ~= 0 then
		TargetWindow.KnownPlayers[mobileId] = false
		return false
	end

	-- if it's a vendor, a quest giver or a banker is definitely not a player
	if IsVendor(mobileId) or IsPlayerVendor(mobileId) or IsQuestGiver(mobileId) or IsBanker(mobileId) then
		TargetWindow.KnownPlayers[mobileId] = false
		return false
	end

	-- get th mobile name
	local name = GetMobileName(mobileId)

	-- get th mobile title
	local title = GetNameTitle(name)

	-- do we have a valid title? (the title parsing is VERY unreliable since a player can call himself "Myrmidex" and it will be marked as not a player...)
	if IsValidWString(title) then

		-- scan the npc titles list
		for npcTitle, _ in pairs(CreaturesDB.NPCTitles) do
			
			-- does the name contains the title?
			if wstring.find(name, title, 1, true) then

				-- mark the player as NOT a player
				TargetWindow.KnownPlayers[mobileId] = false

				return false
			end
		end
	end

	-- if the name is inside the creatures DB then it's not a player (probably)
	local CreaturesDBName = GetMobileType(WindowData.CurrentTarget.TargetId)
	if CreaturesDB[CreaturesDBName] then
		TargetWindow.KnownPlayers[mobileId] = false
		return false
	end
	
	-- if we got here, we can only assume it IS a player...
	TargetWindow.KnownPlayers[mobileId] = true
	return true
end

function IsMobileVisible(mobileId)

	-- do we have a valid mobile ID?
	if not IsValidID(mobileId) then
		return false
	end

	-- get the distance from player
	local dist = GetDistanceFromPlayer(mobileId)

	-- if the distance is less than 0 the mobile is bugged so we mark it as invisible
	if dist < 0 then
		return false
	end

	-- the visible distance is between 0 and 25 tiles away
	return dist >= 0 and dist < 25
end

function IsMobilePoisoned(mobileId)

	-- do we have a valid mobile ID?
	if not IsValidID(mobileId) then
		return false
	end

	-- get the mobile state
	local mobileState = WindowData.HealthBarColor[mobileId]

	-- do we have a valid mobile state?
	if not mobileState then
		return false
	end

	return mobileState.VisualStateId == HealthBarColor.HealthVisualState.Poison
end

function IsMobileMortalStriked(mobileId)

	-- do we have a valid mobile ID?
	if not IsValidID(mobileId) then
		return false
	end

	-- get the mobile state
	local mobileState = WindowData.HealthBarColor[mobileId]

	-- do we have a valid mobile state?
	if not mobileState then
		return false
	end

	return mobileState.VisualStateId == HealthBarColor.HealthVisualState.Cursed
end

function PlayerIsOnBoat()

	-- get the current player area
	local area = MapCommon.CurrentArea

	-- get the current player sub-area
	local subarea = MapCommon.CurrentSubArea

	-- is the player on a bridge?
	local bridge = (subarea and subarea == "Bridges") or area == "Bridges"

	-- is the player at the docsk?
	local docks = (subarea and subarea == "Docks") or area == "Guarded Docks" or area == "Unguarded Docks"

	-- if the player is on water, in a boat enabled faced and not on a bridge or docks then is on a boat!
	return MapCommon.OnWater and MapCommon.IsBoatFacet() and not bridge and not docks
end

function PlayerIsOnWater()

	-- get the terrain ID the player is standing on
	local currTerrain = LuaGetTerrainType(WindowData.PlayerLocation.x, WindowData.PlayerLocation.y)

	-- is this a water type terrain?
	if currTerrain == 5 or currTerrain == 52 then
		return true
	end

	return false
end

function IsRiding(ignoreRace)

	-- is the player a gargoyle? then he can't ride anything
	if not ignoreRace and GetMobileRace(GetPlayerID()) == PaperdollWindow.GARGOYLE then
		return false
	end

	-- initialize the mount ID as nil
	local ridingPet

	-- get the player mount slot
	local equipData = Interface.GetPlayerEquipmentData(EquipmentData.EQPOS_RIDING)

	-- do we have the slot data?
	if equipData then
		
		-- get the mount ID
		ridingPet = equipData.objectId
	end

	-- do we have a valid ID?
	if IsValidID(ridingPet) then
		return ridingPet

	else -- not on a mount
		return false
	end
end

function HasAccessibleInventory(mobileId)

	-- do we have a valid mobile ID?
	if not IsValidID(mobileId) then
		return false
	end

	-- is this the player?
	if mobileId == GetPlayerID() then
		return false
	end

	-- do we already know if this mobile has an inventory?
	if MobileHealthBar and MobileHealthBar.KnownInventory[mobileId] ~= nil then
		return MobileHealthBar.KnownInventory[mobileId]
	end

	-- do we have recently checked for the inventory?
	if MobileHealthBar.LastInventoryRequest[mobileId] and MobileHealthBar.LastInventoryRequest[mobileId] > Interface.TimeSinceLogin then
		return false
	end

	-- get the mobile data
	local mobileData = Interface.GetMobileData(mobileId)
	
	-- is this mobile a pet and is not dead?
	if IsObjectIdPet(mobileId) and (mobileData and not mobileData.IsDead) then

		-- update the last inventory check
		MobileHealthBar.LastInventoryRequest[mobileId] = Interface.TimeSinceLogin + 1
		
		-- get the pet backpack ID
		local backpackId = GetBackpackID(mobileId)
		
		-- do we have a valid backpack ID?
		if IsValidID(backpackId) then

			-- get the container data for the pet backpack
			local data = Interface.GetContainersData(backpackId)
			
			-- is the container named "Backpack"?
			if data and data.containerName == L"Backpack" then

				-- flag the pet has a owner of inventory
				MobileHealthBar.KnownInventory[mobileId] = true
			end
		end

		-- last chance: check the pet context menu
		RequestContextMenu(mobileId, false)
	end

	return false
end

function IsPlayerParalyzed()
	
	-- check the paralyze and stun buff
	return BuffDebuff.BuffWindowId[1037] or CustomBuffs.StunTime > 0
end

function IsPlayerInvisible()
	
	-- check the invisibility or stealth buff
	return BuffDebuff.BuffWindowId[1036] or BuffDebuff.BuffWindowId[1012]
end

function IsObjectInsideOpenContainer(id)

	-- do we have a valid item ID?
	if not IsValidID(id) then
		return false
	end

	-- getting the item info
	local item = Interface.GetObjectInfoData(id)

	-- do we have the item data?
	if not item then
		return false
	end
	
	-- get the container ID from the item data
	local container = item.containerId

	-- do we have a valid container ID?
	if IsValidID(container) then

		-- is the container open?
		if ContainerWindow.OpenContainers[container] then
			return true
		end
	end

	return false
end

function VerifyMobileID(mobileId)

	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return false
	end

	-- is this a valid object?
	if not IsValidObject(mobileId) then
		return false
	end

	return true
end

function GetPlayerID()
	
	-- load the player ID from settings
	Interface.PlayerID = Interface.LoadSetting("PlayerID", WindowData.PlayerStatus.PlayerId, 0)

	-- do we have a valid ID?
	if IsValidID(Interface.PlayerID) then
		return Interface.PlayerID
	end

	-- use the player status ID (that might not be avaialable)
	return WindowData.PlayerStatus.PlayerId
end

function GetPlayerName()

	-- get the player ID
	local playerID = GetPlayerID()

	-- is the player status active and we have a valid ID?
	if WindowData.PlayerStatus and IsValidID(playerID) then	

		-- get the player name
		local PlayerName = GetMobileName(playerID)

		-- make the name lower case
		PlayerName = wstring.lower(PlayerName)

		return PlayerName
	end
end

function GetTalismanID()

	-- get the player ID
	local playerID = GetPlayerID()

	-- do we have a valid ID?
	if not IsValidID(playerID) then
		return 0
	end

	-- get the talisman ID
	return PaperdollWindow.GetPaperdollSlotID(playerId, 12)
end

function CreateSaveStructureWaypoints(array)

	-- if the array is not initialized, we initialize it
	if array == nil then
		array = {}
	end

	-- get the user name
	local user = UserData.Settings.Login.lastUserName

	-- is the user array initialize? if not we do that
	if array[user] == nil then
		array[user] = {}
	end

	-- get the shard ID
	local shard = UserData.Settings.Login.lastShardSelected

	-- is the shard array initialize? if not we do that
	if array[user][shard] == nil then
		array[user][shard] = {}
	end

	-- is the facet array initialize?
	if not array[user][shard].Facet then

		-- initialize the facets array
		array[user][shard].Facet = {}

		-- initialize all facets arrays
		for facet = 0, (MapCommon.NumFacets - 1) do
			array[user][shard].Facet[facet] = {}
		end
	end

	return array
end

function LoadSaveStructureWaypoints(array)

	-- is the array not initialized?
	if array == nil then
		return
	end

	-- get the user name
	local user = UserData.Settings.Login.lastUserName

	-- is the user array initialize?
	if array[user] == nil then
		return
	end

	-- get the shard ID
	local shard = UserData.Settings.Login.lastShardSelected

	-- is the shard array initialize?
	if array[user][shard] == nil then
		return
	end

	return array[user][shard], true
end

function CreateSaveStructureUserShard(array)

	-- if the array is not initialized, we initialize it
	if array == nil then
		array = {}
	end

	-- get the user name
	local user = UserData.Settings.Login.lastUserName

	-- is the user array initialize? if not we do that
	if array[user] == nil then
		array[user] = {}
	end

	-- get the shard ID
	local shard = UserData.Settings.Login.lastShardSelected

	-- is the shard array initialize? if not we do that
	if array[user][shard] == nil then
		array[user][shard] = {}
	end

	return array
end

function LoadSaveStructureUserShard(array)

	-- is the array not initialized?
	if array == nil then
		return
	end

	-- get the user name
	local user = UserData.Settings.Login.lastUserName

	-- is the user array initialize?
	if array[user] == nil then
		return
	end

	-- get the shard ID
	local shard = UserData.Settings.Login.lastShardSelected

	-- is the shard array initialize?
	if array[user][shard] == nil then
		return
	end

	return array[user][shard], true
end

function FixStructureUserShard(array)

	-- is the array not initialized?
	if not array then
		return array
	end

	-- scan the data in the array
	for user, data in pairs(array) do

		-- do we have a valid user?
		if type(user) ~= "string" then

			-- delete the user
			array[user] = nil

			continue
		end

		-- do we have the array data?
		if data then

			-- scan the shards
			for shard, otherData in pairs(data) do

				-- is this a valid shard?
				if type(shard) ~= "number" then

					-- delete the shard
					array[user][shard] = nil

					continue
				end
			end
		end
	end

	return array
end

function CreateSaveStructureAccountOnly(array)

	-- if the array is not initialized, we initialize it
	if array == nil then
		array = {}
	end

	-- get the user name
	local user = UserData.Settings.Login.lastUserName

	-- is the user array initialize? if not we do that
	if array[user] == nil then
		array[user] = {}
	end

	return array
end

function LoadSaveStructureAccountOnly(array)

	-- is the array not initialized?
	if array == nil then
		return
	end

	-- get the user name
	local user = UserData.Settings.Login.lastUserName

	-- is the user array initialize?
	if array[user] == nil then
		return
	end

	return array[user], true
end

function FixStructureAccountOnly(array)

	-- is the array not initialized?
	if not array then
		return array
	end

	-- scan the array
	for user, data in pairs(array) do

		-- is this a valid user?
		if type(user) ~= "string" then

			-- delete the user
			array[user] = nil

			continue
		end
	end

	return array
end

function CreateSaveStructureWithPlayerID(array)

	-- if the array is not initialized, we initialize it
	if array == nil then
		array = {}
	end

	-- get the user name
	local user = UserData.Settings.Login.lastUserName

	-- is the user array initialize? if not we do that
	if array[user] == nil then
		array[user] = {}
	end
	
	-- get the shard ID
	local shard = UserData.Settings.Login.lastShardSelected

	-- is the shard array initialize? if not we do that
	if array[user][shard] == nil then
		array[user][shard] = {}
	end
	
	-- get the player ID
	local playerID = GetPlayerID()

	-- is the player array initialized? if not we do that
	if array[user][shard][playerID] == nil then
		array[user][shard][playerID] = {}
	end

	return array
end

function LoadSaveStructureWithPlayerID(array)

	-- is the array not initialized?
	if array == nil then
		return
	end

	-- get the user name
	local user = UserData.Settings.Login.lastUserName

	-- is the user array initialize?
	if array[user] == nil then
		return
	end
	
	-- get the shard ID
	local shard = UserData.Settings.Login.lastShardSelected

	-- is the shard array initialize?
	if array[user][shard] == nil then
		return
	end
	
	-- get the player ID
	local playerID = GetPlayerID()

	-- is the player array initialized?
	if array[user][shard][playerID] == nil then
		return
	end

	return array[user][shard][playerID], true
end

function FixStructureWithPlayerID(array)

	-- is the array not initialized?
	if not array then
		return array
	end

	-- scan the array data
	for user, data in pairs(array) do

		-- do we have a valid user?
		if type(user) ~= "string" then

			-- delete the user
			array[user] = nil

			continue
		end

		-- do we have the data?
		if data then

			-- scan all shards
			for shard, otherData in pairs(data) do

				-- is this a valid shard?
				if type(shard) ~= "number" then

					-- delete the shard
					array[user][shard] = nil

					continue
				end

				-- do we have other data?
				if otherData then

					-- scan the player IDs
					for playerID, finalData in pairs(otherData) do

						-- is this a valid player ID?
						if type(playerID) ~= "number" then

							-- delete the player
							array[user][shard][playerID] = nil

							continue
						end
					end
				end
			end
		end
	end

	return array
end

function CreateSaveStructureWithSelectedCharID(array)

	-- if the array is not initialized, we initialize it
	if array == nil then
		array = {}
	end

	-- get the user name
	local user = UserData.Settings.Login.lastUserName

	-- is the user array initialize? if not we do that
	if array[user] == nil then
		array[user] = {}
	end
	
	-- get the shard ID
	local shard = UserData.Settings.Login.lastShardSelected

	-- is the shard array initialize? if not we do that
	if array[user][shard] == nil then
		array[user][shard] = {}
	end
	
	-- get the last character selected
	local playerID = UserData.Settings.Login.lastCharacterSelected

	-- is the chractar array initialized? if not we do that
	if array[user][shard][playerID] == nil then
		array[user][shard][playerID] = {}
	end

	return array
end

function LoadSaveStructureWithSelectedCharID(array)

	-- is the array not initialized?
	if array == nil then
		return
	end

	-- get the user name
	local user = UserData.Settings.Login.lastUserName

	-- is the user array initialize?
	if array[user] == nil then
		return
	end
	
	-- get the shard ID
	local shard = UserData.Settings.Login.lastShardSelected

	-- is the shard array initialize?
	if array[user][shard] == nil then
		return
	end
	
	-- get the last character selected
	local playerID = UserData.Settings.Login.lastCharacterSelected

	-- is the chractar array initialized?
	if array[user][shard][playerID] == nil then
		return
	end

	return array[user][shard][playerID], true
end

function IsValidString(text)

	-- is the text null, not a string or empty?
	if text == nil or type(text) ~= "string" or string.trim(text) == "" then
		return false
	end

	return true
end

function IsValidWString(text)

	-- is the text null, not a wstring or empty?
	if text == nil or type(text) ~= "wstring" or wstring.trim(text) == L""  then
		return false
	end

	return true
end

function IsValidID(text)

	-- is the ID null, not a number or 0?
	if text == nil or type(text) ~= "number" or text == 0 then
		return false
	end

	return true
end

SummonsList = { [L"a revenant"] = true, [L"an energy vortex"] = true, [L"a blade spirit"] = true, [L"a rising colossus"] = true, [L"a nature's fury"] = true }

ControllableSummonsList = { [L"an earth elemental"] = true, [L"an air elemental"] = true, [L"an water elemental"] = true, [L"an fire elemental"] = true, [L"an imp"] = true, [L"fey"] = true, [L"summon creature"] = true, [L"daemon"] = true,  }

SummonsToSpellID = { 
	[L"a revenant"] = 114, 
	[L"an energy vortex"] = 58, 
	[L"a blade spirit"] = 33, 
	[L"a rising colossus"] = 693, 
	[L"a nature's fury"] = 606,
	[L"an earth elemental"] = 62,
	[L"an air elemental"] = 60,
	[L"an water elemental"] = 64,
	[L"an fire elemental"] = 63,
	[L"an animated weapon"] = 684,
	[L"an imp"] = 608,
	[L"fey"] = 607,
	[L"summon creature"] = 40,
	[L"daemon"] = 61,
	[L"familiar"] = 112,
	[L"mirror image"] = 508,
}

function IsSummon(param)

	-- shall we check by name
	if type(param) == "wstring" then

		-- get the creature name
		local name = param

		-- is this a valid name?
		if not IsValidWString(name) then
			return false
		end

		--cleaning name
		name = wstring.trim(name)
		name = wstring.lower(name)

		-- is that creature in the summons list?
		if not SummonsList[name] then
			return false
		end

		return true

	 -- check by mobileID for property "(summoned)"
	elseif type(param) == "number" then

		-- get the mobile ID
		local mobileID = param

		-- is this the player?
		if mobileID == GetPlayerID() then
			return false
		end
		
		-- does the mobile has the summon timer?
		if (MobileHealthBar.SummonTimer and MobileHealthBar.SummonTimer[mobileID]) then
			return true
		end
		
		-- does the mobile has the (summoned) tag?
		local hasSummoned = ItemProperties.DoesItemHasProperty(mobileID, 1049646) -- (summoned)
		
		-- if the property is not there (or not properly loaded as usual), we check by name...
		if not hasSummoned then

			-- get the mobile name
			local name = GetMobileName(mobileID)

			-- do we have a valid name?
			if not IsValidWString(name) then
				return
			end

			-- make a recursive call with the mobile name
			hasSummoned = IsSummon(name)
		end

		return hasSummoned 
	end

	return false
end

function IsSomeonePet(mobileId)

	-- do we have a valid ID or it's the player ID?
	if not IsValidID(mobileId) or mobileId == GetPlayerID() then
		return
	end

	-- if this is a player's pet, then it IS someone pet...
	if IsObjectIdPet(mobileId) then
		return true
	end

	-- get the mobile notoriety
	local noto = GetMobileNotoriety(mobileId)

	-- without notoriety or invulnerable? for sure is not a pet.
	if (noto == NameColor.Notoriety.INVULNERABLE) then
		return false
	end

	-- does the mobile has the (bonded) tag?
	local hasBonded = ItemProperties.DoesItemHasProperty(mobileId, 1049608) -- (bonded)
	
	-- if we have the bonded tag we know is a pet
	if hasBonded == true then
		return true
	end

	-- does the mobile has the (tame) tag?
	local hasTamed = ItemProperties.DoesItemHasProperty(mobileId, 502006) -- (tame)

	-- since it's not bonded, the creature is a pet only if it's tamed.
	return hasTamed
end

function IsMySummon(name, mobileId)

	-- is the name valid?
	if not IsValidWString(name) then

		-- get the name from the mobile ID
		name = GetMobileName(mobileId)

		-- if the name is still invalid, we can get out
		if not IsValidWString(name) then
			return _, name
		end
	end

	-- cleaning name
	name = wstring.trim(name)
	name = wstring.lower(name)

	-- do we have a timer for this summon?
	if MobileHealthBar.SummonTimer and MobileHealthBar.SummonTimer[mobileId] then

		-- is this mobile a piexie?
		if CreaturesDB.IsPixie(name) then
			name = L"fey"

		-- is this mobile a demon?
		elseif CreaturesDB.IsDaemon(name) then
			name = L"daemon"

		-- is this mobile a familiar?
		elseif CreaturesDB.IsFamiliar(name) then
			name = L"familiar"

		-- is this mobile a mirror image?
		elseif wstring.find(GetPlayerName(), name, 1, true) then
			name = L"mirror image"

		-- is this a talisman summon?
		elseif IsValidID(GetTalismanID()) and Interface.LastItem == GetTalismanID() then -- talisman summon
			name = L"talisman summon"
		end

		return true, name
	end

	-- is this not a summon or not a player's pet?
	if not IsSummon(mobileId) or not IsObjectIdPet(mobileId) then
		return false, name
	end

	-- is this mobile a piexie?
	if CreaturesDB.IsPixie(name) then

		-- get the creature type name
		name = L"fey"

		-- check if the last spell was summon fey
		return Interface.LastSpell == SummonsToSpellID[name], name

	elseif CreaturesDB.IsDaemon(name) then

		-- get the creature type name
		name = L"daemon"

		-- check if the last spell was summon demon
		return Interface.LastSpell == SummonsToSpellID[name], name

	elseif CreaturesDB.IsFamiliar(name) then

		-- get the creature type name
		name = L"familiar"

		-- check if the last spell was summon demon
		return Interface.LastSpell == SummonsToSpellID[name], name

	elseif wstring.find(GetPlayerName(), name, 1, true) then

		-- get the creature type name
		name = L"mirror image"

		-- check if the last spell was mirror image
		return Interface.LastSpell == SummonsToSpellID[name], name

	-- do we have a talisman ID and the last item the player used was the talisman?
	elseif IsValidID(GetTalismanID()) and Interface.LastItem == GetTalismanID() then

		-- get the creature type name
		name = L"talisman summon"

		return true, name
	end

	-- is the last spell a spell for summoning?
	if Interface.LastSpell == SummonsToSpellID[name] then
		return true, name
	end

	return false, name
end

function IsFarmAnimal(mobileId)

	-- do we have a valid name?
	if not IsValidID(mobileId) then
		return false
	end

	-- current mobile data record
	local mobileStatus = Interface.ActiveMobilesOnScreen[mobileId]

	-- do we have the DB data for the creature in the active mobiles on screen list?
	if mobileStatus and mobileStatus.isNeutralAnimal ~= nil then
		return mobileStatus.isNeutralAnimal
	end

	-- get the mobile notoriety
	local noto = GetMobileNotoriety(mobileId)

	-- neutral animals can only be gray
	if noto ~= NameColor.Notoriety.NONE and noto ~= NameColor.Notoriety.CANATTACK then
		return false
	end

	-- find the DB data into the neutral animals table
	local match = CreaturesDB.FindCompatibleCreatures(mobileId, true, CreaturesDB.AnimalLoreNeutralAnimals)

	-- is the animal listed in the farm animals list?
	return #match > 0
end

function GetSkillTID(skillId)

	-- do we have a valid TID?
	if not skillId then
		return 0
	end

	-- scan the skills in search for the TID
	for _, data in pairs(WindowData.SkillsCSV) do

		-- is this the skill we're looking for?
		if data.ServerId == skillId then

			return data.NameTid
		end
	end

	return 0
end

function GetSkillIDByTID(tid)

	-- do we have a valid TID?
	if not IsValidID(tid) then
		return -1
	end

	-- scan the skills in search for the TID
	for skillId, data in pairs(WindowData.SkillsCSV) do

		-- is this the skill we're looking for?
		if data.NameTid == tid then

			return data.ServerId
		end
	end

	return -1
end

function GetSkillValue(skillID, withBonus, convertToServerId)

	-- do we have a valid ID?
	if not skillID or skillID < 0 then
		return 0
	end

	-- get the server ID for the skill (the one in the parameter by default)
	local serverId = skillID

	-- do we have to get the server ID?
	if convertToServerId then

		-- convert the skill ID to server ID
		serverId = WindowData.SkillsCSV[skillID].ServerId
	end

	-- get the data for the skill
	if WindowData.SkillDynamicData[serverId] then

		-- initialize the skill level with bonus
		local skillLevel = WindowData.SkillDynamicData[serverId].TempSkillValue / 10

		-- do we need the value without the bonus?
		if not withBonus then
			skillLevel = WindowData.SkillDynamicData[serverId].RealSkillValue / 10
		end

		return skillLevel
	end

	return 0
end

function IsMobileInvulnerable(mobileId)

	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return false
	end

	-- get the name data
	local nameData = Interface.GetMobileNameData(mobileId)

	-- do we have the mobile name data?
	if nameData then

		-- get the mobile notoriety
		local noto = nameData.Notoriety + 1

		-- is the notoriety "Invulnerable"?
		if noto == NameColor.Notoriety.INVULNERABLE then
			return true
		end
	end

	return false
end

function IsStableMaster(mobileId)

	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return false
	end
	
	-- is this a pet?
	if IsObjectIdPet(mobileId) then
		return false
	end

	-- is this the player character?
	if mobileId == GetPlayerID() then
		return false
	end

	-- get the mobile name
	local name = GetMobileName(mobileId)

	-- do we have a valid name?
	if not IsValidWString(name) then
		return false
	end

	-- if the mobile has "The Animal Trainer" as title, is a stable master
	return wstring.find(name, L"The Animal Trainer", 1, true) ~= nil
end

function GetMobileName(mobileId, stripTitle, dontTrim)

	-- do we have a valid mobile ID?
	if not IsValidID(mobileId) then
		return L""
	end

	-- get the mobile on screen data
	local mobileStatus = Interface.ActiveMobilesOnScreen[mobileId]

	-- get the mobile name data
	local nameData = Interface.GetMobileNameData(mobileId)

	-- do we have a valid mobile name data and a valid name?
	if nameData and IsValidWString(nameData.MobName) then

		-- get the name and remove spaces at beginning and end
		local name = wstring.trim(nameData.MobName)
		local untrimmedName = nameData.MobName

		-- get the changeling type affix
		local changelingAffix = ChangelingNameCheck(mobileId, name)
		
		-- if we have a valid changeling affix, we add it to the name
		if IsValidWString(changelingAffix) and not wstring.find(name, changelingAffix, 1, true) then
			name = name .. L" (" .. changelingAffix .. L")"
			untrimmedName = untrimmedName .. L" (" .. changelingAffix .. L")"
		end

		-- is the name different from the one on the mobile on screen data?
		if mobileStatus and mobileStatus.name ~= name then

			-- update the name
			mobileStatus.name = name

			-- get the name without the title
			mobileStatus.cleanName = StripNameTitle(mobileStatus.name)

			-- get the mobile title
			mobileStatus.title = GetNameTitle(mobileStatus.name)

		end

		-- do we need to strip the title?
		if stripTitle then
			return StripNameTitle(name)
		end
		
		-- do we need to remove spaces at beginning and end of the name?
		if dontTrim == true then
			return untrimmedName

		else -- return trimmed name
			return name
		end
	end

	-- get the mobile status
	local mobileData = Interface.GetMobileData(mobileId)

	-- do we have the mobile status and a valid name?
	if mobileData and IsValidWString(mobileData.MobName) then
		
		-- get the name and remove spaces at beginning and end
		local name = wstring.trim(mobileData.MobName)
		local untrimmedName = mobileData.MobName

		-- get the changeling type affix
		local changelingAffix = ChangelingNameCheck(mobileId, name)

		-- if we have a valid changeling affix, we add it to the name
		if IsValidWString(changelingAffix) and not wstring.find(name, changelingAffix, 1, true) then
			name = name .. L" (" .. changelingAffix .. L")"
			untrimmedName = untrimmedName .. L" (" .. changelingAffix .. L")"
		end

		-- is the name different from the one on the mobile on screen data?
		if mobileStatus and mobileStatus.name ~= name then

			-- update the name
			mobileStatus.name = name

			-- get the name without the title
			mobileStatus.cleanName = StripNameTitle(mobileStatus.name)

			-- get the mobile title
			mobileStatus.title = GetNameTitle(mobileStatus.name)
		end

		-- do we need to strip the title?
		if stripTitle then
			return StripNameTitle(mobileData.MobName)
		end

		-- do we need to remove spaces at beginning and end of the name?
		if dontTrim == true then
			return untrimmedName

		else -- return the trimmed name
			return name
		end
	end

	-- since we couldn't get the name from the mobileName and mobile status, we try from the properties
	local propName = GetItemNameFromProperties(mobileId)

	-- get the changeling type affix
	local changelingAffix = ChangelingNameCheck(mobileId, propName)

	-- if we have a valid changeling affix, we add it to the name
	if IsValidWString(changelingAffix) and not wstring.find(propName, changelingAffix, 1, true) then
		propName = propName .. L" (" .. changelingAffix .. L")"
	end

	-- do we have a valid name?
	if IsValidWString(propName) then

		-- is the name different from the one on the mobile on screen data?
		if mobileStatus and mobileStatus.name ~= propName then

			-- update the name
			mobileStatus.name = propName

			-- get the name without the title
			mobileStatus.cleanName = StripNameTitle(mobileStatus.name)

			-- get the mobile title
			mobileStatus.title = GetNameTitle(mobileStatus.name)

		end

		-- do we need to remove spaces at beginning and end of the name?
		if stripTitle then
			return StripNameTitle(propName)

		else -- return the trimmed name
			return propName
		end
	end

	-- we have not found the name
	return L""
end

function GetMobileBodyID(mobileId, dontcap)
	
	-- do we have a valid mobile ID?
	if not IsValidID(mobileId) then
		return 0
	end

	-- is this the player and we have a stored body ID?
	if mobileId == GetPlayerID() and IsValidID(Interface.PlayerBodyID) then
		return Interface.PlayerBodyID
	end

	-- get the item data for the mobile
	local itemData = Interface.GetObjectInfoData(mobileId)

	-- do we have the item data?
	if not itemData then
		return 0
	end

	-- if we don't want to remove the extra zeroes, we return it as it is
	if dontcap then
		return itemData.objectType
	end

	-- calculate the body ID
	local bodyID = itemData.objectType - 10000000

	-- is the body ID negative?
	if bodyID < 0 then

		-- use the plain object ID instead
		bodyID = itemData.objectType
	end

	-- is this the player?
	if mobileId == GetPlayerID() then

		-- save the body ID
		Interface.PlayerBodyID = bodyID
	end
	
	return bodyID
end

function GetMobileHue(mobileId)

	-- do we have a valid mobile ID?
	if not IsValidID(mobileId) then
		return 0
	end

	-- get the item data for the mobile
	local itemData = Interface.GetObjectInfoData(mobileId)

	-- do we have the item data?
	if not itemData then
		return 0
	end

	-- return the hue id and rgb
	return itemData.hueId, itemData.hue
end

function ChangelingNameCheck(mobileId, name)
	
	-- do we have a valid ID and name?
	if not IsValidID(mobileId) or not IsValidWString(name) then
		return
	end

	-- check what we already know
	if Interface.KnownChangelings.Changelings[mobileId] then
		return L"Changeling"

	elseif Interface.KnownChangelings.Irks[mobileId] then
		return L"Irk"

	elseif Interface.KnownChangelings.Guiles[mobileId] then
		return L"Guile"
		
	elseif Interface.KnownChangelings.Spites[mobileId] then
		return L"Spite"

	elseif Interface.KnownChangelings.Travestys[mobileId] then
		return L"Travesty"
	end

	-- parse the name to see if and what kind of changeling we have
	if wstring.find(name, L"Changeling", 1, true) then
		
		-- flag this mobile as changeling
		Interface.KnownChangelings.Changelings[mobileId] = true

		return L"Changeling"

	elseif wstring.find(name, L"Irk", 1, true) then

		-- flag this mobile as changeling
		Interface.KnownChangelings.Irks[mobileId] = true

		return L"Irk"

	elseif wstring.find(name, L"Guile", 1, true) then

		-- flag this mobile as changeling
		Interface.KnownChangelings.Guiles[mobileId] = true

		return L"Guile"

	elseif wstring.find(name, L"Spite", 1, true) then

		-- flag this mobile as changeling
		Interface.KnownChangelings.Spites[mobileId] = true

		return L"Spite"

	elseif wstring.find(name, L"Travesty", 1, true) then

		-- flag this mobile as changeling
		Interface.KnownChangelings.Travestys[mobileId] = true

		return L"Travesty"
	end

	return L""
end

function DoesBodyHasPaperdoll(mobileId)

	-- do we have a valid mobile ID?
	if not IsValidID(mobileId) then
		return false
	end

	-- if it's a known player, we are sure he has a paperdoll
	if	TargetWindow.KnownPlayers[mobileId] then
		return true
	end

	-- get hte mobile body ID
	local bodyID = GetMobileBodyID(mobileId)

	-- all the body ID that supports paperdolls
	if	bodyID == 400 or -- human male
		bodyID == 401 or -- human female
		bodyID == 402 or -- human male ghost
		bodyID == 403 or -- human female ghost
		bodyID == 605 or -- elf male
		bodyID == 606 or -- elf female
		bodyID == 607 or -- elf male ghost
		bodyID == 608 or -- elf female ghost
		bodyID == 666 or -- gargoyle male
		bodyID == 667 or -- gargoyle female
		bodyID == 694 or -- gargoyle male (dead)
		bodyID == 695  -- gargoyle female (dead)
	then
		return true
	end

	return false
end

Interface.CurrentPortraits = {}
function SetPortraitImage(mobileId, windowName, square, checkCurrentTexture)

	-- do we have a valid parameters?
	if not IsValidID(mobileId) or not IsValidString(windowName) or not DoesWindowExist(windowName) then
		return
	end

	-- current texture to check
	local currentTexture

	-- if we have to check the current texture, and the active window has a texture saved, we use that as current texture
	if checkCurrentTexture and Interface.CurrentPortraits[windowName] then
		currentTexture = Interface.CurrentPortraits[windowName]
	end

	-- initializing the paperdoll data
	local paperdollData = Interface.GetPaperdollData(mobileId)

	-- get the contributor data
	local contributor = CreditsWindow.GetContributorData(mobileId)

	-- is this mobile a contributor?
	if contributor and IsValidString(contributor.portrait) then

		-- get the contributor portrait
		local texture = contributor.portrait

		-- make sure the texture exist
		if not IsValidString(texture) or currentTexture == texture then
			return texture
		end

		-- is this for a square image?
		if square then

			-- draw the texture
			DynamicImageSetTexture(windowName, texture, 0, 0)
		
			-- set the texture scale
			DynamicImageSetTextureScale(windowName, 0.843)

		else -- circle image

			-- draw the texture
			CircleImageSetTexture(windowName, texture, 32, 32)
		
			-- set the texture scale
			CircleImageSetTextureScale(windowName, 0.843)
		end

		-- store the active texture
		Interface.CurrentPortraits[windowName] = texture
		
	-- creatures with paperdoll will have the picture taken from it
	elseif HasPaperdoll(mobileId) and Interface.VerifyPaperdollData(mobileId, paperdollData) then

		-- get the paperdoll texture
		local textureData = SystemData.PaperdollTexture[mobileId]	

		-- do we have the paperdoll texture?
		if textureData ~= nil and (not currentTexture or currentTexture ~= "paperdoll_texture") then
			
			-- initialize the coordinates and scale
			local x, y, scale

			-- is the paperdoll in legacy mode?
			if textureData.IsLegacy == 1 then

				-- set the coordinates for the legecy paperdoll
				x, y = -88, 14

				-- set the scale for the legacy paperdoll
				scale = 0.8

			else -- normal paperdoll

				-- set the coordinates for the paperdoll
				x, y = -11, -191

				-- set the scale for the paperdoll
				scale = 0.432
			end
				
			-- draw the texture
			CircleImageSetTexture(windowName, "paperdoll_texture" .. mobileId, x - textureData.xOffset, y - textureData.yOffset)

			-- update the texture scale
			CircleImageSetTextureScale(windowName, scale)
		end
		
		return "paperdoll_texture"
			
	else -- creatures without paperdoll

		-- get the body ID
		local bodyId = GetMobileBodyID(mobileId)

		-- since lua can't handle big numbers, we have to do sum as strings...
		bodyId = tonumber(string.sub("100000000", 1, -(string.len(tostring(bodyId)) + 1)) .. tostring(bodyId))

		-- get the mobile hue
		local hue = GetMobileHue(mobileId)

		-- convert the hue into r, g, b
		local r, g, b = HueRGBAValue(hue)

		-- get the icon informations
		local texture, x, y = GetIconData(bodyId)
		
		-- is the current texture the same we're going to draw? we can get out then
		if currentTexture and currentTexture == texture then
			return texture
		end

		-- make sure the texture exist
		if not IsValidString(texture) then
			return
		end

		-- is this for a square image?
		if square then

			-- draw the texture
			DynamicImageSetTexture(windowName, texture, 0, 0)
		
			-- set the texture scale
			DynamicImageSetTextureScale(windowName, 0.843)

		else -- circle image

			-- get the circle image dimensions
			local w, h = WindowGetDimensions(windowName)

			-- default picture offset for the circle image
			local offset = 32

			-- if the image is 65x65 (target window), we change the offset
			if w == 65 and h == 65 then
				offset = 27
			end

			-- draw the texture
			CircleImageSetTexture(windowName, texture, offset, offset)
		
			-- set the texture scale
			CircleImageSetTextureScale(windowName, 0.843)
		end

		-- color the image based on the creature hue
		WindowSetTintColor(windowName, r, g, b)
		
		-- store the active texture
		Interface.CurrentPortraits[windowName] = texture
	end
end

function GetMobileType(mobileId, name)

	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return L""
	end

	-- if we don't have the name, we get it from the mobile ID
	if ((not IsValidString(name) and type(name) == "string") or (not IsValidWString(name) and type(name) == "wstring")) then
		name = GetMobileName(mobileId, false, true)
	end

	-- convert the name in wstring in case it's a string
	if type(name) == "string" then
		name = towstring(name)
	end
	
	-- do we have a valid name?
	if not IsValidWString(towstring(name)) then
		return L""
	end

	-- remove the article in front of the name
	name = wstring.gsub(name, L"An ", L"")
	name = wstring.gsub(name, L"A ", L"")
	
	-- remove line breaker
	name = wstring.gsub(name, L"\n", L" ")

	-- does the name have the suffix (Paragon) ?
	if wstring.find(name , L"(Paragon)", 1, true) ~= nil then

		-- remove the suffix
		name = wstring.gsub(name, L"Paragon", L"")
		name = wstring.gsub(name, L"[(]", L"")
		name = wstring.gsub(name, L"[)]", L"")
	end
	
	-- changelings check
	if Interface.KnownChangelings.Changelings[mobileId] then

		-- the real name is Changeling
		name = L"Changeling"

	elseif Interface.KnownChangelings.Irks[mobileId] then

		-- the real name is Irk
		name = L"Irk"

	elseif Interface.KnownChangelings.Guiles[mobileId] then

		-- the real name is Guile
		name = L"Guile"

	elseif Interface.KnownChangelings.Spites[mobileId] then

		-- the real name is Spite
		name = L"Spite"

	elseif Interface.KnownChangelings.Travestys[mobileId] then

		-- the real name is Travesty
		name = L"Travesty"
	end
	
	-- does the name have the suffix (Guardian)?
	if wstring.find(name , L"(Guardian)", 1, true) ~= nil then
		
		-- remove the suffix
		name = wstring.gsub(name, L"Guardian", L"")
		name = wstring.gsub(name, L"[(]", L"")
		name = wstring.gsub(name, L"[)]", L"")
	end
	
	-- does the name have the suffix Renowned?
	if wstring.find(name, L"Renowned", 1, true) ~= nil then

		-- format the name so that we can find it in the DB
		name = wstring.sub(name, 1, wstring.find(name , L"Renowned", 1, true) - 2)
		name = name .. L"renowned"
	end
	
	-- remove the factions tags if it's a faction monster
	if wstring.find(name, L"CoM", 1, true) ~= nil then
		name = wstring.sub(name, 1, wstring.find(name , L"CoM", 1, true) - 2)
	end
	
	if wstring.find(name, L"TB", 1, true) ~= nil then
		name = wstring.sub(name, 1, wstring.find(name , L"TB", 1, true) - 2)
	end

	if wstring.find(name, L"SL", 1, true) ~= nil then
		name = wstring.sub(name, 1, wstring.find(name , L"SL", 1, true) - 2)
	end

	if wstring.find(name , L"Min", 1, true) ~= nil and not wstring.find(name , L"Minotaur", 1, true) then
		name = wstring.sub(name, 1, wstring.find(name , L"Min", 1, true) - 2)
	end
		
	-- clean the name
	name = wstring.trim(name)

	-- make the name lower case
	name = wstring.lower(name)

	-- does the creature have the paperdoll?
	local hasPaperdoll = HasPaperdoll(mobileId)

	-- find the type on the DB
	local creatureType, inDB = CreaturesDB.NameToType(tostring(name), hasPaperdoll)

	-- if the name has not been found, it could be because it has the affix "- RED", so if the notoriety is for murder we try with that affix.
	-- hell hound also can be red so we check for that too
	if not inDB or name == L"hell hound" then

		-- get the mobile notoriety
		local noto = GetMobileNotoriety(id)
		
		-- is this creature a murder (red notoriety)?
		if noto == NameColor.Notoriety.MURDERER then

			-- add the affix "- RED" to the name
			name = name .. L" - RED"

			-- try to search again
			creatureType, inDB = CreaturesDB.NameToType(tostring(name), hasPaperdoll)
		end
	end

	-- if the creatures is not in the database we return an empty string
	if not inDB then 
		return ""

	else -- otherwise we return the correct type
		return creatureType
	end
end

function GetMobileNotoriety(mobileId, honorCheck)

	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return NameColor.Notoriety.NONE
	end

	-- if the honor check is false, we return the normal notoriety without counting honor
	if honorCheck == nil then
		honorCheck = true
	end

	-- get the name data
	local nameData = Interface.GetMobileNameData(mobileId)

	-- do we have the name data?
	if not nameData then
		return NameColor.Notoriety.NONE
	end

	-- calculate the notoriety
	local noto = nameData.Notoriety + 1

	-- is the mobile the honor target and we have to do the honor check?
	if mobileId == Interface.CurrentHonor and honorCheck then

		-- set the notoriety to honored
		noto = NameColor.Notoriety.HONORED
	end

	return noto
end

function GetMobileRace(mobileId)

	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return PaperdollWindow.HUMAN
	end

	-- get hte mobile body ID
	local bodyID = GetMobileBodyID(mobileId)

	-- is a human body?
	if	bodyID == 400 or -- human male
		bodyID == 401 or -- human female
		bodyID == 402 or -- human male ghost
		bodyID == 403  -- human female ghost
	then

		return PaperdollWindow.HUMAN

	-- is an elf body?
	elseif	bodyID == 605 or -- elf male
			bodyID == 606 or -- elf female
			bodyID == 607 or -- elf male ghost
			bodyID == 608  -- elf female ghost
	then

		return PaperdollWindow.ELF

	-- is a gargoyle body?
	elseif  bodyID == 666 or -- gargoyle male
			bodyID == 667 or -- gargoyle female
			bodyID == 694 or -- gargoyle male (dead)
			bodyID == 695  -- gargoyle female (dead)
	then

		return PaperdollWindow.GARGOYLE
	end

	-- get the mobile data
	local raceData = Interface.GetMobileData(mobileId)

	-- do we have the mobile data?
	if raceData then
		return raceData.Race
	end

	return PaperdollWindow.HUMAN
end

function GetMobileGender(mobileId)
	
	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return 0
	end

	-- get hte mobile body ID
	local bodyID = GetMobileBodyID(mobileId)

	-- is a male body?
	if	bodyID == 400 or -- human male
		bodyID == 402 or -- human male ghost
		bodyID == 605 or -- elf male
		bodyID == 607 or -- elf male ghost
		bodyID == 666 or -- gargoyle male
		bodyID == 694  -- gargoyle male (dead)
	then

		return 0

	-- is a female body?
	elseif	bodyID == 401 or -- human female
			bodyID == 403 or -- human female ghost
			bodyID == 606 or -- elf female
			bodyID == 608 or -- elf female ghost
			bodyID == 667 or -- gargoyle female
			bodyID == 695  -- gargoyle female (dead)
	then
	
		return 1
	end

	-- get the mobile data
	local genderData = Interface.GetMobileData(mobileId)

	-- do we have the mobile data?
	if genderData then
		return genderData.Gender
	end

	return 0
end

function IsMobileStatusChanged(mobileId)

	-- do we have an active healthbar for the mobile?
	if not Interface.IsStatusInUse(mobileId) then
		return false
	end

	-- get the current health
	local hp, maxHp, dead = GetMobileHealth(mobileId)

	-- create a pointer variable for the mobile status
	local mobileStatus = Interface.ActiveMobilesOnScreen[mobileId]

	-- is the status missing or the hp/dead status are changed?
	if not mobileStatus or mobileStatus.curHealth ~= hp or mobileStatus.maxHealth ~= maxHp or mobileStatus.dead ~= dead then
		return true
	end

	return false
end

function IsMobileNameChanged(mobileId)

	-- do we have an active healthbar for the mobile?
	if not Interface.IsNameInUse(mobileId) then
		return false
	end
	
	-- get the mobile name
	local name = GetMobileName(mobileId)

	-- get the mobile notoriety
	local noto = GetMobileNotoriety(mobileId)

	-- create a pointer variable for the mobile status
	local mobileStatus = Interface.ActiveMobilesOnScreen[mobileId]

	-- is the status missing or the hp/dead status are changed?
	if not mobileStatus or mobileStatus.the ~= the or mobileStatus.noto ~= noto then
		return true
	end

	return false
end

function GetMobileHealth(mobileId, partyData)

	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return
	end

	-- is the mobile invulnerable? we don't need the status
	if IsMobileInvulnerable(mobileId) then
		return 100, 100, false, 100
	end

	-- get the mobile data
	local mobileData 

	if mobileId == GetPlayerID() then
		mobileData = Interface.GetPlayerStatusData()
	else
		mobileData = Interface.GetMobileData(mobileId)
	end

	-- do we have valid mobile data?
	if not mobileData or mobileData.MaxHealth == 0 then
		return
	end

	-- calculate the hp percentage
	local perc =  math.floor((mobileData.CurrentHealth / mobileData.MaxHealth) * 100)

	-- do we have a valid percentage?
	if math.isINF(perc) or math.isNAN(perc) or perc < 0 or perc > 100 then
		perc = 0
	end

	-- is this mobile a party member and we need the party info (mana, stamina)?
	if (partyData and IsPartyMember(mobileId)) or mobileId == GetPlayerID() then

		-- if the mana is 0 and this mobile is not dead, the update has not yet arrived... usually the data arrives when they use the resource.
		if mobileData.CurrentMana == 0 and mobileData.MaxMana == 0 and not mobileData.IsDead then
			mobileData.CurrentMana = 1
			mobileData.MaxMana = 1
		end

		-- if the stamina is 0 and this mobile is not dead, the update has not yet arrived... usually the data arrives when they use the resource.
		if mobileData.CurrentStamina == 0 and mobileData.MaxStamina == 0 and not mobileData.IsDead then
			mobileData.CurrentStamina = 1
			mobileData.MaxStamina = 1
		end

		return mobileData.CurrentHealth, mobileData.MaxHealth, mobileData.IsDead, perc, mobileData.CurrentMana, mobileData.MaxMana, mobileData.CurrentStamina, mobileData.MaxStamina

	else -- normal mobile
		return mobileData.CurrentHealth, mobileData.MaxHealth, mobileData.IsDead, perc
	end
end

function HasPaperdoll(mobileId)

	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return false
	end

	-- does the mobile body has a paperdoll?
	if not DoesBodyHasPaperdoll(mobileId) then
		return false
	end

	-- do we have a valid paperdoll data?
	return Interface.GetPaperdollData(mobileId) ~= nil
end

function GetItemName(itemId)

	-- do we have a valid ID?
	if not IsValidID(itemId) then
		return L""
	end

	-- get the item data
	local itemData = Interface.GetObjectInfoData(itemId)

	-- do we have the item data and a valid item name?
	if itemData and IsValidWString(itemData.name) then

		-- remove the quantity number from the front of the name
		return Shopkeeper.stripFirstNumber(wstring.trim(itemData.name))
	end

	-- since we couldn't get the name from the objectInfo, we try from the properties
	local propName = GetItemNameFromProperties(itemId)

	-- do we have a valid name?
	if IsValidWString(propName) then
		
		-- remove the quantity number from the front of the name
		return Shopkeeper.stripFirstNumber(propName)
	end

	return L""
end

function GetItemNameFromProperties(itemId)
	
	-- do we have a valid item ID?
	if not IsValidID(itemId) then
		return L""
	end

	-- get the item name from properties
	local itemName = ItemProperties.GetObjectProperties( itemId, 1, "GetItemNameFromProperties" )

	-- do we have a valid item name?
	if itemName and IsValidWString(itemName) then

		-- return the item name
		return Shopkeeper.stripFirstNumber(wstring.trim(itemName))
	end

	return L""
end

function GetItemIcon(itemId)

	-- do we have a valid item ID?
	if not IsValidID(itemId) then
		return 0
	end

	-- get the item data
	local itemData = Interface.GetObjectInfoData(itemId)

	-- do we have the item data
	if itemData then

		-- return the icon ID
		return itemData.iconId
	end

	return 0
end

function GetItemType(itemId)

	-- do we have a valid item ID?
	if not IsValidID(itemId) then
		return 0
	end

	-- get the item data
	local itemData = Interface.GetObjectInfoData(itemId)

	-- do we have the item data
	if itemData then

		-- return the object type
		return itemData.objectType
	end

	return 0
end

function GetItemHue(itemId)

	-- do we have a valid item ID?
	if not IsValidID(itemId) then
		return 0, { r = 255, g = 255, b = 255 }
	end

	-- get the item data
	local itemData = Interface.GetObjectInfoData(itemId)

	-- do we have the item data
	if itemData then

		-- return the item ID and hue rgb
		return itemData.hueId, itemData.hue
	end

	return 0, {r = 255, g = 255, b = 255}
end

function GetItemWeight(itemId)

	-- do we have a valid ID?
	if not IsValidID(itemId) then
		return
	end

	-- get the item properties data
	local data = Interface.GetItemPropertiesData(itemId)
	
	-- is the object ID the one we have the cursor over?
	if not data and WindowData.ItemProperties.CurrentHover == itemId then

		-- use ID 0 instead
		data = WindowData.ItemProperties[0]	
	end

	-- get the item properties array
	local props = ItemProperties.BuildParamsArray(data, true)

	-- scan the item properties
	for tid, params in pairs(props) do
		
		-- is this a weight property?
		if ItemPropertiesInfo.WeightONLYTid[tid] then

			-- get the weight value
			return tonumber(params[1])
		end
	end
end

function GetQuantityForItem(objectType) 
	-- NOTE: this function is to be used on hotbars ONLY. The object quantity works only with the item ID generated for hotbars items (which are not the same of the item inside the backpack).

	-- is a valid object tpe?
	if not IsValidID(objectType) then
		return -1
	end

	-- do we have the charges on buffer?
	if HotbarSystem.QuantityChargesBuffer[objectType] then

		-- it's been less than a second from the last check?
		if HotbarSystem.QuantityChargesBuffer[objectType].timeStamp > Interface.TimeSinceLogin then
			
			-- we return the charges we have on buffer
			return HotbarSystem.QuantityChargesBuffer[objectType].qta
		end
	end

	-- default quantity value
	local quantity = -1

	-- getting the quantity array
	local objectQuantity = Interface.GetObjectQuantityData(objectType)
	
	-- do we have the informations?
	if objectQuantity then
		quantity = objectQuantity.quantity
	end

	return quantity
end

function GetItemAmount(itemId)

	-- do we have a valid item ID?
	if not IsValidID(itemId) then
		return 0
	end

	-- get the item data
	local itemData = Interface.GetObjectInfoData(itemId)

	-- do we have a valid item data?
	if itemData then

		return itemData.quantity
	end

	return 0
end

function GetItemContainerID(itemId)

	-- do we have a valid item ID?
	if not IsValidID(itemId) then
		return 0
	end

	-- get the item data
	local itemData = Interface.GetObjectInfoData(itemId)

	-- do we have the item data?
	if itemData then
		return itemData.containerId
	end

	return 0
end

function GetContainerItemsNumber(itemId)
	
	-- is a valid id?
	if not IsValidID(itemId) then
		return 0
	end

	-- getting the container data
	local data = Interface.GetContainersData(itemId, false)

	-- no container data? something is gone wrong...
	if not data then
		return 0
	end
	
	return data.numItems
end

function DoesPlayerHasCursorTarget()
	return WindowData.Cursor ~= nil and WindowData.Cursor.target == true
end

function CancelCursorTarget()

	-- is the cursor target active?
	if not DoesPlayerHasCursorTarget() then
		return
	end

	-- send another fake target request
	RequestTargetInfo()

	-- click an invalid ID to remove the target from the cursor
	HandleSingleLeftClkTarget(0)
end

-- tells what kind of target are allowed
-- return: noself, cursoronly
function GetActionTargetTypes(actionId, actionType)

	-- do we have a valid action?
	if not IsValidID(actionId) then
		return false, false
	end

	-- is this a spell?
	if (actionType == SystemData.UserAction.TYPE_SPELL) then

		-- scan all spells to determine the target types
		for _, value in pairs(SpellsInfo.SpellsData) do

			-- is this the spell we're looking for?
			if value.id == actionId then

				return value.noSelf, value.cursorOnly
			end
		end

	-- is this an item?
	elseif HotbarSystem.IsHotbarItem(actionType) then
		
		-- get the object type and hue for the item in the slot
		local objectType = UserActionUseObjectTypeGetObjectTypeHue(actionId)

		-- is this a spell scroll?
		if SpellsInfo.ScrollsToSpellID[objectType] then

			-- get the scroll's spell ID
			local spellId = SpellsInfo.ScrollsToSpellID[objectType]

			-- scan all spells to determine the target type
			for _, value in pairs(SpellsInfo.SpellsData) do

				-- is this the spell we're looking for?
				if value.id == spellId then

					return value.noSelf, value.cursorOnly
				end
			end
		end
	end

	-- eval int is the only skill usable on self
	if type == SystemData.UserAction.TYPE_SKILL and actionId ~= 9 then
		return true, false
	end

	return false, false
end

function CreateTextFile(fileName, text)

	-- do we have valid parameters?
	if not IsValidString(fileName) or not IsValidWString(text) then
		return
	end
	
	-- log name
	local ts = "FILEWRITER" .. Interface.Clock.Timestamp

	-- create the log
	TextLogCreate(ts, 1)

	-- activate the log
	TextLogSetEnabled(ts, true)

	-- clear the log
	TextLogClear(ts)

	-- create the log file
	TextLogSetIncrementalSaving(ts, true, fileName)

	-- write the text
	TextLogAddEntry(ts, 1, text)

	-- destroy the log and close the file
	TextLogDestroy(ts)
end

function CreateMultilineTextFile(fileName, text)

	-- do we have valid parameters?
	if not IsValidString(fileName) or not IsValidWString(text) then
		return
	end

	-- log name
	local ts = "FILEWRITER" .. Interface.Clock.Timestamp

	-- create the log
	TextLogCreate(ts, 1)

	-- activate the log
	TextLogSetEnabled(ts, true)

	-- clear the log
	TextLogClear(ts)

	-- create the log file
	TextLogSetIncrementalSaving(ts, true, fileName)

	-- split the text lines
	local totalText = wstring.split(text, L"\n")

	-- scan all the text lines
	for i, txt in pairsByIndex(totalText) do
		
		-- write the text
		TextLogAddEntry(ts, txt, txt)
	end

	-- destroy the log and close the file
	TextLogDestroy(ts)
end

function ForceExecuteTarget(targetId)
	
	-- set the target to force
	Interface.ForceTarget = targetId

	-- if the target doesn't happen in half second, we cancel it
	Interface.AddTodoList({name = "reset forced target", func = function() Interface.ForceTarget = nil end, time = Interface.TimeSinceLogin + 0.5})
end

function GetFollowersCount()

	-- do we have the followers data?
	if not WindowData.PlayerStatus or not WindowData.PlayerStatus["MaxFollowers"] or not Interface.started then
		return 0
	end

	return tonumber(WindowData.PlayerStatus["Followers"])
end

function GetControllableFollowersCount()
	
	-- does the player have any pet
	if GetFollowersCount() <= 0 then
		return 0
	end

	-- controllable followers count
	local count = 0

	-- scan the mobiles on screen
	for mobileId, mobileData in pairs(Interface.ActiveMobilesOnScreen) do

		-- if it's not a pet we can skip this one
		if not IsObjectIdPet(mobileId) then
			continue
		end

		-- is this a controllable summon or not a summon and not a familiar or a mirror image?
		if (not mobileData.isSummon or (mobileData.isSummon and mobileData.isControllableSummon)) and not mobileData.isFamiliar and not wstring.find(GetMobileName(GetPlayerID()), GetMobileName(mobileId), 1, true) then

			-- increase the controllable summons count
			count = count + 1
		end
	end

	return count
end

function GetDistanceBetweenPoints(x1, y1, x2, y2)

	-- calculate the distance between 2 points
	return math.sqrt( ((x2 - x1) ^ 2) + ((y2 - y1) ^ 2) )
end

function ToggleWindowByName(wndName, btnName, onOpenFunction, onCloseFunction)

	-- make sure we have a valid window name
	if not IsValidString(wndName) then
		return
	end

	-- does this window need to be destroyed on close?
	if Interface.DestroyWindowOnClose[wndName] or not DoesWindowExist(wndName) then
		
		-- does the window exist?
		if DoesWindowExist(wndName) then

			-- destroy the window
			DestroyWindow(wndName)

			-- do we have a function to execute on close?
			if onCloseFunction ~= nil then

				-- execute the function
				onCloseFunction()
			end

		else -- window doesn't exist

			-- create the window
			CreateWindow(wndName, true)

			-- do we have a function to execute on open?
			if onOpenFunction ~= nil then

				-- execute the function
				onOpenFunction()
			end
		end

	else -- just hide

		-- does the window exist?
		if not DoesWindowExist(wndName) then
			return
		end
		
		-- set the new visibility flag
		local showing = not WindowGetShowing(wndName)
		
		-- invert the window visibility status
		WindowSetShowing(wndName, showing)
	
		-- do we have a valid button name?
		if IsValidString(btnName) then

			-- set the button as pressed
			ButtonSetPressedFlag(btnName, showing)
		end

		-- do we have a function to execute on open?
		if onOpenFunction ~= nil and showing == true then

			-- execute the function
			onOpenFunction()

		-- do we have a function to execute on close?
		elseif onCloseFunction ~= nil and showing == false then

			-- execute the function
			onCloseFunction()
		end
	end
end

-- DO NOT USE, CURRENTLTY BUGGED
function SetCurrentTarget(targetId)
	
	-- clear the current target
	ClearCurrentTarget()

	-- set the new target ID
	WindowData.CurrentTarget.TargetId = targetId

	-- is this a mobile?
	if IsMobile(targetId) then
	
		-- set the target type
		WindowData.CurrentTarget.TargetType = TargetWindow.MobileType

		-- check if the mobile has the paperdoll
		WindowData.CurrentTarget.HasPaperdoll = DoesBodyHasPaperdoll(mobileId)

	-- is the new target a corpse?
	elseif IsCorpse(targetId) then

		-- set the target type
		WindowData.CurrentTarget.TargetType = TargetWindow.CorpseType

	else -- the new target is an object
		WindowData.CurrentTarget.TargetType = TargetWindow.ObjectType
	end

	-- flag that we have a target now
	WindowData.CurrentTarget.HasTarget = true
	
	-- trigger the new target event
	BroadcastEvent(WindowData.CurrentTarget.Event)
end

function SendOverheadText(message, hue, mobileID)

	-- set the message to show
	SystemData.Text = message

	-- set the overhead text channel
	SystemData.TextChannelID = 2

	-- use the specified mobile ID or the player ID if the mobile is not specified
	SystemData.TextSourceID = mobileID or GetPlayerID()

	-- remove the source name if the mobile id has not being specified
	SystemData.SourceName = inlineIf(mobileID, GetMobileName(mobileId), nil)

	-- set the text hue
	SystemData.TextColor = hue
	
	-- call the new message event
	BroadcastEvent(SystemData.Events.TEXT_ARRIVED)
end

function ChatPrint(text, channel)

	-- no channel specified?
	if not channel then

		-- print on system
		channel = SystemData.ChatLogFilters.SYSTEM
	end

	-- invalid text?
	if not IsValidWString(text) then

		-- convert to wstring
		text = towstring(tostring(text))
	end

	-- is the new chat enabled?
	if Interface.Settings.chat_useNewChat then

		-- create the chat line data
		local logVal = { text = text, channel = channel, color = ChatSettings.ChannelColors[channel], sourceId = 0, sourceName = "", ignore = false, category = 0, timeStamp = towstring(string.format("%02.f", Interface.Clock.h) .. ":" .. string.format("%02.f", Interface.Clock.m) .. ":" .. string.format("%02.f", Interface.Clock.s)) }

		-- add the chat line to the chat log
		table.insert(NewChatWindow.Messages, logVal)

		-- add the chat line to the save log
		table.insert(NewChatWindow.Setting.Messages, logVal)

		-- show the message in chat
		NewChatWindow.UpdateLog()

	else -- send the message to the chat log
		PrintWStringToChatWindow(text, channel)
	end
end