----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

NewChatWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

NewChatWindow.Messages = {}
NewChatWindow.Setting = nil
function NewChatWindow.InitializeSettings()
	NewChatWindow.Setting = LoadSaveStructureUserShard(NewChatWindow.Settings)
	if not NewChatWindow.Setting then
		NewChatWindow.Settings = CreateSaveStructureUserShard(NewChatWindow.Settings)
		NewChatWindow.Setting = LoadSaveStructureUserShard(NewChatWindow.Settings)
	end
		
	if NewChatWindow.Setting.Messages== nil then
		NewChatWindow.Setting.Messages = {}
	end
	
	for i = #NewChatWindow.Setting.Messages, 1, -1 do
		table.insert(NewChatWindow.Messages, 1, NewChatWindow.Setting.Messages[i])
	end

end

NewChatWindow.Initialized = false 

NewChatWindow.WindowName = "NewChatWindow"
NewChatWindow.WINDOW_WIDTH_MAX = 800
NewChatWindow.WINDOW_HEIGHT_MAX = 800

NewChatWindow.NormalColor = { r=51, g=204, b=255 }
NewChatWindow.ActiveColor = { r=51, g=204, b=51 }
NewChatWindow.HighlightColor = { r=255, g=255, b=0 }

NewChatWindow.maxTabs = 20

NewChatWindow.deltaUpd = 0
NewChatWindow.UpdateReq = false

NewChatWindow.blockUpdate = false

NewChatWindow.LastMsg = {}

NewChatWindow.LastVis = {}

NewChatWindow.totalHeight = {}

NewChatWindow.Labels = {}
NewChatWindow.PrevLabels = {}

NewChatWindow.delta = 0
NewChatWindow.hidden = false
NewChatWindow.waithide = false

NewChatWindow.TabCount = 1
NewChatWindow.TabStatus = {}

NewChatWindow.LastDock = 0

NewChatWindow.ActiveTab = 1

NewChatWindow.ChannelsEnabled = {}

NewChatWindow.DefaultFont = 1
NewChatWindow.ChannelsFonts = {}

NewChatWindow.DefaultFontSize = 16
NewChatWindow.ChannelsFontsSize = {}

NewChatWindow.ChannelColors = {}

NewChatWindow.curChannel =  nil
NewChatWindow.prevChannel = nil

NewChatWindow.MinUpdateRate = 0.3

NewChatWindow.firstGChatSelect = true

NewChatWindow.Filter = {}
NewChatWindow.Filter[1] = 	GetStringFromTid(1011051)
NewChatWindow.Filter[2] = 	GetStringFromTid(1154822)
NewChatWindow.Filter[3] = 	GetStringFromTid(1078866)
NewChatWindow.Filter[4] = 	GetStringFromTid(1154823)
NewChatWindow.Filter[5] = 	GetStringFromTid(1153802)
NewChatWindow.Filter[6] = 	GetStringFromTid(1095164)
NewChatWindow.Filter[7] = 	GetStringFromTid(1154824)
NewChatWindow.Filter[8] = 	GetStringFromTid(3000509)
NewChatWindow.Filter[9] = 	GetStringFromTid(1154825)
NewChatWindow.Filter[10] =	GetStringFromTid(1154826)

NewChatWindow.SwitchOrder = {}
NewChatWindow.SwitchID = 1

NewChatWindow.PlayerName = L""

NewChatWindow.GC_SHOW_UNAVAILABLE = 0
NewChatWindow.GC_SHOW_CHAT = 1

NewChatWindow.Presence = {}
NewChatWindow.Presence[1] = {tid = 1070798, id = NewChatWindow.GC_SHOW_UNAVAILABLE, color = {r = 255, g = 0, b = 0}}
NewChatWindow.Presence[2] = {tid = 1063015, id = NewChatWindow.GC_SHOW_CHAT, color = {r = 0, g = 255, b = 0}}

NewChatWindow.currentSelection = -1

NewChatWindow.createdChannelsLabels = 0
NewChatWindow.friendsLabels = 0

NewChatWindow.currentChannel = L""

NewChatWindow.ChannelTID = {
	YourCurrentChannel = 1114072,
	Title = 1114073,
	Join = 1114074,
	Leave = 1114075,
	Create = 1114076,
	Okay = 3000093,
	Cancel = 1006045,
	CreateChannelTitle = 1114077,

	Add_Friend = 3006110,
	Add_Friend_Detail = 1158421,
	Status = 1153034,
}

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------
function NewChatWindow.SetVisible()
	WindowSetShowing(NewChatWindow.WindowName, Interface.Settings.chat_useNewChat)
	WindowSetShowing(NewChatWindow.WindowName .. "JournalWindow", Interface.Settings.chat_useNewChat)
	for i = 1, NewChatWindow.maxTabs do
		local templatename = "Bookmark" .. i
		if (DoesWindowExist(templatename)) then
			WindowSetShowing(templatename, Interface.Settings.chat_useNewChat)
		end
		if (DoesWindowExist("NewChatWindow" .. i)) then
			WindowSetShowing("NewChatWindow" .. i, Interface.Settings.chat_useNewChat)
		end
		if (DoesWindowExist("NewChatWindowBookmark" .. i)) then
			WindowSetShowing("NewChatWindowBookmark" .. i, Interface.Settings.chat_useNewChat)
		end
	end
end

function NewChatWindow.UpdateMenuSelection()
    local parentName = WindowGetParent( SystemData.ActiveWindow.name )
    WindowClearAnchors( parentName.."Selection" )
    WindowAddAnchor( parentName.."Selection", "topleft", SystemData.ActiveWindow.name, "topleft", -6, -4 )
    WindowAddAnchor( parentName.."Selection", "bottomright", SystemData.ActiveWindow.name, "bottomright", -8, 4 )
    WindowSetShowing( parentName.."Selection", true )
end

function NewChatWindow.HideChannelSelectionMenu()
    WindowAssignFocus( "NewChatChannelSelectionWindow", false )
    WindowSetShowing("NewChatChannelSelectionWindow", false)
end

function NewChatWindow.HideChatContactsMenu()
    WindowAssignFocus( "NewChatContactsWindow", false )
    WindowSetShowing("NewChatContactsWindow", false)
end

function NewChatWindow.OnKeyTab()
	NewChatWindow.SwitchID = NewChatWindow.SwitchID + 1
	if NewChatWindow.SwitchID > #NewChatWindow.SwitchOrder then
		NewChatWindow.SwitchID = 1
	end
	NewChatWindow.prevChannel = NewChatWindow.SwitchOrder[NewChatWindow.SwitchID]
	NewChatWindow.ChatWindowSwitchChannelWithExistingText(ChatWindowContainerTextInput.Text)
end

function NewChatWindow.OnKeyEscape()

	-- is the legacy chat turned off?
	if not SystemData.Settings.Interface.LegacyChat then
		
		-- flag not to show the main menu
		MainMenuWindow.notnow =  true
	end
	
	NewChatWindow.ChatWindowResetTextBox()

    -- Hide the Text Input Window
    WindowAssignFocus( "ChatWindowContainerTextInput", false )
    WindowSetShowing( "ChatWindowContainer", false )
end

function NewChatWindow.ChatWindowResetTextBox()

    -- Reanchor the Text Box
    WindowClearAnchors("ChatWindowContainerTextInput")
    WindowAddAnchor("ChatWindowContainerTextInput", "topright", "ChatWindowContainerChannelLabel", "topleft", 2, -6)
    WindowAddAnchor("ChatWindowContainerTextInput", "bottomright", "ChatWindowContainer", "bottomright", 0, 2)
    
    -- Clear the Text
    TextEditBoxSetText("ChatWindowContainerTextInput", L"")  

    -- Reset the color to white
    TextEditBoxSetTextColor ("ChatWindowContainerTextInput", 255, 255, 255)
    
    -- Reset all the label stuff
    LabelSetTextColor ("ChatWindowContainerChannelLabel", 255, 255, 255)
                                                 
    LabelSetText ("ChatWindowContainerChannelLabel", L"")
    
    NewChatWindow.UpdateCurrentChannel (nil)

end

function NewChatWindow.OnKeyEnter()
	
    local chatChannel = L""
    local chatText = ChatWindowContainerTextInput.Text
    if (NewChatWindow.curChannel == 16) then
		ChatPrint(chatText, NewChatWindow.curChannel)
		NewChatWindow.CloseChatBox()
		return
    end
    if (NewChatWindow.curChannel ~= nil) then
        -- This is the channel that the text will go to...
        chatChannel = ChatSettings.Channels[NewChatWindow.curChannel].serverCmd
    end

    --Debug.Print(L"ChatWindow.OnKeyEnter: text="..chatChannel..L" "..chatText)
   
    if (chatChannel == L"/tell") then
		chatChannel = ChatSettings.Channels[SystemData.ChatLogFilters.SAY].serverCmd
		chatText = L"; " .. chatText
    end
    SendChat(chatChannel, chatText)
    
    NewChatWindow.ChatWindowResetTextBox()
    
    -- Hide the Text Input Window
    WindowAssignFocus( "ChatWindowContainerTextInput", false )
    WindowSetShowing( "ChatWindowContainer", false )
end

function NewChatWindow.ChatWindowSwitchChannelWithExistingText(existingText)
    
    -- Set the Focus to the text input
    WindowSetShowing( "ChatWindowContainer", true )
    WindowSetShowing( "ChatWindowContainerTextInput", true )
    WindowAssignFocus( "ChatWindowContainerTextInput", true )
    
    if (existingText == nil) then
        existingText = L""
    end
    
    -- Set the default channel to Say or the previous channel
    if (NewChatWindow.curChannel == nil and NewChatWindow.prevChannel == nil) then
        NewChatWindow.SwitchToChatChannel (SystemData.ChatLogFilters.SAY, ChatSettings.Channels[SystemData.ChatLogFilters.SAY].labelText, existingText)
    elseif (NewChatWindow.prevChannel ~= nil) then
        if (NewChatWindow.prevChannel == SystemData.ChatLogFilters.TELL_SEND and whisperTarget ~= nil) then
            NewChatWindow.SwitchToChatChannel (NewChatWindow.prevChannel, ChatWindow.FormatWhisperPrompt (whisperTarget), existingText)
        else
			if (NewChatWindow.prevChannel == 16) then  
				NewChatWindow.SwitchToChatChannel (NewChatWindow.prevChannel, L"[Self]:", existingText)
			else
				NewChatWindow.SwitchToChatChannel (NewChatWindow.prevChannel, ChatSettings.Channels[NewChatWindow.prevChannel].labelText, existingText)
			end
        end
    end
end

function NewChatWindow.SwitchToSelectedChannel()
    local windowId = WindowGetId(SystemData.ActiveWindow.name)
	
	if not IsValidID(windowId) then
		return
	end

    local chatChannelId
    local label
    if (windowId == 16) then
		chatChannelId = windowId
		label = L"[Self]:"
	else
		chatChannelId = ChatSettings.Channels[windowId].id
		label = ChatSettings.Channels[chatChannelId].labelText
    end
    
    NewChatWindow.SwitchToChatChannel(chatChannelId, label )
    NewChatWindow.UpdateCurrentChannel(chatChannelId)
    -- Show the Text Input Window and Hide the menu
    WindowAssignFocus( "NewChatChannelSelectionWindow", false )
    WindowSetShowing( "ChatWindowContainer", true )
    WindowSetShowing( "ChatWindowContainerTextInput", true )
    WindowAssignFocus( "ChatWindowContainerTextInput", true )
    WindowSetShowing("NewChatChannelSelectionWindow", false)
end

function NewChatWindow.DragBar(flags)
	
	-- current line name
	local this = SystemData.ActiveWindow.name
	
	-- if we are holding control, we tell EC Playsound to copy the text
	if flags == WindowUtils.ButtonFlags.CONTROL then
	
		-- get the label text
		local text = LabelGetText(this)

		-- scan the
		for i = #NewChatWindow.Messages, 1, -1 do

			-- does the label contains the message text?
			if not wstring.find(text, NewChatWindow.Messages[i].text, 1, true) then
				continue
			end

			-- do we have a source name?
			if IsValidWString(NewChatWindow.Messages[i].sourceName) then
				
				-- does the label contains the source name?
				if	not wstring.find(text, NewChatWindow.Messages[i].sourceName .. L": ", 1, true) and
					not wstring.find(text, NewChatWindow.Messages[i].sourceName .. L"]: ", 1, true)
				then
					continue
				end
			end

			-- send the text to EC Playsound so that it can be stored in the system clipboard
			CreateTextFile("logs/copytext.txt", towstring(NewChatWindow.Messages[i].text))

			-- we can get out
			return
		end

	else -- just clicked

		-- get the mobile ID
		local mobileId = WindowGetId(this)

		-- do we have a valid ID?
		if not IsValidID(mobileId) then
			return
		end

		-- create a variable as pointer for the bar record
		local barData = MobileHealthBar.ActiveBars[mobileId]

		-- do we have a valid ID and the mobile is not a pet or a party member?
		if not IsValidID(mobileId) or IsObjectIdPet(mobileId) or IsPartyMember(mobileId) or (barData and barData.pinned) then
			return
		end

		-- by default we create a new bar
		local callback = function() MobileHealthBar.CreateBar(mobileId, true) end

		-- does the healthbar already exist?
		if barData then

			-- if the bar exist, we pin it (if it's already pinned, nothing will happen)
			callback = function() MobileHealthBar.PinBar(mobileId) end
		end

		-- create a pinned bar if the drag is successful
		WindowUtils.BeginDrag(callback, mobileId)
	end
end

function NewChatWindow.EndDragBar()

	-- terminate the dragging, verify if we actually dragged a bar or just clicked the mobile
	WindowUtils.EndDrag()
end

function NewChatWindow.UpdateCurrentChannel(icurChannel)
    NewChatWindow.prevChannel = NewChatWindow.curChannel
    NewChatWindow.curChannel  = icurChannel
end

NewChatWindow.ChannelJustHidden = false
function NewChatWindow.MenuItemMouseLeave()
	local this = SystemData.ActiveWindow.name
	local parent = WindowGetParent(this)
	if (not WindowHasFocus("NewChatChannelSelectionWindow")) then
		NewChatWindow.HideChannelSelectionMenu()
		NewChatWindow.ChannelJustHidden = true
		Interface.AddTodoList({name = "chat delayed fading", func = function() NewChatWindow.ChannelJustHidden = false end, time = Interface.TimeSinceLogin + 0.5})
	end
end

NewChatWindow.ContactsJustHidden = false
function NewChatWindow.ContactsMenuItemMouseLeave()
	local this = SystemData.ActiveWindow.name
	local parent = WindowGetParent(this)
	if (not WindowHasFocus("NewChatContactsWindow") and not WindowHasFocus("ContextMenu")) then
		NewChatWindow.HideChatContactsMenu()
		NewChatWindow.ContactsJustHidden = true
		Interface.AddTodoList({name = "chat delayed fading", func = function() NewChatWindow.ContactsJustHidden = false end, time = Interface.TimeSinceLogin + 0.5})
	end
end

local function IsSlashCommandInChannel( slashCommand, channel )
    return ( slashCommand ~= nil and
             channel ~= nil and
             channel.slashCmds ~= nil and
             channel.slashCmds[slashCommand] == 1 )
end


function NewChatWindow.SwitchToChatChannel(ichannelIdx, ichannelPrompt, iexistingText)
    NewChatWindow.UpdateCurrentChannel(ichannelIdx)
    
    local channelColor = NewChatWindow.ChannelColors[ ichannelIdx ]
    if (not channelColor) then
		channelColor = NewChatWindow.ChannelColors[ SystemData.ChatLogFilters.SAY ]
	end
	if (ichannelIdx == 16) then
		ichannelPrompt = L"[Self]:"
		channelColor = {}
		channelColor.r, channelColor.g, channelColor.b = HueRGBAValue(1195)
    end
    
	if ichannelIdx == SystemData.ChatLogFilters.SAY then
		channelColor.r,channelColor.g,channelColor.b = HueRGBAValue(SystemData.Settings.Interface.SpeechHue)
	end
		
    TextEditBoxSetTextColor ("ChatWindowContainerTextInput", channelColor.r, channelColor.g, channelColor.b)

    if IsValidWString(iexistingText) then
        TextEditBoxSetText("ChatWindowContainerTextInput", iexistingText)
    else
        TextEditBoxSetText("ChatWindowContainerTextInput", L"")  
    end
    WindowSetShowing("ChatWindowContainerTextInput", true)
    
    --WindowAssignFocus( "ChatWindowContainerTextInput", true )

    LabelSetTextColor("ChatWindowContainerChannelLabel", channelColor.r, channelColor.g, channelColor.b)
    
    LabelSetText ("ChatWindowContainerChannelLabel", ichannelPrompt)
end


function NewChatWindow.DoChatTextReplacement ()  
   
    local spaceIdx      = nil
    local restOfLine    = nil
    spaceIdx = wstring.find(ChatWindowContainerTextInput.Text, L" ", 1, true)

    -- Make sure spaceIdx is not 1 so that you can type instructions on how to
    -- type slash commands to other people...otherwise, this will continue to try parsing
    -- slash-commands even if you insert a bunch of spaces...
    if (spaceIdx ~= nil and spaceIdx ~= 1) then
                
        local firstWord = wstring.sub (ChatWindowContainerTextInput.Text, 1, spaceIdx)        
        restOfLine      = wstring.sub (ChatWindowContainerTextInput.Text, spaceIdx + 1)
        
        -- Make sure that the first word begins with a /
        -- Then check to see if you typed a slash command that will switch your channel
        if (wstring.find(firstWord, L"/", 1, true) ~= 1) then return end
        
        --DEBUG (L"You typed: ["..firstWord..L"], looking in all channels for that command...");
                
        for ixChannel, curChannell in pairs(ChatSettings.Channels) do 
			
            if (IsSlashCommandInChannel (firstWord, curChannell )) then

				
				if (ixChannel == SystemData.ChatLogFilters.GLOBAL_CHAT) then
                    NewChatWindow.SwitchToGChatSelectedChannel()
                else
                    -- Otherwise it's a regular channel, no crazy arguments...just do the switch
					NewChatWindow.SwitchToChatChannel (ixChannel, curChannell.labelText, restOfLine)
                end

                return
                
            end
        end
         if (IsSlashCommandInChannel (firstWord, ChatSettings.Channels[SystemData.ChatLogFilters.GM])) then
			 NewChatWindow.SwitchToChatChannel (SystemData.ChatLogFilters.GM, ChatSettings.Channels[SystemData.ChatLogFilters.GM].labelText, restOfLine)
			 return   
         end
         if (wstring.find(wstring.lower(firstWord), L"/self", 1, true)) then
			 NewChatWindow.SwitchToChatChannel (16, L"[Self]:", restOfLine)
			 return   
         end
    end
end

function NewChatWindow.SwitchToGChatSelectedChannel(existingText)
    
    if (existingText == nil) then
        existingText = L""
    end
      
    local chatChannelId =  SystemData.ChatLogFilters.GLOBAL_CHAT
    WindowData.GChatIndex = ComboBoxGetSelectedMenuItem( "NewChatChannelSelectionWindowGChatActiveFriendSelectCombo")
    
    if ((WindowData.GChatIndex <= 0) or (WindowData.GChatCount == 0)) then
        return
    end
    --Debug.Print("SwitchToGChatSelectedChannel("..tostring(WindowData.GChatIndex)..") Before")
    if (NewChatWindow.firstGChatSelect) then
        WindowData.GChatIndex = WindowData.GChatIndex - 1
        NewChatWindow.firstGChatSelect = false
        NewChatWindow.OnComboRosterUpdate()           
    end    
    --Debug.Print("SwitchToGChatSelectedChannel("..tostring(WindowData.GChatIndex)..") After")
    
	local name = WindowData.GChatNameList[WindowData.GChatIndex]

	if not name then
		-- retry later
		Interface.AddTodoList({name = "chat switch to channel retry", func = function() NewChatWindow.SwitchToGChatSelectedChannel(existingText) end, time = Interface.TimeSinceLogin + 0.5})
		return
	end
    local friendName = L"[" .. towstring(name) .. L"]:"
    local friendPresence = WindowData.GChatPresenceList[WindowData.GChatIndex]
    
    NewChatWindow.SwitchToChatChannel(chatChannelId, friendName, existingText)
    NewChatWindow.UpdateCurrentChannel(chatChannelId)
    -- Show the Text Input Window and Hide the menu
    WindowAssignFocus( "NewChatChannelSelectionWindow", false )
    WindowSetShowing( "ChatWindowContainer", true )
	WindowAssignFocus( "ChatWindowContainerTextInput", true )
    WindowSetShowing("NewChatChannelSelectionWindow", false)
    
    NewChatWindow.SelectActiveFriend(WindowData.GChatIndex)
end

function NewChatWindow.OnComboRosterUpdate()    
    ComboBoxClearMenuItems("NewChatChannelSelectionWindowGChatActiveFriendSelectCombo")
    if WindowData.GChatCount == 0 or NewChatWindow.firstGChatSelect then
        ComboBoxAddMenuItem( "NewChatChannelSelectionWindowGChatActiveFriendSelectCombo",  L"/Select Friend" )
        WindowData.GChatIndex = 1;
        ComboBoxSetSelectedMenuItem( "NewChatChannelSelectionWindowGChatActiveFriendSelectCombo",  WindowData.GChatIndex)        
    end
    for i = 1, WindowData.GChatCount do
       ComboBoxAddMenuItem( "NewChatChannelSelectionWindowGChatActiveFriendSelectCombo",  towstring(WindowData.GChatNameList[i]))        
    end
    if ((WindowData.GChatIndex > 0) and (WindowData.GChatIndex <= WindowData.GChatCount)) then
        ComboBoxSetSelectedMenuItem( "NewChatChannelSelectionWindowGChatActiveFriendSelectCombo",  WindowData.GChatIndex)        
    else
        ComboBoxSetSelectedMenuItem( "NewChatChannelSelectionWindowGChatActiveFriendSelectCombo", 1 ) --SystemData.ChatLogFilters.GLOBAL_CHAT
        WindowData.GChatIndex = 1   
    end     
end

function NewChatWindow.Initialize()
	if (not Interface.started) then
		return
	end
	NewChatWindow.InitializeChannelMenuSelectionWindow()
	NewChatWindow.InitializeContactsWindow()
	NewChatOptionsWindow.Initialize()

	NewChatWindow.PlayerName = GetMobileName(GetPlayerID())
	
	for i = 0, NewChatWindow.maxTabs do
		NewChatWindow.LastMsg[i] = 1
		NewChatWindow.LastVis[i] = 1
		NewChatWindow.totalHeight[i] = 0
		NewChatWindow.Labels[i] = 0
		NewChatWindow.PrevLabels[i] = 0
	end
	
	NewChatWindow.SwitchOrder = {}
	NewChatWindow.SwitchOrder[1] = SystemData.ChatLogFilters.SAY
	NewChatWindow.SwitchOrder[2] = SystemData.ChatLogFilters.CUSTOM
	NewChatWindow.SwitchOrder[3] = SystemData.ChatLogFilters.PARTY
	NewChatWindow.SwitchOrder[4] = SystemData.ChatLogFilters.GUILD
	NewChatWindow.SwitchOrder[5] = SystemData.ChatLogFilters.ALLIANCE
	NewChatWindow.SwitchOrder[6] = SystemData.ChatLogFilters.GM
	
	
	for i= 1, NewChatWindow.maxTabs do
		NewChatWindow.ChannelsEnabled[i] = {}
		NewChatWindow.ChannelsEnabled[i][ SystemData.ChatLogFilters.SAY ]           = Interface.LoadSetting( "ChannelsEnabled" .. i .. SystemData.ChatLogFilters.SAY,false )
		NewChatWindow.ChannelsEnabled[i][ SystemData.ChatLogFilters.WHISPER ]       = Interface.LoadSetting( "ChannelsEnabled" .. i .. SystemData.ChatLogFilters.WHISPER,false )
		NewChatWindow.ChannelsEnabled[i][ SystemData.ChatLogFilters.PARTY ]         = Interface.LoadSetting( "ChannelsEnabled" .. i .. SystemData.ChatLogFilters.PARTY,false ) 
		NewChatWindow.ChannelsEnabled[i][ SystemData.ChatLogFilters.GUILD ]         = Interface.LoadSetting( "ChannelsEnabled" .. i .. SystemData.ChatLogFilters.GUILD,false ) 
		NewChatWindow.ChannelsEnabled[i][ SystemData.ChatLogFilters.ALLIANCE ]      = Interface.LoadSetting( "ChannelsEnabled" .. i .. SystemData.ChatLogFilters.ALLIANCE,false ) 
		NewChatWindow.ChannelsEnabled[i][ SystemData.ChatLogFilters.EMOTE ]         = Interface.LoadSetting( "ChannelsEnabled" .. i .. SystemData.ChatLogFilters.EMOTE,false ) 
		NewChatWindow.ChannelsEnabled[i][ SystemData.ChatLogFilters.YELL ]          = Interface.LoadSetting( "ChannelsEnabled" .. i .. SystemData.ChatLogFilters.YELL,false )  
		NewChatWindow.ChannelsEnabled[i][ SystemData.ChatLogFilters.SYSTEM ]        = Interface.LoadSetting( "ChannelsEnabled" .. i .. SystemData.ChatLogFilters.SYSTEM,false )  
		NewChatWindow.ChannelsEnabled[i][ SystemData.ChatLogFilters.PRIVATE ]       = Interface.LoadSetting( "ChannelsEnabled" .. i .. SystemData.ChatLogFilters.PRIVATE,false )  
		NewChatWindow.ChannelsEnabled[i][ SystemData.ChatLogFilters.CUSTOM ]        = Interface.LoadSetting( "ChannelsEnabled" .. i .. SystemData.ChatLogFilters.CUSTOM,false )  -- CHAT
		NewChatWindow.ChannelsEnabled[i][ SystemData.ChatLogFilters.GESTURE ]       = Interface.LoadSetting( "ChannelsEnabled" .. i .. SystemData.ChatLogFilters.GESTURE,false )  
		NewChatWindow.ChannelsEnabled[i][ 12 ]										= Interface.LoadSetting( "ChannelsEnabled" .. i .. 12,false )  -- PRIVATE MESSAGES
		NewChatWindow.ChannelsEnabled[i][ SystemData.ChatLogFilters.GM ]            = true
		NewChatWindow.ChannelsEnabled[i][ SystemData.ChatLogFilters.GLOBAL_CHAT ]   = Interface.LoadSetting( "ChannelsEnabled" .. i .. SystemData.ChatLogFilters.GLOBAL_CHAT,true )  
		NewChatWindow.ChannelsEnabled[i][ 15 ]										= Interface.LoadSetting( "ChannelsEnabled" .. i .. 15,false )  -- You See
		NewChatWindow.ChannelsEnabled[i][ 16 ]										= Interface.LoadSetting( "ChannelsEnabled" .. i .. 16,false )  -- Note to self
		NewChatWindow.ChannelsEnabled[i][ 17 ]										= Interface.LoadSetting( "ChannelsEnabled" .. i .. 17,false )  -- DAMAGE FILTER
    end
    
    
    NewChatWindow.ChannelsFonts[ SystemData.ChatLogFilters.SAY ]           = Interface.LoadSetting( "ChannelsFonts" .. SystemData.ChatLogFilters.SAY,NewChatWindow.DefaultFont )
    NewChatWindow.ChannelsFonts[ SystemData.ChatLogFilters.WHISPER ]       = Interface.LoadSetting( "ChannelsFonts" .. SystemData.ChatLogFilters.WHISPER,NewChatWindow.DefaultFont )
    NewChatWindow.ChannelsFonts[ SystemData.ChatLogFilters.PARTY ]         = Interface.LoadSetting( "ChannelsFonts" .. SystemData.ChatLogFilters.PARTY,NewChatWindow.DefaultFont ) 
    NewChatWindow.ChannelsFonts[ SystemData.ChatLogFilters.GUILD ]         = Interface.LoadSetting( "ChannelsFonts" .. SystemData.ChatLogFilters.GUILD,NewChatWindow.DefaultFont ) 
    NewChatWindow.ChannelsFonts[ SystemData.ChatLogFilters.ALLIANCE ]      = Interface.LoadSetting( "ChannelsFonts" .. SystemData.ChatLogFilters.ALLIANCE,NewChatWindow.DefaultFont ) 
    NewChatWindow.ChannelsFonts[ SystemData.ChatLogFilters.EMOTE ]         = Interface.LoadSetting( "ChannelsFonts" .. SystemData.ChatLogFilters.EMOTE,NewChatWindow.DefaultFont ) 
    NewChatWindow.ChannelsFonts[ SystemData.ChatLogFilters.YELL ]          = Interface.LoadSetting( "ChannelsFonts" .. SystemData.ChatLogFilters.YELL,NewChatWindow.DefaultFont )  
    NewChatWindow.ChannelsFonts[ SystemData.ChatLogFilters.SYSTEM ]        = Interface.LoadSetting( "ChannelsFonts" .. SystemData.ChatLogFilters.SYSTEM,NewChatWindow.DefaultFont )  
    NewChatWindow.ChannelsFonts[ SystemData.ChatLogFilters.PRIVATE ]       = Interface.LoadSetting( "ChannelsFonts" .. SystemData.ChatLogFilters.PRIVATE,NewChatWindow.DefaultFont )  
    NewChatWindow.ChannelsFonts[ SystemData.ChatLogFilters.CUSTOM ]        = Interface.LoadSetting( "ChannelsFonts" .. SystemData.ChatLogFilters.CUSTOM,NewChatWindow.DefaultFont )  
    NewChatWindow.ChannelsFonts[ SystemData.ChatLogFilters.GESTURE ]       = Interface.LoadSetting( "ChannelsFonts" .. SystemData.ChatLogFilters.GESTURE,NewChatWindow.DefaultFont )  
	NewChatWindow.ChannelsFonts[ 12 ]									   = Interface.LoadSetting( "ChannelsFonts12",NewChatWindow.DefaultFont )  -- Private messages
	NewChatWindow.ChannelsFonts[ SystemData.ChatLogFilters.GM ]            = Interface.LoadSetting( "ChannelsFonts" .. SystemData.ChatLogFilters.GM,NewChatWindow.DefaultFont ) 
	NewChatWindow.ChannelsFonts[ SystemData.ChatLogFilters.GLOBAL_CHAT ]    = Interface.LoadSetting( "ChannelsFonts" .. SystemData.ChatLogFilters.GLOBAL_CHAT,NewChatWindow.DefaultFont ) 
    NewChatWindow.ChannelsFonts[ 15 ]										= Interface.LoadSetting( "ChannelsFonts15",NewChatWindow.DefaultFont )  -- You See
    NewChatWindow.ChannelsFonts[ 16 ]										= Interface.LoadSetting( "ChannelsFonts16",NewChatWindow.DefaultFont )  -- Note to self
    NewChatWindow.ChannelsFonts[ 17 ]									   = Interface.LoadSetting( "ChannelsFonts17",NewChatWindow.DefaultFont )  -- DAMAGE FILTER

    
    NewChatWindow.ChannelsFontsSize[ SystemData.ChatLogFilters.SAY ]           = Interface.LoadSetting( "ChannelsFontsSize" .. SystemData.ChatLogFilters.SAY,NewChatWindow.DefaultFontSize )
    NewChatWindow.ChannelsFontsSize[ SystemData.ChatLogFilters.WHISPER ]       = Interface.LoadSetting( "ChannelsFontsSize" .. SystemData.ChatLogFilters.WHISPER,NewChatWindow.DefaultFontSize )
    NewChatWindow.ChannelsFontsSize[ SystemData.ChatLogFilters.PARTY ]         = Interface.LoadSetting( "ChannelsFontsSize" .. SystemData.ChatLogFilters.PARTY,NewChatWindow.DefaultFontSize ) 
    NewChatWindow.ChannelsFontsSize[ SystemData.ChatLogFilters.GUILD ]         = Interface.LoadSetting( "ChannelsFontsSize" .. SystemData.ChatLogFilters.GUILD,NewChatWindow.DefaultFontSize ) 
    NewChatWindow.ChannelsFontsSize[ SystemData.ChatLogFilters.ALLIANCE ]      = Interface.LoadSetting( "ChannelsFontsSize" .. SystemData.ChatLogFilters.ALLIANCE,NewChatWindow.DefaultFontSize ) 
    NewChatWindow.ChannelsFontsSize[ SystemData.ChatLogFilters.EMOTE ]         = Interface.LoadSetting( "ChannelsFontsSize" .. SystemData.ChatLogFilters.EMOTE,NewChatWindow.DefaultFontSize ) 
    NewChatWindow.ChannelsFontsSize[ SystemData.ChatLogFilters.YELL ]          = Interface.LoadSetting( "ChannelsFontsSize" .. SystemData.ChatLogFilters.YELL,NewChatWindow.DefaultFontSize )  
    NewChatWindow.ChannelsFontsSize[ SystemData.ChatLogFilters.SYSTEM ]        = Interface.LoadSetting( "ChannelsFontsSize" .. SystemData.ChatLogFilters.SYSTEM,NewChatWindow.DefaultFontSize )  
    NewChatWindow.ChannelsFontsSize[ SystemData.ChatLogFilters.PRIVATE ]       = Interface.LoadSetting( "ChannelsFontsSize" .. SystemData.ChatLogFilters.PRIVATE,NewChatWindow.DefaultFontSize )  
    NewChatWindow.ChannelsFontsSize[ SystemData.ChatLogFilters.CUSTOM ]        = Interface.LoadSetting( "ChannelsFontsSize" .. SystemData.ChatLogFilters.CUSTOM,NewChatWindow.DefaultFontSize )  
    NewChatWindow.ChannelsFontsSize[ SystemData.ChatLogFilters.GESTURE ]       = Interface.LoadSetting( "ChannelsFontsSize" .. SystemData.ChatLogFilters.GESTURE,NewChatWindow.DefaultFontSize )  
    NewChatWindow.ChannelsFontsSize[ 12 ]									   = Interface.LoadSetting( "ChannelsFontsSize12" ,NewChatWindow.DefaultFontSize  )  -- Private Messages
	NewChatWindow.ChannelsFontsSize[ SystemData.ChatLogFilters.GM ]            = Interface.LoadSetting( "ChannelsFontsSize" .. SystemData.ChatLogFilters.GM,NewChatWindow.DefaultFontSize ) 
    NewChatWindow.ChannelsFontsSize[ SystemData.ChatLogFilters.GLOBAL_CHAT ]        = Interface.LoadSetting( "ChannelsFontsSize" .. SystemData.ChatLogFilters.GLOBAL_CHAT,NewChatWindow.DefaultFontSize ) 
    NewChatWindow.ChannelsFontsSize[ 15 ]											= Interface.LoadSetting( "ChannelsFontsSize15" ,NewChatWindow.DefaultFontSize  )  -- You see
    NewChatWindow.ChannelsFontsSize[ 16 ]											= Interface.LoadSetting( "ChannelsFontsSize16" ,NewChatWindow.DefaultFontSize  )  -- Note to self
    NewChatWindow.ChannelsFontsSize[ 17 ]									   = Interface.LoadSetting( "ChannelsFontsSize17" ,NewChatWindow.DefaultFontSize  )  -- DAMAGE FILTER
   

	if (Interface.Settings.chat_BaseAlpha < 0.01) then
		Interface.Settings.chat_BaseAlpha = 0.01
	end 
  	 
	WindowSetShowing("NewChatWindowResizeButton", not Interface.Settings.chat_locked)
		 
	NewChatWindow.TabCount = Interface.LoadSetting( "NewChatWindowTabCount",NewChatWindow.TabCount )
	if (NewChatWindow.TabCount < 1) then
		NewChatWindow.TabCount = 1
	end
     
   SnapUtils.SnappableWindows["NewChatWindow"] = true
   
    WindowSetDimensions("NewChatWindow", 400, 200)
	NewChatWindow.OnResizeEnd(NewChatWindow.WindowName)
   
	if Interface.NewChatFirstPositioning then
		
		local x, y= WindowGetOffsetFromParent("ResizeWindow")
		local w, h = WindowGetDimensions("ResizeWindow")
		WindowClearAnchors("NewChatWindow")
		WindowAddAnchor("NewChatWindow", "topleft", "Root", "topleft", x, (y + h)-240)
		
		Interface.NewChatFirstPositioning = nil
	else
		WindowUtils.RestoreWindowPosition("NewChatWindow", true)
		NewChatWindow.OnResizeEnd(NewChatWindow.WindowName)
	end
	
	NewChatWindow.InitializeSettings()
	
	NewChatWindow.LoadTabs()
	
	NewChatWindow.SetVisible()

	--NewChatWindow.UpdateLog()
	NewChatWindow.Initialized = true
	
end

function NewChatWindow.LoadTabs()
	local first = 0
	local row = 0
	local w, h = WindowGetDimensions("NewChatWindow")
	local bookmrkxRow = math.floor(w/90)-- 4
	local bookmrkxCount = 0
	for i = 1, NewChatWindow.maxTabs do
		local templatename = "Bookmark" .. i
		if (DoesWindowExist(templatename)) then
			DestroyWindow(templatename)
		end
		if (DoesWindowExist("NewChatWindow" .. i)) then
			DestroyWindow("NewChatWindow" .. i)
		end
		if (DoesWindowExist("NewChatWindowBookmark" .. i)) then
			DestroyWindow("NewChatWindowBookmark" .. i)
		end
	end
	NewChatWindow.LastDock = 0
	for i = 1, NewChatWindow.TabCount do
		local templatename = "Bookmark" .. i
		CreateWindowFromTemplate( templatename, "BookmarkTemplate", "Root" )
		WindowSetDimensions(templatename, 82, 30)
		local txt = L"ChatTab"
		if (Interface.Settings.chat_firstStart and i == 1) then
			Interface.SaveSetting( "chat_firstStart", false )
			txt = L"Journal"
			Interface.SaveSetting( "NewChatWindowTabName" .. i ,txt )
			Interface.SaveSetting( "ChannelsEnabled" .. 1 .. SystemData.ChatLogFilters.SAY,true )
			Interface.SaveSetting( "ChannelsEnabled" .. 1 .. SystemData.ChatLogFilters.WHISPER,true )
			Interface.SaveSetting( "ChannelsEnabled" .. 1 .. SystemData.ChatLogFilters.PARTY,true ) 
			Interface.SaveSetting( "ChannelsEnabled" .. 1 .. SystemData.ChatLogFilters.GUILD,true ) 
			Interface.SaveSetting( "ChannelsEnabled" .. 1 .. SystemData.ChatLogFilters.ALLIANCE,true ) 
			Interface.SaveSetting( "ChannelsEnabled" .. 1 .. SystemData.ChatLogFilters.EMOTE,true ) 
			Interface.SaveSetting( "ChannelsEnabled" .. 1 .. SystemData.ChatLogFilters.YELL,true )  
			Interface.SaveSetting( "ChannelsEnabled" .. 1 .. SystemData.ChatLogFilters.SYSTEM,true )  
			Interface.SaveSetting( "ChannelsEnabled" .. 1 .. SystemData.ChatLogFilters.PRIVATE,true )  
			Interface.SaveSetting( "ChannelsEnabled" .. 1 .. SystemData.ChatLogFilters.CUSTOM,true )  
			Interface.SaveSetting( "ChannelsEnabled" .. 1 .. SystemData.ChatLogFilters.GESTURE,true )  
			Interface.SaveSetting( "ChannelsEnabled" .. 1 .. 12,true )  -- Private Messages
			Interface.SaveSetting( "ChannelsEnabled" .. 1 .. SystemData.ChatLogFilters.GM,true )  
			Interface.SaveSetting( "ChannelsEnabled" .. 1 .. SystemData.ChatLogFilters.GLOBAL_CHAT,true )  
			Interface.SaveSetting( "ChannelsEnabled" .. 1 .. 15,true )  -- You See
			Interface.SaveSetting( "ChannelsEnabled" .. 1 .. 16,true )  -- Note to self
			Interface.SaveSetting( "ChannelsEnabled" .. 1 .. 17,true )  -- DAMAGE FILTER
			
			NewChatWindow.ChannelsEnabled[1] = {}
			NewChatWindow.ChannelsEnabled[1][ SystemData.ChatLogFilters.SAY ]           = Interface.LoadSetting( "ChannelsEnabled" .. 1 .. SystemData.ChatLogFilters.SAY,true )
			NewChatWindow.ChannelsEnabled[1][ SystemData.ChatLogFilters.WHISPER ]       = Interface.LoadSetting( "ChannelsEnabled" .. 1 .. SystemData.ChatLogFilters.WHISPER,true )
			NewChatWindow.ChannelsEnabled[1][ SystemData.ChatLogFilters.PARTY ]         = Interface.LoadSetting( "ChannelsEnabled" .. 1 .. SystemData.ChatLogFilters.PARTY,true ) 
			NewChatWindow.ChannelsEnabled[1][ SystemData.ChatLogFilters.GUILD ]         = Interface.LoadSetting( "ChannelsEnabled" .. 1 .. SystemData.ChatLogFilters.GUILD,true ) 
			NewChatWindow.ChannelsEnabled[1][ SystemData.ChatLogFilters.ALLIANCE ]      = Interface.LoadSetting( "ChannelsEnabled" .. 1 .. SystemData.ChatLogFilters.ALLIANCE,true ) 
			NewChatWindow.ChannelsEnabled[1][ SystemData.ChatLogFilters.EMOTE ]         = Interface.LoadSetting( "ChannelsEnabled" .. 1 .. SystemData.ChatLogFilters.EMOTE,true ) 
			NewChatWindow.ChannelsEnabled[1][ SystemData.ChatLogFilters.YELL ]          = Interface.LoadSetting( "ChannelsEnabled" .. 1 .. SystemData.ChatLogFilters.YELL,true )  
			NewChatWindow.ChannelsEnabled[1][ SystemData.ChatLogFilters.SYSTEM ]        = Interface.LoadSetting( "ChannelsEnabled" .. 1 .. SystemData.ChatLogFilters.SYSTEM,true )  
			NewChatWindow.ChannelsEnabled[1][ SystemData.ChatLogFilters.PRIVATE ]       = Interface.LoadSetting( "ChannelsEnabled" .. 1 .. SystemData.ChatLogFilters.PRIVATE,true )  
			NewChatWindow.ChannelsEnabled[1][ SystemData.ChatLogFilters.CUSTOM ]        = Interface.LoadSetting( "ChannelsEnabled" .. 1 .. SystemData.ChatLogFilters.CUSTOM,true )  
			NewChatWindow.ChannelsEnabled[1][ SystemData.ChatLogFilters.GESTURE ]       = Interface.LoadSetting( "ChannelsEnabled" .. 1 .. SystemData.ChatLogFilters.GESTURE,true )  
			NewChatWindow.ChannelsEnabled[1][ SystemData.ChatLogFilters.GM ]            = Interface.LoadSetting( "ChannelsEnabled" .. 1 .. SystemData.ChatLogFilters.GM,true )  
			NewChatWindow.ChannelsEnabled[1][ 12 ]										= Interface.LoadSetting( "ChannelsEnabled" .. 1 .. 12,true )  -- Private Messages
			NewChatWindow.ChannelsEnabled[1][ SystemData.ChatLogFilters.GLOBAL_CHAT ]   = Interface.LoadSetting( "ChannelsEnabled" .. 1 .. SystemData.ChatLogFilters.GM,true )  
			NewChatWindow.ChannelsEnabled[1][ 15 ]										= Interface.LoadSetting( "ChannelsEnabled" .. 1 .. 15,true )  -- You See
			NewChatWindow.ChannelsEnabled[1][ 16 ]										= Interface.LoadBoolean( "ChannelsEnabled" .. 1 .. 16,true )  -- Note to self
			NewChatWindow.ChannelsEnabled[1][ 17 ]										= Interface.LoadSetting( "ChannelsEnabled" .. 1 .. 17,true )  -- DAMAGE FILTER

		end
		LabelSetFont(templatename.."Text",  "Arial_Black_Shadow_15", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
		
		
		LabelSetText(templatename.."Text", Interface.LoadSetting( "NewChatWindowTabName" .. i ,txt ))
		WindowClearAnchors(templatename)
		NewChatWindow.TabStatus[i] = { extracted = Interface.LoadBoolean( "NewChatWindowTabExtracted" .. i, false ) }
		if (NewChatWindow.TabStatus[i].extracted == true) then
			CreateWindowFromTemplate( "NewChatWindow" .. i, "NewChatWindowBookmarsk" .. i, "Root" )
			SnapUtils.SnappableWindows["NewChatWindow" .. i] = true
	   
		   WindowSetDimensions("NewChatWindow" .. i, 400, 200)
			
			WindowUtils.RestoreWindowPosition("NewChatWindow" .. i, true)
			WindowSetId("NewChatWindow" .. i, i)
			NewChatWindow.OnResizeEnd("NewChatWindow" .. i, true)
		
			--WindowSetParent("Bookmark"..i, "NewChatWindow"  .. i )
			WindowAddAnchor("Bookmark"..i, "topleft", "NewChatWindow" .. i, "topleft", 0 , -30)
		else
			if (first <= 0) then
				first = i
			end

			if (bookmrkxCount == bookmrkxRow) then
				row = row - 1
				bookmrkxCount = 0
			end
			if (NewChatWindow.LastDock <= 0 or bookmrkxCount == 0) then

				WindowClearAnchors(templatename)
				WindowAddAnchor(templatename, "topleft", "NewChatWindow", "topleft", 0 , (row * 35) -30)
				NewChatWindow.LastDock = i
				bookmrkxCount =  bookmrkxCount +1
			else
				if (not NewChatWindow.TabStatus[NewChatWindow.LastDock].extracted) then
					WindowClearAnchors(templatename)
					WindowAddAnchor(templatename, "topright", "Bookmark" .. NewChatWindow.LastDock, "topleft", 10 , 0)
					NewChatWindow.LastDock = i
					bookmrkxCount = bookmrkxCount + 1
				else
					for j = 1, i-1 do
						if (not NewChatWindow.TabStatus[j].extracted and j > NewChatWindow.LastDock) then
							WindowClearAnchors(templatename)
							WindowAddAnchor(templatename, "topright", "Bookmark" .. j, "topleft", 10 , 0)
							NewChatWindow.LastDock = j
							bookmrkxCount = bookmrkxCount + 1
							break
						end
					end
				end
			end
		end
	end

	NewChatWindow.ShowAgain(true)
	local extTabs = 0
	for j = 1, NewChatWindow.maxTabs do
		local templatename = "NewChatWindow" .. j .."ResizeButton"
		if (DoesWindowExist( templatename)) then
			WindowSetShowing(templatename, not Interface.Settings.chat_locked)
			if (NewChatWindow.TabStatus[j].extracted) then
				extTabs = extTabs +1
			end
		end
	end
	if (NewChatWindow.TabCount - extTabs > 1) then
		LabelSetTextColor("Bookmark" .. NewChatWindow.ActiveTab .. "Text", NewChatWindow.ActiveColor.r, NewChatWindow.ActiveColor.g, NewChatWindow.ActiveColor.b)
	else
		NewChatWindow.ActiveTab = first
	end
end

function NewChatWindow.Shutdown()
	if WindowGetShowing(SystemData.ActiveWindow.name) then
		WindowUtils.SaveWindowPosition(SystemData.ActiveWindow.name, true)
	end
    SnapUtils.SnappableWindows[SystemData.ActiveWindow.name] = nil
       
	NewChatWindow.SaveFullLog()
end

function NewChatWindow.SaveFullLog()
	if Interface.Settings.chat_chatLog then
		local output = L"\r\n"
		for i = 1, #NewChatWindow.Messages do
			local text = NewChatWindow.Messages[i].text
			if (NewChatWindow.Messages[i].channel ~= SystemData.ChatLogFilters.SYSTEM and NewChatWindow.Messages[i].sourceName and NewChatWindow.Messages[i].sourceName ~= L"") then
				text = L"[" .. NewChatWindow.Messages[i].sourceName .. L"]: " .. NewChatWindow.Messages[i].text
			end
			text = L"[" .. NewChatWindow.Messages[i].timeStamp .. L"] " .. text
			output = output .. L"\r\n" .. text
		end

		if (Interface.Clock.h < 10) then
			clockhstr = "0"..tostring(Interface.Clock.h)
		else
			clockhstr = tostring(Interface.Clock.h)
		end
		if (Interface.Clock.m < 10) then
			clockmstr = "0"..tostring(Interface.Clock.m)
		else
			clockmstr = tostring(Interface.Clock.m)
		end
		if (Interface.Clock.s < 10) then
			clocksstr = "0"..tostring(Interface.Clock.s)
		else
			clocksstr = tostring(Interface.Clock.s)
		end
		
		TextLogCreate( "NewChatLog", 1 )
		local path = "logs/" .."[" .. GetClockString() .. "] Journal.txt"
		TextLogSetIncrementalSaving( "NewChatLog", true, path )
		TextLogSetEnabled( "NewChatLog", true )
		TextLogAddEntry( "NewChatLog", 1,  output )
		TextLogSetEnabled("NewChatLog", false)
		TextLogDestroy("NewChatLog")
    end
end

function NewChatWindow.BookmarkContext()
	
	if (WindowGetAlpha(SystemData.ActiveWindow.name) < 0.2) then
		return
	end

	-- reset the context menu
	ContextMenu.CleanUp()

	local bookmarkIndex = string.gsub(SystemData.ActiveWindow.name, "Bookmark", "")
	bookmarkIndex = tonumber(bookmarkIndex)
	ContextMenu.CreateLuaContextMenuItem({tid = 1155203, returnCode = "rename", param = bookmarkIndex})
	local enable = 0
	if (NewChatWindow.TabCount >= NewChatWindow.maxTabs) then
		enable = 1
	end
	ContextMenu.CreateLuaContextMenuItem({tid = 1155202, flags = enable, returnCode = "add", param = bookmarkIndex})
	
	enable = 0
	if (NewChatWindow.TabCount <= 1) then
		enable = 1
	end
	ContextMenu.CreateLuaContextMenuItem({tid = 1155207, flags = enable, returnCode = "remove", param = bookmarkIndex})
	
	
	if (NewChatWindow.TabStatus[bookmarkIndex] and NewChatWindow.TabStatus[bookmarkIndex].extracted) then
		ContextMenu.CreateLuaContextMenuItem({tid = 1155205, returnCode = "reintegrate", param = bookmarkIndex})
	else
		if (NewChatWindow.LastDock > 1) then
			ContextMenu.CreateLuaContextMenuItem({tid = 1155204, returnCode = "extract", param = bookmarkIndex})
		else
			ContextMenu.CreateLuaContextMenuItem({tid = 1155204, flags = 1, returnCode = "extract", param = bookmarkIndex})
		end
	end
	
	local subMenu = {}	
	local val = {str = GetStringFromTid(205),param=bookmarkIndex, returnCode = "enableAll",pressed=false}
	table.insert(subMenu, val)
	val = {str = GetStringFromTid(206),param=bookmarkIndex, returnCode = "disableAll",pressed=false}
	table.insert(subMenu, val)
	val = {str = L"", returnCode="null",pressed=false}
	table.insert(subMenu, val)
	for i, data in pairs(ChatSettings.Channels) do
		if i == 13 then -- make sure you can't disable GM chat
			continue
		end
		-- private messages run on 12 not 14
		if i == 14 then
			i = 12
		end
		val = {str = data.name,param=bookmarkIndex, returnCode=i,pressed=NewChatWindow.ChannelsEnabled[bookmarkIndex][i]}
		table.insert(subMenu, val)
	end

	val = {str = GetStringFromTid(1155208), param=bookmarkIndex, returnCode=15, pressed=NewChatWindow.ChannelsEnabled[bookmarkIndex][15]}
	table.insert(subMenu, val)				 								    
	val = {str = GetStringFromTid(1155209), param=bookmarkIndex, returnCode=16, pressed=NewChatWindow.ChannelsEnabled[bookmarkIndex][16]}
	table.insert(subMenu, val)				 								    
	val = {str = GetStringFromTid(1155206), param=bookmarkIndex, returnCode=17, pressed=NewChatWindow.ChannelsEnabled[bookmarkIndex][17]}
	table.insert(subMenu, val)
	ContextMenu.CreateLuaContextMenuItem({tid = 1155210, subMenuOptions = subMenu})
		
	ContextMenu.CreateLuaContextMenuItem({tid = 1155211, returnCode = "save", param = bookmarkIndex})
	
	
	ContextMenu.ActivateLuaContextMenu(NewChatWindow.BookmarkContextMenuCallback)
end

function NewChatWindow.BookmarkContextMenuCallback( returnCode, param )

	if (returnCode == "extract") then
	
		NewChatWindow.TabStatus[param] = { extracted = true  }
		Interface.SaveSetting( "NewChatWindowTabExtracted" .. param, NewChatWindow.TabStatus[param].extracted )
		if (param == NewChatWindow.ActiveTab) then
			NewChatWindow.ActiveTab = 1
		end
		NewChatWindow.LoadTabs()
		NewChatWindow.ClearAll()
		NewChatWindow.UpdateLog()
	elseif (returnCode == "save") then
		local output = L"\r\n"
		for i = 1, #NewChatWindow.Messages do
			local text = NewChatWindow.Messages[i].text
			if (not NewChatWindow.ChannelsEnabled[param][NewChatWindow.Messages[i].channel] or NewChatWindow.Messages[i].ignore) then
				continue
			end
			if (NewChatWindow.Messages[i].channel ~= SystemData.ChatLogFilters.SYSTEM and NewChatWindow.Messages[i].sourceName and NewChatWindow.Messages[i].sourceName ~= L"") then
				text = L"[" .. NewChatWindow.Messages[i].sourceName .. L"]: " .. NewChatWindow.Messages[i].text
			end
			text = L"[" .. NewChatWindow.Messages[i].timeStamp .. L"] " .. text
			output = output .. L"\r\n" .. text
		end

		TextLogCreate( "NewChatLog", 1 )
		local path = "logs/" .."[" .. GetClockString() .. "] " ..  tostring(Interface.LoadSetting( "NewChatWindowTabName" .. param ,L"ChatTab" )) .. ".txt"
		TextLogSetIncrementalSaving( "NewChatLog", true, path )
		TextLogSetEnabled( "NewChatLog", true )
		TextLogAddEntry( "NewChatLog", 1,  output )
		TextLogSetEnabled("NewChatLog", false)
		TextLogDestroy("NewChatLog")
		
	elseif (returnCode == "reintegrate") then
	
		NewChatWindow.TabStatus[param] = { extracted = false  }
		Interface.SaveSetting( "NewChatWindowTabExtracted" .. param, NewChatWindow.TabStatus[param].extracted )
		NewChatWindow.LoadTabs()
		NewChatWindow.ClearAll()
		NewChatWindow.UpdateLog()
	elseif (returnCode == "rename") then
		local rdata = {title=GetStringFromTid(1155203), subtitle=L"Choose the new tab name:", callfunction=NewChatWindow.BookmarkRename, id=param}
		RenameWindow.Create(rdata)
	elseif (returnCode == "remove") then

		for j = param + 1, NewChatWindow.maxTabs do
			if NewChatWindow.ChannelsEnabled[j] ~= nil then
				NewChatWindow.ChannelsEnabled[j-1] = table.copy(NewChatWindow.ChannelsEnabled[j])
				for i=1, 16 do
					if NewChatWindow.ChannelsEnabled[j-1][i] then
						Interface.SaveSetting( "ChannelsEnabled".. j-1 .. i,NewChatWindow.ChannelsEnabled[j-1][i] ) 
					end
				end
			else
				for i=1, 16 do
					Interface.SaveSetting( "ChannelsEnabled".. j-1 .. i, i == SystemData.ChatLogFilters.GM ) 
				end
			end
		end
		NewChatWindow.TabCount = NewChatWindow.TabCount - 1
		Interface.SaveSetting( "NewChatWindowTabCount",NewChatWindow.TabCount )
		for j = param + 1, NewChatWindow.maxTabs do
			Interface.SaveSetting( "NewChatWindowTabName" .. j-1 ,Interface.LoadSetting( "NewChatWindowTabName" .. j ,L"ChatTab" ) )
			NewChatWindow.TabStatus[j-1] = false
			Interface.SaveSetting( "NewChatWindowTabExtracted" .. j-1, false )
		end
		for j = 1, NewChatWindow.maxTabs do
			NewChatWindow.TabStatus[j] = { extracted = false  }
			Interface.SaveSetting( "NewChatWindowTabExtracted" .. j, NewChatWindow.TabStatus[j].extracted )
		end
		if (DoesWindowExist("NewChatWindow" .. param)) then
			DestroyWindow("NewChatWindow" .. param)
		end
		NewChatWindow.LoadTabs()
		NewChatWindow.SwitchTab({id=1})
	elseif (returnCode == "add") then
		NewChatWindow.TabCount = NewChatWindow.TabCount + 1
		Interface.SaveSetting( "NewChatWindowTabCount",NewChatWindow.TabCount )
		Interface.SaveSetting( "NewChatWindowTabName" .. NewChatWindow.TabCount ,L"ChatTab" )
		for i, data in pairs(ChatSettings.Channels) do
			NewChatWindow.ChannelsEnabled[NewChatWindow.TabCount][i] = false or i == SystemData.ChatLogFilters.GM
			Interface.SaveSetting( "ChannelsEnabled".. NewChatWindow.TabCount .. i,NewChatWindow.ChannelsEnabled[NewChatWindow.TabCount][i] ) 
		end
		NewChatWindow.LoadTabs()
		NewChatWindow.ClearAll()
		NewChatWindow.UpdateLog()
	elseif (returnCode == "enableAll") then
		for i=1, 16 do
			NewChatWindow.ChannelsEnabled[param][i] = true
			Interface.SaveSetting( "ChannelsEnabled".. param .. i, true ) 
		end
		NewChatWindow.ClearAll()
		NewChatWindow.UpdateLog()
	elseif (returnCode == "disableAll") then
		for i=1, 16 do
			NewChatWindow.ChannelsEnabled[param][i] = i == SystemData.ChatLogFilters.GM 
			Interface.SaveSetting( "ChannelsEnabled".. param .. i, i == SystemData.ChatLogFilters.GM ) 
		end
		NewChatWindow.ClearAll()
		NewChatWindow.UpdateLog()
	elseif (tonumber(returnCode)) then
		NewChatWindow.ChannelsEnabled[param][returnCode] = not NewChatWindow.ChannelsEnabled[param][returnCode]
		Interface.SaveSetting( "ChannelsEnabled".. param .. returnCode,NewChatWindow.ChannelsEnabled[param][returnCode] ) 
		NewChatWindow.ClearAll()
		NewChatWindow.UpdateLog()
	end
end

function NewChatWindow.BookmarkRename(id, text)
	if (wstring.len(text) <= 0) then
		text = L"ChatTab"
	end
	Interface.SaveSetting( "NewChatWindowTabName" .. id ,text )
	local templatename = "Bookmark" .. id
	LabelSetText(templatename.."Text", Interface.LoadSetting( "NewChatWindowTabName" .. id ,L"ChatTab" ))
end


function NewChatWindow.LabelOnMouseOver()
	
end

function NewChatWindow.OnResizeBegin()
	local windowName = WindowUtils.GetActiveDialog()
	local widthMin = 100
	local heightMin = 150
    WindowUtils.BeginResize( windowName, "topleft", widthMin, heightMin, false, NewChatWindow.OnResizeEnd)
end


function NewChatWindow.OnResizeEnd(curWindow, forced)
	local windowWidth, windowHeight = WindowGetDimensions(curWindow)
	
	if (windowWidth > NewChatWindow.WINDOW_WIDTH_MAX) then
		windowWidth = NewChatWindow.WINDOW_WIDTH_MAX
	end
	
	if (windowHeight > NewChatWindow.WINDOW_HEIGHT_MAX) then
		windowHeight = NewChatWindow.WINDOW_HEIGHT_MAX
	end
	

	WindowSetDimensions(curWindow, windowWidth, windowHeight)
	
	
	--local topWidth, topHeight = WindowGetDimensions(curWindow.."Top")
	--WindowSetDimensions(curWindow.."Top",windowWidth + 30,topHeight)
	--local bottomWidth, bottomHeight = WindowGetDimensions(curWindow.."Bottom")
	--WindowSetDimensions(curWindow.."Bottom",windowWidth + 30,bottomHeight)
	
	local id = WindowGetId(curWindow)
	if (id and id > 0) then
		local Width,Height  = WindowGetDimensions("NewChatWindowBookmark" .. id .. "ScrollChildText")
		WindowSetDimensions("NewChatWindowBookmark" .. id, windowWidth - 10, windowHeight - 100)
		WindowSetDimensions("NewChatWindowBookmark" .. id .. "ScrollChild", windowWidth - 10, windowHeight - 95)
		
		WindowSetDimensions("NewChatWindowBookmark" .. id .. "ScrollChildText", windowWidth - 10, Height)
		
		ScrollWindowSetOffset( "NewChatWindowBookmark" .. id, 0 )
		ScrollWindowUpdateScrollRect( "NewChatWindowBookmark" .. id )
	else
		local Width,Height  = WindowGetDimensions("NewChatWindowJournalWindowScrollChildText")
		WindowSetDimensions("NewChatWindowJournalWindow", windowWidth - 10, windowHeight - 100)
		WindowSetDimensions("NewChatWindowJournalWindowScrollChild", windowWidth - 10, windowHeight - 95)
		if Height then
			WindowSetDimensions("NewChatWindowJournalWindowScrollChildText", windowWidth - 10, Height)
		end
		
		ScrollWindowSetOffset( "NewChatWindowJournalWindow", 0 )
		ScrollWindowUpdateScrollRect( "NewChatWindowJournalWindow" )
	end
	if not forced then
		NewChatWindow.ClearAll()
		NewChatWindow.LoadTabs()
		NewChatWindow.UpdateLog()
	end
end

function NewChatWindow.SwitchTab(data)
	if not data or type(data) ~= "table" then
		if (WindowGetAlpha(SystemData.ActiveWindow.name) < 0.2) then
			return
		end
		local cleanName = string.gsub(SystemData.ActiveWindow.name, "Bookmark", "")
		cleanName = string.gsub(cleanName, "IMG", "")
		cleanName = string.gsub(cleanName, "Text", "")
		
		if (NewChatWindow.TabStatus[tonumber(cleanName)].extracted) then
			return
		end
		NewChatWindow.ActiveTab = tonumber(cleanName)
	else
		NewChatWindow.ActiveTab = data.id
	end
	Interface.SaveSetting( "NewChatWindowActiveTab",NewChatWindow.ActiveTab )
	for i = 1, NewChatWindow.TabCount do
		if (DoesWindowExist("Bookmark" .. i .. "Text")) then
			if (i == NewChatWindow.ActiveTab) then
				local extTabs = 0
				for j = 1, NewChatWindow.maxTabs do
					local templatename = "NewChatWindow" .. j .."ResizeButton"
					if (DoesWindowExist( templatename)) then
						WindowSetShowing(templatename, not Interface.Settings.chat_locked)

						if (NewChatWindow.TabStatus[j].extracted) then
							extTabs = extTabs +1
						end
					end
				end
				if (NewChatWindow.TabCount - extTabs > 1) then
					LabelSetTextColor("Bookmark" .. i .. "Text", NewChatWindow.ActiveColor.r, NewChatWindow.ActiveColor.g, NewChatWindow.ActiveColor.b)
				else
					LabelSetTextColor("Bookmark" .. i .. "Text", NewChatWindow.NormalColor.r, NewChatWindow.NormalColor.g, NewChatWindow.NormalColor.b)
				end
			else
				LabelSetTextColor("Bookmark" .. i .. "Text", NewChatWindow.NormalColor.r, NewChatWindow.NormalColor.g, NewChatWindow.NormalColor.b)
			end
		end
	end
	NewChatWindow.ClearAll()
	NewChatWindow.UpdateLog()
end

function NewChatWindow.ClearAll()
	NewChatWindow.LastMsg[0] = #NewChatWindow.Messages - Interface.Settings.chat_messagesBuffCap
	if (NewChatWindow.LastMsg[0] < 1) then
		NewChatWindow.LastMsg[0] = 1
	end
	NewChatWindow.LastVis[0] = 1
	for i = 1, #NewChatWindow.Messages do
		if (DoesWindowExist("MainLog"..i)) then
			DestroyWindow("MainLog"..i)
		end
	end
	NewChatWindow.totalHeight[0] = 0
	NewChatWindow.Labels[0] = 0
	local Width, Height = WindowGetDimensions("NewChatWindowJournalWindowScrollChildText")
	WindowSetDimensions("NewChatWindowJournalWindowScrollChildText", Width, 0  )
	ScrollWindowUpdateScrollRect( "NewChatWindowJournalWindow" )
	
	for i = 1, NewChatWindow.maxTabs do
		local templatename = "NewChatWindow" .. i
		if (DoesWindowExist(templatename)) then
			NewChatWindow.LastMsg[i] = #NewChatWindow.Messages - Interface.Settings.chat_messagesBuffCap
			if (NewChatWindow.LastMsg[i] < 1) then
				NewChatWindow.LastMsg[i] = 1
			end
			NewChatWindow.LastVis[i] = 1
			for j = 1, #NewChatWindow.Messages do
				if (DoesWindowExist(templatename .. "Log"..j)) then
					DestroyWindow(templatename .. "Log"..j)
				end
			end
			NewChatWindow.totalHeight[i] = 0
			NewChatWindow.Labels[i] = 0
			local Width, Height = WindowGetDimensions("NewChatWindowBookmark" .. i .. "ScrollChildText")
			WindowSetDimensions("NewChatWindowBookmark" .. i .. "ScrollChildText", Width, 0  )
			ScrollWindowUpdateScrollRect( "NewChatWindowBookmark" .. i )
		end
	end
end

function NewChatWindow.OnOpenChannelMenu()

	Tooltips.ClearTooltip()

    if (WindowGetShowing("NewChatChannelSelectionWindow") == true or NewChatWindow.ChannelJustHidden == true) then
        WindowAssignFocus( "NewChatChannelSelectionWindow", false )
        WindowSetShowing("NewChatChannelSelectionWindow", false)

    else
        WindowClearAnchors( "NewChatChannelSelectionWindow" )
        WindowAddAnchor( "NewChatChannelSelectionWindow", "topleft", "NewChatWindowInputTextButton", "bottomleft", 0, 0 )    
        WindowSetShowing("NewChatChannelSelectionWindow", true)
        WindowSetShowing( "NewChatChannelSelectionWindowSelection", false )
        WindowAssignFocus( "NewChatChannelSelectionWindow", true )

		-- update the current chat channel
		NewChatWindow.UpdateCurrentChatChannel()

		-- update friend roster
		NewChatWindow.OnComboRosterUpdate()  

		-- refresh the channels list
		NewChatWindow.RefreshChannelsList()
    end
end

function NewChatWindow.OnOpenContactsMenu()

	Tooltips.ClearTooltip()

    if (WindowGetShowing("NewChatContactsWindow") == true or NewChatWindow.ContactsJustHidden == true) then
        WindowSetShowing("NewChatContactsWindow", false)
        WindowAssignFocus( "NewChatContactsWindow", false )
    else
        WindowClearAnchors( "NewChatContactsWindow" )
        WindowAddAnchor( "NewChatContactsWindow", "topleft", "NewChatWindowContactstButton", "bottomleft", 0, 0 )    
        WindowSetShowing("NewChatContactsWindow", true)
        WindowSetShowing( "NewChatContactsWindow", false )
        WindowAssignFocus( "NewChatContactsWindow", true )

		-- update the roster
		NewChatWindow.OnGChatRosterUpdate()

		-- update player status
		NewChatWindow.OnGChatPresenceUpdate()
    end
end

function NewChatWindow.InitializeContactsWindow()
	CreateWindow( "NewChatContactsWindow", false )
	LabelSetText("NewChatContactsWindowCurrStatusLabel", GetStringFromTid(NewChatWindow.ChannelTID.Status))
	LabelSetText("NewChatContactsWindowAddFriend", GetStringFromTid(NewChatWindow.ChannelTID.Add_Friend))
end

function NewChatWindow.InitializeChannelMenuSelectionWindow()
    CreateWindow( "NewChatChannelSelectionWindow", false )
    
    NewChatOptionsWindow.SetupChannelColorDefaults( true )
    
    -- Say channel
    local channelColor = NewChatWindow.ChannelColors[ SystemData.ChatLogFilters.SAY ]
    WindowSetId( "NewChatChannelSelectionWindowSayButton", SystemData.ChatLogFilters.SAY)
    ButtonSetText( "NewChatChannelSelectionWindowSayButton", L"/Say" ) 
    ButtonSetTextColor("NewChatChannelSelectionWindowSayButton", Button.ButtonState.NORMAL, channelColor.r, channelColor.g, channelColor.b)
    ButtonSetTextColor("NewChatChannelSelectionWindowSayButton", Button.ButtonState.HIGHLIGHTED, channelColor.r, channelColor.g, channelColor.b)
    ButtonSetTextColor("NewChatChannelSelectionWindowSayButton", Button.ButtonState.PRESSED, channelColor.r, channelColor.g, channelColor.b)
    ButtonSetTextColor("NewChatChannelSelectionWindowSayButton", Button.ButtonState.PRESSED_HIGHLIGHTED, channelColor.r, channelColor.g, channelColor.b)
    
    -- Yell channel
    channelColor = NewChatWindow.ChannelColors[ SystemData.ChatLogFilters.YELL ]
    WindowSetId( "NewChatChannelSelectionWindowYellButton", SystemData.ChatLogFilters.YELL)
    ButtonSetText("NewChatChannelSelectionWindowYellButton", L"/Yell" )
    ButtonSetTextColor("NewChatChannelSelectionWindowYellButton", Button.ButtonState.NORMAL, channelColor.r, channelColor.g, channelColor.b)
    ButtonSetTextColor("NewChatChannelSelectionWindowYellButton", Button.ButtonState.HIGHLIGHTED, channelColor.r, channelColor.g, channelColor.b)
    ButtonSetTextColor("NewChatChannelSelectionWindowYellButton", Button.ButtonState.PRESSED, channelColor.r, channelColor.g, channelColor.b)
    ButtonSetTextColor("NewChatChannelSelectionWindowYellButton", Button.ButtonState.PRESSED_HIGHLIGHTED, channelColor.r, channelColor.g, channelColor.b)
    
    -- Guild channel
    channelColor = NewChatWindow.ChannelColors[ SystemData.ChatLogFilters.GUILD ]
    WindowSetId( "NewChatChannelSelectionWindowGuildButton", SystemData.ChatLogFilters.GUILD )
    ButtonSetText("NewChatChannelSelectionWindowGuildButton", L"/Guild" )
    ButtonSetTextColor("NewChatChannelSelectionWindowGuildButton", Button.ButtonState.NORMAL, channelColor.r, channelColor.g, channelColor.b)
    ButtonSetTextColor("NewChatChannelSelectionWindowGuildButton", Button.ButtonState.HIGHLIGHTED, channelColor.r, channelColor.g, channelColor.b)
    ButtonSetTextColor("NewChatChannelSelectionWindowGuildButton", Button.ButtonState.PRESSED, channelColor.r, channelColor.g, channelColor.b)
    ButtonSetTextColor("NewChatChannelSelectionWindowGuildButton", Button.ButtonState.PRESSED_HIGHLIGHTED, channelColor.r, channelColor.g, channelColor.b)
    
    -- Party channel
    channelColor = NewChatWindow.ChannelColors[ SystemData.ChatLogFilters.PARTY ]
    WindowSetId( "NewChatChannelSelectionWindowPartyButton", ChatSettings.Channels[SystemData.ChatLogFilters.PARTY].id )
    ButtonSetText("NewChatChannelSelectionWindowPartyButton", L"/Party" )
    ButtonSetTextColor("NewChatChannelSelectionWindowPartyButton", Button.ButtonState.NORMAL, channelColor.r, channelColor.g, channelColor.b)
    ButtonSetTextColor("NewChatChannelSelectionWindowPartyButton", Button.ButtonState.HIGHLIGHTED, channelColor.r, channelColor.g, channelColor.b)
    ButtonSetTextColor("NewChatChannelSelectionWindowPartyButton", Button.ButtonState.PRESSED, channelColor.r, channelColor.g, channelColor.b)
    ButtonSetTextColor("NewChatChannelSelectionWindowPartyButton", Button.ButtonState.PRESSED_HIGHLIGHTED, channelColor.r, channelColor.g, channelColor.b)
    
    -- Alliance channel
    channelColor = NewChatWindow.ChannelColors[ SystemData.ChatLogFilters.ALLIANCE ]
    WindowSetId( "NewChatChannelSelectionWindowAllianceButton", ChatSettings.Channels[SystemData.ChatLogFilters.ALLIANCE].id )
    ButtonSetText("NewChatChannelSelectionWindowAllianceButton", L"/Alliance" )
    ButtonSetTextColor("NewChatChannelSelectionWindowAllianceButton", Button.ButtonState.NORMAL, channelColor.r, channelColor.g, channelColor.b)
    ButtonSetTextColor("NewChatChannelSelectionWindowAllianceButton", Button.ButtonState.HIGHLIGHTED, channelColor.r, channelColor.g, channelColor.b)
    ButtonSetTextColor("NewChatChannelSelectionWindowAllianceButton", Button.ButtonState.PRESSED, channelColor.r, channelColor.g, channelColor.b)
    ButtonSetTextColor("NewChatChannelSelectionWindowAllianceButton", Button.ButtonState.PRESSED_HIGHLIGHTED, channelColor.r, channelColor.g, channelColor.b)
    
    -- Chat channel
    channelColor = NewChatWindow.ChannelColors[ SystemData.ChatLogFilters.CUSTOM ]
    WindowSetId( "NewChatChannelSelectionWindowChatButton", SystemData.ChatLogFilters.CUSTOM)
    ButtonSetText("NewChatChannelSelectionWindowChatButton", L"/Chat (Global)" )
    ButtonSetTextColor("NewChatChannelSelectionWindowChatButton", Button.ButtonState.NORMAL, channelColor.r, channelColor.g, channelColor.b)
    ButtonSetTextColor("NewChatChannelSelectionWindowChatButton", Button.ButtonState.HIGHLIGHTED, channelColor.r, channelColor.g, channelColor.b)
    ButtonSetTextColor("NewChatChannelSelectionWindowChatButton", Button.ButtonState.PRESSED, channelColor.r, channelColor.g, channelColor.b)
    ButtonSetTextColor("NewChatChannelSelectionWindowChatButton", Button.ButtonState.PRESSED_HIGHLIGHTED, channelColor.r, channelColor.g, channelColor.b)
    
    -- GM channel
    channelColor = NewChatWindow.ChannelColors[ SystemData.ChatLogFilters.GM ]
    WindowSetId( "NewChatChannelSelectionWindowGMButton", SystemData.ChatLogFilters.GM)
    ButtonSetText("NewChatChannelSelectionWindowGMButton", L"/GM" )
    ButtonSetTextColor("NewChatChannelSelectionWindowGMButton", Button.ButtonState.NORMAL, channelColor.r, channelColor.g, channelColor.b)
    ButtonSetTextColor("NewChatChannelSelectionWindowGMButton", Button.ButtonState.HIGHLIGHTED, channelColor.r, channelColor.g, channelColor.b)
    ButtonSetTextColor("NewChatChannelSelectionWindowGMButton", Button.ButtonState.PRESSED, channelColor.r, channelColor.g, channelColor.b)
    ButtonSetTextColor("NewChatChannelSelectionWindowGMButton", Button.ButtonState.PRESSED_HIGHLIGHTED, channelColor.r, channelColor.g, channelColor.b)
    
    -- Self channel
    WindowSetId( "NewChatChannelSelectionWindowSelfButton", 16)
    ButtonSetText("NewChatChannelSelectionWindowSelfButton", L"/Self" )
	ButtonSetTextColor("NewChatChannelSelectionWindowSelfButton", Button.ButtonState.NORMAL, 192, 192, 248)
    ButtonSetTextColor("NewChatChannelSelectionWindowSelfButton", Button.ButtonState.HIGHLIGHTED, 192, 192, 248)
    ButtonSetTextColor("NewChatChannelSelectionWindowSelfButton", Button.ButtonState.PRESSED, 192, 192, 248)
    ButtonSetTextColor("NewChatChannelSelectionWindowSelfButton", Button.ButtonState.PRESSED_HIGHLIGHTED, 192, 192, 248)

	LabelSetText("NewChatChannelSelectionWindowCurrChannelLabel", GetStringFromTid(NewChatWindow.ChannelTID.YourCurrentChannel))
	LabelSetText("NewChatChannelSelectionWindowCreateChannel", FormatProperly(GetStringFromTid(NewChatWindow.ChannelTID.CreateChannelTitle)))

	NewChatWindow.firstGChatSelect = true
    NewChatWindow.OnGChatRosterUpdate()  
	NewChatWindow.UpdateCurrentChatChannel()
	NewChatWindow.RefreshChannelsList()
end

function NewChatWindow.LeaveChannel()
	ChatLeaveChannel()
	NewChatWindow.UpdateCurrentChatChannel()
end

function NewChatWindow.UpdateLog()
	pcall(NewChatWindow.UpdateLogR)
end

function NewChatWindow.UpdateLogR()
	
	if (NewChatWindow.blockUpdate == true) then
		NewChatWindow.UpdateReq = true
		return
	end
	NewChatWindow.blockUpdate = true
	NewChatWindow.ClearAll()
	local autoScroll = true
	
	if (NewChatWindow.LastVis[0] and DoesWindowExist("MainLog"..NewChatWindow.LastVis[0])) then
		local dontCare, maxOffset = WindowGetDimensions("NewChatWindowJournalWindow")
		local elementX,elementY = WindowGetScreenPosition("MainLog"..NewChatWindow.LastVis[0])
		local parentX,parentY = WindowGetScreenPosition("NewChatWindowJournalWindow")
		local scrollOffset = elementY - parentY

		if (scrollOffset > maxOffset) then
			autoScroll = false
		end
	end
	
	local clAll = false
	if (NewChatWindow.Labels[0] and NewChatWindow.Labels[0] > Interface.Settings.chat_messagesBuffCap * 2) then
		NewChatWindow.ClearAll()
		clAll = true
	end
	if not clAll then
		for j = 1, NewChatWindow.maxTabs do
			if (NewChatWindow.Labels[j] and NewChatWindow.Labels[j] > Interface.Settings.chat_messagesBuffCap) then
				NewChatWindow.ClearAll()
				break
			end
		end
	end
	
	local Width, Height = WindowGetDimensions("NewChatWindowJournalWindowScrollChildText")

	WindowClearAnchors("NewChatWindowJournalWindow")
	WindowAddAnchor("NewChatWindowJournalWindow", "topleft","NewChatWindow", "topleft", 5, 10 )
	WindowAddAnchor("NewChatWindowJournalWindow", "bottomright","NewChatWindow", "bottomright", -2, -10 )
	WindowSetLayer("NewChatWindowJournalWindow", Window.Layers.DEFAULT	)	
	WindowSetParent("NewChatWindowJournalWindow", "NewChatWindow")
	
	if (NewChatWindow.Messages and NewChatWindow.LastMsg and NewChatWindow.LastMsg[0]) then
		for i = NewChatWindow.LastMsg[0], #NewChatWindow.Messages do
			if (not NewChatWindow.ChannelsEnabled[NewChatWindow.ActiveTab] or not NewChatWindow.ChannelsEnabled[NewChatWindow.ActiveTab][NewChatWindow.Messages[i].channel] or NewChatWindow.Messages[i].ignore) then
				continue
			end
			
			if (NewChatWindow.Messages[i].channel == 15) then
				if NewChatWindow.Messages[i].Notoriety then
					local passa = Interface.Settings.chat_SavedFilter[NewChatWindow.Messages[i].Notoriety+1]
					if (not Interface.Settings.chat_SavedFilter[9] and IsFarmAnimal(NewChatWindow.Messages[i].sourceId)) then
							passa = false
					end
					if (not Interface.Settings.chat_SavedFilter[10] and IsSummon(NewChatWindow.Messages[i].sourceId)) then
							passa = false
					end
					if not passa then
						continue
					end
				end
			end
			if (NewChatWindow.Messages[i].channel == 16) then
				NewChatWindow.Messages[i].color = {r=192, g=192, b=248}
				NewChatWindow.Messages[i].sourceName = wstring.sub(GetStringFromTid(3000610), 1, -2) -- Note to Self:
			end
			
		
			CreateWindowFromTemplate( "MainLog"..i, "JournalItem", "NewChatWindowJournalWindowScrollChildText" )

			
			WindowSetParent("MainLog"..i, "NewChatWindowJournalWindowScrollChildText")
			
		
			WindowSetDimensions("MainLog"..i, Width - 15 , 20)
			if (NewChatWindow.Messages[i].channel == 15) then
				WindowSetId("MainLog"..i, NewChatWindow.Messages[i].sourceId)
				WindowSetHandleInput("MainLog"..i, true)
			end
			
			local hueR, hueG, hueB = 255, 255, 255
			if (type(NewChatWindow.Messages[i].color) == "number") then
				hueR, hueG, hueB = HueRGBAValue(NewChatWindow.Messages[i].color)
			elseif NewChatWindow.Messages[i].color then
				hueR = NewChatWindow.Messages[i].color.r
				hueG = NewChatWindow.Messages[i].color.g
				hueB = NewChatWindow.Messages[i].color.b
			end
			local text = NewChatWindow.Messages[i].text
			local prefix = L""
			local channel = NewChatWindow.Messages[i].channel
			if (NewChatWindow.Messages[i].ORGchannel) then
				channel = NewChatWindow.Messages[i].ORGchannel
			end
			
			if (channel == SystemData.ChatLogFilters.GUILD or channel == SystemData.ChatLogFilters.ALLIANCE or channel == SystemData.ChatLogFilters.PARTY ) and not Interface.Settings.chat_hideTag then
						
				prefix = L"[" .. ChatSettings.Channels[channel].name .. L"]"
			end
			
			if (NewChatWindow.Messages[i].channel == SystemData.ChatLogFilters.SAY or NewChatWindow.Messages[i].channel == 16) then
				if (NewChatWindow.Messages[i].sourceName and NewChatWindow.Messages[i].sourceName ~= L"") then
					if (NewChatWindow.Messages[i].channel == 16) then
						text = prefix.. NewChatWindow.Messages[i].sourceName .. L": " ..  towstring(NewChatWindow.Messages[i].text)
					else
						
						text = prefix.. L"[" .. NewChatWindow.Messages[i].sourceName .. L"]: " .. towstring(NewChatWindow.Messages[i].text)
					end
				end
				
				if (not NewChatWindow.Messages[i].color or NewChatWindow.Messages[i].color == 0) then
					hueR= NewChatWindow.ChannelColors[NewChatWindow.Messages[i].channel].r
					hueG= NewChatWindow.ChannelColors[NewChatWindow.Messages[i].channel].g
					hueB= NewChatWindow.ChannelColors[NewChatWindow.Messages[i].channel].b
				end
				
			else
			
				if NewChatWindow.Messages[i].channel == SystemData.ChatLogFilters.SYSTEM and towstring(NewChatWindow.Messages[i].sourceName) ~= L"" then
					text = L"[" .. towstring(NewChatWindow.Messages[i].sourceName) .. L"]: " ..  towstring(NewChatWindow.Messages[i].text)
					if (not NewChatWindow.Messages[i].color or NewChatWindow.Messages[i].color == 0) then
						hueR= NewChatWindow.ChannelColors[SystemData.ChatLogFilters.SYSTEM].r
						hueG= NewChatWindow.ChannelColors[SystemData.ChatLogFilters.SYSTEM].g
						hueB= NewChatWindow.ChannelColors[SystemData.ChatLogFilters.SYSTEM].b
					end
				else
					if (NewChatWindow.Messages[i].channel ~= SystemData.ChatLogFilters.SYSTEM and NewChatWindow.Messages[i].channel ~= 15) then
						if NewChatWindow.Messages[i].sourceName and towstring(NewChatWindow.Messages[i].sourceName) ~= L"" then
							text = towstring(prefix).. L"[" .. towstring(NewChatWindow.Messages[i].sourceName) .. L"]: " .. towstring(NewChatWindow.Messages[i].text)
						else
							text = towstring(prefix) .. towstring(NewChatWindow.Messages[i].text)
						end
					end
					if (type(NewChatWindow.Messages[i].color) == "number") then
						hueR= NewChatWindow.ChannelColors[NewChatWindow.Messages[i].channel].r
						hueG= NewChatWindow.ChannelColors[NewChatWindow.Messages[i].channel].g
						hueB= NewChatWindow.ChannelColors[NewChatWindow.Messages[i].channel].b
					end
				end
			end
			
			if (Interface.Settings.chat_timeStamp) then
				text = L"[" .. NewChatWindow.Messages[i].timeStamp .. L"] " .. text
			end
			LabelSetText("MainLog"..i, text)
			LabelSetTextColor("MainLog"..i, hueR, hueG, hueB)
			local font = FontSelector.Fonts[NewChatWindow.ChannelsFonts[ NewChatWindow.Messages[i].channel ]].fontName .. "_" .. NewChatWindow.ChannelsFontsSize[ NewChatWindow.Messages[i].channel ]
			LabelSetFont("MainLog"..i,font , WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)

			if (i == 1 or NewChatWindow.Labels[0] < 1) then
				WindowAddAnchor("MainLog"..i, "topleft", "NewChatWindowJournalWindowScrollChildText", "topleft", 0, 0)
			else
				WindowAddAnchor("MainLog"..i, "bottomleft", "MainLog"..NewChatWindow.LastVis[0], "topleft", 0, 8)
			end

			NewChatWindow.Labels[0] = NewChatWindow.Labels[0] + 1
			NewChatWindow.LastMsg[0] = i + 1
			NewChatWindow.LastVis[0] = i
			local lblWidth, lblHeight = WindowGetDimensions("MainLog"..i)

		
			NewChatWindow.totalHeight[0] = NewChatWindow.totalHeight[0] + lblHeight + 8
			
			
		end
	end
	
	if NewChatWindow.totalHeight[0] then
		WindowSetDimensions("NewChatWindowJournalWindowScrollChildText", Width, NewChatWindow.totalHeight[0]  )
	end
	ScrollWindowUpdateScrollRect( "NewChatWindowJournalWindow" )
	if (autoScroll and NewChatWindow.LastVis[0]) then
		WindowUtils.ScrollToElementInScrollWindow( "MainLog"..NewChatWindow.LastVis[0], "NewChatWindowJournalWindow", "NewChatWindowJournalWindowScrollChild" )
	end
	
	
	for j = 1, NewChatWindow.maxTabs do
		local templatename = "NewChatWindow" .. j
		if (DoesWindowExist(templatename)) then
			
			local autoScroll = true
	
			if (DoesWindowExist(templatename .. "Log" .. NewChatWindow.LastVis[j])) then
				local dontCare, maxOffset = WindowGetDimensions("NewChatWindowBookmark" .. j)
				local elementX,elementY = WindowGetScreenPosition(templatename .. "Log" .. NewChatWindow.LastVis[j])
				local parentX,parentY = WindowGetScreenPosition("NewChatWindowBookmark" .. j)
				local scrollOffset = elementY - parentY

				if (scrollOffset > maxOffset) then
					autoScroll = false
				end
			end
						
			local Width, Height = WindowGetDimensions("NewChatWindowBookmark" .. j .. "ScrollChildText")

			WindowClearAnchors("NewChatWindowBookmark" .. j)	
			WindowAddAnchor("NewChatWindowBookmark" .. j, "topleft",templatename, "topleft", 5, 10 )
			WindowAddAnchor("NewChatWindowBookmark" .. j, "bottomright",templatename, "bottomright", -2, -10 )
			WindowSetLayer("NewChatWindowBookmark" .. j, Window.Layers.DEFAULT	)
			WindowSetParent("NewChatWindowBookmark" .. j, templatename)
			
			if (NewChatWindow.LastMsg[j]) then
				for i = NewChatWindow.LastMsg[j], #NewChatWindow.Messages do
				
					if (not NewChatWindow.ChannelsEnabled[j] or not NewChatWindow.ChannelsEnabled[j][NewChatWindow.Messages[i].channel] or NewChatWindow.Messages[i].ignore) then
						continue
					end
					
					if (NewChatWindow.Messages[i].channel == 15) then
						if NewChatWindow.Messages[i].Notoriety then
							local passa = Interface.Settings.chat_SavedFilter[NewChatWindow.Messages[i].Notoriety+1]
							if (not Interface.Settings.chat_SavedFilter[9] and IsFarmAnimal(NewChatWindow.Messages[i].sourceId)) then
									passa = false
							end
							if (not Interface.Settings.chat_SavedFilter[10] and IsSummon(NewChatWindow.Messages[i].sourceId)) then
									passa = false
							end
							if not passa then
								continue
							end
						end
					end
					if (NewChatWindow.Messages[i].channel == 16) then
						NewChatWindow.Messages[i].color = {r=192, g=192, b=248}
						NewChatWindow.Messages[i].sourceName = GetStringFromTid(3000610) -- Note to Self:
					end
					
					CreateWindowFromTemplate( templatename .. "Log"..i, "JournalItem", "NewChatWindowBookmark" .. j .. "ScrollChildText" )
					
					WindowSetParent(templatename .. "Log"..i, "NewChatWindowBookmark" .. j .. "ScrollChildText")
					
				
					WindowSetDimensions(templatename .. "Log"..i, Width - 15 , 20)
					if (NewChatWindow.Messages[i].channel == 15) then
						WindowSetId("Log"..i, NewChatWindow.Messages[i].sourceId)
						WindowSetHandleInput("Log"..i, true)
					end
					local hueR, hueG, hueB = 255, 255, 255
					if (type(NewChatWindow.Messages[i].color) == "number") then
						hueR, hueG, hueB = HueRGBAValue(NewChatWindow.Messages[i].color)
					elseif NewChatWindow.Messages[i].color then
						hueR = NewChatWindow.Messages[i].color.r
						hueG = NewChatWindow.Messages[i].color.g
						hueB = NewChatWindow.Messages[i].color.b
					end
					local text = NewChatWindow.Messages[i].text
					local prefix = L""
					local channel = NewChatWindow.Messages[i].channel
					if (NewChatWindow.Messages[i].ORGchannel) then
						channel = NewChatWindow.Messages[i].ORGchannel
					end
					if (channel == SystemData.ChatLogFilters.GUILD or channel == SystemData.ChatLogFilters.ALLIANCE or channel == SystemData.ChatLogFilters.PARTY ) and not Interface.Settings.chat_hideTag then
						
						prefix = L"[" .. ChatSettings.Channels[channel].name .. L"]"
					end
					if (NewChatWindow.Messages[i].channel == SystemData.ChatLogFilters.SAY or NewChatWindow.Messages[i].channel == 16) then
						if (NewChatWindow.Messages[i].sourceName and NewChatWindow.Messages[i].sourceName ~= L"") then
							if (NewChatWindow.Messages[i].channel == 16) then
								text = prefix.. NewChatWindow.Messages[i].sourceName .. L": " .. towstring(NewChatWindow.Messages[i].text)
							else
								text = prefix.. L"[" .. NewChatWindow.Messages[i].sourceName .. L"]: " .. towstring(NewChatWindow.Messages[i].text)
							end
						end
						if (not NewChatWindow.Messages[i].color or NewChatWindow.Messages[i].color == 0) then
							hueR= NewChatWindow.ChannelColors[NewChatWindow.Messages[i].channel].r
							hueG= NewChatWindow.ChannelColors[NewChatWindow.Messages[i].channel].g
							hueB= NewChatWindow.ChannelColors[NewChatWindow.Messages[i].channel].b
						end
						
						
					else
						if NewChatWindow.Messages[i].channel == SystemData.ChatLogFilters.SYSTEM and towstring(NewChatWindow.Messages[i].sourceName) ~= L"" then
							text = L"[" .. towstring(NewChatWindow.Messages[i].sourceName) .. L"]: " ..  towstring(NewChatWindow.Messages[i].text)
							if (not NewChatWindow.Messages[i].color or NewChatWindow.Messages[i].color == 0) then
								hueR= NewChatWindow.ChannelColors[SystemData.ChatLogFilters.SYSTEM].r
								hueG= NewChatWindow.ChannelColors[SystemData.ChatLogFilters.SYSTEM].g
								hueB= NewChatWindow.ChannelColors[SystemData.ChatLogFilters.SYSTEM].b
							end
						else
							if (NewChatWindow.Messages[i].channel ~= SystemData.ChatLogFilters.SYSTEM and NewChatWindow.Messages[i].channel ~= 15) then
								if NewChatWindow.Messages[i].sourceName and towstring(NewChatWindow.Messages[i].sourceName) ~= L"" then
									text = towstring(prefix).. L"[" .. towstring(NewChatWindow.Messages[i].sourceName) .. L"]: " .. towstring(NewChatWindow.Messages[i].text)
								else
									text = towstring(prefix) .. towstring(NewChatWindow.Messages[i].text)
								end
							end
							if (type(NewChatWindow.Messages[i].color) == "number") then
								hueR= NewChatWindow.ChannelColors[NewChatWindow.Messages[i].channel].r
								hueG= NewChatWindow.ChannelColors[NewChatWindow.Messages[i].channel].g
								hueB= NewChatWindow.ChannelColors[NewChatWindow.Messages[i].channel].b
							end
						end
					end
					if (Interface.Settings.chat_timeStamp) then
						text = L"[" .. NewChatWindow.Messages[i].timeStamp .. L"] " .. text
					end
					LabelSetText(templatename .. "Log"..i, text)
					LabelSetTextColor(templatename .. "Log"..i, hueR, hueG, hueB)
					local font = FontSelector.Fonts[NewChatWindow.ChannelsFonts[ NewChatWindow.Messages[i].channel ]].fontName .. "_" .. NewChatWindow.ChannelsFontsSize[ NewChatWindow.Messages[i].channel ]
					LabelSetFont(templatename .. "Log"..i,font , WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)

					if (i == 1 or NewChatWindow.Labels[j] < 1) then
						WindowAddAnchor(templatename .. "Log"..i, "topleft", "NewChatWindowBookmark" .. j .. "ScrollChildText", "topleft", 0, 0)
					else
						WindowAddAnchor(templatename .. "Log"..i, "bottomleft", templatename .. "Log"..NewChatWindow.LastVis[j], "topleft", 0, 8)
					end

					NewChatWindow.Labels[j] = NewChatWindow.Labels[j] + 1
					NewChatWindow.LastMsg[j] = i + 1
					NewChatWindow.LastVis[j] = i
					local lblWidth, lblHeight = WindowGetDimensions(templatename .. "Log"..i)

				
					NewChatWindow.totalHeight[j] = NewChatWindow.totalHeight[j] + lblHeight + 8
					
				end
			end
			WindowSetDimensions("NewChatWindowBookmark" .. j .. "ScrollChildText", Width, NewChatWindow.totalHeight[j]  )
			ScrollWindowUpdateScrollRect( "NewChatWindowBookmark" .. j )
			if (autoScroll and NewChatWindow.LastVis[j]) then
				WindowUtils.ScrollToElementInScrollWindow( templatename .. "Log" .. NewChatWindow.LastVis[j], "NewChatWindowBookmark" .. j, "NewChatWindowBookmark" .. j .. "ScrollChild" )
			end
			WindowAssignFocus("NewChatWindowBookmark" .. j, false)
		end
	
	end
	local totalVis = 0
	if (NewChatWindow.Labels[i]) then
		for i = 0, NewChatWindow.maxTabs do
			totalVis = totalVis + (NewChatWindow.Labels[i] - NewChatWindow.PrevLabels[i])
		end
	end
	if (totalVis > 0) then
		
		if ((NewChatWindow.Labels[0] - NewChatWindow.PrevLabels[0]) > 0) then
			NewChatWindow.PrevLabels[0] = NewChatWindow.Labels[0]
			WindowStopAlphaAnimation("NewChatWindow")
			WindowStopAlphaAnimation("NewChatWindowJournalWindowScrollbar")
			WindowStopAlphaAnimation("NewChatWindowJournalWindow")
			if (DoesWindowExist("Bookmark1")) then
				WindowStopAlphaAnimation("Bookmark1")
				WindowSetAlpha("Bookmark1", Interface.Settings.chat_BaseAlpha)
			end
			WindowSetAlpha("NewChatWindowJournalWindow", 1)
			WindowSetAlpha("NewChatWindow", Interface.Settings.chat_BaseAlpha)
			WindowSetAlpha("NewChatWindowJournalWindowScrollbar",2)
			WindowSetLayer("NewChatWindowJournalWindow", Window.Layers.DEFAULT	)	
			WindowSetParent("NewChatWindowJournalWindow", "NewChatWindow")
			
			for i = 1, #NewChatWindow.Messages do
				if (DoesWindowExist("MainLog"..i)) then
					WindowSetAlpha("MainLog"..i, 2)
					WindowSetFontAlpha("MainLog"..i, 2)
				end
			end
			
		end
		
		for j = 1, NewChatWindow.maxTabs do
			local templatename = "NewChatWindow" .. j
			
			
			if (DoesWindowExist(templatename) and (NewChatWindow.Labels[j] - NewChatWindow.PrevLabels[j]) > 0) then
				if (DoesWindowExist("Bookmark" .. j+1)) then
					WindowStopAlphaAnimation("Bookmark" .. j+1)
					WindowSetAlpha("Bookmark" .. j+1, Interface.Settings.chat_BaseAlpha)
				end
				
				NewChatWindow.PrevLabels[j] = NewChatWindow.Labels[j]
				WindowStopAlphaAnimation(templatename)
				WindowStopAlphaAnimation("NewChatWindowBookmark" .. j .. "Scrollbar")
				WindowStopAlphaAnimation("NewChatWindowBookmark" .. j)
				
				WindowSetLayer("NewChatWindowBookmark" .. j, Window.Layers.DEFAULT	)
				WindowSetParent("NewChatWindowBookmark" .. j, templatename)
				
				WindowSetAlpha("NewChatWindowBookmark" .. j, 1)
				WindowSetAlpha(templatename, Interface.Settings.chat_BaseAlpha)
				WindowSetAlpha("NewChatWindowBookmark" .. j .. "Scrollbar", 2)
				for i = 1, #NewChatWindow.Messages do
					if (DoesWindowExist( templatename .. "Log" ..i)) then
						WindowSetAlpha( templatename .. "Log" ..i, 2)
						WindowSetFontAlpha( templatename .. "Log" ..i, 2)
					end
				end
			end
		end
		NewChatWindow.OnMouseOverEnd()
		
		NewChatWindow.delta = 0
		
		NewChatWindow.hidden = false
	end

end

function NewChatWindow.ShowAgain(bypass)

	if (Interface.Settings.chat_showMouseOver or bypass == true) then
		WindowStopAlphaAnimation("NewChatWindow")
		WindowStopAlphaAnimation("NewChatWindowJournalWindowScrollbar")
		WindowStopAlphaAnimation("NewChatWindowJournalWindow")
		
		WindowSetAlpha("NewChatWindowJournalWindow", 1)
		WindowSetAlpha("NewChatWindow", Interface.Settings.chat_BaseAlpha)
		WindowSetAlpha("NewChatWindowJournalWindowScrollbar", 2)
		WindowSetParent("NewChatWindowJournalWindow", "NewChatWindow")
		WindowSetLayer("NewChatWindowJournalWindow", Window.Layers.DEFAULT	)
		for i = 1, #NewChatWindow.Messages do
			if (DoesWindowExist("MainLog"..i)) then
				WindowSetAlpha("MainLog"..i, 2)
				WindowSetFontAlpha("MainLog"..i, 2)
			end
		end
		for j = 1, NewChatWindow.maxTabs do
			local templatename = "NewChatWindow" .. j
			if (DoesWindowExist("Bookmark" .. j)) then
				WindowStopAlphaAnimation("Bookmark" .. j)
				WindowSetAlpha("Bookmark" .. j, Interface.Settings.chat_BaseAlpha)
			end
			if (DoesWindowExist( templatename)) then
				WindowStopAlphaAnimation(templatename)
				WindowStopAlphaAnimation("NewChatWindowBookmark" .. j .. "Scrollbar")
				WindowStopAlphaAnimation("NewChatWindowJournalWindow")
				
				WindowSetAlpha("NewChatWindowBookmark" .. j, 1)
				WindowSetAlpha(templatename, Interface.Settings.chat_BaseAlpha)
				WindowSetAlpha("NewChatWindowBookmark" .. j .. "Scrollbar", 2)
				
				WindowSetParent("NewChatWindowBookmark" .. j, templatename)
				WindowSetLayer("NewChatWindowBookmark" .. j, Window.Layers.DEFAULT	)
				for i = 1, #NewChatWindow.Messages do
					if (DoesWindowExist( templatename .. "Log" ..i)) then
						WindowSetAlpha( templatename .. "Log" ..i, 2)
						WindowSetFontAlpha( templatename .. "Log" ..i, 2)
					end
				end
			end
		end
		
		NewChatWindow.delta = 0
		
		NewChatWindow.hidden = false
		NewChatWindow.OnMouseOverEnd()
	end
end


function NewChatWindow.Rubber()
	NewChatWindow.ClearAll()
	for i = 0, NewChatWindow.maxTabs do
		NewChatWindow.LastMsg[i] = 1
		NewChatWindow.LastVis[i] = 1
		NewChatWindow.totalHeight[i] = 0
		NewChatWindow.Labels[i] = 0
		NewChatWindow.PrevLabels[i] = 0
	end
	NewChatWindow.Messages = {}
end 


function NewChatWindow.RubberToolTip()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,GetStringFromTid(1155212) )
end


function NewChatWindow.Font()

	-- reset the context menu
	ContextMenu.CleanUp()

	for i, _ in pairs(ChatSettings.Channels) do
		ContextMenu.CreateLuaContextMenuItem({str = ChatSettings.Channels[i].name, returnCode = i})
	end
	ContextMenu.CreateLuaContextMenuItem({tid = 1155208, returnCode = 15})
	ContextMenu.CreateLuaContextMenuItem({tid = 1155209, returnCode = 16})
	ContextMenu.CreateLuaContextMenuItem({tid = 1155206, returnCode = 17})

	
	ContextMenu.ActivateLuaContextMenu(NewChatWindow.FontContextMenuCallback)
		
end 

function NewChatWindow.FontContextMenuCallback( returnCode, param )

		FontSelector.Selection = "journal" .. returnCode
		if (not DoesWindowExist("FontSelector")) then
			CreateWindow("FontSelector", true)
		else
			WindowSetShowing("FontSelector", true)
		end
		FontSelector.OnShown()
		
		WindowSetShowing(FontSelector.RunicFontItem, false)
		WindowUtils.SetWindowTitle("FontSelector", L"Overhead Chat Font")
 

end 

function NewChatWindow.FontToolTip()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,L"Set Fonts" )
end

function NewChatWindow.FontSize()

	-- reset the context menu
	ContextMenu.CleanUp()

	ContextMenu.CreateLuaContextMenuItem({str = L"All Fonts Size", returnCode = "all_fonts"})
	for i, data in pairs(ChatSettings.Channels) do
		ContextMenu.CreateLuaContextMenuItem({str = data.name .. L" (" .. NewChatWindow.ChannelsFontsSize[ i ] .. L")", returnCode = i})
	end


	ContextMenu.CreateLuaContextMenuItem({str = ChatSettings.Channels[SystemData.ChatLogFilters.GM].name .. L" (" .. NewChatWindow.ChannelsFontsSize[ SystemData.ChatLogFilters.GM ] .. L")", returnCode = SystemData.ChatLogFilters.GM})
		
		ContextMenu.CreateLuaContextMenuItem({str = GetStringFromTid(1155208) .. L" (" .. NewChatWindow.ChannelsFontsSize[ 15 ] .. L")", returnCode = 15})
		ContextMenu.CreateLuaContextMenuItem({str = GetStringFromTid(1155209) .. L" (" .. NewChatWindow.ChannelsFontsSize[ 16 ] .. L")", returnCode = 16})
		ContextMenu.CreateLuaContextMenuItem({str = GetStringFromTid(1155206) .. L" (" .. NewChatWindow.ChannelsFontsSize[ 12 ] .. L")", returnCode = 17})
	ContextMenu.ActivateLuaContextMenu(NewChatWindow.FontSizeContextMenuCallback)
end 

function NewChatWindow.FontSizeContextMenuCallback( returnCode, param )

	local rdata = {title=GetStringFromTid(1155213), subtitle=GetStringFromTid(1155214), callfunction=NewChatWindow.SetFontSize, id=returnCode}
	RenameWindow.Create(rdata)
end

function NewChatWindow.SetFontSize(id, px)

	id = tonumber(id)
	if (type(tonumber(px)) == "number") then
		px = tonumber(px)
	else
		px = 12
	end
	if px > 36 then
		px = 36
	end
	if px < 8 then
		px = 8
	end
	if id == nil then
		for i, _ in pairs(NewChatWindow.ChannelsFontsSize) do
			NewChatWindow.ChannelsFontsSize[ i ]  = px
			Interface.SaveSetting( "ChannelsFontsSize" .. i,NewChatWindow.ChannelsFontsSize[ i ] ) 
		end
	else
		NewChatWindow.ChannelsFontsSize[ id ]  = px
		Interface.SaveSetting( "ChannelsFontsSize" .. id,NewChatWindow.ChannelsFontsSize[ id ] ) 
	end
	NewChatWindow.ClearAll()
	NewChatWindow.UpdateLog()
end

function NewChatWindow.FontSizeToolTip()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,GetStringFromTid(1155213) )
end

function NewChatWindow.FontColor()
	WindowSetShowing( "NewChatOptionsWindow", true)
end 
function NewChatWindow.FontColorToolTip()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,GetStringFromTid(1155215) )
end

function NewChatWindow.ChatSettingsToolTip()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,GetStringFromTid(1155216) )
end

function NewChatWindow.ChatContactsToolTip()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,GetStringFromTid(319) )
end

function NewChatWindow.LeaveChannelTooltip()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,GetStringFromTid(321) )

	LabelSetTextColor(SystemData.ActiveWindow.name, 255,0,0 )
end

function NewChatWindow.ChangeStatusTooltip()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name,GetStringFromTid(322) )
end

function NewChatWindow.LeaveChannelTooltipEnd()
	NewChatWindow.UpdateCurrentChatChannel()
end

function NewChatWindow.CreateChannelTooltip()
	LabelSetTextColor(SystemData.ActiveWindow.name, 0,255,0)
end

function NewChatWindow.CreateChannelTooltipEnd()
	LabelSetTextColor(SystemData.ActiveWindow.name, 255,255,255)
end

NewChatWindow.over = ""

function NewChatWindow.BookmarkToolTip()
	for i = 1, NewChatWindow.TabCount do
		if (DoesWindowExist("Bookmark" .. i .. "Text")) then
			if (i == NewChatWindow.ActiveTab) then
				local extTabs = 0
				for j = 1, NewChatWindow.maxTabs do
					local templatename = "NewChatWindow" .. j .."ResizeButton"
					if (DoesWindowExist( templatename)) then
						WindowSetShowing(templatename, not Interface.Settings.chat_locked)
						if (NewChatWindow.TabStatus[j].extracted) then
							extTabs = extTabs +1
						end
					end
				end
				if (NewChatWindow.TabCount - extTabs > 1) then
					LabelSetTextColor("Bookmark" .. i .. "Text", NewChatWindow.ActiveColor.r, NewChatWindow.ActiveColor.g, NewChatWindow.ActiveColor.b)
				else
					LabelSetTextColor("Bookmark" .. i .. "Text", NewChatWindow.NormalColor.r, NewChatWindow.NormalColor.g, NewChatWindow.NormalColor.b)
				end
			else
				LabelSetTextColor("Bookmark" .. i .. "Text", NewChatWindow.NormalColor.r, NewChatWindow.NormalColor.g, NewChatWindow.NormalColor.b)
			end
		end
	end
	if (string.find(SystemData.ActiveWindow.name, "Text", 1, true)) then
		LabelSetTextColor(SystemData.ActiveWindow.name, NewChatWindow.HighlightColor.r, NewChatWindow.HighlightColor.g, NewChatWindow.HighlightColor.b)
		NewChatWindow.over  = SystemData.ActiveWindow.name
	elseif (string.find(SystemData.ActiveWindow.name, "IMG", 1, true)) then
		LabelSetTextColor(string.gsub(SystemData.ActiveWindow.name,"IMG", "") .. "Text", NewChatWindow.HighlightColor.r, NewChatWindow.HighlightColor.g, NewChatWindow.HighlightColor.b)
		NewChatWindow.over  = string.gsub(NewChatWindow.over,"IMG", "")
	else
		LabelSetTextColor(SystemData.ActiveWindow.name .. "Text", NewChatWindow.HighlightColor.r, NewChatWindow.HighlightColor.g, NewChatWindow.HighlightColor.b)
		NewChatWindow.over  = SystemData.ActiveWindow.name .. "Text"
	end
	
end

function NewChatWindow.OnMouseOverEnd()
	for i = 1, NewChatWindow.TabCount do
		if (DoesWindowExist("Bookmark" .. i .. "Text")) then
			WindowSetAlpha("Bookmark" .. i .. "Text", 2)
			WindowSetFontAlpha("Bookmark" .. i .. "Text", 2)
			if (i == NewChatWindow.ActiveTab) then
				local extTabs = 0
				for j = 1, NewChatWindow.maxTabs do
					local templatename = "NewChatWindow" .. j .."ResizeButton"
					if (DoesWindowExist( templatename)) then
						WindowSetShowing(templatename, not Interface.Settings.chat_locked)
						if (NewChatWindow.TabStatus[j].extracted) then
							extTabs = extTabs +1
						end
					end
				end
				if (NewChatWindow.TabCount - extTabs > 1) then
					LabelSetTextColor("Bookmark" .. i .. "Text", NewChatWindow.ActiveColor.r, NewChatWindow.ActiveColor.g, NewChatWindow.ActiveColor.b)
				else
					LabelSetTextColor("Bookmark" .. i .. "Text", NewChatWindow.NormalColor.r, NewChatWindow.NormalColor.g, NewChatWindow.NormalColor.b)
				end
			else
				LabelSetTextColor("Bookmark" .. i .. "Text", NewChatWindow.NormalColor.r, NewChatWindow.NormalColor.g, NewChatWindow.NormalColor.b)
			end
		end
	end
end

function NewChatWindow.OnLButtonDown(flags)
	if (not Interface.Settings.chat_locked) then
		WindowSetMoving(WindowUtils.GetActiveDialog(),true)
		if not (flags == SystemData.ButtonFlags.SHIFT and flags ~= SystemData.ButtonFlags.CONTROL and flags ~= SystemData.ButtonFlags.ALT) then
			SnapUtils.StartWindowSnap(WindowUtils.GetActiveDialog())
		end
		NewChatWindow.waithide = true
	else
		WindowSetMoving(WindowUtils.GetActiveDialog(),false)
	end
end

function NewChatWindow.OnLButtonDownJW(flags)
	local id = WindowGetId(WindowUtils.GetActiveDialog())
	if (id == 0) then
		id = ""
	end
	if (not Interface.Settings.chat_locked) then
		WindowSetMoving("NewChatWindow" .. id,true)
		if not (flags == SystemData.ButtonFlags.SHIFT and flags ~= SystemData.ButtonFlags.CONTROL and flags ~= SystemData.ButtonFlags.ALT) then
			SnapUtils.StartWindowSnap("NewChatWindow" .. id)
		end
		NewChatWindow.waithide = true
	else
		WindowSetMoving("NewChatWindow" .. id,false)
	end
end

function NewChatWindow.OnLButtonUpJW()
	local id = WindowGetId(WindowUtils.GetActiveDialog())
	if (id == 0) then
		id = ""
	end
	WindowSetMoving("NewChatWindow" .. id,false)
	NewChatWindow.waithide = false
end

function NewChatWindow.OnLButtonUp()
	WindowSetMoving(WindowUtils.GetActiveDialog(),false)
	NewChatWindow.waithide = false
end

function NewChatWindow.OnUpdate(timePassed)
	NewChatWindow.deltaUpd = NewChatWindow.deltaUpd + timePassed
	if (NewChatWindow.deltaUpd > NewChatWindow.MinUpdateRate) then
		
		NewChatWindow.blockUpdate = false
		NewChatWindow.deltaUpd = 0
		if (NewChatWindow.UpdateReq) then
			NewChatWindow.UpdateLog()
			NewChatWindow.UpdateReq = false
		end
	end
		
	if (Interface.Settings.chat_autoHide and not NewChatWindow.waithide) then
		NewChatWindow.delta = NewChatWindow.delta + timePassed
		if (NewChatWindow.delta >= Interface.Settings.chat_fadeTime and not NewChatWindow.hidden) then
			if (WindowGetAlpha("NewChatWindow") > 0.01) then
				WindowStartAlphaAnimation("NewChatWindow", Window.AnimationType.SINGLE_NO_RESET, Interface.Settings.chat_BaseAlpha, 0.01, 2, false, 0, 1 )
				if (DoesWindowExist("Bookmark1") and WindowGetAlpha("Bookmark1") > 0.01) then
					WindowStartAlphaAnimation("Bookmark1", Window.AnimationType.SINGLE_NO_RESET, Interface.Settings.chat_BaseAlpha, 0.01, 2, false, 0, 1 )
				end
				if (not Interface.Settings.chat_textFade) then
					WindowSetParent("NewChatWindowJournalWindow", "Root")
					WindowSetLayer("NewChatWindowJournalWindow", Window.Layers.BACKGROUND	)
					WindowStartAlphaAnimation("NewChatWindowJournalWindowScrollbar", Window.AnimationType.SINGLE_NO_RESET, 1, 0.01, 2, false, 0, 1 )
				else
					WindowStartAlphaAnimation("NewChatWindowJournalWindow", Window.AnimationType.SINGLE_NO_RESET, Interface.Settings.chat_BaseAlpha, 0.01, 2, false, 0, 1 )
				end
			end
			for j = 1, NewChatWindow.maxTabs do
				local templatename = "NewChatWindow" .. j
				if (DoesWindowExist("Bookmark" .. j+1)) then
					WindowStartAlphaAnimation("Bookmark" .. j+1, Window.AnimationType.SINGLE_NO_RESET, Interface.Settings.chat_BaseAlpha, 0.01, 2, false, 0, 1 )
				end
				if (DoesWindowExist( templatename) and WindowGetAlpha(templatename) > 0.01) then
					WindowStartAlphaAnimation(templatename, Window.AnimationType.SINGLE_NO_RESET, Interface.Settings.chat_BaseAlpha, 0.01, 2, false, 0, 1 )
					if (not Interface.Settings.chat_textFade) then
						WindowSetParent("NewChatWindowBookmark" .. j, "Root")
						WindowSetLayer("NewChatWindowBookmark" .. j, Window.Layers.BACKGROUND	)
						WindowStartAlphaAnimation("NewChatWindowBookmark" .. j .. "Scrollbar", Window.AnimationType.SINGLE_NO_RESET, 1, 0.01, 2, false, 0, 1 )
					else
						WindowStartAlphaAnimation("NewChatWindowBookmark" .. j, Window.AnimationType.SINGLE_NO_RESET, Interface.Settings.chat_BaseAlpha, 0.1, 2, false, 0, 1 )
					end
				end
			end
			
			NewChatWindow.hidden = true			
		end
	end
end 

function NewChatWindow.CloseChatBox()
	WindowAssignFocus( "ChatWindowContainerTextInput", false )
	NewChatWindow.ChatWindowResetTextBox()
	WindowSetShowing( "ChatWindowContainer", false )
end

function NewChatWindow.UpdateCurrentChatChannel()

	-- fix current channel name
	if NewChatWindow.currentChannel ~= L"" and WindowData.CurrentChannel == L"" then
		WindowData.CurrentChannel = NewChatWindow.currentChannel
	end

	-- do we have a current channel?
	if WindowData.CurrentChannel == L"" then
		LabelSetText("NewChatChannelSelectionWindowCurrChannelName", GetStringFromTid(1011051)) -- None
		LabelSetTextColor( "NewChatChannelSelectionWindowCurrChannelName", 175, 175, 175 )
		WindowSetHandleInput("NewChatChannelSelectionWindowCurrChannelName", false)

	else -- show channel name
		LabelSetText("NewChatChannelSelectionWindowCurrChannelName", WindowData.CurrentChannel)
		LabelSetTextColor( "NewChatChannelSelectionWindowCurrChannelName", 255, 255, 255 )
		WindowSetHandleInput("NewChatChannelSelectionWindowCurrChannelName", true)
	end
end

function NewChatWindow.ToggleChannel()

	-- get the current selected channel
	local previousSelection = NewChatWindow.currentSelection

	-- get the new selected channel
	NewChatWindow.currentSelection = WindowGetId(SystemData.ActiveWindow.name)
	
	-- do we have a previous selection?
	if (previousSelection and previousSelection ~= -1) then

		-- de-select the previous channel
		ButtonSetPressedFlag("channel_"..tostring(previousSelection), false)
	end

	-- select the new channel
	ButtonSetPressedFlag("channel_"..tostring(NewChatWindow.currentSelection), true)

	-- update the scroll list
	ScrollWindowUpdateScrollRect("ChannelListWindow")

	-- join the selected channel
	ChatJoinChannel(ButtonGetText("channel_"..tostring(NewChatWindow.currentSelection)))

	-- update the selection
	NewChatWindow.UpdateCurrentChatChannel()

	-- hide the selection window
	NewChatWindow.HideChannelSelectionMenu()
end

function NewChatWindow.ClearChatChannelsList()

	-- scan all labels
	for i = 1, NewChatWindow.createdChannelsLabels do

		-- current channel name
		local currentChannelButton = "channel_"..tostring(i)

		-- does the label still exist?
		if DoesWindowExist(currentChannelButton) then

			-- destroy the label
			DestroyWindow(currentChannelButton)
		end
	end

	-- reset labels count
	NewChatWindow.createdChannelsLabels = 0
end

function NewChatWindow.RefreshChannelsList()

	-- clear the list
	NewChatWindow.ClearChatChannelsList()

	-- initialize window names
	local previousChannelButton
	local currentChannelButton
	
	-- scan all available channels
	for i = 1, WindowData.ChannelListCount do

		-- current channel name
		currentChannelButton = "channel_"..tostring(i)

		-- current channel name
		local channelName = WindowData.ChannelList[i]
		
		-- create button
		CreateWindowFromTemplate(currentChannelButton, "ChannelButtonTemplate", "ChannelListChildWindow")

		-- add the channel name
		ButtonSetText(currentChannelButton, channelName)

		-- set the channel as
		ButtonSetPressedFlag(currentChannelButton, false)
		WindowSetId(currentChannelButton, i)
		
		-- if there is no previous, then this is the first channel in the list
		if previousChannelButton == nil then

			-- anchor the element at the top of the window
			WindowAddAnchor(currentChannelButton, "topleft", "ChannelListChildWindow", "topleft", 10, 5)

		else -- anchor the element to the previous one
			WindowAddAnchor(currentChannelButton, "bottomleft", previousChannelButton, "topleft", 0, 0)
		end

		-- is this the current active channel?
		if WindowData.CurrentChannel == channelName then

			-- highlight the current channel in the list
			ButtonSetPressedFlag(currentChannelButton, true)

			-- update the selected index
			NewChatWindow.currentSelection = i
		end

		-- store the current element as previous
		previousChannelButton = currentChannelButton

		-- update the labels count
		NewChatWindow.createdChannelsLabels = i
	end
end

function NewChatWindow.CreateChannelWindowInitialize()
	
	WindowUtils.SetWindowTitle("CreateChannelWindow", GetStringFromTid(NewChatWindow.ChannelTID.CreateChannelTitle))
	ButtonSetText( "CreateChannelWindowOkayButton", GetStringFromTid(NewChatWindow.ChannelTID.Okay) )
	ButtonSetText( "CreateChannelWindowCancelButton", GetStringFromTid(NewChatWindow.ChannelTID.Cancel) )
end

function NewChatWindow.CreateCancel_OnLButtonUp()
	DestroyWindow("CreateChannelWindow")
end

function NewChatWindow.CreateChannel()
	local textEntry = TextEditBoxGetText("CreateChannelWindowTextEntry")
	ChatCreateChannel(textEntry)
	
	DestroyWindow("CreateChannelWindow")
	DestroyWindow("ChannelWindow")
end

function NewChatWindow.Create_OnLButtonUp()
	CreateWindow("CreateChannelWindow", true)
end

function NewChatWindow.OfflineTooltip()		
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1070798))	
end

function NewChatWindow.OnlineTooltip()		
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1079366))	
end

function NewChatWindow.RemoveTooltip()		
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(3006099))	
end

function NewChatWindow.SelectActiveFriend(override)	

	-- current window name
	local friendSelection = SystemData.ActiveWindow.name

	-- are we trying to force-select a friend?
	if (override == nil or override == 0) then
	
		-- get the ID from the current selection
		WindowData.GChatIndex = WindowGetId(friendSelection)
	end     

	-- get the text from the search box
	local text = SearchBox.GetFilter("NewChatContactsWindowSearchBox", true)

	-- scan all friends
	for i = 1, WindowData.GChatCount do		

		-- current friend name
		local friendName = towstring(WindowData.GChatNameList[i])

		-- do we have a name (or part of it) in the search box? let's make sure the friend name is compatible with the filter
		if towstring(text) ~= L"" and not wstring.find(wstring.lower(friendName), text, 1, true) then
			continue
		end

		-- current friend online status
		local friendPresence = WindowData.GChatPresenceList[i]

		-- current friend window element
		local currentFriend = "friend_"..tostring(i)

		-- make sure the current element exist
		if not DoesWindowExist(currentFriend) then
			continue
		end

		-- current element button window names
		local currentFriendPresenceButton = currentFriend .. "Presence"
		local currentFriendPresenceOfflineButton = currentFriendPresenceButton .. "Offline"
		local currentFriendPresenceOnlineButton = currentFriendPresenceButton .. "Online"
		local currentFriendNameButton = currentFriend .. "Name"

		-- set the button as not highlighted by default
		ButtonSetPressedFlag(currentFriendNameButton, false)

		-- is this the selected friend?
		if WindowData.GChatIndex == i then	
		
			-- select the friend
			ButtonSetPressedFlag(currentFriendNameButton, true)
		end		
	end
		
	-- is this an override?
	if (override == nil or override == 0) then

		-- force the update of the friend list
		NewChatWindow.firstGChatSelect = false
		NewChatWindow.OnGChatRosterUpdate()  

		-- force the chat to the main chat channel
		NewChatWindow.SwitchToGChatSelectedChannel()

	-- is this the first time something has been selected?
	elseif NewChatWindow.firstGChatSelect then

		-- select the first friend in the list
		WindowData.GChatIndex = WindowData.GChatIndex + 1    
	end
end

function NewChatWindow.OnGStatusContext()
	
	-- reset the context menu
	ContextMenu.CleanUp()

	-- scan al possible states
	for i, status in pairsByIndex(NewChatWindow.Presence) do

		-- creating the context menu button and highlight the active status
		ContextMenu.CreateLuaContextMenuItem({tid = status.tid, returnCode = i, textColor = status.color})
	end

	-- show the context menu
	ContextMenu.ActivateLuaContextMenu(NewChatWindow.StatusContextMenuCallback)
end

function NewChatWindow.StatusContextMenuCallback( returnCode, param )

	-- change the status flag
	WindowData.GChatMyPresence = NewChatWindow.Presence[returnCode].id
	
	-- save the chat availability status
	Interface.ChatStatus = WindowData.GChatMyPresence

	-- trigger the update event
	BroadcastEvent( SystemData.Events.TOGGLE_GLOBAL_CHAT_PRESENCE )
end

function NewChatWindow.OnGChatPresenceUpdate()

	-- is the contacts window available?
	if not DoesWindowExist("NewChatContactsWindow") then

		-- retry later
		Interface.AddTodoList({name = "chat presence update retry", func = function() NewChatWindow.OnGChatPresenceUpdate() end, time = Interface.TimeSinceLogin + 1})
		return
	end
	
	-- get the current status data
	local currentStatus = NewChatWindow.Presence[WindowData.GChatMyPresence + 1]

	-- fill the status label
	LabelSetText("NewChatContactsWindowCurrStatusText", GetStringFromTid(currentStatus.tid))

	-- fix the status label color
	LabelSetTextColor("NewChatContactsWindowCurrStatusText", currentStatus.color.r, currentStatus.color.g, currentStatus.color.b)
end

function NewChatWindow.ClearFriendsList()

	-- scan all labels
	for i = 1, NewChatWindow.friendsLabels do

		-- current friend name
		local currentFriendButton = "friend_"..tostring(i)

		-- does the label still exist?
		if DoesWindowExist(currentFriendButton) then

			-- destroy the label
			DestroyWindow(currentFriendButton)
		end
	end

	-- reset labels count
	NewChatWindow.friendsLabels = 0
end

function NewChatWindow.OnGChatRosterUpdate()
    
	-- is the contacts window available?
	if not DoesWindowExist("NewChatContactsWindow") then

		-- retry later
		Interface.AddTodoList({name = "chat friends list update retry", func = function() NewChatWindow.OnGChatRosterUpdate() end, time = Interface.TimeSinceLogin + 1})
		return
	end

	-- remove all friends from the list
	NewChatWindow.ClearFriendsList()

	-- initialize anchoring element names
	local previousFriend
	local currentFriend

	-- image texture name
	local texture = "UO_Core"	

	-- active friend ID (the one we're going to talk to if we use /x)
	local activeFriend

	-- get the text from the search box
	local text = SearchBox.GetFilter("NewChatContactsWindowSearchBox", true)

	-- scan all the friends in the list
	for i = 1, WindowData.GChatCount do		
		
		-- current friend name
		local friendName = towstring(WindowData.GChatNameList[i])

		-- do we have a name (or part of it) in the search box? let's make sure the friend name is compatible with the filter
		if towstring(text) ~= L"" and not wstring.find(wstring.lower(friendName), text, 1, true) then
			continue
		end

		-- current friend online status
		local friendPresence = WindowData.GChatPresenceList[i]

		-- current friend element name
		currentFriend = "friend_" .. tostring(i)

		-- create the element
		CreateWindowFromTemplate( currentFriend, "GChatRosterListItemTemplate", "GChatRosterContent" )
		
		-- buttons names
		local currentFriendPresenceButton = currentFriend .. "Presence"
		local currentFriendPresenceOfflineButton = currentFriendPresenceButton .. "Offline"
		local currentFriendPresenceOnlineButton = currentFriendPresenceButton .. "Online"
		local currentFriendNameButton = currentFriend .. "Name"
		
		
		-- set the ID to all the buttons
		WindowSetId(currentFriendPresenceOfflineButton, i)
		WindowSetId(currentFriendPresenceOnlineButton, i)
		WindowSetId(currentFriendNameButton, i)
		WindowSetId(currentFriend .. "Remove", i)

		-- set the friend name
		ButtonSetText(currentFriendNameButton, friendName)

		-- set the button as not highlighted by default
		ButtonSetPressedFlag(currentFriendNameButton, false)

		-- is this the active friend we're talking to (with /x)?
		if WindowData.GChatIndex == i then		

			-- highlight the button
			ButtonSetPressedFlag(currentFriendNameButton, true)

			-- save the current friend element (to scroll to after)
			activeFriend = currentFriend
		end
		
		-- is the friend online?
		if friendPresence == 1 then	

			-- show the online image and hide the offline
			WindowSetShowing(currentFriendPresenceOnlineButton, true);
			WindowSetShowing(currentFriendPresenceOfflineButton, false);

		else -- hide the online image and show the offline one
			WindowSetShowing(currentFriendPresenceOnlineButton, false);
			WindowSetShowing(currentFriendPresenceOfflineButton, true);
		end
		
		-- is this the first element?
		if previousFriend == nil then

			-- anchor the element to the top
			WindowAddAnchor(currentFriend, "topleft", "GChatRosterContent", "topleft", 0, 0)	
			
		else -- anchor the element to the previous one
			WindowAddAnchor(currentFriend, "bottomleft", previousFriend, "topleft", 0, 0)
		end

		-- save the current element as previous one
		previousFriend = currentFriend

		-- update the labels count
		NewChatWindow.friendsLabels = i
	end
	
	-- update the scrollable area
	ScrollWindowUpdateScrollRect("GChatRosterScrollWindow")

	-- do we have an active friend?
	if activeFriend ~= nil then

		-- scroll to the active friend
        WindowUtils.ScrollToElementInScrollWindow( activeFriend, "GChatRosterScrollWindow", "GChatRosterContent" )
    end

	-- update roster combo
	NewChatWindow.OnComboRosterUpdate()  
end

function NewChatWindow.UpdateFriendPresence()	

	-- get the text from the search box
	local text = SearchBox.GetFilter("NewChatContactsWindowSearchBox", true)

	-- scan all contacts
    for i = 1, WindowData.GChatCount do	
		
		-- current friend name
		local friendName = towstring(WindowData.GChatNameList[i])

		-- do we have a name (or part of it) in the search box? let's make sure the friend name is compatible with the filter
		if towstring(text) ~= L"" and not wstring.find(wstring.lower(friendName), text, 1, true) then
			continue
		end

		-- current friend online status
		local friendPresence = WindowData.GChatPresenceList[i]

		-- current contact window name
		local currentFriend = "friend_" .. tostring(i)		

		-- make sure the current element exist
		if not DoesWindowExist(currentFriend) then
			continue
		end

		-- current contact button window names
		local currentFriendPresenceButton = currentFriend .. "Presence"
		local currentFriendPresenceOfflineButton = currentFriendPresenceButton .. "Offline"
		local currentFriendPresenceOnlineButton = currentFriendPresenceButton .. "Online"		

		-- is the friend online?
		if friendPresence == 1 then	

			-- show the online image and hide the offline
			WindowSetShowing(currentFriendPresenceOnlineButton, true);
			WindowSetShowing(currentFriendPresenceOfflineButton, false);

		else -- hide the online image and show the offline one
			WindowSetShowing(currentFriendPresenceOnlineButton, false);
			WindowSetShowing(currentFriendPresenceOfflineButton, true);
		end
	end
end

function NewChatWindow.RemoveFriendConfirm()
	
	-- is the current player status online?
	if WindowData.GChatMyPresence == NewChatWindow.GC_SHOW_UNAVAILABLE then
		return
	end

	-- get the current selected friend
	local friendSelection = WindowGetId(SystemData.ActiveWindow.name)

	local OKButton = { textTid=UO_StandardDialog.TID_OKAY, callback=function() NewChatWindow.RemoveFriend(friendSelection) end } -- OK
	local cancelButton = { textTid=UO_StandardDialog.TID_CANCEL } -- Cancel

	local RessConfirmWindow = 
				{
					windowName = "ConfirmRemoveFriend",
					body = ReplaceTokens(GetStringFromTid(323), { towstring(WindowData.GChatNameList[friendSelection])} ),
					title = WindowUtils.translateMarkup(GetStringFromTid(3006099)), -- Remove Friend
					buttons = { OKButton, cancelButton },
					closeCallback = cancelButton.callback,
					destroyDuplicate = true,
				}
	UO_StandardDialog.CreateDialog(RessConfirmWindow)
end

function NewChatWindow.RemoveFriend(friendSelection)	

	-- store the friend ID
	WindowData.RemoveGChatIndex = friendSelection

	-- trigger the removal event
	BroadcastEvent( SystemData.Events.REMOVE_GLOBAL_CHAT_FRIEND )
end

function NewChatWindow.OnAddFriend()

	-- is the player currently online?
	if WindowData.GChatMyPresence == NewChatWindow.GC_SHOW_CHAT then
		
		-- raise the add friend event
		BroadcastEvent( SystemData.Events.ADD_GLOBAL_CHAT_FRIEND)				
	end
end