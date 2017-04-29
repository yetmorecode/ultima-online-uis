local this = {}

TQShopAction = this

this.open = false
this.selected = false
this.bought = false
this.filledContext = false
this.setOrganizer = false
this.filledOrganizer = false
this.timer = 0

this.tailor = nil
this.manager = nil
this.quest = nil

function this.OnStart(manager)
  this.open = false
  this.selected = false
  this.bought = false
  this.filledContext = false
  this.setOrganizer = false
  this.filledOrganizer = false
  this.timer = 0
  
  this.tailor = manager.quest.GetNearestShop()
  this.manager = manager
  this.quest = manager.quest
  
  if not this.quest.HasMissing() then
    -- No items to buy so immediately skip this action
    Debug.PrintToOverhead("All items filled. Skipping shop..")
    manager.AdvanceQuest()
  end
end

function this.OnUpdate(manager, timePassed) 
  this.timer = this.timer + timePassed

  if not this.open and this.timer > 1 then
    this.tailor = manager.quest.GetNearestShop()
    this.RequestShop(this.tailor)
    this.open = true
  end
  
  if this.open and not this.selected and this.timer > 3.5 then
    this.SelectItems()
    this.selected = true
  end
  
  if this.selected and not this.bought and this.timer > 7 then
    this.BuyItems()
    
    this.bought = true
  end
  
  if this.bought and not this.filledContext and this.timer > 9 then 
    this.FillItems()
    
    this.filledContext = true
  end
  
  if this.bought and not this.setOrganizer and this.timer > 10 then
  
    this.FillStackable()
    
    --ContainerWindow.OrganizeParent = Player.BackpackId
    --ContainerWindow.OrganizeBag = manager.quest.GetContainerId()
    --ContainerWindow.Organize = true
    this.setOrganizer = true
  end
  
  if this.setOrganizer and not this.filledOrganizer and this.timer > 11 then
    this.filledOrganizer = true
  end
  
  -- TODO and organizer
  
  if this.filledContext and this.filledOrganizer and this.timer > 12 then
    manager.AdvanceQuest()
  end
end

function this.RequestShop(id)
  this.tailor = id
  Debug.PrintToChat("Requesting shop " .. id)
  
  Mouse.Center(0, -120)
  
  RequestContextMenu(id)
  WindowSetShowing("ContextMenu", false)  
  WindowSetShowing("ContextMenuSubMenu", false) 
  WindowData.ContextMenu.returnCode = 110
  BroadcastEvent(SystemData.Events.CONTEXT_MENU_SELECTED)
end

function this.SelectItems()
  RegisterWindowData(WindowData.PlayerEquipmentSlot.Type, EquipmentData.EQPOS_BACKPACK)
  
  local id = WindowData.PlayerEquipmentSlot[EquipmentData.EQPOS_BACKPACK].objectId
  RegisterWindowData(WindowData.ContainerWindow.Type, id)
    
  local tradeDealProps = nil
  local merchantId = this.tailor
  local data = WindowData.ContainerWindow[id]
  for i=1, data.numItems do
    local item = data.ContainedItems[i]
    RegisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
    
    local prop = ItemProperties.GetObjectProperties(item.objectId, nil, "")
    for propIndex = 1, table.getn(prop) do
      if wstring.find(prop[propIndex], L"TRADE") then
        tradeDealProps = prop
        break
      end
    end
    
    --UnregisterWindowData(WindowData.ObjectInfo.Type, item.objectId)
  end
  
  local wnd = Shopkeeper.LastShopWindow
  local sellContainerId = Shopkeeper[merchantId].sellContainerId
  local sellData = WindowData.ContainerWindow[sellContainerId]
  local missing = false
  
  if tradeDealProps ~= nil then
    for propIndex = 7, table.getn(tradeDealProps)-1 do
      local p = tradeDealProps[propIndex]
      
      local colon = wstring.find(p, L":")
      local slash = wstring.find(p, L"/")
      local name = wstring.sub(p, 1, colon-1)
      local stock = tonumber(wstring.sub(p, colon+1, slash-1))
      local need = tonumber(wstring.sub(p, slash+1))
      name = wstring.gsub(name, L"-", L"")
      
      if stock < need then
        local amount = need - stock
        local missingItem = true
        
        for sellIndex = 1, sellData.numItems do
            local item = sellData.ContainedItems[sellIndex]
          local itemData = WindowData.ObjectInfo[item.objectId]
          local itemName = itemData.name
          itemName = wstring.gsub(itemName, L"-", L"")
          itemName = wstring.gsub(itemName, L"%d+%s", L"")
          
          if itemName == name then
            local itemQ = Shopkeeper[merchantId].Items[sellIndex]
            if amount > itemQ.leftQuantity then
              local bought = itemQ.leftQuantity
              local diff = amount - bought
              itemQ.rightQuantity = itemQ.leftQuantity
              itemQ.leftQuantity = 0
              
                  missingItem = true
                  
                  amount = diff
                  Shopkeeper.RefreshLists(wnd, merchantId)
                elseif amount > 0 then
                  itemQ.leftQuantity = itemQ.leftQuantity - amount 
                  itemQ.rightQuantity = itemQ.rightQuantity + amount
                  missingItem = false
                  amount = 0
                  Shopkeeper.RefreshLists(wnd, merchantId)
                else
                  missingItem = false
            end
          end
        end
        
        if missingItem then
          local msg = L""..amount..L" "..name..L" missing"
          OverheadText.PrintOverheadText(id, 10, msg, SystemData.TextColor)
          Debug.PrintToChat(msg)
          missing = true
        end
      end
    end
    
    if not missing then
      local msg = L"All items filled"
      OverheadText.PrintOverheadText(id, 10, msg, SystemData.TextColor)
      Debug.PrintToChat(msg)
    end
    --Debug.PrintToChat(tradeDealProps[3])
    
    RegisterWindowData(WindowData.PlayerStatus.Type, 0)
    local id = WindowData.PlayerStatus.PlayerId
    UnregisterWindowData(WindowData.PlayerStatus.Type, 0)
    
    Debug.PrintToOverhead(tradeDealProps[3])
  else
    Debug.PrintToChat(L"No trade order found in backpack.")
  end
end

function this.BuyItems()

  local merchantId = this.tailor
  
  if( Shopkeeper[merchantId] ~= nil and
      Shopkeeper[merchantId].Items ~= nil ) then
      local itemList = Shopkeeper[merchantId].Items
      local sellIndex = 1
      for itemIndex, data in ipairs(itemList) do
          if( data.rightQuantity > 0 ) then
              --Debug.Print("Buying: "..tostring(data.id)..", "..tostring(data.value))
            WindowData.ShopData.OfferIds[sellIndex] = data.id
            WindowData.ShopData.OfferQuantities[sellIndex] = data.rightQuantity
            sellIndex = sellIndex + 1
        end
    end

    Shopkeeper[merchantId].OfferAccepted = true
    BroadcastEvent(SystemData.Events.SHOP_OFFER_ACCEPT)
  end
  
  DestroyWindow(Shopkeeper.LastShopWindow)

  --local x,y = WindowGetScreenPosition("PurchaseButton")
  --local w,h = WindowGetDimensions("PurchaseButton")
  
  --Debug.PrintToChat(L""..x..L":"..y..L" - "..w..L":"..h)
  --Mouse.LClick(x + w/2, y + h/2)
end

function this.FillItems()
  local id = TradeQuest.GetContainerId()
  RequestContextMenu(id)
  WindowData.ContextMenu.returnCode = 354
  BroadcastEvent(SystemData.Events.CONTEXT_MENU_SELECTED)
end

function this.FillStackable()
  local dest = TradeQuest.GetContainerId()
  local items = TradeQuest.GetItems()
  
  for i, item in ipairs(items) do
    if item.missing > 0 then
      local type = Item.GetTypeByName(item.name)
      if type ~= nil then
        -- find in backpack
        local id = Item.FindInContainerByType(Player.BackpackId, type)
      
        if id ~= nil then
          Item.MoveToContainer(id, dest, item.missing)
        end
      end
    end
  end
end
