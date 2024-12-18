----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

VendorConfiguration = { }
VendorConfiguration.Items = {}

--VendorConfiguration.Items[1] = {Name=L"Powder Of Fortifying", Price = L"84000" }
--VendorConfiguration.Items[2] = {Name=L"Shadow Runic Hammer", Price = L"125000" }
--VendorConfiguration.Items[3] = {Name=L"Copper Runic Hammer", Price = L"280000" }

VendorConfiguration.VendorItems = {}
VendorConfiguration.SoldItems = {}
VendorConfiguration.WatchContainers = {}

VendorConfiguration.DiscountItemId = 0
VendorConfiguration.DiscountPercentage = 10
VendorConfiguration.DiscountPrice = 0

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

local editItemIndex = 0

function VendorConfiguration.Shutdown()
	VendorConfiguration.SetDefaultView()
end

-- OnInitialize Handler
function VendorConfiguration.Initialize()
	this = "VendorConfiguration"
	local id = SystemData.DynamicWindowId
	WindowSetId(this, id)
	WindowUtils.SetActiveDialogTitle(L"Grim's Vendor Configuration")

	LabelSetText("VendorConfigurationItemsTitle", L"Items")
	LabelSetText("VendorConfigurationSettingsTitle", L"Global Settings")
	ButtonSetText("VendorConfigurationItemsTab", L"Items")
	ButtonSetText("VendorConfigurationSettingsTab", L"Settings")
	
	VendorConfiguration.Load()
	--VendorConfiguration.LoadVendorItems()
	VendorConfiguration.LoadWatchContainers()

	VendorConfiguration.SetDefaultView()
	VendorConfiguration.ShowItems()

end

function VendorConfiguration.Save()
	-- Can't use any existing libraries because most of them use loadstring() or require other libraries.

	local s = "[Items]"

	for i = 1, #VendorConfiguration.Items do
		local item = VendorConfiguration.Items[i]
		s = s .. "[Item]"
		s = s .. "Name=" .. (tostring(item.Name) or "") .. "||"
		s = s .. "Price=" .. (tostring(item.Price) or "") .. "||"
		s = s .. "Description=" .. (tostring(item.Description) or "")
		s = s .. "[/Item]"
	end
	s = s .. "[/Items]"

	Interface.SaveString( "VendorConfigurationItems", s )

end

function VendorConfiguration.Load()
	Debug.Print("Load Vendor Config ======================================")
	local s = Interface.LoadString("VendorConfigurationItems", nil)

	if(not s) then
		-- Haven't saved any Items yet...
		return
	end
	local t = {}

	for item in string.gmatch(s, "%[Item%].-%[/Item%]") do 
	local itemsub = string.match(item, "%[Item%](.-)%[/Item%]")

		local tempItem = { }

		for prop in string.gmatch(itemsub, "([^||]+)") do
			local k, v = string.match(tostring(prop), "(.*)=(.*)")
			tempItem[k] = v
		end

		table.insert(t, tempItem)
	end

	VendorConfiguration.Items = t
end


function VendorConfiguration.SetDefaultView()
	WindowSetShowing("VendorConfigurationItemContainer", true)
	WindowSetShowing("VendorConfigurationSettingsContainer", false)
	WindowSetShowing("VendorConfigurationSettingsContainer", false)
	WindowSetShowing("VendorConfigurationItemsTabActive", true)
	WindowSetShowing("VendorConfigurationItemsTabInactive", false)
	WindowSetShowing("VendorConfigurationSettingsTabActive", false)
	WindowSetShowing("VendorConfigurationSettingsTabInactive", true)
	editItemIndex = 0
end

function VendorConfiguration.ShowItems()

	for i = 1, 30 do
		if(DoesWindowExist("Item".. i)) then
			WindowSetShowing("Item".. i, false)
		end
	end

	WindowSetShowing("VendorConfigurationItemContainer", true)
	WindowSetShowing("VendorConfigurationSettingsContainer", false)
	WindowSetShowing("VendorConfigurationItemsTabActive", true)
	WindowSetShowing("VendorConfigurationItemsTabInactive", false)
	WindowSetShowing("VendorConfigurationSettingsTabActive", false)
	WindowSetShowing("VendorConfigurationSettingsTabInactive", true)

	for i = 1, #VendorConfiguration.Items do
		
		local item = VendorConfiguration.Items[i]
		if(not DoesWindowExist("Item".. i)) then
			CreateWindowFromTemplate("Item" .. i, "ItemDisplayTemplate", "ItemScrollWindowScrollChild")
			if( i == 1) then
				WindowAddAnchor("Item" .. i, "topleft", "ItemScrollWindowScrollChild", "topleft", 0, 0)
			else
				-- Anchor to the last condition of previous item...
				WindowAddAnchor("Item" .. i, "bottomleft", "Item" .. i - 1, "topleft", 0, 0)
			end

			WindowSetId("Item".. i, i)
			WindowSetId("Item".. i .. "Search", i)
			WindowSetId("Item".. i .. "Edit", i)
			WindowSetId("Item".. i .. "Delete", i)
		end
		
		local grr
		if(item.Description ~= "nil") then
			grr = towstring(item.Description)
		end
		WindowUtils.FitTextToLabel("Item" .. i .. "Name", i .. L") " .. towstring(item.Name), false)
		WindowUtils.FitTextToLabel("Item" .. i .. "Price", StringUtils.FormatNumberWString(towstring(item.Price)), false)
		WindowUtils.FitTextToLabel("Item" .. i .. "Description", towstring(grr), false)

		WindowSetShowing("Item".. i, true)
	end

	ScrollWindowUpdateScrollRect("ItemScrollWindow")

end

function VendorConfiguration.ShowSettings()
	WindowSetShowing("VendorConfigurationItemContainer", false)
	WindowSetShowing("VendorConfigurationSettingsContainer", true)
	WindowSetShowing("VendorConfigurationItemsTabActive", false)
	WindowSetShowing("VendorConfigurationItemsTabInactive", true)
	WindowSetShowing("VendorConfigurationSettingsTabActive", true)
	WindowSetShowing("VendorConfigurationSettingsTabInactive", false)
end


function VendorConfiguration.AddItem()
	RequestTargetInfo()
	WindowRegisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT, "VendorConfiguration.AddItemReceieved")
end

function VendorConfiguration.AddItemReceieved()
	WindowUnregisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT)
	local Id = SystemData.RequestInfo.ObjectId
	
	local itemData = WindowData.ObjectInfo[Id]
	
	local rdata = { title=L"Vendor Price", subtitle=L"Set a Vendor Price for this item type.", callfunction=VendorConfiguration.AddItemComplete, id=itemData.name}
	RenameWindow.Create(rdata)
end

function VendorConfiguration.AddItemComplete(a, b)

	Debug.Print("price set...".. tostring(a) .. ",".. tostring(b))
	local item

	-- check for description...
	local parseprice, parsedesc = string.match(tostring(b), "(%d+)(.*)")
	parsedesc = string.trim(parsedesc)
	Debug.Print(parseprice)
	Debug.Print(parsedesc)

	-- item exists???
	for k, v in pairs(VendorConfiguration.Items) do
		if(tostring(v.Name) == tostring(a)) then
			item = v
		end
	end

	if(item) then
		item.Price = parseprice
		item.Description = parsedesc
	else
		item = { Name = a, Price = parseprice, Description = parsedesc }
		table.insert(VendorConfiguration.Items, item)
	end
	
	VendorConfiguration.Save()
	VendorConfiguration.ShowItems()

end


function VendorConfiguration.EditItem()
	local editItemIndex = WindowGetId(SystemData.ActiveWindow.name)
	local item = VendorConfiguration.Items[editItemIndex]
	local rdata = { title=L"Vendor Price", subtitle=L"Set a Vendor Price for ".. towstring(item.Name), callfunction=VendorConfiguration.AddItemComplete, id=towstring(item.Name), text = towstring(item.Price) .. L" " .. towstring(item.Description)}
	RenameWindow.Create(rdata)
end

function VendorConfiguration.DeleteItem()
	local itemIndex = WindowGetId(SystemData.ActiveWindow.name)
	local item = VendorConfiguration.Items[itemIndex]
	local okayButton = { textTid = UO_StandardDialog.TID_OKAY, callback = function() table.remove(VendorConfiguration.Items, itemIndex) VendorConfiguration.Save() VendorConfiguration.ShowItems() end }
	local cancelButton = { textTid = UO_StandardDialog.TID_CANCEL }
	local DeleteConfirmWindow = 
	{
		windowName = "DeleteItem", 
		title = L"Delete Item", 
		body = L"Are you sure you want to delete item '".. towstring(item.Name) ..L"'?", 
		buttons = { okayButton, cancelButton }
	}
			
	UO_StandardDialog.CreateDialog( DeleteConfirmWindow )
end


function VendorConfiguration.Show()
	WindowSetShowing("VendorConfiguration", true);
end

function VendorConfiguration.SearchItem()
	local itemIndex = WindowGetId(SystemData.ActiveWindow.name)
	local item = VendorConfiguration.Items[itemIndex]
	VendorConfiguration.QuickSearch(item.Name)
end

function VendorConfiguration.QuickSearch(text)
	Debug.Print("Searching.." ..text)
    -- Open ContextMenu to set client waiting for a context menu broadcast
    RequestContextMenu(WindowData.PlayerStatus.PlayerId)
	VendorSearch.QuickSearch = text

    -- Broadcast "vendor search" selected event
    WindowData.ContextMenu.returnCode = 1016
    BroadcastEvent(SystemData.Events.CONTEXT_MENU_SELECTED)
	WindowData.ContextMenu.hideMenu = 1
end

function VendorConfiguration.SearchTarget()
	RequestTargetInfo()
	WindowRegisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT, "VendorConfiguration.SearchTargetReceieved")
end

function VendorConfiguration.SearchTargetReceieved()
	WindowUnregisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT)
	local Id = SystemData.RequestInfo.ObjectId
	
	local itemData = WindowData.ObjectInfo[Id]
	VendorConfiguration.QuickSearch(tostring(itemData.name))
end


function VendorConfiguration.SaveVendorItems()
	-- Can't use any existing libraries because most of them use loadstring() or require other libraries.

	local s = "[VendorItems]"

	for k, v in pairs(VendorConfiguration.VendorItems) do
	Debug.Print("save okokokoko")
		Debug.Print(v)
		local item = v
		s = s .. "[Item]"
		s = s .. "ItemId=" .. (tostring(item.ItemId) or "") .. "||"
		s = s .. "TimeStamp=" .. (tostring(item.TimeStamp) or "") .. "||"
		s = s .. "DatePosted=" .. (tostring(item.DatePosted) or "")
		s = s .. "[/Item]"
	end

	s = s .. "[/VendorItems]"

	Interface.SaveString( "VendorItems", s )

end

function VendorConfiguration.LoadVendorItems()
	Debug.Print("Loading Vendor Items +++++++++++++++++++++++++++++++++++++++++++++++")
	local s = Interface.LoadString("VendorItems", nil)

	if(not s) then
		-- Haven't saved any Items yet...
		return
	end
	local t = {}

	for item in string.gmatch(s, "%[Item%].-%[/Item%]") do 
	local itemsub = string.match(item, "%[Item%](.-)%[/Item%]")

		local tempItem = { }

		for prop in string.gmatch(itemsub, "([^||]+)") do
			local k, v = string.match(tostring(prop), "(.*)=(.*)")
			tempItem[k] = v
		end

		t[tonumber(tempItem.ItemId)] = tempItem
		
	end

	VendorConfiguration.VendorItems = t
end

function VendorConfiguration.ToggleWatchContainer(containerId)

	Debug.Print("Adding Watch for container..." .. tostring(containerId))
	--if(VendorConfiguration.WatchContainers[containerId]) then
		-- Already being watched, remove all data
		--VendorConfiguration.WatchContainers[containerId] = nil

	--else
		-- Start Watching
		VendorConfiguration.WatchContainers[containerId] = {}
		VendorConfiguration.WatchContainers[containerId].Items = {}

		RegisterWindowData(WindowData.ContainerWindow.Type, tonumber(containerId))	
		--Debug.Print(WindowData.ContainerWindow[containerId])

		local items = WindowData.ContainerWindow[containerId].ContainedItems
		Debug.Print(items)

		for key, item in pairs(items) do

			local itemInfo = ItemProperties.GetExtendedInfo(item.objectId, true)
			Debug.Print(itemInfo)
			VendorConfiguration.WatchContainers[containerId].Items[itemInfo.ItemId] = 
			{
				Name = itemInfo.Name,
			 	--ItemId = itemInfo.ItemId,
				DatePosted = Interface.Clock.MM  .. "/" .. Interface.Clock.DD .. "/" .. Interface.Clock.YYYY,
				--Timestamp = Interface.Clock.Timestamp,
				Price = itemInfo.Price
			}
		end

	--end

end


function VendorConfiguration.CheckSales(containerId)

	if(VendorConfiguration.WatchContainers[containerId]) then
		-- Ok, we're watching this, let's see if anything sold!
		for k,v in pairs(VendorConfiguration.WatchContainers[containerId].Items) do
			local data = WindowData.ContainerWindow[containerId]
	
			if not data then
				return
			end

			local exists = false
			if(data.ContainedItems) then
				for k2, v2 in pairs(data.ContainedItems) do
					--Debug.Print("check against...")
					--Debug.Print(v2)
					if(tostring(v.ItemId) == tostring(v2.objectId)) then
						Debug.Print("still have item" .. tostring(v.ItemId))
						exists = true
					end
				end
			end

			if(exists == false) then
				-- Oh snap, I sold something!!!!
				-- Add it to our sales table...
				Debug.Print("sold item" .. tostring(v.ItemId))
				--Debug.Print("Adding item to solditems...")
				--Debug.Print(v)
				table.insert(VendorConfiguration.SoldItems, v)
				-- Remove it from the items table...
				--Debug.Print("Removing ItemId from vendoritems..." ..tostring(v.ItemId))
				if(VendorConfiguration.WatchContainers[containerId].Items[v.ItemId]) then
					VendorConfiguration.WatchContainers[containerId].Items[v.ItemId] = nil
				end
			end


		end
	end

end

function VendorConfiguration.PrintSales()
	for k,v in pairs(VendorConfiguration.SoldItems) do

		Debug.Print(v)
		WindowUtils.ChatPrint(towstring(v.Name) .. L" sold for " .. towstring(v.Price), SystemData.ChatLogFilters.SYSTEM )

	end
end



function VendorConfiguration.SaveWatchContainers()
	-- Can't use any existing libraries because most of them use loadstring() or require other libraries.

	local s = "[WatchContainers]"

	for k,v in pairs(VendorConfiguration.WatchContainers) do
		local container = v
		local items = v.Items
		s = s .. "[Container]"
		s = s .. "ContainerId=" .. tostring(k)
		s = s .. "[Items]"

		for k2,v2 in pairs(items) do
			s = s .. "[Item]"
			s = s .. "ItemId=" .. (tostring(k2) or "") .. "||"
			s = s .. "Name=" .. (tostring(v2.Name) or "") .. "||"
			s = s .. "Price=" .. (tostring(v2.Price) or "") .. "||"
			s = s .. "DatePosted=" .. (tostring(v2.DatePosted) or "")
			s = s .. "[/Item]"
		end

		s = s .. "[/Items]"
		s = s .. "[/Container]"
	end
	s = s .. "[/WatchContainers]"

	Interface.SaveString( "WatchContainers", s )

end

function VendorConfiguration.LoadWatchContainers()
	Debug.Print("Load Watch Containers ======================================")
	local s = Interface.LoadString("WatchContainers", nil)

	if(not s) then
		-- Haven't saved any Items yet...
		return
	end
	local t = {}

	for item in string.gmatch(s, "%[Container%].-%[/Container%]") do 
	local containersplit = string.match(item, "%[Container%](.-)%[Items%]")
	local itemsplit = string.match(item, "%[Item%](.-)%[/Item%]")

		local containerId
		local tempContainer = { }
		
		for prop in string.gmatch(containersplit, "([^||]+)") do
			local k, v = string.match(tostring(prop), "(.*)=(.*)")
			containerId = v
		end

		t[containerId] = {}
		t[containerId].Items = {}
		

		local itemId
		local tempItem = {}
		for prop in string.gmatch(itemsplit, "([^||]+)") do
			local k, v = string.match(tostring(prop), "(.*)=(.*)")
			if(k == "ItemId") then
				itemId = v
				t[containerId].Items[itemId] = {}
				continue
			end

			tempItem[k] = v
		end

		t[containerId].Items[itemId] = tempItem

	end

	VendorConfiguration.WatchContainers = t

end


function Debug.ReducePrice(percentage)
	RequestTargetInfo()
	if(percentage and tonumber(percentage) ~= nil) then
		VendorConfiguration.DiscountPercentage = percentage
	else
		VendorConfiguration.DiscountPercentage = 10
	end
	WindowRegisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT, "Debug.ReducePriceReceived")
end

function Debug.ReducePriceReceived(objectId)
	WindowUnregisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT)
	local Id = SystemData.RequestInfo.ObjectId
	local itemInfo = ItemProperties.GetExtendedInfo(Id, true)
	--Debug.Print(itemInfo)

	local price = itemInfo.Price
	price = string.gsub(price, ",", "")
	price = tonumber(price)
	--Debug.Print(price)

	VendorConfiguration.DiscountItemId = Id
	VendorConfiguration.DiscountPrice = price * (1 - (VendorConfiguration.DiscountPercentage / 100))

	local OrganizeBag = ContainerWindow.PlayerBackpack
	ContainerWindow.TimePassedSincePickUp = 0
	ContainerWindow.CanPickUp = false
	MoveItemToContainer(Id, 0, OrganizeBag)
	-- Delay the move back so we don't get the 'you must wait...'
	local td = {func = function() MoveItemToContainer(Id, 0, itemInfo.ContainerId) end, time = Interface.TimeSinceLogin + 1.5}
	table.insert(ContainerWindow.TODO, td)
			
end