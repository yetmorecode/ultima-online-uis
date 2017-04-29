----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

OverheadText = {}

----------------------------------------------------------------
-- *** Local Variables
----------------------------------------------------------------
OverheadText.ActiveIdList = {}
OverheadText.FadeTimeId = {}
OverheadText.TimePassed = {}
OverheadText.AlphaStart = 0.8
OverheadText.AlphaDiff = 0.02
OverheadText.FadeStartTime = 2.5

OverheadText.ChatData = {}
--how long the overhead chats will stay on screen (in sec's)
OverheadText.OverheadAlive = 10
OverheadText.MaxOverheadHeight = 150

OverheadText.mouseOverId = 0

OverheadText.GetsOverhead = {
	false,	--	System
	true,	--	Say
	false,	--	Private
	false,	--	Custom
	true,	--	Emote
	true,	--	Gesture
	true,	--	Whisper
	true,	--	Yell
	true,	--	Party
	true,	--	Guild
	true,	--	Alliance
--	false,	--	Faction
}


OverheadText.OnTextArrivedHandler = {}

function OverheadText.AddTextArrivedHandler(handler)
	local sz = table.getn(OverheadText.OnTextArrivedHandler)
	OverheadText.OnTextArrivedHandler[sz+1] = handler
end

function OverheadText.NotifyTextArrivedHandler(text)
	if text == nil then
		return
	end
	
	if text == L"" then
		return
	end
	
	for key,value in pairs(OverheadText.OnTextArrivedHandler) do
		handler = OverheadText.OnTextArrivedHandler[key]
		pcall(handler, text)
	end
end


----------------------------------------------------------------
-- OverheadText Functions
----------------------------------------------------------------
function OverheadText.InitializeEvents()
    -- we only want to register for these events once so we dont get the event for every instance of the name window
    WindowRegisterEventHandler("Root", WindowData.MobileName.Event, "OverheadText.HandleMobileNameUpdate")
    WindowRegisterEventHandler("Root", SystemData.Events.SHOWNAMES_UPDATED, "OverheadText.HandleSettingsUpdate")
    WindowRegisterEventHandler("Root", SystemData.Events.SHOWNAMES_FLASH_TEMP, "OverheadText.HandleFlashTempNames")
    WindowRegisterEventHandler("Root", SystemData.Events.USER_SETTINGS_UPDATED, "OverheadText.UpdateSettings")
    
    OverheadText.UpdateSettings()
end

function OverheadText.Initialize()
	local this = SystemData.ActiveWindow.name
	local mobileId = SystemData.DynamicWindowId

	WindowSetId(this, mobileId)
	
	OverheadText.FadeTimeId[mobileId] = OverheadText.AlphaStart
	OverheadText.TimePassed[mobileId] = 0
	OverheadText.ActiveIdList[mobileId] = true

	OverheadText.ChatData[mobileId] = {}
	OverheadText.ChatData[mobileId].numVisibleChat = 0
	OverheadText.ChatData[mobileId].timePassed = {}
	OverheadText.ChatData[mobileId].timePassed[1] = 0
	OverheadText.ChatData[mobileId].timePassed[2] = 0
	OverheadText.ChatData[mobileId].timePassed[3] = 0
	OverheadText.ChatData[mobileId].showName = true
	
	RegisterWindowData(WindowData.MobileName.Type, mobileId)	

	OverheadText.UpdateName(mobileId)
	WindowSetShowing(this.."Chat1", false)
	WindowSetShowing(this.."Chat2", false)
	WindowSetShowing(this.."Chat3", false)
end

function OverheadText.Shutdown()
	local this = SystemData.ActiveWindow.name
	local mobileId = WindowGetId(this)
	
	OverheadText.FadeTimeId[mobileId] = nil
	OverheadText.TimePassed[mobileId] = nil
	OverheadText.ActiveIdList[mobileId] = nil
	OverheadText.ChatData[mobileId] = nil
	
	if (OverheadText.mouseOverId == mobileId) then
		OverheadText.NameOnMouseOverEnd()
	end
	
	DetachWindowFromWorldObject( mobileId, "OverheadTextWindow_"..mobileId )
	UnregisterWindowData(WindowData.MobileName.Type, mobileId)
end

function OverheadText.HandleMobileNameUpdate()
    OverheadText.UpdateName(WindowData.UpdateInstanceId)
end

function OverheadText.HandleSettingsUpdate()
	for i, id in pairs(OverheadText.ActiveIdList) do
		local windowName = "OverheadTextWindow_"..i
		if(SystemData.Settings.GameOptions.showNames == SystemData.Settings.GameOptions.SHOWNAMES_NONE) then
			OverheadText.HideName(i)
		elseif(SystemData.Settings.GameOptions.showNames == SystemData.Settings.GameOptions.SHOWNAMES_APPROACHING or SystemData.Settings.GameOptions.showNames == SystemData.Settings.GameOptions.SHOWNAMES_ALL) then
			OverheadText.ShowName(i)
		end
	end
end

-- Used in the Macro Action 'All Names'
-- If the Show Names setting isn't set on 'Always', it will show all the names temporarily on the screen.
function OverheadText.HandleFlashTempNames()
	for i, id in pairs(OverheadText.ActiveIdList) do
		OverheadText.ShowName(i)
	end
end

function OverheadText.UpdateSettings()
	local userSetting = SystemData.Settings.Interface.OverheadChatFadeDelay
	
	if (userSetting == 1) then
		OverheadText.OverheadAlive = 5
	elseif (userSetting == 2) then
		OverheadText.OverheadAlive = 10
	elseif (userSetting == 3) then
		OverheadText.OverheadAlive = 30
	elseif (userSetting == 4) then
		OverheadText.OverheadAlive = 60
	elseif (userSetting == 5) then
		OverheadText.OverheadAlive = 300
	elseif (userSetting == 6) then
		OverheadText.OverheadAlive = 0
	else
		OverheadText.OverheadAlive = 5
	end
end

function OverheadText.UpdateName(mobileId)
	-- Player and object names are not displayed
	if( OverheadText.ChatData[mobileId] == nil ) then
		--return
	end
	
	if( OverheadText.ChatData[mobileId].showName == false ) then
		return
	end

	local data = WindowData.MobileName[mobileId]
	local windowName = "OverheadTextWindow_"..mobileId
	local labelName = windowName.."Name"
    
	if not DoesWindowNameExist(windowName) then
		return
	end
	
	if data.MobName ~= nil then
	
	  -- Fire event for other components to listen on new incoming names
	  OverheadText.NotifyTextArrivedHandler(data.MobName)
	  
	  -- Hide RC and EV names
	  if data.MobName == L" A Rising Colossus " or 
	     data.MobName == L"an energy vortex" or
	     data.MobName == L" An Energy Vortex "
	  then
	    return
	  end
	
		-- Only show names if "hide blues" is disabled or mob is not blue	
		if Interface.LoadBoolean("Lean.HidePlayerNames", false) and data.Notoriety == 1 then
		  -- Hide it
		  LabelSetText(labelName, L"")
      WindowSetDimensions(windowName, 0, 0)
		  WindowSetShowing(windowName, false);
		else
		  -- Normal update
		  LabelSetText(labelName, L""..data.MobName)
      local x, y = LabelGetTextDimensions(labelName)
      WindowSetDimensions(windowName, x, y)
      NameColor.UpdateLabelNameColor(labelName, data.Notoriety+1)
      WindowSetShowing(windowName, true);
		end
	else
		--Destroy the entire overhead text window if the mobile status is not there anymore.
		--Player probably teleported and we didn't delete the mobiles name.
		  Debug.PrintToChat(L"destroy")
  		DestroyWindow(windowName)
	end
end

function OverheadText.Update( timePassed )
	--timer for overhead msg
	if OverheadText.OverheadAlive ~= 0 then
		for id, data in pairs(OverheadText.ChatData) do
			for index, totalTimePassed in pairs(data.timePassed) do
				if totalTimePassed ~= nil then
					data.timePassed[index] = totalTimePassed + timePassed
					if data.timePassed[index] >= OverheadText.OverheadAlive then
						local windowName = "OverheadTextWindow_"..id
						local overheadChatWindow = windowName.."Chat"..index
						
						WindowSetShowing(overheadChatWindow, false)
						LabelSetText( overheadChatWindow, L"")
						
						data.timePassed[index] = nil
						data.numVisibleChat = data.numVisibleChat - 1
						if (data.numVisibleChat < 0) then
							data.numVisibleChat = 0
						end
					end
				end
			end
		end
	end

	if (SystemData.Settings.GameOptions.showNames ~= SystemData.Settings.GameOptions.SHOWNAMES_ALL) then
		for i, id in pairs(OverheadText.ActiveIdList) do
			if( OverheadText.FadeTimeId[i] ~= nil ) then
				OverheadText.TimePassed[i] = OverheadText.TimePassed[i] + timePassed
				if(OverheadText.TimePassed[i] > OverheadText.FadeStartTime ) then
					local windowName = "OverheadTextWindow_"..i
					OverheadText.FadeTimeId[i] = OverheadText.FadeTimeId[i] - OverheadText.AlphaDiff
					if(OverheadText.FadeTimeId[i] <= 0) then
						--Hide Name Window
						OverheadText.HideName(i)
					else
						local labelName = windowName.."Name"
						WindowSetFontAlpha(labelName, OverheadText.FadeTimeId[i])
					end
				end
			end
		end
	end
end

function OverheadText.ShowName(mobileId)
  -- Do not show names at all (client setting)
	if (OverheadText.ChatData[mobileId].showName == false) then
		return
	end
	
	-- Do not show blue names
	local data = WindowData.MobileName[mobileId]
	if Interface.LoadBoolean("Lean.HidePlayerNames", false) and data ~= nil and data.Notoriety == 1 then
	  return
	end
  
	OverheadText.FadeTimeId[mobileId] = OverheadText.AlphaStart
	OverheadText.TimePassed[mobileId] = 0
	
	local windowName = "OverheadTextWindow_"..mobileId
	WindowSetShowing(windowName.."Name", true)
	WindowSetFontAlpha(windowName.."Name", 0.7)
	
	OverheadText.UpdateOverheadAnchors(mobileId)
end

function OverheadText.HideName(mobileId)
	OverheadText.FadeTimeId[mobileId] = nil
	OverheadText.TimePassed[mobileId] = nil
	
	local windowName = "OverheadTextWindow_"..mobileId
	WindowSetShowing(windowName.."Name", false)
	
	OverheadText.UpdateOverheadAnchors(mobileId)
end

function OverheadText.UpdateOverheadAnchors(mobileId)
	local windowName = "OverheadTextWindow_"..mobileId
	local overheadNameWindow = windowName.."Name"
	local overheadChat1Window = windowName.."Chat1"
	local overheadChat2Window = windowName.."Chat2"
	local overheadChat3Window = windowName.."Chat3"
	
	if(DoesWindowNameExist(windowName) == true) then
		-- NOTE: Player and object names are not displayed, do not anchor chat window to name window.
		if( WindowGetShowing(overheadNameWindow) == true and OverheadText.ChatData[mobileId].showName == true ) then
			WindowClearAnchors(overheadChat1Window)
			WindowAddAnchor(overheadChat1Window, "top", overheadNameWindow, "bottom", 0, -10)
			WindowClearAnchors(overheadChat2Window)
			WindowAddAnchor(overheadChat2Window, "top", overheadChat1Window, "bottom", 0, 0)
			WindowClearAnchors(overheadChat3Window)
			WindowAddAnchor(overheadChat3Window, "top", overheadChat2Window, "bottom", 0, 0)
		else
			WindowClearAnchors(overheadChat1Window)
			WindowAddAnchor(overheadChat1Window, "bottom", windowName, "bottom", 0, 0)
			WindowClearAnchors(overheadChat2Window)
			WindowAddAnchor(overheadChat2Window, "top", overheadChat1Window, "bottom", 0, 0)
			WindowClearAnchors(overheadChat3Window)
			WindowAddAnchor(overheadChat3Window, "top", overheadChat2Window, "bottom", 0, 0)
		end
	end
end

function OverheadText.OnShown()
	local this = SystemData.ActiveWindow.name
	local mobileId = WindowGetId(this)
	
	-- if names are not being displayed, keep name hidden
	if(SystemData.Settings.GameOptions.showNames == SystemData.Settings.GameOptions.SHOWNAMES_NONE) then
		OverheadText.HideName(mobileId)
		return
	end
	
    -- window was shown so reset the timers and the font alpha	
	OverheadText.FadeTimeId[mobileId] = OverheadText.AlphaStart
	OverheadText.TimePassed[mobileId] = 0
	
	local labelName = this.."Name"
	WindowSetFontAlpha( labelName, OverheadText.AlphaStart)
end

function OverheadText.NameOnLClick()
	local this = SystemData.ActiveWindow.name
	local parent = WindowGetParent(this)
	local mobileId = WindowGetId(parent)
	
	--Let the targeting manager handle single left click on the target
	if mobileId ~= nil then
		--If player has a targeting cursor up and they target the overhead name
		--send a event telling the client they selected a target
		if WindowData.Cursor ~= nil and WindowData.Cursor.target == true then
			--Let player select there window as there target
			HandleSingleLeftClkTarget(mobileId)
			return
		end
		
		if SystemData.DragItem.DragType == SystemData.DragItem.TYPE_NONE and IsMobile(mobileId) then
			HealthBarManager.OnBeginDragHealthBar(mobileId)
		end
	end
end

function OverheadText.OnLButtonUp()
	if( SystemData.DragItem.DragType == SystemData.DragItem.TYPE_ITEM ) then
		local this = SystemData.ActiveWindow.name
		local parent = WindowGetParent(this)
		local mobileId = WindowGetId(parent)
	    DragSlotDropObjectToObject(mobileId)
	end
end


function OverheadText.NameOnDblClick()
	local this = SystemData.ActiveWindow.name
	local parent = WindowGetParent(this)
	local mobileId = WindowGetId(parent)
	
	UserActionUseItem(mobileId,false)
end

function OverheadText.NameOnMouseOver()
	local this = SystemData.ActiveWindow.name
	local parent = WindowGetParent(this)
	local mobileId = WindowGetId(parent)
	local itemData =
	{
		windowName = this,
		itemId = mobileId,
		itemType = WindowData.ItemProperties.TYPE_ITEM,
	}					
	ItemProperties.SetActiveItem(itemData)
	OverheadText.mouseOverId = mobileId
end

function OverheadText.NameOnMouseOverEnd()
	ItemProperties.ClearMouseOverItem()
	OverheadText.mouseOverId = 0
end

function OverheadText.ShowOverheadText()
	if SystemData.TextSourceID == -1 then
		return
	end

	if not OverheadText.GetsOverhead[SystemData.TextChannelID] then
		return
	end
	
	if wstring.find(SystemData.Text, L"Care to hear how to earn some easy gold?") or
	   wstring.find(SystemData.Text, L"I have an opportunity for you to make some gold!") or
	   wstring.find(SystemData.Text, L"I have an offer for you.")
	then
		return
	end
	
	OverheadText.PrintOverheadText(SystemData.TextSourceID, SystemData.TextChannelID, SystemData.Text, SystemData.TextColor)
end

function OverheadText.PrintOverheadText(source, channel, text, color)
	
	local windowName = "OverheadTextWindow_"..source	
	local overheadChatWindow = windowName.."Chat1"
	
	if OverheadText.ChatData[source] == nil then
	    if( DoesWindowNameExist(windowName) == false ) then
			-- Cases where this would hit are for either the player or non-mobile object
			SystemData.DynamicWindowId = source
			CreateWindowFromTemplate(windowName, "OverheadTextWindow", "Root")
			AttachWindowToWorldObject( source, windowName )
			OverheadText.ChatData[source].showName = false
			OverheadText.HideName(source)
		end
	end
	
	-- if there are other chats move them all up one
	if( OverheadText.ChatData[source].numVisibleChat > 0 ) then
		for i=OverheadText.ChatData[source].numVisibleChat+1, 2, -1 do 
			if( i <= 3 ) then
				local oldWindow = windowName.."Chat"..(i-1)
				local newWindow = windowName.."Chat"..i
				
				local text = LabelGetText(oldWindow)
				local r,g,b = LabelGetTextColor(oldWindow)
				LabelSetText(newWindow,text)
				LabelSetTextColor(newWindow,r,g,b)
				WindowSetShowing(newWindow,true)
				OverheadText.ChatData[source].timePassed[i] = OverheadText.ChatData[source].timePassed[i-1]
			end
		end
	end
	if( OverheadText.ChatData[source].numVisibleChat < 3 ) then
		OverheadText.ChatData[source].numVisibleChat = OverheadText.ChatData[source].numVisibleChat + 1
	end
		
	OverheadText.ChatData[source].timePassed[1] = 0

	local hueR,hueG,hueB = HueRGBAValue(color)
	if color == 0 and ChatSettings ~= nil then 
		local c = ChatSettings.ChannelColors[channel]
		hueR, hueG, hueB = c.r, c.g, c.b
	end
	
	LabelSetTextColor( overheadChatWindow, hueR, hueG, hueB )
	LabelSetText( overheadChatWindow, text)
	
	if( WindowGetShowing(overheadChatWindow) == false ) then
		OverheadText.UpdateOverheadAnchors(source)
		WindowSetShowing(overheadChatWindow, true)
	end
end

function OverheadText.OnOverheadChatShutdown()
    local windowName = SystemData.ActiveWindow.name
    local id = WindowGetId(windowName)
    
    OverheadText.ChatData[id] = nil
end