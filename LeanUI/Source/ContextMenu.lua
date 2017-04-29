----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

ContextMenu = {}

ContextMenu.GREYEDOUT 	= 0x01
ContextMenu.SECONDTIER 	= 0x02
ContextMenu.HIGHLIGHTED	= 0x04

ContextMenu.HighlightColor = { r=51, g=102, b=255 }
ContextMenu.DisabledColor = { r=128, g=128, b=128 }
ContextMenu.NormalColor = { r=255, g=255, b=255}

ContextMenu.WINDOW_WIDTH = 275
ContextMenu.ITEM_WINDOW_WIDTH = 270
ContextMenu.ITEM_WINDOW_HEIGHT = 25
ContextMenu.ITEM_WINDOW_SPACING = 2

ContextMenu.NumItemsCreated = {}

-- These variables are used when the context menu is lua drive
ContextMenu.IsLuaDriven = false
ContextMenu.LuaMenuOptions = {}
ContextMenu.LuaCallback = nil

ContextMenu.HideWindow = false

ContextMenu.SubMenuDelayTimer = nil

----------------------------------------------------------------
-- ContextMenu Functions
----------------------------------------------------------------

-- subMenuOptions is a table that contains the same information as the main item
-- tid, flags, returnCode, param, pressed
function ContextMenu.CreateLuaContextMenuItem(tid,flags,returnCode,param,pressed,subMenuOptions, subMenuDelay, textColor)
  if type(tid) == "wstring" then
    ContextMenu.CreateLuaContextMenuItemWithString(tid, flags, returnCode, param, pressed, subMenuOptions, subMenuDelay, textColor)
  elseif type(tid) == "string" then
    ContextMenu.CreateLuaContextMenuItemWithString(StringToWString(tid), flags, returnCode, param, pressed, subMenuOptions, subMenuDelay, textColor)
  else
    local index = table.getn(ContextMenu.LuaMenuOptions) + 1
    ContextMenu.LuaMenuOptions[index] = { tid=tid, flags=flags, returnCode=returnCode, param=param, pressed=pressed, subMenuOptions=subMenuOptions, subMenuDelay=subMenuDelay, textColor=textColor}
  end
end

function ContextMenu.CreateLuaContextMenuItemWithString(str,flags,returnCode,param,pressed,subMenuOptions,subMenuDelay,textColor)
	local index = table.getn(ContextMenu.LuaMenuOptions) + 1

	ContextMenu.LuaMenuOptions[index] = { str=str, flags=flags, returnCode=returnCode, param=param, pressed=pressed, subMenuOptions=subMenuOptions, subMenuDelay=subMenuDelay, textColor=textColor}
end

function ContextMenu.ActivateLuaContextMenu(callback)
	ContextMenu.LuaCallback = callback
	ContextMenu.IsLuaDriven = true
	WindowSetShowing("ContextMenu",true)
end

function ContextMenu.GetMenuItemData()
	if( ContextMenu.IsLuaDriven == true ) then
	  --Debug.PrintToChat(L"lua context menu")
		return ContextMenu.LuaMenuOptions
	elseif( WindowData.ContextMenu ~= nil ) then
	  --Debug.PrintToChat(L"native context menu")
	  --Debug.DumpToChat("foo", WindowData.ContextMenu.menuItems)
		return WindowData.ContextMenu.menuItems
	end
end

function ContextMenu.ExecuteMenuItem(returnCode,param)
  
	if( ContextMenu.IsLuaDriven == true ) then
	  --Debug.PrintToChat("lua WindowData.ContextMenu.returnCode = "..returnCode)
		ContextMenu.IsLuaDriven = false
		--WindowSetShowing("ContextMenu",false)
		ContextMenu.LuaCallback(returnCode,param)
	else
	  --Debug.PrintToChat("native WindowData.ContextMenu.returnCode = "..returnCode)
		WindowData.ContextMenu.returnCode = returnCode
		BroadcastEvent(SystemData.Events.CONTEXT_MENU_SELECTED) 
	end
end

function ContextMenu.VendorSearch()
    ContextMenu.HideNext = true
    
    -- Open ContextMenu to set client waiting for a context menu broadcast
    RequestContextMenu(WindowData.PlayerStatus.PlayerId)
    
    
    
    -- Broadcast "vendor search" selected event
    WindowData.ContextMenu.returnCode = 1016
    BroadcastEvent(SystemData.Events.CONTEXT_MENU_SELECTED)
end

function ContextMenu.Initialize()
	CreateWindow("ContextMenuSubMenu", false)
end

-- OnShown handler
function ContextMenu.Show()

	local this = WindowUtils.GetActiveDialog()
	local menuItems = ContextMenu.GetMenuItemData()
	
	-- Create any extra menu items that might be needed
	ContextMenu.CreateMenuItems(table.getn(menuItems), "ContextMenu")
	local cmWidth, cmHeight = ContextMenu.FillMenuItems(menuItems, "ContextMenu")	

  if ContextMenu.HideWindow == true then
    -- Move it off the screen when it should be hidden
    WindowSetOffsetFromParent("ContextMenu", -1000, -1000)
    WindowSetShowing("ContextMenu", false)
  else
    -- Anchor it to the mouse position if it should be shwon
    local scale = InterfaceCore.scale 
    local mouseX = SystemData.MousePosition.x
    local mouseY = SystemData.MousePosition.y
    
    local cmWindowX
    if mouseX + (cmWidth * scale) > SystemData.screenResolution.x then
      cmWindowX = mouseX - (cmWidth * scale)
    else
      cmWindowX = mouseX
    end
    
    local cmWindowY = mouseY
    if mouseY + (cmHeight * scale) > SystemData.screenResolution.y then
      cmWindowY = mouseY - (cmHeight * scale)
    else
      cmWindowY = mouseY
    end
    
    WindowSetOffsetFromParent("ContextMenu", cmWindowX / scale, cmWindowY / scale)
  end
end

function ContextMenu.Hide()
    if( WindowData.ContextMenu ~= nil ) then
	    WindowData.ContextMenu.menuItems = {}
	end
	ContextMenu.LuaMenuOptions = {}
	ContextMenu.IsLuaDriven = false
	-- reset submenu timer
	ContextMenu.SubMenuDelayTimer = nil
end

function ContextMenu.CreateMenuItems(numItemsNeeded,menuWindow)
	ContextMenu.HideAllItems(menuWindow)

	local numHave
	
	if( ContextMenu.NumItemsCreated[menuWindow] == nil ) then
		numHave = 0
	else
		numHave = ContextMenu.NumItemsCreated[menuWindow]
	end
	
	if numHave >= numItemsNeeded then
		return
	end

	for i = numHave + 1, numItemsNeeded do
		local itemName = menuWindow.."Item"..i
		
		CreateWindowFromTemplate(itemName, "ContextMenuEntryDef", menuWindow)

		if i == 1 then
			WindowAddAnchor(itemName, "topleft", menuWindow, "topleft", 3, ContextMenu.ITEM_WINDOW_SPACING)
		else
			WindowAddAnchor(itemName, "bottomleft", menuWindow.."Item"..i-1, "topleft", 0, ContextMenu.ITEM_WINDOW_SPACING)
		end
	end
	
	ContextMenu.NumItemsCreated[menuWindow] = numItemsNeeded
end

function ContextMenu.FillMenuItems(menuItems,menuWindow,submenuIndex)
	local len = table.getn(menuItems) 
	
	for i = 1, len do
		--Debug.Print("Adding item index "..i.." menuWindow "..menuWindow)
	
		local itemName = menuWindow.."Item"..i
		local item = menuItems[i]
		--Debug.Print(L"ITEMTEXT: " .. GetStringFromTid(item.tid))
		if (item.tid) then
		  --Debug.PrintToChat(GetStringFromTid(item.tid))
			ButtonSetText(itemName, GetStringFromTid(item.tid))
		else
			ButtonSetText(itemName, item.str)
		end
		
		if item.textColor then
			local hueR,hueG,hueB,hueA = HueRGBAValue(item.textColor)
			ButtonSetTextColor(itemName, Button.ButtonState.NORMAL, hueR, hueG, hueB)
		elseif BitOperations.And(item.flags, ContextMenu.GREYEDOUT) == 0 then
			ButtonSetTextColor(itemName, Button.ButtonState.NORMAL, ContextMenu.NormalColor.r, ContextMenu.NormalColor.g, ContextMenu.NormalColor.b)
		end
		
		if( item.pressed == true ) then
			ButtonSetPressedFlag(itemName, true)
		else
			ButtonSetPressedFlag(itemName, false)
		end
		
		if( submenuIndex ~= nil and submenuIndex > 0 ) then
			local offset = submenuIndex * 100
			WindowSetId(itemName, i+offset)
		else
			WindowSetId(itemName, i)
		end
		
		WindowSetShowing(itemName, true)
		if BitOperations.And(item.flags, ContextMenu.GREYEDOUT) ~= 0 then
			ButtonSetDisabledFlag(itemName, true)
			ButtonSetPressedFlag(itemName, false)
		else
			-- In case we previously set this item to disabled for a different menu
			ButtonSetDisabledFlag(itemName, false)
		end
		
		if BitOperations.And(item.flags, ContextMenu.HIGHLIGHTED) ~= 0 then
			local col = ContextMenu.HighlightColor
			ButtonSetTextColor(itemName, Button.ButtonState.NORMAL, col.r, col.g, col.b)
		end
		
	end
	
	
	local cmWidth = ContextMenu.WINDOW_WIDTH
	local cmHeight = len*(ContextMenu.ITEM_WINDOW_HEIGHT+ContextMenu.ITEM_WINDOW_SPACING)+5
	WindowSetDimensions(menuWindow, cmWidth, cmHeight)
	--Debug.Print("CM Height = "..cmHeight)
	
	return cmWidth, cmHeight
end

function ContextMenu.HideAllItems(menuWindow)
	local numHave = ContextMenu.NumItemsCreated[menuWindow]
	
	if numHave then
		for i = 1, numHave do
			WindowSetShowing(menuWindow.."Item"..i, false)
		end
	end
	-- reset submenu timer
	ContextMenu.SubMenuDelayTimer = nil
end

function ContextMenu.MenuItemLButtonUp()
	local this = SystemData.ActiveWindow.name
	local id = WindowGetId(this)
	local dialog = WindowUtils.GetActiveDialog()
	local itemData = ContextMenu.GetMenuItemData()
	local menuOption
	
	if( id < 100 ) then
		menuOption = itemData[id]
	else
		local parentId = math.floor(id / 100)
		local subMenuId = id - (parentId*100)
		--Debug.Print("ParentId="..parentId.." subMenuId="..subMenuId)
		menuOption = itemData[parentId].subMenuOptions[subMenuId]
	end
	
	if menuOption and menuOption.returnCode then
		-- If menu option is disabled, DON'T click it!
		if BitOperations.And(menuOption.flags, ContextMenu.GREYEDOUT) ~= 0 then
			return
		end
		
		ContextMenu.ExecuteMenuItem(menuOption.returnCode,menuOption.param)
	else
		--Debug.Print("Error showing context menu: either menuOption or menuOption.returnCode was nil.")
	end
	
	if menuOption and menuOption.textColor then
		local hueR,hueG,hueB,hueA = HueRGBAValue(menuOption.textColor)
		ButtonSetTextColor(this, Button.ButtonState.NORMAL, hueR, hueG, hueB)
	end

	WindowSetShowing("ContextMenu", false)	
	WindowSetShowing("ContextMenuSubMenu", false)	
end

function ContextMenu.MenuItemLButtonDown()
	local this = SystemData.ActiveWindow.name
	local id = WindowGetId(this)
	local itemData = ContextMenu.GetMenuItemData()
	local menuOption
	
	if( id < 100 ) then
		menuOption = itemData[id]
	else
		local parentId = math.floor(id / 100)
		local subMenuId = id - parentId*100
		menuOption = itemData[parentId].subMenuOptions[subMenuId]
	end
	
	if menuOption and (BitOperations.And(menuOption.flags, ContextMenu.GREYEDOUT) ~= 0) then
		local col = ContextMenu.DisabledColor
		ButtonSetTextColor(this, Button.ButtonState.NORMAL, col.r, col.g, col.b)
	end

	if menuOption and menuOption.textColor then
		local hueR,hueG,hueB,hueA = HueRGBAValue(menuOption.textColor)
		ButtonSetTextColor(this, Button.ButtonState.NORMAL, hueR, hueG, hueB)
	end
end

function ContextMenu.Update(timePassed)

	if ContextMenu.SubMenuDelayTimer == nil then
		--no sub menu timer
		return
	end

	ContextMenu.SubMenuDelayTimer = ContextMenu.SubMenuDelayTimer - timePassed
	if ContextMenu.SubMenuDelayTimer > 0 then
		--still have to waite
		return
	end

	--time to show the sub menu
	
	--reset timer
	ContextMenu.SubMenuDelayTimer = nil
	
	--show sub menu
	local menuItems = ContextMenu.GetMenuItemData()
	local len = table.getn(menuItems[ContextMenu.SubMenuParentId].subMenuOptions)
	ContextMenu.CreateMenuItems(len,"ContextMenuSubMenu")
	ContextMenu.FillMenuItems(menuItems[ContextMenu.SubMenuParentId].subMenuOptions,"ContextMenuSubMenu",ContextMenu.SubMenuParentId)
	WindowSetShowing("ContextMenuSubMenu",true)
	WindowClearAnchors("ContextMenuSubMenu")

	-- anchor the sub window based on the main window position
	local width, height = WindowGetDimensions("ContextMenuSubMenu")
	local anchorPosX, anchorPosY = WindowGetScreenPosition(ContextMenu.SubMenuParentItemName)
	if( anchorPosY + height > SystemData.screenResolution.y ) then
		WindowAddAnchor("ContextMenuSubMenu","bottomright",ContextMenu.SubMenuParentItemName,"bottomleft",0,0)
	else
		WindowAddAnchor("ContextMenuSubMenu","topright",ContextMenu.SubMenuParentItemName,"topleft",0,0)
	end
end

function ContextMenu.MenuItemMouseOver()
	local this = SystemData.ActiveWindow.name
	local id = WindowGetId(this)
	local menuItems = ContextMenu.GetMenuItemData()
	
	if( id < 100 ) then
		if( menuItems[id].subMenuOptions ~= nil ) then
			-- set sub menu timer
			if menuItems[id].subMenuDelay == nil then
				ContextMenu.SubMenuDelayTimer = 0
			else
				ContextMenu.SubMenuDelayTimer = menuItems[id].subMenuDelay
			end

			ContextMenu.SubMenuParentId = id
			ContextMenu.SubMenuParentItemName = this
		end

		WindowSetShowing("ContextMenuSubMenu",false)
	end

	local menuOption = menuItems[id]
	if id > 100 then
		local parentId = math.floor(id / 100)
		local subMenuId = id - parentId*100
		menuOption = menuItems[parentId].subMenuOptions[subMenuId]
	end
	if menuOption.textColor then
		local hueR,hueG,hueB,hueA = HueRGBAValue(menuOption.textColor)
		ButtonSetTextColor(this, Button.ButtonState.NORMAL, hueR, hueG, hueB)
	end
end

function ContextMenu.MenuItemMouseLeave()
	local this = SystemData.ActiveWindow.name
	local id = WindowGetId(this)
	local menuItems = ContextMenu.GetMenuItemData()

	-- reset submenu timer
	ContextMenu.SubMenuDelayTimer = nil
	
	if( menuItems ~= nil ) then
		local menuOption = menuItems[id]
		if id > 100 then
			local parentId = math.floor(id / 100)
			local subMenuId = id - parentId*100
			if menuItems[parentId] and menuItems[parentId].subMenuOptions then
				menuOption = menuItems[parentId].subMenuOptions[subMenuId]
			end
		end
		
		if menuOption and (BitOperations.And(menuOption.flags, ContextMenu.HIGHLIGHTED) ~= 0) then
			local col = ContextMenu.HighlightColor
			ButtonSetTextColor(this, Button.ButtonState.NORMAL, col.r, col.g, col.b)
		end
		
		if menuOption and menuOption.textColor then
			local hueR,hueG,hueB,hueA = HueRGBAValue(menuOption.textColor)
			ButtonSetTextColor(this, Button.ButtonState.NORMAL, hueR, hueG, hueB)
		end
	end
end