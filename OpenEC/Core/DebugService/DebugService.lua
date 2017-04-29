DebugService = {}

function DebugService.PrintToChat (message)
  if type (message) == "string" then
    message = StringToWString (message)
  end
  TextLogAddEntry ("Chat", 100, message)
end