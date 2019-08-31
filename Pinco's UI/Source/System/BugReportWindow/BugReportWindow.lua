----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

BugReportWindow = {}

BugReportWindow.NUM_MACROS = 12
BugReportWindow.NUM_MACRO_ICONS = 18
BugReportWindow.MACRO_ICONS_ID_BASE = 200

BugReportWindow.activeId = 1
BugReportWindow.iconNum = 0

BugReportWindow.bugTypes = {}
BugReportWindow.bugTypes.BUG_WORLD			= 1
BugReportWindow.bugTypes.BUG_WEARABLES		= 2
BugReportWindow.bugTypes.BUG_COMBAT			= 3
BugReportWindow.bugTypes.BUG_UI				= 4
BugReportWindow.bugTypes.BUG_CRASH			= 5
BugReportWindow.bugTypes.BUG_STUCK			= 6
BugReportWindow.bugTypes.BUG_ANIMATIONS		= 7
BugReportWindow.bugTypes.BUG_PERFORMANCE	= 8
BugReportWindow.bugTypes.BUG_NPCS			= 9
BugReportWindow.bugTypes.BUG_CREATURES		= 10
BugReportWindow.bugTypes.BUG_PETS			= 11
BugReportWindow.bugTypes.BUG_HOUSING		= 12
BugReportWindow.bugTypes.BUG_LOST_ITEM		= 13
BugReportWindow.bugTypes.BUG_EXPLOIT		= 14
BugReportWindow.bugTypes.BUG_OTHER			= 15

BugReportWindow.Size = 15
BugReportWindow.selectedType = BugReportWindow.bugTypes.BUG_OTHER
						
					--Bug Report, Submit, Clear, Select Bug Type, Please enter description of Bug, Your bug has been sent.
BugReportWindow.TID = {Bug = 1077790, Submit = 1077787, Clear = 3000154, Select = 1077788, Description = 1077789, Sent = 1077901}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

----------------------------------------------------------------
-- BugReportWindow Functions
----------------------------------------------------------------

-- OnInitialize Handler
function BugReportWindow.Initialize()       
	
    RegisterWindowData(WindowData.BugReport.Type,0)
    
    -- Label Text

    WindowUtils.SetWindowTitle("BugReportWindow", GetStringFromTid(BugReportWindow.TID.Bug) )

	ButtonSetText( "BugReportWindowReportSubmit", GetStringFromTid(BugReportWindow.TID.Submit) )
	ButtonSetText( "BugReportWindowReportClear", GetStringFromTid(BugReportWindow.TID.Clear) )

	LabelSetText( "BugReportTypesLabel", GetStringFromTid(BugReportWindow.TID.Select) )
    LabelSetText( "BugReportWindowLabel", GetStringFromTid(195) )

	for i = 1, BugReportWindow.Size  do
		if i == BugReportWindow.bugTypes.BUG_UI	 then
			LabelSetText("BugReportType"..i.."Label", L"Pinco's UI" )
		else
			LabelSetText("BugReportType"..i.."Label", WindowData.BugReport[i].flagName )
		end
        ButtonSetStayDownFlag( "BugReportType"..i.."Button", true )
		
	end
        
    BugReportWindow.OnClear()
end

-- OnUpdate Handler
function BugReportWindow.Update( timePassed )
end

-- OnShutdown Handler
function BugReportWindow.Shutdown()
	UnregisterWindowData(WindowData.BugReport.Type,0)
end


function BugReportWindow.Hide()
    ToggleWindowByName( "BugReportWindow", BugReportWindow.OnOpen, BugReportWindow.OnClose )
end

function BugReportWindow.OnOpen()
	BugReportWindow.SelectBugType( BugReportWindow.bugTypes.BUG_UI	 )
    WindowAssignFocus( "BugReportText", true )
end

function BugReportWindow.OnClose()
    WindowAssignFocus( "BugReportText", false )
end

function BugReportWindow.OnSelectBugType()
    local type = WindowGetId(SystemData.ActiveWindow.name) 
    BugReportWindow.SelectBugType( type )
end

function BugReportWindow.SelectBugType( type )
    BugReportWindow.selectedType = type

    for index = 1, BugReportWindow.Size  do
        ButtonSetPressedFlag( "BugReportType"..index.."Button", BugReportWindow.selectedType == index )
    end
    if BugReportWindow.selectedType == BugReportWindow.bugTypes.BUG_UI	 then
		 LabelSetText( "BugReportWindowLabel", GetStringFromTid(195) .. GetStringFromTid(194) )
		 WindowSetDimensions("BugReportWindow", 640, 660)
    else
		 LabelSetText( "BugReportWindowLabel", GetStringFromTid(286) )
		 WindowSetDimensions("BugReportWindow", 640, 570)
    end
end

function BugReportWindow.TextChange()
	local x,y = WindowGetDimensions("BugReportText")
	WindowSetDimensions("BugReportChildTXT", x, y)
	ScrollWindowUpdateScrollRect( "BugReportScrollW" )
end


function BugReportWindow.OnSubmit() 
    --Debug.PrintToDebugConsole(L"Reporting Bug: Type="..BugReportWindow.selectedType..L", Text="..BugReportText.Text )
    if BugReportWindow.selectedType == BugReportWindow.bugTypes.BUG_UI	 then
		BugReportWindow.SendBugReportUI(BugReportText.Text)
    else
		SendBugReport( BugReportWindow.selectedType, BugReportText.Text )
	end
	
    BugReportWindow.OnClear()
	BugReportWindow.Hide()
	
	local bugWindow =
	{
		titleTid = BugReportWindow.TID.Bug,  --"Bug Report"
		bodyTid = BugReportWindow.TID.Sent,	--"Your bug has been sent"
		windowName = "BugReportWindow",
		destroyDuplicate = true,
	}
			
	UO_StandardDialog.CreateDialog(bugWindow)
   
end

function BugReportWindow.OnClear()
--     Debug.PrintToDebugConsole(L"PLayer has press Onclear" )
     TextEditBoxSetText( "BugReportText", L"" )
end

function BugReportWindow.SendBugReportUI(text)
	--[[
	TextLogCreate("bugreport", 1)
	TextLogSetEnabled("bugreport", true)
	TextLogClear("bugreport")
	TextLogSetIncrementalSaving( "bugreport", true, "logs/bugreport.log")
	TextLogAddEntry("bugreport", 1,towstring(text))
	TextLogDestroy("bugreport")
	--]]
	local body = wstring.gsub(text, L" ", L"+")
	Interface.WebCall(L"mailto:pincoui.bugreport@guain.it?subject=Bug+Report&body=" .. body)
end