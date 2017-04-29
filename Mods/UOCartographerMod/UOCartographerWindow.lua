UOCartographerWindow = {

    Initialize = function () 
	    RegisterWindowData(WindowData.Radar.Type,0)    
	    WindowRegisterEventHandler("UOCartographerWindow", WindowData.Radar.Event, "UOCartographerWindow.UpdateMap")
    end,
    
    UpdateMap = function () 
    	waypointX = WindowData.PlayerLocation.x
		waypointY = WindowData.PlayerLocation.y
		waypointFacet = WindowData.PlayerLocation.facet
		TextLogCreate("pos", 1)
		TextLogSetEnabled("pos", true)
		TextLogClear("pos")
		TextLogSetIncrementalSaving( "pos", true, "logs/pos.log")
		TextLogAddFilterType( "pos", 1, L"XY: " )
		TextLogAddEntry("pos", 1, L" "..waypointFacet..L","..waypointX..L","..waypointY..L"!")
		TextLogDestroy("pos")
    end,
    
    Shutdown = function ()
		UnregisterWindowData(WindowData.Radar.Type,0)
    end,
    
    Update = function ()
    
    end
}