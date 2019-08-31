----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

Shopkeeper = {}
Shopkeeper.TID ={}
Shopkeeper.TID.SELLABLE		= 1077865		-- SELLABLE ITEMS
Shopkeeper.TID.SALES		= 1077867		-- PENDING SALES
Shopkeeper.TID.NPCSTORE		= 1077868		-- NPC STORE
Shopkeeper.TID.PURCHASES	= 1077869		-- PENDING PURCHASES
Shopkeeper.TID.NPCVENDOR	= 1077870		-- NPC VENDOR
Shopkeeper.TID.Accept		= 1013076		-- Accept
Shopkeeper.TID.Cancel		= 1006045		-- Cancel
--Shopkeeper.TID.Spent		= 1077871		-- "Spent: "
Shopkeeper.TID.Spent		= 1079160		-- Total Gold --3000087	Total 
Shopkeeper.TID.Quantity		= 1077826		-- Quantity
Shopkeeper.TID.Items		= 1077872		-- Items
Shopkeeper.TID.Cost			= 1060034		-- Cost
Shopkeeper.TID.Purchase		= 1011530		-- Purchase
Shopkeeper.TID.All			= 1077866		-- All
Shopkeeper.TID.Remove		= 1011403		-- Remove
Shopkeeper.TID.Clear		= 3000154		-- Clear

Shopkeeper.REFRESH_DELAY = 0.3
Shopkeeper.QUANTITY_DELAY = 0.3
Shopkeeper.LEFT_SIDE_ID = 0
Shopkeeper.RIGHT_SIDE_ID = 1
Shopkeeper.CurrentAmountArray = {}
Shopkeeper.currentShop = {}

Shopkeeper.Buying = {}
----------------------------------------------------------------
-- Shopkeeper Functions
----------------------------------------------------------------

function Shopkeeper.stripFirstNumber(wStr)
	if (not IsValidWString(wStr) and not IsValidString(wStr)) then
		return wStr
	end
	if (type(wStr) == "string") then
		wStr = towstring(wStr)
	end
	wStr = wstring.gsub(wStr, L"%,", L"" )
	local tempStr = wstring.gsub(wStr, L"^%d* ", L"" )
	return tempStr
end

function Shopkeeper.GetItemIndexById(merchantId, itemId)
    if (Shopkeeper.currentShop[merchantId] and Shopkeeper.currentShop[merchantId].Items ~= nil) then
        for index = 1, #Shopkeeper.currentShop[merchantId].Items do
			local data = Shopkeeper.currentShop[merchantId].Items[index]
            if (data.id == itemId) then
                return index
            end
        end
    end
end

-- OnInitialize Handler
function Shopkeeper.Initialize()
    local this = SystemData.ActiveWindow.name
    local merchantId = SystemData.DynamicWindowId
    
    WindowSetId(this, merchantId)
    Interface.DestroyWindowOnClose[this] = true  
	
	-- Initialize static data
    --WindowUtils.SetWindowTitle (this, GetStringFromTid(Shopkeeper.TID.NPCVENDOR) )

    ButtonSetText("PurchaseButton", GetStringFromTid(Shopkeeper.TID.Accept))
    ButtonSetText("CancelPurchaseButton", GetStringFromTid(Shopkeeper.TID.Clear))    

    LabelSetText ("TotalCostText", GetStringFromTid(Shopkeeper.TID.Spent))
    
    LabelSetText ("ShopItemsHeaderQuantityHeader", GetStringFromTid(Shopkeeper.TID.Quantity))
    LabelSetText ("ShopItemsHeaderItemNamesHeader", GetStringFromTid(Shopkeeper.TID.Items))
    LabelSetText ("ShopItemsHeaderItemCostsHeader", GetStringFromTid(Shopkeeper.TID.Cost))
    LabelSetText ("ShopItemsHeaderItemPurchaseHeader", GetStringFromTid(Shopkeeper.TID.Purchase))
    
    LabelSetText ("PurchasedItemsHeaderQuantityHeader", GetStringFromTid(Shopkeeper.TID.Quantity))
    LabelSetText ("PurchasedItemsHeaderItemNamesHeader", GetStringFromTid(Shopkeeper.TID.Items))
    LabelSetText ("PurchasedItemsHeaderItemCostsHeader", GetStringFromTid(Shopkeeper.TID.Cost))
    LabelSetText ("PurchasedItemsHeaderItemPurchaseHeader", GetStringFromTid(Shopkeeper.TID.Purchase))
    
    -- Initialize dynamic data
    Shopkeeper.currentShop[merchantId] = {}
    Shopkeeper.currentShop[merchantId].RefreshTimer = 0
    Shopkeeper.currentShop[merchantId].OfferAccepted = false
    Shopkeeper.currentShop[merchantId].IsSelling = WindowData.ShopData.IsSelling
    Shopkeeper.currentShop[merchantId].Items = {}
    Shopkeeper.currentShop[merchantId].IsQuantityUpdating = false
    Shopkeeper.currentShop[merchantId].QuantityUpdate = {}
    
	if (WindowData.ShopData.IsSelling == true) then   
		LabelSetText ("StoreName", GetStringFromTid(Shopkeeper.TID.SELLABLE	) )
		LabelSetText ("PurchaseListTitle", GetStringFromTid(Shopkeeper.TID.SALES) )	
		WindowSetShowing("ShopkeeperBuy", false)
		WindowSetShowing("ShopkeeperSell", true)
		Shopkeeper.UpdateSellItems(this, merchantId)
		
		local textureData = SystemData.PaperdollTexture[GetPlayerID()]
		if textureData ~= nil then
			WindowSetDimensions(this .."Texture", textureData.Width, textureData.Height)
			DynamicImageSetTexture(this .."Texture", "paperdoll_texture"..GetPlayerID(), 0, 0 )
		end
	else	
		local mobName = GetMobileName(merchantId)
		local name = wstring.sub(mobName, wstring.find(mobName, L"The", 1, true) +4)
		name = wstring.gsub(name, L"Guildmaster", L"")
		name = wstring.gsub(name, L"Guildmistress", L"")
		LabelSetText ("StoreName", wstring.upper(ReplaceTokens(GetStringFromTid(1155263), {name})) )--GetStringFromTid(Shopkeeper.TID.NPCSTORE) )
		
		WindowSetShowing("ShopkeeperBuy", true)     
		WindowSetShowing("ShopkeeperSell", false)
		-- get the sell container id
		local itemData = Interface.GetObjectInfoData(merchantId)
		Shopkeeper.currentShop[merchantId].sellContainerId = itemData.sellContainerId

		Interface.GetContainersData(Shopkeeper.currentShop[merchantId].sellContainerId)
		WindowRegisterEventHandler(this, WindowData.ContainerWindow.Event, "Shopkeeper.HandleUpdateBuyItemsEvent")
		WindowRegisterEventHandler(this, WindowData.ObjectInfo.Event, "Shopkeeper.HandleUpdateObjectEvent")
		WindowRegisterEventHandler(this, WindowData.ItemProperties.Event, "Shopkeeper.HandleUpdateObjectNameEvent")
		
		LabelSetText ("PurchaseListTitle", GetStringFromTid(Shopkeeper.TID.PURCHASES) )
		
		Shopkeeper.UpdateBuyItems(this, merchantId)
		
		local textureData = SystemData.PaperdollTexture[merchantId]
		if textureData ~= nil then
			WindowSetDimensions(this .."Texture", textureData.Width, textureData.Height)
			DynamicImageSetTexture(this .."Texture", "paperdoll_texture"..merchantId, 0, 0 )
		end
	end  
	
	--Get the amount of gold player has
	--WindowRegisterEventHandler(this, WindowData.PlayerStatus.Event, "Shopkeeper.UpdatePlayersGold")

	Shopkeeper.currentShop[merchantId].PlayerGold = WindowData.PlayerStatus.Gold
	Shopkeeper.currentShop[merchantId].TotalPurchaseCost = 0
	
    Shopkeeper.UpdatePlayersGold(merchantId)
    
	local name, x, y, scale, newWidth, newHeight = RequestTileArt(3820,100,100) -- gold
	scale = 1.2
	WindowSetId("TotalCostImage", 3820)
	DynamicImageSetTextureDimensions("TotalCostImage", newWidth *scale, newHeight*scale)
	WindowSetDimensions("TotalCostImage", newWidth*scale, newHeight*scale)
	DynamicImageSetTexture("TotalCostImage", name, x, y )
	DynamicImageSetTextureScale("TotalCostImage", scale)
end

function Shopkeeper.OnUpdate(timePassed) 
    local this = SystemData.ActiveWindow.name
    local merchantId = WindowGetId(this)
    Shopkeeper.currentShop[merchantId].RefreshTimer = Shopkeeper.currentShop[merchantId].RefreshTimer + timePassed
    if (Shopkeeper.currentShop[merchantId].RefreshTimer > Shopkeeper.REFRESH_DELAY and
            Shopkeeper.currentShop[merchantId].IsDirty == true) then
        Shopkeeper.RefreshLists(this,merchantId)
    end
    
    if (Shopkeeper.currentShop[merchantId].IsQuantityUpdating == true) then
        Shopkeeper.currentShop[merchantId].QuantityUpdate.Timer = Shopkeeper.currentShop[merchantId].QuantityUpdate.Timer + timePassed
        if (Shopkeeper.currentShop[merchantId].QuantityUpdate.Timer > Shopkeeper.QUANTITY_DELAY) then
            Shopkeeper.UpdateItemRightQuantity(this, merchantId, Shopkeeper.currentShop[merchantId].QuantityUpdate.ItemIndex, Shopkeeper.currentShop[merchantId].QuantityUpdate.Amount)
        end
    end  
    Shopkeeper.UpdatePlayersGold(merchantId)
end

function Shopkeeper.UpdateSellItems(this, merchantId) 
    -- for selling we can assume that the list will never change while the window is open   
    
    local numItems = #WindowData.ShopData.Sell.Names
    
    local itemList = Shopkeeper.currentShop[merchantId].Items
    
    for itemIndex=1, numItems do
        if (WindowData.ShopData.Sell.Quantities[itemIndex] ~= 0) then
            itemList[itemIndex] = {}
            itemList[itemIndex].id = WindowData.ShopData.Sell.Ids[itemIndex]
		    itemList[itemIndex].leftQuantity = WindowData.ShopData.Sell.Quantities[itemIndex]
		    itemList[itemIndex].rightQuantity = 0 
		    itemList[itemIndex].totalQuantity = WindowData.ShopData.Sell.Quantities[itemIndex]
		    itemList[itemIndex].value = WindowData.ShopData.Sell.Prices[itemIndex]
		    itemList[itemIndex].name = Shopkeeper.stripFirstNumber( WindowData.ShopData.Sell.Names[itemIndex] )
		    itemList[itemIndex].objType = WindowData.ShopData.Sell.Types[itemIndex]
		end
    end
    
    Shopkeeper.currentShop[merchantId].IsDirty = true
end

function Shopkeeper.HandleUpdateBuyItemsEvent()
    local this = SystemData.ActiveWindow.name
    local merchantId = WindowGetId(this)
    local sellContainer = WindowData.UpdateInstanceId
    
    if (Shopkeeper.currentShop[merchantId] and Shopkeeper.currentShop[merchantId].sellContainerId == sellContainer) then
        Shopkeeper.UpdateBuyItems(this, merchantId)
    end
end

function Shopkeeper.UpdateBuyItems(this, merchantId)
    -- the list of buy items can be updated at any time (if any item is removed we simply set its quantities to 0)
    
    local sellContainerId = Shopkeeper.currentShop[merchantId].sellContainerId
    local data = WindowData.ContainerWindow[sellContainerId]
    
    if (data == nil) then
        return
    end
    
    local itemList = Shopkeeper.currentShop[merchantId].Items
    
    for index = 1, #itemList do
		local itemData = itemList[index]
        if (itemData.registered == true) then
            itemData.registered = false        
        end
        itemData.found = false
    end
    
	for i = 1, data.numItems do
	    local item = data.ContainedItems[i]    
	    
		-- register for updates to this object
		Interface.GetObjectInfoData(objectId)
	    Interface.GetItemPropertiesData(objectId)

	    -- if the item doesnt exist create an empty record
	    local itemIndex = Shopkeeper.GetItemIndexById(merchantId, item.objectId)
	    if (itemIndex == nil) then
	        itemIndex = #itemList + 1
	        itemList[itemIndex] = {}
	        itemList[itemIndex].id = item.objectId
	    end
	    
	    itemList[itemIndex].found = true
	    itemList[itemIndex].registered = true
	    
	    --Debug.Print("Initial: "..tostring(itemIndex)..", "..tostring(item.objectId))
	    
	    Shopkeeper.UpdateBuyObject(this, merchantId, item.objectId)
	end
	
	-- if any of the items have been removed, just clear out the quantities
	-- so we dont mess up the index order
	for index = 1, #itemList do
		local data = itemList[index]
	    if (data.found == false) then
	        data.totalQuantity = 0
	        data.leftQuantity = 0
	        data.rightQuantity = 0
	    end
	end
	
	Shopkeeper.currentShop[merchantId].IsDirty = true
end

function Shopkeeper.HandleUpdateObjectEvent()
    local this = SystemData.ActiveWindow.name
    local merchantId = WindowGetId(SystemData.ActiveWindow.name)
    local objectId = WindowData.UpdateInstanceId
    
    Shopkeeper.UpdateBuyObject(this, merchantId, objectId)
end

function Shopkeeper.HandleUpdateObjectNameEvent()
    local this = SystemData.ActiveWindow.name
    local merchantId = WindowGetId(SystemData.ActiveWindow.name)
    local objectId = WindowData.UpdateInstanceId

    Shopkeeper.UpdateBuyObject(this, merchantId, objectId)
end


function Shopkeeper.UpdateBuyObject(this, merchantId, objectId)

    local itemIndex = Shopkeeper.GetItemIndexById(merchantId, objectId)
    if (itemIndex == nil) then
        return
    end
    
    local itemList = Shopkeeper.currentShop[merchantId].Items    
    
    if (itemIndex ~= nil and merchantId ~= nil) then
        local item = Interface.GetObjectInfoData(objectId)
		
		local itemData = itemList[itemIndex]

		itemData.value = item.shopValue
		itemData.objType = item.objectType
		itemData.name = GetItemNameFromProperties(objectId)
	    
		--Debug.Print("Updated Object: "..tostring(itemIndex)..", "..tostring(itemData.id))
        
		-- calculate the new left, right and total quantities
		if (itemData.totalQuantity == nil) then
			itemData.leftQuantity = item.shopQuantity
			itemData.rightQuantity = 0 	        
		else
			if (itemData.rightQuantity > item.shopQuantity) then
				itemData.rightQuantity = item.shopQuantity
				itemData.leftQuantity = 0
			else
				itemData.leftQuantity = item.shopQuantity - itemData.rightQuantity
			end
		end
		itemData.totalQuantity = item.shopQuantity
    end
    
    Shopkeeper.currentShop[merchantId].IsDirty = true
end

function Shopkeeper.HasItem(itemId)
	if DoesWindowExist("Shopkeeper") then
		local merchantId = WindowGetId("Shopkeeper")
		for index = 1, #Shopkeeper.currentShop[merchantId].Items do
			local data = Shopkeeper.currentShop[merchantId].Items[index]
			if (data.id == itemId) then
				return true
			end
		end
	end
	return false
end

function Shopkeeper.UpdateItemIcon(merchantId,elementIcon,itemData)
    if (Shopkeeper.currentShop[merchantId].IsSelling) then
	    local name, x, y, scale, newWidth, newHeight = RequestTileArt(itemData.objType,300,300)
	    scale = 10
		if newWidth * scale > 50 or newHeight * scale > 50 then
			for j = scale, 0.1, -0.1 do

				if newWidth * j <= 50 and newHeight * j <= 50 then
					scale = j
					break
				end
			end
		end
	    DynamicImageSetTextureDimensions(elementIcon, newWidth* scale, newHeight* scale)
	    WindowSetDimensions(elementIcon, newWidth* scale, newHeight* scale)
	    DynamicImageSetTexture(elementIcon, name, x, y )
	    DynamicImageSetTextureScale(elementIcon, scale)		        
	    WindowSetDimensions(elementIcon, newWidth*scale, newHeight*scale)
    else
        local iconData = Interface.GetObjectInfoData(itemData.id)
		if iconData then
			EquipmentData.UpdateItemIcon(elementIcon, iconData)
		end
    end
end

function Shopkeeper.Restart()
	SearchBox.Classes.Shopkeeper.filtersTable = {}
	Shopkeeper.RefreshLists("Shopkeeper",WindowGetId("Shopkeeper"))
end

function Shopkeeper.OnLButtonUpSearch()
	local text = SearchBox.GetFilter("ShopkeeperSearchBox", true)
	if not IsValidWString(text) then
		return
	end

	local ok = true
	for k = 1, #SearchBox.Classes.Shopkeeper.filtersTable do
		if text == SearchBox.Classes.Shopkeeper.filtersTable[k] then
			ok = false
			break
		end
	end
	if ok then
		table.insert(SearchBox.Classes.Shopkeeper.filtersTable, text)
		--Debug.Print(L"ADD " .. text)
	end
	Shopkeeper.RefreshLists("Shopkeeper",WindowGetId("Shopkeeper"))
end

function Shopkeeper.RefreshLists(window,merchantId)
    --Debug.Print("Shopkeeper.RefreshLists")
    Shopkeeper.currentShop[merchantId].IsDirty = false

	local shopData = Shopkeeper.currentShop[merchantId]
    if (shopData ~= nil) then
        -- first destroy all the old windows
        if (shopData.LeftWindows ~= nil) then
            for index = 1, #shopData.LeftWindows do
				local data = shopData.LeftWindows[index]
				DestroyWindow(data.name)
            end
        end
        shopData.LeftWindows = {}
        if (shopData.RightWindows ~= nil) then
            for index = 1, #shopData.RightWindows do
				local data = shopData.RightWindows[index]
                DestroyWindow(data.name)
            end        
        end        
        shopData.RightWindows = {}
        
        Shopkeeper.currentShop[merchantId].TotalPurchaseCost = 0
        if (shopData.Items ~= nil) then
            local leftIndex = 1
            local rightIndex = 1
            for index = 1, #shopData.Items do
				local data = shopData.Items[index]
				if not data or not data.leftQuantity then
					continue
				end
				local filter =  true
				for k = 1, #SearchBox.Classes.Shopkeeper.filtersTable do
					local text = SearchBox.Classes.Shopkeeper.filtersTable[k]
					local patt = false
					if (wstring.find(wstring.lower(data.name), wstring.lower(text), 1, true) or wstring.lower(data.name) == wstring.lower(text)) then
						patt = true
					end
					if (not patt) then
						filter = false
						break
					end
				end

                if (data.leftQuantity > 0 and data.value > 0 ) and filter then

                    local itemWindowName = window.."LeftItem"..leftIndex
                    CreateWindowFromTemplate( itemWindowName, "ShopItemTemplate", "ShopItemsScrollWindowScrollChildCont" )
                    WindowSetAlpha(itemWindowName .. "BG", 0.5)
                    WindowClearAnchors(itemWindowName)
                    if (leftIndex == 1)  then
                        WindowAddAnchor( itemWindowName, "topleft", "ShopItemsScrollWindowScrollChildCont", "topleft", 5, 5)
                    else
                        local prevWindowName = window.."LeftItem"..(leftIndex-1)
                        WindowAddAnchor( itemWindowName, "bottomleft", prevWindowName, "topleft", 0, 5)                               
                    end
                    
                    ButtonSetText(itemWindowName.."BuyMore",L"+")
                    ButtonSetText(itemWindowName.."BuyLess",L"-")
                    ButtonSetText(itemWindowName.."BuyAll",L"  " .. GetStringFromTid(Shopkeeper.TID.All) .. L"    ")
                    
                    if (data.name ~= nil) then
                        LabelSetText(itemWindowName.."Name",data.name)
                    end
                    LabelSetText(itemWindowName.."Cost",L""..data.value)                        
                    LabelSetText(itemWindowName.."Quantity", L""..data.leftQuantity )

                    local elementIcon = itemWindowName.."IconHolderSquareIcon"
                    Shopkeeper.UpdateItemIcon(merchantId, elementIcon,data)      
                         
                    shopData.LeftWindows[leftIndex] = {name=itemWindowName,itemIndex=index}
                    WindowSetId(itemWindowName,index)
                    WindowSetId(itemWindowName.."BuyMore",Shopkeeper.LEFT_SIDE_ID)
                    WindowSetId(itemWindowName.."BuyLess",Shopkeeper.LEFT_SIDE_ID)
                    WindowSetId(itemWindowName.."BuyAll",Shopkeeper.LEFT_SIDE_ID)                    
                    
                    leftIndex = leftIndex + 1
                end
                if (data.rightQuantity > 0 and data.value > 0) then
                    local itemWindowName = window.."RightItem"..rightIndex
                    CreateWindowFromTemplate( itemWindowName, "ShopItemTemplate", "PurchasedItemsScrollWindowScrollChildCont" )        
                    WindowSetAlpha(itemWindowName .. "BG", 0.5)
                    WindowClearAnchors(itemWindowName)
                    if (rightIndex == 1) then
                        WindowAddAnchor( itemWindowName, "topleft", "PurchasedItemsScrollWindowScrollChildCont", "topleft", 5, 5)        
                    else
                        local prevWindowName = window.."RightItem"..(rightIndex-1)
                        WindowAddAnchor( itemWindowName, "bottomleft", prevWindowName, "topleft", 0, 5)                               
                    end           

                    ButtonSetText(itemWindowName.."BuyMore",L"+")
                    ButtonSetText(itemWindowName.."BuyLess",L"-")
                    ButtonSetText(itemWindowName.."BuyAll",GetStringFromTid(Shopkeeper.TID.Clear))
                    
                    if (data.name ~= nil) then
                        LabelSetText(itemWindowName.."Name",data.name)
                    end
                    LabelSetText(itemWindowName.."Cost",L""..data.value)    
                    LabelSetText(itemWindowName.."Quantity",L""..data.rightQuantity)
                    
                    local elementIcon = itemWindowName.."IconHolderSquareIcon"
                    Shopkeeper.UpdateItemIcon(merchantId,elementIcon,data)      
                                        
                    shopData.RightWindows[rightIndex] = {name=itemWindowName,itemIndex=index}
                    WindowSetId(itemWindowName,index)
                    WindowSetId(itemWindowName.."BuyMore",Shopkeeper.RIGHT_SIDE_ID)
                    WindowSetId(itemWindowName.."BuyLess",Shopkeeper.RIGHT_SIDE_ID)
                    WindowSetId(itemWindowName.."BuyAll",Shopkeeper.RIGHT_SIDE_ID)                    
                    
                    Shopkeeper.currentShop[merchantId].TotalPurchaseCost = Shopkeeper.currentShop[merchantId].TotalPurchaseCost + (data.rightQuantity*data.value)
                    
                    rightIndex = rightIndex + 1                      
                end          
            end
            WindowSetDimensions ("ShopItemsScrollWindowScrollChildCont", 490 , leftIndex * 55)
            WindowSetDimensions ("PurchasedItemsScrollWindowScrollChildCont", 490 , rightIndex * 55)
            ScrollWindowUpdateScrollRect("PurchasedItemsScrollWindow")
            ScrollWindowUpdateScrollRect("ShopItemsScrollWindow")
            
            Shopkeeper.UpdatePlayersGold(merchantId)
        end
        
        Shopkeeper.currentShop[merchantId].RefreshTimer = 0
    end
end

function Shopkeeper.BuyContext()
	ContextMenu.CleanUp()
	for i=1, Organizer.Buys do
		local name = ReplaceTokens(GetStringFromTid(1155437), {towstring( i ) } )
		if (Organizer.Buys_Desc[i] ~= L"") then
			name = Organizer.Buys_Desc[i]
		end
		ContextMenu.CreateLuaContextMenuItem({str = name, returnCode = i, pressed = Organizer.ActiveBuy == i})
	end
	ContextMenu.ActivateLuaContextMenu(Shopkeeper.ContextMenuCallback)
end

function Shopkeeper.ContextMenuCallback( returnCode, param )
	Organizer.ActiveBuy = returnCode
	Interface.SaveSetting( "OrganizerActiveBuy" , Organizer.ActiveBuy )
end

function Shopkeeper.BuyTooltip()

	local name = ReplaceTokens(GetStringFromTid(1155438), {towstring(  Organizer.ActiveBuy ) } )
	if (Organizer.Restocks_Desc[Organizer.ActiveBuy] ~= L"") then
		name = Organizer.Restocks_Desc[Organizer.ActiveBuy]
	end
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(1155264) .. L"\n".. ReplaceTokens(GetStringFromTid(1155265), { name }))
end

function Shopkeeper.OnItemClicked()
	local itemWindow = SystemData.ActiveWindow.name
	local itemWindowParent = WindowGetParent(itemWindow)
	local itemLocalId = WindowGetId(itemWindowParent)
	local merchantWindow = WindowUtils.GetActiveDialog()
	local merchantId = WindowGetId(merchantWindow)
	local itemId = Shopkeeper.currentShop[merchantId].Items[itemLocalId].id
	if (WindowData.Cursor ~= nil and WindowData.Cursor.target == true and slotId ~= 0 )
	then
        HandleSingleLeftClkTarget(itemId)
    end
end

function Shopkeeper.BuyAgent()
    local this = WindowUtils.GetActiveDialog()
    local merchantId = WindowGetId(this)

    
    local sellContainerId = Shopkeeper.currentShop[merchantId].sellContainerId
    local data = WindowData.ContainerWindow[sellContainerId]
    
    if (data == nil) then
        return
    end
    Shopkeeper.CurrentAmountArray = {}
    for i=1,  Organizer.Buys_Items[Organizer.ActiveBuy] do
		local itemL = Organizer.Buy[Organizer.ActiveBuy][i]
		if not Shopkeeper.CurrentAmountArray[itemL.type] then
			Shopkeeper.CurrentAmountArray[itemL.type] = {}
		end
		if not Shopkeeper.CurrentAmountArray[itemL.type][itemL.hue] then
			Shopkeeper.CurrentAmountArray[itemL.type][itemL.hue] = 0
		end
		Shopkeeper.CurrentAmountArray[itemL.type][itemL.hue] = itemL.qta
	end
    
	for i = 1, data.numItems do
	    local item = data.ContainedItems[i]
		local itemData = Interface.GetObjectInfoData(item.objectId)
		if (itemData) then
			if (Organizer.Buy[Organizer.ActiveBuy]) then
				for j=1,  Organizer.Buys_Items[Organizer.ActiveBuy] do
					local itemL = Organizer.Buy[Organizer.ActiveBuy][j]
					if (itemL.type > 0 and itemL.type == itemData.objectType and itemL.hue == itemData.hueId) then
						local itemQ = Shopkeeper.currentShop[merchantId].Items[i]
						local qta = Shopkeeper.CurrentAmountArray[itemL.type][itemL.hue]
						if (qta > 0) then
							if (qta <= itemQ.rightQuantity) then
								qta = qta - itemQ.rightQuantity
							end
							if (qta > itemQ.leftQuantity) then
								qta = itemQ.leftQuantity
							end
							Shopkeeper.CurrentAmountArray[itemL.type][itemL.hue] = Shopkeeper.CurrentAmountArray[itemL.type][itemL.hue] - qta
							
							Shopkeeper.UpdateItemRightQuantity(this, merchantId, i, qta)
						end
					end
				end
			end
		end
	    
	end
end

function Shopkeeper.SellContext()
	ContextMenu.CleanUp()
	for i=1, Organizer.Sells do
		local name = ReplaceTokens(GetStringFromTid(1155439), {towstring( i ) } )
		if (Organizer.Sells_Desc[i] ~= L"") then
			name = Organizer.Sells_Desc[i]
		end
		ContextMenu.CreateLuaContextMenuItem({str = name, returnCode = i, pressed = Organizer.ActiveSell == i})
	end
	ContextMenu.ActivateLuaContextMenu(Shopkeeper.ContextSellMenuCallback)
end

function Shopkeeper.ContextSellMenuCallback( returnCode, param )
	Organizer.ActiveSell = returnCode
	Interface.SaveSetting( "OrganizerActiveSell" , Organizer.ActiveSell )
end

function Shopkeeper.SellTooltip()
	local name = ReplaceTokens(GetStringFromTid(1155440), {towstring( Organizer.ActiveSell ) } )
	if (Organizer.Restocks_Desc[Organizer.ActiveSell] ~= L"") then
		name = Organizer.Restocks_Desc[Organizer.ActiveSell]
	end
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(1155266) .. L"\n".. ReplaceTokens(GetStringFromTid(1155265), { name }))
end


function Shopkeeper.SellAgent()
    local this = WindowUtils.GetActiveDialog()
    local merchantId = WindowGetId(this)

    
    Shopkeeper.CurrentAmountArray = {}

    for i=1,  Organizer.Sells_Items[Organizer.ActiveSell] do
		local itemL = Organizer.Sell[Organizer.ActiveSell][i]
		if not Shopkeeper.CurrentAmountArray[itemL.type] then
			Shopkeeper.CurrentAmountArray[itemL.type] = {}
		end
		if not Shopkeeper.CurrentAmountArray[itemL.type][itemL.hue] then
			Shopkeeper.CurrentAmountArray[itemL.type][itemL.hue] = 0
		end
		Shopkeeper.CurrentAmountArray[itemL.type][itemL.hue] = itemL.qta
		for i = 1, #WindowData.ShopData.Sell.Names do
			local itemQ = Shopkeeper.currentShop[merchantId].Items[i]
			Shopkeeper.CurrentAmountArray[itemL.type][itemL.hue] = Shopkeeper.CurrentAmountArray[itemL.type][itemL.hue] - itemQ.rightQuantity
		end
	end
    
	for i = 1, #WindowData.ShopData.Sell.Names do
		local itemData = Interface.GetObjectInfoData(WindowData.ShopData.Sell.Ids[i])
		if (itemData) then
			if (Organizer.Sell[Organizer.ActiveSell]) then
				for j=1,  Organizer.Sells_Items[Organizer.ActiveSell] do
					local itemL = Organizer.Sell[Organizer.ActiveSell][j]
					if (itemL.type > 0 and itemL.type == itemData.objectType and itemL.hue == itemData.hueId) then
						local itemQ = Shopkeeper.currentShop[merchantId].Items[i]
						local qta = Shopkeeper.CurrentAmountArray[itemL.type][itemL.hue]
						if (qta > 0) then
							if (qta <= itemQ.rightQuantity) then
								qta = qta - itemQ.rightQuantity
							end
							if (qta > itemQ.leftQuantity) then
								qta = itemQ.leftQuantity
							end
							Shopkeeper.CurrentAmountArray[itemL.type][itemL.hue] = Shopkeeper.CurrentAmountArray[itemL.type][itemL.hue] - qta
							
							Shopkeeper.UpdateItemRightQuantity(this, merchantId, i, qta)
						end
					end
				end
			end
		end
	    
	end
end

function Shopkeeper.ItemMouseOver()
	local itemWindow = SystemData.ActiveWindow.name
	local itemWindowParent = WindowGetParent(itemWindow)
	local itemLocalId = WindowGetId(itemWindowParent)

	local merchantWindow = WindowUtils.GetActiveDialog()
	local merchantId = WindowGetId(merchantWindow)
	
	if (Shopkeeper.currentShop[merchantId] ~= nil and Shopkeeper.currentShop[merchantId].Items ~= nil) then
	    local itemId = Shopkeeper.currentShop[merchantId].Items[itemLocalId].id
		
		if itemId then
			local itemData = { windowName = itemWindow,
							   itemId = itemId,
							   itemType = WindowData.ItemProperties.TYPE_ITEM,
							   detail = ItemProperties.DETAIL_LONG }
			ItemProperties.SetActiveItem(itemData)
		end
	end
end



function Shopkeeper.OnBuyOne()
    local this = WindowUtils.GetActiveDialog()
    local merchantId = WindowGetId(this)
    local itemIndex = WindowGetId(WindowGetParent(SystemData.ActiveWindow.name))
    --Debug.Print("Shopkeeper.BuyMore: "..tostring(this)..", "..tostring(merchantId)..", "..tostring(itemIndex))
    Shopkeeper.Buying = {win=this, merch=merchantId, idx=itemIndex}
	if (Shopkeeper.currentShop[merchantId].Items[itemIndex].totalQuantity > 1) then
		
		local rdata = {title=GetStringFromTid(1077826), subtitle=GetStringFromTid(1155269), callfunction=Shopkeeper.BuyHowMuch, id=Shopkeeper.currentShop[merchantId].Items[itemIndex].totalQuantity}
		RenameWindow.Create(rdata)
	else
		Shopkeeper.UpdateItemRightQuantity(Shopkeeper.Buying.win, Shopkeeper.Buying.merch, Shopkeeper.Buying.idx, 1)
		Shopkeeper.Buying = {}
	end
end

function Shopkeeper.BuyHowMuch(j, amt)
	if (type(tonumber(amt)) == "number") then
		amt = tonumber(amt)
		if (amt > j) then
			amt = j
		end
		Shopkeeper.UpdateItemRightQuantity(Shopkeeper.Buying.win, Shopkeeper.Buying.merch, Shopkeeper.Buying.idx, amt)
		Shopkeeper.Buying = {}
	end
end

function Shopkeeper.OnBuyMore()
    local this = WindowUtils.GetActiveDialog()
    local merchantId = WindowGetId(this)
    local itemIndex = WindowGetId(WindowGetParent(SystemData.ActiveWindow.name))
    --Debug.Print("Shopkeeper.BuyMore: "..tostring(this)..", "..tostring(merchantId)..", "..tostring(itemIndex))
    Shopkeeper.UpdateItemRightQuantity(this, merchantId, itemIndex, 1)
    
    Shopkeeper.currentShop[merchantId].IsQuantityUpdating = true
    Shopkeeper.currentShop[merchantId].QuantityUpdate.Amount = 1
    Shopkeeper.currentShop[merchantId].QuantityUpdate.Timer = 0
    Shopkeeper.currentShop[merchantId].QuantityUpdate.ItemIndex = itemIndex
end

function Shopkeeper.OnBuyLess()
    local this = WindowUtils.GetActiveDialog()
    local merchantId = WindowGetId(this)
    local itemIndex = WindowGetId(WindowGetParent(SystemData.ActiveWindow.name))
    --Debug.Print("Shopkeeper.BuyMore: "..tostring(this)..", "..tostring(merchantId)..", "..tostring(itemIndex))
    Shopkeeper.UpdateItemRightQuantity(this, merchantId, itemIndex, -1)

    Shopkeeper.currentShop[merchantId].IsQuantityUpdating = true
    Shopkeeper.currentShop[merchantId].QuantityUpdate.Amount = -1
    Shopkeeper.currentShop[merchantId].QuantityUpdate.Timer = 0
    Shopkeeper.currentShop[merchantId].QuantityUpdate.ItemIndex = itemIndex
end

function Shopkeeper.OnStopUpdating()
    local this = WindowUtils.GetActiveDialog()
    local merchantId = WindowGetId(this)

    Shopkeeper.currentShop[merchantId].IsQuantityUpdating = false
end

function Shopkeeper.OnBuyAll()
    local this = WindowUtils.GetActiveDialog()
    local merchantId = WindowGetId(this)
    local itemIndex = WindowGetId(WindowGetParent(SystemData.ActiveWindow.name))
    local windowSide = WindowGetId(SystemData.ActiveWindow.name)
    --Debug.Print("Shopkeeper.BuyMore: "..tostring(this)..", "..tostring(merchantId)..", "..tostring(itemIndex))
    
    if (Shopkeeper.currentShop[merchantId] ~= nil and
            Shopkeeper.currentShop[merchantId].Items ~= nil and
            Shopkeeper.currentShop[merchantId].Items[itemIndex] ~= nil) then
        local itemData = Shopkeeper.currentShop[merchantId].Items[itemIndex]
        if (itemData.leftQuantity ~= nil and
                itemData.rightQuantity ~= nil) then
            if (windowSide == Shopkeeper.LEFT_SIDE_ID) then
                itemData.leftQuantity = 0
                itemData.rightQuantity = itemData.totalQuantity
            else
                itemData.leftQuantity = itemData.totalQuantity  
                itemData.rightQuantity = 0        
            end
            Shopkeeper.RefreshLists(this, merchantId)
        end
    end    
end

function Shopkeeper.UpdateItemRightQuantity(this, merchantId, itemIndex, amount)
    --Debug.Print("Shopkeeper.BuyMore: "..tostring(this)..", "..tostring(merchantId)..", "..tostring(itemIndex))
    if (Shopkeeper.currentShop[merchantId] ~= nil and
            Shopkeeper.currentShop[merchantId].Items ~= nil and
            Shopkeeper.currentShop[merchantId].Items[itemIndex] ~= nil) then
        local itemData = Shopkeeper.currentShop[merchantId].Items[itemIndex]
        if (itemData.leftQuantity ~= nil and
                itemData.rightQuantity ~= nil and
                (itemData.leftQuantity - amount >= 0) and
                (itemData.rightQuantity + amount >= 0)) then
            itemData.leftQuantity = itemData.leftQuantity - amount
            itemData.rightQuantity = itemData.rightQuantity + amount
            Shopkeeper.RefreshLists(this, merchantId)
        end
    end
end

function Shopkeeper.Shutdown()	
	local this = SystemData.ActiveWindow.name
	local merchantId = WindowGetId(this)
	Shopkeeper.Restart()
    if (Shopkeeper.currentShop[merchantId] ~= nil) then
    	
	    if (Shopkeeper.currentShop[merchantId].IsSelling == false) then
    	    
	        if (Shopkeeper.currentShop[merchantId].Items ~= nil) then
	            for index = 1, #Shopkeeper.currentShop[merchantId].Items do

					local data = Shopkeeper.currentShop[merchantId].Items[index]
	                if (data.registered == true) then
	                    data.registered = false
	                end
	            end
	            
	            Shopkeeper.currentShop[merchantId].Items = nil
	        end
	    end
        
	    if (Shopkeeper.currentShop[merchantId].OfferAccepted == false) then
		    BroadcastEvent(SystemData.Events.SHOP_CANCEL_OFFER)
	    end
	    
	    Shopkeeper.currentShop[merchantId] = nil
	end
	
	if (ItemProperties.GetCurrentWindow() == this) then
		ItemProperties.ClearMouseOverItem()
	end		
	
end
	
function Shopkeeper.UpdatePlayersGold(merchantId)
    if (Shopkeeper.currentShop[merchantId] ~= nil) then
	    Shopkeeper.currentShop[merchantId].PlayerGold = WindowData.PlayerStatus.Gold
	    LabelSetText ("TotalCostVal", L""..Shopkeeper.currentShop[merchantId].TotalPurchaseCost..L"/"..Shopkeeper.currentShop[merchantId].PlayerGold)
	end
end

function Shopkeeper.PurchaseItems()
	local this = WindowUtils.GetActiveDialog()
	local merchantId = WindowGetId(this)
	
	if (Shopkeeper.currentShop[merchantId] ~= nil and
	        Shopkeeper.currentShop[merchantId].Items ~= nil) then
	    local itemList = Shopkeeper.currentShop[merchantId].Items
	    local sellIndex = 1
	    for itemIndex = 1, #itemList do
			local data = itemList[itemIndex]
	        if (data.rightQuantity > 0) then
	            --Debug.Print("Buying: "..tostring(data.id)..", "..tostring(data.value))
		        WindowData.ShopData.OfferIds[sellIndex] = data.id
		        WindowData.ShopData.OfferQuantities[sellIndex] = data.rightQuantity
		        sellIndex = sellIndex + 1
		    end
		end

		Shopkeeper.currentShop[merchantId].OfferAccepted = true
	    BroadcastEvent(SystemData.Events.SHOP_OFFER_ACCEPT)

		-- update the pet dockspot
		Interface.AddTodoList({name = "shopkeeper purchase complete delayed pet update", func = function() MobileBarsDockspot.UpdatePetsCount() end, time = Interface.TimeSinceLogin + 1})
	end
	   
	DestroyWindow(this) 
end

function Shopkeeper.CancelPurchase()
	local this = WindowUtils.GetActiveDialog()
	local merchantId = WindowGetId(this)
	
	if (Shopkeeper.currentShop[merchantId] ~= nil and
	        Shopkeeper.currentShop[merchantId].Items ~= nil) then
	    local itemList = Shopkeeper.currentShop[merchantId].Items
	    for itemIndex = 1, #itemList do
			local data = itemList[itemIndex]
			data.leftQuantity = data.totalQuantity
	        data.rightQuantity = 0
	    end
    
        Shopkeeper.currentShop[merchantId].IsDirty = true
    end	    
end