local this = {}
MonsterWindow = this

this.Index = {}
this.ListItemHeight = 30

local windowName = "MonsterWindow"

function this.Initialize()
  local a = 97
  local z = a + 25 
  
  local Index = {}
  
  for name, data in pairs(CreaturesDB) do
    local letter = string.byte(string.lower(name))
    if Index[letter] == nil then
      Index[letter] = {}
    end
    Index[letter][name] = data
  end
  
  local idx = 1
  local parent = windowName.."ScrollWindowScrollChild"
  
  
  for i = a, z do
    --for monsterName, data in pairs(Index[i]) do
    --  data.monsterName = monsterName
    --  this.Index[idx] = data
      
    --  local name = windowName.."ListItemLabel"..idx    
    --  local label = CreateWindowFromTemplate(name, windowName.."LabelTemplate", parent)
      
    --  LabelSetText(name.."Name", StringToWString(monsterName))
    --  WindowClearAnchors(name)
    --  WindowAddAnchor(name, "topleft", parent, "topleft", 0, (idx-1)  * this.ListItemHeight)
    --  WindowSetShowing(name, true)
    --  WindowSetId(name.."Name", idx)
      
      --idx = idx + 1
    --end
  end 
end

function this.OnMonsterSelect()
  local id = WindowGetId(SystemData.ActiveWindow.name)
  local monster = this.Index[id]
  
  Debug.PrintToChat(monster.monsterName)
end

function this.Shutdown() 

end