<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <UiMod name="TradeQuest" version="1.0">
        
        <Files>
            <File name="Actions/TQRecallAction.lua" />
            <File name="Actions/TQGetQuestAction.lua" />
            <File name="Actions/TQMoveToShopAction.lua" />
            <File name="Actions/TQShopAction.lua" />
            <File name="Actions/TQMoveToGateAction.lua" />
            <File name="Actions/TQGateAction.lua" />
            <File name="Actions/TQMoveToDestinationAction.lua" />
            <File name="Actions/TQMoveToAltShopAction.lua" />
            <File name="Actions/TQSubmitCrateAction.lua" />
            <File name="Actions/TQBoSAction.lua" />
            <File name="TradeQuest.lua" />
        </Files>
        
        <Dependencies>
            <Dependency name="Wizard" />
            <Dependency name="LeanWindowManager" />
        </Dependencies>
        
        <OnInitialize>
            <CallFunction name="TradeQuest.Initialize" />
        </OnInitialize>

    </UiMod>
</ModuleFile>
