<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <UiMod name="DG" version="1.0" date="09/28/2014">
        <Description text="DG" />
        
        <Files>
            <File name="DarkGuardians.lua" />
        </Files>
        
        <OnInitialize>
            <CallFunction name="DarkGuardians.Initialize" />
        </OnInitialize>
        <OnUpdate>
            <CallFunction name="DarkGuardians.Update" />
        </OnUpdate> 
        <OnShutdown>
            <CallFunction name="DarkGuardians.Shutdown" />
        </OnShutdown>
    </UiMod>
</ModuleFile>
