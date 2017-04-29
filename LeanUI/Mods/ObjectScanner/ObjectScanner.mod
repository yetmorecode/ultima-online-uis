<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <UiMod name="ObjectScanner" version="1.0" date="07/24/2089">

        <Author name="foo" email="foo" />
     
        <Files>
            <File name="ObjectScanner.lua" />
        </Files>
        
        <OnInitialize>
            <CallFunction name="ObjectScanner.Initialize" />
        </OnInitialize>
        <OnUpdate>
            <CallFunction name="ObjectScanner.Update" />
        </OnUpdate>
    </UiMod>
</ModuleFile>
