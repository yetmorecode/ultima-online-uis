----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

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
ContainerWindow.ScrollbarWidth = 12
ContainerWindow.Grid = {}
--TODO: Get rid of as much of this synamic stuff as possible.
ContainerWindow.Grid.PaddingTop = 50
ContainerWindow.Grid.PaddingLeft = 12
ContainerWindow.Grid.PaddingBottom = 15
ContainerWindow.Grid.PaddingRight = 26
ContainerWindow.Grid.SocketSize = 57
ContainerWindow.Grid.MinWidth = 320
ContainerWindow.Grid.NumSockets = {}
ContainerWindow.List = {}
ContainerWindow.List.PaddingRight = 14
ContainerWindow.List.LabelPaddingRight = ContainerWindow.ScrollbarWidth + ContainerWindow.List.PaddingRight + 5
-- used for windows the player doesn't own
ContainerWindow.Cascade = {}
ContainerWindow.Cascade.Movement = { x=0, y=0 }
ContainerWindow.PlayerBackpack = 0
ContainerWindow.PlayerBank = 0
ContainerWindow.IgnoreItems = {}
ContainerWindow.OpenedCorpse = 0
ContainerWindow.waitItems = 0
ContainerWindow.waitGump = 0
ContainerWindow.DeltaRefresh = 0
ContainerWindow.delta = 0 
ContainerWindow.Locked = false
-- TODO: remove from settings...
ContainerWindow.BaseGridColor = { r=255, g=255, b=255 }
ContainerWindow.AlternateBackpack = { r=80, g=80, b=80 }
ContainerWindow.LastUsesDelta = {}
ContainerWindow.CurrentUses = {}
ContainerWindow.TODO = {}
ContainerWindow.EnableAutoIgnoreCorpses = true
--ContainerWindow.RefreshRate = 0.1
--ContainerWindow.MaxSlotsPerGrid = 300 -- max number of slots allowed for the grid mode, any amount greater than this one will turn the container to list view.
ContainerWindow.PickupWaitTime = 1
ContainerWindow.ShortUsesDelta = 0
ContainerWindow.GetContentDelta = {}
ContainerWindow.Grid.LastDragFromIndex = 0
ContainerWindow.MAX_INVENTORY_SLOTS = 125
ContainerWindow.MAX_BANK_SLOTS = 175
ContainerWindow.RefreshRate = 0.1
ContainerWindow.MaxSlotsPerGrid = ContainerWindow.MAX_INVENTORY_SLOTS-- max number of slots allowed for the grid mode, any amount greater than this one will turn the container to list view.
ContainerWindow.PickupWaitTime = 1
ContainerWindow.LootAll = {}


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

-- OnInitialize Handler
function ContainerWindow.Initialize()

	local id = SystemData.DynamicWindowId
	Debug.Print("container..." .. id)
	this = "ContainerWindow_" .. id
	if id == Interface.TrapBoxID then
		WindowSetShowing(this, false)
	end
	if (id == ContainerWindow.PlayerBackpack) then
		Interface.BackpackOpen = true
		Interface.SaveBoolean( "BackpackOpen", Interface.BackpackOpen  )
	end
	ContainerWindow.GetContentDelta[id] = 0

	WindowSetId(this, id)
	WindowSetAlpha(this, .95)
	
	Interface.DestroyWindowOnClose[this] = true

	ContainerWindow.OpenContainers[id] = {open = true, cascading = false, slotsWide = 0, slotsHigh = 0}	

	WindowRegisterEventHandler(this, WindowData.ContainerWindow.Event, "ContainerWindow.MiniModelUpdate")
	WindowRegisterEventHandler(this, WindowData.ObjectInfo.Event, "ContainerWindow.HandleUpdateObjectEvent")

	-- Scanned containers maybe already registered
	if WindowData.ContainerWindow[id] then
		UnregisterWindowData(WindowData.ContainerWindow.Type, id)		
	end

	RegisterWindowData(WindowData.ContainerWindow.Type, id)	
	RegisterWindowData(WindowData.PlayerEquipmentSlot.Type, EquipmentData.EQPOS_BACKPACK)	
	
	--UnregisterWindowData(WindowData.ContainerWindow.Type, id)
	--RegisterWindowData(WindowData.ContainerWindow.Type, id)	
	--RegisterWindowData(WindowData.PlayerEquipmentSlot.Type, EquipmentData.EQPOS_BACKPACK)	
	--WindowRegisterEventHandler(this, WindowData.ContainerWindow.Event, "ContainerWindow.MiniModelUpdate")
	--WindowRegisterEventHandler(this, WindowData.ObjectInfo.Event, "ContainerWindow.HandleUpdateObjectEvent")

	--Debug.Print("WindowData.ContainerWindow[id] ================")
	--Debug.Print(WindowData.ContainerWindow[id])
	--Debug.Print("----------")

	

	local gumpID, typeName, mytexture = ContainersInfo.GetGump(id, WindowData.ContainerWindow[id].gumpNum)
	--Debug.Print("found... gumpId: " .. gumpID .. " typeName: " .. typeName .. " texture: " .. tostring(mytexture))

	
	WindowData.ContainerWindow[id].isCorpse = WindowData.ContainerWindow[id].gumpNum == ContainersInfo.DefaultCorpse
	--Debug.Print("Corpse? "..tostring(WindowData.ContainerWindow[id].isCorpse))
	
	if WindowData.ContainerWindow[id].isCorpse then
		-- HACK: containerName is empty on first load of corpses???
		WindowData.ContainerWindow[id].containerName = L"Corpse..."
		ContainerWindow.ViewModes[id] = SystemData.Settings.Interface.defaultCorpseMode
		if ( ContainerWindow.OpenedCorpse ~= 0 and ContainerWindow.EnableAutoIgnoreCorpses) then
			local count = table.getn(ContainerWindow.IgnoreItems)
			local found = false
			for i=1, count do
				if ( ContainerWindow.IgnoreItems[i] and ContainerWindow.IgnoreItems[i].id == ContainerWindow.OpenedCorpse) then
					ObjectHandle.DestroyObjectWindow(ContainerWindow.IgnoreItems[i].id) 
					ContainerWindow.OpenedCorpse = 0
					found = true
					break
				end
    		end
    		if ( not found ) then
    			local data =  { id = ContainerWindow.OpenedCorpse, decayTime = Interface.Clock.Timestamp + 1800}
    			table.insert(ContainerWindow.IgnoreItems, data)
    			ObjectHandleWindow.ForceIgnore = ContainerWindow.OpenedCorpse
				ContainerWindow.OpenedCorpse = 0
    		end
		end
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
		-- use the default container mode
		ContainerWindow.ViewModes[id] = SystemData.Settings.Interface.defaultContainerMode
	end
		
	
	WindowData.ContainerWindow[id].numCreatedSlots = 0
	WindowData.ContainerWindow[id].maxSlots = SystemData.ActiveContainer.NumSlots
	
	-- if this is the players backpack then update the paperdoll backpack icon
	if (WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK]) then
		if( id == ContainerWindow.PlayerBackpack ) then
			ContainerWindow.SetInventoryButtonPressed(true)
			--WindowSetShowing( this.."LootAll", false )
		end
	end
	
	--if (data and data.containerName and data.containerName ~= L"" and data.containerName ~= "") then
		--Debug.Print("$$$$$$")
		--Debug.Print(data)
	    local playerBackpack = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
		if( id == playerBackpack ) then
			WindowUtils.SetActiveDialogTitle(L"Inventory")
			--WindowUtils.FitTextToLabel(this.."Title", L"Inventory")
		else
			--TODO: localize
			WindowUtils.SetActiveDialogTitle(WindowData.ContainerWindow[id].containerName)
			--WindowUtils.FitTextToLabel(this.."Title", data.containerName)
		end
	--end

	WindowSetShowing(this.."Lock", false)
	WindowSetShowing(this.."Unlock", false)
	WindowSetShowing(this.."Organize", false)
	WindowSetShowing(this.."Restock", false)	
	WindowSetShowing(this.."Search", false)			
	--WindowSetShowing(this.."LootAll", false)
	--WindowSetShowing(this.."LootConfiguration", false)		
	LabelSetText(this.."ViewList", L"Ó")
	LabelSetText(this.."ViewGrid", L"+")
	LabelSetText(this.."Search", L"#")
	LabelSetText(this.."LootConfiguration", L"ɣ")
	LabelSetText(this.."VendorConfiguration", L"ɩ")
	LabelSetText(this.."Organize", L"Ş")
	LabelSetText(this.."Restock", L"ɕ")
	LabelSetText(this.."LootAll", L"î")
	LabelSetText(this.."Watch", L"î")


	--WindowSetScale(this.."LootConfiguration", .5)

	
	
	
	--LabelSetTextColor(this.."LootConfigurationLabel", 120,90,60)
	
	ContainerWindow.SetViewButton(id)
	
	
	if (WindowData.ContainerWindow[id].maxSlots > ContainerWindow.MaxSlotsPerGrid and ContainerWindow.ViewModes[id] ~= "Freeform") then
		ContainerWindow.ViewModes[id] = "List"
		--WindowSetShowing(this.. "ViewButton", false)
	end
	
	--WindowSetScale(this, SystemData.Settings.Interface.customUiScale * 0.80)

	-- if this container belongs to the player then use the saved position
	if IsInPlayerBackPack(id) then
		--Debug.Print(this)
		WindowUtils.RestoreWindowPosition(this, true)
		
		-- if the window position can't be restored, try to place this container near its parent container
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
		
		if( id == ContainerWindow.PlayerBackpack ) then
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
		--ContainerWindow.UpdateListViewSockets(id)
	else
		-- default to grid view if not using list or freeform containers
		ContainerWindow.ViewModes[id] = "Grid"
		--ContainerWindow.UpdateGridViewSockets(id)
	end
	--ContainerWindow.UpdateContents(id)

	ContainerWindow.LegacyGridDock(this)	

	ContainerWindow.UpdateUses(id)

	-- Add Container ID to TODO List because all items are not loaded yet
	-- This will be done multiple times so we are sure the uses are correctly updated as soon as possible.
	local td = {func = function() ContainerWindow.UpdateUses(id) end, time = Interface.TimeSinceLogin + 1}
	table.insert(ContainerWindow.TODO, td)

	if Interface.BackpackFirstPositioning and id == ContainerWindow.PlayerBackpack then
		WindowClearAnchors(this)
		WindowAddAnchor(this, "bottomright", "AdvancedStatusWindowSTAM", "bottomleft", -60, 50)
		local x, y= WindowGetOffsetFromParent(this)
		WindowClearAnchors(this)
		WindowSetOffsetFromParent(this, x,y)
	end
	
	-- BUG: xml dimensions are being overridden by settings for some reason. Need to force dimensions.
	WindowSetDimensions(this, 330, 440)

	WindowUtils.LoadScale( this )

end

function ContainerWindow.SetViewButton()
	local id = WindowGetId(WindowUtils.GetActiveDialog())
	-- init the view icon...
	WindowSetShowing(this.."ViewGrid", false)
	WindowSetShowing(this.."ViewList", false)
	if (ContainerWindow.ViewModes[id] == "List") then
		WindowSetShowing(this.."ViewGrid", true)
		WindowSetShowing(this.."ViewList", false)
    elseif( ContainerWindow.ViewModes[id] == "Grid" ) then 
		WindowSetShowing(this.."ViewGrid", false)
		WindowSetShowing(this.."ViewList", true)
	end
end

function ContainerWindow.Shutdown()
	local checkContainerArt = tonumber( requestedContainerArt )
	if checkContainerArt then
		ReleaseGumpArt( checkContainerArt )
	end

	local id = WindowGetId(WindowUtils.GetActiveDialog())
	this = "ContainerWindow_"..id
			
	-- if the container is in the cascade, don't save its position
	if ContainerWindow.IsCascading(id) then
		ContainerWindow.RemoveFromCascade(id)
	elseif id ~= Interface.TrapBoxID then
		WindowUtils.SaveWindowPosition(this)
	end
	
	if ContainerWindow.waitItems == id then
		ContainerWindow.waitItems = 0
	end
	
	if ContainerWindow.waitGump == id then
		ContainerWindow.waitGump = 0
	end
	
	if ContainerWindow.waitLegacy == id then
		ContainerWindow.waitLegacy = 0
	end
	
	if IsInPlayerBackPack(id) then
		
		-- iterate through the shared vector looking for our container id
		for i, windowId in ipairs(SystemData.Settings.Interface.ContainerViewModes.Ids) do
			if windowId == id then
				SystemData.Settings.Interface.ContainerViewModes.ViewModes[i] = ContainerWindow.ViewModes[id]
				break
			end
		end
		
		if( id == ContainerWindow.PlayerBackpack ) then
			ContainerWindow.SetInventoryButtonPressed(false)
		end 
	end
	
	ContainerWindow.ReleaseRegisteredObjects(id)
	
	ContainerWindow.ViewModes[id] = nil
	ContainerWindow.OpenContainers[id] = nil
	
	ContainerWindow.GetContentDelta[id] = nil
	ContainerWindow.CurrentUses[id] = nil
	ContainerWindow.LastUsesDelta[id] = nil
	
	UnregisterWindowData(WindowData.ContainerWindow.Type, id)
	UnregisterWindowData(WindowData.PlayerEquipmentSlot.Type, EquipmentData.EQPOS_BACKPACK)
	
	if( ItemProperties.GetCurrentWindow() == this ) then
		ItemProperties.ClearMouseOverItem()
	end
	
	GumpManagerOnCloseContainer(id)
end


function ContainerWindow.LegacyGridDock(this)
	if not DoesWindowNameExist(this) then
		return
	end
	local id = WindowGetId(this)
	if id == Interface.TrapBoxID then
		return
	end

	WindowSetShowing(this.."GridView", false)
	WindowSetShowing(this.."ListView", false)
	WindowSetShowing(this.."ResizeButton", false)

	if not id or not WindowData.ContainerWindow[id] then
		return
	end	

	local data = WindowData.ContainerWindow[id]
	
	WindowSetShowing(this, true)
	local isNotBankBox = true
	if(WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BANK] and id == WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BANK].objectId)then
		isNotBankBox = false
	end

	
	local numSockets = ContainerWindow.MAX_INVENTORY_SLOTS
	if( data and isNotBankBox == false and data.maxSlots > ContainerWindow.MAX_INVENTORY_SLOTS) then	
		numSockets = data.maxSlots		
	end		
	ContainerWindow.CreateGridViewSockets(this, 1, numSockets)
			
	if (ContainerWindow.PlayerBackpack == id ) then
		if (ContainerWindow.Locked) then		
			WindowSetShowing(this.."Lock", true)
			WindowSetShowing(this.."Unlock", false)
		else
			WindowSetShowing(this.."Lock", false)
			WindowSetShowing(this.."Unlock", true)
		end
			
		WindowSetMovable(this,not ContainerWindow.Locked )
	end

	WindowSetShowing(this.."Search", true)
	WindowSetShowing(this.."LootConfiguration", true)	
	if (ContainerWindow.PlayerBackpack ~= id) then
		WindowSetShowing(this.."Organize", true)
		WindowSetShowing(this.."Restock", true)
		WindowSetShowing(this.."LootAll", true)
	else
					
	end
	
	if (ContainerWindow.ViewModes[id] == "Grid") then
		ContainerWindow.UpdateGridViewSockets(id)
		-- Do we really care about offset when reopening a container???	
		if DoesPlayerHaveItem(id)  or id == ContainerWindow.PlayerBank or id == ContainerWindow.PlayerBackpack then
			local windowName = "ContainerWindow_"..id
			local gridViewName = windowName.."GridView" 
			ScrollWindowSetOffset(gridViewName,Interface.LoadNumber("ScrollGrid" .. id, 0))
		end
	end

end

function ContainerWindow.SearchItem()
	ContainerSearch.Container = WindowGetId(WindowUtils.GetActiveDialog())
	ContainerSearch.Toggle()	
end

function ContainerWindow.SearchAllTooltip()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(1154791))
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
	ContainerWindow.GenericOver()
end

function ContainerWindow.LootConfigurationTooltip()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  L"Loot Configuration")
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
	ContainerWindow.GenericOver()
end

function ContainerWindow.LootAllBtn()
	local oldOrganizeParent = ContainerWindow.OrganizeParent
	ContainerWindow.OrganizeParent = WindowGetId(WindowUtils.GetActiveDialog())

	if(oldOrganizeParent ~= nil and oldOrganizeParent ~= ContainerWindow.OrganizeParent)then
		ContainerWindow.LootAll[oldOrganizeParent] = nil
	end

	if(ContainerWindow.LootAll[ContainerWindow.OrganizeParent] == nil)then
		ContainerWindow.LootAll[ContainerWindow.OrganizeParent] = ContainerWindow.OrganizeParent
	else
		ContainerWindow.LootAll[ContainerWindow.OrganizeParent] = nil
	end	
end

function ContainerWindow.LootAllTooltip()
	local windowID = WindowGetId(WindowUtils.GetActiveDialog())
	if (ContainerWindow.LootAll[windowID] == nil) then
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(1154783))
	else
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(1154788))
	end
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
	ContainerWindow.GenericOver()
end


function ContainerWindow.LockTooltip()
	
	if ( ContainerWindow.Locked ) then
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1154784))
	else
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(1154785))
	end
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function ContainerWindow.OrganizerContext()
	if ( not ContainerWindow.Organize) then
		for i=1, Organizer.Organizers do
			local name = ReplaceTokens(GetStringFromTid(1155441), {towstring( i ) } )
			if (Organizer.Organizers_Desc[i] ~= L"") then
				name = Organizer.Organizers_Desc[i]
			end
			ContextMenu.CreateLuaContextMenuItemWithString(name ,0,i,2,Organizer.ActiveOrganizer == i)
		end
		ContextMenu.ActivateLuaContextMenu(ContainerWindow.ContextMenuCallback)
	end
end

function ContainerWindow.ContextMenuCallback( returnCode, param )
	Organizer.ActiveOrganizer = returnCode
	Interface.SaveNumber( "OrganizerActiveOrganizer" , Organizer.ActiveOrganizer )
end

function ContainerWindow.Organizes()
	
	ContainerWindow.OrganizeBag = nil
	ContainerWindow.OrganizeParent = nil
	if ( not ContainerWindow.Organize) then
		ContainerWindow.OrganizeParent = WindowGetId(WindowUtils.GetActiveDialog())
		if (Organizer.Organizers_Cont[Organizer.ActiveOrganizer] == 0) then
			RequestTargetInfo()
			WindowUtils.SendOverheadText(GetStringFromTid(1154773), 1152, true)
			WindowRegisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT, "ContainerWindow.OrganizeTargetInfoReceived")
		else
			ContainerWindow.OrganizeBag = Organizer.Organizers_Cont[Organizer.ActiveOrganizer]
			ContainerWindow.Organize = true
			return
		end
	end
	
	ContainerWindow.Organize = false
end

function ContainerWindow.OrganizeTargetInfoReceived()
	ContainerWindow.OrganizeBag = SystemData.RequestInfo.ObjectId
	if (ContainerWindow.OrganizeBag ~= nil  and ContainerWindow.OrganizeBag ~= 0 ) then
		ContainerWindow.Organize = true
	end
	WindowUnregisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT)
	
end

function ContainerWindow.OrganizeTooltip()
	if (not ContainerWindow.Organize) then
		local name = L" Organizer " .. Organizer.ActiveOrganizer
		if (Organizer.Organizers_Desc[Organizer.ActiveOrganizer] ~= L"") then
			name = L" " .. Organizer.Organizers_Desc[Organizer.ActiveOrganizer]
		end
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  ReplaceTokens(GetStringFromTid(1154789), {name}))
	else
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(1154786))
	end
	
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
	ContainerWindow.GenericOver()
end

function ContainerWindow.RestockContext()
	if ( not ContainerWindow.Restock) then
		for i=1, Organizer.Restocks do
			local name = ReplaceTokens(GetStringFromTid(1155443), {towstring( i ) } ) 
			if (Organizer.Restocks_Desc[i] ~= L"") then
				name = Organizer.Restocks_Desc[i]
			end
			ContextMenu.CreateLuaContextMenuItemWithString(name,0,i,2,Organizer.ActiveRestock == i)
		end
		ContextMenu.ActivateLuaContextMenu(ContainerWindow.RestockContextMenuCallback)
	end
end

function ContainerWindow.RestockContextMenuCallback( returnCode, param )
	Organizer.ActiveRestock = returnCode
	Interface.SaveNumber( "OrganizerActiveRestock" , Organizer.ActiveRestock )
end

function ContainerWindow.RestockTooltip()
	if (not ContainerWindow.Restock) then
		local name = ReplaceTokens(GetStringFromTid(1155444), {towstring( Organizer.ActiveRestock ) } ) 
		if (Organizer.Restocks_Desc[Organizer.ActiveRestock] ~= L"") then
			name = Organizer.Restocks_Desc[Organizer.ActiveRestock]
		end
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(1155427) .. L"\n".. ReplaceTokens(GetStringFromTid(1155265), { name }))
	else
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(1154787))
	end
	
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
	ContainerWindow.GenericOver()
end

function ContainerWindow.Restocks()
	
	ContainerWindow.OrganizeBag = nil
	ContainerWindow.OrganizeParent = nil
	if ( not ContainerWindow.Restock) then
		ContainerWindow.OrganizeParent = WindowGetId(WindowUtils.GetActiveDialog())
		if (Organizer.Restocks_Cont[Organizer.ActiveRestock] == 0) then
			RequestTargetInfo()
			WindowUtils.SendOverheadText(GetStringFromTid(1154773), 1152, true)
			WindowRegisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT, "ContainerWindow.RestockTargetInfoReceived")
		else
			ContainerWindow.OrganizeBag = Organizer.Restocks_Cont[Organizer.ActiveRestock]
			ContainerWindow.CurrentAmountArray = {}
			for i=1,  Organizer.Restocks_Items[Organizer.ActiveRestock] do
				local itemL = Organizer.Restock[Organizer.ActiveRestock][i]
				if not ContainerWindow.CurrentAmountArray[itemL.type] then
					ContainerWindow.CurrentAmountArray[itemL.type] = {}
				end
				if not ContainerWindow.CurrentAmountArray[itemL.type][itemL.hue] then
					ContainerWindow.CurrentAmountArray[itemL.type][itemL.hue] = 0
				end
				ContainerWindow.CurrentAmountArray[itemL.type][itemL.hue] = 0
			end
			
			RegisterWindowData(WindowData.ContainerWindow.Type, ContainerWindow.OrganizeBag)
			if WindowData.ContainerWindow[ContainerWindow.OrganizeBag] then
				local numItems = WindowData.ContainerWindow[ContainerWindow.OrganizeBag].numItems
				for i = 1, numItems  do
					local item = WindowData.ContainerWindow[ContainerWindow.OrganizeBag].ContainedItems[i]
					local itemData = WindowData.ObjectInfo[item.objectId]
					for tp, h in pairs(ContainerWindow.CurrentAmountArray) do
						if (tp == itemData.objectType and h[itemData.hueId]) then
							ContainerWindow.CurrentAmountArray[itemData.objectType][itemData.hueId] =ContainerWindow.CurrentAmountArray[itemData.objectType][itemData.hueId] + itemData.quantity							
						end
					end
				end
			else
				WindowUtils.SendOverheadText(GetStringFromTid(1154790), 33, true)
				ContainerWindow.OrganizeBag = nil
				return
			end

			ContainerWindow.Restock = true
			return
		end
	end
	
	ContainerWindow.Restock = false
end

function ContainerWindow.RestockTargetInfoReceived()

	ContainerWindow.OrganizeBag = SystemData.RequestInfo.ObjectId
	if (ContainerWindow.OrganizeBag ~= nil and ContainerWindow.OrganizeBag ~= 0) then
		ContainerWindow.CurrentAmountArray = {}
		for i=1,  Organizer.Restocks_Items[Organizer.ActiveRestock] do
			local itemL = Organizer.Restock[Organizer.ActiveRestock][i]
			if not ContainerWindow.CurrentAmountArray[itemL.type] then
				ContainerWindow.CurrentAmountArray[itemL.type] = {}
			end
			if not ContainerWindow.CurrentAmountArray[itemL.type][itemL.hue] then
				ContainerWindow.CurrentAmountArray[itemL.type][itemL.hue] = 0
			end
			ContainerWindow.CurrentAmountArray[itemL.type][itemL.hue] = 0
		end
		
		if WindowData.ContainerWindow[ContainerWindow.OrganizeBag] then
			local numItems = WindowData.ContainerWindow[ContainerWindow.OrganizeBag].numItems
			for i = 1, numItems  do
				local item = WindowData.ContainerWindow[ContainerWindow.OrganizeBag].ContainedItems[i]
				local itemData = WindowData.ObjectInfo[item.objectId]
				for tp, h in pairs(ContainerWindow.CurrentAmountArray) do
					if (tp == itemData.objectType and h[itemData.hueId]) then
						ContainerWindow.CurrentAmountArray[itemData.objectType][itemData.hueId] =ContainerWindow.CurrentAmountArray[itemData.objectType][itemData.hueId] + itemData.quantity
					end
				end
			end
		else
			WindowUnregisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT)
			WindowUtils.SendOverheadText(GetStringFromTid(1155445), 33, true)
			ContainerWindow.OrganizeBag = nil
			return
		end
		ContainerWindow.Restock = true
	end
	WindowUnregisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT)
	
end

function ContainerWindow.Lock()
	local dialog = WindowUtils.GetActiveDialog()
	ContainerWindow.Locked = not ContainerWindow.Locked 
	Interface.SaveBoolean("LockedBackpack", ContainerWindow.Locked)
	WindowSetMovable(dialog, not ContainerWindow.Locked)
	if ( ContainerWindow.Locked ) then		
		WindowSetShowing(this.."Lock", true)
		WindowSetShowing(this.."Unlock", false)
	else
		WindowSetShowing(this.."Lock", false)
		WindowSetShowing(this.."Unlock", true)
	end
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
	local my_paperdoll = "PaperdollWindow"..WindowData.PlayerStatus.PlayerId
	local my_paperdoll_backpackicon = "PaperdollWindow"..WindowData.PlayerStatus.PlayerId.."ToggleInventory"
	if DoesWindowNameExist(my_paperdoll) and WindowGetShowing(my_paperdoll) then
		ButtonSetPressedFlag( my_paperdoll_backpackicon, pressed)
	end	
end

function ContainerWindow.HideAllContents(parent, numItems)
	if not DoesWindowNameExist(parent) then
		return
	end
	local id = WindowGetId(parent)
	local data = WindowData.ContainerWindow[id]
	local maxSlots = 125
	if data then
		maxSlots = data.maxSlots
	end
	for i=1,maxSlots do
		if DoesWindowNameExist(parent.."GridViewSocket"..i.."Icon") then
			DynamicImageSetTexture(parent.."GridViewSocket"..i.."Icon", "", 0, 0);
			if DoesWindowNameExist(parent.."GridViewSocket"..i.."IconMulti") then
				DynamicImageSetTexture( parent.."GridViewSocket"..i.."IconMulti", "", 0, 0 )
			end
			-- Doesn't work...
			--WindowRestoreDefaultSettings(parent.."GridViewSocket"..i.."Background")
			WindowSetTintColor(parent.."GridViewSocket"..i.."IconBorder", 255, 255, 255)
			WindowSetTintColor(parent.."GridViewSocket"..i.."Background", 255, 255, 255)
			WindowSetAlpha(parent.."GridViewSocket"..i.."Background", 1)
			LabelSetText(parent.."GridViewSocket"..i.."Quantity", L"")
			LabelSetText(parent.."GridViewSocket"..i.."Title", L"")
		end
		if i <= numItems then
			if DoesWindowNameExist(parent.."ListViewScrollChildItem"..i) then
				LabelSetText(parent.."ListViewScrollChildItem"..i.."Name", L"" )
				DynamicImageSetTexture(parent.."ListViewScrollChildItem"..i.."Icon", "", 0, 0);
				WindowSetShowing(parent.."ListViewScrollChildItem"..i, false)
			end
		end
	end
end

function ContainerWindow.CreateListViewSlots(dialog, low, high)
	local parent = dialog.."ListViewScrollChild"
	for i=low, high do
		slotName = parent.."Item"..i
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
	if id == Interface.TrapBoxID then
		return
	end

	if (ContainerWindow.OpenContainers[id] and ContainerWindow.OpenContainers[id].inUpdate) then		
		return
	end
	if( id == WindowGetId(SystemData.ActiveWindow.name) ) then		
		ContainerWindow.OpenContainers[id].dirty = 1
	end	
end

function ContainerWindow.BackpackItemsCheck()
	if (Interface.BackPackItems)then
		local serverId = WindowData.SkillsCSV[16].ServerId
		local discoSkillLevel = WindowData.SkillDynamicData[serverId].RealSkillValue / 10
		
		serverId = WindowData.SkillsCSV[41].ServerId
		local peaceSkillLevel = WindowData.SkillDynamicData[serverId].RealSkillValue / 10
		
		serverId = WindowData.SkillsCSV[43].ServerId
		local provoSkillLevel = WindowData.SkillDynamicData[serverId].RealSkillValue / 10
	
		local data = WindowData.ContainerWindow[playerBackpack]
		if data then
			for i = 1, #Interface.BackPackItems do
				if not WindowData.ObjectInfo[Interface.BackPackItems[i]] then
					RegisterWindowData(WindowData.ObjectInfo.Type, Interface.BackPackItems[i])
				end
				local item =  WindowData.ObjectInfo[Interface.BackPackItems[i]]
				if (item) then
					if (item.objectType == 12629 and item.hueId == 0) then
						local prop = ItemProperties.GetObjectPropertiesParamsForTid( Interface.BackPackItems[i], 1060485, "Backpack check - Arcane focus parsing" ) -- strength bonus ~1_val~
						if prop then
							Interface.ArcaneFocusLevel = tonumber(prop[1])
						end
					elseif(item.objectType == 8794 and item.hueId == 0) then
						if discoSkillLevel >= 90 or peaceSkillLevel >= 90 or provoSkillLevel >= 90 then
							Interface.BardMastery = true
						else
							Interface.BardMastery = false
						end
					end
				end
			end
		end
	end
end

function ContainerWindow.UpdateContents(id)	
	this = "ContainerWindow_"..id
	
	if id == Interface.TrapBoxID then
		return
	end
	if(not DoesWindowNameExist(this)) then
		return
	end
	
	local list_view_this = this.."ListView"        
	local grid_view_this = this.."GridView"
	local data = WindowData.ContainerWindow[id]
	
	if not data then
		return
	end
	
	--Debug.Print(data)

	





	-- TODO: find the best place for this...
	-- get the backpack properties... index 3 is always the weight???
	-- there has to be a cleaner way to get this data...
	local props = ItemProperties.GetObjectProperties(id, nil, "Container search - check properties" )
	local prop
	--Debug.Print(props)
	if(props) then
	
	for i = 1, #props do
		if(string.find(tostring(props[i]), "Contents")) then
			prop = props[i]
			break
		end
	end
	end
	--Debug.Print(props)

	--Debug.Print(Interface.BackPackItems)
	--local itemCount = string.match(tostring(prop), "%d+/%d+")
	--if(itemCount and itemCount ~= "") then
--		LabelSetText(this.."ItemCount", towstring(itemCount))
	--end
	-- Contents: 9/125 Items, 8/550 Stones
	-- HACK: not localized. 
	-- BUG: doesn;t work for gargs???
	local itemCount, maxCount, weight, maxWeight
	itemCount, maxCount, weight, maxWeight = string.match(tostring(prop), "(%d+)/(%d+)%s+%a+%,+%s+(%d+)/(%d+)")
	if(not maxWeight) then
		itemCount, maxCount, weight = string.match(tostring(prop), "(%d+)/(%d+)%s+%a+%,+%s+(%d+)")
	end

	-- TODO: Bug with vendor weight
	if(id == ContainerWindow.PlayerBackpack) then
	
		local gold = WindowUtils.AddCommasToNumber(WindowData.PlayerStatus.Gold)
		LabelSetText(this.."Gold", gold .. L" gold")
		LabelSetTextColor(this.."Gold", 60, 30, 0)
	
		LabelSetText(this.."ItemCount", towstring(itemCount) .. L"/" .. towstring(maxCount))
		LabelSetText(this.."Weight", towstring(WindowData.PlayerStatus.Weight) .. L"/" .. towstring(WindowData.PlayerStatus.MaxWeight) .. L" stones")
		LabelSetText(this.."Luck", WindowUtils.AddCommasToNumber(WindowData.PlayerStatus.Luck) .. L" luck")

		LabelSetTextColor(this.."Facet", 60, 30, 0)
		if(WindowData.PlayerLocation.facet == 0) then
			LabelSetText(this.."Facet", L"Felucca")
			LabelSetTextColor(this.."Facet", 200, 0, 0)
		elseif(WindowData.PlayerLocation.facet == 1) then
			LabelSetText(this.."Facet", L"Trammel")
		elseif(WindowData.PlayerLocation.facet == 2) then
			LabelSetText(this.."Facet", L"Ilshenar")
		elseif(WindowData.PlayerLocation.facet == 3) then
			LabelSetText(this.."Facet", L"Malas")
		elseif(WindowData.PlayerLocation.facet == 4) then
			LabelSetText(this.."Facet", L"Tokuno")
		elseif(WindowData.PlayerLocation.facet == 5) then
			LabelSetText(this.."Facet", L"Ter Mur")
		else
			LabelSetText(this.."Facet", L"")
		end

	else
		LabelSetText(this.."Weight", towstring(tostring(weight)) .. L" stones")
	end

	
	ContainerWindow.OpenContainers[id].inUpdate = true
	
	-- store the scrollbar offset so we can restore it when we are done
	local listOffset = ScrollWindowGetOffset(list_view_this)
	local gridOffset = ScrollWindowGetOffset(grid_view_this)
	
	-- Create any contents slots we need
	local contents = data.ContainedItems
	local numItems = data.numItems
	local numCreatedSlots = data.numCreatedSlots or 1

	if numItems > numCreatedSlots then
		ContainerWindow.CreateListViewSlots(this, numCreatedSlots+1, numItems)
		data.numCreatedSlots = numItems
	end
	
	
	if (ContainerWindow.ViewModes[id] == "List" and numItems > numCreatedSlots) then
		
		ContainerWindow.OpenContainers[id].inUpdate = false
		ContainerWindow.UpdateContents(id)
		return
	end
	
	
	if not data.numGridSockets or data.numGridSockets < data.maxSlots then
		ContainerWindow.CreateGridViewSockets(this, 1, data.maxSlots)
		data.numGridSockets = data.maxSlots;
	end
	
	-- Turn off all contents to start
	ContainerWindow.HideAllContents(this, numCreatedSlots)
	if numItems > 0 then
		if ContainerWindow.ViewModes[id] == "List" then
			WindowSetShowing(list_view_this , true)
			WindowSetShowing(grid_view_this, false)
			--WindowSetShowing(freeform_view_this, false)
			
		elseif ContainerWindow.ViewModes[id] == "Grid" then
			WindowSetShowing(list_view_this, false)
			WindowSetShowing(grid_view_this, true)
			--WindowSetShowing(freeform_view_this, false)
			
		elseif ContainerWindow.ViewModes[id] == "Freeform" then
			WindowSetShowing(list_view_this, false)
			WindowSetShowing(grid_view_this, false)
			--WindowSetShowing(freeform_view_this, true)	
		end
	elseif ContainerWindow.ViewModes[id] == "Freeform" then
		WindowSetShowing(list_view_this, false)
		WindowSetShowing(grid_view_this, false)
		--WindowSetShowing(freeform_view_this, true)	
	end

	--LabelSetText(this.."Title", data.containerName)
	--if (data and data.containerName and data.containerName ~= L"" and data.containerName ~= "") then
--		WindowUtils.FitTextToLabel(this.."Title", data.containerName)
--	end

	ContainerWindow.ReleaseRegisteredObjects(id)
	
	if id == ContainerWindow.PlayerBackpack then
		Interface.BackPackItems = ContainerWindow.ScanQuantities(id, true)
		ContainerWindow.BackpackItemsCheck()
	end
		
	if( ContainerWindow.ViewModes[id] ~= "Freeform" ) then
		local scl = WindowGetScale(this)
		for i = 1, numItems do
			item = data.ContainedItems[i]
			ContainerWindow.RegisteredItems[id][item.objectId] = true
			RegisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
			-- perform the initial update of this object
			ContainerWindow.UpdateObject(this,item.objectId)
			
			if	item.name == GetStringFromTid(1062824) or	-- Your Bank Box
				item.name == GetStringFromTid(1062825) or	-- Your Stabled Pets
				item.name == GetStringFromTid(1062826) or	-- Your Worn Equipment
				item.name == GetStringFromTid(1062827) or	-- Your Backpack
				item.name == GetStringFromTid(1062905)		-- Your Controlled Pets
			then 
				data.containerName = L"Transfer Crate"
				--WindowUtils.FitTextToLabel(this.."Title", data.containerName)
			end
			
			WindowSetScale(list_view_this.."ScrollChildItem"..i, scl)
		end
		
		if (ContainerWindow.ViewModes[id] == "List") then
			WindowSetShowing(this.."ListView", true)
		end
		
		if (ContainerWindow.ViewModes[id] == "List") then
			for i = 1, numItems do
				if ( DoesWindowNameExist(list_view_this.."ScrollChildItem"..i) and LabelGetText(list_view_this.."ScrollChildItem"..i.."Name" ) == "") then
					WindowSetShowing(list_view_this.."ScrollChildItem"..i, false)
				else
					WindowSetShowing(list_view_this.."ScrollChildItem"..i,true)
				end
			end
		end
		
		-- Update the scroll windows
		ScrollWindowUpdateScrollRect( list_view_this )   	
		local maxOffset = VerticalScrollbarGetMaxScrollPosition(list_view_this.."Scrollbar")
		if( listOffset > maxOffset ) then
		    listOffset = maxOffset
		end
		ScrollWindowSetOffset(list_view_this,listOffset)
		ContainerWindow.UpdateListViewSockets(this)	
	
		ScrollWindowUpdateScrollRect(grid_view_this) 
		maxOffset = VerticalScrollbarGetMaxScrollPosition(grid_view_this.."Scrollbar")
		if( gridOffset > maxOffset ) then
		    gridOffset = maxOffset
		end
		ScrollWindowSetOffset(grid_view_this,gridOffset)		
	end
	
	--local oldContent = LabelGetText(this.."Content")
	--LabelSetText(this.."Content", L"")
	--if (Interface.ToggleContentsInfo) then

		--	local content = ContainerWindow.GetContent(id)
		--	if content then
		--		LabelSetText(this.."Content", content)				
		--	else
				
		--		LabelSetText(this.."Content", oldContent)
		--	end
	--end
	
	for w, dat in pairs (TradeWindow.TradeInfo) do
		TradeWindow.UpdateContents(dat.containerId, w, true)
		TradeWindow.UpdateContents(dat.containerId2, w, true)
	end
	
	ContainerWindow.OpenContainers[id].inUpdate = false
	ContainerWindow.OpenContainers[id].LastUpdate = ContainerWindow.DeltaRefresh + ContainerWindow.RefreshRate
end

ContainerWindow.GetContentDelta = {}

function ContainerWindow.GetContent(contId)	
	local prop	
	local rtn = L""
	local items, qta, wgt = ContainerWindow.ScanQuantities(contId)

	local tidParams = ItemProperties.GetObjectPropertiesParamsForTid( contId, 1073841, "container content params" )
	if tidParams then
		rtn = ReplaceTokens(GetStringFromTid(1073841), {towstring(qta), towstring(tidParams[2]), WindowUtils.AddCommasToNumber(wgt)})   -- Contents: ~1_COUNT~/~2_MAXCOUNT~ items, ~3_WEIGHT~ stones
	else
		rtn = ReplaceTokens(GetStringFromTid(1073841), {towstring(qta), towstring(125), WindowUtils.AddCommasToNumber(wgt)})   -- Contents: ~1_COUNT~/~2_MAXCOUNT~ items, ~3_WEIGHT~ stones
	end	

	if rtn and rtn ~= L"" and wstring.find(rtn, L":") then
		return rtn
	end
end

function ContainerWindow.ScanSubCont(id, allItems, itemsOnly)
	local removeOnComplete = false
	if not WindowData.ContainerWindow[id] then
		RegisterWindowData(WindowData.ContainerWindow.Type, id)
		removeOnComplete = true		
	end
	
	local qta = 0
	local wgt = 0
	if not WindowData.ContainerWindow[id] and not itemsOnly then			
		local props = ItemProperties.GetObjectPropertiesArray( id, "container items weight scan" )
		if props  then
			local params = ItemProperties.BuildParamsArray( props )			
			for j = 1, #props.PropertiesTids do
				if ItemPropertiesInfo.WeightONLYTid[props.PropertiesTids[j]] then
					local token = ItemPropertiesInfo.WeightONLYTid[props.PropertiesTids[j]]
					local val = tostring(params[props.PropertiesTids[j]][token])
					wgt = wgt + tonumber(val)
					break
				end
			end
		end
		return allItems, qta, wgt
	elseif WindowData.ContainerWindow[id] then
		local numItems = WindowData.ContainerWindow[id].numItems
		qta = numItems
		if not itemsOnly then		
			local props = ItemProperties.GetObjectPropertiesArray( id, "sub-containers items weight scan" )
			if props  then
				local params = ItemProperties.BuildParamsArray( props )
				for j = 1, #props.PropertiesTids do
					if ItemPropertiesInfo.WeightONLYTid[props.PropertiesTids[j]] then
						local token = ItemPropertiesInfo.WeightONLYTid[props.PropertiesTids[j]]
						local val = tostring(params[props.PropertiesTids[j]][token])
						wgt = wgt + tonumber(val)
						break					
					end
				end
			end
		end		
		for i = 1, numItems do
			local item = WindowData.ContainerWindow[id].ContainedItems[i]
			allItems = ContainerSearch.ScanSubCont(item.objectId, allItems, itemsOnly)
			table.insert(allItems,item.objectId )
		end		
	end

	if(ContainerWindow.OpenContainers[id] == nil and removeOnComplete)then		
		UnregisterWindowData(WindowData.ContainerWindow.Type, id)
	end
	
	return allItems, qta, wgt
end

function ContainerWindow.ScanQuantities(backpackId, itemsOnly)
	local AllItems = {}
	local qta = 0 
	local wgt = 0
	if not WindowData.ContainerWindow[backpackId] then
		RegisterWindowData(WindowData.ContainerWindow.Type, backpackId)
	end
	if not WindowData.ContainerWindow[backpackId] then		
		return
	end
	local numItems = WindowData.ContainerWindow[backpackId].numItems
	qta = numItems
	for i = 1, numItems do
		local item = WindowData.ContainerWindow[backpackId].ContainedItems[i]
		AllItems, qt, wg = ContainerWindow.ScanSubCont(item.objectId, AllItems, itemsOnly)
		table.insert(AllItems,item.objectId )
		qta = qta + qt
		wgt = wgt + wg
	end
	
	return AllItems, qta, wgt
end

function ContainerWindow.HandleUpdateObjectEvent()
    ContainerWindow.UpdateObject(SystemData.ActiveWindow.name,WindowData.UpdateInstanceId)
end

function ContainerWindow.UpdateObject(windowName, updateId)
	if not DoesWindowNameExist(windowName) then		
		return
	end
	
	if not WindowData.ObjectInfo[updateId] then
		RegisterWindowData(WindowData.ObjectInfo.Type, updateId)		
	end
	if( WindowData.ObjectInfo[updateId] ~= nil ) then
	    local containerId = WindowData.ObjectInfo[updateId].containerId
    	local viewMode = ContainerWindow.ViewModes[containerId]	   
		-- if this object is in my container
	    if( containerId == WindowGetId(windowName) ) then
		    -- find the slot index
		    containedItems = WindowData.ContainerWindow[containerId].ContainedItems
		    numItems = WindowData.ContainerWindow[containerId].numItems
		    listIndex = 0
		    for i=1, numItems do
			    if( containedItems[i].objectId == updateId ) then
				    listIndex = i
				    gridIndex = (containedItems[i].gridIndex)
				    break
			    end
		    end
		    item = WindowData.ObjectInfo[updateId]

			local objectType = item.objectType
			
			-- Custom ===============
			-- TODO: move rule checks into GetExtendedInfo and return properties on info object...
			local info = ItemProperties.GetExtendedInfo(updateId)
			-- TODO: make this a result object and add in other features like text display and icons...
			local rule = ItemProperties.CheckRules(info)
			--Debug.Print(info)
			--Debug.Print(rule)

			if not rule and WindowData.ContainerWindow[containerId].isCorpse == true and LootConfiguration.MuteCorpseLoot then
				-- TODO: Add excludes like gold???
				item["hueId"] = 2419 
			end
			if(rule and rule.ItemHue and rule.ItemHue ~= "0") then
				item["hueId"] = tonumber(rule.ItemHue)
			end
		
			if(viewMode == "List")then
				-- Name
					ElementName = windowName.."ListViewScrollChildItem"..listIndex.."Name"
					local scl = WindowGetScale(windowName)
					if (DoesWindowNameExist(ElementName) and ContainerWindow.ViewModes[WindowGetId(windowName)] ~= "Freeform") then
						WindowSetScale(ElementName, scl)
					end

					local name =  Shopkeeper.stripFirstNumber(item.name)

					local summBall
					if wstring.find(wstring.lower(GetStringFromTid(1054131)), L":") then
						summBall = wstring.sub(wstring.lower(GetStringFromTid(1054131)), 1, wstring.find(wstring.lower(GetStringFromTid(1054131)), L":") - 1)
					end

					if summBall and (name and type(name) ~= "string" and type(summBall) ~= "wstring") then
						if wstring.find(wstring.lower(name), summBall) then
							name = summBall
						end
					end

					if name and name ~= "" and item.quantity > 1 then
						local commaQ = WindowUtils.AddCommasToNumber(item.quantity)
						if commaQ then
							name = WindowUtils.AddCommasToNumber(item.quantity) .. L" " .. name
						end
					end

					if (name and name ~= "" and wstring.lower(name) == wstring.lower(GetStringFromTid(1041361))) then -- a bank check			    	
						local prop = ItemProperties.GetObjectProperties( updateId, 4, "Container Window - Update Object - Bank Check" )
						if(DoesWindowNameExist(ElementName)) then
							LabelSetText(ElementName, FormatProperly(name .. L"\n   " .. prop))
						end
					elseif(DoesWindowNameExist(ElementName) and name and name ~= "") then
						LabelSetText(ElementName, FormatProperly(name) )
					end

					if (name and name ~= "" and wstring.lower(name) == wstring.lower(GetStringFromTid(1078604))) then -- scroll of alacrity
						local prop = ItemProperties.GetObjectPropertiesTidParams( updateId, 4, "Container Window - Update Object - Scroll of alacrity" )
						local skill = tostring(wstring.gsub(prop[1], L"#", L""))
						skill = tonumber(skill)
						if(skill ~= nil)then
							prop = GetStringFromTid(1149921) .. L" " .. GetStringFromTid(skill)
							if(DoesWindowNameExist(ElementName)) then
								LabelSetText(ElementName, FormatProperly(name .. L"\n   " .. prop))
							end				
						end
					end

					if (name and name ~= "" and wstring.lower(name) == wstring.lower(GetStringFromTid(1094934))) then -- scroll of transcendence
						local prop = ItemProperties.GetObjectPropertiesTidParams( updateId, 4, "Container Window - Update Object - scroll of transcendence" )
						local skill = tostring(wstring.gsub(prop[1], L"#", L""))
						skill = tonumber(skill)
						if(skill ~= nil)then					
							prop = GetStringFromTid(1149921) .. L" " .. GetStringFromTid(skill)
							if(DoesWindowNameExist(ElementName)) then
								LabelSetText(ElementName, FormatProperly(name .. L"\n   " .. prop))
							end				
						end
					end

									
					if (name and name ~= "" and wstring.find(name, L"Commodity Deed Worth")) then
						local val = wstring.match(name, L"Commodity%sDeed%sWorth%s(.+)")
						if(DoesWindowNameExist(ElementName)) then
							LabelSetText(ElementName, FormatProperly(L"Commodity Deed Worth\n   " .. val))
						end
					end



				-- List View Icon
					local uses = ContainerWindow.GetUses(updateId, containerId)				
					if( uses and DoesWindowNameExist(ElementName)) then
						LabelSetText(ElementName, FormatProperly(name .. L"\n   " .. uses[1]))
					end

					WindowSetShowing(ElementName, true)
					-- Icon
					elementIcon = windowName.."ListViewScrollChildItem"..listIndex.."Icon"
					if( item.iconName ~= "" ) then
						if ( Interface.TrapBoxID == 0 and Interface.oldTrapBoxID == updateId) then
							Interface.oldTrapBoxID = 0
						end
						if ( Interface.LootBoxID == 0 and Interface.oldLootBoxID == updateId) then
							Interface.oldLootBoxID = 0
						end

						item.id = updateId
					    EquipmentData.UpdateItemIcon(elementIcon, item)
						
					    parent = WindowGetParent(elementIcon)
					    WindowClearAnchors(elementIcon)
					    WindowAddAnchor(elementIcon, "topleft", parent, "topleft", 15+((45-item.newWidth)/2), 15+((45-item.newHeight)/2))
						
					    WindowSetShowing(elementIcon, true)
					else
					    WindowSetShowing(elementIcon, false)
					end
			end -- end list view...

			-- Grid View Icon
			if( item.iconName ~= "" ) then
				elementIcon = windowName.."GridViewSocket"..gridIndex.."Icon"
				if DoesWindowNameExist(elementIcon .. "Multi") then
					DynamicImageSetTexture( elementIcon .. "Multi", "", 0, 0 )
					WindowSetShowing(elementIcon .. "Multi", false)
				end
				if DoesWindowNameExist(elementIcon) then
					item.id = updateId
					--if(item.objectType == 4234) then
						--item.newHeight = 10
						--item.iconScale = 1.25
					--end
					-- Draw the item icon...
					if(info and info.Scale) then
						item.customScale = info.Scale
					end
					EquipmentData.UpdateItemIcon(elementIcon, item)	

					-- Some item icons get in the way of title text...
					-- TODO: make this a table and configured easier...
					if(objectType == 7154) then
					    parent = WindowGetParent(elementIcon)
					    WindowClearAnchors(elementIcon)
					    WindowAddAnchor(elementIcon, "center", parent, "center", 4, 7)
					end

					if item.quantity > 1 and item.objectType ~= 3821 and item.objectType ~= 3824 then
						if DoesWindowNameExist(elementIcon .. "Multi") then
							-- Draw the item icon...
							EquipmentData.UpdateItemIcon(elementIcon .. "Multi", item)
							WindowSetShowing(elementIcon .. "Multi", true)	
						end
					end
					local gridViewItemLabel = windowName.."GridViewSocket"..gridIndex.."Quantity"
					LabelSetText(gridViewItemLabel, L"")
					
					local uses =  ContainerWindow.GetUses(updateId, containerId)
					if( item.quantity ~= nil and item.quantity > 1 ) then 
						LabelSetText(gridViewItemLabel, Knumber(item.quantity))
					elseif( uses) then
						LabelSetText(gridViewItemLabel, Knumber(uses[2]))
					end

					 
					if(info and info.Title) then
						LabelSetText(windowName.."GridViewSocket"..gridIndex.."Title", towstring(info.Title))
					end
					if(info and info.SubTitle) then
						-- overwrites quantity...
						LabelSetText(gridViewItemLabel, towstring(info.SubTitle))
					end

					if(rule) then
						if(rule.BorderHue ~= "0") then
							local borderR,borderG,borderB,borderA = HueRGBAValue(tonumber(rule.BorderHue))
							WindowSetTintColor(windowName.."GridViewSocket"..gridIndex.."IconBorder", borderR, borderG, borderB)
							if(rule.BorderHueAlpha and rule.BorderHueAlpha ~= "0") then
								WindowSetAlpha(windowName.."GridViewSocket"..gridIndex.."IconBorder", tonumber(rule.BorderHueAlpha))	
							end
						end
						if(rule.BackgroundHue ~= "0") then
							local backgroundR,backgroundG,backgroundB,backgroundA = HueRGBAValue(tonumber(rule.BackgroundHue))
							WindowSetTintColor(windowName.."GridViewSocket"..gridIndex .. "Background", backgroundR, backgroundG, backgroundB)
							if(rule.BackgroundHueAlpha and rule.BackgroundHueAlpha ~= "0") then
								WindowSetAlpha(windowName.."GridViewSocket"..gridIndex .. "Background", tonumber(rule.BackgroundHueAlpha))	
							end
						end
					end
				end
			end
		end
	end
end

function ContainerWindow.UpdateUses(id)	
	ContainerWindow.CurrentUses[id] = {}
	if (WindowData.ContainerWindow[id]) then
		local numItems = WindowData.ContainerWindow[id].numItems
		for i = 1, numItems  do
			local item = WindowData.ContainerWindow[id].ContainedItems[i]
			local objectId = item.objectId
			
			local props = ItemProperties.GetObjectPropertiesArray( objectId, "container items weight scan" )
			local params = ItemProperties.BuildParamsArray( props )
			if not props then
				continue
			end
			
			for j = 1, #props.PropertiesTids do
				if ItemPropertiesInfo.ChargesTid[props.PropertiesTids[j]] then
					local token = ItemPropertiesInfo.ChargesTid[props.PropertiesTids[j]]
					local val = tostring(params[props.PropertiesTids[j]][token])					
					ContainerWindow.CurrentUses[id][objectId] = {ReplaceTokens(GetStringFromTid(props.PropertiesTids[j]), {WindowUtils.AddCommasToNumber(val)}), tonumber(val)} 					
					break
				end
			end
		
		end
	end
	ContainerWindow.LastUsesDelta[id] = 0	
	ContainerWindow.UpdateContents(id)
end
ContainerWindow.ShortUsesDelta = 0

function ContainerWindow.UpdateUsesByID(id, objectId)
		
	local props = ItemProperties.GetObjectPropertiesArray( objectId, "container items weight scan" )
	local params = ItemProperties.BuildParamsArray( props )
	if not props then
		return
	end
	
	for j = 1, #props.PropertiesTids do
		if ItemPropertiesInfo.ChargesTid[props.PropertiesTids[j]] then
			local token = ItemPropertiesInfo.ChargesTid[props.PropertiesTids[j]]
			local val = tostring(params[props.PropertiesTids[j]][token])
			
			ContainerWindow.CurrentUses[id][objectId] = {ReplaceTokens(GetStringFromTid(props.PropertiesTids[j]), {WindowUtils.AddCommasToNumber(val)}), tonumber(val)} 
			break
		end
	end
	ContainerWindow.UpdateObject("ContainerWindow_"..id, objectId)	
	
end

function ContainerWindow.GetUses(objectId, contId)
	
	if not ContainerWindow.CurrentUses[contId] then
		return
	end
	
	return ContainerWindow.CurrentUses[contId][objectId]
end

function ContainerWindow.ToggleView()
	local id = WindowGetId(WindowUtils.GetActiveDialog())
	
	if( WindowData.ContainerWindow[id] and WindowData.ContainerWindow[id].isSnooped == false ) then
		
        if (ContainerWindow.ViewModes[id] == "List") then
		    ContainerWindow.ViewModes[id] = "Grid"
		    ContainerWindow.UpdateGridViewSockets(id)
        elseif( ContainerWindow.ViewModes[id] == "Grid" ) then 
    	    ContainerWindow.ViewModes[id] = "List"    	    
			ContainerWindow.UpdateListViewSockets(id)
	    end		
        ContainerWindow.UpdateContents(id,true)
    end
    
    local playerBackpack = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
	if( id == playerBackpack ) then
		SystemData.Settings.Interface.inventoryMode = ContainerWindow.ViewModes[id]
	elseif( WindowData.ContainerWindow[id] and WindowData.ContainerWindow[id].isCorpse == true ) then
		SystemData.Settings.Interface.defaultCorpseMode = ContainerWindow.ViewModes[id]
	else
		SystemData.Settings.Interface.defaultContainerMode = ContainerWindow.ViewModes[id]
	end

	ContainerWindow.SetViewButton()
	SettingsWindow.UpdateSettings()
end

function ContainerWindow.GetSlotNumFromGridIndex(containerId, gridIndex)
    local slotNum = nil
    
    if( ContainerWindow.ViewModes[containerId] == "Grid" ) then
        local containedItems = WindowData.ContainerWindow[containerId].ContainedItems
        
        if( WindowData.ContainerWindow[containerId].ContainedItems ) then
            for index, item in ipairs(WindowData.ContainerWindow[containerId].ContainedItems) do                
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

function ContainerWindow.OnItemClicked(flags)
	local containerId = WindowGetId(WindowUtils.GetActiveDialog())
	local slotNum = WindowGetId(SystemData.ActiveWindow.name)
	
	slotNum = ContainerWindow.GetSlotNumFromGridIndex(containerId, slotNum)

    if( slotNum ~= nil ) then
	    if( WindowData.Cursor ~= nil and WindowData.Cursor.target == true ) then
			local objectId = WindowData.ContainerWindow[containerId].ContainedItems[slotNum].objectId
			HandleSingleLeftClkTarget(objectId)
	    elseif( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_NONE ) then
			local objectId = WindowData.ContainerWindow[containerId].ContainedItems[slotNum].objectId
			local itemData = WindowData.ObjectInfo[objectId]
			if flags == SystemData.ButtonFlags.CONTROL and DoesPlayerHaveItem(objectId) then
				if ItemsInfo.Reagents[itemData.objectType] then
					local id = itemData.objectType
					local lblid = QuickStats.GetId()
					local label = "QuickStat_" .. lblid
					local l = QuickStats.DoesLabelExist(id, true)
					if l > 0 and DoesWindowNameExist("QuickStat_" .. l) then
						label = "QuickStat_" .. l
					else
						local lab = {objectType=id, minQuantity=20, frame=true, icon=true, name=true, cap=true, locked=false, BGColor={r=0,g=0,b=0}, frameColor={r=255,g=255,b=255}, valueTextColor={r=255,g=255,b=255}, nameTextColor={r=243,g=227,b=49}}
						table.insert(QuickStats.Labels, lblid, lab)
						
						CreateWindowFromTemplate(label, "QuickStatTemplate", "Root")
						WindowSetId(label, lblid)
						WindowUtils.openWindows[label] = true
						QuickStats.UpdateLabel(label)
						QuickStats.Save(label)
						SnapUtils.SnappableWindows[label] = true
					end
					local scaleFactor = 1/InterfaceCore.scale	
					
					local propWindowWidth = 380
					local propWindowHeight = 30
					
					-- Set the position
					local mouseX = SystemData.MousePosition.x - 30
					if mouseX + (propWindowWidth / scaleFactor) > SystemData.screenResolution.x then
						propWindowX = mouseX - (propWindowWidth / scaleFactor)
					else
						propWindowX = mouseX
					end
						
					local mouseY = SystemData.MousePosition.y - 15
					if mouseY + (propWindowHeight / scaleFactor) > SystemData.screenResolution.y then
						propWindowY = mouseY - (propWindowHeight / scaleFactor)
					else
						propWindowY = mouseY
					end
					
					WindowSetOffsetFromParent(label, propWindowX * scaleFactor, propWindowY * scaleFactor)
					QuickStats.InMovement[label] = true
					WindowSetMoving(label, true)
					SnapUtils.StartWindowSnap(label)
				else
					local blockBar = HotbarSystem.GetNextHotbarId()
					Interface.SaveBoolean("Hotbar" .. blockBar .. "_IsBlockbar", true)
					HotbarSystem.SpawnNewHotbar()
					
					HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_USE_ITEM, objectId, itemData.iconId, blockBar,  1)
					
					local scaleFactor = 1/InterfaceCore.scale	
					
					local propWindowWidth = Hotbar.BUTTON_SIZE
					local propWindowHeight = Hotbar.BUTTON_SIZE
					
					-- Set the position
					local mouseX = SystemData.MousePosition.x - 30
					if mouseX + (propWindowWidth / scaleFactor) > SystemData.screenResolution.x then
						propWindowX = mouseX - (propWindowWidth / scaleFactor)
					else
						propWindowX = mouseX
					end
						
					local mouseY = SystemData.MousePosition.y - 15
					if mouseY + (propWindowHeight / scaleFactor) > SystemData.screenResolution.y then
						propWindowY = mouseY - (propWindowHeight / scaleFactor)
					else
						propWindowY = mouseY
					end
					
					WindowSetOffsetFromParent("Hotbar" .. blockBar, propWindowX * scaleFactor, propWindowY * scaleFactor)
					WindowSetMoving("Hotbar" .. blockBar, true)
				end
			else
				DragSlotSetObjectMouseClickData(objectId, SystemData.DragSource.SOURCETYPE_CONTAINER)
				ContainerWindow.GetContentDelta[containerId] = 0								
			end
			
	    end
	end
end

function ContainerWindow.OnItemRelease()	
	if( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM ) then
	
		Debug.Print("OnItemRelease")
		
	    local containerId = WindowGetId(WindowUtils.GetActiveDialog())
		local gridIndex = WindowGetId(SystemData.ActiveWindow.name)
		local slotNum = ContainerWindow.GetSlotNumFromGridIndex(containerId, gridIndex)
		local slot = nil

		-- Used by vendor config for tracking item data 
		SystemData.TargetContainerId = containerId
		SystemData.SourceContainerId = SystemData.DragItem.itemContainerId
		--Debug.Print("dragged an item from..." .. tostring(SystemData.DragItem.itemContainerId))

		if( WindowData.ContainerWindow[containerId].ContainedItems ~= nil and slotNum ~= nil) then
			slot = WindowData.ContainerWindow[containerId].ContainedItems[slotNum]
		end

		-- Check to see if this item needs removed from a watch list...
		-- We do this because we don't want the item to appear to have been 'sold' if we moved it ourselves.
		--Debug.Print("checking for items in container... ".. tostring(SystemData.SourceContainerId))
		if(VendorConfiguration.WatchContainers[SystemData.SourceContainerId]) then
			--Debug.Print("found the container")
			for k,v in pairs(VendorConfiguration.WatchContainers[SystemData.SourceContainerId].Items) do
				if(tostring(k) == tostring(SystemData.DragItem.itemId)) then
					--Debug.Print("removed item from watched container...")
					VendorConfiguration.WatchContainers[SystemData.SourceContainerId].Items[k] = nil
				end
			end
		end	


		SystemData.ActiveContainer.SlotsWide = ContainerWindow.OpenContainers[containerId].slotsWide
		SystemData.ActiveContainer.SlotsHigh = ContainerWindow.OpenContainers[containerId].slotsHigh
        
        --Debug.Print("OnItemRelease: "..tostring(slot))
		-- This happens when you drop an item onto an empty grid socket
		if (not slot) then
			if(gridIndex > ContainerWindow.MAX_BANK_SLOTS)then
				gridIndex = 0
			end			
            DragSlotDropObjectToContainer(containerId,gridIndex)
            local td = {func = function() ContainerWindow.UpdateUsesByID(containerId, SystemData.DragItem.itemId) ContainerWindow.GetContentDelta[containerId] = 0 ContainerWindow.UpdateContents(containerId)	 end, time = Interface.TimeSinceLogin + 2}
			table.insert(ContainerWindow.TODO, td)
			return
		end
		
		local clickedObjId = slot.objectId
		if (clickedObjId ~= Interface.TrapBoxID) then
			if ContainerWindow.ViewModes[containerId] == "Grid" then
				DragSlotDropObjectToObjectAtIndex(clickedObjId,gridIndex)
			else
				DragSlotDropObjectToObjectAtIndex(clickedObjId,0)
			end
		end
        local td = {func = function() ContainerWindow.UpdateUsesByID(containerId, SystemData.DragItem.itemId) end, time = Interface.TimeSinceLogin + 2}
		table.insert(ContainerWindow.TODO, td)
		ContainerWindow.LegacyGridDock(WindowUtils.GetActiveDialog())
		ContainerWindow.GetContentDelta[containerId] = 0
        ContainerWindow.UpdateContents(containerId)	

		


	end
end

function ContainerWindow.OnContainerRelease()	
	if( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM ) then
		local containerId = WindowGetId(WindowUtils.GetActiveDialog())
		DragSlotDropObjectToContainer(containerId,0)
		ContainerWindow.LegacyGridDock(WindowUtils.GetActiveDialog())
		ContainerWindow.GetContentDelta[containerId] = 0 
		ContainerWindow.UpdateContents(containerId)
	end
end

function ContainerWindow.OnItemDblClicked()
	local containerId = WindowGetId(WindowUtils.GetActiveDialog())
	local slotNum = WindowGetId(SystemData.ActiveWindow.name)
		
	slotNum = ContainerWindow.GetSlotNumFromGridIndex(containerId, slotNum)
	if( slotNum ~= nil ) then
	    local objectId = WindowData.ContainerWindow[containerId].ContainedItems[slotNum].objectId
	    
	    if Interface.UnpackTransferCrate then
			RegisterWindowData(WindowData.ObjectInfo.Type, objectId)
			local itemData = WindowData.ObjectInfo[objectId]
			if	itemData.name == GetStringFromTid(1062824) or	-- Your Bank Box
				itemData.name == GetStringFromTid(1062825) or	-- Your Stabled Pets
				itemData.name == GetStringFromTid(1062826) or	-- Your Worn Equipment
				itemData.name == GetStringFromTid(1062827) or	-- Your Backpack
				itemData.name == GetStringFromTid(1062905)		-- Your Controlled Pets
				
			then 
				ContainerWindow.UnpackTransferCrate(objectId)
			else
				UserActionUseItem(objectId,false)
			end
	    else
			UserActionUseItem(objectId,false)
		end
	end
end


function ContainerWindow.UnpackTransferCrate(objectId)
	ContextMenu.RequestContextAction(objectId, ContextMenu.DefaultValues.UnpackTransferCrate )
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
	    objectId = containedItems[slotNum].objectId
    	
	    if objectId then
		    local itemData = { windowName = dialog,
						       itemId = objectId,
		    			       itemType = WindowData.ItemProperties.TYPE_ITEM,
		    			       detail = ItemProperties.DETAIL_LONG }
		    ItemProperties.SetActiveItem(itemData)
	    end
	end
end

function ContainerWindow.OnItemGet(flags)
	local index = WindowGetId(SystemData.ActiveWindow.name)
	local containerId = WindowGetId(WindowUtils.GetActiveDialog())
	local slotNum = ContainerWindow.GetSlotNumFromGridIndex(containerId, index)
	
	if (slotNum ~= nil) then
		local objectId = WindowData.ContainerWindow[containerId].ContainedItems[slotNum].objectId
	
		if (objectId ~= nil or objectId ~= 0) then
			if flags == SystemData.ButtonFlags.CONTROL and  WindowData.ObjectInfo[objectId].quantity > 1 then
				ContainerWindow.DragOne = true
				ContainerWindow.HoldShiftBackup = SystemData.Settings.GameOptions.holdShiftToUnstack
				SystemData.Settings.GameOptions.holdShiftToUnstack = false
				UserSettingsChanged()
				DragSlotSetObjectMouseClickData(objectId, SystemData.DragSource.SOURCETYPE_CONTAINER)
				 ContainerWindow.GetContentDelta[containerId] = 0 
				 ContainerWindow.UpdateContents(containerId)	
				return
			end
				
			-- If player is trying to get objects from a container that is not from the players backpack have it dropped
			-- into the players backpack
			-- Auto loot from anything...
			--if(WindowData.ContainerWindow[containerId].isCorpse == true) then
			local itemInfo = ItemProperties.GetExtendedInfo(objectId)
			if (containerId == ContainerWindow.PlayerBackpack or itemInfo.Price) then
				Debug.Print("context menu please")
				RequestContextMenu(objectId)
			else
				if( ContainerWindow.CanPickUp == true) then
					local itemData = WindowData.ObjectInfo[objectId]
					if (Interface.LootBoxID == 0 or itemData.objectType == 3821) then
						DragSlotAutoPickupObject(objectId)
					else
						MoveItemToContainer(objectId,itemData.quantity, Interface.LootBoxID)
					end
					 ContainerWindow.GetContentDelta[containerId] = 0 
					 ContainerWindow.UpdateContents(containerId)	
					ContainerWindow.TimePassedSincePickUp = 0
					ContainerWindow.CanPickUp = false
				else
					-- must wait to perform action...
					PrintTidToChatWindow(1045157,1)
				end
			end
		end
	end
end

local moveObjects = {}
ContainerWindow.lastLooted = 0

function ContainerWindow.UpdatePickupTimer(timePassed)

	ContainerWindow.DeltaRefresh = ContainerWindow.DeltaRefresh + timePassed

	for i = 1, #ContainerWindow.TODO do
		if ContainerWindow.TODO[i] and not ContainerWindow.TODO[i].time then
			ContainerWindow.TODO[i] = nil
		end
		if ContainerWindow.TODO[i] and Interface.TimeSinceLogin >= ContainerWindow.TODO[i].time then
			local ok = pcall(ContainerWindow.TODO[i].func)
			ContainerWindow.TODO[i] = nil
		end
	end	
	
	-- Check all containers for use items
	ContainerWindow.ShortUsesDelta = ContainerWindow.ShortUsesDelta + timePassed
	local forceCheck = false
	if(ContainerWindow.ShortUsesDelta > 5)then
		forceCheck = true
		ContainerWindow.ShortUsesDelta = 0
	end

	for id, value in pairs(ContainerWindow.LastUsesDelta) do
		if not WindowData.ContainerWindow[id] or not DoesWindowNameExist("ContainerWindow_"..id) then
			ContainerWindow.LastUsesDelta[id] = nil
			ContainerWindow.CurrentUses[id] = nil
			continue
		end
		if (ContainerWindow.LastUsesDelta[id]) then -- long uses update (every 60 seconds) - check all the items
			ContainerWindow.LastUsesDelta[id] = ContainerWindow.LastUsesDelta[id] + timePassed
			if ContainerWindow.LastUsesDelta[id] > 60 then
				ContainerWindow.CurrentUses[id] = {}
				ContainerWindow.LastUsesDelta[id] = nil
				ContainerWindow.UpdateUses(id)
			elseif forceCheck then -- short uses update (every 5 seconds) - check only the items that we know they have uses.				
				for objectId, _ in pairs(ContainerWindow.CurrentUses[id]) do
					ContainerWindow.UpdateUsesByID(id, objectId)					
				end
			end		
		end
	end
	
	if(ContainerWindow.CanPickUp == false) then
		ContainerWindow.TimePassedSincePickUp = ContainerWindow.TimePassedSincePickUp + timePassed
		if(ContainerWindow.TimePassedSincePickUp >= ContainerWindow.PickupWaitTime) then
			ContainerWindow.CanPickUp = true	
		end
	end

	for id, value in pairs(ContainerWindow.OpenContainers) do
		if ContainerWindow.OpenContainers[id] ~= nil	then
			local isDirty = ContainerWindow.OpenContainers[id].dirty
			ContainerWindow.OpenContainers[id].dirty = 0
			if(isDirty and ContainerWindow.OpenContainers[id].LastUpdate and ContainerWindow.OpenContainers[id].LastUpdate < ContainerWindow.DeltaRefresh)then
				ContainerWindow.UpdateContents(id)
				if (ContainerSearch.Container == id) then		
					ContainerSearch.UpdateList()
				end			
			end
		end
	end	
	
	if (ContainerWindow.DragOne) then
		if (DoesWindowNameExist("GenericQuantityWindow")) then
			ContainerWindow.DragOne = false
			DragSlotQuantityRequestResult(1)
			SystemData.Settings.GameOptions.holdShiftToUnstack = ContainerWindow.HoldShiftBackup
			ContainerWindow.HoldShiftBackup = nil
			UserSettingsChanged()
		end	
	end
	
	if ContainerWindow.Organize and ContainerWindow.OrganizeParent then
		if not moveObjects or #moveObjects == 0 then
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
		end
		
		if moveObjects and #moveObjects > 0 and ContainerWindow.CanPickUp then		
			local OrganizeBag = ContainerWindow.OrganizeBag
			if not OrganizeBag or OrganizeBag == 0 then
				OrganizeBag = ContainerWindow.PlayerBackpack
			end			
			local key = moveObjects[1]
			RegisterWindowData(WindowData.ObjectInfo.Type, key)
			local itemData = WindowData.ObjectInfo[key]
			if itemData and itemData.containerId == ContainerWindow.OrganizeParent then
				ContainerWindow.TimePassedSincePickUp = 0
				ContainerWindow.CanPickUp = false
				ObjectHandleWindow.lastItem = key
				
				MoveItemToContainer(key,itemData.quantity, OrganizeBag)

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
			else
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
	
	
	if ContainerWindow.Restock and ContainerWindow.CanPickUp then		
		local OrganizeBag = ContainerWindow.OrganizeBag
		if not OrganizeBag or OrganizeBag == 0 then
			OrganizeBag = ContainerWindow.PlayerBackpack
		end

		local numItems = WindowData.ContainerWindow[ContainerWindow.OrganizeParent].numItems
		for i = 1, numItems  do
			local item = WindowData.ContainerWindow[ContainerWindow.OrganizeParent].ContainedItems[i]
			RegisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
			local itemData = WindowData.ObjectInfo[item.objectId]			
						
			if (itemData) then
				if (Organizer.Restock[Organizer.ActiveRestock]) then
					for j=1,  Organizer.Restocks_Items[Organizer.ActiveRestock] do
						local itemL = Organizer.Restock[Organizer.ActiveRestock][j]
						if (itemL.type > 0 and itemL.type == itemData.objectType and itemL.hue == itemData.hueId and ContainerWindow.CurrentAmountArray[itemL.type][itemL.hue] < itemL.qta) then
							
							if itemData.quantity < itemL.qta then
								DragAmount = itemData.quantity 
							else
								DragAmount = itemL.qta - ContainerWindow.CurrentAmountArray[itemL.type][itemL.hue]
							end
							
							if (DragAmount > 0) then
								MoveItemToContainer(item.objectId,DragAmount, OrganizeBag)
								ContainerWindow.CurrentAmountArray[itemL.type][itemL.hue] = ContainerWindow.CurrentAmountArray[itemL.type][itemL.hue] + DragAmount
								ContainerWindow.TimePassedSincePickUp = 0
								ContainerWindow.CanPickUp = false	
								return
							end
						end
					end	
				end
			end
			UnregisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
		end
		ContainerWindow.Restock = false
	end
	
	
	if ContainerWindow.OrganizeParent and ContainerWindow.LootAll[ContainerWindow.OrganizeParent] and ContainerWindow.CanPickUp then

		if not moveObjects or #moveObjects == 0 then
			moveObjects = {}
			local numItems = WindowData.ContainerWindow[ContainerWindow.OrganizeParent].numItems
			for i = 1, numItems  do
				local item = WindowData.ContainerWindow[ContainerWindow.OrganizeParent].ContainedItems[i]
				local itemData = WindowData.ObjectInfo[item.objectId]
				if (itemData) then
					table.insert(moveObjects,item.objectId)
				end
			end
			if(#moveObjects == 0)then
				ContainerWindow.LootAll[ContainerWindow.OrganizeParent] = nil
			end
		end
		
		if moveObjects and #moveObjects > 0 and ContainerWindow.CanPickUp then
		
			local OrganizeBag = Interface.LootBoxID
			if not OrganizeBag or OrganizeBag == 0 then
				OrganizeBag = ContainerWindow.PlayerBackpack
			end
			
			local key = moveObjects[1]
			local itemData = WindowData.ObjectInfo[key]

			if itemData and itemData.containerId == ContainerWindow.OrganizeParent then
				ContainerWindow.TimePassedSincePickUp = 0
				ContainerWindow.CanPickUp = false
				ObjectHandleWindow.lastItem = key
				
				MoveItemToContainer(key,itemData.quantity, OrganizeBag)

				table.remove(moveObjects, 1)
				if #moveObjects == 0 then
					moveObjects = {}
					local numItems = WindowData.ContainerWindow[ContainerWindow.OrganizeParent].numItems
					for i = 1, numItems  do
						local item = WindowData.ContainerWindow[ContainerWindow.OrganizeParent].ContainedItems[i]
						local itemData = WindowData.ObjectInfo[item.objectId]
						if (itemData) then
							table.insert(moveObjects,item.objectId)
						end
					end
					if #moveObjects == 0 then
						ContainerWindow.LootAll[ContainerWindow.OrganizeParent] = nil
					end
				end
			else
				table.remove(moveObjects, 1)
				if #moveObjects == 0 then
					moveObjects = {}
					local numItems = WindowData.ContainerWindow[ContainerWindow.OrganizeParent].numItems
					for i = 1, numItems  do
						local item = WindowData.ContainerWindow[ContainerWindow.OrganizeParent].ContainedItems[i]
						local itemData = WindowData.ObjectInfo[item.objectId]
						if (itemData) then
							table.insert(moveObjects,item.objectId)
						end
					end
					if #moveObjects == 0 then
						ContainerWindow.LootAll[ContainerWindow.OrganizeParent] = nil
					end
				end
			end	
		end
	end	
end



function ContainerWindow.ViewButtonMouseOver()
	local containerId = WindowGetId(WindowUtils.GetActiveDialog())

	if (ContainerWindow.ViewModes[containerId] == "Grid" ) then
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(ContainerWindow.TID_LIST_MODE))
	elseif (ContainerWindow.ViewModes[containerId] == "List" ) then
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(ContainerWindow.TID_GRID_MODE))
    end
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )    
	ContainerWindow.GenericOver()
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

	ContainerWindow.LegacyGridDock(windowName)
	

    ContainerWindow.UpdateContents(id) 
end

function ContainerWindow.UpdateListViewSockets(id)	
	--Debug.Print("ContainerWindow.UpdateListViewSockets("..id..")")
	
	local windowName = "ContainerWindow_"..id
	local listViewName = windowName.."ListView"
	local scrollchildName = listViewName.."ScrollChild"
	if not DoesWindowNameExist(windowName) then
		return
	end	
	ContainerWindow.LegacyGridDock(windowName)	
end

function ContainerWindow.UpdateGridViewSockets(id)
	if not DoesWindowNameExist("ContainerWindow_" .. id) then
		return
	end
	local data = WindowData.ContainerWindow[id]
	
	local windowName = "ContainerWindow_"..id
	local gridViewName = windowName.."GridView"
	local scrollViewChildName = gridViewName.."ScrollChild"
	
	-- determine the grid dimensions based on window width and height
	local windowWidth, windowHeight = WindowGetDimensions(windowName)
	local GRID_WIDTH = math.floor((windowWidth - (ContainerWindow.Grid.PaddingLeft + ContainerWindow.Grid.PaddingRight)) / ContainerWindow.Grid.SocketSize + 0.5)	
	local GRID_HEIGHT = math.floor((windowHeight - (ContainerWindow.Grid.PaddingTop + ContainerWindow.Grid.PaddingBottom)) / ContainerWindow.Grid.SocketSize + 0.5)
	local numSockets = GRID_WIDTH * GRID_HEIGHT
	local isNotBankBox = true
	if(WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BANK] and id == WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BANK].objectId)then
		isNotBankBox = false
	end
	if(isNotBankBox and numSockets > ContainerWindow.MAX_INVENTORY_SLOTS) then
		numSockets = ContainerWindow.MAX_INVENTORY_SLOTS
	end

	local allSocketsVisible = numSockets >= data.maxSlots
	-- if numSockets is less than 125, we need additional rows to provide at least 125 sockets.
	if not allSocketsVisible then
		GRID_HEIGHT = math.ceil(data.maxSlots / GRID_WIDTH)
		numSockets = GRID_WIDTH * GRID_HEIGHT
		if(isNotBankBox and numSockets > ContainerWindow.MAX_INVENTORY_SLOTS) then
			numSockets = ContainerWindow.MAX_INVENTORY_SLOTS
		end
	end
	
	if not data.numGridSockets then
		ContainerWindow.CreateGridViewSockets(windowName, 1, numSockets)
	else
		-- create additional padding sockets if needed or destroy extra ones from the last resize
		if data.numGridSockets > numSockets then
			ContainerWindow.DestroyGridViewSockets(windowName, numSockets + 1, data.numGridSockets)
		elseif data.numGridSockets < numSockets then
			ContainerWindow.CreateGridViewSockets(windowName, data.numGridSockets + 1, numSockets)
		end
	end

	local scl = WindowGetScale(windowName)
	data.numGridSockets = numSockets
	
	-- position and anchor the sockets
	for i = 1, data.numGridSockets do
		local socketName = windowName.."GridViewSocket"..i 
		if(DoesWindowNameExist(socketName)) then
			WindowClearAnchors(socketName)		
		end		
		WindowSetScale(socketName, scl)
		if i == 1 then
			WindowAddAnchor(socketName, "topleft", scrollViewChildName, "topleft", 0, 0)
		elseif (i % GRID_WIDTH) == 1 then
			WindowAddAnchor(socketName, "bottomleft", windowName.."GridViewSocket"..i-GRID_WIDTH, "topleft", 0, 1)
		else
			WindowAddAnchor(socketName, "topright", windowName.."GridViewSocket"..i-1, "topleft", 1, 0)
		end
		if DoesWindowNameExist(socketName .. "IconMulti") then
			WindowSetShowing(socketName .. "IconMulti", false)
		end
		WindowSetShowing(socketName, true)	
	end

	-- dimensions for the entire grid view with GRID_WIDTH x GRID_HEIGHT dimensions
	local newGridWidth = GRID_WIDTH * ContainerWindow.Grid.SocketSize + ContainerWindow.Grid.PaddingLeft
	local newGridHeight = GRID_HEIGHT * ContainerWindow.Grid.SocketSize + ContainerWindow.Grid.PaddingTop
	
	-- fit the window width to the grid width
	local newWindowWidth = newGridWidth + ContainerWindow.Grid.PaddingRight
	local newWindowHeight = windowHeight
	
	-- if we can see every slot in the container, snap the window height to the grid and hide the void created 
	-- by the missing scrollbar
	if allSocketsVisible then
		newWindowHeight = newGridHeight + ContainerWindow.Grid.PaddingBottom
		newWindowWidth = newWindowWidth - ContainerWindow.ScrollbarWidth
	else
		newWindowHeight = windowHeight
		newGridHeight = windowHeight - (ContainerWindow.Grid.PaddingBottom + ContainerWindow.Grid.PaddingTop)
	end
	
	--WindowSetDimensions(windowName, newWindowWidth, newWindowHeight)
	--WindowSetDimensions(gridViewName, 300, 200)
	--WindowSetDimensions(scrollViewChildName, 290, 200)
	
	ScrollWindowUpdateScrollRect(gridViewName) 
	
	if ContainerWindow.OpenContainers[id] then
		ContainerWindow.OpenContainers[id].slotsWide = GRID_WIDTH
		ContainerWindow.OpenContainers[id].slotsHigh = GRID_HEIGHT
	end

	WindowSetShowing(gridViewName, true)	
end

function ContainerWindow.CreateGridViewSockets(dialog, lower, upper)
	local id = WindowGetId(dialog)
	local data = WindowData.ContainerWindow[id]
	
	if not data then
		return
	end
	
	if not lower then
		lower = 1
	end
	
	if not upper then
		upper = data.maxSlots
	end
	if upper > ContainerWindow.MaxSlotsPerGrid then
		upper = ContainerWindow.MaxSlotsPerGrid
	end
	--Debug.Print("ContainerWindow.CreateGridViewSockets("..dialog..") lower = "..lower.." upper = "..upper)
	
	local parent = dialog.."GridViewScrollChild"
	
	local color = false
	
	for i = lower, upper do
		local socketName = dialog.."GridViewSocket"..i 
		local socketTemplate

		if i > data.maxSlots then
			socketTemplate = "GridViewSocketBaseTemplate"
		else
			if (not Interface.ExtraBrightContainers) then
				socketTemplate = "GridViewSocketTemplate"
			else
				socketTemplate = "ColoredGridViewSocketTemplate"
			end
		end
		
		if DoesWindowNameExist(socketName) then
			DestroyWindow(socketName)
		end
		CreateWindowFromTemplate(socketName, socketTemplate, parent)
		
		WindowSetId(socketName, i)
		WindowSetShowing(socketName, false)
		
		if i > data.maxSlots then
			WindowSetAlpha(socketName, 0)
			--WindowSetTintColor(socketName, 10, 10, 10)
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
		if DoesWindowNameExist(socketName) then
			DestroyWindow(socketName)
		end
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

function ContainerWindow.Scrolling(pos)
	----Debug.Print("ContainerWindow.Shutdown: "..WindowUtils.GetActiveDialog())
	local id = WindowGetId(WindowUtils.GetActiveDialog())
	this = "ContainerWindow_"..id
	if DoesPlayerHaveItem(id)  or id == ContainerWindow.PlayerBank then
		local listViewName = this.."ListView"
		local gridViewName = this.."GridView"
		if WindowGetShowing(listViewName) then
			if VerticalScrollbarGetMaxScrollPosition(listViewName.."Scrollbar") > 0 then

				Interface.SaveNumber("ScrollList" .. id, pos)
			end
		elseif WindowGetShowing(gridViewName) then
			Interface.SaveNumber("ScrollGrid" .. id, pos)
		end
		
		ContainerWindow.scrolled =  nil
	end
end

function ContainerWindow.GenericOver()
	LabelSetTextColor(SystemData.ActiveWindow.name, 0,190,190)

	-- TODO: tooltip text cache...
	--if(Tooltips.Data[
	--local tooltipText = Tooltips
	--local tid = tonumber()

	--Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(1154791))
	--Tooltips.Finalize()
	--Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function ContainerWindow.GenericOverEnd()
	LabelSetTextColor(SystemData.ActiveWindow.name, 120,90,60)
end


--function Blah.NewFunc()
--Debug.Print("ok...")
--Blah.OldFunc()
--end

--Blah.OldFunc = SingleLineTextEntry.Initialize
--function SingleLineTextEntry.Initialize()
--Debug.Print("wtf...!!!")
--end

function ContainerWindow.Watch()
	local containerId = WindowGetId(WindowUtils.GetActiveDialog())
	VendorConfiguration.ToggleWatchContainer(containerId)
end
