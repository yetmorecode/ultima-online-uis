-- Load encyclopedia window defintions
LoadResources( "./UserInterface/"..SystemData.Settings.Interface.customUiName.."/Mods/Encyclopedia", "MonsterWindow.xml", "MonsterWindow.xml" )

-- Define core encyclopedia mod
local this = {};
Encyclopedia = this;

function this.Initialize() 
  CreateWindow("MonsterWindow", false)
end

function this.Shutdown() 
  DestroyWindow("MonsterWindow")
end

