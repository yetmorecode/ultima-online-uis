
----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------


----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

GenericQuantity = { }
GenericQuantity.maxAmount = 1

----------------------------------------------------------------
-- GenericQuantity Functions
----------------------------------------------------------------

function GenericQuantity.Initialize()
	local windowName = "GenericQuantityWindow"
	local buttonName = windowName.."Button"
	local sliderName = windowName.."SliderBar"

    Interface.OnCloseCallBack[windowName] = GenericQuantity.OnCancel
	
	TextEditBoxSetText(windowName.."AmountInput", L""..SystemData.DragItem.GenericQuantity)
	WindowAssignFocus(windowName.."AmountInput", true)
	TextEditBoxSelectAll(windowName.."AmountInput")
	ButtonSetText(buttonName, GetStringFromTid(3000093) )-- "Okay"
	SliderBarSetCurrentPosition( sliderName, GenericQuantity.maxAmount )
	
	GenericQuantity.HandleAnchorWindow(windowName)
end

--Sets the Window close to where the player dragged their mouse
function GenericQuantity.HandleAnchorWindow(genericWindow)
	-- Set the window position
	local windowOffset = -20
	
    local posX = SystemData.MousePosition.x/InterfaceCore.scale + windowOffset
    local posY = SystemData.MousePosition.y/InterfaceCore.scale + windowOffset
	
	WindowClearAnchors(genericWindow)
	WindowAddAnchor(genericWindow, "topleft", "Root", "topleft", posX, posY)
	WindowSetMoving(genericWindow,true)
end

function GenericQuantity.Shutdown()
end

function GenericQuantity.OnKeyEscape()
	GenericQuantity.OnCancel()
end
				
function GenericQuantity.OnKeyEnter()
	GenericQuantity.OnOkay()
end

function GenericQuantity.OnTextChanged()
	local windowName = "GenericQuantityWindow"
	local sliderName = windowName.."SliderBar"
	local quantityLabel = windowName.."AmountInput"
	local amount = SystemData.DragItem.GenericQuantity
	local quantityInputText = TextEditBoxGetText(quantityLabel)
	local outputNum = nil
	if( quantityInputText ~= nil ) then
	    outputNum = tonumber(WStringToString(quantityInputText))
	end
	
	if( outputNum ~= nil) then	
		if( outputNum > amount ) then
			outputNum = amount
			TextEditBoxSetText(quantityLabel, L""..outputNum)
		end	
		
		local slideAmount =  (outputNum/amount) * GenericQuantity.maxAmount
		SliderBarSetCurrentPosition( sliderName, slideAmount )
	else
		SliderBarSetCurrentPosition( sliderName, 0 )
	end
end

function GenericQuantity.OnMouseWheel(x, y, direction)
	local input = TextEditBoxGetText("GenericQuantityWindowAmountInput")
	local value = tonumber(WStringToString(input))
	local max = SystemData.DragItem.GenericQuantity
	local step = math.floor(max / 15)
	if step < 1 then
		step = 1
	end
	
	if direction == 1 then
		value = value + step
		if value > max then
			value = max
		end
	else
		if value > step then
			value = value - step
		else
			value = 0
		end 
	end
	
	TextEditBoxSetText("GenericQuantityWindowAmountInput", L""..value)
end

function GenericQuantity.UpdateQuantity()
	local this = "GenericQuantityWindow"
	local quantityLabel = this.."AmountInput"
	local sliderName = this.."SliderBar"
	local amount = SystemData.DragItem.GenericQuantity
	local quantiyAmount = math.floor(amount * SliderBarGetCurrentPosition(sliderName))
	TextEditBoxSetText( quantityLabel, L""..quantiyAmount)
end

function GenericQuantity.OnOkay()
	quantityInputText = TextEditBoxGetText("GenericQuantityWindowAmountInput")	
	outputNum = tonumber(WStringToString(quantityInputText))
    DragSlotQuantityRequestResult(outputNum)
end

function GenericQuantity.OnCancel()
    DragSlotQuantityRequestResult(0)
end