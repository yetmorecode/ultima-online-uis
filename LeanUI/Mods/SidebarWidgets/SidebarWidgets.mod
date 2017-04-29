<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <UiMod name="SidebarWidgets" version="1.0">
        
        <Files>
            <File name="Widgets/StatusWidget/StatusWidget.lua" />
            <File name="Widgets/MainMenuWidget/MainMenuWidget.lua" />
            <File name="Widgets/HotbarWidget/HotbarWidget.lua" />
            <File name="Widgets/SettingsWidget/SettingsWidget.lua" />
            <File name="Widgets.lua" />
        </Files>
        
        <Dependencies>
          <Dependency name="Sidebar" />
        </Dependencies>
        
        <OnInitialize>
            <CallFunction name="SidebarWidgets.Initialize" />
        </OnInitialize>
    </UiMod>
</ModuleFile>
