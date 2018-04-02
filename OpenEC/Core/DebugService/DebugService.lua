DebugService = {}

function DebugService.PrintToChat (...)
  local log = "Chat"
  local filter = 0
  
  for i, message in ipairs(arg) do
    local t = type (message);
    if t == "string" then
      TextLogAddEntry (log, filter, StringToWString (message))
    elseif t == "wstring" then
      TextLogAddEntry (log, filter, message)
    elseif t == "table" then
      TextLogAddEntry (log, filter, L"{")
      for k, v in pairs(message) do
          DebugService.PrintToChat(tostring(k).."="..tostring(v))
          --DebugService.PrintToChat(v)
      end
      TextLogAddEntry (log, filter, L"}")
    else
      DebugService.PrintToChat("Unknown type: " .. t)
    end
  end
end
