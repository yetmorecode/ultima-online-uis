local this = {}

LeanCourseMapWindow = this

this.ZoomLevel = 1
this.ZoomStep = 0.4
this.ZoomMax = 20


function this.Hook()
	--this.OriginalInitialize = CourseMapWindow.Initialize
	--CourseMapWindow.Initialize = LeanCourseMapWindow.Initialize
end

function this.Unhook()

end



function this.Initialize()
	this.OriginalInitialize()
end

----

function this.Initialize()
    local mapId = SystemData.ActiveObject.Id
    local windowName = "CourseMapWindow"..mapId
    
    this.ZoomLevel = 1
    
    this.NumPointsCreated[mapId] = 0
    this.MapPoints[mapId] = {}
    
    Interface.DestroyWindowOnClose[windowName] = true
    
    WindowSetId(windowName,mapId)
    WindowRegisterEventHandler(windowName,SystemData.Events.COURSE_MAP_DATA_UPDATED,"CourseMapWindow.UpdatePoints")
    WindowRegisterEventHandler(windowName,SystemData.Events.COURSE_MAP_STATE_UPDATED,"CourseMapWindow.UpdateState")
    
    
    
    local width, height, textureWidth, textureHeight, textureScale = GetCourseMapWindowDimensions(mapId)
    WindowSetDimensions(windowName, width + this.X_PADDING, height + this.Y_PADDING)
    
    this.UpdateTexture()
    
    RegisterWindowData(WindowData.ItemProperties.Type, mapId)
    if WindowData.ItemProperties[mapId] and WindowData.ItemProperties[mapId].PropertiesTids then 
		  this.isTmap = this.TreasureMaps[WindowData.ItemProperties[mapId].PropertiesTids[1]]
		  this.Title = GetStringFromTid(WindowData.ItemProperties[mapId].PropertiesTids[1])
		  if this.isTmap then
		    this.MapLocation = GetStringFromTid(WindowData.ItemProperties[mapId].PropertiesTids[4])
		  else
		    this.MapLocation = L""
		  end
	  end
	  UnregisterWindowData(WindowData.ItemProperties.Type, mapId)
    
    local t = wstring.upper(wstring.sub(this.Title, 1, 1))..wstring.sub(this.Title, 2, -1)
    LabelSetText(windowName.."TitleLabel", t)
    
    local t = wstring.upper(wstring.sub(this.MapLocation, 1, 1))..wstring.sub(this.MapLocation, 2, -1)
    LabelSetText(windowName.."SubtitleLabel", t)
    
    local scale = WindowGetScale(windowName)
	  --WindowSetScale(windowName, scale * this.WINDOWSCALE)
end

function this.Shutdown()
    local mapId = WindowGetId(SystemData.ActiveWindow.name)
    ReleaseCourseMap(mapId)
    this.MapPoints[mapId] = nil
    this.NumPointsCreated[mapId] = nil
end

function this.MapOnMouseWheel(x, y, delta)
    local step = this.ZoomStep * this.ZoomLevel
    if step < this.ZoomStep then
      step = this.ZoomStep
    end
     
    this.ZoomLevel = this.ZoomLevel + delta * step 
    
    if this.ZoomLevel > this.ZoomMax then
      this.ZoomLevel = this.ZoomMax
    end
    
    if this.ZoomLevel < 0 then
      this.ZoomLevel = 0
    end
    
    
    this.UpdateTexture()
    this.UpdatePoints()
end

function this.UpdateTexture()
  local mapId = SystemData.ActiveObject.Id
  local windowName = "CourseMapWindow"..mapId
  local width, height, textureWidth, textureHeight, textureScale = GetCourseMapWindowDimensions(mapId)
  
  if width ~= nil and height ~= nil and textureScale ~= nil then
    WindowSetDimensions(windowName.."MaskTexture", width * (1 + this.ZoomLevel), height * (1 + this.ZoomLevel))
    DynamicImageSetTextureDimensions(windowName.."MaskTexture", textureWidth * (1 + this.ZoomLevel), textureHeight * (1 + this.ZoomLevel))
    DynamicImageSetTextureScale(windowName.."MaskTexture", textureScale * (1 + this.ZoomLevel))
    DynamicImageSetTexture(windowName.."MaskTexture", "CourseMap"..mapId, 0, 0)
    DynamicImageSetRotation(windowName.."MaskTexture", 45)
  end
end

function this.OnUpdate()
	if(this.DragMapPoint ~= "") then
		if(WindowGetMoving(this.DragMapPoint) == false) then
			local windowName = this.DragMapPoint
			local parentWindow = WindowGetParent(windowName)
			local mapId = WindowGetId(parentWindow)
			local mapPointId = WindowGetId(this.DragMapPoint)
			
			local textureWidth, textureHeight = WindowGetDimensions(parentWindow.."MaskTexture")
			local point, relativePoint, relativeTo, xOffset, yOffset = WindowGetAnchor(this.DragMapPoint, 1)
			xOffset = xOffset + this.X_MAPPOINT_PADDING
			yOffset = yOffset + this.Y_MAPPOINT_PADDING
			
			if(xOffset >= 0 and xOffset <= textureWidth and yOffset >= 0 and yOffset <= textureHeight) then
				CourseMapMovePoint(mapId, mapPointId, xOffset, yOffset)
				Debug.PrintToChat(L"move")
			else
				CourseMapDeletePoint(mapId, mapPointId)
			end
			
			this.DragMapPoint = ""
		end
	end
end

function this.UpdatePoints()
    local mapId = SystemData.ActiveObject.Id
    local windowName = "CourseMapWindow"..mapId
    
    for i=1, this.NumPointsCreated[mapId] do
        local mapPointName = windowName..mapId.."Point"..i
        WindowSetShowing(mapPointName,false)
    end

    local scale = WindowGetScale(windowName)
    this.MapPoints[mapId] = {}
    local xPosVec, yPosVec = GetCourseMapData(mapId)
    if( xPosVec ~= nil and yPosVec ~= nil ) then
        for i=1, table.getn(xPosVec) do
            local mapPointName = windowName..mapId.."Point"..i

            this.MapPoints[mapId][i] = {}
            this.MapPoints[mapId][i].x = xPosVec[i] * (1 + this.ZoomLevel)
            this.MapPoints[mapId][i].y = yPosVec[i] * (1 + this.ZoomLevel)
            
            if( i > this.NumPointsCreated[mapId] ) then
                CreateWindowFromTemplate(mapPointName,"MapPoint",windowName)
                this.NumPointsCreated[mapId] = this.NumPointsCreated[mapId] + 1
            end
            
            WindowSetId(mapPointName, i)
            LabelSetText(mapPointName.."Name", L""..i)
            
      			if ( this.isTmap) then
      				WindowSetShowing(mapPointName.."Name", false)
      			end
            
            
            
            if this.isTmap then
              WindowClearAnchors(mapPointName)
              WindowAddAnchor(
                mapPointName, "center", 
                windowName.."Mask", "center",
                0,
                0
              )
              
              local textureWidth, textureHeight = WindowGetDimensions(windowName.."MaskTexture")
              local dx = textureWidth / 2 - this.MapPoints[mapId][i].x
              local dy = textureHeight / 2 - this.MapPoints[mapId][i].y
              
              -- rotate 45°
              local sin = 0.70710678118
              local cos = 0.70710678118
              local rdx = dx * cos - dy * sin
              local rdy = dx * sin + dy * cos 
              
              WindowClearAnchors(windowName.."MaskTexture")
              WindowAddAnchor(
                windowName.."MaskTexture", "center", 
                windowName.."Mask", "center",
                rdx, rdy
              )
            else
              WindowClearAnchors(mapPointName)
              WindowAddAnchor(
                mapPointName, "center", 
                windowName.."MaskTexture", "center",
                this.MapPoints[mapId][i].x,
                this.MapPoints[mapId][i].y
              )
            end
            
            WindowSetShowing(mapPointName,true)
        end
    end
end

function this.UpdateState()
	
end

function this.Map_OnLButtonDown()
	local windowName = SystemData.ActiveWindow.name
	local parentWindow = WindowGetParent(windowName)
	local mapId = WindowGetId(parentWindow)
	
	if(CourseMapIsPlotting(mapId) == false) then
		WindowSetMoving(parentWindow, true)
	end
end

function this.Map_OnLButtonUp(flags,x,y)
	local windowName = SystemData.ActiveWindow.name
	local parentWindow = WindowGetParent(windowName)
	local mapId = WindowGetId(parentWindow)
	local scale = WindowGetScale( parentWindow )
	
	if(CourseMapIsPlotting(mapId) == true) then
		CourseMapAddPoint(mapId, x/scale, y/scale)
	else
		WindowSetMoving(parentWindow, false)
	end
end


function this.MapPoint_OnLButtonDown()
	local windowName = SystemData.ActiveWindow.name
	local parentWindow = WindowGetParent(windowName)
	local mapWindow = WindowGetParent(parentWindow)
	local mapId = WindowGetId(mapWindow)

	if(CourseMapIsPlotting(mapId) == true) then
		this.DragMapPoint = parentWindow
		WindowSetMoving(parentWindow, true)
	end
end