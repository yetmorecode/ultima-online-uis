----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

UserWaypointWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

UserWaypointWindow.TID = { Okay = 3000093, Cancel=1006045, CreateWaypoint=1079482, EditWaypoint=1079483,
					     Create=1077830, DeleteWaypoint=1079484, SelectAFacet=1079512, Type=1078603,
					     WaypointName=1079514, Coordinates=1079515, X=1112100, Y=1112101,
					     SelectAnIcon=1079519, MissingWaypointNameError=1079520, InvalidRangeCoordError=1079521,
					     Lat=1080540, Long=1080541, ViewWaypoint=1079571, East=1075387, West=1075390,
					     North=1075389, South=1075386}

UserWaypointWindow.Params = nil
UserWaypointWindow.XYcoords = false


UserWaypointWindow.Icons  = 
{
	{ id  = 100022, name = L"Custom"},
	{ id  = 100000, name = L"Danger"},
	{ id  = 100042, name = L"City"},
	{ id  = 100045, name = L"Dungeon"},
	{ id  = 100043, name = L"Bones"},
	{ id  = 100010, name = L"Yellow Dot"},
	{ id  = 100012, name = L"Healer"},
	{ id  = 100053, name = L"Moongate"},
	{ id  = 100018, name = L"Cross Weapons"},
	{ id  = 100059, name = L"Shop"},
	{ id  = 100060, name = L"Shrine"},
	{ id  = 100030, name = L"Flag"},
	{ id  = 100033, name = L"Alchemy"},
	{ id  = 100034, name = L"Baker"},
	{ id  = 100035, name = L"Bank"},
	{ id  = 100036, name = L"Barber"},
	{ id  = 100037, name = L"Bard"},
	{ id  = 100038, name = L"Blacksmith"},
	{ id  = 100039, name = L"Bowyer"},
	{ id  = 100040, name = L"Butcher"},
	{ id  = 100041, name = L"Carpenter"},
	{ id  = 100046, name = L"Fletcher"},
	{ id  = 100047, name = L"Guild"},
	{ id  = 100048, name = L"Healer Shop"},
	{ id  = 100049, name = L"Inn"},
	{ id  = 100050, name = L"Jeweler"},
	{ id  = 100051, name = L"Landmark"},
	{ id  = 100052, name = L"Mage"},
	{ id  = 100054, name = L"Painter"},
	{ id  = 100056, name = L"Provisioner"},
	{ id  = 100057, name = L"Reagents"},
	{ id  = 100058, name = L"Shipwright"},
	{ id  = 100061, name = GetStringFromTid(1154997)},
	{ id  = 100062, name = L"Tailor"},
	{ id  = 100063, name = L"Tavern"},
	{ id  = 100064, name = L"Theater"},
	{ id  = 100065, name = L"Tinker"},
	{ id  = 100083, name = L"Black Pin"},
	{ id  = 100084, name = L"Blue Pin"},
	{ id  = 100085, name = L"Gold Skull Pin"},
	{ id  = 100086, name = L"Green Pin"},
	{ id  = 100087, name = L"Pink Pin"},
	{ id  = 100088, name = L"Purple Pin"},
	{ id  = 100089, name = L"Red Pin"},
	{ id  = 100090, name = L"Yellow Pin"},
	{ id  = 100106, name = L"Boat"},
	{ id  = 100107, name = L"Cemetery"},
	{ id  = 100108, name = L"Customs"},
	{ id  = 100109, name = L"Dock"},
	{ id  = 100110, name = L"Eye"},
	{ id  = 100111, name = L"Gate"},
	{ id  = 100112, name = L"Leather"},
	{ id  = 100113, name = L"Mark"},
	{ id  = 100114, name = L"Party"},
	{ id  = 100115, name = L"Pillar"},
	{ id  = 100116, name = L"Sink"},
	{ id  = 100117, name = L"Stairs"},
	{ id  = 100118, name = L"Target"},
	{ id  = 100119, name = L"Teleporter"},
	{ id  = 100120, name = L"Waves"},
	{ id  = 100121, name = L"X"},
}

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function UserWaypointWindow.IconScaleUp()
    local scale = WindowGetScale("UserWaypointWindowTypeIcon")
    scale = scale + 0.1
    if (scale > 2) then
		scale = 2
	end
    WindowSetScale("UserWaypointWindowTypeIcon", scale)

end

function UserWaypointWindow.ScaleUpOnMouseOver()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1155430))
end

function UserWaypointWindow.IconScaleDown()
    local scale = WindowGetScale("UserWaypointWindowTypeIcon")
    scale = scale - 0.1
    if (scale < 0.2) then
		scale = 0.2
	end
    WindowSetScale("UserWaypointWindowTypeIcon", scale)

end

function UserWaypointWindow.ScaleDownOnMouseOver()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1155431))
end

function UserWaypointWindow.Initialize()
	RegisterWindowData(WindowData.WaypointDisplay.Type,0)

	LabelSetText("UserWaypointWindowNamePrompt", GetStringFromTid(UserWaypointWindow.TID.WaypointName))
	LabelSetText("UserWaypointWindowTypePrompt", GetStringFromTid(UserWaypointWindow.TID.Type))
    LabelSetText("UserWaypointWindowFacetPrompt", GetStringFromTid(UserWaypointWindow.TID.SelectAFacet))
    
	LabelSetText("UserWaypointWindowLatPrompt", GetStringFromTid(UserWaypointWindow.TID.Lat))
	LabelSetText("UserWaypointWindowLongPrompt", GetStringFromTid(UserWaypointWindow.TID.Long))
	
	LabelSetText("UserWaypointWindowXPrompt", GetStringFromTid(UserWaypointWindow.TID.X))
	LabelSetText("UserWaypointWindowYPrompt", GetStringFromTid(UserWaypointWindow.TID.Y))
	
	-- Set up Latitude direction combo box
	ComboBoxAddMenuItem( "UserWaypointWindowLatDirCombo", GetStringFromTid(UserWaypointWindow.TID.North) )
	ComboBoxAddMenuItem( "UserWaypointWindowLatDirCombo", GetStringFromTid(UserWaypointWindow.TID.South) )
	
	-- Set up Longitude direction combo box
	ComboBoxAddMenuItem( "UserWaypointWindowLongDirCombo", GetStringFromTid(UserWaypointWindow.TID.West) )
	ComboBoxAddMenuItem( "UserWaypointWindowLongDirCombo", GetStringFromTid(UserWaypointWindow.TID.East) )
	
	ButtonSetText("UserWaypointWindowOKButton",  GetStringFromTid(UserWaypointWindow.TID.Okay)) 
	ButtonSetText("UserWaypointWindowCancelButton",  GetStringFromTid(UserWaypointWindow.TID.Cancel))

    -- These are not editable yet
--	WindowSetShowing("UserWaypointWindowTypeText",false)
	WindowSetShowing("UserWaypointWindowFacetText",false)
	
	tabIndex = 3
end

function UserWaypointWindow.Shutdown()
	UnregisterWindowData(WindowData.WaypointDisplay.Type,0)
end

function UserWaypointWindow.InitializeCreateWaypointData(params)
	WindowSetScale("UserWaypointWindowTypeIcon", 1)
	-- DEFAULT VALUES FOR NEW CUSTOM WAYPOINTS
	params.type = MapCommon.WaypointCustomType
	
	UserWaypointWindow.Params = params
	
	WindowUtils.SetWindowTitle("UserWaypointWindow", GetStringFromTid(UserWaypointWindow.TID.CreateWaypoint))
	WindowSetShowing("UserWaypointWindowCancelButton", true)
	
	TextEditBoxSetText("UserWaypointWindowNameTextEditBox",L"")
	--LabelSetText("UserWaypointWindowTypeLabel",WindowData.WaypointDisplay.typeNames[params.type])
	--- ICONS
	ComboBoxClearMenuItems("UserWaypointWindowTypeLabel")
	local n = #UserWaypointWindow.Icons
	for i = 1, n do
		ComboBoxAddMenuItem( "UserWaypointWindowTypeLabel", UserWaypointWindow.Icons[i].name )
	end
	WindowSetShowing("UserWaypointWindowTypeScaleUp", true)
	WindowSetShowing("UserWaypointWindowTypeScaleDown", true)
	
	local iconTexture, x, y = GetIconData(100022)
    local iconWidth, iconHeight = UOGetTextureSize("icon"..100022)

    WindowSetDimensions("UserWaypointWindowTypeIcon", iconWidth, iconHeight)
    DynamicImageSetTextureDimensions("UserWaypointWindowTypeIcon", iconWidth, iconHeight)
    DynamicImageSetTexture("UserWaypointWindowTypeIcon", iconTexture, x, y)
    
	ComboBoxSetSelectedMenuItem( "UserWaypointWindowTypeLabel", 1)
	
	
	UserWaypointWindow.XYcoords = false

	UserWaypointWindow.UpdateCoordInfo(params.x, params.y, params.facetId)

	
	WindowSetShowing("UserWaypointWindowNameText",true)
	WindowSetShowing("UserWaypointWindowNameLabel",false)
	
	-- Hide display-only windows
	WindowSetShowing("UserWaypointWindowLatLabel",false)
	WindowSetShowing("UserWaypointWindowLongLabel",false)
	WindowSetShowing("UserWaypointWindowXLabel",false)
	WindowSetShowing("UserWaypointWindowYLabel",false)
	
	-- Show input-related windows
	WindowSetShowing("UserWaypointWindowLatText",true)
	WindowSetShowing("UserWaypointWindowLongText",true)
	WindowSetShowing("UserWaypointWindowXText",true)
	WindowSetShowing("UserWaypointWindowYText",true)
	
	local area = UOGetRadarArea()

	local facet = UOGetRadarFacet()
--Debug.Print("F: " ..facet .. " A: " .. area)
	if (area > 0 and  ((facet == 0 and area ~= MapCommon.sextantFeluccaLostLands) or (facet == 1 and area ~= MapCommon.sextantTrammelLostLands) or facet > 1)) then
		UserWaypointWindow.XYcoords = true
		WindowSetShowing("UserWaypointWindowToggleCoordButton", false)

		-- Show latitude/longitude windows first
		WindowSetShowing("UserWaypointWindowLat",false)
		WindowSetShowing("UserWaypointWindowLong",false)
		WindowSetShowing("UserWaypointWindowX",true)
		WindowSetShowing("UserWaypointWindowY",true)
		
		WindowSetShowing("UserWaypointWindowLatDirCombo",false)
		WindowSetShowing("UserWaypointWindowLongDirCombo",false)
	else
		UserWaypointWindow.XYcoords = false
		WindowSetShowing("UserWaypointWindowToggleCoordButton", true)
		UserWaypointWindow.UpdateCoordInfo(params.x, params.y, params.facetId)
		-- Show latitude/longitude windows first
		WindowSetShowing("UserWaypointWindowLat",true)
		WindowSetShowing("UserWaypointWindowLong",true)
		WindowSetShowing("UserWaypointWindowX",false)
		WindowSetShowing("UserWaypointWindowY",false)

		WindowSetShowing("UserWaypointWindowLatDirCombo",true)
		WindowSetShowing("UserWaypointWindowLongDirCombo",true)
	end
	
    WindowSetShowing("UserWaypointWindow", true)
    WindowAssignFocus("UserWaypointWindowNameTextEditBox", true)	
end

local tabIndex = 3
function UserWaypointWindow.OnKeyTab()

	if (tabIndex < 3) then
		tabIndex = tabIndex +1
	else
		tabIndex = 1
	end
	if (tabIndex == 3) then
		WindowAssignFocus("UserWaypointWindowNameTextEditBox",true)
	elseif (tabIndex == 1) then

		if (not UserWaypointWindow.XYcoords) then
			WindowAssignFocus("UserWaypointWindowLatTextEditBox",true)
		else
			WindowAssignFocus("UserWaypointWindowXTextEditBox",true)
		end
	elseif (tabIndex == 2) then
		if (not UserWaypointWindow.XYcoords) then
			WindowAssignFocus("UserWaypointWindowLongTextEditBox",true)
			
		else
			WindowAssignFocus("UserWaypointWindowYTextEditBox",true)
			
		end
	end
end

function UserWaypointWindow.InitializeViewWaypointData(params)
	WindowSetScale("UserWaypointWindowTypeIcon", 1)
    UserWaypointWindow.Params = params

	WindowUtils.SetWindowTitle("UserWaypointWindow",  GetStringFromTid(UserWaypointWindow.TID.ViewWaypoint))
	
	WindowSetShowing("UserWaypointWindowCancelButton", false)
	
	LabelSetText("UserWaypointWindowNameLabel",params.name)
	--LabelSetText("UserWaypointWindowTypeLabel",WindowData.WaypointDisplay.typeNames[params.type])
	
	--- ICONS
	ComboBoxClearMenuItems("UserWaypointWindowTypeLabel")
	local n = #UserWaypointWindow.Icons
	for i = 1, n do
		ComboBoxAddMenuItem( "UserWaypointWindowTypeLabel", UserWaypointWindow.Icons[i].name )
	end

	local selection = params.type
	--Debug.Print(params.type)
	
	if params.iconId then
		local n = #UserWaypointWindow.Icons
		for i = 1, n do
			if UserWaypointWindow.Icons[i].id == params.iconId then
				selection = i
				break
			end
		end
	elseif (params.type == 11) then
		selection = 11
	elseif (params.type == 10) then
		selection = 4
	elseif (params.type == 9) then
		selection = 3
	elseif (params.type == 12) then
		selection = 8
	elseif (params.type == 7) then
		selection = 2
	elseif (params.type == 2) then
		selection = 9
	end
	ComboBoxSetSelectedMenuItem( "UserWaypointWindowTypeLabel", selection)
	
	
	local iconId = UserWaypointWindow.Icons[selection].id
	if params.iconId then
		iconId = params.iconId
	end
	local iconTexture, x, y = GetIconData(iconId)
    local iconWidth, iconHeight = UOGetTextureSize("icon"..iconId)
    local iconScale = MapCommon.GetWaypointScale(displayMode)
	if params.scale then
		iconScale = params.scale
	end
	WindowSetShowing("UserWaypointWindowTypeScaleUp", false)
	WindowSetShowing("UserWaypointWindowTypeScaleDown", false)
    WindowSetDimensions("UserWaypointWindowTypeIcon", iconWidth* iconScale, iconHeight* iconScale)
    DynamicImageSetTextureDimensions("UserWaypointWindowTypeIcon", iconWidth, iconHeight)
    DynamicImageSetTexture("UserWaypointWindowTypeIcon", iconTexture, x, y)
	
	WindowSetShowing("UserWaypointWindowNameText",false)
	WindowSetShowing("UserWaypointWindowNameLabel",true)
	
	-- Show display-only windows
	WindowSetShowing("UserWaypointWindowLatLabel",true)
	WindowSetShowing("UserWaypointWindowLongLabel",true)
	WindowSetShowing("UserWaypointWindowXLabel",true)
	WindowSetShowing("UserWaypointWindowYLabel",true)
	
	-- Hide input-related windows
	WindowSetShowing("UserWaypointWindowLatText",false)
	WindowSetShowing("UserWaypointWindowLongText",false)
	WindowSetShowing("UserWaypointWindowLatDirCombo",false)
	WindowSetShowing("UserWaypointWindowLongDirCombo",false)
	WindowSetShowing("UserWaypointWindowXText",false)
	WindowSetShowing("UserWaypointWindowYText",false)
	
	local area = UOGetRadarArea()
	if (area > 0 and  ((facet == 0 and area ~= MapCommon.sextantFeluccaLostLands) or (facet == 1 and area ~= MapCommon.sextantTrammelLostLands) or facet > 1)) then
		UserWaypointWindow.XYcoords = true
		WindowSetShowing("UserWaypointWindowToggleCoordButton", false)
		-- Show latitude/longitude windows first
		WindowSetShowing("UserWaypointWindowLat",false)
		WindowSetShowing("UserWaypointWindowLong",false)
		WindowSetShowing("UserWaypointWindowX",true)
		WindowSetShowing("UserWaypointWindowY",true)
		
	else
		UserWaypointWindow.XYcoords = false
		WindowSetShowing("UserWaypointWindowToggleCoordButton", true)
		UserWaypointWindow.UpdateCoordInfo(params.x, params.y, params.facetId)
		-- Show latitude/longitude windows first
		WindowSetShowing("UserWaypointWindowLat",true)
		WindowSetShowing("UserWaypointWindowLong",true)
		WindowSetShowing("UserWaypointWindowX",false)
		WindowSetShowing("UserWaypointWindowY",false)
	end
	
	
	
    WindowSetShowing("UserWaypointWindow", true)	
end

function UserWaypointWindow.ToggleCoord()
	if (UserWaypointWindow.XYcoords == false) then
		-- Show X/Y windows
		WindowSetShowing("UserWaypointWindowLat",false)
		WindowSetShowing("UserWaypointWindowLong",false)
		WindowSetShowing("UserWaypointWindowX",true)
		WindowSetShowing("UserWaypointWindowY",true)
		
		-- If waypoint is being created
		if (UserWaypointWindow.Params.type == MapCommon.WaypointCustomType) then
			-- Retrieve latitude/longitude values
			local area = UOGetRadarArea()
			local latVal = tonumber(TextEditBoxGetText("UserWaypointWindowLatTextEditBox"))

			local longVal = tonumber(TextEditBoxGetText("UserWaypointWindowLongTextEditBox"))
			
			WindowSetTabOrder( "UserWaypointWindowXTextEditBox", 0 )
			WindowSetTabOrder( "UserWaypointWindowYTextEditBox", 0 )
		
			WindowSetTabOrder( "UserWaypointWindowLatTextEditBox", 2 )
			WindowSetTabOrder( "UserWaypointWindowLongTextEditBox", 3 )
		
			local latDir = L"N"
			local longDir = L"W"
			if (ComboBoxGetSelectedMenuItem("UserWaypointWindowLatDirCombo") == 2) then
				latDir = L"S"
			end
			if (ComboBoxGetSelectedMenuItem("UserWaypointWindowLongDirCombo") == 2) then
				longDir = L"E"
			end
			
			-- Convert to latitude/longitude to x/y
			
			UserWaypointWindow.Params.x, UserWaypointWindow.Params.y = MapCommon.ConvertToXYMinutes(latVal, longVal, latDir, longDir, UserWaypointWindow.Params.facetId, area)
			
			-- Update input boxes with new values
			UserWaypointWindow.UpdateCoordInfo(UserWaypointWindow.Params.x, UserWaypointWindow.Params.y, UserWaypointWindow.Params.facetId)
			
			-- Hide N/S and W/E comboboxes
			WindowSetShowing("UserWaypointWindowLatDirCombo",false)
			WindowSetShowing("UserWaypointWindowLongDirCombo",false)
		end
		
		UserWaypointWindow.XYcoords = true
	else
		-- Show Latitude/Longitude windows
		WindowSetShowing("UserWaypointWindowLat",true)
		WindowSetShowing("UserWaypointWindowLong",true)
		WindowSetShowing("UserWaypointWindowX",false)
		WindowSetShowing("UserWaypointWindowY",false)
		
		WindowSetTabOrder( "UserWaypointWindowLatTextEditBox", 0 )
		WindowSetTabOrder( "UserWaypointWindowLongTextEditBox", 0 )
			
		WindowSetTabOrder( "UserWaypointWindowXTextEditBox", 2 )
		WindowSetTabOrder( "UserWaypointWindowYTextEditBox", 3 )
		
		-- If waypoint is being created
		if (UserWaypointWindow.Params.type == MapCommon.WaypointCustomType) then
			-- Retrieve x/y values
			UserWaypointWindow.Params.x = tonumber(TextEditBoxGetText("UserWaypointWindowXTextEditBox"))
			UserWaypointWindow.Params.y = tonumber(TextEditBoxGetText("UserWaypointWindowYTextEditBox"))
			
			-- Update the input boxes with new values
			UserWaypointWindow.UpdateCoordInfo(UserWaypointWindow.Params.x, UserWaypointWindow.Params.y, UserWaypointWindow.Params.facetId)
			
			-- Show N/S and W/E comboboxes
			WindowSetShowing("UserWaypointWindowLatDirCombo",true)
			WindowSetShowing("UserWaypointWindowLongDirCombo",true)
		end
		
		UserWaypointWindow.XYcoords = false
	end
end

function UserWaypointWindow.ToggleCoordMouseOver()
	local buttonName = "UserWaypointWindowToggleCoordButton"
	local text = GetStringFromTid(1112099)
	Tooltips.CreateTextOnlyTooltip(buttonName, text)
end

function UserWaypointWindow.UpdateCoordInfo(x, y, facet)
	local area = UOGetRadarArea()
	LabelSetText("UserWaypointWindowFacetLabel",GetStringFromTid(UORadarGetFacetLabel(facet)) .. L" - " .. GetStringFromTid(UORadarGetAreaLabel(facet, area)))

	local latStr, longStr, latDir, longDir = MapCommon.GetSextantLocationStrings(x, y, facet)
	
	-- If waypoint is being created
	if (UserWaypointWindow.Params.type == MapCommon.WaypointCustomType) then
		TextEditBoxSetText("UserWaypointWindowLatTextEditBox", latStr)
		TextEditBoxSetText("UserWaypointWindowLongTextEditBox", longStr)
		TextEditBoxSetText("UserWaypointWindowXTextEditBox", towstring(string.format("%.0f",x)) )
		TextEditBoxSetText("UserWaypointWindowYTextEditBox", towstring(string.format("%.0f",y)) )
		
		if (latDir == L"N") then
			ComboBoxSetSelectedMenuItem( "UserWaypointWindowLatDirCombo", 1)
		else
			ComboBoxSetSelectedMenuItem( "UserWaypointWindowLatDirCombo", 2)
		end
		
		if (longDir == L"W") then
			ComboBoxSetSelectedMenuItem( "UserWaypointWindowLongDirCombo", 1)
		else
			ComboBoxSetSelectedMenuItem( "UserWaypointWindowLongDirCombo", 2)
		end
	else
		LabelSetText("UserWaypointWindowLatLabel",latStr..L"'"..latDir)
		LabelSetText("UserWaypointWindowLongLabel",longStr..L"'"..longDir)
		LabelSetText("UserWaypointWindowXLabel", towstring(string.format("%.0f",x)) )
		LabelSetText("UserWaypointWindowYLabel", towstring(string.format("%.0f",y)) )
	end
end

function UserWaypointWindow.OnOkay()
	-- If waypoint is being created
	
    if (UserWaypointWindow.Params.type == MapCommon.WaypointCustomType) then
		-- Retrieve waypoint name
        local name = TextEditBoxGetText("UserWaypointWindowNameTextEditBox")
        if (name == L"") then
            return
        end
        local area = 0
        if (UserWaypointWindow.XYcoords == true) then
			-- Retreive x/y coords
			local x = TextEditBoxGetText("UserWaypointWindowXTextEditBox")
			local y = TextEditBoxGetText("UserWaypointWindowYTextEditBox")
			
			if (x == L"" or y == L"") then
				return
			end
			
			UserWaypointWindow.Params.x = tonumber(x)
			UserWaypointWindow.Params.y = tonumber(y)
			area = UOGetRadarArea()
        else
			-- Retrieve latitude/longitude coords
			local latVal = TextEditBoxGetText("UserWaypointWindowLatTextEditBox")
			local longVal = TextEditBoxGetText("UserWaypointWindowLongTextEditBox")
			if (latVal == L"" or longVal == L"") then
				return
			end
			local latDir = L"N"
			local longDir = L"W"
			if (ComboBoxGetSelectedMenuItem("UserWaypointWindowLatDirCombo") == 2) then
				latDir = L"S"
			end
			if (ComboBoxGetSelectedMenuItem("UserWaypointWindowLongDirCombo") == 2) then
				longDir = L"E"
			end
			area = UOGetRadarArea()

			-- Convert to x/y coords
			UserWaypointWindow.Params.x, UserWaypointWindow.Params.y = MapCommon.ConvertToXYMinutes(tonumber(latVal), tonumber(longVal), latDir, longDir, UserWaypointWindow.Params.facetId, area)
        end
        local curSel = ComboBoxGetSelectedMenuItem( "UserWaypointWindowTypeLabel" )

		local iconId = tostring(UserWaypointWindow.Icons[curSel].id)
		local iconScale = WindowGetScale("UserWaypointWindowTypeIcon")
		iconScale = tonumber(string.sub(tostring(iconScale),1 , 4))
		
		local flag
		--local nameAdd = L""
		if (UserWaypointWindow.Params.facetId == 4 and area > 0) then
			--nameAdd = L"_DUNG_"
			flag = "DUNG"
		end
		if (UserWaypointWindow.Params.facetId == 5 and area == 1) then
			--nameAdd = L"_ABYSS_"
			flag = "ABYSS"
		end
		if (UserWaypointWindow.Params.facetId == 5 and (area == 2 or area == 7)) then
			UserWaypointWindow.Params.facetId = 0
		end
		
		UserWaypointWindow.UOCreateUserWaypoint(UserWaypointWindow.Params.type, UserWaypointWindow.Params.x, UserWaypointWindow.Params.y, UserWaypointWindow.Params.facetId, iconId, iconScale, name, flag)
		
        --UOCreateUserWaypoint( UserWaypointWindow.Params.type, UserWaypointWindow.Params.x, UserWaypointWindow.Params.y, UserWaypointWindow.Params.facetId, name .. L"_ICON_" .. iconId .. L"_SCALE_" .. iconScale .. nameAdd )
        MapCommon.ForcedUpdate = true
		MapCommon.UpdateWaypoints(MapCommon.ActiveView)
    end
    
    WindowSetShowing("UserWaypointWindow", false)	
end

function UserWaypointWindow.OnKeyCancel()
	MainMenuWindow.notnow = true
	UserWaypointWindow.OnCancel()
end

function UserWaypointWindow.OnCancel()
    WindowSetShowing("UserWaypointWindow", false)
end

function UserWaypointWindow.OnSelChanged()
	local curSel = ComboBoxGetSelectedMenuItem( "UserWaypointWindowTypeLabel" )

	local iconId = UserWaypointWindow.Icons[curSel].id
	if (type(iconId) == "number") then
		local iconTexture, x, y = GetIconData(iconId)
		local iconWidth, iconHeight = UOGetTextureSize("icon"..iconId)
		WindowSetDimensions("UserWaypointWindowTypeIcon", iconWidth, iconHeight)
		DynamicImageSetTextureDimensions("UserWaypointWindowTypeIcon", iconWidth, iconHeight)
		DynamicImageSetTexture("UserWaypointWindowTypeIcon", iconTexture, x, y)
	else
		local iconWidth, iconHeight = UOGetTextureSize(iconId)
		WindowSetDimensions("UserWaypointWindowTypeIcon", iconWidth, iconHeight)
		DynamicImageSetTextureDimensions("UserWaypointWindowTypeIcon", iconWidth, iconHeight)
		DynamicImageSetTexture("UserWaypointWindowTypeIcon", iconId, 0, 0)
	end
end

function UserWaypointWindow.UOCreateUserWaypoint(type, x, y, facet, icon, scale, name, flag)
	if not CustomWaypoints then
		UserCustomWaypoints = CreateSaveStructureWaypoints(UserCustomWaypoints)
		Interface.InitializeCustomWaypoints()
	end
	
	local wp = {x=x, y=y, z=0, type=type, Name=name, Icon=icon, Scale=scale, flag=flag}
	table.insert(CustomWaypoints.Facet[facet], wp)

	MapCommon.UpdateWaypoints(MapCommon.ActiveView)
end