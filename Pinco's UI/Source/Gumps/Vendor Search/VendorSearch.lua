----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

VendorSearch = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

VendorSearch.WindowName = "VendorSearch"

VendorSearch.GumpID = 999112
VendorSearch.ResultsGumpID = 999113

VendorSearch.HoldOn = false -- prevents the window closing when the gump reloads

VendorSearch.CurrentError = L""

VendorSearch.CurrentCriteriaTable = {}

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function VendorSearch.Initialize()

	-- mark the window to be destroyed on close
	Interface.DestroyWindowOnClose[VendorSearch.WindowName] = true

	-- make the window snappable
	SnapUtils.SnappableWindows[VendorSearch.WindowName] = true

	-- restore the window position
	WindowUtils.RestoreWindowPosition(VendorSearch.WindowName,false,nil,true)

	-- set the window title
	WindowUtils.SetWindowTitle(VendorSearch.WindowName,GetStringFromTid(1154508))  -- Vendor Search Query
	
	--fill the labels text
	LabelSetText(VendorSearch.WindowName .. "BankBalance", GetStringFromTid(1060645)) -- Bank Balance:
	LabelSetText(VendorSearch.WindowName .. "ItemName", GetStringFromTid(1154510)) -- Item Name
	LabelSetText(VendorSearch.WindowName .. "PriceRange", GetStringFromTid(1155389)) -- Price Range
	LabelSetText(VendorSearch.WindowName .. "PriceRangeSep", L"-")
	LabelSetText(VendorSearch.WindowName .. "MinPrice", GetStringFromTid(1154532)) -- Minimum Price
	LabelSetText(VendorSearch.WindowName .. "MaxPrice", GetStringFromTid(1154533)) -- Maximum Price
	LabelSetText(VendorSearch.WindowName .. "Misc", GetStringFromTid(1011173)) -- Miscellaneous
	LabelSetText(VendorSearch.WindowName .. "Equip", GetStringFromTid(1078237)) -- Equipment
	LabelSetText(VendorSearch.WindowName .. "Props", GetStringFromTid(1062761)) -- Properties
	LabelSetText(VendorSearch.WindowName .. "Combat", GetStringFromTid(1077417)) -- Combat
	LabelSetText(VendorSearch.WindowName .. "Casting", GetStringFromTid(1076209)) -- Casting
	LabelSetText(VendorSearch.WindowName .. "DamageType", GetStringFromTid(1154535)) -- Damage Type
	LabelSetText(VendorSearch.WindowName .. "Slayers", GetStringFromTid(1114263)) -- Slayers
	LabelSetText(VendorSearch.WindowName .. "Resist", GetStringFromTid(1114254)) -- Resists
	LabelSetText(VendorSearch.WindowName .. "Stats", GetStringFromTid(1114262)) -- Stats
	LabelSetText(VendorSearch.WindowName .. "Skills", GetStringFromTid(1115030)) -- Skills
	LabelSetText(VendorSearch.WindowName .. "HitSpell", GetStringFromTid(1154536)) -- Hit Spell
	LabelSetText(VendorSearch.WindowName .. "HitArea", GetStringFromTid(1154537)) -- Hit Area
	LabelSetText(VendorSearch.WindowName .. "SkillReq", GetStringFromTid(1154543)) -- Required Skill
	LabelSetText(VendorSearch.WindowName .. "ClearSearch", GetStringFromTid(1154588)) -- Clear Search Criteria
	LabelSetText(VendorSearch.WindowName .. "Search", GetStringFromTid(1154641)) -- Search
	LabelSetText(VendorSearch.WindowName .. "CriteriaMax", GetStringFromTid(1154681)) -- You may not add any more search criteria items.
	WindowSetShowing(VendorSearch.WindowName .. "CriteriaMax", false)
	LabelSetText(VendorSearch.WindowName .. "CriteriaText", GetStringFromTid(1154546)) -- Selected Search Criteria

	-- request the bank gold update
	CharacterSheet.NextBankGoldUpdate = 0

	-- get the bank gould amount
	local bankGold = tonumber(WindowData.PlayerStatus["BankGold"] or 0)

	-- show the current balancec we have
	LabelSetText(VendorSearch.WindowName .. "BankBalanceValue", StringUtils.AddCommasToNumber(bankGold))

	-- fill the criteria set combo box
	VendorSearch.RefreshCriteriaSetCombo()

	-- draw the gold icon
	EquipmentData.DrawObjectIcon(3823, 0, VendorSearch.WindowName .. "GoldIcon")
	
	-- map the original gumps buttons
	VendorSearch.UpdateButtonsMap()
	
	-- hide the loading screen
	VendorSearch.SetLoading(false)
end

function VendorSearch.Shutdown()
	
	-- hide the loading screen
	VendorSearch.SetLoading(false)

	-- press the "cancel" button in the original gump to close it
	if GumpsParsing.ParsedGumps[VendorSearch.GumpID] then
		GumpsParsing.PressButton(VendorSearch.GumpID, VendorSearch.Cancel)
	end

	-- remove the window from the snappable windows list
	SnapUtils.SnappableWindows[VendorSearch.WindowName] = nil

	-- save the window position
	WindowUtils.SaveWindowPosition(VendorSearch.WindowName)

	-- destroy the window
	DestroyWindow(VendorSearch.WindowName)
end

function VendorSearch.ToggleSearch(forcedState)
	
	-- is the forcedState parameter boolean? (it might not be since the click event send a number that we don't need)
	if type(forcedState) ~= "boolean" then

		-- since it's not boolean, we can get rid of the value
		forcedState = nil
	end

	-- is the vendor search window visible?
	if not DoesWindowExist(VendorSearch.WindowName) then
		
		-- call the vendor search gump
		Actions.ToggleVendorSearch()

		return
	end

	-- initialize the visibility flag to the forced value (if we have one)
	local visibility = forcedState

	-- do we need to force a visibilty state?
	if visibility == nil then

		-- if we don't have a forced state, we invert the current visibility
		visibility =  not WindowGetShowing(VendorSearch.WindowName)
	end	

	-- apply the new visibility state
	WindowSetShowing(VendorSearch.WindowName, visibility)

	-- do we have the search engine visible?
	if visibility == true then

		-- hide the search results
		GumpsParsing.DestroyGump(VendorSearch.ResultsGumpID)
	end
end

function VendorSearch.CountCriteria()
	
	-- initialize criteria count
	local count =  0

	-- price sort criteria found flag
	local lowHighFound = false

	-- do we have the vendor search gump active?
	if GumpsParsing.ParsedGumps[VendorSearch.GumpID] then

		-- scan all the labels in the gump
		for label, data in pairsByKeys(GumpData.Gumps[VendorSearch.GumpID].Labels) do

			-- is the criteria greater than 20? then we can get out because there can't be any more criteria
			if count > 20 then
				break
			end

			-- is this label the price low to high or high to low?
			if data.tid == 1154696 or data.tid == 1154697 then -- Price: Low to High // Price: High to Low

				-- mark the price sort criteria found
				lowHighFound = true

				-- increase the criteria count
				count = count + 1

				-- we can get out because this always comes last
				break

			-- this labels are of no interest to us
			elseif data.tid == 1154546 or data.tid == 1114513 then -- Selected Search Criteria // <DIV ALIGN=CENTER>~1_TOKEN~</DIV>
				continue

			-- is this the item name label and the criteria count is greater than 1 (without price sorting) and the label id is greater than 3?
			-- there are no criteria left then.
			elseif data.tid == 1154510 and (count > 1 or lowHighFound == false) and data.id > 3 then -- item name
				break

			else -- increase the criteria count
				count = count + 1
			end
		end
	end

	-- do we have the price sort criteria?
	if not lowHighFound then

		-- we count 1 less criteria
		count = -1
	end

	return count
end

function VendorSearch.GetError()

	-- do we have the vendor search gump active?
	if GumpsParsing.ParsedGumps[VendorSearch.GumpID] then

		-- scan all the gump labels
		for label, data in pairs(GumpData.Gumps[VendorSearch.GumpID].Labels) do
			
			-- cancel button label
			if data.tid == 1150300 then -- CANCEL

				-- the next label after cancel must not be the title token
				if GumpData.Gumps[VendorSearch.GumpID].Labels[label+1].tid ~= 1114514 then -- <DIV ALIGN=RIGHT>~1_TOKEN~</DIV>

					-- and it can't be the warning that you can't add more criteria
					if GumpData.Gumps[VendorSearch.GumpID].Labels[label+1].tid ~= 1154681 then -- You may not add any more search criteria items.

						-- found an error
						return GumpData.Gumps[VendorSearch.GumpID].Labels[label+1].tid

					else -- no errors
						return
					end

				else -- no errors
					return
				end
			end
		end
	end
end

VendorSearch.OldCriteriaLabels = 0

-- To be executed everytime a criteria is added
function VendorSearch.UpdateButtonsMap() 
	
	-- count the active criterias
	VendorSearch.TotalCriteria = VendorSearch.CountCriteria()

	-- Searches done before a certain date do not include the price sorting so the count will be broken
	if VendorSearch.TotalCriteria == -1 and not VendorSearch.ForceSort then

		-- reset the criteria
		GumpsParsing.PressButton(VendorSearch.GumpID, 24)

		-- show the loading screen
		VendorSearch.SetLoading(true)

		-- flag that we forced the sort process
		VendorSearch.ForceSort = true

		-- let's start over
		return
	end

	-- do we have a forced sort? (the count is -1 and we need 0)
	if VendorSearch.ForceSort then
		VendorSearch.TotalCriteria = 0
	end

	--------------------------------------------------------------------------------------------------
	--
	--	BUTTONS MAP
	--
	--------------------------------------------------------------------------------------------------
	-- Excluding the main buttons, most of the data must be put inside combo boxes.
	-- 
	-- NOTE: all the ButtonID must be sum to the number of criteria already in place
	--
	--------------------------------------------------------------------------------------------------
	--
	-- STRUCTURE EXAMPLE:
	-- [ComboBoxID] = {buttonID=XXX, buttonText="", tid=NNNNNN, [textboxId=YYY] };
	--
	-- If the textboxId is specified, the text box must be shown near the combobox.
	--------------------------------------------------------------------------------------------------
	
	-- cancel button ID
	VendorSearch.Cancel = VendorSearch.TotalCriteria + 22

	-- search button ID
	VendorSearch.Search = VendorSearch.TotalCriteria + 23

	-- clear search button ID
	VendorSearch.ClearSearch = VendorSearch.TotalCriteria + 24

	-- confirm price range button ID
	VendorSearch.ConfirmPriceRange = VendorSearch.TotalCriteria + 25
	
	-- get the min price from the textbox of the gump and we remove all the commas
	local minn = string.gsub(tostring(TextEditBoxGetText(GumpData.Gumps[VendorSearch.GumpID].TextEntry[2])), ",", "")
	minn = tonumber(minn)

	-- get the max price from the textbox of the gump and we remove all the commas
	local maxx = string.gsub(tostring(TextEditBoxGetText(GumpData.Gumps[VendorSearch.GumpID].TextEntry[3])), ",", "")
	maxx = tonumber(maxx)

	-- create the price range table
	VendorSearch.PriceRange = {
		min = minn,
		max = maxx
	}

	-- get the active errors
	local error = VendorSearch.GetError()

	-- do we have an error?
	if error then

		-- store the error text
		VendorSearch.CurrentError = GetStringFromTid(error)

		-- write the error in the label
		LabelSetText(VendorSearch.WindowName .. "OtherError", GetStringFromTid(error))

		-- set the error color to red
		LabelSetTextColor(VendorSearch.WindowName .. "OtherError", 255, 0, 0)

		-- set the transparency at 100%
		WindowSetAlpha(VendorSearch.WindowName .. "OtherError", 255)

		-- start blinking the error
		WindowStartAlphaAnimation(VendorSearch.WindowName .. "OtherError", Window.AnimationType.EASE_OUT, 1, 0, 1, false, 20, 0)

	else -- hide the error label by setting the transparency to 0
		WindowSetAlpha(VendorSearch.WindowName .. "OtherError", 0)

		VendorSearch.CurrentError = L""
	end
	
	-- write the min and max price to the textbox
	TextEditBoxSetText(VendorSearch.WindowName .. "MinPriceText", towstring(VendorSearch.PriceRange.min))
	TextEditBoxSetText(VendorSearch.WindowName .. "MaxPriceText", towstring(VendorSearch.PriceRange.max))
		
	-- low to high price sort active by default
	VendorSearch.PriceLowToHigh = true
	
	-- criteria buttons list initialize
	VendorSearch.CurrentCriteriaButtons = {}

	-- current criteria table initialize (for saving if the player wants to)
	VendorSearch.CurrentCriteriaTable = {}
	
	-- main window name
	local dialog = "VendorSearchSW"

	-- scroll area name
	local parent = dialog.. "ScrollChild"
	
	-- scan all the old criterias
	for i = 1, VendorSearch.OldCriteriaLabels do

		-- criteria element name
		local slotName = parent .. "Item" .. i

		-- does the element still exit?
		if DoesWindowExist(slotName) then

			-- relete the element
			DestroyWindow(slotName)
		end
	end

	-- hide the search by name button (it will appear when we type something as name)
	WindowSetShowing(VendorSearch.WindowName .. "ItemNameButton", false)
	
	-- initialize price sort type
	VendorSearch.priceSortSet = nil

	-- mapping all the buttons and textbox for every possible property that we can use to add new criterias
	local CategoryOffset = 0
	VendorSearch.CategoriesButtons = {
		[1]  = { buttonId = VendorSearch.TotalCriteria + CategoryOffset + 1, buttonText = "price range", tid = 1154512};
		[2]  = { buttonId = VendorSearch.TotalCriteria + CategoryOffset + 2, buttonText = "miscellaneous", tid = 1011173};
		[3]  = { buttonId = VendorSearch.TotalCriteria + CategoryOffset + 3, buttonText = "equipment", tid = 1078237};
		[4]  = { buttonId = VendorSearch.TotalCriteria + CategoryOffset + 4, buttonText = "combat", tid = 1077417};
		[5]  = { buttonId = VendorSearch.TotalCriteria + CategoryOffset + 5, buttonText = "casting", tid = 1076209};
		[6]  = { buttonId = VendorSearch.TotalCriteria + CategoryOffset + 6, buttonText = "damage type", tid = 1154535};
		[7]  = { buttonId = VendorSearch.TotalCriteria + CategoryOffset + 7, buttonText = "hit spell", tid = 1154536};
		[8]  = { buttonId = VendorSearch.TotalCriteria + CategoryOffset + 8, buttonText = "hit area", tid = 1154537};
		[9]  = { buttonId = VendorSearch.TotalCriteria + CategoryOffset + 9, buttonText = "resists", tid = 1114254};
		[10] = { buttonId = VendorSearch.TotalCriteria + CategoryOffset + 10, buttonText = "stats", tid = 1114262};
		[11] = { buttonId = VendorSearch.TotalCriteria + CategoryOffset + 11, buttonText = "arachnid/reptile slayers", tid = 1154683};
		[12] = { buttonId = VendorSearch.TotalCriteria + CategoryOffset + 12, buttonText = "repond/undead slayers", tid = 1154684};
		[13] = { buttonId = VendorSearch.TotalCriteria + CategoryOffset + 13, buttonText = "demon/fey/elemental slayers", tid = 1154685};
		[14] = { buttonId = VendorSearch.TotalCriteria + CategoryOffset + 14, buttonText = "required skill", tid = 1154543};
		[15] = { buttonId = VendorSearch.TotalCriteria + CategoryOffset + 15, buttonText = "skill group 1", tid = 1114255};
		[16] = { buttonId = VendorSearch.TotalCriteria + CategoryOffset + 16, buttonText = "skill group 2", tid = 1114256};
		[17] = { buttonId = VendorSearch.TotalCriteria + CategoryOffset + 17, buttonText = "skill group 3", tid = 1114257};
		[18] = { buttonId = VendorSearch.TotalCriteria + CategoryOffset + 18, buttonText = "skill group 4", tid = 1114258};
		[19] = { buttonId = VendorSearch.TotalCriteria + CategoryOffset + 19, buttonText = "skill group 5", tid = 1114259};
		[20] = { buttonId = VendorSearch.TotalCriteria + CategoryOffset + 20, buttonText = "skill group 6", tid = 1114260};
		[21] = { buttonId = VendorSearch.TotalCriteria + CategoryOffset + 21, buttonText = "sort results", tid = 1154695};
	}
	
	local EquipmentOffset = 25
	VendorSearch.EquipmentButtons = {
		[1]  = { buttonId = VendorSearch.TotalCriteria + EquipmentOffset + 1, buttonText = "footwear/talons", tid = 1154602};
		[2]  = { buttonId = VendorSearch.TotalCriteria + EquipmentOffset + 2, buttonText = "pants/leg armor", tid = 1154603};
		[3]  = { buttonId = VendorSearch.TotalCriteria + EquipmentOffset + 3, buttonText = "shirt", tid = 1154604};
		[4]  = { buttonId = VendorSearch.TotalCriteria + EquipmentOffset + 4, buttonText = "hat/head armor", tid = 1154605};
		[5]  = { buttonId = VendorSearch.TotalCriteria + EquipmentOffset + 5, buttonText = "hand/kilt armor", tid = 1154606};
		[6]  = { buttonId = VendorSearch.TotalCriteria + EquipmentOffset + 6, buttonText = "ring", tid = 1154607};
		[7]  = { buttonId = VendorSearch.TotalCriteria + EquipmentOffset + 7, buttonText = "talisman", tid = 1154608};
		[8]  = { buttonId = VendorSearch.TotalCriteria + EquipmentOffset + 8, buttonText = "necklace/neck armor", tid = 1154609};
		[9]  = { buttonId = VendorSearch.TotalCriteria + EquipmentOffset + 9, buttonText = "apron/belt", tid = 1154611};
		[10] = { buttonId = VendorSearch.TotalCriteria + EquipmentOffset + 10, buttonText = "chest armor", tid = 1154612};
		[11] = { buttonId = VendorSearch.TotalCriteria + EquipmentOffset + 11, buttonText = "bracelet", tid = 1154613};
		[12] = { buttonId = VendorSearch.TotalCriteria + EquipmentOffset + 12, buttonText = "surcoat/tunic/sash", tid = 1154616};
		[13] = { buttonId = VendorSearch.TotalCriteria + EquipmentOffset + 13, buttonText = "earrings/gargish glasses", tid = 1154617};
		[14] = { buttonId = VendorSearch.TotalCriteria + EquipmentOffset + 14, buttonText = "arm armor", tid = 1154618};
		[15] = { buttonId = VendorSearch.TotalCriteria + EquipmentOffset + 15, buttonText = "cloak/quiver/wing armor", tid = 1154619};
		[16] = { buttonId = VendorSearch.TotalCriteria + EquipmentOffset + 16, buttonText = "dress/robe", tid = 1154621};
		[17] = { buttonId = VendorSearch.TotalCriteria + EquipmentOffset + 17, buttonText = "skirt", tid = 1154622};
	}
	
	local CombatOffset = 42
	VendorSearch.CombatButtons = {
		[1]  = { buttonId = VendorSearch.TotalCriteria + CombatOffset + 1,  buttonText = "damage increase", tid = 1062747, textboxId = 4};
		[2]  = { buttonId = VendorSearch.TotalCriteria + CombatOffset + 2,  buttonText = "defense chance", tid = 1116527, textboxId = 5};
		[3]  = { buttonId = VendorSearch.TotalCriteria + CombatOffset + 3,  buttonText = "hit chance", tid = 1116526, textboxId = 6};
		[4]  = { buttonId = VendorSearch.TotalCriteria + CombatOffset + 4,  buttonText = "swing speed", tid = 1075629, textboxId = 7};
		[5]  = { buttonId = VendorSearch.TotalCriteria + CombatOffset + 5,  buttonText = "soul charge", tid = 1116536, textboxId = 8};
		[6]  = { buttonId = VendorSearch.TotalCriteria + CombatOffset + 6,  buttonText = "use best weapon skill", tid = 1079592};
		[7]  = { buttonId = VendorSearch.TotalCriteria + CombatOffset + 7,  buttonText = "reactive paralyze", tid = 1112364};
		[8]  = { buttonId = VendorSearch.TotalCriteria + CombatOffset + 8,  buttonText = "assassin honed", tid = 1152206};
		[9]  = { buttonId = VendorSearch.TotalCriteria + CombatOffset + 9,  buttonText = "searing weapon", tid = 1151183};
		[10] = { buttonId = VendorSearch.TotalCriteria + CombatOffset + 10, buttonText = "blood drinker", tid = 1113591};
		[11] = { buttonId = VendorSearch.TotalCriteria + CombatOffset + 11, buttonText = "battle lust", tid = 1113710};
		[12] = { buttonId = VendorSearch.TotalCriteria + CombatOffset + 12, buttonText = "balanced", tid = 1072792};
		[13] = { buttonId = VendorSearch.TotalCriteria + CombatOffset + 13, buttonText = "focus", tid = 1044110, textboxId = 87};
		[14] = { buttonId = VendorSearch.TotalCriteria + CombatOffset + 14, buttonText = "fire eater", tid = 1075860, textboxId = 9};
		[15] = { buttonId = VendorSearch.TotalCriteria + CombatOffset + 15, buttonText = "cold eater", tid = 1154663, textboxId = 10};
		[16] = { buttonId = VendorSearch.TotalCriteria + CombatOffset + 16, buttonText = "poison eater", tid = 1154664, textboxId = 11};
		[17] = { buttonId = VendorSearch.TotalCriteria + CombatOffset + 17, buttonText = "energy eater", tid = 1154665, textboxId = 12};
		[18] = { buttonId = VendorSearch.TotalCriteria + CombatOffset + 18, buttonText = "kinetic eater", tid = 1154666, textboxId = 13};
		[19] = { buttonId = VendorSearch.TotalCriteria + CombatOffset + 19, buttonText = "damage eater", tid = 1154667, textboxId = 14};
	}
	
	local CastingOffset = 61
	VendorSearch.CastingButtons = {
		[1]  = { buttonId = VendorSearch.TotalCriteria + CastingOffset + 1,  buttonText = "fire resonance", tid = 1154655, textboxId = 15};
		[2]  = { buttonId = VendorSearch.TotalCriteria + CastingOffset + 2,  buttonText = "cold resonance", tid = 1154656, textboxId = 16};
		[3]  = { buttonId = VendorSearch.TotalCriteria + CastingOffset + 3,  buttonText = "poison resonance", tid = 1154657, textboxId = 17};
		[4]  = { buttonId = VendorSearch.TotalCriteria + CastingOffset + 4,  buttonText = "energy resonance", tid = 1154658, textboxId = 18};
		[5]  = { buttonId = VendorSearch.TotalCriteria + CastingOffset + 5,  buttonText = "kinetic resonance", tid = 1154659};
		[6]  = { buttonId = VendorSearch.TotalCriteria + CastingOffset + 6,  buttonText = "spell damage increase", tid = 1062742, textboxId = 20};
		[7]  = { buttonId = VendorSearch.TotalCriteria + CastingOffset + 7,  buttonText = "casting focus", tid = 1116535, textboxId = 21};
		[8]  = { buttonId = VendorSearch.TotalCriteria + CastingOffset + 8,  buttonText = "faster cast recovery", tid = 1062743, textboxId = 22};
		[9]  = { buttonId = VendorSearch.TotalCriteria + CastingOffset + 9,  buttonText = "faster casting", tid = 1062744, textboxId = 23};
		[10] = { buttonId = VendorSearch.TotalCriteria + CastingOffset + 10, buttonText = "lower mana cost", tid = 1062745, textboxId = 24};
		[11] = { buttonId = VendorSearch.TotalCriteria + CastingOffset + 11, buttonText = "lower reagent cost", tid = 1062757, textboxId = 25};
		[12] = { buttonId = VendorSearch.TotalCriteria + CastingOffset + 12, buttonText = "mage weapon", tid = 1062755, textboxId = 26};
		[13] = { buttonId = VendorSearch.TotalCriteria + CastingOffset + 13, buttonText = "mage armor", tid = 1060437};
		[14] = { buttonId = VendorSearch.TotalCriteria + CastingOffset + 14, buttonText = "spell channeling", tid = 1060482};
	}
	
	local MiscOffset = 75
	VendorSearch.MiscellaneousButtons = {
		[1]  = { buttonId = VendorSearch.TotalCriteria + MiscOffset + 1,  buttonText = "exclude items on felucca", tid = 1154646};
		[2]  = { buttonId = VendorSearch.TotalCriteria + MiscOffset + 2,  buttonText = "gargoyles only", tid = 1111709};
		[3]  = { buttonId = VendorSearch.TotalCriteria + MiscOffset + 3,  buttonText = "not gargoyles only", tid = 1154704};
		[4]  = { buttonId = VendorSearch.TotalCriteria + MiscOffset + 4,  buttonText = "elves only", tid = 1075086};
		[5]  = { buttonId = VendorSearch.TotalCriteria + MiscOffset + 5,  buttonText = "not elves only", tid = 1154703};
		[6]  = { buttonId = VendorSearch.TotalCriteria + MiscOffset + 6,  buttonText = "faction item", tid = 1041350};
		[7]  = { buttonId = VendorSearch.TotalCriteria + MiscOffset + 7,  buttonText = "promotional token", tid = 1154682};
		[8]  = { buttonId = VendorSearch.TotalCriteria + MiscOffset + 8,  buttonText = "night sight", tid = 1015168};
		[9]  = { buttonId = VendorSearch.TotalCriteria + MiscOffset + 9,  buttonText = "cursed", tid = 1049643};
		[10] = { buttonId = VendorSearch.TotalCriteria + MiscOffset + 10, buttonText = "not cursed", tid = 1154701};
		[11] = { buttonId = VendorSearch.TotalCriteria + MiscOffset + 11, buttonText = "cannot be repaired", tid = 1151782};
		[12] = { buttonId = VendorSearch.TotalCriteria + MiscOffset + 12, buttonText = "not cannot be repaired", tid = 1154705};
		[13] = { buttonId = VendorSearch.TotalCriteria + MiscOffset + 13, buttonText = "brittle", tid = 1116209};
		[14] = { buttonId = VendorSearch.TotalCriteria + MiscOffset + 14, buttonText = "not brittle", tid = 1154702};
		[15] = { buttonId = VendorSearch.TotalCriteria + MiscOffset + 15, buttonText = "antique", tid = 1152714};
		[16] = { buttonId = VendorSearch.TotalCriteria + MiscOffset + 16, buttonText = "not antique", tid = 1156479};		
		[17] = { buttonId = VendorSearch.TotalCriteria + MiscOffset + 17, buttonText = "enhance potions", tid = 1075624, textboxId = 27};
		[18] = { buttonId = VendorSearch.TotalCriteria + MiscOffset + 18, buttonText = "lower requirements", tid = 1062753, textboxId = 28};
		[19] = { buttonId = VendorSearch.TotalCriteria + MiscOffset + 19, buttonText = "luck", tid = 1061153, textboxId = 29};
		[20] = { buttonId = VendorSearch.TotalCriteria + MiscOffset + 20, buttonText = "reflect physical damage", tid = 1062738, textboxId = 30};
		[21] = { buttonId = VendorSearch.TotalCriteria + MiscOffset + 21, buttonText = "self repair", tid = 1079709, textboxId = 31};
		[22] = { buttonId = VendorSearch.TotalCriteria + MiscOffset + 22, buttonText = "artifact rarity", tid = 1154693, textboxId = 32};
	}
	
	local DamageTypeOffset = MiscOffset + 22
	VendorSearch.DamageTypeButtons = {
		[1] = { buttonId = VendorSearch.TotalCriteria + DamageTypeOffset + 1, buttonText = "physical damage", tid = 1151800, textboxId = 33};
		[2] = { buttonId = VendorSearch.TotalCriteria + DamageTypeOffset + 2, buttonText = "cold damage", tid = 1151802, textboxId = 34};
		[3] = { buttonId = VendorSearch.TotalCriteria + DamageTypeOffset + 3, buttonText = "fire damage", tid = 1151801, textboxId = 35};
		[4] = { buttonId = VendorSearch.TotalCriteria + DamageTypeOffset + 4, buttonText = "poison damage", tid = 1151803, textboxId = 36};
		[5] = { buttonId = VendorSearch.TotalCriteria + DamageTypeOffset + 5, buttonText = "energy damage", tid = 1151804, textboxId = 37};
	}
	
	local HitSpellOffset = DamageTypeOffset + 5
	VendorSearch.HitSpellButtons = {
		[1]  = { buttonId = VendorSearch.TotalCriteria + HitSpellOffset + 1,  buttonText = "hit dispel", tid = 1079702, textboxId = 38};
		[2]  = { buttonId = VendorSearch.TotalCriteria + HitSpellOffset + 2,  buttonText = "hit fireball", tid = 1079703, textboxId = 39};
		[3]  = { buttonId = VendorSearch.TotalCriteria + HitSpellOffset + 3,  buttonText = "hit harm", tid = 1079704, textboxId = 40};
		[4]  = { buttonId = VendorSearch.TotalCriteria + HitSpellOffset + 4,  buttonText = "hit curse", tid = 1154673, textboxId = 41};
		[5]  = { buttonId = VendorSearch.TotalCriteria + HitSpellOffset + 5,  buttonText = "hit life leech", tid = 1079698, textboxId = 42};
		[6]  = { buttonId = VendorSearch.TotalCriteria + HitSpellOffset + 6,  buttonText = "hit lightning", tid = 1079705, textboxId = 43};
		[7]  = { buttonId = VendorSearch.TotalCriteria + HitSpellOffset + 7,  buttonText = "velocity", tid = 1080416, textboxId = 44};
		[8]  = { buttonId = VendorSearch.TotalCriteria + HitSpellOffset + 8,  buttonText = "hit lower attack", tid = 1079699, textboxId = 45};
		[9]  = { buttonId = VendorSearch.TotalCriteria + HitSpellOffset + 9,  buttonText = "hit lower defense", tid = 1079700, textboxId = 46};
		[10] = { buttonId = VendorSearch.TotalCriteria + HitSpellOffset + 10, buttonText = "hit magic arrow", tid = 1079706, textboxId = 47};
		[11] = { buttonId = VendorSearch.TotalCriteria + HitSpellOffset + 11, buttonText = "hit mana leech", tid = 1079701, textboxId = 48};
		[12] = { buttonId = VendorSearch.TotalCriteria + HitSpellOffset + 12, buttonText = "hit stamina leech", tid = 1079707, textboxId = 49};
		[13] = { buttonId = VendorSearch.TotalCriteria + HitSpellOffset + 13, buttonText = "hit fatigue", tid = 1154668, textboxId = 50};
		[14] = { buttonId = VendorSearch.TotalCriteria + HitSpellOffset + 14, buttonText = "hit mana drain", tid = 1154669, textboxId = 51};
		[15] = { buttonId = VendorSearch.TotalCriteria + HitSpellOffset + 15, buttonText = "splintering weapon", tid = 1154670};
		[16] = { buttonId = VendorSearch.TotalCriteria + HitSpellOffset + 16, buttonText = "bane", tid = 1154468};
	}		
													
	local HitAreaOffset = HitSpellOffset + 16
	VendorSearch.HitAreaButtons = {
		[1] = { buttonId = VendorSearch.TotalCriteria + HitAreaOffset + 1, buttonText = "hit cold area", tid = 1079693, textboxId = 53};
		[2] = { buttonId = VendorSearch.TotalCriteria + HitAreaOffset + 2, buttonText = "hit energy area", tid = 1079694, textboxId = 54};
		[3] = { buttonId = VendorSearch.TotalCriteria + HitAreaOffset + 3, buttonText = "hit fire area", tid = 1079695, textboxId = 55};
		[4] = { buttonId = VendorSearch.TotalCriteria + HitAreaOffset + 4, buttonText = "hit physical area", tid = 1079696, textboxId = 56};
		[5] = { buttonId = VendorSearch.TotalCriteria + HitAreaOffset + 5, buttonText = "hit poison area", tid = 1079697, textboxId = 57};
	}
	
	local ResistOffset = HitAreaOffset + 5
	VendorSearch.ResistButtons = {
		[1] = { buttonId = VendorSearch.TotalCriteria + ResistOffset + 1, buttonText = "cold resist", tid = 1062750, textboxId = 58};
		[2] = { buttonId = VendorSearch.TotalCriteria + ResistOffset + 2, buttonText = "energy resist", tid = 1062752, textboxId = 59};
		[3] = { buttonId = VendorSearch.TotalCriteria + ResistOffset + 3, buttonText = "fire resist", tid = 1062749, textboxId = 60};
		[4] = { buttonId = VendorSearch.TotalCriteria + ResistOffset + 4, buttonText = "physical resist", tid = 1062748, textboxId = 61};
		[5] = { buttonId = VendorSearch.TotalCriteria + ResistOffset + 5, buttonText = "poison resist", tid = 1062751, textboxId = 62};
	}
	
	local StatsOffset = ResistOffset + 5
	VendorSearch.StatsButtons = {
		[1] = { buttonId = VendorSearch.TotalCriteria + StatsOffset + 1,  buttonText = "strength bonus", tid = 1062728, textboxId = 63};
		[2] = { buttonId = VendorSearch.TotalCriteria + StatsOffset + 2,  buttonText = "dexterity bonus", tid = 1062729, textboxId = 64};
		[3] = { buttonId = VendorSearch.TotalCriteria + StatsOffset + 3,  buttonText = "intelligence bonus", tid = 1062730, textboxId = 65};
		[4] = { buttonId = VendorSearch.TotalCriteria + StatsOffset + 4,  buttonText = "hit points increase", tid = 1079404, textboxId = 66};
		[5] = { buttonId = VendorSearch.TotalCriteria + StatsOffset + 5,  buttonText = "stamina increase", tid = 1062732, textboxId = 67};
		[6] = { buttonId = VendorSearch.TotalCriteria + StatsOffset + 6,  buttonText = "mana increase", tid = 1062733, textboxId = 68};
		[7] = { buttonId = VendorSearch.TotalCriteria + StatsOffset + 7,  buttonText = "hit point regeneration", tid = 1062734, textboxId = 69};
		[8] = { buttonId = VendorSearch.TotalCriteria + StatsOffset + 8,  buttonText = "stamina regeneration", tid = 1062756, textboxId = 70};
		[9] = { buttonId = VendorSearch.TotalCriteria + StatsOffset + 9,  buttonText = "mana regeneration", tid = 1062735, textboxId = 71};
	}
	
	local SlayersOffset = StatsOffset + 9
	VendorSearch.SlayersButtons = {
		[1]  = { buttonId = VendorSearch.TotalCriteria + SlayersOffset + 30, buttonText = "air elemental slayer", tid = 1060457};
		[2]  = { buttonId = VendorSearch.TotalCriteria + SlayersOffset + 6, buttonText = "arachnid slayer", tid = 1060458};
		[3]  = { buttonId = VendorSearch.TotalCriteria + SlayersOffset + 11, buttonText = "bat slayer", tid = 1072506};
		[4]  = { buttonId = VendorSearch.TotalCriteria + SlayersOffset + 12, buttonText = "bear slayer", tid = 1072504};
		[5]  = { buttonId = VendorSearch.TotalCriteria + SlayersOffset + 13, buttonText = "beetle slayer", tid = 1072508};
		[6]  = { buttonId = VendorSearch.TotalCriteria + SlayersOffset + 14, buttonText = "bird slayer", tid = 1072509};
		[7]  = { buttonId = VendorSearch.TotalCriteria + SlayersOffset + 31, buttonText = "blood elemental slayer", tid = 1060459};
		[8]  = { buttonId = VendorSearch.TotalCriteria + SlayersOffset + 15, buttonText = "bovine slayer", tid = 1072512};
		[9]  = { buttonId = VendorSearch.TotalCriteria + SlayersOffset + 26, buttonText = "demon slayer", tid = 1060460};
		[10] = { buttonId = VendorSearch.TotalCriteria + SlayersOffset + 2, buttonText = "dragon slayer", tid = 1060462};
		[11] = { buttonId = VendorSearch.TotalCriteria + SlayersOffset + 32, buttonText = "earth elemental slayer", tid = 1060463};
		[12] = { buttonId = VendorSearch.TotalCriteria + SlayersOffset + 29, buttonText = "elemental slayer", tid = 1060464};
		[13] = { buttonId = VendorSearch.TotalCriteria + SlayersOffset + 28, buttonText = "fey slayer", tid = 1070855};
		[14] = { buttonId = VendorSearch.TotalCriteria + SlayersOffset + 33, buttonText = "fire elemental slayer", tid = 1060465};
		[15] = { buttonId = VendorSearch.TotalCriteria + SlayersOffset + 16, buttonText = "flame slayer", tid = 1072511};
		[16] = { buttonId = VendorSearch.TotalCriteria + SlayersOffset + 27, buttonText = "gargoyle slayer", tid = 1060466};
		[17] = { buttonId = VendorSearch.TotalCriteria + SlayersOffset + 17, buttonText = "goblin slayer", tid = 1095010};
		[18] = { buttonId = VendorSearch.TotalCriteria + SlayersOffset + 18, buttonText = "ice slayer", tid = 1072510};
		[19] = { buttonId = VendorSearch.TotalCriteria + SlayersOffset + 3, buttonText = "lizardman slayer", tid = 1060467};
		[20] = { buttonId = VendorSearch.TotalCriteria + SlayersOffset + 19, buttonText = "mage slayer", tid = 1072507};
		[21] = { buttonId = VendorSearch.TotalCriteria + SlayersOffset + 20, buttonText = "ogre slayer", tid = 1060468};
		[22] = { buttonId = VendorSearch.TotalCriteria + SlayersOffset + 4, buttonText = "ophidian slayer", tid = 1060469};
		[23] = { buttonId = VendorSearch.TotalCriteria + SlayersOffset + 21, buttonText = "orc slayer", tid = 1060470};
		[24] = { buttonId = VendorSearch.TotalCriteria + SlayersOffset + 34, buttonText = "poison elemental slayer", tid = 1060471};
		[25] = { buttonId = VendorSearch.TotalCriteria + SlayersOffset + 10, buttonText = "repond slayer", tid = 1060472};
		[26] = { buttonId = VendorSearch.TotalCriteria + SlayersOffset + 1, buttonText = "reptile slayer", tid = 1060473};
		[27] = { buttonId = VendorSearch.TotalCriteria + SlayersOffset + 7, buttonText = "scorpion slayer", tid = 1060474};
		[28] = { buttonId = VendorSearch.TotalCriteria + SlayersOffset + 5, buttonText = "snake slayer", tid = 1060475};
		[29] = { buttonId = VendorSearch.TotalCriteria + SlayersOffset + 35, buttonText = "snow elemental slayer", tid = 1079745 };
		[30] = { buttonId = VendorSearch.TotalCriteria + SlayersOffset + 8, buttonText = "spider slayer", tid = 1060477};
		[31] = { buttonId = VendorSearch.TotalCriteria + SlayersOffset + 9, buttonText = "terathan slayer", tid = 1060478};
		[32] = { buttonId = VendorSearch.TotalCriteria + SlayersOffset + 22, buttonText = "troll slayer", tid = 1060480};
		[33] = { buttonId = VendorSearch.TotalCriteria + SlayersOffset + 24, buttonText = "undead slayer", tid = 1060479};
		[34] = { buttonId = VendorSearch.TotalCriteria + SlayersOffset + 23, buttonText = "vermin slayer", tid = 1072505};
		[35] = { buttonId = VendorSearch.TotalCriteria + SlayersOffset + 36, buttonText = "water elemental slayer", tid = 1060481};
		[36] = { buttonId = VendorSearch.TotalCriteria + SlayersOffset + 25, buttonText = "wolf slayer", tid = 1075462};
	}
	
	local SkillReqOffset = SlayersOffset + 36
	VendorSearch.SkillReqButtons = {
		[1] = { buttonId = VendorSearch.TotalCriteria + SkillReqOffset + 1, buttonText = "swordsmanship", tid = 1002151};
		[2] = { buttonId = VendorSearch.TotalCriteria + SkillReqOffset + 2, buttonText = "mace fighting", tid = 1002102};
		[3] = { buttonId = VendorSearch.TotalCriteria + SkillReqOffset + 3, buttonText = "fencing", tid = 1002073};
		[4] = { buttonId = VendorSearch.TotalCriteria + SkillReqOffset + 4, buttonText = "archery", tid = 1002029};
		[5] = { buttonId = VendorSearch.TotalCriteria + SkillReqOffset + 5, buttonText = "throwing", tid = 1044117};
	}
	
	local SkillsOffset = SkillReqOffset + 5
	VendorSearch.SkillsButtons = {
		[1]  = { buttonId = VendorSearch.TotalCriteria + 0, buttonText = "skill group 1", tid = 1114255};
		[2]  = { buttonId = VendorSearch.TotalCriteria + SkillsOffset + 1, buttonText = "swordsmanship", tid = 1002151, textboxId = 72};
		[3]  = { buttonId = VendorSearch.TotalCriteria + SkillsOffset + 2, buttonText = "fencing", tid = 1002073, textboxId = 73};
		[4]  = { buttonId = VendorSearch.TotalCriteria + SkillsOffset + 3, buttonText = "mace fighting", tid = 1002102, textboxId = 74};
		[5]  = { buttonId = VendorSearch.TotalCriteria + SkillsOffset + 4, buttonText = "magery", tid = 1002106, textboxId = 75};
		[6]  = { buttonId = VendorSearch.TotalCriteria + SkillsOffset + 5, buttonText = "musicianship", tid = 1002116, textboxId = 76};
		[7]  = { buttonId = VendorSearch.TotalCriteria + 0, buttonText = "skill group 2", tid = 1114256};
		[8]  = { buttonId = VendorSearch.TotalCriteria + SkillsOffset + 6, buttonText = "wrestling", tid = 1002169, textboxId = 77};
		[9]  = { buttonId = VendorSearch.TotalCriteria + SkillsOffset + 7, buttonText = "tactics", tid = 1017321, textboxId = 78};
		[10] = { buttonId = VendorSearch.TotalCriteria + SkillsOffset + 8, buttonText = "animal taming", tid = 1002010, textboxId = 79};
		[11] = { buttonId = VendorSearch.TotalCriteria + SkillsOffset + 9, buttonText = "provocation", tid = 1002125, textboxId = 80};
		[12] = { buttonId = VendorSearch.TotalCriteria + SkillsOffset + 10, buttonText = "spirit speak", tid = 1002140, textboxId = 81};
		[13] = { buttonId = VendorSearch.TotalCriteria + 0, buttonText = "skill group 3", tid = 1114257};
		[14] = { buttonId = VendorSearch.TotalCriteria + SkillsOffset + 11, buttonText = "stealth", tid = 1042394, textboxId = 82};
		[15] = { buttonId = VendorSearch.TotalCriteria + SkillsOffset + 12, buttonText = "parrying", tid = 1002118, textboxId = 83};
		[16] = { buttonId = VendorSearch.TotalCriteria + SkillsOffset + 13, buttonText = "meditation", tid = 1042393, textboxId = 84};
		[17] = { buttonId = VendorSearch.TotalCriteria + SkillsOffset + 14, buttonText = "animal lore", tid = 1002007, textboxId = 85};
		[18] = { buttonId = VendorSearch.TotalCriteria + SkillsOffset + 15, buttonText = "discordance", tid = 1042362, textboxId = 86};
		[19] = { buttonId = VendorSearch.TotalCriteria + SkillsOffset + 16, buttonText = "focus", tid = 1044110, textboxId = 87};
		[20] = { buttonId = VendorSearch.TotalCriteria + 0, buttonText = "skill group 4", tid = 1114258};
		[21] = { buttonId = VendorSearch.TotalCriteria + SkillsOffset + 17, buttonText = "stealing", tid = 1002142, textboxId = 88};
		[22] = { buttonId = VendorSearch.TotalCriteria + SkillsOffset + 18, buttonText = "anatomy", tid = 1002004, textboxId = 89};
		[23] = { buttonId = VendorSearch.TotalCriteria + SkillsOffset + 19, buttonText = "eval intelligence", tid = 1044076, textboxId = 90};
		[24] = { buttonId = VendorSearch.TotalCriteria + SkillsOffset + 20, buttonText = "veterinary", tid = 1002167, textboxId = 91};
		[25] = { buttonId = VendorSearch.TotalCriteria + SkillsOffset + 21, buttonText = "necromancy", tid = 1044109, textboxId = 92};
		[26] = { buttonId = VendorSearch.TotalCriteria + SkillsOffset + 22, buttonText = "bushido", tid = 1044112, textboxId = 93};
		[27] = { buttonId = VendorSearch.TotalCriteria + SkillsOffset + 23, buttonText = "mysticism", tid = 1044115, textboxId = 94};
		[28] = { buttonId = VendorSearch.TotalCriteria + 0, buttonText = "skill group 5", tid = 1114259};
		[29] = { buttonId = VendorSearch.TotalCriteria + SkillsOffset + 24, buttonText = "healing", tid = 1002082, textboxId = 95};
		[30] = { buttonId = VendorSearch.TotalCriteria + SkillsOffset + 25, buttonText = "resisting spells", tid = 1044086, textboxId = 96};
		[31] = { buttonId = VendorSearch.TotalCriteria + SkillsOffset + 26, buttonText = "peacemaking", tid = 1002120, textboxId = 97};
		[32] = { buttonId = VendorSearch.TotalCriteria + SkillsOffset + 27, buttonText = "archery", tid = 1002029, textboxId = 98};
		[33] = { buttonId = VendorSearch.TotalCriteria + SkillsOffset + 28, buttonText = "chivalry", tid = 1044111, textboxId = 99};
		[34] = { buttonId = VendorSearch.TotalCriteria + SkillsOffset + 29, buttonText = "ninjitsu", tid = 1044113, textboxId = 100};
		[35] = { buttonId = VendorSearch.TotalCriteria + SkillsOffset + 30, buttonText = "throwing", tid = 1044117, textboxId = 101};
		[36] = { buttonId = VendorSearch.TotalCriteria + 0, buttonText = "skill group 6", tid = 1114260};
		[37] = { buttonId = VendorSearch.TotalCriteria + SkillsOffset + 31, buttonText = "lumberjacking", tid = 1002100, textboxId = 102};
		[38] = { buttonId = VendorSearch.TotalCriteria + SkillsOffset + 32, buttonText = "snooping", tid = 1002138, textboxId = 103};
		[39] = { buttonId = VendorSearch.TotalCriteria + SkillsOffset + 33, buttonText = "mining", tid = 1002111, textboxId = 104};
	}
	
	-- index of the previous array to be used only as description.
	VendorSearch.IgnoreSkillsButton = { 
	[1] = true,
	[7] = true,
	[13] = true,
	[20] = true,
	[28] = true,
	[36] = true,
	}
	
	local PriceOffset = SkillsOffset + 33
	VendorSearch.PriceButtons = {
		[1] = { buttonId = VendorSearch.TotalCriteria + PriceOffset + 1, buttonText = "price: low to high", tid = 1154696};
		[2] = { buttonId = VendorSearch.TotalCriteria + PriceOffset + 2, buttonText = "price: high to low", tid = 1154697};
	}

	-- initialize count
	local i = 0

	-- scan all criterias
	for j = 0, VendorSearch.TotalCriteria + 1 do

		-- since we're looking for the criterias, we can skip this lines
		if GumpData.Gumps[VendorSearch.GumpID].Labels[j + 1].tid == 1154546 or GumpData.Gumps[VendorSearch.GumpID].Labels[j + 1].tid == 1114513 then -- Selected Search Criteria // <DIV ALIGN=CENTER>~1_TOKEN~</DIV>
			continue
		end

		-- increase the count
		i = i + 1

		-- is this the low to high price sort?
		if GumpData.Gumps[VendorSearch.GumpID].Labels[j + 1].tid == 1154696 then -- Price: Low to High

			-- se the flag that the price sort is low to high
			VendorSearch.PriceLowToHigh = true

			-- price sort button name
			local button = VendorSearch.WindowName .. "LowHighButton"

			-- resize the button
			WindowSetDimensions(button, 22, 22)

			-- set the arrow from top to down
			ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL, "arrowdown", 0, 0)		
			ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED, "arrowdown", 0, 0)
			ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "arrowdown", 24 , 0)
			ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, "arrowdown", 24 , 0)

			-- flag that we have a price sort set.
			VendorSearch.priceSortSet = true

			continue
			
		-- is this the high to low price sort?
		elseif GumpData.Gumps[VendorSearch.GumpID].Labels[j + 1].tid == 1154697 then -- Price: High to Low

			-- se the flag that the price sort is high to low
			VendorSearch.PriceLowToHigh = false

			-- price sort button name
			local button = VendorSearch.WindowName .. "LowHighButton"

			-- resize the button
			WindowSetDimensions(button, 22, 22)

			-- set the arrow from down to top
			ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL, "arrowup", 0, 0)
			ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED, "arrowup", 0, 0)		
			ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, "arrowup", 24, 0)
			ButtonSetTexture(button, InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, "arrowup", 24, 0)

			-- flag that we have a price sort set.
			VendorSearch.priceSortSet = true

			continue
		end

		-- initialize the item name variable
		local itemName

		-- initialize the text parameter variable
		local textParam

		-- is this the item name label?
		if GumpData.Gumps[VendorSearch.GumpID].Labels[j + 1].tid == 1154510 then -- Item Name

			-- get the item name from the textbox of the gump
			itemName =  wstring.trim(TextEditBoxGetText(GumpData.Gumps[VendorSearch.GumpID].TextEntry[1]))

			-- initialize the parameter with the item name and : as affix so we can build the string: Item Name: <name>
			textParam = L": " .. itemName

			-- fill the textbox with the item name
			TextEditBoxSetText(VendorSearch.WindowName .. "ItemNameText", itemName)
		end
		
		-- criteria element name
		local slotName = parent .. "Item" .. i

		-- criteria text element name
		local elementName = parent .. "Item" .. i .. "Name"

		-- remove criteria button name
		local elementButton = parent .. "Item" .. i .. "RemoveButton"

		-- create the element
		CreateWindowFromTemplate(slotName, "ItemTemplateVS", parent)
		
		-- is this the first element?
		if i == 1 then

			-- anchor the element to the top of the window
			WindowAddAnchor(slotName, "topleft", parent, "topleft", 10, 5)
			WindowAddAnchor(slotName, "topright", dialog, "topright", 0, 0)

		else -- anchor the item to the previous one
			WindowAddAnchor(slotName, "bottomleft", parent.."Item" .. i-1, "topleft", 0, 10)
			WindowAddAnchor(slotName, "bottomright", dialog, "topright", 0, 0)
		end

		-- set the element ID to the remove button
		WindowSetId(elementButton, i)

		-- fill the property name with the value of the parameter
		local name = ReplaceTokens(GetStringFromTid(GumpData.Gumps[VendorSearch.GumpID].Labels[j + 1].tid), GumpData.Gumps[VendorSearch.GumpID].Labels[j + 1].tidParms)

		-- do we have text parameter? then this is the item name and we have to create the label properly
		if textParam then
			name = name .. textParam
		end

		-- fill the element name with the properly formatted property
		LabelSetText(elementName, FormatProperly(name))
		
		-- create the criteria record with all the data about the label and button ID
		local arr = {buttonId = i, labelId = j + 1, tid = GumpData.Gumps[VendorSearch.GumpID].Labels[j + 1].tid, tidParams = GumpData.Gumps[VendorSearch.GumpID].Labels[j + 1].tidParms, textParam = textParam, itsItemName = itemName}

		-- insert the record in the criteria table
		table.insert(VendorSearch.CurrentCriteriaButtons, arr)
		
		-- default criteria tid
		local propTid = arr.tid

		-- skill names must be taken from the params
		if arr.tid >= 1060451 and arr.tid <= 1060455 then -- ~1_skillname~ +~2_val~
			propTid = tonumber(tostring(wstring.gsub(arr.tidParams[1], L"#", L"")))
		end

		-- get the type of array linked to this criteria, the buttonText in the array and the textboxId
		local array, buttonText, textboxId = VendorSearch.GetCriteriaArrayData(propTid, (arr.tidParams ~= nil and #arr.tidParams >= 1) )
			
		-- do we have the info about this property? (we should have it for everything except item name and price range)
		if array then

			-- initialize the criteria text variable
			local criteriaText

			-- does the criteria text exist?
			if DoesWindowExist(GumpData.Gumps[VendorSearch.GumpID].TextEntry[textboxId]) then

				-- get the gump textbox text for the criteria we're going to add
				criteriaText = TextEditBoxGetText(GumpData.Gumps[VendorSearch.GumpID].TextEntry[textboxId])
			end

			-- create the record for the array
			local record = {array = array, buttonText = buttonText, criteriaText = criteriaText}
	
			-- insert the current criteria into the table (the ID should match the criteria list - excluding the item name)
			table.insert(VendorSearch.CurrentCriteriaTable, record)
		end

		-- increase the criteria count
		VendorSearch.OldCriteriaLabels = i
	end
	
	-- do we have the item name in the criteria?
	if not (VendorSearch.CurrentCriteriaButtons[1] and VendorSearch.CurrentCriteriaButtons[1].itsItemName and VendorSearch.CurrentCriteriaButtons[1].itsItemName == TextEditBoxGetText(VendorSearch.WindowName .. "ItemNameText")) then

		-- we don't have the name, so we reset the textbox for the name
		TextEditBoxSetText(VendorSearch.WindowName .. "ItemNameText", L"")
	end
	
	-- do we need to force the sort?
	if VendorSearch.ForceSort then

		-- click the price sort button
		GumpsParsing.PressButton(VendorSearch.GumpID, VendorSearch.PriceButtons[1].buttonId)

		-- remove the flag to force the sorting
		VendorSearch.ForceSort = nil
	end
	
	-- fill the combo with all the table we previously created
	ComboBoxClearMenuItems(VendorSearch.WindowName .. "MiscCombo")
	for i, button in pairsByIndex(VendorSearch.MiscellaneousButtons) do
		ComboBoxAddMenuItem(VendorSearch.WindowName .. "MiscCombo", FormatProperly(GetStringFromTid(button.tid) ))
	end
	
	ComboBoxClearMenuItems(VendorSearch.WindowName .. "EquipCombo")
	for i, button in pairsByIndex(VendorSearch.EquipmentButtons) do
		ComboBoxAddMenuItem(VendorSearch.WindowName .. "EquipCombo", FormatProperly(GetStringFromTid(button.tid) ))
	end
	
	ComboBoxClearMenuItems(VendorSearch.WindowName .. "CombatCombo")
	for i, button in pairsByIndex(VendorSearch.CombatButtons) do
		ComboBoxAddMenuItem(VendorSearch.WindowName .. "CombatCombo", FormatProperly(GetStringFromTid(button.tid) ))
	end
	
	ComboBoxClearMenuItems(VendorSearch.WindowName .. "CastingCombo")
	for i, button in pairsByIndex(VendorSearch.CastingButtons) do
		ComboBoxAddMenuItem(VendorSearch.WindowName .. "CastingCombo", FormatProperly(GetStringFromTid(button.tid) ))
	end
	
	ComboBoxClearMenuItems(VendorSearch.WindowName .. "SlayersCombo")
	for i, button in pairsByIndex(VendorSearch.SlayersButtons) do
		ComboBoxAddMenuItem(VendorSearch.WindowName .. "SlayersCombo", FormatProperly(GetStringFromTid(button.tid) ))
	end
	
	ComboBoxClearMenuItems(VendorSearch.WindowName .. "ResistCombo")
	for i, button in pairsByIndex(VendorSearch.ResistButtons) do
		ComboBoxAddMenuItem(VendorSearch.WindowName .. "ResistCombo", FormatProperly(GetStringFromTid(button.tid) ))
	end
	
	ComboBoxClearMenuItems(VendorSearch.WindowName .. "StatsCombo")
	for i, button in pairsByIndex(VendorSearch.StatsButtons) do
		ComboBoxAddMenuItem(VendorSearch.WindowName .. "StatsCombo", FormatProperly(GetStringFromTid(button.tid) ))
	end
	
	ComboBoxClearMenuItems(VendorSearch.WindowName .. "SkillsCombo")
	for i, button in pairsByIndex(VendorSearch.SkillsButtons) do
		if VendorSearch.IgnoreSkillsButton[i] then
			ComboBoxAddMenuItem(VendorSearch.WindowName .. "SkillsCombo", L"---" .. FormatProperly(GetStringFromTid(button.tid) .. L"---" ))
		else
			ComboBoxAddMenuItem(VendorSearch.WindowName .. "SkillsCombo", FormatProperly(GetStringFromTid(button.tid)))
		end
	end
	
	ComboBoxClearMenuItems(VendorSearch.WindowName .. "HitSpellCombo")
	for i, button in pairsByIndex(VendorSearch.HitSpellButtons) do
		ComboBoxAddMenuItem(VendorSearch.WindowName .. "HitSpellCombo", FormatProperly(GetStringFromTid(button.tid) ))
	end
	
	ComboBoxClearMenuItems(VendorSearch.WindowName .. "HitAreaCombo")
	for i, button in pairsByIndex(VendorSearch.HitAreaButtons) do
		ComboBoxAddMenuItem(VendorSearch.WindowName .. "HitAreaCombo", FormatProperly(GetStringFromTid(button.tid) ))
	end
	
	ComboBoxClearMenuItems(VendorSearch.WindowName .. "SkillReqCombo")
	for i, button in pairsByIndex(VendorSearch.SkillReqButtons) do
		ComboBoxAddMenuItem(VendorSearch.WindowName .. "SkillReqCombo", FormatProperly(GetStringFromTid(button.tid) ))
	end
	
	ComboBoxClearMenuItems(VendorSearch.WindowName .. "DamageTypeCombo")
	for i, button in pairsByIndex(VendorSearch.DamageTypeButtons) do
		ComboBoxAddMenuItem(VendorSearch.WindowName .. "DamageTypeCombo", FormatProperly(GetStringFromTid(button.tid) ))
	end

	-- process the criteria loading
	VendorSearch.LoadCriteriaSetProcess()
end

function VendorSearch.RemoveCriteria()

	-- get the button ID
	local id = WindowGetId(SystemData.ActiveWindow.name)

	-- is this the item name?
	if VendorSearch.CurrentCriteriaButtons[id].itsItemName then

		-- rese the textbox with the item name
		TextEditBoxSetText(VendorSearch.WindowName .. "ItemNameText", L"")
	end

	-- get the label text for this criteria
	local desc = LabelGetText(WindowGetParent(SystemData.ActiveWindow.name) .. "Name")

	-- show the loading screen
	VendorSearch.SetLoading(true)

	-- press the button to remove the criteria
	GumpsParsing.PressButton(VendorSearch.GumpID, id)
end

function VendorSearch.LowHighButton()

	-- get the button ID
	local id = WindowGetId(SystemData.ActiveWindow.name)

	-- show the loading screen
	VendorSearch.SetLoading(true)

	-- swap the price sort based on the current setting
	if not VendorSearch.PriceLowToHigh then
		GumpsParsing.PressButton(VendorSearch.GumpID, VendorSearch.PriceButtons[1].buttonId)

	else
		GumpsParsing.PressButton(VendorSearch.GumpID, VendorSearch.PriceButtons[2].buttonId)
	end
end

function VendorSearch.OnItemNameTextChanged(text)

	-- is the gump still open?
	if not GumpData.Gumps[VendorSearch.GumpID] then
		return
	end

	-- update the gump item name while we fill the window textbox
	TextEditBoxSetText(GumpData.Gumps[VendorSearch.GumpID].TextEntry[1], text)

	-- is the textbox empty?
	if wstring.len(text) <= 0 then
		
		-- hide the add search by name button
		WindowSetShowing(VendorSearch.WindowName .. "ItemNameButton", false)

	else -- show the add search by name button
		WindowSetShowing(VendorSearch.WindowName .. "ItemNameButton", true)
	end
end

function VendorSearch.TargetName()

	-- show the target the item overhead text
	SendOverheadText(GetStringFromTid(1154972), OverheadText.CustomMessageHues.LIGHTBLUE) -- Target the item

	-- send a target request to the player
	RequestTargetInfo(VendorSearch.TargetNameReceived)
end

function VendorSearch.TargetNameReceived(objId)
	
	-- is the id invalid or it's a mobile?
	if not IsValidID(objId) or VerifyMobileID(objId) then

		-- show the overhead error
		SendOverheadText(GetStringFromTid(1154965), OverheadText.CustomMessageHues.RED) -- Invalid item.
		return
	end

	-- get the object ID properties data
	local dt = Interface.GetItemPropertiesData( objId, "Vendor search target props" )

	-- initialize the properties array
	local props

	-- do we have the item properties data?
	if dt then

		-- create the TID properties array
		props = ItemProperties.BuildParamsArray( dt, true )
	end
	
	-- do we have the properties array?
	if not props then
		return
	end

	-- get the item name
	local name = ItemProperties.GetObjectProperties( objId, 1, "Vendor search target name" )

	-- is this a scroll of alacrity?
	if props[1078604] then -- scroll of alacrity
		
		-- get the skill TID for the scroll
		local skill = tostring(wstring.gsub(props[1151930][1], L"#", L"")) -- Skill: ~1_skillname~ ~2_skillamount~ ~3_unitname~

		-- convert the TID in number
		skill = tonumber(skill)

		-- do we have a valid TID?
		if IsValidID(skill) then

			-- format the name for the alacrity scroll
			name = L"alacrity " .. GetStringFromTid(skill)
		end
	end
	
	-- is this a scroll of transcendence?
	if props[1094934] then -- scroll of transcendence

		-- get the skill TID for the scroll
		local skill = tostring(wstring.gsub(props[1151930][1], L"#", L"")) -- Skill: ~1_skillname~ ~2_skillamount~ ~3_unitname~

		-- convert the TID in number
		skill = tonumber(skill)

		-- do we have a valid TID?
		if IsValidID(skill) then	

			-- format the name for the transcendence scroll
			name = L"transcendence " .. GetStringFromTid(skill)
		end
	end
	
	-- is this a 105 power scroll?
	if (props[1049639]) then -- a wondrous scroll of ~1_type~ (105 Skill)

		-- get the skill TID for the scroll
		local skill = tostring(wstring.gsub(props[1049639][1], L"#", L"")) -- Skill: ~1_skillname~ ~2_skillamount~ ~3_unitname~

		-- convert the TID in number
		skill = tonumber(skill)

		-- do we have a valid TID?
		if IsValidID(skill) then	
			
			-- format the name for the 105 scroll
			name = L"scroll of " .. GetStringFromTid(skill) .. L" 105"
		end
	end
	
	-- is this a 110 power scroll?
	if props[1049640] then -- an exalted scroll of ~1_type~ (110 Skill)

		-- get the skill TID for the scroll
		local skill = tostring(wstring.gsub(props[1049640][1], L"#", L"")) -- Skill: ~1_skillname~ ~2_skillamount~ ~3_unitname~

		-- convert the TID in number
		skill = tonumber(skill)

		-- do we have a valid TID?
		if IsValidID(skill) then	
		
			-- format the name for the 110 scroll
			name = L"scroll of " .. GetStringFromTid(skill) .. L" 110"
		end
	end
	
	-- is this a 115 power scroll?
	if props[1049641] then -- a mythical scroll of ~1_type~ (115 Skill)

		-- get the skill TID for the scroll
		local skill = tostring(wstring.gsub(props[1049641][1], L"#", L"")) -- Skill: ~1_skillname~ ~2_skillamount~ ~3_unitname~

		-- convert the TID in number
		skill = tonumber(skill)

		-- do we have a valid TID?
		if IsValidID(skill) then		
		
			-- format the name for the 115 scroll
			name = L"scroll of " .. GetStringFromTid(skill) .. L" 115"
		end
	end
	
	-- is this a 120 power scroll?
	if props[1049642] then -- a legendary scroll of ~1_type~ (120 Skill)

		-- get the skill TID for the scroll
		local skill = tostring(wstring.gsub(props[1049642][1], L"#", L"")) -- Skill: ~1_skillname~ ~2_skillamount~ ~3_unitname~

		-- convert the TID in number
		skill = tonumber(skill)

		-- do we have a valid TID?
		if IsValidID(skill) then			
		
			-- format the name for the 120 scroll
			name = GetStringFromTid(skill) .. L" 120 scroll"
		end
	end

	-- scan all the properties
	for tid, data in pairs(props) do

		-- is this a treasure map?
		local typ = ItemPropertiesInfo.TreasureMaps[tid]
		if typ then

			-- get the map world name
			if props[1041502] then -- for somewhere in Felucca
				prop = GetStringFromTid(1012001) -- Felucca
				
			elseif props[1041503] then -- for somewhere in Trammel
				prop = GetStringFromTid(1012000) -- Trammel
				
			elseif props[1060850] then -- for somewhere in Ilshenar
				prop = GetStringFromTid(1012002) -- Ilshenar
			
			elseif props[1060851] then -- for somewhere in Malas
				prop = GetStringFromTid(1060643) -- Malas
			
			elseif props[1115645] then -- for somewhere in Tokuno Islands
				prop = GetStringFromTid(1063258) -- Tokuno Islands
			
			elseif props[1115646] then -- for somewhere in Ter Mur
				prop = GetStringFromTid(1112178) -- Ter Mur
			end

			-- format the name properly by adding the type of map and the world name
			name = typ .. L" map " .. wstring.lower(prop)
			break
		end
	end

	-- fill the textbox with the name of the targeted item
	TextEditBoxSetText(VendorSearch.WindowName .. "ItemNameText", name)
end

function VendorSearch.SearchName()

	-- show the loading screen
	VendorSearch.SetLoading(true)

	-- since there is no button to search by name, we apply the current price sort so it will trigger the search by name passively.
	if VendorSearch.PriceLowToHigh then
		GumpsParsing.PressButton(VendorSearch.GumpID, VendorSearch.PriceButtons[1].buttonId)
	else
		GumpsParsing.PressButton(VendorSearch.GumpID, VendorSearch.PriceButtons[2].buttonId)
	end
end

function VendorSearch.OnMinPriceTextChanged(text)

	-- update the gump min price while we fill the window textbox
	TextEditBoxSetText(GumpData.Gumps[VendorSearch.GumpID].TextEntry[2], text)

	-- is the textbox empty?
	if wstring.len(text) <= 0 then
		
		-- hide the add search by price button
		WindowSetShowing(VendorSearch.WindowName .. "PriceRangeButton", false)

	else -- show the add search by price button
		WindowSetShowing(VendorSearch.WindowName .. "PriceRangeButton", true)
	end
end

function VendorSearch.OnMaxPriceTextChanged(text)

	-- update the gump max price while we fill the window textbox
	TextEditBoxSetText(GumpData.Gumps[VendorSearch.GumpID].TextEntry[3], text)

	-- is the textbox empty?
	if wstring.len(text) <= 0 then
		
		-- hide the add search by price button
		WindowSetShowing(VendorSearch.WindowName .. "PriceRangeButton", false)

	else -- show the add search by price button
		WindowSetShowing(VendorSearch.WindowName .. "PriceRangeButton", true)
	end
end

function VendorSearch.SearchPrice()

	-- show the loading screen
	VendorSearch.SetLoading(true)

	-- press the search by price button
	GumpsParsing.PressButton(VendorSearch.GumpID, VendorSearch.ConfirmPriceRange)
end

function VendorSearch.OnTextChanged(text)

	-- get the textbox ID
	local txtId = WindowGetId(SystemData.ActiveWindow.name)

	-- get the textbpx parent name
	local txt = string.gsub(string.gsub(SystemData.ActiveWindow.name, "Text", ""), VendorSearch.WindowName, "")
	
	-- do we have a valid textbox ID?
	if IsValidID(txtId) then

		-- set the gump textbox text
		TextEditBoxSetText(GumpData.Gumps[VendorSearch.GumpID].TextEntry[txtId], text)

		-- is the textbox empty?
		if wstring.len(text) <= 0 then

			-- hide the add criteria button
			WindowSetShowing(VendorSearch.WindowName .. txt .. "Button", false)

		else -- show the add criteria button
			WindowSetShowing(VendorSearch.WindowName .. txt .. "Button", true)
		end

	else -- hide the textbox
		WindowSetShowing(VendorSearch.WindowName .. txt .. "Text", false)
		WindowSetShowing(VendorSearch.WindowName .. txt .. "TextBG", false)
	end
end

function VendorSearch.SearchCombo()

	-- show the loading screen
	VendorSearch.SetLoading(true)

	-- get the combo box add criteria button name
	local combo = string.gsub(string.gsub(SystemData.ActiveWindow.name, "Text", ""), VendorSearch.WindowName, "")
	combo = string.gsub(string.gsub(combo, "Button", ""), VendorSearch.WindowName, "")
	combo = VendorSearch.WindowName .. combo .. "Button"

	-- press the add criteria button
	GumpsParsing.PressButton(VendorSearch.GumpID, WindowGetId(combo))
end

function VendorSearch.OnComboSelChanged( selectedIndex )
	
	-- get the combo box main object name
	local combo = string.gsub(string.gsub(SystemData.ActiveWindow.name, "Combo", ""), VendorSearch.WindowName, "")

	-- initialize the buttons data array
	local array

	-- initialize the flag that indicates the property has a textbox
	local hasTbx = true

	-- load the correct array of buttons for the current property
	if combo == "Misc" then
		array = VendorSearch.MiscellaneousButtons

	elseif combo == "Equip" then
		array = VendorSearch.EquipmentButtons
		hasTbx = false

	elseif combo == "Combat" then
		array = VendorSearch.CombatButtons

	elseif combo == "Casting" then
		array = VendorSearch.CastingButtons

	elseif combo == "Slayers" then
		array = VendorSearch.SlayersButtons

	elseif combo == "Resist" then
		array = VendorSearch.ResistButtons

	elseif combo == "Stats" then
		array = VendorSearch.StatsButtons

	elseif combo == "Skills" then
		array = VendorSearch.SkillsButtons

	elseif combo == "HitSpell" then
		array = VendorSearch.HitSpellButtons

	elseif combo == "HitArea" then
		array = VendorSearch.HitAreaButtons

	elseif combo == "SkillReq" then
		array = VendorSearch.SkillReqButtons

	elseif combo == "DamageType" then
		array = VendorSearch.DamageTypeButtons
	end

	-- nothing has been selected
	if array[selectedIndex].buttonId == VendorSearch.TotalCriteria then
		ComboBoxSetSelectedMenuItem( SystemData.ActiveWindow.name, 0 )
	end

	-- set the add criteria button ID to the gump button ID
	WindowSetId(VendorSearch.WindowName .. combo .. "Button", array[selectedIndex].buttonId)

	-- do we have a selection and the property has a textbox and a valid butto ID?
	if hasTbx and array[selectedIndex].textboxId and array[selectedIndex].buttonId > 0 and array[selectedIndex].buttonId ~= VendorSearch.TotalCriteria then

		-- set the ID for the gump textbox to the window textbox
		WindowSetId(VendorSearch.WindowName .. combo .. "Text", array[selectedIndex].textboxId)

		-- set the window textbox text with the same text as the gump textbox
		TextEditBoxSetText(VendorSearch.WindowName .. combo .. "Text", TextEditBoxGetText(GumpData.Gumps[VendorSearch.GumpID].TextEntry[array[selectedIndex].textboxId]))

		-- show the textbox
		WindowSetShowing(VendorSearch.WindowName .. combo .. "Text", true)
		WindowSetShowing(VendorSearch.WindowName .. combo .. "TextBG", true)

		-- move the cursor on the textbox
		WindowAssignFocus(VendorSearch.WindowName .. combo .. "Text", true)

		-- show the add criteria button
		WindowSetShowing(VendorSearch.WindowName .. combo .. "Button", true)

	-- do we have a tetbox but nothing has been selected?
	elseif hasTbx or array[selectedIndex].buttonId == VendorSearch.TotalCriteria then

		-- hide the textbox
		WindowSetShowing(VendorSearch.WindowName .. combo .. "Text", false)
		WindowSetShowing(VendorSearch.WindowName .. combo .. "TextBG", false)
	end
end

function VendorSearch.ClearAll()

	-- show the loading screen
	VendorSearch.SetLoading(true)

	-- press the clear search button
	GumpsParsing.PressButton(VendorSearch.GumpID, VendorSearch.ClearSearch)
end

function VendorSearch.SearchThis()

	-- show the loading screen
	VendorSearch.SetLoading(true)

	-- press the search button
	GumpsParsing.PressButton(VendorSearch.GumpID, VendorSearch.Search)
end

VendorSearch.CriteriaBlink = false
function VendorSearch.OnUpdate(timePassed)
	
	-- is the custom error being shown?
	if VendorSearch.CustomError and VendorSearch.CustomError > 0 then
		VendorSearch.CustomError = VendorSearch.CustomError - timePassed
		
	-- time to show the previous error?
	elseif IsValidWString(VendorSearch.CurrentError) then

		-- show the error label
		WindowSetShowing(VendorSearch.WindowName .. "OtherError", true)

		-- restore the error in the label
		LabelSetText(VendorSearch.WindowName .. "OtherError", VendorSearch.CurrentError)

		-- set the error color to red
		LabelSetTextColor(VendorSearch.WindowName .. "OtherError", 255, 0, 0)

	 -- time to hide the custom error?
	elseif not IsValidWString(VendorSearch.CurrentError) then

		-- hide the error label
		WindowSetShowing(VendorSearch.WindowName .. "OtherError", false)

		-- hide the label
		WindowSetAlpha(VendorSearch.WindowName .. "OtherError", 0)

		-- set the error color to red
		LabelSetTextColor(VendorSearch.WindowName .. "OtherError", 255, 0, 0)
	end

	-- do we have less than 20 criteria and an error is showing?
	if VendorSearch.TotalCriteria < 20  or WindowGetAlpha(VendorSearch.WindowName .. "OtherError") > 0 then

		-- hide the max criteria error
		WindowSetShowing(VendorSearch.WindowName .. "CriteriaMax", false)

		-- is the max criteria error blinking?
		if VendorSearch.CriteriaBlink then

			-- stop the max criteria error blink animation
			WindowStopAlphaAnimation(VendorSearch.WindowName .. "CriteriaMax")

			-- flag that the error animation has been stopped
			VendorSearch.CriteriaBlink = false
		end

	-- no errors in the errors box
	elseif WindowGetAlpha(VendorSearch.WindowName .. "OtherError") == 0 then

		-- show max criteria error
		WindowSetShowing(VendorSearch.WindowName .. "CriteriaMax", true)

		-- the max criteria error is not blinking?
		if not VendorSearch.CriteriaBlink then

			-- start the blinking animation for the max criteria error
			WindowStartAlphaAnimation(VendorSearch.WindowName .. "CriteriaMax", Window.AnimationType.LOOP, 0.3, 1, 1, false, 0, 0)

			-- flag that the error animation has started
			VendorSearch.CriteriaBlink = true
		end
	end
	
	-- does the item name has the cursor inside?
	if WindowHasFocus(VendorSearch.WindowName .. "ItemNameText") then

		-- show the search by item name button
		WindowSetShowing(VendorSearch.WindowName .. "ItemNameButton", true)

	-- does the item name is empty and we have no item name criteria?
	elseif not WindowHasFocus(VendorSearch.WindowName .. "ItemNameText") and (wstring.len(TextEditBoxGetText(VendorSearch.WindowName .. "ItemNameText")) <= 0 or (VendorSearch.CurrentCriteriaButtons[1] and VendorSearch.CurrentCriteriaButtons[1].itsItemName and VendorSearch.CurrentCriteriaButtons[1].itsItemName == TextEditBoxGetText(VendorSearch.WindowName .. "ItemNameText"))) then

		-- hide the search by item name button
		WindowSetShowing(VendorSearch.WindowName .. "ItemNameButton", false)
	end
	
	-- get the min price from the textbox
	local minn = string.gsub(tostring(TextEditBoxGetText(VendorSearch.WindowName .. "MinPriceText")), ",", "")
	minn = tonumber(minn)
	
	-- get the max price from the textbox
	local maxx = string.gsub(tostring(TextEditBoxGetText(VendorSearch.WindowName .. "MaxPriceText")), ",", "")
	maxx = tonumber(maxx)
	
	-- does the min price textbox has the cursor inside?
	if WindowHasFocus(VendorSearch.WindowName .. "MinPriceText") then

		-- show the search by price range button
		WindowSetShowing(VendorSearch.WindowName .. "PriceRangeButton", true)

	-- does the max price textbox has the cursor inside?
	elseif WindowHasFocus(VendorSearch.WindowName .. "MaxPriceText")  then
		
		-- show the search by price range button
		WindowSetShowing(VendorSearch.WindowName .. "PriceRangeButton", true)

	-- does both max and min price textbox have no cursor inside and they are empty and there is no price range criteria?
	elseif (not WindowHasFocus(VendorSearch.WindowName .. "MinPriceText") and (wstring.len(TextEditBoxGetText(VendorSearch.WindowName .. "MinPriceText")) <= 0 or VendorSearch.PriceRange.min == minn)) and
		   (not WindowHasFocus(VendorSearch.WindowName .. "MaxPriceText") and (wstring.len(TextEditBoxGetText(VendorSearch.WindowName .. "MaxPriceText")) <= 0 or VendorSearch.PriceRange.max == maxx))
			then
		
		-- hide the search by price range button
		WindowSetShowing(VendorSearch.WindowName .. "PriceRangeButton", false)
	end
		
	-- get the selected index for each combo. If we don't have an index, we disable the add criteria button. 
	-- Otherwise we show the add criteria button.
	local Equip = ComboBoxGetSelectedMenuItem(VendorSearch.WindowName .. "EquipCombo")
	if Equip <= 0 then
		WindowSetShowing(VendorSearch.WindowName .. "EquipButton", false)		
	else
		WindowSetShowing(VendorSearch.WindowName .. "EquipButton", true)
	end
	
	local misc = ComboBoxGetSelectedMenuItem(VendorSearch.WindowName .. "MiscCombo")
	if misc <= 0 then
		WindowSetShowing(VendorSearch.WindowName .. "MiscText", false)
		WindowSetShowing(VendorSearch.WindowName .. "MiscTextBG", false)
		WindowSetShowing(VendorSearch.WindowName .. "MiscButton", false)		
	else
		WindowSetShowing(VendorSearch.WindowName .. "MiscButton", true)
	end
	
	local Combat = ComboBoxGetSelectedMenuItem(VendorSearch.WindowName .. "CombatCombo")
	if Combat <= 0 then
		WindowSetShowing(VendorSearch.WindowName .. "CombatText", false)
		WindowSetShowing(VendorSearch.WindowName .. "CombatTextBG", false)
		WindowSetShowing(VendorSearch.WindowName .. "CombatButton", false)		
	else
		WindowSetShowing(VendorSearch.WindowName .. "CombatButton", true)
	end
	
	local Casting = ComboBoxGetSelectedMenuItem(VendorSearch.WindowName .. "CastingCombo")
	if Casting <= 0 then
		WindowSetShowing(VendorSearch.WindowName .. "CastingText", false)
		WindowSetShowing(VendorSearch.WindowName .. "CastingTextBG", false)
		WindowSetShowing(VendorSearch.WindowName .. "CastingButton", false)		
	else
		WindowSetShowing(VendorSearch.WindowName .. "CastingButton", true)
	end
	
	local Slayers = ComboBoxGetSelectedMenuItem(VendorSearch.WindowName .. "SlayersCombo")
	if Slayers <= 0 then
		WindowSetShowing(VendorSearch.WindowName .. "SlayersText", false)
		WindowSetShowing(VendorSearch.WindowName .. "SlayersTextBG", false)
		WindowSetShowing(VendorSearch.WindowName .. "SlayersButton", false)		
	else
		WindowSetShowing(VendorSearch.WindowName .. "SlayersButton", true)
	end
	
	local Resist = ComboBoxGetSelectedMenuItem(VendorSearch.WindowName .. "ResistCombo")
	if Resist <= 0 then
		WindowSetShowing(VendorSearch.WindowName .. "ResistText", false)
		WindowSetShowing(VendorSearch.WindowName .. "ResistTextBG", false)
		WindowSetShowing(VendorSearch.WindowName .. "ResistButton", false)		
	else
		WindowSetShowing(VendorSearch.WindowName .. "ResistButton", true)
	end
	
	local Stats = ComboBoxGetSelectedMenuItem(VendorSearch.WindowName .. "StatsCombo")
	if Stats <= 0 then
		WindowSetShowing(VendorSearch.WindowName .. "StatsText", false)
		WindowSetShowing(VendorSearch.WindowName .. "StatsTextBG", false)
		WindowSetShowing(VendorSearch.WindowName .. "StatsButton", false)		
	else
		WindowSetShowing(VendorSearch.WindowName .. "StatsButton", true)
	end
	
	local Skills = ComboBoxGetSelectedMenuItem(VendorSearch.WindowName .. "SkillsCombo")
	if Skills <= 0 or VendorSearch.SkillsButtons[Skills].buttonId == VendorSearch.TotalCriteria then
		WindowSetShowing(VendorSearch.WindowName .. "SkillsText", false)
		WindowSetShowing(VendorSearch.WindowName .. "SkillsTextBG", false)
		WindowSetShowing(VendorSearch.WindowName .. "SkillsButton", false)		
	else
		WindowSetShowing(VendorSearch.WindowName .. "SkillsButton", true)
	end
	
	local HitSpell = ComboBoxGetSelectedMenuItem(VendorSearch.WindowName .. "HitSpellCombo")
	if HitSpell <= 0 or VendorSearch.HitSpellButtons[HitSpell].buttonId == VendorSearch.TotalCriteria  then
		WindowSetShowing(VendorSearch.WindowName .. "HitSpellText", false)
		WindowSetShowing(VendorSearch.WindowName .. "HitSpellTextBG", false)
		WindowSetShowing(VendorSearch.WindowName .. "HitSpellButton", false)		
	else
		WindowSetShowing(VendorSearch.WindowName .. "HitSpellButton", true)
	end
	
	local HitArea = ComboBoxGetSelectedMenuItem(VendorSearch.WindowName .. "HitAreaCombo")
	if HitArea <= 0 or VendorSearch.HitAreaButtons[HitArea].buttonId == VendorSearch.TotalCriteria then
		WindowSetShowing(VendorSearch.WindowName .. "HitAreaText", false)
		WindowSetShowing(VendorSearch.WindowName .. "HitAreaTextBG", false)
		WindowSetShowing(VendorSearch.WindowName .. "HitAreaButton", false)		
	else
		WindowSetShowing(VendorSearch.WindowName .. "HitAreaButton", true)
	end
	
	local SkillReq = ComboBoxGetSelectedMenuItem(VendorSearch.WindowName .. "SkillReqCombo")
	if SkillReq <= 0 or VendorSearch.SkillReqButtons[SkillReq].buttonId == VendorSearch.TotalCriteria then
		WindowSetShowing(VendorSearch.WindowName .. "SkillReqText", false)
		WindowSetShowing(VendorSearch.WindowName .. "SkillReqTextBG", false)
		WindowSetShowing(VendorSearch.WindowName .. "SkillReqButton", false)		
	else
		WindowSetShowing(VendorSearch.WindowName .. "SkillReqButton", true)
	end
	
	local DamageType = ComboBoxGetSelectedMenuItem(VendorSearch.WindowName .. "DamageTypeCombo")
	if DamageType <= 0 or VendorSearch.DamageTypeButtons[DamageType].buttonId == VendorSearch.TotalCriteria then
		WindowSetShowing(VendorSearch.WindowName .. "DamageTypeText", false)
		WindowSetShowing(VendorSearch.WindowName .. "DamageTypeTextBG", false)
		WindowSetShowing(VendorSearch.WindowName .. "DamageTypeButton", false)		
	else
		WindowSetShowing(VendorSearch.WindowName .. "DamageTypeButton", true)
	end

	-- are there criteria to save?
	if #VendorSearch.CurrentCriteriaTable <= 0 and wstring.len(TextEditBoxGetText(VendorSearch.WindowName .. "ItemNameText")) <= 0 then

		-- gray out and disable the save criteria set button
		WindowSetTintColor(VendorSearch.WindowName .. "SaveCriteriaSetting", 125, 125, 125)
		WindowSetHandleInput(VendorSearch.WindowName .. "SaveCriteriaSetting", false)

	else -- enable the save criteria set button
		WindowSetTintColor(VendorSearch.WindowName .. "SaveCriteriaSetting", 255, 255, 255)
		WindowSetHandleInput(VendorSearch.WindowName .. "SaveCriteriaSetting", true)
	end

	-- show the delete criteria set button only if the id is not <NEW CRITERIA>
	WindowSetShowing(VendorSearch.WindowName .. "DeleteCriteriaSetting", VendorSearch.LastSelectedCriteriaSet ~= 1)
end

function VendorSearch.SetLoading(load)

	-- if we're loading, we flag to hold on the window and not close it because we're waiting for the search gump to re-open
	VendorSearch.HoldOn = load

	-- are we waiting for the gump to re-open?
	if VendorSearch.HoldOn then

		-- make the window half transparent
		WindowSetAlpha(VendorSearch.WindowName, 0.5)

		-- is the loading effect showing?
		if not DoesWindowExist(VendorSearch.WindowName .. "LoadingEffect") then

			-- create the loading effect animation
			CreateWindowFromTemplate(VendorSearch.WindowName .. "LoadingEffect", "LoadingEffect", "Root")

			-- anchor the loading animation to the window center
			WindowAddAnchor(VendorSearch.WindowName .. "LoadingEffect", "center", VendorSearch.WindowName, "center", 0, 0)
		end

		-- animate the loading animation
		AnimatedImageStartAnimation( VendorSearch.WindowName .. "LoadingEffect", 1, true, false, 0.0 )

	else -- make the window fully visible
		WindowSetAlpha(VendorSearch.WindowName, 1)

		-- is the loading effect showing?
		if DoesWindowExist(VendorSearch.WindowName .. "LoadingEffect") then

			-- stop the loading animation
			AnimatedImageStopAnimation( VendorSearch.WindowName .. "LoadingEffect" )

			-- destroy the loading animation
			DestroyWindow(VendorSearch.WindowName .. "LoadingEffect")
		end
	end
end

function VendorSearch.GetCriteriaArrayData(tid, hasParams)

	-- do we have a valid tid?
	if not IsValidID(tid) then
		return
	end
	
	-- get the lowered tid text
	local tidText = ReplaceTokens(wstring.lower(GetStringFromTid(tid)), {L""})

	-- remove the percent sign from the text
	tidText = wstring.trim(wstring.gsub(tidText, L"%%", L""))
	tidText = wstring.trim(wstring.gsub(tidText, L"[+]", L""))

	-- if we have parameters is pointless to search here
	if not hasParams then

		-- scan the array to find the array name and id for the button
		for i, data in pairsByIndex(VendorSearch.EquipmentButtons) do
		
			-- get the current text for the criteria
			local currText = ReplaceTokens(wstring.lower(GetStringFromTid(data.tid)), {L""})

			-- is this the button we're looking for?
			if tidText == currText then

				-- we return the array string name, the button text (that will be used to load the right property from the array, even if it changes in the future), and the textboxid (used to get the textbox text from the gump)
				return "VendorSearch.EquipmentButtons", data.buttonText, data.textboxId
			end
		end
	end

	-- scan the array to find the array name and id for the button
	for i, data in pairsByIndex(VendorSearch.CombatButtons) do
		
		-- get the current text for the criteria
		local currText = ReplaceTokens(wstring.lower(GetStringFromTid(data.tid)), {L""})

		-- is this the button we're looking for?
		if tidText == currText then
			
			-- we return the array string name, the button text (that will be used to load the right property from the array, even if it changes in the future), and the textboxid (used to get the textbox text from the gump)
			return "VendorSearch.CombatButtons", data.buttonText, data.textboxId
		end
	end

	-- scan the array to find the array name and id for the button
	for i, data in pairsByIndex(VendorSearch.CastingButtons) do
		
		-- get the current text for the criteria
		local currText = wstring.trim(ReplaceTokens(wstring.lower(GetStringFromTid(data.tid)), {L""}))

		-- is this the button we're looking for?
		if tidText == currText then
			
			-- we return the array string name, the button text (that will be used to load the right property from the array, even if it changes in the future), and the textboxid (used to get the textbox text from the gump)
			return "VendorSearch.CastingButtons", data.buttonText, data.textboxId
		end
	end

	-- scan the array to find the array name and id for the button
	for i, data in pairsByIndex(VendorSearch.MiscellaneousButtons) do
		
		-- get the current text for the criteria
		local currText = ReplaceTokens(wstring.lower(GetStringFromTid(data.tid)), {L""})

		-- is this the button we're looking for?
		if tidText == currText then
			
			-- we return the array string name, the button text (that will be used to load the right property from the array, even if it changes in the future), and the textboxid (used to get the textbox text from the gump)
			return "VendorSearch.MiscellaneousButtons", data.buttonText, data.textboxId
		end
	end

	-- scan the array to find the array name and id for the button
	for i, data in pairsByIndex(VendorSearch.DamageTypeButtons) do
		
		-- get the current text for the criteria
		local currText = ReplaceTokens(wstring.lower(GetStringFromTid(data.tid)), {L""})

		-- is this the button we're looking for?
		if tidText == currText then
			
			-- we return the array string name, the button text (that will be used to load the right property from the array, even if it changes in the future), and the textboxid (used to get the textbox text from the gump)
			return "VendorSearch.DamageTypeButtons", data.buttonText, data.textboxId
		end
	end

	-- scan the array to find the array name and id for the button
	for i, data in pairsByIndex(VendorSearch.HitSpellButtons) do
		
		-- get the current text for the criteria
		local currText = ReplaceTokens(wstring.lower(GetStringFromTid(data.tid)), {L""})

		-- is this the button we're looking for?
		if tidText == currText then
			
			-- we return the array string name, the button text (that will be used to load the right property from the array, even if it changes in the future), and the textboxid (used to get the textbox text from the gump)
			return "VendorSearch.HitSpellButtons", data.buttonText, data.textboxId
		end
	end

	-- scan the array to find the array name and id for the button
	for i, data in pairsByIndex(VendorSearch.HitAreaButtons) do
		
		-- get the current text for the criteria
		local currText = ReplaceTokens(wstring.lower(GetStringFromTid(data.tid)), {L""})

		-- is this the button we're looking for?
		if tidText == currText then
			
			-- we return the array string name, the button text (that will be used to load the right property from the array, even if it changes in the future), and the textboxid (used to get the textbox text from the gump)
			return "VendorSearch.HitAreaButtons", data.buttonText, data.textboxId
		end
	end

	-- scan the array to find the array name and id for the button
	for i, data in pairsByIndex(VendorSearch.ResistButtons) do
		
		-- get the current text for the criteria
		local currText = ReplaceTokens(wstring.lower(GetStringFromTid(data.tid)), {L""})

		-- is this the button we're looking for?
		if tidText == currText then
			
			-- we return the array string name, the button text (that will be used to load the right property from the array, even if it changes in the future), and the textboxid (used to get the textbox text from the gump)
			return "VendorSearch.ResistButtons", data.buttonText, data.textboxId
		end
	end

	-- scan the array to find the array name and id for the button
	for i, data in pairsByIndex(VendorSearch.StatsButtons) do
		
		-- get the current text for the criteria
		local currText = ReplaceTokens(wstring.lower(GetStringFromTid(data.tid)), {L""})

		-- is this the button we're looking for?
		if tidText == currText then
			
			-- we return the array string name, the button text (that will be used to load the right property from the array, even if it changes in the future), and the textboxid (used to get the textbox text from the gump)
			return "VendorSearch.StatsButtons", data.buttonText, data.textboxId
		end
	end

	-- if we have parameters is pointless to search here
	if not hasParams then

		-- scan the array to find the array name and id for the button
		for i, data in pairsByIndex(VendorSearch.SlayersButtons) do
		
			-- get the current text for the criteria
			local currText = ReplaceTokens(wstring.lower(GetStringFromTid(data.tid)), {L""})

			-- is this the button we're looking for?
			if tidText == currText then
			
				-- we return the array string name, the button text (that will be used to load the right property from the array, even if it changes in the future), and the textboxid (used to get the textbox text from the gump)
				return "VendorSearch.SlayersButtons", data.buttonText, data.textboxId
			end
		end
	end

	-- if we have parameters is pointless to search here
	if not hasParams then

		-- scan the array to find the array name and id for the button
		for i, data in pairsByIndex(VendorSearch.SkillReqButtons) do
		
			-- get the current text for the criteria
			local currText = ReplaceTokens(wstring.lower(GetStringFromTid(data.tid)), {L""})

			-- is this the button we're looking for?
			if tidText == currText then
			
				-- we return the array string name, the button text (that will be used to load the right property from the array, even if it changes in the future), and the textboxid (used to get the textbox text from the gump)
				return "VendorSearch.SkillReqButtons", data.buttonText, data.textboxId
			end
		end
	end

	-- scan the array to find the array name and id for the button
	for i, data in pairsByIndex(VendorSearch.SkillsButtons) do
		
		-- get the current text for the criteria
		local currText = ReplaceTokens(wstring.lower(GetStringFromTid(data.tid)), {L""})

		-- is this the button we're looking for?
		if tidText == currText then
			
			-- we return the array string name, the button text (that will be used to load the right property from the array, even if it changes in the future), and the textboxid (used to get the textbox text from the gump)
			return "VendorSearch.SkillsButtons", data.buttonText, data.textboxId
		end
	end
end

function VendorSearch.CriteriaListSelect()
	
	-- get the selected criteria set ID
	local id = ComboBoxGetSelectedMenuItem(VendorSearch.WindowName .. "SavedCriteriaCombo")

	-- show the delete button only if the id is not <NEW CRITERIA>
	WindowSetShowing(VendorSearch.WindowName .. "DeleteCriteriaSetting", id ~= 1)

	-- has the selection changed?
	if id ~= VendorSearch.LastSelectedCriteriaSet then

		-- has <NEW CRITERIA> been selected?
		if id ~= 1 then
			VendorSearch.LoadCriteriaSet(ComboBoxGetSelectedText(VendorSearch.WindowName .. "SavedCriteriaCombo"))
		end

		-- update the last selected ID
		VendorSearch.LastSelectedCriteriaSet = id
	end
end

function VendorSearch.LoadCriteriaSet(name)

	-- do we have a valid name?
	if not IsValidWString(name) then
		return
	end

	-- initialize the loading criteria set process to step 0
	VendorSearch.LoadCriteriaPhase = 0

	-- first we clear the current criteria
	VendorSearch.ClearAll()
end

function VendorSearch.LoadCriteriaSetProcess()

	-- get the name of the criteria set to load
	local loadingCriteriaName = ComboBoxGetSelectedText(VendorSearch.WindowName .. "SavedCriteriaCombo")

	-- if the gump is not showing, we try again in a short time
	if not GumpData.Gumps[VendorSearch.GumpID] or not loadingCriteriaName then
		Interface.AddTodoList({name = "Vendor Search Criteria Retry", func = function() VendorSearch.LoadCriteriaSetProcess() end, time = Interface.TimeSinceLogin + 0.5})

		return
	end

	-- are we loading a criteria set?
	if VendorSearch.LoadCriteriaPhase then
		
		-- show the loading screen
		VendorSearch.SetLoading(true)

		-- load name and price range
		if VendorSearch.LoadCriteriaPhase == 0 then
			
			-- fill the textbox with the saved item name (if we have one saved)
			if VendorSearch.SavedCriteria[loadingCriteriaName].itemName then
				TextEditBoxSetText(VendorSearch.WindowName .. "ItemNameText", VendorSearch.SavedCriteria[loadingCriteriaName].itemName)
			end

			-- do we have a price range?
			if VendorSearch.SavedCriteria[loadingCriteriaName].priceRange then

				-- fill the textbox with the min price
				TextEditBoxSetText(VendorSearch.WindowName .. "MinPriceText", towstring(VendorSearch.SavedCriteria[loadingCriteriaName].priceRange.min))

				-- fill the textbox with the max price
				TextEditBoxSetText(VendorSearch.WindowName .. "MaxPriceText", towstring(VendorSearch.SavedCriteria[loadingCriteriaName].priceRange.max))
			end

			-- move to the next loading sort order phase
			VendorSearch.LoadCriteriaPhase = 999

			-- apply the search for price (that will also apply the name search)
			VendorSearch.SearchPrice()

		-- loading the price sort order
		elseif VendorSearch.LoadCriteriaPhase == 999 then

			-- move to the next loading criteria phase
			VendorSearch.LoadCriteriaPhase = 1

			-- set the sort order
			if VendorSearch.SavedCriteria[loadingCriteriaName].PriceLowToHigh then
				GumpsParsing.PressButton(VendorSearch.GumpID, VendorSearch.PriceButtons[1].buttonId)
			else
				GumpsParsing.PressButton(VendorSearch.GumpID, VendorSearch.PriceButtons[2].buttonId)
			end

		-- this phase number is the ID of the criteria to load from the array
		elseif VendorSearch.LoadCriteriaPhase > 0 and VendorSearch.LoadCriteriaPhase <= #VendorSearch.SavedCriteria[loadingCriteriaName].allCriteria then

			-- get the current criteria record
			local currentCriteria = VendorSearch.SavedCriteria[loadingCriteriaName].allCriteria[VendorSearch.LoadCriteriaPhase]

			-- get the button ID and textbox ID of the criteria to add
			local buttonId, textboxId = VendorSearch.GetCriteriaButtonIDandText(currentCriteria)

			-- set the gump textbox text (if there is a textbox for the criteria)
			if textboxId then
				TextEditBoxSetText(GumpData.Gumps[VendorSearch.GumpID].TextEntry[textboxId], currentCriteria.criteriaText)
			end

			-- increase the current criteria index
			VendorSearch.LoadCriteriaPhase = VendorSearch.LoadCriteriaPhase + 1

			-- press the add criteria button
			GumpsParsing.PressButton(VendorSearch.GumpID, buttonId)

		else -- loading is done, we end the loading process
			VendorSearch.LoadCriteriaPhase = nil
		end
	end

end

function VendorSearch.DeleteCriteriaSet()

	-- initialize the buttons with the callback
	local OKButton = { textTid=UO_StandardDialog.TID_OKAY, callback=function() VendorSearch.DeleteCriteriaFinal(ComboBoxGetSelectedText(VendorSearch.WindowName .. "SavedCriteriaCombo")) end } -- OK
	local cancelButton = { textTid=UO_StandardDialog.TID_CANCEL } -- Cancel

	-- initialize the confirm dialog
	local DeleteCriteriaSetWindow = 
				{
					windowName = "DeleteCriteria",
					titleTid = 338,
					bodyTid  = 345,
					buttons = { OKButton, cancelButton },
					closeCallback = cancelButton.callback,
					destroyDuplicate = true,
				}

	-- show the confirm dialog
	UO_StandardDialog.CreateDialog(DeleteCriteriaSetWindow)
end

function VendorSearch.DeleteCriteriaFinal(name)

	-- do we have a valid name?
	if not IsValidWString(name) then
		return
	end

	-- delete the criteria set
	VendorSearch.SavedCriteria[name] = nil

	-- show the message to confirm that has been deleted
	VendorSearch.ShowCustomError(GetStringFromTid(346), 1)

	-- select <NEW CRITERIA SET>
	VendorSearch.LastSelectedCriteriaSet = 1

	-- refresh the combo box
	VendorSearch.RefreshCriteriaSetCombo()
end

function VendorSearch.SaveCriteriaSet()

	-- there are no criteria to save!
	if #VendorSearch.CurrentCriteriaTable <= 0 and wstring.len(TextEditBoxGetText(VendorSearch.WindowName .. "ItemNameText")) <= 0 then
		return
	end

	-- new criteria set
	if VendorSearch.LastSelectedCriteriaSet == 1 then

		-- create an input box to get the criteria set name
		local rdata = {title=GetStringFromTid(339), subtitle=GetStringFromTid(341), callfunction=VendorSearch.SaveCriteriaSetFinal, maxChars=20}
		RenameWindow.Create(rdata)

	else -- save changes
		VendorSearch.SaveCriteriaSetFinal(_, ComboBoxGetSelectedText(VendorSearch.WindowName .. "SavedCriteriaCombo"))
	end
end

function VendorSearch.SaveCriteriaSetFinal(id, name)
	
	-- do we have a valid name?
	if not IsValidWString(name) then
		return
	end

	-- clear the name from spaces before and after
	name = wstring.trim(name)

	-- initialize the record to save in the array
	VendorSearch.SavedCriteria[name] = {}

	-- get the item name
	local itemName = TextEditBoxGetText(VendorSearch.WindowName .. "ItemNameText")

	-- do we have an item name?
	if wstring.len(itemName) > 0 then
		VendorSearch.SavedCriteria[name].itemName = itemName
	end

	-- save the sort order
	VendorSearch.SavedCriteria[name].PriceLowToHigh = VendorSearch.PriceLowToHigh

	-- copy the current price range
	VendorSearch.SavedCriteria[name].priceRange = table.copy(VendorSearch.PriceRange)

	-- copy all the other criteria
	VendorSearch.SavedCriteria[name].allCriteria = table.copy(VendorSearch.CurrentCriteriaTable)

	-- set saved message
	if VendorSearch.LastSelectedCriteriaSet == 1 then
		VendorSearch.ShowCustomError(GetStringFromTid(343), 1)

	else -- set changes saved
		VendorSearch.ShowCustomError(GetStringFromTid(344), 1)
	end

	-- show the error label
	WindowSetShowing(VendorSearch.WindowName .. "OtherError", true)

	-- refresh the combo box and select the newly added criteria set
	VendorSearch.RefreshCriteriaSetCombo(name)
end

function VendorSearch.ShowCustomError(error, messageType)

	-- notify (green)
	if messageType == 1 then

		-- set the error color to green
		LabelSetTextColor(VendorSearch.WindowName .. "OtherError", 0, 255, 0)

	-- warning (orange)
	elseif messageType == 2 then

		-- set the error color to orange
		LabelSetTextColor(VendorSearch.WindowName .. "OtherError", 255, 128, 0)

	-- errpr (red)
	elseif messageType == 3 then

		-- set the error color to red
		LabelSetTextColor(VendorSearch.WindowName .. "OtherError", 255, 0, 0)
	end

	-- write the error in the label
	LabelSetText(VendorSearch.WindowName .. "OtherError", error)

	-- set the transparency at 100%
	WindowSetAlpha(VendorSearch.WindowName .. "OtherError", 255)

	-- start blinking the error
	WindowStartAlphaAnimation(VendorSearch.WindowName .. "OtherError", Window.AnimationType.EASE_OUT, 1, 0, 1, false, 20, 0)

	-- set how long the error must be shown
	VendorSearch.CustomError = 20
end

function VendorSearch.RefreshCriteriaSetCombo(justAdded)

	-- initialize the saved criteria array
	if not VendorSearch.SavedCriteria then
		VendorSearch.SavedCriteria = {}
	end

	-- initialize the selected criteria from the list to <NEW CRITERIA>
	if not VendorSearch.LastSelectedCriteriaSet then
		VendorSearch.LastSelectedCriteriaSet = 1
	end

	-- empty the saved criteria list
	ComboBoxClearMenuItems(VendorSearch.WindowName .. "SavedCriteriaCombo")

	-- first element is always <NEW CRITERIA>
	ComboBoxAddMenuItem(VendorSearch.WindowName .. "SavedCriteriaCombo", GetStringFromTid(340))

	-- count the criteria
	local count = 1 

	-- scan all the criteria sets
	for name, _ in pairsByKeys(VendorSearch.SavedCriteria) do

		-- increase the criteria count
		count = count + 1

		-- add the saved criteria to the list
		ComboBoxAddMenuItem(VendorSearch.WindowName .. "SavedCriteriaCombo", name)

		-- is this the criteria just added?
		if justAdded and justAdded == name then
			
			-- set the ID to select for the new criteria set
			VendorSearch.LastSelectedCriteriaSet = count
		end
	end

	-- select the last selected criteria value
	ComboBoxSetSelectedMenuItem(VendorSearch.WindowName .. "SavedCriteriaCombo", VendorSearch.LastSelectedCriteriaSet)
end

function VendorSearch.GetCriteriaButtonIDandText(criteria)

	-- do we have a valid table?
	if not type(criteria) == "table" then
		return
	end
	
	-- get the table for the array string name
	local array = GetDynamicVariableValue(criteria.array)

	-- scan the array for the text
	for _, arrData in pairs(array) do

		-- is this the button we're looking for?
		if arrData.buttonText == criteria.buttonText then
				
			-- return the button ID and textbox ID
			return arrData.buttonId, arrData.textboxId
		end
	end
end

function VendorSearch.RemoveCriteriaTooltip()

	-- remove criteria button tooltip
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(1155388)) -- Remove Criteria
end

function VendorSearch.ToggleSearchTooltip()

	-- toggle search button tooltip
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(337))
end

function VendorSearch.TargetNameTooltip()

	-- create the target name button tooltip
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(238))
end
function VendorSearch.ADDButtonTooltip()

	-- create add criteria button tooltip
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1154534)) -- Add Search Criteria
end

function VendorSearch.LowHighButtonTooltip()

	-- change the text based on the sort type
	if VendorSearch.PriceLowToHigh then
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1154696)) -- Price: Low to High

	else
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1154697)) -- Price: High to Low
	end
end

function VendorSearch.DeleteSavedCriteriaTooltip()

	-- remove saved criteria button tooltip
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(338))
end

function VendorSearch.SaveCriteriaTooltip()

	-- is this a new set?
	if VendorSearch.LastSelectedCriteriaSet == 1 then
	
		-- save criteria button tooltip
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(339))

	else -- existing criteria set

		-- save changes to criteria button tooltip
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(342))
	end
end