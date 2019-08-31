OpenCore = {
  Version = "2019-08-29",
  Classes = {},
  
  Initialize = function (self)
    self.Debug:Initialize()
    self.MainMenu:Initialize()
    self.StaticText:Initialize()
    self.OverheadText:Initialize()
    self.ContextMenu:Initialize()
    self.Player:Initialize()
    self.Mobile:Initialize()
    self.Hotbar:Initialize()
    
    
  end,
  
  Chat = function (self, ...)
    self.Debug:Chat(...)
  end,
  
  GetActiveDialog = function (self)
    return self.Window:GetActiveDialog()
  end,
  
  PrintBanner = function (self)
    local now = "[" .. self.DateTime:GetDateString() .. " " .. self.DateTime:GetTimeString() .. "] "
    self:Chat(now.."OpenEC version " .. self.Version)
    --self.Debug:DumpToChat(now.."OpenEC.Classes", self.Classes, {}, 1)
  end,
  
  RegisterClass = function (self, namespace, class)
    local n = namespace .. "."
    local names = {}
    for name in n:gmatch("(.-)%.") do
      table.insert(names, name)
    end
    local namespacesCount = table.getn(names)
    local currentNamespace = self.Classes
    for i = 0, namespacesCount-2 do
      local name = names[i+1]
      currentNamespace[name] = currentNamespace[name] or {}
      currentNamespace = currentNamespace[name]
    end
    currentNamespace[names[namespacesCount]] = class
  end,
  
  RegisterServiceClass = function (self, namespace, service, class)
    self:RegisterClass(namespace, class)
    self[service] = class
  end
}

function OpenCoreRegisterService (name, service)
  OpenCore[name] = service
end

string.split = function (str, pattern)
  local full = str .. pattern
  local all = {}
  if (pattern == ".") then
    pattern = "%."
  end
  for match in full:gmatch("(.-)"..pattern) do
    table.insert(all, match)
  end
  return all
end

wstring.split = function (str, pattern)
  local full = str .. pattern
  local all = {}
  if (pattern == L".") then
    pattern = L"%."
  end
  for match in full:gmatch(L"(.-)"..pattern) do
    table.insert(all, match)
  end
  return all
end