<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <UiMod name="AL" version="1.0" date="09/28/2014">
        <Description text="AL" />
        
        <Files>
            <File name="ALManager.lua" />
        </Files>
        
        <OnInitialize>
            <CallFunction name="ALManager.Initialize" />
        </OnInitialize> 
        <OnShutdown>
            <CallFunction name="ALManager.Shutdown" />
        </OnShutdown>
    </UiMod>
</ModuleFile>
