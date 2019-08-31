----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

TrackingPointer = {}

TrackingPointer.TrackWaypoints = {}

function TrackingPointer.OnInitialize()

	-- current pointer window name
	local windowName = SystemData.ActiveWindow.name

	-- attach the update event to the pointer
	WindowRegisterEventHandler(windowName, SystemData.Events.UPDATE_TRACKING_POINTER, "TrackingPointer.Update")
end

function TrackingPointer.OnShutdown()
	
	-- current pointer window name
	local windowName = SystemData.ActiveWindow.name

	-- get the current window ID
	local windowId = WindowGetId(windowName)

	-- detach the update event from the pointer
	WindowUnregisterEventHandler(windowName, SystemData.Events.UPDATE_TRACKING_POINTER)
	
	-- remove the pointer data
	SystemData.TrackingPointer[windowId] = nil

	-- current index of the waypoint
	local currentId

	-- scan the tracking waypoints
	for i, data in pairs(TrackingPointer.TrackWaypoints) do

		-- is this the waypoint to remove?
		if data.mobileId == windowId then

			-- remove the pointer waypoint
			table.remove(TrackingPointer.TrackWaypoints, i)	

			-- store the index
			currentId = i

			break
		end
	end

	-- was the compass used for tracking?
	if MapWindow.MagnetPoint.tracking then

		if #TrackingPointer.TrackWaypoints == 0 then

			-- close the compass
			MapWindow.CloseCompass()

		else -- switch target

			-- increase the current tracking ID
			MapWindow.MagnetPoint.trackingId = currentId

			-- if we reached the last target we cycle back to the first
			if MapWindow.MagnetPoint.trackingId > #TrackingPointer.TrackWaypoints then
				MapWindow.MagnetPoint.trackingId = 1
			end

			-- get the target data
			local data = TrackingPointer.TrackWaypoints[MapWindow.MagnetPoint.trackingId]

			-- change the x/y coordinates and the mobile id (the facet and the rest is always the same)
			MapWindow.MagnetPoint.x = data.x
			MapWindow.MagnetPoint.y = data.y
			MapWindow.MagnetPoint.mobileID = data.mobileId
		end
	end
end

function TrackingPointer.Update()

	-- current pointer window name
	local windowName = SystemData.ActiveWindow.name

	-- get the current window ID
	local windowId = WindowGetId(windowName)

	-- get the pointer data
	local pointerData = SystemData.TrackingPointer[windowId]

	-- get the current player facet
	local facet = WindowData.PlayerLocation.facet

	-- do we have a valid target?
	if IsValidID(windowId) and windowId ~= GetPlayerID() then

		-- get the current area
		local area = MapCommon.GetAreaID(pointerData.PointerX, pointerData.PointerY, facet)

		-- tokuno dungeon flag
		if facet == 4 and area > 0 then
			flag = "DUNG"
		end

		-- abyss dungeon flag
		if facet == 5 and area == 1 then
			flag = "ABYSS"
		end

		-- champions areas in ter mur that should be in felucca
		if facet == 5 and (area == 2 or area == 7) then
			facet = 0
		end

		-- get the mobile name
		local name = wstring.trim(GetMobileName(windowId))

		-- if we don't have the mobile name, we use a generic "Tracked Target"
		if not IsValidWString(name) then
			name = GetStringFromTid(1155436) -- tracked target
		end

		-- create wp data
		local wp = { mobileId = windowId, facet = facet, x = pointerData.PointerX, y = pointerData.PointerY, z = 0, type = MapCommon.WaypointCustomType, name = name, Icon = 100118, Scale = 0.65 }

		-- flag that indicates if we have the waypoint already or not
		local found

		-- scan the current waypoints to know if it's already in the list
		for i, data in pairs(TrackingPointer.TrackWaypoints) do
			
			-- do we have the waypoint already?
			if data.mobileId == windowId then
				
				-- update the waypoints data
				TrackingPointer.TrackWaypoints[i] = wp

				-- flag that we have found the waypoint
				found = true

				break
			end
		end

		-- do we have the waypoint listed already?
		if not found then

			-- store/update the waypoint
			table.insert(TrackingPointer.TrackWaypoints, wp)

			-- sort the table by distance
			TrackingPointer.SortByDistance()

			-- is the compass off or not tuned to tracking?
			if not MapWindow.MagnetPoint.x or not MapWindow.MagnetPoint.tracking then
			
				-- magnetize the compass to the target
				MapWindow.MagnetizeLocation(pointerData.PointerX, pointerData.PointerY, facet, nil, windowId)

				-- flag that the magnet point is used for tracking
				MapWindow.MagnetPoint.tracking = true

				-- current tracking target ID
				MapWindow.MagnetPoint.trackingId = 1
			end

		-- is the compass magnetized on this target?
		elseif MapWindow.MagnetPoint.mobileID == windowId then
			
			-- update the target coordinates
			MapWindow.MagnetPoint.x = pointerData.PointerX
			MapWindow.MagnetPoint.y = pointerData.PointerY
			MapWindow.MagnetPoint.facet = facet
		end
	end

	-- keep the pointer invisible (since we can't prevent the creation...)
	WindowSetShowing(windowName, false)
end

function TrackingPointer.SortByDistance()
	
	-- sort the array by distance
	local pos = 2
	while pos <= #TrackingPointer.TrackWaypoints do
		
		-- we can't stay at position 1 because we need to compare the previous element (that at 1 we don't have)
		if pos == 1 then
			pos = pos + 1
			continue
		end

		-- get current element location
		local wx = TrackingPointer.TrackWaypoints[pos].x
		local wy = TrackingPointer.TrackWaypoints[pos].y
		
		-- get previous element location
		local wx2 = TrackingPointer.TrackWaypoints[pos - 1].x
		local wy2 = TrackingPointer.TrackWaypoints[pos - 1].y

		-- is the current distance higher than the previous one?
		if TrackingPointer.GetDistranceFromPlayer(wy, wy) >= TrackingPointer.GetDistranceFromPlayer(wy2, wy2) then
			pos = pos + 1

		else -- swap the current element with the previous one
			local swap = TrackingPointer.TrackWaypoints[pos]
			TrackingPointer.TrackWaypoints[pos] = TrackingPointer.TrackWaypoints[pos - 1]
			TrackingPointer.TrackWaypoints[pos - 1] = swap
			pos = pos - 1
		end
	end
end

function TrackingPointer.GetDistranceFromPlayer(wx, wy)

	-- calculate the distance difference between the current player location and the target location
	local deltaX = WindowData.PlayerLocation.x - wx
	local deltaY = WindowData.PlayerLocation.y - wy

	-- calculate the distance between the 2 points
	return math.ceil(math.sqrt(math.pow(deltaX, 2) + math.pow(deltaY, 2)))
end