----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

Moongate = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

Moongate.WindowName = "Moongate"

Moongate.GumpId = 600

-- DEFAULT BUTTONS
Moongate.OK = 1
Moongate.CANCEL = 2

Moongate.TidToTownName =
{
	[1012001] = -- Felucca
	{
		name = "Felucca",
		facet = 0,
		towns = 
		{
			[1012003] = "Moonglow",
			[1012004] = "Britain",
			[1012005] = "Jhelom",
			[1012006] = "Yew",
			[1012007] = "Minoc",
			[1012008] = "Trinsic",
			[1012009] = "SkaraBrae",
			[1012010] = "Magincia",
			[1019001] = "Bucca",
		}
	},

	[1012000] = -- Trammel
	{
		name = "Trammel",
		facet = 1,
		towns = 
		{
			[1012003] = "Moonglow",
			[1012004] = "Britain",
			[1012005] = "Jhelom",
			[1012006] = "Yew",
			[1012007] = "Minoc",
			[1012008] = "Trinsic",
			[1012009] = "SkaraBrae",
			[1012010] = "Magincia",
			[1078098] = "Haven",
		}
	},
	
	[1012002] = -- Ilshenar
	{
		name = "Ilshenar",
		facet = 2,
		towns = 
		{
			[1012015] = "Compassion",
			[1012016] = "Honesty",
			[1012017] = "Honor",
			[1012018] = "Humilty",
			[1012019] = "Justice",
			[1012020] = "Sacrifice",
			[1012021] = "Spirituality",
			[1012022] = "Valor",
			[1019000] = "Chaos",
		}
	},

	[1060643] = -- Malas
	{
		name = "Malas",
		facet = 3,
		towns = 
		{
			[1060641] = "Luna",
			[1060642] = "Umbra",
		}
	},

	[1063258] = -- Tokuno Islands
	{
		name = "Tokuno",
		facet = 4,
		towns = 
		{
			[1063412] = "Isamu",
			[1063413] = "Makoto",
			[1063414] = "Homare",
		}
	},

	[1113602] = -- Ter Mur & Eodon
	{
		name = "TerMur",
		facet = 5,
		towns = 
		{
			[1113603] = "RoyalCity",
			[1156262] = "ValleyOfEodon",
		}
	},
}

Moongate.Siege = false
Moongate.Red = false
Moongate.Locations = {}

Moongate.LastGate = "Moonglow-trammel"

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function Moongate.Initialize()

	-- flag the window to be destroyed on close
	Interface.DestroyWindowOnClose[Moongate.WindowName] = true

	-- restore the saved position
	WindowUtils.RestoreWindowPosition(Moongate.WindowName, false)

	-- set the window title
	WindowUtils.SetWindowTitle(Moongate.WindowName,GetStringFromTid(1023948))  -- Moongate
	
	-- destination label text
	LabelSetText(Moongate.WindowName .. "DestLabel", GetStringFromTid(1012011)) -- L"Destination"

	-- scan all the maps
	for tid, data in pairs(Moongate.TidToTownName) do

		-- set the map name
		LabelSetText(Moongate.WindowName .. data.name .. "Label", GetStringFromTid(tid))

		-- make the button a checkbox
		ButtonSetCheckButtonFlag(Moongate.WindowName .. data.name .. "Button", true)

		-- hide the related window
		WindowSetShowing(Moongate.WindowName .. data.name .. "Window", false)

		-- hide the map radio button
		WindowSetShowing(Moongate.WindowName .. data.name, false)

		-- set the map ID to the radio button
		WindowSetId(Moongate.WindowName .. data.name, tid)
	end
	
	-- go button text
	ButtonSetText(Moongate.WindowName .. "Go", GetStringFromTid(3010006)) -- L"GO!"

	-- default location button text
	ButtonSetText(Moongate.WindowName .. "GoDefault", GetStringFromTid(16)) -- Default Location

	-- set default button text
	ButtonSetText(Moongate.WindowName .. "SetDefault", wstring.titleCase(GetStringFromTid(1011300))) -- L"Set default!"

	-- are we on siege perilous (no trammel)?
	Moongate.Siege = Interface.ShardsList[UserData.Settings.Login.lastShardSelected] == L"Siege Perilous"
end

function Moongate.Shutdown()

	-- save the widnow position
	WindowUtils.SaveWindowPosition(Moongate.WindowName)
	
	-- is the gump still open?
	if GumpData.Gumps[Moongate.GumpId] then

		-- close the gump
		GumpsParsing.DestroyGump(Moongate.GumpId)
	end
end

function Moongate.MoongateParsing(gumpID, data)

	-- initialize the locations table
	Moongate.Locations = {}

	-- count the available maps
	local mapsAvailable = {}

	-- scan all the labels
	for id, dt in pairs(data.Labels) do
		
		-- do we have a TID and is a map TID?
		if dt.tid and Moongate.TidToTownName[dt.tid] then
			
			-- mark the map as available
			mapsAvailable[dt.tid] = true
		end
	end

	-- if the player is a murder there will be only felucca as map
	Moongate.Red = table.countElements(mapsAvailable) == 1

	-- first city label ID
	local start = table.countElements(mapsAvailable) + 5
	
	-- map ID to detract from the label ID
	local mapId = 1

	-- scan the map in order
	for tid, _ in pairsByKeys(mapsAvailable) do

		-- get the map data
		local mapData = Moongate.TidToTownName[tid]
		
		-- variable to store the label index from a map to the other
		local lastStart = 0

		-- sub-window name
		local childWindow = Moongate.WindowName .. mapData.name .. "WindowScrollChild"

		-- increase the map ID
		mapId = mapId + 1

		-- show the map radio
		WindowSetShowing(Moongate.WindowName .. mapData.name, true)

		-- is this the same map the player is in?
		if mapData.facet == WindowData.PlayerLocation.facet then

			-- activate this map
			Moongate.SwitchToMap(tid)
		end

		-- loop through the labels
		for i = start, (start + table.countElements(mapData.towns)) - 1 do
			
			-- get the city TID
			local cityTid = data.Labels[i].tid

			-- get the city name from TID
			local city = mapData.towns[cityTid]
			
			-- do we have the city in the table?
			if not Moongate.Locations[city] then

				-- initialize the city
				Moongate.Locations[city] =  {}
			end

			-- is this the felucca map?
			if tid == 1012001 then -- Felucca
				
				-- store the ID for felucca
				Moongate.Locations[city].felucca = i - mapId

			-- is this the trammel map?
			elseif tid == 1012000 then -- Trammel

				-- store the ID for trammel
				Moongate.Locations[city].trammel = i - mapId

			else -- other maps

				-- store the ID for any other map
				Moongate.Locations[city] = i - mapId
			end

			-- set the town name into the label
			LabelSetText(childWindow .. city .. "Label", GetStringFromTid(cityTid))

			-- set the label ID to the label
			WindowSetId(childWindow .. city, cityTid)

			-- turn the button into a checkbox
			ButtonSetCheckButtonFlag(childWindow .. city .. "Button", true)

			-- the valley of eodon is available only with ToL Expansion
			if cityTid == 1156262 and not Interface.ActiveAccountFeatures.Time_of_Legend then -- valley of eodon

				-- hide the checkbox
				WindowSetShowing(childWindow .. city, false)
			end

			-- store the ID for the next map
			lastStart = i
		end

		-- store the new starting ID
		start = lastStart + 2
	end
end

function Moongate.SwitchToMap(mapTid)

	-- do we have a valid map TID?
	if not IsValidID(mapTid) then
		return
	end

	-- scan all the maps
	for tid, data in pairs(Moongate.TidToTownName) do

		-- flag the map checkbox
		ButtonSetPressedFlag(Moongate.WindowName .. data.name .. "Button", tid == mapTid)

		-- show the map towns
		WindowSetShowing(Moongate.WindowName .. data.name .. "Window", tid == mapTid)
	end
end

function Moongate.ClearAllChecks()

	-- scan all the locations we have load
	for city, data in pairs(Moongate.Locations) do

		-- is the data a number?
		if tonumber(data) then

			-- untick the gump checkbox
			GumpsParsing.UnTickButton(Moongate.GumpId, data)

		else -- the data is a table

			-- does the data has the trammel value?
			if data.trammel then

				-- untick the gump checkbox
				GumpsParsing.UnTickButton(Moongate.GumpId, data.trammel)
			end

			-- does the data has the felucca value?
			if data.felucca then

				-- untick the gump checkbox
				GumpsParsing.UnTickButton(Moongate.GumpId, data.felucca)
			end
		end
	end

	-- scan all the maps
	for tid, mapData in pairs(Moongate.TidToTownName) do

		-- sub-window name
		local childWindow = Moongate.WindowName .. mapData.name .. "WindowScrollChild"

		-- scan all towns for the current map
		for townTid, townName in pairs(mapData.towns) do

			-- untick the checkbox
			ButtonSetPressedFlag(childWindow .. townName .. "Button",  false)
		end
	end
end

function Moongate.CheckLocation()

	-- get the current checkbox name
	local checkbox = SystemData.ActiveWindow.name

	-- is this the label or the button?
	if string.find(checkbox, "Button", 1, true) or string.find(checkbox, "Label", 1, true) then

		-- get the main element
		checkbox = WindowGetParent(checkbox)
	end

	-- get the sub window containing the checkbox
	local subWindow = WindowGetParent(checkbox)

	-- get the clicked town TID
	local currTid = WindowGetId(checkbox)

	-- remove the tick from all the checkboxes
	Moongate.ClearAllChecks()

	-- scan all the maps
	for tid, mapData in pairs(Moongate.TidToTownName) do

		-- sub-window name
		local childWindow = Moongate.WindowName .. mapData.name .. "WindowScrollChild"

		-- scan all towns for the current map
		for townTid, townName in pairs(mapData.towns) do

			-- tick the checkbox if it's the selected one
			ButtonSetPressedFlag(childWindow .. townName .. "Button", currTid == townTid and subWindow == childWindow)

			-- is this the correct TID of the selected town and it's the correct map (trammel e felucca share the same town TIDs)
			if currTid == townTid and subWindow == childWindow then

				-- get the button ID from the locations table
				local buttonId = Moongate.Locations[townName]

				-- by default there is no suffix
				local suffix = ""

				-- is this the felucca window?
				if tid == 1012001 then -- Felucca

					-- set the felucca suffix
					suffix = "-felucca"

					-- store the felucca ID
					buttonId = buttonId.felucca

				-- is this the trammel window?
				elseif tid == 1012000 then -- Trammel

					-- set the trammel suffix
					suffix = "-trammel"

					-- store the Trammel ID
					buttonId = buttonId.trammel
				end

				-- store the current selection
				Moongate.LastGate = townName .. suffix

				-- tick the checkbox into the gump
				GumpsParsing.TickButton(Moongate.GumpId, buttonId)
			end
		end
	end
end

function Moongate.ChangeMap()

	-- get the current checkbox name
	local checkbox = SystemData.ActiveWindow.name
	
	-- is this the label or the button?
	if string.find(checkbox, "Button", 1, true) or string.find(checkbox, "Label", 1, true) then

		-- get the main element
		checkbox = WindowGetParent(checkbox)
	end

	-- reset the last selected location
	Moongate.LastGate = "Moonglow-trammel"

	-- switch the map window
	Moongate.SwitchToMap(WindowGetId(checkbox))
	
	-- clear all checkboxes
	Moongate.ClearAllChecks()
end

function Moongate.GO()

	-- press the OK button in the gump
	GumpsParsing.PressButton(Moongate.GumpId, Moongate.OK)
end

function Moongate.SetDefault()

	-- is the new default location different from Moonglow -> Trammel?
	if Moongate.LastGate ~= "Moonglow-trammel" then

		-- save the new location
		Interface.SaveSetting("MoongateLastGate", Moongate.LastGate)
	end

	-- show a chat message to confirm the default location change
	ChatPrint(GetStringFromTid(502417), SystemData.ChatLogFilters.SYSTEM) -- New default location set.
end

function Moongate.GODefault()

	-- is the moongate window open? (in case is called from the actions)
	if not WindowGetShowing(Moongate.WindowName) then

		-- warning that the moongate window must be opnened first
		ChatPrint(GetStringFromTid(19), SystemData.ChatLogFilters.SYSTEM)

		return
	end
	
	-- system default location is Moonglow -> Trammel
	local default = "Moonglow-trammel"

	-- are we on siege or the player is a murder?
	if Moongate.Siege or Moongate.Red then

		-- move the system default location to Moonglow -> Felucca
		default = "Moonglow-felucca"
	end

	-- get the saved location
	local savedLocation = Interface.LoadSetting("MoongateLastGate", default)
	
	-- is the location in trammel?
	if string.find(savedLocation, "-trammel", 1, true) then

		-- get the buton ID
		savedLocation = Moongate.Locations[string.gsub(savedLocation, "-trammel", "")].trammel

	-- is the location in felucca?
	elseif (string.find(savedLocation, "-felucca", 1, true)) then

		-- get the buton ID
		savedLocation = Moongate.Locations[string.gsub(savedLocation, "-felucca", "")].felucca

	else -- any other map

		-- get the buton ID
		savedLocation = Moongate.Locations[savedLocation]
	end

	-- do we have a valid saved location?
	if IsValidID(savedLocation) then

		-- tick the location
		GumpsParsing.TickButton(Moongate.GumpId, savedLocation)

		-- go to the location
		Moongate.GO()

	else -- warn the player that there is no default location
		ChatPrint(GetStringFromTid(18), SystemData.ChatLogFilters.SYSTEM)
	end
end