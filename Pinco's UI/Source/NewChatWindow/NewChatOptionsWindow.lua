----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

NewChatOptionsWindow = {}

NewChatOptionsWindow.HasTitle = false

NewChatOptionsWindow.TID = { Accept=1013076,CustomColor=1111675,Red=1018351,Green=1079391,Blue=1111676,
                          TextColorHelp=1111677,TextColors=1111678,}

NewChatOptionsWindow.channelListData = {}
NewChatOptionsWindow.channelListOrder = {}

NewChatOptionsWindow.SelectedMessageTypeIndex = 0
NewChatOptionsWindow.SelectedMessageTypeWindowIndex = 0

 NewChatOptionsWindow.Colors = {
        --{r=235, g=235, b=235, id=1},
        {r=32, g=134, b=229, id=2},
        {r=29, g=217, b=33, id=3},
        {r=178, g=255, b=116, id=4},
        {r=239, g=221, b=19, id=5},
        {r=190, g=190, b=190, id=6},
        {r=255, g=255, b=1, id=7},
        {r=144, g=237, b=250, id=8},
        {r=238, g=113, b=21, id=9},
        {r=18, g=202, b=209, id=10},
        {r=231, g=189, b=115, id=11},
        {r=55, g=65, b=248, id=12},
        {r=32, g=224, b=32, id=13},
        {r=251, g=236, b=3, id=14},
        {r=217, g=28, b=28, id=15},
        {r=238, g=113, b=21, id=16},
        {r=235, g=213, b=135, id=17},
        {r=255, g=39, b=39, id=18},
        {r=255, g=168, b=5, id=19},
        {r=195, g=54, b=150, id=20},
        {r=1, g=167, b=167, id=21},
        {r=55, g=65, b=248, id=22},
        {r=110, g=110, b=110, id=23},
        {r=239, g=221, b=19, id=24},
        {r=1, g=167, b=165, id=25},
    }  

NewChatOptionsWindow.channelListCurrentStatus = {}
local wndIndex = 0
local channelChanging = false
local function InitChatOptionListData()
    NewChatOptionsWindow.channelListData = {}
    local channelIndex = 0
    for channel, channelData in pairs(ChatSettings.Channels) do
        if (channelData ~= nil and channelData.name ~= nil) then
            channelIndex = channelIndex + 1
            NewChatOptionsWindow.channelListData[channelIndex] = {
                    channelName = channelData.name,
                    color = NewChatWindow.ChannelColors[channel],
                    logName = channelData.logName,
                    channelID = channelData.id,
                }
            
            NewChatOptionsWindow.channelListCurrentStatus[channelIndex] = {
                hasChanged = false,
            }
            
        end
    end
     local hueR,hueG,hueB = HueRGBAValue(SystemData.Settings.Interface.SpeechHue)
    NewChatOptionsWindow.channelListData[NewChatOptionsWindow.SpeechHueIndex] = {
                    channelName = L"Your Speech",
                    color = {r=hueR,g=hueG,b=hueB},
                    logName = nil,
                    channelID = nil,
    }
    NewChatOptionsWindow.channelListCurrentStatus[NewChatOptionsWindow.SpeechHueIndex] = {
        hasChanged = false,
    }  
    
    local channelData = ChatSettings.Channels[SystemData.ChatLogFilters.GM]
    NewChatOptionsWindow.channelListData[13] = {
                    channelName = channelData.name,
                    color = NewChatWindow.ChannelColors[SystemData.ChatLogFilters.GM],
                    logName = channelData.logName,
                    channelID = SystemData.ChatLogFilters.GM,
                }
            
            NewChatOptionsWindow.channelListCurrentStatus[13] = {
                hasChanged = false,
            }
            
         
                 
end

local function CompareColors( colorTable1, colorTable2 )
    if (colorTable1 == nil or colorTable2 == nil)
    then
        return
    end
    if (colorTable1.r == colorTable2.r and colorTable1.g == colorTable2.g and colorTable1.b == colorTable2.b)
    then
        return true
    else
        return false
    end
end

 
 
function NewChatOptionsWindow.SetupChannelColorDefaults( resetAll )

    if (resetAll) then
        NewChatWindow.ChannelColors = {}
    end

    for key, value in pairs( ChatSettings.Channels ) do
        if (resetAll or NewChatWindow.ChannelColors[ key ] == nil) then
			local col = Interface.LoadSetting( "ChannelsColors" .. key, nil, {r=0,g=0,b=0})

			if not col then
				col = value.defaultColor
			end
            NewChatWindow.ChannelColors[ key ] = col
            ChatSettings.ChannelColors[ key ] = col
        end
    end

end

local function FilterChannelList()

    NewChatOptionsWindow.channelListOrder = {}
    wndIndex = ChatWindow.activeWindow
    local r,g,b
    local dataIndex = 0
    for idx = 1,  #ChatSettings.Channels do
		local info = ChatSettings.Channels[idx]
       dataIndex = dataIndex + 1
                table.insert(NewChatOptionsWindow.channelListOrder, dataIndex)
                NewChatOptionsWindow.channelListData[dataIndex].color.r = NewChatWindow.ChannelColors[info.id].r
                NewChatOptionsWindow.channelListData[dataIndex].color.g = NewChatWindow.ChannelColors[info.id].g
                NewChatOptionsWindow.channelListData[dataIndex].color.b = NewChatWindow.ChannelColors[info.id].b
                
                if (idx < ChatFiltersWindowList.numVisibleRows)
                then
                    -- Only fill the table with the number of labels actually visible
                    labelName = "NewChatOptionsWindowListRow"..idx.."ChannelName"
                    LabelSetTextColor(labelName, 
                              NewChatOptionsWindow.channelListData[dataIndex].color.r, 
                              NewChatOptionsWindow.channelListData[dataIndex].color.g,
                              NewChatOptionsWindow.channelListData[dataIndex].color.b)
                end
                

    end
         -- do the special case for your speech
    table.insert(NewChatOptionsWindow.channelListOrder, NewChatOptionsWindow.SpeechHueIndex)
    labelName = "NewChatOptionsWindowListRow"..NewChatOptionsWindow.SpeechHueIndex.."ChannelName"
    local hueR,hueG,hueB = HueRGBAValue(SystemData.Settings.Interface.SpeechHue)
    LabelSetTextColor(labelName, 
              hueR, 
              hueG,
              hueB) 
              

    local info =ChatSettings.Channels[SystemData.ChatLogFilters.GM]
    table.insert(NewChatOptionsWindow.channelListOrder, 13)
    NewChatOptionsWindow.channelListData[13].color.r = NewChatWindow.ChannelColors[info.id].r
    NewChatOptionsWindow.channelListData[13].color.g = NewChatWindow.ChannelColors[info.id].g
    NewChatOptionsWindow.channelListData[13].color.b = NewChatWindow.ChannelColors[info.id].b

    -- Only fill the table with the number of labels actually visible
    labelName = "NewChatOptionsWindowListRow13ChannelName"
    LabelSetTextColor(labelName, 
		NewChatOptionsWindow.channelListData[13].color.r, 
		NewChatOptionsWindow.channelListData[13].color.g,
		NewChatOptionsWindow.channelListData[13].color.b)

    
      
end

local function ResetChannelList()
    -- Filter, Sort, and Update
    InitChatOptionListData()
    FilterChannelList()
    ListBoxSetDisplayOrder( "NewChatOptionsWindowList", NewChatOptionsWindow.channelListOrder )
    
    -- Reset variables
    NewChatOptionsWindow.SelectedMessageTypeIndex = 0
    NewChatOptionsWindow.SelectedMessageTypeWindowIndex = 0
end

-- OnInitialize Handler
function NewChatOptionsWindow.Initialize()
    LabelSetText( "NewChatOptionsWindowCustomColorText", GetStringFromTid(NewChatOptionsWindow.TID.CustomColor) )
    LabelSetText( "NewChatOptionsWindowCustomColorRedText", GetStringFromTid(NewChatOptionsWindow.TID.Red) )
    LabelSetText( "NewChatOptionsWindowCustomColorGreenText", GetStringFromTid(NewChatOptionsWindow.TID.Green) )
    LabelSetText( "NewChatOptionsWindowCustomColorBlueText", GetStringFromTid(NewChatOptionsWindow.TID.Blue) )
    LabelSetText( "NewChatOptionsWindowHelpHeaderText", GetStringFromTid(NewChatOptionsWindow.TID.TextColorHelp) )
    ButtonSetText( "NewChatOptionsWindowAcceptButton", GetStringFromTid(NewChatOptionsWindow.TID.Accept) ) 
    WindowSetShowing("NewChatOptionsWindowColorSelectionRing", false)
    WindowSetShowing("NewChatOptionsWindowChannelSelection", false)
    ColorPickerCreateWithColorTable("NewChatOptionsWindowColorPicker", NewChatOptionsWindow.Colors, 4, 10, 10)
    NewChatOptionsWindow.SelectedMessageTypeIndex = 0
    NewChatOptionsWindow.SelectedMessageTypeWindowIndex = 0
    
    NewChatOptionsWindow.SpeechHueIndex = 12
    
    if (not NewChatOptionsWindow.HasTitle) then
		WindowUtils.SetWindowTitle("NewChatOptionsWindow", GetStringFromTid(NewChatOptionsWindow.TID.TextColors) )
		NewChatOptionsWindow.HasTitle = true
	end
	
    WindowSetShowing( "NewChatOptionsWindow", false )
end

function NewChatOptionsWindow.Shutdown()
	WindowSetShowing( "NewChatOptionsWindow", false )
end

function NewChatOptionsWindow.Hide()
    WindowSetShowing("NewChatOptionsWindowColorSelectionRing", false)
    WindowSetShowing("NewChatOptionsWindowChannelSelection", false)
    WindowSetShowing( "NewChatOptionsWindow", false )
  
end
function NewChatOptionsWindow.ClearSelectionImage()
    WindowSetShowing("NewChatOptionsWindowChannelSelection", false)
end
function NewChatOptionsWindow.OnShown()
    ResetChannelList()
    NewChatOptionsWindow.UpdateChatOptionRow()
    
end

function NewChatOptionsWindow.OnHidden()
end

-- Callback from the <List> that updates a single row.
function NewChatOptionsWindow.UpdateChatOptionRow()
    if (NewChatOptionsWindowList.PopulatorIndices ~= nil) then
        local active = false
        local labelName
        local tab = ChatWindow.GetMenuTab()
        for rowIndex = 1, #NewChatOptionsWindowList.PopulatorIndices do
			local dataIndex = NewChatOptionsWindowList.PopulatorIndices[rowIndex]
			local r = 0
			local g = 0
			local b = 0
			labelName = "NewChatOptionsWindowListRow"..rowIndex.."ChannelName"
			if (rowIndex == NewChatOptionsWindow.SpeechHueIndex) then
				r,g,b = HueRGBAValue(SystemData.Settings.Interface.SpeechHue)
			elseif (NewChatOptionsWindow.channelListData[dataIndex].channelID) then
				r =	NewChatWindow.ChannelColors[NewChatOptionsWindow.channelListData[dataIndex].channelID].r
				g =	NewChatWindow.ChannelColors[NewChatOptionsWindow.channelListData[dataIndex].channelID].g
				b =	NewChatWindow.ChannelColors[NewChatOptionsWindow.channelListData[dataIndex].channelID].b
			end

			LabelSetTextColor(labelName, 
				  r, 
				  g,
				  b)
        end
    end
end

function NewChatOptionsWindow.OnLButtonUpChannelLabel()

    local windowIndex = WindowGetId (SystemData.ActiveWindow.name)
    local windowParent = WindowGetParent (SystemData.ActiveWindow.name)
    local dataIndex = ListBoxGetDataIndex (WindowGetParent (windowParent), windowIndex)

    local targetRowWindow = "NewChatOptionsWindowListRow"..windowIndex
    
    if (NewChatOptionsWindow.SelectedMessageTypeWindowIndex ~= windowIndex) then
        NewChatOptionsWindow.SelectedMessageTypeWindowIndex = windowIndex
        NewChatOptionsWindow.SelectedMessageTypeIndex = dataIndex
        WindowSetShowing("NewChatOptionsWindowChannelSelection", true)
        WindowClearAnchors("NewChatOptionsWindowChannelSelection")
        WindowAddAnchor( "NewChatOptionsWindowChannelSelection", "topleft", "NewChatOptionsWindowListRow"..windowIndex, "topleft", -5, 2 )
        WindowAddAnchor( "NewChatOptionsWindowChannelSelection", "bottomright", "NewChatOptionsWindowListRow"..windowIndex, "bottomright", -20, 0 )
    end
    
    local x, y = ColorPickerGetCoordinatesForColor("NewChatOptionsWindowColorPicker", NewChatOptionsWindow.channelListData[dataIndex].color.r,
                                                                                   NewChatOptionsWindow.channelListData[dataIndex].color.g,
                                                                                   NewChatOptionsWindow.channelListData[dataIndex].color.b)
    
    if (x ~= nil and y ~= nil)
    then
        WindowSetShowing("NewChatOptionsWindowColorSelectionRing", true)
        WindowClearAnchors("NewChatOptionsWindowColorSelectionRing")
        WindowAddAnchor( "NewChatOptionsWindowColorSelectionRing", "topleft", "NewChatOptionsWindowColorPicker", "topleft", x-5, y-5 ) 
    else
        WindowSetShowing("NewChatOptionsWindowColorSelectionRing", false)
    end
    
    -- Set the sliders
    local color = NewChatOptionsWindow.channelListData[dataIndex].color
    channelChanging = true
    local colorRatio = color.r / 255
    SliderBarSetCurrentPosition("NewChatOptionsWindowCustomColorRedSlider", colorRatio )
    colorRatio = color.g / 255
    SliderBarSetCurrentPosition("NewChatOptionsWindowCustomColorGreenSlider", colorRatio )
    colorRatio = color.b / 255
    SliderBarSetCurrentPosition("NewChatOptionsWindowCustomColorBlueSlider", colorRatio )
    -- We've completed the slider updates, it is now safe for the user to make their custom color.
    channelChanging = false
    
    WindowSetTintColor("NewChatOptionsWindowCustomColorSwatch", NewChatOptionsWindow.channelListData[dataIndex].color.r,
                                                       NewChatOptionsWindow.channelListData[dataIndex].color.g,
                                                       NewChatOptionsWindow.channelListData[dataIndex].color.b)
    
    
    
end

function NewChatOptionsWindow.OnLButtonUpColorPicker( flags, x, y )
    if (NewChatOptionsWindow.SelectedMessageTypeIndex == nil or NewChatOptionsWindow.SelectedMessageTypeIndex == 0)
    then
        -- No chosen filter, please exit
        return true
    end
    local color = ColorPickerGetColorAtPoint( "NewChatOptionsWindowColorPicker", x, y )
    local dataIndex = NewChatOptionsWindow.SelectedMessageTypeIndex
    local currentColor = NewChatOptionsWindow.channelListData[dataIndex].color
    local colorRatio = 0
    -- We have a valid color
    if (color ~= nil)
    then
        LabelSetTextColor("NewChatOptionsWindowListRow"..NewChatOptionsWindow.SelectedMessageTypeWindowIndex.."ChannelName", 
                          color.r, 
                          color.g,
                          color.b)
        -- Set the sliders
        colorRatio = color.r / 255
        SliderBarSetCurrentPosition("NewChatOptionsWindowCustomColorRedSlider", colorRatio )
        colorRatio = color.g / 255
        SliderBarSetCurrentPosition("NewChatOptionsWindowCustomColorGreenSlider", colorRatio )
        colorRatio = color.b / 255
        SliderBarSetCurrentPosition("NewChatOptionsWindowCustomColorBlueSlider", colorRatio )
        
        WindowSetTintColor("NewChatOptionsWindowCustomColorSwatch", color.r,
                                                   color.g,
                                                   color.b)
        -- Update the position of the color ring
        WindowSetShowing("NewChatOptionsWindowColorSelectionRing", true)
        WindowClearAnchors("NewChatOptionsWindowColorSelectionRing")
        WindowAddAnchor( "NewChatOptionsWindowColorSelectionRing", "topleft", "NewChatOptionsWindowColorPicker", "topleft", color.x-5, color.y-5 )
        
        -- Update the color, and the save flag
        NewChatOptionsWindow.channelListData[NewChatOptionsWindow.SelectedMessageTypeIndex].color.r = color.r
        NewChatOptionsWindow.channelListData[NewChatOptionsWindow.SelectedMessageTypeIndex].color.g = color.g
        NewChatOptionsWindow.channelListData[NewChatOptionsWindow.SelectedMessageTypeIndex].color.b = color.b
        NewChatOptionsWindow.channelListCurrentStatus[NewChatOptionsWindow.SelectedMessageTypeIndex].hasChanged = true
    end
end

function NewChatOptionsWindow.OnSetCustomColor()
    
    if (NewChatOptionsWindow.SelectedMessageTypeIndex == nil or NewChatOptionsWindow.SelectedMessageTypeIndex == 0)
    then
        -- No channel picked
        return
    end
    local colorRatio = 0
    local color = {
        r = 0,
        b = 0,
        g = 0,
    }
    colorRatio = SliderBarGetCurrentPosition("NewChatOptionsWindowCustomColorRedSlider")
    color.r = colorRatio * 255
    colorRatio = SliderBarGetCurrentPosition("NewChatOptionsWindowCustomColorGreenSlider")
    color.g = colorRatio * 255
    colorRatio = SliderBarGetCurrentPosition("NewChatOptionsWindowCustomColorBlueSlider")
    color.b = colorRatio * 255
    
    -- Update the color swatch
    WindowSetTintColor("NewChatOptionsWindowCustomColorSwatch", color.r,
                                                       color.g,
                                                       color.b)
                                                       
    if (channelChanging == false)
    then
        LabelSetTextColor("NewChatOptionsWindowListRow"..NewChatOptionsWindow.SelectedMessageTypeWindowIndex.."ChannelName", 
                                  color.r, 
                                  color.g,
                                  color.b)
        -- Update the color, and the save flag
        NewChatOptionsWindow.channelListData[NewChatOptionsWindow.SelectedMessageTypeIndex].color.r = color.r
        NewChatOptionsWindow.channelListData[NewChatOptionsWindow.SelectedMessageTypeIndex].color.g = color.g
        NewChatOptionsWindow.channelListData[NewChatOptionsWindow.SelectedMessageTypeIndex].color.b = color.b
        NewChatOptionsWindow.channelListCurrentStatus[NewChatOptionsWindow.SelectedMessageTypeIndex].hasChanged = true
    end
end

function NewChatOptionsWindow.SetAllColorChanges()
    for idx=1, #NewChatOptionsWindow.channelListCurrentStatus do
        if (NewChatOptionsWindow.channelListCurrentStatus[idx].hasChanged == true)
        then
            -- Set the new color, and Reset the flag
            NewChatOptionsWindow.SetChannelColor(idx)
            NewChatOptionsWindow.channelListCurrentStatus[idx].hasChanged = false
        end
    end
    -- Update the channel Selection window with the new colors
    ChatWindow.UpdateAllChannelColors()
    -- Hide all components
    WindowSetShowing("NewChatOptionsWindowColorSelectionRing", false)
    WindowSetShowing("NewChatOptionsWindowChannelSelection", false)
    WindowSetShowing("NewChatOptionsWindow", false)
    NewChatWindow.ClearAll()
	NewChatWindow.UpdateLog()
end

function NewChatOptionsWindow.SetChannelColor( channelIndex )
    local newColor = NewChatOptionsWindow.channelListData[ channelIndex ].color
	if (channelIndex == NewChatOptionsWindow.SpeechHueIndex) then
		SystemData.Settings.Interface.SpeechHue = GetHueFromRGB(newColor.r, newColor.g, newColor.b)
		-- push the new values to c++
		UserSettingsChanged()
	else
		local channelId = NewChatOptionsWindow.channelListData[ channelIndex ].channelID
		NewChatWindow.ChannelColors[ channelId ] = newColor
		Interface.SaveSetting("ChannelsColors" .. channelId, NewChatWindow.ChannelColors[ channelId ])
		
		-- Loop through all the tabs and change the chat channel color for it.
		for idxW, wnd in pairs(ChatWindow.Windows) do
			for idxT, tab in pairs(wnd.Tabs) do
				LogDisplaySetFilterColor(tab.tabWindow,
										 NewChatOptionsWindow.channelListData[channelIndex].logName,
										 channelId, 
										 newColor.r, newColor.g, newColor.b ) 
			end
		end
	end
end
