
AbilitiesInfo = {}

AbilitiesInfo.DisabledReason = {}
AbilitiesInfo.DisabledReason.LOW_MANA = 1
AbilitiesInfo.DisabledReason.CANT_USE_WHILE_RIDING = 2
AbilitiesInfo.DisabledReason.CAN_USE_ONLY_WHILE_RIDING = 3
AbilitiesInfo.DisabledReason.PLAYER_DEAD = 4
AbilitiesInfo.DisabledReason.PLAYER_IS_CASTING = 5
AbilitiesInfo.DisabledReason.LACK_REQUIREMENTS = 6
AbilitiesInfo.DisabledReason.PLAYER_PARALYZED = 7

AbilitiesInfo.DisabledReasonTID = 
{
	[AbilitiesInfo.DisabledReason.LOW_MANA] = 1060181,
	[AbilitiesInfo.DisabledReason.CAN_USE_ONLY_WHILE_RIDING] = 1070770,
	[AbilitiesInfo.DisabledReason.CANT_USE_WHILE_RIDING] = 1061283,
	[AbilitiesInfo.DisabledReason.PLAYER_DEAD] = 1060169,
	[AbilitiesInfo.DisabledReason.PLAYER_IS_CASTING] = 502165,
	[AbilitiesInfo.DisabledReason.PLAYER_PARALYZED] = 1060170,
	[AbilitiesInfo.DisabledReason.LACK_REQUIREMENTS] = 1049536,
}

AbilitiesInfo.Data = 
{
	[1] = { name = "Armor Ignore", Mana = 30 };
	[2] = { name = "Bleed Attack", Mana = 30 };
	[3] = { name = "Concussion Blow", Mana = 20 };
	[4] = { name = "Crushing Blow", Mana = 20 };
	[5] = { name = "Disarm", Mana = 20 };
	[6] = { name = "Dismount", Mana = 20 };
	[7] = { name = "Double Strike", Mana = 30 };
	[8] = { name = "Infectious Strike", Mana = 20 };
	[9] = { name = "Mortal Strike", Mana = 30 };
	[10] = { name = "Moving Shot", Mana = 20 };
	[11] = { name = "Paralyzing Blow", Mana = 30 };
	[12] = { name = "Shadow Strike", Mana = 20, noTactics = true, };
	[13] = { name = "Whirlwind Attack", Mana = 15 };
	[14] = { name = "Riding Swipe", Mana = 25 };
	[15] = { name = "Frenzied Whirlwind", Mana = 20 };
	[16] = { name = "Block", Mana = 20 };
	[17] = { name = "Defense Mastery", Mana = 20 };
	[18] = { name = "Nerve Strike", Mana = 30 };
	[19] = { name = "Talon Strike", Mana = 20 };
	[20] = { name = "Feint", Mana = 30 };
	[21] = { name = "Dual Wield", Mana = 20 };
	[22] = { name = "Double Shot", Mana = 35 };
	[23] = { name = "Armor Pierce", Mana = 30 };
	[24] = { name = "Bladeweave", Mana = 15 };
	[25] = { name = "Force Arrow", Mana = 20 };
	[26] = { name = "Lightning Arrow", Mana = 15 };
	[27] = { name = "Psychic Attack", Mana = 25 };
	[28] = { name = "Serpent Arrow", Mana = 25 };
	[29] = { name = "Force of Nature", Mana = 35 };
	[30] = { name = "Infused Throw", Mana = 25 };
	[31] = { name = "Mystic Arc", Mana = 20 };
}

AbilitiesInfo.MessageToID = 
{
	[1060077] = 1; -- The blow penetrated your armor!
	[1060160] = 2; -- You are bleeding!
	[1060166] = 3; -- You feel disoriented!
	[1060091] = 4; --You take extra damage from the crushing attack!
	[1060093] = 5; -- Your weapon has been disarmed!
	[1060083] = 6; -- You fall off of your mount and take damage!
	[1060085] = 7; -- Your attacker strikes with lightning speed! 
	[1060081] = 8; -- The poison seems extra effective!
	[1060087] = 9; -- You have been mortally wounded!
	-- NO MOVING SHOT
	[1060164] = 11; -- The attack has temporarily paralyzed you!
	[1060079] = 12; -- You are dazed by the attack and your attacker vanishes!
	[1060162] = 13; -- You are struck by the whirling attack and take damage!
	-- NO RIDING SWIPE
	-- NO FRENZIED WHIRLWIND
	[1063346] = 16; -- Your attack was blocked!
	-- NO DEFENSE MASTERY
	[1063357] = 18; -- Your attacker dealt a crippling nerve strike!
	[1063359] = 19; -- Your attacker delivers a talon strike!
	[1063361] = 20; -- You were deceived by an attacker's feint!
	--NO DUAL WIELD
	[1063349] = 22; -- You're attacked with a barrage of shots!
	[1063351] = 23; -- Your attacker pierced your armor!
	-- NO BLADEWEAVE
	[1074382] = 25; -- You are struck by a force arrow!
	-- NO LIGTNING ARROW
	[1074384] = 27; -- Your mind is attacked by psychic force!
	-- NO SERPENT ARROW
	[1074375] = 29; -- You are assaulted with great force!
	[1149564] = 30; -- You are struck by the infused projectile and take damage!
	[1149566] = 31; -- You take extra damage from the mystic arc!
}

function AbilitiesInfo.isPrimary(abilityId) 
	return abilityId == EquipmentData.CurrentWeaponAbilities[1]
end

function AbilitiesInfo.RequiresBushido(abilityId) 
	return (abilityId == 18 or abilityId == 14)
end

function AbilitiesInfo.RequiresNinjitsu(abilityId) 
	return (abilityId == 21 or abilityId == 19)
end

function AbilitiesInfo.RequiresBushidoOrNinjitsu(abilityId) 
	return (abilityId == 23 or abilityId == 16 or abilityId == 17 or abilityId == 22 or abilityId == 15)
end

function AbilitiesInfo.RequiresStealth(abilityId) 
	return (abilityId == 12)
end

function AbilitiesInfo.CanUse(abilityId) 

	if not abilityId then
		return
	end

	-- do we have the data for this ability?
	if not AbilitiesInfo.Data[abilityId] then
		return
	end

	-- get the ability data
	local abilityData = AbilitiesInfo.Data[abilityId]

	local sworSkillLevel = GetSkillValue(SkillsWindow.SkillsID.SWORDSMANSHIP, true)
	
	local maceSkillLevel = GetSkillValue(SkillsWindow.SkillsID.MACE_FIGHTING, true)
	
	local fenceSkillLevel = GetSkillValue(SkillsWindow.SkillsID.FENCING, true)
	
	local archSkillLevel = GetSkillValue(SkillsWindow.SkillsID.ARCHERY, true)
	
	local throSkillLevel = GetSkillValue(SkillsWindow.SkillsID.THROWING, true)
	
	local wresSkillLevel = GetSkillValue(SkillsWindow.SkillsID.WRESTLING, true)
	
	local tactSkillLevel = GetSkillValue(SkillsWindow.SkillsID.TACTICS, true)
	
	local bushSkillLevel = GetSkillValue(SkillsWindow.SkillsID.BUSHIDO, true)
	
	local ninjSkillLevel = GetSkillValue(SkillsWindow.SkillsID.NINJITSU, true)

	local steaSkillLevel = GetSkillValue(SkillsWindow.SkillsID.STEALTH, true)
	
	local propMhand = AbilitiesInfo.propMhand
	local propOhand = AbilitiesInfo.propOhand

	if PaperdollWindow.GotDamage == true or (not AbilitiesInfo.propMhand and AbilitiesInfo.propOhand) then
		propMhand = ItemProperties.GetObjectPropertiesTid( PaperdollWindow.GetPaperdollSlotID(GetPlayerID(), 4), nil, "Abilities Info - check main hand" )
		propOhand = ItemProperties.GetObjectPropertiesTid( PaperdollWindow.GetPaperdollSlotID(GetPlayerID(), 10), nil, "Abilities Info - check off-hand" )
		AbilitiesInfo.propMhand = propMhand
		AbilitiesInfo.propOhand = propOhand
	end

	local wrest = not propMhand and not propOhand
	if propOhand then
		local oHand = PaperdollWindow.GetPaperdollSlotID(GetPlayerID(), 10)

		local itemData = Interface.GetObjectInfoData(oHand)
		
		local oHandType = ItemPropertiesInfo.GetGumpTypeByItemData(oHand, itemData)
		local found = false
		for i = 1, #propOhand do
			if propOhand[i] == 1061168 then -- weapon damage ~1_val~ - ~2_val~
				found = true
				break
			end
		end
		if not found then
			oHandType = ItemPropertiesInfo.Types.NoDamageWeapon
		end
		if (oHandType ~= ItemPropertiesInfo.Types.Weapon and oHandType ~= ItemPropertiesInfo.Types.Ranged_Weapon) then
			wrest = true
		end
	elseif propMhand then
		local oHand = PaperdollWindow.GetPaperdollSlotID(GetPlayerID(), 4)

		local itemData = Interface.GetObjectInfoData(oHand)
		
		local oHandType = ItemPropertiesInfo.GetGumpTypeByItemData(oHand, itemData)
		local found = false
		for i = 1, #propMhand do
			if propMhand[i] == 1061168 then -- weapon damage ~1_val~ - ~2_val~
				found = true
				break
			end
		end
		if not found then
			oHandType = ItemPropertiesInfo.Types.NoDamageWeapon
		end
		if (oHandType ~= ItemPropertiesInfo.Types.Weapon and oHandType ~= ItemPropertiesInfo.Types.Ranged_Weapon) then
			wrest = true
		end
	end
	
	local tactReq = 30
	local mainReq = 70
	if not AbilitiesInfo.isPrimary(abilityId) then
		mainReq = 90
		tactReq = 60
	end

	if not abilityData.noTactics and tactSkillLevel < tactReq and not wrest then
		return false
	end
	
	if AbilitiesInfo.RequiresBushidoOrNinjitsu(abilityId) then
		if bushSkillLevel < 50 and ninjSkillLevel < 50 then
			return false
		end
	elseif AbilitiesInfo.RequiresBushido(abilityId) then
		if bushSkillLevel < 50 then
			return false
		end
	elseif AbilitiesInfo.RequiresNinjitsu(abilityId)  then
		if ninjSkillLevel < 50 then
			return false
		end
	end

	if AbilitiesInfo.RequiresStealth(abilityId) and steaSkillLevel < 80 then
		return false
	end

	local ubws = false
	if (propMhand) then
		for i = 1, #propMhand do
			if propMhand[i] == 1060400 then -- ubws
				ubws = true
				break
			end
		end
		if ubws then
			if fenceSkillLevel < mainReq and sworSkillLevel < mainReq and maceSkillLevel < mainReq then
				return false
			end
		else		
			for i = 1, #propMhand do
				local lprop = wstring.lower(propMhand[i])
				if propMhand[i] == 1112075 then -- throwing
					if throSkillLevel < mainReq then
						return false
					end
				elseif propMhand[i] == 1061172 then -- swords
					if sworSkillLevel < mainReq then
						return false
					end
				elseif propMhand[i] == 1061173 then -- mace
					if maceSkillLevel < mainReq then
						return false
					end
				elseif propMhand[i] == 1061174 then -- fencing
					if fenceSkillLevel < mainReq then
						return false
					end
				elseif propMhand[i] == 1061175 then -- arcery
					if archSkillLevel < mainReq then
						return false
					end
				end
			end
		end
	elseif (propOhand and not wrest) then
		for i = 1, #propOhand do
			if propOhand[i] == 1060400 then -- ubws
				ubws = true
				break
			end
		end
		if ubws then
			if fenceSkillLevel < mainReq and sworSkillLevel < mainReq and maceSkillLevel < mainReq then
				return false
			end
		else	
			for i = 1, #propOhand do
				if propOhand[i] == 1112075 then -- throwing
					if throSkillLevel < mainReq then
						return false
					end
				elseif propOhand[i] == 1061172 then -- swords
					if sworSkillLevel < mainReq then
						return false
					end
				elseif propOhand[i] == 1061173 then -- mace
					if maceSkillLevel < mainReq then
						return false
					end
				elseif propOhand[i] == 1061174 then -- fencing
					if fenceSkillLevel < mainReq then
						return false
					end
				elseif propOhand[i] == 1061175 then -- arcery
					if archSkillLevel < mainReq then
						return false
					end
				elseif propOhand[i] == 1060400 then -- ubws
					if fenceSkillLevel < mainReq and sworSkillLevel < mainReq and maceSkillLevel < mainReq then
						return false
					end
				end
			end
		end
	elseif wrest then
		if wresSkillLevel < mainReq then
			return false
		end
	end
	
	return true
end 

function AbilitiesInfo.GetManaCost(abilityId) 
	--[[
	The Mana Cost of each special move can be reduced if the warrior's skills are high enough. 
	Add up the skill points for Swords, Mace Fighting, Fencing, Archery, Parrying, Lumberjacking, Stealth, Poisoning, Bushido and Ninjitsu. 
	If the total lies between 200 and 299, subtract 5 from the Mana Cost. If the total is 300 or more, subtract 10 from the Mana Cost.
	+ item LMC
	If a special move is attempted performed within 3 seconds after another special move, the mana cost of that move will be doubled.
	--]]
	if not IsValidID(abilityId) then
		return
	end

	if not AbilitiesInfo.Data[abilityId] then
		return
	end
	
	local manaCost = AbilitiesInfo.Data[abilityId].Mana
	
	
	local lmcItems = tonumber(WindowData.PlayerStatus["LowerManaCost"]) or 0
	
	local sworSkillLevel = GetSkillValue(SkillsWindow.SkillsID.SWORDSMANSHIP, true)
	
	local maceSkillLevel = GetSkillValue(SkillsWindow.SkillsID.MACE_FIGHTING, true)
	
	local fenceSkillLevel = GetSkillValue(SkillsWindow.SkillsID.FENCING, true)
	
	local archSkillLevel = GetSkillValue(SkillsWindow.SkillsID.ARCHERY, true)
	
	local throSkillLevel = GetSkillValue(SkillsWindow.SkillsID.THROWING, true)
	
	local wresSkillLevel = GetSkillValue(SkillsWindow.SkillsID.WRESTLING, true)
	
	local tactSkillLevel = GetSkillValue(SkillsWindow.SkillsID.TACTICS, true)
	
	local bushSkillLevel = GetSkillValue(SkillsWindow.SkillsID.BUSHIDO, true)
	
	local ninjSkillLevel = GetSkillValue(SkillsWindow.SkillsID.NINJITSU, true)

	local parrSkillLevel = GetSkillValue(SkillsWindow.SkillsID.PARRYING, true)

	local lumbSkillLevel = GetSkillValue(SkillsWindow.SkillsID.LUMBERJACKING, true)

	local steaSkillLevel = GetSkillValue(SkillsWindow.SkillsID.STEALTH, true)

	local poisSkillLevel = GetSkillValue(SkillsWindow.SkillsID.POISONING, true)
	
	local total = sworSkillLevel + maceSkillLevel + fenceSkillLevel + archSkillLevel + parrSkillLevel + lumbSkillLevel + steaSkillLevel + poisSkillLevel + bushSkillLevel + ninjSkillLevel + throSkillLevel
	if total >= 200 and total <300 then
		lmcItems = lmcItems + 5
	elseif total > 300 then
		lmcItems = lmcItems + 10
	end
	lmcItems = lmcItems / 100
	if Interface.LastSpecialMoveTime > 0 then
		manaCost = manaCost * 2
	end
	return math.ceil(manaCost - math.floor(manaCost * lmcItems))
end

function AbilitiesInfo.DoesPlayerHaveALance() 

	-- getting the main hand item id
	local mhandId = PaperdollWindow.GetPaperdollSlotID(GetPlayerID(), 4)

	-- does the player have a weapon in the main hand?
	if IsValidID(mhandId) then
		
		-- getting the item type
		local objType = GetItemType(mhandId)

		-- is the item a lance?
		if objType == 18634 or objType == 18635 or objType == 9920 or objType == 9930 then
			return true
		end
	end

	return false
end

function AbilitiesInfo.AbilityEnabled(id) 
	
	-- is the ability ID valid?
	if not IsValidID(id) then
		return false
	end

	-- getting the mana cost
	local mana = AbilitiesInfo.GetManaCost(id)

	-- mana phase buff set mana cost to 0
	if BuffDebuff.ActiveBuffs[1104] then
		mana = 0
	end

	-- does the player have a lance?
	local lance = AbilitiesInfo.DoesPlayerHaveALance() 

	-- Your skill is not up to that task.
	if not AbilitiesInfo.CanUse(EquipmentData.GetWeaponAbilityId(id)) then
		return false, AbilitiesInfo.DisabledReason.LACK_REQUIREMENTS

	-- You cannot use this ability while dead.
	elseif Interface.IsPlayerDead then
		return false, AbilitiesInfo.DisabledReason.PLAYER_DEAD

	-- player have not enough mana
	elseif mana and WindowData.PlayerStatus and tonumber(WindowData.PlayerStatus["CurrentMana"]) and tonumber(WindowData.PlayerStatus["CurrentMana"]) < mana then
		return false, AbilitiesInfo.DisabledReason.LOW_MANA, mana

	-- DOUBLE SHOT: You can only execute this attack while mounted or flying!
	elseif (EquipmentData.GetWeaponAbilityId(id) == 22 ) and not (BuffDebuff.ActiveBuffs[1054] or IsRiding()) then
		return false, AbilitiesInfo.DisabledReason.CAN_USE_ONLY_WHILE_RIDING

	-- DISMOUNT: You cannot perform that attack while mounted or flying!
	elseif (EquipmentData.GetWeaponAbilityId(id) == 6 ) and (BuffDebuff.ActiveBuffs[1054] or IsRiding()) and not lance then
		return false, AbilitiesInfo.DisabledReason.CANT_USE_WHILE_RIDING

	-- You are already casting that spell.
	elseif Interface.CurrentSpell.casting and Interface.Settings.DisableButtonsWhileCast then
		return false, AbilitiesInfo.DisabledReason.PLAYER_IS_CASTING

	-- You cannot use this ability while frozen.
	elseif IsPlayerParalyzed() then
		return false, AbilitiesInfo.DisabledReason.PLAYER_PARALYZED
	end
	
	return true
end
