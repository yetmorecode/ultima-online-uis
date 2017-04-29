----------------------------------------------------------------
-- Debugging Assistance Variables
----------------------------------------------------------------

Debug = {}
Debug.Stringable = { ["nil"]=1, ["string"]=1, ["number"]=1, ["bool"]=1 }

function Debug.PrintToChat( text )
	if type(text) == "string" then
		text = StringToWString(text)
	end
	
	TextLogAddEntry( "Chat", 100, text )
end

DC = Debug.PrintToChat

function Debug.DumpFile()
  LogSystem("lua-functions.txt", "lua-variables.txt")
end

function Debug.PrintToDebugConsole( text )
	if type(text) == "string" then
		text = StringToWString(text)
	end
	
	text = wstring.gsub(text, L"\n", L" +++ ")
	TextLogAddEntry( "UiLog", 1, text )
end

function Debug.PrintToOverhead(text)
  if type(text) == "string" then
    text = StringToWString(text)
  end
  
  OverheadText.PrintOverheadText(Player.Id, 10, text, SystemData.TextColor)
end

-- Shorter alias to PrintToDebugConsole
function Debug.Print(text)
	Debug.PrintToDebugConsole(text)
end

function Debug.DumpToConsole(name, value, memo)
	memo = memo or {}
	
	local t = type(value)
	local prefix = name.."="
	
	if Debug.Stringable[t] then
		Debug.PrintToDebugConsole(prefix..tostring(value))
	elseif t == "wstring" then
		Debug.PrintToDebugConsole(StringToWString(prefix)..value)
	elseif t == "table" then
		if memo[value] then
			Debug.PrintToDebugConsole(prefix..tostring(memo[value]))
		else
			memo[value] = name
			for k, v in pairs(value) do
				local fname = name.."["..tostring(k).."]"
				Debug.DumpToConsole(fname, v, memo)
			end
		end
	else
		Debug.PrintToDebugConsole(StringToWString("Can't serialize type "..t))
	end
end

function Debug.DumpToChat(name, value, memo)
  memo = memo or {}
  
  if type(name) == "wstring" then
    name = tostring(name)
  end
  
  local t = type(value)
  local prefix = name.."="
  
  if Debug.Stringable[t] then
    Debug.PrintToChat(prefix..tostring(value))
  elseif t == "boolean" then
    if value then
      Debug.PrintToChat(prefix.."true")
    else
      Debug.PrintToChat(prefix.."false")
    end
  elseif t == "wstring" then
    Debug.PrintToChat(StringToWString(prefix)..value)
  elseif t == "table" then
    if memo[value] then
      Debug.PrintToChat(prefix..tostring(memo[value]))
    else
      memo[value] = name
      
      for k, v in pairs(value) do
        local fname = name.."["..tostring(k).."]"
        Debug.DumpToChat(fname, v, memo)
      end
    end
  else
    Debug.PrintToChat(StringToWString("Can't serialize type "..t))
  end
end

function Debug.D(value)
  Debug.DumpToChat("", value)
end


function Debug.Dump(name, value, memo)
	Debug.DumpToConsole(name, value, memo)
end
