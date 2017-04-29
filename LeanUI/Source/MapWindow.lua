----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

MapWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------
			  
MapWindow.Rotation = 45
MapWindow.ZoomScale = 0.1
MapWindow.IsDragging = false
MapWindow.IsMouseOver = false
MapWindow.TypeEnabled = {}
MapWindow.LegendVisible = false
MapWindow.CenterOnPlayer = true

MapWindow.WINDOW_WIDTH_MAX = 716
MapWindow.WINDOW_HEIGHT_MAX = 776
MapWindow.MAP_WIDTH_DIFFERENCE = 0
MapWindow.MAP_HEIGHT_DIFFERENCE = 60

MapWindow.LegendItemTextColors = { normal={r=255,g=255,b=255}, disabled={r=80,g=80,b=80} }

MapWindow.Tilt = false

-----------------------------------------------------------------
-- MapCommon Helper Functions
-----------------------------------------------------------------

----------------------------------------------------------------
-- Event Functions
----------------------------------------------------------------

function MapWindow.Initialize()
	  WindowUtils.RestoreWindowPosition("MapWindow", true)
	  MapWindow.OnResizeEnd("MapWindow")

    RegisterWindowData(WindowData.Radar.Type,0)
    RegisterWindowData(WindowData.WaypointDisplay.Type,0)
    RegisterWindowData(WindowData.WaypointList.Type,0)
    
    WindowRegisterEventHandler("MapWindow", WindowData.Radar.Event, "MapWindow.UpdateMap")
    WindowRegisterEventHandler("MapWindow", WindowData.WaypointList.Event, "MapWindow.UpdateWaypoints")
    
    --ComboBoxClearMenuItems( "MapWindowFacetCombo" )
    for facet = 0, (MapCommon.NumFacets - 1) do
		    --Debug.Print("Adding: "..tostring(GetStringFromTid(UORadarGetFacetLabel(facet))))
        --ComboBoxAddMenuItem( "MapWindowFacetCombo", GetStringFromTid(UORadarGetFacetLabel(facet)) )
    end
    
    WindowSetScale("MapWindowCoordsText", 0.75 * InterfaceCore.scale)
    
    LabelSetText("MapWindowTitle", L"Map of Felucca")
    LabelSetText("MapWindowSubTitle", L"The world")
end

function MapWindow.Shutdown()
	WindowUtils.SaveWindowPosition("MapWindow")
	
  UnregisterWindowData(WindowData.Radar.Type,0)
  UnregisterWindowData(WindowData.WaypointDisplay.Type,0)
  UnregisterWindowData(WindowData.WaypointList.Type,0)
end

function MapWindow.UpdateMap()
    if( MapCommon.ActiveView == MapCommon.MAP_MODE_NAME ) then
		local facet = UOGetRadarFacet()
		if (facet ~= nil) then
			local facetName = GetStringFromTid(UORadarGetFacetLabel(facet))
			LabelSetText("MapWindowTitleLabel", L"Map of "..facetName)    
			
			for areaIndex = 0, (UORadarGetAreaCount(facet) - 1) do
				--ComboBoxAddMenuItem( "MapWindowAreaCombo", GetStringFromTid(UORadarGetAreaLabel(facet, areaIndex)) )
			end
		
			local area = UOGetRadarArea()
			local areaName = GetStringFromTid(UORadarGetAreaLabel(facet, area))
			if areaName == L"World" then
			 areaName = L"The World"
			end
      LabelSetText("MapWindowSubTitleLabel", L""..areaName)

			DynamicImageSetTextureScale("MapImage", WindowData.Radar.TexScale * 2)
			DynamicImageSetTexture("MapImage","radar_texture", WindowData.Radar.TexCoordX, WindowData.Radar.TexCoordY)
			DynamicImageSetRotation("MapImage", WindowData.Radar.TexRotation)
			
			--MapCommon.WaypointsDirty = true
			MapCommon.ForcedUpdate = true
			MapCommon.UpdateWaypoints(MapCommon.ActiveView)
		end
    end
end

function MapWindow.ShowFacetSelection()
  for facet = 0, (MapCommon.NumFacets - 1) do
        local name = GetStringFromTid(UORadarGetFacetLabel(facet))
        
        ContextMenu.CreateLuaContextMenuItem(L"Map of "..name, 0, MapCommon.ContextReturnCodes.SELECT_MAP, {
          facet = facet,
          area = 0
        })
    end
    
    ContextMenu.ActivateLuaContextMenu(MapWindow.ContextMenuSelectFacet)
end

function MapWindow.ContextMenuSelectFacet(returnCode, params)
  if returnCode == MapCommon.ContextReturnCodes.SELECT_MAP then
    local facet = params.facet or 0
    MapCommon.ChangeMap(facet, 0)
  end
end

function MapWindow.ShowAreaSelection()
  local facet = UOGetRadarFacet()
  if facet == nil then
    return
  end
  
  for areaIndex = 0, (UORadarGetAreaCount(facet) - 1) do
    local name = GetStringFromTid(UORadarGetAreaLabel(facet, areaIndex))
        
    if name == L"World" then
       name = L"The World"
    end
        
    ContextMenu.CreateLuaContextMenuItem(name, 0, MapCommon.ContextReturnCodes.SELECT_MAP, {
      facet = facet,
      area = areaIndex
    })
  end
    
  ContextMenu.ActivateLuaContextMenu(MapWindow.ContextMenuSelectArea)
end

function MapWindow.ContextMenuSelectArea(returnCode, params)
  if returnCode == MapCommon.ContextReturnCodes.SELECT_MAP then
    local facet = params.facet or 0
    local area = params.area or 0
    MapCommon.ChangeMap(facet, area)
  end
end

function MapWindow.UpdateWaypoints()
    if( MapCommon.ActiveView == MapCommon.MAP_MODE_NAME ) then
        MapCommon.WaypointsDirty = true
    end
end

function MapWindow.ActivateMap()
    if( MapCommon.ActiveView ~= MapCommon.MAP_MODE_NAME ) then
        local mapTextureWidth, mapTextureHeight = WindowGetDimensions("MapImage")

	    UORadarSetWindowSize(mapTextureWidth, mapTextureHeight, false, MapWindow.CenterOnPlayer)
	    UOSetRadarRotation(MapWindow.Rotation)
	    UORadarSetWindowOffset(0, 0)

	    WindowSetShowing("RadarWindow", false)
	    WindowSetShowing("MapWindow", true)
	    
	    MapCommon.ActiveView = MapCommon.MAP_MODE_NAME
	    UOSetWaypointDisplayMode(MapCommon.MAP_MODE_NAME)
		
		SystemData.Settings.Interface.mapMode = MapCommon.MAP_ATLAS
	    
	    local facet = UOGetRadarFacet()
	    local area = UOGetRadarArea()
	    MapCommon.UpdateZoomValues(facet, area)
	    if(MapWindow.CenterOnPlayer == true) then
			MapCommon.AdjustZoom(-4)
		else
			MapCommon.AdjustZoom(0)
		end
	    
	    MapWindow.UpdateMap()
	    MapWindow.UpdateWaypoints()
	end
end

-----------------------------------------------------------------
-- Input Event Handlers
-----------------------------------------------------------------

function MapWindow.MapOnMouseWheel(x, y, delta)
   	MapCommon.AdjustZoom(-delta)
end

function MapWindow.MapMouseDrag(flags,deltaX,deltaY)
    if( MapWindow.IsDragging and (deltaX ~= 0 or deltaY ~= 0) ) then
        MapCommon.SetWaypointsEnabled(MapCommon.ActiveView, false)
        
        local facet = UOGetRadarFacet()
        local area = UOGetRadarArea()
        
        local top, bottom, left, right = MapCommon.GetRadarBorders(facet, area)
        
        
        if ( (deltaX < 0 and right < MapCommon.MapBorder.RIGHT ) or ( deltaX >= 0 and left > MapCommon.MapBorder.LEFT ) ) then
			--deltaX = 0
        end
        
        if ( ( deltaY < 0 and bottom < MapCommon.MapBorder.BOTTOM ) or ( deltaY >= 0 and top > MapCommon.MapBorder.TOP ) ) then
			--deltaY = 0
        end
        
		local mapCenterX, mapCenterY = UOGetRadarCenter()
		local winCenterX, winCenterY = UOGetWorldPosToRadar(mapCenterX,mapCenterY)
		
		local offsetX = winCenterX - deltaX
		local offsetY = winCenterY - deltaY
		local useScale = false
	       
		local newCenterX, newCenterY = UOGetRadarPosToWorld(offsetX,offsetY,useScale)

		UOCenterRadarOnLocation(newCenterX, newCenterY, facet, area, false)
	        
		for waypointId, value in pairs(MapCommon.WaypointsIconFacet) do
			local windowName = "Waypoint"..waypointId..MapCommon.ActiveView
			if (value ~= facet) then
				if (DoesWindowNameExist(windowName)) then
					MapCommon.WaypointViewInfo[MapCommon.ActiveView].Windows[waypointId] = nil
					if (DoesWindowNameExist(windowName)) then
						DestroyWindow(windowName)
					end
				end
			end
		end
		MapCommon.ForcedUpdate = true
		MapCommon.UpdateWaypoints(MapCommon.ActiveView)
    end
end

function MapWindow.ToggleRadarOnLButtonUp()
    RadarWindow.ActivateRadar()
end

function MapWindow.ToggleRadarOnMouseOver()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(MapCommon.TID.ShowRadar))
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function MapWindow.MapOnRButtonUp(flags,x,y)
	local useScale = true
	local waypointX, waypointY = UOGetRadarPosToWorld(x, y, useScale)
	local params = {x=waypointX, y=waypointY, facetId=UOGetRadarFacet()} 
	
	local facet = UOGetRadarFacet()
	local area = UOGetRadarArea()
	local x1, y1, x2, y2 = UORadarGetAreaDimensions(facet, area)
	
	if (x1 < waypointX and y1 < waypointY and x2 > waypointX and y2 > waypointY) then
		ContextMenu.CreateLuaContextMenuItem(MapCommon.TID.CreateWaypoint,0,MapCommon.ContextReturnCodes.CREATE_WAYPOINT,params)
		ContextMenu.CreateLuaContextMenuItem(L"Tilt map", 0, MapCommon.ContextReturnCodes.TILT_MAP, params)
		ContextMenu.CreateLuaContextMenuItem(L"Center on player", 0, MapCommon.ContextReturnCodes.CENTER_PLAYER, params)
		ContextMenu.ActivateLuaContextMenu(MapCommon.ContextMenuCallback)
	end
end

function MapWindow.MapOnLButtonDown()
    MapWindow.IsDragging = true
    
    MapWindow.CenterOnPlayer = false
    ButtonSetPressedFlag( "MapWindowCenterOnPlayerButton", MapWindow.CenterOnPlayer )
    UORadarSetCenterOnPlayer(MapWindow.CenterOnPlayer)
end

function MapWindow.MapOnLButtonUp()
    MapWindow.IsDragging = false
    MapCommon.SetWaypointsEnabled(MapCommon.ActiveView, true)
end

function MapWindow.MapOnLButtonDblClk(flags,x,y)
	local useScale = true
    local worldX, worldY = UOGetRadarPosToWorld(x, y, useScale)
	local facet = UOGetRadarFacet()
	local area = UOGetRadarArea()
	
	if( UORadarIsLocationInArea(worldX, worldY, facet, area) ) then
		UOCenterRadarOnLocation(worldX, worldY, facet, area, true)
	end	

    MapWindow.CenterOnPlayer = false
    ButtonSetPressedFlag( "MapWindowCenterOnPlayerButton", MapWindow.CenterOnPlayer )
    UORadarSetCenterOnPlayer(MapWindow.CenterOnPlayer)	
end

function MapWindow.OnMouseOver()
	MapWindow.IsMouseOver = true
end

function MapWindow.OnMouseOverEnd()
    MapWindow.IsDragging = false
    MapWindow.IsMouseOver = false
    MapCommon.SetWaypointsEnabled(MapCommon.ActiveView, true)
end


function MapWindow.OnShown()

end

function MapWindow.OnUpdate()
	if( WindowGetShowing("MapWindow") == true and MapWindow.IsMouseOver == true) then
		local windowX, windowY = WindowGetScreenPosition("MapImage")
		local mouseX = SystemData.MousePosition.x - windowX
		local mouseY = SystemData.MousePosition.y - windowY
	    local useScale = true
	    local x, y = UOGetRadarPosToWorld(mouseX, mouseY, useScale)

		local facet = UOGetRadarFacet()
		local area = UOGetRadarArea()	    
	    local x1, y1, x2, y2 = UORadarGetAreaDimensions(facet, area)
		if (x1 < x and y1 < y and x2 > x and y2 > y) then
			local latStr, longStr, latDir, longDir = MapCommon.GetSextantLocationStrings(x, y, facet)
			LabelSetText("MapWindowCoordsText", latStr..L"'"..latDir..L" "..longStr..L"'"..longDir)
		else
			LabelSetText("MapWindowCoordsText", L"")
		end
	elseif (MapCommon.WaypointIsMouseOver == false) then
		LabelSetText("MapWindowCoordsText", L"")
	end
end

function MapWindow.OnHidden()
	MapCommon.ActiveView = nil
	SystemData.Settings.Interface.mapMode = MapCommon.MAP_HIDDEN
end

function MapWindow.OnResizeBegin()
	local windowName = WindowUtils.GetActiveDialog()
	local widthMin = 400
	local heightMin = 400
    WindowUtils.BeginResize( windowName, "topleft", widthMin, heightMin, false, MapWindow.OnResizeEnd)
end

function MapWindow.OnResizeEnd(curWindow)
	local windowWidth, windowHeight = WindowGetDimensions("MapWindow")
	--Debug.Print("MapWindow.OnResizeEnd("..curWindow..") width = "..windowWidth.." height = "..windowHeight)
	
	if(windowWidth > MapWindow.WINDOW_WIDTH_MAX) then
		windowWidth = MapWindow.WINDOW_WIDTH_MAX
	end
	
	if(windowHeight > MapWindow.WINDOW_HEIGHT_MAX) then
		windowHeight = MapWindow.WINDOW_HEIGHT_MAX
	end
	
	local legendScale = windowHeight / MapWindow.WINDOW_HEIGHT_MAX
	WindowSetScale("LegendWindow", legendScale * InterfaceCore.scale)
	
	WindowSetDimensions("MapWindow", windowWidth, windowHeight)
	WindowSetDimensions("Map", windowWidth - MapWindow.MAP_WIDTH_DIFFERENCE, windowHeight - MapWindow.MAP_HEIGHT_DIFFERENCE)
end