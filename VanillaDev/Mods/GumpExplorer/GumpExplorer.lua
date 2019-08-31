GumpExplorer = {}

local this = GumpExplorer

function this.Initialize()
  
end

function this.Shutdown()
  
end

function this.PrintOpenGumps()
  local count = 0
  
  if GumpData == nil or GumpData.Gumps == nil then
    Debug.PrintToChat(L"No open gumps - try opening a generic gump")
    return
  end
  
  for gumpId, data in pairs(GumpData.Gumps) do 
    count = count + 1 
  end
  
  if count == 0 then
    Debug.PrintToChat(L"No open gumps - try opening a generic gump")
    return
  end
  
  Debug.PrintToChat(L"----------------")
  Debug.PrintToChat(L"" .. count .. L" open gumps:")
  for gumpId, data in pairs(GumpData.Gumps) do
    Debug.PrintToChat(L"Gump with id " .. gumpId)
    if data.windowName ~= nil then
      Debug.PrintToChat(L"  windowName: " .. StringToWString(data.windowName))
      Debug.PrintToChat(L"  windowId: " .. WindowGetId(data.windowName))
    else
      Debug.PrintToChat(L"  No window")
    end
    if data.Labels ~= nil then
      Debug.PrintToChat(L"  Labels:")
      for labelId, labelData in pairs(data.Labels) do
        Debug.PrintToChat(L"    #" .. labelId .. L" - " .. labelData.tid .. L" - " .. GetStringFromTid(labelData.tid))
      end
    else
      Debug.PrintToChat(L"  No Labels")
    end
    if data.Buttons ~= nil then
      Debug.PrintToChat(L"  Buttons:")
      for buttonId, buttonData in pairs(data.Buttons) do
        Debug.PrintToChat(L"    #" .. buttonId .. L" - " .. StringToWString(buttonData))
        Debug.PrintToChat(L"    GumpsParsing.PressButton(" .. gumpId .. L", " .. buttonId .. L")")
      end
    else
      Debug.PrintToChat(L"  No Buttons")
    end
    if data.TextEntry ~= nil then
      Debug.PrintToChat(L"  TextEntry:")
      for textId, textData in pairs(data.TextEntry) do
        Debug.PrintToChat(L"    " .. textId .. L" - " .. StringToWString(textData) .. L": " .. TextEditBoxGetText(textData))
      end
    else
      Debug.PrintToChat(L"  No TextEntry")
    end
    Debug.PrintToChat(L"----------------")
  end
end

