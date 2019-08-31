----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

ContextMenu = {}

ContextMenu.GREYEDOUT 	= 0x01
ContextMenu.SECONDTIER 	= 0x02
ContextMenu.HIGHLIGHTED	= 0x04

ContextMenu.HighlightColor =	{ r = 51,  g = 102, b = 255 }
ContextMenu.DisabledColor =		{ r = 128, g = 128, b = 128 }
ContextMenu.NormalColor =		{ r = 255, g = 255, b = 255 }
ContextMenu.MouseOverColor =	{ r = 243, g = 227, b = 49 }

ContextMenu.ParchHighlightColor =	{ r = 31,  g = 53,  b = 30 }
ContextMenu.ParchDisabledColor =	{ r = 128, g = 128, b = 128 }
ContextMenu.ParchNormalColor =		{ r = 0,   g = 0,	b = 0 }
ContextMenu.ParchMouseOverColor =	{ r = 140, g = 0,   b = 0 }

ContextMenu.WINDOW_WIDTH = 275
ContextMenu.ITEM_WINDOW_WIDTH = 270
ContextMenu.ITEM_WINDOW_HEIGHT = 25
ContextMenu.ITEM_WINDOW_SPACING = 2

ContextMenu.NumItemsCreated = {}

-- These variables are used when the context menu is lua drive
ContextMenu.IsLuaDriven = false
ContextMenu.LuaMenuOptions = {}
ContextMenu.LuaCallback = nil

ContextMenu.SubMenuDelayTimer = nil

ContextMenu.DefaultValues = {}
ContextMenu.DefaultValues.OpenMap = 10
ContextMenu.DefaultValues.TeleportVendor = 1015
ContextMenu.DefaultValues.OpenVendorContainer = 1018
ContextMenu.DefaultValues.VendorBuy = 110
ContextMenu.DefaultValues.VendorSell = 111
ContextMenu.DefaultValues.OpenBankbox = 120
ContextMenu.DefaultValues.PetGuard = 130
ContextMenu.DefaultValues.PetFollow = 131
ContextMenu.DefaultValues.PetAddFriend = 133
ContextMenu.DefaultValues.PetKill = 134
ContextMenu.DefaultValues.PetStop = 135
ContextMenu.DefaultValues.PetTransfer = 136
ContextMenu.DefaultValues.PetStay = 137
ContextMenu.DefaultValues.PetRelease = 138
ContextMenu.DefaultValues.PetRemoveFriend = 140
ContextMenu.DefaultValues.Tame = 301
ContextMenu.DefaultValues.NPCTalk = 303
ContextMenu.DefaultValues.DigForTreasure = 305
ContextMenu.DefaultValues.CancelProtection = 308
ContextMenu.DefaultValues.EnablePVPWarning = 320
ContextMenu.DefaultValues.StablePet = 400
ContextMenu.DefaultValues.BodRequest = 403
ContextMenu.DefaultValues.ViewQuestLog = 404
ContextMenu.DefaultValues.CancelQuest = 405
ContextMenu.DefaultValues.QuestConversation = 406
ContextMenu.DefaultValues.InsuranceMenu = 416
ContextMenu.DefaultValues.ToggleItemInsurance = 418
ContextMenu.DefaultValues.Bribe = 419
ContextMenu.DefaultValues.OpenBackpackPet = 508
ContextMenu.DefaultValues.OpenPaperdoll = 520
ContextMenu.DefaultValues.SetSecurity = 600
ContextMenu.DefaultValues.ReleaseCoOwnership = 602
ContextMenu.DefaultValues.LeaveHouse = 604
ContextMenu.DefaultValues.UnpackTransferCrate = 622
ContextMenu.DefaultValues.LoadShuriken = 701
ContextMenu.DefaultValues.QuestItem = 801
ContextMenu.DefaultValues.AddPartyMember = 810
ContextMenu.DefaultValues.RemovePartyMember = 811
ContextMenu.DefaultValues.Trade = 819
ContextMenu.DefaultValues.SiegeBless = 820
ContextMenu.DefaultValues.LoyaltyRating = 915
ContextMenu.DefaultValues.TitlesMenu = 918
ContextMenu.DefaultValues.RenamePet = 919
ContextMenu.DefaultValues.EmergencyRepairs = 930
ContextMenu.DefaultValues.PermanentRepairs = 931
ContextMenu.DefaultValues.ShipSecurity = 934
ContextMenu.DefaultValues.ResetShipSecurity = 935
ContextMenu.DefaultValues.RenameShip = 936
ContextMenu.DefaultValues.DryDockShip = 937
ContextMenu.DefaultValues.MoveTillerman = 938
ContextMenu.DefaultValues.VoidPool = 1010
ContextMenu.DefaultValues.Retrieve = 1012
ContextMenu.DefaultValues.AllowTrades = 1013
ContextMenu.DefaultValues.RefuseTrades = 1014
ContextMenu.DefaultValues.SwitchMastery = 953
ContextMenu.DefaultValues.VendorSearch = 1016
ContextMenu.DefaultValues.AcceptFriendRequests = 1020
ContextMenu.DefaultValues.RefuseFriendRequests = 1021

ContextMenu.AutomatedCall = {}

ContextMenu.LastShown = 0

ContextMenu.cmWidth = 0
ContextMenu.cmHeight = 0

ContextMenu.ParchStyle = false

ContextMenu.EmptyLine = {str = L""}

----------------------------------------------------------------
-- ContextMenu Functions
----------------------------------------------------------------

function ContextMenu.CreateLuaContextMenuItem(tid, flags, returnCode, param, pressed, subMenuOptions, subMenuDelay, textColor)

	-- subMenuOptions is a table that contains the same information as the main item
	-- tid, flags, returnCode, param, pressed, textColor

	-- make sure the flags are always present
	if not flags then
		flags = 0
	end

	-- do we have a valid tid?
	if IsValidID(tid) then

		-- add the context menu line
		table.insert(ContextMenu.LuaMenuOptions, {tid = tid, flags = flags, returnCode = returnCode, param = param, pressed = pressed, subMenuOptions = subMenuOptions, subMenuDelay = subMenuDelay, textColor = textColor})

	-- is the first parameter a string?
	elseif IsValidString(tid) then

		-- add the context menu line
		table.insert(ContextMenu.LuaMenuOptions, {str = tid, flags = flags, returnCode = returnCode, param = param, pressed = pressed, subMenuOptions = subMenuOptions, subMenuDelay = subMenuDelay, textColor = textColor})

	-- is the first parameter a table and we have the tid or the string value inside of it?
	elseif type(tid) == "table" and (tid.tid ~= nil or tid.str ~= nil) then
		
		-- add the context menu line
		table.insert(ContextMenu.LuaMenuOptions, tid)
	end
end

function ContextMenu.ActivateLuaContextMenu(callback, parchBG)

	-- if we are dragging a window, then we must not activate a context menu
	if Interface.IsDraggingAWindow then
		
		-- clean up the context menu
		ContextMenu.CleanUp()

		-- hide the context menu
		ContextMenu.ForceHide()

		return
	end
	
	-- do we have any data from previous hardcoded context menus?
	if WindowData.ContextMenu then

		-- reset the internal context menu data
		WindowData.ContextMenu.menuItems = nil
		WindowData.ContextMenu.objectId = nil
	end

	-- context menu window name
	local windowName = "ContextMenu"

	-- reset the context menu window ID
	WindowSetId(windowName, 0)

	-- store the parch style choice
	ContextMenu.ParchStyle = parchBG == true

	-- toggle the background
	WindowSetShowing(windowName .. "WindowBackground", not ContextMenu.ParchStyle)
	WindowSetShowing(windowName .. "WindowParchBackground", ContextMenu.ParchStyle)

	-- toggle the frame
	WindowSetShowing(windowName .. "Frame", not ContextMenu.ParchStyle)
	WindowSetShowing(windowName .. "ParchFrame", ContextMenu.ParchStyle)

	-- set the lua callback for the new context menu
	ContextMenu.LuaCallback = callback

	-- mark the context menu as lua driven
	ContextMenu.IsLuaDriven = true

	-- get the menu elements
	local menuItems = ContextMenu.GetMenuItemData()

	-- fill the context menu lines
	ContextMenu.FillMenuItems(menuItems, windowName)	

	-- show the context menu at the mouse cursor position
	ContextMenu.ForceShow()
end

function ContextMenu.GetMenuItemData()

	-- is the context menu generated from LUA?
	if ContextMenu.IsLuaDriven == true then

		-- return the array of elements generated until now
		return table.copy(ContextMenu.LuaMenuOptions)

	-- is the context menu hardcoded?
	elseif WindowData.ContextMenu ~= nil then

		-- return the array of hardcoded elements
		return table.copy(WindowData.ContextMenu.menuItems)
	end
end

function ContextMenu.ExecuteMenuItem(returnCode, param)
	
	-- is the context menu generated from LUA?
	if ContextMenu.IsLuaDriven == true then

		-- disable the flag (so it won't taint future hardcoded context menus)
		ContextMenu.IsLuaDriven = false
		
		-- execute the callback
		ContextMenu.LuaCallback(returnCode, param)

	else -- hardcoded context menu item

		-- current hardcoded context menu owner ID
		local ownerId = WindowData.ContextMenu.objectId

		-- call the hardcoded context action
		ContextMenu.RequestContextAction(ownerId, returnCode)		
	end
end

-- This happens when the UI starts
function ContextMenu.Initialize()

	-- set the background transparency
	WindowSetAlpha("ContextMenuWindowBackground", 0.8)
	WindowSetAlpha("ContextMenuWindowParchBackground", 0.8)
	
	-- hide the context menu on creation (so it won't show empty)
	CreateWindow("ContextMenuSubMenu", false)
end

function ContextMenu.Show()

	-- current context menu window name
	local this = "ContextMenu"

	-- current hardcoded context menu owner ID
	local id = WindowData.ContextMenu.objectId 

	-- is the context menu generated from LUA? then the ID is 0
	if ContextMenu.IsLuaDriven == true then
		id = 0
		
	-- is this an automated call or we have an hardcoded call to keep the context menu hidden? (this must run now or the menu will do some flickering effect)
	elseif ContextMenu.AutomatedCall[id] == true then

		-- hide the context menu
		ContextMenu.ForceHide()
	end

	-- set the context menu ID to the mobile/item ID
	WindowSetId(this, id)

	-- do we have a valid ID for the context menu? (only for hardcoded context menus)
	if not IsValidID(id) and ContextMenu.IsLuaDriven == false then
		return
	end

	-- make sure we have the flag for the style
	ContextMenu.ParchStyle = ContextMenu.ParchStyle or false

	-- toggle the background
	WindowSetShowing(this .. "WindowBackground", not ContextMenu.ParchStyle)
	WindowSetShowing(this .. "WindowParchBackground", ContextMenu.ParchStyle)

	-- toggle the frame
	WindowSetShowing(this .. "Frame", not ContextMenu.ParchStyle)
	WindowSetShowing(this .. "ParchFrame", ContextMenu.ParchStyle)

	-- get the menu elements
	local menuItems = ContextMenu.GetMenuItemData()

	-- do we have any element for the context menu?
	if menuItems then

		-- set the context menu width
		ContextMenu.cmWidth = ContextMenu.WINDOW_WIDTH

		-- calculate the context menu heigh (based on the number of items)
		ContextMenu.cmHeight = #menuItems * (ContextMenu.ITEM_WINDOW_HEIGHT + ContextMenu.ITEM_WINDOW_SPACING) + 5

	else -- if we have no menu items why are we here?
		return
	end
	
	-- is the context menu owner the player's target?
	if id == WindowData.CurrentTarget.TargetId then

		-- initialize the context menu data for the target window
		TargetWindow.ContextData = {}

		-- copy the context menu items into the context menu data of the target window
		TargetWindow.ContextData = table.copy(menuItems)

		-- store the owner ID
		TargetWindow.ContextData.id = id

		-- update the target window buttons
		TargetWindow.UpdateButtons()
	end

	-- is this an hardcoded context menu?
	if ContextMenu.IsLuaDriven == false then

		-- scan all the menu items
		for i, item in pairsByIndex(menuItems) do
		
			-- is this the player context menu?
			if id == GetPlayerID() then

				-- is this items allow trades?
				if item.returnCode == ContextMenu.DefaultValues.AllowTrades then
					
					-- trades are disabled, update the flag
					Interface.AllowTrades = false
					Interface.SaveSetting( "AllowTrades", Interface.AllowTrades )

				-- is this items refuse trades?
				elseif item.returnCode == ContextMenu.DefaultValues.RefuseTrades then
					
					-- trades are enabled, update the flag
					Interface.AllowTrades = true
					Interface.SaveSetting( "AllowTrades", Interface.AllowTrades )

				-- is this items accept friends?
				elseif item.returnCode == ContextMenu.DefaultValues.AcceptFriendRequests then

					-- friend requests are disabled, update the flag
					Interface.AllowFriendRequests = false
					Interface.SaveSetting( "AllowFriendRequests", Interface.AllowFriendRequests )

				-- is this items refuse friends?
				elseif item.returnCode == ContextMenu.DefaultValues.RefuseFriendRequests then

					-- friend requests are enabled, update the flag
					Interface.AllowFriendRequests = true
					Interface.SaveSetting( "AllowFriendRequests", Interface.AllowFriendRequests )
				end

			else -- others mobile/items context menu

				-- if it's a player we have add/remove party member or trade for sure
				if item.returnCode == ContextMenu.DefaultValues.Trade or item.returnCode == ContextMenu.DefaultValues.AddPartyMember or item.returnCode == ContextMenu.DefaultValues.RemovePartyMember then
					TargetWindow.KnownPlayers[id] = true

				-- if the mobile has an accessible container we have the open backpack menu item
				elseif item.returnCode == ContextMenu.DefaultValues.OpenBackpackPet then
					MobileHealthBar.KnownInventory[id] = true

				-- if the mobile has the tame option, then is tamable
				elseif item.returnCode == ContextMenu.DefaultValues.Tame then
					TargetWindow.KnownTamable[id] = true
				end
			end
		end
	end
	
	-- is the owner of the context menu a mobile?
	if VerifyMobileID(id) then

		-- if has not been marked as a player, then is not a player
		if not TargetWindow.KnownPlayers[id] then
			TargetWindow.KnownPlayers[id] = false
		end

		-- if has not been flagged as an owner of an accessible inventory then he has no accessible inventory
		if not MobileHealthBar.KnownInventory[id] then
			MobileHealthBar.KnownInventory[id] = false
		end

		-- if has not been flagged as tamable, then is not tamable
		if not TargetWindow.KnownTamable[id] then
			TargetWindow.KnownTamable[id] = false
		end
	end
	
	if	Interface.started and -- is the interface not started yet?
		(ContextMenu.IsLuaDriven or -- is the context menu generated from LUA?
		ContextMenu.AutomatedCall[id] == nil ) -- is this a normal (NOT AUTOMATED) call?
	then
	
		-- LUA generated context are filled on activation
		if not ContextMenu.IsLuaDriven then

			-- fill the context menu lines
			ContextMenu.FillMenuItems(menuItems, "ContextMenu")	
		end
		
		-- show the context menu at the mouse cursor position
		ContextMenu.ForceShow()

		-- set the last time we saw the context menu to now.
		ContextMenu.lastShow = Interface.TimeSinceLogin

		-- focus the context menu
		WindowAssignFocus("ContextMenu", true)
		
	else -- invisible context menu

		-- automated call completed, clear the flag
		ContextMenu.AutomatedCall[id] = nil
	end
end

function ContextMenu.SetPosition()
	
	-- move the context menu on the cursor position
	WindowUtils.FollowMouseCursor("ContextMenu", ContextMenu.cmWidth, ContextMenu.cmHeight, 0, 0, false, true, false)
end

function ContextMenu.DestroyAll()

	-- get the lines of the context menu
	local numHave = ContextMenu.NumItemsCreated["ContextMenu"]
	
	-- do we have any line?
	if numHave then

		-- destroy any line for the context menu
		for i = 1, numHave do
			DestroyWindow("ContextMenuItem" .. i)
		end
	end

	-- remove the data for the created context menu lines
	ContextMenu.NumItemsCreated["ContextMenu"] = nil

	-- get the lines of the sub-context menu
	numHave = ContextMenu.NumItemsCreated["ContextMenuSubMenu"]
	
	-- do we have any line?
	if numHave then

		-- destroy any line for the sub-context menu
		for i = 1, numHave do
			DestroyWindow("ContextMenuSubMenuItem"..i)
		end
	end

	-- remove the data for the created sub-context menu lines
	ContextMenu.NumItemsCreated["ContextMenuSubMenu"] = nil
end

function ContextMenu.OnKeyEscape()

	-- row window name
	local this = SystemData.ActiveWindow.name

	-- flag not to show the main menu
	MainMenuWindow.notnow =  true

	-- is this the context menu?
	if this == "ContextMenu" then

		-- destroy the context menu
		ContextMenu.ForceHide()

		-- clean up the context menu
		ContextMenu.CleanUp()

		-- focus the sub-menu
		WindowAssignFocus("ResizeWindow", true)

	-- is this the sub-menu?
	elseif this == "ContextMenuSubMenu" then

		-- hide the sub-menu
		WindowSetShowing("ContextMenuSubMenu", false)

		-- focus the context menu
		WindowAssignFocus("ContextMenu", true)
	end
end

function ContextMenu.OnHidden()

	-- do we need to keep the context menu visible? (this is required for windows that refresh often and will force the context menu to hide)
	if ContextMenu.ForceChoice then

		-- show the context menu at the mouse cursor position
		ContextMenu.ForceShow()

		return
	end

	-- is the context menu generated from LUA?
	if ContextMenu.IsLuaDriven == true then
	
		-- cleanup the context menu data
		ContextMenu.CleanUp()
	end
end

function ContextMenu.CleanUp()
	
	-- context menu window name
	local windowName = "ContextMenu"

	-- destroy all the lines
	ContextMenu.DestroyAll()

	-- do we have any data from previous hardcoded context menus?
	if WindowData.ContextMenu then

		-- reset the internal context menu data
		WindowData.ContextMenu.menuItems = nil
		WindowData.ContextMenu.objectId = nil
	end

	-- delete all the LUA generated context menu options
	ContextMenu.LuaMenuOptions = nil

	-- re-initialize the LUA generated context menu array
	ContextMenu.LuaMenuOptions = {}

	-- reset the LUA generated context menu flag
	ContextMenu.IsLuaDriven = false

	-- reset sub-menu timer
	ContextMenu.SubMenuDelayTimer = nil

	-- reset the parch style
	ContextMenu.ParchStyle = nil

	-- reset the background
	WindowSetShowing(windowName .. "WindowBackground", true)
	WindowSetShowing(windowName .. "WindowParchBackground", false)

	-- reset the frame
	WindowSetShowing(windowName .. "Frame", true)
	WindowSetShowing(windowName .. "ParchFrame", false)

	-- shrink the context menu
	WindowSetDimensions(windowName, 0, 0)

	-- reset the context menu window ID
	WindowSetId(windowName, 0)
	
	-- hide the context menu
	ContextMenu.ForceHide()
end

function ContextMenu.CreateMenuItems(numItemsNeeded, menuWindow)
	
	-- current context menu window name
	local this = "ContextMenu"

	-- hide all items for the window
	ContextMenu.HideAllItems(menuWindow)

	-- get the current number of rows
	local numHave = ContextMenu.NumItemsCreated[menuWindow] or 0

	-- is the number of rows that we have greater than the number of rows we need?
	if numHave >= numItemsNeeded then

		-- we can get out
		return
	end
	
	-- create the missing rows
	for i = numHave + 1, numItemsNeeded do

		-- row window name
		local itemName = menuWindow .. "Item" .. i
		
		-- create the row
		CreateWindowFromTemplate(itemName, inlineIf(ContextMenu.ParchStyle, "ContextMenuParchEntryDef", "ContextMenuEntryDef"), menuWindow)

		-- is this the first row?
		if i == 1 then

			-- anchor to the top-left of the parent window
			WindowAddAnchor(itemName, "topleft", menuWindow, "topleft", 3, ContextMenu.ITEM_WINDOW_SPACING)

		else -- anchor to the previous row
			WindowAddAnchor(itemName, "bottomleft", menuWindow .. "Item" .. i - 1, "topleft", 0, ContextMenu.ITEM_WINDOW_SPACING)
		end
	end
	
	-- update the current number of rows
	ContextMenu.NumItemsCreated[menuWindow] = numItemsNeeded
end

function ContextMenu.FillMenuItems(menuItems, menuWindow, submenuIndex)

	-- make sure we have all the rows we need
	ContextMenu.CreateMenuItems(#menuItems, menuWindow)

	-- scan all the menu items
	for i, item in pairsByIndex(menuItems) do

		-- row window name
		local itemName = menuWindow .. "Item" .. i

		-- is this a sub menu?
		if submenuIndex ~= nil and submenuIndex > 0 then

			-- calculate the sub menu element ID
			local offset = submenuIndex * 100

			-- set the sub-menu item ID
			WindowSetId(itemName, i + offset)

			-- set the text color for the element
			ContextMenu.ResetElementColor(itemName, i + offset)

		else -- if it's not a sub-menu the ID is the plain index we have
			WindowSetId(itemName, i)

			-- set the text color for the element
			ContextMenu.ResetElementColor(itemName, i)
		end
		
		-- do not create the loyalty rating row
		if item.tid == 1049594 then -- Loyalty Rating
			continue
		end
		
		-- if the flag for the element is not specified we set it to 0 by default
		if item.flags == nil then
			item.flags = 0
		end
		
		-- is the row grayed out?
		local grayedOut = (item.flags & ContextMenu.GREYEDOUT) ~= 0

		-- is the row highlighted?
		local highlighted = (item.flags & ContextMenu.HIGHLIGHTED) ~= 0

		-- do we have the tid for the name?
		if item.tid then

			-- get the element name
			local name = FormatProperly(GetStringFromTid(item.tid))
			
			-- is this the switch mastery action?
			if item.tid == 1151948 then -- Switch Mastery

				-- is the element grayed out?
				if grayedOut then

					-- get the time left before the action can be used
					local timeLeft = StringUtils.CountDownSeconds(Spellbook.MasteryChangeCooldown)

					-- append the time left to the name
					name = name .. L" (" .. towstring(timeLeft) .. L")"
				end
			end
			
			-- set the element name
			ButtonSetText(itemName, name)

		-- do we have a string for the name?
		elseif IsValidWString(item.str) then

			-- set the element name
			ButtonSetText(itemName, FormatProperly(item.str))

		else -- we have an empty line
			continue
		end

		-- enable the row (in case it was disabled on another context menu instance)
		ButtonSetDisabledFlag(itemName, false)

		-- is the row text highlighted and not grayed out?
		if item.pressed and not grayedOut then

			-- highlight the row text
			ButtonSetPressedFlag(itemName, true)

		else -- keep the row text unhighlighted
			ButtonSetPressedFlag(itemName, false)
		end
				
		-- show the row
		WindowSetShowing(itemName, true)
	end
	
	-- get the context menu default width
	local cmWidth = ContextMenu.WINDOW_WIDTH

	-- get the context menu default height (based on the amount of rows)
	local cmHeight = (#menuItems * (ContextMenu.ITEM_WINDOW_HEIGHT + ContextMenu.ITEM_WINDOW_SPACING)) + 5

	-- resize the context menu
	WindowSetDimensions(menuWindow, cmWidth, cmHeight)
end

function ContextMenu.HideAllItems(menuWindow)
	
	-- do we have any active row?
	if ContextMenu.NumItemsCreated[menuWindow] then

		-- scan all the rows
		for i = 1, ContextMenu.NumItemsCreated[menuWindow] do

			-- hide the row
			WindowSetShowing(menuWindow .. "Item" .. i, false)
		end
	end

	-- reset sub-menu timer
	ContextMenu.SubMenuDelayTimer = nil
end

function ContextMenu.MenuItemLButtonUp()

	-- row window name
	local this = SystemData.ActiveWindow.name
	
	-- clicked row ID
	local id = WindowGetId(this)

	-- get the context menu lines
	local itemData = ContextMenu.GetMenuItemData()

	-- initialize the context menu row data variable
	local menuOption
	
	-- is this a normal menu element?
	if id < 100 then

		-- get the row data
		menuOption = itemData[id]

	else -- sub menu element

		-- get the parent element ID
		local parentId = math.floor(id / 100)

		-- get the sub-menu ID
		local subMenuId = id - (parentId * 100)

		-- get the sub-menu row data
		menuOption = itemData[parentId].subMenuOptions[subMenuId]
	end

	-- do we have the row element data?
	if not menuOption then
		return
	end
	
	-- do we have an action or the parameters for the row?
	if menuOption.returnCode or menuOption.param then

		-- if we don't have a flag, we set it to 0 by default
		if not menuOption.flags then
			menuOption.flags = 0
		end
		
		-- if the row is disabled, we can get out
		if menuOption.flags & ContextMenu.GREYEDOUT ~= 0 then
			return
		end

		-- execute the action
		ContextMenu.ExecuteMenuItem(menuOption.returnCode, menuOption.param)
	end
	
	-- hide the context menu
	ContextMenu.ForceHide()
end

function ContextMenu.Update(timePassed)
	
	-- get the current context menu ID
	local currId = WindowGetId("ContextMenu")
	
	-- is the context menu generated from LUA?
	if ContextMenu.IsLuaDriven then

		-- is the context menu NOT visible?
		if not ContextMenu.IsShowing() then

			-- show the context menu at the mouse cursor position
			ContextMenu.ForceShow()
		end

	else -- hardcoded context menus

		-- scan the automated calls
		for id, _ in pairs(ContextMenu.AutomatedCall) do	

			-- is this the ID of the current context menu?
			if currId == id and ContextMenu.IsShowing() then

				-- hide the context menu
				ContextMenu.ForceHide()

			else -- if this is not the right ID, then we can remove the automated call (there is no queue in calling context menus)
				ContextMenu.AutomatedCall[id] = nil
			end
		end
	end
	
	-- reset the forced choice flag (used for certain menu that are in windows often refreshed and the context menu gets destroyed)
	ContextMenu.ForceChoice = nil
	
	-- do we have a sub-menu parent?
	if ContextMenu.SubMenuParentItemName and DoesWindowExist(ContextMenu.SubMenuParentItemName) then

		-- is the sub menu showing?
		if WindowGetShowing("ContextMenuSubMenu") then

			-- get the text color
			local textColor = inlineIf(ContextMenu.ParchStyle, ContextMenu.ParchMouseOverColor, ContextMenu.MouseOverColor)
			
			-- set the highlight text color (so if we have a sub-menu it will stay highlighted)
			ButtonSetTextColor(ContextMenu.SubMenuParentItemName, Button.ButtonState.NORMAL, textColor.r, textColor.g, textColor.b)

		else -- restore the default color
			
			-- sub-menu parent ID
			local id = WindowGetId(ContextMenu.SubMenuParentItemName)

			-- reset the color
			ContextMenu.ResetElementColor(ContextMenu.SubMenuParentItemName, id)
		end
	end

	-- no sub-menu timer? we can get out.
	if ContextMenu.SubMenuDelayTimer == nil then
		return
	end

	-- count the time before showing the sub-menu
	ContextMenu.SubMenuDelayTimer = ContextMenu.SubMenuDelayTimer - timePassed

	-- if it's greater than 0 we still need to wait
	if ContextMenu.SubMenuDelayTimer > 0 then
		return
	end

	--time to show the sub menu
	
	-- reset the timer
	ContextMenu.SubMenuDelayTimer = nil
	
	-- get the main context menu items
	local menuItems = ContextMenu.GetMenuItemData()
	
	-- is the current selection grayed out?
	if (menuItems[ContextMenu.SubMenuParentId].flags & ContextMenu.GREYEDOUT) ~= 0 then
		return
	end

	-- fill the sub-menu lines
	ContextMenu.FillMenuItems(menuItems[ContextMenu.SubMenuParentId].subMenuOptions, "ContextMenuSubMenu", ContextMenu.SubMenuParentId)

	-- show the sub-menu
	WindowSetShowing("ContextMenuSubMenu", true)

	-- clear the sub-menu anchors
	WindowClearAnchors("ContextMenuSubMenu")

	-- get the sub-menu dimensions
	local width, height = WindowGetDimensions("ContextMenuSubMenu")

	-- get the screen position of the main item
	local anchorPosX, anchorPosY = WindowGetScreenPosition(ContextMenu.SubMenuParentItemName)

	-- if we show the sub-menu at the main item location, will it still be inside the screen?
	if anchorPosY + height > SystemData.screenResolution.y then

		-- the sub-menu would go under the screen so we'll show it on TOP of the main menu item
		WindowAddAnchor("ContextMenuSubMenu", "bottomright", ContextMenu.SubMenuParentItemName, "bottomleft", 0, 0)

	else -- show the sub-menu UNDER the main menu item (normal view)
		WindowAddAnchor("ContextMenuSubMenu", "topright", ContextMenu.SubMenuParentItemName, "topleft", 0, 0)
	end

	-- focus the sub-menu
	WindowAssignFocus("ContextMenuSubMenu", true)
end

function ContextMenu.MenuItemMouseOver()

	-- row window name
	local this = SystemData.ActiveWindow.name

	-- clicked row ID
	local id = WindowGetId(this)

	-- get the context menu lines
	local menuItems = ContextMenu.GetMenuItemData()

	-- do we have the menu item?
	if menuItems[id] then

		-- make sure there is a flag
		if not menuItems[id].flags then
			menuItems[id].flags = 0
		end

		-- is the row grayed out?
		local grayedOut = (menuItems[id].flags & ContextMenu.GREYEDOUT) ~= 0

		-- make sure the button stays disabled if it's greyout
		ButtonSetDisabledFlag(this, grayedOut)
	end
	
	-- is this a normal menu element?
	if id < 100 then

		-- do we have a sub-menu?
		if menuItems[id] and menuItems[id].subMenuOptions ~= nil then

			-- do we have a sub-menu delay?
			if menuItems[id].subMenuDelay == nil then
				
				-- instantly show the sub-menu
				ContextMenu.SubMenuDelayTimer = 0

			else -- start the delay
				ContextMenu.SubMenuDelayTimer = menuItems[id].subMenuDelay
			end

			-- do we have a sub-menu parent?
			if ContextMenu.SubMenuParentItemName and DoesWindowExist(ContextMenu.SubMenuParentItemName) then

				-- sub-menu parent ID
				local id = WindowGetId(ContextMenu.SubMenuParentItemName)

				-- reset the color
				ContextMenu.ResetElementColor(ContextMenu.SubMenuParentItemName, id)
			end

			-- set the sub-menu parent ID
			ContextMenu.SubMenuParentId = id

			-- set the sub-menu parent element name
			ContextMenu.SubMenuParentItemName = this
		end

		-- hide the sub-menu
		WindowSetShowing("ContextMenuSubMenu", false)

	else -- reset the color for the sub-item
		ContextMenu.ResetElementColor(this, id)
	end
end

function ContextMenu.MenuItemMouseLeave()

	-- reset sub-menu timer
	ContextMenu.SubMenuDelayTimer = nil
end

function ContextMenu.ForceShow()

	-- is the context menu visible?
	if not WindowGetShowing("ContextMenu") then

		-- show the context menu 
		WindowSetShowing("ContextMenu", true)
	end

	-- set the context menu position at the mouse cursor
	ContextMenu.SetPosition()
end

function ContextMenu.ForceHide()
		
	-- hide the context menu
	WindowSetShowing("ContextMenu", false)

	-- hide the sub-menu
	WindowSetShowing("ContextMenuSubMenu", false)	

	-- set the context menu starting position outside the screen (so if we fail to hide it in time, it won't be visible anyway)
	WindowSetOffsetFromParent("ContextMenu", -1000, -1000)
end

function ContextMenu.IsShowing()

	-- get the context menu position
	local x, y = WindowGetOffsetFromParent("ContextMenu")

	-- if the context menu is in the visible area and is visible then it's active
	return x > 0 and y > 0 and WindowGetShowing("ContextMenu") 
end

function ContextMenu.RequestContextAction(ownerId, actionId)
	
	-- is this a vendor search map and we're trying to open the map?
	if Interface.VendorSearchMap and WindowData.ContextMenu.objectId == Interface.VendorSearchMap.itemID and actionId == ContextMenu.DefaultValues.OpenMap then

		-- show the location on the real map (instead of opening the gump)
		MapCommon.Locate(Interface.VendorSearchMap.x, Interface.VendorSearchMap.y, Interface.VendorSearchMap.facet)
		return
	end

	-- request an invisible context menu
	RequestContextMenu(ownerId, false)

	-- is this an open vendor container request? (from the vendor search map)
	if actionId == ContextMenu.DefaultValues.OpenVendorContainer then
	
		-- mark that we have a vendor container opening (so it will be recognized as player vendor container)
		ContainerWindow.VendorSearchMapRequest = true
	end

	-- is this a pet rename request?
	if actionId == ContextMenu.DefaultValues.RenamePet then

		-- use the custom pet rename function
		Interface.RenamePet(WindowData.ContextMenu.objectId)

	-- has the player requested to load the shurikens?
	elseif actionId == ContextMenu.DefaultValues.LoadShuriken then

		-- store the code to execute
		WindowData.ContextMenu.returnCode = actionId

		-- send the code to the server for execution
		BroadcastEvent(SystemData.Events.CONTEXT_MENU_SELECTED) 
		
		-- execute the auto-load shurikens
		Actions.LoadShuri(WindowData.ContextMenu.objectId)

	else -- store the code to execute
		WindowData.ContextMenu.returnCode = actionId

		-- send the code to the server for execution
		BroadcastEvent(SystemData.Events.CONTEXT_MENU_SELECTED) 
	end
end

function ContextMenu.ResetElementColor(itemName, id)

	-- do we have a valid ID?
	if not IsValidID(id) then
		return
	end

	-- get the context menu lines
	local menuItems = ContextMenu.GetMenuItemData()

	-- do we have a context menu?
	if not menuItems then
		return
	end

	-- get the current row data
	local item = menuItems[id]

	-- is this a sub-menu element?
	if id > 100 then

		-- calculate the parent ID
		local parentId = math.floor(id / 100)

		-- calculate the sub-menu ID
		local subMenuId = id - parentId * 100

		-- get the sub-menu element data
		item = menuItems[parentId].subMenuOptions[subMenuId]
	end

	-- do we have the data for this row?
	if not item then
		return
	end

	-- if the flag for the element is not specified we set it to 0 by default
	if item.flags == nil then
		item.flags = 0
	end

	-- is the row grayed out?
	local grayedOut = (item.flags & ContextMenu.GREYEDOUT) ~= 0

	-- is the row highlighted?
	local highlighted = (item.flags & ContextMenu.HIGHLIGHTED) ~= 0

	-- set the text color to the default color
	local textColor = inlineIf(ContextMenu.ParchStyle, ContextMenu.ParchNormalColor, ContextMenu.NormalColor)

	-- is the text grayed out?
	if grayedOut then

		-- get the grayout color
		textColor = inlineIf(ContextMenu.ParchStyle, ContextMenu.ParchDisabledColor, ContextMenu.DisabledColor)
		
		-- disable the row
		ButtonSetDisabledFlag(itemName, true)
		
	-- is the text grayed out?
	elseif highlighted and not grayedOut then
			
		-- enable the row
		ButtonSetDisabledFlag(itemName, false)

		-- get the highlight color
		textColor = inlineIf(ContextMenu.ParchStyle, ContextMenu.ParchHighlightColor, ContextMenu.HighlightColor)

	-- do we have a color table rgb?
	elseif type(item.textColor) == "table" then

		-- enable the row
		ButtonSetDisabledFlag(itemName, false)

		-- get the rgb text color from the table
		textColor = item.textColor

	-- do we have a hue color?
	elseif item.textColor then

		-- enable the row
		ButtonSetDisabledFlag(itemName, false)

		-- convert the hue to rgb
		local hueR, hueG, hueB = HueRGBAValue(item.textColor)

		-- create a table with the colors we got from the hue
		textColor = {r = hueR, g = hueG, b = hueB}
	end
	
	-- set the original text color to the label
	ButtonSetTextColor(itemName, Button.ButtonState.NORMAL, textColor.r, textColor.g, textColor.b)
end