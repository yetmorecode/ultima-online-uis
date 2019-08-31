----------------------------------------------------------------
-- WindowUtil Global Variables
----------------------------------------------------------------
WindowUtils = {}

WindowUtils.resizing = false
WindowUtils.resizeWindow = nil
WindowUtils.resizeAnchor = ""
WindowUtils.resizeEndCallback = nil
WindowUtils.resizeMin = { x=0, y=0 }

WindowUtils.DRAG_PICKUP_TIME = 3 -- 3 Seconds
WindowUtils.DRAG_DISTANCE = 5 -- 5 Pixels
WindowUtils.dragging = false
WindowUtils.dragCallback = nil
WindowUtils.dragData = nil
WindowUtils.dragTime = 0
WindowUtils.dragX = nil
WindowUtils.dragY = nil

WindowUtils.openWindows = {}
WindowUtils.trackSize = {}

WindowUtils.FONT_DEFAULT_TEXT_LINESPACING = 20
WindowUtils.FONT_DEFAULT_SUB_HEADING_LINESPACING = 22

-- all the possible flags combo
WindowUtils.ButtonFlags = {}
WindowUtils.ButtonFlags.NONE = 0

WindowUtils.ButtonFlags.ALT = 32
WindowUtils.ButtonFlags.CONTROL = 8
WindowUtils.ButtonFlags.SHIFT = 4 

WindowUtils.ButtonFlags.CONTROL_ALT = 40
WindowUtils.ButtonFlags.CONTROL_SHIFT = 12
WindowUtils.ButtonFlags.ALT_SHIFT = 36

WindowUtils.ButtonFlags.CONTROL_ALT_SHIFT = 44

----------------------------------------------------------------
-- WindowUtil Functions
----------------------------------------------------------------


function WindowUtils.Initialize()

	-- Create the Util Windows
	
	CreateWindow( "ResizingWindowFrame", false )
	
	WindowRegisterEventHandler( "ResizingWindowFrame", SystemData.Events.L_BUTTON_UP_PROCESSED, "WindowUtils.OnLButtonUp")	
end


function WindowUtils.Update( timePassed )

	-- Update the resize frame
	if (WindowUtils.resizing) then
		local x, y = WindowGetDimensions( "ResizingWindowFrame" )
		local resize = false;
		
		if (x < WindowUtils.resizeMin.x) then
			x = WindowUtils.resizeMin.x
			resize = true
		end
		if (y < WindowUtils.resizeMin.y) then
			y = WindowUtils.resizeMin.y
			resize = true
		end
		
		if (resize) then
			--Debug.PrintToDebugConsole(L"Resizing: "..x..L", "..y )
			WindowSetDimensions( "ResizingWindowFrame", x, y )
		end
    elseif (WindowUtils.dragging) then
        WindowUtils.dragTime = WindowUtils.dragTime - timePassed
			
		local mouseDistanceX = math.abs(WindowUtils.dragX - SystemData.MousePosition.x)
		local mouseDistanceY = math.abs(WindowUtils.dragY - SystemData.MousePosition.y)
		if (WindowUtils.dragTime <= 0 or mouseDistanceX > WindowUtils.DRAG_DISTANCE or mouseDistanceY > WindowUtils.DRAG_DISTANCE) then        
            WindowUtils.dragCallback(WindowUtils.dragData)
            WindowUtils.dragging = false
        end
	end
	
	SnapUtils.SnapUpdate(timePassed)
end

function WindowUtils.BeginResize( windowName, anchorCorner, minX, minY, lockRatio, endCallback )
    --Debug.Print("WindowUtils.BeginResize: "..tostring(windowName)..", "..tostring(anchorCorner)..", "..tostring(minX)..", "..tostring(minY)..", "..tostring(lockRatio)..", "..tostring(endCallback) )
    if (WindowUtils.resizing) then
        return
    end

    -- Anchor the resizing frame to the window
    local scale = WindowGetScale(windowName)
    local width, height = WindowGetDimensions( windowName )
    
    WindowSetDimensions( "ResizingWindowFrame", width, height )
    WindowSetScale("ResizingWindowFrame", scale)
    
    WindowAddAnchor( "ResizingWindowFrame", anchorCorner, windowName, anchorCorner, 0, 0 )

    WindowSetResizing( "ResizingWindowFrame", true, anchorCorner, lockRatio );
    WindowSetShowing( "ResizingWindowFrame", true )
    
    WindowUtils.resizing = true
    WindowUtils.resizeWindow = windowName
    WindowUtils.resizeAnchor = anchorCorner
    WindowUtils.resizeMin.x = minX
    WindowUtils.resizeMin.y = minY
    WindowUtils.resizeEndCallback = endCallback
	--Debug.PrintToDebugConsole(L"BeginResize: "..minX..L", "..minY )
end 

function WindowUtils.BeginDrag( callback, data )
    WindowUtils.dragging = true
    WindowUtils.dragCallback = callback
    WindowUtils.dragData = data
    WindowUtils.dragTime = WindowUtils.DRAG_PICKUP_TIME
    WindowUtils.dragX = SystemData.MousePosition.x
    WindowUtils.dragY = SystemData.MousePosition.y
end

function WindowUtils.EndDrag( )
	WindowUtils.dragging = false
end

function WindowUtils.OnLButtonUp( flags, x, y )

	-- End the resize
	if (WindowUtils.resizing) then
        if (not WindowUtils.resizing) then
            return
        end

        local width, height = WindowGetDimensions( "ResizingWindowFrame" )
        local posX, posY = WindowGetScreenPosition( "ResizingWindowFrame"  )
        local scale      = WindowGetScale( WindowUtils.resizeWindow )
          
        -- Detatch and Hide the Resizing Frame  
        WindowSetResizing( "ResizingWindowFrame", false, "", false );
        WindowClearAnchors( "ResizingWindowFrame" )
        WindowSetShowing( "ResizingWindowFrame", false )    
         
        -- Assign the settings to the new window
        WindowSetDimensions( WindowUtils.resizeWindow, width, height )      
        
        --WindowClearAnchors( WindowUtils.resizeWindow )
        --WindowAddAnchor( WindowUtils.resizeWindow, "topleft", "Root", "topleft", posX/scale, posY/scale )            
        
        if (WindowUtils.resizeEndCallback ~= nil) then
            WindowUtils.resizeEndCallback(WindowUtils.resizeWindow)
            WindowUtils.resizeEndCallback = nil
        end
        
        -- Clear the Resizing Data
        WindowUtils.resizing = false
        WindowUtils.resizeWindow = nil
        WindowUtils.resizeAnchor = nil        
    elseif (WindowUtils.dragging) then
        WindowUtils.dragging = false
	end
end

function WindowUtils.GetTopmostDialog(wndName)
	if (wndName == nil ) or (wndName == "") or not DoesWindowExist(wndName) then 
		--Debug.Print("WindowUtils.GetTopmostDialog: Active dialog is nil or empty!") 
        return 
    end
	parent = wndName
	repeat
		wnd = parent
		if not DoesWindowExist(wnd) then
			return
		end
		parent = WindowGetParent(wnd)
		if parent == nil or not DoesWindowExist(parent) then
		    --Debug.Print("WindowUtils.GetTopmostDialog: someone's parent is nil or empty!") 
		    return wnd
		end
	until (parent == "Root") 
	
    return wnd
end

function WindowUtils.GetActiveDialog()
	return WindowUtils.GetTopmostDialog(SystemData.ActiveWindow.name)
end

function WindowUtils.SetActiveDialogTitle(title)
	if (WindowUtils.GetActiveDialog() == nil) then
		--Debug.Print("WindowUtils.SetActiveDialogTitle: Active dialog is nil!")
		return
	end

	WindowUtils.SetWindowTitle(WindowUtils.GetActiveDialog(),title)
end

function WindowUtils.SetWindowTitle(window,title)
    --Debug.Print("WindowUtils.SetWindowTitle: "..tostring(window).." title: "..tostring(title))
    
	if not title or not window  or title == "" then
		return
	end

	title = wstring.upper(title)
	

	-- *** TESTING
	if type(title) ~= "wstring" then
		--Debug.Print("*** ERROR: window title is of type " .. type(title))
	end
	-- *** END TESTING
	
	if type(title) == "string" then
	    title = towstring(title)	
	end	
	
	
	--local label = window.."Chrome_UO_TitleBar_WindowTitle"
	--LabelSetText(label, title)
	WindowUtils.FitTextToLabel(window, title, true)
end

function WindowUtils.RetrieveWindowSettings()
	-- update the positions for any window thats currently open
	for window, type in pairs(WindowUtils.openWindows) do
		WindowUtils.RestoreWindowPosition(window, false)
	end
end

function WindowUtils.ForceResetWindowPositions()
	-- update the positions for any window thats currently open
	for window, type in pairs(WindowUtils.openWindows) do		
		WindowUtils.ForceResetWindowPosition(window)		
	end
end

function WindowUtils.SendWindowSettings()
	-- save the positions for any window thats currently open
	for window, type in pairs(WindowUtils.openWindows) do
		WindowUtils.SaveWindowPosition(window, false)
	end
end

function WindowUtils.CanRestorePosition(window)
	local result = false
	
	for i, windowName in pairs(SystemData.Settings.Interface.WindowPositions.Names) do
		if (window == windowName) then
			result = true
			break
		end
	end
	
	return result
end

function WindowUtils.RestoreWindowPosition(window, trackSize, alias, keepInbouds)	
	if not DoesWindowExist(window) then
		return
	end
	if not keepInbouds then
		keepInbouds = true
	end
	local windowPositions = SystemData.Settings.Interface.WindowPositions
	local index = nil

	--if no explicit alias, then use actual window name:
	if not alias then
		alias = window
	end
	
	for i, windowName in pairs(SystemData.Settings.Interface.WindowPositions.Names) do
		if (alias == windowName) then
			index = i
			break
		end
	end

	if (index ~= nil) then		
		local x = SystemData.Settings.Interface.WindowPositions.WindowPosX[index]
		local y = SystemData.Settings.Interface.WindowPositions.WindowPosY[index]
		
	    local winWidth, winHeight
		
		if (trackSize == true) then
			local width = SystemData.Settings.Interface.WindowPositions.WindowWidth[index]
			local height = SystemData.Settings.Interface.WindowPositions.WindowHeight[index]
			winWidth = width
			winHeight = height
			
			if (width ~= nil and height ~= nil and width ~= 0 and height ~= 0) then
				WindowSetDimensions(window,width,height)
			end
		else
			local scale = WindowGetScale(window)
			
			winWidth, winHeight = WindowGetDimensions(window)
			winWidth = winWidth * scale
			winHeight = winHeight * scale
		end
		
		if not winWidth then
			winWidth, winHeight = WindowGetDimensions(window)
		end
		
		-- make sure this window is on screen!
	    
	    -- count only if the window is more than half outside the area
	    winWidth = winWidth / 2
	    winHeight = winHeight / 2
	    
	    local resy = SystemData.screenResolution.y / InterfaceCore.scale
	    local resx = SystemData.screenResolution.x / InterfaceCore.scale
		
		if keepInbouds then
			if (x < 0) then
			   x = 0
			elseif (x + winWidth > resx) then
				x = resx - winWidth
			end
			
			if (y < 0) then
				y = 0
			elseif (y + winHeight > resy) then
				y = resy - winHeight
			end
		end
		if (x ~= nil and y ~= nil) then			
			WindowClearAnchors(window)
			WindowAddAnchor(window, "topleft","Root" , "topleft", x, y)	
		end
	else
		WindowClearAnchors(window)
		WindowAddAnchor(window, "center", "ResizeWindow", "center", 0,0)
		local x, y= WindowGetOffsetFromParent(window)
		WindowClearAnchors(window)
		WindowSetOffsetFromParent(window, x,y)
		
	end
		
	WindowUtils.openWindows[alias] = true
	WindowUtils.trackSize[alias] = trackSize
end

function WindowUtils.ForceResetWindowPosition(window)
	local index = nil		
	for i, windowName in pairs(SystemData.Settings.Interface.WindowPositions.Names) do		
		if (window == windowName) then			
			index = i
			break
		end
	end
	
	if (index ~= nil) then		
		local x = 10
		local y = 10
		if (x ~= nil and y ~= nil) then			
			WindowClearAnchors(window)
			WindowAddAnchor(window, "topleft","Root" , "topleft", x, y)				
		end
	end
end

function WindowUtils.SaveWindowPosition(window, trackSize, alias)	
	if not DoesWindowExist(window) then
		return
	end

	-- prevent the UI from saving data if the interface has failed to start
	if not Interface.started then
		return
	end

	--if no explicit alias, then use actual window name:
	if not alias then
		alias = window
	end
	
	WindowUtils.openWindows[alias] = true

	--Debug.Print("saving " .. alias)
	local x, y = WindowUtils.GetScaledScreenPosition(window)
    
	local width, height = WindowGetDimensions(window)
	local windowPositions = SystemData.Settings.Interface.WindowPositions
	
	local index = nil
	for i, windowName in pairs(windowPositions.Names) do
		if (alias == windowName) then
			index = i
			break
		end
	end
	
	-- if it doesnt exist yet then add it
	if (index == nil) then
		for i = 1, #windowPositions.Names do
			if windowPositions.Names[i] == nil then
				index = i
				break
			end
		end
		if not index then
			index = #windowPositions.Names + 1
		end
		windowPositions.Names[index] = alias
	end	
	
	windowPositions.WindowPosX[index] = x
	windowPositions.WindowPosY[index] = y
	
	if (string.find(window, "Hotbar", 1, true)) then
		width = Interface.LoadSetting( window .. "SizeW", width )
		height = Interface.LoadSetting( window .. "SizeH", height )
	end
	
	if (trackSize) then
		windowPositions.WindowWidth[index] = width
		windowPositions.WindowHeight[index] = height
	else
		windowPositions.WindowWidth[index] = 0
		windowPositions.WindowHeight[index] = 0
	end
	

	WindowUtils.openWindows[alias] = nil
	WindowUtils.trackSize[alias] = nil

	-- update user profile
	UserSettingsChanged()
end

function WindowUtils.ClearWindowPosition(window)
	local windowPositions = SystemData.Settings.Interface.WindowPositions
	
	local index = nil
	for i, windowName in pairs(windowPositions.Names) do
		if (window == windowName) then
			index = i
			break
		end
	end	

	if (index ~= nil) then
		-- shift all the elements up
		local lastElement = #windowPositions.Names
		if (index ~= lastElement) then
			for index2 = index + 1, lastElement do
				local previous = index2 - 1
				windowPositions.Names[previous] = windowPositions.Names[index2]
				windowPositions.WindowWidth[previous] = windowPositions.WindowWidth[index2]
				windowPositions.WindowHeight[previous] = windowPositions.WindowHeight[index2]
				windowPositions.WindowPosX[previous] = windowPositions.WindowPosX[index2]
				windowPositions.WindowPosY[previous] = windowPositions.WindowPosY[index2]
			end
		end
		windowPositions.Names[lastElement] = nil
		windowPositions.WindowWidth[lastElement] = nil
		windowPositions.WindowHeight[lastElement] = nil
		windowPositions.WindowPosX[lastElement] = nil
		windowPositions.WindowPosY[lastElement] = nil		
	end
	
	WindowUtils.openWindows[window] = nil
	WindowUtils.trackSize[window] = nil
end

-- replaces HTML markup tags where possible
--   and strips out all others
-- 
-- str is  of type wstring
--
-- Current substitutions are:
--   <BR>  -->  single carriage return
--   <P>  -->  double carriage return
--   <center>-----</center>  -->  deleted 
--   anything else between < >  -->  deleted 
--
-- NOTE: LuaPlus has some bugginess with wstring routines, e.g. gsub returning
--    the string as ASCII instead of unicode, particularly if the return string is empty
--
function WindowUtils.translateMarkup(str)

	--gsub function doesn't work on empty source strings.
	if (not str or str == L"" or str == "") then 
		return L""
	end	
	str = wstring.gsub(str, L"<[Bb][Rr]>", L"\n")
	if str == L"" or str == "" then 
		return L""
	end	
	str = wstring.gsub(str, L"<[Pp]>", L"\n\n")
	if str == L"" or str == "" then 
		return L""
	end	
	str = wstring.gsub(str, L"<center>-----</center>", L"\n\n")
--	str = wstring.gsub(str, L"<center>-----</center>", L"\n     ___________________\n")
	if str == L"" or str == "" then 
		return L""
	end	
	
	str = WindowUtils.translateLinkTag(str)
	
	str = wstring.gsub(str, L"<.->", L"")

	if str == L"" or str == "" then 
		return L""
	end	

	-- *** NOTE: this is the correct replaced of the above line once wstring.gsub works with captures. 
	--   For now we use KLUDGE2a and KLUDGE2b
	--[[
	str = wstring.gsub(str, L"<(.-)>", function(tag) 
											if wstring.sub(tag,1,4) == L"LINK" then 
												return  L"<"..tag..L">"
											else
												return  L""
											end
										end
						)
	--]]
	
	-- *** KLUDGE2b - because the above gsub isn't properly returning any value other than ""
	-- we used KLUDGE2a in translateLinkTag to surrounded the LINK tag with {}.  So here we change it back
	--
	local KLUDGED_LINK_TAG = L"{LINK(.-)}"
	
	local linkBody = wstring.match(str, KLUDGED_LINK_TAG)
	if type(linkBody) == "wstring" then
		str = wstring.gsub(str, KLUDGED_LINK_TAG, L"<LINK"..linkBody..L">" )
		--Debug.Print(str)
	end
	-- END KLUDGE2b
	
	if str == "" then 
		return L""
	end	
	
	return str 
end


-- WindowUtils.translateLinkTag
--   Translates our legacy code link tag to the KR link tag
--
-- the legacy client uses something like <A HREF="some url">text</A> for it's link tag 
--
-- our new style of link tags is currently NEW_LINK_TAG = L"<LINK=%1,%2>", but
-- in the future it may change to L"<LINK data=\"%1\" text=\"%2\" />"
--
function WindowUtils.translateLinkTag(str)

	local LEGACY_LINK_TAG = L"<[Aa]%s+[Hh][Rr][Ee][Ff]%s*=%s*\"(.-)\">(.-)</[Aa]>"
	
	-- *** KLUDGE - wstring.gsub is not setting the captures corrrectly, so I'm extracting the captures
	--  with  wstring.match and manually inserting them into NEW_LINK_TAG
	--
	local dataCapture, textCapture = wstring.match(str, LEGACY_LINK_TAG)
	if type(dataCapture) ~= "wstring" or type(textCapture) ~= "wstring" then
		return str
	end

	-- *** KLUDGE2a - because we do a final wstring.gsub(str, L"<.->", L"") and using a function as the
	-- third argument isn't working, we use {} instead of <> to surroudn the link tag and change them later
	--local NEW_LINK_TAG = L"{LINK data=\""..dataCapture..L"\" text=\""..textCapture..L"\" /}"
	local NEW_LINK_TAG = L"{LINK="..dataCapture..L","..textCapture..L"}"
	-- END KLUDGE2a
	
	-- END KLUDGE
	
	str = wstring.gsub(str, LEGACY_LINK_TAG, NEW_LINK_TAG)
	if str == "" then 
		return L""
	end	
	
	return str 
end



-- currently only handles the case of http links bringing up the web browser but
--	 we could add other generic cases, e.g. opening a help gump or a generic gump or whatever
--
-- linkParam is of type wstring
--
function WindowUtils.ProcessLink( linkParam )
	
    if (wstring.sub(linkParam, 1, 4) == L"http") then
       local url = tostring( linkParam )
       OpenWebBrowser( url)
    else
		--Debug.PrintToDebugConsole(L"WindowUtils.ProcessLink: Link type not known for "..linkParam )
    end
    
end

-- Note that if you are dynamically adding elements to the ScrollWindow, you should be done adding elements and have 
-- called ScrollWindowUpdateScrollRect before using this function
--
function WindowUtils.ScrollToElementInScrollWindow( element, scrollWindow, scrollChild, offset )

	if (not DoesWindowExist(element)) or (not DoesWindowExist(scrollChild)) then
		--Debug.Print("WindowUtils.GotoElementInScrollChild: Window does not exist!")
		return
	end

	if not offset then
		offset = 0
	end
	
	local elementX,elementY = WindowGetScreenPosition(element)
	local parentX,parentY = WindowGetScreenPosition(scrollChild)

	local scrollOffset = elementY - parentY - offset
		
	ScrollWindowSetOffset(scrollWindow, scrollOffset)
end

-- Note that if you are dynamically adding elements to the ScrollWindow, you should be done adding elements and have 
-- called HorizontalScrollWindowUpdateScrollRect before using this function
--
function WindowUtils.ScrollToElementInHorizontalScrollWindow( element, scrollWindow, scrollChild )

	if (not DoesWindowExist(element)) or (not DoesWindowExist(scrollChild)) then
		--Debug.Print("WindowUtils.GotoElementInScrollChild: Window does not exist!")
		return
	end
	
	local elementX,elementY = WindowGetScreenPosition(element)
	local parentX,parentY = WindowGetScreenPosition(scrollChild)
	local maxOffset = WindowGetDimensions(scrollChild)
	local scrollOffset = elementX - parentX
	
	-- sanity checks
	if (scrollOffset < 0) then
	    scrollOffset = 0
	end
	if (scrollOffset > maxOffset) then
	    scrollOffset = maxOffset
	end
	
	HorizontalScrollWindowSetOffset(scrollWindow, scrollOffset)
end

-- Append label text with ellipsis (...) if label text width exceeds label width
-- Used by the function that sets window titles too, so that all titles don't extend beyond the window that contains them
function WindowUtils.FitTextToLabel(labelName, labelText, isTitle )
	
	if not DoesWindowExist(labelName) then
		return
	end
	
---local DEBUG = false -- enable for verbose debugging of this function

	local labelWindowName = labelName
	if isTitle then
		labelText = wstring.upper(labelText)
		labelWindowName = labelName.."Chrome_UO_TitleBar_WindowTitle"	
---if DEBUG then Debug.Print( L"Called WindowUtils.FitTextToLabel() to set the title for window ''"..towstring(labelName)..L"'' to ''"..labelText..L"''" ) end
	else
---if DEBUG then Debug.Print( L"Called WindowUtils.FitTextToLabel( "..towstring(labelWindowName)..L", "..labelText..L" )" ) end
	end

	if not IsValidString(labelWindowName) or not IsValidWString(labelText) then
	   --Debug.Print("ERROR in WindowUtils.FitTextToLabel()! Window name or text is bad")
	   return 0
	end

    LabelSetWordWrap(labelWindowName, false)
	local labelX, labelY = WindowGetDimensions(labelName)
	if isTitle then
		labelX = labelX - 55 -- The window has about 55 pixels of spacing on both ends total that the title shouldn't use.
	end
	LabelSetText( labelWindowName, labelText )
	local textX, textY = LabelGetTextDimensions(labelWindowName)
	
---if DEBUG then Debug.Print( L"The space allowed for this label is "..labelX..L" pixels." ) end
---if DEBUG then Debug.Print( L"The current text size is "..textX..L" pixels." ) end

    local text = labelText

	if not textX or not labelX then
		return
	end
	
	while (textX  > labelX) and (text:len() > 1) do
		text = wstring.sub(text, 1, -2)
---if DEBUG then Debug.Print( L"The text width ("..textX..L") is still greater than the label width ("..labelX..L"), so we're changing the text to ''"..text..L"...''" ) end		
		LabelSetText(labelWindowName, text..L"...")
		textX, textY = LabelGetTextDimensions(labelWindowName)
---if DEBUG then Debug.Print( L"The new text size is width="..textX..L" height="..textY ) end
	end
---if DEBUG then Debug.Print( L"The text width ("..textX..L") is less than the label width ("..labelX..L"), so we are done." ) end		
end

-- Local Functions
function WindowUtils.CopyAnchors( sourceWindow, destWindow, xOffset, yOffset )

    WindowClearAnchors( destWindow )

    local numAnchors = WindowGetAnchorCount( sourceWindow )
    for index = 1, numAnchors
    do
        local point, relativePoint, relativeTo, xoffs, yoffs = WindowGetAnchor( sourceWindow, index )           
        WindowAddAnchor( destWindow , point, relativeTo, relativePoint, xoffs+xOffset, yoffs+yOffset )
    end
end

function WindowUtils.CopyScreenPosition( sourceWindow, destWindow, xOffset, yOffset )
    local uiScale = InterfaceCore.scale
    local screenX, screenY = WindowGetScreenPosition( sourceWindow )        
    
    local xPos = math.floor( (screenX + xOffset)/uiScale + 0.5 )
    local yPos = math.floor( (screenY + yOffset)/uiScale + 0.5 )
    
    --Debug.Print("CopyScreenPosition "..destWindow..": "..xPos..", "..yPos)
    
    WindowClearAnchors( destWindow )
    WindowAddAnchor(destWindow,"topleft","Root","topleft",xPos,yPos)
end

function WindowUtils.CopySize( sourceWindow, destWindow, xOffset, yOffset, offsetInDestCoords )
        
    local width, height = WindowGetDimensions( sourceWindow )
           
    local sourceScale = WindowGetScale( sourceWindow )
    local destScale   = WindowGetScale( destWindow )
    local scaleConvert = destScale / sourceScale
    
    if (offsetInDestCoords ) 
    then
        width  = width*scaleConvert + xOffset
        height = height*scaleConvert + yOffset
    else
        width  = (width + xOffset) * scaleConvert
        height = (height + yOffset)* scaleConvert
    end
    
    WindowSetDimensions( destWindow, width, height ) 
end

function WindowUtils.GetScaledScreenPosition( sourceWindow )
    local uiScale = InterfaceCore.scale
    local screenX, screenY = WindowGetScreenPosition( sourceWindow )        
    
    local xPos = math.floor( screenX/uiScale + 0.5 )
    local yPos = math.floor( screenY/uiScale + 0.5 )
    
    --Debug.Print("GetScaledScreenPosition "..destWindow..": "..xPos..", "..yPos)
    
    return xPos, yPos
end

-- Debugging purposes. Used for creating visible outlines of windows passed into this function.
-- Make sure to use DestroyWindowOutline during window destruction as well.
function WindowUtils.CreateWindowOutline(windowName)
	local debugWindow = "DebugWindowOutline_"..windowName
	
	if (DoesWindowExist(debugWindow) == false) then
		CreateWindowFromTemplate(debugWindow, "SnapWindowTemplate", "Root")
		WindowUtils.CopySize( windowName, debugWindow, 0, 0 )
	    
		WindowClearAnchors(debugWindow)
		WindowAddAnchor(debugWindow, "topleft", windowName, "topleft", 0, 0)
	    
		WindowSetShowing(debugWindow, true)
	end
end

function WindowUtils.DestroyWindowOutline(windowName)
	local debugWindow = "DebugWindowOutline_"..windowName
	if (DoesWindowExist(debugWindow) == true) then
		DestroyWindow(debugWindow)
	end
end

----------------------------
-- Snapping functionality
----------------------------

SnapUtils = {}
SnapUtils.SnappableWindows = {}

SnapUtils.CurWindow = nil
SnapUtils.SnapWindow = nil
SnapUtils.SnapIndex = nil

SnapUtils.ANCHOR_POINT_TOP_LEFT       = 1
SnapUtils.ANCHOR_POINT_TOP            = 2
SnapUtils.ANCHOR_POINT_TOP_RIGHT      = 3
SnapUtils.ANCHOR_POINT_LEFT           = 4
SnapUtils.ANCHOR_POINT_CENTER         = 5
SnapUtils.ANCHOR_POINT_RIGHT          = 6
SnapUtils.ANCHOR_POINT_BOTTOM_LEFT    = 7
SnapUtils.ANCHOR_POINT_BOTTOM         = 8
SnapUtils.ANCHOR_POINT_BOTTOM_RIGHT   = 9

SnapUtils.ANCHOR_POINTS =
{ 
    [SnapUtils.ANCHOR_POINT_TOP_LEFT      ] = { name="topleft",       widthMultipler=0.0,  heightMultiplier=0.0 },
    [SnapUtils.ANCHOR_POINT_TOP           ] = { name="top",           widthMultipler=0.5,  heightMultiplier=0.0 },
    [SnapUtils.ANCHOR_POINT_TOP_RIGHT     ] = { name="topright",      widthMultipler=1.0,  heightMultiplier=0.0 },
    [SnapUtils.ANCHOR_POINT_LEFT          ] = { name="left",          widthMultipler=0.0,  heightMultiplier=0.5 },
    [SnapUtils.ANCHOR_POINT_CENTER        ] = { name="center",        widthMultipler=0.5,  heightMultiplier=0.5 },
    [SnapUtils.ANCHOR_POINT_RIGHT         ] = { name="right",         widthMultipler=1.0,  heightMultiplier=0.5 },
    [SnapUtils.ANCHOR_POINT_BOTTOM_LEFT   ] = { name="bottomleft",    widthMultipler=0.0,  heightMultiplier=1.0 },
    [SnapUtils.ANCHOR_POINT_BOTTOM        ] = { name="bottom",        widthMultipler=0.5,  heightMultiplier=1.0 },
    [SnapUtils.ANCHOR_POINT_BOTTOM_RIGHT  ] = { name="bottomright",   widthMultipler=1.0,  heightMultiplier=1.0 },
}

SnapUtils.SNAP_PAIRS =
{ 
    -- Window 1                                 -- Window 2
    {SnapUtils.ANCHOR_POINT_TOP_LEFT,         SnapUtils.ANCHOR_POINT_BOTTOM_LEFT },
    {SnapUtils.ANCHOR_POINT_TOP_LEFT,         SnapUtils.ANCHOR_POINT_TOP_RIGHT },
    {SnapUtils.ANCHOR_POINT_TOP,              SnapUtils.ANCHOR_POINT_BOTTOM },
    {SnapUtils.ANCHOR_POINT_TOP_RIGHT,        SnapUtils.ANCHOR_POINT_BOTTOM_RIGHT },
    {SnapUtils.ANCHOR_POINT_TOP_RIGHT,        SnapUtils.ANCHOR_POINT_TOP_LEFT },
    {SnapUtils.ANCHOR_POINT_LEFT,             SnapUtils.ANCHOR_POINT_RIGHT },
    {SnapUtils.ANCHOR_POINT_RIGHT,            SnapUtils.ANCHOR_POINT_LEFT },
    {SnapUtils.ANCHOR_POINT_RIGHT,            SnapUtils.ANCHOR_POINT_LEFT },
    {SnapUtils.ANCHOR_POINT_BOTTOM_LEFT,      SnapUtils.ANCHOR_POINT_BOTTOM_RIGHT },
    {SnapUtils.ANCHOR_POINT_BOTTOM_LEFT,      SnapUtils.ANCHOR_POINT_TOP_LEFT },
    {SnapUtils.ANCHOR_POINT_BOTTOM,           SnapUtils.ANCHOR_POINT_TOP },    
    {SnapUtils.ANCHOR_POINT_BOTTOM_RIGHT,     SnapUtils.ANCHOR_POINT_TOP_RIGHT },
    {SnapUtils.ANCHOR_POINT_BOTTOM_RIGHT,     SnapUtils.ANCHOR_POINT_BOTTOM_LEFT },
}

function SnapUtils.GetAnchorDistance( anchorsList1, anchor1, anchorsList2, anchor2 )

    local xDistance = anchorsList1[anchor1].x - anchorsList2[anchor2].x 
    local yDistance = anchorsList1[anchor1].y - anchorsList2[anchor2].y 

    return math.sqrt( xDistance*xDistance + yDistance*yDistance )
end

function SnapUtils.ComputeAnchorScreenPositions( windowName )

    local uiScale = InterfaceCore.scale
    local screenX, screenY = WindowGetScreenPosition( windowName ) 
    
    local width, height = WindowGetDimensions( windowName ) 
    local scale = WindowGetScale( windowName ) 
        
    width   = width*scale
    height  = height*scale
    
    -- Compute the XY coordates for each anchor point
        
    local positions = {}    
    for index = 1, #SnapUtils.ANCHOR_POINTS do    

		local anchorPoint = SnapUtils.ANCHOR_POINTS[index]
        positions[index] = { 
                             x=screenX + width*anchorPoint.widthMultipler,
                             y=screenY + height*anchorPoint.heightMultiplier
                           }
    end   
    
    return positions

end

function SnapUtils.StartWindowSnap( windowName )
	if (not Interface.Settings.EnableSnapping) then
		WindowSetMoving(windowName,true)
		return 
	end
    --Debug.Print("SnapUtils.StartWindowSnap: "..tostring(windowName))
    local scale = WindowGetScale(windowName)
    if (not DoesWindowExist("SnapWindow")) then
		CreateWindowFromTemplate("SnapWindow", "SnapWindowTemplate", "Root")
    end
    WindowSetScale("SnapWindow", scale)
    WindowUtils.CopySize( windowName, "SnapWindow", 0, 0 )
    WindowSetShowing("SnapWindow",false)
    
	local x,y = WindowGetScreenPosition("SnapWindow")
	local w,h = WindowGetDimensions("SnapWindow")

    
	SnapUtils.CurWindow = windowName
	WindowSetMoving(windowName,true)
end

function SnapUtils.EndWindowSnap( windowName )
    --Debug.Print("SnapUtils.EndWindowSnap: "..tostring(windowName))
    
    if (SnapUtils.SnapWindow and DoesWindowExist(SnapUtils.CurWindow)) then
        WindowUtils.CopyScreenPosition( "SnapWindow", SnapUtils.CurWindow, 0, 0)
    end

	-- get the pet window name
	local _, petWindow = MobileBarsDockspot.GetPetDockspotStatus()

	if SnapUtils.CurWindow == petWindow then
		WindowClearAnchors("Hotbar" .. Interface.PetControlsBar)
		WindowAddAnchor("Hotbar" .. Interface.PetControlsBar, "topright", petWindow, "topleft", Hotbar.PetControlBar_Shift_X ,0)
	end
	
    SnapUtils.SnapWindow = nil
    DestroyWindow("SnapWindow")
end

function SnapUtils.SnapUpdate( timePassed )
    if (SnapUtils.CurWindow) then
		if (WindowGetMoving(SnapUtils.CurWindow) == false or DoesWindowExist(SnapUtils.CurWindow) == false) then
		    SnapUtils.EndWindowSnap( SnapUtils.CurWindow )
			SnapUtils.CurWindow = nil
		else
		    SnapUtils.FindSnap()
	    end
    end 
end

function SnapUtils.FindSnap()
    local maxSnapDistance = 20
    local anchorPositions = SnapUtils.ComputeAnchorScreenPositions(SnapUtils.CurWindow)
    local distance = maxSnapDistance + 1
    SnapUtils.SnapWindow = nil
    SnapUtils.SnapIndex = nil

	-- get the pets window name
	local _, petWindow = MobileBarsDockspot.GetPetDockspotStatus()
    
    for windowName,_ in pairs(SnapUtils.SnappableWindows) do

		if SnapUtils.CurWindow == petWindow and windowName == "Hotbar" .. Interface.PetControlsBar then
			continue
		end
		
        if  ( windowName ~= SnapUtils.CurWindow) then          
        
            local comparePositions = SnapUtils.ComputeAnchorScreenPositions(windowName)            
            
            for index = 1, #SnapUtils.SNAP_PAIRS do
				
				-- get the snap pair window
				local snapPair = SnapUtils.SNAP_PAIRS[index]

                local dist = SnapUtils.GetAnchorDistance( anchorPositions, snapPair[1], comparePositions, snapPair[2] )
                
                -- If the distance between the anchors is within the snap threshold, save the value
                if ((dist <= maxSnapDistance) and (dist < distance) and WindowGetShowing(windowName) )
                then
                    distance = dist
                    SnapUtils.SnapWindow = windowName
                    SnapUtils.SnapIndex = index
                end
           end
        end
    end
    
    if (SnapUtils.SnapWindow) then
        WindowSetShowing("SnapWindow", true)
        
        local anchorPt   = SnapUtils.SNAP_PAIRS[ SnapUtils.SnapIndex][2]
        local anchorToPt = SnapUtils.SNAP_PAIRS[ SnapUtils.SnapIndex][1]

        -- Anchor the SnapFrame to it's anchor point.
        WindowClearAnchors("SnapWindow")
        WindowAddAnchor( "SnapWindow", SnapUtils.ANCHOR_POINTS[anchorPt].name, SnapUtils.SnapWindow, SnapUtils.ANCHOR_POINTS[anchorToPt].name, 0, 0 )
        
        return true
    else
        WindowSetShowing("SnapWindow", false)
    end
    
    return false
end

function WindowUtils.TrapClick()
end

WindowUtils.DefaultWindowNames = {
	"LEGACY_Runebook_GUMP",
	"ContainerWindow",
	"MobileBar",
	"ObjectHandleWindow",
	"CourseMapWindow",
	"Spellbook",
}

function WindowUtils.Aplpha(x, y, delta, flags)
	
	-- window name to alter
	local windowname = WindowUtils.GetActiveDialog()

	-- store the original window name
	local originalWindow = windowname
	
	-- scan the default window names (to be converted)
	for i, compareName in pairsByIndex(WindowUtils.DefaultWindowNames) do

		-- does the window contains the default name?
		if string.find(windowname, compareName, 1, true) then

			-- set the window name as the default name + "ALPHA"
			windowname = compareName

			-- we can get out now
			break
		end
	end

	-- is this a mobile bar?
	if string.find(windowname, "Dockspot", 1, true) or windowname == "MobileBar" then

		-- alpha disabled for healthbars and dockspot (it causes a mess with the animations)
		return
	end

	-- is this a gump?
	if GenericGump.GumpsList[windowname] then
		windowname = "Gump" .. GenericGump.GumpsList[windowname]
	end

	-- get the current alpha level	
	local scale = WindowGetAlpha(originalWindow)
	
	-- calculate the new alpha value
	local endscale = delta * 0.05 + scale

	-- reset the scale to default
	if flags == WindowUtils.ButtonFlags.CONTROL then
		endscale = 1
	end
	
	-- do we have a valid alpha value?
	if endscale <= 1 and endscale > 0.01 then
		
		-- is this the object handle window?
		if windowname == "Spellbook" then

			-- scan all spellbooks
			for id, _ in pairs(WindowData.Spellbook) do

				-- is this a valid spellbook?
				if IsValidID(id) then

					-- spellbook window name
					local spellbookWindow = "Spellbook_" .. id

					-- set the new alpha value
					WindowSetAlpha(spellbookWindow, endscale)

					-- set the new font alpha value
					WindowSetFontAlpha(spellbookWindow, endscale)
				end
			end

		-- is this the target window?
		elseif windowname == "TargetWindow" then
				
			-- scale the target window
			WindowSetScale(originalWindow, endscale)

			-- scan all buttons
			for i, button in pairsByIndex(TargetWindow.Buttons) do

				-- does the button exist?
				if DoesWindowExist(button) then

					-- set the new alpha value
					WindowSetAlpha(button, endscale)

					-- set the new font alpha value
					WindowSetFontAlpha(button, endscale)
				end
			end

		-- is this the object handle window?
		elseif windowname == "ObjectHandleWindow" then
				
			-- update the scale on every object handle
			for objectId, _ in pairs(ObjectHandleWindow.hasWindow) do
					
				-- current window name
				local objHandle = "ObjectHandleWindow" .. objectId

				-- update the transparency
				if DoesWindowExist(objHandle) then

					-- set the new alpha value
					WindowSetAlpha(objHandle, endscale)

					-- set the new font alpha value
					WindowSetFontAlpha(objHandle, endscale)
				end
			end

		-- is this the map window?
		elseif windowname == "MapWindow" then

			-- set the new alpha value
			WindowSetAlpha(windowname, endscale)

			-- set the new font alpha value
			WindowSetFontAlpha(windowname, endscale)

		-- is this a hotbar?
		elseif string.find(originalWindow, "Hotbar", 1, true) then

			-- scan all the hotbar's slots
			for slot = 1, Hotbar.NUM_BUTTONS do

			   -- get the slot name
				local element = originalWindow .. "Button" .. slot .. "Cooldown"

				-- do we have the cooldown in this slot?
				if DoesWindowExist(element) then
					
					-- apply the new scale value to the cooldown overlay
					WindowSetScale(element, endscale)
				end
			end	

			-- set the new alpha value
			WindowSetAlpha(originalWindow, endscale)

			-- set the new font alpha value
			WindowSetFontAlpha(originalWindow, endscale)

		-- is this the status window?
		elseif originalWindow == "StatusWindow" then

			-- set the new alpha value
			WindowSetAlpha(originalWindow, endscale)

			-- set the new font alpha value
			WindowSetFontAlpha(originalWindow, endscale)

			-- is the war/peace shield visible?
			if DoesWindowExist("WarButton") then
				
				-- apply the new alpha to the war/peace button
				WindowSetAlpha("WarButton", endscale)
			end

		else -- any other window
			
			-- set the new alpha value
			WindowSetAlpha(originalWindow, endscale)

			-- set the new font alpha value
			WindowSetFontAlpha(originalWindow, endscale)
		end
		
		-- save the alpha value
		Interface.SaveSetting(windowname .. "ALP", endscale)
	end
	
end

function WindowUtils.Scale(x, y, delta, flags)

	-- get the window name to scale
	local windowname = WindowUtils.GetActiveDialog()

	-- make sure is not the VvV gump
	if GumpsParsing.VvVGump == windowname then
		return
	end
	
	-- if it's a container window in freeform, we must go out, is VERY bad to scale freeform containers
	if string.find(windowname, "ContainerWindow", 1, true) and ContainerWindow.ViewModes[WindowGetId(windowname)] == "Freeform" then
		return
	end

	-- fix the bouy tool window name
	if windowname == "BuoyToolSW" then
		windowname = "BuoyToolWindow"
	end
	
	-- set the max scale
	local maxScale = 1.5

	-- is the alpha mode active?
	if WindowUtils.ToggleAlpha then

		-- use the alpha mode
		WindowUtils.Aplpha(x, y, delta, flags)
		
	-- is the scale mode active?
	elseif WindowUtils.ToggleScale then
		
		-- store the original window name
		local originalWindow = windowname
		
		-- scan the default window names (to be converted)
		for i, compareName in pairsByIndex(WindowUtils.DefaultWindowNames) do

			-- does the window contains the default name?
			if string.find(windowname, compareName, 1, true) then

				-- set the window name as the default name + "ALPHA"
				windowname = compareName

				-- we can get out now
				break
			end
		end

		-- is this a dockspot?
		if string.find(windowname, "Dockspot", 1, true) then

			-- we work it as a mobileBar
			windowname = "MobileBar"
		end

		-- is this a listed gump?
		if GenericGump.GumpsList[windowname] then

			-- update the save name
			windowname = "Gump" .. GenericGump.GumpsList[windowname]

		-- is this an unlisted gump?
		elseif string.find(windowname , "GenericGump", 1, true) then

			-- update the save name
			windowname = "GGump"

			-- update the max scale
			maxScale = 3.0

		-- treasure map can be scaled much more than normal windows
		elseif windowname == "CourseMapWindow" then
			
			-- update the max scale
			maxScale = 3.0
		end
		
		-- get the current scale level
		local scale = WindowGetScale(originalWindow)
		
		-- calculate the new scale value
		local endscale = delta * 0.05 + scale

		-- reset the scale to default
		if flags == WindowUtils.ButtonFlags.CONTROL then
			endscale = InterfaceCore.scale
		end
		
		-- do we have a valid scale value?
		if endscale < maxScale and endscale > 0.25 then

			-- add the unlisted gump scale to the table
			if windowname == "GGump" then
				GenericGump.GGumps[originalWindow] = endscale
			end
			
			-- is this a mobile bar?
			if windowname == "MobileBar" then
			
				-- initialize the bar and dockspot type to scale
				local barType
				local dockspotType

				-- initialize the dockspot name
				local dockspotName

				-- is this a dockspot?
				if string.find(originalWindow, "Dockspot", 1, true) then

					-- store the dockspot type
					dockspotType = MobileBarsDockspot.Dockspots[originalWindow].dockspotType

					-- set the dockspot name
					dockspotName = originalWindow

				else -- is a healthbar, get the type

					-- get the bar data
					local barData = MobileHealthBar.ActiveBars[MobileHealthBar.GetMobileIDByWindowName(originalWindow)]

					-- get the bar type
					barType = barData.type

					-- set the dockspot name
					dockspotName = barData.dockspot

					-- get the bar dockspot type
					dockspotType = MobileBarsDockspot.Dockspots[dockspotName].dockspotType
				end

				-- append the type to the string
				windowname = windowname .. "_" .. MobileBarsDockspot.DockspotTypeToString(dockspotType)

				-- scan all healthbars
				for mobileId, data in pairs(MobileHealthBar.ActiveBars) do

					-- compare the dockspot type with the current bar type
					if  (dockspotType == MobileBarsDockspot.DockspotType.PET and data.type == MobileHealthBar.HealthbarsType.PET and not data.pinned) or -- is this a pet bar?
						(dockspotType == MobileBarsDockspot.DockspotType.PARTY and data.type == MobileHealthBar.HealthbarsType.PARTY and not data.pinned) or -- is this a party bar?
						(dockspotType == MobileBarsDockspot.DockspotType.PINNED and data.pinned) or
						(dockspotType == MobileBarsDockspot.DockspotType.MOBILES and (data.type == MobileHealthBar.HealthbarsType.NORMAL or data.type == MobileHealthBar.HealthbarsType.INVULNERABLE) and not data.pinned)
					then

						-- set the new scale
						WindowSetScale(data.windowName, endscale)
					end
				end

				-- set the new scale
				WindowSetScale(dockspotName, endscale)

				-- scale the dockspot layout
				MobileBarsDockspot.ScaleLayoutGrid(dockspotName)

				-- flag to update the pet controls bar
				MobileBarsDockspot.Dockspots[dockspotName].hasBeenMoved = true

			-- is this the object handle window?
			elseif windowname == "Spellbook" then

				-- scan all spellbooks
				for id, _ in pairs(WindowData.Spellbook) do

					-- is this a valid spellbook?
					if IsValidID(id) then

						-- spellbook window name
						local spellbookWindow = "Spellbook_" .. id

						-- set the new scale
						WindowSetScale(spellbookWindow, endscale)
					end
				end
			
			-- is this the target window?
			elseif windowname == "TargetWindow" then
				
				-- scale the target window
				WindowSetScale(originalWindow, endscale)

				-- scan all buttons
				for i, button in pairsByIndex(TargetWindow.Buttons) do

					-- does the button exist?
					if DoesWindowExist(button) then

						-- scale the button
						WindowSetScale(button, endscale - (endscale / 4))
					end
				end

			-- is this the object handle window?
			elseif windowname == "ObjectHandleWindow" then
				
				-- update the scale on every object handle
				for objectId, _ in pairs(ObjectHandleWindow.hasWindow) do
					
					-- current window name
					local objHandle = "ObjectHandleWindow" .. objectId

					-- update the scale
					if DoesWindowExist(objHandle) then

						-- set the new scale
						WindowSetScale(objHandle, endscale)
					end
				end

			-- is this a hotbar?
			elseif string.find(originalWindow, "Hotbar", 1, true) then

				-- scan all the hotbar's slots
				for slot = 1, Hotbar.NUM_BUTTONS do

					-- get the slot name
					local element = originalWindow .. "Button" .. slot .. "Cooldown"

					-- do we have the cooldown in this slot?
					if DoesWindowExist(element) then
					
						-- apply the new scale value to the cooldown overlay
						WindowSetScale(element, endscale)
					end
				end	
				
				-- set the new scale
				WindowSetScale(originalWindow, endscale)

			-- is this the status window?
			elseif originalWindow == "StatusWindow" then

				-- set the new scale
				WindowSetScale(originalWindow, endscale)

				-- is the war/peace shield visible?
				if DoesWindowExist("WarButton") then
					
					-- apply the new scale to the war/peace button
					WindowSetScale("WarButton", endscale)
				end

			-- is this a paperdoll window?
			elseif windowname == "PperdollWindow" then

				-- set the new scale
				WindowSetScale(originalWindow, endscale)

				-- update the paperdoll to avoid glitches
				PaperdollWindow.UpdatePaperdoll(WindowGetId(originalWindow))

			-- is this a treasure map?
			elseif windowname == "CourseMapWindow" then

				-- set the new scale
				WindowSetScale(originalWindow, endscale)

				-- get the new map size
				local width, height = WindowGetDimensions(originalWindow.."Texture")

				-- update the map size with the new scale
				CourseMapWindow.CurrMapSize.width = width * endscale
				CourseMapWindow.CurrMapSize.height = height * endscale
				
				-- update the map points
				CourseMapWindow.UpdatePoints()

			else -- any other window

				-- set the new scale
				WindowSetScale(originalWindow, endscale)
			end
			
			-- save the scale
			Interface.SaveSetting(windowname .. "SC", endscale)
			
			-- is this a container window?
			if windowname == "ContainerWindow" then

				-- re-create the container
				ContainerWindow.CreateContainer(originalWindow, true)
			end
		end
	end
end

function WindowUtils.LoadAlpha(windowname)
	
	-- do we have a valid window name?
	if not IsValidString(windowname) then
		return
	end

	-- store the original window name
	local originalWindow = windowname

	-- scan the default window names (to be converted)
	for i, compareName in pairsByIndex(WindowUtils.DefaultWindowNames) do

		-- does the window contains the default name?
		if string.find(windowname, compareName, 1, true) then

			-- set the window name as the default name + "ALPHA"
			windowname = compareName

			-- we can get out now
			break
		end
	end

	-- is this a mobile bar?
	if string.find(windowname, "Dockspot", 1, true) or windowname == "MobileBar" then

		-- alpha disabled for healthbars and dockspot (it causes a mess with the animations)
		return
	end

	-- is this a listed gump?
	if GenericGump.GumpsList[windowname] then
		windowname = "Gump" .. GenericGump.GumpsList[windowname]

	-- is this an unlisted gump?
	elseif string.find(windowname , "GenericGump", 1, true) then

		-- update the save name
		windowname = "GGump"
	end

	-- load the saved alpha
	local scale = Interface.LoadSetting(windowname .. "ALP", -5)
		
	-- do we have a valid alpha value?
	if scale and scale ~= -5 then

		-- make sure the alpha doesn't go below 0.01
		if scale <  0.01 then
			scale = 0.01
		end

		-- is this the object handle window?
		if windowname == "Spellbook" then

			-- scan all spellbooks
			for id, _ in pairs(WindowData.Spellbook) do

				-- is this a valid spellbook?
				if IsValidID(id) then

					-- spellbook window name
					local spellbookWindow = "Spellbook_" .. id

					-- set the new alpha value
					WindowSetAlpha(spellbookWindow, scale)

					-- set the new font alpha value
					WindowSetFontAlpha(spellbookWindow, scale)
				end
			end

		-- is this the target window?
		elseif windowname == "TargetWindow" then
				
			-- scale the target window
			WindowSetScale(originalWindow, endscale)

			-- scan all buttons
			for i, button in pairsByIndex(TargetWindow.Buttons) do

				-- does the button exist?
				if DoesWindowExist(button) then

					-- set the new alpha value
					WindowSetAlpha(button, scale)

					-- set the new font alpha value
					WindowSetFontAlpha(button, scale)
				end
			end

		-- is this the object handle window?
		elseif windowname == "ObjectHandleWindow" then
				
			-- update the scale on every object handle
			for objectId, _ in pairs(ObjectHandleWindow.hasWindow) do
					
				-- current window name
				local objHandle = "ObjectHandleWindow" .. objectId

				-- update the transparency
				if DoesWindowExist(objHandle) then

					-- set the new alpha value
					WindowSetAlpha(objHandle, scale)

					-- set the new font alpha value
					WindowSetFontAlpha(objHandle, scale)
				end
			end

		-- is this the map windoe?
		elseif windowname == "MapWindow" then

			-- set the new alpha value
			WindowSetAlpha(windowname, scale)

			-- set the new font alpha value
			WindowSetFontAlpha(windowname, scale)

		-- is this a hotbar?
		elseif string.find(originalWindow, "Hotbar", 1, true) then

			-- scan all the hotbar's slots
			for slot = 1, Hotbar.NUM_BUTTONS do

				-- get the slot name
				local element = originalWindow .. "Button" .. slot .. "Cooldown"

				-- do we have the cooldown in this slot?
				if DoesWindowExist(element) then
					
					-- apply the new scale value to the cooldown overlay
					WindowSetScale(element, scale)
				end
			end	

			-- set the new alpha value
			WindowSetAlpha(originalWindow, scale)

			-- set the new font alpha value
			WindowSetFontAlpha(originalWindow, scale)

		-- is this the status window?
		elseif originalWindow == "StatusWindow" then

			-- set the new alpha value
			WindowSetAlpha(originalWindow, scale)

			-- set the new font alpha value
			WindowSetFontAlpha(originalWindow, scale)

			-- is the war/peace shield visible?
			if DoesWindowExist("WarButton") then

				-- apply the new alpha to the war/peace button
				WindowSetAlpha("WarButton", scale)
			end

		else -- any other window
			
			-- set the new alpha value
			WindowSetAlpha(originalWindow, scale)

			-- set the new font alpha value
			WindowSetFontAlpha(originalWindow, scale)
		end
	end
end

function WindowUtils.LoadScale(windowname, default)
	
	-- do we have a valid window name?
	if not IsValidString(windowname) then
		return
	end

	-- make sure is not the VvV gump
	if GumpsParsing.VvVGump == windowname then
		return
	end

	-- load the window alpha first
	WindowUtils.LoadAlpha(windowname)
		
	-- store the original window name
	local originalWindow = windowname
		
	-- scan the default window names (to be converted)
	for i, compareName in pairsByIndex(WindowUtils.DefaultWindowNames) do

		-- does the window contains the default name?
		if string.find(windowname, compareName, 1, true) then

			-- set the window name as the default name + "ALPHA"
			windowname = compareName

			-- we can get out now
			break
		end
	end

	-- is this a mobile bar?
	if windowname == "MobileBar" then

		-- get the bar data
		local barData = MobileHealthBar.ActiveBars[MobileHealthBar.GetMobileIDByWindowName(originalWindow)]

		-- append the type to the string
		windowname = windowname .. "_" .. MobileBarsDockspot.DockspotTypeToString(MobileBarsDockspot.Dockspots[barData.dockspot].dockspotType)
	end

	-- is this a dockspot?
	if string.find(windowname, "Dockspot", 1, true) then

		-- append the type to the string
		windowname = "MobileBar_" .. MobileBarsDockspot.DockspotTypeToString(MobileBarsDockspot.Dockspots[originalWindow].dockspotType)
	end

	-- is this a listed gump?
	if GenericGump.GumpsList[windowname] then

		-- update the save name
		windowname = "Gump" .. GenericGump.GumpsList[windowname]

	-- is this an unlisted gump?
	elseif string.find(windowname , "GenericGump", 1, true) then

		-- update the save name
		windowname = "GGump"
	end
		
	-- load the saved scale
	local scale = Interface.LoadSetting(windowname .. "SC", -5)
		
	-- do we have a valid scale?
	if scale ~= nil and scale ~= -5 then
	
		-- make sure the scale doesn't go below 0.25
		if scale <  0.25 then
			scale = 0.25
		end

		-- treasure map and gumps have the max scale capped to 3
		if (windowname == "CourseMapWindow" or windowname == "GGump") and scale > 3 then

			-- fix the scale
			scale = 3

		-- any other window has the scale capped to 1.5
		elseif (scale > 1.5) and not (windowname == "CourseMapWindow" or windowname == "GGump") then

			-- fix the scale
			scale = 1.5
		end
			
		-- is this the object handle window?
		if windowname == "Spellbook" then

			-- scan all spellbooks
			for id, _ in pairs(WindowData.Spellbook) do

				-- is this a valid spellbook?
				if IsValidID(id) then

					-- spellbook window name
					local spellbookWindow = "Spellbook_" .. id

					-- set the new scale
					WindowSetScale(spellbookWindow, scale)
				end
			end
			
		-- is this the target window?
		elseif windowname == "TargetWindow" then
				
			-- scale the target window
			WindowSetScale(originalWindow, scale)

			-- scan all buttons
			for i, button in pairsByIndex(TargetWindow.Buttons) do

				-- does the button exist?
				if DoesWindowExist(button) then

					-- scale the button
					WindowSetScale(button, scale - (scale / 4))
				end
			end

		-- is this the object handle window?
		elseif windowname == "ObjectHandleWindow" then
				
			-- update the scale on every object handle
			for objectId, _ in pairs(ObjectHandleWindow.hasWindow) do
					
				-- current window name
				local objHandle = "ObjectHandleWindow" .. objectId

				-- update the scale
				if DoesWindowExist(objHandle) then

					-- set the new scale
					WindowSetScale(objHandle, scale)
				end
			end

		-- is this the map window?
		elseif (windowname == "MapWindow") then

			-- scale the window
			WindowSetScale(windowname, scale)

			-- update the waypoints
			MapCommon.WaypointsDirty = true

		-- is this a hotbar?
		elseif string.find(originalWindow, "Hotbar", 1, true) then

			-- scan all the hotbar's slots
			for slot = 1, Hotbar.NUM_BUTTONS do

				-- get the slot name
				local element = originalWindow .. "Button" .. slot .. "Cooldown"

				-- do we have the cooldown in this slot?
				if DoesWindowExist(element) then
					
					-- apply the new scale value to the cooldown overlay
					WindowSetScale(element, scale)
				end
			end	

			-- set the new scale
			WindowSetScale(originalWindow, scale)

		-- is this the status window?
		elseif originalWindow == "StatusWindow" then

			-- set the new scale
			WindowSetScale(originalWindow, scale)

			-- is the war/peace shield visible?
			if DoesWindowExist("WarButton") then

				-- apply the new scale to the war/peace button
				WindowSetScale("WarButton", scale)
			end

			-- do we have a glowing effect?
			if DoesWindowExist("GlowingEffectHealth") then

				-- clear the glowing effect position
				WindowClearAnchors("GlowingEffectHealth")

				-- center the glowing effect
				WindowAddAnchor("GlowingEffectHealth", "center", "StatusWindowPortraitBg", "center", 14, 10)

				-- scale the glowing effect
				WindowSetScale("GlowingEffectHealth", scale)
			end

		-- is this a paperdoll window?
		elseif windowname == "PperdollWindow" then

			-- set the new scale
			WindowSetScale(originalWindow, scale)

			-- update the paperdoll to avoid glitches
			PaperdollWindow.UpdatePaperdoll(WindowGetId(originalWindow))

		-- is this a treasure map?
		elseif windowname == "CourseMapWindow" then

			-- set the new scale
			WindowSetScale(originalWindow, scale)

			-- get the new map size
			local width, height = WindowGetDimensions(originalWindow.."Texture")

			-- update the map size with the new scale
			CourseMapWindow.CurrMapSize.width = width * scale
			CourseMapWindow.CurrMapSize.height = height * scale
				
			-- update the map points
			CourseMapWindow.UpdatePoints()

		else -- any other window

			-- set the new scale
			WindowSetScale(originalWindow, scale)
		end			
	end
end

function WindowUtils.Dec2Hex(nValue)
	if type(nValue) == "string" then
		nValue = String.ToNumber(nValue);
	end
	nHexVal = string.format("%X", nValue);  -- %X returns uppercase hex, %x gives lowercase letters
	sHexVal = nHexVal.."";
	return sHexVal;
end

function WindowUtils.FollowMouseCursor(windowName, width, height, shiftX, shiftY, useWindowScale, clearAnchors, snap)
	if clearAnchors then
		WindowClearAnchors(windowName)
	end

	local propWindowX = 0
	local propWindowY = 0

	local scale = InterfaceCore.scale
	if useWindowScale then
		scale = WindowGetScale(windowName)
	end
	local scaleFactor = 1 / scale
	
	-- Set the position
	local mouseX = SystemData.MousePosition.x + shiftX
	if mouseX + (width / scaleFactor) > SystemData.screenResolution.x then
		propWindowX = mouseX - (width / scaleFactor)
	else
		propWindowX = mouseX
	end
		
	local mouseY = SystemData.MousePosition.y + shiftY
	if mouseY + (height / scaleFactor) > SystemData.screenResolution.y then
		propWindowY = mouseY - (height / scaleFactor)
	else
		propWindowY = mouseY
	end
	
	WindowSetOffsetFromParent(windowName, propWindowX * scaleFactor, propWindowY * scaleFactor)

	if snap then
		SnapUtils.StartWindowSnap(windowName)
	end
end

function WindowUtils.FormatBindings(key, key2, shortKeys)

	-- do we have a key 2? (used to determine the label color)
	if not key2 then
		
		-- set the key 2 = to the other key
		key2 = key
	end

	-- default color
	local color = Interface.Settings.HB_Plain

	-- do we have the key?
	if IsValidWString(key) then

		-- fix the text for "<"
		if (wstring.find(key , L"OEM_102", 1, true) ~= nil) then
			key = wstring.gsub(key, L"OEM_102", L"<")
		end
		
		-- fix the text for "delete"
		if (wstring.find(key , L"Delete", 1, true) ~= nil) then
			key = wstring.gsub(key, L"Delete", L"Del")
		end
		
		-- fix the text for "num pad" numbers
		if (wstring.find(key , L"Num Pad", 1, true) ~= nil) then
			key = wstring.gsub(key, L"Num Pad:", L"NP")
		end
		
		-- fix the text for "+"
		if (wstring.find(key , L"Plus", 1, true) ~= nil) then
			key = wstring.gsub(key, L"Plus", L"+")
		end
		
		-- fix the text for "space"
		if (wstring.find(key , L"Space", 1, true) ~= nil) then
			key = wstring.gsub(key, L"Space", L"Spc")
		end
		
		-- fix the text for "backspace"
		if (wstring.find(key , L"BackSpc", 1, true) ~= nil) then
			key = wstring.gsub(key, L"BackSpc", L"Back")
		end
		
		-- fix the text for "insert"
		if (wstring.find(key , L"Insert", 1, true) ~= nil) then
			key = wstring.gsub(key, L"Insert", L"Ins")
		end
		
		-- fix the text for "page up"
		if (wstring.find(key , L"Page Up", 1, true) ~= nil) then
			key = wstring.gsub(key, L"Page Up", L"PGUp")
		end
		
		-- fix the text for "page down"
		if (wstring.find(key , L"Page Dn", 1, true) ~= nil) then
			key = wstring.gsub(key, L"Page Dn", L"PGDn")
		end

		-- fix the text for "escape"
		if (wstring.find(key , L"Escape", 1, true) ~= nil) then
			key = wstring.gsub(key, L"Escape", L"ESC")
		end

		-- any button with a name longer than 4 characters will be cut to 4
		if (wstring.len(key) > 4 and shortKeys) then
			key = wstring.sub(key, 1, 4)
		end
	end

	-- do we have the key2?
	if IsValidWString(key2) then

		-- CTRL
		if (wstring.find(key2 , L"Control", 1, true) ~= nil) then
			color = Interface.Settings.HB_Control
		end
	
		-- ALT
		if (wstring.find(key2 , L"Alt", 1, true) ~= nil) then
			color = Interface.Settings.HB_Alt
		end
	
		-- SHIFT
		if (wstring.find(key2 , L"Shift", 1, true) ~= nil) then
			color = Interface.Settings.HB_Shift
		end
	
		-- CTRL + SHIFT
		if (wstring.find(key2 , L"Shift", 1, true) ~= nil and wstring.find(key2 , L"Control", 1, true) ~= nil) then
			color = Interface.Settings.HB_ControlShift
		end
	
		-- CTRL + ALT
		if (wstring.find(key2 , L"Alt", 1, true) ~= nil and wstring.find(key2 , L"Control", 1, true) ~= nil) then
			color = Interface.Settings.HB_ControlAlt
		end
	
		-- ALT + SHIFT
		if (wstring.find(key2 , L"Alt", 1, true) ~= nil and wstring.find(key2 , L"Shift", 1, true) ~= nil) then
			color = Interface.Settings.HB_AltShift
		end
	
		-- CTRL + ALT + SHIFT
		if (wstring.find(key2 , L"Alt", 1, true) ~= nil and wstring.find(key2 , L"Shift", 1, true) ~= nil and wstring.find(key2 , L"Control", 1, true) ~= nil) then
			color = Interface.Settings.HB_ControlAltShift
		end
	end

	return key, color
end

function WindowUtils.ClearAnchorsWithoutMoving(windowName)

	-- do we have a valid window name?
	if not IsValidString(windowName) or not DoesWindowExist(windowName) then
		return
	end

	-- get the current location on the screen
	local x, y = WindowGetOffsetFromParent(windowName)

	-- clear the gump position (or it will follow the anchored window if moved around)
	WindowClearAnchors(windowName)

	-- move the gump to the same place it was (but without anchors)
	WindowSetOffsetFromParent(windowName, x, y)
end

function WindowUtils.ShowAssignHotkeyInfo(parentWindow)

	-- reset the key info position
	WindowClearAnchors("AssignHotkeyInfo")

	-- anchor the hotkey tooltip near the macro icon
	WindowAddAnchor("AssignHotkeyInfo", "topleft", parentWindow, "bottomleft", 0, -6)

	-- show the hotkey tooltip
	WindowSetShowing("AssignHotkeyInfo", true)
end

-- color a label from white to red given the percentage
function WindowUtils.ScaleTextRedByPerc(label, perc)
	
	-- do we have valid parameters?
	if not DoesWindowExist(label) then
		return
	end

	-- fix the perc value
	if type(perc) ~= "number" then
		perc = 100
	end

	-- calculate the green and blue level
	local gb = math.floor(2.55 * perc)

	-- color the label text
	LabelSetTextColor(label, 255, gb, gb)
end

-- calculate the gradient from red to green given the percentage
function WindowUtils.GetRGBForTooltip(value, cap, reverse)

	-- by default we start the red and gree at 255
	local r = 255
	local g = 255

	-- is the value greater than the cap?, set the value to the cap
	if value > cap then
		value = cap
	end

	-- green near 0, red near cap
	if reverse then

		-- is the value less than half of the cap?
		if value < (cap / 2) then

			-- calculate the green amount
			r = math.floor((value / (cap / 2)) * 255)

		else -- greater than half of the cap

			-- calculate the red amount
			g = math.floor(1 - ((value - (cap / 2)) / (cap / 2)) * 255)
		end

	else -- red near 0, green near cap

		-- is the value less than half of the cap?
		if value < (cap / 2) then

			-- calculate the green amount
			g = math.floor((value / (cap / 2)) * 255)

		else -- greater than half of the cap

			-- calculate the red amount
			r = math.floor(1 - ((value - (cap / 2)) / (cap / 2)) * 255)
		end
	end

	return r, g, 0
end

function WindowUtils.ToggleButton(buttonName, enabled)

	-- do we have to enable the button?
	if enabled then
		WindowUtils.EnableButton(buttonName)

	else -- do we have to disable the button?
		WindowUtils.DisableButton(buttonName)
	end
end

function WindowUtils.DisableButton(buttonName, color)

	-- do we have a valid button?
	if not IsValidString(buttonName) or not DoesWindowExist(buttonName) then
		return
	end

	-- set the button as disabled
	WindowSetAlpha(buttonName, 0.5)

	-- do we have a disabled color?
	if color then

		-- color the button
		WindowSetTintColor(buttonName, color.r, color.g, color.b)
	end

	-- is this a label button?
	if string.find(buttonName, "Label", 1, true) then
		
		-- set the label text color too
		LabelSetTextColor(buttonName, color.r, color.g, color.b)
	end

	-- disable the button input
	WindowSetHandleInput(buttonName, false)
end

function WindowUtils.EnableButton(buttonName)

	-- do we have a valid button?
	if not IsValidString(buttonName) or not DoesWindowExist(buttonName) then
		return
	end

	-- set the button as disabled
	WindowSetAlpha(buttonName, 1)

	-- restore the button color
	WindowSetTintColor(buttonName, 255, 255, 255)

	-- is this a label button?
	if string.find(buttonName, "Label", 1, true) then
		
		-- set the label text color too
		LabelSetTextColor(buttonName, 0, 0, 0)
	end

	-- disable the button input
	WindowSetHandleInput(buttonName, true)
end