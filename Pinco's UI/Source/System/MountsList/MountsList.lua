
----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

MountsList = {}
MountsList.TYPE_ETHEREAL = 1
MountsList.TYPE_LIVING = 2

MountsList.LivingMountsType = 
{
	[500239] = 9630, -- default
	[1031670] = 11670, -- Cu Sidhe
	[1028501] = 8501, -- desert ostard
	[1030268] = 10268, -- fire beetle
	[1049693] = 8689, -- fire steed
	[1028503] = 8502, -- forest ostard
	[1028502] = 8503, -- frenzied ostard
	[1029743] = 9743, -- giant beetle
	[1030090] = 10090, -- hiryu
	[1018263] = 8484, -- horse
	[1018224] = 9632, -- ki-rin
	[1018283] = 8438, -- llama
	[1018208] = 9627, -- nightmare
	[1075202] = 11669, -- Reptalon
	[1029749] = 9749, -- ridgeback
	[1029753] = 9753, -- swamp dragon
	[1029751] = 9751, -- skeletal mount
	[1018214] = 9678, -- unicorn
	[1018213] = 9629, -- war horse
}			

MountsList.NotAMount = {}
MountsList.MyMounts = {} -- id, iconId, name (tid for ethereals), type (ehtereal/living), available

MountsList.EtheresalsTIDs =
{
	[1049748] = 9743, -- Ethereal Beetle Statuette
	[1049745] = 9678, -- Ethereal Unicorn Statuette
	[1049746] = 9632, -- Ethereal Ki-Rin Statuette
	[1049747] = 9749, -- Ethereal Ridgeback Statuette
	[1049749] = 9753, -- Ethereal Swamp Dragon Statuette
	[1080386] = 11670, -- Ethereal Cu Sidhe Statuette
	[1113813] = 10090, -- Ethereal Hiryu Statuette
	[1113812] = 11669, -- Ethereal Reptalon Statuette
	[1041298] = 8413, -- Ethereal Horse Statuette
	[1041299] = 8501, -- Ethereal Ostard Statuette
	[1041300] = 8438, -- Ethereal Llama Statuette
	[1154589] = 9603, -- Ethereal Tiger Statuette
	[1154590] = 9603, -- Ethereal Tiger Statuette
	[1076159] = 8417, -- Rideable Polar Bear Statuette
	[1150006] = 18169, -- Rideable Boura Statuette
	[1074816] = 11676, -- Charger of the Fallen Statuette
	[1155723] = 16381, -- Ancient Hell Hound Statuette
	[1157081] = 8445, -- Tarantula Statuette
	[1157995] = 9633, -- Ethereal Dragon Statuette (serpentine dragon)
	[1157214] = 9678, -- Lasher
	[1157214] = 16381 -- Windrunner
}

MountsList.ListItems = {}
MountsList.MountMacroId = 0

MountsList.OriginalMountID = 0

function MountsList.Initialize()

	-- mount list window name
	local windowName = "MountsListWindow"

	-- is the player race anything but a gargoyle?
	if GetMobileRace(GetPlayerID()) ~= PaperdollWindow.GARGOYLE then

		-- scan all the ethereals
		for tid, iconId in pairs(MountsList.EtheresalsTIDs) do

			-- check if this ethereal mount is missing
			if not MountsList.DoesMountExistbyTID(tid) then

				-- create a record for this ethereal mount
				local record = {id = 0, iconId = iconId, name = tid, type = MountsList.TYPE_ETHEREAL, available = false}

				-- insert the mount to the list
				table.insert(MountsList.MyMounts, record)
			end
		end

	else -- gargoyls can't have mounts
		LabelSetText(windowName .. "NoMounts", GetStringFromTid(292))
	end

	-- macro ID of the mount/dismount action
	MountsList.MountMacroId = MacroWindow.GetMacroId(L"MountBlockbarMacro")
	
	-- restore the window position
	WindowUtils.RestoreWindowPosition(windowName)

	-- set the description text
	LabelSetText(windowName .. "InfoText", GetStringFromTid(289))

	-- set the text in the reset button
	ButtonSetText(windowName .. "ResetButton", GetStringFromTid(SettingsWindow.TID.Reset))
end

function MountsList.Update(timePassed)

	-- if the player is a gargoyle, we don't need to update anything
	if GetMobileRace(GetPlayerID()) == PaperdollWindow.GARGOYLE then
		return
	end

	-- get the current mount ID
	local ridingPet = IsRiding()

	-- availability change flag
	local availChange = false

	-- scan all mounts
	for i, currMount in pairsByIndex(MountsList.MyMounts) do

		-- was the mount available?
		local prevAvail = currMount.available

		-- is this mount an ethereal?
		if currMount.type == MountsList.TYPE_ETHEREAL then

			-- is this a valid item ID?
			if IsValidID(currMount.id) then

				-- does the player still has the statuette or is riding the mount?
				currMount.available = DoesPlayerHaveItem(currMount.id) or (ridingPet and MountsList.OriginalMountID == currMount.id)

				-- change the availability flag
				availChange = prevAvail ~= currMount.available
			end

		else -- living mount

			-- get the mobile ID
			local mobileId = currMount.id

			-- is it still a valid mobile ID?
			if VerifyMobileID(mobileId) then
				
				-- is the player riding the mount?
				if ridingPet and MountsList.OriginalMountID == mobileId then

					-- mark the mount as available
					currMount.available = true

				else -- get the mount health status
					local curHealth, maxHealth, dead, perc = GetMobileHealth(mobileId)

					-- is available if it's still alive
					currMount.available = not dead
				end

				-- change the availability flag
				availChange = prevAvail ~= currMount.available
			end
		end
	end

	-- is the availability changed?
	if availChange then
		
		-- update the mounts list
		MountsList.UpdateList()
	end
end

function MountsList.UpdateBlockbar(timePassed)

	-- getting the action ID
	local actionType = UserActionGetType(MountsList.MountMacroId, 1, 0)

	-- is the player race anything but a gargoyle?
	if GetMobileRace(GetPlayerID()) ~= PaperdollWindow.GARGOYLE then

		-- if the player is riding we switch the action with a dismount
		if IsRiding() and actionType ~= SystemData.UserAction.TYPE_DISMOUNT then
			HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_DISMOUNT, MountsList.MountMacroId, 798, Interface.MountBlockbar,  1)

		-- if the player is NOT riding, we keep the macro inside the blockbar
		elseif actionType ~= SystemData.UserAction.TYPE_MACRO_REFERENCE then
			HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_MACRO_REFERENCE, MountsList.MountMacroId, 870300, Interface.MountBlockbar,  1)
		end

	-- if the player is a gargoyle we keep the right fly action in it
	elseif actionType ~= SystemData.UserAction.TYPE_RACIAL_ABILITY then
		HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_RACIAL_ABILITY, 1, 3021, Interface.MountBlockbar,  1)
	end
end

function MountsList.OnShown()

	-- mount list window name
	local windowName = "MountsListWindow"

	-- mount/dismount blockbar window name
	local mountBlockbar = "Hotbar" .. Interface.MountBlockbar

	-- clear the blockbar anchors
	WindowClearAnchors(mountBlockbar)

	-- anchor the blockbar to the bottom left of the mount window
	WindowAddAnchor(mountBlockbar, "bottomleft", windowName, "bottomleft", 10, -10)

	-- show the mount/dismount blockbar
	WindowSetShowing(mountBlockbar, true)

	-- is the player race anything but a gargoyle?
	if GetMobileRace(GetPlayerID()) ~= PaperdollWindow.GARGOYLE then

		-- update the mount list
		MountsList.UpdateList(true)
	end
end

function MountsList.Shutdown()

	-- save the window position
	WindowUtils.SaveWindowPosition("MountsListWindow")
end

function MountsList.SetAvailable(id, name, available, forced)

	-- if the player is a gargoyle, we don't need to do anything
	if GetMobileRace(GetPlayerID()) == PaperdollWindow.GARGOYLE then
		return
	end
	
	-- no need to update anything if the mount is already with the same state of availability
	if MountsList.IsMountAvailable(id) == available and not forced then
		return
	end
	
	-- is the mount name valid?
	if not IsValidWString(name) and type(name) ~= "number" then

		-- get the name
		name = GetMobileName(id)
	end

	-- is the mount ethereal?
	local isEthereal = MountsList.EtheresalsTIDs[name] ~= nil or DoesPlayerHaveItem(id)
	
	-- is the player riding?
	local ridingPet = IsRiding()
	
	-- if it's an ethereal we just scan by name
	if isEthereal then
		
		-- if we are riding and we used an ethereal as last mount, then we consider it available (since we still have it).
		if ridingPet and MountsList.OriginalMountID == id then
			available = true
		end

		-- scan all mounts
		for i, currMount in pairsByIndex(MountsList.MyMounts) do

			-- is the name a number and it's the number the current mount id?
			if type(currMount.name) == "number" and currMount.name == name then
			
				-- do we have a valid id?
				if IsValidID(id) then

					-- we update the id for the ethereal mount
					currMount.id = id
				end

				-- update the mount availability
				currMount.available = available
				
				-- update the mount list
				MountsList.UpdateList()

				-- job's done, we can get out
				return
			end
		end

	else -- if it's a living mount we scan by id
		
		-- getting the compatible creatures list with the current mobile
		local creatureData = CreaturesDB.FindCompatibleCreatures(id, true)
		
		-- do we have more creatures?
		if #creatureData > 0 then

			-- since all the bodies are the same if one is ridable, all of them are so we use the first one.
			creatureData = creatureData[1]
		end

		-- scan the compatible creatures
		for k, cd in pairsByIndex(creatureData) do
		
			-- is this a mount?
			if not cd.ismount then
			
				-- flag as not a mount and get out
				MountsList.NotAMount[id] = true

				break
			end
		end
		
		-- is this pet marked as NOT A MOUNT?
		if MountsList.NotAMount[id] then 
		
			-- scan all mounts
			for i, currMount in pairsByIndex(MountsList.MyMounts) do

				-- is this the mount ID to remove?
				if currMount.id == id then

					-- remove the mount from the list
					table.remove(MountsList.MyMounts, i)

					-- mount found we can stop the scan
					break
				end
			end

			-- job's done, we can get out
			return
		end

		-- the pet we're riding should be considered available
		if ridingPet and MountsList.OriginalMountID == id then 
			available = true

		else -- get the pet health status
			local curHealth, maxHealth, dead, perc = GetMobileHealth(id)

			-- if the pet is dead, the pet will be unavailable until is ressed
			available = not dead
		end
		
		-- scan all mounts
		for i, currMount in pairs(MountsList.MyMounts) do
		
			-- skip ethereals
			if currMount.type == MountsList.TYPE_ETHEREAL then
				continue
			end

			-- is this the mount ID we're looking for?
			if currMount.id == id then
			
				-- change the mount availability status
				currMount.available = available

				-- is the mount name valid?
				if IsValidWString(name) then
				
					-- we update the name of the living mount
					currMount.name =  name 

					-- is the mount icon missing?
					if not IsValidID(currMount.iconId) then

						-- convert the name in lower case
						local nameParse =  CreaturesDB.CleanUpName(wstring.lower(name))
				
						-- is this a necromantic horse?
						if nameParse == L"hellsteed" or nameParse == L"grizzled mare" or nameParse == L"skeletal steed" then -- necromancy horses

							-- use the skeletal steed icon
							currMount.iconId = MountsList.LivingMountsType[1029751]

						else -- try to check if the mount is one of the others

							-- set the default icon image
							currMount.iconId = MountsList.LivingMountsType[500239]

							-- update the mount name
							currMount.name = name

							-- scan the living mount types tids
							for tid, iconId in pairs(MountsList.LivingMountsType) do

								-- convert the tid to string in lower case
								local strTid = wstring.lower(GetStringFromTid(tid))

								-- is the tid name inside the mount name?
								if wstring.find(nameParse, strTid, 1, true) then

									-- update the icon ID
									currMount.iconId = iconId
									
									-- end the scan
									break
								end
							end
						end
					end
				end
				
				-- update the mount list
				MountsList.UpdateList()

				-- job's done we can get out
				return
			end
		end
		
		-- if we ended up here, the mount was not inside the array and we have to add it
		local record = {id = id, iconId = 0, name = name, type = MountsList.TYPE_LIVING, available = available}

		-- do we have a valid string name?
		if IsValidWString(name) then

			-- convert the name in lower case
			local nameParse =  CreaturesDB.CleanUpName(wstring.lower(name))
				
			-- is this a necromantic horse?
			if nameParse == L"hellsteed" or nameParse == L"grizzled mare" or nameParse == L"skeletal steed" then -- necromancy horses

				-- use the skeletal steed icon
				record.iconId = MountsList.LivingMountsType[1029751]

			else -- try to check if the mount is one of the others

				-- set the default icon image
				record.iconId = MountsList.LivingMountsType[500239] -- default image

				-- scan the living mount types tids
				for tid, iconId in pairs(MountsList.LivingMountsType) do

					-- convert the tid to string in lower case
					local strTid = wstring.lower(GetStringFromTid(tid))

					-- is the tid name inside the mount name?
					if wstring.find(nameParse, strTid, 1, true) then

						-- update the icon ID
						record.iconId = iconId

						-- end the scan
						break
					end
				end
			end
		end

		-- add the mount to the list
		table.insert(MountsList.MyMounts, record)

		-- update the mount list
		MountsList.UpdateList()
	end
end

function MountsList.NotMount()

	-- get the mount element name
	local parent = WindowGetParent(SystemData.ActiveWindow.name)

	-- get the mount list ID
	local id = WindowGetId(parent)

	-- get the ID of the mount
	local itemId = MountsList.MyMounts[id].id

	-- do we already have the confirm dialog?
	if not DoesWindowExist("MountsListNotAMount") then

		-- initialize the buttons
		local okButton = { textTid = UO_StandardDialog.TID_OKAY, callback = function() MountsList.NotAMount[itemId] = true MountsList.SetAvailable(itemId, L"", false) MountsList.UpdateList() end }
		local cancelButton = { textTid=1152889 } -- Cancel

		-- initialize the confirm dialog
		local windowData = 
		{
			windowName = "MountsListNotAMount", 
			titleTid = 1111873, -- "Warning"
			bodyTid  = 287,
			buttons = { okButton, cancelButton },
			closeCallback = cancelButton.callback,
			destroyDuplicate = true,
		}

		-- create the confirm dialog
		UO_StandardDialog.CreateDialog(windowData)	
	end
end

function MountsList.ClearAll()

	-- scan all elements in the list
	for i, currElement in pairsByIndex(MountsList.ListItems) do

		-- does the element still exist?
		if DoesWindowExist(currElement) then

			-- destroy the element
			DestroyWindow(currElement)
		end
	end

	-- reset the list of elements
	MountsList.ListItems = {}
end

function MountsList.RemoveMount(id)
	
	-- scan all mounts
	for i, currMount in pairsByIndex(MountsList.MyMounts) do

		-- is this the mount to remove?
		if currMount.id == id then

			-- remove the mount
			table.remove(MountsList.MyMounts, i)

			-- update the mount list
			MountsList.UpdateList()

			-- job's done
			return
		end
	end
end

function MountsList.UpdateList(resetscroll)

	-- is the mount list visible?
	if not DoesWindowExist("MountsListWindow") or not WindowGetShowing("MountsListWindow") then
		return
	end

	-- emptying the list
	MountsList.ClearAll()

	-- last element to use as anchor name
	local lastlink = 0

	-- scan all mounts
	for i, currMount in pairsByIndex(MountsList.MyMounts) do

		-- we show only the available mounts
		if currMount.available == false or (IsValidID(currMount.id) and MountsList.NotAMount[currMount.id] == true) then
			continue
		end

		-- initialize window elements
		local dialog = "MountsListSW"
		local parent = dialog.. "ScrollChild"
		local slotName = parent.."Item"..i
		local elementIcon =slotName.."Icon"
		local elementName = slotName.."Name"
		local elementTypetxt = slotName.."Type"
		local elementNotAMountBtn = slotName.."NotAMount"

		-- create the element
		CreateWindowFromTemplate(slotName, "MountTemplate", parent)

		-- add the element to the list
		table.insert(MountsList.ListItems, slotName)

		-- set the element ID
		WindowSetId(slotName,i)

		-- ethereals cannot be set as "NOT A MOUNT" so we disable the button
		if currMount.type == MountsList.TYPE_ETHEREAL then
			WindowSetShowing(elementNotAMountBtn, false)

		else -- living mounts must show the mount type

			-- do we have a valid icon ID?
			if IsValidID(currMount.iconId) then

				-- initialize the type name
				local typ = L""

				-- scan the living mounts type
				for tid, iconId in pairs(MountsList.LivingMountsType) do

					-- is this the icon for the current mount
					if iconId == currMount.iconId then

						-- get the icon type name
						typ = GetStringFromTid(tid)
					end
				end

				-- set the mount type name
				LabelSetText(elementTypetxt, GetStringFromTid(1062213) .. L": " .. FormatProperly(typ)) -- Type
			end
		end

		-- clear the slot anchors
		WindowClearAnchors(slotName)

		-- is this the first element?
		if i == 1 or lastlink == 0 then

			-- anchor the element to the top-left
			WindowAddAnchor(slotName, "topleft", parent, "topleft", 0, 5)
			WindowAddAnchor(slotName, "topright", dialog, "topright", -21, 0)

		else -- anchor the element to the previous one
			WindowAddAnchor(slotName, "bottomleft", lastlink, "topleft", 0, 5)
			WindowAddAnchor(slotName, "bottomright", dialog, "topright", -21, 0)
		end

		-- update the last element name with the current one
		lastlink = slotName

		-- initialize the mount name
		local name = L""

		-- is the mount name a number? then it's an ethereal
		if type(currMount.name) == "number" then

			-- get the name from tid
			name = GetStringFromTid(currMount.name)

		else -- get the living mount name
			name = currMount.name
		end

		-- set the mount name
		LabelSetText(elementName, name)

		-- set the name text color
		LabelSetTextColor(elementName, 255, 255, 255)

		-- we highlight the mount we are currently on
		if IsRiding() and currMount.id == MountsList.OriginalMountID then

			-- set the text color blue
			LabelSetTextColor(elementName, 0, 162, 232)
		end

		-- do we have a valid icon ID?
		if IsValidID(currMount.iconId) then

			-- update the icon for the mount
			EquipmentData.DrawObjectIcon(currMount.iconId, 0, elementIcon)
		end

		-- get the icon dimensions
		local iconW, iconH = WindowGetDimensions(elementIcon)

		-- calculate the name width
		local nameW = 415 - iconW

		-- resizing the name label properly to fit in the correct width
		WindowSetDimensions(elementName, nameW, 16)
	end

	-- update the scrollable area of the mount list
	ScrollWindowUpdateScrollRect("MountsListSW")   

	-- do we need to reset the scroll position to the bottom?
	if resetscroll then

		-- get the current scroll offset
		local listOffset = ScrollWindowGetOffset("MountsListSW")

		-- get the max scroll offset
		local maxOffset = VerticalScrollbarGetMaxScrollPosition("MountsListSWScrollbar")

		-- is the current offset greater than the maximum offset?
		if listOffset > maxOffset then

			-- reset the current offset to the max offset
			listOffset = maxOffset
		end
	
		-- scroll the window
		ScrollWindowSetOffset("MountsListSW", listOffset)
	end
end

function MountsList.OnItemClicked()

	-- get the ID of the mount in the list
	local id = WindowGetId(SystemData.ActiveWindow.name)

	-- if the mount is an ethereal we can't do anything
	if MountsList.MyMounts[id].type == MountsList.TYPE_ETHEREAL then
		return
	end
	
	-- get the mount icon
	local currentIconId = MountsList.GetIconId(id)

	-- reset the context menu
	ContextMenu.CleanUp()

	-- scan all the possible mounts type
	for tid, iconId in pairs(MountsList.LivingMountsType) do

		-- add the type to the context menu
		ContextMenu.CreateLuaContextMenuItem({str = FormatProperly(GetStringFromTid(tid)), returnCode = tid, param = id, pressed = currentIconId == iconId})
	end

	-- since the window has a refresh rate, we need to keep it visible (forcefully) until the player make a choice
	ContextMenu.ForceChoice = true

	-- show the context menu
	ContextMenu.ActivateLuaContextMenu(MountsList.ContextMenuCallback)
end

function MountsList.ContextMenuCallback(returnCode, id)

	-- change the mount type
	MountsList.MyMounts[id].iconId = MountsList.LivingMountsType[returnCode]

	-- update the mount list
	MountsList.UpdateList()
end

function MountsList.DoesMountExistbyTID(tid)
	
	-- scan all mounts
	for i, currMount in pairsByIndex(MountsList.MyMounts) do

		-- is the mount name a number and it's the ethereal mount we're looking for?
		if type(currMount.name) == "number" and currMount.name == tid then

			-- we have this ethereal
			return true
		end
	end

	-- we don't have this ethereal
	return false
end

function MountsList.IsMountAvailable(id)
	
	-- scan all mounts
	for i, currMount in pairsByIndex(MountsList.MyMounts) do
		
		-- is this the mount we're looking for?
		if currMount.id == id then

			-- return the availability status
			return currMount.available
		end
	end

	-- the mount is unavailable
	return false
end

function MountsList.UpdateMountName(id, name)

	-- do we have a valid name?
	if not IsValidWString(name) then
		return
	end

	-- scan all mounts
	for i, currMount in pairsByIndex(MountsList.MyMounts) do

		-- is this the mount we're looking for?
		if currMount.id == id then

			-- update the mount name
			currMount.name = name
		end
	end

	-- update the mount list
	MountsList.UpdateList()
end

function MountsList.GetIconId(index)

	-- do we have a valid ID?
	if not IsValidID(index) then
		return
	end

	-- scan all mounts
	for i, currMount in pairsByIndex(MountsList.MyMounts) do

		-- is this the ID we're looking for?
		if i == index then

			-- return the icon ID
			return currMount.iconId
		end
	end

	-- by default return 0
	return 0
end

function MountsList.NotAMountTooltip()

	-- show the tooltip for "mark as not a mount"
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(288))
end

function MountsList.PickAMount()

	-- initialize the current target ID
	local currTarget = 0

	-- do we have a current target?
	if TargetWindow.HasValidTarget() and WindowGetShowing("TargetWindow") then

		-- backup the current target ID
		currTarget = TargetWindow.TargetId
	end

	-- getting rid of the cursor target (if the player have one), so we don't risk to cast harmful actions on the mount
	CancelCursorTarget()

	-- reset the mounted id
	MountsList.OriginalMountID = 0

	-- we create 2 arrays 1 for living and 1 for ethereals
	local living = {}
	local ethereal = {}
	
	-- scan all mounts
	for i, currMount in pairsByIndex(MountsList.MyMounts) do

		-- is the mount available and we have the mount ID?
		if currMount.available and IsValidID(currMount.id) then
		
			-- is the mount an ethereal?
			if currMount.type == MountsList.TYPE_ETHEREAL then
			
				-- add the mount to the ethereals mounts list
				table.insert(ethereal, currMount.id)

			else -- while for ethereals there are no problems, for livin creatures we need first to check if they are at range for riding
			
				-- get the distannce between the player and the mount
				local dist = GetDistanceFromPlayer(currMount.id)

				-- is the mount available and in range?
				if dist >= 0 and dist <= 1 then

					-- add the mount to the livng mounts list
					table.insert(living, currMount.id)
				end
			end
		end
	end
	
	-- now we must pick a mount.
	-- we give priority to living one since they have no casting time and they can get killed

	-- initialize the mount ID variable
	local mountID

	-- do we have living mount?
	if #living > 0 then
		
		-- if we have more than 1 mount we pick a random one
		if #living > 1 then

			-- pick a random mount ID
			local rnd = math.random(#living)

			-- select the mount
			mountID = living[rnd]

		else -- select the only mount we have
			mountID = living[1]
		end

	else -- if there are no livng mounts we go for an ethereal
	
		-- if we have more than 1 mount we pick a random one
		if #ethereal > 1 then

			-- pick a random mount ID
			local rnd = math.random(#ethereal)

			-- select the mount
			mountID = ethereal[rnd]

		else -- select the only mount we have
			mountID = ethereal[1]
		end
	end

	-- we haven't found any mount...
	if not mountID then
		return
	end

	-- we store the id so it won't became unavailable while we ride it
	MountsList.OriginalMountID = mountID

	-- targeting the mount so that the macro can use the targeted object
	HandleSingleLeftClkTarget(mountID)

	-- does the player had a current target? if yes we will restore it in just 1 second (the time that should take to mount up)
	if currTarget ~= 0 and currTarget ~= mountID then
		Interface.AddTodoList({name = "mount list target restore", func = function() HandleSingleLeftClkTarget(currTarget) MountsList.UpdateList() end, time = Interface.TimeSinceLogin + 1})
	
	else -- otherwise we update only the mounts list to highlight the mount we're using and remove the mount target
		Interface.AddTodoList({name = "highlight mount", func = function() MountsList.UpdateList() ClearCurrentTarget() end, time = Interface.TimeSinceLogin + 1})
	end
end

function MountsList.Reset()

	-- reset the current mount ID
	MountsList.OriginalMountID = 0

	-- reset the arrays
	MountsList.NotAMount = {}
	MountsList.MyMounts = {}

	-- search for ethereals
	ContainerWindow.SearchEtherealsMounts()

	-- search for pet mounts
	Interface.HandlePetsUpdate()

	-- update the list
	MountsList.UpdateList(true)
end

function MountsList.ResetMouseOver()

	-- create the tooltip for reset
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(656))
end