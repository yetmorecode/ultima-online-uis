
----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

BuffDebuff = {}

BuffDebuff.BuffData = {}
BuffDebuff.Timers = {}
BuffDebuff.BuffWindowId = {}
BuffDebuff.TableOrder = {}
BuffDebuff.ReverseOrder = {}
BuffDebuff.MaxLength = 6
BuffDebuff.Gap = 2
BuffDebuff.DeltaTime = 0
BuffDebuff.Fade = {start = 30, endtime = 10, amount = 0.2 }
BuffDebuff.TID = {}
BuffDebuff.TID.timeleft = 1075611
BuffDebuff.IconSize = 38
BuffDebuff.ActiveBuffs = {}
BuffDebuff.Fade = {}
BuffDebuff.FadeRaising = {}
BuffDebuff.MouseOverFlag = false

BuffDebuff.Good = {
[1005] = true; -- AB_NIGHT_SIGHT
[1010] = true; -- AB_DIVINE_FURY
[1011] = true; -- AB_ENEMY_OF_ONE
[1014] = true; -- AB_BLOOD_OATH_CASTER
[1020] = true; -- AB_RENEWAL
[1021] = true; -- AB_ATTUNE_WEAPON
[1024] = true; -- AB_ETHEREAL_VOYAGE
[1025] = true; -- AB_GIFT_OF_LIFE
[1026] = true; -- AB_ARCANE_EMPOWERMENT
[1028] = true; -- AB_REACTIVE_ARMOR
[1029] = true; -- AB_PROTECTION
[1030] = true; -- AB_ARCH_PROTECTION
[1031] = true; -- AB_MAGIC_REFLECTION
[1034] = true; -- AB_ANIMAL_FORM
[1035] = true; -- AB_POLYMORPH
[1036] = true; -- AB_INVISIBILITY
[1045] = true; -- AB_AGILITY
[1046] = true; -- AB_CUNNING
[1047] = true; -- AB_STRENGTH_SPELL
[1048] = true; -- AB_BLESS
[1050] = true; -- AB_STONE_FORM
[1052] = true; -- AB_GARGOYLE_BERSERK
[1055] = true; -- AB_BARD_INSPIRE
[1056] = true; -- AB_BARD_INVIGORATE
[1057] = true; -- AB_BARD_RESILIENCE
[1058] = true; -- AB_BARD_PERSEVERANCE
[1061] = true; -- AB_NEWBIE_TOKEN
[1062] = true; -- AB_FISH_BUFF
[1065] = true; -- AB_HIT_DUAL_WIELD
[1066] = true; -- AB_BLOCK
[1067] = true; -- AB_DEFENSE_MASTERY
[1069] = true; -- AB_HEALING_SKILL
[1070] = true; -- AB_SPELL_FOCUSING_BUFF
[1073] = true; -- AB_RAGE_FOCUSING_BUFF
[1074] = true; -- AB_WARDING
[1075] = true; -- AB_BARD_TRIBULATION_BUFF
[1078] = true; -- AB_SURGE
[1079] = true; -- AB_FEINT
[1082] = true; -- AB_CONSECRATE_BUFF
[1083] = true; -- AB_GRAPES_OF_WRATH
[1085] = true; -- AB_HORRIFIC_BEAST
[1086] = true; -- AB_LICH_FORM
[1087] = true; -- AB_VAMPRIC_FORM
[1088] = true; -- AB_CURSE_WEAPON
[1089] = true; -- AB_REAPER_FORM
[1124] = true; -- AB_WRAITH_FORM
[1090] = true; -- AB_IMMOLATING_WEAPON
[1091] = true; -- AB_ENCHANT
[1092] = true; -- AB_HONORABLE_EXEC
[1093] = true; -- AB_CONFIDENCE
[1094] = true; -- AB_EVASION
[1095] = true; -- AB_COUNTER_ATTACK
[1096] = true; -- AB_LIGHTNING_STRIKE
[1097] = true; -- AB_MOMENTUM_STRIKE
[1098] = true; -- AB_ORANGE_PETALS
[1099] = true; -- AB_ROSEOFTRINSIC_PETALS
[1100] = true; -- AB_POISON_IMMUNITY
[1101] = true; -- AB_VETERINARY
[1102] = true; -- AB_PERFECTION
[1103] = true; -- AB_HONORED_BUFF
[1104] = true; -- AB_MANA_PHASE
[1126] = true; -- AB_CITY_BUFF
[1128] = true; -- AB_VIRTUE_SPIRITUALITY_BUFF
[1129] = true; -- AB_HUMILITY_BUF
[1130] = true; -- AB_RAMPAGE
[1132] = true; -- AB_TOUGHNESS
[1133] = true; -- AB_THRUST
[1135] = true; -- AB_SCAVENG
[1136] = true; -- AB_FOCUSED_EYE
[1138] = true; -- AB_MAGNUS_EFFECT
[1140] = true; -- AB_CALLED_SHOT
[1141] = true; -- AB_WRESTLING_PASSIVE
[1142] = true; -- AB_SAVING_THROW
[1143] = true; -- AB_CONDUIT_BUFF
[1145] = true; -- AB_MYSTIC_WEAPON_BUFF
[1146] = true; -- AB_SW_MANA_SHIELD_BUFF
[1147] = true; -- AB_ANTICIPATE_HIT_BUFF
[1148] = true; -- AB_WAR_CRY_BUF
[1149] = true; -- AB_SHADOW_BUFF
[1150] = true; -- AB_WHITE_TIGER_BU
[1151] = true; -- AB_BODY_GUARD_BUFF
[1152] = true; -- AB_HEIGHTENSENSES_BUFF
[1153] = true; -- AB_TOLERANCE_BUFF
[1154] = true; -- AB_DEATH_RAY
[1156] = true; -- AB_MELEECAST_PASSIVE
[1157] = true; -- AB_SPELLCAST_PASSIVE
[1158] = true; -- AB_SHIELD_BASH
[1159] = true; -- AB_WHISPERING
[1160] = true; -- AB_COMBAT_TRAINING
[1162] = true; -- AB_INJECTING_BUFF
[1163] = true; -- AB_BUBBLE_IMMUNE_BUFF
[1166] = true; -- AB_BOARDING_BUFF
[1167] = true; -- AB_POTENCY_BUFF
[1169] = true; -- AB_FOF_BUFF
[1170] = true; -- AB_EODON_POTION_BARRAB_HEMOLYMPH
[1171] = true; -- AB_EODON_POTION_JUKARI_BURN
[1172] = true; -- AB_EODON_POTION_KURAK_AMBUSHER
[1173] = true; -- AB_EODON_POTION_BARAKO_DRAFT
[1174] = true; -- AB_EODON_POTION_URALI_TRANCE
[1175] = true; -- AB_EODON_POTION_SAKKHRA_PROPHYLAXIS

[1179] = true; -- AB_HIT_SPARKS_IMMUNE_BUFF
[1180] = true; -- AB_HIT_SWARM_IMMUNE_BUFF
[1181] = true; -- AB_HIT_BONECRUSHER_IMMUNE_BUFF
[1182] = true; -- AB_STATUE_TRANSFORM
[1183] = true; -- AB_CORA_IMMUNE
[1184] = true; -- AB_VIRTUE_SHIELD
[1186] = true; -- AB_TOK_METEOR_BUFF
[1187] = true; -- AB_POTION_GLORIOUS_FORTUNE_BUFF
[1188] = true; -- AB_TOTEM_TRANSFORM

-- custom buffs
[15001] = true;
[15002] = true;
[15003] = true;
[15004] = true;
[15005] = true;
[15006] = true;
[15007] = true;
[15008] = true;
[15009] = true;
[15010] = true;

-- super slayer buffs
[15050] = true; -- arachnid
[15051] = true; -- demon
[15052] = true; -- elemental
[15053] = true; -- undead
[15054] = true; -- fey
[15055] = true; -- repond 
[15056] = true; -- reptile
[15091] = true; -- Slayer_Dinosaur
[15092] = true; -- Slayer_Myrmidex
[15093] = true; -- Slayer_Eodontribe
[15094] = true; -- Slayer_Eodon

-- slayer buffs
[15070] = true; -- Slayer_AirElemental
[15071] = true; -- Slayer_BloodElemental
[15072] = true; -- Slayer_Dragon
[15073] = true; -- Slayer_EarthElemental
[15074] = true; -- Slayer_Bovine
[15075] = true; -- Slayer_Wolf 
[15076] = true; -- Slayer_WaterElemental
[15077] = true; -- Slayer_Troll
[15078] = true; -- Slayer_Terathan
[15079] = true; -- Slayer_Spider
[15080] = true; -- Slayer_SnowElemental
[15081] = true; -- Slayer_Snake
[15082] = true; -- Slayer_Scorpion
[15083] = true; -- Slayer_PoisonElemental
[15084] = true; -- Slayer_Orc
[15085] = true; -- Slayer_Ophidian
[15086] = true; -- Slayer_Ogre
[15087] = true; -- Slayer_Gargoyle
[15088] = true; -- Slayer_FireElemental
[15089] = true; -- Slayer_Lizardman
[15090] = true; -- Slayer_Balron
[15091] = true; -- Slayer_Dinosaur
[15092] = true; -- Slayer_Myrmidex

-- talisman slayer buffs
[15100] = true; -- Slayer_Bat
[15101] = true; -- Slayer_Bear
[15102] = true; -- Slayer_Beetle
[15103] = true; -- Slayer_Bird
[15104] = true; -- Slayer_Flame
[15105] = true; -- Slayer_Goblin 
[15106] = true; -- Slayer_Ice
[15107] = true; -- Slayer_Mage
[15108] = true; -- Slayer_Vermin

[15122] = true; -- Honor
[15128] = true; -- Berserk rage
}

BuffDebuff.Neutral = {
[1012] = true; -- AB_HIDDEN
[1013] = true; -- AB_MEDITATING
[1032] = true; -- AB_INCOGNITO
[1033] = true; -- AB_DISGUISED
[1054] = true; -- AB_GARGOYLE_FLY
[1068] = true; -- AB_BARD_DESPAIR_BUFF
[1008] = true; -- AB_HONORED

[15120] = true; -- Riding
[15130] = true; -- Piloting
}

BuffDebuff.Evil = {
[1001] = true; -- AB_NO_REMOUNT
[1002] = true; -- AB_NO_REARM
[1006] = true; -- AB_DEATH_STRIKE
[1007] = true; -- AB_EVIL_OMEN
[1009] = true; -- AB_ACHIEVE_PERFECTION
[1015] = true; -- AB_BLOOD_OATH_CURSE
[1016] = true; -- AB_CORPSE_SKIN
[1017] = true; -- AB_MIND_ROT
[1018] = true; -- AB_PAIN_SPIKE
[1019] = true; -- AB_STRANGLE
[1022] = true; -- AB_THUNDERSTORM
[1023] = true; -- AB_ESSENCE_OF_WIND
[1027] = true; -- AB_MORTAL_STRIKE
[1037] = true; -- AB_PARALYZE
[1038] = true; -- AB_POISON
[1039] = true; -- AB_BLEED
[1040] = true; -- AB_CLUMSY
[1041] = true; -- AB_FEEBLEMIND
[1042] = true; -- AB_WEAKEN
[1043] = true; -- AB_CURSE
[1044] = true; -- AB_MASS_CURSE
[1049] = true; -- AB_SLEEP
[1051] = true; -- AB_SPELL_PLAGUE
[1059] = true; -- AB_BARD_TRIBULATION
[1060] = true; -- AB_BARD_DESPAIR
[1063] = true; -- AB_HIT_LOWER_ATTACK
[1064] = true; -- AB_HIT_LOWER_DEFENSE
[1071] = true; -- AB_SPELL_FOCUSING_DEBUFF
[1072] = true; -- AB_RAGE_FOCUSING_DEBUFF
[1076] = true; -- AB_FORCE_ARROW
[1077] = true; -- AB_DISARM
[1080] = true; -- AB_TALON_STRIKE
[1081] = true; -- AB_PSYCHIC_ATTACK
[1105] = true; -- AB_FANDANCER_FIRE
[1106] = true; -- AB_RAGE
[1107] = true; -- AB_WEBBING
[1108] = true; -- AB_MEDUSA_STONE
[1109] = true; -- AB_FEAR
[1110] = true; -- AB_AURA_NAUSEA
[1111] = true; -- AB_HOWL_OF_CACOPHONY
[1112] = true; -- AB_GAZE_DESPAIR
[1113] = true; -- AB_HIRYU_DEBUFF
[1114] = true; -- AB_RUNEB_CORRUPTION
[1115] = true; -- AB_ANEMIA
[1116] = true; -- AB_BLOOD_DISEASE
[1117] = true; -- AB_SKILL_USE_DELAY
[1118] = true; -- AB_STAT_LOSS
[1119] = true; -- AB_HEAT_OF_BATTLE
[1120] = true; -- AB_CRIMINAL
[1121] = true; -- AB_ARMOR_PIERCE
[1122] = true; -- AB_SPLINTERING
[1123] = true; -- AB_SWING_SPEED_DEBUFF
[1125] = true; -- AB_HONORABLE_EXEC_DEBUFF
[1164] = true; -- AB_PLAYING_THE_ODDS

-- super slayer debuffs
[15060] = true; -- arachnid
[15061] = true; -- demon
[15062] = true; -- elemental
[15063] = true; -- undead
[15064] = true; -- fey
[15065] = true; -- repond 
[15066] = true; -- reptile
[15067] = true; -- myrmidex
[15068] = true; -- dinosaur
[15069] = true; -- tigers
[15131] = true; -- non-eodon tribes
[15132] = true; -- non-eodon

[15121] = true; -- overweight
[15123] = true; -- falling walls
[15124] = true; -- entangled
[15125] = true; -- Stun
[15126] = true; -- Muddied
[15127] = true; -- mana taint
[15129] = true; -- Mana Divert
}
----------------------------------------------------------------
-- Functions
----------------------------------------------------------------
function BuffDebuff.Update(timePassed)
	BuffDebuff.DeltaTime = BuffDebuff.DeltaTime + timePassed
	
	if (BuffDebuff.Timers ~= nil) then
		for key, value in pairs(BuffDebuff.Timers) do
			local buffId = key
			local parent = "BuffDebuff"
			local iconName = parent.."Icon"..buffId .. "TextureIcon"
			if (type(BuffDebuff.Timers[buffId]) == "number") then
				local sec = tonumber(BuffDebuff.Timers[buffId])
				if (sec < 10 and not BuffDebuff.Fade[buffId]) then
					
					BuffDebuff.Fade[buffId] = true
					WindowStartAlphaAnimation(iconName, Window.AnimationType.LOOP, 0.1, 0.8, 0.8, false, 0, 0)
				elseif (sec >= 10) then
					BuffDebuff.Fade[buffId] = false
					WindowStopAlphaAnimation(iconName)
				end
				
			end
		end
	end
	
	if (BuffDebuff.DeltaTime >= 1) then
		for key, value in pairs(BuffDebuff.Timers) do
			local time = value - BuffDebuff.DeltaTime
			--Debug.Print("Time passed for key ="..key.."time = "..math.ceil(time))
			if (time > 0) then
				BuffDebuff.Timers[key] = math.ceil(time)
			else
				BuffDebuff.Timers[key] = 0
				BuffDebuff.HandleBuffRemoved(key)
			end	
		end
		--Update Timer Label
		BuffDebuff.UpdateTimer(timePassed)
		--Reset delta time when it gets used to decrement the timers
		BuffDebuff.DeltaTime = 0
	end
end

function BuffDebuff.retrieveBuffData( buffData )
	if not buffData then
		Debug.PrintToDebugConsole( L"ERROR: buffData does not exist." )
		return false
	end      

	if (WindowData.BuffDebuffSystem.CurrentBuffId == 0) then
		return false
	end
	
	local buffId = WindowData.BuffDebuffSystem.CurrentBuffId
	
	buffData.abilityId = WindowData.BuffDebuffSystem.CurrentBuffId
	buffData.TimerSeconds = WindowData.BuffDebuff.TimerSeconds + 1
	buffData.HasTimer = WindowData.BuffDebuff.HasTimer
	buffData.NameVectorSize = WindowData.BuffDebuff.NameVectorSize
	buffData.ToolTipVectorSize = WindowData.BuffDebuff.ToolTipVectorSize
	buffData.IsBeingRemoved = WindowData.BuffDebuff.IsBeingRemoved
	buffData.NameWStringVector = WindowData.BuffDebuff.NameWStringVector
	buffData.ToolTipWStringVector =  WindowData.BuffDebuff.ToolTipWStringVector
	
	if (BuffDebuff.Good[buffId] or BuffDebuff.Neutral[buffId]) then
		buffData.good = true
	elseif (BuffDebuff.Evil[buffId]) then
		buffData.good = false
	end
	
	return true
end

function BuffDebuff.Initialize()
	--Debug.Print("BuffDebuff.Initialize() ")
	UOBuildTableFromCSV("Data/GameData/buffdata.csv", "BuffDataCSV")
	WindowRegisterEventHandler("Root", WindowData.BuffDebuff.Event, "BuffDebuff.ShouldCreateNewBuff")
end

function BuffDebuff.ShouldCreateNewBuff()
	local buffId = WindowData.BuffDebuffSystem.CurrentBuffId
	
	if (WindowData.BuffDebuff.IsBeingRemoved == false and buffId == 1002) then
		CenterScreenText.SendCenterScreenTexture("disarmed")
		
	end
	if (WindowData.BuffDebuff.IsBeingRemoved == false and buffId == 1107) then
		CenterScreenText.SendCenterScreenTexture("webbed")
	end
	
	if (WindowData.BuffDebuff.IsBeingRemoved == false and buffId == 1108) then
		CenterScreenText.SendCenterScreenTexture("stoned")
	end
	
	if (WindowData.BuffDebuff.IsBeingRemoved == false and (buffId == 1110 or buffId == 1111 or buffId == 1122)) then
		CenterScreenText.SendCenterScreenTexture("slowed")
	end
	
	if (WindowData.BuffDebuff.IsBeingRemoved == false and buffId == 1109) then
		CenterScreenText.SendCenterScreenTexture("panic")
	end

	-- called shot
	if (WindowData.BuffDebuff.IsBeingRemoved == false and buffId == 1140 and (not HotbarSystem.CalledShotCooldown or HotbarSystem.CalledShotCooldown <= 0)) then
		HotbarSystem.CalledShotCooldown = 60
	end

	-- warcry
	if (WindowData.BuffDebuff.IsBeingRemoved == false and buffId == 1148 and (not HotbarSystem.WarcryCooldown or HotbarSystem.WarcryCooldown <= 0)) then
		HotbarSystem.WarcryCooldown = 1200 -- 20 minutes
	end

	-- playing the odds
	if (WindowData.BuffDebuff.IsBeingRemoved == false and buffId == 1164 and (not HotbarSystem.PlayingTheOddsCooldown or HotbarSystem.PlayingTheOddsCooldown <= 0)) then
		HotbarSystem.PlayingTheOddsCooldown = 90
	end
	
	-- whispering
	if (WindowData.BuffDebuff.IsBeingRemoved == false and buffId == 1159 and (not HotbarSystem.WhisperingCooldown or HotbarSystem.WhisperingCooldown <= 0)) then
		HotbarSystem.WhisperingCooldown = SpellsInfo.GetMasterySpellCooldown(743)
	end

	-- poison
	if (WindowData.BuffDebuff.IsBeingRemoved == false and buffId == 1038) then
		
		-- get the buff data
		local data = {}
		BuffDebuff.retrieveBuffData( data ) 
		
		-- get the buff duration
		local duration = data.TimerSeconds + 1

		-- get the tokens from the TID
		local tokens = GetTokensFromString(data.ToolTipWStringVector[1], 1075633)

		-- since the damage is applied every X seconds, we divide the total time by X and get how many times the damage will be applied
		time = math.ceil(duration / tonumber(tokens[2]))

		-- get the player poison resistance
		local poisonResist = tonumber(WindowData.PlayerStatus["PoisonResist"]) / 100

		-- calculate the damage per tick
		local dam = math.floor(tonumber(tokens[1]) - (tonumber(tokens[1]) * poisonResist))

		-- now we multiply the damage for the number of times and we have the total poison damage - the amount of HP regenerated during that time
		StatusWindow.PoisonDamage = { totalDamage = math.floor((dam * time)), nextTick = Interface.TimeSinceLogin, tick = tonumber(tokens[2]), damagePerTick = dam }

		-- force the status update
		StatusWindow.UpdateStatus()
	end

	-- mortal strike
	if (WindowData.BuffDebuff.IsBeingRemoved == false and buffId == 1027) then

		-- force the status update
		StatusWindow.UpdateStatus()
	end

	--If we have a buff debuff icon up, check to see if that is being removed
	--Debug.Print("BuffDebuf event triggered")
--	Debug.Print(buffId)
	local buffData = {}
	if (BuffDebuff.retrieveBuffData( buffData )) then		
		BuffDebuff.BuffData[buffId] = buffData		
		if (WindowData.BuffDebuff.IsBeingRemoved == true) then
			--Debug.Print("BuffDebuf getting destroyed"..buffId)
			if (BuffDebuff.BuffWindowId[buffId] == true) then
				
				if (buffId == 1038) then --poison
					StatusWindow.PoisonDamage = nil
					
					-- force the status update
					StatusWindow.UpdateStatus()
				end

				if (buffId == 1027) then --mortal strike
					
					-- force the status update
					StatusWindow.UpdateStatus()
				end

				if (buffId == 1043) then --1043 Curse
					if (BuffDebuff.ReverseOrder[1040] ~= nil) then --Clumsy
						BuffDebuff.HandleBuffRemoved(1040)
					end
					if (BuffDebuff.ReverseOrder[1041] ~= nil) then --Feeblemind
						BuffDebuff.HandleBuffRemoved(1041)
					end
					if (BuffDebuff.ReverseOrder[1042] ~= nil) then --Weaken
						BuffDebuff.HandleBuffRemoved(1042)
					end
				end
				BuffDebuff.HandleBuffRemoved(buffId)
			end
		else		
			if buffId >= 10000 then
				BuffDebuff.CreateNewBuff()
			else
				local textureId = -1
				local rowServerNum = CSVUtilities.getRowIdWithColumnValue(WindowData.BuffDataCSV, "ServerId", buffId)
				if (rowServerNum ~= nil and WindowData.BuffDataCSV ~= nil and WindowData.BuffDataCSV[rowServerNum] ~= nil and WindowData.BuffDataCSV[rowServerNum].IconId ~= nil) then
					textureId = tonumber(WindowData.BuffDataCSV[rowServerNum].IconId)
					--Debug.Print("Trying to get the icon "..WindowData.BuffDataCSV[rowServerNum].IconId)
				end
				if (textureId ~= nil and textureId ~= -1) then
					--Debug.Print("BuffDebuff.CreateNewBuff()")					
					BuffDebuff.CreateNewBuff()
				else
					--Debug.Print("BuffDebuff.CreateNewBuff() failed: "..tostring(textureId))
					BuffDebuff.BuffData[buffId] = nil
				end
			end
		end		
	else
		--Debug.Print("BuffDebuff.retrieveBuffData failed")
	end
end

function BuffDebuff.HandleBuffRemoved(buffId)
	if not IsValidID(buffId) then
		return
	end

	local iconName = "BuffDebuffIcon"..buffId
	 
	if (BuffDebuff.BuffData[buffId].good) then
		local position = AdvancedBuff.ReverseOrderGood[buffId]

		table.remove(AdvancedBuff.TableOrderGood, position)

		AdvancedBuff.HandleReAnchorBuffGood(1)
	else
		local position = AdvancedBuff.ReverseOrderEvil[buffId]
		table.remove(AdvancedBuff.TableOrderEvil, position)
		AdvancedBuff.HandleReAnchorBuffEvil(1)
	end
	
	if (buffId == 1094) then
		HotbarSystem.EvasionCooldown = 20
	end
	if (buffId == 1021) then
		HotbarSystem.AttunementCooldown = 120
	end
	if (buffId == 1024) then
		HotbarSystem.EtherealVoyageCooldown = 300
	end
	
	if (buffId > 15000 and buffId < 15010) then -- custom buffs
		PlaySound(1, 1136, WindowData.PlayerLocation.x, WindowData.PlayerLocation.y, WindowData.PlayerLocation.z)
	end

	-- Have to set this to nil since the buffId is removed from the table
	BuffDebuff.ReverseOrder[buffId] = nil
	BuffDebuff.BuffWindowId[buffId] = false
	BuffDebuff.BuffData[buffId] = nil
	BuffDebuff.Timers[buffId] = nil
	BuffDebuff.ActiveBuffs[buffId] = nil
	
	DestroyWindow(iconName)
	if BuffDebuff.MouseOverFlag then
		BuffDebuff.MouseOverEnd()
	end
end

function BuffDebuff.UpdateTimer(timePassed)
	local endNumber = #AdvancedBuff.TableOrderGood
	for i=1, endNumber do
		local buffId = AdvancedBuff.TableOrderGood[i]
		local parent = "BuffDebuff"
		local iconName = parent.."Icon"..buffId
		local timer = L" "

		if (BuffDebuff.Timers[buffId] ~= nil and BuffDebuff.Timers[buffId] > 0 ) then
			timer = StringUtils.CountDownSeconds(BuffDebuff.Timers[buffId])
		end
		LabelSetText(iconName.."TimerLabel",timer)	
		WindowSetScale(iconName, WindowGetScale( AdvancedBuff.WindowNameGood ))
	end	
	endNumber = #AdvancedBuff.TableOrderEvil
	for i=1, endNumber do
		local buffId = AdvancedBuff.TableOrderEvil[i]
		local parent = "BuffDebuff"
		local iconName = parent.."Icon"..buffId
		local timer = L" "

		if (BuffDebuff.Timers[buffId] ~= nil and BuffDebuff.Timers[buffId] > 0 ) then
			timer = StringUtils.CountDownSeconds(BuffDebuff.Timers[buffId])
		end
		if (buffId == 1070 or buffId == 1071 or buffId == 1072 or buffId == 1073) then

			timer = BuffDebuff.BuffData[buffId].ToolTipWStringVector[1]

			if IsValidWString(timer) and wstring.find(timer, L":", -7, true) then
				timer = wstring.sub(timer, wstring.find(timer, L":", -7, true)+2)
			end
			
		end
		LabelSetText(iconName.."TimerLabel",timer)
		WindowSetScale(iconName, WindowGetScale( AdvancedBuff.WindowNameEvil )	)
	end		
			
end

function BuffDebuff.CreateNewBuff()
	local BloodOath = false
	local buffId = WindowData.BuffDebuffSystem.CurrentBuffId
	--Debug.Print("In Create New buff() id = "..buffId)
	local buffData = BuffDebuff.BuffData[buffId]
	
	if not DoesWindowExist("CircleEffect_a") then

		CreateWindowFromTemplate("CircleEffect_a", "CursorWarningEffect", "Root")
		
		WindowSetShowing("CircleEffect_a", false)
		WindowClearAnchors("CircleEffect_a")
		
	end

	if (not WindowGetShowing("CircleEffect_a") and not BuffDebuff.ActiveBuffs[buffId]) then
		WindowSetShowing("CircleEffect_a", true)
		WindowClearAnchors("CircleEffect_a")
		
		if BuffDebuff.Good[buffId] then
			WindowSetTintColor("CircleEffect_a", 0, 255, 0)
			WindowSetScale("CircleEffect_a", WindowGetScale(AdvancedBuff.WindowNameGood))
			WindowAddAnchor("CircleEffect_a", "center", AdvancedBuff.WindowNameGood .. "Context", "center", 0, 0)
		elseif BuffDebuff.Neutral[buffId] then
			WindowSetTintColor("CircleEffect_a", 0, 204, 255)
			WindowSetScale("CircleEffect_a", WindowGetScale(AdvancedBuff.WindowNameGood))
			WindowAddAnchor("CircleEffect_a", "center", AdvancedBuff.WindowNameGood .. "Context", "center", 0, 0)
		elseif BuffDebuff.Evil[buffId] then
			WindowSetTintColor("CircleEffect_a", 255, 0, 0)
			WindowSetScale("CircleEffect_a", WindowGetScale(AdvancedBuff.WindowNameEvil))
			WindowAddAnchor("CircleEffect_a", "center", AdvancedBuff.WindowNameEvil .. "Context", "center", 0, 0)
		end
		AnimatedImageStartAnimation( "CircleEffect_a", 1, false, true, 0.0 )
	end
	
	BuffDebuff.ActiveBuffs[buffId] = true
	if (BuffDebuff.BuffWindowId[buffId] ~= true) then
		-- Need to know the ordering so we can anchor the buffs correctly 
		local parent = "BuffDebuff"
		local iconName = parent.."Icon"..buffId

		if (BuffDebuff.BuffData[buffId].good) then
			table.insert(AdvancedBuff.TableOrderGood, buffId)			
			CreateWindowFromTemplate(iconName, "BuffDebuffTemplate", "Root")
		else
			table.insert(AdvancedBuff.TableOrderEvil, buffId)
			CreateWindowFromTemplate(iconName, "BuffDebuffTemplate", "Root")
			
		end
		table.insert(BuffDebuff.TableOrder, buffId) 
	
		local scale = 1
		if (BuffDebuff.BuffData[buffId].good) then
			scale = WindowGetScale( AdvancedBuff.WindowNameGood )
		else
			scale = WindowGetScale( AdvancedBuff.WindowNameEvil )
		end
		WindowSetScale(iconName, scale)

		WindowSetId(iconName, buffId)


		if (BuffDebuff.BuffData[buffId].good) then
			numIcons = #AdvancedBuff.TableOrderGood
			AdvancedBuff.ReverseOrderGood[buffId] = numIcons
			AdvancedBuff.HandleReAnchorBuffGood(numIcons)
		else
			numIcons = #AdvancedBuff.TableOrderEvil
			AdvancedBuff.ReverseOrderEvil[buffId] = numIcons
			AdvancedBuff.HandleReAnchorBuffEvil(numIcons)
		end
		 
		BuffDebuff.BuffWindowId[buffId] = true
		BuffDebuff.UpdateStatus(buffId)
	else
		BuffDebuff.UpdateStatus(buffId)
	end
	
	if (buffId == 1015) then
		CenterScreenText.SendCenterScreenTexture("bloodoath")
		if (WindowData.PlayerStatus.InWarMode) then
			BloodOath = true
		end
	end
	if (buffId == 1017) then
		if (not BuffDebuff.BuffData[1017].HasTimer and Interface.started) then
			CenterScreenText.SendCenterScreenTexture("panic")
		end
	end
	
	if (buffData.HasTimer == true) then
		BuffDebuff.Timers[buffId] = buffData.TimerSeconds
		if buffId == 1069 or buffId == 1101 then
			HotbarSystem.BandageDelayTime = tonumber(BuffDebuff.Timers[buffId])
		end
	end
	
	-- AUTO-REMOVE War Mode if blood oath and restore war mode on invisibility.
	if (Interface.Settings.ToggleBloodOath) then
		if (BloodOath) then
			UserActionToggleWarMode()
		else
			if (Interface.WarModeBackup and IsPlayerInvisible()) then
				Interface.WarModeBackup  = nil
				UserActionToggleWarMode()
			end
		end	
	end
	
	BuffDebuff.UpdateTimer()
end

function BuffDebuff.ResizeOuterWindow(windowName, numIcons)
	local numRows = math.ceil(numIcons / (BuffDebuff.MaxLength))
	local width = BuffDebuff.IconSize * BuffDebuff.MaxLength
	if (numIcons < BuffDebuff.MaxLength) then
		width = BuffDebuff.IconSize * numIcons
	end
	
	local height = BuffDebuff.IconSize * (numRows)
	
	if (numIcons > 0) then
		WindowSetDimensions(windowName, width, height)
	else
		WindowSetDimensions(windowName, 0 , 0)
	end
end

function BuffDebuff.MouseOverEnd()
	BuffDebuff.MouseOverFlag = false
	ItemProperties.ClearMouseOverItem()
end

function BuffDebuff.MouseOver()
	local buffId = WindowGetId(SystemData.ActiveWindow.name)
	local data = BuffDebuff.BuffData[buffId]
	if (data) then
		local nameString = L""
		for i = 1, data.NameVectorSize do
			nameString = nameString..data.NameWStringVector[i]
		end
		
		local tooltipString = L""
		for i = 1, data.ToolTipVectorSize do
			tooltipString = tooltipString .. (data.ToolTipWStringVector[i] or  L"")
		end	

		
		local bodyText = WindowUtils.translateMarkup(tooltipString)
		
		if (data.HasTimer == true and BuffDebuff.Timers[buffId] > 0) then
			local timeText = ReplaceTokens(GetStringFromTid(BuffDebuff.TID.timeleft), { towstring(tostring(BuffDebuff.Timers[buffId])) }) 
			bodyText = bodyText..L"\n"..timeText
		end
		
		local itemData = { windowName = "BuffDebuffIcon"..buffId,
							itemId = buffId,
							itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
							binding = L"",
							detail = nil,
							title =	WindowUtils.translateMarkup(nameString),
							body = bodyText	 }
							
		ItemProperties.SetActiveItem(itemData)	
		BuffDebuff.MouseOverFlag = true
		--Debug.Print("BuffDebuff UpdateStatus labelName = "..tostring( WindowUtils.translateMarkup(nameString)))
		--Debug.Print("BuffDebuff UpdateStatus tooltipName = "..tostring( WindowUtils.translateMarkup(tooltipString)) )
	end
end

function BuffDebuff.Shutdown()
	
	UOUnloadCSVTable("BuffDataCSV")
end

function BuffDebuff.UpdateStatus(iconId)
	local buffId = iconId
	
	local parent = "BuffDebuffIcon"..buffId
	local iconTextureName = parent.."TextureIcon"
	
	if (buffId >= 15000) then -- UI BUFFS
		local icon = 843000 + buffId
		
		local texture, x, y = GetIconData( icon )
		DynamicImageSetTexture( iconTextureName, texture, x, y )
	elseif (textureId ~= nil or textureId ~= -1) then
		--Debug.Print("BuffDebuff buffId = "..buffId)
		local rowServerNum = CSVUtilities.getRowIdWithColumnValue(WindowData.BuffDataCSV, "ServerId", buffId)
		local textureId = tonumber(WindowData.BuffDataCSV[rowServerNum].IconId)
		
		--Debug.Print("BuffDebuff UpdateStatus textureId = "..textureId)
		local texture, x, y = GetIconData( textureId )
		DynamicImageSetTexture( iconTextureName, texture, x, y )
	end
end
