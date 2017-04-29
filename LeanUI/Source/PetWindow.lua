----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

PetWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

PetWindow.hasWindow = {}
PetWindow.reverseIndexId = {}
PetWindow.tid = { PET = 1077432}
PetWindow.OffetSize = 42
PetWindow.windowX = 150
PetWindow.windowY = 42
PetWindow.windowOffset = 5
PetWindow.windowCount = 1
PetWindow.totalPets = 0

if SummonTimes == nil then
	SummonTimes = {}
end

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function PetWindow.Initialize()
	RegisterWindowData(WindowData.Pets.Type, 0)	
	WindowRegisterEventHandler( "PetWindow", WindowData.Pets.Event, "PetWindow.UpdatePets")
	WindowRegisterEventHandler( "PetWindow", WindowData.MobileName.Event, "PetWindow.HandleUpdateNameEvent")
	WindowRegisterEventHandler( "PetWindow", WindowData.MobileStatus.Event, "PetWindow.HandleUpdateStatusEvent")
	WindowRegisterEventHandler( "PetWindow", WindowData.HealthBarColor.Event, "PetWindow.HandleTintHealthBarEvent")
	
	WindowUtils.RestoreWindowPosition("PetWindow")
	PetWindow.UpdatePets()
	PetWindow.ShowPet()
	
	
end


function PetWindow.Shutdown()
	local windowName = "PetWindow"
	--local showName = windowName.."ShowView"
	--SnapUtils.SnappableWindows[showName] = nil
	
	for key,value in pairs(PetWindow.hasWindow) do
		PetWindow.ClearHealthBarData(key)
	end
	UnregisterWindowData(WindowData.Pets.Type, 0)	
	WindowUtils.SaveWindowPosition(windowName)
end

function PetWindow.HideAll()
	local windowName = "PetWindow"
	WindowSetShowing(windowName, false)
end

function PetWindow.ShowWindow()
	local windowName = "PetWindow"
	WindowSetShowing(windowName, true)
end

function PetWindow.UpdatePets()
	local petSize = table.getn(WindowData.Pets.PetId)
	local numPet
	PetWindow.totalPets = 0
	for numPet = 1, petSize do
		if(IsMobile(WindowData.Pets.PetId[numPet])) then
			PetWindow.totalPets = PetWindow.totalPets + 1
		end
	end
	
	for key,value in pairs(PetWindow.hasWindow) do
		PetWindow.ClearHealthBarData(key)
	end
	
	if(PetWindow.totalPets == 0) then
		PetWindow.HideAll()
		return
	else
		PetWindow.ShowWindow()
	end

	if(PetWindow.totalPets >= PetWindow.windowCount ) then
		local howMany = PetWindow.windowCount
		local j
		for j=howMany, PetWindow.totalPets  do
			PetWindow.CreateHealthBar(j)
		end
	end
	
	local i
	local count = 1
	for i=1, petSize do
		if(IsMobile(WindowData.Pets.PetId[i])) then
			PetWindow.UpdateHealthBarId(count, WindowData.Pets.PetId[i])
			count = count + 1
		end
	end
end

function PetWindow.IsPetCountCorrect()
	local petSize = table.getn(WindowData.Pets.PetId)
	local numPet
	local totalPet = 0
	for numPet = 1, petSize do
		if(IsMobile(WindowData.Pets.PetId[numPet])) then
			totalPet = totalPet + 1
		end
	end
	
	if (totalPet == PetWindow.totalPets) then
		return true
	else
		return false
	end
end

function PetWindow.UpdateHealthBarId(index, mobileId)
	local parent = "PetWindow"
	local healthName = "PetHealthBar"..index
	
	WindowSetId(healthName, mobileId)
	
	PetWindow.hasWindow[mobileId] = true
	PetWindow.reverseIndexId[mobileId] = index
	RegisterWindowData(WindowData.MobileStatus.Type, mobileId)	
	RegisterWindowData(WindowData.MobileName.Type, mobileId)
	RegisterWindowData(WindowData.HealthBarColor.Type, mobileId)
	
	WindowSetShowing(healthName, true)
	
	if SummonTimes[mobileId] == nil then
		SummonTimes[mobileId] = Interface.TimeSinceLogin
	end
	
	local data = WindowData.MobileName[mobileId]
	local name = data.MobName
	local shared = false
	if wstring.find(name, L"Rising Colossus") then
		shared = true
	end 
	WindowSetShowing(healthName.."HealthBar", not shared)
	WindowSetShowing(healthName.."SharedHealth", shared)
	WindowSetShowing(healthName.."Timer", shared)
	
	local propWindowHeight = PetWindow.windowY + (PetWindow.OffetSize * index)
	WindowSetDimensions(parent, PetWindow.windowX, propWindowHeight)
	PetWindow.UpdateStatus(mobileId)
	PetWindow.UpdateName(mobileId)
	PetWindow.TintHealthBar(mobileId)
end

function PetWindow.CreateHealthBar(index)
	local petWindow = "PetWindow"
	local healthName = "PetHealthBar"..index

	CreateWindowFromTemplate(healthName, "PetHealthBarTemplate", petWindow)
	
	WindowSetShowing(healthName.."HealthBar", true)
	WindowSetAlpha(healthName.."HealthBar", 0.7)
	WindowSetShowing(healthName.."SharedHealth", false)
	WindowSetAlpha(healthName.."SharedHealth", 0.7)
	WindowSetShowing(healthName.."Timer", false)
	WindowSetAlpha(healthName.."Timer", 0.4)
	WindowSetTintColor(healthName.."Timer", 50, 50, 200)
	StatusBarSetCurrentValue(healthName.."Timer", 1)	
	StatusBarSetMaximumValue(healthName.."Timer", 1)
	
	PetWindow.windowCount = PetWindow.windowCount + 1

	if (index == 1) then
		WindowAddAnchor(healthName, "topleft", petWindow, "topleft", 7, 25)
	else
		WindowAddAnchor(healthName, "bottomleft", "PetHealthBar"..(index-1), "topleft", 0, 0)
	end
end

function PetWindow.ClearHealthBarData(mobileId)
	if(PetWindow.reverseIndexId[mobileId] ~= nil) then
		local healthName = "PetHealthBar"..PetWindow.reverseIndexId[mobileId]
		WindowSetShowing(healthName, false)
		
		PetWindow.hasWindow[mobileId] = false
		PetWindow.reverseIndexId[mobileId] = nil
		UnregisterWindowData(WindowData.MobileStatus.Type, mobileId)
		UnregisterWindowData(WindowData.MobileName.Type, mobileId)
		UnregisterWindowData(WindowData.HealthBarColor.Type, mobileId)
	end
end

function PetWindow.HandleUpdateNameEvent()
	if (PetWindow.IsPetCountCorrect()) then
		PetWindow.UpdateName(WindowData.UpdateInstanceId)
	else
		PetWindow.UpdatePets()
	end
end

function PetWindow.UpdateName(mobileId)
	if(PetWindow.reverseIndexId[mobileId] ~= nil) then
		local windowName = "PetHealthBar"..PetWindow.reverseIndexId[mobileId]
		local data = WindowData.MobileName[mobileId]
		local shared = false
		
		--Set mobiles health status bar and name if their health bar is showing and not disabled
		if( (PetWindow.hasWindow[mobileId] == true) and (data ~= nil and data.MobName ~= nil) ) then
			local labelName = windowName.."LabelName"
			local name = L""
			if wstring.find(data.MobName, L"Rising Colossus") then
				shared = true
	
				name = L"Rising Colossus"
			else
				name = data.MobName
			end
	
			WindowSetShowing(windowName.."HealthBar", not shared)
			WindowSetShowing(windowName.."SharedHealth", shared)
			WindowSetShowing(windowName.."Timer", shared)
			
			LabelSetText(labelName, name)
			WindowUtils.FitTextToLabel(labelName, name)
			
			NameColor.UpdateLabelNameColor(labelName, data.Notoriety+1)
		end
	end
end

function PetWindow.HandleUpdateStatusEvent()
    PetWindow.UpdateStatus(WindowData.UpdateInstanceId)
end

function PetWindow.UpdateTimes()
	local mobileId
	local value
	
	for mobileId,value in pairs(PetWindow.hasWindow) do
		if PetWindow.reverseIndexId[mobileId] ~= nil then
			local windowName = "PetHealthBar"..PetWindow.reverseIndexId[mobileId]
			local name = WindowData.MobileName[mobileId].MobName
			if wstring.find(name, L"Rising Colossus") and SummonTimes[mobileId] ~= nil then
				local start = SummonTimes[mobileId]
				local now = Interface.TimeSinceLogin
				local lifetime = math.floor(now - start)
				local max = CreaturesDB.SummonTimes["a rising colossus"]
				local remaining = max - lifetime
				if remaining < 0 then
					remaining = 0
				end
			
				local alpha = 0.9 - ((remaining / max) * 0.5) 
				WindowSetAlpha(windowName.."Timer", alpha)
				StatusBarSetCurrentValue(windowName.."Timer", remaining)	
				StatusBarSetMaximumValue(windowName.."Timer", max)		
			end	
		end
	end
end


function PetWindow.UpdateStatus(mobileId)
	if(PetWindow.reverseIndexId[mobileId] ~= nil) then
		local windowName = "PetHealthBar"..PetWindow.reverseIndexId[mobileId]
		--Set mobiles health status bar and name if their health bar is showing and not disabled
		if( (PetWindow.hasWindow[mobileId] == true) ) then
			
			local name = WindowData.MobileName[mobileId].MobName
			
			if wstring.find(name, L"Rising Colossus") and SummonTimes[mobileId] ~= nil then
				local start = SummonTimes[mobileId]
				local now = Interface.TimeSinceLogin
				local lifetime = math.floor(now - start)
				local max = CreaturesDB.SummonTimes["a rising colossus"] + 2
				local remaining = max - lifetime
				if remaining < 0 then
					remaining = 0
				end
			
				local alpha = 0.9 - ((remaining / max) * 0.6) 
				WindowSetAlpha(windowName.."Timer", alpha)
				StatusBarSetCurrentValue(windowName.."Timer", remaining)	
				StatusBarSetMaximumValue(windowName.."Timer", max)		
			end
			
			
			StatusBarSetCurrentValue( windowName.."SharedHealth", WindowData.MobileStatus[mobileId].CurrentHealth )	
			StatusBarSetMaximumValue( windowName.."SharedHealth", WindowData.MobileStatus[mobileId].MaxHealth )
			StatusBarSetCurrentValue( windowName.."HealthBar", WindowData.MobileStatus[mobileId].CurrentHealth )	
			StatusBarSetMaximumValue( windowName.."HealthBar", WindowData.MobileStatus[mobileId].MaxHealth )
		end
	end
end

function PetWindow.HidePet()
	local windowName = "PetWindow"
	
	local newWindowPosX, newWindowPosY = WindowGetScreenPosition(windowName)
    if(newWindowPosX < 0) then
		WindowUtils.CopyScreenPosition(windowName,windowName,-newWindowPosX,0)
    end

end

function PetWindow.ShowPet()
	
end

function PetWindow.OnItemClicked()
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)
	if(mobileId ~= nil)then
		--Handle Single Left Click on pet window in uo_targetmanager
		HandleSingleLeftClkTarget(mobileId)
	end
end

--When player double clicks the object handle window it acts as if they double-clicked the object itself
function PetWindow.OnDblClick()
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)	
	UserActionUseItem(mobileId,false)
end

function PetWindow.OnRClick()
	local mobileId = WindowGetId(SystemData.ActiveWindow.name)
	RequestContextMenu(mobileId)
end

function PetWindow.OnMouseDrag()
	local windowName = "PetWindow"
	local showName = windowName.."ShowView"
	if (SnapUtils.SnappableWindows[showName] == true) then
		--SnapUtils.StartWindowSnap(showName)
	end
end

function PetWindow.HandleTintHealthBarEvent()
    PetWindow.TintHealthBar(WindowData.UpdateInstanceId)
end

function PetWindow.TintHealthBar(mobileId)
	if( PetWindow.reverseIndexId[mobileId] ~= nil and IsMobile(mobileId) ) then
		local windowTintName = "PetHealthBar"..PetWindow.reverseIndexId[mobileId]
		--Colors the health bar to the correct color
		HealthBarColor.UpdateHealthBarColor(windowTintName.."HealthBar", WindowData.HealthBarColor[mobileId].VisualStateId)
		HealthBarColor.UpdateHealthBarColor(windowTintName.."SharedHealth", WindowData.HealthBarColor[mobileId].VisualStateId)
	end
end