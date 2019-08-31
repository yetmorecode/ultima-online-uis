----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

DamageWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------
DamageWindow.AttachedId = {}
--Used to shift the Y position to the max before it disappears off the screen
DamageWindow.OverheadAlive = -150
DamageWindow.OverheadMove = 4
DamageWindow.FadeStart = -10
DamageWindow.FadeDiff = 0.01
DamageWindow.DefaultAnchorY = 40
DamageWindow.ShiftYAmount = 15
DamageWindow.MaxAnchorYOverlap = 15
DamageWindow.AnchorY = {}

DamageWindow.DamageArray = {}
DamageWindow.DamageArrayPurgeTime = 600
DamageWindow.LastDamaged = 0
DamageWindow.waitSpecialDamage = nil
DamageWindow.lastSpecialWaiting = nil
 
----------------------------------------------------------------
-- DamageWindow Functions
----------------------------------------------------------------
function DamageWindow.Initialize()
	WindowRegisterEventHandler("Root", SystemData.Events.DAMAGE_NUMBER_INIT, "DamageWindow.Init")
end

--Creates a new window for the mobile Id and set the label text of the damage amount
function DamageWindow.Init()
	if DamageWindow.waitSpecialDamage then
		DamageWindow.AddText(Damage.mobileId, DamageWindow.waitSpecialDamage)
		DamageWindow.waitSpecialDamage = nil
		DamageWindow.lastSpecialWaiting = nil
	end
	local numWindow = DamageWindow.GetNextId()
	local windowName = "DamageWindow"..numWindow
	local labelName = windowName.."Text"

	if IsObjectIdPet(Damage.mobileId) then
		color = Interface.Settings.PETGETDAMAGE_COLOR
		Interface.OnPetGetDamage(Damage.mobileId, Damage.damageNumber)

	elseif (Damage.mobileId == GetPlayerID()) then
		color = Interface.Settings.YOUGETAMAGE_COLOR	
		Interface.OnPlayerGetDamage(Damage.damageNumber)

	else
		color = Interface.Settings.OTHERGETDAMAGE_COLOR
		Interface.OnPlayerDealDamage(Damage.mobileId, Damage.damageNumber)
		
		DamageWindow.LastDamaged = Damage.mobileId
		if (not DamageWindow.DamageArray[Damage.mobileId]) then
			DamageWindow.DamageArray[Damage.mobileId] = { dmg=0, lastActivity=Interface.Clock.Timestamp + DamageWindow.DamageArrayPurgeTime}
		end
		
		DamageWindow.DamageArray[Damage.mobileId] = { dmg=DamageWindow.DamageArray[Damage.mobileId].dmg + Damage.damageNumber, lastActivity=Interface.Clock.Timestamp + DamageWindow.DamageArrayPurgeTime}

		if (Interface.Settings.chat_minTotDmg > 0 and DamageWindow.DamageArray[Damage.mobileId].dmg >= Interface.Settings.chat_minTotDmg) then
			local mobname = GetMobileName(Damage.mobileId)
			local logVal = {text = L"Takes " .. Damage.damageNumber .. L" damage.\nA total of " .. DamageWindow.DamageArray[Damage.mobileId].dmg .. L" from you." , channel = 17, color = color, sourceId = Damage.mobileId, sourceName = mobname, ignore = false, category = 0, timeStamp = towstring(string.format("%02.f", Interface.Clock.h) .. ":" .. string.format("%02.f", Interface.Clock.m) .. ":" .. string.format("%02.f", Interface.Clock.s))}
			table.insert(NewChatWindow.Messages, logVal)
			table.insert(NewChatWindow.Setting.Messages, logVal)
			if (#NewChatWindow.Setting.Messages > 200) then
				table.remove(NewChatWindow.Setting.Messages, 1)
			end
			NewChatWindow.UpdateLog()
		end
	end
	
	CreateWindowFromTemplateShow(windowName, "DamageWindow", "Root", false)
	WindowSetScale(windowName, Interface.Settings.OverhedTextSize)
	
	AttachWindowToWorldObject(Damage.mobileId, windowName)

	--Shifts the previous damage numbers up if its too close to the new damage numbers
	--this way the damage numbers would not cover each other up
	DamageWindow.ShiftYWindowUp()
	
	--Set the time pass to 0 
	DamageWindow.AttachedId[numWindow] = Damage.mobileId
	DamageWindow.AnchorY[numWindow] = DamageWindow.DefaultAnchorY
	LabelSetText(labelName, L""..Damage.damageNumber)
	LabelSetFont(labelName, FontSelector.Fonts[OverheadText.DamageFontIndex].fontName .. "_16", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	
	Interface.IsFighting = true
	Interface.IsFightingLastTime = Interface.TimeSinceLogin + 10
	Interface.CanLogout = Interface.TimeSinceLogin + 120

	if (color ~= nil) then
		LabelSetTextColor( labelName, color.r, color.g, color.b )
	else
		LabelSetTextColor(labelName, Damage.red, Damage.green, Damage.blue)
	end

	PaperdollWindow.GotDamage =  true
	WindowAddAnchor(labelName, "bottom", windowName, "bottom", 0, DamageWindow.DefaultAnchorY)
end

function DamageWindow.GetNextId()
	local numWindow = 1
	while DoesWindowExist("DamageWindow"..numWindow) do
		numWindow = numWindow + 1
	end
	return numWindow
end

function DamageWindow.AddText(mobileId, text)
	
	local numWindow = DamageWindow.GetNextId()
	local windowName = "DamageWindow"..numWindow
	local labelName = windowName.."Text"
	CreateWindowFromTemplateShow(windowName, "DamageWindow", "Root", false)
	WindowSetScale(windowName, Interface.Settings.OverhedTextSize)
	
	AttachWindowToWorldObject(mobileId, windowName)

	--Shifts the previous damage numbers up if its too close to the new damage numbers
	--this way the damage numbers would not cover each other up
	DamageWindow.ShiftYWindowUp()
	
	--Set the time pass to 0 
	DamageWindow.AttachedId[numWindow] = mobileId
	DamageWindow.AnchorY[numWindow] = DamageWindow.DefaultAnchorY
	LabelSetText(labelName, text)
	LabelSetFont(labelName, FontSelector.Fonts[OverheadText.DamageFontIndex].fontName .. "_16", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	
	if (mobileId == GetPlayerID()) then
		color = Interface.Settings.YOUGETAMAGE_COLOR	
	else
		color = Interface.Settings.OTHERGETDAMAGE_COLOR
	end

	if (color ~= nil) then
		LabelSetTextColor( labelName, color.r, color.g, color.b )
	else
		LabelSetTextColor(labelName, Damage.red, Damage.green, Damage.blue)
	end

	WindowAddAnchor(labelName, "bottom", windowName, "bottom", 0, DamageWindow.DefaultAnchorY)
end

-- If the previous Damage Number Y anchor too close to the new damage window, increase all the damage numbers y anchors
function DamageWindow.ShiftYWindowUp()
	if DamageWindow.IsOverlap() then
		for i, id in pairs(DamageWindow.AttachedId) do
			DamageWindow.AnchorY[i] = DamageWindow.AnchorY[i] - DamageWindow.ShiftYAmount
			windowName = "DamageWindow"..i
  			labelName = windowName.."Text"
  			WindowClearAnchors(labelName)
  			WindowAddAnchor(labelName, "bottomleft",windowName , "bottomleft", 0, DamageWindow.AnchorY[i])
		end
	end
end

function DamageWindow.IsOverlap()
	for i, id in pairs(DamageWindow.AttachedId) do
		if (DamageWindow.AnchorY[i] >= DamageWindow.MaxAnchorYOverlap) then
  			return true
  		end
  	end
  	return false
end

--The damage number moves up and slowly disappears off the screen
function DamageWindow.UpdateTime(UpdateInterfaceTime)
	local count = 0
	for i, id in pairs(DamageWindow.AttachedId) do
		DamageWindow.AnchorY[i] = DamageWindow.AnchorY[i] - DamageWindow.OverheadMove
	
		if (DamageWindow.AnchorY[i] < DamageWindow.OverheadAlive) then
			--DetachWindowFromWorldObject(id, "DamageWindow"..i)
			DestroyWindow("DamageWindow"..i)
			DamageWindow.AnchorY[i] = 0
			DamageWindow.AttachedId[i] = nil
		else
			local windowName = "DamageWindow"..i
			local labelName = windowName.."Text"
			WindowClearAnchors(labelName)
			WindowAddAnchor(labelName, "bottom", windowName ,"bottom", 0, DamageWindow.AnchorY[i])
		end
		count = count +1
	end

	--If count is zero reset the numWindow to 1
	if (count == 0) then
		Damage.numWindow = 0
	end
end


