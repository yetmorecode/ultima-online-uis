
local this = {}

SidebarMainMenuWidget = this

this.Name = "Mainmenu Widget"
this.Description = "A widget replacing the main menu"

this.wnd = "MainMenuWidget"
this.template = this.wnd.."Template"

local modFolder = "./UserInterface/"..SystemData.Settings.Interface.customUiName.."/Mods/SidebarWidgets/Widgets/"..this.wnd
LoadResources(modFolder, this.wnd..".xml", this.wnd..".xml")

function this.OnAdded(sidebar)

  this.sidebar = sidebar
  
  
end

function this.OnCreateWindow(sidebar, width, parent)
  CreateWindowFromTemplateShow(this.wnd, this.template, parent, true)
  
  LabelSetText(this.wnd.."ToggleProfileLabel", L"Paperdoll")
  LabelSetText(this.wnd.."ToggleMapLabel", L"Map")
  LabelSetText(this.wnd.."ToggleSkillsLabel", L"Skills")
  LabelSetText(this.wnd.."ToggleQuestsLabel", L"Quests")
  LabelSetText(this.wnd.."ToggleActionsLabel", L"Actions")
  LabelSetText(this.wnd.."ToggleSettingsLabel", L"Settings")
  
  LabelSetText(this.wnd.."ToggleMacrosLabel", L"Macros")
  LabelSetText(this.wnd.."ToggleAgentsLabel", L"Agents")
  LabelSetText(this.wnd.."ToggleHelpLabel", L"Help")
  LabelSetText(this.wnd.."ToggleVirtuesLabel", L"Virtues")
  LabelSetText(this.wnd.."ToggleChatLabel", L"Chat")
  LabelSetText(this.wnd.."ToggleGuildLabel", L"Guild")
  LabelSetText(this.wnd.."LogoutLabel", L"Logout")
  LabelSetText(this.wnd.."ExitLabel", L"Exit")
end

function this.OnPaperdoll()
  local playerId = WindowData.PlayerStatus.PlayerId
  local windowName = "PaperdollWindow"..playerId

  if DoesWindowNameExist(windowName) then
      DestroyWindow(windowName)
  else
      UserActionUseItem(playerId, true)
  end
end

function this.OnMap()
  if WindowGetShowing("RadarWindow") then
    MapWindow.ActivateMap()
  else
    RadarWindow.ActivateRadar()
  end   
end

function this.OnSettings()
  ToggleWindowByName( "SettingsWindow", "", MainMenuWindow.ToggleSettingsWindow )
end

function this.OnSkills()
  SkillsWindow.ToggleSkillsWindow()
end

function this.OnVirtues()
  BroadcastEvent( SystemData.Events.REQUEST_OPEN_VIRTUES_LIST )
end

function this.OnActions()
  ToggleWindowByName( "ActionsWindow", "", MainMenuWindow.OnOpenActions )
end

function this.OnAgents()
  ToggleWindowByName( "OrganizerWindow", "", MainMenuWindow.OnToggleAgentsSettings )
end

function this.OnHelp()
  BroadcastEvent( SystemData.Events.REQUEST_OPEN_HELP_MENU )
end

function this.OnQuests()
  BroadcastEvent( SystemData.Events.REQUEST_OPEN_QUEST_LOG )
end

function this.OnMacros()
  ToggleWindowByName( "MacroWindow", "", MainMenuWindow.OnOpenMacros )
end

function this.OnChat()
  MenuBarWindow.ToggleChatWindow()
end

function this.OnGuild()
  BroadcastEvent(SystemData.Events.REQUEST_OPEN_GUILD_WINDOW)
end

function this.OnLogout()
  BroadcastEvent(SystemData.Events.LOG_OUT)
end

function this.OnRemoved(sidebar)

end

function this.OnUpdate(sidebar, timePassed)

end

function this.OnExpanded(sidebar)

end

function this.OnCollapsed(sidebar)

end