----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

SearchBox = {}

SearchBox.Classes = {}

SearchBox.Classes.ContainerSearch =
{
	clearOnEnter = true,
	search = ContainerSearch.OnLButtonUpSearch,
	resetSearch = ContainerSearch.Restart,
	ignoreTableElement = L"*",
	filtersTable = {},
}

SearchBox.Classes.JewelryBox =
{
	clearOnEnter = true,
	search = GumpsParsing.JewelryBoxStartSearch,
	resetSearch = GumpsParsing.JewelryBoxResetSearch,
	ignoreTableElement = L"*",
	filtersTable = {},
}

SearchBox.Classes.AtlasWindow =
{
	textChanged = AtlasWindow.SearchText,
	resetSearch = AtlasWindow.ResetSearch,
}

SearchBox.Classes.NewChatContacts =
{
	textChanged = NewChatWindow.OnGChatRosterUpdate,
}

SearchBox.Classes.PetsList = 
{
	textChanged = PetsList.UpdateList,
}

SearchBox.Classes.PropertiesInfo =
{
	textChanged = PropertiesInfo.SearchText,
	resetSearch = PropertiesInfo.Restart,
}

SearchBox.Classes.SettingsWindow =
{
	search = SettingsWindow.Search,
	resetSearch = SettingsWindow.ResetSearch
}

SearchBox.Classes.Shopkeeper = 
{
	clearOnEnter = true,
	search = Shopkeeper.OnLButtonUpSearch,
	resetSearch = Shopkeeper.Restart,
	filtersTable = {}
}

SearchBox.Classes.MobilesDockspotSettingscustomText = 
{
	textChanged = MobileBarsDockspot.CustomTextChanged
}

SearchBox.Classes.ActionsWindow =
{
	search = ActionsWindow.Search,
	resetSearch = ActionsWindow.ResetSearch,
	textChanged = ActionsWindow.Search
}

SearchBox.Classes.CraftingTool =
{
	search = GumpsParsing.CraftingToolSearchNext,
	resetSearch = GumpsParsing.CraftingToolSearchReset
}

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function SearchBox.Initialize()
	
	-- searchbox window name
	local searchBox = SystemData.ActiveWindow.name

	-- filter text
	LabelSetText(searchBox .. "Desc", GetStringFromTid(1156592)) -- Filter
end

function SearchBox.SearchBoxStatus(timePassed)

	-- searchbox window name
	local searchBox = SystemData.ActiveWindow.name
	
	-- is the search box visible?
	if not WindowGetShowing(WindowGetParent(searchBox)) then
		return
	end

	-- get the text from the search box
	local text = wstring.lower(TextEditBoxGetText(searchBox .. "Filter"))

	-- should we show the reset button?
	local visible = IsValidWString(text)

	-- toggle the "filter" description if there is text written in the textbox or if the cursor is in the textbox
	WindowSetShowing(searchBox .. "Desc", not visible and not WindowHasFocus(searchBox .. "Filter"))

	-- get the class for the current search box
	local class = SearchBox.GetClass(searchBox)

	-- do we have a valid class filter table? if we have it, we have to count the patterns and see if the table is empty, if it's not then we keep showing the X to reset.
	if class and class.filtersTable then
		
		-- count the elements in the table
		local tableElements = table.countElements(class.filtersTable)

		-- is the first element the one we must ignore?
		if class.filtersTable[1] and class.filtersTable[1] == class.ignoreTableElement then

			-- reduce the elements count by 1
			tableElements = tableElements - 1
		end

		-- if we have some elements in the table then we should see the reset button
		visible = tableElements > 0
	end

	-- toggle the reset search button
	WindowSetShowing(searchBox .. "Reset", visible)

	-- toggle the magnify glass
	WindowSetShowing(searchBox .. "Icon", not visible)
end

function SearchBox.ResetSearch()

	-- searchbox window name
	local searchBox = WindowGetParent(SystemData.ActiveWindow.name)
	
	-- reset the textobx text
	TextEditBoxSetText(searchBox .. "Filter", L"")

	-- get the class for the current search box
	local class = SearchBox.GetClass(searchBox)

	-- do we have a valid class and a valid reset search function for the class?
	if not class or not class.resetSearch then
		return
	end

	-- call the reset search function for the class
	class.resetSearch()
end

function SearchBox.TextChanged()
	
	-- searchbox window name
	local searchBox = WindowGetParent(SystemData.ActiveWindow.name)
	
	-- get the class for the current search box
	local class = SearchBox.GetClass(searchBox)

	-- do we have a valid class and a valid text changed function for the class?
	if not class or not class.textChanged then
		return
	end

	-- call the text changed function for the class
	class.textChanged()

	-- is the searchbox empty?
	if SearchBox.GetFilter(searchBox) == L"" then
		
		-- call the reset search function for the class (if we have one)
		if class.resetSearch then
			class.resetSearch()
		end
	end
end

function SearchBox.Search()

	-- searchbox window name
	local searchBox = WindowGetParent(SystemData.ActiveWindow.name)
	
	-- get the class for the current search box
	local class = SearchBox.GetClass(searchBox)

	-- do we have a valid class and a valid search function for the class?
	if not class or not class.search then
		return
	end

	-- call the search function for the class
	class.search()

	-- do we have to clear the text box after the search?
	if class.clearOnEnter == true then

		-- reset the textobx text
		TextEditBoxSetText(searchBox .. "Filter", L"")
	end
end

function SearchBox.GetClass(searchBox)
	
	-- do we have a valid search box name?
	if not IsValidString(searchBox) then
		return
	end
	
	-- scan all the defined classes of the searchbox
	for class, data in pairs(SearchBox.Classes) do 

		-- does the searchbox contains the class name?
		if string.find(searchBox, class, 1, true) then
			return data
		end
	end
end

function SearchBox.GetFilter(searchBoxWindow, lowered, convertString)
	
	-- do we have a valid main window name?
	if not IsValidString(searchBoxWindow) or not DoesWindowExist(searchBoxWindow) then
		return L""
	end

	-- get the filter text
	local filterText = towstring(TextEditBoxGetText(searchBoxWindow .. "Filter"))

	-- do we need a lowered text?
	if lowered == true then
		filterText = wstring.lower(filterText)
	end
	
	-- do we need to convert the text to string?
	if convertString == true then
		filterText = tostring(filterText)
	end

	return filterText
end

function SearchBox.RemoveFiltersTooltip()

	-- create tooltip
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(1154792)) -- Remove Filters
end

function SearchBox.SearchTooltip()
	
	-- create tooltip
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,  GetStringFromTid(1154641)) -- search
end