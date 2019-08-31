----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

HuePickerWindow = {}

HuePickerWindow.NUM_COLORS = 200
HuePickerWindow.COLORS_PER_ROW = 20
HuePickerWindow.SWATCH_SIZE = 15

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

----------------------------------------------------------------
-- MainMenuWindow Functions
----------------------------------------------------------------


function HuePickerWindow.PickColor(id, huePicked, this)
	--Debug.Print(huePicked)
	HuePickerColorSelected(id,DyeTubs.ListType,huePicked)
	
	DestroyWindow(this)
end


function HuePickerWindow.RequestTargetInfo()
	local windowName = SystemData.ActiveWindow.name
	RequestTargetInfo(HuePickerWindow.RequestTargetInfoReceived)
end

function HuePickerWindow.RequestTargetInfoReceived(objectId)
	local windowName = SystemData.ActiveWindow.name
	
	local this = SystemData.ActiveWindow.name
    local huePickerWindow = WindowGetParent(this)
    if IsValidID(objectId) then 
		local id = WindowGetId(huePickerWindow)
		HuePickerWindow.PickColor(id, GetItemHue(objectId), huePickerWindow)
    end
end

function HuePickerWindow.ColorPicked(windowName)
    local huePicked = ColorPickerWindow.colorSelected[windowName]    	
    local huePickerWindow = WindowGetParent(windowName)
    local id = WindowGetId(huePickerWindow)
	WindowSetShowing(windowName, true)
	HuePickerWindow.PickColor(id,huePicked, huePickerWindow)
end