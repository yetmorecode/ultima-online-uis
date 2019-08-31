
----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

DebugWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

-- Channel Id's.. These will be moved to code-generated variables soon.

local LuaLog            = {}
LuaLog.SYSTEM           = 1
LuaLog.ERROR            = 2
LuaLog.DEBUG            = 3
LuaLog.FUNCTION         = 4

local InterfaceLog      = {}
InterfaceLog.DEBUG      = 1
InterfaceLog.WARNING    = 2
InterfaceLog.ERROR      = 3

DebugWindow.logging = false

----------------------------------------------------------------
-- DebugWindow Functions
----------------------------------------------------------------

-- OnInitialize Handler
function DebugWindow.Initialize()
	
	WindowSetDrawWhenInterfaceHidden("DebugWindow", true)
	CreateWindow("DebugWindowOptions",false)
	
	WindowUtils.SetWindowTitle("DebugWindow", L"Debug Window")

    -- Display Settings
    LogDisplaySetShowTimestamp( "DebugWindowText", false )
    LogDisplaySetShowLogName( "DebugWindowText", true )
    LogDisplaySetShowFilterName( "DebugWindowText", true )

     -- Add the Lua Log
    LogDisplayAddLog("DebugWindowText", "UiLog", true)
    
    LogDisplaySetFilterColor("DebugWindowText", "UiLog", LuaLog.SYSTEM, 255, 0, 255 ) -- Magenta
    LogDisplaySetFilterColor("DebugWindowText", "UiLog", LuaLog.ERROR, 255, 0, 0 ) -- Red
    LogDisplaySetFilterColor("DebugWindowText", "UiLog", LuaLog.DEBUG, 255, 255, 0 ) -- Yellow
    LogDisplaySetFilterColor("DebugWindowText", "UiLog", LuaLog.FUNCTION, 0, 175, 50 ) -- Green
    LogDisplaySetFilterColor("DebugWindowText", "UiLog", LuaLog.WARNING, 0, 175, 50 ) -- Green
    
    ButtonSetText("DebugWindowReloadUi", L"Reload UI")
    
    -- enable the logging
    DebugWindow.logging = TextLogGetEnabled( "UiLog" )
    ButtonSetPressedFlag( "DebugWindowToggleLoggingButton", DebugWindow.logging )

    WindowSetAlpha("DebugWindow", 0.75)
    
    -- Load settings
    WindowSetShowing("DebugWindow", DevData.DebugWindow.isShowing )
    WindowClearAnchors("DebugWindow")
    WindowAddAnchor("DebugWindow", "topleft", "Root", "topleft", DevData.DebugWindow.screenPos.x, DevData.DebugWindow.screenPos.y )

	-- Options		
	LabelSetText( "DebugWindowToggleOptionsLabel", L"Show Options" )
	LabelSetText( "DebugWindowToggleLoggingLabel", L"Enable Logging" )
	LabelSetText( "DebugWindowToggleGExplorerLabel", L"Enable Class Viewer" )
	LabelSetText( "DebugWindowToggleDataLoggerLabel", L"Enable Data Logger" )
	
	WindowUtils.SetWindowTitle( "DebugWindow", L"Debug Log")
	
	
	LabelSetText(  "DebugWindowOptionsFiltersTitle", L"Logging Filters:" )
	LabelSetText(  "DebugWindowOptionsFilterType1Label", L"Ui System Messages" )
	LabelSetText(  "DebugWindowOptionsFilterType2Label", L"Error Messages" )
	LabelSetText(  "DebugWindowOptionsFilterType3Label", L"Debug Messages" )
	LabelSetText(  "DebugWindowOptionsFilterType4Label", L"Warning Messages" )
	LabelSetText(  "DebugWindowOptionsFilterType5Label", L"Function Calls Messages" )
	-- These dont seem to do anything
	--LabelSetText(  "DebugWindowOptionsFilterType6Label", L"Update Spam" )
	--LabelSetText(  "DebugWindowOptionsFilterType7Label", L"Mouse Movement Spam" )
	
	for index = 1, 5 do
		if (index ~= 2) then
			ButtonSetStayDownFlag( "DebugWindowOptionsFilterType"..index.."Button", true )
			
			LogDisplaySetFilterState( "DebugWindowText", "UiLog", index, DevData.DebugWindow.luaFilters[index] )
			ButtonSetPressedFlag( "DebugWindowOptionsFilterType"..index.."Button", DevData.DebugWindow.luaFilters[index] )
		else
			ButtonSetStayDownFlag( "DebugWindowOptionsFilterType"..index.."Button", false )
			
			LogDisplaySetFilterState( "DebugWindowText", "UiLog", index, false )
			ButtonSetPressedFlag( "DebugWindowOptionsFilterType"..index.."Button", false )		
		end	
	end
	
	LabelSetText(  "DebugWindowOptionsErrorHandlingTitle", L"Generate lua-errors from:" )
	LabelSetText(  "DebugWindowOptionsErrorOption1Label", L"Lua calls to ERROR()" )
	LabelSetText(  "DebugWindowOptionsErrorOption2Label", L"Errors in lua calls to C" )
	
	for index = 1, 2 do
		ButtonSetStayDownFlag( "DebugWindowOptionsErrorOption"..index.."Button", true )
	end
	ButtonSetPressedFlag( "DebugWindowOptionsErrorOption1Button", DevData.useDevErrorHandling  )	
	ButtonSetPressedFlag( "DebugWindowOptionsErrorOption2Button", GetUseLuaErrorHandling() )	
	
	
	LabelSetText(  "DebugWindowOptionsLuaDebugLibraryLabel", L"Load Lua Debug Library" )
	ButtonSetPressedFlag( "DebugWindowOptionsLuaDebugLibraryButton", GetLoadLuaDebugLibrary() )
	
	WindowSetShowing("DebugWindowOptions", false )
	
	WindowSetShowing("DebugWindowOptionsChrome_UO_WindowCloseButton", false )
	WindowSetShowing("DebugWindowOptionsChrome_UO_TitleBar", false )
	
	-- does the searchbox exist?
	if not DoesWindowExist("DebugWindowDataLogger") then

		-- create the data logger window
		CreateWindowFromTemplate("DebugWindowDataLogger", "DebugWindowDataLogger", "Root")

		-- reset the data logger anchors
		WindowClearAnchors("DebugWindowDataLogger")

		-- anchor the data logger to the topleft and bottomleft of the debug window so it will resize in height with the debug window
		WindowAddAnchor("DebugWindowDataLogger", "topleft", "DebugWindow", "topright", 5, 0)
		WindowAddAnchor("DebugWindowDataLogger", "bottomleft", "DebugWindow", "bottomright", 5, 0)
	end

	WindowSetShowing("DebugWindowDataLogger", false)

	ButtonSetPressedFlag( "DebugWindowToggleDataLoggerButton", WindowGetShowing("DebugWindowDataLogger") )
end

-- OnShutdown Handler
function DebugWindow.Shutdown()
	-- Save the settings across reloads
	DevData.DebugWindow.isShowing = WindowGetShowing("DebugWindow")
	DevData.DebugWindow.screenPos.x, DevData.DebugWindow.screenPos.y = WindowGetOffsetFromParent("DebugWindow")
	DevData.DebugWindow.size.x, DevData.DebugWindow.size.y = WindowGetDimensions("DebugWindow")
end

function DebugWindow.ToggleLogging()

     if DebugWindow.logging == true then
        Debug.Print( L"Logging OFF")
    end
	
    DebugWindow.logging = not DebugWindow.logging
	
	ButtonSetPressedFlag( "DebugWindowToggleLoggingButton", DebugWindow.logging )

	if Interface.DebugMode then
		TextLogSetIncrementalSaving("UiLog", DebugWindow.logging, "logs/lua[" .. GetClockString() .. "].log")
	end

	TextLogSetEnabled( "UiLog", DebugWindow.logging )
    	
	if DebugWindow.logging == true then
		Debug.Print( L"Logging ON")
    end
end

function DebugWindow.ToggleGExplorer()
	ToggleWindowByName("GExplorerWindow", "DebugWindowToggleGExplorerButton", GExplorer.Reset)
end

function DebugWindow.ToggleDataLogger()
	ToggleWindowByName("DebugWindowDataLogger", "DebugWindowToggleDataLoggerButton")
end

function DebugWindow.OnResizeBegin()
    WindowUtils.BeginResize( "DebugWindow", "topleft", 300, 200, false, nil)
end

--- Options Window

function DebugWindow.ToggleOptions()
	local showing = WindowGetShowing( "DebugWindowOptions" )
	WindowSetShowing("DebugWindowOptions", not showing )
	
	ButtonSetPressedFlag( "DebugWindowToggleOptionsButton", not showing )
	WindowSetShowing("DebugWindowOptions", not showing )
end

function DebugWindow.UpdateDisplayFilter()

	local filterId = WindowGetId(SystemData.ActiveWindow.name)
	
	DevData.DebugWindow.luaFilters[filterId] = not DevData.DebugWindow.luaFilters[filterId]
	
	ButtonSetPressedFlag( "DebugWindowOptionsFilterType"..filterId.."Button", DevData.DebugWindow.luaFilters[filterId] )
	LogDisplaySetFilterState( "DebugWindowText", "UiLog", filterId, DevData.DebugWindow.luaFilters[filterId] )

end

function DebugWindow.UpdateLuaErrorHandling()

	DevData.useDevErrorHandling = not DevData.useDevErrorHandling ;
	ButtonSetPressedFlag( "DebugWindowOptionsErrorOption1Button", DevData.useDevErrorHandling  )	
end

function DebugWindow.UpdateCodeErrorHandling()
	local enabled = GetUseLuaErrorHandling()
	enabled = not enabled
	
	SetUseLuaErrorHandling( enabled )
	ButtonSetPressedFlag( "DebugWindowOptionsErrorOption2Button", enabled )
end

function DebugWindow.UpdateLoadLuaDebugLibrary()
	local enabled = GetLoadLuaDebugLibrary()
	enabled = not enabled

	SetLoadLuaDebugLibrary( enabled )
	ButtonSetPressedFlag( "DebugWindowOptionsLuaDebugLibraryButton", enabled )
end

function DebugWindow.ReloadUIHover()
	Tooltips.CreateTextOnlyTooltip("DebugWindowReloadUi", towstring("Reload UI"))
end

function DebugWindow.UpdateData()

	-- initialize the data logger
	DebugWindow.InitializeData()

	-- update the data logger data
	DebugWindow.UpdateAllData()
end

function DebugWindow.InitializeData()

	-- has the data logger been initialized?
	if not DebugWindow.DataLogInitialized then
		
		-- count the created rows
		local rows = 0

		-- previous row name
		local prevRow

		-- data logger window
		local mainLogWindow = "DataLoggerScrollWindowScrollChild"

		-- create the data logger log row
		CreateWindowFromTemplate(mainLogWindow .. "Name", "SubSectionLabelTemplate", mainLogWindow)
		
		-- set the name for the attribute
		LabelSetText(mainLogWindow .. "NameLabel", L"WindowData Logging\nClick to print. CTRL + Click to target.")

		-- clear the title anchors
		WindowClearAnchors(mainLogWindow .. "Name")

		-- anchor to the top-left
		WindowAddAnchor(mainLogWindow .. "Name", "topleft", mainLogWindow, "topleft", 25, 5)

		-- scan all the window data
		for name, data in pairs(WindowData) do

			-- is this a table?
			if type(data) == "table" then

				-- is this a valid window data type?
				if data.Type and Debug.DataLoggerAllowedType(data.Type) then

					-- increase the rows count
					rows = rows + 1
					
					-- current row name
					local currRow = mainLogWindow .. name

					-- create the data logger log row
					CreateWindowFromTemplate(currRow, "LogDataTemplate", mainLogWindow)

					-- set the name for the attribute
					LabelSetText(currRow .. "AttributeName", towstring(name))

					-- reset the current anchors
					WindowClearAnchors(currRow)

					-- set the window data type to the row
					WindowSetId(currRow, data.Type)

					-- is this the first row?
					if rows == 1 then

						-- anchor to the top-left
						WindowAddAnchor(currRow, "topleft", mainLogWindow, "topleft", 10, 45)
					else

						-- anchor to the previous element
						WindowAddAnchor(currRow, "bottomleft", prevRow, "topleft", 0, 0)
					end

					-- store the previous element
					prevRow = currRow
				end
			end
		end

		-- current row name
		local currRow = mainLogWindow .. "TODOList"

		-- create the data logger log row
		CreateWindowFromTemplate(currRow, "LogDataTemplate", mainLogWindow)

		-- set the name for the attribute
		LabelSetText(currRow .. "AttributeName", L"TODO List")

		-- set the todo list type
		WindowSetId(currRow, 900)

		-- reset the current anchors
		WindowClearAnchors(currRow)

		-- anchor to the previous element
		WindowAddAnchor(currRow, "bottomleft", prevRow, "topleft", 0, 0)

		-- store the previous element
		prevRow = currRow

		-- current row name
		currRow = mainLogWindow .. "CustomEventss"

		-- create the data logger log row
		CreateWindowFromTemplate(currRow, "LogDataTemplate", mainLogWindow)

		-- set the name for the attribute
		LabelSetText(currRow .. "AttributeName", L"Custom Events")

		-- set the custom events list type
		WindowSetId(currRow, 901)

		-- reset the current anchors
		WindowClearAnchors(currRow)

		-- anchor to the previous element
		WindowAddAnchor(currRow, "bottomleft", prevRow, "topleft", 0, 0)

		-- store the previous element
		prevRow = currRow

		-- current row name
		currRow = mainLogWindow .. "ActiveMobilesOnScreen"

		-- create the data logger log row
		CreateWindowFromTemplate(currRow, "LogDataTemplate", mainLogWindow)

		-- set the name for the attribute
		LabelSetText(currRow .. "AttributeName", L"ActiveMobilesOnScreen")

		-- set the custom events list type
		WindowSetId(currRow, 902)

		-- reset the current anchors
		WindowClearAnchors(currRow)

		-- anchor to the previous element
		WindowAddAnchor(currRow, "bottomleft", prevRow, "topleft", 0, 0)

		-- store the previous element
		prevRow = currRow

		-- current row name
		currRow = mainLogWindow .. "MemoryUsage"

		-- create the data logger log row
		CreateWindowFromTemplate(currRow, "LogDataTemplate", mainLogWindow)

		-- set the name for the attribute
		LabelSetText(currRow .. "AttributeName", L"Script Memory Usage")

		-- reset the current anchors
		WindowClearAnchors(currRow)

		-- anchor to the previous element
		WindowAddAnchor(currRow, "bottomleft", prevRow, "topleft", 0, 0)

		-- flag the data logger as initialized
		DebugWindow.DataLogInitialized = true

		-- update the scroll window
		ScrollWindowUpdateScrollRect("DataLoggerScrollWindow")   	
	end
end

function DebugWindow.UpdateAllData()

	-- has the data logger been initialized?
	if DebugWindow.DataLogInitialized then

		-- data logger window
		local mainLogWindow = "DataLoggerScrollWindowScrollChild"

		-- scan all the window data
		for name, data in pairs(WindowData) do

			-- is this a table?
			if type(data) == "table" then

				-- is this a valid window data type?
				if data.Type and Debug.DataLoggerAllowedType(data.Type) then
					
					-- current row name
					local currRow = mainLogWindow .. name

					if DoesWindowExist(currRow) then

						local value = towstring(Debug.DataLoggerGetTypeCount(data.Type))

						-- set the name for the attribute
						LabelSetText(currRow .. "AttributeValue", value)
					end
				end
			end
		end	

		-- current row name
		local currRow = mainLogWindow .. "TODOList"
		
		-- set the name for the attribute
		LabelSetText(currRow .. "AttributeValue", towstring(table.countElements(Interface.TODO)))

		-- current row name
		currRow = mainLogWindow .. "CustomEventss"

		-- set the name for the attribute
		LabelSetText(currRow .. "AttributeValue", towstring(table.countElements(Interface.CheckAvailableEvents)))

		-- current row name
		currRow = mainLogWindow .. "ActiveMobilesOnScreen"

		-- set the name for the attribute
		LabelSetText(currRow .. "AttributeValue", towstring(table.countElements(Interface.ActiveMobilesOnScreen)))

		-- store the previous element
		prevRow = currRow

		-- current row name
		currRow = mainLogWindow .. "MemoryUsage"

		local memory = bytesToSize(gcinfo() * 1024)

		-- set the name for the attribute
		LabelSetText(currRow .. "AttributeValue", towstring(memory))
	end
end

function DebugWindow.PrintData(flags)

	-- current window name
	local windowName = SystemData.ActiveWindow.name

	-- get the data type ID
	local typ = WindowGetId(windowName)

	-- invald type?
	if not IsValidID(typ) then
		return
	end

	local data

	-- todo list type?
	if typ == 900 then
		data = Interface.TODO

	-- custom events type?
	elseif typ == 901 then
		data = Interface.CheckAvailableEvents

	-- active mobiles on screen type?
	elseif typ == 902 then
		data = Interface.ActiveMobilesOnScreen

	else
		data = Debug.GetWindowDataForType(typ)
	end

	-- is the control button pressed?
	if flags == WindowUtils.ButtonFlags.CONTROL and typ ~= WindowData.PlayerStatus.Type and typ ~= WindowData.PlayerEquipmentSlot.Type and (typ < 900 or type ~= 902) then
		
		-- print the data for the target ID
		RequestTargetInfo(function(id) Debug.Print("---------" .. Debug.WindowDataTypeToString(typ) .. "[" .. tostring(id) .. "] ---------" ) Debug.Print(data[id]) Debug.Print("--------- END ---------") end)

	else
		-- print the data
		Debug.Print(data)
	end
end