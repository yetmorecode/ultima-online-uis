----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

ItemProperties = {}

ItemProperties.DETAIL_SHORT = 1
ItemProperties.DETAIL_LONG = 2

ItemProperties.CurrentItemData = {}

ItemProperties.CurrentBaseData = {}
ItemProperties.ItemChanged = false

ItemProperties.VirtueData = {}
ItemProperties.VirtueData[1]	= { iconId = 701, nameTid = 1051005, detailTid=1052058 } -- Honor
ItemProperties.VirtueData[2]	= { iconId = 706, nameTid = 1051001, detailTid=1052053 } -- Sacrifice
ItemProperties.VirtueData[3]	= { iconId = 700, nameTid = 1051004, detailTid=1052057 } -- Valor
ItemProperties.VirtueData[4]	= { iconId = 702, nameTid = 1051002, detailTid=1053000 } -- Compassion
ItemProperties.VirtueData[5]	= { iconId = 704, nameTid = 1051007, detailTid=1052060 } -- Honesty
ItemProperties.VirtueData[6]	= { iconId = 707, nameTid = 1051000, detailTid=1052051 } -- Humility
ItemProperties.VirtueData[7]	= { iconId = 703, nameTid = 1051006, detailTid=1052059 } -- Justice
ItemProperties.VirtueData[8]	= { iconId = 705, nameTid = 1051003, detailTid=1052056 } -- Spirituality

ItemProperties.Delta = 0
ItemProperties.RefreshTime = 1
ItemProperties.LoadTime = 0.01

ItemProperties.WeaponGump_Width = 450

ItemProperties.loadingTime = 0

---------------------------------------------------------------
-- MainMenuWindow Functions
----------------------------------------------------------------

-- OnInitialize Handler
function ItemProperties.Initialize()
	ItemProperties.ClearWindow()
	
	WindowSetAlpha("ItemPropertiesWindowBackground", 0.8)
	
	WindowData.ItemProperties.numLabels = 0
	
	WindowRegisterEventHandler( "ItemProperties", SystemData.Events.UPDATE_ITEM_PROPERTIES, "ItemProperties.UpdateItemPropertiesData")
	
	WindowData.ItemProperties.TYPE_MOBILE = 4
end

function ItemProperties.Shutdown()
end

function ItemProperties.UpdateItemPropertiesData()
	if not Interface.started then
		return
	end
	
	ItemProperties.TagColors = 
	{
		[1151488] = Interface.Settings.Props_MAGICPROP_COLOR; -- Minor Magic Item
		[1151489] = Interface.Settings.Props_MAGICPROP_COLOR; -- Lesser Magic Item
		[1151490] = Interface.Settings.Props_MAGICPROP_COLOR; -- Greater Magic Item
		[1151491] = Interface.Settings.Props_MAGICPROP_COLOR; -- Major Magic Item
		[1151492] = Interface.Settings.Props_MAGICPROP_COLOR; -- Lesser Artifact
		[1151493] = Interface.Settings.Props_ESSENCE_COLOR; -- Greater Artifact
		[1151494] = Interface.Settings.Props_RELIC_COLOR; -- Major Artifact
		[1151495] = Interface.Settings.Props_ARTIFACT_COLOR; -- Legendary Artifact
	}
	
	if not WindowData.ItemProperties or not WindowData.ItemProperties.CurrentHover or WindowData.ItemProperties.CurrentHover == 0 or WindowData.ItemProperties.CurrentType == WindowData.ItemProperties.TYPE_NONE or Interface.DisableProps then
		return
	end
	
	-- is this a gump item but we don't have the properties yet?
	if GenericGump.CurrentOver == "VSEARCH" and WindowData.ItemProperties[0].PropertiesList == nil then
		ItemProperties.loading =  true

	-- is this a gump item and we have the properties?			
	elseif GenericGump.CurrentOver == "VSEARCH" and WindowData.ItemProperties[0].PropertiesList ~= nil then
		ItemProperties.loading =  false
	end

	if ItemProperties.Delta > 0 or ItemProperties.loading then -- and WindowGetShowing("ItemProperties")
		return
	end
	
	if WindowGetShowing("ItemProperties") then
		ItemProperties.Delta = ItemProperties.RefreshTime
	else
		ItemProperties.Delta = ItemProperties.LoadTime
		ItemProperties.loadingTime = 0
	end
	ItemProperties.loading = true
	
	local props
	
	if (GenericGump.CurrentOver == "" and WindowData.ItemProperties.CurrentType == WindowData.ItemProperties.TYPE_ITEM) then
		if WindowData.ItemProperties.CurrentType == WindowData.ItemProperties.TYPE_ITEM and IsMobile(WindowData.ItemProperties.CurrentHover) then
			WindowData.ItemProperties.CurrentType = WindowData.ItemProperties.TYPE_MOBILE
		end
	end
	
	ItemProperties.CurrentItemData.itemType = WindowData.ItemProperties.CurrentType
	
	if (ItemProperties.CurrentItemData.itemType == WindowData.ItemProperties.TYPE_ITEM) then
		local objectId = WindowData.ItemProperties.CurrentHover
		
		ItemProperties.CurrentBaseData = {}

		-- get the properties params array
		props, count = ItemProperties.BuildParamsArray( WindowData.ItemProperties[0], true )

		if GenericGump.CurrentOver == "" then
			local itemData = Interface.GetObjectInfoData(objectId)
			if not itemData then
				ItemProperties.loading = nil
				return
			end
			
			local objData = ItemPropertiesInfo.GetObjectData(itemData.objectType)
			
			if objData then
				ItemProperties.CurrentBaseData = objData
			end
			
			ItemProperties.CurrentBaseData.objectId = objectId

			ItemProperties.CurrentBaseData.GumpType = ItemPropertiesInfo.GetGumpTypeByItemData(objectId, itemData)
			
			ItemProperties.CurrentBaseData.objType = itemData.objectType
			
			-- the following values may change over time so we need to keep it updated everytime the gump get refreshed.
			ItemProperties.CurrentBaseData.quantity = itemData.quantity
			ItemProperties.CurrentBaseData.hue = itemData.hueId 
			
			ItemProperties.CurrentBaseData.equipped = false
			if ItemProperties.CurrentBaseData.layer then -- check if the item can be equipped and if it's equipped
				if objectId == PaperdollWindow.GetPaperdollSlotID(GetPlayerID(), ItemProperties.CurrentBaseData.layer) then
					ItemProperties.CurrentBaseData.equipped = true
				end
			end
			
			if ItemProperties.CurrentItemData.paperdoll then
				if not PaperdollWindow.ItemsProps[ItemProperties.CurrentItemData.paperdollId] then
					PaperdollWindow.ItemsProps[ItemProperties.CurrentItemData.paperdollId] = {}
				end
				PaperdollWindow.ItemsProps[ItemProperties.CurrentItemData.paperdollId][ItemProperties.CurrentItemData.paperdoll] = ItemProperties.BuildParamsArray( WindowData.ItemProperties[0], true )
			end

		elseif GenericGump.CurrentOver == "IemGump" then
			local itemData = Interface.GetObjectInfoData(objectId)
			if not itemData then
				ItemProperties.loading = nil
				return
			end

			local objData = ItemPropertiesInfo.GetObjectData(itemData.objectType)
			
			if objData then
				ItemProperties.CurrentBaseData = objData
			end
			
			ItemProperties.CurrentBaseData.objectId = objectId

			ItemProperties.CurrentBaseData.GumpType = ItemPropertiesInfo.GetGumpTypeByItemData(objectId, itemData)
			
			ItemProperties.CurrentBaseData.objType = itemData.objectType
			
			-- the following values may change over time so we need to keep it updated everytime the gump get refreshed.
			ItemProperties.CurrentBaseData.quantity = itemData.quantity
			ItemProperties.CurrentBaseData.hue = itemData.hueId 
			
			ItemProperties.CurrentBaseData.equipped = false
			if ItemProperties.CurrentBaseData.layer then -- check if the item can be equipped and if it's equipped
				if objectId == PaperdollWindow.GetPaperdollSlotID(GetPlayerID(), ItemProperties.CurrentBaseData.layer) then
					ItemProperties.CurrentBaseData.equipped = true
				end
			end
			
			if ItemProperties.CurrentItemData.paperdoll then
				if not PaperdollWindow.ItemsProps[ItemProperties.CurrentItemData.paperdollId] then
					PaperdollWindow.ItemsProps[ItemProperties.CurrentItemData.paperdollId] = {}
				end
				PaperdollWindow.ItemsProps[ItemProperties.CurrentItemData.paperdollId][ItemProperties.CurrentItemData.paperdoll] = ItemProperties.BuildParamsArray( WindowData.ItemProperties[0], true )
			end
			
		elseif GenericGump.CurrentOver == "BOD" then
			ItemProperties.CurrentBaseData.GumpType = ItemPropertiesInfo.Types.Bod_Smith
			
		elseif GenericGump.CurrentOver == "VSEARCH" then

			if ItemProperties.CurrentItemData.objectType then
				ItemProperties.CurrentBaseData.GumpType = ItemPropertiesInfo.GetGumpTypeByItemData(id, {objectType = ItemProperties.CurrentItemData.objectType, hueId = ItemProperties.CurrentItemData.hue})
				
				local objData = ItemPropertiesInfo.GetObjectData(ItemProperties.CurrentItemData.objectType)
			
				if objData then
					ItemProperties.CurrentBaseData = objData
				end

				ItemProperties.CurrentBaseData.objType = ItemProperties.CurrentItemData.objectType

				ItemProperties.CurrentBaseData.hue = ItemProperties.CurrentItemData.hue

			else
				ItemProperties.CurrentBaseData.GumpType, ItemProperties.CurrentBaseData.objType = ItemPropertiesInfo.GetGumpTypeByName(WindowData.ItemProperties[0].PropertiesList[1])
			
				local objData = ItemPropertiesInfo.GetObjectData(ItemProperties.CurrentBaseData.objType)
			
				if objData then
					ItemProperties.CurrentBaseData = objData
				end

				ItemProperties.CurrentBaseData.GumpType, ItemProperties.CurrentBaseData.objType, ItemProperties.CurrentBaseData.Material = ItemPropertiesInfo.GetGumpTypeByName(WindowData.ItemProperties[0].PropertiesList[1], props)
			end

			ItemProperties.CurrentBaseData.quantity = tonumber(ItemProperties.GetAmountFromName(WindowData.ItemProperties[0].PropertiesList[1]))

			if IsValidID(objectId) then
				ItemProperties.CurrentBaseData.objectId = objectId
			end

			ItemProperties.CurrentBaseData.equipped = false
			if ItemProperties.CurrentBaseData.layer then -- check if the item can be equipped and if it's equipped
				if objectId == PaperdollWindow.GetPaperdollSlotID(GetPlayerID(), ItemProperties.CurrentBaseData.layer) then
					ItemProperties.CurrentBaseData.equipped = true
				end
			end
			
			if ItemProperties.CurrentItemData.paperdoll then
				if not PaperdollWindow.ItemsProps[ItemProperties.CurrentItemData.paperdollId] then
					PaperdollWindow.ItemsProps[ItemProperties.CurrentItemData.paperdollId] = {}
				end
				PaperdollWindow.ItemsProps[ItemProperties.CurrentItemData.paperdollId][ItemProperties.CurrentItemData.paperdoll] = ItemProperties.BuildParamsArray( WindowData.ItemProperties[0], true )
			end
		end
		
		ItemProperties.CurrentBaseData.OriginalProps = WindowData.ItemProperties[0]
			
		call = ItemProperties.ItemParsing
		
	elseif (ItemProperties.CurrentItemData.itemType == WindowData.ItemProperties.TYPE_MOBILE) then
	
		ItemProperties.CurrentBaseData = {}
		
		local mobileId = WindowData.ItemProperties.CurrentHover

		if Interface.Settings.MouseOverTarget and mobileId ~= TargetWindow.TargetId then
			HandleSingleLeftClkTarget(mobileId)
		end

		Interface.UpdateMobileOnScreenNameFlags(mobileId, true)

		ItemProperties.CurrentBaseData.mobileId = mobileId
		ItemProperties.CurrentBaseData.GumpType = ItemPropertiesInfo.GetGumpTypeByItemData(mobileId, itemData)
		
		ItemProperties.CurrentBaseData.hasPaperdoll = HasPaperdoll(mobileId)

		ItemProperties.CurrentBaseData.Notoriety = GetMobileNotoriety(mobileId)

		ItemProperties.CurrentBaseData.OriginalProps = WindowData.ItemProperties[0]
		
		ItemProperties.CurrentBaseData.MobName = GetMobileName(mobileId)

		-- get the contributor data
		local contributor = CreditsWindow.GetContributorData(mobileId)

		if contributor and contributor.engrave then
			ItemProperties.CurrentBaseData.Engrave = contributor.engrave
		end
		
		if not HasPaperdoll(mobileId) then
			ItemProperties.CurrentBaseData.bodyType = GetMobileBodyID(mobileId)
			ItemProperties.CurrentBaseData.hue = GetMobileHue(mobileId)
		end

		call = ItemProperties.MobileParsing
		
	elseif (ItemProperties.CurrentItemData.itemType == WindowData.ItemProperties.TYPE_ACTION) then -- actions/specials/spells/etc.. properties
		call = ItemProperties.ActionParsing
		
	elseif (ItemProperties.CurrentItemData.itemType == WindowData.ItemProperties.TYPE_WSTRINGDATA) then -- tooltip wstring properties.
		call = ItemProperties.WStringParsing
	end
	
	if (call) then
		
		local ok, labelText, labelColors, labelFont = pcall(call, props)
		
		if (ok) then
			if (ItemProperties.CurrentItemData.binding ~= nil and ItemProperties.CurrentItemData.binding ~= L"") then
				if labelText then
					table.insert(labelText, ItemProperties.CurrentItemData.binding)
					table.insert(labelColors, Interface.Settings.Props_BODY_COLOR)
					table.insert(labelFont, ItemProperties.GetFont("normal"))	
				end	
			end

			if (ItemProperties.CurrentItemData.myTarget ~= nil and ItemProperties.CurrentItemData.myTarget ~= L"") then
				if labelText then
					table.insert(labelText, ItemProperties.CurrentItemData.myTarget)
					table.insert(labelColors, Interface.Settings.Props_BODY_COLOR)
					table.insert(labelFont, ItemProperties.GetFont("normal"))	
				end		
			end
			if (labelText and #labelText > 0) then
				ItemProperties.PopulateWindow(labelText, labelColors, labelFont)
			end
		end
	end
	ItemProperties.ItemChanged = false
end

function ItemProperties.GetShowingId()
	if (DoesWindowExist("ItemProperties") and WindowGetShowing("ItemProperties")) then
		return WindowGetId("ItemProperties")
	end
end

function ItemProperties.ClearWindow()

	if (DoesWindowExist("ItemPropertiesItemLabelspace")) then
		DestroyWindow("ItemPropertiesItemLabelspace")
	end
	
	local j = 1
	local labelname = "ItemPropertiesItemLabel" .. j
	while DoesWindowExist(labelname) do
		DestroyWindow(labelname)
		j = j + 1
		labelname = "ItemPropertiesItemLabel" .. j
	end

	if (DoesWindowExist("WeaponProperties")) then
		DestroyWindow("WeaponProperties")
	end
	if (DoesWindowExist("SpellbookProperties")) then
		DestroyWindow("SpellbookProperties")
	end
	if (DoesWindowExist("OtherProperties")) then
		DestroyWindow("OtherProperties")
	end
	if (DoesWindowExist("MobileProperties")) then
		DestroyWindow("MobileProperties")
	end

	if (DoesWindowExist("SpecialItemProperties")) then
		DestroyWindow("SpecialItemProperties")
	end
	
	WindowSetDimensions("ItemProperties", 0, 0)
	ItemProperties.FollowMouse()
	WindowSetShowing("ItemProperties", false)
	WindowSetId("ItemProperties", 0)
end

function ItemProperties.ShowWeaponProps()
 
	local mainWindow = "WeaponProperties"

	local width = ItemProperties.WeaponGump_Width
	
	CreateWindowFromTemplate(mainWindow, "WeaponPropertiesTemplate", "ItemProperties")
	
	WindowSetDimensions(mainWindow, width, 0)
	WindowSetShowing(mainWindow .. "DurBar", false)
	WindowSetShowing(mainWindow .. "DurBarFill", false)
	WindowSetShowing(mainWindow .. "DurBarValue", false)
	WindowSetShowing(mainWindow .. "Charges", false)
	
	WindowSetShowing(mainWindow .. "Human", false)
	WindowSetShowing(mainWindow .. "Elf", false)
	WindowSetShowing(mainWindow .. "Gargoyle", false)
	WindowSetShowing(mainWindow .. "Weight", false)
	WindowSetShowing(mainWindow .. "Str", false)
	
	WindowSetAlpha(mainWindow .. "WindowBackground", 0.8)
	
	local textProperties = ItemProperties.CurrentBaseData.OriginalProps.PropertiesList
	if not textProperties then
		ItemProperties.loading = nil
		return
	end
	
	local itemColor = Interface.Settings.Props_TITLE_COLOR
	
	if ItemProperties.CurrentBaseData.Set then
		itemColor = Interface.Settings.Props_SET_COLOR
	elseif ItemProperties.CurrentBaseData.Artifact then
		itemColor = Interface.Settings.Props_ARTIFACT_COLOR
	elseif ItemProperties.CurrentBaseData.Worth == ItemPropertiesInfo.UNRAVEL_RelicFragment then
		itemColor = Interface.Settings.Props_RELIC_COLOR
	elseif ItemProperties.CurrentBaseData.Worth == ItemPropertiesInfo.UNRAVEL_EnchantedEssence then
		itemColor = Interface.Settings.Props_ESSENCE_COLOR
	elseif ItemProperties.CurrentBaseData.Worth == ItemPropertiesInfo.UNRAVEL_MagicResidue then
		itemColor = Interface.Settings.Props_RESIDUE_COLOR
	end
	
	if ItemProperties.CurrentBaseData.stereotype == ItemPropertiesInfo.Sword then
		DynamicImageSetTexture(mainWindow .. "Stereotype", "STEREOTYPE_Sword", 0, 0)
	elseif ItemProperties.CurrentBaseData.stereotype == ItemPropertiesInfo.Dagger then
		DynamicImageSetTexture(mainWindow .. "Stereotype", "STEREOTYPE_Dagger", 0, 0)	
	elseif ItemProperties.CurrentBaseData.stereotype == ItemPropertiesInfo.Mace then
		DynamicImageSetTexture(mainWindow .. "Stereotype", "STEREOTYPE_Mace", 0, 0)
	elseif ItemProperties.CurrentBaseData.stereotype == ItemPropertiesInfo.Axe then
		DynamicImageSetTexture(mainWindow .. "Stereotype", "STEREOTYPE_Axe", 0, 0)
	elseif ItemProperties.CurrentBaseData.stereotype == ItemPropertiesInfo.Polearm then
		DynamicImageSetTexture(mainWindow .. "Stereotype", "STEREOTYPE_Polearm", 0, 0)
	elseif ItemProperties.CurrentBaseData.stereotype == ItemPropertiesInfo.Bow then
		DynamicImageSetTexture(mainWindow .. "Stereotype", "STEREOTYPE_Bow", 0, 0)
	elseif ItemProperties.CurrentBaseData.stereotype == ItemPropertiesInfo.Boomerang then
		DynamicImageSetTexture(mainWindow .. "Stereotype", "STEREOTYPE_Boomerang", 0, 0)
	elseif ItemProperties.CurrentBaseData.stereotype == ItemPropertiesInfo.Spellbook then
		DynamicImageSetTexture(mainWindow .. "Stereotype", "STEREOTYPE_Spellbook", 0, 0)
	elseif ItemProperties.CurrentBaseData.stereotype == ItemPropertiesInfo.FishingPole then
		DynamicImageSetTexture(mainWindow .. "Stereotype", "STEREOTYPE_FishingPole", 0, 0)
	end
	
	if not ItemProperties.CurrentBaseData.ExpandedProps[1080418] then -- (imbued)
		WindowSetShowing(mainWindow .. "Imbued", false)
	end
	
	-- reforged items star are in the color of the item type
	if ItemProperties.CurrentBaseData.ExpandedProps[1152281] then -- Reforged (Minor)
		DynamicImageSetTexture(mainWindow .. "Stars", "PROPS_1Star", 0, 0)
		WindowSetTintColor(mainWindow .. "Stars", itemColor.r, itemColor.g, itemColor.b)
	elseif ItemProperties.CurrentBaseData.ExpandedProps[1152282] then -- Reforged (Lesser)
		DynamicImageSetTexture(mainWindow .. "Stars", "PROPS_2Star", 0, 0)
		WindowSetTintColor(mainWindow .. "Stars", itemColor.r, itemColor.g, itemColor.b)
	elseif ItemProperties.CurrentBaseData.ExpandedProps[1152283] then -- Reforged (Greater)
		DynamicImageSetTexture(mainWindow .. "Stars", "PROPS_3Star", 0, 0)
		WindowSetTintColor(mainWindow .. "Stars", itemColor.r, itemColor.g, itemColor.b)
	elseif ItemProperties.CurrentBaseData.ExpandedProps[1152284] then -- Reforged (Major)
		DynamicImageSetTexture(mainWindow .. "Stars", "PROPS_4Star", 0, 0)
		WindowSetTintColor(mainWindow .. "Stars", itemColor.r, itemColor.g, itemColor.b)
	elseif ItemProperties.CurrentBaseData.ExpandedProps[1152285] then -- Reforged (Legendary)
		DynamicImageSetTexture(mainWindow .. "Stars", "PROPS_5Star", 0, 0)
		WindowSetTintColor(mainWindow .. "Stars", itemColor.r, itemColor.g, itemColor.b)
	end
		
	-- magic items stars are in the color of the magic property and can have 4 stars at best
	if ItemProperties.CurrentBaseData.ExpandedProps[1151488] then -- Minor Magic Item
		DynamicImageSetTexture(mainWindow .. "Stars", "PROPS_1Star", 0, 0)
		WindowSetTintColor(mainWindow .. "Stars", 0, 153, 255)
	elseif ItemProperties.CurrentBaseData.ExpandedProps[1151489] then -- Lesser Magic Item
		DynamicImageSetTexture(mainWindow .. "Stars", "PROPS_2Star", 0, 0)
		WindowSetTintColor(mainWindow .. "Stars", 0, 153, 255)
	elseif ItemProperties.CurrentBaseData.ExpandedProps[1151490] then -- Greater Magic Item
		DynamicImageSetTexture(mainWindow .. "Stars", "PROPS_3Star", 0, 0)
		WindowSetTintColor(mainWindow .. "Stars", 0, 153, 255)
	elseif ItemProperties.CurrentBaseData.ExpandedProps[1151491] then -- Major Magic Item
		DynamicImageSetTexture(mainWindow .. "Stars", "PROPS_4Star", 0, 0)
		WindowSetTintColor(mainWindow .. "Stars", 0, 153, 255)
	end	
	
	-- artifacts uses the engrave color and starts from 2 stars
	if ItemProperties.CurrentBaseData.ExpandedProps[1151492] then -- Lesser Artifact
		DynamicImageSetTexture(mainWindow .. "Stars", "PROPS_2Star", 0, 0)
		WindowSetTintColor(mainWindow .. "Stars", Interface.Settings.Props_ENGRAVE_COLOR.r, Interface.Settings.Props_ENGRAVE_COLOR.g, Interface.Settings.Props_ENGRAVE_COLOR.b)
	elseif ItemProperties.CurrentBaseData.ExpandedProps[1151493] then -- Greater Artifact
		DynamicImageSetTexture(mainWindow .. "Stars", "PROPS_3Star", 0, 0)
		WindowSetTintColor(mainWindow .. "Stars", Interface.Settings.Props_ENGRAVE_COLOR.r, Interface.Settings.Props_ENGRAVE_COLOR.g, Interface.Settings.Props_ENGRAVE_COLOR.b)
	elseif ItemProperties.CurrentBaseData.ExpandedProps[1151494] then -- Major Artifact
		DynamicImageSetTexture(mainWindow .. "Stars", "PROPS_4Star", 0, 0)
		WindowSetTintColor(mainWindow .. "Stars", Interface.Settings.Props_ENGRAVE_COLOR.r, Interface.Settings.Props_ENGRAVE_COLOR.g, Interface.Settings.Props_ENGRAVE_COLOR.b)
	elseif ItemProperties.CurrentBaseData.ExpandedProps[1151495] then -- Legendary Artifact
		DynamicImageSetTexture(mainWindow .. "Stars", "PROPS_5Star", 0, 0)
		WindowSetTintColor(mainWindow .. "Stars", Interface.Settings.Props_ENGRAVE_COLOR.r, Interface.Settings.Props_ENGRAVE_COLOR.g, Interface.Settings.Props_ENGRAVE_COLOR.b)
	end
	
	if not ItemProperties.CurrentBaseData.ExpandedProps[1116209] then -- Brittle
		WindowSetShowing(mainWindow .. "Brittle", false)
	elseif not ItemProperties.CurrentBaseData.ExpandedProps[1080418] then -- (imbued)
		WindowClearAnchors(mainWindow .. "Brittle")
		WindowAddAnchor(mainWindow .. "Brittle", "bottom", mainWindow .. "Stereotype", "top", 0, 0)
	end
	
	if ItemProperties.CurrentBaseData.ExpandedProps[1116209] and ItemProperties.CurrentBaseData.ExpandedProps[1080418] then -- Brittle and Imbued
		WindowClearAnchors(mainWindow .. "Line1")
		WindowAddAnchor(mainWindow .. "Line1", "bottomleft", mainWindow .. "CraftedBy", "topleft", -78, 20)
	else
		WindowClearAnchors(mainWindow .. "Line1")
		WindowAddAnchor(mainWindow .. "Line1", "bottomleft", mainWindow .. "CraftedBy", "topleft", -78, 10)
	end
	  
	local itemName = Shopkeeper.stripFirstNumber(WindowUtils.translateMarkup(textProperties[1]))
	if ItemProperties.CurrentBaseData.ExpandedProps[1050039] or (ItemProperties.CurrentBaseData.quantity and ItemProperties.CurrentBaseData.quantity > 1) then -- ~1_NUMBER~ ~2_ITEMNAME~
		local amount = StringUtils.AddCommasToNumber(ItemProperties.CurrentBaseData.quantity)
		itemName = ReplaceTokens(GetStringFromTid(1050039), {amount, itemName} )
	end
	LabelSetText(mainWindow .. "ItemName", itemName )
		
	WindowSetTintColor(mainWindow .. "Line2", 50, 50, 50)
	
	-- We have to re-set the height of the lines otherwise they will just show with a wrong dimension.
	WindowSetDimensions(mainWindow .. "Line1", 445, 3)
	WindowSetDimensions(mainWindow .. "Line1", 445, 2)
	
	WindowSetDimensions(mainWindow .. "Line2", 170, 2)
	WindowSetDimensions(mainWindow .. "Line2", 170, 1)
	
	WindowSetDimensions(mainWindow .. "Line3", 445, 3)
	WindowSetDimensions(mainWindow .. "Line3", 445, 2)
	
	WindowSetDimensions(mainWindow .. "Line4", 445, 3)
	WindowSetDimensions(mainWindow .. "Line4", 445, 2)
	
	-- 
	
	WindowSetAlpha(mainWindow .. "Line1", 0.6)
	WindowSetAlpha(mainWindow .. "Line3", 0.6)
	WindowSetAlpha(mainWindow .. "Line4", 0.6)
	
	LabelSetTextColor(mainWindow .. "ItemName", itemColor.r, itemColor.g, itemColor.b)
	WindowSetTintColor(mainWindow .. "Frame", itemColor.r, itemColor.g, itemColor.b)
	WindowSetTintColor(mainWindow .. "Line1", itemColor.r, itemColor.g, itemColor.b)
	WindowSetTintColor(mainWindow .. "Line3", itemColor.r, itemColor.g, itemColor.b)
	WindowSetTintColor(mainWindow .. "Line4", itemColor.r, itemColor.g, itemColor.b)
		
	LabelSetText(mainWindow .. "Hands", L"" )
	
	local th = GetStringFromTid(47)
	if ItemProperties.CurrentBaseData.TwoHanded then
		th = GetStringFromTid(48)
	end

	LabelSetText(mainWindow .. "Hands", th )
	
	if ItemProperties.CurrentBaseData.Engrave then
		LabelSetTextColor(mainWindow .. "Engrave", Interface.Settings.Props_ENGRAVE_COLOR.r, Interface.Settings.Props_ENGRAVE_COLOR.g, Interface.Settings.Props_ENGRAVE_COLOR.b)
		LabelSetText(mainWindow .. "Engrave", ItemProperties.CurrentBaseData.Engrave )
		
	elseif ItemProperties.CurrentBaseData.SellerDesc then
		LabelSetTextColor(mainWindow .. "Engrave", Interface.Settings.Props_ENGRAVE_COLOR.r, Interface.Settings.Props_ENGRAVE_COLOR.g, Interface.Settings.Props_ENGRAVE_COLOR.b)
		LabelSetText(mainWindow .. "Engrave", ItemProperties.CurrentBaseData.SellerDesc )
		
	else
		local w, _ = WindowGetDimensions(mainWindow .. "Engrave")
		WindowSetDimensions(mainWindow .. "Engrave", w, 0) 
	end
	
	LabelSetText(mainWindow .. "ItemType", L"(" .. FormatProperly(GetStringFromTid(ItemProperties.CurrentBaseData.TypeName )) .. L" - ID: " .. ItemProperties.CurrentBaseData.objType .. L")" )
	
	if ItemProperties.CurrentBaseData.Material and ItemProperties.CurrentBaseData.Material ~= 0 then
		LabelSetText(mainWindow .. "MaterialType", FormatProperly(GetStringFromTid(ItemProperties.CurrentBaseData.Material)) )
	elseif ItemProperties.CurrentBaseData.materialKind == ItemPropertiesInfo.MATERIAL_CLOTH then
		LabelSetText(mainWindow .. "MaterialType", FormatProperly(GetStringFromTid(1025989)) ) -- cloth
	elseif ItemProperties.CurrentBaseData.materialKind == ItemPropertiesInfo.MATERIAL_PAPER then
		LabelSetText(mainWindow .. "MaterialType", FormatProperly(GetStringFromTid(54)) ) -- paper
	end
	
	if ItemProperties.CurrentBaseData.ExpandedProps[1050043] then -- crafted by ~1_NAME~
		local craftedBy = FormatProperly(ReplaceTokens(GetStringFromTid(1050043), ItemProperties.CurrentBaseData.ExpandedProps[1050043]))
		
		if ItemProperties.CurrentBaseData.ExpandedProps[1060636] then  -- exceptional
			craftedBy = FormatProperly(ReplaceTokens(GetStringFromTid(42), ItemProperties.CurrentBaseData.ExpandedProps[1050043]))
		end
		
		LabelSetText(mainWindow .. "CraftedBy", craftedBy )
		
	elseif ItemProperties.CurrentBaseData.ExpandedProps[1060636] then  -- exceptional
		LabelSetText(mainWindow .. "CraftedBy", FormatProperly(GetStringFromTid(1060636)) )
	end
	
	WindowSetShowing(mainWindow .. "SpellChannelingDeny", not ItemProperties.CurrentBaseData.ExpandedProps[1060482]) -- spell channeling
	
	if ItemProperties.CurrentBaseData.ExpandedProps[1049643] then -- cursed
		DynamicImageSetTexture(mainWindow .. "Status", "PROPS_Cursed", 0, 0)
	end
	if ItemProperties.CurrentBaseData.ExpandedProps[1038021] then -- Blessed
		DynamicImageSetTexture(mainWindow .. "Status", "PROPS_Blessed", 0, 0)
	end
	
	-- the blessed mark is visible only if the blessed for matches the player name
	
	local redOwned = false
	if ItemProperties.CurrentBaseData.ExpandedProps[1062203] then -- Blessed for ~1_NAME~
		local params = ItemProperties.GetObjectPropertiesParamsForTid(GetPlayerID(),1050045)
		local name 
		if params then
			name = params[2]
		end
		
		local pname = ItemProperties.CurrentBaseData.ExpandedProps[1062203][1]
		if pname == name then
			DynamicImageSetTexture(mainWindow .. "Status", "PROPS_Blessed", 0, 0)
		else
			DynamicImageSetTexture(mainWindow .. "Status", "PROPS_BadBlessed", 0, 0) -- wrong owner
			redOwned = true
		end
	elseif ItemProperties.CurrentBaseData.ExpandedProps[1072304] then --  : Owned by ~1_name~
		local params = ItemProperties.GetObjectPropertiesParamsForTid(GetPlayerID(),1050045)
		local name 
		if params then
			name = params[2]
		end
		local pname = ItemProperties.CurrentBaseData.ExpandedProps[1072304][1]
		if pname == name then
			DynamicImageSetTexture(mainWindow .. "Status", "PROPS_Blessed", 0, 0)
		else
			DynamicImageSetTexture(mainWindow .. "Status", "PROPS_BadBlessed", 0, 0) -- wrong owner
			redOwned = true
		end
	end
	
	if ItemProperties.CurrentBaseData.ExpandedProps[1061682] then --  <b>Insured</b>
		DynamicImageSetTexture(mainWindow .. "Status", "PROPS_Insured", 0, 0)
	end
	
	LabelSetTextColor(mainWindow .. "PhysicalDamage", Interface.Settings.PHYSICAL.r, Interface.Settings.PHYSICAL.g, Interface.Settings.PHYSICAL.b)
	if ItemProperties.CurrentBaseData.ExpandedProps[1060403] then  -- physical damage ~1_val~%
		LabelSetText(mainWindow .. "PhysicalDamage", ItemProperties.CurrentBaseData.ExpandedProps[1060403].value .. L"%" )
	else
		LabelSetText(mainWindow .. "PhysicalDamage", L"0%" )
	end
	
	LabelSetTextColor(mainWindow .. "FireDamage", Interface.Settings.FIRE.r, Interface.Settings.FIRE.g, Interface.Settings.FIRE.b)
	if ItemProperties.CurrentBaseData.ExpandedProps[1060405] then  -- fire damage ~1_val~%
		LabelSetText(mainWindow .. "FireDamage", ItemProperties.CurrentBaseData.ExpandedProps[1060405].value .. L"%" )
	else
		LabelSetText(mainWindow .. "FireDamage", L"0%" )
	end
	
	LabelSetTextColor(mainWindow .. "ColdDamage", Interface.Settings.COLD.r, Interface.Settings.COLD.g, Interface.Settings.COLD.b)
	if ItemProperties.CurrentBaseData.ExpandedProps[1060404] then  -- cold damage ~1_val~%
		LabelSetText(mainWindow .. "ColdDamage", ItemProperties.CurrentBaseData.ExpandedProps[1060404].value .. L"%" )
	else
		LabelSetText(mainWindow .. "ColdDamage", L"0%" )
	end
	
	LabelSetTextColor(mainWindow .. "PoisonDamage", Interface.Settings.POISON.r, Interface.Settings.POISON.g, Interface.Settings.POISON.b)
	if ItemProperties.CurrentBaseData.ExpandedProps[1060406] then  -- poison damage ~1_val~%
		LabelSetText(mainWindow .. "PoisonDamage", ItemProperties.CurrentBaseData.ExpandedProps[1060406].value .. L"%" )
	else
		LabelSetText(mainWindow .. "PoisonDamage", L"0%" )
	end
	
	LabelSetTextColor(mainWindow .. "EnergyDamage", Interface.Settings.ENERGY.r, Interface.Settings.ENERGY.g, Interface.Settings.ENERGY.b)
	if ItemProperties.CurrentBaseData.ExpandedProps[1060407] then  -- energy damage ~1_val~%
		LabelSetText(mainWindow .. "EnergyDamage", ItemProperties.CurrentBaseData.ExpandedProps[1060407].value .. L"%" )
	else
		LabelSetText(mainWindow .. "EnergyDamage", L"0%" )
	end
	
	LabelSetTextColor(mainWindow .. "ChaosDamage", Interface.Settings.Chaos.r, Interface.Settings.Chaos.g, Interface.Settings.Chaos.b)
	if ItemProperties.CurrentBaseData.ExpandedProps[1072846] then  -- chaos damage ~1_val~%
		LabelSetText(mainWindow .. "ChaosDamage", ItemProperties.CurrentBaseData.ExpandedProps[1072846].value .. L"%" )
	else
		LabelSetText(mainWindow .. "ChaosDamage", L"0%" )
	end

	LabelSetText(mainWindow .. "DPSName", GetStringFromTid(43) )
	if not ItemProperties.CurrentBaseData.WeaponDPS then
		ItemProperties.CurrentBaseData.WeaponDPS = 0
	end
	LabelSetText(mainWindow .. "DPSValue", wstring.format(L"%.2f", ItemProperties.CurrentBaseData.WeaponDPS))
	
	if ItemProperties.CurrentBaseData.EquippedData and ItemProperties.CurrentBaseData.EquippedData.WeaponDPS then
		local dpsVar = ItemProperties.CurrentBaseData.WeaponDPS - ItemProperties.CurrentBaseData.EquippedData.WeaponDPS
		if dpsVar > 0 then
			LabelSetTextColor(mainWindow .. "DPSChange", 0, 255, 0)
			LabelSetText(mainWindow .. "DPSChange", L"(+" .. wstring.format(L"%.2f", dpsVar) .. L")" )
		elseif dpsVar < 0 then
			LabelSetTextColor(mainWindow .. "DPSChange", 255, 0, 0)
			LabelSetText(mainWindow .. "DPSChange", L"(" .. wstring.format(L"%.2f", dpsVar) .. L")" )
		else
			LabelSetText(mainWindow .. "DPSChange", L"(" .. wstring.format(L"%.2f", dpsVar) .. L")" )
		end
		
	end
	
	if not ItemProperties.CurrentBaseData.WeaponDamageData then
		ItemProperties.CurrentBaseData.WeaponDamageData = {}
		ItemProperties.CurrentBaseData.WeaponDamageData.min = 0
		ItemProperties.CurrentBaseData.WeaponDamageData.max = 0
		ItemProperties.CurrentBaseData.WeaponDamageData.speed = 0
	end
	
	LabelSetText(mainWindow .. "WeaponDamageName", GetStringFromTid(44) )
	LabelSetText(mainWindow .. "WeaponDamageValue", towstring(ItemProperties.CurrentBaseData.WeaponDamageData.min) .. L" - " .. towstring(ItemProperties.CurrentBaseData.WeaponDamageData.max) )
	
	LabelSetText(mainWindow .. "WeaponSpeedName", GetStringFromTid(45) )
	LabelSetText(mainWindow .. "WeaponSpeedValue", towstring(ItemProperties.CurrentBaseData.WeaponDamageData.speed) .. L"s" )
	
	LabelSetText(mainWindow .. "WeaponRangeName", GetStringFromTid(50) )
	
	if ItemProperties.CurrentBaseData.ExpandedProps[1061169] then
		LabelSetText(mainWindow .. "WeaponRangeValue", ItemProperties.CurrentBaseData.ExpandedProps[1061169][1] )
	else
		WindowSetShowing(mainWindow .. "WeaponRangeName", false)
		WindowSetShowing(mainWindow .. "WeaponRangeValue", false)
		
		WindowClearAnchors(mainWindow .. "Line2")
		WindowAddAnchor(mainWindow .. "Line2", "bottomright", mainWindow .. "Line1", "topleft", -180, 135)
	end
	
	LabelSetText(mainWindow .. "SpecialAttacks", GetStringFromTid(46) )
	
	if ItemProperties.CurrentBaseData.Special1 then
		DynamicImageSetTexture(mainWindow .. "Special1", ItemProperties.CurrentBaseData.Special1.texture, ItemProperties.CurrentBaseData.Special1.x, ItemProperties.CurrentBaseData.Special1.y)
	end
	
	if ItemProperties.CurrentBaseData.Special2 then
		DynamicImageSetTexture(mainWindow .. "Special2", ItemProperties.CurrentBaseData.Special2.texture, ItemProperties.CurrentBaseData.Special2.x, ItemProperties.CurrentBaseData.Special2.y)	
	end
	
	if ItemProperties.CurrentBaseData.ExpandedProps[1061172] then  -- skill required: swordsmanship
		LabelSetText(mainWindow .. "WeaponSkill", FormatProperly(GetStringFromTid(1061172)) )
	elseif ItemProperties.CurrentBaseData.ExpandedProps[1061173] then  -- skill required: mace fighting
		LabelSetText(mainWindow .. "WeaponSkill", FormatProperly(GetStringFromTid(1061173)) )
	elseif ItemProperties.CurrentBaseData.ExpandedProps[1061174] then  -- skill required: fencing
		LabelSetText(mainWindow .. "WeaponSkill", FormatProperly(GetStringFromTid(1061174)) )
	elseif ItemProperties.CurrentBaseData.ExpandedProps[1061175] then  -- skill required: archery
		LabelSetText(mainWindow .. "WeaponSkill", FormatProperly(GetStringFromTid(1061175)) )
	elseif ItemProperties.CurrentBaseData.ExpandedProps[1112075] then  -- skill required: throwing
		LabelSetText(mainWindow .. "WeaponSkill", FormatProperly(GetStringFromTid(1112075)) )
	end
	
	if ItemProperties.CurrentBaseData.ExpandedProps[1060400] then  -- use best weapon skill
		LabelSetText(mainWindow .. "UBWS",  L" (" .. FormatProperly(GetStringFromTid(1060400)) .. L")" )
	end
	
	
	-- getting the height
	local baseH = 0
	
	-- in order to determine the correct size of the labels, we have to add a margin that vary based on the font size
	
	local x, y = WindowGetDimensions(mainWindow .. "ItemName")
	local point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (mainWindow .. "ItemName", 1)
	baseH = baseH + y + yOffs + 10 
	
	x, y = WindowGetDimensions(mainWindow .. "Engrave")
	point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (mainWindow .. "Engrave", 1)
	baseH = baseH + y + yOffs
	
	x, y = WindowGetDimensions(mainWindow .. "SpellChanneling")
	point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (mainWindow .. "ItemType", 1)
	baseH = baseH + y + yOffs
	
	x, y = WindowGetDimensions(mainWindow .. "CraftedBy")
	point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (mainWindow .. "CraftedBy", 1)
	baseH = baseH + y + yOffs 
	
	x, y = WindowGetDimensions(mainWindow .. "Line1")
	point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (mainWindow .. "Line1", 1)
	baseH = baseH + y + yOffs
	
	x, y = WindowGetDimensions(mainWindow .. "Line3")
	point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (mainWindow .. "Line3", 1)
	baseH = baseH + y + yOffs
	
		
	-- adding all the remaining properties
	local sortedProps = {}
	local propCount = 0
	local lootCap = ItemPropertiesInfo.GetDiffCap(ItemProperties.CurrentBaseData.ExpandedProps)
	
	for tid, params in pairs(ItemProperties.CurrentBaseData.ExpandedProps) do
		local prop = ItemProperties.CurrentBaseData.ExpandedProps[tid]
		if type(prop) == "string" then
			prop = {}
		end
		prop.tid = tid
		if lootCap then
			if ItemProperties.CurrentBaseData.GumpType == ItemPropertiesInfo.Types.Ranged_Weapon and ItemPropertiesInfo.LootCaps[tid] then
				prop.trueCap = ItemPropertiesInfo.LootCaps[tid].rangedCap
				
			elseif ItemProperties.CurrentBaseData.GumpType == ItemPropertiesInfo.Types.Jewel and ItemPropertiesInfo.LootCaps[tid] then
				prop.trueCap = ItemPropertiesInfo.LootCaps[tid].jewelryCap
				
			elseif ItemProperties.CurrentBaseData.GumpType == ItemPropertiesInfo.Types.Weapon and ItemPropertiesInfo.LootCaps[tid] then
				prop.trueCap = ItemPropertiesInfo.LootCaps[tid].weaponCap
				
			elseif ItemProperties.CurrentBaseData.GumpType == ItemPropertiesInfo.Types.Shield and ItemPropertiesInfo.LootCaps[tid] then
				prop.trueCap = ItemPropertiesInfo.LootCaps[tid].shieldCap
			
			elseif ItemProperties.CurrentBaseData.GumpType == ItemPropertiesInfo.Types.Wearable and ItemPropertiesInfo.LootCaps[tid] then
				prop.trueCap = ItemPropertiesInfo.LootCaps[tid].armorCap
			end
		end
		if prop.tid == 1072304 and not redOwned then  -- hiding "owned by" if you are the owner
			continue
		end
		if ItemPropertiesInfo.Materials[tid] then
			continue
		end
		if not prop or tid == 0 or ItemPropertiesInfo.NotListed[prop.tid] or ItemPropertiesInfo.WeightONLYTid[prop.tid] or (ItemPropertiesInfo.ChargesTid[prop.tid] and not ItemPropertiesInfo.SpellChargesTid[prop.tid]) or not prop.index or prop.index <= 1 or ItemPropertiesInfo.UselessRefinementData[prop.tid] then
			continue
		end
		sortedProps[prop.index] = prop
		propCount = propCount + 1
	end
	
	local propsH = 0
	
	if propCount > 0  then
		local topAnchor = mainWindow .. "Line3"
		local topmargin = 5
		propsH = topmargin
		local prevLabel
		local currLabel
		local idx = 1
		for i, _ in pairsByKeys(sortedProps) do
			local prop = sortedProps[i]
			currLabel = "prop" .. idx
			prevLabel = "prop" .. idx - 1
			
			if prop.tid == 1060438 then -- mage weapon
				prop.value = prop.value * -1
			end
						
			CreateWindowFromTemplate(currLabel, "NewItemPropItemDef", mainWindow)
			if prop.tid == 1072304 and redOwned then
				 LabelSetTextColor(currLabel .. "Text", 255, 0, 0)
			elseif prop.tid == 1043304 then -- Price: ~1_COST~
				LabelSetTextColor(currLabel .. "Text", Interface.Settings.Props_ENGRAVE_COLOR.r, Interface.Settings.Props_ENGRAVE_COLOR.g, Interface.Settings.Props_ENGRAVE_COLOR.b)
			elseif prop.tid == 1043306 then -- Price: FREE!
				LabelSetTextColor(currLabel .. "Text", 0, 255, 0)
			elseif prop.tid == 1043307 then -- Price: Not for sale.
				LabelSetTextColor(currLabel .. "Text", 255, 0, 0)
			elseif (prop.value and prop.value < 0) or (prop[1] and tonumber(prop[1]) and tonumber(prop[1]) < 0) or prop.tid == 1049643 or prop.tid == 1116209 or prop.tid == 1152714 or prop.tid == 1154910 or prop.tid == 1154910  or prop.tid == 1154909  or prop.tid == 1155420 then -- cursed, brittle, antique, prized, unwieldly, massive or negative value
				LabelSetTextColor(currLabel .. "Text", 255, 0, 0)
			elseif ItemPropertiesInfo.SetProperties[prop.tid] then
				LabelSetTextColor(currLabel .. "Text", Interface.Settings.Props_SET_COLOR.r, Interface.Settings.Props_SET_COLOR.g, Interface.Settings.Props_SET_COLOR.b)
			elseif prop.intensity and tonumber(prop.intensity) and Interface.Settings.IntensInfo then
				LabelSetTextColor(currLabel .. "Text", ItemProperties.GetIntensityColor(prop.intensity))
			elseif ItemPropertiesInfo.ExpansionProperties[prop.tid] and not Interface.ActiveAccountFeatures[ItemPropertiesInfo.ExpansionProperties[prop.tid]] then
				LabelSetTextColor(currLabel .. "Text", 255, 0, 0)
			else
				LabelSetTextColor(currLabel .. "Text", Interface.Settings.Props_MAGICPROP_COLOR.r, Interface.Settings.Props_MAGICPROP_COLOR.g, Interface.Settings.Props_MAGICPROP_COLOR.b)
			end
			if idx == 1 then
				WindowAddAnchor(currLabel, "bottomleft", topAnchor, "topleft", 10, topmargin)
			else
				WindowAddAnchor(currLabel, "bottomleft", prevLabel, "topleft", 0, 10)
			end
			
			if prop.tid == 1072378 then -- Only when full set is present:
				prop.raw = wstring.gsub(prop.raw, L"\n", L"")
			end
			
			if ItemPropertiesInfo.DecoProperties[prop.tid] or (prop and prop.desc) then
				local _, h = WindowGetDimensions(currLabel .. "Text")
				WindowSetDimensions(currLabel .. "Text", 409, h)
			end
			
			--if idx == 1 then
			--	LabelSetText(currLabel .. "Text",  FormatProperly(L"Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis,") ) 
			--else
				LabelSetText(currLabel .. "Text",  FormatProperly(prop.raw) ) 
			--end
			
			local _, h = WindowGetDimensions(currLabel .. "Text")
			local w, _ = WindowGetDimensions(currLabel)
			WindowSetDimensions(currLabel, w, h)

			if Interface.Settings.ShowCaps then
				if prop.trueCap then
					LabelSetText(currLabel .. "Cap", ReplaceTokens(GetStringFromTid(49), {wstring.format(L"%.0f", prop.trueCap)}) )
				elseif prop.cap then
					LabelSetText(currLabel .. "Cap", ReplaceTokens(GetStringFromTid(49), {wstring.format(L"%.0f", prop.cap)}) )
				end
			end
			
			DynamicImageSetTexture(currLabel .. "Dot", "PROPS_Description", 0, 0) -- default image
			
			if ItemProperties.CurrentBaseData.EquippedData and not ItemPropertiesInfo.DecoProperties[prop.tid] and not (prop and prop.desc) then
				local eqProp = ItemProperties.CurrentBaseData.EquippedData.props[prop.tid]
				if prop.cap then
					if eqProp and eqProp[1] and prop.value then
						local currentValue = tonumber(eqProp[1])
						local diff = prop.value - tonumber(eqProp[1])
						
						local currentPlayerValue = WindowData.PlayerStatus[prop.sheetName]
						local totalCap = WindowData.PlayerStatus["Max"..prop.sheetName]
						
						if not totalCap then
							totalCap = CharacterSheet.CapsBonus[prop.sheetName]
						end
						
						-- we have to check if the new value will goes over the cap, and if it does, we just count what will effectively be "used"
						if totalCap then 
							currentPlayerValue = currentPlayerValue - currentValue
							currentPlayerValue = currentPlayerValue + prop.value
							if currentPlayerValue > totalCap then
								local exceed = currentPlayerValue - totalCap
								if exceed < 0 then -- we remove the exceeding part
									diff = diff + exceed
								end
							end
						end
						
						if diff > 0 then
							LabelSetTextColor(currLabel .. "Change", 0, 255, 0)
							DynamicImageSetTexture(currLabel .. "Dot", "PROPS_Gain", 0, 0)
							LabelSetText(currLabel .. "Change", L"(+" .. wstring.format(L"%.0f", diff) .. L")" )
						elseif diff < 0 then
							LabelSetTextColor(currLabel .. "Change", 255, 0, 0)
							DynamicImageSetTexture(currLabel .. "Dot", "PROPS_Lose", 0, 0)
							LabelSetText(currLabel .. "Change", L"(" .. wstring.format(L"%.0f", diff) .. L")" )
						else
							DynamicImageSetTexture(currLabel .. "Dot", "PROPS_Equal", 0, 0)
						end
						
					elseif not ItemPropertiesInfo.DecoProperties[prop.tid] and not (prop and prop.desc) then
						
						local diff = prop.value
						
						local currentPlayerValue = WindowData.PlayerStatus[prop.sheetName]
						local totalCap = WindowData.PlayerStatus["Max"..prop.sheetName]
						
						if not totalCap then
							totalCap = CharacterSheet.CapsBonus[prop.sheetName]
						end
						
						-- we have to check if the new value will goes over the cap, and if it does, we just count what will effectively be "used"
						if totalCap then 
							currentPlayerValue = currentPlayerValue + prop.value
							if currentPlayerValue > totalCap then
								local exceed = currentPlayerValue - totalCap
								if exceed < 0 then -- we remove the exceeding part
									diff = diff + exceed
								end
							end
						end
						
						if diff > 0 then
							DynamicImageSetTexture(currLabel .. "Dot", "PROPS_Gain", 0, 0)
							LabelSetTextColor(currLabel .. "Change", 0, 255, 0)
							LabelSetText(currLabel .. "Change", L"(+" .. wstring.format(L"%.0f", diff) .. L")" )
						elseif diff < 0 then
							DynamicImageSetTexture(currLabel .. "Dot", "PROPS_Lose", 0, 0)
							LabelSetTextColor(currLabel .. "Change", 255, 0, 0)
							LabelSetText(currLabel .. "Change", L"(" .. wstring.format(L"%.0f", diff) .. L")" )
						else
							DynamicImageSetTexture(currLabel .. "Dot", "PROPS_Equal", 0, 0)
						end
						
						
					else
						DynamicImageSetTexture(currLabel .. "Dot", "PROPS_Description", 0, 0)
					end
				else
					if eqProp then
						DynamicImageSetTexture(currLabel .. "Dot", "PROPS_Equal", 0, 0)	
					elseif not ItemPropertiesInfo.DecoProperties[prop.tid] and not (prop and prop.desc) then
						DynamicImageSetTexture(currLabel .. "Dot", "PROPS_Gain", 0, 0)	
					else
						DynamicImageSetTexture(currLabel .. "Dot", "PROPS_Description", 0, 0)
					end
				end
			end
			
			x, y = WindowGetDimensions(currLabel)
			point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (currLabel, 1)
			propsH = propsH + y + yOffs
			idx = idx + 1

		end

		WindowClearAnchors(mainWindow .. "Line4")
		WindowAddAnchor(mainWindow .. "Line4", "bottomleft", currLabel, "topleft", -10, 10)
		
		x, y = WindowGetDimensions(mainWindow .. "Line4")
		point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (mainWindow .. "Line4", 1)
		propsH = propsH + y + yOffs
	
	else
		WindowSetShowing(mainWindow .. "Line4", false)
		propsH = 5
	end
	
	-- item weight
		
	for tid, param in pairs(ItemPropertiesInfo.WeightONLYTid) do
		if ItemProperties.CurrentBaseData.ExpandedProps[tid] then
			local prop = ItemProperties.CurrentBaseData.ExpandedProps[tid]
			prop.value = tostring(prop[1])
			prop.value = tonumber(prop.value)
			
			if not ItemProperties.CurrentBaseData.equipped and not DoesPlayerHaveItem(ItemProperties.CurrentBaseData.objectId) then -- weight warning
				local w = WindowData.PlayerStatus.Weight + prop.value
				local mw = WindowData.PlayerStatus.MaxWeight - 10	
				if (w >= mw) then
					LabelSetTextColor(mainWindow .. "WeightValue", 255, 0, 0)
					DynamicImageSetTexture(mainWindow .. "Weight", "PROPS_WeightWarning", 0, 0)
				end
			end

			WindowSetShowing(mainWindow .. "Weight", true)
			
			DynamicImageSetTexture(mainWindow .. "Weight", "PROPS_Weight", 0, 0)
			
			LabelSetText(mainWindow .. "WeightValue", Knumber(prop.value) )
			break
		end	
	end
	
	WindowClearAnchors(mainWindow .. "WeightValue")
	WindowAddAnchor(mainWindow .. "WeightValue", "bottomright", mainWindow .. "Line4", "topright", -20, 25)
	
	WindowClearAnchors(mainWindow .. "Weight")
	WindowAddAnchor(mainWindow .. "Weight", "left", mainWindow .. "WeightValue", "right", -10, 0)
	
	-- item str requirement
	
	if ItemProperties.CurrentBaseData.ExpandedProps[1061170] then
		local str = tostring(ItemProperties.CurrentBaseData.ExpandedProps[1061170][1])
		str = tonumber(str)
		WindowSetShowing(mainWindow .. "Str", true)
		local baseStr = tonumber(WindowData.PlayerStatus["Strength"]) - tonumber(WindowData.PlayerStatus["IncreaseStr"])
		if baseStr < str then
			LabelSetTextColor(mainWindow .. "StrValue", 255, 125, 64)
			DynamicImageSetTexture(mainWindow .. "Str", "PROPS_StrWarningBase", 0, 0)
		elseif tonumber(WindowData.PlayerStatus["Strength"]) >= str then
			DynamicImageSetTexture(mainWindow .. "Str", "PROPS_Str", 0, 0)
		else
			LabelSetTextColor(mainWindow .. "StrValue", 255, 0, 0)
			DynamicImageSetTexture(mainWindow .. "Str", "PROPS_StrWarning", 0, 0)
		end
		LabelSetText(mainWindow .. "StrValue", towstring(str) )
	end
	
	WindowClearAnchors(mainWindow .. "StrValue")
	WindowAddAnchor(mainWindow .. "StrValue", "left", mainWindow .. "Weight", "left", -40, 0)
	
	WindowClearAnchors(mainWindow .. "Str")
	WindowAddAnchor(mainWindow .. "Str", "left", mainWindow .. "StrValue", "right", -10, 0)
	
	-- race requirement
	
	if ItemProperties.CurrentBaseData.human == nil then
		WindowSetShowing(mainWindow .. "Human", false)
	elseif not ItemProperties.CurrentBaseData.human then
		DynamicImageSetTexture(mainWindow .. "Human", "PROPS_NoHuman", 0, 0)
		WindowSetShowing(mainWindow .. "Human", true)
	elseif WindowData.PlayerStatus["Race"] ~= 1 then
		DynamicImageSetTexture(mainWindow .. "Human", "PROPS_BadHuman", 0, 0)
		WindowSetShowing(mainWindow .. "Human", true)
	else
		WindowSetShowing(mainWindow .. "Human", true)
	end
	
	WindowClearAnchors(mainWindow .. "Human")
	WindowAddAnchor(mainWindow .. "Human", "bottomleft", mainWindow .. "Line4", "topleft", 20, 10)
	
	if ItemProperties.CurrentBaseData.elf == nil then
		WindowSetShowing(mainWindow .. "Elf", false)
	elseif not ItemProperties.CurrentBaseData.elf then
		DynamicImageSetTexture(mainWindow .. "Elf", "PROPS_NoElf", 0, 0)
		WindowSetShowing(mainWindow .. "Elf", true)
	elseif WindowData.PlayerStatus["Race"] ~= 2 then
		DynamicImageSetTexture(mainWindow .. "Elf", "PROPS_BadElf", 0, 0)
		WindowSetShowing(mainWindow .. "Elf", true)
	else
		WindowSetShowing(mainWindow .. "Elf", true)
	end
	
	WindowClearAnchors(mainWindow .. "Elf")
	WindowAddAnchor(mainWindow .. "Elf", "right", mainWindow .. "Human", "left", 20, 0)
	
	if ItemProperties.CurrentBaseData.gargoyle == nil then
		WindowSetShowing(mainWindow .. "Gargoyle", false)
	elseif not ItemProperties.CurrentBaseData.gargoyle then
		DynamicImageSetTexture(mainWindow .. "Gargoyle", "PROPS_NoGargoyle", 0, 0)
		WindowSetShowing(mainWindow .. "Gargoyle", true)
	elseif WindowData.PlayerStatus["Race"] ~= 3 then
		DynamicImageSetTexture(mainWindow .. "Gargoyle", "PROPS_BadGargoyle", 0, 0)
		WindowSetShowing(mainWindow .. "Gargoyle", true)
	else
		WindowSetShowing(mainWindow .. "Gargoyle", true)
	end
	
	WindowClearAnchors(mainWindow .. "Gargoyle")
	WindowAddAnchor(mainWindow .. "Gargoyle", "right", mainWindow .. "Elf", "left", 20, 0)
	
	local bottomH = 0
	local bottomReq = 0
	
	x, y = WindowGetDimensions(mainWindow .. "Weight")
	point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (mainWindow .. "WeightValue", 1)
	bottomH = bottomH + y + yOffs
	bottomReq = bottomReq + 1
	
	
	if ItemProperties.CurrentBaseData.uses then
		WindowSetShowing(mainWindow .. "Charges", true)
		LabelSetText(mainWindow .. "ChargesValue", Knumber(ItemProperties.CurrentBaseData.uses) )
		
		WindowClearAnchors(mainWindow .. "Charges")
		WindowAddAnchor(mainWindow .. "Charges", "bottomleft", mainWindow .. "Weight", "topleft", 0, 10)
		
		WindowClearAnchors(mainWindow .. "ChargesValue")
		WindowAddAnchor(mainWindow .. "ChargesValue", "right", mainWindow .. "Charges", "left", 5, 0)
	else
		WindowSetShowing(mainWindow .. "Charges", false)
		WindowSetShowing(mainWindow .. "ChargesValue", false)
	end
	
	WindowClearAnchors(mainWindow .. "DurBar")
	WindowAddAnchor(mainWindow .. "DurBar", "bottomleft", mainWindow .. "Hue", "topleft", 35, 0)
		
	if ItemProperties.CurrentBaseData.hue and ItemProperties.CurrentBaseData.hue ~= 0 then
		EquipmentData.DrawObjectIcon(4011, ItemProperties.CurrentBaseData.hue, mainWindow .. "Hue", 0, 0, 1) -- dye tub image
		
		local hueName = HuesInfo.Data[ItemProperties.CurrentBaseData.hue]
		WindowClearAnchors(mainWindow .. "HueValue")
		if hueName then
			WindowAddAnchor(mainWindow .. "HueValue", "right", mainWindow .. "Hue", "left", 10, -10)
			LabelSetText(mainWindow .. "HueValue", ReplaceTokens(GetStringFromTid(415), {towstring(ItemProperties.CurrentBaseData.hue), hueName}) )
		else
			WindowAddAnchor(mainWindow .. "HueValue", "right", mainWindow .. "Hue", "left", 10, 0)
			LabelSetText(mainWindow .. "HueValue", ReplaceTokens(GetStringFromTid(414), {towstring(ItemProperties.CurrentBaseData.hue)}) )
		end
		
		WindowClearAnchors(mainWindow .. "Hue")
		WindowAddAnchor(mainWindow .. "Hue", "bottomleft", mainWindow .. "Human", "topleft", -5, 15)
		
		WindowClearAnchors(mainWindow .. "HueValue")
		WindowAddAnchor(mainWindow .. "HueValue", "right", mainWindow .. "Hue", "left", 0, -10)
		
		x, y = WindowGetDimensions(mainWindow .. "Hue")
		point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (mainWindow .. "Hue", 1)
		bottomH = bottomH + y + yOffs
		bottomReq = bottomReq + 1
	elseif ItemProperties.CurrentBaseData.uses then
		x, y = WindowGetDimensions(mainWindow .. "Charges")
		point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (mainWindow .. "Charges", 1)
		bottomH = bottomH + y + yOffs
		bottomReq = bottomReq + 1
	elseif not ItemProperties.CurrentBaseData.uses then
		WindowClearAnchors(mainWindow .. "DurBar")
		WindowAddAnchor(mainWindow .. "DurBar", "bottomleft", mainWindow .. "Human", "topleft", 30, 10)
	end
  
	if ItemProperties.CurrentBaseData.Durability and ItemProperties.CurrentBaseData.Durability.max > 0 then
		
		local perc = (ItemProperties.CurrentBaseData.Durability.min / ItemProperties.CurrentBaseData.Durability.max ) * 100
		if type(perc) ~= "number" or perc < 0 or perc > 100 then
			perc = 0
		end
		local gb = math.floor(2.55 * perc)
		LabelSetTextColor(mainWindow .. "DurBarValue", 255, gb, gb)
		
		LabelSetText(mainWindow .. "DurBarValue", ItemProperties.CurrentBaseData.Durability.min .. L" / " .. ItemProperties.CurrentBaseData.Durability.max )
		
		
		local wid = 348 * (perc / 100)

		WindowSetDimensions(mainWindow .. "DurBarFill", wid, 37)
				
		WindowClearAnchors(mainWindow .. "DurBarFill")
		WindowAddAnchor(mainWindow .. "DurBarFill", "topleft", mainWindow .. "DurBar", "topleft", 2, 5)
		
		WindowClearAnchors(mainWindow .. "DurBarValue")
		WindowAddAnchor(mainWindow .. "DurBarValue", "topleft", mainWindow .. "DurBar", "topleft", 10, 7)
		WindowAddAnchor(mainWindow .. "DurBarValue", "bottomright", mainWindow .. "DurBar", "bottomright", 0, -7)
		
		WindowSetShowing(mainWindow .. "DurBar", true)
		WindowSetShowing(mainWindow .. "DurBarFill", true)
		WindowSetShowing(mainWindow .. "DurBarValue", true)
				
		x, y = WindowGetDimensions(mainWindow .. "DurBar")
		point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (mainWindow .. "DurBar", 1)
		bottomH = bottomH + y + yOffs
		bottomReq = bottomReq + 1
	else
		WindowSetShowing(mainWindow .. "DurBar", false)
		WindowSetShowing(mainWindow .. "DurBarFill", false)
		WindowSetShowing(mainWindow .. "DurBarValue", false)
	end
	
	y = baseH + propsH + bottomH
	
	if ItemProperties.CurrentBaseData.Durability and ItemProperties.CurrentBaseData.Durability.max > 0 then
    
		WindowClearAnchors(mainWindow)
		WindowAddAnchor(mainWindow, "topleft", "ItemProperties", "topleft", 0, 0 )
    
		if not DoesWindowExist(mainWindow .. "Marker") then
			CreateWindowFromTemplate(mainWindow .. "Marker", "MarkerLine", "ItemProperties")	
		end
    
		WindowClearAnchors(mainWindow .. "Marker")
		WindowAddAnchor(mainWindow .. "Marker", "bottomright", mainWindow .. "DurBar", "bottomright", 0, 0 )
		
    local mainDimX, mainDimY = WindowGetDimensions(mainWindow)
    local _, _, _, markxOffs, markyOffs = WindowGetAnchor (mainWindow .. "Marker", 1)
   
    WindowSetDimensions(mainWindow, mainDimX, y + markyOffs + 11)
		--WindowAddAnchor(mainWindow, "bottomright", mainWindow .. "Marker", "bottomright", 45, 10 )
    
	else
		WindowSetDimensions(mainWindow, width, y)
	end
	
	WindowSetAlpha(mainWindow .. "HotbarDataWindowBackground", 0.8)
	WindowSetDimensions(mainWindow .. "HotbarData", 350, 70)
	WindowClearAnchors(mainWindow .. "HotbarData")
	WindowAddAnchor(mainWindow .. "HotbarData", "bottomleft", mainWindow, "topleft", 50, 0)
	WindowSetTintColor(mainWindow .. "HotbarDataFrame", itemColor.r, itemColor.g, itemColor.b)
	WindowSetShowing(mainWindow .. "HotbarData", false)
	
	if ((ItemProperties.CurrentItemData.binding ~= nil and wstring.len(ItemProperties.CurrentItemData.binding) > 0) or (ItemProperties.CurrentItemData.myTarget ~= nil and wstring.len(ItemProperties.CurrentItemData.myTarget) > 0)) then
		WindowSetShowing(mainWindow .. "HotbarData", true)
		if (ItemProperties.CurrentItemData.binding ~= nil and wstring.len(ItemProperties.CurrentItemData.binding) > 0) then
			LabelSetText(mainWindow .. "HotbarDataBinding", ItemProperties.CurrentItemData.binding )
		else
			WindowClearAnchors(mainWindow .. "HotbarDataTarget")
			WindowAddAnchor(mainWindow .. "HotbarDataTarget", "topleft", mainWindow .. "HotbarData", "topleft", 10, 10)
			WindowSetDimensions(mainWindow .. "HotbarData", 350, 50)
		end
		if (ItemProperties.CurrentItemData.myTarget ~= nil and wstring.len(ItemProperties.CurrentItemData.myTarget) > 0) then
			LabelSetText(mainWindow .. "HotbarDataTarget", ItemProperties.CurrentItemData.myTarget )
		end
	end
  
	local scale = Interface.Settings.NewItemPropertiesScale
	WindowSetScale(mainWindow, scale)
	WindowSetScale("ItemProperties", scale)

	if GenericGump.CurrentOver == "" or GenericGump.CurrentOver == "VSEARCH" then
		WindowSetDimensions("ItemProperties", width, y)
		
		ItemProperties.FollowMouse()
		WindowSetId("ItemProperties", ItemProperties.CurrentBaseData.objectId)
		
		if not WindowGetShowing("ItemProperties") then
			WindowSetShowing("ItemPropertiesWindowBackground", false)
			WindowSetShowing("ItemPropertiesFrame", false)
			WindowSetShowing("ItemProperties", true)
		end
		
		if GenericGump.CurrentOver == "VSEARCH" then
			WindowSetParent(mainWindow, "Root")
			WindowClearAnchors(mainWindow)
			WindowAddAnchor(mainWindow, "center", ItemProperties.CurrentItemData.windowName, "bottomright", 0, 0)
		end
	else
		WindowSetParent(mainWindow, "Root")
	end
end

function ItemProperties.ShowNoDamageWeaponProps()
	local mainWindow = "SpellbookProperties"
	
	local width = ItemProperties.WeaponGump_Width
	
	CreateWindowFromTemplate(mainWindow, "SpellbookPropertiesTemplate", "ItemProperties")
	
	WindowSetDimensions(mainWindow, width, 0)
	WindowSetShowing(mainWindow .. "DurBar", false)
	WindowSetShowing(mainWindow .. "DurBarFill", false)
	WindowSetShowing(mainWindow .. "DurBarValue", false)
	WindowSetShowing(mainWindow .. "Charges", false)
	
	WindowSetShowing(mainWindow .. "Weight", false)
	WindowSetShowing(mainWindow .. "Str", false)
	
	WindowSetAlpha(mainWindow .. "WindowBackground", 0.8)
	
	local textProperties = ItemProperties.CurrentBaseData.OriginalProps.PropertiesList
	if not textProperties then
		return
	end
	
	local itemColor = Interface.Settings.Props_TITLE_COLOR
	
	if ItemProperties.CurrentBaseData.Set then
		itemColor = Interface.Settings.Props_SET_COLOR
	elseif ItemProperties.CurrentBaseData.Artifact then
		itemColor = Interface.Settings.Props_ARTIFACT_COLOR
	elseif ItemProperties.CurrentBaseData.Worth == ItemPropertiesInfo.UNRAVEL_RelicFragment then
		itemColor = Interface.Settings.Props_RELIC_COLOR
	elseif ItemProperties.CurrentBaseData.Worth == ItemPropertiesInfo.UNRAVEL_EnchantedEssence then
		itemColor = Interface.Settings.Props_ESSENCE_COLOR
	elseif ItemProperties.CurrentBaseData.Worth == ItemPropertiesInfo.UNRAVEL_MagicResidue then
		itemColor = Interface.Settings.Props_RESIDUE_COLOR
	end

	if ItemProperties.CurrentBaseData.stereotype == ItemPropertiesInfo.Sword then
		DynamicImageSetTexture(mainWindow .. "Stereotype", "STEREOTYPE_Sword", 0, 0)
	elseif ItemProperties.CurrentBaseData.stereotype == ItemPropertiesInfo.Dagger then
		DynamicImageSetTexture(mainWindow .. "Stereotype", "STEREOTYPE_Dagger", 0, 0)	
	elseif ItemProperties.CurrentBaseData.stereotype == ItemPropertiesInfo.Mace then
		DynamicImageSetTexture(mainWindow .. "Stereotype", "STEREOTYPE_Mace", 0, 0)
	elseif ItemProperties.CurrentBaseData.stereotype == ItemPropertiesInfo.Axe then
		DynamicImageSetTexture(mainWindow .. "Stereotype", "STEREOTYPE_Axe", 0, 0)
	elseif ItemProperties.CurrentBaseData.stereotype == ItemPropertiesInfo.Polearm then
		DynamicImageSetTexture(mainWindow .. "Stereotype", "STEREOTYPE_Polearm", 0, 0)
	elseif ItemProperties.CurrentBaseData.stereotype == ItemPropertiesInfo.Bow then
		DynamicImageSetTexture(mainWindow .. "Stereotype", "STEREOTYPE_Bow", 0, 0)
	elseif ItemProperties.CurrentBaseData.stereotype == ItemPropertiesInfo.Boomerang then
		DynamicImageSetTexture(mainWindow .. "Stereotype", "STEREOTYPE_Boomerang", 0, 0)
	elseif ItemProperties.CurrentBaseData.stereotype == ItemPropertiesInfo.Spellbook then
		DynamicImageSetTexture(mainWindow .. "Stereotype", "STEREOTYPE_Spellbook", 0, 0)
	elseif ItemProperties.CurrentBaseData.stereotype == ItemPropertiesInfo.FishingPole then
		DynamicImageSetTexture(mainWindow .. "Stereotype", "STEREOTYPE_FishingPole", 0, 0)
	end
	
	if not ItemProperties.CurrentBaseData.ExpandedProps[1080418] then -- (imbued)
		WindowSetShowing(mainWindow .. "Imbued", false)
	end
	
	-- reforged items star are in the color of the item type
	if ItemProperties.CurrentBaseData.ExpandedProps[1152281] then -- Reforged (Minor)
		DynamicImageSetTexture(mainWindow .. "Stars", "PROPS_1Star", 0, 0)
		WindowSetTintColor(mainWindow .. "Stars", itemColor.r, itemColor.g, itemColor.b)
	elseif ItemProperties.CurrentBaseData.ExpandedProps[1152282] then -- Reforged (Lesser)
		DynamicImageSetTexture(mainWindow .. "Stars", "PROPS_2Star", 0, 0)
		WindowSetTintColor(mainWindow .. "Stars", itemColor.r, itemColor.g, itemColor.b)
	elseif ItemProperties.CurrentBaseData.ExpandedProps[1152283] then -- Reforged (Greater)
		DynamicImageSetTexture(mainWindow .. "Stars", "PROPS_3Star", 0, 0)
		WindowSetTintColor(mainWindow .. "Stars", itemColor.r, itemColor.g, itemColor.b)
	elseif ItemProperties.CurrentBaseData.ExpandedProps[1152284] then -- Reforged (Major)
		DynamicImageSetTexture(mainWindow .. "Stars", "PROPS_4Star", 0, 0)
		WindowSetTintColor(mainWindow .. "Stars", itemColor.r, itemColor.g, itemColor.b)
	elseif ItemProperties.CurrentBaseData.ExpandedProps[1152285] then -- Reforged (Legendary)
		DynamicImageSetTexture(mainWindow .. "Stars", "PROPS_5Star", 0, 0)
		WindowSetTintColor(mainWindow .. "Stars", itemColor.r, itemColor.g, itemColor.b)
	end
		
	-- magic items stars are in the color of the magic property and can have 4 stars at best
	if ItemProperties.CurrentBaseData.ExpandedProps[1151488] then -- Minor Magic Item
		DynamicImageSetTexture(mainWindow .. "Stars", "PROPS_1Star", 0, 0)
		WindowSetTintColor(mainWindow .. "Stars", 0, 153, 255)
	elseif ItemProperties.CurrentBaseData.ExpandedProps[1151489] then -- Lesser Magic Item
		DynamicImageSetTexture(mainWindow .. "Stars", "PROPS_2Star", 0, 0)
		WindowSetTintColor(mainWindow .. "Stars", 0, 153, 255)
	elseif ItemProperties.CurrentBaseData.ExpandedProps[1151490] then -- Greater Magic Item
		DynamicImageSetTexture(mainWindow .. "Stars", "PROPS_3Star", 0, 0)
		WindowSetTintColor(mainWindow .. "Stars", 0, 153, 255)
	elseif ItemProperties.CurrentBaseData.ExpandedProps[1151491] then -- Major Magic Item
		DynamicImageSetTexture(mainWindow .. "Stars", "PROPS_4Star", 0, 0)
		WindowSetTintColor(mainWindow .. "Stars", 0, 153, 255)
	end	
	
	-- artifacts uses the engrave color and starts from 2 stars
	if ItemProperties.CurrentBaseData.ExpandedProps[1151492] then -- Lesser Artifact
		DynamicImageSetTexture(mainWindow .. "Stars", "PROPS_2Star", 0, 0)
		WindowSetTintColor(mainWindow .. "Stars", Interface.Settings.Props_ENGRAVE_COLOR.r, Interface.Settings.Props_ENGRAVE_COLOR.g, Interface.Settings.Props_ENGRAVE_COLOR.b)
	elseif ItemProperties.CurrentBaseData.ExpandedProps[1151493] then -- Greater Artifact
		DynamicImageSetTexture(mainWindow .. "Stars", "PROPS_3Star", 0, 0)
		WindowSetTintColor(mainWindow .. "Stars", Interface.Settings.Props_ENGRAVE_COLOR.r, Interface.Settings.Props_ENGRAVE_COLOR.g, Interface.Settings.Props_ENGRAVE_COLOR.b)
	elseif ItemProperties.CurrentBaseData.ExpandedProps[1151494] then -- Major Artifact
		DynamicImageSetTexture(mainWindow .. "Stars", "PROPS_4Star", 0, 0)
		WindowSetTintColor(mainWindow .. "Stars", Interface.Settings.Props_ENGRAVE_COLOR.r, Interface.Settings.Props_ENGRAVE_COLOR.g, Interface.Settings.Props_ENGRAVE_COLOR.b)
	elseif ItemProperties.CurrentBaseData.ExpandedProps[1151495] then -- Legendary Artifact
		DynamicImageSetTexture(mainWindow .. "Stars", "PROPS_5Star", 0, 0)
		WindowSetTintColor(mainWindow .. "Stars", Interface.Settings.Props_ENGRAVE_COLOR.r, Interface.Settings.Props_ENGRAVE_COLOR.g, Interface.Settings.Props_ENGRAVE_COLOR.b)
	end
	
	if not ItemProperties.CurrentBaseData.ExpandedProps[1116209] then -- Brittle
		WindowSetShowing(mainWindow .. "Brittle", false)
	elseif not ItemProperties.CurrentBaseData.ExpandedProps[1080418] then -- (imbued)
		WindowClearAnchors(mainWindow .. "Brittle")
		WindowAddAnchor(mainWindow .. "Brittle", "bottom", mainWindow .. "Stereotype", "top", 0, 0)
	end
	
	if ItemProperties.CurrentBaseData.ExpandedProps[1116209] and ItemProperties.CurrentBaseData.ExpandedProps[1080418] then -- Brittle and Imbued
		WindowClearAnchors(mainWindow .. "Line1")
		WindowAddAnchor(mainWindow .. "Line1", "bottomleft", mainWindow .. "CraftedBy", "topleft", -78, 20)
	else
		WindowClearAnchors(mainWindow .. "Line1")
		WindowAddAnchor(mainWindow .. "Line1", "bottomleft", mainWindow .. "CraftedBy", "topleft", -78, 10)
	end
	
	local itemName = Shopkeeper.stripFirstNumber(WindowUtils.translateMarkup(textProperties[1]))
	if ItemProperties.CurrentBaseData.ExpandedProps[1050039] or (ItemProperties.CurrentBaseData.quantity and ItemProperties.CurrentBaseData.quantity > 1) then -- ~1_NUMBER~ ~2_ITEMNAME~
		local amount = StringUtils.AddCommasToNumber(ItemProperties.CurrentBaseData.quantity)
		itemName = ReplaceTokens(GetStringFromTid(1050039), {amount, itemName} )
	end
	LabelSetText(mainWindow .. "ItemName", itemName ) -- .. L"\n" .. itemName
		
	-- We have to re-set the height of the lines otherwise they will just show with a wrong dimension.
	WindowSetDimensions(mainWindow .. "Line1", 445, 3)
	WindowSetDimensions(mainWindow .. "Line1", 445, 2)
	
	WindowSetDimensions(mainWindow .. "Line4", 445, 3)
	WindowSetDimensions(mainWindow .. "Line4", 445, 2)
	
	-- 
	
	WindowSetAlpha(mainWindow .. "Line1", 0.6)
	WindowSetAlpha(mainWindow .. "Line4", 0.6)
	
	LabelSetTextColor(mainWindow .. "ItemName", itemColor.r, itemColor.g, itemColor.b)
	WindowSetTintColor(mainWindow .. "Frame", itemColor.r, itemColor.g, itemColor.b)
	WindowSetTintColor(mainWindow .. "Line1", itemColor.r, itemColor.g, itemColor.b)
	WindowSetTintColor(mainWindow .. "Line4", itemColor.r, itemColor.g, itemColor.b)
	
	local th = GetStringFromTid(47)
	if ItemProperties.CurrentBaseData.TwoHanded then
		th = GetStringFromTid(48)
	end
	
	LabelSetText(mainWindow .. "Hands", th )
	
	if ItemProperties.CurrentBaseData.Engrave then
		LabelSetTextColor(mainWindow .. "Engrave", Interface.Settings.Props_ENGRAVE_COLOR.r, Interface.Settings.Props_ENGRAVE_COLOR.g, Interface.Settings.Props_ENGRAVE_COLOR.b)
		LabelSetText(mainWindow .. "Engrave", ItemProperties.CurrentBaseData.Engrave )
	
	else
		local w, _ = WindowGetDimensions(mainWindow .. "Engrave")
		WindowSetDimensions(mainWindow .. "Engrave", w, 0) 
	end
	
	LabelSetText(mainWindow .. "ItemType", L"(" .. FormatProperly(GetStringFromTid(ItemProperties.CurrentBaseData.TypeName )) .. L" - ID: " .. ItemProperties.CurrentBaseData.objType .. L")" )
	
	if ItemProperties.CurrentBaseData.Material and ItemProperties.CurrentBaseData.Material ~= 0 then
		LabelSetText(mainWindow .. "MaterialType", FormatProperly(GetStringFromTid(ItemProperties.CurrentBaseData.Material)) )
	elseif ItemProperties.CurrentBaseData.materialKind == ItemPropertiesInfo.MATERIAL_CLOTH then
		LabelSetText(mainWindow .. "MaterialType", FormatProperly(GetStringFromTid(1025989)) ) -- cloth
	elseif ItemProperties.CurrentBaseData.materialKind == ItemPropertiesInfo.MATERIAL_PAPER then
		LabelSetText(mainWindow .. "MaterialType", FormatProperly(GetStringFromTid(54)) ) -- paper
	end
	
	if ItemProperties.CurrentBaseData.ExpandedProps[1050043] then -- crafted by ~1_NAME~
		local craftedBy = FormatProperly(ReplaceTokens(GetStringFromTid(1050043), ItemProperties.CurrentBaseData.ExpandedProps[1050043]))
		
		if ItemProperties.CurrentBaseData.ExpandedProps[1060636] then  -- exceptional
			craftedBy = FormatProperly(ReplaceTokens(GetStringFromTid(42), ItemProperties.CurrentBaseData.ExpandedProps[1050043]))
		end
		
		LabelSetText(mainWindow .. "CraftedBy", craftedBy )
		
	elseif ItemProperties.CurrentBaseData.ExpandedProps[1060636] then  -- exceptional
		LabelSetText(mainWindow .. "CraftedBy", FormatProperly(GetStringFromTid(1060636)) )
	end
	
	WindowSetShowing(mainWindow .. "SpellChannelingDeny", not ItemProperties.CurrentBaseData.ExpandedProps[1060482] and not ItemProperties.CurrentBaseData.medable) -- spell channeling
	
	if ItemProperties.CurrentBaseData.ExpandedProps[1049643] then -- cursed
		DynamicImageSetTexture(mainWindow .. "Status", "PROPS_Cursed", 0, 0)
	end
	if ItemProperties.CurrentBaseData.ExpandedProps[1038021] then -- Blessed
		DynamicImageSetTexture(mainWindow .. "Status", "PROPS_Blessed", 0, 0)
	end
	
	-- the blessed mark is visible only if the blessed for matches the player name
	
	if ItemProperties.CurrentBaseData.ExpandedProps[1062203] then -- Blessed for ~1_NAME~
		local params = ItemProperties.GetObjectPropertiesParamsForTid(GetPlayerID(),1050045)
		local name 
		if params then
			name = params[2]
		end
		
		local pname = ItemProperties.CurrentBaseData.ExpandedProps[1062203][1]
		if pname == name then
			DynamicImageSetTexture(mainWindow .. "Status", "PROPS_Blessed", 0, 0)
			redOwned = true
		else
			DynamicImageSetTexture(mainWindow .. "Status", "PROPS_BadBlessed", 0, 0) -- wrong owner
			redOwned = true
		end
	elseif ItemProperties.CurrentBaseData.ExpandedProps[1072304] then --  : Owned by ~1_name~
		local params = ItemProperties.GetObjectPropertiesParamsForTid(GetPlayerID(),1050045)
		local name 
		if params then
			name = params[2]
		end
		local pname = ItemProperties.CurrentBaseData.ExpandedProps[1072304][1]
		if pname == name then
			DynamicImageSetTexture(mainWindow .. "Status", "PROPS_Blessed", 0, 0)
		else
			DynamicImageSetTexture(mainWindow .. "Status", "PROPS_BadBlessed", 0, 0) -- wrong owner
			redOwned = true
		end
	end
	
	if ItemProperties.CurrentBaseData.ExpandedProps[1061682] then --  <b>Insured</b>
		DynamicImageSetTexture(mainWindow .. "Status", "PROPS_Insured", 0, 0)
	end
	
	-- getting the height
	local baseH = 0
	
	-- in order to determine the correct size of the labels, we have to add a margin that vary based on the font size
	
	local x, y = WindowGetDimensions(mainWindow .. "ItemName")
	local point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (mainWindow .. "ItemName", 1)
	baseH = baseH + y + yOffs + 10 
	
	x, y = WindowGetDimensions(mainWindow .. "Engrave")
	point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (mainWindow .. "Engrave", 1)
	baseH = baseH + y + yOffs
	
	x, y = WindowGetDimensions(mainWindow .. "SpellChanneling")
	point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (mainWindow .. "ItemType", 1)
	baseH = baseH + y + yOffs
	
	x, y = WindowGetDimensions(mainWindow .. "CraftedBy")
	point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (mainWindow .. "CraftedBy", 1)
	baseH = baseH + y + yOffs 
	
	x, y = WindowGetDimensions(mainWindow .. "Line1")
	point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (mainWindow .. "Line1", 1)
	baseH = baseH + y + yOffs
	
	-- adding all the remaining properties
	local sortedProps = {}
	local propCount = 0
	local lootCap = ItemPropertiesInfo.GetDiffCap(ItemProperties.CurrentBaseData.ExpandedProps)
	for tid, params in pairs(ItemProperties.CurrentBaseData.ExpandedProps) do
		local prop = ItemProperties.CurrentBaseData.ExpandedProps[tid]
		if type(prop) == "string" then
			prop = {}
		end
		prop.tid = tid
		if lootCap then
			if ItemProperties.CurrentBaseData.GumpType == ItemPropertiesInfo.Types.Ranged_Weapon and ItemPropertiesInfo.LootCaps[tid] then
				prop.trueCap = ItemPropertiesInfo.LootCaps[tid].rangedCap
				
			elseif ItemProperties.CurrentBaseData.GumpType == ItemPropertiesInfo.Types.Jewel and ItemPropertiesInfo.LootCaps[tid] then
				prop.trueCap = ItemPropertiesInfo.LootCaps[tid].jewelryCap
				
			elseif ItemProperties.CurrentBaseData.GumpType == ItemPropertiesInfo.Types.Weapon and ItemPropertiesInfo.LootCaps[tid] then
				prop.trueCap = ItemPropertiesInfo.LootCaps[tid].weaponCap
				
			elseif ItemProperties.CurrentBaseData.GumpType == ItemPropertiesInfo.Types.Shield and ItemPropertiesInfo.LootCaps[tid] then
				prop.trueCap = ItemPropertiesInfo.LootCaps[tid].shieldCap
			
			elseif ItemProperties.CurrentBaseData.GumpType == ItemPropertiesInfo.Types.Wearable and ItemPropertiesInfo.LootCaps[tid] then
				prop.trueCap = ItemPropertiesInfo.LootCaps[tid].armorCap
			end
		end
		if ItemPropertiesInfo.Materials[tid] then
			continue
		end
		if not prop or tid == 0 or ItemPropertiesInfo.NotListed[prop.tid] or ItemPropertiesInfo.WeightONLYTid[prop.tid] or (ItemPropertiesInfo.ChargesTid[prop.tid] and not ItemPropertiesInfo.SpellChargesTid[prop.tid]) or not prop.index or prop.index <= 1 or ItemPropertiesInfo.UselessRefinementData[prop.tid] then
			continue
		end
		sortedProps[prop.index] = prop
		propCount = propCount + 1
	end
	
	local propsH = 0
	
	if propCount > 0  then
		local topAnchor = mainWindow .. "Line1"
		local topmargin = 5
		propsH = topmargin
		local prevLabel
		local currLabel
		local idx = 1
		for i, _ in pairsByKeys(sortedProps) do
			local prop = sortedProps[i]
			currLabel = "prop" .. idx
			prevLabel = "prop" .. idx - 1
			
			if prop.tid == 1060438 then -- mage weapon
				prop.value = prop.value * -1
			end
						
			CreateWindowFromTemplate(currLabel, "NewItemPropItemDef", mainWindow)
			
			if prop.tid == 1043304 then -- Price: ~1_COST~
				LabelSetTextColor(currLabel .. "Text", Interface.Settings.Props_ENGRAVE_COLOR.r, Interface.Settings.Props_ENGRAVE_COLOR.g, Interface.Settings.Props_ENGRAVE_COLOR.b)
			elseif prop.tid == 1043306 then -- Price: FREE!
				LabelSetTextColor(currLabel .. "Text", 0, 255, 0)
			elseif prop.tid == 1043307 then -- Price: Not for sale.
				LabelSetTextColor(currLabel .. "Text", 255, 0, 0)
			elseif (prop.value and prop.value < 0) or (prop[1] and tonumber(prop[1]) and tonumber(prop[1]) < 0) or prop.tid == 1049643 or prop.tid == 1116209 or prop.tid == 1152714 or prop.tid == 1154910 or prop.tid == 1154910  or prop.tid == 1154909  or prop.tid == 1155420 then -- cursed, brittle, antique, prized, unwieldly, massive or negative value
				LabelSetTextColor(currLabel .. "Text", 255, 0, 0)
			elseif ItemPropertiesInfo.SetProperties[prop.tid] then
				LabelSetTextColor(currLabel .. "Text", Interface.Settings.Props_SET_COLOR.r, Interface.Settings.Props_SET_COLOR.g, Interface.Settings.Props_SET_COLOR.b)
			elseif prop.intensity and tonumber(prop.intensity) and Interface.Settings.IntensInfo then
				LabelSetTextColor(currLabel .. "Text", ItemProperties.GetIntensityColor(prop.intensity))
			elseif ItemPropertiesInfo.ExpansionProperties[prop.tid] and not Interface.ActiveAccountFeatures[ItemPropertiesInfo.ExpansionProperties[prop.tid]] then
				LabelSetTextColor(currLabel .. "Text", 255, 0, 0)
			else
				LabelSetTextColor(currLabel .. "Text", Interface.Settings.Props_MAGICPROP_COLOR.r, Interface.Settings.Props_MAGICPROP_COLOR.g, Interface.Settings.Props_MAGICPROP_COLOR.b)
			end
			if idx == 1 then
				WindowAddAnchor(currLabel, "bottomleft", topAnchor, "topleft", 10, topmargin)
			else
				WindowAddAnchor(currLabel, "bottomleft", prevLabel, "topleft", 0, 10)
			end
			
			if prop.tid == 1072378 then -- Only when full set is present:
				prop.raw = wstring.gsub(prop.raw, L"\n", L"")
			end
			
			if ItemPropertiesInfo.DecoProperties[prop.tid] or (prop and prop.desc) then
				local _, h = WindowGetDimensions(currLabel .. "Text")
				WindowSetDimensions(currLabel .. "Text", 409, h)
			end
			
			--if idx == 1 then
			--	LabelSetText(currLabel .. "Text",  FormatProperly(L"Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis,") ) 
			--else
				LabelSetText(currLabel .. "Text",  FormatProperly(prop.raw) ) 
			--end
			
			local _, h = WindowGetDimensions(currLabel .. "Text")
			local w, _ = WindowGetDimensions(currLabel)
			WindowSetDimensions(currLabel, w, h)
			
			if Interface.Settings.ShowCaps then
				if prop.trueCap then
					LabelSetText(currLabel .. "Cap", ReplaceTokens(GetStringFromTid(49), {wstring.format(L"%.0f", prop.trueCap)}) )
				elseif prop.cap then
					LabelSetText(currLabel .. "Cap", ReplaceTokens(GetStringFromTid(49), {wstring.format(L"%.0f", prop.cap)}) )
				end
			end
			
			DynamicImageSetTexture(currLabel .. "Dot", "PROPS_Description", 0, 0) -- default image
			
			if ItemProperties.CurrentBaseData.EquippedData and not ItemPropertiesInfo.DecoProperties[prop.tid] and not (prop and prop.desc) then
				local eqProp = ItemProperties.CurrentBaseData.EquippedData.props[prop.tid]
				if prop.cap then
					if eqProp and eqProp[1] and prop.value then
						local currentValue = tonumber(eqProp[1])
						local diff = prop.value - tonumber(eqProp[1])
						
						local currentPlayerValue = WindowData.PlayerStatus[prop.sheetName]
						local totalCap = WindowData.PlayerStatus["Max"..prop.sheetName]
						
						if not totalCap then
							totalCap = CharacterSheet.CapsBonus[prop.sheetName]
						end
						
						-- we have to check if the new value will goes over the cap, and if it does, we just count what will effectively be "used"
						if totalCap then 
							currentPlayerValue = currentPlayerValue - currentValue
							currentPlayerValue = currentPlayerValue + prop.value
							if currentPlayerValue > totalCap then
								local exceed = currentPlayerValue - totalCap
								if exceed < 0 then -- we remove the exceeding part
									diff = diff + exceed
								end
							end
						end
						
						if diff > 0 then
							LabelSetTextColor(currLabel .. "Change", 0, 255, 0)
							DynamicImageSetTexture(currLabel .. "Dot", "PROPS_Gain", 0, 0)
							LabelSetText(currLabel .. "Change", L"(+" .. wstring.format(L"%.0f", diff) .. L")" )
						elseif diff < 0 then
							LabelSetTextColor(currLabel .. "Change", 255, 0, 0)
							DynamicImageSetTexture(currLabel .. "Dot", "PROPS_Lose", 0, 0)
							LabelSetText(currLabel .. "Change", L"(" .. wstring.format(L"%.0f", diff) .. L")" )
						else
							DynamicImageSetTexture(currLabel .. "Dot", "PROPS_Equal", 0, 0)
						end
						
					elseif not ItemPropertiesInfo.DecoProperties[prop.tid] and not (prop and prop.desc) then
						
						local diff = prop.value
						
						local currentPlayerValue = WindowData.PlayerStatus[prop.sheetName]
						local totalCap = WindowData.PlayerStatus["Max"..prop.sheetName]
						
						if not totalCap then
							totalCap = CharacterSheet.CapsBonus[prop.sheetName]
						end
						
						-- we have to check if the new value will goes over the cap, and if it does, we just count what will effectively be "used"
						if totalCap then 
							currentPlayerValue = currentPlayerValue + prop.value
							if currentPlayerValue > totalCap then
								local exceed = currentPlayerValue - totalCap
								if exceed < 0 then -- we remove the exceeding part
									diff = diff + exceed
								end
							end
						end
						
						if diff > 0 then
							DynamicImageSetTexture(currLabel .. "Dot", "PROPS_Gain", 0, 0)
							LabelSetTextColor(currLabel .. "Change", 0, 255, 0)
							LabelSetText(currLabel .. "Change", L"(+" .. wstring.format(L"%.0f", diff) .. L")" )
						elseif diff < 0 then
							DynamicImageSetTexture(currLabel .. "Dot", "PROPS_Lose", 0, 0)
							LabelSetTextColor(currLabel .. "Change", 255, 0, 0)
							LabelSetText(currLabel .. "Change", L"(" .. wstring.format(L"%.0f", diff) .. L")" )
						else
							DynamicImageSetTexture(currLabel .. "Dot", "PROPS_Equal", 0, 0)
						end
						
						
					else
						DynamicImageSetTexture(currLabel .. "Dot", "PROPS_Description", 0, 0)
					end
				else
					if eqProp then
						DynamicImageSetTexture(currLabel .. "Dot", "PROPS_Equal", 0, 0)	
					elseif not ItemPropertiesInfo.DecoProperties[prop.tid] and not (prop and prop.desc) then
						DynamicImageSetTexture(currLabel .. "Dot", "PROPS_Gain", 0, 0)	
					else
						DynamicImageSetTexture(currLabel .. "Dot", "PROPS_Description", 0, 0)
					end
				end
			end
			
			x, y = WindowGetDimensions(currLabel)
			point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (currLabel, 1)
			propsH = propsH + y + yOffs
			idx = idx + 1

		end

		WindowClearAnchors(mainWindow .. "Line4")
		WindowAddAnchor(mainWindow .. "Line4", "bottomleft", currLabel, "topleft", -10, 10)
		
		x, y = WindowGetDimensions(mainWindow .. "Line4")
		point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (mainWindow .. "Line4", 1)
		propsH = propsH + y + yOffs
	
	else
		WindowSetShowing(mainWindow .. "Line4", false)
		propsH = 5
	end
	
	-- item weight
	
	local bottomReq = 0
	
	local bottomH = 0
	
	for tid, param in pairs(ItemPropertiesInfo.WeightONLYTid) do
		if ItemProperties.CurrentBaseData.ExpandedProps[tid] then
			local prop = ItemProperties.CurrentBaseData.ExpandedProps[tid]
			prop.value = tostring(prop[1])
			prop.value = tonumber(prop.value)
			
			if not ItemProperties.CurrentBaseData.equipped and not DoesPlayerHaveItem(ItemProperties.CurrentBaseData.objectId) then -- weight warning
				local w = WindowData.PlayerStatus.Weight + prop.value
				local mw = WindowData.PlayerStatus.MaxWeight - 10	
				if (w >= mw) then
					LabelSetTextColor(mainWindow .. "WeightValue", 255, 0, 0)
					DynamicImageSetTexture(mainWindow .. "Weight", "PROPS_WeightWarning", 0, 0)
				end
			end
			WindowSetShowing(mainWindow .. "Weight", true)
			
			DynamicImageSetTexture(mainWindow .. "Weight", "PROPS_Weight", 0, 0)
			
			LabelSetText(mainWindow .. "WeightValue", Knumber(prop.value) )
			
			x, y = WindowGetDimensions(mainWindow .. "Weight")
			point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (mainWindow .. "WeightValue", 1)
			bottomH = bottomH + y + yOffs
			bottomReq = bottomReq + 1
			break
		end	
	end
	
	WindowClearAnchors(mainWindow .. "WeightValue")
	WindowAddAnchor(mainWindow .. "WeightValue", "bottomright", mainWindow .. "Line4", "topright", -20, 25)
	
	WindowClearAnchors(mainWindow .. "Weight")
	WindowAddAnchor(mainWindow .. "Weight", "left", mainWindow .. "WeightValue", "right", -10, 0)
	
	-- item str requirement
	
	if ItemProperties.CurrentBaseData.ExpandedProps[1061170] then
		local str = tostring(ItemProperties.CurrentBaseData.ExpandedProps[1061170][1])
		str = tonumber(str)
		WindowSetShowing(mainWindow .. "Str", true)
		local baseStr = tonumber(WindowData.PlayerStatus["Strength"]) - tonumber(WindowData.PlayerStatus["IncreaseStr"])
		if baseStr < str then
			LabelSetTextColor(mainWindow .. "StrValue", 255, 125, 64)
			DynamicImageSetTexture(mainWindow .. "Str", "PROPS_StrWarningBase", 0, 0)
		elseif tonumber(WindowData.PlayerStatus["Strength"]) >= str then
			DynamicImageSetTexture(mainWindow .. "Str", "PROPS_Str", 0, 0)
		else
			LabelSetTextColor(mainWindow .. "StrValue", 255, 0, 0)
			DynamicImageSetTexture(mainWindow .. "Str", "PROPS_StrWarning", 0, 0)
		end
		LabelSetText(mainWindow .. "StrValue", towstring(str) )
		bottomReq = bottomReq + 1
	end
	
	WindowClearAnchors(mainWindow .. "StrValue")
	WindowAddAnchor(mainWindow .. "StrValue", "left", mainWindow .. "Weight", "left", -40, 0)
	
	WindowClearAnchors(mainWindow .. "Str")
	WindowAddAnchor(mainWindow .. "Str", "left", mainWindow .. "StrValue", "right", -10, 0)

	if ItemProperties.CurrentBaseData.uses then
		WindowSetShowing(mainWindow .. "Charges", true)
		LabelSetText(mainWindow .. "ChargesValue", Knumber(ItemProperties.CurrentBaseData.uses) )
		
		if bottomReq == 0 then
			WindowClearAnchors(mainWindow .. "Charges")
			WindowAddAnchor(mainWindow .. "Charges", "bottomright", mainWindow .. "Line4", "toright", -100, 15)
			
			WindowClearAnchors(mainWindow .. "ChargesValue")
			WindowAddAnchor(mainWindow .. "ChargesValue", "right", mainWindow .. "Charges", "left", 5, 0)
		else
			WindowClearAnchors(mainWindow .. "Charges")
			WindowAddAnchor(mainWindow .. "Charges", "bottomleft", mainWindow .. "Weight", "topleft", 0, 15)
			
			WindowClearAnchors(mainWindow .. "ChargesValue")
			WindowAddAnchor(mainWindow .. "ChargesValue", "right", mainWindow .. "Charges", "left", 5, 0)
		end
		
		x, y = WindowGetDimensions(mainWindow .. "Charges")
		point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (mainWindow .. "Charges", 1)
		bottomH = bottomH + y + yOffs
		bottomReq = bottomReq + 1
			
	else
		WindowSetShowing(mainWindow .. "Charges", false)
		WindowSetShowing(mainWindow .. "ChargesValue", false)
	end
	
	if ItemProperties.CurrentBaseData.hue and ItemProperties.CurrentBaseData.hue ~= 0 then
		EquipmentData.DrawObjectIcon(4011, ItemProperties.CurrentBaseData.hue, mainWindow .. "Hue", 0, 0, 1) -- dye tub image
		
		WindowClearAnchors(mainWindow .. "Hue")
		WindowAddAnchor(mainWindow .. "Hue", "bottomleft", mainWindow .. "Line4", "topleft", 15, 15)
		
		local hueName = HuesInfo.Data[ItemProperties.CurrentBaseData.hue]
		WindowClearAnchors(mainWindow .. "HueValue")
		if hueName then
			WindowAddAnchor(mainWindow .. "HueValue", "right", mainWindow .. "Hue", "left", 10, -10)
			LabelSetText(mainWindow .. "HueValue", ReplaceTokens(GetStringFromTid(52), {towstring(ItemProperties.CurrentBaseData.hue), hueName}) )
		else
			WindowAddAnchor(mainWindow .. "HueValue", "right", mainWindow .. "Hue", "left", 10, 0)
			LabelSetText(mainWindow .. "HueValue", ReplaceTokens(GetStringFromTid(51), {towstring(ItemProperties.CurrentBaseData.hue)}) )
		end
		if bottomReq == 0 then
			x, y = WindowGetDimensions(mainWindow .. "Hue")
			point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (mainWindow .. "Hue", 1)
			bottomH = bottomH + y + yOffs
			bottomReq = bottomReq + 1
			WindowClearAnchors(mainWindow .. "DurBar")
			WindowAddAnchor(mainWindow .. "DurBar", "bottomright", mainWindow .. "Str", "topright", 80, 20)
		elseif ItemProperties.CurrentBaseData.uses and ItemProperties.CurrentBaseData.Durability then
			WindowClearAnchors(mainWindow .. "DurBar")
			WindowAddAnchor(mainWindow .. "DurBar", "bottomright", mainWindow .. "Charges", "topright", 0, 20)
		end
	
	elseif not ItemProperties.CurrentBaseData.uses and bottomReq > 0 and ItemProperties.CurrentBaseData.Durability then
		WindowClearAnchors(mainWindow .. "DurBar")
		WindowAddAnchor(mainWindow .. "DurBar", "bottomright", mainWindow .. "Str", "topright", 80, 20)
	elseif not ItemProperties.CurrentBaseData.uses and bottomReq == 0 and ItemProperties.CurrentBaseData.Durability then
		WindowClearAnchors(mainWindow .. "DurBar")
		WindowAddAnchor(mainWindow .. "DurBar", "bottomleft", mainWindow .. "Line4", "topleft", 50, 10)
	end

	if ItemProperties.CurrentBaseData.Durability and ItemProperties.CurrentBaseData.Durability.max > 0 then
		
		local perc = (ItemProperties.CurrentBaseData.Durability.min / ItemProperties.CurrentBaseData.Durability.max ) * 100
		if type(perc) ~= "number" or perc < 0 or perc > 100 then
			perc = 0
		end
		local gb = math.floor(2.55 * perc)
		LabelSetTextColor(mainWindow .. "DurBarValue", 255, gb, gb)
		
		LabelSetText(mainWindow .. "DurBarValue", ItemProperties.CurrentBaseData.Durability.min .. L" / " .. ItemProperties.CurrentBaseData.Durability.max )
		
		local wid = 348 * (perc / 100)

		WindowSetDimensions(mainWindow .. "DurBarFill", wid, 37)
		
		WindowClearAnchors(mainWindow .. "DurBarFill")
		WindowAddAnchor(mainWindow .. "DurBarFill", "topleft", mainWindow .. "DurBar", "topleft", 2, 5)
		
		WindowClearAnchors(mainWindow .. "DurBarValue")
		WindowAddAnchor(mainWindow .. "DurBarValue", "topleft", mainWindow .. "DurBar", "topleft", 10, 7)
		WindowAddAnchor(mainWindow .. "DurBarValue", "bottomright", mainWindow .. "DurBar", "bottomright", 0, -7)
		
		WindowSetShowing(mainWindow .. "DurBar", true)
		WindowSetShowing(mainWindow .. "DurBarFill", true)
		WindowSetShowing(mainWindow .. "DurBarValue", true)
		
		x, y = WindowGetDimensions(mainWindow .. "DurBar")
		point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (mainWindow .. "DurBar", 1)
		bottomH = bottomH + y + yOffs
		bottomReq = bottomReq + 1
	else
		WindowSetShowing(mainWindow .. "DurBar", false)
		WindowSetShowing(mainWindow .. "DurBarFill", false)
		WindowSetShowing(mainWindow .. "DurBarValue", false)
	end
	
	if bottomReq == 0 then
		WindowSetShowing(mainWindow .. "Line4", false)
	end
	
	y = baseH + propsH + bottomH	

	if ItemProperties.CurrentBaseData.Durability and ItemProperties.CurrentBaseData.Durability.max > 0 then
		WindowClearAnchors(mainWindow)
		WindowAddAnchor(mainWindow, "topleft", "ItemProperties", "topleft", 0, 0 )
		if not DoesWindowExist(mainWindow .. "Marker") then
			CreateWindowFromTemplate(mainWindow .. "Marker", "MarkerLine", "ItemProperties")	
		end
		WindowClearAnchors(mainWindow .. "Marker")
		WindowAddAnchor(mainWindow .. "Marker", "bottomright", mainWindow .. "DurBar", "bottomright", 0, 0 )
		
    local mainDimX, mainDimY = WindowGetDimensions(mainWindow)
    local _, _, _, markxOffs, markyOffs = WindowGetAnchor (mainWindow .. "Marker", 1)
   
    WindowSetDimensions(mainWindow, mainDimX, y + markyOffs + 11)
		--WindowAddAnchor(mainWindow, "bottomright", mainWindow .. "Marker", "bottomright", 45, 10 )
	else
		WindowSetDimensions(mainWindow, width, y)
		
	end
	
	WindowSetAlpha(mainWindow .. "HotbarDataWindowBackground", 0.8)
	WindowSetDimensions(mainWindow .. "HotbarData", 350, 70)
	WindowClearAnchors(mainWindow .. "HotbarData")
	WindowAddAnchor(mainWindow .. "HotbarData", "bottomleft", mainWindow, "topleft", 50, 0)
	WindowSetTintColor(mainWindow .. "HotbarDataFrame", itemColor.r, itemColor.g, itemColor.b)
	WindowSetShowing(mainWindow .. "HotbarData", false)
	
	if ((ItemProperties.CurrentItemData.binding ~= nil and wstring.len(ItemProperties.CurrentItemData.binding) > 0) or (ItemProperties.CurrentItemData.myTarget ~= nil and wstring.len(ItemProperties.CurrentItemData.myTarget) > 0)) then
		WindowSetShowing(mainWindow .. "HotbarData", true)
		if (ItemProperties.CurrentItemData.binding ~= nil and wstring.len(ItemProperties.CurrentItemData.binding) > 0) then
			LabelSetText(mainWindow .. "HotbarDataBinding", ItemProperties.CurrentItemData.binding )
		else
			WindowClearAnchors(mainWindow .. "HotbarDataTarget")
			WindowAddAnchor(mainWindow .. "HotbarDataTarget", "topleft", mainWindow .. "HotbarData", "topleft", 10, 10)
			WindowSetDimensions(mainWindow .. "HotbarData", 350, 50)
		end
		if (ItemProperties.CurrentItemData.myTarget ~= nil and wstring.len(ItemProperties.CurrentItemData.myTarget) > 0) then
			LabelSetText(mainWindow .. "HotbarDataTarget", ItemProperties.CurrentItemData.myTarget )
		end
	end

	local scale = Interface.Settings.NewItemPropertiesScale
	WindowSetScale(mainWindow, scale)
	WindowSetScale("ItemProperties", scale)
	
	if GenericGump.CurrentOver == "" or GenericGump.CurrentOver == "VSEARCH" then
		WindowSetDimensions("ItemProperties", width, y)
		
		ItemProperties.FollowMouse()
		WindowSetId("ItemProperties", ItemProperties.CurrentBaseData.objectId)
		
		if not WindowGetShowing("ItemProperties") then
			WindowSetShowing("ItemPropertiesWindowBackground", false)
			WindowSetShowing("ItemPropertiesFrame", false)
			WindowSetShowing("ItemProperties", true)
		end
		
		if GenericGump.CurrentOver == "VSEARCH" then
			WindowSetParent(mainWindow, "Root")
			WindowClearAnchors(mainWindow)
			WindowAddAnchor(mainWindow, "center", ItemProperties.CurrentItemData.windowName, "bottomright", 0, 0)
		end
	else
		WindowSetParent(mainWindow, "Root")
	end
	
end

function ItemProperties.ShowOtherProps()
	local mainWindow = "OtherProperties"

	local width = ItemProperties.WeaponGump_Width
	
	CreateWindowFromTemplate(mainWindow, "OtherPropertiesTemplate", "ItemProperties")
	
	WindowSetDimensions(mainWindow, width, 0)
	WindowSetShowing(mainWindow .. "DurBar", false)
	WindowSetShowing(mainWindow .. "DurBarFill", false)
	WindowSetShowing(mainWindow .. "DurBarValue", false)
	WindowSetShowing(mainWindow .. "Charges", false)
	
	WindowSetShowing(mainWindow .. "Human", false)
	WindowSetShowing(mainWindow .. "Elf", false)
	WindowSetShowing(mainWindow .. "Gargoyle", false)
	WindowSetShowing(mainWindow .. "Weight", false)
	WindowSetShowing(mainWindow .. "Str", false)
	
	WindowSetAlpha(mainWindow .. "WindowBackground", 0.8)
	
	local textProperties = ItemProperties.CurrentBaseData.OriginalProps.PropertiesList
	if not textProperties then
		ItemProperties.loading = nil
		return
	end
	
	local itemColor = Interface.Settings.Props_TITLE_COLOR
	
	if ItemProperties.CurrentBaseData.Set then
		itemColor = Interface.Settings.Props_SET_COLOR
	elseif ItemProperties.CurrentBaseData.Artifact then
		itemColor = Interface.Settings.Props_ARTIFACT_COLOR
	elseif ItemProperties.CurrentBaseData.Worth == ItemPropertiesInfo.UNRAVEL_RelicFragment then
		itemColor = Interface.Settings.Props_RELIC_COLOR
	elseif ItemProperties.CurrentBaseData.Worth == ItemPropertiesInfo.UNRAVEL_EnchantedEssence then
		itemColor = Interface.Settings.Props_ESSENCE_COLOR
	elseif ItemProperties.CurrentBaseData.Worth == ItemPropertiesInfo.UNRAVEL_MagicResidue then
		itemColor = Interface.Settings.Props_RESIDUE_COLOR
	end
	
	local gargoylesOnly = ItemProperties.CurrentBaseData.gargoyle and not ItemProperties.CurrentBaseData.elf and not ItemProperties.CurrentBaseData.human
	
	if ItemProperties.CurrentBaseData.stereotype == ItemPropertiesInfo.Sword then
		DynamicImageSetTexture(mainWindow .. "Stereotype", "STEREOTYPE_Sword", 0, 0)
	elseif ItemProperties.CurrentBaseData.stereotype == ItemPropertiesInfo.Dagger then
		DynamicImageSetTexture(mainWindow .. "Stereotype", "STEREOTYPE_Dagger", 0, 0)	
	elseif ItemProperties.CurrentBaseData.stereotype == ItemPropertiesInfo.Mace then
		DynamicImageSetTexture(mainWindow .. "Stereotype", "STEREOTYPE_Mace", 0, 0)
	elseif ItemProperties.CurrentBaseData.stereotype == ItemPropertiesInfo.Axe then
		DynamicImageSetTexture(mainWindow .. "Stereotype", "STEREOTYPE_Axe", 0, 0)
	elseif ItemProperties.CurrentBaseData.stereotype == ItemPropertiesInfo.Polearm then
		DynamicImageSetTexture(mainWindow .. "Stereotype", "STEREOTYPE_Polearm", 0, 0)
	elseif ItemProperties.CurrentBaseData.stereotype == ItemPropertiesInfo.Bow then
		DynamicImageSetTexture(mainWindow .. "Stereotype", "STEREOTYPE_Bow", 0, 0)
	elseif ItemProperties.CurrentBaseData.stereotype == ItemPropertiesInfo.Boomerang then
		DynamicImageSetTexture(mainWindow .. "Stereotype", "STEREOTYPE_Boomerang", 0, 0)
	elseif ItemProperties.CurrentBaseData.stereotype == ItemPropertiesInfo.Spellbook then
		DynamicImageSetTexture(mainWindow .. "Stereotype", "STEREOTYPE_Spellbook", 0, 0)
	elseif ItemProperties.CurrentBaseData.stereotype == ItemPropertiesInfo.FishingPole then
		DynamicImageSetTexture(mainWindow .. "Stereotype", "STEREOTYPE_FishingPole", 0, 0)
	elseif ItemProperties.CurrentBaseData.stereotype == ItemPropertiesInfo.Helm then
		DynamicImageSetTexture(mainWindow .. "Stereotype", "STEREOTYPE_Helm", 0, 0)
	elseif ItemProperties.CurrentBaseData.stereotype == ItemPropertiesInfo.Hat then
		DynamicImageSetTexture(mainWindow .. "Stereotype", "STEREOTYPE_Hat", 0, 0)
	elseif ItemProperties.CurrentBaseData.stereotype == ItemPropertiesInfo.Necklace then
		DynamicImageSetTexture(mainWindow .. "Stereotype", "STEREOTYPE_Necklace", 0, 0)
	elseif ItemProperties.CurrentBaseData.stereotype == ItemPropertiesInfo.Ring then
		DynamicImageSetTexture(mainWindow .. "Stereotype", "STEREOTYPE_Ring", 0, 0)
	elseif ItemProperties.CurrentBaseData.stereotype == ItemPropertiesInfo.Bracelet then
		DynamicImageSetTexture(mainWindow .. "Stereotype", "STEREOTYPE_Bracelet", 0, 0)
	elseif ItemProperties.CurrentBaseData.stereotype == ItemPropertiesInfo.Earrings then
		DynamicImageSetTexture(mainWindow .. "Stereotype", "STEREOTYPE_Earrings", 0, 0)
	elseif ItemProperties.CurrentBaseData.stereotype == ItemPropertiesInfo.Shield then
		DynamicImageSetTexture(mainWindow .. "Stereotype", "STEREOTYPE_Shield", 0, 0)
	elseif ItemProperties.CurrentBaseData.stereotype == ItemPropertiesInfo.CraftingTool then
		DynamicImageSetTexture(mainWindow .. "Stereotype", "STEREOTYPE_Tool", 0, 0)
	elseif ItemProperties.CurrentBaseData.stereotype == ItemPropertiesInfo.Container then

		if ItemProperties.CurrentBaseData.objType and ItemProperties.CurrentBaseData.objType >= 10000000 then

			-- draw the correct portrait (it takes a short time to get the correct data)
			Interface.AddTodoList({name = "target window draw portrait", func = function() if ItemProperties.CurrentBaseData then ItemProperties.CurrentBaseData.texture = SetPortraitImage(ItemProperties.CurrentBaseData.objectId, mainWindow .. "Stereotype", true, ItemProperties.CurrentBaseData.texture) end end, time = Interface.TimeSinceLogin + 0.2})
		else
			DynamicImageSetTexture(mainWindow .. "Stereotype", "STEREOTYPE_Container", 0, 0)
		end
	elseif ItemProperties.CurrentBaseData.stereotype == ItemPropertiesInfo.CraftingMaterial then
		DynamicImageSetTexture(mainWindow .. "Stereotype", "STEREOTYPE_Materials", 0, 0)
	elseif ItemProperties.CurrentBaseData.stereotype == ItemPropertiesInfo.BossKey then
		DynamicImageSetTexture(mainWindow .. "Stereotype", "STEREOTYPE_BossKey", 0, 0)
	elseif ItemProperties.CurrentBaseData.stereotype == ItemPropertiesInfo.MusicalInstrument then
		DynamicImageSetTexture(mainWindow .. "Stereotype", "STEREOTYPE_MusicalInstrument", 0, 0)
	elseif ItemProperties.CurrentBaseData.stereotype == ItemPropertiesInfo.Coins then
		DynamicImageSetTexture(mainWindow .. "Stereotype", "STEREOTYPE_Coins", 0, 0)
	elseif ItemProperties.CurrentBaseData.stereotype == ItemPropertiesInfo.Reagents then
		DynamicImageSetTexture(mainWindow .. "Stereotype", "STEREOTYPE_Reagent", 0, 0)
	elseif ItemProperties.CurrentBaseData.stereotype == ItemPropertiesInfo.Glasses then
		DynamicImageSetTexture(mainWindow .. "Stereotype", "STEREOTYPE_Glasses", 0, 0)
	elseif ItemProperties.CurrentBaseData.stereotype == ItemPropertiesInfo.Misc then
		DynamicImageSetTexture(mainWindow .. "Stereotype", "STEREOTYPE_Misc", 0, 0)
	elseif ItemProperties.CurrentBaseData.layer then -- use paperdoll slot images
		local image = "STEREOTYPE_slot_" .. ItemProperties.CurrentBaseData.layer
		if (ItemProperties.CurrentBaseData.layer == 11 or ItemProperties.CurrentBaseData.layer == 16 or ItemProperties.CurrentBaseData.layer == 13) and (gargoylesOnly) then
			image = image .. "_garg"
		end
		DynamicImageSetTexture(mainWindow .. "Stereotype", image, 0, 0)
	else
		DynamicImageSetTexture(mainWindow .. "Stereotype", "STEREOTYPE_Misc", 0, 0)
	end
	
	if not ItemProperties.CurrentBaseData.ExpandedProps[1080418] then -- (imbued)
		WindowSetShowing(mainWindow .. "Imbued", false)
	end
	
	-- reforged items star are in the color of the item type
	if ItemProperties.CurrentBaseData.ExpandedProps[1152281] then -- Reforged (Minor)
		DynamicImageSetTexture(mainWindow .. "Stars", "PROPS_1Star", 0, 0)
		WindowSetTintColor(mainWindow .. "Stars", itemColor.r, itemColor.g, itemColor.b)
	elseif ItemProperties.CurrentBaseData.ExpandedProps[1152282] then -- Reforged (Lesser)
		DynamicImageSetTexture(mainWindow .. "Stars", "PROPS_2Star", 0, 0)
		WindowSetTintColor(mainWindow .. "Stars", itemColor.r, itemColor.g, itemColor.b)
	elseif ItemProperties.CurrentBaseData.ExpandedProps[1152283] then -- Reforged (Greater)
		DynamicImageSetTexture(mainWindow .. "Stars", "PROPS_3Star", 0, 0)
		WindowSetTintColor(mainWindow .. "Stars", itemColor.r, itemColor.g, itemColor.b)
	elseif ItemProperties.CurrentBaseData.ExpandedProps[1152284] then -- Reforged (Major)
		DynamicImageSetTexture(mainWindow .. "Stars", "PROPS_4Star", 0, 0)
		WindowSetTintColor(mainWindow .. "Stars", itemColor.r, itemColor.g, itemColor.b)
	elseif ItemProperties.CurrentBaseData.ExpandedProps[1152285] then -- Reforged (Legendary)
		DynamicImageSetTexture(mainWindow .. "Stars", "PROPS_5Star", 0, 0)
		WindowSetTintColor(mainWindow .. "Stars", itemColor.r, itemColor.g, itemColor.b)
	end
		
	-- magic items stars are in the color of the magic property and can have 4 stars at best
	if ItemProperties.CurrentBaseData.ExpandedProps[1151488] then -- Minor Magic Item
		DynamicImageSetTexture(mainWindow .. "Stars", "PROPS_1Star", 0, 0)
		WindowSetTintColor(mainWindow .. "Stars", 0, 153, 255)
	elseif ItemProperties.CurrentBaseData.ExpandedProps[1151489] then -- Lesser Magic Item
		DynamicImageSetTexture(mainWindow .. "Stars", "PROPS_2Star", 0, 0)
		WindowSetTintColor(mainWindow .. "Stars", 0, 153, 255)
	elseif ItemProperties.CurrentBaseData.ExpandedProps[1151490] then -- Greater Magic Item
		DynamicImageSetTexture(mainWindow .. "Stars", "PROPS_3Star", 0, 0)
		WindowSetTintColor(mainWindow .. "Stars", 0, 153, 255)
	elseif ItemProperties.CurrentBaseData.ExpandedProps[1151491] then -- Major Magic Item
		DynamicImageSetTexture(mainWindow .. "Stars", "PROPS_4Star", 0, 0)
		WindowSetTintColor(mainWindow .. "Stars", 0, 153, 255)
	end		
	
	-- artifacts uses the engrave color and starts from 2 stars
	if ItemProperties.CurrentBaseData.ExpandedProps[1151492] then -- Lesser Artifact
		DynamicImageSetTexture(mainWindow .. "Stars", "PROPS_2Star", 0, 0)
		WindowSetTintColor(mainWindow .. "Stars", Interface.Settings.Props_ENGRAVE_COLOR.r, Interface.Settings.Props_ENGRAVE_COLOR.g, Interface.Settings.Props_ENGRAVE_COLOR.b)
	elseif ItemProperties.CurrentBaseData.ExpandedProps[1151493] then -- Greater Artifact
		DynamicImageSetTexture(mainWindow .. "Stars", "PROPS_3Star", 0, 0)
		WindowSetTintColor(mainWindow .. "Stars", Interface.Settings.Props_ENGRAVE_COLOR.r, Interface.Settings.Props_ENGRAVE_COLOR.g, Interface.Settings.Props_ENGRAVE_COLOR.b)
	elseif ItemProperties.CurrentBaseData.ExpandedProps[1151494] then -- Major Artifact
		DynamicImageSetTexture(mainWindow .. "Stars", "PROPS_4Star", 0, 0)
		WindowSetTintColor(mainWindow .. "Stars", Interface.Settings.Props_ENGRAVE_COLOR.r, Interface.Settings.Props_ENGRAVE_COLOR.g, Interface.Settings.Props_ENGRAVE_COLOR.b)
	elseif ItemProperties.CurrentBaseData.ExpandedProps[1151495] then -- Legendary Artifact
		DynamicImageSetTexture(mainWindow .. "Stars", "PROPS_5Star", 0, 0)
		WindowSetTintColor(mainWindow .. "Stars", Interface.Settings.Props_ENGRAVE_COLOR.r, Interface.Settings.Props_ENGRAVE_COLOR.g, Interface.Settings.Props_ENGRAVE_COLOR.b)
	end

	if not ItemProperties.CurrentBaseData.ExpandedProps[1116209] then -- Brittle
		WindowSetShowing(mainWindow .. "Brittle", false)
	elseif not ItemProperties.CurrentBaseData.ExpandedProps[1080418] then -- (imbued)
		WindowClearAnchors(mainWindow .. "Brittle")
		WindowAddAnchor(mainWindow .. "Brittle", "bottom", mainWindow .. "Stereotype", "top", 0, 0)
	end
	
	if ItemProperties.CurrentBaseData.ExpandedProps[1116209] and ItemProperties.CurrentBaseData.ExpandedProps[1080418] then -- Brittle and Imbued
		WindowClearAnchors(mainWindow .. "Line1")
		WindowAddAnchor(mainWindow .. "Line1", "bottomleft", mainWindow .. "CraftedBy", "topleft", -78, 20)
	else
		WindowClearAnchors(mainWindow .. "Line1")
		WindowAddAnchor(mainWindow .. "Line1", "bottomleft", mainWindow .. "CraftedBy", "topleft", -78, 10)
	end
	
	local baseH = 0
	
	local itemName = L"" 
	for i=1150301, 1150310 do -- [ ~1_LINE<N>~ ]
		if ItemProperties.CurrentBaseData.ExpandedProps[i] then
			local text = ItemProperties.CurrentBaseData.ExpandedProps[i][1]
			if itemName ~= L"" then
				itemName = itemName .. L"\n"
			end
			itemName = itemName .. text
		else
			break
		end
	end
	if itemName == L"" then
		itemName = Shopkeeper.stripFirstNumber(WindowUtils.translateMarkup(textProperties[1]))
		if ItemProperties.CurrentBaseData.ExpandedProps[1050039] or (ItemProperties.CurrentBaseData.quantity and ItemProperties.CurrentBaseData.quantity > 1) then -- ~1_NUMBER~ ~2_ITEMNAME~
			local amount = StringUtils.AddCommasToNumber(ItemProperties.CurrentBaseData.quantity)
			itemName = ReplaceTokens(GetStringFromTid(1050039), {amount, itemName} )
		end
	end
	
	LabelSetText(mainWindow .. "ItemName", itemName ) -- .. L"\n" .. itemName
	
	local x, y = LabelGetTextDimensions(mainWindow .. "ItemName")
	local point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (mainWindow .. "ItemName", 1)
	baseH = baseH + y + yOffs
		
	-- We have to re-set the height of the lines otherwise they will just show with a wrong dimension.
	WindowSetDimensions(mainWindow .. "Line1", 445, 3)
	WindowSetDimensions(mainWindow .. "Line1", 445, 2)
	
	WindowSetDimensions(mainWindow .. "Line3", 445, 3)
	WindowSetDimensions(mainWindow .. "Line3", 445, 2)
	
	WindowSetDimensions(mainWindow .. "Line4", 445, 3)
	WindowSetDimensions(mainWindow .. "Line4", 445, 2)
	
	-- 
	
	WindowSetAlpha(mainWindow .. "Line1", 0.6)
	WindowSetAlpha(mainWindow .. "Line3", 0.6)
	WindowSetAlpha(mainWindow .. "Line4", 0.6)
	
	LabelSetTextColor(mainWindow .. "ItemName", itemColor.r, itemColor.g, itemColor.b)
	WindowSetTintColor(mainWindow .. "Frame", itemColor.r, itemColor.g, itemColor.b)
	WindowSetTintColor(mainWindow .. "Line1", itemColor.r, itemColor.g, itemColor.b)
	WindowSetTintColor(mainWindow .. "Line3", itemColor.r, itemColor.g, itemColor.b)
	WindowSetTintColor(mainWindow .. "Line4", itemColor.r, itemColor.g, itemColor.b)
	
	if ItemProperties.CurrentBaseData.Engrave then
		LabelSetTextColor(mainWindow .. "Engrave", Interface.Settings.Props_ENGRAVE_COLOR.r, Interface.Settings.Props_ENGRAVE_COLOR.g, Interface.Settings.Props_ENGRAVE_COLOR.b)
		LabelSetText(mainWindow .. "Engrave", ItemProperties.CurrentBaseData.Engrave )
		
	else
		local w, _ = WindowGetDimensions(mainWindow .. "Engrave")
		WindowSetDimensions(mainWindow .. "Engrave", w, 0) 
	end
	
	x, y = WindowGetDimensions(mainWindow .. "Engrave")
	point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (mainWindow .. "Engrave", 1)
	baseH = baseH + y + yOffs
	
	if ItemProperties.CurrentBaseData.TypeName and not ItemProperties.CurrentBaseData.isJewel then
		LabelSetText(mainWindow .. "ItemType", L"(" .. FormatProperly(GetStringFromTid(ItemProperties.CurrentBaseData.TypeName )) .. L" - ID: " .. ItemProperties.CurrentBaseData.objType .. L")" )
		if ItemProperties.CurrentBaseData.Material and ItemProperties.CurrentBaseData.Material ~= 0 then
			LabelSetText(mainWindow .. "MaterialType", FormatProperly(GetStringFromTid(ItemProperties.CurrentBaseData.Material)) )
		elseif ItemProperties.CurrentBaseData.materialKind == ItemPropertiesInfo.MATERIAL_CLOTH then
			LabelSetText(mainWindow .. "MaterialType", FormatProperly(GetStringFromTid(1025989)) ) -- cloth
		elseif ItemProperties.CurrentBaseData.materialKind == ItemPropertiesInfo.MATERIAL_PAPER then
			LabelSetText(mainWindow .. "MaterialType", FormatProperly(GetStringFromTid(54)) ) -- paper
		end
	elseif ItemProperties.CurrentBaseData.ExpandedProps[1060654] then -- small bulk order
		WindowClearAnchors(mainWindow .. "ItemType")
		WindowAddAnchor(mainWindow .. "ItemType", "topleft", mainWindow .. "Medable", "topleft", 0, 2)
		LabelSetText(mainWindow .. "ItemType", FormatProperly(GetStringFromTid(1060654))  )
		
		for tid,_ in pairs(ItemPropertiesInfo.BodMaterials) do
			if ItemProperties.CurrentBaseData.ExpandedProps[tid] then
				LabelSetText(mainWindow .. "MaterialType", FormatProperly(GetStringFromTid(tid)) )
				break
			end
		end
		
	elseif ItemProperties.CurrentBaseData.ExpandedProps[1060655] then -- large bulk order
		WindowClearAnchors(mainWindow .. "ItemType")
		WindowAddAnchor(mainWindow .. "ItemType", "topleft", mainWindow .. "Medable", "topleft", 0, 2)
		LabelSetText(mainWindow .. "ItemType", FormatProperly(GetStringFromTid(1060655))  )
		
		for tid,_ in pairs(ItemPropertiesInfo.BodMaterials) do
			if ItemProperties.CurrentBaseData.ExpandedProps[tid] then
				LabelSetText(mainWindow .. "MaterialType", FormatProperly(GetStringFromTid(tid)) )
				break
			end
		end
	else
		if ItemProperties.CurrentBaseData.Material and ItemProperties.CurrentBaseData.Material ~= 0 and ItemProperties.CurrentBaseData.objType then
			WindowClearAnchors(mainWindow .. "ItemType")
			WindowAddAnchor(mainWindow .. "ItemType", "topleft", mainWindow .. "Medable", "topleft", 0, -4)
			LabelSetText(mainWindow .. "ItemType", L"ID: " .. ItemProperties.CurrentBaseData.objType )
			LabelSetText(mainWindow .. "MaterialType", FormatProperly(GetStringFromTid(ItemProperties.CurrentBaseData.Material)) )
		elseif ItemProperties.CurrentBaseData.objType then
			WindowClearAnchors(mainWindow .. "ItemType")
			WindowAddAnchor(mainWindow .. "ItemType", "topleft", mainWindow .. "Medable", "topleft", 0, 2)
			
			if ItemProperties.CurrentBaseData.objType and ItemProperties.CurrentBaseData.objType >= 10000000 then
				
				LabelSetText(mainWindow .. "ItemType", L"Body ID: " .. (ItemProperties.CurrentBaseData.objType - 10000000) )
			
			elseif ItemProperties.CurrentBaseData.objType then
				LabelSetText(mainWindow .. "ItemType", L"ID: " .. ItemProperties.CurrentBaseData.objType )
			end
		end
	end
	
	if ItemProperties.CurrentBaseData.ExpandedProps[1050043] then -- crafted by ~1_NAME~
		local craftedBy = FormatProperly(ReplaceTokens(GetStringFromTid(1050043), ItemProperties.CurrentBaseData.ExpandedProps[1050043]))
		
		if ItemProperties.CurrentBaseData.ExpandedProps[1060636] then  -- exceptional
			craftedBy = FormatProperly(ReplaceTokens(GetStringFromTid(42), ItemProperties.CurrentBaseData.ExpandedProps[1050043]))
		end
		
		LabelSetText(mainWindow .. "CraftedBy", craftedBy )
		
	elseif ItemProperties.CurrentBaseData.ExpandedProps[1060636] then  -- exceptional
		LabelSetText(mainWindow .. "CraftedBy", FormatProperly(GetStringFromTid(1060636)) )
	elseif ItemProperties.CurrentBaseData.ExpandedProps[1011542] then  -- normal
		LabelSetText(mainWindow .. "CraftedBy", FormatProperly(GetStringFromTid(1011542)) )
	end

	if ItemProperties.CurrentBaseData.TypeName and not ItemProperties.CurrentBaseData.isJewel then
		WindowSetShowing(mainWindow .. "Medable", true)
		WindowSetShowing(mainWindow .. "MedableDeny", not ItemProperties.CurrentBaseData.ExpandedProps[1060437] and not ItemProperties.CurrentBaseData.ExpandedProps[1060482] and not ItemProperties.CurrentBaseData.medable) -- mage armor
	else
		WindowSetShowing(mainWindow .. "Medable", false)
		WindowSetShowing(mainWindow .. "MedableDeny", false)
	end
	
	if ItemProperties.CurrentBaseData.ExpandedProps[1049643] then -- cursed
		DynamicImageSetTexture(mainWindow .. "Status", "PROPS_Cursed", 0, 0)
	end
	if ItemProperties.CurrentBaseData.ExpandedProps[1038021] then -- Blessed
		DynamicImageSetTexture(mainWindow .. "Status", "PROPS_Blessed", 0, 0)
	end
	
	-- the blessed mark is visible only if the blessed for matches the player name
	local redOwned = false
	if ItemProperties.CurrentBaseData.ExpandedProps[1062203] then -- Blessed for ~1_NAME~
		
		local params = ItemProperties.GetObjectPropertiesParamsForTid(GetPlayerID(),1050045)
		local name 
		if params then
			name = params[2]
		end
		
		local pname = ItemProperties.CurrentBaseData.ExpandedProps[1062203][1]
		if pname == name then
			DynamicImageSetTexture(mainWindow .. "Status", "PROPS_Blessed", 0, 0)
		else
			DynamicImageSetTexture(mainWindow .. "Status", "PROPS_BadBlessed", 0, 0) -- wrong owner
			redOwned = true
		end
	elseif ItemProperties.CurrentBaseData.ExpandedProps[1072304] then --  : Owned by ~1_name~
		local params = ItemProperties.GetObjectPropertiesParamsForTid(GetPlayerID(),1050045)
		local name 
		if params then
			name = params[2]
		end
		local pname = ItemProperties.CurrentBaseData.ExpandedProps[1072304][1]
		if pname == name then
			DynamicImageSetTexture(mainWindow .. "Status", "PROPS_Blessed", 0, 0)
		else
			DynamicImageSetTexture(mainWindow .. "Status", "PROPS_BadBlessed", 0, 0) -- wrong owner
			redOwned = true
		end
		
	end
	
	if ItemProperties.CurrentBaseData.ExpandedProps[1061682] then --  <b>Insured</b>
		DynamicImageSetTexture(mainWindow .. "Status", "PROPS_Insured", 0, 0)
	end
	
	local resCount = 0
	local resChanges = 0
	
	local totalRes = 0
	local oldTotalRes = 0
	
	local currTid = 1060448
	local secTid = 1153735
	local baseRes = mainWindow .. "PhysicalResist"
	LabelSetTextColor(baseRes, Interface.Settings.PHYSICAL.r, Interface.Settings.PHYSICAL.g, Interface.Settings.PHYSICAL.b)
	LabelSetTextColor(baseRes .. "Cap", Interface.Settings.PHYSICAL.r, Interface.Settings.PHYSICAL.g, Interface.Settings.PHYSICAL.b)
	if ItemProperties.CurrentBaseData.ExpandedProps[currTid] and ItemProperties.CurrentBaseData.ExpandedProps[currTid].value then
		LabelSetText(baseRes, ItemProperties.CurrentBaseData.ExpandedProps[currTid].value .. L"%" )
		LabelSetText(baseRes .. "Cap", L"(" .. ItemProperties.CurrentBaseData.ExpandedProps[currTid].min .. L" - " .. ItemProperties.CurrentBaseData.ExpandedProps[currTid].cap .. L")"  )
		resCount = resCount + 1
		totalRes = totalRes + ItemProperties.CurrentBaseData.ExpandedProps[currTid].value
	elseif ItemProperties.CurrentBaseData.ExpandedProps[secTid] and ItemProperties.CurrentBaseData.ExpandedProps[secTid].value then
		LabelSetText(baseRes, ItemProperties.CurrentBaseData.ExpandedProps[secTid].value .. L"%" )
		LabelSetText(baseRes .. "Cap", L"(" .. ItemProperties.CurrentBaseData.ExpandedProps[secTid].min .. L" - " .. ItemProperties.CurrentBaseData.ExpandedProps[secTid].cap .. L")"  )
		resCount = resCount + 1
		totalRes = totalRes + ItemProperties.CurrentBaseData.ExpandedProps[secTid].value
	elseif ItemProperties.CurrentBaseData.ExpandedProps[currTid] then
		LabelSetText(baseRes, L"0%" )
		local min = ItemProperties.CurrentBaseData.ExpandedProps[currTid].min
		if not min then 
			min = 0
		end
		local cap = ItemProperties.CurrentBaseData.ExpandedProps[currTid].cap
		if not cap then 
			cap = 0
		end
		LabelSetText(baseRes .. "Cap", L"(" .. min .. L" - " .. cap .. L")"  )
	elseif ItemProperties.CurrentBaseData.ExpandedProps[secTid] then
		LabelSetText(baseRes, L"0%" )
		local min = ItemProperties.CurrentBaseData.ExpandedProps[secTid].min
		if not min then 
			min = 0
		end
		local cap = ItemProperties.CurrentBaseData.ExpandedProps[secTid].cap
		if not cap then 
			cap = 0
		end
		LabelSetText(baseRes .. "Cap", L"(" .. min .. L" - " .. cap .. L")"  )
	end
	
	local prp = ItemProperties.CurrentBaseData.ExpandedProps[currTid]
	local secprp = ItemProperties.CurrentBaseData.ExpandedProps[secTid]
	if ItemProperties.CurrentBaseData.EquippedData and prp then
		local eqProp = ItemProperties.CurrentBaseData.EquippedData.props[currTid]
		
		if not prp.value then
			prp.value = 0
		end
		local currentValue = 0
		if eqProp and eqProp[1] then
			currentValue = eqProp[1]
		end
		oldTotalRes = oldTotalRes + currentValue
		local diff = prp.value - currentValue
		
		local currentPlayerValue = WindowData.PlayerStatus[prp.sheetName]
		local totalCap = WindowData.PlayerStatus["Max"..prp.sheetName]
		
		if not totalCap then
			totalCap = CharacterSheet.CapsBonus[prp.sheetName]
		end
		
		-- we have to check if the new value will goes over the cap, and if it does, we just count what will effectively be "used"
		if totalCap then 
			currentPlayerValue = currentPlayerValue - currentValue
			currentPlayerValue = currentPlayerValue + prp.value
			if currentPlayerValue > totalCap then
				local exceed = currentPlayerValue - totalCap
				if exceed < 0 then -- we remove the exceeding part
					diff = diff + exceed
				end
			end
		end
		
		if diff > 0 then
			LabelSetTextColor(baseRes .. "Change", 0, 255, 0)
			LabelSetText(baseRes .. "Change", L"(+" .. wstring.format(L"%.0f", diff) .. L")" )
			resChanges = resChanges + 1
		elseif diff < 0 then
			LabelSetTextColor(baseRes .. "Change", 255, 0, 0)
			LabelSetText(baseRes .. "Change", L"(" .. wstring.format(L"%.0f", diff) .. L")" )
			resChanges = resChanges + 1
		end
	elseif ItemProperties.CurrentBaseData.EquippedData and secprp then
		local eqProp = ItemProperties.CurrentBaseData.EquippedData.props[secTid]
		
		if not prp.value then
			prp.value = 0
		end
		local currentValue = 0
		if eqProp and eqProp[1] then
			currentValue = eqProp[1]
		end
		oldTotalRes = oldTotalRes + currentValue
		local diff = prp.value - currentValue
		
		local currentPlayerValue = WindowData.PlayerStatus[prp.sheetName]
		local totalCap = WindowData.PlayerStatus["Max"..prp.sheetName]
		
		if not totalCap then
			totalCap = CharacterSheet.CapsBonus[prp.sheetName]
		end
		
		-- we have to check if the new value will goes over the cap, and if it does, we just count what will effectively be "used"
		if totalCap then 
			currentPlayerValue = currentPlayerValue - currentValue
			currentPlayerValue = currentPlayerValue + prp.value
			if currentPlayerValue > totalCap then
				local exceed = currentPlayerValue - totalCap
				if exceed < 0 then -- we remove the exceeding part
					diff = diff + exceed
				end
			end
		end
		
		if diff > 0 then
			LabelSetTextColor(baseRes .. "Change", 0, 255, 0)
			LabelSetText(baseRes .. "Change", L"(+" .. wstring.format(L"%.0f", diff) .. L")" )
			resChanges = resChanges + 1
		elseif diff < 0 then
			LabelSetTextColor(baseRes .. "Change", 255, 0, 0)
			LabelSetText(baseRes .. "Change", L"(" .. wstring.format(L"%.0f", diff) .. L")" )
			resChanges = resChanges + 1
		end
	end
	
	currTid = 1060447
	secTid = 1153737
	baseRes = mainWindow .. "FireResist"
	LabelSetTextColor(baseRes, Interface.Settings.FIRE.r, Interface.Settings.FIRE.g, Interface.Settings.FIRE.b)
	LabelSetTextColor(baseRes .. "Cap", Interface.Settings.FIRE.r, Interface.Settings.FIRE.g, Interface.Settings.FIRE.b)
	if ItemProperties.CurrentBaseData.ExpandedProps[currTid] and ItemProperties.CurrentBaseData.ExpandedProps[currTid].value then
		LabelSetText(baseRes, ItemProperties.CurrentBaseData.ExpandedProps[currTid].value .. L"%" )
		LabelSetText(baseRes .. "Cap", L"(" .. ItemProperties.CurrentBaseData.ExpandedProps[currTid].min .. L" - " .. ItemProperties.CurrentBaseData.ExpandedProps[currTid].cap .. L")"  )
		resCount = resCount + 1
		totalRes = totalRes + ItemProperties.CurrentBaseData.ExpandedProps[currTid].value
	elseif ItemProperties.CurrentBaseData.ExpandedProps[secTid] and ItemProperties.CurrentBaseData.ExpandedProps[secTid].value then
		LabelSetText(baseRes, ItemProperties.CurrentBaseData.ExpandedProps[secTid].value .. L"%" )
		LabelSetText(baseRes .. "Cap", L"(" .. ItemProperties.CurrentBaseData.ExpandedProps[secTid].min .. L" - " .. ItemProperties.CurrentBaseData.ExpandedProps[secTid].cap .. L")"  )
		resCount = resCount + 1
		totalRes = totalRes + ItemProperties.CurrentBaseData.ExpandedProps[secTid].value
	elseif ItemProperties.CurrentBaseData.ExpandedProps[currTid] then
		LabelSetText(baseRes, L"0%" )
		local min = ItemProperties.CurrentBaseData.ExpandedProps[currTid].min
		if not min then 
			min = 0
		end
		local cap = ItemProperties.CurrentBaseData.ExpandedProps[currTid].cap
		if not cap then 
			cap = 0
		end
		LabelSetText(baseRes .. "Cap", L"(" .. min .. L" - " .. cap .. L")"  )
	elseif ItemProperties.CurrentBaseData.ExpandedProps[secTid] then
		LabelSetText(baseRes, L"0%" )
		local min = ItemProperties.CurrentBaseData.ExpandedProps[secTid].min
		if not min then 
			min = 0
		end
		local cap = ItemProperties.CurrentBaseData.ExpandedProps[secTid].cap
		if not cap then 
			cap = 0
		end
		LabelSetText(baseRes .. "Cap", L"(" .. min .. L" - " .. cap .. L")"  )
	end
	
	local prp = ItemProperties.CurrentBaseData.ExpandedProps[currTid]
	local secprp = ItemProperties.CurrentBaseData.ExpandedProps[secTid]
	if ItemProperties.CurrentBaseData.EquippedData and prp then
		local eqProp = ItemProperties.CurrentBaseData.EquippedData.props[currTid]
		
		if not prp.value then
			prp.value = 0
		end
		local currentValue = 0
		if eqProp and eqProp[1] then
			currentValue = eqProp[1]
		end
		oldTotalRes = oldTotalRes + currentValue
		local diff = prp.value - currentValue
		
		local currentPlayerValue = WindowData.PlayerStatus[prp.sheetName]
		local totalCap = WindowData.PlayerStatus["Max"..prp.sheetName]
		
		if not totalCap then
			totalCap = CharacterSheet.CapsBonus[prp.sheetName]
		end
		
		-- we have to check if the new value will goes over the cap, and if it does, we just count what will effectively be "used"
		if totalCap then 
			currentPlayerValue = currentPlayerValue - currentValue
			currentPlayerValue = currentPlayerValue + prp.value
			if currentPlayerValue > totalCap then
				local exceed = currentPlayerValue - totalCap
				if exceed < 0 then -- we remove the exceeding part
					diff = diff + exceed
				end
			end
		end
		
		if diff > 0 then
			LabelSetTextColor(baseRes .. "Change", 0, 255, 0)
			LabelSetText(baseRes .. "Change", L"(+" .. wstring.format(L"%.0f", diff) .. L")" )
			resChanges = resChanges + 1
		elseif diff < 0 then
			LabelSetTextColor(baseRes .. "Change", 255, 0, 0)
			LabelSetText(baseRes .. "Change", L"(" .. wstring.format(L"%.0f", diff) .. L")" )
			resChanges = resChanges + 1
		end
	elseif ItemProperties.CurrentBaseData.EquippedData and secprp then
		local eqProp = ItemProperties.CurrentBaseData.EquippedData.props[secTid]
		
		if not prp.value then
			prp.value = 0
		end
		local currentValue = 0
		if eqProp and eqProp[1] then
			currentValue = eqProp[1]
		end
		oldTotalRes = oldTotalRes + currentValue
		local diff = prp.value - currentValue
		
		local currentPlayerValue = WindowData.PlayerStatus[prp.sheetName]
		local totalCap = WindowData.PlayerStatus["Max"..prp.sheetName]
		
		if not totalCap then
			totalCap = CharacterSheet.CapsBonus[prp.sheetName]
		end
		
		-- we have to check if the new value will goes over the cap, and if it does, we just count what will effectively be "used"
		if totalCap then 
			currentPlayerValue = currentPlayerValue - currentValue
			currentPlayerValue = currentPlayerValue + prp.value
			if currentPlayerValue > totalCap then
				local exceed = currentPlayerValue - totalCap
				if exceed < 0 then -- we remove the exceeding part
					diff = diff + exceed
				end
			end
		end
		
		if diff > 0 then
			LabelSetTextColor(baseRes .. "Change", 0, 255, 0)
			LabelSetText(baseRes .. "Change", L"(+" .. wstring.format(L"%.0f", diff) .. L")" )
			resChanges = resChanges + 1
		elseif diff < 0 then
			LabelSetTextColor(baseRes .. "Change", 255, 0, 0)
			LabelSetText(baseRes .. "Change", L"(" .. wstring.format(L"%.0f", diff) .. L")" )
			resChanges = resChanges + 1
		end
	end
	
	currTid = 1060445
	secTid = 1153739
	baseRes = mainWindow .. "ColdResist"
	LabelSetTextColor(baseRes, Interface.Settings.COLD.r, Interface.Settings.COLD.g, Interface.Settings.COLD.b)
	LabelSetTextColor(baseRes .. "Cap", Interface.Settings.COLD.r, Interface.Settings.COLD.g, Interface.Settings.COLD.b)
	if ItemProperties.CurrentBaseData.ExpandedProps[currTid] and ItemProperties.CurrentBaseData.ExpandedProps[currTid].value then
		LabelSetText(baseRes, ItemProperties.CurrentBaseData.ExpandedProps[currTid].value .. L"%" )
		LabelSetText(baseRes .. "Cap", L"(" .. ItemProperties.CurrentBaseData.ExpandedProps[currTid].min .. L" - " .. ItemProperties.CurrentBaseData.ExpandedProps[currTid].cap .. L")"  )
		resCount = resCount + 1
		totalRes = totalRes + ItemProperties.CurrentBaseData.ExpandedProps[currTid].value
	elseif ItemProperties.CurrentBaseData.ExpandedProps[secTid] and ItemProperties.CurrentBaseData.ExpandedProps[secTid].value then
		LabelSetText(baseRes, ItemProperties.CurrentBaseData.ExpandedProps[secTid].value .. L"%" )
		LabelSetText(baseRes .. "Cap", L"(" .. ItemProperties.CurrentBaseData.ExpandedProps[secTid].min .. L" - " .. ItemProperties.CurrentBaseData.ExpandedProps[secTid].cap .. L")"  )
		resCount = resCount + 1
		totalRes = totalRes + ItemProperties.CurrentBaseData.ExpandedProps[secTid].value
	elseif ItemProperties.CurrentBaseData.ExpandedProps[currTid] then
		LabelSetText(baseRes, L"0%" )
		local min = ItemProperties.CurrentBaseData.ExpandedProps[currTid].min
		if not min then 
			min = 0
		end
		local cap = ItemProperties.CurrentBaseData.ExpandedProps[currTid].cap
		if not cap then 
			cap = 0
		end
		LabelSetText(baseRes .. "Cap", L"(" .. min .. L" - " .. cap .. L")"  )
	elseif ItemProperties.CurrentBaseData.ExpandedProps[secTid] then
		LabelSetText(baseRes, L"0%" )
		local min = ItemProperties.CurrentBaseData.ExpandedProps[secTid].min
		if not min then 
			min = 0
		end
		local cap = ItemProperties.CurrentBaseData.ExpandedProps[secTid].cap
		if not cap then 
			cap = 0
		end
		LabelSetText(baseRes .. "Cap", L"(" .. min .. L" - " .. cap .. L")"  )
	end
	
	local prp = ItemProperties.CurrentBaseData.ExpandedProps[currTid]
	local secprp = ItemProperties.CurrentBaseData.ExpandedProps[secTid]
	if ItemProperties.CurrentBaseData.EquippedData and prp then
		local eqProp = ItemProperties.CurrentBaseData.EquippedData.props[currTid]
		
		if not prp.value then
			prp.value = 0
		end
		local currentValue = 0
		if eqProp and eqProp[1] then
			currentValue = eqProp[1]
		end
		oldTotalRes = oldTotalRes + currentValue
		local diff = prp.value - currentValue
		
		local currentPlayerValue = WindowData.PlayerStatus[prp.sheetName]
		local totalCap = WindowData.PlayerStatus["Max"..prp.sheetName]
		
		if not totalCap then
			totalCap = CharacterSheet.CapsBonus[prp.sheetName]
		end
		
		-- we have to check if the new value will goes over the cap, and if it does, we just count what will effectively be "used"
		if totalCap then 
			currentPlayerValue = currentPlayerValue - currentValue
			currentPlayerValue = currentPlayerValue + prp.value
			if currentPlayerValue > totalCap then
				local exceed = currentPlayerValue - totalCap
				if exceed < 0 then -- we remove the exceeding part
					diff = diff + exceed
				end
			end
		end
		
		if diff > 0 then
			LabelSetTextColor(baseRes .. "Change", 0, 255, 0)
			LabelSetText(baseRes .. "Change", L"(+" .. wstring.format(L"%.0f", diff) .. L")" )
			resChanges = resChanges + 1
		elseif diff < 0 then
			LabelSetTextColor(baseRes .. "Change", 255, 0, 0)
			LabelSetText(baseRes .. "Change", L"(" .. wstring.format(L"%.0f", diff) .. L")" )
			resChanges = resChanges + 1
		end
	elseif ItemProperties.CurrentBaseData.EquippedData and secprp then
		local eqProp = ItemProperties.CurrentBaseData.EquippedData.props[secTid]
		
		if not prp.value then
			prp.value = 0
		end
		local currentValue = 0
		if eqProp and eqProp[1] then
			currentValue = eqProp[1]
		end
		oldTotalRes = oldTotalRes + currentValue
		local diff = prp.value - currentValue
		
		local currentPlayerValue = WindowData.PlayerStatus[prp.sheetName]
		local totalCap = WindowData.PlayerStatus["Max"..prp.sheetName]
		
		if not totalCap then
			totalCap = CharacterSheet.CapsBonus[prp.sheetName]
		end
		
		-- we have to check if the new value will goes over the cap, and if it does, we just count what will effectively be "used"
		if totalCap then 
			currentPlayerValue = currentPlayerValue - currentValue
			currentPlayerValue = currentPlayerValue + prp.value
			if currentPlayerValue > totalCap then
				local exceed = currentPlayerValue - totalCap
				if exceed < 0 then -- we remove the exceeding part
					diff = diff + exceed
				end
			end
		end
		
		if diff > 0 then
			LabelSetTextColor(baseRes .. "Change", 0, 255, 0)
			LabelSetText(baseRes .. "Change", L"(+" .. wstring.format(L"%.0f", diff) .. L")" )
			resChanges = resChanges + 1
		elseif diff < 0 then
			LabelSetTextColor(baseRes .. "Change", 255, 0, 0)
			LabelSetText(baseRes .. "Change", L"(" .. wstring.format(L"%.0f", diff) .. L")" )
			resChanges = resChanges + 1
		end
	end
	
	currTid = 1060449
	secTid = 1153736
	baseRes = mainWindow .. "PoisonResist"
	LabelSetTextColor(baseRes, Interface.Settings.POISON.r, Interface.Settings.POISON.g, Interface.Settings.POISON.b)
	LabelSetTextColor(baseRes .. "Cap", Interface.Settings.POISON.r, Interface.Settings.POISON.g, Interface.Settings.POISON.b)
	if ItemProperties.CurrentBaseData.ExpandedProps[currTid] and ItemProperties.CurrentBaseData.ExpandedProps[currTid].value then
		LabelSetText(baseRes, ItemProperties.CurrentBaseData.ExpandedProps[currTid].value .. L"%" )
		LabelSetText(baseRes .. "Cap", L"(" .. ItemProperties.CurrentBaseData.ExpandedProps[currTid].min .. L" - " .. ItemProperties.CurrentBaseData.ExpandedProps[currTid].cap .. L")"  )
		resCount = resCount + 1
		totalRes = totalRes + ItemProperties.CurrentBaseData.ExpandedProps[currTid].value
	elseif ItemProperties.CurrentBaseData.ExpandedProps[secTid] and ItemProperties.CurrentBaseData.ExpandedProps[secTid].value then
		LabelSetText(baseRes, ItemProperties.CurrentBaseData.ExpandedProps[secTid].value .. L"%" )
		LabelSetText(baseRes .. "Cap", L"(" .. ItemProperties.CurrentBaseData.ExpandedProps[secTid].min .. L" - " .. ItemProperties.CurrentBaseData.ExpandedProps[secTid].cap .. L")"  )
		resCount = resCount + 1
		totalRes = totalRes + ItemProperties.CurrentBaseData.ExpandedProps[secTid].value
	elseif ItemProperties.CurrentBaseData.ExpandedProps[currTid] then
		LabelSetText(baseRes, L"0%" )
		local min = ItemProperties.CurrentBaseData.ExpandedProps[currTid].min
		if not min then 
			min = 0
		end
		local cap = ItemProperties.CurrentBaseData.ExpandedProps[currTid].cap
		if not cap then 
			cap = 0
		end
		LabelSetText(baseRes .. "Cap", L"(" .. min .. L" - " .. cap .. L")"  )
	elseif ItemProperties.CurrentBaseData.ExpandedProps[secTid] then
		LabelSetText(baseRes, L"0%" )
		local min = ItemProperties.CurrentBaseData.ExpandedProps[secTid].min
		if not min then 
			min = 0
		end
		local cap = ItemProperties.CurrentBaseData.ExpandedProps[secTid].cap
		if not cap then 
			cap = 0
		end
		LabelSetText(baseRes .. "Cap", L"(" .. min .. L" - " .. cap .. L")"  )
	end
	
	local prp = ItemProperties.CurrentBaseData.ExpandedProps[currTid]
	local secprp = ItemProperties.CurrentBaseData.ExpandedProps[secTid]
	if ItemProperties.CurrentBaseData.EquippedData and prp then
		local eqProp = ItemProperties.CurrentBaseData.EquippedData.props[currTid]
		
		if not prp.value then
			prp.value = 0
		end
		local currentValue = 0
		if eqProp and eqProp[1] then
			currentValue = eqProp[1]
		end
		oldTotalRes = oldTotalRes + currentValue
		local diff = prp.value - currentValue
		
		local currentPlayerValue = WindowData.PlayerStatus[prp.sheetName]
		local totalCap = WindowData.PlayerStatus["Max"..prp.sheetName]
		
		if not totalCap then
			totalCap = CharacterSheet.CapsBonus[prp.sheetName]
		end
		
		-- we have to check if the new value will goes over the cap, and if it does, we just count what will effectively be "used"
		if totalCap then 
			currentPlayerValue = currentPlayerValue - currentValue
			currentPlayerValue = currentPlayerValue + prp.value
			if currentPlayerValue > totalCap then
				local exceed = currentPlayerValue - totalCap
				if exceed < 0 then -- we remove the exceeding part
					diff = diff + exceed
				end
			end
		end
		
		if diff > 0 then
			LabelSetTextColor(baseRes .. "Change", 0, 255, 0)
			LabelSetText(baseRes .. "Change", L"(+" .. wstring.format(L"%.0f", diff) .. L")" )
			resChanges = resChanges + 1
		elseif diff < 0 then
			LabelSetTextColor(baseRes .. "Change", 255, 0, 0)
			LabelSetText(baseRes .. "Change", L"(" .. wstring.format(L"%.0f", diff) .. L")" )
			resChanges = resChanges + 1
		end
	elseif ItemProperties.CurrentBaseData.EquippedData and secprp then
		local eqProp = ItemProperties.CurrentBaseData.EquippedData.props[secTid]
		
		if not prp.value then
			prp.value = 0
		end
		local currentValue = 0
		if eqProp and eqProp[1] then
			currentValue = eqProp[1]
		end
		oldTotalRes = oldTotalRes + currentValue
		local diff = prp.value - currentValue
		
		local currentPlayerValue = WindowData.PlayerStatus[prp.sheetName]
		local totalCap = WindowData.PlayerStatus["Max"..prp.sheetName]
		
		if not totalCap then
			totalCap = CharacterSheet.CapsBonus[prp.sheetName]
		end
		
		-- we have to check if the new value will goes over the cap, and if it does, we just count what will effectively be "used"
		if totalCap then 
			currentPlayerValue = currentPlayerValue - currentValue
			currentPlayerValue = currentPlayerValue + prp.value
			if currentPlayerValue > totalCap then
				local exceed = currentPlayerValue - totalCap
				if exceed < 0 then -- we remove the exceeding part
					diff = diff + exceed
				end
			end
		end
		
		if diff > 0 then
			LabelSetTextColor(baseRes .. "Change", 0, 255, 0)
			LabelSetText(baseRes .. "Change", L"(+" .. wstring.format(L"%.0f", diff) .. L")" )
			resChanges = resChanges + 1
		elseif diff < 0 then
			LabelSetTextColor(baseRes .. "Change", 255, 0, 0)
			LabelSetText(baseRes .. "Change", L"(" .. wstring.format(L"%.0f", diff) .. L")" )
			resChanges = resChanges + 1
		end
	end
	
	currTid = 1060446
	secTid = 1153738
	baseRes = mainWindow .. "EnergyResist"
	LabelSetTextColor(baseRes, Interface.Settings.ENERGY.r, Interface.Settings.ENERGY.g, Interface.Settings.ENERGY.b)
	LabelSetTextColor(baseRes .. "Cap", Interface.Settings.ENERGY.r, Interface.Settings.ENERGY.g, Interface.Settings.ENERGY.b)
	if ItemProperties.CurrentBaseData.ExpandedProps[currTid] and ItemProperties.CurrentBaseData.ExpandedProps[currTid].value then
		LabelSetText(baseRes, ItemProperties.CurrentBaseData.ExpandedProps[currTid].value .. L"%" )
		LabelSetText(baseRes .. "Cap", L"(" .. ItemProperties.CurrentBaseData.ExpandedProps[currTid].min .. L" - " .. ItemProperties.CurrentBaseData.ExpandedProps[currTid].cap .. L")"  )
		resCount = resCount + 1
		totalRes = totalRes + ItemProperties.CurrentBaseData.ExpandedProps[currTid].value
	elseif ItemProperties.CurrentBaseData.ExpandedProps[secTid] and ItemProperties.CurrentBaseData.ExpandedProps[secTid].value then
		LabelSetText(baseRes, ItemProperties.CurrentBaseData.ExpandedProps[secTid].value .. L"%" )
		LabelSetText(baseRes .. "Cap", L"(" .. ItemProperties.CurrentBaseData.ExpandedProps[secTid].min .. L" - " .. ItemProperties.CurrentBaseData.ExpandedProps[secTid].cap .. L")"  )
		resCount = resCount + 1
		totalRes = totalRes + ItemProperties.CurrentBaseData.ExpandedProps[secTid].value
	elseif ItemProperties.CurrentBaseData.ExpandedProps[currTid] then
		LabelSetText(baseRes, L"0%" )
		local min = ItemProperties.CurrentBaseData.ExpandedProps[currTid].min
		if not min then 
			min = 0
		end
		local cap = ItemProperties.CurrentBaseData.ExpandedProps[currTid].cap
		if not cap then 
			cap = 0
		end
		LabelSetText(baseRes .. "Cap", L"(" .. min .. L" - " .. cap .. L")"  )
	elseif ItemProperties.CurrentBaseData.ExpandedProps[secTid] then
		LabelSetText(baseRes, L"0%" )
		local min = ItemProperties.CurrentBaseData.ExpandedProps[secTid].min
		if not min then 
			min = 0
		end
		local cap = ItemProperties.CurrentBaseData.ExpandedProps[secTid].cap
		if not cap then 
			cap = 0
		end
		LabelSetText(baseRes .. "Cap", L"(" .. min .. L" - " .. cap .. L")"  )
	end
	
	local prp = ItemProperties.CurrentBaseData.ExpandedProps[currTid]
	local secprp = ItemProperties.CurrentBaseData.ExpandedProps[secTid]
	if ItemProperties.CurrentBaseData.EquippedData and prp then
		local eqProp = ItemProperties.CurrentBaseData.EquippedData.props[currTid]
		
		if not prp.value then
			prp.value = 0
		end
		local currentValue = 0
		if eqProp and eqProp[1] then
			currentValue = eqProp[1]
		end
		oldTotalRes = oldTotalRes + currentValue
		local diff = prp.value - currentValue
		
		local currentPlayerValue = WindowData.PlayerStatus[prp.sheetName]
		local totalCap = WindowData.PlayerStatus["Max"..prp.sheetName]
		
		if not totalCap then
			totalCap = CharacterSheet.CapsBonus[prp.sheetName]
		end
		
		-- we have to check if the new value will goes over the cap, and if it does, we just count what will effectively be "used"
		if totalCap then 
			currentPlayerValue = currentPlayerValue - currentValue
			currentPlayerValue = currentPlayerValue + prp.value
			if currentPlayerValue > totalCap then
				local exceed = currentPlayerValue - totalCap
				if exceed < 0 then -- we remove the exceeding part
					diff = diff + exceed
				end
			end
		end
		
		if diff > 0 then
			LabelSetTextColor(baseRes .. "Change", 0, 255, 0)
			LabelSetText(baseRes .. "Change", L"(+" .. wstring.format(L"%.0f", diff) .. L")" )
			resChanges = resChanges + 1
		elseif diff < 0 then
			LabelSetTextColor(baseRes .. "Change", 255, 0, 0)
			LabelSetText(baseRes .. "Change", L"(" .. wstring.format(L"%.0f", diff) .. L")" )
			resChanges = resChanges + 1
		end
	elseif ItemProperties.CurrentBaseData.EquippedData and secprp then
		local eqProp = ItemProperties.CurrentBaseData.EquippedData.props[secTid]
		
		if not prp.value then
			prp.value = 0
		end
		local currentValue = 0
		if eqProp and eqProp[1] then
			currentValue = eqProp[1]
		end
		oldTotalRes = oldTotalRes + currentValue
		local diff = prp.value - currentValue
		
		local currentPlayerValue = WindowData.PlayerStatus[prp.sheetName]
		local totalCap = WindowData.PlayerStatus["Max"..prp.sheetName]
		
		if not totalCap then
			totalCap = CharacterSheet.CapsBonus[prp.sheetName]
		end
		
		-- we have to check if the new value will goes over the cap, and if it does, we just count what will effectively be "used"
		if totalCap then 
			currentPlayerValue = currentPlayerValue - currentValue
			currentPlayerValue = currentPlayerValue + prp.value
			if currentPlayerValue > totalCap then
				local exceed = currentPlayerValue - totalCap
				if exceed < 0 then -- we remove the exceeding part
					diff = diff + exceed
				end
			end
		end
		
		if diff > 0 then
			LabelSetTextColor(baseRes .. "Change", 0, 255, 0)
			LabelSetText(baseRes .. "Change", L"(+" .. wstring.format(L"%.0f", diff) .. L")" )
			resChanges = resChanges + 1
		elseif diff < 0 then
			LabelSetTextColor(baseRes .. "Change", 255, 0, 0)
			LabelSetText(baseRes .. "Change", L"(" .. wstring.format(L"%.0f", diff) .. L")" )
			resChanges = resChanges + 1
		end
	end
	
	if resCount == 0 then
		WindowSetShowing(mainWindow .. "Physical", false)
		WindowSetShowing(mainWindow .. "PhysicalResist", false)
		WindowSetShowing(mainWindow .. "PhysicalResistCap", false)
		WindowSetShowing(mainWindow .. "PhysicalResistChange", false)
		
		WindowSetShowing(mainWindow .. "Fire", false)
		WindowSetShowing(mainWindow .. "FireResist", false)
		WindowSetShowing(mainWindow .. "FireResistCap", false)
		WindowSetShowing(mainWindow .. "FireResistChange", false)
		
		WindowSetShowing(mainWindow .. "Cold", false)
		WindowSetShowing(mainWindow .. "ColdResist", false)
		WindowSetShowing(mainWindow .. "ColdResistCap", false)
		WindowSetShowing(mainWindow .. "ColdResistChange", false)
		
		WindowSetShowing(mainWindow .. "Poison", false)
		WindowSetShowing(mainWindow .. "PoisonResist", false)
		WindowSetShowing(mainWindow .. "PoisonResistCap", false)
		WindowSetShowing(mainWindow .. "PoisonResistChange", false)
		
		WindowSetShowing(mainWindow .. "Energy", false)
		WindowSetShowing(mainWindow .. "EnergyResist", false)
		WindowSetShowing(mainWindow .. "EnergyResistCap", false)
		WindowSetShowing(mainWindow .. "EnergyResistChange", false)
		
		WindowSetShowing(mainWindow .. "TotalResistName", false)
		WindowSetShowing(mainWindow .. "TotalResistValue", false)
		WindowSetShowing(mainWindow .. "TotalResistChange", false)
		
		WindowSetShowing(mainWindow .. "Line3", false)
		WindowClearAnchors(mainWindow .. "Line3")
		WindowAddAnchor(mainWindow .. "Line3", "bottomleft", mainWindow .. "Line1", "topleft", 0, 0)
	else
		LabelSetText(mainWindow .. "TotalResistName", GetStringFromTid(53))
		LabelSetText(mainWindow .. "TotalResistValue", towstring(totalRes))
		
		if ItemProperties.CurrentBaseData.EquippedData then
			local diff = totalRes - oldTotalRes
			if diff > 0 then
				LabelSetTextColor(mainWindow .. "TotalResistChange", 0, 255, 0)
				LabelSetText(mainWindow .. "TotalResistChange", L"(+" .. wstring.format(L"%.0f", diff) .. L")" )
			elseif diff < 0 then
				LabelSetTextColor(mainWindow .. "TotalResistChange", 255, 0, 0)
				LabelSetText(mainWindow .. "TotalResistChange", L"(" .. wstring.format(L"%.0f", diff) .. L")" )
			end
			WindowClearAnchors(mainWindow .. "Line3")
			WindowAddAnchor(mainWindow .. "Line3", "bottomleft", mainWindow .. "Line1", "topleft", 0, 150)
		elseif resChanges == 0 then
			WindowClearAnchors(mainWindow .. "Line3")
			WindowAddAnchor(mainWindow .. "Line3", "bottomleft", mainWindow .. "Line1", "topleft", 0, 130)
		else
			WindowClearAnchors(mainWindow .. "Line3")
			WindowAddAnchor(mainWindow .. "Line3", "bottomleft", mainWindow .. "Line1", "topleft", 0, 130)
		end
		
	end

	x, y = WindowGetDimensions(mainWindow .. "Medable")
	point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (mainWindow .. "Medable", 1)
	baseH = baseH + y + yOffs
	
	x, y = WindowGetDimensions(mainWindow .. "CraftedBy")
	point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (mainWindow .. "CraftedBy", 1)
	baseH = baseH + y + yOffs 
	
	x, y = WindowGetDimensions(mainWindow .. "Line1")
	point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (mainWindow .. "Line1", 1)
	baseH = baseH + y + yOffs

	
	x, y = WindowGetDimensions(mainWindow .. "Line3")
	point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (mainWindow .. "Line3", 1)
	baseH = baseH + y + yOffs

	-- adding all the remaining properties
	local sortedProps = {}
	local propCount = 0
	local lootCap = ItemPropertiesInfo.GetDiffCap(ItemProperties.CurrentBaseData.ExpandedProps)
	
	local isTrophy = false
	for tid, params in pairs(ItemProperties.CurrentBaseData.ExpandedProps) do
		if ItemPropertiesInfo.Trophy[tid] then
			isTrophy = true
			break
		end
	end
	for tid, params in pairs(ItemProperties.CurrentBaseData.ExpandedProps) do
		local prop = ItemProperties.CurrentBaseData.ExpandedProps[tid]
		if type(prop) == "string" then
			prop = {}
		end
		
		prop.tid = tid
		if lootCap then
			if ItemProperties.CurrentBaseData.GumpType == ItemPropertiesInfo.Types.Ranged_Weapon and ItemPropertiesInfo.LootCaps[tid] then
				prop.trueCap = ItemPropertiesInfo.LootCaps[tid].rangedCap
				
			elseif ItemProperties.CurrentBaseData.GumpType == ItemPropertiesInfo.Types.Jewel and ItemPropertiesInfo.LootCaps[tid] then
				prop.trueCap = ItemPropertiesInfo.LootCaps[tid].jewelryCap
				
			elseif ItemProperties.CurrentBaseData.GumpType == ItemPropertiesInfo.Types.Weapon and ItemPropertiesInfo.LootCaps[tid] then
				prop.trueCap = ItemPropertiesInfo.LootCaps[tid].weaponCap
				
			elseif ItemProperties.CurrentBaseData.GumpType == ItemPropertiesInfo.Types.Shield and ItemPropertiesInfo.LootCaps[tid] then
				prop.trueCap = ItemPropertiesInfo.LootCaps[tid].shieldCap
			
			elseif ItemProperties.CurrentBaseData.GumpType == ItemPropertiesInfo.Types.Wearable and ItemPropertiesInfo.LootCaps[tid] then
				prop.trueCap = ItemPropertiesInfo.LootCaps[tid].armorCap
			end
		end
		
		if prop.tid == 1072304 and not redOwned then   -- hiding "owned by" if you are the owner
			continue
		end
		if prop.tid == 1072788 and isTrophy then   -- hiding weight: 1 stone for hunting permits
			continue
		end
		
		if ItemPropertiesInfo.Materials[tid] then
			continue
		end

		if not prop or tid == 0 or ItemPropertiesInfo.NotListed[prop.tid] or (ItemPropertiesInfo.WeightONLYTid[prop.tid] and not isTrophy) or (ItemPropertiesInfo.ChargesTid[prop.tid] and not ItemPropertiesInfo.SpellChargesTid[prop.tid]) or not prop.index or prop.index <= 1 or ItemPropertiesInfo.BodMaterials[prop.tid] or ItemPropertiesInfo.UselessRefinementData[prop.tid] then
			continue
		end
		sortedProps[prop.index] = prop

		propCount = propCount + 1
	end

	local propsH = 0

	if propCount > 0  then
		local topAnchor = mainWindow .. "Line3"
		local topmargin = 5
		propsH = topmargin
		local prevLabel
		local currLabel
		local idx = 1
		for i, _ in pairsByKeys(sortedProps) do
			local prop = sortedProps[i]
			currLabel = "prop" .. idx
			prevLabel = "prop" .. idx - 1
			
			if prop.tid == 1060438 then -- mage weapon
				prop.value = prop.value * -1
			end
			
			CreateWindowFromTemplate(currLabel, "NewItemPropItemDef", mainWindow)
			if ItemPropertiesInfo.WeightONLYTid[prop.tid] then -- trophy
				LabelSetTextColor(currLabel .. "Text", Interface.Settings.Props_MAGICPROP_COLOR.r, Interface.Settings.Props_MAGICPROP_COLOR.g, Interface.Settings.Props_MAGICPROP_COLOR.b)
				prop.raw = ReplaceTokens(GetStringFromTid(prop.tid), {StringUtils.AddCommasToNumber(prop[1])})
			elseif prop.tid == 1072304 and redOwned then
				 LabelSetTextColor(currLabel .. "Text", 255, 0, 0)
			elseif prop.tid == 1043304 then -- Price: ~1_COST~
				LabelSetTextColor(currLabel .. "Text", Interface.Settings.Props_ENGRAVE_COLOR.r, Interface.Settings.Props_ENGRAVE_COLOR.g, Interface.Settings.Props_ENGRAVE_COLOR.b)
			elseif prop.tid == 1043306 then -- Price: FREE!
				LabelSetTextColor(currLabel .. "Text", 0, 255, 0)
			elseif prop.tid == 1043307 then -- Price: Not for sale.
				LabelSetTextColor(currLabel .. "Text", 255, 0, 0)
			elseif (prop.value and prop.value < 0) or (prop[1] and tonumber(prop[1]) and tonumber(prop[1]) < 0) or prop.tid == 1049643 or prop.tid == 1116209 or prop.tid == 1152714 or prop.tid == 1154910 or prop.tid == 1154910  or prop.tid == 1154909  or prop.tid == 1155420 then -- cursed, brittle, antique, prized, unwieldly, massive or negative value
				LabelSetTextColor(currLabel .. "Text", 255, 0, 0)
			elseif ItemPropertiesInfo.SetProperties[prop.tid] then
				LabelSetTextColor(currLabel .. "Text", Interface.Settings.Props_SET_COLOR.r, Interface.Settings.Props_SET_COLOR.g, Interface.Settings.Props_SET_COLOR.b)
			elseif prop.raw == GetStringFromTid(55) or prop.raw == GetStringFromTid(56) then
				LabelSetTextColor(currLabel .. "Text", Interface.Settings.Props_ENGRAVE_COLOR.r, Interface.Settings.Props_ENGRAVE_COLOR.g, Interface.Settings.Props_ENGRAVE_COLOR.b)
			elseif prop.tid == 1060656 then -- amount to make: ~1_val~
				LabelSetTextColor(currLabel .. "Text", Interface.Settings.Props_ENGRAVE_COLOR.r, Interface.Settings.Props_ENGRAVE_COLOR.g, Interface.Settings.Props_ENGRAVE_COLOR.b)
			elseif prop.intensity and tonumber(prop.intensity) and Interface.Settings.IntensInfo then
				LabelSetTextColor(currLabel .. "Text", ItemProperties.GetIntensityColor(prop.intensity))

			elseif ItemPropertiesInfo.ExpansionProperties[prop.tid] and not Interface.ActiveAccountFeatures[ItemPropertiesInfo.ExpansionProperties[prop.tid]] then
				LabelSetTextColor(currLabel .. "Text", 255, 0, 0)
			else
				LabelSetTextColor(currLabel .. "Text", Interface.Settings.Props_MAGICPROP_COLOR.r, Interface.Settings.Props_MAGICPROP_COLOR.g, Interface.Settings.Props_MAGICPROP_COLOR.b)
			end
			if idx == 1 then
				WindowAddAnchor(currLabel, "bottomleft", topAnchor, "topleft", 10, topmargin)
			else
				WindowAddAnchor(currLabel, "bottomleft", prevLabel, "topleft", 0, 10)
			end

			if Spellbook.MasteryBookTIDs[prop.tid] then
				if Spellbook.MyMasteries[prop.tid] then
					prop.raw = WindowUtils.translateMarkup(GetStringFromTid(prop.tid)) .. L" (" .. ReplaceTokens(GetStringFromTid(1156052), {towstring(Spellbook.MyMasteries[prop.tid])}).. L")" -- Tier: ~1_LVL~
				end
			end
			
			if prop.tid == 1072378 then -- Only when full set is present:
				prop.raw = wstring.gsub(prop.raw, L"\n", L"")
			elseif prop.tid == 1070998 then -- Use this to redeem Your ~1_PROMO~
				prop.raw = wstring.gsub(prop.raw, L"\n", L" ")
			end
			
			if ItemPropertiesInfo.DecoProperties[prop.tid] or (prop and prop.desc) then
				local _, h = WindowGetDimensions(currLabel .. "Text")
				WindowSetDimensions(currLabel .. "Text", 409, h)
			end
			
			--if idx == 1 then
			--	LabelSetText(currLabel .. "Text",  FormatProperly(L"Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis,") ) 
			--else
				LabelSetText(currLabel .. "Text",  FormatProperly(prop.raw) ) 
			--end
			
			local _, h = WindowGetDimensions(currLabel .. "Text")
			local w, _ = WindowGetDimensions(currLabel)
			WindowSetDimensions(currLabel, w, h)
			
			if Interface.Settings.ShowCaps then
				if prop.trueCap then
					LabelSetText(currLabel .. "Cap", ReplaceTokens(GetStringFromTid(49), {wstring.format(L"%.0f", prop.trueCap)}) )
				elseif prop.cap then
					LabelSetText(currLabel .. "Cap", ReplaceTokens(GetStringFromTid(49), {wstring.format(L"%.0f", prop.cap)}) )
				end
			end
			
			DynamicImageSetTexture(currLabel .. "Dot", "PROPS_Description", 0, 0) -- default image
			
			if ItemProperties.CurrentBaseData.EquippedData and not ItemPropertiesInfo.DecoProperties[prop.tid] and not (prop and prop.desc) then
				local eqProp = ItemProperties.CurrentBaseData.EquippedData.props[prop.tid]
				if prop.cap then
					if eqProp and eqProp[1] and prop.value then
						local currentValue = tonumber(eqProp[1])
						local diff = prop.value - currentValue
						
						local currentPlayerValue = WindowData.PlayerStatus[prop.sheetName]
						local totalCap = WindowData.PlayerStatus["Max"..prop.sheetName]
						
						if not totalCap then
							totalCap = CharacterSheet.CapsBonus[prop.sheetName]
						end
						
						-- we have to check if the new value will goes over the cap, and if it does, we just count what will effectively be "used"
						if totalCap then 
							currentPlayerValue = currentPlayerValue - currentValue
							currentPlayerValue = currentPlayerValue + prop.value
							if currentPlayerValue > totalCap then
								local exceed = currentPlayerValue - totalCap
								if exceed < 0 then -- we remove the exceeding part
									diff = diff + exceed
								end
							end
						end
						
						if diff > 0 then
							LabelSetTextColor(currLabel .. "Change", 0, 255, 0)
							DynamicImageSetTexture(currLabel .. "Dot", "PROPS_Gain", 0, 0)
							LabelSetText(currLabel .. "Change", L"(+" .. wstring.format(L"%.0f", diff) .. L")" )
						elseif diff < 0 then
							LabelSetTextColor(currLabel .. "Change", 255, 0, 0)
							DynamicImageSetTexture(currLabel .. "Dot", "PROPS_Lose", 0, 0)
							LabelSetText(currLabel .. "Change", L"(" .. wstring.format(L"%.0f", diff) .. L")" )
						else
							DynamicImageSetTexture(currLabel .. "Dot", "PROPS_Equal", 0, 0)
						end
						
					elseif not ItemPropertiesInfo.DecoProperties[prop.tid] and not (prop and prop.desc) and prop.sheetName then
						
						local diff = prop.value
						
						local currentPlayerValue = WindowData.PlayerStatus[prop.sheetName]
						local totalCap = WindowData.PlayerStatus["Max"..prop.sheetName]
						
						if not totalCap then
							totalCap = CharacterSheet.CapsBonus[prop.sheetName]
						end
						
						-- we have to check if the new value will goes over the cap, and if it does, we just count what will effectively be "used"
						if totalCap then 
							currentPlayerValue = currentPlayerValue + prop.value
							if currentPlayerValue > totalCap then
								local exceed = currentPlayerValue - totalCap
								if exceed < 0 then -- we remove the exceeding part
									diff = diff + exceed
								end
							end
						end
						
						if diff > 0 then
							DynamicImageSetTexture(currLabel .. "Dot", "PROPS_Gain", 0, 0)
							LabelSetTextColor(currLabel .. "Change", 0, 255, 0)
							LabelSetText(currLabel .. "Change", L"(+" .. wstring.format(L"%.0f", diff) .. L")" )
						elseif diff < 0 then
							DynamicImageSetTexture(currLabel .. "Dot", "PROPS_Lose", 0, 0)
							LabelSetTextColor(currLabel .. "Change", 255, 0, 0)
							LabelSetText(currLabel .. "Change", L"(" .. wstring.format(L"%.0f", diff) .. L")" )
						else
							DynamicImageSetTexture(currLabel .. "Dot", "PROPS_Equal", 0, 0)
						end
						
						
					else
						DynamicImageSetTexture(currLabel .. "Dot", "PROPS_Description", 0, 0)
					end
				else
					if eqProp then
						DynamicImageSetTexture(currLabel .. "Dot", "PROPS_Equal", 0, 0)	
					elseif not ItemPropertiesInfo.DecoProperties[prop.tid] and not (prop and prop.desc) then
						DynamicImageSetTexture(currLabel .. "Dot", "PROPS_Gain", 0, 0)	
					else
						DynamicImageSetTexture(currLabel .. "Dot", "PROPS_Description", 0, 0)
					end
				end
			end
			
			x, y = WindowGetDimensions(currLabel)
			point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (currLabel, 1)
			propsH = propsH + y + yOffs
			idx = idx + 1

		end

		WindowClearAnchors(mainWindow .. "Line4")
		WindowAddAnchor(mainWindow .. "Line4", "bottomleft", currLabel, "topleft", -10, 10)

		x, y = WindowGetDimensions(mainWindow .. "Line4")
		point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (mainWindow .. "Line4", 1)
		propsH = propsH + y + yOffs - 5
		
	else
		WindowSetShowing(mainWindow .. "Line4", false)
	end
	
	local bottomH = 0
	local bottomReq = 0
	
	-- item weight
	local noweight = true
	if not isTrophy then
		for tid, param in pairs(ItemPropertiesInfo.WeightONLYTid) do
			if ItemProperties.CurrentBaseData.ExpandedProps[tid] then
				local prop = ItemProperties.CurrentBaseData.ExpandedProps[tid]
				prop.value = tostring(prop[1])
				prop.value = tonumber(prop.value)
				if prop.value then
					if GenericGump.CurrentOver == "" and not ItemProperties.CurrentBaseData.equipped and not DoesPlayerHaveItem(ItemProperties.CurrentBaseData.objectId) then -- weight warning
						local w = WindowData.PlayerStatus.Weight + prop.value
						local mw = WindowData.PlayerStatus.MaxWeight - 10	
						if (w >= mw) then
							LabelSetTextColor(mainWindow .. "WeightValue", 255, 0, 0)
							DynamicImageSetTexture(mainWindow .. "Weight", "PROPS_WeightWarning", 0, 0)
						end
					end

					WindowSetShowing(mainWindow .. "Weight", true)
					
					DynamicImageSetTexture(mainWindow .. "Weight", "PROPS_Weight", 0, 0)
					
					LabelSetText(mainWindow .. "WeightValue", Knumber(prop.value) )
					
					x, y = WindowGetDimensions(mainWindow .. "Weight")
					point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (mainWindow .. "Weight", 1)
					bottomH = bottomH + y + yOffs + 16
					
					bottomReq = bottomReq + 1
					noweight = false
				end
				break
			end	
		end
	end
	
	WindowClearAnchors(mainWindow .. "WeightValue")
	WindowAddAnchor(mainWindow .. "WeightValue", "bottomright", mainWindow .. "Line4", "topright", -20, 25)
	
	WindowClearAnchors(mainWindow .. "Weight")
	WindowAddAnchor(mainWindow .. "Weight", "left", mainWindow .. "WeightValue", "right", -10, 0)
	
	-- item str requirement
	local noSTR = false
	
	if ItemProperties.CurrentBaseData.ExpandedProps[1061170] and ItemProperties.CurrentBaseData.ExpandedProps[1061170][1] then
		local str = tostring(ItemProperties.CurrentBaseData.ExpandedProps[1061170][1])
		str = tonumber(str)
		WindowSetShowing(mainWindow .. "Str", true)
		local baseStr = tonumber(WindowData.PlayerStatus["Strength"]) - tonumber(WindowData.PlayerStatus["IncreaseStr"])
		if baseStr < str then
			LabelSetTextColor(mainWindow .. "StrValue", 255, 125, 64)
			DynamicImageSetTexture(mainWindow .. "Str", "PROPS_StrWarningBase", 0, 0)
		elseif tonumber(WindowData.PlayerStatus["Strength"]) >= str then
			DynamicImageSetTexture(mainWindow .. "Str", "PROPS_Str", 0, 0)
		else
			LabelSetTextColor(mainWindow .. "StrValue", 255, 0, 0)
			DynamicImageSetTexture(mainWindow .. "Str", "PROPS_StrWarning", 0, 0)
		end
		LabelSetText(mainWindow .. "StrValue", towstring(str) )
		
		if noweight then
			x, y = WindowGetDimensions(mainWindow .. "Str")
			point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (mainWindow .. "Str", 1)
			bottomH = bottomH + y + yOffs + 16
		end
		bottomReq = bottomReq + 1
	else
		noSTR = true
	end
	
	WindowClearAnchors(mainWindow .. "StrValue")
	WindowAddAnchor(mainWindow .. "StrValue", "left", mainWindow .. "Weight", "left", -40, 0)
	
	WindowClearAnchors(mainWindow .. "Str")
	WindowAddAnchor(mainWindow .. "Str", "left", mainWindow .. "StrValue", "right", -10, 0)
	
	-- race requirement
	local raceCount = 0
	if ItemProperties.CurrentBaseData.human == nil then
		WindowSetShowing(mainWindow .. "Human", false)
	elseif not ItemProperties.CurrentBaseData.human then
		DynamicImageSetTexture(mainWindow .. "Human", "PROPS_NoHuman", 0, 0)
		WindowSetShowing(mainWindow .. "Human", true)
		raceCount = raceCount + 1
	elseif WindowData.PlayerStatus["Race"] ~= 1 then
		DynamicImageSetTexture(mainWindow .. "Human", "PROPS_BadHuman", 0, 0)
		WindowSetShowing(mainWindow .. "Human", true)
		raceCount = raceCount + 1
	else
		WindowSetShowing(mainWindow .. "Human", true)
		raceCount = raceCount + 1
	end
	
	WindowClearAnchors(mainWindow .. "Human")
	WindowAddAnchor(mainWindow .. "Human", "bottomleft", mainWindow .. "Line4", "topleft", 20, 10)
	
	if ItemProperties.CurrentBaseData.elf == nil then
		WindowSetShowing(mainWindow .. "Elf", false)
	elseif not ItemProperties.CurrentBaseData.elf then
		DynamicImageSetTexture(mainWindow .. "Elf", "PROPS_NoElf", 0, 0)
		WindowSetShowing(mainWindow .. "Elf", true)
		raceCount = raceCount + 1
	elseif WindowData.PlayerStatus["Race"] ~= 2 then
		DynamicImageSetTexture(mainWindow .. "Elf", "PROPS_BadElf", 0, 0)
		WindowSetShowing(mainWindow .. "Elf", true)
		raceCount = raceCount + 1
	else
		WindowSetShowing(mainWindow .. "Elf", true)
		raceCount = raceCount + 1
	end
	
	WindowClearAnchors(mainWindow .. "Elf")
	WindowAddAnchor(mainWindow .. "Elf", "right", mainWindow .. "Human", "left", 20, 0)
	
	if ItemProperties.CurrentBaseData.gargoyle == nil then
		WindowSetShowing(mainWindow .. "Gargoyle", false)
	elseif not ItemProperties.CurrentBaseData.gargoyle then
		DynamicImageSetTexture(mainWindow .. "Gargoyle", "PROPS_NoGargoyle", 0, 0)
		WindowSetShowing(mainWindow .. "Gargoyle", true)
		raceCount = raceCount + 1
	elseif WindowData.PlayerStatus["Race"] ~= 3 then
		DynamicImageSetTexture(mainWindow .. "Gargoyle", "PROPS_BadGargoyle", 0, 0)
		WindowSetShowing(mainWindow .. "Gargoyle", true)
		raceCount = raceCount + 1
	else
		WindowSetShowing(mainWindow .. "Gargoyle", true)
		raceCount = raceCount + 1
	end
	
	if (raceCount > 0 or (ItemProperties.CurrentBaseData.hue and ItemProperties.CurrentBaseData.hue ~= 0)) and (not noSTR or not noweight) then
		bottomH = bottomH + 10
	end
	
	if (raceCount == 0 and (not ItemProperties.CurrentBaseData.hue or ItemProperties.CurrentBaseData.hue == 0)) and (not noSTR or not noweight) then
		bottomH = bottomH + 20
	end
	
	WindowClearAnchors(mainWindow .. "Gargoyle")
	WindowAddAnchor(mainWindow .. "Gargoyle", "right", mainWindow .. "Elf", "left", 20, 0)

	
	if ItemProperties.CurrentBaseData.uses then
		WindowSetShowing(mainWindow .. "Charges", true)
		LabelSetText(mainWindow .. "ChargesValue", Knumber(ItemProperties.CurrentBaseData.uses) )
		
		if noSTR and not (ItemProperties.CurrentBaseData.hue and ItemProperties.CurrentBaseData.hue ~= 0) then
			
			if (not ItemProperties.CurrentBaseData.Durability or ItemProperties.CurrentBaseData.Durability.max <= 0)  and noweight  then
				WindowClearAnchors(mainWindow .. "Charges")
				WindowAddAnchor(mainWindow .. "Charges", "bottomright", mainWindow .. "Line4", "toright", -80, 10)
				
				WindowClearAnchors(mainWindow .. "ChargesValue")
				WindowAddAnchor(mainWindow .. "ChargesValue", "right", mainWindow .. "Charges", "left", 5, 0)
			
				x, y = WindowGetDimensions(mainWindow .. "Charges")
				point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (mainWindow .. "ChargesValue", 1)
				bottomH = bottomH + y + yOffs + 15
				
				bottomReq = bottomReq + 1
			else
				WindowClearAnchors(mainWindow .. "Charges")
				WindowAddAnchor(mainWindow .. "Charges", "topleft", mainWindow .. "Str", "topleft", 0, 5)
				
				WindowClearAnchors(mainWindow .. "ChargesValue")
				WindowAddAnchor(mainWindow .. "ChargesValue", "right", mainWindow .. "Charges", "left", 5, 0)
			end
			
		elseif bottomReq == 0 then
			WindowClearAnchors(mainWindow .. "Charges")
			WindowAddAnchor(mainWindow .. "Charges", "bottomright", mainWindow .. "Line4", "toright", -100, 15)
			
			WindowClearAnchors(mainWindow .. "ChargesValue")
			WindowAddAnchor(mainWindow .. "ChargesValue", "right", mainWindow .. "Charges", "left", 5, 0)
		
			x, y = WindowGetDimensions(mainWindow .. "Charges")
			point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (mainWindow .. "ChargesValue", 1)
			bottomH = bottomH + y + yOffs 

			bottomReq = bottomReq + 1
		else
			WindowClearAnchors(mainWindow .. "Charges")
			WindowAddAnchor(mainWindow .. "Charges", "bottomleft", mainWindow .. "Weight", "topleft", 0, 15)
			
			WindowClearAnchors(mainWindow .. "ChargesValue")
			WindowAddAnchor(mainWindow .. "ChargesValue", "right", mainWindow .. "Charges", "left", 5, 0)

			x, y = WindowGetDimensions(mainWindow .. "Charges")
			point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (mainWindow .. "ChargesValue", 1)
			bottomH = bottomH + y + yOffs 

			bottomReq = bottomReq + 1
		end
		
	else
		WindowSetShowing(mainWindow .. "Charges", false)
		WindowSetShowing(mainWindow .. "ChargesValue", false)
	end
	
	WindowClearAnchors(mainWindow .. "DurBar")
	WindowAddAnchor(mainWindow .. "DurBar", "bottomleft", mainWindow .. "Hue", "topleft", 35, 0)
		
	if ItemProperties.CurrentBaseData.hue and ItemProperties.CurrentBaseData.hue ~= 0 then
		EquipmentData.DrawObjectIcon(4011, ItemProperties.CurrentBaseData.hue, mainWindow .. "Hue", 0, 0, 1) -- dye tub image
		
		local hueName = HuesInfo.Data[ItemProperties.CurrentBaseData.hue]
		WindowClearAnchors(mainWindow .. "HueValue")
		if hueName then
			WindowAddAnchor(mainWindow .. "HueValue", "right", mainWindow .. "Hue", "left", 10, -10)
			LabelSetText(mainWindow .. "HueValue", ReplaceTokens(GetStringFromTid(52), {towstring(ItemProperties.CurrentBaseData.hue), hueName}) )
		else
			WindowAddAnchor(mainWindow .. "HueValue", "right", mainWindow .. "Hue", "left", 10, 0)
			LabelSetText(mainWindow .. "HueValue", ReplaceTokens(GetStringFromTid(51), {towstring(ItemProperties.CurrentBaseData.hue)}) )
		end
		if bottomReq == 0 then
			
			if noSTR and noweight then
				WindowClearAnchors(mainWindow .. "DurBar")
				WindowAddAnchor(mainWindow .. "DurBar", "bottomleft", mainWindow .. "Hue", "topleft", 30, 0)
				bottomH = bottomH + 30
			else
				WindowClearAnchors(mainWindow .. "DurBar")
				WindowAddAnchor(mainWindow .. "DurBar", "bottomright", mainWindow .. "Str", "topright", 80, 20)
			end
		elseif ItemProperties.CurrentBaseData.uses and ItemProperties.CurrentBaseData.Durability then
			WindowClearAnchors(mainWindow .. "DurBar")
			WindowAddAnchor(mainWindow .. "DurBar", "bottomright", mainWindow .. "Charges", "topright", 0, 10)
			
		elseif ItemProperties.CurrentBaseData.uses and not ItemProperties.CurrentBaseData.Durability then
			bottomH = bottomH + 20
		end
		
		if raceCount == 0 then
			WindowClearAnchors(mainWindow .. "Hue")
			WindowAddAnchor(mainWindow .. "Hue", "bottomleft", mainWindow .. "Line4", "topleft", 15, 15)
			if bottomReq == 0 then

				x, y = WindowGetDimensions(mainWindow .. "Hue")
				point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (mainWindow .. "Hue", 1)
				bottomH = bottomH + y + yOffs

				bottomReq = bottomReq + 1
			end
			
		else
			WindowClearAnchors(mainWindow .. "Hue")
			WindowAddAnchor(mainWindow .. "Hue", "bottomleft", mainWindow .. "Human", "topleft", -5, 15)

			x, y = WindowGetDimensions(mainWindow .. "Hue")
			point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (mainWindow .. "Hue", 1)
			bottomH = bottomH + y + yOffs

			bottomReq = bottomReq + 1
		end
	
	elseif not ItemProperties.CurrentBaseData.uses and bottomReq > 0 and ItemProperties.CurrentBaseData.Durability then
		WindowClearAnchors(mainWindow .. "DurBar")
		WindowAddAnchor(mainWindow .. "DurBar", "bottomright", mainWindow .. "Str", "topright", 80, 20)
		
	elseif not ItemProperties.CurrentBaseData.uses and bottomReq == 0 and raceCount == 0 and ItemProperties.CurrentBaseData.Durability then
	
		WindowClearAnchors(mainWindow .. "DurBar")
		WindowAddAnchor(mainWindow .. "DurBar", "bottomleft", mainWindow .. "Line4", "topleft", 50, 10)

	elseif not ItemProperties.CurrentBaseData.uses and bottomReq == 0 and raceCount > 0 and ItemProperties.CurrentBaseData.Durability then
	
		WindowClearAnchors(mainWindow .. "DurBar")
		WindowAddAnchor(mainWindow .. "DurBar", "bottomleft", mainWindow .. "Human", "topleft", 30, 10)
		bottomH = bottomH + 50

	elseif not ItemProperties.CurrentBaseData.uses and not ItemProperties.CurrentBaseData.Durability and raceCount > 0 and (not noSTR or not noweight) then
		bottomH = bottomH + 10
		
	elseif ItemProperties.CurrentBaseData.uses and raceCount == 0 and (not noSTR or not noweight) then
		bottomH = bottomH + 30
	end

	if ItemProperties.CurrentBaseData.Durability and ItemProperties.CurrentBaseData.Durability.max > 0 then
		
		local perc = (ItemProperties.CurrentBaseData.Durability.min / ItemProperties.CurrentBaseData.Durability.max ) * 100
		if type(perc) ~= "number" or perc < 0 or perc > 100 then
			perc = 0
		end
		local gb = math.floor(2.55 * perc)
		LabelSetTextColor(mainWindow .. "DurBarValue", 255, gb, gb)
		
		LabelSetText(mainWindow .. "DurBarValue", ItemProperties.CurrentBaseData.Durability.min .. L" / " .. ItemProperties.CurrentBaseData.Durability.max )
		
		local wid = 348 * (perc / 100)

		WindowSetDimensions(mainWindow .. "DurBarFill", wid, 37)
				
		WindowClearAnchors(mainWindow .. "DurBarFill")
		WindowAddAnchor(mainWindow .. "DurBarFill", "topleft", mainWindow .. "DurBar", "topleft", 2, 5)
		
		WindowClearAnchors(mainWindow .. "DurBarValue")
		WindowAddAnchor(mainWindow .. "DurBarValue", "topleft", mainWindow .. "DurBar", "topleft", 10, 7)
		WindowAddAnchor(mainWindow .. "DurBarValue", "bottomright", mainWindow .. "DurBar", "bottomright", 0, -7)
		
		WindowSetShowing(mainWindow .. "DurBar", true)
		WindowSetShowing(mainWindow .. "DurBarFill", true)
		WindowSetShowing(mainWindow .. "DurBarValue", true)
	
		x, y = WindowGetDimensions(mainWindow .. "DurBar")
		point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (mainWindow .. "DurBar", 1)
		bottomH = bottomH + y + yOffs
		
		if bottomReq == 2 and (ItemProperties.CurrentBaseData.uses) then
			bottomH = bottomH + 10
		elseif bottomReq == 1 and (not noweight and raceCount == 0) then
			bottomH = bottomH + 10
		elseif not noSTR and not noweight and ItemProperties.CurrentBaseData.uses then
			bottomH = bottomH + 30
		elseif bottomReq == 1 and noSTR and noweight and not ItemProperties.CurrentBaseData.uses then
			bottomH = bottomH + 30
		end
		bottomReq = bottomReq + 1
	else
		WindowSetShowing(mainWindow .. "DurBar", false)
		WindowSetShowing(mainWindow .. "DurBarFill", false)
		WindowSetShowing(mainWindow .. "DurBarValue", false)
	end
	
	if bottomReq == 0 then
		WindowSetShowing(mainWindow .. "Line4", false)
		if propCount == 0 then
			WindowSetShowing(mainWindow .. "Line1", false)
		end
	end

	if bottomReq == 1 then
		bottomH = bottomH + 10
	end
	
	y = baseH + propsH + bottomH

	if ItemProperties.CurrentBaseData.Durability and ItemProperties.CurrentBaseData.Durability.max > 0 then
		
		WindowClearAnchors(mainWindow)
		WindowAddAnchor(mainWindow, "topleft", "ItemProperties", "topleft", 0, 0 )
		if not DoesWindowExist(mainWindow .. "Marker") then
			CreateWindowFromTemplate(mainWindow .. "Marker", "MarkerLine", "ItemProperties")	
		end
		WindowClearAnchors(mainWindow .. "Marker")
		WindowAddAnchor(mainWindow .. "Marker", "bottomright", mainWindow .. "DurBar", "bottomright", 0, 0 )
		
		local mainDimX, mainDimY = WindowGetDimensions(mainWindow)
		local _, _, _, markxOffs, markyOffs = WindowGetAnchor (mainWindow .. "Marker", 1)
   
		WindowSetDimensions(mainWindow, mainDimX, y + markyOffs + 11)
		--WindowAddAnchor(mainWindow, "bottomright", mainWindow .. "Marker", "bottomright", 45, 10 )
		
	else
		WindowSetDimensions(mainWindow, width, y)
	end
	
	
	WindowSetAlpha(mainWindow .. "HotbarDataWindowBackground", 0.8)
	WindowSetDimensions(mainWindow .. "HotbarData", 350, 70)
	WindowClearAnchors(mainWindow .. "HotbarData")
	WindowAddAnchor(mainWindow .. "HotbarData", "bottomleft", mainWindow, "topleft", 50, 0)
	WindowSetTintColor(mainWindow .. "HotbarDataFrame", itemColor.r, itemColor.g, itemColor.b)
	WindowSetShowing(mainWindow .. "HotbarData", false)
	
	if ((ItemProperties.CurrentItemData.binding ~= nil and wstring.len(ItemProperties.CurrentItemData.binding) > 0) or (ItemProperties.CurrentItemData.myTarget ~= nil and wstring.len(ItemProperties.CurrentItemData.myTarget) > 0)) then
		WindowSetShowing(mainWindow .. "HotbarData", true)
		if (ItemProperties.CurrentItemData.binding ~= nil and wstring.len(ItemProperties.CurrentItemData.binding) > 0) then
			LabelSetText(mainWindow .. "HotbarDataBinding", ItemProperties.CurrentItemData.binding )
		else
			WindowClearAnchors(mainWindow .. "HotbarDataTarget")
			WindowAddAnchor(mainWindow .. "HotbarDataTarget", "topleft", mainWindow .. "HotbarData", "topleft", 10, 10)
			WindowSetDimensions(mainWindow .. "HotbarData", 350, 50)
		end
		if (ItemProperties.CurrentItemData.myTarget ~= nil and wstring.len(ItemProperties.CurrentItemData.myTarget) > 0) then
			LabelSetText(mainWindow .. "HotbarDataTarget", ItemProperties.CurrentItemData.myTarget )
		end
	end
	
	WindowForceProcessAnchors(mainWindow)
	local scale = Interface.Settings.NewItemPropertiesScale
	WindowSetScale(mainWindow, scale)
	WindowSetScale("ItemProperties", scale)

	if GenericGump.CurrentOver == "" or GenericGump.CurrentOver == "VSEARCH" then
		WindowSetDimensions("ItemProperties", width, y)
		
		ItemProperties.FollowMouse()
		WindowSetId("ItemProperties", ItemProperties.CurrentBaseData.objectId)
		
		if not WindowGetShowing("ItemProperties") then
			WindowSetShowing("ItemPropertiesWindowBackground", false)
			WindowSetShowing("ItemPropertiesFrame", false)
			WindowSetShowing("ItemProperties", true)
		end
		
		if GenericGump.CurrentOver == "VSEARCH" then
			WindowSetParent(mainWindow, "Root")
			WindowClearAnchors(mainWindow)
			WindowAddAnchor(mainWindow, "center", ItemProperties.CurrentItemData.windowName, "bottomright", 0, 0)
		end
	else
		WindowSetParent(mainWindow, "Root")
	end
end


function ItemProperties.ShowMobileProps()
	local mainWindow = "MobileProperties"

	local width = ItemProperties.WeaponGump_Width
	
	CreateWindowFromTemplate(mainWindow, "MobilePropertiesTemplate", "ItemProperties")
	
	WindowSetDimensions(mainWindow, width, 0)
	
	WindowSetShowing(mainWindow .. "HPBar", false)
	WindowSetShowing(mainWindow .. "HPBarFill", false)
	WindowSetShowing(mainWindow .. "HPBarValue", false)
	
	WindowSetAlpha(mainWindow .. "WindowBackground", 0.8)
	
	WindowSetAlpha(mainWindow .. "Line1", 0.6)
	WindowSetAlpha(mainWindow .. "Line3", 0.6)
	WindowSetAlpha(mainWindow .. "Line4", 0.6)
	
	local textProperties = ItemProperties.CurrentBaseData.OriginalProps.PropertiesList
	if not textProperties then
		ItemProperties.loading = nil
		return
	end
	local name = L""
	if ItemProperties.CurrentBaseData.ExpandedProps[1050045] then -- ~1_PREFIX~~2_NAME~~3_SUFFIX~
		if wstring.len(wstring.trim(ItemProperties.CurrentBaseData.ExpandedProps[1050045][1])) > 0 then
			name = wstring.trim(ItemProperties.CurrentBaseData.ExpandedProps[1050045][1]) .. L" "
		end
		name = name .. wstring.trim(ItemProperties.CurrentBaseData.ExpandedProps[1050045][2])
		if wstring.len(wstring.trim(ItemProperties.CurrentBaseData.ExpandedProps[1050045][3])) > 0 then
			name = name .. L"\n" .. wstring.trim(ItemProperties.CurrentBaseData.ExpandedProps[1050045][3])
		end
	else
		name = wstring.trim(ItemProperties.CurrentBaseData.MobName)
	end
	
  if  ItemProperties.CurrentBaseData.ExpandedProps[1062613]  then -- "~1_NAME~" (sub-title)
		name = name .. L"\n" .. ItemProperties.CurrentBaseData.ExpandedProps[1062613][1]
	end
  
	if ItemProperties.CurrentBaseData.ExpandedProps[1042971]  then -- ~1_NOTHING~ (sub-title)
		name = name .. L"\n" .. ItemProperties.CurrentBaseData.ExpandedProps[1042971][1]
	end
	
	if  ItemProperties.CurrentBaseData.ExpandedProps[1070722]  then -- ~1_NOTHING~ (sub-title)
		name = name .. L"\n" .. ItemProperties.CurrentBaseData.ExpandedProps[1070722][1]
	end
	
	for tid, _ in pairs(ItemPropertiesInfo.PlayerTitles) do
		if ItemProperties.CurrentBaseData.ExpandedProps[tid] then
			name = name .. L"\n" .. GetStringFromTid(tid)
			ItemProperties.CurrentBaseData.ExpandedProps[tid] = nil
		end
	end
	
	local itemColor = NameColor.TextColors[ItemProperties.CurrentBaseData.Notoriety]

	if (ItemProperties.CurrentBaseData.mobileId == Interface.CurrentHonor) then
		itemColor = {r=163, g=73, b=164}
		LabelSetTextColor(mainWindow .. "MobileName", itemColor.r, itemColor.g, itemColor.b)
		LabelSetTextColor(mainWindow .. "Notoriety", itemColor.r, itemColor.g, itemColor.b)
	else
		NameColor.UpdateLabelNameColor(mainWindow.."MobileName", ItemProperties.CurrentBaseData.Notoriety)	
		NameColor.UpdateLabelNameColor(mainWindow.."Notoriety", ItemProperties.CurrentBaseData.Notoriety)	
	end
	
	if IsValidID(ItemProperties.CurrentBaseData.bodyType) then
		LabelSetText(mainWindow .. "BodyID", L"ID: " .. ItemProperties.CurrentBaseData.bodyType )
	end
	
	WindowSetTintColor(mainWindow .. "Frame", itemColor.r, itemColor.g, itemColor.b)
	WindowSetTintColor(mainWindow .. "Line1", itemColor.r, itemColor.g, itemColor.b)
	WindowSetTintColor(mainWindow .. "Line3", itemColor.r, itemColor.g, itemColor.b)
	WindowSetTintColor(mainWindow .. "Line4", itemColor.r, itemColor.g, itemColor.b)
	
	LabelSetText(mainWindow .. "MobileName", FormatProperly(name) )
	
	local noto = GetStringFromTid(57)
	
	local mobileId = ItemProperties.CurrentBaseData.mobileId
	
	LabelSetText(mainWindow .. "Notoriety", noto[ItemProperties.CurrentBaseData.Notoriety] )

	if ItemProperties.CurrentBaseData.Engrave then
		LabelSetText(mainWindow .. "Engrave", L"\"" .. ItemProperties.CurrentBaseData.Engrave .. L"\"" )
		LabelSetTextColor(mainWindow .. "Engrave", Interface.Settings.Props_ENGRAVE_COLOR.r, Interface.Settings.Props_ENGRAVE_COLOR.g, Interface.Settings.Props_ENGRAVE_COLOR.b)

	else
		local w, _ = WindowGetDimensions(mainWindow .. "Engrave")
		WindowSetDimensions(mainWindow .. "Engrave", w, 0)
	end
	
	local baseH = 0
	
	local x, y = WindowGetDimensions(mainWindow .. "MobileName")
	local point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (mainWindow .. "MobileName", 1)
	baseH = baseH + y + yOffs
	
	x, y = WindowGetDimensions(mainWindow .. "Notoriety")
	point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (mainWindow .. "Notoriety", 1)
	baseH = baseH + y + yOffs

	local engravespace = 0

	if ItemProperties.CurrentBaseData.Engrave then
		x, y = WindowGetDimensions(mainWindow .. "Engrave")
		point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (mainWindow .. "Engrave", 1)
		baseH = baseH + y + yOffs

		engravespace = y + 5
	end

	ItemProperties.CurrentBaseData.hasPaperdoll = HasPaperdoll(ItemProperties.CurrentBaseData.mobileId)

	SetPortraitImage(mobileId, mainWindow .. "Stereotype", false)

	-- draw the correct portrait (it takes a short time to get the correct data)
	Interface.AddTodoList({name = "target window draw portrait", func = function() SetPortraitImage(mobileId, mainWindow .. "Stereotype", false) end, time = Interface.TimeSinceLogin + 0.2})

	if not ItemProperties.CurrentBaseData.hasPaperdoll then

		if not IsObjectIdPet(mobileId) then
		
			local tamable = ItemProperties.CurrentBaseData.CurrentCreature ~= nil and ItemProperties.CurrentBaseData.CurrentCreature.tamable ~= nil
			WindowSetShowing(mainWindow .. "TamableDeny", not tamable )
			
			if ItemProperties.CurrentBaseData.CurrentCreature and tamable then
				LabelSetText(mainWindow .. "TamingSkill", ReplaceTokens(GetStringFromTid(58), {towstring(ItemProperties.CurrentBaseData.CurrentCreature.tamable)}) )
				
				local mint = ItemProperties.CurrentBaseData.CurrentCreature.tamable
				local tamingChance = 0
				
				local tam = GetSkillValue(SkillsWindow.SkillsID.ANIMAL_TAMING, true) -- taming
				if (WindowData.PlayerStatus["Race"] == 1) then
					if (tam < 20) then
						tam = 20
					end
				end
				if tam and mint and tam >= mint then
					tamingChance = math.abs(tam - mint)
					if tamingChance > 99 then
						tamingChance = 99
					end
				end
				tamingChance = wstring.format(L"%.1f", tamingChance) .. L"%"
				
				LabelSetText(mainWindow .. "TamingChance", ReplaceTokens(GetStringFromTid(59), {tamingChance}) )
				
				x, y = WindowGetDimensions(mainWindow .. "Tamable")
				point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (mainWindow .. "Tamable", 1)
				baseH = baseH + y + yOffs
					
				WindowClearAnchors(mainWindow .. "Line1")
				WindowAddAnchor(mainWindow .. "Line1", "bottomleft", mainWindow .. "Tamable", "topleft", -78, 10 + engravespace)

				WindowSetShowing(mainWindow .. "BodyID", false)
			else
				WindowSetShowing(mainWindow .. "Tamable", false)
				WindowSetShowing(mainWindow .. "TamableDeny", false)
				
				WindowClearAnchors(mainWindow .. "Line1")
				WindowAddAnchor(mainWindow .. "Line1", "bottomleft", mainWindow .. "Notoriety", "topleft", -78, 30 + engravespace)
			end
		else
			
			WindowSetShowing(mainWindow .. "Tamable", false)
			WindowSetShowing(mainWindow .. "TamableDeny", false)
			
			WindowClearAnchors(mainWindow .. "Line1")
			WindowAddAnchor(mainWindow .. "Line1", "bottomleft", mainWindow .. "Notoriety", "topleft", -78, 30 + engravespace)
		end
	else
		WindowSetShowing(mainWindow .. "Tamable", false)
		WindowSetShowing(mainWindow .. "TamableDeny", false)
		
		WindowClearAnchors(mainWindow .. "Line1")
		WindowAddAnchor(mainWindow .. "Line1", "bottomleft", mainWindow .. "Notoriety", "topleft", -78, 30 + engravespace)
	end
	
	if tonumber(ItemProperties.CurrentBaseData.BardDiff) then
		local stars = math.floor(tonumber(ItemProperties.CurrentBaseData.BardDiff) / 32)
		if stars < 1 then
			stars = 1
		end

		DynamicImageSetTexture(mainWindow .. "Stars", "PROPS_" .. stars .. "Star", 0, 0)
		WindowSetTintColor(mainWindow .. "Stars", Interface.Settings.Props_ENGRAVE_COLOR.r, Interface.Settings.Props_ENGRAVE_COLOR.g, Interface.Settings.Props_ENGRAVE_COLOR.b)
	end
	
	x, y = WindowGetDimensions(mainWindow .. "Line1")
	point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (mainWindow .. "Line1", 1)
	baseH = baseH + y + yOffs
	
	if ItemProperties.CurrentBaseData.ExpandedProps[502006] then -- (tame)
		DynamicImageSetTexture(mainWindow .. "Status", "PROPS_Tamed", 0, 0)
	elseif ItemProperties.CurrentBaseData.ExpandedProps[1049608] then -- (bonded)
		DynamicImageSetTexture(mainWindow .. "Status", "PROPS_Blessed", 0, 0)
	elseif IsOldQuestGiver( ItemProperties.CurrentBaseData.mobileId ) or ItemProperties.CurrentBaseData.ExpandedProps[1072269] then -- Quest Giver
		DynamicImageSetTexture(mainWindow .. "Status", "PROPS_Quester", 0, 0)
	end
	
	local resCount = 0
	local resCaps = false
	
	local currTid = 1060448 -- physical resist ~1_val~%
	local baseRes = mainWindow .. "PhysicalResist"
	LabelSetTextColor(baseRes, Interface.Settings.PHYSICAL.r, Interface.Settings.PHYSICAL.g, Interface.Settings.PHYSICAL.b)
	LabelSetTextColor(baseRes .. "Cap", Interface.Settings.PHYSICAL.r, Interface.Settings.PHYSICAL.g, Interface.Settings.PHYSICAL.b)
	if ItemProperties.CurrentBaseData.ExpandedProps[currTid] then 
		if ItemProperties.CurrentBaseData.ExpandedProps[currTid].value then
			LabelSetText(baseRes, ItemProperties.CurrentBaseData.ExpandedProps[currTid].value .. L"%" )
		end
		if ItemProperties.CurrentBaseData.ExpandedProps[currTid].range then
			LabelSetText(baseRes .. "Cap", L"(" .. ItemProperties.CurrentBaseData.ExpandedProps[currTid].range .. L")"  )
			resCaps = true
		end
		resCount = resCount + 1
	else
		LabelSetText(baseRes, L"0%" )
	end
	
	currTid = 1060447 -- fire resist ~1_val~%
	baseRes = mainWindow .. "FireResist"
	LabelSetTextColor(baseRes, Interface.Settings.FIRE.r, Interface.Settings.FIRE.g, Interface.Settings.FIRE.b)
	LabelSetTextColor(baseRes .. "Cap", Interface.Settings.FIRE.r, Interface.Settings.FIRE.g, Interface.Settings.FIRE.b)
	if ItemProperties.CurrentBaseData.ExpandedProps[currTid] then 
		if ItemProperties.CurrentBaseData.ExpandedProps[currTid].value then
			LabelSetText(baseRes, ItemProperties.CurrentBaseData.ExpandedProps[currTid].value .. L"%" )
		end
		if ItemProperties.CurrentBaseData.ExpandedProps[currTid].range then
			LabelSetText(baseRes .. "Cap", L"(" .. ItemProperties.CurrentBaseData.ExpandedProps[currTid].range .. L")"  )
			resCaps = true
		end
		resCount = resCount + 1
	else
		LabelSetText(baseRes, L"0%" )
	end
	
	currTid = 1060445
	baseRes = mainWindow .. "ColdResist"
	LabelSetTextColor(baseRes, Interface.Settings.COLD.r, Interface.Settings.COLD.g, Interface.Settings.COLD.b)
	LabelSetTextColor(baseRes .. "Cap", Interface.Settings.COLD.r, Interface.Settings.COLD.g, Interface.Settings.COLD.b)
	if ItemProperties.CurrentBaseData.ExpandedProps[currTid] then 
		if ItemProperties.CurrentBaseData.ExpandedProps[currTid].value then
			LabelSetText(baseRes, ItemProperties.CurrentBaseData.ExpandedProps[currTid].value .. L"%" )
		end
		if ItemProperties.CurrentBaseData.ExpandedProps[currTid].range then
			LabelSetText(baseRes .. "Cap", L"(" .. ItemProperties.CurrentBaseData.ExpandedProps[currTid].range .. L")"  )
			resCaps = true
		end
		resCount = resCount + 1
	else
		LabelSetText(baseRes, L"0%" )
	end
	
	currTid = 1060449
	baseRes = mainWindow .. "PoisonResist"
	LabelSetTextColor(baseRes, Interface.Settings.POISON.r, Interface.Settings.POISON.g, Interface.Settings.POISON.b)
	LabelSetTextColor(baseRes .. "Cap", Interface.Settings.POISON.r, Interface.Settings.POISON.g, Interface.Settings.POISON.b)
	if ItemProperties.CurrentBaseData.ExpandedProps[currTid] then 
		if ItemProperties.CurrentBaseData.ExpandedProps[currTid].value then
			LabelSetText(baseRes, ItemProperties.CurrentBaseData.ExpandedProps[currTid].value .. L"%" )
		end
		if ItemProperties.CurrentBaseData.ExpandedProps[currTid].range then
			LabelSetText(baseRes .. "Cap", L"(" .. ItemProperties.CurrentBaseData.ExpandedProps[currTid].range .. L")"  )
			resCaps = true
		end
		resCount = resCount + 1
	else
		LabelSetText(baseRes, L"0%" )
	end
	
	currTid = 1060446
	baseRes = mainWindow .. "EnergyResist"
	LabelSetTextColor(baseRes, Interface.Settings.ENERGY.r, Interface.Settings.ENERGY.g, Interface.Settings.ENERGY.b)
	LabelSetTextColor(baseRes .. "Cap", Interface.Settings.ENERGY.r, Interface.Settings.ENERGY.g, Interface.Settings.ENERGY.b)
	if ItemProperties.CurrentBaseData.ExpandedProps[currTid] then 
		if ItemProperties.CurrentBaseData.ExpandedProps[currTid].value then
			LabelSetText(baseRes, ItemProperties.CurrentBaseData.ExpandedProps[currTid].value .. L"%" )
		end
		if ItemProperties.CurrentBaseData.ExpandedProps[currTid].range then
			LabelSetText(baseRes .. "Cap", L"(" .. ItemProperties.CurrentBaseData.ExpandedProps[currTid].range .. L")"  )
			resCaps = true
		end
		resCount = resCount + 1
	else
		LabelSetText(baseRes, L"0%" )
	end
	
	if resCount == 0 then
		WindowSetShowing(mainWindow .. "Physical", false)
		WindowSetShowing(mainWindow .. "PhysicalResist", false)
		WindowSetShowing(mainWindow .. "PhysicalResistCap", false)
		
		WindowSetShowing(mainWindow .. "Fire", false)
		WindowSetShowing(mainWindow .. "FireResist", false)
		WindowSetShowing(mainWindow .. "FireResistCap", false)
		
		WindowSetShowing(mainWindow .. "Cold", false)
		WindowSetShowing(mainWindow .. "ColdResist", false)
		WindowSetShowing(mainWindow .. "ColdResistCap", false)
		
		WindowSetShowing(mainWindow .. "Poison", false)
		WindowSetShowing(mainWindow .. "PoisonResist", false)
		WindowSetShowing(mainWindow .. "PoisonResistCap", false)
		
		WindowSetShowing(mainWindow .. "Energy", false)
		WindowSetShowing(mainWindow .. "EnergyResist", false)
		WindowSetShowing(mainWindow .. "EnergyResistCap", false)
		
		WindowSetShowing(mainWindow .. "Line3", false)
		WindowClearAnchors(mainWindow .. "Line3")
		WindowAddAnchor(mainWindow .. "Line3", "bottomleft", mainWindow .. "Line1", "topleft", 0, 0)
		
	elseif not resCaps then
		WindowClearAnchors(mainWindow .. "Line3")
		WindowAddAnchor(mainWindow .. "Line3", "bottomleft", mainWindow .. "Line1", "topleft", 0, 80)
	else
		WindowClearAnchors(mainWindow .. "Line3")
		WindowAddAnchor(mainWindow .. "Line3", "bottomleft", mainWindow .. "Line1", "topleft", 0, 90)
	end
	
	x, y = WindowGetDimensions(mainWindow .. "Line3")
	point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (mainWindow .. "Line3", 1)
	baseH = baseH + y + yOffs
	
	
	-- adding all the remaining properties
	local sortedProps = {}
	local propCount = 0
	for tid, params in pairs(ItemProperties.CurrentBaseData.ExpandedProps) do
		local prop = ItemProperties.CurrentBaseData.ExpandedProps[tid]
		if type(prop) == "string" then
			prop = {}
		end
		prop.tid = tid

		if ItemPropertiesInfo.Materials[tid] then
			continue
		end
		if not prop or tid == 0 or ItemPropertiesInfo.NotListed[prop.tid] or (prop.index and prop.index <= 1)  or ItemPropertiesInfo.UselessRefinementData[prop.tid] then
			continue
		end
		sortedProps[prop.index] = prop
		
		propCount = propCount + 1
	end
	
	local propsH = 0
	
	if propCount > 0 or IsValidID(ItemProperties.CurrentBaseData.hue) then
		local topAnchor = mainWindow .. "Line3"
		local topmargin = 10
		propsH = topmargin
		local prevLabel
		local currLabel
		local idx = 1
		for i, _ in pairsByKeys(sortedProps) do
			local prop = sortedProps[i]
			currLabel = "prop" .. idx
			prevLabel = "prop" .. idx - 1
			
			CreateWindowFromTemplate(currLabel, "NewItemPropItemDef", mainWindow)
			
			if idx == 1 then
				WindowAddAnchor(currLabel, "bottomleft", topAnchor, "topleft", 10, topmargin)
			else
				WindowAddAnchor(currLabel, "bottomleft", prevLabel, "topleft", 0, 10)
			end
			
			local _, h = WindowGetDimensions(currLabel .. "Text")
			WindowSetDimensions(currLabel .. "Text", 409, h)

			local raw = prop.raw 
			
			if not raw then
				raw = ReplaceTokens(GetStringFromTid(prop.tid), {towstring(prop.value)})
			elseif wstring.find(raw, L"s%%") then
				raw = wstring.gsub(raw, L"s%%", L"s")
			end
			if ItemPropertiesInfo.WeightTid[prop.tid] then
				if prop.value >= 1500 then
					LabelSetTextColor(currLabel .. "Text", 255, 0, 0)
					
				elseif prop.value > 557 then
					LabelSetTextColor(currLabel .. "Text", 255, 128, 64)
				end
			elseif prop.activeSlayer then
				LabelSetTextColor(currLabel .. "Text", 0, 255, 0)
				
			elseif prop.activeOpposite then
				LabelSetTextColor(currLabel .. "Text", 255, 0, 0)	
				
			else
				LabelSetTextColor(currLabel .. "Text", Interface.Settings.Props_MAGICPROP_COLOR.r, Interface.Settings.Props_MAGICPROP_COLOR.g, Interface.Settings.Props_MAGICPROP_COLOR.b)
			end
			
			LabelSetText(currLabel .. "Text",  FormatProperly(raw) ) 
			
			DynamicImageSetTexture(currLabel .. "Dot", "PROPS_Description", 0, 0)
			
			x, y = WindowGetDimensions(currLabel)
			point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor(currLabel, 1)
			propsH = propsH + y + yOffs
			idx = idx + 1
		end

		if IsValidID(ItemProperties.CurrentBaseData.hue) then
			EquipmentData.DrawObjectIcon(4011, ItemProperties.CurrentBaseData.hue, mainWindow .. "Hue", 0, 0, 1) -- dye tub image
		
			local hueName = HuesInfo.Data[ItemProperties.CurrentBaseData.hue]
			WindowClearAnchors(mainWindow .. "HueValue")
			if hueName then
				WindowAddAnchor(mainWindow .. "HueValue", "right", mainWindow .. "Hue", "left", 10, -10)
				LabelSetText(mainWindow .. "HueValue", ReplaceTokens(GetStringFromTid(415), {towstring(ItemProperties.CurrentBaseData.hue), hueName}) )
			else
				WindowAddAnchor(mainWindow .. "HueValue", "right", mainWindow .. "Hue", "left", 10, 0)
				LabelSetText(mainWindow .. "HueValue", ReplaceTokens(GetStringFromTid(416), {towstring(ItemProperties.CurrentBaseData.hue)}) )
			end
		
			WindowClearAnchors(mainWindow .. "Hue")
			WindowAddAnchor(mainWindow .. "Hue", "bottomleft", currLabel or topAnchor, "topleft", -10, 10)
		
			WindowClearAnchors(mainWindow .. "HueValue")
			WindowAddAnchor(mainWindow .. "HueValue", "right", mainWindow .. "Hue", "left", 0, -10)
		
			x, y = WindowGetDimensions(mainWindow .. "Hue")
			point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor(mainWindow .. "Hue", 1)
			propsH = propsH + y + yOffs

			WindowClearAnchors(mainWindow .. "Line4")
			WindowAddAnchor(mainWindow .. "Line4", "bottomleft", mainWindow .. "Hue", "topleft", 0, 0)

			x, y = WindowGetDimensions(mainWindow .. "Line4")
			point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor(mainWindow .. "Line4", 1)
			propsH = propsH + y + yOffs - 10

		else
			WindowClearAnchors(mainWindow .. "Line4")
			WindowAddAnchor(mainWindow .. "Line4", "bottomleft", currLabel, "topleft", -10, 10)

			x, y = WindowGetDimensions(mainWindow .. "Line4")
			point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (mainWindow .. "Line4", 1)
			propsH = propsH + y + yOffs - 10
		end
	else
		if not ItemProperties.CurrentBaseData.Life and resCount == 0 then
			WindowSetShowing(mainWindow .. "Line1", false)
			propsH = -10
		else
			propsH = 5
		end
		if not ItemProperties.CurrentBaseData.Life then
			WindowSetShowing(mainWindow .. "Line3", false)
		end
		WindowSetShowing(mainWindow .. "Line4", false)
	end
	
	local bottomH = 0
	
	if ItemProperties.CurrentBaseData.Life then
		local perc = (ItemProperties.CurrentBaseData.Life.min / ItemProperties.CurrentBaseData.Life.max ) * 100
		if type(perc) ~= "number" or perc < 0 or perc > 100 then
			perc = 0
		end
		ItemProperties.CurrentBaseData.Life = nil
		local gb = math.floor(2.55 * perc)
		
		LabelSetTextColor(mainWindow .. "HPBarValue", 255, gb, gb)
		
		LabelSetText(mainWindow .. "HPBarValue", wstring.format(L"%.0f", perc) .. L"%" )
		
		local width = 348 * (perc / 100)

		WindowSetDimensions(mainWindow .. "HPBarFill", width, 37)
				
		WindowClearAnchors(mainWindow .. "HPBarFill")
		WindowAddAnchor(mainWindow .. "HPBarFill", "topleft", mainWindow .. "HPBar", "topleft", 2, 5)
		
		WindowClearAnchors(mainWindow .. "HPBarValue")
		WindowAddAnchor(mainWindow .. "HPBarValue", "topleft", mainWindow .. "HPBar", "topleft", 10, 7)
		WindowAddAnchor(mainWindow .. "HPBarValue", "bottomright", mainWindow .. "HPBar", "bottomright", 0, -7)
		
		WindowSetShowing(mainWindow .. "HPBar", true)
		WindowSetShowing(mainWindow .. "HPBarFill", true)
		WindowSetShowing(mainWindow .. "HPBarValue", true)
		
		
		x, y = WindowGetDimensions(mainWindow .. "HPBar")
		point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (mainWindow .. "HPBar", 1)
		bottomH = bottomH + y + yOffs + 10

	end
		
	y = baseH + propsH + bottomH
	
	if ItemProperties.CurrentBaseData.Life then
		x, _ = WindowGetDimensions(mainWindow .. "HPBar")
		xOffs, _ = WindowGetOffsetFromParent(mainWindow .. "HPBar")
		local w = xOffs + x
		w = width - w
		
		WindowAddAnchor(mainWindow, "topleft", "ItemProperties", "topleft", 0, 0 )
		WindowAddAnchor(mainWindow, "bottomright", mainWindow .. "HPBar", "bottomright", w, 10 )
	else
		WindowSetDimensions(mainWindow, width, y)
		
	end
	
	local scale = Interface.Settings.NewItemPropertiesScale
	WindowSetScale(mainWindow, scale)
	WindowSetScale("ItemProperties", scale)
	
	if GenericGump.CurrentOver == "" or GenericGump.CurrentOver == "VSEARCH" then
		WindowSetDimensions("ItemProperties", width, y)
		
		ItemProperties.FollowMouse()
		WindowSetId("ItemProperties", ItemProperties.CurrentBaseData.mobileId)
		
		if not WindowGetShowing("ItemProperties") then
			WindowSetShowing("ItemPropertiesWindowBackground", false)
			WindowSetShowing("ItemPropertiesFrame", false)
			WindowSetShowing("ItemProperties", true)
		end
		
		if GenericGump.CurrentOver == "VSEARCH" then
			WindowSetParent(mainWindow, "Root")
			WindowClearAnchors(mainWindow)
			WindowAddAnchor(mainWindow, "center", ItemProperties.CurrentItemData.windowName, "bottomright", 0, 0)
		end
	else
		WindowSetParent(mainWindow, "Root")
	end
	
end


function ItemProperties.FollowMouse()
	local scale = Interface.Settings.NewItemPropertiesScale
	if GenericGump.CurrentOver ~= "" and WindowData.ItemProperties.CurrentType == WindowData.ItemProperties.TYPE_ITEM then
		if Interface.Settings.NewItemProperties then
			if DoesWindowExist("OtherProperties") then
				
				WindowClearAnchors("ItemProperties")
				WindowForceProcessAnchors("ItemProperties")
				local width, y = WindowGetDimensions("ItemProperties")
				if not width then
					return
				end

				local scaleFactor = 1/Interface.Settings.NewItemPropertiesScale	
				
				if ItemProperties.CurrentItemData.windowName and DoesWindowExist(ItemProperties.CurrentItemData.windowName) and not Interface.PropsSlot then
					WindowAddAnchor("ItemProperties", "center", ItemProperties.CurrentItemData.windowName, "bottomright", 0, 0)

				elseif not Interface.PropsSlot then
					local windowOffset = 16 * Interface.Settings.NewItemPropertiesScale
					
					local mouseX = SystemData.MousePosition.x
					local propWindowX = mouseX - windowOffset - (width / scaleFactor)
					if propWindowX < 0 then
						propWindowX = mouseX + windowOffset
					end
						
					local mouseY = SystemData.MousePosition.y
					propWindowY = mouseY - windowOffset - (y / scaleFactor)
					if propWindowY < 0 then
						propWindowY = mouseY + windowOffset
					end
					WindowSetOffsetFromParent("ItemProperties", propWindowX * scaleFactor, propWindowY * scaleFactor)

				else
					local props = "Hotbar" .. Interface.PropsSlot.HotbarID .. "Button" .. Interface.PropsSlot.SlotID
					
					WindowAddAnchor("ItemProperties", "center", props, "bottomright", 0, 0)
				end
			end
		elseif DoesWindowExist("SpecialItemProperties") then
			WindowClearAnchors("SpecialItemProperties")
			local width, y = WindowGetDimensions("SpecialItemProperties")

			if not width then
				return
			end
			local scaleFactor = 1/Interface.Settings.NewItemPropertiesScale
			
			if ItemProperties.CurrentItemData.windowName and DoesWindowExist(ItemProperties.CurrentItemData.windowName) and not Interface.PropsSlot then
				WindowAddAnchor("SpecialItemProperties", "center", ItemProperties.CurrentItemData.windowName, "bottomright", 0, 0)
			
			elseif not Interface.PropsSlot then
				local windowOffset = 16 * Interface.Settings.NewItemPropertiesScale
				
				local mouseX = SystemData.MousePosition.x
				local propWindowX = mouseX - windowOffset - (width / scaleFactor)
				if propWindowX < 0 then
					propWindowX = mouseX + windowOffset
				end
					
				local mouseY = SystemData.MousePosition.y
				propWindowY = mouseY - windowOffset - (y / scaleFactor)
				if propWindowY < 0 then
					propWindowY = mouseY + windowOffset
				end

				WindowSetOffsetFromParent("SpecialItemProperties", propWindowX * scaleFactor, propWindowY * scaleFactor)
			
			else
				local props = "Hotbar" .. Interface.PropsSlot.HotbarID .. "Button" .. Interface.PropsSlot.SlotID
				
				WindowAddAnchor("SpecialItemProperties", "center", props, "bottomright", 0, 0)
			end
		end
	else
		WindowClearAnchors("ItemProperties")
		local width, y = WindowGetDimensions("ItemProperties")
		
		local scaleFactor = 1/Interface.Settings.NewItemPropertiesScale	
		
		if ItemProperties.CurrentItemData.windowName and DoesWindowExist(ItemProperties.CurrentItemData.windowName) and not Interface.PropsSlot then
			WindowAddAnchor("ItemProperties", "center", ItemProperties.CurrentItemData.windowName, "bottomright", 0, 0)
			
		elseif not Interface.PropsSlot then
			local windowOffset = 16 * Interface.Settings.NewItemPropertiesScale
			
			local mouseX = SystemData.MousePosition.x
			local propWindowX = mouseX - windowOffset - (width / scaleFactor)
			if propWindowX < 0 then
				propWindowX = mouseX + windowOffset
			end
				
			local mouseY = SystemData.MousePosition.y
			propWindowY = mouseY - windowOffset - (y / scaleFactor)
			if propWindowY < 0 then
				propWindowY = mouseY + windowOffset
			end

			WindowSetOffsetFromParent("ItemProperties", propWindowX * scaleFactor, propWindowY * scaleFactor)

		else
			local props = "Hotbar" .. Interface.PropsSlot.HotbarID .. "Button" .. Interface.PropsSlot.SlotID
			
			WindowAddAnchor("ItemProperties", "center", props, "bottomright", 0, 0)
		end
	end
end

function ItemProperties.WallTextProps()
	local scale = Interface.Settings.NewItemPropertiesScale
	
	local mainWindow = "ItemProperties"
	if GenericGump.CurrentOver ~= "" then
		mainWindow = "SpecialItemProperties"
		CreateWindowFromTemplate("SpecialItemProperties", "SpecialItemProperties", "Root")
	end
	
	local itemColor = Interface.Settings.Props_TITLE_COLOR
	
	if (ItemProperties.CurrentItemData.itemType == WindowData.ItemProperties.TYPE_ITEM) then
		if ItemProperties.CurrentBaseData.Set then
			itemColor = Interface.Settings.Props_SET_COLOR
		elseif ItemProperties.CurrentBaseData.Artifact then
			itemColor = Interface.Settings.Props_ARTIFACT_COLOR
		elseif ItemProperties.CurrentBaseData.Worth == ItemPropertiesInfo.UNRAVEL_RelicFragment then
			itemColor = Interface.Settings.Props_RELIC_COLOR
		elseif ItemProperties.CurrentBaseData.Worth == ItemPropertiesInfo.UNRAVEL_EnchantedEssence then
			itemColor = Interface.Settings.Props_ESSENCE_COLOR
		elseif ItemProperties.CurrentBaseData.Worth == ItemPropertiesInfo.UNRAVEL_MagicResidue then
			itemColor = Interface.Settings.Props_RESIDUE_COLOR
		end
		if GenericGump.CurrentOver == "" then
			WindowSetId(mainWindow, ItemProperties.CurrentBaseData.objectId)
		end
	elseif (ItemProperties.CurrentItemData.itemType == WindowData.ItemProperties.TYPE_MOBILE) then
		itemColor = NameColor.TextColors[ItemProperties.CurrentBaseData.Notoriety]
	
		if (ItemProperties.CurrentBaseData.mobileId == Interface.CurrentHonor) then
			itemColor = {r=163, g=73, b=164}
		end
		if GenericGump.CurrentOver == "" then
			WindowSetId(mainWindow, ItemProperties.CurrentBaseData.mobileId)
		end
	end
	
	WindowSetTintColor(mainWindow .. "Frame", itemColor.r, itemColor.g, itemColor.b)
	
	local sortedProps = {}
	local propCount = 0
	local lootCap = ItemPropertiesInfo.GetDiffCap(ItemProperties.CurrentBaseData.ExpandedProps)
	
	for tid, params in pairsByKeys(ItemProperties.CurrentBaseData.ExpandedProps) do
		local prop = ItemProperties.CurrentBaseData.ExpandedProps[tid]
		if ItemPropertiesInfo.UselessRefinementData[tid] then
			continue
		end
		if type(prop) == "string" then
			prop = {}
		end
		if prop.range then
			prop.raw = FormatProperly(ReplaceTokens(GetStringFromTid(tid), {towstring(prop.range)} ))
		end
		if not prop.raw then
			continue
		end
		if tid == 1072305 or tid == 1062613 then -- engraved
			continue
		end
		prop.tid = tid
		if lootCap then
			if ItemProperties.CurrentBaseData.GumpType == ItemPropertiesInfo.Types.Ranged_Weapon and ItemPropertiesInfo.LootCaps[tid] then
				prop.trueCap = ItemPropertiesInfo.LootCaps[tid].rangedCap
				
			elseif ItemProperties.CurrentBaseData.GumpType == ItemPropertiesInfo.Types.Jewel and ItemPropertiesInfo.LootCaps[tid] then
				prop.trueCap = ItemPropertiesInfo.LootCaps[tid].jewelryCap
				
			elseif ItemProperties.CurrentBaseData.GumpType == ItemPropertiesInfo.Types.Weapon and ItemPropertiesInfo.LootCaps[tid] then
				prop.trueCap = ItemPropertiesInfo.LootCaps[tid].weaponCap
				
			elseif ItemProperties.CurrentBaseData.GumpType == ItemPropertiesInfo.Types.Shield and ItemPropertiesInfo.LootCaps[tid] then
				prop.trueCap = ItemPropertiesInfo.LootCaps[tid].shieldCap
			
			elseif ItemProperties.CurrentBaseData.GumpType == ItemPropertiesInfo.Types.Wearable and ItemPropertiesInfo.LootCaps[tid] then
				prop.trueCap = ItemPropertiesInfo.LootCaps[tid].armorCap
			end
		end
		if (ItemProperties.CurrentItemData.itemType ~= WindowData.ItemProperties.TYPE_MOBILE) then
			if not prop.hue then
				prop.hue = ItemProperties.GetLabelColorForId(ItemProperties.CurrentBaseData.OriginalProps.ColorList, prop.index)
			end
		end
		
		if prop.index == 1 then
			local itemName = Shopkeeper.stripFirstNumber(prop.raw)
			if ItemProperties.CurrentBaseData.ExpandedProps[1050039] or (ItemProperties.CurrentBaseData.quantity and ItemProperties.CurrentBaseData.quantity > 1) then -- ~1_NUMBER~ ~2_ITEMNAME~
				local amount = StringUtils.AddCommasToNumber(ItemProperties.CurrentBaseData.quantity)
				itemName = ReplaceTokens(GetStringFromTid(1050039), {amount, itemName} )
			end
			prop.raw = itemName
		end
		
		sortedProps[prop.index] = prop

		propCount = propCount + 1
	end

	local propWindowWidth = 100
	local propWindowHeight = 4
	local numLabels = 1
	if propCount > 0  then
		for i, _ in pairsByKeys(sortedProps) do
			-- adding the engrave text
			if numLabels == 2 and ItemProperties.CurrentBaseData.Engrave then
				labelName = "ItemPropertiesItemLabel"..numLabels
				local font = ItemProperties.GetFont("normal")
				CreateWindowFromTemplate(labelName, "ItemPropItemDef", mainWindow)
				
				if numLabels == 1 then
				
					WindowAddAnchor(labelName, "top", mainWindow, "top", 0, 5)
					
					if (propCount > 1) then
						CreateWindowFromTemplate("ItemPropertiesItemLabelspace", "ItemPropItemDef", mainWindow)
						WindowAddAnchor("ItemPropertiesItemLabelspace", "bottom", labelName, "top", 0, -12)
						LabelSetText("ItemPropertiesItemLabelspace", L" ")
					end
					font = ItemProperties.GetFont("bold")
				end
				LabelSetFont(labelName, font, WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
				local color = Interface.Settings.Props_ENGRAVE_COLOR
				LabelSetTextColor(labelName, color.r, color.g, color.b)
				LabelSetText(labelName, L"\"" .. ItemProperties.CurrentBaseData.Engrave .. L"\"")
				WindowSetScale(labelName, scale)
				
				w, h = LabelGetTextDimensions(labelName)
				lblhgt = h + 5.2
				
				if (numLabels == 1) then
					lblhgt = lblhgt + 5
				else
					WindowClearAnchors( labelName )
					local anchor = "ItemPropertiesItemLabel"..numLabels-1
					if (numLabels==2) then
						anchor = "ItemPropertiesItemLabelspace"
					end
					if (font == ItemProperties.GetFont("small")) then
						lblhgt = h + 7
						
						WindowAddAnchor(labelName, "bottom", anchor, "top", 0, 7)
					else
						lblhgt = h + 5
						WindowAddAnchor(labelName, "bottom", anchor, "top", 0, 5)
					end
				end
				propWindowWidth = math.max(propWindowWidth, w)
				propWindowHeight = propWindowHeight + lblhgt -- Allow for spacing
				WindowSetShowing(labelName, true)
				
				numLabels = numLabels + 1
			end
			-- end engrave
			
			local prop = sortedProps[i]
			labelName = "ItemPropertiesItemLabel"..numLabels
			local font = ItemProperties.GetFont("normal")
			CreateWindowFromTemplate(labelName, "ItemPropItemDef", mainWindow)
			if numLabels == 1 then
				
				WindowAddAnchor(labelName, "top", mainWindow, "top", 0, 5)
				
				if (propCount > 1) then
					CreateWindowFromTemplate("ItemPropertiesItemLabelspace", "ItemPropItemDef", mainWindow)
					WindowAddAnchor("ItemPropertiesItemLabelspace", "bottom", labelName, "top", 0, -12)
					LabelSetText("ItemPropertiesItemLabelspace", L" ")
				end
				font = ItemProperties.GetFont("bold")
			end
			LabelSetFont(labelName, font, WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)

			local color = prop.hue
			if numLabels == 1 then
				color = itemColor
			elseif ItemPropertiesInfo.LostItemTid[prop.tid] then
				color = Interface.Settings.Props_LOSTITEM_COLOR
			elseif ItemProperties.TagColors[prop.tid] then
				color = ItemProperties.TagColors[prop.tid]
			elseif prop.tid == 1060639 then -- durability ~1_val~ / ~2_val~
				curr = tostring(ItemProperties.CurrentBaseData.ExpandedProps[1060639][1])
				curr = tonumber(curr)

				max = tostring(ItemProperties.CurrentBaseData.ExpandedProps[1060639][2])
				max = tonumber(max)

				local perc = (curr / max ) * 100
				if type(perc) ~= "number" or perc < 0 or perc > 100 then
					perc = 0
				end
				local gb = math.floor(2.55 * perc)
				color = {r=255, g=gb, b=gb}
			elseif ItemPropertiesInfo.WeightONLYTid[prop.tid] then
				color = {r=255, g=255, b=255}
				local p = ItemProperties.CurrentBaseData.ExpandedProps[prop.tid]
				p.value = tostring(p[1])
				p.value = tonumber(p.value)
				if p.value then
					if GenericGump.CurrentOver == "" and not DoesPlayerHaveItem(ItemProperties.CurrentBaseData.objectId) then -- weight warning
						local w = WindowData.PlayerStatus.Weight + p.value
						local mw = WindowData.PlayerStatus.MaxWeight - 10	
						if (w >= mw) then
							color = {r=255, g=0, b=0}
						end
					end
				end
				local params = {}
				for key, value in pairs(ItemProperties.CurrentBaseData.ExpandedProps[prop.tid]) do
					if type(key) == "number" then
						table.insert(params, value)
					end
				end
				params[1] = StringUtils.AddCommasToNumber(params[1])
				prop.raw = FormatProperly(ReplaceTokens(GetStringFromTid(prop.tid), params ))
			elseif prop.tid == 1043304 then -- Price: ~1_COST~
				color = Interface.Settings.Props_ENGRAVE_COLOR
			elseif prop.tid == 1060403 or prop.tid == 1060448 or prop.tid == 1080361 or prop.tid == 1060448 or prop.tid == 1153735 then  -- physical damage/resistance ~1_val~%
				color = Interface.Settings.PHYSICAL
			elseif prop.tid == 1060405 or prop.tid == 1060447 or prop.tid == 1080362 or prop.tid == 1060448 or prop.tid == 1153737 then  -- fire damage/resistance ~1_val~%
				color = Interface.Settings.FIRE
			elseif prop.tid == 1060404 or prop.tid == 1060445 or prop.tid == 1080363 or prop.tid == 1060448 or prop.tid == 1153739 then  -- cold damage/resistance ~1_val~%
				color = Interface.Settings.COLD
			elseif prop.tid == 1060406 or prop.tid == 1060449 or prop.tid == 1080364 or prop.tid == 1060448 or prop.tid == 1153736 then  -- poison damage/resistance ~1_val~%
				color = Interface.Settings.POISON
			elseif prop.tid == 1060407 or prop.tid == 1060446 or prop.tid == 1080365 or prop.tid == 1060448 or prop.tid == 1153738 then  -- energy damage/resistance ~1_val~%
				color = Interface.Settings.ENERGY
			elseif prop.tid == 1072846 then  -- chaos damage ~1_val~%
				color = Interface.Settings.Chaos
			elseif (prop.value and prop.value < 0) or prop.tid == 1049643 or prop.tid == 1116209 or prop.tid == 1152714 or prop.tid == 1154910 or prop.tid == 1154910  or prop.tid == 1154909  or prop.tid == 1155420 then -- cursed, brittle, antique, prized, unwieldly, massive or negative value
				color = {r=255, g=0, b=0}
			elseif prop.intensity and tonumber(prop.intensity) and Interface.Settings.IntensInfo then
				local r, g, b = ItemProperties.GetIntensityColor(prop.intensity)
				color = {r=r, g=g, b=b}
			elseif ItemPropertiesInfo.ExpansionProperties[prop.tid] and not Interface.ActiveAccountFeatures[ItemPropertiesInfo.ExpansionProperties[prop.tid]] then
				color = {r=255, g=0, b=0}
			end
			
			if (not color or not color.r or not color.g or not color.b) then
				if (ItemProperties.CurrentItemData.itemType ~= WindowData.ItemProperties.TYPE_MOBILE) then
					color = Interface.Settings.Props_MAGICPROP_COLOR
				else
					color = Interface.Settings.Props_BODY_COLOR
				end
			end
			
			LabelSetTextColor(labelName, color.r, color.g, color.b)
			
			local text = FormatProperly(prop.raw)
			if Interface.Settings.ShowCaps then
				if prop.trueCap then
					text = text .. L" (" ..ReplaceTokens(GetStringFromTid(49), {wstring.format(L"%.0f", prop.trueCap)}) .. L")"
				elseif prop.cap then
					text = text .. L" (" ..ReplaceTokens(GetStringFromTid(49), {wstring.format(L"%.0f", prop.cap)}) .. L")"
				end
			end
			LabelSetText(labelName, text)
			WindowSetScale(labelName, scale)
			
			w, h = LabelGetTextDimensions(labelName)
			lblhgt = h + 5.2
			
			if (numLabels == 1) then
				lblhgt = lblhgt + 5
			else
				WindowClearAnchors( labelName )
				local anchor = "ItemPropertiesItemLabel"..numLabels-1
				if (numLabels==2) then
					anchor = "ItemPropertiesItemLabelspace"
				end
				if (font == ItemProperties.GetFont("small")) then
					lblhgt = h + 7
					
					WindowAddAnchor(labelName, "bottom", anchor, "top", 0, 7)
				else
					lblhgt = h + 5
					WindowAddAnchor(labelName, "bottom", anchor, "top", 0, 5)
				end
			end
			propWindowWidth = math.max(propWindowWidth, w)
			propWindowHeight = propWindowHeight + lblhgt -- Allow for spacing
			WindowSetShowing(labelName, true)
			
			numLabels = numLabels + 1
		end

		propWindowWidth = propWindowWidth + 12
		if (numLabels > 1) then
			propWindowHeight = propWindowHeight + 8 
		else
			propWindowHeight = propWindowHeight + 3
		end
		
		WindowSetScale(mainWindow, scale)
		WindowSetDimensions(mainWindow, propWindowWidth, propWindowHeight)
		ItemProperties.FollowMouse()
		if not WindowGetShowing(mainWindow) then
			WindowSetShowing("ItemPropertiesWindowBackground", true)
			WindowSetShowing("ItemPropertiesFrame", true)
			WindowSetShowing(mainWindow, true)
		end
		ItemProperties.loading = nil
	end
	
	
end

function ItemProperties.GetLabelColorForId(colors, id)
	if not colors or not id then
		return
	end
	local colorIdx = (id * 4) - 3
	return { r=colors[colorIdx+1], g=colors[colorIdx+2], b=colors[colorIdx+3]}
end

function ItemProperties.PopulateWindow(labelText,labelColors,labelFont)
	ItemProperties.ClearWindow()
	
	if (ItemProperties.CurrentItemData.itemType == WindowData.ItemProperties.TYPE_ITEM) then
		if not ItemProperties.CurrentBaseData or not ItemProperties.CurrentBaseData.ExpandedProps then
			ItemProperties.loading = nil
			return
		end
		
		if Interface.Settings.NewItemProperties then
			if ItemProperties.CurrentBaseData.GumpType == ItemPropertiesInfo.Types.Weapon or ItemProperties.CurrentBaseData.GumpType == ItemPropertiesInfo.Types.Ranged_Weapon then
				ItemProperties.ShowWeaponProps()
			elseif ItemProperties.CurrentBaseData.GumpType == ItemPropertiesInfo.Types.NoDamageWeapon then
				ItemProperties.ShowNoDamageWeaponProps()
			else
				ItemProperties.ShowOtherProps()
			end
		else
			ItemProperties.WallTextProps()
		end
		ItemProperties.loading = nil
		return
	elseif (ItemProperties.CurrentItemData.itemType == WindowData.ItemProperties.TYPE_MOBILE) then
		if not ItemProperties.CurrentBaseData or not ItemProperties.CurrentBaseData.ExpandedProps then
			ItemProperties.loading = nil
			return
		end
		if Interface.Settings.NewItemProperties then
			ItemProperties.ShowMobileProps()
		else
			ItemProperties.WallTextProps()
		end
		ItemProperties.loading = nil
		return
	end
	
	local itemColor = Interface.Settings.Props_TITLE_COLOR
	WindowSetTintColor("ItemProperties" .. "Frame", itemColor.r, itemColor.g, itemColor.b)
	if #labelText == 1 then
		labelColors[1] = Interface.Settings.Props_TITLE_COLOR
	end
	local scale = Interface.Settings.NewItemPropertiesScale
	
	local propWindowWidth = 100
	local propWindowHeight = 4
	
	local numLabels = #labelText
	
	local lblhgt = 0
	for i = 1, numLabels do
		labelName = "ItemPropertiesItemLabel"..i
		if i == 1 then
			CreateWindowFromTemplate(labelName, "ItemPropItemDef", "ItemProperties")
			WindowAddAnchor(labelName, "top", "ItemProperties", "top", 0, 5)
			
			if (numLabels > 1) then
				CreateWindowFromTemplate("ItemPropertiesItemLabelspace", "ItemPropItemDef", "ItemProperties")
				WindowAddAnchor("ItemPropertiesItemLabelspace", "bottom", labelName, "top", 0, -12)
				LabelSetText("ItemPropertiesItemLabelspace", L" ")
			end
			LabelSetFont(labelName, ItemProperties.GetFont("bold"), WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		else
			if not labelFont[i] then
				labelFont[i] = ItemProperties.GetFont("normal")
			end
			CreateWindowFromTemplate(labelName, "ItemPropItemDef", "ItemProperties")
			LabelSetFont(labelName, labelFont[i], WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		end
		LabelSetText(labelName, labelText[i])
		WindowSetScale(labelName, scale)
		LabelSetTextColor(labelName, labelColors[i].r, labelColors[i].g, labelColors[i].b)
		w, h = LabelGetTextDimensions(labelName)
		lblhgt = h + 5.2
		
		if (i == 1) then
			lblhgt = lblhgt + 5
		else
			WindowClearAnchors( labelName )
			local anchor = "ItemPropertiesItemLabel"..i-1
			if (i==2) then
				anchor = "ItemPropertiesItemLabelspace"
			end
			if (labelFont[i-1] == ItemProperties.GetFont("small")) then
				lblhgt = h + 7
				
				WindowAddAnchor(labelName, "bottom", anchor, "top", 0, 7)
			else
				lblhgt = h + 5
				WindowAddAnchor(labelName, "bottom", anchor, "top", 0, 5)
			end
		end
		propWindowWidth = math.max(propWindowWidth, w)
		propWindowHeight = propWindowHeight + lblhgt -- Allow for spacing
		WindowSetShowing(labelName, true)
	end
	propWindowWidth = propWindowWidth + 12
	if (numLabels > 1) then
		propWindowHeight = propWindowHeight + 8 
	else
		propWindowHeight = propWindowHeight + 3
	end
	
	WindowSetScale("ItemProperties", scale)
	WindowSetDimensions("ItemProperties", propWindowWidth, propWindowHeight)
	ItemProperties.FollowMouse()
	if not WindowGetShowing("ItemProperties") then
		WindowSetShowing("ItemPropertiesWindowBackground", true)
		WindowSetShowing("ItemPropertiesFrame", true)
		WindowSetShowing("ItemProperties", true)
	end

	ItemProperties.loading = nil
end

function ItemProperties.MobileParsing()
	local props, count = ItemProperties.BuildParamsArray( WindowData.ItemProperties[0], true )
	if not props or count == 0 then
		ItemProperties.loading = nil
		return
	end
	for tid, params in pairs(props) do
		local idx = ItemProperties.GetPropertyIndex(WindowData.ItemProperties[0], tid)
		local raw = WindowUtils.translateMarkup(WindowData.ItemProperties[0].PropertiesList[idx])
		if type(props[tid]) == "string" then
			props[tid] = {}
		end
		if props[tid][1] then
			props[tid].value = tonumber(tostring(props[tid][1]))
		end
		props[tid].raw = raw
		props[tid].index = idx
	end
	
	if not IsMobileInvulnerable(ItemProperties.CurrentBaseData.mobileId) then

		local mobileId = ItemProperties.CurrentBaseData.mobileId

		-- is the mobile status available?
		if not Interface.VerifyMobileData(mobileId, WindowData.MobileStatus[mobileId]) then

			-- register the bar again
			Interface.GetMobileData(mobileId)
		end

		-- current mobile data record
		local mobileStatus = Interface.ActiveMobilesOnScreen[mobileId]

		ItemProperties.CurrentBaseData.Life = {min=100; max=100;}

		if mobileStatus and mobileStatus.maxHealth then
			ItemProperties.CurrentBaseData.Life = {min=mobileStatus.curHealth; max=mobileStatus.maxHealth;}
		end
	end
	
	local selectedPet = AnimalLore.KnownPetsType[ItemProperties.CurrentBaseData.mobileId] ~= nil and AnimalLore.KnownPetsType[ItemProperties.CurrentBaseData.mobileId].typeID or 1

	local creatureData = CreaturesDB.FindCompatibleCreatures(ItemProperties.CurrentBaseData.mobileId, true)
	creatureData = creatureData[selectedPet]

	if ItemProperties.CurrentBaseData.hasPaperdoll and (not creatureData or IsPlayer(ItemProperties.CurrentBaseData.mobileId)) then
		
		local paperdollId = ItemProperties.CurrentBaseData.mobileId
		if not PaperdollWindow.ItemsProps[paperdollId] then
			PaperdollWindow.ScanProperties(paperdollId)
		end
		
		local paperdollData = PaperdollWindow.ItemsList[paperdollId]
		if not paperdollData then
			paperdollData = Interface.GetPaperdollData(paperdollId)
		end

		local idx = count + 1
		
		if PaperdollWindow.ItemsProps[paperdollId] then -- if the properties are not avaiable the player has to open the paperdoll manually
			for index = 1, paperdollData.numSlots  do
				local p = PaperdollWindow.ItemsProps[paperdollId][index]
				
				if (p) then
					for t, data in pairs(ItemPropertiesInfo.RefinementsResistProperties) do
						if p[t] then
							p[data.trueTid] = p[t]
						end
					end
					
					local tid = 1060448 -- physical res
					if p[tid] then
						if not props[tid] then
							props[tid] = {}
							props[tid].value = tonumber(p[tid][1])
						else
							if not props[tid].value then
								props[tid].value = 0
							end
							if p[tid][1] and tonumber(p[tid][1]) then
								props[tid].value = props[tid].value + tonumber(p[tid][1])
							end
						end
						props[tid].raw = FormatProperly(ReplaceTokens(GetStringFromTid(tid), {towstring(props[tid].value)}))
						props[tid].index = idx
						idx = idx + 1
					end
					
					tid = 1060447 -- fire res
					if p[tid] then 
						if not props[tid] then
							props[tid] = {}
							props[tid].value = tonumber(p[tid][1])
						else
							if not props[tid].value then
								props[tid].value = 0
							end
							if p[tid][1] and tonumber(p[tid][1]) then
								props[tid].value = props[tid].value + tonumber(p[tid][1])
							end
						end
						props[tid].raw = FormatProperly(ReplaceTokens(GetStringFromTid(tid), {towstring(props[tid].value)}))
						props[tid].index = idx
						idx = idx + 1
					end
					
					tid = 1060445 -- cold res
					if p[tid] then
						if not props[tid] then
							props[tid] = {}
							props[tid].value = tonumber(p[tid][1])
						else
							if not props[tid].value then
								props[tid].value = 0
							end
							if p[tid][1] and tonumber(p[tid][1]) then
								props[tid].value = props[tid].value + tonumber(p[tid][1])
							end
						end
						props[tid].raw = FormatProperly(ReplaceTokens(GetStringFromTid(tid), {towstring(props[tid].value)}))
						props[tid].index = idx
						idx = idx + 1
					end
					
					tid = 1060449 -- poison res
					if p[tid] then
						if not props[tid] then
							props[tid] = {}
							props[tid].value = tonumber(p[tid][1])
						else
							if not props[tid].value then
								props[tid].value = 0
							end
							if p[tid][1] and tonumber(p[tid][1]) then
								props[tid].value = props[tid].value + tonumber(p[tid][1])
							end
						end
						props[tid].raw = FormatProperly(ReplaceTokens(GetStringFromTid(tid), {towstring(props[tid].value)}))
						props[tid].index = idx
						idx = idx + 1
					end
					
					tid = 1060446 -- energy res
					if p[tid] then
						if not props[tid] then
							props[tid] = {}
							props[tid].value = tonumber(p[tid][1])
						else
							if not props[tid].value then
								props[tid].value = 0
							end
							if p[tid][1] and tonumber(p[tid][1]) then
								props[tid].value = props[tid].value + tonumber(p[tid][1])
							end
						end
						props[tid].raw = FormatProperly(ReplaceTokens(GetStringFromTid(tid), {towstring(props[tid].value)}))
						props[tid].index = idx
						idx = idx + 1
					end
					
					if p[1153734] then -- dci (refinements)
						p[1060408] = p[1153734]
					end
					
					tid = 1060408 -- dci
					if p[tid] then
						if not props[tid] then
							props[tid] = {}
							props[tid].value = tonumber(p[tid][1])
						else
							if not props[tid].value then
								props[tid].value = 0
							end
							if p[tid][1] and tonumber(p[tid][1]) then
								props[tid].value = props[tid].value + tonumber(p[tid][1])
							end
						end
						props[tid].raw = FormatProperly(ReplaceTokens(GetStringFromTid(tid), {towstring(props[tid].value)}))
						props[tid].index = idx
						idx = idx + 1
					end
					
					tid = 1060415 -- hci
					if p[tid] then
						if not props[tid] then
							props[tid] = {}
							props[tid].value = tonumber(p[tid][1])
						else
							if not props[tid].value then
								props[tid].value = 0
							end
							if p[tid][1] and tonumber(p[tid][1]) then
								props[tid].value = props[tid].value + tonumber(p[tid][1])
							end
						end
						props[tid].raw = FormatProperly(ReplaceTokens(GetStringFromTid(tid), {towstring(props[tid].value)}))
						props[tid].index = idx
						idx = idx + 1
					end
					
					tid = 1060411 -- ep
					if p[tid] then
						if not props[tid] then
							props[tid] = {}
							props[tid].value = tonumber(p[tid][1])
						else
							if not props[tid].value then
								props[tid].value = 0
							end
							if p[tid][1] and tonumber(p[tid][1]) then
								props[tid].value = props[tid].value + tonumber(p[tid][1])
							end
						end
						props[tid].raw = FormatProperly(ReplaceTokens(GetStringFromTid(tid), {towstring(props[tid].value)}))
						props[tid].index = idx
						idx = idx + 1
					end
					
					tid = 1060483 -- sdi
					if p[tid] then
						if not props[tid] then
							props[tid] = {}
							props[tid].value = tonumber(p[tid][1])
						else
							if not props[tid].value then
								props[tid].value = 0
							end
							if p[tid][1] and tonumber(p[tid][1]) then
								props[tid].value = props[tid].value + tonumber(p[tid][1])
							end
						end
						props[tid].raw = FormatProperly(ReplaceTokens(GetStringFromTid(tid), {towstring(props[tid].value)}))
						props[tid].index = idx
						idx = idx + 1
					end
					
					tid = 1060401 -- di
					if p[tid] then
						if not props[tid] then
							props[tid] = {}
							props[tid].value = tonumber(p[tid][1])
						else
							if not props[tid].value then
								props[tid].value = 0
							end
							if p[tid][1] and tonumber(p[tid][1]) then
								props[tid].value = props[tid].value + tonumber(p[tid][1])
							end
						end
						props[tid].raw = FormatProperly(ReplaceTokens(GetStringFromTid(tid), {towstring(props[tid].value)}))
						props[tid].index = idx
						idx = idx + 1
					end
					
					tid = 1060402 -- di
					if p[tid] then
						if not props[tid] then
							props[tid] = {}
							props[tid].value = tonumber(p[tid][1])
						else
							if not props[tid].value then
								props[tid].value = 0
							end
							if p[tid][1] and tonumber(p[tid][1]) then
								props[tid].value = props[tid].value + tonumber(p[tid][1])
							end
						end
						props[tid].raw = FormatProperly(ReplaceTokens(GetStringFromTid(tid), {towstring(props[tid].value)}))
						props[tid].index = idx
						idx = idx + 1
					end
					
					tid = 1060433 -- lmc
					if p[tid] then
						
						if not props[tid] then
							props[tid] = {}
							props[tid].value = tonumber(p[tid][1])
						else
							if not props[tid].value then
								props[tid].value = 0
							end
							if p[tid][1] and tonumber(p[tid][1]) then
								props[tid].value = props[tid].value + tonumber(p[tid][1])
							end
						end
						props[tid].raw = FormatProperly(ReplaceTokens(GetStringFromTid(tid), {towstring(props[tid].value)}))
						props[tid].index = idx
						idx = idx + 1
					end
					
					tid = 1060486 -- ssi
					if p[tid] and tonumber(p[tid][1]) then
						if not props[tid] then
							props[tid] = {}
							props[tid].value = tonumber(p[tid][1])
						else
							if not props[tid].value then
								props[tid].value = 0
							end
							if p[tid][1] and tonumber(p[tid][1]) then
								props[tid].value = props[tid].value + tonumber(p[tid][1])
							end
						end
						props[tid].raw = FormatProperly(ReplaceTokens(GetStringFromTid(tid), {towstring(props[tid].value)}))
						props[tid].index = idx
						idx = idx + 1
					end
									
				end
			end
		end
	elseif (creatureData ~= nil) then
	
		local idx = count + 1
		
		ItemProperties.CurrentBaseData.CurrentCreature = creatureData
		if ItemProperties.CurrentBaseData.CurrentCreature.tamable then
			ItemProperties.CurrentBaseData.hasPaperdoll = false
		end
		local stats
		if (KnownAreas[MapCommon.CurrentArea] and 
			KnownAreas[MapCommon.CurrentArea].SubAreas[MapCommon.CurrentSubArea] and
			KnownAreas[MapCommon.CurrentArea].SubAreas[MapCommon.CurrentSubArea].LocalStats) then
			stats = KnownAreas[MapCommon.CurrentArea].SubAreas[MapCommon.CurrentSubArea].LocalStats
		else
			stats = creatureData
		end
		ItemProperties.CurrentBaseData.LocalStats = stats
		ItemProperties.CurrentBaseData.BardDiff = stats.barddiff
		
		-- physical res
		props[1060448] = {range=stats.physical.range; index = idx;}
		idx = idx + 1
		if AnimalLore.KnownPetsType[ItemProperties.CurrentBaseData.mobileId] then
			props[1060448].value = AnimalLore.KnownPetsType[ItemProperties.CurrentBaseData.mobileId].Physical
		end

		-- fire res
		props[1060447] = {range=stats.fire.range; index = idx;}
		idx = idx + 1
		if AnimalLore.KnownPetsType[ItemProperties.CurrentBaseData.mobileId] then
			props[1060447].value = AnimalLore.KnownPetsType[ItemProperties.CurrentBaseData.mobileId].Fire
		end
		
		-- cold res
		props[1060445] = {range=stats.cold.range; index = idx;}
		idx = idx + 1
		if AnimalLore.KnownPetsType[ItemProperties.CurrentBaseData.mobileId] then
			props[1060445].value = AnimalLore.KnownPetsType[ItemProperties.CurrentBaseData.mobileId].Cold
		end
		
		-- poison res
		props[1060449] = {range=stats.poison.range; index = idx;}
		idx = idx + 1
		if AnimalLore.KnownPetsType[ItemProperties.CurrentBaseData.mobileId] then
			props[1060449].value = AnimalLore.KnownPetsType[ItemProperties.CurrentBaseData.mobileId].Poison
		end
		
		-- energy res
		props[1060446] = {range=stats.energy.range; index = idx;}
		idx = idx + 1
		if AnimalLore.KnownPetsType[ItemProperties.CurrentBaseData.mobileId] then
			props[1060446].value = AnimalLore.KnownPetsType[ItemProperties.CurrentBaseData.mobileId].Energy
		end
		
		
		local superSlayers = ""
		local slayers = ""
		local oppSlayers = L""
		local cL = creatureData.slayers
		
		for i, opp in pairsByIndex(creatureData.oppositeslayers) do
			wstring.appendWithSeparator(oppSlayers, opp, ", ")
		end

		if creatureData.slayers and creatureData.slayers[1] ~= L"None" then
			for tid, data in pairs(ItemPropertiesInfo.Slayers) do
				for i=1, #cL do
					if data.stringName == string.lower(tostring(cL[i])) then
						if data.super then
							if string.len(superSlayers) == 0 then
								superSlayers = tostring(cL[i])
							else
								superSlayers = superSlayers .. ", " .. tostring(cL[i])
							end
						else
							if string.len(slayers) == 0 then
								slayers = tostring(cL[i])
							else
								slayers = slayers .. ", " .. tostring(cL[i])
							end
						end
						break
					end
				end
			end
			
			local activeSuperSlayer = false
			for tid, buffId in pairs(Interface.ActiveSuperSlayers) do
				local data = ItemPropertiesInfo.Slayers[tid]
				for i=1, #cL do
					if data.stringName == string.lower(tostring(cL[i])) then
						activeSuperSlayer = true
						break
					end
				end
			end
			
			local activeSlayer = false
			for tid, buffId in pairs(Interface.ActiveSlayers) do
				local data = ItemPropertiesInfo.Slayers[tid]
				for i=1, #cL do
					if data.stringName == string.lower(tostring(cL[i])) then
						activeSlayer = true
						break
					end
				end
			end
			
			
			if string.len(superSlayers) > 0 then
				props[1] = {}
				props[1].raw = ReplaceTokens(GetStringFromTid(126), {towstring(superSlayers)})
				props[1].index = idx
				idx = idx + 1
				props[1].activeSlayer = activeSuperSlayer
			end
			
			if string.len(slayers) > 0 then
				props[2] = {}
				props[2].raw = ReplaceTokens(GetStringFromTid(127), {towstring(slayers)})
				props[2].index = idx
				idx = idx + 1
				props[2].activeSlayer = activeSlayer
			end
		end
		
		if wstring.len(oppSlayers) > 0 and oppSlayers ~= L"None" then
			local activeOpposite = false
			for tid, buffId in pairs(Interface.ActiveOppositeSlayers) do
				local data = ItemPropertiesInfo.Slayers[tid]
				for i=1, #cL do
					if data.stringName == string.lower(cL[i]) then
						activeOpposite = true
						break
					end
				end
			end

			props[3] = {}
			props[3].raw = ReplaceTokens(GetStringFromTid(128), {towstring(oppSlayers)})
			props[3].index = idx + 1
			props[3].activeOpposite = activeOpposite
		end
	end

	ItemProperties.CurrentBaseData.ExpandedProps = props
	ItemProperties.PopulateWindow()
end

function ItemProperties.ItemParsing(extendedProps)
	if not extendedProps then
		ItemProperties.loading = nil
		return
	end

	ItemProperties.CurrentBaseData.Artifact = ItemProperties.IsArtifact(extendedProps)
	ItemProperties.CurrentBaseData.Set = ItemProperties.IsSet(extendedProps)
	
	ItemProperties.CurrentBaseData.TwoHanded = nil
	ItemProperties.CurrentBaseData.WeaponDamageData = nil
	ItemProperties.CurrentBaseData.WeaponSpeed = nil
	ItemProperties.CurrentBaseData.WeaponDPS = nil
	ItemProperties.CurrentBaseData.Special1 = nil
	ItemProperties.CurrentBaseData.Special2 = nil
	ItemProperties.CurrentBaseData.Engrave = nil
	ItemProperties.CurrentBaseData.SellerDesc = nil
	
	if ItemProperties.CurrentBaseData.layer == 10 then
		ItemProperties.CurrentBaseData.TwoHanded = true
	end
	if ItemProperties.CurrentBaseData.GumpType == ItemPropertiesInfo.Types.Weapon and not extendedProps[1061168] then -- weapon damage ~1_val~ - ~2_val~
		ItemProperties.CurrentBaseData.GumpType = ItemPropertiesInfo.Types.NoDamageWeapon
	end

	if (ItemProperties.CurrentBaseData.GumpType == ItemPropertiesInfo.Types.Weapon or ItemProperties.CurrentBaseData.GumpType == ItemPropertiesInfo.Types.Ranged_Weapon) and extendedProps[1061167] then

		local speed = extendedProps[1061167][1] -- weapon speed ~1_val~
		speed = tostring(wstring.gsub(speed, L"s", L""))
		speed = tonumber(speed)
		local ssi = 0
		if extendedProps[1060486] then -- swing speed increase +~1_val~
			ssi = tostring(extendedProps[1060486][1])
			ssi = tonumber(ssi)
		end
		
		local mindmg, maxdmg, avgdmg = 0
		
		if extendedProps[1061168] then -- weapon damage ~1_val~ - ~2_val~
			mindmg = tostring(tonumber(extendedProps[1061168][1]))
			maxdmg = tostring(tonumber(extendedProps[1061168][2]))
			avgdmg = (mindmg + maxdmg) / 2
		end
		
		local stamTicks = 0 -- we consider only the base weapon speed. This value is the player stamina.
		
		local actualspeed = math.max(1.25, math.floor((speed * 4 - stamTicks) * (100 / (100 + ssi)))/4)
		ItemProperties.CurrentBaseData.WeaponDamageData = {min=mindmg; max=maxdmg; speed=speed; ssi=ssi;}
		ItemProperties.CurrentBaseData.WeaponSpeed = actualspeed
		ItemProperties.CurrentBaseData.WeaponDPS = avgdmg / speed
		
		if extendedProps[1061171] then -- two-handed weapon
			ItemProperties.CurrentBaseData.TwoHanded = true
		end
		if not ItemProperties.CurrentBaseData.Special1 then
			for key, value in pairs(WindowData.WeaponAbilityDataCSV) do
				
				if value.objectId == ItemProperties.CurrentBaseData.objType then
					special1 = value.primaryId  + CharacterAbilities.WEAPONABILITY_OFFSET
					local icon, serverId, tid, desctid, weapons = GetAbilityData(special1)
					
					local iconTexture, x, y = GetIconData(icon)
					ItemProperties.CurrentBaseData.Special1 = {texture=iconTexture, x=x, y=y}
					
					
					special2 = value.secondaryId  + CharacterAbilities.WEAPONABILITY_OFFSET
					icon, serverId, tid, desctid, weapons = GetAbilityData(special2)
					
					iconTexture, x, y = GetIconData(icon)
					ItemProperties.CurrentBaseData.Special2 = {texture=iconTexture, x=x, y=y}
					
				end
			end
		end
	end
	
	if extendedProps[1072305] then  -- Engraved: ~1_INSCRIPTION~
		ItemProperties.CurrentBaseData.Engrave = extendedProps[1072305][1]
		
		if extendedProps[1043305] then -- Seller's Description: "~1_DESC~"
			ItemProperties.CurrentBaseData.Engrave = ItemProperties.CurrentBaseData.Engrave .. L"\n" .. extendedProps[1043305][1]
		end
		
	elseif extendedProps[1043305] then -- Seller's Description: "~1_DESC~"
		ItemProperties.CurrentBaseData.Engrave = extendedProps[1043305][1]
		
	elseif extendedProps[1070722] and extendedProps[1070722][1] and wstring.len(extendedProps[1070722][1]) > 0 then -- ~1_NOTHING~ (runebook name)
		ItemProperties.CurrentBaseData.Engrave = extendedProps[1070722][1]
	
	elseif extendedProps[1062613] then -- "~1_NAME~" (weapon/armor engrave)
		local possibleTid = extendedProps[1062613][1] 
		if wstring.find(possibleTid, L"#", 1, true) == 1 then
			possibleTid = tostring(wstring.gsub(possibleTid, L"#", L""))
			if tonumber(possibleTid) and GetStringFromTid(tonumber(possibleTid)) then
				ItemProperties.CurrentBaseData.Engrave = GetStringFromTid(tonumber(possibleTid))
			end
		else
			ItemProperties.CurrentBaseData.Engrave = extendedProps[1062613][1] 
		end
		
	end
		
	if not ItemProperties.CurrentBaseData.Material then
		ItemProperties.CurrentBaseData.Material = 0
	
		for tid, params in pairs(extendedProps) do
			if ItemPropertiesInfo.Materials[tid] then
				ItemProperties.CurrentBaseData.Material = ItemPropertiesInfo.Materials[tid].baseName
				break
			end
		end
	end

	if ItemProperties.CurrentBaseData.Material == 0 then
		if ItemProperties.CurrentBaseData.materialKind == ItemPropertiesInfo.MATERIAL_METAL then
			ItemProperties.CurrentBaseData.Material = 1053109
		elseif ItemProperties.CurrentBaseData.materialKind == ItemPropertiesInfo.MATERIAL_LEATHER then
			ItemProperties.CurrentBaseData.Material = 1049353
		elseif ItemProperties.CurrentBaseData.materialKind == ItemPropertiesInfo.MATERIAL_WOOD then
			ItemProperties.CurrentBaseData.Material = 1021824
		end
	end
	if not ItemProperties.CurrentBaseData.stereotype then
		if not ItemProperties.CurrentBaseData.layer then
			ItemProperties.CurrentBaseData.stereotype = ItemPropertiesInfo.Misc
		end
		
		local bosskey = false
		for tid,_ in pairs(ItemPropertiesInfo.BossKeysDB) do
			if extendedProps[tid] then
				bosskey = true
				break
			end
		end
		if ItemPropertiesInfo.ForcedStereotypeDB[ItemProperties.CurrentBaseData.objType] then
			ItemProperties.CurrentBaseData.stereotype = ItemPropertiesInfo.ForcedStereotypeDB[ItemProperties.CurrentBaseData.objType]
		elseif ItemPropertiesInfo.ReagentsDB[ItemProperties.CurrentBaseData.objType] then
			ItemProperties.CurrentBaseData.stereotype = ItemPropertiesInfo.Reagents
		elseif ItemPropertiesInfo.MusicalInstrumentsDB[ItemProperties.CurrentBaseData.objType] then
			ItemProperties.CurrentBaseData.stereotype = ItemPropertiesInfo.MusicalInstrument
		elseif ItemPropertiesInfo.IsTool(ItemProperties.CurrentBaseData.objType) then
			ItemProperties.CurrentBaseData.stereotype = ItemPropertiesInfo.CraftingTool
		elseif IsContainer(ItemProperties.CurrentBaseData.objectId) then
			ItemProperties.CurrentBaseData.stereotype = ItemPropertiesInfo.Container
		elseif ItemPropertiesInfo.IsCraftingMaterial(ItemProperties.CurrentBaseData.objType) then
			ItemProperties.CurrentBaseData.stereotype = ItemPropertiesInfo.CraftingMaterial
		elseif bosskey then
			ItemProperties.CurrentBaseData.stereotype = ItemPropertiesInfo.BossKey
		elseif ItemProperties.CurrentBaseData.objType == 3821 or ItemProperties.CurrentBaseData.objType == 3824 or extendedProps[1041361] then -- a bank check
			ItemProperties.CurrentBaseData.stereotype = ItemPropertiesInfo.Coins
		end
	end
	
	if ItemProperties.CurrentBaseData.GumpType == ItemPropertiesInfo.Types.Bod_Smith or ItemProperties.CurrentBaseData.GumpType == ItemPropertiesInfo.Types.Bod_Tailor then
		ItemProperties.GetBodInfo(ItemProperties.CurrentBaseData.objectId, extendedProps, true)
	else
		ItemProperties.GetEquippedData()
		if extendedProps[1022473] and extendedProps[1076255] then -- small crate and no-trade
			ItemProperties.GetCrateFishInfo(extendedProps)
		else
			ItemProperties.GetItemIntensity(ItemProperties.CurrentBaseData.objectId, extendedProps, true)
		end
	end
	
	ItemProperties.PopulateWindow()
end

function ItemProperties.ActionParsing()
	local labelText = {}
	local labelColors = {}
	local labelFont = {}
	
	-- first get its location if it has one and set the subindex to 0 by default
	local itemLoc = ItemProperties.CurrentItemData.itemLoc
	if (itemLoc ~= nil and itemLoc.subIndex == nil) then
		itemLoc.subIndex = 0
	end
	local id = WindowData.ItemProperties.CurrentHover
	local i = 0

	if (ItemProperties.CurrentItemData.actionType == SystemData.UserAction.TYPE_SKILL) then
		local skillId = id - 1
		
		-- translate the server id into a row into the ability csv
		local abilityId = CSVUtilities.getRowIdWithColumnValue(WindowData.SkillsCSV, "ServerId", skillId)

		labelText[1] = GetStringFromTid(WindowData.SkillsCSV[abilityId].NameTid)
		labelColors[1] = Interface.Settings.Props_TITLE_COLOR
		labelFont[1] = ItemProperties.GetFont("bold")

		local detailTid = WindowData.SkillsCSV[abilityId].DescriptionTid
		if (detailTid ~= nil and ItemProperties.CurrentItemData.detail == ItemProperties.DETAIL_LONG) then
			labelText[2] = GetStringFromTid(detailTid)
			labelColors[2] = Interface.Settings.Props_BODY_COLOR 	
			labelFont[2] = ItemProperties.GetFont("normal")
		end
	elseif (ItemProperties.CurrentItemData.actionType == SystemData.UserAction.TYPE_SPELL) then
	
		local icon, serverId, tid, desctid = GetAbilityData(id)

		if (desctid ~= nil and ItemProperties.CurrentItemData.detail == ItemProperties.DETAIL_LONG) then
			if (tid ~= nil) then
				i = i + 1
				labelText[i] = GetStringFromTid(tid)
				labelColors[i] = Interface.Settings.Props_TITLE_COLOR	
				labelFont[i] = ItemProperties.GetFont("bold")	
			end				
			i = i + 1
			labelText[i] = GetStringFromTid(desctid)
			labelColors[i] = Interface.Settings.Props_BODY_COLOR 	
			labelFont[i] = ItemProperties.GetFont("normal")
		elseif (tid ~= nil) then
			i = i + 1
			labelText[i] = GetStringFromTid(tid)
			labelColors[i] = Interface.Settings.Props_TITLE_COLOR	
			labelFont[i] = ItemProperties.GetFont("bold")	
		end		
		
		if (ItemProperties.CurrentItemData.body ~= nil and ItemProperties.CurrentItemData.body ~= L"") then
			i = i + 1
			labelText[i] = WindowUtils.translateMarkup(ItemProperties.CurrentItemData.body)
			labelColors[i] = Interface.Settings.Props_BODY_COLOR 
			labelFont[i] = ItemProperties.GetFont("normal")	
		end
	elseif (ItemProperties.CurrentItemData.actionType == SystemData.UserAction.TYPE_INVOKE_VIRTUE) then

		local nameTid = ItemProperties.VirtueData[id].nameTid
		local detailTid = ItemProperties.VirtueData[id].detailTid

		if (nameTid ~= nil and nameTid ~= 0) then
			i = i +1
			labelText[i] = GetStringFromTid(nameTid)	
			labelColors[i] = Interface.Settings.Props_TITLE_COLOR
			labelFont[i] = ItemProperties.GetFont("bold")
		end
		if (detailTid ~= nil and detailTid ~= 0) then
			i = i +1
			labelText[i] = GetStringFromTid(detailTid)
			labelColors[i] = Interface.Settings.Props_BODY_COLOR 	
			labelFont[i] = ItemProperties.GetFont("normal")
		end
	elseif (ItemProperties.CurrentItemData.actionType == SystemData.UserAction.TYPE_WEAPON_ABILITY) then
		if (EquipmentData.CurrentWeaponAbilities[id] ~= nil and EquipmentData.CurrentWeaponAbilities[id] ~= 0) then
			local abilityId = EquipmentData.CurrentWeaponAbilities[id] + EquipmentData.WEAPONABILITY_ABILITYOFFSET
			local icon, serverId, tid, desctid = GetAbilityData(abilityId)

			-- Always show the ability name
			if (tid ~= nil) then
				i = i +1
				labelText[i] = GetStringFromTid(tid)
				labelColors[i] = Interface.Settings.Props_TITLE_COLOR
				labelFont[i] = ItemProperties.GetFont("bold")
			end

			if (desctid ~= nil and ItemProperties.CurrentItemData.detail == ItemProperties.DETAIL_LONG) then
				i = i +1
				labelText[i] = GetStringFromTid(desctid)	
				labelColors[i] = Interface.Settings.Props_BODY_COLOR 	
				labelFont[i] = ItemProperties.GetFont("normal")		
			end
		end
	elseif (ItemProperties.CurrentItemData.actionType == SystemData.UserAction.TYPE_RACIAL_ABILITY) then

		local iconId = UserActionGetIconId(itemLoc.hotbarId, itemLoc.itemIndex, itemLoc.subIndex)
		local icon, serverId, tid, desctid = GetAbilityData(iconId)
		if (desctid ~= nil and ItemProperties.CurrentItemData.detail == ItemProperties.DETAIL_LONG) then
			if (tid ~= nil) then
				i = i + 1
				labelText[i] = GetStringFromTid(tid)
				labelColors[i] = Interface.Settings.Props_TITLE_COLOR	
				labelFont[i] = ItemProperties.GetFont("bold")	
			end				
			i = i + 1
			labelText[i] = GetStringFromTid(desctid)
			labelColors[i] = Interface.Settings.Props_BODY_COLOR 
			labelFont[i] = ItemProperties.GetFont("normal")		
		elseif (tid ~= nil) then
			i = i + 1
			labelText[i] = GetStringFromTid(tid)
			labelColors[i] = Interface.Settings.Props_TITLE_COLOR
			labelFont[i] = ItemProperties.GetFont("bold")			
		end		
		
		if (ItemProperties.CurrentItemData.body ~= nil and ItemProperties.CurrentItemData.body ~= L"") then
			i = i + 1
			labelText[i] = WindowUtils.translateMarkup(ItemProperties.CurrentItemData.body)
			labelColors[i] = Interface.Settings.Props_BODY_COLOR 
			labelFont[i] = ItemProperties.GetFont("normal")	
		end
	elseif (ItemProperties.CurrentItemData.actionType == SystemData.UserAction.TYPE_USE_OBJECTTYPE) then
		
		item = Interface.GetObjectQuantityData(ItemProperties.CurrentItemData.itemId)
		if (item ~= nil) then
			if (item.name ~= nil and item.name ~= L"") then
				local itemName = Shopkeeper.stripFirstNumber(item.name)
			    labelText[1] = item.quantity..L" "..itemName
			    labelColors[1] = Interface.Settings.Props_TITLE_COLOR	
			    labelFont[i] = ItemProperties.GetFont("bold")	
			end
		end
		
	elseif (ItemProperties.CurrentItemData.actionType == SystemData.UserAction.TYPE_PLAYER_STATS) then
		local name = CharacterSheet.GetStatNameById(id)
		tid = CharacterSheet.AttributesDef[name].tid
		local text
		if tid then
			text = GetStringFromTid(tid)
		else
			text = CharacterSheet.AttributesDef[name].stringText
		end
		
		text = wstring.gsub(ReplaceTokens(text, {L""}), L"%%", L"")
		text = wstring.gsub(ReplaceTokens(text, {L""}), L":", L"")
		
		detailTid = CharacterSheet.AttributesDef[name].descTid
		local params = L""
		if (  (name == "Britain" or		
				name == "Jhelom" or		
				name == "Minoc" or			
				name == "Moonglow" or		
				name == "NewMagincia" or	
				name == "SkaraBrae" or		
				name == "Trinsic" or		
				name == "Vesper" or		
				name == "Yew") and	
				CharacterSheet.cityLoyaltyBlock) then
				
			 detailTid = 1152886 --  You recently renounced citizenship, so you must wait
			 params = CharacterSheet.cityLoyaltyBlock
		end
		local dText 
		if detailTid then
			dText = ReplaceTokens(GetStringFromTid(detailTid), {params})
		else
			dText = CharacterSheet.AttributesDef[name].stringDesc
		end
		i = i + 1
		labelText[i] = text
		labelColors[i] = Interface.Settings.Props_TITLE_COLOR
		labelFont[i] = ItemProperties.GetFont("bold")
	
		if not dText and CharacterSheet.AttributesDef[name].bonus then
			local bonus = CharacterSheet.AttributesDef[name].bonus
			dText = WindowData.PlayerStatus[bonus]
		end
		
		if dText then
			i = i + 1
			labelText[i] = dText
			labelColors[i] = Interface.Settings.Props_BODY_COLOR 	
			labelFont[i] = ItemProperties.GetFont("normal")	
		end
	else

		if ActionsWindow.isAction(ItemProperties.CurrentItemData.actionType) then
			local actionData = ActionsWindow.ActionData[id]
		
			--[[
			if ItemProperties.CurrentItemData.isPlayerDefinedCommandAction then
				id = 57
				actionData = ActionsWindow.GetActionDataForID(id)
			else
				if id and id ~= 0 and ItemProperties.CurrentItemData.windowName == "ActionWindow" then
					actionData = ActionsWindow.GetActionDataForID(id)
				else
					actionData = ActionsWindow.GetActionDataForType(ItemProperties.CurrentItemData.actionType)
				end
			end
			--]]

			local i = 0
			if (actionData ~= nil) then
				if (actionData.nameTid ~= nil and actionData.nameTid ~= 0) then
					i = i + 1
					labelText[i] = GetStringFromTid(actionData.nameTid)
					labelColors[i] = Interface.Settings.Props_TITLE_COLOR	
					labelFont[i] = ItemProperties.GetFont("bold")
				end
				if (actionData.detailTid ~= nil and actionData.detailTid ~= 0 and ItemProperties.CurrentItemData.detail == ItemProperties.DETAIL_LONG) then
					i = i + 1
					labelText[i] = GetStringFromTid(actionData.detailTid)
					labelColors[i] = Interface.Settings.Props_BODY_COLOR 	
					labelFont[i] = ItemProperties.GetFont("normal")	
				end						
			end
			-- add aditional information if the action has a hotbar location
			if (itemLoc ~= nil) then
				if (UserActionIsSpeechType(itemLoc.hotbarId, itemLoc.itemIndex, itemLoc.subIndex)) then
					local speechText = UserActionSpeechGetText(itemLoc.hotbarId, itemLoc.itemIndex, itemLoc.subIndex)
					if (speechText ~= L"") then
						i = i + 1
						labelText[i] = speechText
						labelColors[i] = Interface.Settings.Props_BODY_COLOR 
						labelFont[i] = ItemProperties.GetFont("normal")	
					end
				elseif (ItemProperties.CurrentItemData.actionType == SystemData.UserAction.TYPE_DELAY) then
					local delay = UserActionDelayGetDelay(itemLoc.hotbarId, itemLoc.itemIndex, itemLoc.subIndex)
					if delay then
						i = i + 1
						labelText[i] = wstring.format(L"%.3f",delay)
						labelColors[i] = Interface.Settings.Props_BODY_COLOR 
						labelFont[i] = ItemProperties.GetFont("normal")	
					end
				end
			end
		end
	end
	labelFont[1] = ItemProperties.GetFont("bold")
	return labelText, labelColors, labelFont
end


function ItemProperties.WStringParsing()
	local labelText = {}
	local labelColors = {}
	local labelFont = {}
	local i = 0
	
	if (ItemProperties.CurrentItemData.title ~= nil and ItemProperties.CurrentItemData.title ~= L"") then
		i = i + 1
		labelText[i] = ItemProperties.CurrentItemData.title
		labelColors[i] = Interface.Settings.Props_TITLE_COLOR
		labelFont[i] = ItemProperties.GetFont("bold")
	end

	if (ItemProperties.CurrentItemData.body ~= nil and ItemProperties.CurrentItemData.body ~= L"") then
		i = i + 1
		labelText[i] = ItemProperties.CurrentItemData.body
		labelColors[i] = Interface.Settings.Props_BODY_COLOR
		labelFont[i] = ItemProperties.GetFont("normal")
	end
	return labelText, labelColors, labelFont
end

function ItemProperties.GetFont(style)
	if style == "normal" then
		return "MyriadPro_16"
	elseif style == "bold" then
		return  "Arial_Black_16"
	elseif style == "small" then
		return  "MyriadPro_Light_14"
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
	if (itemData == nil) then
		return
	end
	
	if itemData.itemId ~= ItemProperties.GetShowingId() then
		ItemProperties.Delta = 0
		WindowSetShowing("ItemProperties", false)
	end
	
	-- USE_ITEM actions are the same information as item
	if (itemData.actionType == SystemData.UserAction.TYPE_USE_ITEM) then
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
		ItemProperties.loading = nil
		return
	end

	for i = numHave + 1, numLabelsNeeded do
		labelName = "ItemPropertiesItemLabel"..i
		
		if i == 1 then
			CreateWindowFromTemplate(labelName, "ItemPropItemDef", "ItemProperties")
			WindowAddAnchor(labelName, "top", "ItemProperties", "top", 0, 3)
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
	local this = SystemData.ActiveWindow.name
	if GenericGump.CurrentOver ~= "" then
		return
	end
	if ContainerWindow.CurrentOver == this then
		return
	end
	--Debug.Print("ClearMouseOverItem")
	WindowData.ItemProperties.CurrentHover = 0
	WindowData.ItemProperties.CurrentType = WindowData.ItemProperties.TYPE_NONE
	ItemProperties.CurrentItemData = {}
	ItemProperties.CurrentBaseData = nil
	GenericGump.CurrentOver = ""
end

function ItemProperties.GetCurrentWindow()
    local windowName = nil
    if (ItemProperties.CurrentItemData ~= nil) then
        windowName = ItemProperties.CurrentItemData.windowName
    end
    
    return windowName
end

function ItemProperties.OnPlayerBackpackMouseover()

	if IsValidID(ContainerWindow.PlayerBackpack) then

		-- reset the window properties array (if different from the one last we have seen)
		pcall(ItemProperties.ResetWindowDataProperties, ContainerWindow.PlayerBackpack)

		local itemData = {
			windowName = SystemData.ActiveWindow.name,
			itemId = ContainerWindow.PlayerBackpack,
			itemType = WindowData.ItemProperties.TYPE_ITEM,
		}
		ItemProperties.SetActiveItem(itemData)
	end
end

function ItemProperties.IsSet(props)
	if not props then
		return false
	end
	if  props[1072378] or 	-- Only when full set is present:
		props[1080241] or 	-- Full Jewelry Set Present
		props[1072377] or 	-- Full Armor Set Present
		props[1073492] then -- Full Weapon/Armor Set Present
		
		return true
	end
	return false
end

function ItemProperties.IsArtifact(props)
	if not props then
		return false
	end
	if props[1061078] then -- artifact rarity ~1_val~
		return true
	else
		for tid, _ in pairs(props) do
			if (ArtifactsDB.Artifacts[tid]) then
				return true
			end
		end
	end
	
	return false
end

function ItemProperties.GetPropertyIndex(rawData, tid)
	if not rawData or not rawData.PropertiesTids then
		return
	end
	for i, t in pairsByKeys(rawData.PropertiesTids) do
		if rawData.PropertiesTids[i] == tid then
			return i
		end
	end
	return
end

-- Gets the data from the equipped item for the comparison
function ItemProperties.GetEquippedData()
	if not ItemProperties.CurrentBaseData.equipped then
		if not PaperdollWindow.ItemsProps[GetPlayerID()] then
			PaperdollWindow.ItemsCheck(GetPlayerID())
			ItemProperties.RegisterPaperdollProperties(GetPlayerID())
		end

		local objectId = PaperdollWindow.GetPaperdollSlotID(GetPlayerID(), ItemProperties.CurrentBaseData.layer)
		
		if not PaperdollWindow.ItemsProps[GetPlayerID()] then
			return
		end
		local props = PaperdollWindow.ItemsProps[GetPlayerID()][ItemProperties.CurrentBaseData.layer]
	
		if not props then
			return
		end
		
		ItemProperties.CurrentBaseData.EquippedData = {}
		ItemProperties.CurrentBaseData.EquippedData.props = props
		
		if props[1061167] then  -- weapon speed ~1_val~
			local speed = props[1061167][1] -- weapon speed ~1_val~
			speed = tostring(wstring.gsub(speed, L"s", L""))
			speed = tonumber(speed)
			local ssi = 0
			if props[1060486] then -- swing speed increase +~1_val~
				ssi = tostring(props[1060486][1])
				ssi = tonumber(ssi)
			end
			
			local mindmg, maxdmg, avgdmg = 0
			
			if props[1061168] then -- weapon damage ~1_val~ - ~2_val~
				mindmg = tostring(tonumber(props[1061168][1]))
				maxdmg = tostring(tonumber(props[1061168][2]))
				avgdmg = (mindmg + maxdmg) / 2
			end
			
			local stamTicks = 0 -- we consider only the base weapon speed. This value is the player stamina.
			
			local actualspeed = math.max(1.25, math.floor((speed * 4 - stamTicks) * (100 / (100 + ssi)))/4)
			ItemProperties.CurrentBaseData.EquippedData.WeaponDamageData = {min=mindmg; max=maxdmg; speed=speed; ssi=ssi;}
			ItemProperties.CurrentBaseData.EquippedData.WeaponSpeed = actualspeed
			ItemProperties.CurrentBaseData.EquippedData.WeaponDPS = avgdmg / speed
		end
	end
end

function ItemProperties.GetBodInfo(objectId, props, gumpRequest)
	
	local data
	if gumpRequest then -- we use the data we have if it's for the gump
		data = WindowData.ItemProperties[0]
	end
	
	if not props then -- the function can be used externally to get the intensity of an item.
		data = Interface.GetItemPropertiesData( objectId, "Get item intensity info" )
		props = ItemProperties.BuildParamsArray( data, true )
	end

	if not props then
		return
	end
	
	local count = 0
	for tid, _ in pairs(props) do
		if tid == 1043304 then -- Price: ~1_COST~
			continue
		end
		count = count + 1
	end
		
	local quantity, quality, material, lbodtype, skill, value

	local materialsSmith = {
		[1027152] = 0;   -- iron ingots
		[1045142] = 200; -- All items must be made with dull copper ingots.
		[1045143] = 250; -- All items must be made with shadow iron ingots.
		[1045144] = 300; -- All items must be made with copper ingots.
		[1045145] = 350; -- All items must be made with bronze ingots.
		[1045146] = 400; -- All items must be made with gold ingots.
		[1045147] = 450; -- All items must be made with agapite ingots.
		[1045148] = 500; -- All items must be made with verite ingots.
		[1045149] = 550; -- All items must be made with valorite ingots.
	}
	
	local materialsTailor = {
		[1025989] = 0;   -- L"cloth"
		[1049353] = 0;   -- L"normal leather"
		[1049354] = 50;  -- L"spined leather"
		[1049355] = 100; -- L"horned leather"
		[1049356] = 150; -- L"barbed leather"
		[1049354] = 50; -- All items must be made with spined leather.
		[1049355] = 100; -- All items must be made with horned leather.
		[1049356] = 150; -- All items must be made with barbed leather.
	}
	
	local amounts = {
		[L"10"] = 10;
		[L"15"] = 25;
		[L"20"] = 50;
	}
	
	local baseTypes = {
		[L"normal_smith"] = 0; 
		[L"normal_tailor"] = 0; 
		[L"exceptional_smith"] = 200; 
		[L"exceptional_tailor"] = 100;
	}
	local bodTypes = {
		[L"small"] = 0; 
		[L"4piece"] = 300; 
		[L"5piece"] = 400; 
		[L"6piece"] = 500; 
		[L"polearm"] = 200;
		[L"ringmail"] = 200; 
		[L"chainmail"] = 300; 
		[L"6pieceweapon"] = 300; 
		[L"fencing"] = 350; 
		[L"platemail"] = 400;
	}
	
	if props[1060656] then -- amount to make: ~1_val~
		quantity = props[1060656][1]
	end
	
	for tid, pt in pairs(materialsSmith) do
		if props[tid] then
			skill = L"smith"
			material = pt
			break
		end
	end
	
	for tid, pt in pairs(materialsTailor) do
		if props[tid] then
			skill = L"tailor"
			material = pt
			break
		end
	end
	if not skill then
		return
	end

	if props[1060636] then -- exceptional
		quality = L"exceptional_" .. skill
	else
		quality = L"normal_" .. skill
	end
	
	lbodtype = L"small"
	
	if skill == L"tailor" and count > 8 then
		lbodtype = (count - 7) .. L"piece"
	end
	
	for tid, params in pairs(props) do
		if ItemPropertiesInfo.BodItemsTid[tid] and skill == L"smith" and count > 8 then
			local item
			if params[1] and params[1] and wstring.len(params[1]) > 0 then
				item = wstring.gsub(params[1], L"#", L"")
				item = tonumber(item)
			end
			if item == 1025139 then -- platemail gorget
				lbodtype = L"platemail"
			elseif item == 1025099 then -- ringmail gloves
				lbodtype = L"ringmail"
			elseif item == 1025051 then -- chainmail coif
				lbodtype = L"chainmail"
			elseif item == 1023917 then -- bardiche
				lbodtype = L"polearm"
			elseif item == 1023921 then -- dagger
				lbodtype = L"fencing"	
			else
				lbodtype = L"6pieceweapon"			
			end
		end
	end

	value = baseTypes[quality] + amounts[quantity] + material + bodTypes[lbodtype]
	
	local worthLarge = 0
	local worthLarge2 = 0

	if (lbodtype == L"small") then
		for tid, params in pairs(props) do
			if ItemPropertiesInfo.BodItemsTid[tid] then
				local item
				if params[1] and wstring.len(params[1]) > 0 then
					item = wstring.gsub(params[1], L"#", L"")
					item = tonumber(item)
				end
				
				if ItemPropertiesInfo.BodSmallToLarge[item] then
					local big = ItemPropertiesInfo.BodSmallToLarge[item]
					if (type(big) ~="table") then
						worthLarge = baseTypes[quality] + amounts[quantity] + material + bodTypes[big]
					else
						worthLarge = baseTypes[quality] + amounts[quantity] + material + bodTypes[big[1]]
						worthLarge2 = baseTypes[quality] + amounts[quantity] + material + bodTypes[big[2]]
					end
					break
				end
			end
		end
	end
	
	local rw = ItemProperties.CalcReward(value, skill)
	
	local largeRW = nil
	local largeRW2 = nil
	if (worthLarge > 0) then
		largeRW = ItemProperties.CalcLargeReward(ItemProperties.CalcReward(worthLarge, skill), skill)
	end
	if (worthLarge2 > 0) then
		largeRW2 = ItemProperties.CalcLargeReward(ItemProperties.CalcReward(worthLarge2, skill), skill)
	end
		
	for tid, params in pairsByKeys(props) do
		
		local idx = ItemProperties.GetPropertyIndex(data, tid)
		local raw = WindowUtils.translateMarkup(data.PropertiesList[idx])
		
		if type(props[tid]) == "string" or not props[tid] then
			props[tid] = {}
		end

		props[tid].index = idx
		props[tid].raw = raw
		props[tid].desc = true
	end
	if props[1043304] then -- we re-add the price that we removed from the count
		count = count+1
	end
	count = count+1
	local p = {index=count, raw=GetStringFromTid(55), desc=true, hue=Interface.Settings.Props_ENGRAVE_COLOR}
	table.insert(props, p)
	
	for name, perc in pairs(rw) do
		count = count+1
		if type(name) ~= "wstring" then
			p = {index=count, raw=perc .. L"%", desc=true}
		else
			p = {index=count, raw=name .. L": " .. perc .. L"%", desc=true}
		end
		table.insert(props, p)
	end
	
	if largeRW or largeRW2 then
		count = count+1
		p = {index=count, raw=GetStringFromTid(56), desc=true, hue=Interface.Settings.Props_ENGRAVE_COLOR}
		table.insert(props, p)
	end
	
	if largeRW then
		for name, perc in pairs(largeRW) do
			count = count+1
			if type(name) ~= "wstring" then
				p = {index=count, raw=perc .. L"%", desc=true}
			else
				p = {index=count, raw=name .. L": " .. perc .. L"%", desc=true}
			end
			table.insert(props, p)
		end
	end
	
	if largeRW2 then
		for name, perc in pairs(largeRW2) do
			count = count+1
			if type(name) ~= "wstring" then
				p = {index=count, raw=perc .. L"%", desc=true}
			else
				p = {index=count, raw=name .. L": " .. perc .. L"%", desc=true}
			end
			table.insert(props, p)
		end
	end

	ItemProperties.CurrentBaseData.ExpandedProps = props
	
end

function ItemProperties.CalcReward(w, skill)
	local rw
	if skill == L"tailor" then
		local skillName = GetStringFromTid(1042381)
		
		if w < 50 then
			 rw = GetStringFromTid(1044286) .. L" 1"
			 
		elseif w < 100 then
			 rw = GetStringFromTid(1044286) .. L" 2"
			 
		elseif w < 150 then
			 rw = GetStringFromTid(1044286) .. L" 3"
			 
		elseif w < 200 then
			 rw = {[GetStringFromTid(1044286) .. L" 4"] = 90; [GetStringFromTid(1015289)] = 10;}
			 
		elseif w < 300 then
			 rw = {[GetStringFromTid(1044286) .. L" 4"] = 80; [GetStringFromTid(1015289)] = 20;}
			 
		elseif w < 350 then
			 rw = GetStringFromTid(1024201)
			 
		elseif w < 400 then
			 rw = ReplaceTokens(GetStringFromTid(1061119), { GetStringFromTid(1061118) })
			 
		elseif w < 450 then
			 rw = {[wstring.titleCase(ReplaceTokens(GetStringFromTid(1049639), {skillName} ))] = 40; [GetStringFromTid(1023754)] = 60;} 
			 
		elseif w < 500 then
			 rw = GetStringFromTid(1022729)
			 
		elseif w < 550 then
			 rw = wstring.titleCase(ReplaceTokens(GetStringFromTid(1049640), {skillName} ))
			 
		elseif w < 575 then
			 rw = GetStringFromTid(1041008)
			 
		elseif w < 600 then
			 rw = wstring.titleCase(ReplaceTokens(GetStringFromTid(1049641), {skillName} ))
			 
		elseif w < 650 then
			 rw = ReplaceTokens(GetStringFromTid(1061119), { GetStringFromTid(1061117) })
			 
		elseif w < 700 then
			 rw = wstring.titleCase(ReplaceTokens(GetStringFromTid(1049642), {skillName} ))
			 
		else 
			rw = ReplaceTokens(GetStringFromTid(1061119), { GetStringFromTid(1061116) })
		end
	else
		local skillName = GetStringFromTid(1043066)
		
		if w < 25 then
			rw = GetStringFromTid(1045125) -- L"shovel"
		
		elseif w < 50 then 
			rw = GetStringFromTid(1045126) -- L"pickaxe"		
		
		elseif w < 200 then 
			rw = {[GetStringFromTid(1045126)] = 45; [GetStringFromTid(1045125)] = 45; [GetStringFromTid(1045122)] = 10}  -- L"gloves+1"
		
		elseif w < 400 then 
			rw = {[GetStringFromTid(1049065)] = 45; [GetStringFromTid(1017411)] = 45; [GetStringFromTid(1045123)] = 10} -- L"prospector"  -- L"gargoyle" -- L"gloves+3"
		
		elseif w < 450 then 
			rw = {[GetStringFromTid(1049065)] = 40; [GetStringFromTid(1017411)] = 40; [GetStringFromTid(1049082)] = 20} 
		
		elseif w < 500 then 
			rw = {[GetStringFromTid(1045124)] = 10; [GetStringFromTid(1049082)] = 90}
		
		elseif w < 550 then 
			rw = GetStringFromTid(1049020)
		
		elseif w < 600 then 
			rw = {[GetStringFromTid(1049020)] = 60; [GetStringFromTid(1049021)] = 40}
		
		elseif w < 625 then 
			rw = GetStringFromTid(1049021)
		
		elseif w < 650 then 
			rw = {[wstring.titleCase(ReplaceTokens(GetStringFromTid(1049639), {skillName} ))] = 60; [GetStringFromTid(1049021)] = 30; [GetStringFromTid(1024015)] = 10}
		
		elseif w < 675 then  
			rw = GetStringFromTid(1049022)
		
		elseif w < 700 then  
			rw = {[wstring.titleCase(ReplaceTokens(GetStringFromTid(1049640), {skillName} ))] = 60; [GetStringFromTid(1049022)] = 30; [GetStringFromTid(1024015)] = 10}
		
		elseif w < 750 then  
			rw = GetStringFromTid(1049023)
		
		elseif w < 800 then  
			rw = GetStringFromTid(1049028)
		
		elseif w < 850 then  
			rw = wstring.titleCase(ReplaceTokens(GetStringFromTid(1049641), {skillName} ))
		
		elseif w < 900 then  
			rw = GetStringFromTid(1049029)
		
		elseif w < 950 then  
			rw = wstring.titleCase(ReplaceTokens(GetStringFromTid(1049642), {skillName} ))
		
		elseif w < 1000 then  
			rw = GetStringFromTid(1049024)
		
		elseif w < 1050 then  
			rw = GetStringFromTid(1049030)
		
		elseif w < 1100 then  
			rw = GetStringFromTid(1049025)
		
		elseif w < 1150 then  
			rw = GetStringFromTid(1049031)
		
		elseif w < 1200 then  
			rw = GetStringFromTid(1049026)
		
		else  
			rw = GetStringFromTid(1049027)
			
		end
	end
	
	if type(rw) == "wstring" then
		return {[rw] = 100}
	else	
		return rw
	end
end

function ItemProperties.CalcLargeReward(rw, skill)
	if not rw then
		return
	end
	local skillName 
	if (skill == L"tailor") then
		skillName = GetStringFromTid(1042381)
	else
		skillName = GetStringFromTid(1043066)
	end
	
	local items = {}
	if type(rw) == "wstring" then
		local itemName = wstring.titleCase(ReplaceTokens(rw, {skillName} ))
		items[itemName] = 100
		return items
	else
		for k,v in pairs(rw) do
			local itemName = wstring.titleCase(ReplaceTokens(k, {skillName} ))

			table.insert(items, itemName..L": "..v)
		end
		return items
	end
end

-- for fishing crates
function ItemProperties.GetCrateFishInfo(props)
	local data = WindowData.ItemProperties[0]
	local points = 0
	local propsCount = 0
	for tid, params in pairs(props) do
		local idx = ItemProperties.GetPropertyIndex(data, tid)
		local raw = WindowUtils.translateMarkup(data.PropertiesList[idx])
		propsCount = propsCount + 1
		if ItemPropertiesInfo.FishCrateFishMods[tid] then -- ~1_val~: ~2_val~/~3_val~
			
			local fish = params[1]
			fish = wstring.gsub(fish, L"#", L"")
			fish = tonumber(fish)
			
			local maxCount = tonumber(tostring(params[3]))
			
			local currPt = 0
			
			local FishKind = L""
			if (ItemPropertiesInfo.ShoreFish[fish]) then
				FishKind = L" (" ..GetStringFromTid(212) .. L")"
				currPt = ItemPropertiesInfo.ShoreFish[fish].points
			elseif (ItemPropertiesInfo.DeepwaterFish[fish]) then
				FishKind = L" (" ..GetStringFromTid(213) .. L")"
				currPt = ItemPropertiesInfo.DeepwaterFish[fish].points
			elseif (ItemPropertiesInfo.DungeonFish[fish]) then
				FishKind = L" (" ..GetStringFromTid(214) .. L")"
				currPt = ItemPropertiesInfo.DungeonFish[fish].points
			elseif (ItemPropertiesInfo.CrabLobster[fish]) then
				currPt = ItemPropertiesInfo.CrabLobster[fish].points
			end
			currPt = maxCount * currPt
			points = points + currPt
			raw = ReplaceTokens(GetStringFromTid(tid), {GetStringFromTid(fish) .. FishKind, params[2], params[3]} ) .. L"\t" .. ReplaceTokens(GetStringFromTid(1095171), {wstring.format(L"%.0f", currPt)} ) -- (~1_AMT~ points)
		end
		props[tid] = {}
		props[tid].index = idx
		props[tid].raw = raw
		props[tid].desc = true
	end	
	
	props[1] = {}
	props[1].index = propsCount + 1
	props[1].raw = ReplaceTokens(GetStringFromTid(1095171), {GetStringFromTid(3000087) .. L": " .. wstring.format(L"%.0f", points)} ) -- (~1_AMT~ points), Total
	props[1].desc = true
	
	ItemProperties.CurrentBaseData.ExpandedProps = props
end


-- Get the unravel intensity of an item
-- use only the objectId if it's not used for the item properties gump
function ItemProperties.GetItemIntensity(objectId, props, gumpRequest)

	if (not objectId or IsMobile(objectId)) and GenericGump.CurrentOver ~= "VSEARCH" then -- only for items
		return
	end
	local data
	if gumpRequest then -- we use the data we have if it's for the gump
		data = WindowData.ItemProperties[0]
	end
	if not props then -- the function can be used externally to get the intensity of an item.
		data = Interface.GetItemPropertiesData( objectId, "Get item intensity info" )
		props = ItemProperties.BuildParamsArray( data, true )
	end
	
	if not props then
		return
	end
		
	local actualspeed = 0
	local ssi = 0
	
	if props[1060486] then -- swing speed increase +~1_val~
		ssi = tostring(props[1060486][1])
		ssi = tonumber(ssi)
	end
	
	local artiSet = false
	local itemType 
	local objData
	local actualspeed = 0
	local objType 
	
	if gumpRequest then -- we use the data we have if it's for the gump
		itemType = ItemProperties.CurrentBaseData.GumpType
		
		if not ItemProperties.CurrentBaseData.WeaponSpeed then
			if props[1061167] then
				local speed = props[1061167][1] -- weapon speed ~1_val~
				speed = tostring(wstring.gsub(speed, L"s", L""))
				speed = tonumber(speed)
				local stamTicks = 0 -- we consider only the base weapon speed. This value is the player stamina.
					
				actualspeed = math.max(1.25, math.floor((speed * 4 - stamTicks) * (100 / (100 + ssi)))/4)
			end
		end
		actualspeed = ItemProperties.CurrentBaseData.WeaponSpeed
		artiSet = ItemProperties.CurrentBaseData.Set or ItemProperties.CurrentBaseData.Artifact
		objData = ItemProperties.CurrentBaseData
		
		objType = ItemProperties.CurrentBaseData.objType
	else
		local itemData = Interface.GetObjectInfoData(objectId)
		if not itemData then
			return
		end
		
		itemType = ItemPropertiesInfo.GetGumpTypeByItemData(objectId, itemData)
		
		objData = ItemPropertiesInfo.GetObjectData(itemData.objectType)
		if not objData then
			return
		end
		
		artiSet = ItemProperties.IsSet(props) or ItemProperties.IsArtifact(props)
		
		if props[1061167] then
			local speed = props[1061167][1] -- weapon speed ~1_val~
			speed = tostring(wstring.gsub(speed, L"s", L""))
			speed = tonumber(speed)
			local stamTicks = 0 -- we consider only the base weapon speed. This value is the player stamina.
				
			actualspeed = math.max(1.25, math.floor((speed * 4 - stamTicks) * (100 / (100 + ssi)))/4)
		end
		objType = itemData.objectType
	end
		
	if not actualspeed then
		actualspeed = 0
	end
	
	local propcount = 0
	local totalIntensity = 0
	
	local material = ItemPropertiesInfo.Materials[0]
	if gumpRequest then  -- we use the data we have if it's for the gump
		material.type = ItemProperties.CurrentBaseData.materialKind
	end
	
	if not props then
		return
	end

	for tid, params in pairsByKeys(props) do
		local idx = ItemProperties.GetPropertyIndex(data, tid)
		local raw = WindowUtils.translateMarkup(data.PropertiesList[idx])
		if wstring.sub(raw, 1, 1) == L"*" and Interface.Settings.NewItemProperties then
			raw = wstring.sub(raw, 2, wstring.len(raw))
		end

		local tidParam = 0
		local oldTid = tid
		if ItemPropertiesInfo.SkillBonusConvert[tid] then -- ~1_skillname~ +~2_val~
			tid = wstring.gsub(params[1], L"#", L"")
			tid = tostring(tid)
			tid = tonumber(tid)
			params[1] = params[2]
			params[2] = nil
		end	
		
		if params[1] and wstring.len(params[1]) > 0 and not ItemPropertiesInfo.SkillBonusConvert[oldTid] then
			tidParam = wstring.gsub(params[1], L"#", L"")
			tidParam = tonumber(tidParam)
		end
		if ItemPropertiesInfo.Materials[tid] then
			material = ItemPropertiesInfo.Materials[tid]
		elseif ItemPropertiesInfo.Materials[tidParam] then
			material = ItemPropertiesInfo.Materials[tidParam]
		end
					
		if ItemPropertiesInfo.AllProperties[tid] then
			local mod = ItemPropertiesInfo.AllProperties[tid]
			
			if not mod.weight then -- not counted if we don't have the weight
				if type(params) ~= "string" then
					local value = tostring(params[1])
					value = tonumber(value)
					props[oldTid].value = value
					props[oldTid][1] = nil
					props[oldTid].index = idx
					props[oldTid].raw = raw
					if mod.cap then
						props[oldTid].cap = mod.cap
					end
				end
				continue
			end
			
			local cap = mod.cap				

			if mod.leechScale then -- leech mod cap is scaled by the weapon speed and ssi
				cap = (actualspeed * 2500) / (100 + ssi)
				if itemType == ItemPropertiesInfo.Types.Ranged_Weapon then -- halved on ranged weapons
					cap = cap / 2
				end
				
			elseif itemType == ItemPropertiesInfo.Types.Ranged_Weapon and mod.rangedCap then
				cap = mod.rangedCap
				
			elseif itemType == ItemPropertiesInfo.Types.Jewel and mod.jewelsCap then
				cap = mod.jewelsCap
			end
			
			-- arcane focus strength bonus cap fix
			if (objType == 12629 or objType == 8794) and oldTid == 1060485 then
				cap = 6
			end
			
			if cap then	
				local min = 0	
				if objData[mod.en] then -- resistances cap need to be increased with the base item value
					min = objData[mod.en]
					cap = cap + objData[mod.en]
					props[tid].cap = cap
				end	

				if ItemPropertiesInfo.RefinementsResistProperties[tid] then
					local num = tonumber(tostring(params[2] .. params[3]))
					cap = cap + num
				end
				if tid == 1153734 then --  defense chance increase (refinement)
					local num = tonumber(tostring(params[2] .. params[3]))
					props[tid].cap = cap + num
				end
				local value = tostring(params[1])
				value = tonumber(value)
				if not value then
					value = 0
				end
				local curr = value - min
				local intensity = math.min( math.floor(curr / cap * 100), 100) -- current intensity in percent
				props[oldTid].intensity = intensity
				
				local weight = math.ceil(mod.weight * intensity) -- imbuing unravel weight
				props[oldTid].weight = weight
				props[oldTid].min = min
				props[oldTid].cap = cap
				props[oldTid].value = value
				props[oldTid][1] = nil
				props[oldTid].index = idx
				props[oldTid].raw = raw
				
				local propName = wstring.gsub(FormatProperly(mod.en), L" ", L"")
				props[oldTid].sheetName = tostring(propName)
				
				totalIntensity = totalIntensity + intensity
				
				if intensity > 0 then
					propcount = propcount + 1
				end
			
			elseif mod.negCap then
			
				local value = tostring(params[1])
				value = tonumber(value)
				
				cap = mod.negCap[2] 
			
				local diff = mod.negCap[2] - mod.negCap[1] 
			
				local curr = value - mod.negCap[1]
				
				
				local intensity = math.min( math.floor(curr / diff * 100), 100) -- current intensity in percent
				props[oldTid].intensity = intensity
				
				local weight = math.ceil(mod.weight * intensity) -- imbuing unravel weight
				props[oldTid].weight = weight
				
				props[oldTid].cap = cap
				props[oldTid].value = value
				props[oldTid][1] = nil
				props[oldTid].index = idx
				props[oldTid].raw = raw
				
				local propName = wstring.gsub(FormatProperly(mod.en), L" ", L"")
				props[oldTid].sheetName = tostring(propName)
				
				totalIntensity = totalIntensity + intensity
				
				if intensity > 0 then
					propcount = propcount + 1
				end
			
			else -- if there is no cap, then it's a property like slayers without a value
				props[tid] = {}
				props[tid].index = idx
				
				props[tid].raw = raw
				props[tid].intensity = 100
				
				local weight = math.ceil(mod.weight * props[tid].intensity) -- imbuing unravel weight
				props[tid].weight = weight
				
				props[tid][1] = nil
				
				totalIntensity = totalIntensity + props[tid].intensity
				
				propcount = propcount + 1
			end
		elseif ItemPropertiesInfo.ChargesTid[tid] then
			local value = tonumber(tostring(props[tid][ItemPropertiesInfo.ChargesTid[tid]]))
			if gumpRequest then -- requested for the gump
				ItemProperties.CurrentBaseData.uses = value
			end
			if type(props[tid]) == "string" then
				props[tid] = {}
			end
			props[tid].index = idx
			props[tid].raw = raw
		elseif tid == 1042886 then --  ~1_NUMBERS_OF_SPELLS~ Spells
			local maxSpells = SpellsInfo.GetMaxSpells(itemType)
			local v = towstring(params[1])

			if v and maxSpells then
				v = v .. L"/" .. towstring(maxSpells)
				props[tid] = {}
				props[tid].index = idx
				props[tid].raw = ReplaceTokens(GetStringFromTid(1042886), {towstring(v)})
				props[tid][1] = nil
			else
				if type(props[tid]) == "string" then
					props[tid] = {}
				end
				props[tid].index = idx
				props[tid].raw = raw
				props[tid].desc = true
				if not ItemPropertiesInfo.NotListed[tid] and not ItemPropertiesInfo.WeightONLYTid[tid] and not ItemPropertiesInfo.DecoProperties[tid] and idx ~= 1 and tid ~= 0 or ItemPropertiesInfo.UselessRefinementData[tid] then
					--Debug.Print(L"Property missing: " .. tid .. L" - " .. GetStringFromTid(tid))
				end
			end
		else
			if type(props[tid]) == "string" or not props[tid] then
				props[tid] = {}
			end
			props[tid].index = idx
			props[tid].raw = raw
			props[tid].desc = true
			if not ItemPropertiesInfo.NotListed[tid] and not ItemPropertiesInfo.WeightONLYTid[tid] and not ItemPropertiesInfo.DecoProperties[tid] and idx ~= 1 and tid ~= 0 or ItemPropertiesInfo.UselessRefinementData[tid] then
				--Debug.Print(L"Property missing: " .. tid .. L" - " .. GetStringFromTid(tid))
			end
		end
	end
	local totalres = 0
	for tid, params in pairs(ItemPropertiesInfo.ResistProperties) do -- let's add the missing resistances (if the item allows it)
		local idx = ItemProperties.GetPropertyIndex(data, tid)
		local raw 
		if idx and data.PropertiesList[idx] then
			raw = WindowUtils.translateMarkup(data.PropertiesList[idx])
		end
		local min = 0
		local cap = params.cap
		if objData[params.en] then
			min = objData[params.en]
			cap = params.cap + objData[params.en]
		end	
		if not props[tid] then
			props[tid] = {}
		end
		if props[tid].value and tonumber(props[tid].value) then
			totalres = totalres + props[tid].value
		end

		props[tid].min = min
		props[tid].cap = cap
		if not Interface.Settings.NewItemProperties then
			props[tid].index = idx
		else
			props[tid].index = -1
		end
		props[tid].raw = raw
		local propName = wstring.gsub(FormatProperly(params.en), L" ", L"")
		props[tid].sheetName = tostring(propName)
	end
	if totalres > 0 and not Interface.Settings.NewItemProperties  then
		props[2] = {}
		props[2].index = 998
		props[2].raw = ReplaceTokens(GetStringFromTid(222), {towstring(math.floor(totalres))})
		props[2].desc = true
	end
	
	local imbued = props[1080418] ~= nil -- (imbued)
	
	local curr, max = 0
	if props[1060639] then -- durability ~1_val~ / ~2_val~
		curr = tostring(props[1060639][1])
		curr = tonumber(curr)
		
		max = tostring(props[1060639][2])
		max = tonumber(max)
	end
	
	local worth = ItemPropertiesInfo.UNRAVEL_PlainItem
	
	-- items that won't show the worth colors:
	-- instruments, talismans, arcane focus and spellbooks.
	local notWorth = ItemPropertiesInfo.MusicalInstrumentsDB[objType] ~= nil or (objType == 12629 or objType == 8794) or Actions.IsTalisman(objType) or Actions.IsSpellbook(objType) or objType == 5359 or objType == 6589
	
	-- unravel calculation
	if propcount > 0 and totalIntensity > 0 and not notWorth then
		if (propcount > 5) then
			totalIntensity = math.floor(totalIntensity / propcount) * 5 -- scale the intensity based on the number of properties
		end
		
		if not artiSet and material.type ~= ItemPropertiesInfo.MATERIAL_MISC then
			totalIntensity = math.floor(totalIntensity * material.bonus) -- we scale the intensity based on the material bonus
		end
		
		totalIntensity = totalIntensity + (Interface.Settings.UnravelChar * 20)
		totalIntensity = totalIntensity + (Interface.Settings.UnravelForge * 10)
		
		local correct = 1 -- correction scale
		if imbued then
			correct = 0.8 -- imbued items have a riduced intensity
			
			if (curr < 50) then -- if the durability is less than 50, the correction value will be greatly reduced
				local cr = 0.02 * ( 50 - curr )
				correct = correct - cr
			end
		end
		
		totalIntensity = totalIntensity * correct
		
		if (totalIntensity > 0) then
			if totalIntensity >= ItemPropertiesInfo.RelicIntensity then
				worth = ItemPropertiesInfo.UNRAVEL_RelicFragment
			elseif totalIntensity >= ItemPropertiesInfo.EssenceIntensity then
				worth = ItemPropertiesInfo.UNRAVEL_EnchantedEssence
			else
				worth = ItemPropertiesInfo.UNRAVEL_MagicResidue
			end
		end
		
		props[1] = {}
		props[1].index = 999
		props[1].raw = ReplaceTokens(GetStringFromTid(90), {towstring(math.floor(totalIntensity))})
		props[1].desc = true
	end
	local textProperties = data.PropertiesList
	if textProperties then
		local itemName = wstring.lower(Shopkeeper.stripFirstNumber(WindowUtils.translateMarkup(textProperties[1])))
		local desc = GetDescription(itemName)
		if desc then
			props[3] = {}
			props[3].index = 1000
			props[3].raw = desc
			props[3].desc = true
		end
		if ItemPropertiesInfo.IsCraftingMaterial(objType) then
			desc = GetDescription(wstring.lower(GetStringFromTid(ItemProperties.CurrentBaseData.Material)))
			if desc then
				props[3] = {}
				props[3].index = 1000
				props[3].raw = desc
				props[3].desc = true
			end
		end
	end
	
	if gumpRequest then -- requested for the gump
		ItemProperties.CurrentBaseData.MaterialArray = material
		ItemProperties.CurrentBaseData.Imbued = imbued
		if curr and max then
			ItemProperties.CurrentBaseData.Durability = {min=curr; max=max}
		end
		ItemProperties.CurrentBaseData.Worth = worth
		ItemProperties.CurrentBaseData.TotalIntensity = totalIntensity
		ItemProperties.CurrentBaseData.MagicProperties = propcount
		ItemProperties.CurrentBaseData.ExpandedProps = props
	end
	
	return worth, totalIntensity, propcount
end

function ItemProperties.GetObjectProperties( objectId, number, caller )
	if Interface.DebugMode and caller then
	--	Debug.Print("ItemProperties.GetObjectProperties (" .. caller ..  ")")
	end
	
	local data = Interface.GetItemPropertiesData( objectId, caller )

	-- is the object ID the one we have the cursor over?
	if not data and WindowData.ItemProperties.CurrentHover == objectId then

		-- use ID 0 instead
		data = WindowData.ItemProperties[0]	
	end

	local properties
	local property = {}
	if not IsValidID(objectId) then
		return
	end

	if data and data.PropertiesList then

		properties = data.PropertiesList
		if (number ) and ( type( number ) == "number") then
			property[1] =  towstring( WindowUtils.translateMarkup(properties[number]) )
			return property[1]
		elseif (number ) and ( number == "last") then
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
	local data = Interface.GetItemPropertiesData( objectId, caller )

	-- is the object ID the one we have the cursor over?
	if not data and WindowData.ItemProperties.CurrentHover == objectId then

		-- use ID 0 instead
		data = WindowData.ItemProperties[0]	
	end

	local properties
	local property = {}
	if not IsValidID(objectId) then
		return
	end

	if data then

		properties = data.PropertiesTids
		
		if not properties then
			return
		end

		if (number ) and ( type( number ) == "number") then
			return properties[number]
		elseif (number ) and ( number == "last") then
			return properties[#property]
		else
			for i = 1, #properties do
				table.insert( property, properties[i] )
			end	
			return property
		end
	else
		return
	end	
end

function ItemProperties.GetObjectPropertiesTidParams( objectId, number, caller )
	if Interface.DebugMode and caller then
	--	Debug.Print("ItemProperties.GetObjectPropertiesTid (" .. caller ..  ")")
	end
	local data = Interface.GetItemPropertiesData( objectId, caller )
	
	-- is the object ID the one we have the cursor over?
	if not data and WindowData.ItemProperties.CurrentHover == objectId then

		-- use ID 0 instead
		data = WindowData.ItemProperties[0]	
	end

	local properties
	local property = {}
	if not IsValidID(objectId) then
		return
	end
	
	if data then
		
		properties = data.PropertiesTidsParams
		
		local params = ItemProperties.BuildParamsArray( data )
		
		local newParams = {}
		for i = 1, #data.PropertiesTids do
			newParams[i] = params[data.PropertiesTids[i]]
		end	
		
		if (number ) and ( type( number ) == "number") then
			return newParams[number]
		elseif (number ) and ( number == "last") then
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
	local data = Interface.GetItemPropertiesData( objectId, caller )
	
	-- is the object ID the one we have the cursor over?
	if not data and WindowData.ItemProperties.CurrentHover == objectId then

		-- use ID 0 instead
		data = WindowData.ItemProperties[0]	
	end

	local properties
	local property = {}
	if not IsValidID(objectId) then
		return
	end
	
	if data then
		local params = ItemProperties.BuildParamsArray( data, true )
		return params[tid]

	else
		return nil
	end	
end

function ItemProperties.IsCurrentHover(objectId)
	if (WindowData.ItemProperties.CurrentHover == objectId and WindowData.ItemProperties.CurrentType ~= WindowData.ItemProperties.TYPE_NONE) then
		return true
	end
	return false
end

function ItemProperties.BuildParamsArray( propertiesData, allProps )
	if not propertiesData then
		return
	end
	local params = {}
	local count = 0
	local tid
	
	if propertiesData.PropertiesTidsParams then
		for i = 1, #propertiesData.PropertiesTidsParams do
			local test = tostring(wstring.gsub(propertiesData.PropertiesTidsParams[i], L"@", L""))
			if wstring.find(propertiesData.PropertiesTidsParams[i], L"@", 1, true) == 1 and tonumber(test) and IsValidWString(GetStringFromTid(tonumber(test))) then
				tid = tonumber(test)
				params[tid] = {}
			elseif params[tid] then
				table.insert(params[tid], propertiesData.PropertiesTidsParams[i])
				count = count + 1
			end
		end
	end
	
	if allProps and propertiesData.PropertiesTids then
		for i = 1, #propertiesData.PropertiesTids do
			local tid = tonumber(propertiesData.PropertiesTids[i])
			if not params[tid] then
				params[tid] = ""
				count = count + 1
			end
		end
	end
	return params, count
end

function ItemProperties.DoesItemHasProperty( objectId, propertyTID, paperdollId, index )
	if Interface.DebugMode and caller then
	--	Debug.Print("ItemProperties.GetObjectPropertiesTid (" .. caller ..  ")")
	end
	if not IsValidID(objectId) then
		return
	end
	
	if paperdollId and index then -- get the data from saved properties of the specified paperdoll
		if not PaperdollWindow.ItemsProps[paperdollId] or not PaperdollWindow.ItemsProps[paperdollId][index] then
			return false
		end
		local params = PaperdollWindow.ItemsProps[paperdollId][index]
		if params[propertyTID] ~= nil then
			return true, params[propertyTID]
		end
	else
		local data = Interface.GetItemPropertiesData( objectId,  caller )

		if data then
			local params = ItemProperties.BuildParamsArray( data, true )
			if params[propertyTID] ~= nil then
				return true, params[propertyTID]
			end
		end	
	end
end

function ItemProperties.GetPropertyValue( objectId, propertyTID, removePercent, paperdollId, index )
	local found, values = ItemProperties.DoesItemHasProperty( objectId, propertyTID, paperdollId, index )
	if found then
		if removePercent then -- remove percent symbol from the final value
			return PercentValueToNumber(values[1])
		else
			return values[1]
		end
	end
	return 0
end

function ItemProperties.RegisterPaperdollProperties(paperdollId)
	if not IsValidID(paperdollId) then
		return
	end
	-- initializing the paperdoll data
	local paperdollData = Interface.GetPaperdollData(paperdollId)
	if not PaperdollWindow.ItemsProps[paperdollId] then
		PaperdollWindow.ItemsProps[paperdollId] = {}
	end
	local count = 0
	for index = 1, paperdollData.numSlots  do
		-- resetting the record in case we already have data
		PaperdollWindow.ItemsProps[paperdollId][index] =  nil

		local objectId = PaperdollWindow.GetPaperdollSlotID(paperdollId, index)

		if IsValidID(objectId) then
			-- saving the properties of the item in the slot
			local data = Interface.GetItemPropertiesData( objectId,  "updating character sheet data with missing values from paperdoll slot " .. index )
			local params = ItemProperties.BuildParamsArray( data, true )
			PaperdollWindow.ItemsProps[paperdollId][index] = params
			count = count + 1
		end
	end
	if count == 0 then
		PaperdollWindow.ItemsProps[paperdollId] = nil
	end
end

function ItemProperties.GetActiveProperties()
	
	local playerId = GetPlayerID()
	local paperdollWindowName = "PaperdollWindow"..playerId 	
	local numTotalItemProps = CSVUtilities.getNumRows(WindowData.PlayerItemPropCSV)
	
	local paperdollData = PaperdollWindow.ItemsList[playerId]
	if not paperdollData then
		paperdollData = Interface.GetPaperdollData(playerId)
	end

	if not paperdollData then			
		return
	end	

	-- Show available item properties	
	PropertyTable = {}
	for index = 1, paperdollData.numSlots do
		local objectId = PaperdollWindow.GetPaperdollSlotID(playerId, index)
		if IsValidID(objectId) then
			Interface.GetObjectInfoData(objectId)			
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
		end		
	end
	return PropertyTable
end

function ItemProperties.GetIntensityColor(intensity)
	if intensity > 50 then
		local color = Interface.Settings.IntensInfoColorID
		local r,g,b
		if (color == 1) then
			r=255
			g=0
			b=0
		elseif (color == 2) then
			r=0
			g=255
			b=0
		elseif (color == 3) then
			r=0
			g=0
			b=255
		elseif (color == 4) then
			r=255
			g=255
			b=0
		elseif (color == 5) then
			r=0
			g=255
			b=255
		elseif (color == 6) then
			r=255
			g=0
			b=255
		elseif (color == 7) then
			r=255
			g=255
			b=255
		end
		
		local scale = intensity / 100
		
		return r * scale, g * scale, b * scale
	else
		return Interface.Settings.Props_MAGICPROP_COLOR.r, Interface.Settings.Props_MAGICPROP_COLOR.g, Interface.Settings.Props_MAGICPROP_COLOR.b
	end
end

-- sometimes the properties gets stuck, we need to manually reset it
function ItemProperties.ResetWindowDataProperties(itemId)

	-- is a valid ID?
	if not IsValidID(itemId) then
		return
	end

	-- no need to reset if the item ID is the same of the last properties shown
	if itemId == WindowGetId("ItemProperties") then
		return
	end

	-- reset the index 0 (default for almost every property)
	WindowData.ItemProperties[0] = {}

	-- reset the title, and notoriety status for the ID 0
	if (WindowData.ItemProperties.CustomColorTitle) then
		WindowData.ItemProperties.CustomColorTitle.NotorietyEnable = false
		WindowData.ItemProperties.CustomColorTitle.NotorietyIndex = 0
		WindowData.ItemProperties.CustomColorBody.LabelIndex = 0
		WindowData.ItemProperties.CustomColorBody.Color = {r=0, g=0, b=0}
	end
end

function ItemProperties.ResetWindowDataPropertiesFull()

	-- reset the index 0 (default for almost every property)
	WindowData.ItemProperties[0] = {}

	-- reset the title, and notoriety status for the ID 0
	if (WindowData.ItemProperties.CustomColorTitle) then
		WindowData.ItemProperties.CustomColorTitle.NotorietyEnable = false
		WindowData.ItemProperties.CustomColorTitle.NotorietyIndex = 0
		WindowData.ItemProperties.CustomColorBody.LabelIndex = 0
		WindowData.ItemProperties.CustomColorBody.Color = {r=0, g=0, b=0}
	end
end

function ItemProperties.GetAmountFromName(name)

	-- do we have a valid name?
	if not IsValidWString(name) then
		return
	end

	-- remove the number from the name
	local amount = Shopkeeper.stripFirstNumber(WindowUtils.translateMarkup(name))

	-- remove the name from the name (so only the amount will remain)
	amount = wstring.gsub(name, amount, L"")

	return amount
end