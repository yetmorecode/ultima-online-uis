UOCartographerMod = {
	--
	-- Module lifecycle methods
	--
	Initialize = function ()
		Debug.PrintToChat(L"UOCartographerMod loaded")
		
		CreateWindow("UOCartographerWindow", false)
	end,
	
	Update = function (timePassed)
	
	end,
	
	Shutdown = function () 
		DestroyWindow("UOCartographerWindow")
	end
}