ItemPropertiesToChat = {}
local this = ItemPropertiesToChat

function this.RequestItem()
  RequestTargetInfo()
  WindowRegisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT, "ItemPropertiesToChat.PrintRequested")
end

function this.PrintRequested()
  WindowUnregisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT)
  local id = SystemData.RequestInfo.ObjectId 
  if id == 0 or id == nil then return end
  
  local info = WindowData.ObjectInfo[id]  
  if info == nil then
    RegisterWindowData(WindowData.ObjectInfo.Type, id)
    info = WindowData.ObjectInfo[id]
    UnregisterWindowData(WindowData.ObjectInfo.Type, id)  
  end
  
  this.PrintToChat("---")
  local data = ItemProperties.GetObjectPropertiesArray(id, "caller")
  for k,v in pairs(data["PropertiesList"]) do
    this.PrintToChat(v)
  end
  this.PrintToChat("---")
end 

function this.PrintToChat(text) 
  if type(text) == "string" then
    text = StringToWString(text)
  end
  TextLogAddEntry("Chat", 100, text)
end
