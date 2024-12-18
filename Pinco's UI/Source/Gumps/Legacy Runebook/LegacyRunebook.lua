
----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------


----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------
LegacyRunebook ={}
LegacyRunebook.knownWindows = {}
LegacyRunebook.selectRuneType = {}
LegacyRunebook.NumActiveRunes = {}

LegacyRunebook.NUM_DEFAULT_LABELS = 7
LegacyRunebook.CHARGE_LABEL = 8
LegacyRunebook.KeymapTID = { 1011299, 1011298, 1077594, 1077595, 1062723, 1062724, 1011300, 1011296, }
LegacyRunebook.TID_LegacyRunebook = 1028901
LegacyRunebook.KeymapLabel = { "RenameBook", "DropRune", "Recall", "RecallSpell", "GateTravel", "Sacred", "SetDefault", "Charges",}

LegacyRunebook.ButtonIdLoc = {9, 199, 9, 49, 99, 74, 299}
LegacyRunebook.Hues = { malas = 1102, trammel = 10, tokuno = 1154, felucca = 81, termur=1645 }
LegacyRunebook.RuneColor = {purple = "LegacyPurpleRuneTemplate", torquoise = "LegacyTorquoiseRuneTemplate", gray = "LegacyGrayRuneTemplate", green = "LegacyGreenRuneTemplate", brown = "LegacyBrownRuneTemplate"}
LegacyRunebook.LegacyLabelColors = 
{ 
	malas = { r = 146, g = 73, b = 0 }, 
	trammel = { r = 73, g = 0, b = 146 }, 
	tokuno = { r = 0, g = 50, b = 0 }, 
	felucca = { r = 10, g = 90, b = 90 }, 
	termur = { r = 0, g = 109, b = 219 } 
}

LegacyRunebook.DefaultNum = {}
LegacyRunebook.DefaultNum.RENAME_BOOK		= 1
LegacyRunebook.DefaultNum.DROP_RUNE		= 2
LegacyRunebook.DefaultNum.RECALL			= 3
LegacyRunebook.DefaultNum.GATE_TRAVEL		= 4
LegacyRunebook.DefaultNum.SACRED			= 5
LegacyRunebook.DefaultNum.SET_DEFAULT		= 7

-- Local Defaults for button matching to data from server
local NUM_LegacyRunebook_PAGE_END = 16
local NUM_ADD_STRING = 2
local COORDS_START_STRING = 24

LegacyRunebook.CHARGES_STRING = 19
LegacyRunebook.MAXCHARGES_STRING = 20

LegacyRunebook.SelectItemLabel = { r=200, g=0, b=0, a=255} -- Orange (Selected rune)
LegacyRunebook.DefaultItemLabel = { r=50, g=50, b=0, a=255} -- bottom label color
LegacyRunebook.BlackItemLabel = { r=25, g=25, b=0, a=255} --Black (rune coords color)
LegacyRunebook.DefaultRuneLabel = { r=0, g=102, b=0, a=255} -- bottom label color
LegacyRunebook.DisabledAlpha = 0.5
LegacyRunebook.EnableAlpha = 1

LegacyRunebook.ObjectId = 0

LegacyRunebook.DefaultSpell = 7

LegacyRunebook.CurrentWin = ""

LegacyRunebook.CurrCharges = 0

LegacyRunebook.LockedDown = false

----------------------------------------------------------------
-- LegacyRunebook Functions
----------------------------------------------------------------
function LegacyRunebook.CreateRuneButton(parent, number, color)
	local index = number
	local runeButtonName = parent.."RuneButton"..tostring(index)
	local buttonName = parent.."RuneButton"..tostring(index).."Icon"
	local colorTemplate
	
	if (color == LegacyRunebook.Hues.trammel) then
		colorTemplate = LegacyRunebook.RuneColor.purple
	elseif (color == LegacyRunebook.Hues.felucca) then
		colorTemplate = LegacyRunebook.RuneColor.torquoise
	elseif (color == LegacyRunebook.Hues.malas) then
		colorTemplate = LegacyRunebook.RuneColor.gray
	elseif (color == LegacyRunebook.Hues.tokuno) then
		colorTemplate = LegacyRunebook.RuneColor.green
	else
		colorTemplate = LegacyRunebook.RuneColor.brown
	end
	
	CreateWindowFromTemplate(runeButtonName, colorTemplate, parent)
	ButtonSetStayDownFlag(buttonName,true)
	WindowSetId(buttonName, index)
	WindowSetId(runeButtonName, index)
	
	if (index == 1) then
		WindowAddAnchor(runeButtonName, "topleft", parent.."First", "topleft", 15, 20)
	elseif (index == 9) then
		WindowAddAnchor(runeButtonName, "topleft", parent.."Second", "topleft", 15, 20)
	else
		WindowAddAnchor(runeButtonName, "bottomleft", parent.."RuneButton"..index-1, "topleft", 0, 0)
	end
end

function LegacyRunebook.CreateRuneWindows(data)
	self = {}
	self = data
	local color = 0
	local windowName = self.windowName
	local flagEmptyStart = false

	local defaultRune = Interface.LoadSetting("RunebookDefaultRune_" .. LegacyRunebook.ObjectId, -1 )

	LegacyRunebook.LockedDown = false

	local props = ItemProperties.GetObjectPropertiesTid(Interface.LastItem, _, "Runebook get locked down/secure")	
	if props then
		for id, tid in pairs(props) do	
			if tid == 501643 or tid == 501644 then
				LegacyRunebook.LockedDown  = true
				break
			end
		end
	end

	WindowSetShowing(windowName.."RenameBook", not LegacyRunebook.LockedDown)
	WindowSetShowing(windowName.."DropRune", not LegacyRunebook.LockedDown)


	for index = 1, LegacyRunebook.NumActiveRunes[windowName] do
		local buttonName = windowName.."RuneButton"..tostring(index).."Icon"
		local labelName = windowName.."RuneButton"..tostring(index).."Name"
		local textString = self.stringData[NUM_ADD_STRING+index]
		color = self.textHueData[index]
		LegacyRunebook.CreateRuneButton(windowName, index, color)
		
		local labelColor = LegacyRunebook.DefaultItemLabel
		if defaultRune ~= index then
			if (color == LegacyRunebook.Hues.trammel) then
				labelColor = LegacyRunebook.LegacyLabelColors.trammel
			elseif (color == LegacyRunebook.Hues.felucca) then
				labelColor = LegacyRunebook.LegacyLabelColors.felucca
			elseif (color == LegacyRunebook.Hues.malas) then
				labelColor = LegacyRunebook.LegacyLabelColors.malas
			elseif (color == LegacyRunebook.Hues.tokuno) then
				labelColor = LegacyRunebook.LegacyLabelColors.tokuno
      elseif (color == LegacyRunebook.Hues.termur) then
        	labelColor = LegacyRunebook.LegacyLabelColors.termur
			end
		else
			labelColor = LegacyRunebook.DefaultRuneLabel
			LabelSetFont(labelName, "Arial_Black_15", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
			WindowClearAnchors(labelName)
			WindowAddAnchor(labelName, "topright", buttonName, "topleft",  3, -1)
		end
		
		LabelSetText( labelName, L""..textString)
		LabelSetTextColor( labelName, labelColor.r, labelColor.g, labelColor.b )
		
		local text = tostring(textString)
		if (text == "Empty") then
			ButtonSetDisabledFlag( buttonName, true )
			if (flagEmptyStart == false) then

				LegacyRunebook.NumActiveRunes[windowName] = index - 1
			end
			flagEmptyStart = true
		end
		color = 2
	end	
	WindowAssignFocus(windowName, true)	
end

function LegacyRunebook.ResetRuneDefaultIconText(data)
	self = {}
	self = data
	
	local defaultRune = Interface.LoadSetting("RunebookDefaultRune_" .. LegacyRunebook.ObjectId, -1 )
	
	local windowName = self.windowName
	for index = 1, LegacyRunebook.NumActiveRunes[windowName] do
		local buttonName = windowName.."RuneButton"..tostring(index).."Icon"
		local labelName = windowName.."RuneButton"..tostring(index).."Name"

        color = self.textHueData[index]
		local labelColor = LegacyRunebook.DefaultItemLabel
		if defaultRune ~= index then
		    if (color == LegacyRunebook.Hues.trammel) then
				labelColor = LegacyRunebook.LegacyLabelColors.trammel
			elseif (color == LegacyRunebook.Hues.felucca) then
				labelColor = LegacyRunebook.LegacyLabelColors.felucca
			elseif (color == LegacyRunebook.Hues.malas) then
				labelColor = LegacyRunebook.LegacyLabelColors.malas
			elseif (color == LegacyRunebook.Hues.tokuno) then
				labelColor = LegacyRunebook.LegacyLabelColors.tokuno
			end
		else
			labelColor = LegacyRunebook.DefaultRuneLabel
			LabelSetFont(labelName, "Arial_Black_15", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
			WindowClearAnchors(labelName)
			WindowAddAnchor(labelName, "topright", buttonName, "topleft", 3, -1)
        end
		LabelSetTextColor( labelName, labelColor.r, labelColor.g, labelColor.b )
	end
end

function LegacyRunebook.EnableDefaultButtons(windowName)
	buttonName = windowName.."CoordsIcon"
	ButtonSetDisabledFlag( buttonName, false )
	
	for i = 2, LegacyRunebook.NUM_DEFAULT_LABELS do
		buttonName = windowName..LegacyRunebook.KeymapLabel[i].."Icon"
		labelName = windowName..LegacyRunebook.KeymapLabel[i]	
		
		local defaultRune = Interface.LoadSetting("RunebookDefaultRune_" .. LegacyRunebook.ObjectId, -1 )
		if LegacyRunebook.CurrentSelection == defaultRune and LegacyRunebook.KeymapLabel[i] == "SetDefault" then
			ButtonSetDisabledFlag( buttonName, true )
			WindowSetFontAlpha( labelName, LegacyRunebook.DisabledAlpha )
		else
			ButtonSetDisabledFlag( buttonName, false )
			WindowSetFontAlpha( labelName, LegacyRunebook.EnableAlpha )
		end	
		
	end
end

function LegacyRunebook.DisableDefaultButtons(windowName)
	buttonName = windowName..LegacyRunebook.KeymapLabel[LegacyRunebook.DefaultNum.RENAME_BOOK].."Icon"
	ButtonSetPressedFlag( buttonName, false )
	
	--Set the Coords Texture to the disabled texture
	buttonName = windowName.."CoordsIcon"
	ButtonSetDisabledFlag( buttonName, true )
	
	for i = 2, LegacyRunebook.NUM_DEFAULT_LABELS do
		buttonName = windowName..LegacyRunebook.KeymapLabel[i].."Icon"
		labelName = windowName..LegacyRunebook.KeymapLabel[i]
		ButtonSetDisabledFlag( buttonName, true )
		ButtonSetPressedFlag( buttonName, false )
		WindowSetFontAlpha( labelName, LegacyRunebook.DisabledAlpha )
	end
end

function LegacyRunebook.SelectedRuneLocation(windowData, runeNum)
	self = {}
	self = windowData
	local windowName = self.windowName
	
	LegacyRunebook.selectRuneType[windowName] = runeNum
			
    for index = 1, NUM_LegacyRunebook_PAGE_END do
		local buttonName = windowName.."RuneButton"..tostring(index).."Icon"
        ButtonSetPressedFlag( buttonName, LegacyRunebook.selectRuneType[windowName] == index )
    end
end

-- labels for bottom menu and rename LegacyRunebook
function LegacyRunebook.ResetDefaultIconText(data)
	--Debug.Print("In LegacyRunebook Reset Default Icon")
	
	self = {}
	self = data
	local windowName = self.windowName

	--Name is called differently for charges
	local labelName = windowName..LegacyRunebook.KeymapLabel[LegacyRunebook.CHARGE_LABEL]
	local numCharges = self.stringData[LegacyRunebook.CHARGES_STRING]
	local maxCharges = self.stringData[LegacyRunebook.MAXCHARGES_STRING]
	LegacyRunebook.CurrCharges = tonumber(numCharges)
	LabelSetText( labelName, L""..GetStringFromTid(LegacyRunebook.KeymapTID[LegacyRunebook.CHARGE_LABEL])..numCharges..L"/"..maxCharges)
	LabelSetTextColor( labelName, LegacyRunebook.DefaultItemLabel.r, LegacyRunebook.DefaultItemLabel.g, LegacyRunebook.DefaultItemLabel.b )

	local PlayerHuman = GetMobileRace(GetPlayerID()) == PaperdollWindow.HUMAN

	for i = 1, LegacyRunebook.NUM_DEFAULT_LABELS do
		local currButtonName = windowName..LegacyRunebook.KeymapLabel[i]
		buttonName = windowName..LegacyRunebook.KeymapLabel[i].."Icon"
		labelName = windowName..LegacyRunebook.KeymapLabel[i].."Name"
		WindowSetId(currButtonName, i)
		WindowSetId(buttonName, i)
		LabelSetText( labelName, L""..GetStringFromTid(LegacyRunebook.KeymapTID[i]))
		LabelSetTextColor( labelName, LegacyRunebook.DefaultItemLabel.r, LegacyRunebook.DefaultItemLabel.g, LegacyRunebook.DefaultItemLabel.b )
		LegacyRunebook.DisableDefaultButtons(windowName)
		
		--[[
		if ((WindowData.SkillDynamicData[GumpsParsing.SpellSchools.MAGERY].TempSkillValue >= 230 or BuffDebuff.ActiveBuffs[1124]) and LegacyRunebook.KeymapLabel[i] == "RecallSpell") then
			WindowSetShowing(windowName..LegacyRunebook.KeymapLabel[i], true)
		elseif ((WindowData.SkillDynamicData[GumpsParsing.SpellSchools.MAGERY].TempSkillValue < 230 and not BuffDebuff.ActiveBuffs[1124]) and LegacyRunebook.KeymapLabel[i] == "RecallSpell") then
			WindowSetShowing(windowName..LegacyRunebook.KeymapLabel[i], false)
		end
		
		if (WindowData.SkillDynamicData[GumpsParsing.SpellSchools.MAGERY].TempSkillValue >= 660 and LegacyRunebook.KeymapLabel[i] == "GateTravel") then
			WindowSetShowing(windowName..LegacyRunebook.KeymapLabel[i], true)
		elseif (WindowData.SkillDynamicData[GumpsParsing.SpellSchools.MAGERY].TempSkillValue < 660 and LegacyRunebook.KeymapLabel[i] == "GateTravel") then
			WindowSetShowing(windowName..LegacyRunebook.KeymapLabel[i], false)
		end
		--]]
		if ((WindowData.SkillDynamicData[GumpsParsing.SpellSchools.CHIVALRY].TempSkillValue >= 150 or PlayerHuman) and WindowData.PlayerStatus["TithingPoints"] and WindowData.PlayerStatus["TithingPoints"] > 15 and LegacyRunebook.KeymapLabel[i] == "Sacred") then
			WindowSetShowing(windowName..LegacyRunebook.KeymapLabel[i], true)
		elseif (((WindowData.SkillDynamicData[GumpsParsing.SpellSchools.CHIVALRY].TempSkillValue < 150 and not PlayerHuman) or (WindowData.PlayerStatus["TithingPoints"] and WindowData.PlayerStatus["TithingPoints"] < 15)) and LegacyRunebook.KeymapLabel[i] == "Sacred") then
			WindowSetShowing(windowName..LegacyRunebook.KeymapLabel[i], false)
		end
		
		if (tonumber(numCharges) > 0 and LegacyRunebook.KeymapLabel[i] == "Recall") then
			WindowSetShowing(windowName..LegacyRunebook.KeymapLabel[i], true)
		elseif (tonumber(numCharges) <= 0 and LegacyRunebook.KeymapLabel[i] == "Recall") then
			WindowSetShowing(windowName..LegacyRunebook.KeymapLabel[i], false)
		end
	end
	
	-- Set Default Method addon
	local DefaultSpell = GetStringFromTid(1155308) -- Disabled
	
	if LegacyRunebook.DefaultSpell == 3 then
		DefaultSpell = GetStringFromTid(LegacyRunebook.KeymapTID[3]) -- Recall (Charge)
	end
	
	if LegacyRunebook.DefaultSpell == 4 then
		DefaultSpell = GetStringFromTid(LegacyRunebook.KeymapTID[4]) -- Recall (Spell)
	end

	if LegacyRunebook.DefaultSpell == 5 then
		DefaultSpell = GetStringFromTid(LegacyRunebook.KeymapTID[5]) -- Gate Travel
	end

	if LegacyRunebook.DefaultSpell == 6 then
		DefaultSpell = GetStringFromTid(LegacyRunebook.KeymapTID[6]) -- Sacred Journey
	end
	
	LabelSetText( windowName.."SelectSpellName", DefaultSpell)
	WindowSetId(windowName.."SelectSpellName", 7)
	WindowSetId(windowName.."SelectSpellIcon", 7)
	LabelSetTextColor( windowName.."SelectSpellName", LegacyRunebook.DefaultItemLabel.r, LegacyRunebook.DefaultItemLabel.g, LegacyRunebook.DefaultItemLabel.b )
end

-- OnInitialize Handler
function LegacyRunebook.Initialize()
	self = {}
	if (UO_GenericGump.retrieveWindowData( self )) then
		LegacyRunebook.CurrentWin = WindowUtils.GetActiveDialog()
		LegacyRunebook.DefaultSpell = Interface.LoadSetting("RunebookDefaultSpell", LegacyRunebook.DefaultSpell)
		--Set my LegacyRunebook data to use later
		LegacyRunebook.knownWindows[self.windowName] = self
		local windowName = self.windowName
		LegacyRunebook.NumActiveRunes[windowName] = NUM_LegacyRunebook_PAGE_END
		LegacyRunebook.ResetDefaultIconText(self)
		LegacyRunebook.CreateRuneWindows(self)
		LegacyRunebook.ObjectId = self.objectID
		LegacyRunebook.CurrentSelection = -1
		local locWindowName = windowName.."Location"
		WindowSetShowing(locWindowName, false)
		
		WindowSetScale(WindowUtils.GetActiveDialog(), 0.88)
		Interface.OnCloseCallBack[self.windowName] = GGManager.destroyActiveWindow
		WindowSetShowing(windowName .. "Chrome", false)
		GGManager.registerWindow(self.windowName, self)
		self.broadcastHasBeenSent = false 
		WindowUtils.RestoreWindowPosition(WindowUtils.GetActiveDialog(), false, "LEGACY_Runebook_GUMP")
		WindowUtils.LoadScale( self.windowName )
		LegacyRunebook.ResetRuneDefaultIconText(self)
	end
end

function LegacyRunebook.ResetData(windowName)
	LegacyRunebook.knownWindows[windowName] = nil
	LegacyRunebook.selectRuneType[windowName] = nil
	LegacyRunebook.NumActiveRunes[windowName] = nil
end

function LegacyRunebook.DestroyWindow(myWindowName)
	
	LegacyRunebook.ResetData(myWindowName)
	GGManager.destroyWindow( myWindowName, GGManager.DONT_DELETE_DATA_YET )
end
	
function LegacyRunebook.Shutdown()
	local windowName = SystemData.ActiveWindow.name
	local self = LegacyRunebook.knownWindows[windowName]
	
	if self ~= nil and self.broadcastHasBeenSent == false then
		--Returns 0 to close the window and do nothing
		UO_GenericGump.broadcastButtonPress( 0, self )
		self.broadcastHasBeenSent = true
	end
	
	LegacyRunebook.ResetData(windowName)
	--Save actual Position GG Manger has a bug and is not saving it
	WindowUtils.SaveWindowPosition(windowName, false, "LEGACY_Runebook_GUMP")
	GGManager.unregisterActiveWindow()
end

function LegacyRunebook.UpdateCoordTextandLoc(runeData)
	local self = {}
	self = runeData

	local windowName = self.windowName
	local selectedRune = LegacyRunebook.selectRuneType[windowName]
	local coordName = windowName.."CoordsName"
	local coordsNum 
	-- If selected Rune is the first rune, do not add two to get the coord data
	if (selectedRune == 1) then
		coordsNum = COORDS_START_STRING 
	else
		coordsNum = selectedRune + COORDS_START_STRING - 1
	end
	--Debug.Print( tostring(coordsNum))
	local secondCoordNum = coordsNum+1
	local coordText = self.stringData[coordsNum] -- ..L"\n"..self.stringData[secondCoordNum]
	LabelSetText(coordName, coordText)
	LabelSetTextColor( coordName, LegacyRunebook.BlackItemLabel.r, LegacyRunebook.BlackItemLabel.g, LegacyRunebook.BlackItemLabel.b )
	
	--Show the text of the selected rune location
	local locWindowName = windowName.."Location"
	local locName = locWindowName.."Name"
	local labelName = windowName.."RuneButton"..tostring(selectedRune).."Name"
	local locText = LabelGetText(labelName)
	LabelSetText(locName, locText)
	LabelSetTextColor( locName, 10, 10, 0)  -- color for selected rune text
	WindowSetShowing(locWindowName, true)

end

function LegacyRunebook.OnRuneClicked()
	local windowName = WindowUtils.GetActiveDialog()
	local buttonNum = WindowGetId(SystemData.ActiveWindow.name)
	local self = LegacyRunebook.knownWindows[windowName]
	
	if (self) then
		
		local windowName = self.windowName
		if (buttonNum <= LegacyRunebook.NumActiveRunes[windowName]) then
			LegacyRunebook.ResetRuneDefaultIconText(self)
			LegacyRunebook.SelectedRuneLocation(self, buttonNum)
			LegacyRunebook.CurrentSelection = buttonNum
			LegacyRunebook.UpdateCoordTextandLoc(self)
			LegacyRunebook.EnableDefaultButtons(windowName)
			local labelName = windowName.."RuneButton"..tostring(buttonNum).."Name"
			LabelSetTextColor( labelName, LegacyRunebook.SelectItemLabel.r, LegacyRunebook.SelectItemLabel.g, LegacyRunebook.SelectItemLabel.b )
		end
	end
end

function LegacyRunebook.OnRuneDBLClicked()
	local windowName = WindowUtils.GetActiveDialog()
	local buttonNum = WindowGetId(SystemData.ActiveWindow.name)
	local self = LegacyRunebook.knownWindows[windowName]
	if (self) then
		
		local windowName = self.windowName
		if (buttonNum <= LegacyRunebook.NumActiveRunes[windowName]) then
			LegacyRunebook.ResetRuneDefaultIconText(self)
			LegacyRunebook.SelectedRuneLocation(self, buttonNum)
			LegacyRunebook.CurrentSelection = buttonNum
			LegacyRunebook.UpdateCoordTextandLoc(self)
			LegacyRunebook.EnableDefaultButtons(windowName)
			local labelName = windowName.."RuneButton"..tostring(buttonNum).."Name"
			LabelSetTextColor( labelName, LegacyRunebook.SelectItemLabel.r, LegacyRunebook.SelectItemLabel.g, LegacyRunebook.SelectItemLabel.b )
		end
	end
	if LegacyRunebook.DefaultSpell ~= 7 then
		LegacyRunebook.SendServerButtonInfo(LegacyRunebook.DefaultSpell, self)
	end 
end

LegacyRunebook.CurrentSelection = 0

function LegacyRunebook.OnKeyTab()
	local windowName = WindowUtils.GetActiveDialog()
	local buttonNum = 0

	buttonNum = LegacyRunebook.CurrentSelection + 1
	 
	if LegacyRunebook.CurrentSelection < 0 then
		buttonNum = 1
	end

	if LegacyRunebook.CurrentSelection >= tonumber(LegacyRunebook.NumActiveRunes[windowName])  then
		buttonNum= 1
	end
	LegacyRunebook.CurrentSelection = buttonNum
	
	local self = LegacyRunebook.knownWindows[windowName]
	
	LegacyRunebook.ResetRuneDefaultIconText(self)
	LegacyRunebook.SelectedRuneLocation(self, buttonNum)
	LegacyRunebook.CurrentSelection = buttonNum
	LegacyRunebook.UpdateCoordTextandLoc(self)
	LegacyRunebook.EnableDefaultButtons(windowName)
	local labelName = windowName.."RuneButton"..tostring(buttonNum).."Name"
	LabelSetTextColor( labelName, LegacyRunebook.SelectItemLabel.r, LegacyRunebook.SelectItemLabel.g, LegacyRunebook.SelectItemLabel.b )
end

function LegacyRunebook.SendServerButtonInfo(buttonNumber, runeData)
	--set default buttonId to zero
	local LegacyRunebookButtonId = 0
	
	if (buttonNumber == LegacyRunebook.DefaultNum.RENAME_BOOK) then
		if (LegacyRunebook.ButtonIdLoc[buttonNumber] < runeData.buttonCount) then
			LegacyRunebookButtonId =runeData.buttonIDs[LegacyRunebook.ButtonIdLoc[buttonNumber]]
		end  
	else
		LegacyRunebookButtonId = LegacyRunebook.ButtonIdLoc[buttonNumber] + LegacyRunebook.selectRuneType[runeData.windowName]
	end
	
	if buttonNumber == 3 then -- recall (charge)
		GameData.UseRequests.UseSpellcast = 32
	elseif buttonNumber == 4 then -- recall
		GameData.UseRequests.UseSpellcast = 32
	elseif buttonNumber == 5 then -- gate travel
		GameData.UseRequests.UseSpellcast = 52
	elseif buttonNumber == 6 then -- sacred journey
		GameData.UseRequests.UseSpellcast = 210
	end
	Interface.SpellUseRequest()
	
	local windowName = runeData.windowName
	UO_GenericGump.broadcastButtonPress( LegacyRunebookButtonId, runeData )
	self.broadcastHasBeenSent = true
	
	LegacyRunebook.DestroyWindow(windowName)
end

function LegacyRunebook.DefaultSpellTooltip()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(267))
end

function LegacyRunebook.DefaultSpellContext()
	
	-- reset the context menu
	ContextMenu.CleanUp()

	ContextMenu.CreateLuaContextMenuItem({tid = 1155308, returnCode = 7, pressed = LegacyRunebook.DefaultSpell == 7}) -- Disabled
	
	for i=3, 6 do
		local toadd
		if (LegacyRunebook.CurrCharges > 0 and i == 3) then
			toadd = true
		end
		
		if ((WindowData.SkillDynamicData[GumpsParsing.SpellSchools.MAGERY].TempSkillValue >= 230 or BuffDebuff.ActiveBuffs[1124]) and i == 4) then
			toadd = true
		end
		
		if (WindowData.SkillDynamicData[GumpsParsing.SpellSchools.MAGERY].TempSkillValue >= 660 and i == 5) then
			toadd = true
		end
		
		if (WindowData.SkillDynamicData[GumpsParsing.SpellSchools.CHIVALRY].TempSkillValue >= 150 and i == 6) then
			toadd = true
		end
		
		if toadd then
			ContextMenu.CreateLuaContextMenuItem({tid = LegacyRunebook.KeymapTID[i], returnCode = i, pressed = LegacyRunebook.DefaultSpell == i})
		end
	end
	
	ContextMenu.ActivateLuaContextMenu(LegacyRunebook.DefaultSpellContextCallback)

end

function LegacyRunebook.DefaultSpellContextCallback( returnCode, param )
	local windowName = LegacyRunebook.CurrentWin 

	LegacyRunebook.DefaultSpell = returnCode
	Interface.SaveSetting( "RunebookDefaultSpell" , LegacyRunebook.DefaultSpell )
	
	-- Set Default Method addon
	local DefaultSpell = GetStringFromTid(1155308) -- Disabled
	
	if LegacyRunebook.DefaultSpell == 3 then
		DefaultSpell = GetStringFromTid(LegacyRunebook.KeymapTID[3]) -- Recall (Charge)
	end
	
	if LegacyRunebook.DefaultSpell == 4 then
		DefaultSpell = GetStringFromTid(LegacyRunebook.KeymapTID[4]) -- Recall (Spell)
	end

	if LegacyRunebook.DefaultSpell == 5 then
		DefaultSpell = GetStringFromTid(LegacyRunebook.KeymapTID[5]) -- Gate Travel
	end

	if LegacyRunebook.DefaultSpell == 6 then
		DefaultSpell = GetStringFromTid(LegacyRunebook.KeymapTID[6]) -- Sacred Journey
	end
	
	LabelSetText( windowName.."SelectSpellName", DefaultSpell)
	WindowSetId(windowName.."SelectSpellName", 7)
	WindowSetId(windowName.."SelectSpellIcon", 7)
	LabelSetTextColor( windowName.."SelectSpellName", LegacyRunebook.DefaultItemLabel.r, LegacyRunebook.DefaultItemLabel.g, LegacyRunebook.DefaultItemLabel.b )
end

function LegacyRunebook.OnDefaultClicked()
	local currWindow = WindowUtils.GetActiveDialog()
	local buttonNum = WindowGetId(SystemData.ActiveWindow.name)
	local self = LegacyRunebook.knownWindows[currWindow]
	
	if (self) then
		local windowName = self.windowName

		if buttonNum == LegacyRunebook.DefaultNum.SET_DEFAULT then
			Interface.SaveSetting("RunebookDefaultRune_" .. LegacyRunebook.ObjectId, LegacyRunebook.CurrentSelection )
			LegacyRunebook.ResetDefaultIconText(self)
			LegacyRunebook.SendServerButtonInfo(buttonNum, self)
			
		elseif ((LegacyRunebook.selectRuneType[windowName] ~= nil) or (buttonNum == LegacyRunebook.DefaultNum.RENAME_BOOK)) then
			LegacyRunebook.ResetDefaultIconText(self)
			
			local buttonName = windowName..LegacyRunebook.KeymapLabel[buttonNum].."Icon"
			local labelName = windowName..LegacyRunebook.KeymapLabel[buttonNum].."Name"
			ButtonSetPressedFlag( buttonName, true )
			LabelSetTextColor( labelName, LegacyRunebook.SelectItemLabel.r, LegacyRunebook.SelectItemLabel.g, LegacyRunebook.SelectItemLabel.b )
				--Drop Rune only when it is ok
			if (buttonNum == LegacyRunebook.DefaultNum.DROP_RUNE) then
			    local okayButton = { textTid=UO_StandardDialog.TID_OKAY, callback=function() LegacyRunebook.SendServerButtonInfo(buttonNum, self) end }
                local cancelButton = { textTid=UO_StandardDialog.TID_CANCEL, callback=function() LegacyRunebook.ResetRuneDefaultIconText(self); LabelSetTextColor( labelName, LegacyRunebook.DefaultItemLabel.r, LegacyRunebook.DefaultItemLabel.g, LegacyRunebook.DefaultItemLabel.b ) end }
				local DestroyConfirmWindow = 
				{
				    windowName = "DropRune"..currWindow,
					titleTid = 1011298,
					bodyTid  = 1155404,
					buttons = { okayButton, cancelButton },
					closeCallback = cancelButton.callback,
					destroyDuplicate = true,
				}
				UO_StandardDialog.CreateDialog(DestroyConfirmWindow)
				
				ButtonSetPressedFlag( buttonName, false )
			else
				LegacyRunebook.ResetDefaultIconText(self)
				LegacyRunebook.SendServerButtonInfo(buttonNum, self)
			end
		end
	end
	
end
