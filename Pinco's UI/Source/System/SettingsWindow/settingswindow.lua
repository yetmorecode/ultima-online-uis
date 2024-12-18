
----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

SettingsWindow = {}

-- System Messages
SettingsWindow.IGNORE_LIST_ALL = 0
SettingsWindow.IGNORE_LIST_CONF	= 1
SettingsWindow.ignoreListType	= SettingsWindow.IGNORE_LIST_ALL

SettingsWindow.Modes = {}
SettingsWindow.Modes.Graphics = 1 
SettingsWindow.Modes.KeyBindings = 2 
SettingsWindow.Modes.Options = 5
SettingsWindow.Modes.NUM_MODES = 13

SettingsWindow.Modes.windows = 
{ 
	"SettingsGraphicsWindow", 
	"SettingsKeyBindingsWindow", 
	"SettingsSoundWindow", 
	"SettingsOptionsWindow", 
	"SettingsLegacyWindow", 
	"SettingsProfanityWindow", 
	"SettingsKeyDefaultWindow",
	"OverheadTextSettingsWindow",
	"ContainersSettingsWindow",
	"HealthbarsSettingsWindow",
	"SettingsMobilesOnScreen",
	"NewChatSettingsWindow",
	"PropertiesSettingsWindow",
}
								
SettingsWindow.LegacyBackpackStyle = {}
SettingsWindow.LegacyBackpackStyle[1] = {tid = 1157260, id = SystemData.Settings.LegacyBackpackStyle.LEGACY_BACKPACK_DEFAULT}
SettingsWindow.LegacyBackpackStyle[2] = {tid = 1157261, id = SystemData.Settings.LegacyBackpackStyle.LEGACY_BACKPACK_SUEDE} --Suede
SettingsWindow.LegacyBackpackStyle[3] = {tid = 1157262, id = SystemData.Settings.LegacyBackpackStyle.LEGACY_BACKPACK_POLAR_BEAR} -- Polar Bear
SettingsWindow.LegacyBackpackStyle[4] = {tid = 1157263, id = SystemData.Settings.LegacyBackpackStyle.LEGACY_BACKPACK_GHOUL_SKIN} --Ghoul Skin

SettingsWindow.FontSizes = {}
SettingsWindow.FontSizes[1] = 12
SettingsWindow.FontSizes[2] = 14
SettingsWindow.FontSizes[3] = 16
SettingsWindow.FontSizes[4] = 18
SettingsWindow.FontSizes[5] = 20
SettingsWindow.FontSizes[6] = 22
SettingsWindow.FontSizes[7] = 24
SettingsWindow.NUM_FONT_SIZES = 7

SettingsWindow.ChatFadeTime = {}
SettingsWindow.ChatFadeTime[1] = 1
SettingsWindow.ChatFadeTime[2] = 2
SettingsWindow.ChatFadeTime[3] = 3
SettingsWindow.ChatFadeTime[4] = 4
SettingsWindow.ChatFadeTime[5] = 5
SettingsWindow.NUM_FADE_TIMES = 5

SettingsWindow.Languages = {}
SettingsWindow.Languages[1] = {tid = 1077459, id = SystemData.Settings.Language.LANGUAGE_ENU}
SettingsWindow.Languages[2] = {tid = 1077460, id = SystemData.Settings.Language.LANGUAGE_JPN}
SettingsWindow.Languages[3] = {tid = 1078516, id = SystemData.Settings.Language.LANGUAGE_CHINESE_TRADITIONAL}
SettingsWindow.Languages[4] = {tid = 1156035, id = SystemData.Settings.Language.LANGUAGE_KOR}

SettingsWindow.ShowNames = {}
SettingsWindow.ShowNames[1] = {tid = 1011051, id = SystemData.Settings.GameOptions.SHOWNAMES_NONE}
SettingsWindow.ShowNames[2] = {tid = 1078090, id = SystemData.Settings.GameOptions.SHOWNAMES_APPROACHING}
SettingsWindow.ShowNames[3] = {tid = 1078091, id = SystemData.Settings.GameOptions.SHOWNAMES_ALL}

SettingsWindow.ScrollWheelBehaviors = {}
SettingsWindow.ScrollWheelBehaviors[1] = {tid = 1079288, id = SystemData.Settings.GameOptions.MOUSESCROLL_ZOOM_IN_CAMERA }
SettingsWindow.ScrollWheelBehaviors[2] = {tid = 1079289, id = SystemData.Settings.GameOptions.MOUSESCROLL_ZOOM_OUT_CAMERA }
SettingsWindow.ScrollWheelBehaviors[3] = {tid = 1079177, id = SystemData.Settings.GameOptions.MOUSESCROLL_TARGET_NEXT_FRIENDLY }
SettingsWindow.ScrollWheelBehaviors[4] = {tid = 1111940, id = SystemData.Settings.GameOptions.MOUSESCROLL_TARGET_LAST_FRIENDLY }
SettingsWindow.ScrollWheelBehaviors[5] = {tid = 1079178, id = SystemData.Settings.GameOptions.MOUSESCROLL_TARGET_NEXT_ENEMY }
SettingsWindow.ScrollWheelBehaviors[6] = {tid = 1111941, id = SystemData.Settings.GameOptions.MOUSESCROLL_TARGET_LAST_ENEMY }
SettingsWindow.ScrollWheelBehaviors[7] = {tid = 1094824, id = SystemData.Settings.GameOptions.MOUSESCROLL_TARGET_NEXT_ANY }
SettingsWindow.ScrollWheelBehaviors[8] = {tid = 1111942, id = SystemData.Settings.GameOptions.MOUSESCROLL_TARGET_LAST_ANY }
SettingsWindow.ScrollWheelBehaviors[9] = {tid = 1079156, id = SystemData.Settings.GameOptions.MOUSESCROLL_CURSOR_TARGET_LAST }
SettingsWindow.ScrollWheelBehaviors[10] = {tid = 1079158, id = SystemData.Settings.GameOptions.MOUSESCROLL_CURSOR_TARGET_SELF }
SettingsWindow.ScrollWheelBehaviors[11] = {tid = 1079157, id = SystemData.Settings.GameOptions.MOUSESCROLL_CURSOR_TARGET_CURRENT }
SettingsWindow.ScrollWheelBehaviors[12] = {tid = 1112413, id = SystemData.Settings.GameOptions.MOUSESCROLL_CYCLE_CURSOR_TARGET }
SettingsWindow.ScrollWheelBehaviors[13] = {tid = 1115342, id = SystemData.Settings.GameOptions.MOUSESCROLL_CLEAR_TARGET_QUEUE }
SettingsWindow.ScrollWheelBehaviors[14] = {tid = 1011051, id = SystemData.Settings.GameOptions.MOUSESCROLL_NONE }

SettingsWindow.DelayValues = {}
SettingsWindow.DelayValues[1] = 1078334
SettingsWindow.DelayValues[2] = 1078336
SettingsWindow.DelayValues[3] = 1078337
SettingsWindow.DelayValues[4] = 1078338
SettingsWindow.DelayValues[5] = 1078339
SettingsWindow.DelayValues[6] = 1078340

SettingsWindow.ContainerViewOptions = {}
SettingsWindow.ContainerViewOptions[1] = { name = "List", tid = 1079824 }
SettingsWindow.ContainerViewOptions[2] = { name = "Grid", tid = 1079825 }
SettingsWindow.ContainerViewOptions[3] = { name = "Freeform", tid = 1079826 }

SettingsWindow.ObjectHandles = {}
SettingsWindow.ObjectHandles[1] = { id = SystemData.Settings.ObjectHandleFilter.eDynamicFilter, tid = 1079457}
SettingsWindow.ObjectHandles[2] = { id = SystemData.Settings.ObjectHandleFilter.eCorpseFilterFixed, tid = 1078368}
SettingsWindow.ObjectHandles[3] = { id = SystemData.Settings.ObjectHandleFilter.eNPCFilter, tid = 1079458}
SettingsWindow.ObjectHandles[4] = { id = SystemData.Settings.ObjectHandleFilter.eNPCVendorFilter, tid = 1079459}
SettingsWindow.ObjectHandles[5] = { id = SystemData.Settings.ObjectHandleFilter.eMobileFilter, tid = 1075672}
SettingsWindow.ObjectHandles[6] = { id = SystemData.Settings.ObjectHandleFilter.eItemsOnlyFilter, tid = 1154804}
SettingsWindow.ObjectHandles[7] = { id = SystemData.Settings.ObjectHandleFilter.eLostItemsOnlyFilter, tid = 1154805}

SettingsWindow.LowHPOptions = { L"5%", L"10%", L"15%", L"20%", L"25%", L"30%", L"35%", L"40%", L"45%", L"50%", L"60%", L"70%", L"80%", L"90%", L"99%", GetStringFromTid(1155308)}

SettingsWindow.IntensityColors = { 250, 251, 252, 253, 254, 255, 256}

SettingsWindow.NUM_OBJHANDLE_FILTERS = #SettingsWindow.ObjectHandles

SettingsWindow.ObjectHandleSizes = {50, 100, 200, 300, -1}

SettingsWindow.Keybindings = 
{
	{ name = "MoveUp", tid = 1077791, type = "FORWARD" },
	{ name = "TurnUp", tid = 296, type = "FORWARD_TURN" },

	{ name = "MoveDown", tid = 1077792, type = "BACKWARD" },
	{ name = "TurnDown", tid = 297, type = "BACKWARD_TURN" },

	{ name = "MoveLeft", tid = 1077793, type = "LEFT" },
	{ name = "TurnLeft", tid = 1079320, type = "LEFT_TURN" },

	{ name = "MoveRight", tid = 1077794, type = "RIGHT" },
	{ name = "TurnRight", tid = 1079321, type = "RIGHT_TURN" },
	
	{ name = "AttackMode", tid = 1077813, type = "MELEE_ATTACK" },
	{ name = "PrimaryAttack", tid = 1079153, type = "USE_PRIMARY_ATTACK" },
	{ name = "SecondaryAttack", tid = 1079154, type = "USE_SECONDARY_ATTACK" },
	
	{ name = "NextGroupTarget", tid = 1079155, type = "NEXT_GROUP_TARGET" },
	{ name = "NextEnemy", tid = 1077807, type = "NEXT_ENEMY_TARGET" },
	{ name = "NextFriend", tid = 1077809, type = "NEXT_FRIENDLY_TARGET" },
	{ name = "NextFollower", tid = 1112417, type = "NEXT_FOLLOWER_TARGET" },
	{ name = "NextObject", tid = 1112424, type = "NEXT_OBJECT_TARGET" },
	{ name = "NextTarget", tid = 1094822, type = "NEXT_TARGET" },
	
	{ name = "PreviousGroupTarget", tid = 1112425, type = "PREVIOUS_GROUP_TARGET" },
	{ name = "PreviousEnemy", tid = 1112426, type = "PREVIOUS_ENEMY_TARGET" },
	{ name = "PreviousFriend", tid = 1112427, type = "PREVIOUS_FRIENDLY_TARGET" },
	{ name = "PreviousFollower", tid = 1112428, type = "PREVIOUS_FOLLOWER_TARGET" },
	{ name = "PreviousObject", tid = 1112429, type = "PREVIOUS_OBJECT_TARGET" },
	{ name = "PreviousTarget", tid = 1112430, type = "PREVIOUS_TARGET" },
	
	{ name = "NearestGroup", tid = 1112418, type = "NEAREST_GROUP_TARGET" },
	{ name = "NearestEnemy", tid = 1077811, type = "NEAREST_ENEMY_TARGET" },
	{ name = "NearestFriend", tid = 1077812, type = "NEAREST_FRIENDLY_TARGET" },
	{ name = "NearestFollower", tid = 1112419, type = "NEAREST_FOLLOWER_TARGET" },
	{ name = "NearestObject", tid = 1112423, type = "NEAREST_OBJECT_TARGET" },
	{ name = "NearestTarget", tid = 1094823, type = "NEAREST_TARGET" },
	
	{ name = "TargetSelf", tid = 1077801, type = "TARGET_SELF" },
	{ name = "TargetG1", tid = 1077802, type = "TARGET_GROUP_MEMBER_1" },
	{ name = "TargetG2", tid = 1077803, type = "TARGET_GROUP_MEMBER_2" },
	{ name = "TargetG3", tid = 1077804, type = "TARGET_GROUP_MEMBER_3" },
	{ name = "TargetG4", tid = 1077805, type = "TARGET_GROUP_MEMBER_4" },
	{ name = "TargetG5", tid = 1077806, type = "TARGET_GROUP_MEMBER_5" },
	{ name = "TargetG6", tid = 1079147, type = "TARGET_GROUP_MEMBER_6" },
	{ name = "TargetG7", tid = 1079148, type = "TARGET_GROUP_MEMBER_7" },
	{ name = "TargetG8", tid = 1079149, type = "TARGET_GROUP_MEMBER_8" },
	{ name = "TargetG9", tid = 1079150, type = "TARGET_GROUP_MEMBER_9" },
	
	{ name = "CursorTargetCurrent", tid = 1115345, type = "CURSOR_TARGET_CURRENT" },
	{ name = "CursorTargetLast", tid = 1115346, type = "CURSOR_TARGET_LAST" },
	{ name = "CursorTargetSelf", tid = 1115347, type = "CURSOR_TARGET_SELF" },
	{ name = "CycleLastCursorTarget", tid = 1115348, type = "CYCLE_LAST_CURSOR_TARGET" },
	{ name = "ClearTargetQueue", tid = 1115349, type = "CLEAR_TARGET_QUEUE" },
	
	{ name = "CharacterWin", tid = 1077795, type = "PAPERDOLL_CHARACTER_WINDOW" },
	{ name = "BackpackWin", tid = 1077796, type = "BACKPACK_WINDOW" },
	{ name = "SkillsWin", tid = 1078992, type = "SKILLS_WINDOW" },
	{ name = "ToggleMap", tid = 1078993, type = "WORLD_MAP_WINDOW" },
	{ name = "QuestLogWin", tid = 1077799, type = "QUEST_LOG_WINDOW" },
	
	{ name = "ToggleAlwaysRun", tid = 1113150, type = "TOGGLE_ALWAYS_RUN" },
	
	{ name = "ZoomIn", tid = 1079288, type = "ZOOM_IN" },
	{ name = "ZoomOut", tid = 1079289, type = "ZOOM_OUT" },
	{ name = "ZoomReset", tid = 1079290, type = "ZOOM_RESET" },
	
	{ name = "Screenshot", tid = 1079819, type = "SCREENSHOT" },
	{ name = "ToggleInterface", tid = 1079817, type = "TOGGLE_UI" },
	{ name = "ReloadInterface", tid = 1079820, type = "RELOAD_UI" },
	{ name = "ToggleCoT", tid = 1079818, type = "TOGGLE_CIRCLE_OF_TRANSPARENCY" },
	{ name = "CycleChatForward", tid = 1115574, type = "CYCLE_CHAT_FORWARD" },
	{ name = "CycleChatBackward", tid = 1115575, type = "CYCLE_CHAT_BACKWARD" },
	
	{ name = "QuitGame", tid = 1114308, type = "QUIT_GAME" },
	{ name = "LogOut", tid = 1115334, type = "LOG_OUT" },
	{ name = "Escape", tid = 1115334, type = "CANCEL" },
}

SettingsWindow.TID = 
{ 
						-- TITLE AND BUTTONS
						UserSetting = 1077814,
						ResetUILocPos = 1153107,					Reset = 1077825,							Export = 300,									Import = 301,

						-- TABS TID
						Graphics = 1077815,							Input = 1094693,							Options = 1015326,								Sound = 3000390,						Legacy = 1094697,					
						Filter = 3000173,							MobilesOnScreenTab = 1154852,				ChatTab = 1114078,								HealthbarsTab = 1155276,				ContainersTab = 1155277,				
						OverheadTextTab = 1155278,					ItemPropertiesTab = 2007,
						
						-- GRAPHICS
						Display = 3000396,					
						UseFull = 1077821,							FullRes = 1077819,							MaxFramerate = 1112340,							WindowedFullscreen = 1061,				ShowFrame = 1077820,				
						Gamma = 3000166,
						
						Environment = 1077415,							
						ShowFoliage = 1079814,						ShowShadows = 1079286,						EnableVsync = 1112689,							HardwareDeathEffect = 1115993,			ParticleLOD = 1079213,				
						ParticleFilter = 1112330,					PlayIdleAnimation = 1094692,				Animation = 1079368,							PlayFlyingAnimation = 1158627,			DisplayAllHouseContents = 1159003,

						-- INPUT
						Mouse = 1094694,
						ScrollWheelUp = 1111944,					ScrollWheelDown = 1111945,
						
						KeyBindings = 1077816,

						GlobalNoCustom = 2015,
						MainMenuKey = 1049755,						ObjectHandlesKey = 1066,					ScaleKey = 1067,								AlphaKey = 1068,

						ContainerNoCustom = 2016,
						QuickLootKey = 1069,						UnstackOneKey = 1070,						UnstackHalfKey = 1071,							ContainerBlockbarKey = 1072,

						HotbarsNoCustom = 2017,
						HotbarMoveItemKey = 1073,					HotbarMoveKey = 1074,						HotbarMoveGroupKey = 1075,						HotbarShrinkGroupKey = 1076,			

						OthersNoCustomSubSection = 2018,

						-- SOUND
						EnableSound = 1077823,						SoundVol = 1094691,							EnableEffects = 1078575,						EffectsVolume = 1078576,				EnableMusic = 1078577,				
						MusicVolume = 1078578,						PlayFootsteps = 1078077,

						ECPlaySound = 2006,							
						ECPlaySound_Effects = 1028,					ECPlaySound_Music = 1029,					ECPlaySound_HeartBeat = 1030,					ECPlaySound_HeartBeat_Volume = 1031,

						-- OPTIONS
						System = 1078905,
						Language = 1077824,							EnglishNames = 1115913,						DiskCache = 1079480,

						Interface = 3000395,
						CustomUI = 1079523,							UiScale = 1079205,							ObjectHandleQuantity = 1094696,					ToggleWindowSnap = 1155296,				TipoftheDay = 1094689,				
						
						GameOptions = 1094695,
						EnablePathfinding = 1115324,				EnableAutorun = 1115321,					AlwaysRun = 1078078,							HoldShiftToUnstack = 1112076,			ShiftRightClickContextMenus = 1115355,
						ToggleBloodOath = 1053,						AutoIgnoreCorpses = 1156263,				ScavengeAll = 1011,								ToggleWarShield = 1155367,				AllowTrades = 1154112,
						AcceptFriendRequest = 1158415,				AutoTargetBagOfSending = 1111,

						CenterScreenText = 1155428,
						LowHPLabel = 1155306,						LowHPPetLabel = 1155307,					IgnoreSummons = 1155311,						VvVAlert = 1054,

						TargetingSettings = 1079383,
						IgnoreMouseActionsOnSelf = 1115918,			SwitchCurrentTargetOnMouseOver = 1064,		AlwaysAttack = 1078858,							TargetQueueing = 1115337,				BlockWarOnPets = 1155300,				
						BlockWarOnParty = 1155302, 					BlockWarOnGuild = 1155304,

						GumpsSettings = 2014,
						NewAnimalLore = 1006,						MoongateGump = 1007,						AutoCloseVetRew = 1047,							AutoAcceptHonor = 1060,					DisableFelWarning = 1062,			
						PartyInvitePopUp = 1115367,					QueryBeforeCriminalActions = 1078080,

						AnimalLore = 1002007,
						AnimalLoreBADPerc = 1103,					AnimalLoreVERYBADPerc = 1104,				AnimalLoreKhyrosRating = 1107,

						TreasureMaps = 2027,
						TmapPinPointLines = 1109,					TmapDigPlayerLocation = 1110,

						Tools = 1011170,
						CircleOfTransparency = 1078079,				ToggleClock = 1005,							CastBar = 1010,									SmartBoatCommands = 1057,				ToggleBookLog = 1046,

						Atlas = 1155405,
						ToggleCartographer = 1000,
						
						Paperdoll = 3001020, 
						BlockOthersPaperdoll = 1155298,				TogglePaperdollIcons = 1001,				TogglePaperdollFullSlotDurability = 1002,		EnablePaperdollBG = 1050,				UseLegacyPaperdolls = 1150185,

						MiniTexturePack = 2000,
						MiniTexturePackLabel = 1003,				MiniTexturePackBorderLabel = 1004,

						HotbarSettings = 1079167,
						Tooltips = 1115211,							DisableCastButtons = 1027,

						HotbarsColorsHotkeys = 2002,
						colorHBPlain = 1012,						colorHBControl = 1013,						colorHBAlt = 1014,								colorHBShift = 1015,					colorHBCtrlalt = 1016,
						colorHBCtrlShift = 1018,					colorHBCtrlAltShift = 1019,					colorHBAltShift = 1017,
						
						HotbarsElementsColors = 2019,
						colorHBCountdown = 1020,					colorHBBorder = 1025,						colorHBCurrent = 1021,							colorHBSelf = 1022,						colorHBCursor = 1023,
						colorHBStored = 1024,						colorHBMouseOver = 1065,  

						-- CONTAINERS
						BackpackStyle = 1157257,					DefaultContainerView = 1079827,				DefaultCorpseView = 1079828,					DefaultVendorView = 1026,				ToggleContentsInfo = 1155284,
						ToggleGridLegacy = 1155280,					ToggleScrollPos = 1063,						ShowContainerType = 1049,						ToggleGrid = 1155282,					ToggleExtraBright = 1155288,
						ToggleAlternateGrid = 1155286,				ContainerGridColor = 1155290,				ContainerGridAlternateColor = 1155292,			CascadeSetting = 2010,					CascadeSettingRANDOM = 2011,
						AutoLootMaxWeight = 1105,

						LootSortOrder = 2003,

						FindersKeepers = 2004,

						-- HEALTHBARS
						Healthbars = 1155313,
						ShowStrLabel = 1079171,						StatusWindowStyleLabel = 1155314,			HealthbarsButtons = 446,				ToggleNotorietyAura = 1155319,				ToggleMobileArrow = 1155321,				
						EnableContextButtons = 1058,				HoverbarsActive = 1099,						BossbarsActive = 1101,					HealthbarsFilters = 2022,					HealthbarsSmallButtons = 2024,
						AutoPinHonored = 1106,

						Buttons = 1155323,
						LegacyCloseStyle = 445,						PetLegacyCloseStyle = 1155326,				ShowCloseExtract = 1155328,				HealthBarWod = 1155330,						DisableButtons = 1102,

						SpellButtons = 1155332,

						MosOptions = 2020,							
						MosUpdate = 1154815,						MoSwindowOffset = 1154816,					MoS_UnsortedLimit = 1154807,			MoS_YellowLimit = 1154808,					MoS_GreyLimit = 1154809,
						MoS_BlueLimit = 1154810,					MoS_RedLimit = 1154811,						MoS_GreenLimit = 1154812,				MoS_OrangeLimit = 1154813,

						-- ITEM PROPERTIES
						PropertiesSettings = 2007,
						NewItemProperties = 1009,					NewItemPropertiesScale = 1048,				ShowPropCaps = 1052,					IntensInfo = 1055,							IntensInfoColorLabel = 1056, 

						ImbuingSettings = 2008,
						NormalForge = 1032,							TerMurForge = 1033,							QueenForge = 1034,						HumanElf = 1035,							Gargoyle = 1036,

						PropertiesColors = 2009,
						colorDefault = 1037,						colorMods = 1038,							colorEngrave = 1039,					colorArti = 1040,							colorSet = 1041, 
						colorResidue = 1042,						colorEssence = 1043,						colorRelic = 1044,						colorLostItem = 1045,

						-- OVERHEAD TEXT
						OverheadText = 1155333,
						ShowNames = 1078093,						ShowCorpseNames = 1115927,					ClickableNames = 1155340,				OverheadChat = 1078083,						OverheadChatFadeDelay = 1078084,
						DisableSpells = 1155334,					ShowSpellName = 1155336,					noPoisonOthers = 1155338,

						DefaulTextSizePlus = 1155341,				DefaulTextSizeMinus = 1155342,				OverheadChatFont = 1155343,				OverheadNamesFont = 1155344,				OverheadSpellFont = 1155345, 
						OverheadDamageFont = 1155346, 

						Colors = 1155351,
						DefaulHealTextColor = 1155352,				DefaulCurseTextColor = 1155353,				DefaulParaTextColor = 1155354,			DefaulNeutralTextColor = 1155355,			DefaulNegTextColor = 1155356, 
						DefaulPosTextColor = 1155357,				DefaulYouTextColor = 1155358,				DefaulPetTextColor = 1155359,			DefaulEnemyTextColor = 1155360,				DefaultPhysicalTextColor = 1155361, 
						DefaultFireTextColor = 1155362,				DefaultColdTextColor = 1155363,				DefaultPoisonTextColor = 1155364,		DefaultEnergyTextColor = 1155365,			DefaulChaosTextColor = 1155366,

						-- CHAT
						Chat = 3000131, 
						LegacyChat = 1079172,						BaseAlpha = 1155187,						AutoHide = 1155188,						FadeDelay = 1155189,					ShowMouseOver = 1155190,					
						FadeText = 1155191,							TimeStamp = 1155192,						LockWindow = 1155193,					LockLine = 1155275,						LockLineDown = 277,							
						MinTotDamage = 1155194,					    EnableChatLog = 1149998,					MsgBuffer = 1097,						ContactStatus = 1100,
						
						YouSee = 1155195,

						MsgFilters = 1155196,
						ShowSpells = 1155197,						SpellsCasting = 1155198,					PerfectionMsgs = 1155199,				PreventsMultiple = 1155200,					HideTags = 1155201,

						-- FILTERS
						FilterObscenity = 3000460,					IgnorePlayers = 3000462,					IgnoreConfPlayers = 1151906,			IgnoreListAddButton = 1155473,				IgnoreListChatListButton = 1155474,
						IgnoreListDeleteButton = 1155475,
						IgnoreList = 2021,		     
	
						}
					 
SettingsWindow.DetailTID = 
{	 
						-- GRAPHICS
						UseFull = 1115267,							FullRes = 1115269,							MaxFramerate = 1115270,						WindowedFullscreen = 1561,				ShowFrame = 1115271,			
						Gamma = 1115272,

						ShowFoliage = 1115275,						ShowShadows = 1115276,						EnableVsync = 1115277,						HardwareDeathEffect = 1115994,			ParticleLOD = 1115279,			
						ParticleFilter = 1115280,					PlayIdleAnimation = 1115281,				Animation = 1115282,						PlayFlyingAnimation = 1158627,			DisplayAllHouseContents = 1159138,
							   
						-- INPUT
						ScrollWheelUp = 1115283,					ScrollWheelDown = 1115284,

						ObjectHandlesKey = 1566,					ScaleKey = 1567,							AlphaKey = 1568,

						QuickLootKey = 1569,						UnstackOneKey = 1570,						UnstackHalfKey = 1571,						ContainerBlockbarKey = 1572,

						HotbarMoveItemKey = 1573,					HotbarMoveKey = 1574,						HotbarMoveGroupKey = 1575,					HotbarShrinkGroupKey = 1576,

						-- SOUND
						EnableSound = 1115287,						SoundVol = 1115288,							EnableEffects = 1115289,					EffectsVolume = 1115290,				EnableMusic = 1115291,			
						MusicVolume = 1115292,						PlayFootsteps = 1115293,

						ECPlaySound_Effects = 1528,					ECPlaySound_Music = 1529,					ECPlaySound_HeartBeat = 1530,				ECPlaySound_HeartBeat_Volume = 1531,

						-- OPTIONS
						Language = 1115294,							EnglishNames = 1115914,						DiskCache = 1115295,

						CustomUI = 1115300,							UiScale = 1115301,							ObjectHandleQuantity = 1115308,				ToggleWindowSnap = 1155297,				TipoftheDay = 1115306,			

						EnablePathfinding = 1115325,				EnableAutorun = 1115322,					AlwaysRun = 1115296,						HoldShiftToUnstack = 1115299,			ShiftRightClickContextMenus = 1115356,
						ToggleBloodOath = 1553,						AutoIgnoreCorpses = 1156263,				ScavengeAll = 1511,							ToggleWarShield = 1155368,				AutoTargetBagOfSending = 1611,

						LowHPLabel = 1155309,						LowHPPetLabel = 1155310,					IgnoreSummons = 1155312,					VvVAlert = 1554,

						IgnoreMouseActionsOnSelf = 1115919,			SwitchCurrentTargetOnMouseOver = 1564,		AlwaysAttack = 1115297,						TargetQueueing = 1115338,				BlockWarOnPets = 1155301,		
						BlockWarOnParty = 1155303, 					BlockWarOnGuild = 1155305,

						NewAnimalLore = 1506,						MoongateGump = 1507,						AutoCloseVetRew = 1547,						AutoAcceptHonor = 1560,					DisableFelWarning = 1562,		
						PartyInvitePopUp = 1115368,					QueryBeforeCriminalActions = 1115298,

						AnimalLoreBADPerc = 1603,					AnimalLoreVERYBADPerc = 1604,				AnimalLoreKhyrosRating = 1608,

						TmapPinPointLines = 1609,					TmapDigPlayerLocation = 1610,

						CircleOfTransparency = 1115278,				ToggleClock = 1505,							CastBar = 1510,								SmartBoatCommands = 1557,				ToggleBookLog = 1546,

						ToggleCartographer = 1500,

						BlockOthersPaperdoll = 1155299,				TogglePaperdollIcons = 1501,				TogglePaperdollFullSlotDurability = 1502,	EnablePaperdollBG = 1550,				UseLegacyPaperdolls = 1150186,

						MiniTexturePackLabel = 1503,				MiniTexturePackBorderLabel = 1504,

						Tooltips = 1115305,							DisableCastButtons = 1527, 

						colorHBPlain = 1512,						colorHBControl = 1513,						colorHBAlt = 1514,							colorHBShift = 1515,					colorHBCtrlalt = 1516,
						colorHBCtrlShift = 1518,					colorHBCtrlAltShift = 1519,					colorHBAltShift = 1517,

						colorHBCountdown = 1520,					colorHBBorder = 1525,						colorHBCurrent = 1521,						colorHBSelf = 1522,						colorHBCursor = 1523, 
						colorHBStored = 1524,						colorHBMouseOver = 1565,  

						-- CONTAINERS
						BackpackStyle = 1157266,					DefaultContainerView = 1115302,				DefaultCorpseView = 1115303,				DefaultVendorView = 1526,				ToggleContentsInfo = 1155285,
						ToggleGridLegacy = 1155281,					ToggleScrollPos = 1563,						ShowContainerType = 1549,					ToggleGrid = 1155283,					ToggleExtraBright = 1155289,
						ToggleAlternateGrid = 1155287,				ContainerGridColor = 1155291,				ContainerGridAlternateColor = 1155293,		AutoLootMaxWeight = 1606,

						-- HEALTHBARS
						ShowStrLabel = 1115304,						HealthbarsButtons = 447,					ToggleNotorietyAura = 1155320,				ToggleMobileArrow = 1155322,			EnableContextButtons = 1558,
						HoverbarsActive = 1599,						BossbarsActive = 1601,						HealthbarsSmallButtons = 1605,				AutoPinHonored = 1607,

						LegacyCloseStyle = 1155325,					PetLegacyCloseStyle = 1155327,				ShowCloseExtract = 1155329,					HealthBarWod = 1155331,					DisableButtons = 1602,
							
						NotorietyFilter = 1577,

						MosUpdate = 1578,							MoSwindowOffset = 1579,						BarsLimit = 1598,

						-- ITEM PROPERTIES
						NewItemProperties = 1509,					NewItemPropertiesScale = 1548,				ShowPropCaps = 1552,						IntensInfo = 1555,							IntensInfoColorLabel = 1556, 

						NormalForge = 1532,							TerMurForge = 1533,							QueenForge = 1534,							HumanElf = 1535,							Gargoyle = 1536,
						
						colorDefault = 1537,						colorMods = 1538,							colorEngrave = 1539,						colorArti = 1540,							colorSet = 1541, 
						colorResidue = 1542,						colorEssence = 1543,						colorRelic = 1544,							colorLostItem = 1545,

						-- OVERHEAD TEXT
						ShowNames = 1115309,						ShowCorpseNames = 1115928,					ClickableNames = 1580,						OverheadChat = 1115310,						OverheadChatFadeDelay = 1115311,
						DisableSpells = 1155335,					ShowSpellName = 1155337,					noPoisonOthers = 1155339,

						-- CHAT
						LegacyChat = 1115312,						BaseAlpha = 1581,							AutoHide = 1582,							FadeDelay = 1583,							ShowMouseOver = 1584,						
						FadeText = 1585,							TimeStamp = 1586,							LockWindow = 1587,							LockLine = 1588,							LockLineDown = 1589,
						MinTotDamage = 1590,						EnableChatLog = 1149999,					MsgBuffer = 1597,							ContactStatus = 1600,
						
						YouSeeNotoriety = 1591,

						ShowSpells = 1592,							SpellsCasting = 1593,						PerfectionMsgs = 1594,						PreventsMultiple = 1595,					HideTags = 1596,

						-- FILTERS
						FilterObscenity = 1115315,					IgnorePlayers = 1115316,					IgnoreConfPlayers = 1151906,

						}

SettingsWindow.TID_BINDING_CONFLICT_TITLE = 1079169
SettingsWindow.TID_BINDING_CONFLICT_BODY = 1079170
SettingsWindow.TID_BINDING_CONFLICT_QUESTION = 1094839
SettingsWindow.TID_YES = 1049717
SettingsWindow.TID_NO = 1049718
SettingsWindow.TID_INFO = 1011233
SettingsWindow.TID_RESETLEGACYBINDINGS_CHAT = 1079400
SettingsWindow.TID_RESETDEFAULTBINDINGS = 1094698
SettingsWindow.TID_RESETCHATSETTINGS = 1094699

SettingsWindow.TID_FRAMERATE = { 1112341, 1112342, 1112343, 1112344, 1112345, 529, 530, 531, 532, 533, 534, 535, 536, 537, 538, 539, 540, 541, 542 }

SettingsWindow.TID_DETAILS = { 1079210, 1079211, 1079212 }
SettingsWindow.TID_FILTERS = { 1112331, 1112332, 1112333, 1112334, 1158020 }

SettingsWindow.TID_ANIMATION = {1079210, 1079211, 1079212}

SettingsWindow.RecordingKey = false

SettingsWindow.PreviousBadWordCount = 0
SettingsWindow.PreviousIgnoreListCount = 0
SettingsWindow.CurIgnoreListIdx = -1
SettingsWindow.PreviousIgnoreConfListCount = 0
SettingsWindow.CurIgnoreConfListIdx = -1

--SettingsWindow.ENABLE_CUSTOM_SKINS = false -- enable this element? search for this tag to find all uses of this element also!
--SettingsWindow.TID_CUSTOM_SKINS_TEXT = 1011012 -- "Cancel"( placeholder )-- Label on the right of the combo box
--SettingsWindow.CustomSkins = {} -- table containing data for the different skins, may need to be initalized before use
--SettingsWindow.CustomSkins[1] = {tid = 3006115, id = 1 } -- "Resign( placeholder )-- Fist listed element in combo box
--SettingsWindow.CustomSkins[2] = {tid = 1078056, id = 2 } -- "MORE"( placeholder )
--SettingsWindow.CustomSkins[3] = {tid = 1011011, id = 3 } -- "CONTINUE"( placeholder )-- Last listed element in combo box
	
-- list of settings that are saved in UserSettings.xml
SettingsWindow.GlobalSettings = {
	["UseFullscreen"] =  true,
	["FullScreenRes"] =  true,
	["EnableVSync"] =  true,
	["FramerateMax"] =  true,
	["ShowFrame"] =  true,
	["Gamma"] =  true,
	["ShowFoliage"] =  true,
	["ShowShadows"] =  true,
	["HardwareDeathEffect"] =  true,
	["ParticleLOD"] =  true,
	["ParticleFilter"] =  true,
	["PlayIdleAnimation"] =  true,
	["PlayFlyingAnimation"] =  true,
	["DisplayAllHouseContents"] = true,
	["Animation"] =  true,
	["CacheSize"] =  true,
	["CustomSkins"] =  true,
	["MasterVolume"] =  true,
	["EffectsVolume"] =  true,
	["MusicVolume"] =  true,
	["PlayFootsteps"] =  true,
	["Language"] =  true,
	["EnglishNames"] =  true,
	["BadWordFilterOption"] =  true,
	["IgnoreListOption"] =  true,
}

SettingsWindow.VariableType = {}
SettingsWindow.VariableType.DEFAULT = 1
SettingsWindow.VariableType.UI = 2
SettingsWindow.VariableType.FULLSCREENRES = 3
SettingsWindow.VariableType.MAXFRAMERATE = 4
SettingsWindow.VariableType.WINDOWEDFULLSCREEN = 5 -- to be saved for last because requires the game to be restarted
SettingsWindow.VariableType.VALUEPLUSONE = 6 -- +1 on loading and -1 on saving
SettingsWindow.VariableType.SCROLLWHEELUP = 7
SettingsWindow.VariableType.SCROLLWHEELDOWN = 8
SettingsWindow.VariableType.KEYBINDING = 9 -- we need to get the variable from the array first
SettingsWindow.VariableType.KEYBINDINGMOUNTDISMOUNT = 10
SettingsWindow.VariableType.VOLUME = 11 -- we need to read enabled and volume from the same variable
SettingsWindow.VariableType.LANGUAGE = 12
SettingsWindow.VariableType.CACHE = 13 -- cache need to be multiply by 1024 for load and divide 1024 when save
SettingsWindow.VariableType.CUSTOMUI = 14
SettingsWindow.VariableType.UISCALE = 15
SettingsWindow.VariableType.OBJECTHANDLESIZE = 16
SettingsWindow.VariableType.LOWHP = 17
SettingsWindow.VariableType.LOWHPPET = 18
SettingsWindow.VariableType.HOTBARCOLOR = 19
SettingsWindow.VariableType.BACKPACKSTYLE = 20
SettingsWindow.VariableType.CONTAINERVIEW = 21
SettingsWindow.VariableType.CORPSEVIEW = 22
SettingsWindow.VariableType.VENDORVIEW = 23
SettingsWindow.VariableType.CONTAINERCOLOR = 24
SettingsWindow.VariableType.STATUSSTYLE = 25
SettingsWindow.VariableType.HEALTHBARBUTTON = 26
SettingsWindow.VariableType.MOSOFFSET = 27
SettingsWindow.VariableType.PROPERTIESCOLOR = 28
SettingsWindow.VariableType.SHOWNAMES = 29
SettingsWindow.VariableType.OVERHEADCOLOR = 30
SettingsWindow.VariableType.CHATFADETIME = 31
SettingsWindow.VariableType.CHATMINDAMAGE = 32
SettingsWindow.VariableType.CHATMSGBUFFER = 33
SettingsWindow.VariableType.MOSUPDATETIME = 34
SettingsWindow.VariableType.ANIMALLORERANGE = 35
SettingsWindow.VariableType.AUTOLOOTMAXWEIGHT = 36

function SettingsWindow.InitializeArrays()

	SettingsWindow.StatusWindowStyles = { 1155315, 1155316, 2001, 2013, 2023 }

	SettingsWindow.Tabs = {
	--	{ name = "objectName",		textFill = "text/tid" }
		{ name = "Graphics",		textFill = GetStringFromTid(SettingsWindow.TID.Graphics) },
		{ name = "Sound",			textFill = GetStringFromTid(SettingsWindow.TID.Sound) },
		{ name = "Input",			textFill = GetStringFromTid(SettingsWindow.TID.Input) },
		{ name = "Options",			textFill = GetStringFromTid(SettingsWindow.TID.Options) },
		{ name = "Containers",		textFill = GetStringFromTid(SettingsWindow.TID.ContainersTab) },
		{ name = "Healthbars",		textFill = GetStringFromTid(SettingsWindow.TID.HealthbarsTab) },
		{ name = "ItemProperties",	textFill = GetStringFromTid(SettingsWindow.TID.ItemPropertiesTab) },
		{ name = "OverheadText",	textFill = GetStringFromTid(SettingsWindow.TID.OverheadTextTab) },
		{ name = "Chat",			textFill = GetStringFromTid(SettingsWindow.TID.ChatTab) },
		{ name = "Profanity",		textFill = GetStringFromTid(SettingsWindow.TID.Filter) },
	}

	SettingsWindow.Settings = {
		-- true obj name	tab ID		labe/checkbox...		anchor function				saving/loading function		variable to save/loading			object text			tooltip text	  text color	function to fill the combo		elements to hide if this is enabled		elements to hide if this is disabled
	-- {name="objectName", tabId=x, objectType="objectType", anchorFunc=WindowAddAnchor(), settingType="default/UI", settingVariableName="variableName", textFill="text/tid", tooltip="text/tid", color = rgb, comboFill= function,				hideElementsTrue=table,					hideElementsFalse=table}

		-- GRAPHICS
		{ name = "DisplaySubSection",						tabId = 1,		objectType = "SubSectionLabelTemplate",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"topleft",		parent,		"topleft",		20,		30)	end,		textFill = GetStringFromTid( SettingsWindow.TID.Display ) },
		{ name = "UseFullscreen",							tabId = 1,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		settingType = SettingsWindow.VariableType.DEFAULT,				settingVariableName = "SystemData.Settings.Resolution.useFullScreen",					textFill = GetStringFromTid( SettingsWindow.TID.UseFull ),					tooltip = SettingsWindow.DetailTID.UseFull },
		{ name = "FullScreenRes",							tabId = 1,		objectType = "Settings_LabelCombo",				anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.FULLSCREENRES,		settingVariableName = "SettingsWindow.CurrentResolution",								textFill = GetStringFromTid( SettingsWindow.TID.FullRes ),					tooltip = SettingsWindow.DetailTID.FullRes,						comboFill = function(combo) for res = 1, #SystemData.AvailableResolutions.widths do ComboBoxAddMenuItem( combo, SystemData.AvailableResolutions.widths[res] .. L" x " .. SystemData.AvailableResolutions.heights[res] ) end end },
		{ name = "FramerateMax",							tabId = 1,		objectType = "Settings_LabelCombo",				anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.MAXFRAMERATE,			settingVariableName = "SettingsWindow.CurrentMaxFramerate",								textFill = GetStringFromTid( SettingsWindow.TID.MaxFramerate ),				tooltip = SettingsWindow.DetailTID.MaxFramerate,				comboFill = function(combo) for i, fps in pairsByIndex(SettingsWindow.TID_FRAMERATE) do ComboBoxAddMenuItem( combo, GetStringFromTid(fps) ) end end },
		{ name = "WindowedFullscreen",						tabId = 1,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.WINDOWEDFULLSCREEN,	settingVariableName = "SettingsWindow.WindowedFullscreen",								textFill = GetStringFromTid( SettingsWindow.TID.WindowedFullscreen ),		tooltip = SettingsWindow.DetailTID.WindowedFullscreen,			hideElementsTrue = {"ShowFrame"} },
		{ name = "EnableVSync",								tabId = 1,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.DEFAULT,				settingVariableName = "SystemData.Settings.Resolution.enableVSync",						textFill = GetStringFromTid( SettingsWindow.TID.EnableVsync ),				tooltip = SettingsWindow.DetailTID.EnableVsync },
		{ name = "ShowFrame",								tabId = 1,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.DEFAULT,				settingVariableName = "SystemData.Settings.Resolution.showWindowFrame",					textFill = GetStringFromTid( SettingsWindow.TID.ShowFrame ),				tooltip = SettingsWindow.DetailTID.ShowFrame },
		{ name = "Gamma",									tabId = 1,		objectType = "SliderItemTemplate",				anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		settingType = SettingsWindow.VariableType.DEFAULT,				settingVariableName = "SystemData.Settings.Resolution.gamma",							textFill = GetStringFromTid( SettingsWindow.TID.Gamma ),					tooltip = SettingsWindow.DetailTID.Gamma },
		{ name = "EnvironmentSubSection",					tabId = 1,		objectType = "SubSectionLabelTemplate",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		40)	end,		textFill = GetStringFromTid( SettingsWindow.TID.Environment ) },
		{ name = "ShowFoliage",								tabId = 1,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		settingType = SettingsWindow.VariableType.DEFAULT,				settingVariableName = "SystemData.Settings.Resolution.displayFoliage",					textFill = GetStringFromTid( SettingsWindow.TID.ShowFoliage ),				tooltip = SettingsWindow.DetailTID.ShowFoliage },
		{ name = "ShowShadows",								tabId = 1,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.DEFAULT,				settingVariableName = "SystemData.Settings.Resolution.showShadows",						textFill = GetStringFromTid( SettingsWindow.TID.ShowShadows ),				tooltip = SettingsWindow.DetailTID.ShowShadows },
		{ name = "HardwareDeathEffect",						tabId = 1,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.DEFAULT,				settingVariableName = "SystemData.Settings.GameOptions.useHardwareDeathEffect",			textFill = GetStringFromTid( SettingsWindow.TID.HardwareDeathEffect ),		tooltip = SettingsWindow.DetailTID.HardwareDeathEffect },
		{ name = "ParticleLOD",								tabId = 1,		objectType = "Settings_LabelCombo",				anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.DEFAULT,				settingVariableName = "SystemData.Settings.Resolution.particleLOD",						textFill = GetStringFromTid( SettingsWindow.TID.ParticleLOD ),				tooltip = SettingsWindow.DetailTID.ParticleLOD,					comboFill = function(combo) for i, details in pairsByIndex(SettingsWindow.TID_DETAILS) do ComboBoxAddMenuItem( combo, GetStringFromTid(details) ) end end },
		{ name = "ParticleFilter",							tabId = 1,		objectType = "Settings_LabelCombo",				anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.VALUEPLUSONE,			settingVariableName = "SystemData.Settings.Resolution.particleFilter",					textFill = GetStringFromTid( SettingsWindow.TID.ParticleFilter ),			tooltip = SettingsWindow.DetailTID.ParticleFilter,				comboFill = function(combo) for i, filters in pairsByIndex(SettingsWindow.TID_FILTERS) do ComboBoxAddMenuItem( combo, GetStringFromTid(filters) ) end end },
		{ name = "PlayIdleAnimation",						tabId = 1,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.DEFAULT,				settingVariableName = "SystemData.Settings.Optimization.idleAnimation",					textFill = GetStringFromTid( SettingsWindow.TID.PlayIdleAnimation ),		tooltip = SettingsWindow.DetailTID.PlayIdleAnimation,			updateFunc = function() SettingsWindow.BeginGameRestart() end },
		{ name = "PlayFlyingAnimation",						tabId = 1,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.DEFAULT,				settingVariableName = "SystemData.Settings.Optimization.bEnableFlyingAnimation",		textFill = GetStringFromTid( SettingsWindow.TID.PlayFlyingAnimation ),		tooltip = SettingsWindow.DetailTID.PlayFlyingAnimation,			updateFunc = function() SettingsWindow.BeginGameRestart() end },
		{ name = "DisplayAllHouseContents",					tabId = 1,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.DEFAULT,				settingVariableName = "SystemData.Settings.Optimization.bDisplayAllHouseContents",		textFill = GetStringFromTid( SettingsWindow.TID.DisplayAllHouseContents ),	tooltip = SettingsWindow.DetailTID.DisplayAllHouseContents, },
		{ name = "Animation",								tabId = 1,		objectType = "Settings_LabelCombo",				anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.VALUEPLUSONE,			settingVariableName = "SystemData.Settings.Optimization.frameSetRestriction",			textFill = GetStringFromTid( SettingsWindow.TID.Animation ),				tooltip = SettingsWindow.DetailTID.Animation,					comboFill = function(combo) for i, anim in pairsByIndex(SettingsWindow.TID_ANIMATION) do ComboBoxAddMenuItem( combo, GetStringFromTid(anim) ) end end },
	
		-- SOUND
		{ name = "SoundSubSection",							tabId = 2,		objectType = "SubSectionLabelTemplate",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"topleft",		parent,		"topleft",		20,		30)	end,		textFill = GetStringFromTid( SettingsWindow.TID.Sound ) },
		{ name = "MasterVolume",							tabId = 2,		objectType = "VolumeSliderItemTemplate",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		settingType = SettingsWindow.VariableType.VOLUME,				settingVariableName = "SystemData.Settings.Sound.master",								textFill = {GetStringFromTid( SettingsWindow.TID.EnableSound ), GetStringFromTid( SettingsWindow.TID.SoundVol )},										tooltip = {SettingsWindow.DetailTID.EnableSound, SettingsWindow.DetailTID.SoundVol} },
		{ name = "EffectsVolume",							tabId = 2,		objectType = "VolumeSliderItemTemplate",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		settingType = SettingsWindow.VariableType.VOLUME,				settingVariableName = "SystemData.Settings.Sound.effects",								textFill = {GetStringFromTid( SettingsWindow.TID.EnableEffects ), GetStringFromTid( SettingsWindow.TID.EffectsVolume )},								tooltip = {SettingsWindow.DetailTID.EnableEffects, SettingsWindow.DetailTID.EffectsVolume} },
		{ name = "MusicVolume",								tabId = 2,		objectType = "VolumeSliderItemTemplate",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		settingType = SettingsWindow.VariableType.VOLUME,				settingVariableName = "SystemData.Settings.Sound.music",								textFill = {GetStringFromTid( SettingsWindow.TID.EnableMusic ), GetStringFromTid( SettingsWindow.TID.MusicVolume )},									tooltip = {SettingsWindow.DetailTID.EnableMusic, SettingsWindow.DetailTID.MusicVolume} },
		{ name = "PlayFootsteps",							tabId = 2,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.DEFAULT,				settingVariableName = "SystemData.Settings.Sound.footsteps.enabled",					textFill = GetStringFromTid( SettingsWindow.TID.PlayFootsteps ),			tooltip = SettingsWindow.DetailTID.PlayFootsteps },
		{ name = "ECPlaySoundSubSection",					tabId = 2,		objectType = "SubSectionLabelTemplate",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		40)	end,		textFill = GetStringFromTid( SettingsWindow.TID.ECPlaySound ) },
		{ name = "ECPlaySound_Effects",						tabId = 2,		objectType = "VolumeSliderItemTemplate",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		settingType = SettingsWindow.VariableType.VOLUME,				settingVariableName = "Interface.ECSound",												textFill = {GetStringFromTid( SettingsWindow.TID.ECPlaySound_Effects ), GetStringFromTid( SettingsWindow.TID.EffectsVolume )},							updateFunc = function() SettingsWindow.UpdateECPlaySoundStatus() end,	tooltip = {SettingsWindow.DetailTID.ECPlaySound_Effects, SettingsWindow.DetailTID.EffectsVolume} },
		{ name = "ECPlaySound_Music",						tabId = 2,		objectType = "VolumeSliderItemTemplate",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		settingType = SettingsWindow.VariableType.VOLUME,				settingVariableName = "Interface.ECMusic",												textFill = {GetStringFromTid( SettingsWindow.TID.ECPlaySound_Music ), GetStringFromTid( SettingsWindow.TID.MusicVolume )},								updateFunc = function() SettingsWindow.UpdateECPlaySoundStatus() end,	tooltip = {SettingsWindow.DetailTID.ECPlaySound_Music, SettingsWindow.DetailTID.MusicVolume},			hideElementsTrue = {"MusicVolume", "MusicVolumeToggle"} },
		{ name = "ECPlaySound_HeartBeat",					tabId = 2,		objectType = "VolumeSliderItemTemplate",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		settingType = SettingsWindow.VariableType.VOLUME,				settingVariableName = "Interface.HeartBeat",											textFill = {GetStringFromTid( SettingsWindow.TID.ECPlaySound_HeartBeat ), GetStringFromTid( SettingsWindow.TID.ECPlaySound_HeartBeat_Volume )},			updateFunc = function() SettingsWindow.UpdateECPlaySoundStatus() end,	tooltip = {SettingsWindow.DetailTID.ECPlaySound_HeartBeat, SettingsWindow.DetailTID.ECPlaySound_HeartBeat_Volume} },

		-- INPUT
		{ name = "MouseSubSection",							tabId = 3,		objectType = "SubSectionLabelTemplate",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"topleft",		parent,		"topleft",		20,		30)	end,		textFill = GetStringFromTid( SettingsWindow.TID.Mouse ) },
		{ name = "ScrollWheelUp",							tabId = 3,		objectType = "Settings_LabelComboLong",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		settingType = SettingsWindow.VariableType.SCROLLWHEELUP,		settingVariableName = "SystemData.Settings.GameOptions.mouseScrollUpAction",			textFill = GetStringFromTid( SettingsWindow.TID.ScrollWheelUp ),			tooltip = SettingsWindow.DetailTID.ScrollWheelUp,				comboFill = function(combo) for i, behav in pairsByIndex(SettingsWindow.ScrollWheelBehaviors) do ComboBoxAddMenuItem( combo, GetStringFromTid(behav.tid) ) end end },
		{ name = "ScrollWheelDown",							tabId = 3,		objectType = "Settings_LabelComboLong",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.SCROLLWHEELDOWN,		settingVariableName = "SystemData.Settings.GameOptions.mouseScrollDownAction",			textFill = GetStringFromTid( SettingsWindow.TID.ScrollWheelDown ),			tooltip = SettingsWindow.DetailTID.ScrollWheelDown,				comboFill = function(combo) for i, behav in pairsByIndex(SettingsWindow.ScrollWheelBehaviors) do ComboBoxAddMenuItem( combo, GetStringFromTid(behav.tid) ) end end },
		{ name = "KeyboardSubSection",						tabId = 3,		objectType = "SubSectionLabelTemplate",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		40)	end,		textFill = GetStringFromTid( SettingsWindow.TID.KeyBindings ) },
		{ name = "MoveUp",									tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "MoveDown",								tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "MoveLeft",								tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "MoveRight",								tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "TurnUp",									tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		30) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "TurnDown",								tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "TurnLeft",								tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "TurnRight",								tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "MountDismount",							tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		30) end,		settingType = SettingsWindow.VariableType.KEYBINDINGMOUNTDISMOUNT },
		{ name = "AttackMode",								tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		30) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "PrimaryAttack",							tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "SecondaryAttack",							tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "NextGroupTarget",							tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		30) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "PreviousGroupTarget",						tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "NearestGroup",							tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "TargetSelf",								tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "TargetG1",								tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "TargetG2",								tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "TargetG3",								tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "TargetG4",								tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "TargetG5",								tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "TargetG6",								tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "TargetG7",								tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "TargetG8",								tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "TargetG9",								tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "NextTarget",								tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		30) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "PreviousTarget",							tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "NearestTarget",							tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "NextEnemy",								tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		30) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "PreviousEnemy",							tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "NearestEnemy",							tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "NextFriend",								tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		30) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "PreviousFriend",							tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "NearestFriend",							tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "NextFollower",							tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		30) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "PreviousFollower",						tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "NearestFollower",							tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "NextObject",								tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		30) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "PreviousObject",							tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "NearestObject",							tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "CursorTargetCurrent",						tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		30) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "CursorTargetLast",						tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "CursorTargetSelf",						tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "CycleLastCursorTarget",					tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "ClearTargetQueue",						tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "CharacterWin",							tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		30) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "BackpackWin",								tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "SkillsWin",								tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "ToggleMap",								tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "QuestLogWin",								tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "ToggleAlwaysRun",							tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		30) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "ToggleCoT",								tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "ZoomIn",									tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		30) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "ZoomOut",									tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "ZoomReset",								tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "Screenshot",								tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		30) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "ToggleInterface",							tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "ReloadInterface",							tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "CycleChatForward",						tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		30) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "CycleChatBackward",						tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "QuitGame",								tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		30) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "LogOut",									tabId = 3,		objectType = "KeyPicker",						anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.KEYBINDING },
		{ name = "GlobalNoCustomSubSection",				tabId = 3,		objectType = "SubSectionLabelTemplate",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		40)	end,		textFill = GetStringFromTid( SettingsWindow.TID.GlobalNoCustom ) },
		{ name = "MainMenuKey",								tabId = 3,		objectType = "KeyPickerNoCustom",				anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		textFill = GetStringFromTid( SettingsWindow.TID.MainMenuKey ),										tooltip = SystemData.Settings.Keybindings.CANCEL },
		{ name = "ObjectHandlesKey",						tabId = 3,		objectType = "KeyPickerNoCustom",				anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		textFill = GetStringFromTid( SettingsWindow.TID.ObjectHandlesKey ),									tooltip = GetStringFromTid(SettingsWindow.DetailTID.ObjectHandlesKey) },
		{ name = "ScaleKey",								tabId = 3,		objectType = "KeyPickerNoCustom",				anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		textFill = GetStringFromTid( SettingsWindow.TID.ScaleKey ),											tooltip = GetStringFromTid(SettingsWindow.DetailTID.ScaleKey) },
		{ name = "AlphaKey",								tabId = 3,		objectType = "KeyPickerNoCustom",				anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		textFill = GetStringFromTid( SettingsWindow.TID.AlphaKey ),											tooltip = GetStringFromTid(SettingsWindow.DetailTID.AlphaKey) },
		{ name = "ContainerNoCustomSubSection",				tabId = 3,		objectType = "SubSectionLabelTemplate",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		40)	end,		textFill = GetStringFromTid( SettingsWindow.TID.ContainerNoCustom ) },
		{ name = "QuickLootKey",							tabId = 3,		objectType = "KeyPickerNoCustom",				anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		textFill = GetStringFromTid( SettingsWindow.TID.QuickLootKey ),										tooltip = GetStringFromTid(SettingsWindow.DetailTID.QuickLootKey) },
		{ name = "UnstackOneKey",							tabId = 3,		objectType = "KeyPickerNoCustom",				anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		textFill = GetStringFromTid( SettingsWindow.TID.UnstackOneKey ),									tooltip = GetStringFromTid(SettingsWindow.DetailTID.UnstackOneKey) },
		{ name = "UnstackHalfKey",							tabId = 3,		objectType = "KeyPickerNoCustom",				anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		textFill = GetStringFromTid( SettingsWindow.TID.UnstackHalfKey ),									tooltip = GetStringFromTid(SettingsWindow.DetailTID.UnstackHalfKey) },
		{ name = "ContainerBlockbarKey",					tabId = 3,		objectType = "KeyPickerNoCustom",				anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		textFill = GetStringFromTid( SettingsWindow.TID.ContainerBlockbarKey ),								tooltip = GetStringFromTid(SettingsWindow.DetailTID.ContainerBlockbarKey) },
		{ name = "HotbarsNoCustomSubSection",				tabId = 3,		objectType = "SubSectionLabelTemplate",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		40)	end,		textFill = GetStringFromTid( SettingsWindow.TID.HotbarsNoCustom ) },
		{ name = "HotbarMoveItemKey",						tabId = 3,		objectType = "KeyPickerNoCustom",				anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		textFill = GetStringFromTid( SettingsWindow.TID.HotbarMoveItemKey ),								tooltip = GetStringFromTid(SettingsWindow.DetailTID.HotbarMoveItemKey) },
		{ name = "HotbarMoveKey",							tabId = 3,		objectType = "KeyPickerNoCustom",				anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		textFill = GetStringFromTid( SettingsWindow.TID.HotbarMoveKey ),									tooltip = GetStringFromTid(SettingsWindow.DetailTID.HotbarMoveKey) },
		{ name = "HotbarMoveGroupKey",						tabId = 3,		objectType = "KeyPickerNoCustom",				anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		textFill = GetStringFromTid( SettingsWindow.TID.HotbarMoveGroupKey ),								tooltip = GetStringFromTid(SettingsWindow.DetailTID.HotbarMoveGroupKey) },
		{ name = "HotbarShrinkGroupKey",					tabId = 3,		objectType = "KeyPickerNoCustom",				anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		textFill = GetStringFromTid( SettingsWindow.TID.HotbarShrinkGroupKey ),								tooltip = GetStringFromTid(SettingsWindow.DetailTID.HotbarShrinkGroupKey) },
		{ name = "OthersNoCustomSubSection",				tabId = 3,		objectType = "SubSectionLabelTemplate",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		40)	end,		textFill = GetStringFromTid( SettingsWindow.TID.OthersNoCustomSubSection ) },
		{ name = "OtherBlockbarKey",						tabId = 3,		objectType = "KeyPickerNoCustom",				anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		textFill = GetStringFromTid( SettingsWindow.TID.ContainerBlockbarKey ),								tooltip = GetStringFromTid(SettingsWindow.DetailTID.ContainerBlockbarKey) },

		-- OPTIONS
		{ name = "SystemSubSection",						tabId = 4,		objectType = "SubSectionLabelTemplate",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"topleft",		parent,		"topleft",		20,		30)	end,		textFill = GetStringFromTid( SettingsWindow.TID.System ) },
		{ name = "Language",								tabId = 4,		objectType = "Settings_LabelCombo",				anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		settingType = SettingsWindow.VariableType.LANGUAGE,			settingVariableName = "SystemData.Settings.Language.type",																textFill = GetStringFromTid( SettingsWindow.TID.Language ),									tooltip = SettingsWindow.DetailTID.Language,					comboFill = function(combo) for i, lang in pairsByIndex(SettingsWindow.Languages) do ComboBoxAddMenuItem( combo, GetStringFromTid(lang.tid) ) end end,			hideElementsTrue = {condition = SystemData.Settings.Language.LANGUAGE_ENU, elements={"EnglishNames"}}},
		{ name = "EnglishNames",							tabId = 4,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.DEFAULT,			settingVariableName = "SystemData.Settings.Language.englishNames",														textFill = GetStringFromTid( SettingsWindow.TID.EnglishNames ),								tooltip = SettingsWindow.DetailTID.EnglishNames },
		{ name = "CacheSize",								tabId = 4,		objectType = "SliderItemTemplate",				anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		25) end,		settingType = SettingsWindow.VariableType.CACHE,			settingVariableName = "SystemData.Settings.Optimization.cacheSize",														textFill = GetStringFromTid( SettingsWindow.TID.DiskCache ),								tooltip = SettingsWindow.DetailTID.DiskCache },
		{ name = "InterfaceSubSection",						tabId = 4,		objectType = "SubSectionLabelTemplate",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		40)	end,		textFill = GetStringFromTid( SettingsWindow.TID.Interface ) },
		{ name = "CustomSkins",								tabId = 4,		objectType = "Settings_LabelComboLong",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		settingType = SettingsWindow.VariableType.CUSTOMUI,			settingVariableName = "SystemData.Settings.Interface.customUiName",														textFill = GetStringFromTid( SettingsWindow.TID.CustomUI ),									tooltip = SettingsWindow.DetailTID.CustomUI,					comboFill = function(combo) for i, uis in pairsByIndex(SystemData.CustomUIList) do local text = uis if not IsValidString(text) then text = GetStringFromTid( 3000094 ) else text = towstring(text) end ComboBoxAddMenuItem( combo, text ) end end },
		{ name = "UiScale",									tabId = 4,		objectType = "SliderItemTemplate",				anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		settingType = SettingsWindow.VariableType.UISCALE,			settingVariableName = "SystemData.Settings.Interface.customUiScale",													textFill = GetStringFromTid( SettingsWindow.TID.UiScale ),									tooltip = SettingsWindow.DetailTID.UiScale },
		{ name = "ObjHandleSize",							tabId = 4,		objectType = "Settings_LabelCombo",				anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		settingType = SettingsWindow.VariableType.OBJECTHANDLESIZE,	settingVariableName = "SystemData.Settings.GameOptions.objectHandleSize",												textFill = GetStringFromTid( SettingsWindow.TID.ObjectHandleQuantity ),						tooltip = SettingsWindow.DetailTID.ObjectHandleQuantity,		comboFill = function(combo) for i, obj in pairsByIndex(SettingsWindow.ObjectHandleSizes) do local text = obj if text == -1 then text = GetStringFromTid( 1077866 ) else text = towstring(text) end ComboBoxAddMenuItem( combo, text ) end end },
		{ name = "ToggleWindowSnap",						tabId = 4,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.EnableSnapping",																textFill = GetStringFromTid( SettingsWindow.TID.ToggleWindowSnap ),							tooltip = SettingsWindow.DetailTID.ToggleWindowSnap },
		{ name = "TipoftheDay",								tabId = 4,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.DEFAULT,			settingVariableName = "SystemData.Settings.Interface.showTipoftheDay",													textFill = GetStringFromTid( SettingsWindow.TID.TipoftheDay ),								tooltip = SettingsWindow.DetailTID.TipoftheDay },
		{ name = "GameOptionsSubSection",					tabId = 4,		objectType = "SubSectionLabelTemplate",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		40)	end,		textFill = GetStringFromTid( SettingsWindow.TID.GameOptions ) },
		{ name = "EnablePathfinding",						tabId = 4,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		settingType = SettingsWindow.VariableType.DEFAULT,			settingVariableName = "SystemData.Settings.GameOptions.enablePathfinding",												textFill = GetStringFromTid( SettingsWindow.TID.EnablePathfinding ),						tooltip = SettingsWindow.DetailTID.EnablePathfinding },
		{ name = "EnableAutorun",							tabId = 4,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.DEFAULT,			settingVariableName = "SystemData.Settings.GameOptions.enableAutorun",													textFill = GetStringFromTid( SettingsWindow.TID.EnableAutorun ),							tooltip = SettingsWindow.DetailTID.EnableAutorun },
		{ name = "AlwaysRun",								tabId = 4,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.DEFAULT,			settingVariableName = "SystemData.Settings.GameOptions.alwaysRun",														textFill = GetStringFromTid( SettingsWindow.TID.AlwaysRun ),								tooltip = SettingsWindow.DetailTID.AlwaysRun },
		{ name = "HoldShiftToUnstack",						tabId = 4,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.DEFAULT,			settingVariableName = "SystemData.Settings.GameOptions.holdShiftToUnstack",												textFill = GetStringFromTid( SettingsWindow.TID.HoldShiftToUnstack ),						tooltip = SettingsWindow.DetailTID.HoldShiftToUnstack },
		{ name = "ShiftRightClickContextMenus",				tabId = 4,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.DEFAULT,			settingVariableName = "SystemData.Settings.GameOptions.shiftRightClickContextMenus",									textFill = GetStringFromTid( SettingsWindow.TID.ShiftRightClickContextMenus ),				tooltip = SettingsWindow.DetailTID.ShiftRightClickContextMenus },
		{ name = "ToggleBloodOath",							tabId = 4,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.ToggleBloodOath",																textFill = GetStringFromTid( SettingsWindow.TID.ToggleBloodOath ),							tooltip = SettingsWindow.DetailTID.ToggleBloodOath },
		{ name = "AutoIgnoreCorpses",						tabId = 4,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.EnableAutoIgnoreCorpses",														textFill = GetStringFromTid( SettingsWindow.TID.AutoIgnoreCorpses ),						tooltip = SettingsWindow.DetailTID.AutoIgnoreCorpses },
		{ name = "ScavengeAll",								tabId = 4,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.ScavengeAll",																	textFill = GetStringFromTid( SettingsWindow.TID.ScavengeAll ),								tooltip = SettingsWindow.DetailTID.ScavengeAll },
		{ name = "AutoTargetBagOfSending",					tabId = 4,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.AutoTargetBagOfSending",														textFill = GetStringFromTid( SettingsWindow.TID.AutoTargetBagOfSending ),					tooltip = SettingsWindow.DetailTID.AutoTargetBagOfSending },
		{ name = "ToggleWarShield",							tabId = 4,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.WarShield",																	textFill = GetStringFromTid( SettingsWindow.TID.ToggleWarShield ),							tooltip = SettingsWindow.DetailTID.ToggleWarShield,				updateFunc = function() WarShield.ToggleWarShield() end },
		{ name = "CenterScreenTextSubSection",				tabId = 4,		objectType = "SubSectionLabelTemplate",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		40)	end,		textFill = GetStringFromTid( SettingsWindow.TID.CenterScreenText ) },
		{ name = "LowHP",									tabId = 4,		objectType = "Settings_LabelCombo",				anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		settingType = SettingsWindow.VariableType.LOWHP,			settingVariableName = "Interface.Settings.CST_LowHPPerc",																textFill = GetStringFromTid( SettingsWindow.TID.LowHPLabel ),								tooltip = SettingsWindow.DetailTID.LowHPLabel,					comboFill = function(combo) for i, text in pairsByIndex(SettingsWindow.LowHPOptions) do ComboBoxAddMenuItem( combo, text ) end end },
		{ name = "LowHPPet",								tabId = 4,		objectType = "Settings_LabelCombo",				anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		settingType = SettingsWindow.VariableType.LOWHPPET,			settingVariableName = "Interface.Settings.CST_LowPETHPPerc",															textFill = GetStringFromTid( SettingsWindow.TID.LowHPPetLabel ),							tooltip = SettingsWindow.DetailTID.LowHPPetLabel,				comboFill = function(combo) for i, text in pairsByIndex(SettingsWindow.LowHPOptions) do ComboBoxAddMenuItem( combo, text ) end end },
		{ name = "IgnoreSummons",							tabId = 4,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.CST_EnableIgnoreSummons",														textFill = GetStringFromTid( SettingsWindow.TID.IgnoreSummons ),							tooltip = SettingsWindow.DetailTID.IgnoreSummons },
		{ name = "VvVAlert",								tabId = 4,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.CST_VvVAlert",																textFill = GetStringFromTid( SettingsWindow.TID.VvVAlert ),									tooltip = SettingsWindow.DetailTID.VvVAlert },
		{ name = "GumpsSubSection",							tabId = 4,		objectType = "SubSectionLabelTemplate",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		40)	end,		textFill = GetStringFromTid( SettingsWindow.TID.GumpsSettings ) },
		{ name = "AllowTrades",								tabId = 4,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.DEFAULT,			settingVariableName = "Interface.Settings.AllowTrades",																	textFill = GetStringFromTid( SettingsWindow.TID.AllowTrades ),								tooltip = SettingsWindow.DetailTID.AllowTrades,					updateFunc = function() Actions.ToggleTrades(true) SettingsWindow.ForceSelectTab(SettingsWindow.ActiveTab) end },
		{ name = "AcceptFriendRequest",						tabId = 4,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.DEFAULT,			settingVariableName = "Interface.Settings.AllowFriendRequests",															textFill = GetStringFromTid( SettingsWindow.TID.AcceptFriendRequest ),						tooltip = SettingsWindow.DetailTID.AcceptFriendRequest,			updateFunc = function() Actions.ToggleFriendRequests(true) SettingsWindow.ForceSelectTab(SettingsWindow.ActiveTab) end },
		{ name = "NewAnimalLore",							tabId = 4,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.NewAnimalLore",																textFill = GetStringFromTid( SettingsWindow.TID.NewAnimalLore ),							tooltip = SettingsWindow.DetailTID.NewAnimalLore,				hideElementsFalse = { "AnimalLoreBADPerc", "AnimalLoreVERYBADPerc" } },
		{ name = "MoongateGump",							tabId = 4,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.MoongateGump",																textFill = GetStringFromTid( SettingsWindow.TID.MoongateGump ),								tooltip = SettingsWindow.DetailTID.MoongateGump },
		{ name = "AutoCloseVetRew",							tabId = 4,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.AutoCloseVetRew",																textFill = GetStringFromTid( SettingsWindow.TID.AutoCloseVetRew ),							tooltip = SettingsWindow.DetailTID.AutoCloseVetRew },
		{ name = "AutoAcceptHonor",							tabId = 4,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.AutoAcceptHonor",																textFill = GetStringFromTid( SettingsWindow.TID.AutoAcceptHonor ),							tooltip = SettingsWindow.DetailTID.AutoAcceptHonor },
		{ name = "DisableFelWarning",						tabId = 4,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.DisableFelWarning",															textFill = GetStringFromTid( SettingsWindow.TID.DisableFelWarning ),						tooltip = SettingsWindow.DetailTID.DisableFelWarning },
		{ name = "PartyInvitePopUp",						tabId = 4,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.DEFAULT,			settingVariableName = "SystemData.Settings.Interface.partyInvitePopUp",													textFill = GetStringFromTid( SettingsWindow.TID.PartyInvitePopUp ),							tooltip = SettingsWindow.DetailTID.PartyInvitePopUp },
		{ name = "QueryBeforeCriminalActions",				tabId = 4,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.DEFAULT,			settingVariableName = "SystemData.Settings.GameOptions.queryBeforeCriminalAction",										textFill = GetStringFromTid( SettingsWindow.TID.QueryBeforeCriminalActions ),				tooltip = SettingsWindow.DetailTID.QueryBeforeCriminalActions },
		{ name = "AnimalLoreSubSection",					tabId = 4,		objectType = "SubSectionLabelTemplate",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		40)	end,		textFill = GetStringFromTid( SettingsWindow.TID.AnimalLore ) },
		{ name = "AnimalLoreBADPerc",						tabId = 4,		objectType = "SliderItemTemplate",				anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		settingType = SettingsWindow.VariableType.ANIMALLORERANGE,	settingVariableName = "Interface.Settings.AnimalLoreBADPerc",															textFill = GetStringFromTid( SettingsWindow.TID.AnimalLoreBADPerc ),						tooltip = SettingsWindow.DetailTID.AnimalLoreBADPerc },
		{ name = "AnimalLoreVERYBADPerc",					tabId = 4,		objectType = "SliderItemTemplate",				anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		settingType = SettingsWindow.VariableType.ANIMALLORERANGE,	settingVariableName = "Interface.Settings.AnimalLoreVERYBADPerc",														textFill = GetStringFromTid( SettingsWindow.TID.AnimalLoreVERYBADPerc ),					tooltip = SettingsWindow.DetailTID.AnimalLoreVERYBADPerc },
		{ name = "AnimalLoreKhyrosRating",					tabId = 4,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.AnimalLoreKhyrosRating",														textFill = GetStringFromTid( SettingsWindow.TID.AnimalLoreKhyrosRating ),					tooltip = SettingsWindow.DetailTID.AnimalLoreKhyrosRating },
		{ name = "TMapSubSection",							tabId = 4,		objectType = "SubSectionLabelTemplate",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		40)	end,		textFill = GetStringFromTid( SettingsWindow.TID.TreasureMaps ) },
		{ name = "TmapPinPointLines",						tabId = 4,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.TmapPinPointLines",															textFill = GetStringFromTid( SettingsWindow.TID.TmapPinPointLines ),						tooltip = SettingsWindow.DetailTID.TmapPinPointLines,			updateFunc = function() CourseMapWindow.UpdateAllTMaps() end },
		{ name = "TmapDigPlayerLocation",					tabId = 4,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.TmapDigPlayerLocation",														textFill = GetStringFromTid( SettingsWindow.TID.TmapDigPlayerLocation ),					tooltip = SettingsWindow.DetailTID.TmapDigPlayerLocation },
		{ name = "TargetingSubSection",						tabId = 4,		objectType = "SubSectionLabelTemplate",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		40)	end,		textFill = GetStringFromTid( SettingsWindow.TID.TargetingSettings ) },
		{ name = "IgnoreMouseActionsOnSelf",				tabId = 4,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		settingType = SettingsWindow.VariableType.DEFAULT,			settingVariableName = "SystemData.Settings.GameOptions.ignoreMouseActionsOnSelf",										textFill = GetStringFromTid( SettingsWindow.TID.IgnoreMouseActionsOnSelf ),					tooltip = SettingsWindow.DetailTID.IgnoreMouseActionsOnSelf },
		{ name = "SwitchCurrentTargetOnMouseOver",			tabId = 4,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.MouseOverTarget",																textFill = GetStringFromTid( SettingsWindow.TID.SwitchCurrentTargetOnMouseOver ),			tooltip = SettingsWindow.DetailTID.SwitchCurrentTargetOnMouseOver },
		{ name = "AlwaysAttack",							tabId = 4,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.DEFAULT,			settingVariableName = "SystemData.Settings.GameOptions.alwaysAttack",													textFill = GetStringFromTid( SettingsWindow.TID.AlwaysAttack ),								tooltip = SettingsWindow.DetailTID.AlwaysAttack },
		{ name = "TargetQueueing",							tabId = 4,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.DEFAULT,			settingVariableName = "SystemData.Settings.GameOptions.targetQueueing",													textFill = GetStringFromTid( SettingsWindow.TID.TargetQueueing ),							tooltip = SettingsWindow.DetailTID.TargetQueueing },
		{ name = "BlockWarOnPets",							tabId = 4,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.noWarOnPets",																	textFill = GetStringFromTid( SettingsWindow.TID.BlockWarOnPets ),							tooltip = SettingsWindow.DetailTID.BlockWarOnPets },
		{ name = "BlockWarOnParty",							tabId = 4,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.noWarOnParty",																textFill = GetStringFromTid( SettingsWindow.TID.BlockWarOnParty ),							tooltip = SettingsWindow.DetailTID.BlockWarOnParty },
		{ name = "BlockWarOnGuild",							tabId = 4,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.noWarOnFriendly",																textFill = GetStringFromTid( SettingsWindow.TID.BlockWarOnGuild ),							tooltip = SettingsWindow.DetailTID.BlockWarOnGuild },
		{ name = "ToolsOptionsSubSection",					tabId = 4,		objectType = "SubSectionLabelTemplate",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		40)	end,		textFill = GetStringFromTid( SettingsWindow.TID.Tools ) },
		{ name = "CircleOfTransparency",					tabId = 4,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		settingType = SettingsWindow.VariableType.DEFAULT,			settingVariableName = "SystemData.Settings.GameOptions.circleOfTransEnabled",											textFill = GetStringFromTid( SettingsWindow.TID.CircleOfTransparency ),						tooltip = SettingsWindow.DetailTID.CircleOfTransparency },
		{ name = "ToggleClock",								tabId = 4,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.ClockEnabled",																textFill = GetStringFromTid( SettingsWindow.TID.ToggleClock ),								tooltip = SettingsWindow.DetailTID.ToggleClock,						updateFunc = function() ClockWindow.ReloadSettings() end  },
		{ name = "CastBar",									tabId = 4,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.CastBar",																		textFill = GetStringFromTid( SettingsWindow.TID.CastBar ),									tooltip = SettingsWindow.DetailTID.CastBar },
		{ name = "SmartBoatCommands",						tabId = 4,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.SmartBoatCommands",															textFill = GetStringFromTid( SettingsWindow.TID.SmartBoatCommands ),						tooltip = SettingsWindow.DetailTID.SmartBoatCommands },
		{ name = "ToggleBookLog",							tabId = 4,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.ToggleBookLog",																textFill = GetStringFromTid( SettingsWindow.TID.ToggleBookLog ),							tooltip = SettingsWindow.DetailTID.ToggleBookLog },
		{ name = "MapOptionsSubSection",					tabId = 4,		objectType = "SubSectionLabelTemplate",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		40)	end,		textFill = GetStringFromTid( SettingsWindow.TID.Atlas ) },
		{ name = "ToggleCartographer",						tabId = 4,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.EnableCartographer",															textFill = GetStringFromTid( SettingsWindow.TID.ToggleCartographer ),						tooltip = SettingsWindow.DetailTID.ToggleCartographer },
		{ name = "PaperdollOptionsSubSection",				tabId = 4,		objectType = "SubSectionLabelTemplate",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		40)	end,		textFill = GetStringFromTid( SettingsWindow.TID.Paperdoll ) },
		{ name = "BlockOthersPaperdoll",					tabId = 4,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.BlockOthersPaperdoll",														textFill = GetStringFromTid( SettingsWindow.TID.BlockOthersPaperdoll ),						tooltip = SettingsWindow.DetailTID.BlockOthersPaperdoll },
		{ name = "TogglePaperdollIcons",					tabId = 4,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.ShowPaperdollIcons",															textFill = GetStringFromTid( SettingsWindow.TID.TogglePaperdollIcons ),						tooltip = SettingsWindow.DetailTID.TogglePaperdollIcons },
		{ name = "TogglePaperdollFullSlotDurability",		tabId = 4,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.PaperdollFullSlotDurability",													textFill = GetStringFromTid( SettingsWindow.TID.TogglePaperdollFullSlotDurability ),		tooltip = SettingsWindow.DetailTID.TogglePaperdollFullSlotDurability },
		{ name = "EnablePaperdollBG",						tabId = 4,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.EnablePaperdollBG",															textFill = GetStringFromTid( SettingsWindow.TID.EnablePaperdollBG ),						tooltip = SettingsWindow.DetailTID.EnablePaperdollBG },
		{ name = "UseLegacyPaperdolls",						tabId = 4,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.DEFAULT,			settingVariableName = "SystemData.Settings.Interface.LegacyPaperdolls",													textFill = GetStringFromTid( SettingsWindow.TID.UseLegacyPaperdolls ),						tooltip = SettingsWindow.DetailTID.UseLegacyPaperdolls },
		{ name = "MiniTexturePackSubSection",				tabId = 4,		objectType = "SubSectionLabelTemplate",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		40)	end,		textFill = GetStringFromTid( SettingsWindow.TID.MiniTexturePack ) },
		{ name = "MiniTexturePack",							tabId = 4,		objectType = "Settings_LabelTextureCombo",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		30) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.MTP_Current",																	textFill = GetStringFromTid( SettingsWindow.TID.MiniTexturePackLabel ),						tooltip = SettingsWindow.DetailTID.MiniTexturePackLabel,					comboFill = function(combo) for i, db in pairsByIndex(MiniTexturePack.DB) do ComboBoxAddMenuItem(combo, db.name) end end },
		{ name = "MiniTexturePackBorder",					tabId = 4,		objectType = "Settings_LabelTextureCombo",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		30) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.MTP_CurrentBorder",															textFill = GetStringFromTid( SettingsWindow.TID.MiniTexturePackBorderLabel ),				tooltip = SettingsWindow.DetailTID.MiniTexturePackBorderLabel,				comboFill = function(combo) for i, db in pairsByIndex(MiniTexturePack.Overlays) do ComboBoxAddMenuItem(combo, db.name) end end },
		{ name = "HotbarSubSection",						tabId = 4,		objectType = "SubSectionLabelTemplate",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		40)	end,		textFill = GetStringFromTid( SettingsWindow.TID.HotbarSettings ) },
		{ name = "Tooltips",								tabId = 4,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		settingType = SettingsWindow.VariableType.DEFAULT,			settingVariableName = "SystemData.Settings.Interface.showTooltips",														textFill = GetStringFromTid( SettingsWindow.TID.Tooltips ),									tooltip = SettingsWindow.DetailTID.Tooltips },
		{ name = "DisableCastButtons",						tabId = 4,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.DisableButtonsWhileCast",														textFill = GetStringFromTid( SettingsWindow.TID.DisableCastButtons ),						tooltip = SettingsWindow.DetailTID.DisableCastButtons },
		{ name = "HotbarsColorsHotkeysSubSection",			tabId = 4,		objectType = "SubSectionLabelTemplate",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		40)	end,		textFill = GetStringFromTid( SettingsWindow.TID.HotbarsColorsHotkeys ) },
		{ name = "colorHBPlain",							tabId = 4,		objectType = "Settings_ColorButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		settingType = SettingsWindow.VariableType.HOTBARCOLOR,		settingVariableName = "Interface.Settings.HB_Plain",																	textFill = GetStringFromTid( SettingsWindow.TID.colorHBPlain ),								tooltip = SettingsWindow.DetailTID.colorHBPlain },
		{ name = "colorHBControl",							tabId = 4,		objectType = "Settings_ColorButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		40) end,		settingType = SettingsWindow.VariableType.HOTBARCOLOR,		settingVariableName = "Interface.Settings.HB_Control",																	textFill = GetStringFromTid( SettingsWindow.TID.colorHBControl ),							tooltip = SettingsWindow.DetailTID.colorHBControl },
		{ name = "colorHBAlt",								tabId = 4,		objectType = "Settings_ColorButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"right",		parent,		"left",		  -30,		 0) end,		settingType = SettingsWindow.VariableType.HOTBARCOLOR,		settingVariableName = "Interface.Settings.HB_Alt",																		textFill = GetStringFromTid( SettingsWindow.TID.colorHBAlt ),								tooltip = SettingsWindow.DetailTID.colorHBAlt },
		{ name = "colorHBShift",							tabId = 4,		objectType = "Settings_ColorButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",	 -320,		20) end,		settingType = SettingsWindow.VariableType.HOTBARCOLOR,		settingVariableName = "Interface.Settings.HB_Shift",																	textFill = GetStringFromTid( SettingsWindow.TID.colorHBShift ),								tooltip = SettingsWindow.DetailTID.colorHBShift },
		{ name = "colorHBCtrlalt",							tabId = 4,		objectType = "Settings_ColorButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		40) end,		settingType = SettingsWindow.VariableType.HOTBARCOLOR,		settingVariableName = "Interface.Settings.HB_ControlAlt",																textFill = GetStringFromTid( SettingsWindow.TID.colorHBCtrlalt ),							tooltip = SettingsWindow.DetailTID.colorHBCtrlalt },
		{ name = "colorHBCtrlShift",						tabId = 4,		objectType = "Settings_ColorButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"right",		parent,		"left",		  -30,		 0) end,		settingType = SettingsWindow.VariableType.HOTBARCOLOR,		settingVariableName = "Interface.Settings.HB_ControlShift",																textFill = GetStringFromTid( SettingsWindow.TID.colorHBCtrlShift ),							tooltip = SettingsWindow.DetailTID.colorHBCtrlShift },
		{ name = "colorHBCtrlAltShift",						tabId = 4,		objectType = "Settings_ColorButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",	 -320,		20) end,		settingType = SettingsWindow.VariableType.HOTBARCOLOR,		settingVariableName = "Interface.Settings.HB_ControlAltShift",															textFill = GetStringFromTid( SettingsWindow.TID.colorHBCtrlAltShift ),						tooltip = SettingsWindow.DetailTID.colorHBCtrlAltShift },
		{ name = "colorHBAltShift",							tabId = 4,		objectType = "Settings_ColorButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"right",		parent,		"left",		  -30,		 0) end,		settingType = SettingsWindow.VariableType.HOTBARCOLOR,		settingVariableName = "Interface.Settings.HB_AltShift",																	textFill = GetStringFromTid( SettingsWindow.TID.colorHBAltShift ),							tooltip = SettingsWindow.DetailTID.colorHBAltShift },
		{ name = "HotbarsElementsColorsSubSection",			tabId = 4,		objectType = "SubSectionLabelTemplate",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",   -320,		50)	end,		textFill = GetStringFromTid( SettingsWindow.TID.HotbarsElementsColors ) },
		{ name = "colorHBCountdown",						tabId = 4,		objectType = "Settings_ColorButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		settingType = SettingsWindow.VariableType.HOTBARCOLOR,		settingVariableName = "Interface.Settings.HB_CountdownTimer",															textFill = GetStringFromTid( SettingsWindow.TID.colorHBCountdown ),							tooltip = SettingsWindow.DetailTID.colorHBCountdown },
		{ name = "colorHBBorder",							tabId = 4,		objectType = "Settings_ColorButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		40) end,		settingType = SettingsWindow.VariableType.HOTBARCOLOR,		settingVariableName = "Interface.Settings.TargetTypeTintColors." .. SystemData.Hotbar.TargetType.TARGETTYPE_NONE,		textFill = GetStringFromTid( SettingsWindow.TID.colorHBBorder ),							tooltip = SettingsWindow.DetailTID.colorHBBorder },
		{ name = "colorHBCurrent",							tabId = 4,		objectType = "Settings_ColorButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"right",		parent,		"left",		  -30,		 0) end,		settingType = SettingsWindow.VariableType.HOTBARCOLOR,		settingVariableName = "Interface.Settings.TargetTypeTintColors." .. SystemData.Hotbar.TargetType.TARGETTYPE_CURRENT,	textFill = GetStringFromTid( SettingsWindow.TID.colorHBCurrent ),							tooltip = SettingsWindow.DetailTID.colorHBCurrent },
		{ name = "colorHBSelf",								tabId = 4,		objectType = "Settings_ColorButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",	 -320,		20) end,		settingType = SettingsWindow.VariableType.HOTBARCOLOR,		settingVariableName = "Interface.Settings.TargetTypeTintColors." .. SystemData.Hotbar.TargetType.TARGETTYPE_SELF,		textFill = GetStringFromTid( SettingsWindow.TID.colorHBSelf ),								tooltip = SettingsWindow.DetailTID.colorHBSelf },
		{ name = "colorHBCursor",							tabId = 4,		objectType = "Settings_ColorButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"right",		parent,		"left",		  -30,		 0) end,		settingType = SettingsWindow.VariableType.HOTBARCOLOR,		settingVariableName = "Interface.Settings.TargetTypeTintColors." .. SystemData.Hotbar.TargetType.TARGETTYPE_CURSOR,		textFill = GetStringFromTid( SettingsWindow.TID.colorHBCursor ),							tooltip = SettingsWindow.DetailTID.colorHBCursor },
		{ name = "colorHBStored",							tabId = 4,		objectType = "Settings_ColorButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",	 -320,		20) end,		settingType = SettingsWindow.VariableType.HOTBARCOLOR,		settingVariableName = "Interface.Settings.TargetTypeTintColors." .. SystemData.Hotbar.TargetType.TARGETTYPE_OBJECT_ID,	textFill = GetStringFromTid( SettingsWindow.TID.colorHBStored ),							tooltip = SettingsWindow.DetailTID.colorHBStored },
		{ name = "colorHBMouseOver",						tabId = 4,		objectType = "Settings_ColorButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"right",		parent,		"left",		  -30,		 0) end,		settingType = SettingsWindow.VariableType.HOTBARCOLOR,		settingVariableName = "Interface.Settings.TargetTypeTintColors." .. SystemData.Hotbar.TargetType.TARGETTYPE_MOUSEOVER,	textFill = GetStringFromTid( SettingsWindow.TID.colorHBMouseOver ),							tooltip = SettingsWindow.DetailTID.colorHBMouseOver },
		
		-- CONTAINERS
		{ name = "SystemSubSection",						tabId = 5,		objectType = "SubSectionLabelTemplate",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"topleft",		parent,		"topleft",		20,		30)	end,		textFill = GetStringFromTid( SettingsWindow.TID.System ) },
		{ name = "BackpackStyle",							tabId = 5,		objectType = "Settings_LabelCombo",				anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		settingType = SettingsWindow.VariableType.BACKPACKSTYLE,	settingVariableName = "SystemData.Settings.GameOptions.myLegacyBackpackType",											textFill = GetStringFromTid( SettingsWindow.TID.BackpackStyle ),							tooltip = SettingsWindow.DetailTID.BackpackStyle,					comboFill = function(combo) for i, style in pairsByIndex(SettingsWindow.LegacyBackpackStyle) do local text = GetStringFromTid(style.tid) ComboBoxAddMenuItem( combo, text ) end end },
		{ name = "ContainerView",							tabId = 5,		objectType = "Settings_LabelCombo",				anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		settingType = SettingsWindow.VariableType.CONTAINERVIEW,	settingVariableName = "SystemData.Settings.Interface.defaultContainerMode",												textFill = GetStringFromTid( SettingsWindow.TID.DefaultContainerView ),						tooltip = SettingsWindow.DetailTID.DefaultContainerView,			comboFill = function(combo) for i, view in pairsByIndex(SettingsWindow.ContainerViewOptions) do local text = GetStringFromTid(view.tid) ComboBoxAddMenuItem( combo, text ) end end },
		{ name = "CorpseView",								tabId = 5,		objectType = "Settings_LabelCombo",				anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		settingType = SettingsWindow.VariableType.CORPSEVIEW,		settingVariableName = "SystemData.Settings.Interface.defaultCorpseMode",												textFill = GetStringFromTid( SettingsWindow.TID.DefaultCorpseView ),						tooltip = SettingsWindow.DetailTID.DefaultCorpseView,				comboFill = function(combo) for i, view in pairsByIndex(SettingsWindow.ContainerViewOptions) do local text = GetStringFromTid(view.tid) ComboBoxAddMenuItem( combo, text ) end end },
		{ name = "VendorView",								tabId = 5,		objectType = "Settings_LabelCombo",				anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		settingType = SettingsWindow.VariableType.VENDORVIEW,		settingVariableName = "Interface.Settings.playerVendorView",															textFill = GetStringFromTid( SettingsWindow.TID.DefaultVendorView ),						tooltip = SettingsWindow.DetailTID.DefaultVendorView,				comboFill = function(combo) for i, view in pairsByIndex(SettingsWindow.ContainerViewOptions) do local text = GetStringFromTid(view.tid) ComboBoxAddMenuItem( combo, text ) end end },
		{ name = "ToggleContentsInfo",						tabId = 5,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.ToggleContentsInfo",															textFill = GetStringFromTid( SettingsWindow.TID.ToggleContentsInfo ),						tooltip = SettingsWindow.DetailTID.ToggleContentsInfo,				updateFunc = function() SettingsWindow.UpdateAllContainers() end },
		{ name = "AutoLootMaxWeight",						tabId = 5,		objectType = "SliderItemTemplate",				anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		settingType = SettingsWindow.VariableType.AUTOLOOTMAXWEIGHT,settingVariableName = "Interface.Settings.AutoLootMaxWeight",															textFill = GetStringFromTid( SettingsWindow.TID.AutoLootMaxWeight ),						tooltip = SettingsWindow.DetailTID.AutoLootMaxWeight },
		{ name = "ToggleScrollPos",							tabId = 5,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.SaveScrollPos",																textFill = GetStringFromTid( SettingsWindow.TID.ToggleScrollPos ),							tooltip = SettingsWindow.DetailTID.ToggleScrollPos },
		{ name = "ShowContainerType",						tabId = 5,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.ShowContainerType",															textFill = GetStringFromTid( SettingsWindow.TID.ShowContainerType ),						tooltip = SettingsWindow.DetailTID.ShowContainerType,				updateFunc = function() SettingsWindow.DestroyContainers() end  },
		{ name = "ToggleGridLegacy",						tabId = 5,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.GridLegacy",																	textFill = GetStringFromTid( SettingsWindow.TID.ToggleGridLegacy ),							tooltip = SettingsWindow.DetailTID.ToggleGridLegacy,				updateFunc = function() SettingsWindow.DestroyContainers() end,			hideElementsTrue = {"ShowContainerType"}},
		{ name = "ToggleGrid",								tabId = 5,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.EnableContainerGrid",															textFill = GetStringFromTid( SettingsWindow.TID.ToggleGrid ),								tooltip = SettingsWindow.DetailTID.ToggleGrid,						updateFunc = function() SettingsWindow.UpdateGridcontainers() end,		hideElementsFalse = {"ToggleAlternateGrid", "ToggleExtraBright", "ContainerGridColor", "ContainerGridAlternateColor"}},
		{ name = "ToggleExtraBright",						tabId = 5,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.ExtraBrightContainers",														textFill = GetStringFromTid( SettingsWindow.TID.ToggleExtraBright ),						tooltip = SettingsWindow.DetailTID.ToggleExtraBright,				updateFunc = function() SettingsWindow.UpdateGridcontainers() end },
		{ name = "ToggleAlternateGrid",						tabId = 5,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.AlternateGrid",																textFill = GetStringFromTid( SettingsWindow.TID.ToggleAlternateGrid ),						tooltip = SettingsWindow.DetailTID.ToggleAlternateGrid,				updateFunc = function() SettingsWindow.UpdateGridcontainers() end,		hideElementsFalse = {"ContainerGridAlternateColor"}},
		{ name = "ContainerGridColor",						tabId = 5,		objectType = "Settings_ColorButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		settingType = SettingsWindow.VariableType.CONTAINERCOLOR,	settingVariableName = "Interface.Settings.BaseGridColor",																textFill = GetStringFromTid( SettingsWindow.TID.ContainerGridColor ),						tooltip = SettingsWindow.DetailTID.ContainerGridColor },
		{ name = "ContainerGridAlternateColor",				tabId = 5,		objectType = "Settings_ColorButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		settingType = SettingsWindow.VariableType.CONTAINERCOLOR,	settingVariableName = "Interface.Settings.AlternateBackpack",															textFill = GetStringFromTid( SettingsWindow.TID.ContainerGridAlternateColor ),				tooltip = SettingsWindow.DetailTID.ContainerGridAlternateColor },
		{ name = "CascadeSetting",							tabId = 5,		objectType = "Settings_CascadeSettings",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		40)	end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.CascadeType",																	textFill = {GetStringFromTid( SettingsWindow.TID.CascadeSetting ), GetStringFromTid( SettingsWindow.TID.CascadeSettingRANDOM )} },
		{ name = "LootOrderSubSection",						tabId = 5,		objectType = "SubSectionLabelTemplate",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		50)	end,		textFill = GetStringFromTid( SettingsWindow.TID.LootSortOrder ),	fillFunction = function(window) return SettingsWindow.UpdateLootItemsList(window) end },
		{ name = "FindersKeepersSubSection",				tabId = 5,		objectType = "SubSectionLabelTemplate",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		50)	end,		textFill = GetStringFromTid( SettingsWindow.TID.FindersKeepers ),	fillFunction = function(window) return FindersKeepers.UpdateSettingsList(window) end },
		
		-- HEALTHBARS
		{ name = "HealthbarSettingsSubSection",				tabId = 6,		objectType = "SubSectionLabelTemplate",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"topleft",		parent,		"topleft",		20,		30)	end,		textFill = GetStringFromTid( SettingsWindow.TID.Healthbars ) },
		{ name = "StatusWindowStyle",						tabId = 6,		objectType = "Settings_LabelCombo",				anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		settingType = SettingsWindow.VariableType.STATUSSTYLE,		settingVariableName = "Interface.Settings.StatusWindowStyle",															textFill = GetStringFromTid( SettingsWindow.TID.StatusWindowStyleLabel ),					tooltip = SettingsWindow.DetailTID.StatusWindowStyleLabel,				comboFill = function(combo) for i, style in pairsByIndex(SettingsWindow.StatusWindowStyles) do local text = GetStringFromTid(style) ComboBoxAddMenuItem( combo, text ) end end },
		{ name = "ShowStr",									tabId = 6,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		settingType = SettingsWindow.VariableType.DEFAULT,			settingVariableName = "SystemData.Settings.GameOptions.showStrLabel",													textFill = GetStringFromTid( SettingsWindow.TID.ShowStrLabel ),								tooltip = SettingsWindow.DetailTID.ShowStrLabel,						updateFunc = function() StatusWindow.ToggleStrLabel() end },
		{ name = "HealthbarsButtons",						tabId = 6,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.StatusButtons",																textFill = GetStringFromTid( SettingsWindow.TID.HealthbarsButtons ),						tooltip = SettingsWindow.DetailTID.HealthbarsButtons,					updateFunc = function() StatusWindow.ToggleButtons() end },		
		{ name = "ToggleNotorietyAura",						tabId = 6,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.AuraEnabled",																	textFill = GetStringFromTid( SettingsWindow.TID.ToggleNotorietyAura ),						tooltip = SettingsWindow.DetailTID.ToggleNotorietyAura,					updateFunc = function() StatusWindow.UpdateGlowingStatus() end },
		{ name = "ToggleMobileArrow",						tabId = 6,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.EnableMobileArrow",															textFill = GetStringFromTid( SettingsWindow.TID.ToggleMobileArrow ),						tooltip = SettingsWindow.DetailTID.ToggleMobileArrow },
		{ name = "EnableContextButtons",					tabId = 6,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.EnableContextButtons",														textFill = GetStringFromTid( SettingsWindow.TID.EnableContextButtons ),						tooltip = SettingsWindow.DetailTID.EnableContextButtons },
		{ name = "HoverbarsActive",							tabId = 6,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.HoverbarsActive",																textFill = GetStringFromTid( SettingsWindow.TID.HoverbarsActive ),							tooltip = SettingsWindow.DetailTID.HoverbarsActive,						updateFunc = function() if Interface.Settings.HoverbarsActive == true then MobileBarsDockspot.ForceCloseMobilesBar() end end  },
		{ name = "BossbarsActive",							tabId = 6,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.BossbarsActive",																textFill = GetStringFromTid( SettingsWindow.TID.BossbarsActive ),							tooltip = SettingsWindow.DetailTID.BossbarsActive,						updateFunc = function() if Interface.Settings.BossbarsActive == true then BossBar.ResetBossBar() end end  },
		{ name = "UpdateLimit",								tabId = 6,		objectType = "SliderItemTemplate",				anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		settingType = SettingsWindow.VariableType.MOSUPDATETIME,	settingVariableName = "Interface.Settings.MoSUpdateLimit",																textFill = GetStringFromTid( SettingsWindow.TID.MosUpdate ),								tooltip = SettingsWindow.DetailTID.MosUpdate },
		{ name = "HBButtonsSubSection",						tabId = 6,		objectType = "SubSectionLabelTemplate",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		50)	end,		textFill = GetStringFromTid( SettingsWindow.TID.Buttons ) },
		{ name = "LegacyCloseStyle",						tabId = 6,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.LegacyCloseStyle",															textFill = GetStringFromTid( SettingsWindow.TID.LegacyCloseStyle ),							tooltip = SettingsWindow.DetailTID.LegacyCloseStyle },
		{ name = "DisableButtons",							tabId = 6,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.DisableButtons",																textFill = GetStringFromTid( SettingsWindow.TID.DisableButtons ),							tooltip = SettingsWindow.DetailTID.DisableButtons,						updateFunc = function() MobileHealthBar.CloseAllHealthbars(true) end,		hideElementsTrue = {"HealthbarsSmallButtons"} },
		{ name = "HealthbarsSmallButtons",					tabId = 6,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.HealthbarsSmallButtons",														textFill = GetStringFromTid( SettingsWindow.TID.HealthbarsSmallButtons ),					tooltip = SettingsWindow.DetailTID.HealthbarsSmallButtons,				updateFunc = function() MobileHealthBar.UpdateBarSizes() MobileHealthBar.CloseAllHealthbars(true) end },
		{ name = "AutoPinHonored",							tabId = 6,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.AutoPinHonored",																textFill = GetStringFromTid( SettingsWindow.TID.AutoPinHonored ),							tooltip = SettingsWindow.DetailTID.AutoPinHonored,						updateFunc = function() MobileBarsDockspot.CloseAllBarsOnDockspot(MobileBarsDockspot.DockspotDefaultNames[MobileBarsDockspot.DockspotType.PINNED]) if Interface.Settings.AutoPinHonored then MobileHealthBar.CreateBar(Interface.CurrentHonor, true) end end },
		{ name = "SpellsButtonsSubSection",					tabId = 6,		objectType = "SubSectionLabelTemplate",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		50)	end,		textFill = GetStringFromTid( SettingsWindow.TID.SpellButtons ) },
		{ name = "RedButton",								tabId = 6,		objectType = "Settings_HealthbarSpell",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		30) end,		settingType = SettingsWindow.VariableType.HEALTHBARBUTTON,	settingVariableName = "Interface.Settings.RedButton",						texture = "redButton",						comboFill = function(data) return SettingsWindow.FillSpellsCombo(data) end },
		{ name = "GreenButton",								tabId = 6,		objectType = "Settings_HealthbarSpell",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		30) end,		settingType = SettingsWindow.VariableType.HEALTHBARBUTTON,	settingVariableName = "Interface.Settings.GreenButton",						texture = "greenButton",					comboFill = function(data) return SettingsWindow.FillSpellsCombo(data) end },
		{ name = "BlueButton",								tabId = 6,		objectType = "Settings_HealthbarSpell",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		30) end,		settingType = SettingsWindow.VariableType.HEALTHBARBUTTON,	settingVariableName = "Interface.Settings.BlueButton",						texture = "blueButton",						comboFill = function(data) return SettingsWindow.FillSpellsCombo(data) end },
		{ name = "HBFiltersSubSection",						tabId = 6,		objectType = "SubSectionLabelTemplate",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		50)	end,		textFill = GetStringFromTid( SettingsWindow.TID.HealthbarsFilters ) },
		{ name = "Filter2",									tabId = 6,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.MoSFilter.2",						color = NameColor.TextColors[NameColor.Notoriety.INNOCENT],					textFill = NameColor.Filter[2],									tooltip = SettingsWindow.DetailTID.NotorietyFilter,		 },
		{ name = "Filter3",									tabId = 6,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.MoSFilter.3",						color = NameColor.TextColors[NameColor.Notoriety.FRIEND],					textFill = NameColor.Filter[3],									tooltip = SettingsWindow.DetailTID.NotorietyFilter,		 },
		{ name = "Filter4",									tabId = 6,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.MoSFilter.4",						color = NameColor.TextColors[NameColor.Notoriety.CANATTACK],				textFill = NameColor.Filter[4],									tooltip = SettingsWindow.DetailTID.NotorietyFilter,		 },
		{ name = "Filter5",									tabId = 6,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.MoSFilter.5",						color = NameColor.TextColors[NameColor.Notoriety.CRIMINAL],					textFill = NameColor.Filter[5],									tooltip = SettingsWindow.DetailTID.NotorietyFilter,		 },
		{ name = "Filter6",									tabId = 6,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.MoSFilter.6",						color = NameColor.TextColors[NameColor.Notoriety.ENEMY],					textFill = NameColor.Filter[6],									tooltip = SettingsWindow.DetailTID.NotorietyFilter,		 },
		{ name = "Filter7",									tabId = 6,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.MoSFilter.7",						color = NameColor.TextColors[NameColor.Notoriety.MURDERER],					textFill = NameColor.Filter[7],									tooltip = SettingsWindow.DetailTID.NotorietyFilter,		 },
		{ name = "Filter8",									tabId = 6,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.MoSFilter.8",						color = NameColor.TextColors[NameColor.Notoriety.INVULNERABLE],				textFill = NameColor.Filter[8],									tooltip = SettingsWindow.DetailTID.NotorietyFilter,		 },
		{ name = "Filter9",									tabId = 6,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.MoSFilter.9",																									textFill = NameColor.Filter[9],									tooltip = SettingsWindow.DetailTID.NotorietyFilter,		 },
		{ name = "Filter10",								tabId = 6,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.MoSFilter.10",					color = NameColor.TextColors[NameColor.Notoriety.MURDERER],					textFill = NameColor.Filter[10],								tooltip = SettingsWindow.DetailTID.NotorietyFilter,		 },
		
		-- ITEM PROPERTIES
		{ name = "PropertiesSubSection",					tabId = 7,		objectType = "SubSectionLabelTemplate",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"topleft",		parent,		"topleft",		20,		30)	end,		textFill = GetStringFromTid( SettingsWindow.TID.PropertiesSettings ) },
		{ name = "NewItemProperties",						tabId = 7,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.NewItemProperties",															textFill = GetStringFromTid( SettingsWindow.TID.NewItemProperties ),							tooltip = SettingsWindow.DetailTID.NewItemProperties },
		{ name = "NewItemPropertiesScale",					tabId = 7,		objectType = "SliderItemTemplate",				anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.NewItemPropertiesScale",														textFill = GetStringFromTid( SettingsWindow.TID.NewItemPropertiesScale ),						tooltip = SettingsWindow.DetailTID.NewItemPropertiesScale },
		{ name = "ShowPropCaps",							tabId = 7,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.ShowCaps",																	textFill = GetStringFromTid( SettingsWindow.TID.ShowPropCaps ),									tooltip = SettingsWindow.DetailTID.ShowPropCaps },
		{ name = "IntensInfo",								tabId = 7,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.IntensInfo",																	textFill = GetStringFromTid( SettingsWindow.TID.IntensInfo ),									tooltip = SettingsWindow.DetailTID.IntensInfo },
		{ name = "IntensInfoColor",							tabId = 7,		objectType = "Settings_ColorLabelCombo",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.IntensInfoColorID",															textFill = GetStringFromTid( SettingsWindow.TID.IntensInfoColorLabel ),							tooltip = SettingsWindow.DetailTID.IntensInfoColorLabel,				comboFill = function(combo) for i, color in pairsByIndex(SettingsWindow.IntensityColors) do local text = GetStringFromTid(color) ComboBoxAddMenuItem( combo, text ) end end },
		{ name = "ImbuingSubSection",						tabId = 7,		objectType = "SubSectionLabelTemplate",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		50)	end,		textFill = GetStringFromTid( SettingsWindow.TID.ImbuingSettings ) },
		{ name = "NormalForge",								tabId = 7,		objectType = "Settings_LabelRadioButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",	   50,		20) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.UnravelForge",		trueValue = ItemPropertiesInfo.FORGE_Plain,				textFill = GetStringFromTid( SettingsWindow.TID.NormalForge ),									tooltip = SettingsWindow.DetailTID.NormalForge },
		{ name = "TerMurForge",								tabId = 7,		objectType = "Settings_LabelRadioButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"right",		parent,		"left",		   30,		 0) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.UnravelForge",		trueValue = ItemPropertiesInfo.FORGE_TerMur,			textFill = GetStringFromTid( SettingsWindow.TID.TerMurForge ),									tooltip = SettingsWindow.DetailTID.TerMurForge },
		{ name = "QueenForge",								tabId = 7,		objectType = "Settings_LabelRadioButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"right",		parent,		"left",		   30,		 0) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.UnravelForge",		trueValue = ItemPropertiesInfo.FORGE_Queen,				textFill = GetStringFromTid( SettingsWindow.TID.QueenForge ),									tooltip = SettingsWindow.DetailTID.QueenForge },
		{ name = "NormalChar",								tabId = 7,		objectType = "Settings_LabelRadioButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",	 -250,		20) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.UnravelChar",		    trueValue = ItemPropertiesInfo.RACE_Any,				textFill = GetStringFromTid( SettingsWindow.TID.HumanElf ),										tooltip = SettingsWindow.DetailTID.HumanElf },
		{ name = "GargChar",								tabId = 7,		objectType = "Settings_LabelRadioButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"right",		parent,		"left",		   30,		 0) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.UnravelChar",		    trueValue = ItemPropertiesInfo.RACE_Gargoyle,			textFill = GetStringFromTid( SettingsWindow.TID.Gargoyle ),										tooltip = SettingsWindow.DetailTID.Gargoyle },
		{ name = "ColorsubSection",							tabId = 7,		objectType = "SubSectionLabelTemplate",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",	 -340,		30)	end,		textFill = GetStringFromTid( SettingsWindow.TID.PropertiesColors ) },
		{ name = "colorDefault",							tabId = 7,		objectType = "Settings_ColorButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		settingType = SettingsWindow.VariableType.PROPERTIESCOLOR,	settingVariableName = "Interface.Settings.Props_TITLE_COLOR",															textFill = GetStringFromTid( SettingsWindow.TID.colorDefault ),									tooltip = SettingsWindow.DetailTID.colorDefault },
		{ name = "colorMods",								tabId = 7,		objectType = "Settings_ColorButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"right",		parent,		"left",		  -30,		 0) end,		settingType = SettingsWindow.VariableType.PROPERTIESCOLOR,	settingVariableName = "Interface.Settings.Props_MAGICPROP_COLOR",														textFill = GetStringFromTid( SettingsWindow.TID.colorMods ),									tooltip = SettingsWindow.DetailTID.colorMods },
		{ name = "colorEngrave",							tabId = 7,		objectType = "Settings_ColorButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",	 -320,		20) end,		settingType = SettingsWindow.VariableType.PROPERTIESCOLOR,	settingVariableName = "Interface.Settings.Props_ENGRAVE_COLOR",															textFill = GetStringFromTid( SettingsWindow.TID.colorEngrave ),									tooltip = SettingsWindow.DetailTID.colorEngrave },
		{ name = "colorArti",								tabId = 7,		objectType = "Settings_ColorButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"right",		parent,		"left",		  -30,		 0) end,		settingType = SettingsWindow.VariableType.PROPERTIESCOLOR,	settingVariableName = "Interface.Settings.Props_ARTIFACT_COLOR",														textFill = GetStringFromTid( SettingsWindow.TID.colorArti ),									tooltip = SettingsWindow.DetailTID.colorArti },
		{ name = "colorSet",								tabId = 7,		objectType = "Settings_ColorButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",	 -320,		20) end,		settingType = SettingsWindow.VariableType.PROPERTIESCOLOR,	settingVariableName = "Interface.Settings.Props_SET_COLOR",																textFill = GetStringFromTid( SettingsWindow.TID.colorSet ),										tooltip = SettingsWindow.DetailTID.colorSet },
		{ name = "colorResidue",							tabId = 7,		objectType = "Settings_ColorButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"right",		parent,		"left",		  -30,		 0) end,		settingType = SettingsWindow.VariableType.PROPERTIESCOLOR,	settingVariableName = "Interface.Settings.Props_RESIDUE_COLOR",															textFill = GetStringFromTid( SettingsWindow.TID.colorResidue ),									tooltip = SettingsWindow.DetailTID.colorResidue },
		{ name = "colorEssence",							tabId = 7,		objectType = "Settings_ColorButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",	 -320,		20) end,		settingType = SettingsWindow.VariableType.PROPERTIESCOLOR,	settingVariableName = "Interface.Settings.Props_ESSENCE_COLOR",															textFill = GetStringFromTid( SettingsWindow.TID.colorEssence ),									tooltip = SettingsWindow.DetailTID.colorEssence },
		{ name = "colorRelic",								tabId = 7,		objectType = "Settings_ColorButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"right",		parent,		"left",		  -30,		 0) end,		settingType = SettingsWindow.VariableType.PROPERTIESCOLOR,	settingVariableName = "Interface.Settings.Props_RELIC_COLOR",															textFill = GetStringFromTid( SettingsWindow.TID.colorRelic ),									tooltip = SettingsWindow.DetailTID.colorRelic },
		{ name = "colorLostItem",							tabId = 7,		objectType = "Settings_ColorButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",	 -320,		20) end,		settingType = SettingsWindow.VariableType.PROPERTIESCOLOR,	settingVariableName = "Interface.Settings.Props_LOSTITEM_COLOR",														textFill = GetStringFromTid( SettingsWindow.TID.colorLostItem ),								tooltip = SettingsWindow.DetailTID.colorLostItem },
		
		-- OVERHEAD TEXT
		{ name = "OverheadTextsubSection",					tabId = 8,		objectType = "SubSectionLabelTemplate",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"topleft",		parent,		"topleft",		20,		30)	end,		textFill = GetStringFromTid( SettingsWindow.TID.OverheadText ) },
		{ name = "ShowNames",								tabId = 8,		objectType = "Settings_LabelCombo",				anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		settingType = SettingsWindow.VariableType.SHOWNAMES,		settingVariableName = "Interface.Settings.StatusWindowStyle",															textFill = GetStringFromTid( SettingsWindow.TID.ShowNames ),									tooltip = SettingsWindow.DetailTID.ShowNames,				comboFill = function(combo) for i, names in pairsByIndex(SettingsWindow.ShowNames) do local text = GetStringFromTid(names.tid) ComboBoxAddMenuItem( combo, text ) end end },
		{ name = "ShowCorpseNames",							tabId = 8,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.DEFAULT,			settingVariableName = "SystemData.Settings.GameOptions.showCorpseNames",												textFill = GetStringFromTid( SettingsWindow.TID.ShowCorpseNames ),								tooltip = SettingsWindow.DetailTID.ShowCorpseNames },
		{ name = "ClickableNames",							tabId = 8,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.clickableNames",																textFill = GetStringFromTid( SettingsWindow.TID.ClickableNames ),								tooltip = SettingsWindow.DetailTID.ClickableNames },
		{ name = "OverheadChat",							tabId = 8,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.DEFAULT,			settingVariableName = "SystemData.Settings.Interface.OverheadChat",														textFill = GetStringFromTid( SettingsWindow.TID.OverheadChat ),									tooltip = SettingsWindow.DetailTID.OverheadChat },
		{ name = "OverheadChatFadeDelay",					tabId = 8,		objectType = "Settings_LabelCombo",				anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.DEFAULT,			settingVariableName = "SystemData.Settings.Interface.OverheadChatFadeDelay",											textFill = GetStringFromTid( SettingsWindow.TID.OverheadChatFadeDelay ),						tooltip = SettingsWindow.DetailTID.OverheadChatFadeDelay,	comboFill = function(combo) for i, delay in pairsByIndex(SettingsWindow.DelayValues) do local text = GetStringFromTid(delay) ComboBoxAddMenuItem( combo, text ) end end },
		{ name = "DisableSpells",							tabId = 8,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.DisableSpells",																textFill = GetStringFromTid( SettingsWindow.TID.DisableSpells ),								tooltip = SettingsWindow.DetailTID.DisableSpells },
		{ name = "ShowSpellName",							tabId = 8,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.ShowSpellName",																textFill = GetStringFromTid( SettingsWindow.TID.ShowSpellName ),								tooltip = SettingsWindow.DetailTID.ShowSpellName },
		{ name = "noPoisonOthers",							tabId = 8,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.noPoisonOthers",																textFill = GetStringFromTid( SettingsWindow.TID.noPoisonOthers ),								tooltip = SettingsWindow.DetailTID.noPoisonOthers },
		{ name = "OverheadTextSizePlus",					tabId = 8,		objectType = "OverheadTextSizePlus",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",	   90,		30) end,		textFill = GetStringFromTid( SettingsWindow.TID.DefaulTextSizePlus ) },
		{ name = "OverheadTextSizeMinus",					tabId = 8,		objectType = "OverheadTextSizeMinus",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"right",		parent,		"left",		  100,		 0) end,		textFill = GetStringFromTid( SettingsWindow.TID.DefaulTextSizeMinus ) },
		{ name = "OverheadChatFont",						tabId = 8,		objectType = "OverheadChatFont",				anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",	 -382,		20) end,		textFill = GetStringFromTid( SettingsWindow.TID.OverheadChatFont ) },
		{ name = "OverheadNamesFont",						tabId = 8,		objectType = "OverheadNamesFont",				anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"right",		parent,		"left",		    0,		 0) end,		textFill = GetStringFromTid( SettingsWindow.TID.OverheadNamesFont ) },
		{ name = "OverheadSpellFont",						tabId = 8,		objectType = "OverheadSpellFont",				anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"right",		parent,		"left",		    0,		 0) end,		textFill = GetStringFromTid( SettingsWindow.TID.OverheadSpellFont ) },
		{ name = "OverheadDamageFont",						tabId = 8,		objectType = "OverheadDamageFont",				anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"right",		parent,		"left",		    0,		 0) end,		textFill = GetStringFromTid( SettingsWindow.TID.OverheadDamageFont ) },
		{ name = "ColorsubSection",							tabId = 8,		objectType = "SubSectionLabelTemplate",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",	 -485,		50)	end,		textFill = GetStringFromTid( SettingsWindow.TID.Colors ) },
		{ name = "colorHeal",								tabId = 8,		objectType = "Settings_ColorButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		20) end,		settingType = SettingsWindow.VariableType.OVERHEADCOLOR,	settingVariableName = "Interface.Settings.Heal",																		textFill = GetStringFromTid( SettingsWindow.TID.DefaulHealTextColor ) },
		{ name = "colorCurse",								tabId = 8,		objectType = "Settings_ColorButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"right",		parent,		"left",		  -30,		 0) end,		settingType = SettingsWindow.VariableType.OVERHEADCOLOR,	settingVariableName = "Interface.Settings.Curse",																		textFill = GetStringFromTid( SettingsWindow.TID.DefaulCurseTextColor ) },
		{ name = "colorPara",								tabId = 8,		objectType = "Settings_ColorButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",	 -320,		20) end,		settingType = SettingsWindow.VariableType.OVERHEADCOLOR,	settingVariableName = "Interface.Settings.Paralyze",																	textFill = GetStringFromTid( SettingsWindow.TID.DefaulParaTextColor ) },
		{ name = "colorNeutral",							tabId = 8,		objectType = "Settings_ColorButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"right",		parent,		"left",		  -30,		 0) end,		settingType = SettingsWindow.VariableType.OVERHEADCOLOR,	settingVariableName = "Interface.Settings.Neutral",																		textFill = GetStringFromTid( SettingsWindow.TID.DefaulNeutralTextColor ) },
		{ name = "colorNeg",								tabId = 8,		objectType = "Settings_ColorButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",	 -320,		40) end,		settingType = SettingsWindow.VariableType.OVERHEADCOLOR,	settingVariableName = "Interface.Settings.OverHeadError",																textFill = GetStringFromTid( SettingsWindow.TID.DefaulNegTextColor ) },
		{ name = "colorPos",								tabId = 8,		objectType = "Settings_ColorButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"right",		parent,		"left",		  -30,		 0) end,		settingType = SettingsWindow.VariableType.OVERHEADCOLOR,	settingVariableName = "Interface.Settings.SpecialColor",																textFill = GetStringFromTid( SettingsWindow.TID.DefaulPosTextColor ) },
		{ name = "colorYou",								tabId = 8,		objectType = "Settings_ColorButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",	 -320,		40) end,		settingType = SettingsWindow.VariableType.OVERHEADCOLOR,	settingVariableName = "Interface.Settings.YOUGETAMAGE_COLOR",															textFill = GetStringFromTid( SettingsWindow.TID.DefaulYouTextColor ) },
		{ name = "colorPet",								tabId = 8,		objectType = "Settings_ColorButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"right",		parent,		"left",		  -30,		 0) end,		settingType = SettingsWindow.VariableType.OVERHEADCOLOR,	settingVariableName = "Interface.Settings.PETGETDAMAGE_COLOR",															textFill = GetStringFromTid( SettingsWindow.TID.DefaulPetTextColor ) },
		{ name = "colorEnemy",								tabId = 8,		objectType = "Settings_ColorButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",	 -320,		20) end,		settingType = SettingsWindow.VariableType.OVERHEADCOLOR,	settingVariableName = "Interface.Settings.OTHERGETDAMAGE_COLOR",														textFill = GetStringFromTid( SettingsWindow.TID.DefaulEnemyTextColor ) },
		{ name = "colorPhys",								tabId = 8,		objectType = "Settings_ColorButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		0,		40) end,		settingType = SettingsWindow.VariableType.OVERHEADCOLOR,	settingVariableName = "Interface.Settings.PHYSICAL",																	textFill = GetStringFromTid( SettingsWindow.TID.DefaultPhysicalTextColor ) },
		{ name = "colorFire",								tabId = 8,		objectType = "Settings_ColorButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"right",		parent,		"left",		  -30,		 0) end,		settingType = SettingsWindow.VariableType.OVERHEADCOLOR,	settingVariableName = "Interface.Settings.FIRE",																		textFill = GetStringFromTid( SettingsWindow.TID.DefaultFireTextColor ) },
		{ name = "colorCold",								tabId = 8,		objectType = "Settings_ColorButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",	 -320,		20) end,		settingType = SettingsWindow.VariableType.OVERHEADCOLOR,	settingVariableName = "Interface.Settings.COLD",																		textFill = GetStringFromTid( SettingsWindow.TID.DefaultColdTextColor ) },
		{ name = "colorPois",								tabId = 8,		objectType = "Settings_ColorButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"right",		parent,		"left",		  -30,		 0) end,		settingType = SettingsWindow.VariableType.OVERHEADCOLOR,	settingVariableName = "Interface.Settings.POISON",																		textFill = GetStringFromTid( SettingsWindow.TID.DefaultPoisonTextColor ) },
		{ name = "colorEner",								tabId = 8,		objectType = "Settings_ColorButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",	 -320,		20) end,		settingType = SettingsWindow.VariableType.OVERHEADCOLOR,	settingVariableName = "Interface.Settings.ENERGY",																		textFill = GetStringFromTid( SettingsWindow.TID.DefaultEnergyTextColor ) },
		{ name = "colorChaos",								tabId = 8,		objectType = "Settings_ColorButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"right",		parent,		"left",		  -30,		 0) end,		settingType = SettingsWindow.VariableType.OVERHEADCOLOR,	settingVariableName = "Interface.Settings.Chaos",																		textFill = GetStringFromTid( SettingsWindow.TID.DefaulChaosTextColor ) },
		
		-- CHAT
		{ name = "ChatsubSection",							tabId = 9,		objectType = "SubSectionLabelTemplate",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"topleft",		parent,		"topleft",		20,		30)	end,		textFill = GetStringFromTid( SettingsWindow.TID.Chat ) },
		{ name = "NewChatOptionButtons",					tabId = 9,		objectType = "NewChatButtons",					anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",	   200,		20)	end},
		{ name = "LegacyChat",								tabId = 9,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",	  -200,		30) end,		settingType = SettingsWindow.VariableType.DEFAULT,			settingVariableName = "SystemData.Settings.Interface.LegacyChat",												textFill = GetStringFromTid( SettingsWindow.TID.LegacyChat ),						tooltip = SettingsWindow.DetailTID.LegacyChat },
		{ name = "BaseAlpha",								tabId = 9,		objectType = "SliderItemTemplate",				anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		 0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.chat_BaseAlpha",														textFill = GetStringFromTid( SettingsWindow.TID.BaseAlpha ),						tooltip = SettingsWindow.DetailTID.BaseAlpha,							updateFunc = function() SettingsWindow.UpdateChatAlpha() end  },
		{ name = "AutoHide",								tabId = 9,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		 0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.chat_autoHide",														textFill = GetStringFromTid( SettingsWindow.TID.AutoHide ),							tooltip = SettingsWindow.DetailTID.AutoHide },
		{ name = "ShowMouseOver",							tabId = 9,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		 0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.chat_showMouseOver",													textFill = GetStringFromTid( SettingsWindow.TID.ShowMouseOver ),					tooltip = SettingsWindow.DetailTID.ShowMouseOver },
		{ name = "FadeText",								tabId = 9,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		 0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.chat_textFade",														textFill = GetStringFromTid( SettingsWindow.TID.FadeText ),							tooltip = SettingsWindow.DetailTID.FadeText },
		{ name = "FadeDelay",								tabId = 9,		objectType = "SliderItemTemplate",				anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",	     0,		15) end,		settingType = SettingsWindow.VariableType.CHATFADETIME,		settingVariableName = "Interface.Settings.chat_fadeTime",														textFill = GetStringFromTid( SettingsWindow.TID.FadeDelay ),						tooltip = SettingsWindow.DetailTID.FadeDelay },
		{ name = "TimeStamp",								tabId = 9,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		 0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.chat_timeStamp",														textFill = GetStringFromTid( SettingsWindow.TID.TimeStamp ),						tooltip = SettingsWindow.DetailTID.TimeStamp },
		{ name = "LockWindow",								tabId = 9,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		 0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.chat_locked",															textFill = GetStringFromTid( SettingsWindow.TID.LockWindow ),						tooltip = SettingsWindow.DetailTID.LockWindow },
		{ name = "LockLine",								tabId = 9,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		 0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.chat_lockChatLine",			hideElementsTrue = {"LockLineDown"},	textFill = GetStringFromTid( SettingsWindow.TID.LockLine ),							tooltip = SettingsWindow.DetailTID.LockLine },
		{ name = "LockLineDown",							tabId = 9,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		 0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.chat_lockChatLineDown",		hideElementsTrue = {"LockLine"},		textFill = GetStringFromTid( SettingsWindow.TID.LockLineDown ),						tooltip = SettingsWindow.DetailTID.LockLineDown },
		{ name = "MinTotDamage",							tabId = 9,		objectType = "SliderItemTemplate",				anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",	     0,		15) end,		settingType = SettingsWindow.VariableType.CHATMINDAMAGE,	settingVariableName = "Interface.Settings.chat_minTotDmg",														textFill = GetStringFromTid( SettingsWindow.TID.MinTotDamage ),						tooltip = SettingsWindow.DetailTID.MinTotDamage },
		{ name = "ChatLog",									tabId = 9,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		 0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.chat_chatLog",														textFill = GetStringFromTid( SettingsWindow.TID.EnableChatLog ),					tooltip = SettingsWindow.DetailTID.EnableChatLog },
		{ name = "MsgBuffer",								tabId = 9,		objectType = "SliderItemTemplate",				anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",	     0,		15) end,		settingType = SettingsWindow.VariableType.CHATMSGBUFFER,	settingVariableName = "Interface.Settings.chat_messagesBuffCap",												textFill = GetStringFromTid( SettingsWindow.TID.MsgBuffer ),						tooltip = SettingsWindow.DetailTID.MsgBuffer },
		{ name = "ContactsStatus",							tabId = 9,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		 0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.chat_contactStatusChangeMessage",										textFill = GetStringFromTid( SettingsWindow.TID.ContactStatus ),					tooltip = SettingsWindow.DetailTID.ContactStatus },
		{ name = "YouSee",									tabId = 9,		objectType = "SubSectionLabelTemplate",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		 0,		50)	end,		textFill = GetStringFromTid( SettingsWindow.TID.YouSee ) },
		{ name = "YouSeeFilter2",							tabId = 9,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		 0,		20) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.chat_SavedFilter.2",					color = NameColor.TextColors[NameColor.Notoriety.INNOCENT],					textFill = NewChatWindow.Filter[2],									tooltip = SettingsWindow.DetailTID.YouSeeNotoriety },
		{ name = "YouSeeFilter3",							tabId = 9,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		 0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.chat_SavedFilter.3",					color = NameColor.TextColors[NameColor.Notoriety.FRIEND],					textFill = NewChatWindow.Filter[3],									tooltip = SettingsWindow.DetailTID.YouSeeNotoriety },
		{ name = "YouSeeFilter4",							tabId = 9,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		 0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.chat_SavedFilter.4",					color = NameColor.TextColors[NameColor.Notoriety.CANATTACK],				textFill = NewChatWindow.Filter[4],									tooltip = SettingsWindow.DetailTID.YouSeeNotoriety },
		{ name = "YouSeeFilter5",							tabId = 9,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		 0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.chat_SavedFilter.5",					color = NameColor.TextColors[NameColor.Notoriety.CRIMINAL],					textFill = NewChatWindow.Filter[5],									tooltip = SettingsWindow.DetailTID.YouSeeNotoriety },
		{ name = "YouSeeFilter6",							tabId = 9,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		 0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.chat_SavedFilter.6",					color = NameColor.TextColors[NameColor.Notoriety.ENEMY],					textFill = NewChatWindow.Filter[6],									tooltip = SettingsWindow.DetailTID.YouSeeNotoriety },
		{ name = "YouSeeFilter7",							tabId = 9,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		 0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.chat_SavedFilter.7",					color = NameColor.TextColors[NameColor.Notoriety.MURDERER],					textFill = NewChatWindow.Filter[7],									tooltip = SettingsWindow.DetailTID.YouSeeNotoriety },
		{ name = "YouSeeFilter8",							tabId = 9,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		 0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.chat_SavedFilter.8",					color = NameColor.TextColors[NameColor.Notoriety.INVULNERABLE],				textFill = NewChatWindow.Filter[8],									tooltip = SettingsWindow.DetailTID.YouSeeNotoriety },
		{ name = "YouSeeFilter9",							tabId = 9,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		 0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.chat_SavedFilter.9",																								textFill = NewChatWindow.Filter[9],									tooltip = SettingsWindow.DetailTID.YouSeeNotoriety },
		{ name = "YouSeeFilter10",							tabId = 9,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		 0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.chat_SavedFilter.10",					color = NameColor.TextColors[NameColor.Notoriety.MURDERER],					textFill = NewChatWindow.Filter[10],								tooltip = SettingsWindow.DetailTID.YouSeeNotoriety },
		{ name = "MsgFilters",								tabId = 9,		objectType = "SubSectionLabelTemplate",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		 0,		50)	end,		textFill = GetStringFromTid( SettingsWindow.TID.MsgFilters ) },
		{ name = "ShowSpells",								tabId = 9,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		 0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.chat_showSpells",														textFill = GetStringFromTid( SettingsWindow.TID.ShowSpells ),							tooltip = SettingsWindow.DetailTID.ShowSpells },
		{ name = "SpellsCasting",							tabId = 9,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		 0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.chat_showSpellsCasting",												textFill = GetStringFromTid( SettingsWindow.TID.SpellsCasting ),						tooltip = SettingsWindow.DetailTID.SpellsCasting },
		{ name = "PerfectionMsgs",							tabId = 9,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		 0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.chat_showPerfection",													textFill = GetStringFromTid( SettingsWindow.TID.PerfectionMsgs ),						tooltip = SettingsWindow.DetailTID.PerfectionMsgs },
		{ name = "PreventsMultiple",						tabId = 9,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		 0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.chat_showMultiple",													textFill = GetStringFromTid( SettingsWindow.TID.PreventsMultiple ),						tooltip = SettingsWindow.DetailTID.PreventsMultiple },
		{ name = "HideTags",								tabId = 9,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",		 0,		15) end,		settingType = SettingsWindow.VariableType.UI,				settingVariableName = "Interface.Settings.chat_hideTag",														textFill = GetStringFromTid( SettingsWindow.TID.HideTags ),								tooltip = SettingsWindow.DetailTID.HideTags },
		
		-- FILTERS
		{ name = "FilterSubSection",						tabId = 10,		objectType = "SubSectionLabelTemplate",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"topleft",		parent,		"topleft",		20,		30)	end,		textFill = GetStringFromTid( SettingsWindow.TID.Filter ) },
		{ name = "BadWordFilterOption",						tabId = 10,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",	     0,		20) end,		settingType = SettingsWindow.VariableType.DEFAULT,			settingVariableName = "SystemData.Settings.Profanity.BadWordFilter",											textFill = GetStringFromTid( SettingsWindow.TID.FilterObscenity ),						tooltip = SettingsWindow.DetailTID.FilterObscenity },
		{ name = "IgnoreListOption",						tabId = 10,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",	     0,		15) end,		settingType = SettingsWindow.VariableType.DEFAULT,			settingVariableName = "SystemData.Settings.Profanity.IgnoreListFilter",											textFill = GetStringFromTid( SettingsWindow.TID.IgnorePlayers ),						tooltip = SettingsWindow.DetailTID.IgnorePlayers },
		{ name = "IgnoreConfListOption",					tabId = 10,		objectType = "Settings_LabelCheckButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"right",		parent,		"left",		   -50,		 0) end,		settingType = SettingsWindow.VariableType.DEFAULT,			settingVariableName = "SystemData.Settings.Profanity.IgnoreConfListFilter",										textFill = GetStringFromTid( SettingsWindow.TID.IgnoreConfPlayers ),					tooltip = SettingsWindow.DetailTID.IgnoreConfPlayers },
		{ name = "IgnoreListAddButton",						tabId = 10,		objectType = "IgnoreListsAddButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",	  -277,		15) end,		textFill = GetStringFromTid( SettingsWindow.TID.IgnoreListAddButton ) },
		{ name = "IgnoreConfListAddButton",					tabId = 10,		objectType = "IgnoreConfListsAddButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"right",		parent,		"left",		   133,		 0) end,		textFill = GetStringFromTid( SettingsWindow.TID.IgnoreListAddButton ) },
		{ name = "IgnoreListChatListButton",				tabId = 10,		objectType = "IgnoreListsChatListButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",	  -300,		15) end,		textFill = GetStringFromTid( SettingsWindow.TID.IgnoreListChatListButton ) },
		{ name = "IgnoreConfListChatListButton",			tabId = 10,		objectType = "IgnoreConfListsChatListButton",	anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"right",		parent,		"left",		   133,		 0) end,		textFill = GetStringFromTid( SettingsWindow.TID.IgnoreListChatListButton ) },
		{ name = "IgnoreListDeleteButton",					tabId = 10,		objectType = "IgnoreListsDeleteButton",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",	  -300,		15) end,		textFill = GetStringFromTid( SettingsWindow.TID.IgnoreListDeleteButton ) },
		{ name = "IgnoreConfListDeleteButton",				tabId = 10,		objectType = "IgnoreConfListsDeleteButton",		anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"right",		parent,		"left",		   133,		 0) end,		textFill = GetStringFromTid( SettingsWindow.TID.IgnoreListDeleteButton ) },
		{ name = "IgnoreListSubSection",					tabId = 10,		objectType = "SubSectionLabelTemplate",			anchorFunc = function(params) local window = params[1] local parent = params[2] WindowAddAnchor(window,		"bottomleft",	parent,		"topleft",	  -330,		30)	end,		textFill = GetStringFromTid( SettingsWindow.TID.IgnoreList ),	fillFunction = function(window) return SettingsWindow.PopulateProfanityList(window) end },
	}
end
----------------------------------------------------------------
-- LoginWindow Functions
----------------------------------------------------------------

-- OnInitialize Handler()
function SettingsWindow.Initialize()
	
	-- initialize the settings array
	SettingsWindow.InitializeArrays()

	-- add the event that triggers the cancel button on close
	Interface.OnCloseCallBack["SettingsWindow"] = SettingsWindow.OnHide

	-- set window title
	WindowUtils.SetWindowTitle("SettingsWindow", GetStringFromTid( SettingsWindow.TID.UserSetting ) )

	-- bottom buttons text
	ButtonSetText( "SettingsWindowResetUILocButton", GetStringFromTid( SettingsWindow.TID.ResetUILocPos ) )
	ButtonSetText( "SettingsWindowResetButton", GetStringFromTid( SettingsWindow.TID.Reset ) )
	ButtonSetText( "SettingsWindowExportButton", GetStringFromTid( SettingsWindow.TID.Export ) )
	ButtonSetText( "SettingsWindowImportButton", GetStringFromTid( SettingsWindow.TID.Import ) )

	-- creating side tabs
	SettingsWindow.CreateTabs()

	-- load the active tab
	SettingsWindow.ActiveTab = Interface.LoadSetting("SettingsWindowActiveTab", SettingsWindow.ActiveTab)	
end

function SettingsWindow.ResetSearch()
	
	-- unhighlight the last element
	SettingsWindow.SearchUnhighlight(SettingsWindow.CurrentHighlightedItem)
end

function SettingsWindow.CreateTabs()

	-- previous tab name (for anchoring)
	local prevTab

	-- main container
	local parent = "SettingsCategoriesList"

	-- position of the last element (to resize the scrollable area)
	local topOffset = 30

	-- parse all the tabs in the array
	for i, tabData in pairsByIndex(SettingsWindow.Tabs) do

		-- tab window name
		local tabName = tabData.name .. "Tab"

		-- create the tab
		CreateWindowFromTemplate(tabName, "TabLabel", parent)

		-- set the text for the tab
		LabelSetText(tabName .. "Text", tabData.textFill)

		-- set the tab ID
		WindowSetId(tabName, i)

		-- if it's the first we anchor it to the top left of the window
		if i == 1 then
			WindowAddAnchor(tabName, "topleft", parent, "topleft", 10, 5)

		else -- if it's not the first we anchor it to the previous one
			WindowAddAnchor(tabName, "bottomleft", prevTab, "topleft", 0, 10)
		end

		-- saving the tab name for anchoring the next
		prevTab = tabName

		-- get the height of the last element
		local _, h = WindowGetDimensions(tabName)

		-- get the offset from parent of the last element + its height (to calculate the top height of the scroll window)
		local _, offsetY = WindowGetOffsetFromParent(tabName)
		topOffset = (offsetY + h)
	end

	-- get the scroll area dimensions
	local w, h = WindowGetDimensions(parent)

	-- fix the scrollable area dimensions
	WindowSetDimensions(parent, w, topOffset + 40)

	ScrollWindowUpdateScrollRect( "SettingsCategories" )
end

function SettingsWindow.TabMouseOver()

	-- current window name
	local this = SystemData.ActiveWindow.name

	-- get the tab ID
	local tabId = WindowGetId(this)

	-- is this the active tab?
	if SettingsWindow.ActiveTab ~= tabId then

		-- change the label color to highlight it
		LabelSetTextColor( this .. "Text", 255, 255, 0 )
	end
end

function SettingsWindow.TabMouseOverEnd()

	-- current window name
	local this = SystemData.ActiveWindow.name

	-- get the tab ID
	local tabId = WindowGetId(this)

	-- is this the active tab?
	if SettingsWindow.ActiveTab == tabId then
		
		-- change the label color to highlight it
		LabelSetTextColor( this .. "Text", SettingsWindow.ActiveTabTextColor.r, SettingsWindow.ActiveTabTextColor.g, SettingsWindow.ActiveTabTextColor.b )

	else -- change the label color to unhighlight it
		LabelSetTextColor( this .. "Text", 255, 255, 255 )
	end
end

SettingsWindow.ActiveTab = 1
SettingsWindow.ActiveTabTextColor = {r = 0, g = 162, b = 232}
function SettingsWindow.SelectTab()
	
	-- current window name
	local this = SystemData.ActiveWindow.name

	-- get the tab ID
	local tabId = WindowGetId(this)

	-- activating the tab
	SettingsWindow.ForceSelectTab(tabId)
end

function SettingsWindow.ForceSelectTab(tabId)
	
	-- tab window name
	local this = SettingsWindow.Tabs[tabId].name .. "Tab"

	-- previously active tab window name
	local prevTab = SettingsWindow.Tabs[SettingsWindow.ActiveTab].name .. "Tab"

	-- adding text space
	LabelSetText(this .. "Text", L"\t> " .. SettingsWindow.Tabs[tabId].textFill )

	-- change the label color to highlight it
	LabelSetTextColor(this .. "Text", SettingsWindow.ActiveTabTextColor.r, SettingsWindow.ActiveTabTextColor.g, SettingsWindow.ActiveTabTextColor.b)

	-- make the font bold
	LabelSetFont(this .. "Text", "MyriadPro_Outline_16", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)

	-- unloading the tab
	SettingsWindow.UnloadTab(SettingsWindow.ActiveTab)

	-- is the tab changed?
	local tabChange = false

	-- is this the same tab?
	if SettingsWindow.ActiveTab ~= tabId then

		-- removing the text space
		LabelSetText(prevTab .. "Text", SettingsWindow.Tabs[SettingsWindow.ActiveTab].textFill )

		-- unhighlight the previous tab
		LabelSetTextColor(prevTab .. "Text", 255, 255, 255)

		-- return the font normal
		LabelSetFont(prevTab .. "Text", "MyriadPro_16", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)

		-- saving the active tab ID
		SettingsWindow.ActiveTab = tabId

		-- save the active tab
		Interface.SaveSetting( "SettingsWindowActiveTab", SettingsWindow.ActiveTab )

		-- flag the tab as changed
		tabChange = true
	end

	-- loading the tab settings
	SettingsWindow.LoadTab(tabId)

	-- is this the same tab?
	if tabChange == true then
	
		-- scroll to top
		ScrollWindowSetOffset("SettingsArea", 0)
	end
end

function SettingsWindow.LoadTab(tabId)

	-- main container
	local parent = "SettingsList"

	-- previous element
	local prevElement = parent

	-- list of elements to hide after
	local elementsToHide = {}

	-- list of elements to show after
	local elementsToShow = {}

	-- position of the last element (to resize the scrollable area)
	local topOffset = 30

	-- extra height to add
	local extraElement = 0

	-- parsing all settings
	for i, data in pairsByIndex(SettingsWindow.Settings) do

		-- is this setting part of the active tab?
		if data.tabId == tabId then
			
			-- current element name
			local currElement = parent .. data.name

			-- does the window already exist?
			if not DoesWindowExist(currElement) then
				
				-- create the element
				CreateWindowFromTemplate(currElement, data.objectType, parent)

				-- last element name override
				local lastElement

				-- is this a sub-section?
				if data.objectType == "SubSectionLabelTemplate" then
				
					-- filling the text
					LabelSetText(currElement .. "Label", data.textFill)

					-- do we have to use a color for the text?
					if data.color then

						-- change the label color
						LabelSetTextColor( currElement .. "Label", data.color.r, data.color.g, data.color.b )
					end

					-- execute the filling function (if there is one specified)
					if data.fillFunction then

						_, lastElement = pcall(data.fillFunction, currElement)
					end

				-- is this a checkbox with label?
				elseif data.objectType == "Settings_LabelCheckButton" then
					
					-- filling the text
					LabelSetText(currElement .. "Label", data.textFill)

					-- do we have a tooltip to show?
					if data.tooltip then
						
						-- add the tooltip TID as ID of the label
						WindowSetId(currElement .. "Label", data.tooltip)
					end

					-- do we have to use a color for the text?
					if data.color then

						-- change the label color
						LabelSetTextColor( currElement .. "Label", data.color.r, data.color.g, data.color.b )
					end

					-- turn the button into a checkbox
					ButtonSetCheckButtonFlag(currElement .. "Button", true)

					-- get the current check status
					local checkState = GetDynamicVariableValue(data.settingVariableName)

					-- loading the current checkbox status
					ButtonSetPressedFlag(currElement .. "Button", checkState )

					-- elements to hide if the check state is true
					if data.hideElementsTrue and checkState == true then
						table.append(elementsToHide, data.hideElementsTrue)
					end

					-- elements to hide if the check state is false
					if data.hideElementsFalse and checkState == false then
						table.append(elementsToHide, data.hideElementsFalse)
					end

				-- is this a radio box?
				elseif data.objectType == "Settings_LabelRadioButton" then
					
					-- filling the text
					LabelSetText(currElement .. "Label", data.textFill)

					-- do we have a tooltip to show?
					if data.tooltip then
						
						-- add the tooltip TID as ID of the label
						WindowSetId(currElement .. "Label", data.tooltip)
					end

					-- do we have to use a color for the text?
					if data.color then

						-- change the label color
						LabelSetTextColor( currElement .. "Label", data.color.r, data.color.g, data.color.b )
					end

					-- turn the button into a checkbox
					ButtonSetCheckButtonFlag(currElement .. "Button", true)

					-- update the checkstate based on the saved value
					local checkState = GetDynamicVariableValue(data.settingVariableName) == data.trueValue

					-- loading the current checkbox status
					ButtonSetPressedFlag(currElement .. "Button", checkState )

					-- elements to hide if the check state is true
					if data.hideElementsTrue and checkState == true then
						table.append(elementsToHide, data.hideElementsTrue)
					end

					-- elements to hide if the check state is false
					if data.hideElementsFalse and checkState == false then
						table.append(elementsToHide, data.hideElementsFalse)
					end

				-- is this a combo with label?
				elseif data.objectType == "Settings_LabelCombo" or data.objectType == "Settings_LabelComboLong" then

					-- filling the text
					LabelSetText(currElement .. "Label", data.textFill)

					-- do we have to use a color for the text?
					if data.color then

						-- change the label color
						LabelSetTextColor( currElement .. "Label", data.color.r, data.color.g, data.color.b )
					end

					-- do we have a tooltip?
					if data.tooltip then
						
						-- add the tooltip TID as ID of the label
						WindowSetId(currElement .. "Label", data.tooltip)
					end

					-- filling the combo box
					pcall(data.comboFill, currElement .. "Combo")

					-- get the selected ID
					local selectedValue = GetDynamicVariableValue(data.settingVariableName)
					
					-- this setting need a little change for loading
					if data.settingType == SettingsWindow.VariableType.FULLSCREENRES then
						selectedValue = SettingsWindow.GetCurrentResolution()
						
					-- this setting need a little change for loading
					elseif data.settingType == SettingsWindow.VariableType.MAXFRAMERATE then
						selectedValue = SettingsWindow.GetCurrentMaxFramerate()
						
					-- this setting need a little change for loading
					elseif data.settingType == SettingsWindow.VariableType.VALUEPLUSONE then
						selectedValue = selectedValue + 1

					-- this setting needs to be loaded with its own function
					elseif data.settingType == SettingsWindow.VariableType.SCROLLWHEELUP then
						selectedValue = SettingsWindow.GetCurrentScrollUpSetting()

					-- this setting needs to be loaded with its own function
					elseif data.settingType == SettingsWindow.VariableType.SCROLLWHEELDOWN then
						selectedValue = SettingsWindow.GetCurrentScrollDownSetting()

					-- this setting needs to be loaded with its own function
					elseif data.settingType == SettingsWindow.VariableType.LANGUAGE then
						selectedValue = SettingsWindow.GetCurrentLanguage()

					-- this setting needs to be loaded with its own function
					elseif data.settingType == SettingsWindow.VariableType.CUSTOMUI then
						selectedValue = SettingsWindow.GetCurrentUI()

					-- this setting needs to be loaded with its own function
					elseif data.settingType == SettingsWindow.VariableType.OBJECTHANDLESIZE then
						selectedValue = SettingsWindow.GetCurrentObjectHandleSize()

					-- this setting needs to be loaded with its own function
					elseif data.settingType == SettingsWindow.VariableType.LOWHP then
						selectedValue = SettingsWindow.GetCurrentLowHP()

					-- this setting needs to be loaded with its own function
					elseif data.settingType == SettingsWindow.VariableType.LOWHPPET then
						selectedValue = SettingsWindow.GetCurrentLowHPPet()

					-- this setting needs to be loaded with its own function
					elseif data.settingType == SettingsWindow.VariableType.BACKPACKSTYLE then
						selectedValue = SettingsWindow.GetCurrentBackpackStyle()

					-- this setting needs to be loaded with its own function
					elseif data.settingType == SettingsWindow.VariableType.CONTAINERVIEW then
						selectedValue = SettingsWindow.GetCurrentContainerView()

					-- this setting needs to be loaded with its own function
					elseif data.settingType == SettingsWindow.VariableType.CORPSEVIEW then
						selectedValue = SettingsWindow.GetCurrentCorpseView()

					-- this setting needs to be loaded with its own function
					elseif data.settingType == SettingsWindow.VariableType.VENDORVIEW then
						selectedValue = SettingsWindow.GetCurrentVendorView()

					-- this setting needs to be loaded with its own function
					elseif data.settingType == SettingsWindow.VariableType.STATUSSTYLE then
						selectedValue = SettingsWindow.GetCurrentStatusStyle()

					-- this setting needs to be loaded with its own function
					elseif data.settingType == SettingsWindow.VariableType.SHOWNAMES then
						selectedValue = SettingsWindow.GetCurrentShowNames()
					end

					-- elements to hide if the check state is true. For combo the checkstate is the condition specified in the data
					if data.hideElementsTrue and data.hideElementsTrue.condition == selectedValue then
						table.append(elementsToHide, data.hideElementsTrue.elements)
					end

					-- elements to hide if the check state is false. For combo the checkstate is the condition specified in the data
					if data.hideElementsFalse and data.hideElementsFalse.condition ~= selectedValue then
						table.append(elementsToHide, data.hideElementsFalse.elements)
					end

					-- selecting the combo value
					ComboBoxSetSelectedMenuItem(currElement .. "Combo", selectedValue)

				-- is this a combo with label?
				elseif data.objectType == "Settings_LabelTextureCombo" then

					-- filling the text
					LabelSetText(currElement .. "Label", data.textFill)

					-- do we have to use a color for the text?
					if data.color then

						-- change the label color
						LabelSetTextColor( currElement .. "Label", data.color.r, data.color.g, data.color.b )
					end

					-- do we have a tooltip to show?
					if data.tooltip then
						
						-- add the tooltip TID as ID of the label
						WindowSetId(currElement .. "Label", data.tooltip)
					end

					-- filling the combo box
					pcall(data.comboFill, currElement .. "Combo")

					-- get the selected ID
					local selectedValue = GetDynamicVariableValue(data.settingVariableName)

					-- selecting the combo value
					ComboBoxSetSelectedMenuItem(currElement .. "Combo", selectedValue)

					-- texture pack
					if data.settingVariableName == "Interface.Settings.MTP_Current" then
						
						-- set the texture image
						DynamicImageSetTexture(currElement .. "Image", MiniTexturePack.DB[selectedValue].texture .. "Icon", 0, 0)

					elseif data.settingVariableName == "Interface.Settings.MTP_CurrentBorder" then
						
						-- set the texture image
						DynamicImageSetTexture(currElement .. "Image", MiniTexturePack.Overlays[selectedValue].texture, 0, 0)
					end

				-- is this a combo with label?
				elseif data.objectType == "Settings_ColorLabelCombo" then

					-- filling the text
					LabelSetText(currElement .. "Label", data.textFill)

					-- do we have to use a color for the text?
					if data.color then

						-- change the label color
						LabelSetTextColor( currElement .. "Label", data.color.r, data.color.g, data.color.b )
					end

					-- do we have a tooltip to show?
					if data.tooltip then
						
						-- add the tooltip TID as ID of the label
						WindowSetId(currElement .. "Label", data.tooltip)
					end

					-- filling the combo box
					pcall(data.comboFill, currElement .. "Combo")

					-- get the selected ID
					local selectedValue = GetDynamicVariableValue(data.settingVariableName)

					-- selecting the combo value
					ComboBoxSetSelectedMenuItem(currElement .. "Combo", selectedValue)

					-- intensity info color
					if data.settingVariableName == "Interface.Settings.IntensInfoColorID" then

						-- coloring the slot
						WindowSetTintColor(currElement .. "Color", SettingsWindow.IntensInfoColorComboSelChanged(currElement .. "Combo"))
					end

				-- is this a healthbar spells combo?
				elseif data.objectType == "Settings_HealthbarSpell" then

					-- update the image
					DynamicImageSetTexture( currElement .. "Button", data.texture, 0, 0)

					-- filling the combo box
					local _, selectedValue = pcall(data.comboFill, {currElement .. "Combo1", GetDynamicVariableValue(data.settingVariableName .. "1")})
		
					-- selecting the combo value
					ComboBoxSetSelectedMenuItem(currElement .. "Combo1", selectedValue)

					-- filling the combo box 2
					_, selectedValue = pcall(data.comboFill, {currElement .. "Combo2", GetDynamicVariableValue(data.settingVariableName .. "2")})

					-- selecting the combo value 2
					ComboBoxSetSelectedMenuItem(currElement .. "Combo2", selectedValue)
					
					-- filling the combo box 3
					_, selectedValue = pcall(data.comboFill, {currElement .. "Combo3", GetDynamicVariableValue(data.settingVariableName .. "3")})

					-- selecting the combo value 3
					ComboBoxSetSelectedMenuItem(currElement .. "Combo3", selectedValue)

				-- is this a slider with label?
				elseif data.objectType == "SliderItemTemplate" then
					
					-- filling the text
					LabelSetText(currElement .. "Label", data.textFill)

					-- filling the text for plus/minus buttons
					LabelSetText(currElement .. "PlusButton", L"+")
					LabelSetText(currElement .. "MinusButton", L"-")

					-- do we have to use a color for the text?
					if data.color then

						-- change the label color
						LabelSetTextColor( currElement .. "Label", data.color.r, data.color.g, data.color.b )
					end

					-- do we have a tooltip to show?
					if data.tooltip then
						
						-- add the tooltip TID as ID of the label
						WindowSetId(currElement .. "Label", data.tooltip)
					end

					-- get the current slider value
					local sliderValue = GetDynamicVariableValue(data.settingVariableName)

					-- bar update limit need to be divided by 60
					if data.settingType == SettingsWindow.VariableType.MOSUPDATETIME then

						-- divede the value by 60 for the bar
						sliderValue = sliderValue / 60

					-- this setting needs to be divided by 1024
					elseif data.settingType == SettingsWindow.VariableType.CACHE then

						-- divide the value by 1024 for the bar
						sliderValue = sliderValue / 1024

					-- this setting needs a little tweaking
					elseif data.settingType == SettingsWindow.VariableType.UISCALE then

						-- fixing the value for the bar
						sliderValue = (sliderValue - 0.5) * 2

					-- this setting needs a little tweaking
					elseif data.settingType == SettingsWindow.VariableType.MOSOFFSET then

						-- fixing the value for the bar
						sliderValue = sliderValue / 20

					-- this setting needs a little tweaking
					elseif data.settingType == SettingsWindow.VariableType.CHATFADETIME then

						-- fixing the value for the bar
						sliderValue = sliderValue / 20

					-- this setting needs a little tweaking
					elseif data.settingType == SettingsWindow.VariableType.CHATMINDAMAGE then

						-- fixing the value for the bar
						sliderValue = sliderValue / 1000

					-- this setting needs a little tweaking
					elseif data.settingType == SettingsWindow.VariableType.CHATMSGBUFFER then

						-- fixing the value for the bar
						sliderValue = sliderValue / 500

					-- this setting needs a little tweaking
					elseif data.settingType == SettingsWindow.VariableType.ANIMALLORERANGE then
						
						-- fixing the value for the bar
						sliderValue = (100 - sliderValue) / 100

					-- this setting needs a little tweaking
					elseif data.settingType == SettingsWindow.VariableType.AUTOLOOTMAXWEIGHT then
						
						-- fixing the value for the bar
						sliderValue = sliderValue / 100
					end

					-- update slider position
					SliderBarSetCurrentPosition( currElement .. "SliderBar", sliderValue )

					-- update the value text
					SettingsWindow.UpdateSliderValue(currElement .. "SliderBar")

				-- is this a volume slider with label?
				elseif data.objectType == "VolumeSliderItemTemplate" then
					
					-- filling the text
					LabelSetText(currElement .. "Label", data.textFill[2])

					-- filling the text for plus/minus buttons
					LabelSetText(currElement .. "PlusButton", L"+")
					LabelSetText(currElement .. "MinusButton", L"-")

					-- do we have to use a color for the text?
					if data.color then

						-- change the label color
						LabelSetTextColor( currElement .. "Label", data.color.r, data.color.g, data.color.b )
					end

					-- do we have a tooltip to show?
					if data.tooltip and data.tooltip[2] then
						
						-- add the tooltip TID as ID of the label
						WindowSetId(currElement .. "Label", data.tooltip[2])
					end

					-- get the current slider value
					local sliderValue = GetDynamicVariableValue(data.settingVariableName)

					-- get the volume
					local volume = sliderValue.volume

					-- update slider position
					SliderBarSetCurrentPosition( currElement .. "SliderBar", volume )

					-- showing slider numeric value
					LabelSetText(currElement .. "Val", towstring(math.floor(volume * 100)))

					-- filling the text for the checkbox
					LabelSetText(currElement .. "ToggleLabel", data.textFill[1])

					-- do we have a tooltip to show?
					if data.tooltip and data.tooltip[1] then
						
						-- add the tooltip TID as ID of the label
						WindowSetId(currElement .. "Label", data.tooltip[1])
					end

					-- turn the button into a checkbox
					ButtonSetCheckButtonFlag(currElement .. "ToggleButton", true)

					-- get the current check status
					local checkState = sliderValue.enabled

					-- loading the current checkbox status
					ButtonSetPressedFlag(currElement .. "ToggleButton", checkState )

					-- elements to hide if the check state is true
					if data.hideElementsTrue and checkState == true then
						table.append(elementsToHide, data.hideElementsTrue)
					end

					-- elements to hide if the check state is false
					if data.hideElementsFalse and checkState == false then
						table.append(elementsToHide, data.hideElementsFalse)
					end
					
				-- is this a key picker?
				elseif data.objectType == "KeyPicker" then
					
					-- mount/dismount key
					if data.settingType == SettingsWindow.VariableType.KEYBINDINGMOUNTDISMOUNT then

						-- filling the text
						LabelSetText(currElement .. "Label", GetStringFromTid(290))

						-- update the key value
						LabelSetText(currElement .. "Value", SystemData.Hotbar[Interface.MountBlockbar].BindingDisplayStrings[1])

					else -- any other key

						-- get the name TID
						local nameTid, settingVariableName = SettingsWindow.GetKeyBindingNameNType(data.name)

						-- filling the text
						LabelSetText(currElement .. "Label", GetStringFromTid(nameTid))

						-- update the key value
						LabelSetText(currElement .. "Value", GetDynamicVariableValue(settingVariableName))
					end

					-- reset the text color
					LabelSetTextColor(currElement .. "Value", 255, 255, 255 )

				-- is this a key picker?
				elseif data.objectType == "KeyPickerNoCustom" then
					
					-- get the name TID
					local nameTid, settingVariableName = SettingsWindow.GetKeyBindingNameNType(data.name)

					-- filling the text
					LabelSetText(currElement .. "Label", data.textFill)

					-- do we have to use a color for the text?
					if data.color then

						-- change the label color
						LabelSetTextColor( currElement .. "Label", data.color.r, data.color.g, data.color.b )
					end

					-- update the key value
					LabelSetText(currElement .. "Value", data.tooltip)

					-- reset the text color
					LabelSetTextColor(currElement .. "Value", 255, 255, 255 )

				-- is this a color with label?
				elseif data.objectType == "Settings_ColorButton" then

					-- filling the text
					LabelSetText(currElement .. "Label", data.textFill)

					-- do we have to use a color for the text?
					if data.color then

						-- change the label color
						LabelSetTextColor( currElement .. "Label", data.color.r, data.color.g, data.color.b )
					end

					-- do we have a tooltip to show?
					if data.tooltip then
						
						-- add the tooltip TID as ID of the label
						WindowSetId(currElement .. "Label", data.tooltip)
					end

					-- get the selected ID
					local color = GetDynamicVariableValue(data.settingVariableName)

					-- color the slot
					WindowSetTintColor(currElement .. "Button", color.r, color.g, color.b)

				-- is this a color with label?
				elseif data.objectType == "Settings_CascadeSettings" then

					-- make the buttons as checkbox
					ButtonSetCheckButtonFlag( currElement .. "TOPLEFT",	true )
					ButtonSetCheckButtonFlag( currElement .. "TOPRIGHT", true )
					ButtonSetCheckButtonFlag( currElement .. "BOTTOMLEFT", true )
					ButtonSetCheckButtonFlag( currElement .. "BOTTOMRIGHT",	true )
					ButtonSetCheckButtonFlag( currElement .. "RANDOMButton", true )

					-- filling the text
					LabelSetText(currElement .. "Label", data.textFill[1])

					-- do we have to use a color for the text?
					if data.color then

						-- change the label color
						LabelSetTextColor( currElement .. "Label", data.color.r, data.color.g, data.color.b )
					end

					-- filling the random text
					LabelSetText(currElement .. "RANDOMLabel", data.textFill[2])

					-- get the selected cascade type
					local value = GetDynamicVariableValue(data.settingVariableName)

					-- tick the right radio box
					ButtonSetPressedFlag( currElement .. "TOPLEFT", value == 0 )
					ButtonSetPressedFlag( currElement .. "TOPRIGHT", value == 1 )
					ButtonSetPressedFlag( currElement .. "BOTTOMLEFT", value == 2 )
					ButtonSetPressedFlag( currElement .. "BOTTOMRIGHT", value == 3 )
					ButtonSetPressedFlag( currElement .. "RANDOMButton", value == 4 )

					-- add the tooltip TID as ID of the label
					WindowSetId( currElement .. "TOPLEFT",	0 )
					WindowSetId( currElement .. "TOPRIGHT", 0 )
					WindowSetId( currElement .. "BOTTOMLEFT", 0 )
					WindowSetId( currElement .. "BOTTOMRIGHT",	0 )
					WindowSetId( currElement .. "RANDOMLabel", 0 )

				-- other buttons
				elseif	data.objectType == "OverheadTextSizePlus" or
						data.objectType == "OverheadTextSizeMinus" or
						data.objectType == "OverheadChatFont" or
						data.objectType == "OverheadNamesFont" or
						data.objectType == "OverheadSpellFont" or
						data.objectType == "OverheadDamageFont" or
						data.objectType == "IgnoreListsAddButton" or
						data.objectType == "IgnoreConfListsAddButton" or
						data.objectType == "IgnoreListsChatListButton" or
						data.objectType == "IgnoreConfListsChatListButton" or
						data.objectType == "IgnoreListsDeleteButton" or
						data.objectType == "IgnoreConfListsDeleteButton"
				then

					-- add the text
					ButtonSetText( currElement, data.textFill )
				end

				-- execute the anchoring
				pcall(data.anchorFunc, {currElement, prevElement})

				-- force process anchors or the measurement will be wrong
				WindowForceProcessAnchors(currElement)

				-- previous element name
				prevElement = currElement

				-- do we have an override?
				if lastElement then
					prevElement = lastElement
				end

				-- force process anchors or the measurement will be wrong
				WindowForceProcessAnchors(prevElement)

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
		end
	end

	-- parse the elments to hide
	for i, elmnt in pairsByIndex(elementsToHide) do
		
		-- real element name
		local element = parent .. elmnt

		-- does the element exist?
		if DoesWindowExist(element) then

			-- disable the element
			SettingsWindow.SetDisabled(element)
		end
	end
	
	-- get the scroll area dimensions
	local w, h = WindowGetDimensions(parent)

	-- fix the scrollable area dimensions
	WindowSetDimensions(parent, w, topOffset + 40)

	-- update the scrollable area
	ScrollWindowUpdateScrollRect( "SettingsArea" )
end

function SettingsWindow.UnloadTab(tabId)

	-- main container
	local parent = "SettingsList"

	-- parsing all settings
	for i, data in pairsByIndex(SettingsWindow.Settings) do
		
		-- is this setting part of the active tab?
		if data.tabId == tabId then

			-- check if the window exist and destroy it
			if DoesWindowExist(parent .. data.name) then
				DestroyWindow(parent .. data.name)
			end
		end
	end

	-- delete the loot sort items (if it's the right tab)
	SettingsWindow.DeleteLootList()

	-- delete all the existing finders keepers items (if it's the right tab)
	FindersKeepers.ClearSettingsList()

	-- delete all ignored players (if it's the right tab)
	SettingsWindow.DeleteIgnoreList()
end

function SettingsWindow.ToggleSettingsWindow()	
	ToggleWindowByName("SettingsWindow")	
end

function SettingsWindow.PlusItemMouseOver()
	
	-- current window name
	local this = SystemData.ActiveWindow.name

	-- highlight the plus
	LabelSetTextColor(this, 0, 255, 0)
end

function SettingsWindow.MinusItemMouseOver()

	-- current window name
	local this = SystemData.ActiveWindow.name

	-- highlight the minus
	LabelSetTextColor(this, 255, 0, 0)
end

function SettingsWindow.ClearMouseOverItem()

	-- current window name
	local this = SystemData.ActiveWindow.name

	-- unhighlight the window
	LabelSetTextColor(this, 255, 255, 255)
end

function SettingsWindow.AlterSlider()
	
	-- current window name
	local this = SystemData.ActiveWindow.name

	-- main container
	local parent = "SettingsList"

	-- get the bar name
	local bar = WindowGetParent(this) .. "SliderBar"

	-- get the current bar value
	local barValue = SliderBarGetCurrentPosition( bar )

	-- remove the parent from the bar name to obtain the object name
	local varName = string.gsub(WindowGetParent(this), parent, "")

	-- get the setting type
	local variableName, settingType, updateFunc = SettingsWindow.GetVariableName(varName)

	-- how much the bar should move when the button is pressed?
	local variation = 0.01

	-- get the current text value for the bar
	local oldValue = LabelGetText(WindowGetParent(this) .. "Val")

	-- chat damage log
	if settingType == SettingsWindow.VariableType.CHATMINDAMAGE then

		-- 10 by 10 up to 1k
		variation = 0.1

	-- chat messages buffer
	elseif settingType == SettingsWindow.VariableType.CHATMSGBUFFER then

		-- 5 by 5 up to 500
		variation =  0.2

		-- can't go less than 50
		if tonumber(oldValue) <= 50 and not string.find(this, "Plus", 1, true) then
			return
		end

	-- mobiles on screen bars offset or chat fade time
	elseif	settingType == SettingsWindow.VariableType.MOSOFFSET or 
			settingType == SettingsWindow.VariableType.CHATFADETIME 
	then

		-- 0.05 by 0.05 up to 20
		variation = 0.05

	-- 60s max (1s at time)
	elseif settingType == SettingsWindow.VariableType.MOSUPDATETIME then

		-- 0.016 by 0.016 up to 60
		variation = 0.016

	-- set the animal lore perc caps
	elseif settingType == SettingsWindow.VariableType.ANIMALLORERANGE then

		-- make sure the value is not less than very bad + 5 and not less than 5%
		if (tonumber(oldValue) <= 5 or tonumber(oldValue) <= (100 - (Interface.Settings.AnimalLoreVERYBADPerc - 5))) and variableName == "Interface.Settings.AnimalLoreBADPerc" and not string.find(this, "Plus", 1, true) then
			return

		-- make sure the value is max 95% for bad perc
		elseif tonumber(oldValue) >= 95 and variableName == "Interface.Settings.AnimalLoreBADPerc" and string.find(this, "Plus", 1, true) then
			return

		-- make sure the value is max 90% for very bad perc and always less than the bad perc
		elseif (tonumber(oldValue) >= 90 or tonumber(oldValue) >= (100 - (Interface.Settings.AnimalLoreBADPerc + 5))) and variableName == "Interface.Settings.AnimalLoreVERYBADPerc" and string.find(this, "Plus", 1, true) then
			return
		end
	end

	-- the new text value for the bar (we start as equal and change the sliderbar until the value changes)
	local value = oldValue

	-- is the old value the same as the new value? try again
	while oldValue == value do

		-- increase the value
		if string.find(this, "Plus", 1, true) then
			barValue = barValue + variation
	
		else -- decrease the value
			barValue = barValue - variation
		end

		-- update the bar value
		SliderBarSetCurrentPosition(bar, math.round(barValue, 2))
	
		-- process the update
		SettingsWindow.UpdateSliderValue(bar)

		-- get the new slider bar value
		value = LabelGetText(WindowGetParent(this) .. "Val")
	end

	-- update the last time this slidebar has been used
	SettingsWindow.isSliding[bar] = Interface.TimeSinceLogin + 1

	-- wait for the player to stop sliding then flag the sliding as stopped
	Interface.ExecuteWhenAvailable(
	{
		name = "ChangedSlidebarSettingsTimeout_" .. bar,
		check = function() return Interface.TimeSinceLogin > SettingsWindow.isSliding[bar] end, 
		callback = function() SettingsWindow.isSliding[bar] = nil end, 
		removeOnComplete = true
	})

	-- save the setting only after the player have stopped sliding
	Interface.ExecuteWhenAvailable(
	{
		name = "ChangedSlidebarSettings_" .. bar,
		check = function() return SettingsWindow.isSliding[bar] == nil end, 
		callback = function() SettingsWindow.SaveSliderValue(bar) end, 
		removeOnComplete = true
	})
end

SettingsWindow.isSliding = {}
function SettingsWindow.UpdateSliderSettings(curPos)

	-- original window name
	local bar = SystemData.ActiveWindow.name

	-- update the last time this slidebar has been used
	SettingsWindow.isSliding[bar] = Interface.TimeSinceLogin + 1

	-- update the value
	SettingsWindow.UpdateSliderValue(bar)

	-- wait for the player to stop sliding then flag the sliding as stopped
	Interface.ExecuteWhenAvailable(
	{
		name = "ChangedSlidebarSettingsTimeout_" .. bar,
		check = function() return Interface.TimeSinceLogin > SettingsWindow.isSliding[bar] end, 
		callback = function() SettingsWindow.isSliding[bar] = nil end, 
		removeOnComplete = true
	})

	-- save the setting only after the player have stopped sliding
	Interface.ExecuteWhenAvailable(
	{
		name = "ChangedSlidebarSettings_" .. bar,
		check = function() return SettingsWindow.isSliding[bar] == nil end, 
		callback = function() SettingsWindow.SaveSliderValue(bar) end, 
		removeOnComplete = true
	})
end

function SettingsWindow.SaveSliderValue(bar)

	-- bar name
	local barName = WindowGetParent(bar)

	-- get the bar value
	local barVal = SliderBarGetCurrentPosition( bar )

	-- main container
	local parent = "SettingsList"

	-- remove the parent from the bar name to obtain the object name
	local varName = string.gsub(barName, parent, "")

	-- get the setting type
	local variableName, settingType, updateFunc = SettingsWindow.GetVariableName(varName)
	
	-- cache size bar
	if settingType == SettingsWindow.VariableType.CACHE then
	
		-- update the variable value
		SetDynamicVariableValue(variableName, barVal * 1024)

		-- update the player profile
		SettingsWindow.UpdateProfile()

	-- ui scale bar
	elseif settingType == SettingsWindow.VariableType.UISCALE then
	
		-- update the variable value
		SetDynamicVariableValue(variableName, ( barVal / 2 ) + 0.5)

		-- update the player profile
		SettingsWindow.UpdateProfile()

	-- chat damage log
	elseif settingType == SettingsWindow.VariableType.CHATMINDAMAGE then

		-- remove decimals
		barVal = tonumber(string.format("%.0f", barVal * 1000))

		-- update the variable value
		SetDynamicVariableValue(variableName, barVal)
		
		-- get the variable name by removing "Interface.Settings."
		local saveName = string.gsub(variableName, "Interface.Settings.", "")
		
		-- save the setting
		Interface.SaveSetting( saveName, barVal )

		-- update the player profile
		SettingsWindow.UpdateProfile()

	-- volume
	elseif settingType == SettingsWindow.VariableType.VOLUME then
		variableName = variableName .. ".volume"
		
		-- update the variable value
		SetDynamicVariableValue(variableName, barVal)

		-- EC PlaySound
		if not string.find(variableName, "SystemData.Settings.Sound", 1, true) then

			-- get the variable name by removing "Interface.Settings."
			local saveName = string.gsub(variableName, "Interface.", "")
		
			-- save the setting
			Interface.SaveSetting( saveName, barVal )
		end

		-- update the player profile
		SettingsWindow.UpdateProfile()

	-- chat messages buffer
	elseif settingType == SettingsWindow.VariableType.CHATMSGBUFFER then

		-- remove the decimals from the value
		barVal =  tonumber(string.format("%.0f", barVal * 500))

		-- the buffer can't be less than 50
		if barVal < 50 then
			barVal = 50
			SliderBarSetCurrentPosition(bar, barVal / 500)
		end

		-- update the variable value
		SetDynamicVariableValue(variableName, barVal)
		
		-- get the variable name by removing "Interface.Settings."
		local saveName = string.gsub(variableName, "Interface.Settings.", "")
		
		-- save the setting
		Interface.SaveSetting(saveName, barVal)

		-- update the player profile
		SettingsWindow.UpdateProfile()

	-- mobiles on screen bars offset or chat fade time
	elseif	settingType == SettingsWindow.VariableType.MOSOFFSET or 
			settingType == SettingsWindow.VariableType.CHATFADETIME 
	then

		-- calculate the right value
		barVal = math.floor(20 * barVal)

		-- update the variable value
		SetDynamicVariableValue(variableName, barVal)
		
		-- get the variable name by removing "Interface.Settings."
		local saveName = string.gsub(variableName, "Interface.Settings.", "")
		
		-- save the setting
		Interface.SaveSetting( saveName, barVal )

		-- update the player profile
		SettingsWindow.UpdateProfile()

	-- autoloot max weight
	elseif settingType == SettingsWindow.VariableType.AUTOLOOTMAXWEIGHT then

		-- remove the decimals from the value
		barVal = tonumber(string.format("%.0f", barVal * 100))

		-- update the variable value
		SetDynamicVariableValue(variableName, barVal)
		
		-- get the variable name by removing "Interface.Settings."
		local saveName = string.gsub(variableName, "Interface.Settings.", "")
		
		-- save the setting
		Interface.SaveSetting(saveName, barVal)

		-- update the player profile
		SettingsWindow.UpdateProfile()

	elseif settingType == SettingsWindow.VariableType.DEFAULT then

		-- update the variable value
		SetDynamicVariableValue(variableName, barVal)

		-- update the player profile
		SettingsWindow.UpdateProfile()

	elseif settingType == SettingsWindow.VariableType.UI then

		-- update the variable value
		SetDynamicVariableValue(variableName, barVal)
		
		-- get the variable name by removing "Interface.Settings."
		local saveName = string.gsub(variableName, "Interface.Settings.", "")
		
		-- save the setting
		Interface.SaveSetting( saveName, barVal )

		-- update the player profile
		SettingsWindow.UpdateProfile()

	elseif settingType == SettingsWindow.VariableType.MOSUPDATETIME then

		-- the bars update limit is a 60 based value
		barVal = tonumber(wstring.format(L"%.0f", barVal * 60))

		-- update the variable value
		SetDynamicVariableValue(variableName, barVal)
		
		-- get the variable name by removing "Interface.Settings."
		local saveName = string.gsub(variableName, "Interface.Settings.", "")
		
		-- save the setting
		Interface.SaveSetting( saveName, barVal )

		-- update the player profile
		SettingsWindow.UpdateProfile()

	elseif settingType == SettingsWindow.VariableType.ANIMALLORERANGE then

		-- the bars update limit is a 100 based value
		barVal = tonumber(wstring.format(L"%.0f", barVal * 100))
		
		-- make sure the value is less than the very bad perc
		if tonumber(barVal) < (100 - (Interface.Settings.AnimalLoreVERYBADPerc - 5)) and variableName == "Interface.Settings.AnimalLoreBADPerc" then
			barVal = (100 - (Interface.Settings.AnimalLoreVERYBADPerc - 5)) / 100

			-- set the bar position correctly
			SliderBarSetCurrentPosition(bar, barVal)

		-- make sure the value is min 5% for bad perc
		elseif barVal < 5 and variableName == "Interface.Settings.AnimalLoreBADPerc" then
			barVal = 5
		
			-- set the bar position correctly
			SliderBarSetCurrentPosition(bar, barVal)

		-- make sure the value is min 95% for bad perc
		elseif barVal > 95 and variableName == "Interface.Settings.AnimalLoreBADPerc" then
			barVal = 95

			-- set the bar position correctly
			SliderBarSetCurrentPosition(bar, barVal)

		-- make sure the value is at least 5% less than the bad perc
		elseif barVal > (100 - (Interface.Settings.AnimalLoreBADPerc + 5)) and variableName == "Interface.Settings.AnimalLoreVERYBADPerc" then
			barVal = (100 - (Interface.Settings.AnimalLoreBADPerc + 5)) / 100

			-- set the bar position correctly
			SliderBarSetCurrentPosition(bar, barVal)

		-- make sure the value is min 10% for very bad perc
		elseif barVal > 90 and variableName == "Interface.Settings.AnimalLoreVERYBADPerc" then
			barVal = 90

			-- set the bar position correctly
			SliderBarSetCurrentPosition(bar, barVal)
		end
		
		-- update the variable value
		SetDynamicVariableValue(variableName, 100 - barVal)
		
		-- get the variable name by removing "Interface.Settings."
		local saveName = string.gsub(variableName, "Interface.Settings.", "")
		
		-- save the setting
		Interface.SaveSetting( saveName, 100 - barVal )

		-- update the player profile
		SettingsWindow.UpdateProfile()
	end

	-- do we have a function to execute after saving?
	if updateFunc then
		pcall(updateFunc)
	end
end

function SettingsWindow.UpdateSliderValue(bar)
	
	-- bar name
	local barName = WindowGetParent(bar)

	-- get the bar value
	local barVal = SliderBarGetCurrentPosition( bar )

	-- main container
	local parent = "SettingsList"

	-- remove the parent from the bar name to obtain the object name
	local varName = string.gsub(barName, parent, "")

	-- get the setting type
	local variableName, settingType = SettingsWindow.GetVariableName(varName)

	-- cache size bar
	if settingType == SettingsWindow.VariableType.CACHE then

		-- update the cache size value
		barVal = math.floor( barVal * 1024 )

		-- format the text value
		barVal =  towstring(barVal) .. L" MB"

	-- ui scale bar
	elseif settingType == SettingsWindow.VariableType.UISCALE then
		
		-- get the bar value
		barVal = ( barVal / 2 ) + 0.5

		-- format the text value 
		barVal = wstring.format(L"%2.2f", barVal) 
	
	-- chat damage log
	elseif settingType == SettingsWindow.VariableType.CHATMINDAMAGE then

		-- remove the decimals from the value
		barVal =  towstring(string.format("%.0f", barVal * 1000))

		-- if the value is 0 the bar is disabled
		if barVal == L"0" then
			barVal = GetStringFromTid(1155308) -- Disabled
		end

	-- volume
	elseif settingType == SettingsWindow.VariableType.VOLUME then
		
		-- update the value
		barVal = towstring(string.format("%.0f", barVal * 100))

	-- chat messages buffer
	elseif settingType == SettingsWindow.VariableType.CHATMSGBUFFER then

		-- remove the decimals from the value
		barVal =  tonumber(string.format("%.0f", barVal * 500))

		-- the buffer can't be less than 50
		if barVal < 50 then
			barVal = 50
			SliderBarSetCurrentPosition(bar, barVal / 500)
		end

		barVal = towstring(barVal)

	-- mobiles on screen update limit
	elseif settingType == SettingsWindow.VariableType.MOSUPDATETIME then

		-- format the bar value
		barVal = wstring.format(L"%.0f", barVal * 60) 

		-- is the delay 0?
		if tonumber(barVal) == 0 then

			-- set the text in "Real Time"
			barVal = GetStringFromTid(266)

		else -- add the s to mark the number as seconds
			barVal = barVal .. L" s"
		end

	-- mobiles on screen bars offset or chat fade time
	elseif	settingType == SettingsWindow.VariableType.MOSOFFSET or 
			settingType == SettingsWindow.VariableType.CHATFADETIME 
	then

		-- get the bar value
		barVal = towstring(math.floor( 20 * barVal ))

	-- autoloot max weight
	elseif settingType == SettingsWindow.VariableType.AUTOLOOTMAXWEIGHT then

		-- format the bar value
		barVal = wstring.format(L"%.0f", barVal * 100) 

	-- percent value
	elseif settingType == SettingsWindow.VariableType.ANIMALLORERANGE then

		-- get the bar value
		barVal = towstring(math.floor( 100 * barVal )) .. L"%"

		-- make sure the value is less than the very bad perc
		if tonumber(barVal) < (100 - (Interface.Settings.AnimalLoreVERYBADPerc - 5)) and variableName == "Interface.Settings.AnimalLoreBADPerc" then
			barVal = towstring(wstring.format(L"%.0f", (100 - (Interface.Settings.AnimalLoreVERYBADPerc - 5))) ) .. L"%"

			-- set the bar position correctly
			SliderBarSetCurrentPosition(bar, (100 - (Interface.Settings.AnimalLoreVERYBADPerc - 5)) / 100)

		-- make sure the value is min 5% for bad perc
		elseif tonumber(barVal) < 5 and variableName == "Interface.Settings.AnimalLoreBADPerc" then
			barVal = L"5%"

			-- set the bar position correctly
			SliderBarSetCurrentPosition(bar, 0.05)

		-- make sure the value is max 95% for bad perc
		elseif tonumber(barVal) > 95 and variableName == "Interface.Settings.AnimalLoreBADPerc" then
			barVal = L"95%"

			-- set the bar position correctly
			SliderBarSetCurrentPosition(bar, 0.95)

		-- make sure the value is at least 5% less than the bad perc
		elseif tonumber(barVal) > (100 - (Interface.Settings.AnimalLoreBADPerc + 5)) and variableName == "Interface.Settings.AnimalLoreVERYBADPerc" then
			barVal = towstring(wstring.format(L"%.0f", (100 - (Interface.Settings.AnimalLoreBADPerc + 5))) ) .. L"%"

			-- set the bar position correctly
			SliderBarSetCurrentPosition(bar, (100 - (Interface.Settings.AnimalLoreBADPerc + 5)) / 100)

		-- make sure the value is max 90% for very bad perc
		elseif tonumber(barVal) > 90 and variableName == "Interface.Settings.AnimalLoreVERYBADPerc" then
			barVal = L"90%"

			-- set the bar position correctly
			SliderBarSetCurrentPosition(bar, 0.90)
		end

	-- chat base alpha
	elseif varName == "BaseAlpha" then

		-- is the value less than 0.01?
		if barVal < 0.01 then

			-- set the value to 0.01
			barVal = 0.01

			-- update the slider bar
			SliderBarSetCurrentPosition(bar, barVal)
		end

		-- show the value
		barVal = wstring.format(L"%2.2f", barVal)

	else -- any other bar

		barVal = wstring.format(L"%2.2f", barVal)
	end

	-- show the bar value
	LabelSetText(barName .. "Val", barVal)
end

function SettingsWindow.UpdateSettings()
	
	if not WindowGetShowing("SettingsWindow") then
		return
	end

	-- refresh the tab
	SettingsWindow.ForceSelectTab(SettingsWindow.ActiveTab)
end

function SettingsWindow.UpdateKeyBindings()

	-- main container
	local parent = "SettingsList"

	-- scan all key bindings
	for key, binding in pairsByIndex(SettingsWindow.Keybindings) do

		-- do we have a valid type?
		if binding.type ~= nil then
			
			-- is this key changed?
			if binding.newValue ~= nil then
				
				-- update the key in the settings
				SystemData.Settings.Keybindings[binding.type] = binding.newValue

				-- remove the update value (so it won't update again unless the key changes again)
				binding.newValue = nil
			end
			
			-- get the element name
			local element = parent .. binding.name

			-- does the label exist?
			if DoesWindowExist(element) then

				-- reset the text color
				LabelSetTextColor(element .. "Value", 255, 255, 255 )

				-- update the key name
				LabelSetText(element .. "Value", SystemData.Settings.Keybindings[binding.type])
			end
		end
	end	

	-- update the weapon abilities if the window is open
	if WindowGetShowing("CharacterAbilities") then
		CharacterAbilities.UpdateWeaponAbilities()
	end

	-- update the player profile
	SettingsWindow.UpdateProfile()

	-- update the bindings for hotbars
	HotbarSystem.UpdateHotbars()

	-- update tab
	SettingsWindow.ForceSelectTab(SettingsWindow.ActiveTab)
end

function SettingsWindow.IntensInfoColorComboSelChanged(combo)

	-- get the color ID
	local color = ComboBoxGetSelectedMenuItem( combo )

	if not IsValidID(color) then
		color = 4
	end

	-- initialize the rgb variables
	local r, g, b

	-- red
	if (color == 1) then
		r = 255
		g = 0
		b = 0

	-- green
	elseif (color == 2) then
		r = 0
		g = 255
		b = 0

	-- blue
	elseif (color == 3) then
		r = 0
		g = 0
		b = 255

	-- yellow
	elseif (color == 4) then
		r = 255
		g = 255
		b = 0

	-- light blue
	elseif (color == 5) then
		r = 0
		g = 255
		b = 255

	-- fucsia
	elseif (color == 6) then
		r = 255
		g = 0
		b = 255

	-- white
	elseif (color == 7) then
		r = 255
		g = 255
		b = 255
	end
	return r, g, b
end

function SettingsWindow.ClearTempKeybindings()
	
	-- scan all the keybindings
	for key, binding in pairsByIndex(SettingsWindow.Keybindings) do

		-- nullify the change
		binding.newValue = nil
	end
end

function SettingsWindow.OnResetButton()

	-- create the dialog to reset all to default
	local okayButton = { textTid = UO_StandardDialog.TID_OKAY, callback = function() SettingsWindow.ClearTempKeybindings() BroadcastEvent( SystemData.Events.RESET_SETTINGS_TO_DEFAULT ) end }
	local cancelButton = { textTid = UO_StandardDialog.TID_CANCEL }
	local ResetConfirmWindow = 
	{
		windowName = "SettingsWindow", 
		titleTid = 1078994, 
		bodyTid = 1078995, 
		buttons = { okayButton, cancelButton },
		closeCallback = cancelButton.callback,
		destroyDuplicate = true,
	}
			
	UO_StandardDialog.CreateDialog( ResetConfirmWindow )
end

function SettingsWindow.UnloadWindow()

	-- unloading the tab
	SettingsWindow.UnloadTab(SettingsWindow.ActiveTab)
end

function SettingsWindow.OnHide()
	
	-- is the window showing and we're not recording keys?
	if WindowGetShowing("SettingsWindow") and not SettingsWindow.RecordingKey then

		-- Close the window		
		ToggleWindowByName("SettingsWindow")

		-- clear the window
		SettingsWindow.UnloadWindow()
	end
end

function SettingsWindow.OnResetUILocButton()	

	-- reset all windows positions
	WindowUtils.ForceResetWindowPositions()	

	-- reset the initial positions flag
	Interface.InitialPositions = nil

	-- delete the saved initial position value
	Interface.DeleteSetting("InitialPositions" )

	-- reload the UI
	InterfaceCore.ReloadUI()
end

function SettingsWindow.OnKeyPicked()
	
	-- main container
	local parent = "SettingsList"
	
	-- is this the mount/dismount hotkey?
	if SystemData.ActiveWindow.name == parent .. "MountDismount" then

		-- enable the recording for the mount blockbar
		Hotbar.RecordingSlot = 1
		Hotbar.RecordingHotbar = Interface.MountBlockbar
		Hotbar.RecordingKey = true
		SettingsWindow.RecordingKey = true
		BroadcastEvent( SystemData.Events.INTERFACE_RECORD_KEY )

	else -- scan the keybindings
		for key, binding in pairsByIndex(SettingsWindow.Keybindings) do
		
			-- is the active window the one to update?
			if SystemData.ActiveWindow.name == parent .. binding.name then
				SettingsWindow.CurKeyIndex = key
				break
			end
		end
		
		-- enable the recording 
		SettingsWindow.RecordingKey = true
		SystemData.IsRecordingSettings = true
		BroadcastEvent( SystemData.Events.INTERFACE_RECORD_KEY )
	end
end

function SettingsWindow.StartKeyRecording()	

	-- is the settings window visible?
	if not WindowGetShowing("SettingsWindow") then
		return
	end

	-- main container
	local parent = "SettingsList"

	-- is the recording active?
	if SettingsWindow.RecordingKey == true and not Hotbar.RecordingKey then

		-- get the current setting ID
		local keyIndex = SettingsWindow.CurKeyIndex

		-- get the element name
		local element = parent .. SettingsWindow.Keybindings[keyIndex].name

		-- does the label exist?
		if DoesWindowExist(element) then

			-- remove the highlight from the label
			LabelSetTextColor(element .. "Label", 250, 250, 0 )
			LabelSetTextColor(element .. "Value", 250, 250, 0 )
		end

		-- show the assign hotkey info tooltip
		WindowUtils.ShowAssignHotkeyInfo(element .. "Value")

	elseif SettingsWindow.RecordingKey == true and Hotbar.RecordingKey == true then -- mount/dismount
		
		-- get the element name
		local element = parent .. "MountDismount"

		-- does the label exist?
		if DoesWindowExist(element) then
			
			-- remove the highlight from the label
			LabelSetTextColor(element .. "Label", 250, 250, 0 )
			LabelSetTextColor(element .. "Value", 250, 250, 0 )
		end

		-- show the assign hotkey info tooltip
		WindowUtils.ShowAssignHotkeyInfo(element .. "Value")
	end
end

function SettingsWindow.KeyRecorded()	

	-- main container
	local parent = "SettingsList"

	-- is the recording active?
	if (SettingsWindow.RecordingKey == true) then

		local element

		-- is this the mount/dismount key?
		if Hotbar.RecordingHotbar == Interface.MountBlockbar then
			element = parent .. "MountDismount"
		
		else -- others hotkey
		
			-- get the element name
			element = parent .. SettingsWindow.Keybindings[SettingsWindow.CurKeyIndex].name
		end

		-- hide the hotkey recording info
		WindowSetShowing( "AssignHotkeyInfo", false )

		-- does the label exist?
		if DoesWindowExist(element) then

			-- remove the highlight
			LabelSetTextColor(element .. "Label", 153, 217, 234)
			LabelSetTextColor(element .. "Value", 255, 255, 255)
		end

		-- is this the mount/dismount button?
		if Hotbar.RecordingKey == true then

			-- let the hotbar function handle it
			Hotbar.KeyRecorded()

			-- remove the recording flags
			SettingsWindow.RecordingKey = false

			-- update the key value
			LabelSetText(element .. "Value", SystemData.Hotbar[Interface.MountBlockbar].Bindings[1])

			-- update the list
			SettingsWindow.ForceSelectTab(SettingsWindow.ActiveTab)
			
			return
		end

		-- do we have a key?
		if SystemData.RecordedKey ~= L"" then
			
			-- scan all keybindings
			for index, binding in pairsByIndex(SettingsWindow.Keybindings) do

				-- is this a valid keyginding?
				if binding.type ~= nil then
					
					-- get the current key
					local value = SystemData.Settings.Keybindings[binding.type]

					-- is this the key to change?
					if binding.newValue ~= nil then
						value = binding.newValue
					end
					
					-- is this settings using the same key we recorded? (and it's not the one we changed)
					if (value == SystemData.RecordedKey and index ~= SettingsWindow.CurKeyIndex) then
						
						-- mark this setting's key as conflicting
						SystemData.BindingConflictItemIndex = index
						SystemData.BindingConflictType = SystemData.BindType.BINDTYPE_SETTINGS
						break
					end
				end
			end
		end

		-- is this a setting key conflict?
		if SystemData.BindingConflictType == SystemData.BindType.BINDTYPE_SETTINGS then

			-- scan all keys to find the duplicate
			for type, key in pairs(SystemData.Settings.Keybindings) do

				-- is this the hotkey?
				if key == SystemData.RecordedKey then

					-- update the conflict item index
					_, SystemData.BindingConflictItemIndex = SettingsWindow.GetKeyBindingNameFromType(type)
					break
				end
			end
		end
		
		-- is this a conflicting key?
		if (SystemData.BindingConflictType ~= SystemData.BindType.BINDTYPE_NONE) then

			-- create the message box
			local body = GetStringFromTid(SettingsWindow.TID_BINDING_CONFLICT_BODY)..L"\n\n"..HotbarSystem.GetKeyName(SystemData.BindingConflictHotbarId, SystemData.BindingConflictItemIndex, SystemData.BindingConflictType)..L"\n\n"..GetStringFromTid(SettingsWindow.TID_BINDING_CONFLICT_QUESTION)
			
			-- on YES, we replace the key
			local yesButton = 
			{ 
				textTid = SettingsWindow.TID_YES,
				callback =	function()
								HotbarSystem.ReplaceKey(
								SystemData.BindingConflictHotbarId, SystemData.BindingConflictItemIndex, SystemData.BindingConflictType,
								0, SettingsWindow.CurKeyIndex, SystemData.BindType.BINDTYPE_SETTINGS,
								SystemData.RecordedKey, L"")
							end
			}

			-- on NO we do nothing
			local noButton = { textTid = SettingsWindow.TID_NO }

			-- fill the dialog data array
			local windowData = 
			{
				windowName = "SettingsWindow", 
				titleTid = SettingsWindow.TID_BINDING_CONFLICT_TITLE, 
				body = body, 
				buttons = { yesButton, noButton },
				closeCallback = noButton.callback,
				destroyDuplicate = true,
			}

			-- show the dialog
			UO_StandardDialog.CreateDialog( windowData )

		else -- no conflict? we update the key in the settings	
			SettingsWindow.Keybindings[SettingsWindow.CurKeyIndex].newValue = SystemData.RecordedKey

			-- update the labels
			SettingsWindow.UpdateKeyBindings()
			
			-- update the settings
			BroadcastEvent( SystemData.Events.KEYBINDINGS_UPDATED )

			-- update the bindings for hotbars
			HotbarSystem.UpdateHotbars()
		end
		
		-- remove the recording flags
		SystemData.IsRecordingSettings = false
		SettingsWindow.RecordingKey = false

		-- update the list
		SettingsWindow.ForceSelectTab(SettingsWindow.ActiveTab)
	end
end

function SettingsWindow.KeyCancelRecord()

	-- main container
	local parent = "SettingsList"

	-- is the recording active?
	if SettingsWindow.RecordingKey == true and Hotbar.RecordingKey == false then

		-- hide the recording info
		WindowSetShowing( "AssignHotkeyInfo", false )
		
		-- get the current setting ID
		local keyIndex = SettingsWindow.CurKeyIndex
		
		-- get the element name
		local element = parent .. SettingsWindow.Keybindings[keyIndex].name

		-- does the label exist?
		if DoesWindowExist(element) then

			-- remove the highlight from the label
			LabelSetTextColor(element .. "Label", 153, 217, 234 )
			LabelSetTextColor(element .. "Value", 255, 255, 255 )
		end

		-- remove the recording flags
		SystemData.IsRecordingSettings = false
		SettingsWindow.RecordingKey = false
	
	-- mount/dismount
	elseif SettingsWindow.RecordingKey == true and Hotbar.RecordingKey == true then
		
		-- main container
		local parent = "SettingsList"
		
		-- current element name
		local element = parent .. "MountDismount"
		
		-- does the label exist?
		if DoesWindowExist(element) then

			-- remove the highlight from the label
			LabelSetTextColor(element .. "Label", 153, 217, 234 )
			LabelSetTextColor(element .. "Value", 255, 255, 255 )
		end

		-- disable recording
		Hotbar.KeyCancelRecord()

		-- remove the recording flags
		SystemData.IsRecordingSettings = false
		SettingsWindow.RecordingKey = false
	end
end

function SettingsWindow.OnIgnoreListAddButton()

	-- initialize the ignore list
	StartIgnoreListAdd(SettingsWindow.IGNORE_LIST_ALL)

	--hide the settings window and main menu window so player can pick something on screen	
	WindowSetShowing("SettingsWindow", false)
	WindowSetShowing("MainMenuWindow", false)

	-- show the settings again when the targeting has been done
	Interface.ExecuteWhenAvailable({ name = "SettingsIgnorePlayer", check = function() return not DoesPlayerHasCursorTarget() end, callback = function() WindowSetShowing("SettingsWindow", true) SettingsWindow.ForceSelectTab(10) end, removeOnComplete = true })
end

function SettingsWindow.OnIgnoreConfListAddButton()

	-- initialize the ignore list
	StartIgnoreListAdd(SettingsWindow.IGNORE_LIST_CONF)

	-- hide the settings window and main menu window so player can pick something on screen	
	WindowSetShowing("SettingsWindow", false)
	WindowSetShowing("MainMenuWindow", false)

	-- show the settings again when the targeting has been done
	Interface.ExecuteWhenAvailable({ name = "SettingsIgnorePlayer", check = function() return not DoesPlayerHasCursorTarget() end, callback = function() WindowSetShowing("SettingsWindow", true) SettingsWindow.ForceSelectTab(10) end, removeOnComplete = true })
end

function SettingsWindow.ProfanityListUpdated()
	
	-- the player has aquired the target so we can show the settings again
	WindowSetShowing("SettingsWindow", true)

	-- update the list
	SettingsWindow.ForceSelectTab(SettingsWindow.ActiveTab)
end

function SettingsWindow.DeleteIgnoreList()

	-- parent window name
	local parent = "SettingsList"

	-- delete container
	if DoesWindowExist(parent .. "IgnorePlayers") then
		DestroyWindow(parent .. "IgnorePlayers")
	end

	-- clear ignore list
	for i = 1, SettingsWindow.PreviousIgnoreListCount do
		
		-- current item name
		local item = parent .. "IgnorePlayers" .. "IgnoreListItem" .. i

		-- destroy the item if exist
		if DoesWindowExist(item) then
			DestroyWindow(item)
		end
	end

	-- reset the counter
	SettingsWindow.PreviousIgnoreListCount = 0

	-- delete line
	if DoesWindowExist(parent .. "IgnorePlayers" .. "VLine") then
		DestroyWindow(parent .. "IgnorePlayers" .. "VLine")
	end

	-- delete container
	if DoesWindowExist(parent .. "IgnoreChat") then
		DestroyWindow(parent .. "IgnoreChat")
	end

	-- clear conf ignore list
	for i = 1, SettingsWindow.PreviousIgnoreConfListCount do
		
		-- current item name
		local item = parent .. "IgnoreChat" .. "IgnoreListItem" .. i

		-- destroy the item if exist
		if DoesWindowExist(item) then
			DestroyWindow(item)
		end
	end

	-- reset the counter
	SettingsWindow.PreviousIgnoreConfListCount = 0
end

function SettingsWindow.PopulateProfanityList(subsection)

	-- do we have a valid subsection window?
	if not IsValidString(subsection) or not DoesWindowExist(subsection) then
		return
	end

	-- delete all existing items
	SettingsWindow.DeleteIgnoreList()

	-- parent window to anchor the items
	local parent = "SettingsList"
	
	-- parent for ignore players
	local ignParent = parent .. "IgnorePlayers"

	-- create the container window
	CreateWindowFromTemplate( ignParent, "EmptyContainerWindow", parent )
	
	-- reset the container anchors
	WindowClearAnchors(ignParent)

	-- anchor the container window to the subsection
	WindowAddAnchor( ignParent, "bottomleft", subsection, "topleft", 0, 20 )

	-- initialize previous item
	local previousListItem

	-- scan all ignored players
	for i = 1, WindowData.IgnoreListCount do

		-- current item name
		local item = ignParent .. "IgnoreListItem" .. i

		-- create item
		CreateWindowFromTemplate( item, "IgnoreListItem", ignParent )

		-- reset the item anchors
		WindowClearAnchors(item)

		-- is this the first item?
		if i == 1 then
			
			-- anchor to the top
			WindowAddAnchor(item, "topleft", ignParent, "topleft", 0, 10)

		else -- anchor to the previous item
			WindowAddAnchor(item, "bottomleft", previousListItem, "topleft", 0, 10)
		end

		-- fill the label
		LabelSetText(item, L"- " .. WindowData.IgnoreNameList[i])

		-- update the previous item name
		previousListItem = item
	end

	-- update the items count
	SettingsWindow.PreviousIgnoreListCount = WindowData.IgnoreListCount
	
	-- update the container size
	WindowSetDimensions(ignParent, 320, (26 * SettingsWindow.PreviousIgnoreListCount) + 10)

		-- create vertical line
	CreateWindowFromTemplate(ignParent .. "VLine", "VerticalLine", parent)

	-- reset the container anchors
	WindowClearAnchors(ignParent .. "VLine")

	-- anchor the container window to the subsection
	WindowAddAnchor( ignParent .. "VLine", "topright", ignParent, "topleft", -10, 0 )
	WindowAddAnchor( ignParent .. "VLine", "bottomright", ignParent, "bottomleft", -10, 0 )

	-- parent for ignore chat players
	local ignChatParent = parent .. "IgnoreChat"

	-- create the container window
	CreateWindowFromTemplate( ignChatParent, "EmptyContainerWindow", parent )
	
	-- reset the container anchors
	WindowClearAnchors(ignChatParent)

	-- anchor the container window to the subsection
	WindowAddAnchor( ignChatParent, "topright", ignParent, "topleft", 10, 0 )

	-- scan all ignored chat players
	for i = 1, WindowData.IgnoreConfListCount do

		-- current item name
		local item = ignChatParent .. "IgnoreConfListItem" .. i

		-- create the item
		CreateWindowFromTemplate(item, "IgnoreConfListItem", ignChatParent )
		
		-- reset the item anchors
		WindowClearAnchors(item)

		-- is this the first item?
		if i == 1 then

			-- anchor to the top
			WindowAddAnchor(item, "topleft", ignChatParent, "topleft", 0, 10)

		else -- anchor to the previous item
			WindowAddAnchor(item, "bottomleft", previousListItem, "topleft", 0, 10)
		end

		-- fill the label
		LabelSetText(item, L"- " .. WindowData.IgnoreConfNameList[i] )

		-- update the previous item name
		previousListItem = item
	end

	-- update the items count
	SettingsWindow.PreviousIgnoreConfListCount = WindowData.IgnoreConfListCount

	-- update the container size
	WindowSetDimensions(ignChatParent, 330, (26 * SettingsWindow.PreviousIgnoreConfListCount) + 10)

	-- force process anchors or the measurement will be wrong
	WindowForceProcessAnchors(ignChatParent)
	
	-- return the longest list (so we can resize the window properly)
	if SettingsWindow.PreviousIgnoreListCount > SettingsWindow.PreviousIgnoreConfListCount then
		return ignParent
	else
		return ignChatParent
	end
end

function SettingsWindow.OnIgnoreListDeleteButton()
	
	-- do we have a label selected?
	if SettingsWindow.CurIgnoreListIdx == -1 then
		return
	end

	-- get the ID of the ignored player
	local id = WindowData.IgnoreIdList[SettingsWindow.CurIgnoreListIdx]
	
	-- remove the player from the list
	DeleteFromIgnoreList( id, SettingsWindow.IGNORE_LIST_ALL )

	-- reset the selected label
	SettingsWindow.CurIgnoreListIdx = -1

	-- update the list
	Interface.AddTodoList({name = "update ignore players list", func = function() SettingsWindow.ForceSelectTab(SettingsWindow.ActiveTab) end, time = Interface.TimeSinceLogin + 0.1})
end

function SettingsWindow.OnIgnoreConfListDeleteButton()

	-- do we have a label selected?
	if SettingsWindow.CurIgnoreConfListIdx == -1 then
		return
	end

	-- get the ID of the ignored player
	local id = WindowData.IgnoreConfIdList[SettingsWindow.CurIgnoreConfListIdx]

	-- remove the player from the list
	DeleteFromIgnoreList( id, SettingsWindow.IGNORE_LIST_CONF )

	-- reset the selected label
	SettingsWindow.CurIgnoreConfListIdx = -1

	-- update the list
	Interface.AddTodoList({name = "settings delayed tab update", func = function() SettingsWindow.ForceSelectTab(SettingsWindow.ActiveTab) end, time = Interface.TimeSinceLogin + 0.1})
end

function SettingsWindow.OnIgnoreListChatListButton()
	SettingsWindow.ignoreListType = SettingsWindow.IGNORE_LIST_ALL
	CreateWindow("IgnoreWindow", true)
end

function SettingsWindow.OnIgnoreConfListChatListButton()
	SettingsWindow.ignoreListType = SettingsWindow.IGNORE_LIST_CONF
	CreateWindow("IgnoreWindow", true)
end

function SettingsWindow.OnIgnoreListItemClicked()

	-- main parent window
	local parent = "SettingsList"

	-- parent for ignore chat players
	local ignParent = parent .. "IgnorePlayers"

	-- scan all the ignore players
	for i = 1, WindowData.IgnoreListCount do
		
		-- current item name
		local item = ignParent .. "IgnoreListItem" .. i

		-- reset the label color
		LabelSetTextColor(item, 255, 255, 255)

		-- is this the selected label?
		if SystemData.ActiveWindow.name == item then

			-- store the index
			SettingsWindow.CurIgnoreListIdx = i
		end
	end

	-- highlight the label
	LabelSetTextColor(SystemData.ActiveWindow.name, 250, 250, 0)
end

function SettingsWindow.OnIgnoreConfListItemClicked()
	
	-- main parent window
	local parent = "SettingsList"

	-- parent for ignore chat players
	local ignChatParent = parent .. "IgnoreChat"

	-- scan all ignored chat players
	for i = 1, WindowData.IgnoreConfListCount do
		
		-- current item name
		local item = ignChatParent .. "IgnoreConfListItem" .. i

		-- reset the label color
		LabelSetTextColor(item, 255, 255, 255 )

		-- is this the selected label?
		if SystemData.ActiveWindow.name == item then

			-- store the index
			SettingsWindow.CurIgnoreConfListIdx = i
		end
	end

	-- highlight the label
	LabelSetTextColor( SystemData.ActiveWindow.name, 250, 250, 0 )
end

function SettingsWindow.OnShowResetLegacyDialog()
	if (ButtonGetPressedFlag( "LegacyChatButton" )== true) then
		local yesButton = { textTid = SettingsWindow.TID_YES, callback = function()SettingsWindow.ResetLegacyKeyBindings()end }
		local noButton = { textTid = SettingsWindow.TID_NO }
		local windowData = 
		{
			windowName = "Root", 
			titleTid = SettingsWindow.TID_INFO, 
			bodyTid = SettingsWindow.TID_RESETLEGACYBINDINGS_CHAT, 
			buttons = { yesButton, noButton },
			closeCallback = noButton.callback,
			destroyDuplicate = true,
		}
		UO_StandardDialog.CreateDialog( windowData )	 
	end
end

function SettingsWindow.LegacyTargetingButtonOnLButtonUp()
	SettingsWindow.ResetScrollWheelOptions()
end

function SettingsWindow.LabelOnMouseOver()

	-- get the window name
	local windowName = SystemData.ActiveWindow.name

	-- get the tooltip TID
	local detailTID = WindowGetId(windowName)
	
	-- do we have a TID?
	if not IsValidID(detailTID) then

		-- try to get the parent TID
		detailTID = WindowGetId(WindowGetParent(windowName))
	end
	
	-- do we have a valid TID?
	if IsValidID(detailTID) then

		-- get the TID string
		local text = GetStringFromTid(detailTID)

		-- create the tooltip
		Tooltips.CreateTextOnlyTooltip(windowName, text)
	end 
end

function SettingsWindow.ImportMouseOver()

	-- get the window name
	local windowName = SystemData.ActiveWindow.name

	-- get the exporter character name
	local name = Interface.ExportedSettings.name

	-- create the tooltip text
	local text = ReplaceTokens(GetStringFromTid(302), {towstring( name ) } ) 

	-- create the tooltip
	Tooltips.CreateTextOnlyTooltip(windowName, text)
end

function SettingsWindow.OnSelChanged()
	
	-- current window name
	local this = SystemData.ActiveWindow.name

	-- main container
	local parent = "SettingsList"
	
	-- container window
	local currentParent = WindowGetParent(this)
	
	-- remove the parent from the window name to obtain the object name
	local varName = string.gsub(currentParent, parent, "")

	-- get the setting type
	local variableName, settingType = SettingsWindow.GetVariableName(varName)

	-- get the new combo value
	local selectedValue = ComboBoxGetSelectedMenuItem(this)

	-- run the function to save the value based on the variables
	if settingType == SettingsWindow.VariableType.FULLSCREENRES then
		SettingsWindow.SetCurrentResolution(selectedValue)

	elseif settingType == SettingsWindow.VariableType.MAXFRAMERATE then
		SettingsWindow.SetCurrentMaxFramerate(selectedValue)

	elseif settingType == SettingsWindow.VariableType.VALUEPLUSONE then
		selectedValue = selectedValue - 1

		-- update the variable value
		SetDynamicVariableValue(variableName, selectedValue)

		-- update the player profile
		SettingsWindow.UpdateProfile()

	elseif settingType == SettingsWindow.VariableType.SCROLLWHEELUP then
		SettingsWindow.SetCurrentScrollUpSetting(selectedValue)

	elseif settingType == SettingsWindow.VariableType.SCROLLWHEELDOWN then
		SettingsWindow.SetCurrentScrollDownSetting(selectedValue)

	elseif settingType == SettingsWindow.VariableType.LANGUAGE then
		SettingsWindow.SetCurrentLanguage(selectedValue)

	elseif settingType == SettingsWindow.VariableType.CUSTOMUI then
		SettingsWindow.SetCurrentUI(selectedValue)

	elseif settingType == SettingsWindow.VariableType.OBJECTHANDLESIZE then
		SettingsWindow.SetCurrentObjectHandleSize(selectedValue)

	elseif settingType == SettingsWindow.VariableType.LOWHP then
		SettingsWindow.SetCurrentLowHP(selectedValue)

	elseif settingType == SettingsWindow.VariableType.LOWHPPET then
		SettingsWindow.SetCurrentLowHPPet(selectedValue)

	elseif settingType == SettingsWindow.VariableType.BACKPACKSTYLE then
		SettingsWindow.SetCurrentBackpackStyle(selectedValue)

	elseif settingType == SettingsWindow.VariableType.CONTAINERVIEW then
		SettingsWindow.SetCurrentContainerView(selectedValue)

	elseif settingType == SettingsWindow.VariableType.CORPSEVIEW then
		SettingsWindow.SetCurrentCorpseView(selectedValue)

	elseif settingType == SettingsWindow.VariableType.VENDORVIEW then
		SettingsWindow.SetCurrentVendorView(selectedValue)

	elseif settingType == SettingsWindow.VariableType.STATUSSTYLE then
		SettingsWindow.SetCurrentStatusStyle(selectedValue)

	elseif settingType == SettingsWindow.VariableType.SHOWNAMES then
		SettingsWindow.SetCurrentShowNames(selectedValue)

	-- healthbars buttons
	elseif settingType == SettingsWindow.VariableType.HEALTHBARBUTTON then
	
		-- array for the sorted spells
		local sortedSpells = SettingsWindow.GetSortedSpellsTable()

		-- have we selected a spell?
		if selectedValue > 1 then
		
			-- get the spell ID
			selectedValue = SpellsInfo.SpellsData[sortedSpells[selectedValue]].id

		else -- default spell ID for NONE is 0
			selectedValue = 0
		end

		-- is this the first button?
		if string.find(SystemData.ActiveWindow.name, "Combo1", 1, true) then

			-- append the index of the variable
			variableName = variableName .. "1"

		-- is this the second button?
		elseif string.find(SystemData.ActiveWindow.name, "Combo2", 1, true) then

			-- append the index of the variable
			variableName = variableName .. "2"
		-- is this the third button?
		elseif string.find(SystemData.ActiveWindow.name, "Combo3", 1, true) then

			-- append the index of the variable
			variableName = variableName .. "3"
		end

		-- update the variable value
		SetDynamicVariableValue(variableName, selectedValue)

		-- get the variable name by removing "Interface.Settings."
		local saveName = string.gsub(variableName, "Interface.Settings.", "")

		-- save the setting
		Interface.SaveSetting(saveName, selectedValue)

		-- update the player profile
		SettingsWindow.UpdateProfile()

	-- default client variables
	elseif settingType == SettingsWindow.VariableType.DEFAULT then

		-- update the variable value
		SetDynamicVariableValue(variableName, selectedValue)

		-- update the player profile
		SettingsWindow.UpdateProfile()

	-- UI variables
	elseif settingType == SettingsWindow.VariableType.UI then

		-- update the variable value
		SetDynamicVariableValue(variableName, checkValue)
		
		-- get the variable name by removing "Interface.Settings."
		local saveName = string.gsub(variableName, "Interface.Settings.", "")
		
		-- save the setting
		Interface.SaveSetting( saveName, selectedValue )

		-- update the player profile
		SettingsWindow.UpdateProfile()
	end

	-- intensity info color
	if variableName == "Interface.Settings.IntensInfoColorID" then

		-- coloring the slot
		WindowSetTintColor(currentParent .. "Color", SettingsWindow.IntensInfoColorComboSelChanged(this))
	end
end

function SettingsWindow.ForgeRadioHandler()
	
	-- current window name
	local windowName = SystemData.ActiveWindow.name

	-- main container
	local parent = "SettingsList"

	-- get the setting type
	local variableName = SettingsWindow.GetVariableName("NormalForge")

	-- FORGE TYPE
	if (string.find(windowName, "NormalForge", 1, true)) then
		ButtonSetPressedFlag( parent .. "NormalForgeButton", true )
		ButtonSetPressedFlag( parent .. "TerMurForgeButton", false )
		ButtonSetPressedFlag( parent .. "QueenForgeButton", false )

		-- variable value
		local value = ItemPropertiesInfo.FORGE_Plain

		-- update the variable value
		SetDynamicVariableValue(variableName, value)

		-- get the variable name by removing "Interface.Settings."
		local saveName = string.gsub(variableName, "Interface.Settings.", "")
		
		-- save the setting
		Interface.SaveSetting( saveName, value )
		
		-- update the player profile
		SettingsWindow.UpdateProfile()

		return true

	elseif (string.find(windowName, "TerMurForge", 1, true)) then
		ButtonSetPressedFlag( parent .. "NormalForgeButton", false )
		ButtonSetPressedFlag( parent .. "TerMurForgeButton", true )
		ButtonSetPressedFlag( parent .. "QueenForgeButton", false )

		-- variable value
		local value = ItemPropertiesInfo.FORGE_TerMur

		-- update the variable value
		SetDynamicVariableValue(variableName, value)

		-- get the variable name by removing "Interface.Settings."
		local saveName = string.gsub(variableName, "Interface.Settings.", "")
		
		-- save the setting
		Interface.SaveSetting( saveName, value )
		
		-- update the player profile
		SettingsWindow.UpdateProfile()

		return true
	
	elseif (string.find(windowName,"QueenForge", 1, true)) then
		ButtonSetPressedFlag( parent .. "NormalForgeButton", false )
		ButtonSetPressedFlag( parent .. "TerMurForgeButton", false )
		ButtonSetPressedFlag( parent .. "QueenForgeButton", true )

		-- variable value
		local value = ItemPropertiesInfo.FORGE_Queen

		-- update the variable value
		SetDynamicVariableValue(variableName, value)

		-- get the variable name by removing "Interface.Settings."
		local saveName = string.gsub(variableName, "Interface.Settings.", "")
		
		-- save the setting
		Interface.SaveSetting( saveName, value )
		
		-- update the player profile
		SettingsWindow.UpdateProfile()

		return true
	end
end

function SettingsWindow.CharRaceRadioHandler()

	-- current window name
	local windowName = SystemData.ActiveWindow.name

	-- main container
	local parent = "SettingsList"

	-- get the setting type
	local variableName = SettingsWindow.GetVariableName("NormalChar")

	-- CHAR TYPE
	if (string.find(windowName, "NormalChar", 1, true)) then
		ButtonSetPressedFlag( parent .. "NormalCharButton", true )
		ButtonSetPressedFlag( parent .. "GargCharButton", false )
		
		-- variable value
		local value = ItemPropertiesInfo.RACE_Any

		-- update the variable value
		SetDynamicVariableValue(variableName, value)

		-- get the variable name by removing "Interface.Settings."
		local saveName = string.gsub(variableName, "Interface.Settings.", "")
		
		-- save the setting
		Interface.SaveSetting( saveName, value )
		
		-- update the player profile
		SettingsWindow.UpdateProfile()

		return true

	elseif (string.find(windowName, "GargChar", 1, true)) then
		ButtonSetPressedFlag( parent .. "NormalCharButton", false )
		ButtonSetPressedFlag( parent .. "GargCharButton", true )

		-- variable value
		local value = ItemPropertiesInfo.RACE_Gargoyle

		-- update the variable value
		SetDynamicVariableValue(variableName, value)

		-- get the variable name by removing "Interface.Settings."
		local saveName = string.gsub(variableName, "Interface.Settings.", "")
		
		-- save the setting
		Interface.SaveSetting( saveName, value )
		
		-- update the player profile
		SettingsWindow.UpdateProfile()

		return true
	end
end

function SettingsWindow.CascadeRadioHandler()
	
	-- current window name
	local windowName = SystemData.ActiveWindow.name

	-- main container
	local parent = "SettingsListCascadeSetting"
	
	-- get the setting type
	local variableName = SettingsWindow.GetVariableName("CascadeSetting")

	-- handle the cascade radio
	if (string.find(windowName, "TOPLEFT", 1, true)) then
		ButtonSetPressedFlag( parent .. "TOPLEFT", true )
		ButtonSetPressedFlag( parent .. "TOPRIGHT", false )
		ButtonSetPressedFlag( parent .. "BOTTOMLEFT", false )
		ButtonSetPressedFlag( parent .. "BOTTOMRIGHT", false )
		ButtonSetPressedFlag( parent .. "RANDOMButton", false )

		-- variable value
		local value = 0

		-- update the variable value
		SetDynamicVariableValue(variableName, value)

		-- get the variable name by removing "Interface.Settings."
		local saveName = string.gsub(variableName, "Interface.Settings.", "")
		
		-- save the setting
		Interface.SaveSetting( saveName, value )
		
		-- update the player profile
		SettingsWindow.UpdateProfile()

		return true
		
	elseif (string.find(windowName, "TOPRIGHT", 1, true)) then
		ButtonSetPressedFlag( parent .. "TOPLEFT", false )
		ButtonSetPressedFlag( parent .. "TOPRIGHT", true )
		ButtonSetPressedFlag( parent .. "BOTTOMLEFT", false )
		ButtonSetPressedFlag( parent .. "BOTTOMRIGHT", false )
		ButtonSetPressedFlag( parent .. "RANDOMButton", false )

		-- variable value
		local value = 1

		-- update the variable value
		SetDynamicVariableValue(variableName, value)

		-- get the variable name by removing "Interface.Settings."
		local saveName = string.gsub(variableName, "Interface.Settings.", "")
		
		-- save the setting
		Interface.SaveSetting( saveName, value )
		
		-- update the player profile
		SettingsWindow.UpdateProfile()

		return true
		
	elseif (string.find(windowName, "BOTTOMLEFT", 1, true)) then
		ButtonSetPressedFlag( parent .. "TOPLEFT", false )
		ButtonSetPressedFlag( parent .. "TOPRIGHT", false )
		ButtonSetPressedFlag( parent .. "BOTTOMLEFT", true )
		ButtonSetPressedFlag( parent .. "BOTTOMRIGHT", false )
		ButtonSetPressedFlag( parent .. "RANDOMButton", false )

		-- variable value
		local value = 2
		
		-- update the variable value
		SetDynamicVariableValue(variableName, value)

		-- get the variable name by removing "Interface.Settings."
		local saveName = string.gsub(variableName, "Interface.Settings.", "")
		
		-- save the setting
		Interface.SaveSetting( saveName, value )
		
		-- update the player profile
		SettingsWindow.UpdateProfile()

		return true
		
	elseif (string.find(windowName, "BOTTOMRIGHT", 1, true)) then
		ButtonSetPressedFlag( parent .. "TOPLEFT", false )
		ButtonSetPressedFlag( parent .. "TOPRIGHT", false )
		ButtonSetPressedFlag( parent .. "BOTTOMLEFT", false )
		ButtonSetPressedFlag( parent .. "BOTTOMRIGHT", true )
		ButtonSetPressedFlag( parent .. "RANDOMButton", false )

		-- variable value
		local value = 3

		-- update the variable value
		SetDynamicVariableValue(variableName, value)

		-- update the player profile
		SettingsWindow.UpdateProfile()

		return true
		
	elseif (string.find(windowName, "RANDOM", 1, true)) then
		ButtonSetPressedFlag( parent .. "TOPLEFT", false )
		ButtonSetPressedFlag( parent .. "TOPRIGHT",	false )
		ButtonSetPressedFlag( parent .. "BOTTOMLEFT", false )
		ButtonSetPressedFlag( parent .. "BOTTOMRIGHT", false )
		ButtonSetPressedFlag( parent .. "RANDOMButton",	true )

		-- variable value
		local value = 4

		-- update the variable value
		SetDynamicVariableValue(variableName, value)

		-- get the variable name by removing "Interface.Settings."
		local saveName = string.gsub(variableName, "Interface.Settings.", "")
		
		-- save the setting
		Interface.SaveSetting( saveName, value )

		-- update the player profile
		SettingsWindow.UpdateProfile()

		return true
	end
end

function SettingsWindow.Check()
	
	-- get the current checkbox window name
	local win = string.gsub(SystemData.ActiveWindow.name, "Label", "Button")

	-- inverting the checkbox value
	ButtonSetPressedFlag( win, not ButtonGetPressedFlag( win ))

	-- parse the check value
	SettingsWindow.CheckEnable(win)
end

function SettingsWindow.CheckEnable()

	-- current window name
	local this = SystemData.ActiveWindow.name
	this = string.gsub(this, "Label", "Button")

	-- handle the radio buttons, if handled, they return true and we can get out
	if SettingsWindow.ForgeRadioHandler() then
		return

	elseif SettingsWindow.CharRaceRadioHandler() then
		return

	elseif SettingsWindow.CascadeRadioHandler() then
		return
	end

	-- main container
	local parent = "SettingsList"
	
	local currentParent = WindowGetParent(this)

	-- remove the parent from the window name to obtain the object name
	local varName = string.gsub(currentParent, parent, "")
	
	-- get the setting type
	local variableName, settingType, updateFunc = SettingsWindow.GetVariableName(varName)
	
	-- do we have the variable name? if not this could be a nested object
	if not variableName then
	
		-- get the parent of this item
		currentParent = WindowGetParent(currentParent)

		-- remove the parent from the window name to obtain the object name
		varName = string.gsub(currentParent, parent, "")

		-- retry to get the variable name, if it fails again there is nothing else to do, unless we handle it manually...
		variableName, settingType, updateFunc = SettingsWindow.GetVariableName(varName)
	end

	-- generate an error if we can't identify the setting variable
	if not variableName then
		Debug.Print("Can't identify setting for: " .. varName)
		return
	end

	-- get the button flag
	local checkValue = ButtonGetPressedFlag( this )
	
	-- update the windowed fullscreen value
	if settingType == SettingsWindow.VariableType.WINDOWEDFULLSCREEN then
		SettingsWindow.SetCurrentWindowedFullScreen(checkValue)

	elseif settingType == SettingsWindow.VariableType.VOLUME then
		variableName = variableName .. ".enabled"
		
		-- update the variable value
		SetDynamicVariableValue(variableName, checkValue)

		-- EC PlaySound
		if not string.find(variableName, "SystemData.Settings.Sound", 1, true) then

			-- get the variable name by removing "Interface.Settings."
			local saveName = string.gsub(variableName, "Interface.", "")
		
			-- save the setting
			Interface.SaveSetting( saveName, checkValue )
		end

		-- is this the EC Playsound music?
		if string.find(variableName, "ECMusic", 1, true) then

			-- store the real setting value for EC Music
			Interface.ECMusic.trueValue = Interface.ECMusic.enabled
		end

		-- update the player profile
		SettingsWindow.UpdateProfile()

	elseif settingType == SettingsWindow.VariableType.DEFAULT then

		-- update the variable value
		SetDynamicVariableValue(variableName, checkValue)

		-- update the player profile
		SettingsWindow.UpdateProfile()

	elseif settingType == SettingsWindow.VariableType.UI then

		-- update the variable value
		SetDynamicVariableValue(variableName, checkValue)
		
		-- get the variable name by removing "Interface.Settings."
		local saveName = string.gsub(variableName, "Interface.Settings.", "")
		
		-- save the setting
		Interface.SaveSetting( saveName, checkValue )

		-- update the player profile
		SettingsWindow.UpdateProfile()
	end

	-- do we have a function to execute after saving?
	if updateFunc then
		pcall(updateFunc)
	end

	-- update the list
	Interface.AddTodoList({name = "settings delayed tab update", func = function() SettingsWindow.ForceSelectTab(SettingsWindow.ActiveTab) end, time = Interface.TimeSinceLogin + 0.1})
end

function SettingsWindow.DestroyContainers()

	-- scan all open containers
	for id, value in pairs(ContainerWindow.OpenContainers) do

		-- get the window name
		local windowName = "ContainerWindow_" .. id

		-- close the container if the window exist
		if DoesWindowExist(windowName) then
			DestroyWindow(windowName)
		end
	end
end

function SettingsWindow.DestroyPlayerBackpack()

	-- get the window name
	local windowName = "ContainerWindow_"..ContainerWindow.PlayerBackpack

	-- close the container if the window exist
	if DoesWindowExist(windowName) then
		DestroyWindow(windowName)
	end
end

function SettingsWindow.UpdateGridcontainers()
	
	-- scan all container views
	for id, value in pairs(ContainerWindow.ViewModes) do
		
		-- is this container in grid mode?
		if ContainerWindow.ViewModes[id] == "Grid" then
			
			-- re-create the container
			ContainerWindow.CreateContainer(windowName, true)

			-- set the dirty flag
			ContainerWindow.OpenContainers[id].dirty = true	
		end
	end
end

function SettingsWindow.UpdateAllContainers()
	
	-- scan all open containers
	for id, value in pairs(ContainerWindow.OpenContainers) do

		-- set the dirty flag
		ContainerWindow.OpenContainers[id].dirty = true	
	end
end

function SettingsWindow.UpdateContainerView(containerType, newView)

	-- scan all container views
	for id, value in pairs(ContainerWindow.ViewModes) do

		-- get the containers info
		local containerData = ContainerWindow.OpenContainers[id]

		-- get the window name
		local windowName = "ContainerWindow_" .. id

		-- get the view style saved
		local savedView = Interface.LoadSetting(windowName .. "ViewMode", nil, "")

		if	(containerType == 1 and not savedView) or -- generic container
			(containerType == 2 and containerData.isCorpse) or -- corpse
			(containerType == 3 and containerData.isPlayerVendor) -- player vendors
		then
		
			-- update the view
			ContainerWindow.ViewModes[id] = newView

			if newView == "Grid" then
				
				-- re-create the container
				ContainerWindow.CreateContainer(windowName, true)
				
				-- is this NOT grid legacy? we have to fix the size (same as we did when we created the slots)
				if not Interface.Settings.GridLegacy then
					local minColumns = 5
					local grid_view_this = windowName.."GridView"
					local scrollbarWidth = WindowGetDimensions(grid_view_this.."Scrollbar")
					
					local slotSize = WindowGetDimensions(windowName.."GridViewSocket1")
							
					local minSize = (slotSize * minColumns) - scrollbarWidth
					if ContainerWindow.Grid_MinWidth * WindowGetScale(windowName) ~= minSize then
						ContainerWindow.Grid_MinWidth = minSize
					end
					
					minWidth = ContainerWindow.Grid_MinWidth
					minHeight = minWidth + slotSize - 10
					WindowSetDimensions(windowName, minWidth, minHeight)
					ContainerWindow.UpdateGridViewSockets(id)
				end

			-- is the new view list mode? 
			elseif newView == "List" then

				-- re-create the container
				ContainerWindow.CreateContainer(windowName, true)
				
				-- is this NOT grid legacy? we have to fix the size (same as we did when we created the slots)
				if not Interface.Settings.GridLegacy then
					local minWidth = ContainerWindow.List_MinWidth
					local minHeight = minWidth + (minWidth * 0.15)
					WindowSetDimensions(windowName, minWidth, minHeight)
					ContainerWindow.UpdateListView(id)
				end

			-- update to free form mode
			elseif newView == "Freeform" then
				ContainerWindow.SetLegacyContainer( id, true )
			end
		end
	end
end

function SettingsWindow.PickColor()

	-- color slot window name
	SettingsWindow.HuePickerWindow = SystemData.ActiveWindow.name

	-- main container
	local parent = "SettingsList"

	-- clean up the window name to get the color name
	local color = SystemData.ActiveWindow.name
	color = string.gsub(color, parent, "")
	color = string.gsub(color, "Button", "")
	color = string.gsub(color, "OverheadTextOptions", "")

	-- color name to parse
	SettingsWindow.HuePickerWindowRequest = color
	
	-- color table ids
	local defaultColors = {
		0, --HUE_NONE 
		34, --HUE_RED
		53, --HUE_YELLOW
		63, --HUE_GREEN
		89, --HUE_BLUE
		119, --HUE_PURPLE
		144, --HUE_ORANGE
		368, --HUE_GREEN_2
		946, --HUE_GREY
		}

	-- create the color table
	local hueTable = {}
	for idx, hue in pairs(defaultColors) do
		for i=0,8 do
			hueTable[(idx-1)*10+i+1] = hue+i
		end
	end
	
	-- default brightness
	local Brightness = 1

	-- create the color picker window
	CreateWindowFromTemplate( "ColorPicker", "ColorPickerWindowTemplate", "Root" )

	-- fix the color window layer
	WindowSetLayer( "ColorPicker", Window.Layers.SECONDARY	)

	-- initialize the colors table
	ColorPickerWindow.SetNumColorsPerRow(9)
	ColorPickerWindow.SetSwatchSize(30)
	ColorPickerWindow.SetWindowPadding(4, 4)
	
	-- show the frame?
	ColorPickerWindow.SetFrameEnabled(true)

	-- show the close button?
	ColorPickerWindow.SetCloseButtonEnabled(true)

	-- add the color table to the window
	ColorPickerWindow.SetColorTable(hueTable, "ColorPicker")

	-- draw the color table
	ColorPickerWindow.DrawColorTable("ColorPicker")

	-- set the function to use when the color has been picked
	ColorPickerWindow.SetAfterColorSelectionFunction(SettingsWindow.ColorPicked)

	-- get the colors window dimensions
	local w, h = WindowGetDimensions("ColorPicker")

	-- anchor the window to the color square
	WindowAddAnchor( "ColorPicker", "topleft", SettingsWindow.HuePickerWindow, "topleft", 25, - (h - 10))

	-- show the color picker
	WindowSetShowing( "ColorPicker", true )

	-- default selected color
	ColorPickerWindow.SelectColor("ColorPicker", 1)
end

function SettingsWindow.HueToRGBTable(hue)
	
	-- convert the hue into r, g, b
	local r, g, b = HueRGBAValue(hue)

	-- build the table
	return {r = r, g = g, b = b}
end

function SettingsWindow.ColorPicked()

	-- get the hue from the color picker window	
	local huePicked = ColorPickerWindow.colorSelected["ColorPicker"]

	-- convert the hue to rgb
	local rgb = SettingsWindow.HueToRGBTable(huePicked)

	-- finders keepers color pick
	if SettingsWindow.HuePickerWindowRequest == "FindersKeepersFKColor" then
		
		-- set the window ID with the hue ID
		WindowSetId(SettingsWindow.HuePickerWindowRequest, huePicked)

	else
		-- get the variable name
		local variable, settingType = SettingsWindow.GetVariableName(SettingsWindow.HuePickerWindowRequest)

		-- update the color
		SetDynamicVariableValue(variable, rgb)

		-- get the UI setting variable name
		local varName = string.gsub(variable, "Interface.Settings.", "")

		-- save the setting
		Interface.SaveSetting(varName, rgb)

		-- is this a hotbar color setting?
		if settingType == SettingsWindow.VariableType.HOTBARCOLOR then
		
			-- update the hotbar
			HotbarSystem.UpdateHotbars()

		-- is this a container color setting?
		elseif settingType == SettingsWindow.VariableType.CONTAINERCOLOR then

			-- close all containers
			SettingsWindow.UpdateGridcontainers()
		end	
	end

	-- coloring the slot
	WindowSetTintColor(SettingsWindow.HuePickerWindow, rgb.r, rgb.g, rgb.b)

	-- reset the color picker settings
	SettingsWindow.HuePickerWindowRequest= ""
	SettingsWindow.HuePickerWindow = ""

	-- destroy the color picker
	DestroyWindow("ColorPicker")

	-- save the profile
	SettingsWindow.UpdateProfile()
end

function SettingsWindow.IncreaseTextSize()

	-- increase the size of the overhead text
	Interface.Settings.OverhedTextSize = Interface.Settings.OverhedTextSize + 0.1
		
	-- the size can't go higher than 150%
	if (Interface.Settings.OverhedTextSize > 1.5) then
		Interface.Settings.OverhedTextSize = 1.5
	end

	-- save the new value
	Interface.SaveSetting("OverhedTextSize", Interface.Settings.OverhedTextSize)

	-- showing a test message overhead to show the new size
	SendOverheadText(GetStringFromTid(1155472), OverheadText.CustomMessageHues.PINK) -- TEST Message
end

function SettingsWindow.DecreaseTextSize()
	
	-- decrease the overhead text size
	Interface.Settings.OverhedTextSize = Interface.Settings.OverhedTextSize - 0.1
	
	-- the size can't go lower than 50%
	if (Interface.Settings.OverhedTextSize < 0.5) then
		Interface.Settings.OverhedTextSize = 0.5
	end

	-- save the new value
	Interface.SaveSetting("OverhedTextSize", Interface.Settings.OverhedTextSize)

	-- showing a test message overhead to show the new size
	SendOverheadText(GetStringFromTid(1155472), OverheadText.CustomMessageHues.PINK) -- TEST Message
end

function SettingsWindow.ChatFont()

	-- set the type setting on the font selector
	FontSelector.Selection = "chat"

	-- toggle the font selector window
	if (not DoesWindowExist("FontSelector")) then

		-- create the window if it doesn't exist
		CreateWindow("FontSelector", true)
	else
		WindowSetShowing("FontSelector", true)
	end
	
	-- update the font list
	FontSelector.OnShown()

	-- set the font selector title
	WindowUtils.SetWindowTitle("FontSelector", GetStringFromTid(1155347)) -- Overhead Chat Font
end

function SettingsWindow.NamesFont()

	-- set the type setting on the font selector
	FontSelector.Selection = "names"

	-- toggle the font selector window
	if (not DoesWindowExist("FontSelector")) then

		-- create the window if it doesn't exist
		CreateWindow("FontSelector", true)
	else
		WindowSetShowing("FontSelector", true)
	end

	-- update the font list
	FontSelector.OnShown()

	-- runic fonts disabled
	WindowSetShowing(FontSelector.RunicFontItem, false)

	-- set the font selector title
	WindowUtils.SetWindowTitle("FontSelector", GetStringFromTid(1155348)) -- Overhead Names Font
end

function SettingsWindow.SpellFont()

	-- set the type setting on the font selector
	FontSelector.Selection = "spells"

	-- toggle the font selector window
	if (not DoesWindowExist("FontSelector")) then

		-- create the window if it doesn't exist
		CreateWindow("FontSelector", true)
	else
		WindowSetShowing("FontSelector", true)
	end

	-- update the font list
	FontSelector.OnShown()

	-- runic fonts enabled if the overhead spell names are disabled
	WindowSetShowing(FontSelector.RunicFontItem, not Interface.Settings.ShowSpellName)

	-- set the font selector title
	WindowUtils.SetWindowTitle("FontSelector", GetStringFromTid(1155349))
end

function SettingsWindow.DamageFont()

	-- set the type setting on the font selector
	FontSelector.Selection = "damage"

	-- toggle the font selector window
	if (not DoesWindowExist("FontSelector")) then

		-- create the window if it doesn't exist
		CreateWindow("FontSelector", true)
	else
		WindowSetShowing("FontSelector", true)
	end

	-- update the font list
	FontSelector.OnShown()

	-- runic fonts disabled
	WindowSetShowing(FontSelector.RunicFontItem, false)

	-- set the font selector title
	WindowUtils.SetWindowTitle("FontSelector", GetStringFromTid(1155350))
end

function SettingsWindow.ItemMouseOver()

	-- current window name
	local this = SystemData.ActiveWindow.name

	-- label window name
	local parentLabel = WindowGetParent(this) .. "Label"
	
	-- highlight the up button
	if string.find(this, "UP", 1, true) then
		LabelSetTextColor(this.."Label",0,255,0)
		LabelSetTextColor(parentLabel,0,255,0)

	else -- unhighlight the up button
		LabelSetTextColor(this.."Label",255,0,0)
		LabelSetTextColor(parentLabel,255,0,0)
	end
end

function SettingsWindow.LootItemClearMouseOverItem()

	-- current window name
	local this = SystemData.ActiveWindow.name

	-- label window name
	local parentLabel = WindowGetParent(this) .. "Label"
	
	-- unhighlight the item name
	LabelSetTextColor(this .. "Label", 255, 255, 255)
	LabelSetTextColor(parentLabel, 255, 255, 255)
end

function SettingsWindow.DeleteLootList()

	-- parent window name
	local parent = "SettingsList"

	-- delete container
	if DoesWindowExist(parent .. "LootSort") then
		DestroyWindow(parent .. "LootSort")
	end

	parent = parent .. "LootSort"

	-- delete all the existing items
	for i = 1, 100 do

		-- current item name
		local item = parent .. "SettingLootItem_" .. i

		-- destroy the item if exist
		if DoesWindowExist(item) then
			DestroyWindow(item)
		end
	end
end

function SettingsWindow.UpdateLootItemsList(subsection)

	-- do we have a valid subsection window?
	if not IsValidString(subsection) or not DoesWindowExist(subsection) then
		return
	end
	
	-- has the loot sort been loaded yet?
	if not Interface.LootSortCustomized then
		Interface.LootSortOrder = CreateSaveStructureWithPlayerID(Interface.LootSortOrder)
		Interface.InitializeLootSort(true)
	end

	-- sort the array
	local sorted = {}
	for i = 1, 100 do
		local found = false
		for name, id in pairs(ItemPropertiesInfo.LootOrder) do
			if id == 999 or id == 0 then
				continue
			end
			if ItemPropertiesInfo.LootOrder[name] == i then
				table.insert(sorted, name)
				found = true
				break
			end
		end
		if not found then
			break
		end
	end

	-- delete all the existing loot items
	SettingsWindow.DeleteLootList()

	-- parent window to anchor the items
	local parent = "SettingsList"

	-- create the container window
	CreateWindowFromTemplate( parent .. "LootSort", "EmptyContainerWindow", parent )
	
	-- reset the container anchors
	WindowClearAnchors(parent .. "LootSort")

	-- anchor the container window to the subsection
	WindowAddAnchor( parent .. "LootSort", "bottomleft", subsection, "topleft", 0, 20 )

	-- update the parent name
	parent = parent .. "LootSort"
	
	-- elements count variable
	local count = 1

	-- scan all sorted items
	for id, name in pairsByKeys(sorted) do

		-- current item name
		local item = parent .. "SettingLootItem_" .. count

		-- previous item name
		local prevItem = parent .. "SettingLootItem_" .. count - 1
		
		-- create the item
		CreateWindowFromTemplate( item, "SettingsLootItem", parent )

		-- reset the item anchors
		WindowClearAnchors(item)

		-- is this the first item?
		if count == 1 then
			
			-- anchor it to the subsection
			WindowAddAnchor( item, "topleft", parent, "topleft", 0, 0 )

		else -- anchor the item to the previous one
			WindowAddAnchor( item, "bottomleft", prevItem, "topleft", 0, 5 )
		end

		-- formatting the name
		name = string.gsub(name, "_", " ")
		name = string.gsub(name, "Artifact", " Artifact")
		name = string.gsub(name, "Magic", " Magic Item")
		name = string.gsub(name, "Chest", " Chest")
		name = string.gsub(name, "Map", " Map")
		name = string.trim(name)
		name = id .. ". " .. name
		
		-- showing the item name
		LabelSetText(item .. "Label", towstring(name))
		
		-- if it's the first element we don't show the arrow up
		if count ~= 1 then
			
			-- show the arrow up
			LabelSetText(item .. "UPButtonLabel", L"▲")
		end

		-- if it's the last element we don't show the arrow down
		if count ~= #sorted then

			-- show the arrow down
			LabelSetText(item .. "DownButtonLabel", L"▼")
		end
		
		-- set the item id
		WindowSetId(item, id)
		
		-- increase the count counting
		count = count + 1
	end

	-- update the container size
	WindowSetDimensions(parent, 700, (20 * count))

	-- we return the height of the selection and the name of the last item
	return parent
end

function SettingsWindow.MoveLootItemUp()

	-- has the loot sort been loaded yet?
	if not Interface.LootSortCustomized then
		Interface.LootSortOrder = CreateSaveStructureWithPlayerID(Interface.LootSortOrder)
		Interface.InitializeLootSort(true)
	end

	-- current window name
	local this = WindowGetParent(SystemData.ActiveWindow.name)

	-- current item id
	local id = WindowGetId(this)

	-- switch the item with the previous one
	for name, currId in pairs(ItemPropertiesInfo.LootOrder) do
		if currId == id - 1 then
			ItemPropertiesInfo.LootOrder[name] = id
			continue
		end
		if currId == id then
			ItemPropertiesInfo.LootOrder[name] = id - 1
			continue
		end
	end
	
	-- play a sound for the button
	PlaySound(1, 251 ,WindowData.PlayerLocation.x, WindowData.PlayerLocation.y, WindowData.PlayerLocation.z)

	-- update the list
	SettingsWindow.ForceSelectTab(SettingsWindow.ActiveTab)
end

function SettingsWindow.MoveLootItemDown()
	
	-- has the loot sort been loaded yet?
	if not Interface.LootSortCustomized then
		Interface.LootSortOrder = CreateSaveStructureWithPlayerID(Interface.LootSortOrder)
		Interface.InitializeLootSort(true)
	end

	-- current window name
	local this = WindowGetParent(SystemData.ActiveWindow.name)

	-- current item id
	local id = WindowGetId(this)
	
	-- switch the item with the next one
	for name, currId in pairs(ItemPropertiesInfo.LootOrder) do
		if currId == id + 1 then
			ItemPropertiesInfo.LootOrder[name] = id
			continue
		end
		if currId == id then
			ItemPropertiesInfo.LootOrder[name] = id + 1
			continue
		end
	end

	-- play a sound for the button
	PlaySound(1, 250 ,WindowData.PlayerLocation.x, WindowData.PlayerLocation.y, WindowData.PlayerLocation.z)

	-- update the list
	SettingsWindow.ForceSelectTab(SettingsWindow.ActiveTab)
end

function SettingsWindow.FindersKeepersAddButton()

	-- show the finders keepers window
	WindowSetShowing("FindersKeepers", true)
end

function SettingsWindow.FindersKeepersImportButton()

	-- copy the finders keepers items
	FindersKeepers.ImportItems()

	-- update the list
	Interface.AddTodoList({name = "Update the tab after the import", func = function() SettingsWindow.ForceSelectTab(SettingsWindow.ActiveTab) end, time = Interface.TimeSinceLogin + 0.5})
end

function SettingsWindow.FindersKeepersImportMouseOver()

	-- get the window name
	local windowName = SystemData.ActiveWindow.name

	-- get the exporter character name
	local name = Interface.ExportedSettings.name

	-- create the tooltip text
	local text = ReplaceTokens(GetStringFromTid(520), { towstring(name) }) 

	-- create the tooltip
	Tooltips.CreateTextOnlyTooltip(windowName, text)
end

function SettingsWindow.FKItemLabelOnMouseOver()

	-- current window name
	local this = SystemData.ActiveWindow.name

	-- highlight the window
	LabelSetTextColor(this, 0, 255, 0)	
end

function SettingsWindow.FKItemClearMouseOverItem()

	-- current window name
	local this = SystemData.ActiveWindow.name

	-- current item text
	local itemName = LabelGetText(this)

	-- remove [Trash] from the name
	itemName = wstring.gsub(itemName, L"[(]Trash[)] ", L"")

	-- get the finders keepers data for the item
	local item = ContainerWindow.FindItems[itemName]

	-- get the item color
	local r, g, b = HueRGBAValue(item.hue)

	-- restore the label color
	LabelSetTextColor(this, r, g, b)
end

function SettingsWindow.OnShown()

	-- selecting the active tab
	SettingsWindow.ForceSelectTab(SettingsWindow.ActiveTab)

	-- we hide the import button if there is nothing to import
	if not Interface.ExportedSettings then
		WindowSetShowing("SettingsWindowImportButton", false)
	end
end

SettingsWindow.LastFoundIndex = 0
SettingsWindow.LastText = ""
function SettingsWindow.Search()
	
	-- get the text from the textbox
	local text = SearchBox.GetFilter("SettingsWindowSearchBox", true, true)

	-- is the text changed from the last search?
	if SettingsWindow.LastText ~= text then

		-- reset the last search data
		SettingsWindow.LastText = text
		SettingsWindow.LastFoundIndex = 0
	end

	-- main container
	local parent = "SettingsList"

	-- do we have a valid string?
	if IsValidString(text) then

		-- scan all the settings to search the name
		for i = SettingsWindow.LastFoundIndex + 1, #SettingsWindow.Settings do

			-- get the setting data
			local data = SettingsWindow.Settings[i]

			-- no text to search in this record
			if data.textFill == nil then
				continue
			end

			-- get the setting name
			local textFill = data.textFill
			local textFill2 = ""

			-- is this a keybinding setting?
			if data.settingType == SettingsWindow.VariableType.KEYBINDING then
				
				-- get the name TID
				local nameTid = SettingsWindow.GetKeyBindingNameNType(data.name)

				-- get the string name
				textFill = GetStringFromTid(nameTid)

			-- fix text for keybinding dismount
			elseif data.settingType == SettingsWindow.VariableType.KEYBINDINGMOUNTDISMOUNT then
				textFill = GetStringFromTid(290)
			end

			-- if we have only 1 textfill it will be a string otherwise it will be a table
			if type(textFill) == "string" or type(textFill) == "wstring" then
				textFill = string.lower(tostring(textFill))
			
			else -- double textfill
				textFill = string.lower(tostring(data.textFill[1]))
				textFill2 = string.lower(tostring(data.textFill[2]))
			end

			-- does this property has the text we're looking for?
			if string.find(textFill, text, 1, true) or string.find(textFill2, text, 1, true) then

				-- mark the last found index so the next search will start from here
				SettingsWindow.LastFoundIndex = i

				-- element name
				local element = parent .. data.name

				-- load the setting's tab first (if the tab is different from the active one)
				if SettingsWindow.ActiveTab ~= data.tabId then
					SettingsWindow.ForceSelectTab(data.tabId)
				end

				-- scroll to the setting
				WindowUtils.ScrollToElementInScrollWindow( element, "SettingsArea", "SettingsAreaScrollChild", 50 )

				-- highlight the item
				SettingsWindow.SearchHighlight(element .. "Label")

				return
			end
		end

		-- nothing found, reset the index
		SettingsWindow.LastFoundIndex = 0
	end
end

SettingsWindow.CurrentHighlightedItem = ""
SettingsWindow.CurrentHighlightedOrgColor = {}
function SettingsWindow.SearchHighlight(element)

	-- does the element exist?
	if not DoesWindowExist(element) then
		return
	end

	-- unhighlight the last element
	SettingsWindow.SearchUnhighlight(SettingsWindow.CurrentHighlightedItem)

	-- get the label color
	local oldcolorR, oldcolorG, oldcolorB = LabelGetTextColor(element)

	-- backup the old color
	SettingsWindow.CurrentHighlightedOrgColor = {r = oldcolorR, g = oldcolorG, b = oldcolorB}

	-- backup the element name
	SettingsWindow.CurrentHighlightedItem = element

	-- highlight the text
	LabelSetTextColor(element, 245, 199, 10)
end

function SettingsWindow.SearchUnhighlight(element)

	-- does the element exist?
	if not DoesWindowExist(element) then
		return
	end

	-- unhighlight the label
	LabelSetTextColor(element, SettingsWindow.CurrentHighlightedOrgColor.r, SettingsWindow.CurrentHighlightedOrgColor.g, SettingsWindow.CurrentHighlightedOrgColor.b)
end

function SettingsWindow.SetDisabled(element)
	
	-- do we have a valid element?
	if IsValidString(element) then
	
		-- graying the text color
		LabelSetTextColor(element .. "Label", 130, 130, 130 )

		-- disable the input
		WindowSetHandleInput(element, false)
	end
end

function SettingsWindow.SetEnabled(element)
	
	-- do we have a valid element?
	if IsValidString(element) then
	
		-- graying the text color
		LabelSetTextColor(element .. "Label", 255, 255, 255 )

		-- disable the input
		WindowSetHandleInput(element, true)
	end
end

function SettingsWindow.AddSetting(settingData, afterSetting)
	
	-- do we have a valid setting data to add?
	if not type(settingData) == "table" then
		return false
	end

	-- do we have to add the setting after a specific one?
	if IsValidString(afterSetting) then
		
		-- scan all settings
		for i, data in pairsByIndex(SettingsWindow.Settings) do
			
			-- is this the setting we're looking for?
			if data.name == afterSetting then
				
				-- insert the setting into the table
				table.insert(SettingsWindow.Settings, i + 1, settingData)	
				return true
			end
		end		
		
		-- if we have'nt found anything, we add the setting at the end
		table.insert(SettingsWindow.Settings, settingData)

	else -- add the setting at the end
		table.insert(SettingsWindow.Settings, settingData)
	end

	return true
end

function SettingsWindow.AddTab(tabData, afterTab)
	
	-- do we have a valid setting data to add?
	if not type(tabData) == "table" then
		return false
	end

	-- do we have to add the setting after a specific one?
	if not IsValidString(afterTab) then
		
		-- scan all settings
		for i, data in pairsByIndex(SettingsWindow.Tabs) do
			
			-- is this the setting we're looking for?
			if pairsByIndex.name == afterTab then
				
				-- insert the setting into the table
				table.insert(SettingsWindow.Tabs, i + 1, tabData)	
				return true
			end
		end		
		
		-- if we have'nt found anything, we add the setting at the end
		table.insert(SettingsWindow.Tabs, tabData)

	else -- add the setting at the end
		table.insert(SettingsWindow.Tabs, tabData)
	end

	return true
end

function SettingsWindow.GetKeybindingIDByType(keyType)
	
	if not IsValidString(keyType) then
		return
	end

	-- scan all keybindings
	for i, data in pairsByIndex(SettingsWindow.Keybindings) do

		-- is this the key we're looking for?
		if data.type == keyType then
			return i
		end
	end
end

function SettingsWindow.GetKeyBindingNameNType(name)

	-- parse all key bindings
	for i, data in pairsByIndex(SettingsWindow.Keybindings) do

		-- is this the one we're looking for?
		if data.name == name then
			return data.tid, "SystemData.Settings.Keybindings." .. data.type
		end
	end
end

function SettingsWindow.GetKeyBindingNameFromType(keyType)

	-- parse all key bindings
	for i, data  in pairsByIndex(SettingsWindow.Keybindings) do

		-- is this the one we're looking for?
		if data.type == keyType then
			return data.tid, i
		end
	end
end

function SettingsWindow.GetCurrentResolution()

	-- scan all possible risolutions
	for res = 1, #SystemData.AvailableResolutions.widths do 

		-- is this the active resolution?
		if (SystemData.Settings.Resolution.fullScreen.width == SystemData.AvailableResolutions.widths[res] and 
			SystemData.Settings.Resolution.fullScreen.height == SystemData.AvailableResolutions.heights[res] )
		then

			return res
		end 
	end
end

function SettingsWindow.SetCurrentResolution(fullScreenRes)

	-- update the user settings
	SystemData.Settings.Resolution.fullScreen.width = SystemData.AvailableResolutions.widths[fullScreenRes]
	SystemData.Settings.Resolution.fullScreen.height = SystemData.AvailableResolutions.heights[fullScreenRes]

	-- update the player profile
	SettingsWindow.UpdateProfile()
end

function SettingsWindow.GetCurrentMaxFramerate()

	-- get the current framerate ID
	local id = (SystemData.Settings.Resolution.framerateMax / 10) - 1

	-- make sure we are within the array values
	if id > #SettingsWindow.TID_FRAMERATE then
		return #SettingsWindow.TID_FRAMERATE
	end

	return id
end

function SettingsWindow.SetCurrentMaxFramerate(frameRateID)

	-- update the user settings
	SystemData.Settings.Resolution.framerateMax = (frameRateID + 1) * 10

	-- update the player profile
	SettingsWindow.UpdateProfile()
end

function SettingsWindow.GetCurrentWindowedFullScreen()

	-- read the text file
	local text = LoadTextFile("./logs/WindowedFullscreen.dat")

	-- disabled by default
	SettingsWindow.WindowedFullscreen = false

	-- does the file exist and it says: "ACTIVE"?
	if text and text == L"ACTIVE" then
		SettingsWindow.WindowedFullscreen = true
	end
end

function SettingsWindow.SetCurrentWindowedFullScreen(state)

	-- if the state is changed we need to restart the game
	local needExit = SettingsWindow.WindowedFullscreen ~= state

	-- update the current max framerate ID
	SettingsWindow.WindowedFullscreen = state

	-- change the text file to turn the windowed fullscreen on/off
	if state == true then
		CreateTextFile("logs/WindowedFullscreen.dat", L"ACTIVE")
	else
		CreateTextFile("logs/WindowedFullscreen.dat", L"OFF")
	end

	if needExit then

		-- update user profile
		UserSettingsChanged()
		
		-- begin the restart process
		SettingsWindow.BeginGameRestart()
	end
end

function SettingsWindow.GetCurrentScrollUpSetting()

	-- scan the behaviors
	for behavior, behav in pairsByIndex(SettingsWindow.ScrollWheelBehaviors) do

		-- is this the one we're looking for?
		if (SystemData.Settings.GameOptions.mouseScrollUpAction == behav.id) then
			return behavior
		end
	end

	-- if nothing has been found we set "NONE" as default
	return 14
end

function SettingsWindow.SetCurrentScrollUpSetting(comboID)

	-- update the user settings
	SystemData.Settings.GameOptions.mouseScrollUpAction = SettingsWindow.ScrollWheelBehaviors[comboID].id

	-- update the player profile
	SettingsWindow.UpdateProfile()
end

function SettingsWindow.GetCurrentScrollDownSetting()

	-- scan the behaviors
	for behavior, behav in pairsByIndex(SettingsWindow.ScrollWheelBehaviors) do

		-- is this the one we're looking for?
		if (SystemData.Settings.GameOptions.mouseScrollDownAction == behav.id) then
			return behavior
		end
	end

	-- if nothing has been found we set "NONE" as default
	return 14
end

function SettingsWindow.SetCurrentScrollDownSetting(comboID)

	-- update the user settings
	SystemData.Settings.GameOptions.mouseScrollDownAction = SettingsWindow.ScrollWheelBehaviors[comboID].id

	-- update the player profile
	SettingsWindow.UpdateProfile()
end

function SettingsWindow.GetCurrentLanguage()

	-- scan all languages
	for i, lang in pairsByIndex(SettingsWindow.Languages) do 
		
		-- is this the active language?
		if SystemData.Settings.Language.type == lang.id then
			return lang.id 
		end
	end

	-- if we have nothing, the default language is english
	return SystemData.Settings.Language.LANGUAGE_ENU
end

function SettingsWindow.SetCurrentLanguage(comboID)
	
	-- scan all languages
	for i, lang in pairsByIndex(SettingsWindow.Languages) do 
		
		-- is this the active language?
		if i == comboID then
			SystemData.Settings.Language.type = lang.id 

			-- update the player profile
			SettingsWindow.UpdateProfile()

			break
		end
	end
end

function SettingsWindow.GetCurrentUI()
	
	-- scan the known UI
	for i, uis in pairsByIndex(SystemData.CustomUIList) do

		-- is this the active UI?
		if SystemData.Settings.Interface.customUiName == uis then
			return i
		end
	end

	-- default
	return 1
end

function SettingsWindow.SetCurrentUI(comboID)
	
	-- set the active UI name
	SystemData.Settings.Interface.customUiName = SystemData.CustomUIList[comboID]

	-- update the player profile
	SettingsWindow.UpdateProfile()
end

function SettingsWindow.GetCurrentObjectHandleSize()

	-- scan all possible sizes
	for i, objHandleSize in pairsByIndex(SettingsWindow.ObjectHandleSizes) do

		-- is this the current size?
		if (SystemData.Settings.GameOptions.objectHandleSize == objHandleSize) then
			return i
		end
	end

	-- ALL (default value)
	return 5
end

function SettingsWindow.SetCurrentObjectHandleSize(comboID)

	-- update the number
	SystemData.Settings.GameOptions.objectHandleSize = SettingsWindow.ObjectHandleSizes[comboID]

	-- update the player profile
	SettingsWindow.UpdateProfile()
end

function SettingsWindow.GetCurrentBackpackStyle()

	-- scan all possible styles
	for i, bck in pairsByIndex(SettingsWindow.LegacyBackpackStyle) do

		-- get the style
		local backpackStyle = bck.id

		-- is this the current size?
		if (SystemData.Settings.GameOptions.myLegacyBackpackType == backpackStyle) then
			return i
		end
	end

	-- (default value)
	return 1
end

function SettingsWindow.SetCurrentBackpackStyle(comboID)
	
	-- update the number
	SystemData.Settings.GameOptions.myLegacyBackpackType = SettingsWindow.LegacyBackpackStyle[comboID].id

	-- update the player profile
	SettingsWindow.UpdateProfile()

	-- close all containers
	SettingsWindow.DestroyPlayerBackpack()
end

function SettingsWindow.GetCurrentContainerView()

	-- scan all possible styles
	for i, opt in pairsByIndex(SettingsWindow.ContainerViewOptions) do

		-- get the style
		local view = opt.name

		-- is this the current size?
		if (SystemData.Settings.Interface.defaultContainerMode == view) then
			return i
		end
	end

	-- (default value)
	return 1
end

function SettingsWindow.SetCurrentContainerView(comboID)

	-- update the number
	SystemData.Settings.Interface.defaultContainerMode = SettingsWindow.ContainerViewOptions[comboID].name

	-- update the player profile
	SettingsWindow.UpdateProfile()

	-- update the view of all containers without a saved view
	SettingsWindow.UpdateContainerView(1, SystemData.Settings.Interface.defaultContainerMode)
end

function SettingsWindow.GetCurrentCorpseView()

	-- scan all possible styles
	for i, opt in pairsByIndex(SettingsWindow.ContainerViewOptions) do

		-- get the style
		local view = opt.name

		-- is this the current size?
		if (SystemData.Settings.Interface.defaultCorpseMode == view) then
			return i
		end
	end

	-- (default value)
	return 1
end

function SettingsWindow.SetCurrentCorpseView(comboID)

	-- update the number
	SystemData.Settings.Interface.defaultCorpseMode = SettingsWindow.ContainerViewOptions[comboID].name

	-- update the player profile
	SettingsWindow.UpdateProfile()

	-- update the view of all corpses
	SettingsWindow.UpdateContainerView(2, SystemData.Settings.Interface.defaultCorpseMode)
end

function SettingsWindow.GetCurrentVendorView()

	-- scan all possible styles
	for i, opt in pairsByIndex(SettingsWindow.ContainerViewOptions) do

		-- get the style
		local view = opt.name

		-- is this the current size?
		if (Interface.Settings.playerVendorView == view) then
			return i
		end
	end

	-- (default value)
	return 1
end

function SettingsWindow.SetCurrentVendorView(comboID)

	-- update the number
	Interface.Settings.playerVendorView = SettingsWindow.ContainerViewOptions[comboID].name
		
	-- save the setting
	Interface.SaveSetting( "playerVendorView", Interface.Settings.playerVendorView )
		
	-- update the player profile
	SettingsWindow.UpdateProfile()

	-- update the view of all vendors containers
	SettingsWindow.UpdateContainerView(3, SystemData.Settings.Interface.playerVendorView)
end

function SettingsWindow.GetCurrentLowHP()

	-- this setting has specific index in the array for each value
	if (Interface.Settings.CST_LowHPPercDisabled) then
		return 16

	elseif Interface.Settings.CST_LowHPPerc <= 50 then
		return (Interface.Settings.CST_LowHPPerc  / 5) 

	elseif Interface.Settings.CST_LowHPPerc == 60 then
		return 11

	elseif Interface.Settings.CST_LowHPPerc == 70 then
		return 12 

	elseif Interface.Settings.CST_LowHPPerc == 80 then
		return 13

	elseif Interface.Settings.CST_LowHPPerc == 90 then
		return 14

	elseif Interface.Settings.CST_LowHPPerc == 99 then
		return 15 
	end
end

function SettingsWindow.SetCurrentLowHP(lowHP)
	
	-- set the value based on the index
	if lowHP <= 10 then
		Interface.Settings.CST_LowHPPerc = lowHP * 5
		Interface.Settings.CST_LowHPPercDisabled = false

		-- save the setting
		Interface.SaveSetting( "CST_LowHPPerc", Interface.Settings.CST_LowHPPerc )
		Interface.SaveSetting( "CST_LowHPPercDisabled", Interface.Settings.CST_LowHPPercDisabled )
		
		-- update the player profile
		SettingsWindow.UpdateProfile()

	elseif lowHP == 11 then
		Interface.Settings.CST_LowHPPerc = 60
		Interface.Settings.CST_LowHPPercDisabled = false

		-- save the setting
		Interface.SaveSetting( "CST_LowHPPerc", Interface.Settings.CST_LowHPPerc )
		Interface.SaveSetting( "CST_LowHPPercDisabled", Interface.Settings.CST_LowHPPercDisabled )
		
		-- update the player profile
		SettingsWindow.UpdateProfile()

	elseif lowHP == 12 then
		Interface.Settings.CST_LowHPPerc = 70
		Interface.Settings.CST_LowHPPercDisabled = false

		-- save the setting
		Interface.SaveSetting( "CST_LowHPPerc", Interface.Settings.CST_LowHPPerc )
		Interface.SaveSetting( "CST_LowHPPercDisabled", Interface.Settings.CST_LowHPPercDisabled )
		
		-- update the player profile
		SettingsWindow.UpdateProfile()

	elseif lowHP == 13 then
		Interface.Settings.CST_LowHPPerc = 80
		Interface.Settings.CST_LowHPPercDisabled = false

		-- save the setting
		Interface.SaveSetting( "CST_LowHPPerc", Interface.Settings.CST_LowHPPerc )
		Interface.SaveSetting( "CST_LowHPPercDisabled", Interface.Settings.CST_LowHPPercDisabled )
		
		-- update the player profile
		SettingsWindow.UpdateProfile()

	elseif lowHP == 14 then
		Interface.Settings.CST_LowHPPerc = 90
		Interface.Settings.CST_LowHPPercDisabled = false

		-- save the setting
		Interface.SaveSetting( "CST_LowHPPerc", Interface.Settings.CST_LowHPPerc )
		Interface.SaveSetting( "CST_LowHPPercDisabled", Interface.Settings.CST_LowHPPercDisabled )
		
		-- update the player profile
		SettingsWindow.UpdateProfile()

	elseif lowHP == 15 then
		Interface.Settings.CST_LowHPPerc = 99
		Interface.Settings.CST_LowHPPercDisabled = false

		-- save the setting
		Interface.SaveSetting( "CST_LowHPPerc", Interface.Settings.CST_LowHPPerc )
		Interface.SaveSetting( "CST_LowHPPercDisabled", Interface.Settings.CST_LowHPPercDisabled )
		
		-- update the player profile
		SettingsWindow.UpdateProfile()

	elseif lowHP == 16 then
		Interface.Settings.CST_LowHPPerc = 35
		Interface.Settings.CST_LowHPPercDisabled = true

		-- save the setting
		Interface.SaveSetting( "CST_LowHPPerc", Interface.Settings.CST_LowHPPerc )
		Interface.SaveSetting( "CST_LowHPPercDisabled", Interface.Settings.CST_LowHPPercDisabled )
		
		-- update the player profile
		SettingsWindow.UpdateProfile()

		-- stop the effect in case it was active
		if CenterScreenText.LOWHPMEStarted then
			CenterScreenText.LOWHPMEStarted = false
			WindowStopAlphaAnimation("CenterScreenTextImage")
			WindowSetAlpha("CenterScreenTextImage", 0)
		end
	end
end

function SettingsWindow.GetCurrentLowHPPet()

	-- this setting has specific index in the array for each value
	if (Interface.Settings.CST_LowPETHPPercDisabled) then
		return 16

	elseif Interface.Settings.CST_LowPETHPPerc <= 50 then
		return (Interface.Settings.CST_LowPETHPPerc  / 5) 

	elseif Interface.Settings.CST_LowPETHPPerc == 60 then
		return 11

	elseif Interface.Settings.CST_LowPETHPPerc == 70 then
		return 12 

	elseif Interface.Settings.CST_LowPETHPPerc == 80 then
		return 13

	elseif Interface.Settings.CST_LowPETHPPerc == 90 then
		return 14

	elseif Interface.Settings.CST_LowPETHPPerc == 99 then
		return 15 
	end
end

function SettingsWindow.SetCurrentLowHPPet(lowHPPet)

	-- set the value based on the index
	if lowHPPet <= 10 then
		Interface.Settings.CST_LowPETHPPerc = lowHPPet * 5
		Interface.Settings.CST_LowPETHPPercDisabled = false

		-- save the setting
		Interface.SaveSetting( "CST_LowPETHPPerc", Interface.Settings.CST_LowPETHPPerc )
		Interface.SaveSetting( "CST_LowPETHPPercDisabled", Interface.Settings.CST_LowPETHPPercDisabled )
		
		-- update the player profile
		SettingsWindow.UpdateProfile()

	elseif lowHPPet == 11 then
		Interface.Settings.CST_LowPETHPPerc = 60
		Interface.Settings.CST_LowPETHPPercDisabled = false

		-- save the setting
		Interface.SaveSetting( "CST_LowPETHPPerc", Interface.Settings.CST_LowPETHPPerc )
		Interface.SaveSetting( "CST_LowPETHPPercDisabled", Interface.Settings.CST_LowPETHPPercDisabled )
		
		-- update the player profile
		SettingsWindow.UpdateProfile()

	elseif lowHPPet == 12 then
		Interface.Settings.CST_LowPETHPPerc = 70
		Interface.Settings.CST_LowPETHPPercDisabled = false

		-- save the setting
		Interface.SaveSetting( "CST_LowPETHPPerc", Interface.Settings.CST_LowPETHPPerc )
		Interface.SaveSetting( "CST_LowPETHPPercDisabled", Interface.Settings.CST_LowPETHPPercDisabled )
		
		-- update the player profile
		SettingsWindow.UpdateProfile()

	elseif lowHPPet == 13 then
		Interface.Settings.CST_LowPETHPPerc = 80
		Interface.Settings.CST_LowPETHPPercDisabled = false

		-- save the setting
		Interface.SaveSetting( "CST_LowPETHPPerc", Interface.Settings.CST_LowPETHPPerc )
		Interface.SaveSetting( "CST_LowPETHPPercDisabled", Interface.Settings.CST_LowPETHPPercDisabled )
		
		-- update the player profile
		SettingsWindow.UpdateProfile()

	elseif lowHPPet == 14 then
		Interface.Settings.CST_LowPETHPPerc = 90
		Interface.Settings.CST_LowPETHPPercDisabled = false

		-- save the setting
		Interface.SaveSetting( "CST_LowPETHPPerc", Interface.Settings.CST_LowPETHPPerc )
		Interface.SaveSetting( "CST_LowPETHPPercDisabled", Interface.Settings.CST_LowPETHPPercDisabled )
		
		-- update the player profile
		SettingsWindow.UpdateProfile()

	elseif lowHPPet == 15 then
		Interface.Settings.CST_LowPETHPPerc = 99
		Interface.Settings.CST_LowPETHPPercDisabled = false

		-- save the setting
		Interface.SaveSetting( "CST_LowPETHPPerc", Interface.Settings.CST_LowPETHPPerc )
		Interface.SaveSetting( "CST_LowPETHPPercDisabled", Interface.Settings.CST_LowPETHPPercDisabled )
		
		-- update the player profile
		SettingsWindow.UpdateProfile()

	elseif lowHPPet == 16 then
		Interface.Settings.CST_LowPETHPPerc = 35
		Interface.Settings.CST_LowPETHPPercDisabled = true

		-- save the setting
		Interface.SaveSetting( "CST_LowPETHPPerc", Interface.Settings.CST_LowPETHPPerc )
		Interface.SaveSetting( "CST_LowPETHPPercDisabled", Interface.Settings.CST_LowPETHPPercDisabled )
		
		-- update the player profile
		SettingsWindow.UpdateProfile()

		-- stop the effect in case it was active
		if CenterScreenText.LOWHPPetStarted then
			CenterScreenText.LOWHPPetStarted = false
			WindowStopAlphaAnimation("CenterScreenTextImage")
			WindowSetAlpha("CenterScreenTextImage", 0)
		end
	end
end

function SettingsWindow.SwitchTP()

	-- main container
	local parent = "SettingsList"

	-- update texture image
	local it = ComboBoxGetSelectedMenuItem( parent .. "MiniTexturePackCombo" )
	DynamicImageSetTexture( parent .. "MiniTexturePackImage", MiniTexturePack.DB[it].texture .. "Icon", 0, 0)
	MiniTexturePack.SetTexturePack(it)
	
	-- update border image
	local it = ComboBoxGetSelectedMenuItem( parent .. "MiniTexturePackBorderCombo" )
	DynamicImageSetTexture( parent .. "MiniTexturePackBorderImage", MiniTexturePack.Overlays[it].texture, 0, 0)
	MiniTexturePack.SetTexturePackBorder(it)	
end

function SettingsWindow.GetVariableName(windowName)

	-- scan all settings
	for i, data in pairsByIndex(SettingsWindow.Settings) do

		-- is this the window we're looking for?
		if data.name == windowName then
			return data.settingVariableName, data.settingType, data.updateFunc
		end
	end
end

function SettingsWindow.GetCurrentStatusStyle()

	return Interface.Settings.StatusWindowStyle + 1
end

function SettingsWindow.SetCurrentStatusStyle(comboID)

	-- update the status
	StatusWindow.ChangeStyle(comboID - 1)
end

function SettingsWindow.GetCurrentShowNames()

	-- scan all possible show names
	for i, names in pairsByIndex(SettingsWindow.ShowNames) do

		-- get the id
		local nameId = names.id

		-- is this the current size?
		if (SystemData.Settings.GameOptions.showNames == nameId) then
			return i
		end
	end

	-- (default value)
	return 1
end

function SettingsWindow.SetCurrentShowNames(comboID)

	-- update the number
	SystemData.Settings.GameOptions.showNames = SettingsWindow.ShowNames[comboID].id

	-- update the player profile
	SettingsWindow.UpdateProfile()
end

function SettingsWindow.UpdateProfile(forceReload)
	
	-- do we need to reload the UI
	local needReload = UserSettingsChanged()

	-- update the player profile
	if (needReload == true or forceReload ==  true) then
		InterfaceCore.ReloadUI()
	end
end

function SettingsWindow.UpdateECPlaySoundStatus()

	-- disable music
	if not Interface.ECMusic.enabled then
		ECPlaySound(1, "", 1)
		MapCommon.CurrentArea = nil
		MapCommon.AreaDescription = nil
		MapCommon.CurrentSubArea = nil
		MapCommon.CurrentAreaMusic = nil
	end
	
	-- disable sound
	if not Interface.ECSound.enabled then
		ECPlaySound(0, "", 1)
	end

	-- disable heartbeat
	if not Interface.HeartBeat.enabled then
		ECPlaySound(2, "", 1)
		Interface.Beat = false
		Interface.BeatSlow = false
		Interface.BeatMed = false
		Interface.BeatFast = false
	end

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
end

function SettingsWindow.UpdateChatAlpha()

	-- is the alpha value less than 0.01?
	if Interface.Settings.chat_BaseAlpha < 0.01 then
		
		-- set the value to 0.01
		Interface.Settings.chat_BaseAlpha = 0.01
	end 

	-- apply the alpha to the chat
	WindowSetAlpha("NewChatWindow", Interface.Settings.chat_BaseAlpha)

	-- keep the scrollbar visible
	WindowSetAlpha("NewChatWindowJournalWindowScrollbar", 2)

	-- scan all the visible tabs
	for j = 1, NewChatWindow.maxTabs do

		-- tab name
		local templatename = "NewChatWindow" .. j

		-- does the tab exist?
		if (DoesWindowExist(templatename)) then

			-- apply the alpha to the tab
			WindowSetAlpha(templatename, Interface.Settings.chat_BaseAlpha)

			-- keep the scrollbar visible
			WindowSetAlpha("NewChatWindowBookmark" .. j .. "Scrollbar", 2)
		end
	end

	-- update the tabs
	NewChatWindow.OnMouseOverEnd()
end

function SettingsWindow.BeginGameRestart()

	-- 5s timer before restart
	Interface.RestartTime = Interface.TimeSinceLogin + 5

	-- show a warning popup
	local okayButton = { textTid=UO_StandardDialog.TID_OKAY , callback=function() BroadcastEvent( SystemData.Events.EXIT_GAME ) end }
	local cancelButton = { text=GetStringFromTid(UO_StandardDialog.TID_CANCEL)}
	local DestroyConfirmWindow = 
	{
		windowName = "RestartWarning",
		titleTid = 298,
		bodyTid  = 299 ,
		buttons = { okayButton, cancelButton },
		closeCallback = cancelButton.callback,
		destroyDuplicate = true,
	}
	UO_StandardDialog.CreateDialog(DestroyConfirmWindow)	
end

function SettingsWindow.ExportSettings()

	-- reset the exported settings
	Interface.ExportedSettings = {}
	
	-- get the player name
	Interface.ExportedSettings.name = GetMobileName(GetPlayerID())

	-- copy the loot sort
	Interface.ExportedSettings.LootSort = table.copy(ItemPropertiesInfo.LootOrder)

	-- copy the finders keepers items
	Interface.ExportedSettings.FindersKeepers = table.copy(ContainerWindow.FindItems)

	-- initialize the settings array
	Interface.ExportedSettings.Settings = {}

	-- scan all settings
	for i, settingData in pairsByIndex(SettingsWindow.Settings) do

		-- does this setting have a variable and it's not a global setting?
		if settingData.settingType and not SettingsWindow.GlobalSettings[settingData.name] then
			
			-- keybinding setting
			if settingData.settingType == SettingsWindow.VariableType.KEYBINDING then

				-- get the variable name
				local _, settingVariableName = SettingsWindow.GetKeyBindingNameNType(settingData.name)

				-- add the setting to the export list
				Interface.ExportedSettings.Settings[settingData.name] = GetDynamicVariableValue(settingVariableName)

			-- mount keybinding setting
			elseif settingData.settingType == SettingsWindow.VariableType.KEYBINDINGMOUNTDISMOUNT then

				-- add the setting to the export list
				Interface.ExportedSettings.Settings[settingData.name] = SystemData.Hotbar[Interface.MountBlockbar].BindingDisplayStrings[1]

			-- volume setting
			elseif settingData.settingType == SettingsWindow.VariableType.VOLUME then

				-- get the current volume table
				local volumeVar = GetDynamicVariableValue(settingData.settingVariableName)

				-- add the setting to the export list
				Interface.ExportedSettings.Settings[settingData.name] = table.copy(volumeVar)

			else -- any other setting

				-- get the current variable value
				local value = GetDynamicVariableValue(settingData.settingVariableName)

				-- add the setting to the export list
				Interface.ExportedSettings.Settings[settingData.name] = value
			end
		end
	end

	-- show the import button
	WindowSetShowing("SettingsWindowImportButton", true)
end

function SettingsWindow.ImportSettings()

	-- get the exporter character name
	local name = Interface.ExportedSettings.name

	-- create the body text
	local text = ReplaceTokens(GetStringFromTid(304), { towstring(name) }) 

	-- create the dialog to reset all to default
	local okayButton = { textTid = UO_StandardDialog.TID_OKAY, callback = function() SettingsWindow.BeginImport() end }
	local cancelButton = { textTid = UO_StandardDialog.TID_CANCEL }
	local ResetConfirmWindow = 
	{
		windowName = "ImportSettingsWindow", 
		titleTid = 301, 
		body = text, 
		buttons = { okayButton, cancelButton },
		closeCallback = cancelButton.callback,
		destroyDuplicate = true,
	}
			
	UO_StandardDialog.CreateDialog(ResetConfirmWindow)
end

function SettingsWindow.BeginImport()

	-- copy the loot sort
	ItemPropertiesInfo.LootOrder = table.copy(Interface.ExportedSettings.LootSort)

	-- copy the finders keepers items
	FindersKeepers.ImportItems()

	-- scan all settings
	for i, settingData in pairsByIndex(SettingsWindow.Settings) do

		-- get the settings data
		local settingData = SettingsWindow.Settings[i]

		-- does this setting have a variable and it's not a global setting?
		if settingData.settingType and not SettingsWindow.GlobalSettings[settingData.name] then
			
			-- get the exported value
			local value = Interface.ExportedSettings.Settings[settingData.name]
			
			-- keybinding setting
			if settingData.settingType == SettingsWindow.VariableType.KEYBINDING then

				-- get the variable name
				local _, settingVariableName = SettingsWindow.GetKeyBindingNameNType(settingData.name)
				
				-- update the variable value
				SetDynamicVariableValue(settingVariableName, value)
				
			-- mount keybinding setting
			elseif settingData.settingType == SettingsWindow.VariableType.KEYBINDINGMOUNTDISMOUNT then

				-- update the mount/dismount hotkey
				SystemData.Hotbar[Interface.MountBlockbar].Bindings[1] = value
				SystemData.Hotbar[Interface.MountBlockbar].BindingDisplayStrings[1] = value

			-- volume setting
			elseif settingData.settingType == SettingsWindow.VariableType.VOLUME then

				-- update the variable value
				SetDynamicVariableValue(settingData.settingVariableName .. ".enabled", value.enabled)
				SetDynamicVariableValue(settingData.settingVariableName .. ".volume", value.volume)

				-- is this a playsound variable?
				if string.find(settingData.name, "ECPlaySound", 1, true) then

					-- get the UI setting variable name
					local varName = string.gsub(settingData.settingVariableName, "Interface.", "")

					-- save the setting
					Interface.SaveSetting(varName .. ".enabled", value.enabled)
					Interface.SaveSetting(varName .. ".volume", value.volume)
				end

			else-- any other setting

				-- update the variable value
				SetDynamicVariableValue(settingData.settingVariableName, value)

				-- is this a playsound variable?
				if string.find(settingData.settingVariableName, "Interface.Settings", 1, true) then
					
					-- get the UI setting variable name
					local varName = string.gsub(settingData.settingVariableName, "Interface.Settings.", "")

					-- save the setting
					Interface.SaveSetting(varName, value)
				end
			end
		end
	end

	-- update the keybinding in the character profile
	BroadcastEvent(SystemData.Events.KEYBINDINGS_UPDATED)

	-- update the player profile and reload the UI
	SettingsWindow.UpdateProfile(true)
end

function SettingsWindow.GetSortedSpellsTable()

	-- array for the sorted spells
	local sortedSpells = {}

	-- scan all the spells
	for i, dt in pairs(SpellsInfo.SpellsData) do 

		-- make sure this spell has a target, does not requires to target the ground and is not only for items.
		if dt.notarget or dt.cursorOnly or SpellsInfo.TargetObjectSpells[dt.id] or dt.id <= 0 or not SpellsInfo.CanUseSpell(dt.id) then
			continue
		end

		-- add the value to the table
		table.insert(sortedSpells, i)
	end

	-- sort the table by spell ID
	local pos = 1

	-- loop through the list
	while pos <= #sortedSpells do

		-- current spell ID
		local currSpell = SpellsInfo.SpellsData[sortedSpells[pos]] and SpellsInfo.SpellsData[sortedSpells[pos]].id or -1

		-- previous spell ID
		local prevSpell = SpellsInfo.SpellsData[sortedSpells[pos - 1]] and SpellsInfo.SpellsData[sortedSpells[pos - 1]].id or -1
			
		-- is this the first element or the previous element is bigger than this one?
		if (pos == 1 or currSpell <= prevSpell) then

			-- move to the next element
			pos = pos + 1

		else -- store the element
			local swap = sortedSpells[pos]

			-- move the previous element to th current position
			sortedSpells[pos] = sortedSpells[pos-1]

			-- move the store element to the previous position
			sortedSpells[pos-1] = swap

			-- move to the previous position
			pos = pos - 1
		end
	end

	-- add none as first spell
	table.insert(sortedSpells, 1, GetStringFromTid(1011051)) -- NONE

	return sortedSpells
end

function SettingsWindow.FillSpellsCombo(data)

	-- get the combo nAMW
	local combo = data[1]

	-- get the spell ID
	local spellId = data[2]

	-- array for the sorted spells
	local sortedSpells = SettingsWindow.GetSortedSpellsTable()

	-- default selection is the first element
	local sel = 1 

	-- count the elements in the combo box
	local count = 1

	-- scan all the spells
	for i, spell in pairsByIndex(sortedSpells) do 

		-- first element is always NONE
		if i == 1 then

			-- add the element to the combo box
			ComboBoxAddMenuItem(combo, spell) 

		else -- all the spells 

			-- get the spell data
			local dt = SpellsInfo.SpellsData[spell]

			-- get the TID for the spell
			local _, _, tid = GetAbilityData(dt.id) 

			-- add the element to the combo box
			ComboBoxAddMenuItem(combo, GetStringFromTid(tid)) 

			-- is this the current spell?
			if dt.id == spellId then 

				-- set this spell to be selected
				sel = count 
			end 
		end

		-- increase the spells count
		count = count + 1
	end 

	return sel 
end