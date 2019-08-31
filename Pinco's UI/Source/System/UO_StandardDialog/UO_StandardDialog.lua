----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

UO_StandardDialog = {}

UO_StandardDialog.DialogData = {}

UO_StandardDialog.DIALOG_EDGE_PADDING = 20
UO_StandardDialog.Y_PADDING = 85
UO_StandardDialog.MIN_HEIGHT = 160
UO_StandardDialog.DIALOG_BOTTOM_MARGIN = 20

UO_StandardDialog.TID_OKAY   = 1011036  -- OKAY
UO_StandardDialog.TID_CONTINUE   = 3000186  -- Continue
UO_StandardDialog.TID_CANCEL = 1011012  -- CANCEL
UO_StandardDialog.TID_CANCEL_LC = 3000091  -- Cancel
UO_StandardDialog.TID_ACCEPT = 1013076  -- Accept

UO_StandardDialog.DefaultButtons = { { textTid=UO_StandardDialog.TID_OKAY } }

-- dialogData 
--     windowName   = (string) name of window opening dialog (not optional)
--     title        = (wstring) title in titlebar (default L"")
--     titleTid     = (tid) title in titlebar (overrides title)
--     body         = (wstring) body text (default L"")
--     bodyTid      = (tid) body text (overrides body)
--     buttons      = (table) list of buttons to display (default okay,no callback)
--     hasScrollbar = (boolean) has a scrollbar (default false)
--     focusOnClose = (string) window to set focus to when the dialog closes (default nil)
--	   closeCallback = (string) function to call when the close (X button top-left) is pressed
--	   passCode = (wstring) word or phrase to type to enable the first button.
--     destroyDuplicate = (bool) shall we destroy any other dialog with the same name if it does exist?
--	   addBottomMargin = (bool) shall we add a bottom margin?
--	   forceHeight = (number) force the height of the dialog to this specific value
--
-- buttons[i]
--     text       = (wstring) button text (default L"")
--     textTid    = (tid) button text (overrides text)
--     callback   = (function) function to call on return (default nil)
--     param      = (any type) optional parameter to send to callback (default nil)
--
-- Example:
--     local okayButton = { textTid=UO_StandardDialog.TID_OKAY, callback=MyWindow.OnDialogOptionSelected, param=1 }
--     local cancelButton = { textTid=UO_StandardDialog.TID_CANCEL, callback=MyWindow.OnDialogOptionSelected, param=2 }
--     local dialogData =
--     {
--         windowName = "MyWindow",
--         titleTid = 555555,
--         bodyTid = 123456,
--         buttons = { okayButton, cancelButton },
--         hasScrollbar = false,
--     }
--     UO_StandardDialog.CreateDialog(dialogData)
--
--
function UO_StandardDialog.CreateDialog(dialogData)

	-- do we have the dialog window name?
    if dialogData.windowName == nil then

		-- error dump
        Debug.Print("Window name not specified! Failing to create dialog")

        return false
    end

	-- complete the window name
    local dialogWindowName = dialogData.windowName .. "Dialog"
    
	-- does a dialog with the same name already exist?
    if UO_StandardDialog.DialogData[dialogWindowName] ~= nil then

		-- do we have to destroy duplicate dialogs?
		if dialogData.destroyDuplicate == true then
			DestroyWindow(dialogWindowName)

		else -- error dump
			Debug.Print("Window already has a dialog open! Failing to create dialog")

			return false
		end
    end
    
	-- copy the new dialog data
    UO_StandardDialog.DialogData[dialogWindowName] = dialogData
    
	-- create the dialog
    CreateWindowFromTemplate(dialogWindowName, "UO_StandardDialog", "Root")
    
    return dialogWindowName
end

function UO_StandardDialog.Initialize()

	-- current dialog window name
    local dialogWindowName = SystemData.ActiveWindow.name

	-- current dialog data
    local dialogData = UO_StandardDialog.DialogData[dialogWindowName]

	-- mark the dialog to be destroyed on close    
    Interface.DestroyWindowOnClose[dialogWindowName] = true
    
	-- get the dialog size
    local dialogWidth, dialogHeight = WindowGetDimensions(dialogWindowName)

	-- initialize the height to a default value
    local newHeight = UO_StandardDialog.Y_PADDING
    
	-- no buttons?
    if dialogData.buttons == nil then

		-- add some default buttons
        dialogData.buttons = UO_StandardDialog.DefaultButtons
    end
	
	-- do we have a title TID?
    if dialogData.titleTid ~= nil then

		-- set the title name with TID
		WindowUtils.SetWindowTitle(dialogWindowName, GetStringFromTid(dialogData.titleTid))
 
	-- do we have a text title?
    elseif dialogData.title ~= nil then

		-- set the title name with string
		WindowUtils.SetWindowTitle(dialogWindowName, dialogData.title)
    end
    
    -- do we have the body TID?
    if dialogData.bodyTid ~= nil then

		-- get the body string from the TID
        body = GetStringFromTid(dialogData.bodyTid)

	-- do we have the body string?
    elseif dialogData.body ~= nil then

		-- get the body string
        body = dialogData.body
    end

	-- do we have to use a passcode?
	if dialogData.passCode ~= nil then

		-- add the passcode text to the dialog body
		body = body .. L"\n\n" .. ReplaceTokens(GetStringFromTid(390), {dialogData.passCode, GetStringFromTid(dialogData.buttons[1].textTid)})
	end
    
	-- do we have to show a scrollbar for the text?
    if dialogData.hasScrollbar == true then

		-- hide the normal text
        WindowSetShowing(dialogWindowName .. "NormalText", false)

		-- write the text on the scrollable box
        LabelSetText(dialogWindowName .. "ScrolledChildText", body)

		-- update the scroll area to match the text size
        ScrollWindowUpdateScrollRect(dialogWindowName .. "Scrolled")

		-- do we have to use a passcode?
		if dialogData.passCode ~= nil then

			-- passcode element name
			local passCodeBox = dialogWindowName .. "PassCode"

			-- create the passcode textbox
			CreateWindowFromTemplate(passCodeBox, "UO_StandardDialog_Passcode_Template", dialogWindowName)

			-- anchor the textbox unde the dialog scrollable area
			WindowAddAnchor(passCodeBox, "bottom", dialogWindowName .. "Scrolled", "top", 0, 20)
			
			-- increase the main window size
			newHeight = newHeight + 60
		end

    else -- non-scrollable text

		-- hide the scrollable area
        WindowSetShowing(dialogWindowName .. "Scrolled", false)

		-- write the text in the label
        LabelSetText(dialogWindowName .. "NormalText", body)

		-- get the label dimensions
        local textWidth, textHeight = LabelGetTextDimensions(dialogWindowName .. "NormalText")

		-- increase the dialog size based on the label dimensions
        newHeight = newHeight + textHeight

		-- do we have to use a passcode?
		if dialogData.passCode ~= nil then

			-- passcode element name
			local passCodeBox = dialogWindowName .. "PassCode"

			-- create the passcode textbox
			CreateWindowFromTemplate(passCodeBox, "UO_StandardDialog_Passcode_Template", dialogWindowName)

			-- anchor the textbox unde the dialog text
			WindowAddAnchor(passCodeBox, "bottom", dialogWindowName .. "NormalText", "top", 0, 20)
			
			-- increase the main window size
			newHeight = newHeight + 60
		end
    end
    
	-- count the buttons to draw
    local numButtons = #dialogData.buttons
    
	-- this will be used to calculate the space between the buttons
    local spacing = 0

	-- scan all the buttons
    for index, button in pairsByIndex(dialogData.buttons) do

		-- current button window name
        local buttonName = dialogWindowName .. "Button" .. index

		-- create the button
        CreateWindowFromTemplate(buttonName, "DialogButtonTemplate", dialogWindowName)

		-- set the button ID
        WindowSetId(buttonName, index)

        -- do we have the button name TID?
        if button.textTid ~= nil then

			-- set the button text from TID
			ButtonSetText(buttonName, GetStringFromTid(button.textTid))

		-- do we have the button name string?
        elseif button.text ~= nil then

			-- set the button text from the string
			ButtonSetText(buttonName, button.text)
        end
        
        -- is this the first button?
        if index == 1 then

			-- get the button dimensions
            local buttonWidth, buttonHeight = WindowGetDimensions(buttonName)

            -- increase the dialog dimension by the button height
            newHeight = newHeight + buttonHeight
            
			-- calculating the space between buttons
            spacing = (dialogWidth - (buttonWidth * numButtons)) / (numButtons + 1)
            
			-- anchor the button to the bottom of the dialog
            WindowAddAnchor(buttonName, "bottomleft", dialogWindowName, "bottomleft", spacing, -UO_StandardDialog.DIALOG_EDGE_PADDING)

			-- do we have to use a passcode?
			if dialogData.passCode ~= nil then

				-- disable the button (it will be enabled if the passcode entered is correct)
				ButtonSetDisabledFlag(buttonName, true)

				-- disable the button input
				WindowSetHandleInput(buttonName, false)
			end

        else -- anchor the button to the right of the previous one
            WindowAddAnchor(buttonName, "topright", dialogWindowName .. "Button" .. (index - 1), "topleft", spacing, 0)
        end
    end
    
	-- is the dialog height less than the min height?
    if newHeight < UO_StandardDialog.MIN_HEIGHT then

		-- set the height to the min value
        newHeight = UO_StandardDialog.MIN_HEIGHT
    end

	-- shall we add a bottom margin?
	if dialogData.addBottomMargin == true then

		-- adding a bottom margin
		newHeight = newHeight + UO_StandardDialog.DIALOG_BOTTOM_MARGIN
	end

	-- shall we force the dialog height?
	if dialogData.forceHeight ~= nil and dialogData.forceHeight ~= newHeight then

		-- force the height to the specific value
		newHeight = dialogData.forceHeight
	end

	-- do we have a function to execute on close?
	if dialogData.closeCallback then

		-- add the function to the close callback
		Interface.OnCloseCallBack[dialogWindowName] = dialogData.closeCallback
	end

	-- Add the enter and escape default key events
	WindowRegisterEventHandler(dialogWindowName, SystemData.Events.ENTER_KEY_PROCESSED, "UO_StandardDialog.OnKeyEnter")	
	WindowRegisterEventHandler(dialogWindowName, SystemData.Events.ESCAPE_KEY_PROCESSED, "UO_StandardDialog.OnKeyEscape")	

	-- update the dialog dimensions
    WindowSetDimensions(dialogWindowName, dialogWidth, newHeight)

	-- show the dialog
    WindowSetShowing(dialogWindowName, true)   

	-- set the focus on the dialog (so the enter and escape keys can work properly)
	WindowAssignFocus(dialogWindowName, true)
end

function UO_StandardDialog.Shutdown()

	-- current dialog window name
    local windowName = SystemData.ActiveWindow.name

	-- get the dialog data
    local dialogData = UO_StandardDialog.DialogData[windowName]

	-- do we have to focus another window on close?
    if dialogData.focusOnClose ~= nil then

		-- focus the requested window
        WindowAssignFocus(dialogData.focusOnClose, true)
    end

	-- remove the dialog data
    UO_StandardDialog.DialogData[windowName] = nil

	-- detach the events
	WindowUnregisterEventHandler(windowName, SystemData.Events.ENTER_KEY_PROCESSED)	
	WindowUnregisterEventHandler(windowName, SystemData.Events.ESCAPE_KEY_PROCESSED)	
end

function UO_StandardDialog.OnLButtonUp()

	-- get the main dialog window name
	local dialogWindowName = WindowUtils.GetActiveDialog()

	-- get the dialog data
    local dialogData = UO_StandardDialog.DialogData[dialogWindowName]

	-- if we don't have the dialog data we can get out
	if not dialogData then
		return
	end

	-- get the button index
    local index = WindowGetId(SystemData.ActiveWindow.name)

	-- get the button data
    local button = dialogData.buttons[index]
    
	-- do we have the button data and a function to execute?
    if button ~= nil and button.callback ~= nil then

		-- execute the callback
        button.callback(button.param)
    end
    
	-- destroy the dialog
    DestroyWindow(dialogWindowName)
end

-- the enter key execute the button OK (if exists)
function UO_StandardDialog.OnKeyEnter()

    -- get the main dialog window name
	local dialogWindowName = WindowUtils.GetActiveDialog()

	-- get the dialog data
    local dialogData = UO_StandardDialog.DialogData[dialogWindowName]
	
	-- if we don't have the dialog data we can get out
	if not dialogData then
		return
	end

	-- button data to use
    local button

	-- button index
	local index

	-- scan all the buttons
    for i, data in pairsByIndex(dialogData.buttons) do
		
		-- do we have a button text TID?
		if not data.textTid then
			continue
		end

		-- is the TID OK or CONTINUE?
		if data.textTid == UO_StandardDialog.TID_OKAY or data.textTid == UO_StandardDialog.TID_CONTINUE or data.textTid == UO_StandardDialog.TID_ACCEPT then

			-- get the button data
			button = data

			-- store the button index
			index = i

			break
		end
	end

	-- do we have the button data?
	if not button then
		return
	end

	-- current button window name
    local buttonName = dialogWindowName .. "Button" .. index

	-- if the button is disabled we can get out
	if ButtonGetDisabledFlag(buttonName) then
		return
	end

    -- do we have the button data and a function to execute?
    if button ~= nil and button.callback ~= nil then

		-- execute the callback
        button.callback(button.param)
    end
    
	-- destroy the dialog
    DestroyWindow(dialogWindowName)

	-- make sure the chatbox stay closed (since when we press enter it will always open)
	NewChatWindow.CloseChatBox()
end

-- the escape key execute the button cancel (if exists)
function UO_StandardDialog.OnKeyEscape()

    -- get the main dialog window name
	local dialogWindowName = WindowUtils.GetActiveDialog()

	-- get the dialog data
    local dialogData = UO_StandardDialog.DialogData[dialogWindowName]

	-- make sure the main menu doesn't pop up (since it always does when you press ESCAPE)
	MainMenuWindow.notnow = true
	
	-- if we don't have the dialog data we can get out
	if not dialogData then
		return
	end

	-- scan all the buttons
    for i, data in pairsByIndex(dialogData.buttons) do
		
		-- do we have a button text TID?
		if not data.textTid then
			continue
		end

		-- is the TID CANCEL or NO?
		if data.textTid == UO_StandardDialog.TID_CANCEL or data.textTid == SettingsWindow.TID_NO then

			-- get the button data
			button = data

			break
		end
	end

	-- do we have the button data?
	if not button then
		return
	end

    -- do we have the button data and a function to execute?
    if button ~= nil and button.callback ~= nil then

		-- execute the callback
        button.callback(button.param)
    end
    
	-- destroy the dialog
    DestroyWindow(dialogWindowName)
end

function UO_StandardDialog.TextChanged(text)

	-- get the main dialog window name
	local dialogWindowName = WindowUtils.GetActiveDialog()

	-- get the dialog data
    local dialogData = UO_StandardDialog.DialogData[dialogWindowName]

	-- first button window name
	local firstbuttonName = dialogWindowName .."Button1"

	-- is the passcode correct?
	ButtonSetDisabledFlag(firstbuttonName, dialogData.passCode ~= text)

	-- disable the button input
	WindowSetHandleInput(firstbuttonName, dialogData.passCode == text)
end