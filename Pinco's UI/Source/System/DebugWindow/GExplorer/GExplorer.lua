
----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

GExplorer = {}

GExplorer.Container = 0
GExplorer.Items = {}
GExplorer.SearchResult = {}
GExplorer.Patterns = {}
GExplorer.TotalItems = 0
GExplorer.MaxItems = 0

GExplorer.ItemData = {}
GExplorer.SubItemData = {}

GExplorer.Slots = {} 
GExplorer.SubSlots = {}
GExplorer.DataSlots = {}
GExplorer.DataSubSlots = {}

GExplorer.Colors = {
	["function"] = {0, 255, 0};
	["table"] = {125, 125, 255};
	["boolean"] = {200, 200, 200};
	["number"] = {200, 125, 70};
	["string"] = {125, 200, 70};
	["wstring"] = {125, 200, 125};
}

function GExplorer.GetColor(type)
	return GExplorer.Colors[type][1], GExplorer.Colors[type][2], GExplorer.Colors[type][3]
end


function GExplorer.Initialize()
	local windowName = "GExplorerWindow"
	SnapUtils.SnappableWindows[windowName] = true
	WindowUtils.RestoreWindowPosition("GExplorerWindow")
end

function GExplorer.Shutdown()
	WindowUtils.SaveWindowPosition("GExplorerWindow")
	SnapUtils.SnappableWindows["GExplorerWindow"] = nil
	GExplorer.Close()
end

function GExplorer.Close()
	ItemProperties.ClearMouseOverItem()
	GExplorer.Reset()
	WindowSetShowing("GExplorerWindow", false)
	ButtonSetPressedFlag( "DebugWindowToggleGExplorerButton", false )
end

function GExplorer.Show()
	GExplorer.Reset()
end

function GExplorer.LoadMainList()
	GExplorer.ItemData = {}
	local i = 0
	local w,h = WindowGetDimensions("GExplorerMainSW")
	w = w - 10
	h = h - 10
	local parent = "GExplorerMainSWScrollChild"
	WindowSetDimensions(parent, w, h)
	
	i = i + 1
	local slotName = "GMainItem" .. i
	CreateWindowFromTemplate(slotName, "GItemTemplate", parent)
	table.insert(GExplorer.Slots, slotName)
	WindowClearAnchors(slotName)
	WindowSetId(slotName,i)
	LabelSetText(slotName, L"Root")
	WindowAddAnchor(slotName, "topleft", parent, "topleft", 0, 5)
	GExplorer.ItemData[i] = {name="Root", table=_G, expanded=false, window=slotName}
	_, h = WindowGetDimensions(slotName)
	WindowSetDimensions(slotName, w-10, h)
			
	for k, v in pairsByKeys(_G) do
	
		if k ~= "_G" and type(v) == "table"  then
			i = i + 1
			local prevSlot = "GMainItem" .. i - 1
			local slotName = "GMainItem" .. i
			CreateWindowFromTemplate(slotName, "GItemTemplate", parent)
			_, h = WindowGetDimensions(slotName)
			WindowSetDimensions(slotName, w-10, h)
			table.insert(GExplorer.Slots, slotName)
			WindowClearAnchors(slotName)
			WindowSetId(slotName,i)
			LabelSetText(slotName, towstring(k))
			WindowAddAnchor(slotName, "bottomleft", prevSlot, "topleft", 0, 0)
			GExplorer.ItemData[i] = {name=k, table=v, expanded=false, window=slotName }
		end
	end
	ScrollWindowUpdateScrollRect( "GExplorerMainSW" ) 
end


function GExplorer.ClearItemList()
	for i, data in pairsByKeys(GExplorer.SubSlots)  do
		for j = 1, #GExplorer.SubSlots[i] do
			local window = GExplorer.SubSlots[i][j]
			if DoesWindowExist(window) then
				DestroyWindow(window)
			end
		end
	end
	GExplorer.SubSlots = {}
	for i = 1, #GExplorer.Slots  do
		if DoesWindowExist(GExplorer.Slots[i]) then
			DestroyWindow(GExplorer.Slots[i])
		end
	end
	GExplorer.Slots = {}

end

function GExplorer.ClearContetList()
	for i = 1, #GExplorer.DataSlots  do
		if DoesWindowExist(GExplorer.DataSlots[i]) then
			DestroyWindow(GExplorer.DataSlots[i])
		end
	end
	GExplorer.DataSlots = {}
	for i = 1, #GExplorer.DataSubSlots  do
		if DoesWindowExist(GExplorer.DataSlots[i]) then
			DestroyWindow(GExplorer.DataSlots[i])
		end
	end
	GExplorer.DataSubSlots = {}
end

function GExplorer.Reset()
	GExplorer.ClearItemList()
	GExplorer.ClearContetList()
	GExplorer.Container = 0
	GExplorer.Items = {}
	GExplorer.SearchResult = {}
	GExplorer.Patterns = {}
	GExplorer.TotalItems = 0
	GExplorer.MaxItems = 0
	GExplorer.ItemData = {}
	GExplorer.CurrentActiveItem = 0
	
	GExplorer.LoadMainList()
	
	ScrollWindowUpdateScrollRect( "GExplorerMainSW" )   	
	local listOffset = ScrollWindowGetOffset("GExplorerMainSW")
	local maxOffset = VerticalScrollbarGetMaxScrollPosition("GExplorerMainSWScrollbar")
	if (listOffset > maxOffset) then
		listOffset = maxOffset
	end
	
	ScrollWindowSetOffset("GExplorerMainSW",listOffset)
end


function GExplorer.OnLButtonUpSearch()
	GExplorer.SearchText(nil, TextEditBoxGetText("GExplorerWindowSearchBox"))
end

function GExplorer.SearchTooltip()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(1154641))
end

function GExplorer.OnLButtonUpSearch()
	GExplorer.SearchText(nil, TextEditBoxGetText("GExplorerWindowSearchBox"))
end

function GExplorer.RemoveFiltersTooltip()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(1154792))
end

function GExplorer.Tooltip()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(3000173))
end

GExplorer.CurrentActiveItem = 0
function GExplorer.OnItemClicked()
	local win = SystemData.ActiveWindow.name
	local itemData
	local idx 
	if string.find(SystemData.ActiveWindow.name, "Sub", 1, true) then
		local j = WindowGetId(win)
		local parentWin = string.gsub(string.gsub(win, "_" .. j .. "$", ""), "Sub", "", 1)
		local i = WindowGetId(parentWin)
		itemData = GExplorer.SubItemData[i][j]
		idx = i
	else
		local i = WindowGetId(win)
		itemData = GExplorer.ItemData[i]
		idx = i
	end
	GExplorer.CurrentActiveItem = idx
	ScrollWindowSetOffset("GExplorerSecondSW",0)
	GExplorer.UpdateDataList()
end

function GExplorer.ReloadDataHover()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, L"Reload the class data.")
end

function GExplorer.UpdateDataList()
	if not GExplorer.CurrentActiveItem or GExplorer.CurrentActiveItem == 0 then
		return
	end
	GExplorer.ClearContetList()
	
	itemData = GExplorer.ItemData[GExplorer.CurrentActiveItem]
	
	local w,h = WindowGetDimensions("GExplorerSecondSW")
	w = w - 10
	h = h - 10
	local parent = "GExplorerSecondSWScrollChild"
	WindowSetDimensions(parent, w, h)
	
	local _, finalH = GExplorer.AddDataLabels(itemData.table, 0, 0, 0)
	
	WindowSetDimensions(parent .. "Content", w, finalH)
	ScrollWindowUpdateScrollRect( "GExplorerSecondSW" ) 
	local listOffset = ScrollWindowGetOffset("GExplorerSecondSW")
	local maxOffset = VerticalScrollbarGetMaxScrollPosition("GExplorerSecondSWScrollbar")
	if (listOffset > maxOffset) then
		listOffset = maxOffset
	end
	
	ScrollWindowSetOffset("GExplorerSecondSW",listOffset)
end

function GExplorer.AddDataLabels(tab, currentIndex, dist, finalH, level)

	local parent = "GExplorerSecondSWScrollChild"
	local w,h = WindowGetDimensions(parent)
	local i = currentIndex
	local prevSlot
	local first = true

	parent = parent .. "Content"

	local valueCount = 0
	if not level then
		level = 0
	end
	level = level + 1
	
	for k, v in pairsByKeys(tab) do
		if type(v) == "function" then
			i = i + 1
			prevSlot = "GSecondaryItem" .. i - 1
			local slotName = "GSecondaryItem" .. i
			CreateWindowFromTemplate(slotName, "GItemTemplate", parent)
			WindowClearAnchors(slotName)
			WindowSetId(slotName,i)
			table.insert(GExplorer.DataSlots, slotName)
			LabelSetText(slotName, wstring.upper(towstring(type(v))) .. L": " .. towstring(k))
			LabelSetTextColor(slotName, GExplorer.GetColor(type(v)))
			
			_, h = WindowGetDimensions(slotName)
			WindowSetDimensions(slotName, w, h)
			finalH = finalH + h
			if i == 1 then
				WindowAddAnchor(slotName, "topleft", parent, "topleft", 0, 10)
			elseif first then
				WindowAddAnchor(slotName, "bottomleft", prevSlot, "topleft", dist, 0)
				dist = 0
				first = false
			else
				WindowAddAnchor(slotName, "bottomleft", prevSlot, "topleft", 0, 0)
				dist = 0
			end
			WindowSetHandleInput(slotName, false)
		end
	end
	
	first = true
	for k, v in pairsByKeys(tab) do
		if type(v) == "boolean" then
			i = i + 1
			prevSlot = "GSecondaryItem" .. i - 1
			local slotName = "GSecondaryItem" .. i
			CreateWindowFromTemplate(slotName, "GItemTemplate", parent)
			WindowClearAnchors(slotName)
			WindowSetId(slotName,i)
			table.insert(GExplorer.DataSlots, slotName)
			LabelSetText(slotName, wstring.upper(towstring(type(v))) .. L": " .. towstring(k) .. L" = " .. towstring(tostring(v)))
			LabelSetTextColor(slotName, GExplorer.GetColor(type(v)))
			
			_, h = WindowGetDimensions(slotName)
			WindowSetDimensions(slotName, w, h)
			finalH = finalH + h
			if i == 1 then
				WindowAddAnchor(slotName, "topleft", parent, "topleft", 0, 10)
			elseif first then
				WindowAddAnchor(slotName, "bottomleft", prevSlot, "topleft", dist, 0)
				dist = 0
				first = false
			else
				WindowAddAnchor(slotName, "bottomleft", prevSlot, "topleft", 0, 0)
				dist = 0
			end
			WindowSetHandleInput(slotName, false)
		end
	end
	
	first = true
	for k, v in pairsByKeys(tab) do
		if type(v) == "number" then
			i = i + 1
			prevSlot = "GSecondaryItem" .. i - 1
			local slotName = "GSecondaryItem" .. i
			CreateWindowFromTemplate(slotName, "GItemTemplate", parent)
			WindowClearAnchors(slotName)
			WindowSetId(slotName,i)
			table.insert(GExplorer.DataSlots, slotName)
			LabelSetText(slotName, wstring.upper(towstring(type(v))) .. L": " .. towstring(k) .. L" = " .. towstring(tostring(v)))
			LabelSetTextColor(slotName, GExplorer.GetColor(type(v)))
			
			_, h = WindowGetDimensions(slotName)
			WindowSetDimensions(slotName, w, h)
			finalH = finalH + h
			if i == 1 then
				WindowAddAnchor(slotName, "topleft", parent, "topleft", 0, 10)
			elseif first then
				WindowAddAnchor(slotName, "bottomleft", prevSlot, "topleft", dist, 0)
				dist = 0
				first = false
			else
				WindowAddAnchor(slotName, "bottomleft", prevSlot, "topleft", 0, 0)
				dist = 0
			end
			WindowSetHandleInput(slotName, false)
		end
	end
	
	first = true
	for k, v in pairsByKeys(tab) do
		if type(v) == "string" then
			i = i + 1
			prevSlot = "GSecondaryItem" .. i - 1
			local slotName = "GSecondaryItem" .. i
			CreateWindowFromTemplate(slotName, "GItemTemplate", parent)
			WindowClearAnchors(slotName)
			WindowSetId(slotName,i)
			table.insert(GExplorer.DataSlots, slotName)
			LabelSetText(slotName, wstring.upper(towstring(type(v))) .. L": " .. towstring(k) .. L" = " .. towstring(v))
			LabelSetTextColor(slotName, GExplorer.GetColor(type(v)))
			
			_, h = WindowGetDimensions(slotName)
			WindowSetDimensions(slotName, w, h)
			finalH = finalH + h
			if i == 1 then
				WindowAddAnchor(slotName, "topleft", parent, "topleft", 0, 10)
			elseif first then
				WindowAddAnchor(slotName, "bottomleft", prevSlot, "topleft", dist, 0)
				dist = 0
				first = false
			else
				WindowAddAnchor(slotName, "bottomleft", prevSlot, "topleft", 0, 0)
				dist = 0
			end
			WindowSetHandleInput(slotName, false)
		end
	end
	
	first = true
	for k, v in pairsByKeys(tab) do
		if type(v) == "wstring" then
			i = i + 1
			prevSlot = "GSecondaryItem" .. i - 1
			local slotName = "GSecondaryItem" .. i
			CreateWindowFromTemplate(slotName, "GItemTemplate", parent)
			
			WindowClearAnchors(slotName)
			WindowSetId(slotName,i)
			table.insert(GExplorer.DataSlots, slotName)
			LabelSetText(slotName, wstring.upper(towstring(type(v))) .. L": " .. towstring(k) .. L" = " .. towstring(v))
			LabelSetTextColor(slotName, GExplorer.GetColor(type(v)))
			
			_, h = WindowGetDimensions(slotName)
			WindowSetDimensions(slotName, w, h)
			finalH = finalH + h
			if i == 1 then
				WindowAddAnchor(slotName, "topleft", parent, "topleft", 0, 10)
			elseif first then
				WindowAddAnchor(slotName, "bottomleft", prevSlot, "topleft", dist, 0)
				dist = 0
				first = false
			else
				WindowAddAnchor(slotName, "bottomleft", prevSlot, "topleft", 0, 0)
				dist = 0
			end
			WindowSetHandleInput(slotName, false)
		end
	end

	if tab ~= _G then
		first = true
		for k, v in pairsByKeys(tab) do
			if type(v) == "table" then
				i = i + 1
				prevSlot = "GSecondaryItem" .. i - 1
				local slotName = "GSecondaryItem" .. i
				CreateWindowFromTemplate(slotName, "GItemTemplate", parent)
				WindowClearAnchors(slotName)
				WindowSetId(slotName,i)
				table.insert(GExplorer.DataSlots, slotName)
				LabelSetText(slotName, wstring.upper(towstring(type(v))) .. L": " .. towstring(k))
				LabelSetTextColor(slotName, GExplorer.GetColor(type(v)))
				
				_, h = WindowGetDimensions(slotName)
				WindowSetDimensions(slotName, w, h)
				finalH = finalH + h
				if i == 1 then
					WindowAddAnchor(slotName, "topleft", parent, "topleft", 0, 10)
				elseif first then
					WindowAddAnchor(slotName, "bottomleft", prevSlot, "topleft", dist, 0)
					dist = 0
					first = false
				else
					WindowAddAnchor(slotName, "bottomleft", prevSlot, "topleft", 0, 0)
					dist = 0
				end
				WindowSetHandleInput(slotName, false)
				if type(v) == "table" then
					i, newh, totalAdd, addLevel = GExplorer.AddDataLabels(v, i, dist + 20, level)
					finalH = finalH + newh
					if addLevel > 0 then
						first = true
						dist = dist - (20 * addLevel)
					end
					level = level - addLevel
				end
			end
		end
	end

	return i, finalH, i - valueCount, level
end