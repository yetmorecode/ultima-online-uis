----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

ContainerWindow = {}
ContainerWindow.OpenContainers = {}
ContainerWindow.RegisteredItems = {}
ContainerWindow.ViewModes = {}

ContainerWindow.POSITION_OFFSET = 100
ContainerWindow.TimePassedSincePickUp = 0
ContainerWindow.CanPickUp = true

ContainerWindow.TID_GRID_MODE = 1079439
ContainerWindow.TID_FREEFORM_MODE = 1079440
ContainerWindow.TID_LIST_MODE = 1079441

ContainerWindow.GRID_SLOT_SCALE = 0.2 -- % of the window scale

ContainerWindow.Grid_MinWidth = 250
ContainerWindow.List_MinWidth = 360

ContainerWindow.CHESS_GUMP = 2330
ContainerWindow.BACKGAMMON_GUMP = 2350
ContainerWindow.PLAGUE_BEAST_GUMP = 10851

-- used for windows the player doesn't own
ContainerWindow.Cascade = {}
ContainerWindow.Cascade.Movement = { x=0, y=0 }

ContainerWindow.PlayerBackpack = 0
ContainerWindow.PlayerBank = 0

ContainerWindow.IgnoreItems = {}

ContainerWindow.waitItems = {}

ContainerWindow.Locked = false

ContainerWindow.LastUsesDelta = {}
ContainerWindow.CurrentUses = {}

ContainerWindow.RefreshRate = 0.1 -- the containers refresh time
ContainerWindow.UsesRefreshRate = 60 -- the refresh rate for item uses/charges

ContainerWindow.MaxSlotsPerGrid = 300 -- max number of slots allowed for the grid mode, any amount greater than this one will turn the container to list view.

ContainerWindow.LagReductionLimit = 50 -- max number of items that the UI can parse and sort before it blows up.

ContainerWindow.PickupWaitTime = 1 -- timer that prevents items to being picked up too often
ContainerWindow.LootAll = {}

ContainerWindow.ContainerItems = {}
ContainerWindow.SortedItems = {}

ContainerWindow.lastCorpse = 0 -- used to create the cascade effect on corpses

ContainerWindow.FindItems = {}

ContainerWindow.ContainerLastSeen = {}

ContainerWindow.ItemsProps = {}

ContainerWindow.FindersKeepersActiveItems = {} -- list of the finders keepers items in the open containers

ContainerWindow.ViewModesNames = 
{
	["Grid"] = true,
	["List"] = true,
	["Freeform"] = true,
}

----------------------------------------------------------------
-- ContainerWindow Functions
----------------------------------------------------------------

function ContainerWindow.InitializeFindItems()

	-- load the finders keepers items list
	ContainerWindow.Initialized = true
	ContainerWindow.FindItems = LoadSaveStructureWithPlayerID(ContainerWindow.SavedFindItems)
	SettingsWindow.UpdateLootItemsList()
end

-- Helper function
function ContainerWindow.ReleaseRegisteredObjects(id)

	-- do we have a valid id?
	if not IsValidID(id) then
		return
	end
	
	-- total unregister of the items and properties inside a container
	if (ContainerWindow.RegisteredItems[id] ~= nil) then
		for id, value in pairs(ContainerWindow.RegisteredItems[id]) do
			UnregisterWindowData(WindowData.ObjectInfo.Type, id)
			UnregisterWindowData(WindowData.ItemProperties.Type, id)

			-- remove the item from the finders keepers list
			ContainerWindow.FindersKeepersActiveItems[id] = nil
		end
	end

	-- reset the registered items list
	ContainerWindow.RegisteredItems[id] = {}
end

function ContainerWindow.IsObjectRegistered(searchID)

	-- are there any object registered?
	if (ContainerWindow.RegisteredItems ~= nil) then

		-- csan the containers to find out
		for id, data in pairs(ContainerWindow.RegisteredItems) do
			if data[searchID] then
				return true, id
			end
		end
	end
end

function ContainerWindow.InitializePlayerContainersID(timePassed)

	-- acquire player backpack ID
	if not IsValidID(ContainerWindow.PlayerBackpack) then
		ContainerWindow.PlayerBackpack = GetBackpackID(GetPlayerID())
	end

	-- acquire player bank container ID
	if not IsValidID(ContainerWindow.PlayerBank) then
		--ContainerWindow.PlayerBank = GetPlayerBankID()
	end

	-- do we have an empty backpack items list?
	if not Interface.BackPackItems or table.countElements(Interface.BackPackItems) == 0 then
		
		-- update the player backpack items list
		Interface.BackPackItems = ContainerWindow.ScanQuantities(ContainerWindow.PlayerBackpack, true)
	end
end

function ContainerWindow.RestoreContainerPosition( this, windowID, switchView )

	-- has the container style just changed?
	if not switchView then

		-- let's restore the window position
		local alias = "CID" .. windowID
		
		-- is this a corpse?
		if ContainerWindow.OpenContainers[windowID].isCorpse and windowID ~= ContainerWindow.PlayerBackpack then

			-- loading the starting position for corpses cascade
			if WindowUtils.CanRestorePosition("corpse") and ContainerWindow.lastCorpse == 0 then
				WindowUtils.RestoreWindowPosition(this, false, "corpse", true)
			
			else -- since there is at least another corpse open, we add the new ones to a cascade

				-- clear container position
				WindowClearAnchors(this)

				-- is this the last corpse?
				if ContainerWindow.lastCorpse ~= 0 then

					-- offset this container from the parent
					local x, y = ContainerWindow.GetCascadeOffset("ContainerWindow_"..ContainerWindow.lastCorpse)
					WindowAddAnchor(this, "topleft", "Root", "topleft", x, y)	

					-- add the container to the cascade list
					ContainerWindow.AddToCascade(windowID)

				else -- first container of the cascade
					local x, y = ContainerWindow.GetFirstCascadePosition(this)
					WindowAddAnchor(this, "topleft", "Root", "topleft", x, y)
					
					-- add the container to the cascade list
					ContainerWindow.AddToCascade(windowID)	
				end
			end

			-- if there is no last corpse or the last corpse is not this one, we set this one as last corpse (to add the next corpse to the cascade)
			if ContainerWindow.lastCorpse == 0 or ContainerWindow.lastCorpse ~= windowID then
				ContainerWindow.lastCorpse = windowID
			end
		
		-- is this a player vendor container?
		elseif ContainerWindow.OpenContainers[windowID].isPlayerVendor and windowID ~= ContainerWindow.PlayerBackpack then
			
			-- get the ID of the parent container
			local parentContainerId = GetParentContainer(windowID)

			-- if the ID is invalid or the parent container window doesn't exist we nullify it
			if not IsValidID(parentContainerId) or not DoesWindowExist("ContainerWindow_"..parentContainerId) then
				parentContainerId = nil
			end

			-- the parent container exist
			if IsValidID(parentContainerId) then
				
				-- clear the position
				WindowClearAnchors(this)

				-- offset this container from the parent
				local x, y = ContainerWindow.GetCascadeOffset("ContainerWindow_"..parentContainerId)
				WindowAddAnchor(this, "topleft", "Root", "topleft", x, y)	

				-- add the container to the cascade list
				ContainerWindow.AddToCascade(windowID)
				
			-- this is probably the main container of the vendor, so we restore the saved position
			elseif WindowUtils.CanRestorePosition("playerVendor") then
				WindowUtils.RestoreWindowPosition(this, not Interface.Settings.GridLegacy, "playerVendor", true)

			else -- if window position couldn't be restored, cascade the containers from the top left of the screen
				
				-- initialize location variables
				local x, y
				
				-- get the ID of the previous cascade item (if there is one)
				local topCascadingId = ContainerWindow.GetTopOfCascade()

				-- no previous cascade item? this is the first then
				if not IsValidID(topCascadingId) then
					x, y = ContainerWindow.GetFirstCascadePosition(this)

				else -- get the cascade position
					x, y = ContainerWindow.GetCascadeOffset("ContainerWindow_"..topCascadingId)
				end
				
				-- positioning the container
				WindowClearAnchors(this)
				WindowAddAnchor(this, "topleft", "Root", "topleft", x, y)	
				
				-- add the container to the cascade list
				ContainerWindow.AddToCascade(windowID)
			end
			
		-- do we have a saved position for this container?
		elseif WindowUtils.CanRestorePosition(alias) and windowID ~= ContainerWindow.PlayerBackpack then
			WindowUtils.RestoreWindowPosition(this, not Interface.Settings.GridLegacy, alias, true)
			
		-- no positon saved and its not the player backpack?
		elseif windowID ~= ContainerWindow.PlayerBackpack then

			-- if the window position can't be restored, try to place this container near its parent container
			local parentContainerId = GetParentContainer(windowID)

			-- if the ID is invalid or the parent container window doesn't exist we nullify it
			if not IsValidID(parentContainerId) or not DoesWindowExist("ContainerWindow_"..parentContainerId) then
				parentContainerId = nil
			end

			-- we have a parent container AND it's not the player backpack
			if IsValidID(parentContainerId) and parentContainerId ~= ContainerWindow.PlayerBackpack then

				-- clear the window position
				WindowClearAnchors(this)

				-- offset this container from the parent
				local x, y = ContainerWindow.GetCascadeOffset("ContainerWindow_"..parentContainerId)
				WindowAddAnchor(this, "topleft", "Root", "topleft", x, y)	

				-- add the container to the cascade list
				ContainerWindow.AddToCascade(windowID)
				
			else -- if window position couldn't be restored, cascade the containers from the top left of the screen
				
				-- initialize location variables
				local x, y

				-- get the ID of the previous cascade item (if there is one)
				local topCascadingId = ContainerWindow.GetTopOfCascade()

				-- no previous cascade item? this is the first then
				if not IsValidID(topCascadingId) then
					x, y = ContainerWindow.GetFirstCascadePosition(this)

				else -- get the cascade position
					x, y = ContainerWindow.GetCascadeOffset("ContainerWindow_"..topCascadingId)
				end
				
				-- positioning the container
				WindowClearAnchors(this)
				WindowAddAnchor(this, "topleft", "Root", "topleft", x, y)	
				
				-- add the container to the cascade list
				ContainerWindow.AddToCascade(windowID)
			end

			-- do we have grid legacy mode active (not free form)?
			if not Interface.Settings.GridLegacy and ContainerWindow.ViewModes[windowID] ~= "Freeform" then

				-- creating grid
				ContainerWindow.CreateGridViewSockets(this)
				
				-- min colums for the grid
				local minColumns = 5

				-- grid window name
				local grid_view_this = this.."GridView"

				-- get the scrollbar width
				local scrollbarWidth = WindowGetDimensions(grid_view_this.."Scrollbar")
				
				-- get the slot size
				local slotSize = WindowGetDimensions(this.."GridViewSocket1")
						
				-- calculating the min grid size
				local minSize = (slotSize * minColumns) - scrollbarWidth

				-- checking if the scaled grid width is different from the min size we calculated before, if it is, we use what we calculated.
				if ContainerWindow.Grid_MinWidth * WindowGetScale(this) ~= minSize then
					ContainerWindow.Grid_MinWidth = minSize
				end
				
				-- updating the min width for the current container
				local minWidth = ContainerWindow.Grid_MinWidth

				-- calculating the min height for the current container
				local minHeight = minWidth + slotSize - 10

				-- updating the container size
				WindowSetDimensions(this, minWidth, minHeight)
			end

		-- is this the player backpack and we can't restore the position? thn probably it's the first time has been open and we move it automatically...
		elseif not WindowUtils.CanRestorePosition("playerBackpack") and windowID == ContainerWindow.PlayerBackpack then
			Interface.BackpackFirstPositioning = true

		-- can we restore the backpack position and is the player backpack?
		elseif WindowUtils.CanRestorePosition("playerBackpack") and windowID == ContainerWindow.PlayerBackpack then
			WindowUtils.RestoreWindowPosition(this, not Interface.Settings.GridLegacy, "playerBackpack", true)
		end
	end
end

-- sets legacy container art
function ContainerWindow.SetLegacyContainer( windowID, switchView, noupdate )

	-- do we have a valid id?
	if not IsValidID(windowID) then
		return
	end

	-- container window name
	local this = "ContainerWindow_" .. windowID

	-- does the window really exist?
	if not DoesWindowExist(this) then
		return
	end

	-- does the open container array exist for this container?
	if not ContainerWindow.OpenContainers[windowID] then
		return
	end
	requestedContainerArt = requestedContainerArt or {}
	requestedContainerArt =  ContainerWindow.OpenContainers[windowID].requestedContainerArt

	local gumpID = ContainerWindow.OpenContainers[windowID].requestedContainerArt
	-- TEST AREA --
	--gumpID = 19724
	---------------
	
	-- is this a valid gump ID?
	if not IsValidID(gumpID) then
        --Debug.Print("ContainerWindow.SetLegacyContainer: gumpID is nil!")       
        return
    end
    	
	-- hide unwanted container elements
	WindowSetShowing( this.."Chrome", false )
	WindowSetShowing( this.."Title", false )
	
	WindowSetShowing(this.."ContImageBG", false)
	WindowSetShowing(this.."ContImageBlackBG", false)
	WindowSetShowing(this.."ContImage", false)

	WindowSetShowing(this.."Organize", false)
	WindowSetShowing(this.."Restock", false)	
	WindowSetShowing(this.."Search", false)			
	WindowSetShowing(this.."LootAll", false)
	WindowSetShowing(this.."ViewButton", true)
	WindowSetShowing(this.."ResizeButton", false)
	WindowSetShowing(this.."LootSort", false)
		
	WindowSetShowing(this.."ListView" , false)
	WindowSetShowing(this.."GridView", false)
	WindowSetShowing(this.."FreeformView", true)
		
	-- is this the player backpack?
	if windowID == ContainerWindow.PlayerBackpack then

		-- repositioning the lock button for legacy style
		WindowClearAnchors(this.."Lock")
		WindowSetLayer(this.."Lock", Window.Layers.OVERLAY )
		WindowAddAnchor( this.."Lock", "top", this.."LegacyContainerArt", "center", 0, 35)

		-- show the lock button
		WindowSetShowing(this.."Lock", true)

	else
		-- hide the lock button
		WindowSetShowing(this.."Lock", false)
	end
	
	-- is this a mini-game gump?
	if (gumpID ~= ContainerWindow.CHESS_GUMP and gumpID ~= ContainerWindow.BACKGAMMON_GUMP and gumpID ~= ContainerWindow.PLAGUE_BEAST_GUMP) then
		
		-- repositioning the button to switch view style
		WindowClearAnchors(this.."ViewButton")
		WindowSetLayer(this.."ViewButton", Window.Layers.OVERLAY )
		WindowAddAnchor( this.."ViewButton", "topleft", this.."LegacyContainerArt", "topleft", ContainersInfo.LegacyViewButtonLocation[gumpID].x, ContainersInfo.LegacyViewButtonLocation[gumpID].y)
	end
	
	-- scaling the gump properly with the interface
	WindowSetScale(this, InterfaceCore.scale)   
	
	-- get the default freeform scale
	local scale = SystemData.FreeformInventory.Scale
		
	-- initialize texture variables
	local texture = gumpID
	local xSize, ySize

	-- acquiring the texture info
	texture, xSize, ySize = RequestGumpArt( texture )

	-- the texture size is equal to the biggest side
	local textureSize = xSize
	if (textureSize < ySize) then
		textureSize = ySize
	end

	ContainerWindow.OpenContainers[windowID].textureSize = textureSize
	
	-- show legacy container art
	WindowSetDimensions( this, xSize * scale, ySize * scale )
	WindowSetShowing( this.."LegacyContainerArt", true )
	WindowClearAnchors(this.."LegacyContainerArt")
	WindowAddAnchor( this.."LegacyContainerArt", "topleft", this, "topleft", 0, 0 )
	WindowSetDimensions( this.."LegacyContainerArt", xSize * scale, ySize * scale )
	DynamicImageSetTexture( this.."LegacyContainerArt", texture, 0, 0 )
	DynamicImageSetTextureScale( this.."LegacyContainerArt", scale )
	
	-- load the legacy container core texture
	DynamicImageSetTextureDimensions(this.."FreeformView", textureSize * scale, textureSize * scale)
	WindowSetDimensions(this.."FreeformView", textureSize * scale, textureSize * scale)
	DynamicImageSetTexture(this.."FreeformView", "freeformcontainer_texture"..windowID, 0, 0)
	DynamicImageSetTextureScale(this.."FreeformView", InterfaceCore.scale * scale)
	WindowSetShowing(this.."FreeformView", true)
	
	-- Content Text
	WindowSetScale(this.."Content", InterfaceCore.scale/scale)
	WindowClearAnchors(this.."Content")
	WindowAddAnchor( this.."Content", "bottom", this.."FreeformView", "top", ContainersInfo.LegacyContentLabelLocation[gumpID].x, ContainersInfo.LegacyContentLabelLocation[gumpID].y )

	-- restoring the container position
	ContainerWindow.RestoreContainerPosition( this, windowID, switchView )
	
	-- is this the player backpack and it's the first time has been open?
	if (windowID == ContainerWindow.PlayerBackpack and Interface.BackpackFirstPositioning) then

		-- we get the location of the game area
		local Rx, Ry= WindowGetOffsetFromParent("ResizeWindow")

		-- we get the size of the game area
		local w, h = WindowGetDimensions("ResizeWindow")
		
		-- we get the size of this container
		local wMe, hMe = WindowGetDimensions(this)
		
		-- clear the container position
		WindowClearAnchors(this)

		-- we position the container just on the bottom left of the game area
		WindowAddAnchor(this, "topleft", "Root", "topleft", (Rx + w) - wMe, (Ry + h) - 80)
	end
	
	-- flag this container as visible
	ContainerWindow.OpenContainers[windowID].shown = true
	
	-- skip the update?
	if not noupdate then

		-- update the container contents
		ContainerWindow.UpdateContents(windowID)
	end

	-- showing the window
	WindowSetShowing(this, true)
end

-- OnInitialize Handler
function ContainerWindow.Initialize()
	
	-- get the container ID
	local id = SystemData.DynamicWindowId	

	-- do we have a valid id?
	if not IsValidID(id) then
		return
	end

	-- container window name
	local this = "ContainerWindow_" .. id

	-- does the window really exist?
	if not DoesWindowExist(this) then
		return
	end
	
	-- hiding the container until we have all the data
	WindowSetShowing(this, false)

	-- clear the container position
	WindowClearAnchors(this)

	-- moving it out of the screen so that it won't flicker around
	WindowAddAnchor(this, "topleft", "Root", "topleft", -400, -400)

	-- assign the ID to the window
	WindowSetId(this, id)

	-- is this the trap box?
	if IsValidID(Interface.TrapBoxID) and id == Interface.TrapBoxID then	

		-- we leave the container out of the screen and close it.
		DestroyWindow(this)
		return
	end
	
	-- mark this window to be destroyed on close
	Interface.DestroyWindowOnClose[this] = true

	-- if the container is already registered we unregister it first (or it will cause problems with legacy containers)
	if WindowData.ContainerWindow[id] then
		UnregisterWindowData(WindowData.ContainerWindow.Type, id)		
	end

	-- getting the container data
	local containerData = Interface.GetContainersData(id, true)

	-- initialize the number of items to 0
	local numItems = 0

	-- initialize the gump ID to the default ID
	local gumpNum = ContainersInfo.DefaultGump 

	-- do we have the container data?
	if containerData then

		-- get the right amount of items
		numItems = containerData.numItems

		-- get the right gump ID
		gumpNum = containerData.gumpNum
	end

	-- is this the player backpack?
	if id == ContainerWindow.PlayerBackpack then
		
		-- registering the slot
		Interface.GetPlayerEquipmentData(EquipmentData.EQPOS_BACKPACK)
	end
	
	-- initialize the container info record
	ContainerWindow.OpenContainers[id] = {open = true, cascading = false, numItems = numItems, numCreatedSlots = 0, numCreatedRows = 0, maxSlots = SystemData.ActiveContainer.NumSlots, isCorpse = false, shown = false, isPlayerVendor = false, laggy = false}
	
	-- getting the gump info
	local gumpID, typeName = ContainersInfo.GetGump(id, gumpNum)
	
	-- setting the gump to request for the background
	ContainerWindow.OpenContainers[id].requestedContainerArt = gumpID
	
	-- saving the backpack open status
	if (id == ContainerWindow.PlayerBackpack) then
		Interface.BackpackOpen  = true
		Interface.SaveSetting( "BackpackOpen", Interface.BackpackOpen  )
	end
	
	-- is this a corpse?
	if (typeName == "corpse" or typeName == "bones") then
		ContainerWindow.OpenContainers[id].isCorpse = true 
	else 
		ContainerWindow.OpenContainers[id].isCorpse = false
	end	

	-- checking if is a player vendor container
	
	-- get the parent container ID
	local parentContainerId = GetParentContainer(id)
	
	-- is this the last object used from a container?
	if ContainerWindow.LastItemData and ContainerWindow.LastItemData.lastObj == Interface.LastItem then

		-- get the right parent container
		parentContainerId = ContainerWindow.LastItemData.currCont
	end

	-- if the ID is invalid or the parent container window doesn't exist we nullify it
	if not IsValidID(parentContainerId) or not DoesWindowExist("ContainerWindow_"..parentContainerId) then
		parentContainerId = nil
	end

	-- we assume the container is not from a player vendor
	local isPlayerVendor = false

	-- the player vendor gump has requested to open the inventory so this IS a player vendor
	if ContainerWindow.NextIsPlayerVendor then

		-- set the container as a player vendor container
		isPlayerVendor = true

		-- remove the flag
		ContainerWindow.NextIsPlayerVendor = nil

	-- is the parent container ID valid and already open?
	elseif IsValidID(parentContainerId) and ContainerWindow.OpenContainers[parentContainerId] then

		-- if the parent container is from a player vendor then, this is also from a player vendor
		isPlayerVendor = ContainerWindow.OpenContainers[parentContainerId].isPlayerVendor

	-- no poarent? we check the last mobile the player interacted with
	elseif IsValidID(Interface.LastMobile) and not ContainerWindow.IgnoreLastMobile then

		-- if the last mobile is a player vendor, then this is a container from a player vendor.
		isPlayerVendor = IsPlayerVendor(Interface.LastMobile)

		-- make sure we ignore the last mobile since we've already checked it.
		ContainerWindow.IgnoreLastMobile = true

	-- does the player have opened the container through the vendor map?
	elseif ContainerWindow.VendorSearchMapRequest == true then

		-- reset the flag after 1 second so if there are several sub-containers they all be seen as player vendor
		Interface.AddTodoList({name = "vendor search map open vendor reset vendor flag", func = function() ContainerWindow.VendorSearchMapRequest = nil end, time = Interface.TimeSinceLogin + 1})

		-- mark the container as player vendor
		isPlayerVendor = true
	end

	-- saving the player vendor status we acquired
	ContainerWindow.OpenContainers[id].isPlayerVendor = isPlayerVendor
	-----

	-- initialize view modes
	
	-- get the view style saved
	local savedView = Interface.LoadSetting(this .. "ViewMode", nil, "")
	
	-- is the clock updated?
	if Interface.Clock.Timestamp == 0 then
		pcall(Interface.ClockUpdater, timePassed) 
	end

	-- saving the timestamp we last seen this container (so we can forget about it in a week if se don't see it again)
	ContainerWindow.ContainerLastSeen[id] = Interface.Clock.Timestamp

	-- if this is a mini game gump, we have to force the free form mode
	if (gumpID == ContainerWindow.CHESS_GUMP or gumpID == ContainerWindow.BACKGAMMON_GUMP or gumpID == ContainerWindow.PLAGUE_BEAST_GUMP) then
        ContainerWindow.ViewModes[id] = "Freeform"	
		
	-- is this a corpse?
	elseif ContainerWindow.OpenContainers[id].isCorpse then

		-- does the number of slots required OR the number of items is greater than the maximum number of slots possible?
		if (ContainerWindow.OpenContainers[id].maxSlots > ContainerWindow.MaxSlotsPerGrid or numItems > ContainerWindow.MaxSlotsPerGrid) then

			-- we force list view mode or there will be a great lag
			ContainerWindow.ViewModes[id] = "List"

			-- saving the view style
			Interface.SaveSetting(this .. "ViewMode", "List")

		else -- we se the default view mode for corpses
			ContainerWindow.ViewModes[id] = SystemData.Settings.Interface.defaultCorpseMode
		end
		
		-- is the auto-ignore corpse enabled?
		if (Interface.Settings.EnableAutoIgnoreCorpses) then

			-- is this container already listd?
    		if (not ContainerWindow.IgnoreItems[Interface.LastItem]) then

				-- we add it to the ignore list for 30 minutes (enough time for the corpse to disappear forever)
    			ContainerWindow.IgnoreItems[Interface.LastItem] = Interface.Clock.Timestamp + 1800
    		end

			-- we remove the object handle for this corpse (if the object handles are active)
    		ObjectHandle.DestroyObjectWindow(Interface.LastItem) 
		end
		
	-- does the number of slots required for this container is greater than the maximum amount possible of slots?
	elseif (ContainerWindow.OpenContainers[id].maxSlots > ContainerWindow.MaxSlotsPerGrid) then

		-- we force list view mode or there will be a great lag
		ContainerWindow.ViewModes[id] = "List"

		-- saving the view style
		Interface.SaveSetting(this .. "ViewMode", "List")
		
	-- is this the player backpack?
	elseif id == ContainerWindow.PlayerBackpack then

		-- load the saved view mode (or the default one for backpack)
		savedView = Interface.LoadSetting("BackpackView", SystemData.Settings.Interface.inventoryMode, "")
		
	-- is this a player vendor?
	elseif ContainerWindow.OpenContainers[id].isPlayerVendor then

		-- load the saved view mode (or the default one for player vendors)
		savedView = Interface.Settings.playerVendorView
	end

	-- for some REALLY weird reason, sometimes the container view mode become something totally random, in that case we reset it to default...
	if not ContainerWindow.ViewModesNames[savedView] then
		savedView = nil
	end
	
	-- if there is no view mode set for the container, we initialize it with the default one
	if not ContainerWindow.ViewModes[id] then 
		ContainerWindow.ViewModes[id] = SystemData.Settings.Interface.defaultContainerMode
	end
	
	-- is the saved view mode different from the one already set on the container?
	if savedView and savedView ~= ContainerWindow.ViewModes[id] then

		-- if the container doesn't have more than the maximum number of slots possible, we use the saved view mode
		if not (ContainerWindow.OpenContainers[id].maxSlots > ContainerWindow.MaxSlotsPerGrid or numItems > ContainerWindow.MaxSlotsPerGrid) then
			ContainerWindow.ViewModes[id] = savedView
		
		else
			-- we force list view mode or there will be a great lag
			ContainerWindow.ViewModes[id] = "List"

			-- saving the view style
			Interface.SaveSetting(this .. "ViewMode", "List")
		end
	end

	-- does the number of items in this container goes over the max number of items the UI can process at time?
	if numItems > ContainerWindow.LagReductionLimit and ContainerWindow.OpenContainers[id].isCorpse then

		-- we flag this container as laggy
		ContainerWindow.OpenContainers[id].laggy = true
	end
	-- done getting view mode

	-- enable the loot sort button	
	ButtonSetCheckButtonFlag(this.."LootSort", true)
	
	-- backpack buttons management
	if (id == ContainerWindow.PlayerBackpack) then

		-- restore the lock button status
		local texture = "Lock"
		if not ContainerWindow.Locked  then
			texture = "UnLock"
		end
			
		-- restore the lock button textures
		ButtonSetTexture(this.."Lock", InterfaceCore.ButtonStates.STATE_NORMAL, texture, 0,0)
		ButtonSetTexture(this.."Lock",InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, texture, 0,0)
		ButtonSetTexture(this.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED, texture, 0,0)
		ButtonSetTexture(this.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, texture, 0,0)
		---
			
		-- removing the loot sort settings (not available for player backpack)
		Interface.DeleteSetting(this .. "LootSort")

		-- hiding the loot sort button
		WindowSetShowing(this.."LootSort", false)
			
		-- flagging the inventory button as pressed
		ContainerWindow.SetInventoryButtonPressed(true)

		-- making the container movable (if not locked)
		WindowSetMovable(this, not ContainerWindow.Locked )	
	end
	
	-- safety update (to make sure all items are visible)
	--Interface.AddTodoList({func = function() ContainerWindow.ForceContainerUpdate(id) end, time = Interface.TimeSinceLogin + 3})

	-- the container items are missing, so we wait until they are available to show it (trap box excluded).
	if (not Interface.VerifyContainer(id, containerData) and id ~= Interface.TrapBoxID) then

		-- mark this container as "waiting for items"
		ContainerWindow.waitItems[id] = true
		return
	end
	
	-- do we have the free form view enabled?
	if ContainerWindow.ViewModes[id] == "Freeform" then 
		
		-- since the free form containers works really bad (and it's all inside the client so we can't do anything about it), we create it first in list view
		ContainerWindow.ViewModes[id] = "List"
		ContainerWindow.CreateContainer(this)

		-- set to free form again (this time should work)
		ContainerWindow.ViewModes[id] = "Freeform"
		ContainerWindow.SetLegacyContainer(id)
	
	else -- we create the normal container UI
		ContainerWindow.CreateContainer(this)
	end

	-- registering the main events for update
	WindowRegisterEventHandler(this, WindowData.ContainerWindow.Event, "ContainerWindow.MiniModelUpdate")
	WindowRegisterEventHandler(this, WindowData.ObjectInfo.Event, "ContainerWindow.HandleUpdateObjectEvent")
end

function ContainerWindow.Shutdown()
	
	-- getting the container id
	local id = WindowGetId(WindowUtils.GetActiveDialog())

	-- do we have a valid id?
	if not IsValidID(id) then
		return
	end

	-- container window name
	local this = "ContainerWindow_"..id

	-- does the window really exist?
	if not DoesWindowExist(this) then
		return
	end
	
	-- do we have a texture loaded?
	if ContainerWindow.OpenContainers[id] and ContainerWindow.OpenContainers[id].requestedContainerArt and tonumber( ContainerWindow.OpenContainers[id].requestedContainerArt) then

		-- release the texture
		ReleaseGumpArt( tonumber( ContainerWindow.OpenContainers[id].requestedContainerArt ) )
	end

	-- was this the last corpse opened?
	if ContainerWindow.lastCorpse == id then

		-- reset the last corpse ID (used on the cascade)
		ContainerWindow.lastCorpse = 0
	end
	
	-- was this container visible?
	if ContainerWindow.OpenContainers[id] and ContainerWindow.OpenContainers[id].shown then

		-- let's save the backpack position
		if id == ContainerWindow.PlayerBackpack then
			WindowUtils.SaveWindowPosition(this, not Interface.Settings.GridLegacy, "playerBackpack")
			
		-- save the default corpse position (if not in the cascade)
		elseif ContainerWindow.OpenContainers[id].isCorpse and not ContainerWindow.IsCascading(id) then
			WindowUtils.trackSize["corpse"] = not Interface.Settings.GridLegacy
			WindowUtils.SaveWindowPosition(this, not Interface.Settings.GridLegacy, "corpse")
		
		-- save the player vendor position (if not in the cascade)
		elseif ContainerWindow.OpenContainers[id].isPlayerVendor and not ContainerWindow.IsCascading(id) then
			WindowUtils.trackSize["playerVendor"] = not Interface.Settings.GridLegacy
			WindowUtils.SaveWindowPosition(this, not Interface.Settings.GridLegacy, "playerVendor")
			
		-- if the container is in the cascade, we just remove from the cascade but don't save the position		
		elseif ContainerWindow.IsCascading(id) then
			ContainerWindow.RemoveFromCascade(id)
			
		-- if it's not a trapbox let's save the position.
		elseif id ~= Interface.TrapBoxID then

			-- container alias
			local alias = "CID" .. id

			-- if it's not in grid legacy mode, we save the size too
			WindowUtils.SaveWindowPosition(this, not Interface.Settings.GridLegacy, alias)
		end
	end
	
	-- were we waiting for the items of this container?
	if ContainerWindow.waitItems[id] then
		ContainerWindow.waitItems[id] = nil
	end
	
	-- release all objects (it will work for all the containers and items that are NOT in the player inventory)
	ContainerWindow.ReleaseRegisteredObjects(id)
	
	-- nullify viewmode
	ContainerWindow.ViewModes[id] = nil

	-- nullify container record
	ContainerWindow.OpenContainers[id] = nil
	
	-- nullify uses count
	ContainerWindow.CurrentUses[id] = nil

	-- nullify uses count timer
	ContainerWindow.LastUsesDelta[id] = nil
	
	-- nullify list of items of this container
	ContainerWindow.ContainerItems[id] = nil

	-- nullify sorted list of items
	ContainerWindow.SortedItems[id] = nil
	
	-- is this the player backpack?
	if (id == ContainerWindow.PlayerBackpack) then
		
		-- we remove the pressed effect on the inventory button
		ContainerWindow.SetInventoryButtonPressed(false)
	end
	
	-- are we seen the properties of an item of this container?
	if (ItemProperties.GetCurrentWindow() == this) then

		-- clear item properties
		ItemProperties.ClearMouseOverItem()
	end

	if id == ContainerWindow.PlayerBank then
		GumpsParsing.DestroyGump(GenericGump.BANK_ACTIONS_GUMPID)
		DestroyWindow("ContainerBankMaskTemplate")
	end

	-- send the container close message to the server
	GumpManagerOnCloseContainer(id)
end

-- this function creates the base of the container, so it DOES NOT create slots, but it anchors list and grid correctly.
function ContainerWindow.CreateContainer(this, switchView, noUpdate)

	-- does the window really exist?
	if not DoesWindowExist(this) then
		return
	end
	
	-- get the container ID
	local id = WindowGetId(this)

	-- do we have a valid id?
	if not IsValidID(id) then
		return
	end
	
	-- is this a trap box?
	if id == Interface.TrapBoxID then
		return
	end
	
	-- restore the container position
	ContainerWindow.RestoreContainerPosition( this, id, switchView )
	
	-- getting the current gump texture ID
	local gumpID = ContainerWindow.OpenContainers[id].requestedContainerArt
	
	-- TEST AREA --
	--gumpID = 19724
	---------------
	
	-- list view window name
	local list_view_this = this.."ListView"        

	-- grid view window name
	local grid_view_this = this.."GridView"
	
	-- buttons window names
	local lootAll = this.."LootAll"        
	local restock = this.."Restock"
	local organize = this.."Organize"
	local lock = this.."Lock"
	local search = this.."Search"
	local toggleView = this.."ViewButton"
	local lootSort = this.."LootSort"
	local resizeButton = this.."ResizeButton"

	-- window elements
	local gumpContainerArt = this.."LegacyContainerArt"
	local contFrame = this.."Chrome"
	local contTitle = this.."Title"
	local contImage = this.."ContImage"
	local contentLabel = this.."Content"
	
	-- is this NOT the player backpack and it's not a free form view?
	if id ~= ContainerWindow.PlayerBackpack and ContainerWindow.ViewModes[id] ~= "Freeform" then

		-- loot sort not visible for the player backpack
		WindowSetShowing(lootSort, true)

		-- initialize lootsort status
		local lootSortEnabled 

		-- loading corpse loot sort
		if ContainerWindow.OpenContainers[id].isCorpse then
			lootSortEnabled = Interface.LoadSetting("CropseLtSort", nil, true)

		else -- loading loot sort for any other container
			lootSortEnabled = Interface.LoadSetting(this .. "LootSort", nil, true)
		end
		
		-- no loot sort settings?
		if lootSortEnabled == nil then

			-- disabled by default
			lootSortEnabled = false

			-- is this a corpse or a laggy container?
			if ContainerWindow.OpenContainers[id].isCorpse and not ContainerWindow.OpenContainers[id].laggy then

				-- we neable the loot sort
				lootSortEnabled = true
			end
		end

		ButtonSetPressedFlag( this .. "LootSort", lootSortEnabled)
	end

	-- is grid legacy disabled?
	if (not Interface.Settings.GridLegacy) then
		
		-- show the window border
		WindowSetShowing( contTitle, true )
		
		-- show window title
		WindowSetShowing( contFrame, true )

		-- disable container picture
		WindowSetShowing( gumpContainerArt, false )
		
		-- show/hide container type image in the top left corner (if enabled)
		WindowSetShowing(contImage .."BG", Interface.Settings.ShowContainerType)
		WindowSetShowing(contImage .. "BlackBG", Interface.Settings.ShowContainerType)
		WindowSetShowing(contImage, Interface.Settings.ShowContainerType)
	
		-- showing the main buttons + resize button
		WindowSetShowing(organize, true)
		WindowSetShowing(restock, true)	
		WindowSetShowing(search, true)			
		WindowSetShowing(toggleView, true)
		WindowSetShowing(resizeButton, true)
	
		-- clear position for list view
		WindowClearAnchors(list_view_this)

		-- clear position for grid view
		WindowClearAnchors(grid_view_this)

		-- clear position for buttons
		WindowClearAnchors(lootSort)
		WindowClearAnchors(lootAll)
		WindowClearAnchors(restock)
		WindowClearAnchors(organize)
		WindowClearAnchors(lock)
		WindowClearAnchors(search)
		WindowClearAnchors(toggleView)
	
		-- initialize margins
		local topMargin = 70
		local leftMargin = 10
		local bottomMargin = -13
		local RightMargin = -12
		
		-- anchoring list view with margins
		WindowAddAnchor(list_view_this, "topleft", this, "topleft", leftMargin, topMargin)
		WindowAddAnchor(list_view_this, "bottomright", this, "bottomright", RightMargin, bottomMargin)

		-- anchoring grid view with margins
		WindowAddAnchor(grid_view_this, "topleft", this, "topleft", leftMargin, topMargin)
		WindowAddAnchor(grid_view_this, "bottomright", this, "bottomright", RightMargin, bottomMargin)
		
		-- buttons positioning for player backpack
		if (id == ContainerWindow.PlayerBackpack) then

			-- lock button enabled for player backpack only
			WindowSetShowing(lock, true)

			-- loot all disabled for player backpack
			WindowSetShowing(lootAll, false)
	
			WindowAddAnchor(search, "topleft", this, "topleft", 50, 35)
			WindowAddAnchor(organize, "topright", search, "topleft", 5, 0)
			WindowAddAnchor(restock, "topright", organize, "topleft", 5, 0)
			WindowAddAnchor(lock, "topright", this, "topright", -10, 35)
			WindowAddAnchor(toggleView, "topleft", lock, "topright", -5, 5)

		else -- buttons positioning for every other container

			-- disable lock button
			WindowSetShowing(lock, false)

			-- enable loot all button
			WindowSetShowing(lootAll, true)
			
			WindowAddAnchor(search, "topleft", this, "topleft", 50, 35)
			WindowAddAnchor(lootAll, "topright", search, "topleft", 5, 0)
			WindowAddAnchor(organize, "topright", lootAll, "topleft", 5, 0)
			WindowAddAnchor(restock, "topright", organize, "topleft", 5, 0)
			WindowAddAnchor(lootSort, "topright", restock, "topleft", 5, 0)
			WindowAddAnchor(toggleView, "topright", this, "topright", -15, 40)
		end
		
		-- is the top-left container image enabled?
		if Interface.Settings.ShowContainerType then

			-- getting the texture data (for the top left container image)
			local texture, xSize, ySize = RequestGumpArt( gumpID )

			-- getting the biggest side of the image
			local higher = math.max(xSize, ySize)

			-- default scale
			local scale = 1
		
			-- if the texture is higher than 45, we scale it down until we make it 45 pixel
			while higher > 45 do
				scale = scale - 0.05
				higher = higher * scale
			end
			
			-- get the current scale value
			scale = 1 - scale

			-- drawing the texture
			DynamicImageSetTexture(contImage, texture, 0,0)

			-- setting the right dimensions for the texture
			DynamicImageSetTextureDimensions(contImage, xSize * scale, ySize * scale)

			-- setting the right dimensions for the window
			WindowSetDimensions(contImage, xSize * scale, ySize * scale)

			-- scaling the texture correctly
			DynamicImageSetTextureScale(contImage, scale)
		end
		
	else -- grid legacy container
		
		-- default texture scale
		local scale = 1.5

		-- getting the container texture scale
		local texture, xSize, ySize = RequestGumpArt( gumpID )

		 -- book shelf has to be bigger
		if gumpID == 77 then
			ySize = ySize * 3

		 -- scale fix (too small by default)
		elseif gumpID == 9 then
			scale = 1.8

		 -- scale fix (too small by default)
		elseif gumpID == 60 then
			scale = 1.75

		 -- scale fix (too small by default)
		elseif gumpID == 61 then
			scale = 1.8
		end
		
		-- enable the main buttons
		WindowSetShowing(organize, true)
		WindowSetShowing(restock, true)	
		WindowSetShowing(search, true)			
		WindowSetShowing(toggleView, true)
			
		-- hide the window title
		WindowSetShowing(contTitle, false )

		-- hide the window border
		WindowSetShowing(contFrame, false )

		-- disable the resize button
		WindowSetShowing(resizeButton, false )
		
		-- hide the top left picture of the container
		WindowSetShowing(contImage .. "BG", false)
		WindowSetShowing(contImage .. "BlackBG", false)
		WindowSetShowing(contImage, false)
	
		-- enable the container texture
		WindowSetShowing(gumpContainerArt, true )
		
		-- resizing the window based on the texture size
		WindowSetDimensions( this, (xSize * scale), (ySize * scale) )
		
		-- clear the container texture anchors
		WindowClearAnchors(gumpContainerArt)

		-- set the texture dimensions
		WindowSetDimensions(gumpContainerArt, xSize * scale, ySize * scale )

		-- drawing the texture
		DynamicImageSetTexture(gumpContainerArt, texture, 0, 0 )

		-- setting the right scale for the texture
		DynamicImageSetTextureScale(gumpContainerArt, scale )

		-- anchoring the texture to the top left of the window
		WindowAddAnchor(gumpContainerArt, "topleft", this, "topleft", 0, 0)
				
		-- applying the anchors for grid, list and buttons based on the gump ID
		ContainersInfo.Anchors[gumpID].grid(this)
		ContainersInfo.Anchors[gumpID].list(this)
		ContainersInfo.Anchors[gumpID].buttons(this)
	end
	
	-- clearing the anchors for the content label
	WindowClearAnchors(contentLabel)

	-- positioning the content label to the bottom of the window
	WindowAddAnchor(contentLabel, "bottom", this, "top", 5, 5)

	-- scaling the content label
	WindowSetScale(contentLabel, WindowGetScale(this))
	
	-- showing the list view and hiding the grid
	if ContainerWindow.ViewModes[id] == "List" then
		WindowSetShowing(list_view_this , true)
		WindowSetShowing(grid_view_this, false)

	else -- showing the grid view and hiding the list
		WindowSetShowing(list_view_this, false)
		WindowSetShowing(grid_view_this, true)
	end

	-- hide free form
	WindowSetShowing(this.."FreeformView", false)
	
	-- loading the scale for this container
	WindowUtils.LoadScale( this )
	
	-- if this is the player backpack and it's the first positioning
	if (id == ContainerWindow.PlayerBackpack and Interface.BackpackFirstPositioning) then
		
		-- we get the location of the game area
		local Rx, Ry= WindowGetOffsetFromParent("ResizeWindow")

		-- we get the size of the game area
		local w, h = WindowGetDimensions("ResizeWindow")
		
		-- we get the size of this container
		local wMe, hMe = WindowGetDimensions(this)
		
		-- clear the container position
		WindowClearAnchors(this)

		-- we position the container just on the bottom left of the game area
		WindowAddAnchor(this, "topleft", "Root", "topleft", (Rx + w) - wMe, (Ry + h) - 80)
	end
	
	-- flag this container as shown
	ContainerWindow.OpenContainers[id].shown = true
	
	-- first time uses update 1 second after the container is shown
	Interface.AddTodoList({name = "container first uses update", func = function() ContainerWindow.UpdateUses(id) end, time = Interface.TimeSinceLogin + 1})

	 -- skip the update?
	if not noUpdate then

		-- update the container contents
		ContainerWindow.UpdateContents(id)
	end
	
	-- showing this container
	WindowSetShowing(this, true)
end

function ContainerWindow.CreateListViewSlots(dialog)
	
	-- does the window really exist?
	if not DoesWindowExist(dialog) then
		return
	end
	
	-- get the container ID
	local id = WindowGetId(dialog)
	
	-- do we have a valid id?
	if not IsValidID(id) then
		return
	end
		
	-- getting the number of items
	local numItems = GetContainerItemsNumber(id)
	
	-- the number of items is not the same of the ne number of rows?
	if ContainerWindow.OpenContainers[id].numCreatedRows ~= numItems then

		-- destroy all rows
		ContainerWindow.DestroyListViewRows(dialog)
	
	-- the slots number is already correct, we don't need to do anything at all.
	elseif ContainerWindow.OpenContainers[id].numCreatedRows == numItems then
		return
	end
	
	-- list view window
	local list_view_this = dialog .. "ListView"

	-- refresh the list view anchors
	WindowForceProcessAnchors(dialog)

	-- get the dimensions of the list view
	local GRID_WIDTH, GRID_HEIGHT = WindowGetDimensions(list_view_this)

	-- get the width of the scrollbar
	local scrollbarWidth = WindowGetDimensions(list_view_this.."Scrollbar")
	
	-- subtract the scrollbar width from the list view width
	GRID_WIDTH = GRID_WIDTH - scrollbarWidth
	
	-- parent list view window
	local parent = dialog.."ListViewScrollChild"

	-- are there some items?
	if numItems > 0 then

		-- we create the missing lines
		for i = 1, numItems do

			-- slot window name
			local slotName = dialog.."Item"..i
			
			-- if the window exist we destroy the slot
			if DoesWindowExist(slotName) then
				DestroyWindow(slotName)
			end
			
			-- create the slot
			CreateWindowFromTemplate(slotName, "ContainerItemTemplate", parent)

			-- set the slot ID
			WindowSetId(slotName, i)

			-- set the icon ID
			WindowSetId(slotName.."Icon", i)	
			
			-- set the slot scale
			WindowSetScale(slotName, WindowGetScale(dialog))

			-- reset the slot position
	        WindowClearAnchors(slotName)

			-- is this the first element?
			if i == 1 then
				
				-- grid legacy active?
				if (not Interface.Settings.GridLegacy) then
					
					-- without grid legacy we move the first slot a bit lower
					WindowAddAnchor(slotName, "topleft", parent, "topleft", 3, 0)
				
				else -- with grid legacy we can keep the first slot on top
					WindowAddAnchor(slotName, "topleft", parent, "topleft", 0, 0)
				end

				-- we anchor the slot to the top right
				WindowAddAnchor(slotName, "topright", parent, "topright", 0, 0)

			else -- anchoring the slot to bottom left and bottom right of the previous slot
				WindowAddAnchor(slotName, "bottomleft", dialog.."Item"..i-1, "topleft", 0, 1)
				WindowAddAnchor(slotName, "bottomright", dialog.."Item"..i-1, "topright", 0, 0)
			end
			
			-- update the amount of slot created
			ContainerWindow.OpenContainers[id].numCreatedRows = i
		end
	end

	-- update the parent dimensions
	WindowSetDimensions(parent, GRID_WIDTH, 0)
	
	-- update the scrollable area
	ScrollWindowUpdateScrollRect(list_view_this) 
end

function ContainerWindow.DestroyListViewRows(dialog)

	-- does the window exist?
	if not DoesWindowExist(dialog) then
		return
	end

	-- get the window ID
	local id = WindowGetId(dialog)
	
	-- does the ID is valid?
	if not IsValidID(id) then
		return
	end
	
	-- get the current number of rows
	local numRows = ContainerWindow.OpenContainers[id].numCreatedRows
	
	-- does the number of rows is greater than 0?
	if numRows > 0 then
		
		-- running all the ids
		for i = 1, numRows do
			
			-- slot window name
			local slotName = dialog.."Item"..i

			-- if the window exist, we destroy it
			if DoesWindowExist(slotName) then
				DestroyWindow(slotName)
			end
		end
	end
	
	-- update the current number of rows to 0
	ContainerWindow.OpenContainers[id].numCreatedRows = 0
end

function ContainerWindow.UpdateListView(id)

	-- container window name
	local dialog = "ContainerWindow_" .. id
	
	-- does the window really exist?
	if not DoesWindowExist(dialog) then
		return
	end

	-- get the container ID
	local id = WindowGetId(dialog)
	
	-- do we have a valid id?
	if not IsValidID(id) then
		return
	end
	
	-- do we have a valid number of rows? (>0)
	if not IsValidID(ContainerWindow.OpenContainers[id].numCreatedRows) then

		-- we create the rows
		ContainerWindow.CreateListViewSlots(dialog)
	end
	
	-- is this NOT a grid legacy in list view mode?
	if not Interface.Settings.GridLegacy and ContainerWindow.ViewModes[id] == "List" then

		-- we get the windows width
		local currw = WindowGetDimensions(dialog)
		
		-- get the min width
		local minWidth = ContainerWindow.List_MinWidth

		-- get the mis height
		local minHeight = minWidth + (minWidth * 0.15)

		-- if the current width is less than the min width, we resize the window
		if currw < minWidth then
			WindowSetDimensions(dialog, minWidth, minHeight)
		end
	end
	
	-- list view window name
	local list_view_this = dialog .. "ListView"

	-- force the update of anchors
	WindowForceProcessAnchors(dialog)

	-- get the list view dimensions
	local GRID_WIDTH, GRID_HEIGHT = WindowGetDimensions(list_view_this)
	
	-- get the scrollbar width
	local scrollbarWidth = WindowGetDimensions(list_view_this .. "Scrollbar")
	
	-- remove the width of the scrollbar from the total width
	GRID_WIDTH = GRID_WIDTH - scrollbarWidth
	
	-- list view scrollable area
	local scrollViewChildName = dialog.."ListViewScrollChild"
	
	-- do we have rows?
	if ContainerWindow.OpenContainers[id].numCreatedRows > 0 then

		-- we scan all the rows
		for i = 1, ContainerWindow.OpenContainers[id].numCreatedRows do
			
			-- row window name
			local slotName = dialog.."Item"..i

			-- we scale the row properly
			WindowSetScale(slotName, WindowGetScale(dialog))

			-- hide the slot
			WindowSetShowing(slotName, false)
		end
	end
	
	-- is grid legacy active?
	if not Interface.Settings.GridLegacy then

		-- inialize the distance variable
		local dist = 0

		-- getting the top left anchor
		local point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor(list_view_this, 1)

		-- adding to the distance twice x offset of the anchor (1 time per side)
		dist = dist + (xOffs * 2)

		-- calculating the max width excluding the scrollbar width and the anchors (dist)
		local maxWidth = ContainerWindow.List_MinWidth - scrollbarWidth - dist

		-- is the width less than the max? then we set it at the max
		if GRID_WIDTH < maxWidth then
			GRID_WIDTH = maxWidth
		end

		-- we resize the window width
		WindowSetDimensions(scrollViewChildName, GRID_WIDTH, 0)
	end
		
	-- load the scroll position for list view
	local listOffset = Interface.LoadSetting("ScrollList" .. id, ScrollWindowGetOffset(list_view_this))
	
	-- if the save scroll position is disabled we nullify the loaded value
	if not Interface.Settings.SaveScrollPos then
		listOffset = nil
	end

	-- do we have a scroll position?
	if listOffset then

		-- set that the scrollbar is going to be used automatically
		ContainerWindow.AutoScroll = true

		-- we move the scroll position to the saved one
		ScrollWindowSetOffset(list_view_this, listOffset)
	end
end

function ContainerWindow.CreateGridViewSockets(dialog)

	-- does the window really exist?
	if not DoesWindowExist(dialog) then
		return
	end
	
	-- get the container ID
	local id = WindowGetId(dialog)
	
	-- do we have a valid id?
	if not IsValidID(id) then
		return
	end
	
	-- is loot sort enabled?
	local isLoot = ButtonGetPressedFlag( dialog .. "LootSort" )
	
	-- get the max amount of slots for the container
	local max = ContainerWindow.OpenContainers[id].maxSlots
	
	-- it shouldn't be necessary, but it's safer to check that the slot number do not exceed the slots cap.
	if max > ContainerWindow.MaxSlotsPerGrid then
		max = ContainerWindow.MaxSlotsPerGrid
	end
	
	-- the current slots number is wrong, we destroy them all
	if ContainerWindow.OpenContainers[id].numCreatedSlots ~= max then
		ContainerWindow.DestroyGridViewSockets(dialog)
	end
	
	-- parent window for the grid view
	local parent = dialog.."GridViewScrollChild"
		
	-- getting the number of items
	local numItems = GetContainerItemsNumber(id)
	
	-- do we have more items than the maximum for the container?
	if numItems > max then

		-- set the max to the number of items
		max = numItems
	end

	-- creating the slots...
	for i = 1, max do
		
		-- slot window name
		local socketName = dialog.."GridViewSocket"..i 

		-- initialize the variable for the template
		local socketTemplate
	
		-- is the extra bright containers active?
		if (not Interface.Settings.ExtraBrightContainers) then
			
			-- normal container slot
			socketTemplate = "GridViewSocketTemplate"

		else -- extra bright container slot
			socketTemplate = "ColoredGridViewSocketTemplate"
		end
				
		-- we destroy the slot if already exist (if does exist something wrong is happening...)
		if DoesWindowExist(socketName) then
			DestroyWindow(socketName)
		end
		
		-- we create the slot window
		CreateWindowFromTemplate(socketName, socketTemplate, parent)

		-- is the container grid disabled?
		if (not Interface.Settings.EnableContainerGrid) then
			
			-- hide the slot texture to make the grid disappear
			ButtonSetTexture(socketName, Button.ButtonState.NORMAL, "", 0, 0)
			ButtonSetTexture(socketName, Button.ButtonState.HIGHLIGHTED, "", 0, 0)
			ButtonSetTexture(socketName, Button.ButtonState.DISABLED, "", 0, 0)
			ButtonSetTexture(socketName, Button.ButtonState.PRESSED, "", 0, 0)
			ButtonSetTexture(socketName, Button.ButtonState.PRESSED_HIGHLIGHTED, "", 0, 0)
		end
				
		-- is there a background for the slot? if yes, we hide it
		if DoesWindowExist(socketName .. "BG") then
			WindowSetShowing(socketName .. "BG", false)
		end
		
		-- set the slot id
		WindowSetId(socketName, i)

		-- hiding the slot
		WindowSetShowing(socketName, false)

		-- show the icon
		WindowSetShowing(socketName .. "Icon" , true)	
		
		-- we update the number of created slots
		ContainerWindow.OpenContainers[id].numCreatedSlots = i
	end
end

function ContainerWindow.DestroyGridViewSockets(dialog)
	
	-- does the window really exist?
	if not DoesWindowExist(dialog) then
		return
	end
	
	-- get the container ID
	local id = WindowGetId(dialog)
	
	-- do we have a valid id?
	if not IsValidID(id) then
		return
	end
	
	-- getting the number of existing slots
	local max = ContainerWindow.OpenContainers[id].numCreatedSlots

	-- scanning all the slots
	for i = 1, max do
		
		-- slot window name
		local socketName = dialog.."GridViewSocket"..i 

		-- if the slot exist, we destroy it
		if DoesWindowExist(socketName) then
			DestroyWindow(socketName)
		end
	end
	
	-- update the number of slots to 0
	ContainerWindow.OpenContainers[id].numCreatedSlots = 0
end

function ContainerWindow.UpdateGridViewSockets(id)

	-- do we have a valid id?
	if not IsValidID(id) then
		return
	end

	-- container window name
	local windowName = "ContainerWindow_"..id
	
	-- does the window really exist?
	if not DoesWindowExist(windowName) then
		return
	end

	-- grid window name		
	local grid_view_this = windowName.."GridView"

	-- grid window scrollable area name
	local scrollViewChildName = grid_view_this.."ScrollChild"
	
	-- force update the anchors
	WindowForceProcessAnchors(windowName)

	-- get the grid window dimensions
	local GRID_WIDTH, GRID_HEIGHT = WindowGetDimensions(grid_view_this)

	-- get the scaled width of the grid window
	GRID_WIDTH = GRID_WIDTH * WindowGetScale(windowName)
	
	-- do we have a valid amount of slots created? (>0)
	if not IsValidID(ContainerWindow.OpenContainers[id].numCreatedSlots) then
		ContainerWindow.CreateGridViewSockets(windowName)
	end
	
	-- get the scrollbar width
	local scrollbarWidth = WindowGetDimensions(grid_view_this.."Scrollbar")

	-- subtracting the scrollbar width from the grid width
	GRID_WIDTH = GRID_WIDTH - scrollbarWidth
	
	-- getting the size of a slot
	local slotSize = WindowGetDimensions(windowName.."GridViewSocket1")

	-- we save the unscaled slot size
	local unscaledSlotSize = slotSize
	
	-- getting the slot scale
	local slotScale = WindowGetScale(windowName)

	-- calculating the slot scale
	slotScale = (slotScale - (slotScale * ContainerWindow.GRID_SLOT_SCALE))

	-- applying the slot scale
	slotSize = slotSize * slotScale
	
	-- calculating the max number of columns
	local colums = math.floor(GRID_WIDTH / slotSize)

	-- calculating the space remaining outside the slots we have in a row
	local space = (GRID_WIDTH - (colums * slotSize))

	-- variables for determining the final height and width of the grid scroll area
	local h = 0
	local w = 0
	local rows = 0

	-- color variable used to alternate the backpack grid
	local color = false

	-- parsing all the slots
	for i = 1, ContainerWindow.OpenContainers[id].numCreatedSlots do

		-- slot window name
		local socketName = windowName.."GridViewSocket"..i 
		
		-- does the slot exist?
		if not DoesWindowExist(socketName) then
			continue		
		end	

		-- clearing the slot position
		WindowClearAnchors(socketName)	
		
		-- scaling the slot
		WindowSetScale(socketName, slotScale)

		-- is this the first slot?
		if i == 1 then

			-- is this grid legacy?
			if (not Interface.Settings.GridLegacy) then
				
				-- for non-grid legacy we add a small space
				WindowAddAnchor(socketName, "topleft", scrollViewChildName, "topleft", 3, 0)

			else -- for grid legacy we split the space left between the 2 sides
				WindowAddAnchor(socketName, "topleft", scrollViewChildName, "topleft", space / 2, 0)
			end

			-- getting the top left anchor
			local point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor(socketName, 1)

			-- sum the unscaled slot height to the y offset of the anchor
			h = h + unscaledSlotSize + yOffs

			-- sum the unscaled slot width to the x offset of the anchor
			w = w + unscaledSlotSize + xOffs

			-- increase the number of rows
			rows = rows + 1

		-- is this the first of a new line?
		elseif (i % colums) == 1 then
			
			-- anchoring the slot at the bottom of the first of the previous line
			WindowAddAnchor(socketName, "bottomleft", windowName.."GridViewSocket"..i-colums, "topleft", 0, 1)

			-- getting the top left anchor
			local point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor(socketName, 1)

			-- sum the unscaled slot height to the y offset of the anchor
			h = h + unscaledSlotSize + yOffs

			-- increase the number of rows
			rows = rows + 1

			-- new lines always start with the same color (if the numbers of columns is even), otherwise we have colomuns all of the same color
			if colums % 2 ~= 0 then
				color = not color
			end

		else -- normal slot not at the beginning of a line

			-- anchoring the slot to the previous one on the left
			WindowAddAnchor(socketName, "topright", windowName.."GridViewSocket"..i-1, "topleft", 1, 0)

			-- getting the top left anchor
			local point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor(socketName, 1)

			-- are we still in the first row? (we don't need to increase the width once we've done it for the first row)
			if i <= colums then

				-- sum the unscaled slot width to the x offset of the anchor
				w = w + unscaledSlotSize + xOffs
			end

			-- invert the color variable (for the next slot)
			color = not color
		end

		-- showing the slot
		WindowSetShowing(socketName, true)	

		-- show the icon
		WindowSetShowing(socketName .. "Icon" , true)

		-- do we have the container grid?
		if Interface.Settings.EnableContainerGrid then

			-- get the item ID from the index
			local itemID = ContainerWindow.GetItemIDForIndex(id, i)

			-- do we have a different color in the sorted array? we use that color instead
			if ContainerWindow.ContainerItems[id] and ContainerWindow.ContainerItems[id][itemID] and ContainerWindow.ContainerItems[id][itemID].color ~= nil and not colorCompare(ContainerWindow.ContainerItems[id][itemID].color, Interface.Settings.Props_TITLE_COLOR) then
		
				-- get the item color
				itemColor = ContainerWindow.ContainerItems[id][itemID].color
			
				-- coloring the slot
				WindowSetTintColor(socketName, itemColor.r, itemColor.g, itemColor.b)

			else -- default color
		
				-- coloring the slot
				WindowSetTintColor(socketName, Interface.Settings.BaseGridColor.r, Interface.Settings.BaseGridColor.g, Interface.Settings.BaseGridColor.b)

				-- if the alternate colors are enabled, and the color variable is true (1 time is true and 1 time not), we use the alternate color
				if (color and Interface.Settings.AlternateGrid) then
					WindowSetTintColor(socketName, Interface.Settings.AlternateBackpack.r, Interface.Settings.AlternateBackpack.g, Interface.Settings.AlternateBackpack.b)
				end
			end
		end
	end

	-- do we have the open containers record? (if not something have gone really bad somewhere)
	if ContainerWindow.OpenContainers[id] then

		-- update the number of rows and columns in the record
		ContainerWindow.OpenContainers[id].slotsWide = colums
		ContainerWindow.OpenContainers[id].slotsHigh = rows
	end
	
	-- update the grid view scrollable area dimensions
	WindowSetDimensions(scrollViewChildName, w, h)	
	
	-- is the grid legacy enabled?
	if (not Interface.Settings.GridLegacy) then

		-- get the container windo dimensions
		local winW, winH = WindowGetDimensions(windowName)

		-- update the width including the empty space on each side and the scaled scrollbar
		winW = (winW - space) + (scrollbarWidth * WindowGetScale(windowName)) - 3

		-- is the width less than the min possible width? then we reset to the minimum
		if winW < ContainerWindow.Grid_MinWidth  then
			winW = ContainerWindow.Grid_MinWidth
		end

		-- update the container window dimensions
		WindowSetDimensions(windowName, winW, winH)
	end
	
	-- update the scrollable area
	ScrollWindowUpdateScrollRect(grid_view_this) 
	
	-- load the scroll position for grid view
	local gridOffset = Interface.LoadSetting("ScrollGrid" .. id, ScrollWindowGetOffset(grid_view_this))

	-- if the save scroll position is disabled we nullify the loaded value
	if not Interface.Settings.SaveScrollPos then
		gridOffset = nil
	end
	
	-- do we have a scroll position?
	if gridOffset then

		-- set that the scrollbar is going to be used automatically
		ContainerWindow.AutoScroll = true

		-- we move the scroll position to the saved one
		ScrollWindowSetOffset(grid_view_this, gridOffset)
	end
end

function ContainerWindow.BankMaskButtonTooltip()
	
	-- current window name
	local window = SystemData.ActiveWindow.name

	-- does the slot really exist?
	if not DoesWindowExist(window) then
		return
	end

	-- initialize tooltip text
	local text = L""

	-- deposit gold for transfer button
	if string.find(window, "DepositGoldTransfer", 1, true) then

		text = GetStringFromTid(1156070) -- Transfers gold from the bank to the character transfer account; capped at 1 billion gold. Any currency that a players wishes to transfer to another shard must be placed in character transfer account. Upon transferring the currency will be added to player's account on the shard.

	-- deposit platinum for transfer button
	elseif string.find(window, "DepositPlatinumTransfer", 1, true) then

		text = GetStringFromTid(1156071) -- Transfers platinum from the bank to the character transfer account; capped at 2 billion platinum. Any currency that a players wishes to transfer to another shard must be placed in character transfer account. Upon transferring the currency will be added to player's account on the shard. 

	-- withdraw gold from transfer button
	elseif string.find(window, "WithdrawGoldTransfer", 1, true) then

		text = GetStringFromTid(1156072) -- Transfers gold from the character transfer account to the bank; capped at 1 billion gold.

	-- withdraw platinum from transfer button
	elseif string.find(window, "WithdrawPlatinumTransfer", 1, true) then

		text = GetStringFromTid(1156073) -- Transfers platinum from the character transfer account to the bank; capped at 2 billion platinum.

	-- deposit gold to secure account button
	elseif string.find(window, "DepositGoldSecure", 1, true) then

		text = GetStringFromTid(1156074) -- Transfers gold from the bank to the player's secure account; capped at 100,000,000 gold. Only funds added to the secure account can be added to the wall safe account.

	-- withdraw gold from secure account button
	elseif string.find(window, "WithdrawGoldSecure", 1, true) then

		text = GetStringFromTid(1156075) -- Transfers gold from the secure account to the bank; capped at 100,000,000 gold.

	-- help button
	elseif string.find(window, "HelpButton", 1, true) then
		text = GetStringFromTid(1061037) -- Help
	end

	-- container search button tooltip
	Tooltips.CreateTextOnlyTooltip(window, text)
end

function ContainerWindow.BankMaskButtonClicked()

	-- current window name
	local window = SystemData.ActiveWindow.name

	-- does the slot really exist?
	if not DoesWindowExist(window) then
		return
	end

	-- gump butto index
	local index = 0

	-- deposit gold for transfer button
	if string.find(window, "DepositGoldTransfer", 1, true) then
		index = 1

	-- deposit platinum for transfer button
	elseif string.find(window, "DepositPlatinumTransfer", 1, true) then
		index = 2		

	-- withdraw gold from transfer button
	elseif string.find(window, "WithdrawGoldTransfer", 1, true) then
		index = 3

	-- withdraw platinum from transfer button
	elseif string.find(window, "WithdrawPlatinumTransfer", 1, true) then
		index = 4
		
	-- deposit gold to secure account button
	elseif string.find(window, "DepositGoldSecure", 1, true) then
		index = 5

	-- withdraw gold from secure account button
	elseif string.find(window, "WithdrawGoldSecure", 1, true) then
		index = 6

	-- help button
	elseif string.find(window, "HelpButton", 1, true) then

		-- do we have the EJ bank gump?
		if GumpData.Gumps[GenericGump.EJ_BANK_GUMPID] then
			index = 9

		else -- normal bank
			index = 8
		end
	end

	-- do we have a valid index?
	if IsValidID(index) then
		GumpsParsing.PressButton(GenericGump.BANK_ACTIONS_GUMPID, index)
	end
end

function ContainerWindow.SearchItem()
	
	-- reset the container search
	ContainerSearch.Reset()

	-- acquire the current container ID
	ContainerSearch.Container = WindowGetId(WindowUtils.GetActiveDialog())

	-- toggle the container search window
	ContainerSearch.Toggle()	
end

function ContainerWindow.SearchGumpContainer()

	-- gump window name
	local dialog = WindowUtils.GetActiveDialog()

	-- get the gump ID
	local gumpID = GenericGump.GumpsList[dialog]

	-- reset the container search
	ContainerSearch.Reset()

	-- set the gump to search
	ContainerSearch.Gump = gumpID

	-- toggle the container search window
	ContainerSearch.Toggle()
end

function ContainerWindow.SearchAllTooltip()
	
	-- container search button tooltip
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(1154791)) -- -- Item Search
end

function ContainerWindow.LootSortBtn()

	-- container window name
	local dialog = WindowUtils.GetActiveDialog()

	-- does the window really exist?
	if not DoesWindowExist(dialog) then
		return
	end

	-- get the container ID
	local windowID = WindowGetId(dialog)

	-- do we have a valid id?
	if not IsValidID(windowID) then
		return
	end

	-- is this container open and not a player vendor?
	if ContainerWindow.OpenContainers[windowID] and not ContainerWindow.OpenContainers[windowID].isPlayerVendor then

		-- is this a corpse?
		if ContainerWindow.OpenContainers[windowID].isCorpse then
			
			-- get the curent button state (this is after the player pressed it)
			if ButtonGetPressedFlag( SystemData.ActiveWindow.name) then

				-- activated
				Interface.SaveSetting("CropseLtSort", true)

			else -- deactivated
				Interface.SaveSetting("CropseLtSort", false)
			end

		else -- any other container

			-- get the curent button state (this is after the player pressed it)
			if ButtonGetPressedFlag( SystemData.ActiveWindow.name) then
				
				-- activated
				Interface.SaveSetting(dialog .. "LootSort", true)

			else -- deactivated
				Interface.DeleteSetting(dialog .. "LootSort")
			end
		end
	end

	-- force the container update
	ContainerWindow.ForceContainerUpdate(windowID)
end

function ContainerWindow.LootSortTooltip()

	-- button window name
	local button = SystemData.ActiveWindow.name
	
	-- does the window really exist?
	if not DoesWindowExist(button) then
		return
	end

	-- is the loot sort enabled?
	if not ButtonGetPressedFlag(button) then
		Tooltips.CreateTextOnlyTooltip(button, GetStringFromTid(208))
	else															  
		Tooltips.CreateTextOnlyTooltip(button, GetStringFromTid(209))
	end
end

function ContainerWindow.LockTooltip()
	
	-- button window name
	local button = SystemData.ActiveWindow.name
	
	-- does the window really exist?
	if not DoesWindowExist(button) then
		return
	end

	-- is the container locked?
	if (ContainerWindow.Locked) then
		Tooltips.CreateTextOnlyTooltip(button, GetStringFromTid(1154784)) -- Unlock backpack
	else
		Tooltips.CreateTextOnlyTooltip(button, GetStringFromTid(1154785)) -- Lock Backpack
	end
end

function ContainerWindow.LootAllBtn()

	-- container window name
	local dialog = WindowUtils.GetActiveDialog()

	-- does the window really exist?
	if not DoesWindowExist(dialog) then
		return
	end

	-- get the container ID
	local id = WindowGetId(dialog)
	
	-- do we have a valid id?
	if not IsValidID(id) then
		return
	end

	-- store the old parent container for the organizer
	local oldOrganizeParent = ContainerWindow.OrganizeParent

	-- update the organizer parent container with the current container ID
	ContainerWindow.OrganizeParent = id

	-- is the old parent a valid container and the current one different from the old one?
	if (IsValidID(oldOrganizeParent) and oldOrganizeParent ~= ContainerWindow.OrganizeParent) then
		
		-- we nullify the old flag
		ContainerWindow.LootAll[oldOrganizeParent] = nil
	end

	-- is the loot all flag for the current parent container disabled?
	if ContainerWindow.LootAll[ContainerWindow.OrganizeParent] == nil then

		-- activate the flag to loot all
		ContainerWindow.LootAll[ContainerWindow.OrganizeParent] = ContainerWindow.OrganizeParent

	else -- if the flag is active, we nullify it and disable the loot all
		ContainerWindow.LootAll[ContainerWindow.OrganizeParent] = nil
	end	
end

function ContainerWindow.LootAllTooltip()

	-- container window name
	local dialog = WindowUtils.GetActiveDialog()
	
	-- does the window really exist?
	if not DoesWindowExist(dialog) then
		return
	end

	-- get the container ID
	local id = WindowGetId(dialog)
	
	-- do we have a valid id?
	if not IsValidID(id) then
		return
	end

	-- is the loot all active?
	if (ContainerWindow.LootAll[id] == nil) then
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(1154783)) -- Loot all of the contents of this container.

	else
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(1154788)) -- Stop Looting.
	end
end

function ContainerWindow.LootAllCycle(timePassed)

	-- do we have a parent container to loot, and the loot all is active for that container and we can pick up an item?
	if ContainerWindow.OrganizeParent and ContainerWindow.LootAll[ContainerWindow.OrganizeParent] and ContainerWindow.CanPickUp then
		
		-- getting the container data
		local containerData = Interface.GetContainersData(ContainerWindow.OrganizeParent, true)

		-- do we have the container data?
		if not Interface.VerifyContainer(ContainerWindow.OrganizeParent, containerData) then
			return
		end

		-- getting the number of items from the container too loot
		local numItems = containerData.numItems

		-- is there something to loot?
		if numItems > 0 then
			
			-- acquire the bag in which to drop the loot
			local OrganizeBag = Interface.LootBoxID

			-- no bag specified or the bag is unavailable?
			if not IsValidID(OrganizeBag) or not DoesPlayerHaveItem(OrganizeBag) then

				-- we drop all inside the loot bag or the player backpack if we have no loot bag
				OrganizeBag = inlineIf(IsValidID(Interface.LootBoxID) and DoesPlayerHaveItem(Interface.LootBoxID), Interface.LootBoxID, ContainerWindow.PlayerBackpack)
			end
			
			-- getting the first lootable item ID
			local itemId = ContainerWindow.GetFirstLootableItem(containerData)

			-- nothing to loot
			if not itemId then

				-- we disable the loot all
				ContainerWindow.LootAll[ContainerWindow.OrganizeParent] = nil

				return
			end

			-- getting the item data
			local itemData = Interface.GetObjectInfoData(itemId)

			-- do we have the item data?
			if (itemData) then

				-- if the item is gold we drop it inside the main level of the backpack no matter what
				if itemData.objectType == 3821 and OrganizeBag ~= ContainerWindow.PlayerBackpack then
					MoveItemToContainer(itemId, itemData.quantity, ContainerWindow.PlayerBackpack)

				else -- any other item we move in the chosen container
					MoveItemToContainer(itemId, itemData.quantity, OrganizeBag)
				end
			end

		else -- nothing to loot, we disable the loot all
			ContainerWindow.LootAll[ContainerWindow.OrganizeParent] = nil
		end
	end
end

function ContainerWindow.GetFirstLootableItem(containerData)

	-- do we have the container data?
	if not containerData then
		return
	end

	-- getting the number of items from the container too loot
	local numItems = containerData.numItems

	-- do we have any item in the container?
	if numItems <= 0 then
		return
	end
	
	-- scan the container items
	for i = 1, numItems do

		-- getting the item ID
		local itemId = containerData.ContainedItems[i].objectId

		-- get the item weight
		local weight = GetItemWeight(itemId)

		-- do we have a weight and is higher that the cap the player has set in the settings?
		if weight and weight > Interface.Settings.AutoLootMaxWeight then
			continue
		end

		return itemId
	end
end

function ContainerWindow.OrganizerContext()

	-- is the organizer active?
	if not ContainerWindow.Organize then

		-- reset the context menu
		ContextMenu.CleanUp()

		-- scan all the organizers
		for i = 1, Organizer.Organizers do

			-- get the organizer name
			local name = ReplaceTokens(GetStringFromTid(1155441), {towstring( i ) } ) -- Use Organizer ~1_NAME~

			-- get the organizer description
			if (Organizer.Organizers_Desc[i] ~= L"") then
				name = Organizer.Organizers_Desc[i]
			end

			-- creating the context menu button and highlight the active organizer
			ContextMenu.CreateLuaContextMenuItem({str = name, returnCode = i, pressed = Organizer.ActiveOrganizer == i})
		end

		-- show the context menu
		ContextMenu.ActivateLuaContextMenu(ContainerWindow.ContextMenuCallback)
	end
end

function ContainerWindow.ContextMenuCallback( returnCode, param )

	-- activate the selected organizer
	Organizer.ActiveOrganizer = returnCode

	-- save the active organizer ID
	Interface.SaveSetting( "OrganizerActiveOrganizer" , Organizer.ActiveOrganizer )
end

function ContainerWindow.Organizes()
	
	-- container window name
	local dialog = WindowUtils.GetActiveDialog()

	-- does the window really exist?
	if not DoesWindowExist(dialog) then
		return
	end

	-- get the container ID
	local id = WindowGetId(dialog)
	
	-- do we have a valid id?
	if not IsValidID(id) then
		return
	end

	-- reset the organizer bag
	ContainerWindow.OrganizeBag = nil

	-- reset the ID of the container to organize
	ContainerWindow.OrganizeParent = nil

	-- is the organizer active?
	if ContainerWindow.Organize then

		-- turn off the organizer
		ContainerWindow.Organize = false

	else -- organizer inactive

		-- set this container as the container to organize
		ContainerWindow.OrganizeParent = id

		-- do we have a default container for the organizer?
		if (Organizer.Organizers_Cont[Organizer.ActiveOrganizer] == 0) then

			-- no container, we ask the player to target the container to drop the stuff
			RequestTargetInfo(ContainerWindow.OrganizeTargetInfoReceived)
			SendOverheadText(GetStringFromTid(1154773), OverheadText.CustomMessageHues.LIGHTBLUE) -- Target the hotbag.

		else -- we have a container

			-- set the bag to drop the stuff into
			ContainerWindow.OrganizeBag = Organizer.Organizers_Cont[Organizer.ActiveOrganizer]

			-- start the organizer
			ContainerWindow.Organize = true

			return
		end
	end
	
	
end

function ContainerWindow.OrganizeTargetInfoReceived(objectId)
	
	-- we get the item the player targeted
	ContainerWindow.OrganizeBag = objectId

	-- if it's a valid id, we start the organizer agent
	if IsValidID(ContainerWindow.OrganizeBag) then
		ContainerWindow.Organize = true
	end
end

function ContainerWindow.OrganizeTooltip()

	-- is the organizer active?
	if (not ContainerWindow.Organize) then

		-- get the organizer name
		local name = L" Organizer " .. Organizer.ActiveOrganizer

		-- get the organizer description
		if (Organizer.Organizers_Desc[Organizer.ActiveOrganizer] ~= L"") then
			name = L" " .. Organizer.Organizers_Desc[Organizer.ActiveOrganizer]
		end

		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  ReplaceTokens(GetStringFromTid(1154789), {name})) -- Organizer.Use this to organize the contents of this container.Right Click to select the organizer.Current:~1_NAME~

	else -- if the organizer is active we show the tooltip to stop the organizer
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(1154786)) -- Stop Organizer.
	end
end

function ContainerWindow.OrganizerCycle(timePassed)
	
	-- is the organizer active and can we pick up an item?
	if ContainerWindow.Organize and ContainerWindow.CanPickUp then
		
		-- getting the container data
		local containerData = Interface.GetContainersData(ContainerWindow.OrganizeParent, true)

		-- do we have the container data?
		if not Interface.VerifyContainer(ContainerWindow.OrganizeParent, containerData) then
			return
		end

		-- getting the number of items from the container too loot
		local numItems = containerData.numItems

		-- is there something in the container?
		if numItems > 0 then
			
			-- acquire the bag in which to drop the loot
			local OrganizeBag = ContainerWindow.OrganizeBag

			-- no bag specified or the bag is unavailable? we drop all inside the player backpack
			if not IsValidID(OrganizeBag) then
				OrganizeBag = ContainerWindow.PlayerBackpack
			end

			-- scanning the container objects
			for i = 1, numItems  do

				-- getting the first item ID
				local itemId = containerData.ContainedItems[i].objectId

				-- getting the item data
				local itemData = Interface.GetObjectInfoData(itemId)

				-- do we have the item data?
				if (itemData) then

					-- do we have items in this organizer?
					if (Organizer.Organizer[Organizer.ActiveOrganizer]) then

						-- parsing the organizer items
						for _, itemL in pairs(Organizer.Organizer[Organizer.ActiveOrganizer]) do

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
		end

		-- warn the player the organize is completed
		ChatPrint(GetStringFromTid(595), SystemData.ChatLogFilters.SYSTEM)

		-- if we end up here there is nothing else to move, so we can turn off the organizer
		ContainerWindow.Organize = false

		-- do we have to close the container when finished?
		if Organizer.Organizers_CloseCont[Organizer.ActiveOrganizer] then

			-- if the container is open we close it
			if DoesWindowExist( "ContainerWindow_" .. ContainerWindow.OrganizeParent) then
				DestroyWindow("ContainerWindow_" .. ContainerWindow.OrganizeParent)
			end
		end
	end
end

function ContainerWindow.RestockContext()
	
	-- is the restock off?
	if not ContainerWindow.Restock then
		
		-- reset the context menu
		ContextMenu.CleanUp()

		-- parse all the restocks
		for i = 1, Organizer.Restocks do

			-- get the restock name
			local name = ReplaceTokens(GetStringFromTid(1155443), {towstring( i ) } ) -- Use Restock ~1_NAME~

			-- ge the restock description
			if (Organizer.Restocks_Desc[i] ~= L"") then
				name = Organizer.Restocks_Desc[i]
			end

			-- adding the current restock to the context menu and hihglight if is the active one
			ContextMenu.CreateLuaContextMenuItem({str = name, returnCode = i, pressed = Organizer.ActiveRestock == i})
		end

		-- show the context menu
		ContextMenu.ActivateLuaContextMenu(ContainerWindow.RestockContextMenuCallback)
	end
end

function ContainerWindow.RestockContextMenuCallback( returnCode, param )
	
	-- get the selected restock ID
	Organizer.ActiveRestock = returnCode

	-- save the current restock ID as ACTIVE
	Interface.SaveSetting( "OrganizerActiveRestock" , Organizer.ActiveRestock )
end

function ContainerWindow.RestockTooltip()

	-- is the restock off?
	if (not ContainerWindow.Restock) then
		
		-- showing the restock name and description
		local name = ReplaceTokens(GetStringFromTid(1155444), {towstring( Organizer.ActiveRestock ) } )  -- Restock ~1_NAME~
		if (Organizer.Restocks_Desc[Organizer.ActiveRestock] ~= L"") then
			name = Organizer.Restocks_Desc[Organizer.ActiveRestock]
		end

		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(1155427) .. L"\n".. ReplaceTokens(GetStringFromTid(1155265), { name })) -- Restock.Use this to restock from this container.Right Click to select the restock.

	else -- if the restock is active we show the tooltip to stop the restock
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(1154787)) -- Stop Restock.
	end
end

function ContainerWindow.InitializeRestock()

	-- is the targeted item valid?
	if IsValidID(ContainerWindow.OrganizeBag) then
		
		-- initialize the array with the current amount of items we need
			ContainerWindow.CurrentAmountArray = {}

		-- scan the required items for the restock
		for _, itemL in pairs(Organizer.Restock[Organizer.ActiveRestock]) do

			-- create an array record for this item type and hue
			if not ContainerWindow.CurrentAmountArray[itemL.type] then
				ContainerWindow.CurrentAmountArray[itemL.type] = {}
			end
			if not ContainerWindow.CurrentAmountArray[itemL.type][itemL.hue] then
				ContainerWindow.CurrentAmountArray[itemL.type][itemL.hue] = 0
			end

			-- set the current amount for this type/hue as 0
			ContainerWindow.CurrentAmountArray[itemL.type][itemL.hue] = 0
		end
		
		-- getting the container data of the container to restock
		local containerData = Interface.GetContainersData(ContainerWindow.OrganizeBag, true)
		
		-- do we have the container data? (if not the container is not a container...)
		if Interface.VerifyContainer(ContainerWindow.OrganizeBag, containerData) then
				
			-- get the container items number
			local numItems = containerData.numItems

			-- do we have any item?
			if numItems > 0 then

				-- we scan all items
				for i = 1, numItems  do

					-- current item ID
					local itemId = containerData.ContainedItems[i].objectId

					-- get the item data
					local itemData = Interface.GetObjectInfoData(itemId)

					-- do we have the item data?
					if (itemData) then

						-- parsing the array with the items we need
						for tp, h in pairs(ContainerWindow.CurrentAmountArray) do

							-- is this item of the type and hue we need?
							if (tp == itemData.objectType and h[itemData.hueId]) then

								-- we sum the amount of this stack to the total
								ContainerWindow.CurrentAmountArray[itemData.objectType][itemData.hueId] =ContainerWindow.CurrentAmountArray[itemData.objectType][itemData.hueId] + itemData.quantity							
							end
						end
					end
				end
			end

		else -- the container to restock is invalid, we reset what we've done until now
			SendOverheadText(GetStringFromTid(1154790), OverheadText.CustomMessageHues.RED) -- Invalid destination container!
			ContainerWindow.OrganizeBag = nil
			return
		end

		-- all is gone well, we can start restocking
		ContainerWindow.Restock = true
	end
end

function ContainerWindow.Restocks()
	
	-- container window name
	local dialog = WindowUtils.GetActiveDialog()

	-- does the window really exist?
	if not DoesWindowExist(dialog) then
		return
	end

	-- get the container ID
	local id = WindowGetId(dialog)
	
	-- do we have a valid id?
	if not IsValidID(id) then
		return
	end

	-- reset the organizer bag
	ContainerWindow.OrganizeBag = nil

	-- reset the ID of the container to restock from
	ContainerWindow.OrganizeParent = nil

	-- restock is not currently active
	if (not ContainerWindow.Restock) then
		
		-- set this container as the container to restock from
		ContainerWindow.OrganizeParent = id

		-- do we have a container to restock from?
		if (Organizer.Restocks_Cont[Organizer.ActiveRestock] == 0) then

			-- we ask the player to target the bag to restock
			RequestTargetInfo(ContainerWindow.RestockTargetInfoReceived)
			SendOverheadText(GetStringFromTid(1154773), OverheadText.CustomMessageHues.LIGHTBLUE) -- Target the hotbag.

		else -- we have a container to restock from

			-- set the container to restock from as organize bag
			ContainerWindow.OrganizeBag = Organizer.Restocks_Cont[Organizer.ActiveRestock]

			-- initialize the restock process
			ContainerWindow.InitializeRestock()

			return
		end
	end

	-- warn the player the restock is completed
	ChatPrint(GetStringFromTid(594), SystemData.ChatLogFilters.SYSTEM)
	
	-- if we got here, we can't do a restock or the player wants to stop it manually
	ContainerWindow.Restock = false
end

function ContainerWindow.RestockTargetInfoReceived(objectId)

	-- we get the item the player targeted
	ContainerWindow.OrganizeBag = objectId

	-- initialize the restock process
	ContainerWindow.InitializeRestock()
end

function ContainerWindow.RestockCycle(timePassed)

	-- is restock active and can we pickup an item?
	if ContainerWindow.Restock and ContainerWindow.CanPickUp then
		
		-- getting the container data
		local containerData = Interface.GetContainersData(ContainerWindow.OrganizeParent, true)

		-- do we have the container data?
		if not Interface.VerifyContainer(ContainerWindow.OrganizeParent, containerData) then
			return
		end

		-- getting the number of items from the container too loot
		local numItems = containerData.numItems

		-- is there something in the container?
		if numItems > 0 then

			-- acquire the bag in which to drop the loot
			local OrganizeBag = ContainerWindow.OrganizeBag

			-- no bag specified or the bag is unavailable? we drop all inside the player backpack
			if not IsValidID(OrganizeBag) then
				OrganizeBag = ContainerWindow.PlayerBackpack
			end

			-- scanning the container items
			for i = 1, numItems  do

				-- getting the first item ID
				local itemId = containerData.ContainedItems[i].objectId

				-- getting the item data
				local itemData = Interface.GetObjectInfoData(itemId)
				
				-- do we have the item data?
				if (itemData) then

					-- is this the active restock active?
					if (Organizer.Restock[Organizer.ActiveRestock] and not ContainerWindow.BodRestock) then

						-- we scan the current restock items and find out if the current container item type is in the list
						for _, itemL in pairs(Organizer.Restock[Organizer.ActiveRestock]) do

							-- the amount we still need of this item type
							local amountWeNeed = itemL.qta - ContainerWindow.CurrentAmountArray[itemL.type][itemL.hue]

							-- is the current item of the right type, and color of the one specified in the restock agent? and do we need more?
							if (IsValidID(itemL.type) and itemL.type == itemData.objectType and itemL.hue == itemData.hueId and amountWeNeed > 0) then
							
								-- initialize the amount to drag to 0
								local DragAmount = 0

								-- the quantity we have is not enough, so we take what we have
								if itemData.quantity < amountWeNeed then
									DragAmount = itemData.quantity 

								else -- we have more than enough (or the exact amount), so we take what we need
									DragAmount = amountWeNeed
								end

								-- do we have something to move?
								if (DragAmount > 0) then

									-- move the amount we found
									MoveItemToContainer(itemId, DragAmount, OrganizeBag)

									-- update the current amount we already have
									ContainerWindow.CurrentAmountArray[itemL.type][itemL.hue] = ContainerWindow.CurrentAmountArray[itemL.type][itemL.hue] + DragAmount

									-- reset the pickup flag
									ContainerWindow.ResetPickupTimer()

									-- ready for the next item when the pickup cooldown resets
									return
								end
							end
						end

					-- are we restocking for a bod?
					elseif ContainerWindow.BodRestock then

						-- do we need the current item?
						if ContainerWindow.CurrentAmountArray[itemData.objectType] and ContainerWindow.CurrentAmountArray[itemData.objectType][itemData.hueId] then

							-- initialize the amount to drag to 0
							local DragAmount = 0

							-- the amount of this stack is not enough, we take what we have
							if itemData.quantity < ContainerWindow.CurrentAmountArray[itemData.objectType][itemData.hueId] then
								DragAmount = itemData.quantity 

								-- update the amount we still need
								ContainerWindow.CurrentAmountArray[itemData.objectType][itemData.hueId] = ContainerWindow.CurrentAmountArray[itemData.objectType][itemData.hueId] - DragAmount

							else -- the amount of this stack is enough, we take what we need
								DragAmount = ContainerWindow.CurrentAmountArray[itemData.objectType][itemData.hueId]
								ContainerWindow.CurrentAmountArray[itemData.objectType][itemData.hueId] = nil
							end

							-- do we have something to move?
							if (DragAmount > 0) then

								-- move the amount we found
								MoveItemToContainer(item.objectId, DragAmount, OrganizeBag)

								-- reset the pickup flag
								ContainerWindow.ResetPickupTimer()

								-- ready for the next item when the pickup cooldown resets
								return
							end
						end
					end
				end
			end
		end 

		-- no items to move, we turn off the agent
		SendOverheadText(GetStringFromTid(188), OverheadText.CustomMessageHues.LIGHTBLUE)
		ContainerWindow.BodRestock = nil
		ContainerWindow.Restock = false
	end
end

function ContainerWindow.Lock()

	-- container window name
	local dialog = WindowUtils.GetActiveDialog()
	
	-- does the window really exist?
	if not DoesWindowExist(dialog) then
		return
	end

	-- invert the locked status for the backpack
	ContainerWindow.Locked = not ContainerWindow.Locked 

	-- save the locked status
	Interface.SaveSetting( "LockedBackpack", ContainerWindow.Locked  )

	-- set the container window movable
	WindowSetMovable(dialog, not ContainerWindow.Locked )

	-- button texture name
	local texture = "Lock"

	-- if is not locked then we change the texture name
	if not ContainerWindow.Locked  then
		texture = "UnLock"
	end

	-- update the texture on the button
	ButtonSetTexture(dialog.."Lock", InterfaceCore.ButtonStates.STATE_NORMAL, texture, 0, 0)
	ButtonSetTexture(dialog.."Lock",InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, texture, 0, 0)
	ButtonSetTexture(dialog.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED, texture, 0, 0)
	ButtonSetTexture(dialog.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, texture, 0, 0)
end

function ContainerWindow.OnSetMoving(isMoving)

	-- container window name
	local dialog = WindowUtils.GetActiveDialog()
	
	-- does the window really exist?
	if not DoesWindowExist(dialog) then
		return
	end

	-- get the container ID
	local id = WindowGetId(dialog)
	
	-- do we have a valid id?
	if not IsValidID(id) then
		return
	end

	-- is the container part of a cascade?
	if ContainerWindow.IsCascading(id) then
		
		-- since it's goning to be moved, we remove it from the cascade
		ContainerWindow.RemoveFromCascade(id)
	end
end

function ContainerWindow.SetInventoryButtonPressed(pressed)
	
	-- player paperdoll window name
	local my_paperdoll = "PaperdollWindow" .. GetPlayerID()

	-- player paperdoll backpack icon
	local my_paperdoll_backpackicon = "PaperdollWindow" .. GetPlayerID() .. "ToggleInventory"

	-- does the paperdoll exist and is visible?
	if DoesWindowExist(my_paperdoll) and WindowGetShowing(my_paperdoll) then

		-- switch the backpack button to pressed
		ButtonSetPressedFlag(my_paperdoll_backpackicon, DoesWindowExist("ContainerWindow_" .. GetBackpackID(GetPlayerID())))
	end	
end

function ContainerWindow.GetVisibleSlots(dialog)

	-- does the window really exist?
	if not DoesWindowExist(dialog) then
		return
	end

	-- get the container ID
	local id = WindowGetId(dialog)
	
	-- do we have a valid id?
	if not IsValidID(id) then
		return
	end

	local visibleSlots = 0

	-- is the container in list view mode?
	if ContainerWindow.ViewModes[id] == "List" then

		-- get the current number of rows
		local numRows = ContainerWindow.OpenContainers[id].numCreatedRows
	
		-- does the number of rows is greater than 0?
		if numRows > 0 then
		
			-- running all the ids
			for i = 1, numRows do
			
				-- slot window name
				local slotName = dialog.."Item"..i

				-- if the window exist, we destroy it
				if DoesWindowExist(slotName) and WindowGetShowing(slotName) and IsValidWString(LabelGetText(slotName.."Name")) then
					visibleSlots = visibleSlots + 1
				end
			end
		end

	elseif ContainerWindow.ViewModes[id] == "Grid" then

		-- getting the number of existing slots
		local max = ContainerWindow.OpenContainers[id].numCreatedSlots

		-- do we have slots created?
		if max > 0 then

			-- scanning all the slots
			for i = 1, max do
		
				-- slot window name
				local socketName = dialog.."GridViewSocket"..i 

				-- if the slot exist, we destroy it
				if DoesWindowExist(socketName) then
					visibleSlots = visibleSlots + 1
				end
			end
		end
	end

	return visibleSlots
end

function ContainerWindow.HideAllContents(parent)

	-- does the window really exist?
	if not DoesWindowExist(parent) then
		return
	end

	-- get the container ID
	local id = WindowGetId(parent)
	
	-- do we have a valid id?
	if not IsValidID(id) then
		return
	end

	-- get the max slots for the container
	local maxSlots = ContainerWindow.OpenContainers[id].maxSlots
	
	-- are the number of slot greater than 0?
	if maxSlots > 0 then
		
		-- scan all the slots
		for i = 1, maxSlots do

			-- if the grid slot exist, we remove the texture and all the text (so it will be invisible)
			if DoesWindowExist(parent.."GridViewSocket"..i.."Icon") then

				-- remove the textures
				DynamicImageSetTexture(parent.."GridViewSocket"..i.."Icon", "", 0, 0)
				DynamicImageSetTexture( parent.."GridViewSocket"..i.."IconMulti", "", 0, 0 )

				-- reset the texts
				LabelSetText(parent.."GridViewSocket"..i.."Quantity", L"")
				LabelSetText(parent.."GridViewSocket"..i.."Uses", L"")
			end
		end
	end
end

function ContainerWindow.ForceContainerUpdate(id)

	-- do we have a valid id?
	if not IsValidID(id) then
		return
	end

	-- container window name
	local windowName = "ContainerWindow_" .. id

	-- does the window really exist?
	if not DoesWindowExist(windowName) then
		return
	end

	-- do we have the open container record?
	if not ContainerWindow.OpenContainers[id] then
		return
	end

	-- clear the container contents and sort array to refresh it
	ContainerWindow.ContainerItems[id] = {}
	ContainerWindow.SortedItems[id] = {}

	-- set the dirty flag
	ContainerWindow.OpenContainers[id].dirty = true
end

-- NOTE: this function is triggered continuously so we limit the container update
function ContainerWindow.MiniModelUpdate()
	
	-- get the container ID
	local id = WindowData.UpdateInstanceId
	
	-- do we have a valid id?
	if not IsValidID(id) then
		return
	end

	-- is this the trap box?
	if id == Interface.TrapBoxID then
		return
	end

	-- is the update request for the right container
	if (id == WindowGetId(SystemData.ActiveWindow.name)) then

		-- container window name
		local windowName = "ContainerWindow_" .. id

		-- does the window really exist?
		if not DoesWindowExist(windowName) then
			return
		end

		-- is the container open and already in update?
		if (ContainerWindow.OpenContainers[id] and ContainerWindow.OpenContainers[id].inUpdate) then
			return
		end

		-- getting the container data
		local containerData = Interface.GetContainersData(id, true)

		-- do we have the container data?
		if not Interface.VerifyContainer(id, containerData) then
			return
		end

		-- set the dirty flag
		ContainerWindow.OpenContainers[id].dirty = true	
	end
end

function ContainerWindow.UpdateContents(id)

	-- do we have a valid id?
	if not IsValidID(id) then
		return
	end

	-- container window name
	local this = "ContainerWindow_"..id

	-- does the window really exist?
	if not DoesWindowExist(this) then
		return
	end
	
	-- is this the trap box?
	if id == Interface.TrapBoxID then
		return
	end
	
	-- getting the gump info
	local gumpID, typeName = ContainersInfo.GetGump(id, ContainerWindow.OpenContainers[id].requestedContainerArt)

	-- is the gump ID we have different from the one the container have?
	if ContainerWindow.OpenContainers[id].requestedContainerArt ~= gumpID then

		-- update the gump ID
		ContainerWindow.OpenContainers[id].requestedContainerArt = gumpID
		
		-- re-create the container
		ContainerWindow.CreateContainer(this, false)
	end
	
	-- if the container is already regisstered we unregister it first (or it will cause problems with legacy containers)
	if WindowData.ContainerWindow[id] then
		UnregisterWindowData(WindowData.ContainerWindow.Type, id)		
	end

	-- getting the container data
	local data = Interface.GetContainersData(id, true)
	
	-- do we have the container data?
	if not Interface.VerifyContainer(id, data) then
		return
	end
	
	-- get the container items number
	local numItems = data.numItems
	
	-- is the number of items too high that could cause lag?
	if numItems > ContainerWindow.LagReductionLimit and ContainerWindow.OpenContainers[id].isCorpse then
		ContainerWindow.OpenContainers[id].laggy = true
	end
	
	-- get the current text of the content label
	local oldContent = LabelGetText(this .. "Content")

	-- empty the content text
	LabelSetText(this .. "Content", L"")

	-- is the content label enabled?
	if (Interface.Settings.ToggleContentsInfo) then

		-- get the current content
		local content = ContainerWindow.GetContent(id)

		-- do we have the text
		if content then

			-- update the content label
			LabelSetText(this.."Content", content)		
			
		else -- we don't have an updated text, so we restore the old one
			LabelSetText(this.."Content", oldContent)
		end
	end
	
	-- basic container windows (list, grid and freeform)
	local list_view_this = this.."ListView"        
	local grid_view_this = this.."GridView"
	local freeform_view_this = this.."FreeformView"
	
	-- get the max amount of slots for the container
	local max = ContainerWindow.OpenContainers[id].maxSlots

	-- is this a loot container? (used for sorting, disabled if there are too many items)
	local isLoot = ButtonGetPressedFlag( this .. "LootSort" ) and not ContainerWindow.OpenContainers[id].laggy
	
	-- flag the container as "IN UPDATE"
	ContainerWindow.OpenContainers[id].inUpdate = true

	-- get the scroll position before clearing the list/grid
	local listPos = ScrollWindowGetOffset(list_view_this)
	local gridPos = ScrollWindowGetOffset(grid_view_this)
	
	-- is this a free form view container?
	if ContainerWindow.ViewModes[id] ~= "Freeform" then	

		-- re-create all the slots for grid and list
		ContainerWindow.CreateGridViewSockets(this)
		ContainerWindow.CreateListViewSlots(this)

		-- hide all the slots
		ContainerWindow.HideAllContents(this)

	else -- for free form we have to destroy all the grid and legacy slots (we don't need them)
		ContainerWindow.DestroyGridViewSockets(this)
		ContainerWindow.DestroyListViewRows(this)
	end

	-- do we have items to show?
	if numItems > 0 or (ContainerWindow.OpenContainers[id].ContentItems and ContainerWindow.OpenContainers[id].ContentItems > 0) then

		-- in list view mode we hide grid and free form
		if ContainerWindow.ViewModes[id] == "List" then
			WindowSetShowing(list_view_this , true)
			WindowSetShowing(grid_view_this, false)
			WindowSetShowing(freeform_view_this, false)
	
		-- in grid view mode we hide list and free form
		elseif ContainerWindow.ViewModes[id] == "Grid" then
			WindowSetShowing(list_view_this, false)
			WindowSetShowing(grid_view_this, true)
			WindowSetShowing(freeform_view_this, false)
			
		-- in free form mode we hide list and grid
		elseif ContainerWindow.ViewModes[id] == "Freeform" then
			WindowSetShowing(list_view_this, false)
			WindowSetShowing(grid_view_this, false)
			WindowSetShowing(freeform_view_this, true)	
		end
		
	-- no items and free form mode? we hide grid and list
	elseif ContainerWindow.ViewModes[id] == "Freeform" then
		WindowSetShowing(list_view_this, false)
		WindowSetShowing(grid_view_this, false)
		WindowSetShowing(freeform_view_this, true)

	else -- no items in grid or list view mode? we hide all of them
		WindowSetShowing(list_view_this, false)
		WindowSetShowing(grid_view_this, false)
		WindowSetShowing(freeform_view_this, false)
	end

	-- empty the title text
	LabelSetText(this.."Title", L"")

	-- do we have a container name?
	if IsValidWString(data.containerName) then

		-- we update the container name with the new one
		WindowUtils.FitTextToLabel(this.."Title", data.containerName)
	end

	-- is this the player backpack?
	if id == ContainerWindow.PlayerBackpack then
		
		-- get the new items list
		local allItems = ContainerWindow.ScanQuantities(ContainerWindow.PlayerBackpack, true)

		-- do we have the list of all backpack items?
		if Interface.BackPackItems then

			-- get the list of all the new items
			local newItems = ContainerWindow.GetNewItemsList(allItems)

			-- are there new items?
			if table.countElements(newItems) > 0 then

				-- trigger the new items event
				Interface.OnNewItemsInBackpack(newItems)
			end
		end

		-- reset the player backpack items list
		Interface.BackPackItems = nil

		-- update the backpack contents list
		Interface.BackPackItems = allItems
	end
	
	-- reset the registered items array
	ContainerWindow.RegisteredItems[id] = {}
	
	-- do we have items and it's not in free form view?	
	if (ContainerWindow.ViewModes[id] ~= "Freeform" and numItems > 0) then		

		-- trigger the first uses update
		ContainerWindow.LastUsesDelta[id] = ContainerWindow.UsesRefreshRate

		-- initialize the sort arrays only if they are nil
		if not ContainerWindow.ContainerItems[id] or isLoot then
			ContainerWindow.ContainerItems[id] = {}
		end

		if not ContainerWindow.SortedItems[id] then
			ContainerWindow.SortedItems[id] = {}
		end

		-- scanning the container items
		for i = 1, numItems do
			
			-- get the item ID
			local itemId = data.ContainedItems[i].objectId

			-- do we have a valid item ID?
			if not IsValidID(itemId) then
				continue
			end

			-- initialize the found variable to false
			local found = false

			-- is this a loot sort container?
			if isLoot then
				
				-- scan the sorted array
				for lootType, items in pairsByKeys(ContainerWindow.SortedItems[id]) do

					-- scan all the items of this loot type
					for i, itm in pairsByIndex(items) do
						
						-- is this the same item of the id we got before?
						if itm.objectId == itemId then

							-- we found the item, is already sorted
							found = true
							break
						end
					end

					-- we cn get out of the cycle if we have found the item
					if found then
						break
					end
				end
			end
			
			-- is this already listed in the container's items and the container is not laggy? (the process can be heavy due to the item properties parsing)
			if not ContainerWindow.ContainerItems[id][itemId] and not ContainerWindow.OpenContainers[id].laggy then

				-- initialize the array for the item
				ContainerWindow.ContainerItems[id][itemId] = {}
				
				-- initialize the props TID variable
				local props

				-- acquire the item properties for the item
				local dt = Interface.GetItemPropertiesData(itemId, "Get item intensity info for listview")	

				-- do we have the properties?
				if dt then
				
					-- filling the TID props array
					props = ItemProperties.BuildParamsArray(dt, true)
				end

				-- do we have the item properties?
				if props then
				
					-- is the item an artifact?
					local artifact = ItemProperties.IsArtifact(props)
				
					-- is the item a set piece?
					local set = ItemProperties.IsSet(props)

					-- calculate the item intensity, if is worth a relic, essence, ecc.. and the number of props
					local worth, totalIntensity, propcount = ItemProperties.GetItemIntensity(itemId)
				
					-- default item name color
					local itemColor = Interface.Settings.Props_TITLE_COLOR
		
					-- initialize the worth name
					local worthName = ""
					
					-- is this a finders keepers item?
					if ContainerWindow.FindersKeepersActiveItems[itemId] then

						-- convert the finders keeper color to rgb
						local r, g, b = HueRGBAValue(ContainerWindow.FindersKeepersActiveItems[itemId])

						-- save the item color in the array for this item
						itemColor = { r = r, g = g, b = b }

					-- is this a set?
					elseif set then
					
						-- the item name will use the set color 
						itemColor = Interface.Settings.Props_SET_COLOR

						-- worth level: set item
						worth = ItemPropertiesInfo.UNRAVEL_SetItem

					-- is this an artifact?
					elseif artifact then

						-- the item name will use the artifact color
						itemColor = Interface.Settings.Props_ARTIFACT_COLOR

						-- worth level: artifact
						worth = ItemPropertiesInfo.UNRAVEL_Artifact

					-- do we have a valid props count?
					elseif IsValidID(propcount) then
					
						-- is this a relic?
						if worth == ItemPropertiesInfo.UNRAVEL_RelicFragment then
						
							-- the item name will use the relic color
							itemColor = Interface.Settings.Props_RELIC_COLOR

							-- worth level: relic
							worthName = "Relic"

						-- is this an essence?
						elseif worth == ItemPropertiesInfo.UNRAVEL_EnchantedEssence then
						
							-- the item name will use the essence color
							itemColor = Interface.Settings.Props_ESSENCE_COLOR

							-- worth level: essence
							worthName = "Essence"

						-- is this a residue?
						elseif worth == ItemPropertiesInfo.UNRAVEL_MagicResidue then

							-- the item name will use the residue color
							itemColor = Interface.Settings.Props_RESIDUE_COLOR

							-- worth level: residue
							worthName = "Residue"
						end
					end

					-- save the item color in the array
					ContainerWindow.ContainerItems[id][itemId].color = itemColor

					-- do we have a total intensity level?
					if not totalIntensity then

						-- 0 by default if we don't have anything
						totalIntensity = 0
					end

					-- initialize the item record for the sorted array
					local item = data.ContainedItems[i]

					-- adding the item intensity in the item record
					item.totalIntensity = totalIntensity
				
					-- if the item was not in the sorted array already and the container is loot sorted and we have the properties
					if not found and isLoot then
													
						-- get the correct item name
						local itemName = GetItemName(itemId)

						-- get the object type
						local objectType = GetItemType(itemId)

						-- get the item weight
						local weight = GetItemWeight(itemId)

						-- do we have a valid type?
						if IsValidID(objectType) then
					
							-- get the correct loot type with what we know about the item, and finders keepers color
							local LootType, fkcolor = ItemPropertiesInfo.GetLootType(itemName, itemTid, props, objectType, artifact, set, worthName)

							-- is the weight higher than the maximum we specified?
							if weight and weight > Interface.Settings.AutoLootMaxWeight then

								-- set the loot type as miscellaneous so it will go at the bottom of the list
								LootType = ItemPropertiesInfo.LootOrder.Misc
							end

							-- is this a finders keepers item?
							if LootType == ItemPropertiesInfo.LootOrder.FindersKeepers then

								-- flag the item as finders keepers item
								ContainerWindow.FindersKeepersActiveItems[itemId] = fkcolor
							end

							-- is the loot normal but we have the finders keepers color?
							if (LootType == ItemPropertiesInfo.LootOrder.FindersKeepers or LootType == ItemPropertiesInfo.LootOrder.Misc) and fkcolor then

								-- convert the finders keeper color to rgb
								local r, g, b = HueRGBAValue(fkcolor)

								-- save the item color in the array for this item
								ContainerWindow.ContainerItems[id][itemId].color = { r = r, g = g, b = b }
							end
						
							-- do we have other items of this loot type? if not we initialize the array for it
							if not ContainerWindow.SortedItems[id][LootType] then
								ContainerWindow.SortedItems[id][LootType] = {}
							end

							-- adding the item to the array
							table.insert(ContainerWindow.SortedItems[id][LootType], item)
						end
					end
				end
			end
			
			-- mark the item as registered
			ContainerWindow.RegisteredItems[id][itemId] = true
			
			-- if there are more than 10 items in the container, it can't be the main container for the transfer crate
			if numItems < 10 and not ContainerWindow.OpenContainers[id].TransferCrate then

				-- get the item properties to determine if it's a transfer crate
				local dt = Interface.GetItemPropertiesData( itemId, "Get item intensity info for listview" )

				-- initialize the props TID variable
				local props

				-- do we have the properties?
				if dt then

					-- generate the TID array
					props = ItemProperties.BuildParamsArray( dt, true )
				end

				-- do we have the TID array?
				if props then

					-- check if this item is part of the transfer crate
					if	props[1062824] or	-- Your Bank Box
						props[1062825] or	-- Your Stabled Pets
						props[1062826] or	-- Your Worn Equipment
						props[1062827] or	-- Your Backpack
						props[1062905]		-- Your Controlled Pets
					then 
						
						-- rename the container in "Transfer Crate"
						data.containerName = L"Transfer Crate"

						-- mark this container as "Transfer Crate"
						ContainerWindow.OpenContainers[id].TransferCrate = true

						-- update the container title name
						WindowUtils.FitTextToLabel(this.."Title", data.containerName)
					end
				end
			end
		end

		-- is loot sort enabled?
		if isLoot then
	
			-- intensity sort: ordering the array by intensity
			for lootType, items in pairsByKeys(ContainerWindow.SortedItems[id]) do
				local a = ContainerWindow.SortedItems[id][lootType]
				local pos = 1
				while pos < #a do
					if (pos == 1 or a[pos].totalIntensity <= a[pos-1].totalIntensity) then
						pos = pos + 1
					else
						local old = a[pos]
						a[pos] = a[pos-1]
						a[pos-1] = old
						if (pos > 1) then
							pos = pos - 1
						end
					end
				end
				ContainerWindow.SortedItems[id][lootType] = a
			end
			
			-- final sort: changing the items position index so they will be sorted in the list an grid view
			local index = 0
			for lootType, items in pairsByKeys(ContainerWindow.SortedItems[id]) do
				for i, itm in pairsByIndex(items) do
					local sItem = itm
					for j = 1, numItems do
						local item = data.ContainedItems[j]

						if item.objectId == sItem.objectId then
							index = index + 1
							item.gridIndex = index
							break
						end
					end
				end
			end
		end

		-- update the grid view
		ContainerWindow.UpdateGridViewSockets(id)

		-- update the list view
		ContainerWindow.UpdateListView(id)
	end

	-- scanning all the items one last time to show them
	for i = 1, numItems do

		-- current item ID
		local itemID = data.ContainedItems[i].objectId
			
		-- do we have a valid item id?
		if IsValidID(itemID) then

			-- get the item data
			local itemData = Interface.GetObjectInfoData(itemID)

			-- update the item
			ContainerWindow.UpdateObject(this, itemID)
		end
	end

	-- is this container in list view mode?
	if (ContainerWindow.ViewModes[id] == "List") then

		-- scanning all items
		for i = 1, ContainerWindow.OpenContainers[id].numCreatedRows do

			-- does the slot exist and the name is an empty string?
			if (DoesWindowExist(this.."Item"..i) and LabelGetText(this.."Item"..i.."Name" ) == "") then

				-- hide the slot
				WindowSetShowing(this.."Item"..i, false)

			-- do we have a valid name?
			elseif DoesWindowExist(this.."Item"..i) then
					
				-- show the slot
				WindowSetShowing(this.."Item"..i, true)
			end
		end
	end

	-- update the scrollable area
	ScrollWindowUpdateScrollRect(list_view_this)

	-- restore the previous scroll position
	Interface.AddTodoList({name = "update ignore players list", func = function() if DoesWindowExist(list_view_this) then ScrollWindowSetOffset(list_view_this, listPos) end end, time = Interface.TimeSinceLogin + 0.5})
	
	-- update the trade data (if there is a trade window)
	for w, dat in pairs (TradeWindow.TradeInfo) do
		TradeWindow.UpdateContents(dat.containerId, w, true)
		TradeWindow.UpdateContents(dat.containerId2, w, true)
	end
		
	-- remove the "IN UPDATE" flag from the container
	ContainerWindow.OpenContainers[id].inUpdate = false

	-- remove the dirty flag
	ContainerWindow.OpenContainers[id].dirty = nil

	-- update the refresh time for the next time
	ContainerWindow.OpenContainers[id].LastUpdate = Interface.TimeSinceLogin + ContainerWindow.RefreshRate
end

function ContainerWindow.GetContent(contId)	
	
	-- initialize the string to return to empty string
	local rtn = L""

	-- if the container is laggy or is a loot corpse we can skip all and return nothing
	if ContainerWindow.OpenContainers[contId].laggy or ContainerWindow.OpenContainers[contId].isCorpse then
		return
	end

	-- scan the container items
	local items, qta, wgt = ContainerWindow.ScanQuantities(contId, true)

	-- update the number of items in the container
	ContainerWindow.OpenContainers[contId].ContentItems = qta

	-- get the item properties for the container
	local dt = Interface.GetItemPropertiesData( contId, "Get container items/weight data" )

	-- initialize the TID array variable
	local props

	-- do we have the properties?
	if dt then

		-- create the TID array
		props = ItemProperties.BuildParamsArray( dt, true )
	end

	-- do we have the TID array?
	if props then

		-- parse the properties in search of the "contents" one
		for tid, _ in pairs(ItemPropertiesInfo.ContainerWeightTid) do

			-- do we have this TID in the properties?
			if props[tid] then

				-- get the parameters
				local tidParams = props[tid]

				-- get the items number
				local itemsNum = tidParams[1]

				-- max items default 125
				local maxItems = 125

				-- is the properties specifying a max number of items?
				if tid == 1073841 or tid == 1072241 then

					-- acquire the max items number
					maxItems = tidParams[2]
				end
				
				-- acquire the weight amount
				local weight = StringUtils.AddCommasToNumber(tidParams[3])

				-- no max weight by default
				local maxweight

				-- do the properties specifies a max weight?
				if tid == 1072241 or tid == 1073840 then

					-- update the max weight with the one specified
					maxweight = tidParams[4]
				end
				
				-- is this the player bank box?
				if contId == ContainerWindow.PlayerBank then
					rtn = ReplaceTokens(GetStringFromTid(1073841), {towstring(qta), towstring(tidParams[2]), StringUtils.AddCommasToNumber(wgt)})   -- Contents: ~1_COUNT~/~2_MAXCOUNT~ items, ~3_WEIGHT~ stones
		
				else -- any other container

					if tid == 1072241 then -- Contents: ~1_COUNT~/~2_MAXCOUNT~ items, ~3_WEIGHT~/~4_MAXWEIGHT~ stones
						rtn = ReplaceTokens(GetStringFromTid(tid), {towstring(itemsNum), towstring(maxItems), towstring(weight), towstring(maxweight)})
						
					elseif tid == 1073839 then -- Contents: ~1_COUNT~ items, ~2_WEIGHT~ stones
						rtn = ReplaceTokens(GetStringFromTid(tid), {towstring(itemsNum), towstring(weight)})
						
					elseif tid == 1073840 then -- Contents: ~1_COUNT~ items, ~2_WEIGHT~/~3_MAXWEIGHT~ stones
						rtn = ReplaceTokens(GetStringFromTid(tid), {towstring(itemsNum), towstring(weight), towstring(maxweight)})
						
					elseif tid == 1073841 then -- Contents: ~1_COUNT~ items, ~2_WEIGHT~/~3_MAXWEIGHT~ stones
						rtn = ReplaceTokens(GetStringFromTid(tid), {towstring(itemsNum), towstring(maxItems), towstring(weight)})
					end
				end
				break
			end
		end
	end

	-- do we have a valid value to return?
	if IsValidWString(rtn) and wstring.find(rtn, L":", 1, true) then
		return rtn, qta
	end
end

function ContainerWindow.ScanQuantities(backpackId, itemsOnly, AllItems, qtextra, wgtextra)
	
	-- do we have a valid id?
	if not IsValidID(backpackId) then
		return AllItems, qtextra, wgtextra
	end

	-- getting the container data
	local containerData = Interface.GetContainersData(backpackId, true)
	
	-- do we have the container data?
	if not Interface.VerifyContainer(backpackId, containerData) then
		return AllItems, qtextra, wgtextra
	end

	-- if we don't have the extra quanity (from a previous loop), we set it to 0
	if not qtextra then
		qtextra = 0
	end

	-- if we don't have the extra weight (from a previous loop), we set it to 0
	if not wgtextra then
		wgtextra = 0
	end

	-- if we don't have AllItems (from a previous loop), we set it to 0
	if not AllItems then
		AllItems = {}
	end

	-- get the container items number
	local numItems = containerData.numItems

	-- initialize the variables we need
	local qta = qtextra + numItems -- quantity starts with the number of items of the main container
	local wgt = wgtextra

	-- do we have any item inside the container?
	if numItems > 0 then

		-- we scan all the items
		for i = 1, numItems do

			-- item ID
			local itemId = containerData.ContainedItems[i].objectId

			-- get the object type
			local objectType = GetItemType(itemId)

			-- do we have a valid type id?
			if not IsValidID(objectType) then
				continue
			end

			-- get the object hue
			local hue = GetItemHue(itemId)

			-- get the object quantity
			local amount = GetItemAmount(itemId)

			-- create the record for the item
			if not AllItems[objectType] then
				AllItems[objectType] = {}
			end

			if not AllItems[objectType][hue] then
				AllItems[objectType][hue] = {}
			end

			-- assign the amount to the item ID
			AllItems[objectType][hue][itemId] = amount

			-- is this item a container?
			if IsContainer(itemId) then

				-- we scan this sub container to get the items inside
				AllItems, qt, wg = ContainerWindow.ScanQuantities(itemId, itemsOnly, AllItems, qta, wgt)
				qta = qt
				wgt = wg
			end

			-- do we have some weight and are we searching for the weight too?
			if not itemsOnly then
		
				-- get the item properties of the item
				local props = Interface.GetItemPropertiesData( itemId, "sub-containers items weight scan" )

				-- do we have the properties?
				if props then

					-- we create the TID params
					local params = ItemProperties.BuildParamsArray( props )
			
					-- we scan the params
					for tid, _ in pairs(params) do

						-- is this a weight property?
						if ItemPropertiesInfo.WeightONLYTid[tid] then
					
							-- we get the weight of the container and add it to the total weight
							local token = ItemPropertiesInfo.WeightTid[tid]
							local val = tostring(params[tid][token])
							wgt = wgt + tonumber(val)
							break
						end
					end
				end
			end
		end
	end

	-- return what we've found
	return AllItems, qta, wgt
end

function ContainerWindow.HandleUpdateObjectEvent()

	-- get the object id
	local objectID = WindowData.UpdateInstanceId
	
	-- do we have a valid ID?
	if not IsValidID(objectID) then
		return
	end

	-- is the object already registered in the container?
	if not ContainerWindow.IsObjectRegistered(objectID) then
		return
	end

	-- get the container window name
	local containerWindow = SystemData.ActiveWindow.name

	-- does the window really exist?
	if not DoesWindowExist(containerWindow) then
		return
	end
	
	-- get the container ID
	local id = WindowGetId(containerWindow)

	-- do we have a valid ID?
	if not IsValidID(id) then
		return
	end
	
	-- do we have an open container record?
	if not ContainerWindow.OpenContainers[id] then
		return
	end
	
	-- update the object
	ContainerWindow.UpdateObject(containerWindow, objectID)
end

function ContainerWindow.UpdateObject(windowName, updateId)
	
	-- do we have a valid ID?
	if not IsValidID(updateId) then
		return
	end

	-- do we have a valid window name?
	if not DoesWindowExist(windowName) then
		return
	end
	
	-- get the object data
	local item = Interface.GetObjectInfoData(updateId)
	
	-- do we have the object data?
	if not item then
		return
	end

	-- get the container ID
	local containerId = item.containerId
	
	-- do we have a valid container id?
	if not IsValidID(containerId) then
		return
	end
	
	-- getting the container data
	local containerData = Interface.GetContainersData(containerId, true)

	-- do we have the container data?
	if not Interface.VerifyContainer(containerId, containerData) then
		return
	end
	
	-- get the number of items in the container
	local numItems = containerData.numItems
	
	-- is the loot sort enabled?
	local isLoot = ButtonGetPressedFlag( windowName .. "LootSort" )
	 
	-- get the view mode of the container
	local viewMode = ContainerWindow.ViewModes[containerId]	   

	-- does the player have the item and is a reagent?
	if DoesPlayerHaveItem(updateId) and ItemsInfo.Reagents[item.objectType] then
		
		-- get the quick stat label ID (if exist)
		local labID = QuickStats.DoesLabelExist(item.objectType, true, item.hueId)

		-- do we have a valid label ID?
		if IsValidID(labID) then

			-- label window name
			local label = "QuickStat_" .. labID

			-- update the label
			QuickStats.UpdateLabel(label)
		end
	end
	
	-- if this object is in my container
	if (containerId == WindowGetId(windowName)) then

		-- get the container items from the container data
		local containedItems = containerData.ContainedItems
		
		-- we initialize the index to 0
		local listIndex = 0
		local gridIndex = 0

		-- have we found the index?
		local found = false
			
		-- grid/legacy index scanning matter
		if ContainerWindow.ViewModes[containerId] ~= "Freeform" then

			-- scan the container items
			for i = 1, numItems do

				-- is this the the object we are looking for?
				if (containedItems[i] and containedItems[i].objectId == updateId) then

					-- is loot sort enabled? list index is the same of the grid index
					if isLoot then
						listIndex = containedItems[i].gridIndex

					else -- list index is the current item index
						listIndex = i
					end

					-- get the grid index
					gridIndex = containedItems[i].gridIndex

					-- item found
					found = true
					break
				end
			end
		
			-- is the list index greater than then number of items?
			if listIndex > numItems then

				-- we reset the sort arrays
				ContainerWindow.SortedItems[containerId] = {}
				ContainerWindow.ContainerItems[containerId] = {}
				return
			end
		
			-- item not found, we have to do this again
			if not found then
				return
			end
		end

		-- initialize the uses
		local uses

		-- if the container is not laggy we get the uses
		if not ContainerWindow.OpenContainers[containerId].laggy then
			uses = ContainerWindow.GetUses(updateId, containerId)
		end
			
		-- get the hue id
		local hue = item.hueId

		-- set the trap box id
		if (Interface.TrapBoxID == updateId) then				
			hue = 1152
		end

		-- set the loot box id
		if (Interface.LootBoxID == updateId) then				
			hue = 1177
		end
			
		-- is this list view mode?
		if viewMode == "List" then

			-- element window name
			local ElementName = windowName .. "Item" .. listIndex .. "Name"

			-- do we have the slot? if not we create it
			if not DoesWindowExist(ElementName) then
				ContainerWindow.CreateListViewSlots(windowName)
			end
		
			-- show the slot
			WindowSetShowing(windowName.."Item"..listIndex, true)

			-- initialize the item color
			local itemColor = Interface.Settings.Props_TITLE_COLOR

			-- get the item name
			local name = item.name

			-- write the item name
			LabelSetText(ElementName, FormatProperly(name))

			-- is the container laggy?
			if not ContainerWindow.OpenContainers[containerId].laggy then
				
				-- do we have a different color in the sorted array? we use that color instead
				if ContainerWindow.ContainerItems[containerId] and ContainerWindow.ContainerItems[containerId][updateId] and ContainerWindow.ContainerItems[containerId][updateId].color ~= nil then
					itemColor = ContainerWindow.ContainerItems[containerId][updateId].color
				end
				
				-- apply the item color
				LabelSetTextColor(ElementName, itemColor.r, itemColor.g, itemColor.b)
						
				-- get the correct item name
				name = GetItemName(updateId)					

				-- uses window name
				local ElementUses = windowName.."Item"..listIndex.."Uses"

				-- reset the uses to empty string
				LabelSetText(ElementUses, L"")
						
				-- initialize the summoning ball name variable
				local summBall

				-- clean up the TID string
				if wstring.find(wstring.lower(GetStringFromTid(1054131)), L":", 1, true) then -- a crystal ball of pet summoning: [charges: ~1_charges~] : [linked pet: ~2_petName~]
					summBall = wstring.sub(wstring.lower(GetStringFromTid(1054131)), 1, wstring.find(wstring.lower(GetStringFromTid(1054131)), L":", 1, true) - 1)
				end

				-- is the item a summoning ball (by comparing the name)
				if IsValidWString(name) and IsValidWString(summBall) then
					if wstring.find(wstring.lower(name), summBall, 1, true) then

						-- replace the name with the summoning ball name
						name = summBall
					end
				end

				-- is this a stackable item?
				if IsValidWString(name) and item.quantity > 1 then

					-- add the comma to the quantity number
					local commaQ = StringUtils.AddCommasToNumber(item.quantity)

					-- is that a valid string?
					if commaQ then
						
						-- show the quantity before the name
						name = StringUtils.AddCommasToNumber(item.quantity) .. L" " .. name
					end
				end

				-- acquire the item properties for the item
				local dt = Interface.GetItemPropertiesData(updateId, "Get item intensity info for listview" )

				-- initialize the props TID variable
				local props

				-- do we have the properties?
				if dt then

					-- filling the TID props array
					props = ItemProperties.BuildParamsArray(dt, true)
				end

				-- is this a scroll of alacrity?
				if (props and props[1078604] and IsValidWString(name)) then -- scroll of alacrity
							
					-- get the skill name TID
					local skill = tostring(wstring.gsub(props[1151930][1], L"#", L"")) -- Skill: ~1_skillname~ ~2_skillamount~ ~3_unitname~

					-- convert the TID to number
					skill = tonumber(skill)

					-- do we have a valid TID?
					if IsValidID(skill) then

						-- format the name	
						prop = GetStringFromTid(1149921) .. L" " .. GetStringFromTid(skill) -- Skill:

						-- show the item name
						LabelSetText(ElementName, FormatProperly(name))

						-- show the skill name in the second line
						LabelSetText(ElementUses, wstring.trim(FormatProperly(prop)))
					end
				end

				-- is this a scroll of transcendence?
				if (props and props[1094934] and IsValidWString(name)) then -- scroll of transcendence

					-- get the skill name TID
					local skill = tostring(wstring.gsub(props[1151930][1], L"#", L"")) -- Skill: ~1_skillname~ ~2_skillamount~ ~3_unitname~

					-- get the transcendence value
					local amt = props[1151930][2] -- Skill: ~1_skillname~ ~2_skillamount~ ~3_unitname~

					-- convert the TID to number
					skill = tonumber(skill)
					
					-- do we have a valid TID?
					if IsValidID(skill) then
					
						-- format the skill name	
						prop = GetStringFromTid(1149921) .. L" " .. GetStringFromTid(skill) .. L"(" .. amt .. L")" -- Skill:

						-- show the item name
						LabelSetText(ElementName, FormatProperly(name))

						-- show the skill name in the second line
						LabelSetText(ElementUses, wstring.trim(FormatProperly(prop)))				
					end
				end
						
				-- do we have the properties and a name?
				if (props and IsValidWString(name)) then

					-- get the map level (and also determine if it's a treasure map)
					local mapLevel = CourseMapWindow.TmapTID[dt.PropertiesTids[1]]

					-- determine if the map has been decoded or not
					local decoded = CourseMapWindow.DecodedTids[dt.PropertiesTids[1]]

					-- is this a treasure map?
					if mapLevel then

						-- get the map type
						local typ = dt.PropertiesTidsParams[2]

						-- remove the # from the tid
						typ = wstring.gsub(typ, L"#", L"")

						-- create the map name
						local mapName = GetStringFromTid(CourseMapWindow.MapTypeTID[tonumber(typ)]) .. L" " .. GetStringFromTid(CourseMapWindow.TmapLevelToName[mapLevel])

						-- has the map been decoded yet?
						if not decoded then

							-- add the decoded tag
							mapName = mapName .. L"\n[" .. GetStringFromTid(1153580) .. L"]" -- Not Decoded
						end

						-- write the item name
						LabelSetText(ElementName, FormatProperly(mapName))

						-- is the map completed?
						if props[CourseMapWindow.MapCompletedTID] ~= nil then
	
							-- write "completed in the second line
							LabelSetText(ElementUses, FormatProperly(GetStringFromTid(1153582))) -- Completed

						else -- not completed map: we write the map name in the second line

							-- scan the properties
							for tid, data in pairs(props) do

								-- is this the map property?
								if CourseMapWindow.MapTID[tid] then
							
									-- get the hue
									hue = CourseMapWindow.MapTID[tid].hue

									-- write the map name in the second line
									LabelSetText(ElementUses, FormatProperly(GetStringFromTid(CourseMapWindow.MapTID[tid].tid)))	

									break
								end
							end
						end
					end
				end
					
				-- do we have the properties?
				if props then
					
					-- get the item type and write it down in the second line
					if props[1151488] then -- Minor Magic Item
						LabelSetText(ElementUses, wstring.trim(FormatProperly(GetStringFromTid(1151488))))
								
					elseif props[1151489] then -- Lesser Magic Item
						LabelSetText(ElementUses, wstring.trim(FormatProperly(GetStringFromTid(1151489))))
							
					elseif props[1151490] then -- Greater Magic Item
						LabelSetText(ElementUses, wstring.trim(FormatProperly(GetStringFromTid(1151490))))
								
					elseif props[1151491] then -- Major Magic Item
						LabelSetText(ElementUses, wstring.trim(FormatProperly(GetStringFromTid(1151491))))
								
					elseif props[1151492] then -- Lesser Artifact
						LabelSetText(ElementUses, wstring.trim(FormatProperly(GetStringFromTid(1151492))))
								
					elseif props[1151493] then -- Greater Artifact
						LabelSetText(ElementUses, wstring.trim(FormatProperly(GetStringFromTid(1151493))))
								
					elseif props[1151494] then -- Major Artifact
						LabelSetText(ElementUses, wstring.trim(FormatProperly(GetStringFromTid(1151494))))
								
					elseif props[1151495] then -- Legendary Artifact
						LabelSetText(ElementUses, wstring.trim(FormatProperly(GetStringFromTid(1151495))))
					end
				end
			end
					
			-- do we have uses?
			if (uses and ElementUses) then
				
				-- get the uses value
				local text = uses[1]

				-- update the uses label
				LabelSetText(ElementUses, FormatProperly(text))
			end

			-- show the name
			WindowSetShowing(ElementName, true)
								
			-- do we have an icon?
			if IsValidString(item.iconName)  then

				-- icon window name
				local elementIcon = windowName.."Item"..listIndex.."Icon"

				-- is the trap box changed?
				if (Interface.TrapBoxID == 0 and Interface.oldTrapBoxID == updateId) then
					Interface.oldTrapBoxID = nil
				end

				-- is the loot box changed? 
				if (Interface.LootBoxID == 0 and Interface.oldLootBoxID == updateId) then
					Interface.oldLootBoxID = nil
				end
				
				-- update the item icon with hue
				EquipmentData.UpdateItemIconWithHue(elementIcon, item, hue)
						
				-- get the parent window
				local parent = WindowGetParent(elementIcon)

				-- clear the icon position
				WindowClearAnchors(elementIcon)

				-- center the icon in position
				WindowAddAnchor(elementIcon, "topleft", parent, "topleft", 15 + ((45 - item.newWidth) / 2), 15 + ((45 - item.newHeight) / 2))
						
				-- show the icon
				WindowSetShowing(elementIcon, true)
			end
			
			-- get the slot position
			local w, h = LabelGetTextDimensions(ElementName)

			-- do we have the height?
			if h then
				
				-- initialize the total height
				local totalH = h

				-- do we have the uses?
				if ElementUses then
					
					-- get the uses dimensions
					local w1, h1 = LabelGetTextDimensions(ElementUses)

					-- add the uses height
					local totalH = h + h1
					
					-- get the top left anchor of the item name
					local point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (ElementName, 1)

					-- add the anchor offset to the height
					totalH = totalH + yOffs
							
					-- get the top left anchor of the uses
					point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (ElementUses, 1)

					-- add the anchor offset to the total height + a little margin
					totalH = totalH + yOffs + 10
							
					-- add some extra margin
					totalH = totalH + 20
				end
						
				-- is the total height less than 60?
				if totalH < 60 then

					-- set the height to 60
					totalH = 60
				end
						
				-- update the slot height
				WindowSetDimensions(windowName.."Item"..listIndex, 250, totalH)

				-- is this element coming before the last one?
				if listIndex < ContainerWindow.OpenContainers[containerId].numCreatedRows then

					-- line window name
					local slotLine = windowName.."Item"..listIndex.."Line"

					-- slot window name
					local slot = windowName.."Item"..listIndex

					-- does the slot line exist? we destroy it first
					if DoesWindowExist(slotLine) then
						DestroyWindow(slotLine)
					end

					-- create the line
					CreateWindowFromTemplate(slotLine, "ListLine", slot)

					-- clear the line position
					WindowClearAnchors(slotLine)

					-- anchor the line properly
					WindowAddAnchor(slotLine, "bottomleft", slot, "bottomleft", 10, 0)

					-- get the width of the slot
					local w = WindowGetDimensions(slot)

					-- resize the line properly
					WindowSetDimensions(slotLine, w - 20, 2)

					-- update the line alpha
					WindowSetAlpha(slotLine, 0.6)

					-- scale the line properly with the slot
					WindowSetScale(slotLine, WindowGetScale(slot))
				end
			end

		-- is this grid mode?
		elseif viewMode == "Grid" then

			-- slot window name
			local socket = windowName.."GridViewSocket"..gridIndex

			-- is the loot sort enabled?
			if isLoot then

				-- default item color
				local itemColor = Interface.Settings.Props_TITLE_COLOR

				-- do we have a different color from the loot sort? we use that
				if ContainerWindow.ContainerItems[containerId][updateId] and ContainerWindow.ContainerItems[containerId][updateId].color ~= nil then
					itemColor = ContainerWindow.ContainerItems[containerId][updateId].color
				end

				-- do we have a color that is not the default one?
				if itemColor and itemColor ~= Interface.Settings.Props_TITLE_COLOR then

				-- do we have a background? we hide it
				elseif DoesWindowExist(socket .. "BG") then
					WindowSetShowing(socket .. "BG", false)	
				end
			end

			-- do we have an icon?
			if IsValidString(item.iconName) then

				-- icon window name
				local elementIcon = windowName.."GridViewSocket"..gridIndex.."Icon"

				-- show the icon
				WindowSetShowing(elementIcon, true)

				-- icon to duplicate the icon for stackables
				local elementMultiIcon = windowName .. "GridViewSocket" .. gridIndex .. "IconMulti"
				
				-- is the icon window missing? we re-create the slots to be sure
				if not DoesWindowExist(elementIcon) then
					ContainerWindow.CreateGridViewSockets(windowName)
				end

				-- initialize a flag that indicates the treasure map is completed
				local tmapCompleted

				-- initialize a value that indicates the treasure map level
				local tmapLevel

				-- initialize the flag to determine if the map has been decoded or not
				local decoded

				-- is this a treasure map?
				if item.iconId == 5355 then

					-- acquire the item properties for the item
					local dt = Interface.GetItemPropertiesData(updateId, "Get treasure map properties for grid view" )

					-- initialize the props TID variable
					local props

					-- do we have the properties and is a treasure map?
					if dt and CourseMapWindow.TmapTID[dt.PropertiesTids[1]] then

						-- filling the TID props array
						props = ItemProperties.BuildParamsArray(dt, true)

						-- get the map level
						tmapLevel = L"Lv " .. towstring(CourseMapWindow.TmapTID[dt.PropertiesTids[1]])

						-- determine if the map has been decoded or not
						decoded = CourseMapWindow.DecodedTids[dt.PropertiesTids[1]]
					end
					
					-- do we have the properties?
					if props then
					
						-- get the completed flag
						tmapCompleted = props[CourseMapWindow.MapCompletedTID] ~= nil

						-- only map that needs to be completed will show custom colors
						if not tmapCompleted then

							-- scan the properties
							for tid, data in pairs(props) do
							
								-- is this a treasure map?
								if CourseMapWindow.MapTID[tid] then
							
									-- get the hue
									hue = CourseMapWindow.MapTID[tid].hue

									break
								end
							end
						end
					end
				end
						
				-- draw the icon with the hue
				EquipmentData.UpdateItemIconWithHue(elementIcon, item, hue)

				-- quantity for the grid slot name
				local gridViewQTALabel = windowName .. "GridViewSocket" .. gridIndex .. "Quantity"

				-- uses for the grid slot name
				local gridViewUsesLabel = windowName .. "GridViewSocket" .. gridIndex .. "Uses"

				-- set quantity and uses to empty string
				LabelSetText(gridViewQTALabel, L"")
				LabelSetText(gridViewUsesLabel, L"")
						
				-- is that a stackable item?
				if (item.quantity ~= nil and item.quantity > 1) then 

					-- update the quantity
					LabelSetText(gridViewQTALabel, Knumber(item.quantity))
							
					-- is this NOT gold or silver? we apply the icon to the multi slot
					if item.objectType ~= 3821 and item.objectType ~= 3824 then
						EquipmentData.UpdateItemIconWithHue(elementMultiIcon, item, hue)
					end

				-- do we have uses?
				elseif uses then

					-- show the uses using K instead of thousands zeroes
					LabelSetText(gridViewUsesLabel, Knumber(uses[2]))

				-- do we have the treasure map level? (only if not completed)
				elseif tmapLevel and not tmapCompleted then

					-- has the map been decoded yet?
					if decoded then

						-- show the treasure map level
						LabelSetText(gridViewQTALabel, tmapLevel)

					else -- show the treasure map level and ND (not decoded)
						LabelSetText(gridViewQTALabel, tmapLevel .. L"ND")
					end
				end
			end
		end
	end
end

function ContainerWindow.UpdateUses(id)
	
	-- do we have a valid id?
	if not IsValidID(id) then
		return
	end

	-- is the container laggy or the record is not available?
	if not ContainerWindow.OpenContainers[id] or ContainerWindow.OpenContainers[id].laggy then
		return
	end

	-- uses array missing? we create it
	if not ContainerWindow.CurrentUses[id] then
		ContainerWindow.CurrentUses[id] = {}
	end

	-- getting the container data
	local data = Interface.GetContainersData(id, true)
	
	-- do we have the container data?
	if Interface.VerifyContainer(id, data) then
		
		-- get the number of items in the container
		local numItems = data.numItems

		-- do we have items in the container?
		if numItems > 0 then

			-- scanning all items
			for i = 1, numItems  do
				
				-- get the object ID
				local objectId = data.ContainedItems[i].objectId
				
				-- do we have a valid ID?
				if not IsValidID(objectId) then
					continue
				end

				-- get the item properties
				local props = Interface.GetItemPropertiesData(objectId, "container items uses scan")

				-- get the TID array for properties
				local params = ItemProperties.BuildParamsArray(props)

				-- do we have the item properties?
				if props then

					-- scan the TIDs in search of charges and uses				
					for tid, _ in pairs(params) do

						-- is this a charges TID?
						if ItemPropertiesInfo.ChargesTid[tid] then

							-- get the token ID for this TID
							local token = ItemPropertiesInfo.ChargesTid[tid]

							-- get the charges value
							local val = tostring(params[tid][token])
						
							-- update the charges in the array
							ContainerWindow.CurrentUses[id][objectId] = { ReplaceTokens(GetStringFromTid(1060741), { StringUtils.AddCommasToNumber(val) }), tonumber(val) } 

							-- update the item
							ContainerWindow.UpdateObject("ContainerWindow_" .. id, objectId)
							break

						-- get the number of spells
						elseif tid == 1042886 then -- ~1_NUMBERS_OF_SPELLS~ Spells

							-- get the number of spells token ID
							local token = ItemPropertiesInfo.ChargesTid[tid]

							-- get the number of spells
							local val = tostring(params[tid][1])
						
							-- update the array
							ContainerWindow.CurrentUses[id][objectId] = { ReplaceTokens(GetStringFromTid(1042886), { StringUtils.AddCommasToNumber(val) }), tonumber(val) } 

							-- update the item
							ContainerWindow.UpdateObject("ContainerWindow_"..id, objectId)
							break
						end
					end
				end
			end
		end
	end
		
	ContainerWindow.LastUsesDelta[id] = 0	
end

function ContainerWindow.UpdateUsesByID(id, objectId)
		
	-- do we have a valid ID and object?
	if not IsValidID(id) or not IsValidID(objectId) then
		return
	end

	-- does the array exist?
	if not ContainerWindow.CurrentUses[id] then
		return
	end

	-- get the item properties
	local props = Interface.GetItemPropertiesData(objectId, "container item uses scan")

	-- get the params of TID
	local params = ItemProperties.BuildParamsArray(props)

	-- do we have the properties?
	if not props then
		return
	end
	
	-- scan the properties
	for tid, _ in pairs(params) do
		
		-- is that the TID for the charges?
		if ItemPropertiesInfo.ChargesTid[tid] then

			-- get the token for this TID
			local token = ItemPropertiesInfo.ChargesTid[tid]

			-- get the charges value
			local val = tostring(params[tid][token])
			
			-- update the array
			ContainerWindow.CurrentUses[id][objectId] = { ReplaceTokens(GetStringFromTid(tid), { StringUtils.AddCommasToNumber(val) }), tonumber(val) } 
			break
		end
	end
	
	-- update the object
	ContainerWindow.UpdateObject("ContainerWindow_" .. id, objectId)	
end

function ContainerWindow.GetUses(objectId, contId)

	-- do we have a valid ID and object?
	if not IsValidID(contId) or not IsValidID(objectId) then
		return
	end

	-- do we have the uses for this container and it's not laggy?
	if not ContainerWindow.CurrentUses[contId] or ContainerWindow.OpenContainers[contId].laggy then
		return
	end
	
	-- return the uses for the object requested
	return ContainerWindow.CurrentUses[contId][objectId]
end

function ContainerWindow.ToggleView()
	
	-- container window name
	local windowName = WindowUtils.GetActiveDialog()

	-- does the window really exist?
	if not DoesWindowExist(windowName) then
		return
	end

	-- get the container ID
	local id = WindowGetId(windowName)
	
	-- do we have a valid id?
	if not IsValidID(id) then
		return
	end

	-- getting the container data
	local containerData = Interface.GetContainersData(id, true)

	-- do we have the container data?
	if not Interface.VerifyContainer(id, containerData) then
		return
	end
	
	-- is the container snooped?
	if containerData.isSnooped == false then
		
		-- do we have more slot than the client can handle? (only list view and free form available)
		if (ContainerWindow.OpenContainers[id].maxSlots > ContainerWindow.MaxSlotsPerGrid or containerData.numItems > ContainerWindow.MaxSlotsPerGrid) then

			-- if we have list view, we switch to free form
			if (ContainerWindow.ViewModes[id] == "List") then 
				ContainerWindow.ViewModes[id] = "Freeform"
				ContainerWindow.SetLegacyContainer( id, true )
				
			-- if we have free form we switch to list view
			elseif (ContainerWindow.ViewModes[id] == "Freeform") then 
				ContainerWindow.ViewModes[id] = "List"
				ContainerWindow.CreateContainer(windowName, true)
			end

		else -- decent amount of items 

			-- if we have grid we switch to list
			if (ContainerWindow.ViewModes[id] == "Grid") then
				ContainerWindow.ViewModes[id] = "List"
				ContainerWindow.CreateContainer(windowName, true)
				
				-- is this NOT grid legacy? we have to fix the size (same as we did when we created the slots)
				if not Interface.Settings.GridLegacy then
					local minWidth = ContainerWindow.List_MinWidth
					local minHeight = minWidth + (minWidth * 0.15)
					WindowSetDimensions(windowName, minWidth, minHeight)
					ContainerWindow.UpdateListView(id)
				end
				
			-- if we have list view, we switch to free form
			elseif (ContainerWindow.ViewModes[id] == "List") then 
				ContainerWindow.ViewModes[id] = "Freeform"
				ContainerWindow.SetLegacyContainer( id, true )
				
			-- if we have free form we switch to grid
			elseif (ContainerWindow.ViewModes[id] == "Freeform") then 
				ContainerWindow.ViewModes[id] = "Grid"
				ContainerWindow.CreateContainer(windowName, true)
				
				-- is this NOT grid legacy? we have to fix the size (same as we did when we created the slots)
				if not Interface.Settings.GridLegacy then
					local minColumns = 5
					local grid_view_this = windowName.."GridView"
					local scrollbarWidth = WindowGetDimensions(grid_view_this.."Scrollbar")
					
					local slotSize = WindowGetDimensions(windowName.."GridViewSocket1")
							
					local minSize = (slotSize * minColumns) - scrollbarWidth
					if ContainerWindow.Grid_MinWidth * WindowGetScale(windowName) ~= minSize then
						ContainerWindow.Grid_MinWidth = minSize
					end
					
					minWidth = ContainerWindow.Grid_MinWidth
					minHeight = minWidth + slotSize - 10
					WindowSetDimensions(windowName, minWidth, minHeight)
					ContainerWindow.UpdateGridViewSockets(id)
				end
			end
		end
		
		-- is this the player backpack?
        if (id == ContainerWindow.PlayerBackpack) then

			-- save backpack view mode
			Interface.SaveSetting("BackpackView", ContainerWindow.ViewModes[id])

		-- is this a loot corpse container?
		elseif (ContainerWindow.OpenContainers[id] and ContainerWindow.OpenContainers[id].isCorpse == true) then

			-- save the loot view mode
			SystemData.Settings.Interface.defaultCorpseMode = ContainerWindow.ViewModes[id]

		-- is this a player vendor container?
		elseif ContainerWindow.OpenContainers[id].isPlayerVendor then

			-- update the player vendor mode
			Interface.Settings.playerVendorView = ContainerWindow.ViewModes[id]

			-- save the player vendor view mode
			Interface.SaveSetting("playerVendorView", ContainerWindow.ViewModes[id])

		else -- save the view mode for any other container
			Interface.SaveSetting(windowName .. "ViewMode", ContainerWindow.ViewModes[id])
		end

		-- change the anchoring of the bank balance frame
		ContainerWindow.FixBankboxBalanceAnchors(id)
		
		-- update the container contents
		ContainerWindow.UpdateContents(id)
		
		-- save the settings
		SettingsWindow.UpdateSettings()
    end
end

function ContainerWindow.FixBankboxBalanceAnchors(id)
	
	-- is this the bankbox?
	if id ~= ContainerWindow.PlayerBank then
		return
	end

	-- container window name
	local this = "ContainerWindow_" .. ContainerWindow.PlayerBank

	-- is this the player bankbox?
	if DoesWindowExist(this) then

		-- bank balance mask window name
		local maskName = "ContainerBankMaskTemplate"

		-- clearing the slot position
		WindowClearAnchors(maskName)

		-- anchor the bank mask to the botom of the content label
		WindowAddAnchor(maskName, "bottom", this .. "Content", "top", 0, 10)
	end
end

function ContainerWindow.GetItemIDForIndex(containerId, idx)
	
	-- do we have a valid id?
	if not IsValidID(containerId) or not IsValidID(idx) then
		return 0
	end

	-- getting the container data
	local containerData = Interface.GetContainersData(containerId, false)

	-- do we have the container data?
	if not Interface.VerifyContainer(containerId, containerData) then
		return 0
	end

	-- container items list
	local containedItems = containerData.ContainedItems

	-- do we have the container items?
	if containedItems then
				
		-- we scan the items
		for index, item in pairsByIndex(containedItems) do
             
			-- is the grid index the one we are looking for?
			if (item.gridIndex == idx) then
				return item.objectId
			end
		end
	end
	return 0
end

function ContainerWindow.GetSlotNumFromGridIndex(containerId, gridIndex)

	-- do we have a valid id?
	if not IsValidID(containerId) or not IsValidID(gridIndex) then
		return
	end

	-- getting the container data
	local containerData = Interface.GetContainersData(containerId, true)

	-- do we have the container data?
	if not Interface.VerifyContainer(containerId, containerData) then
		return gridIndex
	end

	-- is the container in grid mode?
    if ContainerWindow.ViewModes[containerId] == "Grid" then

		-- get the container items
        local containedItems = containerData.ContainedItems

		-- do we have the container items?
        if containedItems then
			
			-- we scan the items
            for index, item in pairsByIndex(containedItems) do

			   -- is the grid index the one we are looking for?
               if (item.gridIndex == gridIndex) then
		            return index
	            end
            end
        end
	elseif ContainerWindow.ViewModes[containerId] == "List" then

		-- is the loot sort enabled and is not grid view mode?
		if ButtonGetPressedFlag( "ContainerWindow_" .. containerId .. "LootSort" )  then

			-- get the container items number
			local numItems = containerData.numItems

			-- container items list
			local containedItems = containerData.ContainedItems

			-- do we have the container items?
			if containedItems then
				
				local idx = 0

				-- we scan the items
				for index, item in pairsByIndex(containedItems) do
               
				   -- is the grid index the one we are looking for?
				   if (item.gridIndex == gridIndex) then
						idx = index
						break
					end
				end

				-- scan the container items again to get the correct index for the list
				for i = 1, numItems do

					-- current item data
					local item = containedItems[i]

					-- is this the slot we're looking for?
					if idx == item.gridIndex then
					
						return item.gridIndex
					end
				end
			end
		end
		return gridIndex

    else -- since we don't have any data we return the current grid index we have...
        return gridIndex
    end
end

function ContainerWindow.OnItemClicked(flags)

	-- container window name
	local dialog = WindowUtils.GetActiveDialog()

	-- does the window really exist?
	if not DoesWindowExist(dialog) then
		return
	end

	local containerId = WindowGetId(dialog)

	-- do we have a valid id?
	if not IsValidID(containerId) then
		return
	end

	-- current slot window
	local slot = SystemData.ActiveWindow.name

	-- does the slot really exist?
	if not DoesWindowExist(slot) then
		return
	end

	-- current slot index
	local index = WindowGetId(slot)

	-- do we have a valid id?
	if not IsValidID(index) then
		return
	end

	-- getting the container data
	local containerData = Interface.GetContainersData(containerId, true)

	-- do we have the container data?
	if not Interface.VerifyContainer(containerId, containerData) then
		return
	end

	-- get the ID of the parent container
	local parentContainerId = GetParentContainer(containerId)

	-- is this container inside a trade container?
	if TradeWindow.IsTradeContainer(parentContainerId) then

		-- prevent the items from being moved or targeted
		return
	end
	
	-- get the current view mode for the container
	local viewMode = ContainerWindow.ViewModes[containerId]	

	-- is the loot sort enabled?
	local isLoot = ButtonGetPressedFlag( dialog .. "LootSort" )
	
	-- get the correct slot index (included sorting)
	local slotNum = ContainerWindow.GetSlotNumFromGridIndex(containerId, index)

	-- container items list
	local containedItems = containerData.ContainedItems

	-- do we have a slot number and something in the slot?
    if (IsValidID(slotNum) and containedItems and containedItems[slotNum] ~= nil) then

		-- get the item id
		local objectId = containedItems[slotNum].objectId

		-- do we have the cursor target?
	    if DoesPlayerHasCursorTarget() then

			-- target the item
			HandleSingleLeftClkTarget(objectId)

		-- are we dragging something?
	    elseif (SystemData.DragItem.DragType == SystemData.DragItem.TYPE_NONE) then
			
			-- get the item data
			local itemData = Interface.GetObjectInfoData(objectId)

			-- is CONTROL presse and the player has the item?
			if flags == WindowUtils.ButtonFlags.CONTROL and DoesPlayerHaveItem(objectId) then

				-- is the item a reagent?
				if ItemsInfo.Reagents[itemData.objectType] or itemData.objectType == 3821 then

					-- get the item object tyep
					local id = itemData.objectType

					-- for gold, we pull the stat instead
					if itemData.objectType == 3821 then
						id = 10
					end

					-- get the item hue
					local hue = itemData.hueId

					-- get the a new quickstat label id
					local lblid = QuickStats.GetId()

					-- the quickstat label window name
					local label = "QuickStat_" .. lblid

					-- verify there isn't already a label for the same item type
					local l = QuickStats.DoesLabelExist(id, true, hue)

					-- if the ID is valid and the window exist
					if IsValidID(l) and DoesWindowExist("QuickStat_" .. l) then

						-- update the label window name with the existing one
						label = "QuickStat_" .. l

					else
						-- initialize the label record
						local lab = {objectType = id, minQuantity = 20, hue = hue, frame = true, icon = true, name = true, cap = true, locked = false, BGColor = {r = 0, g = 0, b = 0}, frameColor = {r = 255, g = 255, b = 255}, valueTextColor = {r = 255, g = 255, b = 255}, nameTextColor = {r = 243, g = 227, b = 49}}

						-- for gold, we have to pull the stat instead so we reset the stuff we don't need for the stat
						if itemData.objectType == 3821 then
							lab.minQuantity = 0
							lab.hue = nil
							lab.objectType = nil
							lab.attribute = id
						end

						-- add the record to the labels array
						table.insert(QuickStats.Labels, lblid, lab)
						
						-- create the quickstat label
						CreateWindowFromTemplate(label, "QuickStatTemplate", "Root")

						-- set the label ID
						WindowSetId(label, lblid)

						-- update the label stats
						QuickStats.UpdateLabel(label)

						-- save the label
						QuickStats.Save(label)

						-- enable the snap mode to the label
						SnapUtils.SnappableWindows[label] = true
					end

					-- forcing the label to follow the mouse cursor
					WindowUtils.FollowMouseCursor(label, 380, 30, 100, -15, false, false, true)

					-- mark the label as in movement
					QuickStats.InMovement[label] = true

					-- setting the label movable
					WindowSetMoving(label, true)

				else -- create a blockbar for the item
					local blockBar = HotbarSystem.SpawnNewHotbar(_, 1, true)
					
					local actionType = SystemData.UserAction.TYPE_USE_ITEM
					
					-- add the item to the blockbar
					HotbarSystem.SetActionOnHotbar(actionType, objectId, itemData.iconId, blockBar,  1)
					
					-- forcing the blockbar to follow the mouse cursor
					WindowUtils.FollowMouseCursor("Hotbar" .. blockBar, Hotbar.BUTTON_SIZE, Hotbar.BUTTON_SIZE, -30, -15, false, true, true)

					-- setting the window movable
					WindowSetMoving("Hotbar" .. blockBar, true)
				end

			else -- drag the item
				DragSlotSetObjectMouseClickData(objectId, SystemData.DragSource.SOURCETYPE_CONTAINER)
				
				-- update the container
				ContainerWindow.UpdateContents(containerId)
			end
	    end
	end
end

function ContainerWindow.OnItemRelease()

	-- are we dragging an item?
	if SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM then

		-- container window name
		local dialog = WindowUtils.GetActiveDialog()

		-- does the window really exist?
		if not DoesWindowExist(dialog) then
			return
		end

		local containerId = WindowGetId(dialog)

		-- do we have a valid id?
		if not IsValidID(containerId) then
			return
		end

		-- current slot window
		local slotWindow = SystemData.ActiveWindow.name

		-- does the slot really exist?
		if not DoesWindowExist(slotWindow) then
			return
		end

		-- current grid slot
		local gridIndex = WindowGetId(slotWindow)

		-- getting the container data
		local containerData = Interface.GetContainersData(containerId, true)

		-- do we have the container data?
		if not Interface.VerifyContainer(containerId, containerData) then
			return
		end

		-- get the ID of the parent container
		local parentContainerId = GetParentContainer(containerId)

		-- is this container inside a trade container?
		if TradeWindow.IsTradeContainer(parentContainerId) then

			-- prevent the item from being dropped
			return
		end

		-- get the current view mode for the container
		local viewMode = ContainerWindow.ViewModes[containerId]	

		-- is the loot sort enabled?
		local isLoot = ButtonGetPressedFlag( WindowUtils.GetActiveDialog() .. "LootSort" )
		
		-- container items list
		local containedItems = containerData.ContainedItems

		-- get the correct slot index (included sorting)
		local slotNum = ContainerWindow.GetSlotNumFromGridIndex(containerId, gridIndex)
		
		-- initialize the slot item ID
		local slot

		-- do we have the container items?
        if (containedItems and slotNum) then
			
			-- get the item info
            slot = containedItems[slotNum]
        end
		
		-- this is necessary otherwise the internal function does not recognize the slot id.
		SystemData.ActiveContainer.SlotsWide = ContainerWindow.OpenContainers[containerId].slotsWide
		SystemData.ActiveContainer.SlotsHigh = ContainerWindow.OpenContainers[containerId].slotsHigh
		
		-- no intem info? we clicked an empty slot, so we drop the item there
		if (not slot) then
		
			-- drop the item in the selected slot
			DragSlotDropObjectToContainer(containerId, gridIndex)

			-- update the item
			ContainerWindow.UpdateObject(dialog, SystemData.DragItem.itemId)

		else
			-- get the clicked object ID
			local clickedObjId = slot.objectId

			-- is the clicked object a trapbox?
			if (clickedObjId ~= Interface.TrapBoxID) then

				-- is the container in grid view mode?
				if ContainerWindow.ViewModes[containerId] == "Grid" then

					-- drop the item on the item in the slot (if it's a container will go inside)
					DragSlotDropObjectToObjectAtIndex(clickedObjId, gridIndex)

					-- drop container name
					local dropContainer = "ContainerWindow_"..clickedObjId

					-- does the container is opened?
					if DoesWindowExist(dropContainer) then
						
						-- update the item in the other container
						ContainerWindow.UpdateObject(dropContainer, SystemData.DragItem.itemId)

					else -- try to update the item in this container
						ContainerWindow.UpdateObject(dialog, SystemData.DragItem.itemId)
					end

				else -- drop the item in the first empty space it finds 
					DragSlotDropObjectToContainer(containerId, 0)

					-- update the item in this container
					ContainerWindow.UpdateObject(dialog, SystemData.DragItem.itemId)
				end
			end
        end

		-- we schedule the uses update in 2 seconds from the drop
        Interface.AddTodoList({name = "container item drop uses update", func = function() ContainerWindow.UpdateUsesByID(containerId, SystemData.DragItem.itemId) end, time = Interface.TimeSinceLogin + 2})
	end
end

function ContainerWindow.TargetContainer()

	-- do we have a cursor target?
	if DoesPlayerHasCursorTarget() then
		
		-- container window name
		local dialog = WindowUtils.GetActiveDialog()

		-- does the window really exist?
		if not DoesWindowExist(dialog) then
			return
		end

		-- get the current container ID
		local containerId = WindowGetId(dialog)
		
		-- do we have a valid id?
		if not IsValidID(containerId) then
			return
		end

		-- target the container
		HandleSingleLeftClkTarget(containerId)
	end
end

function ContainerWindow.OnContainerRelease()

	-- are we dragging an item?
	if (SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM) then	

		-- container window name
		local dialog = WindowUtils.GetActiveDialog()

		-- does the window really exist?
		if not DoesWindowExist(dialog) then
			return
		end

		-- get the current container ID
		local containerId = WindowGetId(dialog)

		-- do we have a valid id?
		if not IsValidID(containerId) then
			return
		end

		-- grid window name
		local grid_view_this = dialog .. "GridView"

		-- is the grid visible?
		if WindowGetShowing(grid_view_this) then

			-- get the current mouse position
			local mouseX = SystemData.MousePosition.x
			local mouseY = SystemData.MousePosition.y

			-- this window is an area whre you cannot drop items into
			local noDropZone = dialog .. "BlockDropUnderGrid"

			-- get the top-left position of the no-drop-zone
			local startX, startY = WindowGetScreenPosition(noDropZone)

			-- get the size of the no-drop-zone
			local w, h = WindowGetDimensions(noDropZone)

			-- calculate the bottom-left position of the no-drop-zone
			local endX = startX + w
			local endY = startY + h
		
			-- is the mouse cursor inside the no-drop-zone? then we DO NOT drop the item
			if (mouseX >= startX and mouseX <= endX) and (mouseY >= startY and mouseY <= endY) then
				return
			end
		end

		-- we drop the item inside the container
		DragSlotDropObjectToContainer(containerId, 0)
	end
end

function ContainerWindow.OnItemDblClicked()

	-- container window name
	local dialog = WindowUtils.GetActiveDialog()

	-- does the window really exist?
	if not DoesWindowExist(dialog) then
		return
	end

	-- get the container ID
	local containerId = WindowGetId(dialog)

	-- do we have a valid id?
	if not IsValidID(containerId) then
		return
	end

	-- current slot window
	local slot = SystemData.ActiveWindow.name

	-- does the slot really exist?
	if not DoesWindowExist(slot) then
		return
	end

	-- current slot index
	local index = WindowGetId(slot)

	-- do we have a valid id?
	if not IsValidID(index) then
		return
	end

	-- getting the container data
	local containerData = Interface.GetContainersData(containerId, true)

	-- do we have the container data?
	if not Interface.VerifyContainer(containerId, containerData) then
		return
	end

	-- get the ID of the parent container
	local parentContainerId = GetParentContainer(containerId)

	-- is this container inside a trade container?
	if TradeWindow.IsTradeContainer(parentContainerId) then

		-- prevent the items from being moved or targeted
		return
	end

	-- get the correct slot index (included sorting)
	local slotNum = ContainerWindow.GetSlotNumFromGridIndex(containerId, index)

	-- container items list
	local containedItems = containerData.ContainedItems
	
	-- do we have a slot number and something in the slot?
    if (IsValidID(slotNum) and containedItems and containedItems[slotNum] ~= nil) then
	   
		-- get the item id
		local objectId = containedItems[slotNum].objectId

		-- get the object properties
		local dt = Interface.GetItemPropertiesData( objectId, "Get item intensity info for listview" )

		-- initialize the TID properties
		local props

		-- do we have the properties?
		if dt then
			
			-- get the TID for the properties
			props = ItemProperties.BuildParamsArray( dt, true )
		end

		-- is this a container in a transfer crate?
		if	props and (
			props[1062824] or	-- Your Bank Box
			props[1062825] or	-- Your Stabled Pets
			props[1062826] or	-- Your Worn Equipment
			props[1062827] or	-- Your Backpack
			props[1062905])		-- Your Controlled Pets
		then 

			-- unpack the double-clicked crate
			ContainerWindow.UnpackTransferCrate(objectId)

		else -- use the item otherwise
			UserActionUseItem(objectId, false)
			
			-- store the last object data
			ContainerWindow.LastItemData = {lastObj = objectId, currCont = containerId}

			-- update the item
			ContainerWindow.UpdateObject(dialog, objectId)
		end
	end
end

function ContainerWindow.UnpackTransferCrate(objectId)
	
	-- execute unpack crate on the transfer crate
	ContextMenu.RequestContextAction(objectId, ContextMenu.DefaultValues.UnpackTransferCrate )
end

function ContainerWindow.OnItemRButtonUp()
end

function ContainerWindow.ItemMouseOver()

	-- container window name
	local dialog = WindowUtils.GetActiveDialog()

	-- does the window really exist?
	if not DoesWindowExist(dialog) then
		return
	end

	-- get the container ID
	local containerId = WindowGetId(dialog)

	-- do we have a valid id?
	if not IsValidID(containerId) then
		return
	end

	-- get the current window name
	local this = SystemData.ActiveWindow.name
	
	-- does the window really exist?
	if not DoesWindowExist(this) then
		return
	end

	-- get the current window ID
	local index = WindowGetId(this)

	-- do we have a valid id?
	if not IsValidID(index) then
		return
	end

	-- getting the container data
	local containerData = Interface.GetContainersData(containerId, true)

	-- do we have the container data?
	if not Interface.VerifyContainer(containerId, containerData) then
		return
	end

	-- get the container items
	local containedItems = containerData.ContainedItems

	-- get the correct slot index (included sorting)
    local slotNum = ContainerWindow.GetSlotNumFromGridIndex(containerId, index)

	-- get the current view mode for the container
	local viewMode = ContainerWindow.ViewModes[containerId]	

	-- is the loot sort enabled?
	local isLoot = ButtonGetPressedFlag( dialog .. "LootSort" )
	
    -- do we have a slot number and something in the slot?
    if (IsValidID(slotNum) and containedItems and containedItems[slotNum] ~= nil) then
	    
		-- get the item id
		local objectId = containedItems[slotNum].objectId

		-- is the object ID valid?
		if IsValidID(objectId) then

			-- are we already seeing the item properties of that item?
			if objectId ~= WindowGetId("ItemProperties") and WindowGetShowing("ItemProperties") then

				-- reset the item properties array
				ItemProperties.ResetWindowDataPropertiesFull()
			end
			
			-- creating the item properties info data
		    local itemData = 
			{ 
				windowName = this,
				itemId = objectId,
		    	itemType = WindowData.ItemProperties.TYPE_ITEM,
		    	detail = ItemProperties.DETAIL_LONG 
			}

			-- showing the item properties
		    ItemProperties.SetActiveItem(itemData)
	    end
	end
end

ContainerWindow.JustPickedUp = {}
function ContainerWindow.OnItemGet(flags)
	
	-- container window name
	local dialog = WindowUtils.GetActiveDialog()

	-- does the window really exist?
	if not DoesWindowExist(dialog) then
		return
	end
	
	-- get the container ID
	local containerId = WindowGetId(dialog)

	-- do we have a valid id?
	if not IsValidID(containerId) then
		return
	end

	-- current slot window
	local slot = SystemData.ActiveWindow.name

	-- does the slot really exist?
	if not DoesWindowExist(slot) then
		return
	end

	-- current slot index
	local index = WindowGetId(slot)

	-- do we have a valid id?
	if not IsValidID(index) then
		return
	end
	
	-- getting the container data
	local containerData = Interface.GetContainersData(containerId, true)

	-- do we have the container data?
	if not Interface.VerifyContainer(containerId, containerData) then
		return
	end
	
	-- get the current view mode for the container
	local viewMode = ContainerWindow.ViewModes[containerId]	

	-- is the loot sort enabled?
	local isLoot = ButtonGetPressedFlag( dialog .. "LootSort" )
		
	-- container items list
	local containedItems = containerData.ContainedItems

	-- get the correct slot index (included sorting)
	local slotNum = ContainerWindow.GetSlotNumFromGridIndex(containerId, index)
	
	-- do we have a slot number and something in the slot?
    if (IsValidID(slotNum) and containedItems and containedItems[slotNum] ~= nil) then
		
		-- get the item id
		local objectId = containedItems[slotNum].objectId
		
		-- do we have a valid object ID?
		if IsValidID(objectId) then

			-- get the item data
			local itemData = Interface.GetObjectInfoData(objectId)
			
			-- is this a player vendor container?
			if ContainerWindow.OpenContainers[containerId].isPlayerVendor then
				RequestContextMenu(objectId)

			-- is CONTROL presse and is a stack of more than 1 items?
			elseif flags == WindowUtils.ButtonFlags.CONTROL and GetItemAmount(objectId) > 1 then
				
				-- flag to drag 1
				ContainerWindow.DragOne = true

				-- disable temporarily the hold shift to unstack
				ContainerWindow.HoldShiftBackup = SystemData.Settings.GameOptions.holdShiftToUnstack
				SystemData.Settings.GameOptions.holdShiftToUnstack = false
				UserSettingsChanged()

				-- begin to drag the item (the rest is handle in the drag one function)
				DragSlotSetObjectMouseClickData(objectId, SystemData.DragSource.SOURCETYPE_CONTAINER)

			-- is CONTROL presse and is a stack of more than 1 items?
			elseif flags == WindowUtils.ButtonFlags.ALT and GetItemAmount(objectId) > 1 then
				
				-- flag to drag half amount
				ContainerWindow.DragHalf = math.floor(GetItemAmount(objectId) / 2)

				-- disable temporarily the hold shift to unstack
				ContainerWindow.HoldShiftBackup = SystemData.Settings.GameOptions.holdShiftToUnstack
				SystemData.Settings.GameOptions.holdShiftToUnstack = false
				UserSettingsChanged()

				-- begin to drag the item (the rest is handle in the drag one function)
				DragSlotSetObjectMouseClickData(objectId, SystemData.DragSource.SOURCETYPE_CONTAINER)

			-- does the player has the item?
			elseif not DoesPlayerHaveItem(objectId) then
				
				-- can we pick up items?
				if (ContainerWindow.CanPickUp == true) then
					
					-- is there no loot box set or the item is gold?
					if (Interface.LootBoxID == 0 or itemData.objectType == 3821) then
						
						-- move the item into the backpack
						DragSlotAutoPickupObject(objectId)

					else -- move the item inside the loot box
						MoveItemToContainer(objectId, itemData.quantity, Interface.LootBoxID)
					end

					-- flag that we picked up something with quickloot so the container won't close
					ContainerWindow.JustPickedUp[containerId] = Interface.TimeSinceLogin + 1

				else -- we can't pick up the item
					PrintTidToChatWindow(1045157, 1) -- You must wait to perform another action.
				end
			
			else -- get the item context menu
				RequestContextMenu(objectId)
			end
		end
	end
end

function ContainerWindow.CloseDialog()

	-- container window name
	local dialog = WindowUtils.GetActiveDialog()

	-- does the window really exist?
	if not DoesWindowExist(dialog) then
		return
	end

	-- get the container ID
	local containerId = WindowGetId(dialog)

	-- have we just used the quick loot on this container?
	if not ContainerWindow.CanPickUp and ContainerWindow.JustPickedUp[containerId] then
		return
	end

	-- get the clicked window
	local win = SystemData.ActiveWindow.name

	-- does the window really exist?
	if not DoesWindowExist(win) then
		return
	end

	-- if the clicked window is the container window, we close the container
	if win == dialog then
		
		-- clear item properties
		ItemProperties.ClearMouseOverItem()

		-- close dialog
		UO_DefaultWindow.CloseDialog()
	end
end

function ContainerWindow.UpdateContainerTimer(timePassed)

	-- container window name
	local this = SystemData.ActiveWindow.name

	-- does the window really exist?
	if not DoesWindowExist(this) then
		return
	end

	-- get the container ID
	local id = WindowGetId(this)

	-- do we have a valid id?
	if not IsValidID(id) then
		return
	end

	-- getting the container data
	local data = Interface.GetContainersData(id, true)

	-- is the container data missing, or the container in update or waiting for items?
	if (not Interface.VerifyContainer(id, data) or ContainerWindow.OpenContainers[id].inUpdate or ContainerWindow.waitItems[id]) then
		return
	end

	-- update the container anchors
	WindowForceProcessAnchors(this)

	-- scan all the items marked as finders keepers
	for itemId, _ in pairs(ContainerWindow.FindersKeepersActiveItems) do
		
		-- is the item been looted?
		if DoesPlayerHaveItem(itemId) then

			-- remove the item from the list
			ContainerWindow.FindersKeepersActiveItems[itemId] = nil
		end
	end
		
	-- is this the transfer crate?
	if (data.containerName and data.containerName == L"Transfer Crate") or ContainerWindow.OpenContainers[id].TransferCrate then

		-- is the crate empty?
		if not data.ContainedItems or #data.ContainedItems <= 0 then

			-- we close the container
			DestroyWindow(this)
			return
		end
	end

	-- is it time to update the container? (loot need to be limited in the update frequency or there will be severe lag)
	if ContainerWindow.OpenContainers[id].dirty and (ContainerWindow.OpenContainers[id].LastUpdate and ContainerWindow.OpenContainers[id].LastUpdate <= Interface.TimeSinceLogin) then	

		-- update the container contents
		ContainerWindow.UpdateContents(id)

		-- is the container search active for this container?
		if (ContainerSearch.Container == id) then		

			-- update the container search items list
			ContainerSearch.UpdateList()
		end	
	end	

	-- list view window name
	local list_view_this = this.."ListView"     

	-- update the scrollable area
	ScrollWindowUpdateScrollRect(list_view_this) 
end

function ContainerWindow.UpdateContainers(timePassed)

	-- scan all open containers
	for id, value in pairs(ContainerWindow.OpenContainers) do
		
		-- getting the container data
		local data = Interface.GetContainersData(id, true)

		-- is the container data missing, or the container in update or waiting for items?
		if (not Interface.VerifyContainer(id, data) or ContainerWindow.OpenContainers[id].inUpdate or ContainerWindow.waitItems[id]) then
			continue
		end
		
		-- container window name
		local this = "ContainerWindow_"  .. id

		-- does the window really exist?
		if not DoesWindowExist(this) then
			
			-- unregister the container
			UnregisterWindowData(WindowData.ContainerWindow.Type, id)
			continue
		end

		-- update the container anchors
		WindowForceProcessAnchors(this)
		
		-- is this the transfer crate?
		if (data.containerName and data.containerName == L"Transfer Crate") or ContainerWindow.OpenContainers[id].TransferCrate then

			-- is the crate empty?
			if not data.ContainedItems or #data.ContainedItems <= 0 then

				-- we close the container
				DestroyWindow(this)
				break
			end
		end
		
		-- is it time to update the container? (loot need to be limited in the update frequency or there will be severe lag)
		if ContainerWindow.OpenContainers[id].dirty and (ContainerWindow.OpenContainers[id].LastUpdate and ContainerWindow.OpenContainers[id].LastUpdate <= Interface.TimeSinceLogin) then	

			-- update the container contents
			ContainerWindow.UpdateContents(id)

			-- is the container search active for this container?
			if (ContainerSearch.Container == id) then		

				-- update the container search items list
				ContainerSearch.UpdateList()
			end	
		end			
	end
end

function ContainerWindow.UsesUpdateCycle(timePassed)

	-- scan all active items with uses
	for id, value in pairs(ContainerWindow.LastUsesDelta) do
		
		-- if the container is free form we can skip it
		if (ContainerWindow.ViewModes[id] == "Freeform") then
			continue
		end

		-- does the container still exist?
		if not DoesWindowExist("ContainerWindow_"..id) then 

			-- nullify the uses array for the container
			ContainerWindow.LastUsesDelta[id] = nil
			ContainerWindow.CurrentUses[id] = nil
			continue
		end

		-- do we have the uses update timer?
		if (ContainerWindow.LastUsesDelta[id]) then 

			-- update the timer
			ContainerWindow.LastUsesDelta[id] = ContainerWindow.LastUsesDelta[id] + timePassed

			-- is it time for the update?
			if ContainerWindow.LastUsesDelta[id] > ContainerWindow.UsesRefreshRate then

				-- nullify the update time
				ContainerWindow.LastUsesDelta[id] = nil

				-- update the uses
				ContainerWindow.UpdateUses(id)
			end
		end		
	end
end

function ContainerWindow.WaitForItems(timePassed)

	-- scan all the containers waiting for items
	for id, _ in pairs(ContainerWindow.waitItems) do

		-- getting the container data
		local containerData = Interface.GetContainersData(id, true)

		-- do we have the container data?
		if Interface.VerifyContainer(id, containerData) then
			
			-- does this container have free form view mode?
			if (ContainerWindow.ViewModes[id] == "Freeform") then

				-- create free form container
				ContainerWindow.SetLegacyContainer( id )

			else -- create the container window
				ContainerWindow.CreateContainer("ContainerWindow_"..id)
			end

			-- no longer waiting
			ContainerWindow.waitItems[id] = nil
		end
	end
end

function ContainerWindow.DragOneItem(timePassed)
	
	-- are we unstacking 1 item?
	if ContainerWindow.DragOne then
		
		-- is the quantity selection visible yet?
		if (DoesWindowExist("GenericQuantityWindow")) then

			-- reset the drag one flag
			ContainerWindow.DragOne = false

			-- unstack 1 item
			DragSlotQuantityRequestResult(1)

			-- reset the hold shift to unstack setting
			SystemData.Settings.GameOptions.holdShiftToUnstack = ContainerWindow.HoldShiftBackup
			ContainerWindow.HoldShiftBackup = nil
			UserSettingsChanged()
		end	

	-- are we unstacking half items
	elseif (ContainerWindow.DragHalf) then

		-- is the quantity selection visible yet?
		if (DoesWindowExist("GenericQuantityWindow")) then
			
			-- dragging the half stack (amount specified when we started this)
			DragSlotQuantityRequestResult(ContainerWindow.DragHalf)

			-- reset the drag half value to nil
			ContainerWindow.DragHalf = nil

			-- reset the hold shift to unstack setting
			SystemData.Settings.GameOptions.holdShiftToUnstack = ContainerWindow.HoldShiftBackup
			ContainerWindow.HoldShiftBackup = nil
			UserSettingsChanged()
		end	
	end
end

function ContainerWindow.UpdatePickupTimer(timePassed)
	
	-- is the pickup timer started?
	if (ContainerWindow.CanPickUp == false) then

		-- update the timer
		ContainerWindow.TimePassedSincePickUp = ContainerWindow.TimePassedSincePickUp + timePassed

		-- is the time up?
		if (ContainerWindow.TimePassedSincePickUp >= ContainerWindow.PickupWaitTime) then

			-- enable the item pick up
			ContainerWindow.CanPickUp = true	
		end
	end

	-- scan all containers that we have quicklooted recently
	for id, time in pairs(ContainerWindow.JustPickedUp) do

		-- is the time up?
		if time <= Interface.TimeSinceLogin then
			
			-- reset the flag that indicates we picked up something with quickloot from a specific container
			ContainerWindow.JustPickedUp[id] = nil
		end
	end
end

function ContainerWindow.ViewButtonMouseOver()

	-- container window name
	local dialog = WindowUtils.GetActiveDialog()

	-- does the window really exist?
	if not DoesWindowExist(dialog) then
		return
	end
	
	-- get the container ID
	local containerId = WindowGetId(dialog)

	-- do we have a valid id?
	if not IsValidID(containerId) then
		return
	end
	
	-- initialize the tooltip text
	local messageText = L""

	-- does this container have more items than the UI can handle? 
	if (ContainerWindow.OpenContainers[containerId].maxSlots > ContainerWindow.MaxSlotsPerGrid or WindowData.ContainerWindow[containerId].numItems > ContainerWindow.MaxSlotsPerGrid) then
		
		-- is the container in list view mode?
		if (ContainerWindow.ViewModes[containerId] == "List") then
			
			-- show that the view mode can be switched to free form
			messageText = GetStringFromTid(ContainerWindow.TID_FREEFORM_MODE)

		-- is the container in free form view mode?
		elseif (ContainerWindow.ViewModes[containerId] == "Freeform") then

			-- show that the view mode can be switched to list
			messageText = GetStringFromTid(ContainerWindow.TID_LIST_MODE)
		end

	else -- container with decent amount of items

		-- is this container in grid view mode?
		if (ContainerWindow.ViewModes[containerId] == "Grid") then
			
			-- show that the view mode can be switched to list
			messageText = GetStringFromTid(ContainerWindow.TID_LIST_MODE)

		-- is the container in list view mode?
		elseif (ContainerWindow.ViewModes[containerId] == "List") then

			-- show that the view mode can be switched to free form
			messageText = GetStringFromTid(ContainerWindow.TID_FREEFORM_MODE)

		-- is the container in free form view mode?
		elseif (ContainerWindow.ViewModes[containerId] == "Freeform") then

			-- show that the view mode can be switched to grid
			messageText = GetStringFromTid(ContainerWindow.TID_GRID_MODE)
		end
    end
    
	-- loading the item properties array
	local itemData = 
	{ 
		windowName = SystemData.ActiveWindow.name,
		itemId = containerId,
		itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
		title =	messageText,
	}
	
	-- showing the item properties
	ItemProperties.SetActiveItem(itemData)
end

ContainerWindow.ResizeOffset = {}
function ContainerWindow.OnResizeBegin()

	-- container window name
	local windowName = WindowUtils.GetActiveDialog()

	-- does the window really exist?
	if not DoesWindowExist(windowName) then
		return
	end
	
	-- get the container ID
	local id = WindowGetId(windowName)

	-- do we have a valid id?
	if not IsValidID(id) then
		return
	end

	-- initialize min height and width values
	local minHeight
	local minWidth

	-- is the container in list view mode?
	if (ContainerWindow.ViewModes[id] == "List") then
		
		-- get the min list view width
		minWidth = ContainerWindow.List_MinWidth

		-- calculating the min height as the min width + 15%
		minHeight = minWidth + (minWidth * 0.15)

	else -- is the container in grid view mode?

		-- set the min amount of columns for the grid
		local minColumns = 5

		-- grid view window name
		local grid_view_this = windowName.."GridView"

		-- get the scroll bar width
		local scrollbarWidth = WindowGetDimensions(grid_view_this.."Scrollbar")
		
		-- get the slot size
		local slotSize = WindowGetDimensions(windowName.."GridViewSocket1")
				
		-- calculate the min size (5 slot - scrollbar)
		local minSize = (slotSize * minColumns) - scrollbarWidth

		-- is the scaled minimum size different from the current size?
		if ContainerWindow.Grid_MinWidth * WindowGetScale(windowName) ~= minSize then

			-- set the min size as default min width
			ContainerWindow.Grid_MinWidth = minSize
		end
		
		-- set the min width
		minWidth = ContainerWindow.Grid_MinWidth

		-- calculating the min height as the min widhth + 1 slot size - small margin
		minHeight = minWidth + slotSize - 10
	end
	
	-- remove the container from the cascade
	ContainerWindow.RemoveFromCascade(id)
	
	-- begin the container resize with the data we have
    WindowUtils.BeginResize( windowName, "topleft", minWidth, minHeight, false, ContainerWindow.OnResizeEnd)
end

function ContainerWindow.OnResizeEnd()
	
	-- container window name
	local this = WindowUtils.resizeWindow

	-- does the window really exist?
	if not DoesWindowExist(this) then
		return
	end
	
	-- get the container ID
	local id = WindowGetId(this)

	-- do we have a valid id?
	if not IsValidID(id) then
		return
	end

	-- is the container in grid view mode?
	if (ContainerWindow.ViewModes[id] == "Grid") then		

		-- udpate the grid size
        ContainerWindow.UpdateGridViewSockets(id)

	-- is the container in list view mode?
	elseif (ContainerWindow.ViewModes[id] == "List") then		

		-- update the list size
        ContainerWindow.UpdateListView(id)
    end
    
    -- force the container update
	ContainerWindow.ForceContainerUpdate(id)	
end

function ContainerWindow.GetTopOfCascade()

	-- get the number of cascading windows
	local cascadeSize = #ContainerWindow.Cascade

	-- do we have cascading windows?
	if cascadeSize > 0 then

		-- parsing all the cascading windows from the end to the beginning to find the last one
		for i = cascadeSize, 1, -1 do

			-- get the container ID
			local windowId = ContainerWindow.Cascade[i]

			-- is the container part of the cascade?
			if ContainerWindow.IsCascading(windowId) then

				-- we found the container
				return windowId

			else -- this container is no longer part of the cascade, we remove it from the array
				ContainerWindow.Cascade[i] = nil
			end
		end
	end
	
	-- we found nothing
	return nil
end

function ContainerWindow.IsCascading(windowId)
	
	-- do we have a valid id?
	if not IsValidID(windowId) then
		return
	end

	-- do we have the open container record?
	if ContainerWindow.OpenContainers[windowId] then

		-- return the cascading status
		return ContainerWindow.OpenContainers[windowId].cascading

	else -- missing data
		return false
	end
end

function ContainerWindow.AddToCascade(windowId)
	
	-- do we have a valid id?
	if not IsValidID(windowId) then
		return
	end

	-- do we have the open container record?
	if ContainerWindow.OpenContainers[windowId] then
		
		-- generate a new cascade ID
		local cascadeSize = #ContainerWindow.Cascade + 1

		-- add the ID to the cascade
		ContainerWindow.Cascade[cascadeSize] = windowId

		-- set the cascading flag to true
		ContainerWindow.OpenContainers[windowId].cascading = true
	end
end

function ContainerWindow.RemoveFromCascade(windowId)
	
	-- do we have a valid id?
	if not IsValidID(windowId) then
		return
	end

	-- since this is called often. the ContainerWindow.Cascade array is resized in GetTopOfCascade
	if ContainerWindow.OpenContainers[windowId] then

		-- change the cascading flag to false
		ContainerWindow.OpenContainers[windowId].cascading = false
	end
end

function ContainerWindow.Scrolling(pos)

	-- container window name
	local this = WindowUtils.GetActiveDialog()

	-- does the window really exist?
	if not DoesWindowExist(this) then
		return
	end

	local id = WindowGetId(this)

	-- do we have a valid id?
	if not IsValidID(id) then
		return
	end

	-- getting the container data
	local containerData = Interface.GetContainersData(id, true)

	-- do we have the container data?
	if not Interface.VerifyContainer(id, containerData) then
		return
	end

	-- list view window name
	local list_view_this = this.."ListView"

	-- grid view window name
	local grid_view_this = this.."GridView"

	-- has the scrollbar been used automatically?
	if ContainerWindow.AutoScroll then

		-- is the container in list view mode?
		if ContainerWindow.ViewModes[id] == "List" then

			-- load the last scroll position
			local listOffset = Interface.LoadSetting("ScrollList" .. id, pos)

			-- apply the last scroll position
			ScrollWindowSetOffset(list_view_this, listOffset)
			
		-- is the container in grid view mode?
		elseif ContainerWindow.ViewModes[id] == "Grid" then

			-- load the scroll position for list view
			local gridOffset = Interface.LoadSetting("ScrollGrid" .. id, pos)

			-- apply the last scroll position
			ScrollWindowSetOffset(grid_view_this, gridOffset)
		end

		-- remove the autoscroll flag
		ContainerWindow.AutoScroll = nil

		-- no need to save if the scroll was automatic
		return
	end

	-- we save the scroll position of any container that is not a corpse or a player vendor and if the scroll position saving is enabled
	if not ContainerWindow.OpenContainers[id].isCorpse and not ContainerWindow.OpenContainers[id].isPlayerVendor and Interface.Settings.SaveScrollPos then

		-- is the container in list view mode?
		if ContainerWindow.ViewModes[id] == "List" then
			
			-- is the scrollable area showing at least 1 item?
			if VerticalScrollbarGetMaxScrollPosition(list_view_this .. "Scrollbar") > 0 then

				-- save the scroll position
				Interface.SaveSetting("ScrollList" .. id, pos)
			end

		-- is the container in grid view mode?
		elseif ContainerWindow.ViewModes[id] == "Grid" then

			-- save the scroll position
			Interface.SaveSetting("ScrollGrid" .. id, pos)
		end
	end
end

function ContainerWindow.OnMouseOverEnd()

	-- clear the current item properties
	ItemProperties.ClearMouseOverItem()
end

function ContainerWindow.BackpackItemsCheck(timePassed)
	
	-- do we have a valid backpack id?
	if IsValidID(ContainerWindow.PlayerBackpack) then
		
		-- if we used a mastery book or we don't know the current mastery levels we force the update
		if GetItemType(Interface.LastItem) == 7714 or Spellbook.MyMasteries == nil then
			Spellbook.MasteryGumpCheck = true
		end

		-- get the info about the arcane focus (if the player has it)
		ContainerWindow.UpdateArcaneFocusLevel()

		-- get the info about the vendor search map (if the player has it)
		ContainerWindow.UpdateVendorSearchMap()

		-- get the info about the mastery book (if the player has it)
		ContainerWindow.UpdateMasteryBook()

		-- search for ethereal mounts
		ContainerWindow.SearchEtherealsMounts()
	end
end

function ContainerWindow.GetFirstCascadePosition(windowName)

	-- get the game window dimensions
	local w, h = WindowGetDimensions("ResizeWindow")

	-- apply the scale to the game window dimensions
	w = w * InterfaceCore.scale
	h = h * InterfaceCore.scale

	-- get the screen position of the game window
	local topX, topY = WindowGetOffsetFromParent("ResizeWindow")
	
	-- get the container window dimensions
	local winW, winH = WindowGetDimensions(windowName)

	-- scale the container window dimensions
	winW = winW * InterfaceCore.scale
	winH = winH * InterfaceCore.scale
	
	-- initialize the top left coordinate
	local topleftX = (topX + 100)
	local topleftY = (topY + 100)
	
	-- initialize the top right coordinates
	local toprightX = ((topX + w) - 150) 
	local toprightY = (topY + 100)
	
	-- initialize the bottom left coordinates
	local bottomleftX = (topX + 100)
	local bottomleftY = ((topY + h) - winH - 100)
	
	-- initialize the bottom right coordinates
	local bottomrightX = ((topX + w) - 150)
	local bottomrightY = ((topY + h) - winH - 100)
	
	-- initialize the random coordinates
	local randomX = math.random(topleftX, toprightX)
	local randomY = math.random(topleftY, bottomrightY)
	
	-- return the coordinates based on the chosen position from user setting
	if Interface.Settings.CascadeType == 0  then
		return topleftX, topleftY
		
	elseif Interface.Settings.CascadeType == 1 then
		return toprightX, toprightY
		
	elseif Interface.Settings.CascadeType == 2 then
		return bottomleftX, bottomleftY
	
	elseif Interface.Settings.CascadeType == 3 then
		return bottomrightX, bottomrightY
	
	elseif Interface.Settings.CascadeType == 4 then
		return randomX, randomY
	end
end

function ContainerWindow.GetCascadeOffset(windowName)

	-- does the window really exist?
	if not DoesWindowExist(windowName) then
		return
	end

	-- we get the x, y screen position
	local topX, topY = WindowGetScreenPosition(windowName)	

	-- we get width and height of the window
	local w, h = WindowGetDimensions(windowName)

	-- scale width and height value properly with the UI scale
	w = w * InterfaceCore.scale
	h = h * InterfaceCore.scale
	
	-- calculating the shifting from the top left corner
	local topleftX = (topX + ContainerWindow.POSITION_OFFSET)
	local topleftY = (topY + ContainerWindow.POSITION_OFFSET)
	
	-- calculating the shifting from the top right corner
	local toprightX = (topX + w) - (ContainerWindow.POSITION_OFFSET * 2)
	local toprightY = (topY + ContainerWindow.POSITION_OFFSET)
	
	-- calculating the shifting from the bottom left corner
	local bottomleftX = (topX + ContainerWindow.POSITION_OFFSET)
	local bottomleftY = topY - (ContainerWindow.POSITION_OFFSET / 2)
	
	-- calculating the shifting from the bottom right corner
	local bottomrightX = (topX + w) - (ContainerWindow.POSITION_OFFSET * 2)
	local bottomrightY = topY - (ContainerWindow.POSITION_OFFSET / 2)

	-- apply the calculated position to the chosen cascading direction
	if Interface.Settings.CascadeType == 0 then
		return topleftX, topleftY
		
	elseif Interface.Settings.CascadeType == 1 then
		return toprightX, toprightY
		
	elseif Interface.Settings.CascadeType == 2 then
		return bottomleftX, bottomleftY
	
	elseif Interface.Settings.CascadeType == 3 then
		return bottomrightX, bottomrightY
	
	elseif Interface.Settings.CascadeType == 4 then
		return topleftX, topleftY
	end
end

-- this function is used to remove ALL containers data of containers that have been seen 7 days ago or more
function ContainerWindow.PurgeOldContainersData()

	-- scanning all strings values
	for i, stringName in pairsByIndex(SystemData.Settings.Interface.UIVariables.StringNames) do

		-- is this a container window variable?
		if string.find(stringName, "ContainerWindow_", 1, true) then --ContainerWindow_1093896600ViewMode

			-- get the container ID from the variable name
			local cid = string.gsub(stringName, "ContainerWindow_", "")
			cid = string.gsub(cid, "ViewMode", "")
			cid = tonumber(cid)

			-- update the last seen timestamp if doesn't exist
			if not ContainerWindow.ContainerLastSeen[cid] then
				ContainerWindow.ContainerLastSeen[cid] = 0
			end
		end
	end

	-- scanning all numbers values
	for i, numberName in pairsByIndex(SystemData.Settings.Interface.UIVariables.NumberNames) do

		-- is this a container window scroll grid variable?
		if string.find(numberName, "ScrollGrid", 1, true) then --ScrollGrid1115237763

			-- get the container ID from the variable name
			local cid = string.gsub(numberName, "ScrollGrid", "")
			cid = tonumber(cid)

			-- update the last seen timestamp if doesn't exist
			if not ContainerWindow.ContainerLastSeen[cid] then
				ContainerWindow.ContainerLastSeen[cid] = 0
			end
		end

		-- is this a container window scroll list variable?
		if string.find(numberName, "ScrollList", 1, true) then --ScrollList1074018602

			-- get the container ID from the variable name
			local cid = string.gsub(numberName, "ScrollList", "")
			cid = tonumber(cid)

			-- update the last seen timestamp if doesn't exist
			if not ContainerWindow.ContainerLastSeen[cid] then
				ContainerWindow.ContainerLastSeen[cid] = 0
			end
		end
	end

	-- scan all the window positions
	for i, stringName in pairs(SystemData.Settings.Interface.WindowPositions.Names) do

		-- is this a container window?
		if string.find(stringName, "CID", 1, true) then --CID1109683626

			-- get the container ID from the variable name
			local cid = string.gsub(stringName, "CID", "")
			cid = tonumber(cid)

			-- update the last seen timestamp if doesn't exist
			if not ContainerWindow.ContainerLastSeen[cid] then
				ContainerWindow.ContainerLastSeen[cid] = 0
			end
		end
	end

	-- scanning all the container last seen
	for id, value in pairs(ContainerWindow.ContainerLastSeen) do

		-- is passed a week since we have seen the container?
		if Interface.Clock.Timestamp > value + 604800 then

			-- purge all the variables
			Interface.DeleteSetting("ContainerWindow_" .. id .. "ViewMode")
			Interface.DeleteSetting("ScrollGrid" .. id)
			Interface.DeleteSetting("ScrollList" .. id)
			WindowUtils.ClearWindowPosition("CID" .. id)
		end
	end
end

-- this function gives the quantity of an item type inside the player backpack
-- use "any" to get the count of the type without considering the hue
function ContainerWindow.GetItemQuantity(objectType, hue, excludeHue)

	-- do we have a valid id?
	if not IsValidID(objectType) then
		return 0
	end

	-- do we have the hue?
	if not hue then

		-- any hue will do...
		hue = "any"
	end

	-- the backpack items are unavailable?
	if not Interface.BackPackItems then
		Interface.BackPackItems = ContainerWindow.ScanQuantities(ContainerWindow.PlayerBackpack, true)

		-- still unavailable?
		if not Interface.BackPackItems then
			return 0
		end
	end

	-- count every item of this type without considering the hue
	if type(hue) == "string" and hue == "any" then
		
		-- are there any item of the requested type?
		if not Interface.BackPackItems[objectType] then
			return 0
		end

		-- initialize the quantity count
		local qta = 0

		-- scan all the hue of this object type available
		for hueID, itemIds in pairs(Interface.BackPackItems[objectType]) do

			-- is this hue excluded?
			if excludeHue and  hueID == excludeHue then
				continue
			end

			-- scan all the item id of this object type & hue
			for id, amount in pairs(itemIds) do

				-- sum the quantity of the current item to the total
				qta = qta + amount
			end
		end
		
		return qta 
	
	else -- specific type and hue

		-- are there any item of the requested type?
		if not Interface.BackPackItems[objectType] then
			return 0
		end

		-- are there any item of the requested type?
		if not Interface.BackPackItems[objectType][hue] then
			return 0
		end

		-- initialize the quantity count
		local qta = 0

		-- scan all the item id of this object type & hue
		for id, amount in pairs(Interface.BackPackItems[objectType][hue]) do

			-- sum the quantity of the current item to the total
			qta = qta + amount
		end

		return qta 
	end
end

-- this function gives the item ID (from the backpack or equipped) given the item type and hue
-- use "any" to get the count of the type without considering the hue
function ContainerWindow.GetItemIDByType(objectType, hue, scanEquipped)

	-- do we have a valid id?
	if (type(objectType) ~= "table" and not IsValidID(objectType)) or objectType == nil then
		return 0
	end

	-- do we have the hue?
	if not hue then

		-- any hue will do...
		hue = "any"
	end

	-- initialize the types array
	local types = {}

	-- do we have multiple types?
	if type(objectType) == "table" then
		
		-- we copy all the IDs into the types array
		types = table.copy(objectType)

	else -- we add the only type we have into the types array
		table.insert(types, objectType)
	end
	
	-- the backpack items are unavailable?
	if not Interface.BackPackItems then
		Interface.BackPackItems = ContainerWindow.ScanQuantities(ContainerWindow.PlayerBackpack, true)

		-- still unavailable?
		if not Interface.BackPackItems then
			return 0
		end
	end

	local foundId = 0

	-- scan all types we have to search until we find the item
	for i, objectType in pairsByIndex(types) do
		
		-- count every item of this type without considering the hue
		if type(hue) == "string" and hue == "any" then
		
			-- are there any item of the requested type?
			if not Interface.BackPackItems[objectType] then

				-- shall we scan equipped items?
				if scanEquipped then
					foundId = ContainerWindow.GetEquippedItemIDByType(objectType, hue)

					-- do we have a valid ID?
					if IsValidID(foundId) then
						return foundId
					end
				end
				continue
			end

			-- scan all the hue of this object type available
			for hueID, itemIds in pairs(Interface.BackPackItems[objectType]) do

				-- scan all the item id of this object type & hue
				for id, amount in pairs(itemIds) do

					-- return the first id we find
					foundId = id
				end
			end
			
		else -- specific type and hue

			-- are there any item of the requested type?
			if not Interface.BackPackItems[objectType] then

				-- shall we scan equipped items?
				if scanEquipped then
					foundId = ContainerWindow.GetEquippedItemIDByType(objectType, hue)

					-- do we have a valid ID?
					if IsValidID(foundId) then
						return foundId
					end
				end
				continue
			end

			-- are there any item of the requested type?
			if not Interface.BackPackItems[objectType][hue] then
			
				-- shall we scan equipped items?
				if scanEquipped then
					foundId = ContainerWindow.GetEquippedItemIDByType(objectType, hue)

					-- do we have a valid ID?
					if IsValidID(foundId) then
						return foundId
					end
				end
				continue
			end

			-- scan all the item id of this object type & hue
			for id, amount in pairs(Interface.BackPackItems[objectType][hue]) do

				-- return the first id we find
				foundId = id
			end
		end

		-- do we have a valid ID?
		if IsValidID(foundId) then
			return foundId
		end
	end

	return 0
end

function ContainerWindow.GetEquippedItemIDByType(objectType, hue)

	-- do we have a valid id?
	if not IsValidID(objectType) then
		return 0
	end

	-- do we have the hue?
	if not hue then

		-- any hue will do...
		hue = "any"
	end

	local playerId = GetPlayerID()

	-- get the paperdoll data
	local paperdollData = Interface.GetPaperdollData(playerId)
	if not paperdollData then
		return 0
	end

	-- scan the whole equipment
	for index = 1, paperdollData.numSlots  do
		local itemId = PaperdollWindow.GetPaperdollSlotID(playerId, index)

		-- get the object type
		local currObjectType = GetItemType(itemId)

		-- is this item of the right type?
		if currObjectType == objectType then
			
			-- count every item of this type without considering the hue
			if type(hue) == "string" and hue == "any" then
				return itemId

			else -- specific hue
				
				-- get the object hue
				local currHue = GetItemHue(itemId)

				if currHue == hue then
					return itemId
				end
			end
		end
	end

	-- if we get here we've found nothing
	return 0
end

function ContainerWindow.UpdateArcaneFocusLevel()
	
	-- get the arcane focus ID
	local arcaneFocus = ContainerWindow.GetItemIDByType(12629, 0, false)

	-- do we have an arcane focus?
	if IsValidID(arcaneFocus) then

		-- get the focus strength property
		local prop = ItemProperties.GetObjectPropertiesParamsForTid( arcaneFocus, 1060485, "Backpack check - Arcane focus parsing" ) -- strength bonus ~1_val~

		-- is that property available?
		if prop then

			-- update the focus level
			Interface.ArcaneFocusLevel = tonumber(prop[1])
		end
	end
end

ContainerWindow.IgnoredMaps = {}
ContainerWindow.LastVendorMap = 0
function ContainerWindow.UpdateVendorSearchMap()
	
	-- do we have any map?
	if not Interface.BackPackItems[5355] then
		return
	end

	-- initialize the map ID variable
	local vendorMap = 0

	-- scan all the hue of this object type available
	for hueID, itemIds in pairs(Interface.BackPackItems[5355]) do

		-- scan all the item id of this object type & hue
		for id, amount in pairs(itemIds) do

			-- is the map already known?
			if id == ContainerWindow.LastVendorMap or ContainerWindow.IgnoredMaps[id] then
				continue
			end

			-- get the item name
			local itemName = GetItemName(id)
			
			-- do we have the item name?
			if not IsValidWString(itemName) or itemName == GetStringFromTid(1077438) then -- map
			
				-- retry later
				Interface.AddTodoList({func = function() ContainerWindow.UpdateVendorSearchMap() end, time = Interface.TimeSinceLogin + 1})

				return
			end
			
			-- get the tokens from the name and the TID
			local words = GetTokensFromString(itemName, 1154559)

			-- turn the name lower case
			local finalText = wstring.lower(itemName)

			-- creating an array with all the words in the text
			local textWords = wstring.split(finalText, L" ")

			-- clear the text
			finalText = L""

			-- parse all the words contained in the text string
			for i, word in pairsByIndex(textWords) do
		
				-- does the TID words array contains this word?
				if table.contains(words, word) then
					continue
				end

				-- append this word
				finalText = wstring.appendWithSeparator(finalText, word, L" ")
			end
			
			-- is the final text different from the TID without tokens?
			if wstring.lower(wstring.trim(wstring.gsub(ReplaceTokens(GetStringFromTid(1154559), {L"", L""}), L"%:", L""))) ~= wstring.trim(finalText) then
				
				-- flag to ignore this map
				ContainerWindow.IgnoredMaps[id] = true

				-- NOT a vendor map
				continue
			end

			-- does the item has the property for the map?
			if ItemProperties.DoesItemHasProperty(id, 1154639) then -- Vendor Located at ~1_loc~ (~2_facet~)

				-- set the map ID
				vendorMap = id
				break
			end
		end
		
		-- store the map ID
		ContainerWindow.LastVendorMap = vendorMap

		-- have we found the map?
		if IsValidID(vendorMap) then
			break
		end
	end

	-- do we have a vendor search map?
	if IsValidID(vendorMap) then

		-- is the compass already pointing to that vendor?
		if MapWindow.MagnetPoint.itemID and MapWindow.MagnetPoint.itemID == vendorMap then
			return
		end

		-- get the map properties
		local props = Interface.GetItemPropertiesData( vendorMap, "Backpack check - Vendor search map" )

		-- get the TID array from the property
		local params = ItemProperties.BuildParamsArray( props )

		-- do we have the vendor search map specific TIDs?
		if params and params[1154639] and params[1154559] then -- Vendor Located at ~1_loc~ (~2_facet~) -- AND -- Map to Vendor ~1_Name~: ~2_Shop~

			-- getting the coordinates
			local coord = params[1154639][1] -- Vendor Located at ~1_loc~ (~2_facet~)

			-- getting the map TID
			local map = tostring(wstring.gsub(params[1154639][2], L"#", L""))
			map = tonumber(map)
						
			-- convert the map TID to the map index
			if map == 1012001 then -- felucca
				map = 0
			elseif map == 1012000 then -- trammel
				map = 1								
			elseif map == 1012002 then -- ilshenar
				map = 2
			elseif map == 1060643 then -- malas
				map = 3
			elseif map == 1063258 then -- tokuno
				map = 4
			elseif map == 1112178 then -- ter mur
				map = 5
			end

			-- get the vendor name
			local name = params[1154559][1] -- Map to Vendor ~1_Name~: ~2_Shop~
							
			-- calculating the coordinates X, Y
			local latVal, latDir, longVal, longDir = GumpsParsing.GetSOSCoords(coord)
			local x, y = MapCommon.ConvertToXYMinutes(latVal, longVal, latDir, longDir, map, 1)

			-- initialize the compass data record
			local wp = { itemID = vendorMap, facet = map, x = math.round(x), y = math.round(y), z = 0, type = MapCommon.WaypointCustomType, name = name, Icon = 100113, Scale = 1, itemId = vendorMap }

			-- loading the record
			Interface.VendorSearchMap = wp

			-- set the object handler filter
			ObjectHandleWindow.CurrentFilter = name

			-- magnetize the compass
			MapWindow.MagnetizeLocation(x, y, map, vendorMap)
		end
	end
end

ContainerWindow.MasteryChanged = true
function ContainerWindow.UpdateMasteryBook()

	-- do we have a change in mastery?
	if not ContainerWindow.MasteryChanged then
		return
	end
	
	-- get the mastery book ID
	local masteryBook = ContainerWindow.GetItemIDByType({8794, 8795}, 0, true)
	
	-- do we have the mastery book?
	if IsValidID(masteryBook) then	
	
		-- get the book properties
		local props = Interface.GetItemPropertiesData( masteryBook, "Backpack check - Mastery Book" )
		
		-- do we have the properties?
		if not props then
			return
		end

		-- get the TID array from the property
		local params = ItemProperties.BuildParamsArray( props, true )

		-- do we have any TID?
		if params then

			-- check the arcane focus level
			if params[1060485] then				
					
				-- update the arcane focus level
				Interface.ArcaneFocusLevel = tonumber(params[1060485][1]) -- strength bonus ~1_val~		
			end	
              
			-- is this a bard mastery?
			if params[Spellbook.TID_MASTERY_PROVOCATION] or params[Spellbook.TID_MASTERY_PEACEMAKING] or params[Spellbook.TID_MASTERY_DISCORD] then

				-- we mark the bard mastery as active
				Interface.BardMastery = true

			else -- bard mastery inactive
				Interface.BardMastery = false
			end
				
			-- check the active mastery
			for tid, _ in pairs(Spellbook.MasteryBookTIDs) do
					
				-- found the right mastery
				if params[tid] then

					-- is that different from the current one?
					if Spellbook.ActiveMastery ~= tid then
							
						-- change the active mastery
						Spellbook.ActiveMastery = tid
					end
					break
				end
			end
		end

		-- flag for updating the spellbook (if it's open)
		if not Spellbook.GetMasteryBook() then
			
			-- flag the mastery as changed
			Spellbook.MasteryChanged = true

			-- update the mastery book
			Spellbook.InitMasteryIndexTab(true)
		end

		-- reset the update flag
		ContainerWindow.MasteryChanged = nil
	end
end

function ContainerWindow.SearchEtherealsMounts()
	
	-- the backpack items are unavailable?
	if not Interface.BackPackItems then
		Interface.BackPackItems = ContainerWindow.ScanQuantities(ContainerWindow.PlayerBackpack, true)
	end

	-- scan all the items 
	for objectType, hueItems in pairs(Interface.BackPackItems) do

		-- scan all the hue of this object type available
		for hueID, itemIds in pairs(hueItems) do

			-- scan all the item id of this object type & hue
			for id, amount in pairs(itemIds) do
			
				-- get the item name
				local itemName = GetItemName(id)	

				-- initialize the flag that indicates if the current item is an ethereal mount
				local found = false
				
				-- scan the possible ethereals for the name we have
				for tid, iconId in pairs(MountsList.EtheresalsTIDs) do
					if itemName == GetStringFromTid(tid) then
						MountsList.SetAvailable(id, tid, true)
						found = true
						break
					end
				end

				-- since this array have sevearal items of the same type and hue, if one is not an ethereal mount, none of them are..
				if not found then
					break
				end
			end
		end
	end
end

function ContainerWindow.ResetPickupTimer()
	ContainerWindow.TimePassedSincePickUp = 0
	ContainerWindow.CanPickUp = false
end

function ContainerWindow.GetNewItemsList(newItemsList)

	-- create a table for the new items
	newItems = {}

	-- do we have the items list?
	if not newItemsList then
		return newItems
	end

	-- scan all the items in the new backpack items list
	for objectType, data in pairs(newItemsList) do
	
		-- was this object type inside the backpack?
		if not Interface.BackPackItems[objectType] then

			-- all the items of this type are new
			for _, itemIds in pairs(newItemsList[objectType]) do
				
				-- we store all the item ids as new items
				for id, qta in pairs(itemIds) do
					newItems[id] = objectType
				end
			end

		else -- this object type already existed

			-- current objects of this type in the backpack
			local bpkObj = Interface.BackPackItems[objectType]

			-- scan all the hue of this object type available
			for hueID, itemIds in pairs(newItemsList[objectType]) do
				
				-- did we have an item with this hue and type in the backpack?
				if not bpkObj[hueID] then
					
					-- we store all the item ids as new items
					for id, qta in pairs(itemIds) do
						newItems[id] = objectType
					end

				else -- hue already existed
				 
					-- current objects of this type and hue in the backpack
					local bpkObj = bpkObj[hueID]

					-- scan all the item ids
					for id, qta in pairs(itemIds) do

						-- if the item ID was not in the backpack then it's new
						if not bpkObj[id] then
							newItems[id] = objectType
						end
					end
				end
			end
		end
	end

	return newItems
end