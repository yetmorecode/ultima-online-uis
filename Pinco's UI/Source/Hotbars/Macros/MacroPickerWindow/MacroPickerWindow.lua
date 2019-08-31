----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

MacroPickerWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

MacroPickerWindow.MacroIcons = 
{
	-- Empty/No Icon
	0, 620,
	
	-- Magery Spells
	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
	16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28,
	29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41,
	42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54,
	55, 56, 57, 58, 59, 60, 61, 62, 63, 64,
	
	-- Necromancy Spells
	101, 102, 103, 104, 105, 106, 107, 108, 109, 110,
	111, 112, 113, 114, 115, 116, 117,
	
	-- Chivalry Spells
	201, 202, 203, 204, 205, 206, 207, 208, 209, 210,
	
	-- Bushido Spells
	401, 402, 403, 404, 405, 406,
	
	-- Ninjitsu Spells
	501, 502, 503, 504, 505, 506, 507, 508,
	
	-- Spellweaving Spells
	601, 602, 603, 604, 605, 606, 607, 608, 609, 610,
	611, 612, 613, 614, 615, 616,
	
	-- Mysticism Spells
	678, 679, 680, 681, 682, 683, 684, 685, 686, 687,
	688, 689, 690, 691, 692, 693,
	
	-- Weapon Specials
	1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1009,
	1010, 1011, 1012, 1013, 1014, 1015, 1016, 1017, 1018,
	1019, 1020, 1021, 1022, 1023, 1024, 1025, 1026, 1027,
	1028, 1029, 1030, 1031,
	
	-- Skills
	2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009,
	2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018,
	2019, 2020, 2021, 2022, 2023, 2024, 2025, 2026, 2027,
	2028, 2029, 2030, 2031, 2032, 2033, 2034, 2035, 2036,
	2037, 2038, 2039, 2040, 2041, 2042, 2043, 2044, 2045,
	2046, 2047, 2048, 2049, 2050, 2051, 2052, 2053, 2054,
	2055, 2056, 2057, 2058,
	
	-- Masteries
	1701, 1702, 1703, 1704, 1705, 1706, 1707, 1708, 1709, 
	1710, 1711, 1712, 1713, 1714, 1715, 1716, 1717, 1718, 
	1719, 1720, 1721, 1722, 1723, 1724, 1725, 1726, 1727, 
	1728, 1729, 1730, 1731, 1732, 1733, 1734, 1735, 1736, 
	1737, 1738, 1739, 1740, 1741, 1742, 1743, 1744, 1745,
	
	-- Racial Abilities
	03001, 03002, 03003, 03004, 03011, 03012, 03013, 03014, 
	03015, 03016, 03021, 03022, 03023, 03024, 03025, 
	
	-- Virtues
	700, 701, 702, 703, 704, 705, 706, 707,
	
	-- Communication Actions
	622, 624, 631, 632, 638, 639, 713, 714, 715, 
	855002, 855003, 855005, 855008, 855011, 855014, 
	855015, 855016, 855017, 855018, 855019, 855020, 
	855022, 855023, 855028, 855030, 
	
	-- Boat Commands
	662, 663, 664, 665, 667, 668, 669, 670, 672, 673, 
	674, 694, 695, 709, 710, 711, 712, 855025, 855026, 
	855027, 855031, 855032,
	
	-- Pet Commands
	650, 651, 652, 653, 654, 655, 656, 657, 658, 659, 
	660, 661, 855012, 855013, 855021, 855029, 
	
	-- Menu Actions
	635, 795, 796, 860001, 860002, 860003, 860004, 
	860005, 860006, 860007, 860008, 860009, 860010,
	860011, 860012, 860013, 860014, 860016, 860017,
	
	-- Cursor Targeting
	618, 643, 644, 645, 771, 772, 797, 799, 
	
	-- Targeting Actions
	646, 647, 648, 649, 708, 770, 775, 776, 777, 778, 
	779, 780, 781, 782, 783, 784, 785, 786, 787, 788, 
	865000, 865001, 865002, 865003, 865004, 865005, 
	865006, 865007,
	
	-- Pet Targeting
	870000, 870001, 870002, 870003, 870004, 
	870050, 870051, 870052, 870053, 870054, 

	-- Object Targeting
	870100, 870101, 870102, 870103, 870104, 
	870150, 870151, 870152, 870153, 870154, 
	
	-- Petballs
	870200, 870201, 870202, 870203, 870204, 870205, 870206,
	870207, 870208, 870209, 870210, 870211, 870212, 870213,
	870214,
	
	-- Mounts
	798, 870300, 870301, 870302, 870303, 870304, 870305, 870306,
	870307, 870308, 870309, 870310, 870311,
	
	-- Cannons
	870400, 870401, 870402, 870403, 870404, 870405, 870406, 870407,
	870408,
	
	-- Equipment Actions
	625, 637, 792, 875000, 875001, 875002, 875003, 875004, 875005,
	875006, 875007, 875008, 875009, 875010, 875011, 875012, 875013,
	875014, 875015, 875016, 875017, 875018, 875019, 875020, 875021,
	875022, 875023, 875024, 875025, 875026, 875027, 875028, 875029,
	875030, 875031, 875032, 875033, 875034, 875035, 875036, 875037,
	875038,
	
	-- Other Actions
	619, 623, 641, 718, 724, 729, 730, 731, 732, 789, 790, 791, 
	875100, 875101, 875102, 875103, 875104, 875105, 875106, 875107,
	875109, 875110, 875111, 875112, 875113, 875114, 875115,
	875116, 875117, 875118, 875119, 875120, 875121, 875122, 875123, 
	875124, 875125, 875126, 875127, 875128, 875129, 875130, 875131, 
	875132, 875133, 875134, 875135,
	
	-- Super Slayers
	875200, 875201, 875202, 875203, 875204, 875205, 875206, 875207,
	
	-- Slayers
	875250, 875251, 875252, 875253, 875254, 875255, 875256, 875257,
	875258, 875259, 875260, 875261, 875262, 875263, 875264, 875265,
	875266, 875267, 875268, 875269, 875270, 875271, 875272,
	
	-- Talisman Slayers
	875300, 875301, 875302, 875303, 875304, 875305, 875306, 875307, 
	875308, 875309, 875310,
	
	-- Bard Super Slayers
	875350, 875351, 875352, 875353, 875354, 875355, 875356,
	
	-- Bard Slayers
	875400, 875401, 875402, 875403, 875404, 875405, 875406, 875407, 
	875408, 875409, 875410, 875411, 875412, 875413, 875414, 875415, 
	875416, 875417,
	
	-- Worker Talismans
	875450, 875451, 875452, 875453, 875454, 875455, 875456, 875457,
	875458, 875459, 875460,
	
	-- Player Context Actions
	875500, 875501, 875502, 875503, 875504, 875505, 875506, 875507, 
	875508, 875509, 875510, 875511, 875512, 875513, 875514,
	
	-- Items/Abilities
	617, 629, 640, 677, 793, 794, 875600, 875601, 875602, 875603,
	875604, 875605, 875606, 875607, 875608, 875609, 875610, 875611,
	
	-- Combat
	675, 676, 773, 774,
	
	-- Generic
	633, 719, 200200, 200201, 200202, 200203, 200204, 200205, 200206, 
	200207, 200208, 200209, 200210, 200211, 200212, 200213, 200214, 
	200215, 200216, 200217, 200218, 200219, 200220, 200221, 200222, 
	200223, 
	
	-- Resources
	200100, 200101, 200102, 200103, 200104, 200105, 200106, 
	200150, 200151, 200152, 200153, 200154, 200155, 200156, 
	200157, 200158, 
	
	-- Potions
	856000, 856001, 856002, 856003, 856004, 856005, 856006, 856007, 
	856008, 856009, 856010, 856011, 856012, 856013, 856014, 856015, 
	856016, 856017, 856018, 
	
	-- rune locations
	856100, 856101, 856102, 856103, 856104, 856105, 856106, 856107, 
	856108, 856109, 856110, 856111, 856112, 856113, 856114, 856115, 
	856116, 856117, 856118, 856119, 856120, 856121, 856122, 856123, 
	856124, 856125, 856126, 856127, 856128, 856129, 856130, 856131, 
	856132, 856133, 856134, 856135, 856136, 856137, 856138, 856139, 
	856140, 
	
	-- Numbers
	857400, 857401, 857402, 857403, 857404, 857405, 857406, 857407, 
	857408, 857409, 857410, 857411, 857412, 857413, 857414, 857415, 
	857416, 857417, 857418, 857419, 857420, 857421, 857422, 857423, 
	857424, 857425, 857426, 857427, 857428, 857429,								
}

-- current first element of the first row
MacroPickerWindow.currentID = 1

MacroPickerWindow.numMacrosPerRow = 4
MacroPickerWindow.numMacrosPerPage = 16

MacroPickerWindow.MacroSelected = nil

MacroPickerWindow.activeIcon = 0

-- table of all the icons in the list
MacroPickerWindow.currentIcons = {}

MacroPickerWindow.currentWindow = ""

----------------------------------------------------------------
-- MainMenuWindow Functions
----------------------------------------------------------------

-- OnInitialize Handler
function MacroPickerWindow.Initialize()
	
	-- current window name
	local this = SystemData.ActiveWindow.name

	-- current window ID
	local id = SystemData.DynamicWindowId

	-- attach the ID to the current window
	WindowSetId(this, id)
	
	-- initialize the window data array
	MacroPickerWindow[id] = {}
	
	-- destroy the window on close
	Interface.DestroyWindowOnClose[this] = true

	-- store the window name
	MacroPickerWindow.currentWindow = this
end

function MacroPickerWindow.ClearIconsTable()

	-- scan all the existing elements
	for icon, _ in pairs(MacroPickerWindow.currentIcons) do

		-- does the icon still exist?
		if DoesWindowExist(icon) then

			-- destroy the icon
			DestroyWindow(icon)
		end
	end

	-- empty the icons list
	MacroPickerWindow.currentIcons = {}
end

function MacroPickerWindow.DrawMacroTable(parent)
	
	-- initialize variables
	local numInRow = 0
    local firstRowWindow = nil
    local relativeAnchorMacroWindowName = nil

	-- clear the existing icons
	MacroPickerWindow.ClearIconsTable()

	-- scan all icons
    for index = MacroPickerWindow.currentID, #MacroPickerWindow.MacroIcons do

		-- have we filled the page yet?
		if index == MacroPickerWindow.currentID + MacroPickerWindow.numMacrosPerPage then
			break
		end

		-- current icon ID
		local iconId = MacroPickerWindow.MacroIcons[index]

		-- current icon window name
        local currentMacroWindowName = parent .. "MacroIcon" .. iconId

		-- add the icon to the elements list
		MacroPickerWindow.currentIcons[currentMacroWindowName] = true

		-- create element
        CreateWindowFromTemplate(currentMacroWindowName, "MacroPickerItemTemplate", parent)

		-- is this the current icon?
		if MacroPickerWindow.activeIcon == iconId then

			-- we color the icon in green
			WindowSetTintColor(currentMacroWindowName .. "Icon", 0, 255, 0)
		end

		-- get icon data
        local iconTexture, x, y = GetIconData(iconId)

		-- draw the icon
        DynamicImageSetTexture(currentMacroWindowName .. "Icon", iconTexture, x, y)
        
		-- draw background
        DynamicImageSetTexture(currentMacroWindowName .. "BG", MiniTexturePack.DB[Interface.Settings.MTP_Current].texture .. "Icon", x, y)

		-- attach tie icon ID to its window
		WindowSetId(currentMacroWindowName, iconId)

		-- is this the first element?
        if index == MacroPickerWindow.currentID then 

			-- anchor to the top left of the main window
            WindowAddAnchor(currentMacroWindowName, "topleft", parent, "topleft", 5, 5)

			-- set this as previous window
            relativeAnchorMacroWindowName = currentMacroWindowName

			-- set this as first item of the previous line
            firstRowWindow = currentMacroWindowName

		-- element between the first or the last in a line
        elseif numInRow < MacroPickerWindow.numMacrosPerRow - 1 then

			-- anchor the element to the previous one in the line
            WindowAddAnchor(currentMacroWindowName, "topright", relativeAnchorMacroWindowName, "topleft", 0, 0)

			-- increase the number of items in the row by 1
            numInRow = numInRow + 1

			-- set this as previous window
            relativeAnchorMacroWindowName = currentMacroWindowName

		-- is this the last element of the row?
        elseif numInRow == MacroPickerWindow.numMacrosPerRow - 1 then

			-- anchor the element to the bottom left of the first of the previous line
            WindowAddAnchor(currentMacroWindowName, "bottomleft", firstRowWindow, "topleft", 0, 0)

			-- reset the number of items in the row
            numInRow = 0

			-- set this as previous window
            relativeAnchorMacroWindowName = currentMacroWindowName

			-- set this as first item of the previous line
            firstRowWindow =  currentMacroWindowName                     
        end                
    end

	-- update the page number text
	MacroPickerWindow.UpdatePageNumber(parent)
end

function MacroPickerWindow.UpdatePageNumber(parent)
	
	-- does the window exist?
	if not DoesWindowExist(parent) then
		return
	end

	-- calculate the current page number
	local currPage = (MacroPickerWindow.currentID + (MacroPickerWindow.numMacrosPerPage - 1)) / MacroPickerWindow.numMacrosPerPage
	
	-- calculate the max page number
	local maxPage = math.ceil(#MacroPickerWindow.MacroIcons / MacroPickerWindow.numMacrosPerPage)

	-- update the page number
	LabelSetText(parent .. "Page", currPage .. L"/" .. maxPage)
end

function MacroPickerWindow.SetMacro()

	-- get the parent window name
    local parent = WindowGetParent(WindowGetParent(WindowGetParent(SystemData.ActiveWindow.name)))
    
	-- get the selected icon ID
	MacroPickerWindow.MacroSelected = WindowGetId(SystemData.ActiveWindow.name)

	-- hide the icon selection window
    WindowSetShowing(parent, false)
        
	-- call the after-selection function
    MacroPickerWindow.AfterMacroSelectionFunction()
end

function MacroPickerWindow.SetAfterMacroSelectionFunction(funcCall)

	-- update the after-selection function
	MacroPickerWindow.AfterMacroSelectionFunction = funcCall        
end

function MacroPickerWindow.SetMacroId(macroId, parent)

	-- set the macro ID
	MacroPickerWindow.MacroSelected = macroId

	-- hide the parent window
    WindowSetShowing(parent, false)
end

function MacroPickerWindow.NextPage()

	-- increase the ID to the first one of the next page
	MacroPickerWindow.currentID = MacroPickerWindow.currentID + MacroPickerWindow.numMacrosPerPage

	-- is the ID greater than the number of icons?
	if MacroPickerWindow.currentID > #MacroPickerWindow.MacroIcons then

		-- go back to the first page
		MacroPickerWindow.currentID = 1
	end

	-- update the icons list
	MacroPickerWindow.DrawMacroTable(MacroPickerWindow.currentWindow)
end

function MacroPickerWindow.PreviousPage()

	-- increase the ID to the first one of the next page
	MacroPickerWindow.currentID = MacroPickerWindow.currentID - MacroPickerWindow.numMacrosPerPage

	-- is the ID greater than the number of icons?
	if MacroPickerWindow.currentID < 0 then

		-- keep increasing the ID until we find the last page
		while MacroPickerWindow.currentID < #MacroPickerWindow.MacroIcons do

			-- increase the ID to the first one of the next page
			MacroPickerWindow.currentID = MacroPickerWindow.currentID + MacroPickerWindow.numMacrosPerPage
		end

		-- get the ID for the last page
		MacroPickerWindow.currentID = MacroPickerWindow.currentID - MacroPickerWindow.numMacrosPerPage
	end

	-- update the icons list
	MacroPickerWindow.DrawMacroTable(MacroPickerWindow.currentWindow)
end

function MacroPickerWindow.ScrollPage(x, y, delta, flags)

	-- scroll up
	if delta > 0 then

		-- go to the previous page
		MacroPickerWindow.PreviousPage()

	else -- scroll down

		-- go to the next page
		MacroPickerWindow.NextPage()
	end
end

function MacroPickerWindow.FindCurrentPage()
	
	-- initialzie the current ID
	MacroPickerWindow.currentID = 1

	-- ID of the active icon in the table
	local currId = 1

	-- search for the ID of the active icon
	for i, iconId in pairsByIndex(MacroPickerWindow.MacroIcons) do

		-- is this the active icon?
		if iconId == MacroPickerWindow.activeIcon then

			-- store the ID
			currId = i

			break
		end
	end

	-- keep increasing the ID until we find the last page
	while MacroPickerWindow.currentID < currId do

		-- increase the ID to the first one of the next page
		MacroPickerWindow.currentID = MacroPickerWindow.currentID + MacroPickerWindow.numMacrosPerPage 
	end

	-- if the ID are the same we do nothing
	if MacroPickerWindow.currentID > currId then

		-- get the correct ID
		MacroPickerWindow.currentID = MacroPickerWindow.currentID - MacroPickerWindow.numMacrosPerPage
	end
end