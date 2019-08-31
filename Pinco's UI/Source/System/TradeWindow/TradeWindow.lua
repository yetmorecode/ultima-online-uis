----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

TradeWindow = {}
TradeWindow.TradeInfo ={}
--[[
<<<Variables in TradeInfo:>>>
containerId -> player trade container
containerId2 -> other trade container
tradeName -> other party name
containerIdAccept -> player accept trade
containerId2Accept -> other accept trade
myTradeGold -> player gold
myTradePlat -> player platinum
myGoldBalance -> player gold balance
myPlatBalance -> player platinum balance
theirTradeGold -> other gold offer
theirTradePlat -> other platinum offer
]]

TradeWindow.RegisteredItems = {}
TradeWindow.OpenContainers = {}
TradeWindow.NumCreatedSlots = {}

TradeWindow.StringTID = {}
TradeWindow.StringTID.MYOFFER = 1077713
TradeWindow.StringTID.THEIROFFER = 3000145
TradeWindow.StringTID.ACCEPT = 1013076
TradeWindow.StringTID.CANCEL = 1006045
TradeWindow.StringTID.WAITING = 1077715
TradeWindow.StringTID.ACCEPTED = 1077716
TradeWindow.StringTID.OFFER = 1077714
TradeWindow.StringTID.TRADE = 1077728
----------------------------------------------------------------
-- ContainerWindow Functions
----------------------------------------------------------------

function TradeWindow.OnCloseDialog()

	-- send the close trade to the other party
	BroadcastEvent(SystemData.Events.TRADE_SEND_CLOSE_WINDOW)
end

function TradeWindow.Initialize()

	-- current trade window name
	local this = SystemData.ActiveWindow.name

	-- current trade window ID
	local id = SystemData.DynamicWindowId

	-- set the ID to the window
	WindowSetId(this, id)
	
	-- update the current trade window name
	TradeWindow.CurrentTradeWindow = this

	-- fill the title label
	WindowUtils.SetWindowTitle(this, GetStringFromTid(TradeWindow.StringTID.TRADE))
	
	-- mark the window to be destroyed on close
	Interface.DestroyWindowOnClose[this] = true

	-- add the callback function for closing
	Interface.OnCloseCallBack[this] = TradeWindow.OnCloseDialog
	
	--Store the TradeInfo
	TradeWindow.TradeInfo[this] = WindowData.TradeInfo
	TradeWindow.OpenContainers[this] = true
	TradeWindow.NumCreatedSlots[this] = {}
	TradeWindow.NumCreatedSlots[this][TradeWindow.TradeInfo[this].containerId] = 0
	TradeWindow.NumCreatedSlots[this][TradeWindow.TradeInfo[this].containerId2] = 0

	-- attach the trade events to the window
	WindowRegisterEventHandler(this, SystemData.Events.TRADE_RECEIVE_CLOSE_WINDOW, "TradeWindow.CloseWindow")
	WindowRegisterEventHandler(this, SystemData.Events.TRADE_RECEIVE_ACCEPTMSG_WINDOW, "TradeWindow.AcceptMessage")
	WindowRegisterEventHandler(this, SystemData.Events.TRADE_RECEIVE_MODIFYGOLD_WINDOW, "TradeWindow.ModifyTheirGold")
	WindowRegisterEventHandler(this, SystemData.Events.TRADE_RECEIVE_BALANCE_WINDOW, "TradeWindow.UpdateBalance")
	
	--Register with two ContainerWindows
	Interface.GetContainersData(TradeWindow.TradeInfo[this].containerId)
	Interface.GetContainersData(TradeWindow.TradeInfo[this].containerId2)
	WindowRegisterEventHandler(this, WindowData.ContainerWindow.Event, "TradeWindow.MiniModelUpdate")
	WindowRegisterEventHandler(this, WindowData.ObjectInfo.Event, "TradeWindow.HandleUpdateObjectEvent")
	
	-- fill the my offer label
	LabelSetText(this .. "ItemDescMyOffer", GetStringFromTid(TradeWindow.StringTID.MYOFFER))

	-- fill the their offer label
	LabelSetText(this .. "ItemDescTradeOffer", GetStringFromTid(TradeWindow.StringTID.THEIROFFER))
	
	-- set the player name
	LabelSetText(this .. "PlayerAcceptName", towstring(TradeWindow.TradeInfo[this].playerName))

	-- set the other party name
	LabelSetText(this .. "TradeAcceptName", towstring(TradeWindow.TradeInfo[this].tradeName))
		
	-- turn the buttons in checkbox (for accept)
	ButtonSetStayDownFlag(this .. "PlayerAcceptCheck", true)
	ButtonSetStayDownFlag(this .. "TradeAcceptCheck", true)
				
	-- set the textbox for player offered gold to 0
	TextEditBoxSetText(this .. "PlayerAcceptGoldAmountGold",  L"0")

	-- set the label for player offered gold to 0
	LabelSetText(this .. "PlayerAcceptGoldAmountGoldLabel", L"0")

	-- set the textbox for other party offered gold to 0
	LabelSetText(this .. "PlayerWaitingGoldAmountGold", L"0")

	-- set the textbox for player offered platinum to 0
	TextEditBoxSetText(this .. "PlayerAcceptGoldAmountPlat", L"0")

	-- set the label for player offered platinum to 0
	LabelSetText(this .. "PlayerAcceptGoldAmountPlatLabel", L"0")

	-- set the textbox for other party offered platinum to 0
	LabelSetText(this .. "PlayerWaitingGoldAmountPlat", L"0")

	-- initialize the accept checkbox and button state
	TradeWindow.AcceptMessage()

	-- get the gold icon texture data
	local textureGold, goldx, goldy = GetIconData( 85856 )

	-- get the platinum texture data
	local texturePlat, platx, platy = GetIconData( 85855 )
	
	-- display the gold icon for player
	DynamicImageSetTextureDimensions(this .. "PlayerAcceptGoldImageGold", 40, 30)
	WindowSetDimensions(this .. "PlayerAcceptGoldImageGold", 40, 30)
	DynamicImageSetTexture(this .. "PlayerAcceptGoldImageGold", textureGold, goldx, goldy )
	DynamicImageSetTextureScale(this .. "PlayerAcceptGoldImageGold", 1)

	-- display the platinum icon for player
	DynamicImageSetTextureDimensions(this .. "PlayerAcceptGoldImagePlat", 40, 30)
	WindowSetDimensions(this .. "PlayerAcceptGoldImagePlat", 40, 30)
	DynamicImageSetTexture(this .. "PlayerAcceptGoldImagePlat", texturePlat, platx, platy)
	DynamicImageSetTextureScale(this .. "PlayerAcceptGoldImagePlat", 1)

	-- display the gold icon for the other party
	DynamicImageSetTextureDimensions(this .. "PlayerWaitingGoldImageGold", 40, 30)
	WindowSetDimensions(this .. "PlayerWaitingGoldImageGold", 40, 30)
	DynamicImageSetTexture(this .. "PlayerWaitingGoldImageGold", textureGold, goldx, goldy )
	DynamicImageSetTextureScale(this .. "PlayerWaitingGoldImageGold", 1)

	-- display the platinum icon for the other party
	DynamicImageSetTextureDimensions(this .. "PlayerWaitingGoldImagePlat", 40, 30)
	WindowSetDimensions(this .. "PlayerWaitingGoldImagePlat", 40, 30)
	DynamicImageSetTexture(this .. "PlayerWaitingGoldImagePlat", texturePlat, platx, platy )
	DynamicImageSetTextureScale(this .. "PlayerWaitingGoldImagePlat", 1)

	-- display the gold icon for the player total gold
	DynamicImageSetTextureDimensions(this .. "BalanceDescImageGold", 40, 30)
	WindowSetDimensions(this .. "BalanceDescImageGold", 40, 30)
	DynamicImageSetTexture(this .. "BalanceDescImageGold", textureGold, goldx, goldy )
	DynamicImageSetTextureScale(this .. "BalanceDescImageGold", 1)

	-- display the platinum icon for the player total platinum
	DynamicImageSetTextureDimensions(this .. "BalanceDescImagePlat", 40, 30)
	WindowSetDimensions(this .. "BalanceDescImagePlat", 40, 30)
	DynamicImageSetTexture(this .. "BalanceDescImagePlat", texturePlat, platx, platy )
	DynamicImageSetTextureScale(this .. "BalanceDescImagePlat", 1)

	-- hide the red cross over the accept checkbox
	WindowSetShowing(this .. "PlayerAcceptDenied", false)

	-- initialize the player gold balance
	LabelSetText(this .. "BalanceDescBalanceGold", L"0")

	-- initialize the player platinum balance
	LabelSetText(this .. "BalanceDescBalancePlat", L"0")

	-- reset the timer for enabling the accept button
	TradeWindow.LastGoldOfferChange = nil
end

function TradeWindow.UpdateBalance()
		
	-- current trade window name
	local this = SystemData.ActiveWindow.name

	-- update the player gold balance
	LabelSetText(this .. "BalanceDescBalanceGold", StringUtils.AddCommasToNumber(WindowData.TradeInfo.myGoldBalance))

	-- update the player platinum balance
	LabelSetText(this .. "BalanceDescBalancePlat", StringUtils.AddCommasToNumber(WindowData.TradeInfo.myPlatBalance))
end

function TradeWindow.ModifyTheirGold()	
	
	-- current trade window name
	local this = SystemData.ActiveWindow.name

	-- player accept button name	
	local playerButtonLabel = this .. "PlayerAcceptButton"

	-- red cross over the checkbox name
	local playerDeniedIMG = this .. "PlayerAcceptDenied"

	-- update the other party gold offer
	LabelSetText(this .. "PlayerWaitingGoldAmountGold", StringUtils.AddCommasToNumber(WindowData.TradeInfo.theirTradeGold))

	-- update the other party platinum offer
	LabelSetText(this .. "PlayerWaitingGoldAmountPlat", StringUtils.AddCommasToNumber(WindowData.TradeInfo.theirTradePlat))

	-- highlight in red the new values
	LabelSetTextColor(this .. "PlayerWaitingGoldAmountGold", 255, 0, 0)
	LabelSetTextColor(this .. "PlayerWaitingGoldAmountPlat", 255, 0, 0)

	-- disable the accept button
	WindowSetHandleInput(playerButtonLabel, false)

	-- show the label text as WAITING
	ButtonSetText(playerButtonLabel, GetStringFromTid(TradeWindow.StringTID.WAITING))

	-- show a red cross over the accept checkbox
	WindowSetShowing(playerDeniedIMG, true)

	-- save the time of the last gold offer change
	TradeWindow.LastGoldOfferChange = Interface.TimeSinceLogin
end

function TradeWindow.EnableAcceptButton()
	
	-- player accept button name	
	local playerButtonLabel = TradeWindow.CurrentTradeWindow .. "PlayerAcceptButton"

	-- red cross over the checkbox name
	local playerDeniedIMG = TradeWindow.CurrentTradeWindow .. "PlayerAcceptDenied"

	-- restore the gold and platinum offer text color
	LabelSetTextColor(TradeWindow.CurrentTradeWindow .. "PlayerWaitingGoldAmountGold", 255, 255, 255) 
	LabelSetTextColor(TradeWindow.CurrentTradeWindow .. "PlayerWaitingGoldAmountPlat", 255, 255, 255) 

	-- restore the accept button text
	ButtonSetText(playerButtonLabel, GetStringFromTid(TradeWindow.StringTID.ACCEPT))

	-- enable the accept button text
	WindowSetHandleInput(playerButtonLabel, true) 

	-- hide the red cross over the checkbox
	WindowSetShowing(playerDeniedIMG, false) 

	-- reset the timer
	TradeWindow.LastGoldOfferChange = nil
end

function TradeWindow.ReleaseRegisteredInfo()

	-- current trade window name
	local this = SystemData.ActiveWindow.name
	
	-- do we have a trade window active?
	if (this ~= nil and TradeWindow.TradeInfo[this] ~= nil) then
		
		-- reset the trade containers tables data
		TradeWindow.OpenContainers[this] = {}
		TradeWindow.TradeInfo[this] = {}
		TradeWindow.NumCreatedSlots[this] = {}
	end
end

function TradeWindow.Shutdown()

	-- make sure the item properties disappears before closing the window
	ItemProperties.ClearMouseOverItem()
	
	-- make sure all the items and containers are released
	TradeWindow.ReleaseRegisteredInfo()

	-- delete the current trade window name
	TradeWindow.CurrentTradeWindow = nil

	-- reset the timer for enabling the accept button
	TradeWindow.LastGoldOfferChange = nil
end

function TradeWindow.IsTradeContainer(searchID)

	-- scan all the trade windows
	 for win, data in pairs(TradeWindow.TradeInfo) do

		-- is this a trade container?
		if searchID == data.containerId or searchID == data.containerId2 then
			return true
		end
	 end
end

function TradeWindow.IsObjectRegistered(searchID)

	-- are there any object registered?
	if TradeWindow.RegisteredItems ~= nil then

		-- scal all the items registered for the trade window
		for id, data in pairs(TradeWindow.RegisteredItems) do

			-- is this the item we're looking for?
			if data[searchID] then

				-- return that the item is registered and the container ID
				return true, id
			end
		end
	end
end

function TradeWindow.ReleaseRegisteredObjects(parentWindow, containerId)

	-- do we have any registered items?
	if TradeWindow.RegisteredItems[containerId] ~= nil then

		-- scan all the reigstered items for the trade window
		for id, value in pairs(TradeWindow.RegisteredItems[containerId]) do

			-- release the item
			UnregisterWindowData(WindowData.ObjectInfo.Type, id)
		end

		-- reset the registered items table
		TradeWindow.RegisteredItems[containerId] = {}
	end
end

function TradeWindow.HideAllContents(parent, amount)

	-- scan all the possible items in the container (125)
	for i = 1, 125 do

		-- is the current ID included in the amount of created slots?
		if i <= amount then

			-- hide the slot
			WindowSetShowing(parent .. i, false)
		end
	end
end

function TradeWindow.CreateSlots(parentWindow, nextWindow, low, high)
	
	-- current parent window for the slot to create
	local parent = parentWindow .. nextWindow .. "ScrollWindowScrollChild"

	-- cycle between the min ID and the max ID specified
	for i = low, high do

		-- current slot window name
		local slotName = parent .. "Item" .. i

		-- create the slot window
		CreateWindowFromTemplate(slotName, "TradeItemTemplate", parent)

		-- set the slot ID
		WindowSetId(slotName, i)

		-- set the slot ID to the icon
		WindowSetId(slotName .. "Icon", i)
		
		-- is this the first slot?
		if i == 1 then

			-- anchor to the top left of the parent window
			WindowAddAnchor(slotName, "topleft", parent, "topleft", 0, 0)

		else -- anchor to the previous slot
			WindowAddAnchor(slotName, "bottomleft", parent .. "Item" .. i - 1, "topleft", 0, 0)
		end
	end

	-- update the scrollable area
	ScrollWindowUpdateScrollRect(parentWindow..nextWindow .. "ScrollWindow")	
end

function TradeWindow.UpdateContents(contId, win, force)
	
	-- current trade window name
	local this = SystemData.ActiveWindow.name

	-- do we have a window specified as parameter? (used for manual updates)
	if win then

		-- use the parameter window name
		this = win
	end
	
	-- initialize the base variables
	local contents
	local numItems
	local numCreatedSlots
	local fullName
	local updateFlag = false
	
	-- get the data of the trade container
	local data = Interface.GetContainersData(contId, true)

	-- do we need to force the update?
	if force then
		updateFlag = true
	end

	-- do we have the data of the trade container and the trade window is still active?
	if data and TradeWindow.TradeInfo[this] ~= nil then

		-- get the number of contained items
		contents = data.ContainedItems

		-- get the total number of items
		numItems = data.numItems

		-- get the number of created slots in the window
		numCreatedSlots = TradeWindow.NumCreatedSlots[this][contId] or 0

		-- is this the player trade container?
		if TradeWindow.TradeInfo[this].containerId == contId then

			-- player trade items list
			fullName = this .. "PlayerList"

			-- do we have enough slots for all the items?
			if numItems > numCreatedSlots then

				-- create the missing slots
				TradeWindow.CreateSlots(this, "PlayerList", numCreatedSlots + 1, numItems)

				-- update the slots count
				TradeWindow.NumCreatedSlots[this][contId] = numItems
			end		
			
			-- mark the container to be updated
			updateFlag = true

		-- is this the other party container?
		elseif TradeWindow.TradeInfo[this].containerId2 == contId then

			-- other paty trade item list
			fullName = this .. "TraderList"

			-- do we have nough slots for all the items?
			if numItems > numCreatedSlots then

				-- create the missing slots
				TradeWindow.CreateSlots(this, "TraderList", numCreatedSlots+1, numItems)

				-- update the slots count
				TradeWindow.NumCreatedSlots[this][contId] = numItems
			end	
			
			-- mark the container to be updated
			updateFlag = true
		end
		
		-- do we need to update the container?
		if updateFlag == true then

			-- scrollable area window name
			local contentName = fullName .. "ScrollWindowScrollChildItem"

			-- hide all the items
			TradeWindow.HideAllContents(contentName, numCreatedSlots)

			-- reset the registered items for this container
			TradeWindow.RegisteredItems[contId] = {}

			-- scan all the items inside the trade container
			for i = 1, numItems do

				-- current item data
				local item = data.ContainedItems[i]

				-- mark the current item as regisered
				TradeWindow.RegisteredItems[contId][item.objectId] = true
				
				-- perform the initial update of this object
				TradeWindow.UpdateObject(this, item.objectId, contId)

				-- show the item
				WindowSetShowing(contentName .. i, true)
			end
			
			-- Update the scroll windows			
			ScrollWindowUpdateScrollRect( fullName .. "ScrollWindow" )
		end
	end
end

function TradeWindow.DropObjectInContainer(currWindow, playerWindow, parentWindow)

	-- is this the player trade window and we're dragging an object?
	if currWindow == playerWindow and SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM then

		-- player trade container ID
		local containerId = TradeWindow.TradeInfo[parentWindow].containerId
		
		-- drop the item inside the trade container (top slot)
		DragSlotDropObjectToContainer(containerId, 0)
	end
end

function TradeWindow.IsPlayerContainer(currWindow, parentWindow)

	-- player trade container items list
	local playerWindow = parentWindow .. "PlayerList"

	-- is this the player trade container?
	if currWindow == playerWindow then
		return true
	end

	return false
end

function TradeWindow.IsTraderContainer(currWindow, parentWindow)

	-- other party trade container item list
	local traderWindow = parentWindow .. "TraderList"

	-- is this the other party trade container?
	if currWindow == traderWindow then
		return true
	end

	return false
end

function TradeWindow.OnContainerRelease()

	-- current trade container
	local this = SystemData.ActiveWindow.name

	-- current trade window
	local parentWindow = WindowGetParent(this)

	-- player trade container
	local playerWindow = parentWindow .. "PlayerList"

	-- drop the object in the player trade container
	TradeWindow.DropObjectInContainer(this, playerWindow, parentWindow)
end

function TradeWindow.OnItemRelease()

	-- current item slot
	local this = WindowGetParent(SystemData.ActiveWindow.name)

	-- current item list
	local currWindow = WindowGetParent(this)

	-- current item list container
	local nextWindow = WindowGetParent(currWindow)

	-- current trade window
	local parentWindow = WindowGetParent(nextWindow)

	-- player item list
	local playerWindow = parentWindow .. "PlayerList"

	-- drop the object inside the container
	TradeWindow.DropObjectInContainer(nextWindow, playerWindow, parentWindow)
end

function TradeWindow.OnItemDblClicked()

	-- current item ID
	local currWindowId = WindowGetId(SystemData.ActiveWindow.name)

	-- current item slot
	local this = WindowGetParent(SystemData.ActiveWindow.name)

	-- current item list
	local currWindow = WindowGetParent(this)

	-- current item list container
	local nextWindow = WindowGetParent(currWindow)

	-- current trade window
	local parentWindow = WindowGetParent(nextWindow)

	-- initialize the object ID
	local objectId
	
	-- is this the player trade container?
	if TradeWindow.IsPlayerContainer(nextWindow, parentWindow) then

		-- get the player container ID
		local containerId = TradeWindow.TradeInfo[parentWindow].containerId

		-- get the object ID
		objectId = WindowData.ContainerWindow[containerId].ContainedItems[currWindowId].objectId

	-- is this the other party trade container?
	elseif TradeWindow.IsTraderContainer(nextWindow, parentWindow) then

		-- get the other party container ID
		local containerId2 = TradeWindow.TradeInfo[parentWindow].containerId2

		-- get the object ID
		objectId = WindowData.ContainerWindow[containerId2].ContainedItems[currWindowId].objectId
	end
	
	-- do we have a valid object ID?
	if IsValidID(objectId) then

		-- use the item (if possible)
		UserActionUseItem(objectId, false)
	end
end

function TradeWindow.ItemMouseOver()

	-- get the current item ID
	local currWindowId = WindowGetId(SystemData.ActiveWindow.name)

	-- current item slot
	local this = WindowGetParent(SystemData.ActiveWindow.name)

	-- current item list
	local currWindow = WindowGetParent(this)

	-- current item list container
	local nextWindow = WindowGetParent(currWindow)

	-- current trade window
	local parentWindow = WindowGetParent(nextWindow)

	-- initialize the object ID
	local objectId
	
	-- is this the player trade container?
	if TradeWindow.IsPlayerContainer(nextWindow, parentWindow) then

		-- get the player container ID
		local containerId = TradeWindow.TradeInfo[parentWindow].containerId

		-- get the object ID
		objectId = WindowData.ContainerWindow[containerId].ContainedItems[currWindowId].objectId

	-- is this the other party trade container?
	elseif TradeWindow.IsTraderContainer(nextWindow, parentWindow) then

		-- get the other party container ID
		local containerId2 = TradeWindow.TradeInfo[parentWindow].containerId2

		-- get the object ID
		objectId = WindowData.ContainerWindow[containerId2].ContainedItems[currWindowId].objectId
	end
	
	-- do we have a valid object ID?
	if IsValidID(objectId) then

		-- create the item properties for the item
		local itemData = { 
							windowName = SystemData.ActiveWindow.name,
							itemId = objectId,
							itemType = WindowData.ItemProperties.TYPE_ITEM,
							detail = ItemProperties.DETAIL_LONG 
						 }

		-- show the item properties
		ItemProperties.SetActiveItem(itemData)
	end
end

function TradeWindow.OnAccept()

	-- current button window name
	local this = SystemData.ActiveWindow.name

	-- current button window container
	local nextWindow = WindowGetParent(this)

	-- current trade window name
	local parentWindow = WindowGetParent(nextWindow)

	-- do we have a trade window data?
	if TradeWindow.TradeInfo[parentWindow] == nil then

		-- initialize the trade window data
		TradeWindow.TradeInfo[parentWindow] = {}
	end
	
	-- does the player have unchecked the accept box?
	if TradeWindow.TradeInfo[parentWindow].containerIdAccept then

		-- flag the trade as NOT accepted
		WindowData.TradeInfo.containerIdAccept = false
		TradeWindow.TradeInfo[parentWindow].containerIdAccept = false

	else -- flag the trade as ACCEPTED
		WindowData.TradeInfo.containerIdAccept = true
		TradeWindow.TradeInfo[parentWindow].containerIdAccept = true
	end

	-- send the accept/not accept status to the server
	BroadcastEvent(SystemData.Events.TRADE_SEND_ACCEPTMSG_WINDOW)
end

function TradeWindow.CloseWindow()

	-- destroy the trade window
	DestroyWindow(SystemData.ActiveWindow.name)
end

function TradeWindow.AcceptMessage()

	-- current trade window
	local this = SystemData.ActiveWindow.name

	-- player accept checkbox name
	local playerButtonName = this .. "PlayerAcceptCheck"

	-- other party accept box name
	local tradeButtonName = this .. "TradeAcceptCheck"

	-- player accept button name	
	local playerButtonLabel = this .. "PlayerAcceptButton"

	-- otherparty accept status label
	local tradeLabel = this .. "TradeAcceptLabel"

	-- current player gold offer textbox
	local tradeGoldAmount = this .. "PlayerAcceptGoldAmountGold"

	-- current player platinum offer textbox
	local tradePlatAmount = this .. "PlayerAcceptGoldAmountPlat"


	-- has the player accepted the trade?
	if TradeWindow.TradeInfo[this].containerIdAccept then

		-- add the check on the checkbox
		ButtonSetPressedFlag(playerButtonName, true)

		-- show the button text as CANCEL
		ButtonSetText(playerButtonLabel, GetStringFromTid(TradeWindow.StringTID.CANCEL))
		
	else -- remove the check from the checkbox
		ButtonSetPressedFlag(playerButtonName, false)

		-- show the button text as ACCEPT
		ButtonSetText(playerButtonLabel, GetStringFromTid(TradeWindow.StringTID.ACCEPT))		
	end
	
	-- has the other party accepted?
	if TradeWindow.TradeInfo[this].containerId2Accept then

		-- add the check on the checkbox
		ButtonSetPressedFlag(tradeButtonName, true)

		-- show the label text as ACCEPTED
		LabelSetText(tradeLabel, GetStringFromTid(TradeWindow.StringTID.ACCEPTED))

	else -- remove the check from the checkbox
		ButtonSetPressedFlag(tradeButtonName, false)

		-- show the label text as WAITING
		LabelSetText(tradeLabel, GetStringFromTid(TradeWindow.StringTID.WAITING))
	end

	-- have one of the two parties accepted the trade?
	if TradeWindow.TradeInfo[this].containerIdAccept or TradeWindow.TradeInfo[this].containerId2Accept then

		-- disable the input for the gold textbox 
		WindowSetHandleInput(tradeGoldAmount, false)

		-- disable the input for the gold label 
		WindowSetHandleInput(tradeGoldAmount .. "Label", false)

		-- disable the input for the platinum textbox 
		WindowSetHandleInput(tradePlatAmount, false)

		-- disable the input for the platinum label 
		WindowSetHandleInput(tradePlatAmount .. "Label", false)

	else -- enable the input for the gold textbox 
		WindowSetHandleInput(tradeGoldAmount, true)

		-- enable the input for the gold label 
		WindowSetHandleInput(tradeGoldAmount .. "Label", true)
		
		-- enable the input for the platinum textbox 
		WindowSetHandleInput(tradePlatAmount, true)

		-- enable the input for the platinum label 
		WindowSetHandleInput(tradePlatAmount .. "Label", true)
	end
end

function TradeWindow.MiniModelUpdate()

	-- ID for the current container update request
	local contId = WindowData.UpdateInstanceId

	-- current trade window name
	local this = SystemData.ActiveWindow.name
	
	-- is the container to update th player or the other party trade container?
	if  TradeWindow.TradeInfo[this].containerId == contId or
	    TradeWindow.TradeInfo[this].containerId2 == contId  then

		-- update the container contents
		TradeWindow.UpdateContents(contId)
	end
end

function TradeWindow.OnUpdate()

	-- current trade window name
	local this = SystemData.ActiveWindow.name

	-- update the items list for both parties
	TradeWindow.UpdateContents(TradeWindow.TradeInfo[this].containerId)
	TradeWindow.UpdateContents(TradeWindow.TradeInfo[this].containerId2)

	-- gold and platinum textbox window names
	local tradeGoldAmount = this .. "PlayerAcceptGoldAmountGold"
	local tradePlatAmount = this .. "PlayerAcceptGoldAmountPlat"

	-- is the gold textbox focused?
	if not WindowHasFocus(tradeGoldAmount) then

		-- label window name
		local label = tradeGoldAmount .. "Label"

		-- hide the label
		WindowSetShowing(label, true)

		-- show the textbox
		WindowSetShowing(tradeGoldAmount, false)
	end

	-- is the platinum textbox focused?
	if not WindowHasFocus(tradePlatAmount) then

		-- label window name
		local label = tradePlatAmount .. "Label" 

		-- hide the label
		WindowSetShowing(label, true)

		-- show the textbox
		WindowSetShowing(tradePlatAmount, false)
	end

	-- is it time to re-enable the accept button?
	if TradeWindow.LastGoldOfferChange and Interface.TimeSinceLogin > TradeWindow.LastGoldOfferChange + 2 then
		TradeWindow.EnableAcceptButton()
	end
end

function TradeWindow.HandleUpdateObjectEvent()

	-- update the item in one of the trade containers
    TradeWindow.UpdateObject(SystemData.ActiveWindow.name, WindowData.UpdateInstanceId)
end

function TradeWindow.UpdateObject(window, updateId, containerId)

	-- do we have the container ID?
	if not containerId then

		-- try to get the container ID from the item to update
		containerId = GetItemContainerID(updateId)
	end

	-- initialize the base variables
	local containedItems
	local numItems
	local slotIndex
	local windowName

	-- is the item inside the player or the other party trade container?
	if TradeWindow.OpenContainers[window] == true and TradeWindow.TradeInfo[window] ~= nil then

		-- is the item inside the player trade container?
		if TradeWindow.TradeInfo[window].containerId == containerId then
			
			-- set the window name as the player items list
			windowName = window .. "PlayerList"

		-- is the item inside the other party trade container?
		elseif TradeWindow.TradeInfo[window].containerId2 == containerId then

			-- set the window name as the other party items list
			windowName = window .. "TraderList"
		end
	
		-- do we know in which party container the item is?
		if windowName ~= nil then

			-- get the container data
			local containerData = Interface.GetContainersData(containerId, true)
			
			-- get the amount of items inside the container
			containedItems = containerData.ContainedItems

			-- get the total amount of items
			numItems = containerData.numItems

			-- initialize the slot ID
			slotIndex = 0

			-- scan all the items to find the slot ID for the item
			for i = 1, numItems do

				-- is this the item we need?
				if containedItems[i].objectId == updateId then

					-- update the slot index with the right one
					slotIndex = i

					break
				end
			end

			-- get the item data
			local item = Interface.GetObjectInfoData(updateId)

			-- do we have the item data?
			if item then
				
				-- slot window name
				local defaultName = windowName .. "ScrollWindowScrollChildItem" .. slotIndex

				-- slot window name label
				local elementName = defaultName .. "Name"

				-- update the item name
				LabelSetText(elementName, item.name )

				-- show the slot
				WindowSetShowing(elementName, true)
		
				-- slot window icon
				local elementIcon = defaultName .. "Icon"

				-- do we have a valid icon for the item?
				if item.iconName ~= "" then

					-- update the item icon
					EquipmentData.UpdateItemIcon(elementIcon, item)	
				
					-- clear the icon anchors
					WindowClearAnchors(elementIcon)

					-- try to center the icon in the slot
					WindowAddAnchor(elementIcon, "topleft", defaultName, "topleft", 15 + ((45 - item.newWidth) / 2), 15 + ((45 - item.newHeight) / 2))
				
					-- show the icon
					WindowSetShowing(elementIcon, true)

				else -- since there is no icon we hide it
					WindowSetShowing(elementIcon, false)
				end
			end
		end
	end
end


function TradeWindow.DangerMouseOver()

	-- create a tooltip for the trade warning
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(347))
end

function TradeWindow.MyTradeTotalGoldMouseOver()

	-- create a tooltip for your trade gold icon
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(1156205)) -- Your Trade Gold
end

function TradeWindow.MyTradeTotalPlatMouseOver()

	-- create a tooltip for your trade platinum icon
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(1156206)) -- Your Trade Platinum
end

function TradeWindow.TheirTradeTotalGoldMouseOver()

	-- create a tooltip for the other party trade gold icon
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(1156207)) -- Their Trade Gold
end

function TradeWindow.TheirTradeTotalPlatMouseOver()

	-- create a tooltip for the other party trade platinum icon
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(1156208)) -- Their Trade Platinum
end

function TradeWindow.BalanceGoldMouseOver()

	-- create a tooltip for your gold balance icon
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(1156203)) -- Your Current Gold Balance
end

function TradeWindow.BalancePlatMouseOver()
	
	-- create a tooltip for your platinum balance icon
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(1156204)) -- Your Current Platinum Balance
end

function TradeWindow.OnKeyEnter()
	
	-- textbox window name
	local this = SystemData.ActiveWindow.name

	-- hide the textbox
	WindowSetShowing(this, false)

	-- show the label
	WindowSetShowing(this .. "Label", true)
end

function TradeWindow.OnKeyDown()

	-- current textbox
	local this = SystemData.ActiveWindow.name	

	-- current textbox container
	local parentWindow = WindowGetParent(this)	

	-- current trade window
	this = WindowGetParent(parentWindow)
	
	-- gold amount in the textbox
	local gold = tonumber(TextEditBoxGetText(this .. "PlayerAcceptGoldAmountGold"))

	-- platinum amount in the textbox
	local plat = tonumber(TextEditBoxGetText(this .. "PlayerAcceptGoldAmountPlat"))

	-- player gold balance
	local goldBalance = tonumber(WindowData.TradeInfo.myGoldBalance)

	-- player platinum balance
	local platBalance = tonumber(WindowData.TradeInfo.myPlatBalance)

	-- max gold/platinum amount
	local PLATINUM_SIZE = 1000000000

	-- is the gold exceeding the cap?
	if gold >= PLATINUM_SIZE then	

		-- set the gold to the maximum amount
		gold = PLATINUM_SIZE - 1

		-- update the textbox
		TextEditBoxSetText(this .. "PlayerAcceptGoldAmountGold", towstring(gold))
	end

	-- is the platinum exceeding the cap?
	if plat >= PLATINUM_SIZE then

		-- set the platinum to the maximum amount
		plat = PLATINUM_SIZE - 1

		-- update the textbox
		TextEditBoxSetText(this .. "PlayerAcceptGoldAmountPlat", towstring(plat))
	end
	
	-- is the gold amount greater than the player has available?
	if gold > goldBalance then

		-- set the gold amount to the maximum amount available
		gold = goldBalance

		-- update the textbox
		TextEditBoxSetText(this .. "PlayerAcceptGoldAmountGold", towstring(gold))
	end

	-- is the platinum amount greater than the player has available?
	if plat > platBalance then
		
		-- set the platinum amount to the maximum amount available
		plat = platBalance

		-- update the textbox
		TextEditBoxSetText(this .. "PlayerAcceptGoldAmountPlat", towstring(plat))
	end

	-- set the gold and platinum amount in the data to be sent to the server
	WindowData.TradeInfo.myTradeGold = gold
	WindowData.TradeInfo.myTradePlat = plat

	-- send the data to the server
	BroadcastEvent(SystemData.Events.TRADE_SEND_MODIFYGOLD_WINDOW)
end

function TradeWindow.FocusTextbox()

	-- label window name
	local this = SystemData.ActiveWindow.name

	-- textbox window name
	local textBox = string.gsub(this, "Label", "")

	-- hide the label
	WindowSetShowing(this, false)

	-- show the textbox
	WindowSetShowing(textBox, true)

	-- remove the "Label" to get the textbox name, and focus it
	WindowAssignFocus(textBox, true)
end

function TradeWindow.TextChanged()

	-- textbox window name
	local this = SystemData.ActiveWindow.name

	-- label window name
	local label = this .. "Label"

	-- update the label with the number with commas
	LabelSetText(label, StringUtils.AddCommasToNumber(TextEditBoxGetText(this)))
end