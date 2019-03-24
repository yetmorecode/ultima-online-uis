<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <UiMod name="OverheadTextMod" version="1.0">
        <Files>
            <File name="OverhideTextService.lua" />
            <File name="OverhideTextWindow.lua" />
        </Files>

        <OnInitialize>
            <CallFunction name="OverhideTextService.Initialize" />
        </OnInitialize>
    </UiMod>
</ModuleFile>
