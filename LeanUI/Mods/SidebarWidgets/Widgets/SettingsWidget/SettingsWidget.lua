
local this = {}

SettingsWidget = this

this.Name = "Quick Settings Widget"
this.Description = "Quick acces for often used settings"

this.wnd = "SettingsWidget"
this.template = this.wnd.."Template"

local modFolder = "./UserInterface/"..SystemData.Settings.Interface.customUiName
modFolder = modFolder.."/Mods/SidebarWidgets/Widgets/"..this.wnd
LoadResources(modFolder, this.wnd..".xml", this.wnd..".xml")

function this.OnAdded(sidebar)
  this.sidebar = sidebar
end

function this.OnCreateWindow(sidebar, width, parent)
  CreateWindowFromTemplateShow(this.wnd, this.template, parent, true)
  
  LabelSetText(this.wnd.."Title", L"Settings:")
  
  LabelSetText(this.wnd.."LegacyContainersLabel", L"Legacy Containers")
  ButtonSetPressedFlag(this.wnd.."LegacyContainersButton", SystemData.Settings.Interface.LegacyContainers)
  
  LabelSetText(this.wnd.."QuickLootLabel", L"Quick looting")
  ButtonSetPressedFlag(this.wnd.."QuickLootButton", Interface.LoadBoolean("Lean.QuickLoot", false))
  
  LabelSetText(this.wnd.."HideBluesLabel", L"Hide player names")
  ButtonSetPressedFlag(this.wnd.."HideBluesButton", Interface.LoadBoolean("Lean.HidePlayerNames", false))
  
  LabelSetText(this.wnd.."LootWindowLabel", L"Show LootWindow")
  ButtonSetPressedFlag(this.wnd.."LootWindowButton", WindowGetShowing("LootWindow"))
  
  LabelSetText(this.wnd.."EncyclopediaLabel", L"Show Encyclopedia")
  ButtonSetPressedFlag(this.wnd.."EncyclopediaButton", WindowGetShowing("MonsterWindow"))
  
  LabelSetText(this.wnd.."StatusWindowLabel", L"Show StatusWindow")
  ButtonSetPressedFlag(this.wnd.."StatusWindowButton", WindowGetShowing("StatusWindow"))
  
  LabelSetText(this.wnd.."ScanLabel", L"Scan objects")
  ButtonSetPressedFlag(this.wnd.."ScanButton", ObjectScanner.enabled)
  
  LabelSetText(this.wnd.."MenubarLabel", L"Show Menubar")
  ButtonSetPressedFlag(this.wnd.."MenubarButton", WindowGetShowing("MenuBarWindow"))
  
  LabelSetText(this.wnd.."TradeQuestLabel", L"Trade Quest Window")
  ButtonSetPressedFlag(this.wnd.."TradeQuestButton", WindowGetShowing("TradeQuestWindow"))
end

function this.ToggleLegacyContainers()
    local lc = not SystemData.Settings.Interface.LegacyContainers

    SystemData.Settings.Interface.LegacyContainers = lc
    UserSettingsChanged()
  
    ButtonSetStayDownFlag(this.wnd.."LegacyContainersButton", lc)
    ButtonSetPressedFlag(this.wnd.."LegacyContainersButton", lc)  
end

function this.ToggleQuickLoot()
  local s = not Interface.LoadBoolean("Lean.QuickLoot", false)
  ButtonSetStayDownFlag(this.wnd.."QuickLootButton", s)
  ButtonSetPressedFlag(this.wnd.."QuickLootButton", s)
  Interface.SaveBoolean("Lean.QuickLoot", s) 
end

function this.TogglePlayerNames()
  local s = not Interface.LoadBoolean("Lean.HidePlayerNames", false)
  ButtonSetStayDownFlag(this.wnd.."HideBluesButton", s)
  ButtonSetPressedFlag(this.wnd.."HideBluesButton", s)
  Interface.SaveBoolean("Lean.HidePlayerNames", s)     
end

function this.ToggleLootWindow()
  local s = not WindowGetShowing("LootWindow")
  WindowSetShowing("LootWindow", s)
  ButtonSetStayDownFlag(this.wnd.."LootWindowButton", s)
  ButtonSetPressedFlag(this.wnd.."LootWindowButton", s)  
end

function this.ToggleEncyclopedia()
  local s = not WindowGetShowing("MonsterWindow")
  WindowSetShowing("MonsterWindow", s)
  ButtonSetStayDownFlag(this.wnd.."EncyclopediaButton", s)
  ButtonSetPressedFlag(this.wnd.."EncyclopediaButton", s)
end

function this.ToggleStatusWindow()
  local s = not WindowGetShowing("StatusWindow")
  WindowSetShowing("StatusWindow", s)
  ButtonSetStayDownFlag(this.wnd.."StatusWindowButton", s)
  ButtonSetPressedFlag(this.wnd.."StatusWindowButton", s)  
end

function this.ToggleScan()
  local s = not ObjectScanner.enabled
  ObjectScanner.enabled = s
  ButtonSetStayDownFlag(this.wnd.."ScanButton", s)
  ButtonSetPressedFlag(this.wnd.."ScanButton", s)  
end

function this.ToggleMenubar()
  local s = not WindowGetShowing("MenuBarWindow")
  WindowSetShowing("MenuBarWindow", s)
  ButtonSetStayDownFlag(this.wnd.."MenubarButton", s)
  ButtonSetPressedFlag(this.wnd.."MenubarButton", s)
end

function this.ToggleTradeQuest()
  local wnd = "TradeQuestWindow"
  local s = not WindowGetShowing(wnd)
  WindowSetShowing(wnd, s)
  ButtonSetStayDownFlag(this.wnd.."TradeQuestButton", s)
  ButtonSetPressedFlag(this.wnd.."TradeQuestButton", s)
end

function this.OnRemoved(sidebar)

end

function this.OnUpdate(sidebar, timePassed)
  
end


function this.OnExpanded(sidebar)

end

function this.OnCollapsed(sidebar)

end