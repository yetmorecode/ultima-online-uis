----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

TargetWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

TargetWindow.TargetId = 0
TargetWindow.HasTarget = false
TargetWindow.TargetType = 0
TargetWindow.MobileType = 2
TargetWindow.ObjectType = 3
TargetWindow.CorpseType = 4

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function TargetWindow.Initialize()
  StatusBarSetCurrentValue( "TargetWindowHealthBar", 0 )
	StatusBarSetMaximumValue( "TargetWindowHealthBar", 100 )

	RegisterWindowData(WindowData.CurrentTarget.Type,0)
	WindowRegisterEventHandler( "TargetWindow", WindowData.CurrentTarget.Event, "TargetWindow.UpdateTarget")
	WindowRegisterEventHandler( "TargetWindow", WindowData.MobileStatus.Event, "TargetWindow.MobileStatusUpdate")
	WindowRegisterEventHandler( "TargetWindow", WindowData.MobileName.Event, "TargetWindow.HandleUpdateNameEvent")
	WindowRegisterEventHandler( "TargetWindow", WindowData.ObjectInfo.Event, "TargetWindow.UpdateObjectInfo")
	WindowRegisterEventHandler( "TargetWindow", WindowData.HealthBarColor.Event, "TargetWindow.HandleTintHealthBarEvent")
	
	WindowRegisterCoreEventHandler("TargetWindow", "OnLButtonDblClk", "TargetWindow.OnItemDblClicked")
	WindowUtils.RestoreWindowPosition("TargetWindow")
end

function TargetWindow.Shutdown()
	TargetWindow.ClearPreviousTarget()
	UnregisterWindowData(WindowData.CurrentTarget.Type,0)
	WindowUtils.SaveWindowPosition("TargetWindow")
end

function TargetWindow.ClearPreviousTarget()
	if( TargetWindow.HasTarget == true ) then
			WindowSetShowing("TargetWindow",false)
			if(TargetWindow.TargetType == TargetWindow.MobileType) then
				UnregisterWindowData(WindowData.MobileName.Type,TargetWindow.TargetId)
				UnregisterWindowData(WindowData.MobileStatus.Type,TargetWindow.TargetId)
				UnregisterWindowData(WindowData.HealthBarColor.Type,TargetWindow.TargetId)
			elseif(TargetWindow.TargetType == TargetWindow.ObjectType or
			       TargetWindow.TargetType == TargetWindow.CorpseType) then
				UnregisterWindowData(WindowData.ObjectInfo.Type,TargetWindow.TargetId)				
			end
			LabelSetText("TargetWindowName", L"")
			StatusBarSetCurrentValue( "TargetWindowHealthBar", 0 )
			WindowSetShowing("TargetWindowPortrait", false)
			WindowSetShowing("TargetWindowDisabled", false)
			WindowSetShowing("TargetWindowObject", false)
			TargetWindow.TargetType = 0
	end
end	

function TargetWindow.UnregisterPreviousTargetData()
	--If previous target was a mobile unregister data with the previous target
	if( TargetWindow.HasTarget == true) then
		if(TargetWindow.TargetType == TargetWindow.MobileType) then
			UnregisterWindowData(WindowData.MobileName.Type,TargetWindow.TargetId)
			UnregisterWindowData(WindowData.MobileStatus.Type,TargetWindow.TargetId)	
			UnregisterWindowData(WindowData.HealthBarColor.Type,TargetWindow.TargetId)
		elseif(TargetWindow.TargetType == TargetWindow.ObjectType or
			   TargetWindow.TargetType == TargetWindow.CorpseType) then
			UnregisterWindowData(WindowData.ObjectInfo.Type,TargetWindow.TargetId)	
		end
	end
end

function TargetWindow.UpdateMobile(id)
	if( TargetWindow.HasTarget == false or
	(TargetWindow.HasTarget == true and id ~= TargetWindow.TargetId) ) then
		TargetWindow.UnregisterPreviousTargetData()
		
		--Update the local targetType as a mobile type
		TargetWindow.TargetType = TargetWindow.MobileType
		WindowSetShowing("TargetWindow",true)
		
		RegisterWindowData(WindowData.MobileName.Type, id)
		RegisterWindowData(WindowData.MobileStatus.Type,id)
		RegisterWindowData(WindowData.HealthBarColor.Type,id)
		TargetWindow.UpdateStatus(id)	
		TargetWindow.UpdateName(id)	
		TargetWindow.TargetId = id
		TargetWindow.TintHealthBar(id)
		
		if( WindowData.CurrentTarget.HasPaperdoll ) then
		
			local textureData = SystemData.PaperdollTexture[id]	
			if( textureData ~= nil) then
			
				local x, y, scale
				if textureData.IsLegacy == 1 then
					x, y = -88, 14
					scale = 0.8
				else
					x, y = -11, -191
					scale = 0.432
				end
				
				CircleImageSetTexture("TargetWindowPortrait", "paperdoll_texture"..id, x - textureData.xOffset, y - textureData.yOffset)
				CircleImageSetTextureScale("TargetWindowPortrait", scale)
			end			
		else
			CircleImageSetTextureScale("TargetWindowPortrait",0.843)
			CircleImageSetTexture("TargetWindowPortrait","target_portrait",32,32);
			UpdatePortrait("target_portrait",true,id);
		end
		
		--WindowSetShowing("TargetWindowHealthBarImage", true)
		WindowSetShowing("TargetWindowPortrait", true)
		WindowSetShowing("TargetWindowObject", false)
	end
end

function TargetWindow.UpdateObject(id)
  Debug.PrintToChat(L""..id)

	if( (TargetWindow.HasTarget == false) or
		(TargetWindow.HasTarget == true and id ~= TargetWindow.TargetId) ) then
		TargetWindow.UnregisterPreviousTargetData()
		
		--Update the local targetType to Object type
		TargetWindow.TargetType = TargetWindow.ObjectType
		WindowSetShowing("TargetWindow",true)
		TargetWindow.TargetId = id
		
		RegisterWindowData(WindowData.ObjectInfo.Type,id)
		
		StatusBarSetCurrentValue( "TargetWindowHealthBar", 0 )
		local itemData = WindowData.ObjectInfo[id]
		LabelSetText("TargetWindowName", itemData.name)
		
		NameColor.UpdateLabelNameColor("TargetWindowName", NameColor.Notoriety.NONE)

        EquipmentData.UpdateItemIcon("TargetWindowObject", itemData)

		--WindowSetShowing("TargetWindowHealthBarImage", false)
		WindowSetShowing("TargetWindowObject", true)
		WindowSetShowing("TargetWindowDisabled", false)
		UpdatePortrait("target_portrait",false,0);
		WindowSetShowing("TargetWindowPortrait", false)
	end
end

--Corpse will show the portrait of the mobile, but use the item properites for the name
function TargetWindow.UpdateCorpse(id)
	if( (TargetWindow.HasTarget == false) or
		(TargetWindow.HasTarget == true and id ~= TargetWindow.TargetId) ) then
		TargetWindow.UnregisterPreviousTargetData()
		WindowSetShowing("TargetWindowDisabled",false)
		
		--Update the local targetType to Object type
		TargetWindow.TargetType = TargetWindow.CorpseType
		WindowSetShowing("TargetWindow",true)
		TargetWindow.TargetId = id
		
		RegisterWindowData(WindowData.ObjectInfo.Type,id)
		local itemData = WindowData.ObjectInfo[id]
		
		StatusBarSetCurrentValue( "TargetWindowHealthBar", 0 )
		LabelSetText("TargetWindowName", itemData.name)
		
		NameColor.UpdateLabelNameColor("TargetWindowName", NameColor.Notoriety.NONE)
		
		CircleImageSetTextureScale("TargetWindowPortrait",0.843)
		CircleImageSetTexture("TargetWindowPortrait","target_portrait",32,32);		
		UpdatePortrait("target_portrait",true,id);
		--WindowSetShowing("TargetWindowHealthBarImage", false)
		WindowSetShowing("TargetWindowPortrait", true)
		WindowSetShowing("TargetWindowObject", false)
	end
end



function TargetWindow.UpdateTarget()
  if WindowData.CurrentTarget.TargetId ~= nil then
    TargetWindow.UpdateTargetById(WindowData.CurrentTarget.TargetId, WindowData.CurrentTarget.TargetType)
  end
end

function TargetWindow.UpdateTargetById(id, type)
    
	--Check to see if the target is a mobile or object first, if it is a mobile then show the portrait of the mobile
	--otherwise show the object texture
	if(type == TargetWindow.MobileType) then
		TargetWindow.UpdateMobile(id)
	else
		if(type == TargetWindow.ObjectType) then
			TargetWindow.UpdateObject(id)
		else
			if(type == TargetWindow.CorpseType) then
				TargetWindow.UpdateCorpse(id)
			else
				TargetWindow.ClearPreviousTarget()
			end
		end
	end 
	-- End of registering for the mobileType

	TargetWindow.HasTarget = WindowData.CurrentTarget.HasTarget	
end

function TargetWindow.MobileStatusUpdate()
    TargetWindow.UpdateStatus(WindowData.UpdateInstanceId)
end

function TargetWindow.UpdateStatus(targetId)	
	if( targetId == WindowData.CurrentTarget.TargetId ) then
		StatusBarSetCurrentValue( "TargetWindowHealthBar", WindowData.MobileStatus[WindowData.CurrentTarget.TargetId].CurrentHealth )	
		StatusBarSetMaximumValue( "TargetWindowHealthBar", WindowData.MobileStatus[WindowData.CurrentTarget.TargetId].MaxHealth )			
		if( WindowData.MobileStatus[WindowData.CurrentTarget.TargetId].IsDead ) then
		    WindowSetShowing("TargetWindowDisabled",true)
		else
            WindowSetShowing("TargetWindowDisabled",false)
		end
	end
end

function TargetWindow.HandleUpdateNameEvent()
    TargetWindow.UpdateName(WindowData.UpdateInstanceId)
end

function TargetWindow.UpdateName(targetId)	
	if( targetId == WindowData.CurrentTarget.TargetId ) then
		LabelSetText("TargetWindowName", WindowData.MobileName[WindowData.CurrentTarget.TargetId].MobName)
		
		NameColor.UpdateLabelNameColor("TargetWindowName", WindowData.MobileName[WindowData.CurrentTarget.TargetId].Notoriety+1)
	end
end

function TargetWindow.HandleTintHealthBarEvent()
    TargetWindow.TintHealthBar(WindowData.UpdateInstanceId)
end

function TargetWindow.TintHealthBar(mobileId)
	if( mobileId == WindowData.CurrentTarget.TargetId ) then
		local windowTintName = "TargetWindowHealthBar"
		--Colors the health bar to the correct color
		HealthBarColor.UpdateHealthBarColor(windowTintName, WindowData.HealthBarColor[mobileId].VisualStateId)
	end
end

function TargetWindow.UpdateObjectInfo()
	if( WindowData.UpdateInstanceId == WindowData.CurrentTarget.TargetId ) then
		local itemData = WindowData.ObjectInfo[WindowData.CurrentTarget.TargetId]
		LabelSetText("TargetWindowName", itemData.name)
	end	
end

--
-- Try using the current target as it was an item
--
function TargetWindow.OnItemDblClicked()
	UserActionUseItem(TargetWindow.TargetId, false)
end

--
-- Show the current target's context menu on right click 
--
function TargetWindow.OnRClick()
	RequestContextMenu(TargetWindow.TargetId)
end

--
-- Spawn mobile health bar if the protrait is right-clicked
--
function TargetWindow.OnPortraitRClick()
  MobileHealthBar.CreateHealthBar(WindowData.CurrentTarget.TargetId)
end

function TargetWindow.OnLClick()
	if( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM ) then
	    DragSlotDropObjectToObject(WindowData.CurrentTarget.TargetId)
	else
		--Let the targeting manager handle single left click on the target
		HandleSingleLeftClkTarget(WindowData.CurrentTarget.TargetId)
	end
end

function TargetWindow.OnMouseOver()
	local itemData =
	{
		windowName = "TargetWindow",
		itemId = WindowData.CurrentTarget.TargetId,
		itemType = WindowData.ItemProperties.TYPE_ITEM,
	}					
	ItemProperties.SetActiveItem(itemData)
end

function TargetWindow.OnMouseOverEnd()
	ItemProperties.ClearMouseOverItem()
end