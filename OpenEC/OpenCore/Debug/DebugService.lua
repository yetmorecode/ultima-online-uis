local DebugService = {

  Initialize = function (self)
    WindowRegisterEventHandler("Root", SystemData.Events.DEBUGPRINT_TO_CONSOLE, "OpenCore.Debug.OnDebugMessage")
  end,
  
  Shutdown = function (self)
    WindowUnregisterEventHandler("Root", SystemData.Events.DEBUGPRINT_TO_CONSOLE, "OpenCore.Debug.OnDebugMessage")
  end,
  
  OnDebugMessage = function ()
    OpenCore.Debug:Chat(DebugData.DebugString)
  end,

  Chat = function (self, ...)
    local log = "Chat"
    local filter = 0
    
    for i, message in ipairs(arg) do
      local t = type (message);
      if t == "string" then
        TextLogAddEntry (log, filter, StringToWString (message))
        -- XXX: PrintWStringToChatWindow(message, SystemData.ChatLogFilters.SYSTEM )
      elseif t == "number" then
        TextLogAddEntry (log, filter, StringToWString(tostring(message)))
      elseif t == "wstring" then
        TextLogAddEntry (log, filter, message)
      elseif t == "table" then
        self:DumpToChat("table", message)
      else
        self:Chat("Unknown type: " .. t)
      end
    end
  end,
  
  PrintToChat = function (self, ...)
    self:Chat(...)
  end,
  
  DumpToChat = function (self, name, value, memo, depth)
    name = name or "table"
    memo = memo or {}
    depth = depth or 4
    if type(name) == "wstring" then
      name = tostring(name)
    end
    local t = type(value)
    local prefix = name.."="
    
    if t == "number" or t == "string" or t == "function" then
      self:Chat(prefix..tostring(value))
    elseif t == "nil" then
      self:Chat(prefix.."(nil)")
    elseif t == "boolean" then
      if value then
        self:Chat(prefix.."true")
      else
        self:Chat(prefix.."false")
      end
    elseif t == "wstring" then
      self:Chat(StringToWString(prefix)..value)
    elseif t == "table" then
      
      if memo[value] then
        self:Chat(prefix..tostring(memo[value]))
      else
        memo[value] = name
        
        for k, v in pairs(value) do
          local fname = name.."["..tostring(k).."]"
          if tostring(k) == "__index" then
            if v == value then
              self:Chat(fname.."=(to self)")
            else
              self:Chat(fname.."=(to other???)")          
            end
          else
            if type(v) == "table" and depth < 1 then
              self:Chat(fname.."={..}")
            else
              self:DumpToChat(fname, v, memo, depth-1)
            end
          end
        end
      end      
    else
      self:Chat("[Debug] could not serialize type: "..t)
    end
  end
}

OpenCore:RegisterServiceClass("Debug.DebugService", "Debug", DebugService)