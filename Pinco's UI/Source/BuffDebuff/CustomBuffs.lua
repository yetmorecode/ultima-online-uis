----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

CustomBuffs = {}

CustomBuffs.StunTime = 0
CustomBuffs.MudTime = 0
CustomBuffs.ManaTaintTime = 0
CustomBuffs.ManaDivertTime = 0

CustomBuffs.Type = {}
CustomBuffs.Type.BodyDecay = 8
CustomBuffs.Type.HonorActive = 14
 
CustomBuffs.ManaTaintTime = 0
CustomBuffs.ManaDivertTime = 0
CustomBuffs.MudTime = 0
CustomBuffs.FallingWallsTime = 0
CustomBuffs.StunTime = 0
CustomBuffs.BerserkRage = false
CustomBuffs.Entangle = false
CustomBuffs.HonorActive = false
 
CustomBuffs.WeightBlink = false

----------------------------------------------------------------
-- CustomBuffs Functions
----------------------------------------------------------------

function CustomBuffs.Create(id, name, description, cooldown, custom)

	-- do we have a valid ID?
	if not IsValidID(id) then
		return
	end

	-- do we have a valid name?
	if not IsValidWString(name) then
		return
	end

	-- do we have the description?
	if not IsValidWString(description) then

		-- set the description as empty by default
		description = L""
	end

	-- is the buff already active and there is no cooldown specified?
	if BuffDebuff.ActiveBuffs[id] and not cooldown then
		return
	end
	
	-- initialize the buff ID
	WindowData.BuffDebuffSystem.CurrentBuffId = inlineIf(custom, 15000 + id, id)

	-- do we have a cooldown?
	if cooldown and cooldown > 0 then

		-- set the cooldown duration
		WindowData.BuffDebuff.TimerSeconds = cooldown

		-- flag that the buff has a timer
		WindowData.BuffDebuff.HasTimer = true

	else -- no cooldown
		
		-- set the timer to 0
		WindowData.BuffDebuff.TimerSeconds = 0

		-- flag that the buff has no timer
		WindowData.BuffDebuff.HasTimer = false
	end

	-- set the number of names
	WindowData.BuffDebuff.NameVectorSize = 1

	-- set the number of tooltips
	WindowData.BuffDebuff.ToolTipVectorSize = 1

	-- flag that is NOT being removed
	WindowData.BuffDebuff.IsBeingRemoved = false

	-- set the buff name
	WindowData.BuffDebuff.NameWStringVector = { [1] = name }

	-- set the description for the buff
	WindowData.BuffDebuff.ToolTipWStringVector = { [1] = description }

	-- create the buff
	BuffDebuff.ShouldCreateNewBuff()
end

function CustomBuffs.Remove(id, custom)

	-- do we have a valid ID?
	if not IsValidID(id) then
		return
	end

	-- get the real ID of the buff (based on the fact that is a custom buff or not)
	local realId = inlineIf(custom, 15000 + id, id)

	-- does the buff exist?
	if not BuffDebuff.ActiveBuffs[realId] then
		return
	end

	-- set the buff ID
	WindowData.BuffDebuffSystem.CurrentBuffId = realId

	-- mark the buff for removal
	WindowData.BuffDebuff.IsBeingRemoved = true

	-- remove the buff
	BuffDebuff.ShouldCreateNewBuff()	
end

CustomBuffs.BoatDirectionLastFix = 0
function CustomBuffs.BuffManager(timePassed)

	-- has the interface started?
	if not Interface.started then
		return
	end

	-- handle the mount related buffs
	pcall(CustomBuffs.MountBuffs)

	-- handle the overweight buff
	pcall(CustomBuffs.OverweightBuff)
	
	-- handle the skill delay buff
	pcall(CustomBuffs.SkillDelayBuff)
	
	-- handle the honor virtue buff
	pcall(CustomBuffs.HonorBuff)

	-- handle the mana taint buff
	pcall(CustomBuffs.ManaTaintBuff)
	
	-- handle the mana divert buff
	pcall(CustomBuffs.ManaDivertBuff)
	
	-- handle the muddied buff
	pcall(CustomBuffs.MuddiedBuff)
	
	-- handle the falling walls buff
	pcall(CustomBuffs.FallingWallsBuff)
	
	-- handle the stun buff
	pcall(CustomBuffs.StunBuff)
	
	-- handle the berserk buff
	pcall(CustomBuffs.BerserkBuff)
	
	-- handle the entangle buff
	pcall(CustomBuffs.EntangleBuff)
end

function CustomBuffs.MountBuffs()

	-- determine if we are riding and the mount ID
	local ride = IsRiding()

	-- is the player riding?
	if not ride then

		-- flag that we are not piloting a ship
		Interface.IsPilotingAShip = false

		-- remove the riding buff
		CustomBuffs.Remove(130, true)

		-- remove the piloting buff
		CustomBuffs.Remove(120, true)

		-- is the slow down buff active (without the timer)?
		if not BuffDebuff.Timers[1122] then

			-- remove the buff (since we don't have an overweight mount)
			CustomBuffs.Remove(1122)
		end

		return
	end
	
	-- get the mount properties
	local data = Interface.GetItemPropertiesData(ride, "checking mount data")
	local props = ItemProperties.BuildParamsArray(data, true)

	-- determine if the player is piloting a ship
	Interface.IsPilotingAShip = props and props[1036022] -- prow

	-- does the mount has the weight property?
	if props and props[1072225] then -- Weight: ~1_WEIGHT~ stones

		-- get the mount weight
		local weight = tonumber(tostring(props[1072225][1]))

		-- is the weight higher than 557?
		if weight > 557 then

			-- is the unable to run buff inactive?
			if not BuffDebuff.ActiveBuffs[1122] then 

				-- create the unable to run buff
				CustomBuffs.Create(1122, GetStringFromTid(109), GetStringFromTid(110))
			end

		else -- not heavy enough to slow the player

			-- is the slow down buff active (without the timer)?
			if not BuffDebuff.Timers[1122] then

				-- remove the buff
				CustomBuffs.Remove(1122)
			end
		end

		-- create the additional description for the riding buff for the weight
		local description = GetStringFromTid(105) .. L"\n\n" .. ReplaceTokens(GetStringFromTid(1072225), {towstring(weight) .. L"/" .. 1600})

		-- create the riding buff
		CustomBuffs.CreateRidingBuff(description)

	elseif props and props[1115719] then -- armor points: ~1_val~

		-- get the remaining armor points
		local arm = tonumber(tostring(props[1115719][1]))

		-- create the additional description for the riding buff for the armor points
		local description = GetStringFromTid(105) .. L"\n\n" .. ReplaceTokens(FormatProperly(GetStringFromTid(1115719)), {StringUtils.AddCommasToNumber(arm)})

		-- create the riding buff
		CustomBuffs.CreateRidingBuff(description)

	elseif Interface.IsPilotingAShip then -- piloting buff

		-- remove the riding buff (if present)
		CustomBuffs.Remove(120, true)

		-- is the piloting buff inactive?
		if not BuffDebuff.ActiveBuffs[15130] then 

			-- do we have a last boat direction?	
			if Interface.LastBoatDirection then

				-- create the piloting buff with the boat direction info
				CustomBuffs.Create(130, GetStringFromTid(262), ReplaceTokens(GetStringFromTid(263), { Actions.BoatDirections[Interface.LastBoatDirection].name }), 0, true)

			else -- create the plain piloting buff
				CustomBuffs.Create(130, GetStringFromTid(262), GetStringFromTid(263), 0, true)
			end

		else -- buff already active

			-- do we have a last boat direction?	
			if Interface.LastBoatDirection then

				-- update the piloting buff with the boat direction info
				BuffDebuff.BuffData[15130].ToolTipWStringVector[1] = ReplaceTokens(GetStringFromTid(263), { Actions.BoatDirections[Interface.LastBoatDirection].name })

			else -- update the plain piloting buff
				BuffDebuff.BuffData[15130].ToolTipWStringVector[1] = GetStringFromTid(263)
			end
		end

		-- is it time to fix the boat direction?
		if CustomBuffs.BoatDirectionLastFix <= Interface.TimeSinceLogin then

			-- reset the timer
			CustomBuffs.BoatDirectionLastFix = Interface.TimeSinceLogin + 1

			-- update the boat direction silently
			Actions.FixSmartBoatDirectionsStart(true)
		end
		
	else -- nothing special about the mount

		-- create a plain riding buff
		CustomBuffs.CreateRidingBuff(GetCliloc(105))
	end
end

function CustomBuffs.CreateRidingBuff(description)

	-- is the riding buff inactive?
	if not BuffDebuff.ActiveBuffs[15120] then 

		-- create the riding buff
		CustomBuffs.Create(120, GetStringFromTid(104), description, 0, true)

	else -- update the buff description
		BuffDebuff.BuffData[15120].ToolTipWStringVector[1] = description
	end
end

function CustomBuffs.OverweightBuff()

	-- is the player almost overweight?
	if WindowData.PlayerStatus.Weight > WindowData.PlayerStatus.MaxWeight - 10 then
		
		-- count how much weight the player can still hold before being overweight
		local remainings = (WindowData.PlayerStatus.MaxWeight + 3) - WindowData.PlayerStatus.Weight

		-- default overweight description
		local description = GetStringFromTid(108)

		-- do we have weight remaining?
		if remainings > 0 then

			-- create the description for the remaining weight
			description = ReplaceTokens(GetStringFromTid(107), { towstring(remainings) })
		end

		-- is the overweight buff inactive?
		if not BuffDebuff.ActiveBuffs[15121] then

			-- create the overweight buff
			CustomBuffs.Create(121, GetStringFromTid(106), description, 0, true)

		else -- only update the buff 
			BuffDebuff.BuffData[15121].ToolTipWStringVector[1] = description
		end
		
		-- buff icon window name
		local iconName = "BuffDebuffIcon15121"
			
		-- is the player completely overweight?
		if remainings <= 0 then

			-- is the overweight buff NOT blinking?
			if not CustomBuffs.WeightBlink then

				-- start the blinking animation
				WindowStartAlphaAnimation(iconName, Window.AnimationType.LOOP, 0.1, 0.8, 0.8, false, 0, 0)

				-- flag that the overweight buff is blinking
				CustomBuffs.WeightBlink = true
			end

		-- do we still have some remaining weight before overweight, and the buff is blinking?
		elseif remainings > 0 and CustomBuffs.WeightBlink then

			-- stop the blinking animation
			WindowStopAlphaAnimation(iconName)

			-- flag that the buff is not blinking
			CustomBuffs.WeightBlink = false
		end

	else -- the player is not overweight

		-- remove the overweight buff
		CustomBuffs.Remove(121, true)
	end
end

function CustomBuffs.SkillDelayBuff()

	-- are the skills in cooldown?
	if HotbarSystem.SkillDelayTime > 0 then

		-- is the skills cooldown buff inactive?
		if not BuffDebuff.ActiveBuffs[1117] then

			-- add the skills cooldown buff
			CustomBuffs.Create(1117, GetStringFromTid(109), L"", HotbarSystem.SkillDelayTime)
		end

	else -- the skills are no longer in cooldown
	
		-- remove the skills cooldown buff
		CustomBuffs.Remove(1117)
	end
end

function CustomBuffs.HonorBuff()
	
	-- is the honor virtue active?
	if CustomBuffs.HonorActive then

		-- is the honor virtue buff inactive?
		if not BuffDebuff.ActiveBuffs[15122] then

			-- create the honor virtue buff
			CustomBuffs.Create(122, GetStringFromTid(1012017), GetStringFromTid(123), 0, true)
		end

	else -- honor virtune inactive

		-- remove the honor virtue buff
		CustomBuffs.Remove(122, true)
	end
end

function CustomBuffs.ManaTaintBuff()

	-- is the player mana tainted?
	if CustomBuffs.ManaTaintTime > 0 then

		-- is the mana taint buff inactive?
		if not BuffDebuff.ActiveBuffs[15127] then

			-- create the mana taint buff
			CustomBuffs.Create(127, GetStringFromTid(111), GetStringFromTid(112), CustomBuffs.ManaTaintTime, true)
		end

		-- update the mana taint timer
		CustomBuffs.ManaTaintTime = CustomBuffs.ManaTaintTime - 1

	else -- mana taint inactive

		-- remove the mana taint buff
		CustomBuffs.Remove(127, true)
	end
end

function CustomBuffs.ManaDivertBuff()

	-- is the player mana diverted?
	if CustomBuffs.ManaDivertTime > 0 then

		-- is the mana divert buff inactive?
		if not BuffDebuff.ActiveBuffs[15129] then

			-- create the mana divert buff
			CustomBuffs.Create(129, GetStringFromTid(113), GetStringFromTid(114), CustomBuffs.ManaDivertTime, true)
		end

		-- update the mana divert timer
		CustomBuffs.ManaDivertTime = CustomBuffs.ManaDivertTime - 1

	else -- mana divert inactive

		-- remove the mana divert buff
		CustomBuffs.Remove(129, true)
	end
end

function CustomBuffs.MuddiedBuff()

	-- is the player muddied?
	if CustomBuffs.MudTime > 0 then

		-- is the muddied buff inactive?
		if not BuffDebuff.ActiveBuffs[15126] then

			-- create the muddied buff
			CustomBuffs.Create(126, GetStringFromTid(115), GetStringFromTid(116), CustomBuffs.MudTime, true)
		end

		-- update the muddied timer
		CustomBuffs.MudTime = CustomBuffs.MudTime - 1

	else -- muddied inactive

		-- remove the muddied buff
		CustomBuffs.Remove(126, true)
	end
end

function CustomBuffs.FallingWallsBuff()

	-- are the walls falling?
	if CustomBuffs.FallingWallsTime > 0 then

		-- is the falling walls buff inactive?
		if not BuffDebuff.ActiveBuffs[15123] then

			-- create the falling walls buff
			CustomBuffs.Create(123, GetStringFromTid(117), GetStringFromTid(118), CustomBuffs.FallingWallsTime, true)
		end

		-- update the falling walls timer
		CustomBuffs.FallingWallsTime = CustomBuffs.FallingWallsTime - 1

	else -- the walls are not falling

		-- remove the falling walls buff
		CustomBuffs.Remove(123, true)
	end
end

function CustomBuffs.StunBuff()

	-- is the stun active?
	if CustomBuffs.StunTime > 0 then

		-- is the stun buff inactive?
		if not BuffDebuff.ActiveBuffs[15125] then

			-- create the stun buff
			CustomBuffs.Create(125, GetStringFromTid(119), GetStringFromTid(120), CustomBuffs.StunTime, true)
		end

		-- update the stun timer
		CustomBuffs.StunTime = CustomBuffs.StunTime - 1

	else -- stun inactive

		-- remove the stun buff
		CustomBuffs.Remove(125, true)
	end
end

function CustomBuffs.BerserkBuff()

	-- is the berserker rage active?
	if CustomBuffs.BerserkRage then
		
		-- is the berseker rage buff inactive
		if not BuffDebuff.ActiveBuffs[15128] then

			-- create the berseker rage buff
			CustomBuffs.Create(128, GetStringFromTid(121), GetStringFromTid(122), 0, true)
		end

	else -- berseker rage inactive

		-- remove the berseker rage buff
		CustomBuffs.Remove(128, true)
	end
end

function CustomBuffs.EntangleBuff()

	-- is the entangle active?
	if CustomBuffs.Entangle then
		
		-- is the entangle buff inactive?
		if not BuffDebuff.ActiveBuffs[15124] then

			-- create the entangle buff
			CustomBuffs.Create(124, GetStringFromTid(124), GetStringFromTid(125), 0, true)
		end

	else -- entangle inactive

		-- remove the entangle buff
		CustomBuffs.Remove(124, true)
	end
end