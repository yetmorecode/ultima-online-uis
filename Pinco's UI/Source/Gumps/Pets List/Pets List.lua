----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

PetsList = {}

PetsList.GumpID = 462

PetsList.List = {}

PetsList.CustomTypes = {}

PetsList.TotalPets = L""

PetsList.PetsCap = 0
PetsList.PetsAmount = 0

----------------------------------------------------------------
-- PetsList Functions
----------------------------------------------------------------

function PetsList.Initialize()
	
	-- pet list window name
	local mainWindow = "PetsList"

	-- set the window to be destroyed on close
	Interface.DestroyWindowOnClose[mainWindow] = true

	-- restore the window position
	WindowUtils.RestoreWindowPosition("PetsList")

	-- fill the text for the window title
	LabelSetText(mainWindow .. "StoreName", GetStringFromTid(1080333)) -- Select a pet to retrieve from the stables:

	-- fill the header
    LabelSetText ("PetsListItemsHeaderPetName", GetStringFromTid(1037013)) -- Name
    LabelSetText ("PetsListItemsHeaderPetType", GetStringFromTid(1062213)) -- Type
	LabelSetText ("PetsListTotalPetsText", GetStringFromTid(316))

	-- say <pet name> release
	SendChat(ChatSettings.Channels[SystemData.ChatLogFilters.SAY].serverCmd, L"Stablecount")

	-- update the pet list
	PetsList.UpdateList()
end

function PetsList.Shutdown()

	-- close the pet list gump
	GumpsParsing.DestroyGump(PetsList.GumpID)

	-- save the window position
	WindowUtils.SaveWindowPosition("PetsList")
end

function PetsList.ClearList()
	
	-- pet list window name
	local mainWindow = "PetsList"

	-- delete up to 100 elements in the list
	for i = 1, 100 do
		
		-- current item name
		local item = mainWindow .. "Pet" .. i

		-- does the item exist?
		if DoesWindowExist(item) then

			-- delete the element
			DestroyWindow(item)
		end
	end
end

function PetsList.UpdateList()
	
	-- pet list window name
	local mainWindow = "PetsList"

	-- reset the current list content
	PetsList.ClearList()

	-- get the text from the textbox
	local text = SearchBox.GetFilter(mainWindow .. "SearchBox", true)

	-- last item variable initialize
	local lastItem

	-- current items count
	local count = 1

	-- scan all pets in the list
	for id, name in pairsByIndex(PetsList.List) do

		-- is the search box empty or the pet name is what we're looking for?
		if text == "" or text == L"" or wstring.find(wstring.lower(name), text, 1, true) then

			-- current item name
			local item = mainWindow .. "Pet" .. count

			-- create the line in the scroll window
            CreateWindowFromTemplate( item, "PetListItemTemplate", "PetsListItemsScrollWindowScrollChildCont" )

			-- change the background transparency
            WindowSetAlpha(item .. "BG", 0.5)

			-- reset the item anchor
            WindowClearAnchors(item)

			-- set the ID to the item
			WindowSetId(item, id)

			-- fill the name label and make sure it fits
			WindowUtils.FitTextToLabel(item .. "Name", name)

			-- clear the combo box for pet types
			ComboBoxClearMenuItems(item .. "PetType")
			
			-- initialize custom type variables
			local petType
			local comboType 

			-- get the creature type from the saved table
			if PetsList.CustomTypes[name] then
				petType = PetsList.CustomTypes[name].name

				-- get the pet type (if available in the DB)
				petType = CreaturesDB.FindCompatibleCreaturesByName(petType)

				-- have we found a pet?
				if petType then

					-- pick the first of the list
					petType = petType[1]
				end
			end
			
			-- if we don't have a custom type for the pet, we try to get a default type
			if not petType then

				-- get the pet type (if available in the DB)
				petType = CreaturesDB.FindCompatibleCreaturesByName(name)

				-- have we found a pet?
				if petType then

					-- pick the first of the list
					petType = petType[1]
				end
				
				-- do we have a pet type?
				if petType then

					-- get the creature name
					comboType = petType.creaturename
					
					-- we get the correct texture from the DB
					petType = "icon" .. tonumber(string.sub("100000000", 1, -(string.len(tostring(petType.bodyid[1])) + 1)) .. tostring(petType.bodyid[1]))
				end

			else
				-- do we have a pet type?
				if petType then

					-- get the creature name
					comboType = petType.creaturename

					-- we get the correct texture from the DB
					petType = "icon" .. tonumber(string.sub("100000000", 1, -(string.len(tostring(petType.bodyid[1])) + 1)) .. tostring(petType.bodyid[1]))
				end
			end

			-- initialize the selected type from the list
			local selType = -1

			-- fill the pet types combo with all the possible tamable creatures
			for i, creature in pairsByIndex(CreaturesDB.AnimalLoreTamables) do

				-- add the type to the list
				ComboBoxAddMenuItem(item .. "PetType", wstring.titleCase(creature.creaturename))

				-- if we have a pet type, we check if this is the current one
				if petType then

					-- parse the pet name
					if wstring.lower(comboType) == wstring.lower(creature.creaturename) then
						selType = i
					end
				end
			end
			
			-- we have no pet type
			if not petType or petType == L"" then

				-- we use the gray question mark as image
				petType = "RewardMarker_Grayed"

				-- show the texture based on the creature type
				DynamicImageSetTexture(item .. "IconHolderSquareIcon", petType, -5, 5)	

				-- scale the portrait correctly
				DynamicImageSetTextureScale(item .. "IconHolderSquareIcon", 0.55)

			else
				-- show the texture based on the creature type
				DynamicImageSetTexture(item .. "IconHolderSquareIcon", petType, 0, 0)	
				
				-- scale the portrait correctly
				DynamicImageSetTextureScale(item .. "IconHolderSquareIcon", 0.7)

				-- do we have a selected type from the list (safety check, we should since we're here)
				if selType > 0 then 

					-- select the type from the list
					ComboBoxSetSelectedMenuItem(item .. "PetType", selType )
				end
			end

			-- is this the first item?
            if count == 1  then

				-- anchor to the top-left of the scroll window
                WindowAddAnchor( item, "topleft", "PetsListItemsScrollWindowScrollChildCont", "topleft", 5, 5)

            else -- for any other item, we anchor it at the previous element
                WindowAddAnchor( item, "bottomleft", lastItem, "topleft", 0, 5)                               
            end

			-- increase the items count
			count = count + 1

			-- update the last item with the current item name
			lastItem = item
		end
	end


	-- update the scrollable area
	WindowSetDimensions("PetsListItemsScrollWindowScrollChildCont", 490 , count * 55)
	ScrollWindowUpdateScrollRect("PetsListItemsScrollWindow")
	
	-- do we have the amount of pets?
	if PetsList.PetsAmount == 0 then

		-- store the amount of pets
		PetsList.PetsAmount = #PetsList.List
	end

	-- update pet count
	PetsList.UpdateCount()
end

function PetsList.ChangeType()
	
	-- current window name
	local windowName = SystemData.ActiveWindow.name
	
	-- get the ID of the pet
	local id = WindowGetId(WindowGetParent(SystemData.ActiveWindow.name))

	-- get the current selected item
	local sel = ComboBoxGetSelectedMenuItem(windowName)

	-- initialize the custom type
	PetsList.CustomTypes[PetsList.List[id]] = {}

	-- update the custom type
	PetsList.CustomTypes[PetsList.List[id]].name = CreaturesDB.AnimalLoreTamables[sel].creaturename
	PetsList.CustomTypes[PetsList.List[id]].id = sel
	
	-- update the list
	PetsList.UpdateList()
end

function PetsList.OnItemClicked()

	-- current item window name
	local this = SystemData.ActiveWindow.name
	
	-- get the item ID
	local buttonID = WindowGetId(this)

	-- do we have a valid ID?
	if IsValidID(buttonID) then

		-- claim the pet
		GumpsParsing.PressButton(PetsList.GumpID, buttonID)
	end
end

function PetsList.UpdateCount()

	-- get the REVERSE percentage of the stable usage
	local perc = 100 - (PetsList.PetsAmount * 100) / PetsList.PetsCap

	-- color the label based on the percent used
	WindowUtils.ScaleTextRedByPerc("PetsListTotalPetsVal", perc)

	-- update pet count
	LabelSetText("PetsListTotalPetsVal", PetsList.PetsAmount .. L" / " .. PetsList.PetsCap)
end