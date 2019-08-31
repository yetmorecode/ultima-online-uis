----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

FindersKeepers = {};

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

FindersKeepers.ItemsList = {};
FindersKeepers.FinalPropsList = {};

FindersKeepers.MaxProps = 6
FindersKeepers.PropsCount = 0

FindersKeepers.Editing = false

FindersKeepers.CreatedItems = 0

FindersKeepers.ValueProperties = 
{
	[1060448] = {en = L"physical resist"; };
	[1060447] = {en = L"fire resist"; };
	[1060445] = {en = L"cold resist"; };
	[1060449] = {en = L"poison resist"; };
	[1060446] = {en = L"energy resist"; };
	[1060403] = {en = L"physical damage"; };
	[1060405] = {en = L"fire damage"; };
	[1060406] = {en = L"poison damage"; };
	[1060404] = {en = L"cold damage"; };
	[1060407] = {en = L"energy damage"; };
	[1072846] = {en = L"chaos damage"; };
	[1060485] = {en = L"strength bonus"; };
	[1060409] = {en = L"dexterity bonus"; };
	[1060432] = {en = L"intelligence bonus"; };
	[1060431] = {en = L"hit point increase"; };
	[1060484] = {en = L"stamina increase"; };
	[1060439] = {en = L"mana increase"; };
	[1060443] = {en = L"stamina regen"; };
	[1060440] = {en = L"mana regen"; };
	[1060444] = {en = L"hit point regen"; };
	[1060422] = {en = L"hit life leech"; };
	[1060427] = {en = L"hit mana leech"; };
	[1060430] = {en = L"hit stamina leech"; };
	[1060424] = {en = L"hit lower attack"; };
	[1060425] = {en = L"hit lower defense"; };
	[1060417] = {en = L"hit dispel"; };
	[1060420] = {en = L"hit fireball"; };
	[1060421] = {en = L"hit harm"; };
	[1060423] = {en = L"hit lightning"; };
	[1060426] = {en = L"hit magic arrow"; };
	[1072793] = {en = L"velocity"; };
	[1113699] = {en = L"hit mana drain"; };
	[1113700] = {en = L"hit fatigue"; };
	[1060416] = {en = L"hit cold area"; };
	[1060418] = {en = L"hit energy area"; };
	[1060419] = {en = L"hit fire area"; };
	[1060428] = {en = L"hit physical area"; };
	[1060429] = {en = L"hit poison area"; };
	[1060401] = {en = L"damage chance increase"; };
	[1060402] = {en = L"damage chance increase"; };
	[1060408] = {en = L"defense chance increase"; };
	[1060415] = {en = L"hit chance increase"; };
	[1060486] = {en = L"swing speed increase"; };
	[1060411] = {en = L"enhance potions"; };
	[1060412] = {en = L"faster cast recovery"; };
	[1060413] = {en = L"faster casting"; };
	[1060433] = {en = L"lower mana cost"; };
	[1060434] = {en = L"lower reagent cost"; };
	[1060438] = {en = L"mage weapon"; };
	[1060483] = {en = L"spell damage increase"; };
	[1113630] = {en = L"soul charge"; };
	[1113696] = {en = L"casting focus"; };
	[1113597] = {en = L"kinetic eater"; };
	[1113593] = {en = L"fire eater"; };
	[1113594] = {en = L"cold eater"; };
	[1113595] = {en = L"poison eater"; };
	[1113596] = {en = L"energy eater"; };
	[1113598] = {en = L"damage eater"; };
	[1113695] = {en = L"kinetic resonance"; };
	[1113691] = {en = L"fire resonance"; };
	[1113692] = {en = L"cold resonance"; };
	[1113693] = {en = L"poison resonance"; };
	[1113694] = {en = L"energy resonance"; };
	[1060435] = {en = L"lower requirements"; };
	[1060436] = {en = L"luck"; };
	[1060450] = {en = L"self repair"; };
	[1060442] = {en = L"reflect physical damage"; };
	[1112857] = {en = L"splintering weapon"; };
	[1061170] = {en = L"strength requirement"; };
}

FindersKeepers.NoValueProperties = 
{
	[1060400] = {en = L"use best weapon skill"; };
	[1113710] = {en = L"battle lust"; };
	[1113591] = {en = L"blood drinker"; };
	[1112364] = {en = L"reactive paralyze"; };
	[1072792] = {en = L"balanced"; };
	[1060482] = {en = L"spell channeling"; };
	[1060441] = {en = L"night sight"; };
	[1060457] = {en = L"air elemental slayer"; };
	[1060458] = {en = L"arachnid slayer"; };
	[1060459] = {en = L"blood elemental slayer"; };
	[1060460] = {en = L"demon slayer"; };
	[1060461] = {en = L"demon slayer"; };
	[1060462] = {en = L"dragon slayer"; };
	[1060463] = {en = L"earth elemental slayer"; };
	[1060464] = {en = L"elemental slayer"; };
	[1070855] = {en = L"fey slayer"; };
	[1060465] = {en = L"fire elemental slayer"; };
	[1060466] = {en = L"gargoyle slayer"; };
	[1060467] = {en = L"lizardman slayer"; };
	[1060468] = {en = L"ogre slayer"; };
	[1060469] = {en = L"ophidian slayer"; };
	[1060470] = {en = L"orc slayer"; };
	[1060471] = {en = L"poison elemental slayer"; };
	[1060472] = {en = L"repond slayer"; };
	[1060473] = {en = L"reptile slayer"; };
	[1060474] = {en = L"scorpion slayer"; };
	[1060475] = {en = L"snake slayer"; };
	[1060476] = {en = L"snow elemental slayer"; };
	[1060477] = {en = L"spider slayer"; };
	[1060478] = {en = L"terathan slayer"; };
	[1060480] = {en = L"troll slayer"; };
	[1060479] = {en = L"undead slayer"; };
	[1060481] = {en = L"water elemental slayer"; };
	[1017396] = {en = L"balron damnation"; };
	[1072504] = {en = L"bear slayer"; };
	[1072506] = {en = L"bat slayer"; };
	[1072508] = {en = L"beetle slayer"; };
	[1072509] = {en = L"bird slayer"; };
	[1072512] = {en = L"bovine slayer"; };
	[1072511] = {en = L"flame slayer"; };
	[1072510] = {en = L"ice slayer"; };
	[1072507] = {en = L"mage slayer"; };
	[1072505] = {en = L"vermin slayer"; };
	[1075462] = {en = L"wolf slayer"; };
	[1049643] = {en = L"cursed"; };
}

FindersKeepers.TokenedProperties = 
{
	[1072394] = {en = L"success bonus"; craftskill = true; };
	[1072395] = {en = L"exceptional success bonus"; craftskill = true; };
	[1060451] = {en = L"skill bonus"; skill = true; };
}


----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function FindersKeepers.Initialize()

	-- window name
	local windowName = SystemData.ActiveWindow.name

	-- fill labels
	LabelSetText(windowName .. "Description", GetStringFromTid(1072202) .. L":") -- Description
	LabelSetText(windowName .. "Type", GetStringFromTid(1154511) .. L":") -- Item Type
	LabelSetText(windowName .. "SetTrash" .. "Label", GetCliloc(210))
	
	-- turn the button into a checkbox
	ButtonSetCheckButtonFlag(windowName .. "SetTrash" .. "Button", true)
	
	-- empty the combo box list
	ComboBoxClearMenuItems(windowName .. "ItemType")

	-- first element "ANY"
	ComboBoxAddMenuItem(windowName .. "ItemType", FormatProperly(GetStringFromTid(196)))
	
	-- initialize the items list
	FindersKeepers.ItemsList = {}

	-- scan all wearable items type
	for tid, data in pairs(ItemPropertiesInfo.WearableItemsDB) do

		-- do we have a valid object type?
		if data.objectType then

			-- add tid and data to the array
			FindersKeepers.ItemsList[wstring.lower(GetStringFromTid(tid))] = data
			FindersKeepers.ItemsList[wstring.lower(GetStringFromTid(tid))].tid = tid
		end
	end

	-- initialize index to 1
	local idx = 1

	-- scan all items
	for name, _ in pairsByKeys(FindersKeepers.ItemsList) do

		-- increase the index (we start from 2 because "ANY" is first)
		idx = idx + 1

		-- set the id value = index
		FindersKeepers.ItemsList[name].id = idx

		-- add the item to the combo list
		ComboBoxAddMenuItem(windowName .. "ItemType", FormatProperly(name))
	end
	
	-- initalize the properties list
	FindersKeepers.FinalPropsList = {}

	-- scan all properties with a value
	for tid, _ in pairs(FindersKeepers.ValueProperties) do

		-- creating the property name by removing "%" and "+"
		local final = wstring.gsub(ReplaceTokens(GetStringFromTid(tid), { L"" }) , L"%+", L"")
		final = wstring.gsub(final, L"%%", L"")

		-- add the property to the list with its TID
		FindersKeepers.FinalPropsList[FormatProperly(final)] = { tid = tid }
	end
	
	-- list of skills id not available on items
	local skipId = { 1, 6, 8, 10, 11, 12, 14, 19, 20, 22, 24, 25, 27, 28, 29, 30, 35, 42, 44, 45, 46, 52, 53, 55, 56 } 

	-- list of crafting skill id
	local CraftSkillsId = { 1, 8, 11, 12, 14, 20, 27, 52, 55 }

	-- scan all the token properties (success chance and skill bonus)
	for tid, data in pairs(FindersKeepers.TokenedProperties) do

		-- is this a crafting skill?
		if data.craftskill then 

			-- create a list for this property and all the crafting skills
			for i, skill in pairsByIndex(CraftSkillsId) do

				-- skill name TID
				local skTid = WindowData.SkillsCSV[skill].NameTid

				-- create the property name with the skill name
				local final = wstring.gsub(ReplaceTokens(GetStringFromTid(tid), { GetStringFromTid(skTid), L"" }), L"%+", L"")
				final = wstring.gsub(final, L"%:", L"")

				-- adding the property to the array with TID and skill TID
				FindersKeepers.FinalPropsList[FormatProperly(final)] = { tid = tid, param = skTid }
			end

		-- is this a skill bonus property?
		elseif data.skill then 

			-- create a list for all the poossible skill bonus
			for i = 1, SkillsWindow.maxskill_index + 1 do

				-- skip skill flag
				local skip = false

				-- check if the current skill has to be skipped
				for j, skp in pairsByIndex(skipId) do

					-- is this the skill we're looking for?
					if i == skp then

						-- mark the skill to be skipped
						skip = true
						break
					end
				end

				-- skip the skill?
				if skip then 
					continue
				end

				-- get the skill name TID
				local skTid = WindowData.SkillsCSV[i].NameTid
				
				-- create the skill bonus property name with the skill name
				local final = wstring.gsub(ReplaceTokens(GetStringFromTid(tid), { GetStringFromTid(skTid), L"" }), L"%%", L"")

				-- adding the property to the array with TID and skill TID 
				FindersKeepers.FinalPropsList[FormatProperly(final)] = {tid = tid, param = skTid}
			end
		end
	end
	
	-- scan all properties without value
	for tid, _ in pairs(FindersKeepers.NoValueProperties) do

		-- add the property to the array with TID and novalue flag
		FindersKeepers.FinalPropsList[FormatProperly(GetStringFromTid(tid))] = { tid = tid, novalue = true }
	end

	-- reset the index to 1
	idx = 1

	-- scan the final property list
	for name, _ in pairsByKeys(FindersKeepers.FinalPropsList) do

		-- as before, we start from 2 (because "ANY" is the first value)
		idx = idx + 1

		-- add the index to the property
		FindersKeepers.FinalPropsList[name].idx = idx
	end
	
	-- fill the text labels
	LabelSetText(windowName .. "Color", GetStringFromTid(203))
	LabelSetText(windowName .. "AddProp", GetStringFromTid(197))
	
	-- fill the buttons text
	ButtonSetText(windowName .. "Submit", GetStringFromTid(BugReportWindow.TID.Submit))
	ButtonSetText(windowName .. "Cancel", GetStringFromTid(UO_StandardDialog.TID_CANCEL))
	
	-- update the window title
	WindowUtils.SetWindowTitle(windowName, GetStringFromTid(198))
end

function FindersKeepers.OnShown()

	-- clear the form on show
	FindersKeepers.Clear()
end

local errorAnim = 0
function FindersKeepers.OnUpdate(timePassed)

	-- hide the button if the number of properties added has reached the max
	WindowSetShowing("FindersKeepersAddProp", not(FindersKeepers.PropsCount >= FindersKeepers.MaxProps))

	-- is the number of properties reached the max?
	if FindersKeepers.PropsCount >= FindersKeepers.MaxProps then

		-- property element name
		local windowName = "FindersKeepers_Prop" .. 1

		-- reset the element anchors
		WindowClearAnchors(windowName)

		-- anchor the property to the left corner (where the add property button used to be)
		WindowAddAnchor(windowName, "topleft", "FindersKeepersAddProp", "topleft", 20, 10 )
	end

	-- is the animation for the item active?
	if errorAnim > 0 then

		-- reduce the number by the time value
		errorAnim = errorAnim - timePassed

		-- set the border color in red
		WindowSetTintColor("FindersKeepersDescriptionTextBorder", 255, 0, 0)

	else -- set the border color to white
		WindowSetTintColor("FindersKeepersDescriptionTextBorder", 255, 255, 255)

		-- remove the error text
		LabelSetText("FindersKeepersError", L"")
	end
end

function FindersKeepers.CreateStructure()

	-- do we have a finders keepers list?
	if not ContainerWindow.FindItems then
		
		-- load the array
		ContainerWindow.SavedFindItems = CreateSaveStructureWithPlayerID(ContainerWindow.SavedFindItems)
		ContainerWindow.InitializeFindItems()
	end
end

function FindersKeepers.Clear()

	-- do we have a finders keepers list?
	FindersKeepers.CreateStructure()

	-- delete all active properties
	for i = FindersKeepers.PropsCount, 1, -1  do

		-- property window name
		local windowName = "FindersKeepers_Prop" .. i

		-- destroy the element
		if DoesWindowExist(windowName) then
			DestroyWindow(windowName)
		end
	end

	-- remove the item texture
	DynamicImageSetTexture("FindersKeepersIcon", "", 0, 0)

	-- reset the highlight color
	WindowSetTintColor("FindersKeepersFKColorButton", 255, 255, 255)

	-- reset the highlight hue id
	WindowSetId("FindersKeepersFKColor", 0)

	-- set the properties count to 0
	FindersKeepers.PropsCount = 0

	-- set id to 1
	local idx = 1

	-- first ite name
	local name = L"Item " .. idx

	-- keep trying until we find the first item
	while ContainerWindow.FindItems[name] do
		idx = idx + 1
		name = L"Item " .. idx
	end

	-- set the textbox text to the item name
	TextEditBoxSetText("FindersKeepersDescriptionTextText", name)

	-- select the first item type
	ComboBoxSetSelectedMenuItem("FindersKeepersItemType", 1)
end

function FindersKeepers.AddProp()

	-- do we have the maximum number of properties active already?
	if FindersKeepers.PropsCount >= FindersKeepers.MaxProps then
		return
	end
	
	-- increase the current properties count number by 1
	FindersKeepers.PropsCount = FindersKeepers.PropsCount + 1

	-- current property window name
	local windowName = "FindersKeepers_Prop" .. FindersKeepers.PropsCount

	-- previous property window name
	local prevProp = "FindersKeepers_Prop" .. FindersKeepers.PropsCount -1
	
	-- create the element
	CreateWindowFromTemplate(windowName, "FindersKeepers_PropBox", "FindersKeepers")

	-- reset the element's anchors
	WindowClearAnchors(windowName)

	-- is this the first element?
	if FindersKeepers.PropsCount == 1 then

		-- anchor the element to the add property button
		WindowAddAnchor(windowName, "bottomleft", "FindersKeepersAddProp", "topleft", 20, 30)

	else -- anchor the item to the previous one
		WindowAddAnchor(windowName, "bottomleft", prevProp, "topleft", 0, 20)
	end
	
	-- value comparison sign
	LabelSetText(windowName .. "Sign", L">=")

	-- set the textbox value to 0
	TextEditBoxSetText(windowName .. "ValueText", L"0")
	
	-- add the option "remove"
	ComboBoxAddMenuItem(windowName .. "Prop", L"<REMOVE>")

	-- add the properties list to the combo list
	for name, data in pairsByKeys(FindersKeepers.FinalPropsList) do
		ComboBoxAddMenuItem(windowName .. "Prop", name)
	end

	-- set the property ID
	WindowSetId(windowName .. "Prop", FindersKeepers.PropsCount)
end

function FindersKeepers.OnCancel()

	-- hide the window
	WindowSetShowing("FindersKeepers", false)	
end

function FindersKeepers.OnSubmit()

	-- save the item
	local _, err = pcall(FindersKeepers.SaveItem)
	
	-- do we have an error?
	if(err ~= nil and(type(err) == "string" or type(err) == "wstring")) then

		-- set the number of loops for the animation
		local loops = 4

		-- set the time per loop
		local timePerLoop = 0.5

		-- make the error blink
		WindowStartAlphaAnimation("FindersKeepersDescriptionText", Window.AnimationType.LOOP, 1, 0.3, timePerLoop, false, 0, loops)

		-- set the loop variable to run with the timer
		errorAnim = loops

		-- do we have something else than a wstring?
		if type(err) ~= "wstring" then

			-- generic error
			err = GetStringFromTid(199)
		end

		-- show the error
		LabelSetText("FindersKeepersError", err)
	end
end

function FindersKeepers.LabelOnMouseOver()

	-- current window name
	local this = SystemData.ActiveWindow.name

	-- highlight the label
	LabelSetTextColor(this, 0, 255, 0)
end

function FindersKeepers.LabelOnMouseOverEnd()
	
	-- current window name
	local this = SystemData.ActiveWindow.name

	-- unhighlight the label
	LabelSetTextColor(this, 255, 231, 132)
end

function FindersKeepers.TypeChanged()

	-- get the new selected item index
	local idx = ComboBoxGetSelectedMenuItem(SystemData.ActiveWindow.name)

	-- get the current window name
	local windowName = WindowUtils.GetActiveDialog()
	
	-- is the index greater than 1?
	if idx > 1 then

		-- initialize the variables
		local txt 
		local obj

		-- scan the items list
		for name, data in pairs(FindersKeepers.ItemsList) do

			-- is this the selected id?
			if data.id == idx then

				-- get the item type name
				txt = wstring.lower(name)

				-- get the item type id
				obj = data.objectType[1]
				break
			end
		end

		-- show the item type image
		EquipmentData.DrawObjectIcon(obj, 0, windowName .. "Icon")
	end
end

function FindersKeepers.PropSelected()

	-- get the selected property ID
	local propId = WindowGetId(SystemData.ActiveWindow.name)

	-- get the selected index
	local idx = ComboBoxGetSelectedMenuItem(SystemData.ActiveWindow.name)

	-- current window name
	local windowName = "FindersKeepers_Prop" .. propId
	
	-- scan the properties list
	for name, data in pairs(FindersKeepers.FinalPropsList) do

		-- is this the selected property?
		if data.idx == idx then

			-- does the property has a value?
			if data.novalue then
				
				-- show comparison and value box
				WindowSetShowing(windowName .. "Sign", false)
				WindowSetShowing(windowName .. "Value", false)

			else -- hide comparison and value box
				WindowSetShowing(windowName .. "Sign", true)
				WindowSetShowing(windowName .. "Value", true)
			end

			break
		end
	end
end

function FindersKeepers.SaveItem()
	
	-- do we have a finders keepers list?
	FindersKeepers.CreateStructure()

	-- get the textbox text
	local name = FindersKeepersDescriptionTextText.Text

	-- do we have a valid name?
	if type(name) ~= "wstring" or wstring.len(name) <= 1 or not name then
		return GetStringFromTid(199)
	end

	-- does the name already exist (and we're not editing the item)?
	if ContainerWindow.FindItems[name] ~= nil and not FindersKeepers.Editing then
		return GetStringFromTid(201)
	end
	
	-- initialize the record for the item
	if not ContainerWindow.FindItems[name] then
		ContainerWindow.FindItems[name] = {}
	end

	-- get the selected item type
	local typeIdx = ComboBoxGetSelectedMenuItem("FindersKeepersItemType")

	-- do we have a valid type?
	if typeIdx > 1 then

		-- initialize the variables
		local txt 
		local obj

		-- parse the items list
		for pname, data in pairs(FindersKeepers.ItemsList) do

			-- is this the item we're looking for?
			if data.id == typeIdx then

				-- add the type data to the item record
				ContainerWindow.FindItems[name].type = {tid = data.tid, name = pname}
				break
			end
		end
	end
	
	-- is the item marked as trash?
	local trash = ButtonGetPressedFlag("FindersKeepers" .. "SetTrash" .. "Button")
	
	-- save the trash flag
	if trash then
		ContainerWindow.FindItems[name].trash = true
	else
		ContainerWindow.FindItems[name].trash = nil
	end
	
	-- do we have a type but no properties?
	if typeIdx == 1 and FindersKeepers.PropsCount == 0 then

		-- cancel the saving
		ContainerWindow.FindItems[name] = nil
		return GetStringFromTid(200)
	end
	
	-- get the hue ID
	local hue = WindowGetId("FindersKeepersFKColor")

	-- do we have a valid hue?
	if IsValidID(hue) then
		ContainerWindow.FindItems[name].hue = hue

	else -- if no hue is specified, we use the default value 0 
		ContainerWindow.FindItems[name].hue = 0
	end
	
	-- do we have properties specified?
	if FindersKeepers.PropsCount > 0 then

		-- initialize the properties count
		local pId = 0

		-- scan all properties
		for propId = 1, FindersKeepers.PropsCount do

			-- current property window name
			local windowName = "FindersKeepers_Prop" .. propId
			
			-- get the selected property ID
			local pidx = ComboBoxGetSelectedMenuItem(windowName .. "Prop")

			-- no property selected or 1? we can ignore it
			if not pidx or pidx <= 1 then
				continue
			end

			-- increase the properties count
			pId = pId + 1

			-- scan the complete the properties list
			for pname, data in pairs(FindersKeepers.FinalPropsList) do

				-- is this the current property?
				if data.idx == pidx then
					
					-- initialize the properties array for the item if is missing
					if not ContainerWindow.FindItems[name].Props then
						ContainerWindow.FindItems[name].Props = {}
					end

					-- does the property has a value?
					if data.novalue then
						ContainerWindow.FindItems[name].Props[propId] = {tid = data.tid, name = pname}

					else -- get the specified value
						local value = tostring(TextEditBoxGetText(windowName .. "ValueText"))
						value = tonumber(value)

						-- do we have a valid value? if not we use 0 as default
						if not tonumber(value) then
							value = 0
						end

						-- add the property to the array
						ContainerWindow.FindItems[name].Props[pId] = {tid = data.tid, name = pname, param = data.param, value = value}
					end

					break
				end
			end
		end
	end

	-- turn off the editing flag (if it was active)
	FindersKeepers.Editing = false

	-- hide the finders keeper window
	WindowSetShowing("FindersKeepers", false)

	-- update the list
	SettingsWindow.ForceSelectTab(SettingsWindow.ActiveTab)
end

function FindersKeepers.RemoveItem()

	-- current window name
	local this = WindowGetParent(SystemData.ActiveWindow.name)

	-- current window label
	local label = this .. "Label"
	
	-- get the item name from the label
	local itemName = LabelGetText(label)

	-- clean the item name from "(Trash)"
	itemName = wstring.gsub(itemName, L"[(]Trash[)] ", L"")
	
	-- initialize the confirm dialog butttons
	local yesButton = { textTid = SettingsWindow.TID_YES, callback = function() ContainerWindow.FindItems[itemName] = nil SettingsWindow.ForceSelectTab(SettingsWindow.ActiveTab) end }
	local noButton = { textTid = SettingsWindow.TID_NO }

	-- create the confirm dialog data array
	local windowData = 
	{
		windowName = "Root", 
		titleTid = 1154777, -- Remove?
		bodyTid = 202, 
		buttons = { yesButton, noButton },
		closeCallback = noButton.callback,
		destroyDuplicate = true,
	}

	-- show the confirm dialog
	UO_StandardDialog.CreateDialog(windowData)
end

function FindersKeepers.EditItem()

	-- show finders keepers window
	WindowSetShowing("FindersKeepers", true)

	-- clear the properties list
	FindersKeepers.Clear()
	
	-- current item window name
	local this = SystemData.ActiveWindow.name
	
	-- get the item name from the label
	local itemName = LabelGetText(this)

	-- clean the item name from "(Trash)"
	itemName = wstring.gsub(itemName, L"[(]Trash[)] ", L"")
	
	-- does the item exist?
	if ContainerWindow.FindItems[itemName] then

		-- get the item data
		local item = ContainerWindow.FindItems[itemName]

		-- fill the textbox with the item name
		TextEditBoxSetText("FindersKeepersDescriptionTextText", itemName)
		
		-- do we have a type specified?
		if not item.type then

			-- use "ANY" as default type
			ComboBoxSetSelectedMenuItem("FindersKeepersItemType", 1)

		else -- select the specified type name from the combo
			ComboBoxSetSelectedMenuItem("FindersKeepersItemType", FindersKeepers.ItemsList[item.type.name].id)

			-- show the specified type image
			EquipmentData.DrawObjectIcon(FindersKeepers.ItemsList[item.type.name].objectType[1], 0, "FindersKeepersIcon")
		end
		
		-- does the item have a hue specified?
		if item.hue then
			
			-- get the hue rgb
			local r, g, b = HueRGBAValue(item.hue)

			-- show the color in the button
			WindowSetTintColor("FindersKeepersFKColorButton", r, g, b)
		end
		
		-- is this a trash item?
		if item.trash then

			-- flag the checkbox
			ButtonSetPressedFlag("FindersKeepers" .. "SetTrash" .. "Button", true)
		end
		
		-- do we have properties specified?
		if item.Props then

			-- scan all the specified properties
			for propId, data in pairsByKeys(item.Props) do

				-- add a new property
				FindersKeepers.AddProp()

				-- property window name
				local windowName = "FindersKeepers_Prop" .. propId

				-- property data
				local prop = FindersKeepers.FinalPropsList[data.name]

				-- select the property into on the combo box
				ComboBoxSetSelectedMenuItem(windowName .. "Prop", prop.idx)

				-- does the property have a value?
				if not prop.novalue then

					-- show the specified value
					TextEditBoxSetText(windowName .. "ValueText" , towstring(data.value))

				else -- hide the comparison sign
					WindowSetShowing(windowName .. "Sign", false)

					-- hide the value
					WindowSetShowing(windowName .. "Value", false)
				end
			end
		end
	end

	-- activate the editing flag
	FindersKeepers.Editing = true
end

function FindersKeepers.ClearSettingsList()

	-- parent window name
	local parent = "SettingsList"

	-- delete the container
	if DoesWindowExist(parent .. "FKItems") then
		DestroyWindow(parent .. "FKItems")
	end

	-- delete the add button
	if DoesWindowExist(parent .. "FKItems" .. "AddButton") then
		DestroyWindow(parent .. "FKItems" .. "AddButton")
	end

	-- delete the import button
	if DoesWindowExist(parent .. "FKItems" .. "ImportButton") then
		DestroyWindow(parent .. "FKItems" .. "ImportButton")
	end

	-- scan all created items
	for i = 1, FindersKeepers.CreatedItems do

		-- current item name
		local windowName = parent .. "FKItems" .. "FindersKeepers_Item" .. i

		-- does the element exist?
		if DoesWindowExist(windowName) then

			-- destroy the window
			DestroyWindow(windowName)
		end
	end

	-- set the current items number to 0
	FindersKeepers.CreatedItems = 0
end

function FindersKeepers.TrashTooltip()

	-- current window name
	local windowName = SystemData.ActiveWindow.name

	-- set tooltip text
	Tooltips.CreateTextOnlyTooltip(windowName, GetStringFromTid(211))
end

function FindersKeepers.UpdateSettingsList(subsection)

	-- do we have a valid subsection window?
	if not IsValidString(subsection) or not DoesWindowExist(subsection) then
		return
	end

	-- clear the list first
	FindersKeepers.ClearSettingsList()

	-- parent window to anchor the items
	local parent = "SettingsList"

	-- create the container window
	CreateWindowFromTemplate(parent .. "FKItems", "EmptyContainerWindow", parent)
	
	-- reset the container anchors
	WindowClearAnchors(parent .. "FKItems")

	-- anchor the container window to the subsection
	WindowAddAnchor(parent .. "FKItems", "bottomleft", subsection, "topleft", 0, 20)

	-- update the parent name
	parent = parent .. "FKItems"

	-- add item button window
	local addButtonName = parent .. "AddButton"

	-- create the add item button
	CreateWindowFromTemplate(addButtonName, "FindersKeepersAddButton", parent)
	
	-- reset the button anchors
	WindowClearAnchors(addButtonName)

	-- anchor the container window properly
	WindowAddAnchor(addButtonName, "topleft", parent, "topleft", 26, 5)

	-- fill button text
	ButtonSetText(addButtonName, GetStringFromTid(2005))

	-- import button window
	local importButtonName = parent .. "ImportButton"

	-- create the button
	CreateWindowFromTemplate(importButtonName, "FindersKeepersImportButton", parent)
	
	-- reset the button anchors
	WindowClearAnchors(importButtonName)

	-- anchor the container window properly
	WindowAddAnchor(importButtonName, "right", addButtonName, "left", 10, 0)

	-- fill button text
	ButtonSetText(importButtonName, GetStringFromTid(2026))

	-- we hide the import button if there is nothing to import
	if not Interface.ExportedSettings then
		WindowSetShowing(importButtonName, false)
	end

	-- get the button height
	local w, h = WindowGetDimensions(addButtonName)

	-- total height (start with the button height + top border
	local height = h + 5

	-- initialize the items count
	local count = 0

	-- do we have any items?
	if ContainerWindow.FindItems then

		-- scan all the items
		for name, data in pairsByKeys(ContainerWindow.FindItems) do

			-- increase the count
			count = count + 1

			-- current item window name
			local windowName = parent .. "FindersKeepers_Item" .. count

			-- previous item window name
			local prevProp = parent .. "FindersKeepers_Item" .. count - 1
		
			-- create the item
			CreateWindowFromTemplate(windowName, "SettingsFindersKeepersItem", parent)

			-- reset the item anchors
			WindowClearAnchors(windowName)

			-- is this the first item?
			if count == 1 then

				-- anchor it to the button
				WindowAddAnchor(windowName, "bottomleft", addButtonName, "topleft", 0, 20)

			else -- anchor the item to the previous one
				WindowAddAnchor(windowName, "bottomleft", prevProp, "topleft", 0, 20)
			end

			-- is this a trash item?
			if data.trash then

				-- add "(Trash)" to the name
				name = L"(Trash) " .. name
			end

			-- fill the text label
			LabelSetText(windowName .. "Label", name)

			-- do we have a hue specified?
			if data.hue then
				
				-- get the hue rgb
				local r, g, b = HueRGBAValue(data.hue)

				-- color the label with the specified color
				LabelSetTextColor(windowName .. "Label", r, g, b)
			end

			-- get the current window dimensions
			w, h = WindowGetDimensions(windowName)

			-- do we have an item type specified?
			if data.type then

				-- get the item type
				local obj = FindersKeepers.ItemsList[data.type.name].objectType[1]

				-- show the item type
				EquipmentData.DrawObjectIcon(obj, 0, windowName .. "Icon")

				-- get the item icon dimensions
				_, h = WindowGetDimensions(windowName .. "Icon")
			end

			-- update the element with the correct height
			WindowSetDimensions(windowName, w, h)

			-- update the total height
			height = height + h + 20
		end
	end

	-- update the items count
	FindersKeepers.CreatedItems = count

	-- update the container size
	WindowSetDimensions(parent, 700, height)

	-- we return the height of the selection and the name of the last item
	return parent
end

function FindersKeepers.ImportItems()
	
	-- do we have a finders keepers list?
	FindersKeepers.CreateStructure()

	-- do we have any finders keepers data to import?
	if not Interface.ExportedSettings.FindersKeepers then
		return
	end

	-- scan all the items to import
	for name, data in pairs(Interface.ExportedSettings.FindersKeepers) do

		-- initialize the record for the item
		if not ContainerWindow.FindItems[name] then
			ContainerWindow.FindItems[name] = {}
		end

		-- copy the item data
		ContainerWindow.FindItems[name] = table.copy(data)
	end
end