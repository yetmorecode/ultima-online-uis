----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

ColorPickerWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

ColorPickerWindow.numColorsPerRow = 5
ColorPickerWindow.swatchSize = 47
ColorPickerWindow.colorTables = {}
ColorPickerWindow.colorSelected = {}
ColorPickerWindow.frameEnabled = true
ColorPickerWindow.closeButtonEnabled = true
ColorPickerWindow.xPadding = 10
ColorPickerWindow.yPadding = 15

----------------------------------------------------------------
-- MainMenuWindow Functions
----------------------------------------------------------------

-- OnInitialize Handler
function ColorPickerWindow.Initialize()
	local this = SystemData.ActiveWindow.name
	local id = SystemData.DynamicWindowId
	WindowSetId(this, id)
	
	ColorPickerWindow[id] = {}
	
	Interface.DestroyWindowOnClose[this] = true
end

function ColorPickerWindow.SetColorTable(colorTable, parent)
	ColorPickerWindow.colorTables[parent] = nil
	ColorPickerWindow.colorTables[parent] = colorTable        
end

function ColorPickerWindow.SetNumColorsPerRow(numColorsPerRow)
	ColorPickerWindow.numColorsPerRow = numColorsPerRow        
end

function ColorPickerWindow.SetSwatchSize(newSize)
    ColorPickerWindow.swatchSize = newSize
end

function ColorPickerWindow.SetWindowPadding(x,y)
    ColorPickerWindow.xPadding = x
    ColorPickerWindow.yPadding = y
end

function ColorPickerWindow.SetFrameEnabled(enabled)
    ColorPickerWindow.frameEnabled = enabled
end

function ColorPickerWindow.SetCloseButtonEnabled(enabled)
    ColorPickerWindow.closeButtonEnabled = enabled
end

function ColorPickerWindow.DrawColorTable(parent)
    local numInRow = 0
    local firstRowWindow = nil
    local currentColorWindowName = nil
    local relativeAnchorColorWindowName = nil
    local first = true
    local red, green, blue, alpha = nil

    local windowWidth = (ColorPickerWindow.numColorsPerRow * ColorPickerWindow.swatchSize) + ColorPickerWindow.xPadding
    local windowHeight = ( math.ceil((#ColorPickerWindow.colorTables[parent]/ColorPickerWindow.numColorsPerRow)) * ColorPickerWindow.swatchSize) + ColorPickerWindow.yPadding + 35
    WindowSetDimensions(parent, windowWidth, windowHeight)

    for key, hueNumber in pairs(ColorPickerWindow.colorTables[parent])  do
        currentColorWindowName = parent..tostring(key)
        
        if (not DoesWindowExist( currentColorWindowName )) then
			CreateWindowFromTemplate( currentColorWindowName, "ColorPickerWindowColorItemTemplate", parent )
		end
        
        red, green, blue, alpha  = HueRGBAValue(hueNumber)
		--Debug.Print("hueNumber "..hueNumber.." = ".." red = "..red..", green = "..green..", blue = "..blue)
		WindowSetDimensions(currentColorWindowName,ColorPickerWindow.swatchSize,ColorPickerWindow.swatchSize)
        WindowSetTintColor(currentColorWindowName.."Color", red, green, blue)
		WindowSetId(currentColorWindowName, hueNumber)
        WindowSetShowing(currentColorWindowName.."Frame", false)
        WindowClearAnchors(currentColorWindowName)
        if (first) then 
            WindowAddAnchor( currentColorWindowName, "topleft", parent, "topleft", 0, 35)
            relativeAnchorColorWindowName = currentColorWindowName
            firstRowWindow = currentColorWindowName
            if ColorPickerWindow.colorSelected[parent] == nil then
                ColorPickerWindow.colorSelected[parent] = hueNumber
            end
            first = false
        elseif (numInRow < ColorPickerWindow.numColorsPerRow-1) then
            WindowAddAnchor( currentColorWindowName, "topright", relativeAnchorColorWindowName, "topleft", 0, 0)
            numInRow = numInRow + 1
            relativeAnchorColorWindowName = currentColorWindowName
        elseif (numInRow == ColorPickerWindow.numColorsPerRow-1) then
            WindowAddAnchor( currentColorWindowName, "bottomleft", firstRowWindow, "topleft", 0, 0)
            numInRow = 0
            relativeAnchorColorWindowName = currentColorWindowName
            firstRowWindow =  currentColorWindowName                     
        end                
        if (ColorPickerWindow.frameEnabled and ColorPickerWindow.colorSelected[parent] == hueNumber) then
            WindowSetShowing(currentColorWindowName.."Frame", true)
        end
    end

	-- Add background and frame to colorpicker window
	if (not DoesWindowExist( parent.."Background" )) then
		CreateWindowFromTemplate( parent.."Background", "UO_Simple_Black_Background", parent )
	end
	WindowClearAnchors(parent.."Background")
	WindowAddAnchor( parent.."Background", "topleft", parent, "topleft", 0, 0)
	WindowAddAnchor( parent.."Background", "bottomright", parent, "bottomright", 0, 0)
	
	if (not DoesWindowExist( parent.."Frame" )) then
		CreateWindowFromTemplate( parent.."Frame", "UO_Default_Inner_Window_Frame", parent )
	end
	WindowClearAnchors(parent.."Frame")
	WindowAddAnchor( parent.."Frame", "topleft", parent, "topleft", 0, 0)
	WindowAddAnchor( parent.."Frame", "bottomright", parent, "bottomright", 0, 0)
	
	-- hide close button if its not enabled
	if (ColorPickerWindow.closeButtonEnabled == false) then
	    WindowSetShowing( parent.."CloseButton", false )
	end
end

function ColorPickerWindow.RGBToHue(parent, r,g,b,a)
	if not parent or not ColorPickerWindow.colorTables or not ColorPickerWindow.colorTables[parent] or not r or not g or not b then
		return 0
	end
	for key, hueNumber in pairs(ColorPickerWindow.colorTables[parent]) do

		local red, green, blue, alpha  = HueRGBAValue(hueNumber)

		if red == r and green == g and blue == b and alpha == a then
			return hueNumber
		end
	end
	return 0
end

function ColorPickerWindow.DisableAllFrames(win)
	for key, hueNumber in pairs(ColorPickerWindow.colorTables[win]) do
		if DoesWindowExist(win..hueNumber.."Frame") then
			WindowSetShowing(win..hueNumber.."Frame", false)	
		end
	end
end

function ColorPickerWindow.SelectColor(win, hue)
	
	ColorPickerWindow.DisableAllFrames(win)
	
	if type(hue) == "table" then
		hue = ColorPickerWindow.RGBToHue(win, hue.r,hue.g,hue.b, hue.a)
	end
	ColorPickerWindow.colorSelected[win]= hue
	if ColorPickerWindow.frameEnabled then
		WindowSetShowing(win..ColorPickerWindow.colorSelected[win].."Frame", true)
	end
end

function ColorPickerWindow.SetColor()
    local parent = WindowGetParent(SystemData.ActiveWindow.name)
	if (ColorPickerWindow.colorSelected[parent] and ColorPickerWindow.frameEnabled == true) then
    	ColorPickerWindow.DisableAllFrames(parent)
	end
    
	ColorPickerWindow.colorSelected[parent] = WindowGetId(SystemData.ActiveWindow.name)
	if (ColorPickerWindow.frameEnabled == true) then
        WindowSetShowing(parent..ColorPickerWindow.colorSelected[parent].."Frame", true)
    end
    WindowSetShowing(parent, false)
        
    ColorPickerWindow.AfterColorSelectionFunction(parent)
end

function ColorPickerWindow.AfterColorSelectionFunction(parent)
	return
end

function ColorPickerWindow.SetAfterColorSelectionFunction(funcCall)
	ColorPickerWindow.AfterColorSelectionFunction = funcCall        
end

-- BE CAREFUL IF YOU REINITIALIZE THE COLORPICKERWINDOW WITH SAME COLOR TABLE, IT WILL BE WHONKY!
function ColorPickerWindow.ClearWindow(parent)
	for key, hueNumber in pairs(ColorPickerWindow.colorTables[parent])  do
		DestroyWindow(parent..tostring(hueNumber))	
	end
end

function ColorPickerWindow.SetHue(hueNumber, parent)
	--Debug.Print("ColorPickerWindow.SetHue() hueNumber = "..tostring(hueNumber).." parent = "..parent)
    
	if (ColorPickerWindow.colorSelected[parent] and ColorPickerWindow.frameEnabled == true) then
    	WindowSetShowing(parent..ColorPickerWindow.colorSelected[parent].."Frame", false)
	end
    
	ColorPickerWindow.colorSelected[parent] = hueNumber
	if (ColorPickerWindow.frameEnabled == true) then
        WindowSetShowing(parent..ColorPickerWindow.colorSelected[parent].."Frame", true)
    end
    WindowSetShowing(parent, false)
end
