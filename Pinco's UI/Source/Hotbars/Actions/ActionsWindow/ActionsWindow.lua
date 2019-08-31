
----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

ActionsWindow = {}
ActionsWindow.DefaultTypes = 91

function ActionsWindow.InitActionData()

	ActionsWindow.ActionData = {}
	
	-- UNUSED
	ActionsWindow.ActionData[18] = { type = SystemData.UserAction.TYPE_MACRO,							inActionWindow = false,			 nameTid = 3000394, editWindow = "Macro" }	
	ActionsWindow.ActionData[33] = { type = SystemData.UserAction.TYPE_PET_COMMAND_GUARD,				inActionWindow = true, iconId = 657, nameTid = 1079304, detailTid = 1115163 }	

	-- COMBAT
	ActionsWindow.ActionData[67] = { group = 1077417, type = SystemData.UserAction.TYPE_ATTACK_CURRENT_TARGET,			inActionWindow = true, iconId = 773, nameTid = 1112414, detailTid = 1115188, unique = true }
	ActionsWindow.ActionData[68] = { group = 1077417, type = SystemData.UserAction.TYPE_ATTACK_LAST_CURSOR_TARGET,		inActionWindow = true, iconId = 774, nameTid = 1112415, detailTid = 1115190, unique = true }
	ActionsWindow.ActionData[27] = { group = 1077417, type = SystemData.UserAction.TYPE_WAR_MODE,						inActionWindow = true, iconId = 675, nameTid = 3000086, detailTid = 1115156, unique = true }
	ActionsWindow.ActionData[28] = { group = 1077417, type = SystemData.UserAction.TYPE_PEACE_MODE, 					inActionWindow = true, iconId = 676, nameTid = 3000085, detailTid = 1115157, unique = true }

	-- VIRTUES
	ActionsWindow.ActionData[58] = { group = 1077439, type = SystemData.UserAction.TYPE_INVOKE_VIRTUE,					inActionWindow = true, iconId = 701, nameTid = 1051005, detailTid = 1052058, invokeId = 1, unique = true } -- Honor
	ActionsWindow.ActionData[59] = { group = 1077439, type = SystemData.UserAction.TYPE_INVOKE_VIRTUE,					inActionWindow = true, iconId = 706, nameTid = 1051001, detailTid = 1052053, invokeId = 2, unique = true } -- Sacrifice
	ActionsWindow.ActionData[60] = { group = 1077439, type = SystemData.UserAction.TYPE_INVOKE_VIRTUE,					inActionWindow = true, iconId = 700, nameTid = 1051004, detailTid = 1052057, invokeId = 3, unique = true } -- Valor
	ActionsWindow.ActionData[61] = { group = 1077439, type = SystemData.UserAction.TYPE_INVOKE_VIRTUE,					inActionWindow = true, iconId = 702, nameTid = 1051002, detailTid = 1053000, invokeId = 4, unique = true } -- Compassion
	ActionsWindow.ActionData[62] = { group = 1077439, type = SystemData.UserAction.TYPE_INVOKE_VIRTUE,					inActionWindow = true, iconId = 704, nameTid = 1051007, detailTid = 1052060, invokeId = 5, unique = true } -- Honesty
	ActionsWindow.ActionData[63] = { group = 1077439, type = SystemData.UserAction.TYPE_INVOKE_VIRTUE,					inActionWindow = true, iconId = 707, nameTid = 1051000, detailTid = 1052051, invokeId = 6, unique = true } -- Humility
	ActionsWindow.ActionData[64] = { group = 1077439, type = SystemData.UserAction.TYPE_INVOKE_VIRTUE,					inActionWindow = true, iconId = 703, nameTid = 1051006, detailTid = 1052059, invokeId = 7, unique = true } -- Justice
	ActionsWindow.ActionData[65] = { group = 1077439, type = SystemData.UserAction.TYPE_INVOKE_VIRTUE,					inActionWindow = true, iconId = 705, nameTid = 1051003, detailTid = 1052056, invokeId = 8, unique = true } -- Spirituality

	-- 4001 -> 4020 :  CANNON ACTIONS
	ActionsWindow.ActionData[4000] = { group = 1116354, type = SystemData.UserAction.TYPE_TARGET_BY_OBJECT_ID,			inActionWindow = true, iconId = 870400, nameString = ReplaceTokens(GetStringFromTid(1155059), {L"1"}), detailString = ReplaceTokens(GetStringFromTid(1155060), {L"1"}), editWindow = "TargetByObjectId", paramInfoTid = 1094788, hideOK = true, unique = true }
	ActionsWindow.ActionData[4001] = { group = 1116354, type = SystemData.UserAction.TYPE_TARGET_BY_OBJECT_ID,			inActionWindow = true, iconId = 870401, nameString = ReplaceTokens(GetStringFromTid(1155059), {L"2"}), detailString = ReplaceTokens(GetStringFromTid(1155060), {L"2"}), editWindow = "TargetByObjectId", paramInfoTid = 1094788, hideOK = true, unique = true }
	ActionsWindow.ActionData[4002] = { group = 1116354, type = SystemData.UserAction.TYPE_TARGET_BY_OBJECT_ID,			inActionWindow = true, iconId = 870402, nameString = ReplaceTokens(GetStringFromTid(1155059), {L"3"}), detailString = ReplaceTokens(GetStringFromTid(1155060), {L"3"}), editWindow = "TargetByObjectId", paramInfoTid = 1094788, hideOK = true, unique = true }
	ActionsWindow.ActionData[4003] = { group = 1116354, type = SystemData.UserAction.TYPE_TARGET_BY_OBJECT_ID,			inActionWindow = true, iconId = 870403, nameString = ReplaceTokens(GetStringFromTid(1155059), {L"4"}), detailString = ReplaceTokens(GetStringFromTid(1155060), {L"4"}), editWindow = "TargetByObjectId", paramInfoTid = 1094788, hideOK = true, unique = true }
	ActionsWindow.ActionData[4004] = { group = 1116354, type = SystemData.UserAction.TYPE_TARGET_BY_OBJECT_ID,			inActionWindow = true, iconId = 870404, nameString = ReplaceTokens(GetStringFromTid(1155059), {L"5"}), detailString = ReplaceTokens(GetStringFromTid(1155060), {L"5"}), editWindow = "TargetByObjectId", paramInfoTid = 1094788, hideOK = true, unique = true }
	ActionsWindow.ActionData[4005] = { group = 1116354, type = SystemData.UserAction.TYPE_TARGET_BY_OBJECT_ID,			inActionWindow = true, iconId = 870405, nameString = ReplaceTokens(GetStringFromTid(1155059), {L"6"}), detailString = ReplaceTokens(GetStringFromTid(1155060), {L"6"}), editWindow = "TargetByObjectId", paramInfoTid = 1094788, hideOK = true, unique = true }
	ActionsWindow.ActionData[4006] = { group = 1116354, type = SystemData.UserAction.TYPE_TARGET_BY_OBJECT_ID,			inActionWindow = true, iconId = 870406, nameString = ReplaceTokens(GetStringFromTid(1155059), {L"7"}), detailString = ReplaceTokens(GetStringFromTid(1155060), {L"7"}), editWindow = "TargetByObjectId", paramInfoTid = 1094788, hideOK = true, unique = true }
	ActionsWindow.ActionData[4007] = { group = 1116354, type = SystemData.UserAction.TYPE_TARGET_BY_OBJECT_ID,			inActionWindow = true, iconId = 870407, nameString = ReplaceTokens(GetStringFromTid(1155059), {L"8"}), detailString = ReplaceTokens(GetStringFromTid(1155060), {L"8"}), editWindow = "TargetByObjectId", paramInfoTid = 1094788, hideOK = true, unique = true }
	ActionsWindow.ActionData[4008] = { group = 1116354, type = SystemData.UserAction.TYPE_TARGET_BY_OBJECT_ID,			inActionWindow = true, iconId = 870408, nameString = ReplaceTokens(GetStringFromTid(1155059), {L"9"}), detailString = ReplaceTokens(GetStringFromTid(1155060), {L"9"}), editWindow = "TargetByObjectId", paramInfoTid = 1094788, hideOK = true, unique = true }
	
	-- 4100 -> 4299 :  EQUIPMENT
	ActionsWindow.ActionData[1]   =	 { group = 1154982, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 625,	nameTid = 1078184, detailTid = 1115131, editWindow = "Equip",	paramInfoTid = 1078184}
	ActionsWindow.ActionData[2]   =	 { group = 1154982, type = SystemData.UserAction.TYPE_UNEQUIP_ITEMS,				inActionWindow = true, iconId = 637,	nameTid = 1078185, detailTid = 1115132, editWindow = "UnEquip", paramInfoTid = 1078185}
	ActionsWindow.ActionData[85]  =	 { group = 1154982, type = SystemData.UserAction.TYPE_EQUIP_LAST_WEAPON,			inActionWindow = true, iconId = 792,	nameTid = 1114305, detailTid = 1115207, unique = true }
	ActionsWindow.ActionData[4100] = { group = 1154982, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875000, nameTid = 1155063, detailTid = 1115131, editWindow = "Equip",	paramInfoTid = 1078184,  unique = true }
	ActionsWindow.ActionData[4101] = { group = 1154982, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875001, nameTid = 1155064, detailTid = 1115131, editWindow = "Equip",	paramInfoTid = 1078184,  unique = true }
	ActionsWindow.ActionData[4102] = { group = 1154982, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875002, nameTid = 1155065, detailTid = 1115131, editWindow = "Equip",	paramInfoTid = 1078184,  unique = true }
	ActionsWindow.ActionData[4103] = { group = 1154982, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875003, nameTid = 1155066, detailTid = 1115131, editWindow = "Equip",	paramInfoTid = 1078184,  unique = true }
	ActionsWindow.ActionData[4104] = { group = 1154982, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875004, nameTid = 1155067, detailTid = 1115131, editWindow = "Equip",	paramInfoTid = 1078184,  unique = true }
	ActionsWindow.ActionData[4105] = { group = 1154982, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875005, nameTid = 1155068, detailTid = 1115131, editWindow = "Equip",	paramInfoTid = 1078184,  unique = true }
	ActionsWindow.ActionData[4106] = { group = 1154982, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875006, nameTid = 1155069, detailTid = 1115131, editWindow = "Equip",	paramInfoTid = 1078184,  unique = true }
	ActionsWindow.ActionData[4107] = { group = 1154982, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875007, nameTid = 1155070, detailTid = 1115131, editWindow = "Equip",	paramInfoTid = 1078184,  unique = true }
	ActionsWindow.ActionData[4108] = { group = 1154982, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875008, nameTid = 1155071, detailTid = 1115131, editWindow = "Equip",	paramInfoTid = 1078184,  unique = true }
	ActionsWindow.ActionData[4109] = { group = 1154982, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875009, nameTid = 1155072, detailTid = 1115131, editWindow = "Equip",	paramInfoTid = 1078184,  unique = true }
	ActionsWindow.ActionData[4110] = { group = 1154982, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875010, nameTid = 1155073, detailTid = 1115131, editWindow = "Equip",	paramInfoTid = 1078184,  unique = true }
	ActionsWindow.ActionData[4111] = { group = 1154982, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875011, nameTid = 1155074, detailTid = 1115131, editWindow = "Equip",	paramInfoTid = 1078184,  unique = true }
	ActionsWindow.ActionData[4112] = { group = 1154982, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875012, nameTid = 1155075, detailTid = 1115131, editWindow = "Equip",	paramInfoTid = 1078184,  unique = true }
	ActionsWindow.ActionData[4113] = { group = 1154982, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875013, nameTid = 1155076, detailTid = 1115131, editWindow = "Equip",	paramInfoTid = 1078184,  unique = true }
	ActionsWindow.ActionData[4114] = { group = 1154982, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875014, nameTid = 1155077, detailTid = 1115131, editWindow = "Equip",	paramInfoTid = 1078184,  unique = true }
	ActionsWindow.ActionData[4115] = { group = 1154982, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875015, nameTid = 1155078, detailTid = 1115131, editWindow = "Equip",	paramInfoTid = 1078184,  unique = true }
	ActionsWindow.ActionData[4116] = { group = 1154982, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875016, nameTid = 1155079, detailTid = 1115131, editWindow = "Equip",	paramInfoTid = 1078184,  unique = true }
	ActionsWindow.ActionData[4117] = { group = 1154982, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875017, nameTid = 1155080, detailTid = 1115131, editWindow = "Equip",	paramInfoTid = 1078184,  unique = true }
	ActionsWindow.ActionData[4118] = { group = 1154982, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875018, nameTid = 1155081, detailTid = 1115131, editWindow = "Equip",	paramInfoTid = 1078184,  unique = true }
	ActionsWindow.ActionData[4119] = { group = 1154982, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875019, nameTid = 1155082, detailTid = 1115131, editWindow = "Equip",	paramInfoTid = 1078184,  unique = true }
	ActionsWindow.ActionData[4120] = { group = 1154982, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875020, nameTid = 1155083, detailTid = 1115131, editWindow = "Equip",	paramInfoTid = 1078184,  unique = true }
	ActionsWindow.ActionData[4121] = { group = 1154982, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875021, nameTid = 1155084, detailTid = 1115131, editWindow = "Equip",	paramInfoTid = 1078184,  unique = true }
	ActionsWindow.ActionData[4122] = { group = 1154982, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875022, nameTid = 1155085, detailTid = 1115131, editWindow = "Equip",	paramInfoTid = 1078184,  unique = true }
	ActionsWindow.ActionData[4123] = { group = 1154982, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875023, nameTid = 1155086, detailTid = 1115131, editWindow = "Equip",	paramInfoTid = 1078184,  unique = true }
	ActionsWindow.ActionData[4124] = { group = 1154982, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875024, nameTid = 1155087, detailTid = 1115131, editWindow = "Equip",	paramInfoTid = 1078184,  unique = true }
	ActionsWindow.ActionData[4125] = { group = 1154982, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875025, nameTid = 1155088, detailTid = 1115131, editWindow = "Equip",	paramInfoTid = 1078184,  unique = true }
	ActionsWindow.ActionData[4126] = { group = 1154982, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875026, nameTid = 1155089, detailTid = 1115131, editWindow = "Equip",	paramInfoTid = 1078184,  unique = true }
	ActionsWindow.ActionData[4127] = { group = 1154982, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875027, nameTid = 1155090, detailTid = 1115131, editWindow = "Equip",	paramInfoTid = 1078184,  unique = true }
	ActionsWindow.ActionData[4128] = { group = 1154982, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875028, nameTid = 1155091, detailTid = 1115131, editWindow = "Equip",	paramInfoTid = 1078184,  unique = true }
	ActionsWindow.ActionData[4129] = { group = 1154982, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875029, nameTid = 1155092, detailTid = 1115131, editWindow = "Equip",	paramInfoTid = 1078184,  unique = true }
	ActionsWindow.ActionData[4130] = { group = 1154982, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875030, nameTid = 1155093, detailTid = 1115131, editWindow = "Equip",	paramInfoTid = 1078184,  unique = true }
	ActionsWindow.ActionData[4131] = { group = 1154982, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875031, nameTid = 1155094, detailTid = 1115131, editWindow = "Equip",	paramInfoTid = 1078184,  unique = true }
	ActionsWindow.ActionData[4132] = { group = 1154982, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875032, nameTid = 1155095, detailTid = 1115131, editWindow = "Equip",	paramInfoTid = 1078184,  unique = true }
	ActionsWindow.ActionData[4133] = { group = 1154982, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875033, nameTid = 1049028, detailTid = 1115131, editWindow = "Equip",	paramInfoTid = 1078184,  unique = true }
	ActionsWindow.ActionData[4134] = { group = 1154982, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875034, nameTid = 1049029, detailTid = 1115131, editWindow = "Equip",	paramInfoTid = 1078184,  unique = true }
	ActionsWindow.ActionData[4135] = { group = 1154982, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875035, nameTid = 1049030, detailTid = 1115131, editWindow = "Equip",	paramInfoTid = 1078184,  unique = true }
	ActionsWindow.ActionData[4136] = { group = 1154982, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875036, nameTid = 1049031, detailTid = 1115131, editWindow = "Equip",	paramInfoTid = 1078184,  unique = true }
	ActionsWindow.ActionData[4137] = { group = 1154982, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875011, nameTid = 3514,	   detailTid = 3014,	editWindow = "Custom",							 unique = true,		macroOnly = true }
	ActionsWindow.ActionData[4138] = { group = 1154982, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875037, nameTid = 4002,	   detailTid = 1115131, editWindow = "Equip",	paramInfoTid = 1078184,  }
	ActionsWindow.ActionData[4139] = { group = 1154982, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875038, nameTid = 3524,	   detailTid = 3024,	editWindow = "UnEquip",	paramInfoTid = 1078185,	 callback = L"script Actions.EquipLast({ ~1_slotId~ }, ~2_hotbarId~, ~3_slot~, ~4_index~)", unique = true,		macroOnly = true }
	
	
	-- 4300 -> 4349 :  SUPER SLAYERS
	ActionsWindow.ActionData[4300] = { group = 1155463, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875200, nameTid = 1079747, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
	ActionsWindow.ActionData[4301] = { group = 1155463, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875201, nameTid = 1079748, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
	ActionsWindow.ActionData[4302] = { group = 1155463, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875202, nameTid = 1079749, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
	ActionsWindow.ActionData[4303] = { group = 1155463, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875203, nameTid = 1070855, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
	ActionsWindow.ActionData[4304] = { group = 1155463, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875204, nameTid = 1079750, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
	ActionsWindow.ActionData[4305] = { group = 1155463, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875205, nameTid = 1079751, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
	ActionsWindow.ActionData[4306] = { group = 1155463, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875206, nameTid = 1079752, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
	ActionsWindow.ActionData[4307] = { group = 1155463, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875207, nameTid = 1156126, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
					
	-- 4350 -> 4399 :  SLAYERS		
	ActionsWindow.ActionData[4350] = { group = 1155464, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875250, nameTid = 1079743, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
	ActionsWindow.ActionData[4351] = { group = 1155464, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875251, nameTid = 1079746, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
	ActionsWindow.ActionData[4352] = { group = 1155464, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875252, nameTid = 1079753, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
	ActionsWindow.ActionData[4353] = { group = 1155464, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875253, nameTid = 1079737, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
	ActionsWindow.ActionData[4354] = { group = 1155464, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875254, nameTid = 1079733, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
	ActionsWindow.ActionData[4355] = { group = 1155464, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875255, nameTid = 1079734, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
	ActionsWindow.ActionData[4356] = { group = 1155464, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875256, nameTid = 1079735, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
	ActionsWindow.ActionData[4357] = { group = 1155464, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875257, nameTid = 1079736, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
	ActionsWindow.ActionData[4358] = { group = 1155464, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875258, nameTid = 1079742, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
	ActionsWindow.ActionData[4359] = { group = 1155464, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875259, nameTid = 1079745, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
	ActionsWindow.ActionData[4360] = { group = 1155464, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875260, nameTid = 1079755, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
	ActionsWindow.ActionData[4361] = { group = 1155464, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875261, nameTid = 1079741, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
	ActionsWindow.ActionData[4362] = { group = 1155464, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875262, nameTid = 1079739, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
	ActionsWindow.ActionData[4363] = { group = 1155464, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875263, nameTid = 1079754, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
	ActionsWindow.ActionData[4364] = { group = 1155464, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875264, nameTid = 1061284, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
	ActionsWindow.ActionData[4365] = { group = 1155464, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875265, nameTid = 1079738, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
	ActionsWindow.ActionData[4366] = { group = 1155464, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875266, nameTid = 1079740, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
	ActionsWindow.ActionData[4367] = { group = 1155464, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875267, nameTid = 1079744, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
	ActionsWindow.ActionData[4368] = { group = 1155464, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875269, nameTid = 1075462, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
	ActionsWindow.ActionData[4369] = { group = 1155464, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875268, nameTid = 1072512, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
	ActionsWindow.ActionData[4370] = { group = 1155464, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875270, nameTid = 1156347, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
	ActionsWindow.ActionData[4371] = { group = 1155464, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875271, nameTid = 1156345, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
	ActionsWindow.ActionData[4372] = { group = 1155464, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875272, nameTid = 1156346, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
																								
	-- 4400 -> 4449 : TALISMAN SLAYERS																																					  
	ActionsWindow.ActionData[4400] = { group = 1155465, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875300, nameTid = 1072506, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
	ActionsWindow.ActionData[4401] = { group = 1155465, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875301, nameTid = 1072504, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
	ActionsWindow.ActionData[4402] = { group = 1155465, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875302, nameTid = 1072508, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
	ActionsWindow.ActionData[4403] = { group = 1155465, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875303, nameTid = 1072509, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
	ActionsWindow.ActionData[4404] = { group = 1155465, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875304, nameTid = 1072512, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
	ActionsWindow.ActionData[4405] = { group = 1155465, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875305, nameTid = 1072511, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
	ActionsWindow.ActionData[4406] = { group = 1155465, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875306, nameTid = 1072510, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
	ActionsWindow.ActionData[4407] = { group = 1155465, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875307, nameTid = 1072507, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
	ActionsWindow.ActionData[4408] = { group = 1155465, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875308, nameTid = 1079752, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
	ActionsWindow.ActionData[4409] = { group = 1155465, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875309, nameTid = 1072505, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
	ActionsWindow.ActionData[4410] = { group = 1155465, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875310, nameTid = 1095010, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
																												
	-- 4450 -> 4499 :  WORKER'S TALISMAN																												
	ActionsWindow.ActionData[4450] = { group = 1155466, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875450, nameTid = 1155108, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
	ActionsWindow.ActionData[4451] = { group = 1155466, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875451, nameTid = 1155109, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
	ActionsWindow.ActionData[4452] = { group = 1155466, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875452, nameTid = 1155110, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
	ActionsWindow.ActionData[4453] = { group = 1155466, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875453, nameTid = 1155111, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
	ActionsWindow.ActionData[4454] = { group = 1155466, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875454, nameTid = 1155112, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
	ActionsWindow.ActionData[4455] = { group = 1155466, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875455, nameTid = 1155113, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
	ActionsWindow.ActionData[4456] = { group = 1155466, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875456, nameTid = 1155114, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
	ActionsWindow.ActionData[4457] = { group = 1155466, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875457, nameTid = 1155115, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
	ActionsWindow.ActionData[4458] = { group = 1155466, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875458, nameTid = 1155116, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
	ActionsWindow.ActionData[4459] = { group = 1155466, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875459, nameTid = 1155117, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }
	ActionsWindow.ActionData[4460] = { group = 1155466, type = SystemData.UserAction.TYPE_EQUIP_ITEMS,					inActionWindow = true, iconId = 875460, nameTid = 1155118, detailTid = 1115131, editWindow = "Equip", paramInfoTid = 1078184 }


	-- 5001 -> 5099 :  MENU ACTIONS
	ActionsWindow.ActionData[3]   =	   { group = 1154979, type = SystemData.UserAction.TYPE_TOGGLE_WAR_MODE,				inActionWindow = true, iconId = 635,	nameTid = 3002081, detailTid = 1115133 }
	ActionsWindow.ActionData[88]  =	   { group = 1154979, type = SystemData.UserAction.TYPE_QUIT_GAME,						inActionWindow = true, iconId = 795,	nameTid = 1114308, detailTid = 1115210, settingKeyBinding = "QUIT_GAME" }
	ActionsWindow.ActionData[89]  =	   { group = 1154979, type = SystemData.UserAction.TYPE_LOG_OUT,						inActionWindow = true, iconId = 796,	nameTid = 1115334, detailTid = 1115335, settingKeyBinding = "LOG_OUT" }
	ActionsWindow.ActionData[5001] =   { group = 1154979, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 860001, nameTid = 1077438,						callback = L"script Actions.ToggleMapWindow()", settingKeyBinding = "WORLD_MAP_WINDOW", unique = true }
	ActionsWindow.ActionData[5002] =   { group = 1154979, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 860002, nameTid = 1049755,						callback = L"script Actions.ToggleMainMenu()", settingKeyBinding = "CANCEL", unique = true }
	ActionsWindow.ActionData[5003] =   { group = 1154979, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 860003, nameTid = 1077440,						callback = L"script Actions.ToggleQuestWindow()", settingKeyBinding = "QUEST_LOG_WINDOW", unique = true}
	ActionsWindow.ActionData[5004] =   { group = 1154979, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 860004, nameTid = 1077439,						callback = L"script Actions.ToggleVirtuesWindow()", unique = true}
	ActionsWindow.ActionData[5005] =   { group = 1154979, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 860005, nameTid = 1063308,						callback = L"script Actions.ToggleGuildWindow()", unique = true }
	ActionsWindow.ActionData[5006] =   { group = 1154979, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 860006, nameTid = 3000133,						callback = L"script Actions.TogglePaperdollWindow()", settingKeyBinding = "PAPERDOLL_CHARACTER_WINDOW", unique = true }
	ActionsWindow.ActionData[5007] =   { group = 1154979, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 860007, nameTid = 3000084,						callback = L"script Actions.ToggleSkillsWindow()", settingKeyBinding = "SKILLS_WINDOW", unique = true }
	ActionsWindow.ActionData[5009] =   { group = 1154979, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 860009, nameTid = 1077437,						callback = L"script Actions.ToggleCharacterSheet()", unique = true }
	ActionsWindow.ActionData[5010] =   { group = 1154979, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 860010, nameTid = 1112228,						callback = L"script Actions.ToggleCharacterAbilities()", unique = true }
	ActionsWindow.ActionData[5011] =   { group = 1154979, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 860011, nameTid = 1022482,						callback = L"script Actions.ToggleInventoryWindow()", settingKeyBinding = "BACKPACK_WINDOW", unique = true }
	ActionsWindow.ActionData[5013] =   { group = 1154979, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 860013, nameTid = 1077814,						callback = L"script Actions.ToggleUserSettings()", unique = true }
	ActionsWindow.ActionData[5014] =   { group = 1154979, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 860014, nameTid = 1079812,						callback = L"script Actions.ToggleActions()", unique = true}
	ActionsWindow.ActionData[5015] =   { group = 1154979, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 860015, nameTid = 3000172,						callback = L"script Actions.ToggleMacros()", unique = true }
	ActionsWindow.ActionData[5016] =   { group = 1154979, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 860016, nameTid = 1061037,						callback = L"script Actions.ToggleHelpWindow()", unique = true }
	ActionsWindow.ActionData[5017] =   { group = 1154979, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 860017, nameTid = 1157353,						callback = L"script Actions.ToggleUOStoreWindow()", unique = true }

	-- 5100 -> 5119 :  COMMUNICATION ACTIONS
	ActionsWindow.ActionData[4]   =	  { group = 1094744, type = SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow = true, iconId = 632,	nameTid = 3002076,	detailTid = 1115134, editWindow = "Text", paramInfoTid = 3002006 }
	ActionsWindow.ActionData[5]   =	  { group = 1094744, type = SystemData.UserAction.TYPE_SPEECH_EMOTE,				inActionWindow = true, iconId = 624,	nameTid = 3002077,	detailTid = 1115135, editWindow = "Text", paramInfoTid = 3002007 }
	ActionsWindow.ActionData[6]   =	  { group = 1094744, type = SystemData.UserAction.TYPE_SPEECH_WHISPER,				inActionWindow = true, iconId = 638,	nameTid = 3002078,	detailTid = 1115136, editWindow = "Text", paramInfoTid = 3002009 }
	ActionsWindow.ActionData[7]   =	  { group = 1094744, type = SystemData.UserAction.TYPE_SPEECH_YELL,					inActionWindow = true, iconId = 639,	nameTid = 3002079,	detailTid = 1115137, editWindow = "Text", paramInfoTid = 3002010 }
	ActionsWindow.ActionData[12]  =	  { group = 1094744, type = SystemData.UserAction.TYPE_BOW,							inActionWindow = true, iconId = 622,	nameTid = 3002093,	detailTid = 1115142, unique = true }
	ActionsWindow.ActionData[13]  =	  { group = 1094744, type = SystemData.UserAction.TYPE_SALUTE,						inActionWindow = true, iconId = 631,	nameTid = 3002094,	detailTid = 1115143, unique = true }
	ActionsWindow.ActionData[5100]  = { group = 1094744, type = SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow = true, iconId = 855002, nameTid = 1023083,	detailTid = 1154984, paramInfoTid = 3002006, callback = L"Bank", unique = true}
	ActionsWindow.ActionData[5101]  = { group = 1094744, type = SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow = true, iconId = 855005, nameTid = 1076893,	detailTid = 1154985, paramInfoTid = 3002006, callback = L"Guards ! Help Me !!!", unique = true}
	ActionsWindow.ActionData[5102]  = { group = 1094744, type = SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow = true, iconId = 855008, nameTid = 1154983,	detailTid = 1154986, editWindow = "Text", paramInfoTid = 3002006, callback = L"Vendor Buy", unique = true}
	ActionsWindow.ActionData[5103]  = { group = 1094744, type = SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow = true, iconId = 855011, nameTid = 1154987,	detailTid = 1154988, editWindow = "Text", paramInfoTid = 3002006, callback = L"Vendor Sell", unique = true}
	ActionsWindow.ActionData[5104]  = { group = 1094744, type = SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow = true, iconId = 855014, nameTid = 3533,		detailTid = 1154990, paramInfoTid = 3002006, callback = L"Recsu", unique = true}
	ActionsWindow.ActionData[5105]  = { group = 1094744, type = SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow = true, iconId = 855015, nameTid = 3534,		detailTid = 3041,	 editWindow = "Text", paramInfoTid = 3002006, callback = L"Recdu", unique = true}
	ActionsWindow.ActionData[5106]  = { group = 1094744, type = SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow = true, iconId = 855016, nameTid = 1154989,	detailTid = 1154991, paramInfoTid = 3002006, callback = L"I must consider my sins", unique = true}
	ActionsWindow.ActionData[5107]  = { group = 1094744, type = SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow = true, iconId = 855003, nameTid = 1112634,	detailTid = 1154992, paramInfoTid = 3002006, callback = L"Balance", unique = true}
	ActionsWindow.ActionData[5108]  = { group = 1094744, type = SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow = true, iconId = 855017, nameTid = 1154993,	detailTid = 1154994, paramInfoTid = 3002006, callback = L"Ord", unique = true}
	ActionsWindow.ActionData[5109]  = { group = 1094744, type = SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow = true, iconId = 855018, nameTid = 1154995,	detailTid = 1154996, paramInfoTid = 3002006, callback = L"An Ord", unique = true}
	ActionsWindow.ActionData[5112]  = { group = 1094744, type = SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow = true, iconId = 713, 	nameTid = 1154999,	detailTid = 1155000, paramInfoTid = 3002006, callback = L"I Wish To Secure This", unique = true}
	ActionsWindow.ActionData[5113]  = { group = 1094744, type = SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow = true, iconId = 714, 	nameTid = 1155001,	detailTid = 1155002, paramInfoTid = 3002006, callback = L"I Wish To Release This", unique = true}
	ActionsWindow.ActionData[5114]  = { group = 1094744, type = SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow = true, iconId = 715, 	nameTid = 1155003,	detailTid = 1155004, paramInfoTid = 3002006, callback = L"I Wish To Lock This Down", unique = true}
	ActionsWindow.ActionData[5115]  = { group = 1094744, type = SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow = true, iconId = 855020, nameTid = 1155005,	detailTid = 1155006, paramInfoTid = 3002006, callback = L"I Wish To Place A Trash Barrel", unique = true}
	ActionsWindow.ActionData[5116]  = { group = 1094744, type = SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow = true, iconId = 855022, nameTid = 3535,		detailTid = 3042,	 paramInfoTid = 3002006, callback = L"News", unique = true}
	ActionsWindow.ActionData[5117]  = { group = 1094744, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 855028, nameTid = 1155261,	detailTid = 1155262, callback = L"script ContextMenu.RequestContextAction(TargetWindow.TargetId, ContextMenu.DefaultValues.BodRequest)", unique = true}
	ActionsWindow.ActionData[5118]  = { group = 1094744, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 855030, nameTid = 1155267,	detailTid = 1155268, callback = L"script ContextMenu.RequestContextAction(TargetWindow.TargetId, ContextMenu.DefaultValues.Bribe)", unique = true}

	-- 5120 -> 5149 : PET COMMANDS
	ActionsWindow.ActionData[29]  =	  { group = 1079385, type = SystemData.UserAction.TYPE_PET_COMMAND_ALLKILL,			inActionWindow = true, iconId = 650,	nameTid = 1079300,	detailTid = 1115158, unique = true }
	ActionsWindow.ActionData[30]  =	  { group = 1079385, type = SystemData.UserAction.TYPE_PET_COMMAND_COME,			inActionWindow = true, iconId = 651,	nameTid = 1079301,	detailTid = 1115159, unique = true }
	ActionsWindow.ActionData[31]  =	  { group = 1079385, type = SystemData.UserAction.TYPE_PET_COMMAND_FOLLOW,			inActionWindow = true, iconId = 655,	nameTid = 1079302,	detailTid = 1115160, unique = true }
	ActionsWindow.ActionData[32]  =	  { group = 1079385, type = SystemData.UserAction.TYPE_PET_COMMAND_FOLLOWME,		inActionWindow = true, iconId = 656,	nameTid = 1079303,	detailTid = 1115161, unique = true }
	ActionsWindow.ActionData[34]  =	  { group = 1079385, type = SystemData.UserAction.TYPE_PET_COMMAND_GUARDME,			inActionWindow = true, iconId = 658,	nameTid = 1079305,	detailTid = 1115162, unique = true }
	ActionsWindow.ActionData[35]  =	  { group = 1079385, type = SystemData.UserAction.TYPE_PET_COMMAND_STAY,			inActionWindow = true, iconId = 661,	nameTid = 1079306,	detailTid = 1115164, unique = true }
	ActionsWindow.ActionData[36]  =	  { group = 1079385, type = SystemData.UserAction.TYPE_PET_COMMAND_STOP,			inActionWindow = true, iconId = 660,	nameTid = 1079307,	detailTid = 1115165, unique = true }
	ActionsWindow.ActionData[5120]  = { group = 1079385, type = SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow = true, iconId = 855012, nameTid = 1154997 , detailTid = 1154998, paramInfoTid = 3002006, callback = L"Stable", unique = true}
	ActionsWindow.ActionData[5121]  = { group = 1079385, type = SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow = true, iconId = 855013, nameTid = 3532,		detailTid = 1155008, paramInfoTid = 3002006, callback = L"Claim Pet", unique = true}
	ActionsWindow.ActionData[5122]  = { group = 1079385, type = SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow = true, iconId = 855021, nameTid = 1155007,	detailTid = 3039,	 paramInfoTid = 3002006, callback = L"Stablecount", unique = true}
	ActionsWindow.ActionData[5123]  = { group = 1079385, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 855029, nameTid = 1155424,	detailTid = 1155429, callback = L"script Actions.AllRelease()", unique = true }
	
	-- 5150 -> 5169 : BOAT COMMANDS
	ActionsWindow.ActionData[37] = { group = 1079386, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 668, nameTid = Actions.GetBoatCommandNameTid(Actions.BoatCommands.ForwardLeft),		detailTid = Actions.GetBoatCommandDetailTid(Actions.BoatCommands.ForwardLeft),	 callback = L"script Actions.BoatCommand(Actions.BoatCommands.ForwardLeft)", unique = true }
	ActionsWindow.ActionData[38] = { group = 1079386, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 669, nameTid = Actions.GetBoatCommandNameTid(Actions.BoatCommands.ForwardRight),	detailTid = Actions.GetBoatCommandDetailTid(Actions.BoatCommands.ForwardRight),	 callback = L"script Actions.BoatCommand(Actions.BoatCommands.ForwardRight)", unique = true }
	ActionsWindow.ActionData[39] = { group = 1079386, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 667, nameTid = Actions.GetBoatCommandNameTid(Actions.BoatCommands.Forward),			detailTid = Actions.GetBoatCommandDetailTid(Actions.BoatCommands.Forward),		 callback = L"script Actions.BoatCommand(Actions.BoatCommands.Forward)", unique = true }
	ActionsWindow.ActionData[40] = { group = 1079386, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 653, nameTid = Actions.GetBoatCommandNameTid(Actions.BoatCommands.BackLeft),		detailTid = Actions.GetBoatCommandDetailTid(Actions.BoatCommands.BackLeft),		 callback = L"script Actions.BoatCommand(Actions.BoatCommands.BackLeft)", unique = true }
	ActionsWindow.ActionData[41] = { group = 1079386, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 654, nameTid = Actions.GetBoatCommandNameTid(Actions.BoatCommands.BackRight), 		detailTid = Actions.GetBoatCommandDetailTid(Actions.BoatCommands.BackRight), 	 callback = L"script Actions.BoatCommand(Actions.BoatCommands.BackRight)", unique = true }
	ActionsWindow.ActionData[42] = { group = 1079386, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 652, nameTid = Actions.GetBoatCommandNameTid(Actions.BoatCommands.Back),			detailTid = Actions.GetBoatCommandDetailTid(Actions.BoatCommands.Back),			 callback = L"script Actions.BoatCommand(Actions.BoatCommands.Back)", unique = true }
	ActionsWindow.ActionData[43] = { group = 1079386, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 664, nameTid = Actions.GetBoatCommandNameTid(Actions.BoatCommands.Left),			detailTid = Actions.GetBoatCommandDetailTid(Actions.BoatCommands.Left),			 callback = L"script Actions.BoatCommand(Actions.BoatCommands.Left)", unique = true }
	ActionsWindow.ActionData[44] = { group = 1079386, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 665, nameTid = Actions.GetBoatCommandNameTid(Actions.BoatCommands.Right),			detailTid = Actions.GetBoatCommandDetailTid(Actions.BoatCommands.Right),		 callback = L"script Actions.BoatCommand(Actions.BoatCommands.Right)", unique = true }
	ActionsWindow.ActionData[45] = { group = 1079386, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 670, nameTid = 1079320, detailTid = 1115174, callback = L"script Actions.BoatCommand(Actions.BoatCommands.TurnLeft)", unique = true }
	ActionsWindow.ActionData[46] = { group = 1079386, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 672, nameTid = 1079321, detailTid = 1115175, callback = L"script Actions.BoatCommand(Actions.BoatCommands.TurnRight)", unique = true }
	ActionsWindow.ActionData[47] = { group = 1079386, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 662, nameTid = 1079322, detailTid = 1115176, callback = L"script Actions.BoatCommand(Actions.BoatCommands.TurnAround)", unique = true }
	ActionsWindow.ActionData[48] = { group = 1079386, type = SystemData.UserAction.TYPE_BOAT_COMMAND_DORACRON,			inActionWindow = true, iconId = 663, nameTid = 1079323, detailTid = 1115177, unique = true }
	ActionsWindow.ActionData[49] = { group = 1079386, type = SystemData.UserAction.TYPE_BOAT_COMMAND_SUEACRON,			inActionWindow = true, iconId = 674, nameTid = 1079324, detailTid = 1115178, unique = true }
	ActionsWindow.ActionData[50] = { group = 1079386, type = SystemData.UserAction.TYPE_SPEECH_SAY,						inActionWindow = true, iconId = 673, nameTid = 1052073, detailTid = 1115179, callback = L"Furl Sail", unique = true  }
	ActionsWindow.ActionData[53] = { group = 1079386, type = SystemData.UserAction.TYPE_SPEECH_SAY,						inActionWindow = true, iconId = 694, nameTid = 3005113, detailTid = 1115182, callback = L"Start", unique = true }
	ActionsWindow.ActionData[54] = { group = 1079386, type = SystemData.UserAction.TYPE_SPEECH_SAY,						inActionWindow = true, iconId = 695, nameTid = 1052072, detailTid = 1115183, callback = L"Continue", unique = true }

	-- are the smart commands active?
	if Interface.Settings.SmartBoatCommands then
		ActionsWindow.ActionData[5150] = { group = 1079386, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,		inActionWindow = true, iconId = 00709, 	nameTid = 3519, detailTid = 3019, paramInfoTid = 3002006, callback = L"script Actions.BoatCommand(Actions.BoatCommands.SlowForward)", unique = true }
		ActionsWindow.ActionData[5151] = { group = 1079386, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,		inActionWindow = true, iconId = 00710, 	nameTid = 3520, detailTid = 3020, callback = L"script Actions.BoatCommand(Actions.BoatCommands.SlowBack)", unique = true }
		ActionsWindow.ActionData[5152] = { group = 1079386, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,		inActionWindow = true, iconId = 855031, nameTid = 3521, detailTid = 3021, callback = L"script Actions.FixSmartBoatDirections()", unique = true }

	else -- normal controls
		ActionsWindow.ActionData[5150] = { group = 1079386, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,		inActionWindow = true, iconId = 00709, 	nameTid = 1155011, detailTid = 1155012, paramInfoTid = 3002006, callback = L"script Actions.BoatCommand(Actions.BoatCommands.SlowForward)", unique = true }
		ActionsWindow.ActionData[5151] = { group = 1079386, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,		inActionWindow = true, iconId = 00711, 	nameTid = 1155013, detailTid = 1155014, paramInfoTid = 3002006, callback = L"script Actions.BoatCommand(Actions.BoatCommands.ForwardOne)", unique = true }
		ActionsWindow.ActionData[5152] = { group = 1079386, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,		inActionWindow = true, iconId = 00710, 	nameTid = 1155015, detailTid = 1155016, callback = L"script Actions.BoatCommand(Actions.BoatCommands.SlowBack)", unique = true }
		ActionsWindow.ActionData[5153] = { group = 1079386, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,		inActionWindow = true, iconId = 00712, 	nameTid = 1155017, detailTid = 1155018, paramInfoTid = 3002006, callback = L"script Actions.BoatCommand(Actions.BoatCommands.BackOne)", unique = true }
	end

	ActionsWindow.ActionData[5154] = { group = 1079386, type = SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow = true, iconId = 855025, nameTid = 1155019, detailTid = 1155020, paramInfoTid = 3002006, callback = L"Start Tracking", unique = true }
	ActionsWindow.ActionData[5155] = { group = 1079386, type = SystemData.UserAction.TYPE_SPEECH_SAY,					inActionWindow = true, iconId = 855026, nameTid = 4001,	   detailTid = 207,		paramInfoTid = 3002006, callback = L"Stop Tracking", unique = true }
	ActionsWindow.ActionData[5156] = { group = 1079386, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 855027, nameTid = 1155096, detailTid = 1155097, editWindow = "Custom", macroOnly = true }
	ActionsWindow.ActionData[5157] = { group = 1079386, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 855032, nameTid = 3525,	   detailTid = 3025,	callback = L"script Actions.NearestSoS()", unique = true }
	
	-- 5170 -> 5199 : OTHER COMMUNICATIONS ACTIONS
	ActionsWindow.ActionData[5170]  = { group = 1094744, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 00716, nameTid = 3500, detailTid = 3000, editWindow = "Text", paramInfoTid = 3002006 }
	ActionsWindow.ActionData[5171]  = { group = 1094744, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 00717, nameTid = 3501, detailTid = 3001, editWindow = "Text", paramInfoTid = 3002006 }
	ActionsWindow.ActionData[5172]  = { group = 1094744, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 00720, nameTid = 3502, detailTid = 3002, editWindow = "Text", paramInfoTid = 3002006 }
	ActionsWindow.ActionData[5173]  = { group = 1094744, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 00721, nameTid = 3503, detailTid = 3003, editWindow = "Text", paramInfoTid = 3002006 }
	ActionsWindow.ActionData[5174]  = { group = 1094744, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 00722, nameTid = 3504, detailTid = 3004, editWindow = "Text", paramInfoTid = 3002006 }
			
	-- 5200 -> 5299 :  TARGETING ACTIONS
	ActionsWindow.ActionData[11] =   { group = 1079383, type = SystemData.UserAction.TYPE_USE_TARGETED_OBJECT,			inActionWindow = true, iconId = 646,	nameTid = 1079159,	detailTid = 1115141, unique = true }
	ActionsWindow.ActionData[22] =   { group = 1079383, type = SystemData.UserAction.TYPE_TARGET_NEXT_FRIENDLY,			inActionWindow = true, iconId = 647,	nameTid = 1079177,	detailTid = 1115151, settingKeyBinding = "NEXT_FRIENDLY_TARGET", unique = true }
	ActionsWindow.ActionData[23] =   { group = 1079383, type = SystemData.UserAction.TYPE_TARGET_NEXT_ENEMY,			inActionWindow = true, iconId = 648,	nameTid = 1079178,	detailTid = 1115152, settingKeyBinding = "NEXT_ENEMY_TARGET", unique = true }
	ActionsWindow.ActionData[24] =   { group = 1079383, type = SystemData.UserAction.TYPE_TARGET_NEXT_GROUPMEMBER,		inActionWindow = true, iconId = 649,	nameTid = 1079179,	detailTid = 1115153, settingKeyBinding = "NEXT_GROUP_TARGET", unique = true }
	ActionsWindow.ActionData[25] =   { group = 1079383, type = SystemData.UserAction.TYPE_TARGET_NEXT,					inActionWindow = true, iconId = 708,	nameTid = 1094824,	detailTid = 1115154, settingKeyBinding = "NEXT_TARGET", unique = true }
	ActionsWindow.ActionData[55] =   { group = 1079383, type = SystemData.UserAction.TYPE_TARGET_BY_RESOURCE,			inActionWindow = true, iconId = 770,	nameTid = 1079430,	detailTid = 1115184, editWindow = "TargetByResource", paramInfoTid = 1079430 }
	ActionsWindow.ActionData[69] =   { group = 1079383, type = SystemData.UserAction.TYPE_TARGET_NEXT_FOLLOWER,			inActionWindow = true, iconId = 775,	nameTid = 1112416,	detailTid = 1115191, settingKeyBinding = "NEXT_FOLLOWER_TARGET", unique = true }
	ActionsWindow.ActionData[70] =   { group = 1079383, type = SystemData.UserAction.TYPE_TARGET_NEXT_OBJECT,			inActionWindow = true, iconId = 776,	nameTid = 1112420,	detailTid = 1115192, settingKeyBinding = "NEXT_OBJECT_TARGET", unique = true }
	ActionsWindow.ActionData[71] =   { group = 1079383, type = SystemData.UserAction.TYPE_TARGET_PREVIOUS_FRIENDLY,		inActionWindow = true, iconId = 777,	nameTid = 1112431,	detailTid = 1115193, settingKeyBinding = "PREVIOUS_FRIENDLY_TARGET", unique = true }
	ActionsWindow.ActionData[72] =   { group = 1079383, type = SystemData.UserAction.TYPE_TARGET_PREVIOUS_ENEMY,		inActionWindow = true, iconId = 778,	nameTid = 1112432,	detailTid = 1115194, settingKeyBinding = "PREVIOUS_ENEMY_TARGET", unique = true }
	ActionsWindow.ActionData[73] =   { group = 1079383, type = SystemData.UserAction.TYPE_TARGET_PREVIOUS_GROUPMEMBER,	inActionWindow = true, iconId = 779,	nameTid = 1112433,	detailTid = 1115195, settingKeyBinding = "PREVIOUS_GROUP_TARGET", unique = true }
	ActionsWindow.ActionData[74] =   { group = 1079383, type = SystemData.UserAction.TYPE_TARGET_PREVIOUS_FOLLOWER,		inActionWindow = true, iconId = 780,	nameTid = 1112434,	detailTid = 1115196, settingKeyBinding = "PREVIOUS_FOLLOWER_TARGET", unique = true }
	ActionsWindow.ActionData[75] =   { group = 1079383, type = SystemData.UserAction.TYPE_TARGET_PREVIOUS_OBJECT,		inActionWindow = true, iconId = 781,	nameTid = 1112435,	detailTid = 1115197, settingKeyBinding = "PREVIOUS_OBJECT_TARGET", unique = true }
	ActionsWindow.ActionData[76] =   { group = 1079383, type = SystemData.UserAction.TYPE_TARGET_PREVIOUS,				inActionWindow = true, iconId = 782,	nameTid = 1112436,	detailTid = 1115198, settingKeyBinding = "PREVIOUS_TARGET", unique = true }
	ActionsWindow.ActionData[77] =   { group = 1079383, type = SystemData.UserAction.TYPE_TARGET_NEAREST_FRIENDLY,		inActionWindow = true, iconId = 783,	nameTid = 1112437,	detailTid = 1115199, settingKeyBinding = "NEAREST_FRIENDLY_TARGET", unique = true }
	ActionsWindow.ActionData[78] =   { group = 1079383, type = SystemData.UserAction.TYPE_TARGET_NEAREST_ENEMY,			inActionWindow = true, iconId = 784,	nameTid = 1112438,	detailTid = 1115200, settingKeyBinding = "NEAREST_ENEMY_TARGET", unique = true }
	ActionsWindow.ActionData[79] =   { group = 1079383, type = SystemData.UserAction.TYPE_TARGET_NEAREST_GROUPMEMBER,	inActionWindow = true, iconId = 785,	nameTid = 1112439,	detailTid = 1115201, settingKeyBinding = "NEAREST_GROUP_TARGET", unique = true }
	ActionsWindow.ActionData[80] =   { group = 1079383, type = SystemData.UserAction.TYPE_TARGET_NEAREST_FOLLOWER,		inActionWindow = true, iconId = 786,	nameTid = 1112440,	detailTid = 1115202, settingKeyBinding = "NEAREST_FOLLOWER_TARGET", unique = true }
	ActionsWindow.ActionData[81] =   { group = 1079383, type = SystemData.UserAction.TYPE_TARGET_NEAREST_OBJECT,		inActionWindow = true, iconId = 787,	nameTid = 1112441,	detailTid = 1115203, settingKeyBinding = "NEAREST_OBJECT_TARGET", unique = true }
	ActionsWindow.ActionData[82] =   { group = 1079383, type = SystemData.UserAction.TYPE_TARGET_NEAREST,				inActionWindow = true, iconId = 788,	nameTid = 1112442,	detailTid = 1115204, settingKeyBinding = "NEAREST_TARGET", unique = true }
	ActionsWindow.ActionData[5200] = { group = 1079383, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 865000, nameTid = 1155021,	detailTid = 1155022, callback = L"script Actions.PrevTarget()", unique = true }
	ActionsWindow.ActionData[5201] = { group = 1079383, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 708, 	nameTid = 1155023,  detailTid = 3040,	 callback = L"script Actions.NextTarget(~1_NOTO~)" }
	ActionsWindow.ActionData[5202] = { group = 1079383, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 788, 	nameTid = 1155025,  detailTid = 3040,	 callback = L"script Actions.NearTarget(~1_NOTO~)" }
	ActionsWindow.ActionData[5203] = { group = 1079383, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 865001, nameTid = 1155027,  detailTid = 1155028, callback = L"script Actions.InjuredFollower()", unique = true }
	ActionsWindow.ActionData[5204] = { group = 1079383, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 865002, nameTid = 1155029,  detailTid = 3040,	 callback = L"script Actions.InjuredMobile(~1_NOTO~)" }
	ActionsWindow.ActionData[5205] = { group = 1079383, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 865003, nameTid = 1155031,  detailTid = 1155032, callback = L"script Actions.InjuredParty()", unique = true }
	ActionsWindow.ActionData[5206] = { group = 1079383, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 865004, nameTid = 1155033,  detailTid = 3045,	 editWindow = "TargetByObjectId",  paramInfoTid = 1094788, callback = L"script Actions.TargetFirstContainerObject(~1_TARGET~)" }
	ActionsWindow.ActionData[5207] = { group = 1079383, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 865005, nameTid = 1155035,	detailTid = 3046,	 editWindow = "Custom", callback = L"script Actions.TargetByType(~1_TYPE~, ~2_HUE~)" }
	ActionsWindow.ActionData[5208] = { group = 1079383, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 865006, nameTid = 3523,		detailTid = 3023,	 callback = L"script BuoyTool.TargetNearest()" }
	ActionsWindow.ActionData[5209] = { group = 1079383, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 865007, nameTid = 3529,		detailTid = 3029,	 callback = L"script Actions.TargetBoss()" }
	ActionsWindow.ActionData[5210] = { group = 1079383, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 865008, nameTid = 3538,		detailTid = 3049,	 callback = L"script Actions.TargetClosestCorpse(~1_FLAGS~)" }

	
	-- 5300 -> 5350 :  PET TARGETING ACTIONS (STORE)
	ActionsWindow.ActionData[5301] = { group = 1154968, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 870000, detailString = ReplaceTokens(GetStringFromTid(1155038), {L"1"}), nameString = ReplaceTokens(GetStringFromTid(1155037), {L"1"}), callback = L"script Actions.TargetDefaultPet(1)", unique = true }
	ActionsWindow.ActionData[5302] = { group = 1154968, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 870001, detailString = ReplaceTokens(GetStringFromTid(1155038), {L"2"}), nameString = ReplaceTokens(GetStringFromTid(1155037), {L"2"}), callback = L"script Actions.TargetDefaultPet(2)", unique = true }
	ActionsWindow.ActionData[5303] = { group = 1154968, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 870002, detailString = ReplaceTokens(GetStringFromTid(1155038), {L"3"}), nameString = ReplaceTokens(GetStringFromTid(1155037), {L"3"}), callback = L"script Actions.TargetDefaultPet(3)", unique = true }
	ActionsWindow.ActionData[5304] = { group = 1154968, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 870003, detailString = ReplaceTokens(GetStringFromTid(1155038), {L"4"}), nameString = ReplaceTokens(GetStringFromTid(1155037), {L"4"}), callback = L"script Actions.TargetDefaultPet(4)", unique = true }
	ActionsWindow.ActionData[5305] = { group = 1154968, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 870004, detailString = ReplaceTokens(GetStringFromTid(1155038), {L"5"}), nameString = ReplaceTokens(GetStringFromTid(1155037), {L"5"}), callback = L"script Actions.TargetDefaultPet(5)", unique = true }
	
	-- 5351 -> 5399 :  PET TARGETING ACTIONS (TARGETING)
	ActionsWindow.ActionData[5351] = { group = 1154968, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 870050, detailString = ReplaceTokens(GetStringFromTid(3047), {L"1"}), nameString = ReplaceTokens(GetStringFromTid(1155039), {L"1"}), callback = L"script HandleSingleLeftClkTarget( Interface.DefaultPet1 )", unique = true }
	ActionsWindow.ActionData[5352] = { group = 1154968, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 870051, detailString = ReplaceTokens(GetStringFromTid(3047), {L"2"}), nameString = ReplaceTokens(GetStringFromTid(1155039), {L"2"}), callback = L"script HandleSingleLeftClkTarget( Interface.DefaultPet2 )", unique = true }
	ActionsWindow.ActionData[5353] = { group = 1154968, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 870052, detailString = ReplaceTokens(GetStringFromTid(3047), {L"3"}), nameString = ReplaceTokens(GetStringFromTid(1155039), {L"3"}), callback = L"script HandleSingleLeftClkTarget( Interface.DefaultPet3 )", unique = true }
	ActionsWindow.ActionData[5354] = { group = 1154968, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 870053, detailString = ReplaceTokens(GetStringFromTid(3047), {L"4"}), nameString = ReplaceTokens(GetStringFromTid(1155039), {L"4"}), callback = L"script HandleSingleLeftClkTarget( Interface.DefaultPet4 )", unique = true }
	ActionsWindow.ActionData[5355] = { group = 1154968, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 870054, detailString = ReplaceTokens(GetStringFromTid(3047), {L"5"}), nameString = ReplaceTokens(GetStringFromTid(1155039), {L"5"}), callback = L"script HandleSingleLeftClkTarget( Interface.DefaultPet5 )", unique = true }
	
	-- 5400 -> 5450 :  OBJECT TARGETING ACTIONS (STORE)
	ActionsWindow.ActionData[5400] = { group = 1155462, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 870100, detailString = ReplaceTokens(GetStringFromTid(1155042), {L"1"}), nameString = ReplaceTokens(GetStringFromTid(1155041), {L"1"}), callback = L"script Actions.TargetDefaultItem(1)", unique = true }
	ActionsWindow.ActionData[5401] = { group = 1155462, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 870101, detailString = ReplaceTokens(GetStringFromTid(1155042), {L"2"}), nameString = ReplaceTokens(GetStringFromTid(1155041), {L"2"}), callback = L"script Actions.TargetDefaultItem(2)", unique = true }
	ActionsWindow.ActionData[5402] = { group = 1155462, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 870102, detailString = ReplaceTokens(GetStringFromTid(1155042), {L"3"}), nameString = ReplaceTokens(GetStringFromTid(1155041), {L"3"}), callback = L"script Actions.TargetDefaultItem(3)", unique = true }
	ActionsWindow.ActionData[5403] = { group = 1155462, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 870103, detailString = ReplaceTokens(GetStringFromTid(1155042), {L"4"}), nameString = ReplaceTokens(GetStringFromTid(1155041), {L"4"}), callback = L"script Actions.TargetDefaultItem(4)", unique = true }
	ActionsWindow.ActionData[5404] = { group = 1155462, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 870104, detailString = ReplaceTokens(GetStringFromTid(1155042), {L"5"}), nameString = ReplaceTokens(GetStringFromTid(1155041), {L"5"}), callback = L"script Actions.TargetDefaultItem(5)", unique = true }
	
	ActionsWindow.ActionData[5410] = { group = 1155462, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 02043, nameTid = 3512, detailTid = 3012, callback = L"script Actions.Snoop()", macroOnly = true }

	-- 5451 -> 5499 :  OBJECT TARGETING ACTIONS (TARGETING)
	ActionsWindow.ActionData[5450] = { group = 1155462, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 870150, detailString = ReplaceTokens(GetStringFromTid(3048), {L"1"}), nameString = ReplaceTokens(GetStringFromTid(1155043), {L"1"}), callback = L"script HandleSingleLeftClkTarget( Interface.DefaultObject1 )", unique = true }
	ActionsWindow.ActionData[5451] = { group = 1155462, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 870151, detailString = ReplaceTokens(GetStringFromTid(3048), {L"2"}), nameString = ReplaceTokens(GetStringFromTid(1155043), {L"2"}), callback = L"script HandleSingleLeftClkTarget( Interface.DefaultObject2 )", unique = true }
	ActionsWindow.ActionData[5452] = { group = 1155462, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 870152, detailString = ReplaceTokens(GetStringFromTid(3048), {L"3"}), nameString = ReplaceTokens(GetStringFromTid(1155043), {L"3"}), callback = L"script HandleSingleLeftClkTarget( Interface.DefaultObject3 )", unique = true }
	ActionsWindow.ActionData[5453] = { group = 1155462, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 870153, detailString = ReplaceTokens(GetStringFromTid(3048), {L"4"}), nameString = ReplaceTokens(GetStringFromTid(1155043), {L"4"}), callback = L"script HandleSingleLeftClkTarget( Interface.DefaultObject4 )", unique = true }
	ActionsWindow.ActionData[5454] = { group = 1155462, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 870154, detailString = ReplaceTokens(GetStringFromTid(3048), {L"5"}), nameString = ReplaceTokens(GetStringFromTid(1155043), {L"5"}), callback = L"script HandleSingleLeftClkTarget( Interface.DefaultObject5 )", unique = true }
	
	ActionsWindow.ActionData[5470] = { group = 1155462, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875101, nameTid = 3513, detailTid = 3013, callback = L"script HandleSingleLeftClkTarget( Interface.SnoopTarget )", macroOnly = true }

	-- 5500 -> 5599 :  PETBALLS
	ActionsWindow.ActionData[5500] = { group = 1154980, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 870200,	nameTid = 1155446,  detailTid = 1155045, editWindow = "Custom", macroOnly = true }
	ActionsWindow.ActionData[5501] = { group = 1154980, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 870201,	nameTid = 1155447,  detailTid = 1155045, editWindow = "Custom", macroOnly = true }
	ActionsWindow.ActionData[5502] = { group = 1154980, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 870202,	nameTid = 1155448,  detailTid = 1155045, editWindow = "Custom", macroOnly = true }
	ActionsWindow.ActionData[5503] = { group = 1154980, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 870203,	nameTid = 1155449,  detailTid = 1155045, editWindow = "Custom", macroOnly = true }
	ActionsWindow.ActionData[5504] = { group = 1154980, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 870204,	nameTid = 1155450,  detailTid = 1155045, editWindow = "Custom", macroOnly = true }
	ActionsWindow.ActionData[5505] = { group = 1154980, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 870205,	nameTid = 1155451,  detailTid = 1155045, editWindow = "Custom", macroOnly = true }
	ActionsWindow.ActionData[5506] = { group = 1154980, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 870206,	nameTid = 1155453,  detailTid = 1155045, editWindow = "Custom", macroOnly = true }
	ActionsWindow.ActionData[5507] = { group = 1154980, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 870207,	nameTid = 1155454,  detailTid = 1155045, editWindow = "Custom", macroOnly = true }
	ActionsWindow.ActionData[5508] = { group = 1154980, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 870208,	nameTid = 1155455,  detailTid = 1155045, editWindow = "Custom", macroOnly = true }
	ActionsWindow.ActionData[5509] = { group = 1154980, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 870209,	nameTid = 1155456,  detailTid = 1155045, editWindow = "Custom", macroOnly = true }
	ActionsWindow.ActionData[5510] = { group = 1154980, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 870210,	nameTid = 1155457,  detailTid = 1155045, editWindow = "Custom", macroOnly = true }
	ActionsWindow.ActionData[5511] = { group = 1154980, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 870211,	nameTid = 1155458,  detailTid = 1155045, editWindow = "Custom", macroOnly = true }
	ActionsWindow.ActionData[5512] = { group = 1154980, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 870212,	nameTid = 1155459,  detailTid = 1155045, editWindow = "Custom", macroOnly = true }
	ActionsWindow.ActionData[5513] = { group = 1154980, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 870213,	nameTid = 1155460,  detailTid = 1155045, editWindow = "Custom", macroOnly = true }
	ActionsWindow.ActionData[5514] = { group = 1154980, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 870214,	nameTid = 1155452,  detailTid = 1155045, editWindow = "Custom", macroOnly = true }

	-- 5600 -> 5699 :  MOUNTS
	ActionsWindow.ActionData[91] =   { group = 1154981, type = SystemData.UserAction.TYPE_DISMOUNT,						inActionWindow = true, iconId = 798,	nameTid = 1115935, detailTid = 1115936, unique = true }
	ActionsWindow.ActionData[5600] = { group = 1154981, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 870300, nameTid = 1155046, detailTid = 1155058, editWindow = "Custom", macroOnly = true}
	ActionsWindow.ActionData[5601] = { group = 1154981, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 870301, nameTid = 1155047, detailTid = 1155058, editWindow = "Custom", macroOnly = true}
	ActionsWindow.ActionData[5602] = { group = 1154981, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 870302, nameTid = 1155048, detailTid = 1155058, editWindow = "Custom", macroOnly = true}
	ActionsWindow.ActionData[5603] = { group = 1154981, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 870303, nameTid = 1155049, detailTid = 1155058, editWindow = "Custom", macroOnly = true}
	ActionsWindow.ActionData[5604] = { group = 1154981, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 870304, nameTid = 1155050, detailTid = 1155058, editWindow = "Custom", macroOnly = true}
	ActionsWindow.ActionData[5605] = { group = 1154981, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 870305, nameTid = 1155051, detailTid = 1155058, editWindow = "Custom", macroOnly = true}
	ActionsWindow.ActionData[5606] = { group = 1154981, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 870306, nameTid = 1155052, detailTid = 1155058, editWindow = "Custom", macroOnly = true}
	ActionsWindow.ActionData[5607] = { group = 1154981,  type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 870307, nameTid = 1155053, detailTid = 1155058, editWindow = "Custom", macroOnly = true}
	ActionsWindow.ActionData[5608] = { group = 1154981, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 870308, nameTid = 1155054, detailTid = 1155058, editWindow = "Custom", macroOnly = true}
	ActionsWindow.ActionData[5609] = { group = 1154981, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 870309, nameTid = 1155055, detailTid = 1155058, editWindow = "Custom", macroOnly = true}
	ActionsWindow.ActionData[5610] = { group = 1154981, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 870310, nameTid = 1155056, detailTid = 1155058, editWindow = "Custom", macroOnly = true}
	ActionsWindow.ActionData[5611] = { group = 1154981, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 870311, nameTid = 1155057, detailTid = 1155058, editWindow = "Custom", macroOnly = true}
	
	-- 5700 -> 5719 :  CURSOR TARGETING
	ActionsWindow.ActionData[17] =   { group = 1094876, type = SystemData.UserAction.TYPE_WAIT_FOR_TARGET,				inActionWindow = true, iconId = 618,	nameTid = 3002100, detailTid = 1115147, macroOnly = true }
	ActionsWindow.ActionData[19] =   { group = 1094876, type = SystemData.UserAction.TYPE_CURSOR_TARGET_LAST,			inActionWindow = true, iconId = 644,	nameTid = 1079156, detailTid = 1115148, settingKeyBinding = "CURSOR_TARGET_LAST", unique = true }
	ActionsWindow.ActionData[20] =   { group = 1094876, type = SystemData.UserAction.TYPE_CURSOR_TARGET_CURRENT,		inActionWindow = true, iconId = 643,	nameTid = 1079157, detailTid = 1115149, settingKeyBinding = "CURSOR_TARGET_CURRENT", unique = true }
	ActionsWindow.ActionData[21] =   { group = 1094876, type = SystemData.UserAction.TYPE_CURSOR_TARGET_SELF,			inActionWindow = true, iconId = 645,	nameTid = 1079158, detailTid = 1115150, settingKeyBinding = "CURSOR_TARGET_SELF", unique = true }
	ActionsWindow.ActionData[56] =   { group = 1094876, type = SystemData.UserAction.TYPE_TARGET_BY_OBJECT_ID,			inActionWindow = true, iconId = 771,	nameTid = 1094786, detailTid = 1115185, editWindow = "TargetByObjectId", paramInfoTid = 1094788, hideOK = true }
	ActionsWindow.ActionData[66] =   { group = 1094876, type = SystemData.UserAction.TYPE_CYCLE_CURSOR_TARGET,			inActionWindow = true, iconId = 772,	nameTid = 1112413, detailTid = 1115187, settingKeyBinding = "CYCLE_LAST_CURSOR_TARGET", unique = true }
	ActionsWindow.ActionData[90] =   { group = 1094876, type = SystemData.UserAction.TYPE_CLEAR_TARGET_QUEUE,			inActionWindow = true, iconId = 797,	nameTid = 1115342, detailTid = 1115344, settingKeyBinding = "CLEAR_TARGET_QUEUE", unique = true }
	ActionsWindow.ActionData[5700] = { group = 1094876, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 00799,	nameTid = 1155061, detailTid = 1155062, callback = L"script CancelCursorTarget()", unique = true }
	
	-- 5720 -> 5799 : OTHER
	ActionsWindow.ActionData[14]  =	 { group = 1044294, type = SystemData.UserAction.TYPE_OPEN_DOOR,					inActionWindow = true, iconId = 641,	nameTid = 3002087, detailTid = 1115144, unique = true }
	ActionsWindow.ActionData[15]  =	 { group = 1044294, type = SystemData.UserAction.TYPE_ALL_NAMES,					inActionWindow = true, iconId = 619,	nameTid = 3002096, detailTid = 1115145, unique = true }
	ActionsWindow.ActionData[16]  =	 { group = 1044294, type = SystemData.UserAction.TYPE_DELAY,						inActionWindow = true, iconId = 623,	nameTid = 3002103, detailTid = 1115146, editWindow = "Slider", paramInfoTid = 3002103, sliderMin = 0.0, sliderMax = 10.0, unique = true }
	ActionsWindow.ActionData[57]  =	 { group = 1044294, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 790,	nameTid = 3002105, detailTid = 1115186, editWindow = "Text", paramInfoTid = 3002105, unique = true }
	ActionsWindow.ActionData[83]  =	 { group = 1044294, type = SystemData.UserAction.TYPE_TOGGLE_ALWAYS_RUN,			inActionWindow = true, iconId = 789,	nameTid = 1113150, detailTid = 1115205, settingKeyBinding = "TOGGLE_ALWAYS_RUN", unique = true }
	ActionsWindow.ActionData[84]  =	 { group = 1044294, type = SystemData.UserAction.TYPE_TOGGLE_CIRCLE_OF_TRANSPARENCY,inActionWindow = true, iconId = 791,	nameTid = 1079818, detailTid = 1115206, settingKeyBinding = "TOGGLE_CIRCLE_OF_TRANSPARENCY", unique = true }
	ActionsWindow.ActionData[5720] = { group = 1044294, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 724,	nameTid = 1154929, detailTid = 1154928, callback = L"script Actions.ToggleFoliage()", unique = true }
	ActionsWindow.ActionData[5721] = { group = 1044294, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875100, nameTid = 3000469, detailTid = 1115316, callback = L"script Actions.IgnorePlayer()", unique = true }
	ActionsWindow.ActionData[5722] = { group = 1044294, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875131, nameTid = 1046,	   detailTid = 1546,	callback = L"script Actions.ToggleBookLogging()", unique = true }
	ActionsWindow.ActionData[5723] = { group = 1044294, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875102, nameTid = 1115918, detailTid = 1115919, callback = L"script Actions.IgnoreActionSelf()", unique = true }
	ActionsWindow.ActionData[5724] = { group = 1044294, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 729, 	nameTid = 1154930,						callback = L"script Actions.ToggleSound()", unique = true}
	ActionsWindow.ActionData[5725] = { group = 1044294, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 731, 	nameTid = 1155105,						callback = L"script Actions.ToggleSoundEffects()", unique = true}
	ActionsWindow.ActionData[5726] = { group = 1044294, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 730, 	nameTid = 1155106,						callback = L"script Actions.ToggleMusic()", unique = true}
	ActionsWindow.ActionData[5727] = { group = 1044294, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 732, 	nameTid = 1155107,						callback = L"script Actions.ToggleFootsteps()", unique = true}
	ActionsWindow.ActionData[5728] = { group = 1044294, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875104, nameTid = 1115913, detailTid = 1115914, callback = L"script Actions.ToggleEnglishNames()", unique = true, nonEnglishOnly = true }
	ActionsWindow.ActionData[5729] = { group = 1044294, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875103, nameTid = 1155123, detailTid = 1155124, callback = L"script Actions.ExportContainerItems()", unique = true }
	ActionsWindow.ActionData[5730] = { group = 1044294, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875105, nameTid = 1155126, detailTid = 1155127, callback = L"script Actions.CloseAllContainers()", unique = true }
	ActionsWindow.ActionData[5731] = { group = 1044294, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875106, nameTid = 1155128, detailTid = 1155129, callback = L"script Actions.CloseAllCorpses()", unique = true }
	ActionsWindow.ActionData[5732] = { group = 1044294, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875107, nameTid = 1155131, detailTid = 1155132, callback = L"script Actions.MassOrganizerStart()", unique = true }
	ActionsWindow.ActionData[5733] = { group = 1044294, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875124, nameTid = 3530,	   detailTid = 1155230, callback = L"script Actions.UndressMe()", unique = true }
	ActionsWindow.ActionData[5734] = { group = 1044294, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875109, nameTid = 1155135, detailTid = 1155136, callback = L"script Actions.ToggleKeepAlive()", unique = true }
	ActionsWindow.ActionData[5736] = { group = 1044294, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875111, nameTid = 1155138, detailTid = 1155139, editWindow = "Custom", unique = true }
	ActionsWindow.ActionData[5737] = { group = 1044294, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875112, nameTid = 1155140, detailTid = 1155141, callback = L"script Actions.DressHolding()", unique = true }
	ActionsWindow.ActionData[5738] = { group = 1044294, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875113, nameTid = 1155142, detailTid = 1155143, callback = L"script Actions.DropHolding()", unique = true }
	ActionsWindow.ActionData[5739] = { group = 1044294, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875114, nameTid = 1155150, detailTid = 1155151, callback = L"script Actions.ToggleTrapBox()", unique = true }
	ActionsWindow.ActionData[5740] = { group = 1044294, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875115, nameTid = 1155157, detailTid = 1155158, callback = L"script Actions.ToggleLootbag()", unique = true } 
	ActionsWindow.ActionData[5741] = { group = 1044294, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875116, nameTid = 1155162, detailTid = 1155163, callback = L"script Actions.ToggleAlphaMode()", unique = true }
	ActionsWindow.ActionData[5742] = { group = 1044294, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875117, nameTid = 1155164, detailTid = 1155165, callback = L"script Actions.ToggleScaleMode()", unique = true }
	ActionsWindow.ActionData[5743] = { group = 1044294, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 718,	nameTid = 3531,	   detailTid = 1155168, callback = L"script Actions.ObjectHandleContextMenu()", unique = true }
	ActionsWindow.ActionData[5745] = { group = 1044294, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875119, nameTid = 1155177, detailTid = 1155178, callback = L"script Actions.GetTypeID()", unique = true }
	ActionsWindow.ActionData[5746] = { group = 1044294, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875120, nameTid = 1155179, detailTid = 1155180, callback = L"script Actions.GetHueID()", unique = true }
	ActionsWindow.ActionData[5747] = { group = 1044294, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875121, nameTid = 1155219, detailTid = 1155218, callback = L"script Actions.IgnoreTargettedItem()", unique = true }
	ActionsWindow.ActionData[5748] = { group = 1044294, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875122, nameTid = 1155223, detailTid = 1155222, callback = L"script Actions.ClearIgnoreList()", unique = true }
	ActionsWindow.ActionData[5749] = { group = 1044294, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875123, nameTid = 1155225, detailTid = 1155228, callback = L"script Actions.ToggleBlockPaperdolls()", unique = true }
	ActionsWindow.ActionData[5750] = { group = 1044294, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875125, nameTid = 3506,	   detailTid = 3006,    callback = L"script Moongate.GODefault()", unique = true }
	ActionsWindow.ActionData[5751] = { group = 1044294, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875126, nameTid = 3508,	   detailTid = 3008,    callback = L"script Actions.ChangeSecurity(~1_TYPE~)", unique = true }
	ActionsWindow.ActionData[5752] = { group = 1044294, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875127, nameTid = 3509,	   detailTid = 3009,    callback = L"script Actions.ToggleItemProperties()", unique = true }
	ActionsWindow.ActionData[5756] = { group = 1044294, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875133, nameTid = 3515,	   detailTid = 3015,    callback = L"script Actions.ToggleItemPreview()", unique = true }
	ActionsWindow.ActionData[5757] = { group = 1079386, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875136, nameTid = 3537,	   detailTid = 3044,	callback = L"script Actions.NearestTmap()", unique = true }

	
	-- 5800 -> 5850 : BARD'S SUPER SLAYER
	ActionsWindow.ActionData[5800] = { group = 1155467, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875350, nameTid = 1079747, detailTid = 1155461, editWindow = "Custom", macroOnly = true }
	ActionsWindow.ActionData[5801] = { group = 1155467, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875351, nameTid = 1079748, detailTid = 1155461, editWindow = "Custom", macroOnly = true }
	ActionsWindow.ActionData[5802] = { group = 1155467, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875352, nameTid = 1079749, detailTid = 1155461, editWindow = "Custom", macroOnly = true }
	ActionsWindow.ActionData[5803] = { group = 1155467, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875353, nameTid = 1070855, detailTid = 1155461, editWindow = "Custom", macroOnly = true }
	ActionsWindow.ActionData[5804] = { group = 1155467, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875354, nameTid = 1079750, detailTid = 1155461, editWindow = "Custom", macroOnly = true }
	ActionsWindow.ActionData[5805] = { group = 1155467, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875355, nameTid = 1079751, detailTid = 1155461, editWindow = "Custom", macroOnly = true }
	ActionsWindow.ActionData[5806] = { group = 1155467, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875356, nameTid = 1079752, detailTid = 1155461, editWindow = "Custom", macroOnly = true }
	
	-- 5850 -> 5899 : BARD'S SLAYER
	ActionsWindow.ActionData[5850] = { group = 1155468, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875400, nameTid = 1079743, detailTid = 1155461, editWindow = "Custom", macroOnly = true}
	ActionsWindow.ActionData[5851] = { group = 1155468, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875401, nameTid = 1079746, detailTid = 1155461, editWindow = "Custom", macroOnly = true}
	ActionsWindow.ActionData[5852] = { group = 1155468, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875402, nameTid = 1079753, detailTid = 1155461, editWindow = "Custom", macroOnly = true}
	ActionsWindow.ActionData[5853] = { group = 1155468, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875403, nameTid = 1079737, detailTid = 1155461, editWindow = "Custom", macroOnly = true}
	ActionsWindow.ActionData[5854] = { group = 1155468, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875404, nameTid = 1079733, detailTid = 1155461, editWindow = "Custom", macroOnly = true}
	ActionsWindow.ActionData[5855] = { group = 1155468, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875405, nameTid = 1079734, detailTid = 1155461, editWindow = "Custom", macroOnly = true}
	ActionsWindow.ActionData[5856] = { group = 1155468, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875406, nameTid = 1079735, detailTid = 1155461, editWindow = "Custom", macroOnly = true}
	ActionsWindow.ActionData[5857] = { group = 1155468, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875407, nameTid = 1079736, detailTid = 1155461, editWindow = "Custom", macroOnly = true}
	ActionsWindow.ActionData[5858] = { group = 1155468, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875408, nameTid = 1079742, detailTid = 1155461, editWindow = "Custom", macroOnly = true}
	ActionsWindow.ActionData[5859] = { group = 1155468, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875409, nameTid = 1079745, detailTid = 1155461, editWindow = "Custom", macroOnly = true}
	ActionsWindow.ActionData[5860] = { group = 1155468, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875410, nameTid = 1079755, detailTid = 1155461, editWindow = "Custom", macroOnly = true}
	ActionsWindow.ActionData[5861] = { group = 1155468, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875411, nameTid = 1079741, detailTid = 1155461, editWindow = "Custom", macroOnly = true}
	ActionsWindow.ActionData[5862] = { group = 1155468, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875412, nameTid = 1079739, detailTid = 1155461, editWindow = "Custom", macroOnly = true}
	ActionsWindow.ActionData[5863] = { group = 1155468, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875413, nameTid = 1079754, detailTid = 1155461, editWindow = "Custom", macroOnly = true}
	ActionsWindow.ActionData[5864] = { group = 1155468, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875414, nameTid = 1061284, detailTid = 1155461, editWindow = "Custom", macroOnly = true}
	ActionsWindow.ActionData[5865] = { group = 1155468, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875415, nameTid = 1079738, detailTid = 1155461, editWindow = "Custom", macroOnly = true}
	ActionsWindow.ActionData[5866] = { group = 1155468, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875416, nameTid = 1079740, detailTid = 1155461, editWindow = "Custom", macroOnly = true}
	ActionsWindow.ActionData[5867] = { group = 1155468, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875417, nameTid = 1079744, detailTid = 1155461, editWindow = "Custom", macroOnly = true}
					
	-- 5900 -> 5949 :  PLAYER CONTEXT MENU
	ActionsWindow.ActionData[5900] = { group = 1155120, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,		inActionWindow = true, iconId = 875500,	nameTid = 1113797,							callback = L"script Actions.EnablePVPWarning()", unique = true }
	ActionsWindow.ActionData[5901] = { group = 1155120, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,		inActionWindow = true, iconId = 875501,	nameTid = 3006205,							callback = L"script Actions.ReleaseCoownership()", unique = true }
	ActionsWindow.ActionData[5902] = { group = 1155120, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,		inActionWindow = true, iconId = 875502,	nameTid = 3006207,							callback = L"script Actions.LeaveHouse()", unique = true }
	ActionsWindow.ActionData[5903] = { group = 1155120, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,		inActionWindow = true, iconId = 875503,	nameTid = 3006156,							callback = L"script Actions.QuestConversation()", unique = true }
	ActionsWindow.ActionData[5904] = { group = 1155120, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,		inActionWindow = true, iconId = 875504,	nameTid = 3006154,							callback = L"script Actions.ViewQuestLog()", unique = true }
	ActionsWindow.ActionData[5905] = { group = 1155120, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,		inActionWindow = true, iconId = 875505,	nameTid = 3006155,							callback = L"script Actions.CancelQuest()", unique = true }
	ActionsWindow.ActionData[5906] = { group = 1155120, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,		inActionWindow = true, iconId = 875506,	nameTid = 3006169,							callback = L"script Actions.QuestItem()", unique = true }
	ActionsWindow.ActionData[5907] = { group = 1155120, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,		inActionWindow = true, iconId = 875507,	nameTid = 1114299,							callback = L"script Actions.InsuranceMenu()", unique = true }
	ActionsWindow.ActionData[5908] = { group = 1155120, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,		inActionWindow = true, iconId = 875508,	nameTid = 3006201,							callback = L"script Actions.ToggleItemInsurance()", unique = true }
	ActionsWindow.ActionData[5909] = { group = 1155120, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,		inActionWindow = true, iconId = 875509,	nameTid = 1115022,							callback = L"script Actions.TitlesMenu()", unique = true }
	ActionsWindow.ActionData[5911] = { group = 1155120, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,		inActionWindow = true, iconId = 875511,	nameTid = 3006157,							callback = L"script Actions.CancelProtection()", unique = true }																													
	ActionsWindow.ActionData[5912] = { group = 1155120, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,		inActionWindow = true, iconId = 875512,	nameTid = 1152531,							callback = L"script Actions.VoidPool()", unique = true }
	ActionsWindow.ActionData[5913] = { group = 1155120, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,		inActionWindow = true, iconId = 875513,	nameTid = 1155121,	detailTid = 1155122,    callback = L"script Actions.ToggleTrades()", unique = true }
	ActionsWindow.ActionData[5914] = { group = 1155120, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,		inActionWindow = true, iconId = 875514, nameTid = 3006168,							callback = L"script Actions.SiegeBlessItem()", siegeOnly = true, unique = true }
	ActionsWindow.ActionData[5915] = { group = 1155120, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,		inActionWindow = true, iconId = 875515, nameTid = 1154679,							callback = L"script Actions.ToggleVendorSearch()", unique = true }
	
	-- 5950 -> 5999 :  ITEMS/ABILITIES
	ActionsWindow.ActionData[8]  =   { group = 1079384, type = SystemData.UserAction.TYPE_LAST_SKILL,					inActionWindow = true, iconId = 617,	nameTid = 3002089, detailTid = 1115138, unique = true }
	ActionsWindow.ActionData[9]  =   { group = 1079384, type = SystemData.UserAction.TYPE_LAST_SPELL,					inActionWindow = true, iconId = 640,	nameTid = 3002091, detailTid = 1115139, unique = true }
	ActionsWindow.ActionData[10] =   { group = 1079384, type = SystemData.UserAction.TYPE_LAST_OBJECT,					inActionWindow = true, iconId = 629,	nameTid = 3002092, detailTid = 1115140, unique = true }
	ActionsWindow.ActionData[26] =   { group = 1079384, type = SystemData.UserAction.TYPE_ARM_DISARM,					inActionWindow = true, iconId = 677,	nameTid = 3002099, detailTid = 1115155, editWindow = "ArmDisarm", paramInfoTid = 1079292, unique = true }
	ActionsWindow.ActionData[86] =   { group = 1079384, type = SystemData.UserAction.TYPE_BANDAGE_SELF,					inActionWindow = true, iconId = 793,	nameTid = 1114306, detailTid = 1115208, unique = true }
	ActionsWindow.ActionData[87] =   { group = 1079384, type = SystemData.UserAction.TYPE_BANDAGE_SELECTED_TARGET,		inActionWindow = true, iconId = 794,	nameTid = 1114307, detailTid = 1115209, unique = true }
	ActionsWindow.ActionData[5950] = { group = 1079384, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875600, nameTid = 1155133, detailTid = 1155134, callback = L"script Actions.LoadShuri()", unique = true }
	ActionsWindow.ActionData[5951] = { group = 1079384, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875601, detailString = ReplaceTokens(GetStringFromTid(3007), {GetStringFromTid(1044112)}), nameString = ReplaceTokens(GetStringFromTid(3507), {GetStringFromTid(1044112)}),  callback = L"script Actions.SearchFullSpellbook(Actions.SpellbookTypes.Bushido)", unique = true }
	ActionsWindow.ActionData[5952] = { group = 1079384, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875602, detailString = ReplaceTokens(GetStringFromTid(3007), {GetStringFromTid(1044111)}), nameString = ReplaceTokens(GetStringFromTid(3507), {GetStringFromTid(1044111)}),  callback = L"script Actions.SearchFullSpellbook(Actions.SpellbookTypes.Chivalry)", unique = true }
	ActionsWindow.ActionData[5953] = { group = 1079384, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875603, detailString = ReplaceTokens(GetStringFromTid(3007), {GetStringFromTid(1044085)}), nameString = ReplaceTokens(GetStringFromTid(3507), {GetStringFromTid(1044085)}),  callback = L"script Actions.SearchFullSpellbook(Actions.SpellbookTypes.Magery)", unique = true }
	ActionsWindow.ActionData[5954] = { group = 1079384, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875604, detailString = ReplaceTokens(GetStringFromTid(3007), {GetStringFromTid(1044115)}), nameString = ReplaceTokens(GetStringFromTid(3507), {GetStringFromTid(1044115)}),  callback = L"script Actions.SearchFullSpellbook(Actions.SpellbookTypes.Mysticism)", unique = true }
	ActionsWindow.ActionData[5955] = { group = 1079384, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875605, detailString = ReplaceTokens(GetStringFromTid(3007), {GetStringFromTid(1044109)}), nameString = ReplaceTokens(GetStringFromTid(3507), {GetStringFromTid(1044109)}),  callback = L"script Actions.SearchFullSpellbook(Actions.SpellbookTypes.Necromancy)", unique = true }
	ActionsWindow.ActionData[5956] = { group = 1079384, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875606, detailString = ReplaceTokens(GetStringFromTid(3007), {GetStringFromTid(1044113)}), nameString = ReplaceTokens(GetStringFromTid(3507), {GetStringFromTid(1044113)}),  callback = L"script Actions.SearchFullSpellbook(Actions.SpellbookTypes.Ninjitsu)", unique = true }
	ActionsWindow.ActionData[5957] = { group = 1079384, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875607, detailString = ReplaceTokens(GetStringFromTid(3007), {GetStringFromTid(1044114)}), nameString = ReplaceTokens(GetStringFromTid(3507), {GetStringFromTid(1044114)}),  callback = L"script Actions.SearchFullSpellbook(Actions.SpellbookTypes.Spellweaving)", unique = true }
	ActionsWindow.ActionData[5958] = { group = 1079384, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875608, detailTid = 3016, nameTid = 3516,  callback = L"script Actions.RetrieveTarget()", unique = true }
	ActionsWindow.ActionData[5959] = { group = 1079384, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875609, detailTid = 3017, nameTid = 3517,  callback = L"script Actions.GatherSeeds()", unique = true }
	ActionsWindow.ActionData[5960] = { group = 1079384, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875610, detailTid = 3018, nameTid = 3518,  callback = L"script Actions.GatherResources()", unique = true }
	ActionsWindow.ActionData[5961] = { group = 1079384, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875611, detailTid = 3022, nameTid = 3522,  callback = L"script BuoyTool.Toggle()", unique = true }
	
	-- 6000 -> 6100 :  CRAFTING UTILITIES
	ActionsWindow.ActionData[6000] = { group = 1155372, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 876001, nameTid = 1155373, detailTid = 1155374,																callback = L"script Actions.UnravelItem()", unique = true }
	ActionsWindow.ActionData[6001] = { group = 1155372, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 876000, nameTid = 1155375, detailTid = 1155376,																callback = L"script Actions.ImbueLast()", unique = true }
	ActionsWindow.ActionData[6002] = { group = 1155372, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 876002,					   detailTid = 1155377, nameString = FormatProperly(GetStringFromTid(1094726 )),	callback = L"script Actions.AlterItem()", unique = true }
	ActionsWindow.ActionData[6003] = { group = 1155372, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 876003,					   detailTid = 1155378, nameString = FormatProperly(GetStringFromTid(1061001 )),	callback = L"script Actions.EnhanceItem()", unique = true }
	ActionsWindow.ActionData[6004] = { group = 1155372, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 876004,					   detailTid = 1155379, nameString = FormatProperly(GetStringFromTid(1044015 )),	callback = L"script Actions.RepairItem()", unique = true }
	ActionsWindow.ActionData[6005] = { group = 1155372, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 876005,					   detailTid = 1155380, nameString = FormatProperly(GetStringFromTid(1044016 )),	callback = L"script Actions.SmeltItem()", unique = true }
	ActionsWindow.ActionData[6006] = { group = 1155372, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 876006,					   detailTid = 1155381, nameString = FormatProperly(GetStringFromTid(1044013)),		callback = L"script Actions.MakeLast()", unique = true }
	ActionsWindow.ActionData[6007] = { group = 1155372, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 876007, nameTid = 3526,	   detailTid = 3026,																callback = L"script Actions.ReimbueLast()", unique = true }
	ActionsWindow.ActionData[6008] = { group = 1155372, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 876008, nameTid = 3536,	   detailTid = 3043,																callback = L"script Actions.UnravelContainer()", unique = true }
	ActionsWindow.ActionData[6009] = { group = 1155372, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 876010, nameTid = 3539,	   detailTid = 3050,																callback = L"script Actions.CloseCraftGump()", unique = true }
	ActionsWindow.ActionData[6010] = { group = 1155372, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 876009, nameTid = 3540,	   detailTid = 3051,																callback = L"script Actions.CraftItem(0)", editWindow = "Custom" }

	
	-- 6200 -> 6300 :  HEALTHBARS
	ActionsWindow.ActionData[6200] = { group = 1155276, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875118, nameTid = 1155173, detailTid = 1155174, callback = L"script Actions.GetHealthbar()", unique = true }
	ActionsWindow.ActionData[6201] = { group = 1155276, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875110, nameTid = 1155137,						callback = L"script MobileHealthBar.CloseAllHealthbars()", unique = true }
	ActionsWindow.ActionData[6202] = { group = 1155276, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875134, nameTid = 3527,	   detailTid = 3027,    callback = L"script MobileBarsDockspot.FilterListSelectByName(~1_NAME~)" }
	ActionsWindow.ActionData[6203] = { group = 1155276, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 875135, nameTid = 3528,	   detailTid = 3028,	callback = L"script BossBar.AttachBossBar(TargetWindow.TargetId)", unique = true }

	-- 15001 -> 15050 :  CUSTOM BUFFS
	ActionsWindow.ActionData[15001] = { group = 4000, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 857500,					   detailTid = 3005, nameString = ReplaceTokens(GetStringFromTid(3505), {L"1"}), editWindow = "Text", paramInfoText = GetStringFromTid(15), unique = true }
	ActionsWindow.ActionData[15002] = { group = 4000, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 857501,					   detailTid = 3005, nameString = ReplaceTokens(GetStringFromTid(3505), {L"2"}), editWindow = "Text", paramInfoText = GetStringFromTid(15), unique = true }
	ActionsWindow.ActionData[15003] = { group = 4000, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 857502,					   detailTid = 3005, nameString = ReplaceTokens(GetStringFromTid(3505), {L"3"}), editWindow = "Text", paramInfoText = GetStringFromTid(15), unique = true }
	ActionsWindow.ActionData[15004] = { group = 4000, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 857503,					   detailTid = 3005, nameString = ReplaceTokens(GetStringFromTid(3505), {L"4"}), editWindow = "Text", paramInfoText = GetStringFromTid(15), unique = true }
	ActionsWindow.ActionData[15005] = { group = 4000, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 857504,					   detailTid = 3005, nameString = ReplaceTokens(GetStringFromTid(3505), {L"5"}), editWindow = "Text", paramInfoText = GetStringFromTid(15), unique = true }
	ActionsWindow.ActionData[15006] = { group = 4000, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 857505,					   detailTid = 3005, nameString = ReplaceTokens(GetStringFromTid(3505), {L"6"}), editWindow = "Text", paramInfoText = GetStringFromTid(15), unique = true }
	ActionsWindow.ActionData[15007] = { group = 4000, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 857506,					   detailTid = 3005, nameString = ReplaceTokens(GetStringFromTid(3505), {L"7"}), editWindow = "Text", paramInfoText = GetStringFromTid(15), unique = true }
	ActionsWindow.ActionData[15008] = { group = 4000, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 857507,					   detailTid = 3005, nameString = ReplaceTokens(GetStringFromTid(3505), {L"8"}), editWindow = "Text", paramInfoText = GetStringFromTid(15), unique = true }
	ActionsWindow.ActionData[15009] = { group = 4000, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 857508,					   detailTid = 3005, nameString = ReplaceTokens(GetStringFromTid(3505), {L"9"}), editWindow = "Text", paramInfoText = GetStringFromTid(15), unique = true }
	ActionsWindow.ActionData[15010] = { group = 4000, type = SystemData.UserAction.TYPE_SPEECH_USER_COMMAND,			inActionWindow = true, iconId = 857509,					   detailTid = 3005, nameString = ReplaceTokens(GetStringFromTid(3505), {L"10"}), editWindow = "Text", paramInfoText = GetStringFromTid(15), unique = true }
	
	-- initialize the groups
	ActionsWindow.Groups = {}

	-- scan all the actions
	for id, data in pairsByKeys(ActionsWindow.ActionData) do

		-- does the action belong to a group? (if not it won't show in the list)
		if not data.group then
			continue
		end

		-- do we have a group for this tid yet?
		if not ActionsWindow.Groups[data.group] then

			-- create the group
			ActionsWindow.Groups[data.group] = {}
		end

		-- add the action ID to the group
		table.insert(ActionsWindow.Groups[data.group], id)
	end
end

ActionsWindow.CurrentGroup = 1077417

ActionsWindow.CreatedActions = {}

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function ActionsWindow.Initialize()

	-- actions window name
	local this = "ActionsWindow"

	-- flag the window to be destroyed on close
	Interface.DestroyWindowOnClose[this] = true

	-- set the current window title
	WindowUtils.SetWindowTitle(this, GetStringFromTid(1079812)) -- Actions

	-- restore the saved window position
	WindowUtils.RestoreWindowPosition(this)	

	-- load the last group viewed
	ActionsWindow.CurrentGroup = Interface.LoadSetting("ActionsWindowCurrentGroup", ActionsWindow.CurrentGroup)
	
	-- update the list with the current group elements
	ActionsWindow.UpdateList(ActionsWindow.CurrentGroup)
end

function ActionsWindow.Shutdown()

	-- delete all the existing actions
	ActionsWindow.ClearAllActions()

	-- save the window position
	WindowUtils.SaveWindowPosition("ActionsWindow")
end

function ActionsWindow.Context()

	-- clear the context menu
	ContextMenu.CleanUp()

	-- sorted list of the context elements
	local sortedElements = {}

	-- scan all the groups
	for tid, _ in pairs(ActionsWindow.Groups) do

		-- add the element string into the table
		table.insert(sortedElements, wstring.lower(GetStringFromTid(tid)))
	end

	-- sort the elements
	table.sort(sortedElements)
	
	-- cycle through the sorted elements
	for _, name in pairsByIndex(sortedElements) do

		-- scan all the groups
		for tid, _ in pairs(ActionsWindow.Groups) do

			-- is this the elment=
			if wstring.lower(GetStringFromTid(tid)) == name then

				-- create the context menu line for the group
				ContextMenu.CreateLuaContextMenuItem({ tid = tid, returnCode = tid, pressed = ActionsWindow.CurrentGroup == tid })
			end
		end
	end
	
	-- show the context menu
	ContextMenu.ActivateLuaContextMenu(ActionsWindow.ContextMenuCallback)
end

function ActionsWindow.ContextMenuCallback(returnCode, param)

	-- set the selected group as current group
	ActionsWindow.CurrentGroup = returnCode

	-- save the selected group
	Interface.SaveSetting("ActionsWindowCurrentGroup", ActionsWindow.CurrentGroup)

	-- update the actions list
	ActionsWindow.UpdateList(ActionsWindow.CurrentGroup)
end

function ActionsWindow.ContextTooltip()

	-- show the tooltip for the button to switch group
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(577))
end

function ActionsWindow.ClearAllActions()
	
	-- scan all the created actions
	for window, _ in pairs(ActionsWindow.CreatedActions) do
		
		-- does this action still exist?
		if DoesWindowExist(window) then

			-- delete the action
			DestroyWindow(window)
		end
	end

	-- clear the created elements table
	ActionsWindow.CreatedActions = {}
end

function ActionsWindow.UpdateList(tid)
	
	-- actions window name
	local this = "ActionsWindow"

	-- scroll area window name
	local scrollChild = this .. "ListScrollChild"
	
	-- does the group exist?
	if not ActionsWindow.Groups[tid] then

		-- get the first element of the table
		tid = next(ActionsWindow.Groups)
	end

	-- delete all the existing actions
	ActionsWindow.ClearAllActions()

	-- initialize the previous element window variable
	local previousElement
	
	-- get all the actions for the selected group
	for index, actionIndex in pairs(ActionsWindow.Groups[tid]) do
		
		-- action window name
		local windowName = scrollChild .. "Action" .. actionIndex

		-- get the action data for the current action
		local actionData = ActionsWindow.ActionData[actionIndex]

		-- is this action for siege perilous rules shards only?
		if actionData.siegeOnly and not Interface.SiegeRules then
			continue
		end

		-- is this action only for NON-ENGLISH language and we are using english?
		if actionData.nonEnglishOnly and SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU then
			continue
		end

		-- make sure the element does not exist yet
		if not DoesWindowExist(windowName) then

			-- create the element
			CreateWindowFromTemplate(windowName, "ActionItemDef", scrollChild)
		end

		-- set the action ID to the element
		WindowSetId(windowName .. "Button", actionIndex)

		-- get the icon data for the action
		local texture, x, y = GetIconData(actionData.iconId)

		-- draw the icon
		DynamicImageSetTexture(windowName .. "ButtonSquareIcon", texture, x, y)
				
		-- set the correct background based on the mini texture pack
		DynamicImageSetTexture(windowName .. "ButtonSquareIconBG", MiniTexturePack.DB[Interface.Settings.MTP_Current].texture .. "Icon", 0, 0)

		-- determine if the action is already in the bar
		local alreadyInBar, existingSlot = HotbarSystem.ActionAlreadyInHotbar(actionIndex, actionData.type)
		
		-- is the action enabled (unknown which case it could be disabled...) or it's already in the bar and is not unique? 
		if UserActionIsActionTypeTargetModeCompat(actionData.type) and ((alreadyInBar and not actionData.unique) or (not alreadyInBar and actionData.unique == true) or (not alreadyInBar and not actionData.unique)) then

			-- enable the element
			WindowUtils.EnableButton(windowName .. "Button")

			-- hide the disabled mask
			WindowSetShowing(windowName .. "ButtonDisabled", false)

			-- set the label text color
			LabelSetTextColor(windowName .. "Name", 255, 255, 255)

		else -- action disabled
		
			-- disable the element
			WindowUtils.DisableButton(windowName .. "Button")

			-- show the disabled mask
			WindowSetShowing(windowName .. "ButtonDisabled", true)

			-- set the label text color
			LabelSetTextColor(windowName .. "Name", 128, 128, 128)
		end

		-- do we have the action tid?
		if actionData.nameTid then

			-- set the TID name
			LabelSetText(windowName .. "Name", FormatProperly(GetStringFromTid(actionData.nameTid)))

		else -- set the string name
			LabelSetText(windowName .. "Name", actionData.nameString )
		end

		-- is this the first element?
		if index == 1 then

			-- anchor to the top-left of the scroll window
			WindowAddAnchor(windowName, "topleft", scrollChild, "topleft", 0, 0)

		else -- anchor to the previous elements
			WindowAddAnchor(windowName, "bottomleft",previousElement, "topleft", 0, 0)
		end

		-- make the current element the previous element
		previousElement = windowName

		-- add the current element to the list of the existing elements
		ActionsWindow.CreatedActions[windowName] = actionData
	end

	-- scroll to the top
	ScrollWindowSetOffset(this .. "List", 0)

	-- update the scrollable area size
	ScrollWindowUpdateScrollRect(this .. "List")
end

function ActionsWindow.UpdateIcons()

	-- scan all the created actions
	for windowName, actionData in pairs(ActionsWindow.CreatedActions) do

		-- does this action still exist?
		if DoesWindowExist(windowName) then

			-- get the action index
			local actionIndex = WindowGetId(windowName .. "Button")
			
			-- determine if the action is already in the bar
			local alreadyInBar, existingSlot = HotbarSystem.ActionAlreadyInHotbar(actionIndex, actionData.type)
			
			-- update the background
			DynamicImageSetTexture(windowName .. "ButtonSquareIconBG", MiniTexturePack.DB[Interface.Settings.MTP_Current].texture .. "Icon", 64, 64 )

			-- is the action enabled (unknown which case it could be disabled...) or it's already in the bar and is not unique? 
			if UserActionIsActionTypeTargetModeCompat(actionData.type) and ((alreadyInBar and not actionData.unique) or (not alreadyInBar and actionData.unique == true) or (not alreadyInBar and not actionData.unique)) then

				-- enable the element
				WindowUtils.EnableButton(windowName .. "Button")

				-- hide the disabled mask
				WindowSetShowing(windowName .. "ButtonDisabled", false)

				-- set the label text color
				LabelSetTextColor(windowName .. "Name", 255, 255, 255)

			else -- action disabled
			
				-- disable the element
				WindowUtils.DisableButton(windowName .. "Button")

				-- show the disabled mask
				WindowSetShowing(windowName .. "ButtonDisabled", true)

				-- set the label text color
				LabelSetTextColor(windowName .. "Name", 128, 128, 128)
			end
		end
	end
end

function ActionsWindow.Search()

	-- actions window name
	local this = "ActionsWindow"

	-- get the text from the search box
	local text = SearchBox.GetFilter(this .. "SearchBox", true, false)
	
	-- do we have a valid text?
	if not IsValidWString(text) then
		return
	end

	-- scroll area window name
	local scrollChild = this .. "ListScrollChild"

	-- delete all the existing actions
	ActionsWindow.ClearAllActions()

	-- initialize the previous element window variable
	local previousElement
	
	-- get all the actions for the selected group
	for actionIndex, actionData in pairs(ActionsWindow.ActionData) do

		-- if this action has no group, it's not to be listed
		if not actionData.group then
			continue
		end
		
		-- action window name
		local windowName = scrollChild .. "Action" .. actionIndex

		-- is this action for siege perilous rules shards only?
		if actionData.siegeOnly and not Interface.SiegeRules then
			continue
		end

		-- is this action only for NON-ENGLISH language and we are using english?
		if actionData.nonEnglishOnly and SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU then
			continue
		end

		-- initialize the action name
		local name

		-- do we have the action tid?
		if actionData.nameTid then

			-- set the TID name
			name = wstring.lower(GetStringFromTid(actionData.nameTid))

		else -- set the string name
			name = wstring.lower(actionData.nameString)
		end

		-- does this action name cointains the search text?
		if not wstring.find(name, text, 1, true) then
			continue
		end

		-- make sure the element does not exist yet
		if not DoesWindowExist(windowName) then

			-- create the element
			CreateWindowFromTemplate(windowName, "ActionItemDef", scrollChild)
		end

		-- set the action ID to the element
		WindowSetId(windowName .. "Button", actionIndex)

		-- get the icon data for the action
		local texture, x, y = GetIconData(actionData.iconId)

		-- draw the icon
		DynamicImageSetTexture(windowName .. "ButtonSquareIcon", texture, x, y)
				
		-- set the correct background based on the mini texture pack
		DynamicImageSetTexture(windowName .. "ButtonSquareIconBG", MiniTexturePack.DB[Interface.Settings.MTP_Current].texture .. "Icon", 0, 0)

		-- determine if the action is already in the bar
		local alreadyInBar, existingSlot = HotbarSystem.ActionAlreadyInHotbar(actionIndex, actionData.type)
		
		-- is the action enabled (unknown which case it could be disabled...) or it's already in the bar and is not unique? 
		if UserActionIsActionTypeTargetModeCompat(actionData.type) and ((alreadyInBar and not actionData.unique) or (not alreadyInBar and actionData.unique) or (not alreadyInBar and not actionData.unique)) then

			-- enable the element
			WindowUtils.EnableButton(windowName .. "Button")

			-- hide the disabled mask
			WindowSetShowing(windowName .. "ButtonDisabled", false)

			-- set the label text color
			LabelSetTextColor(windowName .. "Name", 255, 255, 255)

		else -- action disabled

			-- disable the element
			WindowUtils.DisableButton(windowName .. "Button")

			-- show the disabled mask
			WindowSetShowing(windowName .. "ButtonDisabled", true)

			-- set the label text color
			LabelSetTextColor(windowName .. "Name", 128, 128, 128)
		end

		-- set the name
		LabelSetText(windowName .. "Name", FormatProperly(name))

		-- is this the first element?
		if index == 1 then

			-- anchor to the top-left of the scroll window
			WindowAddAnchor(windowName, "topleft", scrollChild, "topleft", 0, 0)

		else -- anchor to the previous elements
			WindowAddAnchor(windowName, "bottomleft",previousElement, "topleft", 0, 0)
		end

		-- make the current element the previous element
		previousElement = windowName

		-- add the current element to the list of the existing elements
		ActionsWindow.CreatedActions[windowName] = actionData
	end

	-- scroll to the top
	ScrollWindowSetOffset(this .. "List", 0)

	-- update the scrollable area size
	ScrollWindowUpdateScrollRect(this .. "List")
end

function ActionsWindow.ResetSearch()

	-- update the list with the current group elements
	ActionsWindow.UpdateList(ActionsWindow.CurrentGroup)
end

function ActionsWindow.CustomEdit(actionId)

	-- do we have a valid ID?
	if not IsValidID(actionId) then
		return false
	end

	-- does this action exist?
	if not ActionsWindow.ActionData[actionId] then
		return false
	end

	-- get the action type
	local type = ActionsWindow.ActionData[actionId].type

	-- do we have a valid action type?
	if not type or not ActionsWindow.isAction(type) then
		return false
	end

	if	(type == SystemData.UserAction.TYPE_SPEECH_USER_COMMAND and actionId ~= 57) or -- all the speech commands (except the speech command itself) are custom actions
		(type == SystemData.UserAction.TYPE_SPEECH_SAY and actionId ~= 4) or -- all the says (except the say itself) are custom actions
		(type == SystemData.UserAction.TYPE_EQUIP_ITEMS and actionId ~= 1) -- all the equip (except the equip itself) are custom actions
	then 

		return true
	end

	return false
end

ActionsWindow.LastDrag = 0
function ActionsWindow.ItemLButtonDown(flags)

	-- current window name
	local this = SystemData.ActiveWindow.name

	-- get the index of the current action
	local actionId = WindowGetId(this)	
	
	-- get the action data
	local actionData = ActionsWindow.ActionData[actionId]

	-- store the action type
	local actionType = actionData.type
	
	-- is this a virtue action?
	if actionType == SystemData.UserAction.TYPE_INVOKE_VIRTUE then

		-- update the action ID with the virtue ID
		actionId = actionData.invokeId
	end

	-- is controll pressed?
	if flags == SystemData.ButtonFlags.CONTROL then

		-- preventing the player from dropping on hotbar actions that should only be used inside of macros
		if ActionsWindow.ActionData[actionId].macroOnly then
			ChatPrint(GetStringFromTid(219), SystemData.ChatLogFilters.SYSTEM)
			return
		end

		-- preventing the player from dropping duplicate actions (only certain generic actions can be used multiple times)
		local alreadyInBar, existingSlot = HotbarSystem.ActionAlreadyInHotbar(actionId, actionType)
		if actionData.unique and alreadyInBar then
			ChatPrint(GetStringFromTid(285), SystemData.ChatLogFilters.SYSTEM)

			-- make the slot glow to highlight the duplicate
			HotbarSystem.GlowSlotWarning(existingSlot, 5, actionId)

			return
		end

		-- create a blockbar
		local blockBar = HotbarSystem.SpawnNewHotbar(_, 1, true)
		
		-- set the action on the blockbar
		HotbarSystem.SetActionOnHotbar(actionType, actionId, actionData.iconId, blockBar,  1)
		
		-- forcing the blockbar to follow the mouse cursor
		WindowUtils.FollowMouseCursor("Hotbar" .. blockBar, Hotbar.BUTTON_SIZE, Hotbar.BUTTON_SIZE, -30, -15, false, true, true)

		 -- start to move the blockbar
		WindowSetMoving("Hotbar" .. blockBar, true)
		
    else -- control NOT pressed

		-- store the dragged action (so we can track the exact action ID we are dragging when we drop it)
		ActionsWindow.LastDrag = actionId

		-- begin dragging the action
		DragSlotSetActionMouseClickData(actionType, actionId, actionData.iconId)
	end
end

function ActionsWindow.ItemMouseOver()

	-- current window name
	local this = SystemData.ActiveWindow.name

	-- get the action ID
	local actionId = WindowGetId(this)

	-- get the action data
	local actionData = ActionsWindow.ActionData[actionId]

	-- store the action type
	local actionType = actionData.type

	-- is this a virtue action?
	if actionType == SystemData.UserAction.TYPE_INVOKE_VIRTUE then

		-- update the action ID with the virtue ID
		actionId = actionData.invokeId
	end

	-- initialize the action name
	local name = actionData.nameString
	
	-- do we have a TID?
	if actionData.nameTid then

		-- get the action name from TID
		name = FormatProperly(GetStringFromTid(actionData.nameTid))
	end

	-- initialize the action description
	local desc = actionData.detailString

	-- do we have a TID?
	if actionData.detailTid then

		-- get the action description from TID
		desc = GetStringFromTid(actionData.detailTid) 
	end

	-- initialize the properties data variable
	local itemData
	
	-- is this a default action?
	if not ActionsWindow.CustomEdit(actionId) then

		-- generate the properties data
		itemData =
		{
			windowName = SystemData.ActiveWindow.name,
			itemId = actionId,
			actionType = actionData.type,
			detail = ItemProperties.DETAIL_LONG,
			itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
			title =	name,
			body = desc
		}	

	-- is this the player backpack action?
	elseif actionId == 5011 then

		-- get the player backpack ID
		local backpackId = GetBackpackID(GetPlayerID())
	
		-- do we have a valid ID?
		if IsValidID(backpackId) then

			-- create the item properties for the backpack
			itemData = 
			{
				windowName = SystemData.ActiveWindow.name,
				itemId = backpackId,
				itemType = WindowData.ItemProperties.TYPE_ITEM,
			}
		end

	else -- any other action
		
		-- generate the properties data
		itemData =
		{
			windowName = SystemData.ActiveWindow.name,
			itemId = actionId,
			detail = ItemProperties.DETAIL_LONG,
			itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
			title =	name,
			body = desc
		}	
	end		
	
	-- show the item properties
	ItemProperties.SetActiveItem(itemData)	
end

function ActionsWindow.GetActionDataForType(actionType)

	-- scan all actions
	for index, actionData in pairs(ActionsWindow.ActionData) do

		-- does this action has the type we're looking for?
		if actionData.type == actionType then
			return actionData
		end
	end
end
function ActionsWindow.GetActionDataForID(actionId, actionType)

	-- scan all actions
	for index, actionData in pairs(ActionsWindow.ActionData) do

		-- is this the action we're looking for?
		if index == actionId and actionType == actionData.type then
			return actionData
		end
	end
end

function ActionsWindow.GuessIdByIconId(iconId)

	-- scan all actions
	for id, data in pairs(ActionsWindow.ActionData) do

		-- does this action uses the icon we're looking for
		if data.iconId == iconId then
			return id
		end
	end
end

function ActionsWindow.isAction(type)

	-- compare the type with all the basic types of NON-ACTIONS
	if  type ~= 0 and
		type ~= SystemData.UserAction.TYPE_MACRO_REFERENCE and 
		type ~= SystemData.UserAction.TYPE_MACRO and 
		type ~= SystemData.UserAction.TYPE_SKILL and 
		type ~= SystemData.UserAction.TYPE_SPELL and 
		type ~= SystemData.UserAction.TYPE_WEAPON_ABILITY and 
		type ~= SystemData.UserAction.TYPE_USE_ITEM and 
		type ~= SystemData.UserAction.TYPE_USE_OBJECTTYPE and 
		type ~= SystemData.UserAction.TYPE_PLAYER_STATS and 
		type ~= SystemData.UserAction.TYPE_RACIAL_ABILITY and 
		type ~= SystemData.UserAction.TYPE_INVOKE_VIRTUE 
	then
		return true
	end

	return false
end

-- returns if to open the edit window
function ActionsWindow.InitializeActionSlotCallback(params)
	
	-- acquiring data from params
	local actionId = params[1]
	local actionType = params[2]
	local element = params[3]
	local hotbarId = params[4]
	local slot = params[5]
	local subIndex = params[6]

	-- make sure the hotbar and slot exist
	if (not Hotbar.DoesHotbarExist(hotbarId, true) and hotbarId ~= SystemData.MacroSystem.STATIC_MACRO_ID ) or not IsValidID(slot) then
		return false
	end

	-- is a valid action?
	if not IsValidID(actionId) or not ActionsWindow.isAction(actionType) then
		return false
	end
	
	-- is this a custom (non-default) action?
	if ActionsWindow.CustomEdit(actionId) then
	
		-- acquiring action data
		local actionData = ActionsWindow.ActionData[actionId]

		-- is this an unique action?
		if actionData.unique then

			-- disabling this action (to avoid any kind of problems)
			ActionsWindow.UpdateIcons()
		end

		-- general chat, guild, alliance, party and note to self messages settings
		if (actionId >= 5170 and actionId <= 5174) then
		
			return true -- opening the normal speech edit action
		
		-- smart next, smart nearest, target severely injured mobile, nearest corpse
		elseif (actionId == 5201 or actionId == 5202 or actionId == 5204 or actionId == 5210) then

			-- acquiring the callback form actionData
			local speechText = actionData.callback

			-- setting the default type to: nil
			speechText = ReplaceTokens(speechText, {L""})

			-- saving the callback in the hotbar slot
			UserActionSpeechSetText(hotbarId, slot, subIndex, speechText)

			return false -- nothing to edit (it uses the context menu)

		-- change security (house items)
		elseif (actionId == 5751) then

			-- acquiring the callback form actionData
			local speechText = actionData.callback

			-- setting the default type to: OWNER
			speechText = ReplaceTokens(speechText, {L"\"owner\""})

			-- saving the callback in the hotbar slot
			UserActionSpeechSetText(hotbarId, slot, subIndex, speechText)

			return false -- nothing to edit (it uses the context menu)

		-- change security (house items)
		elseif (actionId == 5757) then

			-- acquiring the callback form actionData
			local speechText = actionData.callback

			-- setting the default type to: default
			speechText = ReplaceTokens(speechText, {L"L\"default\""})

			-- saving the callback in the hotbar slot
			UserActionSpeechSetText(hotbarId, slot, subIndex, speechText)

			return false -- nothing to edit (it uses the context menu)

		-- item properties slot (show item properties over this slot)
		elseif (actionId == 5752) then
					
			-- setting the parameters for the item properties and saving them
			Interface.PropsSlot = {HotbarID = hotbarId, SlotID = slot}
			Interface.SaveSetting("PropsSlotHotbarID", hotbarId )
			Interface.SaveSetting("PropsSlotSlotID", slot )

			-- setting the callback from the actionData
			local speechText = actionData.callback
			UserActionSpeechSetText(hotbarId, slot, subIndex, speechText)	

			return false -- nothing to edit
		
		-- custom buffs
		elseif (actionId >= 15001 and actionId < 15010) then	
					
			-- default example text
			local speechText = L"Buff Name|Cooldown"
			UserActionSpeechSetText(hotbarId, slot, subIndex, speechText)

			return true -- opening the normal speech edit action
					
		-- any other action with a callback in the actionData (and is not the equip last or target first container item)
		elseif actionData.callback and actionId ~= 4139 and actionId ~= 5206 and actionId ~= 5207 then
		
			-- saving the callback in the hotbar slot as it is
			UserActionSpeechSetText(hotbarId, slot, subIndex, actionData.callback)	

			return false -- nothing to edit (just functions to be executed without user editing it)
					
		-- any other cases, opens the default edit (like for custom equip actions)
		else
		
			return true -- opening the normal edit action
		end		
	end

	return true -- opening the normal edit action
end

function ActionsWindow.IsABoatCommand(actionId, actionType)
	
	-- is the action ID valid?
	if not IsValidID(actionId) then
		return
	end

	-- is that an action?
	if ActionsWindow.isAction(actionType) then

		-- boat commands
		if ((actionId >= 37 and actionId <= 50) or (actionId >= 5150 and actionId <= 5153)) then

			return true
		end
	end

	return false
end

function ActionsWindow.OldBoatCommandsFix(element, hotbarId, itemIndex, subIndex, actionId, actionType)

	-- make sure the hotbar exist and the ids are valids
	if (hotbarId ~= SystemData.MacroSystem.STATIC_MACRO_ID and not Hotbar.DoesHotbarExist(hotbarId, true)) or not IsValidID(itemIndex) or not DoesWindowExist(element) then
		return false
	end

	-- hotbar slot
	if subIndex == 0 then

		-- replacing the old obsolete actions with the new ones
		if actionType == SystemData.UserAction.TYPE_BOAT_COMMAND_FORWARD_LEFT then
			actionId = 37
			local data = ActionsWindow.ActionData[actionId]
			HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_SPEECH_USER_COMMAND, actionId, data.iconId, hotbarId, itemIndex)
		
		elseif actionType == SystemData.UserAction.TYPE_BOAT_COMMAND_FORWARD_RIGHT then		
			actionId = 38
			local data = ActionsWindow.ActionData[actionId]
			HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_SPEECH_USER_COMMAND, actionId, data.iconId, hotbarId, itemIndex)
		
		elseif actionType == SystemData.UserAction.TYPE_BOAT_COMMAND_FORWARD then			
			actionId = 39
			local data = ActionsWindow.ActionData[actionId]
			HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_SPEECH_USER_COMMAND, actionId, data.iconId, hotbarId, itemIndex)
		
		elseif actionType == SystemData.UserAction.TYPE_BOAT_COMMAND_BACKWARD_LEFT then		
			actionId = 40
			local data = ActionsWindow.ActionData[actionId]
			HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_SPEECH_USER_COMMAND, actionId, data.iconId, hotbarId, itemIndex)
		
		elseif actionType == SystemData.UserAction.TYPE_BOAT_COMMAND_BACKWARD_RIGHT then		
			actionId = 41
			local data = ActionsWindow.ActionData[actionId]
			HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_SPEECH_USER_COMMAND, actionId, data.iconId, hotbarId, itemIndex)
		
		elseif actionType == SystemData.UserAction.TYPE_BOAT_COMMAND_BACKWARDS then			
			actionId = 42
			local data = ActionsWindow.ActionData[actionId]
			HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_SPEECH_USER_COMMAND, actionId, data.iconId, hotbarId, itemIndex)
		
		elseif actionType == SystemData.UserAction.TYPE_BOAT_COMMAND_LEFT then				
			actionId = 43
			local data = ActionsWindow.ActionData[actionId]
			HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_SPEECH_USER_COMMAND, actionId, data.iconId, hotbarId, itemIndex)
		
		elseif actionType == SystemData.UserAction.TYPE_BOAT_COMMAND_RIGHT then				
			actionId = 44
			local data = ActionsWindow.ActionData[actionId]
			HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_SPEECH_USER_COMMAND, actionId, data.iconId, hotbarId, itemIndex)
		
		elseif actionType == SystemData.UserAction.TYPE_BOAT_COMMAND_TURN_LEFT then			
			actionId = 45
			local data = ActionsWindow.ActionData[actionId]
			HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_SPEECH_USER_COMMAND, actionId, data.iconId, hotbarId, itemIndex)
		
		elseif actionType == SystemData.UserAction.TYPE_BOAT_COMMAND_TURN_RIGHT then			
			actionId = 46
			local data = ActionsWindow.ActionData[actionId]
			HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_SPEECH_USER_COMMAND, actionId, data.iconId, hotbarId, itemIndex)
		
		elseif actionType == SystemData.UserAction.TYPE_BOAT_COMMAND_TURN_AROUND then		
			actionId = 47
			local data = ActionsWindow.ActionData[actionId]
			HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_SPEECH_USER_COMMAND, actionId, data.iconId, hotbarId, itemIndex)
		end	
		
		return false
		
	else -- is a macro

		-- checking if it's one of the old boat actions
		if  actionType == SystemData.UserAction.TYPE_BOAT_COMMAND_FORWARD_LEFT or
			actionType == SystemData.UserAction.TYPE_BOAT_COMMAND_FORWARD_RIGHT or
			actionType == SystemData.UserAction.TYPE_BOAT_COMMAND_FORWARD or	
			actionType == SystemData.UserAction.TYPE_BOAT_COMMAND_BACKWARD_LEFT or
			actionType == SystemData.UserAction.TYPE_BOAT_COMMAND_BACKWARD_RIGHT or	
			actionType == SystemData.UserAction.TYPE_BOAT_COMMAND_BACKWARDS or
			actionType == SystemData.UserAction.TYPE_BOAT_COMMAND_LEFT or		
			actionType == SystemData.UserAction.TYPE_BOAT_COMMAND_RIGHT or		
			actionType == SystemData.UserAction.TYPE_BOAT_COMMAND_TURN_LEFT or		
			actionType == SystemData.UserAction.TYPE_BOAT_COMMAND_TURN_RIGHT or		
			actionType == SystemData.UserAction.TYPE_BOAT_COMMAND_TURN_AROUND then
		
			-- since we can't do replacements in the macro slot, we have to remove it
			HotbarSystem.ClearActionIcon(element, hotbarId, itemIndex, subIndex, true)	
			UserActionMacroRemoveAction( hotbarId, itemIndex, subIndex)

			-- warning that we removed the action
			return true
		end
	end
end