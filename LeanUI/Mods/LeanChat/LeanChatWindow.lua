
LeanChatWindow = {}

LeanChatWindow.ChannelNum = 1

function LeanChatWindow.Initialize()
	WindowRegisterEventHandler( "LeanChatWindow", SystemData.Events.CHAT_ENTER_START, "LeanChatWindow.OnEnterText")
    WindowRegisterEventHandler( "LeanChatWindow", SystemData.Events.TEXT_ARRIVED,     "LeanChatWindow.OnNewTextAlert")
    
    LogDisplayAddLog("LeanChatLogDisplay", "Chat", true)
    --LogDisplayAddLog("LeanChatLogDisplay", "UiLog", true)
    
    for filterId, msgTypeData in pairs( ChatSettings.Channels ) 
    do
        LogDisplaySetFilterState("LeanChatLogDisplay", msgTypeData.logName, msgTypeData.id, (msgTypeData.isOnAlways or msgTypeData.isOnChat or msgTypeData.isOnJournal) )

        local color = ChatSettings.ChannelColors[ filterId ]
        LogDisplaySetFilterColor("LeanChatLogDisplay", msgTypeData.logName, msgTypeData.id, color.r, color.g, color.b )
    end
    
    WindowSetAlpha("LeanChatOptions", 0.2)
    WindowSetAlpha("LeanChatResizeButton", 0.2)
    
    WindowUtils.RestoreWindowPosition("LeanChatWindow", true)
end

function LeanChatWindow.Shutdown()
    WindowUtils.SaveWindowPosition("LeanChatWindow")
end

function LeanChatWindow.OnEnterText()
	if (not WindowHasFocus("LeanChatInput")) then
		WindowSetShowing("LeanChatInput", true)
    	WindowAssignFocus("LeanChatInput", true)
    	
    	LeanChatWindow.UpdatePrompt()
    	WindowSetAlpha("LeanChatOptions", 0.8)
    end
end


function LeanChatWindow.OnKeyEnter()
    local chatChannel = L""
    local chatText = LeanChatInput.Text
    local channel = ChatSettings.Ordering[LeanChatWindow.ChannelNum]
    
    if (channel ~= nil) then
        chatChannel = ChatSettings.Channels[channel].serverCmd
        
        if (channel == SystemData.ChatLogFilters.TELL_SEND) then
            if (whisperTarget ~= nil) then
                chatChannel = ChatSettings.Channels[channel].serverCmd..L" "..whisperTarget
            else               
                chatText = L""
            end
        end        
    end

    if wstring.sub(chatText, 1, 4) == L"vs: " then
    
        ContextMenu.VendorSearch()
    else
        SendChat(chatChannel, chatText)  
    end
  
    -- Reset the input field
	LeanChatWindow.OnKeyEscape()
end

function LeanChatWindow.OnKeyEscape()
    -- Hide the Text Input Window
    TextEditBoxSetText("LeanChatInput", L"")
    WindowAssignFocus("LeanChatInput", false)
    WindowSetShowing("LeanChatInput", false)
    WindowSetShowing("LeanChatPrompt", false)
    WindowSetAlpha("LeanChatOptions", 0.2)
end

function LeanChatWindow.OnKeyTab()
	if (LeanChatWindow.ChannelNum == 1) then
		LeanChatWindow.ChannelNum = 3
	elseif (LeanChatWindow.ChannelNum == 3) then
		LeanChatWindow.ChannelNum = 8
	else
		LeanChatWindow.ChannelNum = LeanChatWindow.ChannelNum + 1
		if (LeanChatWindow.ChannelNum > 11) then
			LeanChatWindow.ChannelNum = 1
		end
	end
	
	LeanChatWindow.UpdatePrompt()
end

function LeanChatWindow.UpdatePrompt()
	local channel = ChatSettings.Ordering[LeanChatWindow.ChannelNum]
	local channelColor = ChatSettings.ChannelColors[channel]

	if (ChatSettings.Channels[channel].serverCmd == nil) then
		LeanChatWindow.OnKeyTab()
		return
	end

	WindowSetShowing("LeanChatPrompt", true)
	
	local r = channelColor.r
	r = r * 1.2
	if r > 255 then
	 r = 255
  end
  local g = channelColor.g
  g = g * 1.2
  if g > 255 then
   g = 255
  end
  local b = channelColor.b
  b = b * 1.2
  if b > 255 then
   b = 255
  end
	
  LabelSetTextColor("LeanChatPrompt", r, g, b)
	LabelSetText("LeanChatPrompt", wstring.sub(ChatSettings.Channels[channel].serverCmd, 2) .. L":")
end

function LeanChatWindow.OnOptions()
	ChatWindow.activeWindow = 1
	WindowSetShowing( "ChatOptionsWindow", true)
end


function LeanChatWindow.OnResizeBegin(flags, x, y)	
    WindowUtils.BeginResize("LeanChatWindow", "topleft", 150, 100, false)
end

function LeanChatWindow.OnNewTextAlert()
	if ((SystemData.Settings.Interface.OverheadChat or SystemData.TextAlwaysShow) and SystemData.TextSourceID ~= -1) then
		OverheadText.ShowOverheadText()
	end    
end
