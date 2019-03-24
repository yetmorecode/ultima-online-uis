----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

ItemProperties = {}

ItemProperties.DETAIL_SHORT = 1
ItemProperties.DETAIL_LONG = 2

ItemProperties.CurrentItemData = {}

ItemProperties.TITLE_COLOR = { r=243, g=227, b=49 }
ItemProperties.BODY_COLOR = { r=255, g=255, b=255 }

ItemProperties.VirtueData = {}
ItemProperties.VirtueData[1]	= { iconId = 701, nameTid = 1051005, detailTid=1052058 } -- Honor
ItemProperties.VirtueData[2]	= { iconId = 706, nameTid = 1051001, detailTid=1052053 } -- Sacrifice
ItemProperties.VirtueData[3]	= { iconId = 700, nameTid = 1051004, detailTid=1052057 } -- Valor
ItemProperties.VirtueData[4]	= { iconId = 702, nameTid = 1051002, detailTid=1053000 } -- Compassion
ItemProperties.VirtueData[5]	= { iconId = 704, nameTid = 1051007, detailTid=1052060 } -- Honesty
ItemProperties.VirtueData[6]	= { iconId = 707, nameTid = 1051000, detailTid=1052051 } -- Humility
ItemProperties.VirtueData[7]	= { iconId = 703, nameTid = 1051006, detailTid=1052059 } -- Justice
ItemProperties.VirtueData[8]	= { iconId = 705, nameTid = 1051003, detailTid=1052056 } -- Spirituality

---------------------------------------------------------------
-- MainMenuWindow Functions
----------------------------------------------------------------

-- OnInitialize Handler
function ItemProperties.Initialize()
	WindowSetAlpha("ItemPropertiesFrame", 1)
	
	WindowData.ItemProperties.numLabels = 0
	
	RegisterWindowData(WindowData.ItemProperties.Type, 0)
	WindowRegisterEventHandler( "ItemProperties", SystemData.Events.UPDATE_ITEM_PROPERTIES, "ItemProperties.UpdateItemPropertiesData")
end

function ItemProperties.Shutdown()
	UnregisterWindowData(WindowData.ItemProperties.Type, 0)
end

function ItemProperties.UpdateItemPropertiesData()
	if WindowData.ItemProperties.CurrentHover == 0 then
		return
	end
	--Debug.Print("UpdateItemPropertiesData Enter")
	local this = WindowUtils.GetActiveDialog()
	local id = WindowData.ItemProperties.CurrentHover
	local labelText = {}
	local labelColors = {}
	local numLabels = 0
	
	-- update the item type incase it has changed from code
	ItemProperties.CurrentItemData.itemType = WindowData.ItemProperties.CurrentType
	
	ItemProperties.HideAllPropsLabels()
	--Debug.Print("WindowData")
	--Debug.Print(WindowData)
	--Debug.Print("WindowData.ItemProperties")
	--Debug.Print(WindowData.ItemProperties)
	--Debug.Print("ItemProperties.CurrentItemData")
	--Debug.Print(ItemProperties.CurrentItemData)

	if( ItemProperties.CurrentItemData.itemType == WindowData.ItemProperties.TYPE_ITEM ) then
		-- use instance id 0 for the current item properties object
		data = WindowData.ItemProperties[0]
	
		-- BUG: Causes bug with opening corpses....
		--itemInfo = ItemProperties.GetExtendedInfo(id, true)
		--Debug.Print(itemInfo)

		if data and data.PropertiesList then

			propList = data.PropertiesList
			propLen = table.getn(propList)			
			colorList = data.ColorList
			colorLen = table.getn(colorList)
			
			local isjewel

			for i = 1, propLen do

				-- my stuff
				local mycolor = { r=255, g=255, b=255 }
				local blah = string.lower(tostring(propList[i]))
				if ((string.find(blah, "ring") and string.find(blah, "splinter") == nil) or string.find(blah, "bracelet"))  then
					isjewel = true
				end

				if isjewel == true and string.find(blah, "swing") then
					mycolor = { r=0, g=255, b=0 } 
				end

				if(string.find(blah,"luck")) then
					--Debug.Print(string.sub(blah, string.len(blah) - 3))
					local luck = tonumber(string.sub(blah, string.len(blah) - 3))
					if(luck ~= nil and luck >= 100) then
						--mycolor = { r=0, g=255, b=0 }
					end
				end

				if(isjewel and (string.find(blah,"spell damage") or string.find(blah,"hit chance") or string.find(blah,"defense chance"))) then
					--Debug.Print(string.sub(blah, -3, -2))
					local spelldamage = tonumber(string.sub(blah, -3, -2))
					if(spelldamage ~= nil and spelldamage >= 12) then
						mycolor = { r=0, g=255, b=0 }
					end
				end

				if(isjewel and string.find(blah,"stamina")) then
					local value = tonumber(string.match(blah, "(%d+)"))
					if(value ~= nil and value >= 4) then
						mycolor = { r=0, g=255, b=0 }
					end
				end

				if string.find(blah, "artifact") or string.find(blah, "major") or (string.find(blah, "mage weapon") and string.find(blah, "15")) then
					mycolor = { r=0, g=255, b=0 }
				elseif string.find(blah, "durability") or string.find(blah, "require")  or string.find(blah, "on damage")  or string.find(blah, "on speed")  or string.find(blah, "weight") or string.find(blah, "handed") or string.find(blah, "lesser") or string.find(blah, "minor") or string.find(blah, "greater") or string.find(blah, "range") then
					mycolor = { r=100, g=100, b=100 }
				elseif string.find(blah, "cursed") then
					mycolor = { r=255, g=0, b=0 }
				end

				if string.find(blah, "weight") and string.find(blah, "50")  then
					mycolor = { r=200, g=50, b=50 }
				end
			
				if( i==1 ) then 
					numLabels = numLabels + 1
					labelText[numLabels] = WindowUtils.translateMarkup(propList[i])

					if ( (WindowData.ItemProperties.CustomColorTitle) and (WindowData.ItemProperties.CustomColorTitle.Enable) and (i == WindowData.ItemProperties.CustomColorTitle.LabelIndex) and (WindowData.ItemProperties.CustomColorTitle.NotorietyEnable) ) then
						labelColors[numLabels] = NameColor.TextColors[WindowData.ItemProperties.CustomColorTitle.NotorietyIndex+1]						
					else
						labelColors[numLabels] = ItemProperties.TITLE_COLOR
					end
				elseif( ItemProperties.CurrentItemData.detail == nil or ItemProperties.CurrentItemData.detail == ItemProperties.DETAIL_LONG ) then
					numLabels = numLabels + 1
					labelText[numLabels] = WindowUtils.translateMarkup(propList[i])
					labelColors[numLabels] = mycolor
				end 
			end -- end prop loop

			-- Append on vendor shop info...
			-- Item id from here...Debug.Print(ItemProperties.CurrentItemData)
			--local itemId = ItemProperties.CurrentItemData.itemId
			--numLabels = numLabels + 1
			--if(itemInfo) then
			--	if(VendorConfiguration.WatchContainers[itemInfo.ContainerId]) then
			--		if(VendorConfiguration.WatchContainers[itemInfo.ContainerId].Items[itemId]) then
			--			labelText[numLabels] = L"Posted: " .. towstring(VendorConfiguration.WatchContainers[itemInfo.ContainerId].Items[itemId].DatePosted)
			--			labelColors[numLabels] = ItemProperties.TITLE_COLOR
			--		end
			--	end
			--end
			

		end	
	elseif( ItemProperties.CurrentItemData.itemType == WindowData.ItemProperties.TYPE_ACTION ) then
		-- first get its location if it has one and set the subindex to 0 by default
		local itemLoc = ItemProperties.CurrentItemData.itemLoc
		if( itemLoc ~= nil and itemLoc.subIndex == nil ) then
			itemLoc.subIndex = 0
		end
		
		if( ItemProperties.CurrentItemData.actionType == SystemData.UserAction.TYPE_SKILL ) then
			-- NOTE: Need to fix this. Id 0 is also a null check, so no tooltip for Alchemy
			local skillId = id - 1
			
			-- translate the server id into a row into the ability csv
			local abilityId = CSVUtilities.getRowIdWithColumnValue(WindowData.SkillsCSV, "ServerId", skillId)

			numLabels = numLabels + 1
			labelText[numLabels] = GetStringFromTid(WindowData.SkillsCSV[abilityId].NameTid)
			labelColors[numLabels] = ItemProperties.TITLE_COLOR
			
			local detailTid = WindowData.SkillsCSV[abilityId].DescriptionTid
			if( detailTid ~= nil and ItemProperties.CurrentItemData.detail == ItemProperties.DETAIL_LONG ) then
				numLabels = numLabels + 1
				labelText[numLabels] = GetStringFromTid(detailTid)
				labelColors[numLabels] = ItemProperties.BODY_COLOR	
			end
		elseif( ItemProperties.CurrentItemData.actionType == SystemData.UserAction.TYPE_SPELL ) then
			local icon, serverId, tid, desctid = GetAbilityData(id)

			if( desctid ~= nil and ItemProperties.CurrentItemData.detail == ItemProperties.DETAIL_LONG ) then
				if( tid ~= nil ) then
					numLabels = numLabels + 1
					labelText[numLabels] = GetStringFromTid(tid)
					labelColors[numLabels] = ItemProperties.TITLE_COLOR		
				end				
				numLabels = numLabels + 1
				labelText[numLabels] = GetStringFromTid(desctid)
				labelColors[numLabels] = ItemProperties.BODY_COLOR	
			elseif( tid ~= nil ) then
				numLabels = numLabels + 1
				labelText[numLabels] = GetStringFromTid(tid)
				labelColors[numLabels] = ItemProperties.TITLE_COLOR		
			end		
			
			if(ItemProperties.CurrentItemData.body ~= nil and ItemProperties.CurrentItemData.body ~= L"") then
				numLabels = numLabels + 1
				labelText[numLabels] = WindowUtils.translateMarkup(ItemProperties.CurrentItemData.body)
				labelColors[numLabels] = ItemProperties.BODY_COLOR	
			end
		elseif( ItemProperties.CurrentItemData.actionType == SystemData.UserAction.TYPE_INVOKE_VIRTUE ) then
			local nameTid = ItemProperties.VirtueData[id].nameTid
			local detailTid = ItemProperties.VirtueData[id].detailTid
			if( nameTid ~= nil and nameTid ~= 0 ) then
				numLabels = numLabels + 1
				labelText[numLabels] = GetStringFromTid(nameTid)	
				labelColors[numLabels] = ItemProperties.TITLE_COLOR
			end
			if( detailTid ~= nil and detailTid ~= 0 ) then
				numLabels = numLabels + 1
				labelText[numLabels] = GetStringFromTid(detailTid)
				labelColors[numLabels] = ItemProperties.BODY_COLOR	
			end
		elseif( ItemProperties.CurrentItemData.actionType == SystemData.UserAction.TYPE_WEAPON_ABILITY ) then
			if( EquipmentData.CurrentWeaponAbilities[id] ~= nil and EquipmentData.CurrentWeaponAbilities[id] ~= 0 ) then
				local abilityId = EquipmentData.CurrentWeaponAbilities[id] + EquipmentData.WEAPONABILITY_ABILITYOFFSET
				local icon, serverId, tid, desctid = GetAbilityData(abilityId)
				
				-- Always show the ability name
				if( tid ~= nil ) then
					numLabels = numLabels + 1
					labelText[numLabels] = GetStringFromTid(tid)
					labelColors[numLabels] = ItemProperties.TITLE_COLOR
				end

				if( desctid ~= nil and ItemProperties.CurrentItemData.detail == ItemProperties.DETAIL_LONG ) then
					numLabels = numLabels + 1
					labelText[numLabels] = GetStringFromTid(desctid)	
					labelColors[numLabels] = ItemProperties.BODY_COLOR			
				end
			end
		elseif( ItemProperties.CurrentItemData.actionType == SystemData.UserAction.TYPE_RACIAL_ABILITY ) then
			-- NOTE: Need to fix this. Hotbar slot loses ability id because of racial ability id conversion.
			local iconId = UserActionGetIconId(itemLoc.hotbarId, itemLoc.itemIndex, itemLoc.subIndex)
			local icon, serverId, tid, desctid = GetAbilityData(iconId)

			if( desctid ~= nil and ItemProperties.CurrentItemData.detail == ItemProperties.DETAIL_LONG ) then
				if( tid ~= nil ) then
					numLabels = numLabels + 1
					labelText[numLabels] = GetStringFromTid(tid)
					labelColors[numLabels] = ItemProperties.TITLE_COLOR		
				end				
				numLabels = numLabels + 1
				labelText[numLabels] = GetStringFromTid(desctid)
				labelColors[numLabels] = ItemProperties.BODY_COLOR	
			elseif( tid ~= nil ) then
				numLabels = numLabels + 1
				labelText[numLabels] = GetStringFromTid(tid)
				labelColors[numLabels] = ItemProperties.TITLE_COLOR		
			end		
			
			if(ItemProperties.CurrentItemData.body ~= nil and ItemProperties.CurrentItemData.body ~= L"") then
				numLabels = numLabels + 1
				labelText[numLabels] = WindowUtils.translateMarkup(ItemProperties.CurrentItemData.body)
				labelColors[numLabels] = ItemProperties.BODY_COLOR	
			end
		elseif( ItemProperties.CurrentItemData.actionType == SystemData.UserAction.TYPE_USE_OBJECTTYPE) then
			RegisterWindowData(WindowData.ObjectTypeQuantity.Type, ItemProperties.CurrentItemData.itemId)
			item = WindowData.ObjectTypeQuantity[ItemProperties.CurrentItemData.itemId]
			if( item ~= nil ) then
				if( item.name ~= nil ) then
					numLabels = numLabels + 1
					local itemName = Shopkeeper.stripFirstNumber(item.name)
				    labelText[numLabels] = item.quantity..L" "..itemName
				    labelColors[numLabels] = ItemProperties.TITLE_COLOR	
				end
			end
			
			UnregisterWindowData(WindowData.ObjectTypeQuantity.Type, ItemProperties.CurrentItemData.itemId)
			
		elseif(ItemProperties.CurrentItemData.actionType == SystemData.UserAction.TYPE_PLAYER_STATS) then
			--If the user action is TYPE_PLAYER_STATS just show the tid of the stats ex: strength, dexterity
				tid = WindowData.PlayerStatsDataCSV[id].tid
				detailTid = WindowData.PlayerStatsDataCSV[id].detailTid
				-- Always show the ability name
				if( tid ~= nil ) then
					numLabels = numLabels + 1
					labelText[numLabels] = GetStringFromTid(tid)
					labelColors[numLabels] = ItemProperties.TITLE_COLOR
				end
				if( detailTid ~= nil and detailTid ~= 0 and ItemProperties.CurrentItemData.detail == ItemProperties.DETAIL_LONG ) then
					numLabels = numLabels + 1
					labelText[numLabels] = GetStringFromTid(detailTid)
					labelColors[numLabels] = ItemProperties.BODY_COLOR
				end
			
		-- Blanket case for generic actions
		else
			local actionData = ActionsWindow.GetActionDataForType(ItemProperties.CurrentItemData.actionType)
			
			if( actionData ~= nil ) then
			    if( actionData.nameTid ~= nil and actionData.nameTid ~= 0 ) then
				    numLabels = numLabels + 1
				    labelText[numLabels] = GetStringFromTid(actionData.nameTid)
				    labelColors[numLabels] = ItemProperties.TITLE_COLOR	
			    end
			    if( actionData.detailTid ~= nil and actionData.detailTid ~= 0 and
						ItemProperties.CurrentItemData.detail == ItemProperties.DETAIL_LONG ) then
				    numLabels = numLabels + 1
				    labelText[numLabels] = GetStringFromTid(actionData.detailTid)
				    labelColors[numLabels] = ItemProperties.BODY_COLOR	
			    end						
			end
		end
		
		-- add aditional information if the action has a hotbar location
		if( itemLoc ~= nil ) then
			if( UserActionIsSpeechType(itemLoc.hotbarId, itemLoc.itemIndex, itemLoc.subIndex) ) then
				local speechText = UserActionSpeechGetText(itemLoc.hotbarId, itemLoc.itemIndex, itemLoc.subIndex)
				if( speechText ~= L"" ) then
					numLabels = numLabels + 1
					labelText[numLabels] = speechText
					labelColors[numLabels] = ItemProperties.BODY_COLOR
				end
			elseif( ItemProperties.CurrentItemData.actionType == SystemData.UserAction.TYPE_DELAY ) then
				local delay = UserActionDelayGetDelay(itemLoc.hotbarId, itemLoc.itemIndex, itemLoc.subIndex)				
				numLabels = numLabels + 1
				labelText[numLabels] = wstring.format(L"%.1f",delay)
				labelColors[numLabels] = ItemProperties.BODY_COLOR				
			elseif( ItemProperties.CurrentItemData.actionType == SystemData.UserAction.TYPE_MACRO ) then
				local macroName = UserActionMacroGetName(itemLoc.hotbarId, itemLoc.itemIndex)
				if( macroName ~= L"" ) then
					numLabels = numLabels + 1
					labelText[numLabels] = macroName
					labelColors[numLabels] = ItemProperties.BODY_COLOR
				end
			end
		end
		
	elseif( ItemProperties.CurrentItemData.itemType == WindowData.ItemProperties.TYPE_WSTRINGDATA ) then
		if( ItemProperties.CurrentItemData.title ~= nil and ItemProperties.CurrentItemData.title ~= L"" ) then
			numLabels = numLabels + 1
			labelText[numLabels] = ItemProperties.CurrentItemData.title
			labelColors[numLabels] = ItemProperties.TITLE_COLOR	
		end
		if( ItemProperties.CurrentItemData.body ~= nil and ItemProperties.CurrentItemData.body ~= L"" ) then
			numLabels = numLabels + 1
			labelText[numLabels] = ItemProperties.CurrentItemData.body
			labelColors[numLabels] = ItemProperties.BODY_COLOR	
		end	
	end
	
	if( ItemProperties.CurrentItemData.binding ~= nil and ItemProperties.CurrentItemData.binding ~= L"" ) then
		numLabels = numLabels + 1
		labelText[numLabels] = ItemProperties.CurrentItemData.binding
		labelColors[numLabels] = ItemProperties.BODY_COLOR	
	end

	if( ItemProperties.CurrentItemData.myTarget ~= nil and ItemProperties.CurrentItemData.myTarget ~= L"" ) then
		numLabels = numLabels + 1
		labelText[numLabels] = ItemProperties.CurrentItemData.myTarget
		labelColors[numLabels] = ItemProperties.BODY_COLOR	
	end
			
	numLabels = table.getn(labelText)
	--Debug.Print("numLabels: "..numLabels)
	if( numLabels > 0 ) then
		ItemProperties.CreatePropsLabels(numLabels)
	
		local propWindowWidth = 100
		local propWindowHeight = 4
		
		-- build out window..

		for i = 1, numLabels do
			labelName = "ItemPropertiesItemLabel"..i
			LabelSetText(labelName, labelText[i])
			LabelSetTextColor(labelName, labelColors[i].r, labelColors[i].g, labelColors[i].b)
			w, h = LabelGetTextDimensions(labelName)
			propWindowWidth = math.max(propWindowWidth, w)
			propWindowHeight = propWindowHeight + h + 3 -- Allow for spacing
			WindowSetShowing(labelName, true)
		end
	
		propWindowWidth = propWindowWidth + 32
		propWindowHeight = propWindowHeight + 32
		WindowSetDimensions("ItemProperties", propWindowWidth, propWindowHeight)

		-- Set the window position
		windowOffset = 16
		scaleFactor = 1/InterfaceCore.scale	
		
		mouseX = SystemData.MousePosition.x
		propWindowX = mouseX - windowOffset - (propWindowWidth / scaleFactor)
		if propWindowX < 0 then
			propWindowX = mouseX + windowOffset
		end
			
		mouseY = SystemData.MousePosition.y
		propWindowY = mouseY - windowOffset - (propWindowHeight / scaleFactor)
		if propWindowY < 0 then
			propWindowY = mouseY + windowOffset
		end

		WindowSetOffsetFromParent("ItemProperties", propWindowX * scaleFactor, propWindowY * scaleFactor)
		WindowSetShowing("ItemProperties",true)
	end

end

-- Values in itemdata table
--   windowName - name of base window that contains hover
--   itemId     - unique id of item
--   itemType   - WindowData.ItemProperties
--	 binding    - (default L"") shown on last line
--   detail     - (default SHORT) ItemProperties.DETAIL_SHORT
--				  ItemProperties.DETAIL_LONG 
--   actionType - (default NONE) SystemData.UserAction
--	title		- Used for item properties that have the title wstring (default L"")
--	body		- Outputs the body of your text given a wstring, goes below the title (default L"")	
function ItemProperties.SetActiveItem(itemData)
	if( itemData == nil ) then
		itemData = {}
	end
	
	-- USE_ITEM actions are the same information as item
	if( itemData.actionType == SystemData.UserAction.TYPE_USE_ITEM ) then
		itemData.itemType = WindowData.ItemProperties.TYPE_ITEM
	end
	
	--Debug.Print("ItemProperties.SetActiveItem: id="..tostring(itemData.itemId).." type="..tostring(itemData.itemType).." action="..tostring(itemData.actionType))
	
	WindowData.ItemProperties.CurrentHover = itemData.itemId
	WindowData.ItemProperties.CurrentType = itemData.itemType
	ItemProperties.CurrentItemData = itemData
end

function ItemProperties.CreatePropsLabels(numLabelsNeeded)
	-- Dynamically create a bunch of labels for the individual property lines.
	numHave = WindowData.ItemProperties.numLabels 
	
	if numHave >= numLabelsNeeded then
		return
	end

	for i = numHave + 1, numLabelsNeeded do
		labelName = "ItemPropertiesItemLabel"..i
		
		if i == 1 then
			CreateWindowFromTemplate(labelName, "ItemPropItemDef", "ItemProperties")
			WindowAddAnchor(labelName, "top", "ItemProperties", "top", 0, 16)
		else
			CreateWindowFromTemplate(labelName, "ItemPropItemDef", "ItemProperties")
			WindowAddAnchor(labelName, "bottom", "ItemPropertiesItemLabel"..i-1, "top", 0, 3)
		end
	end
	
	WindowData.ItemProperties.numLabels = numLabelsNeeded
end

function ItemProperties.HideAllPropsLabels()
	numHave = WindowData.ItemProperties.numLabels 
	
	if numHave then
		for i = 1, numHave do
			WindowSetShowing("ItemPropertiesItemLabel"..i, false)
		end
	end
end

function ItemProperties.ClearMouseOverItem()
	--Debug.Print("ItemProperties.ClearMouseOverItem")
	WindowData.ItemProperties.CurrentHover = 0
	WindowData.ItemProperties.CurrentType = WindowData.ItemProperties.TYPE_NONE
	ItemProperties.CurrentItemData = {}
end

function ItemProperties.GetCurrentWindow()
    local windowName = nil
    if( ItemProperties.CurrentItemData ~= nil ) then
        windowName = ItemProperties.CurrentItemData.windowName
    end
    
    return windowName
end

function ItemProperties.OnPlayerBackpackMouseover()
	local backpackId = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
	
	if backpackId ~= 0 then
		local itemData = {
			windowName = dialog,
			itemId = backpackId,
			itemType = WindowData.ItemProperties.TYPE_ITEM,
		}
		ItemProperties.SetActiveItem(itemData)
	end
end

function ItemProperties.GetObjectPropertiesArray( objectId, caller )
	if Interface.DebugMode and caller then
	--Debug.Print("ItemProperties.GetObjectProperties (" .. caller ..  ")")
	end
	local data
	if (objectId == 0) then
		return
	end
	
	if WindowData.ItemProperties[objectId] then
		data = WindowData.ItemProperties[objectId]
	else
		RegisterWindowData(WindowData.ItemProperties.Type, objectId)
		if WindowData.ItemProperties[objectId] then
			data = WindowData.ItemProperties[objectId]
		end
		-- why do we unregister???
		UnregisterWindowData(WindowData.ItemProperties.Type, objectId)
	end
	return data
end

function ItemProperties.GetObjectProperties( objectId, number, caller )
	if Interface.DebugMode and caller then
	--	Debug.Print("ItemProperties.GetObjectProperties (" .. caller ..  ")")
	end
	local data = ItemProperties.GetObjectPropertiesArray( objectId, caller )
	local properties
	local property = {}
	if (objectId == 0) then
		return
	end

	if data then

		properties = data.PropertiesList
		if ( number ) and ( type( number ) == "number" ) then
			property[1] =  towstring( WindowUtils.translateMarkup(properties[number]) )
			return property[1]
		elseif ( number ) and ( number == "last" ) then
			property[1] =  towstring( WindowUtils.translateMarkup(properties[#properties]) )
			return property[1]
		else
			for i = 1, #properties do
				local value = towstring( WindowUtils.translateMarkup(properties[i]) )
				table.insert( property, value )
			end	
			return property
		end
	else
		return nil
	end	
end

function ItemProperties.GetObjectPropertiesTid( objectId, number, caller )
	if Interface.DebugMode and caller then
	--	Debug.Print("ItemProperties.GetObjectPropertiesTid (" .. caller ..  ")")
	end
	local data = ItemProperties.GetObjectPropertiesArray( objectId, caller )
	local properties
	local property = {}
	if (objectId == 0) then
		return
	end

	if data then

		properties = data.PropertiesTids
		
		if ( number ) and ( type( number ) == "number" ) then
			return properties[number]
		elseif ( number ) and ( number == "last" ) then
			return properties[#property]
		else
			for i = 1, #properties do
				table.insert( property, properties[i] )
			end	
			return property
		end
	else
		return nil
	end	
end

function ItemProperties.GetObjectPropertiesTidParams( objectId, number, caller )
	if Interface.DebugMode and caller then
	--	Debug.Print("ItemProperties.GetObjectPropertiesTid (" .. caller ..  ")")
	end
	local data = ItemProperties.GetObjectPropertiesArray( objectId, caller )
	local properties
	local property = {}
	if (objectId == 0) then
		return
	end
	
	if data then
		
		properties = data.PropertiesTidsParams
		
		local params = ItemProperties.BuildParamsArray( data )
		
		local newParams = {}
		for i = 1, #data.PropertiesTids do
			newParams[i] = params[data.PropertiesTids[i]]
		end	
		
		if ( number ) and ( type( number ) == "number" ) then
			return newParams[number]
		elseif ( number ) and ( number == "last" ) then
			return newParams[#params]
		else
			return newParams
		end
	else
		return nil
	end	
end

function ItemProperties.GetObjectPropertiesParamsForTid( objectId, tid, caller )
	if Interface.DebugMode and caller then
	--	Debug.Print("ItemProperties.GetObjectPropertiesTid (" .. caller ..  ")")
	end
	local data = ItemProperties.GetObjectPropertiesArray( objectId, caller )
	local properties
	local property = {}
	if (objectId == 0) then
		return
	end
	
	if data then
		
		local params = ItemProperties.BuildParamsArray( data )
		
		return params[tid]

	else
		return nil
	end	
end

function ItemProperties.BuildParamsArray( propertiesData )
	if not propertiesData then
		return
	end
	local params = {}
	
	local tid
	for i = 1, #propertiesData.PropertiesTidsParams do
		if wstring.find(propertiesData.PropertiesTidsParams[i], L"@") then
			tid = tostring(wstring.gsub(propertiesData.PropertiesTidsParams[i], L"@", L""))
			tid = tonumber(tid)
			params[tid] = {}
		else
			table.insert(params[tid], propertiesData.PropertiesTidsParams[i])
		end
	end

	return params
end

function ItemProperties.GetActiveProperties()
	
	local playerId = WindowData.PlayerStatus.PlayerId
	local paperdollWindowName = "PaperdollWindow"..playerId 	
	local numTotalItemProps = CSVUtilities.getNumRows(WindowData.PlayerItemPropCSV)
	
	if(WindowData.Paperdoll[playerId] == nil ) then			
		return
	end	

	-- Show available item properties	
	PropertyTable = {}
	for index = 1, WindowData.Paperdoll[playerId].numSlots do
		if (WindowData.Paperdoll[playerId][index].slotId ~= 0) then
			local objectId = WindowData.Paperdoll[playerId][index].slotId
			RegisterWindowData(WindowData.ObjectInfo.Type, objectId)			
			local props = ItemProperties.GetObjectPropertiesTid(objectId, nil, "ItemProperties - get active properties")						
			if not props then
				continue
			end						
			for i = 1, #props do				
				local currentTID = 0				
				for propIndex = 1, numTotalItemProps do
					currentTID = WindowData.PlayerItemPropCSV[propIndex].TID
					if (currentTID ~= 0 and currentTID == props[i]) then
						-- Append to active List								
						PropertyTable[propIndex] = propIndex							
						break
					end
				end					
			end
			UnregisterWindowData(WindowData.ObjectInfo.Type, objectId)
		end		
	end
	return PropertyTable
end

infoCache = {}
function ItemProperties.RemoveInfoCacheItem(itemId)
	infoCache[itemId] = nil
end

function ItemProperties.GetExtendedInfo(itemId, forceRefresh)
	if(infoCache[itemId] and not forceRefresh) then
		return infoCache[itemId]
	end

	-- Really have to find a better way to do this. It isn't localized at all!!!
	-- Should define all potential properties here or make the caller determine if they exist on the object before inspecting the value?
	local item = {}
	
	--UnregisterWindowData(WindowData.ItemProperties.Type, itemId)

	RegisterWindowData(WindowData.ObjectInfo.Type, itemId)
	local objectInfo = WindowData.ObjectInfo[itemId]
	local objectProps = ItemProperties.GetObjectPropertiesArray(itemId, nil)
	-- use instead??? ItemProperties.GetObjectProperties(itemId, nil, nil)
	
	--Debug.Print("--------")
	--Debug.Print(objectInfo)
	
	
	if(not objectProps) then
		return 
	end

	item.ItemId = itemId
	item.TypeId = objectInfo.objectType
	item.Name = objectInfo.name
	item.ContainerId = objectInfo.containerId

	-- DEFAULTS =================
	-- These need set in order to evaluate some of the boolean conditions.
	item.Jewelry = false
	item.Cursed = false
	item.Antique = false
	item.Prized = false
	item.Brittle = false

	
	if(item.TypeId == 4234 or item.TypeId == 4230 or item.TypeId == 7942 or item.TypeId == 7945 or item.TypeId == 16913 or item.TypeId == 16914) then
		item.Jewelry = true
	elseif(item.TypeId  == 5355) then -- and objectInfo.hueId == 0) then
		item.Title = "T-Map"
		item.TreasureMapLevel = 0
	elseif(item.TypeId == 7154 or item.TypeId == 5091) then
		if(objectInfo.hueId == 0) then
			item.Title = "Iron"
		elseif(objectInfo.hueId == 1154) then
			local temp = string.match(tostring(objectInfo.name), ".*%+(%d+)")
			item.Title = "ASH " .. temp
		elseif(objectInfo.hueId == 2419) then
			item.Title = "Dull"
		elseif(objectInfo.hueId == 2406) then
			item.Title = "Shadow"
		elseif(objectInfo.hueId == 2413) then
			item.Title = "Copper"
		elseif(objectInfo.hueId == 2418) then
			item.Title = "Bronze"
		elseif(objectInfo.hueId == 2213) then
			item.Title = "Golden"
		elseif(objectInfo.hueId == 2425) then
			item.Title = "Agapite"
		elseif(objectInfo.hueId == 2207) then
			item.Title = "Verite"
		elseif(objectInfo.hueId == 2219) then
			item.Title = "Valorite"
		end
	end

	-- SCALE =============================

	if(item.TypeId == 10153) then
		item.Scale = .5
	elseif(item.TypeId == 22300) then
		-- Essence
		-- TODO: something wrong with the default icon size.
		item.Scale = .5
	elseif(item.TypeId == 5355) then
		item.Scale = .75
	end



	-- TODO: check for specific objectType to highlight specific weapons/armor/etc.


	local props = objectProps.PropertiesList
	local propertyCount = 0
	local maxPropertyCount = 0
	local totalResists = 0

	for i = 1, #props do

		local prop = string.lower(tostring(props[i]))
		local propCase = tostring(props[i])

		-- Safe to assume name is always the first property??? or use name from objectInfo???
		--if(i == 1) then
			--item.Name = props[i]
			-- Removed the gtfo since we need to parse some name stuff below.
			--continue
		--end

		if(item.TreasureMapLevel) then
			if (string.find(prop, "plainly drawn")) then
				item.TreasureMapLevel = 1
				item.SubTitle = "Lvl 1"
			elseif (string.find(prop, "expertly drawn")) then
				item.TreasureMapLevel = 2
				item.SubTitle = "Lvl 2"
			elseif (string.find(prop, "adeptly drawn")) then
				item.TreasureMapLevel = 3
				item.SubTitle = "Lvl 3"
			elseif (string.find(prop, "cleverly drawn")) then
				item.TreasureMapLevel = 4
				item.SubTitle = "Lvl 4"
			elseif (string.find(prop, "deviously drawn")) then
				item.TreasureMapLevel = 5
				item.SubTitle = "Lvl 5"
			elseif (string.find(prop, "ingeniously drawn")) then
				item.TreasureMapLevel = 6
				item.SubTitle = "Lvl 6"
			elseif (string.find(prop, "diabolically drawn")) then
				item.TreasureMapLevel = 7
				item.SubTitle = "Lvl 7"
			end

			if (string.find(prop, "trammel")) then
				item.Title = "Trammel"
			elseif (string.find(prop, "felucca")) then
				item.Title = "Felucca"
			elseif (string.find(prop, "ilshenar")) then
				item.Title = "Ilshenar"
			elseif (string.find(prop, "malas")) then
				item.Title = "Malas"
			elseif (string.find(prop, "ter mur")) then
				item.Title = "Ter Mur"
			elseif (string.find(prop, "tokuno")) then
				item.Title = "Tokuno"
			end

			if (string.find(prop, "completed")) then
				item.Title = "Completed"
			end

		end

		-- ENGRAVED ========================================
		-- TODO: vendor desc (contains weird line breaks and formatting...)
		if (string.find(propCase, "Engraved:")) then
			Debug.Print(propCase)
			item.SubTitle = string.match(propCase, ".*Engraved:%s(.+)")
			continue
		end



		-- SCROLLS ====================
		if(item.TypeId == 5359) then
			item.Scale = .75
			if(objectInfo.hueId == 1153) then
				-- Power
				local skill, value = string.match(propCase, ".*Of%s(.*)%s%((.-)%s.*")
				if(skill and value) then
					item.Title = skill
					item.SubTitle = value
				end
			elseif(objectInfo.hueId == 1168) then
				-- Trans
				local skill, value = string.match(propCase, "Skill:%s(.*)%s(.*)%sSkill Points")
				if(skill and value) then
					item.Title = skill
					item.SubTitle = value
				end
			elseif(objectInfo.hueId == 1195) then
				-- Alac
				-- Skill: Arms Lore 15 Minutes
				Debug.Print(propCase)
				local skill = string.match(propCase, "Skill:%s(.*)%s%d.*")
				if(skill) then
					item.Title = skill
				end
			elseif(objectInfo.hueId == 1636) then
				-- Binder
				local value, skill, value2 = string.match(propCase, "(%d+)%s(.*):%s(.*)")
				if(skill and value and value2) then
					item.Title = skill
					item.SubTitle = value .. " " .. value2
				else
					local skill, value = string.match(propCase, "(.*)%sTranscendence:%s(.*)")
					if(skill and value) then
						item.Title = skill
						item.SubTitle = value
					end
				end
			end
		end

		if(item.TypeId == 5360) then
			item.Scale = .75
			-- Commodity
			local subtitle, title = string.match(propCase, "Commodity%sDeed%sWorth%s(%d+)%s(.*)")
			if(title and subtitle) then
				item.Title = title
				item.SubTitle = StringUtils.FormatNumberWString(towstring(subtitle))
			end
		end

		-- OTHER ====================

		if (string.find(prop, "require") or string.find(prop, "durability")) then
			-- TODO: weapon skill required.
			continue
		end

		if (string.find(prop, "weight")) then
			item.Weight = string.match(prop, "weight:%s(%d+)%sstone")
			continue
		end

		if (string.find(prop, "price")) then
			item.Price = string.match(prop, "price:%s(.+)")
			if(item.Price and not string.find(item.Price, "not")) then
				item.SubTitle = item.Price
			end
			continue
		end

		if (string.find(prop, "insured")) then
			item.Insured = true
			continue
		end

		if (string.find(prop, "imbued")) then
			item.Imbued = true
			continue
		end

		if (string.find(prop, "cursed")) then
			item.Cursed = true
			continue
		end

		if (string.find(prop, "antique")) then
			item.Antique = true
			continue
		end

		if (string.find(prop, "prized")) then
			item.Prized = true
			continue
		end

		if (string.find(prop, "brittle")) then
			item.Brittle = true
			continue
		end

		if (string.find(prop, "splintering")) then
			item.Splintering = tonumber(string.match(prop, "splintering%sweapon%s(%d+)"))
			propertyCount = propertyCount + 1
			continue
		end

		
		if (string.find(prop, "luck")) then
			item.Luck = tonumber(string.match(prop, "luck%s(%d+)"))
			propertyCount = propertyCount + 1
			continue
		end

		if (string.find(prop, "night sight")) then
			item.NightSight = true
			propertyCount = propertyCount + 1
			continue
		end

		-- TODO: Set bonuses breaking this logic. Check for nil value when looking at max property.
		if (string.find(prop, "damage%sincrease") and not string.find(prop, "spell")) then
			item.DamageIncrease = tonumber(string.match(prop, "damage%sincrease%s(%d+)"))
			propertyCount = propertyCount + 1
			if(item.Jewelry and item.DamageIncrease and item.DamageIncrease >= 25) then
				maxPropertyCount = maxPropertyCount + 1
			end
			continue
		end

		if (string.find(prop, "swing%sspeed%sincrease")) then
			item.SwingSpeedIncrease = tonumber(string.match(prop, "swing%sspeed%sincrease%s(%d+)"))
			propertyCount = propertyCount + 1
			if(item.Jewelry and item.SwingSpeedIncrease and item.SwingSpeedIncrease >= 10) then
				maxPropertyCount = maxPropertyCount + 1
			end
			continue
		end

		if (string.find(prop, "defense%schance%sincrease")) then
			item.DefenseChanceIncrease = tonumber(string.match(prop, "defense%schance%sincrease%s(%d+)"))
			propertyCount = propertyCount + 1
			if(item.Jewelry and item.DefenseChanceIncrease and item.DefenseChanceIncrease >= 15) then
				maxPropertyCount = maxPropertyCount + 1
			end
			continue
		end

		if (string.find(prop, "hit%schance%sincrease")) then
			item.HitChanceIncrease = tonumber(string.match(prop, "hit%schance%sincrease%s(%d+)"))
			propertyCount = propertyCount + 1
			if(item.Jewelry and item.HitChanceIncrease and item.HitChanceIncrease >= 15) then
				maxPropertyCount = maxPropertyCount + 1
			end
			continue
		end

		-- STATS ========================

		if (string.find(prop, "strength%sbonus")) then
			item.Strength = tonumber(string.match(prop, "strength%sbonus%s(%d+)"))
			propertyCount = propertyCount + 1
			continue
		end

		if (string.find(prop, "dexterity%sbonus")) then
			item.Dexterity = tonumber(string.match(prop, "dexterity%sbonus%s(%d+)"))
			propertyCount = propertyCount + 1
			continue
		end

		if (string.find(prop, "intelligence%sbonus")) then
			item.Intelligence = tonumber(string.match(prop, "intelligence%sbonus%s(%d+)"))
			propertyCount = propertyCount + 1
			continue
		end

		if (string.find(prop, "hit%spoint%sincrease")) then
			item.HitPointIncrease = tonumber(string.match(prop, "hit%spoint%sincrease%s(%d+)"))
			propertyCount = propertyCount + 1
			continue
		end

		if (string.find(prop, "stamina%sincrease")) then
			item.StaminaIncrease = tonumber(string.match(prop, "stamina%sincrease%s(%d+)"))
			propertyCount = propertyCount + 1
			if(item.Jewelry and item.StaminaIncrease and item.StaminaIncrease >= 4) then
				maxPropertyCount = maxPropertyCount + 1
			end
			if(not item.Jewelry and item.StaminaIncrease and item.StaminaIncrease >= 8) then
				maxPropertyCount = maxPropertyCount + 1
			end
			continue
		end

		if (string.find(prop, "mana%sincrease")) then
			item.ManaIncrease = tonumber(string.match(prop, "mana%sincrease%s(%d+)"))
			propertyCount = propertyCount + 1
			continue
		end
		
		if (string.find(prop, "hit%spoint%sregeneration")) then
			item.HitPointRegeneration = tonumber(string.match(prop, "hit%spoint%sregeneration%s(%d+)"))
			propertyCount = propertyCount + 1
			continue
		end

		if (string.find(prop, "stamina%sregeneration")) then
			item.StaminaRegeneration = tonumber(string.match(prop, "stamina%sregeneration%s(%d+)"))
			propertyCount = propertyCount + 1
			continue
		end

		if (string.find(prop, "mana%sregeneration")) then
			item.ManaRegeneration = tonumber(string.match(prop, "mana%sregeneration%s(%d+)"))
			propertyCount = propertyCount + 1
			if(item.ManaRegeneration and item.ManaRegeneration >= 3) then
				maxPropertyCount = maxPropertyCount + 1
			end
			continue
		end

		-- ON HIT ========================================

		if (string.find(prop, "hit%sstamina%sleech")) then
			item.HitStaminaLeech = tonumber(string.match(prop, "hit%sstamina%sleech%s(%d+)"))
			propertyCount = propertyCount + 1
			continue
		end

		if (string.find(prop, "hit%smana%sleech")) then
			item.HitManaLeech = tonumber(string.match(prop, "hit%smana%sleech%s(%d+)"))
			propertyCount = propertyCount + 1
			continue
		end

		if (string.find(prop, "hit%smana%sdrain")) then
			item.HitManaDrain = tonumber(string.match(prop, "hit%smana%sdrain%s(%d+)"))
			propertyCount = propertyCount + 1
			continue
		end

		if (string.find(prop, "hit%sfatigue")) then
			item.HitFatigue = tonumber(string.match(prop, "hit%sfatigue%s(%d+)"))
			propertyCount = propertyCount + 1
			continue
		end

		-- SPELLCASTING ====================================
		
		if (string.find(prop, "spell%sdamage%sincrease")) then
			item.SpellDamageIncrease = tonumber(string.match(prop, "spell%sdamage%sincrease%s(%d+)"))
			propertyCount = propertyCount + 1
			if(item.Jewelry and item.SpellDamageIncrease and item.SpellDamageIncrease >= 12) then
				maxPropertyCount = maxPropertyCount + 1
			end
			continue
		end

		if (string.find(prop, "faster%scasting")) then
			item.FasterCasting = tonumber(string.match(prop, "faster%scasting%s(%d+)"))
			propertyCount = propertyCount + 1
			continue
		end

		if (string.find(prop, "faster%scast%srecovery")) then
			item.FasterCastRecovery = tonumber(string.match(prop, "faster%scast%srecovery%s(%d+)"))
			-- TODO: exclude if spell channeling or negative???
			propertyCount = propertyCount + 1
			continue
		end

		if (string.find(prop, "lower%smana%scost")) then
			item.LowerManaCost = tonumber(string.match(prop, "lower%smana%scost%s(%d+)"))
			propertyCount = propertyCount + 1
			if(item.Jewelry and item.LowerManaCost and item.LowerManaCost >= 8) then
				maxPropertyCount = maxPropertyCount + 1
			end
			continue
		end

		if (string.find(prop, "lower%sreagent%scost")) then
			item.LowerReagentCost = tonumber(string.match(prop, "lower%sreagent%scost%s(%d+)"))
			propertyCount = propertyCount + 1
			continue
		end

		if (string.find(prop, "enhance%spotions")) then
			item.EnhancePotions = tonumber(string.match(prop, "enhance%spotions%s(%d+)"))
			propertyCount = propertyCount + 1
			if(item.Jewelry and item.EnhancePotions and item.EnhancePotions >= 25) then
				maxPropertyCount = maxPropertyCount + 1
			end
			if(not item.Jewelry and item.EnhancePotions and item.EnhancePotions >= 5) then
				maxPropertyCount = maxPropertyCount + 1
			end
			continue
		end

		if (string.find(prop, "casting%sfocus")) then
			item.CastingFocus = string.match(prop, "casting%sfocus%s(%d+)")
			propertyCount = propertyCount + 1
			continue
		end

		if (string.find(prop, "%+")) then
			-- TODO: track individual skils.
			propertyCount = propertyCount + 1
			continue
		end

		if (string.find(prop, "%seater")) then
			-- TODO: track eaters
			item.Eater = true
			propertyCount = propertyCount + 1
			continue
		end

		if (string.find(prop, "physical%sresist")) then
			item.PhysicalResist = string.match(prop, "physical%sresist%s(%d+)")
			if(item.Jewelry) then
				propertyCount = propertyCount + 1
			end
			if(item.PhysicalResist) then
				totalResists = totalResists + item.PhysicalResist
			end
			continue
		end

		if (string.find(prop, "fire%sresist")) then
			item.FireResist = string.match(prop, "fire%sresist%s(%d+)")
			if(item.Jewelry) then
				propertyCount = propertyCount + 1
			end
			totalResists = totalResists + item.FireResist
			continue
		end

		if (string.find(prop, "cold%sresist")) then
			item.ColdResist = string.match(prop, "cold%sresist%s(%d+)")
			if(item.Jewelry) then
				propertyCount = propertyCount + 1
			end
			totalResists = totalResists + item.ColdResist
			continue
		end

		if (string.find(prop, "poison%sresist")) then
			item.PoisonResist = string.match(prop, "poison%sresist%s(%d+)")
			if(item.Jewelry) then
				propertyCount = propertyCount + 1
			end
			totalResists = totalResists + item.PoisonResist
			continue
		end

		if (string.find(prop, "energy%sresist")) then
			item.EnergyResist = string.match(prop, "energy%sresist%s(%d+)")
			if(item.Jewelry) then
				propertyCount = propertyCount + 1
			end
			totalResists = totalResists + item.EnergyResist
			continue
		end

		-- ITEM INTENSITY ================================================
		-- Greater Magic Item - 3
		-- Major Magic Item - 4
		-- Lesser Artifact - 5
		-- Greater Artifact - 6
		-- Major Artifact - 7
		-- Legendary Artifact - 8
		if (string.find(prop, "minor%smagic%sitem")) then
			item.Intensity = 1
			continue
		end

		if (string.find(prop, "lesser%smagic%sitem")) then
			item.Intensity = 2
			continue
		end

		if (string.find(prop, "greater%smagic%sitem")) then
			item.Intensity = 3
			continue
		end
		
		if (string.find(prop, "major%smagic%sitem")) then
			item.Intensity = 4
			continue
		end

		if (string.find(prop, "lesser%sartifact")) then
			item.Intensity = 5
			continue
		end

		if (string.find(prop, "greater%sartifact")) then
			item.Intensity = 6
			continue
		end

		if (string.find(prop, "greater%sartifact")) then
			item.Intensity = 6
			continue
		end

		if (string.find(prop, "major%sartifact")) then
			item.Intensity = 7
			continue
		end

		if (string.find(prop, "legendary%sartifact")) then
			item.Intensity = 8
			continue
		end
		

	end

	if(propertyCount ~= 0) then
		item.PropertyCount = propertyCount
	end
	if(maxPropertyCount ~= 0) then
		item.MaxPropertyCount = maxPropertyCount
	end
	if(totalResists ~= 0) then
		item.TotalResists = totalResists
	end

		
	--Debug.Print("--------")
	--Debug.Print(item)

	infoCache[itemId] = item
	return item
end


-- Returns the rule that passes first.
function ItemProperties.CheckRules(itemInfo)
	
	if(not itemInfo) then
		return
	end

	-- TODO: Cache results...
	for i = 1, #LootConfiguration.Rules do

		local rule = LootConfiguration.Rules[i]

		-- If no conditions have been set up then the rule is invalid.
		if(#rule.Conditions == 0) then
			continue
		end

		local valid = true

		for j = 1, #rule.Conditions do
		
			if(valid == false) then
				-- If a previous condition was invalid there is no need to test the rest of the conditions for this rule.
				break
			end

			-- Must have this property to pass the rule...
			-- Need to check for an actual value instead of just falsy otherwise "false" is true...
			if(itemInfo[rule.Conditions[j].Property] == nil) then
				valid = false
				break
			end

			--local propertyType
			-- find the PropertyType...
			--for k = 1, #LootConfiguration.Properties do
			--	if(tostring(LootConfiguration.Properties[k].Property) == tostring(rule.Conditions[j].Property)) then
			--		propertyType = LootConfiguration.Properties[i].PropertyType
			--	end
			--end
			-- There doesn't seem to be any way to do an eval. This is going to get ugly...
			-- string.match is done to strip out comment tags, ex. Intensity property...
			if(rule.Conditions[j].Operator == ">=") then
				if(tonumber(itemInfo[rule.Conditions[j].Property]) < tonumber(string.match(rule.Conditions[j].Value, "(%d+)"))) then
					valid = false
					break
				end
			elseif(rule.Conditions[j].Operator == "<=") then
				if(tonumber(itemInfo[rule.Conditions[j].Property]) > tonumber(string.match(rule.Conditions[j].Value, "(%d+)"))) then
					valid = false
					break
				end
			elseif(rule.Conditions[j].Operator == "=") then
				if(tonumber(itemInfo[rule.Conditions[j].Property]) ~= tonumber(string.match(rule.Conditions[j].Value, "(%d+)"))) then
					valid = false
					break
				end
			elseif(rule.Conditions[j].Operator == "is") then
				if(tostring(itemInfo[rule.Conditions[j].Property]) ~= tostring(rule.Conditions[j].Value)) then
					valid = false
					break
				end
			else
				-- Default to invalid...
				-- Shouldn't hit this unless the operators are messed with.
				valid = false
				break
			end

		end -- end rule conditions loop...

		if(valid == true) then
			-- Return this as the first passing rule.
			return rule
		end

	end -- end rules loop

end

