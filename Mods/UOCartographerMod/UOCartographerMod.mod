<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <UiMod name="UOCartographerMod" version="0.1" date="04/26/2014">

        <Author name="petemage" email="" />
        <Description text="UOCartographer mod for EC without Pinco's UI" />
     
        <Files>
            <File name="Loader.lua" />
            <File name="UOCartographerMod.lua" />
        </Files>
        
        <OnInitialize>
            <CallFunction name="UOCartographerMod.Initialize" />
        </OnInitialize> 
        <OnUpdate>
            <CallFunction name="UOCartographerMod.Update" />
        </OnUpdate>
        <OnShutdown>
            <CallFunction name="UOCartographerMod.Shutdown" />
        </OnShutdown>
    </UiMod>
</ModuleFile>
