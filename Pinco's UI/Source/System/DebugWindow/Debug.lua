----------------------------------------------------------------
-- Debugging Assistance Variables
----------------------------------------------------------------

Debug = {}
Debug.Stringable = { ["nil"]=1, ["string"]=1, ["number"]=1, ["bool"]=1 }

function Debug.PrintToChat(text)
	ChatPrint(towstring(text), SystemData.ChatLogFilters.SYSTEM)
end

function Debug.PrintToDebugConsole(text)
	TextLogAddEntry( "UiLog", 1, towstring(text) )
end

-- Shorter alias to PrintToDebugConsole
function Debug.Print(text)
	if (type(text) == "table") then
		Debug.DumpToConsole("", text)
	elseif type(text) == "function" then
		Debug.PrintToDebugConsole("<" .. type(text) .. ">: " .. getFunctionName(text))
	elseif text == L"Logging OFF" or text == L"Logging ON" then
		Debug.PrintToDebugConsole(tostring(text))
	else
		if string.find(tostring(text), "<", 1, true) then
			Debug.PrintToDebugConsole(text)
		else
			Debug.PrintToDebugConsole("<" .. type(text) .. ">: " .. tostring(text))
		end
	end
end

-- additional aliases
function Debug.print(text)
	Debug.Print(text)
end

function Debug.Log(text)
	Debug.Print(text)
end

function Debug.log(text)
	Debug.Print(text)
end

Debug.Recursive = 0
function Debug.DumpToConsole(name, value, memo)
	memo = memo or {}
	local t = type(value)
	if Debug.Stringable[t] then
		if name == "~specialSep~" then
			Debug.Print(tostring(value))
		else
			Debug.Print("<" .. type(value) .. ">: " .. name .. " = " ..tostring(value))
		end
	elseif t == "wstring" then
		Debug.Print(L"<" .. type(v) .. ">: " .. name .. L" = " ..value)
	elseif t == "boolean" then
		Debug.Print("<" .. type(v) .. ">: " .. name .. " = " ..tostring(value))
	elseif t == "function" then
		if Interface.AllFunctions == nil then
			Interface.AllFunctions = {}
			generateAllFunctionsTable()
		end
		Debug.Print("<" .. t .. ">: " .. Interface.AllFunctions[tostring(value)])
	elseif t == "table" then
		if memo[value] then
			Debug.Print("<" .. type(v) .. ">: " .. name .. " = " ..tostring(memo[value]))
		else
			memo[value] = name
			local tabs = ""
			
			if name ~= "" then
				for i = 1, Debug.Recursive do
					tabs = tabs .. "   "
				end
				Debug.DumpToConsole("~specialSep~", tabs ..  "<table>: " .. string.trim(name) , memo)
			else
				local n = table.getTableName(value)
				if n then
					Debug.DumpToConsole("~specialSep~", "<table>: [" .. table.getTableName(value) .. "]", memo)
				end
			end
			
			for k, v in pairsByKeys(value) do
				if type(v) == "boolean" then
					local fname = tabs .. "<" .. type(v) .. ">: " .. string.format("%s[%s]", string.trim(name), tostring(k)) .. " = " ..tostring(v)
					Debug.DumpToConsole("~specialSep~", fname, memo)
				end
			end
			
			for k, v in pairsByKeys(value) do
				if type(v) == "number" then
					local fname = tabs ..  "<" .. type(v) .. ">: " .. string.format("%s[%s]", string.trim(name), tostring(k)) .. " = " ..tostring(v)
					Debug.DumpToConsole("~specialSep~", fname, memo)
				end
			end
			
			for k, v in pairsByKeys(value) do
				if type(v) == "string" then
					local fname = tabs ..  "<" .. type(v) .. ">: " .. string.format("%s[%s]", string.trim(name), tostring(k)) .. " = " ..tostring(v)
					Debug.DumpToConsole("~specialSep~", fname, memo)
				end
			end
			
			for k, v in pairsByKeys(value) do
				if type(v) == "wstring" then
					local fname = tabs ..  "<" .. type(v) .. ">: " .. string.format("%s[%s]", string.trim(name), tostring(k)) .. " = " ..tostring(v)
					Debug.DumpToConsole("~specialSep~", fname, memo)
				end
			end
			
			for k, v in pairsByKeys(value) do
				if type(v) == "table" then
					Debug.Recursive = Debug.Recursive + 1
					local fname = tabs ..  string.format("%s[%s]", string.trim(name), tostring(k))
					Debug.DumpToConsole(fname, v, memo)
				end
			end
			
			for k, v in pairsByKeys(value) do
				if type(v) == "function" then
					local fname = tabs ..  "<" .. type(v) .. ">: " .. string.format("%s[%s]", string.trim(name), tostring(k))
					Debug.DumpToConsole("~specialSep~", fname, memo)
				end
			end
			
			for k, v in pairsByKeys(value) do
				if v == nil then
					local fname = tabs ..  "<" .. type(v) .. ">: " .. string.format("%s[%s]", string.trim(name), tostring(k)) .. " = " ..tostring(v)
					Debug.DumpToConsole("~specialSep~", fname, memo)
				end
			end
			
			if name ~= "" then
				Debug.Recursive = Debug.Recursive -1
			end
			
		end
	else
		Debug.PrintToDebugConsole(L"Can't serialize type "..t)
	end
end

function Debug.Dump(name, value, memo)
	Debug.DumpToConsole(name, value, memo)
end


function Debug.ToggleDebugWindow()
	WindowSetShowing("DebugWindow", not WindowGetShowing("DebugWindow"))
	if DebugWindow.logging then
	--	DebugWindow.ToggleLogging()
	end
	if WindowGetShowing("DebugWindow") then
		if not DebugWindow.logging then
			SetLoadLuaDebugLibrary( true )
			DebugWindow.ToggleLogging()
		end
	end
end

Debug.UniqueLogged = {}
Debug.LastCount = 1
Debug.LastFunctionCall = L""
function Debug.ParseDebugLog() -- function that saves the errors data

	if not DebugWindow.logging or not Interface.started or false then
		pcall(Interface.ClockUpdater, 0)
	end

	local totalEntries = TextLogGetNumEntries( "UiLog" )

	-- no new entries
	if totalEntries == 0 then
		return
	end

	for i = Debug.LastCount, totalEntries - 1 do
		local timestamp, filterType, entryText = TextLogGetEntry( "UiLog", i )
		
		-- logging on/off messages are useless
		if entryText == L"Logging ON" or entryText == L"Logging OFF" then
			continue
		end
		-- function call
		if filterType == 5 then
			Debug.LastFunctionCall = entryText
		end
		-- description texts
		if	wstring.find(entryText, L"Set m_defaultDir", 1, true) or
			wstring.find(entryText, L"Invalid font definition for Label", 1, true) or
			wstring.find(entryText, L"Error Loading XML Definition", 1, true) or
			wstring.find(entryText, L"Text is cut off in", 1, true) or
			wstring.find(entryText, L"Calling \'DestroyWindow\' on window", 1, true) or
			wstring.find(entryText, L"Error in function call \'ModuleInitialize\': PlayerVariables_", 1, true) or
			wstring.find(entryText, L"Error in function call \'ModulesLoadFromListFile\': file ./UserInterface/PlayerVariablesMods", 1, true) or
			wstring.find(entryText, L"Unable to load \'./UserInterface/PlayerVariablesMods", 1, true) or
			wstring.find(entryText, L"Error loading \'PlayerVariables\' from \'./UserInterface/PlayerVariablesMods/", 1, true) or
			wstring.find(entryText, L"<string>: GenericGump", 1, true) or
			wstring.find(entryText, L"SingleLineTextEntry.", 1, true) or
			wstring.find(entryText, L"is not a Label", 1, true) or
			filterType >= 4
		then
			continue
		end

		-- searching for loading messages
		local found = false
		for name, _ in pairs(Interface.SupportedMods) do
			if string.find(tostring(entryText), "(" .. name .. ")", 1, true) then
				found = true
				break
			end
		end
		if found then
			continue
		end

		-- prevents duplicate error logging
		if Debug.IsErrorAlreadyLogged(entryText) then
			continue
		end

		--entryText = L"Last Function Called: " .. Debug.LastFunctionCall .. L"\r Error Message: " .. entryText

		-- logging data
		if filterType == 1 then -- debug errors
			Debug.SaveError("ERROR", i, entryText)
		elseif filterType == 2 then
			Debug.SaveError("WARNING", i, entryText)
		elseif filterType == 3 then
			Debug.SaveError("ERROR", i, entryText)
		end
	end

	-- clearing the log
	if not Interface.DebugMode then
		TextLogClear( "UiLog" )
	else
		Debug.LastCount = totalEntries
	end
end

function Debug.IsErrorAlreadyLogged(entryText)
	for i = 1, #Debug.UniqueLogged do
		if Debug.UniqueLogged[i] == entryText then
			return true
		end
	end
	return false
end

function Debug.SaveError(type, index,  text)

	table.insert(Debug.UniqueLogged, text)

	local output = L""
	TextLogCreate("Error", 5000000)
	TextLogSetEnabled("Error", true)
	TextLogClear("Error")
		
	TextLogSetIncrementalSaving( "Error", true, "logs/Errors/[" .. GetClockString() .. "]" .. index .. " - " .. type .. ".txt")

	TextLogAddEntry("Error", 1, text)
	
	TextLogDestroy("Error")
end

function Debug.WindowDataTypeToString(type)

	if (type == 902) then
		return "Interface.ActiveMobilesOnScreen"
	elseif (type == WindowData.MobileStatus.Type) then
		return "WindowData.MobileStatus"
	elseif (type == WindowData.Paperdoll.Type) then
		return "WindowData.Paperdoll"
	elseif (type == WindowData.MobileName.Type) then
		return "WindowData.MobileName"
	elseif (type == WindowData.ObjectInfo.Type) then
		return "WindowData.ObjectInfo"
	elseif (type == WindowData.ItemProperties.Type) then
		return "WindowData.ItemProperties"
	elseif (type == WindowData.PlayerStatus.Type) then
		return "WindowData.PlayerStatus"
	elseif (type == WindowData.PlayerEquipmentSlot.Type) then
		return "WindowData.PlayerEquipmentSlot"
	elseif (type == WindowData.ContainerWindow.Type) then
		return "WindowData.ContainerWindow"
	elseif (type == WindowData.ObjectTypeQuantity.Type) then
		return "WindowData.ObjectTypeQuantity"
	elseif (type == WindowData.SkillDynamicData.Type) then
		return "WindowData.SkillDynamicData"
	elseif (type == WindowData.Spellbook.Type) then
		return "WindowData.Spellbook"
	elseif (type == WindowData.HighlightEffect.Type) then
		return "WindowData.HighlightEffect"
	end
	return ""
end

function Debug.DataLoggerAllowedType(type)

	if (type == WindowData.MobileStatus.Type) then
		return true
	elseif (type == WindowData.HealthBarColor.Type) then
		return true
	elseif (type == WindowData.Paperdoll.Type) then
		return true
	elseif (type == WindowData.MobileName.Type) then
		return true
	elseif (type == WindowData.ObjectInfo.Type) then
		return true
	elseif (type == WindowData.ItemProperties.Type) then
		return true
	elseif (type == WindowData.PlayerStatus.Type) then
		return true
	elseif (type == WindowData.PlayerEquipmentSlot.Type) then
		return true
	elseif (type == WindowData.ContainerWindow.Type) then
		return true
	elseif (type == WindowData.ObjectTypeQuantity.Type) then
		return true
	elseif (type == WindowData.Spellbook.Type) then
		return true
	end
	return false
end

function Debug.DataLoggerGetTypeCount(typ)

	local count = 0
	if (typ == WindowData.MobileStatus.Type) then

		for mobileId, data in pairs(WindowData.MobileStatus) do
			if type(data) == "table" then
				count = count + 1
			end
		end

	elseif (typ == WindowData.HealthBarColor.Type) then

		for mobileId, data in pairs(WindowData.MobileStatus) do
			if type(data) == "table" then
				count = count + 1
			end
		end

	elseif (typ == WindowData.Paperdoll.Type) then

		for mobileId, data in pairs(WindowData.Paperdoll) do
			if type(data) == "table" then
				count = count + 1
			end
		end

	elseif (typ == WindowData.MobileName.Type) then

		for mobileId, data in pairs(WindowData.MobileName) do
			if type(data) == "table" then
				count = count + 1
			end
		end

	elseif (typ == WindowData.ObjectInfo.Type) then

		for mobileId, data in pairs(WindowData.ObjectInfo) do
			if type(data) == "table" then
				count = count + 1
			end
		end

	elseif (typ == WindowData.ItemProperties.Type) then

		for mobileId, data in pairs(WindowData.ItemProperties) do
			if type(data) == "table" and IsValidID(mobileId) then
				count = count + 1
			end
		end

	elseif (typ == WindowData.PlayerStatus.Type) then

		if Interface.VerifyPlayerStatus() ~= nil then
			return "Active"
		end

		return "Waiting"

	elseif (typ == WindowData.PlayerEquipmentSlot.Type) then

		for mobileId, data in pairs(WindowData.PlayerEquipmentSlot) do
			if type(data) == "table" then
				count = count + 1
			end
		end

	elseif (typ == WindowData.ContainerWindow.Type) then

		for mobileId, data in pairs(WindowData.ContainerWindow) do
			if type(data) == "table" then
				count = count + 1
			end
		end

	elseif (typ == WindowData.ObjectTypeQuantity.Type) then

		for mobileId, data in pairs(WindowData.ObjectTypeQuantity) do
			if type(data) == "table" then
				count = count + 1
			end
		end

	elseif (typ == WindowData.Spellbook.Type) then

		for mobileId, data in pairs(WindowData.Spellbook) do
			if type(data) == "table" then
				count = count + 1
			end
		end
	end
	return count
end

function Debug.GetWindowDataForType(typ)
	for name, data in pairs(WindowData) do
		if type(data) == "table" then
			if data.Type and data.Type == typ then
				return data
			end
		end
	end
end

function Debug.GetAllWindowDataTypes()
	for name, data in pairs(WindowData) do
		if type(data) == "table" then
			if data.Type then
				Debug.Print(name)
			end
		end
	end
end