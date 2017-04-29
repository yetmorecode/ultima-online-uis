<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <UiMod name="LeanChat" version="1.0" date="09/28/2014">
        <Description text="LeanChat" />
     
        <Files>
            <File name="ChatSettings.lua" />
            <File name="LeanChat.lua" />
        </Files>
        
        <Dependencies>
            <Dependency name="LeanWindowManager" />
        </Dependencies>
        
        <OnInitialize>
            <CallFunction name="LeanChat.Initialize" />
        </OnInitialize> 
        <OnShutdown>
            <CallFunction name="LeanChat.Shutdown" />
        </OnShutdown>
    </UiMod>
</ModuleFile>
