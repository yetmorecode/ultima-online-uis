----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

MapWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

MapWindow.Locked = false

MapWindow.MagnetPoint = {}
MapWindow.compassDelta = 0

MapWindow.WINDOW_WIDTH_MAX = 750
MapWindow.WINDOW_HEIGHT_MAX = 750

MapWindow.MAP_WIDTH_DIFFERENCE = 40
MapWindow.MAP_HEIGHT_DIFFERENCE = 90

----------------------------------------------------------------
-- Event Functions
----------------------------------------------------------------

function MapWindow.Initialize()

	-- current window name
	local this = "MapWindow"

	-- restore the map position
	WindowUtils.RestoreWindowPosition(this, true)
	
	-- fix the map dimensions
	MapWindow.OnResizeEnd(this)

	-- load the custom scale
	WindowUtils.LoadScale(this)

	-- mark the window as snappable
    SnapUtils.SnappableWindows[this] = true
   
	-- load the locked status 
    MapWindow.Locked = Interface.LoadSetting("MapWindowLocked", MapWindow.Locked)

	-- rotate the map name bg for a better effect
	DynamicImageSetRotation(this .. "MapNameBG", 180)

	-- update the lock button
	MapWindow.UpdateLockButton()
end

function MapWindow.Shutdown()

	-- save the current window position
	WindowUtils.SaveWindowPosition("MapWindow", true)
   
	-- remove the window from the snap list
    SnapUtils.SnappableWindows["MapWindow"] = nil
end

function MapWindow.LockTooltip()
	
	-- is the window locked?
	if MapWindow.Locked then

		-- show the unlock message
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1111696)) -- Unlock Window

	else -- show the lock message
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1111697)) -- Lock Window
	end
end

function MapWindow.Lock()
	
	-- toggle the lock status
	MapWindow.Locked = not MapWindow.Locked 
	
	-- save the new lock status
	Interface.SaveSetting( "MapWindowLocked", MapWindow.Locked  )
	
	-- update the button texture
	MapWindow.UpdateLockButton()
end

function MapWindow.OnMouseDrag(flags)
	
	-- is the window locked?
	if not MapWindow.Locked then

		-- if control is pressed, we allow the window to snap
		if flags == WindowUtils.ButtonFlags.CONTROL then
			SnapUtils.StartWindowSnap("MapWindow")
		end

		-- set the window in motion
		WindowSetMoving("MapWindow", true)

	else -- stop the window movement
		WindowSetMoving("MapWindow", false)
	end
end

function MapWindow.UpdateMap(tiltChanged)

	-- main window name
	local this = "MapWindow"

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
	if MapWindow.CurrFacet ~= facet or MapWindow.CurrArea ~= area then
		
		-- update waypoints
		MapCommon.WaypointsDirty = true	
	end

	-- update the current location
	MapWindow.CurrFacet = facet
	MapWindow.CurrArea = area
end

function MapWindow.OnShown()
	
	-- get the map image dimensions
	local mapTextureWidth, mapTextureHeight = WindowGetDimensions("MapWindowMapImage")

	-- set the area size to update for the map
	UORadarSetWindowSize(mapTextureWidth, mapTextureHeight, true, true)

	-- keep the map center on player
	UORadarSetCenterOnPlayer(true)

	-- reset the waypoints update timer
	MapCommon.RefreshDelta = 0

	-- update the map (and fix rotation)
	Interface.UpdateMap(true)
end

function MapWindow.HideMap()
	
	-- remove the waypoint tooltip
	MapCommon.WaypointMouseOverEnd()

	-- hide the minimap
	WindowSetShowing("MapWindow", false)

	-- delete all the waypoints
	MapCommon.DeleteAllWaypoints()
end

function MapWindow.ShowMap()

	-- make sure the atlas is closed before showing the minimap to avoid trouble
	if WindowGetShowing("AtlasWindow") then
		return
	end

	-- show the minimap
	WindowSetShowing("MapWindow", true)		
	
	-- center the map on player
	UORadarSetCenterOnPlayer(true)

	-- update the map (and fix rotation)
	Interface.UpdateMap(true)
    
	-- load the zoom
    UOSetRadarZoom(MapCommon.ZoomCurrent["MapWindow"])

	-- update the player location
	MapCommon.UpdatePlayerLocation()

	-- update waypoints
	MapCommon.WaypointsDirty = true
end

function MapWindow.UpdateLockButton()

	-- current window name
	local this = "MapWindow"

	-- default texture
	local texture = "Lock"

	-- is the map unlocked?
	if not MapWindow.Locked then

		-- unlock texture
		texture = "UnLock"
	end
	
	-- update the button textures
	ButtonSetTexture(this .. "Lock", InterfaceCore.ButtonStates.STATE_NORMAL, texture, 0,0)
	ButtonSetTexture(this .. "Lock", InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, texture, 0,0)
	ButtonSetTexture(this .. "Lock", InterfaceCore.ButtonStates.STATE_PRESSED, texture, 0,0)
	ButtonSetTexture(this .. "Lock", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, texture, 0,0)

	-- the resize button is visible only when the map is unlocked
	WindowSetShowing(this .. "ResizeButton", not MapWindow.Locked)
end

function MapWindow.AtlasOnMouseOver()
	
	-- create the atlas tooltip
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1155405)) -- Atlas
end

function MapWindow.AtlasOnLButtonUp()

	-- remove the waypoint tooltip
	MapCommon.WaypointMouseOverEnd()

	-- show the atlas and hide the minimap
	AtlasWindow.ShowAtlas()
end

function MapWindow.OnUpdate(timePassed)

	-- current window name
	local this = "MapWindow"

	-- compass arrow
	local navigator = this .. "Navigator"

	-- distance from target label
	local label = this.. "DestinationText"

	-- is the compass active?
	if not MapWindow.MagnetPoint.x then

		-- is the compass arrow visible?
		if WindowGetShowing(navigator) then
			
			-- hide the compass
			WindowSetShowing(navigator, false)
		end
		
		return
	end

	-- is the compass using an item and the item is gone?
	if MapWindow.MagnetPoint.itemID and not DoesPlayerHaveItem(MapWindow.MagnetPoint.itemID) then
	
		-- remove the magnet
		MapWindow.CloseCompass()
		return
	end

	-- do we have the waypoint id?
	if MapWindow.MagnetPoint.waypointId then

		-- get the item ID or mobile ID (if we have them)
		local itemId = MapWindow.MagnetPoint.itemID or MapWindow.MagnetPoint.mobileID

		-- check if the waypoint still exist
		if not MapCommon.DoesWaypointExist(MapWindow.MagnetPoint.waypointId, MapWindow.MagnetPoint.facet, itemId) then

			-- remove the magnet
			MapWindow.CloseCompass()
			return
		end
	end

	-- is the mobile we're tracking visible and there is no filter in the object handlers and we have no name for the mobile?
	if IsMobileVisible(MapWindow.MagnetPoint.mobileID) and ObjectHandleWindow.CurrentFilter == "" and not MapWindow.MagnetPoint.name then
		
		-- set the mobile name
		MapWindow.MagnetPoint.name = wstring.trim(GetMobileName(MapWindow.MagnetPoint.mobileID))

		-- set the mobile in the object handle filters
		ObjectHandleWindow.CurrentFilter = MapWindow.MagnetPoint.name
	end

	-- increase the timer for the compass
	MapWindow.compassDelta = MapWindow.compassDelta + timePassed

	-- the update time is random between 0.1 and 1s
	if MapWindow.compassDelta > math.random(0, 1) then

		-- reset the timer
		MapWindow.compassDelta = 0

		-- is the compass arrow visible?
		if not WindowGetShowing(navigator) then
			
			-- show the compass
			WindowSetShowing(navigator, true)
		end

		-- get the magnet point coordinates
		local wx = MapWindow.MagnetPoint.x
		local wy = MapWindow.MagnetPoint.y
		local wfacet = MapWindow.MagnetPoint.facet

		-- is the compass magnetized on a waypoint? (moving waypoints only)
		if MapWindow.MagnetPoint.waypointId then

			-- get the updated location
			_, _, _, wfacet, wx, wy = UOGetWaypointInfo(MapWindow.MagnetPoint.waypointId)
		end

		-- initialize the angle rotation for the needle
		local angle = 0

		-- initialize the distance 
		local distance = 0

		-- is the player in the right facet?
		if WindowData.PlayerLocation.facet == wfacet then

			-- calculate the distance difference between the current player location and the target location
			local deltaX = WindowData.PlayerLocation.x - wx
			local deltaY = WindowData.PlayerLocation.y - wy

			-- calculate the distance between the 2 points
			distance = math.ceil(math.sqrt(math.pow(deltaX, 2) + math.pow(deltaY, 2)))

			-- is the player AT the location?
			if distance == 0 then

				-- set the "you have arrived" label text
				LabelSetText(label, ReplaceTokens(GetStringFromTid(MapCommon.TID.Arrived)))

			else -- set the distance label text
				LabelSetText(label, ReplaceTokens(GetStringFromTid(MapCommon.TID.Distance), { towstring(distance) }))
			end

			-- calculate the rotation angle for the compass
			angle = math.ceil(8 * (1 + math.deg(math.atan2( deltaX, deltaY )) / 360) - 0.5) % 8
			
		else -- if the location is in another facet, we point to the nearest moongate

			-- get the closest moongate distance
			distance, angle = MapCommon.FindClosestMoongate(WindowData.PlayerLocation.x, WindowData.PlayerLocation.y, WindowData.PlayerLocation.facet)
			
			-- set the distance from the moongate label text
			LabelSetText(label, ReplaceTokens(GetStringFromTid(MapCommon.TID.DistanceMoongate), { GetStringFromTid(MapCommon.GetMapTid(wx, wy, wfacet)), towstring(distance) }))
		end

		-- fix the angle for the isometric view
		angle = (angle * -45) + 45

		-- default shaking value (to simulate the compass needle, the closer you are to the target, the more the needle shakes)
		local shaking = 1

		-- is the player on top of the target? (spin around)
		if distance <= 0 then
			shaking = 360

		-- the player is close
		elseif distance < 10 then
			shaking = 15

		-- the player is getting close
		elseif distance < 20 then
			shaking = 10

		-- the player is far
		elseif distance < 30 then
			shaking = 5

		-- the player is very far
		elseif distance < 50 then
			shaking = 2
		end

		-- update the angle with the shaking value
		angle = angle + math.ceil(math.random(-shaking, shaking))

		-- apply the angle to the needle
		DynamicImageSetRotation(navigator, angle)
	end
end

function MapWindow.CloseCompass()

	-- is the object handler filtered to the current magnetized item?
	if MapWindow.MagnetPoint.name and ObjectHandleWindow.CurrentFilter == MapWindow.MagnetPoint.name then

		-- remove the filter
		ObjectHandleWindow.CurrentFilter = ""
	end

	-- remove the magnet point
	MapWindow.MagnetPoint = {}

	-- reset the compass timer
	MapWindow.compassDelta = 0

	-- current window name
	local this = "MapWindow"

	-- clear the destination label
	LabelSetText(this.. "DestinationText", L"")
end

function MapWindow.NavigatorTooltip()

	-- do we have multiple tracking elements?
	if MapWindow.MagnetPoint.tracking and #TrackingPointer.TrackWaypoints > 1 then
		
		-- show how to cycle through them
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(MapCommon.TID.CycleCompass))
	
	else -- show the turn off compass tooltip
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(MapCommon.TID.TurnOffCompass))
	end
end

function MapWindow.LocateCompass()
	
	-- is the compass active?
	if not MapWindow.MagnetPoint.x then
		return
	end

	-- do we have multiple tracking elements?
	if MapWindow.MagnetPoint.tracking and #TrackingPointer.TrackWaypoints > 1 then

		-- increase the current tracking ID
		MapWindow.MagnetPoint.trackingId = MapWindow.MagnetPoint.trackingId + 1

		-- if we reached the last target we cycle back to the first
		if MapWindow.MagnetPoint.trackingId > #TrackingPointer.TrackWaypoints then
			MapWindow.MagnetPoint.trackingId = 1
		end

		-- get the target data
		local data = TrackingPointer.TrackWaypoints[MapWindow.MagnetPoint.trackingId]

		-- change the x/y coordinates and the mobile id (the facet and the rest is always the same)
		MapWindow.MagnetPoint.x = data.x
		MapWindow.MagnetPoint.y = data.y
		MapWindow.MagnetPoint.mobileID = data.mobileId

	else -- locate the waypoint
		MapCommon.Locate(MapWindow.MagnetPoint.x, MapWindow.MagnetPoint.y, MapWindow.MagnetPoint.facet)
	end
end

function MapWindow.MagnetizeLocation(x, y, facet, itemId, mobileId)
	
	-- are we already tracking this item?
	if itemId and MapWindow.MagnetPoint.itemID == itemId then
		return
	end

	-- are we already tracking this mobile?
	if mobileId and MapWindow.MagnetPoint.mobileId == mobileId then
		return
	end

	-- are we already tracking this position?
	if MapWindow.MagnetPoint.x == x and MapWindow.MagnetPoint.y == y and MapWindow.MagnetPoint.facet == facet then
		return
	end

	-- initialize the magnet point
	MapWindow.MagnetPoint = {}

	-- store the data
	MapWindow.MagnetPoint.mobileID = mobileId
	MapWindow.MagnetPoint.itemID = itemId
	MapWindow.MagnetPoint.x = x
	MapWindow.MagnetPoint.y = y
	MapWindow.MagnetPoint.facet = facet
	
	-- is the map visible?
	if not MapCommon.IsMapVisible() then

		-- show the minimap
		MapWindow.ShowMap()

	-- is the atlas open?
	elseif MapCommon.GetActiveMap() == "AtlasWindow" then

		-- hide the atlas
		AtlasWindow.HideAtlas()
	end
end

function MapWindow.OnResizeBegin()

	-- get the current window name
	local windowName = WindowUtils.GetActiveDialog()

	-- set the minimum size of the map
	local widthMin = 350
	local heightMin = 350

	-- begin the resize process
    WindowUtils.BeginResize(windowName, "topleft", widthMin, heightMin, true, MapWindow.OnResizeEnd)
end

function MapWindow.OnResizeEnd(curWindow)

	-- get the new window height
	local windowWidth, windowHeight = WindowGetDimensions(curWindow)
	
	-- make sure the new size is within the cap
	windowWidth = math.min(windowWidth, MapWindow.WINDOW_WIDTH_MAX)
	windowHeight = math.min(windowHeight, MapWindow.WINDOW_HEIGHT_MAX)
	
	-- update the window size
	WindowSetDimensions(curWindow, windowWidth, windowHeight)

	-- update the map size
	WindowSetDimensions(curWindow .. "Map", windowWidth - MapWindow.MAP_WIDTH_DIFFERENCE, windowHeight - MapWindow.MAP_HEIGHT_DIFFERENCE)
end