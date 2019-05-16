<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <UiMod name="GumpExplorer" version="1.0" date="09/28/2014">
        <Description text="GumpExplorer" />
     
        <Files>
            <File name="GumpExplorer.lua" />
        </Files>
        
        <OnInitialize>
            <CallFunction name="GumpExplorer.Initialize" />
        </OnInitialize> 
        <OnShutdown>
            <CallFunction name="GumpExplorer.Shutdown" />
        </OnShutdown>
    </UiMod>
</ModuleFile>
