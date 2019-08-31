
----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

Tooltips = {}

-- Pre-Defined Anchor Modes

Tooltips.ANCHOR_WINDOW_LEFT = 1
Tooltips.ANCHOR_WINDOW_RIGHT = 2
Tooltips.ANCHOR_WINDOW_TOP = 3
Tooltips.ANCHOR_WINDOW_BOTTOM = 4

Tooltips.ANCHOR_SCREEN_BOTTOM_RIGHT = 5

-- Window - Relative Anchor Positions
Tooltips.ANCHOR_WINDOW_LEFT 	= { Point = "topleft",		RelativeTo = "", RelativePoint = "topright",	XOffset = -4, YOffset = 0 }
Tooltips.ANCHOR_WINDOW_RIGHT 	= { Point = "topright",		RelativeTo = "", RelativePoint = "topleft", XOffset = 4, YOffset = 0 }
Tooltips.ANCHOR_WINDOW_TOP		= { Point = "topleft",		RelativeTo = "", RelativePoint = "bottomleft",	XOffset = 0, YOffset = -4 }
Tooltips.ANCHOR_WINDOW_BOTTOM	= { Point = "bottomleft",	RelativeTo = "", RelativePoint = "topleft",	XOffset = 0, YOffset = 4 }

-- Default tooltip table dimensions
Tooltips.NUM_ROWS = 15
Tooltips.NUM_COLUMNS = 2
Tooltips.ROW_SPACING = 5
Tooltips.BORDER_SIZE = 6
Tooltips.LEFT_BORDER_SIZE = 10
Tooltips.COL_BORDER_SIZE = 5
Tooltips.COL_MIN_HEIGHT = 10
Tooltips.MAX_WIDTH = 375

Tooltips.DefaultFont = "google_noto_18"

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

local currentMouseOverWindow = ""
local currentStyle  = 0
local currentAnchor = Tooltips.ANCHOR_RIGHT
local currentTooltipWindow = ""
local visible = false
local currentUpdateCallback = nil

----------------------------------------------------------------
-- Tooltip Functions
----------------------------------------------------------------

function Tooltips.Initialize()

	-- Create the Tooltip Windows
	CreateWindow("DefaultTooltip", false)
	
	-- store the default window name
	currentTooltipWindow = "DefaultTooltip"

	-- reset the tooltip
	Tooltips.ClearTooltip()
end

function Tooltips.Update(timePassed)

	-- is the tooltip visible?
	if visible then

		-- is the tooltip the current mouse over window?
		if currentMouseOverWindow ~= SystemData.MouseOverWindow.name then
	
			-- hide the tooltip
			Tooltips.ClearTooltip()

		-- do we have a custom callback for update?
		elseif currentUpdateCallback then
		    
		    -- use the custom callback
		    currentUpdateCallback(timePassed)
		end
	end
end

function Tooltips.ClearTooltip()

	-- make sure we have a valid window name
	if not IsValidString(currentTooltipWindow) then
		return
	end

	-- hide the tooltip
	WindowSetShowing(currentTooltipWindow, false)

	-- restore the transparency
	Tooltips.SetTooltipAlpha(1.0)

	-- is this the default window?
	if currentTooltipWindow == "DefaultTooltip" then

		-- scan the rows
		for rowNum = 1, Tooltips.NUM_ROWS do

			-- current row name
			local rowName = currentTooltipWindow .. "Row" .. rowNum

			-- scan the columns
			for colNum = 1, Tooltips.NUM_COLUMNS do

				-- column window name
				local colName = rowName .. "Col" .. colNum .. "Text"

				-- remove the column text
				LabelSetText(colName, L"")

				-- resize the label to 0
				WindowSetDimensions(colName, Tooltips.MAX_WIDTH, 0)

				-- reset the text color
				LabelSetTextColor(colName, 255, 255, 255)

				-- by default the word wrap is off
				LabelSetWordWrap(colName, false)

				-- reset the tooltip font
				LabelSetFont(colName, Tooltips.DefaultFont, WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
				
				-- is this the first cell of the line?
				if colNum == 1 then

					-- remove the cell anchors
					WindowClearAnchors(colName)

					-- reset the anchor to default
					WindowAddAnchor(colName, "topleft", rowName, "topleft", 0, 0)
				end
			end

			-- resize the row to 0
			WindowSetDimensions(rowName, 0, 0)

			-- hide the row
			WindowSetShowing(rowName, false)
		end
	end
	
	-- resize the window to 0
	WindowSetDimensions(currentTooltipWindow, 0, 0)

	-- remove the custom update callback
	currentUpdateCallback = nil

	-- remove the mouse over window
	currentMouseOverWindow = ""
	
	-- flag that the tooltip is invisible
	visible = false	
end

function Tooltips.AnchorTooltipManual(anchorPoint, anchorToWindow, anchorRelativePoint, anchorOffsetX, anchorOffsetY)
	
	-- clear the tooltip anchors
	WindowClearAnchors(currentTooltipWindow)

	-- add the new anchors
	WindowAddAnchor(currentTooltipWindow, anchorPoint, anchorToWindow, anchorRelativePoint, anchorOffsetX, anchorOffsetY)
end

function Tooltips.AnchorTooltip(anchor)

	-- get the relative window to anchor to
	local anchorToWindow = anchor.RelativeTo

	-- do we have a window to anchor to?
	if not IsValidString(anchorToWindow) or not DoesWindowExist(anchorToWindow) then
		
		-- use the current mouse over window
		anchorToWindow = currentMouseOverWindow
	end	

	-- do we have a properties slot?
	if Interface.PropsSlot then

		-- set the anchor window to the properties slot
		anchorToWindow = "Hotbar" .. Interface.PropsSlot.HotbarID .. "Button" .. Interface.PropsSlot.SlotID

		-- anchor in the center of the slot
		anchor.Point = "center"

		-- anchor the bottom right of the tooltip to the center of the slot
		anchor.RelativePoint = "bottomright"

		-- set the offset to 0
		anchor.XOffset = 0
		anchor.YOffset = 0
	end
	
	-- clear the window anchors
	WindowClearAnchors(currentTooltipWindow)

	-- ancor to the chosen window and location
	WindowAddAnchor(currentTooltipWindow, anchor.Point, anchorToWindow, anchor.RelativePoint, anchor.XOffset, anchor.YOffset)	
end

-- Set Data function for STYLE_TEXT_ONLY
function Tooltips.CreateTextOnlyTooltip(mouseOverWindow, text)

	-- do we have a valid text?
	if not IsValidWString(text) then
		return
	end

	-- set the window to show the tooltip of
	currentMouseOverWindow = mouseOverWindow
	
	-- clear the tooltip
	Tooltips.ClearTooltip()
	
	-- set the window name to default
	currentTooltipWindow = "DefaultTooltip"

	-- allow word wrap
	Tooltips.SetTooltipWordWrap(1, 1, true)

	-- set the text in the first cell of the tooltip window
	Tooltips.SetTooltipText(1, 1, text)

	-- current cell window name
	local cell = currentTooltipWindow .. "Row1Col1Text"

	-- remove the cell anchors
	WindowClearAnchors(cell)

	-- anchor it to the center of the main window
	WindowAddAnchor(cell, "center", currentTooltipWindow, "center", 2, 0)

	-- set the tooltip default anchor
	Tooltips.AnchorTooltip(Tooltips.ANCHOR_WINDOW_TOP)

	-- finalize the tooltip
	Tooltips.Finalize()
end

function Tooltips.CreateCustomTooltip(mouseOverWindow, tooltipWindow)

	-- current mouse over window
	currentMouseOverWindow = mouseOverWindow
	
	-- reset the tooltip
	Tooltips.ClearTooltip()
	
	-- set the custom window as tooltip
	currentTooltipWindow = tooltipWindow
	
	-- show the tooltip window
	WindowSetShowing(currentTooltipWindow, true)

	-- flag the tooltip as visible
	visible = true
end

function Tooltips.SetUpdateCallback(callbackFunction)

	-- set the custom update callback
    currentUpdateCallback = callbackFunction
end

function Tooltips.SetTooltipAlpha(alpha)
	
	-- set the window transparency
	WindowSetAlpha(currentTooltipWindow, alpha)

	-- set the font transparency
	WindowSetFontAlpha(currentTooltipWindow, alpha)

	-- is this the default window?
	if currentTooltipWindow == "DefaultTooltip" then

		-- set the backgroud a little more transparent than the rest of the window
		WindowSetAlpha(currentTooltipWindow .. "Background", alpha - 0.2)
	end
end

function Tooltips.SetMouseOverWindow(mouseOverWindow)

	-- current mouse over window
	currentMouseOverWindow = mouseOverWindow
end

function Tooltips.SetTooltipText(row, column, text)

	-- are the row and column index within the limits?
	if  row < 1 or row > Tooltips.NUM_ROWS or 
		column < 1 or column > Tooltips.NUM_COLUMNS 
	then
		return
	end
	
	-- set the current tooltip window to default
	currentTooltipWindow = "DefaultTooltip"

	-- do we have a mouse over window?
	if not IsValidString(currentMouseOverWindow) then

		-- set the tooltip mouse over window
		Tooltips.SetMouseOverWindow(SystemData.MouseOverWindow.name)
	end

	-- current cell window name
	local name = currentTooltipWindow .. "Row" .. row .. "Col" .. column .. "Text"

	-- set the text to the cell
	LabelSetText(name, text )

	-- reset the cell font to default
	LabelSetFont(name, Tooltips.DefaultFont, WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
end

function Tooltips.SetTooltipFont(row, column, font, linespacing)

	-- are the row and column index within the limits?
	if  row < 1 or row > Tooltips.NUM_ROWS or 
		column < 1 or column > Tooltips.NUM_COLUMNS 
	then
		return
	end

	-- set the current tooltip window to default
	currentTooltipWindow = "DefaultTooltip"

	-- current cell window name
	local name = currentTooltipWindow .. "Row" .. row .. "Col" .. column .. "Text"

	-- set the label font
	LabelSetFont(name, font, linespacing or WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
end

function Tooltips.SetTooltipTextAlignment(row, column, align)

	-- are the row and column index within the limits?
	if  row < 1 or row > Tooltips.NUM_ROWS or 
		column < 1 or column > Tooltips.NUM_COLUMNS 
	then
		return
	end

	-- set the current tooltip window to default
	currentTooltipWindow = "DefaultTooltip"

	-- current cell window name
	local name = currentTooltipWindow .. "Row" .. row .. "Col" .. column .. "Text"

	-- set the label font
	LabelSetTextAlign(name, align)
end

function Tooltips.SetTooltipColor(row, column, red, green, blue)

	-- are the row and column index within the limits?
	if  row < 1 or row > Tooltips.NUM_ROWS or 
		column < 1 or column > Tooltips.NUM_COLUMNS 
	then
		return
	end

	-- set the current tooltip window to default
	currentTooltipWindow = "DefaultTooltip"

	-- current cell window name
	local name = currentTooltipWindow .. "Row" .. row .. "Col" .. column .. "Text"

	-- set the label font color
	LabelSetTextColor(name, red, green, blue)
end

function Tooltips.SetTooltipWordWrap(row, column, wordWrap)

	-- are the row and column index within the limits?
	if  row < 1 or row > Tooltips.NUM_ROWS or 
		column < 1 or column > Tooltips.NUM_COLUMNS 
	then
		return
	end

	-- set the current tooltip window to default
	currentTooltipWindow = "DefaultTooltip"

	-- current cell window name
	local name = currentTooltipWindow .. "Row" .. row .. "Col" .. column .. "Text"

	-- set the label font color
	LabelSetWordWrap(name, wordWrap)
end

function Tooltips.Finalize()
	
	-- count the visible rows
	local numRows = Tooltips.CountRows()
	
	-- initialize the window sizes
	local maxWidth = 0
	local maxHeight = 0

	-- max column width (to have all the cells of the same size)
	local maxCol1W = 0
	local maxCol2W = 0

	-- scan all the rows
	for rowNum = 1, numRows do

		-- current row name
		local rowName = currentTooltipWindow .. "Row" .. rowNum

		-- row dimensions variable
		local rowWidth = 0
		local rowHeight = 0

		-- scan the columns
		for colNum = 1, Tooltips.NUM_COLUMNS do

			-- column window name
			local colName = rowName .. "Col" .. colNum .. "Text"

			-- get the text dimensions
			local x, y = LabelGetTextDimensions(colName)
			
			-- get the column text
			local text = LabelGetText(colName)

			-- do we have a text inside this cell?
			if not IsValidWString(text) then

				-- reset the size to 0
				x = 0
				y = 0
			end

			-- increase the row width ( + a border)
			rowWidth = rowWidth + x + Tooltips.COL_BORDER_SIZE

			-- update the row height
			rowHeight = math.max(math.max(y, Tooltips.COL_MIN_HEIGHT), rowHeight)

			-- resize the column
			WindowSetDimensions(colName, x, y)

			-- is this the first cell?
			if colNum == 1 then

				-- determine if this is the largest cell of the column
				maxCol1W = math.max(x + Tooltips.COL_BORDER_SIZE, maxCol1W)

			else -- second cell

				-- determine if this is the largest cell of the column
				maxCol2W = math.max(x + Tooltips.COL_BORDER_SIZE, maxCol2W)
			end
		end

		-- cap the row size
		rowWidth = math.min(rowWidth, Tooltips.MAX_WIDTH)

		-- resize the row
		WindowSetDimensions(rowName, rowWidth, rowHeight)

		-- show the row
		WindowSetShowing(rowName, true)

		-- determine the max width for the window
		maxWidth = math.max(maxWidth, rowWidth)

		-- increase the total height
		maxHeight = maxHeight + rowHeight + Tooltips.ROW_SPACING
	end
	
	-- add a border to the max width
	maxCol1W = maxCol1W
	maxCol2W = maxCol2W

	-- calculate the default row width
	local rowWidth = maxCol1W + maxCol2W

	-- scan all the rows
	for rowNum = 1, numRows do

		-- current row name
		local rowName = currentTooltipWindow .. "Row" .. rowNum

		-- get the text dimensions
		local _, rowHeight = WindowGetDimensions(rowName)

		-- scan the columns
		for colNum = 1, Tooltips.NUM_COLUMNS do

			-- column window name
			local colName = rowName .. "Col" .. colNum .. "Text"

			-- is this the first cell?
			if colNum == 1 then

				-- resize the column
				WindowSetDimensions(colName, maxCol1W, rowHeight)

			else -- second cell

				-- resize the column
				WindowSetDimensions(colName, maxCol2W, rowHeight)
			end
		end

		-- resize the row
		WindowSetDimensions(rowName, rowWidth, rowHeight)
	end

	-- resize the window
	WindowSetDimensions(currentTooltipWindow, rowWidth + (Tooltips.LEFT_BORDER_SIZE * 2), maxHeight + (Tooltips.BORDER_SIZE * 2))

	-- show the tooltip
	WindowSetShowing(currentTooltipWindow, true)

	-- flag the tooltip as visible
	visible = true
end

function Tooltips.CountRows()

	-- current rows list
	local rowsList = {}

	-- scan the rows
	for rowNum = 1, Tooltips.NUM_ROWS do

		-- current row name
		local rowName = currentTooltipWindow .. "Row" .. rowNum

		-- current column name
		local col1Name = rowName .. "Col1" .. "Text"
		local col2Name = rowName .. "Col2" .. "Text"

		-- get the column text
		local text = LabelGetText(col1Name)
		local text2 = LabelGetText(col1Name)

		-- determine if the row is full or not
		rowsList[rowNum] = IsValidWString(text) or IsValidWString(text2)
	end

	-- scan the rows
	for rowNum = Tooltips.NUM_ROWS, 1, -1 do

		-- is there something in this row?
		if rowsList[rowNum] then

			-- this is the last row then
			return rowNum
		end
	end

	return 0
end

function Tooltips.HideEmptyRows()

	-- get the total amount of rows
	local totalRows = Tooltips.CountRows()

	-- scan the rows
	for rowNum = totalRows, 1, -1 do

		-- current row name
		local rowName = currentTooltipWindow .. "Row" .. rowNum
		
		-- hide the row
		WindowSetShowing(rowName, false)
	end
end