----------------------------------------------------------------
-- In-Game Interface Initialization Variables
----------------------------------------------------------------

Interface.DebugMode = false
Interface.DisableDiskIO = false
Interface.Version = L"6.1"

Interface.LoadedSettings = false
Interface.ArcaneFocusLevel = 0

-- In the future, this could be exposed by c++:
Interface.PLAYWINDOWSET = 2

Interface.TimeSinceLogin = 0
Interface.OpeningBpk = 0
Interface.DeltaTime = 0
Interface.AtlasResetTime = 0
Interface.MobilesOnScreenDelta = 5

Interface.CurrentHonor = 0
Interface.LastItem = 0
Interface.LastMobile = 0
Interface.LastMouseOverItem = 0

Interface.MenuId = -1

Interface.AlacrityStart = 0

Interface.CurrentSpell = {}

Interface.Latency = {}
Interface.LatencyDelta = 0

Interface.BlockThisPaperdoll = {}

Interface.Clock = {}
Interface.Clock.DD = 0
Interface.Clock.MM = 0
Interface.Clock.YYYY = 0
Interface.Clock.Timestamp = 0
Interface.Clock.h = 0
Interface.Clock.m = 0
Interface.Clock.s = 0

Interface.LastTarget = 0
Interface.LastSpell = 0
Interface.LastSpecialMove = 0

Interface.IsFighting = false
Interface.IsFightingLastTime = 0
Interface.CanLogout = 0

Interface.MenuBar = nil
Interface.PetControlsBar = nil
Interface.MountBlockbar = nil
Interface.FirstImprovement = nil
Interface.InitialPositions = nil

Interface.NewPlayerInventoryToggled = false
Interface.NewPlayerPaperdollToggled = false
Interface.NewPlayerMapToggled = false
Interface.NewPlayerWarToggled = false

Interface.LastSpecialMoveTime = 0

Interface.SkillsCooldown = {}
Interface.SpellsCooldown = {}
Interface.SpecialsCooldown = {}
Interface.VirtuesCooldown = {}

Interface.ArteReceived = 0
Interface.ResReceived = 0
Interface.AirReceived = 0
Interface.SeedsReceived = 0
Interface.TokensReceived = 0
Interface.MasteriesReceived = 0

Interface.PaperdollOpen = true
Interface.BackpackOpen = true
Interface.MapVisible = true

Interface.TrapBoxID = 0
Interface.LootBoxID = 0

Interface.MobileArrowOver = 0

WindowUtils.ToggleAlpha = false
WindowUtils.ToggleScale = false

Interface.ForceEnchant = 0
Interface.ForceAnimal = 0
Interface.ForceSpellTrigger = 0
Interface.ForcePolymorph = 0
Interface.ForceFamiliar = 0
Interface.ForceTraining = 0
Interface.ForceTracking = 0

Interface.IsPlayerDead = false

Interface.PurpleButtonItems = 
{ 
	[3617] = { Tid = 1071289 }; -- Bandage
	[9900] = { Tid = 1029900 }; -- bolas
}

Interface.SupportedMods = 
{
	["EA_ContextMenu"] = true;
	["UO_ChatWindow"] = true;
	["GlobalVariables"] = true;
	["CraftingInfoData"] = true;
}

Interface.BackPackItems = {}

Interface.SOSWaypoints = {}
Interface.TmapWaypoints = {}

Interface.AccountFeatures = 
{
	[0] = "None",
	[1] = "The_Second_Age",
	[2] = "Renaissance",
	[4] = "Third_Dawn",
	[8] = "Lord_Blackthorn_Return",
	[16] = "Age_of_Shadows",
	[32] = "6th_Character_Slot",
	[64] = "Samurai_Empire",
	[128] = "Mondains_Legacy",
	[256] = "8th_Anniversary", --_25/09/2005 package
	[512] = "9th_Anniversary", --_31/06/2006 package
	[1024] = "10th_Anniversary", -- 25/09/2007 package
	[2048] = "Increased_Storage", -- house/bank storage increase
	[4096] = "7th_Character_Slot",
	[8192] = "Roleplay_Faces",
	[16384] = "Trial_Account",
	[32768] = "Paid_Account",
	[65536] = "Stygian_Abyss",
	[131072] = "High_Seas",
	[262144] = "Gothic_Addon",
	[524288] = "Rustic_Addon",
	[1048576] = "Jungle", --_Time_of Legend feature
	[2097152] = "Shadowguard", --_Time of Legend feature
	[4194304] = "Time_of_Legend", -- Time of Legend main flag
	[8388608] = "Endless_Journey",
}

Interface.ShardsList = 
{
	[0] = L"Atlantic",
	[1] = L"Lake Superior",
	[2] = L"Pacific",
	[3] = L"Great Lakes",

	[5] = L"Baja",
	[6] = L"Chesapeake",
	[7] = L"Napa Valley",
	[8] = L"Catskills",
	[9] = L"Sonoma",
	[10] = L"Lake Austin",

	[12] = L"Siege Perilous",

	[14] = L"Legends",

	[16] = L"Sakura",

	[18] = L"Mugen",
	[19] = L"Oceania",
	[20] = L"Yamato",
	[21] = L"Asuka",
	[22] = L"Wakoku",
	[23] = L"Hokuto",
	[24] = L"Europa",
	[25] = L"Drachenfels",
	[26] = L"Formosa",
	[27] = L"Izumo",
	[28] = L"Arirang",
	[29] = L"Balhae",

	[31] = L"Mizuho",

	[45] = L"Origin",

	[54] = L"Test Center 1",
}

Interface.SiegeId = 12

Interface.SiegeRules = false

Interface.CurrentItemPropertiesId = 0

Interface.BardMastery = false

Interface.ActiveSlayers = {}
Interface.ActiveSuperSlayers = {}
Interface.ActiveOppositeSlayers = {}

Interface.PlaySoundDelta = 0
Interface.ECPlaySoundBuffer = {}
Interface.MusLenght = 0
Interface.Loops = 0
Interface.GetMusLenght = false

Interface.IsFighting = false
Interface.IsFightingLastTime = 0

Interface.WarSongs = 13
Interface.SeaWarSongs = 7
Interface.TavernSongs = 7
Interface.DeadSongs = 2
Interface.WildSongs = 10
Interface.ChampionSongs = 6

Interface.ServerLine = false

Interface.DragWindows = {}
Interface.IsDraggingAWindow = false

Interface.LastBoatDirectionBackup = nil
Interface.LastBoatDirection = nil
Interface.BoatSpeed = 0
Interface.IsPilotingAShip = false

Interface.BuoysWindowVisible = false

Interface.UnequipItems = {}

Interface.LoadingFailSafeTimeout = 10

Interface.ActiveMobilesOnScreen = {}
Interface.ActiveItemsOnScreen = {}
Interface.ActiveItemsTimeFromLastUpdate = 10

Interface.InsuranceCost = 0
Interface.PayableDeaths = 0

Interface.WindowDataForceRefreshRate = 60

Interface.KnownChangelings = {
	Changelings = {},
	Irks = {},
	Guiles = {},
	Spites = {},
	Travestys = {}
}

Interface.Settings = {}

-------------------------------------------------------------------------------
--
-- SETTINGS DEFAULT VALUES
--
-------------------------------------------------------------------------------

----------------------------------------------------------------
-- SOUND:
----------------------------------------------------------------

Interface.ECSound = {enabled = true, volume = 0.5}
Interface.ECMusic = {enabled = true, volume = 0.5}
Interface.HeartBeat = {enabled = true, volume = 0.5}

----------------------------------------------------------------
-- CONTAINERS: (containers tab)
----------------------------------------------------------------
Interface.Settings.ToggleContentsInfo = true
Interface.Settings.playerVendorView = "Freeform"
Interface.Settings.SaveScrollPos = true
Interface.Settings.GridLegacy = true
Interface.Settings.ShowContainerType = true
Interface.Settings.EnableContainerGrid = true
Interface.Settings.ExtraBrightContainers = false
Interface.Settings.AlternateGrid = false
Interface.Settings.AutoLootMaxWeight = 50

Interface.Settings.BaseGridColor = { r = 255, g = 255, b = 255 }
Interface.Settings.AlternateBackpack = { r = 80, g = 80, b = 80 }

Interface.Settings.CascadeType = 0

-- CASCADE TYPES:

--  __
-- |
-- |  == 0

-- __
--   |
--   |  == 1

-- |
-- |___  == 2

--	  |
-- ___|  == 3

-- RANDOM = 4

----------------------------------------------------------------
-- MAP: (options tab)
----------------------------------------------------------------

Interface.Settings.EnableCartographer = false

Interface.Settings.MapWindow_WPFilters = ""
Interface.Settings.AtlasWindow_WPFilters = ""

----------------------------------------------------------------
-- HEALTHBARS/STATUS: (healthbars tab)

-- STATUS WINDOW STYLES:
-- 0: classic
-- 1: advanced
-- 2: diablo 2
-- 3: overhead
-- 4: party healthbar
----------------------------------------------------------------

Interface.Settings.StatusWindowStyle = 1

-- always show health, stamina, mana
Interface.Settings.StatusButtons = true
Interface.Settings.AuraEnabled = true

Interface.Settings.EnableMobileArrow = true
Interface.Settings.EnableContextButtons = true

Interface.Settings.LegacyCloseStyle = false

Interface.Settings.DisableButtons = false
Interface.Settings.HealthbarsSmallButtons = false
Interface.Settings.AutoPinHonored = false

Interface.Settings.HoverbarsActive = false
Interface.Settings.BossbarsActive = true

Interface.Settings.MoSUpdateLimit = 5

Interface.RedDef = 1
Interface.Settings.RedButton1 = 29
Interface.Settings.RedButton2 = 59
Interface.Settings.RedButton3 = 0

Interface.GreenDef = 1
Interface.Settings.GreenButton1 = 25
Interface.Settings.GreenButton2 = 17
Interface.Settings.GreenButton3 = 0

Interface.BlueDef = 1
Interface.Settings.BlueButton1 = 44
Interface.Settings.BlueButton2 = 6
Interface.Settings.BlueButton3 = 0

Interface.Settings.GoldCount = 8
Interface.GoldDef = 1
Interface.Settings.GoldButton1 = 2 -- animal lore
Interface.Settings.GoldButton2 = 35 -- animal taming
Interface.Settings.GoldButton3 = 15 -- disco
Interface.Settings.GoldButton4 = 9 -- peacemaking
Interface.Settings.GoldButton5 = 22 -- provocation
Interface.Settings.GoldButton6 = 33 -- stealing
Interface.Settings.GoldButton7 = 28 -- snooping
Interface.Settings.GoldButton8 = 6 -- begging

Interface.Settings.PurpleCount = 2
Interface.PurpleDef = 1
Interface.Settings.PurpleButton1 = 3617 -- bandages
Interface.Settings.PurpleButton2 = 9900 -- bolas

Interface.Settings.MoSFilter = {}
Interface.Settings.MoSFilter[1] = false
Interface.Settings.MoSFilter[2] = true
Interface.Settings.MoSFilter[3] = true
Interface.Settings.MoSFilter[4] = true
Interface.Settings.MoSFilter[5] = true
Interface.Settings.MoSFilter[6] = true
Interface.Settings.MoSFilter[7] = true
Interface.Settings.MoSFilter[8] = false
Interface.Settings.MoSFilter[9] = false
Interface.Settings.MoSFilter[10] = false

----------------------------------------------------------------
-- ITEM PROPERTIES: (options tab)
----------------------------------------------------------------
Interface.Settings.NewItemProperties = true
Interface.Settings.NewItemPropertiesScale = SystemData.Settings.Interface.customUiScale
Interface.Settings.ShowCaps = true
Interface.Settings.IntensInfo = false
Interface.Settings.IntensInfoColorID = 4

Interface.Settings.UnravelForge = 2 -- ItemPropertiesInfo.FORGE_Queen
Interface.Settings.UnravelChar = 1 -- ItemPropertiesInfo.RACE_Gargoyle

Interface.Settings.Props_TITLE_COLOR  =  { r = 192, g = 192, b = 192 }
Interface.Settings.Props_MAGICPROP_COLOR  =  { r = 134, g = 129, b = 205 }
Interface.Settings.Props_ENGRAVE_COLOR  =  { r = 255, g = 204, b = 51 }
Interface.Settings.Props_ARTIFACT_COLOR  =  { r = 184, g = 72, b = 0 }
Interface.Settings.Props_SET_COLOR  =  { r = 155, g = 50, b = 255 }
Interface.Settings.Props_RESIDUE_COLOR  = { r = 230, g = 0, b = 0 }
Interface.Settings.Props_ESSENCE_COLOR  = { r = 0, g = 230, b = 0 }
Interface.Settings.Props_RELIC_COLOR  = { r = 100, g = 217, b = 255 }
Interface.Settings.Props_LOSTITEM_COLOR  =  { r = 146, g = 245, b = 153 } 

Interface.Settings.Props_BODY_COLOR  =  { r = 255, g = 255, b = 255 }

----------------------------------------------------------------
-- NEW CHAT: (new chat tab)
----------------------------------------------------------------
Interface.Settings.chat_useNewChat = true -- Internal, no toggle.
Interface.Settings.chat_firstStart = true

Interface.Settings.chat_BaseAlpha = 0.7
Interface.Settings.chat_autoHide = false
Interface.Settings.chat_fadeTime = 5
Interface.Settings.chat_showMouseOver = true
Interface.Settings.chat_textFade = false
Interface.Settings.chat_timeStamp = false
Interface.Settings.chat_locked = false
Interface.Settings.chat_lockChatLine = false
Interface.Settings.chat_lockChatLineDown = false
Interface.Settings.chat_minTotDmg = 200
Interface.Settings.chat_chatLog = false
Interface.Settings.chat_showSpells = false
Interface.Settings.chat_showSpellsCasting = false
Interface.Settings.chat_showPerfection = false
Interface.Settings.chat_showMultiple = true
Interface.Settings.chat_hideTag = false
Interface.Settings.chat_messagesBuffCap = 50

Interface.Settings.chat_SavedFilter = {}
Interface.Settings.chat_SavedFilter[1]  = false
Interface.Settings.chat_SavedFilter[2]  = false
Interface.Settings.chat_SavedFilter[3]  = false
Interface.Settings.chat_SavedFilter[4]  = false
Interface.Settings.chat_SavedFilter[5]  = false
Interface.Settings.chat_SavedFilter[6]  = false
Interface.Settings.chat_SavedFilter[7]  = false
Interface.Settings.chat_SavedFilter[8]  = false
Interface.Settings.chat_SavedFilter[9]  = false
Interface.Settings.chat_SavedFilter[10] = false

Interface.Settings.chat_contactStatusChangeMessage = true

----------------------------------------------------------------
-- OVERHEAD TEXT: (overhead text tab)
----------------------------------------------------------------

Interface.Settings.clickableNames = true
-- show names:
-- show corpse names
-- Interface.Settings.clickableNames
-- overhead chat
-- overhead chat fade
Interface.Settings.DisableSpells = false
Interface.Settings.ShowSpellName = false
Interface.Settings.noPoisonOthers = true
Interface.Settings.OverhedTextSize = InterfaceCore.scale
-- chat font
-- name font
-- spell font
-- damage font
-- spells colors
-- damage colors
-- positive/negative messages colors		

Interface.Settings.OverHeadError  =  { r = 255, g = 0, b = 0 }
Interface.Settings.SpecialColor  =  { r = 64, g = 164, b = 254 }

Interface.Settings.PHYSICAL  =  { r = 168, g = 168, b = 168 }
Interface.Settings.FIRE  =  { r = 245, g = 155, b = 33 }
Interface.Settings.COLD  =  { r = 28, g = 111, b = 234 }
Interface.Settings.POISON  =  { r = 63, g = 199, b = 73 }
Interface.Settings.ENERGY  =  { r = 192, g = 69, b = 192 }
Interface.Settings.Chaos  =  { r = 251, g = 30, b = 251 }

Interface.Settings.Heal  =  { r = 255, g = 215, b = 0 }
Interface.Settings.Curse  =  { r = 162, g = 153, b = 185 }
Interface.Settings.Paralyze  =  { r = 194, g = 67, b = 99 }
Interface.Settings.Neutral  =  { r = 255, g = 255, b = 255 }

Interface.Settings.Green  =  { r = 16, g = 184, b = 0 }

Interface.Settings.YOUGETAMAGE_COLOR  =  { r = 255, g = 0, b = 0 }
Interface.Settings.PETGETDAMAGE_COLOR  =  { r = 255, g = 80, b = 255 }
Interface.Settings.OTHERGETDAMAGE_COLOR  =  { r = 255, g = 255, b = 0 }
----------------------------------------------------------------
-- MISC: (options tab)
----------------------------------------------------------------

Interface.Settings.BlockOthersPaperdoll = false
Interface.Settings.ShowPaperdollIcons = false
Interface.Settings.PaperdollFullSlotDurability = true
Interface.Settings.EnablePaperdollBG = true
Interface.Settings.EnableSnapping = true
Interface.Settings.NewAnimalLore = true
Interface.Settings.MoongateGump = true	
Interface.Settings.AutoCloseVetRew = false
Interface.Settings.AutoAcceptHonor = false
Interface.Settings.DisableFelWarning = false
Interface.Settings.DisableButtonsWhileCast = true
Interface.Settings.MouseOverTarget = false
Interface.Settings.noWarOnPets = false
Interface.Settings.noWarOnParty = false
Interface.Settings.noWarOnFriendly = false
Interface.Settings.ClockEnabled = false
Interface.Settings.CastBar = true	
Interface.Settings.SmartBoatCommands = true
Interface.Settings.ToggleBookLog = false
Interface.Settings.ToggleBloodOath = true
Interface.Settings.EnableAutoIgnoreCorpses = true
Interface.Settings.ScavengeAll = false
Interface.Settings.AutoTargetBagOfSending = true
Interface.Settings.WarShield = true
Interface.Settings.AllowTrades = true
Interface.Settings.AllowFriendRequests = true
Interface.Settings.CST_LowHPPerc = 35
Interface.Settings.CST_LowHPPercDisabled = false
Interface.Settings.CST_LowPETHPPerc = 35
Interface.Settings.CST_LowPETHPPercDisabled = false
Interface.Settings.CST_EnableIgnoreSummons = true
Interface.Settings.CST_VvVAlert = true
Interface.Settings.MTP_Current = 1
Interface.Settings.MTP_CurrentBorder = 1
Interface.Settings.AnimalLoreBADPerc = 25
Interface.Settings.AnimalLoreVERYBADPerc = 50
Interface.Settings.AnimalLoreKhyrosRating = true
Interface.Settings.TmapPinPointLines = true
Interface.Settings.TmapDigPlayerLocation = false

Interface.Settings.objectHandleFilter = SystemData.Settings.ObjectHandleFilter.eDynamicFilter

Interface.Settings.DarkItemLabel  =		{ r = 245, g = 229, b = 0 }
Interface.Settings.LightItemLabel =		{ r = 255, g = 255, b = 255 }
Interface.Settings.HB_Plain =			{ r = 255, g = 255, b = 255 }
Interface.Settings.HB_Control  =		{ r = 255, g = 0, b = 0 }
Interface.Settings.HB_Alt =				{ r = 0, g = 255, b = 0 }
Interface.Settings.HB_Shift =			{ r = 0, g = 92, b = 232 }
Interface.Settings.HB_ControlAlt  =		{ r = 255, g = 255, b = 0 }
Interface.Settings.HB_AltShift  =		{ r = 0, g = 255, b = 255 }
Interface.Settings.HB_ControlShift  =	{ r = 255, g = 0, b = 255 }
Interface.Settings.HB_ControlAltShift =	{ r = 179, g = 106, b = 227 }
Interface.Settings.HB_CountdownTimer  =	{ r = 255, g = 0, b = 0 }

SystemData.Hotbar.TargetType.TARGETTYPE_MOUSEOVER = 5

Interface.Settings.TargetTypeTintColors = {
	[SystemData.Hotbar.TargetType.TARGETTYPE_NONE] =		{ r = 125,	g = 125,	b = 125	},
	[SystemData.Hotbar.TargetType.TARGETTYPE_SELF] =		{ r = 0,	g = 138,	b = 255	},
	[SystemData.Hotbar.TargetType.TARGETTYPE_CURRENT] =		{ r = 255,	g = 0,		b = 0	},
	[SystemData.Hotbar.TargetType.TARGETTYPE_CURSOR] =		{ r = 91,	g = 204,	b = 91	},
	[SystemData.Hotbar.TargetType.TARGETTYPE_OBJECT_ID] =	{ r = 200,	g = 200,	b = 200	},
	[SystemData.Hotbar.TargetType.TARGETTYPE_MOUSEOVER] =	{ r = 242,	g = 125,	b = 47	}
}
-- block war on pets
-- block war on party
-- block war on guild


Interface.AdvancedCrafting = false

Interface.Contacts = {}

Interface.OnKeyEnterCallback = {}
Interface.OnKeyEscapeCallback = {}

Interface.CorpseLocalization =
{
	L"屍體",
	L"의 시체",
	--L"の死体",
	L"a corpse of ",
	L" corpse",
}

----------------------------------------------------------------
--
-- INTERFACE STARTUP
--
----------------------------------------------------------------
function Interface.CreatePlayWindowSet()

	if not DebugWindow.logging then
		DebugWindow.ToggleLogging()
	end

	pcall(Interface.CreateOverrides)

	CreateWindow("Loading", Interface.DebugMode == false)

	-- Load the proper font XML definitions based on the language
	if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_JPN) then
		LoadResources( "./UserInterface/"..SystemData.Settings.Interface.customUiName, "FontsJPN.xml", "Fonts/FontsJPN.xml" )
	elseif (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_CHINESE_TRADITIONAL) then
		LoadResources( "./UserInterface/"..SystemData.Settings.Interface.customUiName, "FontsCHT.xml", "Fonts/FontsCHT.xml" )	
	elseif (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_KOR) then
		LoadResources( "./UserInterface/"..SystemData.Settings.Interface.customUiName, "FontsKOR.xml", "Fonts/FontsKOR.xml" )	
	else
		LoadResources( "./UserInterface/"..SystemData.Settings.Interface.customUiName, "FontsENU.xml", "Fonts/FontsENU.xml" )
		SystemData.Settings.Language.englishNames = false
		UserSettingsChanged()
	end
	SetLoadLuaDebugLibrary( true )

	Interface.PlayerID =								Interface.LoadSetting("PlayerID", WindowData.PlayerStatus.PlayerId, 0)

	pcall(Interface.ClockUpdater, 0)	
	pcall(Interface.LoadVariables)	

	-- is this the first time this character is loaded?
	if (not Interface.FirstImprovement) then

		-- make sure the UI scale is correct
		if SystemData.Settings.Interface.customUiScale ~= 0.85 then

			-- fix the UI scale
			SystemData.Settings.Interface.customUiScale = 0.85
			UserSettingsChanged()

			-- reload the UI
			Interface.ReloadUI()
			return
		end
	end

	pcall(Interface.CreateWindows)	
	pcall(Interface.RegisterEvents)	
	pcall(Interface.InitializeWindows)		
	
	-- clear old unused settings from previous versions
	Interface.ClearOldSettings()

	-- verify the active account features
	Interface.CheckAccountFeatures()

	-- setting the legacy container flag so we can see the legacy style
	Interface.LegacyContBackup = SystemData.Settings.Interface.LegacyContainers
    SystemData.Settings.Interface.LegacyContainers = true

	-- disable the legacy targeting (useless, player can simply use the target cursor on everything instead)
	SystemData.Settings.GameOptions.legacyTargeting = false
	UserSettingsChanged()

	-- mark the interface as ready to start so that the update cycle can begin
	Interface.ReadyToStart = true
end

function Interface.CheckAccountFeatures()

	-- initialize the active account features table
	Interface.ActiveAccountFeatures = {}

	-- scan all the possible account features
	for flag, name in pairsByKeys(Interface.AccountFeatures) do

		-- check if the feature is active
		Interface.ActiveAccountFeatures[name] = HasEntitlement(flag)
	end
end

Interface.RegisteredEvents = {}
function Interface.RegisterEvents()
	WindowRegisterEventHandler("Root", SystemData.Events.BUG_REPORT_SCREEN, "Interface.InitBugReport")	
	WindowRegisterEventHandler("Root", SystemData.Events.CHARACTER_SETTINGS_UPDATED, "Interface.RetrieveCharacterSettings")
	WindowRegisterEventHandler("Root", SystemData.Events.WINDOWS_SETTINGS_UPDATED, "Interface.UpdateWindowsSettings")
	WindowRegisterEventHandler("Root", SystemData.Events.OPEN_CRIMINAL_NOTIFICATION_GUMP, "Interface.ShowCriminalNotificationGump")
	WindowRegisterEventHandler("Root", SystemData.Events.SHOW_PARTY_INVITE, "Interface.ShowPartyInvite")
	
	WindowRegisterEventHandler("Root", SystemData.Events.ITEM_USE_REQUEST, "Interface.ItemUseRequest")	
	WindowRegisterEventHandler("Root", SystemData.Events.SPELL_USE_REQUEST, "Interface.SpellUseRequest")
	WindowRegisterEventHandler("Root", SystemData.Events.SKILL_USE_REQUEST, "Interface.SkillUseRequest")
	--WindowRegisterEventHandler("Root", SystemData.Events.Virtue_USE_REQUEST, "Interface.VirtueUseRequest")
	
	WindowRegisterEventHandler( "Root", SystemData.Events.TEXT_ARRIVED,      "Interface.NewChatText") 
	
	WindowRegisterEventHandler("Root", SystemData.Events.DEBUGPRINT_TO_CONSOLE, "Interface.OnDebugPrint")
	WindowRegisterEventHandler("Root", SystemData.Events.TOGGLE_BACKPACK_WINDOW, "Actions.ToggleInventoryWindow")
	WindowRegisterEventHandler("Root", SystemData.Events.TOGGLE_PAPERDOLL_CHARACTER_WINDOW, "Actions.TogglePaperdollWindow")
	WindowRegisterEventHandler("Root", SystemData.Events.TOGGLE_GUILD_WINDOW, "Actions.ToggleGuildWindow")
	WindowRegisterEventHandler("Root", SystemData.Events.TOGGLE_SKILLS_WINDOW, "Actions.ToggleSkillsWindow")
	WindowRegisterEventHandler("Root", SystemData.Events.TOGGLE_VIRTUES_WINDOW, "Actions.ToggleVirtuesWindow")
	WindowRegisterEventHandler("Root", SystemData.Events.TOGGLE_QUEST_LOG_WINDOW, "Actions.ToggleQuestWindow")
	WindowRegisterEventHandler("Root", SystemData.Events.TOGGLE_HELP_WINDOW, "Actions.ToggleHelpWindow")
	WindowRegisterEventHandler("Root", SystemData.Events.TOGGLE_WORLD_MAP_WINDOW, "Actions.ToggleMapWindow")
	WindowRegisterEventHandler("Root", SystemData.Events.ESCAPE_KEY_PROCESSED, "Interface.EscapePressed")
	--WindowRegisterEventHandler("Root", SystemData.Events.LOG_OUT, "Interface.LogOut")

	WindowRegisterEventHandler("Root", SystemData.Events.GHAT_PRESENCE_UPDATE, "Interface.ContactsStatusUpdate")

	WindowRegisterEventHandler("Root", SystemData.Events.CURRENT_CHANNEL_UPDATED, "NewChatWindow.UpdateCurrentChannel")
    WindowRegisterEventHandler("Root", SystemData.Events.GHAT_MY_PRESENCE_UPDATE, "NewChatWindow.OnGChatPresenceUpdate")
    WindowRegisterEventHandler("Root", SystemData.Events.GHAT_ROSTER_UPDATE, "NewChatWindow.OnGChatRosterUpdate") 

	WindowRegisterEventHandler("Root", SystemData.Events.BEGIN_DRAG_HEALTHBAR_WINDOW, "Interface.BeginDragHealthbarFromWorld")
	WindowRegisterEventHandler("Root", SystemData.Events.END_DRAG_HEALTHBAR_WINDOW, "Interface.EndDragHealthbarFromWorld")
	WindowRegisterEventHandler("Root", WindowData.MobileStatus.Event, "Interface.UpdateMobileStatus")
	WindowRegisterEventHandler("Root", WindowData.MobileName.Event, "Interface.UpdateMobileName")
	WindowRegisterEventHandler("Root", WindowData.HealthBarColor.Event, "Interface.UpdateMobileStatusColor")
	WindowRegisterEventHandler("Root", SystemData.Events.ENABLE_HEALTHBAR_WINDOW, "Interface.UpdateHealthbarAvailability")
	WindowRegisterEventHandler("Root", SystemData.Events.DISABLE_HEALTHBAR_WINDOW, "Interface.UpdateHealthbarAvailability")

	WindowRegisterEventHandler("Root", WindowData.Paperdoll.Event, "Interface.HandleUpdatePaperdollEvent")
	WindowRegisterEventHandler("Root", SystemData.Events.UPDATE_CHAR_PROFILE, "Interface.UpdateCharProfile")
	WindowRegisterEventHandler("Root", SystemData.Events.UPDATE_PLAYER_STATUS, "Interface.UpdatePlayerStatus")

	WindowRegisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT, "Interface.RequestTargetInfoReceived")
	WindowRegisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_SERVER, "Interface.RequestServerTargetInfoReceived")

	WindowRegisterEventHandler("Root", SystemData.Events.UO_STORE_REQUEST, "Interface.StoreRequest")

	WindowRegisterEventHandler("Root", WindowData.PartyMember.Event, "Interface.HandlePartyMemberUpdate")

	WindowRegisterEventHandler("Root", WindowData.Pets.Event, "Interface.HandlePetsUpdate")

	WindowRegisterEventHandler("Root", WindowData.CurrentTarget.Event, "Interface.UpdateTarget")
	WindowRegisterEventHandler("Root", WindowData.ObjectInfo.Event, "Interface.UpdateObjectInfo")

	WindowRegisterEventHandler("Root", SystemData.Events.RELOAD_INTERFACE, "Interface.EndReloadUI")

	WindowRegisterEventHandler("Root", SystemData.Events.BOOK_PAGE_DATA_RECIEVED, "Interface.BookPageReceived")

	-- attach the key record events
	WindowRegisterEventHandler("Root", SystemData.Events.INTERFACE_KEY_RECORDED, "Interface.KeyRecorded" )
	WindowRegisterEventHandler("Root", SystemData.Events.INTERFACE_KEY_CANCEL_RECORD, "MacroWindow.KeyCancelRecord" )
	WindowRegisterEventHandler("Root", SystemData.Events.INTERFACE_RECORD_KEY , "SettingsWindow.StartKeyRecording")

	WindowRegisterEventHandler("Root", WindowData.PlayerEquipmentSlot.Event, "EquipmentData.UpdateWeaponAbilities")
	WindowRegisterEventHandler("Root", SystemData.Events.ABILITY_DISPLAY_ACTIVE, "Interface.ActivateAbility")
	WindowRegisterEventHandler("Root", SystemData.Events.ABILITY_RESET, "Interface.ResetAbility")

	WindowRegisterEventHandler("Root", WindowData.WaypointList.Event, "Interface.UpdateWaypoints")
	WindowRegisterEventHandler("Root", WindowData.Radar.Event, "Interface.UpdateMap")

	WindowRegisterEventHandler("Root", SystemData.Events.CREATE_OBJECT_HANDLES, "ObjectHandleWindow.CreateObjectHandles")
	WindowRegisterEventHandler("Root", SystemData.Events.DESTROY_OBJECT_HANDLES, "ObjectHandleWindow.DestroyObjectHandles")

	-- get the player status
	Interface.GetPlayerStatusData()
	Interface.GetMobileNameData(GetPlayerID())
	Interface.GetPaperdollData(GetPlayerID())
	--Interface.GetMobileData(GetPlayerID())

	-- register the party status
	RegisterWindowData(WindowData.PartyMember.Type, 0)

	-- register pet status
	RegisterWindowData(WindowData.Pets.Type, 0)	

	-- register the player location tracker
	RegisterWindowData(WindowData.PlayerLocation.Type, 0)

	-- register the current target
	RegisterWindowData(WindowData.CurrentTarget.Type, 0)

	-- register the mouse over properties
	RegisterWindowData(WindowData.ItemProperties.Type, 0)

	-- register the skills list
	RegisterWindowData(WindowData.SkillList.Type, 0)

	-- register the buff/debuff
	RegisterWindowData(WindowData.BuffDebuff.Type, 0)

	-- register map data
	RegisterWindowData(WindowData.Radar.Type, 0)

	-- register waypoint data
    RegisterWindowData(WindowData.WaypointDisplay.Type, 0)

	-- register waypoints list
    RegisterWindowData(WindowData.WaypointList.Type, 0)

	-- flag the mastery to be checked
	Spellbook.MasteryChanged = true

	-- force to scan the pets
	Interface.HandlePetsUpdate()

	-- this part is for when you reload the UI so that you'll get the target window with the right target instead of nothing and a mobile with a circle around it...
	Interface.ExecuteWhenAvailable(
	{
		name = "getReloadTarget",
		check = function() return Interface.started end, 
		callback = function() if WindowData.CurrentTarget and IsValidID(WindowData.CurrentTarget.TargetId) then BroadcastEvent(WindowData.CurrentTarget.Event) TargetWindow.UpdateTarget() end end, 
		removeOnComplete = true,
		delay = Interface.TimeSinceLogin + 2,
		maxTime = math.huge
	})

	UserActionMacroUpdateBinding(SystemData.MacroSystem.STATIC_MACRO_ID, MacroWindow.GetMacroId(L"MountBlockbarMacro"), L"")
end

function Interface.ContactsStatusUpdate()

	-- make sure the UI is started
	if not Interface.started then
		return
	end

	-- scan the contacts list
	for i = 1, WindowData.GChatCount do		

		-- contact ID
		local currentFriend = "friend_"..tostring(i)		
	
		-- contact online status
		local friendPresence = WindowData.GChatPresenceList[i]			

		-- contact name
		local friendName = towstring(WindowData.GChatNameList[i])

		-- was this contact already in the contacts list?
		if Interface.Contacts[currentFriend] then

			-- does the user want to get a message when a contact status change between online and offline?
			if Interface.Settings.chat_contactStatusChangeMessage then

				-- is the online status changed for this contact?
				if Interface.Contacts[currentFriend].status ~= friendPresence then

					-- initialize the contact text status to online
					local textStatus = GetStringFromTid(1063015) -- online

					-- change the text status to offline (if the contact is offline)
					if friendPresence == 0 then
						textStatus = wstring.upper(GetStringFromTid(1070798)) -- offline
					end

					-- send a chat message informing about the change of status
					ChatPrint(ReplaceTokens(GetStringFromTid(320), {friendName, textStatus}), SystemData.ChatLogFilters.CUSTOM)
				end
			end

			-- update the friend status
			Interface.Contacts[currentFriend].status = friendPresence

		else -- add to the contact list
			Interface.Contacts[currentFriend] = {status = friendPresence, name = friendName}
		end
	end

	NewChatWindow.UpdateFriendPresence()
end

function Interface.LogOut()

	-- set the chat presence offline
	if WindowData.GChatMyPresence ~= NewChatWindow.GC_SHOW_UNAVAILABLE then
		WindowData.GChatMyPresence = NewChatWindow.GC_SHOW_UNAVAILABLE

		BroadcastEvent( SystemData.Events.TOGGLE_GLOBAL_CHAT_PRESENCE )
	end
end

function Interface.LoadVariables()
	--Builds the data for player
	UOBuildTableFromCSV("Data/GameData/playerstats.csv", "PlayerStatsDataCSV")
	UOBuildTableFromCSV("Data/GameData/itemprop.csv", "PlayerItemPropCSV")	
	UOBuildTableFromCSV("Data/GameData/weaponability.csv", "WeaponAbilityDataCSV")
	UOBuildTableFromCSV("data/gamedata/skilldata.csv","SkillsCSV")
	
	CreaturesDB.AllCreatures = table.fromCSV("./UserInterface/"..SystemData.Settings.Interface.customUiName .. "/Source/Data/CreaturesDB.csv") 
	CreaturesDB.FormatCreaturesArray()

	CreaturesDB.LoadTamables()
	CreaturesDB.LoadSummons()
	CreaturesDB.LoadNeutralAnimals()

	SkillsWindow.CreateSkillsTable()

	if Interface.DisableDiskIO  then
		Debug.Print("WARNING: disk I/O disabled, several functions will be unavailable!!!")
	end
	
	local unsupportedMods = ModulesGetData()
	for i, data in pairs(unsupportedMods) do
		
		-- the crafting info mod is only for debug purposes
		if not Interface.DebugMode and data.name == "CraftingInfoData" then
			continue
		end

		if	Interface.SupportedMods[data.name] then
			continue
		end

		ModuleSetEnabled(data.name, false)
	end

	-- the chat status is not saved, we get the current one
	if not Interface.ChatStatus then
		Interface.ChatStatus = WindowData.GChatMyPresence
	end
	
	Interface.ECSound.enabled = 						Interface.LoadSetting( "ECSound.enabled" , Interface.ECSound.enabled )
	Interface.ECMusic.enabled = 						Interface.LoadSetting( "ECMusic.enabled" , Interface.ECMusic.enabled ) and not SystemData.Settings.Sound.music.enabled
	Interface.HeartBeat.enabled =						Interface.LoadSetting( "HeartBeat.enabled" , Interface.HeartBeat.enabled )

	Interface.ECSound.volume =							Interface.LoadSetting( "ECSound.volume", Interface.ECSound.volume )
	Interface.ECMusic.volume =							Interface.LoadSetting( "ECMusic.volume", Interface.ECMusic.volume )
	Interface.HeartBeat.volume =						Interface.LoadSetting( "HeartBeat.volume", Interface.HeartBeat.volume )

	-- get the real setting value for EC Music
	Interface.ECMusic.trueValue = Interface.ECMusic.enabled

	-- read the file
	local musicDisabled = LoadTextFile("logs/disableMusicON.dat") ~= nil

	-- is the music disabled from EC Playsound?
	if musicDisabled then

		-- disable the music on the UI
		Interface.ECMusic.enabled = false
	end
	
	-- scan all settings
	for settingName, defaultValue in pairs(Interface.Settings) do
		
		-- is this setting a table with more than 3 elements (not a color?)
		if type(defaultValue) == "table" and #defaultValue > 3 and defaultValue.r == nil and defaultValue.g == nil and defaultValue.b == nil then
			
			-- load the setting for each record of the table
			for i, _ in pairsByIndex(defaultValue) do
				
				-- load setting
				Interface.Settings[settingName][i] = Interface.LoadSetting( settingName .. "." .. i, defaultValue[i] )
			end

		else -- load setting
			Interface.Settings[settingName] = Interface.LoadSetting( settingName, defaultValue )
		end
	end

	-- verify and fix the map filters
	Interface.Settings.MapWindow_WPFilters = MapCommon.VerifyFilterString(Interface.Settings.MapWindow_WPFilters)
	Interface.Settings.AtlasWindow_WPFilters = MapCommon.VerifyFilterString(Interface.Settings.AtlasWindow_WPFilters)

	-- load the map zoom
	MapCommon.ZoomCurrent = {}
	MapCommon.ZoomCurrent["MapWindow"] = Interface.LoadSetting("MapWindowZoom", 0)
	MapCommon.ZoomCurrent["AtlasWindow"] = Interface.LoadSetting("AtlasWindowZoom", 0)

	-- loading current windowed fullscreen state
	SettingsWindow.GetCurrentWindowedFullScreen()

	Interface.LastBoatDirection =						Interface.LoadSetting( "LastBoatDirection", Interface.LastBoatDirection, 0 )
	Interface.BoatSpeed =								Interface.LoadSetting( "BoatSpeed", Interface.BoatSpeed )
	Interface.BuoysWindowVisible =						Interface.LoadSetting( "BuoysWindowVisible" , Interface.BuoysWindowVisible )

	Interface.BackpackOpen =							Interface.LoadSetting( "BackpackOpen" , Interface.BackpackOpen )
	ContainerWindow.Locked =							Interface.LoadSetting( "LockedBackpack" , false )
	PaperdollWindow.Locked =							Interface.LoadSetting( "PdollWindowLocked", PaperdollWindow.Locked  )
	
	Interface.RedDef =									Interface.LoadSetting( "RedDef", Interface.RedDef )
	Interface.GreenDef =								Interface.LoadSetting( "GreenDef", Interface.GreenDef )
	Interface.BlueDef =									Interface.LoadSetting( "BlueDef", Interface.BlueDef )
	
	Interface.ArteReceived =							Interface.LoadSetting( "ArteReceived", Interface.ArteReceived )
	Interface.ResReceived =								Interface.LoadSetting( "ResReceived", Interface.ResReceived )
	Interface.AirReceived =								Interface.LoadSetting( "AirReceived", Interface.AirReceived )
	Interface.TokensReceived =							Interface.LoadSetting( "AirReceived", Interface.TokensReceived )
	Interface.SeedsReceived =							Interface.LoadSetting( "SeedsReceived", Interface.SeedsReceived )
	Interface.MasteriesReceived =						Interface.LoadSetting( "MasteriesReceived", Interface.MasteriesReceived )
	
	Interface.PaperdollOpen =							Interface.LoadSetting( "PaperdollOpen", Interface.PaperdollOpen )
	
	Interface.DefaultPet1 = 							Interface.LoadSetting( "DefaultPet1" , 0 )
	Interface.DefaultPet2 = 							Interface.LoadSetting( "DefaultPet2" , 0 )
	Interface.DefaultPet3 = 							Interface.LoadSetting( "DefaultPet3" , 0 )
	Interface.DefaultPet4 = 							Interface.LoadSetting( "DefaultPet4" , 0 )
	Interface.DefaultPet5 = 							Interface.LoadSetting( "DefaultPet5" , 0 )
	
	Interface.DefaultObject1 = 							Interface.LoadSetting( "DefaultObject1" , 0 )
	Interface.DefaultObject2 = 							Interface.LoadSetting( "DefaultObject2" , 0 )
	Interface.DefaultObject3 = 							Interface.LoadSetting( "DefaultObject3" , 0 )
	Interface.DefaultObject4 = 							Interface.LoadSetting( "DefaultObject4" , 0 )
	Interface.DefaultObject5 = 							Interface.LoadSetting( "DefaultObject5" , 0 )
	
	Interface.SnoopTarget = 							Interface.LoadSetting( "SnoopTarget" , 0 )
	
	Interface.AlacrityStart =							Interface.LoadSetting( "AlacrityStart" , 0 )
	
	Interface.ArteReceived =							Interface.LoadSetting( "ArteReceived" , Interface.ArteReceived )
	Interface.ResReceived =								Interface.LoadSetting( "ResReceived" , Interface.ResReceived )
	Interface.AirReceived =								Interface.LoadSetting( "AirReceived" , Interface.AirReceived )
	Interface.SeedsReceived =							Interface.LoadSetting( "SeedsReceived" , Interface.SeedsReceived )
	Interface.TokensReceived =							Interface.LoadSetting( "TokensReceived" , Interface.TokensReceived )
	
	Interface.TrapBoxID = 								Interface.LoadSetting( "TrapBoxID" , Interface.TrapBoxID )
	Interface.LootBoxID = 								Interface.LoadSetting( "LootBoxID" , Interface.LootBoxID )
	
	Interface.MenuBar =									Interface.LoadSetting( "MenuBar" , Interface.MenuBar, 0 )
	Interface.PetControlsBar =							Interface.LoadSetting( "PetControlsBar" , Interface.PetControlsBar, 0 )
	Interface.MountBlockbar =							Interface.LoadSetting( "MountBlockbar" , Interface.MountBlockbar, 0 )
	Interface.FirstImprovement =						Interface.LoadSetting( "FirstImprovement", Interface.FirstImprovement, true ) 
	Interface.InitialPositions =						Interface.LoadSetting( "InitialPositions", Interface.InitialPositions, true ) 
	
	Interface.NewPlayerInventoryToggled =				Interface.LoadSetting( "NewPlayerInventoryToggled", Interface.NewPlayerInventoryToggled ) 
	Interface.NewPlayerPaperdollToggled =				Interface.LoadSetting( "NewPlayerPaperdollToggled", Interface.NewPlayerPaperdollToggled ) 
	Interface.NewPlayerMapToggled =						Interface.LoadSetting( "NewPlayerMapToggled", Interface.NewPlayerMapToggled ) 
	Interface.NewPlayerWarToggled =						Interface.LoadSetting( "NewPlayerWarToggled", Interface.NewPlayerWarToggled ) 
		
	Interface.RedDef =									Interface.LoadSetting( "RedDef", Interface.RedDef )
	Interface.GreenDef =								Interface.LoadSetting( "GreenDef", Interface.GreenDef )
	Interface.BlueDef =									Interface.LoadSetting( "BlueDef", Interface.BlueDef )
	
	OverheadText.FontIndex =							Interface.LoadSetting("OverheadTextFontIndex", OverheadText.FontIndex)
	OverheadText.NameFontIndex =						Interface.LoadSetting("OverheadTextNameFontIndex", OverheadText.NameFontIndex)
	OverheadText.SpellsFontIndex =						Interface.LoadSetting("OverheadTextSpellsFontIndex", OverheadText.SpellsFontIndex)
	OverheadText.DamageFontIndex =						Interface.LoadSetting("OverheadTextDamageFontIndex", OverheadText.DamageFontIndex)
	
	Interface.ForceEnchant =							Interface.LoadSetting("ForceEnchant", Interface.ForceEnchant)
	Interface.ForceTraining =							Interface.LoadSetting("ForceTraining", Interface.ForceTraining)
	Interface.ForceAnimal =								Interface.LoadSetting("ForceAnimal", Interface.ForceAnimal)
	Interface.ForceSpellTrigger =						Interface.LoadSetting("ForceSpellTrigger", Interface.ForceSpellTrigger)
	Interface.ForcePolymorph =							Interface.LoadSetting("ForcePolymorph", Interface.ForcePolymorph)
	Interface.ForceFamiliar =							Interface.LoadSetting("ForceFamiliar", Interface.ForceFamiliar)
	Interface.ForceTracking =							Interface.LoadSetting("ForceTracking", Interface.ForceTracking)
		
	WindowUtils.ToggleScale =							Interface.LoadSetting("ToggleScale", WindowUtils.ToggleScale)
	WindowUtils.ToggleAlpha =							Interface.LoadSetting("ToggleAlpha", WindowUtils.ToggleAlpha)
	
	Interface.ServerLine =								Interface.LoadSetting("ServerLine", Interface.ServerLine) 

	Interface.CurrentHonor =							Interface.LoadSetting("CurrentHonor", Interface.CurrentHonor)
	
	if	Interface.ShardsList[UserData.Settings.Login.lastShardSelected] == L"Siege Perilous" or
		Interface.ShardsList[UserData.Settings.Login.lastShardSelected] == L"Mugen" 
	then
		Interface.SiegeRules = true		
	end
		
	GenericGump.ToolTips = {
		[1151954] = GenericGump.GetReforgingDesc(1); --Powerful Re-Forging
		[1151955] = GenericGump.GetReforgingDesc(2); --Structural Re-Forging
		[1151956] = GenericGump.GetReforgingDesc(3); --Fortified Re-Forging
		[1151957] = GenericGump.GetReforgingDesc(4); --Fundamental Re-Forging
		[1151958] = GenericGump.GetReforgingDesc(5); --Integral Re-Forging
		[1151961] = GenericGump.GetReforgingDesc(6); --Grand Artifice
		[1151962] = GenericGump.GetReforgingDesc(7); --Inspired Artifice
		[1151963] = GenericGump.GetReforgingDesc(8); --Exalted Artifice
		[1151964] = GenericGump.GetReforgingDesc(9); --Sublime Artifice
		[1151717] = GetStringFromTid(60); --Mighty / of Vitality
		[1151706] = GetStringFromTid(61); --Mystic / of Sorcery
		[1151707] = GetStringFromTid(62); --Animated / of Haste
		[1151708] = GetStringFromTid(63); --Arcane / of Wizardry
		[1151709] = GetStringFromTid(64); --Exquisite / of Quality
		[1151710] = GetStringFromTid(65); --Vampiric / of the Vampire
		[1151711] = GetStringFromTid(66); --Invigorating / of Restoration
		[1151712] = GetStringFromTid(67); --Fortified / of Defense
		[1151713] = GetStringFromTid(68); --Auspicious / of Fortune
		[1151714] = GetStringFromTid(69); --Charmed / of Alchemy
		[1151715] = GetStringFromTid(70); --Vicious / of Slaughter
		[1151716] = GetStringFromTid(71); --Towering / of Aegis
	}
	
	if not SystemData.Settings.Keybindings["CANCEL"]  or SystemData.Settings.Keybindings["CANCEL"] ~= L"Escape" then
		SystemData.Settings.Keybindings["CANCEL"] = L"Escape"
		BroadcastEvent( SystemData.Events.KEYBINDINGS_UPDATED )
	end

	-- add a secondary corpse filter type
	SystemData.Settings.ObjectHandleFilter.eCorpseFilterFixed = 7
	
	-- update the ID in the filters table
	SettingsWindow.ObjectHandles[2].id = SystemData.Settings.ObjectHandleFilter.eCorpseFilterFixed

	-- change the filter to the one we saved
	SystemData.Settings.GameOptions.objectHandleFilter = Interface.Settings.objectHandleFilter

	-- save the changes
	UserSettingsChanged()
end

function Interface.LoadPlayerVariablesMod()

	-- have the variable already being initialized?
	if Interface.PlayerVariablesInitialized then
		return
	end

	-- get the current shard name
	local shard = Interface.ShardsList[UserData.Settings.Login.lastShardSelected]

	-- get the current player ID
	local playerID = GetPlayerID()

	-- do we have a valid player ID?
	if not IsValidID(playerID) then

		-- throw an error
		Debug.Print("NO PLAYER ID!!!")
		return
	end

	-- remove the spaces from the shard name
	shard = wstring.gsub(shard, L" ", L"_")

	-- initialize the player variables file name
	local playerFileName = "PlayerVariables_" ..tostring(shard) .. "_" .. playerID

	-- create the player variables file
	Interface.CreatePlayerVariablesMod(playerFileName)

	-- load the player variables file
	ModuleLoad("./UserInterface/PlayerVariablesMods/" .. playerFileName .. ".mod", playerFileName, true)
	ModuleInitialize(playerFileName)

	-- scan active quests
	QuestLog.AutoScanLog()

	-- set the player variables as initialized (if they have been loaded correctly)
	Interface.PlayerVariablesInitialized = Interface.IsModEnabled(playerFileName)

	-- reset the mastery array if it exists but has no elements
	if Spellbook.MyMasteries and table.countElements(Spellbook.MyMasteries) <= 0 then
		Spellbook.MyMasteries = nil
	end

	-- get all the skills data
	for i, data in pairsByIndex(WindowData.SkillsCSV) do  
		RegisterWindowData(WindowData.SkillDynamicData.Type, data.ServerId)
	end

	-- flag that all the skills have been registered
	SkillsWindow.RegisterComplete = true
end

function Interface.CreateWindows()
	ActionsWindow.InitActionData()
	CreateWindow("ResizeWindow", true)
	CreateWindow("MainMenuWindow", false)
	CreateWindow("SettingsWindow", false)
	CreateWindow("CharacterSheet", false)
	CreateWindow("CharacterAbilities", false)
	CreateWindow("ItemProperties", false)
	CreateWindow("BugReportWindow", false)
	CreateWindow("SkillsWindow", false)
	CreateWindow("NewChatOptionsWindow", false)
	CreateWindow("NewChatWindow", false)

	-- is this the first time this character is loaded?
	if (not Interface.FirstImprovement) then

		-- first positioning of the game area
		local x, y = WindowGetDimensions("Root")
		WindowSetDimensions("ResizeWindow", x - 550, y - 300)
		ResizeWindow.OnResizeEnd()
		ResizeWindow.UpdateWindow()

		-- first chat positioning
		WindowClearAnchors("NewChatWindow")
		WindowAddAnchor("NewChatWindow", "bottomleft", "ResizeWindow", "bottomleft", 0, -40)
		WindowUtils.SaveWindowPosition("NewChatWindow", true)
	end

	Organizer.Initialize()
	CraftingInfo.Initialize()
	CreateWindow("TargetWindow", false)
	CreateWindow("ContextMenu", false)
	CreateWindow("ActionEditText", false)
	CreateWindow("ActionEditSlider", false)
	CreateWindow("ActionEditMacro", false)
	CreateWindow("ActionEditEquip", false)
	CreateWindow("ActionEditUnEquip", false)
	CreateWindow("ActionEditArmDisarm", false)
	CreateWindow("ActionEditTargetByResource", false)
	CreateWindow("ActionEditTargetByObjectId", false)
	CreateWindow("MapWindow", false)
	CreateWindow("AtlasWindow", false)
	CreateWindow("SkillsInfo", false)	
	CreateWindow("UserWaypointWindow", false)
	CreateWindow("OrganizerWindow", false)
	CreateWindow("ContainerSearchWindow", false)
	CreateWindow("RenameWindow", false)
	CreateWindow("ProfileWindow", false)
	CreateWindow("PropertiesInfoWindow", false)
	CreateWindow("CenterScreenText", true)
	CreateWindow("ClockWindow", Interface.Settings.ClockEnabled)
	CreateWindow("CastBarWindow", false)
	CreateWindow("DyeTubs", false)
	CreateWindow("CreditsWindow", false)
	CreateWindow("FindersKeepers", false)
	CreateWindow("ItemPreview", false)
	CreateWindow("BossBarWindow", true)

	DestroyWindow("DebugWindowOptions")
	DestroyWindow("DebugWindow")

	if Interface.DebugMode then
		CreateWindow("DebugWindow", true)

		WindowSetShowing("DebugWindow", true)
	end

	CreateWindow("CleanupBritanniaWindow", false)
	CreateWindow("BuoyToolWindow", Interface.BuoysWindowVisible)

	Interface.ExecuteWhenAvailable(
	{
		name = "InitializeMountList", 
		check = function() return Interface.PlayerVariablesInitialized end, 
		callback = function() CreateWindow("MountsListWindow", false) end, 
		removeOnComplete = true,
		maxTime = math.huge
	})
	
	DestroyWindow("DefaultTooltip")
	
	Interface.CreateTCTools()
	
	if (SystemData.Settings.Interface.showTipoftheDay) then
		CreateWindow( "TipoftheDayWindow", true)
	end
	
end

function Interface.CreateTCTools()
	if (UserData.Settings.Login.lastShardSelected == 54 and not DoesWindowExist("TCTOOLSWindow")) then
		CreateWindowFromTemplate("TCTOOLSWindow", "TCTOOLS", "Root")
		WindowClearAnchors("TCTOOLSWindow")
		WindowAddAnchor("TCTOOLSWindow", "bottomright", "ResizeWindow", "bottomright", -10, -20)
		WindowSetShowing("TCTOOLSWindowIMG", false)
		SnapUtils.SnappableWindows["TCTOOLSWindow"] = true
		WindowUtils.RestoreWindowPosition("TCTOOLSWindow", false)
	end
end

function Interface.InitializeWindows()
	MobileHealthBar.UpdateBarSizes()
	MobileBarsDockspot.Initialize()
	SpellsInfo.Initialize()
	HotbarSystem.Initialize()
	GGManager.Initialize()	
	DamageWindow.Initialize()
	EquipmentData.Initialize()
	OverheadText.InitializeEvents()
    StaticTextWindow.Initialize()
    ProfileWindow.Initialize()
    PropertiesInfo.Initialize()
    StatusWindow.Initialize()
    AdvancedBuff.Initialize()
    BuffDebuff.Initialize()
	CreaturesDB.Initialize()
	ClockWindow.Initialize()
	Tooltips.Initialize()
	CastBarWindow.Initialize()
	ResizeWindow.UpdateLockStatus()
	LabelSetText("CCRLBL2", L"Ver. " .. Interface.Version)
end

function Interface.InitializeLootSort()
	local customOrder, customized = LoadSaveStructureWithPlayerID(Interface.LootSortOrder)
	local count = 0
	local user = UserData.Settings.Login.lastUserName
	local shard = UserData.Settings.Login.lastShardSelected
	local playerID = GetPlayerID()
	if customOrder then
		for _, _ in pairs(customOrder) do
			count = count + 1
		end
	end
	if customized and (customOrder and count > 0) then
		ItemPropertiesInfo.LootOrder = Interface.LootSortOrder[user][shard][playerID]	
		Interface.LootSortCustomized = true

	elseif customized and (not customOrder or count == 0) then
		table.insert(Interface.LootSortOrder[user][shard], playerID, table.copy(ItemPropertiesInfo.LootOrder))
		ItemPropertiesInfo.LootOrder = Interface.LootSortOrder[user][shard][playerID]		
		Interface.LootSortCustomized = true
		
	end
	SettingsWindow.UpdateLootItemsList()
end

function Interface.InitializeSOSWaypoints()
	Interface.SOSWaypointsInitialized = true

	Interface.SOSWaypoints = LoadSaveStructureWithPlayerID(Interface.SOSWaypointsAll)
end

function Interface.InitializeTmapWaypoints()
	Interface.TmapWaypointsInitialized = true

	Interface.TmapWaypoints = LoadSaveStructureWithPlayerID(Interface.TmapWaypointsAll)
end

function Interface.InitializeCustomWaypoints()
	Interface.CustomWaypointsInitialized = true
	CustomWaypoints = LoadSaveStructureWaypoints(UserCustomWaypoints)
end

function Interface.CreateOverrides()
	Interface.org_ReloadUI = InterfaceCore.ReloadUI
	InterfaceCore.ReloadUI = Interface.ReloadUI

	Interface.org_RequestTargetInfo = RequestTargetInfo
	RequestTargetInfo = Interface.RequestTargetInfo

	Interface.org_GetAbilityData = GetAbilityData
    GetAbilityData = Interface.GetAbilityData

	Interface.org_GetStringFromTid = GetStringFromTid
    GetStringFromTid = Interface.GetStringFromTid

	Interface.org_DragSlotAutoPickupObject = DragSlotAutoPickupObject
    DragSlotAutoPickupObject = Interface.DragSlotAutoPickupObject

	Interface.org_DragSlotSetObjectMouseClickData = DragSlotSetObjectMouseClickData
    DragSlotSetObjectMouseClickData = Interface.DragSlotSetObjectMouseClickData

	Interface.org_MoveItemToContainer = MoveItemToContainer
    MoveItemToContainer = Interface.MoveItemToContainer

	Interface.org_ButtonSetPressedFlag = ButtonSetPressedFlag
    ButtonSetPressedFlag = Interface.ButtonSetPressedFlag

	Interface.org_DoesWindowExist = DoesWindowExist
    DoesWindowExist = Interface.DoesWindowExist

	Interface.org_DoesWindowNameExist = DoesWindowNameExist
    DoesWindowNameExist = Interface.DoesWindowNameExist

	Interface.org_IsHealthBarEnabled = IsHealthBarEnabled
    IsHealthBarEnabled = Interface.IsHealthBarEnabled
    
	Interface.org_WindowSetMoving = WindowSetMoving
    WindowSetMoving = Interface.WindowSetMoving
    
	Interface.org_CreateWindow = CreateWindow
    CreateWindow = Interface.CreateWindow
    
	Interface.org_IsMobile = IsMobile
    IsMobile = Interface.IsMobile
    
	Interface.org_UnregisterWindowData = UnregisterWindowData
    UnregisterWindowData = Interface.UnregisterWindowData
    
	Interface.org_RegisterWindowData = RegisterWindowData
    RegisterWindowData = Interface.RegisterWindowData
    
	Interface.org_RequestContextMenu = RequestContextMenu
    RequestContextMenu = Interface.RequestContextMenu
    
    Interface.org_DragSlotQuantityRequestResult = DragSlotQuantityRequestResult
    DragSlotQuantityRequestResult = Interface.DragSlotQuantityRequestResult
    
    Interface.org_HandleSingleLeftClkTarget = HandleSingleLeftClkTarget
    HandleSingleLeftClkTarget = Interface.HandleSingleLeftClkTarget
    
    Interface.org_WindowRegisterEventHandler = WindowRegisterEventHandler
    WindowRegisterEventHandler = Interface.WindowRegisterEventHandler

	Interface.org_WindowUnregisterEventHandler = WindowUnregisterEventHandler
    WindowUnregisterEventHandler = Interface.WindowUnregisterEventHandler

	Interface.org_pcall = pcall
    pcall = Interface.pcall

	Interface.org_WindowSetShowing = WindowSetShowing
    WindowSetShowing = Interface.WindowSetShowing

	Interface.org_UserActionHasTargetType = UserActionHasTargetType
    UserActionHasTargetType = Interface.UserActionHasTargetType

	Interface.org_UserActionGetTargetType = UserActionGetTargetType
    UserActionGetTargetType = Interface.UserActionGetTargetType

	Interface.org_DoesPlayerHaveItem = DoesPlayerHaveItem
	DoesPlayerHaveItem = Interface.DoesPlayerHaveItem

	Interface.org_ReplaceTokens = ReplaceTokens
	ReplaceTokens = Interface.ReplaceTokens

	Interface.org_WindowAssignFocus = WindowAssignFocus
	WindowAssignFocus = Interface.WindowAssignFocus

	Interface.org_DestroyWindow = DestroyWindow
	DestroyWindow = Interface.DestroyWindow

	Interface.org_SingleLineTextEntryOnSubmit = SingleLineTextEntry.OnSubmit
	SingleLineTextEntry.OnSubmit = Interface.SingleLineTextEntryOnSubmit

	Interface.org_SingleLineTextEntryOnCancel = SingleLineTextEntry.OnCancel
	SingleLineTextEntry.OnCancel = Interface.SingleLineTextEntryOnCancel

	Interface.org_SingleLineTextEntryInitialize = SingleLineTextEntry.Initialize
	SingleLineTextEntry.Initialize = Interface.SingleLineTextEntryInitialize

	Interface.org_SingleLineTextEntryShutdown = SingleLineTextEntry.Shutdown
	SingleLineTextEntry.Shutdown = Interface.SingleLineTextEntryShutdown

	Interface.org_LabelSetTextColor = LabelSetTextColor
	LabelSetTextColor = Interface.LabelSetTextColor

	Interface.org_WindowAddAnchor = WindowAddAnchor
	WindowAddAnchor = Interface.WindowAddAnchor

	Interface.org_AttachWindowToWorldObject = AttachWindowToWorldObject
	AttachWindowToWorldObject = Interface.AttachWindowToWorldObject

	Interface.org_DetachWindowFromWorldObject = DetachWindowFromWorldObject
	DetachWindowFromWorldObject = Interface.DetachWindowFromWorldObject

	Interface.org_WindowStopAlphaAnimation = WindowStopAlphaAnimation
	WindowStopAlphaAnimation = Interface.WindowStopAlphaAnimation

	Interface.org_WindowStartAlphaAnimation = WindowStartAlphaAnimation
	WindowStartAlphaAnimation = Interface.WindowStartAlphaAnimation

	Interface.org_BroadcastEvent = BroadcastEvent
	BroadcastEvent = Interface.BroadcastEvent

	Interface.org_WindowSetFontAlpha = WindowSetFontAlpha
	WindowSetFontAlpha = Interface.WindowSetFontAlpha

	Interface.org_GetDistanceFromPlayer = GetDistanceFromPlayer
	GetDistanceFromPlayer = Interface.GetDistanceFromPlayer

	Interface.org_WindowGetId = WindowGetId
	WindowGetId = Interface.WindowGetId

	Interface.org_WindowGetShowing = WindowGetShowing
	WindowGetShowing = Interface.WindowGetShowing

	Interface.org_LabelSetText = LabelSetText
	LabelSetText = Interface.LabelSetText

	Interface.org_IsObjectIdPet = IsObjectIdPet
	IsObjectIdPet = Interface.IsObjectIdPet
	
	-- this 2 are obsolete functions used on default...
	StringSplit = string.split
	WStringSplit = wstring.split
end

function Interface.InitializeMap()

	-- has the map already been initialized?
	if Interface.mapInitialized then
		return
	end

	-- do we have the wrong map mode set?
	if SystemData.Settings.Interface.mapMode ~= MapCommon.MAP_ATLAS and SystemData.Settings.Interface.mapMode ~= MapCommon.MAP_HIDDEN then

		-- fix the map mode
		SystemData.Settings.Interface.mapMode = MapCommon.MAP_ATLAS
		UserSettingsChanged()

		-- update the type of waypoints to display (radar is the only one that can show healers)
		UOSetWaypointDisplayMode("RADAR")
	end

	-- make sure the map is open if it was open the last session
	if SystemData.Settings.Interface.mapMode == MapCommon.MAP_ATLAS then
		MapWindow.ShowMap()
	end

	-- mark the map as initialized
	Interface.mapInitialized = true
end

function Interface.InterfaceInitialize() 
	local x, y = WindowGetOffsetFromParent("ResizeWindow")
	
	if (not Interface.FirstImprovement) then
		local needReload = false

		Interface.PlayerID = WindowData.PlayerStatus.PlayerId
		Interface.SaveNumber("PlayerID", WindowData.PlayerStatus.PlayerId)

		if not Interface.PlayerVariablesInitialized then
			pcall(Interface.LoadPlayerVariablesMod)	
		end

		Interface.FirstImprovement = true
		Interface.SaveBoolean( "FirstImprovement", Interface.FirstImprovement )
		
		SystemData.Settings.GameOptions.enableAutorun = false
		SystemData.Settings.GameOptions.ignoreMouseActionsOnSelf = true
		SystemData.Settings.GameOptions.holdShiftToUnstack = true 
		SystemData.Settings.Interface.defaultCorpseMode = "List"
		SystemData.Settings.GameOptions.showStrLabel = true
		SystemData.Settings.Sound.music.enabled = false
		SystemData.Settings.Interface.mapMode = MapCommon.MAP_ATLAS
		
		Interface.SaveBoolean( "StatusLabels", SystemData.Settings.GameOptions.showStrLabel )
		
		SystemData.Settings.GameOptions.mouseScrollUpAction = SystemData.Settings.GameOptions.MOUSESCROLL_NONE
		SystemData.Settings.GameOptions.mouseScrollDownAction = SystemData.Settings.GameOptions.MOUSESCROLL_NONE
				 
		WindowClearAnchors("NewChatWindow")
		WindowAddAnchor("NewChatWindow", "bottomleft", "ResizeWindow", "bottomleft", 0, -40)
		WindowUtils.SaveWindowPosition("NewChatWindow", true)
	end	
	local hb = -1
	if (not Interface.MenuBar or not Hotbar.DoesHotbarExist(Interface.MenuBar)) then	
		if Interface.MenuBar ~= nil then
			HotbarSystem.SpawnNewHotbar(Interface.MenuBar)
		else
			Interface.MenuBar = HotbarSystem.SpawnNewHotbar()
		end

		HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_SPEECH_USER_COMMAND, 5006, 860006, Interface.MenuBar,  1)
		HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_SPEECH_USER_COMMAND, 5007, 860007, Interface.MenuBar,  2)
		HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_SPEECH_USER_COMMAND, 5003, 860003, Interface.MenuBar,  3)
		HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_SPEECH_USER_COMMAND, 5004, 860004, Interface.MenuBar,  4)
		HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_SPEECH_USER_COMMAND, 5005, 860005, Interface.MenuBar,  5)
		HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_SPEECH_USER_COMMAND, 5743,    718, Interface.MenuBar,  6)
		HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_SPEECH_USER_COMMAND, 5001, 860001, Interface.MenuBar,  7)
		HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_SPEECH_USER_COMMAND, 5016, 860016, Interface.MenuBar,  8)
		HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_SPEECH_USER_COMMAND, 5014, 860014, Interface.MenuBar,  9)
		HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_SPEECH_USER_COMMAND, 5015, 860015, Interface.MenuBar, 10)
		HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_SPEECH_USER_COMMAND, 5017, 860017, Interface.MenuBar, 11)
		HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_SPEECH_USER_COMMAND, 5011, 860011, Interface.MenuBar, 12)
		
		Interface.SaveNumber( "MenuBar", Interface.MenuBar )

		WindowClearAnchors("Hotbar" .. Interface.MenuBar)
		WindowAddAnchor("Hotbar" .. Interface.MenuBar, "bottom", "Root", "bottom", 0, 0)

		hb = HotbarSystem.SpawnNewHotbar()
	end	

	if (not Interface.MountBlockbar or not Hotbar.DoesHotbarExist(Interface.MountBlockbar)) then	
		if Interface.MountBlockbar ~= nil then
			HotbarSystem.SpawnNewHotbar(Interface.MountBlockbar, 1, true)
		else
			Interface.MountBlockbar = HotbarSystem.SpawnNewHotbar(_, 1, true)
			Interface.SaveNumber( "MountBlockbar", Interface.MountBlockbar )
		end
		
		SystemData.Hotbar[Interface.MountBlockbar].Bindings[1] = L"Z"
	    SystemData.Hotbar[Interface.MountBlockbar].BindingDisplayStrings[1] = L"Z"
		HotbarUpdateBinding(Interface.MountBlockbar, 1, L"Z")

		if GetMobileRace(GetPlayerID()) == PaperdollWindow.GARGOYLE then
			HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_RACIAL_ABILITY, 1, 3021, Interface.MountBlockbar,  1)
		else
			local mountMacro = MacroWindow.GetMacroId(L"MountBlockbarMacro")

			if mountMacro == 0 then
				local macroIndex = MacroSystemAddMacroItem()
	
				UserActionMacroSetName(SystemData.MacroSystem.STATIC_MACRO_ID, macroIndex, L"MountBlockbarMacro")
				UserActionSetIconId(SystemData.MacroSystem.STATIC_MACRO_ID,macroIndex, 0, 870300)

				ActionEditWindow.OpenEditWindow(macroIndex, SystemData.UserAction.TYPE_MACRO, nil, SystemData.MacroSystem.STATIC_MACRO_ID)
				WindowSetShowing("ActionEditMacro", false)

				Interface.CreateMountMacro = macroIndex
				Interface.CreateMountMacroStep = 0
			else
				HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_MACRO_REFERENCE, mountMacro, 870300, Interface.MountBlockbar,  1)
			end
		end
	end

	if (not Interface.PetControlsBar or not Hotbar.DoesHotbarExist(Interface.PetControlsBar)) then
		if Interface.PetControlsBar ~= nil then
			HotbarSystem.SpawnNewHotbar(Interface.PetControlsBar, 5, true)
		else
			Interface.PetControlsBar = HotbarSystem.SpawnNewHotbar(nil, 5)
		end
		
		HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_PET_COMMAND_ALLKILL,	29, 650, Interface.PetControlsBar,  1)
		HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_PET_COMMAND_FOLLOWME, 32, 656, Interface.PetControlsBar,  2)
		HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_PET_COMMAND_GUARDME,	34, 658, Interface.PetControlsBar,  3)
		HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_PET_COMMAND_STOP,		36, 660, Interface.PetControlsBar,  4)
		HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_PET_COMMAND_STAY,		35, 661, Interface.PetControlsBar,  5)
		SystemData.Hotbar[Interface.PetControlsBar].Bindings[1] = L"Left Control+1"
	    SystemData.Hotbar[Interface.PetControlsBar].BindingDisplayStrings[1] = L"1"
		HotbarUpdateBinding(Interface.PetControlsBar,1,L"Left Control+1")

		
		SystemData.Hotbar[Interface.PetControlsBar].Bindings[2] = L"Left Control+2"
	    SystemData.Hotbar[Interface.PetControlsBar].BindingDisplayStrings[2] = L"2"
		HotbarUpdateBinding(Interface.PetControlsBar,2,L"Left Control+2")
		
		
		SystemData.Hotbar[Interface.PetControlsBar].Bindings[3] = L"Left Control+3"
	    SystemData.Hotbar[Interface.PetControlsBar].BindingDisplayStrings[3] = L"3"
		HotbarUpdateBinding(Interface.PetControlsBar,3,L"Left Control+3")

		
		SystemData.Hotbar[Interface.PetControlsBar].Bindings[4] = L"Left Control+4"
	    SystemData.Hotbar[Interface.PetControlsBar].BindingDisplayStrings[4] = L"4"
		HotbarUpdateBinding(Interface.PetControlsBar,4,L"Left Control+4")

		
		SystemData.Hotbar[Interface.PetControlsBar].Bindings[5] = L"Left Control+5"
	    SystemData.Hotbar[Interface.PetControlsBar].BindingDisplayStrings[5] = L"5"
		HotbarUpdateBinding(Interface.PetControlsBar,5,L"Left Control+5")

		Interface.SaveNumber( "PetControlsBar", Interface.PetControlsBar )

		-- get the pets window name
		local _, petWindow = MobileBarsDockspot.GetPetDockspotStatus()

		WindowClearAnchors("Hotbar" .. Interface.PetControlsBar)
		WindowAddAnchor("Hotbar" .. Interface.PetControlsBar, "right", petWindow, "left", -2 ,0)
		WindowSetScale("Hotbar" .. Interface.PetControlsBar, 0.64)
		Interface.SaveNumber("Hotbar" .. Interface.PetControlsBar .. "SC", 0.64)
		Interface.SaveBoolean("Hotbar" .. Interface.PetControlsBar .. "LockWithHandle", true)
	end	

	if not Interface.InitialPositions then
		
		local x,y = WindowGetDimensions("Root")
		WindowSetDimensions("ResizeWindow", x - 550, y - 300)
		ResizeWindow.OnResizeEnd()
		ResizeWindow.UpdateWindow()
		
		WindowClearAnchors("MapWindow")
		WindowAddAnchor("MapWindow", "topright", "ResizeWindow", "topleft", 0, 0)
		WindowUtils.ClearAnchorsWithoutMoving("MapWindow")

		WindowClearAnchors("Hotbar1")
		WindowAddAnchor("Hotbar1", "bottomleft", "ResizeWindow", "topleft", 40, 0)
		WindowUtils.ClearAnchorsWithoutMoving("Hotbar1")
		
		if hb ~= -1 then
			--Hotbar.SetLocked(hb, true)
			WindowClearAnchors("Hotbar" .. hb)
			WindowAddAnchor("Hotbar" .. hb, "topright", "Hotbar1", "topleft", 0, 0)
			WindowUtils.ClearAnchorsWithoutMoving("Hotbar" .. hb)
		end
		
		if DoesWindowExist("TCTOOLSWindow") then
			WindowClearAnchors("TCTOOLSWindow")
			WindowAddAnchor("TCTOOLSWindow", "bottomright", "ResizeWindow", "bottomright", 0, -20)
			WindowUtils.ClearAnchorsWithoutMoving("TCTOOLSWindow")
		end
		
		WindowClearAnchors("TargetWindow")
		WindowAddAnchor("TargetWindow", "top", "ResizeWindow", "top", 0, 120)
		WindowUtils.ClearAnchorsWithoutMoving("TargetWindow")
		
		if DoesWindowExist("TipoftheDayWindow") then
			WindowClearAnchors("TipoftheDayWindow")
			WindowAddAnchor("TipoftheDayWindow", "center", "ResizeWindow", "center", 0, 0)
			WindowUtils.ClearAnchorsWithoutMoving("TipoftheDayWindow")
		end
		
		if DoesWindowExist("ClockWindow") then
			WindowClearAnchors("ClockWindow")
			WindowAddAnchor("ClockWindow", "topright", "ResizeWindow", "topright", 0, 0)
			WindowUtils.ClearAnchorsWithoutMoving("ClockWindow")
		end

		ResizeWindow.UpdateViewport()
				
		Interface.BackpackFirstPositioning = true
		Interface.NewChatFirstPositioning = true
		Interface.PaperdollFirstPositioning = true
				
		Interface.InitialPositions = true
		Interface.SaveBoolean("InitialPositions", Interface.InitialPositions )
		WindowUtils.SaveWindowPosition("ResizeWindow", true)
	else
		Interface.AddTodoList({ name = "Resize resizewindow", func = function() WindowUtils.RestoreWindowPosition("ResizeWindow", true) ResizeWindow.UpdateViewport() end, time = Interface.TimeSinceLogin + 0.5 })
	end

	Interface.PropsSlot = {HotbarID = Interface.LoadSetting("PropsSlotHotbarID", 1 ), SlotID = Interface.LoadSetting("PropsSlotSlotID", 1 )}
	local props = "Hotbar"..Interface.PropsSlot.HotbarID.."Button"..Interface.PropsSlot.SlotID
	
	if not DoesWindowExist(props) then
		Interface.PropsSlot = nil
	else
		local action = UserActionGetId(Interface.PropsSlot.HotbarID,Interface.PropsSlot.SlotID,0)
		if action ~= 5752 then
			Interface.PropsSlot = nil
		end
	end
	Interface.DisableProps = Interface.LoadSetting("DisableProps", Interface.DisableProps, true)
	
	Interface.InitializeLootSort()
	
	SettingsWindow.UpdateSettings()
	
	Hotbar.RelaodAll()

	pcall(HotbarSystem.HandleUpdatehotbarsKeybinding)
	
	WindowSetShowing("Loading", false)
	
	Interface.InterfaceInitialized = true
end

function Interface.InitBugReport()
	ToggleWindowByName("BugReportWindow")
end

-------------------------------------------------------------------------------
--
-- TIMERS
--
-------------------------------------------------------------------------------
Interface.ECPlaySoundActive = false
Interface.ECPCheckPhase = 1
function Interface.CheckUIStarted(timePassed)

	local started = true

	started = started and Interface.PlayerVariablesInitialized ~= nil
	started = started and Interface.VerifyPlayerStatus() ~= nil
	started = started and Interface.Clock.Timestamp ~= 0

	-- get the player ID
	local playerID = GetPlayerID()

	-- if we don't have the player ID we can get out
	if not playerID then
		return
	end

	-- EC Playsound check file name
	local checkFile = "logs/" .. playerID .. "_ECPCheck.dat"

	-- EC Playsound check phase 1
	if Interface.ECPCheckPhase == 1 then

		-- set the UI as NOT started
		started = false

		-- create a check file
		CreateTextFile(checkFile, L"CHECK")

		-- set to phase 2
		Interface.ECPCheckPhase = 2

		-- mark EC Playsound as INACTIVE
		Interface.ECPlaySoundActive = false

	-- EC Playsound check phase 2
	elseif Interface.ECPCheckPhase == 2 then
		
		-- set the UI as NOT started
		started = false

		-- read the file
		local text = LoadTextFile(checkFile)

		-- is EC Playsound active?
		if text == L"ACTIVE" then
			
			-- overwrite the file with to delete it
			CreateTextFile(checkFile, L"DELETE")

			-- set to phase 3
			Interface.ECPCheckPhase = 3

		else -- phase 1 failed, try again...

			-- create a check file
			CreateTextFile(checkFile, L"CHECK")
		end

		-- mark EC Playsound as INACTIVE
		Interface.ECPlaySoundActive = false

	-- EC Playsound check phase 3
	elseif Interface.ECPCheckPhase == 3 then

		-- set the UI as NOT started
		started = false

		-- read the file
		local text = LoadTextFile(checkFile)

		-- if we have no text, the file is gone and the check is complete
		if text == nil then

			-- end the phase check
			Interface.ECPCheckPhase = 4

			-- set the UI as started
			started = started and true

			-- mark EC Playsound as ACTIVE
			Interface.ECPlaySoundActive = true

			-- update the sound status
			SettingsWindow.UpdateECPlaySoundStatus()
		end
	end

	Interface.started = started
	if Interface.ReloadTriggered and started then
		Interface.ReloadTriggered = nil
	end
end

function Interface.Update(timePassed)
	
	-- make sure the UI has been initialized first
	if not Interface.ReadyToStart or Interface.goingDown then
		return
	end

	-- increase the time since login
	Interface.TimeSinceLogin = Interface.TimeSinceLogin + timePassed

	-- parse the TODO list
	pcall(Interface.TODOList, timePassed)

	-- parse the custom events
	pcall(Interface.CheckAvailableEventsManager, timePassed)

	-- verify player ID
	if not IsValidID(Interface.PlayerID) and IsValidID(WindowData.PlayerStatus.PlayerId) then
		Interface.PlayerID = WindowData.PlayerStatus.PlayerId
		Interface.SaveNumber("PlayerID", WindowData.PlayerStatus.PlayerId)
	end

	-- the profile has been copied from another character, and we need to fix the playerid ASAP to avoid troubles
	if WindowData.PlayerStatus.PlayerId ~= GetPlayerID() and IsValidID(WindowData.PlayerStatus.PlayerId) then 
		Interface.PlayerID = WindowData.PlayerStatus.PlayerId
		Interface.SaveNumber("PlayerID", WindowData.PlayerStatus.PlayerId)
		BroadcastEvent( SystemData.Events.RELOAD_INTERFACE )
		return
	end

	-- make sure the player variables are initialized
	if not Interface.PlayerVariablesInitialized  then

		-- load the variables mod
		pcall(Interface.LoadPlayerVariablesMod) 
	end
	
	-- check if the UI is ready to be set started
	pcall(Interface.CheckUIStarted, timePassed)

	-- show the loading screen if the UI is not started correctly
	WindowSetShowing("Loading", not Interface.started and not Interface.DebugMode)
	
	-- has the reload been triggered?
	if Interface.ReloadTriggered and not Interface.started then

		-- if the reload cooldown has been triggered for enough time, we just reload the UI
		if Interface.ReloadCountDown > 0 and Interface.TimeSinceLogin <= Interface.ReloadCountDown then
			Interface.ReloadTriggered = nil
			BroadcastEvent( SystemData.Events.RELOAD_INTERFACE )
		end
		return
	end

	-- if the UI is not started, we can stop here
	if not Interface.started then
		return
	end
	
	-- make sure all player variables are initialized
	pcall(Interface.InitializePlayerVariables, timePassed)

	-- initialize the map
	pcall(Interface.InitializeMap)

	-- chat need to stay fixed
	pcall(Interface.ChatFixer, timePassed)

	-- make sure the mobile list AND overhead bars are not active at the same time
	pcall(Interface.HealthbarProtectionSystem, timePassed)

	-- time for delyaed updates
	Interface.DeltaTime = Interface.DeltaTime + timePassed

	-- delayed functions (once per second)
	if (Interface.DeltaTime >= 1) then
		
		-- reset the time
		Interface.DeltaTime = 0

		-- clock update
		pcall(Interface.ClockUpdater, timePassed) 

		-- show/hide paperdoll
		pcall(Interface.PaperdollCheck, timePassed)

		-- manage custom buffs
		pcall(CustomBuffs.BuffManager, timePassed) 

		-- update items durabilities for the player paperdoll
		pcall(PaperdollWindow.UpdateDurabilities, timePassed)
		
		-- update pet power hour
		pcall(MobileHealthBar.PetPowerHourManager, timePassed)

		-- update the summons time
		pcall(MobileHealthBar.SummonsManager, timePassed)	

		-- update the available mounts
		pcall(MountsList.Update, timePassed)

		-- TC Tools, reset all skills
		pcall(StatusWindow.ResetSkills, timePassed)

		-- fix for these settings (they don't save correctly so we have to load them separately)
		SystemData.Settings.GameOptions.noWarOnPets =		Interface.Settings.noWarOnPets		
		SystemData.Settings.GameOptions.noWarOnParty =		Interface.Settings.noWarOnParty		
		SystemData.Settings.GameOptions.noWarOnFriendly =	Interface.Settings.noWarOnFriendly
	end

	-- atlas delayed update
	Interface.AtlasResetTime = Interface.AtlasResetTime + timePassed	
	if (Interface.AtlasResetTime >= 2) then

		Interface.AtlasResetTime = 0

		pcall(GenericGump.ClearRunicAtlasData, timePassed)	

		-- make sure the chat status is correct
		if WindowData.GChatMyPresence ~= Interface.ChatStatus and WindowData.GChatCount > 0 then
			BroadcastEvent( SystemData.Events.TOGGLE_GLOBAL_CHAT_PRESENCE )
		end
	end

	-- atlas delayed update
	Interface.MobilesOnScreenDelta = Interface.MobilesOnScreenDelta + timePassed	
	if (Interface.MobilesOnScreenDelta >= Interface.Settings.MoSUpdateLimit) then
		
		-- scan all mobiles on screen
		pcall(Interface.ScanMobilesOnScreen)

		Interface.MobilesOnScreenDelta = 0
	end

	-- papedoll delayed scan
	PaperdollWindow.ScanDelta = PaperdollWindow.ScanDelta + timePassed
	if PaperdollWindow.ScanDelta > PaperdollWindow.ScanDeltaTime or PaperdollWindow.GotDamage == true then
		PaperdollWindow.ScanDelta = 0
		
		PaperdollWindow.ScanProperties()

		-- reset the changed equip flag
		PaperdollWindow.GotDamage = false
	end

	-- in combat flag
	if (Interface.TimeSinceLogin >= Interface.IsFightingLastTime and Interface.IsFighting) then
		Interface.IsFighting = false
	end
	
	-- increase the timer from the last items list update
	Interface.ActiveItemsTimeFromLastUpdate = Interface.ActiveItemsTimeFromLastUpdate + timePassed

	-- is the player dead?
	Interface.IsPlayerDead = IsPlayerDead()

	-- war mode backup
	if (not IsPlayerInvisible()) then
		Interface.WarModeBackup = WindowData.PlayerStatus.InWarMode
	end

	-- make sure to reset the drag window
	if SystemData.DragItem.DragType == SystemData.DragItem.TYPE_NONE then
		pcall(DragWindow.Shutdown, timePassed)
	end
	
	-- update all the dockspots (delayed)
	pcall(MobileBarsDockspot.UpdateAllDockspotsBars, timePassed)

	-- update all the dockspots (delayed)
	pcall(MobileBarsDockspot.UpdateAllDockspotsButtons, timePassed)

	-- anchor the pet controls to the pet dockspot
	pcall(Hotbar.PetControlsSnap)

	-- update all the target ouse over actions inside macros
	pcall(HotbarSystem.HandleUpdateTargetMouseOver)

	-- windowdata garbage collector
	pcall(Interface.ClearWindowData, timePassed)	

	-- make sure the player backpack ID and items are always available
	pcall(ContainerWindow.InitializePlayerContainersID, timePassed)

	-- make sure the main menu is not showing when it shouldn't
	pcall(Interface.MainMenuChecker, timePassed)	

	-- check if the shop window is open
	pcall(Interface.ShopChecker, timePassed)	

	-- update the object handles
	pcall(ObjectHandleWindow.OnUpdate, timePassed)

	-- clear the item properties if we don't need it
	pcall(Interface.PropsCacheClear, timePassed)

	-- stop loading pending properties
	pcall(Interface.ItemPropertiesFailSafe, timePassed)	

	-- properly anchors the macro window
	pcall(Interface.MacroWindowsAnchoring, timePassed)	
	
	-- handle the clickable area in the status
	pcall(StatusWindow.EnableInput, timePassed)	

	-- update the status latency
	pcall(Interface.UpdateLatency, timePassed)	
	
	-- update the buff/debuff
	pcall(BuffDebuff.Update, timePassed)
	
	-- update the damage window
	pcall(DamageWindow.UpdateTime, timePassed)	

	-- update the game area
	pcall(ResizeWindow.Update, timePassed)	

	-- update the overhead text
	pcall(OverheadText.Update, timePassed)	

	-- check the backpack position
	pcall(Interface.BackpackCheck, timePassed)	

	-- check the backpack items
	pcall(ContainerWindow.BackpackItemsCheck, timePassed)

	-- check the pending items
	pcall(ContainerWindow.WaitForItems, timePassed)	

	-- pickup timer handler
	pcall(ContainerWindow.UpdatePickupTimer, timePassed)

	-- update container uses
	pcall(ContainerWindow.UsesUpdateCycle, timePassed)	

	-- drag one item handler
	pcall(ContainerWindow.DragOneItem, timePassed)	

	-- organizer cycle
	pcall(ContainerWindow.OrganizerCycle, timePassed)	

	-- restock cycle
	pcall(ContainerWindow.RestockCycle, timePassed)	

	-- loot all cycle
	pcall(ContainerWindow.LootAllCycle, timePassed)	
	
	-- static text update
	pcall(StaticTextWindow.Update, timePassed)	

	-- map update
	pcall(MapCommon.Update, timePassed)	

	-- quickstats update
	pcall(QuickStats.OnUpdate, timePassed)

	-- all skills up/down/lock handler
	pcall(Interface.SkillLocker, timePassed)	

	-- last target handler
	pcall(Interface.CheckLastTargetChanged, timePassed)	

	-- target dragged item to put inside EJ bank
	pcall(Interface.GumpTargetDragBank, timePassed)	

	-- target dragged item to put inside jewels box
	pcall(Interface.GumpTargetDragJewbox, timePassed)	

	-- all release command handler
	pcall(Actions.ReleasePet, timePassed)	

	-- sleep mode handler
	pcall(Actions.KeepAliveMan, timePassed)

	-- mass organizer cycle
	pcall(Actions.MassOrganizer, timePassed)	

	-- undress agent cycle
	pcall(Actions.UndressAgent, timePassed)	

	-- load shurikens cycle
	pcall(Actions.Shuriken, timePassed)	

	-- castbar handler
	pcall(Interface.SpellsTimer, timePassed)

	-- target protection data handler
	pcall(Interface.TargetProtectionManager, timePassed)

	-- cooldowns manager
	pcall(Interface.Cooldowns, timePassed)	

	-- logout cooldown handler
	pcall(Interface.LoginTimeoutCheck, timePassed)	

	-- exit game cooldown handler
	pcall(Interface.RestartTimeoutCheck, timePassed)

	-- area info update
	pcall(MapCommon.UpdateAreaInfo, timePassed)	

	-- sound manager
	pcall(Interface.SoundBuffer, timePassed)

	-- block paperdoll manager
	pcall(PaperdollWindow.BlockPaperdolls, timePassed)	

	-- special moves mana cooldown manager
	pcall(Interface.SpecialMovesManaCooldown, timePassed)

	-- mobile arrow manager
	pcall(Interface.MobileArrowManager, timePassed)	

	-- war button status handler
	pcall(Interface.UpdateWarButton, timePassed)

	-- paperdoll window update
	pcall(PaperdollWindow.OnUpdate, timePassed)	

	-- parse active gumps
	pcall(GumpsParsing.CheckGumpType, timePassed)	
	
	-- center screen text manager
	pcall(CenterScreenText.OnUpdate, timePassed)

	-- cleanup unused SOS waypoints
	pcall(Interface.SOSWaypointsCleaner, timePassed)

	-- cleanup unused Tmap waypoints
	pcall(Interface.TmapWaypointsCleaner, timePassed)	
	
	-- handle the mouse over item changed event
	pcall(Interface.MouseOverItemCheck, timePassed)	

	-- update the castbar
	pcall(CastBarWindow.Update, timePassed)	

	-- handle the mouse over properties
	pcall(Interface.PropsTimerHandler, timePassed)	

	-- handle the moving windows
	pcall(Interface.DragWindowHandler, timePassed)	

	-- buoy tools updater
	pcall(BuoyTool.Update, timePassed)	

	-- loading failsafe (reload the UI if it's stuck on loading)
	pcall(Interface.LoadingFailSafe, timePassed)	

	-- parse the debug log
	pcall(Debug.ParseDebugLog)

	-- spellbook macro creation cycle
	pcall(Spellbook.CreateMacroCycle, timePassed)	

	-- mount/dismount macro creation cycle
	pcall(Interface.HandleCreateMountMacro, timePassed)	

	-- import macro cycle
	pcall(Interface.HandleImportMacro, timePassed)	

	-- mount/dismount blockbar updater
	pcall(MountsList.UpdateBlockbar, timePassed)

	-- riding status change handler
	pcall(Interface.CheckRidingStatusChange, timePassed)

	-- handle the mound/dismount blockbar visibility
	pcall(HotbarSystem.HandleMountsBlockbarVisibility)

	-- purge the saved variables
	pcall(Interface.SavedVariablesPurge, timePassed)	

	-- racial tab updater
	pcall(CharacterAbilities.UpdateRacialTab)

	-- check player items durability
	pcall(PaperdollWindow.ItemsCheck, GetPlayerID())

	-- open/close macro handler
	pcall(Interface.MapRefresh, timePassed)	

	-- low hp manger
	pcall(Interface.LowHPManager, timePassed)	

	-- skill tracker updater
	pcall(Interface.SkillsTrackerUpdate, timePassed)

	-- hidden context calls handler
	pcall(Interface.ContextCalls, timePassed)	

	-- hoverbar cycle manager
	pcall(Interface.HoverbarsCycle, timePassed)

	-- animal lore known creatures cleaner
	pcall(AnimalLore.KnownPetsleaner, timePassed)
end

function Interface.MacroWindowsAnchoring(timePassed)

	local macroEditWindow = "ActionEditMacro"
	local macroWindow = "MacroWindow"
	local actionsWindow = "ActionsWindow"

	-- macro edit window and actions window linked
	if	WindowGetShowing(macroEditWindow) and
		WindowGetShowing(actionsWindow)
	then

		-- get the anchors
		local _, _, relativeTo = WindowGetAnchor(actionsWindow, 1)

		-- is already anchored to the macro edit window?
		if relativeTo ~= macroEditWindow then
			WindowClearAnchors(actionsWindow)
			WindowAddAnchor(actionsWindow, "topright", macroEditWindow, "topleft", 0, 0)    
			WindowSetMovable(actionsWindow, false)
		end

		-- is the window movable?
		if DoesWindowExist(actionsWindow) and WindowGetMovable(actionsWindow) then
			WindowSetMovable(actionsWindow, false)
		end

	else -- if the macro edit window is hidden, we make the actions window movable
		if not WindowGetShowing(macroEditWindow) and (WindowGetShowing(actionsWindow) and not WindowGetMovable(actionsWindow)) then
			WindowSetMovable(actionsWindow, true)
		end
	end

	-- macro window and macro edit window linked
	if	WindowGetShowing(macroEditWindow) and
		WindowGetShowing(macroWindow)
	then

		-- get the anchors
		local _, _, relativeTo = WindowGetAnchor(macroEditWindow, 1)

		-- is already anchored to the macro window?
		if relativeTo ~= macroWindow then
			WindowClearAnchors(macroEditWindow)
			WindowAddAnchor(macroEditWindow, "topright", macroWindow, "topleft", 0, 0)    
		end

		-- is the macro edit window movable?
		if WindowGetMovable(macroEditWindow) then

			-- make it static
			WindowSetMovable(macroEditWindow, false)
		end

	else -- if the macro window is hidden, we make the macro edit window movable
		if not WindowGetShowing(macroWindow) and not WindowGetMovable(macroEditWindow) then
			WindowSetMovable(macroEditWindow, true)
		end
	end
end

Interface.ScannedMobilesOnScreen = {}
function Interface.HoverbarsCycle(timePassed)

	if not Interface.started then
		return
	end

	-- make sure the player hoverbar exist if that status style has been selected
	if Interface.Settings.StatusWindowStyle == 3 and not DoesWindowExist("Hoverbar_"..GetPlayerID()) then
		OverheadText.CreatePlayerHoverbar()
	end

	-- is the hoverbar system active?
	if Interface.Settings.HoverbarsActive then
		
		local toRemove = {}

		-- scan all the mobiles on screen
		for mobileId, data in pairs(Interface.ActiveMobilesOnScreen) do

			-- no need for the player ID
			if mobileId == GetPlayerID() then
				continue
			end

			-- does this mobile already have an hoverbar or boss bar?
			if mobileId == BossBar.GetActiveBoss() then
				continue
			end

			-- get the mobile notoriety
			local noto = data.notoriety

			-- is the mobile invulnerable or without notoriety?
			if noto == NameColor.Notoriety.NONE or noto == NameColor.Notoriety.INVULNERABLE then

				-- mark to remove
				toRemove[mobileId] =  true
				continue
			end

			-- do we have the healthbar?
			if MobileHealthBar.ActiveBars[mobileId] then

				-- mark to remove
				toRemove[mobileId] =  true
				continue
			end

			--[[ do we have a text filter?
			if (MobilesOnScreen.STRFilter ~= "") then -- filter

				-- get the mobile name
				mobName = GetMobileName(mobileId)
				
				-- do we have a valid name?
				if IsValidWString(mobName) then

					-- initialize the found flag
					local found = false

					-- scan all the text names in the array
					for cf in wstring.gmatch(MobilesOnScreen.STRFilter, L"[^|]+") do

						-- is this mobile name matching the name?
						if (wstring.find(wstring.lower(mobName), wstring.lower(cf))) then
							found = true
							break
						end
					end

					-- if we haven't found the name, we can destroy the bar and check the next one in list
					if (not found) then	

						-- mark to remove
						toRemove[mobileId] =  true		
						continue				
					end
				end
			end
			--]]

			-- get the mobile distance
			local dist = GetDistanceFromPlayer(mobileId)

			-- is the mobile visible?
			if dist < 0 or dist > 15 then
				
				-- mark to remove
				toRemove[mobileId] =  true
				continue

			-- is the summon filter active?
			elseif (not Interface.Settings.MoSFilter[10] and data.isSummon and mobileId ~= Interface.CurrentHonor) then
				continue

			-- is the notoriety filter active?
			elseif (not Interface.Settings.MoSFilter[noto]) then

				-- mark to remove
				toRemove[mobileId] =  true
				continue

			-- is the hoverbar already present?
			elseif OverheadText.hasHoverbar[mobileId] then
				continue
			
			else
				--[[ get the mobile name
				if not mobName then
					mobName = GetMobileName(mobileId)
				end

				-- mobiles that should be ignored
				if MobilesOnScreen.IgnoredMobile(mobName) then
					continue

				-- is the farm animals filter active?
				elseif (not Interface.Settings.MoSFilter[9] and IsFarmAnimal(mobName) and mobileId ~= Interface.CurrentHonor) then

					-- we check if a mobile is wounded
					local isWounded = false
					local curr, max, dead = GetMobileHealth(mobileId)
					if curr == max then
						continue
					end
				
				end
				--]]
			end

			-- check if the mobile has been marked to remove
			if not toRemove[mobileId] then

				-- try to create an hoverbar
				OverheadText.CreateHoverbar(mobileId)
			end
		end

		-- clean up the scanned mobiles array
		for mobileId, _ in pairs(Interface.ScannedMobilesOnScreen) do

			-- delete the marked mobile since is no longer around
			if not Interface.ActiveMobilesOnScreen[mobileId] then
				Interface.ScannedMobilesOnScreen[mobileId] = nil
			end
		end

		-- scan the existing bars and destroy the one no longer around
		for mobileId, _ in pairs(OverheadText.hasHoverbar) do

			-- is the mobile around?
			if (not Interface.ActiveMobilesOnScreen[mobileId] and mobileId ~= GetPlayerID()) or toRemove[mobileId] then
				
				-- destroy the hoverbar
				OverheadText.DestroyHoverbarByID(mobileId)
			end
		end
	end
end

function Interface.InitializePlayerVariables(timePassed)
	if not Interface.started then
		return
	end

	if not Interface.InterfaceInitialized then
		pcall(Interface.InterfaceInitialize)	
	end
		
	if not BuoyTool.Initialized then
		pcall(BuoyTool.InitializeBuoys)	
	end

	if not ContainerWindow.Initialized then
		pcall(ContainerWindow.InitializeFindItems)
	end

	if not Interface.SOSWaypointsInitialized then
		pcall(Interface.InitializeSOSWaypoints)
	end

	if not Interface.TmapWaypointsInitialized then
		pcall(Interface.InitializeTmapWaypoints)
	end
		
	if not Interface.CustomWaypointsInitialized then
		pcall(Interface.InitializeCustomWaypoints)
	end
		
	if not QuickStats.Initialized then
		pcall(QuickStats.Initialize)
	end
		
	if not AnimalLore.KnownPetsInitialized then
		pcall(AnimalLore.InitializeKnownPets)
	end

	if Interface.SiegeRules and not SkillsWindow.RotInitialized then
		pcall(SkillsWindow.InitializeRot)
	end
		
	if not MobileHealthBar.SummonTimerInitialized then
		pcall(MobileHealthBar.InitializeSummons)
	end
		
	if not MobileHealthBar.PetPowerHourInitialized then
		pcall(MobileHealthBar.InitializePetPowerHour)
	end
		
	if not DyeTubs.Initialized then
		pcall(DyeTubs.InitializeTubs)
	end

	if not HotbarSystem.TargetInitialized then
		pcall(HotbarSystem.InitializeTargetMouseOver)
	end
end

function Interface.ContextCalls(timePassed)
		
	local updateBarLoyalty = (DoesWindowExist("CharacterSheet") and WindowGetShowing("CharacterSheet")) or CharacterSheet.LoyaltyInHotbar or QuickStats.HasLoyaltyLabel()

	if CharacterSheet.NextLoyaltyUpdate <= Interface.TimeSinceLogin and (Interface.TimeSinceLogin - CharacterSheet.LastLoyaltyUpdate) >= CharacterSheet.minLoyaltyUpdate and updateBarLoyalty then
		--Debug.Print("UPDATE LOYALTY")
		ContextMenu.RequestContextAction(GetPlayerID(), ContextMenu.DefaultValues.LoyaltyRating)
		CharacterSheet.NextLoyaltyUpdate = Interface.TimeSinceLogin + CharacterSheet.minLoyaltyUpdate -- prevents the continuous call of the context menu until the gump appears
	end

	local updateBarGold = ((DoesWindowExist("PlayerVendor") and WindowGetShowing("PlayerVendor")) or (DoesWindowExist("CharacterSheet") and WindowGetShowing("CharacterSheet")) or CharacterSheet.BankGoldInHotbar or QuickStats.DoesLabelExist(11)) and (not GumpData or not GumpData.Gumps[GenericGump.INSURANCE_MENU_GUMPID])
		
	if CharacterSheet.NextBankGoldUpdate <= Interface.TimeSinceLogin and updateBarGold and not Interface.SiegeRules then
		--Debug.Print("UPDATE BANK GOLD")
		GumpsParsing.GetBankGold = true 
		ContextMenu.RequestContextAction(GetPlayerID(), ContextMenu.DefaultValues.InsuranceMenu)
		CharacterSheet.NextBankGoldUpdate = Interface.TimeSinceLogin + 60
	end

	if Spellbook.MasteryGumpCheck == true and CharacterSheet.NextMasteryGumpUpdate <= Interface.TimeSinceLogin then
		Spellbook.UpdateMyMasteries()
		CharacterSheet.NextMasteryGumpUpdate = Interface.TimeSinceLogin + CharacterSheet.minLoyaltyUpdate
	end
end

function Interface.CheckRidingStatusChange(timePassed)
	local riding = IsRiding() ~= false
	if Interface.IsRiding ~= riding then
		Interface.MountedStatusChanged(Interface.IsRiding)
		Interface.IsRiding = riding
	end
end

function Interface.HandleImportMacro(timePassed)

	-- is the import active?
	if Interface.ImportMacro ~= nil then

		-- make sure the warning is visible (or create it if missing)
		Interface.ImportMacroWarningDialog()

		-- have we dragged an item already?
		if Interface.ImportMacroStep > 0 then

			-- default macro hotbar ID
			local hotbarId = SystemData.MacroSystem.STATIC_MACRO_ID

			-- macro ID
			local itemIndex = Interface.ImportMacro

			-- drop the action in the last slot
			local dropSuccess = DragSlotDropAction(hotbarId, itemIndex, Interface.ImportMacroStep)

			-- has the action been dropped correctly?
			if (dropSuccess) then

				-- element name
				local actionWindowName = "ActionEditMacro" .. "MacroActionsScrollChildItem" .. Interface.ImportMacroStep

				-- get the element data
				local data = Interface.ImportMacroData.Elements[Interface.ImportMacroStep]

				-- set the target type
				UserActionSetTargetType(hotbarId, itemIndex, Interface.ImportMacroStep, data.targetType)

				-- is this a mouse over target?
				if data.targetType == SystemData.Hotbar.TargetType.TARGETTYPE_MOUSEOVER then

					-- create the target mouse over data
					HotbarSystem.UpdateTargetMouseOver(hotbarId, itemIndex, Interface.ImportMacroStep, {HotbarId = hotbarId, ItemIndex = itemIndex, SubIndex = Interface.ImportMacroStep})

				-- is this a stored target?
				elseif data.targetType == SystemData.Hotbar.TargetType.TARGETTYPE_OBJECT_ID then

					-- set the stored target
					UserActionSetTargetId(hotbarId, itemIndex, Interface.ImportMacroStep, data.storedTarget)
				end

				-- is there a callback for this action?
				if data.callback then

					-- set the action callback
					UserActionSpeechSetText(hotbarId, itemIndex, Interface.ImportMacroStep, data.callback)
				end

				-- is this an unequip action?
				if data.actionType == SystemData.UserAction.TYPE_UNEQUIP_ITEMS then

					-- scan all unequip slots
					for i = 1, #ActionEditWindow.UnEquip.Slots do

						-- is the slot checked?
						if data.UnequipSlots[i] == true then
							
							-- check the slot
							UserActionAddSlot(hotbarId, itemIndex, Interface.ImportMacroStep, ActionEditWindow.UnEquip.Slots[i].slot)
						else

							-- uncheck the slot
							UserActionRemoveSlot(hotbarId, itemIndex, Interface.ImportMacroStep, ActionEditWindow.UnEquip.Slots[i].slot)
						end
					end

				-- is this an equip action?
				elseif (data.actionType == SystemData.UserAction.TYPE_EQUIP_ITEMS) then

					-- scan all equip items
					for i = 1, #data.EquipSlots do
						
						-- does the player have the item?
						if DoesPlayerHaveItem(data.EquipSlots[i].objectId) then

							-- add the item
							UserActionEquipItemsAddItem(hotbarId, itemIndex, Interface.ImportMacroStep, data.EquipSlots[i].objectId, data.EquipSlots[i].objectType)
						end
					end

				-- is this an arm/disarm action?
				elseif (data.actionType == SystemData.UserAction.TYPE_ARM_DISARM) then

					-- check the arm/disarm slot
					UserActionArmDisarmSelectSlot(hotbarId, itemIndex, Interface.ImportMacroStep, data.armDisarmSlot)

				-- is this a target resource action?
				elseif (data.actionType == SystemData.UserAction.TYPE_TARGET_BY_RESOURCE) then
					
					-- load the resource tool
					UserActionTargetByResourceSetUseObjectInstanceId(hotbarId, itemIndex, Interface.ImportMacroStep, data.TargetResource.objectId)

					-- load the resource type
				    UserActionTargetByResourceSetResourceType(hotbarId, itemIndex, Interface.ImportMacroStep, data.TargetResource.resourceType)

					-- load the resource category
				    UserActionTargetByResourceSetResourceCategory(hotbarId, itemIndex, Interface.ImportMacroStep, data.TargetResource.resourceCategory)

				-- is this a delay?
				elseif (data.actionType == SystemData.UserAction.TYPE_DELAY) then

					-- set the action delay
					UserActionDelaySetDelay(hotbarId, itemIndex, Interface.ImportMacroStep, data.delay)
				end
			end
		end

		-- increase the action index
		Interface.ImportMacroStep = Interface.ImportMacroStep + 1

		-- get the element data
		local data = Interface.ImportMacroData.Elements[Interface.ImportMacroStep]

		-- no more elements to add?
		if data == nil then

			-- stop the cycle
			Interface.ImportMacro = nil
			Interface.ImportMacroStep = nil

			-- destroy the warning
			DestroyWindow("ImportMacroWarningDialog")

		else -- we have an action to add

			-- drag the action
			DragSlotSetActionMouseClickData(data.actionType, data.actionId, data.iconId)
		end
	end
end

function Interface.HandleCreateMountMacro(timePassed)
	if Interface.CreateMountMacro ~= nil then
		Interface.MacroWarningDialog()

		if Interface.CreateMountMacroStep > 0 then
			local hotbarId = SystemData.MacroSystem.STATIC_MACRO_ID
			local slot = Interface.CreateMountMacro
			local dropSuccess = DragSlotDropAction(hotbarId, slot, Interface.CreateMountMacroStep)
			if (dropSuccess) then
				if Interface.CreateMountMacroStep == 1 then
					local speechText = L"script MountsList.PickAMount()"
					UserActionSpeechSetText(hotbarId, slot, 1, speechText)
				end
				Interface.CreateMountMacroStep = Interface.CreateMountMacroStep + 1
			end
		end

		if Interface.CreateMountMacroStep == 0 then
			Interface.CreateMountMacroStep = 1
			local index = 57
			local actionData = ActionsWindow.ActionData[index]
			DragSlotSetActionMouseClickData(actionData.type, index, actionData.iconId)
		elseif Interface.CreateMountMacroStep == 2 then
			local index = 11
			local actionData = ActionsWindow.ActionData[index]
			DragSlotSetActionMouseClickData(actionData.type, index, actionData.iconId)
		else
			HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_MACRO_REFERENCE, Interface.CreateMountMacro, 870300, Interface.MountBlockbar,  1)
			Interface.CreateMountMacro = nil
			Interface.CreateMountMacroStep = nil
			DestroyWindow("MountMacroWarningDialog")
		end
	end
end

function Interface.MacroWarningDialog()
	if not DoesWindowExist("MountMacroWarningDialog") then
		local Warning = 
		{
			windowName = "MountMacroWarning",
			titleTid = 281,
			bodyTid  = 282,
			destroyDuplicate = true,
		}
		UO_StandardDialog.CreateDialog(Warning)	
	end
end

function Interface.ImportMacroWarningDialog()
	if not DoesWindowExist("ImportMacroWarningDialog") then
		local Warning = 
		{
			windowName = "ImportMacroWarning",
			titleTid = 281,
			bodyTid  = 309,
			destroyDuplicate = true,
		}
		UO_StandardDialog.CreateDialog(Warning)	
	end
end

function Interface.LoadingFailSafe(timePassed)
	if Interface.TimeSinceLogin > Interface.LoadingFailSafeTimeout and WindowGetShowing("Loading") then
		BroadcastEvent( SystemData.Events.RELOAD_INTERFACE )
	end
end

function Interface.MouseOverItemCheck(timePassed)

	-- is the item under the mouse cursor changed?
	if WindowData.ItemProperties.CurrentHover ~= Interface.LastMouseOverItem then

		-- change the last mouse over item
		Interface.LastMouseOverItem = WindowData.ItemProperties.CurrentHover

		-- trigger the mouse over item changed event
		Interface.OnMouseOverItemChanged(Interface.LastMouseOverItem)
	end
end

Interface.SOSWaypointsCleanerDelta = 0

function Interface.SOSWaypointsCleaner(timePassed)

	-- have the SOS waypoints been initialized?
	if not Interface.SOSWaypointsInitialized or not Interface.SOSWaypoints then
		return
	end

	-- do we have any SOS waypoint?
	if table.countElements(Interface.SOSWaypoints) <= 0 then
		return
	end
	
	-- is it time to cleanup the SOS waypoints?
	if Interface.SOSWaypointsCleanerDelta < 30 then

		-- increase the timer
		Interface.SOSWaypointsCleanerDelta = Interface.SOSWaypointsCleanerDelta + timePassed

		return
	end

	-- reset the timer
	Interface.SOSWaypointsCleanerDelta = 0

	-- initialize the counter of how many SOS has been removed
	local countRemoved = 0

	-- scan all the SOS waypoints
	for sosId, wpData in pairs(Interface.SOSWaypoints) do

		-- does the player still has the SOS in his backpack?
		if not DoesPlayerHaveItem(sosId) then

			-- remove the SOS
			Interface.SOSWaypoints[sosId] = nil

			-- increase the SOS removed counter
			countRemoved = countRemoved + 1
		end
	end

	-- if a waypoint has been removed, we have to update the map
	if countRemoved > 0 then

		-- update the waypoints
		MapCommon.WaypointsDirty = true
	end
end


Interface.TmapWaypointsCleanerDelta = 0

function Interface.TmapWaypointsCleaner(timePassed)

	-- have the Tmap waypoints been initialized?
	if not Interface.TmapWaypointsInitialized or not Interface.TmapWaypoints then
		return
	end

	-- do we have any Tmap waypoint?
	if table.countElements(Interface.TmapWaypoints) <= 0 then
		return
	end
	
	-- is it time to cleanup the Tmap waypoints?
	if Interface.TmapWaypointsCleanerDelta < 30 then

		-- increase the timer
		Interface.TmapWaypointsCleanerDelta = Interface.TmapWaypointsCleanerDelta + timePassed

		return
	end

	-- reset the timer
	Interface.TmapWaypointsCleanerDelta = 0

	-- initialize the counter of how many SOS has been removed
	local countRemoved = 0

	-- scan all the Tmap waypoints
	for TmapId, wpData in pairs(Interface.TmapWaypoints) do

		-- does the player still has the Tmap in his backpack and is not completed?
		if not DoesPlayerHaveItem(TmapId) or ItemProperties.DoesItemHasProperty(TmapId, CourseMapWindow.MapCompletedTID) then

			-- remove the Tmap
			Interface.TmapWaypoints[TmapId] = nil

			-- increase the Tmap removed counter
			countRemoved = countRemoved + 1
		end
	end

	-- if a waypoint has been removed, we have to update the map
	if countRemoved > 0 then

		-- update the waypoints
		MapCommon.WaypointsDirty = true
	end
end

Interface.TODO = {}
function Interface.TODOList(timePassed)
	
	-- EXAMPLE OF RECORD:
	-- Interface.AddTodoList({func = function() end, time = Interface.TimeSinceLogin + 1})

	-- scan all the TODO list
	for i, data in pairsByKeys(Interface.TODO) do

		-- do we have the time?
		if not data.time then

			-- if we don't have the time, this is a bad record, and we remove it.
			Interface.TODO[i] = nil
		end

		-- is the time up?
		if Interface.TimeSinceLogin >= data.time then

			-- execute the function
			pcall(data.func)

			-- remove the record
			Interface.TODO[i] = nil
		end
	end
end

Interface.CheckAvailableEvents = {}
function Interface.CheckAvailableEventsManager(timePassed)
	
	-- if the interface is shutting down we can avoid everything in here
	if Interface.goingDown then
		return
	end

	-- this function will keep checking the condition until is true or until the max time is up.
	-- if the time is up and the condition is not met, it will execute the failCallback
	-- EXAMPLE OF RECORD: (removeOnComplete, maxTime and delay are optional)
	-- Interface.ExecuteWhenAvailable({name = "UNIQUEName", check = function() return true end, callback = function() end, failCallback = function() end, maxTime = Interface.TimeSinceLogin + 1, delay = Interface.TimeSinceLogin + 1, removeOnComplete = true})

	-- scan all the list
	for i, data in pairsByKeys(Interface.CheckAvailableEvents) do

		-- do we have a delay?
		if data.delay and Interface.TimeSinceLogin < data.delay then 
			continue
		end

		-- execute the check function
		local _, verify = pcall(data.check)
 
		-- are the custom condition met?
		if verify then
			
			-- execute the callback
			pcall(data.callback)

			-- do we have to remove the record on complete?
			if data.removeOnComplete then

				-- remove the record
				Interface.CheckAvailableEvents[i] = nil
			end

		-- do we have a time limit?
		elseif data.maxTime and data.maxTime ~= math.huge and Interface.TimeSinceLogin >= data.maxTime then

			-- is there a fail callback?
			if data.failCallback then

				-- execute the failure callback
				pcall(data.failCallback)
			end

			-- remove the record
			Interface.CheckAvailableEvents[i] = nil
		end
	end
end

function Interface.DragWindowHandler(timePassed)

	-- flag that indicates a window is moving
	local somethingmoving = false

	-- scan the movable windows
	for i, window in pairs(Interface.DragWindows) do

		-- is the window moving?
		if WindowGetMoving(window) then

			-- flag that the window is moving
			somethingmoving = true

		else -- remove the window from the list
			table.remove(Interface.DragWindows, i)

			-- is this a gump window?
			if string.find(window, "GenericGump", 1, true) then
				
				-- get the window data
				local _, gumpID = GumpsParsing.GetElementData(window)

				-- is the gump visible?
				if GumpsParsing.ToShow[gumpID] == nil or GumpsParsing.ToShow[gumpID] == true and WindowGetShowing(data.windowName) then

					-- if the gump is not in the opened windows table, we add it
					if not WindowUtils.openWindows["Gump" .. gumpID] then
						WindowUtils.openWindows["Gump" .. gumpID] = true
					end
				
					-- we keep saving the gump position (since we may not be able to do it on shutdown because sometimes we lose the ability to determine the gump ID)
					WindowUtils.SaveWindowPosition(window, false, "Gump" .. gumpID)
				end
			end
		end
	end

	-- store the name of the moving window
	Interface.IsDraggingAWindow = somethingmoving
end

function Interface.PropsTimerHandler(timePassed)

	-- do we have something new unter the mouse cursor?
	if Interface.CurrentItemPropertiesId ~= WindowData.ItemProperties.CurrentHover then

		-- set the mouse is now over na item
		Interface.OnObjectMouseOver(Interface.CurrentItemPropertiesId, WindowData.ItemProperties.CurrentHover)

		-- update the mouse over item ID
		Interface.CurrentItemPropertiesId = WindowData.ItemProperties.CurrentHover
	end

	-- increase the item properties timer
	if ItemProperties.Delta > 0 then
		ItemProperties.Delta = ItemProperties.Delta - timePassed
	end

	-- make the item properties follow the mouse cursor
	ItemProperties.FollowMouse()
end

function Interface.PropsCacheClear(timePassed)
	
	-- are we pointing something ina gump?
	if GenericGump.CurrentOver ~= "" then

		-- update the gump item properties
		ItemProperties.UpdateItemPropertiesData()

	-- are we pointing an item?
	elseif (WindowData.ItemProperties and WindowData.ItemProperties.CurrentHover == 0 and GenericGump.CurrentOver == "") then

		-- reset the item properties array
		ItemProperties.ResetWindowDataPropertiesFull()

		-- reset the item properties window
		ItemProperties.ClearWindow()
	end
end

function Interface.ItemPropertiesFailSafe(timePassed)

	-- increase the item properties timer
	ItemProperties.loadingTime = ItemProperties.loadingTime + timePassed

	-- is the loading time over 5s?
	if ItemProperties.loading and ItemProperties.loadingTime > 5 then

		-- reset the loading flag
		ItemProperties.loading = nil

		-- reset the item properties gump
		ItemProperties.ClearMouseOverItem()
	end
	
	-- is the cursor outside the window is supposed to show the properties?
	if WindowGetShowing("ItemProperties") and (ItemProperties.GetCurrentWindow() ~= SystemData.MouseOverWindow.name and not string.find(SystemData.MouseOverWindow.name, "FreeformView", 1, true)) then
	
		-- reset the loading flag
		ItemProperties.loading = nil

		-- reset the item properties gump
		ItemProperties.ClearMouseOverItem()
	end
	
	-- is the mouse over item changed?
	if WindowGetShowing("ItemProperties") and WindowData.ItemProperties.CurrentType == WindowData.ItemProperties.TYPE_ITEM and ItemProperties.GetShowingId() ~= WindowData.ItemProperties.CurrentHover then
	
		-- reset the item properties gump
		ItemProperties.ClearMouseOverItem()
	end

	-- do we have the properties but the window is in movement?
	if WindowGetShowing("ItemProperties") and ItemProperties.CurrentItemData.windowName and (WindowGetMoving(ItemProperties.CurrentItemData.windowName) or WindowGetMoving(WindowGetParent(ItemProperties.CurrentItemData.windowName))) then
	
		-- reset the item properties gump
		ItemProperties.ClearMouseOverItem()
	end
end

function Interface.UpdateWarButton(timePassed)
	
	-- is war mode active?
	if WindowData.PlayerStatus.InWarMode then

		-- store the war mode flag
        Actions.WarMode = 1       

		-- is the war/peace shield visible?
		if DoesWindowExist("WarButton") then

			-- set the war button as pressed
			ButtonSetPressedFlag("WarButton", true)
		end

    else -- war mode off

		-- store the war mode flag
        Actions.WarMode = 0

		-- is the war/peace shield visible?
		if DoesWindowExist("WarButton") then

			-- set the war button as unpressed
			ButtonSetPressedFlag("WarButton", false)
		end
    end
end

function Interface.MobileArrowManager(timePassed)
	
	-- mobile arrow window name
	local windowName = "MobileArrow"

	-- update the mobile arrow over ID
	Interface.MobileArrowOver = MobileHealthBar.mouseOverId

	-- is the mobile arrow inactive and the window is nowhere to be found?
	if Interface.MobileArrowOver == 0 and not DoesWindowExist(windowName) then
		return
	end

	-- if the mobile is no longer in sight, we destroy the arrow
	if not IsMobileVisible(Interface.MobileArrowOver) then
		
		-- destroy the mobile arrow
		Interface.DestroyMobileArrow()

		return
	end
	
	-- is the mobile arrow active?
	if Interface.Settings.EnableMobileArrow then

		-- by deafault the arrow has no ID (if it doesn't exist)
		local currentArrowOver = 0
		
		-- get the ID currently attached to the mobile arrow (if the arrow is already around)
		if DoesWindowExist(windowName) then
			currentArrowOver = WindowGetId(windowName)
		end
		
		-- is the mobile arrow ID changed or the arrow is not visible (out of screen)?
		if currentArrowOver ~= Interface.MobileArrowOver or not WindowGetShowing(windowName) then

			-- destroy the mobile arrow
			Interface.DestroyMobileArrow()
		end

		-- do we have an invalid ID or the player ID?
		if not IsValidID(Interface.MobileArrowOver) or Interface.MobileArrowOver == GetPlayerID() then

			-- destroy the mobile arrow
			Interface.DestroyMobileArrow()

			-- reset the mouse over ID
			Interface.MobileArrowOver = 0

			-- we can get out now
			return
		end
		
		-- create the mobile arrow
		Interface.CreateMobileArrow(Interface.MobileArrowOver)

	else -- mobile arrow disabled, make sure is destroyed
		Interface.DestroyMobileArrow()

		-- reset the mouse over ID
		Interface.MobileArrowOver = 0
	end
end


function Interface.SpecialMovesManaCooldown(timePassed)
	if Interface.LastSpecialMoveTime >= 0 then
		Interface.LastSpecialMoveTime = Interface.LastSpecialMoveTime - timePassed
	end
	if EquipmentData.ActiveAbility then
		EquipmentData.ActivateAbility()
		CharacterAbilities.ActivateWeaponAbility()
	end
end

function Interface.LoginTimeoutCheck(timePassed)
	if (DoesWindowExist("LogOutWarningDialog")) then
		local time = Interface.CanLogout - Interface.TimeSinceLogin
		if (time > 0) then
			local min = math.floor(time/60)
			if min > 0 then

				timer = towstring(tostring(min)	.. " minute")
				local sec = math.floor(time - (min * 60))
				timer = timer .. L" and " .. towstring(tostring(sec)	.. " seconds")
			else
				timer = towstring(tostring(math.floor(time))	.. " seconds")
			end
			LabelSetText("LogOutWarningDialogNormalText", ReplaceTokens(GetStringFromTid(1155273), {timer}))
		else
			BroadcastEvent( SystemData.Events.LOG_OUT )
		end
	end
end

Interface.RestartTime = 0
function Interface.RestartTimeoutCheck(timePassed)
	if (DoesWindowExist("RestartWarningDialog")) then
		local time = Interface.RestartTime - Interface.TimeSinceLogin
		if (time > 0) then
			local min = math.floor(time/60)
			if min > 0 then

				timer = towstring(tostring(min)	.. " minute")
				local sec = math.floor(time - (min * 60))
				timer = timer .. L" and " .. towstring(tostring(sec)	.. " seconds")
			else
				timer = towstring(tostring(math.floor(time))	.. " seconds")
			end
			LabelSetText("RestartWarningDialogNormalText",ReplaceTokens(GetStringFromTid(299), {timer}))
		else
			BroadcastEvent( SystemData.Events.EXIT_GAME )
		end
	end
end

function Interface.UpdateLatency(timePassed)
	Interface.LatencyDelta = Interface.LatencyDelta + timePassed
	if Interface.LatencyDelta >= 2 then
		local shardLatency, packetLoss = GetShardPingInfo(UserData.Settings.Login.lastShardSelected)
		Interface.Latency = {lag=shardLatency, ploss=packetLoss}
		StatusWindow.UpdateLatency()
		Interface.LatencyDelta = 0
	end
end

function Interface.Cooldowns(timePassed)
	if HotbarSystem.GrapeDelayTime > 0 then
		HotbarSystem.GrapeDelayTime = HotbarSystem.GrapeDelayTime - timePassed
	end
	if HotbarSystem.AppleDelayTime > 0 then
		HotbarSystem.AppleDelayTime = HotbarSystem.AppleDelayTime - timePassed
	end
	if HotbarSystem.HealPotDelayTime > 0 then
		HotbarSystem.HealPotDelayTime = HotbarSystem.HealPotDelayTime - timePassed
	end
	if HotbarSystem.BandageDelayTime > 0 then
		HotbarSystem.BandageDelayTime = HotbarSystem.BandageDelayTime - timePassed
	end
	if HotbarSystem.StunTime > 0 then
		HotbarSystem.StunTime = HotbarSystem.StunTime - timePassed
	end
	if HotbarSystem.EvasionCooldown > 0 then
		HotbarSystem.EvasionCooldown = HotbarSystem.EvasionCooldown - timePassed
	end
	if HotbarSystem.AttunementCooldown > 0 then
		HotbarSystem.AttunementCooldown = HotbarSystem.AttunementCooldown - timePassed
	end
	if HotbarSystem.EtherealVoyageCooldown > 0 then
		HotbarSystem.EtherealVoyageCooldown = HotbarSystem.EtherealVoyageCooldown - timePassed
	end
	if HotbarSystem.ReflectionCooldown > 0 then
		HotbarSystem.ReflectionCooldown = HotbarSystem.ReflectionCooldown - timePassed
	end

	if Spellbook.MasteryChangeCooldown and Spellbook.MasteryChangeCooldown > 0 then
		Spellbook.MasteryChangeCooldown = Spellbook.MasteryChangeCooldown - timePassed
	end

	if HotbarSystem.CalledShotCooldown and HotbarSystem.CalledShotCooldown > 0 then
		HotbarSystem.CalledShotCooldown = HotbarSystem.CalledShotCooldown - timePassed
	end

	if HotbarSystem.PlayingTheOddsCooldown and HotbarSystem.PlayingTheOddsCooldown > 0 then
		HotbarSystem.PlayingTheOddsCooldown = HotbarSystem.PlayingTheOddsCooldown - timePassed
	end

	if HotbarSystem.WhisperingCooldown and HotbarSystem.WhisperingCooldown > 0 then
		HotbarSystem.WhisperingCooldown = HotbarSystem.WhisperingCooldown - timePassed
	end

	if HotbarSystem.EtherealBurstCooldown and HotbarSystem.EtherealBurstCooldown > 0 then
		HotbarSystem.EtherealBurstCooldown = HotbarSystem.EtherealBurstCooldown - timePassed
	end

	if HotbarSystem.RejuvenateCooldown and HotbarSystem.RejuvenateCooldown > 0 then
		HotbarSystem.RejuvenateCooldown = HotbarSystem.RejuvenateCooldown - timePassed
	end

	if HotbarSystem.FlamingShotCooldownStop then
		HotbarSystem.FlamingShotCooldown = 0
		HotbarSystem.FlamingShotCooldownStop = false
	elseif HotbarSystem.FlamingShotCooldown and HotbarSystem.FlamingShotCooldown > 0 then
		HotbarSystem.FlamingShotCooldown = HotbarSystem.FlamingShotCooldown - timePassed
	end

	if HotbarSystem.WarcryCooldown and HotbarSystem.WarcryCooldown > 0 then
		HotbarSystem.WarcryCooldown = HotbarSystem.WarcryCooldown - timePassed
	end

	if HotbarSystem.SkillDelayTime > 0 then
		HotbarSystem.SkillDelayTime = HotbarSystem.SkillDelayTime - timePassed
	end
end

function Interface.TargetProtectionManager(timePassed)

	-- do we have the target?
	if not DoesPlayerHasCursorTarget() then
		return
	end
	
	-- target protection data window
	local tpdWindow = "TargetProtectionData"

	-- does the target protection window already exist?
	if not DoesWindowExist(tpdWindow) then

		-- create the target protection window
		CreateWindow(tpdWindow, true)

		-- do we have a protected last spell?
		if Interface.ProtectedLastSpell then

			-- get the spell max distance
			local spellDistance = SpellsInfo.GetSpellDistance(Interface.ProtectedLastSpell) or L"?"

			-- get the spell TID
			local _, _, tid  = GetAbilityData(Interface.ProtectedLastSpell)

			-- get the spell name
			local nameText = ReplaceTokens(GetStringFromTid(521), { GetStringFromTid(tid), towstring(spellDistance) })

			-- set the spell name into the label
			LabelSetText(tpdWindow .. "Name", nameText)
	
		-- do we have a protected last skill?
		elseif Interface.LastSkillProtected then

			-- do we need to target an instrument?
			if TextParsing.InstrumentCheck then

				-- set the spell name into the label
				LabelSetText(tpdWindow .. "Name", GetStringFromTid(522))
			
			else
				-- get the skill max distance
				local skillDistance = SkillsWindow.GetSkillDistance(Interface.LastSkillProtected) or L"?"

				-- get the skill TID
				local tid = GetSkillTID(Interface.LastSkillProtected)

				-- get the spell name
				local nameText = ReplaceTokens(GetStringFromTid(521), { GetStringFromTid(tid), towstring(skillDistance) })

				-- set the spell name into the label
				LabelSetText(tpdWindow .. "Name", nameText)
			end
		end
	end
	
	-- do we have a valid protected last spell or skill?
	if Interface.ProtectedLastSpell or Interface.LastSkillProtected then

		-- is the player pointing a healthbar?
		if IsValidID(MobileHealthBar.mouseOverId) then

			-- for animal lore, the invulnerable target are ok as long as they are creatures
			local anilException = Interface.LastSkillProtected and Interface.LastSkillProtected == SkillsWindow.SkillsID.ANIMAL_LORE and not DoesBodyHasPaperdoll(MobileHealthBar.mouseOverId)
			
			-- INVALID TARGET
			if (IsMobileInvulnerable(MobileHealthBar.mouseOverId) and not anilException) or (Interface.ProtectedLastSpell and SpellsInfo.TargetObjectSpells[Interface.ProtectedLastSpell] and IsMobile(MobileHealthBar.mouseOverId)) then

				-- start the blinking animation
				if not Interface.TargetProtectionDataBlink then
					WindowStartAlphaAnimation(tpdWindow .. "RangeCheck", Window.AnimationType.LOOP, 1, 0.2, 0.2, false, 0, 0)

					-- add the blinking flag
					Interface.TargetProtectionDataBlink = true
				end

				-- set the text to OUT OF RANGE
				LabelSetText(tpdWindow .. "RangeCheck", GetStringFromTid(526))

				-- set the text to red
				LabelSetTextColor(tpdWindow .. "RangeCheck", 255, 0, 0)

			-- is the target acceptable?
			elseif Interface.CheckTarget(MobileHealthBar.mouseOverId) then
			
				-- stop the blinking animation
				WindowStopAlphaAnimation(tpdWindow .. "RangeCheck")

				-- remove the blink flag
				Interface.TargetProtectionDataBlink = nil

				-- set the text to LOCKED
				LabelSetText(tpdWindow .. "RangeCheck", GetStringFromTid(523))

				-- set the text to green
				LabelSetTextColor(tpdWindow .. "RangeCheck", 0, 255, 0)

			else -- out of range

				-- start the blinking animation
				if not Interface.TargetProtectionDataBlink then
					WindowStartAlphaAnimation(tpdWindow .. "RangeCheck", Window.AnimationType.LOOP, 1, 0.2, 0.2, false, 0, 0)
					
					-- add the blinking flag
					Interface.TargetProtectionDataBlink = true
				end

				-- set the text to OUT OF RANGE
				LabelSetText(tpdWindow .. "RangeCheck", GetStringFromTid(525))

				-- set the text to red
				LabelSetTextColor(tpdWindow .. "RangeCheck", 255, 0, 0)
			end

		-- is the player pointing a overhead name/bar?
		elseif IsValidID(OverheadText.mouseOverId) then

			-- for animal lore, the invulnerable target are ok as long as they are creatures
			local anilException = Interface.LastSkillProtected and Interface.LastSkillProtected == SkillsWindow.SkillsID.ANIMAL_LORE and not DoesBodyHasPaperdoll(OverheadText.mouseOverId)

			-- INVALID TARGET
			if (IsMobileInvulnerable(OverheadText.mouseOverId) and not anilException) or (Interface.ProtectedLastSpell and SpellsInfo.TargetObjectSpells[Interface.ProtectedLastSpell] and IsMobile(OverheadText.mouseOverId)) then

				-- start the blinking animation
				if not Interface.TargetProtectionDataBlink then
					WindowStartAlphaAnimation(tpdWindow .. "RangeCheck", Window.AnimationType.LOOP, 1, 0.2, 0.2, false, 0, 0)
					
					-- add the blinking flag
					Interface.TargetProtectionDataBlink = true
				end

				-- set the text to OUT OF RANGE
				LabelSetText(tpdWindow .. "RangeCheck", GetStringFromTid(526))

				-- set the text to red
				LabelSetTextColor(tpdWindow .. "RangeCheck", 255, 0, 0)

			-- is the target acceptable?
			elseif Interface.CheckTarget(OverheadText.mouseOverId) then
			
				-- stop the blinking animation
				WindowStopAlphaAnimation(tpdWindow .. "RangeCheck")

				-- remove the blink flag
				Interface.TargetProtectionDataBlink = nil

				-- set the text to LOCKED
				LabelSetText(tpdWindow .. "RangeCheck", GetStringFromTid(523))

				-- set the text to green
				LabelSetTextColor(tpdWindow .. "RangeCheck", 0, 255, 0)

			else -- out of range

				-- start the blinking animation
				if not Interface.TargetProtectionDataBlink then
					WindowStartAlphaAnimation(tpdWindow .. "RangeCheck", Window.AnimationType.LOOP, 1, 0.2, 0.2, false, 0, 0)
					
					-- add the blinking flag
					Interface.TargetProtectionDataBlink = true
				end

				-- set the text to OUT OF RANGE
				LabelSetText(tpdWindow .. "RangeCheck", GetStringFromTid(525))

				-- set the text to red
				LabelSetTextColor(tpdWindow .. "RangeCheck", 255, 0, 0)
			end

		-- is the player pointing a object handle?
		elseif IsValidID(ObjectHandleWindow.mouseOverId) then

			-- for animal lore, the invulnerable target are ok as long as they are creatures
			local anilException = Interface.LastSkillProtected and Interface.LastSkillProtected == SkillsWindow.SkillsID.ANIMAL_LORE and not DoesBodyHasPaperdoll(ObjectHandleWindow.mouseOverId)

			-- INVALID TARGET
			if (IsMobileInvulnerable(ObjectHandleWindow.mouseOverId) and not anilException) or (Interface.ProtectedLastSpell and SpellsInfo.TargetObjectSpells[Interface.ProtectedLastSpell] and IsMobile(ObjectHandleWindow.mouseOverId)) then

				-- start the blinking animation
				if not Interface.TargetProtectionDataBlink then
					WindowStartAlphaAnimation(tpdWindow .. "RangeCheck", Window.AnimationType.LOOP, 1, 0.2, 0.2, false, 0, 0)
					
					-- add the blinking flag
					Interface.TargetProtectionDataBlink = true
				end

				-- set the text to OUT OF RANGE
				LabelSetText(tpdWindow .. "RangeCheck", GetStringFromTid(526))

				-- set the text to red
				LabelSetTextColor(tpdWindow .. "RangeCheck", 255, 0, 0)

			-- is the target acceptable?
			elseif Interface.CheckTarget(ObjectHandleWindow.mouseOverId) then
			
				-- stop the blinking animation
				WindowStopAlphaAnimation(tpdWindow .. "RangeCheck")

				-- remove the blink flag
				Interface.TargetProtectionDataBlink = nil

				-- set the text to LOCKED
				LabelSetText(tpdWindow .. "RangeCheck", GetStringFromTid(523))

				-- set the text to green
				LabelSetTextColor(tpdWindow .. "RangeCheck", 0, 255, 0)

			else -- out of range

				-- start the blinking animation
				if not Interface.TargetProtectionDataBlink then
					WindowStartAlphaAnimation(tpdWindow .. "RangeCheck", Window.AnimationType.LOOP, 1, 0.2, 0.2, false, 0, 0)
					
					-- add the blinking flag
					Interface.TargetProtectionDataBlink = true
				end

				-- set the text to OUT OF RANGE
				LabelSetText(tpdWindow .. "RangeCheck", GetStringFromTid(525))

				-- set the text to red
				LabelSetTextColor(tpdWindow .. "RangeCheck", 255, 0, 0)
			end

		-- is the player pointing something else (in general)?
		elseif IsValidID(WindowData.ItemProperties.CurrentHover) or IsValidID(ItemProperties.GetShowingId()) then
		
			-- for animal lore, the invulnerable target are ok as long as they are creatures
			local anilException = Interface.LastSkillProtected and Interface.LastSkillProtected == SkillsWindow.SkillsID.ANIMAL_LORE and not DoesBodyHasPaperdoll(WindowData.ItemProperties.CurrentHover)
			
			-- INVALID TARGET
			if (IsMobileInvulnerable(WindowData.ItemProperties.CurrentHover) and not anilException) or (IsMobileInvulnerable(ItemProperties.GetShowingId()) and not anilException) or (Interface.ProtectedLastSpell and SpellsInfo.TargetObjectSpells[Interface.ProtectedLastSpell] and (IsMobile(WindowData.ItemProperties.CurrentHover) or IsMobile(ItemProperties.GetShowingId()))) then

				-- start the blinking animation
				if not Interface.TargetProtectionDataBlink then
					WindowStartAlphaAnimation(tpdWindow .. "RangeCheck", Window.AnimationType.LOOP, 1, 0.2, 0.2, false, 0, 0)
					
					-- add the blinking flag
					Interface.TargetProtectionDataBlink = true
				end

				-- set the text to OUT OF RANGE
				LabelSetText(tpdWindow .. "RangeCheck", GetStringFromTid(526))

				-- set the text to red
				LabelSetTextColor(tpdWindow .. "RangeCheck", 255, 0, 0)

			-- is the target acceptable?
			elseif Interface.CheckTarget(WindowData.ItemProperties.CurrentHover) or Interface.CheckTarget(ItemProperties.GetShowingId()) then
			
				-- stop the blinking animation
				WindowStopAlphaAnimation(tpdWindow .. "RangeCheck")
				
				-- remove the blink flag
				Interface.TargetProtectionDataBlink = nil

				-- set the text to LOCKED
				LabelSetText(tpdWindow .. "RangeCheck", GetStringFromTid(523))

				-- set the text to green
				LabelSetTextColor(tpdWindow .. "RangeCheck", 0, 255, 0)

			else -- out of range
	
				-- start the blinking animation
				if not Interface.TargetProtectionDataBlink then
					WindowStartAlphaAnimation(tpdWindow .. "RangeCheck", Window.AnimationType.LOOP, 1, 0.2, 0.2, false, 0, 0)
					
					-- add the blinking flag
					Interface.TargetProtectionDataBlink = true
				end

				-- set the text to OUT OF RANGE
				LabelSetText(tpdWindow .. "RangeCheck", GetStringFromTid(525))

				-- set the text to red
				LabelSetTextColor(tpdWindow .. "RangeCheck", 255, 0, 0)
			end

		else 
			-- stop the blinking animation
			WindowStopAlphaAnimation(tpdWindow .. "RangeCheck")

			-- remove the blink flag
			Interface.TargetProtectionDataBlink = nil

			-- set the text to SCANNING
			LabelSetText(tpdWindow .. "RangeCheck", GetStringFromTid(524))

			-- set the text to yellow
			LabelSetTextColor(tpdWindow .. "RangeCheck", 255, 255, 0)
		end
	end

	-- move the castbar under the mouse cursor
	WindowUtils.FollowMouseCursor(tpdWindow, 220, 60, 0, 20, false, false, false)
end
	
Interface.SpellRecovery = 0
function Interface.SpellsTimer(timePassed)
	local SpellSpeed = Interface.CurrentSpell
	if SpellSpeed.casting then
		SpellSpeed.ActualSpeed = SpellSpeed.ActualSpeed + timePassed
		if (SpellSpeed.casting and SpellSpeed.ActualSpeed > SpellSpeed.UnlaggedSpeed * 5) then
			SpellSpeed.casting = false
			SpellSpeed.ready =true
			Interface.SpellRecovery = SpellsInfo.GetRecoverySpeed()
			Interface.OnSpellCastedSuccessfully(Interface.CurrentSpell.SpellId)
		end
		if (SpellSpeed.ActualSpeed > SpellSpeed.UnlaggedSpeed) then
			Interface.OnSpellCastedSuccessfully(Interface.CurrentSpell.SpellId)
			SpellSpeed.IsSpell = false
			SpellSpeed.ready =false
			SpellSpeed.UnlaggedSpeed = 0
			SpellSpeed.ActualSpeed = 0
			SpellSpeed.casting = false
			SpellSpeed.SpellId = 0
			Interface.SpellRecovery = SpellsInfo.GetRecoverySpeed()
			return
		end
		if (SpellSpeed.CheckFizzle) then
			Interface.OnSpellCastFailed(SpellSpeed.SpellId )
			SpellSpeed.IsSpell = false
			SpellSpeed.ready =false
			SpellSpeed.UnlaggedSpeed = 0
			SpellSpeed.ActualSpeed = 0
			SpellSpeed.casting = false
			SpellSpeed.SpellId = 0
			Interface.SpellRecovery = SpellsInfo.GetRecoverySpeed()
			CastBarWindow.CurrentTime = 0
			CastBarWindow.UnlagTime = 0
			CastBarWindow.Blinking = false
			WindowStopAlphaAnimation("CastBarWindow")
			WindowSetShowing("CastBarWindow", false)
			return
		end
		if DoesPlayerHasCursorTarget() then
			Interface.OnSpellCastedSuccessfully(Interface.CurrentSpell.SpellId)
			SpellSpeed.IsSpell = false
			SpellSpeed.ready =false
			SpellSpeed.UnlaggedSpeed = 0
			SpellSpeed.ActualSpeed = 0
			SpellSpeed.casting = false
			SpellSpeed.SpellId = 0
			CastBarWindow.CurrentTime = 0
			CastBarWindow.UnlagTime = 0
		end
	elseif  Interface.SpellRecovery > 0 then
		Interface.SpellRecovery = Interface.SpellRecovery - timePassed
	end
	CharacterAbilities.UpdateWeaponAbilities()
end

function Interface.ShopChecker(timePassed)
	
	-- should there be the shop active?
	if GenericGump.NextisShop and GenericGump.shoptime and GenericGump.shoptime < Interface.TimeSinceLogin then

		-- is the shop gump open?
		if GenericGump.IsShopGump() then

			-- check again in 1 second
			GenericGump.shoptime = Interface.TimeSinceLogin + 1

		else -- the shop gump is closed
			GenericGump.NextisShop = nil
			GenericGump.shoptime = nil
			GumpsParsing.ShopWindow = ""

			-- toggle the last gump visibility
			WindowSetShowing(GenericGump.LastGump, GumpsParsing.VvVGump == windowName)
		end
	end
end

function Interface.MainMenuChecker(timePassed)
	
	-- is the main menu visible while it shouldn't?
	if WindowGetShowing("MainMenuWindow") and MainMenuWindow.notnow then

		-- reset the flag to hide the main menu
		MainMenuWindow.notnow = nil

		-- hide the main menu
		WindowSetShowing("MainMenuWindow", false)
	end
end

Interface.chatFixed = false
function Interface.ChatFixer(timePassed)
	
	if not NewChatWindow and not Interface.chatFixed then
		return
	end

	if Interface.started then
		if not NewChatWindow.Initialized then			
			 pcall(NewChatWindow.Initialize)
		end
	end

	local dialog

	for windowName, _ in pairs(UO_StandardDialog.DialogData) do
		dialog = windowName
		break
	end

	-- press ok on dialogs on enter
	if WindowHasFocus("ChatWindowContainerTextInput") and dialog ~= nil then
		SystemData.ActiveWindow.name = dialog
		UO_StandardDialog.OnKeyEnter()
		NewChatWindow.CloseChatBox()
	end

	-- is the chat line focused?
	if WindowHasFocus("ChatWindowContainerTextInput") then

		-- scan all the enter callbacks we have
		for windowName, func in pairs(Interface.OnKeyEnterCallback) do
		
			-- if at least one of this windows are visible, we trigger the callback here
			if WindowGetShowing(windowName) then

				-- execute the enter keypress
				Interface.EnterPressed()
						
				-- close the chat box
				NewChatWindow.CloseChatBox()

				break
			end
		end
	end

	--Debug.Print("CHAT FIXER")
	ChatWindow.OnKeyEnter = NewChatWindow.OnKeyEnter
	ChatWindow.OnKeyTab = NewChatWindow.OnKeyTab
	ChatWindow.OnKeyEscape = NewChatWindow.OnKeyEscape

	ChatWindow.DoChatTextReplacement = NewChatWindow.DoChatTextReplacement
	ChatWindow.ResetTextBox = NewChatWindow.ChatWindowResetTextBox
	ChatWindow.SwitchChannelWithExistingText = NewChatWindow.ChatWindowSwitchChannelWithExistingText
	if (WindowGetShowing("NewChatWindow")) then
		WindowSetShowing("ChatWindowInputTextButton", false)
		if (DoesWindowExist("NewChatWindowInputTextButton")) then
			WindowSetShowing("NewChatWindowInputTextButton", true)
		else
			CreateWindow("NewChatWindowInputTextButton", true)
			WindowClearAnchors("NewChatWindowInputTextButton")
			WindowAddAnchor("NewChatWindowInputTextButton", "bottomleft", "ResizeWindow", "bottomleft", 0, -6)
		end

		if (DoesWindowExist("NewChatWindowContactstButton")) then
			WindowSetShowing("NewChatWindowContactstButton", true)
		else
			CreateWindow("NewChatWindowContactstButton", true)
			WindowClearAnchors("NewChatWindowContactstButton")
			WindowAddAnchor("NewChatWindowContactstButton", "right", "NewChatWindowInputTextButton", "left", 0, 0)
		end

		for key, wnd in pairs(ChatWindow.Windows) do
			WindowSetShowing(wnd.wndName, not WindowGetShowing("NewChatWindow"))
		end
		
		if (ChatWindowContainerTextInput.TextUpdated == true) then
			NewChatWindow.DoChatTextReplacement ()
			-- Make sure to reset the var because we handled this update
			ChatWindowContainerTextInput.TextUpdated = false
		end
	else
		WindowSetShowing("ChatWindowInputTextButton", true)
	end
	
	if (DoesWindowExist("ChatWindow") and not ChatWindow.Settings.autohide) then
		for idxW, wnd in pairs(ChatWindow.Windows) do
			ChatWindow.PerformFadeIn(idxW)
		end
	end
    
	if (Interface.Settings.chat_lockChatLine) then
		if (DoesWindowExist("ChatWindowInputTextButton")) then
			WindowClearAnchors("ChatWindowInputTextButton")
			WindowAddAnchor("ChatWindowInputTextButton", "bottomleft", "ResizeWindow", "bottomleft", 0, -6)
			if (DoesWindowExist("NewChatWindowInputTextButton")) then
				WindowClearAnchors("NewChatWindowInputTextButton")
				WindowAddAnchor("NewChatWindowInputTextButton", "bottomleft", "ResizeWindow", "bottomleft", 0, -6)
			end
		end
		if (DoesWindowExist("ChatWindowContainer")) then
			WindowClearAnchors("ChatWindowContainer")
			if (WindowGetShowing("NewChatWindow")) then
				WindowAddAnchor("ChatWindowContainer", "bottomleft", "NewChatWindowContactstButton", "bottomleft", 32, 5)
			else
				WindowAddAnchor("ChatWindowContainer", "bottomleft", "ChatWindowInputTextButton", "bottomleft", 25, 5)
			end
			WindowAddAnchor("ChatWindowContainer", "bottomright", "ResizeWindow", "bottomright", -50, 0)
		end
		if (DoesWindowExist("ChatWindowContainerTextInput")) then
			WindowClearAnchors("ChatWindowContainerTextInput")
			local x, y = WindowGetDimensions( "ChatWindowContainerChannelLabel" )
			WindowAddAnchor("ChatWindowContainerTextInput", "bottomleft", "ChatWindowContainerChannelLabel", "bottomleft", x + 5, -4)
			WindowAddAnchor("ChatWindowContainerTextInput", "bottomright", "ChatWindowContainer", "bottomright", 0, 0)
			WindowSetLayer("ChatWindowContainerTextInput", Window.Layers.BACKGROUND	)
		end
	elseif (Interface.Settings.chat_lockChatLineDown) then
		if (DoesWindowExist("ChatWindowInputTextButton")) then
			WindowClearAnchors("ChatWindowInputTextButton")
			WindowAddAnchor("ChatWindowInputTextButton", "bottomleft", "ResizeWindow", "topleft", 0, 6)
			if (DoesWindowExist("NewChatWindowInputTextButton")) then
				WindowClearAnchors("NewChatWindowInputTextButton")
				WindowAddAnchor("NewChatWindowInputTextButton", "bottomleft", "ResizeWindow", "topleft", 0, 0)
			end
		end
		if (DoesWindowExist("ChatWindowContainer")) then
			WindowClearAnchors("ChatWindowContainer")
			if (WindowGetShowing("NewChatWindow")) then
				WindowAddAnchor("ChatWindowContainer", "bottomleft", "NewChatWindowContactstButton", "bottomleft", 32, 5)
			else
				WindowAddAnchor("ChatWindowContainer", "bottomleft", "ChatWindowInputTextButton", "bottomleft", 25, 5)
			end
			WindowAddAnchor("ChatWindowContainer", "bottomright", "ResizeWindow", "bottomright", -50, 0)
		end
		if (DoesWindowExist("ChatWindowContainerTextInput")) then
			WindowClearAnchors("ChatWindowContainerTextInput")
			local x, y = WindowGetDimensions( "ChatWindowContainerChannelLabel" )
			WindowAddAnchor("ChatWindowContainerTextInput", "bottomleft", "ChatWindowContainerChannelLabel", "bottomleft", x + 5, -4)
			WindowAddAnchor("ChatWindowContainerTextInput", "bottomright", "ChatWindowContainer", "bottomright", 0, 0)
			WindowSetLayer("ChatWindowContainerTextInput", Window.Layers.BACKGROUND	)
		end
	elseif (WindowGetShowing("NewChatWindow")) then
		WindowClearAnchors("NewChatWindowInputTextButton")
		WindowAddAnchor("NewChatWindowInputTextButton", "bottomleft", "NewChatWindow", "bottomleft", 0, 38)
		if (DoesWindowExist("ChatWindowContainer")) then
			WindowClearAnchors("ChatWindowContainer")
			WindowAddAnchor("ChatWindowContainer", "bottomleft", "NewChatWindow", "bottomleft", 64, 38)
			WindowAddAnchor("ChatWindowContainer", "bottomright", "NewChatWindow", "bottomright", 0, 38)
		end
		if (DoesWindowExist("ChatWindowContainerTextInput")) then
			WindowClearAnchors("ChatWindowContainerTextInput")
			local x, y = WindowGetDimensions( "ChatWindowContainerChannelLabel" )
			WindowAddAnchor("ChatWindowContainerTextInput", "bottomleft", "ChatWindowContainerChannelLabel", "bottomleft", x + 5, -4)
			WindowAddAnchor("ChatWindowContainerTextInput", "bottomright", "ChatWindowContainer", "bottomright", 0, 0)
			WindowSetLayer("ChatWindowContainerTextInput", Window.Layers.BACKGROUND	)
		end
	end
	Interface.chatFixed = WindowGetShowing("NewChatWindow")
end

function Interface.HealthbarProtectionSystem(timePassed)
	
	-- is the mobile list active with the overhead bars?
	if MobileBarsDockspot.GetMobilesDockspotStatus() and Interface.Settings.HoverbarsActive then

		-- disable overhead bars
		Interface.Settings.HoverbarsActive = false

		-- save the setting
		Interface.SaveSetting( "HoverbarsActive", Interface.Settings.HoverbarsActive )

		-- update settings window (if it's open)
		SettingsWindow.UpdateSettings()
	end
end


function Interface.ClockUpdater(timePassed)

	if not Interface.Clock then
		Interface.Clock = {}
	end

	Interface.Clock.Timestamp, Interface.Clock.YYYY, Interface.Clock.MM, Interface.Clock.DD, Interface.Clock.h, Interface.Clock.m, Interface.Clock.s  = GetCurrentDateTime()
	
	-- fix the months count (starts with 0) and years count (0 = 1900)
	Interface.Clock.MM = Interface.Clock.MM + 1
	Interface.Clock.YYYY = 1900 + Interface.Clock.YYYY

	if DoesWindowExist("ClockWindow") then
		pcall(ClockWindow.Update, timePassed)
	end
end

function Interface.EscapePressed()

	-- if this happens after 1 second we don't care
	if Interface.CanceledCursorTime > Interface.TimeSinceLogin or DoesPlayerHasCursorTarget()  then

		-- was the flaming shot?
		if Interface.LastSpell == 723 then
			HotbarSystem.FlamingShotCooldownStop = true
		end
	end

	-- do we have the current target active?
	if WindowData.CurrentTarget.HasTarget and not DoesPlayerHasCursorTarget() then

		-- remove the current target
		ClearCurrentTarget()

		-- is the target window still visible?
		if WindowGetShowing("TargetWindow") then
		
			-- clear the previous target
			TargetWindow.ClearPreviousTarget()

			-- flag that we don't have a target anymore
			WindowData.CurrentTarget.HasTarget = false
		end

		-- prevent the main menu from opening
		MainMenuWindow.notnow = true
	end

	-- scan all the escape callbacks we have
	for windowName, func in pairs(Interface.OnKeyEscapeCallback) do
		
		-- does the window exist?
		if not DoesWindowExist(windowName) then

			-- remove the window from the table
			Interface.OnKeyEscapeCallback[windowName] = nil

			continue
		end

		-- is the window visible?
		if WindowGetShowing(windowName) then
			
			-- execute the callback
			pcall(func, windowName)

			-- we execute only 1 at time
			break
		end
	end
end

function Interface.EnterPressed()

	-- scan all the enter callbacks we have
	for windowName, func in pairs(Interface.OnKeyEnterCallback) do
		
		-- does the window exist?
		if not DoesWindowExist(windowName) then

			-- remove the window from the table
			Interface.OnKeyEnterCallback[windowName] = nil

			continue
		end

		-- is the window visible?
		if WindowGetShowing(windowName) then

			-- execute the callback
			pcall(func, windowName)

			-- we execute only 1 at time
			break
		end
	end
end

Interface.CursorTarget = false
Interface.CanceledCursorTime = 0

function Interface.GumpTargetDragBank(timePassed)

	-- do we have to target the dragged item?
	if not GenericGump.TargetDrag then
		return
	end

	-- phse 1
	if GenericGump.TargetDrag == 1 then

		-- store the item ID
		GenericGump.DraggedItem = SystemData.DragItem.itemId

		-- default button ID to deposit items
		local buttonIndex = 8

		-- is the item gold coins?
		if SystemData.DragItem.itemType == 3821 then
			buttonIndex = 7
		end

		-- click the gump button to get the target
		GumpsParsing.PressButton(GenericGump.BANK_ACTIONS_GUMPID, buttonIndex)

		-- drop the item inside the backpack
		DragSlotDropObjectToContainer(ContainerWindow.PlayerBackpack, 0)

		-- target the item we tried to release (phase 2: click the item)
		GenericGump.TargetDrag = 2

	-- phse 2
	elseif GenericGump.TargetDrag == 2 and DoesPlayerHaveItem(GenericGump.DraggedItem) and DoesPlayerHasCursorTarget() then

		-- target the item
		HandleSingleLeftClkTarget(GenericGump.DraggedItem)

		-- target the item we tried to release (phase 3: remove the cursor target)
		GenericGump.TargetDrag = 3

	-- phase 3
	elseif GenericGump.TargetDrag == 3 and DoesPlayerHasCursorTarget() then

		-- remove the cursor target
		CancelCursorTarget()

		-- reset the variables
		GenericGump.TargetDrag = nil
		GenericGump.DraggedItem = nil
	end
end

function Interface.GumpTargetDragJewbox(timePassed)

	-- do we have to target the dragged item?
	if not GenericGump.JewTargetDrag then
		return
	end

	-- phse 1
	if GenericGump.JewTargetDrag == 1 then

		-- store the item ID
		GenericGump.DraggedItem = SystemData.DragItem.itemId

		-- count the items in the box
		local countItems = table.countElements(GenericGump.GetAllItemProperties(GenericGump.JEWELBOX_GUMPID))

		-- default button ID to deposit items
		local buttonIndex = countItems + 11

		-- click the gump button to get the target
		GumpsParsing.PressButton(GenericGump.JEWELBOX_GUMPID, buttonIndex)

		-- drop the item inside the backpack
		DragSlotDropObjectToContainer(ContainerWindow.PlayerBackpack, 0)

		-- target the item we tried to release (phase 2: click the item)
		GenericGump.JewTargetDrag = 2

	-- phse 2
	elseif GenericGump.JewTargetDrag == 2 and DoesPlayerHaveItem(GenericGump.DraggedItem) and DoesPlayerHasCursorTarget() then

		-- target the item
		HandleSingleLeftClkTarget(GenericGump.DraggedItem)

		-- target the item we tried to release (phase 3: remove the cursor target)
		GenericGump.JewTargetDrag = 3

	-- phase 3
	elseif GenericGump.JewTargetDrag == 3 and DoesPlayerHasCursorTarget() then

		-- remove the cursor target
		CancelCursorTarget()

		-- reset the variables
		GenericGump.JewTargetDrag = nil
		GenericGump.DraggedItem = nil
	end
end

function Interface.CheckLastTargetChanged(timePassed)
	if not WindowData.Cursor then
		WindowData.Cursor = {}
	end
	local newTarg = WindowData.Cursor.lastTarget
	if newTarg == nil then
		newTarg = 0
	end
	local oldTarg = Interface.LastTarget
	if oldTarg == nil then
		oldTarg = 0
	end
	
	if Interface.started then

		if DoesPlayerHasCursorTarget() then
			Interface.CursorTarget = true

			if Interface.ForceTarget then
				HandleSingleLeftClkTarget(Interface.ForceTarget)
				Interface.ForceTarget = nil
			end

		elseif Interface.CursorTarget then
			Interface.CanceledCursorTime = Interface.TimeSinceLogin + 2
			Interface.CursorTarget = false
			Interface.OnTarget(newTarg, oldTarg)
			return
		end
	end

	if WindowData.Cursor.lastTarget and WindowData.Cursor.lastTarget ~= Interface.LastTarget then
		Interface.OnTarget(newTarg, oldTarg)
		Interface.LastTarget = WindowData.Cursor.lastTarget
	end
end

function Interface.PaperdollCheck(timePassed)

	if not Interface.NewPlayerPaperdollToggled and (not MapCommon.AreaDescription or MapCommon.AreaDescription == "") and not Interface.started then
		return
	end
	
	if MapCommon.AreaDescription ~= "New Player Quest Area" then
		if (Interface.PaperdollOpen and not DoesWindowExist("PaperdollWindow"..GetPlayerID())) then
			Interface.TogglePaperdollWindow()
		elseif DoesWindowExist("PaperdollWindow"..GetPlayerID()) then
			if not WindowGetShowing("PaperdollWindow"..GetPlayerID()) then
				Interface.TogglePaperdollWindow()
			end
		end
	elseif Interface.NewPlayerPaperdollToggled then
		if (Interface.PaperdollOpen and not DoesWindowExist("PaperdollWindow"..GetPlayerID())) then
			Interface.TogglePaperdollWindow()
		elseif DoesWindowExist("PaperdollWindow"..GetPlayerID()) then
			if not WindowGetShowing("PaperdollWindow"..GetPlayerID()) then
				Interface.TogglePaperdollWindow()
			end
		end
	end
	if not DoesWindowExist("PaperdollWindow"..GetPlayerID()) then
		if Interface.PaperdollOpen and (MapCommon.AreaDescription ~= "New Player Quest Area" or Interface.NewPlayerPaperdollToggled) then
			Interface.TogglePaperdollWindow()
		end
	end
end

function Interface.BackpackCheck(timePassed)
	if not Interface.NewPlayerInventoryToggled and (not MapCommon.AreaDescription or MapCommon.AreaDescription == "") and not Interface.started then
		return
	end
	
	Interface.OpeningBpk = Interface.OpeningBpk + timePassed

	if MapCommon.AreaDescription ~= "New Player Quest Area" then
		if not Interface.IsPlayerDead and Interface.BackpackOpen and not DoesWindowExist("ContainerWindow_"..ContainerWindow.PlayerBackpack) and Interface.OpeningBpk > 2 then
			Actions.ToggleInventoryWindow()
			Interface.OpeningBpk = 0
		end
	elseif Interface.NewPlayerInventoryToggled then
		if not Interface.IsPlayerDead and Interface.BackpackOpen and not DoesWindowExist("ContainerWindow_"..ContainerWindow.PlayerBackpack) and Interface.OpeningBpk > 2 then
			Actions.ToggleInventoryWindow()
			Interface.OpeningBpk = 0
		end
	end
end

function Interface.MapRefresh(timePassed)

	-- is the interface shutting down, not yet started or the map has not been initialized?
	if Interface.goingDown or not Interface.started or not Interface.mapInitialized then
		return
	end

	-- is the map visible and the type is incorrect?
	if MapCommon.IsMapVisible() and SystemData.Settings.Interface.mapMode ~= MapCommon.MAP_ATLAS then

		-- fix the map type
		SystemData.Settings.Interface.mapMode = MapCommon.MAP_ATLAS
		UserSettingsChanged()

	-- is the map hidden and the type is incorrect?
	elseif not MapCommon.IsMapVisible() and SystemData.Settings.Interface.mapMode ~= MapCommon.MAP_HIDDEN then

		-- fix the map type
		SystemData.Settings.Interface.mapMode = MapCommon.MAP_HIDDEN
		UserSettingsChanged()
	end
end

function Interface.SkillsTrackerUpdate(timePassed)
	if (SkillsWindow.SkillsTrackerMode  == 1 or Interface.LoadSetting( "ShowTracker" , false )) then
		SkillsWindow.SkillsTrackerMode = 1
		if (not DoesWindowExist("SkillsTrackerWindow")) then
			CreateWindow("SkillsTrackerWindow", true)
			WindowUtils.RestoreWindowPosition("SkillsTrackerWindow")
		end
		SkillsTracker.Update()
	else
		SkillsWindow.SkillsTrackerMode = 0
		if DoesWindowExist("SkillsTrackerWindow") then
			DestroyWindow("SkillsTrackerWindow")
		end
	end
end

function Interface.SkillLocker(timePassed)
	if (Interface.DeltaTime >= 0.1) then
		SkillsWindow.LockSkills()
		SkillsWindow.DownSkills()
	end
end

Interface.BeatSlow = false
Interface.BeatMed = false
Interface.BeatFast = false
Interface.Beat = false

Interface.BeatSoundStartDelta = 0 
Interface.BeatSoundLength = 0

function Interface.LowHPManager(timePassed)
	if not WindowData.PlayerStatus or not WindowData.PlayerStatus.CurrentHealth then
		return
	end
	local curr = WindowData.PlayerStatus.CurrentHealth
	local max = WindowData.PlayerStatus.MaxHealth
	local perc = (curr/max)*100
	if (max == 0) then
		perc = 100
	end
	perc = math.floor(perc)
	if perc < 50 and not Interface.IsPlayerDead then
		WindowSetShowing("BloodSmear", true)
		local alpha = ((perc * 100) / 50) + 0.2
		WindowSetAlpha("BloodSmear", 1 - (alpha / 100))
	else
		WindowSetShowing("BloodSmear", false)
	end
	if (perc <= Interface.Settings.CST_LowHPPerc and not Interface.IsPlayerDead) and not CenterScreenText.LOWHPMEStarted then
		CenterScreenText.SendCenterScreenTexture("lowhp")
		CenterScreenText.LOWHPMEStarted = true
		CenterScreenText.LOWHPPetStarted = false
	elseif (perc > Interface.Settings.CST_LowHPPerc or Interface.IsPlayerDead) and CenterScreenText.LOWHPMEStarted then
		CenterScreenText.LOWHPMEStarted = false
		WindowStopAlphaAnimation("CenterScreenTextImage")
		WindowSetAlpha("CenterScreenTextImage", 0)
	end

	if (Interface.HeartBeat.enabled) then
		if (perc <= 50 and not Interface.IsPlayerDead) then
			Interface.BeatSoundStartDelta = Interface.BeatSoundStartDelta + timePassed
			local changeBeat = false

			if (perc >35 and perc <= 50 and not Interface.BeatSlow) then
				Interface.BeatSlow = true
				Interface.BeatMed = false
				Interface.BeatFast = false
				changeBeat = true
			end
			if (perc >20 and perc <= 35 and not Interface.BeatMed) then
				Interface.BeatSlow = false
				Interface.BeatMed = true
				Interface.BeatFast = false
				changeBeat = true
			end
			if (perc >0 and perc <= 20 and not Interface.BeatFast) then
				Interface.BeatSlow = false
				Interface.BeatMed = false
				Interface.BeatFast = true
				changeBeat = true
			end
			if Interface.BeatSoundStartDelta >= Interface.BeatSoundLength then
				changeBeat = true
			end
			if (changeBeat) then
				ECPlaySound(2,"", 1)
				--PlaySound(2, 0, WindowData.PlayerLocation.x, WindowData.PlayerLocation.y, WindowData.PlayerLocation.z)
				if (Interface.BeatSlow) then
					--PlaySound(1, 1657 ,WindowData.PlayerLocation.x, WindowData.PlayerLocation.y, WindowData.PlayerLocation.z)
					ECPlaySound(2,"beatSlow.mp3", 2)
					Interface.BeatSoundLength = 48
				elseif (Interface.BeatMed) then
					--PlaySound(1, 1656 ,WindowData.PlayerLocation.x, WindowData.PlayerLocation.y, WindowData.PlayerLocation.z)
					ECPlaySound(2,"beatMed.mp3", 2)
					Interface.BeatSoundLength = 58
				elseif (Interface.BeatFast) then
					--PlaySound(1, 1655 ,WindowData.PlayerLocation.x, WindowData.PlayerLocation.y, WindowData.PlayerLocation.z)
					ECPlaySound(2,"beatFast.mp3", 2)
					Interface.BeatSoundLength = 120
				end
				Interface.BeatSoundStartDelta = 0
			end
			Interface.Beat = true
		elseif (Interface.IsPlayerDead) then

			ECPlaySound(2,"", 1)
			--PlaySound(2, 0, WindowData.PlayerLocation.x, WindowData.PlayerLocation.y, WindowData.PlayerLocation.z)
			Interface.Beat = false
			Interface.BeatSlow = false
			Interface.BeatMed = false
			Interface.BeatFast = false

			Interface.BeatSoundStartDelta = 0
			Interface.BeatSoundLength = 0
		
		else
			if (Interface.Beat) then
				ECPlaySound(2,"", 1)
				--PlaySound(2, 0, WindowData.PlayerLocation.x, WindowData.PlayerLocation.y, WindowData.PlayerLocation.z)
				Interface.Beat = false
				Interface.BeatSlow = false
				Interface.BeatMed = false
				Interface.BeatFast = false
			end
			Interface.BeatSoundStartDelta = 0
			Interface.BeatSoundLength = 0
		end
		
	elseif (Interface.IsPlayerDead) then
		ECPlaySound(2,"", 1)
		--PlaySound(2, 0, WindowData.PlayerLocation.x, WindowData.PlayerLocation.y, WindowData.PlayerLocation.z)
		Interface.Beat = false
		Interface.BeatSlow = false
		Interface.BeatMed = false
		Interface.BeatFast = false

		Interface.BeatSoundStartDelta = 0
		Interface.BeatSoundLength = 0
	end
end

Interface.RegisterQueue = {}
Interface.UnregisterQueue = {}
function Interface.ClearWindowData(timePassed)

	-- is it time to clean up the window data?
	pcall(Interface.CheckMobileData, timePassed)	

	pcall(Interface.ReleaseObjects, timePassed)	
	pcall(Interface.ReleaseNames, timePassed)	
	pcall(Interface.ReleasePaperdolls, timePassed)	
 	pcall(Interface.ReleaseStatus, timePassed)	
	pcall(Interface.ReleaseProperties, timePassed)	
	pcall(Interface.ReleaseContainers, timePassed)	
	pcall(Interface.ReleaseSpellbooks, timePassed)

	pcall(Interface.ClearChatBuff, timePassed)	
	pcall(Interface.ClearDamageArray, timePassed)
	pcall(Interface.ClearPortraits, timePassed)	

	--pcall(Interface.InterfaceWindowData, timePassed)	
end

function Interface.ClearPortraits(timePassed)

	-- scan all the stored portraits
	for window, texture in pairs(Interface.CurrentPortraits) do

		-- does the window still exist?
		if not DoesWindowExist(window) then

			-- remove the portrait data
			Interface.CurrentPortraits[window] = nil
		end
	end
end

function Interface.CheckMobileData(timePassed)

	-- scan all the status update
	for mobileId, time in pairs(Interface.LastStatusUpdate) do

		-- has the status been unregistered? 
		if not WindowData.MobileStatus[mobileId] then

			-- remove the mobile from the list.
			Interface.LastStatusUpdate[mobileId] = nil

			continue
		end

		-- are we using the status?
		if not Interface.IsHealthbarActive(mobileId) then

			-- unregister the status, we don't need it anymore
			UnregisterWindowData(WindowData.MobileStatus.Type, mobileId, true)
			UnregisterWindowData(WindowData.HealthBarColor.Type, mobileId, true)

			-- remove the mobile from the list.
			Interface.LastStatusUpdate[mobileId] = nil

			continue
		end
	end

	-- scan all the active bars
	for mobileId, barData in pairs(MobileHealthBar.ActiveBars) do
	
		-- is the bar enabled?
		if not barData.disabled then
				
			-- are the mobile data not available?
			if not Interface.VerifyMobileData(mobileId, WindowData.MobileStatus[mobileId]) then

				-- make sure we don't have fake mobile data first
				Interface.KillFakeMobileData(mobileId)

				-- register the window data for the mobile
				Interface.ExecuteWhenAvailable(
				{
					name = "MobileDataMissingFromBar" .. mobileId,
					check = function() return not Interface.VerifyMobileData(mobileId, WindowData.MobileStatus[mobileId]) and not Shopkeeper.HasItem(mobileId) end, 
					callback = function() Interface.GetMobileData(mobileId) Interface.GetMobileNameData(mobileId) end,
					removeOnComplete = true,
					maxTime = Interface.TimeSinceLogin + 2,
					dealay = Interface.TimeSinceLogin + 1,
				})
			end
		end
	end

	-- are the overhead healthbars active?
	if Interface.Settings.HoverbarsActive then

		-- scan all the active bars
		for mobileId, _ in pairs(OverheadText.hasHoverbar) do
			
			-- is the bar visible?
			if WindowGetShowing("Hoverbar_" .. mobileId) then
				
				-- are the mobile data not available?
				if not Interface.VerifyMobileData(mobileId, WindowData.MobileStatus[mobileId]) then

					-- make sure we don't have fake mobile data first
					Interface.KillFakeMobileData(mobileId)

					-- register the window data for the mobile
					Interface.ExecuteWhenAvailable(
					{
						name = "MobileDataMissingFromBar" .. mobileId,
						check = function() return not Interface.VerifyMobileData(mobileId, WindowData.MobileStatus[mobileId]) and not Shopkeeper.HasItem(mobileId) end, 
						callback = function() Interface.GetMobileData(mobileId) Interface.GetMobileNameData(mobileId) end,
						removeOnComplete = true,
						maxTime = Interface.TimeSinceLogin + 2,
						dealay = Interface.TimeSinceLogin + 1,
					})
				end
			end
		end
	end

	-- are the overhead healthbars active?
	if Interface.Settings.BossbarsActive then

		-- get the mobile ID
		local mobileId = BossBar.GetActiveBoss()
		
		-- do we have a valid ID
		if IsValidID(mobileId) then
				
			-- are the mobile data not available?
			if not Interface.VerifyMobileData(mobileId, WindowData.MobileStatus[mobileId]) then

				-- make sure we don't have fake mobile data first
				Interface.KillFakeMobileData(mobileId)

				-- register the window data for the mobile
				Interface.ExecuteWhenAvailable(
				{
					name = "MobileDataMissingFromBar" .. mobileId,
					check = function() return not Interface.VerifyMobileData(mobileId, WindowData.MobileStatus[mobileId]) and not Shopkeeper.HasItem(mobileId) end, 
					callback = function() Interface.GetMobileData(mobileId) Interface.GetMobileNameData(mobileId) end,
					removeOnComplete = true,
					dealay = Interface.TimeSinceLogin + 1,
				})
			end
		end
	end
end

function Interface.ReleaseObjectsQuantity(timePassed)

	-- scan all the object quantities (this is used ONLY in hotbars slots)
	for itemId, value in pairs(WindowData.ObjectTypeQuantity) do

		-- do we have a valid ID?
		if not IsValidID(itemId) then
			continue
		end

		-- make sure is passed enough time
		if Interface.WindowDataReleaseTime[WindowData.ObjectTypeQuantity.Type] and Interface.WindowDataReleaseTime[WindowData.ObjectTypeQuantity.Type][itemId] and Interface.TimeSinceLogin < Interface.WindowDataReleaseTime[WindowData.ObjectTypeQuantity.Type][itemId] then
			continue
		end

		-- unregister the quantity
		UnregisterWindowData(WindowData.ObjectTypeQuantity.Type, itemId)
	end
end

function Interface.ReleaseObjects(timePassed)

	-- scan all the object info
	for itemId, value in pairs(WindowData.ObjectInfo) do

		-- do we have a valid item ID?
		if not IsValidID(itemId) then
			continue
		end
		
		-- is the object in use?
		if Interface.IsObjectInUse(itemId) then
			continue
		end
		
		-- make sure is passed enough time
		if Interface.WindowDataReleaseTime[WindowData.ObjectInfo.Type] and Interface.WindowDataReleaseTime[WindowData.ObjectInfo.Type][itemId] and Interface.TimeSinceLogin < Interface.WindowDataReleaseTime[WindowData.ObjectInfo.Type][itemId] then
			continue
		end

		-- unregister the object info
		UnregisterWindowData(WindowData.ObjectInfo.Type,itemId)
	end
end

function Interface.ReleaseNames(timePassed)

	-- scan all names
	for mobileId, value in pairs(WindowData.MobileName) do

		-- do we have a valid mobile ID?
		if not IsValidID(mobileId) then
			continue
		end
	
		-- is the name in use?
		if Interface.IsNameInUse(mobileId) then
			continue
		end

		-- make sure is passed enough time
		if Interface.WindowDataReleaseTime[WindowData.MobileName.Type] and Interface.WindowDataReleaseTime[WindowData.MobileName.Type][mobileId] and Interface.TimeSinceLogin < Interface.WindowDataReleaseTime[WindowData.MobileName.Type][mobileId] then
			continue
		end
		
		-- unregister the name data
		UnregisterWindowData(WindowData.MobileName.Type,mobileId)
	end
end

function Interface.ReleasePaperdolls(timePassed)

	-- scal all paperdolls
	for mobileId, value in pairs(WindowData.Paperdoll) do

		-- do we have a valid mobile ID?
		if not IsValidID(mobileId) then
			continue
		end

		-- is the paperdoll in use?
		if Interface.IsPaperdollInUse(mobileId) then
			continue
		end

		-- make sure is passed enough time
		if Interface.WindowDataReleaseTime[WindowData.Paperdoll.Type] and Interface.WindowDataReleaseTime[WindowData.Paperdoll.Type][mobileId] and Interface.TimeSinceLogin < Interface.WindowDataReleaseTime[WindowData.Paperdoll.Type][mobileId] then
			continue
		end
		
		-- unregister the paperdoll
		UnregisterWindowData(WindowData.Paperdoll.Type,mobileId)
	end
end

function Interface.ReleaseStatus(timePassed)

	-- scan all the mobile status
	for mobileId, value in pairs(WindowData.MobileStatus) do

		-- do we have a valid mobile ID?
		if not IsValidID(mobileId) then
			continue
		end

		-- make sure is passed enough time
		if Interface.WindowDataReleaseTime[WindowData.MobileStatus.Type] and Interface.WindowDataReleaseTime[WindowData.MobileStatus.Type][mobileId] and Interface.TimeSinceLogin < Interface.WindowDataReleaseTime[WindowData.MobileStatus.Type][mobileId] then
			continue
		end

		-- make sure we don't have fake mobile data first
		--Interface.KillFakeMobileData(mobileId)

		-- is the status in use and the mobile is NOT invulnerable?
		if Interface.IsStatusInUse(mobileId) and not IsMobileInvulnerable(mobileId) then
			continue
		end

		-- unregister the data
		UnregisterWindowData(WindowData.MobileStatus.Type, mobileId)
		UnregisterWindowData(WindowData.HealthBarColor.Type, mobileId)
	end

	-- scan the hoverbars
	for id, _ in pairs(OverheadText.hasHoverbar) do

		-- is the status gone?
		if WindowData.MobileStatus[id] == nil then

			-- remove the hoverbar
			OverheadText.DestroyHoverbarByID(id)
		end
	end

	-- do we have a boss bar, the mobile data is gone and is passed enough time from the creation of the boss bar?
	if IsValidID(BossBar.GetActiveBoss()) and WindowData.MobileStatus[BossBar.GetActiveBoss()] == nil and BossBar.InitializeTime < Interface.TimeSinceLogin then

		-- remove the boss bar
		BossBar.ResetBossBar()
	end
end

function Interface.ReleaseProperties(timePassed)

	-- can all the properties
	for itemId, value in pairs(WindowData.ItemProperties) do

		-- do we have a valid item ID?
		if not IsValidID(itemId) then
			continue
		end
			
		-- is this the item in the active properties?
		if ItemProperties.IsCurrentHover(itemId) then
			continue
		end

		-- make sure is passed enough time
		if Interface.WindowDataReleaseTime[WindowData.ItemProperties.Type] and Interface.WindowDataReleaseTime[WindowData.ItemProperties.Type][itemId] and Interface.TimeSinceLogin < Interface.WindowDataReleaseTime[WindowData.ItemProperties.Type][itemId] then
			continue
		end

		-- unregister the properties
		UnregisterWindowData(WindowData.ItemProperties.Type, itemId)
	end
end

function Interface.ReleaseSpellbooks(timePassed)

	-- scan all the spellbooks data
	for itemId, value in pairs(WindowData.Spellbook) do
		
		-- do we have a valid item ID?
		if not IsValidID(itemId) then
			continue
		end
			
		-- is the spellbook open?
		if Spellbook.OpenSpellbooks[itemId] and Spellbook.OpenSpellbooks[itemId].showing == true then
			continue
		end

		-- make sure is passed enough time
		if Interface.WindowDataReleaseTime[WindowData.Spellbook.Type] and Interface.WindowDataReleaseTime[WindowData.Spellbook.Type][itemId] and Interface.TimeSinceLogin < Interface.WindowDataReleaseTime[WindowData.Spellbook.Type][itemId] then
			continue
		end
		
		-- unregister the spellbook
		UnregisterWindowData(WindowData.Spellbook.Type, itemId)
	end
end

function Interface.ReleaseContainers(timePassed)

	-- scan all the containers data
	for contId, value in pairs(WindowData.ContainerWindow) do
		
		-- do we have a valid item ID?
		if not IsValidID(contId) then
			continue
		end

		-- make sure is passed enough time
		if Interface.WindowDataReleaseTime[WindowData.ContainerWindow.Type] and Interface.WindowDataReleaseTime[WindowData.ContainerWindow.Type][contId] and Interface.TimeSinceLogin < Interface.WindowDataReleaseTime[WindowData.ContainerWindow.Type][contId] then
			continue
		end
		
		-- is this a container registered for the active shopkeeper?
		local shopReg = (DoesWindowExist("Shopkeeper") and Shopkeeper.currentShop[WindowGetId("Shopkeeper")] and contId == Shopkeeper.currentShop[WindowGetId("Shopkeeper")].sellContainerId)

		-- is this a trade window container?
		local tradeReg = TradeWindow.IsTradeContainer(contId)

		-- if this is not a shopkeeper container or a trade container or an open container and we're not waiting for the container to show
		if not shopReg and not tradeReg and not ContainerWindow.OpenContainers[contId] and ContainerWindow.waitGump ~= contId then

			-- unregister the container data
			UnregisterWindowData(WindowData.ContainerWindow.Type, contId)
		end
	end
end

function Interface.InterfaceWindowData(timePassed)

	-- scan all the callback on close
	for win, _ in pairs(Interface.OnCloseCallBack) do
		
		-- does the window still exist?
		if not DoesWindowExist(win) then

			-- remove the callback
			Interface.OnCloseCallBack[win] = nil
		end
	end
end

function Interface.ClearChatBuff(timePassed)
	while (NewChatWindow.Setting and #NewChatWindow.Setting.Messages > Interface.Settings.chat_messagesBuffCap * 2) do
		table.remove(NewChatWindow.Setting.Messages, 1)
	end
end

function Interface.ClearDamageArray(timePassed)
	for mobileId, data in pairs(DamageWindow.DamageArray) do
		if DamageWindow.DamageArray[mobileId].lastActivity <= Interface.Clock.Timestamp then
			DamageWindow.DamageArray[mobileId] = nil
			break
		end
	end
end

-------------------------------------------------------------------------------
--
-- NEW CHAT OVERRIDES
--
-------------------------------------------------------------------------------
function Interface.NewChatText()
	local ign = false
	local share, ignore

	_, ignore = pcall(TextParsing.IgnoreTextManager)
	ign = ignore
	
	pcall(TextParsing.ForceOverhead)
	
	local color, channel
	_, color, channel = pcall(TextParsing.ColorizeText)
	
	pcall(TextParsing.SpecialTexts)
	pcall(TextParsing.SpellCasting)
	pcall(TextParsing.TimersNbuff)
	pcall(TextParsing.Taunts)
	pcall(TextParsing.CenterScreenText, timePassed)	
	
	if (SystemData.TextSourceID == GetPlayerID()) then
		local spellinf = SpellsInfo.SpellsData[tostring(SystemData.Text)]
		if (spellinf and Interface.LastSpell ~= 0) then
			 local speed = SpellsInfo.GetSpellSpeed(Interface.LastSpell)
			 if (speed) then
				CastBarWindow.CurrentTime = speed + (speed * CastBarWindow.LagFactor)
				CastBarWindow.UnlagTime = speed
				Interface.CurrentSpell.UnlaggedSpeed = speed
				Interface.CurrentSpell.Recovery = 1.5
				Interface.CurrentSpell.ActualSpeed = 0
				Interface.CurrentSpell.IsSpell = true
				Interface.CurrentSpell.SpellId = spellinf.id
				Interface.CurrentSpell.ready =false
				Interface.CurrentSpell.casting = true
				Interface.CurrentSpell.CheckFizzle = false
				Interface.CurrentSpell.Color = spellinf.color
			end
			if (NewChatWindow and not Interface.Settings.chat_showSpells) then
				ign = true
			end
		end
		
	end

	SystemData.TextColor = color
	if NewChatWindow and not ign then
		if channel == 14 then
			channel = 12
		end
		
		local logVal = {text = SystemData.Text, ORGchannel = SystemData.TextChannelID , channel = channel, color = color, sourceId = SystemData.TextSourceID, sourceName = SystemData.SourceName, ignore = ign, category = 0, timeStamp = towstring(string.format("%02.f", Interface.Clock.h) .. ":" .. string.format("%02.f", Interface.Clock.m) .. ":" .. string.format("%02.f", Interface.Clock.s))}
		table.insert(NewChatWindow.Messages, logVal)
		if (NewChatWindow.Setting and NewChatWindow.Setting.Messages) then
			table.insert(NewChatWindow.Setting.Messages, logVal)
		end
		if (NewChatWindow.Setting and #NewChatWindow.Setting.Messages > Interface.Settings.chat_messagesBuffCap * 2) then
			table.remove(NewChatWindow.Setting.Messages, 1)
		end
		NewChatWindow.UpdateLog()
	end
end

-------------------------------------------------------------------------------
--
-- OVERRIDES
--
-------------------------------------------------------------------------------

Interface.org_IsObjectIdPet = nil
function Interface.IsObjectIdPet(id)

	-- do we have a valid id?
	if not IsValidID(id) then
		return false
	end

	-- scan the pets list
	for i = 1, #WindowData.Pets.PetId do

		-- is this the mobile we're looking for?
		if WindowData.Pets.PetId[i] == id then
			return true
		end
	end

	return false
end

Interface.org_WindowGetShowing = nil
function Interface.WindowGetShowing(windowName)

	-- does the window exist?
	if not DoesWindowExist(windowName) then
		return false
	end

	-- execute the default action
	return Interface.org_WindowGetShowing(windowName)
end

Interface.org_WindowGetId = nil
function Interface.WindowGetId(windowName)

	-- does the window exist?
	if not DoesWindowExist(windowName) then
		return 0
	end

	-- execute the default action
	return Interface.org_WindowGetId(windowName)
end

Interface.org_GetDistanceFromPlayer = nil
function Interface.GetDistanceFromPlayer(id)

	-- do we have a valid ID?
	if not IsValidID(id) then
		return -1
	end

	-- is this an item and the player has it or is inside an open container?
	if not IsMobile(id) and (DoesPlayerHaveItem(id) or ContainerWindow.IsObjectRegistered(id)) then
		return 0
	end

	-- execute the default action
	return Interface.org_GetDistanceFromPlayer(id)
end

Interface.org_WindowSetFontAlpha = nil
function Interface.WindowSetFontAlpha(label, alpha)

	-- does the label exist?
	if not DoesWindowExist(label) then
		return
	end

	-- execute the default action
	return Interface.org_WindowSetFontAlpha(label, alpha)
end

Interface.org_BroadcastEvent = nil
function Interface.BroadcastEvent(event)

	-- is this the reload interface event?
	if event == SystemData.Events.RELOAD_INTERFACE then
	
		-- close all gumps to avoid crashes
		GumpsParsing.CloseAllGumps()

		-- close the animal lore gump to avoid crash
		if DoesWindowExist("AnimalLore") then
			DestroyWindow("AnimalLore")
		end
	end

	-- execute the default action
	return Interface.org_BroadcastEvent(event)
end

Interface.org_WindowStartAlphaAnimation = nil
function Interface.WindowStartAlphaAnimation(windowName, animType, startAlpha, endAlpha, duration, setStartBeforeDelay, delay, numLoop)

	-- do we have a valid window?
	if not DoesWindowExist(windowName) then
		return
	end

	Interface.org_WindowStartAlphaAnimation(windowName, animType, startAlpha, endAlpha, duration, setStartBeforeDelay, delay, numLoop)
end

Interface.org_WindowStartAlphaAnimation = nil
function Interface.WindowStartAlphaAnimation(windowName, animType, startAlpha, endAlpha, duration, setStartBeforeDelay, delay, numLoop)

	-- do we have a valid window?
	if not DoesWindowExist(windowName) then
		return
	end

	Interface.org_WindowStartAlphaAnimation(windowName, animType, startAlpha, endAlpha, duration, setStartBeforeDelay, delay, numLoop)
end

Interface.org_WindowStopAlphaAnimation = nil
function Interface.WindowStopAlphaAnimation(windowName)

	-- do we have a valid window?
	if not DoesWindowExist(windowName) then
		return
	end

	Interface.org_WindowStopAlphaAnimation(windowName)
end

Interface.org_DetachWindowFromWorldObject = nil
function Interface.DetachWindowFromWorldObject(objectId, windowName)

	-- do we have valid parameters?
	if not IsValidID(objectId) or not DoesWindowExist(windowName) then
		return
	end

	Interface.org_DetachWindowFromWorldObject(objectId, windowName)
end

Interface.org_AttachWindowToWorldObject = nil
function Interface.AttachWindowToWorldObject(objectId, windowName)

	-- do we have valid parameters?
	if not IsValidID(objectId) or not DoesWindowExist(windowName) then
		return
	end

	-- make sure the object is in sight
	if not IsMobileVisible(objectId) then
		return
	end

	Interface.org_AttachWindowToWorldObject(objectId, windowName)
end

Interface.org_WindowAddAnchor = nil
function Interface.WindowAddAnchor(windowName, anchorPoint, relativeTo, relativePoint, xOffset, yOffset)

	-- make sure that both windows exist
	if not DoesWindowExist(windowName) or not DoesWindowExist(relativeTo) then
		return
	end

	return Interface.org_WindowAddAnchor(windowName, anchorPoint, relativeTo, relativePoint, xOffset, yOffset)
end

Interface.org_LabelSetText = nil
function Interface.LabelSetText(windowName, text)

	return Interface.org_LabelSetText(windowName, text)
end

Interface.org_LabelSetTextColor = nil
function Interface.LabelSetTextColor(windowTextName, r, g, b)

	-- All this is to fix a glitch that prevents the labels to be colored correctly after a while...

	-- get the label text
	local text = LabelGetText(windowTextName)

	-- reset the label color to white
	Interface.org_LabelSetTextColor(windowTextName, 255, 255, 255)

	-- remove the label text
	LabelSetText(windowTextName, L"")

	-- restore the label text
	LabelSetText(windowTextName, text)
	
	-- set the correct color
	Interface.org_LabelSetTextColor(windowTextName, r, g, b)
end

Interface.CurrentTextEntryWindow = nil
Interface.CurrentTextEntryWindowEditBox = nil
Interface.org_SingleLineTextEntryInitialize = nil
function Interface.SingleLineTextEntryInitialize()
	
	Interface.org_SingleLineTextEntryInitialize()

	Interface.CurrentTextEntryWindow = SystemData.ActiveWindow.name
	Interface.CurrentTextEntryWindowEditBox = Interface.CurrentTextEntryWindow .. "TextEntryBox"

	-- hide the text entry window if there is a vendor rename request (handled automatically)
	if PlayerVendor.RenameShopSent or PlayerVendor.RenameVendorSent then
		WindowSetShowing(Interface.CurrentTextEntryWindow, false)
	end
end

Interface.org_SingleLineTextEntryShutdown = nil
function Interface.SingleLineTextEntryShutdown()
	
	Interface.org_SingleLineTextEntryShutdown()

	Interface.CurrentTextEntryWindow = nil
	Interface.CurrentTextEntryWindowEditBox = nil
end

Interface.org_SingleLineTextEntryOnCancel = nil
function Interface.SingleLineTextEntryOnCancel()
	
	Interface.org_SingleLineTextEntryOnCancel()

	-- do we had a player vendor text entry pending?
	if PlayerVendor.TextEntryRequest then

		-- re-open the vendor customization main window
		UserActionUseItem(PlayerVendor.MobileId, false)

		-- flag the text entry request as done
		PlayerVendor.TextEntryRequest = false
	end
end

Interface.org_SingleLineTextEntryOnCancel = nil
function Interface.SingleLineTextEntryOnSubmit()
	
	Interface.org_SingleLineTextEntryOnSubmit()

	-- do we had a player vendor text entry pending?
	if PlayerVendor.TextEntryRequest then

		-- re-open the vendor customization main window
		UserActionUseItem(PlayerVendor.MobileId, false)

		-- flag the text entry request as done
		PlayerVendor.TextEntryRequest = false
	end
end

Interface.org_DestroyWindow = nil
function Interface.DestroyWindow(window)
	
	if not DoesWindowExist(window) then
		return
	end

	-- are there any events attached to this window?
	if Interface.RegisteredEvents[window] then

		-- scan all the events for the current window
		for id, _ in pairs(Interface.RegisteredEvents[window]) do
				
			-- remove the event
			WindowUnregisterEventHandler(window, id)
		end
	end

	Interface.org_DestroyWindow(window)
end

Interface.org_WindowAssignFocus = nil
function Interface.WindowAssignFocus(window, focus)
	
	-- make sure the window exist first
	if not DoesWindowExist(window) then
		return
	end

	-- is the window visible?
	if not WindowGetShowing(window) and focus == true then

		-- show the window first
		WindowSetShowing(window, true)
	end

	-- execute the default action
	return Interface.org_WindowAssignFocus(window, focus)
end

Interface.org_ReplaceTokens = nil
function Interface.ReplaceTokens(text, tokens)
	
	-- do we have a valid string?
	if not IsValidWString(text) then
		return text
	end

	-- do we have a valid tokens table?
	if not type(tokens) == "table" then
		return text
	end

	-- count the tokens to replace in the string
	local tokensCount = CountTokensOnString(text)

	-- are there any token in the string to replace?
	if tokensCount == 0 then
		return text
	end

	-- do we have enough tokens to replace?
	if tokensCount > #tokens then
		return text
	end

	-- scan all tokens
	for i, token in pairsByIndex(tokens) do

		-- is the token a wstring?
		if type(token) ~= "wstring" then

			-- convert the token to wstring
			tokens[i] = towstring(token)
		end
	end
	
	-- replace the tokens
	return Interface.org_ReplaceTokens(text, tokens)
end	

Interface.org_DoesPlayerHaveItem = nil
function Interface.DoesPlayerHaveItem(objectId)
	
	if not IsValidID(objectId) then
		return false
	end

	return Interface.org_DoesPlayerHaveItem(objectId)
end	

Interface.org_UserActionGetTargetType = nil
function Interface.UserActionGetTargetType(hotbarId, itemIndex, subIndex, slotWindow)
	
	local targetType = Interface.org_UserActionGetTargetType(hotbarId, itemIndex, subIndex)

	-- check if it's a mouse over target and fix the target type if it is
	targetType = Hotbar.IsAMouseOverTarget(slotWindow, targetType)

	return targetType
end	

Interface.org_UserActionHasTargetType = nil
function Interface.UserActionHasTargetType(hotbarId, itemIndex, subIndex)
	
	-- subIndex default parameter is 0 (unless is a macro)
	if (subIndex == nil) then
		subIndex = 0
	end

	-- make sure the hotbar and slot exist
	if (hotbarId ~= SystemData.MacroSystem.STATIC_MACRO_ID and not Hotbar.DoesHotbarExist(hotbarId, true)) or not IsValidID(itemIndex) then
		return false
	end
	
	-- getting the current action ID
	local actionId = UserActionGetId(hotbarId, itemIndex, subIndex)

	-- getting the current action type
	local actionType = UserActionGetType(hotbarId, itemIndex, subIndex)

	-- is a valid action id?
	if not IsValidID(actionId) then
		return false
	end
	
	-- is this an item?
	if HotbarSystem.IsHotbarItem(actionType) then
		
		-- get the object type and hue for the item in the slot
		local objectType = UserActionUseObjectTypeGetObjectTypeHue(actionId)

		-- is this a spell scroll?
		if SpellsInfo.ScrollsToSpellID[objectType] then

			-- get the scroll's spell ID
			local spellId = SpellsInfo.ScrollsToSpellID[objectType]

			-- scan all spells to determine if it supports a target
			for _, value in pairs(SpellsInfo.SpellsData) do
				if value.id == spellId and value.notarget == true then
					return false
				end
			end
		end
	end

	-- spells check
	if (actionType == SystemData.UserAction.TYPE_SPELL and SpellsInfo) then
		for _, value in pairs(SpellsInfo.SpellsData) do
			if value.id == actionId and value.notarget == true then
				return false
			end
		end
	end

	-- skills without target
	if	actionType == SystemData.UserAction.TYPE_SKILL and 
		(actionId == 46 or actionId == 32 or actionId == 56 or actionId == 38 or actionId == 21 or actionId == 47) -- meditation, spirit speak, imbuing, tracking, hiding, stealth
	then 

		return false
	end

	return Interface.org_UserActionHasTargetType(hotbarId, itemIndex, subIndex)
end

Interface.org_pcall = nil
function Interface.pcall(func, param)
	--[[
	if Interface.AllFunctions == nil then
		Interface.AllFunctions = {}
		generateAllFunctionsTable()
	end

	local funcName = Interface.AllFunctions[tostring(func)]

	
	if funcName then
		local stringParams = funcName .. table.toString(param, true)

		local textEntry = L"(pcall)" .. towstring(stringParams)
	
		TextLogAddEntry( "UiLog", 5, textEntry)
	end
	--]]

	local ok, err, val1, val2, val3, val4, val5, val6, val7, val8, val9, val10 = Interface.org_pcall(func, param)	

	Interface.ErrorTracker(ok, err)

	return ok, err, val1, val2, val3, val4, val5, val6, val7, val8, val9, val10
end

Interface.org_WindowSetShowing = nil
function Interface.WindowSetShowing(windowName, showing)
	if not IsValidString(windowName) or not DoesWindowExist(windowName) then
		return
	end
	return Interface.org_WindowSetShowing(windowName, showing)
end

Interface.org_DragSlotSetObjectMouseClickData = nil
function Interface.DragSlotSetObjectMouseClickData(objectId, dragSource)
	if not IsValidID(objectId) then
		return
	end
	Interface.org_DragSlotSetObjectMouseClickData(objectId, dragSource)
	ContainerWindow.ResetPickupTimer()
end

Interface.org_RequestTargetInfo = nil
function Interface.RequestTargetInfo(func)

	-- get the function to execute for the target parsing
	Interface.RequestTargetFunction = func

	-- request the target
	Interface.org_RequestTargetInfo()
end

Interface.AbilitiesDataBuffer = {}
Interface.org_GetAbilityData = nil
function Interface.GetAbilityData(spellId)

	if not spellId then
		spellId = 0
	end

	-- return what we have in the buffer
	if Interface.AbilitiesDataBuffer[spellId] then

		-- data buffered
		local data = Interface.AbilitiesDataBuffer[spellId]

		return data.icon, data.serverId, data.tid, data.desctid, data.reagents, data.powerword, data.tithingcost, data.minskill, data.manacost, data.targetType
	
	else -- getting the spell data	
		local icon, serverId, tid, desctid, reagents, powerword, tithingcost, minskill, manacost, targetType  = Interface.org_GetAbilityData(spellId)

		local range = SpellsInfo.GetSpellDistance(spellId)

		local hasRange = range ~= nil

		Interface.AbilitiesDataBuffer[spellId] = {}

		Interface.AbilitiesDataBuffer[spellId].icon = icon
		Interface.AbilitiesDataBuffer[spellId].serverId = serverId
		Interface.AbilitiesDataBuffer[spellId].tid = tid
		Interface.AbilitiesDataBuffer[spellId].desctid = desctid
		Interface.AbilitiesDataBuffer[spellId].reagents = reagents
		Interface.AbilitiesDataBuffer[spellId].powerword = powerword
		Interface.AbilitiesDataBuffer[spellId].tithingcost = tithingcost
		Interface.AbilitiesDataBuffer[spellId].minskill = minskill
		Interface.AbilitiesDataBuffer[spellId].manacost = manacost
		Interface.AbilitiesDataBuffer[spellId].targetType = targetType
		Interface.AbilitiesDataBuffer[spellId].hasRange = hasRange
		Interface.AbilitiesDataBuffer[spellId].range = range

		return icon, serverId, tid, desctid, reagents, powerword, tithingcost, minskill, manacost, targetType
	end
end

Interface.org_GetStringFromTid = nil
function Interface.GetStringFromTid(tid, useUICliloc)

	-- do we have a valid tid?
	if not tid then
		return L""
	end

	-- is the tid a wstring? convert it to string
	if type(tid) == "wstring" then
		tid = tostring(tid)
	end

	-- is the tid a string? convert it to number
	if type(tid) == "string" then
		tid = tonumber(tid)
	end

	-- check again if the tid is valid (in case the previous conversions returns nil)
	if not tid then
		return L""
	end

	-- shall we use the UI cliloc (yes by default)
	if useUICliloc == nil then
		useUICliloc = true
	end

	-- all tid previous to 500000 are UI cliloc (if the UI cliloc is enabled)
	if tid < 500000 and useUICliloc == true then
		return GetCliloc(tid) or L""
	end

	-- return the string
	return Interface.org_GetStringFromTid(tid) or L""
end

Interface.org_DragSlotAutoPickupObject = nil
function Interface.DragSlotAutoPickupObject(objectId)
	if not IsValidID(objectId)  then
		return
	end
	Interface.org_DragSlotAutoPickupObject(objectId)
	ContainerWindow.ResetPickupTimer()
end

Interface.org_MoveItemToContainer = nil
function Interface.MoveItemToContainer(objectId, amount, container)
	if not IsValidID(objectId) or not IsValidID(amount) or not IsValidID(container) then
		return
	end
	Interface.org_MoveItemToContainer(objectId, amount, container)
	ContainerWindow.ResetPickupTimer()
end

Interface.org_ButtonSetPressedFlag = nil
function Interface.ButtonSetPressedFlag(button, presed)
	if not IsValidString(button) then
		return
	end
	if not DoesWindowExist(button) then
		return
	end
	if button == "MainMenuWindowExitGameItem" then
		button = "MainMenuWindowExitGameItemButton"
	end
	return Interface.org_ButtonSetPressedFlag(button, presed)
end

Interface.org_DoesWindowNameExist = nil
function Interface.DoesWindowNameExist(str)
	if not IsValidString(str) then
		return false
	end
	return Interface.org_DoesWindowNameExist(str)
end

Interface.org_DoesWindowExist = nil
function Interface.DoesWindowExist(str)
	if not IsValidString(str) then
		return false
	end
	return Interface.org_DoesWindowExist(str)
end

Interface.org_IsHealthBarEnabled = nil
function Interface.IsHealthBarEnabled(mobileId)

	local enabled = Interface.org_IsHealthBarEnabled(mobileId)
	
	return enabled
end

Interface.org_WindowSetMoving = nil
function Interface.WindowSetMoving(windowName, moving)
	Interface.IsDraggingAWindow = moving
	table.insert(Interface.DragWindows, windowName)
	Interface.org_WindowSetMoving(windowName, moving)
end

Interface.org_CreateWindow = nil
function Interface.CreateWindow(windowName, show)

	return Interface.org_CreateWindow(windowName, show)
end

Interface.org_IsMobile = nil
function Interface.IsMobile(id)
	if not IsValidID(id) then
		return
	end
	if not VerifyMobileID(id) then
		return false
	end
	return Interface.org_IsMobile(id)
end

Interface.org_UnregisterWindowData = nil
function Interface.UnregisterWindowData(type, id, forced)

	-- do we have a valid type and ID?
	if not type or not id then
		return
	end
	
	-- remove the unregister timer
	if Interface.WindowDataReleaseTime[type] then
		Interface.WindowDataReleaseTime[type][id] = nil
	end

	-- do we have to unregister this no matter what?
	if not forced then
	--[[
		if type == WindowData.MobileStatus.Type then
			if Interface.IsStatusInUse(id) then
				return
			end

		elseif type == WindowData.HealthBarColor.Type then
			if Interface.IsStatusInUse(id) then
				return
			end

		elseif type == WindowData.Paperdoll.Type then
			if PaperdollWindow.OpenPaperdolls[id] then
				return
			else
				PaperdollWindow.ItemsProps[id] = nil
			end

		elseif type == WindowData.MobileName.Type then
			if Interface.IsNameInUse(id) then
				return
			end

		else--]]
		if type == WindowData.ObjectInfo.Type then
			if Interface.IsObjectInUse(id) then
				return
			end

		elseif type == WindowData.ObjectTypeQuantity.Type then
			if Interface.IsObjectInUse(id) then
				return
			end

		elseif type == WindowData.ItemProperties.Type then
			if ItemProperties.IsCurrentHover(id) then
				return
			end

		elseif type == WindowData.ContainerWindow.Type then
			if ContainerWindow.OpenContainers[id] then
				return
			end
		end
	end

	-- unregister the data
	Interface.org_UnregisterWindowData(type, id)

	-- have we removed the mobile status?
	if type == WindowData.MobileStatus.Type then

		-- remove the status from the active mobiles on screen data too
		Interface.RemoveMobileOnScreenStatus(id)
	end
end

Interface.WindowDataReleaseTime = {}
Interface.org_RegisterWindowData = nil
function Interface.RegisterWindowData(type, id, unregisterFirst)

	-- do we have a valid type and ID?
	if not type or not id then
		return
	end

	-- get the windowdata table name
	local tableName = Interface.WindowDataTableNames[type]
	
	-- is the table name unavailable?
	if not tableName then

		-- calculate the table name
		_, tableName = Interface.GetWindowDataByType(type, id)
	end
	--Debug.Print(tostring(tableName) .. id)
	-- do we have to unregister first? make sure we have the data first
	if unregisterFirst and (type == WindowData.PlayerStatus.Type or WindowData[tableName][id] ~= nil) then
		UnregisterWindowData(type, id)
	end

	-- are we registering the mobile status?
	if type == WindowData.MobileStatus.Type then

		-- remove the current status data so we can get updated values
		Interface.RemoveMobileOnScreenStatus(id)
	end

	-- if is one of the following type we ceate a timer
	if	type == WindowData.ObjectTypeQuantity.Type or
		type == WindowData.ObjectInfo.Type or
		type == WindowData.MobileName.Type or
		type == WindowData.Paperdoll.Type or
		type == WindowData.MobileStatus.Type or
		type == WindowData.ItemProperties.Type or
		type == WindowData.ContainerWindow.Type or
		type == WindowData.Spellbook.Type
	then

		-- initialize the release time
		if not Interface.WindowDataReleaseTime[type] then
			Interface.WindowDataReleaseTime[type] = {}
		end

		-- the registered object will be ready for release shortly but not before.
		-- this will work for anything except calls with ID 0
		if not Interface.WindowDataReleaseTime[type][id] then
			Interface.WindowDataReleaseTime[type][id] = Interface.TimeSinceLogin + 1
		end
	end
	
	-- register the data
	Interface.org_RegisterWindowData(type, id)
end

Interface.org_WindowUnregisterEventHandler = nil
function Interface.WindowUnregisterEventHandler(window, id)
	if not IsValidID(id) or not IsValidString(window) then
		return
	end

	-- remove the event from the table
	if Interface.RegisteredEvents[window] and Interface.RegisteredEvents[window][id] then
		Interface.RegisteredEvents[window][id] = nil
	end

	Interface.org_WindowUnregisterEventHandler(window, id)
end

Interface.org_WindowRegisterEventHandler = nil
function Interface.WindowRegisterEventHandler(window, id, callback)
	if not IsValidID(id) then
		if Interface.DebugMode then
			Debug.Print(window .. " is trying to register an event 0 or nil!!! - CALLBACK: " .. callback)
		end
		return
	end

	-- is this event attach to the root main window?
	if window == "Root" then

		-- create the window events table
		if not Interface.RegisteredEvents[window] then
			Interface.RegisteredEvents[window] = {}
		end

		-- flag the event as registered
		Interface.RegisteredEvents[window][id] = true
	end

	Interface.org_WindowRegisterEventHandler(window, id, callback)
end

Interface.org_RequestContextMenu = nil
function Interface.RequestContextMenu(id, visible)

	-- is the context menu visible or we have a cursor target or the shop is open?
	if ContextMenu.IsShowing() or (WindowData.Cursor and WindowData.Cursor.target == true) or GenericGump.NextisShop ~= nil then

		-- cancel the context menu call
		return "not now"
	end

	-- do we have to show the context menu?
	if visible == nil or visible == true then

		-- nullify any automated call for this ID (if we had any)
		ContextMenu.AutomatedCall[id] = nil

	else -- flag this as an automated call
		ContextMenu.AutomatedCall[id] = true
	end

	-- cleanup the context menu data
	ContextMenu.CleanUp()

	-- store the window name that is calling for a context menu
	ContextMenu.SenderWindow = WindowUtils.GetActiveDialog()

	-- request the context menu
	Interface.org_RequestContextMenu(id)
end

Interface.org_DragSlotQuantityRequestResult = nil
function Interface.DragSlotQuantityRequestResult(amount)
	SystemData.DragItem.DragAmount = amount 
	Interface.org_DragSlotQuantityRequestResult(amount)
end

Interface.org_HandleSingleLeftClkTarget = nil
function Interface.HandleSingleLeftClkTarget(id)

	-- can we target the mobile safely?
	if IsValidID(id) and not Interface.CheckTarget(id, true) then
		return
	end
	
	-- target the mobile
	Interface.org_HandleSingleLeftClkTarget(id)

	-- do we have the cursor table?
	if WindowData.Cursor then

		-- save the last target in there
		WindowData.Cursor.lastTarget = id
	end

	-- post-target event
	Interface.OnTarget(0, id)
end

function Interface.RenamePet(mobileId)
	if not IsValidID(mobileId) then
		return
	end
	if not IsMobile(mobileId) then
		return
	end
	local rdata = {}
	rdata.text = wstring.trim(GetMobileName(mobileId))
	rdata.subtitle = GetStringFromTid(1115558)
	rdata.title = GetStringFromTid(1155270)
	rdata.callfunction =  Interface.RenameComplete
	rdata.id = mobileId
	rdata.maxChars = 255
	RenameWindow.Create(rdata)
end

function Interface.RenameComplete()
	local mobileId = RenameWindow.id 
	WindowData.Pets.RenameId = mobileId
	WindowData.Pets.Name = tostring(RenameWindow.TextEntered)
	BroadcastEvent(SystemData.Events.RENAME_MOBILE)	
	
	Interface.AddTodoList({name = "Update Mount Name", func = function() MountsList.UpdateMountName(mobileId, RenameWindow.TextEntered) TargetWindow.UpdateName(mobileId) end, time = Interface.TimeSinceLogin + 1})
end

-------------------------------------------------------------------------------
--
-- OTHER
--
-------------------------------------------------------------------------------

function Interface.RemoveMobileOnScreenStatus(id)
	
	-- get the mobile status
	local mobileStatus = Interface.ActiveMobilesOnScreen[id]

	-- is this the mobile data and we have the mobile on screen data?
	if mobileStatus and id ~= GetPlayerID() and mobileStatus.maxHealth then

		-- remove the status data
		mobileStatus.curHealth = nil
		mobileStatus.maxHealth = nil
		mobileStatus.dead = nil
		mobileStatus.perc = nil
		mobileStatus.curMana = nil
		mobileStatus.maxMana = nil
		mobileStatus.curStamina = nil
		mobileStatus.maxStamina = nil
		
		-- update the status for the mobile
		Interface.UpdateMobileStatus_final(id)
	end
end

function Interface.CheckTarget(id, noInvulnerable)
	
	-- make sure we have a valid ID
	if not IsValidID(id) then
		return false
	end

	-- do we have a protected last spell?
	if Interface.ProtectedLastSpell then

		-- get the target type limitation
		local noSelf, cursorOnly = GetActionTargetTypes(Interface.ProtectedLastSpell, SystemData.UserAction.TYPE_SPELL)
	
		-- there is no target self and the target is the player?
		if noSelf and id == GetPlayerID() then

			-- prevent the targeting
			return false
		end
		
		-- get the spell max distance
		local spellDistance = SpellsInfo.GetSpellDistance(Interface.ProtectedLastSpell)

		-- this spells requires to target objects
		if SpellsInfo.TargetObjectSpells[Interface.ProtectedLastSpell] and (not spellDistance or (spellDistance and GetDistanceFromPlayer(id) <= spellDistance)) then
			return true
		end

		-- if the target is cursor only is usually an area spell so we can exclude those
		if not cursorOnly and IsValidID(id) then

			-- is the target beyond the maximum spell distance?
			if spellDistance and GetDistanceFromPlayer(id) > spellDistance or noInvulnerable and IsMobileInvulnerable(id) then

				-- prevent the targeting
				return false
			end
		end

	-- do we have a protected last skill?
	elseif Interface.LastSkillProtected then

		-- get the target type limitation
		local noSelf, cursorOnly = GetActionTargetTypes(Interface.LastSkillProtected, SystemData.UserAction.TYPE_SKILL)
	
		-- there is no target self and the target is the player?
		if noSelf and id == GetPlayerID() then

			-- prevent the targeting
			return false
		end

		-- do we need to target an instrument?
		if TextParsing.InstrumentCheck then

			-- is the target a mobile?
			if IsMobile(id) then
				return false

			else -- targetted an item

				-- does the player has the item and it's a musical instrument?
				if DoesPlayerHaveItem(id) and ItemPropertiesInfo.MusicalInstrumentsDB[GetItemType(id)] then
					return true
					
				else -- if it's not an instrument we must not target it
					return false
				end
			end
		end

		-- do we have a stealing request for an item inside a container? we mark the target as valid since we don't have an efficient way to calculate the distance from the container.
		if Interface.LastSkillProtected == SkillsWindow.SkillsID.STEALING and ContainerWindow.IsObjectRegistered(id) then
			return true
		end

		-- get the skill max distance
		local skillDistance = SkillsWindow.GetSkillDistance(Interface.LastSkillProtected)

		-- for animal lore, the invulnerable target are ok as long as they are creatures
		noInvulnerable = not (Interface.LastSkillProtected and Interface.LastSkillProtected == SkillsWindow.SkillsID.ANIMAL_LORE and not DoesBodyHasPaperdoll(id))

		-- is the target beyond the maximum spell distance?
		if (skillDistance and GetDistanceFromPlayer(id) > skillDistance) or (noInvulnerable and IsMobileInvulnerable(id)) then

			-- prevent the targeting
			return false
		end
	end

	return true
end

Interface.WindowDataTableNames = {}
function Interface.GetWindowDataByType(typ, id)

	-- do we have a valid type and ID?
	if not typ or not id then
		return
	end
	
	-- is this the player status?
	if typ == WindowData.PlayerStatus.Type then
		return WindowData.PlayerStatus
	end
	
	-- do we have the name stored?
	if Interface.WindowDataTableNames[typ] then
		return WindowData[Interface.WindowDataTableNames[typ]][id], Interface.WindowDataTableNames[typ]
	end
	
	-- scan all the window data tables
	for name, data in pairs(WindowData) do

		-- is this a table?
		if type(data) == "table" then

			-- is this the type we're looking for?
			if data.Type == typ then

				-- store the table name for future requests
				Interface.WindowDataTableNames[typ] = name

				-- return the data for the specified ID
				return data[id], name
			end
		end
	end
end

function Interface.IsModEnabled(searchName)
	local allmods = ModulesGetData()
	for i, data in pairs(allmods) do
		if data.name == searchName then
			return data.isEnabled
		end
	end
	return false
end

function Interface.ExecuteWhenAvailable(array)

	-- do we have a valid record for the custom events list?
	if array and array.check and array.callback then
		
		-- do we have a name?
		if not array.name then
			Debug.Print("Tried to add a custom event without a unique name!!!")
		end

		-- if there is no max time specified, we add a 10s by default of timeout (to avoid events piling up...)
		if not array.maxTime then
			array.maxTime = Interface.TimeSinceLogin + 10
		end

		-- scan all the current list and see if we already have one with the same name
		for i, data in pairsByKeys(Interface.CheckAvailableEvents) do

			-- does this one has the same name of the one we are adding?
			if data.name == array.name then
				return
			end
		end

		-- add to the custom events list
		table.insert(Interface.CheckAvailableEvents, array)
	end
end

function Interface.AddTodoList(array)

	-- do we have a valid record to add to the TODO list?
	if array and array.time and array.func then

		-- add to the TODO list
		table.insert(Interface.TODO, array)
	end
end

function Interface.GetPlayerEquipmentData(slotId)

	-- do we have a valid item ID?
	if not slotId then
		return
	end

	-- verify what we have at the moment
	local data = WindowData.PlayerEquipmentSlot[slotId]
	
	-- we don't have the data, so we register it
	if not data then
		
		-- get the object data from the server
		RegisterWindowData(WindowData.PlayerEquipmentSlot.Type, slotId)
		
		-- get the container data
		data = WindowData.PlayerEquipmentSlot[slotId]
	end
	
	-- return the data
	return data
end

function Interface.GetPlayerStatusData()

	-- verify what we have at the moment
	local status = WindowData.PlayerStatus --Interface.VerifyPlayerStatus()

	-- is the status unavailable?
	if not status or not WindowData.PlayerStatus.MaxHealth then
	
		-- register the player status
		RegisterWindowData(WindowData.PlayerStatus.Type, 0)

		-- we send the data as soon as it's available
		Interface.ExecuteWhenAvailable(
		{
			name = "WaitForPlayerStatus",
			check = function() return Interface.VerifyPlayerStatus() ~= nil end, 
			callback = function() end,
			failCallback = function() UnregisterWindowData(WindowData.PlayerStatus.Type, 0) Interface.GetPlayerStatusData() end,
			removeOnComplete = true,
			maxTime = Interface.TimeSinceLogin + 2
		})

		-- since the update status event of the client doesn't work correctly, we create one that works...
		Interface.ExecuteWhenAvailable(
		{
			name = "UpdatePlayerStatus",
			check = function() return StatusWindow.prevHP ~= WindowData.PlayerStatus.CurrentHealth or StatusWindow.prevMana ~= WindowData.PlayerStatus.CurrentMana or StatusWindow.prevStam ~= WindowData.PlayerStatus.CurrentStamina or StatusWindow.prevAlwaysRun ~= SystemData.Settings.GameOptions.alwaysRun end, 
			callback = function() Interface.UpdatePlayerStatus() end,
			removeOnComplete = false,
			maxTime = math.huge
		})
	end

	-- return the current data
	return Interface.VerifyPlayerStatus()
end

function Interface.VerifyPlayerStatus()

	-- get the player status
	local status = WindowData.PlayerStatus

	-- verify the player status by checking some values making sure they are not nil or 0
	if status and (WindowData.PlayerStatus.MaxHealth == 0 or not IsValidID(WindowData.PlayerStatus.PlayerId))  then
		status = nil
	end

	-- return the real status
	return status
end

function Interface.GetContainersData(objectId)

	-- do we have a valid item ID?
	if not IsValidID(objectId) then
		return
	end

	-- verify what we have at the moment
	local data = WindowData.ContainerWindow[objectId]
	
	-- we don't have the container data, so we register it
	if not data or ContainerWindow.ViewModes[objectId] == "Freeform" then
		
		-- get the object data from the server
		RegisterWindowData(WindowData.ContainerWindow.Type, objectId)

		-- get the container data
		data = WindowData.ContainerWindow[objectId]
	end

	-- return the data
	return data
end

function Interface.VerifyContainer(objectId, contInfo)

	-- container contents check
	if contInfo and (not contInfo.ContainedItems and contInfo.numItems > 0) then
		contInfo = nil
	end

	-- return the real container info
	return contInfo
end

function Interface.GetItemSpellbookData(objectId)

	-- do we have a valid item ID?
	if not IsValidID(objectId) then
		return
	end

	-- verify what we have at the moment
	local data = WindowData.Spellbook[objectId]

	-- we don't have the data, so we register it
	if not data then
		
		-- get the object data from the server
		RegisterWindowData(WindowData.Spellbook.Type, objectId)

		-- get the item properties
		data = WindowData.Spellbook[objectId]
	end
	
	-- return the data
	return data
end

function Interface.GetItemPropertiesData(objectId)

	-- do we have a valid item ID?
	if not IsValidID(objectId) then
		return
	end

	-- verify what we have at the moment
	local data = WindowData.ItemProperties[objectId]

	-- we don't have the item properties data, so we register it
	if not data then
	
		-- get the object data from the server
		RegisterWindowData(WindowData.ItemProperties.Type, objectId)

		-- get the item properties
		data = WindowData.ItemProperties[objectId]
	end

	-- return the data
	return data
end

function Interface.GetObjectQuantityData(objectId)

	-- do we have a valid item ID?
	if not IsValidID(objectId) then
		return
	end

	-- verify what we have at the moment
	local objectQuantity = WindowData.ObjectTypeQuantity[objectId]

	-- is the object already registered?
	if objectQuantity then

		-- return the data
		return objectQuantity
	end

	-- we don't have the item data, so we register it
	if not objectQuantity then
		
		-- get the object data from the server
		RegisterWindowData(WindowData.ObjectTypeQuantity.Type, objectId)

		-- get the object quantity
		objectQuantity = WindowData.ObjectTypeQuantity[objectId]
	end

	-- return the data
	return objectQuantity
end


function Interface.GetObjectInfoData(objectId)
	
	-- do we have a valid item ID?
	if not IsValidID(objectId) then
		return
	end

	-- verify what we have at the moment
	local objectInfo = WindowData.ObjectInfo[objectId]

	-- we don't have the item data, so we register it
	if not objectInfo then
		
		-- get the object data from the server
		RegisterWindowData(WindowData.ObjectInfo.Type, objectId)

		-- update the object info
		objectInfo = Interface.VerifyObjectName(objectId, WindowData.ObjectInfo[objectId])

		-- we show the name as soon as it's available
		Interface.ExecuteWhenAvailable(
		{
			name = "FaketemDataUpdate" .. objectId,
			check = function() return not Interface.VerifyObjectName(objectId, WindowData.ObjectInfo[objectId]) or Shopkeeper.HasItem(mobileId) end, 
			callback = function() end,
			failCallback = function() UnregisterWindowData(WindowData.ObjectInfo.Type, objectId) end,
			removeOnComplete = true,
			maxTime = Interface.TimeSinceLogin + 2
		})
	end

	-- return the data
	return objectInfo
end

function Interface.VerifyObjectName(objectId, objectInfo)

	-- name check for items, if nil or empty or it has no icon the data is not inside a shopkeeper inventory, the data is invalid
	-- shopkeeper items have no name for some reason...
	if objectInfo and (not IsValidWString(objectInfo.name) or not IsValidString(objectInfo.iconName)) and not Shopkeeper.HasItem(objectId)  then
		objectInfo = nil
	end

	-- return the real object info
	return objectInfo
end

function Interface.GetPaperdollData(mobileId)

	-- do we have a valid mobile ID?
	if not IsValidID(mobileId) then
		return
	end

	-- verify what we have at the moment
	local paperdollData = WindowData.Paperdoll[mobileId]

	-- we don't have the paperdoll data, so we register it
	if not paperdollData then
		
		-- get the mobile paperdoll data from the server
		RegisterWindowData(WindowData.Paperdoll.Type, mobileId)

		-- verify the data we obtained once again
		paperdollData = WindowData.Paperdoll[mobileId]
	end

	-- return the data
	return paperdollData
end

function Interface.VerifyPaperdollData(mobileId, paperdollData)

	-- do we have the paperdoll data?
	if not paperdollData then
		return
	end

	-- get the backpack ID
	local backpackId = paperdollData.backpackId
	
	-- items count of the items worn by the mobile
	local itemsCount = 0

	-- scan all the items worn by the mobile
	for i = 1, paperdollData.numSlots do

		-- get the item ID
		local slotId = paperdollData[i].slotId

		-- is this a valid item ID?
		if IsValidID(slotId) then

			-- icrease the items count
			itemsCount = itemsCount + 1
		end
	end

	-- if the mobiles has no items and an invalid backpack, is a fake data
	if itemsCount == 0 and not IsValidID(backpackId) then

		-- delete the data
		WindowData.Paperdoll[mobileId] = nil

		return 
	end

	-- return the real paperdoll data
	return paperdollData
end

function Interface.GetMobileNameData(mobileId)

	-- do we have a valid mobile ID?
	if not IsValidID(mobileId) then
		return
	end

	-- verify what we have at the moment
	local mobileName = WindowData.MobileName[mobileId]

	-- we don't have the mobile data, so we register it
	if not mobileName then
		
		-- get the mobile name data from the server
		RegisterWindowData(WindowData.MobileName.Type, mobileId)
	end

	-- return the data
	return Interface.VerifyMobileName(mobileId, WindowData.MobileName[mobileId])
end

function Interface.VerifyMobileName(mobileId, mobileName)

	-- name check for mobiles, if nil or empty or it has no notoriety the data is not loaded correctly, and we have to retry.
	if mobileName and (not IsValidWString(mobileName.MobName) or mobileName.Notoriety+1 == NameColor.Notoriety.NONE) then
		mobileName = nil
	end

	-- return the real mobile name data
	return mobileName
end

function Interface.GetMobileData(mobileId)

	-- do we have a valid mobile ID?
	if not IsValidID(mobileId) then
		return
	end
	
	-- get the current riding pet
	local ridingPet = IsRiding(true)

	-- do we have a riding pet? we don't get the status for that
	if ridingPet and ridingPet == mobileId then
		return
	end

	-- make sure we don't have fake mobile data first
	Interface.KillFakeMobileData(mobileId)

	-- verify what we have at the moment
	local mobileData = WindowData.MobileStatus[mobileId]

	-- we don't have the mobile data, so we register it
	if not mobileData then

		-- get the mobile status data from the server
		RegisterWindowData(WindowData.MobileStatus.Type, mobileId)

		-- remove the fake mobile data we we have it, and get out so we can try again later
		if Interface.KillFakeMobileData(mobileId) then
			return
		end

		-- get the mobile bar colors (the color is useless without the status anyway so we work them as a couple with the status)
		-- the player has this value stored in the playerdata
		if mobileId ~= GetPlayerID() then
			RegisterWindowData(WindowData.HealthBarColor.Type, mobileId)
		end

		-- verify the data we obtained once again
		mobileData = Interface.VerifyMobileData(mobileId, WindowData.MobileStatus[mobileId])
	end

	-- return the data
	return mobileData
end

function Interface.KillFakeMobileData(mobileId)
	
	-- do we have a fake mobile data? we have to remove it immediately before it contaminates the table
	if Interface.IsFakeMobileData(WindowData.MobileStatus[mobileId]) and not Shopkeeper.HasItem(mobileId) and mobileId ~= GetPlayerID() then
			
		-- we unregister and manually nullify fake records
		UnregisterWindowData(WindowData.MobileStatus.Type, mobileId, true)
		WindowData.MobileStatus[mobileId] = nil

		return true
	end
end

function Interface.IsFakeMobileData(mobileData)
	
	-- make sure we have a mobileData
	if mobileData then
		
		-- if all is 0 and there is no name, is a fake mobile data record
		if	mobileData.MaxHealth == 0 and
			mobileData.MaxMana == 0 and
			mobileData.MaxStamina == 0 and
			mobileData.CurrentHealth == 0 and
			mobileData.CurrentMana == 0 and
			mobileData.CurrentStamina == 0 and
			mobileData.Gender == 0 and
			mobileData.Notoriety == 0 and
			not IsValidWString(mobileData.mobName)
		then

			return true
		end
	end

	return false
end

function Interface.VerifyMobileData(mobileId, mobileData)

	-- hp check for mobiles, if 0 the data is not loaded correctly, and we have to retry (no correct hp checks for invulnerable mobiles)
	if mobileData and Interface.IsFakeMobileData(mobileData) and mobileId ~= GetPlayerID() then
		mobileData = nil
	end

	-- return the real mobile data
	return mobileData
end

function Interface.IsHealthbarActive(mobileId)
	if	(MobileHealthBar.ActiveBars[mobileId] and not MobileHealthBar.ActiveBars[mobileId].disabled ) or
		((WindowData.CurrentTarget.TargetId == mobileId or TargetWindow.TargetId == mobileId)) or
		(OverheadText.hasHoverbar[mobileId] and WindowGetShowing("Hoverbar_" .. mobileId)) or
		mobileId == BossBar.GetActiveBoss()
	then
		return true
	end

	return false
end

function Interface.IsStatusInUse(mobileId, ignoreHealthbars)

	-- do we have a valid mobile ID?
	if not IsValidID(mobileId) then
		return false
	end

	-- is the distance less than 0? (mobile out of range or fake mobile)
	if GetDistanceFromPlayer(mobileId) < 0 then
		return false
	end

	-- get the mobile data
	local mobileData = WindowData.MobileStatus[mobileId]

	-- has the data been loaded correctly?
	if mobileData == nil or mobileData.MaxHealth == 0 then 
		return false
	end

	-- is this the current mount?
	if mobileId == IsRiding() then
		return false
	end

	-- get the current mobile health
	local curr = mobileData.CurrentHealth

	-- get the mobile max health
	local max = mobileData.MaxHealth

	if	(not ignoreHealthbars and Interface.IsHealthbarActive(mobileId)) or -- are we considering the healthbars and we have one active?
		ItemProperties.IsCurrentHover(mobileId) or -- are the properties for this mobile active?
		(IsMobileVisible(mobileId) and curr < max) or -- we don't need the status for mobiles full health, this exist only to keep working the small healthbar under the mobile's feet
		mobileId == GetPlayerID()
	then
		return true
	end

	return false
end

function Interface.IsPaperdollInUse(mobileId)

	-- do we have a valid mobile ID?
	if not IsValidID(mobileId) then
		return false
	end

	-- is the distance less than 0? (mobile out of range or fake mobile)
	if GetDistanceFromPlayer(mobileId) < 0 then
		return false
	end

	if	PaperdollWindow.OpenPaperdolls[mobileId] or -- is the paperdoll open?
		ItemProperties.IsCurrentHover(mobileId) or -- are the properties for this mobile active?
		PlayerVendor.MobileId == mobileId or -- is the paperdoll in use in the player vendor gump?
		(TargetWindow.HasValidTarget() and mobileId == TargetWindow.TargetId) -- is this the target window mobile?
	then
		return true
	end

	return false
end

function Interface.IsNameInUse(mobileId, ignoreHealthbars)

	-- do we have a valid mobile ID?
	if not IsValidID(mobileId) then
		return false
	end

	-- is the distance less than 0? (mobile out of range or fake mobile)
	if GetDistanceFromPlayer(mobileId) < 0 then
		return false
	end

	if	(not ignoreHealthbars and Interface.IsHealthbarActive(mobileId)) or -- are we considering the healthbars and we have one active?
		ItemProperties.IsCurrentHover(mobileId) or -- are the properties for this mobile active?
		Interface.PendingNames[mobileId] -- are we waiting the name data?
		--OverheadText.OverheadNameVisible(mobileId) -- is the overhead name visible?
	then
		return true
	end

	return false
end

function Interface.IsObjectInUse(itemId)

	-- do we have a valid item ID?
	if not IsValidID(itemId) then
		return false
	end

	if  Shopkeeper.HasItem(itemId) or -- is the item in the shopkeeper inventory that we're seeing?
		ItemProperties.IsCurrentHover(itemId) or -- are the properties for this item active?
		itemId == SystemData.DragItem.itemId or -- is this the item we're dragging?
		ObjectHandleWindow.hasWindow[itemId] or -- is this item shown in the object handles?
		ContainerWindow.OpenContainers[itemId] or -- is this item an open container?
		ContainerWindow.IsObjectRegistered(itemId) or -- is this object inside an open container?
		TradeWindow.IsObjectRegistered(itemId) or -- is this item being traded?
		DoesPlayerHaveItem(itemId) or -- does the player has this item with him?
		ActionEditWindow.IsRegisteredObject(itemId) or -- is the item used in the action editor?
		(TargetWindow.HasValidTarget() and itemId == TargetWindow.TargetId) -- is this the target window item?
	then
		return true
	end

	return false
end

function Interface.SavedVariablesPurge()
	if Interface.PurgeDone or not Interface.started then
		return
	end
	DyeTubs.SavedColorsFile = FixStructureAccountOnly(DyeTubs.SavedColorsFile)
	ContainerWindow.SavedFindItems = FixStructureWithPlayerID(ContainerWindow.SavedFindItems)
	Interface.LootSortOrder = FixStructureWithPlayerID(Interface.LootSortOrder)
	UserCustomWaypoints = FixStructureUserShard(UserCustomWaypoints)
	BuoyTool.Buoys = FixStructureWithPlayerID(BuoyTool.Buoys)
	Interface.SOSWaypointsAll = FixStructureWithPlayerID(Interface.SOSWaypointsAll)
	Interface.TmapWaypointsAll = FixStructureWithPlayerID(Interface.TmapWaypointsAll)
	SkillsWindow.RotSaved = FixStructureWithPlayerID(SkillsWindow.RotSaved)
	NewChatWindow.Settings = FixStructureUserShard(NewChatWindow.Settings)
	MobileHealthBar.SummonTimers = FixStructureWithPlayerID(MobileHealthBar.SummonTimers)
	MobileHealthBar.PetPowerHours = FixStructureWithPlayerID(MobileHealthBar.PetPowerHours)
	pcall(ContainerWindow.PurgeOldContainersData)
	Interface.PurgeDone = true
end

function Interface.Shutdown()

	-- flag that the interface is shutting down
	Interface.goingDown = true

	if IsValidID(WindowData.PlayerStatus.PlayerId) and Interface.PlayerID  ~= WindowData.PlayerStatus.PlayerId then
		Interface.SaveNumber("PlayerID", WindowData.PlayerStatus.PlayerId)
	end

	ECPlaySound(3, "", 1)

	-- get volumes
	local music = math.floor( Interface.ECMusic.volume * 7000 ) - 7000
	local effects = math.floor(  Interface.ECSound.volume * 7000 ) - 7000
	local heartbeat = math.floor( Interface.HeartBeat.volume * 7000 ) - 7000
	
	-- send the data to EC PlaySound
	TextLogCreate("Volume", 1)
	TextLogSetEnabled("Volume", true)
	TextLogClear("Volume")
	TextLogSetIncrementalSaving( "Volume", true, "logs/Volume.log")
		
	TextLogAddEntry("Volume", 1, L"music|"..music)
	TextLogAddEntry("Volume", 1, L"effects|"..effects)
	TextLogAddEntry("Volume", 1, L"heartbeat|"..heartbeat)
	TextLogDestroy("Volume")

	Interface.BackpackOpen = false
	Interface.PaperdollOpen = false
	pcall(SettingsWindow.DestroyContainers)
	ContainerWindow.OpenContainers = {}
	for id, wc in pairs(PaperdollWindow.OpenPaperdolls) do
		DestroyWindow("PaperdollWindow"..id)
	end

	-- setting the legacy container flag so we can see the legacy style
    SystemData.Settings.Interface.LegacyContainers = Interface.LegacyContBackup
	UserSettingsChanged()

	PaperdollWindow.OpenPaperdolls = {}
	pcall(UserSettingsChanged)
	pcall(QuickStats.Shutdown)
	pcall(EquipmentData.Shutdown)
	pcall(HotbarSystem.Shutdown)
	pcall(BuffDebuff.Shutdown)
	pcall(TradeWindow.OnCloseDialog)
	
	--Unload playerstatsData used for character sheet and the hotbar system
	UOUnloadCSVTable("PlayerStatsDataCSV")
	UOUnloadCSVTable("PlayerItemPropCSV")
	UOUnloadCSVTable("WeaponAbilityDataCSV")
	UOUnloadCSVTable("SkillsCSV")
	pcall(Interface.TotalUnregister)
	pcall(Debug.ParseDebugLog) 

	-- execute the logout procedure (the event doesn't work).
	--Interface.LogOut()
end

function Interface.ErrorTracker(success, error)
	if (not success and error ~= nil and (type(error) == "string" or type(error) == "wstring")) then
		Debug.Print(error)
	end
end

function Interface.TotalUnregister()
	for id, value in pairs(WindowData.MobileName) do
		if type(id) ~= number then
			continue
		end
		UnregisterWindowData(WindowData.MobileName.Type,id)
	end
	for mobileId, value in pairs(WindowData.Paperdoll) do
		if type(id) ~= number then
			continue
		end
		UnregisterWindowData(WindowData.Paperdoll.Type,id)
	end
	for mobileId, value in pairs(WindowData.MobileStatus) do
		if type(id) ~= number then
			continue
		end
		UnregisterWindowData(WindowData.MobileStatus.Type,id)
	end
	for mobileId, value in pairs(WindowData.ObjectInfo) do
		if type(id) ~= number then
			continue
		end
		UnregisterWindowData(WindowData.ObjectInfo.Type,id)
	end
	for mobileId, value in pairs(WindowData.ObjectTypeQuantity) do
		if type(id) ~= number then
			continue
		end
		UnregisterWindowData(WindowData.ObjectTypeQuantity.Type,id)
	end
	for mobileId, value in pairs(WindowData.ContainerWindow) do
		if type(id) ~= number then
			continue
		end
		UnregisterWindowData(WindowData.ContainerWindow.Type,id)
	end
	for mobileId, value in pairs(WindowData.ItemProperties) do
		if type(id) ~= number then
			continue
		end
		UnregisterWindowData(WindowData.ItemProperties.Type,id)
	end
	UnregisterWindowData(WindowData.PlayerStatus.Type,0)
	UnregisterWindowData(WindowData.PartyMember.Type, 0)
	UnregisterWindowData(WindowData.Pets.Type, 0)	
    UnregisterWindowData(WindowData.PlayerLocation.Type, 0)
	UnregisterWindowData(WindowData.CurrentTarget.Type, 0)
	UnregisterWindowData(WindowData.ItemProperties.Type, 0)
	UnregisterWindowData(WindowData.SkillList.Type, 0)
	UnregisterWindowData(WindowData.BuffDebuff.Type, 0)
	UnregisterWindowData(WindowData.Radar.Type, 0)
    UnregisterWindowData(WindowData.WaypointDisplay.Type, 0)
    UnregisterWindowData(WindowData.WaypointList.Type, 0)

	-- unregister all the events attached to the main game window (so any possible update will stop on login)
	for window, events in pairs(Interface.RegisteredEvents) do

		-- does the window exist?
		if DoesWindowExist(window) then

			-- scan all the events for the current window
			for id, _ in pairs(events) do
				
				-- remove the event
				WindowUnregisterEventHandler(window, id)
			end
		end
	end
end

function Interface.ScanMobilesOnScreen()

	-- get all the mobiles on screen
	local allMobiles = GetAllMobileTargets()

	-- has the active mobiles array been initialized?
	if not Interface.ActiveMobilesOnScreen then
		Interface.ActiveMobilesOnScreen = {}
	end

	-- this table will be used to store only the mobiles currently visible
	-- any mobile not on this table is no longer on the screen and will be removed from the main table
	local doubleCheckTable = {}

	-- count the data record to be gathered
	local dataToGet = 0

	-- scan all mobiles
	for i, mobileId in pairsByIndex(allMobiles) do

		-- is the mobile in a visible distance?
		if not IsMobileVisible(mobileId) then

			-- remove the record of this mobile if exist
			Interface.ActiveMobilesOnScreen[mobileId] = nil

			-- trigger the event for the mobile leaving the screen
			Interface.MobileLeftScreen(mobileId)

			continue
		end

		-- is this mobile a boss or it has been marked as boss?
		if (Interface.ActiveMobilesOnScreen[mobileId] and Interface.ActiveMobilesOnScreen[mobileId].isBoss == true) or mobileId == BossBar.GetActiveBoss() then 

			-- activate the boss bar
			BossBar.AttachBossBar(mobileId)
		end

		-- add to the double check table
		doubleCheckTable[mobileId] = true
		
		-- do we have the record for the mobile?
		if not Interface.ActiveMobilesOnScreen[mobileId] then
			
			-- create a new record
			Interface.ActiveMobilesOnScreen[mobileId] = {}

			-- updating the summon timer and checking if the mobile is a summon after half second (so all the info about it will be available)
			if IsObjectIdPet(mobileId) then

				-- get the mobile name
				local mobName = GetMobileName(mobileId)

				-- start to check the if it's a summon
				MobileHealthBar.DelayedSummonCheck(mobName, mobileId)
			end

			-- get the mobile name data
			Interface.UpdateMobileOnScreenName(mobileId)
			
			-- do we have the mobile status and the mobile is NOT invulnerable?
			if mobileId == GetPlayerID() or (Interface.IsStatusInUse(mobileId) and (Interface.ActiveMobilesOnScreen[mobileId] and not Interface.ActiveMobilesOnScreen[mobileId].invulnerable)) then
			
				-- get the status data
				Interface.UpdateMobileOnScreenStatus(mobileId)
			end

			-- trigger the "New Mobile On Screen" event
			Interface.NewMobileOnScreen(mobileId)
		end

		-- update the mobile index
		if Interface.ActiveMobilesOnScreen[mobileId] then
			Interface.ActiveMobilesOnScreen[mobileId].index = i
		end
	end

	-- scan the current mobiles list
	for mob, data in pairs(Interface.ActiveMobilesOnScreen) do

		-- get the healthbar data
		local barData = MobileHealthBar.ActiveBars[mob]

		-- do we have the healthbar?
		if barData then

			-- do we have a normal healthbar for an invulnerable mobile?
			if	barData.type ~= MobileHealthBar.HealthbarsType.PARTY and IsPartyMember(mob) or
				barData.type == MobileHealthBar.HealthbarsType.PARTY and not IsPartyMember(mob) or
				barData.type ~= MobileHealthBar.HealthbarsType.PET and IsObjectIdPet(mob) or
				barData.type == MobileHealthBar.HealthbarsType.PET and not IsObjectIdPet(mob) or
				MobileHealthBar.IgnoredMobile(mob)
			then

				-- destroy the current healthbar and let the system create a new one
				MobileHealthBar.CloseBarByID(mob, "Wrong bar type, need to re-create")
			end
		end

		-- is this mobile on the screen right now?
		if not doubleCheckTable[mob] then

			-- remove the mobile from the current list
			Interface.ActiveMobilesOnScreen[mob] = nil

			-- trigger the event for the mobile leaving the screen
			Interface.MobileLeftScreen(mob)
		end
	end

	-- scan the current mobiles healthbars
	for mob, data in pairs(MobileHealthBar.ActiveBars) do

		-- is the mobile in a visible distance?
		if not IsMobileVisible(mob) then
			
			-- trigger the event for the mobile leaving the screen
			Interface.MobileLeftScreen(mob)
		end
	end
end

function Interface.UpdateMobileOnScreenStatus(mobileId)
	
	-- has the active mobiles array been initialized?
	if not Interface.ActiveMobilesOnScreen then
		Interface.ActiveMobilesOnScreen = {}
	end

	-- checking the mobileID is correct and it's not the player id
	if not IsValidID(mobileId) then
		return
	end

	-- is the mobile in a visible distance?
	if not IsMobileVisible(mobileId) then

		-- remove the record of this mobile if exist
		Interface.ActiveMobilesOnScreen[mobileId] = nil

		return
	end
	
	-- is this a new mobile?
	local isNewMobile = false

	-- do we have the record for the mobile?
	if not Interface.ActiveMobilesOnScreen[mobileId] then
			
		-- create a new record
		Interface.ActiveMobilesOnScreen[mobileId] = {}

		-- flag this as new mobile
		isNewMobile = true
	end

	-- current mobile record
	local mobileStatus = Interface.ActiveMobilesOnScreen[mobileId]

	-- is the mobile invulnerable? no need to get the status for those...
	if not mobileStatus.invulnerable then
	
		-- is this a party member? if it is we also get the party ID
		mobileStatus.isParty, mobileStatus.partyIndex = IsPartyMember(mobileId)

		-- is this a normal mobile (not party, not pet) and the mobiles settings are showing?
		if not mobileStatus.isParty and not IsObjectIdPet(mobileId) and DoesWindowExist(MobileBarsDockspot.DockspotDefaultNames[MobileBarsDockspot.DockspotType.MOBILES .. "Settings"]) then

			-- does the mobile doesn't have an healthbar or is pinned?
			if not MobileHealthBar.ActiveBars[mobileId] or (MobileHealthBar.ActiveBars[mobileId] and not MobileHealthBar.ActiveBars[mobileId].pinned) then
				return
			end
		end

		-- is this the party leader?
		mobileStatus.isPartyLeader = WindowData.PartyMember.partyLeaderId == mobileId

		-- get mobile's health status
		mobileStatus.curHealth, mobileStatus.maxHealth, mobileStatus.dead, mobileStatus.perc, mobileStatus.curMana, mobileStatus.maxMana, mobileStatus.curStamina, mobileStatus.maxStamina = GetMobileHealth(mobileId, true)

		-- do we have the mobile status?
		if mobileStatus.curHealth == 0 and mobileStatus.maxHealth == 0 then

			-- try again in a short while
			Interface.ExecuteWhenAvailable(
			{
				name = "WaitForStatus" .. mobileId,
				check = function() local curHealth, maxHealth = GetMobileHealth(mobileId, true) return maxHealth and maxHealth > 0 end, 
				callback = function() Interface.UpdateMobileOnScreenStatus(mobileId) end, 
				failCallback = function() if Interface.IsStatusInUse(mobileId) then Interface.GetMobileData(mobileId) Interface.UpdateMobileOnScreenStatus(mobileId) end end,
				removeOnComplete = true
			})
		end
	end

	-- is this a new mobile?
	if isNewMobile then

		-- update the mobile name data
		Interface.UpdateMobileOnScreenName(mobileId)

		-- trigger the "New Mobile On Screen" event
		Interface.NewMobileOnScreen(mobileId)
	end
end

Interface.PendingNames = {}
function Interface.UpdateMobileOnScreenName(mobileId)
	
	-- has the active mobiles array been initialized?
	if not Interface.ActiveMobilesOnScreen then
		Interface.ActiveMobilesOnScreen = {}
	end

	-- checking the mobileID is correct and it's not the player id
	if not IsValidID(mobileId) then
		return
	end

	-- is the mobile in a visible distance?
	if not IsMobileVisible(mobileId) then

		-- remove the record of this mobile if exist
		Interface.ActiveMobilesOnScreen[mobileId] = nil

		return
	end

	if Interface.VerifyMobileName(mobileId, WindowData.MobileName[mobileId]) == nil or GetMobileNotoriety(mobileId) == NameColor.Notoriety.NONE or not IsValidWString(GetMobileName(mobileId)) then

		-- add to the pending names table
		Interface.PendingNames[mobileId] = true

		-- register the window data for the mobile
		Interface.ExecuteWhenAvailable(
		{
			name = "WaitingForMobileName" .. mobileId,
			check = function() return Interface.VerifyMobileName(mobileId, WindowData.MobileName[mobileId]) ~= nil and GetMobileNotoriety(mobileId) ~= NameColor.Notoriety.NONE and IsValidWString(GetMobileName(mobileId)) end, 
			callback = function() Interface.UpdateMobileOnScreenName(mobileId) end,
			removeOnComplete = true,
			maxTime = Interface.TimeSinceLogin + 2
		})

		return
	end

	-- is this a new mobile?
	local isNewMobile = false

	-- do we have the record for the mobile?
	if not Interface.ActiveMobilesOnScreen[mobileId] then
			
		-- create a new record
		Interface.ActiveMobilesOnScreen[mobileId] = {}
			
		-- flag this as new mobile
		isNewMobile = true
	end

	-- current mobile record
	local mobileStatus = Interface.ActiveMobilesOnScreen[mobileId]

	-- clean up the mobile name (if it returns true, the name has changed)
	local forced = Interface.UpdateMobileOnScreenCleanName(mobileId)

	-- get mobile's notoriety
	mobileStatus.notoriety = GetMobileNotoriety(mobileId)

	-- is the mobile invulnerable?
	mobileStatus.invulnerable = IsMobileInvulnerable(mobileId)

	-- do we have a valid name?
	if MobileHealthBar.IgnoredMobile(mobileId) then

		-- remove the record
		Interface.ActiveMobilesOnScreen[mobileId] = nil

		return
	end

	-- have we already determine if this mobile is a boss?
	if mobileStatus.isBoss == nil and not mobileStatus.isSomeonePet then

		-- get the formatted mobile DB name 
		mobileStatus.DBName = CreaturesDB.FindCompatibleCreatures(mobileId, true)
		
		-- do we have a compatible creature?
		if mobileStatus.DBName then

			-- check the compatible creatures list
			for i, data in pairs(mobileStatus.DBName) do

				-- get the boss flag
				mobileStatus.isBoss = data.isboss
				
				-- if we found a boss we can stop looking
				if data.isboss then
					break
				end
			end
		end
	end

	-- update the flags (like vendor, questgiver, etc...)
	Interface.UpdateMobileOnScreenNameFlags(mobileId, forced)

	-- is this mobile a boss?
	if mobileStatus.isBoss == true then 

		-- activate the boss bar
		BossBar.AttachBossBar(mobileId)
	end

	-- is this a new mobile?
	if isNewMobile then

		-- update the mobile status data
		Interface.UpdateMobileOnScreenStatus(mobileId)

		-- trigger the "New Mobile On Screen" event
		Interface.NewMobileOnScreen(mobileId)
	end

	-- remove from the pending names table
	Interface.PendingNames[mobileId] = nil
end

function Interface.UpdateMobileOnScreenCleanName(mobileId)

	-- checking the mobileID is correct and it's not the player id
	if not IsValidID(mobileId) then
		return
	end

	-- do we have the record for the mobile?
	if not Interface.ActiveMobilesOnScreen[mobileId] then
		return
	end

	-- current mobile data record
	local mobileStatus = Interface.ActiveMobilesOnScreen[mobileId]

	-- do we have the mobile data?
	if not mobileStatus then
		return
	end

	-- store the old name
	local oldName = mobileStatus.name

	-- get the mobile name
	mobileStatus.name = GetMobileName(mobileId)

	-- get the name without the title
	mobileStatus.cleanName = StripNameTitle(mobileStatus.name)

	-- get the mobile title
	mobileStatus.title = GetNameTitle(mobileStatus.name)

	if oldName ~= mobileStatus.name then
		return true
	end
end

Interface.MobileFlagsUpdateTime = {}
function Interface.UpdateMobileOnScreenNameFlags(mobileId, forced)
	-- if forced, we update all the false values too.

	-- checking the mobileID is correct and it's not the player id
	if not IsValidID(mobileId) then
		return
	end

	-- do we have the record for the mobile?
	if not Interface.ActiveMobilesOnScreen[mobileId] then
		return
	end

	-- current mobile data record
	local mobileStatus = Interface.ActiveMobilesOnScreen[mobileId]

	-- do we have the mobile data?
	if not mobileStatus then
		return
	end
	
	-- get an updated name
	Interface.UpdateMobileOnScreenCleanName(mobileId)

	-- is the mobile invulnerable?
	if mobileStatus.invulnerable then

		-- have we already determine if this mobile is a player vendor?
		if mobileStatus.isPlayerVendor == nil or (forced and not mobileStatus.isPlayerVendor) then
			mobileStatus.isPlayerVendor = IsPlayerVendor(mobileId)
		end

		-- have we already determine if this mobile is a shopkeeper?
		if mobileStatus.isShopkeeper == nil or (forced and not mobileStatus.isShopkeeper) then
			mobileStatus.isShopkeeper = IsVendor(mobileId)
		end

		-- have we already determine if this mobile is a banker?
		if mobileStatus.isBanker == nil or (forced and not mobileStatus.isBanker) then
			mobileStatus.isBanker = IsBanker(mobileId)
		end

		-- have we already determine if this mobile is a bod dealer?
		if mobileStatus.isBodDealer == nil or (forced and not mobileStatus.isBodDealer) then
			mobileStatus.isBodDealer = IsBodDealer(mobileId, false)
		end
		-- have we already determine if this mobile is a stable master?
		if mobileStatus.isStableMaster == nil or (forced and not mobileStatus.isStableMaster) then
			mobileStatus.isStableMaster = IsStableMaster(mobileId)
		end
	end

	-- have we already determine if this mobile is a quest giver?
	if mobileStatus.isQuestGiver == nil or (forced and not mobileStatus.isQuestGiver) then
		mobileStatus.isQuestGiver = IsQuestGiver(mobileId)
	end

	-- is this mobile a pet with accessible inventory?
	if IsObjectIdPet(mobileId) and (mobileStatus.hasAccessibleInventory == nil or (forced and not mobileStatus.hasAccessibleInventory)) then
		mobileStatus.hasAccessibleInventory = HasAccessibleInventory(mobileId)
	end

	-- have we already determine if this mobile is a summon?
	if mobileStatus.isSummon == nil or (forced and not mobileStatus.isSummon) then
		mobileStatus.isSummon = IsSummon(mobileId)

		-- mark this as NON boss
		mobileStatus.isBoss = false
	end

	-- have we already determine if this mobile is someone's pet? (not just the player's pet but anyones)
	if mobileStatus.isSomeonePet == nil or (forced and not mobileStatus.isSomeonePet) then
		mobileStatus.isSomeonePet = (IsObjectIdPet(mobileId) or IsSomeonePet(mobileId)) and not mobileStatus.isSummon

		-- mark this as NON boss
		mobileStatus.isBoss = false
	end
	
	-- have we already determine if this mobile is a neutral animal?
	if (mobileStatus.isNeutralAnimal == nil or forced) then

		-- do we have a compatible creature?
		if mobileStatus.DBName then

			-- check the compatible creatures list
			for i, data in pairs(mobileStatus.DBName) do

				-- get the neutral flag
				mobileStatus.isNeutralAnimal = data.isneutral
				
				-- if we found that is a neutral creature we can stop looking
				if data.isneutral then
					break
				end
			end
		end
	end

	-- have we already determine if this mobile is a neutral animal?
	if (mobileStatus.isPlayer == nil or forced) and mobileStatus.notoriety ~= NameColor.Notoriety.NONE and not mobileStatus.invulnerable then
		mobileStatus.isPlayer = IsPlayer(mobileId)
	end

	-- update the healthbar
	MobileHealthBar.UpdateBarName(mobileId)
end

function Interface.DestroyMobileArrow()
	
	-- mobile arrow window name
	local windowName = "MobileArrow"
	
	-- does the mobile arrow exist?
	if DoesWindowExist(windowName) then
	
		-- detach the arrow from the mobile
		DetachWindowFromWorldObject(WindowGetId(windowName), windowName)

		-- destroy the mobile arrow
		DestroyWindow(windowName)
	end
end

function Interface.CreateMobileArrow(mobileId)

	-- do we have a valid mobile ID?
	if not IsValidID(mobileId) then
		return
	end

	-- mobile arrow window name
	local windowName = "MobileArrow"

	-- does the mobile arrow already exist?
	if not DoesWindowExist(windowName) then

		-- create the mobile arrow
		CreateWindow(windowName, false)

		-- set the ID on the arrow
		WindowSetId(windowName, mobileId)
			
		-- scale the arrow properly
		WindowSetScale(windowName, 0.4)

		-- start the arrow animation
		AnimatedImageStartAnimation(windowName .. "Anim", 1, true, false, 0.0 )

		-- get the mobile data
		local data = Interface.ActiveMobilesOnScreen[mobileId]

		-- do we have the mobile data?
		if data then
			
			-- color the arrow with the notoriety color
			NameColor.UpdateImageNameColor(windowName, data.notoriety)

		else -- use a default color (this will mostly happens for items)
			WindowSetTintColor(windowName, 255, 102, 0)
		end
		
		-- put the arrow over the mobile/item
		AttachWindowToWorldObject(mobileId, windowName)
	end
end

-------------------------------------------------------------------------------
--
-- WindowData Counting
--
-------------------------------------------------------------------------------

function Interface.ShowMobileID()
	RequestTargetInfo(Interface.ShowMobileID_final)
end

function Interface.ShowMobileID_final(mobileId)
	ChatPrint(L"The mobile ID is: " .. mobileId, 1)
end

function Interface.ShowPlayerID()
	ChatPrint(L"Your character ID is: " .. GetPlayerID(), 1)
end

function Interface.GetVariablesFolder()
	ChatPrint(L"Variable Folder Name: PlayerVariables_" .. Interface.ShardsList[UserData.Settings.Login.lastShardSelected] ..  L"_".. GetPlayerID(), 16)
end

function Interface.CountWinData()
	ChatPrint(L"----------------------------", 16)
	ChatPrint(L"Registerd Names: " .. Interface.CountNamesData(), 16)
	ChatPrint(L"Registerd Items: " .. Interface.CountObjectData(), 16)
	ChatPrint(L"Registerd Properties: " .. Interface.CountPropsData(), 16)
	ChatPrint(L"Registerd Containers: " .. Interface.CountContainersData(), 16)
	ChatPrint(L"Registerd Paperdolls: " .. Interface.CountPaperdollData(), 16)
	ChatPrint(L"Registerd Status: " .. Interface.CountMobileStatusData(), 16)
	ChatPrint(L"Registerd Spellbooks: " .. Interface.CountSpellbookssData(), 16)
	ChatPrint(L"Registerd Mobiles on Screen: " .. table.countElements(Interface.ActiveMobilesOnScreen), 16)
	ChatPrint(L"Functions Queue: " .. towstring(table.countElements(Interface.TODO)), 16)
	ChatPrint(L"Pending Events: " .. towstring(table.countElements(Interface.CheckAvailableEvents)), 16)
	ChatPrint(L"Scripts Memory Usage: " .. towstring(bytesToSize(gcinfo() * 1024)), 16)
	ChatPrint(L"----------------------------", 16)
end

function Interface.CountNamesData()
	local a = 0
	for key, value in pairs(WindowData.MobileName) do
		if tonumber(key) then
			a = a + 1
		end
	end
	return a
end

function Interface.CountObjectData()
	local a = 0
	for key, value in pairs(WindowData.ObjectInfo) do
		if tonumber(key) then
			a = a + 1
		end
	end
	return a
end

function Interface.CountContainersData()
	local a = 0
	for key, value in pairs(WindowData.ContainerWindow) do
		if tonumber(key) then
			a = a + 1
		end
	end
	return a
end

function Interface.CountSpellbookssData()
	local a = 0
	for key, value in pairs(WindowData.Spellbook) do
		if tonumber(key) then
			a = a + 1
		end
	end
	return a
end

function Interface.CountPropsData()
	local a = 0
	for key, value in pairs(WindowData.ItemProperties) do
		if tonumber(key) and key ~= 0 then
			a = a + 1
		end
	end
	return a
end


function Interface.CountMobileStatusData()
	local a = 0
	for key, value in pairs(WindowData.MobileStatus) do
		if tonumber(key) then
			a = a + 1
		end
	end
	return a
end

function Interface.CountPaperdollData()
	local a = 0
	for key, value in pairs(WindowData.Paperdoll) do
		if tonumber(key) then
			a = a + 1
		end
	end
	return a
end
-------------------------------------------------------------------------------
--
-- EVENTS
--
-------------------------------------------------------------------------------

Interface.LastStatusUpdate = {}
function Interface.UpdateMobileStatus()

	-- make sure the UI is started
	if not Interface.started then
		return
	end

	-- get the mobile ID to update
	local mobileId = WindowData.UpdateInstanceId

	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return
	end

	-- update the mobile status (we use another function because we call it from another place too, and we don't want to alter the parameters)
	Interface.UpdateMobileStatus_final(mobileId)
end

function Interface.UpdateMobileStatus_final(mobileId)

	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return
	end
	
	-- TEMPORARILY DISABLE THE FEATURE TO SEE IF IT's CAUSING TROUBLE
	--[[ make sure the update doesn't happen faster than 1/10 of a second (usually is triggered 3 times simultaneously)
	if Interface.LastStatusUpdate[mobileId] and Interface.TimeSinceLogin < Interface.LastStatusUpdate[mobileId] + 0.1 then
		return
	end
	--]]
	-- store the last update time
	Interface.LastStatusUpdate[mobileId] = Interface.TimeSinceLogin

	-- update the active mobiles data
	pcall(Interface.UpdateMobileOnScreenStatus, mobileId)

	-- is this the player ID?
	if mobileId == GetPlayerID() then
	
		-- update player status
		pcall(StatusWindow.UpdateStatus) 
	end

	-- update target
	pcall(TargetWindow.UpdateStatus, mobileId)

	-- update healthbar
	pcall(MobileHealthBar.UpdateBarStatus, mobileId)

	-- are the hoverbar active?
	if Interface.Settings.HoverbarsActive then
		
		-- update hoverbar status
		pcall(OverheadText.UpdateHoverbarStatus, mobileId)
	end

	-- is the boss bar active?
	if Interface.Settings.BossbarsActive then
		
		-- update bossbar
		pcall(BossBar.UpdateStatus, mobileId)
	end

	-- update the animal lore status
	pcall(AnimalLore.UpdateStatus, mobileId)

	-- is this the mobile we're seeing the item properties?
	if ItemProperties.IsCurrentHover(mobileId) then

		-- update the item properties
		ItemProperties.UpdateItemPropertiesData()
	end
end

Interface.LastNameUpdate = {}
function Interface.UpdateMobileName()

	-- make sure the UI is started
	if not Interface.started then
		return
	end

	-- get the mobile ID to update
	local mobileId = WindowData.UpdateInstanceId

	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return
	end

	-- make sure the update doesn't happen faster than 1/10 of a second (usually is triggered 3 times simultaneously)
	if Interface.LastNameUpdate[mobileId] and Interface.TimeSinceLogin < Interface.LastNameUpdate[mobileId] + 0.1 then
		return
	end
	
	-- store the last update time
	Interface.LastNameUpdate[mobileId] = Interface.TimeSinceLogin
		
	-- we show the name as soon as it's available
	Interface.ExecuteWhenAvailable(
	{
		name = "GlobalNameUpdate" .. mobileId,
		check = function() return Interface.VerifyMobileName(mobileId, WindowData.MobileName[mobileId]) ~= nil end, 
		callback = function() Interface.UpdateMobileName_final(mobileId) end,
		removeOnComplete = true
	})
end

function Interface.UpdateMobileName_final(mobileId)
	
	-- update the active mobiles data
	pcall(Interface.UpdateMobileOnScreenName, mobileId)

	-- update target name
	pcall(TargetWindow.UpdateName, mobileId)

	-- update healthbar name
	pcall(MobileHealthBar.UpdateBarName, mobileId)

	-- are the hoverbar active?
	if Interface.Settings.HoverbarsActive then
	
		-- update overbar name
		pcall(OverheadText.UpdateHoverbarName, mobileId)
	end
	
	-- update overhead name
	pcall(OverheadText.UpdateName, mobileId)

	-- is the boss bar active?
	if Interface.Settings.BossbarsActive then
		
		-- has this mobile been marked as boss?
		if mobileId == BossBar.GetActiveBoss() then 

			-- activate the boss bar
			BossBar.AttachBossBar(mobileId)
		end

		-- update boss name
		pcall(BossBar.UpdateName, mobileId)
	end
end

Interface.LastColorUpdate = {}
function Interface.UpdateMobileStatusColor()

	-- make sure the UI is started
	if not Interface.started then
		return
	end

	-- get the mobile ID to update
	local mobileId = WindowData.UpdateInstanceId

	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return
	end

	-- make sure the update doesn't happen faster than 1/10 of a second (usually is triggered 3 times simultaneously)
	if Interface.LastColorUpdate[mobileId] and Interface.TimeSinceLogin < Interface.LastColorUpdate[mobileId] + 0.1 then
		return
	end
	
	-- store the last update time
	Interface.LastColorUpdate[mobileId] = Interface.TimeSinceLogin

	-- is this the player ID?
	if mobileId == GetPlayerID() then

		-- update player status
		pcall(StatusWindow.UpdateStatus) 
	end

	-- update target
	pcall(TargetWindow.TintHealthBar, mobileId)

	-- update healthbar
	pcall(MobileHealthBar.UpdateHealthBarColor, mobileId)

	-- are the hoverbar active?
	if Interface.Settings.HoverbarsActive then
		
		-- update hoverbar
		pcall(OverheadText.HoverbarColorUpdate, mobileId)
	end

	-- is the boss bar active?
	if Interface.Settings.BossbarsActive then
		
		-- update bossbar
		pcall(BossBar.HandleHealthBarColorUpdate, mobileId)
	end
end

function Interface.UpdateHealthbarAvailability(mobileId)

	-- make sure the UI is started
	if not Interface.started then
		return
	end

	-- get the mobile ID to update (mobileId is null if it's an utomated call)
	if not mobileId then
		mobileId = WindowData.UpdateInstanceId
	end

	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return
	end

	-- update healthbar
	pcall(MobileHealthBar.UpdateHealthBarState, mobileId)

	-- are the hoverbar active?
	if Interface.Settings.HoverbarsActive then
		
		-- update hoverbar
		pcall(OverheadText.HandleHealthBarStateUpdate, mobileId)
	end

	-- is the boss bar active?
	if Interface.Settings.BossbarsActive then
		
		-- update bossbar
		pcall(BossBar.HandleHealthBarStateUpdate, mobileId)
	end
end

function Interface.HandlePartyMemberUpdate()

	-- scan all party members
	for i, member in pairsByIndex(WindowData.PartyMember) do

		-- get the mobile ID for this member
		local mobileId = member.memberId

		-- do we have a valid mobile ID?
		if not IsValidID(mobileId) then
			continue
		end

		-- current mobile record
		local mobileStatus = Interface.ActiveMobilesOnScreen[mobileId]

		-- is the mobile already registered on screen?
		if mobileStatus then

			-- update the party member flag
			mobileStatus.isParty = true

			-- update the party index
			mobileStatus.partyIndex = i
		end

		-- create a variable as pointer for the bar record
		local barData = MobileHealthBar.ActiveBars[mobileId]

		-- do we have the healthbar and is not a party healthbar?
		if barData and not barData.PartyMember then

			-- destroy the current healthbar and let the system create a new one
			MobileHealthBar.CloseBarByID(mobileId, "New party member")
		end
	end

	-- scan all the registered mobils
	for mobileId, mobileStatus in pairs(Interface.ActiveMobilesOnScreen) do

		-- store the previous party flag
		local wasParty = mobileStatus.isParty

		-- is this a party member? if it is we also get the party ID
		mobileStatus.isParty, mobileStatus.partyIndex = IsPartyMember(mobileId)

		-- create a variable as pointer for the bar record
		local barData = MobileHealthBar.ActiveBars[mobileId]

		-- was this mobile a party member and now is no more?
		if wasParty and mobileStatus.isParty ~= wasParty then

			-- do we have the healthbar and is not a party healthbar?
			if barData then
			
				-- destroy the current healthbar and let the system create a new one
				MobileHealthBar.CloseBarByID(mobileId, "No longer a party member")
			end
		end
	end

	-- update the party members count
	MobileBarsDockspot.UpdatePartyCount()
end

function Interface.UpdateTarget()

	-- update the current target
	TargetWindow.UpdateTarget()
end

function Interface.UpdateObjectInfo()

	-- get the ID of the object to update
	local objectId = WindowData.UpdateInstanceId

	-- update the target object
	TargetWindow.UpdateObjectInfo(objectId)
end

function Interface.HandlePetsUpdate()

	-- update the pets count in the dockspot
	MobileBarsDockspot.UpdatePetsCount()
	
	-- scan the active pets
	for i, mobileId in pairsByIndex(WindowData.Pets.PetId) do

		-- is the pet visible and not a summon?
		if ridingPet ~= mobileId and IsMobileVisible(mobileId) and not IsSummon(mobileId) then

			-- is the healthbar already around and is NOT a pet healthbar?
			if MobileHealthBar.ActiveBars[mobileId] and MobileHealthBar.ActiveBars[mobileId].type ~= MobileHealthBar.HealthbarsType.PET then

				-- close the healthbar (it will be re-created automatically)
				MobileHealthBar.CloseBarByID(mobileId, "pet with a normal healthbar")
			end

			-- add to the mounts list
			Interface.ExecuteWhenAvailable(
			{
				name = "addToMountList" .. mobileId, 
				check = function() return Interface.PlayerVariablesInitialized and IsValidWString(GetMobileName(mobileId)) end, 
				callback = function() MountsList.SetAvailable(mobileId, GetMobileName(mobileId), true, true) end, 
				removeOnComplete = true
			})
		end
	end

	-- update the docked bars
	MobileBarsDockspot.UpdateDockspotBars(MobileBarsDockspot.DockspotDefaultNames[MobileBarsDockspot.DockspotType.PET])
end

function Interface.HandleUpdatePaperdollEvent()

	-- make sure the UI is started
	if not Interface.started then
		return
	end

	-- get the mobile ID to update
	local mobileId = WindowData.UpdateInstanceId

	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return
	end

	-- update the paperdoll
	pcall(PaperdollWindow.UpdatePaperdoll, mobileId)
end

function Interface.UpdateCharProfile()
	
	-- make sure the UI is started
	if not Interface.started then
		return
	end

	-- get the mobile ID to update
	local mobileId = WindowData.UpdateInstanceId

	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return
	end

	-- update the profile
	pcall(PaperdollWindow.UpdateCharProfile, mobileId)
end

function Interface.UpdatePlayerStatus()

	-- player ID
	local mobileId = GetPlayerID()

	-- update the player status data
	pcall(Interface.UpdateMobileOnScreenStatus, mobileId)

	-- overhead status
	if Interface.Settings.StatusWindowStyle == 3 then

		-- update the hoverbar status (if this style is enabled)
		OverheadText.UpdateHoverbarStatus(mobileId)
	end

	-- party bar status
	if Interface.Settings.StatusWindowStyle == 4 then

		-- update healthbar (if this style is enabled)
		pcall(MobileHealthBar.UpdateBarStatus, mobileId)
	end
	
	-- dedicated status style
	if Interface.Settings.StatusWindowStyle < 3 then

		-- update the player status
		StatusWindow.UpdateStatus()
	end
end

function Interface.StoreRequest()

	-- mark the next gump as the shop gump
	GenericGump.NextisShop = true
end

function Interface.BookPageReceived()
	
	-- get the book ID
	local bookId = WindowData.Book.ObjectId

	-- is the book open?
	if BookTemplate.OpenBooks[bookId] then
		
		-- scan the received pages and check if we have stored them
		for i = #BookTemplate.OpenBooks[bookId].content, #WindowData.Book.Pages do

			-- add the page to the book (since all the pages are loaded when the books open in sequence, we can add them in sequence)
			table.insert(BookTemplate.OpenBooks[bookId].content, i, WindowData.Book.Pages[i])
		end

		-- left page ID
		local leftPage = BookTemplate.GetLeftPageID(bookId)

		-- right page ID
		local rightPage = BookTemplate.GetRightPageID(bookId)

		-- do we have the currently visible pages text?
		if	IsValidID(leftPage) and BookTemplate.OpenBooks[bookId].content[leftPage] or
			IsValidID(rightPage) and BookTemplate.OpenBooks[bookId].content[rightPage]
		then

			-- update the book pages
			BookTemplate.SetPagesText(bookId)
		end

		-- do we have all the book pages?
		if #BookTemplate.OpenBooks[bookId].content == BookTemplate.OpenBooks[bookId].numPages then
			
			-- save the book to file (if the logging is enabled)
			-- NOTE: the book will be saved over and over until we got it all. There seems to be no better way to do it...
			BookTemplate.SaveToFile(bookId)
		end
	end
end

function Interface.KeyRecorded()

	-- parse the key record for macros
	MacroWindow.KeyRecorded()

	-- parse the key record for settings
	SettingsWindow.KeyRecorded()

	-- parse the key record for hotbars
	Hotbar.KeyRecorded()
end

function Interface.KeyCancelRecord()

	-- parse the cancel key record for macros
	MacroWindow.KeyCancelRecord()

	-- parse the cancel key record for settings
	SettingsWindow.KeyCancelRecord()

	-- parse the cancel key record for hotbars
	Hotbar.KeyCancelRecord()
end

function Interface.ActivateAbility()

	-- parse the generic activation for weapon ability
	EquipmentData.ActivateAbility()

	-- parse the activation for weapon ability in the character abilities list
	CharacterAbilities.ActivateWeaponAbility()
end

function Interface.ResetAbility()

	-- parse the generic reset for weapon ability
	EquipmentData.ResetAbility()

	-- parse the reset for weapon ability in the character abilities list
	CharacterAbilities.ResetWeaponAbility()
end

function Interface.RequestTargetInfoReceived()

	-- make sure the UI is started
	if not Interface.started then
		return
	end

	-- get the target ID
	local objectId = SystemData.RequestInfo.ObjectId

	-- do we have a valid ID?
	if not IsValidID(objectId) then
		return
	end

	-- call the function
	pcall(Interface.RequestTargetFunction, objectId)
end

function Interface.TogglePaperdollWindow()
	playerId = GetPlayerID()
	local windowName = "PaperdollWindow"..playerId

	if (DoesWindowExist(windowName)) then
		DestroyWindow(windowName)
	else
	    UserActionUseItem(playerId,true)
		WindowUtils.RestoreWindowPosition(windowName, false, "pdollself", true)
	end
end

function Interface.OnDebugPrint()
	Debug.PrintToDebugConsole(DebugData.DebugString)
end

function Interface.RetrieveCharacterSettings()
	--WindowUtils.RetrieveWindowSettings()
end

function Interface.UpdateWindowsSettings()
	WindowUtils.SendWindowSettings()
end

function Interface.ECPlaySoundInactive()
	SystemData.Settings.Interface.customUiName = ""
	UserSettingsChanged()
	BroadcastEvent( SystemData.Events.RELOAD_INTERFACE )
end

Interface.ReloadTriggered = false
Interface.ReloadCountDown = 0
function Interface.ReloadUI(withCD)

	WindowSetShowing("Loading", true)
	if withCD == true then
		Interface.ReloadCountDown = Interface.TimeSinceLogin + 0.2	
		Interface.ReloadTriggered = true
	else
		BroadcastEvent( SystemData.Events.RELOAD_INTERFACE )
	end
end

function Interface.UpdateMap(tiltChanged)

	-- make sure the UI is started
	if not Interface.started then
		return
	end
	
	-- if the minimap is visible update the minimap
	if WindowGetShowing("MapWindow") then
		MapWindow.UpdateMap(tiltChanged)
	end

	-- if the atlas is visible, update the atlas
	if WindowGetShowing("AtlasWindow") then
		AtlasWindow.UpdateMap(tiltChanged)
	end

	-- update the smart boat orientation (if the fix has been triggered)
	Actions.FixSmartBoatDirectionsComplete(true)
end

function Interface.UpdateWaypoints()

	-- is the map visible?
	if MapCommon.IsMapVisible() then
		
		-- update the waypoints
		MapCommon.WaypointsDirty = true
    end
end

function Interface.EndReloadUI()

end

function Interface.ShowCriminalNotificationGump()
	local okButton = { textTid = UO_StandardDialog.TID_ACCEPT, callback = Interface.AcceptCriminalNotification }
	local cancelButton = { textTid = UO_StandardDialog.TID_CANCEL, callback = nil }
	local windowData = 
	{
		windowName = "ShowCriminalNotification", 
		titleTid = 1111873, -- "Warning"
		bodyTid = 3000032, -- This may flag you criminal!
		buttons = { okButton, cancelButton },
		closeCallback = cancelButton.callback,
		destroyDuplicate = true,
	}
	UO_StandardDialog.CreateDialog( windowData )	
end

function Interface.ShowPartyInvite()
	CreateWindow( "PartyInviteWindow", true )
end

function Interface.AcceptCriminalNotification()
	AcceptCriminalNotification()		
end

function Interface.HonorMobileConfirm(mobileId)

	-- store the previous honor target
	local lastHonorTarget = Interface.CurrentHonor

	-- get the new honor target
	Interface.CurrentHonor = WindowData.Cursor.lastTarget

	-- do we had an honor target?
	if IsValidID(lastHonorTarget) then			

		-- update the mobile on screen
		Interface.UpdateMobileOnScreenName(lastHonorTarget)

		-- update all the bars that could have had it.
		MobileHealthBar.UpdateBarName(lastHonorTarget)
		OverheadText.UpdateName(lastHonorTarget)
		TargetWindow.UpdateName(lastHonorTarget)
		OverheadText.UpdateHoverbarNameColor(lastHonorTarget)
	end	

	-- save the current honor mobile (for future sessions)
	Interface.CurrentHonor = mobileId
	Interface.SaveNumber("CurrentHonor", Interface.CurrentHonor)

	-- update the mobile on screen
	Interface.UpdateMobileOnScreenName(mobileId)

	-- create a variable as pointer for the bar record
	local barData = MobileHealthBar.ActiveBars[mobileId]

	-- does the healthbar already exist and is already pinned?
	if (barData and barData.pinned) then

		-- update the bar name
		MobileHealthBar.UpdateBarName(mobileId)

	-- create and/or pin the healthbar
	elseif Interface.Settings.AutoPinHonored then
		MobileHealthBar.CreateBar(mobileId, true)
	end

	-- update all the bars that could have the honor target
	OverheadText.UpdateName(mobileId)
	TargetWindow.UpdateName(mobileId)
	OverheadText.UpdateHoverbarNameColor(mobileId)
end

function Interface.ItemUseRequest()
	--Debug.Print("Used Item " .. GameData.UseRequests.UseItem .. " with target: " .. GameData.UseRequests.UseTarget)

	-- get the used item ID
	local itemId = GameData.UseRequests.UseItem
	
	-- does the request included a target?
	if GameData.UseRequests and GameData.UseRequests.UseTarget ~= 0 then

		-- save the last cursor target
		WindowData.Cursor.lastTarget = GameData.UseRequests.UseTarget

		-- trigger the on target event
		Interface.OnTarget(0, GameData.UseRequests.UseTarget)
	end
	
	-- is the item we used a mobile?
	if IsMobile(itemId) then

		-- store the last mobile ID
		Interface.LastMobile = itemId

		-- is this an old questgiver?
		if IsOldQuestGiver(itemId) then

			-- is the paperdoll for this mobile closed?
			if not DoesWindowExist("PaperdollWindow" .. itemId) then

				-- flag not to open the paperdoll
				Interface.BlockThisPaperdoll[itemId] = true
			end

			-- use the context menu and talk action
			Interface.BlockThisPaperdollMenuCall = ContextMenu.DefaultValues.NPCTalk

		-- is this a banker?
		elseif IsBanker(itemId) then

			-- is the paperdoll for this mobile closed?
			if not DoesWindowExist("PaperdollWindow" .. itemId) then

				-- flag not to open the paperdoll
				Interface.BlockThisPaperdoll[itemId] = true
			end

			-- open the bank box
			Interface.BlockThisPaperdollMenuCall = ContextMenu.DefaultValues.OpenBankbox
			
		-- is this a shopkeeper?
		elseif IsVendor(itemId) then

			-- is the paperdoll for this mobile closed?
			if not DoesWindowExist("PaperdollWindow" .. itemId) then

				-- flag not to open the paperdoll
				Interface.BlockThisPaperdoll[itemId] = true
			end

			-- open the shopkeeper window
			Interface.BlockThisPaperdollMenuCall = ContextMenu.DefaultValues.VendorBuy
		end

		-- reset the ignore last mobile flag (this flag is to check if the player has opened a vendor inventory).
		ContainerWindow.IgnoreLastMobile = nil

		-- if no container opens in 1 second we can consider the mobile NOT a vendor.
		Interface.AddTodoList({name = "Update NOT A VENDOR flag", func = function() ContainerWindow.IgnoreLastMobile = true end, time = Interface.TimeSinceLogin + 1})

	else -- is an item

		-- store the last item ID
		Interface.LastItem = itemId

		-- is the auto-target for the bag of sending enabled?
		if Interface.Settings.AutoTargetBagOfSending then

			-- get the object type
			local objectType = GetItemType(itemId)

			-- is this a bag?
			if objectType == 3702 then

				-- get the item name
				local itemName = wstring.lower(GetItemName(itemId))

				-- is this a bag of sending?
				if itemName == wstring.lower(GetStringFromTid(1054104)) then -- a bag of sending

					-- get the charges remaining
					local _, charges = ItemProperties.DoesItemHasProperty(itemId, 1060741) -- charges: ~1_val~
					
					-- are there still charges available in the bag?
					if tonumber(charges[1]) > 0 then

						-- do we have gold inside the backpack?
						if Interface.BackPackItems[3821] then

							-- get all the gold piles we have in the backpack
							local gold = Interface.BackPackItems[3821][0]

							-- initialize the variables to determine the best pile
							local bestPileAmount = 0
							local bestPileID = 0

							-- scan all the gold piles
							for itemId, amount in pairs(gold) do
							
								-- does this pile is bigger than the one we have selected?
								if amount > bestPileAmount then

									-- update the selected pile amount
									bestPileAmount = amount

									-- store the ID of the pile
									bestPileID = itemId
								end
							end
							
							-- target the best pile as soon as the cursor appear
							Interface.ExecuteWhenAvailable({ name = "TargetGold", check = function() return DoesPlayerHasCursorTarget() end, callback = function() HandleSingleLeftClkTarget(bestPileID) end, maxTime = Interface.TimeSinceLogin + 1, removeOnComplete = true })

						else -- no gold available
							
							-- remove the cursor target
							Interface.ExecuteWhenAvailable({ name = "TargetGold", check = function() return DoesPlayerHasCursorTarget() end, callback = function() CancelCursorTarget() end, maxTime = Interface.TimeSinceLogin + 1, removeOnComplete = true })
						end
					end
				end
			end
		end

		-- get if the item has been registered in any open container and the ID of the container is in
		local registered, containerId = ContainerWindow.IsObjectRegistered(itemId)
	
		-- is the object registered and the container is visible?
		if registered and DoesWindowExist("ContainerWindow_" .. containerId) then

			-- update the container content
			ContainerWindow.ForceContainerUpdate(containerId)

			-- update the uses for the item in 2 seconds
			Interface.AddTodoList({name = "Update Uses for " .. GameData.UseRequests.UseItem, func = function() ContainerWindow.UpdateUsesByID(containerId, itemId) end, time = Interface.TimeSinceLogin + 2})
		end
	
		-- check if the item is an ethereal mount
		if MountsList.IsMountAvailable(itemId) then
			MountsList.OriginalMountID = itemId
		end

		-- does the item do NOT belong to the player and is NOT in an open container and 
		if not DoesPlayerHaveItem(itemId) and not ContainerWindow.IsObjectRegistered(itemId) and (GetDistanceFromPlayer(itemId) >= 0 and GetDistanceFromPlayer(itemId) <= 2) then

			-- get the object info
			local itemData = Interface.GetObjectInfoData(itemId)
	
			-- do we have the object info?
			if not itemData then
				return
			end

			-- is the item a moongate?
			if ItemsInfo.Moongates[itemData.objectType] then

				-- remove the current target
				ClearCurrentTarget()
			end

			-- is this a crystal portal item?  
			if	(itemData.objectType == 18058 and itemData.hueId == 2601 and itemData.name == GetStringFromTid(1150074)) or -- Corrupted Crystal Portal
				(itemData.objectType == 18059 and itemData.hueId == 0 and itemData.name == GetStringFromTid(1113945)) -- Crystal Portal
			then

				-- show the crystal portal window
				CrystalPortal.Toggle()
			end

		else
			-- get the object info
			local itemData = Interface.GetObjectInfoData(itemId)
	
			-- do we have the object info?
			if not itemData then
				return
			end

			-- is this a spell scroll?
			if SpellsInfo.ScrollsToSpellID[itemData.objectType] then

				-- set the spell ID to the protection system
				Interface.ProtectedLastSpell = SpellsInfo.ScrollsToSpellID[itemData.objectType]
			end
		end
	end
end

Interface.LastSpell = 0
function Interface.SpellUseRequest()
	--Debug.Print("Used Spell " .. GameData.UseRequests.UseSpellcast .. " with target: " .. GameData.UseRequests.UseTarget)
	if GameData.UseRequests.UseTarget ~= 0 then
		if not WindowData.Cursor then
			WindowData.Cursor = {}
		end
		WindowData.Cursor.lastTarget = GameData.UseRequests.UseTarget
		Interface.OnTarget(0, GameData.UseRequests.UseTarget)
	end
	Interface.LastSpell = GameData.UseRequests.UseSpellcast

	-- store the spell for the protected target check
	Interface.ProtectedLastSpell = Interface.LastSpell

	-- if recall or sacred journey have been casted, make sure we have no current target so the data won't be destroyed
	if Interface.LastSpell == 32 or Interface.LastSpell == 210 then
		
		-- remove the current target
		ClearCurrentTarget()
	end

	if Interface.LastSpell == 503 or Interface.LastSpell == 507 or Interface.LastSpell == 508  then
		local speed = SpellsInfo.GetSpellSpeed(Interface.LastSpell)
		 if (speed) then
			Interface.CurrentSpell.UnlaggedSpeed = speed
			Interface.CurrentSpell.Recovery = 1.75
			Interface.CurrentSpell.ActualSpeed = 0
			Interface.CurrentSpell.IsSpell = true
			Interface.CurrentSpell.SpellId = Interface.LastSpell
			Interface.CurrentSpell.ready =false
			Interface.CurrentSpell.casting = true
			Interface.CurrentSpell.CheckFizzle = false
		end
	end
end

function Interface.SkillUseRequest()
	--Debug.Print("Used Skill " .. GameData.UseRequests.UseSkill .. " with target: " .. GameData.UseRequests.UseTarget)

	-- store the skill ID
	Interface.LastSkillProtected = GameData.UseRequests.UseSkill

	-- do we have a valid ID?
	if IsValidID(GameData.UseRequests.UseTarget) then

		-- store the target as last cursor target
		WindowData.Cursor.lastTarget = GameData.UseRequests.UseTarget

		-- execute the ontarget event
		Interface.OnTarget(0, GameData.UseRequests.UseTarget)
	end
end

function Interface.VirtueUseRequest()
	--Debug.Print("Used Virtue " .. GameData.UseRequests.UseVirtue .. " with target: " .. GameData.UseRequests.UseTarget)
	if GameData.UseRequests.UseTarget ~= 0 then
		WindowData.Cursor.lastTarget = GameData.UseRequests.UseTarget
		Interface.OnTarget(0, GameData.UseRequests.UseTarget)
	end

	if GameData.UseRequests.UseVirtue == 1 then
		local lastHonorTarget = Interface.CurrentHonor
		Interface.CurrentHonor = WindowData.Cursor.lastTarget
		if IsValidID(lastHonorTarget) then			
			MobileHealthBar.UpdateName(lastHonorTarget)
			OverheadText.UpdateName(lastHonorTarget)
			TargetWindow.UpdateName(lastHonorTarget)
		end	
	end
end

function Interface.SpecialMoveUseRequest()
	--Debug.Print(GameData.UseRequests.UseSpecialMove)
	Interface.LastSpecialMove = GameData.UseRequests.UseSpecialMove
end

function Interface.OnTarget(lastTarget, newTarget)
	-- Debug.Print("Target Triggered - PREVIOUS LAST: " .. lastTarget .. " NEW TARGET: " .. newTarget)
	
	-- do we still have the target? fake call...
	if DoesPlayerHasCursorTarget() then
		return
	end

	-- flaming shot casted
	if GameData.UseRequests.UseSpellcast == 723 and Interface.started then
		HotbarSystem.FlamingShotCooldown = 10
	end

	-- remove the protected skill ID
	Interface.LastSkillProtected = nil

	-- remove the protected spell ID
	Interface.ProtectedLastSpell = nil

	-- does the target protection window already exist?
	if DoesWindowExist("TargetProtectionData") then

		-- create the target protection window
		DestroyWindow("TargetProtectionData")
	end
end

function Interface.OnSpellCastedSuccessfully(id)
end

function Interface.OnSpellCastFailed(id)
end

function Interface.OnSpecialMoveUsedSuccessfully(id, targetId)
end

function Interface.OnSpecialMoveDamageReceived(id)
end

function Interface.OnHPChange(previous)
end

function Interface.OnManaChange(previous)
	CharacterAbilities.UpdateWeaponAbilities()
end

function Interface.OnStamChange(previous)
end

function Interface.OnMouseOverItemChanged(id)
	if WindowData.ItemProperties.CurrentType == WindowData.ItemProperties.TYPE_ITEM then
		if IsMobile(id) then
			Interface.OnMobileMouseOver(id)
		else
			Interface.OnObjectMouseOver(id)
		end
	elseif WindowData.ItemProperties.CurrentType == WindowData.ItemProperties.TYPE_ACTION then
		Interface.OnActionMouseOver(id)
	elseif WindowData.ItemProperties.CurrentType == WindowData.ItemProperties.TYPE_WSTRINGDATA then
	end
	ItemProperties.UpdateDelta = 0
end

function Interface.OnMobileMouseOver(id)
	-- Debug.Print("Over Mobile " .. id)
end

function Interface.OnObjectMouseOver(id)
	-- Debug.Print("Over Object " .. id)
end

function Interface.OnActionMouseOver(id)
	-- Debug.Print("Over Action " .. id)
end

function Interface.OnPlayerMove(oldX, oldY, oldFacet,  newX, newY, newFacet)
	--Debug.Print("Player has moved from: " .. oldX .. "," .. oldY .. " FACET: " .. oldFacet .. " TO " .. newX .. "," .. newY .. " FACET: " .. newFacet)
	
	-- is the minimap visible?
	if MapCommon.IsMapVisible(true) then

		-- send a waypoint update request
		MapCommon.WaypointUpdateRequest = true
	end

	-- update the player location on the minimap
	MapCommon.UpdatePlayerLocation()
end

function Interface.OnAreaChange(oldarea, oldsubarea, newarea,  newsubarea)
	--Debug.Print("Player has moved from: " .. oldarea .. "," .. oldsubarea .. " TO " .. newarea .. "," .. newsubarea )
	
	-- update the paperdoll background
	PaperdollWindow.SwitchBG()

	-- update the player location on the minimap
	MapCommon.UpdatePlayerLocation()
end

function Interface.OnItemsEquip(mobileId, ids)
	-- Debug.Print("Items Equipped: ")
	-- Debug.Print(ids)
	for i = 1, #ids do
		local item = ids[i]
		if mobileId == GetPlayerID() then
			if Interface.UnequipItems[item.slot] == item.itemId then
				Interface.UnequipItems[item.slot] = nil
			end
		end
	end
end

function Interface.OnItemsUnequip(mobileId, ids)
	-- Debug.Print("Items Unequipped: ")
	-- Debug.Print(ids)
	if not Interface.UnequipItems then
		Interface.UnequipItems = {}
	end
	for i = 1, #ids do
		local item = ids[i]
		if mobileId == GetPlayerID() then
			Interface.UnequipItems[item.slot] = item.itemId
		end
	end
end

function Interface.OnNewItemsInBackpack(itemsList)
	--Debug.Print("Player Got new items: ")
	--Debug.Print(itemsList)

	-- did we just retrieved a map?
	if GenericGump.MapRetrievedData then
	
		-- do we have the sos waypoints table?
		if not Interface.TmapWaypoints then

			-- initialize the table
			Interface.TmapWaypointsAll = CreateSaveStructureWithPlayerID(Interface.TmapWaypointsAll)

			-- load the waypoints
			Interface.InitializeTmapWaypoints()
		end

		-- scan the new items (there should be only 1)
		for itemId, objectType in pairs(itemsList) do

			-- is this a tmap?
			if objectType == 5355 then

				-- create the waypoint for the map
				Interface.TmapWaypoints[itemId] = GenericGump.MapRetrievedData

				break
			end
		end

		-- delete the map data
		GenericGump.MapRetrievedData = nil
	end
end

function Interface.OnPlayerGetDamage(amount)
	-- Debug.Print("Player Got Damaged by " .. amount)
end

function Interface.OnPetGetDamage(petId, amount)
	-- Debug.Print("Pet " .. petId .. "  Got Damaged by " .. amount)
end

function Interface.OnPlayerDealDamage(targetId, amount)
	-- Debug.Print("Player has damaged " .. targetId .. "  by: " .. amount)
end

-- Triggered when an item loses durability
function Interface.OnItemDamaged(id, slotId, durabilityLost)

end

-- Triggered when an item loses MAX durability
function Interface.OnItemSeverelyDamaged(id, slotId, MAXdurabilityLost)

end

-- Triggered when a player mount/dismount
function Interface.MountedStatusChanged(wasMounted)
	MountsList.UpdateList()
end

-- New mobile appeared on screen
function Interface.NewMobileOnScreen(mobileId)
	--Debug.Print("NEW MOBILE ON SCREEN " .. mobileId)

	-- is this the current honor target?
	if Interface.Settings.AutoPinHonored and mobileId == Interface.CurrentHonor then

		-- create and/or pin the healthbar
		MobileHealthBar.CreateBar(mobileId, true)
	end

	-- update the healthbar availability
	Interface.UpdateHealthbarAvailability(mobileId)
end

-- a mobile left the screen
function Interface.MobileLeftScreen(mobileId)
	-- Debug.Print("MOBILE LEFT SCREEN " .. mobileId)

	-- update the healthbar availability
	Interface.UpdateHealthbarAvailability(mobileId)

	-- unregister the data
	UnregisterWindowData(WindowData.MobileStatus.Type, mobileId, true)
	UnregisterWindowData(WindowData.HealthBarColor.Type, mobileId, true)
end

-- begin drag a mobile from the world
function Interface.BeginDragHealthbarFromWorld()

	-- get the mobile ID
	local mobileId = SystemData.ActiveMobile.Id

	-- create a variable as pointer for the bar record
	local barData = MobileHealthBar.ActiveBars[mobileId]

	-- do we have a valid ID and the mobile is not a pet or a party member?
	if not IsValidID(mobileId) or IsObjectIdPet(mobileId) or IsPartyMember(mobileId) or (barData and barData.pinned) then
		return
	end

	-- by default we create a new bar
	local callback = function() MobileHealthBar.CreateBar(mobileId, true) end

	-- does the healthbar already exist?
	if barData then

		-- if the bar exist, we pin it (if it's already pinned, nothing will happen)
		callback = function() MobileHealthBar.PinBar(mobileId) end
	end

	-- create a pinned bar if the drag is successful
	WindowUtils.BeginDrag(callback, mobileId)
end

-- end drag a mobile from the world
function Interface.EndDragHealthbarFromWorld()

	-- terminate the dragging, verify if we actually dragged a bar or just clicked the mobile
	WindowUtils.EndDrag()
end

function Interface.OnObjectMouseOver(oldid, id)
	if not id then
		return
	end
	--Debug.Print("The mouse is now over: " .. id .. " from " .. oldid)
	ItemProperties.ItemChanged = true
end

function Interface.WebCall(url)

	-- is the disk I/O disabled?
	if Interface.DisableDiskIO  then
		Debug.Print("Disk I/O disabled, can't execute a web call!")
		return
	end
	
	-- send the web call
	CreateTextFile("logs/webcall.log", towstring(url))
end

function Interface.CreatePlayerVariablesMod(fileName)

	-- is the disk I/O disabled?
	if Interface.DisableDiskIO  then
		Debug.Print("Disk I/O disabled, can't create player variables mod!")
		return
	end

	-- send the request to copy the player variables mod file
	CreateTextFile("logs/playermod.txt", towstring(fileName))
end

-------------------------------------------------------------------------------

-- EC PlaySound Management

-------------------------------------------------------------------------------

function ECPlaySound(type, filename, command, startpos, endpos)
	-- TYPES: 0 = sound; 1 = music; 2 = heartbeat; 3 = shutdown;
	-- COMMANDS: 0 = play; 1 = stop; 2 = loop;
	if Interface.DisableDiskIO  then
		Debug.Print("Disk I/O disabled, can't use ECPlaySound!")
		return
	end
	if not Interface.ECPlaySoundActive then
		return
	end
	
	if (type==0 and not Interface.ECSound.enabled and command ~= 1) then
		return
	end
	
	if (type==1 and not Interface.ECMusic.enabled and command ~= 1) then
		return
	end
	
	if not Interface.PlaySoundBuffer then
		Interface.PlaySoundBuffer = {}
	end
	
	local buffValue
	
	local output = L""

	if (type == 0) then
		output = "sound|"
	elseif (type == 2) then
		output = "heartbeat|"
	elseif (type == 3) then
		output = "shutdown|"
	else
		output = "music|"
	end
	if (command == 1) then
		output = output .. "stop"
	elseif (command == 0) then
		output = output .. filename .. "|false"
	elseif (command == 2) then
		if (output == "music|") then
			Interface.GetMusLenght = true
			Interface.MusLenght = 0
			buffValue = "music|stop"
		end
		if not filename then
			filename = ""
		end
		output = output .. filename .. "|true"
	end
	if (startpos) then
		output = output .. "|" .. startpos
	end
	if (endpos) then
		output = output .. "|" .. endpos
	end
	
	if (type == 3) then
		if Interface.ECMusic.enabled then
			output = "music|Theme.mp3|true"
		end
		CreateTextFile("logs/playSound.log", towstring(output))
	else
		buffValue = output
	end
	if Interface.PlaySoundBuffer[#Interface.PlaySoundBuffer] ~= buffValue then
		table.insert(Interface.PlaySoundBuffer, output)
	end
end

function Interface.SoundBuffer(timePassed)

	-- is EC Playssound and the disk I/O active?
	if not Interface.ECPlaySoundActive or Interface.DisableDiskIO then
		return
	end

	-- read the file
	local musicDisabled = LoadTextFile("logs/disableMusicON.dat") ~= nil

	-- is the music disabled from EC Playsound?
	if musicDisabled then

		-- disable the music on the UI
		Interface.ECMusic.enabled = false

	else
		-- get the real setting value for EC Music
		Interface.ECMusic.enabled = Interface.ECMusic.trueValue
	end
	
	-- increase the time
	Interface.PlaySoundDelta = Interface.PlaySoundDelta + timePassed

	-- is it time for an update?
	if Interface.PlaySoundDelta >= 0.1 then
		
		-- do we have the sound buffer?
		if not Interface.PlaySoundBuffer then

			-- initialize the sound buffer
			Interface.PlaySoundBuffer = {}
		end

		-- load the sound started confirm
		local confirm = LoadTextFile("./logs/playSoundConfirm.txt")

		-- is the file started the first in the buffer?
		if confirm == towstring(Interface.PlaySoundBuffer[1]) then
		
			-- remove the sound from the buffer
			table.remove(Interface.PlaySoundBuffer, 1)

			-- request to delete the confirm file
			CreateTextFile("logs/playSoundConfirm.txt", L"DELETE")

		elseif confirm == L"music|Theme.mp3|true" then

			-- request to delete the confirm file
			CreateTextFile("logs/playSoundConfirm.txt", L"DELETE")
		end

		-- load the music file request (if the file exist, we just sent a request)
		local text = LoadTextFile("./logs/playSound.log")
		
		-- do we have something in the buffer and we DON'T have any request pending?
		if (Interface.PlaySoundBuffer[1] and not text) then
			
			-- send a request to play a music file
			CreateTextFile("logs/playSound.log", towstring(Interface.PlaySoundBuffer[1]))
		end
		
		-- reset the timer
		Interface.PlaySoundDelta = 0
	end
	
	-- is the area music and EC Playsound active?
	if not Interface.DisableAreaMusic and Interface.ECPlaySoundActive then

		-- do we need the song length?
		if Interface.GetMusLenght == true then

			-- load the song length
			local text = LoadTextFile("./logs/musLenght.txt")
			
			-- do we have a length and it's a valid number?
			if text and IsValidID(tonumber(text)) then
				
				-- format the number by converting the comma in dot
				text = tostring(wstring.gsub(text, L",", L"."))

				-- mark the file to be deleted
				CreateTextFile("logs/musLenght.txt", L"DELETE")

				-- update the music length
				Interface.MusLenght = Interface.TimeSinceLogin + tonumber(text) - 1

				-- remove the length check
				Interface.GetMusLenght = false
			end

		else -- load the song length
			local text = LoadTextFile("./logs/musLenght.txt")

			-- do we have the file and we don't need it?
			if text and text ~= L"DELETE" then

				-- mark the file to be deleted
				CreateTextFile("logs/musLenght.txt", L"DELETE")
			end
		end
		
		-- do we have the music length and the time is up?
		if Interface.MusLenght > 0 and Interface.TimeSinceLogin >= Interface.MusLenght then

			-- flag for the music changed
			local changed = false

			-- are we in a tavern?
			if (MapCommon.CurrentAreaMusic and string.find(MapCommon.CurrentAreaMusic, "Tavern", 1, true)) then

				-- request a random tavern music
				MapCommon.CurrentAreaMusic = "Tavern" .. math.random(Interface.TavernSongs) .. ".mp3"

				-- flag the music as changed
				changed = true
			end

			-- is the war music on?
			if MapCommon.WarMusic then

				-- default war mode type
				local type = "WarMode"

				-- total war mode songs
				local count = Interface.WarSongs

				-- are we on water?
				if MapCommon.OnWater then

					-- change the type on water war music
					type = "SeaWarMode"

					-- total number of water war songs
					count = Interface.SeaWarSongs
				end

				-- get a random war mode song
				MapCommon.CurrentAreaMusic = type .. math.random(Interface.WarSongs) .. ".mp3"

				-- flag the music as changed
				changed = true
			end

			-- are we in a champion spawn area?
			if MapCommon.CurrentAreaMusic and string.find(MapCommon.CurrentAreaMusic, "Champion", 1, true) then

				-- get a random champion spawn soung
				MapCommon.CurrentAreaMusic = "Champion" .. math.random(Interface.ChampionSongs) .. ".mp3"

				-- flag the music as changed
				changed = true
			end

			-- is the music changed?
			if not changed then

				-- increase the number of loops
				Interface.Loops = Interface.Loops + 1

				-- time to change music?
				if Interface.Loops % 2 > 0 then
					
					-- get a random wilderness song
					MapCommon.CurrentAreaMusic = "WildSong" .. math.random(Interface.WildSongs) .. ".mp3"

				else -- play the current song
					MapCommon.CurrentAreaMusic = MapCommon.originalAreaMus
				end
			end

			-- if the player is not dead and there is no water music, change the song
			if not (MapCommon.DeadMusic or MapCommon.WaterMusic) then
				ECPlaySound(1, MapCommon.CurrentAreaMusic, 2) 
			end
		end
	end
end

-------------------------------------------------------------------------------

-- LOAD/SAVE

-------------------------------------------------------------------------------

function Interface.ClearOldSettings()
	
	local windowPositions = SystemData.Settings.Interface.WindowPositions

	local winToRemove = {}
	
	for i, windowName in pairs(SystemData.Settings.Interface.WindowPositions.Names) do
		if string.find(windowName, "CustomSetting___", 1, true) then
			table.insert(winToRemove, windowName)
			continue
		end
		if string.find(windowName, "BuffDebuffIcon", 1, true) then
			table.insert(winToRemove, windowName)
			continue
		end
		
		if string.find(windowName, "CorrectWindow", 1, true) then
			table.insert(winToRemove, windowName)
			continue
		end
		
		if windowName == "UOKRPetWindow" then
			table.insert(winToRemove, windowName)
			continue
		end
		
		if windowName == "PerfectionCounter" then
			table.insert(winToRemove, windowName)
			continue
		end
		
		if windowName == "QuickDetailsWindow" then
			table.insert(winToRemove, windowName)
			continue
		end
		
		if windowName == "Hourglass" then
			table.insert(winToRemove, windowName)
			continue
		end
		
		if windowName == "MapWaypoints" then
			table.insert(winToRemove, windowName)
			continue
		end
		
		if windowName == "ImbuingCalcWindow" then
			table.insert(winToRemove, windowName)
			continue
		end
		
		if windowName == "SlayerNote" then
			table.insert(winToRemove, windowName)
			continue
		end
		
		if windowName == "CORPSECont" then
			table.insert(winToRemove, windowName)
			continue
		end
		
		if windowName == "DurabilityBar" then
			table.insert(winToRemove, windowName)
			continue
		end
		
		if windowName == "ObjectHandleToggleWindow" then
			table.insert(winToRemove, windowName)
			continue
		end
		
		if windowName == "RUNEBOOK_GUMP" then
			table.insert(winToRemove, windowName)
			continue
		end
		
		if windowName == "FriendList" then
			table.insert(winToRemove, windowName)
			continue
		end

		if windowName == "MobilesOnScreenWindow" then
			table.insert(winToRemove, windowName)
			continue
		end

		if windowName == "PetWindow" then
			table.insert(winToRemove, windowName)
			continue
		end

		if string.find(windowName, "PartyHealthBar_", 1, true) then
			table.insert(winToRemove, windowName)
			continue
		end

		if string.find(windowName, "PartyHealthBar_", 1, true) then
			table.insert(winToRemove, windowName)
			continue
		end
	
		 -- reset the position of windows too far outside the screen
		if windowPositions.WindowPosX[i] < - 100 and windowPositions.WindowPosY[i] < - 100 then
			table.insert(winToRemove, windowName)
			continue
		end
	end
	
	for i, windowName in pairs(winToRemove) do
		WindowUtils.ClearWindowPosition(windowName)
	end
	
	winToRemove = {}
	
	local nBools = #SystemData.Settings.Interface.UIVariables.BoolNames
	for i = 1, nBools do
		if string.find(SystemData.Settings.Interface.UIVariables.BoolNames[i], "LootSort", 1, true) then
			table.insert(winToRemove, i)
		end
	end

	Interface.DeleteSetting("LastMasteryChange")
	Interface.DeleteSetting("QuickLootEverywhere")
	Interface.DeleteSetting("MobileHealthBarSCALESC")
	Interface.DeleteSetting("PrtyHealthBarSCALESC")
	Interface.DeleteSetting("ContainerWindowSCALESC")
	Interface.DeleteSetting("CourseMapWindowSCALESC")
	Interface.DeleteSetting("SpellbookSCALESC")
	Interface.DeleteSetting("ObjectHandleWindowSCALESC")
	Interface.DeleteSetting("MobileHealthBarALPHA")
	Interface.DeleteSetting("PrtyHealthBarALPHA")
	Interface.DeleteSetting("ObjectHandleWindowALPHA")
	Interface.DeleteSetting("MobileHealthBarALPHA")
	Interface.DeleteSetting("CourseMapWindowALPHA")
	Interface.DeleteSetting("MapZoom")
	Interface.DeleteSetting("MapZoomBig")
	Interface.DeleteSetting("MapWindowBigW")
	Interface.DeleteSetting("MapWindowBigH")
	Interface.DeleteSetting("MapWindowW")
	Interface.DeleteSetting("MapWindowH")
	Interface.DeleteSetting("MapWindowTilt")
	Interface.DeleteSetting("ShowMapCombos")
	Interface.DeleteSetting("ShowNameHealthbars")

	for i, index in pairs(winToRemove) do
		table.remove( SystemData.Settings.Interface.UIVariables.BoolNames, index)
		table.remove( SystemData.Settings.Interface.UIVariables.BoolValues, index)
	end

	-- delete the waypoint data array (unused with the new system)
	WindowData.WaypointDisplay.displayTypes = nil
end

function Interface.SaveSetting( settingName, settingValue )
	
	if type(settingValue) == type(true) then
		Interface.SaveBoolean( settingName, settingValue )

	elseif type(settingValue) == type(0) then
		Interface.SaveNumber( settingName, settingValue )
		
	elseif Interface.CheckColor(settingValue) then
		Interface.SaveColor( settingName, settingValue )

	elseif type(settingValue) == type("") then
		
		Interface.SaveString( settingName, settingValue )

	elseif type(settingValue) == type(L"") then
		Interface.SaveWString( settingName, settingValue )
	
	elseif settingValue == nil then
		Debug.Print("Trying to save NULL value for: " .. settingName)

	else
		Debug.Print("Trying to save undefined type for: " .. settingName)
	end
end

function Interface.LoadSetting( settingName, defaultValue, settingType )
	
	-- do we have a default value?
	if defaultValue ~= nil then
		if type(defaultValue) == type(true) then
			return Interface.LoadBoolean( settingName, defaultValue )

		elseif type(defaultValue) == type(0) then
			return Interface.LoadNumber( settingName, defaultValue )

		elseif Interface.CheckColor(defaultValue) then
			return Interface.LoadColor( settingName, defaultValue )

		elseif type(defaultValue) == type("") then
			return Interface.LoadString( settingName, defaultValue )

		elseif type(defaultValue) == type(L"") then
			return Interface.LoadWString( settingName, defaultValue )			
		end

	-- settingType is use as example in case there is no default value
	elseif settingType ~= nil then
		if type(settingType) == type(true) then
			return Interface.LoadBoolean( settingName, defaultValue )

		elseif type(settingType) == type(0) then
			return Interface.LoadNumber( settingName, defaultValue )

		elseif Interface.CheckColor(settingType) then
			return Interface.LoadColor( settingName, defaultValue )

		elseif type(settingType) == type("") then
			return Interface.LoadString( settingName, defaultValue )

		elseif type(settingType) == type(L"") then
			return Interface.LoadWString( settingName, defaultValue )
		end
	else
		Debug.Print("Trying to load undefined type for: " .. settingName)
	end
end

-------------------------------------------------------------------------------
-- Interface.SaveBoolean
-- Description:
--     Saves a boolean value for a setting
-- Parameters:
--     settingName - the name of the setting to be saved
--     settingValue - the value to be saved
-- Returns:
--     True if the setting was saved, false if it failed
-------------------------------------------------------------------------------
function Interface.SaveBoolean( settingName, settingValue )

	-- Check the types of the arguments
	if type( settingName ) ~= type( "") then
		Debug.Print( "Interface.SaveBoolean: settingName must be a boolean -- SETTING: " .. settingName .. " VALUE: " .. tostring(settingValue) )
		return false
	end
	if type( settingValue ) ~= type( true) then
		Debug.Print( "Interface.SaveBoolean: settingValue must be a boolean -- SETTING: " .. settingName .. " VALUE: " .. tostring(settingValue) )
		return false
	end
	
	local nBools = #SystemData.Settings.Interface.UIVariables.BoolNames
	if nBools <= 0 then
		table.insert(SystemData.Settings.Interface.UIVariables.BoolNames, settingName)
		table.insert(SystemData.Settings.Interface.UIVariables.BoolValues, settingValue)
	else
		local found = false
		for i = 1, nBools do
			if SystemData.Settings.Interface.UIVariables.BoolNames[i] == settingName then
				SystemData.Settings.Interface.UIVariables.BoolValues[i] = settingValue
				found = true
				break
			end
		end
		if not found then
			table.insert(SystemData.Settings.Interface.UIVariables.BoolNames, settingName)
			table.insert(SystemData.Settings.Interface.UIVariables.BoolValues, settingValue)
		end
	end
end

-------------------------------------------------------------------------------
-- Interface.SaveNumber
-- Description:
--     Saves a numeric value for a setting
-- Parameters:
--     settingName - the name of the setting to be saved
--     settingValue - the value to be saved
-------------------------------------------------------------------------------
function Interface.SaveNumber( settingName, settingValue )
	-- Check the types of the arguments
	if type( settingName ) ~= type( "") then
		Debug.Print( "Interface.SaveNumber: settingName must be a number -- SETTING: " .. settingName .. " VALUE: " .. tostring(settingValue) )
		return false
	end
	if type( settingValue ) ~= type( 0) then
		Debug.Print( "Interface.SaveNumber: settingValue must be a number -- SETTING: " .. settingName .. " VALUE: " .. tostring(settingValue) )
		return false
	end

	local nNumbers = #SystemData.Settings.Interface.UIVariables.NumberNames
	if nNumbers <= 0 then
		table.insert(SystemData.Settings.Interface.UIVariables.NumberNames, settingName)
		table.insert(SystemData.Settings.Interface.UIVariables.NumberValues, settingValue)
	else
		local found = false
		for i = 1, nNumbers do
			if SystemData.Settings.Interface.UIVariables.NumberNames[i] == settingName then
				SystemData.Settings.Interface.UIVariables.NumberValues[i] = settingValue
				found = true
				break
			end
		end
		if not found then
			table.insert(SystemData.Settings.Interface.UIVariables.NumberNames, settingName)
			table.insert(SystemData.Settings.Interface.UIVariables.NumberValues, settingValue)
		end
	end
	
	Interface.DeleteSetting( "GumpScale999116" )
	Interface.DeleteSetting( "GumpAlpha999116" )
end

-------------------------------------------------------------------------------
-- Interface.SaveColor
-- Description:
--     Saves a color value for a setting
-- Parameters:
--     settingName - the name of the setting to be saved
--     settingValue - the value to be saved 
--                    (table {r=(0-255),g=(0-255),b=(0-255)[,a=(0-255)]})
-------------------------------------------------------------------------------
function Interface.SaveColor( settingName, settingValue )
	-- Check the types of the arguments
	if type( settingName ) ~= type( "") then
		Debug.Print( "Interface.SaveColor: settingName must be a color -- SETTING: " .. settingName .. " VALUE: " .. tostring(settingValue) )
		return false
	end
	--Debug.Print("Checking Color: " .. settingName)
	if not Interface.CheckColor( settingValue, "Interface.SaveColor -- SETTING: " .. settingName .. " VALUE: " .. tostring(settingValue)) then
		-- Debug printing in CheckColor function
		return false
	end
	
	local r = settingValue.r
	local g = settingValue.g
	local b = settingValue.b
	local a = settingValue.a
	
	if not a then
		a = 255
	end
	
	local nColors = #SystemData.Settings.Interface.UIVariables.ColorNames
	if nColors <= 0 then
		table.insert(SystemData.Settings.Interface.UIVariables.ColorNames, settingName)
		table.insert(SystemData.Settings.Interface.UIVariables.ColorRedValues, r)
		table.insert(SystemData.Settings.Interface.UIVariables.ColorGreenValues, g)
		table.insert(SystemData.Settings.Interface.UIVariables.ColorBlueValues, b)
		table.insert(SystemData.Settings.Interface.UIVariables.ColorAlphaValues, a)
	else
		local found = false
		for i = 1, nColors do
			if SystemData.Settings.Interface.UIVariables.ColorNames[i] == settingName then
				SystemData.Settings.Interface.UIVariables.ColorRedValues[i] = r
				SystemData.Settings.Interface.UIVariables.ColorGreenValues[i] = g
				SystemData.Settings.Interface.UIVariables.ColorBlueValues[i] = b
				SystemData.Settings.Interface.UIVariables.ColorAlphaValues[i] = a
				found = true
				break
			end
		end
		if not found then
			table.insert(SystemData.Settings.Interface.UIVariables.ColorNames, settingName)
			table.insert(SystemData.Settings.Interface.UIVariables.ColorRedValues, r)
			table.insert(SystemData.Settings.Interface.UIVariables.ColorGreenValues, g)
			table.insert(SystemData.Settings.Interface.UIVariables.ColorBlueValues, b)
			table.insert(SystemData.Settings.Interface.UIVariables.ColorAlphaValues, a)
		end
	end
end


-------------------------------------------------------------------------------
-- Interface.SaveString
-- Description:
--     Saves a string value for a setting
-- Parameters:
--     settingName - the name of the setting to be saved
--     settingValue - the value to be saved
-------------------------------------------------------------------------------
function Interface.SaveString( settingName, settingValue )
	-- Check the types of the arguments
	if type( settingName ) ~= type( "") then
		Debug.Print( "Interface.SaveString: settingName must be a string -- SETTING: " .. settingName .. " VALUE: " .. tostring(settingValue) )
		return false
	end
	if type( settingValue ) ~= type( "") then
		Debug.Print( "Interface.SaveString: settingValue must be a string -- SETTING: " .. settingName .. " VALUE: " .. tostring(settingValue) )
		return false
	end

	-- if there is an empty string, the client can save it correctly, but it will load random stuff...
	if not IsValidString(string.trim(settingValue)) then
		settingValue = "nil"
	end

	local nStrings = #SystemData.Settings.Interface.UIVariables.StringNames
	if nStrings <= 0 then
		table.insert(SystemData.Settings.Interface.UIVariables.StringNames, settingName)
		table.insert(SystemData.Settings.Interface.UIVariables.StringValues, settingValue)
	else
		local found = false
		for i = 1, nStrings do
			if SystemData.Settings.Interface.UIVariables.StringNames[i] == settingName then
				SystemData.Settings.Interface.UIVariables.StringValues[i] = settingValue
				found = true
				break
			end
		end
		if not found then
			table.insert(SystemData.Settings.Interface.UIVariables.StringNames, settingName)
			table.insert(SystemData.Settings.Interface.UIVariables.StringValues, settingValue)
		end
	end
end

-------------------------------------------------------------------------------
-- Interface.SaveWString
-- Description:
--     Saves a wstring value for a setting
-- Parameters:
--     settingName - the name of the setting to be saved
--     settingValue - the value to be saved
-------------------------------------------------------------------------------
function Interface.SaveWString( settingName, settingValue )
	-- Check the types of the arguments

	if type( settingValue ) ~= type( L"") then
		Debug.Print( "Interface.SaveString: settingValue must be a wstring -- SETTING: " .. settingName .. " VALUE: " .. tostring(settingValue) )
		return false
	end

	-- if there is an empty string, the client can save it correctly, but it will load random stuff...
	if not IsValidWString(wstring.trim(settingValue)) then
		settingValue = L"nil"
	end
	
	local nWStrings = #SystemData.Settings.Interface.UIVariables.WStringNames
	if nWStrings <= 0 then
		table.insert(SystemData.Settings.Interface.UIVariables.WStringNames, settingName)
		table.insert(SystemData.Settings.Interface.UIVariables.WStringValues, settingValue)
	else
		local found = false
		for i = 1, nWStrings do
			if SystemData.Settings.Interface.UIVariables.WStringNames[i] == settingName then
				SystemData.Settings.Interface.UIVariables.WStringValues[i] = settingValue
				found = true
				break
			end
		end
		if not found then
			table.insert(SystemData.Settings.Interface.UIVariables.WStringNames, settingName)
			table.insert(SystemData.Settings.Interface.UIVariables.WStringValues, settingValue)
		end
	end
end


-------------------------------------------------------------------------------
-- Interface.DeleteSetting
-- Description:
--     Delete an existing setting
-- Parameters:
--     settingName - the name of the setting (with the prefix)
-------------------------------------------------------------------------------

function Interface.DeleteSetting( settingName )
	local nBools = #SystemData.Settings.Interface.UIVariables.BoolNames
	for i = 1, nBools do
		if SystemData.Settings.Interface.UIVariables.BoolNames[i] == settingName then
			table.remove( SystemData.Settings.Interface.UIVariables.BoolNames, i)
			table.remove( SystemData.Settings.Interface.UIVariables.BoolValues, i)
			return
		end
	end
	
	local nNumbers = #SystemData.Settings.Interface.UIVariables.NumberNames
	for i = 1, nNumbers do
		if SystemData.Settings.Interface.UIVariables.NumberNames[i] == settingName then
			table.remove( SystemData.Settings.Interface.UIVariables.NumberNames, i)
			table.remove( SystemData.Settings.Interface.UIVariables.NumberValues, i)
			return
		end
	end
	
	local nColors = #SystemData.Settings.Interface.UIVariables.ColorNames
	for i = 1, nColors do
		if SystemData.Settings.Interface.UIVariables.ColorNames[i] == settingName then
			table.remove( SystemData.Settings.Interface.UIVariables.ColorNames, i)
			table.remove( SystemData.Settings.Interface.UIVariables.ColorRedValues, i)
			table.remove( SystemData.Settings.Interface.UIVariables.ColorGreenValues, i)
			table.remove( SystemData.Settings.Interface.UIVariables.ColorBlueValues, i)
			table.remove( SystemData.Settings.Interface.UIVariables.ColorAlphaValues, i)
			return
		end
	end
	
	local nStrings = #SystemData.Settings.Interface.UIVariables.StringNames
	for i = 1, nStrings do
		if SystemData.Settings.Interface.UIVariables.StringNames[i] == settingName then
			table.remove( SystemData.Settings.Interface.UIVariables.StringNames, i)
			table.remove( SystemData.Settings.Interface.UIVariables.StringValues, i)
			return
		end
	end
	
	local nWStrings = #SystemData.Settings.Interface.UIVariables.WStringNames
	for i = 1, nWStrings do
		if SystemData.Settings.Interface.UIVariables.WStringNames[i] == settingName then
			table.remove( SystemData.Settings.Interface.UIVariables.WStringNames, i)
			table.remove( SystemData.Settings.Interface.UIVariables.WStringValues, i)
			return
		end
	end
end

-------------------------------------------------------------------------------
-- Interface.CheckColor
-- Description:
--     Checks to see if an argument is a valid color table
-- Parameters:
--     color - the argument to check
--     rootFunction - the name of the function to use in the debug messages
--                    no logging is done if this is nil
-- Returns:
--     True if it is a valid color, false otherwise
-------------------------------------------------------------------------------
function Interface.CheckColor( color, rootFunction )
	local good = true
	if type( color ) ~= type( {}) then
		good = false
	elseif type( color.r ) ~= type( 0 ) or color.r < 0 or color.r > 255 then
		good = false
	elseif type( color.g ) ~= type( 0 ) or color.g < 0 or color.g > 255 then
		good = false
	elseif type( color.b ) ~= type( 0 ) or color.b < 0 or color.b > 255 then
		good = false
	elseif color.a ~= nil and type( color.a ) ~= type( 0) then
		if (color.a < 0 or color.a > 255) then
			good = false
		end
	end
	if not good and rootFunction ~= nil then
		Debug.Print( rootFunction .. ": color must be a table with r, g, and b values between 0 and 255 (with an option a value between 0 and 255)" )
	end
	return good
end

-------------------------------------------------------------------------------
-- Interface.LoadBoolean
-- Description:
--     Gets the boolean value of a setting 
-- Parameters:
--     settingName - the name of the setting
--     defaultValue - a value to use as a default if it wasn't saved properly
-- Returns:
--     The value of the setting if it was saved properly, the default value if
--     it wasn't saved properly, or nil if it wasn't saved properly and no
--     default value was provided
-------------------------------------------------------------------------------
function Interface.LoadBoolean( settingName, defaultValue )
	-- Check the types of the arguments
	if type( settingName ) ~= type( "") then
		Debug.Print( "Interface.LoadNumber: settingName must be a string" )
		return defaultValue
	end
	
	if not SystemData.Settings.Interface.UIVariables.BoolNames then
		return defaultValue
	end
	
	local nBools = #SystemData.Settings.Interface.UIVariables.BoolNames
	for i = 1, nBools do
		
		if SystemData.Settings.Interface.UIVariables.BoolNames[i] == settingName then
		--[[
			Debug.Print(settingName)
			Debug.Print(SystemData.Settings.Interface.UIVariables.BoolValues[i])
			Debug.Print("-------")
		--]]
			return SystemData.Settings.Interface.UIVariables.BoolValues[i]
		end
	end
	return defaultValue
end

-------------------------------------------------------------------------------
-- Interface.LoadNumber
-- Description:
--     Gets the numeric value of a setting 
-- Parameters:
--     settingName - the name of the setting
--     defaultValue - a value to use as a default if it wasn't saved properly
-- Returns:
--     The value of the setting if it was saved properly, the default value if
--     it wasn't saved properly, or nil if it wasn't saved properly and no
--     default value was provided
-------------------------------------------------------------------------------
function Interface.LoadNumber( settingName, defaultValue )
	-- Check the types of the arguments
	if type( settingName ) ~= type( "") then
		Debug.Print( "Interface.LoadNumber: settingName must be a string" )
		return defaultValue
	end
	
	if not SystemData.Settings.Interface.UIVariables.NumberNames then
		return defaultValue
	end
	
	local nNumbers = #SystemData.Settings.Interface.UIVariables.NumberNames
	for i = 1, nNumbers do
		if SystemData.Settings.Interface.UIVariables.NumberNames[i] == settingName then
			return SystemData.Settings.Interface.UIVariables.NumberValues[i]
		end
	end
	return defaultValue
end

-------------------------------------------------------------------------------
-- Interface.LoadColor
-- Description:
--     Gets the color value of a setting 
-- Parameters:
--     settingName - the name of the setting
--     defaultValue - a value to use as a default if it wasn't saved properly
-- Returns:
--     The value of the setting if it was saved properly, the default value if
--     it wasn't saved properly, or nil if it wasn't saved properly and no
--     default value was provided
-------------------------------------------------------------------------------
function Interface.LoadColor( settingName, defaultValue )
	-- Check the types of the arguments
	if type( settingName ) ~= type( "") then
		Debug.Print( "Interface.LoadColor: settingName must be a string" )
		return false
	end
	
	if not SystemData.Settings.Interface.UIVariables.ColorNames then
		return defaultValue
	end

	local nStrings = #SystemData.Settings.Interface.UIVariables.ColorNames
	for i = 1, nStrings do
		if SystemData.Settings.Interface.UIVariables.ColorNames[i] == settingName then
			return {
					r=SystemData.Settings.Interface.UIVariables.ColorRedValues[i],
					g=SystemData.Settings.Interface.UIVariables.ColorGreenValues[i],
					b=SystemData.Settings.Interface.UIVariables.ColorBlueValues[i],
					a=SystemData.Settings.Interface.UIVariables.ColorAlphaValues[i]
				   }
		end
	end
	return defaultValue
end

-------------------------------------------------------------------------------
-- Interface.LoadStringValue
-- Parameters:
--     settingName - the name of the setting
--     defaultValue - a value to use as a default if it wasn't saved properly
-------------------------------------------------------------------------------
function Interface.LoadString( settingName, defaultValue )
    -- Check the types of the arguments
	if type( settingName ) ~= type( "") then
		Debug.Print( "Interface.LoadNumber: settingName must be a string" )
		return defaultValue
	end
	
	if not SystemData.Settings.Interface.UIVariables.StringNames then
		return defaultValue
	end
	
	local nStrings = #SystemData.Settings.Interface.UIVariables.StringNames
	for i = 1, nStrings do
		if SystemData.Settings.Interface.UIVariables.StringNames[i] == settingName then
			
			local settingValue = SystemData.Settings.Interface.UIVariables.StringValues[i]

			-- if there is an empty string, the client can save it correctly, but it will load random stuff...
			if settingValue == "nil" then
				settingValue = ""
			end
			return settingValue
		end
	end
	return defaultValue
end


-------------------------------------------------------------------------------
-- Interface.LoadWStringValue
-- Parameters:
--     settingName - the name of the setting
--     defaultValue - a value to use as a default if it wasn't saved properly
-------------------------------------------------------------------------------

function Interface.LoadWString( settingName, defaultValue )
	-- Check the types of the arguments
	if type( settingName ) ~= type( "") then
		Debug.Print( "Interface.LoadNumber: settingName must be a string" )
		return defaultValue
	end
	
	if not SystemData.Settings.Interface.UIVariables.WStringNames then
		return defaultValue
	end
	
    local nWStrings = #SystemData.Settings.Interface.UIVariables.WStringNames
	for i = 1, nWStrings do
		if SystemData.Settings.Interface.UIVariables.WStringNames[i] == settingName then

			local settingValue = SystemData.Settings.Interface.UIVariables.WStringValues[i]

			-- if there is an empty string, the client can save it correctly, but it will load random stuff...
			if settingValue == L"nil" then
				settingValue = L""
			end
			return settingValue
		end
	end

	return defaultValue
end

-------------------------------------------------------------------------------
-- DEV UTILITY
-------------------------------------------------------------------------------

function ExportCliloc()
	local output = L""
	TextLogCreate("Cliloc", 5000000)
	TextLogSetEnabled("Cliloc", true)
	TextLogClear("Cliloc")
		
	TextLogSetIncrementalSaving( "Cliloc", true, "logs/[" .. GetClockString() .. "] Cliloc.txt")

	for i=0, 5000000 do	
		local str = GetStringFromTid(i, false)
		if (str == L"MISSING STRING" or str == "" or str == L"") then
			continue
		end
		output = i .. L" -- " .. towstring(str)
		TextLogAddEntry("Cliloc", i, output)
	end

	
	TextLogDestroy("Cliloc")
end