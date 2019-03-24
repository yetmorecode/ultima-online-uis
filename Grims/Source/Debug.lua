----------------------------------------------------------------
-- Debugging Assistance Variables
----------------------------------------------------------------

Debug = {}
Debug.Stringable = { ["nil"]=1, ["string"]=1, ["number"]=1, ["bool"]=1 }

function Debug.PrintToChat( text )
	TextLogAddEntry( "Chat", 100, text )
end

function Debug.PrintToDebugConsole( text )
	--if type(text) == "string" then
	--	text = StringToWString(text)
	--end
	
	TextLogAddEntry( "UiLog", 1, StringToWString(tostring(text)) )
	TextLogAddEntry("DebugPrint", 1, StringToWString(tostring(text)))
end

-- Shorter alias to PrintToDebugConsole
function Debug.Print(text)
	if (type(text) == "table") then
		Debug.DumpToConsole("", text)
	else
		Debug.PrintToDebugConsole(text)
	end
end

function Debug.DumpToConsole(name, value, memo)
	memo = memo or {}
	local t = type(value)
	local prefix = name.."="
	if Debug.Stringable[t] then
		Debug.Print(prefix..tostring(value))
	elseif t == "wstring" then
		Debug.Print(StringToWString(prefix)..value)
	elseif t == "boolean" then
		Debug.Print(StringToWString(prefix)..StringToWString(tostring(value)))
	elseif t == "table" then
		if memo[value] then
			Debug.Print(prefix..tostring(memo[value]))
		else
			memo[value] = name
			for k, v in pairs(value) do
				local fname = string.format("%s[%s]", name, tostring(k))
				Debug.DumpToConsole(fname, v, memo)
			end
		end
	else
		Debug.PrintToDebugConsole(StringToWString("Can't serialize type "..t))
	end
end

function Debug.Dump(name, value, memo)
	Debug.DumpToConsole(name, value, memo)
end


function Debug.ItemInfo()
	RequestTargetInfo()
	WindowRegisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT, "Debug.ItemInfoReceieved")
end

function Debug.ItemInfoReceieved()
	WindowUnregisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT)
	local Id = SystemData.RequestInfo.ObjectId
	
	local itemData = WindowData.ObjectInfo[Id]
	local extendedData = ItemProperties.GetExtendedInfo(Id, true)

	Debug.Print("=======================")
	Debug.Print(itemData);
	Debug.Print("-----------------------")
	Debug.Print(extendedData)

	--RegisterWindowData(WindowData.ContainerWindow.Type, Id)	
	--Debug.Print("*****************************")
	--Debug.Print(WindowData.ContainerWindow[Id])
	--Debug.Print("%%%%%%%%%%%%%%%%%%%%%%%%")
	--Debug.Print(WindowData.ContainerWindow[Id].ContainedItems)

end


function Debug.Test()
	RequestTargetInfo()
	WindowRegisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT, "Debug.Test2")
end

function Debug.Test2(objectId)
	WindowUnregisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT)
	local Id = SystemData.RequestInfo.ObjectId

	local itemInfo = ItemProperties.GetExtendedInfo(Id, true)
	Debug.Print(itemInfo)

	local price = itemInfo.Price
	price = string.gsub(price, ",", "")

	price = tonumber(price)
	Debug.Print(price)

	VendorConfiguration.DiscountItemId = Id
	VendorConfiguration.DiscountPrice = price * (1 - (VendorConfiguration.DiscountPercentage / 100))


	local OrganizeBag = ContainerWindow.PlayerBackpack
	ContainerWindow.TimePassedSincePickUp = 0
	ContainerWindow.CanPickUp = false
	
	MoveItemToContainer(Id, 0, OrganizeBag)

	local td = {func = function() MoveItemToContainer(Id, 0, itemInfo.ContainerId) end, time = Interface.TimeSinceLogin + 1.5}
	table.insert(ContainerWindow.TODO, td)
			
end


function Debug.Dump()

	--Debug.Print(WindowData)
	--Debug.Print("Taking a dump...system")
	--Debug.Print(SystemData)

	Debug.DumpToConsole("SystemData", SystemData)

	--local output = SystemData
	--local clockstring = Interface.Clock.DD .. "-" .. Interface.Clock.MM .. "-" .. Interface.Clock.YYYY .. " " .. Interface.Clock.h .. "-" .. Interface.Clock.m .. "-" .. Interface.Clock.s
	
	--TextLogCreate("SystemDump", 1) 
	--TextLogSetEnabled("SystemDump", true)
	--TextLogClear("SystemDump")
	--TextLogSetIncrementalSaving( "SystemDump", true, "logs/[" .. clockstring .. "]_SystemData.txt")
	
	--TextLogAddEntry("SystemDump", 1, output)
	--TextLogDestroy("SystemDump")
	

end


