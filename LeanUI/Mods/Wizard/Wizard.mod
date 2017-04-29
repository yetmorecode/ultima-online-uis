<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <UiMod name="Wizard" version="1.0">
        
        <Files>
            <File name="BlackMage.lua" />
            <File name="Movement.lua" />
            <File name="Mouse.lua" />
            <File name="Quest.lua" />
        </Files>
        
        <OnInitialize>
            <CallFunction name="BlackMage.Initialize" />
        </OnInitialize>
        <OnUpdate>
            <CallFunction name="Move.Update" />
            <CallFunction name="Quest.Update" />
        </OnUpdate>
    </UiMod>
</ModuleFile>
