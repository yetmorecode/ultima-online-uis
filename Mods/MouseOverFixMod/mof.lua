----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

mof = {}

mof.lastUpdate = 0
mof.originalUpdateFn = 0

mof.mouseX = 0
mof.mouseY = 0

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function hookUpdateFn()
	mof.mouseX = SystemData.MousePosition.x
	mof.mouseY = SystemData.MousePosition.y
	mof.originalUpdateFn()
end

function mof.Initialize()
	Debug.PrintToChat(L"Loading publish 86 mouse-over EC workaround..")
	
	-- Hook ItemProperties.UpdateItemPropertiesData
	mof.originalUpdateFn = ItemProperties.UpdateItemPropertiesData 
	ItemProperties.UpdateItemPropertiesData = hookUpdateFn
	
	Debug.PrintToChat(L"Successfully loaded! Please remove this mod after the issue is fixed!")
end

function mof.Update(updateTimePassed)
	-- In publish 86 the properties window is not properly closed
	-- when hovering over world objects. Internally the client seems
	-- to loose mouse-out events for world objects, leaving him in a state
	-- thinking we are still hovering the item while the mouse has
	-- long moved out.
	--
	-- This fix just checks whether the mouse has moved or not in a certain time frame.
	-- If the mouse has moved the proterties window is closed manually, thus correcting
	-- the client state.
	if WindowData.ItemProperties.CurrentHover ~= 0 then
		if mof.lastUpdate > 0.15 then
			local curX = SystemData.MousePosition.x
			local curY = SystemData.MousePosition.y
		
			if curX ~= mof.mouseX or curY ~= mof.mouseY then
				mof.lastUpdate = 0
				ItemProperties.ClearMouseOverItem()	
			end
		else
			mof.lastUpdate = mof.lastUpdate + updateTimePassed
		end
	end
end
