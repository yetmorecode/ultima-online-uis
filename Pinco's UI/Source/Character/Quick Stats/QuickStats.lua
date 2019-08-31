
----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

QuickStats = {}

QuickStats.Settings = {}
QuickStats.Initialized = false

QuickStats.LabelsRefreshRate = 0.5

-- [LabeID] = {attribute=AttributeName, objectType=TypeID, hue=objectHue, minQuantity=MinQuantityWarningAmount, icon=ON/OFF, frame=ON/OFF name=ON/OFF, cap=ON/OFF, locked=ON/OFF, BGColor=RGB, frameColor=RGB, valueTextColor=RGB, nameTextColor=RGB}
QuickStats.Labels = {}

QuickStats.Max = 100

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------


function QuickStats.Initialize()

	-- initializ the labels array
	QuickStats.Labels = {}

	-- scanning all the possible ids up to the max
	for i = 1, QuickStats.Max do
		
		-- quickstat label name
		local label = "QuickStat_" .. i

		-- load the label
		local lab = QuickStats.Load(label)

		-- do we have the label record? (if not the label doesn't exist)
		if lab then

			-- assign the label record to the array
			QuickStats.Labels[i] = lab

			-- create the label
			CreateWindowFromTemplate(label, "QuickStatTemplate", "Root")

			-- add the label to the open windows
			WindowUtils.openWindows[label] = true

			-- attach the label id to the label
			WindowSetId(label, i)
			
			-- mark the label as snappable
			SnapUtils.SnappableWindows[label] = true
			
			-- restore the window position
			WindowSetOffsetFromParent(label, lab.x, lab.y)
		
			-- update the label
			QuickStats.UpdateLabel(label)
			
			-- load the label scale
			WindowUtils.LoadScale( label )
		end
	end

	-- mark the quickstat as initialized
	QuickStats.Initialized = true
end

function QuickStats.Shutdown()
	
	-- scanning all the labels
	for i = 1, QuickStats.Max do
		
		-- quick stat label name
		local label = "QuickStat_" .. i

		-- does the label exist?
		if DoesWindowExist(label) then
			
			-- save the data
			QuickStats.Save(label)

			-- destroy the label
			DestroyWindow(label)
		end
	end
end

-- this function returns an ID for a new label
function QuickStats.GetId()

	-- scan all the labels IDs in search of an empty one
	for i = 1, QuickStats.Max do

		-- does the label exist?
		if not QuickStats.Labels[i] then

			-- found a free ID
			return i
		end
	end
end

function QuickStats.Save(label)

	-- is this a valid string?
	if not IsValidString(label) then
		return
	end
	
	-- get the label record
	local lab = QuickStats.Labels[WindowGetId(label)]

	-- get the label screen position
	local x, y = WindowUtils.GetScaledScreenPosition(label)

	-- load the screen position in the record
	lab.x = x
	lab.y = y

	-- disable the blinking
	lab.blink = nil

	-- save the attribute ID (if we have one)
	if lab.attribute then
		Interface.SaveSetting(label .. "_attribute", lab.attribute)
	end

	-- save the object type (if we have one)
	if lab.objectType then
		Interface.SaveSetting(label .. "_objectType", lab.objectType)
	end

	-- save the item hue (if we have one)
	if lab.hue then
		Interface.SaveSetting(label .. "_hue", lab.hue)
	end

	-- save all the others settings
	Interface.SaveSetting(label .. "_minQuantity", lab.minQuantity)
	Interface.SaveSetting(label .. "_icon", lab.icon)
	Interface.SaveSetting(label .. "_frame", lab.frame)
	Interface.SaveSetting(label .. "_name", lab.name)
	Interface.SaveSetting(label .. "_cap", lab.cap)
	Interface.SaveSetting(label .. "_locked", lab.locked)
	Interface.SaveSetting(label .. "_BGColor", lab.BGColor)
	Interface.SaveSetting(label .. "_frameColor", lab.frameColor)
	Interface.SaveSetting(label .. "_valueTextColor", lab.valueTextColor)
	Interface.SaveSetting(label .. "_nameTextColor", lab.nameTextColor)	
	Interface.SaveSetting(label .. "_x", lab.x)	
	Interface.SaveSetting(label .. "_y", lab.y)	
end

function QuickStats.Load(label)

	-- is this a valid string?
	if not IsValidString(label) then
		return
	end

	-- initialize the label record
	local lab = {}

	-- load all the record attributes
	lab.attribute = Interface.LoadSetting(label .. "_attribute", nil, 0)
	lab.objectType = Interface.LoadSetting(label .. "_objectType", nil, 0)
	lab.minQuantity = Interface.LoadSetting(label .. "_minQuantity", nil, 0)
	lab.icon = Interface.LoadSetting(label .. "_icon", nil, true)
	lab.frame = Interface.LoadSetting(label .. "_frame", nil, true)
	lab.name = Interface.LoadSetting(label .. "_name", nil, true)
	lab.cap = Interface.LoadSetting(label .. "_cap", nil, true)
	lab.locked = Interface.LoadSetting(label .. "_locked", nil, true)
	lab.BGColor = Interface.LoadSetting(label .. "_BGColor", nil, {r=0,g=0,b=0})
	lab.frameColor = Interface.LoadSetting(label .. "_frameColor", nil, {r=0,g=0,b=0})
	lab.valueTextColor = Interface.LoadSetting(label .. "_valueTextColor", nil, {r=0,g=0,b=0})
	lab.nameTextColor = Interface.LoadSetting(label .. "_nameTextColor", nil, {r=0,g=0,b=0})	
	lab.x = Interface.LoadSetting(label .. "_x", nil, 0)
	lab.y = Interface.LoadSetting(label .. "_y", nil, 0)
	lab.hue = Interface.LoadSetting(label .. "_hue", nil, 0)

	-- the blink is turned off at start
	lab.blink = false

	-- if we don't have a bg color, the record is damaged and we nullify it
	if not lab.BGColor then
		lab = nil
	end

	return lab
end

function QuickStats.DeleteSettings(label)

	-- is this a valid string?
	if not IsValidString(label) then
		return
	end
	
	-- does the label exist?
	if not DoesWindowExist(label) then
		return
	end

	-- delete all settings
	Interface.DeleteSetting(label .. "_attribute")
	Interface.DeleteSetting(label .. "_objectType")
	Interface.DeleteSetting(label .. "_minQuantity")
	Interface.DeleteSetting(label .. "_icon")
	Interface.DeleteSetting(label .. "_frame")
	Interface.DeleteSetting(label .. "_name")
	Interface.DeleteSetting(label .. "_cap")
	Interface.DeleteSetting(label .. "_locked")
	Interface.DeleteSetting(label .. "_BGColor")
	Interface.DeleteSetting(label .. "_frameColor")
	Interface.DeleteSetting(label .. "_valueTextColor")
	Interface.DeleteSetting(label .. "_nameTextColor")	
	Interface.DeleteSetting(label .. "_x")	
	Interface.DeleteSetting(label .. "_y")	
	Interface.DeleteSetting(label .. "_hue")	
	
	-- delete the label record
	QuickStats.Labels[WindowGetId(label)] = nil	

	-- delete the scale
	Interface.DeleteSetting( label .."SC" )

	-- destroy the label
	DestroyWindow(label)

	-- remove the label from the open windows list
	WindowUtils.openWindows[label] = nil
end

function QuickStats.DoesLabelExist(attributeId, isObject, hue)
	
	-- are we looking for an object?
	if isObject then

		-- are we looking for bandages?
		if attributeId == 3617 then
			
			-- if the hue is not the enhanced bandages hue, we set it to 0
			if hue ~= 2213 then
				hue = 0
			end

		else -- only bandages supports the hue for now...
			hue = 0
		end
	end

	-- scan all the labels
	for i,_ in pairs(QuickStats.Labels) do

		-- get the label record
		local lab = QuickStats.Labels[i]

		-- is this the stat we're looking for?
		if lab and lab.attribute == attributeId and not isObject then
			return i

		-- is this the object we're looking for?
		elseif lab and lab.objectType == attributeId and isObject then
			
			-- are we looking for a specific hue?
			if hue then

				-- is the current label hue the one we're looking for?
				if lab.hue == hue then
					return i
				end

			else -- we found the label
				return i
			end
		end
	end

	-- we found nothing
	return 0
end

function QuickStats.HasLoyaltyLabel()

	-- scan all the labels
	for i,_ in pairs(QuickStats.Labels) do

		-- get the label record
		local lab = QuickStats.Labels[i]

		-- is this the stat we're looking for?
		if lab and lab.attribute then
			return CharacterSheet.isInLoyaltyRating(CharacterSheet.GetStatNameById(lab.attribute))
		end
	end

	-- we found nothing
	return false
end

function QuickStats.UpdateLabel(label)
	
	-- make sure the UI is started first
	if not Interface.started then
		return
	end

	-- is this a valid string?
	if not IsValidString(label) then
		return
	end

	-- does the label exist?
	if not DoesWindowExist(label) then
		return
	end

	-- get the label ID
	local labID = WindowGetId(label)

	-- do we have a valid ID?
	if not IsValidID(labID) then
		return
	end

	-- get the label record
	local lab = QuickStats.Labels[labID]

	-- do we have the label record?
	if not lab then
		return
	end

	-- is this label an item?
	local isObject = lab.objectType ~= nil
	
	-- do we have a min quantity alert?	
	if not lab.minQuantity then
		lab.minQuantity = -1
	end
	
	-- initialize the object/stat ID
	local id = 0

	-- separator string (used for stats only)
	local sep = L""

	-- initialize the quanitty/stat value variable
	local value

	-- initialize the cap value
	local cap = ""

	-- initialize the name string
	local text

	-- initialize the offset for the name
	local yOffset = 0
	local xOffset = 0

	-- label name window
	local labelName = label.."AttributeName"

	-- label value window
	local labelValue = label.."AttributeValue"

	-- label icon window
	local labelIcon = label.."SquareIcon"

	-- is this an object?
	if isObject then

		-- the ID is the type
		id = lab.objectType

		-- get the item TID
		local tid = ItemsInfo.Reagents[id]

		-- load the hue
		local hue = lab.hue

		-- if we have no hue, we use the default color
		if not hue then
			hue = 0
		end

		-- is this normal bandages?
		if id == 3617 then
			
			-- if the hue is 2213, is enchanted bandages
			if lab.hue == 2213 then
				tid = 1152441 -- enhanced bandage

			else -- no need to show the hue if it's not the enhanced bandages
				hue = 0
			end

		else -- hue supported only for bandages
			hue = 0
		end

		-- get the string from TID
		text = GetStringFromTid(tid)

		-- draw the item icon
		EquipmentData.DrawObjectIcon(id, hue, labelIcon)
		
		-- clean up the name from % and :
		text = wstring.gsub(ReplaceTokens(text, {L""}), L"%%", L"")
		text = wstring.gsub(ReplaceTokens(text, {L""}), L":", L"")
		
		-- clear the icon anchors
		WindowClearAnchors(labelIcon)

		-- center the icon to the left
		WindowAddAnchor(labelIcon, "left", label, "left", 6, 5)

		-- the Y offset for the name is -5
		yOffset = -5

		-- initialize the hue to exclude
		local excludeHue

		-- fix the hue for the quantity search of normal bandages, but we exclude the enhanced color
		if hue == 0 and id == 3617 then
			hue = "any"
			excludeHue = 2213
		end

		-- get the item quantity
		local qta = ContainerWindow.GetItemQuantity(id, hue, excludeHue)

		-- format the amount of items
		value = tostring(Knumber(qta))

		-- do we have a min quantity specified and the quantity is less than the min quantity and the label is not blinking?
		if lab.minQuantity ~= -1 and lab.minQuantity >= qta and not lab.blink then

			-- color the value in red
			LabelSetTextColor(labelValue, 255, 0, 0)

			-- start blinking the value
			WindowStartAlphaAnimation(labelValue, Window.AnimationType.LOOP, 0.3, 1.0, 1, false, 0, 0)
			
			-- set the name in red
			LabelSetTextColor(labelName, 255, 0, 0)

			-- start blinking the name
			WindowStartAlphaAnimation(labelName, Window.AnimationType.LOOP, 0.3, 1.0, 1, false, 0, 0)
			
			-- flag the label as blinking
			QuickStats.Labels[labID].blink = true

		-- is the item quantity greater than the min and the label is blinking?
		elseif ((lab.minQuantity < qta and lab.blink) or lab.minQuantity == -1) then

			-- restore the label value color
			LabelSetTextColor(labelValue, lab.valueTextColor.r, lab.valueTextColor.g, lab.valueTextColor.b)

			-- stop the blinking animation
			WindowStopAlphaAnimation(labelValue)
			
			-- restore the name color
			LabelSetTextColor(labelName, lab.nameTextColor.r, lab.nameTextColor.g, lab.nameTextColor.b)

			-- stop the name animation
			WindowStopAlphaAnimation(labelName)

			-- remove the blinking flag
			QuickStats.Labels[labID].blink = nil
		end

		-- no separator needed for items
		sep = ""

	else
		-- if this is a stat we get the stat ID
		id = lab.attribute

		-- show the stat icon on the label
		CharacterSheet.SetMiniIconStats(label, CharacterSheet.AttributesDef[CharacterSheet.GetStatNameById(id)].iconId)

		-- get the stat name TID
		local tid = CharacterSheet.AttributesDef[CharacterSheet.GetStatNameById(id)].tid

		-- do we have a TID?
		if tid then

			-- get the string from the TID
			text = GetStringFromTid(tid)

		else -- use the string name
			text = CharacterSheet.AttributesDef[CharacterSheet.GetStatNameById(id)].stringText
		end
		
		-- clean up the name from % and :
		text = wstring.gsub(ReplaceTokens(text, {L""}), L"%%", L"")
		text = wstring.gsub(ReplaceTokens(text, {L""}), L":", L"")
		
		-- clear the name anchors
		WindowClearAnchors(labelName)

		-- attach the name to the right of the icon
		WindowAddAnchor(labelName, "right", label.."SquareIcon", "left", 6, 0)

		-- get the stat name
		local k = CharacterSheet.GetStatNameById(id)

		-- does the stat need a separator?
		sep = CharacterSheet.AttributesDef[k].separator  or ""

		-- fix the name for health, stamina and mana
		local curVar = k
		if (k == "Health" or k == "Stamina" or k == "Mana") then

			-- set the current value name
			curVar = "Current"..k
		end
		
		-- weight support the warning level so we set the max weight on the min quantity - warning level
		if (k == "Weight") then
			lab.minQuantity = tonumber(tostring(WindowData.PlayerStatus["Max"..k])) - HotbarSystem.WARNINGLEVEL
		end
		
		-- get current raw value for the stat
		local qta = tostring(WindowData.PlayerStatus[curVar])

		-- do we need to show the cap?
		if lab.cap then
			
			-- does the stat have a cap?
			if (CharacterSheet.AttributesDef[k].cap) then

				-- get the stat cap
				cap = CharacterSheet.AttributesDef[k].cap + (CharacterSheet.CapsBonus[k] or 0)
			end
			
			-- this stats need a small change to the base name to get the correct cap value
			if (k == "CurrentHealth" or k == "CurrentStamina" or k == "CurrentMana") then

				-- get the cap value
				cap = tostring(Knumber(WindowData.PlayerStatus[string.gsub(k, "Current", "Max")]))

			-- get the stat max (to work as cap)
			elseif WindowData.PlayerStatus["Max"..k] then
				cap = tostring(Knumber(tonumber(tostring(WindowData.PlayerStatus["Max"..k]))))	
			end
			
			-- if we have a valid cap we use the separator and it's not the player damage
			if IsValidString(cap) and id ~= 20 then
				sep = " / "

			-- if is the player damage we use a different separator
			elseif id == 20 then
				sep = " - "
			end

		else -- no separator needed if there is no cap
			sep = ""
		end
		
		-- is the stat value a number?
		if type(tonumber(qta)) == "number" then
		
			-- convert the raw value to number
			qta = tonumber(qta)

			-- get the formatted current stat value
			value = tostring(Knumber(tonumber(tostring(qta))))

			-- is this stat the weight?
			if (k == "Weight") then

				-- is the current value greater than the max weight?
				if qta >= lab.minQuantity then

					-- is the label not blinking?
					if not lab.blink then

						-- color the value in red
						LabelSetTextColor(labelValue, 255, 0, 0)

						-- start blinking the value
						WindowStartAlphaAnimation(labelValue, Window.AnimationType.LOOP, 0.3, 1.0, 1, false, 0, 0)
			
						-- set the name in red
						LabelSetTextColor(labelName, 255, 0, 0)

						-- start blinking the name
						WindowStartAlphaAnimation(labelName, Window.AnimationType.LOOP, 0.3, 1.0, 1, false, 0, 0)
			
						-- flag the label as blinking
						QuickStats.Labels[labID].blink = true
					end

					-- reset cap and separator if the weight is thousands or more
					if string.find(value, "K", 1, true) then
						cap = ""
						sep = ""
					end

				-- is the current weight less than the max and the label is blinking?
				elseif qta < lab.minQuantity and lab.blink then

					-- restore the label value color
					LabelSetTextColor(labelValue, lab.valueTextColor.r, lab.valueTextColor.g, lab.valueTextColor.b)

					-- stop the blinking animation
					WindowStopAlphaAnimation(labelValue)
			
					-- restore the name color
					LabelSetTextColor(labelName, lab.nameTextColor.r, lab.nameTextColor.g, lab.nameTextColor.b)

					-- stop the name animation
					WindowStopAlphaAnimation(labelName)

					-- remove the blinking flag
					QuickStats.Labels[labID].blink = nil
				end

			else -- other stats blinks only if there is a min quantity specified by the user
			
				-- is the value less than the minimum required and the label is not blinking?
				if lab.minQuantity ~= -1 and lab.minQuantity >= qta and not lab.blink then

					-- color the value in red
					LabelSetTextColor(labelValue, 255, 0, 0)

					-- start blinking the value
					WindowStartAlphaAnimation(labelValue, Window.AnimationType.LOOP, 0.3, 1.0, 1, false, 0, 0)
			
					-- set the name in red
					LabelSetTextColor(labelName, 255, 0, 0)

					-- start blinking the name
					WindowStartAlphaAnimation(labelName, Window.AnimationType.LOOP, 0.3, 1.0, 1, false, 0, 0)
			
					-- flag the label as blinking
					QuickStats.Labels[labID].blink = true

				-- is the min value less than the current value and the label is blinking?
				elseif ((lab.minQuantity < qta and lab.blink) or lab.minQuantity == -1) then

					-- restore the label value color
					LabelSetTextColor(labelValue, lab.valueTextColor.r, lab.valueTextColor.g, lab.valueTextColor.b)

					-- stop the blinking animation
					WindowStopAlphaAnimation(labelValue)
			
					-- restore the name color
					LabelSetTextColor(labelName, lab.nameTextColor.r, lab.nameTextColor.g, lab.nameTextColor.b)

					-- stop the name animation
					WindowStopAlphaAnimation(labelName)

					-- remove the blinking flag
					QuickStats.Labels[labID].blink = nil
				end
			end
		end

		-- do we have a stat value that is nil?
		if not value or value == "nil" then
			
			-- set the stat value to 0 if there is no current value
			if not WindowData.PlayerStatus[curVar] then
				value = "0"

			else -- we have a string value for the stat
				value = tostring(WindowData.PlayerStatus[curVar])
			end

			-- no separator needed
			sep = ""
		end
	end

	-- fill the label value
	LabelSetText(labelValue, wstring.trim(towstring(value .. sep .. cap)))
		
	-- get the name width
	local w, _ = WindowGetDimensions(labelName)
	w = w + 10 -- +margin

	-- get the value width
	local w1, _ = WindowGetDimensions(labelValue)
	w1 = w1 + 10 -- +margin

	-- get the icon width
	local w2, _ = WindowGetDimensions(labelIcon)
	w2 = w2 + 6 -- +margin
	
	-- initialize total width
	local totalW

	-- do we have the icon visible?
	if lab.icon then

		-- set the icon visible
		WindowSetShowing(labelIcon, true)
		
		-- do we have the name visible?
		if lab.name then

			-- write the item/stat name
			LabelSetText(labelName, wstring.trim(FormatProperly(text)))

			-- get the label width and height
			local w, h = LabelGetTextDimensions(labelName)

			-- fix the width to 190
			w = 190

			-- update the name dimensions
			WindowSetDimensions(labelName, w, h)

			-- clear the name position
			WindowClearAnchors(labelName)

			-- attach the name to the right of the icon
			WindowAddAnchor(labelName, "right", labelIcon, "left", 6, yOffset)
			
			-- change the value width
			WindowSetDimensions(labelValue, 80, h)
			
			-- clear the value position
			WindowClearAnchors(labelValue)

			-- attach the value to the right of the name
			WindowAddAnchor(labelValue, "right", labelName, "left", xOffset, 0)

			-- align the value to the right
			LabelSetTextAlign(labelValue, "right")
			
			-- calculate the total width
			totalW = w + w1 + w2 + 18

		else -- name disabled?

			-- clear the name text
			LabelSetText(labelName, L"")			

			-- get the value dimensions
			local w1, h = LabelGetTextDimensions(labelValue)

			-- force the width to 80
			w1 = 80

			-- if we don't have to show the cap, the width is half
			if not lab.cap then
				w1 = w1/2
			end

			-- resize the value
			WindowSetDimensions(labelValue, w1, h)

			-- clear the value position
			WindowClearAnchors(labelValue)

			-- attach the value to the right of the icon
			WindowAddAnchor(labelValue, "right", labelIcon, "left", xOffset + 6, yOffset)

			-- align the value to the right
			LabelSetTextAlign(labelValue, "right")
			
			-- calculate the total width
			totalW = w1 + w2 + 18
		end
		
	else -- we hide the icon
		WindowSetShowing(labelIcon, false)

		-- do we have the name visible?
		if lab.name then

			-- se the label name
			LabelSetText(labelName, wstring.trim(FormatProperly(text)))

			-- get the name dimensions
			local w, h = LabelGetTextDimensions(labelName)

			-- force the width to 190
			w = 190

			-- resize the name label properly
			WindowSetDimensions(labelName, w, h)

			-- clear the name position
			WindowClearAnchors(labelName)

			-- attach the name to the left border of the label
			WindowAddAnchor(labelName, "left", label, "left", 6, 0)
			
			-- resize the value label properly
			WindowSetDimensions(labelValue, 80, h)
			
			-- clear the value position
			WindowClearAnchors(labelValue)

			-- anchor the value to the right of the name
			WindowAddAnchor(labelValue, "right", labelName, "left", 0, 0)

			-- align the value to the right
			LabelSetTextAlign(labelValue, "right")
			
			-- calculate the total width
			totalW = w + w1 + 18

		else -- name invisible

			-- clear the name text
			LabelSetText(labelName, L"")		
			
			-- get the value dimensions
			local w1, h = LabelGetTextDimensions(labelValue)

			-- resize the value label
			WindowSetDimensions(labelValue, w1, h)

			-- clear the value position
			WindowClearAnchors(labelValue)

			-- anchor the value to the left margin of the label
			WindowAddAnchor(labelValue, "left", label, "left", 6, 0)

			-- align the value to the left
			LabelSetTextAlign(labelValue, "left")

			-- default offset from the border
			local off = 12

			-- if we have the cap the offset is halved
			if lab.cap then
				off = off/2 + 5
			end
			
			-- calculate the total width
			totalW = w1 + off
		end
	end

	-- update the quick stat label dimensions
	WindowSetDimensions(label, totalW, 30)

	-- re-process all anchors
	WindowForceProcessAnchors(label)
	
	-- add some transparency to the background
	WindowSetAlpha(label.."WindowBackground", 0.8)

	-- color the background
	WindowSetTintColor(label.."WindowBackground", lab.BGColor.r, lab.BGColor.g, lab.BGColor.b)
	
	-- do we have the frame active?
	if not lab.frame then

		-- disable the frame
		WindowSetShowing(label.."Frame", false)

	else -- enable the frame
		WindowSetShowing(label.."Frame", true)
			
		-- add some transparency to the frame
		WindowSetAlpha(label.."Frame", 0.8)

		-- color the frame
		WindowSetTintColor(label.."Frame", lab.frameColor.r, lab.frameColor.g, lab.frameColor.b)
	end
end


QuickStats.Delta = 0
function QuickStats.OnUpdate(timePassed)

	-- update the delta time
	QuickStats.Delta = QuickStats.Delta + timePassed

	-- is it time for an update?
	if QuickStats.Delta > QuickStats.LabelsRefreshRate then

		-- reset the delta
		QuickStats.Delta = 0

		-- scan all labels
		for i = 1, QuickStats.Max do

			-- label window name
			local label = "QuickStat_" .. i

			-- is the window visible and not moving?
			if DoesWindowExist(label) and QuickStats.InMovement[label] ~= true and label ~= SnapUtils.SnapWindow then

				-- update the label
				QuickStats.UpdateLabel(label)
			end
		end
	end
end

function QuickStats.StatLButtonDown(flags)
	local this = WindowGetParent(SystemData.ActiveWindow.name)

	-- does the window exist?
	if not DoesWindowExist(this) then
		return
	end

	-- get the label ID
	local id = WindowGetId(this)

	-- do we have a valid ID?
	if not IsValidID(id) then
		return
	end

	-- is ALT pressed and the window is not moving?
	if flags == WindowUtils.ButtonFlags.ALT and not WindowGetMoving(this) then
		
		-- we move the whole block of labels
		QuickStats.FindQuickStatMovingBlock(this)

		-- mark this label as in movement
		QuickStats.InMovement[this] = true

	-- is the label not locked and not in movement?
	elseif QuickStats.Labels[id] and not QuickStats.Labels[id].locked and not WindowGetMoving(this) then

		-- mark this label as in movement
		QuickStats.InMovement[this] = true

		-- start window snap on the label
		SnapUtils.StartWindowSnap(this)

		-- set this label moving
		WindowSetMoving(this, true)
	end
end

function QuickStats.StatOnLButtonUp()

	-- scan the bars in movement
	for windowName, _ in pairs(QuickStats.InMovement) do

		-- stop the movement for the label
		WindowSetMoving(windowName, false)

		-- delay the saved position
		Interface.AddTodoList({name = "quickstat delayed position save", func = function() QuickStats.Save(windowName) end, time = Interface.TimeSinceLogin + 0.2})

		-- remove the label from the array
		QuickStats.InMovement[windowName] = nil
	end
end

QuickStats.InMovement = {}
function QuickStats.FindQuickStatMovingBlock(CurWindow)

	-- setting the scan range for the window
	local anchorPositions = SnapUtils.ComputeAnchorScreenPositions(CurWindow)

	-- now we scan all the snappable windows if any of them are in range
	for windowName,_ in pairs(SnapUtils.SnappableWindows) do

		-- we ignore the current window (obv), windows that we have already found, and windows that are already moving. We must also be sure it's another quick stat.
		if (windowName ~= CurWindow and string.find(windowName, "QuickStat", 1, true) and not QuickStats.InMovement[windowName] and not WindowGetMoving(windowName)) then          

			-- setting the scanning range for the other window
			local comparePositions = SnapUtils.ComputeAnchorScreenPositions(windowName)            
            
			-- now we must make sure the 2 windows are actually in range
			for index, snapPair in pairsByIndex(SnapUtils.SNAP_PAIRS) do

				-- calculating distance
				local dist = SnapUtils.GetAnchorDistance( anchorPositions, snapPair[1], comparePositions, snapPair[2] )
               
				-- if the range is confirmed, we can add the window to the movement block and search for more.
				if ((dist <= 5) and (dist < 6) and WindowGetShowing(windowName)) then
					WindowSetMoving(windowName, true)
					QuickStats.InMovement[windowName] = true
					QuickStats.FindQuickStatMovingBlock(windowName)
				end
		   end
		end
	end
end


function QuickStats.Context()

	-- label window name
	local this = WindowGetParent(SystemData.ActiveWindow.name)

	-- does the label exist?
	if not DoesWindowExist(this) then
		return
	end

	-- get the label ID
	local labID = WindowGetId(this)

	-- do we have a valid ID?
	if not IsValidID(labID) then
		return
	end

	-- get the label record
	local lab = QuickStats.Labels[labID]

	-- do we have the label record?
	if not lab then
		return
	end

	-- reset the context menu
	ContextMenu.CleanUp()

	-- label locked?
	if lab.locked then
		ContextMenu.CreateLuaContextMenuItem({tid = 1111696, returnCode = "lock", param = this}) -- Unlock Window
	else
		ContextMenu.CreateLuaContextMenuItem({tid = 1111697, returnCode = "lock", param = this}) -- Lock Window
	end
	
	-- empty space
	ContextMenu.CreateLuaContextMenuItem(ContextMenu.EmptyLine)
	
	ContextMenu.CreateLuaContextMenuItem({tid = 1155391, returnCode = "ShowIcon",  param = this, pressed = lab.icon}) -- Show Icon
	ContextMenu.CreateLuaContextMenuItem({tid = 1155392, returnCode = "ShowFrame", param = this, pressed = lab.frame}) -- Show Frame
	ContextMenu.CreateLuaContextMenuItem({tid = 1155393, returnCode = "ShowName",  param = this, pressed = lab.name}) -- Show Name
	ContextMenu.CreateLuaContextMenuItem({tid = 1155394, returnCode = "ShowCap",   param = this, pressed = lab.cap}) -- Show Cap
	
	-- is the label an item?
	if lab.objectType then
		ContextMenu.CreateLuaContextMenuItem({str = ReplaceTokens(GetStringFromTid(1155478),  {towstring(lab.minQuantity)}), returnCode = "amtWarning", param = this}) -- Set Amount Warning (~1_AMT~)

	else
		-- get the attribute name
		local k = CharacterSheet.GetStatNameById(lab.attribute)

		-- any attribute but weight
		if (k ~= "Weight") then
			ContextMenu.CreateLuaContextMenuItem({str = ReplaceTokens(GetStringFromTid(1155478),  {towstring(lab.minQuantity)}), returnCode = "amtWarning", param = this}) -- Set Amount Warning (~1_AMT~)
		end
	end
	
	-- empty space
	ContextMenu.CreateLuaContextMenuItem(ContextMenu.EmptyLine)
	
	ContextMenu.CreateLuaContextMenuItem({tid = 1155395, returnCode = "BGColor",	 param = this}) -- Set Background Color
	ContextMenu.CreateLuaContextMenuItem({tid = 1155396, returnCode = "FrameColor", param = this}) -- Set Frame Color
	ContextMenu.CreateLuaContextMenuItem({tid = 1155397, returnCode = "NameColor",  param = this}) -- Set Name Color
	ContextMenu.CreateLuaContextMenuItem({tid = 1155398, returnCode = "ValueColor", param = this}) -- Set Value Color
	
	-- empty space
	ContextMenu.CreateLuaContextMenuItem(ContextMenu.EmptyLine)
	
	ContextMenu.CreateLuaContextMenuItem({tid = 1155399, returnCode = "Destroy", param = this}) -- Destroy Label
	
	-- show the context menu
	ContextMenu.ActivateLuaContextMenu(QuickStats.ContextMenuCallback)
end

function QuickStats.ContextMenuCallback(returnCode, label)

	-- get the label record
	local lab = QuickStats.Labels[WindowGetId(label)]
	
	-- lock label
	if (returnCode=="lock") then
		lab.locked = not lab.locked

	-- toggle icon
	elseif (returnCode=="ShowIcon") then
		lab.icon = not lab.icon

	-- toggle frame
	elseif (returnCode=="ShowFrame") then
		lab.frame = not lab.frame

	-- toggle name
	elseif (returnCode=="ShowName") then
		lab.name = not lab.name

	-- toggle cap
	elseif (returnCode=="ShowCap") then
		lab.cap = not lab.cap

	-- amount warning input box
	elseif (returnCode=="amtWarning") then
		local rdata = {title=GetStringFromTid(1155400), subtitle=GetStringFromTid(1155401), callfunction=QuickStats.AmountSettings, id=WindowGetId(label)}-- Amount Alert // Enter the minimum amount required to trigger the warning.
		RenameWindow.Create(rdata)

	-- destroy dialog
	elseif (returnCode=="Destroy") then
		local okayButton = { textTid=UO_StandardDialog.TID_OKAY, callback=function() QuickStats.Destroy(label) end }
        local cancelButton = { textTid=UO_StandardDialog.TID_CANCEL }
		local DestroyConfirmWindow = 
		{
		    windowName = label,
			titleTid = 1155399, -- Destroy Label
			bodyTid  = 1155390, -- Are you sure?
			buttons = { okayButton, cancelButton },
			closeCallback = cancelButton.callback,
			destroyDuplicate = true,
		}
			
		UO_StandardDialog.CreateDialog(DestroyConfirmWindow)

	-- color picking window
	elseif (string.find(returnCode, "Color", 1, true)) then	
		
		QuickStats.PickColor(string.gsub(returnCode, "Color", ""), label)
	end

	-- save the changes
	QuickStats.Save(label)

	-- update the label
	QuickStats.UpdateLabel(label)
end

function QuickStats.AmountSettings(id, amount)

	-- do we have a valid amount?
	if not tonumber(amount) then
		return

	else 
		-- get the label record
		local lab = QuickStats.Labels[id]

		-- do we have a valid record?
		if not lab then
			return
		end

		-- label window name
		local label = "QuickStat_" .. id

		-- set the label min quantity alert
		lab.minQuantity = tonumber(amount)

		-- update the value text color
		LabelSetTextColor(label.."AttributeValue", lab.valueTextColor.r, lab.valueTextColor.g, lab.valueTextColor.b)

		-- stop blinking
		WindowStopAlphaAnimation(label.."AttributeValue")
		
		-- update the name color
		LabelSetTextColor(label.."AttributeName", lab.nameTextColor.r, lab.nameTextColor.g, lab.nameTextColor.b)

		-- stop blinking
		WindowStopAlphaAnimation(label.."AttributeName")
	end

	-- save settings
	QuickStats.Save("QuickStat_" .. id)
end

function QuickStats.Destroy(windowname)

	-- delete settings
	QuickStats.DeleteSettings(windowname)

	-- remove from the snap list
	SnapUtils.SnappableWindows[windowname] = nil
end

function QuickStats.PickColor(color, windowname)
	
	-- picking color data array
	QuickStats.PickingColor = {windowname, color}

	-- base color IDs table
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

	-- initialize the colors list
	local hueTable = {}

	-- parse all the colors
	for idx, hue in pairs(defaultColors) do
		
		-- add the color to the table
		for i = 0,8 do
			hueTable[(idx-1)*10+i+1] = hue+i
		end
	end

	-- default Brightness
	local Brightness = 1

	-- create the color picking window
	CreateWindowFromTemplate( "ColorPicker", "ColorPickerWindowTemplate", "Root" )

	-- set the proper layer
	WindowSetLayer( "ColorPicker", Window.Layers.SECONDARY	)

	-- colors settings
	ColorPickerWindow.SetNumColorsPerRow(9)
	ColorPickerWindow.SetSwatchSize(30)
	ColorPickerWindow.SetWindowPadding(4,4)
	ColorPickerWindow.SetFrameEnabled(true)
	ColorPickerWindow.SetCloseButtonEnabled(true)
	ColorPickerWindow.SetColorTable(hueTable, "ColorPicker")
	ColorPickerWindow.DrawColorTable("ColorPicker")
	ColorPickerWindow.SetAfterColorSelectionFunction(QuickStats.ColorPicked)

	-- get the window dimensions
	local w, h = WindowGetDimensions("ColorPicker")

	-- anchor the window to center screen
	WindowAddAnchor( "ColorPicker", "center", "Root", "center", 0, 0)

	-- disable the frame
	ColorPickerWindow.SetFrameEnabled(false)

	-- show the window
	WindowSetShowing( "ColorPicker", true )

	-- select default color
	ColorPickerWindow.SelectColor("ColorPicker", 1)
end

function QuickStats.ColorPicked()

	-- get the selected color
	local huePicked = ColorPickerWindow.colorSelected["ColorPicker"]

	-- initialize the rgb variable
	local color = {}

	-- convert the hue to rgb
	color.r, color.g, color.b = HueRGBAValue(huePicked)
		
	-- get the label record
	local lab = QuickStats.Labels[WindowGetId(QuickStats.PickingColor[1])]

	-- do we have a valid record?
	if not lab then
		DestroyWindow("ColorPicker")
		return
	end

	-- save the color based on the setting chosen
	if QuickStats.PickingColor[2] == "BG" then
		lab.BGColor = color

	elseif QuickStats.PickingColor[2] == "Frame" then
		lab.frameColor = color

	elseif QuickStats.PickingColor[2] == "Name" then
		lab.nameTextColor = color

	elseif QuickStats.PickingColor[2] == "Value" then
		lab.valueTextColor = color		
	end					
	
	-- update the label
	QuickStats.UpdateLabel(QuickStats.PickingColor[1])

	-- save the new settings
	QuickStats.Save(QuickStats.PickingColor[1])	

	-- destroy the color picker window
	DestroyWindow("ColorPicker")		 
end