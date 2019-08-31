----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

CrystalPortal = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

CrystalPortal.WindowName = "CrystalPortal"

CrystalPortal.Trammel = {}
CrystalPortal.Trammel.Dungeons = 
{
	{ name = L"Blighted Grove", command = L"grove" },
	{ name = L"Covetous", command = L"covetous" },
	{ name = L"Deceit", command = L"deceit" },
	{ name = L"Despise", command = L"despise" },
	{ name = L"Destard", command = L"destard" },
	{ name = L"Ice", command = L"ice" },
	{ name = L"Fire", command = L"fire" },
	{ name = L"Hythloth", command = L"hythloth" },
	{ name = L"Orc Cave", command = L"orc" },
	{ name = L"Painted Caves", command = L"caves" },
	{ name = L"Palace of Paroxysmus", command = L"palace" },
	{ name = L"Prism of Light", command = L"prism" },
	{ name = L"Sanctuary", command = L"sanctuary" },
	{ name = L"Shame", command = L"shame" },
	{ name = L"Wind", command = L"wind" },
	{ name = L"Wrong", command = L"wrong" },
	{ name = L"Doom", command = L"doom" },
	{ name = L"The Citadel", command = L"citadel" },
	{ name = L"Fan Dancer Dojo", command = L"fandancer" },
	{ name = L"Yomotsu Mines", command = L"mines" },
	{ name = L"Bedlam", command = L"bedlam" },
	{ name = L"The Labyrinth", command = L"labyrinth" },
	{ name = L"Underworld", command = L"underworld" },
	{ name = L"Tomb of the Kings", command = L"abyss" },
	{ name = L"Blackthorn Dungeon", command = L"blackthorn" },
}

CrystalPortal.Trammel.Moongates = 
{
	{ name = L"Britain", command = L"britain" },
	{ name = L"Haven", command = L"haven" },
	{ name = L"Jhelom", command = L"jhelom" },
	{ name = L"Magincia", command = L"magincia" },
	{ name = L"Minoc", command = L"minoc" },
	{ name = L"Moonglow", command = L"moonglow" },
	{ name = L"Skara Brae", command = L"skara" },
	{ name = L"Trinsic", command = L"trinsic" },
	{ name = L"Yew", command = L"yew" },
	{ name = L"Compassion", command = L"compassion" },
	{ name = L"Honesty", command = L"honesty" },
	{ name = L"Honor", command = L"honor" },
	{ name = L"Humility", command = L"humility" },
	{ name = L"Justice", command = L"justice" },
	{ name = L"Sacrifice", command = L"sacrifice" },
	{ name = L"Spirituality", command = L"spirituality" },
	{ name = L"Valor", command = L"valor" },
	{ name = L"Chaos", command = L"chaos" },
	{ name = L"Luna", command = L"luna" },
	{ name = L"Umbra", command = L"umbra" },
	{ name = L"Isamu Jima", command = L"isamu" },
	{ name = L"Makoto Jima", command = L"makoto" },
	{ name = L"Homare Jima", command = L"homare" },
	{ name = L"Royal City", command = L"termur" },
	{ name = L"Valley of Eodon", command = L"eodon" },
}

CrystalPortal.Trammel.Banks = 
{
	{ name = L"Britain", command = L"britain" },
	{ name = L"Buccaneer's Den", command = L"bucs" },
	{ name = L"Cove", command = L"cove" },
	{ name = L"Delucia", command = L"delucia" },
	{ name = L"Haven", command = L"haven" },
	{ name = L"Jhelom", command = L"jhelom" },
	{ name = L"Magincia", command = L"magincia" },
	{ name = L"Minoc", command = L"minoc" },
	{ name = L"Moonglow", command = L"moonglow" },
	{ name = L"Nujel'm", command = L"nujelm" },
	{ name = L"Papua", command = L"papua" },
	{ name = L"Serpent's Hold", command = L"serpent" },
	{ name = L"Skara Brae", command = L"skara" },
	{ name = L"Trinsic", command = L"trinsic" },
	{ name = L"Vesper", command = L"vesper" },
	{ name = L"Wind", command = L"wind" },
	{ name = L"Yew", command = L"yew" },
	{ name = L"Luna", command = L"luna" },
	{ name = L"Umbra", command = L"umbra" },
	{ name = L"Zento", command = L"zento" },
	{ name = L"Royal City", command = L"termur" },
	{ name = L"Gypsy Bank", command = L"ilshenar" },
}

CrystalPortal.Felucca = {}
CrystalPortal.Felucca.Dungeons = 
{
	{ name = L"Blighted Grove", command = L"grove" },
	{ name = L"Covetous", command = L"covetous" },
	{ name = L"Deceit", command = L"deceit" },
	{ name = L"Despise", command = L"despise" },
	{ name = L"Destard", command = L"destard" },
	{ name = L"Ice", command = L"ice" },
	{ name = L"Fire", command = L"fire" },
	{ name = L"Hythloth", command = L"hythloth" },
	{ name = L"Orc Cave", command = L"orc" },
	{ name = L"Painted Caves", command = L"caves" },
	{ name = L"Prism of Light", command = L"prism" },
	{ name = L"Shame", command = L"shame" },
	{ name = L"Sanctuary", command = L"sanctuary" },
	{ name = L"Wind", command = L"wind" },
	{ name = L"Wrong", command = L"wrong" },
	{ name = L"Blackthorn Dungeon", command = L"blackthorn" },
}

CrystalPortal.Felucca.Moongates = 
{
	{ name = L"Britain", command = L"britain" },
	{ name = L"Buccaneer's Den", command = L"bucs" },
	{ name = L"Jhelom", command = L"jhelom" },
	{ name = L"Magincia", command = L"magincia" },
	{ name = L"Minoc", command = L"minoc" },
	{ name = L"Moonglow", command = L"moonglow" },
	{ name = L"Skara Brae", command = L"skara" },
	{ name = L"Trinsic", command = L"trinsic" },
	{ name = L"Yew", command = L"yew" },
}

CrystalPortal.Felucca.Banks = 
{
	{ name = L"Britain", command = L"britain" },
	{ name = L"Buccaneer's Den", command = L"bucs" },
	{ name = L"Cove", command = L"cove" },
	--{ name = L"Delucia", command = L"delucia" },
	{ name = L"Jhelom", command = L"jhelom" },
	{ name = L"Magincia", command = L"magincia" },
	{ name = L"Minoc", command = L"minoc" },
	{ name = L"Moonglow", command = L"moonglow" },
	{ name = L"Nujel'm", command = L"nujelm" },
	{ name = L"Ocllo", command = L"ocllo" },
	--{ name = L"Papua", command = L"papua" },
	{ name = L"Serpent's Hold", command = L"serpent" },
	{ name = L"Skara Brae", command = L"skara" },
	{ name = L"Trinsic", command = L"trinsic" },
	{ name = L"Vesper", command = L"vesper" },
	{ name = L"Wind", command = L"wind" },
	{ name = L"Yew", command = L"yew" },
}

CrystalPortal.RadioButtons = 
{
	[1012000] = "Trammel",
	[1012001] = "Felucca",
	[1075159] = "Dungeon",
	[1076082] = "Moongate",
	[1076117] = "Bank",
}

CrystalPortal.NoWind = false

CrystalPortal.LastSelection = 1
CrystalPortal.LastMap = 1
CrystalPortal.LastArea = 3

CrystalPortal.ComboElements = {}

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function CrystalPortal.Initialize()

	-- flag the window to be destroyed on close
	Interface.DestroyWindowOnClose[CrystalPortal.WindowName] = true

	-- load the window position
	WindowUtils.RestoreWindowPosition(CrystalPortal.WindowName, false)

	-- set the window title
	WindowUtils.SetWindowTitle(CrystalPortal.WindowName, GetStringFromTid(1113945))  -- Crystal portal

	-- destination label text
	LabelSetText(CrystalPortal.WindowName .. "DestLabel", GetStringFromTid(1012011)) -- L"Destination"
	
	-- go button text
	ButtonSetText(CrystalPortal.WindowName .. "Go", GetStringFromTid(3010006)) -- L"GO!"

	-- scan the radio buttons
	for tid, name in pairs(CrystalPortal.RadioButtons) do

		-- set the radio button label text
		LabelSetText(CrystalPortal.WindowName .. name .. "Label", GetStringFromTid(tid))

		-- turn the button into a checkbox (used as radio button)
		ButtonSetCheckButtonFlag(CrystalPortal.WindowName .. name .. "Button", true)
	end

	-- do we have enough magery to access wind?
	CrystalPortal.NoWind = GetSkillValue(SkillsWindow.SkillsID.MAGERY, true) < 71.5

	-- load the last selected map
	CrystalPortal.LastMap = Interface.LoadSetting("CrystalPortalMap", 1)

	-- load the last selected area
	CrystalPortal.LastArea = Interface.LoadSetting("CrystalPortalArea", 3)

	-- load the last selected location
	CrystalPortal.LastSelection = Interface.LoadSetting("CrystalPortalSelection", 1)

	-- update the radio buttons selection
	CrystalPortal.RadioButtonsUpdate()

	-- update the combo box content and selection
	CrystalPortal.UpdateCombo()

	-- select the saved selection
	ComboBoxSetSelectedMenuItem(CrystalPortal.WindowName .. "DestCombo", CrystalPortal.LastSelection)
end

function CrystalPortal.Shutdown()

	-- save the window position
	WindowUtils.SaveWindowPosition(CrystalPortal.WindowName, false)
end

function CrystalPortal.Toggle()

	-- does the crystal portal window exist?
	if DoesWindowExist(CrystalPortal.WindowName) then

		-- destroy the window
		DestroyWindow(CrystalPortal.WindowName)
		
	else -- create the window
		CreateWindow(CrystalPortal.WindowName, true)
	end
end

function CrystalPortal.RadioButtonsUpdate()

	-- update map radio
	ButtonSetPressedFlag(CrystalPortal.WindowName .. "TrammelButton", CrystalPortal.LastMap == 1)
	ButtonSetPressedFlag(CrystalPortal.WindowName .. "FeluccaButton", CrystalPortal.LastMap == 2)

	-- update area radio
	ButtonSetPressedFlag(CrystalPortal.WindowName .. "DungeonButton", CrystalPortal.LastArea == 1)
	ButtonSetPressedFlag(CrystalPortal.WindowName .. "MoongateButton", CrystalPortal.LastArea == 2)
	ButtonSetPressedFlag(CrystalPortal.WindowName .. "BankButton", CrystalPortal.LastArea == 3)

	-- update combo selection
	ComboBoxSetSelectedMenuItem(CrystalPortal.WindowName .. "DestCombo", CrystalPortal.LastSelection)
end

function CrystalPortal.CheckEnable()

	-- get the current checkbox name
	local checkbox = SystemData.ActiveWindow.name
	
	-- is this the label or the button?
	if string.find(checkbox, "Button", 1, true) or string.find(checkbox, "Label", 1, true) then

		-- get the main element
		checkbox = WindowGetParent(checkbox)
	end

	-- remove the main window name from the checkbox name
	checkbox = string.gsub(checkbox, CrystalPortal.WindowName, "")
	
	-- have we selected a map?
	if checkbox == "Trammel" or checkbox == "Felucca" then

		-- update the radio button flag for the maps
		ButtonSetPressedFlag(CrystalPortal.WindowName .. "TrammelButton", checkbox == "Trammel")
		ButtonSetPressedFlag(CrystalPortal.WindowName .. "FeluccaButton", checkbox == "Felucca")
	end

	-- have we selected a map?
	if checkbox == "Dungeon" or checkbox == "Moongate"  or checkbox == "Bank" then

		-- update the radio button flag for the locations
		ButtonSetPressedFlag(CrystalPortal.WindowName .. "DungeonButton", checkbox == "Dungeon")
		ButtonSetPressedFlag(CrystalPortal.WindowName .. "MoongateButton", checkbox == "Moongate")
		ButtonSetPressedFlag(CrystalPortal.WindowName .. "BankButton", checkbox == "Bank")
	end

	-- update the combo box content and selection
	CrystalPortal.UpdateCombo()
end

function CrystalPortal.GetDataTable()

	-- base data table
	local base = CrystalPortal.Trammel

	-- is the felucca button flagged?
	if ButtonGetPressedFlag(CrystalPortal.WindowName .. "FeluccaButton") then

		-- set the data table on felucca
		base = CrystalPortal.Felucca
	end

	-- is the dungeon button flagged?
	if ButtonGetPressedFlag(CrystalPortal.WindowName .. "DungeonButton") then

		-- set the data table to dungeons
		base = base.Dungeons

	-- is the moongate button flagged?
	elseif ButtonGetPressedFlag(CrystalPortal.WindowName .. "MoongateButton") then

		-- set the data table to moongates
		base = base.Moongates

	-- is the bank button flagged?
	elseif ButtonGetPressedFlag(CrystalPortal.WindowName .. "BankButton") then

		-- set the data table to banks
		base = base.Banks
	end

	return base
end

function CrystalPortal.UpdateCombo()

	-- base data table
	local base = CrystalPortal.GetDataTable()

	-- get the combo window name
	local combo = CrystalPortal.WindowName .. "DestCombo"

	-- name of the current selection in the combo list
	local lastName = CrystalPortal.ComboElements[ComboBoxGetSelectedMenuItem(combo)]
	
	-- clear the combo box list
	ComboBoxClearMenuItems(combo)

	-- reset the combo elements list
	CrystalPortal.ComboElements = {}

	-- count the items in the combo box list
	local count = 0

	-- ID of the item to select in the combo box
	local toSelect = 0

	-- scan all the elements in the data table
	for i, data in pairsByIndex(base) do

		-- is this the "Wind" city element and the player has not enough magery to go there?
		if data.name == L"Wind" and CrystalPortal.NoWind then
			continue
		end

		-- increase the items counter
		count = count + 1

		-- add the element to the combo list
		ComboBoxAddMenuItem(combo, data.name)

		-- add the element to the combo elements list
		table.insert(CrystalPortal.ComboElements, data.name)

		-- is this the previously selected element?
		if lastName == data.name then

			-- store the ID of the element to select
			toSelect = count
		end
	end

	-- do we have a selected element?
	if toSelect == 0 then

		-- select the first element
		ComboBoxSetSelectedMenuItem(combo, 1)

	else -- select the element
		ComboBoxSetSelectedMenuItem(combo, toSelect)
	end
end

function CrystalPortal.GO()

	-- if we have no destination we can get out
	if ComboBoxGetSelectedMenuItem(CrystalPortal.WindowName .. "DestCombo") == 0 then
		return
	end
	
	-- final command to say in order to go to the destination
	local finalstring = L""

	-- get the destination command and the selected index
	local destinationCommand, idx = CrystalPortal.GetDestinationCommand()

	-- set the last selection
	CrystalPortal.LastSelection = idx

	-- save the last selection
	Interface.SaveSetting("CrystalPortalSelection", CrystalPortal.LastSelection)

	-- initialize the last selected map to trammel	
	CrystalPortal.LastMap = 1

	-- is the felucca button flagged?
	if ButtonGetPressedFlag(CrystalPortal.WindowName .. "FeluccaButton") then

		-- add "Fel" in front of the command
		finalstring = L"fel "

		-- set the map to felucca
		CrystalPortal.LastMap = 2
	end

	-- save the selected map
	Interface.SaveSetting("CrystalPortalMap" , CrystalPortal.LastMap)
	
	-- is the dungeon button flagged?
	if ButtonGetPressedFlag(CrystalPortal.WindowName .. "DungeonButton") then

		-- append the command
		finalstring = finalstring .. L"dungeon " .. destinationCommand

		-- set the last area to dungeons
		CrystalPortal.LastArea = 1

	-- is the moongate button flagged?
	elseif ButtonGetPressedFlag(CrystalPortal.WindowName .. "MoongateButton") then

		-- append "moongate" to the command
		finalstring = finalstring .. destinationCommand .. L" moongate"

		-- set the last area to moongates
		CrystalPortal.LastArea = 2

	-- is the bank button flagged?
	elseif ButtonGetPressedFlag(CrystalPortal.WindowName .. "BankButton") then

		-- append "mint" to the command
		finalstring = finalstring .. destinationCommand .. L" mint"

		-- set the last area to banks
		CrystalPortal.LastArea = 3
	end

	-- save the selected area
	Interface.SaveSetting("CrystalPortalArea" , CrystalPortal.LastArea)
	
	-- remove the current target
	ClearCurrentTarget()

	-- say the command in order to send the player to the destination
	SendChat(ChatSettings.Channels[SystemData.ChatLogFilters.SAY].serverCmd, L"/say " .. finalstring)

	-- close the crystal portal
	CrystalPortal.Toggle()
end

function CrystalPortal.GetDestinationCommand()

	-- base data table
	local base = CrystalPortal.GetDataTable()

	-- name of the current selection in the combo list
	local selectedName = CrystalPortal.ComboElements[ComboBoxGetSelectedMenuItem(CrystalPortal.WindowName .. "DestCombo")]

	-- count the items to determine the final ID
	local count = 0

	-- scan all the elements in the data table
	for i, data in pairsByIndex(base) do

		-- is this the "Wind" city element and the player has not enough magery to go there?
		if data.name == L"Wind" and CrystalPortal.NoWind then
			continue
		end

		-- increase the counter
		count = count + 1

		-- is this the previously selected element?
		if selectedName == data.name then

			return data.command, count
		end
	end
end