----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

ObjectHandleWindow = {}
ObjectHandle = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------


ObjectHandleWindow.Active = false

--If the health bar for it is already open
ObjectHandleWindow.hasWindow = {}
ObjectHandleWindow.ObjectsData ={}
ObjectHandleWindow.ReverseObjectLookUp ={} 

--Default gray color of objects for their object handles
ObjectHandleWindow.grayColor = { r = 172, g = 172, b = 172 }
ObjectHandleWindow.whiteColor = { r = 255, g = 255, b = 255 }

ObjectHandleWindow.mouseOverId = 0

--Theses are used for mobiles only for setting the tint color of the object handle window
ObjectHandleWindow.Notoriety = {NONE = 1, INNOCENT = 2, FRIEND = 3, CANATTACK =4, CRIMINAL=5, ENEMY=6, MURDERER=7, INVULNERABLE=8, HONORED=9 }
ObjectHandleWindow.TextColors = {}
ObjectHandleWindow.TextColors[ObjectHandleWindow.Notoriety.NONE] =			{ r = 64,  g = 64,  b = 255 } --- BLUE
ObjectHandleWindow.TextColors[ObjectHandleWindow.Notoriety.INNOCENT] =		{ r = 128, g = 128, b = 255 } --- BLUE
ObjectHandleWindow.TextColors[ObjectHandleWindow.Notoriety.FRIEND] =		{ r = 0,   g = 159, b = 0	} --- GREEN 
ObjectHandleWindow.TextColors[ObjectHandleWindow.Notoriety.CANATTACK] =		{ r = 64,  g = 64,  b = 64  } --- GREY/SYS
ObjectHandleWindow.TextColors[ObjectHandleWindow.Notoriety.CRIMINAL] =		{ r = 64,  g = 64,  b = 64  } --- GREY/SYS
ObjectHandleWindow.TextColors[ObjectHandleWindow.Notoriety.ENEMY]  =		{ r = 255, g = 128, b = 0   } --- ORANGE
ObjectHandleWindow.TextColors[ObjectHandleWindow.Notoriety.MURDERER] =		{ r = 255, g = 0  , b = 0   } --- RED  
ObjectHandleWindow.TextColors[ObjectHandleWindow.Notoriety.INVULNERABLE] =  { r = 251, g = 194, b = 2   } --- YELLOW 
ObjectHandleWindow.TextColors[ObjectHandleWindow.Notoriety.HONORED]	=		{ r = 163, g = 73,  b = 164 } --- PURPLE 

ObjectHandleWindow.ObjectHandleScale = InterfaceCore.scale * 0.8
ObjectHandleWindow.ObjectHandleAlpha = 0.6

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function ObjectHandleWindow.retrieveObjectsData( objectsData )

	-- do we have the objects data?
	if not objectsData then
		return false
	end      
	
	-- fill the array
	objectsData.Names = WindowData.ObjectHandle.Names
	objectsData.ObjectId = WindowData.ObjectHandle.ObjectId
	objectsData.XPos = WindowData.ObjectHandle.XPos
	objectsData.YPos = WindowData.ObjectHandle.YPos
	objectsData.IsMobile = WindowData.ObjectHandle.IsMobile
	objectsData.Notoriety = WindowData.ObjectHandle.Notoriety
	
	return true
end

--Creates all the object handles for all the objects that are on screen
function ObjectHandleWindow.CreateObjectHandles()

	-- if the object handles are already active is pointless to update them (since we won't get any new data anyway)
	if ObjectHandleWindow.Active then
		return
	end

	-- flag the object handles active
	ObjectHandleWindow.Active = true

	-- loading objects data
	local objectsData = {}

	-- have we successfully obtained all the objects?
	if (ObjectHandleWindow.retrieveObjectsData(objectsData)) then

		-- do we have the objects data and the names?
		if not objectsData or not objectsData.Names then
			return
		end		

		-- reset the timer from the last update
		Interface.ActiveItemsTimeFromLastUpdate = 0

		-- reset the active items list
		Interface.ActiveItemsOnScreen = {}

		-- save the array
		ObjectHandleWindow.ObjectsData = objectsData

		-- loading object handle filters
		local isItemsOnly = SystemData.Settings.GameOptions.objectHandleFilter == SystemData.Settings.ObjectHandleFilter.eItemsOnlyFilter
		local isLostItemsOnly = SystemData.Settings.GameOptions.objectHandleFilter == SystemData.Settings.ObjectHandleFilter.eLostItemsOnlyFilter
		local isCorpsesOnly = SystemData.Settings.GameOptions.objectHandleFilter == SystemData.Settings.ObjectHandleFilter.eCorpseFilterFixed
		
		-- scann all objects
		for i, objectId in pairsByIndex(ObjectHandleWindow.ObjectsData.ObjectId) do
			
			-- no need to show the player
			if objectId == GetPlayerID() then
				continue
			end

			-- this is for avoiding a bug where in some areas you can see player items like if they are on the ground.
			if DoesPlayerHaveItem(objectId) then 
				continue
			end
			
			-- get the current object name
			local name = ObjectHandleWindow.ObjectsData.Names[i]

			-- is an item or a corpse?
			if not ObjectHandleWindow.ObjectsData.IsMobile[i] or IsCorpse(objectId) then

				-- store the item in the active items list
				Interface.ActiveItemsOnScreen[objectId] = { name = name, isCorpse = IsCorpse(objectId), isLostItem = ObjectHandleWindow.IsLostItem(objectId), type = GetItemType(objectId), hue = GetItemHue(objectId) }
			end

			-- is the corpse filter active and is not a corpse?
			if isCorpsesOnly and not IsCorpse(objectId, true) then
				continue
			end
			
			-- do we have a valid name?
			if not IsValidWString(name) then
				continue
			end
			
			-- parse the lobster traps
			ObjectHandleWindow.HandleLobsterTrap(objectId, name)

			-- object already showing
			if ObjectHandleWindow.hasWindow[objectId] then
				continue
			end

			-- ignored item
			if ContainerWindow.IgnoreItems[objectId] then
				continue
			end

			-- useless item that do not need to be shown at all
			if (name == L"Treasure Sand") then 
				continue
			end

			-- is the items only filter active and this is not an item?
			if isItemsOnly and (ObjectHandleWindow.ObjectsData.IsMobile[i] or IsCorpse(objectId)) then
				continue
			end
			
			-- applying text filters
			if not ObjectHandleWindow.ParseNameWithFilters(name) then
				continue
			end

			-- is a lost item for humility?
			local lostItem = ObjectHandleWindow.IsLostItem(objectId)
			if isLostItemsOnly and not lostItem then
				continue
			end
			
			-- initialize the hue variable
			local hue 

			-- is this a mobile?
			if ObjectHandleWindow.ObjectsData.IsMobile[i] then

				-- fix for the honored mobile notoriety
				if (objectId == Interface.CurrentHonor) then
					ObjectHandleWindow.ObjectsData.Notoriety[i] = 8
				end

				-- get the notoriety hue
				hue = ObjectHandleWindow.TextColors[ObjectHandleWindow.ObjectsData.Notoriety[i]+1]

			else -- items

				-- is this a lost item (for humility)?
				if lostItem then

					-- use the lsot items hue
					hue = Interface.Settings.Props_LOSTITEM_COLOR

				else -- default grey color
					hue = ObjectHandleWindow.grayColor
				end
			end
			
			-- create the object handle
			ObjectHandleWindow.CreateHandle(objectId, i, name, hue)

			-- adding the handle to the array
			ObjectHandleWindow.hasWindow[objectId] = true
			ObjectHandleWindow.ReverseObjectLookUp[objectId] = orderIndex
		end

		-- update handles scale
		WindowUtils.LoadScale("ObjectHandleWindow")
	end
end

--Destroys all the object handles on the screen when the user lets go of ctrl+shift
function ObjectHandleWindow.DestroyObjectHandles()

	-- flag the object handles as inactive
	ObjectHandleWindow.Active = false

	-- destroying all handles
	for key, value in pairs(ObjectHandleWindow.hasWindow) do
		ObjectHandle.DestroyObjectWindow(key, true) 
	end

	-- disabling the item properties if the cursor was over a handle
	if (ObjectHandleWindow.mouseOverId ~= 0) then
		ObjectHandleWindow.mouseOverId = 0
		ItemProperties.ClearMouseOverItem()
	end

	-- clearing the windowdata array
	if WindowData.ObjectHandle then
		WindowData.ObjectHandle.ObjectId = {}
	end
end

--Destroy object handle when player right clicks the window
function ObjectHandleWindow.OnClickClose()

	-- get the current object ID
	local objectId = WindowGetId(WindowUtils.GetActiveDialog())

	-- destroy the label
	ObjectHandle.DestroyObjectWindow(objectId) 

	-- clear the item properties
	ItemProperties.ClearMouseOverItem()
end

--When player double clicks the object handle window it acts as if they double-clicked the object itself
function ObjectHandleWindow.OnDblClick()

	-- get the current object ID
	local mobileId = WindowGetId(WindowUtils.GetActiveDialog())
	
	-- is this a banker?
	if IsBanker( mobileId) then

		-- open the bankbox
		ContextMenu.RequestContextAction(mobileId, ContextMenu.DefaultValues.OpenBankbox)

	-- is this a vendor?
	elseif IsVendor( mobileId) then

		-- open the shopkeeper window
		ContextMenu.RequestContextAction(mobileId, ContextMenu.DefaultValues.VendorBuy)

	-- is this an old quest giver?
	elseif IsOldQuestGiver( mobileId) then

		-- ask for the quest
		ContextMenu.RequestContextAction(mobileId, ContextMenu.DefaultValues.NPCTalk)

	else -- default action
		UserActionUseItem(mobileId, false)
	end
	
	-- save the ID as opened corpse (it will be cleared out if actually is a corpse)
	ContainerWindow.OpenedCorpse = mobileId
end

function ObjectHandleWindow.OnItemClicked()

	-- get the current object ID
	local objectId = WindowGetId(WindowUtils.GetActiveDialog())

	-- do we have a valid ID?
	if IsValidID(objectId) then
		
		-- Target the object
		HandleSingleLeftClkTarget(objectId)
		
		-- are we dragging something?
		if SystemData.DragItem.DragType == SystemData.DragItem.TYPE_NONE then
			
			-- is this a mobile?
			if IsMobile(objectId) then
				
				-- create a variable as pointer for the bar record
				local barData = MobileHealthBar.ActiveBars[objectId]

				-- do we have a valid ID and the mobile is not a pet or a party member?
				if not IsValidID(objectId) or IsObjectIdPet(objectId) or IsPartyMember(objectId) or (barData and barData.pinned) then
					return
				end

				-- by default we create a new bar
				local callback = function() MobileHealthBar.CreateBar(objectId, true) end

				-- does the healthbar already exist?
				if barData then

					-- if the bar exist, we pin it (if it's already pinned, nothing will happen)
					callback = function() MobileHealthBar.PinBar(objectId) end
				end

				-- create a pinned bar if the drag is successful
				WindowUtils.BeginDrag(callback, objectId)

			else	
				-- start dragging the item
				DragSlotSetObjectMouseClickData(objectId, SystemData.DragSource.SOURCETYPE_OBJECT)
			end
		end
	end
end

function ObjectHandleWindow.OnLButtonUp()

	-- are we dragging an healthbar?
	if WindowUtils.dragging then
		
		-- terminate the dragging, verify if we actually dragged a bar or just clicked the mobile
		WindowUtils.EndDrag()

	else
		-- get the current object ID
		local mobileId = WindowGetId(WindowUtils.GetActiveDialog())

		-- are we dragging an item?
		if (SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM) then
		
			-- drop the slot on the mobile (start a trade if it's a player)
			DragSlotDropObjectToObject(mobileId)
		end

		-- target the mobile
		HandleSingleLeftClkTarget(mobileId)
	end
end

--Destroy object handle window and reset the data to nil
function ObjectHandle.DestroyObjectWindow(objectId, permanent) 

	-- current window name
	local windowName = "ObjectHandleWindow" .. objectId

	-- does the window exist?
	if DoesWindowExist(windowName) then

		-- detach the label from the world object
		DetachWindowFromWorldObject(objectId, windowName)

		-- destroy the label
		DestroyWindow(windowName)
	end

	-- are we destroying all handles?
	if permanent then

		-- clear up the data about the object
		ObjectHandleWindow.hasWindow[objectId] = nil
		ObjectHandleWindow.ReverseObjectLookUp[objectId] = nil
	end

	-- if we have the item properties of the current item we need to clear them
	if (ObjectHandleWindow.mouseOverId == objectId) then

		-- reset the mouse over ID
		ObjectHandleWindow.mouseOverId = 0

		-- clear item properties
		ItemProperties.ClearMouseOverItem()
	end
end

function ObjectHandleWindow.OnMouseOver()

	-- get the current object ID
	local objectId = WindowGetId(WindowUtils.GetActiveDialog())

	-- reset the object properties if it's showing another item
	ItemProperties.ResetWindowDataProperties(objectId)

	-- create the item properties array
	local itemData =
	{
		windowName = WindowUtils.GetActiveDialog(),
		itemId = objectId,
		itemType = WindowData.ItemProperties.TYPE_ITEM,
	}			
	
	-- show the item properties
	ItemProperties.SetActiveItem(itemData)

	-- store the current over ID
	ObjectHandleWindow.mouseOverId = objectId
end

ObjectHandleWindow.lastItem = 0
ObjectHandleWindow.retryItems = {}
ObjectHandleWindow.cooldown = 0

local okObjects = {}

function ObjectHandleWindow.IgnoreListCleaner(timePassed)

	-- scan all ignored items list
	for id, time in pairs(ContainerWindow.IgnoreItems) do

		-- is it time to reset the current item?
		if time <= Interface.Clock.Timestamp then

			-- remove the item from the ignore list
			ContainerWindow.IgnoreItems[id] = nil
		end
	end
end

function ObjectHandleWindow.OnUpdate(timePassed)

	-- clear ignore list items
	ObjectHandleWindow.IgnoreListCleaner(timePassed)

	-- are the object handles active?
	if not ObjectHandleWindow.Active then
		return
	end

	--[[ show mobiles while moving, not working properly... it should be done from the client.
	-- scan all mobiles on screen
	for mobileId, _ in pairs(MobilesOnScreen.AllMobilesOnScreen) do

		-- is the mobile already in list?
		local IDAlreadyInLIst = false

		-- scann all objects
		for i = 1, #ObjectHandleWindow.ObjectsData.ObjectId do
			
			-- get the current object ID
			local objectId = ObjectHandleWindow.ObjectsData.ObjectId[i]

			-- is the mobile in list?
			if objectId == mobileId then
				IDAlreadyInLIst = true
				break
			end
		end

		-- is the mobile in list?
		if not IDAlreadyInLIst then
			table.insert(WindowData.ObjectHandle.Names, GetMobileName(mobileId))
			table.insert(WindowData.ObjectHandle.ObjectId, mobileId)
			table.insert(WindowData.ObjectHandle.IsMobile, true)
			table.insert(WindowData.ObjectHandle.Notoriety, GetMobileNotoriety(mobileId, true) - 1)
		end
	end
	--]]
	
	-- update the labels
	ObjectHandleWindow.CreateObjectHandles()

	-- scan all object handles windows
	for itemId, _ in pairs(ObjectHandleWindow.hasWindow) do

		-- is the object gone or the player has it or has been ignored?
		if not IsValidObject(itemId) or DoesPlayerHaveItem(itemId) or ContainerWindow.IgnoreItems[itemId] ~= nil then

			-- destroy the label
			ObjectHandle.DestroyObjectWindow(itemId) 
		end
	end

	-- scavenging an item from the ground
	if ContainerWindow.CanPickUp and ObjectHandleWindow.IsScavengerEnabled() then
		
		-- sometimes it fails to pick up something, so we must make sure that the player has the item or it will get lost
		if IsValidID(ObjectHandleWindow.lastItem) and not DoesPlayerHaveItem(ObjectHandleWindow.lastItem) and not ObjectHandleWindow.retryItems[ObjectHandleWindow.lastItem] then
			
			-- mark this item as "retry", so it won't be tried again
			ObjectHandleWindow.retryItems[ObjectHandleWindow.lastItem] = true
			ObjectHandleWindow.lastItem = 0
		end
		
		-- set the scavenge bag
		local scavengeBag = ObjectHandleWindow.GetScavengerContainer()

		-- get an item to pickup
		local objectId = ObjectHandleWindow.GetAnItemToScavenge()

		-- do we have a valid item to pickup?
		if IsValidID(objectId) then

			-- get the item data
			local itemData = Interface.GetObjectInfoData(objectId)

			-- do we have the item data?
			if itemData then

				 -- make sure the item is no inside a container (but the containerId variable in itemData may not be reliable)
				if itemData.containerId == 0 and not ContainerWindow.IsObjectRegistered(objectId) then

					-- mark the item as last item
					ObjectHandleWindow.lastItem = objectId

					-- try to pickup the item
					MoveItemToContainer(objectId, itemData.quantity, scavengeBag)
				end
			end
		end
	end
end

function ObjectHandleWindow.OnMouseOverEnd()

	-- clear item properties
	ItemProperties.ClearMouseOverItem()

	-- reset current over ID
	ObjectHandleWindow.mouseOverId = 0
end

function ObjectHandleWindow.HandleLobsterTrap(objectId, name)

	-- do we have a valid object ID and name?
	if not IsValidID(objectId) or not IsValidWString(name) then
		return
	end

	-- is this a lobster trap?
	if wstring.find(wstring.lower(name), L"lobster trap", 1, true) then

		-- get the object type
		local objectType = GetItemType(objectId)

		-- do we have a valid object type and it's a lobster trap?
		if IsValidID(objectType) and objectType == 17612 then
			
			-- if it's not already there, we add the trap to the buoy array
			if not BuoyTool.Items[objectId]  then
				BuoyTool.Items[objectId] = {}
				BuoyTool.Items[objectId].bobs = 0
			end

			-- getting the buoy owner data
			local hasProp, ownerData = ItemProperties.DoesItemHasProperty( objectId, 1116390 )  -- ~1_NAME~'s lobster trap
			if hasProp then
				BuoyTool.Items[objectId].owner = ownerData[1]
			end
		end
	end
end

function ObjectHandleWindow.ParseNameWithFilters(name)

	-- do we have a valid filter?
	if IsValidWString(ObjectHandleWindow.CurrentFilter) then

		-- split the text with | to get all the filters
		for cf in wstring.gmatch(ObjectHandleWindow.CurrentFilter, L"[^|]+") do
            
			-- is the current filter in the item name?
			if wstring.find(wstring.lower(name), wstring.lower(cf), 1, true) then
                return true
            end
        end

	else -- no filters present
		return true
	end

	return false
end

function ObjectHandleWindow.IsLostItem(objectId)

	-- is this a mobile?
	if not IsMobile(objectId) then

		-- is this a lost item?
		local hasProp = ItemProperties.DoesItemHasProperty( objectId, 1151520 )  -- lost item (Return to gain Honesty)

		return hasProp
	end

	return false
end

function ObjectHandleWindow.CreateHandle(objectId, orderIndex, name, hue)

	-- initializing basic variables
	local windowName = "ObjectHandleWindow"..objectId
	local windowTintName = windowName.."Tint"
	local labelName = windowName.."TintName"

	-- initializing handle
	CreateWindowFromTemplate(windowName, "ObjectHandleWindow", "Root")
	WindowSetScale(windowName, ObjectHandleWindow.ObjectHandleScale)
	WindowSetAlpha(windowName, ObjectHandleWindow.ObjectHandleAlpha)
	WindowSetId(windowName, objectId)

	-- clearing and setting name
	LabelSetText(labelName, wstring.trim(name))

	-- coloring the handle
	WindowSetTintColor(windowTintName, hue.r, hue.g, hue.b)

	-- showing the handle over the object
	AttachWindowToWorldObject(objectId, windowName)
end

function ObjectHandleWindow.IsScavengerEnabled()

	-- do we ave an active scavenger or the scavenge all option is active?
	if Organizer.Scavengers_Items[Organizer.ActiveScavenger] > 0 or Interface.Settings.ScavengeAll then

		return true
	end

	return false
end

function ObjectHandleWindow.GetAnItemToScavenge()

	-- is it the scavenger enabled?
	if ObjectHandleWindow.IsScavengerEnabled() then

		-- scan all labels
		for itemId, value in pairs(ObjectHandleWindow.hasWindow) do

			-- is this a mobile?
			if IsMobile(itemId) then
				continue
			end

			-- is this the last item we tried to pick up?
			if itemId == ObjectHandleWindow.lastItem or ObjectHandleWindow.retryItems[itemId] then
				continue
			end
			
			-- is this a valid item and it's in a range of 2 tiles from the player?
			if (IsValidObject(itemId) and GetDistanceFromPlayer(itemId) <=2) then

				 -- any item is good if we want to scavenge all
				if Interface.Settings.ScavengeAll then
					return itemId

				else -- determining if the item is compatible with the items specified by the player
					local itemData = Interface.GetObjectInfoData(itemId)

					-- do we have the item data?
					if itemData then
						
						-- scan all the items type to pickup
						for _, itemL in pairs(Organizer.Scavenger[Organizer.ActiveScavenger]) do

							-- is this item of the type and hue we're looking for?
							if (itemL.type > 0 and itemL.type == itemData.objectType and itemL.hue == itemData.hueId) then
								return itemId
							end
						end
					end
				end
			end
		end

		-- reset the retry items
		ObjectHandleWindow.retryItems = {}
	end

	return
end

function ObjectHandleWindow.GetScavengerContainer()

	-- scavenger bag ID
	local scavengeBag = Organizer.Scavengers_Cont[Organizer.ActiveScavenger]

	-- if the container is not specified or unavailable, the default is the player backpack
	if not IsValidID(scavengeBag) or not DoesPlayerHaveItem(scavengeBag) then

		return ContainerWindow.PlayerBackpack
	end

	return scavengeBag
end