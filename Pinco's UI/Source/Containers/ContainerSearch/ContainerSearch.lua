
----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

ContainerSearch = {}

ContainerSearch.Container = 0
ContainerSearch.Gump = 0
ContainerSearch.SearchResult = {}
ContainerSearch.TotalItems = 0
ContainerSearch.MaxItems = 0

ContainerSearch.Slots = {} 

function ContainerSearch.Initialize()

	-- current window name
	local windowName = "ContainerSearchWindow"

	-- enable snap for the window
	SnapUtils.SnappableWindows[windowName] = true

	-- set the window title
	LabelSetText(windowName .. "InfoText", GetStringFromTid(1154791)) -- Item Search

	-- load the window position
	WindowUtils.RestoreWindowPosition("ContainerSearchWindow")
end

function ContainerSearch.Shutdown()

	-- close the window
	ContainerSearch.Close()

	-- save the window position
	WindowUtils.SaveWindowPosition("ContainerSearchWindow")

	-- remove the window from the snap list
	SnapUtils.SnappableWindows["ContainerSearchWindow"] = nil
end

function ContainerSearch.Close()

	-- clear the item properties
	ItemProperties.ClearMouseOverItem()

	-- reset the search
	ContainerSearch.Reset()

	-- hide the window
	WindowSetShowing("ContainerSearchWindow", false)
end

function ContainerSearch.Toggle()

	-- is the window visible?
	if WindowGetShowing("ContainerSearchWindow") then

		-- close the window
		ContainerSearch.Close()

	else -- show the window
		WindowSetShowing("ContainerSearchWindow", true)

		-- reset the search
		ContainerSearch.Restart()
	end
end

function ContainerSearch.ClearItemList()

	-- scan all created items
	for i, slot in pairsByIndex(ContainerSearch.Slots)  do
	 
		-- does this slot still exist?
		if DoesWindowExist(slot) then

			-- destroy the slot
			DestroyWindow(slot)
		end
	end

	-- reset the slot list
	ContainerSearch.Slots = {}
end

function ContainerSearch.Reset()
	
	-- delete all item slots
	ContainerSearch.ClearItemList()

	-- reset all variables
	ContainerSearch.Container = 0
	ContainerSearch.Gump = 0
	ContainerSearch.Items = {}
	ContainerSearch.SearchResult = {}
	SearchBox.Classes.ContainerSearch.filtersTable = {}
	ContainerSearch.TotalItems = 0
	ContainerSearch.MaxItems = 0

	-- update the scroll window
	ScrollWindowUpdateScrollRect( "ContainerSearchSW" )   	
	
	-- reset the scroll location to the top
	ScrollWindowSetOffset("ContainerSearchSW", 0)
end

function ContainerSearch.OnLButtonUpSearch()
	
	-- get the text from the search box
	local text = SearchBox.GetFilter("ContainerSearchWindowSearchBox", true)

	-- start the search with the content of the text box
	ContainerSearch.SearchText(text)
end

function ContainerSearch.DoesPatternExist(text)
	
	-- do we have a valid text to search?
	if not IsValidWString(text) then
		return true
	end

	-- make the text in lower case for an easier parsing
	text = wstring.lower(text)

	-- scan all the patterns in the array
	for k, filter in pairsByIndex(SearchBox.Classes.ContainerSearch.filtersTable) do
		
		-- is this pattern the same as the entered text?
		if text == filter then
			return true
		end
	end

	return false
end

function ContainerSearch.DoesPropertyContainText(propText, text)

	-- do we have a valid text to search?
	if not IsValidWString(text) or not IsValidWString(propText) then
		return false
	end

	-- if the text to search is * then we want to list all items
	if text == L"*" then
		return true
	end

	-- convert the property in lower case
	propText = wstring.lower(propText)

	-- convert the search pattern in lower case
	text = wstring.lower(text)

	-- find if the text to find has quotation marks
	local m_start = wstring.find(text, L"\"")

	-- initialize variable for the closing quotation marks
	local m_end

	-- do we have the quotation marks?
	if m_start then

		-- find the closing quotation marks
		m_end = wstring.find(text, L"\"", m_start + 1)

		-- take the text without quotation marks
		text = wstring.sub(text, m_start + 1, m_end - 1)
	end

	-- if the text to find is between quotation marks, we must find an exact match
	if m_start and m_end then
		return propText == text

	else -- check if the property is equal to the text or if it contains it
		return propText == text or wstring.find(propText, text, 1, true)
	end
end

function ContainerSearch.SearchText(text, refilter)

	-- do we have a valid text to search?
	if not refilter and not IsValidWString(text) then
		return
	end

	-- make sure the pattern doesn't exist already, if it does, we re-filter instead
	if not refilter and ContainerSearch.DoesPatternExist(text) then
		refilter = true
	end

	-- do we have to refilter the container?
	if not refilter then

		-- do we have the default "show all" pattern active?
		if ContainerSearch.DoesPatternExist(L"*") then

			-- reset the patterns
			SearchBox.Classes.ContainerSearch.filtersTable = {}
		end

		-- make the text in lower case for an easier parsing
		text = wstring.lower(text)

		-- add the pattern to the list
		table.insert(SearchBox.Classes.ContainerSearch.filtersTable, text)
	end
	
	-- clear the items list
	ContainerSearch.ClearItemList()

	-- initialize the search result array
	ContainerSearch.SearchResult = {}

	-- initialize total items found counter
	ContainerSearch.TotalItems = 0

	-- are we searching the items in a gump?
	if IsValidID(ContainerSearch.Gump) then

		-- get all the items in the container
		local AllItems = GenericGump.GetAllItemProperties(ContainerSearch.Gump)

		-- do we have any item?
		if not AllItems then
			return
		end

		-- search all the items in the container
		ContainerSearch.SearchGumpItems(AllItems)

	-- are we searching the items in a container?
	elseif IsValidID(ContainerSearch.Container) then

		-- get all the items in the container
		local AllItems = ContainerWindow.ScanQuantities(ContainerSearch.Container, true)

		-- do we have any item?
		if not AllItems then
			return
		end

		-- search all the items in the container
		ContainerSearch.SearchItems(AllItems)
	end

	-- current window name
	local dialog = "ContainerSearchSW"

	-- update the total items label
	LabelSetText("ContainerSearchWindowTotal", ReplaceTokens( GetStringFromTid(1154793), { towstring(ContainerSearch.TotalItems) } ) ) -- Total Items: ~1_ITEMS~

	-- update the scrollable area
	ScrollWindowUpdateScrollRect(dialog)   	
	
	-- is this a refiltering?
	if not refilter then
		
		-- reset the scroll position
		ScrollWindowSetOffset(dialog, 0)	
	end
end

function ContainerSearch.SearchGumpItems(AllItems)
	
	-- current window name
	local dialog = "ContainerSearchSW"

	-- scroll window name
	local parent = dialog.. "ScrollChild"

	-- initialize previous window variable
	local lastlink

	-- scan all the items 
	for objectId, prop in pairs(AllItems) do
			
		-- do we have the properties?
		if not prop then
			continue
		end
		
		-- get the item object type
		local _, objectType = ItemPropertiesInfo.GetGumpTypeByName(prop.PropertiesList[1])

		-- array that contains all the found properties. If it contains the same amount of items as the patterns, then the item is a perfect match
		local found = {}

		-- scan all properties
		for j, p in pairsByIndex(prop.PropertiesList) do
						
			-- do we have a valid string for the property?
			if IsValidWString(p) then
							
				-- get the property text
				local propText = wstring.lower(p)

				-- is this the first property? (item name)
				if j == 1 then

					-- remove the quantity from the name
					propText = Shopkeeper.stripFirstNumber(p)
				end
							
				-- scan all patterns
				for k, pattText in pairsByIndex(SearchBox.Classes.ContainerSearch.filtersTable) do

					-- if we found one on this property we can get out
					if ContainerSearch.DoesPropertyContainText(propText, pattText) then

						-- add the property to the found list
						table.insert(found, propText)

						break
					end
				end
			end

			-- if we have found all the patterns then we can get out
			if #found == #SearchBox.Classes.ContainerSearch.filtersTable then
				break
			end
		end

		-- have we found the item?
		if #found == #SearchBox.Classes.ContainerSearch.filtersTable then

			-- add the item to the array
			ContainerSearch.SearchResult[objectId] = true

			-- increase the total items count
			ContainerSearch.TotalItems = ContainerSearch.TotalItems + 1

			-- current slot name
			local slotName = parent .. "Item" .. ContainerSearch.TotalItems

			-- current slot icon
			local elementIcon = parent .. "Item" .. ContainerSearch.TotalItems .. "Icon"

			-- current slot name label
			local elementName = parent .. "Item" .. ContainerSearch.TotalItems .. "Name"

			-- does the slot already exist?
			if not DoesWindowExist(slotName) then
				CreateWindowFromTemplate(slotName, "ItemTemplate", parent)
			end

			-- add the current slot to the slots array list
			table.insert(ContainerSearch.Slots, slotName)

			-- set the object ID on the slot and icon
			WindowSetId(slotName, objectId)
			WindowSetId(slotName .. "Icon", objectId)

			-- is this the first element?
			if ContainerSearch.TotalItems == 1 or not lastlink then

				-- anchor the element to the top-left of the scroll window
				WindowAddAnchor(slotName, "topleft", parent, "topleft", 0, 5)

			else -- anchor the element to the previous one
				WindowAddAnchor(slotName, "bottomleft", lastlink, "topleft", 0, 0)
			end

			-- update the slot item icon
			EquipmentData.DrawObjectIconAtWindowDimensions(objectType, 0, elementIcon)

			-- update item name
			LabelSetText(elementName, FormatProperly(prop.PropertiesList[1]))

			-- update the last element name with the current one
			lastlink = slotName
		end
	end
end

function ContainerSearch.SearchItems(AllItems)

	-- current window name
	local dialog = "ContainerSearchSW"

	-- scroll window name
	local parent = dialog.. "ScrollChild"

	-- initialize previous window variable
	local lastlink

	-- scan all the items 
	for objectType, hueItems in pairs(AllItems) do

		-- scan all the hue of this object type available
		for hueID, itemIds in pairs(hueItems) do

			-- scan all the item id of this object type & hue
			for objectId, amount in pairs(itemIds) do
			
				-- get the item data
				local itemData = Interface.GetObjectInfoData(objectId)

				-- do we have the item data?
				if itemData then
					
					-- get the item properties
					local prop = ItemProperties.GetObjectProperties( objectId, nil, "Container search - check properties" )
					
					-- do we have the properties?
					if not prop then
						continue
					end

					-- array that contains all the found properties. If it contains the same amount of items as the patterns, then the item is a perfect match
					local found = {}

					-- scan all properties
					for j, p in pairsByIndex(prop) do
						
						-- do we have a valid string for the property?
						if IsValidWString(p) then
							
							-- get the property text
							local propText = wstring.lower(p)

							-- is this the first property? (item name)
							if j == 1 then

								-- remove the quantity from the name
								propText = Shopkeeper.stripFirstNumber(p)
							end
							
							-- scan all patterns
							for k, pattText in pairsByIndex(SearchBox.Classes.ContainerSearch.filtersTable) do

								-- if we found one on this property we can get out
								if ContainerSearch.DoesPropertyContainText(propText, pattText) then

									-- add the property to the found list
									table.insert(found, propText)

									break
								end
							end
						end

						-- if we have found all the patterns then we can get out
						if #found == #SearchBox.Classes.ContainerSearch.filtersTable then
							break
						end
					end

					-- have we found the item?
					if #found == #SearchBox.Classes.ContainerSearch.filtersTable then

						-- add the item to the array
						ContainerSearch.SearchResult[objectId] = true

						-- increase the total items count
						ContainerSearch.TotalItems = ContainerSearch.TotalItems + 1

						-- current slot name
						local slotName = parent .. "Item" .. ContainerSearch.TotalItems

						-- current slot icon
						local elementIcon = parent .. "Item" .. ContainerSearch.TotalItems .. "Icon"

						-- current slot name label
						local elementName = parent .. "Item" .. ContainerSearch.TotalItems .. "Name"

						-- does the slot already exist?
						if not DoesWindowExist(slotName) then
							CreateWindowFromTemplate(slotName, "ItemTemplate", parent)
						end

						-- add the current slot to the slots array list
						table.insert(ContainerSearch.Slots, slotName)

						-- set the object ID on the slot and icon
						WindowSetId(slotName, objectId)
						WindowSetId(slotName .. "Icon", objectId)

						-- is this the first element?
						if ContainerSearch.TotalItems == 1 or not lastlink then

							-- anchor the element to the top-left of the scroll window
							WindowAddAnchor(slotName, "topleft", parent, "topleft", 0, 5)

						else -- anchor the element to the previous one
							WindowAddAnchor(slotName, "bottomleft", lastlink, "topleft", 0, 0)
						end

						-- update the slot item icon
						EquipmentData.UpdateItemIcon(elementIcon, itemData)

						-- update item name
						LabelSetText(elementName, itemData.name)

						-- update the last element name with the current one
						lastlink = slotName
					end
				end
			end
		end
	end
end

function ContainerSearch.UpdateList()
	
	-- do we have a valid container?
	if not IsValidID(ContainerSearch.Container) and not IsValidID(ContainerSearch.Gump) then
		return
	end

	-- refilter the container
	ContainerSearch.SearchText(_, true)

	-- current window name
	local dialog = "ContainerSearchSW"

	-- get the max scrollable offset
	local maxOffset = VerticalScrollbarGetMaxScrollPosition(dialog .. "Scrollbar")

	-- get the current scrollbar offset
	local listOffset = ScrollWindowGetOffset(dialog)

	-- is the offset greater than the maximum
	if (listOffset > maxOffset) then

		-- bring the scroll to the maximum
		listOffset = maxOffset
	end
	
	-- update the scroll position
	ScrollWindowSetOffset(dialog, listOffset)
end

function ContainerSearch.Restart()

	-- do we have a valid container
	if not IsValidID(ContainerSearch.Container) and not IsValidID(ContainerSearch.Gump) then
		return
	end

	-- clear all patterns
	SearchBox.Classes.ContainerSearch.filtersTable = {}

	-- clear all search results
	ContainerSearch.SearchResult = {}

	-- delete all items
	ContainerSearch.ClearItemList()

	-- send a search request for * (show all items). That pattern will be removed when the first search begin
	ContainerSearch.SearchText(L"*")
end

function ContainerSearch.OnItemClicked()

	-- current window name
	local this = SystemData.ActiveWindow.name

	-- current object ID
	local objectId = WindowGetId(this)

	-- do we have a valid ID?
	if IsValidID(objectId) then

		-- are we searching the items in a gump?
		if IsValidID(ContainerSearch.Gump) then
			
			-- press the item button in the gump
			GumpsParsing.PressButton(ContainerSearch.Gump, GenericGump.GetButtonIDByItemID(ContainerSearch.Gump, objectId))

	    -- do we have the cursor target?
	    elseif DoesPlayerHasCursorTarget() then
			
			-- target the item
			HandleSingleLeftClkTarget(objectId)

		-- are we dragging something?
	    elseif (SystemData.DragItem.DragType == SystemData.DragItem.TYPE_NONE) then

			-- start dragging the item
			DragSlotSetObjectMouseClickData(objectId, SystemData.DragSource.SOURCETYPE_CONTAINER)
	    end
	end
end

function ContainerSearch.ItemMouseOver()

	-- current window name
	local this = SystemData.ActiveWindow.name

	-- get the current object ID
	local objectId = WindowGetId(this)

	-- do we have a valid ID?
	if IsValidID(objectId) then

		-- is this a gump container?
		if IsValidID(ContainerSearch.Gump) then

			-- mark that we are over a gump element
			GenericGump.CurrentOver = "VSEARCH"
		end

		-- is the item properties we're seeing of a different item?
		if objectId ~= WindowGetId("ItemProperties") and WindowGetShowing("ItemProperties") then

			-- reset the item properties array
			ItemProperties.ResetWindowDataPropertiesFull()
		end

		-- create the object properties data
	    local itemData = { windowName = this,
					       itemId = objectId,
	    			       itemType = WindowData.ItemProperties.TYPE_ITEM,
	    			       detail = ItemProperties.DETAIL_LONG }

		-- activate object properties
	    ItemProperties.SetActiveItem(itemData)
	end
end
