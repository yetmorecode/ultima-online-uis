----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

GenericGump = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------
 
GenericGump.LastGump = ""
GenericGump.LastGumpLabels = {}
GenericGump.GumpsList = {}

GenericGump.CurrentOver = ""

GenericGump.VETERAN_REWARD_GUMPID = 452
GenericGump.CRAFTING_GUMPID = 460
GenericGump.RUNIC_ATLAS_GUMPID = 498
GenericGump.HELP_MENU_GUMPID = 666
GenericGump.BOD_BOOK_GUMPID = 668
GenericGump.CRAFTING_ITEM_DETAILS_GUMPID = 685
GenericGump.QUEST_RESIGN_GUMPID = 801
GenericGump.VIRTUE_GUMP_GUMPID = 10014
GenericGump.PLANT_REPRODUCTION_GUMPID = 22222
GenericGump.PLANT_GUMPID = 29842
GenericGump.LOYALTY_RATING_GUMPID = 999060
GenericGump.INSURANCE_MENU_GUMPID = 999071
GenericGump.BOAT_PLACEMENT_GUMPID = 999076
GenericGump.VENDOR_SEARCH_GUMPID = 999112
GenericGump.VENDOR_SEARCH_RESULTS_GUMPID = 999113
GenericGump.VvV_GUMPID = 999116
GenericGump.BANK_ACTIONS_GUMPID = 999123
GenericGump.EJ_BANK_GUMPID = 999147
GenericGump.JEWELBOX_GUMPID = 999143
GenericGump.SOULSTONE_GUMPID = 15010
GenericGump.NEW_STORE_ITEM_GUMPID = 999136
GenericGump.MAGINCIA_PET_VENDOR_GUMPID = 999090
GenericGump.DAVIES_LOCKER_GUMPID = 999102
GenericGump.TRACKING_GUMPID = 12350000
GenericGump.IMBUING_GUMPID = 999059

GenericGump.BoldFont_small = "google_noto_bold_shadow_14"
GenericGump.SmallFont = "google_noto_13"

GenericGump.NormalFont = "google_noto_16"
GenericGump.BoldFont = "google_noto_bold_shadow_16"
GenericGump.BoldFontTitle = "google_noto_bold_shadow_18"

GenericGump.HighlightColor = { r = 255, g = 215, b = 0 }

GenericGump.ToolTips = {}

GenericGump.VirtueImagesTable = {}
GenericGump.VirtueImagesTable[2] = 63
GenericGump.VirtueImagesTable[3] = 60
GenericGump.VirtueImagesTable[4] = 58
GenericGump.VirtueImagesTable[5] = 59
GenericGump.VirtueImagesTable[6] = 61
GenericGump.VirtueImagesTable[7] = 65
GenericGump.VirtueImagesTable[8] = 64
GenericGump.VirtueImagesTable[9] = 62

----------------------------------------------------------------
-- GenericGump Functions
----------------------------------------------------------------

function GenericGump.Initialize()

	-- current gump window name
	local windowName = SystemData.ActiveWindow.name

	-- mark the window to be destroyed on closing
	Interface.DestroyWindowOnClose[windowName] = true

	-- store the last gump window name
	GenericGump.LastGump = windowName
	
	-- are we waiting for the shop gump?
	if GenericGump.NextisShop then

		-- show the gump before it gets locked
		WindowSetShowing(windowName, true)

		-- store the shop gump window name
		GumpsParsing.ShopWindow = windowName

		-- start the timer to check if the gump is still open
		GenericGump.shoptime = Interface.TimeSinceLogin + 1

	else -- reset the stored labels
		GenericGump.LastGumpLabels = {}

		-- hide the gump by default (except for vice vs virtue gump)
		WindowSetShowing(windowName, GumpsParsing.VvVGump == windowName)
	end
  
	-- if we're checking a waypoint while a gump appears, we lose the tooltip so we need to re-focus the map.
	if MapCommon.WaypointIsMouseOver then
		WindowAssignFocus("MapWindow", true)
	end
end

function GenericGump.OnLabelInit()
	
	-- current gump window name
	local windowName = SystemData.ActiveWindow.name

	-- get the main gump window
	local parent = WindowUtils.GetActiveDialog()

	-- initialize the gump ID
	local gumpId 
	
	-- do we have any gump registered?
	if GumpData then

		-- scan all the gumps
		for g, data in pairs(GumpData.Gumps) do

			-- is the element the current gump main window or there is only 1 gump?
			if data.windowName == parent or table.countElements(GumpData.Gumps) == 1 then
		
				-- we found the gump
				gumpId = g

				break
			end
		end
	end

	-- if we don't have the gump ID we can get out
	if not gumpId then
		gumpId = "unknown"
	end

	-- do we have the labels aray?
	if not GenericGump.LastGumpLabels then

		-- initialize the labels array
		GenericGump.LastGumpLabels = {}
	end

	-- do we have the labels aray for this gump?
	if not GenericGump.LastGumpLabels[gumpId] then

		-- initialize the labels array
		GenericGump.LastGumpLabels[gumpId] = {}
	end

	-- add the label window name into the labels array
	table.insert(GenericGump.LastGumpLabels[gumpId], {windowName = windowName})
end

function GenericGump.Shutdown()
	
	-- if the interface is shutting down we can avoid everything in here
	if Interface.goingDown then
		return
	end

	-- current gump window name
	local windowName = SystemData.ActiveWindow.name
	
	-- current gump ID
	local gumpID = GenericGump.GumpsList[windowName]

	-- remove the window from the "destroy on close" array
	Interface.DestroyWindowOnClose[windowName] = nil

	-- if this was the shop, let's check in half second if it's really closed or if we're just turning page.
	if GenericGump.NextisShop then
		GenericGump.shoptime = Interface.TimeSinceLogin + 0.5
	end

	-- do we have the gump ID?
	if gumpID then

		-- is the vendor search and there is no holdon flag?
		if gumpID == GenericGump.VENDOR_SEARCH_GUMPID and not VendorSearch.HoldOn then

			-- is the vendor search gump still active?
			if DoesWindowExist(VendorSearch.WindowName) then

				-- destroy the vendor search gump
				DestroyWindow(VendorSearch.WindowName)
			end
		end

		-- it's a bod book?
		if gumpID == GenericGump.BOD_BOOK_GUMPID then

			-- delete the bod book window name
			GenericGump.BodBook = nil
		end

		-- is this the virtue gump?
		if gumpId == GenericGump.VIRTUE_GUMP_GUMPID then
			GenericGump.virtueRegistered = nil
		end

		-- is this the pet list gump?
		if PetsList and gumpID == PetsList.GumpID then

			-- destroy the pet list window
			DestroyWindow("PetsList")
		end
		
		-- is this the player vendor gump?
		if PlayerVendor and (gumpID == PlayerVendor.GumpID or gumpID == PlayerVendor.CustomizeGumpID) then

			-- check again if the gump is active in 1 second
			Interface.AddTodoList({name = "player vendor gump retry", func = function() PlayerVendor.CheckGump()  end, time = Interface.TimeSinceLogin + 1})
		end

		-- flag the gump as open window
		WindowUtils.openWindows["Gump" .. gumpID] = true

		-- save the gump position
		WindowUtils.SaveWindowPosition(windowName, false, "Gump" .. gumpID)

		-- remove the gump flag in the open windows list
		WindowUtils.openWindows["Gump" .. gumpID] = nil

		-- is this the loyalty rating gump in the pick title page?
		if gumpID == GenericGump.LOYALTY_RATING_GUMPID and GumpsParsing.ParsedGumps[gumpID] == "PickCityTitle" then

			-- cancel the take city loyalty action
			CharacterSheet.TakeCityLoyalty = nil
		end

		-- remove the parsed gumps
		GumpsParsing.ParsedGumps[gumpID] = nil

		-- remove the gump from the to be shown list
		GumpsParsing.ToShow[gumpID] = nil
	end

	-- remove the window from the gumps list
	GenericGump.GumpsList[windowName] = nil

	-- do we have the mouse over a gump element?
	if GenericGump.CurrentOver ~= "" then

		-- reset the mouse over window name
		GenericGump.CurrentOver = ""
		
		-- clear the item property
		ItemProperties.ClearMouseOverItem()
	end
end

function GenericGump.RunicAtlasManagement()

	-- get the current window name
	local windowName = SystemData.ActiveWindow.name

	-- get the gump main window name, gump ID and element ID
	local parent, gumpId, id = GumpsParsing.GetElementData(windowName)

	-- runic atlas: making the rune label clicking the same as clicking the little round button the side
	if gumpId == GenericGump.RUNIC_ATLAS_GUMPID then 

		-- get the label text
		local labelText = LabelGetText(windowName)

		-- is this an empty slot? then we do nothing
		if labelText == L"Empty" then
			return
		end
		
		-- initialize the label ID
		local labelId = 0

		-- initialize min ID of the label
		local labelMin = 0

		-- scan all the labels
		for label, data in pairsByKeys(GumpData.Gumps[gumpId].Labels) do	

			-- label window name
			local labelGumpName  = "GenericGumpItem" .. tostring(label)

			-- does the label exist?
			if DoesWindowExist(labelGumpName) then

				-- is this the current label?
				if windowName == labelGumpName then

					-- get the label ID
					labelId = label
				end

				-- IDs greater than 30 are runes
				if label > 30 then

					-- if we don't have the smallest ID yet, we get this one as min
					if labelMin == 0 then
						labelMin = label
					end

					-- is the current ID smallest than the one we have? then we update the smallest ID
					if label < labelMin then
						labelMin = label
					end
				end
			end
		end

		-- initialize the label tid
		local labelTid = 0

		-- if the label ID is still 0 then we haven't found it yet
		if labelId == 0 then

			-- scan all labels (again)
			for label, data in pairsByKeys(GumpData.Gumps[gumpId].Labels) do	

				-- is this the label we're looking for and it's a button (not a rune)?
				if windowName == data.windowName and label < 30 then

					-- get the label ID
					labelId = label

					-- get the text tid
					labelTid = data.tid

					break
				end
			end
		end

		-- if the label ID is greater than 30, we have clicked a rune
		if labelId > 30 then

			-- runes button's starts from 3 (2 if only 1 page turner is visible)
			-- LABEL ID ORDER:
			--  1	2
			--  3	4
			--	5	6
			--	7	8
			--	9	10
			--	11	12
			--	13	14
			--	15	16
			-- id 19 rename book
			-- id 20 recall (spell)
			-- id 21 recall (charge) if available, otherwise the following will be -1
			-- id 22 gate travel  if available, otherwise the following will be -1
			-- id 23 sacred journey  if available, otherwise the following will be -1
			-- id 24 set default
			-- id 25 drop rune

			-- BUTTONS IDS:
			-- 1, 2 page turner (all -1 if there is only 1 page turner)
			-- 3...18 runes
			-- 19 rename book
			-- 20 recall (spell)
			-- 21 recall (charge), if there are no charges the following are -1
			-- 22 gate travel, the following are -1 if you can't cast gate travel
			-- 23 sacred journey
			-- 24 set default
			-- 25 drop rune

			-- calculate the real label ID by subtracting the minimum ID we've found and dividing by 2
			labelId = (labelId - labelMin) / 2

			-- initialize the starting button ID
			local startButtonId = 2

			-- do we have 2 page turner buttons?
			if GumpsParsing.RunicAtlasGetPageTurnerNumber() == 2 then

				-- the button ID needs to be increased by 1
				startButtonId = startButtonId + 1

				-- press the button
				GumpsParsing.PressButton(gumpId, startButtonId + labelId)

			else -- only 1 page turner
				GumpsParsing.PressButton(gumpId, startButtonId + labelId)
			end

		else -- non-rune clicked

			-- get the spell ID based on the label tid
			local spell = GumpsParsing.RunicAtlasTidToSpellId[labelTid]

			-- press the spell button
			GumpsParsing.PressButton(gumpId, GumpsParsing.RunicAtlasGetButtonID(spell))
		end
	end
end

function GenericGump.OnClicked()
	
	-- get the current element name
	local windowName = SystemData.ActiveWindow.name

	-- get the gump main window name, gump ID and element ID
	local parent, gumpId, id = GumpsParsing.GetElementData(windowName)

	-- do we have the gump ID?
	if not gumpId then
		return
	end

	-- manage extra action on the button press
	GenericGump.OnGumpButtonClicked(gumpId, id)

	-- execute the default action for pressing the button
    GenericGumpOnClicked(WindowGetId(windowName), windowName)
end

function GenericGump.OnGumpButtonClicked(GumpID, buttonID)

	-- check if it's the help menu and handle it
	GenericGump.HelpMenuButtonClick(GumpID, buttonID)

	-- check if it's the new store item gump and handle it
	GenericGump.NewStoreItemButtonClick(GumpID, buttonID)

	-- check if it's the magincia pet vendor gump and handle it
	GenericGump.PetVendorButtonClick(GumpID, buttonID)

	-- check if it's the boat placement gump and handle it
	GenericGump.BoatPlacementButtonClick(GumpID, buttonID)

	-- check if it's the quest resign gump and handle it
	GenericGump.QuestResignButtonClick(GumpID, buttonID)

	-- check if it's the customize player vendor gump and handle it
	GenericGump.CustomizeVendorButtonClick(GumpID, buttonID)

	-- check if it's the davie's locker gump and handle it
	GenericGump.DaviesLockerButtonClick(GumpID, buttonID)

	-- check if it's a crafting gump and handle it
	GenericGump.CraftingGumpButtonClick(GumpID, buttonID)
end

function GenericGump.OnDoubleClicked()
    
	-- get the current element name
	local windowName = SystemData.ActiveWindow.name
	
	-- get the ID of the clicked element
    local gumpId = WindowGetId(windowName)
    
	-- execute the double click
    GenericGumpOnDoubleClicked(gumpId, windowName)
end

function GenericGump.OnRClicked()

	-- get the ID of the clicked element
    local gumpId = WindowGetId(SystemData.ActiveWindow.name)
    
	-- execute the default right click function
    GenericGumpOnRClicked(gumpId)    
end

function GenericGump.OnMouseOver()

	-- get the current gump element name
    local windowName = SystemData.ActiveWindow.name

	-- get the gump main window name, gump ID and element ID
	local parent, gumpId, id, objectType = GumpsParsing.GetElementData(windowName)

	-- if the debug mode is active, we print the window name
    if Interface.DebugMode then
		Debug.Print(windowName)
	end
	
	-- do we have the gump ID?
	if not gumpId then
		return
	end

	-- initialize the label data variable
	local LabelData
	
	-- get the data for the current gump label (if it is a label)
	if GumpData.Gumps[gumpId] and GumpData.Gumps[gumpId].Labels and GumpData.Gumps[gumpId].Labels[id] and objectType == "label" then
		LabelData = GumpData.Gumps[gumpId].Labels[id]
		
	 -- search the label data (desperate method)
	elseif GumpData.Gumps[gumpId] and GumpData.Gumps[gumpId].Labels and objectType == "label" then
		
		-- get the label text
		local lblText = LabelGetText(windowName)
		
		-- if we don't have the label text then it's not a label
		if not lblText then
			return
		end

		-- scan the labels
		for id, dt in pairsByKeys(GumpData.Gumps[gumpId].Labels) do

			-- do we have the label TID?
			if not dt.tid then
				continue
			end
			
			-- is this the label we are looking at?
			if dt.tid and GetStringFromTid(dt.tid) == lblText then

				-- get the label data
				LabelData = dt

				break

			-- try with the parameters
			elseif dt.tid and dt.tidParms and ReplaceTokens(GetStringFromTid(dt.tid), dt.tidParms) == lblText then

				-- get the label data
				LabelData = dt

				break
			end
		end
	end
	
	-- get the tooltip for the current gump element (NOTE: this function only works if the mouse cursor is physically over the element)
	local tooltipText = GenericGumpGetToolTipText(WindowGetId(windowName), windowName)

	-- do we have the label data?
	if LabelData and LabelData.tid then

		-- is there a custom tooltip for this label?
		if GenericGump.ToolTips[LabelData.tid] then

			-- show the custom tooltip instead
			tooltipText = GenericGump.ToolTips[LabelData.tid]
		end
	end	
	   
	-- do we have a valid tooltip text and it's not the vendor search results?
    if IsValidWString(tooltipText) and gumpId ~= GenericGump.VENDOR_SEARCH_RESULTS_GUMPID then

		-- show the tooltip
		Tooltips.CreateTextOnlyTooltip(windowName, tooltipText)

		-- job's done, we can get out
		return

	-- is this a vendor search result?
    elseif gumpId == GenericGump.VENDOR_SEARCH_RESULTS_GUMPID and tooltipText then
	
		-- generate the item properties for the item
		GenericGump.ParseTooltipItemProperties(windowName, WindowUtils.translateMarkup(tooltipText))

		-- job's done, we can get out
		return

	-- is this a crafting tool?
    elseif gumpId == GenericGump.CRAFTING_GUMPID and LabelData and LabelData.tidParms and LabelData.tidParms[1] then

		-- get the raw TID param
		local param = wstring.gsub(LabelData.tidParms[1], L"#", L"")

		-- get the item TID
		local itemTid = tonumber(param)

		-- get the crafting skill name
		local skillName = GumpsParsing.ParsedGumps[GenericGump.CRAFTING_GUMPID]

		-- get the item data
		local itemData = CraftingInfo.ToolMap[skillName][itemTid]

			-- make sure we have the item data
		if not itemData then

			-- warn the player that we don't have the item data
			Tooltips.CreateTextOnlyTooltip(windowName, GetStringFromTid(613))

			return
		end

		-- we use the first instance of the item by default
		local instance = 1

		-- is this a category (NOT LAST TEN), and the item has multiple instances?
		if GumpsParsing.CraftingToolCurrentCategory > 0 and itemData.category2 then

			-- determine the item instance
			instance = inlineIf(itemData.category == GumpsParsing.CraftingToolCurrentCategory, 1, 2)
		end
		
		-- show the tooltip for the item
		GenericGump.ShowCraftingGumpItemTooltip(itemTid, itemData, windowName, instance)

		return

	-- are this the crafting item details?
	elseif gumpId == GenericGump.CRAFTING_ITEM_DETAILS_GUMPID and LabelData and LabelData.tidParms and LabelData.tidParms[1] then
		
		-- instance of the TID 1114057. The first is the item name the rest are the materials
		local instance = 0
		
		-- scan the labels
		for _, dt in pairsByKeys(GumpData.Gumps[gumpId].Labels) do

			-- item or material
			if dt.tid == 1114057 then -- ~1_val~

				-- increase the instances of this TID
				instance = instance + 1

				-- the item name has been clicked so we do nothing
				if instance == 1 and LabelData.tidParms[1] == dt.tidParms[1] then
					return

				-- materials
				elseif LabelData.tidParms[1] == dt.tidParms[1] then
					
					-- get the raw TID param
					local param = wstring.gsub(LabelData.tidParms[1], L"#", L"")

					-- get the item TID
					local itemTid = tonumber(param)

					-- get the skill ID required to craft the material (if available)
					local skillTid, tid, _, skillName = GumpsParsing.CraftingToolGetToolRequired(itemTid)

					-- is this a craftable item?
					if skillName and CraftingInfo.ToolMap[skillName] and CraftingInfo.ToolMap[skillName][tid] then

						-- get the item data
						local itemData = CraftingInfo.ToolMap[skillName][tid]

						-- we use the first instance of the item by default
						local instance = 1

						-- is this a category (NOT LAST TEN), and the item has multiple instances?
						if GumpsParsing.CraftingToolCurrentCategory > 0 and itemData.category2 then

							-- determine the item instance
							instance = inlineIf(itemData.category == GumpsParsing.CraftingToolCurrentCategory, 1, 2)
						end
		
						-- show the tooltip for the item
						GenericGump.ShowCraftingGumpItemTooltip(itemTid, itemData, windowName, instance, true)

						-- store the label name
						GenericGump.HighlightedLabel = windowName

						-- highlight the label
						LabelSetTextColor(GenericGump.HighlightedLabel, GenericGump.HighlightColor.r, GenericGump.HighlightColor.g, GenericGump.HighlightColor.b)

					else -- not craftable

						-- do we have the material description?
						if skillTid then

							-- add the skill required to craft the item
							local text = FormatProperly(ReplaceTokens(GetStringFromTid(615), {  wstring.trim(GetStringFromTid(skillTid)) }))

							-- show the extra info on the material
							Tooltips.CreateTextOnlyTooltip(windowName, text)

							-- store the label name
							GenericGump.HighlightedLabel = windowName

							-- highlight the label
							LabelSetTextColor(GenericGump.HighlightedLabel, GenericGump.HighlightColor.r, GenericGump.HighlightColor.g, GenericGump.HighlightColor.b)
						end
					end

					return
				end
			end
		end
    end

	-- get the object ID for the gump element
	local objectId = GenericGumpGetItemPropertiesId(WindowGetId(windowName), windowName)
	
	-- do we have a valid ID?
    if IsValidID(objectId) then

		-- mark that we are over a gump element
		GenericGump.CurrentOver = "VSEARCH"

		-- is the item properties we're seeing of a different item?
		if objectId ~= WindowGetId("ItemProperties") and WindowGetShowing("ItemProperties") then

			-- reset the item properties array
			ItemProperties.ResetWindowDataPropertiesFull()
		end
		
		-- create the item properties data table
	    local itemData = { windowName = windowName,
					       itemId = objectId,
	    			       itemType = WindowData.ItemProperties.TYPE_ITEM,
	    			       detail = ItemProperties.DETAIL_LONG }

		-- show the item properties
	    ItemProperties.SetActiveItem(itemData)      
    end
end

function GenericGump.LabelClicked()
	
	-- get the current gump element name
    local windowName = SystemData.ActiveWindow.name

	-- get the gump main window name, gump ID and element ID
	local parent, gumpId, id, objectType = GumpsParsing.GetElementData(windowName)

	-- do we have the gump ID?
	if not gumpId then
		return
	end

	-- get the data for the current gump label (if it is a label)
	if GumpData.Gumps[gumpId] and GumpData.Gumps[gumpId].Labels and GumpData.Gumps[gumpId].Labels[id] and objectType == "label" then
		LabelData = GumpData.Gumps[gumpId].Labels[id]
	end

	-- is this a crafting tool?
	if gumpId == GenericGump.CRAFTING_GUMPID and LabelData then

		-- get the gump data
		local data = GumpData.Gumps[gumpId]

		-- get the crafting skill name
		local skillName = GumpsParsing.ParsedGumps[gumpId]

		-- get the categories button start ID
		local startId = GumpsParsing.MapCraftingToolGetFirstCatButton(GenericGump.CRAFTING_GUMPID)
		
		-- index of the clicked category
		local category = 0
		
		-- flag that indicates if we have to start counting categories
		local startCount =  false

		-- scan all the labels to determine if the label is a category name
		for id, dt in pairsByKeys(data.Labels) do

			-- from here we start the count
			if dt.tid == 1044014 then -- LAST TEN
	
				-- start counting the categories
				startCount = true

				-- is this the label we clicked?
				if dt.windowName == windowName then

					-- go to the last ten category
					GumpsParsing.PressButton(GenericGump.CRAFTING_GUMPID, startId)

					return
				end

				continue
			end
			
			-- each of this elements determine the end of the categories
			if dt.tid == 1114057 or dt.tid == 1061001 or dt.tid == 1044017 or dt.tid == 1044016 or dt.tid == 1112533 or dt.tid == 1112534 then -- ~1_val~ // ENHANCE ITEM // MARK ITEM // SMELT ITEM // NON QUEST ITEM // QUEST ITEM
				break
			end
			
			-- are we counting the categories now? (and this is not the "SELECTION" label?)
			if startCount and dt.tid ~= 1044011 then -- <CENTER>SELECTIONS</CENTER>

				-- increase the counter
				category = category + 1
				
				-- is this the label we clicked?
				if dt.windowName == windowName then

					-- go to the right category
					GumpsParsing.PressButton(GenericGump.CRAFTING_GUMPID, startId + category)

					return
				end
			end
		end

		-- item index
		local itemIndex = 0

		-- scan the labels to determine the item index
		for _, dt in pairsByKeys(data.Labels) do
		
			-- this label is repeated each page
			if dt.tid == 1044044 or dt.tid == 1044045 then -- PREV PAGE // NEXT PAGE
				continue
			end

			-- item in the category
			if dt.tid == 1114057 then -- ~1_val~

				-- increase the item index
				itemIndex = itemIndex + 1

				-- is this the label we clicked?
				if dt.windowName == windowName then

					-- show the item details
					GumpsParsing.GetCraftingToolItemDetailsByIndex(itemIndex)

					return
				end
			end
		end

	-- are this the crafting item details?
	elseif gumpId == GenericGump.CRAFTING_ITEM_DETAILS_GUMPID and LabelData and LabelData.tidParms and LabelData.tidParms[1] then

		-- get the crafting skill name
		local skillName = GumpsParsing.ParsedGumps[gumpId]

		-- get the current skill TID
		local currSkill = GumpsParsing.CraftingToolToolTypeToSkill(skillName)

		-- instance of the TID 1114057. The first is the item name the rest are the materials
		local instance = 0
		
		-- active item TID
		local currItemTid

		-- scan the labels
		for _, dt in pairsByKeys(GumpData.Gumps[gumpId].Labels) do

			-- item or material
			if dt.tid == 1114057 then -- ~1_val~

				-- increase the instances of this TID
				instance = instance + 1

				-- is this the first instance?
				if instance == 1 then

					-- get the raw TID param
					local param = wstring.gsub(dt.tidParms[1], L"#", L"")

					-- get the item TID
					currItemTid = tonumber(param)

					-- has the item name being clicked?
					if LabelData.tidParms[1] == dt.tidParms[1] then
						return
					end

				-- materials
				elseif LabelData.tidParms[1] == dt.tidParms[1] then
					
					-- get the raw TID param
					local param = wstring.gsub(dt.tidParms[1], L"#", L"")

					-- get the item TID
					local itemTid = tonumber(param)

					-- get the skill ID required to craft the material (if available)
					local skillTid, tid, instance = GumpsParsing.CraftingToolGetToolRequired(itemTid)

					-- do we have the material description and the tool info?
					if skillTid and CraftingInfo.Tools[skillTid] then
					
						-- is the material crafted with this tool?
						if skillTid == currSkill then

							-- click the back button
							GumpsParsing.PressButton(gumpId, 1)

							-- open the item details
							Interface.ExecuteWhenAvailable({ name = "MaterialOpenItemDetails", check = function() return GumpsParsing.ParsedGumps[GenericGump.CRAFTING_GUMPID] ~= nil end, callback = function() GumpsParsing.GetCraftingToolItemDetails(tid, instance) end, maxTime = Interface.TimeSinceLogin + 1, delay = Interface.TimeSinceLogin + 0.5, removeOnComplete = true })

						else -- other tool

							-- get the tool ID
							local toolId = ContainerWindow.GetItemIDByType(CraftingInfo.Tools[skillTid], 0)

							-- open the tool
							UserActionUseItem(toolId, false)

							-- open the item details
							Interface.ExecuteWhenAvailable({ name = "MaterialOpenItemDetails", check = function() return GumpsParsing.ParsedGumps[GenericGump.CRAFTING_GUMPID] ~= nil end, callback = function() GumpsParsing.GetCraftingToolItemDetails(tid, instance) end, maxTime = Interface.TimeSinceLogin + 1, delay = Interface.TimeSinceLogin + 0.5, removeOnComplete = true })
						end

						-- set the current item name in the search so we can find it easily when we are done with the material
						GumpsParsing.CraftingToolLastSearch = GetStringFromTid(currItemTid)
						
						-- store the current tool name for the search
						GumpsParsing.LastTool = skillName
					end

					return
				end
			end
		end
	end

	-- execute the default action for pressing the label
    GenericGumpOnClicked(WindowGetId(windowName), windowName)
end

function GenericGump.OnHyperLinkClicked(link)

	-- open the web browser
    Interface.WebCall(link)
end

function GenericGump.OnMouseOverEnd()

	-- reset the flag that indicates we're seeing a gump item property
	GenericGump.CurrentOver = ""

	-- chear the item properties
	ItemProperties.ClearMouseOverItem()

	-- is this an highlighted label?
	if SystemData.ActiveWindow.name == GenericGump.HighlightedLabel and GenericGump.HighlightedLabel ~= GumpsParsing.CraftingToolHighlightedLabel then
		
		-- remove the highlight
		LabelSetTextColor(GenericGump.HighlightedLabel, 255, 255, 255)

		-- remove the stored variable
		GenericGump.HighlightedLabel = nil
	end
end

function GenericGump.OnItemRelease()
	
	-- get the current element name
	local windowName = SystemData.ActiveWindow.name

	-- get the gump main window name, gump ID and element ID
	local parent, gumpId, id = GumpsParsing.GetElementData(windowName)

	-- do we have the gump ID and is the EJ bank?
	if not gumpId or (gumpId ~= GenericGump.EJ_BANK_GUMPID and gumpId ~= GenericGump.JEWELBOX_GUMPID) then
		return
	end

	-- is this the EJ bankbox gump?
	if gumpId == GenericGump.EJ_BANK_GUMPID then

		-- is the bank actions gump active?
		if not GumpData.Gumps[GenericGump.BANK_ACTIONS_GUMPID] then

			-- send an error message so the player will know that he has to re-open the bankbox
			ChatPrint(GetStringFromTid(373), 1)
			return
		end

		-- are we dragging an item?
		if SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM then

			-- target the item we tried to release (phase 1: drop to backpack)
			GenericGump.TargetDrag = 1
		end

	-- is this the jewelry box gump?
	elseif gumpId == GenericGump.JEWELBOX_GUMPID then

		-- are we dragging an item?
		if SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM then

			-- target the item we tried to release (phase 1: drop to backpack)
			GenericGump.JewTargetDrag = 1
		end
	end
end

function GenericGump.GetReforgingDesc(index)

	-- generates a table with all the lines of this tid
	local desc = wstring.split(GetStringFromTid(1151965), L"<br>") --Powerful Re-Forging causes the item to have slightly more magical power.<br><br>Structural Re-Forging causes the item to have more magical power, but the item will be Brittle.<br><br>Fortified Re-Forging causes the item to have higher durability.<br><br>Fundamental Re-Forging causes the item to have significantly more magical power, but the item cannot be repaired. Its durability will be increased.<br><br>Integral Re-Forging further increases the item's durability.<br><br>Grand Artifice guarantees that the resulting item will have one name, either a prefix or a suffix.<br><br>Inspired Artifice allows you to choose which name will be added to the item.<br><br>Exalted Artifice guarantees that the item will have two names, both a prefix and a suffix.<br><br>Sublime Artifice allows you to choose a name to be added to the item.<br><br>You must use both Inspired Artifice and Sublime Artifice in conjunction if you wish to choose both names to add to the item.

	-- return the required line
	return desc[index]
end

function GenericGump.ClearRunicAtlasData()

	-- do we have the gump data for the runic atlas?
	if GumpData and not GumpData.Gumps[GenericGump.RUNIC_ATLAS_GUMPID] then

		-- reset the runic atlas locked flag
		GumpsParsing.RunicAtlasLocked = false

		-- reset the runic atlas ID
		GumpsParsing.RunicAtlasID = 0
	end
end

function GenericGump.DragVirtue()

	-- get the current element name
	local windowName = SystemData.ActiveWindow.name

	-- get the gump main window name, gump ID and element ID
	local parent, gumpId, id = GumpsParsing.GetElementData(windowName)
	
	-- is the virtue gump open?
	if gumpId ~= GenericGump.VIRTUE_GUMP_GUMPID then
		WindowSetMoving(parent, true)
		return
	end

	-- humility = 2
	-- valor = 3
	-- honor = 4
	-- sacrifice = 5
	-- compassion = 6
	-- spirituality = 7
	-- justice = 8
	-- honesty = 9

	-- get the action ID for the virtue
	local actionId = GenericGump.VirtueImagesTable[id]

	-- if we don't have the action ID, it means the player have not clicked a virtue.
	if not actionId then
		WindowSetMoving(parent, true)
		return
	end

	-- preventing the player from dropping duplicate virtues (only certain generic actions can be used multiple times)
	local alreadyInBar, existingSlot = HotbarSystem.ActionAlreadyInHotbar(actionId, SystemData.UserAction.TYPE_INVOKE_VIRTUE)

	-- is the virtue already in an hotbar?
	if alreadyInBar then
		
		-- highlight the virtue in the current hotbar slot
		HotbarSystem.GlowSlotWarning(existingSlot, 5, actionId)

		-- send a chat error
		ChatPrint(GetStringFromTid(285), SystemData.ChatLogFilters.SYSTEM)

		return
	end

	-- drag the virtue
	DragSlotSetActionMouseClickData(SystemData.UserAction.TYPE_INVOKE_VIRTUE, ActionsWindow.ActionData[actionId].invokeId, ActionsWindow.ActionData[actionId].iconId)
end

function GenericGump.IsShopGump()

	-- do we have the labels array?
	if not GenericGump.LastGumpLabels or table.countElements(GenericGump.LastGumpLabels) <= 0 then
		return false
	end

	-- get the "Cart:" text from tid
	local cart = wstring.trim(wstring.sub(GetStringFromTid(1156593), 1, wstring.find(GetStringFromTid(1156593), L"~", 1, true) - 1)) -- Cart: ~1_val~/~2_val~

	-- scan all the gump labels
	for gumpID, labelData in pairsByIndex(GenericGump.LastGumpLabels) do

		-- scan all the labels for this gump
		for i, label in pairsByIndex(labelData) do

			-- does the label still exist?
			if DoesWindowExist(label.windowName) then

				-- get the current label text
				local currLabel = LabelGetText(label.windowName)

				-- is this the "Cart:" label? then it's the shop gump
				if currLabel and wstring.find(currLabel, cart, 1, true) then
					return true
				end
			end
		end
	end

	-- not the shop
	return false
end

function GenericGump.ParseTooltipItemProperties(windowName, tooltipText, objectType, hue)

	-- do we have valid parameters?
	if not IsValidString(windowName) or not IsValidWString(tooltipText) then
		return
	end

	-- split the tooltip lines into an array
	local lines = wstring.split(tooltipText, L"\n")

	-- if the tooltip has less than 2 lines, is not an item
	if #lines < 2 then
		
		-- show the tooltip
		Tooltips.CreateTextOnlyTooltip(windowName, tooltipText)

		return
	end

	-- format properly the item name
	lines[1] = FormatProperly(lines[1])

	-- initialize the "fake" properties array
	local fakeProps = {}

	-- initialize the properties tid array
	fakeProps.PropertiesTids = {}

	-- initialize the tid parameters
	fakeProps.PropertiesTidsParams = {}

	-- copy the lines into the properties list
	fakeProps.PropertiesList = table.copy(lines)
	
	-- initialize the color data (we don't need this since they are used only on mobiles, so we initialize them as default values)
	fakeProps.CustomColorTitle = {}
	fakeProps.CustomColorBody = {}
	fakeProps.CustomColorTitle.NotorietyEnable = false
	fakeProps.CustomColorTitle.NotorietyIndex = 0
	fakeProps.CustomColorBody.LabelIndex = 0
	fakeProps.CustomColorBody.Color = {r=0, g=0, b=0}

	-- name of all the properties tables
	local propertiesTables = {
		"ItemPropertiesInfo.FullSetPropertiesConvert",
		"ItemPropertiesInfo.WeightTid",
		"ItemPropertiesInfo.SetProperties",
		"ItemPropertiesInfo.NotListed",
		"ItemPropertiesInfo.DecoProperties",
		"ItemPropertiesInfo.AllProperties",
	}

	-- flag that indicates that the previous line and the current line are one single property
	local prevUses2Lines = false

	-- flag that indicates that every property after is set will be a description (used for full set bonuses)
	local descFromNowOn = false

	-- base index for the description property
	local descCount = 348

	-- scan the raw lines of properties trying to identify the right property and params
	for i, rawData in pairsByIndex(lines) do

		if wstring.trim(rawData) == L"" then
			
			continue
		end

		-- this line and the previous one are a single property.
		if prevUses2Lines then

			-- flag that the double line has been processed
			prevUses2Lines = false

			-- skip to the next line
			continue
		end

		-- flag which indicates that we have identified the property
		local found = false

		-- removing comma from numbers and the spaces at the beginning and the end of the string. Also turning the string in lower case.
		local clean = wstring.lower(wstring.trim(wstring.gsub(towstring(rawData), L",", L"")))

		-- get the numeric value in the property
		local value = wstring.match(towstring(clean), L"%d*%.?%d+")

		-- initialize the second value
		local value2

		-- get the second numeric value in the property (if it exist)
		if value then
			value2 = wstring.match(towstring(wstring.gsub(clean, value, L"", 1)), L"%d*%.?%d+")
		end

		-- do we have a valid wstring for the property text?
		if not IsValidWString(clean) then
			
			-- this was an empty line
			continue
		end

		-- is this a property? (not the item name?)
		if i ~= 1 then

			-- scan all the arrays to find the property
			for _, strArray in pairsByIndex(propertiesTables) do

				-- get the table for the array string name
				local array = GetDynamicVariableValue(strArray)

				-- scan the array
				for tid, extra in pairs(array) do

					-- store the value 2 in a temporary variable (to be modified for certain properties)
					local tempValue = value 

					-- weapon speed requires seconds after the value
					if tid == 1061167 and tempValue then
						tempValue = tempValue .. L"s"

					-- the price needs a comma
					elseif tid == 1043304 and tempValue then
						tempValue = StringUtils.AddCommasToNumber(tempValue)
					end

					-- get the property text with the same value of the property we're looking for
					local tidString = wstring.lower(ReplaceTokens(GetStringFromTid(tid), {towstring(tempValue), towstring(value2)}))

					-- if we don't have a valid string, we can skip to the next
					if not IsValidWString(tidString) then	
						continue
					end

					-- have we found the property?
					local verified = wstring.lower(rawData) == tidString

					-- initialize a stripped tid string to be used for few properties
					local strippedTid = L""
					
					-- is this the engrave? (weapon/armor)
					if tid == 1062613 and verified then

						-- remove the quotes from the text to get only the custom text
						tempValue = wstring.trim(wstring.gsub(rawData, L'"', L""))

					-- engrave and seller description require a special treatment
					elseif tid == 1043305 or tid == 1072305 or tid == 1072378 then

						-- remove the tokens
						strippedTid = ReplaceTokens(wstring.lower(GetStringFromTid(tid)), {L""})
						
						-- remove the br tags
						strippedTid = wstring.gsub(strippedTid, L"<br>", L"")

						-- remove the quotes
						strippedTid = wstring.gsub(strippedTid, L'"', L"")

						-- is this the seller description?
						if tid == 1043305 and lines[i+1] and wstring.find(clean, strippedTid, 1, true) then

							-- the seller description uses also the next line
							local sellerDescription = clean .. lines[i+1]

							-- remove the tid text to get only the custom text
							sellerDescription = wstring.gsub(sellerDescription, strippedTid, L"")

							-- remove the quotes and we have the custom text
							tempValue = wstring.gsub(sellerDescription, L'"', L"")

							-- flag that this line and the next are a single property
							prevUses2Lines = true
						end

						-- is this the engrave?
						if tid == 1072305 and wstring.find(clean, strippedTid, 1, true) then

							-- remove the tid text to get only the custom text
							tempValue = wstring.trim(wstring.gsub(clean, strippedTid, L""))
						end

						-- is this the property?
						verified = verified or wstring.find(clean, strippedTid, 1, true) ~= nil
					end

					-- talsiman crafting bonus
					if tid == 1072394 or tid == 1072395 then

						-- is it a crafting skill bonus?
						strippedTid = ReplaceTokens(wstring.lower(GetStringFromTid(extra.setTid)), {wstring.split(clean, L" ")[1], tempValue})

						-- is this the property?
						verified = verified or wstring.lower(rawData) == tidString
					end

					-- some set description requires an extra check
					if descFromNowOn and type(extra) == "table" and extra.setTid then
						
						-- fill the tokens
						strippedTid = ReplaceTokens(wstring.lower(GetStringFromTid(extra.setTid)), {clean, tempValue})
						
						-- is this the property?
						verified = verified or wstring.lower(rawData) == strippedTid
					end

					-- is the current line the same as the tid property we generated? or is a seller description or an engrave
					if verified then
					
						-- Only when full set is present:
						if tid == 1072378 then
							descFromNowOn = true
						end

						-- add the tid to the properties tid array
						table.insert(fakeProps.PropertiesTids, tid)

						-- do we have a value?
						if tempValue then
							
							-- add the value to the tid params
							table.insert(fakeProps.PropertiesTidsParams, L"@" .. tid)
							table.insert(fakeProps.PropertiesTidsParams, tempValue)
							table.insert(fakeProps.PropertiesTidsParams, value2)
						end

						-- mark the property as found
						found = true

						break
					end
				end

				-- since we've found the property we don't need to scan other arrays
				if found then
					break
				end
			end
		end

		-- if we didn't find the properties for this line on all the ones that we know, we use ~1_NOTHING~ and the whole text will be as param
		-- we have 25 slots for that
		if not found then
			
			-- add the description property
			table.insert(fakeProps.PropertiesTids, descCount)
			table.insert(fakeProps.PropertiesTidsParams, L"@" .. descCount)
			table.insert(fakeProps.PropertiesTidsParams, FormatProperly(rawData))

			-- increase the description property id
			descCount = descCount + 1
		end
	end

	-- set that we are current over a vendor search result item
	GenericGump.CurrentOver = "VSEARCH"
	
	-- copy the fake property in the active properties table
	WindowData.ItemProperties[0] = table.copy(fakeProps)

	-- create the properties window data
	local itemData = { windowName = windowName,
					   itemId = 2, -- random number for item ID
		    		   itemType = WindowData.ItemProperties.TYPE_ITEM,
		    		   detail = ItemProperties.DETAIL_LONG,
					   objectType = objectType,
					   hue = hue
					}

	-- show the item properties
	ItemProperties.SetActiveItem(itemData)     
end

function GenericGump.GetAllItemProperties(gump)

	-- array for all the properties of all the items in the gump
	local allProps = {}

	-- scan all the active gumps
	for gumpID, data in pairs(GumpData.Gumps) do

		-- is this the gump we're looking for?
		if gumpID == gump then

			-- scan all the images
			for id, button in pairs(data.Buttons) do

				-- get the object ID for the gump element
				local objectId = GenericGumpGetItemPropertiesId(WindowGetId(button), button)

				-- do we have a valid item ID?
				if not IsValidID(objectId) then
					continue
				end

				-- acquire the item properties for the item
				allProps[objectId] = Interface.GetItemPropertiesData(objectId, "All gump properties GumpID: " .. gumpID)
			end
		end
	end

	return allProps
end

function GenericGump.GetButtonIDByItemID(gump, itemID)

	-- scan all the active gumps
	for gumpID, data in pairs(GumpData.Gumps) do

		-- is this the gump we're looking for?
		if gumpID == gump then

			-- scan all the images
			for id, button in pairs(data.Buttons) do

				-- get the object ID for the gump element
				local objectId = GenericGumpGetItemPropertiesId(WindowGetId(button), button)

				-- do we have a valid item ID?
				if not IsValidID(objectId) then
					continue
				end

				-- is this the item we're looking for?
				if objectId == itemID then

					-- return the button ID
					return id, button
				end
			end
		end
	end
end

function GenericGump.HelpMenuButtonClick(GumpID, buttonID)

	-- help menu
	if GumpID == GenericGump.HELP_MENU_GUMPID then

		-- initialize the shop button ID variable
		local shopButton 

		-- search for the labels values
		for id, data in pairsByKeys(GumpData.Gumps[GumpID].Labels) do

			-- is this the store label?
			if data.tid and data.tid == 1156863 then -- <u>Ultima Store:</u> Select this option if you would like to purchase in-game items or have a promotional code that you wish to redeem with this character or account.

				-- the shop button is the label ID
				shopButton = id
			end
		end

		-- is this the shop button?
		if shopButton and buttonID == shopButton then

			-- flag that the next gump will be the shop
			GenericGump.NextisShop = true

			-- start the timer to check if the gump is still open
			GenericGump.shoptime = Interface.TimeSinceLogin + 1
		end
	end
end

function GenericGump.NewStoreItemButtonClick(GumpID, buttonID)

	-- new item in store gump
	if GumpID == GenericGump.NEW_STORE_ITEM_GUMPID then

		-- ok button
		if buttonID == 1 then
			
			-- flag that the next gump will be the shop
			GenericGump.NextisShop = true

			-- start the timer to check if the gump is still open
			GenericGump.shoptime = Interface.TimeSinceLogin + 1
		end
	end
end

function GenericGump.PetVendorButtonClick(GumpID, buttonID)

	-- is this a magincia pet vendor?
	if GumpID == GenericGump.MAGINCIA_PET_VENDOR_GUMPID then

		-- there are 10 pets per page, the lore button is 2, the next +3 and so on...
		if ((buttonID - 2) % 3) == 0 and buttonID <= 32 then

			-- get the id (from 0 to 9) of the pet in the list
			local pressedOrderID = (buttonID - 2) / 3

			-- if the number is higher than 9, then it's not the lore button
			if pressedOrderID <= 9 then
				
				-- the ID for the pet id in the labels text starts from 1 then we get another id every 4
				local petID = (pressedOrderID * 4) + 1

				-- the pet type is 2 labels after the ID
				local labelID = (pressedOrderID * 4) + 3

				-- get the pet type from the label
				local petType = WindowUtils.translateMarkup(GumpData.Gumps[GenericGump.MAGINCIA_PET_VENDOR_GUMPID].LabelsText[labelID])

				-- do we have a valid pet type?
				if IsValidWString(petType) then

					-- set the current pet ID as animal lore target ID
					AnimalLore.VendorPetType = petType

					-- remove the animal lore target ID
					AnimalLore.TargetID = tonumber(GumpData.Gumps[GenericGump.MAGINCIA_PET_VENDOR_GUMPID].LabelsText[petID]) or 0
				end
			end
		end
	end
end

function GenericGump.BoatPlacementButtonClick(GumpID, buttonID)

	-- boat placement
	if GumpID == GenericGump.BOAT_PLACEMENT_GUMPID then

		-- get the direction the boat is placed
		if buttonID == 1 then
			buttonID = Actions.BoatDirections.West

		elseif buttonID == 2 then
			buttonID = Actions.BoatDirections.North

		elseif buttonID == 3 then
			buttonID = Actions.BoatDirections.South

		elseif buttonID == 4 then
			buttonID = Actions.BoatDirections.East
		end

		-- save the direction for the smart boat commands
		Interface.LastBoatDirection = buttonID
		Interface.SaveSetting("LastBoatDirection", Interface.LastBoatDirection)
	end
end

function GenericGump.QuestResignButtonClick(GumpID, buttonID)

	-- quest resign
	if GumpID == GenericGump.QUEST_RESIGN_GUMPID then
	
		-- confirm button
		if buttonID == 3 then

			-- raise the event for the resigned quest
			QuestLog.QuestResigned()
		end
	end
end

function GenericGump.CustomizeVendorButtonClick(GumpID, buttonID)

	-- player vendor customize
	if GumpID == PlayerVendor.CustomizeGumpID then

		-- hair color
		if buttonID == 12 then
			DyeTubs.VendorHairBeard = 0

		-- beard color
		elseif buttonID == 21 then
			DyeTubs.VendorHairBeard = 1

		-- close
		elseif buttonID == 1 then
			
			-- re-open the vendor customization main window
			UserActionUseItem(PlayerVendor.MobileId, false)
		end

		-- make sure the paperdoll for the vendor is open (unless we're closing the gump or using dyes)
		if buttonID ~= 1 then

			-- update the gump picture
			PlayerVendor.ShowEquipment()
		end
	end
end

function GenericGump.DaviesLockerButtonClick(GumpID, buttonID)

	-- davie's locker
	if GumpID == GenericGump.DAVIES_LOCKER_GUMPID then
		
		-- button 5 = add map
		
		-- is the "Get" button?
		if buttonID >= 6 and buttonID <= 15 then

			-- get the data for the map we got out
			local data = GumpsParsing.DaviesLockerData[buttonID - 5]

			-- did we got a decoded map?
			if data and not data.completed and data.isTmap and data.coords and data.coords.x then

				-- create the waypoint data for the current retrieved map
				GenericGump.MapRetrievedData = { facet = data.coords.map, x = data.coords.x, y = data.coords.y, z = 0, type = MapCommon.WaypointCustomType, name = data.mapName, Icon = 100113, Scale = 1.5 }
			end
		end
	end
end

function GenericGump.CraftingGumpButtonClick(GumpID, buttonID)

	-- is this the crafting gump?
	if GumpID ~= GenericGump.CRAFTING_GUMPID then
		return
	end

	-- get the crafting skill name
	local skillName = GumpsParsing.ParsedGumps[GenericGump.CRAFTING_GUMPID]

	-- if we don't have the skill name, the crafting gump is not open
	if not skillName then
		return
	end
	
	-- get the categories button start ID
	local startId = GumpsParsing.MapCraftingToolGetFirstCatButton(GenericGump.CRAFTING_GUMPID)

	-- get the number of categories in this tool
	local totalCat = CraftingInfo.ToolMap[skillName].totalCategories

	-- calculate the button ID
	local btnId = startId + totalCat + GumpsParsing.ToolMaterialsCount(skillName) + GumpsParsing.ToolHasEnhance(skillName)

	-- virtual max number of pages
	local maxPages = 100

	-- search if the button pressed is a prev/next page button
	for page = 1, maxPages do

		-- is this the first page?
		if page == 1 then

			-- in the first page we have 20 buttons for the items + the next page button
			local nextPage = btnId + 21

			-- is this the next page button?
			if buttonID == nextPage then

				-- increase the current page index
				GumpsParsing.CraftingToolCurrentPage = GumpsParsing.CraftingToolCurrentPage + 1

				return
			end

		else -- any other page
				
			-- calculate the next page button offset
			local nextPage = btnId + (20 * (page - 1)) + (1 + ((page - 2) * 2))

			-- the prev page is the button after next
			local prevPage = nextPage + 1

			-- is this the next page button?
			if buttonID == nextPage then

				-- increase the current page index
				GumpsParsing.CraftingToolCurrentPage = GumpsParsing.CraftingToolCurrentPage + 1

				return

			-- is this the prev page button?
			elseif buttonID == prevPage then

				-- increase the current page index
				GumpsParsing.CraftingToolCurrentPage = GumpsParsing.CraftingToolCurrentPage - 1

				return

			-- did we passed the button? then is not a page next/prev button
			elseif buttonID < nextPage then
				break
			end
		end
	end

end

function GenericGump.ShowCraftingGumpItemTooltip(itemTid, itemData, windowName, instance, itemDetails)

	-- is this label NOT highlighted (by the search result)
	if not GenericGump.HighlightedLabel or GenericGump.HighlightedLabel ~= GumpsParsing.CraftingToolHighlightedLabel then

		-- store the label name
		GenericGump.HighlightedLabel = windowName

		-- highlight the label
		LabelSetTextColor(GenericGump.HighlightedLabel, GenericGump.HighlightColor.r, GenericGump.HighlightColor.g, GenericGump.HighlightColor.b)
	end

	-- get the item name
	local itemName = FormatProperly(GetStringFromTid(itemTid))

	-- is this the item details tooltip?
	if itemDetails then

		-- get the skill ID required to craft the material (if available)
		local skillTid = GumpsParsing.CraftingToolGetToolRequired(itemTid)

		-- add the skill name under the item name
		itemName = itemName .. L"\n" .. FormatProperly(ReplaceTokens(GetStringFromTid(615), {  wstring.trim(GetStringFromTid(skillTid)) }))
	end

	local tooltipText = 
	{
		[1] = { itemName, L" " },
		[2] = { L" ", L" " },
		[3] = { FormatProperly(GetStringFromTid(1044457)) .. L":", L" " },
	}

	local tooltipColors = {}

	-- get the materials list
	local materials = itemData.materials

	-- we need the materials of the second instance
	if instance == 2 then
		materials = itemData.materials2
	end
	
	-- scan the materials
	for tid, amount in pairs(materials) do

		-- get the skill ID required to craft the material (if available)
		local skillTid = GumpsParsing.CraftingToolGetToolRequired(tid)

		-- initialize the tooltip text
		local text = FormatProperly(GetStringFromTid(tid))

		-- do we have the material description?
		if skillTid then

			-- add the skill required to craft the item
			text = text .. L"\n" .. FormatProperly(ReplaceTokens(GetStringFromTid(615), {  wstring.trim(GetStringFromTid(skillTid)) }))
		end

		-- add the materials to the tooltip
		table.insert(tooltipText, { text .. L"\n", L"x " .. amount })
	end

	-- add an empty line
	table.insert(tooltipText, { L" ", L"" })

	-- add the skills sub-title
	table.insert(tooltipText, { FormatProperly(GetStringFromTid(1115030)) .. L":", L" " }) -- Skills

	-- get the skills list
	local skills = itemData.skills

	-- we need the skills of the second instance
	if instance == 2 then
		skills = itemData.skills2
	end

	-- scan the materials
	for tid, amount in pairs(skills) do

		-- add the materials to the tooltip
		table.insert(tooltipText, { FormatProperly(GetStringFromTid(tid)), SkillsWindow.FormatSkillValue(amount) })
	end

	-- does this item requires a recipe?
	if itemData.recipe then

		-- add an empty line
		table.insert(tooltipText, { L" ", L"" })

		-- add the "Requires a recipe" text
		table.insert(tooltipText, { GetStringFromTid(606), L"" })
	end

	-- does this item retains the material color??
	if itemData.retainsColor then

		-- add an empty line
		table.insert(tooltipText, { L" ", L"" })

		-- add the "Requires a recipe" text
		table.insert(tooltipText, { GetStringFromTid(612), L"" })
	end

	-- does this item requires stygian abyss?
	if itemData.requiresSA then

		-- add an empty line
		table.insert(tooltipText, { L" ", L"" })

		-- add the "Requires a recipe" text
		table.insert(tooltipText, { GetStringFromTid(607), L"" })

		-- is the feature disabled for the account?
		if not Interface.ActiveAccountFeatures["Stygian_Abyss"] then

			-- set the color to red
			tooltipColors[#tooltipText] = { r = 255, g = 0, b = 0 }
		end
	end

	-- does this item requires high seas?
	if itemData.requiresHS then

		-- add an empty line
		table.insert(tooltipText, { L" ", L"" })

		-- add the "Requires a recipe" text
		table.insert(tooltipText, { GetStringFromTid(608), L"" })

		-- is the feature disabled for the account?
		if not Interface.ActiveAccountFeatures["High_Seas"] then

			-- set the color to red
			tooltipColors[#tooltipText] = { r = 255, g = 0, b = 0 }
		end
	end

	-- does this item requires rustic booster?
	if itemData.requiresRustic then

		-- add an empty line
		table.insert(tooltipText, { L" ", L"" })

		-- add the "Requires a recipe" text
		table.insert(tooltipText, { GetStringFromTid(609), L"" })

		-- is the feature disabled for the account?
		if not Interface.ActiveAccountFeatures["Rustic_Addon"] then

			-- set the color to red
			tooltipColors[#tooltipText] = { r = 255, g = 0, b = 0 }
		end
	end

	-- does this item requires gothic booster?
	if itemData.requiresGothic then

		-- add an empty line
		table.insert(tooltipText, { L" ", L"" })

		-- add the "Requires a recipe" text
		table.insert(tooltipText, { GetStringFromTid(610), L"" })

		-- is the feature disabled for the account?
		if not Interface.ActiveAccountFeatures["Gothic_Addon"] then

			-- set the color to red
			tooltipColors[#tooltipText] = { r = 255, g = 0, b = 0 }
		end
	end

	-- does this item requires time of legend?
	if itemData.requiresToL then

		-- add an empty line
		table.insert(tooltipText, { L" ", L"" })

		-- add the "Requires a recipe" text
		table.insert(tooltipText, { GetStringFromTid(611), L"" })

		-- is the feature disabled for the account?
		if not Interface.ActiveAccountFeatures["Time_of_Legend"] then

			-- set the color to red
			tooltipColors[#tooltipText] = { r = 255, g = 0, b = 0 }
		end
	end

	-- is this the item details window?
	if itemDetails then

		-- add an empty line
		table.insert(tooltipText, { L" ", L"" })

		-- add the "click to craft this material"
		table.insert(tooltipText, { GetStringFromTid(655), L"" })
	end

	-- reset the tooltip
	Tooltips.ClearTooltip()

	-- create the tooltip lines
	for i, text in pairsByKeys(tooltipText) do
	
		-- add an empty line
		Tooltips.SetTooltipText(i, 1, text[1])

		-- add an empty line
		Tooltips.SetTooltipText(i, 2, text[2])

		-- do we have a color for this label?
		if tooltipColors[i] then

			-- set the text color
			Tooltips.SetTooltipColor(i, 1, tooltipColors[i].r, tooltipColors[i].g, tooltipColors[i].b)

			-- set the text color
			Tooltips.SetTooltipColor(i, 2, tooltipColors[i].r, tooltipColors[i].g, tooltipColors[i].b)

		else -- no color

			-- set the text color
			Tooltips.SetTooltipColor(i, 1, 255, 255, 255)

			-- set the text color
			Tooltips.SetTooltipColor(i, 2, 255, 255, 255)
		end

		-- is this the title?
		if i == 1 then
		
			-- set a bold title font
			Tooltips.SetTooltipFont(i, 1, GenericGump.BoldFontTitle)

			-- set the font color
			Tooltips.SetTooltipColor(i, 1, Interface.Settings.Props_TITLE_COLOR.r, Interface.Settings.Props_TITLE_COLOR.g, Interface.Settings.Props_TITLE_COLOR.b)

		-- is this a sub-title?
		elseif not IsValidWString(text[2]) then

			-- set a bold font
			Tooltips.SetTooltipFont(i, 1, GenericGump.BoldFont)
		
		else -- rest of the text

			-- set a normal font
			Tooltips.SetTooltipFont(i, 1, GenericGump.NormalFont)
			Tooltips.SetTooltipFont(i, 2, GenericGump.NormalFont)

			-- align the second column text to the top-center
			Tooltips.SetTooltipTextAlignment(i, 2, "top")
		end
	end

	-- set the tooltip mouse over window
	Tooltips.SetMouseOverWindow(windowName)

	-- show the tooltip
	Tooltips.Finalize()

	-- anchor the tooltip
	Tooltips.AnchorTooltip(Tooltips.ANCHOR_WINDOW_TOP)
end