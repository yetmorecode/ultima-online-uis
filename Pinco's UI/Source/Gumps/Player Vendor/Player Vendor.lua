----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

PlayerVendor = {}

PlayerVendor.GumpID = 683
PlayerVendor.CustomizeGumpID = 999014

PlayerVendor.MobileId = 0

PlayerVendor.PaperdollOpen = false

PlayerVendor.TextEntryRequest = false

PlayerVendor.VendorGenderMale = false
PlayerVendor.VendorRaceHuman = false

PlayerVendor.VendorGold = 0

----------------------------------------------------------------
-- PlayerVendor Functions
----------------------------------------------------------------

function PlayerVendor.Initialize()
	
	-- player vendor window name
	local mainWindow = "PlayerVendor"

	-- set the window to be destroyed on close
	Interface.DestroyWindowOnClose[mainWindow] = true

	-- restore the window position
	WindowUtils.RestoreWindowPosition(mainWindow)

	-- shop name label
	LabelSetText(mainWindow .. "MainShopNameLabel", GetStringFromTid(1150332)) -- Shop Name:

	-- vendor name label
	LabelSetText(mainWindow .. "MainVendorNameLabel", GetStringFromTid(1062508)) -- Vendor Name:

	-- player gold label
	LabelSetText(mainWindow .. "MainPlayerGoldLabel", GetStringFromTid(326))

	-- player insurance label
	LabelSetText(mainWindow .. "MainPlayerInsuranceLabel", GetStringFromTid(327))

	-- are we on a siege rules shard?
	if Interface.SiegeRules then

		-- gray out text
		LabelSetTextColor(mainWindow .. "MainPlayerGoldLabel", 125, 125, 125)
		LabelSetTextColor(mainWindow .. "MainPlayerInsuranceLabel", 125, 125, 125)
	end

	-- vendor gold label
	LabelSetText(mainWindow .. "MainVendorGoldLabel", GetStringFromTid(329))

	-- vendor cost label
	LabelSetText(mainWindow .. "MainVendorCostLabel", GetStringFromTid(330))

	-- dismiss vendor label
	LabelSetText(mainWindow .. "MainDismissVendor", GetStringFromTid(1071987)) -- Dismiss Vendor

	-- vendor gender label
	LabelSetText(mainWindow .. "SecondaryVendorGenderLabel", GetStringFromTid(3000120) .. L": ") -- Gender:

	-- vendor race label
	LabelSetText(mainWindow .. "SecondaryVendorRaceLabel", GetStringFromTid(1077827) .. L": ") -- Race:

	-- vendor hair label
	LabelSetText(mainWindow .. "SecondaryVendorHairLabel", GetStringFromTid(1011395))  -- Hair

	-- vendor beard label
	LabelSetText(mainWindow .. "SecondaryVendorBeardLabel", GetStringFromTid(1116653))  -- Beard

	-- draw the bottle image for beards
	EquipmentData.DrawObjectIcon(3623, 0, mainWindow .. "SecondaryVendorHairHue", 0, 0, 1) -- bottle image

	-- draw the bottle image for beards
	EquipmentData.DrawObjectIcon(3623, 0, mainWindow .. "SecondaryVendorBeardHue", 0, 0, 1) -- bottle image

	-- fill the window data
	PlayerVendor.RefreshWindow()
end

function PlayerVendor.Shutdown()

	-- close the layer vendor gump
	GumpsParsing.DestroyGump(PlayerVendor.GumpID)

	-- close the paperdoll
	if DoesWindowExist("PaperdollWindow" .. PlayerVendor.MobileId) then
		DestroyWindow("PaperdollWindow" .. PlayerVendor.MobileId)
	end

	-- reset the mobile ID
	PlayerVendor.MobileId = 0

	-- reset the text entry request flag
	PlayerVendor.TextEntryRequest = false

	-- save the window position
	WindowUtils.SaveWindowPosition("PlayerVendor")
end

function PlayerVendor.RefreshWindow()

	-- player vendor window name
	local mainWindow = "PlayerVendor"
	
	-- update the vendor image
	PlayerVendor.UpdatePicture()

	-- update shop name
	PlayerVendor.UpdateShopName()

	-- update vendor name
	PlayerVendor.UpdateVendorName()

	-- update auction status
	PlayerVendor.UpdateAuctionStatus()

	-- request the bank gold update
	CharacterSheet.NextBankGoldUpdate = 0

	-- update the player gold
	PlayerVendor.UpdatePlayerGold()

	-- initialize the gender text for the label
	local genderText = GetStringFromTid(3000119) -- Female

	-- finalize the gender text with male or female accordingly
	if PlayerVendor.VendorGenderMale then
		genderText = GetStringFromTid(3000118)  -- Male
	end
	
	-- update gender
	LabelSetText(mainWindow .. "SecondaryVendorGenderText", genderText)

	-- initialize the race text for the label
	local raceText = GetStringFromTid(1072256)  -- Elf

	-- finalize the race text with male or female accordingly
	if PlayerVendor.VendorRaceHuman then
		raceText =  GetStringFromTid(1072255) -- Human
	end
	
	-- update race
	LabelSetText(mainWindow .. "SecondaryVendorRaceText", raceText)

	-- human hair/beard list
	if PlayerVendor.VendorRaceHuman then

		-- humans have 1 more type of hairs
		WindowSetShowing(mainWindow .. "SecondaryTwoTails", true)

		-- enable beard for males
		WindowSetShowing(mainWindow .. "SecondaryVendorBeard", PlayerVendor.VendorGenderMale)

		-- label all the hairs
		LabelSetText(mainWindow .. "SecondaryBaldLabel", GetStringFromTid(1011051))  -- None
		LabelSetText(mainWindow .. "SecondaryShortLabel", GetStringFromTid(1011052))  -- Short
		LabelSetText(mainWindow .. "SecondaryLongLabel", GetStringFromTid(1011053))  -- Long
		LabelSetText(mainWindow .. "SecondaryPonytailLabel", GetStringFromTid(1011054))  -- Ponytail
		LabelSetText(mainWindow .. "SecondaryMohawkLabel", GetStringFromTid(1011055))  -- Mohawk
		LabelSetText(mainWindow .. "SecondaryPageboyLabel", GetStringFromTid(1011047))  -- Pageboy
		LabelSetText(mainWindow .. "SecondaryTopknotLabel", GetStringFromTid(1011050))  -- Topknot
		LabelSetText(mainWindow .. "SecondaryCurlyLabel", GetStringFromTid(1011396))  -- Curly
		LabelSetText(mainWindow .. "SecondaryRecedingLabel", GetStringFromTid(1011048))  -- Receding
		LabelSetText(mainWindow .. "SecondaryTwoTailsLabel", GetStringFromTid(1011049))  -- 2-tails

		-- label all the beards
		LabelSetText(mainWindow .. "SecondaryVendorBeardNoneLabel", GetStringFromTid(1011051))  -- None
		LabelSetText(mainWindow .. "SecondaryVendorBeardMustacheLabel", GetStringFromTid(1011062))  -- Mustache
		LabelSetText(mainWindow .. "SecondaryVendorBeardShortbeardLabel", GetStringFromTid(1011060))  -- Short beard
		LabelSetText(mainWindow .. "SecondaryVendorBeardShortbeardMustacheLabel", GetStringFromTid(1015321))  -- Short Beard & Moustache
		LabelSetText(mainWindow .. "SecondaryVendorBeardLongbeardLabel", GetStringFromTid(1011061))  -- Long beard
		LabelSetText(mainWindow .. "SecondaryVendorBeardLongbeardMustacheLabel", GetStringFromTid(1015322))  -- Long Beard & Moustache
		LabelSetText(mainWindow .. "SecondaryVendorBeardGoateeLabel", GetStringFromTid(1015323))  -- Goatee
		LabelSetText(mainWindow .. "SecondaryVendorBeardVandykeLabel", GetStringFromTid(1011401))  -- Vandyke

	else -- elven hair list

		-- elves has 1 less type of hairs
		WindowSetShowing(mainWindow .. "SecondaryTwoTails", false)

		-- elves have no beard
		WindowSetShowing(mainWindow .. "SecondaryVendorBeard", false)
		
		-- elven male hair typs
		if PlayerVendor.VendorGenderMale then

			-- label all the hairs
			LabelSetText(mainWindow .. "SecondaryBaldLabel", GetStringFromTid(1011051))  -- None
			LabelSetText(mainWindow .. "SecondaryShortLabel", GetStringFromTid(1074385))  -- Mid Long
			LabelSetText(mainWindow .. "SecondaryLongLabel", GetStringFromTid(1074386))  -- Long Feather
			LabelSetText(mainWindow .. "SecondaryPonytailLabel", GetStringFromTid(1074387))  -- Short
			LabelSetText(mainWindow .. "SecondaryMohawkLabel", GetStringFromTid(1074388))  -- Mullet
			LabelSetText(mainWindow .. "SecondaryPageboyLabel", GetStringFromTid(1074391))  -- Topknot
			LabelSetText(mainWindow .. "SecondaryTopknotLabel", GetStringFromTid(1074392))  -- Long Braid
			LabelSetText(mainWindow .. "SecondaryCurlyLabel", GetStringFromTid(1074390))  -- Long
			LabelSetText(mainWindow .. "SecondaryRecedingLabel", GetStringFromTid(1074394))  -- Spiked

		else -- elven female hairs

			-- label all the hairs
			LabelSetText(mainWindow .. "SecondaryBaldLabel", GetStringFromTid(1011051))  -- None
			LabelSetText(mainWindow .. "SecondaryShortLabel", GetStringFromTid(1074389))  -- Flower
			LabelSetText(mainWindow .. "SecondaryLongLabel", GetStringFromTid(1074386))  -- Long Feather
			LabelSetText(mainWindow .. "SecondaryPonytailLabel", GetStringFromTid(1074387))  -- Short
			LabelSetText(mainWindow .. "SecondaryMohawkLabel", GetStringFromTid(1074388))  -- Mullet
			LabelSetText(mainWindow .. "SecondaryPageboyLabel", GetStringFromTid(1074391))  -- Topknot
			LabelSetText(mainWindow .. "SecondaryTopknotLabel", GetStringFromTid(1074392))  -- Long Braid
			LabelSetText(mainWindow .. "SecondaryCurlyLabel", GetStringFromTid(1074393))  -- Buns
			LabelSetText(mainWindow .. "SecondaryRecedingLabel", GetStringFromTid(1074394))  -- Spiked
		end
	end

	-- reset the flag
	PlayerVendor.WaitForButton = false
end

function PlayerVendor.OnUpdate()
	
	-- paperdoll window name
	local windowName = "PaperdollWindow" .. PlayerVendor.MobileId

	-- player vendor window name
	local mainWindow = "PlayerVendor"

	-- does the paperdoll window exist and the button is enabled?
	if (DoesWindowExist(windowName) and WindowGetShowing(windowName)) and WindowGetHandleInput(mainWindow .. "MainShowEquipment") == true  then
		WindowSetTintColor(mainWindow .. "MainShowEquipment", 125, 125, 125)
		WindowSetHandleInput(mainWindow .. "MainShowEquipment", false)
		

	-- does the paperdoll window exist and the button is disabled?
	elseif (not DoesWindowExist(windowName) or not WindowGetShowing(windowName)) and WindowGetHandleInput(mainWindow .. "MainShowEquipment") == false then
		WindowSetTintColor(mainWindow .. "MainShowEquipment", 255, 255, 255)
		WindowSetHandleInput(mainWindow .. "MainShowEquipment", true)
	end

	-- is the customize visible?
	local customizeVisible = GumpData.Gumps[PlayerVendor.CustomizeGumpID] ~= nil

	-- toggle the customize area of the gump
	WindowSetShowing(mainWindow .. "Secondary", customizeVisible)

	-- enable/disable the main window based on the customize gump being visible or not
	WindowSetHandleInput(mainWindow .. "Main", not customizeVisible)

	-- if the customize is visible, make sure the paperdoll is always visible
	if customizeVisible then
		PlayerVendor.ShowPaperdoll()
	
	-- hide the paperdoll
	elseif DoesWindowExist("PaperdollWindow" .. PlayerVendor.MobileId) then
		WindowSetShowing("PaperdollWindow" .. PlayerVendor.MobileId, false)
	end

	-- get the vendor backpack ID
	local backpackId = GetBackpackID(PlayerVendor.MobileId)

	-- backpack window name
	local backpackWindow = "ContainerWindow_" .. backpackId

	-- does the paperdoll window exist and the button is enabled?
	if (DoesWindowExist(backpackWindow) and WindowGetShowing(backpackWindow)) and WindowGetHandleInput(mainWindow .. "MainShowGoods") == true  then
		WindowSetTintColor(mainWindow .. "MainShowGoods", 125, 125, 125)
		WindowSetHandleInput(mainWindow .. "MainShowGoods", false)
		

	-- does the paperdoll window exist and the button is disabled?
	elseif (not DoesWindowExist(backpackWindow) or not WindowGetShowing(backpackWindow)) and WindowGetHandleInput(mainWindow .. "MainShowGoods") == false then
		WindowSetTintColor(mainWindow .. "MainShowGoods", 255, 255, 255)
		WindowSetHandleInput(mainWindow .. "MainShowGoods", true)
	end

	-- are we waiting for a text entry to rename the shop and the text entry box is appeared?
	if PlayerVendor.RenameShopSent and Interface.CurrentTextEntryWindow ~= nil then
		
		-- get the gump text
		local text = TextEditBoxGetText(mainWindow .. "MainShopNameEditBox")

		-- update the text entry with the gump text
		TextEditBoxSetText(Interface.CurrentTextEntryWindowEditBox, text)

		-- submit the text
		SingleLineTextEntry.OnSubmit()

		-- remove the waiting flag
		PlayerVendor.RenameShopSent = nil
	end

	-- are we waiting for a text entry to rename the vendor and the text entry box is appeared?
	if PlayerVendor.RenameVendorSent and Interface.CurrentTextEntryWindow ~= nil then
		
		-- get the gump text
		local text = TextEditBoxGetText(mainWindow .. "MainVendorNameEditBox")

		-- update the text entry with the gump text
		TextEditBoxSetText(Interface.CurrentTextEntryWindowEditBox, text)

		-- submit the text
		SingleLineTextEntry.OnSubmit()

		-- remove the waiting flag
		PlayerVendor.RenameVendorSent = nil
	end

	-- are we waiting for a text entry to deposit gold and the text entry box is appeared?
	if PlayerVendor.GoldToDeposit and Interface.CurrentTextEntryWindow ~= nil then
		
		-- update the text entry with the gump text
		TextEditBoxSetText(Interface.CurrentTextEntryWindowEditBox, towstring(PlayerVendor.GoldToDeposit))

		-- submit the text
		SingleLineTextEntry.OnSubmit()

		-- remove the waiting flag
		PlayerVendor.GoldToDeposit = nil

		-- close the window (it will close anyway, but it will be faster this way)
		DestroyWindow("PlayerVendor")
	end

	-- are we waiting for a text entry to collect gold and the text entry box is appeared?
	if PlayerVendor.GoldToCollect and Interface.CurrentTextEntryWindow ~= nil then
		
		-- update the text entry with the gump text
		TextEditBoxSetText(Interface.CurrentTextEntryWindowEditBox, towstring(PlayerVendor.GoldToCollect))

		-- submit the text
		SingleLineTextEntry.OnSubmit()

		-- remove the waiting flag
		PlayerVendor.GoldToCollect = nil

		-- close the window (it will close anyway, but it will be faster this way)
		DestroyWindow("PlayerVendor")
	end
end

function PlayerVendor.CheckGump() 
	
	-- is the player vendor gump still available?
	if not GumpData.Gumps[PlayerVendor.GumpID] and not GumpData.Gumps[PlayerVendor.CustomizeGumpID] and not WindowGetShowing(DyeTubs.WindowName) and (not PlayerVendor.TextEntryRequest or (PlayerVendor.TextEntryRequest and Interface.CurrentTextEntryWindow == nil)) and not PlayerVendor.WaitForButton then

		-- close the window
		DestroyWindow("PlayerVendor")
	end
end

function PlayerVendor.UpdatePlayerGold()
	
	-- player vendor window name
	local mainWindow = "PlayerVendor"

	-- hide the textbox
	WindowSetShowing(mainWindow .. "MainVendorGoldEdit", false)

	-- is the player vendor window open or are we on siege rules? (can't check the gold on siege)
	if not DoesWindowExist(mainWindow) or Interface.SiegeRules or not GumpData.Gumps[PlayerVendor.GumpID] then
		return
	end

	-- bank gold label window name
	local bankGoldLabel = mainWindow .. "MainPlayerGoldText"

	-- insurance label window name
	local insuranceLabel = mainWindow .. "MainPlayerInsuranceText"

	-- vendor gold label window name
	local vendorGoldLabel = mainWindow .. "MainVendorGoldText"

	-- vendor cost label window name
	local vendorCostLabel = mainWindow .. "MainVendorCostText"

	-- vendor gold coverage label
	local vendorGoldCoverLabel = mainWindow .. "MainVendorGoldCoverLabel"

	-- get the bank gould amount
	local bankGold = tonumber(WindowData.PlayerStatus["BankGold"] or 0)

	-- get the insurance cost
	local insuranceCost = tonumber(Interface.InsuranceCost or 0)

	-- do we have enough gold for insurance?
	if bankGold <= insuranceCost then

		-- set the text to red
		LabelSetTextColor(bankGoldLabel, 255, 0, 0)

	else -- set the text to black
		LabelSetTextColor(bankGoldLabel, 0, 0, 0)
	end

	-- show the amount of player gold
	LabelSetText(bankGoldLabel, StringUtils.AddCommasToNumber(bankGold))

	-- show the insurance cost
	LabelSetText(insuranceLabel, StringUtils.AddCommasToNumber(insuranceCost))

	-- base gump table
	local data = GumpData.Gumps[PlayerVendor.GumpID]

	-- do we have the text?
	if data.LabelsText then

		-- get the vendor gold amount
		PlayerVendor.VendorGold = tonumber(tostring(wstring.gsub(data.LabelsText[4], L",", L"")))

		-- get the vendor gold amount
		local vendorCost = tonumber(tostring(wstring.gsub(data.LabelsText[6], L",", L"")))

		-- get the vendor gold amount
		local vendorCoveredDays = tonumber(tostring(wstring.gsub(data.LabelsText[1], L",", L"")))
			
		-- vendor gold
		LabelSetText(vendorGoldLabel, StringUtils.AddCommasToNumber(PlayerVendor.VendorGold))

		-- update the textbox
		TextEditBoxSetText(mainWindow .. "MainVendorGoldEditBox", towstring(PlayerVendor.VendorGold))

		-- vendor gold
		LabelSetText(vendorCostLabel, StringUtils.AddCommasToNumber(vendorCost))

		-- vendor gold cover
		LabelSetText(vendorGoldCoverLabel, ReplaceTokens(GetStringFromTid(331), {StringUtils.AddCommasToNumber(vendorCoveredDays)}))

		-- do we have enough gold for at least a day?
		if vendorCoveredDays < 1 then

			-- set the text to red
			LabelSetTextColor(vendorGoldLabel, 255, 0, 0)
			LabelSetTextColor(vendorGoldCoverLabel, 255, 0, 0)

		-- do we have enough gold for at least 5 days?
		elseif vendorCoveredDays < 5 then

			-- set the text to orange
			LabelSetTextColor(vendorGoldLabel, 255, 128, 0)
			LabelSetTextColor(vendorGoldCoverLabel, 255, 0, 0)

		else -- set the text to black
			LabelSetTextColor(vendorGoldLabel, 0, 0, 0)

			-- set the gold cover to gold
			LabelSetTextColor(vendorGoldCoverLabel, 216, 163, 0)
		end
	end

	-- is there any gold in the vendor? in that case we disable the dismiss vendor button
	if PlayerVendor.VendorGold > 0 then

		-- gray out text
		LabelSetTextColor(mainWindow .. "MainDismissVendor", 125, 125, 125)

	else -- reset the color to default
		LabelSetTextColor(mainWindow .. "MainDismissVendor", 255, 0, 0)
	end
end

function PlayerVendor.UpdateShopName()

	-- player vendor window name
	local mainWindow = "PlayerVendor"

	-- hide the textbox
	WindowSetShowing(mainWindow .. "MainShopNameEdit", false)

	-- make sure the gump is open
	if not GumpData.Gumps[PlayerVendor.GumpID] then
		return
	end

	-- current gump data table
	local data = GumpData.Gumps[PlayerVendor.GumpID]

	-- do we have the text?
	if data.LabelsText then
			
		-- shop name label window name
		local shopNameLabel = mainWindow .. "MainShopNameText"

		-- fill the shop name label
		LabelSetText(shopNameLabel, data.LabelsText[9])

		-- if the name is "Shop Not Yet Named", we color the label in red
		if wstring.lower(data.LabelsText[9]) == L"shop not yet named" then
			LabelSetTextColor(shopNameLabel, 255, 0, 0)

			-- update the edit box
			TextEditBoxSetText(mainWindow .. "MainShopNameEditBox", L"")

		else -- otherwise we make the text black
			LabelSetTextColor(shopNameLabel, 0, 0, 0)

			-- update the edit box
			TextEditBoxSetText(mainWindow .. "MainShopNameEditBox", data.LabelsText[9])
		end
	end
end

function PlayerVendor.UpdateVendorName()

	-- player vendor window name
	local mainWindow = "PlayerVendor"

	-- hide the textbox
	WindowSetShowing(mainWindow .. "MainVendorNameEdit", false)

	-- make sure the gump is open
	if not GumpData.Gumps[PlayerVendor.GumpID] then
		return
	end

	-- current gump data table
	local data = GumpData.Gumps[PlayerVendor.GumpID]

	-- do we have the text?
	if data.LabelsText then
			
		-- vendor name label window name
		local vendorNameLabel = mainWindow .. "MainVendorNameText"

		-- fill the shop name label
		LabelSetText(vendorNameLabel, data.LabelsText[10])

		-- set the vendor name in black
		LabelSetTextColor(vendorNameLabel, 0, 0, 0)

		-- update the edit box
		TextEditBoxSetText(mainWindow .. "MainVendorNameEditBox", data.LabelsText[10])

	end
end

function PlayerVendor.UpdateAuctionStatus()

	-- make sure the gump is open
	if not GumpData.Gumps[PlayerVendor.GumpID] then
		return
	end

	-- player vendor window name
	local mainWindow = "PlayerVendor"

	-- scan all labels
	for i, data in pairs(GumpData.Gumps[PlayerVendor.GumpID].Labels) do
		
		-- vendor search enabled?
		if data.tid == 1154633 then -- Vendor Search Enabled
			
			-- fill the shop name label
			LabelSetText(mainWindow .. "MainAuctionLabel", GetStringFromTid(data.tid))

			-- set the vendor name in black
			LabelSetTextColor(mainWindow .. "MainAuctionLabel", 0, 255, 0)

			break

		-- vendor search disabled?
		elseif data.tid == 1154634 then -- Vendor Search Disabled
			
			-- fill the shop name label
			LabelSetText(mainWindow .. "MainAuctionLabel", GetStringFromTid(data.tid))

			-- set the vendor name in black
			LabelSetTextColor(mainWindow .. "MainAuctionLabel", 255, 0, 0)

			break
		end
	end
end

function PlayerVendor.UpdatePicture()

	-- player vendor window name
	local mainWindow = "PlayerVendor"

	-- load the paperdoll texture
	local textureData = SystemData.PaperdollTexture[PlayerVendor.MobileId]

	-- do we have the texture?
	if textureData ~= nil then

		-- update the image size
		WindowSetDimensions(mainWindow .. "Texture", textureData.Width, textureData.Height)

		-- draw the texture
		DynamicImageSetTexture(mainWindow .. "Texture", "paperdoll_texture" .. PlayerVendor.MobileId, 0, 0 )
	end
end

function PlayerVendor.ShowGoods()
	
	-- set the flag to wait for the button result
	PlayerVendor.WaitForButton = true

	-- press see goods button
	GumpsParsing.PressButton(PlayerVendor.GumpID, 1)

	-- flag that the next container will be the player vendor
	ContainerWindow.NextIsPlayerVendor = true

	-- re-open the vendor customization main window
	UserActionUseItem(PlayerVendor.MobileId, false)
end

function PlayerVendor.CloseCustomize()

	-- set the flag to wait for the button result
	PlayerVendor.WaitForButton = true

	-- press close shop button
	GumpsParsing.PressButton(PlayerVendor.CustomizeGumpID, 1)

	-- close the paperdoll
	if DoesWindowExist("PaperdollWindow" .. PlayerVendor.MobileId) then
		DestroyWindow("PaperdollWindow" .. PlayerVendor.MobileId)
	end

	-- re-open the vendor customization main window
	UserActionUseItem(PlayerVendor.MobileId, false)
end

function PlayerVendor.ShowEquipment()

	-- show the vendor paperdoll
	PlayerVendor.ShowPaperdoll()

	-- set the flag to wait for the button result
	PlayerVendor.WaitForButton = true

	-- press rename shop button
	GumpsParsing.PressButton(PlayerVendor.GumpID, 2)
end

function PlayerVendor.ShowPaperdoll()
	
	-- paperdoll window name
	local windowName = "PaperdollWindow" .. PlayerVendor.MobileId

	-- does the paperdoll window exist?
	if not DoesWindowExist(windowName) then

		-- open the vendor paperdoll
		ContextMenu.RequestContextAction(PlayerVendor.MobileId, ContextMenu.DefaultValues.OpenPaperdoll)

		-- make sure the paperdoll is open by checking again in a short time
		Interface.AddTodoList({name = "Check Vendor Paperdoll is Open", func = function() PlayerVendor.ShowPaperdoll() end, time = Interface.TimeSinceLogin + 0.5})

	-- the paperdoll is probably invisible or not anchored correctly
	else

		-- show the paperdoll
		WindowSetShowing(windowName, true)

		-- clear the current position
		WindowClearAnchors(windowName)

		-- anchor the paperdoll inside the player vendor gump
		WindowAddAnchor(windowName, "topleft", "PlayerVendorItems", "topright", 0, -60)

		-- make the window NOT movable
		WindowSetMovable(windowName, false)
	end
end

function PlayerVendor.RenameShop()
	
	-- player vendor window name
	local mainWindow = "PlayerVendor"

	-- show the textbox
	WindowSetShowing(mainWindow .. "MainShopNameEdit", true)

	-- hide the shop name label
	WindowSetShowing(mainWindow .. "MainShopNameText", false)
end

function PlayerVendor.CancelRenameShop()

	-- player vendor window name
	local mainWindow = "PlayerVendor"

	-- hide the textbox
	WindowSetShowing(mainWindow .. "MainShopNameEdit", false)

	-- show the shop name label
	WindowSetShowing(mainWindow .. "MainShopNameText", true)

	-- undo the changes
	PlayerVendor.UpdateShopName()
end

function PlayerVendor.SubmitRenameShop()

	-- player vendor window name
	local mainWindow = "PlayerVendor"

	-- hide the textbox
	WindowSetShowing(mainWindow .. "MainShopNameEdit", false)

	-- show the shop name label
	WindowSetShowing(mainWindow .. "MainShopNameText", true)

	-- flag that we have sent a text entry request
	PlayerVendor.TextEntryRequest = true 

	-- press rename shop button
	GumpsParsing.PressButton(PlayerVendor.GumpID, 3)

	-- flag that indicates that we are waiting for a text entry box
	PlayerVendor.RenameShopSent = true
end

function PlayerVendor.RenameVendor()
	
	-- player vendor window name
	local mainWindow = "PlayerVendor"

	-- show the textbox
	WindowSetShowing(mainWindow .. "MainVendorNameEdit", true)

	-- hide the vendor name label
	WindowSetShowing(mainWindow .. "MainVendorNameText", false)
end

function PlayerVendor.CancelRenameVendor()

	-- player vendor window name
	local mainWindow = "PlayerVendor"

	-- hide the textbox
	WindowSetShowing(mainWindow .. "MainVendorNameEdit", false)

	-- show the vendor name label
	WindowSetShowing(mainWindow .. "MainVendorNameText", true)

	-- undo the changes
	PlayerVendor.UpdateVendorName()
end

function PlayerVendor.SubmitRenameVendor()

	-- player vendor window name
	local mainWindow = "PlayerVendor"

	-- hide the textbox
	WindowSetShowing(mainWindow .. "MainVendorNameEdit", false)

	-- show the vendor name label
	WindowSetShowing(mainWindow .. "MainVendorNameText", true)

	-- flag that we have sent a text entry request
	PlayerVendor.TextEntryRequest = true 

	-- press rename shop button
	GumpsParsing.PressButton(PlayerVendor.GumpID, 4)

	-- flag that indicates that we are waiting for a text entry box
	PlayerVendor.RenameVendorSent = true
end

function PlayerVendor.ChangeVendorGold()
	
	-- player vendor window name
	local mainWindow = "PlayerVendor"

	-- show the textbox
	WindowSetShowing(mainWindow .. "MainVendorGoldEdit", true)

	-- hide the vendor name label
	WindowSetShowing(mainWindow .. "MainVendorGoldText", false)
end

function PlayerVendor.CancelVendorGold()

	-- player vendor window name
	local mainWindow = "PlayerVendor"

	-- hide the textbox
	WindowSetShowing(mainWindow .. "MainVendorGoldEdit", false)

	-- show the vendor name label
	WindowSetShowing(mainWindow .. "MainVendorGoldText", true)

	-- undo the changes
	PlayerVendor.UpdatePlayerGold()
end

function PlayerVendor.SubmitVendorGold()

	-- player vendor window name
	local mainWindow = "PlayerVendor"

	-- hide the textbox
	WindowSetShowing(mainWindow .. "MainVendorGoldEdit", false)

	-- show the vendor name label
	WindowSetShowing(mainWindow .. "MainVendorGoldText", true)

	-- get the gump text (converted in number)
	local text = tonumber(TextEditBoxGetText(mainWindow .. "MainVendorGoldEditBox"))

	

	-- make sure the amount is greater than 0
	if text < 0 then
		text = 0
	end

	-- does the player has specified a value greater than the current vendor gold?
	if text > PlayerVendor.VendorGold then
		
		-- get the bank gould amount
		local bankGold = tonumber(WindowData.PlayerStatus["BankGold"] or 0)

		-- calculate the amount of gold to get from the bank box
		local goldToDeposit = text - PlayerVendor.VendorGold

		-- do we have the bank gold amount and the amount to deposit is greater than the bank gold amount?
		if bankGold > 0 and goldToDeposit > bankGold then

			-- cap the amount to what we have in bank
			goldToDeposit = bankGold
		end

		-- flag that we have sent a text entry request
		PlayerVendor.TextEntryRequest = true 

		-- press deposit gold button
		GumpsParsing.PressButton(PlayerVendor.GumpID, 7)

		-- flag that indicates that we are waiting for a text entry box
		PlayerVendor.GoldToDeposit = goldToDeposit

	-- does the player has specified a value smaller than the current vendor gold?
	elseif text < PlayerVendor.VendorGold then

		-- calculate the amount of gold to get from the vendor
		local goldToCollect = PlayerVendor.VendorGold - text

		-- flag that we have sent a text entry request
		PlayerVendor.TextEntryRequest = true 

		-- press collect gold button
		GumpsParsing.PressButton(PlayerVendor.GumpID, 6)

		-- flag that indicates that we are waiting for a text entry box
		PlayerVendor.GoldToCollect = goldToCollect
	end

	-- if the amount of gold is the same, we do nothing
end

function PlayerVendor.ToggleSearch()
	
	-- set the flag to wait for the button result
	PlayerVendor.WaitForButton = true

	-- press rename vendor button
	GumpsParsing.PressButton(PlayerVendor.GumpID, 9)

	-- re-open the vendor customization main window
	UserActionUseItem(PlayerVendor.MobileId, false)
end

function PlayerVendor.GenderChange()

	-- default button ID
	local buttonID = 22

	-- is the vendor human female?
	if not PlayerVendor.VendorGenderMale and PlayerVendor.VendorRaceHuman then
		
		-- the button ID changes because there is no beard settings
		buttonID = 13

	-- is the vendor elf?
	elseif not PlayerVendor.VendorRaceHuman then
		
		-- the button ID changes because there is no beard settings and 1 less type of hairs
		buttonID = 12
	end

	-- set the flag to wait for the button result
	PlayerVendor.WaitForButton = true

	-- press rename vendor button
	GumpsParsing.PressButton(PlayerVendor.CustomizeGumpID, buttonID)	
end

function PlayerVendor.CustomVanity()

	-- get the buttonID for the gump button
	local buttonID = WindowGetId(SystemData.ActiveWindow.name)

	-- elf bald is 1 id less
	if buttonID == 11 and not PlayerVendor.VendorRaceHuman then
		buttonID = 10
	end

	-- set the flag to wait for the button result
	PlayerVendor.WaitForButton = true

	-- press rename vendor button
	GumpsParsing.PressButton(PlayerVendor.CustomizeGumpID, buttonID)	
end

function PlayerVendor.DismissVendor()
	
	-- can't dismiss the vendor if it's holding any gold
	if PlayerVendor.VendorGold > 0 then
		return
	end

	-- press dismiss vendor button
	GumpsParsing.PressButton(PlayerVendor.GumpID, 8)	
end

function PlayerVendor.RaceChange()

	-- default button ID
	local buttonID = 23

	-- is the vendor human female?
	if not PlayerVendor.VendorGenderMale and PlayerVendor.VendorRaceHuman then
		
		-- the button ID changes because there is no beard settings
		buttonID = 14

	-- is the vendor elf?
	elseif not PlayerVendor.VendorRaceHuman then
		
		-- the button ID changes because there is no beard settings and 1 less type of hairs
		buttonID = 13
	end

	-- set the flag to wait for the button result
	PlayerVendor.WaitForButton = true

	-- press rename vendor button
	GumpsParsing.PressButton(PlayerVendor.CustomizeGumpID, buttonID)	
end

function PlayerVendor.HairDye()

	-- default button ID
	local buttonID = 12

	-- is the vendor elf?
	if not PlayerVendor.VendorRaceHuman then
				
		-- the button ID changes because there is 1 less type of hairs
		buttonID = 11
	end

	-- set the flag to wait for the button result
	PlayerVendor.WaitForButton = true

	-- press rename vendor button
	GumpsParsing.PressButton(PlayerVendor.CustomizeGumpID, buttonID)	
end

function PlayerVendor.BeardDye()

	-- set the flag to wait for the button result
	PlayerVendor.WaitForButton = true

	-- press rename vendor button
	GumpsParsing.PressButton(PlayerVendor.CustomizeGumpID, 21)	
end

function PlayerVendor.CheckLabelHighlighted(windowName)
	
	-- make sure the window exist
	if not DoesWindowExist(windowName) then
		return false
	end

	-- get the label text color
	local r, g, b = LabelGetTextColor(windowName)

	if not r or not g or not b then
		return false
	end

	-- make the color a round number
	r = math.floor(r)
	g = math.floor(g)
	b = math.floor(b)

	-- highlighted labels are in ligth blue, if the color matches is highlighted
	return r == 131 and g == 131 and b == 255
end

function PlayerVendor.TextHighlight()
	
	-- can't dismiss the vendor if it's holding any gold
	if PlayerVendor.VendorGold > 0 then
		return
	end

	-- set the text to green
	LabelSetTextColor(SystemData.ActiveWindow.name, 0, 255, 0)
end

function PlayerVendor.TextUnhighlight()

	-- can't dismiss the vendor if it's holding any gold
	if PlayerVendor.VendorGold > 0 then
		return
	end

	-- set the text to red
	LabelSetTextColor(SystemData.ActiveWindow.name, 255, 0, 0)
end

function PlayerVendor.RadioHighlight()

	-- get the button window name
	local button = SystemData.ActiveWindow.name .. "Button"

	-- if the window doesn't exist, it means that is a child item
	if not DoesWindowExist(button) then
		button = WindowGetParent(SystemData.ActiveWindow.name) .. "Button"
	end

	ButtonSetStayDownFlag(button, true)
	-- highlight the button
	ButtonSetPressedFlag(button, true)
end

function PlayerVendor.RadioUnhighlight()
	
	-- get the button window name
	local button = SystemData.ActiveWindow.name .. "Button"

	-- if the window doesn't exist, it means that is a child item
	if not DoesWindowExist(button) then
		button = WindowGetParent(SystemData.ActiveWindow.name) .. "Button"
	end

	-- unhighlight the button
	ButtonSetPressedFlag(button, false)
end

function PlayerVendor.ShowGoodsTooltip()
	
	-- create the inventory button tooltip
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1011354)) -- See goods
end

function PlayerVendor.ShowEquipmentTooltip()
	
	-- create the equiment button tooltip
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(334))
end

function PlayerVendor.RenameShopTextboxTooltip()
	
	-- create the rename shop button tooltip
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1062434) .. GetStringFromTid(325))  -- Rename Shop
end

function PlayerVendor.RenameShopTooltip()
	
	-- create the rename shop button tooltip
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1062434))  -- Rename Shop
end

function PlayerVendor.RenameVendorTextboxTooltip()
	
	-- create the rename vendor button tooltip
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(3006217) .. GetStringFromTid(325))  -- Rename Vendor
end

function PlayerVendor.RenameVendorTooltip()
	
	-- create the rename vendor button tooltip
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(3006217))  -- Rename Vendor
end

function PlayerVendor.ToggleVendorSearchTooltip()
	
	-- create the rename vendor button tooltip
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(324))
end

function PlayerVendor.SiegeTooltip()
	
	-- show only on siege rules shard
	if not Interface.SiegeRules then
		return
	end

	-- create data unavailable on siege rules tooltip
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(328))
end

function PlayerVendor.ChangeVendorGoldTooltip()
	
	-- create the change amount of gold for the vendor button tooltip
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(332))
end

function PlayerVendor.ChangeVendorGoldTextboxTooltip()
	
	-- create the change amount of gold for the vendor button tooltip
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(333) .. GetStringFromTid(325))
end

function PlayerVendor.CloseCustomizeTooltip()
	
	-- create the close button tooltip
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1061046)) -- Close
end

function PlayerVendor.GenderTooltip()
	
	-- create the gender change button tooltip
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1156609)) -- Gender Change
end

function PlayerVendor.RaceTooltip()
	
	-- create the race change button tooltip
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, FormatProperly(GetStringFromTid(1113656))) -- race change
end

function PlayerVendor.HairDyeTooltip()
	
	-- create the hair dye button tooltip
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, FormatProperly(GetStringFromTid(1016491))) -- hair dye
end

function PlayerVendor.BeardDyeTooltip()
	
	-- create the beard dye button tooltip
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(335))
end

function PlayerVendor.CantDismissTooltip()
	
	-- if the vendor has no gold we don't need to show any tooltip
	if PlayerVendor.VendorGold <= 0 then
		return
	end

	-- create the can't dismiss vendor button tooltip
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(336))
end