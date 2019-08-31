----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

AtlasWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

AtlasWindow.MinimapWasOpen = false
AtlasWindow.AtlasWasClosed = false

AtlasWindow.NewWaypoint = false
AtlasWindow.EditWaypointId = 0

AtlasWindow.OldTilt = 0
AtlasWindow.OldFilters = ""

AtlasWindow.TmapID = 0
AtlasWindow.TmapName = ""

AtlasWindow.TmapMatchingZoom = 0.133

AtlasWindow.NewWaypointScale = { min = 0.3, max = 2 }

AtlasWindow.OverlayModeButtons = 
{
	"WPFiltertButton",
	"Compass",
	"FacetCombo",
	"AreaCombo",
	"ZoomInButton",
	"ZoomOutButton",
	"OverlayModeInfo",
	"PlayerCoordsText",
	"WPOnPlayerLocButton",
	"CoordsText",
	"Separator",
	"WaypointFinder"
}

AtlasWindow.Sizes = {}
AtlasWindow.Sizes.Default = { w = 850, h = 660, bottomAnchorX = -100, bottomAnchorY = -80 }
AtlasWindow.Sizes.OverlayMode = { w = 470, h = 510, bottomAnchorX = 0, bottomAnchorY = 0 }

AtlasWindow.InSearch = false
AtlasWindow.FoundWP = {}

----------------------------------------------------------------
-- Event Functions
----------------------------------------------------------------

function AtlasWindow.Initialize()

	-- get the atlas window name
	local this = SystemData.ActiveWindow.name

	-- initialize the current facet and area
	AtlasWindow.CurrFacet = WindowData.PlayerLocation.facet or 0
	AtlasWindow.CurrArea = 0

	-- resize the atlas
	WindowSetDimensions(this, AtlasWindow.Sizes.Default.w, AtlasWindow.Sizes.Default.h)

	-- current window background
	local bg = this .. "Bg"

	-- reset the bg anchors
	WindowClearAnchors(bg)

	-- stretch the background properly
	WindowAddAnchor(bg, "topleft", this, "topleft", 0, 0)
	WindowAddAnchor(bg, "bottomright", this, "bottomright", AtlasWindow.Sizes.Default.bottomAnchorX, AtlasWindow.Sizes.Default.bottomAnchorY)

	-- make the separator a bit transparent
	WindowSetAlpha(this .. "Separator", 0.5)
	WindowSetAlpha(this .. "WaypointFinderSeparator", 0.4)

	-- initialize the facet combo (this combo should never be updated again)
	AtlasWindow.UpdateFacetCombo()

	-- set the overlay mode info text
	LabelSetText(this .. "OverlayModeInfo", GetStringFromTid(MapCommon.TID.AtlasOverlayInfo))

	-- hide the overlay mode info text
	WindowSetShowing(this .. "OverlayModeInfo", false)

	-- get the map image dimensions
	local mapWidth, mapHeight = WindowGetDimensions(this .. "Map")

	-- calculate the difference between the tmap texture and the frame
	local scale = 1 - (300 / mapWidth)

	-- calculate the final scale to apply to the image
	local newScale = WindowGetScale(this .. "MapTMapImage") + scale
	
	-- fix the map scale
	WindowSetScale(this .. "MapTMapImage", newScale)

	-- hide the tmap overlay
	WindowSetShowing(this .. "MapTMapImage", false)

	-- waypoint editor area name
	local waypointEditor = this .. "WaypointEditor"

	-- waypoint name label text
	LabelSetText(waypointEditor .. "Name" .. "Label", GetStringFromTid(MapCommon.TID.WaypointName))

	-- map name label
	LabelSetText(waypointEditor .. "Map" .. "Label", GetStringFromTid(MapCommon.TID.SelectAFacet))

	-- icon name
	LabelSetText(waypointEditor .. "Icon" .. "Label", GetStringFromTid(MapCommon.TID.Icon))

	-- clear the icons combo
	ComboBoxClearMenuItems(waypointEditor .. "Icon" .. "Combo")

	-- fill the icons list
	for i = 1, #MapCommon.IconsData do
		ComboBoxAddMenuItem(waypointEditor .. "Icon" .. "Combo", MapCommon.IconsData[i].name)
	end

	-- Latitude/Longitude checkbox label
	LabelSetText(waypointEditor .. "CoordsTypeLatLong" .. "Label", GetStringFromTid(MapCommon.TID.LatLong))

	-- turn the button into a checkbox
	ButtonSetCheckButtonFlag(waypointEditor .. "CoordsTypeLatLong" .. "Button", true)

	-- check this button
	ButtonSetPressedFlag(waypointEditor .. "CoordsTypeLatLong" .. "Button", true)

	-- X/Y checkbox label
	LabelSetText(waypointEditor .. "CoordsTypeXY" .. "Label", GetStringFromTid(MapCommon.TID.XY))

	-- turn the button into a checkbox
	ButtonSetCheckButtonFlag(waypointEditor .. "CoordsTypeXY" .. "Button", true)

	-- uncheck this button
	ButtonSetPressedFlag(waypointEditor .. "CoordsTypeXY" .. "Button", false)

	-- hide the X/Y textboxes
	WindowSetShowing(waypointEditor .. "CoordsXY", false)
	
	-- X name
	LabelSetText(waypointEditor .. "CoordsXYX" .. "Label", GetStringFromTid(MapCommon.TID.X))

	-- Y name
	LabelSetText(waypointEditor .. "CoordsXYY" .. "Label", GetStringFromTid(MapCommon.TID.Y))

	-- show the X/Y textboxes
	WindowSetShowing(waypointEditor .. "CoordsLatLong", true)

	-- Lat name
	LabelSetText(waypointEditor .. "CoordsLatLongLat" .. "Label", GetStringFromTid(MapCommon.TID.Lat))

	-- Long name
	LabelSetText(waypointEditor .. "CoordsLatLongLong" .. "Label", GetStringFromTid(MapCommon.TID.Long))

	-- create/edit button
	ButtonSetText(waypointEditor .. "CreateEdit", GetStringFromTid(MapCommon.TID.CreateWaypointHere))

	-- cancel button
	ButtonSetText(waypointEditor .. "Cancel", wstring.upper(GetStringFromTid(MapCommon.TID.Cancel)))
	
	-- clear the waypoint editor
	AtlasWindow.ClearWaypointEditor()

	-- hide the waypoint editor
	WindowSetShowing(waypointEditor, false)

	-- add the escape callback
	Interface.OnKeyEscapeCallback[this] = function() AtlasWindow.OnKeyEscape() end
end

function AtlasWindow.Shutdown()

	-- remove the escape callback
	Interface.OnKeyEscapeCallback[SystemData.ActiveWindow.name] = nil
end

function AtlasWindow.OnUpdate(timePassed)

	-- get the atlas window name
	local this = SystemData.ActiveWindow.name

	-- get the window screen position
	local windowX, windowY = WindowGetScreenPosition(this .. "MapImage")

	-- calculate the mouse x, y coordinates inside the map window
	local mouseX = SystemData.MousePosition.x - windowX
	local mouseY = SystemData.MousePosition.y - windowY

	-- reset the coordinates text
	LabelSetText(this .. "CoordsText", L"")
	
	-- do we have the mouse coordinates?
    if (mouseX ~= 0 or mouseY ~= 0) then 

		-- get the window scale
		local scale = WindowGetScale(this)

		-- get the x, y coordinates (map coordinates)
		local x, y = UOGetRadarPosToWorld(mouseX / scale, mouseY / scale, false)

		-- get the current facet
		local facet = AtlasWindow.CurrFacet

		-- get the current area
		local area = AtlasWindow.CurrArea	  
		
		-- is the clicked position inside the visible area?
		if UORadarIsLocationInArea(x, y, facet, area) and MapCommon.IsWaypointVisible(this, _, x, y, facet, _) then

			-- initialize the sextant string
			local Sextant

			-- fix the facet for certain areas.
			if (facet == 5 and (area == 2 or area == 7)) then
				facet = 0
			end

			-- are we on trammel or felucca or in the lost lands or any other facet?
			if (facet == 0 and (area == 0 or area == MapCommon.sextantFeluccaLostLands)) or (facet == 1 and (area == 0 or area == MapCommon.sextantTrammelLostLands) or facet > 1) then

				-- calculate latitude and longitude based on the current player position
				local latStr, longStr, latDir, longDir = MapCommon.GetSextantLocationStrings(x, y, facet)

				-- set the string with lat/long and x/y
				Sextant = GetStringFromTid(555) .. L": " .. latStr .. L"'" .. latDir .. L" " .. longStr .. L"'" .. longDir .. L" (" .. x .. L", " .. y .. L")"

			else -- set the string with x/y ONLY
				Sextant = GetStringFromTid(555) .. L": " .. x .. L", " .. y
			end

			-- show the coordinates text
			LabelSetText(this .. "CoordsText", Sextant)
		end
	end
end

function AtlasWindow.OnShown()
	
	-- get the map image dimensions
	local mapTextureWidth, mapTextureHeight = WindowGetDimensions("AtlasWindowMapImage")

	-- set the area size to update for the map
	UORadarSetWindowSize(mapTextureWidth, mapTextureHeight, true, true)

	-- reset the waypoints update timer
	MapCommon.RefreshDelta = 0

	-- update the map (and fix rotation)
	Interface.UpdateMap(true)
end

function AtlasWindow.OnHidden()

	-- remove the waypoint tooltip
	MapCommon.WaypointMouseOverEnd()

	-- delete all the waypoints
	MapCommon.DeleteAllWaypoints()

	-- do we have the tmap overlay active?
	if IsValidID(AtlasWindow.TmapID) then
		
		-- atlas window name
		local windowName = "AtlasWindow"

		-- waypoint name
		local mapPointName = windowName .. "TmapPoint"

		-- reset the tmap ID (and disable the overlay mode)
		AtlasWindow.TmapID = 0

		-- reset the tmap name
		AtlasWindow.TmapName = ""
		
		-- show the buttons that are not related to the overlay mode
		AtlasWindow.ToggleOverlayButtons()

		-- remove the tmap texture
		DynamicImageSetTexture(windowName .. "MapTMapImage", "", 0, 0)

		-- restore the tilt value
		MapCommon.Tilt = AtlasWindow.OldTilt

		-- restore the waypoint filters
		Interface.Settings[windowName .. "_WPFilters"] = AtlasWindow.OldFilters

		-- delete the tmap point
		DestroyWindow(mapPointName)

		-- hide the tmap overlay
		WindowSetShowing(windowName .. "MapTMapImage", false)

		-- resize the atlas
		WindowSetDimensions(windowName, AtlasWindow.Sizes.Default.w, AtlasWindow.Sizes.Default.h)

		-- current window background
		local bg = windowName .. "Bg"

		-- reset the bg anchors
		WindowClearAnchors(bg)

		-- stretch the background properly
		WindowAddAnchor(bg, "topleft", windowName, "topleft", 0, 0)
		WindowAddAnchor(bg, "bottomright", windowName, "bottomright", AtlasWindow.Sizes.Default.bottomAnchorX, AtlasWindow.Sizes.Default.bottomAnchorY)
	end

	-- show the minimap (if it was open)
	if AtlasWindow.MinimapWasOpen then
		
		-- we need to delay the re-opening of the minimap or the game will crash (especially after adding a tmap waypoint)
		Interface.AddTodoList({func = function() MapWindow.ShowMap() end, time = Interface.TimeSinceLogin + 0.5})
	end
end

function AtlasWindow.HideAtlas()
	
	-- hide the atlas window
	WindowSetShowing("AtlasWindow", false)
end

function AtlasWindow.ShowAtlas()
	
	-- is the atlas already open?
	if not WindowGetShowing("AtlasWindow") then

		-- remember if the minimap was open
		AtlasWindow.MinimapWasOpen = WindowGetShowing("MapWindow")

		-- hide the minimap
		MapWindow.HideMap()

		-- show the atlas
		WindowSetShowing("AtlasWindow", true)	

	else -- is the atlas already open?

		-- update the map (and fix rotation)
		Interface.UpdateMap(true)
	end

	-- focus the atlas
	WindowAssignFocus("AtlasWindow", true)
	
	-- DO NOT keep the map center on player
	UORadarSetCenterOnPlayer(false)
    
	-- load the zoom
	UOSetRadarZoom(MapCommon.ZoomCurrent["AtlasWindow"])

	-- update the player location
	MapCommon.UpdatePlayerLocation()

	-- update waypoints
	MapCommon.WaypointsDirty = true

	-- update the list of all the waypoints in the map
	Interface.AddTodoList({func = function() AtlasWindow.UpdateVisibleWaypointsSearch() end, time = Interface.TimeSinceLogin + 0.5})
end

function AtlasWindow.UpdateMap(tiltChanged)

	-- main window name
	local this = "AtlasWindow"

	-- atlas map texture
	local mapTxt = this .. "MapImage"

	-- set the texture scale
	DynamicImageSetTextureScale(mapTxt, WindowData.Radar.TexScale)

	-- set the texture
	DynamicImageSetTexture(mapTxt, "radar_texture", WindowData.Radar.TexCoordX, WindowData.Radar.TexCoordY)

	-- is the map rotation changed?
	if tiltChanged then

		-- tilt map
		UOSetRadarRotation(MapCommon.Tilt)

		-- tilt texture
		DynamicImageSetRotation(mapTxt, MapCommon.Tilt)

		-- update the compass rotation
		DynamicImageSetRotation(this .. "Compass", MapCommon.Tilt)
	end

	-- get the current facet
	local facet = UOGetRadarFacet()

	-- get the current area
	local area = UOGetRadarArea()

	-- has the area or facet changed?
	if AtlasWindow.CurrFacet ~= facet or AtlasWindow.CurrArea ~= area then
		
		-- update waypoints
		MapCommon.WaypointsDirty = true	
	end

	-- update the current location
	AtlasWindow.CurrFacet = facet
	AtlasWindow.CurrArea = area
	
	-- update the areas combo
	AtlasWindow.UpdateAreaCombo()

	-- update the facet combo selection
	ComboBoxSetSelectedMenuItem(this .. "FacetCombo", (facet + 1))	

	-- update the area combo selection
	ComboBoxSetSelectedMenuItem(this .. "AreaCombo", (area + 1))	
end

function AtlasWindow.UpdateFacetCombo()

	-- main window name
	local this = "AtlasWindow"

	-- waypoint editor area name
	local waypointEditor = this .. "WaypointEditor"

	-- clear the facets combo
	ComboBoxClearMenuItems(this .. "FacetCombo")

	-- scan all the facets
    for facet = 0, (MapCommon.NumFacets - 1) do
		
		-- add the facet to the combos
        ComboBoxAddMenuItem(this .. "FacetCombo", GetStringFromTid(UORadarGetFacetLabel(facet)) )
        ComboBoxAddMenuItem(waypointEditor .. "Map" .. "Combo", GetStringFromTid(UORadarGetFacetLabel(facet)) )
    end
end

function AtlasWindow.UpdateAreaCombo()

	-- main window name
	local this = "AtlasWindow"

	-- clear the areas list combo
	ComboBoxClearMenuItems(this .. "AreaCombo")

	-- scan all the areas for the current facet
	for areaIndex = 0, (UORadarGetAreaCount(AtlasWindow.CurrFacet) - 1) do

		-- add the area to the list
		ComboBoxAddMenuItem(this .. "AreaCombo", GetStringFromTid(UORadarGetAreaLabel(AtlasWindow.CurrFacet, areaIndex)))
	end			
end

function AtlasWindow.SelectFacet()

	-- main window name
	local this = "AtlasWindow"

	-- waypoint editor area name
	local waypointEditor = this .. "WaypointEditor"

	-- is the waypoint editor visible?
	if WindowGetShowing(waypointEditor) then
		return
	end

	-- get the selected facet
	local facet = ComboBoxGetSelectedMenuItem(this .. "FacetCombo") - 1

	-- we will use the area 0 because we don't know how many areas the new facet will have
    local area = 0

	-- have we selected a different facet from the one we're actually in?
	if facet ~= AtlasWindow.CurrFacet then

		-- move the map to the center of the new facet/area
		AtlasWindow.ChangeArea(facet, area)
	end

	-- remove the waypoint tooltip
	MapCommon.WaypointMouseOverEnd()
end

function AtlasWindow.SelectArea()
	
	-- main window name
	local this = "AtlasWindow"

	-- waypoint editor area name
	local waypointEditor = this .. "WaypointEditor"

	-- is the waypoint editor visible?
	if WindowGetShowing(waypointEditor) then
		return
	end

	-- we use the current facet to change area
	local facet = AtlasWindow.CurrFacet

	-- get the new area selected
    local area = ComboBoxGetSelectedMenuItem(this .. "AreaCombo") - 1

	-- have we selected a different area from the one we're actually in?
	if area ~= AtlasWindow.CurrArea then

		-- move the map to the center of the new facet/area
		AtlasWindow.ChangeArea(facet, area)
	end

	-- remove the waypoint tooltip
	MapCommon.WaypointMouseOverEnd()
end

function AtlasWindow.ChangeArea(facet, area)

	-- main window name
	local this = "AtlasWindow"

	-- do we have an area and facet specified?
	if not area or not facet then
		return
	end

	-- get the top left and bottom right corner locations of the area in the map
	local x1, y1, x2, y2 = UORadarGetAreaDimensions(facet, area)

	-- do we have the bottom right corner?
	if not x2 then
		return
	end

	-- calculate the center of the area
	local centerX = ((x2 - x1) / 2) + x1
	local centerY = ((y2 - y1) / 2) + y1
	
	-- set the map to the area center
	UOCenterRadarOnLocation(centerX, centerY, facet, area, false)
		
	-- is the current zoom higher than it should be for this area?
	if MapCommon.ZoomCurrent[this] > UORadarGetMaxZoomForMap(facet, area) then

		-- set the zoom to the maximum level of this area
		MapCommon.ZoomCurrent[this] = UORadarGetMaxZoomForMap(facet, area)

		-- update the zoom
		UOSetRadarZoom(MapCommon.ZoomCurrent[this])
	end

	-- update waypoints
	MapCommon.WaypointsDirty = true
	
	-- update the list of all the waypoints in the map
	Interface.AddTodoList({func = function() AtlasWindow.UpdateVisibleWaypointsSearch() end, time = Interface.TimeSinceLogin + 0.5})
end

function AtlasWindow.MapOnLButtonDblClk()

	-- current window name
	local this = "AtlasWindow"

	-- waypoint editor area name
	local waypointEditor = this .. "WaypointEditor"

	-- is the waypoint editor visible?
	if WindowGetShowing(waypointEditor) then
		return
	end

	-- get the screen position of the map
	local windowX, windowY = WindowGetScreenPosition("AtlasWindowMapImage")

	-- calculate the mouse position
	local deltaX = SystemData.MousePosition.x - windowX
	local deltaY = SystemData.MousePosition.y - windowY

	-- do we have the mouse coordinates?
    if (deltaX ~= 0 or deltaY ~= 0) then
   
        -- get the current facet
        local facet = AtlasWindow.CurrFacet

		-- get the current area
        local area = AtlasWindow.CurrArea
        
		-- get the current window scale
		local scale = WindowGetScale("AtlasWindow")

		-- calculate the position we clicked (map coordinates)
		local newCenterX, newCenterY = UOGetRadarPosToWorld((deltaX / scale), (deltaY / scale), false)

		-- is the clicked position inside the visible area?
		if UORadarIsLocationInArea(newCenterX, newCenterY, facet, area) then

			-- shift the map to the new location
			UOCenterRadarOnLocation(newCenterX, newCenterY, facet, area, false)

			-- update waypoints
			MapCommon.WaypointsDirty = true
		end
    end
end

function AtlasWindow.MapOnRButtonUp(flags, x, y)

	-- current window name
	local this = "AtlasWindow"

	-- waypoint editor area name
	local waypointEditor = this .. "WaypointEditor"

	-- is the waypoint editor visible?
	if WindowGetShowing(waypointEditor) then
		return
	end

	-- get the screen position of the map
	local windowX, windowY = WindowGetScreenPosition("AtlasWindowMapImage")

	-- calculate the mouse position
	local deltaX = SystemData.MousePosition.x - windowX
	local deltaY = SystemData.MousePosition.y - windowY

	-- do we have the mouse coordinates?
    if (deltaX ~= 0 or deltaY ~= 0) then
   
        -- get the current facet
        local facet = AtlasWindow.CurrFacet

		-- get the current area
        local area = AtlasWindow.CurrArea
        
		-- get the current window scale
		local scale = WindowGetScale("AtlasWindow")

		-- calculate the position we clicked (map coordinates)
		local newCenterX, newCenterY = UOGetRadarPosToWorld((deltaX / scale), (deltaY / scale), false)

		-- is the clicked position inside the visible area?
		if UORadarIsLocationInArea(newCenterX, newCenterY, facet, area) then

			-- create the params for the context menu
			local params = { x = newCenterX, y = newCenterY, facetId = UOGetRadarFacet(), area = UOGetRadarArea() }

			-- reset the context menu
			ContextMenu.CleanUp()

			-- create waypoint here
			ContextMenu.CreateLuaContextMenuItem({ tid = MapCommon.TID.CreateWaypoint, returnCode = MapCommon.ContextReturnCodes.CREATE_WAYPOINT, param = params })

			-- add the magnetize option
			ContextMenu.CreateLuaContextMenuItem({ tid = MapCommon.TID.Magnetize, returnCode = MapCommon.ContextReturnCodes.MAGNETIZE, param = params })
	
			-- show the context menu
			ContextMenu.ActivateLuaContextMenu(MapCommon.ContextMenuCallback, true)
		end
    end
end

function AtlasWindow.MapMouseDrag(flags, deltaX, deltaY)

	-- current window name
	local this = "AtlasWindow"

	-- waypoint editor area name
	local waypointEditor = this .. "WaypointEditor"

	-- is the waypoint editor visible?
	if WindowGetShowing(waypointEditor) then
		return
	end

	-- do we have the mouse coordinates?
    if (deltaX ~= 0 or deltaY ~= 0) then
   
        -- get the current facet
        local facet = AtlasWindow.CurrFacet

		-- get the current area
        local area = AtlasWindow.CurrArea
             
		-- get the map center
		local mapCenterX, mapCenterY = UOGetRadarCenter()
		
		-- convert the map coordinates into screen coordinates
		local winCenterX, winCenterY = UOGetWorldPosToRadar(mapCenterX, mapCenterY)
		
		-- calculate where we have clicked in the map (screen coordinates)
		local offsetX = winCenterX - deltaX
		local offsetY = winCenterY - deltaY

		-- calculate the position we clicked (map coordinates)
		local newCenterX, newCenterY = UOGetRadarPosToWorld(offsetX, offsetY, false)

		-- is the new location inside the visible area?
		if UORadarIsLocationInArea(newCenterX, newCenterY, facet, area) then

			-- flag that the map is being dragged
			AtlasWindow.IsDraggingMap = true

			-- shift the map to the new location
			UOCenterRadarOnLocation(newCenterX, newCenterY, facet, area, false)

			-- update waypoints
			MapCommon.WaypointsDirty = true
		end
    end
end

function AtlasWindow.ToggleOverlayButtons()

	-- atlas window name
	local windowName = "AtlasWindow"

	-- scan the buttons in the list
	for i, button in pairsByIndex(AtlasWindow.OverlayModeButtons) do

		-- full button window name
		local buttonWindow = windowName .. button

		-- toggle the button
		WindowSetShowing(buttonWindow, not WindowGetShowing(buttonWindow))
	end
end

function AtlasWindow.CreateTmapPoint()

	-- atlas window name
	local windowName = "AtlasWindow"

	-- tmap texture on the atlas
	local textureWindow = windowName .. "MapTMapImage"

	-- waypoint name
	local mapPointName = windowName .. "TmapPoint"

	-- do we have a tmap point already?
	if DoesWindowExist(mapPointName) then

		-- destroy the existing point
		DestroyWindow(mapPointName)
	end

	-- create the waypoint
	CreateWindowFromTemplate(mapPointName, "TMapPoint", textureWindow)

	-- set the waypoint ID
	WindowSetId(mapPointName, AtlasWindow.TmapID)

	-- reset the waypoint anchors
	WindowClearAnchors(mapPointName)

	-- position the waypoint in the map
	WindowAddAnchor(mapPointName, "topleft", textureWindow, "center", CourseMapWindow.MapPoints[AtlasWindow.TmapID][1].x, CourseMapWindow.MapPoints[AtlasWindow.TmapID][1].y)

	-- fix the waypoint transparency
	WindowSetAlpha(mapPointName, 1.0)
end

function AtlasWindow.GetXLocation()
	
	-- atlas window name
	local windowName = "AtlasWindow"

	-- waypoint name
	local mapPointName = windowName .. "TmapPoint"

	-- get the screen position of the map
	local windowX, windowY = WindowGetScreenPosition(windowName .. "MapImage")

	-- get the screen position of the X
	local xX, xY = WindowGetScreenPosition(mapPointName)

	-- get the treasure waypoint size
	local w, h = WindowGetDimensions(mapPointName)

	-- calculate the X position
	local deltaX = (xX + (w / 2)) - windowX
	local deltaY = (xY + (h / 2)) - windowY

	-- do we have the X center coordinates?
    if (deltaX ~= 0 or deltaY ~= 0) then
   
        -- get the current facet
        local facet = AtlasWindow.CurrFacet

		-- get the current area
        local area = AtlasWindow.CurrArea
        
		-- get the window scale
		local scale = WindowGetScale(windowName)

		-- get the x, y coordinates (map coordinates)
		return UOGetRadarPosToWorld((deltaX / scale), (deltaY / scale), false)
    end
end

-- we must keep this function (and related event in the xml) or the drag event won't work
function AtlasWindow.MapOnLButtonUp()

	-- flag that the map is no longer being dragged
	AtlasWindow.IsDraggingMap = nil

	-- update the list of all the waypoints in the map
	AtlasWindow.UpdateVisibleWaypointsSearch()
end

function AtlasWindow.AtlasOverlayOnLButtonUp()
	
	-- get the tmap window name
	local this = WindowUtils.GetActiveDialog()

	-- atlas window name
	local windowName = "AtlasWindow"

	-- tmap texture on the atlas
	local textureWindow = windowName .. "MapTMapImage"

	-- store the tmap ID
	AtlasWindow.TmapID = WindowGetId(this)

	-- is there a waypoint already for this map?
	if Interface.TmapWaypoints[AtlasWindow.TmapID] then

		-- scroll to the waypoint instead
		MapCommon.Locate(Interface.TmapWaypoints[AtlasWindow.TmapID].x, Interface.TmapWaypoints[AtlasWindow.TmapID].y, Interface.TmapWaypoints[AtlasWindow.TmapID].facet)

		-- reset the map ID
		AtlasWindow.TmapID = 0

		return
	end

	-- get the map name (for the waypoint)
	AtlasWindow.TmapName = GetStringFromTid(CourseMapWindow.TmapType[AtlasWindow.TmapID]) .. L" " .. GetStringFromTid(CourseMapWindow.TmapLevelToName[CourseMapWindow.isTmap[AtlasWindow.TmapID]])

	-- store the current tilt value
	AtlasWindow.OldTilt = MapCommon.Tilt

	-- store the current filters
	AtlasWindow.OldFilters = Interface.Settings[windowName .. "_WPFilters"]

	-- initialize the filters string
	local filterString = ""

	-- enable all filters
	while string.len(filterString) < table.countElements(MapCommon.WaypointFilters) do
		filterString = filterString .. "0"
	end

	-- store the new filters
	Interface.Settings[windowName .. "_WPFilters"] = filterString

	-- tilt the map to 0�
	MapCommon.Tilt = 0

	-- show the tmap overlay
	WindowSetShowing(windowName .. "MapTMapImage", true)

	-- switch to atlas
	AtlasWindow.ShowAtlas()
	
	-- get the tmap facet and area info
	local mapData = CourseMapWindow.MapData[AtlasWindow.TmapID]

	-- switch to the tmap location
	AtlasWindow.ChangeArea(mapData.facetId, mapData.area)

	-- hide the buttons that are not related to the overlay mode
	AtlasWindow.ToggleOverlayButtons()

	-- hide the waypoint editor
	WindowSetShowing(windowName .. "WaypointEditor", false)

	-- match the tmap zoom
	MapCommon.SetZoom(AtlasWindow.TmapMatchingZoom)

	-- get the map texture data
    local width, height, textureWidth, textureHeight, textureScale = GetCourseMapWindowDimensions(AtlasWindow.TmapID)

	-- set the texture dimensions and scale
    DynamicImageSetTextureDimensions(textureWindow, textureWidth, textureHeight)
	DynamicImageSetTextureScale(textureWindow, textureScale)

	-- draw the map
    DynamicImageSetTexture(textureWindow, "CourseMap" .. AtlasWindow.TmapID, 0, 0)

	-- fade the tmap
	WindowSetAlpha(textureWindow, 0.7)

	-- create the treasure location X
	AtlasWindow.CreateTmapPoint()

	-- fix the point scale
	WindowSetScale(windowName .. "TmapPoint", 0.8)

	-- resize the atlas
	WindowSetDimensions(windowName, AtlasWindow.Sizes.OverlayMode.w, AtlasWindow.Sizes.OverlayMode.h)

	-- current window background
	local bg = windowName .. "Bg"

	-- reset the bg anchors
	WindowClearAnchors(bg)

	-- stretch the background properly
	WindowAddAnchor(bg, "topleft", windowName, "topleft", 0, 0)
	WindowAddAnchor(bg, "bottomright", windowName, "bottomright", AtlasWindow.Sizes.OverlayMode.bottomAnchorX, AtlasWindow.Sizes.OverlayMode.bottomAnchorY)
end

function AtlasWindow.TmapLocationOnLButtonDown()

	-- do we have the sos waypoints table?
	if not Interface.TmapWaypoints then

		-- initialize the table
		Interface.TmapWaypointsAll = CreateSaveStructureWithPlayerID(Interface.TmapWaypointsAll)

		-- load the waypoints
		Interface.InitializeTmapWaypoints()
	end

	-- get the X location (based on the current position of the overlay)
	local x, y = AtlasWindow.GetXLocation()

	-- store the map waypoint
	Interface.TmapWaypoints[AtlasWindow.TmapID] = { facet = AtlasWindow.CurrFacet, x = x, y = y, z = 0, type = MapCommon.WaypointCustomType, name = AtlasWindow.TmapName, Icon = 100113, Scale = 1.5 }

	-- hide the atlas
	AtlasWindow.HideAtlas()

	-- update waypoints
	MapCommon.WaypointsDirty = true
end

function AtlasWindow.AtlasOverlayOnMouseOver()

	-- get the tmap window name
	local this = WindowUtils.GetActiveDialog()

	-- do we have the sos waypoints table?
	if not Interface.TmapWaypoints then

		-- initialize the table
		Interface.TmapWaypointsAll = CreateSaveStructureWithPlayerID(Interface.TmapWaypointsAll)

		-- load the waypoints
		Interface.InitializeTmapWaypoints()
	end

	-- is there a waypoint already for this map?
	if Interface.TmapWaypoints[WindowGetId(this)] then

		-- locate waypoint tooltip
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(MapCommon.TID.LocateWaypoint))

	else -- create the atlas overlay tooltip
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(MapCommon.TID.AtlasOverlay))
	end
end

function AtlasWindow.TmapLocationTooltip()

	-- create the X tooltip
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(MapCommon.TID.XTooltip))
end

function AtlasWindow.CheckNumbers(text)

	-- get the textbox window name
	local this = SystemData.ActiveWindow.name

	-- initialize the clean string
	local finalText = L""

	-- count how many . we have in the string (only 1 allowed)
	local countDots = 0

	-- scan all the characters of the text
	for i = 1, wstring.len(text) do

		-- get the current character
		local char = wstring.getChar(text, i)
		
		-- is the char a number or .?
		if table.contains(StringUtils.Numbers, char) then

			-- add the char to the final string
			finalText = finalText .. char
		end

		-- is this a dot and we have none at the moment?
		if char == L"." and countDots == 0 then

			-- increase the count for dots
			countDots = countDots + 1

			-- add the char to the final string
			finalText = finalText .. char
		end
	end

	-- replace the current string with the clean one.
	TextEditBoxSetText(this, finalText)
end

function AtlasWindow.CheckDegrees(text)

	-- get the textbox window name
	local this = SystemData.ActiveWindow.name

	-- initialize the clean string
	local finalText = L""

	-- count how many . we have in the string (only 1 allowed)
	local countDots = 0

	-- count how many ' we have in the string (only 1 allowed)
	local countMinutes = 0

	-- scan all the characters of the text
	for i = 1, wstring.len(text) do

		-- get the current character
		local char = wstring.getChar(text, i)
		
		-- is the char a number or .?
		if table.contains(StringUtils.Numbers, char) then

			-- add the char to the final string
			finalText = finalText .. char
		end

		-- is this a dot and we have none at the moment?
		if char == L"." and countDots == 0 then

			-- increase the count for dots
			countDots = countDots + 1

			-- add the char to the final string
			finalText = finalText .. char
		end

		-- is this a minutes sign and we have none at the moment?
		if char == L"'" and countMinutes == 0 then

			-- increase the count for dots
			countMinutes = countMinutes + 1

			-- add the char to the final string
			finalText = finalText .. char
		end
	end

	-- replace the current string with the clean one.
	TextEditBoxSetText(this, finalText)
end

function AtlasWindow.IconOnSelChanged()
	
	-- get the combo window name
	local this = SystemData.ActiveWindow.name

	-- waypoint editor area name
	local waypointEditor = MapCommon.GetActiveMap() .. "WaypointEditor"

	-- get the combo selection
	local curSel = ComboBoxGetSelectedMenuItem(this)

	-- get the icon ID
	local iconId = MapCommon.IconsData[curSel].id

	-- get the icon data
	local iconTexture, x, y = GetIconData(iconId)

	-- get the icon size
	local iconWidth, iconHeight = UOGetTextureSize(iconTexture)

	-- resize the icon window
	WindowSetDimensions(waypointEditor .. "IconIcon", iconWidth, iconHeight)

	-- set the texture dimension
	DynamicImageSetTextureDimensions(waypointEditor .. "IconIcon", iconWidth, iconHeight)

	-- draw the icon
	DynamicImageSetTexture(waypointEditor .. "IconIcon", iconTexture, x, y)

	-- reset the scale
	WindowSetScale(waypointEditor .. "IconIcon", 1)
end

function AtlasWindow.IconScaleUp()

	-- window name
	local this = WindowGetParent(SystemData.ActiveWindow.name)

    -- icon name
	local icon = this .. "Icon"

	-- get the current icon scale
    local scale = WindowGetScale(icon)

	-- increase the scale and make sure it stays in the cap
    scale = math.min(scale + 0.1, AtlasWindow.NewWaypointScale.max)

	-- update the scale
    WindowSetScale(icon, scale)

	-- is the scale at the cap?
	if scale == AtlasWindow.NewWaypointScale.max then

		-- disable the button
		WindowUtils.DisableButton(this .. "ScaleUp", MapCommon.DisabledButtonColor)
	end

	-- enable the scale up
	WindowUtils.EnableButton(this .. "ScaleDown")
end

function AtlasWindow.ScaleUpOnMouseOver()

	-- create the scale up icon tooltip
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1155430))  -- Big Icon
end

function AtlasWindow.IconScaleDown()

	-- window name
	local this = WindowGetParent(SystemData.ActiveWindow.name)

    -- icon name
	local icon = this .. "Icon"

	-- get the current icon scale
    local scale = WindowGetScale(icon)

	-- decrease the scale and make sure it stays in the cap
    scale = math.max(scale - 0.1, AtlasWindow.NewWaypointScale.min)

	-- update the scale
    WindowSetScale(icon, scale)

	-- is the scale at the cap?
	if scale == AtlasWindow.NewWaypointScale.min then

		-- disable the button
		WindowUtils.DisableButton(this .. "ScaleDown", MapCommon.DisabledButtonColor)
	end

	-- enable the scale up
	WindowUtils.EnableButton(this .. "ScaleUp")
end

function AtlasWindow.ScaleDownOnMouseOver()

	-- create the scale down icon tooltip
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1155431)) -- Small Icon
end

function AtlasWindow.CoordinatesCheck()

	-- get the current window name
	local this = WindowGetParent(SystemData.ActiveWindow.name)

	-- waypoint editor window name
	local waypointEditor = WindowGetParent(this)

	-- is this the X/Y radio?
	if this == waypointEditor .. "CoordsTypeXY" then

		-- activate X/Y
		ButtonSetPressedFlag(this .. "Button", true)

		-- deactivate lat/long
		ButtonSetPressedFlag(waypointEditor .. "CoordsTypeLatLong" .. "Button", false)

		-- show the X/Y textboxes
		WindowSetShowing(waypointEditor .. "CoordsXY", true)

		-- hide the lat/long textboxes
		WindowSetShowing(waypointEditor .. "CoordsLatLong", false)

	else -- lat/long radio

		-- activate lat/long
		ButtonSetPressedFlag(this .. "Button", true)

		-- deactivate X/Y
		ButtonSetPressedFlag(waypointEditor .. "CoordsTypeXY" .. "Button", false)

		-- hide the X/Y textboxes
		WindowSetShowing(waypointEditor .. "CoordsXY", false)

		-- show the lat/long textboxes
		WindowSetShowing(waypointEditor .. "CoordsLatLong", true)
	end
end

function AtlasWindow.FunctionEnableLatLong(disableXY)
	
	-- current window name
	local this = "AtlasWindow"

	-- waypoint editor area name
	local waypointEditor = this .. "WaypointEditor"

	-- activate lat/long
	ButtonSetPressedFlag(waypointEditor .. "CoordsTypeLatLong" .. "Button", true)

	-- deactivate X/Y
	ButtonSetPressedFlag(waypointEditor .. "CoordsTypeXY" .. "Button", false)

	-- hide the X/Y textboxes
	WindowSetShowing(waypointEditor .. "CoordsXY", false)

	-- show the lat/long textboxes
	WindowSetShowing(waypointEditor .. "CoordsLatLong", true)

	-- do we have to disable the x/y button?
	if disableXY then

		-- disable the x/y button
		WindowUtils.DisableButton(waypointEditor .. "CoordsTypeXY" .. "Button", MapCommon.DisabledButtonColor)
		WindowUtils.DisableButton(waypointEditor .. "CoordsTypeXY" .. "Label", MapCommon.DisabledButtonColor)
	end
end

function AtlasWindow.FunctionEnableXY(disablelatLong)
	
	-- current window name
	local this = "AtlasWindow"

	-- waypoint editor area name
	local waypointEditor = this .. "WaypointEditor"

	-- activate X/Y
	ButtonSetPressedFlag(waypointEditor .. "CoordsTypeXY" .. "Button", true)

	-- deactivate lat/long
	ButtonSetPressedFlag(waypointEditor .. "CoordsTypeLatLong" .. "Button", false)

	-- show the X/Y textboxes
	WindowSetShowing(waypointEditor .. "CoordsXY", true)

	-- hide the lat/long textboxes
	WindowSetShowing(waypointEditor .. "CoordsLatLong", false)

	-- do we have to disable the lat/long button?
	if disablelatLong then

		-- disable the lat/long button
		WindowUtils.DisableButton(waypointEditor .. "CoordsTypeLatLong" .. "Button", MapCommon.DisabledButtonColor)
		WindowUtils.DisableButton(waypointEditor .. "CoordsTypeLatLong" .. "Label", MapCommon.DisabledButtonColor)
	end
end

function AtlasWindow.ChangeDirection()

	-- get the current button name
	local this = SystemData.ActiveWindow.name

	-- get the current direction
	local currDirection = ButtonGetText(this)

	-- is the direction north?
	if currDirection == GetStringFromTid(MapCommon.TID.North) then
		
		-- switch to south
		ButtonSetText(this, GetStringFromTid(MapCommon.TID.South))

	-- is the direction south?
	elseif currDirection == GetStringFromTid(MapCommon.TID.South) then

		-- switch to north
		ButtonSetText(this, GetStringFromTid(MapCommon.TID.North))

	-- is the direction east?
	elseif currDirection == GetStringFromTid(MapCommon.TID.East) then

		-- switch to west
		ButtonSetText(this, GetStringFromTid(MapCommon.TID.West))

	-- is the direction west?
	elseif currDirection == GetStringFromTid(MapCommon.TID.West) then

		-- switch to east
		ButtonSetText(this, GetStringFromTid(MapCommon.TID.East))
	end
end

function AtlasWindow.ClearWaypointEditor()

	-- waypoint editor area name
	local waypointEditor = "AtlasWindowWaypointEditor"

	-- reset the new/edit flag
	AtlasWindow.EditWaypointId = false

	-- reset the edit waypoint ID
	AtlasWindow.EditWaypointId = 0

	-- reset the name
	TextEditBoxSetText(waypointEditor .. "Name" .. "TextEditBox", L"")

	-- select the current map element
	ComboBoxSetSelectedMenuItem(waypointEditor .. "Map" .. "Combo", AtlasWindow.CurrFacet + 1)

	-- get the first icon in the list data
	local iconTexture, x, y = GetIconData(MapCommon.IconsData[1].id)

	-- get the icon size
    local iconWidth, iconHeight = UOGetTextureSize(iconTexture)

	-- resize the icon
    WindowSetDimensions(waypointEditor .. "Icon" .. "Icon", iconWidth, iconHeight)

	-- set the texture dimensions
    DynamicImageSetTextureDimensions(waypointEditor .. "Icon" .. "Icon", iconWidth, iconHeight)

	-- draw the icon
    DynamicImageSetTexture(waypointEditor .. "Icon" .. "Icon", iconTexture, x, y)

	-- reset the icon scale
	WindowSetScale(waypointEditor .. "Icon" .. "Icon", 1)
    
	-- select the first icon element
	ComboBoxSetSelectedMenuItem(waypointEditor .. "Icon" .. "Combo", 1)

	-- enable the lat/long button (in case it was disabled)
	WindowUtils.EnableButton(waypointEditor .. "CoordsTypeLatLong" .. "Button")
	WindowUtils.EnableButton(waypointEditor .. "CoordsTypeLatLong" .. "Label")
	
	-- switch to lat/long system
	ButtonSetPressedFlag(waypointEditor .. "CoordsTypeLatLong" .. "Button", true)

	-- enable the x/y button (in case it was disabled)
	WindowUtils.EnableButton(waypointEditor .. "CoordsTypeXY" .. "Button")
	WindowUtils.EnableButton(waypointEditor .. "CoordsTypeXY" .. "Label")

	-- deactivate X/Y
	ButtonSetPressedFlag(waypointEditor .. "CoordsTypeXY" .. "Button", false)

	-- hide the X/Y textboxes
	WindowSetShowing(waypointEditor .. "CoordsXY", false)

	-- show the lat/long textboxes
	WindowSetShowing(waypointEditor .. "CoordsLatLong", true)

	-- reset X value
	TextEditBoxSetText(waypointEditor .. "CoordsXYX" .. "TextEditBox", L"")

	-- reset Y value
	TextEditBoxSetText(waypointEditor .. "CoordsXYY" .. "TextEditBox", L"")

	-- reset latitude value
	TextEditBoxSetText(waypointEditor .. "CoordsLatLongLat" .. "TextEditBox", L"")

	-- set the default direction to north
	ButtonSetText(waypointEditor .. "CoordsLatLongLatDirection" .. "Button", GetStringFromTid(MapCommon.TID.North))

	-- reset longitude value
	TextEditBoxSetText(waypointEditor .. "CoordsLatLongLong" .. "TextEditBox", L"")

	-- set the default direction to west
	ButtonSetText(waypointEditor .. "CoordsLatLongLongDirection" .. "Button", GetStringFromTid(MapCommon.TID.West))
end

function AtlasWindow.ShowWaypointEditor()

	-- current window name
	local this = "AtlasWindow"

	-- waypoint editor area name
	local waypointEditor = this .. "WaypointEditor"

	-- is the atlas visible?
	if MapCommon.GetActiveMap() ~= this then
	
		-- switch to atlas
		AtlasWindow.ShowAtlas()

		-- flag that the atlas was closed
		AtlasWindow.AtlasWasClosed = true
	end

	-- disable the combo and the waypoint finder so we can't change area while creating a waypoint
	WindowSetHandleInput(this .. "AreaCombo", false)
	WindowSetHandleInput(this .. "FacetCombo", false)
	WindowSetHandleInput(this .. "WaypointFinder", false)

	-- clear the waypoint editor
	AtlasWindow.ClearWaypointEditor()

	-- show the waypoint editor
	WindowSetShowing(waypointEditor, true)

	-- focus on the waypoint name
	WindowAssignFocus(waypointEditor .. "Name" .. "TextEditBox", true)
end

function AtlasWindow.HideWaypointEditor()

	-- current window name
	local this = "AtlasWindow"

	-- waypoint editor area name
	local waypointEditor = this .. "WaypointEditor"
	
	-- re-enable the combo and the waypoint finder so we can't change area while creating a waypoint
	WindowSetHandleInput(this .. "AreaCombo", true)
	WindowSetHandleInput(this .. "FacetCombo", true)
	WindowSetHandleInput(this .. "WaypointFinder", true)

	-- hide the waypoint editor
	WindowSetShowing(waypointEditor, false)
	
	-- reset the new/edit flag
	AtlasWindow.EditWaypointId = false

	-- reset the edit waypoint ID
	AtlasWindow.EditWaypointId = 0
	
	-- was the atlas closed?
	if AtlasWindow.AtlasWasClosed then
	
		-- reset the flag
		AtlasWindow.AtlasWasClosed = false

		-- hide the atlas
		AtlasWindow.HideAtlas()

		-- we need to delay the re-opening of the minimap or the game will crash (especially after adding a tmap waypoint)
		Interface.AddTodoList({func = function() MapWindow.ShowMap() end, time = Interface.TimeSinceLogin + 0.5})
	end
end

function AtlasWindow.StartMoving()

	-- start the moving
	WindowSetMoving("AtlasWindow", true)
end

function AtlasWindow.StopMoving()

	-- stop the moving
	WindowSetMoving("AtlasWindow", false)
end

function AtlasWindow.CreateWaypointHere(x, y, facet, area, edit, waypointId, waypointName, iconId, iconScale)

	-- current window name
	local this = "AtlasWindow"

	-- waypoint editor area name
	local waypointEditor = this .. "WaypointEditor"

	-- show the waypoint editor
	AtlasWindow.ShowWaypointEditor()

	-- flag that we are creating a new waypoint false if we are editing
	AtlasWindow.NewWaypoint = not edit

	-- are we editing the waypoint?
	if not AtlasWindow.NewWaypoint then

		-- create/edit button text
		ButtonSetText(waypointEditor .. "CreateEdit", GetStringFromTid(MapCommon.TID.EditWaypointHere))

		-- set the name
		TextEditBoxSetText(waypointEditor .. "Name" .. "TextEditBox", waypointName)

		-- set the ID of the waypoint we are editing
		AtlasWindow.EditWaypointId = waypointId - MapCommon.WaypointIDRange.Custom.min

		-- get the first icon in the list data
		local iconTexture, txtx, txty = GetIconData(iconId)

		-- get the icon size
		local iconWidth, iconHeight = UOGetTextureSize(iconTexture)

		-- resize the icon
		WindowSetDimensions(waypointEditor .. "Icon" .. "Icon", iconWidth, iconHeight)

		-- set the texture dimensions
		DynamicImageSetTextureDimensions(waypointEditor .. "Icon" .. "Icon", iconWidth, iconHeight)

		-- draw the icon
		DynamicImageSetTexture(waypointEditor .. "Icon" .. "Icon", iconTexture, txtx, txty)

		-- set the icon scale
		WindowSetScale(waypointEditor .. "Icon" .. "Icon", iconScale)

		-- search for the icon
		for i = 1, #MapCommon.IconsData do
			
			-- is this the icon?
			if MapCommon.IconsData[i].id == iconId then

				-- select the icon element
				ComboBoxSetSelectedMenuItem(waypointEditor .. "Icon" .. "Combo", i)

				break
			end
		end

	else -- set CREATE text in the button
		ButtonSetText(waypointEditor .. "CreateEdit", GetStringFromTid(MapCommon.TID.CreateWaypointHere))
	end

	-- set X value
	TextEditBoxSetText(waypointEditor .. "CoordsXYX" .. "TextEditBox", towstring(x))

	-- set Y value
	TextEditBoxSetText(waypointEditor .. "CoordsXYY" .. "TextEditBox", towstring(y))

	-- fix the facet for certain areas.
	if (facet == 5 and (area == 2 or area == 7)) then
		facet = 0
	end

	-- are we on trammel or felucca or in the lost lands or any other facet?
	if (facet == 0 and (area == 0 or area == MapCommon.sextantFeluccaLostLands)) or (facet == 1 and (area == 0 or area == MapCommon.sextantTrammelLostLands) or facet > 1) then
	
		-- switch to lat/long
		AtlasWindow.FunctionEnableLatLong()

		-- calculate latitude and longitude based on the current player position
		local latStr, longStr, latDir, longDir = MapCommon.GetSextantLocationStrings(x, y, facet)

		-- set latitude value
		TextEditBoxSetText(waypointEditor .. "CoordsLatLongLat" .. "TextEditBox", towstring(latStr))

		-- set the default direction to north
		ButtonSetText(waypointEditor .. "CoordsLatLongLatDirection" .. "Button", towstring(latDir))

		-- set longitude value
		TextEditBoxSetText(waypointEditor .. "CoordsLatLongLong" .. "TextEditBox", towstring(longStr))

		-- set the default direction to west
		ButtonSetText(waypointEditor .. "CoordsLatLongLongDirection" .. "Button", towstring(longDir))

	else -- every other lace

		-- enable x/y and disable lat/long so that it cannot be used
		AtlasWindow.FunctionEnableXY(true)
	end
end

function AtlasWindow.WPOnPlayerLocation()
	
	-- current window name
	local this = "AtlasWindow"

	-- waypoint editor area name
	local waypointEditor = this .. "WaypointEditor"

	-- is the waypoint editor visible?
	if WindowGetShowing(waypointEditor) then
		return
	end

	-- center the map on player
	UORadarSetCenterOnPlayer(true)

	-- open the editor with the player location data
	AtlasWindow.CreateWaypointHere(WindowData.PlayerLocation.x, WindowData.PlayerLocation.y, WindowData.PlayerLocation.facet, UOGetRadarArea())

	-- detach the map from following the player
	UORadarSetCenterOnPlayer(false)
end

function AtlasWindow.CreateEditWaypoint()

	-- waypoint editor area name
	local waypointEditor = "AtlasWindowWaypointEditor"

	-- do we have custom waypoints?
	if not CustomWaypoints then

		-- create the custom waypoints structure
		UserCustomWaypoints = CreateSaveStructureWaypoints(UserCustomWaypoints)

		-- initialize the custom waypoints
		Interface.InitializeCustomWaypoints()
	end
	
	-- get the waypoint name
	local name = TextEditBoxGetText(waypointEditor .. "Name" .. "TextEditBox")
	
	-- do we have a valid waypoint name?
	if not IsValidWString(name) then

		-- show the error
		AtlasWindow.WaypointEditorError(GetStringFromTid(MapCommon.TID.InvalidWaypointName))

		return
	end

	-- get the facet
	local facet = AtlasWindow.CurrFacet

	-- get the area
	local area = AtlasWindow.CurrArea

	-- get the nicon ID
	local iconId = MapCommon.IconsData[ComboBoxGetSelectedMenuItem(waypointEditor .. "Icon" .. "Combo")].id

	-- get the icon scale
	local iconScale = WindowGetScale(waypointEditor .. "Icon" .. "Icon")

	-- get the radio value
	local latLong = ButtonGetPressedFlag(waypointEditor .. "CoordsTypeLatLong" .. "Button")

	-- initialize the x, y values
	local x, y

	-- do we have lat/long values?
	if latLong then

		-- get the latitude
		local latVal = TextEditBoxGetText(waypointEditor .. "CoordsLatLongLat" .. "TextEditBox")

		-- get the longitude
		local longVal = TextEditBoxGetText(waypointEditor .. "CoordsLatLongLong" .. "TextEditBox")

		-- get the latitude direction
		local latDir = ButtonGetText(waypointEditor .. "CoordsLatLongLatDirection" .. "Button")

		-- get the longitude direction
		local longDir = ButtonGetText(waypointEditor .. "CoordsLatLongLongDirection" .. "Button")

		-- do we have valid latitude and longitude?
		if not IsValidWString(latVal) or not IsValidWString(longVal) then
		
			-- show the error
			AtlasWindow.WaypointEditorError(GetStringFromTid(MapCommon.TID.InvalidWaypointCoordinates))

			return
		end

		-- calculate x, y from the lat/long coordinates
		x, y = MapCommon.ConvertToXYMinutes(tonumber(latVal), tonumber(longVal), latDir, longDir, facet, area)

	else -- get x and y
		x = TextEditBoxGetText(waypointEditor .. "CoordsXYX" .. "TextEditBox")
		y = TextEditBoxGetText(waypointEditor .. "CoordsXYY" .. "TextEditBox")

		-- do we have valid coordinates
		if not IsValidWString(x) or not IsValidWString(y) then

			-- show the error
			AtlasWindow.WaypointEditorError(GetStringFromTid(MapCommon.TID.InvalidWaypointCoordinates))

			return
		end

		-- convert to numbers
		x = tonumber(x)
		y = tonumber(y)
	end

	-- initialize the flag
	local flag

	-- tokuno dungeon flag
	if facet == 4 and area > 0 then
		flag = "DUNG"
	end

	-- abyss dungeon flag
	if facet == 5 and area == 1 then
		flag = "ABYSS"
	end

	-- champions areas in ter mur that should be in felucca
	if facet == 5 and (area == 2 or area == 7) then
		facet = 0
	end

	-- create the waypoint data
	local wp = { x = math.round(x), y = math.round(y), z = 0, type = MapCommon.WaypointCustomType, Name = name, Icon = iconId, Scale = iconScale, flag = flag}

	-- are we creating a new waypoint?
	if AtlasWindow.NewWaypoint then
		
		-- add the waypoint to the list
		table.insert(CustomWaypoints.Facet[facet], wp)

	else -- edit existing waypoint

		-- replace the existing data
		CustomWaypoints.Facet[facet][AtlasWindow.EditWaypointId] = wp
	end

	-- hide the waypoint editor
	AtlasWindow.HideWaypointEditor()

	-- update waypoints
	MapCommon.WaypointsDirty = true

	-- update the list of all the waypoints in the map
	Interface.AddTodoList({func = function() AtlasWindow.UpdateVisibleWaypointsSearch() end, time = Interface.TimeSinceLogin + 0.5})
end

function AtlasWindow.WaypointEditorError(message)
	
	-- waypoint editor area name
	local waypointEditor = "AtlasWindowWaypointEditor"

	-- waypoint editor error text
	LabelSetText(waypointEditor .. "Error" .. "Label", message)

	-- remove the error after 5s
	Interface.AddTodoList({ name = "Waypoint editor error reset", func = function() LabelSetText(waypointEditor .. "Error" .. "Label", L"") end, time = Interface.TimeSinceLogin + 5 })
end

AtlasWindow.tabIndex = 1
function AtlasWindow.OnKeyTab()

	-- waypoint editor area name
	local waypointEditor = "AtlasWindowWaypointEditor"

	-- increase the current tab index
	AtlasWindow.tabIndex = AtlasWindow.tabIndex + 1

	-- return at the start when it reaches the cap (3)
	if AtlasWindow.tabIndex > 3 then
		AtlasWindow.tabIndex = 1
	end

	-- get the radio value
	local latLong = ButtonGetPressedFlag(waypointEditor .. "CoordsTypeLatLong" .. "Button")

	-- tabindex 1 = waypoint name
	if AtlasWindow.tabIndex == 1 then

		-- focus on the waypoint name
		WindowAssignFocus(waypointEditor .. "Name" .. "TextEditBox", true)

	-- tabindex 2 = latitude/X
	elseif AtlasWindow.tabIndex == 2 then

		-- latitude/longitude mode on?
		if latLong then

			-- focus on the latitude
			WindowAssignFocus(waypointEditor .. "CoordsLatLongLat" .. "TextEditBox", true)

		else -- x/y mode

			-- focus on the X
			WindowAssignFocus(waypointEditor .. "CoordsXYX" .. "TextEditBox", true)
		end

	-- tabindex 3 = longitude/Y
	elseif AtlasWindow.tabIndex == 3 then

		-- latitude/longitude mode on?
		if latLong then

			-- focus on the longitude
			WindowAssignFocus(waypointEditor .. "CoordsLatLongLong" .. "TextEditBox", true)

		else -- x/y mode

			-- focus on the Y
			WindowAssignFocus(waypointEditor .. "CoordsXYY" .. "TextEditBox", true)
		end
	end
end

function AtlasWindow.OnKeyEscape()

	-- waypoint editor area name
	local waypointEditor = "AtlasWindowWaypointEditor"

	-- search box name
	local searchBox = "AtlasWindowWaypointFinderSearchBoxFilter"

	-- flag to not open the main menu
	MainMenuWindow.notnow = true

	-- is the waypoint editor visible?
	if WindowGetShowing(waypointEditor) then

		-- hide the waypoint editor
		AtlasWindow.HideWaypointEditor()

	-- does the search box has the focus?
	elseif WindowHasFocus(searchBox) then
		
		-- execute the reset search
		SearchBox.ResetSearch()

	else -- hide the atlas
		AtlasWindow.HideAtlas()
	end
end

function AtlasWindow.SearchText()

	-- get the text from the search box
	local text = SearchBox.GetFilter("AtlasWindowWaypointFinderSearchBox", true, true)
	
	-- do we have a valid text?
	if not IsValidString(text) then
		return
	end

	-- set that we are in search mode
	AtlasWindow.InSearch = true

	-- clear all the current elements
	AtlasWindow.ClearSearchItems()

	-- scan the UI waypoints
	for facet, array in pairs(Waypoints.Facet) do

		-- scan all the waypoints of this facet
		for i = 1, #array do

			-- does this waypoint cointains the search text?
			if string.find(string.lower(array[i].Name), text, 1, true) then

				-- get the waypoint ID
				local waypointId = MapCommon.WaypointIDRange.UI.min + i

				-- get the waypoint data
				local wtype, wflags, wname, wfacet, wx, wy, wz, iconId, iconDefaultScale = Waypoints.GetWaypointInfo(i, facet)

				-- create the waypoint data
				data = { waypointId = waypointId, wtype = wtype, wflags = wflags, wname = towstring(wname), wfacet = wfacet, wx = wx, wy = wy, wz = wz, iconId = iconId, iconDefaultScale = iconDefaultScale }

				-- create the result element
				AtlasWindow.CreateResultElement(data)
			end
		end
	end
	
	-- do we have custom waypoints?
	if CustomWaypoints then

		-- scan the custom waypoints
		for facet, array in pairs(CustomWaypoints.Facet) do

			-- scan all the waypoints of this facet
			for i = 1, #array do

				-- does this waypoint cointains the search text?
				if wstring.find(wstring.lower(array[i].Name), towstring(text), 1, true) then

					-- get the waypoint ID
					local waypointId = MapCommon.WaypointIDRange.Custom.min + i
					
					-- get the waypoint data
					local wtype, wflags, wname, wfacet, wx, wy, wz, iconId, iconDefaultScale = Waypoints.GetCustomWaypointInfo(i, facet)
					
					-- create the waypoint data
					data = { waypointId = waypointId, wtype = wtype, wflags = wflags, wname = towstring(wname), wfacet = wfacet, wx = wx, wy = wy, wz = wz, iconId = iconId, iconDefaultScale = iconDefaultScale }

					-- create the result element
					AtlasWindow.CreateResultElement(data)
				end
			end
		end
	end
	
	-- do we have SOS waypoints?
	if Interface.SOSWaypoints then

		-- initialize the counter
		local i = 1

		-- scan all the tmap waypoints
		for waypointId, data in pairs(Interface.SOSWaypoints) do

			-- is this the waypoint we're looking for?
			if wstring.find(wstring.lower(data.name), towstring(text), 1, true) then
				
				-- get the waypoint ID
				local waypointId = MapCommon.WaypointIDRange.SOS.min + i

				-- increase the counter
				i = i + 1

				-- get the data for the waypoint
				local wtype = data.type
				local wflags = data.flags
				local wname = data.name
				local wfacet = data.facet
				local wx = data.x
				local wy = data.y
				local wz = data.z
				local iconId = 100116
				local iconDefaultScale = data.Scale
				
				-- create the waypoint data
				data = { waypointId = waypointId, wtype = wtype, wflags = wflags, wname = towstring(wname), wfacet = wfacet, wx = wx, wy = wy, wz = wz, iconId = iconId, iconDefaultScale = iconDefaultScale }

				-- create the result element
				AtlasWindow.CreateResultElement(data)
			end
		end
	end

	-- do we have tmap waypoints?
	if Interface.TmapWaypoints then

		-- initialize the counter
		local i = 1

		-- scan all the tmap waypoints
		for waypointId, data in pairs(Interface.TmapWaypoints) do

			-- is this the waypoint we're looking for?
			if wstring.find(wstring.lower(data.name), towstring(text), 1, true) then
				
				-- get the waypoint ID
				local waypointId = MapCommon.WaypointIDRange.Tmap.min + i

				-- increase the counter
				i = i + 1

				-- get the data for the waypoint
				local wtype = data.type
				local wflags = data.flags
				local wname = data.name
				local wfacet = data.facet
				local wx = data.x
				local wy = data.y
				local wz = data.z
				local iconId = data.Icon
				local iconDefaultScale = data.Scale
				
				-- create the waypoint data
				data = { waypointId = waypointId, wtype = wtype, wflags = wflags, wname = towstring(wname), wfacet = wfacet, wx = wx, wy = wy, wz = wz, iconId = iconId, iconDefaultScale = iconDefaultScale }

				-- create the result element
				AtlasWindow.CreateResultElement(data)
			end
		end
	end
	
	-- do we have the charybdis waypoint?
	if Interface.CharybdisLocation then

		-- is this the waypoint we're looking for?
		if wstring.find(wstring.lower(Interface.CharybdisLocation.name), towstring(text), 1, true) then

			-- get the waypoint ID
			local waypointId = MapCommon.WaypointIDRange.Charybdis.min

			-- get the data for the charybdis waypoint
			local wtype = Interface.CharybdisLocation.type
			local wflags = Interface.CharybdisLocation.flags
			local wname = Interface.CharybdisLocation.name
			local wfacet = Interface.CharybdisLocation.facet
			local wx = Interface.CharybdisLocation.x
			local wy = Interface.CharybdisLocation.y
			local wz = Interface.CharybdisLocation.z
			local iconId = Interface.CharybdisLocation.Icon
			local iconDefaultScale = Interface.CharybdisLocation.Scale

			-- create the waypoint data
			data = { waypointId = waypointId, wtype = wtype, wflags = wflags, wname = towstring(wname), wfacet = wfacet, wx = wx, wy = wy, wz = wz, iconId = iconId, iconDefaultScale = iconDefaultScale }

			-- create the result element
			AtlasWindow.CreateResultElement(data)
		end
	end
	
	if Interface.VendorSearchMap then

		-- is this the waypoint we're looking for?
		if wstring.find(wstring.lower(Interface.VendorSearchMap.name), towstring(text), 1, true) then

			-- get the waypoint ID
			local waypointId = MapCommon.WaypointIDRange.VendorSearch.min

			-- get the data for the vendor search waypoint
			local wtype = Interface.VendorSearchMap.type
			local wflags = Interface.VendorSearchMap.flags
			local wname = Interface.VendorSearchMap.name
			local wfacet = Interface.VendorSearchMap.facet
			local wx = Interface.VendorSearchMap.x
			local wy = Interface.VendorSearchMap.y
			local wz = Interface.VendorSearchMap.z
			local iconId = Interface.VendorSearchMap.Icon
			local iconDefaultScale = Interface.VendorSearchMap.Scale

			-- create the waypoint data
			data = { waypointId = waypointId, wtype = wtype, wflags = wflags, wname = towstring(wname), wfacet = wfacet, wx = wx, wy = wy, wz = wz, iconId = iconId, iconDefaultScale = iconDefaultScale }

			-- create the result element
			AtlasWindow.CreateResultElement(data)
		end
	end

	-- update the count
	AtlasWindow.UpdateSearchCount()
end

function AtlasWindow.ClearSearchItems()

	-- scan all the waypoint we have in the results
	for windowName, data in pairs(AtlasWindow.FoundWP) do

		-- does the result still exist?
		if DoesWindowExist(windowName) then

			-- destroy the element
			DestroyWindow(windowName)
		end
	end

	-- clear the table
	AtlasWindow.FoundWP = {}
end

function AtlasWindow.ResetSearch()
	
	-- set that we are not in search
	AtlasWindow.InSearch = false

	-- clear the existing results
	AtlasWindow.ClearSearchItems()

	-- show all the visible waypoints as search result
	AtlasWindow.ShowVisibleWaypointsSearch()

	-- update the scroll area
	AtlasWindow.UpdateScrollArea()
end

function AtlasWindow.CreateResultElement(data)

	-- scrollable area container
	local dialog = "AtlasMapFindSW"

	-- scrollable area
	local parent = dialog .. "ScrollChild"

	-- get the id for the element
	local resultID = table.countElements(AtlasWindow.FoundWP) + 1

	-- result window name
	local prevSlotName = parent .. "Item" .. (resultID - 1)

	-- result window name
	local slotName = parent .. "Item" .. resultID

	-- result icon window
	local elementIcon = slotName .. "Icon"

	-- result name window
	local elementName = slotName .. "Name"

	-- result location window
	local elementLocation = slotName .. "Location"

	-- does the result already exist?
	if not DoesWindowExist(slotName) then

		-- create the result
		CreateWindowFromTemplate(slotName, "AtlasWeapontSearchResultItem", parent)
	end

	-- set the result ID
	WindowSetId(slotName, resultID)

	-- is this the first result?
	if resultID == 1 then
		
		-- anchor to the top of the parent window
		WindowAddAnchor(slotName, "topleft", parent, "topleft", 0, 5)
		WindowAddAnchor(slotName, "topright", dialog, "topright", -15, 0)

	else -- any other result gets anchored to the previous one
		WindowAddAnchor(slotName, "bottomleft", prevSlotName, "topleft", 0, 0)
		WindowAddAnchor(slotName, "bottomright", dialog, "topright", -15, 0)
	end

	-- get the icon data
	local iconTexture, x, y = GetIconData(data.iconId)

	-- get the icon dimensions
	local iconWidth, iconHeight = UOGetTextureSize(iconTexture)
	
	-- set the texture dimensions
	DynamicImageSetTextureDimensions(elementIcon, iconWidth * data.iconDefaultScale, iconHeight * data.iconDefaultScale)

	-- update the texture image
	DynamicImageSetTexture(elementIcon, iconTexture, x, y)

	-- update the texture dimensions
	WindowSetDimensions(elementIcon, iconWidth, iconHeight)

	-- set the icon scale
	DynamicImageSetTextureScale(elementIcon, data.iconDefaultScale)

	-- scale the texture
	WindowSetScale(elementIcon, data.iconDefaultScale)
	
	-- set the waypoint name
	LabelSetText(elementName, data.wname)
	
	-- create the sextant string (with x and y in the second line)
	local sextant = L"( " .. math.floor(data.wx) .. L", " .. math.floor(data.wy) .. L" )"

	-- set the waypoint name
	LabelSetText(elementLocation, sextant)

	-- make the separator a bit transparent
	WindowSetAlpha(slotName .. "Separator", 0.4)
	
	-- add the result to the table
	AtlasWindow.FoundWP[slotName] = data
end

function AtlasWindow.UpdateVisibleWaypointsSearch()

	-- do not execute if something have been searched
	if AtlasWindow.InSearch then

		-- refresh the search results instead
		AtlasWindow.SearchText()
		
		return
	end

	-- clear the existing results
	AtlasWindow.ClearSearchItems()

	-- if the overlay mode is active we don't do this
	if not WindowGetShowing("AtlasWindowWaypointFinder") then
		return
	end

	-- show all the visible waypoints as search result
	AtlasWindow.ShowVisibleWaypointsSearch()

	-- update the scroll area
	AtlasWindow.UpdateScrollArea()
end

function AtlasWindow.ShowVisibleWaypointsSearch()
	
	-- scan all the existing waypoints
	for waypoint, data in pairs(MapCommon.CreatedWaypoints) do
		
		-- create the result element
		AtlasWindow.CreateResultElement(data)
	end

	-- update the count
	AtlasWindow.UpdateSearchCount()
end

function AtlasWindow.UpdateSearchCount()

	-- no waypoints message lable
	local label = "AtlasMapFindSWNothingFound"

	-- total label
	local totalLabel = "AtlasWindowWaypointFinderTotal"
	
	-- clear the labels
	LabelSetText(label, L"")
	LabelSetText(totalLabel, L"")

	-- total waypoints found
	local totalwp = table.countElements(AtlasWindow.FoundWP)

	-- do we have something as result?
	if totalwp <= 0 then
		
		-- write "No waypoints found"
		LabelSetText(label, GetStringFromTid(MapCommon.TID.NoWaypointsFound))

	else -- write the total count
		LabelSetText(totalLabel, ReplaceTokens(GetStringFromTid(MapCommon.TID.TotalFound), { towstring(totalwp) }))
	end
end

function AtlasWindow.UpdateScrollArea()

	-- scrollable area container
	local dialog = "AtlasMapFindSW"

	-- update the scroll rectangle
	ScrollWindowUpdateScrollRect(dialog)   	

	-- get the current position in the list
	local listOffset = ScrollWindowGetOffset(dialog)

	-- get the max scrollable position
	local maxOffset = VerticalScrollbarGetMaxScrollPosition(dialog .. "Scrollbar")

	-- if the current scroll position is beyond the max we set it to the max
	if listOffset > maxOffset then
	    listOffset = maxOffset
	end
	
	-- update the scroll position
	ScrollWindowSetOffset(dialog, listOffset)
end

function AtlasWindow.LocateWaypoint()

	-- get the atlas window name
	local this = SystemData.ActiveWindow.name

	-- get the result waypoint data
	local waypointData = AtlasWindow.FoundWP[this]

	-- do we have the waypoint data?
	if not waypointData then
		return
	end

	-- center the map to the waypoint
	MapCommon.Locate(waypointData.wx, waypointData.wy, waypointData.wfacet)
end

function AtlasWindow.CenterOnPlayer()

	-- set the map to the area center
	MapCommon.Locate(WindowData.PlayerLocation.x, WindowData.PlayerLocation.y, WindowData.PlayerLocation.facet)
end

function AtlasWindow.CenterOnPlayerOnMouseOver()

	-- create the center on player tooltip
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(MapCommon.TID.CenterOnPlayer))
end