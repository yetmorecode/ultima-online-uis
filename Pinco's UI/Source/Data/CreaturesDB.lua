----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

CreaturesDB = {}

CreaturesDB.SummonTimes = { }

CreaturesDB.AnimalLoreTamables = {}
CreaturesDB.AnimalLoreSummons = {}
CreaturesDB.AnimalLoreNeutralAnimals = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------
function CreaturesDB.Initialize()

	-- title -> skillID
	CreaturesDB.NPCProfession = 
	{
		[L"The Armourer"] = SkillsWindow.SkillsID.BLACKSMITH,
		[L"The Blacksmith"] = SkillsWindow.SkillsID.BLACKSMITH,
		[L"The Blacksmith Guildmaster"] = SkillsWindow.SkillsID.BLACKSMITH,
		[L"The Blacksmith Guildmistress"] = SkillsWindow.SkillsID.BLACKSMITH,
		[L"The Weaponsmith"] = SkillsWindow.SkillsID.BLACKSMITH,

		[L"The Tailor"] = SkillsWindow.SkillsID.TAILORING,
		[L"The Tailor Guildmaster"] = SkillsWindow.SkillsID.TAILORING,
		[L"The Tailor Guildmistress"]= SkillsWindow.SkillsID.TAILORING,
		[L"The Tailor Instructor"] = SkillsWindow.SkillsID.TAILORING,
		[L"The Weaver"] = SkillsWindow.SkillsID.TAILORING,

		[L"The Bowyer"] = SkillsWindow.SkillsID.FLETCHING,
		[L"The Bowyer Guildmaster"] = SkillsWindow.SkillsID.FLETCHING,
		[L"The Bowyer Guildmistress"] = SkillsWindow.SkillsID.FLETCHING,
		[L"The Bowyer Instructor"] = SkillsWindow.SkillsID.FLETCHING,

		[L"The Carpenter"] = SkillsWindow.SkillsID.CARPENTRY,
		[L"The Carpenter Guildmaster"] = SkillsWindow.SkillsID.CARPENTRY,
		[L"The Carpenter Guildmistress"] = SkillsWindow.SkillsID.CARPENTRY,
		[L"The Carpenter Instructor"] = SkillsWindow.SkillsID.CARPENTRY,

		[L"The Tinker"] = SkillsWindow.SkillsID.TINKERING,
		[L"The Tinker Guildmaster"] = SkillsWindow.SkillsID.TINKERING,
		[L"The Tinker Guildmistress"] = SkillsWindow.SkillsID.TINKERING,
		[L"The Tinker Instructor"] = SkillsWindow.SkillsID.TINKERING,

		[L"The Scribe"] = SkillsWindow.SkillsID.INSCRIPTION,
		[L"The Scribe Guildmaster"] = SkillsWindow.SkillsID.INSCRIPTION,
		[L"The Scribe Guildmistress"] = SkillsWindow.SkillsID.INSCRIPTION,
		[L"The Scribe Instructor"] = SkillsWindow.SkillsID.INSCRIPTION,

		[L"The Cook"] = SkillsWindow.SkillsID.COOKING,
		[L"The Cook Guildmaster"] = SkillsWindow.SkillsID.COOKING,
		[L"The Cook Guildmistress"] = SkillsWindow.SkillsID.COOKING,
		[L"The Cook Instructor"] = SkillsWindow.SkillsID.COOKING,

		[L"The Baker"] = SkillsWindow.SkillsID.COOKING,

		[L"The Alchemist"] = SkillsWindow.SkillsID.ALCHEMY,
		[L"The Alchemist Guildmaster"] = SkillsWindow.SkillsID.ALCHEMY,
		[L"The Alchemist Guildmistress"] = SkillsWindow.SkillsID.ALCHEMY,
		[L"The Alchemist Instructor"] = SkillsWindow.SkillsID.ALCHEMY,
	}

	-- name -> skillID
	CreaturesDB.NPCNameProfession =
	{
		[L"Thepem The Apprentice"] = SkillsWindow.SkillsID.ALCHEMY,
	}

	-- name -> skillID
	CreaturesDB.NPCNameFakeProfession =
	{
		[L"Aliabeth The Tinker"] = true,
	}
end

function CreaturesDB.LoadTamables()

	-- reset the current list
	CreaturesDB.AnimalLoreTamables = {}

	-- scan all the creatures in the DB
	for i, data in pairsByIndex(CreaturesDB.AllCreatures) do

		-- is the creature tamable?
		if data.tamable ~= nil then

			-- store the creature ID
			data.id = i

			-- add the creature to the table
			table.insert(CreaturesDB.AnimalLoreTamables, data)
		end
	end
end

function CreaturesDB.LoadSummons()

	-- reset the current list
	CreaturesDB.AnimalLoreSummons = {}

	-- scan all the creatures in the DB
	for i, data in pairsByIndex(CreaturesDB.AllCreatures) do

		-- is the creature tamable?
		if wstring.find(data.creaturename, L"(summoned)", 1, true) then

			-- store the creature ID
			data.id = i

			-- add the creature to the table
			table.insert(CreaturesDB.AnimalLoreSummons, data)
		end
	end
end

function CreaturesDB.LoadNeutralAnimals()

	-- reset the current list
	CreaturesDB.AnimalLoreNeutralAnimals = {}

	-- scan all the creatures in the DB
	for i, data in pairsByIndex(CreaturesDB.AllCreatures) do

		-- is the creature neutral?
		if data.isneutral == true then

			-- store the creature ID
			data.id = i

			-- add the creature to the table
			table.insert(CreaturesDB.AnimalLoreNeutralAnimals, data)
		end
	end
end

function CreaturesDB.updateSummonTimes()

	local magery = GetSkillValue(SkillsWindow.SkillsID.MAGERY, true)
	
	local sw = GetSkillValue(SkillsWindow.SkillsID.SPELLWEAVING, true)
	
	local mystic = GetSkillValue(SkillsWindow.SkillsID.MYSTICISM, false)

	local imbuing = GetSkillValue(SkillsWindow.SkillsID.IMBUING, false) 

	local focus = GetSkillValue(SkillsWindow.SkillsID.FOCUS, false)

	local sspeak = GetSkillValue(SkillsWindow.SkillsID.SPIRIT_SPEAK, false)

	local ninj = GetSkillValue(SkillsWindow.SkillsID.NINJITSU, false)
	
	local focusImb = math.max(focus, imbuing)
	
	CreaturesDB.SummonTimes[L"a revenant"] = ((sspeak * 80) / 1200) + 10
	
	CreaturesDB.SummonTimes[L"an energy vortex"] = 90 
	CreaturesDB.SummonTimes[L"a blade spirit"] = 120
	
	CreaturesDB.SummonTimes[L"summon creature"] =  ((20 * magery) / 5)
	
	CreaturesDB.SummonTimes[L"an earth elemental"] = ((20 * magery) / 5) 
	CreaturesDB.SummonTimes[L"an air elemental"] = ((20 * magery) / 5) 
	CreaturesDB.SummonTimes[L"a water elemental"] = ((20 * magery) / 5) 
	CreaturesDB.SummonTimes[L"a fire elemental"] = ((20 * magery) / 5) 

	CreaturesDB.SummonTimes[L"daemon"] = ((20 * magery) / 5) - 2

	CreaturesDB.SummonTimes[L"a rising colossus"] = ((mystic + focusImb) / 4)
	CreaturesDB.SummonTimes[L"an animated weapon"] = ((mystic + focusImb) / 2) + 10
	
	CreaturesDB.SummonTimes[L"a nature's fury"] =  (sw / 24) + (2 * Interface.ArcaneFocusLevel) + 25
	
	CreaturesDB.SummonTimes[L"an imp"] = (((sw / 24) +  Interface.ArcaneFocusLevel) * 60) 
	CreaturesDB.SummonTimes[L"fey"] =  (((sw / 24) +  Interface.ArcaneFocusLevel) * 60) 
	
	CreaturesDB.SummonTimes[L"mirror image"] =  30 + (ninj / 4)
	
	CreaturesDB.SummonTimes[L"talisman summon"] =  600
end

function CreaturesDB.GetBardDiff(name)
	if not name then
		return L""
	end
	if (CreaturesDB[name] ~= nil and CreaturesDB[name].barddiff) then
		local bd = tostring(CreaturesDB[name].barddiff)
		if bd then
			bd = string.gsub(bd, ",", ".")
			return towstring(bd)
		end
	end
	return L""
end

function CreaturesDB.IsCursed(name)
	return IsValidWString(name) and wstring.find(name, L" the cursed", 1, true) ~= nil
end

function CreaturesDB.IsBrigand(name)
	return IsValidWString(name) and wstring.find(name, L" the brigand", 1, true) ~= nil
end

function CreaturesDB.IsBrigandCannibal(name)
	return IsValidWString(name) and wstring.find(name, L" the brigand cannibal", 1, true) ~= nil
end

function CreaturesDB.IsCannibalMage(name)
	return IsValidWString(name) and wstring.find(name, L" the brigand cannibal mage", 1, true) ~= nil
end

function CreaturesDB.IsExecutioner(name)
	return IsValidWString(name) and wstring.find(name, L" the executioner", 1, true) ~= nil
end

function CreaturesDB.IsCorruptedMage(name)
	return IsValidWString(name) and wstring.find(name, L" the corrupted mage", 1, true) ~= nil
end

function CreaturesDB.IsVileMage(name)
	return IsValidWString(name) and wstring.find(name, L" the vile mage", 1, true) ~= nil
end

function CreaturesDB.IsPriestOfMondain(name)
	return IsValidWString(name) and wstring.find(name, L" the priest of mondain", 1, true) ~= nil
end

function CreaturesDB.IsWanderingHealer(name)
	return IsValidWString(name) and wstring.find(name, L" the wandering healer", 1, true) ~= nil
end

function CreaturesDB.IsDefender(name)
	return IsValidWString(name) and wstring.find(name, L" the defender", 1, true) ~= nil
end

function CreaturesDB.IsSquatter(name)
	return IsValidWString(name) and wstring.find(name, L" the squatter", 1, true) ~= nil
end

function CreaturesDB.IsBurning(name)
	return IsValidWString(name) and wstring.find(name, L" the burning", 1, true) ~= nil
end

function CreaturesDB.IsCrazed(name)
	return IsValidWString(name) and wstring.find(name, L" the crazed", 1, true) ~= nil
end

function CreaturesDB.IsEvilMageLord(name)
	return IsValidWString(name) and CreaturesDB.Names.EvilMageLords[name] ~= nil
end

function CreaturesDB.IsEvilMage(name)
	return IsValidWString(name) and wstring.find(name, L" the mage", 1, true) ~= nil and CreaturesDB.Names.EvilMages[StripNameTitle(name)] and not CreaturesDB.IsEvilMageLord(name)
end

function CreaturesDB.IsSoulboundSB(name)
	return IsValidWString(name) and wstring.find(name, L" the soulbound swashbuckler", 1, true) ~= nil
end

function CreaturesDB.IsSoulboundSS(name)
	return IsValidWString(name) and wstring.find(name, L" the soulbound spell slinger", 1, true) ~= nil
end

function CreaturesDB.IsSoulboundPR(name)
	return IsValidWString(name) and wstring.find(name, L" the soulbound pirate raider", 1, true) ~= nil
end

function CreaturesDB.IsSoulboundPC(name)
	return IsValidWString(name) and wstring.find(name, L" the soulbound pirate captain", 1, true) ~= nil
end

function CreaturesDB.IsSoulboundBM(name)
	return IsValidWString(name) and wstring.find(name, L" the soulbound battle mage", 1, true) ~= nil
end

function CreaturesDB.IsSoulboundAM(name)
	return IsValidWString(name) and wstring.find(name, L" the soulbound apprentice mage", 1, true) ~= nil
end

function CreaturesDB.IsDaemon(name)
	return IsValidWString(name) and CreaturesDB.Names.Daemons[name] ~= nil
end

function CreaturesDB.IsBaneChosenGuard(name)
	return IsValidWString(name) and wstring.find(name, L" the guard", 1, true) and CreaturesDB.IsDaemon(StripNameTitle(name))
end

function CreaturesDB.IsFamiliar(name)
	return IsValidWString(name) and CreaturesDB.Names.Familiars[name] ~= nil
end

function CreaturesDB.IsBird(name)
	return IsValidWString(name) and CreaturesDB.Names.Birds[name] ~= nil
end

function CreaturesDB.IsLizardman(name)
	return IsValidWString(name) and CreaturesDB.Names.Lizardmen[name] ~= nil
end

function CreaturesDB.IsRatman(name)
	return IsValidWString(name) and CreaturesDB.Names.Ratmen[name] ~= nil
end

function CreaturesDB.IsController(name)
	return IsValidWString(name) and wstring.find(name, L" the controller", 1, true) and CreaturesDB.Names.Controllers[StripNameTitle(name)] ~= nil
end

function CreaturesDB.IsSavageRider(name)
	return IsValidWString(name) and wstring.find(name, L" the savage rider", 1, true) and CreaturesDB.IsSavage(StripNameTitle(name))
end

function CreaturesDB.IsSavageShaman(name)
	return IsValidWString(name) and wstring.find(name, L" the savage shaman", 1, true) and CreaturesDB.IsSavage(StripNameTitle(name))
end

function CreaturesDB.IsSavageWarrior(name)
	return IsValidWString(name) and wstring.find(name, L" the savage warrior", 1, true) and CreaturesDB.IsSavage(StripNameTitle(name))
end

function CreaturesDB.IsSavage(name)
	return IsValidWString(name) and CreaturesDB.Names.Savages[name] ~= nil
end

function CreaturesDB.IsOrc(name)
	return IsValidWString(name) and CreaturesDB.Names.Orcs[name] ~= nil
end

function CreaturesDB.IsDarknightCreeper(name)
	return IsValidWString(name) and CreaturesDB.Names.DarknightCreepers[name] ~= nil
end

function CreaturesDB.IsImpaler(name)
	return IsValidWString(name) and CreaturesDB.Names.Impalers[name] ~= nil
end

function CreaturesDB.IsShadowKnight(name)
	return IsValidWString(name) and wstring.find(name, L" the shadow knight", 1, true) and CreaturesDB.Names.ShadowKnights[StripNameTitle(name)] ~= nil
end

function CreaturesDB.IsDarkFather(name)
	return IsValidWString(name) and wstring.find(name, L" the dark father", 1, true) and CreaturesDB.Names.DarkFathers[StripNameTitle(name)] ~= nil
end

function CreaturesDB.IsBalron(name)
	return IsValidWString(name) and CreaturesDB.Names.Balrons[name] ~= nil
end

function CreaturesDB.IsPixie(name)
	return IsValidWString(name) and CreaturesDB.Names.Pixies[name] ~= nil
end

function CreaturesDB.IsCentaur(name)
	return IsValidWString(name) and CreaturesDB.Names.Centaurs[name] ~= nil
end

function CreaturesDB.IsEtherealWarrior(name)
	return IsValidWString(name) and CreaturesDB.Names.EtherealWarriors[name] ~= nil
end

function CreaturesDB.IsAncientLich(name)
	return IsValidWString(name) and CreaturesDB.Names.AncientLichs[name] ~= nil
end

function CreaturesDB.CleanUpName(name, stripGuardian)
	
	-- do we have a valid name?
	if not IsValidWString(towstring(name)) then
		return L""
	end

	-- make the name lower case
	name = wstring.lower(name)

	-- get the first 3 characters of the name
	local article = wstring.sub(name, 1, 3)

	-- does the name has the article A ...?
	if wstring.find(article, L"a ", 1, true) then

		-- get the name from char 3 and forward
		name = wstring.sub(name, 3)

	-- does the name has the article An ...?
	elseif wstring.find(article, L"an ", 1, true) then

		-- get the name from char 4 and forward
		name = wstring.sub(name, 4)
	end

	-- remove line breaker
	name = wstring.gsub(name, L"\n", L" ")

	-- does the name have the suffix (Paragon) ?
	if wstring.find(name , L"(paragon)", 1, true) ~= nil then

		-- remove the suffix
		name = wstring.gsub(name, L"%(paragon%)", L"")
	end

	-- does the name have the suffix [Renowned] ?
	if wstring.find(name , L"[renowned]", 1, true) ~= nil then

		-- remove the tags
		name = wstring.gsub(name, L"%[", L"")
		name = wstring.gsub(name, L"%]", L"")
	end

	-- does the name have the suffix (Guardian) ?
	if stripGuardian and wstring.find(name , L"(guardian)", 1, true) ~= nil then

		-- remove the suffix
		name = wstring.gsub(name, L"%(guardian%)", L"")
	end

	-- clean the name from extra spaces
	name = wstring.trim(name)

	return name
end

function CreaturesDB.FormatBoolean(value)
	
	-- do we have a valid string with "true" inside?
	if (IsValidString(value) and value == "true") or (IsValidWString(value) and value == L"true") then
		return true
	end
end

function CreaturesDB.FormatCreaturesArray()

	-- scan all the creatures in the DB
	for i, data in pairsByIndex(CreaturesDB.AllCreatures) do

		-- create a copy of the current record
		local newRecord = table.copy(data)
		
		-- scan all the record fields
		for field, value in pairs(data) do
			
			-- is this the creature name?
			if field == "creaturename" then

				-- convert the name to wstring
				newRecord[field] = towstring(value)

				continue
			end

			-- this field needs to be converted in a function
			if field == "nametotype" then

				-- do we have a valid string for the function name?
				if IsValidString(value) then
					
					-- load the function into the table
					newRecord[field] = function(name) return CreaturesDB[value](name) end

				else -- remove the value if we don't have a function
					newRecord[field] = nil
				end

				continue
			end

			-- is this the body ID?
			if field == "bodyid" then

				-- replace the "-" with comma and split into lines
				value = string.gsub(value, "[-]", ",")
				local splitValue = string.split(value, ",", true)

				-- reset the value on the new record for the field
				newRecord[field] = {}

				-- scan all the body ids
				for j, value in pairsByIndex(splitValue) do

					-- transform the string to number
					newRecord[field][j] = tonumber(value)
				end

				continue
			end

			-- is this the hues field?
			if field == "hues" then

				-- replace the "-" with comma and split into lines
				value = string.gsub(value, "[-]", ",")
				local splitValue = string.split(value, ",", true)

				-- reset the value on the new record for the field
				newRecord[field] = {}

				-- do we have any hue specified?
				if IsValidString(value) then

					-- scan the hues
					for k, val in pairsByIndex(splitValue) do

						-- if it's not a valid number, it's a function
						if not tonumber(val) then

							-- get the hue table
							local hueTable = CreaturesDB[val]()
						
							-- append the procedurally generated hue table to the current hues table
							newRecord[field] = table.append(newRecord[field], hueTable)

						else -- add the number into the table
							table.insert(newRecord[field], tonumber(val))
						end
					end

				else -- no hue = any hue will do
					newRecord[field] = "any"
				end

				continue
			end

			-- is this the notoriety?
			if field == "notoriety" then

				-- do we have any notoriety specified?
				if IsValidString(value) then

					-- convert the value to number
					newRecord[field] = tonumber(value)

				else -- no notoriety = any notoriety will do
					newRecord[field] = "any"
				end

				continue
			end

			-- is this a slayers field?
			if field == "slayers" or field == "oppositeslayers" then
				
				-- replace the "-" with comma and split into lines
				value = string.gsub(value, "[-]", ",")
				local splitValue = string.split(value, ",", true)

				-- reset the value on the new record for the field
				newRecord[field] = {}

				-- scan all the slayers we got from the splitted string
				for j, slayer in pairsByIndex(splitValue) do
					
					-- do we have a valid slayer?
					if IsValidString(slayer) then

						-- add the slayer to the slayers list of the new record
						table.insert(newRecord[field], towstring(string.trim(slayer)))
					end
				end

				continue
			end

			-- is this the barding difficulty?
			if field == "barddiff" then

				-- do we have a valid number for the barding difficulty?
				if tonumber(value) and value ~= "Immune" then

					-- convert the value to number
					newRecord[field] = tonumber(value)

				else -- string value
					newRecord[field] = value
				end

				continue
			end

			-- is this the tamable field?
			if field == "tamable" then

				-- convert the value to number (or nil)
				newRecord[field] = tonumber(value)

				continue
			end

			-- is this the multislot field?
			if field == "multislot" then

				-- convert the value to number (or nil)
				newRecord[field] = tonumber(value)

				continue
			end

			-- is this a true/false flag?
			if field == "halfstat" or field == "isboss" or field == "ismount" or field == "isneutral" or field == "eightstat" or field == "innatemagery" or field == "innatenecro" or field == "innatepoisoning" or field == "innatemysticism" then
				
				-- convert the string flag to boolean
				newRecord[field] = CreaturesDB.FormatBoolean(value)

				continue
			end

			-- this field needs to be nullified if is empty
			if field == "location" then

				-- do we have a valid string for the location name?
				if not IsValidString(value) then
					newRecord[field] = nil
				end

				continue
			end
			
			-- is this the specials list?
			if field == "specials" then
			
				-- replace the "-" with comma and split into lines
				value = string.gsub(value, "[-]", ",")
				local splitValue = string.split(value, ",", true)

				-- reset the value on the new record for the field
				newRecord[field] = {}
				
				-- scan all the specials tid
				for j, value in pairsByIndex(splitValue) do

					-- transform the string to number
					newRecord[field][j] = tonumber(value)
				end

				continue
			end

			-- is this the classification list?
			if field == "classification" then
			
				-- replace the "-" with comma and split into lines
				value = string.gsub(value, "[-]", ",")
				local splitValue = string.split(value, ",", true)

				-- reset the value on the new record for the field
				newRecord[field] = {}
				
				-- scan all the specials tid
				for j, value in pairsByIndex(splitValue) do

					-- transform the string to number
					newRecord[field][j] = towstring(value)
				end

				continue
			end

			-- any other value

			-- replace the "-" with comma and split into lines
			value = string.gsub(value, "[-]", ",")
			local splitValue = string.split(value, ",", true)

			-- reset the value on the new record for the field
			newRecord[field] = {}

			-- split in min, max and
			newRecord[field].min = tonumber(splitValue[1]) or 0
			newRecord[field].max = tonumber(splitValue[2]) or 0

			-- store the orignal range too
			newRecord[field].range = towstring(string.gsub(value, ",", " - "))
		end
		
		-- insert the formatted data
		CreaturesDB.AllCreatures[i] = newRecord
	end
end

function CreaturesDB.FindCompatibleCreaturesByName(name)

	-- do we have a valid ID?
	if not IsValidWString(name) then
		return
	end
	
	-- cleanup the name
	name = CreaturesDB.CleanUpName(name)
	
	-- array of all compatible creatures
	local compatibleArray = {}

	-- scan all the creatures in the DB
	for i, data in pairsByIndex(CreaturesDB.AllCreatures) do

		-- does this creature has a name check function?
		if (not data.nametotype and name == data.creaturename) or (data.nametotype and data.nametotype(name) == true) then
			
			-- add the ID to the record
			data.id = i

			-- add the mobile to the compatible array
			table.insert(compatibleArray, table.copy(data))
		end
	end
	
	return compatibleArray			
end

function CreaturesDB.FindCompatibleCreatures(mobileId, perfectMatch, tbl)

	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return
	end

	-- update the mobile flag
	Interface.UpdateMobileOnScreenNameFlags(mobileId, true)

	-- current mobile data record
	local mobileStatus = Interface.ActiveMobilesOnScreen[mobileId]

	-- get hte mobile body ID
	local bodyID = GetMobileBodyID(mobileId)
	
	-- the mobile name
	local name

	-- do we have a name?
	if mobileStatus and mobileStatus.name then

		-- get the loaded name
		name = mobileStatus.name

	else -- get the name
		name = GetMobileName(mobileId)
	end

	-- current area name
	local nameArea = string.lower(MapCommon.CurrentArea or "")

	-- current sub-area name
	local nameSubArea = string.lower(MapCommon.CurrentSubArea or "")

	-- the mobile notoriety
	local noto
	
	-- do we have the notoriety?
	if mobileStatus and mobileStatus.notoriety and mobileStatus.notoriety ~= NameColor.Notoriety.NONE then

		-- get the loaded noto
		noto = mobileStatus.notoriety

	else -- get the notoriety
		noto = GetMobileNotoriety(mobileId, false)
	end

	-- get the mobile hue
	local hue = GetMobileHue(mobileId)

	-- is this creature paragon?
	if hue == 1281 then

		-- set the hue to 0 if it's paragon
		hue = 0
	end

	-- does this creature belong to someone?
	local isSomeonePet

	-- if is an invulnerable creature at new magincia is probably a creature from a pets vendor
	if noto == NameColor.Notoriety.INVULNERABLE and not DoesBodyHasPaperdoll(mobileId) and nameArea == "new magincia" then
		isSomeonePet = true
		
	-- do we have the flag?
	elseif mobileStatus and mobileStatus.isSomeonePet ~= nil then

		-- get the loaded flag
		isSomeonePet = mobileStatus.isSomeonePet

	else -- get the flag 
		isSomeonePet = IsSomeonePet(mobileId)
	end
	
	-- does this creature is a summon?
	local isSummon

	-- do we have the flag?
	if mobileStatus and mobileStatus.isSummon ~= nil then

		-- get the loaded flag
		isSummon = mobileStatus.isSummon

	else -- get the flag
		isSummon = IsSummon(mobileId)
	end
	
	-- cleanup the name
	name = CreaturesDB.CleanUpName(name)

	-- do we have to use a specific table?
	if not tbl then

		-- use the default all creatures table
		tbl = CreaturesDB.AllCreatures
	end

	-- array of all compatible creatures
	local compatibleArray = {}
	
	-- scan all the creatures in the DB
	for i, data in pairsByIndex(tbl) do
	
		-- does this creature has the right notoriety
		if not isSomeonePet and not isSummon and ((type(data.notoriety) == "string" and data.notoriety ~= "any") or data.notoriety ~= noto) then

			if (data.notoriety == NameColor.Notoriety.INNOCENT and noto ~= NameColor.Notoriety.CANATTACK) then
				continue
			end
		end
		
		-- is the creature restricted to a certain area (that is not where we are now?)
		if data.location and data.location ~= nameArea and data.location ~= nameSubArea then
			continue
		end
		
		-- flag that indicates if the body has been found or not
		local bodyfound = false

		-- scan the body ids for the creature
		for _, body in pairsByIndex(data.bodyid) do

			-- is this the body we're looking for?
			if body == bodyID then

				-- mark the body as found
				bodyfound = true

				break
			end
		end
		
		-- if the body is compatible, we add the mobile data to the compatible table 
		if bodyfound then
		
			-- does this creature has a name check function?
			if not data.nametotype or data.nametotype(name) == false then
			
				-- is the name not in the DB but is a summon?
				if name ~= data.creaturename and isSummon then
				
					-- add the tag summoned to the name
					name = name .. L" (summoned)"
					
					-- if the name is still not good, is not the creature we're looking for
					if name ~= data.creaturename then
						continue
					end

				-- check for the name exact match (if it's not someoneone pet's)
				elseif name ~= data.creaturename and not isSomeonePet then

					-- is this a guardian creature?
					if wstring.find(name , L"(guardian)", 1, true) then
					
						-- we strip the guardian tag
						name = CreaturesDB.CleanUpName(name, true)
					end

					-- if the name is still not good, is not the creature we're looking for
					if name ~= data.creaturename then
						continue
					end
				end
			end

			-- if we want a perfect match, we need to check also the hues (unfortunately the DB may not have them all...).
			-- if we don't have the hues, any color is ok.
			if perfectMatch and data.hues and #data.hues > 0 then

				-- flag that indicates if the hue has been found or not
				local hueFound = false

				-- do we have the hues data?
				if type(data.hues) == "table" then

					-- scan the hues ids for the creature
					for _, hid in pairsByIndex(data.hues) do
			
						-- is this the hue we're looking for?
						if hue == hid then

							-- mark the hue as found
							hueFound = true

							break
						end
					end

				else -- generate an error to be reported...
					Debug.Print(L"NO HUE DATA!!! (" .. towstring(hue) .. L") " .. towstring(data.creaturename))
				end

				-- if we have no hue we can move on
				if not hueFound then
					continue
				end
			end

			-- add the ID to the record
			data.id = i

			-- add the mobile to the compatible array
			table.insert(compatibleArray, table.copy(data))
		end
	end

	return compatibleArray			
end

function CreaturesDB.IsGoat(mobileId)

	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return
	end

	-- get hte mobile body ID
	local bodyID = GetMobileBodyID(mobileId)

	-- goat body ids
	return bodyID == 209 or bodyID == 88
end

function CreaturesDB.PinkHue()

	-- initialize the colors table
	local tab = {}
	
	-- loop through the colors range
	for color = 1201, 1254 do

		-- add the color to the table
		table.insert(tab, color)
	end

	-- return the color table
	return tab
end

function CreaturesDB.BlueHue()

	-- initialize the colors table
	local tab = {}
	
	-- loop through the colors range
	for color = 1301, 1354 do

		-- add the color to the table
		table.insert(tab, color)
	end

	-- return the color table
	return tab
end

function CreaturesDB.GreenHue()

	-- initialize the colors table
	local tab = {}
	
	-- loop through the colors range
	for color = 1401, 1454 do

		-- add the color to the table
		table.insert(tab, color)
	end

	-- return the color table
	return tab
end

function CreaturesDB.OrangeHue()

	-- initialize the colors table
	local tab = {}
	
	-- loop through the colors range
	for color = 1601, 1654 do

		-- add the color to the table
		table.insert(tab, color)
	end

	-- return the color table
	return tab
end

function CreaturesDB.LavaLizardHue()

	-- initialize the colors table
	local tab = {}
	
	-- loop through the colors range
	for color = 1601, 1654 do

		-- add the color to the table
		table.insert(tab, color + 32768)
	end

	-- return the color table
	return tab
end

function CreaturesDB.YellowHue()

	-- initialize the colors table
	local tab = {}
	
	-- loop through the colors range
	for color = 1701, 1754 do

		-- add the color to the table
		table.insert(tab, color)
	end

	-- return the color table
	return tab
end

function CreaturesDB.NeutralHue()

	-- initialize the colors table
	local tab = {}
	
	-- loop through the colors range
	for color = 1801, 1908 do

		-- add the color to the table
		table.insert(tab, color)
	end

	-- return the color table
	return tab
end

function CreaturesDB.SnakeHue()

	-- initialize the colors table
	local tab = {}
	
	-- loop through the colors range
	for color = 2001, 2018 do

		-- add the color to the table
		table.insert(tab, color)
	end

	-- return the color table
	return tab
end

function CreaturesDB.BirdHue()

	-- initialize the colors table
	local tab = {}
	
	-- loop through the colors range
	for color = 2301, 2330 do

		-- add the color to the table
		table.insert(tab, color)
	end

	-- return the color table
	return tab
end

function CreaturesDB.BirdHue2()

	-- initialize the colors table
	local tab = {}
	
	-- loop through the colors range
	for color = 2101, 2130 do

		-- add the color to the table
		table.insert(tab, color)
	end

	-- return the color table
	return tab
end

function CreaturesDB.SlimeHue()

	-- initialize the colors table
	local tab = {}
	
	-- loop through the colors range
	for color = 2201, 2224 do

		-- add the color to the table
		table.insert(tab, color)
	end

	-- return the color table
	return tab
end

function CreaturesDB.AnimalsHue()

	-- initialize the colors table
	local tab = {}
	
	-- loop through the colors range
	for color = 2301, 2318 do

		-- add the color to the table
		table.insert(tab, color)
	end

	-- return the color table
	return tab
end

function CreaturesDB.MetalHue()

	-- initialize the colors table
	local tab = {}
	
	-- loop through the colors range
	for color = 2401, 2430 do

		-- add the color to the table
		table.insert(tab, color)
	end

	-- return the color table
	return tab
end

function CreaturesDB.HairHue()

	-- initialize the colors table
	local tab = {}
	
	-- loop through the colors range
	for color = 1102, 1150 do

		-- add the color to the table
		table.insert(tab, color)
	end

	-- return the color table
	return tab
end

function CreaturesDB.PlagueSpawnSkinHue()

	-- initialize the colors table
	local tab = {}
	
	-- loop through the colors range
	for color = 17, 32 do

		-- add the color to the table
		table.insert(tab, color)
	end

	-- return the color table
	return tab
end

function CreaturesDB.HeadlessSkinHue()

	-- initialize the colors table
	local tab = {}
	
	-- loop through the colors range
	for color = 1002, 1059 do

		-- add the color to the table
		table.insert(tab, color)
	end

	-- return the color table
	return tab
end

function CreaturesDB.SkinHue()

	-- initialize the colors table
	local tab = {}
	
	-- loop through the colors range
	for color = 1002, 1059 do

		-- add the color to the table
		table.insert(tab, color + 32768)
	end

	-- return the color table
	return tab
end

function CreaturesDB.ElfSkinHue()

	-- initialize the colors table
	local tab = { 191, 589, 590, 591, 851, 865, 871, 884, 885, 886, 897, 898, 899, 900, 901, 905, 990, 997, 998, 1000, 1001, 1072, 1191, 1246, 1309, 1343, 1401, 1899, 1900, 1901, 2101, 2307 }

	-- lo through all the colors
	for i, color in pairsByIndex(tab) do

		-- increase the color ID
		tab[i] = 32768 + color
	end

	-- return the color table
	return tab
end

function CreaturesDB.GargoyleSkinHue()

	-- initialize the colors table
	local tab = {}
	
	-- loop through the colors range
	for color = 1755, 1780 do

		-- add the color to the table
		table.insert(tab, color + 32768)
	end

	-- return the color table
	return tab
end

function CreaturesDB.CursedSkinHue()

	-- initialize the colors table
	local tab = {}
	
	-- loop through the colors range
	for color = 34198, 34201 do

		-- add the color to the table
		table.insert(tab, color)
	end

	-- return the color table
	return tab
end

function CreaturesDB.DyeHue()

	-- initialize the colors table
	local tab = {}
	
	-- loop through the colors range
	for color = 2, 1001 do

		-- add the color to the table
		table.insert(tab, color)
	end

	-- return the color table
	return tab
end

function CreaturesDB.BrightHue()

	-- initialize the colors table
	local tab = { 98, 113, 3,  13, 19, 28, 33, 48, 55, 58, 68, 89 }

	-- return the color table
	return tab
end