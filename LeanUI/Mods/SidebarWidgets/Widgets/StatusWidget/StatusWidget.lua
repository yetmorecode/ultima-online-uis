local this = {}

StatusWidget = this

this.Name = "Status Widget"
this.Description = "A simple widget"

this.wnd = "StatusWidget"
this.class = "StatusWidget"
this.template = this.wnd.."Template"

local modFolder = "./UserInterface/"..SystemData.Settings.Interface.customUiName
modFolder = modFolder.."/Mods/SidebarWidgets/Widgets/"..this.wnd
LoadResources(modFolder, this.wnd..".xml", this.wnd..".xml")

function this.OnAdded(sidebar)

  this.sidebar = sidebar
  
  
end

function this.OnCreateWindow(sidebar, width, parent)
  CreateWindowFromTemplateShow(this.wnd, this.template, parent, true)
  
  RegisterWindowData(WindowData.PlayerStatus.Type,0)
  WindowRegisterEventHandler(this.wnd, WindowData.PlayerStatus.Event, "StatusWidget.UpdateStatus")
  
  this.UpdateStatus()
  --Debug.DumpToChat("WindowData.PlayerStatus", WindowData.PlayerStatus)
end

function this.UpdateStatus()
  if SystemData.PaperdollTexture[WindowData.PlayerStatus.PlayerId] ~= nil then
    local textureData = SystemData.PaperdollTexture[WindowData.PlayerStatus.PlayerId] 
    
    local x, y, scale
    if textureData.IsLegacy == 1 then
      x, y = -88, 10
      scale = 1.75
    else
      x, y = -11, -191
      scale = 0.75
    end
    
    CircleImageSetTexture(this.wnd.."Portrait", "paperdoll_texture"..WindowData.PlayerStatus.PlayerId, x - textureData.xOffset, y - textureData.yOffset)
    CircleImageSetTextureScale(this.wnd.."Portrait", InterfaceCore.scale * scale)
    
    local stats = WindowData.PlayerStatus
    LabelSetText(this.wnd.."HP", L""..stats["MaxHealth"]..L" ("..stats["Strength"]..L")")
    LabelSetText(this.wnd.."Mana", L""..stats["MaxMana"]..L" ("..stats["Intelligence"]..L")")
    LabelSetText(this.wnd.."Stam", L""..stats["MaxStamina"]..L" ("..stats["Dexterity"]..L")")
    LabelSetText(this.wnd.."Melee", L""..stats["DamageChanceIncrease"]..L" DI, "..stats["HitChanceIncrease"]..L" HCI, "..stats["DefenseChanceIncrease"]..L" DCI, "..stats["SwingSpeedIncrease"]..L" SSI")
    LabelSetText(this.wnd.."Casting", L""..stats["LowerReagentCost"]..L" LRC, "..stats["LowerManaCost"]..L" LMC, "..stats["SpellDamageIncrease"]..L" SDI, "..stats["FasterCasting"]..L"/"..stats["FasterCastRecovery"]..L" FC")
    LabelSetText(this.wnd.."Regen", L""..stats["ManaRegen"]..L" MR, "..stats["StamRegen"]..L" SR, "..stats["HitPointRegen"]..L" HPR, "..stats["EnhancePotions"]..L" EP")
    LabelSetText(this.wnd.."Resists", L""..stats["PhysicalResist"]..L" / "..stats["FireResist"]..L" / "..stats["ColdResist"]..L" / "..stats["PoisonResist"]..L" / "..stats["EnergyResist"]..L"   "..stats["Luck"]..L" Luck")
  end
end


function this.OnRemoved(sidebar)

end

function this.OnUpdate(sidebar, timePassed)

end

function this.OnExpanded(sidebar)

end

function this.OnCollapsed(sidebar)

end