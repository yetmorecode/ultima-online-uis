----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

SingleLineTextEntry = {}
SingleLineTextEntry_GumpData = {}

local WindowName
local data = {}
local stringData = {}

----------------------------------------------------------------
-- SingleLineTextEntry Functions
----------------------------------------------------------------

function SingleLineTextEntry.Initialize()
	UO_GenericGump.retrieveWindowData (SingleLineTextEntry_GumpData)
	stringData = UO_GenericGump.retreiveWindowDataStrings( SingleLineTextEntry_GumpData )

	WindowName = SingleLineTextEntry_GumpData.windowName
	WindowSetShowing(WindowName, false)

	Interface.OnCloseCallBack[WindowName] = SingleLineTextEntry.UserClosedGump

	WindowUtils.SetWindowTitle(WindowName,GetStringFromTid(1079164))

	Debug.Print(stringData)

	-- string data
	-- [1]= "TEXTENTRY"
	-- [2] = sender object id
	-- [3] = user object id
	-- [4] = text entry id return code
	-- [5] = messageTid
	-- [6] = IsUnicode (1 = yes, 0 = no)
	
	data.SenderObjId  = tonumber(stringData[2])
	data.UserObjId = tonumber(stringData[3])
	data.TextEntryId = tonumber (stringData[4])
	data.MessageTid = tonumber (stringData[5])
	data.IsUnicode = tonumber(stringData[6])
	
	if( SingleLineTextEntry_GumpData.localizedData ~= nil and SingleLineTextEntry_GumpData.localizedData[1] ~= nil ) then
	    LabelSetText(WindowName.."Subtitle1", SingleLineTextEntry_GumpData.localizedData[1])
	else
	    LabelSetText(WindowName.."Subtitle1", GetStringFromTid(data.MessageTid))
    end
	
	local submitButtonName = GGManager.translateTID(1077787)		-- "Submit"
	local clearButtonName = GGManager.translateTID(3000154)		-- "Clear"
	local cancelButtonName = GGManager.translateTID(GGManager.CANCEL_TID)

	ButtonSetText(WindowName.."SubmitButton", submitButtonName )
	ButtonSetText(WindowName.."ClearButton", clearButtonName )
	ButtonSetText(WindowName.."CancelButton", cancelButtonName )
	
	TextEditBoxSetText(WindowName.."TextEntryBox", L"")
	
	GGManager.registerWindow( WindowName, SingleLineTextEntry_GumpData )
	SingleLineTextEntry.broadcastHasBeenSent = false 

	-- AUTO VENDOR PRICING
	if(data.TextEntryId == 26) then

		local price 
		local priceConcat
		local itemData = WindowData.ObjectInfo[data.SenderObjId]


		if(VendorConfiguration.DiscountItemId ~= 0 and VendorConfiguration.DiscountPrice ~= 0) then
			--Debug.Print("discount pricing")
			--Debug.Print(VendorConfiguration.DiscountItemId)
			--Debug.Print(VendorConfiguration.DiscountPrice)
			-- Discount one specific item and ignore price defaults...
			price = VendorConfiguration.DiscountPrice
			priceConcat = towstring(VendorConfiguration.DiscountPrice)
			-- Reset the discount pricing...
			VendorConfiguration.DiscountItemId = 0
			VendorConfiguration.DiscountPrice = 0
		else
			-- Look for a specific price for this item name in our configuration
			for k, v in pairs(VendorConfiguration.Items) do
				if(tostring(v.Name) == tostring(itemData.name)) then
					price = towstring(v.Price)
					priceConcat = towstring(v.Price) .. L" " .. towstring(v.Description)
				end
			end
		end

		if(price) then
			TextEditBoxSetText(WindowName .. "TextEntryBox", priceConcat)
			WindowUtils.ChatPrint(itemData.name .. L" added for " .. StringUtils.FormatNumberWString(price), SystemData.ChatLogFilters.SYSTEM )
			SingleLineTextEntry.OnSubmit()
			return
		end

	end

	WindowSetShowing(WindowName, true)
	WindowAssignFocus(WindowName.."TextEntryBox", true)

end


-- this is used to make sure player didn't enter unicode chars when they should be only entering ascii
-- convert the text entered to a string then back to a wstring - if the conversion doesn't equal the original string, then there were unicode characters
function SingleLineTextEntry.CheckForUnicodeChars (text_entered)
	local returnVal = true
	
	local temp = StringToWString(tostring(text_entered))

	Debug.PrintToDebugConsole(L"SingleLineTextEntry.CheckForUnicodeChars: text =  "..text_entered)
	Debug.PrintToDebugConsole(L"SingleLineTextEntry.CheckForUnicodeChars: text2 =  "..temp)

	if (temp ~= text_entered) then
		returnVal = false
	end
	
	return (returnVal)

end

function SingleLineTextEntry.OnSubmit()

	local text_entered = TextEditBoxGetText( WindowName.."TextEntryBox" )
	Debug.PrintToDebugConsole(L"SingleLineTextEntry.OnSubmit: text =  "..text_entered)

	-- VENDOR INFO
	-- Save information about when this item was posted.
	if(data.TextEntryId == 26) then
		local itemId = tonumber(data.SenderObjId)
		--ItemProperties.RemoveInfoCacheItem(itemId)

		if(VendorConfiguration.WatchContainers[SystemData.TargetContainerId]) then
			
			local itemInfo = ItemProperties.GetExtendedInfo(data.SenderObjId)
			local item = {}
			item.Name = itemInfo.Name
			-- TODO: parse out price vs description...
			item.Price = text_entered
			item.DatePosted = Interface.Clock.MM  .. "/" .. Interface.Clock.DD .. "/" .. Interface.Clock.YYYY
			--Debug.Print("Saving this vendor item...")
			--Debug.Print(item)
			-- Is this container even being watched???
		
			VendorConfiguration.WatchContainers[SystemData.TargetContainerId].Items[itemId] = item
			VendorConfiguration.SaveWatchContainers()
		end
	end

	if (text_entered ~= nil) then
		if (data.IsUnicode == 1) then
			UO_GenericGump.broadcastTextEntryUReply( data.TextEntryId, text_entered,  SingleLineTextEntry_GumpData, 1 )
			SingleLineTextEntry.broadcastHasBeenSent = true 
			SingleLineTextEntry.OnCloseWindow()
		else
			-- make sure there are no unicode chars in the string
			local ValidString = SingleLineTextEntry.CheckForUnicodeChars (text_entered)
			if (ValidString == true) then
				UO_GenericGump.broadcastTextEntryReply( data.TextEntryId, text_entered,  SingleLineTextEntry_GumpData, 1 )	
				SingleLineTextEntry.broadcastHasBeenSent = true 
				SingleLineTextEntry.OnCloseWindow()
			else
				-- tell player the string contained illegal characters and to try again
				LabelSetText (WindowName.."Subtitle2",GetStringFromTid(1079165))
				SingleLineTextEntry.OnClear()
			end
		end
	end

	if(data.TextEntryId == 26) then
		local itemId = tonumber(data.SenderObjId)
		-- Need to delay this otherwise the item properties won't see the price change...
		local td = {func = function() ItemProperties.RemoveInfoCacheItem(itemId) end, time = Interface.TimeSinceLogin + 1}
		table.insert(ContainerWindow.TODO, td)
	end

end

function SingleLineTextEntry.OnClear()
	TextEditBoxSetText( WindowName.."TextEntryBox", L"" )
end

function SingleLineTextEntry.OnCancel()
	-- set the code to 0
	local text_entered = ""
	
	if (data.IsUnicode == 1) then
		UO_GenericGump.broadcastTextEntryUReply( data.TextEntryId, text_entered,  SingleLineTextEntry_GumpData, 0 )
	else
		UO_GenericGump.broadcastTextEntryReply( data.TextEntryId, text_entered,  SingleLineTextEntry_GumpData, 0 )	
	end
	SingleLineTextEntry.broadcastHasBeenSent = true 
	SingleLineTextEntry.OnCloseWindow()
end

function SingleLineTextEntry.UserClosedGump()
	SingleLineTextEntry.OnCancel()
end

function SingleLineTextEntry.Shutdown()

	if SingleLineTextEntry.broadcastHasBeenSent == false and data ~= nil then	
		if (data.IsUnicode == 1) then
			UO_GenericGump.broadcastTextEntryUReply( data.TextEntryId, text_entered,  SingleLineTextEntry_GumpData, 0 )
		else
			UO_GenericGump.broadcastTextEntryReply( data.TextEntryId, text_entered,  SingleLineTextEntry_GumpData, 0 )	
		end
	end
	
	data = {}
	stringData = {}
end

function SingleLineTextEntry.OnCloseWindow()
	GGManager.destroyWindow (WindowName)
end