----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

MapCommon = {}

MapCommon.MAP_HIDDEN = "hidden"
MapCommon.MAP_RADAR = "radar"
MapCommon.MAP_ATLAS = "atlas"

MapCommon.TID = 
{
	Waypoints = 1078474, 
	WorldMap = 1077438, 
	YourLocation = 1078897,
	CreateWaypoint = 1079482, 
	EditWaypoint = 1079483, 
	DeleteWaypoint = 1079484, 
	ViewWaypoint = 1079571, 
	Close = 1052061,
	Atlas = 1111703, 
	ShowLegend = 1111706, 
	ZoomOut = 1079289, 
	ZoomIn = 1079288, 
	TiltMap = 1154867,
	ShowRadar = 1112106, 
	ShowAtlas = 1112107,
	WaypointsFilter = 554,
	WaypointHere = 1079482,
	You = 1154864,
	AtlasOverlay = 558,
	AtlasOverlayInfo = 559,
	XTooltip = 560,
	LocateWaypoint = 561,
	Magnetize = 1154860,
	WaypointName = 1079514,
	Icon = 562,
	X = 1112100, 
	Y = 1112101,
	XY = 563,
	LatLong = 564,
	Lat = 1080540, 
	Long = 1080541,
	North = 565,
	South = 566,
	West = 567,
	West = 567,
	East = 568,
	SelectAFacet = 1079512,
	CreateWaypointHere = 1077852,
	EditWaypointHere = 1150647,
	Cancel = 1152889,
	InvalidWaypointName = 569,
	InvalidWaypointCoordinates = 570,
	NoWaypointsFound = 571,
	TotalFound = 572,
	Distance = 1154863,
	DistanceMoongate = 574,
	Arrived = 573,
	TurnOffCompass = 575,
	CycleCompass = 576,
	CenterOnPlayer = 1112059,
}

MapCommon.IconsData  = 
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
	{ id  = 100113, name = L"Treasure Mark"},
	{ id  = 100114, name = L"Party"},
	{ id  = 100115, name = L"Pillar"},
	{ id  = 100116, name = L"Sunken Ship"},
	{ id  = 100117, name = L"Stairs"},
	{ id  = 100118, name = L"Target"},
	{ id  = 100119, name = L"Teleporter"},
	{ id  = 100120, name = L"Waves"},
	{ id  = 100121, name = L"X"},
}

MapCommon.NumFacets = 6

MapCommon.ZoomStep = 0.25
MapCommon.ZoomMin = -2
MapCommon.ZoomMax = 
{
	["MapWindow"] = 0.5,
	["AtlasWindow"] = 0.8,
}

-- any waypoint icon smaller than this value, will be considered a local icon
MapCommon.LocalIconsScale = 0.6

-- max zoom levels for local icons (all the local icons will be hidden with a higher zoom level)
MapCommon.ZoomMaxLocalIcons = 0

-- minimum size a waypoint can be scaled
MapCommon.MinIconScale = 0.35

-- max size a name tag can be scaled
MapCommon.MaxNameTagScale = 0.41

MapCommon.Tilt = 45

MapCommon.CreatedWaypoints = {}
MapCommon.CreatedServerLines = {}

-- waypoints ID range
MapCommon.WaypointIDRange = {}
MapCommon.WaypointIDRange.Player = { min = 0, max = 0 }
MapCommon.WaypointIDRange.Default = { min = 1, max = 9999 }
MapCommon.WaypointIDRange.UI = { min = 10000, max = 19997 }
MapCommon.WaypointIDRange.VendorSearch = { min = 19998, max = 19998 }
MapCommon.WaypointIDRange.Charybdis = { min = 19999, max = 19999 }
MapCommon.WaypointIDRange.Custom = { min = 20000, max = 29999 }
MapCommon.WaypointIDRange.SOS = { min = 30000, max = 39999 }
MapCommon.WaypointIDRange.Tmap = { min = 40000, max = 49999 }
MapCommon.WaypointIDRange.Tracking = { min = 50000, max = 69999 }


MapCommon.WaypointFilters = 
{
	[1] =  { name = "player_party_names", tid = 557 },
	[2] =  { name = "corpse", tid = 1028198, icons = { 100043 } },
	[3] =  { name = "party", tid = 1075670, icons = { 100118 } },
	[4] =  { name = "quest_giver", tid = 1078400, icons = { 100122 } },
	[5] =  { name = "wandering_healer", tid = 1079190, icons = { 100012, 100013, 100014 } },
	[6] =  { name = "champion_spawns", tid = 1113127, icons = { 1113127 } },
	[7] =  { name = "dungeon", tid = 1078373, icons = { 100000, 100045, 100107, 100117, 100121 } },
	[8] =  { name = "player", tid = 1078897, icons = { 100021, 100022, 100023 } },
	[9] =  { name = "points_of_interest", tid = 556, icons = { 100042, 100051, 100053, 100060, 100094, 100110 } },
	[10] = { name = "shops", tid = 1078375, icons = { 100033, 100034, 100035, 100036, 100037, 100038, 100039, 100040, 100041, 100046, 100047, 100048, 100049, 100050, 100052, 100054, 100056, 100057, 100058, 100061, 100062, 100063, 100064, 100065, 100108, 100109, 100112 } },
	[11] = { name = "server_lines", tid = 3511 },
}

MapCommon.WaypointCorpse = 1
MapCommon.WaypointParty = 2
MapCommon.WaypointSpecial = 3
MapCommon.WaypointQuest = 4
MapCommon.WaypointNewPlayerQuest = 5
MapCommon.WaypointHealer = 6
MapCommon.WaypointDanger = 7
MapCommon.WaypointPointsOfInterest = 8
MapCommon.WaypointCity = 9
MapCommon.WaypointDungeon = 10
MapCommon.WaypointShrine = 11
MapCommon.WaypointMoongate = 12
MapCommon.WaypointShop = 13
MapCommon.WaypointPlayerType = 14
MapCommon.WaypointCustomType = 15

MapCommon.WaypointsDataByType = 
{
	[1] =  { scale = 1;		iconId = 100006;	moving = false;		layer = Window.Layers.OVERLAY; },
	[2] =  { scale = 0.65;	iconId = 100114;	moving = true;		layer = Window.Layers.SECONDARY; },
	[3] =  { scale = 1;		iconId = 100032;	moving = false;		layer = Window.Layers.DEFAULT; },
	[4] =  { scale = 1;		iconId = 100122;	moving = true;		layer = Window.Layers.SECONDARY; },
	[5] =  { scale = 1;		iconId = 100030;	moving = false;		layer = Window.Layers.DEFAULT; },
	[6] =  { scale = 1;		iconId = 100012;	moving = true;		layer = Window.Layers.OVERLAY; },
	[7] =  { scale = 1;		iconId = 100002;	moving = false;		layer = Window.Layers.DEFAULT; },
	[8] =  { scale = 1;		iconId = 100002;	moving = false;		layer = Window.Layers.DEFAULT; },
	[9] =  { scale = 1;		iconId = 100005;	moving = false;		layer = Window.Layers.DEFAULT; },
	[10] = { scale = 1;		iconId = 100011;	moving = false;		layer = Window.Layers.DEFAULT; },
	[11] = { scale = 1;		iconId = 100027;	moving = false;		layer = Window.Layers.DEFAULT; },
	[12] = { scale = 1;		iconId = 100015;	moving = false;		layer = Window.Layers.DEFAULT; },
	[13] = { scale = 1;		iconId = 100026;	moving = false;		layer = Window.Layers.DEFAULT; },
	[14] = { scale = 1;		iconId = 100022;	moving = true;		layer = Window.Layers.OVERLAY; },
	[15] = { scale = 1;		iconId = 100022;	moving = false;		layer = Window.Layers.DEFAULT; },
}

MapCommon.WaypointIsMouseOver = false

MapCommon.ContextReturnCodes = {}
MapCommon.ContextReturnCodes.CREATE_WAYPOINT = 0
MapCommon.ContextReturnCodes.EDIT_WAYPOINT = 1
MapCommon.ContextReturnCodes.DELETE_WAYPOINT = 2
MapCommon.ContextReturnCodes.MAGNETIZE = 3

MapCommon.ContextReturnCodes.NO_FILTERS = 5
MapCommon.ContextReturnCodes.ALL_FILTERS = 6
MapCommon.ContextReturnCodes.DISABLE_FILTER = 7

MapCommon.sextantDefaultCenterX = 1323
MapCommon.sextantDefaultCenterY = 1624

MapCommon.sextantLostLandCenterX = 5936
MapCommon.sextantLostLandCenterY = 3112

MapCommon.sextantLostLandTopLeftX = 5120
MapCommon.sextantLostLandTopLeftY = 2304

MapCommon.sextantLostLandBottomRightX = 6144
MapCommon.sextantLostLandBottomRightY = 4096

MapCommon.sextantMaximumX = 5120;
MapCommon.sextantMaximumY = 4096;

MapCommon.sextantFeluccaLostLands = 14
MapCommon.sextantTrammelLostLands = 13

MapCommon.RefreshDelta = 0
MapCommon.RefreshDelay = 0.5
MapCommon.WaypointUpdateRequest = false

-- if x, or y are missing, it means the line run all the way through that axis
-- the start point is always the border
-- if the endpoint is missing, it means it runs through all the map
-- { map, x, y, endpoint }
MapCommon.ServerLines = 
{
	[1]  = { map = 0, x = 2687, endpoint = { x = 2687, y = 4096 } },
	[2]  = { map = 1, x = 2687, endpoint = { x = 2687, y = 4096 } },
	[3]  = { map = 0, y = 1279, endpoint = { x = 2687, y = 1279 } },
	[4]  = { map = 1, y = 1279, endpoint = { x = 2687, y = 1279 } },
	[5]  = { map = 0, x = 1550, endpoint = { x = 1550, y = 1279 } },
	[6]  = { map = 1, x = 1550, endpoint = { x = 1550, y = 1279 } },
	[7]  = { map = 0, y = 2032, endpoint = { x = 2687, y = 2032 } },
	[8]  = { map = 1, y = 2032, endpoint = { x = 2687, y = 2032 } },
	[9]  = { map = 0, x = 3850, endpoint = { x = 3850, y = 4096 } },
	[10] = { map = 1, x = 3850, endpoint = { x = 3850, y = 4096 } },
	[11] = { map = 3, y = 1024 },
	[12] = { map = 4, y = 751 },
}

MapCommon.MapTidToID = 
{
	[1012001] = 0, -- Felucca
	[1012000] = 1, -- Trammel
	[1012002] = 2, -- Ilshenar
	[1060643] = 3, -- Malas
	[1063258] = 4, -- Tokuno Islands
	[1112178] = 5, -- Ter Mur
	[1156262] = 5, -- Eodon
}

MapCommon.MapIDToTid = 
{
	[0] = 1012001, -- Felucca
	[1] = 1012000, -- Trammel
	[2] = 1012002, -- Ilshenar
	[3] = 1060643, -- Malas
	[4] = 1063258, -- Tokuno Islands
	[5] = 1112178, -- Ter Mur
}

MapCommon.MapSize = 
{
	[0] = { width = 5120; height = 4096 }, -- felucca (without lost lands)
	[1] = { width = 5120; height = 4096 }, -- trammel (without lost lands)
	[2] = { width = 2304; height = 1600 }, -- ilshenar
	[3] = { width = 2560; height = 2048 }, -- malas
	[4] = { width = 1448; height = 1448 }, -- tokuno
	[5] = { width = 1280; height = 4096 }, -- termur
}

-- areas that are considered valley of eodon
MapCommon.EodonCoordinates = 
{
	{ map = 5, x = 68, y = 1350, x2 = 754, y2 = 1903 },
	{ map = 5, x = 604, y = 1970, x2 = 950, y2 = 2206 },
}

MapCommon.DisabledButtonColor = { r = 255, g = 205, b = 155 }

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function MapCommon.Update(timePassed)

	-- do we have the mouse over a waypoint that is not there anymore?
	if MapCommon.WaypointMouseOverName and not DoesWindowExist(MapCommon.WaypointMouseOverName) then

		-- remove the tooltip
		MapCommon.WaypointMouseOverEnd()
	end

	-- make sure a map is visible
	if not MapCommon.IsMapVisible() then
		return
	end

	-- make sure only 1 map stays visible
	if WindowGetShowing("AtlasWindow") and WindowGetShowing("MapWindow") then

		-- hide the atlas
		AtlasWindow.HideAtlas()
	end

	-- increase the waypoints update timer
	MapCommon.RefreshDelta = MapCommon.RefreshDelta + timePassed
		
	-- is it time to update the waypoints?
	if MapCommon.RefreshDelta >= MapCommon.RefreshDelay or MapCommon.WaypointsDirty then

		-- reset the timer
		MapCommon.RefreshDelta = 0

		-- do we need to update all the waypoints or we must do it forcefully?
		if MapCommon.WaypointUpdateRequest or MapCommon.WaypointsDirty then

			-- reset the flag
			MapCommon.WaypointsDirty = nil

			-- update the waypoints
			MapCommon.UpdateWaypoints()

		else -- update only the waypoints that are not static (like players, healers, quest givers, etc..)
			MapCommon.UpdateMovingWaypoints()
		end
	end

	-- are we looking at a waypoint info?
	if WindowGetShowing("WaypointInfo") then

		-- waypoint info window
		local waypointTooltip = "WaypointInfo"

		-- get the waypoint window name
		local waypoint = MapCommon.WaypointMouseOverName

		-- get the waypoint data
		local waypointData = MapCommon.CreatedWaypoints[waypoint]
	
		-- do we have the waypoint data?
		if not waypointData then
			return
		end

		-- get the waypoint coordinates
		local waypointX = waypointData.wx
		local waypointY = waypointData.wy
		local waypointFacet = waypointData.wfacet

		-- calculate the waypoint latitude and longitude
		local latStr, longStr, latDir, longDir = MapCommon.GetSextantLocationStrings(waypointX, waypointY, waypointFacet)
	
		-- create the sextant string (with x and y in the second line)
		local sextant = latStr .. L"'" .. latDir .. L" " .. longStr .. L"'" .. longDir .. L"\n(" .. math.floor(waypointX) .. L", " .. math.floor(waypointY) .. L")"

		-- set the waypoint location text
		LabelSetText(waypointTooltip .. "Location", sextant)
	end
end

function MapCommon.SetZoom(zoomLevel)

	-- make sure the map is visible
	if MapCommon.IsMapVisible() then

		-- get the map we are zooming (atlas or minimap)
		local currentMapWindow = MapCommon.GetActiveMap()

		-- calculate the new zoom level
		MapCommon.ZoomCurrent[currentMapWindow] = zoomLevel

		-- reset the zoom buttons availability for minimap
		WindowUtils.EnableButton(currentMapWindow .. "ZoomInButton")
		WindowUtils.EnableButton(currentMapWindow .. "ZoomOutButton")

		-- is the zoom lower than the min possible?
		if MapCommon.ZoomCurrent[currentMapWindow] <= MapCommon.ZoomMin then

			-- set the zoom level to the cap
			MapCommon.ZoomCurrent[currentMapWindow] = MapCommon.ZoomMin

			WindowUtils.DisableButton(currentMapWindow .. "ZoomInButton", MapCommon.DisabledButtonColor)
			WindowUtils.EnableButton(currentMapWindow .. "ZoomOutButton")
		end

		-- is the zoom higher than the max possible?
		if MapCommon.ZoomCurrent[currentMapWindow] >= MapCommon.ZoomMax[currentMapWindow] then
			
			-- set the zoom level to the cap
			MapCommon.ZoomCurrent[currentMapWindow] = MapCommon.ZoomMax[currentMapWindow]

			-- toggle the zoom buttons availability for minimap
			WindowUtils.EnableButton(currentMapWindow .. "ZoomInButton")
			WindowUtils.DisableButton(currentMapWindow .. "ZoomOutButton", MapCommon.DisabledButtonColor)
		end

		-- update the map zoom
		UOSetRadarZoom(MapCommon.ZoomCurrent[currentMapWindow])
		
		-- save the new zoom value
		Interface.SaveSetting(currentMapWindow .. "Zoom", MapCommon.ZoomCurrent[currentMapWindow])

		-- update waypoints
		MapCommon.WaypointsDirty = true
	end
end

function MapCommon.AdjustZoom(zoomDelta)

	-- make sure the map is visible
	if MapCommon.IsMapVisible() then

		-- get the map we are zooming (atlas or minimap)
		local currentMapWindow = WindowUtils.GetActiveDialog()
		
		-- if we don't have a current map window, we use the minimap as default
		if not currentMapWindow or (currentMapWindow ~= "MapWindow" and currentMapWindow ~= "AtlasWindow") then

			-- is the minimap visible?
			if WindowGetShowing("MapWindow") then
				currentMapWindow = "MapWindow"

			else -- use the atlas
				currentMapWindow = "AtlasWindow"
			end
		end
		
		-- calculate at which % the zoom currently is
		local currZoomPerc = 1 - ((MapCommon.ZoomCurrent[currentMapWindow] + 2) / (MapCommon.ZoomMax[currentMapWindow] + 2))

		-- scale the step based on the percent (otherwise when the zoom is too high it will be too fast)
		local step = MapCommon.ZoomStep * currZoomPerc

		-- cap the step to 0.01 or it will get stuck when near ther max
		if step < 0.01 then
			step = 0.01
		end

		-- calculate the new zoom level
		MapCommon.ZoomCurrent[currentMapWindow] = math.round(MapCommon.ZoomCurrent[currentMapWindow] + (zoomDelta * step), 2)

		-- reset the zoom buttons availability for minimap
		WindowUtils.EnableButton(currentMapWindow .. "ZoomInButton")
		WindowUtils.EnableButton(currentMapWindow .. "ZoomOutButton")

		-- is the zoom lower than the min possible?
		if MapCommon.ZoomCurrent[currentMapWindow] <= MapCommon.ZoomMin then

			-- set the zoom level to the cap
			MapCommon.ZoomCurrent[currentMapWindow] = MapCommon.ZoomMin

			WindowUtils.DisableButton(currentMapWindow .. "ZoomInButton", MapCommon.DisabledButtonColor)
			WindowUtils.EnableButton(currentMapWindow .. "ZoomOutButton")
		end

		-- is the zoom higher than the max possible?
		if MapCommon.ZoomCurrent[currentMapWindow] >= MapCommon.ZoomMax[currentMapWindow] then
			
			-- set the zoom level to the cap
			MapCommon.ZoomCurrent[currentMapWindow] = MapCommon.ZoomMax[currentMapWindow]

			-- toggle the zoom buttons availability for minimap
			WindowUtils.EnableButton(currentMapWindow .. "ZoomInButton")
			WindowUtils.DisableButton(currentMapWindow .. "ZoomOutButton", MapCommon.DisabledButtonColor)
		end

		-- update the map zoom
		UOSetRadarZoom(MapCommon.ZoomCurrent[currentMapWindow])
		
		-- save the new zoom value
		Interface.SaveSetting(currentMapWindow .. "Zoom", MapCommon.ZoomCurrent[currentMapWindow])

		-- update waypoints
		MapCommon.WaypointsDirty = true

		-- is the current map the atlas?
		if currentMapWindow == "AtlasWindow" then

			-- store the current zom
			local zoom = MapCommon.ZoomCurrent[currentMapWindow]

			-- wait a bit then update the waypoints filter (if the zoom is changed)
			Interface.ExecuteWhenAvailable({name = "RefreshWaypointFilter", check = function() return zoom ~= MapCommon.ZoomCurrent[currentMapWindow] end, callback = function() AtlasWindow.UpdateVisibleWaypointsSearch() end, maxTime = Interface.TimeSinceLogin + 1, delay = Interface.TimeSinceLogin + 0.5, removeOnComplete = true})
		end
	end
end

function MapCommon.IsMapVisible(minimapOnly)
	
	-- do we need to check only for the minimap?
	if minimapOnly and WindowGetShowing("MapWindow") then
		return true
	end

	return WindowGetShowing("MapWindow") or WindowGetShowing("AtlasWindow")
end

function MapCommon.GetActiveMap()
	
	-- is the minimap visible?
	if WindowGetShowing("MapWindow") then
		return "MapWindow"

	-- is the atlas visible?
	elseif WindowGetShowing("AtlasWindow") then
		return "AtlasWindow"
	end
end

function MapCommon.UpdateMovingWaypoints()
	
	-- determine which type of map is visible
	local currWindow = MapCommon.GetActiveMap()

	-- make sure the window we are updating is the minimap or the atlas
	if not currWindow or (currWindow ~= "MapWindow" and currWindow ~= "AtlasWindow") then
		return
	end

	-- count how many filters are active
	local _, activeFiltersCount = string.gsub(Interface.Settings[currWindow .. "_WPFilters"], "1", "")

	-- all the waypoints are disabled, so we can get out
	if activeFiltersCount == 0 then
		return
	end

	-- get the current facet
	local facet = UOGetRadarFacet()

	-- get the current area
    local area = UOGetRadarArea()

	-- fix the facet for certain areas.
    if (facet == 5 and (area == 2 or area == 7)) then
		facet = 0
	end
	
	-- initialize the aray for the new list of waypoints
	local newWaypoints = {}
	
	-- get the player waypoint
	newWaypoints = MapCommon.GetPlayerWaypoint(currWindow, facet, area, newWaypoints)

	-- get the default waypoints
	newWaypoints = MapCommon.GetDefaultMovingWaypoints(currWindow, facet, area, newWaypoints)

	-- get the tracking waypoints
	newWaypoints = MapCommon.GetTrackingWaypoints(currWindow, facet, area, newWaypoints)

	-- delete all the waypoints that are no longer visible
	MapCommon.DeleteMismatchingWaypoints(currWindow, newWaypoints, true)

	-- update the current waypoints position (if necessary)
	MapCommon.UpdateWaypointsPosition(currWindow)

	-- create the waypoints that does not exist yet
	MapCommon.CreateMissingWaypoints(currWindow, newWaypoints)

	-- update the waypoints scale
	MapCommon.UpdateWaypointsScale(currWindow)
end

function MapCommon.UpdateWaypoints()

	-- determine which type of map is visible
	local currWindow = MapCommon.GetActiveMap()

	-- make sure the window we are updating is the minimap or the atlas
	if not currWindow or (currWindow ~= "MapWindow" and currWindow ~= "AtlasWindow") then
		return
	end

	-- count how many filters are active
	local _, activeFiltersCount = string.gsub(Interface.Settings[currWindow .. "_WPFilters"], "1", "")

	-- all the waypoints are disabled, so we can get out
	if activeFiltersCount == 0 then
		return
	end

	-- get the current facet
	local facet = UOGetRadarFacet()

	-- get the current area
    local area = UOGetRadarArea()
	
	-- fix the facet for certain areas.
    if (facet == 5 and (area == 2 or area == 7)) then
		facet = 0
	end
	
	-- initialize the aray for the new list of waypoints
	local newWaypoints = {}

	-- get the player waypoint
	newWaypoints = MapCommon.GetPlayerWaypoint(currWindow, facet, area, newWaypoints)

	-- get the default waypoints
	newWaypoints = MapCommon.GetDefaultWaypoints(currWindow, facet, area, newWaypoints)
	
	-- get the UI waypoints
	newWaypoints = MapCommon.GetWaypoints(currWindow, facet, area, newWaypoints)

	-- get the custom waypoints
	newWaypoints = MapCommon.GetCustomWaypoints(currWindow, facet, area, newWaypoints)
	
	-- get the SOS waypoints
	newWaypoints = MapCommon.GetSOSWaypoints(currWindow, facet, area, newWaypoints)

	-- get the tmap waypoints
	newWaypoints = MapCommon.GetTmapWaypoints(currWindow, facet, area, newWaypoints)

	-- get the tracking waypoints
	newWaypoints = MapCommon.GetTrackingWaypoints(currWindow, facet, area, newWaypoints)
	
	-- delete all the waypoints that are no longer visible
	MapCommon.DeleteMismatchingWaypoints(currWindow, newWaypoints)

	-- update the current waypoints position (if necessary)
	MapCommon.UpdateWaypointsPosition(currWindow)

	-- create the waypoints that does not exist yet
	MapCommon.CreateMissingWaypoints(currWindow, newWaypoints)

	-- update the waypoints scale
	MapCommon.UpdateWaypointsScale(currWindow)

	-- draw the server lines
	MapCommon.DrawServerLine(currWindow, facet)
end

function MapCommon.GetPlayerWaypoint(currWindow, facet, area, newWaypoints)

	-- make sure the window we are updating is the minimap or the atlas
	if not currWindow or (currWindow ~= "MapWindow" and currWindow ~= "AtlasWindow") then
		return newWaypoints
	end

	-- get the waypoint ID
	local waypointId = MapCommon.WaypointIDRange.Player.min

	-- get the waypoint data
	local wtype = MapCommon.WaypointPlayerType
	local wname = GetStringFromTid(MapCommon.TID.You)
	local wfacet = WindowData.PlayerLocation.facet
	local wx = WindowData.PlayerLocation.x
	local wy = WindowData.PlayerLocation.y
	local wz = WindowData.PlayerLocation.z

	-- tokuno dungeons are in malas and we need to fix the player position in order to see them
    if (facet == 4 and wfacet == 3) then
		wfacet = 4
	end

	-- get the waypoint icon based on the type (only for default waypoints)
	local iconId = MapCommon.WaypointsDataByType[wtype].iconId or 100002

	-- get the default icon scale
	local iconDefaultScale = MapCommon.WaypointsDataByType[wtype].scale

	-- is the waypoint in the visible area?
	if not MapCommon.IsWaypointVisible(currWindow, wtype, wx, wy, wfacet, iconId) then
		return newWaypoints
	end

	-- initialize the waypoint window name
	local waypoint = currWindow .. "Waypoint" .. waypointId

	-- add the waypoint to the table
	newWaypoints[waypoint] = { waypointId = waypointId, wtype = wtype, wflags = wflags, wname = towstring(wname), wfacet = wfacet, wx = wx, wy = wy, wz = wz, iconId = iconId, iconDefaultScale = iconDefaultScale }
	
	return newWaypoints
end

function MapCommon.GetDefaultMovingWaypoints(currWindow, facet, area, newWaypoints)

	-- make sure the window we are updating is the minimap or the atlas
	if not currWindow or (currWindow ~= "MapWindow" and currWindow ~= "AtlasWindow") then
		return newWaypoints
	end

	-- get the default waypoints list for the current facet
	UOSetWaypointMapFacet(facet) 

	-- scan all the default waypoints
	for waypointId = MapCommon.WaypointIDRange.Default.min, WindowData.WaypointList.waypointCount do

		-- get the waypoint data
		local wtype, wflags, wname, wfacet, wx, wy, wz = UOGetWaypointInfo(waypointId)

		-- if the waypoint has no name we will ignore it
		if not wname then
			continue
		end

		-- moongates are already included into the UI waypoints
		if wtype == MapCommon.WaypointMoongate then
			continue
		end

		-- is this a waypoint that can move around?
		if not MapCommon.WaypointsDataByType[wtype].moving then
			continue
		end

		-- is this a party waypoint?
		if wtype == MapCommon.WaypointParty then

			-- remove the quotes from party names
			wname = FormatProperly(wstring.gsub(wname, L"\"", L""))
		end

		-- get the waypoint icon based on the type (only for default waypoints)
		local iconId = MapCommon.WaypointsDataByType[wtype].iconId or 100002

		-- get the default icon scale
		local iconDefaultScale = MapCommon.WaypointsDataByType[wtype].scale

		-- is this the sea market waypoint?
		if (wname == L"Sea Market" and (wfacet == 1 or wfacet == 0)) then

			-- replace with the city icon
			iconId = 100042
		end

		-- there is a shrine of wisdom in the wrong facet, we are going to ignore it
		if wname == L"Shrine of Wisdom" and wfacet == 4 then
			continue
		end

		-- if the waypoint is custom we ignore it (this kind of waypoints are from the old system)
		if wtype == MapCommon.WaypointCustomType then
			continue
        end

		-- if this waypoint marks a dungeon, we don't need it, because we have it in the internal waypoints db
		if wtype == MapCommon.WaypointDungeon then
			continue
        end

		-- if the icon default scale is less than 0.6 and the current zoom is greater than -0.5, we hide the icon. Quest icons will be included even if the scale is higher
		if (iconDefaultScale < MapCommon.LocalIconsScale or wtype == MapCommon.WaypointQuest) and MapCommon.ZoomCurrent[currWindow] > MapCommon.ZoomMaxLocalIcons then
			continue
		end

		-- is the waypoint in the visible area?
		if not MapCommon.IsWaypointVisible(currWindow, wtype, wx, wy, wfacet, iconId) then
			continue
		end

		-- initialize the waypoint window name
		local waypoint = currWindow .. "Waypoint" .. waypointId

		-- add the waypoint to the table
		newWaypoints[waypoint] = { waypointId = waypointId, wtype = wtype, wflags = wflags, wname = towstring(wname), wfacet = wfacet, wx = wx, wy = wy, wz = wz, iconId = iconId, iconDefaultScale = iconDefaultScale }
	end
	
	return newWaypoints
end

function MapCommon.GetDefaultWaypoints(currWindow, facet, area, newWaypoints)

	-- make sure the window we are updating is the minimap or the atlas
	if not currWindow or (currWindow ~= "MapWindow" and currWindow ~= "AtlasWindow") then
		return newWaypoints
	end

	-- get the default waypoints list for the current facet
	UOSetWaypointMapFacet(facet) 
	
	-- scan all the default waypoints
	for waypointId = MapCommon.WaypointIDRange.Default.min, WindowData.WaypointList.waypointCount do

		-- get the waypoint data
		local wtype, wflags, wname, wfacet, wx, wy, wz = UOGetWaypointInfo(waypointId)

		-- if the waypoint has no name we will ignore it
		if not wname then
			continue
		end
		
		-- moongates are already included into the UI waypoints
		if wtype == MapCommon.WaypointMoongate then
			continue
		end

		-- is this a party waypoint?
		if wtype == MapCommon.WaypointParty then

			-- remove the quotes from party names
			wname = FormatProperly(wstring.gsub(wname, L"\"", L""))
		end

		-- get the waypoint icon based on the type (only for default waypoints)
		local iconId = MapCommon.WaypointsDataByType[wtype].iconId or 100002

		-- get the default icon scale
		local iconDefaultScale = MapCommon.WaypointsDataByType[wtype].scale

		-- is this the sea market waypoint?
		if (wname == L"Sea Market" and (wfacet == 1 or wfacet == 0)) then

			-- replace with the city icon
			iconId = 100042
		end

		-- there is a shrine of wisdom in the wrong facet, we are going to ignore it
		if wname == L"Shrine of Wisdom" and wfacet == 4 then
			continue
		end

		-- if the waypoint is custom we ignore it (this kind of waypoints are from the old system)
		if wtype == MapCommon.WaypointCustomType then
			continue
        end

		-- if this waypoint marks a dungeon, we don't need it, because we have it in the internal waypoints db
		if wtype == MapCommon.WaypointDungeon then
			continue
        end

		-- if the icon default scale is less than 0.6 and the current zoom is greater than -0.5, we hide the icon. Quest icons will be included even if the scale is higher
		if (iconDefaultScale < MapCommon.LocalIconsScale or wtype == MapCommon.WaypointQuest) and MapCommon.ZoomCurrent[currWindow] > MapCommon.ZoomMaxLocalIcons then
			continue
		end

		-- is the waypoint in the visible area?
		if not MapCommon.IsWaypointVisible(currWindow, wtype, wx, wy, wfacet, iconId) then
			continue
		end

		-- initialize the waypoint window name
		local waypoint = currWindow .. "Waypoint" .. waypointId

		-- add the waypoint to the table
		newWaypoints[waypoint] = { waypointId = waypointId, wtype = wtype, wflags = wflags, wname = towstring(wname), wfacet = wfacet, wx = wx, wy = wy, wz = wz, iconId = iconId, iconDefaultScale = iconDefaultScale }
	end
	
	return newWaypoints
end

function MapCommon.GetWaypoints(currWindow, facet, area, newWaypoints)

	-- make sure the window we are updating is the minimap or the atlas
	if not currWindow or (currWindow ~= "MapWindow" and currWindow ~= "AtlasWindow") then
		return newWaypoints
	end

	-- scan all the waypoints for the current map
	for i = 1, #Waypoints.Facet[facet] do	

		-- get the waypoint ID
		local waypointId = MapCommon.WaypointIDRange.UI.min + i

		-- get the waypoint data
		local wtype, wflags, wname, wfacet, wx, wy, wz, iconId, iconDefaultScale = Waypoints.GetWaypointInfo(i, facet)
		
		-- if the waypoint has no name we will ignore it
		if not wname then
			continue
		end

		-- if the icon default scale is less than 0.6 and the current zoom is greater than -0.5, we hide the icon
		if iconDefaultScale < MapCommon.LocalIconsScale and MapCommon.ZoomCurrent[currWindow] > MapCommon.ZoomMaxLocalIcons then
			continue
		end

		-- some tokuno waypoints are shown in the wrong place, so we need to check for the DUNG flag in that area
		if (wflags == "DUNG" and facet == 4 and area == 0) then
			continue
		end
		
		-- some world waypoints in tokuno are shown inside dungeons, so we need to exclude them
		if (not wflags and facet == 4 and area ~= 0) then
			continue
		end
			
		-- make sure that only the abyss waypoints are shown in the abyss
		if (wflags ~= "ABYSS" and facet == 5 and area == 1) then
			continue
		end

		-- is the waypoint in the visible area?
		if not MapCommon.IsWaypointVisible(currWindow, wtype, wx, wy, wfacet, iconId) then
			continue
		end

		-- initialize the waypoint window name
		local waypoint = currWindow .. "Waypoint" .. waypointId

		-- add the waypoint to the table
		newWaypoints[waypoint] = { waypointId = waypointId, wtype = wtype, wflags = wflags, wname = towstring(wname), wfacet = wfacet, wx = wx, wy = wy, wz = wz, iconId = iconId, iconDefaultScale = iconDefaultScale }
	end

	return newWaypoints
end

function MapCommon.GetCustomWaypoints(currWindow, facet, area, newWaypoints)

	-- make sure the window we are updating is the minimap or the atlas
	if not currWindow or (currWindow ~= "MapWindow" and currWindow ~= "AtlasWindow") then
		return newWaypoints
	end

	-- do we have a charybdis location?
	if Interface.CharybdisLocation then

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

		-- is the waypoint in the visible area?
		if MapCommon.IsWaypointVisible(currWindow, wtype, wx, wy, wfacet, iconId) and
			not (wflags == "DUNG" and facet == 4 and area == 0) and -- some tokuno waypoints are shown in the wrong place, so we need to check for the DUNG flag in that area
			not (wflags ~= "ABYSS" and facet == 5 and area == 1) -- make sure that only the abyss waypoints are shown in the abyss
		then
			
			-- store the waypointID
			Interface.CharybdisLocation.WaypointId = waypointId

			-- initialize the waypoint window name
			local waypoint = currWindow .. "Waypoint" .. waypointId

			-- add the waypoint to the table
			newWaypoints[waypoint] = { waypointId = waypointId, wtype = wtype, wflags = wflags, wname = towstring(wname), wfacet = wfacet, wx = wx, wy = wy, wz = wz, iconId = iconId, iconDefaultScale = iconDefaultScale }
		end
	end

	-- does the player still have the vendor search map?
	if Interface.VendorSearchMap and not DoesPlayerHaveItem(Interface.VendorSearchMap.itemID)  then

		-- remove the waypoint
		Interface.VendorSearchMap = nil

		-- if the atlas window has an active search, we update it (in case is showing the vendor search map)
		if AtlasWindow.InSearch then
			AtlasWindow.SearchText()

		else -- update the visible waypoints otherwise
			AtlasWindow.UpdateVisibleWaypointsSearch()
		end
	end

	-- do we have a vendor search location?
	if Interface.VendorSearchMap then

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

		-- is the waypoint in the visible area?
		if MapCommon.IsWaypointVisible(currWindow, wtype, wx, wy, wfacet, iconId) and
			not (wflags == "DUNG" and facet == 4 and area == 0) and -- some tokuno waypoints are shown in the wrong place, so we need to check for the DUNG flag in that area
			not (wflags ~= "ABYSS" and facet == 5 and area == 1) -- make sure that only the abyss waypoints are shown in the abyss
		then
			
			-- store the waypointID
			Interface.VendorSearchMap.WaypointId = waypointId

			-- initialize the waypoint window name
			local waypoint = currWindow .. "Waypoint" .. waypointId

			-- add the waypoint to the table
			newWaypoints[waypoint] = { waypointId = waypointId, wtype = wtype, wflags = wflags, wname = towstring(wname), wfacet = wfacet, wx = wx, wy = wy, wz = wz, iconId = iconId, iconDefaultScale = iconDefaultScale }
		end
	end

	-- do we have custom waypoints?
	if not CustomWaypoints then
		return newWaypoints
	end
	
	-- scan all the custom waypoints
	for i = 1, #CustomWaypoints.Facet[facet] do	

		-- get the waypoint ID
		local waypointId = MapCommon.WaypointIDRange.Custom.min + i

		-- get the waypoint data
		local wtype, wflags, wname, wfacet, wx, wy, wz, iconId, iconDefaultScale = Waypoints.GetCustomWaypointInfo(i, facet)

		-- if the waypoint has no name we will ignore it
		if not wname then
			continue
		end

		-- if the icon default scale is less than 0.6 and the current zoom is greater than -0.5, we hide the icon
		if iconDefaultScale < MapCommon.LocalIconsScale and MapCommon.ZoomCurrent[currWindow] > MapCommon.ZoomMaxLocalIcons then
			continue
		end

		-- some tokuno waypoints are shown in the wrong place, so we need to check for the DUNG flag in that area
		if (wflags == "DUNG" and facet == 4 and area == 0) then
			continue
		end
			
		-- make sure that only the abyss waypoints are shown in the abyss
		if (wflags ~= "ABYSS" and facet == 5 and area == 1) then
			continue
		end

		-- is the waypoint in the visible area?
		if not MapCommon.IsWaypointVisible(currWindow, wtype, wx, wy, wfacet, iconId) then
			continue
		end

		-- initialize the waypoint window name
		local waypoint = currWindow .. "Waypoint" .. waypointId

		-- add the waypoint to the table
		newWaypoints[waypoint] = { waypointId = waypointId, wtype = wtype, wflags = wflags, wname = towstring(wname), wfacet = wfacet, wx = wx, wy = wy, wz = wz, iconId = iconId, iconDefaultScale = iconDefaultScale }
	end

	return newWaypoints
end

function MapCommon.GetSOSWaypoints(currWindow, facet, area, newWaypoints)

	-- make sure the window we are updating is the minimap or the atlas
	if not currWindow or (currWindow ~= "MapWindow" and currWindow ~= "AtlasWindow") then
		return newWaypoints
	end

	-- are the sos waypoints being initialized?
	if not Interface.SOSWaypointsInitialized then

		-- initialize the sos waypoints
		pcall(Interface.InitializeSOSWaypoints)
	end

	-- do we have SOS waypoints?
	if not Interface.SOSWaypoints then
		return newWaypoints
	end

	-- initialize the counter
	local i = 1

	-- scan all the waypoints for the current map
	for itemId, data in pairs(Interface.SOSWaypoints) do

		-- is this waypoint in the right facet?
		if data.facet ~= facet then
			continue
		end

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

		-- some tokuno waypoints are shown in the wrong place, so we need to check for the DUNG flag in that area
		if (wflags == "DUNG" and facet == 4 and area == 0) then
			continue
		end
			
		-- make sure that only the abyss waypoints are shown in the abyss
		if (wflags ~= "ABYSS" and facet == 5 and area == 1) then
			continue
		end

		-- is the waypoint in the visible area?
		if not MapCommon.IsWaypointVisible(currWindow, wtype, wx, wy, wfacet, iconId) then
			continue
		end

		-- initialize the waypoint window name
		local waypoint = currWindow .. "Waypoint" .. waypointId
		
		-- add the waypoint to the table
		newWaypoints[waypoint] = { waypointId = waypointId, wtype = wtype, wflags = wflags, wname = towstring(wname), wfacet = wfacet, wx = wx, wy = wy, wz = wz, iconId = iconId, iconDefaultScale = iconDefaultScale }
	end

	return newWaypoints
end

function MapCommon.GetTmapWaypoints(currWindow, facet, area, newWaypoints)

	-- make sure the window we are updating is the minimap or the atlas
	if not currWindow or (currWindow ~= "MapWindow" and currWindow ~= "AtlasWindow") then
		return newWaypoints
	end

	-- are the tmap waypoints being initialized?
	if not Interface.TmapWaypointsInitialized then

		-- initialize the sos waypoints
		pcall(Interface.InitializeTmapWaypoints)
	end

	-- do we have tmap waypoints?
	if not Interface.TmapWaypoints then
		return newWaypoints
	end

	-- initialize the counter
	local i = 1

	-- scan all the waypoints for the current map
	for itemId, data in pairs(Interface.TmapWaypoints) do

		-- is this waypoint in the right facet?
		if data.facet ~= facet then
			continue
		end

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

		-- some tokuno waypoints are shown in the wrong place, so we need to check for the DUNG flag in that area
		if (wflags == "DUNG" and facet == 4 and area == 0) then
			continue
		end
			
		-- make sure that only the abyss waypoints are shown in the abyss
		if (wflags ~= "ABYSS" and facet == 5 and area == 1) then
			continue
		end

		-- is the waypoint in the visible area?
		if not MapCommon.IsWaypointVisible(currWindow, wtype, wx, wy, wfacet, iconId) then
			continue
		end

		-- initialize the waypoint window name
		local waypoint = currWindow .. "Waypoint" .. waypointId
		
		-- add the waypoint to the table
		newWaypoints[waypoint] = { waypointId = waypointId, wtype = wtype, wflags = wflags, wname = towstring(wname), wfacet = wfacet, wx = wx, wy = wy, wz = wz, iconId = iconId, iconDefaultScale = iconDefaultScale, itemId = itemId }
	end

	return newWaypoints
end

function MapCommon.GetTrackingWaypoints(currWindow, facet, area, newWaypoints)

	-- make sure the window we are updating is the minimap or the atlas
	if not currWindow or (currWindow ~= "MapWindow" and currWindow ~= "AtlasWindow") then
		return newWaypoints
	end

	-- scan all the waypoints for the current map
	for i, data in pairs(TrackingPointer.TrackWaypoints) do

		-- is this waypoint in the right facet?
		if data.facet ~= facet then
			continue
		end

		-- get the waypoint ID
		local waypointId = MapCommon.WaypointIDRange.Tracking.min + i

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

		-- some tokuno waypoints are shown in the wrong place, so we need to check for the DUNG flag in that area
		if (wflags == "DUNG" and facet == 4 and area == 0) then
			continue
		end
			
		-- make sure that only the abyss waypoints are shown in the abyss
		if (wflags ~= "ABYSS" and facet == 5 and area == 1) then
			continue
		end

		-- is the waypoint in the visible area?
		if not MapCommon.IsWaypointVisible(currWindow, wtype, wx, wy, wfacet, iconId) then
			continue
		end

		-- initialize the waypoint window name
		local waypoint = currWindow .. "Waypoint" .. waypointId
		
		-- add the waypoint to the table
		newWaypoints[waypoint] = { waypointId = waypointId, wtype = wtype, wflags = wflags, wname = towstring(wname), wfacet = wfacet, wx = wx, wy = wy, wz = wz, iconId = iconId, iconDefaultScale = iconDefaultScale, itemId = data.mobileId }
	end

	return newWaypoints
end

function MapCommon.DrawServerLine(currWindow, facet)

	-- verify and fix the waypoints filters
    local filterString = MapCommon.VerifyFilterString(Interface.Settings[currWindow .. "_WPFilters"])

	-- are the server lines disabled?
	if not MapCommon.IsFilterEnabled(filterString, 11) then

		-- delete the server lines
		MapCommon.DeleteAllServerlines()

		return
	end

	-- get the map center coordinates
	local mapCenterX, mapCenterY = UOGetRadarCenter()

	-- convert the map coordinates into screen coordinates
	local winCenterX, winCenterY = UOGetWorldPosToRadar(mapCenterX, mapCenterY)

	-- map window name
	local parentWindow = currWindow .. "MapImage"

	-- margin to use from the mask border to the point to start showing the waypoints
	local maskOverlayOffset = 20

	-- get the map mask window size (the visible area)
	local mapAreaW, mapAreaH = WindowGetDimensions(currWindow .. "Map")

	-- get the map texture window size (the whole chunk of map hidden behind the mask)
	local textureAreaW, textureAreaH = WindowGetDimensions(parentWindow)

	-- calculate where the left border of the mask begins (based on the masked texture behind it)
	local leftBorder = ((textureAreaW - mapAreaW) / 2) + maskOverlayOffset

	-- calculate where the right border of the mask begins (based on the masked texture behind it)
	local rightBorder = (leftBorder + mapAreaW) - (maskOverlayOffset * 2)

	-- calculate where the top border of the mask begins (based on the masked texture behind it)
	local topBorder = ((textureAreaH - mapAreaH) / 2) + maskOverlayOffset

	-- calculate where the right border of the mask begins (based on the masked texture behind it)
	local bottomBorder = (topBorder + mapAreaH) - (maskOverlayOffset * 2)

	-- scan all the known server lines
	for id, data in pairsByIndex(MapCommon.ServerLines) do
		
		-- server line object name
		local slineName = "ServerLine" .. id
		
		-- is this line in the same facet that we are seeing?
		if facet ~= data.map then

			-- if the server line exists, we delete it
			MapCommon.DeleteServerLine(slineName)

			continue
		end

		-- initialize the flag that indicates if the server line is visible
		local lineVisible = false

		-- does the line run along the x axis?
		if not data.y then

			lineVisible = MapCommon.IsWaypointVisible(currWindow, _, data.x, mapCenterY, facet, _)

		-- does the line run along the y axis?
		elseif not data.x then
			
			lineVisible = MapCommon.IsWaypointVisible(currWindow, _, mapCenterX, data.y, facet, _)
		end

		-- initialize the end point location (screen coordinates)
		local endX
		local endY

		-- flag that indicates if the end point is visible or not
		local endPointVisible = false

		-- do we have an endpoint for the line?
		if data.endpoint then

			-- calculate the position in the texture of the end point
			endX, endY = UOGetWorldPosToRadar(data.endpoint.x, data.endpoint.y)

			-- is the end point before the visible area? (for lines along Y)
			if (endX > rightBorder or endY < topBorder) and data.x then

				-- then the server line ends before the visible area (if it ends after the line is still visible)
				lineVisible = false

			-- is the end point before the visible area? (for lines along X)
			elseif (endX < leftBorder or endY < topBorder) and data.y then

				-- then the server line ends before the visible area (if it ends after the line is still visible)
				lineVisible = false
			end
			
			-- is the end point inside the map bounds?
			endPointVisible = (endX >= leftBorder and endX <= rightBorder) and (endY >= topBorder and endY <= bottomBorder) 
		end

		-- is the line visible?
		if lineVisible then
		
			-- does the server line already exist?
			if not DoesWindowExist(slineName) then

				-- create the server line
				CreateWindowFromTemplate(slineName, "ServerLineTemplate", parentWindow)
			end

			-- rotate the server line with the same degree of the map
			DynamicImageSetRotation(slineName, MapCommon.Tilt)

			-- reset the anchors
			WindowClearAnchors(slineName)
			
			-- initialize the line size
			local w = 2
			local h = 2

			-- does the line run along the x axis?
			if not data.y then

				-- calculate the x on the map (screen coordinates)
				local wpXonTexture, wpYonTexture = UOGetWorldPosToRadar(data.x, mapCenterY)

				-- do we have the end point and is visible?
				if endX and endPointVisible then

					-- is the map NOT tilted?
					if MapCommon.Tilt == 0 then

						-- calculate linear the distance between the map border and the end point
						local length = math.sqrt(math.pow(0 - endX, 2) + math.pow(0 - endY, 2))

						-- set the line length
						h = length

						-- anchor the waypoint to the map. The center point of the line will pass through endpoint X and endpoint Y (- half length since is anchored in the middle)
						WindowAddAnchor(slineName, "topleft", parentWindow, "center", endX, endY - (length / 2))

					else -- tilted map

						-- calculate the isometric distance between the map border and the end point
						-- with isometric coordinates y is twice as much in the projection, but note this is not the same as halving the x-distance.
						local isoLength = math.floor(math.sqrt(math.pow(0 - endX, 2) + math.pow(0 - endY, 2)))

						-- set the line length (for some reason any number higher than 600 push the line out of the anchors...)
						h = isoLength

						-- anchor the waypoint to the map. The center point of the line will pass through endpoint X (increased by 35.5%) and endpoint Y (reduced by 35.5%)
						WindowAddAnchor(slineName, "topleft", parentWindow, "center", endX + (h * 0.355), endY - (h * 0.355))
					end

				else -- no end point 
				
					-- anchor the waypoint to the map (the center point of the line will pass through x, mapcenterY)
					WindowAddAnchor(slineName, "topleft", parentWindow, "center", wpXonTexture, wpYonTexture)

					-- set the line long as the whole texture height
					h = textureAreaH
				end
				
			-- does the line run along the y axis?
			elseif not data.x then

				-- calculate the y on the map (screen coordinates)
				local wpXonTexture, wpYonTexture = UOGetWorldPosToRadar(mapCenterX, data.y)

				-- do we have the end point and is visible?
				if endY and endPointVisible then
				
					-- is the map NOT tilted?
					if MapCommon.Tilt == 0 then

						-- calculate linear the distance between the map border and the end point
						local length = math.sqrt(math.pow(0 - endX, 2) + math.pow(0 - endY, 2))

						-- set the line length to the distance between the center and the end point + the distance between the map center and the border
						w = length

						-- anchor the waypoint to the map. The center point of the line will pass through endpoint X (- half lenght since is anchored in the middle) and endpoint Y
						WindowAddAnchor(slineName, "topleft", parentWindow, "center", endX - (length / 2), endY)

					else -- tilted map

						-- calculate the isometric distance between the map border and the end point
						-- with isometric coordinates y is twice as much in the projection, but note this is not the same as halving the x-distance.
						local isoLength = math.sqrt((0 - endX) + (2 * math.pow(0 - endY, 2)))

						-- set the line length to the distance between the center and the end point + the distance between the map center and the border
						w = isoLength

						-- anchor the waypoint to the map. The center point of the line will pass through endpoint X and endpoint Y, reduced by 35.5%
						WindowAddAnchor(slineName, "topleft", parentWindow, "center", endX - (isoLength * 0.355), endY - (isoLength * 0.355) )
					end

				else -- no end point

					-- anchor the waypoint to the map (the center point of the line will pass through mapcenterX, y)
					WindowAddAnchor(slineName, "topleft", parentWindow, "center", wpXonTexture, wpYonTexture)

					-- set the line long as the whole texture width
					w = textureAreaW
				end
			end

			-- resize the server line properly
			WindowSetDimensions(slineName, w, h)

			-- mark the server line as created
			MapCommon.CreatedServerLines[slineName] = true

		else -- if the server line exists, we delete it
			MapCommon.DeleteServerLine(slineName)
		end
	end	
end

function MapCommon.IsWaypointVisible(currWindow, wtype, wx, wy, wfacet, iconId)
	
	-- make sure the window we are updating is the minimap or the atlas
	if not currWindow or (currWindow ~= "MapWindow" and currWindow ~= "AtlasWindow") then
		return false
	end
	
	-- get the current facet
	local facet = UOGetRadarFacet() or 0

	-- get the current area
	local area = UOGetRadarArea() or 0

	-- un-fix the facet for certain areas.
    if (wfacet == 0 and facet == 5 and (area == 2 or area == 7)) then
		wfacet = 5
	end

	-- is the waypoint in a different facet?
	if wfacet ~= facet then
		return false
	end
	
	-- dos this waypoint belong to this area?
	if not UORadarIsLocationInArea(wx, wy, wfacet, area) then
		return false
	end

	-- get the current area top left and bottom right corners coordinates
	local topLeftX, topLeftY, bottomRightX, bottomRightY = UORadarGetAreaDimensions(facet, area)

	-- now we check if the waypoints coordinates fits inside the current area
	if (wx >= topLeftX and wx <= bottomRightX) and (wy >= topLeftY and wy <= bottomRightY) then

		-- get the map mask window size (the visible area)
		local mapAreaW, mapAreaH = WindowGetDimensions(currWindow .. "Map")

		-- margin to use from the mask border to the point to start showing the waypoints
		local maskOverlayOffset = 20

		-- get the map texture window size (the whole chunk of map hidden behind the mask)
		local textureAreaW, textureAreaH = WindowGetDimensions(currWindow .. "MapImage")

		-- calculate where the left border of the mask begins (based on the masked texture behind it)
		local leftBorder = ((textureAreaW - mapAreaW) / 2) + maskOverlayOffset

		-- calculate where the right border of the mask begins (based on the masked texture behind it)
		local rightBorder = (leftBorder + mapAreaW) - (maskOverlayOffset * 2)

		-- calculate where the top border of the mask begins (based on the masked texture behind it)
		local topBorder = ((textureAreaH - mapAreaH) / 2) + maskOverlayOffset

		-- calculate where the right border of the mask begins (based on the masked texture behind it)
		local bottomBorder = (topBorder + mapAreaH) - (maskOverlayOffset * 2)

		-- calculate the position of the waypoint on the map texture
		local wpXonTexture, wpYonTexture = UOGetWorldPosToRadar(wx, wy)

		-- now we check if the waypoint X and Y are inside the texture borders we defined, if it is, the waypoint is visible
		if (wpXonTexture >= leftBorder and wpXonTexture <= rightBorder) and (wpYonTexture >= topBorder and wpYonTexture <= bottomBorder) then
		
			-- if this data is not available, the request DO NOT comes from the waypoint drawing routines
			if not wtype or not iconId then
				return true
			end

			-- verify and fix the waypoints filters
			local filterString = MapCommon.VerifyFilterString(Interface.Settings[MapCommon.GetActiveMap() .. "_WPFilters"])

			-- scan all the filters
			for id, data in pairsByIndex(MapCommon.WaypointFilters) do

				-- is the filter disabled?
				if not MapCommon.IsFilterEnabled(filterString, id) then
					
					-- if this filter has the icon of this waypoint, the waypoint won't be visible
					if data.icons and table.contains(data.icons, iconId) then
						return false
					end
				end
			end

			return true
		end
	end
	
	return false
end

function MapCommon.CreateWaypoint(currWindow, wname, wtype, wx, wy, wfacet, iconId, iconDefaultScale, waypointId)
	
	-- make sure the window we are updating is the minimap or the atlas
	if not currWindow or (currWindow ~= "MapWindow" and currWindow ~= "AtlasWindow") then
		return
	end

	-- make sure the waypoint is visible
	if not MapCommon.IsWaypointVisible(currWindow, wtype, wx, wy, wfacet, iconId) then
		return
	end

	-- initialize the waypoint window name
	local waypoint = currWindow .. "Waypoint" .. waypointId
	
	-- does the waypoint window exist?
	if DoesWindowExist(waypoint) then
			
		-- delete the waypoint
		DestroyWindow(waypoint)
	end

	-- name of the window where to create the waypoints
	local parentWindow = currWindow .. "MapImage"
	
	-- calculate the position of the waypoint on the current window
	local windowX, windowY = UOGetWorldPosToRadar(wx, wy)

	-- create the waypoint object
	CreateWindowFromTemplate(waypoint, "WaypointIconTemplate", parentWindow)

	-- is this the player or party member waypoint and the name tags are enabled?
	if (wtype == MapCommon.WaypointParty or wtype == MapCommon.WaypointPlayerType) and MapCommon.IsFilterEnabled(Interface.Settings[MapCommon.GetActiveMap() .. "_WPFilters"], 1) then

		-- create the label over the waypoint
		CreateWindowFromTemplate(waypoint .. "Text", "WPText", waypoint)

		-- anchor the text on top of the waypoint
		WindowAddAnchor(waypoint .. "Text", "top", waypoint, "bottom", 0, -5)

		-- set the text
		LabelSetText(waypoint .. "Text", wname)

		-- set the text scale
		WindowSetScale(waypoint .. "Text", math.min(WindowGetScale(waypoint), MapCommon.MaxNameTagScale))
	end

	-- set the ID on the waypoint
	WindowSetId(waypoint, waypointId)

	-- move the waypoint on the proper layer based on priority
	WindowSetLayer(waypoint, MapCommon.WaypointsDataByType[wtype].layer)

	-- get the icon data
	local iconTexture, x, y = GetIconData(iconId)
	
	-- get the icon dimensions
	local iconWidth, iconHeight = UOGetTextureSize(iconTexture)

	-- we draw the icons in full size, and resize them later based on the zoom level
	WindowSetDimensions(waypoint, iconWidth, iconHeight)

	-- update the texture dimensions
	DynamicImageSetTextureDimensions(waypoint, iconWidth, iconHeight)

	-- draw the texture
	DynamicImageSetTexture(waypoint, iconTexture, x, y)

	-- is this a healer waypoint and is a priest of mondain?
	if wtype == MapCommon.WaypointHealer and wstring.find(wstring.lower(wname), L"priest of mondain", 1, true) then
		
		-- we color the waypoint in red
		WindowSetTintColor(waypoint, 255, 0, 0)
	end
	
	-- reset the waypoint anchors
	WindowClearAnchors(waypoint)

	-- anchor the waypoint to the map
	WindowAddAnchor(waypoint, "topleft", parentWindow, "center", windowX, windowY)
end

function MapCommon.UpdateWaypointsPosition(currWindow)
	
	-- name of the window where to create the waypoints
	local parentWindow = currWindow .. "MapImage"

	-- scan the waypoints we currently have
	for waypoint, data in pairs(MapCommon.CreatedWaypoints) do
		
		-- calculate the position of the waypoint on the current window
		local windowX, windowY = UOGetWorldPosToRadar(data.wx, data.wy)

		-- get the current waypoint position on the window
		local currX, currY = WindowGetAnchor(waypoint, 1)

		-- has the position changed?
		if windowX ~= currX or windowY ~= currY then

			-- reset the waypoint anchors
			WindowClearAnchors(waypoint)

			-- anchor the waypoint to the map
			WindowAddAnchor(waypoint, "topleft", parentWindow, "center", windowX, windowY)
		end

		-- are the name tags disabled?
		if MapCommon.IsFilterEnabled(Interface.Settings[MapCommon.GetActiveMap() .. "_WPFilters"], 1) then

			if (MapCommon.CreatedWaypoints[waypoint].wtype == MapCommon.WaypointParty or MapCommon.CreatedWaypoints[waypoint].wtype == MapCommon.WaypointPlayerType) then
			
				-- does the name tag exist?
				if not DoesWindowExist(waypoint .. "Text") then

					-- create the label over the waypoint
					CreateWindowFromTemplate(waypoint .. "Text", "WPText", waypoint)

					-- anchor the text on top of the waypoint
					WindowAddAnchor(waypoint .. "Text", "top", waypoint, "bottom", 0, -10)
					
					-- set the correct scale for the text
					WindowSetScale(waypoint .. "Text", math.min(WindowGetScale(waypoint), MapCommon.MaxNameTagScale))
				end

				-- update the name tag
				LabelSetText(waypoint .. "Text", MapCommon.CreatedWaypoints[waypoint].wname)
			end

		else -- name tags disabled

			-- does the name tag exist?
			if DoesWindowExist(waypoint .. "Text") then
				
				-- delete the name tag
				DestroyWindow(waypoint .. "Text")
			end
		end
	end
end

function MapCommon.UpdateWaypointsScale(currWindow)

	-- scan the waypoints we currently have
	for waypoint, data in pairs(MapCommon.CreatedWaypoints) do

		-- update the scale for the waypoint
		MapCommon.UpdateWaypointScale(currWindow, waypoint, data.wtype, data.iconDefaultScale)
	end
end

function MapCommon.UpdateWaypointScale(currWindow, waypoint, wtype, iconDefaultScale)

	-- name of the window where to create the waypoints
	local parentWindow = currWindow .. "MapImage"

	-- get the current zoom level
	local currZoom = MapCommon.ZoomCurrent[currWindow]

	-- we know that at the default map zoom level (0), the icon scale must be: iconDefaultScale
	-- we also know that if the iconDefaultScale is less than 0.6, the waypoint must be hidden at a zoom level higher than -0.5

	-- icon scale of 0.6 and less
	if iconDefaultScale < MapCommon.LocalIconsScale or wtype == MapCommon.WaypointQuest then

		-- calculate at which % the zoom currently is
		local currZoomPerc = 1 - ((MapCommon.ZoomCurrent[currWindow] + 2) / (MapCommon.ZoomMax[currWindow] + 2 + MapCommon.ZoomMaxLocalIcons))

		-- calculate the new scale based on the current zoom level percentage
		iconDefaultScale = iconDefaultScale * currZoomPerc
		
	else -- normal icons

		-- calculate at which % the zoom currently is
		local currZoomPerc = 1 - ((MapCommon.ZoomCurrent[currWindow] + 2) / (MapCommon.ZoomMax[currWindow] + 2))

		-- calculate the new scale based on the current zoom level percentage
		iconDefaultScale = (iconDefaultScale * currZoomPerc)
	end

	-- make sure the icons don't get too small
	if iconDefaultScale < MapCommon.MinIconScale then
		iconDefaultScale = MapCommon.MinIconScale
	end

	-- update the icon scale
	WindowSetScale(waypoint, iconDefaultScale)

	-- does the name tag exist?
	if DoesWindowExist(waypoint .. "Text") then

		-- cap the name tag scale so it won't become too small or too big
		WindowSetScale(waypoint .. "Text", math.min(WindowGetScale(waypoint), MapCommon.MaxNameTagScale))
	end
end

function MapCommon.CreateMissingWaypoints(currWindow, newWaypoints)
	
	-- do we have the waypoints list?
	if not newWaypoints then
		return
	end

	-- initialize the waypoints table if it's missing
	if not MapCommon.CreatedWaypoints then
		MapCommon.CreatedWaypoints = {}
	end

	-- scan the waypoints we currently have
	for waypoint, data in pairs(newWaypoints) do

		-- make sure the waypoint does not exist
		if not MapCommon.CreatedWaypoints[waypoint] then
			
			-- create the waypoint
			MapCommon.CreateWaypoint(currWindow, data.wname, data.wtype, data.wx, data.wy, data.wfacet, data.iconId, data.iconDefaultScale, data.waypointId)

			-- add the waypoint to the list
			MapCommon.CreatedWaypoints[waypoint] = data
		end
	end
end

function MapCommon.DeleteMismatchingWaypoints(currWindow, newWaypoints, doNotDeleteMissing)

	-- scan the waypoints we currently have
	for waypoint, data in pairs(MapCommon.CreatedWaypoints) do
	
		-- is the current waypoint in the new list?
		if not newWaypoints[waypoint] and not doNotDeleteMissing then
		
			-- delete the waypoint
			MapCommon.DeleteWaypoint(waypoint)

			continue
		end

		-- if the waypoint is in the list but doesn't exist, we delete it from the current list so it will be re-created later
		if not DoesWindowExist(waypoint) then
			
			-- delete the waypoint
			MapCommon.DeleteWaypoint(waypoint)
			
			continue
		end
		
		-- if the icon default scale is less than 0.6 and the current zoom is greater than -0.5, we hide the icon
		if data.iconDefaultScale < MapCommon.LocalIconsScale and MapCommon.ZoomCurrent[currWindow] > MapCommon.ZoomMaxLocalIcons then
			
			-- delete the waypoint
			MapCommon.DeleteWaypoint(waypoint)

			continue
		end

		-- get the new waypoint data
		local newData = newWaypoints[waypoint]

		-- make sure we have the new data
		if not newData then
			continue
		end

		-- if the type, the name, the facet or the icon id don't match, we delete the waypoint
		if	newData.wtype ~= data.wtype or
			newData.wflags ~= data.wflags or
			newData.wname ~= data.wname or
			newData.wfacet ~= data.wfacet or
			newData.iconId ~= data.iconId
		then
			
			-- delete the waypoint
			MapCommon.DeleteWaypoint(waypoint)

			continue
		end

		-- has the position changed?
		if data.wx ~= newData.x or data.wy ~= newData.y then

			-- update the current waypoint data with the new one
			MapCommon.CreatedWaypoints[waypoint] = newData
		end
	end
end

function MapCommon.DeleteAllWaypoints()

	-- scan all created waypoints
	for waypoint, _ in pairs(MapCommon.CreatedWaypoints) do

		-- delete the waypoint
		MapCommon.DeleteWaypoint(waypoint)
	end

	-- clear the table
	MapCommon.CreatedWaypoints = {}

	-- delete the server lines
	MapCommon.DeleteAllServerlines()
end

function MapCommon.DeleteAllServerlines()

	-- scan all created server lines
	for sline, _ in pairs(MapCommon.CreatedServerLines) do

		-- delete the server line
		MapCommon.DeleteServerLine(sline)
	end

	-- clear the server lines table
	MapCommon.CreatedServerLines = {}
end

function MapCommon.DeleteWaypoint(waypoint)
	
	-- does the waypoint window exist?
	if DoesWindowExist(waypoint) then
			
		-- delete the waypoint
		DestroyWindow(waypoint)
	end

	-- remove the waypoint from the list
	MapCommon.CreatedWaypoints[waypoint] = nil
end

function MapCommon.DeleteServerLine(sline)
	
	-- does the server line window exist?
	if DoesWindowExist(sline) then
			
		-- delete the waypoint
		DestroyWindow(sline)
	end

	-- remove the waypoint from the list
	MapCommon.CreatedServerLines[sline] = nil
end

function MapCommon.GetSextantCenterByArea(facet, area)

	-- get the area coordinates
	local x1, y1, x2, y2 = UORadarGetAreaDimensions(facet, area)

	-- fix the facet for certain areas.
    if (facet == 5 and (area == 2 or area == 7)) then
		facet = 0
	end

	return MapCommon.GetSextantCenter(x1, y1, facet)
end

function MapCommon.GetSextantCenter(x, y, facet)

	-- is this trammel or felucca?
	if facet == 0 or facet == 1 then
	
		-- is the area inside "world"?
		if x >= 0 and y >= 0 and x < MapCommon.MapSize[facet].width and y < MapCommon.MapSize[facet].height then

			-- we use the default sextant center
			return MapCommon.sextantDefaultCenterX, MapCommon.sextantDefaultCenterY

		-- is this area outside the "world" area? (lost lands, dungeons, etc..)
		elseif x >= MapCommon.sextantLostLandTopLeftX and y >= MapCommon.sextantLostLandTopLeftY and x < MapCommon.sextantLostLandBottomRightX and y < MapCommon.sextantLostLandBottomRightY then
		
			-- we use the lost land sextant center
			return MapCommon.sextantLostLandCenterX, MapCommon.sextantLostLandCenterY

		else -- out of bounds
			return 0, 0
		end

	-- for any other map we just check if the location is inside the bounds
	elseif x >= 0 and y >= 0 and x < MapCommon.MapSize[facet].width and y < MapCommon.MapSize[facet].height then

		-- we use the default sextant center
		return MapCommon.sextantDefaultCenterX, MapCommon.sextantDefaultCenterY

	else -- out of bounds
		return 0, 0
	end
end

function MapCommon.ConvertToXYMinutes(latVal, longVal, latDir, longDir, facet, area)

	-- make sure we have a valid latitude and longitude
	if not tonumber(latVal) or not tonumber(longVal) then
		return 0, 0
	end
	
	-- get the coordinates for the map center
	local sectCenterX, sectCenterY = MapCommon.GetSextantCenterByArea(facet, area)

	-- LONGITUDE
	-- calculate X from longitude minutes
	local minutesX = (longVal - math.floor(longVal)) * 100

	-- calculate the rest of the x from the longitude seconds
	local xlong = math.floor(longVal)

	-- calculate the absolute longitude value (minutes + seconds)
	local absLong = xlong + (minutesX / 60)

	-- is the longitude west?
	if longDir == L"W" then

		-- subtract 360° from the absolute longitude
		absLong = 360 - absLong
	end

	-- LATITUDE
	-- calculate Y from latitude minutes
	local minutesY = (latVal - math.floor(latVal)) * 100

	-- calculate the rest of the y from the latitude seconds
	local ylat = math.floor(latVal)

	-- calculate the absolute latitude value (minutes + seconds)
	local absLat = ylat + (minutesY / 60)

	-- is the latitude north?
	if latDir == L"N" then

		-- subtract 360° from the absolute latitude
		absLat = 360 - absLat
	end
	
	-- FINAL X, Y
	-- calculate the final X
	local x = sectCenterX + ((absLong * MapCommon.sextantMaximumX) / 360)

	-- calculate the final Y
	local y = sectCenterY + ((absLat * MapCommon.sextantMaximumY) / 360)

	-- fix the x value if is less than 0
	if x < 0 then
		x = x + MapCommon.sextantMaximumX
	end

	-- fix the x value if is higher than the map maximum x
	if x >= MapCommon.sextantMaximumX then
		x = x - MapCommon.sextantMaximumX
	end

	-- fix the y value if is less than 0
	if y < 0 then
		y = y + MapCommon.sextantMaximumY
	end

	-- fix the y value if is higher than maximum y
	if y >= MapCommon.sextantMaximumY then
		y = y - MapCommon.sextantMaximumY
	end

	return x, y
end

function MapCommon.GetSextantLocationStrings(x, y, facet)

	-- get the area ID for the location
	local area = MapCommon.GetAreaID(x, y, facet)

	-- fix the facet for certain areas.
    if (facet == 5 and (area == 2 or area == 7)) then
		facet = 0
	end

	-- calculate the minutes from x and y
    local minutesX, minutesY = MapCommon.ConvertToMinutesXY(x, y, facet)
  
	-- default longitude is EAST
    local longDir = L"E"
	
	-- are the X minutes negative?
    if minutesX < 0 then

		-- change the longitude to WEST
		longDir = L"W"

		-- make the minutes negative
		minutesX = -minutesX
    end

	-- calculate the longitude output string
    local longString = wstring.format(L"%d", (minutesX / 60)) .. L"." .. wstring.format(L"%02d", (minutesX % 60))

	-- default latitude is SOUTH
    local latDir = L"S"

	-- are the minutes negative?
    if minutesY < 0 then

		-- change the latitude to NORTH
		latDir = L"N"

		-- make the minutes negative
		minutesY = -minutesY
	end
    
	-- calculate the latitude output string
    local latString = wstring.format(L"%d", (minutesY / 60)) .. L"." .. wstring.format(L"%02d", (minutesY % 60))
    
    return latString, longString, latDir, longDir
end

function MapCommon.ConvertToMinutesXY(x, y, facet)

	-- get the map center coordinates
	local sectCenterX, sectCenterY = MapCommon.GetSextantCenter(x, y, facet) 
    
	-- calculate the minutes from the X
	local minutesX = 21600 * (x - sectCenterX) / MapCommon.sextantMaximumX

	-- calculate the minutes from the Y
	local minutesY = 21600 * (y - sectCenterY) / MapCommon.sextantMaximumY

	-- make sure the minutes do not exceed the limit
	if minutesX > 10800 then
		minutesX = minutesX - 21600
	end

	-- make sure the minutes are not less than the minimum value
	if minutesX <= -10800 then
		minutesX = minutesX + 21600
	end

	-- make sure the minutes do not exceed the limit
	if minutesY > 10800 then
		minutesY = minutesY - 21600
	end

	-- make sure the minutes are not less than the minimum value
	if minutesY <= -10800 then
		minutesY = minutesY + 21600
	end
	
	return minutesX, minutesY
end

function MapCommon.WaypointMouseOver()
	
	-- make sure a map is visible and that we're not dragging the map
	if not MapCommon.IsMapVisible() or AtlasWindow.IsDraggingMap then
		return
	end

	-- get the waypoint window name
    local waypoint = SystemData.ActiveWindow.name
	
	-- get the waypoint data
	local waypointData = MapCommon.CreatedWaypoints[waypoint]
	
	-- do we have the waypoint data?
	if not waypointData then
		return
	end

	-- does the waypoint tooltip window already exist?
    if DoesWindowExist("WaypointInfo") then

		-- destroy the window
        DestroyWindow("WaypointInfo")
    end
        
	-- flag that we have the cursor over a waypoint
    MapCommon.WaypointIsMouseOver = true

	-- store the waypoint name (so we can update the tooltip)
	MapCommon.WaypointMouseOverName = waypoint

	-- get the waypoint name
	local waypointName = FormatProperly(waypointData.wname)

	-- get the waypoint coordinates
    local waypointX = waypointData.wx
    local waypointY = waypointData.wy
    local waypointFacet = waypointData.wfacet
	local waypointArea = MapCommon.GetAreaID(waypointX, waypointY, waypointFacet)
	
	-- initialize the sextant string
	local sextant

	-- fix the facet for certain areas.
	if (waypointFacet == 5 and (waypointArea == 2 or waypointArea == 7)) then
		waypointFacet = 0
	end

	-- are we on trammel or felucca or in the lost lands or any other facet?
	if (waypointFacet == 0 and (waypointArea == 0 or waypointArea == MapCommon.sextantFeluccaLostLands)) or (waypointFacet == 1 and (waypointArea == 0 or waypointArea == MapCommon.sextantTrammelLostLands) or waypointFacet > 1) then

		-- calculate latitude and longitude based on the current player position
		local latStr, longStr, latDir, longDir = MapCommon.GetSextantLocationStrings(waypointX, waypointY, waypointFacet)

		-- set the string with lat/long and x/y
		sextant = GetStringFromTid(555) .. L": " .. latStr .. L"'" .. latDir .. L" " .. longStr .. L"'" .. longDir .. L" (" .. waypointX .. L", " .. waypointY .. L")"

	else -- set the string with x/y ONLY
		sextant = GetStringFromTid(555) .. L": " .. waypointX .. L", " .. waypointY
	end

	-- waypoint info window
	local waypointTooltip = "WaypointInfo"

	-- create the tooltip
    CreateWindowFromTemplate(waypointTooltip, "WaypointInfoTemplate", "Root")

	-- reset the tooltip anchors
    WindowClearAnchors(waypointTooltip)

	-- do we have a properties slot in the hotbar?
	if Interface.PropsSlot then

		-- properties slot name
		local anchor = "Hotbar" .. Interface.PropsSlot.HotbarID .. "Button" .. Interface.PropsSlot.SlotID

		-- anchor the tooltip to the properties slot
		WindowAddAnchor(waypointTooltip, "center", anchor, "bottomright", 0, 0)

	else -- show the tooltip on the waypoint
		WindowAddAnchor(waypointTooltip, "bottom", waypoint, "top", 0, 0)
	end
                
	-- set the waypoint name text
    LabelSetText(waypointTooltip .. "Details", waypointName)

	-- set the waypoint location text
    LabelSetText(waypointTooltip .. "Location", sextant)

	-- make the background a bit transparent
	WindowSetAlpha(waypointTooltip .. "WindowBackground", 0.75)

	-- scale the tooltip with the same scale of the item properties
	WindowSetScale(waypointTooltip, Interface.Settings.NewItemPropertiesScale)
end

function MapCommon.WaypointMouseOverEnd()

	-- clear the waypoint mouse over flag
	MapCommon.WaypointIsMouseOver = nil

	-- clear the waypoint mouse over name
	MapCommon.WaypointMouseOverName = nil
	
	-- is the waypoint tooltip still active?
    if DoesWindowExist("WaypointInfo") then

		-- destroy the tooltip
        DestroyWindow("WaypointInfo")
    end    
end

function MapCommon.WaypointOnLButtonDblClk()

	-- get the waypoint window name
	local waypoint = SystemData.ActiveWindow.name

	-- make sure we have the waypoint data
	if not MapCommon.CreatedWaypoints[waypoint] then
		return
	end

	-- get the item ID (if it has one)
	local itemId = MapCommon.CreatedWaypoints[waypoint].itemId

	-- do we have an item ID?
	if IsValidID(itemId) then
		
		-- use the item
		UserActionUseItem(itemId, false)
	end
end

function MapCommon.WaypointOnRButtonUp()
	
	-- get the active map (atlas or minimap)
	local currentMapWindow = MapCommon.GetActiveMap()

	-- only the atlas is allowd to edit waypoints
	if currentMapWindow ~= "AtlasWindow" then
		return
	end

	-- waypoint editor area name
	local waypointEditor = currentMapWindow .. "WaypointEditor"

	-- is the waypoint editor visible?
	if WindowGetShowing(waypointEditor) then
		return
	end
	
	-- get the waypoint window name
	local waypoint = SystemData.ActiveWindow.name
	
	-- get the waypoint ID
	local waypointId = WindowGetId(waypoint)

	-- get the waypoint data
	local waypointData = MapCommon.CreatedWaypoints[waypoint]

	-- if it's the player waypoint we do nothing
	if waypointData.wtype == MapCommon.WaypointPlayerType then
		return
	end

	-- load all the waypoint data into the params
	local params = { itemId = waypointData.itemId, waypoint = waypoint, wtype = waypointData.wtype, iconId = waypointData.iconId, iconScale = waypointData.iconDefaultScale, waypointName = waypointData.wname, waypointId = waypointId, x = waypointData.wx, y = waypointData.wy, facetId = waypointData.wfacet, area = UOGetRadarArea() }

	-- reset the context menu
	ContextMenu.CleanUp()

	-- is this a custom waypoint?
	if waypointId >= MapCommon.WaypointIDRange.Custom.min and waypointId <= MapCommon.WaypointIDRange.Custom.max then
		
		-- add the edit waypoint option
		ContextMenu.CreateLuaContextMenuItem({ tid = MapCommon.TID.EditWaypoint, returnCode = MapCommon.ContextReturnCodes.EDIT_WAYPOINT, param = params })

		-- add the delete waypoint option
		ContextMenu.CreateLuaContextMenuItem({ tid = MapCommon.TID.DeleteWaypoint, returnCode = MapCommon.ContextReturnCodes.DELETE_WAYPOINT, param = params })

	-- is this a tmap waypoint?
	elseif waypointId >= MapCommon.WaypointIDRange.Tmap.min and waypointId <= MapCommon.WaypointIDRange.Tmap.max then

		-- add the delete waypoint option
		ContextMenu.CreateLuaContextMenuItem({ tid = MapCommon.TID.DeleteWaypoint, returnCode = MapCommon.ContextReturnCodes.DELETE_WAYPOINT, param = params })
	end

	-- add the magnetize option
	ContextMenu.CreateLuaContextMenuItem({ tid = MapCommon.TID.Magnetize, returnCode = MapCommon.ContextReturnCodes.MAGNETIZE, param = params })
	
	-- show the context menu
	ContextMenu.ActivateLuaContextMenu(MapCommon.ContextMenuCallback, true)
end

function MapCommon.ContextMenuCallback(returnCode, params)
	
	-- get the map we are zooming (atlas or minimap)
	local mapWindow = MapCommon.GetActiveMap()

	if returnCode == MapCommon.ContextReturnCodes.ALL_FILTERS then

		-- initialize the filters string
		local filterString = ""

		-- enable all filters
		while string.len(filterString) < table.countElements(MapCommon.WaypointFilters) do
			filterString = filterString .. "1"
		end

		-- store the new filters
		Interface.Settings[mapWindow .. "_WPFilters"] = filterString

		-- save the filters
		Interface.SaveSetting(mapWindow .. "_WPFilters", Interface.Settings[mapWindow .. "_WPFilters"])

		-- refresh the waypoints
		MapCommon.WaypointsDirty =  true

		-- update the list of all the waypoints in the map
		Interface.AddTodoList({func = function() AtlasWindow.UpdateVisibleWaypointsSearch() end, time = Interface.TimeSinceLogin + 0.5})

	elseif returnCode == MapCommon.ContextReturnCodes.NO_FILTERS then

		-- initialize the filters string
		local filterString = ""

		-- enable all filters
		while string.len(filterString) < table.countElements(MapCommon.WaypointFilters) do
			filterString = filterString .. "0"
		end

		-- store the new filters
		Interface.Settings[mapWindow .. "_WPFilters"] = filterString

		-- save the filters
		Interface.SaveSetting(mapWindow .. "_WPFilters", Interface.Settings[mapWindow .. "_WPFilters"])

		-- refresh the waypoints
		MapCommon.WaypointsDirty =  true

		-- update the list of all the waypoints in the map
		Interface.AddTodoList({func = function() AtlasWindow.UpdateVisibleWaypointsSearch() end, time = Interface.TimeSinceLogin + 0.5})

	-- do we have to disable a filter?
	elseif returnCode == MapCommon.ContextReturnCodes.DISABLE_FILTER then

		-- get the filter id
		local filter = params.id
		
		-- toggle the filter
		if MapCommon.IsFilterEnabled(params.filterString, filter) then
			params.filterString = string.setChar(params.filterString, filter, 0)
		else
			params.filterString = string.setChar(params.filterString, filter, 1)
		end

		-- store the new filters
		Interface.Settings[mapWindow .. "_WPFilters"] = params.filterString

		-- save the filters
		Interface.SaveSetting(mapWindow .. "_WPFilters", Interface.Settings[mapWindow .. "_WPFilters"])

		-- refresh the waypoints
		MapCommon.WaypointsDirty =  true

		-- update the list of all the waypoints in the map
		Interface.AddTodoList({func = function() AtlasWindow.UpdateVisibleWaypointsSearch() end, time = Interface.TimeSinceLogin + 0.5})

	-- create waypoint context
	elseif returnCode == MapCommon.ContextReturnCodes.CREATE_WAYPOINT then
	
		-- open the waypoint editor
		AtlasWindow.CreateWaypointHere(params.x, params.y, params.facetId, params.area)

	-- edit waypoint
	elseif returnCode == MapCommon.ContextReturnCodes.EDIT_WAYPOINT then

		-- open the waypoint editor and set that we are editing
		AtlasWindow.CreateWaypointHere(params.x, params.y, params.facetId, params.area, true, params.waypointId, params.waypointName, params.iconId, params.iconScale)

	-- delete waypoint
	elseif returnCode == MapCommon.ContextReturnCodes.DELETE_WAYPOINT then

		-- initialize the remove function
		local func

		-- is this a custom waypoint?
		if params.waypointId >= MapCommon.WaypointIDRange.Custom.min and params.waypointId <= MapCommon.WaypointIDRange.Custom.max then

			-- get the real waypoint ID
			local waypointId = params.waypointId - MapCommon.WaypointIDRange.Custom.min

			-- create the delete function
			func = function() CustomWaypoints.Facet[params.facetId][waypointId] = nil AtlasWindow.UpdateVisibleWaypointsSearch() MapCommon.WaypointsDirty = true end

		-- is this a tmap waypoint?
		elseif params.waypointId >= MapCommon.WaypointIDRange.Tmap.min and params.waypointId <= MapCommon.WaypointIDRange.Tmap.max then
		
			-- create the delete function
			func = function() Interface.TmapWaypoints[params.itemId] = nil AtlasWindow.UpdateVisibleWaypointsSearch() MapCommon.WaypointsDirty = true end
		end

		-- create the buttons data
		local OKButton = { textTid = UO_StandardDialog.TID_OKAY, callback = func } -- OK
		local cancelButton = { textTid = UO_StandardDialog.TID_CANCEL, callback = function() end } -- Cancel

		-- create the dialog data
		local DeleteWaypointConfirmWindow = 
					{
						windowName = "DeleteWaypointConfirm",
						bodyTid = 1155390, -- Are you sure?
						titleTid = MapCommon.TID.DeleteWaypoint,
						buttons = { OKButton, cancelButton },
						closeCallback = cancelButton.callback,
						destroyDuplicate = true,
					}

		-- create the confirm dialog
		UO_StandardDialog.CreateDialog(DeleteWaypointConfirmWindow)

	-- magnetize compass
	elseif returnCode == MapCommon.ContextReturnCodes.MAGNETIZE then

		-- magnetize the compass
		MapWindow.MagnetizeLocation(params.x, params.y, params.facetId, vendorMap)

		-- store the item ID (in case is a tmap or an sos)
		MapWindow.MagnetPoint.itemID = params.itemId

		-- is this a (default) moving waypoint?
		if params.waypointId and MapCommon.WaypointsDataByType[params.wtype].moving and params.waypointId <= MapCommon.WaypointIDRange.Default.max then

			-- add the waypoint ID to the magnet point data so we can update the location
			MapWindow.MagnetPoint.waypointId = params.waypointId
		end
	end
end

function MapCommon.isChampionSpawn(name)

	-- is this area a champion spawn area?
	if name and string.find(name, "Champion Spawn", 1, true) or name == "Sleeping Dragon" then
		return true
	end

	return false
end

function MapCommon.UOMapperSend()

	-- is the cartographer output enabled and we have the player data?
	if not Interface.Settings.EnableCartographer or Interface.DisableDiskIO or not WindowData.PlayerStatus.MaxHealth or not WindowData.PlayerStatus.CurrentHealth then
		return
	end
	
	-- create the position file for cartographer
	CreateTextFile("logs/pos.log", MapCommon.PlayerLocation.MAP .. L"," .. MapCommon.PlayerLocation.X .. L"," .. MapCommon.PlayerLocation.Y .. L"!")
		
	-- is the player in combat?
	local isBattling = inlineIf(activeFight, 1, 0)

	-- get the player health percent
	local intHealth = (WindowData.PlayerStatus.CurrentHealth / WindowData.PlayerStatus.MaxHealth) * 100

	-- is the player alive?
	local isDead = inlineIf(Interface.IsPlayerDead, 1, 0)

	-- create the position file for uo mapper
	CreateTextFile("logs/pos2.log", MapCommon.PlayerLocation.MAP .. L"," .. MapCommon.PlayerLocation.X .. L"," .. MapCommon.PlayerLocation.Y .. L"," .. intHealth .. L"," .. isBattling .. L"," .. isDead .. L"!")
end

function MapCommon.IsBoatFacet()

	-- is this the new player quest area?
	if MapCommon.AreaDescription == "New Player Quest Area" then
		return false
	end

	-- get the player location
	local x = WindowData.PlayerLocation.x
	local y = WindowData.PlayerLocation.y
	local facet = WindowData.PlayerLocation.facet

	-- is this a map where you can use boats?
	if facet ~= 0 and facet ~= 1 and facet ~= 4 then
		return false
	end
	
	-- is this trammel or felucca?
	if facet == 0 or facet == 1 then

		 -- lost lands? we just need the half where the boats can go.
		if ((x >= MapCommon.sextantLostLandTopLeftX) and (y > MapCommon.sextantLostLandTopLeftY and y < 3290)) then
			return true

		 -- rest of the world
		elseif x < MapCommon.sextantMaximumX and y < MapCommon.sextantMaximumY then
			return true
		end	  
		
	-- tokuno
	elseif facet == 4 then
		return true
	end
	
	return false
end

MapCommon.CurrentArea = ""
MapCommon.CurrentSubArea = ""
MapCommon.AreaDescription = ""
MapCommon.OnWater = false
MapCommon.PlayerLocation = { X = 0, Y = 0, MAP = 0 }

MapCommon.AreaRefreshDelay = 0.25
MapCommon.AreaDelta = 0

function MapCommon.UpdateAreaInfo(timePassed)

	-- get the current terrain type
	local currTerrain = LuaGetTerrainType(WindowData.PlayerLocation.x, WindowData.PlayerLocation.y)

	-- is this a champion spawn area?
	local champ = (MapCommon.isChampionSpawn(MapCommon.CurrentSubArea) or MapCommon.isChampionSpawn(MapCommon.CurrentArea))
	
	-- is the player in war mode (and not dead or in a champion spawn area)?
	local activeFight = WindowData.PlayerStatus.InWarMode and not champ and not Interface.IsPlayerDead
		
	-- has the player moved?
	if (MapCommon.PlayerLocation.X ~= WindowData.PlayerLocation.x or MapCommon.PlayerLocation.Y ~= WindowData.PlayerLocation.y or MapCommon.PlayerLocation.MAP ~= WindowData.PlayerLocation.facet) then
	
		-- trigger the player moved event
		Interface.OnPlayerMove(MapCommon.PlayerLocation.X, MapCommon.PlayerLocation.Y, MapCommon.PlayerLocation.MAP,  WindowData.PlayerLocation.x, WindowData.PlayerLocation.y, WindowData.PlayerLocation.facet)

		-- update the current location
		MapCommon.PlayerLocation.X = WindowData.PlayerLocation.x
		MapCommon.PlayerLocation.Y = WindowData.PlayerLocation.y
		MapCommon.PlayerLocation.MAP = WindowData.PlayerLocation.facet
		
		-- create the uo mapper output (if enabled)
		MapCommon.UOMapperSend()
	end
	
	-- incerase the area check timer
	MapCommon.AreaDelta = MapCommon.AreaDelta + timePassed

	-- is it time to update the area?
	if MapCommon.AreaDelta > MapCommon.AreaRefreshDelay then
		
		-- reset the timer
		MapCommon.AreaDelta = 0

		-- update the area description text and get the area data
		local mainarea, areaData = MapCommon.UpdateAreaDescription()
		
		-- handle the area music
		MapCommon.MusicManagement(mainarea, areaData)
	end
end

function MapCommon.UpdateAreaDescription()

	-- get the current location
	local x = MapCommon.PlayerLocation.X
	local y = MapCommon.PlayerLocation.Y
	local z = WindowData.PlayerLocation.z
	local facet = MapCommon.PlayerLocation.MAP
		
	-- were we in the water?		
	local oldonwater = MapCommon.OnWater

	-- store the previous area
	local oldarea = MapCommon.CurrentArea
	local oldsubarea = MapCommon.CurrentSubArea

	-- are we in the water now?
	MapCommon.OnWater = PlayerIsOnWater()

	-- initialize the variables
	local notFound = false
	local area
	local subarea
	local desc
	local extraDesc = ""

	-- get the current shard ID
	local currShard = UserData.Settings.Login.lastShardSelected

	-- are we in the water in a map that allows boats?
	if (facet == 0 or facet == 1 or facet == 4) and PlayerIsOnWater() then

		-- are we in shallow water?
		if currTerrain == 52 then
			extraDesc = " - Shallow Water"

		else -- deep sea
			extraDesc = " - Deep Sea"
		end
	end
		
	-- initialize the area data variables
	local areaData, mainarea

	-- scan all the known areas
	for areaName, value in pairs(KnownAreas) do

		-- flag that we have found the area we're on
		notFound = true

		-- scan all the main areas 
		for i = 1, #KnownAreas[areaName].MainAreas do

			-- does this area is shard specific?
			local areaShard = KnownAreas[areaName].MainAreas[i].shard

			-- is the current location part of this area (and in the right shard if it's a shard specific area)?
			if (MapCommon.CheckSquareTable(x, y, z, facet, KnownAreas[areaName].MainAreas[i]) and (not areaShard or currShard == areaShard)) then

				-- store the area name
				area = areaName

				-- store the main area data
				mainarea = KnownAreas[areaName]

				-- store the area data (same as the main area for now)
				areaData = KnownAreas[areaName]

				-- store the area internal name
				desc = KnownAreas[areaName].MainAreas[i].name

				-- flag that we have found the area
				notFound = false

				break
			end
		end
			
		-- if we haven't found anything at this point we can move to the next main area
		if notFound then
			continue
		end
			
		-- scan all the sub areas
		for sub, value in pairs(KnownAreas[areaName].SubAreas) do

			-- initialize the flag that indicates if we are in a sub-area
			local found	

			-- scan all the sub-areas rectangles
			for i = 1, #KnownAreas[areaName].SubAreas[sub].Squares do
					
				-- does this area is shard specific?
				local areaShard = KnownAreas[areaName].SubAreas[sub].Squares[i].shard

				-- is the current location part of this sub area (and in the right shard if it's a shard specific area)?
				if (MapCommon.CheckSquareTable(x, y, z, facet, KnownAreas[areaName].SubAreas[sub].Squares[i]) and (not areaShard or currShard == areaShard)) then

					-- set the flag that we have found a sub-area
					found = KnownAreas[areaName].SubAreas[sub].Prior
						
					-- update the area data with the sub area data
					areaData = KnownAreas[areaName].SubAreas[sub]

					-- store the sub-area internal name
					subarea = sub

					-- get the area name
					desc = KnownAreas[areaName].SubAreas[sub].Squares[i].name

					break
				end
			end

			-- if we have found something we can get out of this cycle too
			if found then
				break
			end
		end
	end
		
	-- update the area data with the new ones
	MapCommon.AreaDescription = desc
	MapCommon.CurrentArea = area
	MapCommon.CurrentSubArea = subarea
			
	-- is the area changed?
	if oldarea ~= area or oldsubarea ~= subarea or oldonwater ~= PlayerIsOnWater() then

		-- trigger the area change event
		Interface.OnAreaChange(oldarea, oldsubarea, area, subarea)
	end
		
	-- do we have an area but not the name?
	if not desc and area then

		-- do we have a sub area?
		if subarea then
				
			-- use the sub-area internal name
			MapCommon.AreaDescription = subarea .. extraDesc

		else -- use the area internal name
			MapCommon.AreaDescription = area .. extraDesc
		end
	end

	-- do we have the area data?
	if MapCommon.CurrentArea and KnownAreas[MapCommon.CurrentArea] then
		
		-- do we have a sub area?
		if MapCommon.CurrentSubArea then

			-- toggle the guards button based on if the main area or sub area are guarded
			StatusWindow.UopdateStatusGuardsButton(KnownAreas[MapCommon.CurrentArea].Guarded or KnownAreas[MapCommon.CurrentArea].SubAreas[MapCommon.CurrentSubArea].Guarded)

		else -- only main area
			-- toggle the guards button based on if the main area is guarded
			StatusWindow.UopdateStatusGuardsButton(KnownAreas[MapCommon.CurrentArea].Guarded)
		end

	else -- unknown area (probably unguarded)
		StatusWindow.UopdateStatusGuardsButton(false)
	end

	return mainarea, areaData
end

function MapCommon.MusicManagement(mainarea, areaData)

	-- is the music enabled?
	if not Interface.DisableAreaMusic and Interface.ECPlaySoundActive then

		-- is this a champion spawn area?
		MapCommon.ChampionArea = areaData and (areaData.MainMusic == "$RandomChampion$" or areaData.Music == "$RandomChampion$")

		-- is the player fighting?
		local activeFight = (Interface.IsFighting or WindowData.PlayerStatus.InWarMode) and not MapCommon.ChampionArea and not Interface.IsPlayerDead

		-- is the player alive?
		if not Interface.IsPlayerDead then

			-- are we playing the death music?
			if MapCommon.DeadMusic then

				-- delete the current music data
				MapCommon.CurrentAreaMusic = nil

				-- stop the current music
				ECPlaySound(1, "", 1)
			end
			
			-- clear the dead music flag
			MapCommon.DeadMusic = nil
		end
			
		-- are we on water?
		if not MapCommon.OnWater then

			-- are we playing thw water music?
			if MapCommon.WaterMusic then

				-- delete the current music data
				MapCommon.CurrentAreaMusic = nil

				-- stop the current music
				ECPlaySound(1, "", 1)
			end

			-- clear the water music flag
			MapCommon.WaterMusic = nil
		end
			
		-- is the player NOT fighting and is not in a champion spawn area^
		if not activeFight and not MapCommon.ChampionArea then

			-- are we playing the combat music?
			if MapCommon.WarMusic then

				-- delete the current music data
				MapCommon.CurrentAreaMusic = nil

				-- stop the current music
				ECPlaySound(1, "", 1)
			end

			-- clear the combat music flag
			MapCommon.WarMusic = nil
		end
			
		-- initialize the music variable
		local music

		-- do we have the area data and the area has a specific music? (for sub-areas)
		if areaData and areaData.Music and areaData.Music ~= "" then

			-- get the sub-area music name
			music = areaData.Music

		-- is this a main area and the area has a specific music?
		elseif areaData and areaData.MainMusic and areaData.MainMusic ~= "" then

			-- get the area music name
			music = areaData.MainMusic

		-- do we have the main area data only and the main area has a music?
		elseif mainarea and mainarea.MainMusic and mainarea.MainMusic ~= "" then

			-- get the main area music name
			music = mainarea.MainMusic
		end
			
		-- do we have an empty string for music? nullify the music name then
		if music == "" then
			music = nil
		end
			
		-- do we have a music to play?
		if music then

			-- are we playing random wild music?
			if MapCommon.WildMusic then

				-- delete the current music data
				MapCommon.CurrentAreaMusic = nil

				-- stop the current music
				ECPlaySound(1, "", 1)
			end

			-- clear the wild music flag
			MapCommon.WildMusic = nil
		end
			
		-- is the player dead?
		if Interface.IsPlayerDead then

			-- are we playing a dead music?
			if not MapCommon.DeadMusic or not MapCommon.CurrentAreaMusic then

				-- get a random dead music
				local music = "Dead" .. math.random(Interface.DeadSongs) .. ".mp3"

				-- is this song different from the one currently playing?
				if MapCommon.CurrentAreaMusic ~= music then

					-- play the new song
					ECPlaySound(1, music, 2)

					-- store the new music title
					MapCommon.CurrentAreaMusic = music

					-- flag that we are playing a dead music
					MapCommon.DeadMusic = true
				end
			end
				
		-- is the player fighting and we're not playing a fighting song?
		elseif activeFight and (not MapCommon.WarMusic or not MapCommon.CurrentAreaMusic) then

			-- song type name
			local type = "WarMode"

			-- song type count
			local count = Interface.WarSongs

			-- is the player on water?
			if PlayerIsOnWater() then

				-- change the type to sea war song
				type = "SeaWarMode"

				-- get the new count for the new type
				count = Interface.SeaWarSongs
			end

			-- get a random song 
			music = type .. math.random(count) .. ".mp3"

			-- is this song different from the one currently playing?
			if MapCommon.CurrentAreaMusic ~= music then

				-- play the new song
				ECPlaySound(1, music, 2)

				-- store the new music title
				MapCommon.CurrentAreaMusic = music

				-- flag that we are playing a war song
				MapCommon.WarMusic = true
			end
				
		-- is the player on water and NOT fighting?
		elseif MapCommon.OnWater then

			-- is the player fighting?
			if not activeFight then

				-- get the sea song title
				music = "Sea.mp3"

				-- is this song different from the one currently playing?
				if MapCommon.CurrentAreaMusic ~= music then

					-- play the new song
					ECPlaySound(1, music, 2)

					-- store the new music title
					MapCommon.CurrentAreaMusic = music

					-- flag that we are playing a water song
					MapCommon.WaterMusic = true
				end
			end
				
		-- we have no specific music for the area and we are not playing a wild song?
		elseif not music and (not MapCommon.WildMusic or not MapCommon.CurrentAreaMusic) then

			-- get a random wild song
			local music = "WildSong" .. math.random(Interface.WildSongs) .. ".mp3"

			-- is the player fighting?
			if not activeFight then

				-- is this song different from the one currently playing?
				if MapCommon.CurrentAreaMusic ~= music then

					-- play the new song
					ECPlaySound(1, music, 2)

					-- store the new music title
					MapCommon.CurrentAreaMusic = music

					-- clear the original area music
					MapCommon.originalAreaMus = nil

					-- flag that we are playing a wild song
					MapCommon.WildMusic = true
				end
			end
				
		-- do we have a specific song to play?
		elseif music then			

			-- do we need to play a random tavern song?
			if music == "$RandomTavern$" then

				-- are we already playing a random tavern song?
				if MapCommon.CurrentAreaMusic and string.find(MapCommon.CurrentAreaMusic, "Tavern", 1, true) then

					-- get the current area music
					music = MapCommon.CurrentAreaMusic

				else -- play a random tavern song
					music = "Tavern" .. math.random(Interface.TavernSongs) .. ".mp3"
				end
			end

			-- do we have to play a random champion spawn song?
			if music == "$RandomChampion$" then

				-- are we already playing a random champion spawn song?
				if MapCommon.CurrentAreaMusic and string.find(MapCommon.CurrentAreaMusic, "Champion", 1, true) then

					-- get the current area music
					music = MapCommon.CurrentAreaMusic

				else -- play a random champion spawn song
					music = "Champion" .. math.random(Interface.ChampionSongs) .. ".mp3"
				end

				-- remove the active fight flag
				activeFight = nil

				-- remove the war music flag
				MapCommon.WarMusic = nil
			end

			-- are we NOT fighting and we are not playing a wild song?
			if not activeFight and (not MapCommon.WildMusic or not MapCommon.CurrentAreaMusic) then

				-- is this song different from the one currently playing?
				if MapCommon.CurrentAreaMusic ~= music then

					-- play the new song
					ECPlaySound(1, music, 2)

					-- store the new music title
					MapCommon.CurrentAreaMusic = music

					-- set the original area music
					MapCommon.originalAreaMus = music

					-- set the loops amount
					Interface.Loops = 0
				end
			end
		end
	end	
end

function MapCommon.UpdatePlayerLocation()
	
	-- make sure a map is visible
	if not MapCommon.IsMapVisible() then
		return
	end

	-- get the map we are zooming (atlas or minimap)
	local mapWindow = MapCommon.GetActiveMap()

	-- get the current facet
	local facet = WindowData.PlayerLocation.facet

	-- get the current area
    local area = UOGetRadarArea()

	-- initialize the coordinates string
	local Sextant

	-- fix the facet for certain areas.
	if (facet == 5 and (area == 2 or area == 7)) then
		facet = 0
	end

	-- are we on trammel or felucca or in the lost lands or any other facet?
	if (facet == 0 and (area == 0 or area == MapCommon.sextantFeluccaLostLands)) or (facet == 1 and (area == 0 or area == MapCommon.sextantTrammelLostLands) or facet > 1) then

		-- calculate latitude and longitude based on the current player position
		local latStr, longStr, latDir, longDir = MapCommon.GetSextantLocationStrings(WindowData.PlayerLocation.x, WindowData.PlayerLocation.y, facet)

		-- set the string with lat/long and x/y
		Sextant = L": " .. latStr .. L"'" .. latDir .. L" " .. longStr .. L"'" .. longDir .. L" (" .. WindowData.PlayerLocation.x .. L", " .. WindowData.PlayerLocation.y .. L", " .. WindowData.PlayerLocation.z .. L")"

	else -- set the string with x/y ONLY
		Sextant = L": " .. WindowData.PlayerLocation.x .. L", " .. WindowData.PlayerLocation.y .. L", " .. WindowData.PlayerLocation.z
	end

	-- we use a shorter wording in the minimap
	if mapWindow == "MapWindow" then
		Sextant = GetStringFromTid(1018327) .. Sextant -- Location

	else -- in the atlas we have more space and we can spare extra words
		Sextant = GetStringFromTid(1078897) .. Sextant -- Your Location
	end

	-- set the area name on top of the minimap
	LabelSetText(mapWindow .. "PlayerCoordsText", Sextant)

	-- next part is for the minimap only
	if mapWindow ~= "MapWindow" then
		return
	end

	-- initialize the area name variable
	local areaName = L""

	-- do we have an area description?
	if MapCommon.AreaDescription then

		-- use the current area description
		areaName = towstring(MapCommon.AreaDescription)

	else -- try to find an area name
		
		-- do we have a sub-area?
		if MapCommon.CurrentSubArea then

			-- use the sub-area name
			areaName = towstring(MapCommon.CurrentSubArea)

		-- do we have a main area?
		elseif MapCommon.CurrentArea then
				
			-- use the main area name
			areaName = towstring(MapCommon.CurrentArea)

		-- is the player on the water outside of every area?
		elseif MapCommon.OnWater then

			-- the player is on the sea
			areaName = L"Sea"

		else -- we are unable to determine the area name, so we show the map name
			areaName = GetStringFromTid(UORadarGetFacetLabel(WindowData.PlayerLocation.facet))
		end
	end
	
	-- set the area name on top of the minimap
	LabelSetText(mapWindow .. "MapName", areaName)
end

function MapCommon.CheckSquareTable(x, y, z, map, region)

	-- get the area rectangle corners
	local x1 = region.x1
	local y1 = region.y1
	local x2 = region.x2
	local y2 = region.y2
	local map2 = region.map

	-- do we have a z value?
	if region.z then
		
		-- are we exactly at the region z, or in a tollerance area of +/-5?
		if (region.z == z or (z >= region.z - 5 and z <= region.z + 5)) then

			-- do we have a ray?
			if region.r then

				-- check if we are inside the circle
				return MapCommon.CheckCircle(x, y, map, x1, y1, region.r, map2)

			-- do we have the square center?
			elseif region.squareCenter then

				-- check if we are inside the square
				return MapCommon.CheckSquareByCenter(x, y, map, x1, y1, region.squareCenter, map2)

			-- do we have the width and height?
			elseif region.w then

				-- check inside the rectangle
				return MapCommon.CheckSquare(x, y, map, x1, y1, x1 + region.w, y1 + region.h, map2)

			else -- check inside the square
				return MapCommon.CheckSquare(x, y, map, x1, y1, x2, y2, map2)
			end
			
		else -- outside the z range
			return false
		end

	else -- ignore z value

		-- do we have a ray?
		if region.r then

			-- check if we are inside the circle
			return MapCommon.CheckCircle( x, y, map, x1, y1, region.r, map2 )

		-- do we have the square center?
		elseif region.squareCenter then

			-- check if we are inside the square
			return MapCommon.CheckSquareByCenter( x, y, map, x1, y1, region.squareCenter, map2 )

		-- do we have the width and height?
		elseif region.w then

			-- check inside the rectangle
			return MapCommon.CheckSquare( x, y, map, x1, y1, x1 + region.w, y1 + region.h, map2 )
		
		else  -- check inside the square
			return MapCommon.CheckSquare( x, y, map, x1, y1, x2, y2, map2 )
		end
	end
end

function MapCommon.CheckCircle(x, y, map, x1, y1, r, map2)
	-- x1, y1 = TOP LEFT
	-- x2, y2 = BOTTOM RIGHT
	-- map2 = square map
	
	-- calculate the circumference
	local c = math.pow(x - x1, 2) + math.pow(y - y1, 2)

	-- is the point x, y, map inside the circumference?
	if c <= math.pow(r, 2) and (map == map2) then
	
		return true
	end

	return false
end

function MapCommon.CheckSquareByCenter(x, y, map, x1, y1, center, map2)
	-- x1, y1 = TOP LEFT
	-- x2, y2 = BOTTOM RIGHT
	-- map2 = square map
	
	-- create a square around the specified x, y coordinates
	x2 = x1 + center
	y2 = y1 + center
	
	x1 = x1 - center
	y1 = y1 - center

	-- check if the x, y, map point is inside the created square
	return MapCommon.CheckSquare(x, y, map, x1, y1, x2, y2, map2)
end

function MapCommon.CheckSquare(x, y, map, x1, y1, x2, y2, map2)
	-- x1, y1 = TOP LEFT
	-- x2, y2 = BOTTOM RIGHT
	-- map2 = square map
	
	-- make sure we have the coordinates
	if not x or not x1 or not x2 then
		return false
	end

	-- check if a the x, y, map point is inside the specified area
	if (x >= x1 and y >= y1) and (x <= x2 and y <= y2) and (map == map2) then
		return true
	end
	return false
end

function MapCommon.MapOnMouseWheel(x, y, delta)

	-- do we have the tmap overlay active?
	if IsValidID(AtlasWindow.TmapID) then
		return
	end

	-- zoom the map
   	MapCommon.AdjustZoom(-delta)
end

function MapCommon.ZoomOutOnLButtonUp()
   	MapCommon.AdjustZoom(2)
end

function MapCommon.ZoomInOnLButtonUp()
    MapCommon.AdjustZoom(-2)
end

function MapCommon.WPFilterOnLButtonUp()

	-- get the map we are zooming (atlas or minimap)
	local mapWindow = MapCommon.GetActiveMap()
	
	-- verify and fix the waypoints filters
    local filterString = MapCommon.VerifyFilterString(Interface.Settings[mapWindow .. "_WPFilters"])

	-- reset the context menu
	ContextMenu.CleanUp()

	-- count how many filters are active
	local _, activeFiltersCount = string.gsub(Interface.Settings[mapWindow .. "_WPFilters"], "1", "")

	 -- enable all
	ContextMenu.CreateLuaContextMenuItem({tid = 205, returnCode = MapCommon.ContextReturnCodes.ALL_FILTERS, flags = inlineIf(activeFiltersCount < table.countElements(MapCommon.WaypointFilters) and activeFiltersCount >= 0, 0, ContextMenu.GREYEDOUT)})
	
	-- disable all
	ContextMenu.CreateLuaContextMenuItem({tid = 206, returnCode = MapCommon.ContextReturnCodes.NO_FILTERS, flags = inlineIf(activeFiltersCount >= 1, 0, ContextMenu.GREYEDOUT)})

	-- add an empty line
	ContextMenu.CreateLuaContextMenuItem(ContextMenu.EmptyLine)

	-- scan all the filters
	for id, data in pairsByIndex(MapCommon.WaypointFilters) do

		-- add the filter to the context menu
		ContextMenu.CreateLuaContextMenuItem({tid = data.tid, returnCode = MapCommon.ContextReturnCodes.DISABLE_FILTER, param = { id = id, filterString = filterString }, pressed = MapCommon.IsFilterEnabled(filterString, id)})
	end

	-- show the context menu
	ContextMenu.ActivateLuaContextMenu(MapCommon.ContextMenuCallback)
end

function MapCommon.TiltMap()

	-- is the map tilted at 45�?
    if MapCommon.Tilt == 45 then

		-- switch to 0�
		MapCommon.Tilt = 0

    else -- if the map is tilted at 0�, we change it to 45�
		MapCommon.Tilt = 45
    end	

	-- update the map
	Interface.UpdateMap(true)

	-- refresh the waypoints
	MapCommon.WaypointsDirty =  true
end

function MapCommon.ZoomOutOnMouseOver()

	-- create the zoom out tooltip
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(MapCommon.TID.ZoomOut))
end

function MapCommon.ZoomInOnMouseOver()

	-- create the zoom in tooltip
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(MapCommon.TID.ZoomIn))
end

function MapCommon.TiltMapTooltip()

	-- create the tilt map tooltip
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(MapCommon.TID.TiltMap))
end

function MapCommon.WPFilterTooltip()

	-- create the waypoints filter tooltip
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(MapCommon.TID.WaypointsFilter))
end

function MapCommon.WPPlayerLocOnMouseOver()

	-- create the waypoints filter tooltip
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(MapCommon.TID.WaypointHere))
end

function MapCommon.Locate(x, y, map)

	-- is the atlas visible?
	if not WindowGetShowing("AtlasWindow") then

		-- open the atlas
		AtlasWindow.ShowAtlas()
	end

	-- scan all the areas in the specified map
	for areaIndex = UORadarGetAreaCount(map), 0, -1  do

		-- is the location in this area?
		if UORadarIsLocationInArea(x, y, map, areaIndex) then

			-- scroll the atlas to the location
			UOCenterRadarOnLocation(x, y, map, areaIndex, false)

			-- refresh the waypoints
			MapCommon.WaypointsDirty =  true

			return
		end	
	end
end

function MapCommon.IsFilterEnabled(filterString, filter)
	
	-- each digit in the string is a filter (ex. 3 = party). If it's 1 is enabled, if it's 0 is disabled.
	-- check MapCommon.WaypointFilters to learn all the indexes
	return tonumber(string.getChar(filterString, filter)) == 1
end

function MapCommon.VerifyFilterString(filterString)

	-- do we have the filter string?
	if not filterString then

		-- initialize a filter string with all active
		filterString = ""

	else -- make sure the value is a string
		filterString = tostring(filterString)
	end

	-- initialize the new string
	local newString = ""

	-- scan all the characters in the string
	for i = 1, string.len(filterString) do

		-- get the character
		local num = string.getChar(filterString, i)
		
		-- if there is an e (like e+015), we need to remove the esponential values entirely by exiting the cycle
		if num == "e" then
			break

		-- if we have a "." we move to the next character because the number might have been converted to esponential
		elseif num == "." then
			continue

		-- if the character is not 0 or 1 or not a number, we replace it with 1 and move forward
		elseif not tonumber(num) or (tonumber(num) ~= 0 and tonumber(num) ~= 1) then
			num = 0
		end

		newString = newString .. num
	end

	-- update the noto string
	filterString = newString

	-- do we have less numbers than filters? enable the missing filters
	while string.len(filterString) < table.countElements(MapCommon.WaypointFilters) do
		filterString = filterString .. "1"
	end

	return filterString
end

function MapCommon.IsEodon(x, y, facet)

	-- flag that indicates if the area is considered eodon
	local isEodon = false

	-- scan all the areas considered part of eodon
	for i = 1, #MapCommon.EodonCoordinates do

		-- get the area data for this element
		local rect = MapCommon.EodonCoordinates[i]
		
		-- check if the coordinates are inside the area
		isEodon = MapCommon.CheckSquare(x, y, facet, rect.x, rect.y, rect.x2, rect.y2, rect.map)

		-- if is true, we're done
		if isEodon == true then
			return isEodon
		end
	end
	
	return isEodon
end

function MapCommon.FindClosestMoongate(x, y, facet)

	-- initialize the best distance found variable
	local bestDistance
	local bestMoongate
	local bestAngle
	
	-- scan all the waypoints for this facet
	for _, data in pairsByIndex(Waypoints.Facet[facet]) do
				
		-- is this a moongate?
		if string.find(string.lower(data.Name), "moongate", 1, true) then

			-- calculate the distance difference between the current player location and the moongate location
			local deltaX = x - data.x
			local deltaY = y - data.y

			-- calculate the distance between the 2 points
			local distance = math.ceil(math.sqrt(math.pow(deltaX, 2) + math.pow(deltaY, 2)))

			-- calculate the rotation angle for the compass
			local angle = math.ceil(8 * (1 + math.deg(math.atan2( deltaX, deltaY )) / 360) - 0.5) % 8

			-- is this moongate distance closer than the one found before?
			if not bestDistance or distance < bestDistance then

				-- store the distance
				bestDistance = distance

				-- store the moongate data
				bestMoongate = data

				-- store the angle
				bestAngle = angle
			end
		end
	end

	return bestDistance, bestAngle, bestMoongate
end

function MapCommon.GetMapTid(x, y, facet)

	-- is the location in eodon?
	if MapCommon.IsEodon(x, y, facet) then
		return 1156262 -- valley of eodon

	else -- return the map tid
		return MapCommon.MapIDToTid[facet]
	end
end

function MapCommon.GetAreaID(x, y, facet)
	
	-- scan all the areas for the current facet
	for area = 0, UORadarGetAreaCount(facet) do

		-- dos this location belong to this area?
		if UORadarIsLocationInArea(x, y, facet, area) then

			-- return the area ID and wstring name
			return area, GetStringFromTid(UORadarGetAreaLabel(AtlasWindow.CurrFacet, area))
		end
	end
end

function MapCommon.DoesWaypointExist(waypointId, facet, itemId)
	
	-- scan all the waypoint types
	for wpType, dataRange in pairs(MapCommon.WaypointIDRange) do
		
		-- is this the waypoint type where the waypoint belongs?
		if waypointId >= dataRange.min and waypointId <= dataRange.max then

			-- is this a default waypoint?
			if wpType == "Player" or wpType == "Default" then

				-- get the waypoint data
				local wtype, wflags, wname, wfacet, wx, wy, wz = UOGetWaypointInfo(waypointId)

				-- if the waypoint has no name, it doesn't exist
				if not wname then
					return false
				end

			-- is this an UI waypoint?
			elseif wpType == "UI" then

				-- get the waypoint index
				local index = waypointId - MapCommon.WaypointIDRange.UI.min

				-- get the waypoint data
				local wtype, wflags, wname, wfacet, wx, wy, wz, iconId, iconDefaultScale = Waypoints.GetWaypointInfo(index, facet)
		
				-- if the waypoint has no name, it doesn't exist
				if not wname then
					return false
				end

			-- is this a vendor search waypoint and it's not there anymore?
			elseif wpType == "VendorSearch" and not Interface.VendorSearchMap then
				return false

			-- is this the charybdis waypoint and it's not there anymore?
			elseif wpType == "Charybdis" and not Interface.CharybdisLocation then
				return false

			-- is this a custom waypoint?
			elseif wpType == "Custom" then

				-- get the waypoint index
				local index = waypointId - MapCommon.WaypointIDRange.Custom.min

				-- get the waypoint data
				local wtype, wflags, wname, wfacet, wx, wy, wz, iconId, iconDefaultScale = Waypoints.GetCustomWaypointInfo(index, facet)
		
				-- if the waypoint has no name, it doesn't exist
				if not wname then
					return false
				end

			-- is this an sos waypoint?
			elseif wpType == "SOS" then
				return Interface.SOSWaypoints[itemId] ~= nil

			-- is this a tmap waypoint?
			elseif wpType == "Tmap" then
				return Interface.TmapWaypoints[itemId] ~= nil

			-- is this a tracking waypoint?
			elseif wpType == "Tracking" then
				
				-- get the waypoint index
				local index = waypointId - MapCommon.WaypointIDRange.Tracking.min

				-- if the waypoint doesn't exist or the mobile id is changed then the waypoint is gone
				return not TrackingPointer.TrackWaypoints[index] or TrackingPointer.TrackWaypoints[index].mobileId ~= itemId
			end
			
			-- if we got here, the waypoint exist
			return true
		end
	end

	return false
end

function MapCommon.GetMapHue(mapId)
	
	-- scan the table with the map colors
	for _, data in pairs(CourseMapWindow.MapTID) do

		-- is this the map we're looking for?
		if data.facetId == mapId then
			return data.hue
		end
	end
end

-------------------------------------------------------------------
-- INTERNAL TOOLS
-------------------------------------------------------------------

function MapCommon.MarkTop()

	-- mark the bottom corner of the area we need to map
	MapCommon.Top = "{ x1 = " .. WindowData.PlayerLocation.x .. ", y1 = " .. WindowData.PlayerLocation.y
end

function MapCommon.MarkBottom()

	-- do we have the top? (we must map the top first)
	if not MapCommon.Top then
		return
	end 

	-- create the whole string
	local total = MapCommon.Top .. ", x2 = " .. WindowData.PlayerLocation.x .. ", y2 = " .. WindowData.PlayerLocation.y .. ", map = " .. WindowData.PlayerLocation.facet .. " };"

	-- create the text file
	CreateTextFile("logs/region.txt", towstring(total))

	-- clear the top
	MapCommon.Top = nil
end

