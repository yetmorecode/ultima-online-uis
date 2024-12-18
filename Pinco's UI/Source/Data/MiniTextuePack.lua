----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------
MiniTexturePack ={}

MiniTexturePack.DB = {
[1] = {name =L"Default", texture = "Silver", PaperdollLabelColor={r=0,g=0,b=0}, StatLabelColor={r=0,g=0,b=0}};
[2] = {name =L"Gold", texture = "Golden", PaperdollLabelColor={r=50,g=41,b=5}, StatLabelColor={r=50,g=41,b=5}};
[3] = {name =L"Dermott Copper", texture = "DermottCopper", PaperdollLabelColor={r=50,g=41,b=5}, StatLabelColor={r=50,g=41,b=5}};
[4] = {name =L"Decors Gray", texture = "DecorsGray", PaperdollLabelColor={r=0,g=0,b=0}, StatLabelColor={r=0,g=0,b=0}};
[5] = {name =L"Pink", texture = "Pink", PaperdollLabelColor={r=0,g=0,b=0}, StatLabelColor={r=0,g=0,b=0}};
[6] = {name =L"Nox Green", texture = "NoxGreen", PaperdollLabelColor={r=0,g=0,b=0}, StatLabelColor={r=0,g=0,b=0}};
[7] = {name =L"Night Blue", texture = "NightBlue", PaperdollLabelColor={r=0,g=0,b=0}, StatLabelColor={r=255,g=255,b=255}};
[8] = {name =L"Blood Red", texture = "BloodRed", PaperdollLabelColor={r=0,g=0,b=0}, StatLabelColor={r=0,g=0,b=0}};
[9] = {name =L"Nalif UO Parchment", texture = "NalifParchment", PaperdollLabelColor={r=50,g=41,b=5}, StatLabelColor={r=50,g=41,b=5}};
[10] = {name =L"Undead", texture = "Undead", PaperdollLabelColor={r=0,g=0,b=0}, StatLabelColor={r=0,g=0,b=0}};
[11] = {name =L"Parchment", texture = "Parchment", PaperdollLabelColor={r=50,g=41,b=5}, StatLabelColor={r=50,g=41,b=5}};
[12] = {name =L"Dermott Dark Stone", texture = "Darkstone", PaperdollLabelColor={r=208,g=168,b=48}, StatLabelColor={r=208,g=168,b=48}};
[13] = {name =L"Dermott Leather", texture = "Leather", PaperdollLabelColor={r=50,g=41,b=5}, StatLabelColor={r=255,g=255,b=255}};
[14] = {name =L"Dermott Wood", texture = "Wood", PaperdollLabelColor={r=222,g=182,b=63}, StatLabelColor={r=0,g=0,b=0}};
[15] = {name =L"Dermott TD", texture = "TD", PaperdollLabelColor={r=208,g=168,b=48}, StatLabelColor={r=0,g=0,b=0}};
[16] = {name =L"Dermott Stone", texture = "Stone", PaperdollLabelColor={r=208,g=168,b=48}, StatLabelColor={r=208,g=168,b=48}};
[17] = {name =L"Old EC Default", texture = "OldUI", PaperdollLabelColor={r=50,g=41,b=5}, StatLabelColor={r=50,g=41,b=5}};
[18] = {name =L"Bright Green", texture = "BrightGreen", PaperdollLabelColor={r=50,g=41,b=5}, StatLabelColor={r=50,g=41,b=5}};
[19] = {name =L"Black", texture = "Black", PaperdollLabelColor={r=255,g=255,b=255}, StatLabelColor={r=255,g=255,b=255}};
[20] = {name =L"Glass", texture = "Glass", PaperdollLabelColor={r=0,g=0,b=0}, StatLabelColor={r=0,g=0,b=0}};
[21] = {name =L"Crystal", texture = "Crystal", PaperdollLabelColor={r=0,g=0,b=0}, StatLabelColor={r=0,g=0,b=0}};
}

MiniTexturePack.Overlays ={
[1] = 	{name = L"Button Frame 1", 	texture="Button_Frame_01" };
[2] = 	{name = L"Button Frame 2", 	texture="Button_Frame_02" };
[3] = 	{name = L"Button Frame 3", 	texture="Button_Frame_03" };
[4] = 	{name = L"Button Frame 4", 	texture="Button_Frame_04" };
[5] = 	{name = L"Button Frame 5", 	texture="Button_Frame_05" };
[6] = 	{name = L"Button Frame 6", 	texture="Button_Frame_06" };
[7] = 	{name = L"Button Frame 7", 	texture="Button_Frame_07" };
[8] = 	{name = L"Button Frame 8", 	texture="Button_Frame_08" };
[9] = 	{name = L"Button Frame 9", 	texture="Button_Frame_09" };
[10] =	{name = L"Button Frame 10",	texture="Button_Frame_10" };
}


function MiniTexturePack.SetTexturePack(id)

	-- is the ID correct?
	if not MiniTexturePack.DB[id] then
		return
	end

	-- save the texture ID
	Interface.Settings.MTP_Current = id
	Interface.SaveSetting( "MTP_Current", Interface.Settings.MTP_Current )
	
	-- update the hotbars
	HotbarSystem.UpdateHotbars()
	
	-- update the paperdoll
	PaperdollWindow.SwitchLabelTexture()

	-- update the actions
	ActionsWindow.UpdateIcons()

	-- update the skills
	SkillsWindow.ShowTab(SkillsWindow.CurrentTab)
end

function MiniTexturePack.SetTexturePackBorder(id)

	-- is the ID correct?
	if not MiniTexturePack.Overlays[id] then
		return
	end

	-- save the texture ID
	Interface.Settings.MTP_CurrentBorder = id
	Interface.SaveSetting( "MTP_CurrentBorder", Interface.Settings.MTP_CurrentBorder )
	
	-- update the hotbars
	HotbarSystem.UpdateHotbars()

	-- does the macro window exist?
	if DoesWindowExist("ActionEditMacro") and ActionEditWindow.CurEditItem then
		
		-- update macro edit window
		MacroEditWindow.UpdateMacroActionList("ActionEditMacro", SystemData.MacroSystem.STATIC_MACRO_ID, ActionEditWindow.CurEditItem.itemIndex)
	end
end