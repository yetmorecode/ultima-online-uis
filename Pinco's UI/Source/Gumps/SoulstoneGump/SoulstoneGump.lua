----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

SoulstoneGump = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

SoulstoneGump.WindowName = "SoulstoneGump"

SoulstoneGump.currentGumpData = {}

SoulstoneGump.deltaCheck = 0

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function SoulstoneGump.Initialize()
	
	-- current window name
	local this = SoulstoneGump.WindowName

	-- set the window title
	WindowUtils.SetActiveDialogTitle(GetStringFromTid(1030899)) -- soulstone

	-- get the soulstone ID
    local soulstoneID = Interface.LastItem
    
	-- set the soulstone ID to the window
    WindowSetId(this, soulstoneID)

	-- mark the window to be destroyed on close
    Interface.DestroyWindowOnClose[this] = true 

	-- restore the saved window position
	WindowUtils.RestoreWindowPosition(this)
end

function SoulstoneGump.Shutdown()

	-- save the window position
	WindowUtils.SaveWindowPosition(SoulstoneGump.WindowName)
	
	-- is the soulstone gump still active?
	if GumpData.Gumps[GenericGump.SOULSTONE_GUMPID] then
		
		-- close the gump
		GumpsParsing.PressButton(GenericGump.SOULSTONE_GUMPID, 1)
	end

	-- clear the gump data
	SoulstoneGump.currentGumpData = nil
end

function SoulstoneGump.OnUpdate(timePassed)

	-- increase the delay check timer
	SoulstoneGump.deltaCheck = SoulstoneGump.deltaCheck + timePassed

	-- is it time to check if the gump i still open?
	if SoulstoneGump.deltaCheck > 1 then
		
		-- is the gump closed?
		if not GumpData.Gumps[GenericGump.SOULSTONE_GUMPID] then

			-- destroy the window
			DestroyWindow(SoulstoneGump.WindowName)
		end
	end
end

function SoulstoneGump.SetGumpType(gumpData)

	-- current window name
	local this = SoulstoneGump.WindowName

	-- store the gump data
	SoulstoneGump.currentGumpData = gumpData

	-- is this the skill selection gump?
	if gumpData.Labels[2].tid == 1061087 then -- Which skill do you wish to transfer to the Soulstone?

		-- window content sub-window name
		local contentWindowName = "SoulstoneStore"

		-- does the content window already exist?
		if DoesWindowExist(contentWindowName) then
			
			-- destroy the existing window to avoid trouble
			DestroyWindow(contentWindowName)
		end

		-- sub-window title name
		local subTitle = contentWindowName .. "Title"

		-- create the absorb sub-window
		CreateWindowFromTemplate(contentWindowName, "SoulstoneStoreTemplate", this)

		-- set the sub-window title
		LabelSetText(subTitle, GetStringFromTid(384))

		-- previous label name
		local prevLabel

		-- scan all the labels
		for i, label in pairsByIndex(gumpData.Labels) do

			-- is the label index greater than 2? (the first 2 labels are the title and the cancel button)
			if i < 3 then
				continue
			end

			-- button ID for the skill (the buttons index is 1 less than the labels)
			local buttonID = i - 1

			-- get the skill TID
			local skillTid = label.tid

			-- get the skill server ID
			local serverID = SoulstoneGump.GetServerIDForTID(skillTid)

			-- get the current skill value
			local skillValue = wstring.format(L"%.1f", WindowData.SkillDynamicData[serverID].RealSkillValue / 10)

			-- skill label name
			local labelname = contentWindowName .. "Skill" .. buttonID

			-- create the skill button
			CreateWindowFromTemplate(labelname, "SoulstoneSkillButtonTemplate", contentWindowName)

			-- reset the label anchors
			WindowClearAnchors(labelname)

			-- is this the first label?
			if not prevLabel then

				-- anchor this button under the sub-title
				WindowAddAnchor(labelname, "bottom", subTitle, "top", 0, 30)

			else -- other labels
				
				-- anchor this button under the previous label
				WindowAddAnchor(labelname, "bottom", prevLabel, "top", 0, 10)
			end

			-- set the button ID for the skill
			WindowSetId(labelname, buttonID)

			-- set the label text for the skill
			LabelSetText(labelname, GetStringFromTid(skillTid) .. L" - " .. skillValue)

			-- save the current label as previous label
			prevLabel = labelname
		end

		-- show the soulstone window
		WindowSetShowing(this, true)

	-- is this the delete skill gump
	elseif gumpData.Labels[2].tid == 1070725 then -- <CENTER>Confirm Soulstone Skill Removal</CENTER>

		-- do we have to delete the skill?
		if SoulstoneGump.DeleteSkillPoints then
		
			-- remove the safety flag
			SoulstoneGump.DeleteSkillPoints = nil

			-- remove the skill from the soulstone
			GumpsParsing.PressButton(GenericGump.SOULSTONE_GUMPID, 2)

			-- destroy this soulstone window
			DestroyWindow(this)
		end

	-- is this the store/absorb skill gump
	elseif gumpData.Labels[2].tid == 1070709 then -- <CENTER>Confirm Soulstone Transfer</CENTER>

		-- is this the skill absorb gump?
		if gumpData.Labels[12].tid == 1070723 then -- Remove all skill points from this stone and DO NOT absorb them.

			-- window content sub-window name
			local contentWindowName = "SoulstoneAbsorb"

			-- sub-window warning
			local subWarning = contentWindowName .. "Warning"

			-- sub-window warning title
			local subWarningLabel = contentWindowName .. "WarningLabel"

			-- does the content window already exist?
			if not DoesWindowExist(contentWindowName) then
			
				-- create the absorb sub-window
				CreateWindowFromTemplate(contentWindowName, "SoulstoneAbsorbTemplate", this)
			end

			-- skill to absorb TID
			local skillTid = gumpData.Labels[5].tid

			-- get the character cap for the skill to absorb
			local currentCap = tonumber(gumpData.LabelsText[2])

			-- get the new skill value
			local newSkillValue = tonumber(gumpData.LabelsText[3])

			-- set the sub-window title
			LabelSetText(contentWindowName .. "Title", GetStringFromTid(374))

			-- set the skill name label
			LabelSetText(contentWindowName .. "SkillLabel", GetStringFromTid(1149921)) -- Skill:

			-- set the skill name
			LabelSetText(contentWindowName .. "SkillName", GetStringFromTid(skillTid))

			-- set the skill current value label
			LabelSetText(contentWindowName .. "CurrValueLabel", GetStringFromTid(1062298))  -- Current Value:

			-- set the skill current value
			LabelSetText(contentWindowName .. "CurrValue", gumpData.LabelsText[1])

			-- set the skill current cap label
			LabelSetText(contentWindowName .. "CurrCapLabel", GetStringFromTid(1062299)) -- Current Cap:

			-- set the skill current cap
			LabelSetText(contentWindowName .. "CurrCap", towstring(currentCap))

			-- set the skill new value label
			LabelSetText(contentWindowName .. "NewValueLabel", GetStringFromTid(1062300)) -- New Value:

			-- set the skill new value
			LabelSetText(contentWindowName .. "NewValue", towstring(newSkillValue))

			-- set the label for the delete skill button
			ButtonSetText(contentWindowName .. "DeleteButton", GetStringFromTid(1077851)) -- DELETE

			-- set the label for the absorb skill button
			ButtonSetText(contentWindowName .. "AbsorbButton", GetStringFromTid(377)) 

			-- set the skill warnings label
			LabelSetText(subWarningLabel, GetStringFromTid(503377)) -- 503377 -- Warnings:

			-- hide the warning label, we'll show it later if there are actual warnings to show
			WindowSetShowing(subWarningLabel, false)

			-- enable the absorb button
			ButtonSetDisabledFlag(contentWindowName .. "AbsorbButton", false)

			-- enable the button input
			WindowSetHandleInput(contentWindowName .. "AbsorbButton", true)

			-- reset the flag that indicates that by absorbing the skill the player might lose other skills
			SoulstoneGump.loseOtherSkills = nil

			-- get the total amount of points that will be absorbed
			local pointsToAbsorb = tonumber(gumpData.LabelsText[3]) - tonumber(gumpData.LabelsText[1])

			-- is the current skill cap less than the new skill value?
			if newSkillValue > currentCap then

				-- show the warning label
				WindowSetShowing(subWarningLabel, true)

				-- the player need to use a power scroll first
				LabelSetText(subWarning, ReplaceTokens(GetStringFromTid(382), {towstring(SoulstoneGump.GetRequiredPS(newSkillValue)), wstring.upper(GetStringFromTid(skillTid))})) 

				-- disable the absorb button
				ButtonSetDisabledFlag(contentWindowName .. "AbsorbButton", true)

				-- disable the button input
				WindowSetHandleInput(contentWindowName .. "AbsorbButton", false)

			-- do we have enough skill points available to absorb the skill?
			elseif (SoulstoneGump.GetSkillCap() + pointsToAbsorb) > 720 then
				
				-- show the warning label
				WindowSetShowing(subWarningLabel, true)

				-- get the skills set to drop
				local downSkills = SoulstoneGump.GetDownSkills(skillTid)

				-- do we have skills set to drop?
				if downSkills ~= L"" then

					-- show the list of the skills that might lose points
					LabelSetText(subWarning, ReplaceTokens(GetStringFromTid(375), {downSkills}) )

					-- flag thta the player may lose other skills if he absorb the skill
					SoulstoneGump.loseOtherSkills = true

				else -- not enough points to absorb
					LabelSetText(subWarning, GetStringFromTid(376)) 

					-- disable the absorb button
					ButtonSetDisabledFlag(contentWindowName .. "AbsorbButton", true)

					-- disable the button input
					WindowSetHandleInput(contentWindowName .. "AbsorbButton", false)
				end
			end

			-- show the soulstone window
			WindowSetShowing(this, true)

		else -- skill store gump

			-- make sure we have the confirm to store the skill already
			if SoulstoneGump.storeSkillConfirm then

				-- reset the confirm flag
				SoulstoneGump.storeSkillConfirm = nil

				-- store the skill to the soulstone
				GumpsParsing.PressButton(GenericGump.SOULSTONE_GUMPID, 3)

				-- destroy this soulstone window
				DestroyWindow(this)
			end
		end

	-- is this the error gump?
	else
		-- if we're here something went wrong, close the gump
		GumpsParsing.PressButton(GenericGump.SOULSTONE_GUMPID, 1)

		-- print the error to chat
		ChatPrint(GetStringFromTid(gumpData.Labels[3].tid), SystemData.ChatLogFilters.SYSTEM)
	end
end

function SoulstoneGump.GetRequiredPS(newValue)

	-- determine the power scroll required for the given skill value
	if newValue >= 120 then
		return 120
	elseif newValue >= 115 then
		return 115
	elseif newValue >= 110 then
		return 110
	elseif newValue >= 105 then
		return 105
	else 
		return newValue
	end
end

function SoulstoneGump.GetSkillCap()
	
	-- total skill points used
	local SkillPointsUsed = 0

	-- scan all the skill
	for i, skillData in pairsByIndex(WindowData.SkillDynamicData) do

		-- increase the total skill points used with the real value of the current skill
		SkillPointsUsed = SkillPointsUsed + skillData.RealSkillValue
	end

	-- the total amount of points is without comma, so we need to divide by 10
	return SkillPointsUsed / 10
end

function SoulstoneGump.GetDownSkills(excludeTid)

	-- table for all the skills set to drop
	local skills = L""

	-- scan all the skill
	for i, skillData in pairsByIndex(WindowData.SkillDynamicData) do

		-- is the skill set to drop?
		if skillData.SkillState == 1 then

			-- get the skill name TID
			local skillNameTid = SoulstoneGump.GetSkillname(i)

			-- is this the skill to exclude? 
			if skillNameTid == excludeTid then
				continue
			end

			-- does the skill has points to lose?
			if skillData.RealSkillValue <= 0 then
				continue
			end

			-- append the skill name to the list
			skills = wstring.appendWithSeparator(skills, GetStringFromTid(skillNameTid), L", ")
		end
	end

	return skills
end

function SoulstoneGump.GetSkillname(serverID)
	
	-- scan all the skills CSV
	for i, skill in pairsByIndex(WindowData.SkillsCSV) do

		-- is this the skill we're looking for?
		if skill.ServerId == serverID then

			return skill.NameTid
		end
	end
end

function SoulstoneGump.GetServerIDForTID(skillTid)

	-- scan all the skills CSV
	for i, skill in pairsByIndex(WindowData.SkillsCSV) do

		-- is this the skill we're looking for?
		if skill.NameTid == skillTid or GetStringFromTid(skill.NameTid) == GetStringFromTid(skillTid) then
		
			return skill.ServerId
		end
	end
end

-- state: 0: UP, 1: DOWN, 2: LOCK
function SoulstoneGump.SetSkillState(skillTid, state)
	
	-- get the server skill ID
	local serverID = SoulstoneGump.GetServerIDForTID(skillTid)

	-- set the new state for the skill
	WindowData.SkillDynamicData[serverID].SkillState = state

	-- set the server skill ID to update
	ReturnWindowData.SkillSystem.SkillId = serverID

	-- set the state to set
	ReturnWindowData.SkillSystem.SkillButtonState = state

	-- process the skill state change
	BroadcastEvent(SystemData.Events.SKILLS_ACTION_SKILL_STATE_CHANGE)
end

function SoulstoneGump.DeleteSkillTooltip()

	-- show the tooltip for skill delete button
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(378))
end

function SoulstoneGump.AbsorbSkillTooltip()

	-- show the tooltip for the absorb skill button
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(379))
end

function SoulstoneGump.DeleteSkill()

	-- un-press the button or it will stay pressed forever
	ButtonSetPressedFlag(SystemData.ActiveWindow.name, false)

	-- create the buttons data
	local OKButton = { textTid = UO_StandardDialog.TID_OKAY, callback = function() SoulstoneGump.DeleteSkillPoints = true GumpsParsing.PressButton(GenericGump.SOULSTONE_GUMPID, 2) end } -- OK
	local cancelButton = { textTid = UO_StandardDialog.TID_CANCEL } -- Cancel

	-- get the skill name and value
	local skillName = GetStringFromTid(SoulstoneGump.currentGumpData.Labels[5].tid) .. L" - " .. SoulstoneGump.currentGumpData.LabelsText[3]

	-- create the dialog data
	local DeleteSkillWindow = 
				{
					windowName = "DeleteSkillDialog",
					body = ReplaceTokens(GetStringFromTid(380), {skillName}),
					titleTid = 381,
					buttons = { OKButton, cancelButton },
					closeCallback = cancelButton.callback,
					passCode = L"DELETE",
					destroyDuplicate = true,
				}

	-- create the vendor dismiss confirm dialog
	UO_StandardDialog.CreateDialog(DeleteSkillWindow)
end

function SoulstoneGump.AbsorbSkill()
	
	-- get the current skill TID
	local skillTid = SoulstoneGump.currentGumpData.Labels[5].tid

	-- does the player risk to lose other skills by absorbing this one?
	if SoulstoneGump.loseOtherSkills then

		-- create the buttons data
		local OKButton = { textTid = UO_StandardDialog.TID_OKAY, callback = function() SoulstoneGump.loseOtherSkills = nil SoulstoneGump.SetSkillState(skillTid, 0) Interface.AddTodoList({name = "Soulstone absorb delayed button press", func = function() GumpsParsing.PressButton(GenericGump.SOULSTONE_GUMPID, 3) end, time = Interface.TimeSinceLogin + 0.5}) end } -- OK
		local cancelButton = { textTid = UO_StandardDialog.TID_CANCEL } -- Cancel

		-- get the skill name and value
		local skillName = GetStringFromTid(skillTid) .. L" - " .. SoulstoneGump.currentGumpData.LabelsText[3]

		-- create the dialog data
		local AbsorbSkilWindow = 
					{
						windowName = "AbsorbSkillDialog",
						body = ReplaceTokens(GetStringFromTid(383), {skillName}),
						titleTid = 374,
						buttons = { OKButton, cancelButton },
						closeCallback = cancelButton.callback,
						passCode = L"ABSORB AND DROP",
						destroyDuplicate = true,
					}

		-- create the vendor dismiss confirm dialog
		UO_StandardDialog.CreateDialog(AbsorbSkilWindow)

	else -- no risk of losing other skills, we can absorb the points.

		-- set the skill state to UP
		SoulstoneGump.SetSkillState(skillTid, 0)

		-- absorb the skill (delayed so there is time to update the skill state to UP)
		Interface.AddTodoList({name = "soulstone absorb delayed button press", func = function() GumpsParsing.PressButton(GenericGump.SOULSTONE_GUMPID, 3) end, time = Interface.TimeSinceLogin + 0.5})
	end
end

function SoulstoneGump.SkillHighlight()
	
	-- set the text to green
	LabelSetTextColor(SystemData.ActiveWindow.name, 0, 255, 0)
end

function SoulstoneGump.SkillUnhighlight()

	-- set the text to light blue
	LabelSetTextColor(SystemData.ActiveWindow.name, 0, 153, 255)
end

function SoulstoneGump.StoreSkill()

	-- current label name
	local this = SystemData.ActiveWindow.name

	-- get the button ID
	local buttonID = WindowGetId(this)

	-- skill tid for the button
	local skillTid = SoulstoneGump.currentGumpData.Labels[buttonID + 1].tid

	-- create the buttons data
	local OKButton = { textTid = UO_StandardDialog.TID_OKAY, callback = function() SoulstoneGump.storeSkillConfirm = true SoulstoneGump.SetSkillState(skillTid, 1) Interface.AddTodoList({name = "soulstone store delayed button press", func = function() GumpsParsing.PressButton(GenericGump.SOULSTONE_GUMPID, buttonID) end, time = Interface.TimeSinceLogin + 0.5}) end } -- OK
	local cancelButton = { textTid = UO_StandardDialog.TID_CANCEL } -- Cancel

	-- get the skill name and value
	local skillName = LabelGetText(this)

	-- create the dialog data
	local StoreSkillWindow = 
				{
					windowName = "StoreSkillDialog",
					body = ReplaceTokens(GetStringFromTid(385), {skillName}),
					titleTid = 384,
					buttons = { OKButton, cancelButton },
					closeCallback = cancelButton.callback,
					destroyDuplicate = true,
				}

	-- create the vendor dismiss confirm dialog
	UO_StandardDialog.CreateDialog(StoreSkillWindow)
end

function SoulstoneGump.ToggleGump()

	-- toggle the soulstone gump visibility
	GumpsParsing.ToShow[GenericGump.SOULSTONE_GUMPID] = not GumpsParsing.ToShow[GenericGump.SOULSTONE_GUMPID]
end