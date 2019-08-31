----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

CreditsWindow = {}

CreditsWindow.ContributionPerks = 
{
	[1] = { r = 216, g = 200, b = 176 },
	[2] = { r = 112, g = 104, b = 120 },
	[3] = { r = 232, g = 200, b = 120 },
	[4] = { r = 184, g = 144, b = 64 },
	[5] = { r = 240, g = 208, b = 64 },
	[6] = { r = 232, g = 192, b = 168 },
	[7] = { r = 208, g = 224, b = 104 },
	[8] = { r = 176, g = 208, b = 232 },
}

CreditsWindow.ContributionPerksName = 
 {
	[1] = L"Dull Copper",
	[2] = L"Shadow",
	[3] = L"Copper",
	[4] = L"Bronze",
	[5] = L"Golden",
	[6] = L"Agapite",
	[7] = L"Verite",
	[8] = L"Valorite",
 }

CreditsWindow.Contributors = 
{
	{ id = 19521476, shard = L"Test Center 1", perk = 8, engrave = L"Pinco", portrait = "" }, -- test

	{ id = 20920293, shard = L"Drachenfels", perk = 2, portrait = "" }, -- oliver rosin
	{ id = 28802784, shard = L"Drachenfels", perk = 2, portrait = "" }, -- oliver rosin

	{ id = 21757147, shard = L"Drachenfels", perk = 1, engrave = L"Protector Of The Lost Heals", portrait = "" }, -- andreas berger

	{ id = 11453549, shard = L"Drachenfels", perk = 8, engrave = L"My love Vegas", portrait = "vegasPortrait" }, -- johann soppoth

	{ id = 23503564, shard = L"Lake Superior", perk = 1, engrave = L"Treasure Hunters of Britannia", portrait = "" }, -- michael meyer
}

-- current scroll position
local i = 0

-- OnInitialize Handler
function CreditsWindow.Initialize()
	
	-- set the window title
	WindowUtils.SetWindowTitle("CreditsWindow", GetStringFromTid(192))
    
	-- update the scrollable area
	ScrollWindowUpdateScrollRect("CreditsContentWindow")

	-- get the credits text
	local text = LoadTextFile("./UserInterface/" .. SystemData.Settings.Interface.customUiName .. "/Source/System/Credits/credits.txt")
	
	-- show the credits text
	LabelSetText("CreditsWindowText1", text)
end

function CreditsWindow.Shutdown()

	-- re-enable the area music
	Interface.DisableAreaMusic = nil

	-- do we have the area music?
	if MapCommon.CurrentAreaMusic then

		-- play the area music
		ECPlaySound(1, MapCommon.CurrentAreaMusic, 2)

	else -- play a random wild music
		ECPlaySound(1, "WildSong" .. math.random(Interface.WildSongs) .. ".mp3", 2)
	end
end

function CreditsWindow.OnUpdate(timepassed)

	-- get the max scrollable area size
	local _, maxOffset = WindowGetDimensions("CreditsContentWindowScrollChild")

	-- increase the current position
	i = i + 1

	-- scroll to the current position
	ScrollWindowSetOffset("CreditsContentWindow", i)

	-- have we reached the bottom?
	if i >= maxOffset then

		-- move to the beginning
		i = 0
	end
end

function CreditsWindow.OnShown()

	-- reset the scroll position
	i = 0

	-- disable the area music
	Interface.DisableAreaMusic = true

	-- play the credits song
	ECPlaySound(1, "credits.mp3", 2)

	-- hide the main menu (if it's visible)
	WindowSetShowing("MainMenuWindow", false)
end

function CreditsWindow.Close()

	-- re-enable the area music
	Interface.DisableAreaMusic = nil

	-- do we have the area music?
	if MapCommon.CurrentAreaMusic then

		-- play the area music
		ECPlaySound(1, MapCommon.CurrentAreaMusic, 2)

	else -- play a random wild music
		ECPlaySound(1, "WildSong" .. math.random(Interface.WildSongs) .. ".mp3", 2)
	end
end

function CreditsWindow.GetContributorData(mobileId)
	
	-- parse all the contributors
	for contrib, data in pairs(CreditsWindow.Contributors) do
	
		-- does this contributor ID matches the one we're looking for and also is in the right shard?
		if data.id == mobileId and Interface.ShardsList[UserData.Settings.Login.lastShardSelected] == data.shard then
			return data
		end
	end
end