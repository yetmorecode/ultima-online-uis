----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

QuestLog = {}

QuestLog.QuestCap = 10 -- static, defined server side

QuestLog.QuestCount = 0
QuestLog.ActiveQuests = {}
QuestLog.NewActiveQuests = {}

QuestLog.MainLogGumpID = 805
QuestLog.DetailsLogGumpID = 809

QuestLog.LastQuestGiver = 0

QuestLog.DisabledQuestMarkers = {}

QuestLog.CreaturesToKill = {}

QuestLog.QuestLogScannedAtLeastOnce = false

QuestLog.ScanInProgress = false

QuestLog.ObjectiveTypes = {
	[1072204] =  true, -- Slay
	[1072205] =  true, -- Obtain
	[1072206] =  true, -- Escort to
	[1072207] =  true, -- Deliver
	[1077485] =  true, -- Increase ~1_SKILL~ to ~2_VALUE~
}

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function QuestLog.AutoScanLog()
	
	-- no need to start the scan again if it's already running
	if QuestLog.ScanInProgress then 
		return
	end

	-- set the scan in progress flag
	QuestLog.ScanInProgress = true

	-- reset the list of creatures to kill
	QuestLog.CreaturesToKill = {}

	-- reset the quest count
	QuestLog.QuestCount = 0

	-- set the quest ID to scan to the first quest
	QuestLog.CurrentScanning = 1

	-- open the quest log
	BroadcastEvent( SystemData.Events.REQUEST_OPEN_QUEST_LOG )
end

function QuestLog.ScanLog()

	-- do we have the main gump?
	if GumpData.Gumps[QuestLog.MainLogGumpID] then

		-- get the quest count
		QuestLog.QuestCount = #GumpData.Gumps[QuestLog.MainLogGumpID].Buttons - 1
	end
end

function QuestLog.ScanDetails()
	
	-- do we have the quest details gump?
	if GumpData.Gumps[QuestLog.DetailsLogGumpID] then

		-- is this a new quest?
		local newQuest = QuestLog.ActiveQuests[questName] == nil and QuestLog.QuestLogScannedAtLeastOnce == true

		-- current quest giver
		local currentQuestGiver = QuestLog.LastQuestGiver

		-- current gump data
		local currentData = GumpData.Gumps[QuestLog.DetailsLogGumpID]

		-- label id for the quest name
		local questNameID = 3

		-- if the quest is failed all the labels shift down by 1
		local questFailed = 0

		-- is the quest failed?
		if currentData.Labels[3].tid == 500039 then -- Failed!
			questFailed = 1
		end

		-- get the quest TID name
		local questName = tonumber(tostring(wstring.gsub(currentData.Labels[questNameID + questFailed].tidParms[1], L"#", L"")))

		-- get the quest TID description
		local questDesc = currentData.Labels[5].tid

		-- initialize the objectives array
		local questObjectives = {}

		-- initialize the questgiver name
		local questgiver = L""

		-- initialize the objective array
		local currObjective

		-- label ID to start looking for the objectives
		local objID = 11 + questFailed

		-- get the current label TID
		local currLabelTid = currentData.Labels[objID].tid
		
		-- we scan for objectives until we find the reward section
		while currLabelTid ~= 1072201 do -- Reward

			-- new objective found
			if QuestLog.ObjectiveTypes[currLabelTid] then
				
				-- do we have a current objective?
				if currObjective then

					-- insert the current objective into the quest objectives array
					table.insert(questObjectives, currObjective)
				end

				-- initialize a new objective
				currObjective = {}

				-- set the objective type
				currObjective.type = currentData.Labels[objID].tid

				-- is this an escort quest?
				if currObjective.type == 1072206 then -- Escort to
					
					-- next tid is location to go
					objID = objID + 1

					-- escort to
					currObjective.escortTo = currentData.Labels[objID].tid

				elseif currObjective.type == 1072205 then -- Obtain
					
					-- next tid is the item name
					objID = objID + 2

					-- if the item name is not here (so is a string name) we must check the params later
					if not currentData.Labels[objID] then
						currObjective.specialObtain = true

					else
						-- item name
						currObjective.obtain = currentData.Labels[objID].tid
					end

				elseif currObjective.type == 1072204 then -- Slay

					-- next tid is total to kill or the location
					objID = objID + 3

					-- is the location?
					if currentData.Labels[objID].tid == 1018327 then -- Location

						-- check the next label for the location name
						objID = objID + 1

						-- get the location name
						currObjective.location = currentData.Labels[objID].tid
					end

				elseif currObjective.type == 1077485 then -- Increase ~1_SKILL~ to ~2_VALUE~

					-- getting the skill name
					currObjective.skill = tonumber(tostring(wstring.gsub(currentData.Labels[objID].tidParms[1], L"#", L"")))

					-- get the skill value to reach
					currObjective.total = tonumber(currentData.Labels[objID].tidParms[2])
				end
			end

			-- get the next label TID
			objID = objID + 1
			while currentData.Labels[objID] == nil do
				objID = objID + 1
			end

			currLabelTid = currentData.Labels[objID].tid
		end

		-- do we have a current objective?
		if currObjective then

			-- insert the current objective into the quest objectives array
			table.insert(questObjectives, currObjective)
		end
		
		-- starting ID for the params value
		local paramsID = 2

		-- is this an escort quest?
		local isEscort = false

		-- is this a quest that requires the questgiver ID?
		local getQuestGiver = false

		-- scan all the objectives we have
		for i, currObjective in pairsByIndex(questObjectives) do
			
			-- escort and skill quests requires the questgiver id
			if	currObjective.type == 1072206 then -- Escort to
	
				isEscort = true

				-- if this is not a new quest wwe get the previous questgiver ID
				if not newQuest then
					currentQuestGiver = QuestLog.ActiveQuests[questName].escortQuestGiver
				end

			elseif currObjective.type == 1077485 then -- Increase ~1_SKILL~ to ~2_VALUE~

				getQuestGiver = true

				-- if this is not a new quest wwe get the previous questgiver ID
				if not newQuest and questName then
					currentQuestGiver = QuestLog.ActiveQuests[questName].questGiver
				end

			elseif currObjective.type == 1072207 then -- Deliver

				-- get the amount to deliver
				currObjective.total = currentData.LabelsText[paramsID]

				-- get the item name
				paramsID = paramsID + 1
				currObjective.item = currentData.LabelsText[paramsID]

				-- get the time remaining
				paramsID = paramsID + 1
				currObjective.time = currentData.LabelsText[paramsID]

				-- get the npc name
				paramsID = paramsID + 1

				-- get the complete NPC name
				currObjective.returnTo = currentData.LabelsText[paramsID]

				-- if there are brackets then the NPC name also contains the location
				if wstring.find(currObjective.returnTo, L"(", 1, true) then

					-- clean the return to NPC name (by removing the location at the end of the name)
					currObjective.npcName = wstring.sub(currObjective.returnTo, 1, wstring.find(currObjective.returnTo, L"(", 1, true) - 1)

				else -- no brackets, the npc name is already formmatted correctly
					currObjective.npcName = currentData.LabelsText[paramsID]
				end

				-- update the objective data
				questObjectives[i] = currObjective

				-- next id
				paramsID = paramsID + 2

			elseif currObjective.type == 1072205 and not currObjective.specialObtain then -- Obtain (TID name)

				-- get the amount to obtain
				currObjective.total = currentData.LabelsText[paramsID]

				-- get the amount obtained
				paramsID = paramsID + 4
				currObjective.current = currentData.LabelsText[paramsID]

				-- get the npc name
				paramsID = paramsID + 1

				-- get the complete NPC name
				currObjective.returnTo = currentData.LabelsText[paramsID]

				-- if there are brackets then the NPC name also contains the location
				if wstring.find(currObjective.returnTo, L"(", 1, true) then

					-- clean the return to NPC name (by removing the location at the end of the name)
					currObjective.npcName = wstring.sub(currObjective.returnTo, 1, wstring.find(currObjective.returnTo, L"(", 1, true) - 1)

				else -- no brackets, the npc name is already formmatted correctly
					currObjective.npcName = currentData.LabelsText[paramsID]
				end

				-- update the objective data
				questObjectives[i] = currObjective

				-- next id
				paramsID = paramsID + 1

			elseif currObjective.type == 1072205 and currObjective.specialObtain then -- Obtain (string name)

				-- get the amount to obtain
				currObjective.total = currentData.LabelsText[paramsID]

				-- get the item name
				paramsID = paramsID + 1
				currObjective.obtain = currentData.LabelsText[paramsID]

				-- get the amount obtained
				paramsID = paramsID + 4
				currObjective.current = currentData.LabelsText[paramsID]

				-- get the npc name
				paramsID = paramsID + 1

				-- get the complete NPC name
				currObjective.returnTo = currentData.LabelsText[paramsID]

				-- if there are brackets then the NPC name also contains the location
				if wstring.find(currObjective.returnTo, L"(", 1, true) then

					-- clean the return to NPC name (by removing the location at the end of the name)
					currObjective.npcName = wstring.sub(currObjective.returnTo, 1, wstring.find(currObjective.returnTo, L"(", 1, true) - 1)

				else -- no brackets, the npc name is already formmatted correctly
					currObjective.npcName = currentData.LabelsText[paramsID]
				end

				-- update the objective data
				questObjectives[i] = currObjective

				-- next id
				paramsID = paramsID + 1

			elseif currObjective.type == 1072204 then -- Slay
				
				-- get the amount to slay
				currObjective.total = tonumber(currentData.LabelsText[paramsID])

				-- get the creature name
				paramsID = paramsID + 1
				currObjective.creature = currentData.LabelsText[paramsID]

				-- get the amount slain
				paramsID = paramsID + 5
				currObjective.current = tonumber(currentData.LabelsText[paramsID])

				-- do we still need to find this creature?
				if currObjective.current < currObjective.total then

					-- add the creature name to the list
					QuestLog.CreaturesToKill[currObjective.creature] = true
				end

				-- npc name label ID
				paramsID = paramsID + 1

				-- get the complete NPC name
				currObjective.returnTo = currentData.LabelsText[paramsID]
				
				-- if there are brackets then the NPC name also contains the location
				if wstring.find(currObjective.returnTo, L"(", 1, true) then

					-- clean the return to NPC name (by removing the location at the end of the name)
					currObjective.npcName = wstring.sub(currObjective.returnTo, 1, wstring.find(currObjective.returnTo, L"(", 1, true) - 1)

				else -- no brackets, the npc name is already formmatted correctly
					currObjective.npcName = currentData.LabelsText[paramsID]
				end

				-- update the objective data
				questObjectives[i] = currObjective

				-- next id
				paramsID = paramsID + 1
			end
		end

		-- update the quest objectives for the quest
		QuestLog.ActiveQuests[questName] = questObjectives

		-- is the quest failed?
		QuestLog.ActiveQuests[questName].failed = questFailed == 1

		-- if this is an escort quest, we get the questgiver ID
		if isEscort and IsValidID(currentQuestGiver) then
			QuestLog.ActiveQuests[questName].escortQuestGiver = currentQuestGiver
		end

		-- set the quetgiver for the quest
		if (getQuestGiver and IsValidID(currentQuestGiver)) or not QuestLog.ActiveQuests[questName].returnTo then
			QuestLog.ActiveQuests[questName].questGiver = currentQuestGiver
		end
	end
end

function QuestLog.NPCHasActiveQuest(mobileId)
	
	-- do we have a valid ID?
	if not IsValidID(mobileId) then
		return false
	end

	-- get the mobile name
	local mobName = wstring.lower(GetMobileName(mobileId))

	-- do we have a valid name?
	if IsValidWString(mobName) then
		
		-- scan the quest we have in search of the quest givers
		for questName, objectives in pairs(QuestLog.ActiveQuests) do
			
			-- quest not completed by default
			local completed = false

			-- npc found
			local npcFound = false

			-- scan all the objectives we have
			for i, currObjective in pairsByIndex(objectives) do
				
				-- current amount
				local current = 0

				-- for skills we get the current value
				if currObjective.type == 1077485 then -- Increase ~1_SKILL~ to ~2_VALUE~
					current = GetSkillValue(GetSkillIDByTID(currObjective.skill), false)

				-- deliver quest are always completed (because you always have the thing to deliver with you)
				elseif currObjective.type == 1072207 then -- Deliver
					current = currObjective.total

				-- get the current amount from the quest details
				elseif currObjective.current then
					current = currObjective.current
				end

				-- check if the objective is completed
				completed = current == currObjective.total

				-- is this the questgiver we're looking for?
				if (currObjective.npcName and wstring.find(mobName, wstring.lower(towstring(currObjective.npcName), 1, true))) or objectives.escortQuestGiver == mobileId or objectives.questGiver == mobileId then
					npcFound = true
				end
			end

			-- this is a questgiver, also we return the completed flag
			if npcFound then
				return true, completed, objectives.escortQuestGiver == mobileId
			end
		end
	end

	return false
end

function QuestLog.HasKillMarker(name)
	
	-- do we have a valid string?
	if IsValidWString(name) then
	
		-- remove the article from the name
		name = wstring.gsub(towstring(name), L" An ", L"")
		name = wstring.gsub(towstring(name), L" A ", L"")

		-- clean the name from spaces at beginning and end
		name = wstring.trim(name)

		-- turn the mobile name lower case
		name = wstring.lower(name)
		
		-- scan all the creatures to be killed
		for creature, _ in pairs(QuestLog.CreaturesToKill) do

			-- make the creature name lower case
			creature = wstring.lower(creature)
			
			-- creature names are plural so we search if the name is inside (to avoid removing the final "s" and avoid the exceptions)
			if wstring.find(towstring(creature), towstring(name), 1, true) then
				return true
			end
		end

		return false
	end
end

function QuestLog.ClearAllMarkers()
	
	-- remove all the active quest markers
	for mobileId, markWindow in pairs(OverheadText.QuestMarkers) do
		
		-- remove the quest marker
		OverheadText.RemoveQuestMarkerFromMobile(mobileId)
	end
end

function QuestLog.ClearAllKillMarkers()
	
	-- remove all the active kill markers
	for mobileId, markWindow in pairs(OverheadText.KillMarkers) do
		
		-- remove the kill marker
		OverheadText.RemoveKillMarkerFromMobile(mobileId)
	end
end

function QuestLog.QuestResigned()

	-- scan the log for the changes
	QuestLog.AutoScanLog()
end