----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

ObjectHandleWindow = {}
ObjectHandle = {}

IgnoreHandle = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

--If the health bar for it is already open
ObjectHandleWindow.hasWindow = {}
ObjectHandleWindow.ObjectsData ={}
ObjectHandleWindow.ReverseObjectLookUp ={} 

--Default gray color of objects for their object handles
ObjectHandleWindow.grayColor = { r=172, g=172, b=172 }
ObjectHandleWindow.whiteColor = { r= 255, g=255, b= 255 }

ObjectHandleWindow.WindowShiftOffset = 15

ObjectHandleWindow.mouseOverId = 0

--Theses are used for mobiles only for setting the tint color of the object handle window
ObjectHandleWindow.Notoriety = {NONE = 1, INNOCENT = 2, FRIEND = 3, CANATTACK =4, CRIMINAL=5, ENEMY=6, MURDERER=7, INVULNERABLE=8 }
ObjectHandleWindow.TextColors = {}
ObjectHandleWindow.TextColors[ObjectHandleWindow.Notoriety.NONE]    =  { r=64,   g=64,   b=255 } --- BLUE
ObjectHandleWindow.TextColors[ObjectHandleWindow.Notoriety.INNOCENT]   = { r=128,   g=128,   b=255 } --- BLUE
ObjectHandleWindow.TextColors[ObjectHandleWindow.Notoriety.FRIEND]   = { r=0,   g=159,   b=0 } --- GREEN 
ObjectHandleWindow.TextColors[ObjectHandleWindow.Notoriety.CANATTACK]   = { r=64, g=64, b=64 } --- GREY/SYS
ObjectHandleWindow.TextColors[ObjectHandleWindow.Notoriety.CRIMINAL]   = { r=64, g=64, b=64 } --- GREY/SYS
ObjectHandleWindow.TextColors[ObjectHandleWindow.Notoriety.ENEMY]  = { r=255, g=128, b=0   } --- ORANGE
ObjectHandleWindow.TextColors[ObjectHandleWindow.Notoriety.MURDERER]  =  { r=255, g=0  , b=0  } --- RED  
ObjectHandleWindow.TextColors[ObjectHandleWindow.Notoriety.INVULNERABLE]  = { r=251, g=194, b=2   } --- YELLOW 

ObjectHandleWindow.SuppressWindows =  false

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function ObjectHandleWindow.Initialize()
	WindowRegisterEventHandler( "Root", SystemData.Events.CREATE_OBJECT_HANDLES, "ObjectHandleWindow.CreateObjectHandles")
	WindowRegisterEventHandler( "Root", SystemData.Events.DESTROY_OBJECT_HANDLES, "ObjectHandleWindow.DestroyObjectHandles")
end

function ObjectHandleWindow.retrieveObjectsData( objectsData )
	if not objectsData then
		--Debug.PrintToDebugConsole( L"ERROR: objectsData does not exist." )
		return false
	end      
				
	objectsData.Names = WindowData.ObjectHandle.Names
	objectsData.ObjectId = WindowData.ObjectHandle.ObjectId
	objectsData.XPos = WindowData.ObjectHandle.XPos
	objectsData.YPos = WindowData.ObjectHandle.YPos
	objectsData.IsMobile = WindowData.ObjectHandle.IsMobile
	objectsData.Notoriety = WindowData.ObjectHandle.Notoriety
	
	return true
end



function getItemName(item)
	if wstring.len(item.name) > 0 then
		return item.name
	end
	
	if item.objectType == 3821 then
		return L"gold"
	end
end

--Creates all the object handles for all the objects that are on screen
function ObjectHandleWindow.CreateObjectHandles()
	local objectsData = {}
	local didLoot = false
	
	
	
	if( ObjectHandleWindow.retrieveObjectsData(objectsData) ) then
		ObjectHandleWindow.ObjectsData = objectsData
		--Inspection.dumpToChat("foo", objectsData)
		local numberObjects = table.getn(ObjectHandleWindow.ObjectsData.ObjectId)
		
		--Debug.PrintToChat(L""..numberObjects..L" items on screen")
		
		-- foreach object on screen
		for i=1, numberObjects do	
			local objectId = ObjectHandleWindow.ObjectsData.ObjectId[i]
			local windowName = "ObjectHandleWindow"..objectId
			local windowTintName = windowName.."Tint"
			local labelName = windowName.."TintName"
			local labelContent = ObjectHandleWindow.ObjectsData.Names[i]

      local artwork = false
      for k,v in pairs(ItemProperties.GetObjectProperties(objectId)) do
        if wstring.find(v, L"rtwork") then
          artwork = true
        end
      end
        
      if artwork then
        local Timestamp, YYYY, MM, DD, h, m, s  = GetCurrentDateTime()
        
        
        Debug.PrintToChat("Artwork spawned!! " .. h .. ":" .. m .. ":" .. s)
      end

      if wstring.find(labelContent, L"House Sign") then
        local decay = false
        
        Debug.PrintToChat(L"house.."..objectId)
        for k,v in pairs(ItemProperties.GetObjectProperties(objectId)) do
          if wstring.find(v, L"Condition") or wstring.find(v, L"OSI") then
            decay = true
          end
          
          if wstring.find(v, L"ilk") then
            artwork = true
          end
        end
        
        if artwork then
          local Timestamp, YYYY, MM, DD, h, m, s  = GetCurrentDateTime()
          
          
          Debug.PrintToChat("Artwork spawned!! " .. h .. ":" .. m .. ":" .. s)
        end
        
        if decay then
          Debug.PrintToChat("[IDOC found] Decaying house:")
          local sign = L""
          for k,v in pairs(ItemProperties.GetObjectProperties(objectId)) do
            sign = sign .. L" / " .. v
          end
          
          Debug.PrintToChat(sign)
        end
      end
			
			--Debug.PrintToChat(string.format("%d / %x - %s", objectId, objectId, WStringToString(labelContent)))
			
			if GetDistanceFromPlayer(objectId) < 3 then
				--UserActionUseItem(objectId, false)
			end
			
			if wstring.find(labelContent, L"Tangle") or
				wstring.find(labelContent, L"Chaga Mushroom")
			then
			 Debug.PrintToChat("tanlgE");
			else
        
      end
			--Debug.PrintToChat(L""..objectId..L": "..labelContent)
				
			if not ObjectHandleWindow.SuppressWindows and IgnoreHandle[objectId] == nil then
				CreateWindowFromTemplate(windowName, "ObjectHandleWindow", "Root")
			
				WindowSetOffsetFromParent(windowName, 100, i*55)
				AttachWindowToWorldObject(objectId, windowName)
				
				if ObjectHandleWindow.ObjectsData.IsMobile[i] == false and ObjectHandleWindow.ObjectsData.Notoriety[i] == -1 then
					RegisterWindowData(WindowData.ContainerWindow.Type, objectId)
					if WindowData.ContainerWindow[objectId] ~= nil then
						if WindowData.ContainerWindow[objectId].isCorpse then
							numItems = WindowData.ContainerWindow[objectId].numItems
							
							if numItems > 0 then
								Debug.PrintToChat(L""..objectId..L": "..ObjectHandleWindow.ObjectsData.Names[i]..L" public")
								LootManager.AddContainer(objectId)
							else
								Debug.PrintToChat(L""..objectId..L": "..ObjectHandleWindow.ObjectsData.Names[i]..L" private or empty")
							end
							
						end
					end
					UnregisterWindowData(WindowData.ContainerWindow.Type, objectId)
				end 
				
				
				WindowSetId(windowName, objectId)
				ObjectHandleWindow.hasWindow[objectId] = true
				ObjectHandleWindow.ReverseObjectLookUp[objectId] = i
				LabelSetText(labelName, ObjectHandleWindow.ObjectsData.Names[i])
				
				--Set the color of the window based off of the notoriety
				if(ObjectHandleWindow.ObjectsData.IsMobile[i]) then
					local hue = ObjectHandleWindow.TextColors[ObjectHandleWindow.ObjectsData.Notoriety[i]+1]
					--Debug.Print("Seting tint color mobile r ="..hue.r.."g = "..hue.g.."b = "..hue.b)
					WindowSetTintColor(windowTintName, hue.r, hue.g, hue.b)
				else
					--Debug.Print("Seting tint color object r ="..ObjectHandleWindow.grayColor.r.."g = "..ObjectHandleWindow.grayColor.g.."b = "..ObjectHandleWindow.grayColor.b)
					WindowSetTintColor(windowTintName, ObjectHandleWindow.grayColor.r, ObjectHandleWindow.grayColor.g,ObjectHandleWindow.grayColor.b)
					
				end
				
				--HandleSingleLeftClkTarget(objectId)
				--UserActionUseItem(objectId,true)
				--DragSlotAutoPickupObject(objectId)
			else
			
			end
		end
	end 
end

--Destroys all the object handles on the screen when the user lets go of ctrl+shift
function ObjectHandleWindow.DestroyObjectHandles()
	for key, value in pairs(ObjectHandleWindow.hasWindow) do
		ObjectHandle.DestroyObjectWindow(key) 
	end
end

--Destroy object handle when player right clicks the window
function ObjectHandleWindow.OnClickClose()
	local objectId = WindowGetId(WindowUtils.GetActiveDialog())
	
	DragSlotAutoPickupObject(objectId)
	--ObjectHandle.DestroyObjectWindow(objectId) 
end

--Used on mobiles, if they have a context menu and they single click the context menu will come up
function ObjectHandleWindow.OnRClick()
	local objectId = WindowGetId(WindowUtils.GetActiveDialog())
	local tableLoc = ObjectHandleWindow.ReverseObjectLookUp[objectId]
	--Request context menu if the object halde they left click is an object
	if( (SystemData.DragItem.DragType == SystemData.DragItem.TYPE_NONE) and ObjectHandleWindow.ObjectsData.IsMobile[tableLoc]) then
		RequestContextMenu(objectId)
	end
end

--When player double clicks the object handle window it acts as if they double-clicked the object itself
function ObjectHandleWindow.OnDblClick()
	local objectId = WindowGetId(WindowUtils.GetActiveDialog())
	
	Debug.PrintToChat(L"Ignoring Handle = "..objectId)
	IgnoreHandle[objectId] = true
	
	UserActionUseItem(objectId,false)
end

function ObjectHandleWindow.OnItemClicked()
	local objectId = WindowGetId(WindowUtils.GetActiveDialog())
	if(objectId ~= nil)then
		--If player has a targeting cursor up and they target a object handle window
		--send a event telling the client they selected a target
		if( WindowData.Cursor ~= nil and WindowData.Cursor.target == true ) then
			--Let player select there window as there target
			HandleSingleLeftClkTarget(objectId)
			return
		end
		
		local tableLoc = ObjectHandleWindow.ReverseObjectLookUp[objectId]
		--If player is trying to drag the object handle window, have it act as if they are trying to pickup the object
		if( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_NONE) then
			local cursorData
			
			if( (ObjectHandleWindow.ObjectsData.IsMobile[tableLoc] == false ) ) then
				RegisterWindowData(WindowData.ObjectInfo.Type, objectId)
				selectedNum = WindowData.ObjectInfo[objectId]
				local quantity = selectedNum.quantity
				local objectType = selectedNum.objectType
				UnregisterWindowData(WindowData.ObjectInfo.Type, objectId)

				DragSlotSetObjectMouseClickData(objectId, SystemData.DragSource.SOURCETYPE_OBJECT)
			else				
				HealthBarManager.OnBeginDragHealthBar(objectId)
			end
		end
	end
end

function ObjectHandleWindow.OnLButtonUp()
	if( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM ) then
		local mobileId = WindowGetId(WindowUtils.GetActiveDialog())
	    DragSlotDropObjectToObject(mobileId)
	end
end

--Destroy object handle window and reset the data to nil
function ObjectHandle.DestroyObjectWindow(objectId) 
	local windowName = "ObjectHandleWindow"..objectId
	if( ObjectHandleWindow.hasWindow[objectId] == true) then
		--DetachWindowFromWorldObject(objectId, windowName)
		DestroyWindow(windowName)
		ObjectHandleWindow.hasWindow[objectId] = nil
		ObjectHandleWindow.ReverseObjectLookUp[objectId] = nil
	end
	
	if (ObjectHandleWindow.mouseOverId == objectId) then
		ObjectHandleWindow.OnMouseOverEnd()
	end
end

function ObjectHandleWindow.OnMouseOver()
	local objectId = WindowGetId(WindowUtils.GetActiveDialog())
	local itemData =
	{
		windowName = "ObjectHandleWindow",
		itemId = objectId,
		itemType = WindowData.ItemProperties.TYPE_ITEM,
	}					
	ItemProperties.SetActiveItem(itemData)
	ObjectHandleWindow.mouseOverId = objectId
end

function ObjectHandleWindow.OnMouseOverEnd()
	ItemProperties.ClearMouseOverItem()
	ObjectHandleWindow.mouseOverId = 0
end