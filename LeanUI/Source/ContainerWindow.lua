ContainerWindow = {}
ContainerWindow.OpenContainers = {}
ContainerWindow.RegisteredItems = {}
ContainerWindow.ViewModes = {}

ContainerWindow.DEFAULT_START_POSITION = { x=100,y=100 }
ContainerWindow.MAX_VALUES = { x=1280, y=1024 }
ContainerWindow.POSITION_OFFSET = 30
ContainerWindow.TimePassedSincePickUp = 0
ContainerWindow.CanPickUp = true

ContainerWindow.TID_GRID_MODE = 1079439
ContainerWindow.TID_FREEFORM_MODE = 1079440
ContainerWindow.TID_LIST_MODE = 1079441

ContainerWindow.ScrollbarWidth = 5

ContainerWindow.Grid = {}
ContainerWindow.Grid.PaddingTop = 50
ContainerWindow.Grid.PaddingLeft = 2
ContainerWindow.Grid.PaddingBottom = 2
ContainerWindow.Grid.PaddingRight = 10
ContainerWindow.Grid.SocketSize = 57
ContainerWindow.Grid.MinWidth = 320
ContainerWindow.Grid.NumSockets = {}

ContainerWindow.List = {}
ContainerWindow.List.PaddingTop = 65
ContainerWindow.List.PaddingLeft = 0
ContainerWindow.List.PaddingBottom = 0
ContainerWindow.List.PaddingRight = 0
ContainerWindow.List.LabelPaddingRight = ContainerWindow.ScrollbarWidth + ContainerWindow.List.PaddingRight + 5
ContainerWindow.List.ItemHeight = 60
ContainerWindow.List.MinWidth = 320

ContainerWindow.MAX_INVENTORY_SLOTS = 125

ContainerWindow.CHESS_GUMP = 2330
ContainerWindow.BACKGAMMON_GUMP = 2350
ContainerWindow.PLAGUE_BEAST_GUMP = 10851

-- used for windows the player doesn't own
ContainerWindow.Cascade = {}
ContainerWindow.Cascade.Movement = { x=0, y=0 }

ContainerWindow.OrganizeBag = nil
ContainerWindow.OrganizeParent = nil
ContainerWindow.Organize = false

ContainerWindow.Timer = 0
ContainerWindow.LastUpdate = {}
ContainerWindow.LastItemCount = {}
ContainerWindow.DelayedUpdate = {}

----------------------------------------------------------------
-- ContainerWindow Functions
----------------------------------------------------------------

-- Helper function
function ContainerWindow.ReleaseRegisteredObjects(id)
	if( ContainerWindow.RegisteredItems[id] ~= nil ) then
		for id, value in pairs(ContainerWindow.RegisteredItems[id]) do
			UnregisterWindowData(WindowData.ObjectInfo.Type, id)
		end
	end
	ContainerWindow.RegisteredItems[id] = {}
end

-- sets legacy container art
function ContainerWindow.SetLegacyContainer( gumpID, windowID )
	local this = SystemData.ActiveWindow.name
	
	-- hide unwanted container elements
	WindowSetShowing( this.."Chrome", false )
	WindowSetShowing( this.."Title", false )
	WindowSetShowing( this.."Background", false )

    if( gumpID == nil ) then
        --Debug.Print("ContainerWindow.SetLegacyContainer: gumpID is nil!")
        return
    end

	local texture = gumpID
	local xSize, ySize
	local scale = SystemData.FreeformInventory.Scale
	texture, xSize, ySize = RequestGumpArt( texture )
	local textureSize = xSize
	if (textureSize < ySize) then
		textureSize = ySize
	end
	
	local yAnchor = 0
	if (gumpID == ContainerWindow.CHESS_GUMP) then
		yAnchor = 20
	end
	
	-- show legacy container art
	WindowSetDimensions( this, xSize * scale, ySize * scale )
	WindowSetShowing( this.."LegacyContainerArt", true )
	WindowAddAnchor( this.."LegacyContainerArt", "topleft", this, "topleft", 0, yAnchor )
	WindowSetDimensions( this.."LegacyContainerArt", xSize * scale, ySize * scale )
	DynamicImageSetTexture( this.."LegacyContainerArt", texture, 0, 0 )
	DynamicImageSetTextureScale( this.."LegacyContainerArt", scale )
	
	DynamicImageSetTextureDimensions(this.."FreeformView", textureSize * scale, textureSize * scale)
	WindowSetDimensions(this.."FreeformView", textureSize * scale, textureSize * scale)
	DynamicImageSetTexture(this.."FreeformView", "freeformcontainer_texture"..windowID, 0, 0)
	DynamicImageSetTextureScale(this.."FreeformView", InterfaceCore.scale * scale)
	
	requestedContainerArt = requestedContainerArt or {}
	requestedContainerArt = texture
end

-- OnInitialize Handler
function ContainerWindow.Initialize()
	
	local this = SystemData.ActiveWindow.name
	local id = SystemData.DynamicWindowId
	local legacyContainersMode = SystemData.Settings.Interface.LegacyContainers

	WindowSetId(this, id)
	
	--Debug.PrintToChat(L"container id  = "..id);
	
	Interface.DestroyWindowOnClose[this] = true

	ContainerWindow.OpenContainers[id] = {open = true, cascading = false, slotsWide = 0, slotsHigh = 0}

	RegisterWindowData(WindowData.ContainerWindow.Type, id)
	RegisterWindowData(WindowData.PlayerEquipmentSlot.Type, EquipmentData.EQPOS_BACKPACK)
	WindowRegisterEventHandler(this, WindowData.ContainerWindow.Event, "ContainerWindow.MiniModelUpdate")
	WindowRegisterEventHandler(this, WindowData.ObjectInfo.Event, "ContainerWindow.HandleUpdateObjectEvent")

	local gumpID = WindowData.ContainerWindow[id].gumpNum
	
	local l = L"grid"
	if legacyContainersMode then
		l = L"legacy"
	end
	
	if (legacyContainersMode or gumpID == ContainerWindow.CHESS_GUMP or gumpID == ContainerWindow.BACKGAMMON_GUMP 
			or gumpID == ContainerWindow.PLAGUE_BEAST_GUMP ) then
        ContainerWindow.ViewModes[id] = "Freeform"	
		
	elseif WindowData.ContainerWindow[id].isCorpse then
		ContainerWindow.ViewModes[id] = SystemData.Settings.Interface.defaultCorpseMode
		
	elseif IsInPlayerBackPack(id) then
		-- iterate through the shared vector looking for our container id
		for i, windowId in ipairs(SystemData.Settings.Interface.ContainerViewModes.Ids) do
			if windowId == id then -- we found the preserved viewmode
				ContainerWindow.ViewModes[id] = SystemData.Settings.Interface.ContainerViewModes.ViewModes[i]
				break
			end
		end
		
		-- if the id wasn't found or if the container's viewmode was manually changed to "Freeform" with legacy containers 
		-- turned off, use the default setting
		if not ContainerWindow.ViewModes[id] or ContainerWindow.ViewModes[id] == "Freeform" then
			ContainerWindow.ViewModes[id] = SystemData.Settings.Interface.defaultContainerMode
			
			-- insert the new container setting into the shared vector
			local newContainerIndex = table.getn(SystemData.Settings.Interface.ContainerViewModes.ViewModes) + 1
			SystemData.Settings.Interface.ContainerViewModes.Ids[newContainerIndex] = id
			SystemData.Settings.Interface.ContainerViewModes.ViewModes[newContainerIndex] = ContainerWindow.ViewModes[id]
		end
		
	else
		ContainerWindow.ViewModes[id] = SystemData.Settings.Interface.defaultContainerMode
	end
	-- done getting view mode
	
	-- Set legacy art icon
	local texture = gumpID
	local xSize, ySize
	texture, xSize, ySize = RequestGumpArt(texture)
	local scale = 40 / ySize
	local yAnchor = 10
	local xAnchor = 10
	if (gumpID == ContainerWindow.CHESS_GUMP) then
		yAnchor = 20
	end
	ySize = ySize * scale
	xSize = xSize * scale
	WindowSetShowing( this.."LegacyArt", true )
	WindowSetAlpha(this.."LegacyArt", 0.5)
	WindowAddAnchor( this.."LegacyArt", "topleft", this, "topleft", xAnchor, yAnchor )
	WindowSetDimensions( this.."LegacyArt", xSize, ySize)
	DynamicImageSetTexture( this.."LegacyArt", texture, 0, 0 )
	DynamicImageSetTextureScale( this.."LegacyArt", scale )
	
	
	if (ContainerWindow.ViewModes[id] == "Freeform") then
		ContainerWindow.SetLegacyContainer( gumpID, id )
		WindowSetShowing( this.."ViewButton", false )
		WindowSetShowing( this.."ResizeButton", false )
	else
		WindowSetShowing( this.."ViewButton", true )
		WindowSetAlpha(this.."ViewButton", 0.5)
	end

	WindowData.ContainerWindow[id].numCreatedSlots = 0
	WindowData.ContainerWindow[id].maxSlots = SystemData.ActiveContainer.NumSlots
	
	--Debug.PrintToChat(L"ContainerWindow.Init(id = "..id..L", gump = "..gumpID..L", mode = "..l..L", maxSlots = "..SystemData.ActiveContainer.NumSlots..L")")
	
		
	if IsInPlayerBackPack(id) then
		WindowUtils.RestoreWindowPosition(this, true)
		
		-- Limit window height for commonly used containers if they exceed too much height
		local dimx, dimy = WindowGetDimensions(this)
		if dimy > 500 then
		    WindowSetDimensions(this, dimx, 521)
		end
		
		if not WindowUtils.CanRestorePosition(this) then
			local parentContainerId = GetParentContainer(id)
			
			WindowClearAnchors(this)
			if parentContainerId ~= 0 then
				-- offset this container from the parent
				local x, y = WindowGetScreenPosition("ContainerWindow_"..parentContainerId)	
				x = math.floor((x + ContainerWindow.POSITION_OFFSET) / InterfaceCore.scale + 0.5)
				y = math.floor((y + ContainerWindow.POSITION_OFFSET) / InterfaceCore.scale + 0.5)
				WindowAddAnchor(this, "topleft", "Root", "topleft", x, y)	
			else
				WindowAddAnchor(this, "topleft", "Root", "topleft", 200, 200)	
			end
		end
		
		-- if this is the players backpack then update the paperdoll backpack icon
		local playerBackpack = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
		if( id == playerBackpack ) then
			ContainerWindow.SetInventoryButtonPressed(true)
		end
		
	-- else tile them like the old client
	else
		WindowUtils.RestoreWindowPosition(this)
		
		if not WindowUtils.CanRestorePosition(this) then
			-- if window position couldn't be restored, cascade the containers from the top left of the screen
			local x, y;
			
			local topCascadingId = ContainerWindow.GetTopOfCascade()
			if not topCascadingId then
				x = ContainerWindow.DEFAULT_START_POSITION.x
				y = ContainerWindow.DEFAULT_START_POSITION.y
			else
				x, y = WindowGetScreenPosition("ContainerWindow_"..topCascadingId)
				x = x + ContainerWindow.POSITION_OFFSET
				y = y + ContainerWindow.POSITION_OFFSET
			end
			
			x = math.floor(x / InterfaceCore.scale + 0.5)
			y = math.floor(y / InterfaceCore.scale + 0.5)
			WindowClearAnchors(this)
			WindowAddAnchor(this, "topleft", "Root", "topleft", x, y)	
			
			ContainerWindow.AddToCascade(id)
		end

	end
	
	
	if (ContainerWindow.ViewModes[id] == "List") then
		ContainerWindow.UpdateListViewSockets(id)
	elseif (ContainerWindow.ViewModes[id] ~= "Freeform") then
		-- default to grid view if not using list or freeform containers
		ContainerWindow.ViewModes[id] = "Grid"
		ContainerWindow.UpdateGridViewSockets(id)
	end
	
	ContainerWindow.UpdateContents(id)
	
end

function ContainerWindow.Shutdown()
	--Debug.PrintToChat(L"ContainerWindow.Shutdown")

	if requestedContainerArt then
		ReleaseGumpArt( tonumber( requestedContainerArt ) )
	end

	local id = WindowGetId(WindowUtils.GetActiveDialog())
	local this = "ContainerWindow_"..id
	
	-- if the container is in the cascade, don't save its position
	if ContainerWindow.IsCascading(id) then
		ContainerWindow.RemoveFromCascade(id)
	else
		WindowUtils.SaveWindowPosition(this)
	end
	
	if IsInPlayerBackPack(id) then
		
		-- iterate through the shared vector looking for our container id
		for i, windowId in ipairs(SystemData.Settings.Interface.ContainerViewModes.Ids) do
			if windowId == id then
				SystemData.Settings.Interface.ContainerViewModes.ViewModes[i] = ContainerWindow.ViewModes[id]
				break
			end
		end
		
		local playerBackpack = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
		if( id == playerBackpack ) then
			ContainerWindow.SetInventoryButtonPressed(false)
		end 
	end
	
	ContainerWindow.ReleaseRegisteredObjects(id)
	
	ContainerWindow.ViewModes[id] = nil
	ContainerWindow.OpenContainers[id] = nil
	
	UnregisterWindowData(WindowData.ContainerWindow.Type, id)
	UnregisterWindowData(WindowData.PlayerEquipmentSlot.Type, EquipmentData.EQPOS_BACKPACK)
	
	if( ItemProperties.GetCurrentWindow() == this ) then
		ItemProperties.ClearMouseOverItem()
	end
	
	GumpManagerOnCloseContainer(id)
end


function ContainerWindow.OnSetMoving(isMoving)
	local id = WindowGetId(WindowUtils.GetActiveDialog())
	
	if ContainerWindow.IsCascading(id) then
		local windowName = "ContainerWindow_"..id
		local x, y = WindowGetScreenPosition(windowName)
		if isMoving then
			ContainerWindow.Cascade.Movement.x = x
			ContainerWindow.Cascade.Movement.y = y
		else
			if ContainerWindow.Cascade.Movement.x ~= x and ContainerWindow.Cascade.Movement.y ~= y then
				ContainerWindow.RemoveFromCascade(id)
			end
		end
	end
	
end

function ContainerWindow.SetInventoryButtonPressed(pressed)
	ButtonSetPressedFlag("MenuBarWindowToggleInventory", pressed)
	local my_paperdoll = "PaperdollWindow"..WindowData.PlayerStatus.PlayerId
	local my_paperdoll_backpackicon = "PaperdollWindow"..WindowData.PlayerStatus.PlayerId.."ToggleInventory"
	if DoesWindowNameExist(my_paperdoll) and WindowGetShowing(my_paperdoll) then
		ButtonSetPressedFlag( my_paperdoll_backpackicon, pressed)
	end	
end

function ContainerWindow.HideAllContents(parent, numItems)
	local id = WindowGetId(parent)
	local data = WindowData.ContainerWindow[id]
	for i=1, data.maxSlots do
	  local socket = parent.."GridViewSocket"..i
		DynamicImageSetTexture(socket.."Icon", "", 0, 0);
		LabelSetText(socket.."Quantity", L"")
		WindowSetTintColor(socket, 255, 255, 255)
		
		if i <= numItems then
			WindowSetShowing(parent.."ListViewScrollChildItem"..i, false)
		end
	end
end

function ContainerWindow.CreateListViewSlots(dialog, low, high)
	local parent = dialog.."ListViewScrollChild"
	for i=low, high do
		local slotName = parent.."Item"..i
		CreateWindowFromTemplate(slotName, "ContainerItemTemplate", parent)
		WindowSetId(slotName,i)
		WindowSetId(slotName.."Icon", i)
        
		if i == 1 then
			WindowAddAnchor(slotName, "topleft", parent, "topleft", 0, 0)
            WindowAddAnchor(slotName, "topright", dialog, "topright", -ContainerWindow.List.LabelPaddingRight, 0)
		else
			WindowAddAnchor(slotName, "bottomleft", parent.."Item"..i-1, "topleft", 0, 0)
            WindowAddAnchor(slotName, "bottomright", dialog, "topright", -ContainerWindow.List.LabelPaddingRight, 0)
		end
	end
end

function ContainerWindow.MiniModelUpdate()
	local id = WindowData.UpdateInstanceId
	
	if id == WindowGetId(SystemData.ActiveWindow.name) then
		ContainerWindow.UpdateContents(id)
	end
end

function ContainerWindow.UpdateContents(id)
	local this = "ContainerWindow_"..id
	local list_view_this = this.."ListView"        
	local grid_view_this = this.."GridView"
	local freeform_view_this = this.."FreeformView"
	
	local data = WindowData.ContainerWindow[id]
  local contents = data.ContainedItems
  local numItems = data.numItems
  
  local bufferDelay = 0.1
	if ContainerWindow.LastUpdate[id] ~= nil and 
	   ContainerWindow.Timer - ContainerWindow.LastUpdate[id] < bufferDelay and 
	   ContainerWindow.LastItemCount[id] == numItems
	then
    -- delay this update!
    --Debug.PrintToChat("skipping mini model update!")
    if ContainerWindow.DelayedUpdate[id] == nil then
      ContainerWindow.DelayedUpdate[id] = ContainerWindow.Timer + bufferDelay
    end
    
    return
  else
    ContainerWindow.LastItemCount[id] = numItems
    ContainerWindow.LastUpdate[id] = ContainerWindow.Timer
  end 
	
	-- store the scrollbar offset so we can restore it when we are done
	local listOffset = ScrollWindowGetOffset(list_view_this)
	local gridOffset = ScrollWindowGetOffset(grid_view_this)
	
	local numCreatedSlots = data.numCreatedSlots or 0
	
	--Debug.PrintToChat(L"ContainerWindow.UpdateContents(id = "..id..L", #createdSlots = "..numCreatedSlots..L", #items = "..numItems..L")")
	
	if numItems > numCreatedSlots then
		ContainerWindow.CreateListViewSlots(this, numCreatedSlots+1, numItems)
		data.numCreatedSlots = numItems
	end
	
	if not data.numGridSockets or data.numGridSockets < data.maxSlots or not DoesWindowExist(grid_view_this.."Socket1") then
		ContainerWindow.CreateGridViewSockets(this, 1, data.maxSlots)
		data.numGridSockets = data.maxSlots;
	end
	
	-- Turn off all contents to start
	ContainerWindow.HideAllContents(this, numCreatedSlots)

	if ContainerWindow.ViewModes[id] == "List" then
		WindowSetShowing(list_view_this , true)
		WindowSetShowing(grid_view_this, false)
		WindowSetShowing(freeform_view_this, false)
		
	elseif ContainerWindow.ViewModes[id] == "Grid" then
		WindowSetShowing(list_view_this, false)
		WindowSetShowing(grid_view_this, true)
		WindowSetShowing(freeform_view_this, false)
		
	elseif ContainerWindow.ViewModes[id] == "Freeform" then
		WindowSetShowing(list_view_this, false)
		WindowSetShowing(grid_view_this, false)
		WindowSetShowing(freeform_view_this, true)	
	end
	
	LabelSetText(this.."Title", data.containerName)
	if (data.containerName and data.containerName ~= L"" and data.containerName ~= "") then
		WindowUtils.FitTextToLabel(this.."Title", data.containerName)
	end
	
	ContainerWindow.ReleaseRegisteredObjects(id)
	
	if( ContainerWindow.ViewModes[id] ~= "Freeform" ) then
		for i = 1, numItems do
			local item = data.ContainedItems[i]
			ContainerWindow.RegisteredItems[id][item.objectId] = true
			RegisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
			-- perform the initial update of this object
			ContainerWindow.UpdateObject(this,item.objectId)
			WindowSetShowing(this.."ListViewScrollChildItem"..i,true)
		end
		
		-- Update the scroll windows
		ScrollWindowUpdateScrollRect( list_view_this )   	
		local maxOffset = VerticalScrollbarGetMaxScrollPosition(list_view_this.."Scrollbar")
		if( listOffset > maxOffset ) then
		    listOffset = maxOffset
		end
		ScrollWindowSetOffset(list_view_this,listOffset)

		ScrollWindowUpdateScrollRect(grid_view_this) 
		maxOffset = VerticalScrollbarGetMaxScrollPosition(grid_view_this.."Scrollbar")
		if( gridOffset > maxOffset ) then
		    gridOffset = maxOffset
		end
		ScrollWindowSetOffset(grid_view_this,gridOffset)	
			
	end
	
	-- Rate items if it is not the players backpack
    if Player.BackpackId ~= nil and id ~= Player.BackpackId then
      ContainerWindow.RateLoot(id, this)
    end
end

function ContainerWindow.HandleUpdateObjectEvent()
    --Debug.PrintToChat("update object")
    ContainerWindow.UpdateObject(SystemData.ActiveWindow.name,WindowData.UpdateInstanceId)
end

function ContainerWindow.UpdateObject(windowName,updateId)

	if WindowData.ObjectInfo[updateId] ~= nil then
	    local gridIndex
	
		--Debug.PrintToChat(L"ContainerWindow.UpdateObject")
	    local containerId = WindowData.ObjectInfo[updateId].containerId
    	
	    -- if this object is in my container
	    if( containerId == WindowGetId(windowName) ) then
		    -- find the slot index
		    local containedItems = WindowData.ContainerWindow[containerId].ContainedItems
		    local numItems = WindowData.ContainerWindow[containerId].numItems
		    local listIndex = 0
		    for i=1, numItems do
			    if( containedItems[i].objectId == updateId ) then
				    listIndex = i
				    gridIndex = (containedItems[i].gridIndex)
				    break
			    end
		    end
		    local item = WindowData.ObjectInfo[updateId]

		    -- Icon
		    local elementIcon = windowName.."ListViewScrollChildItem"..listIndex.."Icon"
		    if item.iconName ~= "" then
          local parent = WindowGetParent(elementIcon)
          EquipmentData.UpdateItemIcon(elementIcon, item)
			    WindowClearAnchors(elementIcon)
			    WindowAddAnchor(elementIcon, "topleft", parent, "topleft", 15+((45-item.newWidth)/2), 15+((45-item.newHeight)/2))
			    WindowSetShowing(elementIcon, true)
		    else
			    WindowSetShowing(elementIcon, false)
		    end

        -- Name
        local ElementName = windowName.."ListViewScrollChildItem"..listIndex.."Name"
        LabelSetText(ElementName, item.name )
        WindowSetShowing(ElementName, true)

		    -- Grid View Icon & Quantity Label
		    if( item.iconName ~= "" ) then
			    elementIcon = windowName.."GridViewSocket"..gridIndex.."Icon"

                EquipmentData.UpdateItemIcon(elementIcon, item)	
			    
			    local gridViewItemLabel = windowName.."GridViewSocket"..gridIndex.."Quantity"
			    LabelSetText(gridViewItemLabel, L"")
			    if( item.quantity ~= nil and item.quantity > 1 ) then 
				    LabelSetText(gridViewItemLabel, L""..item.quantity)
				  end
		    end
		    
		    -- rate item
        local rating = Item.GetRating(updateId)
        local socket = windowName.."GridViewSocket"..gridIndex
        
        if rating.score ~= 0 then
          local h = rating.hue
          WindowSetTintColor(socket, h.r, h.g, h.b)
        end
	    end
	end
end

function ContainerWindow.ToggleView()
	local id = WindowGetId(WindowUtils.GetActiveDialog())
	
	if( WindowData.ContainerWindow[id].isSnooped == false ) then
        if (ContainerWindow.ViewModes[id] == "List") then
		    ContainerWindow.ViewModes[id] = "Grid"
			ContainerWindow.UpdateGridViewSockets(id)
        elseif( ContainerWindow.ViewModes[id] == "Grid" ) then 
    	    ContainerWindow.ViewModes[id] = "List"
			ContainerWindow.UpdateListViewSockets(id)
	    end

        ContainerWindow.UpdateContents(id)
    end
    
    local playerBackpack = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
	if( id == playerBackpack ) then
		SystemData.Settings.Interface.inventoryMode = ContainerWindow.ViewModes[id]
	elseif( WindowData.ContainerWindow[id].isCorpse == true ) then
		SystemData.Settings.Interface.defaultCorpseMode = ContainerWindow.ViewModes[id]
	else
		SystemData.Settings.Interface.defaultContainerMode = ContainerWindow.ViewModes[id]
	end
	
	SettingsWindow.UpdateSettings()
end

function ContainerWindow.GetSlotNumFromGridIndex(containerId, gridIndex)
    local slotNum = nil
    
    if( ContainerWindow.ViewModes[containerId] == "Grid" ) then
        local containedItems = WindowData.ContainerWindow[containerId].ContainedItems
        
        if( WindowData.ContainerWindow[containerId].ContainedItems ) then
            for index, item in ipairs(WindowData.ContainerWindow[containerId].ContainedItems) do
                --Debug.Print("Comparing to: "..tostring(item.gridIndex))
	            if( item.gridIndex == gridIndex ) then
		            slotNum = index
		            break
	            end
            end
        end
    else
        slotNum = gridIndex
    end
    
    return slotNum
end

function ContainerWindow.OnItemClicked()
	local containerId = WindowGetId(WindowUtils.GetActiveDialog())
	local slotNum = WindowGetId(SystemData.ActiveWindow.name)
	
	slotNum = ContainerWindow.GetSlotNumFromGridIndex(containerId, slotNum)

    if( slotNum ~= nil ) then
	    if( WindowData.Cursor ~= nil and WindowData.Cursor.target == true ) then
			local objectId = WindowData.ContainerWindow[containerId].ContainedItems[slotNum].objectId
			HandleSingleLeftClkTarget(objectId)
	    elseif( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_NONE ) then
			local objectId = WindowData.ContainerWindow[containerId].ContainedItems[slotNum].objectId
			DragSlotSetObjectMouseClickData(objectId, SystemData.DragSource.SOURCETYPE_CONTAINER)
	    end
	end
end

function ContainerWindow.OnItemRelease()
	if( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM ) then
	    local containerId = WindowGetId(WindowUtils.GetActiveDialog())
		local gridIndex = WindowGetId(SystemData.ActiveWindow.name)
		local slotNum = ContainerWindow.GetSlotNumFromGridIndex(containerId, gridIndex)
		local slot = nil
	
        if( WindowData.ContainerWindow[containerId].ContainedItems ~= nil and slotNum ~= nil) then
            slot = WindowData.ContainerWindow[containerId].ContainedItems[slotNum]
        end
		
		SystemData.ActiveContainer.SlotsWide = ContainerWindow.OpenContainers[containerId].slotsWide
		SystemData.ActiveContainer.SlotsHigh = ContainerWindow.OpenContainers[containerId].slotsHigh
        
		-- This happens when you drop an item onto an empty grid socket
		
		if (not slot) then
            DragSlotDropObjectToContainer(containerId,gridIndex)
			return
		end
		
		local clickedObjId = slot.objectId
        if ContainerWindow.ViewModes[containerId] == "Grid" then
            DragSlotDropObjectToObjectAtIndex(clickedObjId,gridIndex)
        else
            DragSlotDropObjectToObjectAtIndex(clickedObjId,0)
        end
         
	end
end

function ContainerWindow.OnContainerRelease(slotNum)
	if( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM ) then
		local containerId = WindowGetId(WindowUtils.GetActiveDialog())
		DragSlotDropObjectToContainer(containerId,0)
	end
end

function ContainerWindow.OnItemDblClicked()
	local containerId = WindowGetId(WindowUtils.GetActiveDialog())
	local slotNum = WindowGetId(SystemData.ActiveWindow.name)
	
	slotNum = ContainerWindow.GetSlotNumFromGridIndex(containerId, slotNum)
	if( slotNum ~= nil ) then
	    local objectId = WindowData.ContainerWindow[containerId].ContainedItems[slotNum].objectId
    	
	    UserActionUseItem(objectId,false)
	end
end

function ContainerWindow.OnItemRButtonUp()

end

function ContainerWindow.ItemMouseOver()
	local this = SystemData.ActiveWindow.name
	local index = WindowGetId(this)
	local dialog = WindowUtils.GetActiveDialog()
	local containerId = WindowGetId(dialog)
	local containedItems = WindowData.ContainerWindow[containerId].ContainedItems
    local slotNum = ContainerWindow.GetSlotNumFromGridIndex(containerId, index)
    
    if( slotNum ~= nil and containedItems and containedItems[slotNum] ~= nil ) then
	    local objectId = containedItems[slotNum].objectId
    	
	    if objectId then
		    local itemData = { windowName = dialog,
						       itemId = objectId,
		    			       itemType = WindowData.ItemProperties.TYPE_ITEM,
		    			       detail = ItemProperties.DETAIL_LONG }
		    ItemProperties.SetActiveItem(itemData)
	    end
	end
end

function ContainerWindow.OnItemGet()
	local index = WindowGetId(SystemData.ActiveWindow.name)
	local containerId = WindowGetId(WindowUtils.GetActiveDialog())
	local slotNum = ContainerWindow.GetSlotNumFromGridIndex(containerId, index)
	
	if (slotNum ~= nil) then
		local objectId = WindowData.ContainerWindow[containerId].ContainedItems[slotNum].objectId
	
		if (objectId ~= nil or objectId ~= 0) then
			-- If player is trying to get objects from a container that is not from the players backpack have it dropped
			-- into the players backpack
			if(WindowData.ContainerWindow[containerId].isCorpse == true or Interface.LoadBoolean("Lean.QuickLoot", false)) then
				if( ContainerWindow.CanPickUp == true) then
					DragSlotAutoPickupObject(objectId)
					ContainerWindow.TimePassedSincePickUp = 0
					ContainerWindow.CanPickUp = false
				else
					PrintTidToChatWindow(1045157,1)
				end
			else
				RequestContextMenu(objectId)
			end
		end
	end
end

--
-- Starts the organizers when the organize button is pressed
--
function ContainerWindow.Organizes(parent)
	--ContainerWindow.OrganizeBag = nil
	ContainerWindow.OrganizeParent = parent
	if not ContainerWindow.Organize then
		if Organizer.Organizers_Cont[Organizer.ActiveOrganizer] == 0 or ContainerWindow.OrganizeBag == nil then
			
			Debug.PrintToChat(L"[Organizer] Select a destination bag first")
			WindowRegisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT, "ContainerWindow.OrganizeTargetInfoReceived")
			RequestTargetInfo()
		else
			Debug.PrintToChat(L"[Organizer] Starting to organize " .. ContainerWindow.OrganizeBag .. L" (" .. ContainerWindow.OrganizeParent .. L")")
			ContainerWindow.OrganizeBag = Organizer.Organizers_Cont[Organizer.ActiveOrganizer]
			ContainerWindow.Organize = true
	
			return
		
		end
	end
	
	ContainerWindow.Organize = false
end

--
-- Called when a organizer bag was selected
--
function ContainerWindow.OrganizeTargetInfoReceived()
	ContainerWindow.OrganizeBag = SystemData.RequestInfo.ObjectId
	if (ContainerWindow.OrganizeBag ~= nil  and ContainerWindow.OrganizeBag ~= 0 ) then
		Debug.PrintToChat(L"[Organizer] Starting to organize")
		ContainerWindow.Organize = true
	end
	WindowUnregisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT)
end

function ContainerWindow.UpdatePickupTimer(timePassed)
  ContainerWindow.Timer = ContainerWindow.Timer + timePassed 

  -- delayed update events?
  for id,delayed in pairs(ContainerWindow.DelayedUpdate) do
    if delayed ~= nil and delayed < ContainerWindow.Timer then
      ContainerWindow.DelayedUpdate[id] = nil
      ContainerWindow.UpdateContents(id)
    end
  end

	if(ContainerWindow.CanPickUp == false) then
		ContainerWindow.TimePassedSincePickUp = ContainerWindow.TimePassedSincePickUp + timePassed
		if(ContainerWindow.TimePassedSincePickUp >= 1) then
			ContainerWindow.CanPickUp = true	
		end
	end
	
	-- Run the organizers
	if ContainerWindow.Organize then
	
	  -- Build list of objects to move
		if not moveObjects or #moveObjects == 0 then
			moveObjects = {}
			local par = ContainerWindow.OrganizeParent
			
			-- is parent open
			if par ~= nil and WindowData.ContainerWindow[par]  ~= nil then
			
			  -- loop through parent
  			local numItems = WindowData.ContainerWindow[par].numItems
  			for i = 1, numItems  do
  			
  				local item = WindowData.ContainerWindow[ContainerWindow.OrganizeParent].ContainedItems[i]
  				RegisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
  				local itemData = WindowData.ObjectInfo[item.objectId]
  				if (itemData) then
  					if (Organizer.Organizer[Organizer.ActiveOrganizer]) then
  						for j=1,  Organizer.Organizers_Items[Organizer.ActiveOrganizer] do
  							local itemL = Organizer.Organizer[Organizer.ActiveOrganizer][j]
  							if (itemL.type > 0 and itemL.type == itemData.objectType and itemL.hue == itemData.hueId) then
  								table.insert(moveObjects,item.objectId)
  								break
  							elseif(itemL.id > 0  and itemL.id == item.objectId) then
  								table.insert(moveObjects,item.objectId)
  								break
  							end
  						end
  					end	
  				end
  				UnregisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
  			end
  	  end
		end
		
		-- move a object if possible
		if moveObjects and #moveObjects > 0 and ContainerWindow.CanPickUp then
		
			local OrganizeBag = ContainerWindow.OrganizeBag
			if not OrganizeBag or OrganizeBag == 0 then
				OrganizeBag = ContainerWindow.PlayerBackpack
			end
			
			local key = moveObjects[1]
			RegisterWindowData(WindowData.ObjectInfo.Type, key)
			local itemData = WindowData.ObjectInfo[key]
			
			
			if itemData and itemData.containerId == ContainerWindow.OrganizeParent then
			  -- pick it up finally
				ContainerWindow.TimePassedSincePickUp = 0
				ContainerWindow.CanPickUp = false
				ObjectHandleWindow.lastItem = key
				
				MoveItemToContainer(key,itemData.quantity, OrganizeBag)

        -- remove it from object list
				table.remove(moveObjects, 1)
				
				-- redo like above??
				if #moveObjects == 0 then
					moveObjects = {}
					local numItems = WindowData.ContainerWindow[ContainerWindow.OrganizeParent].numItems
					for i = 1, numItems  do
						local item = WindowData.ContainerWindow[ContainerWindow.OrganizeParent].ContainedItems[i]
						RegisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
						local itemData = WindowData.ObjectInfo[item.objectId]
						if (itemData) then
							if (Organizer.Organizer[Organizer.ActiveOrganizer]) then
								for j=1,  Organizer.Organizers_Items[Organizer.ActiveOrganizer] do
									local itemL = Organizer.Organizer[Organizer.ActiveOrganizer][j]
									if (itemL.type > 0 and itemL.type == itemData.objectType and itemL.hue == itemData.hueId) then
										table.insert(moveObjects,item.objectId)
										break
									elseif(itemL.id > 0  and itemL.id == item.objectId) then
										table.insert(moveObjects,item.objectId)
										break
									end
								end
							end	
						end
						UnregisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
					end
					
					--  stop organizer
					if #moveObjects == 0 then
						ContainerWindow.Organize = false
						if Organizer.Organizers_CloseCont[Organizer.ActiveOrganizer] then
							if DoesWindowNameExist( "ContainerWindow_" .. ContainerWindow.OrganizeParent ) then
								DestroyWindow("ContainerWindow_" .. ContainerWindow.OrganizeParent)
							end
						end
					end
				end
			else
			   -- weird crap???
				table.remove(moveObjects, 1)
				if #moveObjects == 0 then
					moveObjects = {}
					local numItems = WindowData.ContainerWindow[ContainerWindow.OrganizeParent].numItems
					for i = 1, numItems  do
						local item = WindowData.ContainerWindow[ContainerWindow.OrganizeParent].ContainedItems[i]
						RegisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
						local itemData = WindowData.ObjectInfo[item.objectId]
						if (itemData) then
							if (Organizer.Organizer[Organizer.ActiveOrganizer]) then
								for j=1,  Organizer.Organizers_Items[Organizer.ActiveOrganizer] do
									local itemL = Organizer.Organizer[Organizer.ActiveOrganizer][j]
									if (itemL.type > 0 and itemL.type == itemData.objectType and itemL.hue == itemData.hueId) then
										table.insert(moveObjects,item.objectId)
										break
									elseif(itemL.id > 0  and itemL.id == item.objectId) then
										table.insert(moveObjects,item.objectId)
										break
									end
								end
							end	
						end
						UnregisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
					end
					if #moveObjects == 0 then
						ContainerWindow.Organize = false
						if Organizer.Organizers_CloseCont[Organizer.ActiveOrganizer] then
							if DoesWindowNameExist( "ContainerWindow_" .. ContainerWindow.OrganizeParent ) then
								DestroyWindow("ContainerWindow_" .. ContainerWindow.OrganizeParent)
							end
						end
					end
				end
			end
		end
		
	end
end

function ContainerWindow.ViewButtonMouseOver()
	local messageText = L""
	local containerId = WindowGetId(WindowUtils.GetActiveDialog())
	
	if (ContainerWindow.ViewModes[containerId] == "Grid" ) then
        messageText = GetStringFromTid(ContainerWindow.TID_LIST_MODE)
	elseif (ContainerWindow.ViewModes[containerId] == "List" ) then
        messageText = GetStringFromTid(ContainerWindow.TID_GRID_MODE)
    end
    
	local itemData = { windowName = SystemData.ActiveWindow.name,
						itemId = containerId,
						itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
						binding = L"",
						detail = nil,
						title =	messageText,
						body = L""}

	ItemProperties.SetActiveItem(itemData)
end

function ContainerWindow.OnResizeBegin()
	local id = WindowGetId(WindowUtils.GetActiveDialog())
	local minHeight
	local minWidth

	if (ContainerWindow.ViewModes[id] == "List") then
		minWidth = ContainerWindow.List.MinWidth
		minHeight = minWidth
	else -- "Grid"
		minWidth = ContainerWindow.Grid.MinWidth
		minHeight = minWidth
	end
	
    WindowUtils.BeginResize( WindowUtils.GetActiveDialog(), "topleft", minWidth, minHeight, false, ContainerWindow.OnResizeEnd)
end

function ContainerWindow.OnResizeEnd()
	local windowName = WindowUtils.resizeWindow
	local id = WindowGetId(windowName)

	if (ContainerWindow.ViewModes[id] == "List" ) then
        ContainerWindow.UpdateListViewSockets(id)
	elseif (ContainerWindow.ViewModes[id] == "Grid" ) then
        ContainerWindow.UpdateGridViewSockets(id)
    end
	
    ContainerWindow.UpdateContents(id) 
end

function ContainerWindow.UpdateListViewSockets(id)	
	--Debug.Print("ContainerWindow.UpdateListViewSockets("..id..")")
	
	local windowName = "ContainerWindow_"..id
	local listViewName = windowName.."ListView"
	local scrollchildName = listViewName.."ScrollChild"
	
	local windowWidth, windowHeight = WindowGetDimensions(windowName)
	local newListHeight = windowHeight - (ContainerWindow.List.PaddingTop + ContainerWindow.List.PaddingBottom)
	local newListWidth = windowWidth - (ContainerWindow.List.PaddingRight + ContainerWindow.List.PaddingLeft)
    
	WindowSetDimensions(listViewName, newListWidth, newListHeight)
    WindowSetDimensions(scrollchildName, newListWidth, newListHeight)
	
	ScrollWindowUpdateScrollRect(listViewName) 
end

function ContainerWindow.UpdateGridViewSockets(id)
	--Debug.Print("ContainerWindow.UpdateGridViewSockets("..id..")")
	
	local data = WindowData.ContainerWindow[id]
	
	local windowName = "ContainerWindow_"..id
	local gridViewName = windowName.."GridView"
	local scrollViewChildName = gridViewName.."ScrollChild"
	
	-- determine the grid dimensions based on window width and height
	local windowWidth, windowHeight = WindowGetDimensions(windowName)
	local GRID_WIDTH = math.floor((windowWidth - (ContainerWindow.Grid.PaddingLeft + ContainerWindow.Grid.PaddingRight)) / ContainerWindow.Grid.SocketSize + 0.5)	
	local GRID_HEIGHT = math.floor((windowHeight - (ContainerWindow.Grid.PaddingTop + ContainerWindow.Grid.PaddingBottom)) / ContainerWindow.Grid.SocketSize + 0.5)
	local numSockets = GRID_WIDTH * GRID_HEIGHT
	local allSocketsVisible = numSockets >= data.maxSlots
		
	-- if numSockets is less than 125, we need additional rows to provide at least 125 sockets.
	if not allSocketsVisible then
		GRID_HEIGHT = math.ceil(data.maxSlots / GRID_WIDTH)
		numSockets = GRID_WIDTH * GRID_HEIGHT
	end
	
	if not data.numGridSockets then
		ContainerWindow.CreateGridViewSockets(windowName, 1, numSockets)
	else
		-- create additional padding sockets if needed or destroy extra ones from the last resize
		if data.numGridSockets > numSockets then
			--ContainerWindow.DestroyGridViewSockets(windowName, numSockets + 1, data.numGridSockets)
		elseif data.numGridSockets < numSockets then
			ContainerWindow.CreateGridViewSockets(windowName, data.numGridSockets + 1, numSockets)
		end
	end
	data.numGridSockets = numSockets
	
	-- position and anchor the sockets
	for i = 1, data.numGridSockets do
		local socketName = windowName.."GridViewSocket"..i 
		WindowClearAnchors(socketName)
			
		if i == 1 then
			WindowAddAnchor(socketName, "topleft", scrollViewChildName, "topleft", 0, 0)
		elseif (i % GRID_WIDTH) == 1 then
			WindowAddAnchor(socketName, "bottomleft", windowName.."GridViewSocket"..i-GRID_WIDTH, "topleft", 0, 1)
		else
			WindowAddAnchor(socketName, "topright", windowName.."GridViewSocket"..i-1, "topleft", 1, 0)
		end

		WindowSetShowing(socketName, true)
	end
	
	-- dimensions for the entire grid view with GRID_WIDTH x GRID_HEIGHT dimensions
	local newGridWidth = GRID_WIDTH * ContainerWindow.Grid.SocketSize + ContainerWindow.Grid.PaddingLeft
	local newGridHeight = GRID_HEIGHT * ContainerWindow.Grid.SocketSize + ContainerWindow.Grid.PaddingTop
	
	-- fit the window width to the grid width
	local newWindowWidth = newGridWidth + ContainerWindow.Grid.PaddingRight
	local newWindowHeight = windowHeight - ((windowHeight - 65) % ContainerWindow.Grid.SocketSize) + ContainerWindow.Grid.SocketSize
	
	-- if we can see every slot in the container, snap the window height to the grid and hide the void created 
	-- by the missing scrollbar
	if allSocketsVisible then
		newWindowHeight = newGridHeight + ContainerWindow.Grid.PaddingBottom
		newWindowWidth = newWindowWidth - ContainerWindow.ScrollbarWidth
	else
		--newWindowHeight = windowHeight
		newGridHeight = windowHeight - (ContainerWindow.Grid.PaddingBottom + ContainerWindow.Grid.PaddingTop)
	end
	
	WindowSetDimensions(windowName, newWindowWidth, newWindowHeight)
	WindowSetDimensions(gridViewName, newGridWidth, newGridHeight)
	WindowSetDimensions(scrollViewChildName, newGridWidth, newGridHeight)
	
	ScrollWindowUpdateScrollRect(gridViewName) 
	
	if ContainerWindow.OpenContainers[id] then
		ContainerWindow.OpenContainers[id].slotsWide = GRID_WIDTH
		ContainerWindow.OpenContainers[id].slotsHigh = GRID_HEIGHT
	end
	
	Debug.Print("ContainerWindow.UpdateGridViewSockets("..id..") end")
end

function ContainerWindow.CreateGridViewSockets(dialog, lower, upper)
	local id = WindowGetId(dialog)
	local data = WindowData.ContainerWindow[id]
	
	if not lower then
		lower = 1
	end
	
	if not upper then
		upper = data.maxSlots
	end

	--Debug.Print("ContainerWindow.CreateGridViewSockets("..dialog..") lower = "..lower.." upper = "..upper)
	
	local parent = dialog.."GridViewScrollChild"
	
	for i = lower, upper do
		
		local socketName = dialog.."GridViewSocket"..i 
		local socketTemplate


		--Debug.Print("Adding socket ".. socketName)
		
		if i > data.maxSlots then
			socketTemplate = "GridViewSocketBaseTemplate"
		else
			socketTemplate = "GridViewSocketTemplate"
		end
		
		-- use the transparent grid background for legacy container views
		local legacyContainersMode = SystemData.Settings.Interface.LegacyContainers
		if( legacyContainersMode == true ) then
		    socketTemplate = "GridViewSocketLegacyTemplate"
		end
		
		CreateWindowFromTemplate(socketName, socketTemplate, parent)
		WindowSetId(socketName, i)
		WindowSetShowing(socketName, false)
		
		if i > data.maxSlots then
			WindowSetAlpha(socketName, 0.5)
			WindowSetTintColor(socketName, 10, 10, 10)
		end
	end
	
	WindowSetShowing(dialog.."GridView", false)
end

function ContainerWindow.DestroyGridViewSockets(dialog, lower, upper)
	local id = WindowGetId(dialog)
	local data = WindowData.ContainerWindow[id]
	
	if not lower then
		lower = 1
	end
	
	if not upper then
    upper = data.maxSlots
	end

	for i = lower, upper do
		local socketName = dialog.."GridViewSocket"..i 
		DestroyWindow(socketName)
	end
end

function ContainerWindow.GetTopOfCascade()
	local cascadeSize = table.getn(ContainerWindow.Cascade)
	if cascadeSize > 0 then
		-- loop from n to 1 , removing windows with cascading == false and returning the first
		-- with cascading == true
		for i = cascadeSize, 1, -1 do
			local windowId = ContainerWindow.Cascade[i]
			if ContainerWindow.IsCascading(windowId) then
				return windowId
			else
				ContainerWindow.Cascade[i] = nil
			end
		end
	end
	
	return nil;
end

function ContainerWindow.IsCascading(windowId)
	if ContainerWindow.OpenContainers[windowId] then
		return ContainerWindow.OpenContainers[windowId].cascading
	else
		return false
	end
end

function ContainerWindow.AddToCascade(windowId)
	if ContainerWindow.OpenContainers[windowId] then
		local cascadeSize = table.getn(ContainerWindow.Cascade) + 1
		ContainerWindow.Cascade[cascadeSize] = windowId
		ContainerWindow.OpenContainers[windowId].cascading = true
	end
end

function ContainerWindow.RemoveFromCascade(windowId)
	-- since this is called often. the ContainerWindow.Cascade array is resized in GetTopOfCascade
	if ContainerWindow.OpenContainers[windowId] then
		ContainerWindow.OpenContainers[windowId].cascading = false
	end
end



function ContainerWindow.ShowOptions()
  local params = {
    dialog = WindowUtils.GetActiveDialog(),
    container = WindowGetId(WindowUtils.GetActiveDialog())
  }

  ContextMenu.CreateLuaContextMenuItem("Run organizer", 0, 1, params)
  ContextMenu.CreateLuaContextMenuItem("Rate loot", 0, 2, params)
  ContextMenu.ActivateLuaContextMenu(ContainerWindow.OptionsCallback)
end

function ContainerWindow.OptionsCallback(code, params)
  if code == 1 then
    ContainerWindow.Organizes(params.container)
  elseif code == 2 then
    ContainerWindow.RateLoot(params.container, params.dialog)
  end
  
  ContextMenu.Hide()
end

function ContainerWindow.RateLoot(id, dialog)
  local data = WindowData.ContainerWindow[id]
  
  if data == nil then
    Debug.PrintToChat("No container data registered.")
    return
  end
  
  for i=1, data.numItems do
    local item = data.ContainedItems[i]
    local rating = Item.GetRating(item.objectId)
    local socket = dialog.."GridViewSocket"..item.gridIndex
    
    if rating.score ~= 0 then
      local h = rating.hue      
      WindowSetTintColor(socket, h.r, h.g, h.b)
    else
      WindowSetTintColor(socket, 255, 255, 255)
    end
  end
end
