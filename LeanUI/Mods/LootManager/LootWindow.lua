LootWindow = {}

LootWindow.maxSlots = 100

function LootWindow.Initialize()
	local this = SystemData.ActiveWindow.name
	
	--Interface.DestroyWindowOnClose[this] = true

	if WindowUtils.CanRestorePosition(this) then
		WindowUtils.RestoreWindowPosition(this, true)
	else
		WindowClearAnchors(this)
		WindowAddAnchor(this, "topleft", "Root", "topleft", 200, 200)
	end
	
	LootWindow.UpdateGridViewSockets()
	LabelSetText(this.."Title", L"LW2")
	LootWindow.Update()
end

function LootWindow.Shutdown()
	local this = SystemData.ActiveWindow.name
	
	WindowUtils.SaveWindowPosition(this)
	
	--LootWindow.ReleaseRegisteredObjects(id)
	
	if( ItemProperties.GetCurrentWindow() == this ) then
		ItemProperties.ClearMouseOverItem()
	end
	
	LootWindow.DestroyGridViewSockets("LootWindow")
end

function LootWindow.Update()
	local this = "LootWindow"
	
	local grid_view_this = this.."GridView"
	
	local data = {}
	
	-- store the scrollbar offset so we can restore it when we are done
	local gridOffset = ScrollWindowGetOffset(grid_view_this)
	
	-- Create any contents slots we need
	local contents = 100
	local numItems = 100
	local numCreatedSlots = 100 or 0
	
	-- Turn off all contents to start
	--LootWindow.HideAllContents()
	
	--LootWindow.ReleaseRegisteredObjects(id)
	
	
		
	local i = 1
	for key,item in pairs(LootManager.queue) do
		local elementIcon = this.."GridViewSocket"..i.."Icon"
		local gridViewItemLabel = this.."GridViewSocket"..i.."Quantity"
	    local gridViewItemAdditional = this.."GridViewSocket"..i.."Additional"
        
        --EquipmentData.UpdateItemIcon(elementIcon, item.itemInfo)
        local itemInfo = item.itemInfo
        WindowSetDimensions(elementIcon, itemInfo.newWidth, itemInfo.newHeight)		
        DynamicImageSetTextureDimensions(elementIcon, itemInfo.newWidth, itemInfo.newHeight)
        --Debug.PrintToChat(StringToWString(itemInfo.iconName))
        if itemInfo.iconName ~= nil then
        	--Inspection.dumpToChat("foo", itemInfo)
        	DynamicImageSetTexture(elementIcon, itemInfo.iconName, 0, 0)
        	
        end
        if itemInfo.iconId ~= nil then
    		--local texture, x, y = GetIconData(itemInfo.iconId)
    		--Debug.PrintToChat(StringToWString(texture))
    		--DynamicImageSetTexture(elementIcon, texture, x, y)
    	end		
        DynamicImageSetCustomShader(elementIcon, "UOSpriteUIShader", {itemInfo.hueId, itemInfo.objectType})
        DynamicImageSetTextureScale(elementIcon, itemInfo.iconScale)
        WindowSetTintColor(elementIcon,itemInfo.hue.r,itemInfo.hue.g,itemInfo.hue.b)
        WindowSetAlpha(elementIcon,itemInfo.hue.a/255)
        --WindowSetShowing(elementIcon, true)	
		if itemInfo.quantity ~= nil then
	    	LabelSetText(gridViewItemLabel, L""..itemInfo.quantity)
	    else
	    	LabelSetText(gridViewItemLabel, L"")
	    end
			
		i = i + 1
	end
end

function LootWindow.HideAllContents()
	local this = "LootWindow"
	for i=1,100 do
		--DynamicImageSetTexture(this.."GridViewSocket"..i.."Icon", "", 0, 0);
		LabelSetText(this.."GridViewSocket"..i.."Quantity", L"")
	end
end

function LootWindow.UpdateGridViewSockets()
	local this = LootWindow
	local data = {}
	local windowName = SystemData.ActiveWindow.name
	local gridViewName = windowName.."GridView"
	local scrollViewChildName = gridViewName.."ScrollChild"
	
	-- determine the grid dimensions based on window width and height
	local windowWidth, windowHeight = WindowGetDimensions(windowName)
	local GRID_WIDTH = math.floor((windowWidth - (ContainerWindow.Grid.PaddingLeft + ContainerWindow.Grid.PaddingRight)) / ContainerWindow.Grid.SocketSize + 0.5)	
	local GRID_HEIGHT = math.floor((windowHeight - (ContainerWindow.Grid.PaddingTop + ContainerWindow.Grid.PaddingBottom)) / ContainerWindow.Grid.SocketSize + 0.5)
	local numSockets = GRID_WIDTH * GRID_HEIGHT
	local allSocketsVisible = numSockets >= this.maxSlots
		
	-- if numSockets is less than 125, we need additional rows to provide at least 125 sockets.
	if not allSocketsVisible then
		GRID_HEIGHT = math.ceil(this.maxSlots / GRID_WIDTH)
		numSockets = GRID_WIDTH * GRID_HEIGHT
	end
	--Debug.Print("LM sockets: "..numSockets)
	--Debug.Print("LM sockets height: "..GRID_HEIGHT)
	--Debug.Print("LM sockets width: "..GRID_WIDTH)
	LootWindow.CreateGridViewSockets(windowName, 1, numSockets)
	
	-- position and anchor the sockets
	for i = 1, numSockets do
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
	
	WindowSetDimensions(windowName, newWindowWidth, newWindowHeight)
	WindowSetDimensions(gridViewName, newGridWidth, newGridHeight)
	WindowSetDimensions(scrollViewChildName, newGridWidth, newGridHeight)
	
	ScrollWindowUpdateScrollRect(gridViewName)
	
	--Debug.Print("LM sockets done") 
end

function LootWindow.CreateGridViewSockets(dialog, lower, upper)
	local this = LootWindow
	local data = {}
	local parent = dialog.."GridViewScrollChild"
	
	if not lower then
		lower = 1
	end
	
	if not upper then
		upper = this.maxSlots
	end
	
	for i = lower, upper do
		local socketName = dialog.."GridViewSocket"..i 
		local socketTemplate

		if i > this.maxSlots then
			socketTemplate = "LootSocketBaseTemplate"
		else
			socketTemplate = "LootSocketTemplate"
		end
		
		--Debug.Print(socketName)
		CreateWindowFromTemplate(socketName, socketTemplate, parent)
		WindowSetId(socketName, i)
		--WindowSetShowing(socketName, false)
		
		if i > this.maxSlots then
			WindowSetAlpha(socketName, 0.5)
			WindowSetTintColor(socketName, 10, 10, 10)
		end
	end
	
	WindowSetShowing(dialog.."GridView", true)
end

function LootWindow.DestroyGridViewSockets(dialog, lower, upper)
	if not lower then
		lower = 1
	end
	
	if not upper then
    	upper = LootManager.maxSlots
	end

	for i = lower, upper do
		local socketName = dialog.."GridViewSocket"..i 
		DestroyWindow(socketName)
	end
end