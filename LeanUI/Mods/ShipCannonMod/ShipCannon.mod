<?xml version="1.0" encoding="windows-1252"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <UiMod name="ShipCannonMod" version="0.1" date="03/27/2019">
        <Files>
            <File name="ShipCannon.lua" />
            <File name="ShipCannonManager.lua" />
        </Files>
        
        <OnInit>
            <CallFunction name="ShipCannonManager.Init" />
        </OnInit>
        <OnUpdate>
            <CallFunction name="ShipCannonManager.Update" />
        </OnUpdate>
    </UiMod>
</ModuleFile>
