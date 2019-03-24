----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

SkillsWindow2 = { }
SkillsWindow2.skillList = {}
SkillsWindow2.maxskill_index = 57

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

local currentTab = "TabAll"


-- OnInitialize Handler
function SkillsWindow2.Initialize()
	Debug.Print(L"SkillsWindow2.Initialize")
	LabelSetText("a", L"werwewre")
--	if SkillsWindowInitialized == 1 then
		--Debug.PrintToDebugConsole(L"SkillsWindow.Initialize: already initialized, returning")
	--	return
	--end

	UOBuildTableFromCSV ("data/gamedata/skilldata.csv","SkillsCSV")

	
	this = "SkillsWindow2"
	
    --SkillsWindow.SkillCapMode = (SystemData.Settings.Interface.SkillsWindowShowCaps and 1 or 0)
    --SkillsWindow.SkillDataMode = (SystemData.Settings.Interface.SkillsWindowShowModified and 1 or 0)
	
	local id = SystemData.DynamicWindowId
	WindowSetId(this, id)

	if(WindowData.SkillsWindow ~= nil) then
		data = WindowData.SkillsWindow[id]
	end
	
	-- Register each of the skills
	-- TODO: Register for the skills list first and use that instead of magic numbers
	
	-- CJT - don't attempt to update the window draws while we register for all of the skills
	--updateOff = 1
	for i=0,SkillsWindow2.maxskill_index do  
			RegisterWindowData(WindowData.SkillDynamicData.Type, i)
	end
	updateOff = 0
	
	RegisterWindowData(WindowData.SkillList.Type,0)
	
	--WindowRegisterEventHandler( this, WindowData.SkillDynamicData.Event, "SkillsWindow.UpdateSkill")

	SkillsWindow2.skillList = SkillsWindow2.BuildTable()

	SkillsWindow2.CreateWindows()
	SkillsWindow2.ShowWindows()

end

function SkillsWindow2.CreateWindows()
	for i = 1, #SkillsWindow2.skillList do
		CreateWindowFromTemplate("SkillTemplate"..i, "SkillTemplate", "SkillsScrollWindowScrollChild")
		WindowSetId("SkillTemplate"..i, i)
		WindowSetId("SkillTemplate"..i.."Button", i)
		WindowSetId("SkillTemplate"..i.."Lock", i)
		WindowSetId("SkillTemplate"..i.."Up", i)
		WindowSetId("SkillTemplate"..i.."Down", i)
		LabelSetText("SkillTemplate"..i.."SkillName", SkillsWindow2.skillList[i].Name)
		LabelSetText("SkillTemplate"..i.."SkillValue", towstring(string.format("%.1f", (SkillsWindow2.skillList[i].RealValue/10))))
		WindowSetDimensions("SkillTemplate"..i.."ProgressBarEmpty", (SkillsWindow2.skillList[i].Cap/10)*2, 14)
		WindowSetDimensions("SkillTemplate"..i.."ProgressBarFilled", (SkillsWindow2.skillList[i].RealValue/10)*2, 14)
			
		local iconTexture, x, y = GetIconData(SkillsWindow2.skillList[i].IconId)
		DynamicImageSetTexture("SkillTemplate"..i.."ButtonIcon", iconTexture, x, y)
	
		-- highlight the correct state button.
		SkillsWindow2.ChangeSkillStateSelection(i, SkillsWindow2.skillList[i].State)
		
	end
end

function SkillsWindow2.ShowWindows()

	local lastShownId = 0
	local show
	for i = 1, #SkillsWindow2.skillList do
		
		WindowSetShowing("SkillTemplate"..i, false)
		WindowClearAnchors("SkillTemplate"..i)

		show = false
		if currentTab == "TabAll" then
			show = true
		elseif currentTab == "TabUsed" then
			if SkillsWindow2.skillList[i].RealValue > 0 then
				show = true
			end
		end

		if show then
			WindowSetShowing("SkillTemplate"..i, true)
			
			if not lastShownId then
				WindowAddAnchor("SkillTemplate"..i, "topleft", "SkillsScrollWindowScrollChild", "topleft", 10, 0)
			else
				WindowAddAnchor("SkillTemplate"..i, "bottomleft", "SkillTemplate"..(lastShownId), "topleft", 0, 0)
			end

			lastShownId = i
		end

	end

	ScrollWindowUpdateScrollRect("SkillsScrollWindow")

end


function SkillsWindow2.Show()
	WindowSetShowing("SkillsWindow2", true);
end

function SkillsWindow2.Lock()
--Debug.Print(SystemData.Text)
--Debug.Print(SystemData.TextEntryUnicodeId)
--Debug.Print(SystemData.TextEntryUnicodeCode)

	local skillId = WindowGetId(SystemData.ActiveWindow.name)
	SkillsWindow2.ChangeSkillState(skillId, 2)
	SkillsWindow2.ChangeSkillStateSelection(skillId, 2)
end

function SkillsWindow2.Up()
	local skillId = WindowGetId(SystemData.ActiveWindow.name)
	SkillsWindow2.ChangeSkillState(skillId, 0)
	SkillsWindow2.ChangeSkillStateSelection(skillId, 0)
end

function SkillsWindow2.Down()
	local skillId = WindowGetId(SystemData.ActiveWindow.name)
	SkillsWindow2.ChangeSkillState(skillId, 1)
	SkillsWindow2.ChangeSkillStateSelection(skillId, 1)
end

function SkillsWindow2.ChangeSkillState(skillId, state)

	ReturnWindowData.SkillSystem.SkillId = SkillsWindow2.skillList[skillId].ServerId
	ReturnWindowData.SkillSystem.SkillButtonState = state
	BroadcastEvent (SystemData.Events.SKILLS_ACTION_SKILL_STATE_CHANGE)
end

function SkillsWindow2.TabChange()
	Debug.Print("SkillsWindow2.TabChange")
	Debug.Print(SystemData.ActiveWindow.name)
	currentTab = SystemData.ActiveWindow.name

	SkillsWindow2.ShowWindows()

end


function SkillsWindow2.ChangeSkillStateSelection(skillId, state)

	WindowSetTintColor("SkillTemplate"..skillId.."Lock", 255,255,255)
	WindowSetTintColor("SkillTemplate"..skillId.."Up", 255,255,255)
	WindowSetTintColor("SkillTemplate"..skillId.."Down", 255,255,255)
	if state == 0 then
		WindowSetTintColor("SkillTemplate"..skillId.."Up", 200,200,200)
	elseif state == 1 then
		WindowSetTintColor("SkillTemplate"..skillId.."Down", 200,200,200)
	else
		WindowSetTintColor("SkillTemplate"..skillId.."Lock", 200,200,200)
	end

end

function SkillsWindow2.Dump()
	Debug.Print(L"SkillsWindow2.Dump")
	Debug.Print(SkillsWindow2.BuildTable())
end


function SkillsWindow2.BuildTable()

	local skillList = {}
	for i = 1, #WindowData.SkillsCSV do
		
		local skill = WindowData.SkillsCSV[i]
		local value = WindowData.SkillDynamicData[skill.ServerId]
		local item = { 
			Name = skill.SkillName, 
			TempValue = value.TempSkillValue,
			RealValue = value.RealSkillValue,
			Cap = value.SkillCap,
			State = value.SkillState,
			Entitlement = skill.Entitlement,
			IconId = skill.IconId,
			DragIcon = skill.DragIcon,
			DescriptionTid = skill.DescriptionTid,
			ServerId = skill.ServerId
			}
		table.insert(skillList, item)
	end

	return skillList
end

function SkillsWindow2.SkillLButtonUp()
	-- Player is using a skill by single clicking on an icon

	--Debug.PrintToDebugConsole(L"SkillsWindow.SkillLButtonUp()")
	--Debug.PrintToDebugConsole(L"SkillsWindow.SkillLButtonUp(): window name = "..StringToWString(SystemData.ActiveWindow.name))

	local buttonNum = WindowGetId(SystemData.ActiveWindow.name)
	--Debug.PrintToDebugConsole(L"SkillsWindow.SkillLButtonUp(): button = "..StringToWString(tostring(buttonNum)))

	-- button number is its location on the screen (1 = top of left column, 2 = 2nd in left column, etc with left column done first before starting through the right column)

	--local tab = data.activeTab
	--Debug.PrintToDebugConsole(L"SkillsWindow.SkillLButtonDown(): window name = "..StringToWString(SystemData.ActiveWindow.name))
	--local activeContent = tabContents[tab]
	-- skillIndex is the line index in the csv file for this skill
	--local skillIndex = activeContent[buttonNum]
	Debug.Print(SystemData.ActiveWindow.name)
	local skillId = WindowGetId(SystemData.ActiveWindow.name)
	--local skillId = SkillsWindow2.skillList[skillId].ServerId

	--Debug.PrintToDebugConsole(L"SkillsWindow.SkillLButtonDown(): tab = "..StringToWString(tostring(tab)))
	--Debug.PrintToDebugConsole(L"SkillsWindow.SkillLButtonDown(): skillIndex = "..StringToWString(tostring(skillIndex)))
	--Debug.PrintToDebugConsole(L"SkillsWindow.SkillLButtonDown(): skillId = "..StringToWString(tostring(skillId)))
	
	-- if the skill icon is not dragable, then it can't be directly used
	if (SkillsWindow2.skillList[skillId].DragIcon == 1) then
		SkillsWindow2.UseSkill (SkillsWindow2.skillList[skillId].ServerId)
	else
	    PrintTidToChatWindow(500014,SystemData.ChatLogFilters.SYSTEM)
	end		
end

function SkillsWindow2.UseSkill (skillId)

	-- skillId is the server id for the skill
	--Debug.PrintToDebugConsole(L"SkillsWindow.UseSkill(): serverId = "..StringToWString(tostring(skillId)))
	
	UserActionUseSkill(skillId)
end

function SkillsWindow2.Fuu()
--local skillId = WindowGetId(SystemData.ActiveWindow.name)
WindowSetTintColor("y", 255,0,0)
--Debug.Print(WindowGetLayer("SkillTemplate"..skillId.."LockIcon"))
end

function SkillsWindow2.Hover()
local skillId = WindowGetId(SystemData.ActiveWindow.name)
--WindowSetTintColor("SkillTemplate"..skillId.."LockIcon", 255,0,0)
--Debug.Print(WindowGetLayer("SkillTemplate"..skillId.."LockIcon"))
end


function SkillsWindow2.HoverEnd()
local skillId = WindowGetId(SystemData.ActiveWindow.name)
--WindowSetTintColor("SkillTemplate"..skillId.."LockIcon", 0,255,0)
end
