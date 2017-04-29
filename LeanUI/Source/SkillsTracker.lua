----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

SkillsTracker = { }

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

local createdSkillTrackers = {}

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function SkillsTracker.Initialize()
	WindowRegisterEventHandler( this, WindowData.SkillDynamicData.Event, "SkillsTracker.UpdateSkill")
	LabelSetText("SkillsTrackerWindowInfoText", GetStringFromTid(1111939))
	WindowSetShowing("SkillsTrackerWindowDragHandle", false)
	WindowUtils.RestoreWindowPosition("SkillsTrackerWindow")
	SkillsTracker.Update()
end

function SkillsTracker.Shutdown()
	createdSkillTrackers = {}
	
	WindowUnregisterEventHandler(this, WindowData.SkillDynamicData.Event)
	
	WindowUtils.SaveWindowPosition("SkillsTrackerWindow")
end

function SkillsTracker.Update()
	-- Destroy the existing skill trackers
	for i=1, table.getn(createdSkillTrackers) do
		local serverId = createdSkillTrackers[i]
		local skillWindowName = "SkillsTrackerSkill"..serverId
		
		DestroyWindow(skillWindowName)
	end
	createdSkillTrackers = {}

	-- Create new skill trackers
	local customSkills = SystemData.Settings.Interface.CustomSkills
	local numCustomSkills = table.getn(customSkills)

	for i=1,numCustomSkills do
		local skillId = customSkills[i]
		local serverId = WindowData.SkillsCSV[skillId].ServerId
	
		local skillWindowName = "SkillsTrackerSkill"..serverId
		CreateWindowFromTemplate( skillWindowName, "SkillsTrackerSkillTemplate", "SkillsTrackerWindow" )
		
		createdSkillTrackers[i] = serverId
		
		-- reanchor window
		WindowClearAnchors(skillWindowName)
		if (i==1) then
         	WindowAddAnchor( skillWindowName, "bottomright", "SkillsTrackerWindowDragHandle", "topright", 0, 3)
		else
			local previousId = WindowData.SkillsCSV[customSkills[i-1]].ServerId
        	WindowAddAnchor( skillWindowName, "bottomright", "SkillsTrackerSkill"..previousId, "topright", 0, 3)
		end
	
		local displayName = GetStringFromTid(WindowData.SkillsCSV[skillId].NameTid)	
		LabelSetText(skillWindowName.."Name", displayName)
		
		SkillsTracker.UpdateSkill(serverId)
	end
	
	if (numCustomSkills == 0) then
		WindowSetShowing("SkillsTrackerWindowInfoText", true)
	else
		WindowSetShowing("SkillsTrackerWindowInfoText", false)
	end
end

function SkillsTracker.UpdateSkill(index)
	local serverId = index
	if (serverId == nil) then
		serverId = WindowData.UpdateInstanceId
	end
	local skillWindowName = "SkillsTrackerSkill"..serverId
	
	if( not DoesWindowNameExist(skillWindowName) ) then
		return
	end
	
	local skillLevel = nil
	if (SkillsWindow.SkillDataMode == 0) then
		skillLevel = WindowData.SkillDynamicData[serverId].RealSkillValue
	else
		skillLevel = WindowData.SkillDynamicData[serverId].TempSkillValue
	end
	
	local skillLevelCap = WindowData.SkillDynamicData[serverId].SkillCap
	
	-- Clean up the number so it works as a percentage
	local skillFormatted = SkillsWindow.FormatSkillValue(skillLevel)
	
	local value = L""
	if (SkillsWindow.SkillCapMode == 0) then
		if skillLevel ~= nil then
			value = skillFormatted
		else
			value = L"---.-"
		end	
	else	
		local capFormatted = SkillsWindow.FormatSkillValue(skillLevelCap)
		if skillLevel ~= nil then
			value = skillFormatted..L"/"..capFormatted
		else
			value = L"---.-/---.-"
			
		end
	end
	LabelSetText(skillWindowName.."Value", value)
end


function SkillsTracker.OnMouseOver()
	WindowSetShowing("SkillsTrackerWindowDragHandle", true)
end

function SkillsTracker.OnMouseLeave()
	WindowSetShowing("SkillsTrackerWindowDragHandle", false)
end
