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

	Interface.OnCloseCallBack[WindowName] = SingleLineTextEntry.UserClosedGump

	--WindowUtils.SetWindowTitle(WindowName,GetStringFromTid(1079164))

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
	
	local text
	if( SingleLineTextEntry_GumpData.localizedData ~= nil and SingleLineTextEntry_GumpData.localizedData[1] ~= nil ) then
		text = SingleLineTextEntry_GumpData.localizedData[1]
	else
	    text = GetStringFromTid(data.MessageTid)
    end
    
    text = wstring.gsub(text, L" %(ESC = CANCEL%)", L"")
    text = wstring.gsub(text, L"marked object", L"mark")
    
    LabelSetText(WindowName.."Subtitle1", text)
	
	local submitButtonName = GGManager.translateTID(1077787)		-- "Submit"
	local cancelButtonName = L"Cancel" -- GGManager.translateTID(GGManager.CANCEL_TID)

	ButtonSetText(WindowName.."SubmitButton", submitButtonName )
	ButtonSetText(WindowName.."CancelButton", cancelButtonName )
	
	TextEditBoxSetText(WindowName.."TextEntryBox", L"")
	WindowAssignFocus(WindowName.."TextEntryBox", true)

	GGManager.registerWindow( WindowName, SingleLineTextEntry_GumpData )
	SingleLineTextEntry.broadcastHasBeenSent = false 

	WindowUtils.RestoreWindowPosition("SingleLineTextEntry"..data.MessageTid)
end


-- this is used to make sure player didn't enter unicode chars when they should be only entering ascii
-- convert the text entered to a string then back to a wstring - if the conversion doesn't equal the original string, then there were unicode characters
function SingleLineTextEntry.CheckForUnicodeChars (text_entered)
	local returnVal = true
	
	local temp = StringToWString(tostring(text_entered))

	if (temp ~= text_entered) then
		returnVal = false
	end
	
	return (returnVal)

end

function SingleLineTextEntry.OnSubmit()
	local text_entered = TextEditBoxGetText( WindowName.."TextEntryBox" )
	
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
	
	WindowUtils.SaveWindowPosition("SingleLineTextEntry"..data.MessageTid)
	
	data = {}
	stringData = {}
end

function SingleLineTextEntry.OnCloseWindow()
	GGManager.destroyWindow (WindowName)
end