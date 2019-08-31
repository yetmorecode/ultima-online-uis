----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

MobileBarsDockspot = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

MobileBarsDockspot.Dockspots = {}

MobileBarsDockspot.DockspotType = { PET = 1, PARTY = 2, PINNED = 3, MOBILES = 4 }

MobileBarsDockspot.SortType = { APPEARANCE = 1, HEALTH = 2, DISTANCE = 3 }

MobileBarsDockspot.LayoutType = { VERTICAL_10x2 = 1, VERTICAL_10x1 = 2, HORIZONTAL_5x2 = 3, HORIZONTAL_10x1 = 4 }

MobileBarsDockspot.SubFilters = { NEUTRALANIMALS = 1, SUMMON = 2, BOSS = 3, QUESTGIVER = 4, STABLEMASTERS = 5, BANKERS = 6, SHOPKEEPERS = 7, BODDEALERS = 8, PLAYERVENDORS = 9, SOMEONEPET = 10,  PLAYERS = 11}

MobileBarsDockspot.SubFiltersToFlag = 
{
	[MobileBarsDockspot.SubFilters.NEUTRALANIMALS] =	"isNeutralAnimal",
	[MobileBarsDockspot.SubFilters.SUMMON] =			"isSummon",
	[MobileBarsDockspot.SubFilters.BOSS] =				"isBoss",
	[MobileBarsDockspot.SubFilters.QUESTGIVER] =		"isQuestGiver",
	[MobileBarsDockspot.SubFilters.STABLEMASTERS] =		"isStableMaster",
	[MobileBarsDockspot.SubFilters.BANKERS] =			"isBanker",
	[MobileBarsDockspot.SubFilters.SHOPKEEPERS] =		"isShopkeeper",
	[MobileBarsDockspot.SubFilters.BODDEALERS] =		"isBodDealer",
	[MobileBarsDockspot.SubFilters.PLAYERVENDORS] =		"isPlayerVendor",
	[MobileBarsDockspot.SubFilters.SOMEONEPET] =		"isSomeonePet",
	[MobileBarsDockspot.SubFilters.PLAYERS] =			"isPlayer",
}

-- anchor offsets between the first bar and the dockspot
MobileBarsDockspot.OFFSET_X = 2
MobileBarsDockspot.OFFSET_Y = 2

-- offset between each bar
MobileBarsDockspot.OFFSET_BETWEEN_BARS = 2

-- update ratio in seconds
MobileBarsDockspot.DockspotUpdateRatio = 2

MobileBarsDockspot.SettingsScale = 0.7

MobileBarsDockspot.BarsInCreation = {}

-- this will be use as a temporary value until we get the max number of followers from the server
MobileBarsDockspot.PetsBarsCap = 5

-- (for party is 10, but if we exclude the player is 9)
MobileBarsDockspot.PartyBarsCap = 9

-- cap for the any other bar (excluding pet, party and pinned)
MobileBarsDockspot.MobileBarsCap = 20

-- cap for the pinned bars
MobileBarsDockspot.PinnedBarsCap = 10

MobileBarsDockspot.DockspotDefaultNames = 
{
	 [MobileBarsDockspot.DockspotType.PET] = "PetsDockspot",
	 [MobileBarsDockspot.DockspotType.PARTY] = "PartyDockspot",
	 [MobileBarsDockspot.DockspotType.MOBILES] = "MobilesDockspot",
	 [MobileBarsDockspot.DockspotType.PINNED] = "PinnedDockspot",
}

MobileBarsDockspot.ActiveFilter = 1
MobileBarsDockspot.TotalFilters = 1

-- filters applied to the mobiles list
MobileBarsDockspot.SavedFilters = {}

MobileBarsDockspot.SavedFilters[L"default"] = 
{
	
	-- ID of the filter
	id = 1,

	-- default notoriety filters
	notorieties =	
	{
		[NameColor.Notoriety.NONE]         =		0, -- mobile data still not loaded, never show
		[NameColor.Notoriety.INNOCENT]     =		20,
		[NameColor.Notoriety.FRIEND]       =		20,
		[NameColor.Notoriety.CANATTACK]    =		20,
		[NameColor.Notoriety.CRIMINAL]     =		20,
		[NameColor.Notoriety.ENEMY]        =		20,
		[NameColor.Notoriety.MURDERER]     =		20,
		[NameColor.Notoriety.INVULNERABLE] =		20,
		[NameColor.Notoriety.HONORED]	   =		0, -- always disabled in the mobiles list
	},
	
	-- default sub-filters
	subFilters =	
	{
		[MobileBarsDockspot.SubFilters.NEUTRALANIMALS] =		true,
		[MobileBarsDockspot.SubFilters.SUMMON] =				true,
		[MobileBarsDockspot.SubFilters.BOSS] =					true,
		[MobileBarsDockspot.SubFilters.QUESTGIVER] =			true,
		[MobileBarsDockspot.SubFilters.STABLEMASTERS] =			true,
		[MobileBarsDockspot.SubFilters.BANKERS] =				true,
		[MobileBarsDockspot.SubFilters.SHOPKEEPERS] =			true,
		[MobileBarsDockspot.SubFilters.BODDEALERS] =			true,
		[MobileBarsDockspot.SubFilters.PLAYERVENDORS] =			true,
		[MobileBarsDockspot.SubFilters.SOMEONEPET] =			true,
		[MobileBarsDockspot.SubFilters.PLAYERS] =				true,
	},

	-- custom text filter
	customText = L""
}

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function MobileBarsDockspot.Initialize()

	-- create the dockspot for pets
	MobileBarsDockspot.CreatePetsDockspot()

	-- create the dockspot for pets
	MobileBarsDockspot.CreatePartyDockspot()

	-- create the dockspot for pets
	MobileBarsDockspot.CreatePinnedDockspot()

	-- create the dockspot for pets
	MobileBarsDockspot.CreateMobilesDockspot()
end

function MobileBarsDockspot.Shutdown()

	-- get the current window name
	local dockspotName = SystemData.ActiveWindow.name

	-- remove the window from the snappable list
	SnapUtils.SnappableWindows[dockspotName] = nil

	-- save the window position
	WindowUtils.SaveWindowPosition(dockspotName)
end

function MobileBarsDockspot.CreatePetsDockspot()

	-- dockspot window name
	local dockspotName = MobileBarsDockspot.DockspotDefaultNames[MobileBarsDockspot.DockspotType.PET]
	
	-- does the dockspot already exist?
	if MobileBarsDockspot.Dockspots[dockspotName] then
		return
	end

	-- dockspot data record to be added to the dockspot table
	local dockspotData = {}

	-- load the auto-close on empty status
	dockspotData.autoClose = Interface.LoadSetting(dockspotName .. "autoClose", false)

	-- load the closing direction of the dockspot (left by default)
	dockspotData.closeLeft = Interface.LoadSetting(dockspotName .. "closeLeft", true)

	-- is the auto-close disabled?
	if not dockspotData.autoClose then
		
		-- load the visible status
		dockspotData.isClosed = Interface.LoadSetting(dockspotName .. "IsClosed", false)
	end

	-- load the sort type for the dockspot
	dockspotData.sortType = Interface.LoadSetting(dockspotName .. "sortType", MobileBarsDockspot.SortType.APPEARANCE)

	-- load the layout type for the dockspot
	dockspotData.layoutType = Interface.LoadSetting(dockspotName .. "layoutType", MobileBarsDockspot.LayoutType.VERTICAL_10x1)

	-- set the dockspot type
	dockspotData.dockspotType = MobileBarsDockspot.DockspotType.PET

	-- set the dockspot bars cap (if the cap is not available yet, we set 5, and we change it later)
	dockspotData.capBars = tonumber(WindowData.PlayerStatus["MaxFollowers"] or MobileBarsDockspot.PetsBarsCap) 

	-- the dockspot is locked by default, opening the settings makes it movable
	dockspotData.locked = true

	-- dockspot settings
	dockspotData.settings = 
	{
		{ name = "MainSubSection",	template = "DockspotSubSectionLabelTemplate",	anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"topleft",		parent,		"topleft",		20,		40)	end,	nameTid = 11 },
		{ name = "autoClose",		template = "DockspotLabelCheckButton",	anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,	nameTid = 419,	tooltipTid = 420 },
		{ name = "closeLeft",		template = "DockspotLabelCheckButton",	anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,	nameTid = 421,	tooltipTid = 422 },
		{ name = "sortType",		template = "DockspotLabelCombo",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,	nameTid = 423,	tooltipTid = 424,		comboFill = function(combo) local tab = {} for name, i in pairsByKeys(MobileBarsDockspot.SortType) do table.insert(tab, i, name) end for i, name in pairsByKeys(tab) do ComboBoxAddMenuItem(combo, FormatProperly(towstring(name)) ) end end   },
		{ name = "layoutType",		template = "DockspotLabelCombo",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,	nameTid = 425,	tooltipTid = 426,		comboFill = function(combo) local tab = {} for name, i in pairs(MobileBarsDockspot.LayoutType) do if i == 1 then continue end table.insert(tab, i, name) end for i, name in pairsByKeys(tab) do ComboBoxAddMenuItem(combo, FormatProperly(towstring(name)) ) end end },
	}

	-- create the dockspot
	CreateWindowFromTemplate(dockspotName, "MobileBarsDockspotTemplate", "Root")

	-- set the dockspot title and pets count
	MobileBarsDockspot.UpdatePetsCount()

	-- initialize the dockspot data table with the record we created
	MobileBarsDockspot.Dockspots[dockspotName] = dockspotData

	-- load the saved scale/alpha
	WindowUtils.LoadScale(dockspotName)

	-- apply the saved button rotation
	MobileBarsDockspot.ApplyButtonRotation(dockspotName)

	-- do we have a saved window position?
	if WindowUtils.CanRestorePosition(dockspotName) then

		-- restore the saved window position
		WindowUtils.RestoreWindowPosition(dockspotName, false)

	else -- default position

		-- clear the window position
		WindowClearAnchors(dockspotName)
		
		-- anchor the bar on the top-left of the screen
		WindowAddAnchor(dockspotName, "topleft", "Root", "topleft", 0, 0)
	end

	-- create the grid for the layout
	MobileBarsDockspot.CreateLayoutGrid(dockspotName)

	-- show/hide the dockspot based on the saved status
	MobileBarsDockspot.ToggleDockspot(dockspotName, true)
end

function MobileBarsDockspot.CreatePartyDockspot()

	-- dockspot window name
	local dockspotName = MobileBarsDockspot.DockspotDefaultNames[MobileBarsDockspot.DockspotType.PARTY]
	
	-- does the dockspot already exist?
	if MobileBarsDockspot.Dockspots[dockspotName] then
		return
	end

	-- dockspot data record to be added to the dockspot table
	local dockspotData = {}

	-- load the auto-close on empty status
	dockspotData.autoClose = Interface.LoadSetting(dockspotName .. "autoClose", true)

	-- load the closing direction of the dockspot (left by default)
	dockspotData.closeLeft = Interface.LoadSetting(dockspotName .. "closeLeft", false)

	-- load the flag that indicates if we shall leave the disabled bars in the list or not
	dockspotData.leaveDisabledBars = Interface.LoadSetting(dockspotName .. "leaveDisabledBars", true)

	-- is the auto-close disabled?
	if not dockspotData.autoClose then
		
		-- load the visible status
		dockspotData.isClosed = Interface.LoadSetting(dockspotName .. "IsClosed", false)
	end

	-- load the sort type for the dockspot
	dockspotData.sortType = Interface.LoadSetting(dockspotName .. "sortType", MobileBarsDockspot.SortType.APPEARANCE)

	-- load the layout type for the dockspot
	dockspotData.layoutType = Interface.LoadSetting(dockspotName .. "layoutType", MobileBarsDockspot.LayoutType.VERTICAL_10x1)

	-- set the dockspot type
	dockspotData.dockspotType = MobileBarsDockspot.DockspotType.PARTY

	-- set the dockspot bars cap (for party is 10, but if we exclude the player is 9)
	dockspotData.capBars = MobileBarsDockspot.PartyBarsCap

	-- the dockspot is locked by default, opening the settings makes it movable
	dockspotData.locked = true

	-- dockspot settings
	dockspotData.settings = 
	{
		{ name = "MainSubSection",		template = "DockspotSubSectionLabelTemplate",	anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"topleft",		parent,		"topleft",		20,		40)	end,	nameTid = 11 },
		{ name = "autoClose",			template = "DockspotLabelCheckButton",	anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,	nameTid = 419,	tooltipTid = 420 },
		{ name = "closeLeft",			template = "DockspotLabelCheckButton",	anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,	nameTid = 421,	tooltipTid = 422 },
		{ name = "leaveDisabledBars",	template = "DockspotLabelCheckButton",	anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,	nameTid = 427,	tooltipTid = 428 },
		{ name = "sortType",			template = "DockspotLabelCombo",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,	nameTid = 423,	tooltipTid = 424,		comboFill = function(combo) local tab = {} for name, i in pairsByKeys(MobileBarsDockspot.SortType) do table.insert(tab, i, name) end for i, name in pairsByKeys(tab) do ComboBoxAddMenuItem(combo, FormatProperly(towstring(name)) ) end end   },
		{ name = "layoutType",			template = "DockspotLabelCombo",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,	nameTid = 425,	tooltipTid = 426,		comboFill = function(combo) local tab = {} for name, i in pairs(MobileBarsDockspot.LayoutType) do if i == 1 then continue end table.insert(tab, i, name) end for i, name in pairsByKeys(tab) do ComboBoxAddMenuItem(combo, FormatProperly(towstring(name)) ) end end },
	}

	-- create the dockspot
	CreateWindowFromTemplate(dockspotName, "MobileBarsDockspotTemplate", "Root")

	-- set the dockspot title and pets count
	MobileBarsDockspot.UpdatePartyCount()

	-- initialize the dockspot data table with the record we created
	MobileBarsDockspot.Dockspots[dockspotName] = dockspotData

	-- load the saved scale/alpha
	WindowUtils.LoadScale(dockspotName)

	-- apply the saved button rotation
	MobileBarsDockspot.ApplyButtonRotation(dockspotName)

	-- do we have a saved window position?
	if WindowUtils.CanRestorePosition(dockspotName) then

		-- restore the saved window position
		WindowUtils.RestoreWindowPosition(dockspotName, false)

	else -- default position

		-- clear the window position
		WindowClearAnchors(dockspotName)
	
		-- anchor the bar on the top-right of the game area
		WindowAddAnchor(dockspotName, "topright", "ResizeWindow", "topright", 0, 0)
	end

	-- create the grid for the layout
	MobileBarsDockspot.CreateLayoutGrid(dockspotName)

	-- show/hide the dockspot based on the saved status
	MobileBarsDockspot.ToggleDockspot(dockspotName, true)
end

function MobileBarsDockspot.CreateMobilesDockspot()

	-- dockspot window name
	local dockspotName = MobileBarsDockspot.DockspotDefaultNames[MobileBarsDockspot.DockspotType.MOBILES]
	
	-- does the dockspot already exist?
	if MobileBarsDockspot.Dockspots[dockspotName] then
		return
	end

	-- dockspot data record to be added to the dockspot table
	local dockspotData = {}

	-- load the auto-close on empty status
	dockspotData.autoClose = Interface.LoadSetting(dockspotName .. "autoClose", false)

	-- load the closing direction of the dockspot (left by default)
	dockspotData.closeLeft = Interface.LoadSetting(dockspotName .. "closeLeft", false)

	-- is the auto-close disabled?
	if not dockspotData.autoClose then
		
		-- load the visible status
		dockspotData.isClosed = Interface.LoadSetting(dockspotName .. "IsClosed", false)
	end

	-- load the option to show friends ina column and foe in the other
	dockspotData.friendFoe = Interface.LoadSetting(dockspotName .. "friendFoe", false)

	-- load the sort type for the dockspot
	dockspotData.sortType = Interface.LoadSetting(dockspotName .. "sortType", MobileBarsDockspot.SortType.DISTANCE)

	-- load the friends sort type for the dockspot
	dockspotData.friendsSortType = Interface.LoadSetting(dockspotName .. "friendsSortType", MobileBarsDockspot.SortType.HEALTH)

	-- load the layout type for the dockspot
	dockspotData.layoutType = Interface.LoadSetting(dockspotName .. "layoutType", MobileBarsDockspot.LayoutType.VERTICAL_10x2)

	-- set the dockspot type
	dockspotData.dockspotType = MobileBarsDockspot.DockspotType.MOBILES

	-- set the dockspot bars cap 
	dockspotData.capBars = MobileBarsDockspot.MobileBarsCap

	-- the dockspot is locked by default, opening the settings makes it movable
	dockspotData.locked = true

	-- dockspot settings
	dockspotData.settings = 
	{
		{ name = "MainSubSection",		template = "DockspotSubSectionLabelTemplate",	anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"topleft",		parent,		"topleft",	   25,		35)	end,	nameTid = 11 },
		{ name = "autoClose",			template = "DockspotLabelCheckButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		10) end,	nameTid = 419,		tooltipTid = 420 },
		{ name = "closeLeft",			template = "DockspotLabelCheckButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		10) end,	nameTid = 421,		tooltipTid = 422 },
		{ name = "friendFoe",			template = "DockspotLabelCheckButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		10) end,	nameTid = 448,		tooltipTid = 449,		hideElementsFalse = { "friendsSortType" } },
		{ name = "sortType",			template = "DockspotLabelCombo",				anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		10) end,	nameTid = 423,		tooltipTid = 424,		comboFill = function(combo) local tab = {} for name, i in pairsByKeys(MobileBarsDockspot.SortType) do table.insert(tab, i, name) end for i, name in pairsByKeys(tab) do ComboBoxAddMenuItem(combo, FormatProperly(towstring(name)) ) end end   },
		{ name = "friendsSortType",		template = "DockspotLabelCombo",				anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		10) end,	nameTid = 528,		tooltipTid = 424,		comboFill = function(combo) local tab = {} for name, i in pairsByKeys(MobileBarsDockspot.SortType) do table.insert(tab, i, name) end for i, name in pairsByKeys(tab) do ComboBoxAddMenuItem(combo, FormatProperly(towstring(name)) ) end end   },

		{ name = "FiltersSubSection",	template = "DockspotSubSectionLabelTemplate",	anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20)	end,	nameTid = 3000173 },
		{ name = "filterSelect",		template = "SavedFiltersTemplate",				anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,												comboFill = function(combo) MobileBarsDockspot.FillFiltersCombo(combo) end },
		{ name = "customText",			template = "SearchBoxNoNext_MEDIUM",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",	   25,		10) end,	},
		{ name = "INNOCENT",			template = "DockspotSliderItemTemplate",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",	  -25,		15) end,	nameTid = 1154822,	tooltipTid = 431,		color = NameColor.TextColors[NameColor.Notoriety.INNOCENT] },
		{ name = "FRIEND",				template = "DockspotSliderItemTemplate",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		 5) end,	nameTid = 1078866,	tooltipTid = 431,		color = NameColor.TextColors[NameColor.Notoriety.FRIEND] },
		{ name = "CANATTACK",			template = "DockspotSliderItemTemplate",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		 5) end,	nameTid = 1154823,	tooltipTid = 431,		color = NameColor.TextColors[NameColor.Notoriety.CANATTACK] },
		{ name = "CRIMINAL",			template = "DockspotSliderItemTemplate",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		 5) end,	nameTid = 1153802,	tooltipTid = 431,		color = NameColor.TextColors[NameColor.Notoriety.CRIMINAL] },
		{ name = "ENEMY",				template = "DockspotSliderItemTemplate",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		 5) end,	nameTid = 1095164,	tooltipTid = 431,		color = NameColor.TextColors[NameColor.Notoriety.ENEMY] },
		{ name = "MURDERER",			template = "DockspotSliderItemTemplate",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		 5) end,	nameTid = 1154824,	tooltipTid = 431,		color = NameColor.TextColors[NameColor.Notoriety.MURDERER] },
		{ name = "INVULNERABLE",		template = "DockspotSliderItemTemplate",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		 5) end,	nameTid = 3000509,	tooltipTid = 431,		color = NameColor.TextColors[NameColor.Notoriety.INVULNERABLE] },

		{ name = "NEUTRALANIMALS",		template = "DockspotLabelCheckButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		10) end,	nameTid = 1154825,		tooltipTid = 441 },
		{ name = "SUMMON",				template = "DockspotLabelCheckButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		 5) end,	nameTid = 1154826,		tooltipTid = 441 },
		{ name = "BOSS",				template = "DockspotLabelCheckButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		 5) end,	nameTid = 432,			tooltipTid = 441 },
		{ name = "QUESTGIVER",			template = "DockspotLabelCheckButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		 5) end,	nameTid = 433,			tooltipTid = 441 },
		{ name = "STABLEMASTERS",		template = "DockspotLabelCheckButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		 5) end,	nameTid = 434,			tooltipTid = 441 },
		{ name = "BANKERS",				template = "DockspotLabelCheckButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		 5) end,	nameTid = 435,			tooltipTid = 441 },
		{ name = "SHOPKEEPERS",			template = "DockspotLabelCheckButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		 5) end,	nameTid = 436,			tooltipTid = 441 },
		{ name = "BODDEALERS",			template = "DockspotLabelCheckButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		 5) end,	nameTid = 437,			tooltipTid = 441 },
		{ name = "PLAYERVENDORS",		template = "DockspotLabelCheckButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		 5) end,	nameTid = 438,			tooltipTid = 441 },
		{ name = "SOMEONEPET",			template = "DockspotLabelCheckButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		 5) end,	nameTid = 439,			tooltipTid = 441 },
		{ name = "PLAYERS",				template = "DockspotLabelCheckButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		 5) end,	nameTid = 440,			tooltipTid = 441 },
	}

	-- loading the active filter ID
	MobileBarsDockspot.ActiveFilter =							Interface.LoadSetting("ActiveFilter", MobileBarsDockspot.ActiveFilter)

	-- load the filters count
	MobileBarsDockspot.TotalFilters  =							Interface.LoadSetting("TotalFilters", MobileBarsDockspot.TotalFilters)

	-- load all the saved filters
	for id = 1, MobileBarsDockspot.TotalFilters do
		MobileBarsDockspot.LoadFilter(id)
	end

	-- create the dockspot
	CreateWindowFromTemplate(dockspotName, "MobileBarsDockspotTemplate", "Root")

	-- create the searchbox
	CreateWindowFromTemplate(dockspotName .. "SearchBox", "SearchBoxNoNext_SMALL", "Root")

	-- reduce the searchbox frame visibility
	WindowSetAlpha(dockspotName .. "SearchBoxFrameFrame", 0.5)	

	-- move the focus away from the searchbox
	WindowAssignFocus(dockspotName, true)

	-- hide the searchbox
	WindowSetShowing(dockspotName .. "SearchBox", false)

	-- create the button to toggle the seachbox
	CreateWindowFromTemplate(dockspotName .. "ToggleSearch", "ToggleSearchButtonTemplate", dockspotName .. "VisibleView")

	-- set the position for the toggle search button
	WindowAddAnchor(dockspotName .. "ToggleSearch", "left", dockspotName .. "VisibleView", "left", 10, 0)

	-- hide the toggle search button
	WindowSetShowing(dockspotName .. "ToggleSearch", false)

	-- set the dockspot title and pets count
	MobileBarsDockspot.UpdateMobilesCount()

	-- initialize the dockspot data table with the record we created
	MobileBarsDockspot.Dockspots[dockspotName] = dockspotData

	-- load the saved scale/alpha
	WindowUtils.LoadScale(dockspotName)

	-- apply the saved button rotation
	MobileBarsDockspot.ApplyButtonRotation(dockspotName)

	-- do we have a saved window position?
	if WindowUtils.CanRestorePosition(dockspotName) then

		-- restore the saved window position
		WindowUtils.RestoreWindowPosition(dockspotName, false)

	else -- default position

		-- clear the window position
		WindowClearAnchors(dockspotName)
	
		-- anchor the bar on right of the game area (under the party dockspot + all the bars
		WindowAddAnchor(dockspotName, "topright", "ResizeWindow", "topright", 0, 390)
	end

	-- create the grid for the layout
	MobileBarsDockspot.CreateLayoutGrid(dockspotName)

	-- show/hide the dockspot based on the saved status
	MobileBarsDockspot.ToggleDockspot(dockspotName, true)
end

function MobileBarsDockspot.CreatePinnedDockspot()
	
	-- dockspot window name
	local dockspotName = MobileBarsDockspot.DockspotDefaultNames[MobileBarsDockspot.DockspotType.PINNED]
	
	-- does the dockspot already exist?
	if MobileBarsDockspot.Dockspots[dockspotName] then
		return
	end

	-- dockspot data record to be added to the dockspot table
	local dockspotData = {}

	-- load the auto-close on empty status
	dockspotData.autoClose = Interface.LoadSetting(dockspotName .. "autoClose", true)

	-- load the closing direction of the dockspot (left by default)
	dockspotData.closeLeft = Interface.LoadSetting(dockspotName .. "closeLeft", true)

	-- is the auto-close disabled?
	if not dockspotData.autoClose then
		
		-- load the visible status
		dockspotData.isClosed = Interface.LoadSetting(dockspotName .. "IsClosed", false)
	end

	-- load the sort type for the dockspot
	dockspotData.sortType = Interface.LoadSetting(dockspotName .. "sortType", MobileBarsDockspot.SortType.DISTANCE)

	-- load the layout type for the dockspot
	dockspotData.layoutType = Interface.LoadSetting(dockspotName .. "layoutType", MobileBarsDockspot.LayoutType.HORIZONTAL_5x2)

	-- set the dockspot type
	dockspotData.dockspotType = MobileBarsDockspot.DockspotType.PINNED

	-- set the dockspot bars cap 
	dockspotData.capBars = MobileBarsDockspot.PinnedBarsCap

	-- the dockspot is locked by default, opening the settings makes it movable
	dockspotData.locked = true

	-- dockspot settings
	dockspotData.settings = 
	{
		{ name = "MainSubSection",	template = "DockspotSubSectionLabelTemplate",	anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"topleft",		parent,		"topleft",		20,		40)	end,	nameTid = 11 },
		{ name = "autoClose",		template = "DockspotLabelCheckButton",	anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,	nameTid = 419,	tooltipTid = 420 },
		{ name = "closeLeft",		template = "DockspotLabelCheckButton",	anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,	nameTid = 421,	tooltipTid = 422 },
		{ name = "sortType",		template = "DockspotLabelCombo",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,	nameTid = 423,	tooltipTid = 424,		comboFill = function(combo) local tab = {} for name, i in pairsByKeys(MobileBarsDockspot.SortType) do table.insert(tab, i, name) end for i, name in pairsByKeys(tab) do ComboBoxAddMenuItem(combo, FormatProperly(towstring(name)) ) end end   },
		{ name = "layoutType",		template = "DockspotLabelCombo",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,	nameTid = 425,	tooltipTid = 426,		comboFill = function(combo) local tab = {} for name, i in pairs(MobileBarsDockspot.LayoutType) do if i == 1 then continue end table.insert(tab, i, name) end for i, name in pairsByKeys(tab) do ComboBoxAddMenuItem(combo, FormatProperly(towstring(name)) ) end end },
	}

	-- create the dockspot
	CreateWindowFromTemplate(dockspotName, "MobileBarsDockspotTemplate", "Root")

	-- set the dockspot title and pets count
	MobileBarsDockspot.UpdatePinnedCount()

	-- initialize the dockspot data table with the record we created
	MobileBarsDockspot.Dockspots[dockspotName] = dockspotData

	-- load the saved scale/alpha
	WindowUtils.LoadScale(dockspotName)

	-- apply the saved button rotation
	MobileBarsDockspot.ApplyButtonRotation(dockspotName)

	-- do we have a saved window position?
	if WindowUtils.CanRestorePosition(dockspotName) then

		-- restore the saved window position
		WindowUtils.RestoreWindowPosition(dockspotName, false)

	else -- default position

		-- clear the window position
		WindowClearAnchors(dockspotName)
	
		-- anchor the bar on right of the game area (under the party dockspot + all the bars
		WindowAddAnchor(dockspotName, "topright", "NewChatWindow", "topleft", 0, 0)
	end

	-- create the grid for the layout
	MobileBarsDockspot.CreateLayoutGrid(dockspotName)

	-- show/hide the dockspot based on the saved status
	MobileBarsDockspot.ToggleDockspot(dockspotName, true)

	-- restore the pinned bars
	Interface.ExecuteWhenAvailable(
	{
		name = "reloadPinnedBars",
		check = function() return Interface.started end, 
		callback = function() MobileBarsDockspot.RestorePinnedBars() end, 
		removeOnComplete = true,
		delay = Interface.TimeSinceLogin + 2,
		maxTime = math.huge
	})
end

function MobileBarsDockspot.CreateLayoutGrid(dockspotName)

	-- create a variable as pointer for the dockspot record
	local dockspotData = MobileBarsDockspot.Dockspots[dockspotName]

	-- if the dockspot don't exist we can get out
	if not dockspotData then
		return
	end

	-- destroy all the existing slots
	MobileBarsDockspot.DestryLayoutGrid(dockspotName)

	-- is the dockspot closed? then we can get out
	if dockspotData.isClosed then
		return
	end

	-- defaul distance from the dockspot and the first bar
	local yOffset = MobileBarsDockspot.OFFSET_Y

	-- 1 columns with 10 bars
	if dockspotData.layoutType == MobileBarsDockspot.LayoutType.VERTICAL_10x1 then

		-- we loop from 1 to the bars cap, and create 1 slot per possible bar
		for i = 1, dockspotData.capBars do

			-- grid slot name
			local gridSlotName = dockspotName .. "Grid" .. i

			-- previous slot name
			local prevGridSlotName = dockspotName .. "Grid" .. i - 1

			-- create the dockspot
			CreateWindowFromTemplate(gridSlotName, "MobileBarsDockspotGridSlotTemplate", "Root")

			-- set the correct size to the slot
			MobileBarsDockspot.ResizeGridSlot(gridSlotName, dockspotName)

			-- is this the first slot?
			if i == 1 then

				-- anchor the slot under the dockspot
				WindowAddAnchor(gridSlotName, "bottomleft", dockspotName, "topleft", MobileBarsDockspot.OFFSET_X, yOffset)

			else -- others slot

				-- anchor the slot under the previous slot
				WindowAddAnchor(gridSlotName, "bottomleft", prevGridSlotName, "topleft", 0, MobileBarsDockspot.OFFSET_BETWEEN_BARS)
			end
		end

	-- 2 columns with 10 bars
	elseif dockspotData.layoutType == MobileBarsDockspot.LayoutType.VERTICAL_10x2 then

		-- by default we anchor the slots from left to right
		local anchorPoint = "topright"
		local relativePoint = "topleft"

		-- default horizontal offset
		local horizontalOffset = MobileBarsDockspot.OFFSET_BETWEEN_BARS

		-- does the dockspot closes on the left?
		if not dockspotData.closeLeft then

			-- we anchor the slots from right to left
			anchorPoint = "topleft"
			relativePoint = "topright"

			-- horizontal offset is negative for the right anchoring
			horizontalOffset = horizontalOffset * -1
		end

		-- number of slots per line
		local slotsPerColumn = 10

		-- we loop from 1 to the bars cap, and create 1 slot per possible bar
		for i = 1, dockspotData.capBars do

			-- grid slot name
			local gridSlotName = dockspotName .. "Grid" .. i

			-- create the dockspot
			CreateWindowFromTemplate(gridSlotName, "MobileBarsDockspotGridSlotTemplate", "Root")

			-- set the correct size to the slot
			MobileBarsDockspot.ResizeGridSlot(gridSlotName, dockspotName)

			-- is this the first slot?
			if i == 1 then

				-- anchor the slot under the dockspot
				WindowAddAnchor(gridSlotName, "bottomleft", dockspotName, "topleft", MobileBarsDockspot.OFFSET_X, yOffset)

			-- shall we move to the second line?
			elseif i == slotsPerColumn + 1 then

				-- previous slot name
				local prevGridSlotName = dockspotName .. "Grid" .. i - slotsPerColumn

				-- anchor the slot on the left/right of the first bar
				WindowAddAnchor(gridSlotName, anchorPoint, prevGridSlotName, relativePoint, horizontalOffset, 0)

			else -- others slot

				-- previous slot name
				local prevGridSlotName = dockspotName .. "Grid" .. i - 1

				-- anchor the slot under the previous slot
				WindowAddAnchor(gridSlotName, "bottomleft", prevGridSlotName, "topleft", 0, MobileBarsDockspot.OFFSET_BETWEEN_BARS)
			end
		end

	-- 1 line with 10 bars
	elseif dockspotData.layoutType == MobileBarsDockspot.LayoutType.HORIZONTAL_10x1 then

		-- by default we anchor the slots from left to right
		local anchorPoint = "topright"
		local relativePoint = "topleft"

		-- default horizontal offset
		local horizontalOffset = MobileBarsDockspot.OFFSET_BETWEEN_BARS

		-- does the dockspot closes on the left?
		if not dockspotData.closeLeft then

			-- we anchor the slots from right to left
			anchorPoint = "topleft"
			relativePoint = "topright"

			-- horizontal offset is negative for the right anchoring
			horizontalOffset = horizontalOffset * -1
		end

		-- we loop from 1 to the bars cap, and create 1 slot per possible bar
		for i = 1, dockspotData.capBars do

			-- grid slot name
			local gridSlotName = dockspotName .. "Grid" .. i

			-- previous slot name
			local prevGridSlotName = dockspotName .. "Grid" .. i - 1

			-- create the dockspot
			CreateWindowFromTemplate(gridSlotName, "MobileBarsDockspotGridSlotTemplate", "Root")

			-- set the correct size to the slot
			MobileBarsDockspot.ResizeGridSlot(gridSlotName, dockspotName)

			-- is this the first slot?
			if i == 1 then

				-- anchor the slot under the dockspot
				WindowAddAnchor(gridSlotName, "bottomleft", dockspotName, "topleft", MobileBarsDockspot.OFFSET_X, yOffset)

			else -- others slot

				-- anchor the slot on the left/right the previous slot
				WindowAddAnchor(gridSlotName, anchorPoint, prevGridSlotName, relativePoint, horizontalOffset, 0)
			end
		end

	-- 2 lines with 5 bars
	elseif dockspotData.layoutType == MobileBarsDockspot.LayoutType.HORIZONTAL_5x2 then

		-- by default we anchor the slots from left to right
		local anchorPoint = "topright"
		local relativePoint = "topleft"

		-- default horizontal offset
		local horizontalOffset = MobileBarsDockspot.OFFSET_BETWEEN_BARS

		-- does the dockspot closes on the left?
		if not dockspotData.closeLeft then

			-- we anchor the slots from right to left
			anchorPoint = "topleft"
			relativePoint = "topright"

			-- horizontal offset is negative for the right anchoring
			horizontalOffset = horizontalOffset * -1
		end

		-- number of slots per line
		local slotsPerLine = 5

		-- we loop from 1 to the bars cap, and create 1 slot per possible bar
		for i = 1, dockspotData.capBars do

			-- grid slot name
			local gridSlotName = dockspotName .. "Grid" .. i

			-- create the dockspot
			CreateWindowFromTemplate(gridSlotName, "MobileBarsDockspotGridSlotTemplate", "Root")

			-- set the correct size to the slot
			MobileBarsDockspot.ResizeGridSlot(gridSlotName, dockspotName)

			-- is this the first slot?
			if i == 1 then

				-- anchor the slot under the dockspot
				WindowAddAnchor(gridSlotName, "bottomleft", dockspotName, "topleft", MobileBarsDockspot.OFFSET_X, yOffset)

			-- shall we move to the second line?
			elseif i > slotsPerLine then

				-- previous slot name
				local prevGridSlotName = dockspotName .. "Grid" .. i - slotsPerLine

				-- anchor the slot under the one of the previous line
				WindowAddAnchor(gridSlotName, "bottomleft", prevGridSlotName, "topleft", 0, MobileBarsDockspot.OFFSET_BETWEEN_BARS)

			else -- others slot

				-- previous slot name
				local prevGridSlotName = dockspotName .. "Grid" .. i - 1

				-- anchor the slot on the left/right the previous slot
				WindowAddAnchor(gridSlotName, anchorPoint, prevGridSlotName, relativePoint, horizontalOffset, 0)
			end
		end
	end

	-- hide the layout grid
	MobileBarsDockspot.HideLayoutGrid(dockspotName)
end

function MobileBarsDockspot.ScaleLayoutGrid(dockspotName)

	-- create a variable as pointer for the dockspot record
	local dockspotData = MobileBarsDockspot.Dockspots[dockspotName]

	-- if the dockspot don't exist we can get out
	if not dockspotData then
		return
	end

	-- we loop from 1 to the bars cap, and destroy all the slots
	for i = 1, dockspotData.capBars do

		-- grid slot name
		local gridSlotName = dockspotName .. "Grid" .. i

		-- if the slot exist, we destroy it
		if DoesWindowExist(gridSlotName) then

			-- apply to the slot the same scale of the dockspot
			WindowSetScale(gridSlotName, WindowGetScale(dockspotName))
		end
	end
end

function MobileBarsDockspot.HideLayoutGrid(dockspotName)

	-- create a variable as pointer for the dockspot record
	local dockspotData = MobileBarsDockspot.Dockspots[dockspotName]

	-- if the dockspot don't exist we can get out
	if not dockspotData then
		return
	end
	
	-- we loop from 1 to the bars cap, and destroy all the slots
	for i = 1, dockspotData.capBars do

		-- grid slot name
		local gridSlotName = dockspotName .. "Grid" .. i

		-- if the slot exist, we destroy it
		if DoesWindowExist(gridSlotName) then
			WindowSetShowing(gridSlotName, false)
		end
	end
end

function MobileBarsDockspot.ShowLayoutGrid(dockspotName)

	-- create a variable as pointer for the dockspot record
	local dockspotData = MobileBarsDockspot.Dockspots[dockspotName]

	-- if the dockspot don't exist we can get out
	if not dockspotData then
		return
	end

	-- we loop from 1 to the bars cap, and destroy all the slots
	for i = 1, dockspotData.capBars do

		-- grid slot name
		local gridSlotName = dockspotName .. "Grid" .. i

		-- if the slot exist, we destroy it
		if DoesWindowExist(gridSlotName) then
			WindowSetShowing(gridSlotName, true)
		end
	end
end

function MobileBarsDockspot.DestryLayoutGrid(dockspotName)

	-- create a variable as pointer for the dockspot record
	local dockspotData = MobileBarsDockspot.Dockspots[dockspotName]

	-- if the dockspot don't exist we can get out
	if not dockspotData then
		return
	end

	-- we loop from 1 to the bars cap, and destroy all the slots
	for i = 1, dockspotData.capBars do

		-- grid slot name
		local gridSlotName = dockspotName .. "Grid" .. i

		-- if the slot exist, we destroy it
		if DoesWindowExist(gridSlotName) then
			DestroyWindow(gridSlotName)
		end
	end
end

function MobileBarsDockspot.ResizeGridSlot(gridSlotName, dockspotName)
	
	-- does the slot exist?
	if not DoesWindowExist(gridSlotName) then
		return
	end

	-- default slot size
	local defaultWidth = 160
	local defaultHeight = 35

	-- create a variable as pointer for the dockspot record
	local dockspotData = MobileBarsDockspot.Dockspots[dockspotName]

	-- if the dockspot don't exist we can get out
	if not dockspotData then
		return
	end

	-- is this the pet dockspot?
	if dockspotData.dockspotType == MobileBarsDockspot.DockspotType.PET then

		-- we use the maximum height a pet bar can have (not enlarged)
		defaultHeight = MobileHealthBar.PetBarHeight

	-- is this the party dockspot?
	elseif dockspotData.dockspotType == MobileBarsDockspot.DockspotType.PARTY then

		-- we use the maximum height a pet bar can have (not enlarged)
		defaultHeight = MobileHealthBar.PartyBarHeight
	end

	-- get the current slot dimensions
	local x, y = WindowGetDimensions(gridSlotName)

	-- does the slot has the wrong dimensions?
	if x ~= defaultWidth or y ~= defaultHeight then

		-- resize the slot
		WindowSetDimensions(gridSlotName, defaultWidth, defaultHeight)
	end

	-- load the saved scale/alpha
	WindowUtils.LoadScale(dockspotName)

	-- scale the grid with the dockspot
	WindowSetScale(gridSlotName, WindowGetScale(dockspotName))
end

function MobileBarsDockspot.ResizeAllGridSlots(dockspotName, ignoreFilled)
	
	-- create a variable as pointer for the dockspot record
	local dockspotData = MobileBarsDockspot.Dockspots[dockspotName]

	-- if the dockspot don't exist we can get out
	if not dockspotData then
		return
	end

	-- we loop from 1 to the bars cap, and destroy all the slots
	for i = 1, dockspotData.capBars do

		-- grid slot name
		local gridSlotName = dockspotName .. "Grid" .. i

		-- do the slot exist?
		if not DoesWindowExist(gridSlotName) then
			continue
		end

		-- shall we ignore filled slots?
		if ignoreFilled then

			-- is there something in this slot?
			local found = false

			-- scan all the open healthbars
			for mobileId, barData in pairs(MobileHealthBar.ActiveBars) do

				-- does this healthbar belongs to this dockspot?
				if barData.dockspot ~= dockspotName then
					continue
				end

				-- is the bar in this slot?
				if barData.dockGrid == gridSlotName then
					
					-- the slot is filled
					found = true

					break
				end
			end

			-- move to the next one if the slot is filled
			if found then
				continue
			end
		end

		-- resize the slot
		MobileBarsDockspot.ResizeGridSlot(gridSlotName, dockspotName)
	end
end

function MobileBarsDockspot.ToggleDockspot(dockspotName, updateStatus)

	-- does the dockspot exist?
	if not DoesWindowExist(dockspotName) then
		return
	end

	-- create a variable as pointer for the dockspot record
	local dockspotData = MobileBarsDockspot.Dockspots[dockspotName]

	-- if the dockspot don't exist we can get out
	if not dockspotData then
		return
	end
	
	-- is the auto-close enabled? we don't manage it here
	if dockspotData.autoClose then
		return
	end

	-- are we loading the current window open/close status?
	if updateStatus then

		-- apply the current open/close status
		if dockspotData.isClosed then
			MobileBarsDockspot.CloseDockspot(dockspotName)

		else
			MobileBarsDockspot.OpenDockspot(dockspotName)
		end

	else -- invert the closed status
		if dockspotData.isClosed then
			MobileBarsDockspot.OpenDockspot(dockspotName)

		else
			MobileBarsDockspot.CloseDockspot(dockspotName)
		end
	end
end

function MobileBarsDockspot.CloseDockspot(dockspotName, updateStatus)

	-- does the dockspot exist?
	if not DoesWindowExist(dockspotName) then

		-- this happens when the button is pressed so we have to get the mouse over window
		dockspotName = WindowUtils.GetActiveDialog()

		-- nullify the update status if the button has been pressed
		updateStatus = nil
	end

	-- create a variable as pointer for the dockspot record
	local dockspotData = MobileBarsDockspot.Dockspots[dockspotName]

	-- if the dockspot don't exist we can get out
	if not dockspotData then
		return
	end

	-- flag the dockspot as closed
	dockspotData.isClosed = true

	-- is the auto-close enabled? we don't need to save the status if it is
	-- updateStatus require to update the dockspot visibility status to the current one. Used on loading.
	if not dockspotData.autoClose and not updateStatus then

		-- save the new visibility status
		Interface.SaveSetting(dockspotName .. "IsClosed", dockspotData.isClosed)
	end

	-- texture to show/hide name
	local showName = dockspotName .. "VisibleView"
	local hideName = dockspotName .. "HiddenView"
	
	-- hide the "visible" dockspot texture
	WindowSetShowing(showName, false)

	-- show the "hidden" dockspot texture
	WindowSetShowing(hideName, true)
	
	-- remove from the snappable windows (only when open you can snap)
	SnapUtils.SnappableWindows[showName] = nil

	-- close all the bars on the dockspot
	MobileBarsDockspot.CloseAllBarsOnDockspot(dockspotName)

	-- is this the pets dockspot?
	if dockspotData.dockspotType == MobileBarsDockspot.DockspotType.PET then

		-- shrink the pet controls bar
		Hotbar.Shrink("Hotbar" .. Interface.PetControlsBar)
	end
	
	-- remove the grid
	MobileBarsDockspot.DestryLayoutGrid(dockspotName)

	-- is this the mobiles dockspot?
	if dockspotData.dockspotType == MobileBarsDockspot.DockspotType.MOBILES then

		-- update the mobiles count
		MobileBarsDockspot.UpdateMobilesCount()
	end
end

function MobileBarsDockspot.CloseAllBarsOnDockspot(dockspotName)
	
	-- does the dockspot exist?
	if not DoesWindowExist(dockspotName) then
		return
	end

	-- create a variable as pointer for the dockspot record
	local dockspotData = MobileBarsDockspot.Dockspots[dockspotName]

	-- if the dockspot don't exist we can get out
	if not dockspotData then
		return
	end

	-- scan all the open healthbars
	for mobileId, barData in pairs(MobileHealthBar.ActiveBars) do

		-- does this healthbar belongs to this dockspot?
		if barData.dockspot ~= dockspotName then
			continue
		end
		
		-- close the healthbar
		MobileHealthBar.CloseBarByID(mobileId, "Close all bars in the dockspot")
	end

	-- is this the pinned dockspot?
	if dockspotData.dockspotType == MobileBarsDockspot.DockspotType.PINNED then
		
		-- clear the pinned order
		MobileHealthBar.PinnedOrder = {}
	end

	-- empty the dockspot sorted list
	dockspotData.sortedList = {}
end

function MobileBarsDockspot.OpenDockspot(dockspotName, updateStatus, noUpdate)

	-- does the dockspot exist?
	if not DoesWindowExist(dockspotName) then
		
		-- this happens when the button is pressed so we have to get the mouse over window
		dockspotName = WindowUtils.GetActiveDialog()

		-- nullify the update status if the button has been pressed
		updateStatus = nil
	end

	-- create a variable as pointer for the dockspot record
	local dockspotData = MobileBarsDockspot.Dockspots[dockspotName]

	-- if the dockspot don't exist we can get out
	if not dockspotData then
		return
	end

	-- flag the dockspot as open
	dockspotData.isClosed = false

	-- is the auto-close enabled? we don't need to save the status if it is
	-- updateStatus require to update the dockspot visibility status to the current one. Used on loading.
	if not dockspotData.autoClose and not updateStatus then

		-- save the new visibility status
		Interface.SaveSetting(dockspotName .. "IsClosed", dockspotData.isClosed)
	end

	-- texture to show/hide name
	local showName = dockspotName .. "VisibleView"
	local hideName = dockspotName .. "HiddenView"
	
	-- show the "visible" dockspot texture
	WindowSetShowing(showName, true)

	-- hide the "hidden" dockspot texture
	WindowSetShowing(hideName, false)
	
	-- add to the snappable windows (only when open you can snap)
	SnapUtils.SnappableWindows[showName] = true

	-- create the layout grid
	MobileBarsDockspot.CreateLayoutGrid(dockspotName)

	-- hide the grid
	MobileBarsDockspot.HideLayoutGrid(dockspotName)
	
	-- the noupdate is used when the call comes from the update itself
	if not noUpdate then
		
		-- update the docked bars
		MobileBarsDockspot.UpdateDockspotBars(dockspotName)
	end
end

function MobileBarsDockspot.ApplyButtonRotation(dockspotName, noUpdate)
	
	-- does the dockspot exist?
	if not DoesWindowExist(dockspotName) then
		return
	end

	-- create a variable as pointer for the dockspot record
	local dockspotData = MobileBarsDockspot.Dockspots[dockspotName]

	-- if the dockspot don't exist we can get out
	if not dockspotData then
		return
	end

	-- texture to show/hide name
	local showName = dockspotName .. "VisibleView"
	local hideName = dockspotName .. "HiddenView"

	-- left button
	local showNameLeftButton = showName .. "HideButton"
	local hideNameLeftButton = hideName .. "ShowButton"

	-- right button
	local showNameRightButton = showName .. "HideButtonR"
	local hideNameRightButton = hideName .. "ShowButtonR"

	-- hidden mode label
	local hideLabel = hideName .. "Name"

	-- settings button
	local showSettings = showName .. "Settings"
	local hideSettings = hideName .. "Settings"

	-- searchbox name
	local searchBox = dockspotName .. "SearchBox"

	-- hide the settings button
	WindowSetShowing(showSettings, false)
	WindowSetShowing(hideSettings, false)

	-- is the auto-close active?
	if dockspotData.autoClose then

		-- since the open/close is handled automatically, we hide the buttons
		WindowSetShowing(showNameRightButton, false)
		WindowSetShowing(showNameLeftButton, false)
		WindowSetShowing(hideNameRightButton, false)
		WindowSetShowing(hideNameLeftButton, false)

	else -- auto-close inactive

		-- fix the arrow button based on the direction
		WindowSetShowing(showNameRightButton, not dockspotData.closeLeft)
		WindowSetShowing(showNameLeftButton, dockspotData.closeLeft)
		WindowSetShowing(hideNameRightButton, not dockspotData.closeLeft)
		WindowSetShowing(hideNameLeftButton, dockspotData.closeLeft)

		-- fix the default transparency
		WindowSetAlpha(showNameRightButton, 0.5)
		WindowSetAlpha(showNameLeftButton, 0.5)
		WindowSetAlpha(hideNameRightButton, 0.5)
		WindowSetAlpha(hideNameLeftButton, 0.5)
	end

	-- reset the label location (only for the label visible when the dockspot is hidden)
	WindowClearAnchors(hideLabel)

	-- reset the hidden view location
	WindowClearAnchors(hideName)

	-- reset the settings button location
	WindowClearAnchors(hideSettings)
	WindowClearAnchors(showSettings)

	-- does the searchbox exist?
	if DoesWindowExist(searchBox) then

		-- reset searchbox anchors
		WindowClearAnchors(searchBox)
	end

	-- does the dockspot closes on the left?
	if dockspotData.closeLeft then

		-- does the searchbox exist?
		if DoesWindowExist(searchBox) then
			
			-- anchor the searchbox to the dockspot properly
			WindowAddAnchor(searchBox, "right", dockspotName, "left",  0, 0)
		end

		-- fix the label location based on the direction
		WindowAddAnchor(hideLabel, "bottomleft", hideName, "topleft", 10, -10)

		-- fix the label location based on the direction for the hidden view block
		WindowAddAnchor(hideName, "topleft", dockspotName, "topleft", 0, 0)

		-- is the auto-close active?
		if dockspotData.autoClose then

			-- fix the location of the settings button
			WindowAddAnchor(hideSettings, "topleft", hideName, "topleft",  2, -5)
			WindowAddAnchor(showSettings, "topright", showName, "topright",  2, 0)

		else
			-- fix the location of the settings button
			WindowAddAnchor(hideSettings, "topright", hideNameLeftButton, "topleft",  2, -5)
			WindowAddAnchor(showSettings, "topleft", showNameLeftButton, "topright",  -2, -5)
		end

	else -- close on the right

		-- does the searchbox exist?
		if DoesWindowExist(searchBox) then

			-- anchor the searchbox to the dockspot
			WindowAddAnchor(searchBox, "left", dockspotName, "right",  0, 0)
		end

		-- fix the label location based on the direction
		WindowAddAnchor(hideLabel, "bottomright", hideName, "topright", -10, -10)

		-- fix the label location based on the direction for the hidden view block
		WindowAddAnchor(hideName, "topright", dockspotName, "topright", 0, 0)

		-- is the auto-close active?
		if dockspotData.autoClose then

			-- fix the location of the settings button
			WindowAddAnchor(hideSettings, "topright", hideName, "topright",  2, 0)
			WindowAddAnchor(showSettings, "topright", showName, "topright",  -2, 0)

		else
			-- fix the location of the settings button
			WindowAddAnchor(hideSettings, "topleft", hideNameRightButton, "topright", -2, -5)
			WindowAddAnchor(showSettings, "topleft", showNameLeftButton, "topright",  -2, -5)
		end
	end

	-- update the pet controls bar anchors
	Hotbar.PetControlsSnap(true)

	-- the no update comes from switching the autoclose
	if not noUpdate then

		-- re-create the grid layout
		MobileBarsDockspot.CreateLayoutGrid(dockspotName)

		-- close all the bars on the dockspot
		MobileBarsDockspot.CloseAllBarsOnDockspot(dockspotName)

		-- force-update the bars
		MobileBarsDockspot.UpdateDockspotBars(dockspotName)
	end
end

function MobileBarsDockspot.GetPetDockspotStatus()

	-- dockspot window name
	local dockspotName = MobileBarsDockspot.DockspotDefaultNames[MobileBarsDockspot.DockspotType.PET]
	
	-- return if the dockspot is visible and the dockspot name
	return not MobileBarsDockspot.Dockspots[dockspotName].isClosed, dockspotName
end

function MobileBarsDockspot.GetMobilesDockspotStatus()

	-- dockspot window name
	local dockspotName = MobileBarsDockspot.DockspotDefaultNames[MobileBarsDockspot.DockspotType.MOBILES]
	
	-- return if the dockspot is visible and the dockspot name
	return not MobileBarsDockspot.Dockspots[dockspotName].isClosed, dockspotName
end

function MobileBarsDockspot.ForceCloseMobilesBar()

	-- dockspot window name
	local dockspotName = MobileBarsDockspot.DockspotDefaultNames[MobileBarsDockspot.DockspotType.MOBILES]
	
	-- create a variable as pointer for the dockspot record
	local dockspotData = MobileBarsDockspot.Dockspots[dockspotName]
	
	-- disable the autoclose
	dockspotData.autoClose = false

	-- save the new auto-close status
	Interface.SaveSetting(dockspotName .. "autoClose", dockspotData.autoClose)

	-- close the dockspot
	MobileBarsDockspot.CloseDockspot(dockspotName)

	-- apply the saved button rotation
	MobileBarsDockspot.ApplyButtonRotation(dockspotName, true)
end

function MobileBarsDockspot.UpdatePetsCount()

	-- do we have the followers data?
	if not WindowData.PlayerStatus or not WindowData.PlayerStatus["Followers"] or not WindowData.PlayerStatus["MaxFollowers"] then

		-- try again in a short while
		Interface.ExecuteWhenAvailable(
		{
			name = "UpdatePetsCount",
			check = function() return WindowData.PlayerStatus and WindowData.PlayerStatus["Followers"] end, 
			callback = function() MobileBarsDockspot.UpdatePetsCount() end, 
			removeOnComplete = true
		})

		return
	end

	-- dockspot window name
	local dockspotName = MobileBarsDockspot.DockspotDefaultNames[MobileBarsDockspot.DockspotType.PET]

	-- does the dockspot exist?
	if not DoesWindowExist(dockspotName) or not MobileBarsDockspot.Dockspots[dockspotName] then

		-- try again in a short while
		Interface.ExecuteWhenAvailable(
		{
			name = "UpdatePetsCount" .. dockspotName,
			check = function() return DoesWindowExist(dockspotName) end, 
			callback = function() MobileBarsDockspot.UpdatePetsCount() end, 
			removeOnComplete = true
		})

		return
	end

	-- change the bars cap
	MobileBarsDockspot.ChangeBarsCap(dockspotName, tonumber(WindowData.PlayerStatus["MaxFollowers"]) )

	-- create the pets count string
	local petsCountString = GetStringFromTid(1078830) .. L" [" .. WindowData.PlayerStatus["Followers"] .. L"/" .. WindowData.PlayerStatus["MaxFollowers"] .. L"]"-- Followers

	-- set the dockbar tittle
	LabelSetText(dockspotName .. "VisibleView" .. "Name", petsCountString)
	LabelSetText(dockspotName .. "HiddenView"  .. "Name", petsCountString)
end

function MobileBarsDockspot.UpdatePartyCount()

	-- dockspot window name
	local dockspotName = MobileBarsDockspot.DockspotDefaultNames[MobileBarsDockspot.DockspotType.PARTY]

	-- does the dockspot exist?
	if not DoesWindowExist(dockspotName) or not MobileBarsDockspot.Dockspots[dockspotName] then

		-- try again in a short while
		Interface.ExecuteWhenAvailable(
		{
			name = "UpdatePartyCount" .. dockspotName,
			check = function() return DoesWindowExist(dockspotName) end, 
			callback = function() MobileBarsDockspot.UpdatePartyCount() end, 
			removeOnComplete = true
		})

		return
	end

	-- the party count is 0 by default
	local partyCount = 0

	-- if the player uses the party status, we start the counting from 1
	if Interface.Settings.StatusWindowStyle == 4 then
		partyCount = 1
	end

	-- do we have the party array?
	if WindowData.PartyMember then

		-- scan all the mobiles
		for i, member in pairsByIndex(WindowData.PartyMember) do
			
			-- get the mobile ID
			local mobileId = member.memberId

			-- is this mobile the player?
			if mobileId ~= GetPlayerID() and IsValidID(mobileId) then

				-- increase the party count
				partyCount = partyCount + 1
			end
		end
	end

	-- is the party healthbar status active?
	if Interface.Settings.StatusWindowStyle == 4 then
		
		-- change the bars cap
		MobileBarsDockspot.ChangeBarsCap(dockspotName, MobileBarsDockspot.PartyBarsCap + 1)

	else -- other status style
		-- change the bars cap
		MobileBarsDockspot.ChangeBarsCap(dockspotName, MobileBarsDockspot.PartyBarsCap)
	end

	-- create the pets count string
	local countString = GetStringFromTid(3000332) .. L" [" .. partyCount .. L"/" .. MobileBarsDockspot.Dockspots[dockspotName].capBars .. L"]" -- Party

	-- set the dockbar tittle
	LabelSetText(dockspotName .. "VisibleView" .. "Name", countString)
	LabelSetText(dockspotName .. "HiddenView"  .. "Name", countString)
end

function MobileBarsDockspot.UpdateMobilesCount()

	-- dockspot window name
	local dockspotName = MobileBarsDockspot.DockspotDefaultNames[MobileBarsDockspot.DockspotType.MOBILES]

	-- does the dockspot exist?
	if not DoesWindowExist(dockspotName) or not MobileBarsDockspot.Dockspots[dockspotName] then

		-- try again in a short while
		Interface.ExecuteWhenAvailable(
		{
			name = "UpdateMobilesCount" .. dockspotName,
			check = function() return DoesWindowExist(dockspotName) end, 
			callback = function() MobileBarsDockspot.UpdateMobilesCount() end, 
			removeOnComplete = true
		})

		return
	end

	-- get the dockspot data
	local dockspotData = MobileBarsDockspot.Dockspots[dockspotName]

	-- the mobiles count is 0 by default
	local mobilesCount = {}
	
	-- do we have the sorted array?
	if dockspotData.sortedList then

		-- initialize the bars count
		local count = 0

		-- scan the sorted list
		for i, mobileId in pairsByIndex(dockspotData.sortedList) do
		
			-- does this mobile has a healthbar?
			if MobileHealthBar.ActiveBars[mobileId] and not mobilesCount[mobileId] then
				mobilesCount[mobileId] = true

				-- increase the count
				count = count + 1
			end

			-- enemies are always half of the cap if the friend|foe option is active
			if dockspotData.friendFoe and count >= dockspotData.capBars / 2 then
				break
			end
		end
	end
	
	-- do we have the friends sorted array?
	if dockspotData.sortedListFriends then

		-- initialize the bars count
		local count = 0

		-- scan the sorted list
		for i, mobileId in pairsByIndex(dockspotData.sortedListFriends) do

			-- does this mobile has a healthbar?
			if MobileHealthBar.ActiveBars[mobileId] and not mobilesCount[mobileId] then
				mobilesCount[mobileId] = true

				-- increase the count
				count = count + 1
			end

			-- friends are always half of the cap
			if count >= dockspotData.capBars / 2 then
				break
			end
		end
	end

	-- create the pets count string
	local countString = GetStringFromTid(1075672) .. L" [" .. table.countElements(mobilesCount) .. L"/" .. dockspotData.capBars .. L"]" -- Mobiles

	-- set the dockbar tittle
	LabelSetText(dockspotName .. "VisibleView" .. "Name", countString)
	LabelSetText(dockspotName .. "HiddenView"  .. "Name", countString)
end

function MobileBarsDockspot.UpdatePinnedCount()

	-- dockspot window name
	local dockspotName = MobileBarsDockspot.DockspotDefaultNames[MobileBarsDockspot.DockspotType.PINNED]

	-- does the dockspot exist?
	if not DoesWindowExist(dockspotName) or not MobileBarsDockspot.Dockspots[dockspotName] then

		-- try again in a short while
		Interface.ExecuteWhenAvailable(
		{
			name = "UpdatePinnedCount" .. dockspotName,
			check = function() return DoesWindowExist(dockspotName) end, 
			callback = function() MobileBarsDockspot.UpdatePinnedCount() end, 
			removeOnComplete = true
		})

		return
	end

	-- the mobiles count is 0 by default
	local mobilesCount = 0

	-- scan all the active healthbars
	for mobileId, data in pairs(MobileHealthBar.ActiveBars) do
		
		-- is the bar pinned?
		if data.pinned then
			mobilesCount = mobilesCount + 1
		end
	end

	-- create the pets count string
	local countString = GetStringFromTid(413) .. L" [" .. mobilesCount .. L"/" .. MobileBarsDockspot.Dockspots[dockspotName].capBars .. L"]" -- Mobiles

	-- set the dockbar tittle
	LabelSetText(dockspotName .. "VisibleView" .. "Name", countString)
	LabelSetText(dockspotName .. "HiddenView"  .. "Name", countString)
end

function MobileBarsDockspot.ChangeBarsCap(dockspotName, newCap)
	
	-- does the dockspot exist and we have a valid new cap?
	if not DoesWindowExist(dockspotName) or not newCap then
		return
	end

	-- create a variable as pointer for the dockspot record
	local dockspotData = MobileBarsDockspot.Dockspots[dockspotName]

	-- if the dockspot don't exist we can get out
	if not dockspotData then
		return
	end

	-- get the old cap
	local oldCap = dockspotData.capBars

	-- has the cap changed?
	if oldCap ~= newCap then

		-- destroy all the existing slots (so if there are more that we need there won't be slots lost around)
		MobileBarsDockspot.DestryLayoutGrid(dockspotName)

		-- update the dockspot bars cap
		dockspotData.capBars = tonumber(newCap) 

		-- re-create the grid layout for the new cap
		MobileBarsDockspot.CreateLayoutGrid(dockspotName)

		-- is the settings window visible?
		if DoesWindowExist(dockspotName .. "Settings") then
			
			-- make sure the layout is visible
			MobileBarsDockspot.ShowLayoutGrid(dockspotName)
		end

	else -- just update the dockspot bars cap
		dockspotData.capBars = tonumber(newCap) 
	end
end

function MobileBarsDockspot.ShowToolTip()
	
	-- get the button window name
	local windowName = SystemData.ActiveWindow.name
	
	-- tooltip text message
	local message = GetStringFromTid(1078518) -- Show

	-- is this the settings button?
	if string.find(SystemData.MouseOverWindow.name, "Settings", 1, true) then

		-- we have to change the way we get the window name for the settings
		windowName = SystemData.MouseOverWindow.name

		-- set the tooltip for the settings
		message = GetStringFromTid(417)

	-- is this the toggle search button?
	elseif string.find(SystemData.MouseOverWindow.name, "ToggleSearch", 1, true) then

		-- we have to change the way we get the window name for the toggle search
		windowName = SystemData.MouseOverWindow.name

		-- set the tooltip for the settings
		message = GetStringFromTid(444)

	else -- make the button more visible
		WindowSetAlpha(windowName, 1)
	end

	-- show the tooltip
	Tooltips.CreateTextOnlyTooltip(windowName, message)
end

function MobileBarsDockspot.ShowToolTipEnd()
	
	-- restore the default transparency
	WindowSetAlpha(SystemData.ActiveWindow.name, 0.5)
end

function MobileBarsDockspot.HideToolTip()
	
	-- get the button window name
	local windowName = SystemData.ActiveWindow.name

	-- show the tooltip
	Tooltips.CreateTextOnlyTooltip(windowName, GetStringFromTid(1078519)) -- Hide

	-- make the button more visible
	WindowSetAlpha(windowName, 1)
end

function MobileBarsDockspot.HideToolTipEnd()

	-- restore the default transparency
	WindowSetAlpha(SystemData.ActiveWindow.name, 0.5)
end

function MobileBarsDockspot.OnMouseDrag(flags)

	-- get the current dockspot window name
	local dockspotName = WindowUtils.GetActiveDialog()
	
	-- is this the settings window?
	if string.find(dockspotName, "Settings", 1, true) then

		-- start moving the settings window
		WindowSetMoving(dockspotName, true)

	else -- move dockspot

		-- create a variable as pointer for the dockspot record
		local dockspotData = MobileBarsDockspot.Dockspots[dockspotName]

		-- if the dockspot don't exist we can get out
		if not dockspotData then
			return
		end

		-- is the dockspot unlocked?
		if not dockspotData.locked then
		
			-- is anything but ALT pressed?
			if flags ~= WindowUtils.ButtonFlags.ALT then

				-- enable window snapping
				SnapUtils.StartWindowSnap(dockspotName)
			end

			-- start moving the dockspot
			WindowSetMoving(dockspotName, true)
	
		else -- stop moving the dockspot
			WindowSetMoving(dockspotName, false)

			-- is this the pet dockspot?
			if MobileBarsDockspot.DockspotDefaultNames[MobileBarsDockspot.DockspotType.PET] == dockspotName then
				
				-- flag the bar that has been moved
				MobileBarsDockspot.Dockspots[dockspotName].hasBeenMoved = true
			end
		end
	end
end

function MobileBarsDockspot.ToggleSeach()

	-- mobiles dockspot name
	local dockspotName = MobileBarsDockspot.DockspotDefaultNames[MobileBarsDockspot.DockspotType.MOBILES]

	-- create a variable as pointer for the dockspot record
	local dockspotData = MobileBarsDockspot.Dockspots[dockspotName]

	-- if the dockspot don't exist we can get out
	if not dockspotData or not dockspotData.sortedList then
		return
	end

	-- searchbox name
	local searchBox = dockspotName .. "SearchBox"

	-- does the searchbox exist?
	if DoesWindowExist(searchBox) then
	
		-- invert the search visibility
		dockspotData.searchVisible = not dockspotData.searchVisible

		-- hide the searchbox
		WindowSetShowing(searchBox, dockspotData.searchVisible)
	end
end

function MobileBarsDockspot.PrepareBarsForDockspot(dockspotName)

	-- create a variable as pointer for the dockspot record
	local dockspotData = MobileBarsDockspot.Dockspots[dockspotName]

	-- if the dockspot don't exist we can get out
	if not dockspotData or not dockspotData.sortedList then
		return
	end

	-- bars count
	local totalBars = 0

	-- get the updated array and the bars count
	local array, bars = MobileBarsDockspot.PrepareBarsForDockspotArray(dockspotName, dockspotData.sortedList)
	
	-- update the array
	dockspotData.sortedList = array
	
	-- update the bars count
	totalBars = totalBars + bars

	-- get the updated array and the bars count
	array, bars = MobileBarsDockspot.PrepareBarsForDockspotArray(dockspotName, dockspotData.sortedListFriends)

	-- update the array
	dockspotData.sortedListFriends = array

	-- update the bars count
	totalBars = totalBars + bars

	-- verify the existing healthbars if they all belongs to the dockspot
	MobileBarsDockspot.VerifyBarsForDockspot(dockspotName)
end

function MobileBarsDockspot.PrepareBarsForDockspotArray(dockspotName, array)

	-- do we have a valid table?
	if not array then
		return _, 0
	end

	-- create a variable as pointer for the dockspot record
	local dockspotData = MobileBarsDockspot.Dockspots[dockspotName]

	-- if the dockspot don't exist we can get out
	if not dockspotData then
		return 0
	end

	-- bars count
	local totalBars = 0
	
	-- scan the sorted list to create/destroy the bars
	for i, mob in pairsByIndex(array) do

		-- create a variable as pointer for the bar record
		local barData = MobileHealthBar.ActiveBars[mob]

		-- is this mobile compatible with the current filters?
		local filterCompatible = MobileBarsDockspot.IsMobileCompatible(mob, dockspotData)

		-- do we still have slots? the bar exist? is visible (or should we create a disabled bar)? is the dockspot open (or in auto-close)? 
		if totalBars < dockspotData.capBars and not barData and ((IsMobileVisible(mob) and not IsPartyMember(mob)) or (IsPartyMember(mob) and dockspotData.leaveDisabledBars) ) and (not dockspotData.isClosed or dockspotData.autoClose) then
		
			-- is the mobile compatible with the filters?
			if filterCompatible then
				
				-- create the healthbar
				barData = MobileHealthBar.CreateBar(mob)

			else -- remove the incompatible mobile from the list
				table.remove(array, i)

				continue
			end
		end

		-- we have enough bars? is the bar disabled? is the mobile out of sight? is the dockspot closed (and auto-close is disabled)? is a party bar and we don't want to see disabled bars?
		if	(totalBars > dockspotData.capBars or (barData and barData.disabled) or not IsMobileVisible(mob) or (dockspotData.isClosed and not dockspotData.autoClose)) and
			(not IsPartyMember(mob) or (IsPartyMember(mob) and not dockspotData.leaveDisabledBars))
		then

			-- is the mobile incompatible with the filters?
			if not filterCompatible then
			
				-- remove the incompatible mobile from the list
				table.remove(array, i)

				-- close the healthbar
				MobileHealthBar.CloseBarByID(mob, "Bar doesn't belong in the dockspot/too many bars in the dockspot")
			end

			continue
		end

		-- increase the bars count
		totalBars = totalBars + 1

		-- do we have the bar data?
		if not barData then
			continue
		end

		-- save the dockspot name to the healthbar
		barData.dockspot = dockspotName

		-- reset previous anchors
		barData.dockGrid = nil
	end

	-- remove all possible duplicates
	array = table.removeDuplicates(array)

	return array, totalBars
end

function MobileBarsDockspot.VerifyBarsForDockspot(dockspotName)
	
	-- create a variable as pointer for the dockspot record
	local dockspotData = MobileBarsDockspot.Dockspots[dockspotName]

	-- if the dockspot don't exist we can get out
	if not dockspotData or not dockspotData.sortedList then
		return
	end

	-- scan all the healthbars (for a reverse check)
	for mobileId, barData in pairs(MobileHealthBar.ActiveBars) do
		
		-- does this bar belongs to this dockspot?
		if barData.dockspot == dockspotName then

			-- flag that indicates if we have found the mobile inside the sorted list
			local found = false

			-- is this in the friends array?
			local friend = false

			-- scan the sorted list
			for i, mob in pairsByIndex(dockspotData.sortedList) do

				-- is this the mobile we're looking for?
				if mob == mobileId then

					-- mark the mobile as found
					found = true

					break
				end
			end

			-- do we have the friends list?
			if dockspotData.sortedListFriends then

				-- scan the sorted list
				for i, mob in pairsByIndex(dockspotData.sortedListFriends) do

					-- is this the mobile we're looking for?
					if mob == mobileId then

						-- mark the mobile as found
						found = true

						-- flag the mobile as friend
						friend = true

						break
					end
				end
			end

			-- is this mobile compatible with the current filters? (this is for all the bars that are not inside the lists)
			local filterCompatible = MobileBarsDockspot.IsMobileCompatible(mobileId, dockspotData)
			
			-- have we found the mobile?
			if not found or not filterCompatible then

				-- is the mobile inside one of the arrays and is incompatible with the filters? (this shouldn't happen since we just filtered the arrays, but we never know...)
				if found and not filterCompatible then

					-- is this a friend?
					if friend then

						-- remove the incompatible mobile from the friends list
						table.remove(dockspotData.sortedListFriends, table.indexOf(dockspotData.sortedListFriends, mobileId))

					else
						-- remove the incompatible mobile from the list
						table.remove(dockspotData.sortedList, table.indexOf(dockspotData.sortedList, mobileId))
					end
				end
			
				-- close the healthbar (this bar has nothing to do with the dockspot)
				MobileHealthBar.CloseBarByID(mobileId, "Bar doesn't belong in the dockspot")
			end
		end
	end
end

function MobileBarsDockspot.UpdateAllDockspotsButtons(timePassed)
	
	-- if the interface is shutting down we can avoid everything in here
	if Interface.goingDown then
		return
	end

	-- get the dockspot bar name
	local dockspotName = WindowUtils.GetTopmostDialog(SystemData.MouseOverWindow.name)

	-- is the mouse over the dockspot?
	if MobileBarsDockspot.Dockspots[dockspotName] then

		-- main window names
		local showName = dockspotName .. "VisibleView"
		local hideName = dockspotName .. "HiddenView"

		-- settings button
		local showSettings = showName .. "Settings"
		local hideSettings = hideName .. "Settings"

		-- toggle search button
		local toggleSearch = dockspotName .. "ToggleSearch"

		-- is the settings button hidden?
		if not WindowGetShowing(showSettings) or not WindowGetShowing(hideSettings) then

			-- show the settings button
			WindowSetShowing(showSettings, true)
			WindowSetShowing(hideSettings, true)

			-- add the Left Mouse Button Up (otherwise the settings button won't work, such is the price of buttons that are visible only with the mouse over...)
			WindowRegisterEventHandler(dockspotName, SystemData.Events.L_BUTTON_UP_PROCESSED, "MobileBarsDockspot.OpenSettings")
		end

		-- are we in the visible view and the toggle search is hidden?
		if DoesWindowExist(toggleSearch) and WindowGetShowing(showName) and not WindowGetShowing(toggleSearch) then

			-- show the toggle search button
			WindowSetShowing(toggleSearch, true)
		end

		-- is this the settings button?
		if	string.find(SystemData.MouseOverWindow.name, "Settings", 1, true) or
			string.find(SystemData.MouseOverWindow.name, "ToggleSearch", 1, true)
		then
			
			-- show the tooltip
			MobileBarsDockspot.ShowToolTip()

			-- is the mouse over the search button?
			if string.find(SystemData.MouseOverWindow.name, "ToggleSearch", 1, true) then

				-- add the Left Mouse Button Up (otherwise the settings button won't work, such is the price of buttons that are visible only with the mouse over...)
				WindowUnregisterEventHandler(dockspotName, SystemData.Events.L_BUTTON_UP_PROCESSED)
				WindowRegisterEventHandler(dockspotName, SystemData.Events.L_BUTTON_UP_PROCESSED, "MobileBarsDockspot.ToggleSeach")

			-- is the mouse over the settings button?
			elseif string.find(SystemData.MouseOverWindow.name, "Settings", 1, true) then
				
				-- add the Left Mouse Button Up (otherwise the settings button won't work, such is the price of buttons that are visible only with the mouse over...)
				WindowUnregisterEventHandler(dockspotName, SystemData.Events.L_BUTTON_UP_PROCESSED)
				WindowRegisterEventHandler(dockspotName, SystemData.Events.L_BUTTON_UP_PROCESSED, "MobileBarsDockspot.OpenSettings")
			end
		end

		-- as soon as the mouse is out of the area, we hide the settings button again
		Interface.ExecuteWhenAvailable(
		{
			name = "HideSettingsFor" .. dockspotName,
			check = function() return WindowUtils.GetTopmostDialog(SystemData.MouseOverWindow.name) ~= dockspotName end, 
			callback = function() WindowSetShowing(showSettings, false) WindowSetShowing(hideSettings, false) WindowSetShowing(toggleSearch, false) WindowUnregisterEventHandler(dockspotName, SystemData.Events.L_BUTTON_UP_PROCESSED) end, 
			removeOnComplete = true,
			maxTime = math.huge
		})
	end
end

function MobileBarsDockspot.UpdateAllDockspotsBars(timePassed)

	-- make sure the UI is started before updating
	if not Interface.started or Interface.goingDown then
		return
	end

	-- scan all the dockspots
	for dockspotName, dockspotData in pairs(MobileBarsDockspot.Dockspots) do

		-- is passed at least 1 second since the last update and update cycle is not paused for this bar?
		if (not dockspotData.lastUpdate or Interface.TimeSinceLogin >= dockspotData.lastUpdate + MobileBarsDockspot.DockspotUpdateRatio) and not dockspotData.stopUpdate and not dockspotData.inUpdate then
		
			-- is the bar open or in auto-close mode?
			if dockspotData.autoClose or not dockspotData.isClosed then
			
				-- update the dockspot
				MobileBarsDockspot.UpdateDockspotBars(dockspotName)
			end
		end
	end
end

function MobileBarsDockspot.UpdateDockspotBars(dockspotName)

	-- create a variable as pointer for the dockspot record
	local dockspotData = MobileBarsDockspot.Dockspots[dockspotName]
	
	-- if the dockspot don't exist we can get out
	if not dockspotData then
		return
	end

	-- no need to continue if the update is stopped
	if dockspotData.stopUpdate or dockspotData.inUpdate then
		return
	end
	
	-- remove the update request flag
	dockspotData.requestUpdate = nil

	-- fix the grid slots
	MobileBarsDockspot.ResizeAllGridSlots(dockspotName, true)

	-- flag the dockspot as "updating"
	dockspotData.inUpdate = true
	
	-- get the sort list for the pets
	dockspotData.sortedList, dockspotData.sortedListFriends = MobileBarsDockspot.SortMobilesForDockspot(dockspotData.dockspotType, dockspotName)

	-- final mobiles list
	local list = {}

	-- create the player status in the party healthbars list
	if dockspotData.dockspotType == MobileBarsDockspot.DockspotType.PARTY and Interface.Settings.StatusWindowStyle == 4 then

		-- add the player ID on top of the others
		table.insert(dockspotData.sortedList, 1, GetPlayerID())

		-- prepare the dockspot by creating/destroying healthbars
		MobileBarsDockspot.PrepareBarsForDockspot(dockspotName)

	-- the create/destroy process is not necessary for pinned bars
	elseif dockspotData.dockspotType ~= MobileBarsDockspot.DockspotType.PINNED then
		
		-- prepare the dockspot by creating/destroying healthbars
		MobileBarsDockspot.PrepareBarsForDockspot(dockspotName)

	-- is this the pinned bar dockspot?
	elseif dockspotData.dockspotType == MobileBarsDockspot.DockspotType.PINNED then
	
		-- do we have an honor target?
		if Interface.Settings.AutoPinHonored and IsValidID(Interface.CurrentHonor) then
			
			-- does the list already contains this mobile?
			local present, idx = table.contains(dockspotData.sortedList, Interface.CurrentHonor)

			-- do we have a duplicate?
			if present then
					
				-- remove the old one
				table.remove(dockspotData.sortedList, idx)
			end

			-- add the honored ID on top of the others
			table.insert(dockspotData.sortedList, 1, Interface.CurrentHonor)
		end
		
		-- scan the sorted list
		for i, mob in pairsByKeys(MobileHealthBar.PinnedOrder) do
		
			-- make sure the bar still exist
			if not MobileHealthBar.ActiveBars[mob] then

				-- remove since the bar don't exist anymore
				table.remove(dockspotData.sortedList, idx)

				continue
			end

			-- is the bar disabled?
			if not IsHealthBarEnabled(mob) or not IsMobileVisible(mob) or MobileHealthBar.ActiveBars[mob].disabled then
				
				-- does the list already contains this mobile?
				local present, idx = table.contains(dockspotData.sortedList, mob)

				-- do we have a duplicate?
				if present then
					
					-- remove the old one
					table.remove(dockspotData.sortedList, idx)
				end

				-- add the mobile to the bottom of the list
				table.insert(dockspotData.sortedList, mob)
			end
		end
	end

	-- is this the mobiles dockspot and the friend | foe option is available?
	if dockspotData.dockspotType == MobileBarsDockspot.DockspotType.MOBILES and dockspotData.friendFoe == true then

		-- create the array for friends and foes
		local friends = {}
		local foes = {}

		-- the cap of friends and foe is half the total cap
		local max = dockspotData.capBars / 2

		-- scan the sorted list (this time we have to parse the list to get only the one we need for the dockspot)
		for i, mob in pairsByIndex(dockspotData.sortedList) do

			-- create a variable as pointer for the bar record
			local barData = MobileHealthBar.ActiveBars[mob]

			-- do we have the bar data?
			if not barData then
				continue
			end
			
			-- fo we still have slots for foes?
			if #foes < max then

				-- add the foe to the list
				table.insert(foes, mob)
			end
		end
		
		-- scan the sorted list (this time we have to parse the list to get only the one we need for the dockspot)
		for i, mob in pairsByIndex(dockspotData.sortedListFriends) do

			-- create a variable as pointer for the bar record
			local barData = MobileHealthBar.ActiveBars[mob]

			-- do we have the bar data?
			if not barData then
				continue
			end
			
			-- do we still have slots for friends?
			if #friends < max then

				-- add the friends to the list
				table.insert(friends, mob)
			end
		end

		-- update the mobiles list
		dockspotData.sortedList = table.append(dockspotData.sortedList, foes)
		dockspotData.sortedListFriends = table.append(dockspotData.sortedListFriends, friends)

		-- count all the bars docked to the dockspot
		local totalBars = table.countElements(dockspotData.sortedList) + table.countElements(dockspotData.sortedListFriends)
		
		-- is the auto-close active?
		if dockspotData.autoClose then

			-- do we have mobiles on the list?
			if totalBars > 0 and dockspotData.isClosed then

				-- open the dockspot
				MobileBarsDockspot.OpenDockspot(dockspotName, nil, true)

			-- close the dockspot since we have no mobiles to show
			elseif totalBars <= 0 and not dockspotData.isClosed then
		
				-- close the dockspot
				MobileBarsDockspot.CloseDockspot(dockspotName)
			end
		end

		-- scan the foes list
		for i, mob in pairsByIndex(foes) do

			-- we only have cap / 2 slots...
			if i > max then
				break
			end

			-- create a variable as pointer for the bar record
			local barData = MobileHealthBar.ActiveBars[mob]

			-- grid slot name
			barData.dockGrid = dockspotName .. "Grid" .. i
		
			-- dock the bar to the slot
			MobileHealthBar.DockToGrid(mob)
		end

		-- scan the friends list
		for i, mob in pairsByIndex(friends) do

			-- we only have cap / 2 slots...
			if i > max then
				break
			end

			-- create a variable as pointer for the bar record
			local barData = MobileHealthBar.ActiveBars[mob]

			-- grid slot name (starting in the second column)
			barData.dockGrid = dockspotName .. "Grid" .. 10 + i
		
			-- dock the bar to the slot
			MobileHealthBar.DockToGrid(mob)
		end

		-- update the mobiles count
		MobileBarsDockspot.UpdateMobilesCount()

	else
		-- scan the sorted list (this time we have to parse the list to get only the one we need for the dockspot)
		for i, mob in pairsByIndex(dockspotData.sortedList) do

			-- create a variable as pointer for the bar record
			local barData = MobileHealthBar.ActiveBars[mob]

			-- do we have the bar data?
			if not barData then
				continue
			end

			-- add the accessible mobile to the list
			table.insert(list, mob)

			-- do we have enough bars?
			if table.countElements(list) == dockspotData.capBars then
				break
			end
		end

		-- update the mobiles list
		dockspotData.sortedList = table.copy(list)

		-- count all the bars docked to the dockspot
		local totalBars = table.countElements(list)

		-- is the auto-close active?
		if dockspotData.autoClose then

			-- do we have mobiles on the list?
			if totalBars > 0 and dockspotData.isClosed then

				-- open the dockspot
				MobileBarsDockspot.OpenDockspot(dockspotName, nil, true)

			-- close the dockspot since we have no mobiles to show
			elseif totalBars <= 0 and not dockspotData.isClosed then
		
				-- close the dockspot
				MobileBarsDockspot.CloseDockspot(dockspotName)
			end
		end

		-- scan the cleaned list (final run: we dock the bars to the grid)
		for i, mob in pairsByIndex(list) do

			-- create a variable as pointer for the bar record
			local barData = MobileHealthBar.ActiveBars[mob]

			-- grid slot name
			barData.dockGrid = dockspotName .. "Grid" .. i
		
			-- dock the bar to the slot
			MobileHealthBar.DockToGrid(mob)
		end

		-- is this the mobiles dockspot?
		if dockspotData.dockspotType == MobileBarsDockspot.DockspotType.MOBILES then

			-- update the mobiles count
			MobileBarsDockspot.UpdateMobilesCount()

		elseif dockspotData.dockspotType == MobileBarsDockspot.DockspotType.PINNED then

			-- update the mobiles count
			MobileBarsDockspot.UpdatePinnedCount()
		end
	end

	-- flag the dockspot as "updating"
	dockspotData.inUpdate = false

	-- save the last update time
	dockspotData.lastUpdate = Interface.TimeSinceLogin

	-- search and destroy duplicates and orphans bars
	MobileHealthBar.DockspotDuplicateHandle()
end

function MobileBarsDockspot.SortMobilesForDockspot(dockspotType, dockspotName)

	-- do we have a valid dockspot type? (it should never happen)
	if not IsValidID(dockspotType) then
		return
	end

	-- create a variable as pointer for the dockspot record
	local dockspotData = MobileBarsDockspot.Dockspots[dockspotName]

	-- if the dockspot don't exist we can get out (it shouldn't happen here)
	if not dockspotData then
		return
	end
	
	-- create the sorting table
	local sortedList = {}

	-- pets sorting
	if dockspotType == MobileBarsDockspot.DockspotType.PET then

		-- scan the active pets
		for i, mobileId in pairsByIndex(WindowData.Pets.PetId) do
		
			-- is the pet visible?
			if IsMobileVisible(mobileId) then

				-- add it to the list
				table.insert(sortedList, mobileId)
			end
		end

	-- party dockspot
	elseif dockspotType == MobileBarsDockspot.DockspotType.PARTY then
	
		-- scan all the mobiles
		for i, member in pairsByIndex(WindowData.PartyMember) do
			
			-- get the mobile ID
			local mobileId = member.memberId

			-- is this mobile the player?
			if mobileId ~= GetPlayerID() and IsValidID(mobileId) then

				-- add it to the list
				table.insert(sortedList, mobileId)
			end
		end

	-- mobiles dockspot (friend|foe enabled)
	elseif dockspotType == MobileBarsDockspot.DockspotType.MOBILES and dockspotData.friendFoe == true then

		-- create the sorting table for friends
		local sortedListFriends = {}

		-- searchbox name
		local searchBox = dockspotName .. "SearchBox"

		-- get the text from the search box
		local text

		-- does the searchbox exist?
		if DoesWindowExist(searchBox) then

			-- get the text from the searchbox
			text = wstring.lower(TextEditBoxGetText(searchBox .. "Filter"))
		end

		-- scan all the mobiles on screen
		for mobileId, data in pairsByKeys(Interface.ActiveMobilesOnScreen) do
			
			-- we exclude: the player, pets, party members and pinned bars
			if not IsObjectIdPet(mobileId) and not IsPartyMember(mobileId) and (not MobileHealthBar.ActiveBars[mobileId] or not MobileHealthBar.ActiveBars[mobileId].pinned) and not MobileHealthBar.IgnoredMobile(mobileId) and (not Interface.Settings.AutoPinHonored or Interface.CurrentHonor ~= mobileId) and mobileId ~= GetPlayerID() then
					
				-- do we have a valid text filter?
				if IsValidWString(text) then

					-- does the name contains the text we're searching for?
					if IsValidWString(data.name) and wstring.find(wstring.lower(data.name), text, 1, true) then
						
						-- get the notoriety for the mobile
						local noto = data.notoriety

						-- is this the honored mobile and the auto-pin is disabled?
						if not Interface.Settings.AutoPinHonored and mobileId == Interface.CurrentHonor then
						
							-- add the mobile to the table
							table.insert(sortedList, mobileId)

						-- is this an enemy?
						elseif (noto == NameColor.Notoriety.CANATTACK or noto == NameColor.Notoriety.CRIMINAL or noto == NameColor.Notoriety.ENEMY or noto == NameColor.Notoriety.MURDERER) then
						
							-- add the mobile to the table
							table.insert(sortedList, mobileId)

						-- is this a friend?
						elseif (noto == NameColor.Notoriety.INNOCENT or noto == NameColor.Notoriety.FRIEND or noto == NameColor.Notoriety.INVULNERABLE) then

							-- add the mobile to the table
							table.insert(sortedListFriends, mobileId)
						end
					end

				else -- no string filter
					
					-- get the notoriety for the mobile
					local noto = data.notoriety

					-- is this the honored mobile and the auto-pin is disabled?
					if not Interface.Settings.AutoPinHonored and mobileId == Interface.CurrentHonor then
						
						-- add the mobile to the table
						table.insert(sortedList, mobileId)

					-- is this an enemy?
					elseif (noto == NameColor.Notoriety.CANATTACK or noto == NameColor.Notoriety.CRIMINAL or noto == NameColor.Notoriety.ENEMY or noto == NameColor.Notoriety.MURDERER) then
						
						-- add the mobile to the table
						table.insert(sortedList, mobileId)

					-- is this a friend?
					elseif (noto == NameColor.Notoriety.INNOCENT or noto == NameColor.Notoriety.FRIEND or noto == NameColor.Notoriety.INVULNERABLE) then

						-- add the mobile to the table
						table.insert(sortedListFriends, mobileId)
					end
				end
			end
		end

		-- remove all possible duplicates
		sortedList = table.removeDuplicates(sortedList)
		sortedListFriends = table.removeDuplicates(sortedListFriends)

		-- SORT ENEMIES

		-- do we have to sort by distance?
		if dockspotData.sortType == MobileBarsDockspot.SortType.DISTANCE then
			sortedList = MobileBarsDockspot.SortByDistance(sortedList)

		-- do we have to sort by health?
		elseif dockspotData.sortType == MobileBarsDockspot.SortType.HEALTH then
			sortedList = MobileBarsDockspot.SortByHealth(sortedList)
		end

		-- SORT FRIENDS

		-- do we have to sort by distance?
		if dockspotData.friendsSortType == MobileBarsDockspot.SortType.DISTANCE then
			sortedListFriends = MobileBarsDockspot.SortByDistance(sortedListFriends)

		-- do we have to sort by health?
		elseif dockspotData.friendsSortType == MobileBarsDockspot.SortType.HEALTH then
			sortedListFriends = MobileBarsDockspot.SortByHealth(sortedListFriends)
		end
		
		return sortedList, sortedListFriends

	-- mobiles dockspot (friend|foe disabled)
	elseif dockspotType == MobileBarsDockspot.DockspotType.MOBILES and not dockspotData.friendFoe then

		-- searchbox name
		local searchBox = dockspotName .. "SearchBox"

		-- get the text from the search box
		local text

		-- does the searchbox exist?
		if DoesWindowExist(searchBox) then

			-- get the text from the searchbox
			text = wstring.lower(TextEditBoxGetText(searchBox .. "Filter"))
		end

		-- scan all the mobiles on screen
		for mobileId, data in pairsByKeys(Interface.ActiveMobilesOnScreen) do
		
			-- we exclude: the player, pets, party members and pinned bars
			if not IsObjectIdPet(mobileId) and not IsPartyMember(mobileId) and (not MobileHealthBar.ActiveBars[mobileId] or not MobileHealthBar.ActiveBars[mobileId].pinned) and not MobileHealthBar.IgnoredMobile(mobileId) and (not Interface.Settings.AutoPinHonored or Interface.CurrentHonor ~= mobileId) and mobileId ~= GetPlayerID() then
				
				-- do we have a valid text filter?
				if IsValidWString(text) then

					-- does the name contains the text we're searching for?
					if IsValidWString(data.name) and wstring.find(wstring.lower(data.name), text, 1, true) then
						
						-- add the mobile to the table
						table.insert(sortedList, mobileId)
					end

				else -- no string filter
					
					-- add the mobile to the table
					table.insert(sortedList, mobileId)
				end
			end
		end

	-- pinned dockspot
	elseif dockspotType == MobileBarsDockspot.DockspotType.PINNED then

		-- copy the pinned table
		sortedList = table.copy(MobileHealthBar.PinnedOrder)

		-- scan the mobiles
		for i, mob in pairsByIndex(sortedList) do
			
			-- do we have the healthbar?
			if not MobileHealthBar.ActiveBars[mob] then
				continue
			end

			-- is this the current honor target?
			if Interface.Settings.AutoPinHonored and mob == Interface.CurrentHonor then
				
				-- remove the honor target from the list (we'll add it back later)
				table.remove(sortedList, i)

			-- is the bar disabled?
			elseif not IsHealthBarEnabled(mob) or not IsMobileVisible(mob) then

				-- remove the disabled bars (we'll add them later)
				table.remove(sortedList, i)
			end
		end
	end

	-- remove all possible duplicates
	sortedList = table.removeDuplicates(sortedList)

	-- if we have to sort by appearance, then the list is already sorted out
	if dockspotData.sortType == MobileBarsDockspot.SortType.APPEARANCE then
		return sortedList, {}

	-- do we have to sort by distance?
	elseif dockspotData.sortType == MobileBarsDockspot.SortType.DISTANCE then
		return MobileBarsDockspot.SortByDistance(sortedList), {}

	-- do we have to sort by health?
	elseif dockspotData.sortType == MobileBarsDockspot.SortType.HEALTH then
		return MobileBarsDockspot.SortByHealth(sortedList), {}
	end
end

function MobileBarsDockspot.CountBarsByNotoriety(notoriety, excludeMobileId)
	
	-- total count
	local count = 0

	-- scan all the active healthbars
	for mobileId, barData in pairs(MobileHealthBar.ActiveBars) do

		-- we don't count pinned bars
		if barData.pinned then
			continue
		end

		-- is this a mobile bar (not pet, not party and not pinned)?
		if barData.type == MobileHealthBar.HealthbarsType.NORMAL or barData.type == MobileHealthBar.HealthbarsType.INVULNERABLE then
			
			-- does this mobile has the notoriety we're looking for?
			if Interface.ActiveMobilesOnScreen[mobileId] and Interface.ActiveMobilesOnScreen[mobileId].notoriety == notoriety then

				-- do we have to exclude a mobile ID?
				if excludeMobileId and excludeMobileId ~= mobileId then
					continue
				end

				-- increase the counter
				count = count + 1
			end
		end
	end

	return count
end

function MobileBarsDockspot.IsMobileCompatible(mobileId, dockspotData)

	-- if this is not the mobiles dockspot, we don't apply the filters.
	if dockspotData.dockspotType ~= MobileBarsDockspot.DockspotType.MOBILES then
		return true
	end

	-- is the mobile in a visible distance?
	if not IsMobileVisible(mobileId) then

		return false
	end

	-- searchbox name
	local searchBox = MobileBarsDockspot.DockspotDefaultNames[MobileBarsDockspot.DockspotType.MOBILES] .. "SearchBox"

	-- does the searchbox exist?
	if DoesWindowExist(searchBox) then

		-- get the text from the searchbox
		local text = wstring.lower(TextEditBoxGetText(searchBox .. "Filter"))

		-- if we have a text filter, we ignore any other active filter.
		if IsValidWString(text) then
			return true
		end
	end

	-- get the mobile data for the current mobile
	local data = Interface.ActiveMobilesOnScreen[mobileId]

	-- do we have the mobile name data?
	if not Interface.IsNameInUse(mobileId) and (not data or not IsValidWString(data.name)) then

		-- update the name data
		Interface.UpdateMobileOnScreenName(mobileId)
	end
	
	-- if the mobile data is missing, we remove it from the list.
	if not data or not data.notoriety or data.notoriety == NameColor.Notoriety.NONE or not IsValidWString(data.name) then
	
		return false
	end

	-- count the current amount of bars for this notoriety
	local notoCount = MobileBarsDockspot.CountBarsByNotoriety(data.notoriety)

	-- get the current filter data
	local currentFitler = MobileBarsDockspot.SavedFilters[MobileBarsDockspot.GetFilterByID(MobileBarsDockspot.ActiveFilter)]

	-- cap for the current notoriety
	local notoCap = currentFitler.notorieties[data.notoriety]

	-- is the auto-pin for honor disabled? then we show all the honored targets in the mobile list
	if not Interface.Settings.AutoPinHonored and mobileId == Interface.CurrentHonor then
		return true
	end

	-- is this notoriety disabled or we have already enough mobiles for this notoriety?
	if notoCap == 0 or notoCount > notoCap then
	
		return false
	end

	-- scan all the sub-filters
	for filter, flag in pairs(currentFitler.subFilters) do

		-- is the sub-filter disabled but the mobile is of this type?
		if not flag and data[MobileBarsDockspot.SubFiltersToFlag[filter]] then

			return false
		end
	end

	-- are we looking only for mobiles with a specific string as part of the name and this mobile don't has it?
	if IsValidWString(currentFitler.customText) and IsValidWString(data.name) and wstring.find(wstring.lower(data.name), currentFitler.customText, 1, true) == nil then
				
		return false
	end

	return true
end

function MobileBarsDockspot.GetMobileIndexFromList(list, mobileId)
	
	-- do we have a valid mobile list?
	if type(list) ~= "table" or #list <= 0 then
		return
	end

	-- scan the list
	for i, mob in pairsByIndex(list) do
		
		-- is this the mobile we're looking for?
		if mob == mobileId then

			return i
		end
	end
end

function MobileBarsDockspot.SortByDistance(list)
	
	-- do we have a valid mobile list?
	if type(list) ~= "table" or #list <= 0 then
		return list
	end

	-- sort the table by distance from player
	local pos = 1

	-- loop through the list
	while pos <= #list do

		-- current mobile distance
		local position = GetDistanceFromPlayer(list[pos] or 0)

		-- if the position is -1 or the mobile is not visible, we set the distance very far
		if not position or position < 0 or not IsMobileVisible(list[pos]) then
			position = 1000
		end

		-- previous mobile distance
		local prevPosition = GetDistanceFromPlayer(list[pos-1] or 0)

		-- if the position is -1 or the mobile is not visible, we set the distance very far
		if not prevPosition or prevPosition < 0 or not IsMobileVisible(list[pos-1]) then
			prevPosition = 1000
		end
		
		-- is this the first element or the previous element is bigger than this one?
		if (pos == 1 or position >= prevPosition) then

			-- move to the next element
			pos = pos + 1

		else -- store the element
			local swap = list[pos]

			-- move the previous element to th current position
			list[pos] = list[pos-1]

			-- move the store element to the previous position
			list[pos-1] = swap

			-- move to the previous position
			pos = pos - 1
		end
	end

	return list
end

function MobileBarsDockspot.SortByHealth(list)
	
	-- do we have a valid mobile list?
	if type(list) ~= "table" or #list <= 0 then
		return list
	end

	-- table of mobiles to be removed from the list
	local toRemove = {}

	-- scan all the mobiles we need to make sure we have all the data before sorting
	for i, mobileId in pairsByIndex(list) do
		
		-- create a variable as pointer for the bar record
		local barData = MobileHealthBar.ActiveBars[mobileId]

		-- get the mobile data
		local mobileStatus = Interface.ActiveMobilesOnScreen[mobileId]

		-- if the mobile status is not available, we create it
		if not mobileStatus then

			-- is the healthbar enabled?
			if IsHealthBarEnabled(mobileId) then
				mobileStatus = {}

			 -- out of range mobile to be removed (if the bar is not pinned)
			elseif not barData or not barData.pinned then
				toRemove[i] = true

				continue
			end
		end

		-- update the mobile status	
		--Interface.UpdateMobileOnScreenStatus(mobileId)
	end

	-- remove all the out of range mobiles
	for i, _ in pairsByKeys(toRemove) do
		table.remove(list, i)
	end

	-- sort the table by health percent
	local pos = 1
	while pos <= #list do
		
		-- 100 by default if we don't have the data
		local health = 100
		
		-- do we have the mobile health for this element?
		if Interface.ActiveMobilesOnScreen[list[pos]] and not Interface.ActiveMobilesOnScreen[list[pos]].invulnerable then
			health = Interface.ActiveMobilesOnScreen[list[pos]].perc or 100
		end

		-- make sure the invulnerable stays at the bottom of the list...
		if Interface.ActiveMobilesOnScreen[list[pos]] and Interface.ActiveMobilesOnScreen[list[pos]].invulnerable then
			health = 1000
		end

		-- 100 by default if we don't have the data
		local prevHealth = 100

		-- do we have the mobile health for the previous element?
		if Interface.ActiveMobilesOnScreen[list[pos-1]] and not Interface.ActiveMobilesOnScreen[list[pos-1]].invulnerable then
			prevHealth = Interface.ActiveMobilesOnScreen[list[pos-1]].perc or 100
		end

		-- make sure the invulnerable stays at the bottom of the list...
		if Interface.ActiveMobilesOnScreen[list[pos-1]] and Interface.ActiveMobilesOnScreen[list[pos-1]].invulnerable then
			prevHealth = 1000
		end

		-- is this the first element or the previous element is bigger than this one?
		if (pos == 1 or health >= prevHealth) then
			
			-- move to the next element
			pos = pos + 1

		else -- store the element
			local swap = list[pos]

			-- move the previous element to th current position
			list[pos] = list[pos-1]

			-- move the store element to the previous position
			list[pos-1] = swap

			-- move to the previous position
			pos = pos - 1
		end
	end

	return list
end

function MobileBarsDockspot.IsDockspot(windowName)

	-- do we have a valid window name?
	if not IsValidString(windowName) then
		return false
	end
	
	-- does the dockspot exist?
	return MobileBarsDockspot.Dockspots[windowName] ~= nil
end

function MobileBarsDockspot.OpenSettings()

	-- have we clicked the settings button?
	if not string.find(SystemData.MouseOverWindow.name, "Settings", 1, true) then
		return
	end

	-- get the dockspot bar name
	local dockspotName = WindowUtils.GetTopmostDialog(SystemData.ActiveWindow.name)
	
	-- create a variable as pointer for the dockspot record
	local dockspotData = MobileBarsDockspot.Dockspots[dockspotName]

	-- if the dockspot don't exist we can get out (it shouldn't happen here)
	if not dockspotData then
		return
	end

	-- settings window name
	local settingsWindow = dockspotName .. "Settings"

	-- is the window already open?
	if DoesWindowExist(settingsWindow) then

		-- close the settings window
		DestroyWindow(settingsWindow)

		return
	end

	-- get the dockspot title without the count
	local dockspotTitle = LabelGetText(dockspotName .. "VisibleView" .. "Name")
	dockspotTitle = wstring.trim(wstring.sub(dockspotTitle, 1, wstring.find(dockspotTitle, L"[", 1, true) - 1))

	-- create the settings window
	CreateWindowFromTemplate(settingsWindow, "DockspotSettingsWindow", "Root")

	-- destroy the settings window on close
	Interface.DestroyWindowOnClose[settingsWindow] = true

	-- set the settings title
	LabelSetText(settingsWindow .. "Title", ReplaceTokens(GetStringFromTid(418), {dockspotTitle}))

	-- do we have a saved window position?
	if WindowUtils.CanRestorePosition("DockspotSettingsWindow") then

		-- restore the saved window position
		WindowUtils.RestoreWindowPosition(settingsWindow, false, "DockspotSettingsWindow", true)

	else -- default position

		-- clear the window position
		WindowClearAnchors(settingsWindow)
		
		-- anchor the bar on the top-left of the screen
		WindowAddAnchor(settingsWindow, "top", "Root", "top", 0, 50)
	end

	-- make the dockspot movable
	dockspotData.locked = false

	-- stop the dockspot update
	dockspotData.stopUpdate = true

	-- close all the bars on the dockspot
	MobileBarsDockspot.CloseAllBarsOnDockspot(dockspotName)

	-- populate the settings window
	MobileBarsDockspot.PopulateSettings(settingsWindow, dockspotData)

	-- show the dockspot (if it was closed)
	MobileBarsDockspot.OpenDockspot(dockspotName, true)

	-- resize the entire grid
	MobileBarsDockspot.ResizeAllGridSlots(dockspotName)

	-- show the layout grid
	MobileBarsDockspot.ShowLayoutGrid(dockspotName)
end

function MobileBarsDockspot.PopulateSettings(settingsWindow, dockspotData)

	-- do we have a valid setting window?
	if not IsValidString(settingsWindow) or not DoesWindowExist(settingsWindow) then
		return
	end

	-- do we have the dockspot data?
	if not dockspotData then
		return
	end

	-- restore the scale
	WindowSetScale(settingsWindow, InterfaceCore.scale)

	-- previous element
	local prevElement = settingsWindow

	-- position of the last element (to resize the window area)
	local topOffset = 30

	-- list of elements to hide after
	local elementsToHide = {}

	-- parsing all settings for the dockspot
	for i, data in pairsByIndex(dockspotData.settings) do

		-- current element name
		local currElement = settingsWindow .. data.name

		-- does the window already exist?
		if DoesWindowExist(currElement) then

			-- destroy the existing element
			DestroyWindow(currElement)
		end

		-- create the element
		CreateWindowFromTemplate(currElement, data.template, settingsWindow)

		-- reset the element anchors
		WindowClearAnchors(currElement)
		
		-- is this a sub-section?
		if data.template == "DockspotSubSectionLabelTemplate" then

			-- filling the text
			LabelSetText(currElement .. "Label", GetStringFromTid(data.nameTid))

			-- do we have to use a color for the text?
			if data.color then

				-- change the label color
				LabelSetTextColor(currElement .. "Label", data.color.r, data.color.g, data.color.b)
			end

		-- is this a checkbox with label?
		elseif data.template == "DockspotLabelCheckButton" then

			-- filling the text
			LabelSetText(currElement .. "Label", GetStringFromTid(data.nameTid))

			-- do we have to use a color for the text?
			if data.color then

				-- change the label color
				LabelSetTextColor(currElement .. "Label", data.color.r, data.color.g, data.color.b)
			end

			-- do we have a tooltip to show?
			if data.tooltipTid then
						
				-- add the tooltip TID as ID of the label
				WindowSetId(currElement .. "Label", data.tooltipTid)
			end

			-- turn the button into a checkbox
			ButtonSetCheckButtonFlag(currElement .. "Button", true)

			-- check value for the checkbox
			local checkState = false

			-- is this a dockspot setting?
			if dockspotData[data.name] ~= nil then

				-- get the check value
				checkState = dockspotData[data.name]

				-- loading the current checkbox status
				ButtonSetPressedFlag(currElement .. "Button", checkState)

			else -- this is a sub-filter setting

				-- get the current filter data
				local currentFitler = MobileBarsDockspot.SavedFilters[MobileBarsDockspot.GetFilterByID(MobileBarsDockspot.ActiveFilter)]

				-- get the check value
				checkState = currentFitler.subFilters[MobileBarsDockspot.SubFilters[data.name]]

				-- loading the sub-filter status
				ButtonSetPressedFlag(currElement .. "Button", currentFitler.subFilters[MobileBarsDockspot.SubFilters[data.name]])
			end

			-- elements to hide if the check state is false
			if data.hideElementsFalse and checkState == false then
				table.append(elementsToHide, data.hideElementsFalse)
			end

		-- is this a combo with label?
		elseif data.template == "DockspotLabelCombo" then

			-- filling the text
			LabelSetText(currElement .. "Label", GetStringFromTid(data.nameTid))

			-- do we have to use a color for the text?
			if data.color then

				-- change the label color
				LabelSetTextColor(currElement .. "Label", data.color.r, data.color.g, data.color.b)
			end

			-- do we have a tooltip to show?
			if data.tooltipTid then
						
				-- add the tooltip TID as ID of the label
				WindowSetId(currElement .. "Label", data.tooltipTid)
			end

			-- filling the combo box
			pcall(data.comboFill, currElement .. "Combo")

			-- get the selection ID
			local selection = dockspotData[data.name]

			-- is this the layout template?
			if data.name == "layoutType" then

				-- layout start from 2 since the 1 is only for mobiles (and the only layout they have)
				selection = selection - 1
			end
			
			-- selecting the combo value
			ComboBoxSetSelectedMenuItem(currElement .. "Combo", selection)

		-- is this the filter selection combo?
		elseif data.template == "SavedFiltersTemplate" then

			-- filling the combo box
			pcall(data.comboFill, currElement .. "Combo")
			
			-- combo ID to select (since is sorted by name, the ID is not the same as the filter)
			local selection = 1

			-- scan all the filters
			for name, data in pairsByKeys(MobileBarsDockspot.SavedFilters) do

				-- is this the active filter?
				if data.id == MobileBarsDockspot.ActiveFilter then

					-- selecting the combo value
					ComboBoxSetSelectedMenuItem(currElement .. "Combo", selection)
				end

				-- increase the selection ID
				selection = selection + 1
			end

			-- show the delete filter button
			WindowSetShowing(currElement .. "DeleteFilter", true)

			-- is this the default filter?
			if MobileBarsDockspot.ActiveFilter == 1 then

				-- hide the delete filter set button
				WindowSetShowing(currElement .. "DeleteFilter", false)
			end

		-- is this a checkbox slider with label?
		elseif data.template == "DockspotSliderItemTemplate" then
					
			-- filling the text
			LabelSetText(currElement .. "Label", GetStringFromTid(data.nameTid))

			-- filling the text for plus/minus buttons
			LabelSetText(currElement .. "PlusButton", L"+")
			LabelSetText(currElement .. "MinusButton", L"-")

			-- do we have to use a color for the text?
			if data.color then

				-- change the label color
				LabelSetTextColor(currElement .. "Label", data.color.r, data.color.g, data.color.b)
			end

			-- do we have a tooltip to show?
			if data.tooltipTid then
						
				-- add the tooltip TID as ID of the label
				WindowSetId(currElement .. "Label", data.tooltipTid)
			end

			-- get the current filter data
			local currentFitler = MobileBarsDockspot.SavedFilters[MobileBarsDockspot.GetFilterByID(MobileBarsDockspot.ActiveFilter)]

			-- get the amount of mobiles for the notoriety
			local sliderValue = currentFitler.notorieties[NameColor.Notoriety[data.name]]
			
			-- get the value for the slider bar
			sliderValue = sliderValue / 20

			-- update slider position
			SliderBarSetCurrentPosition(currElement .. "SliderBar", sliderValue)

			-- update the value text
			MobileBarsDockspot.UpdateSliderValue(currElement .. "SliderBar")

		-- is this the custom text box?
		elseif data.template == "SearchBoxNoNext_MEDIUM" then
			
			-- get the current filter data
			local currentFitler = MobileBarsDockspot.SavedFilters[MobileBarsDockspot.GetFilterByID(MobileBarsDockspot.ActiveFilter)]

			-- set the custom text into the textbox
			TextEditBoxSetText(currElement .. "Filter", towstring(currentFitler.customText))
		end

		-- execute the anchoring
		pcall(data.anchorFunc, {currElement, prevElement})

		-- force process anchors or the measurement will be wrong
		WindowForceProcessAnchors(currElement)

		-- previous element name
		prevElement = currElement

		-- get the height of the last element
		local _, h = WindowGetDimensions(prevElement)

		-- get the offset from parent of the last element + its height (to calculate the top height of the scroll window)
		local _, offsetY = WindowGetOffsetFromParent(prevElement)

		-- is the offset correct and greater than the previous value?
		if (offsetY + h) > topOffset then

			-- update the offset
			topOffset = (offsetY + h)

		else -- something is gone wrong with  WindowGetOffsetFromParent

			-- get the height of the current element
			_, h = WindowGetDimensions(currElement)

			-- get the offset from parent of the last element + its height (to calculate the top height of the scroll window)
			_, offsetY = WindowGetOffsetFromParent(currElement)

			-- update the offset
			topOffset = (offsetY + h)

			-- get the height of the last element
			_, h = WindowGetDimensions(prevElement)

			-- get the prev item anchor
			local point, relativePoint, relativeTo, xOffset, yOffset = WindowGetAnchor(prevElement, 1)

			-- update the offset correctly
			topOffset = topOffset + h + yOffset 
		end
	end

	-- parse the elments to hide
	for i, elmnt in pairsByIndex(elementsToHide) do
		
		-- real element name
		local element = settingsWindow .. elmnt

		-- does the element exist?
		if DoesWindowExist(element) then

			-- disable the element
			SettingsWindow.SetDisabled(element)
		end
	end

	-- get the scroll area dimensions
	local w, h = WindowGetDimensions(settingsWindow)

	-- fix the window area dimensions
	WindowSetDimensions(settingsWindow, w, topOffset + 20)

	-- scale the window
	WindowSetScale(settingsWindow, MobileBarsDockspot.SettingsScale)
end

function MobileBarsDockspot.SettingsShutdown()

	-- get the current window name
	local windowName = SystemData.ActiveWindow.name

	-- get the dockspot window name
	local dockspotName = string.gsub(windowName, "Settings", "")

	-- create a variable as pointer for the dockspot record
	local dockspotData = MobileBarsDockspot.Dockspots[dockspotName]

	-- lock the dockspot
	dockspotData.locked = true

	-- restart the update sequence
	dockspotData.stopUpdate = false

	-- hide the grid
	MobileBarsDockspot.HideLayoutGrid(dockspotName)

	-- is this the pinned dockspot?
	if dockspotData.dockspotType == MobileBarsDockspot.DockspotType.PINNED then
		
		-- do we have an honor target?
		if Interface.Settings.AutoPinHonored and IsValidID(Interface.CurrentHonor) then

			-- create andpin the honor target healthbar
			MobileHealthBar.CreateBar(Interface.CurrentHonor, true)
		end

		-- restore the pinned bars in 1s
		Interface.AddTodoList({name = "Restore the pinned bars after settings", func = function() MobileBarsDockspot.RestorePinnedBars() end, time = Interface.TimeSinceLogin + 1})
	end

	-- save the window position
	WindowUtils.SaveWindowPosition(windowName, false, "DockspotSettingsWindow")

	-- save the window position
	WindowUtils.SaveWindowPosition(dockspotName)
end

function MobileBarsDockspot.SettingsCheck()

	-- get the current checkbox window name
	local win = string.gsub(SystemData.ActiveWindow.name, "Label", "Button")

	-- inverting the checkbox value
	ButtonSetPressedFlag( win, not ButtonGetPressedFlag( win ))

	-- parse the check value
	MobileBarsDockspot.SettingsCheckEnable(win)
end

function MobileBarsDockspot.SettingsCheckEnable()

	-- current window name
	local this = SystemData.ActiveWindow.name
	this = string.gsub(this, "Label", "Button")

	-- settings window name
	local settingsWindow = WindowUtils.GetActiveDialog()

	-- get the dockspot window name
	local dockspotName = string.gsub(settingsWindow, "Settings", "")

	-- get the variable name
	local variable = string.gsub(string.gsub(this, settingsWindow, ""), "Button", "")

	-- get the button flag
	local checkValue = ButtonGetPressedFlag(this)

	-- create a variable as pointer for the dockspot record
	local dockspotData = MobileBarsDockspot.Dockspots[dockspotName]
	
	-- is this a valid setting?
	if dockspotData[variable] ~= nil then

		-- update the setting
		dockspotData[variable] = checkValue
		 
		-- save the setting
		Interface.SaveSetting(dockspotName .. variable, checkValue)

		-- apply the saved button rotation
		MobileBarsDockspot.ApplyButtonRotation(dockspotName, true)

		-- create the layout grid
		MobileBarsDockspot.CreateLayoutGrid(dockspotName)

		-- make sure the layout is visible
		MobileBarsDockspot.ShowLayoutGrid(dockspotName)

	else -- this is a sub-filter setting
		
		-- get the current filter data
		local currentFitler = MobileBarsDockspot.SavedFilters[MobileBarsDockspot.GetFilterByID(MobileBarsDockspot.ActiveFilter)]

		-- get the subfilter index
		local subFilterIndex = MobileBarsDockspot.SubFilters[variable]

		-- toggle the sub-filter
		currentFitler.subFilters[subFilterIndex] = checkValue

		-- save the subfilter flag
		Interface.SaveSetting("DockspotFilterSubFilter" .. subFilterIndex .. "_" .. MobileBarsDockspot.ActiveFilter, currentFitler.subFilters[subFilterIndex])
	end

	-- for the friends or foe option we need to close the settings
	if variable == "friendFoe" then

		-- close the settings window
		DestroyWindow(settingsWindow)
	end
end

function MobileBarsDockspot.SettingsOnSelChanged()

	-- current window name
	local this = SystemData.ActiveWindow.name

	-- settings window name
	local settingsWindow = WindowUtils.GetActiveDialog()

	-- get the dockspot window name
	local dockspotName = string.gsub(settingsWindow, "Settings", "")

	-- get the variable name
	local variable = string.gsub(string.gsub(this, settingsWindow, ""), "Combo", "")

	-- create a variable as pointer for the dockspot record
	local dockspotData = MobileBarsDockspot.Dockspots[dockspotName]

	-- get the new combo value
	local selection = ComboBoxGetSelectedMenuItem(this)

	-- is this the layout template?
	if variable == "layoutType" then

		-- layout start from 2 since the 1 is only for mobiles (and the only layout they have)
		selection = selection + 1
	end

	-- is this a valid setting?
	if dockspotData[variable] then

		-- update the setting
		dockspotData[variable] = selection
		
		-- save the setting
		Interface.SaveSetting(dockspotName .. variable, selection)

		-- create the layout grid
		MobileBarsDockspot.CreateLayoutGrid(dockspotName)

		-- make sure the layout is visible
		MobileBarsDockspot.ShowLayoutGrid(dockspotName)
	end
end

MobileBarsDockspot.isSliding = {}
function MobileBarsDockspot.AlterSlider()
	
	-- current window name
	local this = SystemData.ActiveWindow.name

	-- get the bar name
	local bar = WindowGetParent(this) .. "SliderBar"

	-- get the current bar value
	local barValue = SliderBarGetCurrentPosition( bar )

	-- increase the value
	if string.find(this, "Plus", 1, true) then
		barValue = barValue + 0.05
	
	else -- decrease the value
		barValue = barValue - 0.05
	end

	-- update the bar value
	SliderBarSetCurrentPosition( bar, barValue )
	
	-- process the update
	MobileBarsDockspot.UpdateSliderValue(bar)

	-- update the last time this slidebar has been used
	MobileBarsDockspot.isSliding[bar] = Interface.TimeSinceLogin + 1

	-- wait for the player to stop sliding then flag the sliding as stopped
	Interface.ExecuteWhenAvailable(
	{
		name = "ChangedSlidebarSettingsTimeout_" .. bar,
		check = function() return Interface.TimeSinceLogin > MobileBarsDockspot.isSliding[bar] end, 
		callback = function() MobileBarsDockspot.isSliding[bar] = nil end, 
		removeOnComplete = true
	})

	-- save the setting only after the player have stopped sliding
	Interface.ExecuteWhenAvailable(
	{
		name = "ChangedSlidebarSettings_" .. bar,
		check = function() return MobileBarsDockspot.isSliding[bar] == nil end, 
		callback = function() MobileBarsDockspot.SaveSliderValue(bar) end, 
		removeOnComplete = true
	})
end

function MobileBarsDockspot.UpdateSliderSettings(curPos)

	-- original window name
	local bar = SystemData.ActiveWindow.name

	-- update the last time this slidebar has been used
	MobileBarsDockspot.isSliding[bar] = Interface.TimeSinceLogin + 1

	-- update the value
	MobileBarsDockspot.UpdateSliderValue(bar)

	-- wait for the player to stop sliding then flag the sliding as stopped
	Interface.ExecuteWhenAvailable(
	{
		name = "ChangedSlidebarSettingsTimeout_" .. bar,
		check = function() return Interface.TimeSinceLogin > MobileBarsDockspot.isSliding[bar] end, 
		callback = function() MobileBarsDockspot.isSliding[bar] = nil end, 
		removeOnComplete = true
	})

	-- save the setting only after the player have stopped sliding
	Interface.ExecuteWhenAvailable(
	{
		name = "ChangedSlidebarSettings_" .. bar,
		check = function() return MobileBarsDockspot.isSliding[bar] == nil end, 
		callback = function() MobileBarsDockspot.SaveSliderValue(bar) end, 
		removeOnComplete = true
	})
end

function MobileBarsDockspot.UpdateSliderValue(bar)
	
	-- bar name
	local barName = WindowGetParent(bar)

	-- get the bar value
	local barVal = SliderBarGetCurrentPosition(bar) * 20
	barVal = wstring.format(L"%1.0f", barVal)
	
	-- get the label text
	local labelText = LabelGetText(barName .. "Label")

	-- do we have the value in the text?
	if wstring.find(labelText, L"(", 1, true) then
		labelText = wstring.sub(labelText, 1, wstring.find(labelText, L"(", 1, true) - 2)
	end

	-- do we have a value higher than 0?
	if tonumber(barVal) > 0 then

		-- show the bar value
		LabelSetText(barName .. "Label", labelText .. L" (" .. barVal .. L")")

	else -- remove the bar value
		LabelSetText(barName .. "Label", labelText .. L" (OFF)")
	end
end

function MobileBarsDockspot.SaveSliderValue(bar)

	-- get the notoriety type
	local value = string.sub(WindowGetParent(bar), string.find(WindowGetParent(bar), "DockspotSettings", 1, false) + 16)

	-- get the bar value
	local barVal = SliderBarGetCurrentPosition(bar) * 20
	barVal = wstring.format(L"%1.0f", barVal)

	-- get the current filter data
	local currentFitler = MobileBarsDockspot.SavedFilters[MobileBarsDockspot.GetFilterByID(MobileBarsDockspot.ActiveFilter)]

	-- get the notoriety index
	local notoIndex = NameColor.Notoriety[value]

	-- update the filter
	currentFitler.notorieties[notoIndex] = tonumber(barVal)
	
	-- save the notoriety amount
	Interface.SaveSetting("DockspotFilterNoto" .. notoIndex .. "_" .. MobileBarsDockspot.ActiveFilter, currentFitler.notorieties[notoIndex])
end

function MobileBarsDockspot.CustomTextChanged()
	
	-- window name
	local textbox = WindowGetParent(SystemData.ActiveWindow.name)

	-- get the variable name
	local value = string.gsub(textbox, WindowUtils.GetTopmostDialog(textbox), "")
	
	-- get the current filter data
	local currentFitler = MobileBarsDockspot.SavedFilters[MobileBarsDockspot.GetFilterByID(MobileBarsDockspot.ActiveFilter)]

	-- save the textbox value
	currentFitler[value] = wstring.lower(TextEditBoxGetText(textbox .. "Filter"))

	-- if we have an empty string, we save a space (or it won't work correctly)
	if not IsValidWString(currentFitler[value]) then
		currentFitler[value] = L" "
	end
	
	-- save the custom text filter
	Interface.SaveSetting("DockspotFilterCT" .. MobileBarsDockspot.ActiveFilter, currentFitler[value])
end

function MobileBarsDockspot.DeleteFilterTooltip()

	-- remove saved filter button tooltip
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(430))
end

function MobileBarsDockspot.CreateFilterTooltip()

	-- create new filter set button tooltip
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(429))
end

function MobileBarsDockspot.CreateFilter()

	-- create an input box to get the criteria set name
	local rdata = {title=GetStringFromTid(429), subtitle=GetStringFromTid(442), callfunction=MobileBarsDockspot.CreateFilter_final, maxChars=10}
	RenameWindow.Create(rdata)
end

function MobileBarsDockspot.CreateFilter_final(id, name)

	-- do we have a valid name?
	if not IsValidWString(name) then
		return
	end

	-- turn the name lower case (to avoid duplicates)
	name = wstring.lower(name)

	-- does the filter already exist?
	if MobileBarsDockspot.SavedFilters[name] then

		-- select the existing filter with the same name
		MobileBarsDockspot.FilterListSelect(MobileBarsDockspot.GetFilterIDByName(name))

		return
	end

	-- create the new filter
	MobileBarsDockspot.SavedFilters[name]= {
	
		-- ID of the filter
		id = MobileBarsDockspot.TotalFilters + 1,

		-- default notoriety filters
		notorieties =	{
						[NameColor.Notoriety.NONE]         =		0, -- mobile data still not loaded, never show
						[NameColor.Notoriety.INNOCENT]     =		20,
						[NameColor.Notoriety.FRIEND]       =		20,
						[NameColor.Notoriety.CANATTACK]    =		20,
						[NameColor.Notoriety.CRIMINAL]     =		20,
						[NameColor.Notoriety.ENEMY]        =		20,
						[NameColor.Notoriety.MURDERER]     =		20,
						[NameColor.Notoriety.INVULNERABLE] =		20,
						[NameColor.Notoriety.HONORED]	   =		0, -- always disabled in the mobiles list
						},
	
		-- default sub-filters
		subFilters =	{
						[MobileBarsDockspot.SubFilters.NEUTRALANIMALS] =		true,
						[MobileBarsDockspot.SubFilters.SUMMON] =				true,
						[MobileBarsDockspot.SubFilters.BOSS] =					true,
						[MobileBarsDockspot.SubFilters.QUESTGIVER] =			true,
						[MobileBarsDockspot.SubFilters.STABLEMASTERS] =			true,
						[MobileBarsDockspot.SubFilters.BANKERS] =				true,
						[MobileBarsDockspot.SubFilters.SHOPKEEPERS] =			true,
						[MobileBarsDockspot.SubFilters.BODDEALERS] =			true,
						[MobileBarsDockspot.SubFilters.PLAYERVENDORS] =			true,
						[MobileBarsDockspot.SubFilters.SOMEONEPET] =			true,
						[MobileBarsDockspot.SubFilters.PLAYERS] =				true,
						},

		-- custom text filter
		customText = L""
	}

	-- increase the total filters count
	MobileBarsDockspot.TotalFilters = table.countElements(MobileBarsDockspot.SavedFilters)

	-- save the new total filters count
	Interface.SaveSetting("TotalFilters", MobileBarsDockspot.TotalFilters)

	-- save the new filter changes
	MobileBarsDockspot.SaveFilter(MobileBarsDockspot.TotalFilters)

	-- select the existing filter with the same name
	MobileBarsDockspot.FilterListSelect(MobileBarsDockspot.TotalFilters)
end

function MobileBarsDockspot.FillFiltersCombo(combo)

	-- clear the filters combo
	ComboBoxClearMenuItems(combo)

	-- scan the filters list
	for filterName, _ in pairsByKeys(MobileBarsDockspot.SavedFilters) do  

		-- add the new setting to the list
		ComboBoxAddMenuItem(combo, FormatProperly(filterName)) 
	end
end

function MobileBarsDockspot.DeleteFilter()

	-- initialize the buttons with the callback
	local OKButton = { textTid=UO_StandardDialog.TID_OKAY, callback=function() MobileBarsDockspot.DeleteFilter_final() end } -- OK
	local cancelButton = { textTid=UO_StandardDialog.TID_CANCEL } -- Cancel

	-- initialize the confirm dialog
	local DeleteCriteriaSetWindow = 
				{
					windowName = "DeleteFilter",
					titleTid = 430,
					bodyTid  = 443,
					buttons = { OKButton, cancelButton },
					closeCallback = cancelButton.callback,
					destroyDuplicate = true,
				}

	-- show the confirm dialog
	UO_StandardDialog.CreateDialog(DeleteCriteriaSetWindow)
end

function MobileBarsDockspot.DeleteFilter_final()

	-- get the name of the filter to be deleted
	local filterToDelete = MobileBarsDockspot.GetFilterByID(MobileBarsDockspot.ActiveFilter)

	-- STEP 1: delete all the saved filters from the character profile
	for name, data in pairs(MobileBarsDockspot.SavedFilters) do

		-- delete all notorieties
		for i = 2, #NameColor.TextColors - 1 do
			Interface.DeleteSetting("DockspotFilterNoto" .. i .. "_" .. data.id)
		end

		-- delete all subfilters
		for i = 1, table.countElements(MobileBarsDockspot.SubFilters) do
			Interface.DeleteSetting("DockspotFilterSubFilter" .. i .. "_" .. data.id)
		end

		-- delete the custom text filter
		Interface.DeleteSetting("DockspotFilterCT" .. data.id)

		-- delete the filter name
		Interface.DeleteSetting("DockspotFilterName" .. data.id)
	end

	-- STEP 2: delete the selected filter
	MobileBarsDockspot.SavedFilters[filterToDelete] = nil

	-- STEP 3: update the filters IDS and save them all again

	-- filter count (start from 2 since 1 is always default - and can't be deleted)
	local filterID = 2

	-- scan all filters
	for name, data in pairsByKeys(MobileBarsDockspot.SavedFilters) do

		-- the default filter is always ID 1
		if name == L"default" then
			
			-- set the right ID for default
			data.id = 1

			-- save the filter
			MobileBarsDockspot.SaveFilter(data.id)

			-- we can keep going
			continue
		end

		-- set the new filter ID
		data.id = filterID

		-- save the filter
		MobileBarsDockspot.SaveFilter(data.id)

		-- increase the filter ID
		filterID = filterID + 1
	end

	-- STEP 4: update the amount of filters we have
	MobileBarsDockspot.TotalFilters = table.countElements(MobileBarsDockspot.SavedFilters)

	-- save the new total filters count
	Interface.SaveSetting("TotalFilters", MobileBarsDockspot.TotalFilters)

	-- STEP 5: select the default filter
	MobileBarsDockspot.FilterListSelectByName(L"default")
end

function MobileBarsDockspot.ComboFilterListSelect(selectedIndex)

	-- combo window name
	local combo = SystemData.ActiveWindow.name

	-- get the combo text
	local selectedText = wstring.lower(ComboBoxGetSelectedText(combo))

	-- get the correct ID for the filter
	local id = MobileBarsDockspot.GetFilterIDByName(selectedText)

	-- select the filter
	MobileBarsDockspot.FilterListSelect(id)
end

function MobileBarsDockspot.FilterListSelectByName(name)
	
	-- is this a valid wstring?
	if not IsValidWString(name) then
		return
	end
	
	-- get the correct ID for the filter
	local id = MobileBarsDockspot.GetFilterIDByName(name)

	-- set the new active filter
	MobileBarsDockspot.ActiveFilter = id

	-- save the new active filter
	Interface.SaveSetting("ActiveFilter", MobileBarsDockspot.ActiveFilter)

	-- select the filter
	MobileBarsDockspot.FilterListSelect(id)	
end

function MobileBarsDockspot.FilterListSelect(selectedIndex)

	-- do we have a valid selection?
	if not IsValidID(selectedIndex) then
		return
	end

	-- get the dockspot name
	local dockspotName = MobileBarsDockspot.DockspotDefaultNames[MobileBarsDockspot.DockspotType.MOBILES]

	-- main settings window
	local settingWindow = dockspotName .. "Settings"

	-- is the setting window visible? (action call)
	if not DoesWindowExist(settingWindow) then
		
		-- update the docked bars
		MobileBarsDockspot.UpdateDockspotBars(dockspotName)

		return
	end

	-- save the current filter settings
	MobileBarsDockspot.SaveFilter(MobileBarsDockspot.ActiveFilter)

	-- set the new active filter
	MobileBarsDockspot.ActiveFilter = selectedIndex

	-- save the new active filter
	Interface.SaveSetting("ActiveFilter", MobileBarsDockspot.ActiveFilter)

	-- update the setting window with the new selection
	MobileBarsDockspot.PopulateSettings(settingWindow, MobileBarsDockspot.Dockspots[dockspotName])
end

function MobileBarsDockspot.GetFilterByID(id)

	-- do we have a valid id?
	if not IsValidID(id) then
		return L"Default"
	end

	-- scan all the filters
	for name, data in pairs(MobileBarsDockspot.SavedFilters) do
		
		-- is this the ID we're looking for?
		if data.id == id then

			return name
		end
	end

	return L"Default"
end

function MobileBarsDockspot.GetFilterIDByName(name)

	-- do we have a valid id?
	if not IsValidWString(name) then
		return 1
	end

	-- scan all the filters
	for filtername, data in pairs(MobileBarsDockspot.SavedFilters) do
		
		-- is this the ID we're looking for?
		if filtername == name then

			return data.id
		end
	end

	return 1
end

function MobileBarsDockspot.LoadFilter(id)

	-- initalize the name variable
	local name

	-- if the ID is 1, the default name will be "default"
	if id == 1 then
		name = L"default"
	end

	-- get the filter name
	name = Interface.LoadSetting("DockspotFilterName" .. id, name, L"")

	-- do we have a valid name?
	if not IsValidWString(name) then
		return
	end

	-- initialize the filter record
	local filter = {}

	-- set the filter ID
	filter.id = id

	-- initialize the notorieties
	filter.notorieties = {}

	-- no notoriety is always disabled
	filter.notorieties[1] = 0
	
	-- loading all notorieties
	for i = 2, #NameColor.TextColors - 1 do

		-- load the notoriety amount
		filter.notorieties[i] = Interface.LoadSetting("DockspotFilterNoto" .. i .. "_" .. id, 20)
	end

	-- honored is never shown in the mobiles list
	filter.notorieties[9] = 0

	-- initialize the subfilters
	filter.subFilters = {}

	-- loading all subfilters
	for i = 1, table.countElements(MobileBarsDockspot.SubFilters) do

		-- load the subfilter flag
		filter.subFilters[i] = Interface.LoadSetting("DockspotFilterSubFilter" .. i .. "_" .. id, true)
	end

	-- load the custom text filter
	filter.customText = wstring.trim(Interface.LoadSetting("DockspotFilterCT" .. id, L""))

	-- load the filter into the table
	MobileBarsDockspot.SavedFilters[name] = filter
end

function MobileBarsDockspot.SaveFilter(id)

	-- get the filter name
	local name = MobileBarsDockspot.GetFilterByID(id)
	
	-- do we have a valid name?
	if not IsValidWString(name) then
		return
	end

	-- save the filter name
	Interface.SaveSetting("DockspotFilterName" .. id, name)

	-- loading all notorieties
	for i = 2, #NameColor.TextColors - 1 do

		-- save the notoriety amount
		Interface.SaveSetting("DockspotFilterNoto" .. i .. "_" .. id, MobileBarsDockspot.SavedFilters[name].notorieties[i])
	end

	-- loading all subfilters
	for i = 1, table.countElements(MobileBarsDockspot.SubFilters) do

		-- save the subfilter flag
		Interface.SaveSetting("DockspotFilterSubFilter" .. i .. "_" .. id, MobileBarsDockspot.SavedFilters[name].subFilters[i])
	end
	
	-- if we have an empty string, we save a space (or it won't work correctly)
	if not IsValidWString(MobileBarsDockspot.SavedFilters[name].customText) then
		MobileBarsDockspot.SavedFilters[name].customText = L" "
	end

	-- save the custom text filter
	Interface.SaveSetting("DockspotFilterCT" .. id, MobileBarsDockspot.SavedFilters[name].customText)
end

function MobileBarsDockspot.DockspotTypeToString(dsType)

	-- scan the type table
	for name, typ in pairs(MobileBarsDockspot.DockspotType) do
		
		-- is this the type we're looking for?
		if dsType == typ then
			return name
		end
	end
end

function MobileBarsDockspot.RestorePinnedBars()

	-- do we have any stored pinned bar?
	if not MobileBarsDockspot.StoredPinnedBars then
		return
	end

	-- scan the stored pinned bar
	for mobileId, _ in pairs(MobileBarsDockspot.StoredPinnedBars) do
		
		-- is the healthbar enabled?
		if not IsHealthBarEnabled(mobileId) then

			-- remove the mobile from the list
			MobileBarsDockspot.StoredPinnedBars[mobileId] = nil

			continue
		end

		-- create and/or pin the healthbar
		MobileHealthBar.CreateBar(mobileId, true)
	end
end