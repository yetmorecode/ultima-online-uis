
----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

BuoyTool = {}

-- itemId, owner, bobs, lastbob
BuoyTool.Items = {}

BuoyTool.Slots = {} 

function BuoyTool.InitializeBuoys()
	BuoyTool.Initialized = true

	if BuoyTool.Buoys == nil then
		return
	end
	
	local shard = UserData.Settings.Login.lastShardSelected
	if BuoyTool.Buoys[shard] == nil then
		return
	end
	
	local user = UserData.Settings.Login.lastUserName

	if BuoyTool.Buoys[shard][user] == nil then
		return
	end
	
	local char = GetPlayerID()
	
	if BuoyTool.Buoys[shard][user][char] == nil then
		return
	end
	
	BuoyTool.Items = BuoyTool.Buoys[user][currShard][playerID]
end

function BuoyTool.Initialize()
	local windowName = "BuoyToolWindow"
	SnapUtils.SnappableWindows[windowName] = true
	WindowUtils.RestoreWindowPosition(windowName)
	
	WindowUtils.LoadScale( windowName )
	
	LabelSetText(windowName .. "Info", GetStringFromTid(261))
end

function BuoyTool.Shutdown()
	WindowUtils.SaveWindowPosition("BuoyToolWindow")
	SnapUtils.SnappableWindows["BuoyToolWindow"] = nil
	BuoyTool.Reset()
	WindowSetShowing("BuoyToolWindow", false)
end

function BuoyTool.Close()
	ItemProperties.ClearMouseOverItem()
	BuoyTool.Reset()
	WindowSetShowing("BuoyToolWindow", false)
	Interface.BuoysWindowVisible = false
	Interface.SaveSetting("BuoysWindowVisible", Interface.BuoysWindowVisible)
end

function BuoyTool.Toggle()
	if (WindowGetShowing("BuoyToolWindow")) then
		BuoyTool.Close()
	else
		WindowSetShowing("BuoyToolWindow", true)
		Interface.BuoysWindowVisible = true
		Interface.SaveSetting("BuoysWindowVisible", Interface.BuoysWindowVisible)
	end
end


function BuoyTool.ClearItemList()
	for i = 1, #BuoyTool.Slots  do
		if DoesWindowExist(BuoyTool.Slots[i]) then
			DestroyWindow(BuoyTool.Slots[i])
		end
	end
	BuoyTool.Slots = {}
end

function BuoyTool.Reset()
	BuoyTool.ClearItemList()
	
	BuoyTool.Items = {}
	
	LabelSetText("BuoyToolWindowTotal", L"" )
	ScrollWindowUpdateScrollRect( "BuoyToolSW" )   	
	local listOffset = ScrollWindowGetOffset("BuoyToolSW")
	local maxOffset = VerticalScrollbarGetMaxScrollPosition("BuoyToolSWScrollbar")
	if (listOffset > maxOffset) then
		listOffset = maxOffset
	end
	
	ScrollWindowSetOffset("BuoyToolSW",listOffset)
end

function BuoyTool.Update(timePassed)
	for itemId, data in pairsByKeys(BuoyTool.Items) do
		if GetDistanceFromPlayer(itemId) < 0 then
			BuoyTool.Items[itemId] = nil
		end
		if data.lastbob == 0 then
			data.lastbob = Interface.Clock.Timestamp
		end
	end
	if BuoyTool.overItem ~= 0 and (BuoyTool.overItem ~= TargetWindow.TargetId or not WindowGetShowing("TargetWindow")) then
		BuoyTool.overItem = 0
	end
	BuoyTool.SortByDistance()
	if WindowGetShowing("BuoyToolWindow") then
		BuoyTool.UpdateList()
	end
end

function BuoyTool.SortByDistance()
	BuoyTool.SortedItems = {}
	for itemId, data in pairsByKeys(BuoyTool.Items) do
		data.itemId = itemId
		table.insert(BuoyTool.SortedItems, data)
	end
	local pos = 1
	while pos <= #BuoyTool.SortedItems do
		if (pos == 1 or GetDistanceFromPlayer(BuoyTool.SortedItems[pos].itemId) >= GetDistanceFromPlayer(BuoyTool.SortedItems[pos-1].itemId)) then
			pos = pos + 1
		else
			local swap = BuoyTool.SortedItems[pos]
			BuoyTool.SortedItems[pos] = BuoyTool.SortedItems[pos-1]
			BuoyTool.SortedItems[pos-1] = swap
			pos = pos - 1
		end
	end
	BuoyTool.TotalItems = #BuoyTool.SortedItems
	
end

function BuoyTool.TargetNearest()
	if BuoyTool.SortedItems[1] then
		HandleSingleLeftClkTarget(BuoyTool.SortedItems[1].itemId)
	end
end

function BuoyTool.UpdateList()
	BuoyTool.ClearItemList()
	
	if BuoyTool.TotalItems > 0 then
		WindowSetShowing("BuoyToolWindowInfo", false)
	else
		WindowSetShowing("BuoyToolWindowInfo", true)
	end
	
	local scale = WindowGetScale("BuoyToolWindow")
	
	local dialog = "BuoyToolSW"
	local parent = dialog.. "ScrollChild"
	local prev
	
	CreateWindowFromTemplate("BuoyToolHeader", "BouyItemTemplate", dialog)
	WindowSetScale("BuoyToolHeader", scale)
	WindowSetHandleInput("BuoyToolHeader", false)
	WindowAddAnchor("BuoyToolHeader", "topleft", dialog, "topleft", 5, -25)
	table.insert(BuoyTool.Slots, "BuoyToolHeader")
	
	LabelSetText("BuoyToolHeader" .. "Name", wstring.upper(GetStringFromTid(1041474))) -- Owner:
	LabelSetFont("BuoyToolHeader" .. "Name", "Arial_Black_Shadow_16", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	LabelSetTextColor("BuoyToolHeader" .. "Name", 255, 255, 0)
	
	LabelSetText("BuoyToolHeader" .. "Distance", wstring.upper(GetStringFromTid(258)))
	LabelSetFont("BuoyToolHeader" .. "Distance", "Arial_Black_Shadow_16", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	LabelSetTextColor("BuoyToolHeader" .. "Distance", 255, 255, 0)
	
	LabelSetText("BuoyToolHeader" .. "Bobs", wstring.upper(GetStringFromTid(259)))
	LabelSetFont("BuoyToolHeader" .. "Bobs", "Arial_Black_Shadow_16", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	LabelSetTextColor("BuoyToolHeader" .. "Bobs", 255, 255, 0)
	
	LabelSetText("BuoyToolHeader" .. "LastBob", wstring.upper(GetStringFromTid(260))) 
	LabelSetFont("BuoyToolHeader" .. "LastBob", "Arial_Black_Shadow_16", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	LabelSetTextColor("BuoyToolHeader" .. "LastBob", 255, 255, 0)
	
	local exist = false
	
	for i = 1, #BuoyTool.SortedItems do
		local data = BuoyTool.SortedItems[i]
		local itemId = data.itemId
		local slotName = "Bouy".. itemId
		
		CreateWindowFromTemplate(slotName, "BouyItemTemplate", parent)
		WindowSetScale(slotName, scale)
		table.insert(BuoyTool.Slots, slotName)
		WindowSetId(slotName,itemId)

		if BuoyTool.overItem ~= 0 and BuoyTool.overItem == itemId then
			exist = true
		end

		local objectType = GetItemType(itemId)
		if not IsValidID(itemId) then
			continue
		end
		EquipmentData.DrawObjectIconAtWindowDimensions(objectType, 0, slotName .. "Icon")
		if i == 1  then
			WindowAddAnchor(slotName, "topleft", parent, "topleft", 0, 5)
		else
			WindowAddAnchor(slotName, "bottomleft", prev, "topleft", 0, 0)
		end
		
		LabelSetText(slotName .. "Distance", towstring(GetDistanceFromPlayer(itemId)))
		
		local params = ItemProperties.GetObjectPropertiesParamsForTid(GetPlayerID(), 1050045, "update bouy")
		local playername
		if params then
			playername = params[2]
		end
		if playername then
			if playername ~= data.owner then
				LabelSetTextColor(slotName .. "Name", 255, 0, 0)
			else
				LabelSetTextColor(slotName .. "Name", 0, 153, 255)
			end
		end
		LabelSetText(slotName .. "Name", data.owner)
		if data.lastbob then
			LabelSetText(slotName .. "Bobs", towstring(data.bobs))
			local time = StringUtils.SecondsToClock(Interface.Clock.Timestamp - data.lastbob, false)
			LabelSetText(slotName .. "LastBob", towstring(time))
		else
			LabelSetText(slotName .. "Bobs", L"0")
		end
		prev = slotName
	end
	
	if not exist then
		BuoyTool.overItem = 0
	end
	
	LabelSetText("BuoyToolWindowTotal", ReplaceTokens(GetStringFromTid(257), {towstring(BuoyTool.TotalItems)}))
	ScrollWindowUpdateScrollRect( "BuoyToolSW" )   	
	local listOffset = ScrollWindowGetOffset("BuoyToolSW")
	local maxOffset = VerticalScrollbarGetMaxScrollPosition("BuoyToolSWScrollbar")
	if (listOffset > maxOffset) then
		listOffset = maxOffset
	end
	
	ScrollWindowSetOffset("BuoyToolSW",listOffset)
end


function BuoyTool.OnItemClicked()
	local this = SystemData.ActiveWindow.name
	local dialog = WindowUtils.GetActiveDialog()
	local objectId = WindowGetId(this)

	if (objectId) then
		HandleSingleLeftClkTarget(objectId)
		BuoyTool.overItem = objectId
		Interface.MobileArrowOver = objectId
	end
end

function BuoyTool.OnItemDblClicked()
	local this = SystemData.ActiveWindow.name
	local dialog = WindowUtils.GetActiveDialog()
	local objectId = WindowGetId(this)

	if (objectId) then
		UserActionUseItem(objectId,false)
	end
end
