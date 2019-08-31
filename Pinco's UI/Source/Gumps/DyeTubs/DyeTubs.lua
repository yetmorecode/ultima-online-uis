----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

DyeTubs = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

DyeTubs.WindowName = "DyeTubs"

DyeTubs.WidthOffset = 60
DyeTubs.WindowWidth = 1030
DyeTubs.WindowHeight = 770

DyeTubs.GumpId = -1

DyeTubs.TubId = 0
DyeTubs.ListType = 0

DyeTubs.colorSelected = false
DyeTubs.initialHue = 0

-- DEFAULT BUTTONS
DyeTubs.OK = 1
DyeTubs.DEFAULT = 2

DyeTubs.Hues = {}
DyeTubs.dimensions = {}

DyeTubs.Elements = {}
DyeTubs.Buttons = {}
DyeTubs.ComboHues = {}
DyeTubs.LoadedHues = {}
DyeTubs.LoadedIds = {}

DyeTubs.CurrentType = 0

DyeTubs.GumpTubType = 0

DyeTubs.SelectedObjType = 0

DyeTubs.VendorHairBeard = 0 -- 0 hair, 1 beard

-----------------------------------------------------
-- TYPES DEFINITION
-----------------------------------------------------
DyeTubs.TubsTypes = {}

DyeTubs.TubsTypes.None = -1

-- Plain Gump
DyeTubs.TubsTypes.Plain = 0
DyeTubs.TubsTypes.Furniture = 1

-- Special Gump (401)
DyeTubs.TubsTypes.Special = 2

-- Leather Gump (402)
DyeTubs.TubsTypes.Leather = 3
DyeTubs.TubsTypes.Runebook = 4
DyeTubs.TubsTypes.Statuette = 5

-- Metallic Gump (999079)
DyeTubs.TubsTypes.Metal = 6
DyeTubs.TubsTypes.MetalLeather = 7
DyeTubs.TubsTypes.MetalCloth = 8

-- Hair Gump (999022)
DyeTubs.TubsTypes.HairDye = 9
DyeTubs.TubsTypes.BrightHairDye = 10

-----------------------------------------------------
-- HUES DEFINITION
-----------------------------------------------------

-- HUE STRUCTURE:
-- [CategoryTID] = {hue1, hue2, .. hueN}

-- Plain DYE TUB
DyeTubs.Hues[0] = {}

-- SPECIAL DYE TUB
DyeTubs.Hues[401] = {
	[1018345] = { 1230, 1231, 1232, 1233, 1234, 1235 },
	[1018346] = { 1501, 1502, 1503, 1504, 1505, 1506, 1507, 1508 },
	[1018347] = { 2012, 2013, 2014, 2015, 2016, 2017 },
	[1018348] = { 1303, 1304, 1305, 1306, 1307, 1308 },
	[1018349] = { 1420, 1421, 1422, 1423, 1424, 1425, 1426 },
	[1018350] = { 1619, 1620, 1621, 1622, 1623, 1624, 1625, 1626 },
	[1018351] = { 1640, 1641, 1642, 1643, 1644 },
	[1018352] = { 2001, 2002, 2003, 2004, 2005 },
}

-- LEATHER DYE TUB
DyeTubs.Hues[402] = {
	[1018332] = { 2419, 2420, 2421, 2422, 2423, 2424 },
	[1018333] = { 2406, 2407, 2408, 2409, 2410, 2411, 2412 },
	[1018334] = { 2413, 2414, 2415, 2416, 2417, 2418 },
	[1018335] = { 2414, 2415, 2416, 2417, 2418 },
	[1018336] = { 2213, 2214, 2215, 2216, 2217, 2218 },
	[1018337] = { 2425, 2426, 2427, 2428, 2429, 2430 },
	[1018338] = { 2207, 2208, 2209, 2210, 2211, 2212 },
	[1018339] = { 2219, 2220, 2221, 2222, 2223, 2224 },
	[1018340] = { 2113, 2114, 2115, 2116, 2117, 2118 },
	[1018341] = { 2119, 2120, 2121, 2122, 2123, 2124 },
	[1018342] = { 2126, 2127, 2128, 2129, 2130 },
	[1018343] = { 2213, 2214, 2215, 2216, 2217, 2218 },
}

-- METALLIC DYE TUB 
DyeTubs.Hues[999079] = {
	[1] = {2501, 2502, 2503, 2504, 2505, 2506, 2507, 2508, 2509, 2510, 2511, 2512, },
	[2] = {2514, 2515, 2516, 2517, 2518, 2519, 2520, 2521, 2522, 2523, 2524, 2525, },
	[3] = {2526, 2527, 2528, 2529, 2530, 2531, 2532, 2533, 2534, 2535, 2536, 2537, },
	[4] = {2538, 2539, 2540, 2541, 2542, 2543, 2544, 2545, 2546, 2547, 2548, 2549, },
	[5] = {2550, 2551, 2552, 2553, 2554, 2555, 2556, 2557, 2558, 2559, 2560, 2561, },
	[6] = {2562, 2563, 2564, 2565, 2566, 2567, 2568, 2569, 2570, 2571, 2572, 2573, },
	[7] = {2574, 2575, 2576, 2577, 2578, 2579, 2580, 2581, 2582, 2583, 2584, 2585, },
	[8] = {2586, 2587, 2588, 2589, 2590, 2591, 2592, 2593, 2594, 2595, 2596, 2597, },
	[9] = {2598, 2599, 2600, 2601, 2602, 2603, 2604, 2605, 2606, 2607, 2608, 2609, },
	[10] = {2610, 2611, 2612, 2613, 2614, 2615, 2616, 2617, 2618, 2619, 2620, 2621, },
	[11] = {2622, 2623, 2624, 2625, 2626, 2627, 2628, 2629, 2630, 2631, 2632, 2633, },
	[12] = {2634, 2635, 2636, 2637, 2638, 2639, 2640, 2641, 2642, 2643, 2644, 2645, },
	[13] = {2652, 2653, 2654, 2655, 2656, 2657, 2658, 2659, 2660, 2661, 2662, 2663, },
}

-- HAIR/BEARD DYE
DyeTubs.Hues[999022] = {
	[1] = 	{1602, 26},
	[2] = 	{1628, 27},
	[3] = 	{1502, 32},
	[4] = 	{1302, 32},
	[5] = 	{1402, 32},
	[6] = 	{1202, 24},
	[7] = 	{2402, 29},
	[8] = 	{2213, 6},
	[9] = 	{1102, 8},
	[10] = 	{1110, 8},
	[11] = 	{1118, 16},
	[12] = 	{1134, 16},
}

-- BRIGHT HAIR/BEARD DYE
DyeTubs.Hues[999038] = {
	[1] = 	{12, 10},
	[2] = 	{32, 5},
	[3] = 	{38, 8},
	[4] = 	{54, 3},
	[5] = 	{62, 10},
	[6] = 	{81, 2},
	[7] = 	{89, 2},
	[8] = 	{1153, 2},
}

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function DyeTubs.InitializeTubs()
	DyeTubs.Initialized = true
	DyeTubs.SavedColors = LoadSaveStructureAccountOnly(DyeTubs.SavedColorsFile)
end

function DyeTubs.Initialize()
	ButtonSetText(DyeTubs.WindowName .. "Ok", GetStringFromTid(3000093)) -- L"Ok"
	ButtonSetText(DyeTubs.WindowName .. "Default", GetStringFromTid(3000094)) -- Default
	ButtonSetText(DyeTubs.WindowName .. "PickColorTarget", GetStringFromTid(28)) -- Target Color
	ButtonSetText(DyeTubs.WindowName .. "SaveSelected", GetStringFromTid(3000187)) -- Save
	ButtonSetText(DyeTubs.WindowName .. "DeleteSelected", GetStringFromTid(3000408)) -- Delete
	
	LabelSetText(DyeTubs.WindowName .. "KnownLabel", GetStringFromTid(26))
	LabelSetText(DyeTubs.WindowName .. "SavedLabel", GetStringFromTid(27))
	LabelSetText(DyeTubs.WindowName .. "SelectedLabel", GetStringFromTid(30))
		
	-- creating the base dye tub hues array
	for bright = 1, 5 do
		local i = 0
		for row = 1, 10 do
			for cols = 1, 20 do
				i = i + 1
				local hue = ((i-1)*5)+bright + 1
				table.insert(DyeTubs.Hues[0], hue)
			end
		end
	end
end

function DyeTubs.Hide()
	DyeTubs.GumpId = 0
	WindowSetShowing(DyeTubs.WindowName, false)
end

function DyeTubs.OnUpdate(timePassed)
	if WindowGetShowing(DyeTubs.WindowName) and DyeTubs.GumpId ~= 0 and (not GumpData.Gumps[DyeTubs.GumpId] or not DoesWindowExist(GumpData.Gumps[DyeTubs.GumpId].windowName)) then
		DyeTubs.Hide()
	end
	
	local it = ComboBoxGetSelectedMenuItem( DyeTubs.WindowName .. "SavedCombo" )
	if it > 0 then
		WindowSetShowing(DyeTubs.WindowName .. "SaveSelected", false)
		WindowSetShowing(DyeTubs.WindowName .. "DeleteSelected", true)
	else
		WindowSetShowing(DyeTubs.WindowName .. "SaveSelected", true)
		WindowSetShowing(DyeTubs.WindowName .. "DeleteSelected", false)
	end
	
end

function DyeTubs.OnHidden()
	DyeTubs.ClearWindow()
	WindowUtils.SaveWindowPosition(DyeTubs.WindowName)

	if DyeTubs.GumpId ~= 0 then
		GenericGumpOnRClicked(WindowGetId(GumpData.Gumps[DyeTubs.GumpId].windowName)) 
	end
	
	if DoesWindowExist("HuePicker" .. DyeTubs.TubId) then
		if not DyeTubs.colorSelected then
			HuePickerColorSelected(DyeTubs.TubId, DyeTubs.ListType, DyeTubs.initialHue)
		end
		
		DestroyWindow("HuePicker" .. DyeTubs.TubId)
	end
end

function DyeTubs.Shutdown()
	DyeTubs.ClearWindow()
	SnapUtils.SnappableWindows[DyeTubs.WindowName] = nil
	WindowUtils.SaveWindowPosition(DyeTubs.WindowName)
	WindowSetShowing(DyeTubs.WindowName,false)
	if DyeTubs.GumpId ~= 0 and GumpData and GumpData.Gumps[DyeTubs.GumpId] then
		GenericGumpOnRClicked(WindowGetId(GumpData.Gumps[DyeTubs.GumpId].windowName)) 
	end

	if DoesWindowExist("HuePicker" .. DyeTubs.TubId) then
		if not DyeTubs.colorSelected then
			HuePickerColorSelected(DyeTubs.TubId, DyeTubs.ListType, DyeTubs.initialHue)
		end
		DestroyWindow("HuePicker" .. DyeTubs.TubId)
	end
	
end

function DyeTubs.OnShown()
	WindowUtils.RestoreWindowPosition(DyeTubs.WindowName,false)
end

function DyeTubs.LoadSavedColors()
	-- SAVED COLORS STRUCTURE
	-- id ( 0 - N ) = {hue=HueID, name=CustomWstringName}
	if not DyeTubs.SavedColors then
		return
	end
	ComboBoxClearMenuItems( DyeTubs.WindowName .. "SavedCombo" )
	DyeTubs.LoadedHues = {}
	DyeTubs.LoadedIds = {}
	for id, arr in pairsByKeys(DyeTubs.SavedColors) do
		if arr and DyeTubs.DetermineDyeTub(arr.hue) == DyeTubs.GumpTubType then
			ComboBoxAddMenuItem( DyeTubs.WindowName .. "SavedCombo", arr.name )
			table.insert(DyeTubs.LoadedHues, arr.hue)
			table.insert(DyeTubs.LoadedIds, id)
		end
	end
	WindowSetShowing(DyeTubs.WindowName .. "SavedCombo", #DyeTubs.LoadedHues > 0)
	WindowSetShowing(DyeTubs.WindowName .. "SavedLabel", #DyeTubs.LoadedHues > 0)
end

function DyeTubs.LoadCompatibleColors() -- colors from the hues data compatible with this dye tub
	ComboBoxClearMenuItems( DyeTubs.WindowName .. "KnownCombo" )
	DyeTubs.ComboHues = {}
	for hue, name in pairs(HuesInfo.Data) do
		if DyeTubs.DetermineDyeTub(hue) == DyeTubs.GumpTubType then
			ComboBoxAddMenuItem( DyeTubs.WindowName .. "KnownCombo", name )
			table.insert(DyeTubs.ComboHues, hue)
		end
	end
	WindowSetShowing(DyeTubs.WindowName .. "KnownCombo", #DyeTubs.ComboHues > 0)
	WindowSetShowing(DyeTubs.WindowName .. "KnownLabel", #DyeTubs.ComboHues > 0)
end

function DyeTubs.UpdateComboSelection(hue)
	for i = 1, #DyeTubs.LoadedHues do
		if DyeTubs.LoadedHues[i] == hue then
			ComboBoxSetSelectedMenuItem(DyeTubs.WindowName .. "KnownCombo", 0)
			ComboBoxSetSelectedMenuItem(DyeTubs.WindowName .. "SavedCombo", i)
			return
		end
	end
	
	for i = 1, #DyeTubs.ComboHues do
		if DyeTubs.ComboHues[i] == hue then
			ComboBoxSetSelectedMenuItem(DyeTubs.WindowName .. "SavedCombo", 0)
			ComboBoxSetSelectedMenuItem(DyeTubs.WindowName .. "KnownCombo", i)
			return
		end
	end
end


function DyeTubs.PickColorTarget()
	local windowName = SystemData.ActiveWindow.name
	RequestTargetInfo(DyeTubs.RequestTargetInfoReceived)
end

function DyeTubs.RequestTargetInfoReceived(objectId)
	local windowName = SystemData.ActiveWindow.name
	
    if IsValidID(objectId) then 
		local hueId = GetItemHue(objectId)
		local tubs = DyeTubs.DetermineDyeTub(hueId)
		if tubs[DyeTubs.GumpTubType] then
			DyeTubs.ClearAllChecks()
			for i = 1, #DyeTubs.Buttons do
				if DoesWindowExist(DyeTubs.Buttons[i].button) then
					if DyeTubs.Buttons[i].hue == hueId then
						ButtonSetPressedFlag( DyeTubs.Buttons[i].button .. "Button",  true )
						DyeTubs.UpdateChecked(DyeTubs.Buttons[i].button .. "Button")
						local id = WindowGetId(DyeTubs.Buttons[i].button)
						if DyeTubs.GumpId ~= 0 then
							GumpsParsing.TickButton(DyeTubs.GumpId, id)
						end
						DyeTubs.UpdateComboSelection(hueId)
						break
					end
				end
			end
		else
			SendOverheadText(GetStringFromTid(29), OverheadText.CustomMessageHues.RED)
		end
    end
end


function DyeTubs.ChangeType()
	local windowName = SystemData.ActiveWindow.name
	RequestTargetInfo(DyeTubs.RequestTypeTargetInfoReceived)
	SendOverheadText(GetStringFromTid(32), OverheadText.CustomMessageHues.RED)
end

function DyeTubs.RequestTypeTargetInfoReceived(objectId)
	local windowName = SystemData.ActiveWindow.name
	
    if IsValidID(objectId) then 
		local objectType = GetItemType(objectId)
		if IsValidID(objectType) then
			DyeTubs.SelectedObjType = objectType

			local hue = DyeTubs.GetPickedHue()
			EquipmentData.DrawObjectIcon(DyeTubs.SelectedObjType, hue, DyeTubs.WindowName .. "SelectedIcon", 60, 60, 1)
			WindowSetId(DyeTubs.WindowName .. "SelectedIcon", hue)
			DyeTubs.SetSelectedHueInfo(hue)
		end
    end
end

function DyeTubs.UpdateChecked(button)
	local id = WindowGetId(WindowGetParent(button))
	if id ~= 0 or string.find(button, "TargetedColor", 1, true) then
		if DyeTubs.GumpId ~= 0 then
			GumpsParsing.TickButton(DyeTubs.GumpId, id)
		end
		ButtonSetPressedFlag( WindowGetParent(button) .. "Button",  true )
		
		ComboBoxSetSelectedMenuItem(DyeTubs.WindowName .. "KnownCombo", 0)
		ComboBoxSetSelectedMenuItem(DyeTubs.WindowName .. "SavedCombo", 0)
			
		local hue = DyeTubs.GetPickedHue()
		EquipmentData.DrawObjectIcon(DyeTubs.SelectedObjType, hue, DyeTubs.WindowName .. "SelectedIcon", 60, 60, 1)
		WindowSetId(DyeTubs.WindowName .. "SelectedIcon", hue)
		DyeTubs.SetSelectedHueInfo(hue)
		DyeTubs.UpdateComboSelection(hue)
	end
end

function DyeTubs.CheckItem()
	local button = SystemData.ActiveWindow.name
	
	DyeTubs.ClearAllChecks()
	
	local id = WindowGetId(WindowGetParent(button))
	if id ~= 0 or string.find(button, "TargetedColor", 1, true) then
		if DyeTubs.GumpId ~= 0 then
			GumpsParsing.TickButton(DyeTubs.GumpId, id)
		end
		ButtonSetPressedFlag( WindowGetParent(button) .. "Button",  true )
		
		ComboBoxSetSelectedMenuItem(DyeTubs.WindowName .. "KnownCombo", 0)
		ComboBoxSetSelectedMenuItem(DyeTubs.WindowName .. "SavedCombo", 0)
			
		local hue = DyeTubs.GetPickedHue()
		EquipmentData.DrawObjectIcon(DyeTubs.SelectedObjType, hue, DyeTubs.WindowName .. "SelectedIcon", 60, 60, 1)
		WindowSetId(DyeTubs.WindowName .. "SelectedIcon", hue)
		DyeTubs.SetSelectedHueInfo(hue)
		DyeTubs.UpdateComboSelection(hue)
	end
end

function DyeTubs.ClearAllChecks()
	for i = 1, #DyeTubs.Buttons do
		
		if DoesWindowExist(DyeTubs.Buttons[i].button) then
			local id = WindowGetId(DyeTubs.Buttons[i].button)
			if DyeTubs.GumpId ~= 0 then
				GumpsParsing.UnTickButton(DyeTubs.GumpId, id)
			end
			ButtonSetPressedFlag( DyeTubs.Buttons[i].button .. "Button",  false )
		end
	end
end

function DyeTubs.GetPickedHue()
	for i = 1, #DyeTubs.Buttons do
		if DoesWindowExist(DyeTubs.Buttons[i].button) then
			local id = WindowGetId(DyeTubs.Buttons[i].button)
			if ButtonGetPressedFlag( DyeTubs.Buttons[i].button .. "Button") then
				return DyeTubs.Buttons[i].hue
			end
		end
	end
	return DyeTubs.initialHue
end

function DyeTubs.SetSelectedHueInfo(hue)
	local hueR,hueG,hueB = HueRGBAValue(hue)
	
	local text = ReplaceTokens(GetStringFromTid(1155185), { towstring(hue) }) .. L"<br>" .. L"R:"..hueR..L" G:".. hueG .. L" B:" .. hueB
	if (HuesInfo.Data[hue]) then
		text = text .. L"<br>" .. ReplaceTokens(GetStringFromTid(1155186), { HuesInfo.Data[hue] })
	end
	LabelSetText(DyeTubs.WindowName .. "InfoLabel", text)
end

function DyeTubs.SaveSetting()
	local rdata = {title=GetStringFromTid(34), subtitle=GetStringFromTid(33), callfunction=DyeTubs.CompleteSaveColor, maxChars=256}
	RenameWindow.Create(rdata)
end

function DyeTubs.CompleteSaveColor(_, name)
	if not DyeTubs.SavedColors then
		DyeTubs.SavedColorsFile = CreateSaveStructureAccountOnly(DyeTubs.SavedColorsFile)
		DyeTubs.InitializeTubs()
	end
	local hue = DyeTubs.GetPickedHue()
	table.insert(DyeTubs.SavedColors, {hue=hue, name=name})
	DyeTubs.LoadSavedColors()
	DyeTubs.UpdateComboSelection(hue)
end

function DyeTubs.DeleteColor()
	local it = ComboBoxGetSelectedMenuItem( DyeTubs.WindowName .. "SavedCombo" )
	if it > 0 then
		local id = DyeTubs.LoadedIds[it]
		
		local okButton = { textTid=UO_StandardDialog.TID_OKAY , callback=function() table.remove(DyeTubs.SavedColors, id) DyeTubs.LoadSavedColors() end }
		local cancelButton = { textTid=UO_StandardDialog.TID_CANCEL}

		local DestroyConfirmWindow = 
		{
			windowName = "DelColor",
			titleTid = 35,
			body = ReplaceTokens(GetStringFromTid(36), {ComboBoxGetSelectedText(DyeTubs.WindowName .. "SavedCombo" )}),
			buttons = { okButton, cancelButton },
			closeCallback = cancelButton.callback,
			destroyDuplicate = true,
		}
		UO_StandardDialog.CreateDialog(DestroyConfirmWindow)
	end
end

function DyeTubs.KnownColorChanged()
	ComboBoxSetSelectedMenuItem( DyeTubs.WindowName .. "SavedCombo", 0 )
	local it = ComboBoxGetSelectedMenuItem( DyeTubs.WindowName .. "KnownCombo" )
	if it > 0 then
		DyeTubs.ClearAllChecks()
		
		local hue = DyeTubs.ComboHues[it]

		for i = 1, #DyeTubs.Buttons do
			if DoesWindowExist(DyeTubs.Buttons[i].button) then
				if DyeTubs.Buttons[i].hue == hue then
					ButtonSetPressedFlag( DyeTubs.Buttons[i].button .. "Button",  true )
					local id = WindowGetId(DyeTubs.Buttons[i].button)
					if DyeTubs.GumpId ~= 0 then
						GumpsParsing.TickButton(DyeTubs.GumpId, id)
					end
					ComboBoxSetSelectedMenuItem(DyeTubs.WindowName .. "KnownCombo", 0)
					ComboBoxSetSelectedMenuItem(DyeTubs.WindowName .. "SavedCombo", 0)
					DyeTubs.UpdateComboSelection(hue)
					break
				end
			end
		end
		
		EquipmentData.DrawObjectIcon(DyeTubs.SelectedObjType, hue, DyeTubs.WindowName .. "SelectedIcon", 60, 60, 1)
		WindowSetId(DyeTubs.WindowName .. "SelectedIcon", hue)
		DyeTubs.SetSelectedHueInfo(hue)
		
	end
end

function DyeTubs.SaveColorChanged()
	ComboBoxSetSelectedMenuItem( DyeTubs.WindowName .. "KnownCombo", 0 )
	local it = ComboBoxGetSelectedMenuItem( DyeTubs.WindowName .. "SavedCombo" )
	if it > 0 then
		DyeTubs.ClearAllChecks()
		
		local hue = DyeTubs.LoadedHues[it]

		for i = 1, #DyeTubs.Buttons do
			if DoesWindowExist(DyeTubs.Buttons[i].button) then
				if DyeTubs.Buttons[i].hue == hue then
					ButtonSetPressedFlag( DyeTubs.Buttons[i].button .. "Button",  true )
					local id = WindowGetId(DyeTubs.Buttons[i].button)
					if DyeTubs.GumpId ~= 0 then
						GumpsParsing.TickButton(DyeTubs.GumpId, id)
					end
					ComboBoxSetSelectedMenuItem(DyeTubs.WindowName .. "KnownCombo", 0)
					ComboBoxSetSelectedMenuItem(DyeTubs.WindowName .. "SavedCombo", 0)
					DyeTubs.UpdateComboSelection(hue)
					break
				end
			end
		end
		
		EquipmentData.DrawObjectIcon(DyeTubs.SelectedObjType, hue, DyeTubs.WindowName .. "SelectedIcon", 60, 60, 1)
		WindowSetId(DyeTubs.WindowName .. "SelectedIcon", hue)
		DyeTubs.SetSelectedHueInfo(hue)
		
	end
end

function DyeTubs.ClearWindow()
	for i = 1, #DyeTubs.Elements do
		if DoesWindowExist(DyeTubs.Elements[i]) then
			DestroyWindow(DyeTubs.Elements[i])
		end
	end
	DyeTubs.Elements = {}
	DyeTubs.Buttons = {}
end

function DyeTubs.DetermineDyeTub(hue)
	local tubs = {}
	tubs[DyeTubs.TubsTypes.None] = true
	-- plain
	for i = 1, #DyeTubs.Hues[0] do
		if DyeTubs.Hues[0][i] == hue then
			tubs[DyeTubs.TubsTypes.Plain] = true
			break
		end
	end
	
	-- special
	for _, hues in pairs(DyeTubs.Hues[401]) do
		for i = 1, #hues do
			if hues[i] == hue then
				tubs[DyeTubs.TubsTypes.Special] = true
				break
			end
		end
	end
	
	-- leather
	for _, hues in pairs(DyeTubs.Hues[402]) do
		for i = 1, #hues do
			if hues[i] == hue then
				tubs[DyeTubs.TubsTypes.Leather] = true
				break
			end
		end
	end
	
	-- metallic
	for _, hues in pairs(DyeTubs.Hues[999079]) do
		for i = 1, #hues do
			if hues[i] == hue then
				tubs[DyeTubs.TubsTypes.Metal] = true
				break
			end
		end
	end
	
	-- hair
	for page = 1, #DyeTubs.Hues[999022] do
		local huestart = DyeTubs.Hues[999022][page][1]
		local hueend = DyeTubs.Hues[999022][page][2]
		for i = huestart, huestart + hueend do
			if i == hue then
				tubs[DyeTubs.TubsTypes.HairDye] = true
				break
			end
		end
	end
	
	-- bright hair
	for page = 1, #DyeTubs.Hues[999038] do
		local huestart = DyeTubs.Hues[999038][page][1]
		local hueend = DyeTubs.Hues[999038][page][2]
		for i = huestart, huestart + hueend do
			if i == hue then
				tubs[DyeTubs.TubsTypes.BrightHairDye] = true
				break
			end
		end
	end
	
	return tubs
end

function DyeTubs.DyeTubsParsing(gumpID)
	if not gumpID then
		gumpID = 0
	end
	
	DyeTubs.colorSelected = false

	DyeTubs.GumpId = gumpID
	
	if #DyeTubs.Elements > 0 then
		DyeTubs.ClearWindow()
	end
	
	local tubName = 0
	
	if WindowData.HuePicker and WindowData.HuePicker.ObjectId ~= 0 and gumpID == 0 then
		DyeTubs.TubId = WindowData.HuePicker.ObjectId
		DyeTubs.ListType = WindowData.HuePicker.ListType
	elseif gumpID == 999022 or gumpID == 999037 or gumpID == 999039 or gumpID == 999040 then -- vendor hair dye
		DyeTubs.TubId = 0
		DyeTubs.initialHue = 0
		tubName = 1041060
	elseif gumpID == 999038 or gumpID == 999041 or gumpID == 999042 then -- vendor bright hair dye
		DyeTubs.TubId = 0
		DyeTubs.initialHue = 0
		tubName = 38
	else
		DyeTubs.TubId = Interface.LastTarget
	end
	
	if DyeTubs.TubId ~= 0 then
		local hueId = GetItemHue(DyeTubs.TubId)
		DyeTubs.initialHue = hueId
		
		tubName = ItemProperties.GetObjectPropertiesTid( DyeTubs.TubId, 1, "Dye Tubs Gump" )
	end

	DyeTubs.CurrentType = DyeTubs.TubsTypes.None
	
	--Debug.Print(tubName)
	--Debug.Print(GetStringFromTid(tubName))

	if tubName == 1024011 or tubName == 1024009 or tubName == 1050045 then -- plain/dyes
		DyeTubs.CurrentType = DyeTubs.TubsTypes.Plain
		DyeTubs.GumpTubType = DyeTubs.TubsTypes.Plain
		if tubName == 1050045 and DyeTubs.VendorHairBeard == 0 then
			tubName = 317
		elseif tubName == 1050045 and DyeTubs.VendorHairBeard == 1 then
			tubName = 318
		end
	elseif tubName == 1041246 then -- furniture
		DyeTubs.CurrentType = DyeTubs.TubsTypes.Furniture
		DyeTubs.GumpTubType = DyeTubs.TubsTypes.Plain
	elseif tubName == 1042971 then -- special ??? ~NOTHING~ ???
		DyeTubs.CurrentType = DyeTubs.TubsTypes.Special
		DyeTubs.GumpTubType = DyeTubs.TubsTypes.Special
		tubName = 1006047
	elseif tubName == 1041284 then -- leather
		DyeTubs.CurrentType = DyeTubs.TubsTypes.Leather
		DyeTubs.GumpTubType = DyeTubs.TubsTypes.Leather
	elseif tubName == 1049740 then -- runebook
		DyeTubs.CurrentType = DyeTubs.TubsTypes.Runebook
		DyeTubs.GumpTubType = DyeTubs.TubsTypes.Leather
	elseif tubName == 1049741 then -- statuette
		DyeTubs.CurrentType = DyeTubs.TubsTypes.Statuette
		DyeTubs.GumpTubType = DyeTubs.TubsTypes.Leather
	elseif tubName == 1150067 then -- metallic
		DyeTubs.CurrentType = DyeTubs.TubsTypes.Metal
		DyeTubs.GumpTubType = DyeTubs.TubsTypes.Metal
	elseif tubName == 1153495 then -- metallic leather
		DyeTubs.CurrentType = DyeTubs.TubsTypes.MetalLeather
		DyeTubs.GumpTubType = DyeTubs.TubsTypes.Metal
	elseif tubName == 1152920 then -- metallic cloth
		DyeTubs.CurrentType = DyeTubs.TubsTypes.MetalCloth
		DyeTubs.GumpTubType = DyeTubs.TubsTypes.Metal
	elseif tubName == 1152920 then -- metallic cloth
		DyeTubs.CurrentType = DyeTubs.TubsTypes.MetalCloth
		DyeTubs.GumpTubType = DyeTubs.TubsTypes.Metal
	elseif tubName == 1041060 then -- hair dye
		DyeTubs.CurrentType = DyeTubs.TubsTypes.HairDye
		DyeTubs.GumpTubType = DyeTubs.TubsTypes.HairDye

		local equipData = Interface.GetPlayerEquipmentData(EquipmentData.EQPOS_HAIR)
		if equipData then
			local hairs = equipData.objectId
			local hueId = GetItemHue(hairs)

			DyeTubs.initialHue = hueId
		end
		
	elseif tubName == 38 then -- bright hair dye
		DyeTubs.CurrentType = DyeTubs.TubsTypes.BrightHairDye
		DyeTubs.GumpTubType = DyeTubs.TubsTypes.BrightHairDye
		local equipData = Interface.GetPlayerEquipmentData(EquipmentData.EQPOS_HAIR)
		if equipData then
			local hairs = equipData.objectId
			local hueId = GetItemHue(hairs)

			DyeTubs.initialHue = hueId
		end
	end
	
	DyeTubs.LoadCompatibleColors()
	
	DyeTubs.LoadSavedColors()
	if gumpID == 999039 then -- hair only
		tubName = 39
	elseif gumpID == 999040 then -- beard only
		DyeTubs.initialHue = 0

		local equipData = Interface.GetPlayerEquipmentData(EquipmentData.EQPOS_FACIALHAIR)
		if equipData then
			local hairs = equipData.objectId
			local hueId = GetItemHue(hairs)

			DyeTubs.initialHue = hueId
		end
		tubName = 31
	elseif gumpID == 999041 then -- bright hair only
		tubName = 40
	elseif gumpID == 999042 then -- bright beard only
		DyeTubs.initialHue = 0
		
		local equipData = Interface.GetPlayerEquipmentData(EquipmentData.EQPOS_FACIALHAIR)
		if equipData then
			local hairs = equipData.objectId
			local hueId = GetItemHue(hairs)

			DyeTubs.initialHue = hueId
		end
	
		tubName = 41
	end
	
	if tubName < 500000 then
		WindowUtils.SetWindowTitle(DyeTubs.WindowName,GetStringFromTid(tubName)) 
	else
		WindowUtils.SetWindowTitle(DyeTubs.WindowName,GetStringFromTid(tubName)) 
	end
	local gumpIdOverride = DyeTubs.GumpId
	
	if DyeTubs.GumpId == 0 then
		local hueIdStart = 10
		local prevCat
		
		local objType = 7939 -- robe (default)
		
		if DyeTubs.CurrentType == DyeTubs.TubsTypes.Plain then
			objType = 7939 -- robe
			DyeTubs.dimensions[0] = {w = 1050, h = 4050 }
		elseif DyeTubs.CurrentType == DyeTubs.TubsTypes.Furniture then
			objType = 2612 -- drawers
			DyeTubs.dimensions[0] = {w = 1050, h = 4050 }
		end
		local catId = 0
		for bright = 1, 5 do
			local i = 0
			
			for row = 1, 10 do
				catId = catId + 1
				local categoryLbl = "Category_" .. catId
				CreateWindowFromTemplate(categoryLbl, "DyeTubs_ItemTitle", "DyeTubsData")
				if not prevCat then 
					WindowAddAnchor(categoryLbl, "topleft", "DyeTubsData", "topleft", 10, 10)
				else
					WindowAddAnchor(categoryLbl, "bottomleft", prevCat, "topleft", 0, 80)
				end
				table.insert(DyeTubs.Elements, categoryLbl)
				prevCat = categoryLbl
				local prevHue
				for cols = 1, 20 do
					i = i + 1
					local hue = ((i-1)*5)+bright + 1
					
					local hueBtn = "Hue_" .. row .. "_" .. hue
					CreateWindowFromTemplate(hueBtn, "DyeTubs_IconCheckButton", "DyeTubsData")
					WindowSetDimensions(hueBtn .. "SquareIcon", 60, 60)
					if not prevHue then
						WindowAddAnchor(hueBtn, "bottomleft", categoryLbl, "topleft", 20, 10)
					else
						WindowAddAnchor(hueBtn, "topright", prevHue, "topleft", 10, 0)
					end
					table.insert(DyeTubs.Elements, hueBtn)
					table.insert(DyeTubs.Buttons, {button=hueBtn, hue=hue})
					
					hueIdStart = hueIdStart + 1
					EquipmentData.DrawObjectIcon(objType, hue, hueBtn .. "SquareIcon", 60, 60)
					WindowSetId(hueBtn, hue)
					ButtonSetCheckButtonFlag( hueBtn .. "Button", true )
					
					prevHue = hueBtn
				end
			end
		end
		DyeTubs.SelectedObjType = objType
	elseif DyeTubs.GumpId == 401 then
		local hueIdStart = 10
		local prevCat
		DyeTubs.dimensions[401] = {w = 600, h = 940 }
		local objType = 7939
		
		for cat, hues in pairsByKeys(DyeTubs.Hues[DyeTubs.GumpId]) do
			local categoryLbl = "Category_" .. cat
			
			CreateWindowFromTemplate(categoryLbl, "DyeTubs_ItemTitle", "DyeTubsData")
			if not prevCat then 
				WindowAddAnchor(categoryLbl, "topleft", "DyeTubsData", "topleft", 10, 10)
			else
				WindowAddAnchor(categoryLbl, "bottomleft", prevCat, "topleft", 0, 100)
			end
			table.insert(DyeTubs.Elements, categoryLbl)
			WindowSetDimensions(categoryLbl, 300, 20)
			LabelSetText(categoryLbl, GetStringFromTid(cat))
			prevCat = categoryLbl
			local prevHue
			for i = 1, #hues do
				local hueBtn = "Hue_" .. cat .. "_" .. hueIdStart
				CreateWindowFromTemplate(hueBtn, "DyeTubs_IconCheckButton", "DyeTubsData")
				WindowSetDimensions(hueBtn .. "SquareIcon", 60, 60)
				if not prevHue then
					WindowAddAnchor(hueBtn, "bottomleft", categoryLbl, "topleft", 20, 10)
				else
					WindowAddAnchor(hueBtn, "topright", prevHue, "topleft", 30, 0)
				end
				table.insert(DyeTubs.Elements, hueBtn)
				table.insert(DyeTubs.Buttons, {button=hueBtn, hue=hues[i]})
				
				hueIdStart = hueIdStart + 1
				EquipmentData.DrawObjectIcon(7939, hues[i], hueBtn .. "SquareIcon", 60, 60)
				WindowSetId(hueBtn, hueIdStart)
				ButtonSetCheckButtonFlag( hueBtn .. "Button", true )
				prevHue = hueBtn
			end
		end
		DyeTubs.SelectedObjType = objType
		
	elseif DyeTubs.GumpId == 402 then
		local hueIdStart = 14
		local prevCat
		
		local objType = 5068 -- leather chest (default)
		
		if DyeTubs.CurrentType == DyeTubs.TubsTypes.Leather then
			objType = 5068 -- leather chest
			DyeTubs.dimensions[402] = {w = 350, h = 1150 }
		elseif DyeTubs.CurrentType == DyeTubs.TubsTypes.Runebook then
			objType = 8901 -- runebook
			DyeTubs.dimensions[402] = {w = 350, h = 1130 }
		elseif DyeTubs.CurrentType == DyeTubs.TubsTypes.Statuette then
			objType = 9678 -- unicorn statuette
			DyeTubs.dimensions[402] = {w = 350, h = 1150 }
		end
		
		
		for cat, hues in pairsByKeys(DyeTubs.Hues[DyeTubs.GumpId]) do
			local categoryLbl = "Category_" .. cat
			CreateWindowFromTemplate(categoryLbl, "DyeTubs_ItemTitle", "DyeTubsData")
			if not prevCat then 
				WindowAddAnchor(categoryLbl, "topleft", "DyeTubsData", "topleft", 10, 10)
			else
				WindowAddAnchor(categoryLbl, "bottomleft", prevCat, "topleft", 0, 80)
			end
			table.insert(DyeTubs.Elements, categoryLbl)
			WindowSetDimensions(categoryLbl, 300, 20)
			LabelSetText(categoryLbl, GetStringFromTid(cat))
			prevCat = categoryLbl
			local prevHue
			for i = 1, #hues do
				local hueBtn = "Hue_" .. cat .. "_" .. hueIdStart
				CreateWindowFromTemplate(hueBtn, "DyeTubs_IconCheckButton", "DyeTubsData")
				WindowSetDimensions(hueBtn .. "SquareIcon", 60, 60)
				if not prevHue then
					WindowAddAnchor(hueBtn, "bottomleft", categoryLbl, "topleft", 20, 10)
				else
					WindowAddAnchor(hueBtn, "topright", prevHue, "topleft", 10, 0)
				end
				table.insert(DyeTubs.Elements, hueBtn)
				table.insert(DyeTubs.Buttons, {button=hueBtn, hue=hues[i]})
				
				hueIdStart = hueIdStart + 1
				EquipmentData.DrawObjectIcon(objType, hues[i], hueBtn .. "SquareIcon", 60, 60)
				WindowSetId(hueBtn, hueIdStart)
				ButtonSetCheckButtonFlag( hueBtn .. "Button", true )
				
				prevHue = hueBtn
			end
		end
		DyeTubs.SelectedObjType = objType
		
	elseif DyeTubs.GumpId == 999079 then
		local hueIdStart = 15
		local prevCat
		
		local objType = 5138 -- plate helm (default)
		local offset = 20 -- offset between buttons
		local imgScale = 1.2 -- picture scale
		
		if DyeTubs.CurrentType == DyeTubs.TubsTypes.Metal then
			objType = 5138 -- plate helm
			offset = 20
			imgScale = 1.2
			DyeTubs.dimensions[999079] = {w = 650, h = 1300 }
		elseif DyeTubs.CurrentType == DyeTubs.TubsTypes.MetalLeather then
			objType = 5068 -- leather chest
			offset = 20
			imgScale = 1
			DyeTubs.dimensions[999079] = {w = 650, h = 1300 }
		elseif DyeTubs.CurrentType == DyeTubs.TubsTypes.MetalCloth then
			objType = 7939 -- robe
			offset = 20
			imgScale = 1
			DyeTubs.dimensions[999079] = {w = 650, h = 1300 }
		end
		
		
		local hue = 2501
		for page = 1, 13 do
			local categoryLbl = "Category_" .. page
			CreateWindowFromTemplate(categoryLbl, "DyeTubs_ItemTitle", "DyeTubsData")
			if not prevCat then 
				WindowAddAnchor(categoryLbl, "topleft", "DyeTubsData", "topleft", 10, 10)
			else
				WindowAddAnchor(categoryLbl, "bottomleft", prevCat, "topleft", 0, 80 + offset)
			end
			table.insert(DyeTubs.Elements, categoryLbl)
			prevCat = categoryLbl
			local prevHue
			if page == 13 then
				hue = hue + 6
			end
			for row = 1, 12 do
				local hueBtn = "Hue_" .. page .. "_" .. row
				CreateWindowFromTemplate(hueBtn, "DyeTubs_IconCheckButton", "DyeTubsData")
				WindowSetDimensions(hueBtn .. "SquareIcon", 60, 60)	
				
				if not prevHue then
					WindowAddAnchor(hueBtn, "bottomleft", categoryLbl, "topleft", 10, 0)
				else

					WindowAddAnchor(hueBtn, "topright", prevHue, "topleft", 10, 0)
				end
				table.insert(DyeTubs.Elements, hueBtn)
				table.insert(DyeTubs.Buttons, {button=hueBtn, hue=hue})
				
				hueIdStart = hueIdStart + 1
				
				EquipmentData.DrawObjectIcon(objType, hue, hueBtn .. "SquareIcon", 60, 60, imgScale)
				WindowSetId(hueBtn, hueIdStart)
				ButtonSetCheckButtonFlag( hueBtn .. "Button", true )
				
				
				prevHue = hueBtn
				hue = hue + 1
			end

		end
		DyeTubs.SelectedObjType = objType
	
	elseif DyeTubs.GumpTubType == DyeTubs.TubsTypes.HairDye then
		gumpIdOverride = 999022
		DyeTubs.dimensions[999022] = {w = 770, h = 2280 }
		local objType = 3597 -- long hairs
		local offset = 0
		local cpr = 16 -- colors per row
		local btn = 14 -- button starting id
		
		local prevCat
		
		for page = 1, #DyeTubs.Hues[999022] do
			local categoryLbl = "Category_" .. page
			CreateWindowFromTemplate(categoryLbl, "DyeTubs_ItemTitle", "DyeTubsData")
			if not prevCat then 
				WindowAddAnchor(categoryLbl, "topleft", "DyeTubsData", "topleft", 0, 10)
			else
				WindowAddAnchor(categoryLbl, "bottomleft", prevCat, "topleft", 0, 30 + offset)
			end
			table.insert(DyeTubs.Elements, categoryLbl)
			local prevHue
			
			local hueIdStart = DyeTubs.Hues[999022][page][1]
			local hueIdEnd = DyeTubs.Hues[999022][page][2] + 1
			local bckcategoryLbl = categoryLbl
			local hues = 1
						
			while hues < hueIdEnd do
				
				for cols = 1, cpr do
					local hueBtn = "Hue_" .. page .. "_" .. hueIdStart
					CreateWindowFromTemplate(hueBtn, "DyeTubs_IconCheckButton", "DyeTubsData")
					WindowSetDimensions(hueBtn .. "SquareIcon", 60, 60)	
					if not prevHue then
						if categoryLbl ~= bckcategoryLbl then
							WindowAddAnchor(hueBtn, "bottomleft", categoryLbl, "topleft", 0, 0)
						else
							WindowAddAnchor(hueBtn, "bottomleft", categoryLbl, "topleft", 0, 0)
						end
						categoryLbl = hueBtn
					else

						WindowAddAnchor(hueBtn, "topright", prevHue, "topleft", 10, 0)
					end
					table.insert(DyeTubs.Elements, hueBtn)
					table.insert(DyeTubs.Buttons, {button=hueBtn, hue=hueIdStart})
					
					EquipmentData.DrawObjectIcon(objType, hueIdStart, hueBtn .. "SquareIcon", 60, 60, imgScale)
					
					WindowSetId(hueBtn, btn)
					ButtonSetCheckButtonFlag( hueBtn .. "Button", true )
					
					prevHue = hueBtn
					btn = btn + 1
					hueIdStart = hueIdStart + 1
					
					hues = hues + 1
					if hues >= hueIdEnd then
						break
					end
				end
				prevHue = nil
			end
			prevCat = categoryLbl
		end
		DyeTubs.SelectedObjType = objType
		
	elseif DyeTubs.GumpTubType == DyeTubs.TubsTypes.BrightHairDye then
		gumpIdOverride = 999038
		DyeTubs.dimensions[999038] = {w = 500, h = 1000 }
		local objType = 3597 -- long hairs
		local offset = 0
		local cpr = 16 -- colors per row
		local btn = 10 -- button starting id
		
		local prevCat
		
		for page = 1, #DyeTubs.Hues[999038] do
			local categoryLbl = "Category_" .. page
			CreateWindowFromTemplate(categoryLbl, "DyeTubs_ItemTitle", "DyeTubsData")
			if not prevCat then 
				WindowAddAnchor(categoryLbl, "topleft", "DyeTubsData", "topleft", 0, 10)
			else
				WindowAddAnchor(categoryLbl, "bottomleft", prevCat, "topleft", 0, 30 + offset)
			end
			table.insert(DyeTubs.Elements, categoryLbl)
			local prevHue
			
			local hueIdStart = DyeTubs.Hues[999038][page][1]
			local hueIdEnd = DyeTubs.Hues[999038][page][2] + 1
			local bckcategoryLbl = categoryLbl
			local hues = 1
						
			while hues < hueIdEnd do
				
				for cols = 1, cpr do
					local hueBtn = "Hue_" .. page .. "_" .. hueIdStart
					CreateWindowFromTemplate(hueBtn, "DyeTubs_IconCheckButton", "DyeTubsData")
					WindowSetDimensions(hueBtn .. "SquareIcon", 60, 60)	
					if not prevHue then
						if categoryLbl ~= bckcategoryLbl then
							WindowAddAnchor(hueBtn, "bottomleft", categoryLbl, "topleft", 0, 0)
						else
							WindowAddAnchor(hueBtn, "bottomleft", categoryLbl, "topleft", 0, 0)
						end
						categoryLbl = hueBtn
					else

						WindowAddAnchor(hueBtn, "topright", prevHue, "topleft", 10, 0)
					end
					table.insert(DyeTubs.Elements, hueBtn)
					table.insert(DyeTubs.Buttons, {button=hueBtn, hue=hueIdStart})
					
					EquipmentData.DrawObjectIcon(objType, hueIdStart, hueBtn .. "SquareIcon", 60, 60, imgScale)
					
					WindowSetId(hueBtn, btn)
					ButtonSetCheckButtonFlag( hueBtn .. "Button", true )
					
					prevHue = hueBtn
					btn = btn + 1
					hueIdStart = hueIdStart + 1
					
					hues = hues + 1
					if hues >= hueIdEnd then
						break
					end
				end
				prevHue = nil
			end
			prevCat = categoryLbl
		end
		DyeTubs.SelectedObjType = objType
	end
	
	EquipmentData.DrawObjectIcon(DyeTubs.SelectedObjType, DyeTubs.initialHue, DyeTubs.WindowName .. "SelectedIcon", 60, 60, 1)
	DyeTubs.SetSelectedHueInfo(DyeTubs.initialHue)
	
	for i = 1, #DyeTubs.Buttons do
		if DoesWindowExist(DyeTubs.Buttons[i].button) then
			if DyeTubs.Buttons[i].hue == DyeTubs.initialHue then
				ButtonSetPressedFlag( DyeTubs.Buttons[i].button .. "Button",  true )
				local id = WindowGetId(DyeTubs.Buttons[i].button)
				if DyeTubs.GumpId ~= 0 then
					GumpsParsing.TickButton(DyeTubs.GumpId, id)
				end
				ComboBoxSetSelectedMenuItem(DyeTubs.WindowName .. "KnownCombo", 0)
				ComboBoxSetSelectedMenuItem(DyeTubs.WindowName .. "SavedCombo", 0)
				DyeTubs.UpdateComboSelection(DyeTubs.initialHue)
				break
			end
		end
	end

	local w = DyeTubs.dimensions[gumpIdOverride].w
	if w < DyeTubs.WindowWidth then
		w = DyeTubs.WindowWidth
	end
	
	WindowSetDimensions("DyeTubsData", DyeTubs.dimensions[gumpIdOverride].w, DyeTubs.dimensions[gumpIdOverride].h)
	WindowSetDimensions("DyeTubsSWScrollChild", w, DyeTubs.dimensions[gumpIdOverride].h)
	
	WindowSetDimensions(DyeTubs.WindowName, w + DyeTubs.WidthOffset, DyeTubs.WindowHeight)

	ScrollWindowSetOffset( "DyeTubsSW", 0 )
	ScrollWindowUpdateScrollRect( "DyeTubsSW" )
		
	WindowSetShowing(DyeTubs.WindowName, true)	
	
	WindowSetScale(DyeTubs.WindowName, 1) -- if the scale doesn't reset, the size will be wrong
	
	WindowSetScale(DyeTubs.WindowName, 0.7)
	WindowUtils.LoadScale( DyeTubs.WindowName )
end


function DyeTubs.OkClick()
	DyeTubs.colorSelected = true
	if DyeTubs.GumpId == 0 then
		local huePicked = DyeTubs.GetPickedHue()
		HuePickerColorSelected(DyeTubs.TubId, DyeTubs.ListType, huePicked)
		DyeTubs.Hide()
	else
		GumpsParsing.PressButton(DyeTubs.GumpId, DyeTubs.OK)
		DyeTubs.GumpId = 0
		DyeTubs.Hide()
	end
end

function DyeTubs.DefaultClick()
	DyeTubs.colorSelected = true
	DyeTubs.ClearAllChecks()
	if DyeTubs.GumpId == 0 then
		HuePickerColorSelected(DyeTubs.TubId, DyeTubs.ListType, 0)
		DyeTubs.Hide()
	else
		GumpsParsing.PressButton(DyeTubs.GumpId, DyeTubs.DEFAULT)
		DyeTubs.GumpId = 0
		DyeTubs.Hide()
	end
end

function DyeTubs.TypeTooltip()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(37))
end