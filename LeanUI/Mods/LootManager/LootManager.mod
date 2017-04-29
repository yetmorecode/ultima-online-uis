<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <UiMod name="LootManager" version="1.0" date="07/24/2089">

        <Author name="foo" email="foo" />
     
        <Files>
            <File name="Loader.lua" />
            <File name="LootManager.lua" />
        </Files>
        
        <OnInitialize>
            <CallFunction name="LootManager.Initialize" />
        </OnInitialize>
        <OnUpdate>
            <CallFunction name="LootManager.Update" />
        </OnUpdate>
    </UiMod>
</ModuleFile>
