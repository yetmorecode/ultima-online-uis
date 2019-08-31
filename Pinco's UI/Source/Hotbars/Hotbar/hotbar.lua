----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

Hotbar = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

Hotbar.NUM_BUTTONS = 12

Hotbar.DarkItemLabel = { r=245,g=229,b=0 }
Hotbar.LightItemLabel = { r=0,g=0,b=0 }

Hotbar.RecordingKey = false
Hotbar.RecordingSlot = 0
Hotbar.RecordingHotbar = 0
Hotbar.JustReleased = {}
Hotbar.ReleaseTimeBeforeUse = 0.5

Hotbar.HANDLE_OFFSET = 20
Hotbar.BUTTON_SIZE = 50

Hotbar.TID_BINDING_CONFLICT_TITLE = 1079169
Hotbar.TID_BINDING_CONFLICT_BODY = 1079170
Hotbar.TID_BINDING_CONFLICT_QUESTION = 1094839
Hotbar.TID_YES = 1049717
Hotbar.TID_NO = 1049718

Hotbar.TID_TARGET = 1079927 -- "Target:"
Hotbar.TID_BINDING = 1079928 -- "Binding:"

Hotbar.TID_HOTBAR = 1079167 -- "Hotbar"
Hotbar.TID_SLOT = 1079168 -- "Slot"

Hotbar.PetControlBar_Shift_X = -17
Hotbar.PetControlBar_ScaleDifference = 0.19

Hotbar.HORIZONTAL_DIRECTION = 1
Hotbar.VERTICAL_DIRECTION = 2

Hotbar.LEFT_TO_RIGHT = 3
Hotbar.RIGHT_TO_LEFT = 4

-- MAXIMIZE

Hotbar.MaximizeButtonTextures = {}
Hotbar.MaximizeButtonTextures[Hotbar.HORIZONTAL_DIRECTION] ={}
Hotbar.MaximizeButtonTextures[Hotbar.HORIZONTAL_DIRECTION][Hotbar.RIGHT_TO_LEFT] ={}
Hotbar.MaximizeButtonTextures[Hotbar.HORIZONTAL_DIRECTION][Hotbar.RIGHT_TO_LEFT][InterfaceCore.ButtonStates.STATE_NORMAL] =					{texture="ExtractLeft",		x=24,	y=0}
Hotbar.MaximizeButtonTextures[Hotbar.HORIZONTAL_DIRECTION][Hotbar.RIGHT_TO_LEFT][InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE] =		{texture="ExtractLeft",		x=0,	y=0}
Hotbar.MaximizeButtonTextures[Hotbar.HORIZONTAL_DIRECTION][Hotbar.RIGHT_TO_LEFT][InterfaceCore.ButtonStates.STATE_PRESSED] =				{texture="ExtractLeft",		x=0,	y=0}
Hotbar.MaximizeButtonTextures[Hotbar.HORIZONTAL_DIRECTION][Hotbar.RIGHT_TO_LEFT][InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE] =		{texture="ExtractLeft",		x=0,	y=0}

Hotbar.MaximizeButtonTextures[Hotbar.HORIZONTAL_DIRECTION][Hotbar.LEFT_TO_RIGHT] ={}
Hotbar.MaximizeButtonTextures[Hotbar.HORIZONTAL_DIRECTION][Hotbar.LEFT_TO_RIGHT][InterfaceCore.ButtonStates.STATE_NORMAL] =					{texture="ExtractRight",	x=0,	y=0}
Hotbar.MaximizeButtonTextures[Hotbar.HORIZONTAL_DIRECTION][Hotbar.LEFT_TO_RIGHT][InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE] =		{texture="ExtractRight",	x=24,	y=0}
Hotbar.MaximizeButtonTextures[Hotbar.HORIZONTAL_DIRECTION][Hotbar.LEFT_TO_RIGHT][InterfaceCore.ButtonStates.STATE_PRESSED] =				{texture="ExtractRight",	x=24,	y=0}
Hotbar.MaximizeButtonTextures[Hotbar.HORIZONTAL_DIRECTION][Hotbar.LEFT_TO_RIGHT][InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE] =		{texture="ExtractRight",	x=24,	y=0}

Hotbar.MaximizeButtonTextures[Hotbar.VERTICAL_DIRECTION] ={}
Hotbar.MaximizeButtonTextures[Hotbar.VERTICAL_DIRECTION][Hotbar.RIGHT_TO_LEFT] ={} -- up to down
Hotbar.MaximizeButtonTextures[Hotbar.VERTICAL_DIRECTION][Hotbar.RIGHT_TO_LEFT][InterfaceCore.ButtonStates.STATE_NORMAL] =					{texture="updown",			x=27,	y=0}
Hotbar.MaximizeButtonTextures[Hotbar.VERTICAL_DIRECTION][Hotbar.RIGHT_TO_LEFT][InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE] =			{texture="updown",			x=3,	y=2}
Hotbar.MaximizeButtonTextures[Hotbar.VERTICAL_DIRECTION][Hotbar.RIGHT_TO_LEFT][InterfaceCore.ButtonStates.STATE_PRESSED] =					{texture="updown",			x=3,	y=2}
Hotbar.MaximizeButtonTextures[Hotbar.VERTICAL_DIRECTION][Hotbar.RIGHT_TO_LEFT][InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE] =			{texture="updown",			x=3,	y=2}

Hotbar.MaximizeButtonTextures[Hotbar.VERTICAL_DIRECTION][Hotbar.LEFT_TO_RIGHT] ={} -- down to up
Hotbar.MaximizeButtonTextures[Hotbar.VERTICAL_DIRECTION][Hotbar.LEFT_TO_RIGHT][InterfaceCore.ButtonStates.STATE_NORMAL] =					{texture="updown",			x=50,	y=1}
Hotbar.MaximizeButtonTextures[Hotbar.VERTICAL_DIRECTION][Hotbar.LEFT_TO_RIGHT][InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE] =			{texture="updown",			x=76,	y=0}
Hotbar.MaximizeButtonTextures[Hotbar.VERTICAL_DIRECTION][Hotbar.LEFT_TO_RIGHT][InterfaceCore.ButtonStates.STATE_PRESSED] =					{texture="updown",			x=76,	y=0}
Hotbar.MaximizeButtonTextures[Hotbar.VERTICAL_DIRECTION][Hotbar.LEFT_TO_RIGHT][InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE] =			{texture="updown",			x=76,	y=0}

-- minimize

Hotbar.MinimizeButtonTextures = {}
Hotbar.MinimizeButtonTextures[Hotbar.HORIZONTAL_DIRECTION] ={}
Hotbar.MinimizeButtonTextures[Hotbar.HORIZONTAL_DIRECTION][Hotbar.RIGHT_TO_LEFT] ={}
Hotbar.MinimizeButtonTextures[Hotbar.HORIZONTAL_DIRECTION][Hotbar.RIGHT_TO_LEFT][InterfaceCore.ButtonStates.STATE_NORMAL] =					{texture="ExtractRight",	x=0,	y=0}
Hotbar.MinimizeButtonTextures[Hotbar.HORIZONTAL_DIRECTION][Hotbar.RIGHT_TO_LEFT][InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE] =		{texture="ExtractRight",	x=24,	y=0}
Hotbar.MinimizeButtonTextures[Hotbar.HORIZONTAL_DIRECTION][Hotbar.RIGHT_TO_LEFT][InterfaceCore.ButtonStates.STATE_PRESSED] =				{texture="ExtractRight",	x=24,	y=0}
Hotbar.MinimizeButtonTextures[Hotbar.HORIZONTAL_DIRECTION][Hotbar.RIGHT_TO_LEFT][InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE] =		{texture="ExtractRight",	x=24,	y=0}

Hotbar.MinimizeButtonTextures[Hotbar.HORIZONTAL_DIRECTION][Hotbar.LEFT_TO_RIGHT] ={}
Hotbar.MinimizeButtonTextures[Hotbar.HORIZONTAL_DIRECTION][Hotbar.LEFT_TO_RIGHT][InterfaceCore.ButtonStates.STATE_NORMAL] =					{texture="ExtractLeft",		x=24,	y=0}
Hotbar.MinimizeButtonTextures[Hotbar.HORIZONTAL_DIRECTION][Hotbar.LEFT_TO_RIGHT][InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE] =		{texture="ExtractLeft",		x=0,	y=0}
Hotbar.MinimizeButtonTextures[Hotbar.HORIZONTAL_DIRECTION][Hotbar.LEFT_TO_RIGHT][InterfaceCore.ButtonStates.STATE_PRESSED] =				{texture="ExtractLeft",		x=0,	y=0}
Hotbar.MinimizeButtonTextures[Hotbar.HORIZONTAL_DIRECTION][Hotbar.LEFT_TO_RIGHT][InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE] =		{texture="ExtractLeft",		x=0,	y=0}

Hotbar.MinimizeButtonTextures[Hotbar.VERTICAL_DIRECTION] ={}
Hotbar.MinimizeButtonTextures[Hotbar.VERTICAL_DIRECTION][Hotbar.RIGHT_TO_LEFT] ={} -- up to down
Hotbar.MinimizeButtonTextures[Hotbar.VERTICAL_DIRECTION][Hotbar.RIGHT_TO_LEFT][InterfaceCore.ButtonStates.STATE_NORMAL] =					{texture="updown",			x=50,	y=1}
Hotbar.MinimizeButtonTextures[Hotbar.VERTICAL_DIRECTION][Hotbar.RIGHT_TO_LEFT][InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE] =			{texture="updown",			x=76,	y=0}
Hotbar.MinimizeButtonTextures[Hotbar.VERTICAL_DIRECTION][Hotbar.RIGHT_TO_LEFT][InterfaceCore.ButtonStates.STATE_PRESSED] =					{texture="updown",			x=76,	y=0}
Hotbar.MinimizeButtonTextures[Hotbar.VERTICAL_DIRECTION][Hotbar.RIGHT_TO_LEFT][InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE] =			{texture="updown",			x=76,	y=0}

Hotbar.MinimizeButtonTextures[Hotbar.VERTICAL_DIRECTION][Hotbar.LEFT_TO_RIGHT] ={} -- down to up
Hotbar.MinimizeButtonTextures[Hotbar.VERTICAL_DIRECTION][Hotbar.LEFT_TO_RIGHT][InterfaceCore.ButtonStates.STATE_NORMAL] =					{texture="updown",			x=27,	y=0}
Hotbar.MinimizeButtonTextures[Hotbar.VERTICAL_DIRECTION][Hotbar.LEFT_TO_RIGHT][InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE] =			{texture="updown",			x=3,	y=2}
Hotbar.MinimizeButtonTextures[Hotbar.VERTICAL_DIRECTION][Hotbar.LEFT_TO_RIGHT][InterfaceCore.ButtonStates.STATE_PRESSED] =					{texture="updown",			x=3,	y=2}
Hotbar.MinimizeButtonTextures[Hotbar.VERTICAL_DIRECTION][Hotbar.LEFT_TO_RIGHT][InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE] =			{texture="updown",			x=3,	y=2}

----------------------------------------------------------------
-- MainMenuWindow Functions
----------------------------------------------------------------

-- this function load the saved hotbar item
function Hotbar.SetHotbarItem(hotbarId, slot)

	-- make sure the hotbar and slot exist
	if not Hotbar.DoesHotbarExist(hotbarId, true) and IsValidID(slot) then
		return
	end

	-- make sure the hotbar really has something in this slot
	if (HotbarHasItem(hotbarId, slot) == false) then
		return
	end
	
	-- loading the hotbar item
	local element = "Hotbar"..hotbarId.."Button"..slot	
	HotbarSystem.RegisterAction(element, hotbarId, slot, 0)
end

function Hotbar.ClearHotbarItem(hotbarId, slot, shutdown)

	-- make sure the hotbar and slot exist
	if not Hotbar.DoesHotbarExist(hotbarId, true) and IsValidID(slot) then
		return
	end

	-- clearing the slot
	local element = "Hotbar"..hotbarId.."Button"..slot

	-- does this slot had a target mouse over?
	if HotbarSystem.TargetMouseOver and not shutdown then
		HotbarSystem.TargetMouseOver[element] = nil
	end

	-- reset the timer text
	LabelSetText(element.."BandageTime", L"")

	HotbarSystem.ClearActionIcon(element, hotbarId, slot, 0, shutdown)
end

function Hotbar.ReloadHotbar(hotbarId)

	-- make sure the hotbar exist
	if not Hotbar.DoesHotbarExist(hotbarId, true) then
		return
	end

	-- hotbar window name
	local hotbar = "Hotbar"..hotbarId
	
	-- loading the slots
	for slot = 1, Hotbar.NUM_BUTTONS do	

		-- setting the action inside the slot
		Hotbar.SetHotbarItem(hotbarId,slot)

		-- restoring the icon scale proportional on the slot scale
		local element = hotbar.."Button"..slot
		local elementIcon = element.."SquareIcon"
		local scale = WindowGetScale(element)
		WindowSetScale(elementIcon, scale - (0.12 * scale))
	end

	-- is this a blockbar?
	local isBlockbar = Interface.LoadSetting(hotbar .. "_IsBlockbar", false)

	-- blockbars have a different initialization
	if isBlockbar then
		pcall(Hotbar.InitializeBlockbar, hotbarId)

	else
		-- loading the custom text
		pcall(Hotbar.HotbarLoadCustomText, hotbarId)

		pcall(Hotbar.OnResizeEnd, hotbar)
		
		-- is the hotbar shrinked? (we don't check for transparency)
		if Hotbar.IsShrunken(hotbarId, true) then
			Hotbar.Shrink(hotbar, true)
		end

		-- pet control bar has different settings
		if Interface.PetControlsBar == WindowGetId(hotbar) then
			pcall(Hotbar.InitializePetControlBar)
		end
	end
	
	-- initialize fading
	Hotbar.HideBar(hotbar)
end

function Hotbar.InitializeBlockbar(hotbarId)

	-- make sure the hotbar exist
	if not Hotbar.DoesHotbarExist(hotbarId, true) then
		return
	end

	-- hotbar window name
	local hotbar = "Hotbar"..hotbarId

	-- hiding all the butons except the first one
	for slot=2, Hotbar.NUM_BUTTONS do
		local button = hotbar.."Button"..slot
		WindowSetShowing(button, false)
	end

	-- making sure that the blockbar is still a 1x1 hotbar
	WindowSetDimensions(hotbar, Hotbar.BUTTON_SIZE, Hotbar.BUTTON_SIZE)

	-- hiding most of the basic elements
	pcall(Hotbar.FixHotbarOrientationItems, hotbarId)
end

function Hotbar.InitializePetControlBar()
	
	-- make sure the hotbar exist
	if not Hotbar.DoesHotbarExist(Interface.PetControlsBar, true) then
		return
	end

	-- pet control bar window name
	local hotbar = "Hotbar" .. Interface.PetControlsBar

	-- hiding maximize, minimize and handles (not needed for this bar)
	WindowSetShowing(hotbar .. "MinimizeButtonH", false)
	WindowSetShowing(hotbar .. "MaximizeButtonH", false)
	WindowSetShowing(hotbar .. "HorizHandle", false)
	WindowSetShowing(hotbar .. "VertHandle", false)

	-- making sure that the blockbar is still a 1x5 hotbar
	WindowSetDimensions(hotbar, Hotbar.BUTTON_SIZE * 5, Hotbar.BUTTON_SIZE )

	-- get the pets window name
	local _, petWindow = MobileBarsDockspot.GetPetDockspotStatus()

	-- get the pet window scale
	local petWindowScale = WindowGetScale(petWindow)

	-- get the pet controls bar scale
	local petControlsScale = WindowGetScale(hotbar)

	-- make sure the pet controls bar and the pet window have the same scale
	if petControlsScale ~= petWindowScale + Hotbar.PetControlBar_ScaleDifference then

		-- scale the pet controls bar
		WindowSetScale(hotbar, petWindowScale - Hotbar.PetControlBar_ScaleDifference)
	end

	-- initialize the anchors to the pet bar (the timer will keep it locked there)
	WindowClearAnchors(hotbar)

	-- does the pet bar closes left?
	if MobileBarsDockspot.Dockspots[petWindow].closeLeft then

		-- anchor to the right
		WindowAddAnchor(hotbar, "right", petWindow, "left", Hotbar.PetControlBar_Shift_X, 1)

	else -- if it closes right, we anchor to the left
		WindowAddAnchor(hotbar, "left", petWindow, "right", Hotbar.PetControlBar_Shift_X, 1)
	end
end

function Hotbar.SetLocked(hotbarId, locked)
	
	-- make sure the hotbar exist
	if not Hotbar.DoesHotbarExist(hotbarId, true) then
		return
	end

	-- current hotbar window
	local curWindow = "Hotbar"..hotbarId

	-- changing the flag
	SystemData.Hotbar[hotbarId].Locked = locked

	-- updating the graphics
	Hotbar.OnResizeEnd(curWindow)
end

function Hotbar.UseSlot(hotbarId, slot)

	-- make sure the hotbar exist and the slot is valid
	if not Hotbar.DoesHotbarExist(hotbarId, true) or not IsValidID(slot) then
		return
	end

	-- current hotbar window name
	local hotbar = "Hotbar" .. hotbarId
	
	-- is the snap process over?
	if SnapUtils.SnapWindow == hotbar or WindowGetMoving(hotbar) then
		return
	end

	-- is this hotbar just being released from dragging?
	if Hotbar.JustReleased[hotbar] and Hotbar.JustReleased[hotbar].timer < Hotbar.ReleaseTimeBeforeUse then
		return
	end

	-- is there something to use in the slot?
	if (HotbarHasItem(hotbarId, slot)) then
		HotbarExecuteItem(hotbarId, slot)
		--Debug.Print(HotbarSystem.RegisteredObjects["Hotbar"..hotbarId.."Button"..itemIndex])
	end
end

-- OnInitialize Handler
function Hotbar.Initialize()
	
	-- current window name
	local this = SystemData.ActiveWindow.name

	-- get the hotbar id
	local hotbarId = SystemData.DynamicWindowId
	
	-- make sure the hotbar exist and the id is correct
	if not Hotbar.DoesHotbarExist(hotbarId, true) then
		return
	end

	-- enabling window snap
	SnapUtils.SnappableWindows[this] = true
	
	-- assign the id
	WindowSetId(this, hotbarId)
		
	-- updating the lock status
	Hotbar.SetLocked(hotbarId, SystemData.Hotbar[hotbarId].Locked)
	
	for slot = 1, Hotbar.NUM_BUTTONS do
		
		-- slot window name
		local element = this.."Button"..slot

		-- long text binding
		local key = SystemData.Hotbar[hotbarId].BindingDisplayStrings[slot]

		-- short text binding
		local key2 = SystemData.Hotbar[hotbarId].Bindings[slot]

		-- updating the hotbar keybinding text and colors
		HotbarSystem.UpdateBinding(element, key, key2)
	   
		-- clearing the slot
		Hotbar.ClearHotbarItem(hotbarId, slot, true)
	end	
	
	-- loading the hotbar basics arts and settings
	Hotbar.ReloadHotbar(hotbarId)
	
	-- mounts blockbar can only be seen inside the mounts list window
	if Interface.MountBlockbar and this == "Hotbar" .. Interface.MountBlockbar then
		WindowSetShowing(this, false)
	end

	-- loading hotbar position and scale
	WindowUtils.RestoreWindowPosition(this, true)	
	WindowUtils.LoadScale( this )
end

-- OnShutdown Handler
function Hotbar.Shutdown()
	--Debug.Print("Hotbar.Shutdown")
	
	-- current window name
	local this = SystemData.ActiveWindow.name

	-- get hotbar id
	local hotbarId = WindowGetId(this)
	
	-- disabling window snap
	SnapUtils.SnappableWindows[this] = nil
	
	-- removing all actions from slots
	for slot = 1, Hotbar.NUM_BUTTONS do
		Hotbar.ClearHotbarItem(hotbarId, slot, true)
	end
	
	-- clearing item properties if the cursor is over this hotbar
	if (ItemProperties.GetCurrentWindow() == "Hotbar"..hotbarId) then
		ItemProperties.ClearMouseOverItem()
	end
	
	-- if is not closed we also save the dimensions
	if not Hotbar.IsShrunken(hotbarId, true) then
		local width, height = WindowGetDimensions(this)
		Interface.SaveSetting( this .. "SizeW", width )
		Interface.SaveSetting( this .. "SizeH", height )
	end

	-- saving the window position
	WindowUtils.SaveWindowPosition(this, true)
end

-- this function finds all the hotbars near the one we specify so we can move an entire group of them.
-- it uses the same principles used for the snapping
function Hotbar.FindHotbarMovingBlock(CurWindow)

	-- setting the scan range for the window
	local anchorPositions = SnapUtils.ComputeAnchorScreenPositions(CurWindow)

	-- now we scan all the snappable windows if any of them are in range
	for windowName, _ in pairs(SnapUtils.SnappableWindows) do

		-- we ignore the current window (obv), windows that we have already found, and windows that are already moving. We must also be sure it's another hotbar.
		if (windowName ~= CurWindow and string.find(windowName, "Hotbar", 1, true) and not Hotbar.InMovement[windowName] and not WindowGetMoving(windowName)) then     
			
			-- get the hotbar ID
			local hotbarId = WindowGetId(windowName)

			-- is this the pet controls bar?
			local petControlsBar = Interface.PetControlsBar == hotbarId

			-- is this the mount blockbar?
			local mountBlockbar = Interface.MountBlockbar == hotbarId

			-- this 2 bars cannot be moved
			if petControlsBar or mountBlockbar then
				continue
			end

			-- setting the scanning range for the other window
			local comparePositions = SnapUtils.ComputeAnchorScreenPositions(windowName)            
            
			-- now we must make sure the 2 windows are actually in range
			for index, snapPair in pairsByIndex(SnapUtils.SNAP_PAIRS) do
				
				-- calculating distance
				local dist = SnapUtils.GetAnchorDistance( anchorPositions, snapPair[1], comparePositions, snapPair[2] )
               
				-- if the range is confirmed, we can add the window to the movement block and search for more.
				if ((dist <= 5) and (dist < 6) and WindowGetShowing(windowName)) then
					WindowSetMoving(windowName, true)
					Hotbar.InMovement[windowName] = true
					Hotbar.FindHotbarMovingBlock(windowName)

					-- add the release timer for the hotbar
					Hotbar.JustReleased[windowName] = {}
					Hotbar.JustReleased[windowName].timer = 0
				end
		   end
		end
	end
end

-- this function finds all the hotbars near the one we specify so we can shrink an entire group of them.
-- it uses the same principles used for the snapping
function Hotbar.FindHotbarShrinkBlock(CurWindow)
	
	-- setting the scan range for the window
	local anchorPositions = SnapUtils.ComputeAnchorScreenPositions(CurWindow)

	-- now we scan all the snappable windows if any of them are in range
	for windowName, _ in pairs(SnapUtils.SnappableWindows) do

		-- get the hotbar ID
		local hotbarId = WindowGetId(windowName)

		-- we ignore the current window (obv), windows that we have already found, and windows that are already shrinked. We must also be sure it's another hotbar.
		if (windowName ~= CurWindow and string.find(windowName, "Hotbar", 1, true) and not Hotbar.IsShrunken(hotbarId, false)) then          
			
			-- is this the pet controls bar?
			local petControlsBar = Interface.PetControlsBar == hotbarId

			-- is this a blockbar?
			local isBlockbar = Interface.LoadSetting( windowName .. "_IsBlockbar", false)

			-- pet controls bar and blockbars cannot be shrinked
			if petControlsBar or isBlockbar then
				continue
			end

			-- setting the scanning range for the other window
			local comparePositions = SnapUtils.ComputeAnchorScreenPositions(windowName)            
            
			-- now we must make sure the 2 windows are actually in range
			for index, snapPair in pairsByIndex(SnapUtils.SNAP_PAIRS) do

				-- calculating distance
				local dist = SnapUtils.GetAnchorDistance( anchorPositions, snapPair[1], comparePositions, snapPair[2] )
               
				-- if the range is confirmed, we can add the window to the shrink block and search for more.
				if ((dist <= 5) and (dist < 6) and WindowGetShowing(windowName)) then
					Hotbar.Shrink(windowName)
					Hotbar.FindHotbarShrinkBlock(windowName)
				end
		   end
		end
	end
end

-- this function finds all the hotbars near the one we specify so we can enlarge an entire group of them.
-- it uses the same principles used for the snapping
function Hotbar.FindHotbarEnlargeBlock(CurWindow)
	
	-- setting the scan range for the window
	local anchorPositions = SnapUtils.ComputeAnchorScreenPositions(CurWindow)

	-- now we scan all the snappable windows if any of them are in range
	for windowName, _ in pairs(SnapUtils.SnappableWindows) do

		-- get the hotbar ID
		local hotbarId = WindowGetId(windowName)

		-- we ignore the current window (obv), windows that we have already found, and windows that are already enlarged. We must also be sure it's another hotbar.
		if (windowName ~= CurWindow and string.find(windowName, "Hotbar", 1, true) and Hotbar.IsShrunken(hotbarId, false)) then        
		
			-- is this the pet controls bar?
			local petControlsBar = Interface.PetControlsBar == hotbarId

			-- is this a blockbar?
			local isBlockbar = Interface.LoadSetting( windowName .. "_IsBlockbar", false)

			-- pet controls bar and blockbars cannot be enlarged
			if petControlsBar or isBlockbar then
				continue
			end

			-- setting the scanning range for the other window
			local comparePositions = SnapUtils.ComputeAnchorScreenPositions(windowName)            
            
			-- now we must make sure the 2 windows are actually in range
			for index, snapPair in pairsByIndex(SnapUtils.SNAP_PAIRS) do

				-- calculating distance
				local dist = SnapUtils.GetAnchorDistance( anchorPositions, snapPair[1], comparePositions, snapPair[2] )
               
				-- if the range is confirmed, we can add the window to the enlarge block and search for more.
				if ((dist <= 5) and (dist < 6) and WindowGetShowing(windowName)) then
					Hotbar.Enlarge(windowName)
					Hotbar.FindHotbarEnlargeBlock(windowName)
				end
		   end
		end
	end
end

-- this function search and return a group of hotbars
-- it uses the same principles used for the snapping
function Hotbar.FindHotbarGroup(CurWindow, group)

	-- if it's the first recursion we initialize the group array
	if not group then
		group = {}
	end

	-- count variable for the current recursion
	local count = 0

	-- setting the scan range for the window
	local anchorPositions = SnapUtils.ComputeAnchorScreenPositions(CurWindow)

	-- now we scan all the snappable windows if any of them are in range
	for windowName, _ in pairs(SnapUtils.SnappableWindows) do

		-- we ignore the current window (obv), windows that we have already found. We must also be sure it's another hotbar.
		if (windowName ~= CurWindow and string.find(windowName, "Hotbar", 1, true) and not group[windowName]) then   
			
			-- get the hotbar ID
			local hotbarId = WindowGetId(windowName)

			-- is this the pet controls bar?
			local petControlsBar = Interface.PetControlsBar == hotbarId

			-- is this the mount blockbar?
			local mountBlockbar = Interface.MountBlockbar == hotbarId

			-- useless to make this 2 bars parts of a group since they can't be treated as normal hotbars
			if petControlsBar or mountBlockbar then
				continue
			end

			-- setting the scanning range for the other window
			local comparePositions = SnapUtils.ComputeAnchorScreenPositions(windowName)            
            
			-- now we must make sure the 2 windows are actually in range
			for index, snapPair in pairsByIndex(SnapUtils.SNAP_PAIRS) do

				-- calculating distance
				local dist = SnapUtils.GetAnchorDistance( anchorPositions, snapPair[1], comparePositions, snapPair[2] )
               
				-- if the range is confirmed, we can add the window to the group and search for more.
				if ((dist <= 5) and (dist < 6) and WindowGetShowing(windowName)) then
					group[windowName] = true
					group = Hotbar.FindHotbarGroup(windowName, group)
				end
		   end
		end
	end

	-- counting the elements of the group
	for _, _ in pairs(group) do
		count = count + 1
	end

	return group, count
end

-- OnLButtonDown Handler
function Hotbar.ItemLButtonDown(flags)

	-- window elements ids
	local slot = WindowGetId(SystemData.ActiveWindow.name)
	local hotbarId = WindowGetId(WindowUtils.GetActiveDialog())

	-- hotbar window name
	local hotbar = "Hotbar"..hotbarId

	-- make sure the hotbar exist and the ids are valids
	if not Hotbar.DoesHotbarExist(hotbarId, true) or not IsValidID(slot) then
		return
	end
		
	-- window moving management (excluding pet controls bar and mount blockbar)
	if hotbarId ~= Interface.PetControlsBar and hotbarId ~= Interface.MountBlockbar then

		-- pressing CTRL and drag, allows to move an hotbar (like you do by the handle), but it works even when it's locked
		if flags == WindowUtils.ButtonFlags.CONTROL then
			WindowSetMoving(hotbar, true)
			SnapUtils.StartWindowSnap(hotbar)

			-- add the release timer for the hotbar
			Hotbar.JustReleased[hotbar] = {}
			Hotbar.JustReleased[hotbar].timer = 0

			return -- job done here
		end

		-- pressing ALT and drag, allows to move the hotbar and the all the nearest hotbars without snapping. It works even when it's locked
		if flags == WindowUtils.ButtonFlags.ALT and not WindowGetMoving(hotbar) then
			Hotbar.InMovement = {}
			Hotbar.FindHotbarMovingBlock(hotbar)
			WindowSetMoving(hotbar, true)

			-- add the release timer for the hotbar
			Hotbar.JustReleased[hotbar] = {}
			Hotbar.JustReleased[hotbar].timer = 0
			
			return -- job done here
		end
	end
	
	-- is this a blockbar?
	local isBlockbar = Interface.LoadSetting(hotbar .. "_IsBlockbar", false)

	-- pressing SHIFT and drag, allows to move the action out of the slot.
	if flags == WindowUtils.ButtonFlags.SHIFT then

		-- is there something inside the slot and is not a blockbar? (Blockbars don't allow to move stuff out.)
		if HotbarHasItem(hotbarId, slot) and not isBlockbar then

			-- getting the current slot action type
			local actionType = UserActionGetType(hotbarId, slot, 0)

			-- start dragging the content of the slot
			DragSlotSetExistingActionMouseClickData(hotbarId, slot, 0)

			-- if it's an action we update the actions list icons (so if it's unique it will be disabled)
			if ActionsWindow.isAction(actionType) then
				
				-- We do it in 0.5 seconds to be sure it works properly
				Interface.AddTodoList({name = "Update Action Icons", func = function() ActionsWindow.UpdateIcons() end, time = Interface.TimeSinceLogin + 0.5})
			end
		
			-- update the keybindings
			Interface.AddTodoList({name = "hotbar delayed keybinding text update", func = function() HotbarSystem.HandleUpdatehotbarsKeybinding() end, time = Interface.TimeSinceLogin + 0.2})

			return -- job done here

		-- is this a blockbar?
		elseif isBlockbar then

			-- set the blockbar in movement
			WindowSetMoving(hotbar, true)

			-- forcing the blockbar to follow the mouse cursor (without snapping)
			WindowUtils.FollowMouseCursor(hotbar, Hotbar.BUTTON_SIZE, Hotbar.BUTTON_SIZE, -30, -15, false, true, false)

			-- add the release timer for the hotbar
			Hotbar.JustReleased[hotbar] = {}
			Hotbar.JustReleased[hotbar].timer = 0
		end
	end

	-- is there something in the slot? and it's enabled?
	if HotbarHasItem(hotbarId, slot) and Hotbar.IsSlotEnabled(hotbarId, slot) then

		-- managing cursor target on hotbar slot (items only).
		-- we need to make sure there is an item in the slot and that we have the target cursor active to enter.
		if DoesPlayerHasCursorTarget() then
		
			-- initializing item id variable
			local objID

			-- getting the current slot action type
			local actionType = UserActionGetType(hotbarId, slot, 0)

			-- getting the current slot action id
			local actionId = UserActionGetId(hotbarId, slot, 0)

			-- single item (non-stackable). actionId is the item id.
			if actionType == SystemData.UserAction.TYPE_USE_ITEM then
				objID = actionId
			
			-- stackable item. actionId is the item type
			elseif actionType == SystemData.UserAction.TYPE_USE_OBJECTTYPE then

				-- getting the first item id for the object type
				objID = UserActionGetNextObjectId(actionId)
			end

			-- verify the item id is valid
			if IsValidID(objID) then

				-- targeting the item
				HandleSingleLeftClkTarget(objID)

				return -- job done here
			end
		end
	end
end

-- OnLButtonUP Handler
function Hotbar.ItemLButtonUp(flags)
	
	-- window elements ids
	local hotbarId = WindowGetId(WindowUtils.GetActiveDialog())
	local slot = WindowGetId(SystemData.ActiveWindow.name)
	local subIndex = 0 -- default value for non-macros

	-- make sure the hotbar exist and the ids are valids
	if not Hotbar.DoesHotbarExist(hotbarId, true) or not IsValidID(slot) then
		return
	end

	-- hotbar window name
	local hotbar = "Hotbar"..hotbarId
	
	-- if there is a group of hotbars moving, we must stop it
	if Hotbar.InMovement ~= nil then
		for windowName,_ in pairs(Hotbar.InMovement) do
			WindowSetMoving(windowName, false)
			Hotbar.InMovement[windowName] = nil
		end
	end
	
	-- is the hotbar in movement?
	if WindowGetMoving(hotbar) then
		
		-- we stop this hotbar here
		WindowSetMoving(hotbar, false)

		return -- job is done
	end
	
	-- is this hotbar just being released from dragging?
	if Hotbar.JustReleased[hotbar] and Hotbar.JustReleased[hotbar].timer < Hotbar.ReleaseTimeBeforeUse then
		return
	end

	-- since the flags are used for many stuff, better to get out and avoid problems
	if flags ~= WindowUtils.ButtonFlags.NONE and flags ~= WindowUtils.ButtonFlags.SHIFT then
		return
	end
	
	-- are we dragging something?
	if (SystemData.DragItem.DragType ~= SystemData.DragItem.TYPE_NONE) then
				
		-- nothing can be dropped in a blockbar
		if Interface.LoadSetting(hotbar.. "_IsBlockbar", false) then
			return
		end

		-- the action/item dropped is a duplicate?
		local _, itemIsDuplicate = pcall(Hotbar.HandleCheckDuplicates, { hotbarId, slot })
		if itemIsDuplicate then	
			return
		end

		-- store the dragged object type before dropping it
		local dragType = SystemData.DragItem.DragType

		-- is this a pet summoning ball (from another hotbar slot)?
		if SystemData.DragItem.actionIconId == Actions.PetBallType then
			dragType = SystemData.DragItem.TYPE_ITEM
		end

		-- store the dragged item ID (if we have one)
		local dragId = inlineIf(SystemData.DragItem.itemId ~= 0, SystemData.DragItem.itemId, SystemData.DragItem.actionId)

		-- item dropped on an item in the current slot?
		local _, itemDropped = pcall(Hotbar.HandleDropOnItem, { hotbarId, slot, dragType, dragId })
		if itemDropped then	
			return
		end

		-- now that all the exceptions are excluded we can finally drop the action in the slot
		local dropSuccess = DragSlotDropAction(hotbarId, slot, subIndex)

		-- check and fix the hotbar slot if it's a pet ball
		pcall(Hotbar.PetBallFix, { hotbarId, slot, dragType, dragId })

		-- all gone well?
		if (dropSuccess) then
			
			-- clear existing hotbar slot and unregister the item
			Hotbar.ClearHotbarItem(hotbarId, slot)	 
			
			-- hotbar slot window name
			local element = hotbar.."Button"..slot
				  
			-- get the new action type for this item
			local actionType = UserActionGetType(hotbarId, slot, subIndex)	
		
			-- get the new action ID for this item
			local actionId = UserActionGetId(hotbarId, slot, subIndex)
			
			-- get the action data for the current action (if available)
			local actionData = ActionsWindow.ActionData[actionId]
					
			-- unbinding the key on the slot for actions that already have a key binded through user settings
			if	actionType == SystemData.UserAction.TYPE_WEAPON_ABILITY or 
				HotbarSystem.IsHotbarMacro(actionType) or
				( ActionsWindow.isAction(actionType) and actionData and actionData.settingKeyBinding)
			then
				SystemData.Hotbar[hotbarId].Bindings[slot] = L""
				SystemData.Hotbar[hotbarId].BindingDisplayStrings[slot] = L""
				BroadcastEvent(SystemData.Events.KEYBINDINGS_UPDATED)

				-- updating the binding text and colors
				HotbarSystem.UpdateBinding(element, L"", L"")
			end

			-- showing the action in the hotbar
			Hotbar.SetHotbarItem(hotbarId, slot)

			-- does this action requires a target?
			if UserActionHasTargetType(hotbarId, slot, subIndex) then
			
				-- we set the target cursor by default, if is a spell or a skill without target, we'll handle it when the player will try to set one (because he won't be able to do it)
				UserActionSetTargetType(hotbarId, slot, subIndex, SystemData.Hotbar.TargetType.TARGETTYPE_CURSOR)

				-- updating the target art (here we check for the exceptions)
				HotbarSystem.UpdateTargetTypeIndicator(element, hotbarId, slot, subIndex)
			end

			-- does this action requires to open an edit window?
			local _, openEdit = pcall(ActionsWindow.InitializeActionSlotCallback, {actionId, actionType, element, hotbarId, slot, subIndex})

			-- if it does we open the edit window
			if openEdit then
				ActionEditWindow.OpenEditWindow(actionId, actionType, element, hotbarId, slot, subIndex)
			end

			-- update the keybindings
			HotbarSystem.HandleUpdatehotbarsKeybinding()
			
			-- if it's an action we update the actions list icons (so if it's unique it will be disabled)
			if ActionsWindow.isAction(actionType) then

				-- We do it in 0.5 seconds to be sure it works properly
				Interface.AddTodoList({name = "Update Action Icons", func = function() ActionsWindow.UpdateIcons() end, time = Interface.TimeSinceLogin + 0.5})
			end
		end

	else -- not dragging? use the slot
		Hotbar.UseSlot(hotbarId, slot)
	end
end

function Hotbar.HandleCheckDuplicates(params)

	-- acquiring the ids from the params array
	local hotbarId = params[1]
	local slot = params[2]

	-- make sure the hotbar exist and the ids are valids
	if not Hotbar.DoesHotbarExist(hotbarId, true) or not IsValidID(slot) then
		return false
	end

	-- are we dragging an item?
	if (SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM) then
			
		-- the ID of the item we are dragging
		local dragId = SystemData.DragItem.itemId

		-- is this specific item (or item type if is a stackable) already in any hotbar slot? (it pefroms also an hue check...)
		local alreadyInBar, existingSlot = HotbarSystem.ActionAlreadyInHotbar(dragId, "item", {type = SystemData.DragItem.itemType, hue = SystemData.DragItem.itemHueId} )

		-- if we have the item in another slot, then we must prevent a duplicate
		if alreadyInBar then
			ChatPrint(GetStringFromTid(285), SystemData.ChatLogFilters.SYSTEM)
			
			-- make the slot glow to highlight the duplicate
			HotbarSystem.GlowSlotWarning(existingSlot, 5, dragId)

			return true-- job is done
		end

	else -- we are dragging an action/spell or something that is not an item
			
		-- getting the action ID
		local dragId = SystemData.DragItem.actionId

		-- macros, weapons abilities, player stats and racials can only exist once in the hotbars
		if	HotbarSystem.IsHotbarMacro(SystemData.DragItem.actionType) or
			SystemData.DragItem.actionType == SystemData.UserAction.TYPE_WEAPON_ABILITY or
			SystemData.DragItem.actionType == SystemData.UserAction.TYPE_PLAYER_STATS or
			SystemData.DragItem.actionType == SystemData.UserAction.TYPE_RACIAL_ABILITY or
			SystemData.DragItem.actionType == SystemData.UserAction.TYPE_INVOKE_VIRTUE
		then

			-- is this specific action already in any hotbar slot?
			local alreadyInBar, existingSlot = HotbarSystem.ActionAlreadyInHotbar(dragId, SystemData.DragItem.actionType )

			-- if we have the action in another slot, then we must prevent a duplicate
			if alreadyInBar then
				ChatPrint(GetStringFromTid(285), SystemData.ChatLogFilters.SYSTEM)

				-- make the slot glow to highlight the duplicate
				HotbarSystem.GlowSlotWarning(existingSlot, 5, dragId)

				return true-- job is done
			end

		-- we are dragging a spell
		elseif SystemData.DragItem.actionType == SystemData.UserAction.TYPE_SPELL then
			
			local notarget = false

			-- check if the spells supports a target
			for _, value in pairs(SpellsInfo.SpellsData) do
				if value.id == dragId and value.notarget == true then
					notarget = true
					break
				end
			end

			-- does the spell support a target?
			if notarget then

				-- is this specific spell already in any hotbar slot?
				local alreadyInBar, existingSlot = HotbarSystem.ActionAlreadyInHotbar(dragId, SystemData.DragItem.actionType )

				-- if we have the spell in another slot, then we must prevent a duplicate (useless to have a duplicate of a spell without a target)
				if alreadyInBar then
					ChatPrint(GetStringFromTid(285), SystemData.ChatLogFilters.SYSTEM)
					
					-- make the slot glow to highlight the duplicate
					HotbarSystem.GlowSlotWarning(existingSlot, 5, dragId)

					return true-- job is done
				end
			end

		-- we are dragging an action
		elseif ActionsWindow.isAction(SystemData.DragItem.actionType) then
				
			-- we get the info about this action
			local actionData = ActionsWindow.ActionData[dragId]

			-- if we have no info it's not an action
			if actionData then

				-- this action can only be used inside a macro
				if actionData.macroOnly == true then
					ChatPrint(GetStringFromTid(219), SystemData.ChatLogFilters.SYSTEM)

					-- make the slot glow to highlight the duplicate
					HotbarSystem.GlowSlotWarning(existingSlot, 5, dragId)

					return true -- job is done
				end

				-- is this action unique? (only 1 can exist in all hotbars)
				if actionData.unique == true then

					-- is this specific action already in any hotbar slot?
					local alreadyInBar, existingSlot = HotbarSystem.ActionAlreadyInHotbar(dragId, "action")

					-- if we have the action in another slot, then we must prevent a duplicate
					if alreadyInBar then
						ChatPrint(GetStringFromTid(285), SystemData.ChatLogFilters.SYSTEM)
					
						-- make the slot glow to highlight the duplicate
						HotbarSystem.GlowSlotWarning(existingSlot, 5, dragId)

						return true-- job is done
					end
				end
			end
		end
	end
end

function Hotbar.PetBallFix(params)

	-- acquiring the ids from the params array
	local hotbarId = params[1]
	local slot = params[2]
	local dragType = params[3]
	local itemId = params[4]

	-- make sure the hotbar exist and the ids are valids
	if not Hotbar.DoesHotbarExist(hotbarId, true) or not IsValidID(slot) then
		return false
	end

	-- are we dragging an item?
	if dragType == SystemData.DragItem.TYPE_ITEM then

		-- is there something inside the slot?
		if HotbarHasItem(hotbarId, slot) and Hotbar.IsSlotEnabled(hotbarId, slot) then
		
			-- we get the action ID and type of whatever is inside the slot before changing it
			local currActionId = UserActionGetId(hotbarId, slot, 0)
			local currActionType = UserActionGetType(hotbarId, slot, 0)

			-- is this a stackable item?
			if currActionType == SystemData.UserAction.TYPE_USE_OBJECTTYPE or currActionType == SystemData.UserAction.TYPE_USE_ITEM then
				
				-- getting the item type
				local objectType = GetItemType(itemId)
				
				-- get the item hue ID
				local hueId = GetItemHue(itemId)

				-- is this a pet summoning ball?
				if objectType == Actions.PetBallType and hueId == 0 and ItemProperties.DoesItemHasProperty(itemId, 1054131) then  -- a crystal ball of pet summoning: [charges: ~1_charges~] : [linked pet: ~2_petName~]
					
					-- hotbar slot window name
					local slotWindow = "Hotbar" .. hotbarId .. "Button" .. slot

					-- replace the item type with the specific summoning ball instead
					HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_USE_ITEM, itemId, objectType, hotbarId, slot)

					-- show the charges for the item
					Interface.SaveSetting(slotWindow .. "EnableCharges", true)

					-- update the charges for the item
					HotbarSystem.UpdateQuantityNChargesForSlot(slotWindow, itemId, objectType, itemId, objectType, 0)

					return true -- job done
				end
			end
		end
	end

	return false
end

function Hotbar.HandleDropOnItem(params)

	-- acquiring the ids from the params array
	local hotbarId = params[1]
	local slot = params[2]
	local dragType = params[3]
	local itemId = params[4]

	-- make sure the hotbar exist and the ids are valids
	if not Hotbar.DoesHotbarExist(hotbarId, true) or not IsValidID(slot) then
		return false
	end
	
	-- are we dragging an item?
	if dragType == SystemData.DragItem.TYPE_ITEM then
	
		-- is there something inside the slot?
		if HotbarHasItem(hotbarId, slot) and Hotbar.IsSlotEnabled(hotbarId, slot) then
		
			-- we get the action ID and type of whatever is inside the slot before changing it
			local currActionId = UserActionGetId(hotbarId, slot, 0)
			local currActionType = UserActionGetType(hotbarId, slot, 0)
			
			-- toggle inventory action: drops the intem inside the player backpack
			if ActionsWindow.isAction(currActionType) and currActionId == 5011 then
				DragSlotDropObjectToObject(GetPlayerID())

				return true -- job is done

			-- a container in an hotbar slot: drop the item inside
			elseif currActionType == SystemData.UserAction.TYPE_USE_ITEM and IsContainer(currActionId) then
				DragSlotDropObjectToObject(currActionId)
				
				return true-- job is done

			-- cursor target stored action
			elseif currActionType == SystemData.UserAction.TYPE_TARGET_BY_OBJECT_ID then

				-- we get the stored target id
				local objID = UserActionGetTargetId(hotbarId, slot, 0)

				-- verify the object id is valid
				if IsValidID(objID) then
					
					-- the object is a mobile
					if VerifyMobileID(objID) and IsMobile(objID) then

						-- is that mobile a pack animal?
						if HasAccessibleInventory(objID) then

							-- we drop the item in the pack animal
							DragSlotDropObjectToObject(objID)

							return true-- job is done
						end

					else --the object is an item
						
						-- is the item a container?
						if IsContainer(objID) then

							-- we drop the item in the container
							DragSlotDropObjectToObject(objID)

							return true-- job is done
						end
					end
				end
			end
		end
	end

	return false
end

-- OnMouseOver Handler
function Hotbar.ItemMouseOver()
	
	-- basic IDs for the hotbar items
	local hotbarId = WindowGetId(WindowUtils.GetActiveDialog())
	local itemIndex = WindowGetId(SystemData.ActiveWindow.name)
	local subIndex = 0 -- default for hotbars
	local fakeId = 1234 -- fake item id used to show plain text

	-- current window name
	local slotWindow = SystemData.ActiveWindow.name
	local hotbar = "Hotbar".. hotbarId
	
	-- make sure the hotbar exist and the ids are valids
	if (hotbarId ~= SystemData.MacroSystem.STATIC_MACRO_ID and not Hotbar.DoesHotbarExist(hotbarId, true)) or not IsValidID(itemIndex) then
		return
	end

	-- if the hotbar is in movement we don't show the properties
	if WindowGetMoving(hotbar) then
		return
	end
	
	-- revealing a hotbar that was faded out
	Hotbar.ShowBar("Hotbar" .. hotbarId)

	-- if there is nothing in the slot, there is nothing to show
	if not HotbarHasItem(hotbarId, itemIndex) then
		return
	end

	-- get the action ID
	local actionId = UserActionGetId(hotbarId, itemIndex, subIndex)

	-- getting the current slot action type
	local actionType = UserActionGetType(hotbarId, itemIndex, subIndex)

	-- getting the binding text
	local bindingText = SystemData.Hotbar[hotbarId].Bindings[itemIndex] or L""

	-- adding the TID prefix to the bindingText if there is a key binded to the slot
	if IsValidWString(bindingText) then
		bindingText = GetStringFromTid(Hotbar.TID_BINDING)..L" "..bindingText -- "Binding:"..L" "..<KEY>
	end

	-- default target text
	local targetText = L""

	-- does the action requires a target?
	if (( UserActionHasTargetType(hotbarId, itemIndex, subIndex) ) and ( SystemData.Settings.GameOptions.legacyTargeting == false )) then
		
		-- getting the target type actually set
		local targetType = UserActionGetTargetType(hotbarId, itemIndex, subIndex, slotWindow)

		-- get the string name of the current target
		local targetString = Hotbar.TargetTypeToWStringName(targetType)

		-- if we have a string name we attach it to the prefix
		if IsValidWString(targetString) then
			-- "target:" text prefix + target name
			targetText = GetStringFromTid(Hotbar.TID_TARGET) .. L" " .. targetString
		end
	end

	-- setting the level of details to short by default
	local detailType = ItemProperties.DETAIL_SHORT

	-- if the player have set it so, we give more details
	if (SystemData.Settings.Interface.showTooltips) then

		detailType = ItemProperties.DETAIL_LONG
	end

	-- mount blockbar has a specific text to show
	if hotbarId == Interface.MountBlockbar then
		
		-- reset the window properties array (if different from the one last we have seen)
		pcall(ItemProperties.ResetWindowDataProperties, fakeId + 1)

		-- item properties params array
		local itemData = 
		{	
			windowName = slotWindow,
			itemId = fakeId,
			itemLoc = {hotbarId=hotbarId, itemIndex=itemIndex},
			binding = bindingText, -- As defined above
			itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
			detail = detailType,
			title = GetStringFromTid(290),
			body = GetStringFromTid(291),
		}

		-- showing the properties
		ItemProperties.SetActiveItem(itemData)

		return

	-- items (non-stackable). actionId is the item id
	elseif actionType == SystemData.UserAction.TYPE_USE_ITEM then
		
		-- reset the window properties array (if different from the one last we have seen)
		pcall(ItemProperties.ResetWindowDataProperties, actionId)

		-- if the slot is enabled, we just show the info about the skill
		if Hotbar.IsSlotEnabled(hotbarId, itemIndex) then

			-- item properties params array
			local itemData = 
			{ 
				windowName = slotWindow,
				itemId = actionId,
				itemType = WindowData.ItemProperties.TYPE_ITEM,
				detail = detailType,
				itemLoc = {hotbarId=hotbarId, itemIndex=itemIndex},
				binding = bindingText,
				myTarget = targetText, 
			}

			-- showing the properties
			ItemProperties.SetActiveItem(itemData)
			
			return

		else -- if the slot is NOT enabled, we must show why
			
			-- reset the window properties array (if different from the one last we have seen)
			pcall(ItemProperties.ResetWindowDataProperties, fakeId)

			-- item name
			local name = Interface.LoadSetting(slotWindow.."ItemName", L"")	

			-- default desc value
			local desc = L""

			-- You cannot use this ability while dead.
			if Interface.IsPlayerDead then
				desc = desc .. GetStringFromTid(1060169) .. L"\n"

			-- You cannot use this ability while frozen.
			elseif (CustomBuffs.StunTime > 0 or BuffDebuff.Timers[1037]) then	
				desc = desc .. GetStringFromTid(502646) .. L"\n"

			-- item not available 
			else
				desc = desc .. GetStringFromTid(1094717) -- (Not Available)
			end

			-- item properties params array
			local itemData = 
			{ 
				windowName = slotWindow,
				itemId = fakeId,
				detail = detailType,
				itemLoc = {hotbarId=hotbarId, itemIndex=itemIndex},
				itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
				binding = bindingText ,
				myTarget = targetText,
				title =	name,
				body = desc
			}

			-- showing the properties
			ItemProperties.SetActiveItem(itemData)	

			return
		end

	-- items (stackable). actionId is the object type
	elseif actionType == SystemData.UserAction.TYPE_USE_OBJECTTYPE then
		
		-- if the slot is enabled, we just show the info about the skill
		if Hotbar.IsSlotEnabled(hotbarId, itemIndex) then

			-- getting the id of an item of that type
			local itemId = UserActionGetNextObjectId(actionId)

			-- reset the window properties array (if different from the one last we have seen)
			pcall(ItemProperties.ResetWindowDataProperties, itemId)

			-- item properties params array
			local itemData = 
			{ 
				windowName = slotWindow,
				itemId = itemId,
				itemType = WindowData.ItemProperties.TYPE_ITEM,
				detail = detailType,
				itemLoc = {hotbarId=hotbarId, itemIndex=itemIndex},
				binding = bindingText,
				myTarget = targetText, 
			}

			-- showing the properties
			ItemProperties.SetActiveItem(itemData)

			return
		else -- if the slot is NOT enabled, we must show why
			
			-- reset the window properties array (if different from the one last we have seen)
			pcall(ItemProperties.ResetWindowDataProperties, fakeId + 1)

			-- item name
			local name = Interface.LoadSetting(slotWindow.."ItemName", L"")	

			-- default desc value
			local desc = L""

			-- You cannot use this ability while dead.
			if Interface.IsPlayerDead then
				desc = desc .. GetStringFromTid(1060169) .. L"\n"

			-- You cannot use this ability while frozen.
			elseif (CustomBuffs.StunTime > 0 or BuffDebuff.Timers[1037]) then	
				desc = desc .. GetStringFromTid(502646) .. L"\n"

			-- item not available 
			else
				desc = desc .. GetStringFromTid(1094717) -- (Not Available)
			end

			-- item properties params array
			local itemData = 
			{ 
				windowName = slotWindow,
				itemId = fakeId,
				detail = detailType,
				itemLoc = {hotbarId=hotbarId, itemIndex=itemIndex},
				itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
				binding = bindingText ,
				myTarget = targetText,
				title =	name,
				body = desc
			}

			-- showing the properties
			ItemProperties.SetActiveItem(itemData)	

			return
		end

	-- virtues
	elseif actionType == SystemData.UserAction.TYPE_INVOKE_VIRTUE then

		-- getting the action data record for the current action
		local actionData = ActionsWindow.ActionData[actionId]

		-- get the current virtue id
		local itemId = actionData.invokeId

		-- reset the window properties array (if different from the one last we have seen)
		pcall(ItemProperties.ResetWindowDataProperties, itemId)
		
		-- item properties params array
		local itemData = 
		{ 
			windowName = slotWindow,
			itemId = actionId,
			itemType = WindowData.ItemProperties.TYPE_ACTION,
			actionType = actionType,
			detail = detailType,
			itemLoc = {hotbarId=hotbarId, itemIndex=itemIndex},
			binding = bindingText,
			myTarget = targetText,
		}

		-- showing the properties
		ItemProperties.SetActiveItem(itemData)	

		return

	-- weapons abilities
	elseif actionType == SystemData.UserAction.TYPE_WEAPON_ABILITY then
		
		-- if the slot is enabled, we just show the info about the weapon ability as it is
		if Hotbar.IsSlotEnabled(hotbarId, itemIndex) then
			
			-- reset the window properties array (if different from the one last we have seen)
			pcall(ItemProperties.ResetWindowDataProperties, actionId)

			-- item properties params array
			local itemData = 
			{ 
				windowName = slotWindow,
				itemId = actionId,
				itemType = WindowData.ItemProperties.TYPE_ACTION,
				actionType = actionType,
				detail = detailType,
				itemLoc = {hotbarId=hotbarId, itemIndex=itemIndex},
				binding = bindingText, 
				myTarget = targetText, 
			}

			-- showing the properties
			ItemProperties.SetActiveItem(itemData)	

			return

		else -- if the slot is NOT enabled, we must show why
			
			-- reset the window properties array (if different from the one last we have seen)
			pcall(ItemProperties.ResetWindowDataProperties, fakeId + 1)

			-- get the correct action ID
			actionId = EquipmentData.GetWeaponAbilityId(actionId) + CharacterAbilities.WEAPONABILITY_OFFSET

			-- item properties params array
			local itemData = Hotbar.GetDisabledInfoArray(actionId, actionType, targetType, detailType, slotWindow)
			
			-- adding the missing data
			itemData.windowName = slotWindow
			itemData.itemId = fakeId
			itemData.itemLoc = {hotbarId=hotbarId, itemIndex=itemIndex}
			itemData.binding = bindingText 
			itemData.myTarget = targetText

			-- showing the properties
			ItemProperties.SetActiveItem(itemData)	

			return
		end

	-- spells
	elseif actionType == SystemData.UserAction.TYPE_SPELL then
		
		-- if the slot is enabled, we just show the info about the spell as it is
		if Hotbar.IsSlotEnabled(hotbarId, itemIndex) then
			
			-- reset the window properties array (if different from the one last we have seen)
			pcall(ItemProperties.ResetWindowDataProperties, actionId)

			-- item properties params array
			local itemData = 
			{ 
				windowName = slotWindow,
				itemId = actionId,
				itemType = WindowData.ItemProperties.TYPE_ACTION,
				actionType = actionType,
				detail = detailType,
				itemLoc = {hotbarId=hotbarId, itemIndex=itemIndex},
				binding = bindingText, 
				myTarget = targetText, 
			}

			-- showing the properties
			ItemProperties.SetActiveItem(itemData)	

			return

		else -- if the slot is NOT enabled, we must show why
			
			-- reset the window properties array (if different from the one last we have seen)
			pcall(ItemProperties.ResetWindowDataProperties, fakeId + 1)

			-- item properties params array
			local itemData = Hotbar.GetDisabledInfoArray(actionId, actionType, targetType, detailType, slotWindow)
			
			-- adding the missing data
			itemData.windowName = slotWindow
			itemData.itemId = fakeId
			itemData.itemLoc = {hotbarId=hotbarId, itemIndex=itemIndex}
			itemData.binding = bindingText 
			itemData.myTarget = targetText

			-- showing the properties
			ItemProperties.SetActiveItem(itemData)	

			return
		end

	elseif HotbarSystem.IsHotbarMacro(actionType) then
			
		-- reset the window properties array (if different from the one last we have seen)
		pcall(ItemProperties.ResetWindowDataProperties, fakeId + 1)

		-- the ID is the macro ID of when it was dropped on the slot, this function will give us the real ID
		local macroIndex = MacroSystemGetMacroIndexById(actionId)

		-- get the macro name
		local macroName = UserActionMacroGetName(SystemData.MacroSystem.STATIC_MACRO_ID, macroIndex)

		-- get the macro binding
		bindingText = UserActionMacroGetBinding(SystemData.MacroSystem.STATIC_MACRO_ID, macroIndex) or L""

		-- item properties params array
		local itemData = 
		{	
			windowName = slotWindow,
			itemId = fakeId,
			itemLoc = {hotbarId=hotbarId, itemIndex=itemIndex},
			binding = bindingText, -- As defined above
			itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
			detail = detailType,
			binding = bindingStr,
			title = macroName,
			body = L"",
		}

		-- showing the properties
		ItemProperties.SetActiveItem(itemData)

		return

	-- Skills
	elseif actionType == SystemData.UserAction.TYPE_SKILL then
		
		-- if the slot is enabled, we just show the info about the skill
		if Hotbar.IsSlotEnabled(hotbarId, itemIndex) then

			-- reset the window properties array (if different from the one last we have seen)
			pcall(ItemProperties.ResetWindowDataProperties, actionId + 1)

			-- we add before the binding the current skill value
			local skillValue = L"\n".. GetStringFromTid(1062298) .. L" " .. SkillsWindow.FormatSkillValue(GetSkillValue(actionId + 1, SystemData.Settings.Interface.SkillsWindowShowModified, true)) .. L"%" -- Current Value:
			bindingText = skillValue ..L"\n\n"..bindingText
			
			-- item properties params array
			local itemData = 
			{ 
				windowName = slotWindow,
				itemId = actionId + 1,
				itemType = WindowData.ItemProperties.TYPE_ACTION,
				actionType = actionType,
				detail = detailType,
				itemLoc = {hotbarId=hotbarId, itemIndex=itemIndex},
				binding = bindingText, 
				myTarget = targetText, 
			}

			-- showing the properties
			ItemProperties.SetActiveItem(itemData)	

			return

		else -- if the slot is NOT enabled, we must show why
			
			-- reset the window properties array (if different from the one last we have seen)
			pcall(ItemProperties.ResetWindowDataProperties, fakeId + 1)

			-- skill name
			local name = GetStringFromTid(GetSkillTID(actionId))	

			-- default desc value
			local desc = L""

			-- You cannot use this ability while dead.
			if Interface.IsPlayerDead then
				desc = desc .. GetStringFromTid(1060169) .. L"\n"
			end

			-- item properties params array
			local itemData = 
			{ 
				windowName = slotWindow,
				itemId = fakeId,
				detail = detailType,
				itemLoc = {hotbarId=hotbarId, itemIndex=itemIndex},
				itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
				binding = bindingText ,
				myTarget = targetText,
				title =	name,
				body = desc
			}

			-- showing the properties
			ItemProperties.SetActiveItem(itemData)	

			return
		end

	-- player stats
	elseif (actionType == SystemData.UserAction.TYPE_PLAYER_STATS) then
		
		-- reset the window properties array (if different from the one last we have seen)
		pcall(ItemProperties.ResetWindowDataProperties, actionId)

		-- no need to show the binding for stats
		bindingText = L""	

		-- item properties params array
		local itemData = 
		{ 
			windowName = slotWindow,
			itemId = actionId,
			itemType = WindowData.ItemProperties.TYPE_ACTION,
			actionType = actionType,
			detail = detailType,
			itemLoc = {hotbarId=hotbarId, itemIndex=itemIndex},
			binding = bindingText, 
			myTarget = targetText, 
		}

		-- showing the properties
		ItemProperties.SetActiveItem(itemData)	

		return

	-- all the other actions
	elseif ActionsWindow.isAction(actionType) then
		
		-- player backpack action
		if (actionId == 5011) then
			
			-- we use its specific function for this
			ItemProperties.OnPlayerBackpackMouseover()

			return
		end

		-- getting the action data for the current action
		local actionData = ActionsWindow.ActionData[actionId]

		-- if there is no action data something is wrong and it's better to get out
		if not actionData then
			return
		end

		-- does this action have a settings hotkey?
		if actionData.settingKeyBinding then
				
			-- getting the setting's hotkey type
			local keyType = actionData.settingKeyBinding

			-- getting the key from settings
			bindingText = SystemData.Settings.Keybindings[keyType]
		end

		-- default name value
		local name = L""

		-- default description value
		local desc = L""

		-- mass organizer
		if actionId == 5732 then
			
			-- we use the organize ID for the name in this action
			name = ReplaceTokens(GetStringFromTid(1155442), {towstring( Organizer.ActiveOrganizer ) } ) -- Organizer ~1_NAME~

			-- we show the organizer name into the description
			if IsValidWString(Organizer.Organizers_Desc[Organizer.ActiveOrganizer]) then
				desc = desc .. L"\n\n" .. ReplaceTokens(GetStringFromTid(1154934), {Organizer.Organizers_Desc[Organizer.ActiveOrganizer]}) -- \\nCurrent: ~1_NAME~
			end
		
		-- TID name
		elseif actionData.nameTid then
			name = GetStringFromTid(actionData.nameTid)

		else -- string name

			name = actionData.nameString
		end

		-- show the detailed description only if it's enabled
		if detailType == ItemProperties.DETAIL_LONG then

			-- TID description
			if (not actionData.detailTid) then
				desc = actionData.detailString

			else -- string description

				desc = GetStringFromTid(actionData.detailTid)
			end
		end

		-- boat command actions cannot be used while piloting a ship
		if ((actionId >= 37 and actionId <= 50) or (actionId >= 5150 and actionId <= 5153)) and Interface.IsPilotingAShip then

			desc = desc .. L"\n\n" .. GetStringFromTid(264)
		end

		-- delay
		if actionType == SystemData.UserAction.TYPE_DELAY then

			-- add the delay value
			desc = desc .. L"\n\n" .. ReplaceTokens(GetStringFromTid(310), {towstring( UserActionDelayGetDelay(hotbarId, itemIndex, subIndex) ) } ) 
		end

		-- target resource
		if actionType == SystemData.UserAction.TYPE_TARGET_BY_RESOURCE then

			-- get the object ID
			local objectId = UserActionTargetByResourceGetUseObjectInstanceId(hotbarId, itemIndex, subIndex)
			
			-- do we have a valid object ID?
			if IsValidID(objectId) then

				-- get the resource data
				local resource = ActionEditWindow.ResourceType[UserActionTargetByResourceGetResourceType(hotbarId, itemIndex, subIndex) + 1]

				-- do we have a resource?
				if resource then

					-- add the delay value
					desc = desc .. L"\n\n" .. ReplaceTokens(GetStringFromTid(312), {GetStringFromTid( resource.tid ) } )
				end
			end
		end

		-- command
		if actionId == 57 and actionType == SystemData.UserAction.TYPE_SPEECH_USER_COMMAND then

			-- add the delay value
			desc = desc .. L"\n\n" .. ReplaceTokens(GetStringFromTid(311), {towstring( UserActionSpeechGetText(hotbarId, itemIndex, subIndex) ) } ) 
		end

		-- crat item
		if actionId == 6010 then

			-- getting the current setting
			local command = UserActionSpeechGetText(hotbarId, itemIndex, subIndex)

			-- do we have a command set?
			if command and wstring.find(command, L",", 1, true) then

				-- remove the first part of the command
				local itemTid = wstring.gsub(command, L"script Actions.CraftItem[(]", L"")

				-- remove everything after the comma (that separates the first parameter)
				itemTid = wstring.sub(itemTid, 1, wstring.find(itemTid, L",", 1, true) - 1)

				-- add the current item name
				desc = desc .. L"\n\n" .. ReplaceTokens(GetStringFromTid(659), { GetStringFromTid(tonumber(itemTid)) }) .. L"\n"

			else -- there is no item set!
				desc = desc .. L"\n\n" ..GetStringFromTid(661) .. L"\n"
			end
		end

		-- if the slot is disabled, we just show why
		if not Hotbar.IsSlotEnabled(hotbarId, itemIndex) then

			-- get the disabled reason
			local _, reason = Actions.IsActionEnabled(actionId, actionType, hotbarId, itemIndex)

			-- add the reason the action is disabled
			desc = desc .. L"\n\n\n" .. GetStringFromTid(reason) .. L"\n"
		end

		-- reset the window properties array (if different from the one last we have seen)
		pcall(ItemProperties.ResetWindowDataProperties, fakeId + 1)

		-- item properties params array
		local itemData = 
		{
			windowName = slotWindow,
			itemId = fakeId,
			detail = ItemProperties.DETAIL_LONG,
			itemLoc = {hotbarId=hotbarId, itemIndex=itemIndex},
			itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
			binding = bindingText, -- As defined above
			title =	name,
			body = desc,
		}	
		
		-- showing the properties
		ItemProperties.SetActiveItem(itemData)	

		return
	end	
end

function Hotbar.ItemMouseOverEnd()
	
	-- begin the fade animation
	Hotbar.HideBar(WindowGetParent(SystemData.ActiveWindow.name))

	-- clear the current item properties
	ItemProperties.ClearMouseOverItem()
end

function Hotbar.ItemRButtonUp()

	-- basic IDs
	local hotbarId = WindowGetId(WindowUtils.GetActiveDialog())
	local itemIndex = WindowGetId(SystemData.ActiveWindow.name)
	local subIndex = 0 -- default value for hotbars

	-- make sure the hotbar and slot exist
	if not Hotbar.DoesHotbarExist(hotbarId, true) and IsValidID(itemIndex) then
		return
	end

	-- elements window names
	local hotbar = "Hotbar" .. hotbarId
	local slotWindow = SystemData.ActiveWindow.name

	-- creating parameters array
	local param = {SlotWindow = slotWindow, HotbarId = hotbarId, ItemIndex = itemIndex, SubIndex = subIndex}	
	
	-- is this a blockbar?
	local isBlockbar = Interface.LoadSetting( hotbar .. "_IsBlockbar", false)

	-- is this the pet controls bar?
	local petControlsBar = Interface.PetControlsBar == hotbarId

	-- is this the mount blockbar?
	local mountBlockbar = Interface.MountBlockbar == hotbarId

	-- is this the menu bar?
	local menuBar = Interface.MenuBar == hotbarId

	-- is this the static bar? (the first hotbar and can't be destroyed)
	local isStatic = hotbarId == HotbarSystem.STATIC_HOTBAR_ID

	-- auto-hide active?
	local autoHide = Interface.LoadSetting( hotbar .. "Fade", false )

	-- reset the context menu
	ContextMenu.CleanUp()

	-- actions not available for blockbars and pet controls bar
	if not isBlockbar and not petControlsBar  then

		-- lock hotbar
		if SystemData.Hotbar[hotbarId].Locked then
			ContextMenu.CreateLuaContextMenuItem({tid = HotbarSystem.TID_UNLOCK_HOTBAR, returnCode = HotbarSystem.ContextReturnCodes.LOCK_HOTBAR, param = param})

		else -- unlock hotbar

			ContextMenu.CreateLuaContextMenuItem({tid = HotbarSystem.TID_LOCK_HOTBAR, returnCode = HotbarSystem.ContextReturnCodes.LOCK_HOTBAR, param = param})
		end
		
		-- new hotbar
		ContextMenu.CreateLuaContextMenuItem({tid = HotbarSystem.TID_NEW_HOTBAR, returnCode = HotbarSystem.ContextReturnCodes.NEW_HOTBAR, param = param})
	end

	-- actions not available for the mount blockbar
	if not mountBlockbar then

		-- disable auto hide
		if autoHide then
			ContextMenu.CreateLuaContextMenuItem({tid = 1155402, returnCode = HotbarSystem.ContextReturnCodes.DISABLE_AUTOHIDE, param = param})

		else -- enable auto hide

			ContextMenu.CreateLuaContextMenuItem({tid = 1155403, returnCode = HotbarSystem.ContextReturnCodes.ENABLE_AUTOHIDE, param = param})
		end
	
		-- static bar, mennu bar and pet controls bar cannot be destroyed
		if (not isStatic and not menuBar and not petControlsBar) then
			
			-- destroy hotbar
			ContextMenu.CreateLuaContextMenuItem({tid = HotbarSystem.TID_DESTROY_HOTBAR, returnCode = HotbarSystem.ContextReturnCodes.DESTROY_HOTBAR, param = param})

			-- find if the hotbar is part of a group
			local grp, cnt = Hotbar.FindHotbarGroup("Hotbar" .. hotbarId)

			if cnt > 0 then -- if it's part of a group we add the option to destroy the whole group
				ContextMenu.CreateLuaContextMenuItem({tid = 1155386, returnCode = HotbarSystem.ContextReturnCodes.DESTROY_HOTBAR_GROUP, param = param})
			end
		end
	end

	-- getting the current slot action type
	local actionType = UserActionGetType(hotbarId, itemIndex, subIndex)

	-- is this a macro? (used for the hotkey assignation)
	if HotbarSystem.IsHotbarMacro(actionType) then

		-- get the action ID
		local actionId = UserActionGetId(hotbarId, itemIndex, subIndex)

		-- flagging the params to remember that this is a macro
		param.isMacro = true

		-- adding the macro's id to the params
		param.macroId = MacroSystemGetMacroIndexById(actionId)
	end

	-- assign hotkey
	ContextMenu.CreateLuaContextMenuItem({tid = HotbarSystem.TID_ASSIGN_HOTKEY, returnCode = HotbarSystem.ContextReturnCodes.ASSIGN_KEY, param = param})

	-- actions not available for the mount blockbar
	-- (we have to do this again to keep the order of elements in the context menu)
	if not mountBlockbar then
		
		-- is there something in the slot?
		if (HotbarHasItem(hotbarId, itemIndex) == true) then

			-- adding more options based on the content
			HotbarSystem.CreateUserActionContextMenuOptions(hotbarId, itemIndex, subIndex, slotWindow)
		
			-- initializing the sub menu array
			local subMenu = {}
	
			-- is there a custom texture set for this slot?
			local custom = Interface.LoadSetting( slotWindow .. "CustomTXT", nil, 0 )
	
			-- listing all the mini texture packs available
			for i, element in pairsByIndex(MiniTexturePack.DB) do
			
				-- button highlighted? (no by default)
				local press = false

				-- is this texture the one saved for the slot?
				if (custom) then
					press = custom == i

				else -- is this texture the one used for all elements?

					press = Interface.Settings.MTP_Current == i
				end

				-- copying the params
				local currParam = table.copy(param)

				-- adding the current texture ID to the current record params
				currParam.SelectedTexture = i

				-- creating the record for the sub menu array containing the info of this texture
				local item = { str = element.name, returnCode = HotbarSystem.ContextReturnCodes.MINI_TEXTURE_PACK, param = currParam, pressed = press }

				-- adding the record to the sub menu
				table.insert(subMenu, item)
			end

			-- adding the submenu to its related button
			ContextMenu.CreateLuaContextMenuItem({tid = 9, subMenuOptions = subMenu})
		
			-- reset the submenu array
			subMenu = {}

			-- is there a custom texture set for this slot's border?
			custom = Interface.LoadSetting( slotWindow .. "Custom", Interface.Settings.MTP_CurrentBorder )
	
			-- listing all the borders texture available
			for i, element in pairsByIndex(MiniTexturePack.Overlays) do
			
				-- is this the border saved for this slot?
				local press = custom == i

				-- copying the params
				local currParam = table.copy(param)

				-- adding the current texture ID to the current record params
				currParam.SelectedBorder = i

				-- creating the record for the sub menu array containing the info of this border texture
				local item = { str = element.name, returnCode = HotbarSystem.ContextReturnCodes.BORDER_TEXTURE, param = currParam, pressed = press, false }

				-- adding the record to the sub menu
				table.insert(subMenu, item)
			end

			-- adding the submenu to its related button
			ContextMenu.CreateLuaContextMenuItem({tid = 1155279, subMenuOptions = subMenu})
		end
	end
	
	-- showing the context menu
	ContextMenu.ActivateLuaContextMenu(Hotbar.ContextMenuCallback)
end

function Hotbar.ContextMenuCallback(returnCode, param)
	
	-- handling the callback of actions
	local bHandled = HotbarSystem.ContextMenuCallback(returnCode, param) 
		
	-- if it wasnt handled then check for hotbar empty slot specific options
	if (bHandled == false) then	

		-- setting the texture for the slot
		if (returnCode == HotbarSystem.ContextReturnCodes.BORDER_TEXTURE) then

			-- saving the texture id
			Interface.SaveSetting( param.SlotWindow .. "Custom", param.SelectedBorder )

			-- updating the texture on the slot
			HotbarSystem.UpdateTargetTypeIndicator(param.SlotWindow, param.HotbarId, param.ItemIndex, 0)

		-- setting the border for the slot
		elseif (returnCode == HotbarSystem.ContextReturnCodes.MINI_TEXTURE_PACK) then

			-- saving the border id
			Interface.SaveSetting( param.SlotWindow .. "CustomTXT", param.SelectedTexture )

			-- setting the border id
			DynamicImageSetTexture( param.SlotWindow .."SquareIconBG", MiniTexturePack.DB[param.SelectedTexture].texture .. "Icon", 0, 0 )	
			LabelSetTextColor(param.SlotWindow.."StatsTop", MiniTexturePack.DB[param.SelectedTexture].PaperdollLabelColor.r, MiniTexturePack.DB[param.SelectedTexture].PaperdollLabelColor.g, MiniTexturePack.DB[param.SelectedTexture].PaperdollLabelColor.b)
			LabelSetTextColor(param.SlotWindow.."StatsBottom", MiniTexturePack.DB[param.SelectedTexture].PaperdollLabelColor.r, MiniTexturePack.DB[param.SelectedTexture].PaperdollLabelColor.g, MiniTexturePack.DB[param.SelectedTexture].PaperdollLabelColor.b)
			LabelSetTextColor(param.SlotWindow.."Stats", MiniTexturePack.DB[param.SelectedTexture].PaperdollLabelColor.r, MiniTexturePack.DB[param.SelectedTexture].PaperdollLabelColor.g, MiniTexturePack.DB[param.SelectedTexture].PaperdollLabelColor.b)

		-- clear item
		elseif (returnCode == HotbarSystem.ContextReturnCodes.CLEAR_ITEM) then
			
			-- if it's a slot that shows properties, we disable it first
			if (Interface.PropsSlot and param.HotbarId == Interface.PropsSlot.HotbarID and param.ItemIndex == Interface.PropsSlot.SlotID) then
				Interface.PropsSlot = nil
				Interface.DeleteSetting("PropsSlotHotbarID")
				Interface.DeleteSetting("PropsSlotSlotID")
			end

			-- if it's an action we update the actions list icons (so if it's unique it will be disabled)
			if ActionsWindow.isAction(param.ActionType) then
				
				-- We do it in 0.5 seconds to be sure it works properly
				Interface.AddTodoList({ name = "Update Action Icons", func = function() ActionsWindow.UpdateIcons() end, time = Interface.TimeSinceLogin + 0.5 })
			end

			-- if this slot has a target mouse over we remove it from the array
			if HotbarSystem.TargetMouseOver then
				HotbarSystem.TargetMouseOver[param.SlotWindow] = nil
			end

			-- clearing the slot for good
			HotbarClearItem(param.HotbarId, param.ItemIndex)

			-- remove the action from the slot
			HotbarSystem.ClearActionIcon(param.SlotWindow, param.HotbarId, param.ItemIndex, param.SubIndex)

			-- update the key bindings for the slot
			HotbarSystem.UpdateBindingToSlot(param.HotbarId, param.ItemIndex)

		-- assign hotkey
		elseif (returnCode == HotbarSystem.ContextReturnCodes.ASSIGN_KEY) then

			-- has this been requested from the spellbook?
			if param.isSpell then
				Spellbook.AssignHotkey(param.abilityId, param.iconId, param.spellbookId, param.windowName)

			-- has this been requested from the skills window?
			elseif param.isSkill then
				SkillsWindow.AssignHotkey(param.abilityId, param.iconId, param.windowName)

			-- is the action on the slot a macro (and is not the mount blockbar)?
			elseif param.isMacro and not param.HotbarId == Interface.MountBlockbar then

				-- show the assign hotkey info tooltip
				WindowUtils.ShowAssignHotkeyInfo("Hotbar" .. param.HotbarId .. "Button" .. param.ItemIndex)

				MacroWindow.RecordingIndex = param.macroId
				MacroWindow.RecordingKey = true
				BroadcastEvent(SystemData.Events.INTERFACE_RECORD_KEY)

			else 
				-- show the assign hotkey info tooltip
				WindowUtils.ShowAssignHotkeyInfo("Hotbar" .. param.HotbarId .. "Button".. param.ItemIndex)
			
				-- assigning an hotkey to the hotbar slot
				Hotbar.RecordingSlot = param.ItemIndex
				Hotbar.RecordingHotbar = param.HotbarId
				Hotbar.RecordingKey = true
				BroadcastEvent(SystemData.Events.INTERFACE_RECORD_KEY)
			end

		-- creating a new hotbar
		elseif (returnCode == HotbarSystem.ContextReturnCodes.NEW_HOTBAR) then
			local rdata = {title=GetStringFromTid(HotbarSystem.TID_NEW_HOTBAR), subtitle=GetStringFromTid(1155471), callfunction=Hotbar.CreateNew, maxChars=5}
			RenameWindow.Create(rdata)

		-- destroying the hotbar
		elseif (returnCode == HotbarSystem.ContextReturnCodes.DESTROY_HOTBAR) then
            local okayButton = { textTid=UO_StandardDialog.TID_OKAY, callback=function() HotbarSystem.DestroyHotbar(param.HotbarId) end }
            local cancelButton = { textTid=UO_StandardDialog.TID_CANCEL }
			local DestroyConfirmWindow = 
			{
				windowName = "Hotbar"..param.HotbarId,
				titleTid = HotbarSystem.TID_DESTROY_HOTBAR,
				bodyTid = HotbarSystem.TID_DESTROY_CONFIRM,
				buttons = { okayButton, cancelButton },
				closeCallback = cancelButton.callback,
				destroyDuplicate = true,
			}
					
			UO_StandardDialog.CreateDialog(DestroyConfirmWindow)

		-- destroying hotbars group
		elseif (returnCode == HotbarSystem.ContextReturnCodes.DESTROY_HOTBAR_GROUP) then
            local okayButton = { textTid=UO_StandardDialog.TID_OKAY, callback=function() HotbarSystem.DestroyHotbarGroup("Hotbar"..param.HotbarId) end }
            local cancelButton = { textTid=UO_StandardDialog.TID_CANCEL }
			local DestroyConfirmWindow = 
			{
				windowName = "Hotbar"..param.HotbarId,
				titleTid = HotbarSystem.TID_DESTROY_HOTBAR,
				bodyTid  = 1155387,
				buttons = { okayButton, cancelButton },
				closeCallback = cancelButton.callback,
				destroyDuplicate = true,
			}
					
			UO_StandardDialog.CreateDialog(DestroyConfirmWindow)

		-- lock hotbar
		elseif (returnCode == HotbarSystem.ContextReturnCodes.LOCK_HOTBAR) then
			Hotbar.SetLocked(param.HotbarId, not SystemData.Hotbar[param.HotbarId].Locked)

		-- enable autohide
		elseif (returnCode == HotbarSystem.ContextReturnCodes.ENABLE_AUTOHIDE) then
			Interface.SaveSetting( "Hotbar"..param.HotbarId.. "Fade", true )
			Hotbar.HideBar("Hotbar"..param.HotbarId)

		-- disable autohide
		elseif (returnCode == HotbarSystem.ContextReturnCodes.DISABLE_AUTOHIDE) then
			Interface.SaveSetting( "Hotbar"..param.HotbarId.. "Fade", false )
			Hotbar.ShowBar("Hotbar"..param.HotbarId)
		end	
	end						 
end

function Hotbar.KeyRecorded()

	-- are we recording a key?
	if (Hotbar.RecordingKey == true) then

		-- turn off the recording
		Hotbar.RecordingKey = false

		-- hiding the hotkey recording window
		WindowSetShowing("AssignHotkeyInfo",false)

		-- is this a setting key conflict?
		if SystemData.BindingConflictType == SystemData.BindType.BINDTYPE_SETTINGS then

			-- scan all keys to find the duplicate
			for type, key in pairs(SystemData.Settings.Keybindings) do

				-- is this the hotkey?
				if key == SystemData.RecordedKey then

					-- update the conflict item index
					_, SystemData.BindingConflictItemIndex = SettingsWindow.GetKeyBindingNameFromType(type)
					break
				end
			end
		end

		-- if we're trying to replace the same slot of the same hotbar is not a conflict.
		if SystemData.BindingConflictHotbarId == Hotbar.RecordingHotbar and SystemData.BindingConflictItemIndex == Hotbar.RecordingSlot then
			SystemData.BindingConflictType = SystemData.BindType.BINDTYPE_NONE
		end
		
		-- is there a conflicting key?
		if (SystemData.BindingConflictType ~= SystemData.BindType.BINDTYPE_NONE) then
			body = GetStringFromTid( Hotbar.TID_BINDING_CONFLICT_BODY )..L"\n\n"..HotbarSystem.GetKeyName(SystemData.BindingConflictHotbarId, SystemData.BindingConflictItemIndex, SystemData.BindingConflictType)..L"\n\n"..GetStringFromTid( Hotbar.TID_BINDING_CONFLICT_QUESTION )
			
			local yesButton = { textTid = Hotbar.TID_YES,
								callback =	function()
											HotbarSystem.ReplaceKey(
												SystemData.BindingConflictHotbarId, SystemData.BindingConflictItemIndex, SystemData.BindingConflictType,
												Hotbar.RecordingHotbar, Hotbar.RecordingSlot, SystemData.BindType.BINDTYPE_HOTBAR,
												SystemData.RecordedKey, SystemData.RecordedKeySmallDisplay)
											end
							  }
			local noButton = { textTid = Hotbar.TID_NO }
			local windowData = 
			{
				windowName = "Hotbar", 
				titleTid = Hotbar.TID_BINDING_CONFLICT_TITLE, 
				body = body, 
				buttons = { yesButton, noButton },
				closeCallback = noButton.callback,
				destroyDuplicate = true,
			}
			UO_StandardDialog.CreateDialog( windowData )

	    else -- no conflict

			-- record slot window name
			local element = "Hotbar"..Hotbar.RecordingHotbar.."Button"..Hotbar.RecordingSlot
			
			-- getting the action ID for the current slot
			local actionId = UserActionGetId(Hotbar.RecordingHotbar, Hotbar.RecordingSlot, 0)

			-- getting the action type for the current slot
			local actionType = UserActionGetType(Hotbar.RecordingHotbar, Hotbar.RecordingSlot, 0)

			-- is this a weapon ability?
			if actionType == SystemData.UserAction.TYPE_WEAPON_ABILITY  then
				
				-- hotkey ID on settings window for ability 1
				local setId = 10

				-- if it's the ability 2 we change it
				if actionId == 2 then
					setId = 11
				end

				-- setting the hotkey inside the setting window
				SettingsWindow.Keybindings[setId].newValue = SystemData.RecordedKeySmallDisplay

				-- removing the hotkey from the hotbar slot
				SystemData.Hotbar[Hotbar.RecordingHotbar].Bindings[Hotbar.RecordingSlot] = L""
				SystemData.Hotbar[Hotbar.RecordingHotbar].BindingDisplayStrings[Hotbar.RecordingSlot] = L""
				
				-- update the keybinding in the character profile
				BroadcastEvent( SystemData.Events.KEYBINDINGS_UPDATED )

				-- updating the keybinding text graphics
				HotbarSystem.UpdateBinding(element,SystemData.RecordedKeySmallDisplay,SystemData.RecordedKey)
				
				-- update the keybindings in the settings window
				SettingsWindow.UpdateKeyBindings()

			-- is this an action with an hotkey in the settings
			elseif ActionsWindow.isAction(actionType) and ActionsWindow.ActionData[actionId] and ActionsWindow.ActionData[actionId].settingKeyBinding then
				
				-- getting the setting ID for the keybinding
				local setId = SettingsWindow.GetKeybindingIDByType(ActionsWindow.ActionData[actionId].settingKeyBinding)

				-- setting the hotkey inside the setting window
				SettingsWindow.Keybindings[setId].newValue = SystemData.RecordedKeySmallDisplay

				-- removing the hotkey from the hotbar slot
				SystemData.Hotbar[Hotbar.RecordingHotbar].Bindings[Hotbar.RecordingSlot] = L""
				SystemData.Hotbar[Hotbar.RecordingHotbar].BindingDisplayStrings[Hotbar.RecordingSlot] = L""

				-- update the keybinding in the character profile
				BroadcastEvent( SystemData.Events.KEYBINDINGS_UPDATED )

				-- updating the keybinding text graphics
				HotbarSystem.UpdateBinding(element,SystemData.RecordedKeySmallDisplay,SystemData.RecordedKey)

				-- update the keybindings in the settings window
				SettingsWindow.UpdateKeyBindings()

			else -- setting the hotkey to the hotbar slot
				SystemData.Hotbar[Hotbar.RecordingHotbar].Bindings[Hotbar.RecordingSlot] = SystemData.RecordedKey
				SystemData.Hotbar[Hotbar.RecordingHotbar].BindingDisplayStrings[Hotbar.RecordingSlot] = SystemData.RecordedKeySmallDisplay
				
				-- update the keybinding in the character profile
				BroadcastEvent( SystemData.Events.KEYBINDINGS_UPDATED )

				-- updating the keybinding text graphics
				HotbarUpdateBinding(Hotbar.RecordingHotbar, Hotbar.RecordingSlot, SystemData.RecordedKey)

				-- update the keybindings in the settings window
				HotbarSystem.UpdateBinding(element,SystemData.RecordedKeySmallDisplay,SystemData.RecordedKey)
			end
		end
	end
end

function Hotbar.KeyCancelRecord()
	
	-- turning off the key recording
	if Hotbar.RecordingKey == true then

		-- stop the recording
		Hotbar.RecordingKey = false

		-- hide the tooltip
		WindowSetShowing("AssignHotkeyInfo",false)
	end
end

function Hotbar.OnResizeBegin()
	local this = WindowUtils.GetActiveDialog()

	-- make sure the window exist
	if not DoesWindowExist(this) then
		return
	end

	-- getting the hotbar ID
	local hotbarId = WindowGetId(this)

	-- make sure the hotbar exist
	if not Hotbar.DoesHotbarExist(hotbarId, true) then
		return
	end

	-- is the hotbar locked?
	if not SystemData.Hotbar[hotbarId].Locked then

		-- getting the window dimensions
		local width, height = WindowGetDimensions(this)

		-- minimum width (1 slot + handle)
		local widthMin = 70
		local heightMin = 70

		-- vertical bar (slot size only)
		if (width >= height) then
			heightMin = 50

		else -- horizontal bar (slot size only)
			widthMin = 50
		end

		-- beginning the resize process
		WindowUtils.BeginResize( this, "topleft", widthMin, heightMin, false, Hotbar.OnResizeEnd)
	end
end

function Hotbar.OnResizeEnd(curWindow)

	-- make sure the window exist
	if not DoesWindowExist(curWindow) then
		return
	end

	-- getting the hotbar ID
	local hotbarId = WindowGetId(curWindow)

	-- make sure the hotbar exist
	if not Hotbar.DoesHotbarExist(hotbarId, true) then
		return
	end

	-- is the bar shrinked?
	if Hotbar.IsShrunken(hotbarId, true) then
		return
	end

	-- getting the current window dimensions
	local width, height = WindowGetDimensions(curWindow)
	
	-- is the bar locked?
	local locked = SystemData.Hotbar[hotbarId].Locked
	
	-- if is not locked we must add the handle offset
	local handleOffset = locked and 0 or Hotbar.HANDLE_OFFSET
	
	-- initialize the new width and height variable
	local newHeight, newWidth

	-- horizontal bar
	if (width > height) then
		
		-- clearing the anchors of the first button
		WindowClearAnchors(curWindow.."Button"..1)

		-- if the bar is locked we attach the first button to the window border
		if locked then
			WindowAddAnchor(curWindow.."Button"..1, "topleft", curWindow, "topleft", 0, 0)

		else -- if the bar is not locked the first button is attached to the handle

			WindowAddAnchor(curWindow.."Button"..1, "topright", curWindow.."HorizHandle", "topleft", 0, 0)
		end

		-- showing the first button
		WindowSetShowing(curWindow.."Button"..1, true)
		
		-- anchor the rest of the buttons to the previous one
		-- and hide the ones that are outside the window
		for slot = 2, Hotbar.NUM_BUTTONS do
			
			-- button window name
			local button = curWindow.."Button"..slot

			-- is the button out of the window size?
			if ((slot * Hotbar.BUTTON_SIZE) > (width + handleOffset)) then
				WindowSetShowing(button, false)

			else -- attaching the button to the previous one
				local relativeTo = curWindow.."Button"..(slot-1)
				WindowClearAnchors(button)
				WindowAddAnchor(button,"topright",relativeTo,"topleft",0,0)			
				WindowSetShowing(button, true)
			end
		end
		
		-- getting the number of visible slots
		local numVisibleButtons = math.min(math.floor((width + handleOffset) / Hotbar.BUTTON_SIZE), Hotbar.NUM_BUTTONS)

		-- fixing the height
		newHeight = Hotbar.BUTTON_SIZE

		-- fixing the width
		newWidth = math.min((numVisibleButtons * Hotbar.BUTTON_SIZE) + handleOffset, (Hotbar.BUTTON_SIZE * Hotbar.NUM_BUTTONS) + handleOffset)

		-- applying the new width and height
		WindowSetDimensions(curWindow, newWidth, newHeight)
		
	else -- vertical bar
	
		-- clearing the anchors of the first button
		WindowClearAnchors(curWindow.."Button"..1)

		-- if the bar is locked we attach the first button to the window border
		if locked then
			WindowAddAnchor(curWindow.."Button"..1,"topright",curWindow,"topright",0,0)

		else -- if the bar is not locked the first button is attached to the handle

			WindowAddAnchor(curWindow.."Button"..1,"bottomright",curWindow.."VertHandle","topright",0,0)
		end

		-- showing the first button
		WindowSetShowing(curWindow.."Button"..1, true)
		
		-- anchor the rest of the buttons to the previous one
		-- and hide the ones that are outside the window
		for slot = 2, Hotbar.NUM_BUTTONS do
			
			-- button window name
			local button = curWindow.."Button"..slot

			-- is the button out of the window size?
			if ((slot * Hotbar.BUTTON_SIZE) > (height + handleOffset)) then
				WindowSetShowing(button, false)

			else -- attaching the button to the previous one
				local relativeTo = curWindow.."Button"..(slot-1)
				WindowClearAnchors(button)
				WindowAddAnchor(button,"bottomleft",relativeTo,"topleft",0,0)			
				WindowSetShowing(button, true)
			end
		end

		-- getting the number of visible slots
		local numVisibleButtons = math.min(math.floor((height + handleOffset) / Hotbar.BUTTON_SIZE), Hotbar.NUM_BUTTONS)

		-- fixing the height
		newHeight = math.min((numVisibleButtons * Hotbar.BUTTON_SIZE) + handleOffset, (Hotbar.BUTTON_SIZE * Hotbar.NUM_BUTTONS) + handleOffset)

		-- fixing the width
		newWidth = Hotbar.BUTTON_SIZE

		-- applying the new width and height
		WindowSetDimensions(curWindow,newWidth,newHeight)		
	end

	-- fixing the hotbar textures
	Hotbar.FixHotbarOrientationItems(hotbarId, newWidth, newHeight)
end

function Hotbar.OnHandleLButDown(flags, x, y)

	-- get the hotbar ID
	local hotbarId = WindowGetId(WindowUtils.GetActiveDialog())

	-- make sure the hotbar exist
	if not Hotbar.DoesHotbarExist(hotbarId, true) then
		return
	end

	-- get the handle's hotbar window name
	local hotbarWindow = WindowGetParent(SystemData.ActiveWindow.name)

	-- if it's the pet controls bar or the mount blockbar it can't be moved
	if hotbarId ~= Interface.PetControlsBar and hotbarId ~= Interface.MountBlockbar then
			
		-- pressing ALT and drag, allows to move the hotbar and the all the nearest hotbars without snapping. It works even when it's locked
		if flags == WindowUtils.ButtonFlags.ALT and not WindowGetMoving(hotbarWindow) then
			Hotbar.InMovement = {}
			Hotbar.FindHotbarMovingBlock(hotbarWindow)
			WindowSetMoving(hotbarWindow, true)

			-- add the release timer for the hotbar
			Hotbar.JustReleased[hotbarWindow] = {}
			Hotbar.JustReleased[hotbarWindow].timer = 0

		-- moving the hotbar with snap active by default if it's not locked
		elseif not SystemData.Hotbar[hotbarId].Locked and not Interface.LoadSetting( hotbarWindow .. "LockWithHandle", false) then 

			SnapUtils.StartWindowSnap( hotbarWindow )
		end
	end

end

function Hotbar.OnHandleLButUp(flags, x, y)

	-- get the hotbar ID
	local hotbarId = WindowGetId(WindowGetParent(SystemData.ActiveWindow.name))
	
	-- make sure the hotbar exist
	if not Hotbar.DoesHotbarExist(hotbarId, true) then
		return
	end

	-- get the handle's hotbar window name
	local hotbarWindow = WindowGetParent(SystemData.ActiveWindow.name)

	-- set the hotbar to static if it was moving
	if WindowGetMoving(hotbarWindow) then
		WindowSetMoving(hotbarWindow, false)
	end

	-- if there is a group of hotbars moving, we must stop it
	if Hotbar.InMovement ~= nil then
		for windowName,_ in pairs(Hotbar.InMovement) do
			WindowSetMoving(windowName, false)
			Hotbar.InMovement[windowName] = nil
		end
	end
end

function Hotbar.ShrinkTooltip()
	local windowname = WindowUtils.GetActiveDialog()

	-- make sure the window exist
	if not DoesWindowExist(windowname) then
		return
	end

	-- get the hotbar id
	local hotbarId = WindowGetId(windowname)

	-- is the bar closed?
	-- lock/unlock tooltip
	if Hotbar.IsShrunken(hotbarId, true) then
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1155233))
	else
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1155234))
	end
	
	-- get the hotbar ID
	local hotbarId = WindowGetId(WindowUtils.GetActiveDialog())

	-- force the bar to show
	Hotbar.ShowBar("Hotbar" .. hotbarId)
end

function Hotbar.ShowBar(windowName)

	-- make sure the window exist
	if not DoesWindowExist(windowName) then
		return
	end

	-- stop the fading animation
	WindowStopAlphaAnimation(windowName)

	-- get the saved alpha value
	local alpha = Interface.LoadSetting( windowName.."ALP", -5 )

	-- setting the alpha value to the saved value
	if (alpha ~= nil and alpha ~= -5) then
		WindowSetAlpha(windowName, alpha)

	else -- making the window visible
		WindowSetAlpha(windowName, 1)
	end
end

function Hotbar.HandleMouseOver()

	-- handle window name
	local this = SystemData.ActiveWindow.name

	-- get the hotbar ID
	local hotbarId = WindowGetId(WindowUtils.GetActiveDialog())

	-- make sure the hotbar exist
	if not Hotbar.DoesHotbarExist(hotbarId, true) then
		return
	end

	-- show the hotbar
	Hotbar.ShowBar("Hotbar" .. hotbarId)
end

function Hotbar.HideBar(windowName)

	-- make sure the window exist
	if not DoesWindowExist(windowName) then
		return
	end

	-- is the bar autohide active?
	if Interface.LoadSetting( windowName.. "Fade", false) then
		
		-- get the saved alpha value
		local alpha = Interface.LoadSetting( windowName.."ALP", -5 )

		-- if there is no saved alpha value we set the starting point to 1
		if (alpha == nil or alpha == -5) then
			alpha = 1
		end

		-- start the fading animation
		WindowStartAlphaAnimation(windowName, Window.AnimationType.SINGLE_NO_RESET, alpha, 0.01, 2, false, 1, 1 )
	end
end

function Hotbar.SpecialLock()

	-- getting the current window name
	local windowname = WindowUtils.GetActiveDialog()
	
	-- make sure the window exist
	if not DoesWindowExist(windowname) then
		return
	end

	-- getting the saved width and height
	local width = Interface.LoadSetting( windowname .. "SizeW", 50 )
	local height = Interface.LoadSetting( windowname .. "SizeH", 50 )
	
	-- getting the current width and height
	local w,h = WindowGetDimensions(windowname)

	-- if the current width is greater than the saved one, we update the saved one. Same for height
	if w > width then
		width = w
	end
	if h > height then
		height = h
	end
	
	-- reset the context menu
	ContextMenu.CleanUp()

	-- close left to right
	if (not Interface.LoadSetting( windowname .. "LeftToRight", false )) then
		-- close right
		if (width > height) then
			ContextMenu.CreateLuaContextMenuItem({tid = 1154845, returnCode = "closeR", param = {wind = windowname, side = GetStringFromTid(1155245)}}) -- right

		else -- close bottom
			ContextMenu.CreateLuaContextMenuItem({tid = 1155236, returnCode = "closeR", param = {wind = windowname, side = GetStringFromTid(1155246)}}) -- bottom
		end

	else -- close right to left
		
		-- close left
		if (width > height) then
			ContextMenu.CreateLuaContextMenuItem({tid = 1154846, returnCode = "closeL", param = {wind=windowname, side =GetStringFromTid(1155247)}}) -- left

		else -- close top
			ContextMenu.CreateLuaContextMenuItem({tid = 1155238, returnCode = "closeL", param = {wind=windowname, side =GetStringFromTid(1155248)}}) -- top
		end
	end
	
	-- change handle color
	ContextMenu.CreateLuaContextMenuItem({tid = 1155239, returnCode = "HandleColor", param = {wind=windowname, side =L"HandleColor"}})
	
	-- reverse text
	ContextMenu.CreateLuaContextMenuItem({tid = 1155240, returnCode = "Reverse", param = {wind=windowname}, pressed = Interface.LoadSetting( windowname .. "ReverseText", false )})
	
	-- set hotbar text
	ContextMenu.CreateLuaContextMenuItem({tid = 1155241, returnCode = "SetText", param = {wind=windowname}})
	
	-- empty space
	ContextMenu.CreateLuaContextMenuItem(ContextMenu.EmptyLine)
	
	-- lock with handle
	if (not Interface.LoadSetting( windowname .. "LockWithHandle", false )) then
		ContextMenu.CreateLuaContextMenuItem({tid = 1111697, returnCode = "lock", param = {wind=windowname}})
	else
		ContextMenu.CreateLuaContextMenuItem({tid = 1111696, returnCode = "unlock", param = {wind=windowname}})
	end
	
	-- show the context menu
	ContextMenu.ActivateLuaContextMenu(Hotbar.ContextMenuCallbackLock)
end

function Hotbar.ContextMenuCallbackLock(returnCode, param)

	-- getting the window dimensions
	local windowname = param.wind

	-- make sure the window exist
	if not DoesWindowExist(windowname) then
		return
	end

	-- get the hotbar ID
	local hotbarId = WindowGetId(windowname)

	-- lock with handle
	if (returnCode=="lock") then
		Interface.SaveSetting( windowname .. "LockWithHandle", true )
		ChatWindow.Print(GetStringFromTid(1155242))

	-- unlock with handle
	elseif (returnCode=="unlock") then
		Interface.SaveSetting( windowname .. "LockWithHandle", false )
		ChatWindow.Print(GetStringFromTid(1155243))

	-- close right
	elseif (returnCode=="closeR") then
		Interface.SaveSetting( windowname .. "LeftToRight", true )
		ChatWindow.Print(ReplaceTokens(GetStringFromTid(1155244), { param.side }))
		pcall(Hotbar.SetMaxMinTextureID, hotbarId)

	-- close left
	elseif (returnCode=="closeL") then
		Interface.SaveSetting( windowname .. "LeftToRight", false )
		ChatWindow.Print(ReplaceTokens(GetStringFromTid(1155244), { param.side }))
		pcall(Hotbar.SetMaxMinTextureID, hotbarId)

	-- reverse text
	elseif (returnCode=="Reverse") then
		local stat = not Interface.LoadSetting( windowname .. "ReverseText", false )
		Interface.SaveSetting( windowname .. "ReverseText", stat )

	-- set bar text
	elseif (returnCode=="SetText") then
		local rdata = {title=GetStringFromTid(1077826), subtitle=GetStringFromTid(1155249), callfunction=Hotbar.SetText, id=windowname}
		RenameWindow.Create(rdata)

	-- pick handle color
	elseif (returnCode=="HandleColor") then	
	
		Hotbar.PickColor(param.side, windowname)
	end

	-- get the hotbar dimensions
	local width, height = WindowGetDimensions(windowname)
		
	-- update the texture elmennts
	Hotbar.FixHotbarOrientationItems(hotbarId, width, height)
end

function Hotbar.CreateNew(_, text)

	-- has the player entered only a single number?
	if tonumber(text) and not wstring.find(text, L"x", 1, true) then
		
		-- getting the number
		local slots = tonumber(text)

		-- if the number is greater than 12, we cap it to 12
		if slots > 12 then
			slots = 12
		end

		-- create the hotbar with the specified number of slots
		HotbarSystem.SpawnNewHotbar(_, slots)

	else -- the player specified rows and columns
		
		-- make sure there is an x to separate them
		if wstring.find(text, L"x", 1, true) then
			
			-- number of slots per bar
			local slots = tostring(wstring.sub(text, wstring.find(text, L"x", 1, true)+1, -1 ))
			
			-- convert to number
			slots = tonumber(slots)

			-- make sure is not nil
			if slots then

				-- if the number is greater than 12, we cap it to 12
				if slots > 12 then
					slots = 12
				end
				
				-- get the number of bars
				local bars = tostring(wstring.sub(text, 1, wstring.find(text, L"x", 1, true) - 1))

				-- convert to number
				bars = tonumber(bars)

				-- make sure is not nil
				if bars then

					-- if the number is greater than 12, we cap it to 12
					if bars > 12 then
						bars = 12
					end

					-- initialize prev bar id
					local prev = -1

					-- starting to spawn bars
					for i = 1, bars do

						-- getting the ID of the created bar
						local id = HotbarSystem.SpawnNewHotbar(_, slots)

						-- after spawning the first bar we start to anchor them to each other
						if i > 1 then
							
							-- bar name
							local barName = "Hotbar" .. id

							-- previous bar name
							local prevBarName = "Hotbar" .. prev

							-- anchoring to the previous one
							WindowClearAnchors(barName)
							WindowAddAnchor(barName,"bottomleft",prevBarName,"topleft",0,0)

							-- getting the screen position moving it there manually
							local x, y = WindowGetOffsetFromParent(barName)
							WindowClearAnchors(barName)
							WindowSetOffsetFromParent(barName, x,y)
						end

						-- saving the ID of the previous bar
						prev = id
					end

					ChatPrint(GetStringFromTid(293), SystemData.ChatLogFilters.SYSTEM)
				end
			end
		end
	end
end

function Hotbar.SetText(windowname, text)

	-- make sure the window exist
	if not DoesWindowExist(windowName) then
		return
	end

	-- save the text
	Interface.SaveSetting( windowname .. "CustomText", text )

	-- setting up the text on the bar
	LabelSetText(windowname .. "NameH", text)
	LabelSetText(windowname .. "NameV", text)
	LabelSetText(windowname .. "NameVrev", text)
	LabelSetText(windowname .. "NameHrev", text)
end

function Hotbar.PickColor(color, windowname)
	
	-- make sure the window exist
	if not DoesWindowExist(windowname) then
		return
	end

	-- setting the window name
	Hotbar.CurrentChangeColorWindow = windowname

	-- default colors table
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

	-- initializing hue array
	local hueTable = {}

	-- loading the hue table
	for idx, hue in pairs(defaultColors) do
		for i=0,8 do
			hueTable[(idx-1)*10+i+1] = hue+i
		end
	end

	-- setting the brightness value
	local Brightness = 1

	-- creating the color picking window
	CreateWindowFromTemplate( "ColorPicker", "ColorPickerWindowTemplate", "Root" )
	WindowSetLayer( "ColorPicker", Window.Layers.SECONDARY	)

	-- loading the colors to the window
	ColorPickerWindow.SetNumColorsPerRow(9)
	ColorPickerWindow.SetSwatchSize(30)
	ColorPickerWindow.SetWindowPadding(4,4)
	ColorPickerWindow.SetFrameEnabled(true)
	ColorPickerWindow.SetCloseButtonEnabled(true)
	ColorPickerWindow.SetColorTable(hueTable,"ColorPicker")
	ColorPickerWindow.DrawColorTable("ColorPicker")
	ColorPickerWindow.SetAfterColorSelectionFunction(Hotbar.ColorPicked)

	-- positioning the window
	local w, h = WindowGetDimensions("ColorPicker")
	WindowAddAnchor( "ColorPicker", "center", "Root", "center", 0, 0)

	-- disabling the frame
	ColorPickerWindow.SetFrameEnabled(false)

	--- showing the window
	WindowSetShowing( "ColorPicker", true )

	-- highlight the first color
	ColorPickerWindow.SelectColor("ColorPicker", 1)
end

function Hotbar.ColorPicked()
	
	-- get the selected hue
	local huePicked = ColorPickerWindow.colorSelected["ColorPicker"]
	
	-- initialize the color array
	local color = {}
	
	-- get the rgb from the hue
	color.r, color.g, color.b = HueRGBAValue(huePicked)

	-- save the color
	Interface.SaveSetting(Hotbar.CurrentChangeColorWindow .. "HandleColor",color)

	-- coloring the handle
	WindowSetTintColor(Hotbar.CurrentChangeColorWindow .. "HorizHandle", color.r, color.g, color.b)
	WindowSetTintColor(Hotbar.CurrentChangeColorWindow .. "VertHandle", color.r, color.g, color.b)

	-- coloring the text
	LabelSetTextColor(Hotbar.CurrentChangeColorWindow .. "NameH", color.r, color.g, color.b)
	LabelSetTextColor(Hotbar.CurrentChangeColorWindow .. "NameV", color.r, color.g, color.b)
	LabelSetTextColor(Hotbar.CurrentChangeColorWindow .. "NameVrev", color.r, color.g, color.b)
	LabelSetTextColor(Hotbar.CurrentChangeColorWindow .. "NameHrev", color.r, color.g, color.b)

	-- destroying the color picking window
	DestroyWindow("ColorPicker")
end

function Hotbar.ShrinkBDown(flags)

	-- get the window name
	local windowName = WindowUtils.GetActiveDialog()

	-- make sure the window exist
	if not DoesWindowExist(windowName) then
		return
	end

	-- get the hotbar id
	local hotbarId = WindowGetId(windowName)

	-- is the hotbar already closed?
	if not Hotbar.IsShrunken(hotbarId, true) then
		
		-- close the hotbar
		Hotbar.Shrink(windowName)

		-- if alt is pressed, we shrink the whole hotbars group
		if flags == WindowUtils.ButtonFlags.ALT then
			Hotbar.FindHotbarShrinkBlock(windowName)
		end

	else -- open the closed hotbar
		Hotbar.Enlarge(windowName)

		-- if alt is pressed, we enlarge the whole hotbars group
		if flags == WindowUtils.ButtonFlags.ALT then
			Hotbar.FindHotbarEnlargeBlock(windowName)
		end
	end
end

function Hotbar.Shrink(hotbar, loading)

	-- make sure the window exist
	if not DoesWindowExist(hotbar) then
		return
	end

	-- get the hotbar ID
	local hotbarId = WindowGetId(hotbar)

	-- does the hotbar exst?
	if not Hotbar.DoesHotbarExist(hotbarId, true) then
		return
	end

	-- is the bar already close or are we loading the UI?
	if Hotbar.IsShrunken(hotbarId, true) and not loading then
		return
	end

	-- get the hotbar dimension
	local width, height = WindowGetDimensions(hotbar)

	-- if the UI is loding we make sure we load the size first (or we lose it)
	if loading then
		width = Interface.LoadSetting( hotbar .. "SizeW", width )
		height = Interface.LoadSetting( hotbar .. "SizeH", height )
	end

	-- saving the bar size before closing it
	Interface.SaveSetting( hotbar .. "SizeW", width )
	Interface.SaveSetting( hotbar .. "SizeH", height )

	-- getting the bar position
	local x, y = WindowGetOffsetFromParent(hotbar)

	-- setting the closed flag
	Interface.SaveSetting( hotbar.. "Closed", true )
	
	-- horizontal bar
	if (width > height) then
		
		-- we se the dimension to the handle dimension
		WindowSetDimensions(hotbar, 20, 50)

		-- if the hotbar closes the opposite way, we must move the handle
		if (Interface.LoadSetting( hotbar .. "LeftToRight", false ) and Interface.started) then
			if (WindowGetAnchorCount(hotbar) > 0) then
				WindowClearAnchors(hotbar)
			end
			WindowSetOffsetFromParent(hotbar, (x + (width - 20)), y)
		end
		
	else -- vertical bar

		-- we se the dimension to the handle dimension
		WindowSetDimensions(hotbar, 50, 20)

		-- if the hotbar closes the opposite way, we must move the handle
		if (Interface.LoadSetting( hotbar .. "LeftToRight", false ) and Interface.started) then
			if (WindowGetAnchorCount(hotbar) > 0) then
				WindowClearAnchors(hotbar)
			end
			WindowSetOffsetFromParent(hotbar, x, (y + (height - 20)))
		end
	end
	
	-- we hide all the buttons
	for slot = 1, Hotbar.NUM_BUTTONS do
		local button = hotbar.."Button"..slot
		WindowSetShowing(button, false)
	end

	-- update the textures
	pcall(Hotbar.FixHotbarOrientationItems, hotbarId)
end

function Hotbar.Enlarge(hotbar)

	-- make sure the window exist
	if not DoesWindowExist(hotbar) then
		return
	end

	-- get the hotbar ID
	local hotbarId = WindowGetId(hotbar)

	-- does the hotbar exst?
	if not Hotbar.DoesHotbarExist(hotbarId, true) then
		return
	end
	
	-- if the hotbar is not closed there is no need for enlarging
	if not Hotbar.IsShrunken(hotbarId, true) then
		return
	end

	-- loading the saved window size
	local width = Interface.LoadSetting( hotbar .. "SizeW", 50 )
	local height = Interface.LoadSetting( hotbar .. "SizeH", 50 )

	-- getting the bar position
	local x, y = WindowGetOffsetFromParent(hotbar)

	-- setting the closed flag
	Interface.SaveSetting( hotbar.. "Closed", false )

	-- redimensioning the window to its original size
	WindowSetDimensions(hotbar, width, height)

	-- horizontal bar	
	if (width > height) then
		
		-- if the hotbar closes the opposite way, we must move the handle
		if (Interface.LoadSetting( hotbar .. "LeftToRight", false ) and Interface.started) then
			if (WindowGetAnchorCount(hotbar) > 0) then
				WindowClearAnchors(hotbar)
			end
			WindowSetOffsetFromParent(hotbar, (x - (width -20)), y)
		end

	else -- vertical bar

		-- if the hotbar closes the opposite way, we must move the handle
		if (Interface.LoadSetting( hotbar .. "LeftToRight", false ) and Interface.started) then
			if (WindowGetAnchorCount(hotbar) > 0) then
				WindowClearAnchors(hotbar)
			end
			WindowSetOffsetFromParent(hotbar, x, (y - (height - 20)))
		end
	end
	
	Hotbar.OnResizeEnd(hotbar)
end

function Hotbar.RelaodAll()
	-- reload all hotbars
	for index, hotbarId in pairs(SystemData.Hotbar.HotbarIds) do	
		Hotbar.ReloadHotbar(hotbarId)
	end
end

function Hotbar.ShrinkALL()
	-- shrink all hotbars
	for index, hotbarId in pairs(SystemData.Hotbar.HotbarIds) do	
		local windowname = "Hotbar"..hotbarId
		Hotbar.Shrink(windowname)
	end
end

function Hotbar.EnlargeALL()
	-- enlarge all hotbars
	for index, hotbarId in pairs(SystemData.Hotbar.HotbarIds) do	
		local windowname = "Hotbar"..hotbarId
		Hotbar.Enlarge(windowname)
	end
end

function Hotbar.IsShrunken(hotbarId, noAlphaCheck)

	-- getting the window name
	local windowname = "Hotbar"..hotbarId

	-- make sure the hotbar window exist
	if not DoesWindowExist(windowname) then
		return
	end

	-- button window name
	local button = windowname.."Button1"

	-- shrinked flag
	local closed = Interface.LoadSetting( windowname .. "Closed", false )

	-- making sure the button is visible
	local firstButtonVisible =  WindowGetShowing(button)

	if closed and firstButtonVisible and Interface.started then
		Interface.SaveSetting( windowname .. "Closed", false )
	end

	-- if we don't have to check for faded hotbars, then we can just return the flag value
	if noAlphaCheck then
		return closed

	else -- hotbars with less than 50% transparency can be considered hidden
		return WindowGetAlpha(windowname) <= 0.5 or closed
	end
end

function Hotbar.PetControlsSnap(forced)
	
	-- is the interface started?
	if Interface.started and Interface.PetControlsBar then

		-- pet controls hotbar
		local hotbar = "Hotbar" .. Interface.PetControlsBar

		-- if there are no pets we shrink the bar
		if WindowData.PlayerStatus["Followers"] == 0 then
			Hotbar.Shrink(hotbar)

		else 
			-- initialize the visible pet variable
			local visiblePets = GetControllableFollowersCount()
			
			-- do we have visible pets?
			if visiblePets > 0 then
			
				-- if we have 1 or more pets we enlarge the bar
				Hotbar.Enlarge(hotbar)

				-- get the hotbar dimensions
				local w, h = WindowGetDimensions(hotbar)

				-- are the dimensions already correct?
				if w ~= Hotbar.BUTTON_SIZE * 5 or h ~= Hotbar.BUTTON_SIZE then

					-- making sure that the blockbar is still a 1x5 hotbar
					WindowSetDimensions(hotbar, Hotbar.BUTTON_SIZE * 5, Hotbar.BUTTON_SIZE )
				end

				-- scanning the 5 slot of the hotbar
				for slot = 1, 5 do
				
					-- button window name
					local button = hotbar.."Button"..slot

					-- making sure the button is visible
					if not WindowGetShowing(button) then
						WindowSetShowing(button, true)
					end
				end

			else -- since we have no pets in sight we shrink the bar
				Hotbar.Shrink(hotbar)
			end
		end

		-- get the pet window name
		local petWindowVisible, petWindow = MobileBarsDockspot.GetPetDockspotStatus()

		-- is the visibility changed?
		if petWindowVisible ~= WindowGetShowing(hotbar) then
			
			-- if the pet window is not showing we hide the pet controls too
			WindowSetShowing(hotbar, petWindowVisible)
		end

		-- are the buttons visible?
		if WindowGetShowing(hotbar .. "MinimizeButtonH") or WindowGetShowing(hotbar .. "MaximizeButtonH") or WindowGetShowing(hotbar .. "HorizHandle") or WindowGetShowing(hotbar .. "VertHandle") then

			-- hiding maximize, minimize and handles (not needed for this bar)
			WindowSetShowing(hotbar .. "MinimizeButtonH", false)
			WindowSetShowing(hotbar .. "MaximizeButtonH", false)
			WindowSetShowing(hotbar .. "HorizHandle", false)
			WindowSetShowing(hotbar .. "VertHandle", false)
		end

		-- moving the bar with the pet window
		if petWindowVisible and MobileBarsDockspot.Dockspots[petWindow].hasBeenMoved then

			-- force the pet controls bar to follow the pet window
			WindowForceProcessAnchors(hotbar)

			-- get the pet window scale
			local petWindowScale = WindowGetScale(petWindow)

			-- get the pet controls bar scale
			local petControlsScale = WindowGetScale(hotbar)

			-- make sure the pet controls bar and the pet window have the same scale
			if petControlsScale ~= petWindowScale + Hotbar.PetControlBar_ScaleDifference then

				-- scale the pet controls bar
				WindowSetScale(hotbar, petWindowScale - Hotbar.PetControlBar_ScaleDifference)
			end

			-- get the pet controls bar anchors
			local point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor(hotbar, 1)

			-- does the pet bar closes left?
			if (forced and MobileBarsDockspot.Dockspots[petWindow].closeLeft) or (MobileBarsDockspot.Dockspots[petWindow].closeLeft and relativePoint ~= "right") then

				-- reset the pet controls bar anchors
				WindowClearAnchors(hotbar)

				-- anchor to the right
				WindowAddAnchor(hotbar, "right", petWindow, "left", Hotbar.PetControlBar_Shift_X, 1)

			 -- if it closes right, we anchor to the left
			elseif (forced and not MobileBarsDockspot.Dockspots[petWindow].closeLeft) or (not MobileBarsDockspot.Dockspots[petWindow].closeLeft and relativePoint ~= "left") then
				
				-- reset the pet controls bar anchors
				WindowClearAnchors(hotbar)

				-- anchor to the left
				WindowAddAnchor(hotbar, "left", petWindow, "right", Hotbar.PetControlBar_Shift_X, 1)
			end
		end
	end
end

function Hotbar.DoesHotbarExist(hotbarId, windowCheck)
	
	-- verify the hotbar id is valid
	if not IsValidID(hotbarId) then
		return false
	end

	-- we must check if the window exist and that the hotbar is registered
	if windowCheck then
		local hotbar = "Hotbar"..hotbarId
		return DoesWindowExist(hotbar) == true and SystemData.Hotbar[hotbarId] ~= nil

	else -- if is not a registered hotbar, it doesnt exist
		return SystemData.Hotbar[hotbarId] ~= nil
	end
end

function Hotbar.HotbarLoadCustomText(hotbarId)
	
	-- make sure the hotbar exist
	if not Hotbar.DoesHotbarExist(hotbarId, true) then
		return
	end

	-- hotbar window name
	local hotbar = "Hotbar"..hotbarId

	-- loading the saved text
	local text = Interface.LoadSetting( hotbar .. "CustomText", L"" )
	
	-- setting the text to the labels (all directions and shape)
	LabelSetText(hotbar .. "NameH", text)
	LabelSetText(hotbar .. "NameV", text)
	LabelSetText(hotbar .. "NameVrev", text)
	LabelSetText(hotbar .. "NameHrev", text)
end

-- return the hotbar orientation and the number of slots
function Hotbar.GetHotbarOrientation(hotbarId, newWidth, newHeight)
	
	-- make sure the hotbar exist
	if not Hotbar.DoesHotbarExist(hotbarId, true) then
		return
	end

	-- hotbar window name
	local hotbar = "Hotbar"..hotbarId

	-- first we get the width, hight
	local width, height = WindowGetDimensions(hotbar)
	
	if not newWidth and not newHeight then

		-- if we have saved values we have to get them because they are the correct ones
		width = Interface.LoadSetting( hotbar .. "SizeW", width )
		height = Interface.LoadSetting( hotbar .. "SizeH", height )

	else -- using the new values
		width = newWidth
		height = newHeight
		
	end
	
	-- if the width is small than the height then we have a vertical hotbar
	if (width < height) then
		return Hotbar.VERTICAL_DIRECTION
	else
		return Hotbar.HORIZONTAL_DIRECTION
	end
end

-- toggle visibility of the basic hotbar elements based on orientation
function Hotbar.FixHotbarOrientationItems(hotbarId, newWidth, newHeight)

	-- make sure the hotbar exist
	if not Hotbar.DoesHotbarExist(hotbarId, true) then
		return
	end

	-- hotbar window name
	local hotbar = "Hotbar"..hotbarId

	-- is this a blockbar?
	local isBlockbar = Interface.LoadSetting("Hotbar" .. hotbarId .. "_IsBlockbar", false)

	-- blockbar don't use most of the other stuff so we just take a shortcut
	if isBlockbar then
		WindowSetShowing(hotbar .. "MinimizeButtonH", false)
		WindowSetShowing(hotbar .. "MaximizeButtonH", false)

		WindowSetShowing(hotbar .. "MinimizeButtonV", false)
		WindowSetShowing(hotbar .. "MaximizeButtonV", false)

		WindowSetShowing(hotbar.."VertHandle", false )
		WindowSetShowing(hotbar.."HorizHandle", false )

		-- resize button
		WindowSetShowing(hotbar .."ResizeButton", false)

		return
	end

	-- getting the current orientation by setting an horizontal flag for quick parsing
	local horiz = Hotbar.GetHotbarOrientation(hotbarId, newWidth, newHeight) == Hotbar.HORIZONTAL_DIRECTION

	-- is the hotbar locked?
	local locked = SystemData.Hotbar[hotbarId].Locked

	-- does the hotbar have reverse texxt?
	local isTextReversed = Interface.LoadSetting( hotbar .. "ReverseText", false )

	-- is the hotbar locked with the handle visibile?
	local lockedWithHandle = Interface.LoadSetting( hotbar .. "LockWithHandle", false )

	-- is the hotbar closed?
	local closed = Hotbar.IsShrunken(hotbarId, true)

	-- showing the button for resizing?
	local showResizeButton = not lockedWithHandle and not locked and not closed

	-- now we start to toggle the visibility --

	-- loading handle color
	local color = Interface.LoadSetting(hotbar .. "HandleColor", {r=153,g=153,b=153})

	WindowSetTintColor(hotbar .. "HorizHandle", color.r, color.g, color.b)
	WindowSetTintColor(hotbar .. "VertHandle", color.r, color.g, color.b)

	-- setting custom text label at the same color of the handle
	LabelSetTextColor(hotbar .. "NameH", color.r, color.g, color.b)
	LabelSetTextColor(hotbar .. "NameV", color.r, color.g, color.b)
	LabelSetTextColor(hotbar .. "NameVrev", color.r, color.g, color.b)
	LabelSetTextColor(hotbar .. "NameHrev", color.r, color.g, color.b)

	-- handles visibility: showing if not locked
	WindowSetShowing(hotbar.."VertHandle", (not horiz and not locked) )
	WindowSetShowing(hotbar.."HorizHandle", (horiz and not locked) )

	-- pet control bar has no minimize and not maximize
	if Interface.PetControlsBar == hotbarId then
		WindowSetShowing(hotbar .. "MinimizeButtonH", false)
		WindowSetShowing(hotbar .. "MaximizeButtonH", false)

		WindowSetShowing(hotbar .. "MinimizeButtonV", false)
		WindowSetShowing(hotbar .. "MaximizeButtonV", false)
	else
		-- loading the minimize/maximize button textures
		pcall(Hotbar.SetMaxMinTextureID, hotbarId)

		-- setting the minimize/maximize button visibility (not showing for locked bars)
		WindowSetShowing(hotbar .. "MaximizeButtonV" , (not horiz and closed and not locked) )
		WindowSetShowing(hotbar .. "MaximizeButtonH" , (horiz and closed and not locked) )
		
		WindowSetShowing(hotbar .. "MinimizeButtonV" , (not horiz and not closed and not locked) )
		WindowSetShowing(hotbar .. "MinimizeButtonH" , (horiz and not closed and not locked) )
	end
	
	-- resize button
	WindowSetShowing(hotbar .."ResizeButton", showResizeButton)

	-- custom text elements
	if isTextReversed then
		
		-- hiding straight text
		WindowSetShowing(hotbar .. "NameV", false)
		WindowSetShowing(hotbar .. "NameH", false)

		-- showing reverse text based on orientation
		WindowSetShowing(hotbar .. "NameVrev", not horiz)
		WindowSetShowing(hotbar .. "NameHrev", horiz)
	
	else
		 -- hiding reverse text
		WindowSetShowing(hotbar .. "NameVrev", false)
		WindowSetShowing(hotbar .. "NameHrev", false)

		-- showing straight text based on orientation
		WindowSetShowing(hotbar .. "NameV", not horiz)
		WindowSetShowing(hotbar .. "NameH", horiz)
	end
end

function Hotbar.SetMaxMinTextureID(hotbarId)

	-- make sure the hotbar exist
	if not Hotbar.DoesHotbarExist(hotbarId, true) then
		return
	end
	
	-- hotbar window name
	local hotbar = "Hotbar"..hotbarId

	-- hotbar orientation
	local orient = Hotbar.GetHotbarOrientation(hotbarId)

	-- button element name
	local buttonMax, buttonMin
	if orient == Hotbar.HORIZONTAL_DIRECTION then
		buttonMax = hotbar .. "MaximizeButtonH"
		buttonMin = hotbar .. "MinimizeButtonH"

	else
		buttonMax = hotbar .. "MaximizeButtonV"
		buttonMin = hotbar .. "MinimizeButtonV"
	end

	-- determine the closing direction
	local leftToRight = Interface.LoadBoolean( hotbar .. "LeftToRight", false )

	-- if it's closed we need to invert the arrow
	if Hotbar.IsShrunken(hotbarId, true)  then
		leftToRight = not leftToRight
	end

	-- assign a numeric value to "left to right" and "right to left" for the array
	if leftToRight then
		leftToRight = Hotbar.LEFT_TO_RIGHT
	else
		leftToRight = Hotbar.RIGHT_TO_LEFT
	end

	-- getting the array record based on what we know
	local maximize = Hotbar.MaximizeButtonTextures[orient][leftToRight]
	local minimize = Hotbar.MinimizeButtonTextures[orient][leftToRight]

	-- we assign the texture per each state
	for _, state in pairs(InterfaceCore.ButtonStates) do

		-- verify that we have that texture in the array
		if not maximize[state] then
			continue
		end

		-- loading the record for the current state
		local currMax = maximize[state]
		local currMin = minimize[state]

		-- assigning the texture data
		ButtonSetTexture(buttonMax, state, currMax.texture, currMax.x, currMax.y)
		ButtonSetTexture(buttonMin, state, currMax.texture, currMax.x, currMax.y)
	end
end

function Hotbar.IsSlotEnabled(hotbarId, slot)

	-- make sure the hotbar exist and the ids are valids
	if not Hotbar.DoesHotbarExist(hotbarId, true) or not IsValidID(slot) then
		return
	end

	-- disabled slot window name
	local element = "Hotbar"..hotbarId.."Button"..slot.."Disabled"

	-- if the window doesn't exist or is hidden, then the slot is enabled
	return not DoesWindowExist(element) or not WindowGetShowing(element)
end

function Hotbar.IsAMouseOverTarget(slotWindow, targetType)

	-- is a target mouse over?
	if HotbarSystem.TargetMouseOver and HotbarSystem.TargetMouseOver[slotWindow] then
			
		-- target mouse over are saved as target stored
		if targetType == SystemData.Hotbar.TargetType.TARGETTYPE_OBJECT_ID then
			return SystemData.Hotbar.TargetType.TARGETTYPE_MOUSEOVER

		-- the target type has changed and the array was not updated correctly, we must remove it from the array
		else
			HotbarSystem.TargetMouseOver[slotWindow] = nil

		end
	end
	return targetType
end

function Hotbar.TargetTypeToWStringName(targetType)

	if targetType == SystemData.Hotbar.TargetType.TARGETTYPE_SELF then
		return GetStringFromTid(HotbarSystem.TID_SELF)

	elseif targetType == SystemData.Hotbar.TargetType.TARGETTYPE_CURRENT then
		return GetStringFromTid(HotbarSystem.TID_CURRENT)

	elseif targetType == SystemData.Hotbar.TargetType.TARGETTYPE_CURSOR then
		return GetStringFromTid(HotbarSystem.TID_CURSOR)

	elseif targetType == SystemData.Hotbar.TargetType.TARGETTYPE_OBJECT_ID then
		return GetStringFromTid(HotbarSystem.TID_OBJECT_ID)

	elseif targetType == SystemData.Hotbar.TargetType.TARGETTYPE_MOUSEOVER then
		return GetStringFromTid(280)

	end

	-- Bad case... forget about it.
	return L""
end

function Hotbar.GetDisabledInfoArray(abilityId, actionType, targetType, detailType, slotWindow)
	
	-- is a valid action ID?
	if not IsValidID(abilityId) then 
		return
	end

	-- does the slot exist?
	if not IsValidString(slotWindow) or not DoesWindowExist(slotWindow) then
		return
	end

	-- disabled slot name
	local disabledSlot = slotWindow.."Disabled"

	-- getting all we can from CSV
	local icon, serverId, tid, desctid, reagents, powerword, tithingcost, minskill, manacost  = GetAbilityData(abilityId)

	-- getting the name string from TID
	local name = GetStringFromTid(tid)

	-- initialize description variable
	local desc = L""
				
	-- if we have the description TID, we add it as extended description
	if (detailType ~= ItemProperties.DETAIL_SHORT) and desctid then
		desc = GetStringFromTid(desctid) .. L"\n\n"
	end	
		
	-- weapon abilities problems
	if (actionType == SystemData.UserAction.TYPE_WEAPON_ABILITY) then
			
		-- determining if the ability can be used, and if not the reason why
		local canUse, reason, mana = AbilitiesInfo.AbilityEnabled(serverId) 

		-- can we use the ability?
		if not canUse then
				
			-- getting the TID reason
			local TID = AbilitiesInfo.DisabledReasonTID[reason]

			-- is the TID valid?
			if IsValidID(TID) then

				if mana then
					-- adding the text to the description + the special token returned
					desc = desc .. ReplaceTokens(GetStringFromTid(TID), {towstring(mana)}) .. L"\n"

				else
					-- adding the text to the description
					desc = desc .. GetStringFromTid(TID) .. L"\n"
				end
			end
		end
			
	-- spells problems
	elseif (actionType == SystemData.UserAction.TYPE_SPELL) then

		-- determining if the ability can be used, and if not the reason why
		local canUse, reason, mana = SpellsInfo.SpellEnabled(abilityId, targetType)

		-- can we use the ability?
		if not canUse then
				
			-- getting the TID reason
			local TID = SpellsInfo.DisabledReasonTID[reason]

			-- is the TID valid?
			if IsValidID(TID) then

				if mana then
					-- adding the text to the description + the special token returned
					desc = desc .. ReplaceTokens(GetStringFromTid(TID), {towstring(mana)}) .. L"\n"

				else
					-- adding the text to the description
					desc = desc .. GetStringFromTid(TID) .. L"\n"
				end
			end
		end
	end

	-- creating the item properties array (we still have to add: windowname, itemloc, itemId, binding and target info )
	local itemData = { 
						detail = detailType,
						itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
						title =	name,
						body = desc
					}

	return itemData
end