
----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

CharacterSheet = {}

CharacterSheet.NextBankGoldUpdate = 0

CharacterSheet.NextLoyaltyUpdate = 0
CharacterSheet.LastLoyaltyUpdate = 0
CharacterSheet.minLoyaltyUpdate = 3 -- minimum amount of time between the calls of the loyalty ratings

CharacterSheet.LoyaltyInHotbar = false
CharacterSheet.BankGoldInHotbar = false

CharacterSheet.cityLoyaltyBlock = nil

CharacterSheet.Groups = {}
CharacterSheet.Groups[1] = { nameString=L"Attributes",			nameTid=1049593,		mods={"Strength", "Dexterity", "Intelligence", "StatCap", "CurrentHealth", "CurrentStamina", "CurrentMana", "HitPointRegen", "StamRegen", "ManaRegen"}}
CharacterSheet.Groups[2] = { nameString=L"Resistances",			nameTid=1061645,		mods={"PhysicalResist", "FireResist", "ColdResist", "PoisonResist", "EnergyResist", "DamageEater", "KineticEater", "FireEater", "ColdEater", "PoisonEater", "EnergyEater", "KineticResonance", "FireResonance", "ColdResonance", "PoisonResonance", "EnergyResonance"}}
CharacterSheet.Groups[3] = { nameString=L"Attack",				nameTid=1011533,		mods={"DPS", "SwingSpeed", "Damage", "HitChanceIncrease", "SwingSpeedIncrease", "DamageChanceIncrease", "BattleLust", "Balanced", "SpellChannelingW"}}
CharacterSheet.Groups[4] = { nameString=L"Defense",				nameTid=1017320,		mods={"ReflectPhysicalDamage", "EnhancePotions", "DefenseChanceIncrease", "SpellChannelingS", "ReactiveParalyze"}}
CharacterSheet.Groups[5] = { nameString=L"Magic",				nameTid=1078593,		mods={"LowerReagentCost", "LowerManaCost", "SpellDamageIncrease", "FasterCasting", "FasterCastRecovery", "CastingFocus", "SoulCharge", "TithingPoints", "Medable", "NightSight"}}
CharacterSheet.Groups[6] = { nameString=L"Hit Effects",			nameTid=1114251,		mods={"HitLowerAttack", "HitLowerDefense", "SplinteringWeapon", "Velocity", "HitHarm", "HitMagicArrow", "HitFireball", "HitLightning", "HitDispel", "HitCurse", "HitLifeLeech", "HitStaminaLeech", "HitLifeDrain", "HitManaLeech", "HitManaDrain", "HitFatigue", "BloodDrinker"}}
CharacterSheet.Groups[7] = { nameString=L"Hit Area Effects",	nameTid=1114250,		mods={"HitPhysicalArea", "HitFireArea", "HitColdArea", "HitPoisonArea", "HitEnergyArea"}}
CharacterSheet.Groups[8] = { nameString=L"Miscellaneous",		nameTid=1011173,		mods={"Karma", "Fame", "Luck", "Gold", "BankGold", "Weight", "Followers", "HealingSpeed"}}
CharacterSheet.Groups[9] = { nameString=L"Loyalty Rating",		nameTid=1049594,		mods={"GargoyleQueen", "Ophidian", "BaneChosen", "Meer", "Juka"}}
CharacterSheet.Groups[10] = { nameString=L"Dungeons",			nameTid=1078373,		mods={"Shame", "Despise", "Void"}}
CharacterSheet.Groups[11] = { nameString=L"City Loyalty",		nameTid=1152190,		mods={"Britain", "Jhelom", "Minoc", "Moonglow", "NewMagincia", "SkaraBrae", "Trinsic", "Vesper", "Yew", "Citizenship", "CitizenshipTitles"}}

CharacterSheet.TID = {CharacterSheet = 1077437}                            

CharacterSheet.CapsBonus = {}

function CharacterSheet.InitializeAttributes()

	CharacterSheet.AttributesDef = {
		["CurrentHealth"] =			{index=1; 	tid=1061149; 				descTid=1115215; 							iconId=742; 	cap=25;		iconWarning=766; 	separator=" / ";	bonus="IncreaseHitPointsMax";	};
		["CurrentStamina"] =		{index=2; 	tid=1061150; 				descTid=1115216; 							iconId=750; 				iconWarning=768; 	separator=" / ";	bonus="IncreaseStamMax";		};
		["CurrentMana"] =			{index=3; 	tid=1061151; 				descTid=1115217; 							iconId=746; 				iconWarning=767; 	separator=" / ";	bonus="IncreaseManaMax";		};
		
		["Strength"] =				{index=4; 	tid=1061146; 				descTid=1115218; 							iconId=751; 	cap=150;											bonus="IncreaseStr";			};
		["Dexterity"] =				{index=5; 	tid=1061147; 				descTid=1115219; 							iconId=738; 	cap=150;											bonus="IncreaseDex";			};
		["Intelligence"] =			{index=6; 	tid=1061148; 				descTid=1115220; 							iconId=744; 	cap=150;											bonus="IncreaseInt";			};
		["StatCap"] =				{index=7; 	tid=1078829; 				descTid=1115221; 							iconId=753; 	cap=260;																			};
	
		["Luck"] =					{index=8; 	tid=1061153; 				descTid=1115222; 							iconId=745;																							};
		["Weight"] =				{index=9; 	tid=1061154; 				descTid=1115223; 							iconId=754;									 	separator=" / ";									};
		["Gold"] =					{index=10; 	tid=1061156; 				descTid=1115224; 							iconId=741;																							};
		["BankGold"] =				{index=11; 	tid=1060645; 				descTid=1115224; 							iconId=741;																							};
		["Followers"] = 			{index=12; 	tid=1078830; 				descTid=1115225; 							iconId=747;										separator=" / ";									};
		["Karma"] =					{index=13; 	tid=3010073; 						 									iconId=85843;																						};
		["Fame"] =					{index=14; 	tid=3010072; 						 									iconId=85842;																						};
	
		["PhysicalResist"] =		{index=15; 	tid=1061158; 				descTid=1115226;							iconId=748;										separator=" / ";									};
		["FireResist"] =			{index=16; 	tid=1061159; 				descTid=1115227;							iconId=740;										separator=" / ";									};
		["ColdResist"] =			{index=17; 	tid=1061160; 				descTid=1115228;							iconId=735;										separator=" / ";									};
		["PoisonResist"] =			{index=18; 	tid=1061161; 				descTid=1115229;							iconId=749;										separator=" / ";									};
		["EnergyResist"] =			{index=19; 	tid=1061162; 				descTid=1115230;							iconId=739;										separator=" / ";									};
	
		["Damage"] =				{index=20; 	tid=1017319; 				descTid=1115231;							iconId=736;										separator=" - ";									};
		["DPS"] =					{index=21; 	stringText=GetStringFromTid(43); 	stringDesc=GetStringFromTid(91);					iconId=736;																							};
		["HitChanceIncrease"] =		{index=22; 	tid=1075616; 				descTid=1115232;							iconId=743;		cap=45;																					};
		["SwingSpeedIncrease"] =	{index=23; 	tid=1075629; 				descTid=1115233;							iconId=752;		cap=60;																					};
		["DamageChanceIncrease"] =	{index=24; 	tid=1079399; 				descTid=1115234;							iconId=737;		cap=100;																					};
	
		["LowerReagentCost"] =		{index=25; 	tid=1075625; 				descTid=1115235;							iconId=761;		cap=100;																					};
		["HitPointRegen"] =			{index=26; 	tid=1075627; 				descTid=1115241;							iconId=759;		cap=18;																					};
		["StamRegen"] =				{index=27; 	tid=1079411; 				descTid=1115242;							iconId=765;																							};
		["ManaRegen"] =				{index=28; 	tid=1079410; 				descTid=1115243;							iconId=762;		cap=30;																					};
		["ReflectPhysicalDamage"] =	{index=29; 	tid=1075626; 				descTid=1115244;							iconId=763;		cap=105;																					};
		["EnhancePotions"] =		{index=30; 	tid=1075624; 				descTid=1115236;							iconId=756;		cap=50;																					};
		["DefenseChanceIncrease"] =	{index=31; 	tid=1075620; 				descTid=1115245;							iconId=755;										separator=" / ";									};
		["SpellDamageIncrease"] =	{index=32; 	tid=1075628; 				descTid=1115237;							iconId=764;																							};
		["FasterCastRecovery"] =	{index=33; 	tid=1075618; 				descTid=1115238;							iconId=758;		cap=6;																				};
		["FasterCasting"] =			{index=34; 	tid=1075617; 				descTid=1115239;							iconId=757;		cap=4;																				};
		["LowerManaCost"] =			{index=35; 	tid=1075621; 				descTid=1115240;							iconId=760;		cap=40;																					};
		["TithingPoints"] =			{index=36; 	tid=1062102; 															iconId=85800;																						};
	
		["SwingSpeed"] =			{index=37; 	stringText=GetStringFromTid(92); 	stringDesc=GetStringFromTid(93);					iconId=85853;																							};
		["CastingFocus"] =			{index=38; 	tid=1113696; 				descTid=1152389;							iconId=85844;	cap=12;																				};
		["SoulCharge"] =			{index=39; 	tid=1113630; 				descTid=1152382;							iconId=85801;																						};
		["DamageEater"] =			{index=40; 	tid=1113598; 				descTid=1152390;							iconId=85802;	cap=18;																				};
		["KineticEater"] =			{index=41; 	tid=1113597; 				descTid=1152390;							iconId=85803;	cap=30;																				};
		["FireEater"] =				{index=42; 	tid=1113593; 				descTid=1152390;							iconId=85804;	cap=30;																				};
		["ColdEater"] =				{index=43; 	tid=1113594; 				descTid=1152390;							iconId=85805;	cap=30;																				};
		["PoisonEater"] =			{index=44; 	tid=1113595; 				descTid=1152390;							iconId=85806;	cap=30;																				};
		["EnergyEater"] =			{index=45; 	tid=1113596; 				descTid=1152390;							iconId=85807;	cap=30;																				};
		["KineticResonance"] =		{index=46; 	tid=1113695; 				descTid=1152391;							iconId=85808;																						};
		["FireResonance"] =			{index=47; 	tid=1113691; 				descTid=1152391;							iconId=85809;																						};
		["ColdResonance"] =			{index=48; 	tid=1113692; 				descTid=1152391;							iconId=85810;																						};
		["PoisonResonance"] =		{index=49; 	tid=1112364; 				descTid=1152391;							iconId=85811;																						};
		["EnergyResonance"] =		{index=50; 	tid=1113694; 				descTid=1152391;							iconId=85812;																						};
	
		["HitLowerAttack"] =		{index=51; 	tid=1079699; 				descTid=1152420;							iconId=85813;																						};
		["HitLowerDefense"] =		{index=52; 	tid=1079700; 				descTid=1152419;							iconId=85814;																						};
		["SplinteringWeapon"] =		{index=53; 	tid=1112857; 				descTid=1152396;							iconId=85815;																						};
		["Velocity"] =				{index=54; 	tid=1080416; 				descTid=1152392;							iconId=85816;																						};
		["BloodDrinker"] =			{index=55; 	tid=1113591; 				descTid=1152387;							iconId=85817;																						};
		["BattleLust"] =			{index=56; 	tid=1113710; 				descTid=1152385;							iconId=85818;																						};
		["Balanced"] =				{index=57; 	tid=1072792; 				descTid=1152384;							iconId=85819;																						};
		["SpellChannelingW"] =		{index=58; 	tid=1060482; 				descTid=1152398;							iconId=85820;																						};
		["SpellChannelingS"] =		{index=59; 	tid=1060482; 				descTid=1152398;							iconId=85821;																						};
		["ReactiveParalyze"] =		{index=60; 	tid=1112364; 				descTid=1152400;							iconId=85822;																						};
		["Medable"] =				{index=61; 	stringText=GetStringFromTid(94); 	stringDesc=GetStringFromTid(95);					iconId=85823;																						};
		["NightSight"] =			{index=62; 	tid=1075643; 				stringDesc=GetStringFromTid(96);					iconId=85824;																						};
		["HitPhysicalArea"] =		{index=63; 	tid=1079696; 				descTid=1152422;							iconId=85825;																						};
		["HitFireArea"] =			{index=64; 	tid=1079695; 				descTid=1152422;							iconId=85826;																						};
		["HitColdArea"] =			{index=65; 	tid=1079693; 				descTid=1152422;							iconId=85827;																						};
		["HitPoisonArea"] =			{index=66; 	tid=1079697; 				descTid=1152422;							iconId=85828;																						};
		["HitEnergyArea"] =			{index=67; 	tid=1079694; 				descTid=1152422;							iconId=85829;																						};
		["HitFireball"] =			{index=68; 	tid=1079703; 				descTid=1152412;							iconId=85830;																						};
		["HitLightning"] =			{index=69; 	tid=1079705; 				descTid=1152426;							iconId=85831;																						};
		["HitMagicArrow"] =			{index=70; 	tid=1079706; 				descTid=1152427;							iconId=85832;																						};
		["HitHarm"] =				{index=71; 	tid=1079704; 				descTid=1152413;							iconId=85833;																						};
		["HitDispel"] =				{index=72; 	tid=1079702; 				descTid=1152409;							iconId=85834;																						};
		["HitCurse"] =				{index=73; 	tid=1113712; 				descTid=1152438;							iconId=85835;																						};
		["HitLifeLeech"] =			{index=74; 	tid=1079698; 				descTid=1152425;							iconId=85836;																						};
		["HitManaLeech"] =			{index=75; 	tid=1079701; 				descTid=1152424;							iconId=85837;																						};
		["HitStaminaLeech"] =		{index=76; 	tid=1079707; 				descTid=1152423;							iconId=85838;																						};
		["HitLifeDrain"] =			{index=77; 	stringText=GetStringFromTid(97); 	descTid=1152425;							iconId=85839;																						};
		["HitManaDrain"] =			{index=78; 	tid=1113699;			 	descTid=1152436;							iconId=85840;																						};
		["HitFatigue"] =			{index=79; 	tid=1113700;			 	descTid=1152437;							iconId=85841;																						};
	
		["IncreaseHitPoints"] =		{index=80; 	 				 																		cap=25;																				};
		["IncreaseStam"] =			{index=81; 	 				 																																							};
		["IncreaseMana"] =			{index=82; 	 				 																																							};
	
		["GargoyleQueen"] =			{index=83;	 tid=1095163;															iconId=85845;														bonus="GargoyleQueenLevel";		};
		["Ophidian"] =				{index=84;   tid=1115733;															iconId=85847;														bonus="OphidianLevel";			};
		["BaneChosen"] =			{index=85;   tid=1115734;															iconId=85846;														bonus="BaneChosenLevel";		};
		["Meer"] =					{index=86;   tid=1116245;															iconId=85848;														bonus="MeerLevel";				};
		["Juka"] =					{index=87;   tid=1079796;															iconId=85849;														bonus="JukaLevel";				};
		["Shame"] =					{index=88;   tid=1123444;															iconId=85850;																						};
		["Despise"] =				{index=89;   tid=1123419;															iconId=85851;																						};
		["Void"] =					{index=90;   tid=1152531;															iconId=85852;																						};
		["Britain"] =				{index=91;   tid=1011028;																								buttonId=3;						nodrag=true;					};
		["Jhelom"] =				{index=92;   tid=1011343;																								buttonId=4;						nodrag=true;					};
		["Minoc"] =					{index=93;   tid=1011031;																								buttonId=5;						nodrag=true;					};
		["Moonglow"] =				{index=94;   tid=1011344;																								buttonId=6;						nodrag=true;					};
		["NewMagincia"] =			{index=95;   tid=1011345;																								buttonId=7;						nodrag=true;					};
		["SkaraBrae"] =				{index=96;   tid=1011347;																								buttonId=8;						nodrag=true;					};
		["Trinsic"] =				{index=97;   tid=1011029;																								buttonId=9;						nodrag=true;					};
		["Vesper"] =				{index=98;	 tid=1011030;																								buttonId=10;					nodrag=true;					};
		["Yew"] =					{index=99;	 tid=1011032;																								buttonId=11;					nodrag=true;					};
		["Citizenship"] =			{index=100;  tid=1152883;				descTid=1152888;																buttonId=4;						nodrag=true;	space=true;		};
		["CitizenshipTitles"] =		{index=101;  tid=1152890;																								buttonId=3;						noValue=true;					};
											
		["HealingSpeed"] =			{index=102;  stringText=GetStringFromTid(189); stringDesc=GetStringFromTid(190);					iconId=85854;									separator=" / ";									};
	
	}
end

CharacterSheet.CreatedLabels = {}

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function CharacterSheet.Initialize()
	CharacterSheet.InitializeAttributes()

	LabelSetText("CharacterSheetTitle", L">>>> " .. wstring.upper(GetStringFromTid(CharacterSheet.TID.CharacterSheet)) .. L" <<<<" )
	WindowUtils.RestoreWindowPosition("CharacterSheet")
	
	if Interface.SiegeRules then -- removing the bank gold from siege perilouse because we can't access the insurance menu.
		CharacterSheet.Groups[8] = { nameString=L"Miscellaneous",		nameTid=1011173,		mods={"Karma", "Fame", "Luck", "Gold", "Weight", "Followers", "HealingSpeed"}}
	end
	
	CharacterSheet.PopulateWindow()
	
end

function CharacterSheet.Shutdown()
	WindowUtils.SaveWindowPosition("CharacterSheet")
end

function CharacterSheet.ClearLabels(group)
	if not CharacterSheet.CreatedLabels[group] then
		return
	end
	for j = 1, #CharacterSheet.CreatedLabels[group] do
		local win = CharacterSheet.CreatedLabels[group][j]
		if DoesWindowExist(win) then
			DestroyWindow(win)
		end
	end
	CharacterSheet.CreatedLabels[group] = {}
end

function CharacterSheet.ClearAll()
	local parent = "CharacterSheetScrollAreaScrollChild"
	local w = WindowGetDimensions(parent)
	for i = 1, #CharacterSheet.Groups do
		local tabName = parent.."TabButton"..i
		local frameName = parent.."TabFrame"..i
		CharacterSheet.ClearLabels(i)
		
		if DoesWindowExist(tabName) then
			DestroyWindow(tabName)
		end
		
		if DoesWindowExist(frameName .. "Top") then
			DestroyWindow(frameName .. "Top")
		end
		if DoesWindowExist(frameName .. "Bottom") then
			DestroyWindow(frameName .. "Bottom")
		end
		if DoesWindowExist(frameName .. "Left") then
			DestroyWindow(frameName .. "Left")
		end
		if DoesWindowExist(frameName .. "Right") then
			DestroyWindow(frameName .. "Right")
		end
		if DoesWindowExist(frameName .. "BG") then
			DestroyWindow(frameName .. "BG")
		end
	end
	if DoesWindowExist(parent .. "BottomLine") then
		DestroyWindow(parent .. "BottomLine")
	end
	WindowSetDimensions(parent, w, 0)
	
	ScrollWindowUpdateScrollRect( "CharacterSheetScrollArea" )
end

function CharacterSheet.GetStatNameById(id)
	for name, data in pairs(CharacterSheet.AttributesDef) do
		if data.index == id then
			return name
		end
	end
end

function CharacterSheet.GetStatIdByName(name)
	if CharacterSheet.AttributesDef[name] then
		return CharacterSheet.AttributesDef[name].index
	end
end

function CharacterSheet.PopulateWindow()
	
	CharacterSheet.ClearAll()
	
	local parent = "CharacterSheetScrollAreaScrollChild"
	local frameName
	local w = WindowGetDimensions(parent)
	local totalH = 0
	local xOff = 0
	for i = 1, #CharacterSheet.Groups do
		local tabName = parent.."TabButton"..i
		
		frameName = parent.."TabFrame"..i
		local prevFrameName = parent.."TabFrame"..i - 1 .. "Bottom"
		CreateWindowFromTemplate(tabName, "CategoryTag", parent)
		
		local x, y = WindowGetDimensions(tabName)
		
		WindowClearAnchors(tabName)
		if i == 1 then
			WindowAddAnchor(tabName, "topleft", parent, "topleft", 0, 5)
			xOff = WindowGetOffsetFromParent(tabName)
			totalH = totalH + y + 5
		else
			WindowAddAnchor(tabName, "bottomleft", prevFrameName, "topleft", -1, 10)
			local _, yOffs = WindowGetOffsetFromParent(tabName)
			WindowClearAnchors(tabName)
			WindowSetOffsetFromParent(tabName, xOff, yOffs)
			totalH = totalH + y + 10
		end
		WindowSetId(tabName, i)
		ButtonSetDisabledFlag( tabName, true )
		
		local text = CharacterSheet.Groups[i].nameString
		if CharacterSheet.Groups[i].nameTid then
			text = GetStringFromTid(CharacterSheet.Groups[i].nameTid)
		end
		ButtonSetText(tabName, wstring.upper(text))
		
		local h = 0

		local entry
		if Interface.LoadSetting( "CharacterSheetCategory_" .. i .. "_Visible" , true) then
			WindowSetShowing(tabName .. "HideCategory", true)
			
			local template = "AttributeTemplate"
			if CharacterSheet.Groups[i].nameTid == 1152190 then -- city loyalty
				template = "CityLoyaltyTemplate"
			end
			
			for j = 1, #CharacterSheet.Groups[i].mods do
				local mod = CharacterSheet.Groups[i].mods[j]
				entry = tabName .. "Stat"..j
				local space = 0
				if CharacterSheet.AttributesDef[mod].space then
					space = 10					
				end
				local prevEntry = tabName .. "Stat"..j - 1
				CreateWindowFromTemplate(entry, template, parent)
				
				WindowSetId(entry, CharacterSheet.AttributesDef[mod].index)
				
				WindowClearAnchors(entry)
				
				if j == 1 then
					WindowAddAnchor(entry, "bottomleft", tabName, "topleft", 0, 10)
				else
					WindowAddAnchor(entry, "bottomleft", prevEntry, "topleft", 0, 5 + space)
				end
				if not CharacterSheet.CreatedLabels[i] then
					CharacterSheet.CreatedLabels[i] = {}
				end
				table.insert(CharacterSheet.CreatedLabels[i], entry)
				
				x, y = WindowGetDimensions(entry)
				local point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor (entry, 1)
				h = h + y + yOffs
				
				if template ~= "CityLoyaltyTemplate" then
					CharacterSheet.SetMiniIconStats(entry, CharacterSheet.AttributesDef[mod].iconId)
				end
				
				if CharacterSheet.AttributesDef[mod].tid then
					local text = wstring.gsub(ReplaceTokens(GetStringFromTid(CharacterSheet.AttributesDef[mod].tid), {L""}), L"%%", L"")
					text = wstring.gsub(ReplaceTokens(text, {L""}), L":", L"")
					LabelSetText(entry .. "AttributeName", FormatProperly(text))
				elseif CharacterSheet.AttributesDef[mod].stringText then
					LabelSetText(entry .. "AttributeName", FormatProperly(CharacterSheet.AttributesDef[mod].stringText))
				end
				
				CharacterSheet.UpdateLabel(mod, entry, tabName)
			end	
			h = h + 8
			
			local tabW = WindowGetDimensions(tabName)
			-- top line
			CreateWindowFromTemplate(frameName .. "Top", "HRLine", parent)
			WindowClearAnchors(frameName .. "Top")
			WindowSetDimensions(frameName .. "Top", 0, 0)
			WindowSetDimensions(frameName .. "Top", w - tabW, 4)
			WindowSetAlpha(frameName .. "Top", 0.6)
			WindowAddAnchor(frameName .. "Top", "bottomright", tabName, "topleft", -2, -4)
			
			-- bottom line
			CreateWindowFromTemplate(frameName .. "Bottom", "HRLine", parent)
			WindowClearAnchors(frameName .. "Bottom")
			WindowSetDimensions(frameName .. "Bottom", 0, 0)
			WindowSetDimensions(frameName .. "Bottom", w-2, 4)
			WindowSetAlpha(frameName .. "Bottom", 0.6)
			WindowAddAnchor(frameName .. "Bottom", "bottomleft", tabName, "topleft", 1.5, h+2)
			
			if entry then
				-- left line
				CreateWindowFromTemplate(frameName .. "Left", "HRLine", parent)
				WindowClearAnchors(frameName .. "Left")
				WindowSetDimensions(frameName .. "Left", 0, 0)
				WindowSetDimensions(frameName .. "Left", 4, h+2)
				WindowSetAlpha(frameName .. "Left", 0.6)
				WindowAddAnchor(frameName .. "Left", "bottomleft", tabName, "topleft", 1, 0)
				
				-- right line
				CreateWindowFromTemplate(frameName .. "Right", "HRLine", parent)
				WindowClearAnchors(frameName .. "Right")
				WindowSetDimensions(frameName .. "Right", 0, 0)
				WindowSetDimensions(frameName .. "Right", 4, h+6)
				WindowSetAlpha(frameName .. "Right", 0.6)
				WindowAddAnchor(frameName .. "Right", "topright", frameName .. "Top", "topright", 2, 0)
				
				CreateWindowFromTemplate(frameName .. "BG", "TabFrameBG", parent)
				WindowClearAnchors(frameName .. "BG")
				WindowSetAlpha(frameName.."BG", 0.6)
				WindowAddAnchor(frameName .. "BG", "bottomleft", tabName, "topleft", 2, 0)
				WindowAddAnchor(frameName .. "BG", "bottomright", frameName .. "Bottom", "bottomright", 0, 0)
			end
		else
			h = 0
			
			WindowSetShowing(tabName .. "HideCategory", false)
			
			-- bottom line
			CreateWindowFromTemplate(frameName .. "Bottom", "HRLine", parent)
			WindowClearAnchors(frameName .. "Bottom")
			WindowSetDimensions(frameName .. "Bottom", 0, 0)
			WindowSetDimensions(frameName .. "Bottom", w, 4)
			WindowSetAlpha(frameName .. "Bottom", 0.6)
			WindowAddAnchor(frameName .. "Bottom", "bottomleft", tabName, "topleft", 1, 0)
			WindowAddAnchor(frameName .. "Bottom", "bottomright", tabName, "topright", -2, 0)
		end
		totalH = totalH + h
	end

	-- created to push the scrollwindow size down
	
	CreateWindowFromTemplate(parent .. "BottomLine", "HRLine", parent)
	WindowSetDimensions(parent .. "BottomLine", 1, 1)
	WindowAddAnchor(parent .. "BottomLine", "bottomleft", frameName .. "Bottom", "bottomleft", 0, 10)
		
	WindowSetDimensions(parent, w, totalH)
	
	ScrollWindowUpdateScrollRect( "CharacterSheetScrollArea" ) 
end

function CharacterSheet.UpdateLabels()
	if not Interface.started then
		return
	end
	local parent = "CharacterSheetScrollAreaScrollChild"
	local cityLoyalty = WindowData.PlayerStatus["Citizenship"]
	for i = 1, #CharacterSheet.Groups do
		local tabName = parent.."TabButton"..i
		
		if Interface.LoadSetting( "CharacterSheetCategory_" .. i .. "_Visible" , true) then
			for j = 1, #CharacterSheet.Groups[i].mods do
				local mod = CharacterSheet.Groups[i].mods[j]
				entry = tabName .. "Stat"..j
				
				if not CharacterSheet.AttributesDef[mod].noValue then
					CharacterSheet.UpdateLabel(mod, entry, tabName)
				else
					LabelSetText(entry.."AttributeValue", L"")
				end
				
				-- citizenship toggle button
				if CharacterSheet.Groups[i].nameTid == 1152190 then -- city loyalty
					
					if cityLoyalty == GetStringFromTid(1152884) and not CharacterSheet.cityLoyaltyBlock then -- No City
						DynamicImageSetTexture( entry.."SquareIcon", "SmallRoundButton", 0, 0 )
						DynamicImageSetTextureScale(entry.."SquareIcon", 1)
						WindowSetHandleInput(entry.."SquareIcon", true)
					else
						DynamicImageSetTexture( entry.."SquareIcon", "PROPS_Deny", 0, 0 )
						DynamicImageSetTextureScale(entry.."SquareIcon", 0.2)
					end
				end
			
				-- renounce citizenship toggle button
				if mod == "Citizenship" or mod == "CitizenshipTitles" then
					if cityLoyalty == GetStringFromTid(1152884) or CharacterSheet.cityLoyaltyBlock then -- No City
						WindowSetShowing(entry.."SquareIcon", false)
					else
						DynamicImageSetTexture( entry.."SquareIcon", "SmallRoundButton", 0, 0 )
						DynamicImageSetTextureScale(entry.."SquareIcon", 1)
						WindowSetShowing(entry.."SquareIcon", true)
					end
				end
			end
		end
	end
end

function CharacterSheet.isLoyalty(mod)
	for i=1, #CharacterSheet.Groups[11].mods do
		if mod == CharacterSheet.Groups[11].mods[i] then
			return true
		end
	end
	return false
end

function CharacterSheet.UpdateLabel(mod, entry, tabName)
	if not Interface.started then
		return
	end
	local value
	if WindowData.PlayerStatus[mod] then
		if CharacterSheet.isLoyalty(mod) then 
			value = WindowData.PlayerStatus[mod]
		elseif string.find(mod, "Current", 1, true) then
			value = WindowData.PlayerStatus[mod]..CharacterSheet.AttributesDef[mod].separator..WindowData.PlayerStatus["Max"..string.gsub(mod, "Current", "")]
			local bonus = CharacterSheet.AttributesDef[mod].bonus
			
			if WindowData.PlayerStatus[bonus] then
				local val = tonumber(WindowData.PlayerStatus[bonus])
				local cap = CharacterSheet.AttributesDef[mod].cap
				local str = L""
				if cap then
					if val > 0 then
						str = L"(+"..val .. L" / "  .. cap .. L")"
					elseif val < 0 then
						str = L"("..val .. L" / "  .. cap .. L")"
					end
				else
					if val > 0 then
						str = L"(+" .. val .. L")" 
					elseif val < 0 then
						str = L"(" .. val .. L")"
					end
				end
				LabelSetText(entry.."Extra", str)
			end
		elseif CharacterSheet.AttributesDef[mod].bonus then
			value = WindowData.PlayerStatus[mod]
			local bonus = CharacterSheet.AttributesDef[mod].bonus
			
			if WindowData.PlayerStatus[bonus] then
				local val = WindowData.PlayerStatus[bonus]
				local cap = CharacterSheet.AttributesDef[mod].cap
				local str = L""
				
				if cap then
					if val > 0 then
						str = L"(+"..val .. L" / "  .. cap .. L")"
					elseif val < 0 then
						str = L"("..val .. L" / "  .. cap .. L")"
					end
				else
					if type(val) == "number" then
						if tonumber(val) > 0 then
							str = L"(+" .. val .. L")" 
						elseif tonumber(val) < 0 then
							str = L"(" .. val .. L")"
						end
					else
						str = L"(" .. val .. L")"
					end
				end
				LabelSetText(entry.."Extra", str)
			end
		elseif CharacterSheet.AttributesDef[mod].separator then
			value = WindowData.PlayerStatus[mod]..CharacterSheet.AttributesDef[mod].separator..WindowData.PlayerStatus["Max"..mod]
		elseif CharacterSheet.AttributesDef[mod].cap then
			value = WindowData.PlayerStatus[mod].." / "..CharacterSheet.AttributesDef[mod].cap
		elseif type(WindowData.PlayerStatus[mod]) == "wstring" then
			value = WindowData.PlayerStatus[mod]
		else
			value = StringUtils.AddCommasToNumber(WindowData.PlayerStatus[mod])
		end
	else
		value = 0
	end
	
	LabelSetText(entry.."AttributeValue", towstring(value))
	
	local button = entry.."LockButton"
	if DoesWindowExist(button) then
		DynamicImageSetTexture( button, "", 0, 0 )
		WindowSetDimensions( button, 0, 0 )
	end
	
	if mod == "Strength" then
		local val = WindowData.PlayerStatus.StatLock[0]
		--Debug.Print("Update StatLock["..tostring(CharacterSheet.Attributes[stat]).."]="..tostring(val))
		if val == 0 then
			WindowSetDimensions(button, 22, 22)
			DynamicImageSetTexture( button, "arrowup", 0, 0 )
		elseif val == 1 then
			WindowSetDimensions(button, 22, 22)
			DynamicImageSetTexture( button, "arrowdown", 0, 0 )		
		elseif val == 2 then
			WindowSetDimensions(button, 22, 22)
			DynamicImageSetTexture( button, "Lock_Button", 0, 0 )	
		end
		local bonus = CharacterSheet.AttributesDef[mod].bonus
		if WindowData.PlayerStatus[bonus] then
			local val = tonumber(WindowData.PlayerStatus[bonus])
			local str = L""
			if val > 0 then
				str = L"(+"..towstring(val)..L")" 
			elseif val < 0 then
				str = L"("..towstring(val)..L")"
			end
			LabelSetText(entry.."Extra", str)
		end
		
	elseif mod == "Dexterity" then 
		local val = WindowData.PlayerStatus.StatLock[1]
		--Debug.Print("Update StatLock["..tostring(CharacterSheet.Attributes[stat]).."]="..tostring(val))
		if val == 0 then
			WindowSetDimensions(button, 22, 22)
			DynamicImageSetTexture( button, "arrowup", 0, 0 )
		elseif val == 1 then
			WindowSetDimensions(button, 22, 22)
			DynamicImageSetTexture( button, "arrowdown", 0, 0 )		
		elseif val == 2 then
			WindowSetDimensions(button, 22, 22)
			DynamicImageSetTexture( button, "Lock_Button", 0, 0 )	
		end
		local bonus = CharacterSheet.AttributesDef[mod].bonus
		if WindowData.PlayerStatus[bonus] then
			local val = tonumber(WindowData.PlayerStatus[bonus])
			local str = L""
			if val > 0 then
				str = L"(+"..towstring(val)..L")" 
			elseif val < 0 then
				str = L"("..towstring(val)..L")"
			end
			LabelSetText(entry.."Extra", str)
		end
		
	elseif mod == "Intelligence" then
		local val = WindowData.PlayerStatus.StatLock[2]
		--Debug.Print("Update StatLock["..tostring(CharacterSheet.Attributes[stat]).."]="..tostring(val))
		if val == 0 then
			WindowSetDimensions(button, 22, 22)
			DynamicImageSetTexture( button, "arrowup", 0, 0 )
		elseif val == 1 then
			WindowSetDimensions(button, 22, 22)
			DynamicImageSetTexture( button, "arrowdown", 0, 0 )		
		elseif val == 2 then
			WindowSetDimensions(button, 22, 22)
			DynamicImageSetTexture( button, "Lock_Button", 0, 0 )	
		end
		local bonus = CharacterSheet.AttributesDef[mod].bonus
		if WindowData.PlayerStatus[bonus] then
			local val = tonumber(WindowData.PlayerStatus[bonus])
			local str = L""
			if val > 0 then
				str = L"(+"..towstring(val)..L")" 
			elseif val < 0 then
				str = L"("..towstring(val)..L")"
			end
			LabelSetText(entry.."Extra", str)
		end
		
	end
end

function CharacterSheet.SetMiniIconStats(iconWindow, iconId)
	local texture, x, y = GetIconData( iconId )
	--Start position of the texture, need to be offset by x and y to get the stat icon image
	x = 4  
	y = 3
	WindowSetDimensions(iconWindow.."SquareIcon", 27, 27)
	DynamicImageSetTexture( iconWindow.."SquareIcon", texture, x, y )	   
	DynamicImageSetTextureScale(iconWindow.."SquareIcon", 1 )
end

function CharacterSheet.OnShown()
    if (WindowData.PlayerStatus ~= nil and GetPlayerID() ~= nil) then
        local paperdollWindow = "PaperdollWindow"..GetPlayerID()
        if (DoesWindowExist(paperdollWindow)) then
            ButtonSetPressedFlag(paperdollWindow.."ToggleCharacterSheet",true)
        end
    end
    CharacterSheet.UpdateStatus()
end

function CharacterSheet.OnHidden()
    if (WindowData.PlayerStatus ~= nil and GetPlayerID() ~= nil) then
        local paperdollWindow = "PaperdollWindow"..GetPlayerID()
        if (DoesWindowExist(paperdollWindow)) then
            ButtonSetPressedFlag(paperdollWindow.."ToggleCharacterSheet",false)
        end
    end
end

function CharacterSheet.UpdateStatus()
	
	PaperdollWindow.ScanProperties()

	-- DPS calculator
	local mindmg = WindowData.PlayerStatus["Damage"]
	local maxdmg = WindowData.PlayerStatus["MaxDamage"]
	local avgdmg = (mindmg + maxdmg) / 2
	local finalspeed = tonumber(WindowData.PlayerStatus["SwingSpeed"])
	
	if finalspeed == 0 then
		finalspeed = 1.25
	end

	WindowData.PlayerStatus["DPS"] = string.format("%.2f", avgdmg/finalspeed)

	-- healing speed calculator
	WindowData.PlayerStatus["HealingSpeed"] = math.ceil(11 - (WindowData.PlayerStatus["Dexterity"] / 20)) .. "s"
	WindowData.PlayerStatus["MaxHealingSpeed"] = math.ceil(4 - (WindowData.PlayerStatus["Dexterity"] / 60)) .. "s"
	
	if DoesWindowExist("CharacterSheet") and WindowGetShowing("CharacterSheet") then
		CharacterSheet.UpdateLabels()
	end
end

function CharacterSheet.ClickStatLock()
	local this = WindowGetParent(SystemData.ActiveWindow.name)
	local id = WindowGetId(this)
	--Debug.Print("Button id is "..id)

	local mod = CharacterSheet.GetStatNameById(id)
	if mod == "Strength" then
		id = 0
	elseif mod == "Dexterity" then 
		id = 1
	elseif mod == "Intelligence" then
		id = 2
	else
		id = nil
	end

	if id then
		-- CJT: originally the stat locks were buttons 1-3
		local lock = WindowData.PlayerStatus.StatLock[id]

		lock = lock + 1
		if lock > 2 then 
			lock = 0
		end

		--Debug.Print("setting statlock "..id.." to "..lock)
		WindowData.PlayerStatus.StatLock[id] = lock
		--Debug.Dump('StatLock', WindowData.PlayerStatus.StatLock) 
		UpdateStatLock(id)
		
		CharacterSheet.UpdateStatus()
	end
end

function CharacterSheet.StatLButtonDown(flags)
	local parent = WindowGetParent(SystemData.ActiveWindow.name)
	local id = WindowGetId(parent)

	local iconId = CharacterSheet.AttributesDef[CharacterSheet.GetStatNameById(id)].iconId
	
	local cityLoyalty = WindowData.PlayerStatus["Citizenship"]

	if CharacterSheet.AttributesDef[CharacterSheet.GetStatNameById(id)].buttonId and string.find(SystemData.ActiveWindow.name, "SquareIcon", 1, true) then
		if  (not CharacterSheet.cityLoyaltyBlock and cityLoyalty == GetStringFromTid(1152884)) or 
			(not CharacterSheet.cityLoyaltyBlock and cityLoyalty ~= GetStringFromTid(1152884) and (CharacterSheet.GetStatNameById(id) == "Citizenship" or CharacterSheet.GetStatNameById(id) == "CitizenshipTitles")) 
		then
			CharacterSheet.TakeCityLoyalty = CharacterSheet.AttributesDef[CharacterSheet.GetStatNameById(id)].buttonId
			ContextMenu.RequestContextAction(GetPlayerID(), ContextMenu.DefaultValues.LoyaltyRating)
		end
		return
	end
	
	if (flags ~= SystemData.ButtonFlags.SHIFT and flags == SystemData.ButtonFlags.CONTROL and flags ~= SystemData.ButtonFlags.ALT) then
		local alreadyInBar, existingSlot = HotbarSystem.ActionAlreadyInHotbar(id, SystemData.UserAction.TYPE_PLAYER_STATS )
		if alreadyInBar then
			ChatPrint(GetStringFromTid(285), SystemData.ChatLogFilters.SYSTEM)
			return
		end
		local lblid = QuickStats.GetId()
		local label = "QuickStat_" .. lblid
		local l = QuickStats.DoesLabelExist(id)
		if l > 0 and DoesWindowExist("QuickStat_" .. l) then
			label = "QuickStat_" .. l
		else
			local lab = {attribute=id, frame=true, icon=true, name=true, cap=true, locked=false, minQuantity=-1, BGColor={r=0,g=0,b=0}, frameColor={r=255,g=255,b=255}, valueTextColor={r=255,g=255,b=255}, nameTextColor={r=243,g=227,b=49}}
			table.insert(QuickStats.Labels, lblid, lab)
			local k = CharacterSheet.GetStatNameById(id)
			if (k == "Followers") then
				lab.minQuantity = -1
			end
			CreateWindowFromTemplate(label, "QuickStatTemplate", "Root")
			WindowSetId(label, lblid)
			QuickStats.UpdateLabel(label)
			QuickStats.Save(label)
			SnapUtils.SnappableWindows[label] = true
		end
		
		-- forcing the label to follow the mouse cursor
		WindowUtils.FollowMouseCursor(label, 380, 30, -30, -15, false, false, true)

		QuickStats.InMovement[label] = true
		WindowSetMoving(label, true)
	else
		local alreadyInBar, existingSlot = HotbarSystem.ActionAlreadyInHotbar(id, SystemData.UserAction.TYPE_PLAYER_STATS )
		if alreadyInBar then
			HotbarSystem.GlowSlotWarning(existingSlot, 5, id)
		end
		DragSlotSetActionMouseClickData(SystemData.UserAction.TYPE_PLAYER_STATS,id,iconId)
	end
end

function CharacterSheet.StatMouseOver()	
	local parent = WindowGetParent(SystemData.ActiveWindow.name)
	if parent == "CharacterSheetScrollAreaScrollChild" then
		parent = SystemData.ActiveWindow.name
	end
	local id = WindowGetId(parent)

	local itemData = { windowName = parent,
						itemId = id,
						itemType = WindowData.ItemProperties.TYPE_ACTION,
						actionType = SystemData.UserAction.TYPE_PLAYER_STATS,
						detail = ItemProperties.DETAIL_LONG }

	ItemProperties.SetActiveItem(itemData)
end

function CharacterSheet.LockMouseOver()
	local text = GetStringFromTid(1112102)
	local buttonName = SystemData.ActiveWindow.name
	Tooltips.CreateTextOnlyTooltip(buttonName, text)
end

function CharacterSheet.ShowCategory()
	local tab = WindowGetParent(SystemData.ActiveWindow.name)
	local id = WindowGetId(tab)
	Interface.SaveSetting( "CharacterSheetCategory_" .. id .. "_Visible" , true )
	CharacterSheet.PopulateWindow()
end

function CharacterSheet.ShowCategoryOver()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(98))
end

function CharacterSheet.HideCategory()
	local tab = WindowGetParent(SystemData.ActiveWindow.name)
	local id = WindowGetId(tab)
	Interface.SaveSetting( "CharacterSheetCategory_" .. id .. "_Visible" , false )
	CharacterSheet.PopulateWindow()
end

function CharacterSheet.HideCategoryOver()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(99))
end

function CharacterSheet.OnRButtonDown()
	WindowSetShowing("CharacterSheet", false)
end

function CharacterSheet.isInLoyaltyRating(mod)
	if mod == "Karma" or mod == "Fame" then
		return true
	end
	for i=1, #CharacterSheet.Groups[9].mods do
		if mod == CharacterSheet.Groups[9].mods[i] then
			return true
		end
	end
	for i=1, #CharacterSheet.Groups[10].mods do
		if mod == CharacterSheet.Groups[10].mods[i] then
			return true
		end
	end
	for i=1, #CharacterSheet.Groups[11].mods do
		if mod == CharacterSheet.Groups[11].mods[i] then
			return true
		end
	end
	return false
end