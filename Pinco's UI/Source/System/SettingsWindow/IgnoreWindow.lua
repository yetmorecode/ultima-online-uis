----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

IgnoreWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

IgnoreWindow.currentSelection = -1

IgnoreWindow.TID = 
{
	Title = 1114787,
	Add = 1114788,
	Cancel = 1006045
}

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function IgnoreWindow.Initialize()

	-- mark the window to be destroyed when the window closes
	Interface.DestroyWindowOnClose["IgnoreWindow"] = true
	
	-- fill the window title
	WindowUtils.SetWindowTitle("IgnoreWindow", GetStringFromTid(IgnoreWindow.TID.Title))
	
	-- fill the button texts
	ButtonSetText( "IgnoreWindowAddButton", GetStringFromTid(IgnoreWindow.TID.Add) )
	ButtonSetText( "IgnoreWindowCancelButton", GetStringFromTid(IgnoreWindow.TID.Cancel) )
	
	-- initialize the previous element
	local previousChannelButton
	
	-- scan all possible players
	for i = 1, WindowData.RecentChatPlayerListCount do

		-- current element name
		local currentChannelButton = "recentchatplayer_"..WindowData.RecentChatPlayerIdList[i]
		
		-- create element
		CreateWindowFromTemplate(currentChannelButton, "PlayerListIgnoreButtonTemplate", "PlayerListIgnoreChildWindow")

		-- fill the button text with the player name and ID
		ButtonSetText(currentChannelButton, L"<"..WindowData.RecentChatPlayerIdList[i] .. L"> " .. WindowData.RecentChatPlayerNameList[i])

		-- set the player ID to the button
		WindowSetId(currentChannelButton, WindowData.RecentChatPlayerIdList[i])

		-- initialize the button
		ButtonSetPressedFlag(currentChannelButton, false)
		
		-- do we have a previous element?
		if previousChannelButton == nil then

			-- anchor the element to the top-left
			WindowAddAnchor(currentChannelButton, "topleft", "PlayerListIgnoreChildWindow", "topleft", 10, 5)

			-- highlight the button
			ButtonSetPressedFlag(currentChannelButton, true)

			-- store the selected element ID
			IgnoreWindow.currentSelection = WindowData.RecentChatPlayerIdList[i]

		else -- anchor the element to the previous one
			WindowAddAnchor(currentChannelButton, "bottomleft", previousChannelButton, "topleft", 0, 0)
		end

		-- update the previous element name with the current one
		previousChannelButton = currentChannelButton
	end

	-- update the scroll window
	ScrollWindowUpdateScrollRect("PlayerListIgnoreWindow")
end

function IgnoreWindow.SelectPlayer()

	-- unhighlight the element currrently selected
	if IgnoreWindow.currentSelection and IgnoreWindow.currentSelection ~= -1 then
		ButtonSetPressedFlag("recentchatplayer_" .. tostring(previousSelection), false)
	end

	-- set the new selected item
	IgnoreWindow.currentSelection = WindowGetId(SystemData.ActiveWindow.name)
	
	-- highlight the element
	ButtonSetPressedFlag("recentchatplayer_" .. tostring(IgnoreWindow.currentSelection), true)
end

function IgnoreWindow.Add_OnLButtonUp()

	-- destroy the window if nothing has been selected
	if IgnoreWindow.currentSelection == -1 then
		DestroyWindow("IgnoreWindow")
		return
	end
	
	-- current selected element
	local windowName = "recentchatplayer_" .. tostring(IgnoreWindow.currentSelection)
	
	-- get the element text
	local rawNameText = ButtonGetText(windowName)

	-- find the position of ">"
	local nameSearchPos = wstring.find(rawNameText, L">", 1, true)

	-- extract the player name from the button text
	local nameString = wstring.sub(rawNameText, nameSearchPos + 1)
	
	-- add the player to the ignore list
	AddPlayerToIgnoreList(WindowGetId(windowName), nameString, SettingsWindow.ignoreListType)
	
	-- destroy the window
	DestroyWindow("IgnoreWindow")
end

function IgnoreWindow.Cancel_OnLButtonUp()

	-- desroy the window
	DestroyWindow("IgnoreWindow")
end