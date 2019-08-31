
----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

GumpsParsing = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

GumpsParsing.ParsedGumps = {} -- contains the name of all the identified gumps

GumpsParsing.ToShow = {}

GumpsParsing.SpellSchools = { MAGERY = 25, CHIVALRY = 51 }

GumpsParsing.SOSTids = {1153537, 1153538, 1153539, 1153540, 1153541, 1153542, 1153543, 1153544, 1153545, 1153546, 1153547, 1153548, 1153549, 1153550, 1153584, 1153585, 1153586}

GumpsParsing.GumpMaps = {
--		ID					NAME							SHOW?

	-- QUESTLOG
	[800]  =	 { name = "QuestOffer",						show = true };
	[801]  =	 { name = "QuestResign",					show = true };
	[805]  = 	 { name = "QuestLog",						show = true };
	[806]  =	 { name = "QuestConversation",				show = true };
	[809]  = 	 { name = "QuestDetailsLog",				show = true };
				   
	-- GUILD	   
	[725]  = 	 { name = "GuildMenuCreate",				show = true };
	[726]  = 	 { name = "GuildInvite",					show = true };
	[727]  = 	 { name = "GuildMenuRoster",				show = true };
	[728]  = 	 { name = "GuildMenuPlayerDetails", 		show = true };
	[729]  = 	 { name = "GuildMenuDiplomacy",				show = true };
	[730]  = 	 { name = "GuildMenuRelationship",			show = true };
	[731]  = 	 { name = "GuildMenuWar",					show = true };
	[733]  = 	 { name = "GuildMenuMyGuild",				show = true };
	[734]  = 	 { name = "GuildMenuAdvSearch",				show = true };
				   
	-- HELP		   
	[666]  = 	 { name = "HelpMenu",						show = true };
	[672] = 	 { name = "HelpMenu",						show = true }; -- "GUMP_PAGE_TEXTENTRY"
	[296] = 	 { name = "HelpMenu",						show = true }; -- "GUMP_STUCK_PLAYER"
	[9019] = 	 { name = "HelpMenu",						show = true }; -- "GUMP_TARGET_PETITION_TARGET"
	[9020] = 	 { name = "HelpMenu",						show = true }; -- "GUMP_TYPE_PETITION_TARGET"
	[9021] = 	 { name = "HelpMenu",						show = true }; -- "GUMP_SELECT_PETITION_TARGET"
				   
	[999019]  =	 { name = "SOS",							show = false };
				   
	[999060]  =	 { name = "LoyaltyRating",					show = false };
				   
	[460]  =	 { name = "CraftingMenu",					show = true };
	[685]  =	 { name = "CraftingMenuItemDetail",			show = true };
				   
	[661]  =	 { name = "HouseContainerSecurity",			show = true };
				   
	[668]  =	 { name = "BodBook",						show = true };
				   
	[464]  =	 { name = "HousePlacementMenu",				show = true };
	[452]  =	 { name = "VeteranRewardMain",				show = false };
	[453]  =	 { name = "VeteranRewardCategories",		show = true };
	[9083]  =	 { name = "HTML_Book",						show = false };
	[999074]  =	 { name = "TitlesMenu",						show = true };
	[999071]  =	 { name = "InsuranceMenu",					show = true };
	[9178]  =	 { name = "CityStone",						show = true };
	[17000]  =	 { name = "PointsRewardGump",				show = true };
	[475]  =	 { name = "AnimalLore",						show = true };
	[999139]  =	 { name = "PetTraining",					show = false };
	[999137]  =	 { name = "AnimalTrainingMenu",				show = true };
	[999138]  =	 { name = "AnimalTrainingConfirm",			show = false };
	[600]  =	 { name = "Moongate",						show = true };
	[9008]  =	 { name = "BulletinBoard",					show = true };
	[999059]  =	 { name = "ImbuingMenu",					show = true };
	[455]  =	 { name = "BODOffer",						show = true };
	[456]  =	 { name = "BOD",							show = true };
	[403]  =	 { name = "SixMonthsReward",				show = false };
	[9005]  =	 { name = "FeluccaWarning",					show = true };
				   
	-- VENDOR SE A RCH
	[999112]  =	 { name = "VendorSearch",					show = true };
	[999113]  =	 { name = "VendorSearchResults",			show = true };
	[999115]  =	 { name = "VendorSearchSearching",			show = false };
				   
	-- PLANTS	   
	[29842]	 =	 { name = "Plant",							show = true };		
	[29582]	 =	 { name = "PlantEmptyBowl",					show = true };		
	[22222]	 =	 { name = "PlantReproduction",				show = true };		
				   
	[100001] =	 { name = "TransferCrateWarning",			show = true };
	[999057] =	 { name = "EnchantSpell",					show = true };
	[9014] =	 { name = "IconsGump",						show = true }; -- Used for all choice with icons like animal form, polymorph, heritage token, etc...
	[658]  =	 { name = "SummonFamiliarMenu",				show = true };
	[1123123] =	 { name = "CombatTrainingMenu",				show = true };
				   
	[999013] =	 { name = "CharacterCopyMain",				show = true };
	[200001] =	 { name = "CharacterCopyShardSelect",		show = true };
	[300001] =	 { name = "TransferCheckPacking",			show = true }; --character copy/transfer check packing and final confirm
	[498] =		 { name = "RunicAtlas",						show = true }; 
				   
	-- DYE TUBS	   
	[401]	 =	 { name = "SpecialDye",						show = false };		
	[402]	 =	 { name = "LeatherDye",						show = false };		
	[999079] =	 { name = "MetallicDye",					show = false };		
	[999022] =	 { name = "BottleHairDye",					show = false };
	[999037] =	 { name = "NormalHairDye",					show = false };
	[999038] =	 { name = "BrightHairDye",					show = false };
	[999039] =	 { name = "HairOnlyDye",					show = false };
	[999040] =	 { name = "BeardOnlyDye",					show = false };
	[999041] =	 { name = "BrightHairOnlyDye",				show = false };
	[999042] =	 { name = "BrightBeardOnlyDye",				show = false };	
				   
	[999084] =	 { name = "ReforgeMenu",					show = true };	
				   
	[999143] =	 { name = "JewelryBox",						show = true };	
				   
	[999116] =	 { name = "ViceVSVirtue",					show = true };	
	[9200] =	 { name = "ViceVSVirtueBattleReults",		show = true };	
				   
	[999076] =	 { name = "BoatPlacement",					show = true };	
				   
	[9070] =	 { name = "HonorConfirm",					show = true };	
				   
	[999122] =	 { name = "Masteries",						show = true };	
				   
	[999123] =	 { name = "BankActions",					show = false };	
	[999147] =	 { name = "EJBank",							show = true };	
				   
	[2223] =	 { name = "RessGump",						show = false };	
				   
	[999002] =	 { name = "TCGump",							show = true };	
				   
	[462] =		 { name = "StableClaim",					show = false };	
				   
	[683] =		 { name = "PlayerVendorManage",				show = false };	
	[999014] =	 { name = "PlayerVendorCustomize",			show = false };	
	[9073] =	 { name = "PlayerVendorDismiss",			show = false };	
				   
	[9011] =	 { name = "FriendRequest",					show = false };
				   
	[10014] =	 { name = "VirtuesGump",					show = true };
				   
	[9013] =	 { name = "RedeemGump",						show = false };
				   
	[15010] =	 { name = "SoulstoneGump",					show = false };
				   
	[999090] =	 { name = "MaginciaPetVendor",				show = true };
				   
	[999102] =	 { name = "DaviesLocker",					show = true };
	[12350000] = { name = "Tracking",						show = true };
	[999007] =	 { name = "DryDock",						show = false };
				   
	[9157] =	 { name = "TranscendenceAlacrityBook",		show = true };
}

GumpsParsing.GetBankGold = false

GumpsParsing.VvVGump = ""
GumpsParsing.ShopWindow = ""

GumpsParsing.RunicAtlasLocked = false
GumpsParsing.RunicAtlasID = 0

GumpsParsing.RunicAtlasTidToSpellId = {
	[1077594] = 1, -- recall (charge)
	[1077595] = 2, -- recall (spell)
	[1062723] = 3, -- gate travel
	[1062724] = 4, -- sacred journey
	[1011299] = 5, -- rename book
	[1011300] = 6, -- set default
	[1011298] = 7, -- drop rune
}

GumpsParsing.DaviesLockerData = {}

----------------------------------------------------------------
-- GumpsParsing Functions
----------------------------------------------------------------

function GumpsParsing.CheckGumpType(timePassed)

	-- do we have any gump active?
	if not GumpData then
		return
	end

	-- is the uo store active?
	if DoesWindowExist(GumpsParsing.ShopWindow) and WindowGetShowing(GumpsParsing.ShopWindow) then

		-- while the store is active there can't be any other gump active so we can assume that anything after this will still be the shop
		GenericGump.NextisShop = true

		-- check if the store is still active in 1 second
		GenericGump.shoptime = Interface.TimeSinceLogin + 1

		-- we can stop here since no other gump can be active while the shop is active
		return
	end

	-- main parsing routine
	pcall(GumpsParsing.MainParsingCheck, timePassed)	
	
	-- show/hide gump routine
	pcall(GumpsParsing.ShowHide, timePassed)	
end

function GumpsParsing.MainParsingCheck(timePassed)

	-- scan all the active gumps
	for gumpID, data in pairs(GumpData.Gumps) do

		-- do we have the gump id and the data? (safety check)
		if not gumpID or not data then	
			continue
		end

		-- has the gump already been parsed?
		if GumpsParsing.ParsedGumps[gumpID] ~= nil then
			continue
		end
		
		-- is this the vice vs virtue gump?
		if gumpID == GenericGump.VvV_GUMPID then

			-- update the vvv window name
			GumpsParsing.VvVGump = GenericGump.LastGump
		end
		
		-- store the gumpID
		data.gumpID = gumpID

		-- there is a bug somewhere inside the client that cause this to be null, so we have to fix it here
		pcall(GumpsParsing.FixMainGumpStructure, data)

		-- fix the labels structure (there are several bugs we need to take care, from the window name to the endless repeat of th text table)
		pcall(GumpsParsing.FixLabelsStructure, data)
		
		-- fix the bug with textboxes text color that by default is white on white background (and extremely hard to read)
		pcall(GumpsParsing.FixTextboxStructure, data)
		
		-- add the current gump to the opened gumps list
		GenericGump.GumpsList[data.windowName] = gumpID

		-- is this NOT the vvv gump?
		if data.windowName ~= GumpsParsing.VvVGump then

			-- load the scale/alpha for the gump
			WindowUtils.LoadScale(data.windowName)

			-- do we have a saved position for this gump?
			if WindowUtils.CanRestorePosition("Gump" .. gumpID) then

				-- restore the window position
				WindowUtils.RestoreWindowPosition(data.windowName, false, "Gump" .. gumpID)	

			else -- we don't have a saved position for the gump

				-- clear the gump position
				WindowClearAnchors(data.windowName)

				-- anchor the gump to the center of the game area
				WindowAddAnchor(data.windowName, "center", "ResizeWindow", "center", 0, 0)

				-- remove the anchors without moving the window
				WindowUtils.ClearAnchorsWithoutMoving(windowName)
			end
		end
		
		-- is the gump mapped?
		if GumpsParsing.GumpMaps[gumpID] then
		
			-- get the name of the gump from the gumps map (if there is one)
			local mappedGumpName = GumpsParsing.GumpMaps[gumpID].name

			-- flag the gump as parsed
			GumpsParsing.ParsedGumps[gumpID] = mappedGumpName

			-- change the show/hide flag for the gump based on the value on the gumps map
			GumpsParsing.ToShow[gumpID] = GumpsParsing.GumpMaps[gumpID].show

			-- is this a dye gump? we adapt the name to a generic one
			if string.find(GumpsParsing.ParsedGumps[gumpID], "Dye", 1, true) then
				mappedGumpName = "DyeGump"
			end
			
			-- get the parsing function
			local parsingFunc = GumpsParsing.FindParsingFunction(mappedGumpName)

			-- do we have the parsing function?
			if parsingFunc then
			
				-- execute the parsing function
				parsingFunc(gumpID, data)
			end

		else -- unknown gump

			-- update the parsed gump name
			GumpsParsing.ParsedGumps[gumpID] = "UnknownGump"

			-- flag the gump to be shown
			GumpsParsing.ToShow[gumpID] = true
		end
	end

	-- is the davies locker gump still open?
	if not GumpsParsing.GumpMaps[GenericGump.DAVIES_LOCKER_GUMPID] then
		
		-- reset the data
		GumpsParsing.DaviesLockerData = {}
	end
end

function GumpsParsing.GetLabelData(windowName)

	-- scan all the active gumps
	for gumpID, data in pairs(GumpData.Gumps) do
		
		-- do we have labels?
		if data.Labels then

			-- scan all the labels
			for id, dt in pairs(data.Labels) do

				-- is this the label we're looking for?
				if dt.windowName == windowName then

					-- return the label data, element ID and gump ID
					return dt, id, gumpID
				end
			end

		else
			return
		end
	end
end

function GumpsParsing.DestroyGump(gumpID)
	
	-- do we have any active gump?
	if not GumpData or not GumpData.Gumps[gumpID] then
		return
	end

	-- get the gump data
	local gumpData = GumpData.Gumps[gumpID]

	-- does the gump still exist?
	if gumpData.windowName and DoesWindowExist(gumpData.windowName) then

		-- right click the gump
		GenericGumpOnRClicked(WindowGetId(gumpData.windowName)) 

		-- remove the gump from the parsed gumps tabled
		GumpsParsing.ParsedGumps[gumpID] = nil

		-- remove the gump from the gump visibility table
		GumpsParsing.ToShow[gumpID] = nil

		-- remove the gump from the active gump list
		GenericGump.GumpsList[gumpData.windowName] = nil

	else -- the gump is already gone

		-- remove the gump from the parsed gumps tabled
		GumpsParsing.ParsedGumps[gumpID] = nil

		-- remove the gump from the gump visibility table
		GumpsParsing.ToShow[gumpID] = nil

		-- remove the gump from the active gump list
		GenericGump.GumpsList[gumpData.windowName] = nil
	end
end

function GumpsParsing.PressButton(gumpID, buttonID)

	-- do we have any active gump?
	if not GumpData or not GumpData.Gumps[gumpID] then
		return
	end

	-- get the gump data
	local gumpData = GumpData.Gumps[gumpID]

	-- get the gump ID
	local gumpId = WindowGetId(gumpData.windowName)	

	-- do we have a valid ID and the button actually exist?
	if IsValidID(gumpId) and gumpData.Buttons[buttonID] and DoesWindowExist(gumpData.Buttons[buttonID]) then

		-- press the button
		GenericGumpOnClicked(gumpId, gumpData.Buttons[buttonID])
	end
end

function GumpsParsing.TickButton(gumpID, buttonID)

	-- do we have any active gump?
	if not GumpData or not GumpData.Gumps[gumpID] then
		return
	end

	-- get the gump data
	local gumpData = GumpData.Gumps[gumpID]

	-- get the gump ID
	local gumpId = WindowGetId(gumpData.windowName)	

	-- do we have a valid ID and the checkbox actually exist?
	if IsValidID(gumpId) and gumpData.Buttons[buttonID] and DoesWindowExist(gumpData.Buttons[buttonID]) then

		-- tick the chackbox
		ButtonSetPressedFlag(gumpData.Buttons[buttonID], true)
	end
end

function GumpsParsing.UnTickButton(gumpID, buttonID)
	-- do we have any active gump?
	if not GumpData or not GumpData.Gumps[gumpID] then
		return
	end

	-- get the gump data
	local gumpData = GumpData.Gumps[gumpID]

	-- get the gump ID
	local gumpId = WindowGetId(gumpData.windowName)	

	-- do we have a valid ID and the checkbox actually exist?
	if IsValidID(gumpId) and gumpData.Buttons[buttonID] and DoesWindowExist(gumpData.Buttons[buttonID]) then

		-- untick the chackbox
		ButtonSetPressedFlag(gumpData.Buttons[buttonID], false)
	end
end

function GumpsParsing.TextentryGetText(gumpID, TextentryID)
	
	-- do we have any active gump?
	if not GumpData or not GumpData.Gumps[gumpID] then
		return
	end

	-- get the gump data
	local gumpData = GumpData.Gumps[gumpID]

	-- get the gump ID
	local gumpId = WindowGetId(gumpData.windowName)	

	-- do we have a valid ID and the textbox actually exist?
	if IsValidID(gumpId) and gumpData.TextEntry[TextentryID] and DoesWindowExist(gumpData.TextEntry[TextentryID]) then

		-- get the textbox text
		return TextEditBoxGetText(gumpData.TextEntry[TextentryID])
	end
end

function GumpsParsing.GetLabelWindowByID(gumpID, id)

	-- do we have the labels list?
	if not GenericGump.LastGumpLabels[gumpID] then
		return
	end

	-- scan the loaded labels
	for i, data in pairsByKeys(GenericGump.LastGumpLabels[gumpID]) do

		-- get the label text
		local labelText = LabelGetText(data.windowName)

		-- get the gump label data
		local labelData = GumpData.Gumps[gumpID].Labels[id]

		-- get the text saved from the table
		local tableText = labelData.LabelText

		-- do we have a TID?
		if not tableText and labelData.tid then

			-- do we have TID parameters?
			if labelData.tidParms then

				-- build the string
				tableText = ReplaceTokens(GetStringFromTid(labelData.tid), labelData.tidParms)

			else -- only TID

				-- get the TID text
				tableText = GetStringFromTid(labelData.tid)
			end
		end
		
		-- do we have the same text?
		if labelText == tableText then
		
			-- remove the value from the DB
			GenericGump.LastGumpLabels[gumpID][i] = nil

			return data.windowName

		-- the string could be cutted (if we have one)
		elseif IsValidWString(tableText) and IsValidWString(labelText) then

			-- take the last 3 characters of the string
			local lastThree = wstring.sub(labelText, -3)
			
			-- does the string end with 3 dots?
			if lastThree == L"..."  then

				-- remove the last 3 dots
				labelText = wstring.sub(labelText, 1, -4)
				
				-- remove from the original string the one we got from the label
				local missingPart = wstring.gsub(tableText, labelText, L"")

				-- add the missing part to the label text
				labelText = labelText .. missingPart

				-- do we have the same text now?
				if labelText == tableText then
		
					-- remove the value from the DB
					GenericGump.LastGumpLabels[gumpID][i] = nil

					return data.windowName
				end
			end
		end
	end

	-- do we have unknown gump labels?
	if GenericGump.LastGumpLabels["unknown"] then

		-- scan the unknown loaded labels
		for i, data in pairsByKeys(GenericGump.LastGumpLabels["unknown"]) do

			-- get the label text
			local labelText = LabelGetText(data.windowName)

			-- get the gump label data
			local labelData = GumpData.Gumps[gumpID].Labels[id]

			-- get the text saved from the table
			local tableText = labelData.LabelText

			-- do we have a TID?
			if not tableText and labelData.tid then

				-- do we have TID parameters?
				if labelData.tidParms and #labelData.tidParms > 0 then

					-- build the string
					tableText = ReplaceTokens(GetStringFromTid(labelData.tid), labelData.tidParms)

				else -- only TID

					-- get the TID text
					tableText = WindowUtils.translateMarkup(GetStringFromTid(labelData.tid))
				end
			end

			-- do we have the same text?
			if labelText == tableText then

				-- remove the value from the DB
				GenericGump.LastGumpLabels["unknown"][i] = nil

				return data.windowName
			end
		end
	end
end

function GumpsParsing.GetElementData(windowName)

	-- initialize the first gump ID
	local firstGumpID

	-- scan all the gumps
	for gumpID, data in pairs(GumpData.Gumps) do

		-- store the gump ID
		firstGumpID = gumpID
		
		-- is the element the current gump main window?
		if data.windowName == windowName then
		
			-- we found the gump
			return data.windowName, firstGumpID
		end

		-- does this gump have images?
		if data.Images then
		
			-- scan all the images
			for id, image in pairs(data.Images) do

				-- is this the element we're looking for?
				if image == windowName then
				
					-- we found the gump
					return data.windowName, firstGumpID, id, "image"
				end
			end
		end

		-- does this gump have labels?
		if data.Labels then

			-- san all the labels
			for id, dt in pairs(data.Labels) do

				-- is this the element we're looking for?
				if dt.windowName == windowName then

					-- we found the gump
					return data.windowName, firstGumpID, id, "label"
				end
			end
		end

		-- does this gump have buttons?
		if data.Buttons then

			-- san all the buttons
			for id, button in pairs(data.Buttons) do

				-- is this the element we're looking for?
				if button == windowName then
				
					-- we found the gump
					return data.windowName, firstGumpID, id, "button"
				end
			end
		end

		-- does this gump have text boxes?
		if data.TextEntry then

			-- san all the text boxes
			for id, textEntry in pairs(data.TextEntry) do

				-- is this the element we're looking for?
				if textEntry == windowName then

					-- we found the gump
					return data.windowName, firstGumpID, id, "textentry"
				end
			end
		end
	end

	-- if we're here it means we're in trouble because the element is not registered
	-- in this case we take our chances with get active dialog and hope for the best
	local parent = WindowUtils.GetActiveDialog()

	-- if the parent is Root then we're out of the gump
	if parent and parent ~= "Root" and GumpData.Gumps[WindowGetId(parent)] then
		return parent, WindowGetId(parent)

	else -- at this point we return what we have
		return parent, firstGumpID
	end
end

function GumpsParsing.CloseAllGumps()

	-- do we have open gumps?
	if GumpData then

		-- scan all the active gumps
		for gumpID, data in pairs(GumpData.Gumps) do

			-- close the gump
			GumpsParsing.DestroyGump(gumpID)
		end
	end
end

function GumpsParsing.ShowHide(timePassed)

	-- do we have any gump active?
	if not GumpData or table.countElements(GumpData.Gumps) <= 0 then
		
		-- is the new animal lore window active?
		if Interface.Settings.NewAnimalLore then

			-- destroy the new animal lore window if the animal lore gump has been closed
			if DoesWindowExist("AnimalLore") then
				DestroyWindow("AnimalLore")
			end
		end

		-- does the bank action window is open but the gump is not? remove the window so the player will know that he has to re-open the bankbox
		if DoesWindowExist("ContainerBankMaskTemplate") then
			DestroyWindow("ContainerBankMaskTemplate")
		end

		-- is the moongate window open? close it since the gump is gone
		if DoesWindowExist("Moongate") then
			DestroyWindow("Moongate")
		end

		return
	end

	-- destroy veteran reward dialog if the gump is gone.
	if not GumpData.Gumps[GenericGump.VETERAN_REWARD_GUMPID] and DoesWindowExist("ConfirmVeteranDialog") then
		DestroyWindow("ConfirmVeteranDialog")
	end

	-- destroy moongate window if the gump is gone
	if not GumpData.Gumps[Moongate.GumpId] and DoesWindowExist("Moongate") then
		DestroyWindow("Moongate")
	end
	
	-- is the new animal lore window active?
	if Interface.Settings.NewAnimalLore then
	
		-- destroy animal lore gump if the new window has been closed
		if (not DoesWindowExist("AnimalLore") and AnimalLore.HoldOn == nil) and GumpData.Gumps[AnimalLore.gumpID] then
			GumpsParsing.DestroyGump(AnimalLore.gumpID)

		-- destroy the new animal lore window if the animal lore gump has been closed
		elseif DoesWindowExist("AnimalLore") and GumpData.Gumps[AnimalLore.gumpID] == nil then
			DestroyWindow("AnimalLore")
		end
	end

	-- is the container search set on a gump, but the gump is gone?
	if IsValidID(ContainerSearch.Gump) and WindowGetShowing("ContainerSearchWindow") and not GumpData.Gumps[ContainerSearch.Gump] then
		
		-- toggle the container search window
		ContainerSearch.Toggle()
	end

	-- bank window name
	local playerBank = "ContainerWindow_" .. ContainerWindow.PlayerBank

	-- destroy bank actions window if the gump has been closed
	if DoesWindowExist("ContainerBankMaskTemplate") and not GumpData.Gumps[GenericGump.EJ_BANK_GUMPID] and not DoesWindowExist(playerBank)  then
		DestroyWindow("ContainerBankMaskTemplate")

		-- close the bank actions gump
		GumpsParsing.DestroyGump(GenericGump.BANK_ACTIONS_GUMPID)
	end

	-- does the bank action window is closed but the gump is active? re-create the window again
	if not DoesWindowExist("ContainerBankMaskTemplate") and GumpData.Gumps[GenericGump.BANK_ACTIONS_GUMPID] then
		GumpsParsing.BankActions(GenericGump.BANK_ACTIONS_GUMPID, GumpData.Gumps[GenericGump.BANK_ACTIONS_GUMPID])
	end

	-- does the bank action window is open but the gump is not? remove the window so the player will know that he has to re-open the bankbox
	if DoesWindowExist("ContainerBankMaskTemplate") and not GumpData.Gumps[GenericGump.BANK_ACTIONS_GUMPID] then
		DestroyWindow("ContainerBankMaskTemplate")
	end
	
	-- scan all the gump
	for gumpID, data in pairs(GumpData.Gumps) do

		-- does the gump still exist?
		if data.windowName and DoesWindowExist(data.windowName) then

			-- do we have a show/hide flag for this gump?
			if  GumpsParsing.ToShow[gumpID] ~= nil then

				-- is the visible status different from the one it's supposed to have?
				if WindowGetShowing(data.windowName) ~= GumpsParsing.ToShow[gumpID] then
				
					-- set the gump visibility as set with the show/hide flag
					WindowSetShowing(data.windowName, GumpsParsing.ToShow[gumpID])
				end

			 -- by default we set the gump visible if the visibility flag is not set
			elseif not WindowGetShowing(data.windowName) then
				WindowSetShowing(data.windowName, true)
			end
		
		-- do we have the gump window name, but the gump is gone?
		elseif data.windowName and not DoesWindowExist(data.windowName) then

			-- remove the gump data from the table
			GumpData.Gumps[gumpID] = nil

			continue
		end
	end
end

function GumpsParsing.PetTrainingConfirm(tid) -- pet training confirm

	-- create the buttons data
	local OKButton = { textTid = UO_StandardDialog.TID_OKAY, callback = function() GumpsParsing.PressButton(999138, 1) end } -- OK
	local cancelButton = { textTid = UO_StandardDialog.TID_CANCEL, callback = function() GumpsParsing.PressButton(999138, 2) end } -- Cancel

	-- create the dialog data
	local PetTrainingConfirmWindow = 
				{
					windowName = "PetTrainingConfirm",
					bodyTid = tid,
					titleTid = 1157502, -- Pet Training Confirmation
					buttons = { OKButton, cancelButton },
					closeCallback = cancelButton.callback,
					destroyDuplicate = true,
				}

	-- create the confirm dialog
	UO_StandardDialog.CreateDialog(PetTrainingConfirmWindow)
end

function GumpsParsing.RedeemItemConfirm(tid) -- redeem item confirmation

	-- create the buttons data
	local OKButton = { textTid = UO_StandardDialog.TID_OKAY, callback = function() GumpsParsing.PressButton(9013, 1) end } -- OK
	local cancelButton = { textTid = UO_StandardDialog.TID_CANCEL, callback = function() GumpsParsing.PressButton(9013, 2) end } -- Cancel

	-- create the dialog data
	local RedeemItemWindow = 
				{
					windowName = "RedeemItemDialog",
					body = GetStringFromTid(1070972) .. L"\n\n" .. WindowUtils.translateMarkup(GetStringFromTid(tid)), -- Click "OKAY" to redeem the following: <ITEMNAME>
					titleTid = 1154682, -- Promotional Token
					buttons = { OKButton, cancelButton },
					closeCallback = cancelButton.callback,
					destroyDuplicate = true,
					addBottomMargin = true
				}

	-- create the vendor dismiss confirm dialog
	UO_StandardDialog.CreateDialog(RedeemItemWindow)
end

function GumpsParsing.TCGumpDialog() -- TC Gump confirm

	-- create the button data
	local OKButton = { textTid = UO_StandardDialog.TID_OKAY, callback = function() GumpsParsing.DestroyGump(999002) end } -- OK

	-- create the dialog data
	local TConfirmWindow = 
				{
					windowName = "ConfirmTC",
					bodyTid = 295,
					buttons = { OKButton },
					closeCallback = OKButton.callback,
					destroyDuplicate = true,
					addBottomMargin = true
				}

	-- create the ress confirm dialog
	UO_StandardDialog.CreateDialog(TConfirmWindow)
end

function GumpsParsing.DismissVendorConfirm(tid) -- dismiss vendor confirm

	-- create the buttons data
	local OKButton = { textTid = UO_StandardDialog.TID_OKAY, callback = function() GumpsParsing.PressButton(9073, 1) end } -- OK
	local cancelButton = { textTid = UO_StandardDialog.TID_CANCEL, callback = function() GumpsParsing.PressButton(9073, 2) end } -- Cancel

	-- create the dialog data
	local DismissVendorWindow = 
				{
					windowName = "DismissVendor",
					bodyTid = tid, -- Do you really wish to dismiss this vendor?
					titleTid = 1071987, -- Dismiss Vendor
					buttons = { OKButton, cancelButton },
					closeCallback = cancelButton.callback,
					destroyDuplicate = true,
					addBottomMargin = true
				}

	-- create the vendor dismiss confirm dialog
	UO_StandardDialog.CreateDialog(DismissVendorWindow)
end

function GumpsParsing.RessConfirm(tid) -- resurrection confirm

	-- create the buttons data
	local OKButton = { textTid = UO_StandardDialog.TID_CONTINUE, callback = function() GumpsParsing.PressButton(2223, 1) end } -- Continue
	local cancelButton = { textTid = UO_StandardDialog.TID_CANCEL, callback = function() GumpsParsing.PressButton(2223, 2) end } -- Cancel

	-- create the dialog data
	local RessConfirmWindow = 
				{
					windowName = "ConfirmRess",
					bodyTid = tid,
					title = WindowUtils.translateMarkup(GetStringFromTid(1011022)),
					buttons = { OKButton, cancelButton },
					closeCallback = cancelButton.callback,
					destroyDuplicate = true,
					addBottomMargin = true
				}

	-- create the ress confirm dialog
	UO_StandardDialog.CreateDialog(RessConfirmWindow)
end

function GumpsParsing.DryDockConfirm(tid) -- dry dock confirm

	-- create the buttons data
	local OKButton = { textTid = UO_StandardDialog.TID_OKAY, callback = function() GumpsParsing.PressButton(999007, 1) end } -- OK
	local cancelButton = { textTid = UO_StandardDialog.TID_CANCEL, callback = function() GumpsParsing.PressButton(999007, 2) end } -- Cancel

	-- create the dialog data
	local DryDockConfirmWindow = 
				{
					windowName = "DryDock",
					bodyTid = tid,
					title = WindowUtils.translateMarkup(GetStringFromTid(1116520)), -- Dry Dock Ship
					buttons = { OKButton, cancelButton },
					closeCallback = cancelButton.callback,
					destroyDuplicate = true,
					addBottomMargin = true
				}

	-- create the drydock confirm dialog
	UO_StandardDialog.CreateDialog(DryDockConfirmWindow)
end

function GumpsParsing.FriendRequestConfirm(playerName)

	-- create the buttons data
	local OKButton = { textTid = UO_StandardDialog.TID_OKAY, callback = function() GumpsParsing.PressButton(9011, 1) end } -- Continue
	local cancelButton = { textTid = UO_StandardDialog.TID_CANCEL, callback = function() GumpsParsing.PressButton(9011, 2) end } -- Cancel
	
	-- create the dialog data
	local FriendRequestConfirmWindow = 
				{
					windowName = "FriendRequest",
					body = ReplaceTokens(GetStringFromTid(1158394), { towstring(playerName)} ), -- ~1_name~ would like to add you as a friend. By doing so you will be able to communicate with them privately across Shards. Do you accept?
					title = WindowUtils.translateMarkup(GetStringFromTid(1158393)), -- Global Chat Friend Request
					buttons = { OKButton, cancelButton },
					closeCallback = cancelButton.callback,
					destroyDuplicate = true,
					addBottomMargin = true
				}
	
	-- create the ress confirm dialog
	UO_StandardDialog.CreateDialog(FriendRequestConfirmWindow)
end

function GumpsParsing.VeteranRewardNotify() -- veteran reward confirm

	-- create the buttons data
	local OKButton = { textTid=UO_StandardDialog.TID_OKAY, callback=function() GumpsParsing.PressButton(452, 1) end } -- OK
	local cancelButton = { textTid=UO_StandardDialog.TID_CANCEL, callback=function() GumpsParsing.PressButton(452, 2) end } -- Cancel

	-- create the dialog data
	local DestroyConfirmWindow = 
				{
					windowName = "ConfirmVeteran",
					bodyTid = 1006046, -- You have reward items available.  Click 'ok' below to get the selection menu or 'cancel' to be prompted upon your next login.
					titleTid = 226,
					buttons = { OKButton, cancelButton },
					closeCallback = cancelButton.callback,
					destroyDuplicate = true,
					addBottomMargin = true 
				}

	-- create the veteran reward confirm dialog
	UO_StandardDialog.CreateDialog(DestroyConfirmWindow)

	-- create the party image to decorate the dialog
	CreateWindowFromTemplate("ConfirmVeteranDialog" .. "PartyImage", "AnniversaryPartyImage", "ConfirmVeteranDialog")

	-- clear the party image location
	WindowClearAnchors("ConfirmVeteranDialog" .. "PartyImage")

	-- anchor the party image on the top-left of the dialog
	WindowAddAnchor("ConfirmVeteranDialog" .. "PartyImage", "topleft", "ConfirmVeteranDialog", "topleft", -100, -130)
	
	-- get the player mobile data
	local mobileData = Interface.GetMobileData(GetPlayerID())
	
	-- default sound ID
	local sid = 1097

	-- is the player female?
	if mobileData.Gender == 1 then

		-- female sound
		sid = 823
	end

	-- play the sound
	PlaySound(1, sid, WindowData.PlayerLocation.x, WindowData.PlayerLocation.y, WindowData.PlayerLocation.z)
end

function GumpsParsing.CitizenshipConfirmGump(param) -- confirm citizenship

	-- create the buttons data
	local OKButton = { textTid=UO_StandardDialog.TID_OKAY, callback=function() GumpsParsing.PressButton(999060, 2) end } -- Declare Citizenship
	local cancelButton = { textTid=1152889, callback=function() GumpsParsing.PressButton(999060, 3) end } -- Cancel
	
	-- initialize the message body text
	local body = WindowUtils.translateMarkup(ReplaceTokens(GetStringFromTid(1152891), {GetStringFromTid(param)})) -- If you choose to declare citizenship with ~1_CITY~,

	-- create the dialog data
	local DestroyConfirmWindow = 
				{
					windowName = "ConfirmCitizenship",
					body = body,
					title = GetStringFromTid(param),
					buttons = { OKButton, cancelButton },
					closeCallback = cancelButton.callback,
					destroyDuplicate = true,
					addBottomMargin = true 
				}

	-- create the veteran reward confirm dialog
	UO_StandardDialog.CreateDialog(DestroyConfirmWindow)

	-- reset the city loyalty variable
	CharacterSheet.TakeCityLoyalty = nil
end

function GumpsParsing.CitizenshipRenounceGump(param) -- renounce citizenship

	-- create the buttons data
	local OKButton = { textTid=UO_StandardDialog.TID_OKAY, callback=function() GumpsParsing.PressButton(999060, 2) end } -- Renounce Citizenship
	local cancelButton = { textTid=1152889, callback=function() GumpsParsing.PressButton(999060, 3) end } -- Cancel

	-- initialize the message body text
	local body = WindowUtils.translateMarkup(ReplaceTokens(GetStringFromTid(1152887), {GetStringFromTid(param)})) -- If you renounce your citizenship,
	
	-- create the dialog data
	local DestroyConfirmWindow = 
				{
					windowName = "CitizenshipRenounce",
					body = body,
					title = GetStringFromTid(param),
					buttons = { OKButton, cancelButton },
					closeCallback = cancelButton.callback,
					destroyDuplicate = true,
					addBottomMargin = true 
				}
	
	-- create the veteran reward confirm dialog
	UO_StandardDialog.CreateDialog(DestroyConfirmWindow)

	-- reset the city loyalty variable
	CharacterSheet.TakeCityLoyalty = nil
end

function GumpsParsing.SixMonthsRewardGump() -- 6 months reward message Management

	-- create the buttons data
	local OKButton = { textTid = UO_StandardDialog.TID_OKAY, callback=function() GumpsParsing.PressButton(403, 1) end }
	local cancelButton = { textTid = UO_StandardDialog.TID_CANCEL_LC, callback=function() GumpsParsing.PressButton(403, 2) end }

	-- initialize the message body text
	local body = WindowUtils.translateMarkup(GetStringFromTid(1076664)) -- <B>Ultima Online Rewards Program</B> Thank you for being part of the Ultima Online community for over 6 months. As a token of our appreciation, your stat cap will be increased. 
	
	-- create the dialog data
	local DestroyConfirmWindow = 
				{
					windowName = "6MonthsReward",
					body = body,
					buttons = { OKButton, cancelButton },
					closeCallback = cancelButton.callback,
					destroyDuplicate = true,
					forceHeight = 230
				}
	
	-- create the 6 months reward confirm dialog
	UO_StandardDialog.CreateDialog(DestroyConfirmWindow)
end

function GumpsParsing.CreateSOSWaypoint(sosID, map, x, y)

	-- add the the waypoint to the sos waypoints table
	Interface.SOSWaypoints[sosID] = { facet = map, x = x, y = y, z = 0, type = MapCommon.WaypointCustomType, name = L"Sunken Ship", Icon = 100116, Scale = 0.69 }

	-- update the map
	MapCommon.UpdateWaypoints()
end

function GumpsParsing.RunicAtlasGetButtonID(spell)
	-- SPELLS:
	-- 1: recall (charge)
	-- 2: recall (spell)
	-- 3: gate travel
	-- 4: sacred journey
	-- 5: rename book
	-- 6: set default
	-- 7: drop rune

	-- BUTTONS IDS:
	-- 1, 2 page turner (all -1 if there is only 1 page turner)
	-- 3...18 runes
	-- 19 rename book
	-- 20 recall (spell)
	-- 21 recall (charge), if there are no charges the following are -1
	-- 22 gate travel, the following are -1 if you can't cast gate travel
	-- 23 sacred journey, the following are -1 if you can't cast sacred journey
	-- 24 set default
	-- 25 drop rune
	
	-- is the runic atlas open?
	if GumpData.Gumps[GenericGump.RUNIC_ATLAS_GUMPID] then
		
		-- initialize the ID variables
		local pageturner = 0
		local recallChargeVisible = 0
		local gateVisible = 0
		local sacredVisible = 0

		-- if recall is hidden by default we have 1 less button so we do a -1 to the ID
		if GumpsParsing.RunicAtlasIsRecallChargeVisible() == false then -- Recall (Charge) visible?
			recallChargeVisible = -1
		end

		-- if gate travel is hidden by default we have 1 less button so we do a -1 to the ID
		if GumpsParsing.RunicAtlasIsGateSpellVisible() == false then -- Gate Travel visible?
			gateVisible = -1
		end

		-- if sacred journey is hidden by default we have 1 less button so we do a -1 to the ID
		if GumpsParsing.RunicAtlasIsSacredJourneyVisible() == false then -- Saced Journey visible?
			sacredVisible = -1
		end
		
		-- if we have only 1 page turner we have 1 less button so we do a -1 to the ID
		if GumpsParsing.RunicAtlasGetPageTurnerNumber() == 1 then -- only 1 page turner
			pageturner = -1
		end

		-- rename book button ID
		if spell == 5 then
			return 19 + pageturner

		-- rescall (spell) button ID
		elseif spell == 2 then
			return 20 + pageturner

		-- recall (charge) button ID
		elseif spell == 1 then
			return 21 + pageturner

		-- gate travel button ID
		elseif spell == 3 then
			return 22 + pageturner + recallChargeVisible

		-- sacred journey button ID
		elseif spell == 4 then
			return 23 + pageturner + recallChargeVisible + gateVisible

		-- set default button ID
		elseif spell == 6 then
			return 24 + pageturner + recallChargeVisible + gateVisible + sacredVisible

		-- drop rune button ID
		elseif spell == 7 then
			return 25 + pageturner + recallChargeVisible + gateVisible + sacredVisible
		end
	end
end

function GumpsParsing.RunicAtlasGetPageTurnerNumber()

	-- is the runic atlas open?
	if GumpData.Gumps[GenericGump.RUNIC_ATLAS_GUMPID] then

		-- get the number of buttons on the page
		local numButtons = #GumpData.Gumps[GenericGump.RUNIC_ATLAS_GUMPID].Buttons

		-- number of buttons if all spells are available with 2 page turners: 2 page turners + 16 runes + 4 spells + 3 (rename, drop and set default)
		local onePageTurnerID = 25 

		-- Recall (Charge) visible? if not the buttons count gets a -1
		if GumpsParsing.RunicAtlasIsRecallChargeVisible() == false then
			onePageTurnerID = onePageTurnerID -1
		end

		-- Gate Travel visible? if not the buttons count gets a -1
		if GumpsParsing.RunicAtlasIsGateSpellVisible() == false then 
			onePageTurnerID = onePageTurnerID -1
		end

		-- Sacred Journey visible? if not the buttons count gets a -1
		if GumpsParsing.RunicAtlasIsSacredJourneyVisible() == false then 
			onePageTurnerID = onePageTurnerID -1
		end
		
		-- removed the spells not present if the number of buttons is = onePageTurnerID then we have 2 page turners, otherwise 1
		if numButtons == onePageTurnerID then 
			return 2

		else
			return 1
		end
	end
end

function GumpsParsing.RunicAtlasIsRecallChargeVisible()
	
	-- get the gump data for the runic atlas
	local gumpData = GumpData.Gumps[GenericGump.RUNIC_ATLAS_GUMPID]

	-- is the gump open?
	if gumpData then

		-- is the recall (charge) label visible?
		if gumpData.Labels[21] and gumpData.Labels[21].tid == 1077594 then -- Recall (Charge)
			return true
		end
	end

	return false
end

function GumpsParsing.RunicAtlasIsGateSpellVisible()
	
	-- get the gump data for the runic atlas
	local gumpData = GumpData.Gumps[GenericGump.RUNIC_ATLAS_GUMPID]

	-- is the gump open?
	if gumpData then

		-- initialize the recall charge ID variation
		local recallChargeVisible = 0

		-- is the recall (charge) visible? if not we have to do a -1 to the ID
		if GumpsParsing.RunicAtlasIsRecallChargeVisible() == false then
			recallChargeVisible = -1
		end

		-- is the gate travel label visible?
		if gumpData.Labels[22 + recallChargeVisible] and gumpData.Labels[22 + recallChargeVisible].tid == 1062723 then -- gate travel
			return true
		end
	end

	return false
end

function GumpsParsing.RunicAtlasIsSacredJourneyVisible()
	
	-- get the gump data for the runic atlas
	local gumpData = GumpData.Gumps[GenericGump.RUNIC_ATLAS_GUMPID]

	-- is the gump open?
	if gumpData then

		-- initialize the recall charge + recall spell ID variation
		local recallChargeVisible = 0

		-- is the recall (charge) visible? if not we have to do a -1 to the ID
		if GumpsParsing.RunicAtlasIsRecallChargeVisible() == false then
			recallChargeVisible = -1
		end

		-- is the recall (spell) visible? if not we have to do a -1 to the ID
		if GumpsParsing.RunicAtlasIsGateSpellVisible() == false then -- Gate Travel visible?
			recallChargeVisible = recallChargeVisible - 1
		end

		-- is the sacred journey label visible?
		if gumpData.Labels[23 + recallChargeVisible] and gumpData.Labels[23 + recallChargeVisible].tid == 1062724 then -- Sacred Journey
			return true
		end
	end

	return false
end

function GumpsParsing.IsHunterAtlas()

	-- is a hunter atlas if the label 7 has "New Haven Mine" as text
	return	GumpData.Gumps[GenericGump.RUNIC_ATLAS_GUMPID] and 
			GumpData.Gumps[GenericGump.RUNIC_ATLAS_GUMPID].Labels[7] and 
			GumpData.Gumps[GenericGump.RUNIC_ATLAS_GUMPID].Labels[7].tidParms and 
			GumpData.Gumps[GenericGump.RUNIC_ATLAS_GUMPID].Labels[7].tidParms[1] == L"#1153647" -- New Haven Mine
end

function GumpsParsing.RunicAtlasHideSpellButton(labelData, gumpData)

	-- does the label still exist?
	if DoesWindowExist(labelData.windowName) then

		-- hide the label
		WindowSetShowing(labelData.windowName, false)

		-- get the button order ID
		local spell = GumpsParsing.RunicAtlasTidToSpellId[labelData.tid]

		-- get the button ID from the gump
		local buttonId = GumpsParsing.RunicAtlasGetButtonID(spell)

		-- hide the button
		WindowSetShowing(gumpData.Buttons[buttonId], false)
	end
end

----------------------------------------------------------------
-- GumpsParsing Utilities
----------------------------------------------------------------

function GumpsParsing.GetSOSCoords(coords)
	
	-- get the comma position
	local commaPos = wstring.find(coords, L",", 1, true)
	
	-- get the first coordinate 
	local first = wstring.sub(coords, 1, commaPos - 1)

	-- replace � with .
	first = wstring.gsub(first, L"o ", L".")

	-- remove '
	first = wstring.gsub(first, L"'", L"")

	-- remove spaces
	first = wstring.gsub(first, L" ", L"")

	-- calculate the latitude N/S
	local latDir = wstring.sub(first, -1)

	-- get the numeric value for the latitude
	local latVal = wstring.sub(first, 1, -2)

	-- get the second coordinate
	local second = wstring.sub(coords, commaPos + 3, -1)

	-- replace � with .
	second = wstring.gsub(second, L"o ", L".")

	-- remove '
	second = wstring.gsub(second, L"'", L"")

	-- remove spaces
	second = wstring.gsub(second, L" ", L"")
	
	-- get the longitude E/W
	local longDir = wstring.sub(second, -1)
	
	-- get the numeric value for the longitude
	local longVal = wstring.sub(second, 1, -2)

	-- print the coordinates if we're in debug mode
	if Interface.DebugMode then
		Debug.Print(latVal .. L"+" .. latDir .. L" - " .. longVal .. L"+" .. longDir )
	end

	-- return the coordinates
	return tonumber(latVal), latDir, tonumber(longVal), longDir
end

function GumpsParsing.GetDaviesCoords(coords)
	
	-- get the space position
	local spacePos = wstring.find(coords, L" ", 1, true)
	
	-- get the first coordinate 
	local first = wstring.sub(coords, 1, spacePos - 1)

	-- calculate the latitude N/S
	local latDir = wstring.sub(first, -1)

	-- get the numeric value for the latitude
	local latVal = wstring.sub(first, 1, -2)

	-- get the second coordinate
	local second = wstring.sub(coords, spacePos + 1, -1)
	
	-- get the longitude E/W
	local longDir = wstring.sub(second, -1)
	
	-- get the numeric value for the longitude
	local longVal = wstring.sub(second, 1, -2)

	-- print the coordinates if we're in debug mode
	if Interface.DebugMode then
		Debug.Print(latVal .. L"+" .. latDir .. L" - " .. longVal .. L"+" .. longDir )
	end

	-- return the coordinates
	return tonumber(latVal), latDir, tonumber(longVal), longDir
end

function GumpsParsing.FixMainGumpStructure(data)

	-- do we have the labels table?
	if not data or not data.Labels then
		return
	end

	-- do we have the main gump window name?
	if not data.windowName then

		-- set the main gump window name
		data.windowName = GenericGump.LastGump

		-- reset the last gump window name
		GenericGump.LastGump = ""
	end
end

function GumpsParsing.FixLabelsStructure(data)

	-- do we have the labels table?
	if not data or not data.Labels then
		return
	end

	-- texts array
	local texts
	
	-- scan all the labels
	for id, dt in pairs(data.Labels) do
				
		-- is there a text array? (this array is repeated over and over again, so we need to fix it)
		if dt.text then

			-- create the LabelsText array (we can do it just once since every other instance is just a copy of the same array)
			if not texts then
				texts = table.copy(dt.text)
			end

			-- clear the text array
			dt.text = nil
		end
	end

	-- text index
	local idx = 1

	-- scan all the labels
	for id, dt in pairs(data.Labels) do

		-- is there a tid for the text?
		if not dt.tid then

			-- set the label text
			dt.LabelText =  WindowUtils.translateMarkup(texts[idx])

			-- increase the text count
			idx = idx + 1
		end

		-- get the label window name
		local label = GumpsParsing.GetLabelWindowByID(data.gumpID, id)

		-- do we have the label window name?
		if label then
			
			-- store the label window name
			dt.windowName = label
		end
	end

	-- store the label texts in a separate array
	data.LabelsText = table.copy(texts)

	-- reset the labels window names array (since we've stored all the data, we don't need it anymore)
	GenericGump.LastGumpLabels[data.gumpID] = nil
end

function GumpsParsing.FixTextboxStructure(data)

	-- do we have the textbox table?
	if not data or not data.TextEntry then
		return
	end

	-- san all the text boxes
	for id, textEntry in pairs(data.TextEntry) do

		-- set the textbox text color black by default
		TextEditBoxSetTextColor(textEntry, 0, 0, 0)
	end
end

function GumpsParsing.DoesGumpLabelsHasTID(gumpID, tid)

	-- get the gump data
	local data = GumpData.Gumps[gumpID]

	-- do we have the gump data and the gump has labels?
	if not data or not data.Labels then
		return false
	end

	-- scan all the gump labels
	for id, dt in pairs(data.Labels) do

		-- is this the tid we need?
		if dt.tid == tid then

			-- found it!
			return true
		end
	end

	return false
end

function GumpsParsing.FindParsingFunction(funcName)

	-- do we have a valid string?
	if not IsValidString(funcName) then
		return
	end

	-- scan all the class variables in search fo the function with the specified name
	for var, data in pairs(GumpsParsing) do

		-- is this a function and it's the one we're looking for?
		if type(data) == "function" and var == funcName then
			return data
		end
	end
end

function GumpsParsing.HonorConfirm(gumpID, data)
	
	-- this gump is used for honor confirm, but also other messages so we need to make sure
	-- search for the honor confirm message
	if GumpsParsing.DoesGumpLabelsHasTID(gumpID, 1071218) then -- Are you sure you want to use honor points on yourself?

		-- is this the honor confirm gump and the auto-accept honor is active?
		if Interface.Settings.AutoAcceptHonor then

			-- press OK
			GumpsParsing.PressButton(gumpID, 1)
		end

	else -- if we haven't found the honor confirm message, this is an unknown gump

		-- change the parsed gump name to unknown
		GumpsParsing.ParsedGumps[gumpID] = "UnknownGump"

		-- flag the gump to be shown
		GumpsParsing.ToShow[gumpID] = true
	end
end

function GumpsParsing.PointsRewardGump(gumpID, data)

	-- is this cleanup britannia?
	if GumpsParsing.DoesGumpLabelsHasTID(gumpID, 1151316) then -- Clean Up Britannia

		-- update the parsed gump name
		GumpsParsing.ParsedGumps[gumpID] = "CleanupBritannia"

		-- hide the gump
		GumpsParsing.ToShow[gumpID] = false

		-- show the cleanup britannia window
		WindowSetShowing("CleanupBritanniaWindow", true)

	-- is this the vvv rewards gump?
	elseif GumpsParsing.DoesGumpLabelsHasTID(gumpID, 1155512) then -- VvV Rewards

		-- update the parsed gump name
		GumpsParsing.ParsedGumps[gumpID] = "VvVRewards"

		-- show the gump
		GumpsParsing.ToShow[gumpID] = true
	end
end

function GumpsParsing.Plant(gumpID, data)

	-- is the get resources/seed action active?
	if Actions.GetResources or Actions.GetSeeds then

		-- press the button to enter the menu for gathering resources/seeds
		GumpsParsing.PressButton(GenericGump.PLANT_GUMPID, 1)
	end
end

function GumpsParsing.PlantReproduction(gumpID, data)

	-- initialize the seeds and resources count
	local seeds
	local resources
				
	-- do we have the text labels?
	if data.LabelsText then

		-- get the seeds amount
		seeds = data.LabelsText[2]

		-- get the resources cont
		resources = data.LabelsText[3]
	end

	-- is the gather resources action active?
	if Actions.GetResources then

		-- if there is an X there are no more resources to gather
		if resources == L"X" then

			-- stop the gather resources action
			Actions.GetResources = nil

		else -- there are more resources to get

			-- get the amount of resources remaining
			local curr = wstring.sub(resources, 1, wstring.find(resources, L"/", 1, true) - 1)

			-- convert the string to number
			curr = tonumber(tostring(curr))

			-- do we still have resources to get?
			if curr > 0 then

				-- gather resources
				GumpsParsing.PressButton(GenericGump.PLANT_REPRODUCTION_GUMPID, 6)

			else -- we got it all, return to the main gump
				GumpsParsing.PressButton(GenericGump.PLANT_REPRODUCTION_GUMPID, 1)

				-- stop the gather resources action
				Actions.GetResources = nil
			end
		end
	end
				
	-- is the gather seeds action active?
	if Actions.GetSeeds then

		-- if there is an X there are no more seeds to gather
		if seeds == L"X" then

			-- stop the gather seeds action
			Actions.GetSeeds = nil

		else -- there are more seeds to get

			-- get the amount of seeds remaining
			local curr = wstring.sub(seeds, 1, wstring.find(seeds, L"/", 1, true) - 1)

			-- convert the string to number
			curr = tonumber(tostring(curr))

			-- do we still have seeds to get?
			if curr > 0 then

				-- gather seeds
				GumpsParsing.PressButton(GenericGump.PLANT_REPRODUCTION_GUMPID, 7)
						
			else -- we got it all, return to the main gump
				GumpsParsing.PressButton(GenericGump.PLANT_REPRODUCTION_GUMPID, 1)

				-- stop the gather seeds action
				Actions.GetSeeds = nil
			end
		end
	end
end

function GumpsParsing.FeluccaWarning(gumpID, data)
	
	-- flag the gump visibility based on the the user choice if the felucca warnings are disabled
	GumpsParsing.ToShow[gumpID] = not Interface.Settings.DisableFelWarning

	-- are the felucca warning disabled?
	if Interface.Settings.DisableFelWarning == true then

		-- is this a moongate warning?
		if data.Labels[2] and data.Labels[2].tid == 1062049 then -- Dost thou wish to step into the moongate? Continue to enter the gate, Cancel to stay here
					
			-- press the OK button
			GumpsParsing.PressButton(gumpID, 1) -- OK

		-- is this a gate travel warning?
		elseif GumpData.Gumps[gumpID].Labels[2] and (GumpData.Gumps[gumpID].Labels[2].tid == 1062050) then -- This Gate goes to Felucca... Continue to enter the gate, Cancel to stay here
					
			-- press the OK button
			GumpsParsing.PressButton(gumpID, 1) -- OK
		end
	end
end

function GumpsParsing.VeteranRewardMain(gumpID, data)

	-- is the auto-close veteran reward active?
	if not Interface.Settings.AutoCloseVetRew then

		-- create a confirm dialog for the veteran reward
		GumpsParsing.VeteranRewardNotify()
	end
end

function GumpsParsing.ViceVSVirtue(gumpID, data)

	-- update the vvv window name
	GumpsParsing.VvVGump = data.windowName
end

function GumpsParsing.ViceVSVirtueBattleReults(gumpID, data)

	-- reset the VvV window name
	GumpsParsing.VvVGump = ""
end

function GumpsParsing.LoyaltyRating(gumpID, data)

	-- hide the gump
	GumpsParsing.ToShow[gumpID] = false

	-- is this the city loyalty confirm gump?
	if data.Labels[3].tid == 1152891 then -- If you choose to declare citizenship with ~1_CITY~, ...

		-- update the parsed gump name
		GumpsParsing.ParsedGumps[gumpID] = "CityLoyaltyConfirm"

		-- get the tid parameter
		local param = data.Labels[3].tidParms[1]
		
		-- remove the # from the text
		param = wstring.gsub(param, L"#", L"")
		
		-- create the confirm gump
		GumpsParsing.CitizenshipConfirmGump(tonumber(param))
					
	-- is this the renounce citizenship gump?
	elseif data.Labels[5].tid == 1152887  then -- If you renounce your citizenship,

		-- update the parsed gump name
		GumpsParsing.ParsedGumps[gumpID] = "CityLoyaltyRenounceConfirm"

		-- get the tid parameter
		local param = data.Labels[5].tidParms[1]

		-- remove the # from the text
		param = wstring.gsub(param, L"#", L"")

		-- create the renounce gump
		GumpsParsing.CitizenshipRenounceGump(tonumber(param))

	-- is this the title selection window?
	elseif data.Labels[3].tid == 1152901 or data.Labels[3].tid == 1152894 then -- Obtain Title   Your Titles:

		-- update the parsed gump name
		GumpsParsing.ParsedGumps[gumpID] = "PickCityTitle"
					
		-- flag the gump to be shown
		GumpsParsing.ToShow[gumpID] = true

		-- show the gump
		WindowSetShowing(data.Labels[2].windowName, false)

		-- hide the button to go back
		WindowSetShowing(data.Buttons[1], false)
					
	-- titles list page 2
	elseif data.Labels[13].tid == 1152896 then -- Click the gem next

		-- flag the gump to be shown
		GumpsParsing.ToShow[gumpID] = true

		-- show the gump
		WindowSetShowing(data.Labels[2].windowName, false)

		-- hide the button to go back
		WindowSetShowing(data.Buttons[1], false)
					
	-- city loyalty page
	elseif data.Labels[1].tid == 1152188 then -- <center>City Loyalty</center>
					
		-- update the parsed gump name
		GumpsParsing.ParsedGumps[gumpID] = "CityLoyalty"

		-- list of the cities in the same order of the gump
		local cities = {"Britain", "Jhelom", "Minoc", "Moonglow", "NewMagincia", "SkaraBrae", "Trinsic", "Vesper", "Yew", "Citizenship"}
					
		-- starting label ID
		local startLabel = 3 -- +2 for the first city loyalty level
			
		-- scan all the cities
		for i, city in pairsByIndex(cities) do
			
			-- increase the label ID
			startLabel = startLabel + 2

			-- get the label tid
			local text = data.Labels[startLabel].tid

			-- update the city loyalty level
			WindowData.PlayerStatus[city] = GetStringFromTid(text)
		end
					
		-- update the timer for the next loyalty check
		CharacterSheet.NextLoyaltyUpdate = Interface.TimeSinceLogin + 60

		-- update the loyalty last update time
		CharacterSheet.LastLoyaltyUpdate = Interface.TimeSinceLogin
					
		-- get the label tid
		text = data.Labels[24].tid

		-- do we have the tid? that mean that we have recently announced a citizenship and can't change
		if text and text == 1152886 then -- You recently renounced citizenship

			-- store the params for the block
			CharacterSheet.cityLoyaltyBlock = data.Labels[24].tidParms[1]

		else -- remove the citizenship block
			CharacterSheet.cityLoyaltyBlock = nil
		end

		-- do we have a request to take a city loyalty?
		if CharacterSheet.TakeCityLoyalty then
		
			-- press the button to take the city loyalty
			GumpsParsing.PressButton(gumpID, CharacterSheet.TakeCityLoyalty)

		else -- destroy the gump
			GumpsParsing.DestroyGump(gumpID)
		end

	else -- main loyalty rating gump

		-- update the parsed gump name
		GumpsParsing.ParsedGumps[gumpID] = "LoyaltyRating"
					
		-- starting label ID
		local startLabel = 2 -- +2 for the first reputation

		-- list of the reputations in the gump (in the same order
		local rep = {"GargoyleQueen", "Ophidian", "BaneChosen", "Meer", "Juka"}

		-- scan all the reputations
		for i, name in pairsByIndex(rep) do
			
			-- increase the label ID
			startLabel = startLabel + 2

			-- get the text tid
			local text = data.Labels[startLabel].tid

			-- update the gargoyle queen level
			WindowData.PlayerStatus[name .. "Level"] = GetStringFromTid(text)

			-- increase the label ID
			startLabel = startLabel + 1

			-- update the gargoyle queen reputation
			WindowData.PlayerStatus[name] = data.Labels[startLabel].tidParms[1]
		end
					
		-- update the fame
		WindowData.PlayerStatus["Fame"] = data.Labels[18].tidParms[1]

		-- update the karma
		WindowData.PlayerStatus["Karma"] = data.Labels[19].tidParms[1]

		-- update shame dungeon points
		WindowData.PlayerStatus["Shame"] = data.Labels[21].tidParms[1]

		-- update despise dungeon points
		WindowData.PlayerStatus["Despise"] = data.Labels[22].tidParms[1]

		-- update the void points
		WindowData.PlayerStatus["Void"] = data.Labels[25].tidParms[1]
					
		-- press the next page button
		GumpsParsing.PressButton(gumpID, 1)
	end
end

function GumpsParsing.InsuranceMenu(gumpID, data)

	-- do we have the labels text for this gump?
	if data.LabelsText and #data.LabelsText >= 3 then

		-- get the gold amount
		local gamount = wstring.gsub(data.LabelsText[1], L",", L"")

		-- do we have a valid number?
		if tonumber(gamount) then

			-- update the player bank gold
			WindowData.PlayerStatus["BankGold"] = tonumber(gamount)
		end

		-- get the insurance cost
		gamount = wstring.gsub(data.LabelsText[2], L",", L"")

		-- update the insurance cost
		Interface.InsuranceCost = gamount

		-- get the playable deaths
		gamount = wstring.gsub(data.LabelsText[3], L",", L"")

		-- update the playable deaths
		Interface.PayableDeaths = gamount
		
		-- update the next bank gold check timer
		CharacterSheet.NextBankGoldUpdate = Interface.TimeSinceLogin + 60

		-- update the player vendor gold (if the gump is active)
		PlayerVendor.UpdatePlayerGold()

		-- is the vendor search visible?
		if WindowGetShowing(VendorSearch.WindowName) then

			-- get the bank gould amount
			local bankGold = tonumber(WindowData.PlayerStatus["BankGold"] or 0)

			-- update the bank balance label
			LabelSetText(VendorSearch.WindowName .. "BankBalanceValue", StringUtils.AddCommasToNumber(bankGold))
		end
	end
	
	-- is this an automated gump check for the bank gold?
	if GumpsParsing.GetBankGold then

		-- flag the gump to stay hidden
		GumpsParsing.ToShow[gumpID] = false

		-- destroy the gump
		GumpsParsing.DestroyGump(gumpID)

		-- toggle the flag to update the bank gold
		GumpsParsing.GetBankGold = false
	end
end

function GumpsParsing.SOS(gumpID, data)
	
	-- do we have the sos waypoints table?
	if not Interface.SOSWaypoints then

		-- initialize the table
		Interface.SOSWaypointsAll = CreateSaveStructureWithPlayerID(Interface.SOSWaypointsAll)

		-- load the waypoints
		Interface.InitializeSOSWaypoints()
	end

	-- scan all the gump labels
	for labelID, labelData in pairs(data.Labels) do

		-- scan the possible tid for an sos and check which one we have
		for i, tid in pairsByIndex(GumpsParsing.SOSTids) do

			-- is this the SOS tid?
			if labelData.tid == tid then
				
				-- get the SOS ID
				local sosID = Interface.LastItem 
				
				-- initialize the buttons variables
				local TrammelButton
				local FeluccaButton
				local cancelButton 
				local body
				
				-- get the SOS text
				local sosText = ReplaceTokens(GetStringFromTid(labelData.tid), labelData.tidParms)
				
				-- calculate the SOS coordinates
				local latVal, latDir, longVal, longDir = GumpsParsing.GetSOSCoords(labelData.tidParms[1])
					
				-- convert the coordinates in x, y
				local x, y = MapCommon.ConvertToXYMinutes(latVal, longVal, latDir, longDir, 1, 1)
				
				-- is the waypoint already listed?
				if not Interface.SOSWaypoints[sosID] then

					-- initialize the buttons to add the waypoint on trammel/felucca or cancel
					TrammelButton = { textTid = 1012000, callback = function() GumpsParsing.CreateSOSWaypoint(sosID, 1, x, y) end } -- Trammel
					FeluccaButton = { textTid = 1012001, callback = function() GumpsParsing.CreateSOSWaypoint(sosID, 0, x, y) end } -- Felucca
					cancelButton =  { textTid = UO_StandardDialog.TID_CANCEL_LC } -- Cancel

					-- initialize the message body text
					body = sosText ..  L"\n\n" .. GetStringFromTid(1079482) .. L"?" -- Create Waypoint Here

				else -- initialize the buttons to locate/magnetize or cancel
					TrammelButton = { textTid = 223, callback = function() MapCommon.Locate(x, y, Interface.SOSWaypoints[sosID].facet) end }
					FeluccaButton = { textTid = 224, callback = function() MapWindow.MagnetizeLocation(x, y, Interface.SOSWaypoints[sosID].facet, sosID) end }
					cancelButton =  { textTid = UO_StandardDialog.TID_CANCEL_LC } -- Cancel

					-- initialize the message body text
					body = sosText
				end

				-- initialize the dialog data
				local DestroyConfirmWindow = 
							{
								windowName = "SoS",
								titleTid = 1041081,
								body = body,
								buttons = { TrammelButton, FeluccaButton, cancelButton },
								closeCallback = cancelButton.callback,
								destroyDuplicate = true,
								forceHeight = 350 
							}

				-- create the dialog
				UO_StandardDialog.CreateDialog(DestroyConfirmWindow)

				-- destroy the gump
				GumpsParsing.DestroyGump(gumpID)

				return
			end 
		end
	end
end

function GumpsParsing.Moongate(gumpID, data)

	-- is the moongate window enabled?
	if Interface.Settings.MoongateGump then

		-- if the window already exist, we destroy it for safety
		if DoesWindowExist("Moongate") then
			DestroyWindow("Moongate")
		end

		-- create the moongate window
		CreateWindow("Moongate", true)
		
		-- parse the moongate data
		Moongate.MoongateParsing(gumpID, data)

		-- hide the gump
		GumpsParsing.ToShow[gumpID] = false
	end
end

function GumpsParsing.DyeGump(gumpID, data)

	-- parse the dye tub
	DyeTubs.DyeTubsParsing(gumpID)
end

function GumpsParsing.AnimalLore(gumpID, data)

	-- is the animal lore window active?
	if Interface.Settings.NewAnimalLore then

		-- make sure the gump has not been called from the magincia pet vendor
		if not AnimalLore.VendorPetType then
			
			-- get the last animal lore target
			AnimalLore.TargetID = Interface.LastTarget
		end

		-- does the gump has as frst label anything but the empty token title
		if data.Labels[1].tid ~= 1114513 then -- <DIV ALIGN=CENTER>~1_TOKEN~</DIV>

			-- parse the animal lore data
			AnimalLore.InitializeGump()
			
			-- update the progress in the pet healthbar
			MobileHealthBar.ForceUpdatePetProgress()

		else -- this is a warning message so we have to skip it
			GumpsParsing.PressButton(gumpID, 1)
		end
	end
end

function GumpsParsing.PetTraining(gumpID, data)

	-- reset the all the pet progress
	AnimalLore.PetProgress = {}

	-- scan the label text 2 by 2 until we have all the pets
	for i = 1, #data.LabelsText, 2 do

		-- is this a number?
		if tonumber(data.LabelsText[i]) then

			-- initialize the pet record
			local pet = {}

			-- get the pet name
			pet.name = wstring.lower(AnimalLore.CleanTags(data.LabelsText[i]))

			-- get the current progress percent
			pet.perc = AnimalLore.CleanTags(data.LabelsText[i + 1])

			-- add the record to the pet progress table
			table.insert(AnimalLore.PetProgress, pet)
		end
	end

	-- update the progress in the pet healthbars
	MobileHealthBar.ForceUpdatePetProgress()
end

function GumpsParsing.HouseContainerSecurity(gumpID, data)

	-- do we have to set a security automatically?
	if Actions.SecType then
		
		-- automatically set the security for a container
		Actions.SetSecurity(gumpID)
	end
end

function GumpsParsing.CraftingMenuItemDetail(gumpID, data)

	-- check the crafting menu title and update the parsed gump name
	GumpsParsing.ParsedGumps[gumpID] = CraftingInfo.CraftingToolNames[data.Labels[4].tid].name

	-- flag that indicates that we need to get the item data
	if GumpsParsing.getItemData then

		-- remove the flag to log the next item
		GumpsParsing.getItemData = nil

		-- store the current item info
		GumpsParsing.GetCraftingToolItemData()

		-- move to the next item when the gump is back up
		Interface.ExecuteWhenAvailable({ name = "GetCraftingToolItemDetailsNEXT", check = function() return GumpsParsing.ParsedGumps[GenericGump.CRAFTING_GUMPID] ~= nil end, callback = function() GumpsParsing.MapCraftingToolItemsGetNextItem() end, maxTime = Interface.TimeSinceLogin + 1, delay = Interface.TimeSinceLogin + 1, removeOnComplete = true })
	end

	-- flag that indicates that we don't have the recipe
	local noRecipe = false

	-- scan all the labels (now we search for the category label window name)
	for id, dt in pairsByKeys(data.Labels) do

		-- does this item requires a recipe?
		if dt.tid == 1073620 then -- You have not learned this recipe.
			
			-- fix the label font to make it more readable
			LabelSetFont(dt.windowName, GenericGump.BoldFont_small, WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)

			-- flag that we don't have the recipe for this item
			noRecipe = true
		end
	end

	-- are we scanning for the recipe and we don't have the recipe?
	if GumpsParsing.ScanForRecipes and noRecipe then

		-- store the item in the missing recipes list
		GumpsParsing.MissingRecipes[GumpsParsing.RecipesItems[GumpsParsing.ScanItems]] = true

		-- click the back button
		GumpsParsing.PressButton(gumpID, 1)

		-- move to the next item when the gump is back up
		Interface.ExecuteWhenAvailable({ name = "GetCraftingToolItemDetailsNEXTRecipe", check = function() return GumpsParsing.ParsedGumps[GenericGump.CRAFTING_GUMPID] ~= nil end, callback = function() GumpsParsing.CraftingToolItemsCheckNextRecipe() end, maxTime = Interface.TimeSinceLogin + 1, delay = Interface.TimeSinceLogin + 1, removeOnComplete = true })
	end
end

function GumpsParsing.CraftingMenu(gumpID, data)

	-- check if the last item used is the tool for this gump
	local possibleTool = GumpsParsing.CraftingToolToolCheckTool(Interface.LastItem)

	-- is this the tool that opened this gump?
	if possibleTool and possibleTool == data.Labels[1].tid then

		-- store the tool ID
		GumpsParsing.CurrentTool = Interface.LastItem
	end

	-- do we have a valid tool ID?
	if IsValidID(GumpsParsing.CurrentTool) then

		-- get the gump title
		local gumpTitle = LabelGetText(data.Labels[1].windowName)

		-- get the remaining uses for the tool
		local _, uses = ItemProperties.DoesItemHasProperty(GumpsParsing.CurrentTool, 1060584) -- uses remaining: ~1_val~

		-- show the uses on the gump title
		LabelSetText(data.Labels[1].windowName, gumpTitle .. L"\t" .. ReplaceTokens(GetStringFromTid(662), uses))
	end

	-- check the crafting menu title and update the parsed gump name
	GumpsParsing.ParsedGumps[gumpID] = CraftingInfo.CraftingToolNames[data.Labels[1].tid].name

	-- is the crafting tool mapping utility active?
	if GumpsParsing.MapCraftingToolActive then

		-- remove the flag to export the tool
		GumpsParsing.MapCraftingToolActive = nil

		-- disable the window until the process is completed
		WindowSetHandleInput(data.windowName, false)

		-- warn that the export is started
		Debug.Print("EXPORT TOOL STARTED...")

		-- get the crafting skill name
		local skillName = GumpsParsing.ParsedGumps[gumpID]

		-- do we have the tool map table?
		if not CraftingInfo.ToolMap then

			-- initialize the tool map table
			CraftingInfo.ToolMap = {}
		end

		-- reset the current tool data
		CraftingInfo.ToolMap[skillName] = nil

		-- get the first category button ID
		GumpsParsing.CraftingCategoryButtonStartId = GumpsParsing.MapCraftingToolGetFirstCatButton(gumpID)
		
		-- initialize the first category ID
		GumpsParsing.ToolCategory = 1
		
		-- move to the first category
		GumpsParsing.PressButton(gumpID, GumpsParsing.CraftingCategoryButtonStartId + GumpsParsing.ToolCategory)

		-- add the continue flag
		GumpsParsing.MapCraftingToolContinue = true
	
	-- do we have to continue the export?
	elseif GumpsParsing.MapCraftingToolContinue then

		-- remove the continue flag
		GumpsParsing.MapCraftingToolContinue = nil

		-- disable the window until the process is completed
		WindowSetHandleInput(data.windowName, false)

		-- continue the export
		GumpsParsing.MapCraftingTool(gumpID, data)

	else -- normal behaviour

		-- toggle the input availability based on if we are scanning the item data or not
		WindowSetHandleInput(data.windowName, not GumpsParsing.getItemData)

		-- get the selected category label name and index
		local catIndex, _, label = GumpsParsing.ToolGetSelectedCategory(gumpID, data)

		-- store the current category index
		GumpsParsing.CraftingToolCurrentCategory = catIndex

		-- highlight the selected category
		LabelSetTextColor(label, GenericGump.HighlightColor.r, GenericGump.HighlightColor.g, GenericGump.HighlightColor.b)

		-- change the label font
		LabelSetFont(label, GenericGump.BoldFont_small, WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	end

	-- get the window size
	local w, h = WindowGetDimensions(data.windowName)
	
	-- search window name
	local searchBox = "CraftingTool"

	-- create the search box for the gump
	CreateWindowFromTemplate(searchBox, "CraftingTool", data.windowName)

	-- remove the search box anchors
	WindowClearAnchors(searchBox)

	-- add the search line on the bottom of the gump
	WindowAddAnchor(searchBox, "bottom", data.windowName, "bottom", -1, 0)

	-- increase the window size
	WindowSetDimensions(data.windowName, w, h + 68)

	-- draw the recipe item in the recipe search button
	EquipmentData.DrawObjectIcon(10289, 0, searchBox .."ScanRecipesIcon", 100, 100, 1.2)

	-- the button to rebuild the tool data is only visible in debug mode
	WindowSetShowing(searchBox .."RebuildToolData", Interface.DebugMode)

	-- set the rebuild data icon
	EquipmentData.DrawObjectIcon(7716, 0, searchBox .."RebuildToolDataIcon", 100, 100, 0.8)
	
	-- are we scanning for recipes?
	if GumpsParsing.ScanForRecipes then

		-- warn the player to stand still or the process will fail
		LabelSetText(searchBox .. "Warning", GetStringFromTid(178))

		-- disable the window until the process is completed
		WindowSetHandleInput(data.windowName, false)
	end

	-- by default the tool always go back to page 1
	GumpsParsing.CraftingToolCurrentPage = 1

	if not GumpsParsing.CraftingToolAutoDetails and not GumpsParsing.ScanForRecipes then

		-- restore the search text and assign the focus to the search box so we can keep searching by pressing enter and then resume the search (if it's the same tool)
		Interface.ExecuteWhenAvailable({ name = "CraftingToolItemFocusSearch", check = function() return WindowGetShowing(searchBox .. "SearchBoxFilter") end, callback = function() WindowAssignFocus(searchBox .. "SearchBoxFilter", GumpsParsing.CraftingToolLastSearch ~= nil) TextEditBoxSetText(searchBox .. "SearchBoxFilter", GumpsParsing.CraftingToolLastSearch or L"") GumpsParsing.CraftingToolSearchNext(GumpsParsing.LastTool == GumpsParsing.ParsedGumps[GenericGump.CRAFTING_GUMPID]) end, maxTime = Interface.TimeSinceLogin + 1, removeOnComplete = true })
	end
end

function GumpsParsing.VendorSearch(gumpID, data)

	-- is the vendor search window already open?
	if not DoesWindowExist(VendorSearch.WindowName) then
		CreateWindow(VendorSearch.WindowName, true)

	else -- update the window
		VendorSearch.UpdateButtonsMap()

		-- disable the loading screen if we're not loading the criteria
		VendorSearch.SetLoading(VendorSearch.LoadCriteriaPhase ~= nil)
	end

	-- hide the gump
	GumpsParsing.ToShow[gumpID] = false
end

function GumpsParsing.VendorSearchResults(gumpID, data)

	-- get the vendor search result window name
	local parent = data.windowName

	-- create the toggle search button
	CreateWindowFromTemplate(parent .. "ToggleSearch", "ToggleSearchTemplate", parent)

	-- clear the button anchors
	WindowClearAnchors(parent .. "ToggleSearch")

	-- anchor the button on the top-left of the window
	WindowAddAnchor(parent .. "ToggleSearch", "topleft", parent, "topleft", 70, 40)

	-- hide the search engine
	VendorSearch.ToggleSearch(false)
end

function GumpsParsing.HTML_Book(gumpID, data)

	-- is this the corrupted crystal portal?
	if data.Labels[1].tid == 1150074 then -- Corrupted Crystal Portal

		-- update the parsed gump name
		GumpsParsing.ParsedGumps[gumpID] = "CorruptedCrystalPortal"

		-- is the crystal portal window visible?
		if not DoesWindowExist(CrystalPortal.WindowName) or not WindowGetShowing(CrystalPortal.WindowName) then
			
			-- show the crystal portal window
			CrystalPortal.Toggle()
		end

		-- destroy the original gump
		GumpsParsing.DestroyGump(gumpID)

	-- is this the crystal portal?
	elseif data.Labels[1].tid == 1113945  then -- Crystal Portal

		-- update the parsed gump name
		GumpsParsing.ParsedGumps[gumpID] = "CrystalPortal"

		-- is the crystal portal window visible?
		if not DoesWindowExist(CrystalPortal.WindowName) or not WindowGetShowing(CrystalPortal.WindowName) then
			
			-- show the crystal portal window
			CrystalPortal.Toggle()
		end

		-- destroy the original gump
		GumpsParsing.DestroyGump(gumpID)

	else -- any other gump we show
		GumpsParsing.ToShow[gumpID] = true
	end	
end

function GumpsParsing.SixMonthsReward(gumpID, data)

	-- show the 6 months reward dialog
	GumpsParsing.SixMonthsRewardGump()
end

function GumpsParsing.TransferCrateWarning(gumpID, data)

	-- if this is the transfer crate warning, we mark the next container as the transfer crate
	Interface.UnpackTransferCrate = true
end

function GumpsParsing.SummonFamiliarMenu(gumpID, data)

	-- get the familiar to be selected automatically
	local button = Interface.ForceFamiliar

	-- do we have to pick a familiar automatically?
	if button ~= 0 then

		-- do the player has the requirements to summon the selected familiar?
		if SpellsInfo.SumonFamiliarSkillRequirements(button) == 1 then

			-- if not we disable the auto-select
			button = 0
		end

		-- do we have to auto-select the familiar?
		if button ~= 0 then

			-- summon the familiar
			GumpsParsing.PressButton(gumpID, button)

			-- set the gump to stay hidden
			GumpsParsing.ToShow[gumpID] = false
		end
	end
end

function GumpsParsing.EnchantSpell(gumpID, data)

	-- get the enchant to be selected automatically
	local button = Interface.ForceEnchant

	-- do we have to auto-select an enchant?
	if button ~= 0 then

		-- select the enchant
		GumpsParsing.PressButton(gumpID, button)

		-- set the gump to stay hidden
		GumpsParsing.ToShow[gumpID] = false
	end
end

function GumpsParsing.CombatTrainingMenu(gumpID, data)
	
	-- get the training to be selected automatically
	local button = Interface.ForceTraining

	-- do we have to auto-select an training?
	if button ~= 0 then

		-- select the training
		GumpsParsing.PressButton(gumpID, button)

		-- set the gump to stay hidden
		GumpsParsing.ToShow[gumpID] = false
	end
end

function GumpsParsing.Masteries(gumpID, data)
	
	-- initialize mastery array
	if not Spellbook.MyMasteries then
		Spellbook.MyMasteries = {}
	end
	
	-- initialize the last tier variable
	local lastTIer = 0

	-- search for the labels values
	for id, dt in pairsByKeys(data.Labels) do

		-- each skill has the tier value 1 label back
		
		-- is this a skill tier?
		if dt.tid == 1156052 then -- Tier: ~1_LVL~

			-- store the tier value
			lastTIer = tonumber(dt.tidParms[1])

		-- is this a mastery skill?
		elseif Spellbook.MasteryBookTIDs[dt.tid] then

			-- save the tier for the mastery
			Spellbook.MyMasteries[dt.tid] = lastTIer
			
			-- reset the last tier value
			lastTIer = 0
		end
	end

	-- is this an automated call?
	if Spellbook.MasteryGumpCheck == true then

		-- destroy the gump
		GumpsParsing.DestroyGump(gumpID)

		-- remove the flag to check the mastery gump
		Spellbook.MasteryGumpCheck = nil
	end
end

function GumpsParsing.RessGump(gumpID, data)

	-- create the ress confirm dialog
	GumpsParsing.RessConfirm(data.Labels[2].tid)
end

function GumpsParsing.DryDock(gumpID, data)

	-- create the ress confirm dialog
	GumpsParsing.DryDockConfirm(data.Labels[1].tid)
end

function GumpsParsing.FriendRequest(gumpID, data)

	-- create the friend request confirm dialog with the name of the player
	GumpsParsing.FriendRequestConfirm(data.Labels[2].tidParms[1])
end

function GumpsParsing.TCGump(gumpID, data)
	
	-- get the current shard name
	local shard = Interface.ShardsList[UserData.Settings.Login.lastShardSelected]

	-- is this the test center shard?
	if not wstring.find(shard, L"Test Center", 1, true) and not wstring.find(shard, L"TC", 1, true) then
		return
	end

	-- is this the TC gump or is appeared within 10 seconds from the UI start?
	if (data.Labels[1].LabelText and wstring.find(data.Labels[1].LabelText, L"Test Center", 1, true)) or Interface.TimeSinceLogin < 20 then

		-- create the TC gump dialog
		GumpsParsing.TCGumpDialog()

		-- hide the gump
		GumpsParsing.ToShow[gumpID] = false
	end
end

function GumpsParsing.Tracking(gumpID, data)

	-- do we have a avlid target selection?
	if IsValidID(Interface.ForceTracking) then
	
		-- press the default target button
		GumpsParsing.PressButton(GenericGump.TRACKING_GUMPID, Interface.ForceTracking)
	end
end

function GumpsParsing.BankActions(gumpID, data)

	-- container window name
	local this = "ContainerWindow_" .. GetPlayerBankID()
	
	-- is this the player bankbox?
	if DoesWindowExist(this) or GumpData.Gumps[GenericGump.EJ_BANK_GUMPID] then
	
		-- bank balance mask window name
		local maskName = "ContainerBankMaskTemplate"

		-- we create the bank balance mask
		if not DoesWindowExist(maskName) then
			CreateWindow(maskName, true)
		end

		-- fix background transparency
		WindowSetAlpha(maskName .. "BG", 0.6)

		-- clearing the slot position
		WindowClearAnchors(maskName)

		-- do we have the EJ bank gump?
		if not DoesWindowExist(this) and GumpData.Gumps[GenericGump.EJ_BANK_GUMPID] then
		
			-- anchor to the EJ bank box
			WindowAddAnchor(maskName, "bottom", GumpData.Gumps[GenericGump.EJ_BANK_GUMPID].windowName, "top", 0, 10)

		else -- anchor the bank mask to the botom of the content label
			WindowAddAnchor(maskName, "bottom", this .. "Content", "top", 0, 10)
		end

		-- labels window names
		local totalGold = maskName.."TotalGold"
		local totalPlatinum = maskName.."TotalPlatinum"
		local totalSecure = maskName.."TotalSecure"
		local totalTransferGold = maskName.."TotalTransferGold"
		local totalTransferPlatinum = maskName.."TotalTransferPlatinum"

		-- filling the labels names
		LabelSetText(totalGold, GetStringFromTid(1156044)) -- Total Gold:
		LabelSetText(totalPlatinum, GetStringFromTid(1156045)) -- Total Platinum:
		LabelSetText(totalSecure, GetStringFromTid(1157003)) -- Secure Account:
		LabelSetText(totalTransferGold, GetStringFromTid(1157004)) -- Transfer Gold:
		LabelSetText(totalTransferPlatinum, GetStringFromTid(1157005)) -- Transfer Platinum:

		-- do we have the labels values?
		if data.LabelsText then

			-- filling the labels values
			LabelSetText(totalGold .. "Value", data.LabelsText[1])
			LabelSetText(totalPlatinum .. "Value", data.LabelsText[2])
			LabelSetText(totalSecure .. "Value", data.LabelsText[3])
			LabelSetText(totalTransferGold .. "Value", data.LabelsText[4])
			LabelSetText(totalTransferPlatinum .. "Value", data.LabelsText[5])
		end

		-- draw the deposit gold image
		EquipmentData.DrawObjectIconAtWindowDimensions(8487, 2213, maskName .. "DepositGoldTransferIMG")

		-- draw the deposit platinum image
		EquipmentData.DrawObjectIconAtWindowDimensions(8487, 1154, maskName .. "DepositPlatinumTransferIMG")

		-- draw the withdraw gold image
		EquipmentData.DrawObjectIconAtWindowDimensions(8487, 2213, maskName .. "WithdrawGoldTransferIMG")
		DynamicImageSetTextureOrientation(maskName .. "WithdrawGoldTransferIMG", true)

		-- draw the withdraw platinum image
		EquipmentData.DrawObjectIconAtWindowDimensions(8487, 1154, maskName .. "WithdrawPlatinumTransferIMG")
		DynamicImageSetTextureOrientation(maskName .. "WithdrawPlatinumTransferIMG", true)

		-- draw the deposit gold secure storage image
		EquipmentData.DrawObjectIconAtWindowDimensions(2472, 0, maskName .. "DepositGoldSecureIMG")

		-- draw the deposit platinum secure storage image
		EquipmentData.DrawObjectIconAtWindowDimensions(2472, 0, maskName .. "WithdrawGoldSecureIMG")
		DynamicImageSetTextureOrientation(maskName .. "WithdrawGoldSecureIMG", true)
	end
end

function GumpsParsing.RunicAtlas(gumpID, data)

	-- is this the hunter atlas?
	if GumpsParsing.IsHunterAtlas() then
		
		-- update the parsed gump name
		GumpsParsing.ParsedGumps[gumpID] = "HunterAtlas"

		return
	end
				
	-- scan all the labels in the gump
	for id, dt in pairs(data.Labels) do

		-- add the left mouse button down event
		WindowRegisterCoreEventHandler(dt.windowName, "OnLButtonDown", "GenericGump.RunicAtlasManagement")	
	end

	-- do we have the runic atlas ID?
	if GumpsParsing.RunicAtlasID == 0 then

		-- store the runic atlas ID
		GumpsParsing.RunicAtlasID = Interface.LastItem

		-- get the runic atlas properties
		local props = ItemProperties.GetObjectPropertiesTid(Interface.LastItem, nil, "Runic Atlas get locked down/secure")	

		-- do we have the item properties?
		if props then

			-- scan all the properties
			for id, tid in pairs(props) do	

				-- is this the locked down property?
				if tid == 501643 or tid == 501644 then -- locked down // locked down & secure

					-- flag the runic atlas as locked
					GumpsParsing.RunicAtlasLocked = true

					break
				end
			end
		end
	end

	-- runic atlas original rune lables color
	local OriginalLabelColors = 
	{ 
		malas = { r = 160, g = 160, b = 176 }, 
		trammel = { r = 144, g = 96, b = 240 },
		tokuno = { r = 216, g = 240, b = 240 }, 
		felucca = { r = 144, g = 240, b = 192 }, 
		termur = { r = 192, g = 48, b = 48 } 
	}	

	-- scan all the labels
	for label, dt in pairsByKeys(data.Labels) do
			
		-- is the runic atlas locked down?
		if GumpsParsing.RunicAtlasLocked then

			-- is this the rename book label?
			if dt.tid == 1011299 then -- rename book

				-- hide the rename book button
				GumpsParsing.RunicAtlasHideSpellButton(dt, data)

			-- is this the drop rune label?
			elseif dt.tid == 1011298 then -- drop rune

				-- hide the drop rune button
				GumpsParsing.RunicAtlasHideSpellButton(dt, data)
			end
		end

		-- skill check: recall
		if dt.tid == 1077595 then -- recall (spell)

			-- does the player has the skill for recall and is not in wraith form?
			if (WindowData.SkillDynamicData[GumpsParsing.SpellSchools.MAGERY].TempSkillValue < 0 and not BuffDebuff.ActiveBuffs[1124]) then

				-- hide the recall button
				GumpsParsing.RunicAtlasHideSpellButton(dt, data)
			end

		-- skill check: sacred journey
		elseif data.tid == 1062724 then -- sacred journey

			-- is the sacred journey visible, and the player has less than 15 tithing points?
			if (GumpsParsing.RunicAtlasIsSacredJourneyVisible() and WindowData.PlayerStatus["TithingPoints"] and WindowData.PlayerStatus["TithingPoints"] < 15) then
					
				-- hide the sacred journey button
				GumpsParsing.RunicAtlasHideSpellButton(dt, data)
			end
		end

		-- now we have to re-color the labels text to match the normal runebook

		-- does the label still exist?
		if DoesWindowExist(dt.windowName) then

			-- get the label text color
			local newr, newg, newb = LabelGetTextColor(dt.windowName)

			-- if we don't have the color then it's not a label
			if newr ~= nil and newg ~= nil and newb ~= nil then								

				-- create a proper table for the label color
				local myRGB = { r = math.floor(newr), g = math.floor(newg), b = math.floor(newb) }
						
				-- default selected label color
				local labelColor = { r = 146, g = 0, b = 0 }

				-- is this a trammel rune?
				if myRGB.r == OriginalLabelColors.trammel.r and myRGB.g == OriginalLabelColors.trammel.g and myRGB.b == OriginalLabelColors.trammel.b then

					-- update the trammel rune color
					labelColor = LegacyRunebook.LegacyLabelColors.trammel

				-- is this a felucca rune?
				elseif myRGB.r == OriginalLabelColors.felucca.r and myRGB.g == OriginalLabelColors.felucca.g and myRGB.b == OriginalLabelColors.felucca.b then

					-- update the felucca rune color
					labelColor = LegacyRunebook.LegacyLabelColors.felucca

				-- is this a malas rune?
				elseif myRGB.r == OriginalLabelColors.malas.r and myRGB.g == OriginalLabelColors.malas.g and myRGB.b == OriginalLabelColors.malas.b then
			
					-- update the malas rune color
					labelColor = LegacyRunebook.LegacyLabelColors.malas							

				-- is this a tokuno rune?
				elseif myRGB.r == OriginalLabelColors.tokuno.r and myRGB.g == OriginalLabelColors.tokuno.g and myRGB.b == OriginalLabelColors.tokuno.b then

					-- update the tokuno rune color
					labelColor = LegacyRunebook.LegacyLabelColors.tokuno

				-- is this a ter mur rune?
				elseif myRGB.r == OriginalLabelColors.termur.r and myRGB.g == OriginalLabelColors.termur.g and myRGB.b == OriginalLabelColors.termur.b then

					-- update the ter mur rune color
					labelColor = LegacyRunebook.LegacyLabelColors.termur

				-- is this a label without color?
				elseif myRGB.r == 0 and myRGB.g == 0 and myRGB.b == 0 then

					-- use the default label color
					labelColor = LegacyRunebook.DefaultItemLabel		
				end

				-- set the label text color
				LabelSetTextColor(dt.windowName, labelColor.r, labelColor.g, labelColor.b)
			end
		end		
	end

	-- scan all the laels test
	for id, text in pairsByKeys(data.LabelsText) do

		-- is this an empty rune? we have to hide the button then, because it's pointless to have a button that does nothing.
		if text == L"Empty" then

			-- do we have 2 page turners?
			if GumpsParsing.RunicAtlasGetPageTurnerNumber() == 2 then -- 2 page turner

				-- get the rune button ID
				local buttonWindowd = data.Buttons[id + 1]

				-- does the button still exist?
				if DoesWindowExist(buttonWindowd) then

					-- hide the button
					WindowSetShowing(buttonWindowd, false)
				end

			else -- only 1 page turner (first or last page)

				-- get the rune button ID
				local buttonWindowd = data.Buttons[id]

				-- does the button still exist?
				if DoesWindowExist(buttonWindowd) then

					-- hide the button
					WindowSetShowing(buttonWindowd, false)
				end
			end
		end
	end
end

function GumpsParsing.IconsGump(gumpID, data)

	-- is this the animal form menu?
	if data.Labels[2].tid == 1063394 then -- <center>Animal Form Selection Menu</center>

		-- update the parsed gump name
		GumpsParsing.ParsedGumps[gumpID] = "AnimalFormMenu"

		-- do we have a button to press automatically?
		if Interface.ForceAnimal ~= 0 then

			-- get the button ID that needs to be automatically pressed (this function also does a safety skill check)
			local button = SpellsInfo.GetAnimalFormButtonID(Interface.ForceAnimal)

			-- do we have the button ID to press?
			if button ~= 0 then

				-- flag the gump to stay hidden
				GumpsParsing.ToShow[gumpID] = false

				-- press the button
				GumpsParsing.PressButton(gumpID, button)
			end

		else -- flag the gump to be visible
			GumpsParsing.ToShow[gumpID] = true
		end

	-- is this the spell trigger menu?
	elseif data.Labels[2].tid == 1080151 then -- <center>Spell Trigger Selection Menu</center>

		-- update the parsed gump name
		GumpsParsing.ParsedGumps[gumpID] = "SpellTriggerMenu"
					
		-- do we have to automatically press a button?
		if Interface.ForceSpellTrigger ~= 0 then

			-- get the button ID that needs to be automatically pressed (this function also does a safety skill check)
			local button = SpellsInfo.GetSpellTriggerButtonID(Interface.ForceSpellTrigger)

			-- do we have the button ID to press?
			if button ~= 0 then

				-- flag the gump to stay hidden
				GumpsParsing.ToShow[gumpID] = false

				-- press the button
				GumpsParsing.PressButton(gumpID, Interface.ForceSpellTrigger)
			end

		else -- flag the gump to be visible
			GumpsParsing.ToShow[gumpID] = true
		end
		
	-- is this the polymorph gump?
	elseif data.Labels[2].tid == 1015234 then -- <center>Polymorph Selection Menu</center>

		-- update the parsed gump name
		GumpsParsing.ParsedGumps[gumpID] = "PolymorphMenu"

		-- do we have to automatically select a form?
		if Interface.ForcePolymorph ~= 0 then

			-- get the form button ID
			local num = Interface.ForcePolymorph + 1

			-- if the ID is creater than 12 we add 2 (the page turners)
			if num >= 12 then
				num = num + 2
			end

			-- flag the gump to stay hidden
			GumpsParsing.ToShow[gumpID] = false

			-- press the button
			GumpsParsing.PressButton(gumpID, num)

		else -- flag the gump to be visible
			GumpsParsing.ToShow[gumpID] = true
		end

	-- is this the heritage token gump?
	elseif data.Labels[1].tid == 1075576 then -- Choose your item from the following pages

		-- update the parsed gump name
		GumpsParsing.ParsedGumps[gumpID] = "HeritageToken"
	end
end

function GumpsParsing.QuestOffer(gumpID, data)

	-- save the questgiver ID (used for escort)
	QuestLog.LastQuestGiver = Interface.LastItem
end

function GumpsParsing.QuestLog(gumpID, data)

	-- is the auto-scan active?
	if QuestLog.ScanInProgress then

		-- flag the gump to stay hidden
		GumpsParsing.ToShow[gumpID] = false

	else -- flag the gump to be visible
		GumpsParsing.ToShow[gumpID] = true
	end

	-- scan the quest log
	QuestLog.ScanLog()

	-- auto-scan active, start parsing the quests
	if QuestLog.CurrentScanning then

		-- do we have more quests to scan?
		if QuestLog.CurrentScanning <= QuestLog.QuestCount then

			-- click the next quest details to get
			GumpsParsing.PressButton(gumpID, QuestLog.CurrentScanning + 1)

		else -- no more quests, stopping the scan
			QuestLog.CurrentScanning = nil

			-- reset the new quests array
			QuestLog.NewActiveQuests = {}

			-- scan the gump for all quest names
			for _, dt in pairs(GumpData.Gumps[QuestLog.MainLogGumpID].Labels) do
						
				-- save the quest in the new quest array
				if data.tid then
					QuestLog.NewActiveQuests[dt.tid] = true
				end
			end
						
			-- close the quest log
			GumpsParsing.PressButton(gumpID, 1)
						
			-- counter of removed quests
			local removed = 0

			-- scan the active quest list to clean it up from the old quests
			for questName, _ in pairs(QuestLog.ActiveQuests) do

				-- if the quest is not in the new quests array we remove the quest
				if not QuestLog.NewActiveQuests[questName] then

					-- get the quest escort NPC ID
					local escortID = QuestLog.ActiveQuests[questName].escortQuestGiver

					-- if it's an escort quest we have to remove the marker from the NPC
					if IsValidID(escortID) then
									
						-- remove the quest marker
						OverheadText.RemoveQuestMarkerFromMobile(escortID)

						-- add the NPC escort to the disabled markers
						QuestLog.DisabledQuestMarkers[escortID] = true
					end

					-- increase the count of removed quests
					removed = removed + 1

					-- remove the quest from the list
					QuestLog.ActiveQuests[questName] = nil
				end
			end

			-- if we have removed at least one quest we refresh all the markers
			if removed > 0 then
				QuestLog.ClearAllMarkers()
			end

			-- reset the new quests array
			QuestLog.NewActiveQuests = {}

			-- mark the quest log scanned at least once since login
			QuestLog.QuestLogScannedAtLeastOnce = true

			-- mark the scan progress as finished
			QuestLog.ScanInProgress = false

			-- force the update of the markers
			OverheadText.QuestMarkerDelta = 0
		end
	end
end

function GumpsParsing.QuestDetailsLog(gumpID, data)

	-- is the auto-scan active?
	if QuestLog.ScanInProgress then

		-- flag the gump to stay hidden
		GumpsParsing.ToShow[gumpID] = false

	else -- flag the gump to be visible
		GumpsParsing.ToShow[gumpID] = true
	end

	-- scan the quest details
	QuestLog.ScanDetails()

	-- auto-scan active, moving to the next quest
	if QuestLog.CurrentScanning then

		-- increase the quest ID
		QuestLog.CurrentScanning = QuestLog.CurrentScanning + 1

		-- return to the quest log
		GumpsParsing.PressButton(gumpID, 2)
	end
end

function GumpsParsing.StableClaim(gumpID, data)

	-- reset the pets list
	PetsList.List = {}

	-- scan all labels text
	for id, text in pairsByIndex(data.LabelsText) do
					
		-- the pets names start from 2
		if id >= 2 then
						
			-- let's get the pet name without HTML tags
			local rawPetName = WindowUtils.translateMarkup(text)

			-- let's get all the words in the raw pet name (we need this to remove the pet ID)
			local words = wstring.split(rawPetName, L" ")
						
			-- let's remove the pet ID and format the name properly
			rawPetName = FormatProperly(wstring.gsub(rawPetName, words[1] .. L" ", L""))
						
			-- add the pet to the list
			PetsList.List[id-1] = rawPetName
		end
	end

	-- show the pet list
	CreateWindow( "PetsList", true )
end

function GumpsParsing.PlayerVendorManage(gumpID, data)

	-- set the player vendor ID
	PlayerVendor.MobileId = Interface.LastMobile

	-- show the vendor window
	if not DoesWindowExist("PlayerVendor") then
		CreateWindow( "PlayerVendor", true )

	else -- refresh the window
		PlayerVendor.RefreshWindow()
	end
end

function GumpsParsing.PlayerVendorCustomize(gumpID, data)

	-- scan all labels
	for _, dt in pairs(data.Labels) do

		-- is this the male label?
		if dt.tid == 1015327 then -- male

			-- is the vendor male? if the label is highlighted it is.
			PlayerVendor.VendorGenderMale = PlayerVendor.CheckLabelHighlighted(dt.windowName)

		-- is this the human label?
		elseif dt.tid == 1072255 then -- Human

			-- is the vendor human? if the label is highlighted it is.
			PlayerVendor.VendorRaceHuman = PlayerVendor.CheckLabelHighlighted(dt.windowName)
		end
	end

	-- refresh the custom vendor window
	PlayerVendor.RefreshWindow()
end

function GumpsParsing.PlayerVendorDismiss(gumpID, data)

	-- get the message tid
	local tid = GumpData.Gumps[gumpID].Labels[1].tid

	-- create the confirm gump
	GumpsParsing.DismissVendorConfirm(tid)

	-- close the player vendor gump
	if DoesWindowExist("PlayerVendor") then
		DestroyWindow("PlayerVendor")
	end
end

function GumpsParsing.VirtuesGump(gumpID, data)

	-- scan all the images in the gump
	for id, window in pairs(data.Images) do

		-- is this a virtue image?
		if GenericGump.VirtueImagesTable[id] then

			-- add the left mouse button down event
			WindowRegisterCoreEventHandler(window, "OnLButtonDown", "GenericGump.DragVirtue")	
		end
	end
end

function GumpsParsing.RedeemGump(gumpID, data)

	-- get the message tid
	local tid = GumpData.Gumps[gumpID].Labels[2].tid

	-- create the confirm gump
	GumpsParsing.RedeemItemConfirm(tid)
end

function GumpsParsing.AnimalTrainingConfirm(gumpID, data)

	-- get the message tid
	local tid = GumpData.Gumps[gumpID].Labels[2].tid

	-- create the confirm gump
	GumpsParsing.PetTrainingConfirm(tid)
end

function GumpsParsing.SoulstoneGump(gumpID, data)

	-- does the soulstone window already exist?
	if DoesWindowExist("SoulstoneGump") then

		-- destroy the window first
		DestroyWindow("SoulstoneGump")
	end

	-- create the soulstone gump window
	CreateWindow("SoulstoneGump", false)

	-- update the gump based on the gump data
	SoulstoneGump.SetGumpType(data)
end

function GumpsParsing.EJBank(gumpID, data)

	-- search button name
	local searchButton = data.windowName .. "SearchButton"

	-- create the search button for the gump
	CreateWindowFromTemplate(searchButton, "GumpContainerSearchButtonTemplate", data.windowName)

	-- remove the button anchors
	WindowClearAnchors(searchButton)

	-- add the button under "Select filter"
	WindowAddAnchor(searchButton, "topleft", data.windowName, "topleft", 50, 30)
end

function GumpsParsing.JewelryBox(gumpID, data)

	-- search button name
	local searchBox = "JewelryBox"

	-- create the search box for the gump
	CreateWindowFromTemplate(searchBox, "JewelryBox", data.windowName)

	-- remove the search box anchors
	WindowClearAnchors(searchBox)

	-- add the search line on the bottom of the gump
	WindowAddAnchor(searchBox, "bottom", data.windowName, "bottom", 0, -30)

	-- re-filter the container
	GumpsParsing.JewelryBoxSearchText(_, true)
end

function GumpsParsing.TranscendenceAlacrityBook(gumpID, data)

	-- scan all the labels
	for _, dt in pairsByKeys(data.Labels) do

		-- change the label font
		LabelSetFont(dt.windowName, GenericGump.SmallFont, WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)

		-- bring the labels forward so they won't fall behind the turn page buttons
		WindowSetLayer(dt.windowName, Window.Layers.OVERLAY)
	end

	-- get the current gump scale
	local scale = WindowGetScale(data.windowName)

	-- is the scale less than 1.0?
	if scale < 1 then

		-- make the gump bigger
		WindowSetScale(data.windowName, 1.1)
	end
end

function GumpsParsing.DaviesLocker()

	-- LABELS STRUCTURE:
	-- 7: maps count

	-- the first element if it's a map has:
	-- 11: coords (or 1153569: unknown)
	-- 12: facet
	-- 13-14: map name
	-- 15: decoded/not
	-- 16+ next element

	-- if it's an SOS:
	-- 11: coords (or 1153569: unknown)
	-- 12: facet
	-- 13: map name
	-- 14: opened/not
	-- 15+ next element

	-- reset the data of this page
	GumpsParsing.DaviesLockerData = {}

	-- store the gump ID
	local gumpID = GenericGump.DAVIES_LOCKER_GUMPID

	-- max number of maps/sos per page
	local maxElements = 15

	-- first label of the first element
	local firstLabelId = 11

	-- next label to check
	local nextLabel = 11

	-- shortcut to the labels table
	local labelsTable = GumpData.Gumps[gumpID].Labels

	-- run through all the maps/sos
	for i = 1, maxElements do

		-- do we have the next label?
		if not labelsTable[nextLabel] then
			break
		end

		-- initialize the data for this element
		local data = {}

		-- get the text and tid for the label
		local labelText = labelsTable[nextLabel].LabelText
		local labelTid = labelsTable[nextLabel].tid

		-- initialize the x, y coordinates
		local x, y

		-- do we have unknown coordinates?
		if labelTid and labelTid == 1153569 then -- unknown

			-- store unknown
			data.coordsText = GetStringFromTid(1153569)

			-- flag the map as not decoded
			data.decoded = false

		else -- store the text coordinates
			data.coordsText = labelText

			-- calculate the coordinates
			local latVal, latDir, longVal, longDir = GumpsParsing.GetDaviesCoords(labelText)

			-- convert the coordinates in x, y
			 x, y = MapCommon.ConvertToXYMinutes(latVal, longVal, latDir, longDir, 1, 1)

			 -- flag the map as decoded
			 data.decoded = true
		end

		-- move to the next label (facet)
		nextLabel = nextLabel + 1

		-- get the facet tid
		labelTid = labelsTable[nextLabel].tid

		-- initialize the facet to trammel
		local facet = 1

		-- make sure we have a specific facet
		if labelTid ~= 1153567 then-- Tram / Fel

			-- convert the tid into the facet ID
			facet = MapCommon.MapTidToID[labelTid]

			-- get the hue for the map
			local hue = MapCommon.GetMapHue(facet)

			-- did we determine the map color?
			if hue then

				-- convert the hue color to rgb
				local r, g, b = HueRGBAValue(hue)

				-- label window name
				local windowName = labelsTable[nextLabel].windowName

				-- set the label text color
				LabelSetTextColor(windowName, r, g, b)

				-- fix the label font
				LabelSetFont(windowName, GenericGump.BoldFont_small, WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
			end
		end

		-- do we have the coordinates?
		if x and y then

			-- store the coordinates
			data.coords = { x = math.round(x), y = math.round(y), map = facet }
		
			-- is the map in eodon?
			if MapCommon.IsEodon(x, y, facet) then

				-- fix the facet name to valley of eodon
				LabelSetText(labelsTable[nextLabel].windowName, GetStringFromTid(1156262)) -- valley of eodon

				-- get the eodon hue and convert to rgb
				local r, g, b = HueRGBAValue(CourseMapWindow.MapTID[1158985].hue)

				-- label window name
				local windowName = labelsTable[nextLabel].windowName

				-- set the label text color
				LabelSetTextColor(windowName, r, g, b)
			end
		end

		-- move to the next label (map type or sos)
		nextLabel = nextLabel + 1

		-- get the item type
		labelTid = labelsTable[nextLabel].tid

		-- flag that indicates if the item is a treasure map or not
		data.isTmap = false

		-- is this NOT an SOS?
		if labelTid ~= 1153568 then -- S-O-S

			-- store the first part of the name
			local mapName = GetStringFromTid(labelTid)

			-- move to the next label (second part of the name)
			nextLabel = nextLabel + 1

			-- get the other part of the name
			labelTid = labelsTable[nextLabel].tid

			-- complete the name
			data.mapName = mapName .. L" " .. GetStringFromTid(labelTid)

			-- get the map level
			local level = table.indexOf(CourseMapWindow.TmapLevelToName, labelTid)

			-- remove the second part of the name to make space
			LabelSetText(labelsTable[nextLabel].windowName, L"") -- clear this label

			-- previous label window name
			local windowName = labelsTable[nextLabel - 1].windowName

			-- write the whole name in the first part (so it will use less space) + the map level
			LabelSetText(windowName, mapName .. L"\n" .. GetStringFromTid(labelTid) .. L" (" .. level .. L")") 

			-- align the text in the middle
			LabelSetTextAlign(windowName, "top")

			-- get the anchors for the label
			local point, relativePoint, relativeTo, xOffs, yOffs = WindowGetAnchor(windowName, 1)

			-- clear the current anchors
			WindowClearAnchors(windowName)

			WindowAddAnchor(windowName, point, relativeTo, relativePoint, xOffs, yOffs - 3)    
			
			-- flag as treasure map
			data.isTmap = true
		end

		-- the next label is: decoded/not or opened/not, or completed
		nextLabel = nextLabel + 1

		-- get the decoded type
		labelTid = labelsTable[nextLabel].tid

		-- is the map completed?
		if labelTid and labelTid == 1153582 then -- Completed

			-- flag as completed
			data.completed = true
		end

		-- add the data to the final table
		table.insert(GumpsParsing.DaviesLockerData, data)

		-- the next label is the first of the next row
		nextLabel = nextLabel + 1
	end
end

function GumpsParsing.JewelryBoxStartSearch()
	
	-- get the text from the search box
	local text = SearchBox.GetFilter("JewelryBoxSearchBox", true)

	-- start the search with the content of the text box
	GumpsParsing.JewelryBoxSearchText(text)
end

GumpsParsing.JewBoxHighlights = {}
function GumpsParsing.JewelryBoxSearchText(text, refilter)
	
	-- do we have a valid text to search?
	if not refilter and not IsValidWString(text) then
		return
	end

	-- make sure the pattern doesn't exist already, if it does, we re-filter instead
	if not refilter and table.contains(SearchBox.Classes.JewelryBox.filtersTable, text) then
		refilter = true
	end
	
	-- do we have to refilter the container?
	if not refilter then

		-- do we have the default "show all" pattern active?
		if table.contains(SearchBox.Classes.JewelryBox.filtersTable, L"*") then

			-- reset the patterns
			SearchBox.Classes.JewelryBox.filtersTable = {}

		else
			-- make the text in lower case for an easier parsing
			text = wstring.lower(text)

			-- add the pattern to the list
			table.insert(SearchBox.Classes.JewelryBox.filtersTable, text)
		end
	end

	-- clear the highlighted items
	GumpsParsing.JewelryBoxRemoveHighlights()

	-- do we have any filter to apply?
	if table.countElements(SearchBox.Classes.JewelryBox.filtersTable) <= 0 then
		return
	end

	-- get all the items in the container
	local AllItems = GenericGump.GetAllItemProperties(GenericGump.JEWELBOX_GUMPID)
	
	-- do we have any item?
	if not AllItems then
		return
	end
	
	-- scan all the items 
	for objectId, prop in pairs(AllItems) do
			
		-- do we have the properties?
		if not prop then
			continue
		end

		-- array that contains all the found properties. If it contains the same amount of items as the patterns, then the item is a perfect match
		local found = {}

		-- scan all properties
		for j, p in pairsByIndex(prop.PropertiesList) do
						
			-- do we have a valid string for the property?
			if IsValidWString(p) then
							
				-- get the property text
				local propText = wstring.lower(p)

				-- is this the first property? (item name)
				if j == 1 then

					-- remove the quantity from the name
					propText = Shopkeeper.stripFirstNumber(p)
				end
							
				-- scan all patterns
				for k, pattText in pairsByIndex(SearchBox.Classes.JewelryBox.filtersTable) do

					-- if we found one on this property we can get out
					if ContainerSearch.DoesPropertyContainText(propText, pattText) then

						-- add the property to the found list
						table.insert(found, propText)

						break
					end
				end
			end

			-- if we have found all the patterns then we can move to the next item
			if #found == #SearchBox.Classes.JewelryBox.filtersTable then
				break
			end
		end

		-- have we found the item?
		if #found == #SearchBox.Classes.JewelryBox.filtersTable then
		
			-- get the button window name
			local _, button = GenericGump.GetButtonIDByItemID(GenericGump.JEWELBOX_GUMPID, objectId)

			-- highlight name
			local highlight = button .. "Highlight"

			-- save the highlight
			GumpsParsing.JewBoxHighlights[highlight] = true

			-- create the highlight for the item
			CreateWindowFromTemplate(highlight, "JewelryBoxAlert", button)
		end
	end
end

function GumpsParsing.JewelryBoxResetSearch()

	-- clear all patterns
	SearchBox.Classes.JewelryBox.filtersTable = {}

	-- clear the highlighted items
	GumpsParsing.JewelryBoxRemoveHighlights()
end

function GumpsParsing.JewelryBoxRemoveHighlights()

	-- find all the highlights we placed
	for window, _ in pairs(GumpsParsing.JewBoxHighlights) do

		-- does the highlight still exit?
		if DoesWindowExist(window) then

			-- remove the highlight
			DestroyWindow(window)
		end

		-- remove the highlight from the table
		GumpsParsing.JewBoxHighlights[window] = nil
	end
end

function GumpsParsing.MapCraftingToolGetFirstCatButton(gumpID)

	-- get the crafting skill name
	local skillName = GumpsParsing.ParsedGumps[gumpID]

	-- scan the tool names table
	for _, data in pairs(CraftingInfo.CraftingToolNames) do

		-- is the this the skill we're looking for?
		if skillName == data.name then
			return data.categoryStartId
		end
	end
end

function GumpsParsing.ToolHasEnhance(skillName)
	
	-- scan the tool names table
	for _, data in pairs(CraftingInfo.CraftingToolNames) do

		-- is the this the skill we're looking for?
		if skillName == data.name then
			return inlineIf(data.hasEnhance, 1, 0)
		end
	end
end

function GumpsParsing.ToolMaterialsCount(skillName)
	
	-- scan the tool names table
	for _, data in pairs(CraftingInfo.CraftingToolNames) do

		-- is the this the skill we're looking for?
		if skillName == data.name then
			return data.totalMaterials
		end
	end
end

function GumpsParsing.ToolGetSelectedCategory(gumpID, data)

	-- get the crafting skill name
	local skillName = GumpsParsing.ParsedGumps[gumpID]

	-- category index
	local categoryId = 0

	-- count the items in the DB missing in the current list
	local missingItems = 0

	-- current list of the items
	local itemsList = {}

	-- pages count
	local page = 1

	-- scan all the labels (we search for the category ID of the first item in the list)
	for id, dt in pairsByKeys(data.Labels) do
		
		-- prev page is the last button label before the first element of the next page
		if dt.tid == 1044044 then -- PREV PAGE
			
			-- increase the page count
			page = page + 1
		end

		-- this label is repeated each page
		if dt.tid == 1044044 or dt.tid == 1044045 then -- PREV PAGE // NEXT PAGE
			continue
		end

		-- item in the category
		if dt.tid == 1114057 then -- ~1_val~

			-- get the raw TID param
			local param = wstring.gsub(dt.tidParms[1], L"#", L"")

			-- get the item TID
			local itemTid = tonumber(param)

			-- add the item to the list
			itemsList[itemTid] = true

			-- is the item missing from the DB?
			if not CraftingInfo.ToolMap[skillName][itemTid] then

				-- send an error to the player to report this problem
				Debug.Print("MISSING ITEM FROM TOOL: " .. skillName .. " REPORT THIS AS BUG!!!")

				-- increase the missing items count
				missingItems = missingItems + 1

				continue
			end
			
			-- is the category id still unknown?
			if categoryId == 0 then

				-- get the first item category
				categoryId = CraftingInfo.ToolMap[skillName][itemTid].category

			-- do we have the category ID but the item doesn't match the category? (we're in last ten)
			-- last ten only have 1 page, so if there is more than 1 is not the last 10 for sure
			elseif page == 1 and categoryId ~= 0 and (CraftingInfo.ToolMap[skillName][itemTid].category ~= categoryId and (CraftingInfo.ToolMap[skillName][itemTid].category2 and CraftingInfo.ToolMap[skillName][itemTid].category2 ~= categoryId)) then
			
				-- we reset the category ID to 0 and get out
				categoryId = 0

				break
			end
		end
	end

	-- do we have a category id? (if there are more than 1 pages is not the last ten category)
	if categoryId ~= 0 and page == 1 then

		-- initialize the counter for the items in this category
		local itemsInThisCategory = 0

		-- scan all the items for this tool to count the one in this category
		for itemTid, itemData in pairs(CraftingInfo.ToolMap[skillName]) do
			
			-- make sure is not the categories count
			if tonumber(itemData) then
				continue
			end

			-- does this item belong to the category we're looking for?
			if itemData.category == categoryId then
			
				-- increase the counter
				itemsInThisCategory = itemsInThisCategory + 1
			end

			-- does this item belong to the category we're looking for? (if the category 1 and 2 are the same they HAVE to stack in the final count)
			if itemData.category2 and itemData.category2 == categoryId then
			
				-- increase the counter
				itemsInThisCategory = itemsInThisCategory + 1
			end
		end
	
		-- does the items in the list are a different amount of the one in the DB? 
		-- (we exclude new items so it won't cause problems)
		if table.countElements(itemsList) ~= itemsInThisCategory + missingItems then
		
			-- now we know it's the last ten category
			categoryId = 0
		end
	end

	-- category counter enabled?
	local startCount = false

	-- counter for the categories
	local countCategories = 0

	-- scan all the labels (now we search for the category label window name)
	for id, dt in pairsByKeys(data.Labels) do

		-- from here we start the count
		if dt.tid == 1044014 then -- LAST TEN

			-- the current category is last 10
			if categoryId == 0 then
				return categoryId, dt.tid, dt.windowName
			end

			-- begin to count
			startCount = true

			continue
		end

		-- each of this elements determine the end of the categories
		if dt.tid == 1114057 or dt.tid == 1061001 or dt.tid == 1044017 or dt.tid == 1044016 or dt.tid == 1112533 or dt.tid == 1112534 then -- ~1_val~ // ENHANCE ITEM // MARK ITEM // SMELT ITEM // NON QUEST ITEM // QUEST ITEM
			break
		end

		-- are we counting the categories now? (and this is not the "SELECTION" label?)
		if startCount and dt.tid ~= 1044011 then -- <CENTER>SELECTIONS</CENTER>

			-- increase the counter
			countCategories = countCategories + 1

			-- is this the selected category?
			if categoryId == countCategories then
				return categoryId, dt.tid, dt.windowName
			end
		end
	end
end

function GumpsParsing.GetCraftingToolItemData(skillName, category, index)

	-- scan all the items for this tool
	for itemTid, itemData in pairs(CraftingInfo.ToolMap[skillName]) do
			
		-- make sure is not the categories count
		if tonumber(itemData) then
			continue
		end

		-- if the current item has the same category and index of the requested item, we found what we were looking for
		if (itemData.category == category or itemData.category2 == category) and (itemData.index == index or itemData.index2 == index) then
			return itemData
		end
	end
end

function GumpsParsing.GetCraftingToolActiveItemData()

	-- get the gump data
	local data = GumpData.Gumps[GenericGump.CRAFTING_ITEM_DETAILS_GUMPID]

	-- do we have the gump data?
	if not data then
		return
	end
	
	-- initialize the item id and materials
	local itemId
	local materials = {}

	-- scan all the labels
	for id, dt in pairsByKeys(data.Labels) do

		-- the first instance is the item TID
		if dt.tid == 1114057 and not itemId then -- ~1_val~

			-- get the raw TID param
			local param = wstring.gsub(dt.tidParms[1], L"#", L"")

			-- store the item ID
			itemId = tonumber(param)

		 -- any other instance of ~1_val~ is a material
		elseif dt.tid == 1114057 then

			-- get the raw TID param
			local param = wstring.gsub(dt.tidParms[1], L"#", L"")

			-- store the material
			materials[tonumber(param)] = true
		end
	end

	return itemId, materials
end

function GumpsParsing.GetCraftingToolItemDetails(itemTid, instance)

	-- get the crafting skill name
	local skillName = GumpsParsing.ParsedGumps[GenericGump.CRAFTING_GUMPID]

	-- if we don't have the skill name, the crafting gump is not open
	if not skillName then
		return
	end

	-- if we don't have the tool map we can't do anything
	if not CraftingInfo.ToolMap[skillName] then
		return
	end

	-- get the current item data
	local itemData = CraftingInfo.ToolMap[skillName][itemTid]

	-- make sure we have the item data
	if not itemData then
		return
	end

	-- flag that we are going to get the details of an items (so the search won't bother us)
	GumpsParsing.CraftingToolAutoDetails = true

	-- get the item page for the instance
	local category = inlineIf(not instance or instance == 1, itemData.category, itemData.category2)

	-- get the item index for the instance
	local itemIndex = inlineIf(not instance or instance == 1, itemData.index, itemData.index2)

	-- get the item page for the instance
	local page = inlineIf(not instance or instance == 1, itemData.page, itemData.page2)

	-- get the categories button start ID
	local startId = GumpsParsing.MapCraftingToolGetFirstCatButton(GenericGump.CRAFTING_GUMPID)

	-- get the number of categories in this tool
	local totalCat = CraftingInfo.ToolMap[skillName].totalCategories

	-- get the offset from the prev/next page button
	local pageBtnOffset = inlineIf(page == 1, 0, ((page - 2) * 2) + 2)

	-- calculate the button ID
	local btnId = startId + totalCat + GumpsParsing.ToolMaterialsCount(skillName) + (itemIndex * 2) + pageBtnOffset + GumpsParsing.ToolHasEnhance(skillName)

	-- are we in the wrong category?
	if GumpsParsing.CraftingToolCurrentCategory ~= category then
		
		-- go to the right category
		GumpsParsing.PressButton(GenericGump.CRAFTING_GUMPID, startId + category)

		-- update the current category
		GumpsParsing.CraftingToolCurrentCategory = category
	end
	
	-- click the item details as soon as the gump is back up
	Interface.ExecuteWhenAvailable({ name = "GetCraftingToolItemDetails", check = function() return GumpsParsing.ParsedGumps[GenericGump.CRAFTING_GUMPID] ~= nil end, callback = function() GumpsParsing.PressButton(GenericGump.CRAFTING_GUMPID, btnId) GumpsParsing.CraftingToolAutoDetails = nil end, maxTime = Interface.TimeSinceLogin + 1, delay = Interface.TimeSinceLogin + 0.5, removeOnComplete = true })
end

function GumpsParsing.GetCraftingToolItemDetailsByIndex(itemIndex)

	-- get the crafting skill name
	local skillName = GumpsParsing.ParsedGumps[GenericGump.CRAFTING_GUMPID]

	-- if we don't have the skill name, the crafting gump is not open
	if not skillName then
		return
	end

	-- if we don't have the tool map we can't do anything
	if not CraftingInfo.ToolMap[skillName] then
		return
	end

	-- get the categories button start ID
	local startId = GumpsParsing.MapCraftingToolGetFirstCatButton(GenericGump.CRAFTING_GUMPID)

	-- get the number of categories in this tool
	local totalCat = CraftingInfo.ToolMap[skillName].totalCategories

	-- determine the item page index
	local page = math.max(math.ceil(itemIndex / 10), 1)

	-- get the offset from the prev/next page button
	local pageBtnOffset = inlineIf(page == 1, 0, ((page - 2) * 2) + 2)

	-- calculate the button ID
	local btnId = startId + totalCat + GumpsParsing.ToolMaterialsCount(skillName) + (itemIndex * 2) + pageBtnOffset + GumpsParsing.ToolHasEnhance(skillName)

	-- click the item details
	GumpsParsing.PressButton(GenericGump.CRAFTING_GUMPID, btnId)
end

function GumpsParsing.GetCraftingToolHighlightItem(itemTid, instance)

	-- get the crafting skill name
	local skillName = GumpsParsing.ParsedGumps[GenericGump.CRAFTING_GUMPID]

	-- if we don't have the skill name, the crafting gump is not open
	if not skillName then
		return
	end

	-- if we don't have the tool map we can't do anything
	if not CraftingInfo.ToolMap[skillName] then
		return
	end

	-- get the current item data
	local itemData = CraftingInfo.ToolMap[skillName][itemTid]

	-- make sure we have the item data
	if not itemData then
		return
	end

	-- get the item page for the instance
	local category = inlineIf(not instance or instance == 1, itemData.category, itemData.category2)

	-- get the item page for the instance
	local page = inlineIf(not instance or instance == 1, itemData.page, itemData.page2)

	-- get the categories button start ID
	local startId = GumpsParsing.MapCraftingToolGetFirstCatButton(GenericGump.CRAFTING_GUMPID)

	-- flag that indicates if we changed category
	local categoryChange = false

	-- are we in the wrong category?
	if GumpsParsing.CraftingToolCurrentCategory ~= category then
		
		-- go to the right category
		GumpsParsing.PressButton(GenericGump.CRAFTING_GUMPID, startId + category)

		-- update the current category
		GumpsParsing.CraftingToolCurrentCategory = category

		-- flag that we changed category
		categoryChange =  true
	end

	-- has the category changed?
	if categoryChange then

		-- if the item is in page 1 we just highlight it
		if page == 1 then

			-- highlight the item as soon as the gump is back up
			Interface.ExecuteWhenAvailable({ name = "CraftingToolItemHighlight", check = function() return GumpsParsing.ParsedGumps[GenericGump.CRAFTING_GUMPID] ~= nil end, callback = function() GumpsParsing.CraftingToolHighlightItemByTid(itemTid, instance) end, maxTime = Interface.TimeSinceLogin + 1, delay = Interface.TimeSinceLogin + 0.5, removeOnComplete = true })
		end

	-- the category has NOT changed and we are in the right page?
	elseif GumpsParsing.CraftingToolCurrentPage == page then
		
		-- highlight the item
		GumpsParsing.CraftingToolHighlightItemByTid(itemTid, instance)

	else -- category unchanged and wrong page

		-- get the number of categories in this tool
		local totalCat = CraftingInfo.ToolMap[skillName].totalCategories

		-- get the offset from the next page button
		local pageBtnOffset = 0

		-- each page of the gump has 2 button: next and prev
		-- pressing the button next on page 3, will take us to page 4 (even if we are at page 1). 

		-- is the button in a next page?
		if itemData.page > GumpsParsing.CraftingToolCurrentPage then

			-- calculate the next page button offset
			pageBtnOffset = (20 * (itemData.page - 1)) + (1 + ((itemData.page - 2) * 2)) 

			-- calculate the button ID
			local btnId = startId + totalCat + GumpsParsing.ToolMaterialsCount(skillName) + GumpsParsing.ToolHasEnhance(skillName) + pageBtnOffset

			-- change page
			GumpsParsing.PressButton(GenericGump.CRAFTING_GUMPID, btnId)

			-- update the current page index
			GumpsParsing.CraftingToolCurrentPage = itemData.page

			-- highlight the item
			GumpsParsing.CraftingToolHighlightItemByTid(itemTid, instance)

		-- the button is in a previous page
		elseif itemData.page < GumpsParsing.CraftingToolCurrentPage then

			-- going back is not as easy as going forward...
			-- in theory we should go 1 page forward of the item page and press prev. 
			-- But since we don't know if there is a next page, we press the prev button until we get to the item page.
			while GumpsParsing.CraftingToolCurrentPage > itemData.page do

				-- calculate the prev page button offset (in the current page)
				pageBtnOffset = (20 * (GumpsParsing.CraftingToolCurrentPage - 1)) + (1 + ((GumpsParsing.CraftingToolCurrentPage - 2) * 2)) + 1

				-- calculate the button ID
				local btnId = startId + totalCat + GumpsParsing.ToolMaterialsCount(skillName) + GumpsParsing.ToolHasEnhance(skillName) + pageBtnOffset

				-- change page
				GumpsParsing.PressButton(GenericGump.CRAFTING_GUMPID, btnId)

				-- update the current page index
				GumpsParsing.CraftingToolCurrentPage = GumpsParsing.CraftingToolCurrentPage - 1
			end

			-- highlight the item
			GumpsParsing.CraftingToolHighlightItemByTid(itemTid, instance)
		end
	end
end

function GumpsParsing.CraftingToolHighlightItemByTid(itemTid, instance)

	-- get the item data
	local itemData = CraftingInfo.ToolMap[GumpsParsing.LastTool][itemTid]

	-- get the item page based on the instance
	local itemPage = inlineIf(not instance or instance == 1, itemData.page, itemData.page2)

	-- page index
	local page = 1

	-- scan all the labels
	for id, dt in pairsByKeys(GumpData.Gumps[GenericGump.CRAFTING_GUMPID].Labels) do
		
		-- prev page is the last button label before the first element of the next page
		if dt.tid == 1044044 then -- PREV PAGE
			
			-- increase the page count
			page = page + 1
		end

		-- this label is repeated each page
		if dt.tid == 1044044 or dt.tid == 1044045 then -- PREV PAGE // NEXT PAGE
			continue
		end

		-- is the item we're looking for in this page?
		if page ~= itemPage then
			continue
		end

		-- item in the category
		if dt.tid == 1114057 then -- ~1_val~

			-- get the raw TID param
			local param = wstring.gsub(dt.tidParms[1], L"#", L"")

			-- get the item TID
			local currItemTid = tonumber(param)

			-- is this the item we're looking for?
			if currItemTid == itemTid then

				-- highlight the item
				GumpsParsing.CraftingToolHighlightItem(dt.windowName)

				return
			end
		end
	end
end

function GumpsParsing.CraftingToolHighlightItem(windowName)

	-- do we have an highlighted label?
	if IsValidString(GumpsParsing.CraftingToolHighlightedLabel) and DoesWindowExist(GumpsParsing.CraftingToolHighlightedLabel) then
		
		-- remove the highlight
		LabelSetTextColor(GumpsParsing.CraftingToolHighlightedLabel, 255, 255, 255)
	end

	-- store the new highlighted label
	GumpsParsing.CraftingToolHighlightedLabel = windowName

	-- do we have an highlighted label now?
	if IsValidString(GumpsParsing.CraftingToolHighlightedLabel) and DoesWindowExist(GumpsParsing.CraftingToolHighlightedLabel) then
		
		-- highlight the label
		LabelSetTextColor(GumpsParsing.CraftingToolHighlightedLabel, GenericGump.HighlightColor.r, GenericGump.HighlightColor.g, GenericGump.HighlightColor.b)
	end
end

function GumpsParsing.CraftingToolSearchNext(gumpReloaded)

	-- get the text from the search box
	local text = SearchBox.GetFilter("CraftingToolSearchBox", true)

	-- is the tool or the search pattern changed?
	if (GumpsParsing.LastTool and GumpsParsing.LastTool ~= GumpsParsing.ParsedGumps[GenericGump.CRAFTING_GUMPID]) or (GumpsParsing.CraftingToolLastSearch and GumpsParsing.CraftingToolLastSearch ~= text) then

		-- reset the results
		GumpsParsing.SearchResults = nil
	end
	
	-- we still have no search results?
	if not GumpsParsing.SearchResults then
	
		-- do nothing if we don't have a valid search text
		if not IsValidWString(text) then
			return
		end

		-- store the search text
		GumpsParsing.CraftingToolLastSearch = text
	
		-- store the current tool skill
		GumpsParsing.LastTool = GumpsParsing.ParsedGumps[GenericGump.CRAFTING_GUMPID]

		-- get the sorted list of items in this tool
		local sortedItems = GumpsParsing.CraftingToolSortItems(GumpsParsing.LastTool)

		-- initialize the search results table
		GumpsParsing.SearchResults = {}

		-- make sure we have the items data for this tool
		if CraftingInfo.ToolMap[GumpsParsing.LastTool] then

			-- we cycle all the categories
			for catId = 1, CraftingInfo.ToolMap[GumpsParsing.LastTool].totalCategories do

				-- we scan the items again so we can make a list sorted by category
				for _, itemTid in pairsByIndex(sortedItems[catId]) do

					-- is this item NOT inside the table and the name match our search?
					if not table.contains(GumpsParsing.SearchResults, itemTid) and wstring.find(wstring.lower(GetStringFromTid(itemTid)), text, 1, true) then

						-- add the item to the search results
						table.insert(GumpsParsing.SearchResults, itemTid)
					end
				end
			end
		end

		-- do we have any results?
		if #GumpsParsing.SearchResults > 0 then

			-- set the first result to show as the first one
			GumpsParsing.SearchResultsID = 1
		end
	end

	-- is NOT the gump being reloaded and we have results?
	if not gumpReloaded and GumpsParsing.SearchResults and #GumpsParsing.SearchResults > 0 then
		
		-- move to the next result
		GumpsParsing.SearchResultsID = GumpsParsing.SearchResultsID + 1

		-- is this the last result?
		if GumpsParsing.SearchResultsID > #GumpsParsing.SearchResults then

			-- set the first result to show as the first one
			GumpsParsing.SearchResultsID = 1
		end
	end

	-- do we have the search results?
	if GumpsParsing.SearchResults and #GumpsParsing.SearchResults > 0 then

		-- current item TID
		local currItem = GumpsParsing.SearchResults[GumpsParsing.SearchResultsID]

		-- get the previous item (if there is one)
		local prevItem = inlineIf(GumpsParsing.SearchResultsID > 1, GumpsParsing.SearchResults[GumpsParsing.SearchResultsID - 1])
		
		-- move to highlight the next item (or the second instance of it)
		GumpsParsing.GetCraftingToolHighlightItem(currItem, inlineIf(currItem == prevItem, 2, 1))
	end
end

function GumpsParsing.CraftingToolSearchReset()

	-- reset the textobx text
	TextEditBoxSetText("CraftingToolSearchBoxFilter", L"")

	-- remove the highlight
	GumpsParsing.CraftingToolHighlightItem()

	-- remove the search text
	GumpsParsing.CraftingToolLastSearch = nil

	-- remove the tool name
	GumpsParsing.LastTool = nil

	-- remove the search results
	GumpsParsing.SearchResults = nil

	-- remove the current highlighted search result ID
	GumpsParsing.SearchResultsID = nil
end

function GumpsParsing.CraftingToolSortItems(skillName)

	-- make sure we have the skill name
	if not skillName then
		return
	end

	-- table with the items sorted by category (USED TO MAP THE TOOLS ONLY)
	local sortedItems = {}

	-- scan all the items for this tool (to sort them by category)
	for itemTid, data in pairs(CraftingInfo.ToolMap[skillName]) do
		
		-- make sure is not the categories count
		if tonumber(data) then
			continue
		end

		-- initialize the table for the category if it doesn't exist
		if not sortedItems[data.category] then
			sortedItems[data.category] = {}
		end

		-- add the item inside its category table
		sortedItems[data.category][data.index] = itemTid

		-- does the item have multiple instances?
		if data.category2 then

			-- initialize the table for the other category if it doesn't exist
			if not sortedItems[data.category2] then
				sortedItems[data.category2] = {}
			end
	
			-- add the second item instance inside its category table
			sortedItems[data.category2][data.index2] = itemTid
		end
	end

	return sortedItems
end

function GumpsParsing.CraftingToolScanMissingRecipes()

	-- get the crafting skill name
	local skillName = GumpsParsing.ParsedGumps[GenericGump.CRAFTING_GUMPID]

	-- table with the items sorted by category (USED TO MAP THE TOOLS ONLY)
	allItems = GumpsParsing.CraftingToolSortItems(skillName)

	-- initialize the table with all the items with a recipe
	GumpsParsing.RecipesItems = {}

	-- scan all the categories
	for catId, items in pairsByIndex(allItems) do

		-- scan all the items in the category
		for idx, itemTid in pairsByIndex(items) do

			-- get the item data from the DB
			local itemData = CraftingInfo.ToolMap[skillName][itemTid]

			-- does this item has a recipe?
			if itemData.recipe then

				-- add the item to the list of the items to scan
				table.insert(GumpsParsing.RecipesItems, itemTid)
			end
		end
	end

	-- index of the item that we are scanning in the current category 
	GumpsParsing.ScanItems = 0

	-- initialize the table for all the missing recipes
	GumpsParsing.MissingRecipes = {}

	-- check the next ercipe
	GumpsParsing.CraftingToolItemsCheckNextRecipe()
end

function GumpsParsing.CraftingToolItemsCheckNextRecipe()

	-- increase the ID of the item to scan
	GumpsParsing.ScanItems = GumpsParsing.ScanItems + 1

	-- do we have the item for this index?
	if GumpsParsing.RecipesItems[GumpsParsing.ScanItems] then

		-- flag that indicates we are scanning for recipes
		GumpsParsing.ScanForRecipes = true

		-- open the item details (we don't care about the second instance, since it's the same item, we check only once)
		GumpsParsing.GetCraftingToolItemDetails(GumpsParsing.RecipesItems[GumpsParsing.ScanItems], 1)

	else -- no more items

		-- disable the window until the process is completed
		WindowSetHandleInput(GumpData.Gumps[GenericGump.CRAFTING_GUMPID].windowName, true)

		-- show the missing recipes list
		GumpsParsing.CraftingToolItemsShowMissingRecipes()

		-- remove the list of all the missing recipes
		GumpsParsing.MissingRecipes = nil

		-- remove the item list
		GumpsParsing.RecipesItems = nil

		-- remove the item index
		GumpsParsing.ScanItems = nil

		-- remove the scan recipe flag
		GumpsParsing.ScanForRecipes = nil

		-- remove the warning message
		LabelSetText("CraftingToolWarning", L"")

		-- get the categories button start ID
		local startId = GumpsParsing.MapCraftingToolGetFirstCatButton(GenericGump.CRAFTING_GUMPID)

		-- go to the first category and the scan will begin!
		GumpsParsing.PressButton(GenericGump.CRAFTING_GUMPID, startId + 1)
	end
end

function GumpsParsing.CraftingToolItemsShowMissingRecipes()

	-- do we have missing recipes?
	if table.countElements(GumpsParsing.MissingRecipes) <= 0 then

		-- notify the player that there are no missing recipes
		ChatPrint(GetStringFromTid(152), 1)

		return
	end

	-- add a separator
	ChatPrint(L"------MISSING RECIPES-------", 1)
	
	-- scan all the missing recipes
	for itemTid, _ in pairs(GumpsParsing.MissingRecipes) do

		-- print the item name
		ChatPrint(L"- " .. FormatProperly(GetStringFromTid(itemTid)), 1)
	end

	-- add a separator
	ChatPrint(L"-------TOTAL: " .. table.countElements(GumpsParsing.MissingRecipes) .. L"-------", 1)
end

function GumpsParsing.CraftingToolScanMissingRecipesTooltip()

	-- show the tooltip for the recipes scan button
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(142))
end

function GumpsParsing.CraftingToolRebuildToolData()

	-- set the tool scan active
	GumpsParsing.MapCraftingToolActive = true
	
	-- get the categories button start ID
	local startId = GumpsParsing.MapCraftingToolGetFirstCatButton(GenericGump.CRAFTING_GUMPID)

	-- go to the first category and the scan will begin!
	GumpsParsing.PressButton(GenericGump.CRAFTING_GUMPID, startId + 1)
end

function GumpsParsing.CraftingToolRebuildToolDataTooltip()

	-- show the tooltip for the rebuild tool data button
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(614))
end

function GumpsParsing.CraftingToolGetToolRequired(itemTid)

	-- special descriptions for items like Ingots
	if CraftingInfo.MaterialToSkill[itemTid] then
		return CraftingInfo.MaterialToSkill[itemTid]
	end

	-- does the material uses a different name from the crafting item?
	itemTid = inlineIf(CraftingInfo.CraftingToolMaterialTidsConversion[itemTid], CraftingInfo.CraftingToolMaterialTidsConversion[itemTid], itemTid)
	
	-- get the item name in string (some materials have a different TID)
	local itemName = wstring.trim(wstring.lower(GetStringFromTid(itemTid)))
	
	-- scan all the tools to search by TID
	for skillName, items in pairs(CraftingInfo.ToolMap) do
		
		-- scan all the items
		for tid, data in pairs(items) do
			
			-- make sure is not the categories count
			if tonumber(data) then
				continue
			end
	
			-- is this the item we're looking for?
			if itemTid == tid then

				-- the best instance is the one with less materials types required
				local bestInstance = inlineIf(data.materials2 and #data.materials2 < #data.materials, 2, 1)

				return GumpsParsing.CraftingToolToolTypeToSkill(skillName), tid, bestInstance, skillName
			end
		end
	end

	-- scan all the tools again to search by string
	for skillName, items in pairs(CraftingInfo.ToolMap) do

		-- scan all the items
		for tid, data in pairs(items) do
			
			-- make sure is not the categories count
			if tonumber(data) then
				continue
			end

			-- get the current item name
			local currItem = wstring.trim(wstring.lower(GetStringFromTid(tid)))

			-- is this the item we're looking for?
			if currItem == itemName then

				-- the best instance is the one with less materials types required
				local bestInstance = inlineIf(data.materials2 and #data.materials2 < #data.materials, 2, 1)

				return GumpsParsing.CraftingToolToolTypeToSkill(skillName), tid, bestInstance, skillName
			end
		end
	end
end

function GumpsParsing.CraftingToolToolTypeToSkill(skillName)

	-- scan the tool names table
	for _, data in pairs(CraftingInfo.CraftingToolNames) do

		-- is the this the skill we're looking for?
		if skillName == data.name then
			return data.skillTID
		end
	end
end

function GumpsParsing.CraftingToolToolCheckTool(itemId)

	-- get the object type
	local objectType = GetItemType(itemId)

	-- scan the tool names
	for skillTid, data in pairs(CraftingInfo.CraftingToolNames) do

		-- is this the skill for the item we are checking?
		if table.contains(CraftingInfo.Tools[data.skillTID], objectType) then
			return skillTid
		end
	end
end

-- ==========================================================================
-- |	CRAFTING TOOL MAPPING TOOLS !!! (USE IN DEBUG MODE ONLY!!!)
-- ==========================================================================
function GumpsParsing.GetCraftingToolItemData()

	-- get the crafting skill name
	local skillName = GumpsParsing.ParsedGumps[GenericGump.CRAFTING_ITEM_DETAILS_GUMPID]

	-- get the gump data
	local data = GumpData.Gumps[GenericGump.CRAFTING_ITEM_DETAILS_GUMPID]

	-- initialize the item TID variable
	local itemTid

	-- initialize the materials table
	local materials = {}

	-- initialize the skills table
	local skills = {}

	-- flag that indicates if the item requires a recipe
	local recipe

	-- expansion required flags
	local requiresToL
	local requiresSA
	local requiresHS
	local requiresRustic
	local requiresGothic

	-- flag that indicates if the item retains the material color
	local retainsColor

	-- index of the material
	local matInstance = 0

	-- index of the skill
	local skillInstance = 0

	-- scan all the labels (now we search for the category label window name)
	for id, dt in pairsByKeys(data.Labels) do

		-- is this a skill?
		if GetSkillIDByTID(dt.tid) >= 0 then
		
			-- increase the skill index
			skillInstance = skillInstance + 1

			-- get the skill requirement
			local skillReq = tonumber(data.LabelsText[skillInstance])

			-- store the skill requirement
			skills[dt.tid] = skillReq
			
		-- check for the required expansion
		elseif dt.tid == 1094732 then -- * Requires the "Stygian Abyss" expansion
			requiresSA = true

		elseif dt.tid == 1116296 then -- * Requires the "High Seas" booster
			requiresHS = true

		elseif dt.tid == 1150650 then -- * Requires the "Gothic" theme pack
			requiresGothic = true

		elseif dt.tid == 1150651 then -- * Requires the "Rustic" theme pack
			requiresRustic = true

		elseif dt.tid == 1155876 or dt.tid == 1156140 then -- * Requires the "Time of Legends" expansion.
			requiresToL = true

		-- does this item requires a recipe?
		elseif dt.tid == 1073620 then -- You have not learned this recipe.

			-- flag that this item requires a recipe
			recipe = true

		-- does this item retains the material color?
		elseif dt.tid == 1044152 then -- * The item retains the color of this material
			
			-- flag that this item retains the material color
			retainsColor = true

		-- item or material
		elseif dt.tid == 1114057 then -- ~1_val~

			-- get the raw TID param
			local param = wstring.gsub(dt.tidParms[1], L"#", L"")

			-- the first instance is the item TID
			if not itemTid then

				-- get the item TID
				itemTid = tonumber(param)

			else -- any other instance of ~1_val~ is a material

				-- get the material TID
				local matTid = tonumber(param)

				-- increase the materials count
				matInstance = matInstance + 1

				-- count the materials amount in the labels texts
				local countInstance = 0

				-- scan the label text
				for _, text in pairsByKeys(data.LabelsText) do

					-- if it contains the html tag: <basefont color .. is a material amount
					if wstring.find(text, L"basefont color", 1, true) then

						-- increase the current material amount instance
						countInstance = countInstance + 1

						-- does this material amount has the same index of the material?
						if countInstance == matInstance then
							
							-- get the material amount
							local amount = tonumber(WindowUtils.translateMarkup(text))

							-- store the amount in the materials table
							materials[matTid] = amount

							break
						end
					end
				end
			end
		end
	end

	-- did we find the item?
	if itemTid then

		-- is the category of the item correct and we don't have the materials yet?
		if CraftingInfo.ToolMap[skillName][itemTid].category == GumpsParsing.CraftingToolCurrentCategory and not CraftingInfo.ToolMap[skillName][itemTid].materials then

			-- store the materials table
			CraftingInfo.ToolMap[skillName][itemTid].materials = table.copy(materials)

			-- store the skills table
			CraftingInfo.ToolMap[skillName][itemTid].skills = table.copy(skills)

		 -- it must be another instance of the item
		elseif CraftingInfo.ToolMap[skillName][itemTid].category2 == GumpsParsing.CraftingToolCurrentCategory and not CraftingInfo.ToolMap[skillName][itemTid].materials2 then

			-- store the materials table
			CraftingInfo.ToolMap[skillName][itemTid].materials2 = table.copy(materials)

			-- store the skills table
			CraftingInfo.ToolMap[skillName][itemTid].skills2 = table.copy(skills)
		end

		-- store the recipe flag
		CraftingInfo.ToolMap[skillName][itemTid].recipe			= recipe

		-- store the retains color flag
		CraftingInfo.ToolMap[skillName][itemTid].retainsColor	= retainsColor

		-- store the required expansion flag
		CraftingInfo.ToolMap[skillName][itemTid].requiresToL	= requiresToL
		CraftingInfo.ToolMap[skillName][itemTid].requiresSA		= requiresSA
		CraftingInfo.ToolMap[skillName][itemTid].requiresHS		= requiresHS
		CraftingInfo.ToolMap[skillName][itemTid].requiresRustic	= requiresRustic
		CraftingInfo.ToolMap[skillName][itemTid].requiresGothic	= requiresGothic
	end

	-- click the back button
	GumpsParsing.PressButton(GenericGump.CRAFTING_ITEM_DETAILS_GUMPID, 1)
end

-- USE TO STORE ALL THE ITEMS INFO FOR THE CURRENT TOOL
function GumpsParsing.MapCraftingToolItems()
	
	-- get the crafting skill name
	local skillName = GumpsParsing.ParsedGumps[GenericGump.CRAFTING_GUMPID]

	-- table with the items sorted by category (USED TO MAP THE TOOLS ONLY)
	GumpsParsing.SortedItems = GumpsParsing.CraftingToolSortItems(skillName)

	-- index of the item that we are scanning in the current category 
	GumpsParsing.ScanItems = 0

	-- index of the category that we are scanning
	GumpsParsing.ScanCategory = 0

	-- start the gathering process
	GumpsParsing.MapCraftingToolItemsGetNextItem()
end

function GumpsParsing.MapCraftingToolItemsGetNextItem()
	
	-- get the crafting skill name
	local skillName = GumpsParsing.ParsedGumps[GenericGump.CRAFTING_GUMPID]

	-- increase the current item index
	GumpsParsing.ScanItems = GumpsParsing.ScanItems + 1

	-- if the current item is higher than the max, we move to the next category
	if not GumpsParsing.SortedItems[GumpsParsing.ScanCategory] or GumpsParsing.ScanItems > #GumpsParsing.SortedItems[GumpsParsing.ScanCategory] then

		-- increase the category counter
		GumpsParsing.ScanCategory = GumpsParsing.ScanCategory + 1

		-- restart with the items from 1
		GumpsParsing.ScanItems = 1
	end

	-- if the category is higher than the max, we reached the end of the line
	if GumpsParsing.ScanCategory > #GumpsParsing.SortedItems then

		-- remove the index variables
		GumpsParsing.ScanItems = nil
		GumpsParsing.ScanCategory = nil

		-- remove the sorted table
		GumpsParsing.SortedItems = nil

		-- remove the flag to log the next item
		GumpsParsing.getItemData = nil

		-- warn that the export is completed
		Debug.Print("ITEM DATA EXPORT COMPLETED!")

		-- get the categories button start ID
		local startId = GumpsParsing.MapCraftingToolGetFirstCatButton(GenericGump.CRAFTING_GUMPID)

		-- go to the first category to reload the tool
		GumpsParsing.PressButton(GenericGump.CRAFTING_GUMPID, startId + 1)

		return -- job is done
	end

	-- update the export status
	Debug.Print("CATEGORY " .. GumpsParsing.ScanCategory .. "/" .. #GumpsParsing.SortedItems .. " - ITEM " .. GumpsParsing.ScanItems .. "/" .. #GumpsParsing.SortedItems[GumpsParsing.ScanCategory])

	-- flag that indicates that we need to get the item data
	GumpsParsing.getItemData = true
	
	-- get the item TID
	local itemTid = GumpsParsing.SortedItems[GumpsParsing.ScanCategory][GumpsParsing.ScanItems]

	-- get the item data from the DB
	local itemData = CraftingInfo.ToolMap[skillName][itemTid]

	-- determine the item instance
	local instance = inlineIf(itemData.index == GumpsParsing.ScanItems and itemData.category == GumpsParsing.ScanCategory, 1, 2)

	-- open the item details
	GumpsParsing.GetCraftingToolItemDetails(itemTid, instance)
end

function GumpsParsing.MapCraftingTool(gumpID, data)

	-- get the crafting skill name
	local skillName = GumpsParsing.ParsedGumps[gumpID]

	-- if we don't have the skill name, the crafting gump is not open
	if not skillName then
		return
	end

	-- is the tool map not available yet?
	if not CraftingInfo.ToolMap then
		
		-- initialize the tool map
		CraftingInfo.ToolMap = {}
	end

	-- is the tool map not available yet?
	if not CraftingInfo.ToolMap[skillName] then
		
		-- initialize the tool map
		CraftingInfo.ToolMap[skillName] = {}

		-- reset the categories count
		GumpsParsing.ToolTotalCategories = 0

		-- category counter enabled?
		local startCount = false

		-- scan all the labels
		for id, dt in pairsByKeys(data.Labels) do

			-- from here we start the count
			if dt.tid == 1044014 then -- LAST TEN
				startCount = true
				continue
			end

			-- each of this elements determine the end of the categories
			if dt.tid == 1114057 or dt.tid == 1061001 or dt.tid == 1044017 or dt.tid == 1044016 or dt.tid == 1112533 or dt.tid == 1112534 then -- ~1_val~ // ENHANCE ITEM // MARK ITEM // SMELT ITEM // NON QUEST ITEM // QUEST ITEM
				break
			end

			-- are we counting the categories now? (and this is not the "SELECTION" label?)
			if startCount and dt.tid ~= 1044011 then -- <CENTER>SELECTIONS</CENTER>

				-- increase the counter
				GumpsParsing.ToolTotalCategories = GumpsParsing.ToolTotalCategories + 1
			end
		end

		-- store the total amount of categories in the tool
		CraftingInfo.ToolMap[skillName].totalCategories = GumpsParsing.ToolTotalCategories
	end
	
	-- show where we are with the export
	Debug.Print("Exported category " .. GumpsParsing.ToolCategory .. "/" .. GumpsParsing.ToolTotalCategories)

	-- initialize the items page ID
	local page = 1

	-- index of the item in the list
	local itemIndex = 1

	-- scan all the labels
	for id, dt in pairsByKeys(data.Labels) do
		
		-- prev page is the last button label before the first element of the next page
		if dt.tid == 1044044 then -- PREV PAGE
			
			-- increase the page count
			page = page + 1
		end

		-- this label is repeated each page
		if dt.tid == 1044044 or dt.tid == 1044045 then -- PREV PAGE // NEXT PAGE
			continue
		end

		-- item in the category
		if dt.tid == 1114057 then -- ~1_val~

			-- get the raw TID param
			local param = wstring.gsub(dt.tidParms[1], L"#", L"")

			-- get the item TID
			local itemTid = tonumber(param)
			
			-- is this a new item?
			if not CraftingInfo.ToolMap[skillName][itemTid] then
				
				-- store the item data into the table
				CraftingInfo.ToolMap[skillName][itemTid] = { index = itemIndex, category = GumpsParsing.ToolCategory, page = page }

			else -- this is a second instance of the same item (in another category probably)

				-- store the new instance location
				CraftingInfo.ToolMap[skillName][itemTid].index2 = itemIndex
				CraftingInfo.ToolMap[skillName][itemTid].category2 = GumpsParsing.ToolCategory
				CraftingInfo.ToolMap[skillName][itemTid].page2 = page
			end

			-- increase the item index
			itemIndex = itemIndex + 1
		end
	end

	-- did we reach the last category?
	if GumpsParsing.ToolCategory == GumpsParsing.ToolTotalCategories then

		-- update on the export status
		Debug.Print("EXPORT TOOL COMPLETED!")
		Debug.Print("BEGIN EXPORTING THE ITEMS DATA...")

		-- export the items data now
		GumpsParsing.MapCraftingToolItems()

		return
	end

	-- move to the next category
	GumpsParsing.ToolCategory = GumpsParsing.ToolCategory + 1

	-- run the mapping tool again when the gump re-opens in the new category
	GumpsParsing.MapCraftingToolContinue = true

	-- move to the first category
	GumpsParsing.PressButton(gumpID, GumpsParsing.CraftingCategoryButtonStartId + GumpsParsing.ToolCategory)
end