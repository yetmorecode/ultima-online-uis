----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

Spellbook = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

Spellbook.uniqueOrdinals = { L"st", L"nd", L"rd" }
Spellbook.bardMasteries = { GetStringFromTid(1044082), GetStringFromTid(1044069), GetStringFromTid(1044075) }

Spellbook.TID = {Active=1156227, Index=1156226, Passive=1112232}
Spellbook.MasteryChangeCooldown = 0

Spellbook.MasteryGumpID = 999122
CharacterSheet.NextMasteryGumpUpdate = 0

Spellbook.MasteryBookTIDs = {}
Spellbook.MasteryBookTIDs[1151945] = true -- TID_MASTERY_DISCORD		
Spellbook.MasteryBookTIDs[1151946] = true -- TID_MASTERY_PROVOCATION	
Spellbook.MasteryBookTIDs[1151947] = true -- TID_MASTERY_PEACEMAKING	
Spellbook.MasteryBookTIDs[1155771] = true -- TID_MASTERY_MAGERY		
Spellbook.MasteryBookTIDs[1155772] = true -- TID_MASTERY_MYSTICISM		
Spellbook.MasteryBookTIDs[1155773] = true -- TID_MASTERY_NECRO			
Spellbook.MasteryBookTIDs[1155774] = true -- TID_MASTERY_SPELLWEAVING	
Spellbook.MasteryBookTIDs[1155775] = true -- TID_MASTERY_BUSHIDO		
Spellbook.MasteryBookTIDs[1155776] = true -- TID_MASTERY_CHIVALRY		
Spellbook.MasteryBookTIDs[1155777] = true -- TID_MASTERY_NINJITSU		
Spellbook.MasteryBookTIDs[1155778] = true -- TID_MASTERY_FENCING		
Spellbook.MasteryBookTIDs[1155779] = true -- TID_MASTERY_MACE			
Spellbook.MasteryBookTIDs[1155780] = true -- TID_MASTERY_SWORDS		
Spellbook.MasteryBookTIDs[1155781] = true -- TID_MASTERY_THROWING		
Spellbook.MasteryBookTIDs[1155782] = true -- TID_MASTERY_PARRY			
Spellbook.MasteryBookTIDs[1155783] = true -- TID_MASTERY_POISON		
Spellbook.MasteryBookTIDs[1155784] = true -- TID_MASTERY_WRESTILING	
Spellbook.MasteryBookTIDs[1155785] = true -- TID_MASTERY_ANIMAL_TAMING	
Spellbook.MasteryBookTIDs[1155786] = true -- TID_MASTERY_ARCHERY		
Spellbook.MASTERY_COUNT = 45
Spellbook.ActiveMastery = 0
Spellbook.MAX_MASTERY_SPELL_COUNT = 3

-- Spell A, Spell B, Passive
Spellbook.ActiveMasteryIndex = {}
Spellbook.ActiveMasteryIndex[1151945] = {SpellA=705, SpellB=706,  Passive=0} 
Spellbook.ActiveMasteryIndex[1151946] = {SpellA=701, SpellB=702,  Passive=0}
Spellbook.ActiveMasteryIndex[1151947] = {SpellA=703, SpellB=704 ,  Passive=0 }
Spellbook.ActiveMasteryIndex[1155771] = {SpellA=707, SpellB=708 ,  Passive=715 }
Spellbook.ActiveMasteryIndex[1155772] = {SpellA=709, SpellB=710 ,  Passive=715 }
Spellbook.ActiveMasteryIndex[1155773] = {SpellA=711, SpellB=712 ,  Passive=715 }
Spellbook.ActiveMasteryIndex[1155774] = {SpellA=713, SpellB=714 ,  Passive=715}
Spellbook.ActiveMasteryIndex[1155775] = {SpellA=716, SpellB=717 ,  Passive=718 }
Spellbook.ActiveMasteryIndex[1155776] = {SpellA=719, SpellB=720 ,  Passive=718 }
Spellbook.ActiveMasteryIndex[1155777] = {SpellA=721, SpellB=722 ,  Passive=718 }
Spellbook.ActiveMasteryIndex[1155778] = {SpellA=725, SpellB=726 ,  Passive=733 }
Spellbook.ActiveMasteryIndex[1155779] = {SpellA=727, SpellB=728 ,  Passive=733 }
Spellbook.ActiveMasteryIndex[1155780] = {SpellA=729, SpellB=730 ,  Passive=733}
Spellbook.ActiveMasteryIndex[1155781] = {SpellA=731, SpellB=732 ,  Passive=718 }
Spellbook.ActiveMasteryIndex[1155782] = {SpellA=734, SpellB=735 ,  Passive=736 }
Spellbook.ActiveMasteryIndex[1155783] = {SpellA=737, SpellB=738 ,  Passive=739 }
Spellbook.ActiveMasteryIndex[1155784] = {SpellA=740, SpellB=741 ,  Passive=742 }
Spellbook.ActiveMasteryIndex[1155785] = {SpellA=743, SpellB=744 ,  Passive=745 }
Spellbook.ActiveMasteryIndex[1155786] = {SpellA=723, SpellB=724 ,  Passive=733 }

-- TODO: Obviously, TIDs should be in abilities.csv
Spellbook.baseTid = 1028319

-- Indexed by firstSpellNum, MAX per page is 8
Spellbook.numTabs = {}
Spellbook.numTabs[1] = 8 -- Magery
Spellbook.numTabs[101] = 3 -- Necromancy
Spellbook.numTabs[201] = 2 -- Chivalry
Spellbook.numTabs[401] = 1 -- Bushido
Spellbook.numTabs[501] = 1 -- Ninjitsu
Spellbook.numTabs[601] = 2 -- Spellweaving
Spellbook.numTabs[678] = 2 -- Mysticism
Spellbook.numTabs[701] = 1 -- Masteries

-- Indexed by firstSpellNum, MAX per page is 8
Spellbook.numSpellsPerTab = {}
Spellbook.numSpellsPerTab[1] = 8 -- Magery
Spellbook.numSpellsPerTab[101] = 8 -- Necromancy
Spellbook.numSpellsPerTab[201] = 8 -- Chivalry
Spellbook.numSpellsPerTab[401] = 8 -- Bushido
Spellbook.numSpellsPerTab[501] = 8 -- Ninjitsu
Spellbook.numSpellsPerTab[601] = 8 -- Spellweaving
Spellbook.numSpellsPerTab[678] = 8 -- Mysticism
Spellbook.numSpellsPerTab[701] = 2 -- Masteries

Spellbook.LegacyTexture = {}
Spellbook.LegacyTexture[1] = 2219 -- Magery
Spellbook.LegacyTexture[101] = 11008 -- Necromancy
Spellbook.LegacyTexture[201] = 11009 -- Chivalry
Spellbook.LegacyTexture[401] = 11015 -- Bushido
Spellbook.LegacyTexture[501] = 11014 -- Ninjitsu
Spellbook.LegacyTexture[601] = 11055 -- Spellweaving
Spellbook.LegacyTexture[678] = 11058 -- Mysticism
Spellbook.LegacyTexture[701] = 11049 -- Masteries

Spellbook.MAX_SPELLS_PER_TAB = 8

Spellbook.OpenSpellbooks ={}

----------------------------------------------------------------
-- MainMenuWindow Functions
----------------------------------------------------------------

-- OnInitialize Handler
function Spellbook.Initialize()
	
	-- getting the spellbook window name
	local this = SystemData.ActiveWindow.name

	-- make sure the window exist
	if not DoesWindowExist(this) then
		return
	end

	-- getting the current spellbook ID
	local id = SystemData.DynamicWindowId

	-- is this a valid id?
	if not IsValidID(id) then
		return
	end
	
	-- make sure the spellbook window is destroyed when closed
	Interface.DestroyWindowOnClose[this] = true

	-- is the spellbook window hidden?
	if Spellbook.IsSpellbookOpen(id) then

		-- showing the window
		WindowSetShowing(this, true)

	else -- the window has just been created
		
		-- setting the ID to the window
		WindowSetId(this, id)

		-- restoring the window position
		WindowUtils.RestoreWindowPosition(this, false, "LEGACY_Spellbook_GUMP")  

		-- initializing the record for this spellbook data
		Spellbook.OpenSpellbooks[id] = {}

		-- loading the last tab opened on this spellbook (if we don't have one, we use the first tab as default)
		Spellbook.OpenSpellbooks[id].activeTab = Interface.LoadSetting("SpellbookTab_" .. id, 1)

		-- we initialize the "tab have been created?" flag to false
		Spellbook.OpenSpellbooks[id].tabsCreated = false

		-- we initialize the number of tabs to 0
		Spellbook.OpenSpellbooks[id].numTabs = 0

		-- is this the mastery book?
		if Spellbook.IsMasteryBook(id) then
			
			-- do we have an active mastery?
			if not IsValidID(Spellbook.ActiveMastery) then

				-- get the current mastery TID
				Spellbook.ActiveMastery = Spellbook.GetCurrentMastery(id)
			end
		end

		-- register the spellbook windowdata
		Interface.GetItemSpellbookData(id)
		
		-- attach the update spells event handler to this window
		WindowRegisterEventHandler(this, WindowData.Spellbook.Event, "Spellbook.UpdateSpells")
	end
end

function Spellbook.OnShown()
	
	-- getting the spellbook window name
	local this = SystemData.ActiveWindow.name
	
	-- make sure the window exist
	if not DoesWindowExist(this) then
		return
	end

	-- getting the current spellbook ID
	local id = WindowGetId(this)

	-- is this a valid id?
	if not IsValidID(id) then
		return
	end
	
	-- register the spellbook windowdata
	RegisterWindowData(WindowData.Spellbook.Type, id)

	-- flag this spellbook as showing
	Spellbook.OpenSpellbooks[id].showing = true

	-- assign focus to the spellbook
	WindowAssignFocus(this, true)
end

function Spellbook.CreateSpellContext(spellId, param, hotbarADD)
	
	-- is a valid spell ID?
	if not IsValidID(spellId) then
		return
	end

	-- initialize an empty params array if there is no param array
	if param == nil then
		param = {}
	end

	-- if it's not a call from an hotbar slot, we can reset the context menu
	if not hotbarADD then
		ContextMenu.CleanUp()
	end
	
	-- Enchant
	if spellId == 681 then

		-- initialize the sub menu
		local subMenu = {}

		-- creating a record for the sub menu with each option
		for i, tid in pairsByIndex(SpellsInfo.EnchantContextOptions) do

			-- is this the current selection?
			local press = i == Interface.ForceEnchant

			-- copying the params
			local currParam = table.copy(param)

			-- adding the current index to the current record params
			currParam.SelectedSpellOption = i

			-- creating the record for the sub menu array containing the info for the current spell
			local item = {tid = tid, returnCode = HotbarSystem.ContextReturnCodes.SPELL_ENCHANT, param = currParam, pressed = press }

			-- adding the record to the sub menu
			table.insert(subMenu, item)
		end
		
		-- adding the sub menu to the context menu
		ContextMenu.CreateLuaContextMenuItem({tid = 1080133, subMenuOptions = subMenu})  -- Select Enchant
		
	 -- summon familiar
	elseif spellId == 112 then

		-- initialize the sub menu
		local subMenu = {}

		-- getting the current saved option
		local savedOption = Interface.ForceFamiliar

		-- can the player still use that form?
		if SpellsInfo.SumonFamiliarSkillRequirements(savedOption) == 1 then
			
			-- if not we reset the saved option
			savedOption = 0
		end

		-- creating a record for the sub menu with each option
		for i, tid in pairsByIndex(SpellsInfo.SummonFamiliarContextOptions) do

			-- is this the current selection?
			local press = i == savedOption

			-- copying the params
			local currParam = table.copy(param)

			-- adding the current index to the current record params
			currParam.SelectedSpellOption = i

			-- enabled flag
			local flag = 0

			-- if the index is not the description (0), we determine if the player can use the familiar or not
			if i ~= 0 then
				flag = SpellsInfo.SumonFamiliarSkillRequirements(i)
			end

			-- creating the record for the sub menu array containing the info for the current spell
			local item = { tid = tid, flags = flag, returnCode = HotbarSystem.ContextReturnCodes.SPELL_FAMILIAR, param = currParam, pressed = press }

			-- adding the record to the sub menu
			table.insert(subMenu, item)
		end
		
		-- adding the sub menu to the context menu
		ContextMenu.CreateLuaContextMenuItem({tid = 1060147, subMenuOptions = subMenu})  -- Choose thy familiar...

	-- animal form
	elseif spellId == 503 then 

		-- initialize the sub menu
		local subMenu = {}

		-- getting the current saved option
		local savedOption = Interface.ForceAnimal

		-- can the player still use that form?
		if SpellsInfo.AnimalFormSkillRequirements(savedOption) == 1 or savedOption == 0 then
			
			-- if not we reset the saved option
			savedOption = 1078861 -- Select
		end

		-- creating a record for the sub menu with each option
		for i, tid in pairsByIndex(SpellsInfo.AnimalFormContextOptions) do

			-- is this the current selection?
			local press = tid == savedOption

			-- copying the params
			local currParam = table.copy(param)

			-- adding the current TID to the current record params
			currParam.SelectedSpellOption = tid

			-- enabled flag
			local flag = 0

			-- if the index is not the description (1078861), we determine if the player can use the familiar or not
			if tid ~= 1078861 then
				flag = SpellsInfo.AnimalFormSkillRequirements(tid)
			end

			-- creating the record for the sub menu array containing the info for the current spell
			local item = { str = FormatProperly(GetStringFromTid(tid)), flags = flag, returnCode = HotbarSystem.ContextReturnCodes.SPELL_ANIMAL_FORM, param = currParam, pressed = press }

			-- adding the record to the sub menu
			table.insert(subMenu, item)
		end
		
		-- adding the sub menu to the context menu
		ContextMenu.CreateLuaContextMenuItem({str = WindowUtils.translateMarkup(GetStringFromTid(1063394)), subMenuOptions = subMenu})  -- Animal Form Selection Menu

	-- polymorph
	elseif spellId == 56 then 

		-- initialize the sub menu
		local subMenu = {}

		-- getting the current saved option
		local savedOption = Interface.ForcePolymorph

		-- creating a record for the sub menu with each option
		for i, tid in pairsByIndex(SpellsInfo.PolymorphContextOptions) do

			-- is this the current selection?
			local press = i == savedOption

			-- copying the params
			local currParam = table.copy(param)

			-- adding the current index to the current record params
			currParam.SelectedSpellOption = i

			-- creating the record for the sub menu array containing the info for the current spell
			local item = { str = FormatProperly(GetStringFromTid(tid)), returnCode = HotbarSystem.ContextReturnCodes.SPELL_POLYMORPH, param = currParam, pressed = press }

			-- adding the record to the sub menu
			table.insert(subMenu, item)
		end
		
		-- adding the sub menu to the context menu
		ContextMenu.CreateLuaContextMenuItem({str = WindowUtils.translateMarkup(GetStringFromTid(1015234)), subMenuOptions = subMenu})  -- Polymorph Selection Menu

	-- spell trigger
	elseif spellId == 686 then 

		-- initialize the sub menu
		local subMenu = {}

		-- getting the current saved option
		local savedOption = Interface.ForceSpellTrigger

		-- we have to convert 0 to tid (if nothing is selected)
		if savedOption == 0 then
			
			savedOption = 1078861 -- Select
		end

		-- copying the params
		local currParam = table.copy(param)

		-- adding the current TID to the current record params
		currParam.SelectedSpellOption = 1078861

		-- add the first descriptive element to the sub menu
		local item = { str = FormatProperly(GetStringFromTid(1078861)), returnCode = HotbarSystem.ContextReturnCodes.SPELL_SPELL_TRIGGER, param = currParam, pressed = (savedOption == 1078861), false }; -- Select

		-- adding the record to the sub menu
		table.insert(subMenu, item)

		-- scanning the spells list, searching for the spells used by spell trigger
		for words, tab in pairs(SpellsInfo.SpellsData) do

			-- mysticism spell, compatible with spell trigger
			if tab.id >= 678 and tab.id <= 700 and tab.spellTrigger then
				
				-- getting the tid from the CSV
				local _, _, tid  = GetAbilityData(tab.id)

				-- is this the current selection?
				local press = tid == savedOption

				-- copying the params
				currParam = table.copy(param)

				-- adding the current TID to the current record params
				currParam.SelectedSpellOption = tid

				-- enabled flag
				local flag = 0

				-- if the player can't use the current spell, we disable the button
				if not SpellsInfo.CanUseSpell(tab.id, true) then
					flag = 1
				end

				-- creating the record for the sub menu array containing the info for the current spell
				item = { str = FormatProperly(GetStringFromTid(tid)), flags = flag, returnCode = HotbarSystem.ContextReturnCodes.SPELL_SPELL_TRIGGER, param = currParam, pressed = press }

				-- adding the record to the sub menu
				table.insert(subMenu, item)
			end
		end

		-- adding the sub menu to the context menu
		ContextMenu.CreateLuaContextMenuItem({str = WindowUtils.translateMarkup(GetStringFromTid(1080151)), subMenuOptions = subMenu})  -- Spell Trigger Selection Menu

	-- combat training
	elseif spellId == 744 then 

		-- initialize the sub menu
		local subMenu = {}

		-- getting the current saved option
		local savedOption = Interface.ForceTraining

		-- creating a record for the sub menu with each option
		for i, tid in pairsByIndex(SpellsInfo.CombatTrainingContextOptions) do

			-- is this the current selection?
			local press = i == savedOption

			-- copying the params
			local currParam = table.copy(param)

			-- adding the current index to the current record params
			currParam.SelectedSpellOption = i

			-- creating the record for the sub menu array containing the info for the current spell
			local item = { str = FormatProperly(GetStringFromTid(tid)), returnCode = HotbarSystem.ContextReturnCodes.SPELL_COMBAT_TRAINING, param = currParam, pressed = press }

			-- adding the record to the sub menu
			table.insert(subMenu, item)
		end
		
		-- adding the sub menu to the context menu
		ContextMenu.CreateLuaContextMenuItem({tid = 1156113, subMenuOptions = subMenu})  -- Select Training

	end
end

function Spellbook.SpellContext()
	
	-- getting the spellbook window name
	local this = WindowUtils.GetActiveDialog()

	-- make sure the window exist
	if not DoesWindowExist(this) then
		return
	end

	-- getting the current spellbook ID
    local id = WindowGetId(this)

	-- is this a valid id?
	if not IsValidID(id) then
		return
	end

	-- getting the spellbook data
    local data = WindowData.Spellbook[id]

	-- getting the active tab 
    local page = Spellbook.GetActiveTab(id)

	-- getting the current icon ID
    local index = WindowGetId(SystemData.ActiveWindow.name)

	-- is this a mastery spellbook?
    if not Spellbook.IsMasteryBook(id) then	
		
		-- we must calculate the ID from the page and the icon ID
	    curSpell = (page - 1) * Spellbook.numSpellsPerTab[data.firstSpellNum] + index + data.firstSpellNum - 1

	else -- the spell ID is the same as the icon index
		curSpell = index
	end  

	-- getting the spell data
    local icon, serverId = GetAbilityData(curSpell)
    
	-- is this a valid spell ID (not passive)?
    if IsValidID(serverId) and not SpellsInfo.IsPassive(serverId) then
		
		-- reset the context menu
		ContextMenu.CleanUp()

		-- creating the context for this specific spell (not all spells have one)
		Spellbook.CreateSpellContext(serverId, param)
		
		-- getting the macro ID for this spell
		local macroId = MacroWindow.GetMacroId(L"SpellbookHotkey" .. serverId)

		-- if we have an hidden macro for the spell hotkey we can also change the target type (except for legacy targeting)
		if IsValidID(macroId)  and ( SystemData.Settings.GameOptions.legacyTargeting == false) then
			
			-- initialize the macro hotbar id
			local hotbarId = SystemData.MacroSystem.STATIC_MACRO_ID

			-- macro ID
			local itemIndex = macroId

			 -- our hidden macro have only 1 action inside: the spell we are analyzing.
			local subIndex = 1
			
			-- get the target type limitation
			local noSelf, cursorOnly = GetActionTargetTypes(serverId, SystemData.UserAction.TYPE_SPELL)

			-- slot window name for the target mouse over
			local slotWindow = "Macro_" .. macroId .. "_1"

			-- initializing the params
			local param = {HotbarId = hotbarId, ItemIndex = itemIndex, SubIndex = subIndex, SlotWindow = slotWindow, ActionType = SystemData.UserAction.TYPE_SPELL}

			-- does this spell support a target?
			if UserActionHasTargetType(hotbarId, itemIndex, subIndex)  then

				-- getting the current target type
				local targetType = UserActionGetTargetType(hotbarId, itemIndex, subIndex, slotWindow)

				-- initialize pressed flags array
				local pressed = { false, false, false, false, false }

				-- highlight the flag for the target type in use
				pressed[targetType+1] = true
		
				local subMenu = {}

				-- filling the menu only with target cursor
				if (cursorOnly) then
					subMenu = { {tid = HotbarSystem.TID_CURSOR, returnCode = HotbarSystem.ContextReturnCodes.TARGET_CURSOR, param = param, pressed = pressed[1+SystemData.Hotbar.TargetType.TARGETTYPE_CURSOR] } }
			
				-- filling the sub menu with all but target self
				elseif (noSelf) then
					subMenu =	{
								{tid = HotbarSystem.TID_CURSOR, returnCode = HotbarSystem.ContextReturnCodes.TARGET_CURSOR, param = param, pressed = pressed[1+SystemData.Hotbar.TargetType.TARGETTYPE_CURSOR] },
								{tid = HotbarSystem.TID_OBJECT_ID, returnCode = HotbarSystem.ContextReturnCodes.TARGET_OBJECT_ID, param = param, pressed = pressed[1+SystemData.Hotbar.TargetType.TARGETTYPE_OBJECT_ID] },
								{tid = HotbarSystem.TID_CURRENT, returnCode = HotbarSystem.ContextReturnCodes.TARGET_CURRENT, param = param, pressed = pressed[1+SystemData.Hotbar.TargetType.TARGETTYPE_CURRENT] },
								{ str = GetStringFromTid(280), returnCode = HotbarSystem.ContextReturnCodes.TARGET_MOUSEOVER, param = param, pressed = pressed[1+SystemData.Hotbar.TargetType.TARGETTYPE_MOUSEOVER] } 
								}

				else -- filling the sub menu array with all targets
					subMenu =	{
								{tid = HotbarSystem.TID_SELF, returnCode = HotbarSystem.ContextReturnCodes.TARGET_SELF, param  =param, pressed = pressed[1+SystemData.Hotbar.TargetType.TARGETTYPE_SELF] },
								{tid = HotbarSystem.TID_CURSOR, returnCode = HotbarSystem.ContextReturnCodes.TARGET_CURSOR, param = param, pressed = pressed[1+SystemData.Hotbar.TargetType.TARGETTYPE_CURSOR] },
								{tid = HotbarSystem.TID_OBJECT_ID, returnCode = HotbarSystem.ContextReturnCodes.TARGET_OBJECT_ID, param = param, pressed = pressed[1+SystemData.Hotbar.TargetType.TARGETTYPE_OBJECT_ID] },
								{tid = HotbarSystem.TID_CURRENT, returnCode = HotbarSystem.ContextReturnCodes.TARGET_CURRENT, param = param, pressed = pressed[1+SystemData.Hotbar.TargetType.TARGETTYPE_CURRENT] },
								{ str = GetStringFromTid(280), returnCode = HotbarSystem.ContextReturnCodes.TARGET_MOUSEOVER, param = param, pressed = pressed[1+SystemData.Hotbar.TargetType.TARGETTYPE_MOUSEOVER] } 
								}
				end
				
				ContextMenu.CreateLuaContextMenuItem({tid = 283, subMenuOptions = subMenu}) 
			end
		end

		-- creating new params for the spell data
		local param = {isSpell =  true, abilityId = serverId, iconId = icon, spellbookId = id, windowName = SystemData.ActiveWindow.name}

		-- assign hotkey
		ContextMenu.CreateLuaContextMenuItem({tid = HotbarSystem.TID_ASSIGN_HOTKEY, returnCode = HotbarSystem.ContextReturnCodes.ASSIGN_KEY, param = param})

		-- create the cotnext menu
		ContextMenu.ActivateLuaContextMenu(Hotbar.ContextMenuCallback)

	else -- invalid spell, something is wrong, better to close the spellbook
		Spellbook.Hide(this)
    end
end

function Spellbook.OnKeyHide()
	
	-- since the escape key always opens the main menu, we block that
	MainMenuWindow.notnow = true

	-- hiding the spellbook
	Spellbook.Hide()
end

function Spellbook.Hide(windowName)

	-- if th window specified in the parameters is invalid (or not specified), we get the active dialog instead
	if not IsValidString(windowName) or not DoesWindowExist(windowName) then
		windowName = WindowUtils.GetActiveDialog()
	end

	-- getting the spellbook ID
	local id = WindowGetId(windowName)

	-- is this a valid id?
	if not IsValidID(id) then
		return
	end

	-- hiding the spellbook
	WindowSetShowing(windowName, false)

	-- flagging the spellbook as hidden	
	Spellbook.OpenSpellbooks[id].showing = false

	-- unregister the spellbook
	UnregisterWindowData(WindowData.Spellbook.Type, id)
end

function Spellbook.OnUpdate(timePassed)

	-- getting the spellbook window name
	local this = SystemData.ActiveWindow.name

	-- make sure the window exist
	if not DoesWindowExist(this) then
		return
	end

	-- getting the spellbook ID
	local id = WindowGetId(this)

	-- is this a valid id?
	if not IsValidID(id) then
		return
	end

	-- is the spellbook open?
	if Spellbook.IsSpellbookOpen(id) then
		
		-- we update the current tab
		Spellbook.ShowTab(Spellbook.GetActiveTab(id))
	end
end

function Spellbook.CreateTabs(parent, numTabs)
	
	-- make sure the parent window exist
	if not DoesWindowExist(parent) then
		return
	end

	-- creating small tabs
	for i = 1, numTabs do
		
		-- tab name
		local tabName = parent.."TabButton"..i

		-- create the tab
		CreateWindowFromTemplate(tabName, "SpellbookTabButton", parent)
		
		-- if it's the first tab, we attach it to the top left corner
		if i == 1 then
			WindowAddAnchor(tabName, "topleft", parent.."TabWindow", "topleft", 2, -22)

		else -- if it's not the first tab we attach it to the previous one
			WindowAddAnchor(tabName, "topright", parent.."TabButton"..i-1, "topleft", 4, 0)
		end

		-- hiding the tab (for later use)
		WindowSetShowing(tabName.."TabSelected", false)
	end
end

function Spellbook.CreateTabsLarge(parent, numTabs)
	
	-- make sure the parent window exist
	if not DoesWindowExist(parent) then
		return
	end

	-- create large tabs
	for i = 1, numTabs do
		
		-- tab name
		local tabName = parent.."TabButton"..i

		-- create the tab
		CreateWindowFromTemplate(tabName, "SpellbookTabButtonLarge", parent)
		
		-- if it's the first tab, we attach it to the top left corner
		if i == 1 then
			WindowAddAnchor(tabName, "topleft", parent.."TabWindow", "topleft", 2, -22)

		else -- if it's not the first tab we attach it to the previous one
			WindowAddAnchor(tabName, "topright", parent.."TabButton"..i-1, "topleft", 4, 0)
		end

		-- hiding the tab (for later use)
		WindowSetShowing(tabName.."TabSelected", false)
	end
end

function Spellbook.UnselectAllTabs(parent, numTabs)
	
	-- make sure the parent window exist
	if not DoesWindowExist(parent) then
		return
	end
	
	-- parsing all tabs
	for i = 1, numTabs do

		-- tab name
		local tabName = parent.."TabButton"..i

		-- does the tab exist?
		if DoesWindowExist(tabName) then

			-- turning off the highlight on the tab button
			WindowSetShowing(tabName.."TabSelected", false)

			-- enabling the tab button
			ButtonSetDisabledFlag(tabName, false)
		end
	end
end

function Spellbook.SelectTab(parent, tabNum, id)
	
	-- is this a valid tab id?
	if not IsValidID(tabNum) then
		return
	end

	-- is this a valid id?
	if not IsValidID(id) then
		return
	end
	
	-- make sure the parent window exist
	if not DoesWindowExist(parent) then
		return
	end

	-- tab window name
	local tabName = parent.."TabButton"..tabNum

	-- make sure the tab window exist
	if not DoesWindowExist(tabName) then
		return
	end

	-- showing the tab highlight
	WindowSetShowing(tabName.."TabSelected", true)

	-- disabling the button
	ButtonSetDisabledFlag(tabName, true)

	-- update the active tab in the open spellbook data
	Spellbook.OpenSpellbooks[id].activeTab = tabNum

	-- saving the active tab for this spellbook
	Interface.SaveSetting("SpellbookTab_" .. id, tabNum)
end
	
-- Called when a minimodel event causes a refresh
-- Update the spells on the current page & set the tab text
-- Doing this in Initialize was causing a bunch of "doesn't exist" error messages
function Spellbook.UpdateSpells()

	-- spellbook window name
    local this = SystemData.ActiveWindow.name

	-- make sure the parent window exist
	if not DoesWindowExist(this) then
		return
	end
	
	-- getting the current window ID
	local windowId = WindowGetId(this)

	-- is this a valid id?
	if not IsValidID(windowId) then
		return
	end

	-- getting the ID from the update request
	local id = WindowData.UpdateInstanceId
	
	-- is this a valid id?
	if not IsValidID(id) then
		return
	end
	
	-- is the current window the one we want to update?
	if (windowId ~= id) then
		return
	end	
	
	-- is the spellbook visible?
	if not Spellbook.IsSpellbookOpen(id) then
		return
	end
	
	-- getting the current spellbook data
	local data = Interface.GetItemSpellbookData(id)

	-- did we already created the spellbook tabs?
	if not Spellbook.OpenSpellbooks[id].tabsCreated then
		
		-- getting the number of tabs for the current spellbook
		Spellbook.OpenSpellbooks[id].numTabs = Spellbook.GetSpellbookTabsNumber(id)

		-- is this a mastery spellbook?
		if Spellbook.IsMasteryBook(id) then
			
			-- showing the scrollable area with all the mastery abilities
			WindowSetShowing(this .. "RightScrollWindowScrollChildSwitchMastery", true)

			-- hiding the tab window
			WindowSetShowing( this.."TabWindow", false)

			-- hiding the scroll windows
        	WindowSetShowing( this.."LeftScrollWindow", true)
        	WindowSetShowing( this.."RightScrollWindow", true)

			-- showing the mastery spells
			Spellbook.InitMasteryIndexTab()

		else
			-- we hide the scrollable area of all the mastery abilities
            WindowSetShowing(this .. "RightScrollWindowScrollChildSwitchMastery", false)

			-- we create all the necessary tabs
			Spellbook.CreateTabs(this, Spellbook.OpenSpellbooks[id].numTabs)
			
			-- naming the tabs with ordinal numbers
			for i = 1, Spellbook.OpenSpellbooks[id].numTabs do

				-- is this an unique ordinal like 1st, 2nd, ecc...?
				local ordinal = Spellbook.uniqueOrdinals[i] or L"th"

				-- completing the number
				ordinal =  i .. ordinal

				-- updating the tab text
				ButtonSetText( this.."TabButton"..i, ordinal)
			end	

			-- showing the active tab
			Spellbook.ShowTab(Spellbook.OpenSpellbooks[id].activeTab)
		end

		-- flagging the tabs as created
		Spellbook.OpenSpellbooks[id].tabsCreated = true
	end

	-- getting the texture ID		
	local texture = Spellbook.GetSpellbookTexture(id)

	-- is this a valid id?
	if not IsValidID(texture) then
		return
	end

	-- hiding the default window frame and background
	WindowSetShowing( this.."Chrome", false )
	
	-- initialize size variables
    local xSize, ySize

	-- initialize scale to 200% (the legacy textures are small!)
	local scale = 2.0

	-- reading the texture data
	texture, xSize, ySize = RequestGumpArt( texture )

	-- re-dimensioning the window to adapt to the texture size (+ some borders)
	WindowSetDimensions(  this, (xSize * scale), (ySize * scale) + 20 )

	-- re-dimensioning the background image to adapt to the texture size
	WindowSetDimensions(  this.."LegacyBook", xSize * scale, ySize * scale )

	-- applying the texture to the background image
	DynamicImageSetTexture( this.."LegacyBook", texture, 0, 0 )

	-- scaling the background image accordingly
	DynamicImageSetTextureScale( this.."LegacyBook", scale )
		
	-- clearing the background image position
	WindowClearAnchors(this.."LegacyBook")

	-- anchoring the background image accordingly
	WindowAddAnchor( this.."LegacyBook", "topleft", this, "topleft", -60, 0)

	-- showing the background image
	WindowSetShowing( this.."LegacyBook", true )
end

function Spellbook.ShowTab(tabnum, customSpellbook)
    
	-- is this a valid tab id?
	if not IsValidID(tabnum) then
		return
	end

	-- getting the current window name
    local this = WindowUtils.GetActiveDialog()

	-- do we have a custom window name from parameters?
	if customSpellbook then
		this = customSpellbook
	end

	-- make sure the window exist
	if not DoesWindowExist(this) then
		return
	end

	-- getting the current spellbook ID
    local id = WindowGetId(this)

	-- is this a valid id?
	if not IsValidID(id) then
		return
	end

	-- is this a mastery spellbook?
	if Spellbook.IsMasteryBook(id)  then
		
		-- showing the mastery spells
		Spellbook.InitMasteryIndexTab(true)

		return
	end

	-- getting the spellbook data
    local data = WindowData.Spellbook[id]

	-- do we have the spellbook data? if not the book has ben closed so we can go out.
	if not data then
		return
	end

	-- disable the highlight on all the tabs
	Spellbook.UnselectAllTabs(this, Spellbook.OpenSpellbooks[id].numTabs)

	-- Update tabs to highlight the correct one
	Spellbook.SelectTab(this, tabnum, id)
   
    -- calculating the page spells offset
	local pageOffset = (tabnum - 1) * Spellbook.numSpellsPerTab[data.firstSpellNum]

	-- parsing all the possible spells per tab
	for i = 1, Spellbook.MAX_SPELLS_PER_TAB do
		
		-- button window name
		local buttonName = "Spellbook_"..id.."TabWindowButton"..i

		-- icon window name
		local iconName = buttonName.."SquareIcon"

		-- label window name
		local labelName = buttonName.."Desc"

		-- power word window name
		local wordName = buttonName.."WordPower"

		-- hotkey window name
		local hotkeyName = buttonName.."Hotkey"

		-- spell ID
		local abilityId = data.firstSpellNum + pageOffset + i - 1

		-- getting the spell's data
		local icon, serverId, tid, desctid, reagents, powerword = GetAbilityData(abilityId)

		-- is this a valid icon and can we add the spell (based on the current limit of this spellbook)?
		if IsValidID(icon) and i <= Spellbook.numSpellsPerTab[data.firstSpellNum] then

			-- getting icon texture data
			local texture, x, y = GetIconData( icon )

			-- drawing the icon
			DynamicImageSetTexture( iconName, texture, x, y )
		
			-- determining if the ability can be used, and if not the reason why
			local canUse, reason, mana = SpellsInfo.SpellEnabled(serverId, SystemData.Hotbar.TargetType.TARGETTYPE_CURSOR)

			-- if the ability can't be used because of the lack of mana we color the icon in blue
			if not canUse and reason == SpellsInfo.DisabledReason.LOW_MANA then
				WindowSetTintColor(buttonName, 0, 0, 255)
	
			else -- reset to the default white color
				WindowSetTintColor(buttonName, 255,255,255)
			end

			-- spell can't be used but the player has the spell?
			if not canUse and data.spells[pageOffset+i] == 1 then
				
				-- change the alpha to disable the icon
				WindowSetAlpha( iconName, 0.4 )

				-- normal text color
				LabelSetTextColor(labelName, 0, 0, 0)

				-- normal power word color
				LabelSetTextColor(wordName,  0, 94, 0)

				-- button disabled
				ButtonSetDisabledFlag(buttonName, true)

			-- the spell can be used and the player has it?
			elseif data.spells[pageOffset+i] == 1 then
				
				-- icon fully visible
				WindowSetAlpha( iconName, 1.0 )

				-- normal text color
				LabelSetTextColor(labelName, 0, 0, 0)

				-- normal power word color
				LabelSetTextColor(wordName,  0, 94, 0)

				-- button enabled
				ButtonSetDisabledFlag(buttonName, false)

			else -- the player don't have the spell

				-- change the alpha to disable the icon
				WindowSetAlpha( iconName, 0.4 )

				-- disabled spell name color
				LabelSetTextColor(labelName, 115, 115, 115)

				-- disabled power word color
				LabelSetTextColor(wordName, 115, 115, 115)

				-- button disabled
				ButtonSetDisabledFlag(buttonName, true)
			end

			-- showing the spell name
			LabelSetText(labelName, GetStringFromTid(tid))

			-- showing the word of power (if available)
			if IsValidString(powerword) then
				LabelSetText(wordName, towstring(powerword))
			end
			
			-- getting the id for this spell macro
			local macroId = MacroWindow.GetMacroId(L"SpellbookHotkey" .. abilityId)

			-- getting the hotkey for this spell macro (if it has one)
			local bindingStr = UserActionMacroGetBinding(SystemData.MacroSystem.STATIC_MACRO_ID, macroId)

			-- reset the hotkey text color
			LabelSetTextColor( hotkeyName, 243, 227, 49 )

			-- do we have a macro and a hotkey?
			if IsValidID(macroId) and IsValidWString(bindingStr) then

				-- update the hotkey text and color
				MacroWindow.UpdateBindingText(hotkeyName, bindingStr)

			else -- no macro or hotkey

				-- adding the text: "No KEYBINDING"
				LabelSetText(hotkeyName, GetStringFromTid(MacroWindow.TID_NO_KEYBINDING) )
			end		

			-- show the button
			WindowSetShowing (buttonName, true)

			-- showing the spell name
			WindowSetShowing (labelName, true)

		else -- inalid spell

			-- hide the button
			WindowSetShowing (buttonName, false)
			
			-- hide the spell name
			WindowSetShowing (labelName, false)
		end
	end	

	-- update spellbook scale
	WindowUtils.LoadScale(this)
end

function Spellbook.InitMasteryIndexTab(activeOnly)
	
	-- spellbook window name
	local this = SystemData.ActiveWindow.name

	-- make sure the parent window exist
	if not DoesWindowExist(this) then
		return
	end

	-- getting the window id
	local id = WindowGetId(this)

	-- is this a valid id?
	if not IsValidID(id) then
		return
	end

	-- gtting the spellbook data
    local data = WindowData.Spellbook[id]

	-- update active mastery spells list
	Spellbook.DrawActiveMasteriesSpells(this, data)

	-- update only active spells?
	if activeOnly and not Spellbook.MasteryChanged then
		return
	end

	-- reset the mastery changed flag
	Spellbook.MasteryChanged = nil
	
	-- update all the inactive masteries spells list
	Spellbook.DrawInactiveMasteriesSpells(this, data)
end

function Spellbook.DrawActiveMasteriesSpells(this, data)

	-- make sure the parent window exist
	if not DoesWindowExist(this) then
		return
	end

	-- do we have the spellbook data?
	if not data then
		return
	end

	-- active abilities title
	LabelSetText(this.."RightScrollWindowScrollChildActive", L" --- " .. GetStringFromTid(Spellbook.TID.Active) .. L" --- ")
		
	-- active abilities scroll area
	local baseItemName = this.."RightScrollWindowScrollChildItem"

	-- ative abilities parent
	local parent = this.."RightScrollWindowScrollChild"

	-- active abilities scroll window
	local rightScrollWindow = this.."RightScrollWindow"

	-- clearing the active abilities area position
	WindowClearAnchors(parent)
	
	-- positioning the active abilities area on the top left
	WindowAddAnchor( parent, "topleft", rightScrollWindow, "topleft", 0, 0)

	-- getting the current window scale
    local scl = WindowGetScale(this)	

	-- last shown ability (used for anchoring)
	local lastShownIdx = 0
	
	-- do we have an active mastery?
	if IsValidID(Spellbook.ActiveMastery) then

		-- parsing all the possible spells for a mastery
		for i = 1, Spellbook.MAX_MASTERY_SPELL_COUNT do
			
			-- get the mastery data
			local masteryData = Spellbook.ActiveMasteryIndex[Spellbook.ActiveMastery]

			-- is it a valid mastery?
			if not masteryData then
				break				
			end

			-- initialize the spell id variable
			local abilityId

			-- first spell ID
			if i == 1 then
				abilityId = masteryData.SpellA

			-- second spell ID
			elseif i == 2 then
				abilityId = masteryData.SpellB

			else -- third spell ID
				abilityId = masteryData.Passive				
			end	
						
			-- button window name
			local currentWindowName = baseItemName.."Active"..i

			-- if the button already exist, we get rid of it
			if DoesWindowExist(currentWindowName) and Spellbook.MasteryChanged then
				DestroyWindow(currentWindowName)
			end

			-- is a valid spell ID?
			if not IsValidID(abilityId) then
				break
			end

			-- getting the spell data
			local icon, serverId, tid, desctid, reagents, powerword = GetAbilityData(abilityId)

			-- do we have a valid icon id?
			if IsValidID(icon) then			
			
				-- icon window name
				local iconName = currentWindowName.."SquareIcon"

				-- label window name
				local labelName = currentWindowName.."Desc"

				-- power word window name
				local wordName = currentWindowName.."WordPower"			

				-- hotkey window name
				local hotkeyName = currentWindowName.."Hotkey"

				-- if the icon doesn't exist, we create it.
				if not DoesWindowExist(currentWindowName) then

					-- creating the spell button
					CreateWindowFromTemplate( currentWindowName, "SpellbookButtonDef",  parent)

					-- clearing the button position
					WindowClearAnchors(currentWindowName)
				
					-- is this the first button?
					if i == 1 then

						-- anchoring it to the top left
						WindowAddAnchor( currentWindowName, "topleft", parent, "topleft", 20, 60)	
					
					else -- any other button get anchored to the last one shown
						WindowAddAnchor( currentWindowName, "bottomleft", baseItemName.."Active"..(lastShownIdx), "topleft", 0, 30)
					end

					-- updating the last shown id
					lastShownIdx = i
				end

				-- getting the icon texture data
				local iconTexture, x, y = GetIconData(icon)

				-- drawing the icon
				DynamicImageSetTexture(iconName, iconTexture, x, y)
				
				-- determining if the ability can be used, and if not the reason why
				local canUse, reason, mana = SpellsInfo.SpellEnabled(serverId, SystemData.Hotbar.TargetType.TARGETTYPE_CURSOR)

				-- if the ability can't be used because of the lack of mana we color the icon in blue
				if not canUse and reason == SpellsInfo.DisabledReason.LOW_MANA then
					WindowSetTintColor(iconName, 0, 0, 255)
	
				else -- reset to the default white color
					WindowSetTintColor(iconName, 255,255,255)
				end

				-- normal text color
				LabelSetTextColor(labelName, 0, 0, 0)

				-- normal power word color
				LabelSetTextColor(wordName,  0, 94, 0)

				-- spell can't be used?
				if canUse then
				
					-- change the alpha to enable the icon
					WindowSetAlpha( iconName, 1 )

					-- button enabled
					ButtonSetDisabledFlag(currentWindowName, false)

				else
					-- change the alpha to disable the icon
					WindowSetAlpha( iconName, 0.4 )

					-- button disabled
					ButtonSetDisabledFlag(currentWindowName, true)
				end

				-- hiding the disabled button mask
				WindowSetShowing(currentWindowName.."Disabled", false)
						
				-- set spell name
				LabelSetText(labelName, GetStringFromTid(tid))

				-- enchanted summoning have a problem with the "(passive)" text overlapping the name of the spell
				if abilityId == 715 then

					-- clearing the power word position
					WindowClearAnchors(wordName)

					-- fixing the position of the label so it won't overlap
					WindowAddAnchor( wordName, "bottomleft", labelName, "topleft", 0, 23)	
				end

				-- is this a passive ability?
				if SpellsInfo.IsPassive(abilityId) then
					
					-- adding "passive" text 
					LabelSetText(wordName, GetStringFromTid(1153268)) -- Passive
				
				else -- active spell

					-- showing the word of power (if available)
					if IsValidString(powerword) then
						LabelSetText(wordName, towstring(powerword))
					end

					-- getting the id for this spell macro
					local macroId = MacroWindow.GetMacroId(L"SpellbookHotkey" .. abilityId)

					-- getting the hotkey for this spell macro (if it has one)
					local bindingStr = UserActionMacroGetBinding(SystemData.MacroSystem.STATIC_MACRO_ID, macroId)

					-- reset the hotkey text color
					LabelSetTextColor( hotkeyName, 243, 227, 49 )

					-- do we have a macro and a hotkey?
					if IsValidID(macroId) and IsValidWString(bindingStr) then

						-- update the hotkey text and color
						MacroWindow.UpdateBindingText(hotkeyName, bindingStr)

					else -- no macro or hotkey

						-- adding the text: "No KEYBINDING"
						LabelSetText(hotkeyName, GetStringFromTid(MacroWindow.TID_NO_KEYBINDING) )
					end		
				end

				-- show the button
				WindowSetShowing(currentWindowName, true)			

				-- setting the spell id to the button
				WindowSetId(currentWindowName, abilityId)
				WindowSetId(currentWindowName.."SquareIcon", abilityId)						
			end
		end
	end

	-- updating the scrollbars
	ScrollWindowUpdateScrollRect(rightScrollWindow)
end

function Spellbook.DrawInactiveMasteriesSpells(this, data)
	
	-- make sure the parent window exist
	if not DoesWindowExist(this) then
		return
	end

	-- do we have the spellbook data?
	if not data then
		return
	end

	-- all abilities title
	LabelSetText(this.."LeftScrollWindowScrollChildIndex", L" --- " .. GetStringFromTid(Spellbook.TID.Index) .. L" --- ")

	-- inactive abilities window name
	local baseItemName = this.."LeftScrollWindowScrollChildItem"

	-- inactive abilities parent
	local parent = this.."LeftScrollWindowScrollChild"

	-- inactive abilities scroll window
	local leftScrollWindow = this.."LeftScrollWindow"

	-- clearing the anchors for the parent
	WindowClearAnchors(parent)

	-- re-positioning the parent to the top left corner
	WindowAddAnchor( parent, "topleft", leftScrollWindow, "topleft", 0, 0)
		
	-- last shown ability (used for anchoring)
	lastShownIdx = 0

	-- parsing all the remaining masteries abilities
	for i = 1, Spellbook.MASTERY_COUNT do
		
		-- get the spell ID
		local abilityId = data.firstSpellNum + i - 1

		-- button window name
		local currentWindowName = baseItemName.."All"..i

		-- if the button already exist, we get rid of it
		if (DoesWindowExist(currentWindowName)) then
			DestroyWindow(currentWindowName)
		end

		-- is this spell already showing in the active spells list? if it is we skip it..
		if Spellbook.IsCurrentMasterySpell(abilityId) then
			continue			
		end
		
		-- getting the spell data
		local icon, serverId, tid, desctid, reagents, powerword = GetAbilityData(abilityId)

		-- do we have a valid icon id?
		if IsValidID(icon) then		
			
			-- icon window name
			local iconName = currentWindowName.."SquareIcon"

			-- label window name
			local labelName = currentWindowName.."Desc"

			-- power word window name
			local wordName = currentWindowName.."WordPower"		
			
			-- hotkey window name
			local hotkeyName = currentWindowName.."Hotkey"

			-- creating the spell button
			CreateWindowFromTemplate( currentWindowName, "SpellbookButtonDef", parent)

			-- clearing the button position
			WindowClearAnchors(currentWindowName)			

			-- is this the first button?
			if i == 1 then
				
				-- anchoring it to the top left
				WindowAddAnchor( currentWindowName, "topleft", parent, "topleft", 0, 30)	
				
			else -- any other button get anchored to the last one shown
				WindowAddAnchor( currentWindowName, "bottomleft", baseItemName.."All"..(lastShownIdx), "topleft", 0, 0)
			end

			-- updating the last shown id
			lastShownIdx = i

			-- getting the icon texture data
			local iconTexture, x, y = GetIconData(icon)

			-- drawing the icon
			DynamicImageSetTexture(iconName, iconTexture, x, y)
			
			-- hiding the disabled button mask
			WindowSetShowing(currentWindowName.."Disabled", false)

			-- setting the icon alpsha to disable the icon
			WindowSetAlpha( iconName, 0.4 )

			-- disabled spell name color
			LabelSetTextColor(labelName, 115, 115, 115)

			-- disabled power word color
			LabelSetTextColor(wordName, 115, 115, 115)
			
			-- set spell name
			LabelSetText(labelName, GetStringFromTid(tid))

			-- enchanted summoning have a problem with the "(passive)" text overlapping the name of the spell
			if abilityId == 715 then

				-- clearing the power word position
				WindowClearAnchors(wordName)

				-- fixing the position of the label so it won't overlap
				WindowAddAnchor( wordName, "bottomleft", labelName, "topleft", 0, 23)	
			end

			-- is this a passive ability?
			if SpellsInfo.IsPassive(abilityId) then
					
				-- adding "passive" text 
				LabelSetText(wordName, GetStringFromTid(1153268)) -- Passive
			
			else -- active spell

				-- showing the word of power (if available)
				if IsValidString(powerword) then
					LabelSetText(wordName, towstring(powerword))
				end

				-- getting the id for this spell macro
				local macroId = MacroWindow.GetMacroId(L"SpellbookHotkey" .. abilityId)

				-- getting the hotkey for this spell macro (if it has one)
				local bindingStr = UserActionMacroGetBinding(SystemData.MacroSystem.STATIC_MACRO_ID, macroId)

				-- reset the hotkey text color
				LabelSetTextColor( hotkeyName, 243, 227, 49 )

				-- do we have a macro and a hotkey?
				if IsValidID(macroId) and IsValidWString(bindingStr) then

					-- update the hotkey text and color
					MacroWindow.UpdateBindingText(hotkeyName, bindingStr)

				else -- no macro or hotkey

					-- adding the text: "No KEYBINDING"
					LabelSetText(hotkeyName, GetStringFromTid(MacroWindow.TID_NO_KEYBINDING) )
				end		
			end

			-- disable the spell button
			ButtonSetDisabledFlag(currentWindowName, true)			
			
			-- show the button
			WindowSetShowing(currentWindowName, true)	
			
			-- setting the spell id to the button
			WindowSetId(currentWindowName, abilityId)
			WindowSetId(currentWindowName.."SquareIcon", abilityId)						
		end
	end
	
	-- updating the scrollbars
	ScrollWindowUpdateScrollRect(leftScrollWindow)	
end


-- OnShutdown Handler
function Spellbook.Shutdown()
	
	-- clearing the active item properties
	ItemProperties.ClearMouseOverItem()

	-- spellbook window name
	local this = WindowUtils.GetActiveDialog()

	-- make sure the parent window exist
	if not DoesWindowExist(this) then
		return
	end

	local id = WindowGetId(this)

	-- is this a valid id?
	if not IsValidID(id) then
		return
	end

	-- save the current window position
	WindowUtils.SaveWindowPosition(SystemData.ActiveWindow.name, false, "LEGACY_Spellbook_GUMP")
end

-- OnLButtonDown Handler
function Spellbook.SpellLButtonDown(flags)
	
	-- getting the spellbook window name
    local this = WindowUtils.GetActiveDialog()

	-- make sure the window exist
	if not DoesWindowExist(this) then
		return
	end

	-- getting the current spellbook ID
    local id = WindowGetId(this)

	-- is this a valid id?
	if not IsValidID(id) then
		return
	end

	-- getting the current spellbook data
    local data = WindowData.Spellbook[id]

	-- get the current tab id
    local page = Spellbook.GetActiveTab(id)

	-- get the spell index
    local index = WindowGetId(SystemData.ActiveWindow.name)

	-- is a valid index?
	if not IsValidID(index) then
		return
	end

	-- initialize current spell ID
	local curSpell = index

	-- is this a mastery spellbook?
	if Spellbook.IsMasteryBook(id)  then	

		-- is this a passive spell?
		if SpellsInfo.IsPassive(curSpell) then
			return
		end

	else -- get the ID for a NON mastery spell
		curSpell = (page - 1) * Spellbook.numSpellsPerTab[data.firstSpellNum] + index + data.firstSpellNum - 1
	end
    
	-- getting the spell data	
    local icon, serverId = GetAbilityData(curSpell)


	local notarget = false

	-- check if the spells supports a target
	for _, value in pairs(SpellsInfo.SpellsData) do
		if value.id == dragId and value.notarget == true then
			notarget = true
			break
		end
	end

	-- initialize variables to check if the item is already around
	local alreadyInBar, existingSlot

	-- does the spell support a target?
	if notarget or SpellsInfo.IsSummonSpell(curSpell) then

		-- is this specific spell already in any hotbar slot?
		alreadyInBar, existingSlot = HotbarSystem.ActionAlreadyInHotbar(dragId, SystemData.DragItem.actionType )
	end

	-- if CONTROL is pressed we create a blockbar with the spell in it
    if flags == WindowUtils.ButtonFlags.CONTROL and not alreadyInBar then
		
		-- get the blockbar id
		local blockBar = HotbarSystem.SpawnNewHotbar(_, 1, true)
				
		-- adding the spell to the blockbar
		HotbarSystem.SetActionOnHotbar(SystemData.UserAction.TYPE_SPELL, curSpell, icon, blockBar,  1)
		
		-- forcing the blockbar to follow the mouse cursor
		WindowUtils.FollowMouseCursor("Hotbar" .. blockBar, Hotbar.BUTTON_SIZE, Hotbar.BUTTON_SIZE, -30, -15, false, true, true)

		-- setting the window movable
		WindowSetMoving("Hotbar" .. blockBar, true)
		
    else -- drag the spell to be put in an hotbar or macro
		
		-- make the slot glow to highlight the duplicate
		if alreadyInBar then
			HotbarSystem.GlowSlotWarning(existingSlot, 5, i)
		end

		DragSlotSetActionMouseClickData(SystemData.UserAction.TYPE_SPELL, serverId, icon)
	end
end

-- OnLButtonUP Handler
function Spellbook.SpellLButtonUp()

	-- spellbook window name
	local this = WindowUtils.GetActiveDialog()

	-- make sure the parent window exist
	if not DoesWindowExist(this) then
		return
	end

    -- getting the window id
	local id = WindowGetId(this)

	-- is this a valid id?
	if not IsValidID(id) then
		return
	end

    -- gtting the spellbook data
    local data = WindowData.Spellbook[id]

    -- get the current tab id
    local page = Spellbook.GetActiveTab(id)

    -- get the spell index
    local index = WindowGetId(SystemData.ActiveWindow.name)

	-- is a valid index?
	if not IsValidID(index) then
		return
	end

	-- initialize current spell ID
	local curSpell = index

	-- is this a mastery spellbook?
	if Spellbook.IsMasteryBook(id)  then	

		-- is this a passive spell?
		if SpellsInfo.IsPassive(curSpell) then
			return
		end

		-- is a spell of the active mastery?
		if not Spellbook.IsCurrentMasterySpell(curSpell) then
			return
		end

	else -- get the ID for a NON mastery spell
		curSpell = (page - 1) * Spellbook.numSpellsPerTab[data.firstSpellNum] + index + data.firstSpellNum - 1
	end
	
	-- get the button window name
	local buttonName = SystemData.ActiveWindow.name
      
	-- is the button enabled?
	if not ButtonGetDisabledFlag(buttonName) then

		-- getting the spell data	
		local icon, serverId = GetAbilityData(curSpell)
		
		-- is this a valid spell?
		if IsValidID(serverId) then

			-- casting the spell
			UserActionCastSpell(serverId)

			-- hiding the current window
			Spellbook.Hide(this)
		end
	end
end

-- OnMouseOver Handler
function Spellbook.SpellMouseOver()
	
	-- getting the spellbook window name
	local this = WindowUtils.GetActiveDialog()

	-- make sure the window exist
	if not DoesWindowExist(this) then
		return
	end

	-- getting the spellbook ID
    local id = WindowGetId(this)

	-- is this a valid id?
	if not IsValidID(id) then
		return
	end

	-- getting the current spellbook data
    local data = WindowData.Spellbook[id]

    -- get the current tab id
    local page = Spellbook.GetActiveTab(id)

    -- get the spell index
    local index = WindowGetId(SystemData.ActiveWindow.name)

	-- update the character sheet to make sure we have all the stats updated
	CharacterSheet.UpdateStatus()
    
	-- initialize the current spell ID
	local curSpell = index	

	 -- get the ID for a NON mastery spell
    if not Spellbook.IsMasteryBook(id) then		    
	    curSpell = (page - 1) * Spellbook.numSpellsPerTab[data.firstSpellNum] + index + data.firstSpellNum - 1	    
	end

	-- getting the spell data	
    local icon, serverId, tid, desctid, reagents, powerword, tithingcost, minskill, manacost  = GetAbilityData(curSpell)
	
	-- initialize the descriptions strings
    local reagentsStr = L""
    local tithingStr = L""
    local minskillStr = L""
    local manacostStr = L""
    
	-- are there any reagents?  
    if IsValidString(reagents) then
		reagentsStr = L"<BR>== "..GetStringFromTid(1002127)..L" ==<BR>"..towstring(reagents) .. L"<BR>" -- Reagents
    end
    
	-- is there a tithing cost? (used for upkeep cost too)
    if IsValidID(tithingcost) then
		
		-- chivalry spell: thithing cost
		if serverId >= 201 and serverId <= 210 then
			tithingStr =  L"<BR>"..GetStringFromTid(1062099)..towstring(tithingcost) .. L"<BR>" -- Tithing Cost:
		
		-- chivalry mastery spells
		elseif serverId == 719 or serverId == 720 then
			tithingStr =  L"<BR>"..GetStringFromTid(1062099)..towstring(tithingcost) .. L"<BR>" -- Tithing Cost:

		-- bard spell
		elseif serverId >= 701 and serverId <= 706 then
			tithingStr =  L"<BR>"..GetStringFromTid(1115718)..towstring(tithingcost) .. L"<BR>" -- Upkeep Cost:

		-- rest of the mastery spells
		elseif serverId == 707 or serverId == 721 or serverId == 725 or serverId == 728 or serverId == 730 or serverId == 736 then
			tithingStr =  L"<BR>"..GetStringFromTid(1115718)..towstring(tithingcost) .. L"<BR>" -- Upkeep Cost:
		end
    end
    
	-- get the skill ID for the current spell
    local skillId = SpellsInfo.GetSkillID(curSpell)  
	
	-- if there is no minskill, we get it from the spellsinfo
	if not minskill or (minskill == 0 and curSpell <= 64) then
		minskill = SpellsInfo.GetMinSkill(curSpell) 
	end
	
	-- skill level initialize
	local skillLevel = 0
	
	-- if it's a not a mastery spell we get the current skill level
	if (curSpell < 701) then
		skillLevel = GetSkillValue(skillId, true)
	end
	
	-- do we have a min skill?
    if minskill ~= nil then
		minskillStr =  minskillStr..L"<BR>"..GetStringFromTid(1062101)..L" "..towstring(minskill) --Min Skill:
    end
    
    -- if the player is a human the default min skill is 20
	if GetMobileRace(GetPlayerID()) == PaperdollWindow.HUMAN then
		skillLevel = 20
	end

	-- spell damage string
	local spelldamage = L""
	
	-- is a valid skill ID?
	if IsValidID(skillId) then

		-- get the skill required for 100% success
		local maxskill = SpellsInfo.GetMaxSkill(minskill, curSpell) 

		-- do we have a max skill and it's not a mastery spell?
		if maxskill > minskill and curSpell < 701 then
			minskillStr =  minskillStr..L"<BR>"..L"Max Skill: "..towstring(maxskill)
		end
	    
		-- no need to show the success chance on passive skills
		if not SpellsInfo.IsPassive(curSpell) then

			-- calculating success chance
			local success  = ((skillLevel - minskill) * 100) / SpellsInfo.GetVariation(curSpell) 

			-- is the skill level minor than min required skill?
			if skillLevel < minskill then
			
				-- success 0%
				success = 0 
			end

			-- is the skill level greater than the max skill required or is a mastery spell?
			if skillLevel > minskill + SpellsInfo.GetVariation(curSpell) or curSpell > 700 then

				-- success 100%
				success = 100
			end
        
			-- format the success chance with 1 decimal
			success = string.format("%1.1f", success)

			-- adding the success chance to the description string
			minskillStr =  minskillStr..L"<BR><BR>"..L"Success Chance: "..towstring(success) .. L"%<BR>"
		end

		-- getting the spell casting speed
		local spellspeed = SpellsInfo.GetSpellSpeed(curSpell)
       
	    -- if we have the casting speed we add it to the description string
		if (spellspeed) then
			minskillStr =  minskillStr .. L"<BR>Casting Speed: " .. spellspeed .. L"s<BR>"
		end

		-- calculating the spell damage
		spelldamage = SpellsInfo.GetSpellDamage(curSpell) 
    end
    
	-- do we have a mana cost (greater than 0)?
    if IsValidID(manacost) then

		-- calculating the mana cost
		local lmcMana = math.floor(manacost - (manacost * (tonumber(WindowData.PlayerStatus["LowerManaCost"]) / 100))) -- Mana Cost:

		-- mana phase buff set mana cost to 0
		if BuffDebuff.BuffWindowId[1104] then
			lmcMana = 0
		end

		-- adding the mana cost to the description string
		manacostStr =  L"<BR>"..GetStringFromTid(1062100)..L" " .. towstring(lmcMana) .. L" (".. towstring(manacost) .. L")"
    end

	-- initialize the reason for the spell being disabled
	local desc = L""

	-- determining if the ability can be used, and if not the reason why
	local canUse, reason, mana = SpellsInfo.SpellEnabled(serverId, SystemData.Hotbar.TargetType.TARGETTYPE_CURSOR)

	-- can we use the spell?
	if not canUse then

		-- getting the TID reason
		local TID = SpellsInfo.DisabledReasonTID[reason]

		-- is the TID valid?
		if IsValidID(TID) then

			if mana then
				-- adding the text to the description + the special token returned
				desc = L"\n\n" .. ReplaceTokens(GetStringFromTid(TID), {towstring(mana)}) .. L"\n"

			else
				-- adding the text to the description
				desc = L"\n\n" .. GetStringFromTid(TID) .. L"\n"
			end
		end
	end
    
	-- getting the id for this spell macro
	local macroId = MacroWindow.GetMacroId(L"SpellbookHotkey" .. curSpell)

	-- getting the hotkey for this spell macro (if it has one)
	local bindingText = UserActionMacroGetBinding(SystemData.MacroSystem.STATIC_MACRO_ID,macroId)

	-- initialize target text
	local targetText = L""

	if IsValidID(macroId) and IsValidWString(bindingText) then

		-- getting the hotkey text
		bindingText = L"\n" .. GetStringFromTid(Hotbar.TID_BINDING) .. L" " .. bindingText

		-- slot window name for the target mouse over
		local slotWindow = "Macro_" .. macroId .. "_1"

		-- get the macro target type
		local targetType = UserActionGetTargetType(SystemData.MacroSystem.STATIC_MACRO_ID, macroId, 1, slotWindow)

		-- get the string name of the current target
		local targetString = Hotbar.TargetTypeToWStringName(targetType)

		-- if we have a string name we attach it to the prefix
		if IsValidWString(targetString) then
			-- "target:" text prefix + target name
			targetText = GetStringFromTid(Hotbar.TID_TARGET) .. L" " .. targetString
		end
	end

	-- generating the item properties array
	local itemData = { windowName = SystemData.ActiveWindow.name,
						itemId = curSpell,
						itemType = WindowData.ItemProperties.TYPE_ACTION,
						actionType = SystemData.UserAction.TYPE_SPELL,
						detail = ItemProperties.DETAIL_LONG,
						binding = bindingText, -- As defined above
						myTarget = targetText, 
						title = L"",	
						body = reagentsStr..tithingStr..minskillStr.. spelldamage .. manacostStr .. desc	}

	-- showing the item properties
	ItemProperties.SetActiveItem(itemData)	    
end

-- Tab Handler
function Spellbook.ToggleTab()
    -- Get the number of the tab clicked, which should be the last character of its name
    -- NOTE: Obviously, this won't work if you have more than ten tabs
    tab_clicked = tonumber (string.sub( SystemData.ActiveWindow.name, -1, -1))
	Spellbook.ShowTab(tab_clicked)  
end

function Spellbook.IsMasteryBook(id)
	return (WindowData.Spellbook[id] ~= nil and WindowData.Spellbook[id].firstSpellNum == 701)
end

function Spellbook.GetMasteryBook()

	-- scan all the open books
	for id, _ in pairs(Spellbook.OpenSpellbooks) do

		-- is this a mastery book?
		if Spellbook.IsMasteryBook(id) then

			-- return the ID
			return id
		end
	end
end

function Spellbook.SwitchMasteryMouseOver()

	-- getting the spellbook window name
	local spellbook = WindowUtils.GetActiveDialog()

	-- make sure the window exist
	if not DoesWindowExist(spellbook) then
		return
	end

	-- getting the object ID of the spellbook
	local objectId = WindowGetId(spellbook) 

	-- is this a valid id?
	if not IsValidID(objectId) then
		return
	end

	-- get this button window name
	local this = SystemData.ActiveWindow.name

	-- getting the seconds left before the mastery can be changed
	local seconds = Spellbook.MasteryChangeCooldown

	-- tooltip text
	local messageText = GetStringFromTid(1151948) -- Switch Mastery

	-- initialize the tooltip body text
	local body = L""

	-- are there seconds left?
	if seconds > 0 then
		body = GetStringFromTid(1155888) .. L" ( " .. StringUtils.CountDownSeconds(seconds) .. L" )" -- You must wait before using this ability again.
	end
    
	-- generating the item properties array
	local itemData = { windowName = SystemData.ActiveWindow.name,
						itemId = objectId,
						itemType = WindowData.ItemProperties.TYPE_WSTRINGDATA,
						binding = L"",
						detail = nil,
						title =	messageText,
						body = body}
	
	-- showing the item properties
	ItemProperties.SetActiveItem(itemData)
end

function Spellbook.SwitchMastery()

	-- getting the spellbook window name
	local spellbook = WindowUtils.GetActiveDialog()

	-- make sure the window exist
	if not DoesWindowExist(spellbook) then
		return
	end

	-- getting the object ID of the spellbook
	local objectId = WindowGetId(spellbook) 

	-- is this a valid id?
	if not IsValidID(objectId) then
		return
	end

	-- getting the seconds left before the mastery can be changed
	local seconds = Spellbook.MasteryChangeCooldown

	-- if there are no seconds left the button can be used
	if seconds <= 0 then
		
		-- request context menu for the spellbook
		ContextMenu.RequestContextAction(objectId, ContextMenu.DefaultValues.SwitchMastery)
	end
end

function Spellbook.AssignHotkey(abilityId, iconId, spellbookId, windowName)

	-- getting the macro ID for this spell
	local macroIndex = MacroWindow.GetMacroId(L"SpellbookHotkey" .. abilityId)

	-- if we don't have a macro
	if not IsValidID(macroIndex) then
		
		-- create a new macro for the spell
		macroIndex = Spellbook.CreateMacro(abilityId, iconId, spellbookId, windowName)

		-- assign the hotkey for the macro
		Spellbook.HandleAssignHotkey(windowName, macroIndex, spellbookId)

	else -- assign the hotkey for the macro
		Spellbook.HandleAssignHotkey(windowName, macroIndex, spellbookId)
	end
end

function Spellbook.HandleAssignHotkey(windowName, macroIndex, spellbookId)

	-- show the assign hotkey info tooltip
	WindowUtils.ShowAssignHotkeyInfo(windowName)
	
	-- loading the data for the hotkey recording
	MacroWindow.RecordingKeySpellbook = "Spellbook_" .. spellbookId
	MacroWindow.RecordingIndex = macroIndex
	MacroWindow.RecordingKey = true

	-- beginning the key record
	BroadcastEvent( SystemData.Events.INTERFACE_RECORD_KEY )
end

function Spellbook.CreateMacro(abilityId, iconId, spellbookId, windowName)

	-- creating a new macro
	local macroIndex = MacroSystemAddMacroItem()
	
	-- setting the macro name
	UserActionMacroSetName(SystemData.MacroSystem.STATIC_MACRO_ID,macroIndex,L"SpellbookHotkey" .. abilityId)

	-- setting the icon id
	UserActionSetIconId(SystemData.MacroSystem.STATIC_MACRO_ID, macroIndex, 0, iconId)

	-- determining if the action window is already showing and saving the status
	local prevActions = WindowGetShowing("ActionsWindow")

	-- opening the edit window to fill the macro
	ActionEditWindow.OpenEditWindow(macroIndex, SystemData.UserAction.TYPE_MACRO,nil,SystemData.MacroSystem.STATIC_MACRO_ID)

	-- hiding the edit window
	WindowSetShowing("ActionEditMacro", false)

	-- restoring the actions window visibility
	WindowSetShowing("ActionsWindow", prevActions)

	-- filling the data for the drag spell
	Spellbook.DragSpell = {type = SystemData.UserAction.TYPE_SPELL, abilityId = abilityId, iconId = iconId, macroIndex = macroIndex, spellbookId = spellbookId}

	-- creating the warning tooltip (to keep the mouse moving)
	local Warning = 
	{
		windowName = "SpellWarning",
		titleTid = 281,
		bodyTid  = 282,
		destroyDuplicate = true,
	}
	UO_StandardDialog.CreateDialog(Warning)	

	-- returning the macro id
	return macroIndex
end

function Spellbook.CreateMacroCycle()
	
	-- are we creating a macro for a skill?
	if Spellbook.DragSpell and Spellbook.DragSpell.type == SystemData.UserAction.TYPE_SKILL then
		SkillsWindow.CreateMacroCycle()
		return
	end

	-- if there is nothing on the cursor, we begin to drag the spell
	if Spellbook.DragSpell and SystemData.DragItem.DragType == SystemData.DragItem.TYPE_NONE then
		DragSlotSetActionMouseClickData(SystemData.UserAction.TYPE_SPELL, Spellbook.DragSpell.abilityId, Spellbook.DragSpell.iconId)

	-- if we're dragging something, we drop it in the macro edit window
	elseif Spellbook.DragSpell and SystemData.DragItem.DragType ~= SystemData.DragItem.TYPE_NONE then

		MacroEditWindow.MacroActionLButtonUp(true)
	end
end

function Spellbook.GetActiveTab(id)
	
	-- is a valid ID?
	if not IsValidID(id) then
		return 1
	end

	-- is the spellbook open?
	if not Spellbook.OpenSpellbooks[id] then
		return 1
	end

	return Spellbook.OpenSpellbooks[id].activeTab
end

function Spellbook.GetSpellbookTexture(id)
	
	-- is this a valid id?
	if not IsValidID(id) then
		return 2200 -- default texture
	end

	-- getting the current spellbook data
	local data = WindowData.Spellbook[id]

	-- the spells per tab number is determined by the first spell ID of the book
	return Spellbook.LegacyTexture[data.firstSpellNum]
end

function Spellbook.GetSpellbookTabsNumber(id)
	
	-- is this a valid id?
	if not IsValidID(id) then
		return 0
	end

	-- getting the current spellbook data
	local data = WindowData.Spellbook[id]

	-- the spells per tab number is determined by the first spell ID of the book
	return Spellbook.numTabs[data.firstSpellNum]
end

function Spellbook.IsSpellbookOpen(id)

	-- is a valid ID?
	if not IsValidID(id) then
		return false
	end

	-- is the spellbook open?
	if not Spellbook.OpenSpellbooks[id] then
		return false
	end

	return Spellbook.OpenSpellbooks[id].showing
end

function Spellbook.IsCurrentMasterySpell(abilityId)

	-- is a valid ID?
	if not IsValidID(abilityId) then
		return false
	end

	-- get the mastery data
	local masteryData = Spellbook.ActiveMasteryIndex[Spellbook.ActiveMastery]

	-- is it a valid mastery?
	if not masteryData then
		return false			
	end

	return abilityId == masteryData.SpellA or abilityId == masteryData.SpellB or abilityId == masteryData.Passive	
end

function Spellbook.GetCurrentMastery(objectId)

	-- is this a valid id?
	if not IsValidID(objectId) then
		return 0
	end

	-- does the player have this item?
	if not DoesPlayerHaveItem(objectId) then
		return 0
	end

	-- get the book properties
	local props = Interface.GetItemPropertiesData( objectId, "Spellbook.OnMasteryUpdate" )

	-- did we get the properties?
	if not props then
		return 0
	end	

	-- build the properties TID array
	local params = ItemProperties.BuildParamsArray( props )

	-- searching for the mastery TID
	for tid, _ in pairs(Spellbook.MasteryBookTIDs) do

		-- found it!
		if params[tid] then
			return tid
		end
	end

	return 0
end

function Spellbook.UpdateMyMasteries()
	
	-- get the mastery book ID
	local masteryBook = ContainerWindow.GetItemIDByType({8794, 8795}, 0, true)
	
	-- do we have a valid ID for the mastery book?
	if not IsValidID(masteryBook) then
		return
	end
	
	-- request gump
	ContextMenu.RequestContextAction(masteryBook, ContextMenu.DefaultValues.SwitchMastery)
end
