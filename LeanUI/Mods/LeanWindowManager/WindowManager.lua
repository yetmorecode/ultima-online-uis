local this = {}

LeanWindowManager = this

LoadResources(
  "./UserInterface/"..SystemData.Settings.Interface.customUiName.."/Mods/LeanWindowManager/Window", 
  "LeanWindowOverview.xml", 
  "LeanWindowOverview.xml"
)

this.windows = {}

function this.Initialize ()
    this.CreateWindow("LeanWindowOverview", false, {
        description = L"Shows an overview of all available windows an their state."
    })
    
end

function this.CreateWindow (name, show, data) 
    CreateWindow (name, show)
    this.RegisterWindow(name, data)
end

function this.DestroyWindow (name)
    WindowUtils.SaveWindowPosition (name)
    DestroyWindow (name)
    this.windows[name] = nil
end

function this.ToggleWindow (name)  
  WindowUtils.SaveWindowPosition (name) 
  ToggleWindowByName(name, "", this.ToggleWindow) 
end

function this.RegisterWindow (name, data)
  this.windows[name] = {
      name = name,
      data = data
  }
  LeanWindowOverview.Update ()
end

function this.GetWindows ()
  return this.windows
end