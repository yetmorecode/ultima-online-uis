----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

UO_GenericGump = {}

UO_GenericGump.DEFAULT_CLOSE_BUTTON_ID = 0

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

if IsInternalBuild() then
	UO_GenericGump.DEBUG_ON = false
	--UO_GenericGump.DEBUG_ON = true
end

-- KLUDGE:
-- used for fixing a resizing problem
-- When this is fixed in the base UI, we can just change this to: 
UO_GenericGump.EMPTY_LINE = L"                                    "



----------------------------------------------------------------
-- Generic Gump Utility Functions
----------------------------------------------------------------

function UO_GenericGump.retrieveWindowData( gumpData )
	if not gumpData then
		Debug.PrintToDebugConsole( L"ERROR: gumpData does not exist." )
		return false
	end      
	if not WindowData.GG_Core.GumpId then
		Debug.PrintToDebugConsole( L"ERROR: required field WindowData.GG_Core.GumpId could not be retrieved." )
		return false
	end      	
	
	gumpData.gumpID = WindowData.GG_Core.GumpId
	
	if not WindowData.GG_Core.ObjectId then
		Debug.PrintToDebugConsole( L"ERROR: required field WindowData.GG_Core.objectID could not be retrieved." )
		return false
	end   
	
	gumpData.objectID = WindowData.GG_Core.ObjectId
	
	gumpData.windowName = SystemData.ActiveWindow.name
	gumpData.name = towstring(gumpData.windowName)

	gumpData.stringPageIndex = WindowData.GG_Core.stringPageIndex
	gumpData.stringData = WindowData.GG_Core.stringData
	gumpData.stringDataCount = WindowData.GG_Core.stringDataCount
	
	gumpData.descPageIndex = WindowData.GG_Core.descPageIndex
	gumpData.descData = WindowData.GG_Core.desc
	gumpData.descDataCount = WindowData.GG_Core.descCount
	
	gumpData.buttonPageIndex = WindowData.GG_Core.buttonPageIndex
	gumpData.buttonIDs = WindowData.GG_Core.buttonIdData
	gumpData.buttonCount = WindowData.GG_Core.buttonIdDataCount
	
	gumpData.localizedPageIndex = WindowData.GG_Core.tokenPageIndex
	gumpData.localizedData = WindowData.GG_Core.localizedData
	gumpData.localizedDataCount = WindowData.GG_Core.localizedDataCount
	
	gumpData.ImagePageIndex = WindowData.GG_Core.tilePageIndex
	gumpData.ImageNum = WindowData.GG_Core.gumppicNumData
	gumpData.ImageCount = WindowData.GG_Core.gumppicNumDataCount
	
	gumpData.portImgPageIndex = WindowData.GG_Core.portPageIndex
	gumpData.portImgData = WindowData.GG_Core.portImgData
	
	gumpData.textHuePageIndex = WindowData.GG_Core.huePageIndex
	gumpData.textHueData = WindowData.GG_Core.textHueData
	gumpData.textHueDataCount = WindowData.GG_Core.textHueDataCount
	
	gumpData.toolTipPageIndex = WindowData.GG_Core.toolTipPageIndex
	gumpData.toolTipData = WindowData.GG_Core.toolTipData
	
	UO_GenericGump.debug( L"retrieved data for "..gumpData.name..L" with gumpID = "..gumpData.gumpID..L" ,objectID = "..gumpData.objectID  )
	return true
end


function UO_GenericGump.retreiveWindowDataStrings( gumpData )
	return WindowData.GG_Core.stringData
end


-- UO_GenericGump.broadcastTextEntries( buttonID, stringList, gumpData )
-- Sends text back to the server
--
-- buttonID - button pressed to submit the data, i.e. a submit or 
--              OK button, not the ID for the TextEntry (type int)
-- stringList - Table of textEntry ID to Text enterred pairs, 
--                e.g. put date into table with call like: stringList[ WindowGetId( textBoxName ) ] = TextEditBoxGetText( textBoxName )
--                Note: because these are not numeric indexed you can't use table.getn to tell what's in the table 
--                Note: the wombat script will normally accept either nil or "" for textentry fields with no data, but you should look at the wombat trigger for that GumpID to confirm
-- gumpData - standard table of basic gump header (gumpID and objectID)
--
function UO_GenericGump.broadcastTextEntries( buttonID, stringList, gumpData )
  
    local i = 0
    for key, str in pairs( stringList ) do
		i = i + 1
		if tonumber(key) == nil then
			ReturnWindowData.GG_Core.CountEntries.Id[i] = -1
		else 
			ReturnWindowData.GG_Core.CountEntries.Id[i] = tonumber(key)
		end
		ReturnWindowData.GG_Core.CountEntries.Text[i] = str
		ReturnWindowData.GG_Core.CountEntries.Length[i] = str:len()

		UO_GenericGump.debug( L"sending string = "..ReturnWindowData.GG_Core.CountEntries.Text[i]..L", length = "..ReturnWindowData.GG_Core.CountEntries.Length[i]..L", ID = "..ReturnWindowData.GG_Core.CountEntries.Id[i] )

	end

    ReturnWindowData.GG_Core.NumCountEntries = i
	
	UO_GenericGump.debug( L"sending "..i..L" strings"  )

	
	UO_GenericGump.broadcastButtonPress( buttonID, gumpData )
 end


function UO_GenericGump.broadcastSelections( buttonID, selectionsList, gumpData )

    ReturnWindowData.GG_Core.NumCountSelections = #selectionsList
    ReturnWindowData.GG_Core.CountSelections = selectionsList
 
	 UO_GenericGump.broadcastButtonPress( buttonID, gumpData )
 end

function UO_GenericGump.broadcastButtonPress( buttonID, gumpData )

	if not UO_GenericGump.writeBasicGumpData( gumpData) then
		Debug.PrintToDebugConsole( L"ERROR in UO_GenericGump.broadcastButtonPress: could not broadcast button trigger." )
		return false	
	end 
    ReturnWindowData.GG_Core.ButtonId = buttonID
    
    -- TODO: figure out where to get this value to broadcast
    BroadcastEvent( SystemData.Events.GENERIC_GUMP_ACTION)
    
    if ReturnWindowData.GG_Core.ButtonId then
		UO_GenericGump.debug( L"Broadcast GENERIC_GUMP_ACTION with buttonID = "..ReturnWindowData.GG_Core.ButtonId..L"\n"  )
	else
		UO_GenericGump.debug( L"Broadcasted GENERIC_GUMP_ACTION with buttonID = NIL. Why is it NIL???\n" )
	end
end

function UO_GenericGump.writeBasicGumpData( gumpData )

	if not gumpData or not gumpData.gumpID or not gumpData.objectID then
		Debug.PrintToDebugConsole( L"ERROR in UO_GenericGump.writeBasicGumpData: basic Generic Gump Data not found." )
		return false
	end   
	
	ReturnWindowData.GG_Core.GumpId = gumpData.gumpID 
	ReturnWindowData.GG_Core.ObjectId = gumpData.objectID
	
	UO_GenericGump.debug( L"Set outgoing values gumpID = "..ReturnWindowData.GG_Core.GumpId..L" ,objectID = "..ReturnWindowData.GG_Core.ObjectId   )
	return true
end

-- this is used for when a generic gump sends a reply that is to be treated as a text entry trigger rather than a generic gump 
function UO_GenericGump.broadcastTextEntryReply( textEntryId, theText,  gumpData, code )
	--Debug.PrintToDebugConsole(L"UO_GenericGump.broadcastTextEntryReply: textEntryId =  "..towstring(tostring(textEntryId)))
	--Debug.PrintToDebugConsole(L"UO_GenericGump.broadcastTextEntryReply: theText =  "..theText)

	if not UO_GenericGump.writeBasicGumpData( gumpData) then
		Debug.PrintToDebugConsole( L"ERROR in UO_GenericGump.broadcastTextEntryReply: could not broadcast button trigger." )
		return false	
	end 

	ReturnWindowData.GG_Core.GumpId = gumpData.gumpID 
	ReturnWindowData.GG_Core.ObjectId = gumpData.objectID

    ReturnWindowData.GG_Core.TextEntryID = textEntryId
    -- this will be sent as a wstring for both unicode and non-unicode strings, we will handle casting the wstring to a string when needed in c++
	ReturnWindowData.GG_Core.TheTexts[1] = theText
	ReturnWindowData.GG_Core.TheTextLengths[1] = theText:len()
 
 	ReturnWindowData.GG_Core.TheCode = code -- 1 if submit button pressed, 0 if canceled
   
    -- TODO: figure out where to get this value to broadcast
    BroadcastEvent(SystemData.Events.GENERIC_GUMP_TEXT_ENTRY_ACTION)
    
	UO_GenericGump.debug( L"Broadcast GENERIC_GUMP_TEXT_ENTRY_ACTION with textEntryID = "..ReturnWindowData.GG_Core.TextEntryID..L"\n"  )
end

-- this is used for when a generic gump sends a reply that is to be treated as a text entry unicode trigger rather than a generic gump 
function UO_GenericGump.broadcastTextEntryUReply( textEntryId, theText,  gumpData, code )
	--Debug.PrintToDebugConsole(L"UO_GenericGump.broadcastTextEntryUReply: textEntryId =  "..towstring(tostring(textEntryId)))
	--Debug.PrintToDebugConsole(L"UO_GenericGump.broadcastTextEntryUReply: theText =  "..theText)
	

	if not UO_GenericGump.writeBasicGumpData( gumpData) then
		Debug.PrintToDebugConsole( L"ERROR in UO_GenericGump.broadcastTextEntryUReply: could not broadcast button trigger." )
		return false	
	end 
   
  	ReturnWindowData.GG_Core.GumpId = gumpData.gumpID 
	ReturnWindowData.GG_Core.ObjectId = gumpData.objectID
 
    ReturnWindowData.GG_Core.TextEntryID = textEntryId
    -- this will be sent as a wstring for both unicode and non-unicode strings, we will handle casting the wstring to a string when needed in c++
	ReturnWindowData.GG_Core.TheTexts[1] = theText
	ReturnWindowData.GG_Core.TheTextLengths[1] = theText:len()

	ReturnWindowData.GG_Core.TheCode = code -- 1 if submit button pressed, 0 if canceled
  
    -- TODO: figure out where to get this value to broadcast
    BroadcastEvent(SystemData.Events.GENERIC_GUMP_TEXT_ENTRYU_ACTION)
    
	UO_GenericGump.debug( L"Broadcast GENERIC_GUMP_TEXT_ENTRYU_ACTION with textEntryID = "..ReturnWindowData.GG_Core.TextEntryID..L"\n"  )
end



function UO_GenericGump.debug(wstr)
	if UO_GenericGump.DEBUG_ON then
		Debug.PrintToDebugConsole(wstr)
	end
end
