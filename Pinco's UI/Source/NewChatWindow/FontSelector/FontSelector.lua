----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

FontSelector = {}

local function Font( iname, iid, idefault, ishownName )
    local newChannel = 
    {
        fontName         = iname,
        id           = iid,
        isDefault    = idefault,
        shownName    = ishownName,
    };

    return newChannel;
end

FontSelector.Selection = ""

FontSelector.RunicFontItem = ""

 FontSelector.Fonts = {}
    --                               name of font     id  default  name to be shown
	FontSelector.Fonts[1] = Font( "Gothic_Shadow", 1, true, "Default (Unicode)" )
	FontSelector.Fonts[2] = Font( "MyriadPro", 1, false, "MyriadPro (Unicode)" )
	FontSelector.Fonts[3] = Font( "aqua", 1, false, "Aqua (Unicode)" )
	FontSelector.Fonts[4] = Font( "Arial_Black_Shadow", 1, false, "Arial (Unicode)" )
	FontSelector.Fonts[5] = Font( "UMEGothic", 1, false, "UME Gothic (Unicode)" )
	FontSelector.Fonts[6] = Font( "UO_NeueText", 1, false, "Neue Text" )
	FontSelector.Fonts[7] = Font( "avatar", 1, false, "Avatar" )
	FontSelector.Fonts[8] = Font( "avatar_bold", 1, false, "Avatar Bold" )
	FontSelector.Fonts[9] = Font( "chiller", 1, false, "Chiller" )
	FontSelector.Fonts[10] = Font( "comics", 1, false, "Comic Sans" )
	FontSelector.Fonts[11] = Font( "comics_bold", 1, false, "Comic Sans Bold" )
	FontSelector.Fonts[12] = Font( "diablo", 1, false, "Diablo" )
	FontSelector.Fonts[13] = Font( "gothic", 1, false, "Gothic Ultra Trendy" )
	FontSelector.Fonts[14] = Font( "handwriting", 1, false, "Handwriting" )
	FontSelector.Fonts[15] = Font( "magic_school", 1, false, "Magic School" )
	FontSelector.Fonts[16] = Font( "magic", 1, false, "Magic The Gathering" )
	FontSelector.Fonts[17] = Font( "samurai", 1, false, "Samurai" )
	FontSelector.Fonts[18] = Font( "times", 1, false, "Times New Roman" )
	FontSelector.Fonts[19]= Font( "times_bold", 1, false, "Times New Roman Bold" )
	FontSelector.Fonts[20]= Font( "UO", 1, false, "Ultima Online Classic" )
	FontSelector.Fonts[21] = Font( "murder", 1, false, "You Murder" )
	FontSelector.Fonts[22] = Font( "OmniaLt_Shadow", 1, false, "Omnia LT Std" )
	FontSelector.Fonts[23] = Font( "Albertus_Shadow", 1, false, "Albertus" )
	
	FontSelector.Fonts[24] = Font( "Runic", 1, false, "Runic Font" )
	FontSelector.Fonts[25] = Font( "gargrunic", 1, false, "Gargish" )

-- OnInitialize Handler
function FontSelector.Initialize()

    
    --WindowSetScale("FontSelector", 1.28)
    Interface.DestroyWindowOnClose["FontSelector"] = true
        
    local size = #FontSelector.Fonts
    for idx=1, size do

		local itemWindow = "FontSelectorItem"..idx
		if DoesWindowExist( itemWindow) then
			DestroyWindow(itemWindow)
		end
		CreateWindowFromTemplate (itemWindow, "FontRowTemplate", "FontSelectorSWText")
		LabelSetFont( itemWindow.."Label", FontSelector.Fonts[idx].fontName .. "_20", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING )
		LabelSetText( itemWindow.."Label", towstring(FontSelector.Fonts[idx].shownName) )
		local x, y = WindowGetDimensions(itemWindow.."Label")

		WindowSetDimensions(itemWindow, x, y)
		WindowSetId(itemWindow, idx)
		WindowClearAnchors(itemWindow)
		
		WindowSetShowing(itemWindow.."Check", false)
		
		local attachIndex = idx -1
	    	    
	    if (attachIndex<=0) then
			attachIndex = 1
	    end
	    
		if (idx == 1) then
			WindowAddAnchor( itemWindow, "topleft", "FontSelectorSWText", "topleft", 0, 0 )
		else
			WindowAddAnchor( itemWindow, "bottomleft", "FontSelectorItem"..attachIndex, "topleft", 0, 7 )			
		end
    
   end
end

function FontSelector.OnShown()
	local selectedIdx = 1
    if (FontSelector.Selection == "chat") then
		selectedIdx = OverheadText.FontIndex 
	elseif (FontSelector.Selection == "names") then
		selectedIdx = OverheadText.NameFontIndex
	elseif (FontSelector.Selection == "spells") then
		selectedIdx = OverheadText.SpellsFontIndex 
	elseif (FontSelector.Selection == "damage") then
		selectedIdx = OverheadText.DamageFontIndex
	elseif (string.find(FontSelector.Selection, "journal", 1, true)) then
		local id = string.gsub(FontSelector.Selection, "journal", "")
		id = tonumber(id)
		selectedIdx = NewChatWindow.ChannelsFonts[ id ]
	end

	local size = #FontSelector.Fonts
    for idx=1, size do
		local itemWindow = "FontSelectorItem"..idx
		if (selectedIdx == idx) then
			WindowSetShowing(itemWindow.."Check", true)
			WindowClearAnchors(itemWindow.."Check")
			WindowForceProcessAnchors(itemWindow.."Check")
			WindowAddAnchor( itemWindow.."Check", "left", itemWindow.."Label", "center", -17, 5 )
		else
			WindowSetShowing(itemWindow.."Check", false)
		end
	end	
	ScrollWindowUpdateScrollRect( "FontSelectorSW" )   	
    ScrollWindowSetOffset("FontSelectorSW",0)
end

function FontSelector.Shutdown()
    
end

function FontSelector.SetFontToSelection()

	if (FontSelector.Selection == "chat") then
		OverheadText.FontIndex = WindowGetId(SystemData.ActiveWindow.name)
		Interface.SaveSetting("OverheadTextFontIndex", OverheadText.FontIndex)
		WindowSetShowing("FontSelector", false)
	elseif (FontSelector.Selection == "names") then
		OverheadText.NameFontIndex = WindowGetId(SystemData.ActiveWindow.name)
		Interface.SaveSetting("OverheadTextNameFontIndex", OverheadText.NameFontIndex)
		WindowSetShowing("FontSelector", false)
	elseif (FontSelector.Selection == "spells") then
		OverheadText.SpellsFontIndex = WindowGetId(SystemData.ActiveWindow.name)
		Interface.SaveSetting("OverheadTextSpellsFontIndex", OverheadText.SpellsFontIndex)
		WindowSetShowing("FontSelector", false)
	elseif (FontSelector.Selection == "damage") then
		OverheadText.DamageFontIndex = WindowGetId(SystemData.ActiveWindow.name)
		Interface.SaveSetting("OverheadTextDamageFontIndex", OverheadText.DamageFontIndex)
		WindowSetShowing("FontSelector", false)
	elseif (string.find(FontSelector.Selection, "journal", 1, true)) then
		local id = string.gsub(FontSelector.Selection, "journal", "")
		id = tonumber(id)
		
		NewChatWindow.ChannelsFonts[ id ] = WindowGetId(SystemData.ActiveWindow.name)
		Interface.SaveSetting("ChannelsFonts" .. id, NewChatWindow.ChannelsFonts[ id ])
		NewChatWindow.ClearAll()
		NewChatWindow.UpdateLog()
		WindowSetShowing("FontSelector", false)
	end
end

function FontSelector.CloseFontWindow()
	WindowSetShowing("FontSelector", false)
end

function FontSelector.ItemMouseOver()
	local fontIndex = WindowGetId(SystemData.ActiveWindow.name)
	local itemWindow = "FontSelectorItem"..fontIndex
	
	LabelSetTextColor(itemWindow.."Label",243,227,49)
end

function FontSelector.ClearMouseOverItem()
	local fontIndex = WindowGetId(SystemData.ActiveWindow.name)
	local itemWindow = "FontSelectorItem"..fontIndex
	
	LabelSetTextColor(itemWindow.."Label",255,255,255)
end

function FontSelector.Scrolling(pos)
	WindowForceProcessAnchors("FontSelectorSW")
end