----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

CharacterAbilities = {}

CharacterAbilities.TID = {CharacterAbilities=1112228, WEAPON=1112229, RACIAL=1112230, Weapon=1062759, ITEM=1152335,
							Active=1112231, Index=3010003, Passive=1112232, PrimaryAbility=1062105, SecondaryAbility=1062106}

CharacterAbilities.WEAPONABILITY_OFFSET = 1000
CharacterAbilities.RACIALABILITY_OFFSET = 3000
CharacterAbilities.ITEMPROPERTY_OFFSET =  5000

CharacterAbilities.WEAPONABILITY_MAX = 31

CharacterAbilities.ITEMPROPICON = 3015

CharacterAbilities.MaxRacialAbilities = 0

CharacterAbilities.PropertyTable = {}

function CharacterAbilities.Initialize()
	local windowName = "CharacterAbilities"
	
	WindowUtils.SetWindowTitle(windowName, GetStringFromTid(CharacterAbilities.TID.CharacterAbilities) )

	ButtonSetText(windowName.."TabButton1", GetStringFromTid(CharacterAbilities.TID.WEAPON))
	ButtonSetText(windowName.."TabButton2", GetStringFromTid(CharacterAbilities.TID.RACIAL))
	ButtonSetText(windowName.."TabButton3", GetStringFromTid(CharacterAbilities.TID.ITEM))
	
	CharacterAbilities.UnselectAllTabs(windowName, 3)
	CharacterAbilities.SelectTab(windowName, 1)

	CharacterAbilities.InitWeaponTab()
	CharacterAbilities.InitRacialTab()
	
	UOBuildTableFromCSV("Data/GameData/itemprop.csv", "PlayerItemPropCSV")	
	CharacterAbilities.InitItemPropInfoTab()
	
	WindowRegisterEventHandler( "CharacterAbilities", WindowData.PlayerStatus.Event, "CharacterAbilities.UpdateRacialTab")	
	WindowRegisterEventHandler( "CharacterAbilities", SystemData.Events.ABILITY_DISPLAY_ACTIVE, "CharacterAbilities.ActivateWeaponAbility")
	WindowRegisterEventHandler( "CharacterAbilities", SystemData.Events.ABILITY_RESET, "CharacterAbilities.ResetWeaponAbility")
	WindowUtils.RestoreWindowPosition("CharacterAbilities")
	
end

function CharacterAbilities.Shutdown()
	CharacterAbilities.ShutdownWeaponTab()
	CharacterAbilities.ShutdownRacialTab()
	CharacterAbilities.ShutdownItemPropInfo()
	WindowUtils.SaveWindowPosition("CharacterAbilities")
end

function CharacterAbilities.OnShown()
	if( WindowData.PlayerStatus ~= nil and WindowData.PlayerStatus.PlayerId ~= nil ) then
        local paperdollWindow = "PaperdollWindow"..WindowData.PlayerStatus.PlayerId
        if( DoesWindowNameExist(paperdollWindow) ) then
            ButtonSetPressedFlag(paperdollWindow.."ToggleCharacterAbilities",true)
			CharacterAbilities.UpdateItemPropInfo()
        end		
    end
end

function CharacterAbilities.OnHidden()
	if( WindowData.PlayerStatus ~= nil and WindowData.PlayerStatus.PlayerId ~= nil ) then
        local paperdollWindow = "PaperdollWindow"..WindowData.PlayerStatus.PlayerId
        if( DoesWindowNameExist(paperdollWindow) ) then
            ButtonSetPressedFlag(paperdollWindow.."ToggleCharacterAbilities",false)
        end
    end
end

function CharacterAbilities.ToggleTab()
	local parent = "CharacterAbilities"
	local buttonId = WindowGetId(SystemData.ActiveWindow.name)	
	CharacterAbilities.UnselectAllTabs("CharacterAbilities", 3)
	CharacterAbilities.SelectTab(parent, buttonId)
end

function CharacterAbilities.UnselectAllTabs(parent, numTabs)
	for i = 1, numTabs do
		local tabName = parent.."TabButton"..i
		local tabSelected = tabName.."TabSelected"
		local tabWindow = parent.."TabWindow"..i
		WindowSetShowing(tabSelected, false)
		WindowSetShowing(tabWindow, false)
		ButtonSetDisabledFlag(tabName, false)
	end
end

function CharacterAbilities.SelectTab(parent, tabNum)
	local tabName = parent.."TabButton"..tabNum
	local tabSelected= tabName.."TabSelected"
	local tabWindow = parent.."TabWindow"..tabNum
	WindowSetShowing(tabSelected, true)
	WindowSetShowing(tabWindow, true)
	ButtonSetDisabledFlag(tabName, true)
end

function CharacterAbilities.InitWeaponTab()
	LabelSetText("CharacterAbilitiesTabWindow1ScrollWindowScrollChildActive", GetStringFromTid(CharacterAbilities.TID.Active))
	LabelSetText("CharacterAbilitiesTabWindow1ScrollWindowScrollChildIndex", GetStringFromTid(CharacterAbilities.TID.Index))
	
	local baseItemName = "CharacterAbilitiesTabWindow1ScrollWindowScrollChildItem"
	
	-- Show primary/secondary weapon abilities
	for i=1,2 do
		local currentWindowName = baseItemName.."Active"..i
		
		if (DoesWindowExist(currentWindowName)) then
			DestroyWindow(currentWindowName)
		end
		CreateWindowFromTemplate( currentWindowName, "CharacterAbilityDef", "CharacterAbilitiesTabWindow1ScrollWindowScrollChild" )

		WindowClearAnchors(currentWindowName)
		if (i==1) then
 			WindowAddAnchor( currentWindowName, "bottomleft", "CharacterAbilitiesTabWindow1ScrollWindowScrollChildActive", "topleft", -10, 0)
		else
			WindowAddAnchor( currentWindowName, "bottomleft", baseItemName.."Active"..(i-1), "topleft", 0, 0)
		end
		
		local abilityId = EquipmentData.GetWeaponAbilityId(i) + CharacterAbilities.WEAPONABILITY_OFFSET
		local icon, serverId, tid, desctid = GetAbilityData(abilityId)
		local iconTexture, x, y = GetIconData(icon)
		
		DynamicImageSetTexture(currentWindowName.."SquareIcon", iconTexture, x, y)
		WindowSetShowing(currentWindowName.."Disabled", false)
		
		LabelSetTextColor(currentWindowName.."Name", 255, 255, 255)
		LabelSetText(currentWindowName.."Name", GetStringFromTid(tid))
		
		LabelSetTextColor(currentWindowName.."SubText", 240, 200, 0)
		if (i == 1) then
			LabelSetText(currentWindowName.."SubText", GetStringFromTid(CharacterAbilities.TID.PrimaryAbility))
		elseif (i == 2) then
			LabelSetText(currentWindowName.."SubText", GetStringFromTid(CharacterAbilities.TID.SecondaryAbility))
		end
		WindowSetShowing(currentWindowName.."SubText", true)
		
		WindowSetShowing(currentWindowName, true)
		
		WindowSetId(currentWindowName, abilityId)
		WindowSetId(currentWindowName.."SquareIcon", abilityId)
	end
	
	-- Show all weapon abilities
	for i=1,CharacterAbilities.WEAPONABILITY_MAX do
		local currentWindowName = baseItemName.."All"..i
		
		if (DoesWindowExist(currentWindowName)) then
			DestroyWindow(currentWindowName)
		end
		CreateWindowFromTemplate( currentWindowName, "CharacterAbilityDef", "CharacterAbilitiesTabWindow1ScrollWindowScrollChild" )

		WindowClearAnchors(currentWindowName)
		if (i==1) then
 			WindowAddAnchor( currentWindowName, "bottomleft", "CharacterAbilitiesTabWindow1ScrollWindowScrollChildIndex", "topleft", -10, 0)
		else
			WindowAddAnchor( currentWindowName, "bottomleft", baseItemName.."All"..(i-1), "topleft", 0, 0)
		end
		
		local abilityId = i + CharacterAbilities.WEAPONABILITY_OFFSET
		local icon, serverId, tid, desctid = GetAbilityData(abilityId)
		local iconTexture, x, y = GetIconData(icon)
		
		DynamicImageSetTexture(currentWindowName.."SquareIcon", iconTexture, x, y)
		
		LabelSetTextColor(currentWindowName.."Name", 128, 128, 128)
		LabelSetText(currentWindowName.."Name", GetStringFromTid(tid))
		
		WindowSetShowing(currentWindowName.."SubText", false)
		
		WindowSetShowing(currentWindowName, true)
		
		WindowSetId(currentWindowName, abilityId)
		WindowSetId(currentWindowName.."SquareIcon", abilityId)
	end
end

function CharacterAbilities.ShutdownWeaponTab()
	local baseItemName = "CharacterAbilitiesTabWindow1ScrollWindowScrollChildItem"
	
	for i=1,2 do
		local currentWindowName = baseItemName.."Active"..i
		
		if (DoesWindowExist(currentWindowName)) then
			DestroyWindow(currentWindowName)
		end
	end
	
	for i=1,CharacterAbilities.WEAPONABILITY_MAX do
		local currentWindowName = baseItemName.."All"..i
		
		if (DoesWindowExist(currentWindowName)) then
			DestroyWindow(currentWindowName)
		end
	end
end

function CharacterAbilities.UpdateWeaponAbilities()
	local baseItemName = "CharacterAbilitiesTabWindow1ScrollWindowScrollChildItem"
	
	if (not DoesWindowExist(baseItemName.."Active1") or not DoesWindowExist(baseItemName.."Active2")) then
		CharacterAbilities.InitWeaponTab()
	end
	
	for i=1,2 do
		local currentWindowName = baseItemName.."Active"..i		
		local abilityId = EquipmentData.GetWeaponAbilityId(i) + CharacterAbilities.WEAPONABILITY_OFFSET
		local icon, serverId, tid, desctid = GetAbilityData(abilityId)
		local iconTexture, x, y = GetIconData(icon)
		
		DynamicImageSetTexture(currentWindowName.."SquareIcon", iconTexture, x, y)
		LabelSetText(currentWindowName.."Name", GetStringFromTid(tid))
		
		WindowSetId(currentWindowName, abilityId)
		WindowSetId(currentWindowName.."SquareIcon", abilityId)
	end
end

function CharacterAbilities.ActivateWeaponAbility()
	local abilityId = GameData.Abilities.ActiveAbility
	local type = GameData.Abilities.ActiveAbilityType
	
	if( type == SystemData.UserAction.TYPE_WEAPON_ABILITY ) then
		local abilityIndex = 0		
		if( abilityId == EquipmentData.CurrentWeaponAbilities[EquipmentData.WEAPONABILITY_PRIMARY] ) then
			abilityIndex = EquipmentData.WEAPONABILITY_PRIMARY
		elseif( abilityId == EquipmentData.CurrentWeaponAbilities[EquipmentData.WEAPONABILITY_SECONDARY] ) then
			abilityIndex = EquipmentData.WEAPONABILITY_SECONDARY
		end
		
		local baseItemName = "CharacterAbilitiesTabWindow1ScrollWindowScrollChildItem"
		if (not DoesWindowExist(baseItemName.."Active1") or not DoesWindowExist(baseItemName.."Active2")) then
			CharacterAbilities.InitWeaponTab()
		end
		
		for i=1,2 do
			if (i == abilityIndex) then
				local currentWindowName = baseItemName.."Active"..i
				WindowSetTintColor(currentWindowName.."SquareIcon",255,0,0)
			end
		end
	end
end

function CharacterAbilities.ResetWeaponAbility()
	local baseItemName = "CharacterAbilitiesTabWindow1ScrollWindowScrollChildItem"
	if (not DoesWindowExist(baseItemName.."Active1") or not DoesWindowExist(baseItemName.."Active2")) then
		CharacterAbilities.InitWeaponTab()
	end
		
	for i=1,2 do
		local currentWindowName = baseItemName.."Active"..i
		WindowSetTintColor(currentWindowName.."SquareIcon",255,255,255)
	end
end

function CharacterAbilities.InitRacialTab()
	local baseItemName = "CharacterAbilitiesTabWindow2ScrollWindowScrollChildItem"
	
	CharacterAbilities.MaxRacialAbilities = GetMaxRacialAbilities()
	
	-- Show racial abilities
	for i=1,CharacterAbilities.MaxRacialAbilities do
		local currentWindowName = baseItemName..i
		
		if (DoesWindowExist(currentWindowName)) then
			DestroyWindow(currentWindowName)
		end
		CreateWindowFromTemplate( currentWindowName, "CharacterAbilityDef", "CharacterAbilitiesTabWindow2ScrollWindowScrollChild" )

		WindowClearAnchors(currentWindowName)
		if (i==1) then
 			WindowAddAnchor( currentWindowName, "topleft", "CharacterAbilitiesTabWindow2ScrollWindowScrollChild", "topleft", 0, 0)
		else
			WindowAddAnchor( currentWindowName, "bottomleft", baseItemName..(i-1), "topleft", 0, 0)
		end
		
		local abilityId = GetRacialAbilityId(i) + CharacterAbilities.RACIALABILITY_OFFSET
		local icon, serverId, tid = GetAbilityData(abilityId)
		local iconTexture, x, y = GetIconData(icon)
		
		DynamicImageSetTexture(currentWindowName.."SquareIcon", iconTexture, x, y)
		WindowSetShowing(currentWindowName.."Disabled", false)
		
		LabelSetTextColor(currentWindowName.."Name", 255, 255, 255)
		LabelSetText(currentWindowName.."Name", GetStringFromTid(tid))
		
		if (serverId == 0) then
			LabelSetTextColor(currentWindowName.."SubText", 240, 200, 0)
			LabelSetText(currentWindowName.."SubText", GetStringFromTid(CharacterAbilities.TID.Passive))
			WindowSetShowing(currentWindowName.."SubText", true)
		else
			WindowSetShowing(currentWindowName.."SubText", false)
		end
		
		WindowSetShowing(currentWindowName, true)
		
		WindowSetId(currentWindowName, abilityId)
		WindowSetId(currentWindowName.."SquareIcon", abilityId)
	end
	
	ScrollWindowUpdateScrollRect("CharacterAbilitiesTabWindow2ScrollWindow")
end

function CharacterAbilities.ShutdownRacialTab()
	local baseItemName = "CharacterAbilitiesTabWindow2ScrollWindowScrollChildItem"
	
	for i=1,CharacterAbilities.MaxRacialAbilities do
		local currentWindowName = baseItemName..i
		
		if (DoesWindowExist(currentWindowName)) then
			DestroyWindow(currentWindowName)
		end
	end
end

function CharacterAbilities.UpdateRacialTab()
	if (CharacterAbilities.MaxRacialAbilities ~= GetMaxRacialAbilities()) then
		CharacterAbilities.ShutdownRacialTab()
		CharacterAbilities.InitRacialTab()
	end
end

function CharacterAbilities.ItemMouseOver()
	local id = WindowGetId(SystemData.ActiveWindow.name)
	local itemData = {}
	if (id > CharacterAbilities.WEAPONABILITY_OFFSET and id < CharacterAbilities.WEAPONABILITY_OFFSET + 1000) or
	(id > CharacterAbilities.RACIALABILITY_OFFSET and id < CharacterAbilities.RACIALABILITY_OFFSET + 1000) then
		local icon, serverId, tid, desctid, weapons = GetAbilityData(id)
	
		local weaponsStr = L""
		if(weapons ~= nil and weapons ~= "") then
			weaponsStr = L"<BR>== "..GetStringFromTid(CharacterAbilities.TID.Weapon)..L" ==<BR>"..StringToWString(weapons)
		end
		
		itemData = { windowName = this,
							itemId = id,
							itemType = WindowData.ItemProperties.TYPE_ACTION,
							actionType = SystemData.UserAction.TYPE_SPELL,
							detail = ItemProperties.DETAIL_LONG,
							body = weaponsStr }						
		ItemProperties.SetActiveItem(itemData)
		
	elseif (id > CharacterAbilities.ITEMPROPERTY_OFFSET and id < CharacterAbilities.ITEMPROPERTY_OFFSET + 1000) then
			
		local descriptionStr = L"<BR>"..GetStringFromTid(WindowData.PlayerItemPropCSV[id - CharacterAbilities.ITEMPROPERTY_OFFSET].DescriptionTID)..L" <BR>"
		
		itemData = { windowName = this,
							itemId = id,
							itemType = WindowData.ItemProperties.TYPE_ACTION,
							actionType = SystemData.UserAction.TYPE_SPELL,
							detail = ItemProperties.DETAIL_LONG,
							body = descriptionStr}
							
		ItemProperties.SetActiveItem(itemData)		
	end
end

function CharacterAbilities.ItemLButtonDown()
	local iconId = WindowGetId(SystemData.ActiveWindow.name)
	
	if (iconId > CharacterAbilities.WEAPONABILITY_OFFSET and iconId < CharacterAbilities.WEAPONABILITY_OFFSET + 1000) then
		for i=1,2 do			
			local abilityId = EquipmentData.GetWeaponAbilityId(i) + CharacterAbilities.WEAPONABILITY_OFFSET
			if (abilityId == iconId) then
				DragSlotSetActionMouseClickData(SystemData.UserAction.TYPE_WEAPON_ABILITY,i,iconId)
				break
			end
		end
	elseif (iconId > CharacterAbilities.RACIALABILITY_OFFSET and iconId < CharacterAbilities.RACIALABILITY_OFFSET + 1000) then
		local icon, serverId = GetAbilityData(iconId)
		if (serverId ~= 0) then
			DragSlotSetActionMouseClickData(SystemData.UserAction.TYPE_RACIAL_ABILITY,serverId,iconId)
		end
	end
end

function CharacterAbilities.ItemLButtonUp()
	local iconId = WindowGetId(SystemData.ActiveWindow.name)
	
	if (iconId > CharacterAbilities.WEAPONABILITY_OFFSET and iconId < CharacterAbilities.WEAPONABILITY_OFFSET + 1000) then
		for i=1,2 do			
			local abilityId = EquipmentData.GetWeaponAbilityId(i) + CharacterAbilities.WEAPONABILITY_OFFSET
			if (abilityId == iconId) then
				UserActionUseWeaponAbility(i)
			end
		end
	elseif (iconId > CharacterAbilities.RACIALABILITY_OFFSET and iconId < CharacterAbilities.RACIALABILITY_OFFSET + 1000) then
		local icon, serverId = GetAbilityData(iconId)
		if (serverId ~= 0) then
			UserActionUseRacialAbility(serverId)
		end	
	end	
end

function CharacterAbilities.InitItemPropInfoTab()
	LabelSetText("CharacterAbilitiesTabWindow3ScrollWindowScrollChildActive", GetStringFromTid(CharacterAbilities.TID.Active))
	LabelSetText("CharacterAbilitiesTabWindow3ScrollWindowScrollChildIndex", GetStringFromTid(CharacterAbilities.TID.Index))
	
	local baseItemName = "CharacterAbilitiesTabWindow3ScrollWindowScrollChildItem"
	local playerId = WindowData.PlayerStatus.PlayerId
	local paperdollWindowName = "PaperdollWindow"..playerId 	
	local numTotalItemProps = CSVUtilities.getNumRows(WindowData.PlayerItemPropCSV)
	
	if(WindowData.Paperdoll[playerId] == nil ) then			
		return
	end	

	-- Show available item properties	
	CharacterAbilities.PropertyTable = {}
	for index = 1, WindowData.Paperdoll[playerId].numSlots do
		if (WindowData.Paperdoll[playerId][index].slotId ~= 0) then
			local objectId = WindowData.Paperdoll[playerId][index].slotId
			RegisterWindowData(WindowData.ObjectInfo.Type, objectId)			
			local props = ItemProperties.GetObjectProperties(objectId)						
			if not props then
				continue
			end			
			local propLen = #props			
			for i = 1, propLen do				
				local currentTID = 0				
				for propIndex = 1, numTotalItemProps do
					currentTID = WindowData.PlayerItemPropCSV[propIndex].TID
					if (currentTID ~= 0) then
						local text = nil
						local currentTIDText = wstring.lower(GetStringFromTid(currentTID))
						local exactMatch = WindowData.PlayerItemPropCSV[propIndex].MatchExact
						currentTIDText = CharacterAbilities.RemoveAfterSymbol(currentTIDText,"~")																			
						local cleanProp = CharacterAbilities.RemoveAfterSymbol(props[i],"%d")						
						if(exactMatch ~= 0) then 																				
							if(wstring.find(wstring.lower(props[i]),currentTIDText) == 1)then								
								text = currentTIDText
							end												
						else						
							text = wstring.find(wstring.lower(props[i]),currentTIDText)
						end
						if ( text ~= nil ) then					
							-- Append to active List								
							CharacterAbilities.PropertyTable[propIndex] = propIndex							
							break
						end
					end
				end					
			end
		end		
	end
		
	--for i=1,table.getn(CharacterAbilities.PropertyTable) do
	local tabelIdx = 1
	for i,k in pairs(CharacterAbilities.PropertyTable) do
		local currentWindowName = baseItemName.."Active"..tabelIdx		
		if (DoesWindowExist(currentWindowName)) then
			DestroyWindow(currentWindowName)
		end
		CreateWindowFromTemplate( currentWindowName, "CharacterAbilityDef", "CharacterAbilitiesTabWindow3ScrollWindowScrollChild" )				
		
		if (tabelIdx==1) then
 			WindowAddAnchor(currentWindowName, "bottomleft", "CharacterAbilitiesTabWindow3ScrollWindowScrollChildActive", "topleft", -10, 0)			
		else
			WindowAddAnchor( currentWindowName, "bottomleft", baseItemName.."Active"..(tabelIdx-1), "topleft", 0, 0)
			
		end	
		
		local currentPropIdx = i
		local itemPropId = currentPropIdx + CharacterAbilities.ITEMPROPERTY_OFFSET
		local tid = WindowData.PlayerItemPropCSV[currentPropIdx].TID		
		if(tid == 0)then		
			continue
		end				
		local iconTexture, x, y = GetIconData(CharacterAbilities.ITEMPROPICON)
		
		DynamicImageSetTexture(currentWindowName.."SquareIcon", iconTexture, x, y)
		WindowSetShowing(currentWindowName.."Disabled", false)
		
		-- Display Item Prop Name
		LabelSetTextColor(currentWindowName.."Name", 255, 255, 255)
		LabelSetText(currentWindowName.."Name", CharacterAbilities.RemoveAfterSymbol(GetStringUpppercaseFromTid(tid),"~"))		
		WindowSetShowing(currentWindowName, true)		
		
		WindowSetId(currentWindowName, itemPropId)
		WindowSetId(currentWindowName.."SquareIcon", itemPropId)
		tabelIdx = tabelIdx + 1
	end
	
	local displayOffset = tabelIdx - 1 		
	WindowClearAnchors("CharacterAbilitiesTabWindow3ScrollWindowScrollChildIndex")
	
	if(displayOffset ~= 0) then		 		
		WindowAddAnchor( "CharacterAbilitiesTabWindow3ScrollWindowScrollChildIndex", "bottomleft", baseItemName.."Active"..displayOffset, "topleft", 10, 0)
	else
		WindowAddAnchor( "CharacterAbilitiesTabWindow3ScrollWindowScrollChildIndex", "bottomleft", "CharacterAbilitiesTabWindow3ScrollWindowScrollChildActive", "topleft", 0, 200)
	end
	-- Show all item properties
	tabelIdx = 1
	for i=1,numTotalItemProps do
		local currentWindowName = baseItemName.."All"..tabelIdx
		
		if (DoesWindowExist(currentWindowName)) then
			DestroyWindow(currentWindowName)
		end
		
		local itemPropId = i + CharacterAbilities.ITEMPROPERTY_OFFSET
		local tid = WindowData.PlayerItemPropCSV[i].TID		
		local iconTexture, x, y = GetIconData(CharacterAbilities.ITEMPROPICON)				
		if(tid == 0)then		
			continue
		end		
		
		CreateWindowFromTemplate( currentWindowName, "CharacterAbilityDef", "CharacterAbilitiesTabWindow3ScrollWindowScrollChild" )
		WindowClearAnchors(currentWindowName)
		
		if (tabelIdx==1) then
			if(displayOffset == 0) then
				WindowAddAnchor(currentWindowName, "bottomleft", "CharacterAbilitiesTabWindow3ScrollWindowScrollChildIndex", "topleft", -10, 0)
			else 
				WindowAddAnchor(currentWindowName, "bottomleft", baseItemName.."Active"..displayOffset, "topleft", 0, 25)
			end 						
		else
			WindowAddAnchor( currentWindowName, "bottomleft", baseItemName.."All"..(tabelIdx-1), "topleft", 0, 0)			
		end
		
		
		DynamicImageSetTexture(currentWindowName.."SquareIcon", iconTexture, x, y)		
		LabelSetTextColor(currentWindowName.."Name", 128, 128, 128)
		LabelSetText(currentWindowName.."Name", CharacterAbilities.RemoveAfterSymbol(GetStringUpppercaseFromTid(tid),"~"))		
		WindowSetShowing(currentWindowName.."SubText", false)		
		WindowSetShowing(currentWindowName, true)
		WindowSetId(currentWindowName,itemPropId)
		WindowSetId(currentWindowName.."SquareIcon", itemPropId)
		tabelIdx = tabelIdx + 1
	end
end

function CharacterAbilities.ShutdownItemPropInfo()
	local baseItemName = "CharacterAbilitiesTabWindow3ScrollWindowScrollChildItem"
	UOUnloadCSVTable("PlayerItemPropCSV")
	
	local tabelIdx = 1
	for i,k in pairs(CharacterAbilities.PropertyTable) do
		local currentWindowName = baseItemName.."Active"..tabelIdx		
		if (DoesWindowExist(currentWindowName)) then
			DestroyWindow(currentWindowName)
		end
		tabelIdx = tabelIdx + 1
	end
	CharacterAbilities.PropertyTable = {}
	local numTotalItemProps = CSVUtilities.getNumRows(WindowData.PlayerItemPropCSV)
	for i=1,CharacterAbilities.numTotalItemProps do
		local currentWindowName = baseItemName.."All"..i		
		if (DoesWindowExist(currentWindowName)) then
			DestroyWindow(currentWindowName)
		end
	end
end

function CharacterAbilities.UpdateItemPropInfo()	
	local baseItemName = "CharacterAbilitiesTabWindow3ScrollWindowScrollChildItem"
	local tabelIdx = 1
	for i,k in pairs(CharacterAbilities.PropertyTable) do
		local currentWindowName = baseItemName.."Active"..tabelIdx		
		if (DoesWindowExist(currentWindowName)) then
			DestroyWindow(currentWindowName)
		end
		tabelIdx = tabelIdx + 1
	end
	CharacterAbilities.InitItemPropInfoTab()	
end

function CharacterAbilities.RemoveAfterSymbol(currentString,symbol)
	local text = nil
	text = wstring.find(currentString,towstring(symbol))
	if ( text ~= nil ) then							
		text = text - 1
		currentString = wstring.sub(currentString,1,text)		
		text = nil
	end
	return currentString
end