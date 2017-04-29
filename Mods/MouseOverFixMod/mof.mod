<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <UiMod name="Timer" version="1.0" date="07/24/2089">

        <Author name="pete" email="petemage" />
        <Description text="Fixes Publish 86 RC1 mouse-over EC issue" />
     
        <Files>
            <File name="mof.lua" />
        </Files>
        
        <OnInitialize>
            <CallFunction name="mof.Initialize" />
        </OnInitialize>
        <OnUpdate>
            <CallFunction name="mof.Update" />
        </OnUpdate>
    </UiMod>
</ModuleFile>
