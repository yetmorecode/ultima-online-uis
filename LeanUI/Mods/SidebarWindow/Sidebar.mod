<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <UiMod name="Sidebar" version="1.0">
        
        <Files>
            <File name="Resources.lua" />
            <File name="SidebarWindow.lua" />
        </Files>
        
        <OnInitialize>
            <CallFunction name="SidebarWindow.Initialize" />
        </OnInitialize>
        <OnUpdate>
            <CallFunction name="SidebarWindow.Update" />
        </OnUpdate>
        <OnShutdown>
            <CallFunction name="SidebarWindow.Shutdown" />
        </OnShutdown>
    </UiMod>
</ModuleFile>
