----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

ClockWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

ClockWindow.MouseOverEnd = false
ClockWindow.AlphaDiff = 0.006
ClockWindow.Alpha = 0.6
ClockWindow.Locked = false
ClockWindow.KeepFrame = false
ClockWindow.KeepBG = false
ClockWindow.Clockcolor = {r=255,g=255,b=255}

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function ClockWindow.Initialize()
	local parent = "ClockWindow"
	WindowSetAlpha( parent.."WindowBackground", ClockWindow.Alpha )
	WindowSetShowing(parent.."WindowBackground", true)
	WindowSetShowing(parent.."Frame", true)
	--ColorPicker
	local defaultColors = {
		0, --HUE_NONE 
		34, --HUE_RED
		53, --HUE_YELLOW
		63, --HUE_GREEN
		89, --HUE_BLUE
		119, --HUE_PURPLE
		144, --HUE_ORANGE
		368, --HUE_GREEN_2
		946, --HUE_GREY
	}
	local hueTable = {}
	for idx, hue in pairs(defaultColors) do
		for i=0,8 do
			hueTable[(idx-1)*10+i+1] = hue+i
		end
	end
	if not DoesWindowExist("ClockColorPicker") then
		CreateWindowFromTemplate( "ClockColorPicker", "ColorPickerWindowTemplate", "Root" )
		WindowSetShowing("ClockColorPicker", false)
		WindowSetLayer( "ClockColorPicker", Window.Layers.SECONDARY	)
		ColorPickerWindow.SetNumColorsPerRow(9)
		ColorPickerWindow.SetSwatchSize(30)
		ColorPickerWindow.SetWindowPadding(4,4)
		ColorPickerWindow.SetFrameEnabled(true)
		ColorPickerWindow.SetCloseButtonEnabled(true)
		ColorPickerWindow.SetColorTable(hueTable,"ClockColorPicker")
		ColorPickerWindow.DrawColorTable("ClockColorPicker")
	end
	
	--restore Settings
	WindowUtils.RestoreWindowPosition(parent)
	ClockWindow.ReloadSettings()
	SnapUtils.SnappableWindows["ClockWindow"] = true
end


function ClockWindow.OnRClick()
	
	-- reset the context menu
	ContextMenu.CleanUp()

	if (ClockWindow.Locked == false) then
		ContextMenu.CreateLuaContextMenuItem({tid = 1111697, returnCode = "Lock"})
	else
		ContextMenu.CreateLuaContextMenuItem({tid = 1111696, returnCode = "Unlock"})
	end
	local subMenu = {
	{ str=L"24h",  returnCode="24", pressed= not ClockWindow.Twelve},
	{ str=L"12h",  returnCode="12", pressed= ClockWindow.Twelve},
	{ str=GetStringFromTid(13),  returnCode="KeepFrame",pressed= ClockWindow.KeepFrame},
	{ str=GetStringFromTid(14),  returnCode="KeepBG",pressed= ClockWindow.KeepBG},
	{ tid=1079312,  returnCode="Color"}
	}
	ContextMenu.CreateLuaContextMenuItem({tid = 11, subMenuOptions = subMenu})
	ContextMenu.CreateLuaContextMenuItem({tid = 12, returnCode = "Disable"})
	ContextMenu.ActivateLuaContextMenu(ClockWindow.ContextMenuCallback)
end

function ClockWindow.OnMouseDrag()
	if (not ClockWindow.Locked) then
		SnapUtils.StartWindowSnap("ClockWindow")
		WindowSetMoving("ClockWindow",true)
	else
		WindowSetMoving("ClockWindow",false)
	end

end

function ClockWindow.ContextMenuCallback( returnCode, param )
	--Context Callback
	if (returnCode == "Lock") then
		ClockWindow.Locked = true
		Interface.SaveSetting( "ClockWindowLocked", ClockWindow.Locked)
	end
	if (returnCode == "Unlock") then
		ClockWindow.Locked = false
		Interface.SaveSetting( "ClockWindowLocked", ClockWindow.Locked)
	end
	if (returnCode == "12") then
		ClockWindow.Twelve = true
		Interface.SaveSetting( "ClockWindowTwelve", ClockWindow.Twelve )
	end
	if (returnCode == "24") then
		ClockWindow.Twelve = false
		Interface.SaveSetting( "ClockWindowTwelve", ClockWindow.Twelve )	
	end
	if (returnCode == "KeepFrame") then
		ClockWindow.KeepFrame = not ClockWindow.KeepFrame
		Interface.SaveSetting( "ClockKeepFrame", ClockWindow.KeepFrame )	
	end
	if (returnCode == "KeepBG") then
		ClockWindow.KeepBG = not ClockWindow.KeepBG
		Interface.SaveSetting( "ClockKeepBG", ClockWindow.KeepBG )	
	end
	if (returnCode =="Disable") then
		Interface.Settings.ClockEnabled = false
		Interface.SaveSetting( "ClockEnabled", Interface.Settings.ClockEnabled )
		--ButtonSetPressedFlag( "SettingsPincoClockButton", Interface.Settings.ClockEnabled )
	end
	if (returnCode =="Color") then
		ColorPickerWindow.SetAfterColorSelectionFunction(ClockWindow.ColorPicked)
		WindowClearAnchors( "ClockColorPicker" )
		WindowAddAnchor( "ClockColorPicker", "topleft", "ClockWindowClock", "topleft", 0, 25)
		WindowSetShowing( "ClockColorPicker", true )
		ColorPickerWindow.SelectColor("ClockColorPicker", ClockWindow.Clockcolor)
	end
	ClockWindow.ReloadSettings()
end

function ClockWindow.ColorPicked()
	--Set Color of the clock
	local red, green, blue, alpha
	local huePicked = ColorPickerWindow.colorSelected["ClockColorPicker"]
	red, green, blue, alpha  = HueRGBAValue(huePicked)
	LabelSetTextColor("ClockWindowClock", red, green, blue)
	ClockWindow.Clockcolor = {r=red, g=green, b=blue, a=alpha}
	Interface.SaveSetting( "ClockColor", ClockWindow.Clockcolor )

end

function ClockWindow.ReloadSettings()
	ClockWindow.Locked = Interface.LoadSetting( "ClockWindowLocked", ClockWindow.Locked )
	ClockWindow.Twelve = Interface.LoadSetting( "ClockWindowTwelve", ClockWindow.Twelve, true )
	ClockWindow.Clockcolor = Interface.LoadSetting( "ClockColor", ClockWindow.Clockcolor )
	ClockWindow.KeepFrame = Interface.LoadSetting( "ClockKeepFrame", ClockWindow.KeepFrame )
	ClockWindow.KeepBG = Interface.LoadSetting( "ClockKeepBG", ClockWindow.KeepBG )
	--Lock Status and Disable Status
	WindowSetShowing("ClockWindow", Interface.Settings.ClockEnabled)
	WindowSetMovable("ClockWindow", not ClockWindow.Locked)
	--Color
	LabelSetTextColor("ClockWindowClock", ClockWindow.Clockcolor.r, ClockWindow.Clockcolor.g, ClockWindow.Clockcolor.b)
	--24/12 Settings fit the label to center
	if (ClockWindow.Twelve == true) then
		WindowClearAnchors("ClockWindowClock")
		WindowAddAnchor("ClockWindowClock","topleft","ClockWindow","topleft",10,12)
	else
		WindowClearAnchors("ClockWindowClock")
		WindowAddAnchor("ClockWindowClock","topleft","ClockWindow","topleft",25,12)
	end	
	ClockWindow.Update()
	ClockWindow.MouseOverEnd()
end

function ClockWindow.OnMouseOver()
	local parent = "ClockWindow"
	--only if the window is not locked
	if (ClockWindow.Locked == false) then
		WindowStopAlphaAnimation(parent.."WindowBackground")
		WindowStopAlphaAnimation(parent.."Frame")
		WindowSetAlpha(parent.."WindowBackground", ClockWindow.Alpha )
		WindowSetAlpha(parent.."Frame", 1 )
		WindowSetShowing(parent.."WindowBackground", true)
		WindowSetShowing(parent.."Frame", true)
	end
end

function ClockWindow.MouseOverEnd()
	local parent = "ClockWindow"
	if not ClockWindow.KeepFrame then
		WindowStartAlphaAnimation(parent.."Frame", Window.AnimationType.SINGLE_NO_RESET, 1, ClockWindow.AlphaDiff, 1, false, 0, 0)
	end
	if not ClockWindow.KeepBG then
		WindowStartAlphaAnimation(parent.."WindowBackground", Window.AnimationType.SINGLE_NO_RESET, ClockWindow.Alpha, ClockWindow.AlphaDiff, 1, false, 0, 0)
	end
end


function ClockWindow.Update(updateTimePassed)
	local parent = "ClockWindow"
	--Update Clock
	--  Label
		local clockhstr = 0
		local clockmstr = 0
		local clocksstr = 0
	-- 24h/12h Setting
	if (ClockWindow.Twelve == true) then
		if (Interface.Clock.h > 12) then
			local clockhstrtwlv = Interface.Clock.h - 12
			if (clockhstrtwlv < 10) then
				clockhstr = "0"..tostring(clockhstrtwlv)
			else
				clockhstr = tostring(clockhstrtwlv)
			end
		else
			if (Interface.Clock.h < 10) then
				clockhstr = "0"..tostring(Interface.Clock.h)
			else
				clockhstr = tostring(Interface.Clock.h)
			end
		end
	else
		if (Interface.Clock.h < 10) then
			clockhstr = "0"..tostring(Interface.Clock.h)
		else
			clockhstr = tostring(Interface.Clock.h)
		end
	end
	if (Interface.Clock.m < 10) then
		clockmstr = "0"..tostring(Interface.Clock.m)
	else
		clockmstr = tostring(Interface.Clock.m)
	end
	if (Interface.Clock.s < 10) then
		clocksstr = "0"..tostring(Interface.Clock.s)
	else
		clocksstr = tostring(Interface.Clock.s)
	end
	local clockstring = clockhstr.." : "..clockmstr.." : "..clocksstr
	--24/12 am pm
	if (ClockWindow.Twelve == true) then
		if (Interface.Clock.h > 12) then
			clockstring = clockstring.." pm"
		else
			clockstring = clockstring.." am"
		end	
	end
	local clockwstring = towstring(clockstring)
	LabelSetText("ClockWindowClock", clockwstring)
	--Statistics Window	
end



function ClockWindow.Shutdown()
	WindowUtils.SaveWindowPosition("ClockWindow")
	SnapUtils.SnappableWindows["ClockWindow"] = nil
end
