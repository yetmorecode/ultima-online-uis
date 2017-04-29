<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <UiMod name="Encyclopedia" version="1.0">
        
        <Files>
            <File name="Encyclopedia.lua" />
        </Files>
        
        <OnInitialize>
            <CallFunction name="Encyclopedia.Initialize" />
        </OnInitialize>
        <OnShutdown>
            <CallFunction name="Encyclopedia.Shutdown" />
        </OnShutdown>
    </UiMod>
</ModuleFile>
