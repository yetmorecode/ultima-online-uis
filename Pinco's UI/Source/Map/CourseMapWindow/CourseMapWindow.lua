----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

CourseMapWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

CourseMapWindow.X_PADDING = 16
CourseMapWindow.Y_PADDING = 76

CourseMapWindow.X_MAPPOINT_PADDING = 10
CourseMapWindow.Y_MAPPOINT_PADDING = 10

CourseMapWindow.MapPoints = {}
CourseMapWindow.isTmap = {}
CourseMapWindow.MapName = {}
CourseMapWindow.MapCompleted = {}
CourseMapWindow.ZoomLevel = {}
CourseMapWindow.TmapType = {}
CourseMapWindow.MapData = {}

CourseMapWindow.DragMapPoint = ""

CourseMapWindow.ZoomStep = 0.25
CourseMapWindow.ZoomMin = 1
CourseMapWindow.ZoomMax = 6

CourseMapWindow.WINDOWSCALE = 1.4 -- default window scale

-- course map buttons TID
CourseMapWindow.TID = 
{
	PlotCourse = 3000180,
	StopPlotting = 3000181,
	ClearCourse = 3000182
}

-- treasure map recognition TID
CourseMapWindow.TmapTID = 
{
	[1041510] = 0; -- a tattered, youthful treasure map
	[1041511] = 1; -- a tattered, plainly drawn treasure map
	[1041512] = 2; -- a tattered, expertly drawn treasure map
	[1041513] = 3; -- a tattered, adeptly drawn treasure map
	[1041514] = 4; -- a tattered, cleverly drawn treasure map
	[1041515] = 5; -- a tattered, deviously drawn treasure map
	[1063452] = 6; -- a tattered, ingeniously drawn treasure map
	[1116790] = 7; -- a tattered, diabolically drawn treasure map

	[1041516] = 0; -- a youthful treasure map
	[1041517] = 1; -- a plainly drawn treasure map
	[1041518] = 2; -- an expertly drawn treasure map
	[1041519] = 3; -- an adeptly drawn treasure map
	[1041520] = 4; -- a cleverly drawn treasure map
	[1041521] = 5; -- a deviously drawn treasure map
	[1063453] = 6; -- an ingeniously drawn treasure map
	[1116773] = 7;  -- A Diabolically Drawn Treasure Map

	[1158975] = 1; -- A Tattered Treasure Map Leading to ~1_TYPE~'s Stash
	[1158976] = 2; -- A Tattered Treasure Map Leading to ~1_TYPE~'s Supply
	[1158977] = 3; -- A Tattered Treasure Map Leading to ~1_TYPE~'s Cache
	[1158978] = 4; -- A Tattered Treasure Map Leading to ~1_TYPE~'s Hoard
	[1158979] = 5; -- A Tattered Treasure Map Leading to ~1_TYPE~'s Trove

	[1158980] = 1; -- A Treasure Map Leading to ~1_TYPE~'s Stash
	[1158981] = 2; -- A Treasure Map Leading to ~1_TYPE~'s Supply
	[1158982] = 3; -- A Treasure Map Leading to ~1_TYPE~'s Cache
	[1158983] = 4; -- A Treasure Map Leading to ~1_TYPE~'s Hoard
	[1158984] = 5; -- A Treasure Map Leading to ~1_TYPE~'s Trove
}

-- this is used to determine if a map has been decoded or not
CourseMapWindow.DecodedTids = 
{
	[1041516] = true; -- a youthful treasure map
	[1041517] = true; -- a plainly drawn treasure map
	[1041518] = true; -- an expertly drawn treasure map
	[1041519] = true; -- an adeptly drawn treasure map
	[1041520] = true; -- a cleverly drawn treasure map
	[1041521] = true; -- a deviously drawn treasure map
	[1063453] = true; -- an ingeniously drawn treasure map
	[1116773] = true;  -- A Diabolically Drawn Treasure Map

	[1158980] = true; -- A Treasure Map Leading to ~1_TYPE~'s Stash
	[1158981] = true; -- A Treasure Map Leading to ~1_TYPE~'s Supply
	[1158982] = true; -- A Treasure Map Leading to ~1_TYPE~'s Cache
	[1158983] = true; -- A Treasure Map Leading to ~1_TYPE~'s Hoard
	[1158984] = true; -- A Treasure Map Leading to ~1_TYPE~'s Trove
}

-- map name recognition TID
CourseMapWindow.MapTID = 
{
	[1041502] = { tid = 1012001, hue = 1172, facetId = 0, area = 0 }; -- for somewhere in Felucca
	[1041503] = { tid = 1012000, hue = 1165, facetId = 1, area = 0 }; -- for somewhere in Trammel
	[1060850] = { tid = 1012002, hue = 1426, facetId = 2, area = 0 }; -- for somewhere in Ilshenar
	[1060851] = { tid = 1060643, hue = 1108, facetId = 3, area = 0 }; -- for somewhere in Malas
	[1115645] = { tid = 1063258, hue = 1168, facetId = 4, area = 0 }; -- for somewhere in Tokuno Islands
	[1115646] = { tid = 1112178, hue = 1158, facetId = 5, area = 0 }; -- for somewhere in Ter Mur
	[1158985] = { tid = 1156262, hue = 1192, facetId = 5, area = 16 }; -- for somewhere in Eodon
}

-- map type name recognition TID
CourseMapWindow.MapTypeTID = 
{
	[1158986] = 1158997; -- a Mage
	[1158987] = 1158998; -- an Assassin
	[1158988] = 1158999; -- a Warrior
	[1158989] = 1159000; -- an Artisan
	[1158990] = 1159001; -- a Ranger
	[1158991] = 1159002; -- a Ranger
}

CourseMapWindow.TmapLevelToName = 
{
	[1] = 1158992; -- Stash
	[2] = 1158993; -- Supply
	[3] = 1158994; -- Cache
	[4] = 1158995; -- Hoard
	[5] = 1158996; -- Trove
}

CourseMapWindow.MapCompletedTID = 1041507 -- completed by ~1_val~

CourseMapWindow.MapSize = { width = 5120; height = 4096; squarediff = 1024 }
CourseMapWindow.CurrMapSize = { width = 5120; height = 4096 }

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function CourseMapWindow.Initialize()
	
	-- get the map item ID
    local mapId = SystemData.ActiveObject.Id

	-- current map window name
    local windowName = "CourseMapWindow" .. mapId

	-- set the map ID to the window
    WindowSetId(windowName, mapId)

	-- make sure the window get destroyed on close
	Interface.DestroyWindowOnClose[windowName] = true
    
	-- is this a vendor search map?
    if Interface.VendorSearchMap and mapId == Interface.VendorSearchMap.itemID then

		-- enable the compass to locate the vendor
		MapCommon.Locate(Interface.VendorSearchMap.x, Interface.VendorSearchMap.y, Interface.VendorSearchMap.facet)

		-- close the map
		UO_DefaultWindow.CloseDialog()

		return
	end
    
	-- reset the map data (for course map mainly)
    CourseMapWindow.MapPoints[mapId] = {}
	CourseMapWindow.MapName[mapId] = L""
	CourseMapWindow.MapData[mapId] = {}
	CourseMapWindow.isTmap[mapId] = false
	CourseMapWindow.MapCompleted[mapId] = false
	CourseMapWindow.ZoomLevel[mapId] = 1
   
    -- attach the map events to the window
    WindowRegisterEventHandler(windowName, SystemData.Events.COURSE_MAP_DATA_UPDATED, "CourseMapWindow.UpdatePoints")
    WindowRegisterEventHandler(windowName, SystemData.Events.COURSE_MAP_STATE_UPDATED, "CourseMapWindow.UpdateState")
    
	-- get the map texture data
    local width, height, textureWidth, textureHeight, textureScale = GetCourseMapWindowDimensions(mapId)
    
	-- do we have the map texture data?
    if (width ~= nil and height ~= nil and textureScale ~= nil) then

		-- resize the map texture object with the map specifics
        WindowSetDimensions(windowName, width + CourseMapWindow.X_PADDING, height + CourseMapWindow.Y_PADDING)
        WindowSetDimensions(windowName .. "Texture", width, height)
        DynamicImageSetTextureDimensions(windowName .. "Texture", textureWidth, textureHeight)
        DynamicImageSetTextureScale(windowName .. "Texture", textureScale)

		-- draw the map
        DynamicImageSetTexture(windowName .. "Texture", "CourseMap" .. mapId, 0, 0)
    end
        
    -- get the map item properties
    local data = Interface.GetItemPropertiesData(mapId)

	-- do we have the item properties?
    if data and data.PropertiesTids then 

		-- if the item has one of the possible treasure maps names, is a treasure map.
		CourseMapWindow.isTmap[mapId] = CourseMapWindow.TmapTID[data.PropertiesTids[1]]

		-- is this a treasure map and we have the map name?
		if CourseMapWindow.isTmap[mapId] then

			-- scan the other properties for the map name and completed flag
			for idx, tid in pairs(data.PropertiesTids) do

				-- is this the map name?
				if CourseMapWindow.MapTID[tid] then

					-- store the map name
					CourseMapWindow.MapName[mapId] = GetStringFromTid(CourseMapWindow.MapTID[tid].tid)

					-- store the map data info
					CourseMapWindow.MapData[mapId] = CourseMapWindow.MapTID[tid]

				-- is this the "completed by" property?
				elseif tid == CourseMapWindow.MapCompletedTID then
					
					-- flag the map as completed
					CourseMapWindow.MapCompleted[mapId] = true
				end
			end

			-- get the map type
			local typ = data.PropertiesTidsParams[2]

			-- remove the # from the tid
			typ = wstring.gsub(typ, L"#", L"")

			-- get the map type
			CourseMapWindow.TmapType[mapId] = CourseMapWindow.MapTypeTID[tonumber(typ)]

			-- map button name window
			local mapButton = windowName .. "MapName"

			-- show the map name
			ButtonSetText(mapButton, CourseMapWindow.MapName[mapId])

			-- disable the map name button if the map is completed
			ButtonSetDisabledFlag(mapButton, CourseMapWindow.MapCompleted[mapId])
			
			-- set the map name on top
			LabelSetText(windowName .. "TMapName", GetStringFromTid(CourseMapWindow.TmapType[mapId]) .. L" " .. GetStringFromTid(CourseMapWindow.TmapLevelToName[CourseMapWindow.isTmap[mapId]]))
		end
	end
  
	-- is this a treasure map?
	if CourseMapWindow.isTmap[mapId] then

		-- hide the plot course buttons
		WindowSetShowing(windowName .. "PlotToggle", false)
		WindowSetShowing(windowName .. "ClearCourse", false)
		
		-- show the atlas overlay button (if the map is not completed)
		WindowSetShowing(windowName .. "AtlasOverlay", not CourseMapWindow.MapCompleted[mapId])

		-- disable the zoom out button at start
		WindowUtils.DisableButton(windowName .. "ZoomOut", MapCommon.DisabledButtonColor)

		-- show the map name
		WindowSetShowing(windowName .. "MapName", true)

	else -- for normal maps we set the plot course buttons text
		LabelSetText(windowName .. "PlotToggle", GetStringFromTid(CourseMapWindow.TID.PlotCourse))
		LabelSetText(windowName .. "ClearCourse", GetStringFromTid(CourseMapWindow.TID.ClearCourse))

		-- disable "clear course" button (only visible while plotting a course)
		WindowSetShowing(windowName .. "ClearCourse", false)

		-- hide the pinpoint lines for non-treasure maps
		WindowSetShowing(windowName .. "TargetVLine", false)
		WindowSetShowing(windowName .. "TargetHLine", false)

		-- the zoom buttons are only available for treasure maps
		WindowSetShowing(windowName .. "ZoomIn", false)
		WindowSetShowing(windowName .. "ZoomOut", false)

		-- hide the atlas overlay button
		WindowSetShowing(windowName .. "AtlasOverlay", false)

		-- hide the map name
		WindowSetShowing(windowName .. "MapName", false)
	end
    
	-- get the current map scale
    local scale = WindowGetScale(windowName)

	-- scale the map to the default level
	WindowSetScale(windowName, scale * CourseMapWindow.WINDOWSCALE)

	-- reload the saved window scale for the treasure maps
	if CourseMapWindow.isTmap[mapId] then
		WindowUtils.LoadScale(windowName)
	end
end

function CourseMapWindow.Shutdown()

	-- get the current map ID
    local mapId = WindowGetId(SystemData.ActiveWindow.name)

	-- release the map data
    ReleaseCourseMap(mapId)

	-- clear all the map variables
    CourseMapWindow.MapPoints[mapId] = nil
	CourseMapWindow.MapName[mapId] = nil
	CourseMapWindow.isTmap[mapId] = nil
	CourseMapWindow.MapCompleted[mapId] = nil
	CourseMapWindow.ZoomLevel[mapId] = nil
	CourseMapWindow.TmapType[mapId] = nil
	CourseMapWindow.MapData[mapId] = nil
end

function CourseMapWindow.OnUpdate()

	-- get the map window name
	local this = WindowUtils.GetActiveDialog()
	
	-- get the map object ID
	local mapId = WindowGetId(this)

	-- does the player still has the map or is dragging it?
	if (not DoesPlayerHaveItem(mapId) and SystemData.DragItem.itemId ~= mapId) then
		
		-- is the map out of reach?
		if (GetDistanceFromPlayer(mapId) < 0 or GetDistanceFromPlayer(mapId) > 2) then

			-- close the map
			UO_DefaultWindow.CloseDialog()

			return
		end
	end

	-- is this a treasure map?
	if CourseMapWindow.isTmap[mapId] then
		return
	end

	-- are we plotting a course?
	if not CourseMapIsPlotting(mapId) then

		-- do we have a waypoint in motion?
		if CourseMapWindow.DragMapPoint ~= "" then

			-- make the waypoint NOT moving
			WindowSetMoving(CourseMapWindow.DragMapPoint, false)

			-- clear the moving waypoint name
			CourseMapWindow.DragMapPoint = ""
		end

		return
	end
	
	-- do we have a waypoint in motion?
	if CourseMapWindow.DragMapPoint ~= "" then

		-- has the waypoint stopped moving?
		if not WindowGetMoving(CourseMapWindow.DragMapPoint) then

			-- current waypoint name
			local windowName = CourseMapWindow.DragMapPoint

			-- get the waypoint ID
			local mapPointId = WindowGetId(CourseMapWindow.DragMapPoint)
			
			-- get the map texture size
			local textureWidth, textureHeight = WindowGetDimensions(this .. "Texture")

			-- get the waypoint relative position in the map
			local point, relativePoint, relativeTo, xOffset, yOffset = WindowGetAnchor(windowName, 1)

			-- add the map margins to the position
			xOffset = xOffset + CourseMapWindow.X_MAPPOINT_PADDING
			yOffset = yOffset + CourseMapWindow.Y_MAPPOINT_PADDING
			
			-- is the waypoint inside the map?
			if (xOffset >= 0 and xOffset <= textureWidth and yOffset >= 0 and yOffset <= textureHeight) then

				-- move the waypoint to the new position
				CourseMapMovePoint(mapId, mapPointId, xOffset, yOffset)

			else -- the waypoint is outside the map so we remove it
				CourseMapDeletePoint(mapId, mapPointId)
			end

			-- clear the moving waypoint data
			CourseMapWindow.DragMapPoint = ""			
		end
	end
end

function CourseMapWindow.UpdatePoints(forcedID)

    -- get the current map ID
	local mapId = forcedID or SystemData.ActiveObject.Id

	-- map window name
    local windowName = "CourseMapWindow" .. mapId
    
    -- get all the waypoints locations (relative to the current map section not global)
    local xPosVec, yPosVec = GetCourseMapData(mapId)

	-- clear the current waypoints
	CourseMapWindow.ClearWaypoints(mapId)

	-- do we have the arrays with the coordinates?
    if xPosVec and yPosVec then

		-- is this a treasure map?
		if CourseMapWindow.isTmap[mapId] then

			-- waypoint name
			local mapPointName = windowName .. "Point" .. 1

			-- store the waypoint data
			CourseMapWindow.MapPoints[mapId][1] = {}
			CourseMapWindow.MapPoints[mapId][1].x = xPosVec[1]
			CourseMapWindow.MapPoints[mapId][1].y = yPosVec[1]

			-- toggle the pinpoint lines based on the user settings
			WindowSetShowing(windowName .. "TargetVLine", Interface.Settings.TmapPinPointLines)
			WindowSetShowing(windowName .. "TargetHLine", Interface.Settings.TmapPinPointLines)

			-- are the pinpoint lines enabled?
			if Interface.Settings.TmapPinPointLines then

				-- reset the pinpoint lines anchors
				WindowClearAnchors(windowName .. "TargetVLine")
				WindowClearAnchors(windowName .. "TargetHLine")

				-- position the pinpoint lines
				WindowAddAnchor(windowName .. "TargetVLine", "topleft", windowName .. "Texture", "topleft", xPosVec[1], 0)
				WindowAddAnchor(windowName .. "TargetHLine", "topleft", windowName .. "Texture", "topleft", 0, yPosVec[1])

			else -- create the normal X
				CourseMapWindow.CreateWaypoint(mapId, 1, xPosVec[1], yPosVec[1])
			end

		else -- normal map

			-- scan the array to create the waypoints
			for i = 1, #xPosVec do
            
				-- store the waypoint data
				CourseMapWindow.MapPoints[mapId][i] = {}
				CourseMapWindow.MapPoints[mapId][i].x = xPosVec[i]
				CourseMapWindow.MapPoints[mapId][i].y = yPosVec[i]
            
				-- create the waypoint
				CourseMapWindow.CreateWaypoint(mapId, i, xPosVec[i], yPosVec[i])
			end
		end
    end
end

function CourseMapWindow.ClearWaypoints(mapId)

	-- map window name
    local windowName = "CourseMapWindow" .. mapId
	
	-- scan all the current waypoints
	for i = 1, table.countElements(CourseMapWindow.MapPoints[mapId]) do

		-- waypoint name
        local mapPointName = windowName .. "Point" .. i

		-- delete the waypoint
        DestroyWindow(mapPointName)
    end

	-- clear the waypoints list
    CourseMapWindow.MapPoints[mapId] = {}
end

function CourseMapWindow.CreateWaypoint(mapId, waypointID, x, y)
	
	-- map window name
    local windowName = "CourseMapWindow" .. mapId

	-- waypoint name
	local mapPointName = windowName .. "Point" .. waypointID
            
	-- create the waypoint
	CreateWindowFromTemplate(mapPointName, "MapPoint", windowName)

	-- set the waypoint ID
	WindowSetId(mapPointName, waypointID)
	
    -- is this a treasure map?
	if not CourseMapWindow.isTmap[mapId] then

		-- if is not a treasure map we show the waypoint ID
		LabelSetText(mapPointName .. "Name", towstring(waypointID))
	end
            
	-- reset the waypoint anchors
	WindowClearAnchors(mapPointName)

	-- get the current scale level for the map
	local scale = Interface.LoadSetting("CourseMapWindowSCALE", WindowGetScale(windowName))

	-- make sure the scale is capped to avoid problems
	if scale > 0.9 then
		scale = 0.9
	end

	-- scale the waypoint
	WindowSetScale(mapPointName, scale)

	-- position the waypoint in the map
	WindowAddAnchor(mapPointName, "topleft", windowName .. "Texture", "center", x, y)
end

function CourseMapWindow.UpdateState()

	-- get the current map ID
	local mapId = SystemData.ActiveObject.Id

	-- map window name
    local windowName = "CourseMapWindow" .. mapId
    
	-- do we have the gump for this map?
	if not DoesWindowExist(windowName) then

		-- release the map data and prevents further updates
		ReleaseCourseMap(mapId)

		return
	end

	-- is this a treasure map?
    if not CourseMapWindow.isTmap[mapId] then   

		-- are we plotting a course?
		if CourseMapIsPlotting(mapId) then

			-- change the button text
			LabelSetText(windowName .. "PlotToggle", GetStringFromTid(CourseMapWindow.TID.StopPlotting))

			-- change the button color
			LabelSetTextColor(windowName .. "PlotToggle", 50, 0, 0)

			-- enable "clear course" button
			WindowSetShowing(windowName .. "ClearCourse", true)

		else -- plotting disabled

			-- change the button text
			LabelSetText(windowName .. "PlotToggle", GetStringFromTid(CourseMapWindow.TID.PlotCourse))

			-- change the button color
			LabelSetTextColor(windowName .. "PlotToggle", 0, 50, 0)

			-- disable "clear course" button
			WindowSetShowing(windowName .. "ClearCourse", false)
		end
	end
end

function CourseMapWindow.PlotToggle_OnLButtonUp()
	
	-- get the map window name
	local this = WindowUtils.GetActiveDialog()
	
	-- get the map object ID
	local objectId = WindowGetId(this)

	-- do we have a valid map ID?
	if not IsValidID(objectId) then
		return
	end
	
	-- toggle the course plotting mode
	CourseMapPlotToggle(objectId)
end

function CourseMapWindow.ClearCourse_OnLButtonUp()

	-- get the map window name
	local this = WindowUtils.GetActiveDialog()
	
	-- get the map object ID
	local objectId = WindowGetId(this)

	-- do we have a valid map ID?
	if not IsValidID(objectId) then
		return
	end
	
	-- clear all the waypoints in the map
	CourseMapClearCourse(objectId)
end

function CourseMapWindow.MapPoint_OnLButtonDown()

	-- get the map window name
	local this = WindowUtils.GetActiveDialog()
	
	-- get the map object ID
	local objectId = WindowGetId(this)

	-- do we have a valid map ID?
	if not IsValidID(objectId) then
		return
	end

	-- are we plotting a course?
	if CourseMapIsPlotting(objectId) then

		-- set the current waypoint as "being dragged"
		CourseMapWindow.DragMapPoint = WindowGetParent(SystemData.ActiveWindow.name)

		-- make the waypoint movable
		WindowSetMoving(CourseMapWindow.DragMapPoint, true)

	else -- make the map movable
		WindowSetMoving(this, true)
	end
end

function CourseMapWindow.Map_OnLButtonDown()
	
	-- get the map window name
	local this = WindowUtils.GetActiveDialog()
	
	-- get the map object ID
	local objectId = WindowGetId(this)

	-- do we have a valid map ID?
	if not IsValidID(objectId) then
		return
	end
	
	-- are we plotting a course?
	if not CourseMapIsPlotting(objectId) then

		-- if we're not plotting a course, then we are just moving the map around
		WindowSetMoving(this, true)
	end
end

function CourseMapWindow.Map_OnLButtonUp(flags, x, y)

	-- get the map window name
	local this = WindowUtils.GetActiveDialog()
	
	-- get the map object ID
	local objectId = WindowGetId(this)

	-- do we have a valid map ID?
	if not IsValidID(objectId) then
		return
	end
	
	-- are we plotting a course?
	if CourseMapIsPlotting(objectId) == true then

		-- get the current window scale
		local scale = WindowGetScale(this)

		-- draw the waypoint in the clicked location
		CourseMapAddPoint(objectId, x / scale, y / scale)

	else -- if we're not plotting a course, then we're just moving the map around and we can stop moving it
		WindowSetMoving(this, false)
	end
end

function CourseMapWindow.OnMapNameOver()

	-- get the map window name
	local this = WindowUtils.GetActiveDialog()
	
	-- get the map object ID
	local objectId = WindowGetId(this)

	-- do we have a valid map ID?
	if not IsValidID(objectId) then
		return
	end

	-- are we already seeing the item properties of that item?
	if objectId ~= WindowGetId("ItemProperties") and WindowGetShowing("ItemProperties") then

		-- reset the item properties array
		ItemProperties.ResetWindowDataPropertiesFull()
	end
			
	-- creating the item properties info data
	local itemData = 
	{ 
		windowName = SystemData.ActiveWindow.name,
		itemId = objectId,
		itemType = WindowData.ItemProperties.TYPE_ITEM
	}
	-- show the map item properties
	ItemProperties.SetActiveItem(itemData)
end

function CourseMapWindow.OnMapNameLClick()

	-- get the map window name
	local this = WindowUtils.GetActiveDialog()

	-- button window name
	local btn = SystemData.ActiveWindow.name
	
	-- get the map object ID
	local objectId = WindowGetId(this)

	-- do we have a valid map ID?
	if not IsValidID(objectId) then
		return
	end

	-- is the button enabled? (is disabled when the map is completed)
	if not ButtonGetDisabledFlag(btn) then

		-- execute the dig action for this map
		ContextMenu.RequestContextAction(objectId, ContextMenu.DefaultValues.DigForTreasure)

		-- do we have to dig automatically at the player location?
		if Interface.Settings.TmapDigPlayerLocation then

			-- target the player when we get the cursor target
			Interface.ExecuteWhenAvailable(
			{
				name = "TmapAutoTarget",
				check = function() return DoesPlayerHasCursorTarget() end, 
				callback = function() HandleSingleLeftClkTarget(GetPlayerID()) end,
				removeOnComplete = true,
				maxTime = Interface.TimeSinceLogin + 2,
				dealay = Interface.TimeSinceLogin + 0.5,
			})
		end
	end
end

function CourseMapWindow.OnMapNameRClick()

	-- get the map window name
	local this = WindowUtils.GetActiveDialog()

	-- get the map object ID
	local objectId = WindowGetId(this)

	-- do we have a valid map ID?
	if not IsValidID(objectId) then
		return
	end

	-- target the map
	HandleSingleLeftClkTarget(objectId)
end

function CourseMapWindow.ZoomIn()
	CourseMapWindow.ZoomMap(_, _, 2)
end

function CourseMapWindow.ZoomOut()
	CourseMapWindow.ZoomMap(_, _, -2)
end

function CourseMapWindow.ZoomMap(x, y, delta, flags)

	-- get the map window name
	local this = WindowUtils.GetActiveDialog()

	-- get the map object ID
	local objectId = WindowGetId(this)

	-- do we have a valid map ID?
	if not IsValidID(objectId) then
		return
	end

	-- make sure is a treasure map
	if not CourseMapWindow.isTmap[objectId] then
		return
	end

	-- determine the next scale level (delta can be only 1 or -1 depending on if we scroll up or down)
	local scale = CourseMapWindow.ZoomLevel[objectId] + (delta * CourseMapWindow.ZoomStep)

	-- reset the zoom buttons
	WindowUtils.EnableButton(this .. "ZoomOut")
	WindowUtils.EnableButton(this .. "ZoomIn")

	-- make sure the scale is not less than the minimum level
	if scale <= CourseMapWindow.ZoomMin then
		scale = CourseMapWindow.ZoomMin

		-- toggle the zoom buttons availability
		WindowUtils.EnableButton(this .. "ZoomIn")
		WindowUtils.DisableButton(this .. "ZoomOut", MapCommon.DisabledButtonColor)
	end

	-- make sure the scale is not higher than the maximum level
	if scale >= CourseMapWindow.ZoomMax then
		scale = CourseMapWindow.ZoomMax
			
		-- toggle the zoom buttons availability
		WindowUtils.DisableButton(this .. "ZoomIn", MapCommon.DisabledButtonColor)
		WindowUtils.EnableButton(this .. "ZoomOut")
	end

	-- set the zoom level
	CourseMapWindow.SetZoom(objectId, scale)
end

function CourseMapWindow.SetZoom(objectId, scale)

	-- get the map window name
	local this = "CourseMapWindow" .. objectId

	-- map texture window
	local mapTexture = this .. "Texture"

	-- get the map texture data
	local width, height, textureWidth, textureHeight, textureScale = GetCourseMapWindowDimensions(objectId)

	-- do we have the map texture data?
    if (width ~= nil and height ~= nil and textureScale ~= nil) then

		-- scale the texture
		DynamicImageSetTextureDimensions(mapTexture, math.round(textureWidth / scale), math.round(textureHeight / scale))

		-- update the stored scale level
		CourseMapWindow.ZoomLevel[objectId] = scale

		-- get the treasure relative location
		local point = CourseMapWindow.MapPoints[objectId][1]

		-- make sure the treasure location has been loaded or we can't do anything here
		if not point then
			return
		end

		-- calculate the distance between the point and the map center
		local distX = point.x - (width * 0.5)
		local distY = point.y - (height * 0.5)

		-- calculate the map size difference between the original and the new scaled size
		local offsetX = width - math.round(width / scale)
		local offsetY = height - math.round(height / scale)

		-- now we calculate how much we need to shift the map in order to see the treasure location
		offsetX = math.round(offsetX + ((2 * ( (distX * scale) - distX )) / scale))
		offsetY = math.round(offsetY + ((2 * ( (distY * scale) - distY )) / scale))

		-- shift the map correctly
		DynamicImageSetTexture(mapTexture, "CourseMap" .. objectId, offsetX, offsetY)
	end
end

function CourseMapWindow.UpdateAllTMaps()

	-- scan the treasure map currently open
	for mapId, _ in pairs(CourseMapWindow.isTmap) do

		-- update the map points
		CourseMapWindow.UpdatePoints(mapId)
	end
end

function CourseMapWindow.Test(scale)

	-- scan the treasure map currently open
	for mapId, _ in pairs(CourseMapWindow.isTmap) do

		-- update the map points
		CourseMapWindow.SetZoom(mapId, scale)
	end
end