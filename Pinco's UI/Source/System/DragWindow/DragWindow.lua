----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

DragWindow = {}

DragWindow.CurrentItem = {}
----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------
 
----------------------------------------------------------------
-- DragWindow Functions
----------------------------------------------------------------
function DragWindow.Initialize()
    if SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM then
        WindowSetDimensions("DragWindow", SystemData.DragItem.itemWidth, SystemData.DragItem.itemHeight)
        WindowSetShowing("DragWindowAction",false)
        
        item = 
        {
			itemId = SystemData.DragItem.itemId,
            iconName = SystemData.DragItem.itemName,
            newWidth = SystemData.DragItem.itemWidth,
            newHeight = SystemData.DragItem.itemHeight,
            iconScale = SystemData.DragItem.itemScale,
            hueId = SystemData.DragItem.itemHueId,
            hue = SystemData.DragItem.itemHue,
			objectType = SystemData.DragItem.itemType,
			amount = SystemData.DragItem.DragAmount,
			itemdata = Interface.GetObjectInfoData(SystemData.DragItem.itemId)
        }
        DragWindow.CurrentItem = item

        EquipmentData.UpdateItemIcon("DragWindowItem", item)     

        DynamicImageSetTexture( "DragWindowIconMulti", "", 0, 0 ) 

		if item.itemdata then
			if not item.amount or item.amount ~= item.itemdata.quantity then
				item.amount = item.itemdata.quantity
			end
		elseif not item.amount then
			item.amount = 1
		end

		if SystemData.DragItem.DragAmount then
			item.amount = SystemData.DragItem.DragAmount
		end

		if item.itemdata and item.amount > 1 and item.objectType ~= 3821 and item.objectType ~= 3824 then
			EquipmentData.UpdateItemIcon("DragWindowIconMulti", item)  
		end

		if item.amount > 1 then
			LabelSetText("DragWindowQuantity", L"x" .. Knumber(item.amount))
		end

	elseif (SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ACTION) then
	    local x, y = WindowGetDimensions("DragWindowAction")
	    
	    local disabled = false
	    if (SystemData.DragItem.actionType == SystemData.UserAction.TYPE_MACRO_REFERENCE) then
			disabled = not UserActionIsTargetModeCompat(SystemData.MacroSystem.STATIC_MACRO_ID, SystemData.DragItem.actionId, 0)
	    else
			disabled = not UserActionIsActionTypeTargetModeCompat(SystemData.DragItem.actionType)
		end
		
        WindowSetDimensions("DragWindow", x, y)
        HotbarSystem.UpdateActionButton(nil, nil, nil, "DragWindowAction", SystemData.DragItem.actionType, SystemData.DragItem.actionId, SystemData.DragItem.actionIconId, disabled )
	    WindowSetShowing("DragWindowItem",false)
	    
	    WindowSetShowing("DragWindowActionHotkeyBackground",false)   
    end
    
    DragWindow.Update()
end

function DragWindow.Shutdown()
	if SystemData.DragItem.actionId ~= 0 then
		HotbarSystem.TerminateGlow = SystemData.DragItem.actionId
	end
	SystemData.DragItem.DragAmount = nil
	SystemData.DragItem.itemdata = nil
	SystemData.DragItem.actionId = 0
	SystemData.DragItem.actionType = 0
	SystemData.DragItem.actionIconId = 0
	SystemData.DragItem.itemId = 0
	SystemData.DragItem.itemHueId = 0
	SystemData.DragItem.itemType = 0
	ActionsWindow.LastDrag = nil
end

function DragWindow.Update()
    local posX = SystemData.MousePosition.x/InterfaceCore.scale
    local posY = SystemData.MousePosition.y/InterfaceCore.scale

    WindowClearAnchors("DragWindow")
    if (SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM) then
		WindowAddAnchor("DragWindow", "topleft", "Root", "center", posX, posY)
    elseif (SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ACTION) then
        WindowAddAnchor("DragWindow", "topleft", "Root", "topleft", posX, posY)
    end
    
    if (SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM) then
        WindowSetDimensions("DragWindow", SystemData.DragItem.itemWidth, SystemData.DragItem.itemHeight)
        WindowSetShowing("DragWindowAction",false)
        
        item = DragWindow.CurrentItem

        EquipmentData.UpdateItemIcon("DragWindowItem", item)     

        DynamicImageSetTexture( "DragWindowIconMulti", "", 0, 0 ) 

        if not item.itemdata then
			item.itemdata = Interface.GetObjectInfoData(item.itemId)
		end

		if item.itemdata then
			if not item.amount or item.amount ~= item.itemdata.quantity then
				item.amount = item.itemdata.quantity
			end
		elseif not item.amount then
			item.amount = 1
		end

		if SystemData.DragItem.DragAmount then
			item.amount = SystemData.DragItem.DragAmount
		end
		
		local amt = tonumber(LabelGetText("DragWindowQuantity"))
		
		if item.amount ~= amt and item.amount > 1 then
			LabelSetText("DragWindowQuantity", L"x" .. Knumber(item.amount))

			if item.itemdata and item.amount > 1 and item.objectType ~= 3821 and item.objectType ~= 3824 then
				EquipmentData.UpdateItemIcon("DragWindowIconMulti", item)  
			end
		end

		local alreadyInBar, existingSlot = HotbarSystem.ActionAlreadyInHotbar(item.itemId, "item", {type = SystemData.DragItem.itemType, hue = SystemData.DragItem.itemHueId} )
		if alreadyInBar and not HotbarSystem.GlowingItems[existingSlot] then
			HotbarSystem.GlowSlotWarning(existingSlot, 1, item.itemId)
		end

	elseif (SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ACTION and SystemData.DragItem.actionType == SystemData.UserAction.TYPE_SPELL) then
		
		local notarget = false

		-- check if the spells supports a target
		for _, value in pairs(SpellsInfo.SpellsData) do
			if value.id == SystemData.DragItem.actionId and value.notarget == true then
				notarget = true
				break
			end
		end

		if notarget then
			local alreadyInBar, existingSlot = HotbarSystem.ActionAlreadyInHotbar(SystemData.DragItem.actionId, SystemData.DragItem.actionType )
		
			if alreadyInBar and not HotbarSystem.GlowingItems[existingSlot] then
				HotbarSystem.GlowSlotWarning(existingSlot, 1, SystemData.DragItem.actionId)
			end
		end
	end
end
