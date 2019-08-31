----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

BookTemplate = {}

BookTemplate.OpenBooks = {}

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function BookTemplate.Initialize()

	-- get the book ID
	local bookId = WindowData.Book.ObjectId

	-- current book window name
	local bookWindowName = SystemData.ActiveWindow.name

	-- flag the window to be destroyed when closed
	Interface.DestroyWindowOnClose[bookWindowName] = true

	-- attach the book ID to the window
    WindowSetId(bookWindowName, WindowData.Book.ObjectId)

	-- scale the window
	WindowSetScale(bookWindowName, 0.85)

	-- initialize the book data array
 	BookTemplate.OpenBooks[bookId] = {}

	-- get the book title
	BookTemplate.OpenBooks[bookId].title = WindowData.Book.Title

	-- get the author name
	BookTemplate.OpenBooks[bookId].author = WindowData.Book.Author

	-- get the total number of pages
	BookTemplate.OpenBooks[bookId].numPages = WindowData.Book.NumPages

	-- can the book be modified?
	BookTemplate.OpenBooks[bookId].canEdit = WindowData.Book.CanEdit

	-- each element in this table is the text page for the book
	BookTemplate.OpenBooks[bookId].content = {}

	-- id of the pages that we are currently seeing
	BookTemplate.OpenBooks[bookId].showingPages = { 0, 1 }

	-- update the default book textures
	BookTemplate.UpdateTextures(bookWindowName)

	-- title page name
	local titlePageWindowName = bookWindowName .. "TitlePage"

	-- create the title page
    CreateWindowFromTemplate(titlePageWindowName, "TitlePageTemplate", bookWindowName)
	
	-- can the book be modified?
	if BookTemplate.OpenBooks[bookId].canEdit then

		-- hide the title label
		WindowSetShowing(titlePageWindowName .. "Title", false)

		-- focus the title textbox
		WindowAssignFocus(titlePageWindowName .. "EditTitle", true)

		-- set the title in the textbox
		TextEditBoxSetText(titlePageWindowName .. "EditTitle", BookTemplate.OpenBooks[bookId].title)
		
		-- hide the author label
		WindowSetShowing(titlePageWindowName .. "Author", false)

		-- set the author name into the author textbox
		TextEditBoxSetText(titlePageWindowName .. "EditAuthor", BookTemplate.OpenBooks[bookId].author)
		
		-- hide the label text pages
		WindowSetShowing(bookWindowName .. "Page1Text", false)
		WindowSetShowing(bookWindowName .. "Page2Text", false)

	else -- the book cannot be modified
		
		-- hide the title textbox
		WindowSetShowing(titlePageWindowName .. "EditTitle", false)

		-- set the title into the title label
		LabelSetText(titlePageWindowName .. "Title", BookTemplate.OpenBooks[bookId].title)
		
		-- hide the author textbox
		WindowSetShowing(titlePageWindowName .. "EditAuthor", false)

		-- set the author name into the author label
		LabelSetText(titlePageWindowName .. "Author", BookTemplate.OpenBooks[bookId].author)
		
		-- hide the textbox pages
		WindowSetShowing(bookWindowName .. "Page1EditText", false)
		WindowSetShowing(bookWindowName .. "Page2EditText", false)
	end

	-- set the first page number
	LabelSetText(bookWindowName .. "Page2Number", L"1")
	
	-- hide the previous page buttons
	WindowSetShowing(bookWindowName .. "PageDownButton", false)

	-- the next page button is enable only if you have more than 1 page in the book
	WindowSetShowing(bookWindowName .. "PageUpButton", BookTemplate.OpenBooks[bookId].numPages > 1)
	
	-- initialize the list of pages to request from the server
	local pages = {}

	-- add the page index to the array
	for i = 1, WindowData.Book.NumPages do
		pages[i] = i
	end

	-- request all the book pages at once
    GumpManagerRequestBookPages(bookId, pages)
end

function BookTemplate.Shutdown()

	-- get the book ID
    local bookId = WindowGetId(SystemData.ActiveWindow.name)
    
	-- can the book be modified?
    if BookTemplate.OpenBooks[bookId].canEdit then

		-- save the changes before closing
        BookTemplate.StoreText(bookId)
    end
    
	-- delete the book data
    BookTemplate.OpenBooks[bookId] = nil
end

function BookTemplate.SetPagesText(bookId)
	
	-- do we have a valid book ID?
	if not IsValidID(bookId) then
		return
	end

	-- book window name
	local bookWindowName = "Book" .. bookId

	-- title page name
	local titlePageWindowName = bookWindowName .. "TitlePage"

	-- left page ID
	local leftPage = BookTemplate.GetLeftPageID(bookId)

	-- show/hide the title/author if it's the first page
	WindowSetShowing(titlePageWindowName, leftPage == 0)

	-- show the page text if it's not the first page and the book CANNOT be edited
	WindowSetShowing(bookWindowName .. "Page1Text", leftPage ~= 0 and not BookTemplate.OpenBooks[bookId].canEdit)

	-- show the page textbox if it's not the first page and the book CAN be edited
	WindowSetShowing(bookWindowName .. "Page1EditText", leftPage ~= 0 and BookTemplate.OpenBooks[bookId].canEdit)

	-- do we have a valid left page (is not valid if it's the title) and we have the page content?
	if IsValidID(leftPage) and BookTemplate.OpenBooks[bookId].content[leftPage] then

		-- can the book be edited?
		if BookTemplate.OpenBooks[bookId].canEdit then

			-- set the text into the page textbox
            TextEditBoxSetText(bookWindowName .. "Page1EditText", BookTemplate.OpenBooks[bookId].content[leftPage])

		else -- set the text into the page label
			LabelSetText(bookWindowName .. "Page1Text", BookTemplate.OpenBooks[bookId].content[leftPage])
		end
	end

	-- right page ID
	local rightPage = BookTemplate.GetRightPageID(bookId)

	-- do we have a valid right page (is invalid if it's over the cap of pages - so nil) and we have the page content?
	if IsValidID(rightPage) and BookTemplate.OpenBooks[bookId].content[rightPage] then

		-- can the book be edited?
		if BookTemplate.OpenBooks[bookId].canEdit then

			-- set the text into the page textbox
            TextEditBoxSetText(bookWindowName .. "Page2EditText", BookTemplate.OpenBooks[bookId].content[rightPage])

		else -- set the text into the page label
			LabelSetText(bookWindowName .. "Page2Text", BookTemplate.OpenBooks[bookId].content[rightPage])
		end
	end
end

function BookTemplate.PageUp()

	-- get the current book ID
    local bookId = WindowGetId(WindowUtils.GetActiveDialog())

	-- get the current book window name
    local bookWindowName = WindowUtils.GetActiveDialog()

	-- get the current left page ID
	local currLeftPage = BookTemplate.GetLeftPageID(bookId)

	-- are there more pages after this one?
	if currLeftPage + 2 <= BookTemplate.OpenBooks[bookId].numPages then

		-- can the book be modified?
		if BookTemplate.OpenBooks[bookId].canEdit then

			-- is the current left page the title page?
			if currLeftPage == 0 then

				-- save the book title
				BookTemplate.EnterTitle(bookId)
			end

			-- save the current page text
      		BookTemplate.StoreText(bookId)
    	end

		-- increase the left page index
		BookTemplate.OpenBooks[bookId].showingPages[1] = BookTemplate.OpenBooks[bookId].showingPages[1] + 2

		-- increase the right page index
		BookTemplate.OpenBooks[bookId].showingPages[2] = BookTemplate.OpenBooks[bookId].showingPages[2] + 2

		-- show the next page button if it's not the last page
		WindowSetShowing(bookWindowName .. "PageUpButton", currLeftPage + 2 < BookTemplate.OpenBooks[bookId].numPages)

		-- show the previous page button
		WindowSetShowing(bookWindowName .. "PageDownButton", true)

		-- update the current page numbers
		BookTemplate.UpdatePageNumbers(bookId)

		-- update the pages text
		BookTemplate.SetPagesText(bookId)
	end
end

function BookTemplate.PageDown()

    -- get the current book ID
    local bookId = WindowGetId(WindowUtils.GetActiveDialog())

	-- get the current book window name
    local bookWindowName = WindowUtils.GetActiveDialog()

	-- get the current left page ID
	local currLeftPage = BookTemplate.GetLeftPageID(bookId)

	-- is this NOT the first page?
	if currLeftPage - 2 >= 0 then

		-- can the book be modified?
		if BookTemplate.OpenBooks[bookId].canEdit then

			-- save the current page text
      		BookTemplate.StoreText(bookId)
    	end

		-- decrease the left page index
		BookTemplate.OpenBooks[bookId].showingPages[1] = BookTemplate.OpenBooks[bookId].showingPages[1] - 2

		-- decrease the right page index
		BookTemplate.OpenBooks[bookId].showingPages[2] = BookTemplate.OpenBooks[bookId].showingPages[2] - 2

		-- show the next page button
		WindowSetShowing(bookWindowName .. "PageUpButton", true)

		-- show the previous page button if it's not the first page
		WindowSetShowing(bookWindowName .. "PageDownButton", currLeftPage - 2 > 0)

        -- update the current page numbers
		BookTemplate.UpdatePageNumbers(bookId)

		-- update the pages text
		BookTemplate.SetPagesText(bookId)
	end
end

function BookTemplate.GetLeftPageID(bookId)

	-- do we have a valid book ID?
	if not IsValidID(bookId) then
		return
	end

	return BookTemplate.OpenBooks[bookId].showingPages[1]
end

function BookTemplate.GetRightPageID(bookId)

	-- do we have a valid book ID?
	if not IsValidID(bookId) then
		return
	end

	return BookTemplate.OpenBooks[bookId].showingPages[2]
end

function BookTemplate.UpdatePageNumbers(bookId)

	-- do we have a valid book ID?
	if not IsValidID(bookId) then
		return
	end

    -- book window name
	local bookWindowName = "Book" .. bookId

	-- left page ID
	local leftPage = BookTemplate.GetLeftPageID(bookId)

	-- right page ID
	local rightPage = BookTemplate.GetRightPageID(bookId)

	-- is the left page the title page?
	if not IsValidID(leftPage) then

		-- remove the page number
		LabelSetText(bookWindowName .. "Page1Number", L"")	

	else -- set the page number
		LabelSetText(bookWindowName .. "Page1Number", towstring(leftPage))
	end

	-- is the right page a valid page?
	if not IsValidID(rightPage) then

		-- remove the page number
		LabelSetText(bookWindowName .. "Page2Number", L"")	

	else -- set the page number
		LabelSetText(bookWindowName .. "Page2Number", towstring(rightPage))
	end
end

function BookTemplate.EnterTitle(bookId)

	-- do we have a valid book ID? (is invalid when we press enter and we need to get it from the active window)
	if not IsValidID(bookId) then
		
		-- get the book ID
		bookId = WindowGetId(WindowUtils.GetActiveDialog())
	end

	-- can the book be modified?
	if not BookTemplate.OpenBooks[bookId].canEdit then
		return
	end
	
    -- book window name
	local bookWindowName = "Book" .. bookId

	-- title window name
    local bookTitleEditBoxName = bookWindowName .. "TitlePage"
    
	-- get the book new title
    BookTemplate.OpenBooks[bookId].title = TextEditBoxGetText(bookTitleEditBoxName .. "EditTitle") or L""

	-- get the new author name
	BookTemplate.OpenBooks[bookId].author = TextEditBoxGetText(bookTitleEditBoxName .. "EditAuthor") or L""

	-- remove the focus from the title and author textbox
    WindowAssignFocus(bookWindowName .. "TitlePageEditTitle", false)
	WindowAssignFocus(bookWindowName .. "TitlePageEditAuthor", false)

	-- send the new author and title to the server to be saved
	GumpManagerSendAuthorTitle(bookId, BookTemplate.OpenBooks[bookId].title, BookTemplate.OpenBooks[bookId].author)
end

function BookTemplate.StoreText(bookId)

	-- do we have a valid book ID?
	if not IsValidID(bookId) then
		return
	end

	-- can the book be modified?
	if not BookTemplate.OpenBooks[bookId].canEdit then
		return
	end

    -- book window name
	local bookWindowName = "Book" .. bookId

	-- default line break
	local lineBreak = L"\r\n"

	-- left page ID
	local leftPage = BookTemplate.GetLeftPageID(bookId)

	-- right page ID
	local rightPage = BookTemplate.GetRightPageID(bookId)

	-- get the left page text
    local leftPageText = TextEditBoxGetText(bookWindowName .. "Page1EditText") or L""

	-- get the right page text
	local rightPageText = TextEditBoxGetText(bookWindowName .. "Page2EditText") or L""

	-- data to send to the server
	local pageText = {}
    local pageNums = {}

	-- is this the first page?
	if leftPage == 0 then

		-- we send only the right page id
		pageNums[1] = rightPage

		-- we send only the right page text
		pageText[1] = rightPageText

		-- store the new page text
		BookTemplate.OpenBooks[bookId].content[rightPage] = rightPageText

	else -- we have both pages
		
		-- we send left and right page ID
		pageNums[1] = leftPage
        pageNums[2] = rightPage

		-- we send left and right page text
        pageText[1] = leftPageText
        pageText[2] = rightPageText

		-- store the new pages text
		BookTemplate.OpenBooks[bookId].content[leftPage] = leftPageText
		BookTemplate.OpenBooks[bookId].content[rightPage] = rightPageText
	end
    
	-- send the new pages text to the server to be saved
	GumpManagerSendBookPages(bookId, pageNums, pageText)
end

function BookTemplate.SaveToFile(bookId)

	-- is the book logging active?
	if Interface.Settings.ToggleBookLog then
		
		-- clean up the book title so it will work as a file name
		local booktitle = BookTemplate.CleanBookFileName(BookTemplate.OpenBooks[bookId].title)

		-- file name for the book
		local filename = "logs/Books/" .. "[" .. bookId .. "] " .. tostring(booktitle) .. ".txt"

		-- default line break
		local lineBreak = L"\r\n"

		-- initialize the text to write in the log file
		local bookText = L"-"

		-- add a line at the beginning of the text file
		bookText = wstring.appendWithSeparator(bookText, L"------------------------------------", lineBreak)
		
		-- add the book title
		bookText = wstring.appendWithSeparator(bookText, GetStringFromTid(1155271) .. L" " .. BookTemplate.OpenBooks[bookId].title, lineBreak) -- Title:

		-- add the book author
		bookText = wstring.appendWithSeparator(bookText, GetStringFromTid(1158027) .. L" " .. BookTemplate.OpenBooks[bookId].author, lineBreak) -- Author:

		-- add a line to separate the title/author from the book text
		bookText = wstring.appendWithSeparator(bookText, L"------------------------------------" .. lineBreak, lineBreak)

		-- scan all the book pages to store the text
		for _, pageText in pairsByIndex(BookTemplate.OpenBooks[bookId].content) do

			-- add the current page to the complete book text
			bookText = wstring.appendWithSeparator(bookText, pageText, L"")
		end

		-- replace the "enter" character with a line breaker
		bookText = wstring.gsub(bookText, wstring.char(10), lineBreak)

		-- save the book to file
		CreateTextFile(filename, bookText)
	end
end

function BookTemplate.CleanBookFileName(title)
	
	-- do we have a valid title?
	if not IsValidWString(title) then
		return L""
	end

	-- list of all the illegal characters for a file name
	local illegalPath = { L"/", L"<", L">", L"\\", L"\:", L"?", L"*", L"|", L"\"" }

	-- scan all the illegal characters
	for i = 1, #illegalPath do

		-- remove the illega character from the title
		title = wstring.gsub(title, illegalPath[i], L"")
	end

	return title
end

function BookTemplate.UpdateTextures(bookWindowName)

	-- initialize the texture size variables
	local xSize, ySize

	-- set texture scale
	local scale = 1.3

	--------- BACKGROUND TEXTURE ---------

	-- get the texture name and size
	texture, xSize, ySize = RequestGumpArt(510)

	-- update the book dimensions
	WindowSetDimensions(bookWindowName, xSize * scale, ySize * scale)

	-- update the background image dimensions
	WindowSetDimensions(bookWindowName .. "LegacyBook", xSize * scale, ySize * scale)

	-- set the background image
	DynamicImageSetTexture(bookWindowName .. "LegacyBook", texture, 0, 0)

	-- set the background image scale
	DynamicImageSetTextureScale(bookWindowName .. "LegacyBook", scale)

	--------- PREVIOUS PAGE TEXTURE ---------

	-- get the texture name and size
	texture, xSize, ySize = RequestGumpArt(511)

	-- fix the size
	xSize = xSize - 1
	ySize = ySize - 2

	-- update the button dimensions
	WindowSetDimensions(bookWindowName .. "PageDownButton", xSize * scale, ySize * scale)

	-- set the button textures
	ButtonSetTexture(bookWindowName .. "PageDownButton", Button.ButtonState.NORMAL, texture, 0, 0)
	ButtonSetTexture(bookWindowName .. "PageDownButton", Button.ButtonState.HIGHLIGHTED, texture, 0, 0)
	ButtonSetTexture(bookWindowName .. "PageDownButton", Button.ButtonState.PRESSED, texture, 0, 0)
	ButtonSetTexture(bookWindowName .. "PageDownButton", Button.ButtonState.PRESSED_HIGHLIGHTED, texture, 0, 0)
		
	--------- NEXT PAGE TEXTURE ---------

	-- get the texture name and size
	texture, xSize, ySize = RequestGumpArt(512)

	-- fix the size
	ySize = ySize - 4

	-- update the button dimensions
	WindowSetDimensions(bookWindowName .. "PageUpButton", xSize * scale, ySize * scale)

	-- set the button textures
	ButtonSetTexture(bookWindowName .. "PageUpButton", Button.ButtonState.NORMAL, texture, 0, 0)
	ButtonSetTexture(bookWindowName .. "PageUpButton", Button.ButtonState.HIGHLIGHTED, texture, 0, 0)
	ButtonSetTexture(bookWindowName .. "PageUpButton", Button.ButtonState.PRESSED, texture, 0, 0)
	ButtonSetTexture(bookWindowName .. "PageUpButton", Button.ButtonState.PRESSED_HIGHLIGHTED, texture, 0, 0)
end