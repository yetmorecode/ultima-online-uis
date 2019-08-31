
-- NOTE: This file is doccumented with NaturalDocs style comments. All comments begining with "--#' will
-- be included in the output.

------------------------------------------------------------------------------------------------------------------------------------------------
--# Title: String Utils
--#     This file contains string manipulation functions
------------------------------------------------------------------------------------------------------------------------------------------------

StringUtils = {}

StringUtils.Numbers = { L"0", L"1", L"2", L"3", L"4", L"5", L"6", L"7", L"8", L"9" }

----------------------------------------------------------------
-- String Manipulation Functions that are not defined in lua.
----------------------------------------------------------------

function wstring.setChar(str, charID, newChar)
	return (L"%s%s%s"):format(str:sub(1, charID - 1), newChar, str:sub(charID + 1))
end

function string.setChar(str, charID, newChar)
	return ("%s%s%s"):format(str:sub(1, charID - 1), newChar, str:sub(charID + 1))
end

function wstring.getChar(str, charID)

	-- if the string is invalid we can return nil
	if not IsValidWString(str) then
		return nil
	end
	
	return wstring.sub(str, charID, charID)
end

function string.getChar(str, charID)

	-- if the string is invalid we can return nil
	if not IsValidString(str) then
		return nil
	end

	return string.sub(str, charID, charID)
end

function string.appendWithSeparator(str, str2, separator)

	-- if the separator to use is nil or invalid, we set it to a empty value
	if not separator then
		separator = ""
	end

	-- if the string to append is nil or invalid, we  set it to a empty value
	if not IsValidString(str2) then
		str2 = ""
	end

	-- do we have something inside the string?
	if not IsValidString(str) then
		
		-- if the string is empty, we just put the second string inside
		str = str2

	else -- there is something inside the string already
		str = str .. separator .. str2
	end

	return str
end

function wstring.appendWithSeparator(str, str2, separator)

	-- if the separator to use is nil or invalid, we set it to a empty value
	if not separator then
		separator = L""
	end

	-- if the string to append is nil or invalid, we  set it to a empty value
	if not IsValidWString(str2) then
		str2 = L""
	end

	-- do we have something inside the string?
	if not IsValidWString(str) then
		
		-- if the string is empty, we just put the second string inside
		str = str2

	else -- there is something inside the string already
		str = str .. separator .. str2
	end

	return str
end

function string.removePatterns(str)

	-- escape all the magic characters from the string
	return str:gsub("[%(%)%.%+%-%*%?%[%]%^%$%%]", "%%%1")
end

function wstring.removePatterns(str)
	
	-- escape all the magic characters from the string
	return str:gsub(L"[%(%)%.%+%-%*%?%[%]%^%$%%]", L"%%%1")
end

function string.restorePatterns(str)

	-- remove the escape from the magic characters
	return str:gsub("[%%]", "%%%%")
end

function wstring.restorePatterns(str)

	-- remove the escape from the magic characters
	return str:gsub(L"[%%]", L"%%%%")
end

function string.split(inString, delimiter, includeEmptyLines)

	-- initialize the strings list
	local list = {}

	-- starting position
	local pos = 1
  
    -- if delimiter is empty, use space as a default...
	if (delimiter == nil or delimiter == "") then 
		delimiter = " "
	end
    
	-- loop until we're done
	while 1 do

		-- search for the delimiter from the current position in the string
		local first, last = string.find(inString, delimiter, pos, true)
    
		-- found?
		if first then

			-- clean the word
			local word = string.trim(string.sub(inString, pos, first - 1))

			-- do we have a valid word?
			if IsValidString(word) or includeEmptyLines then

				-- add the string to the table
				table.insert(list, word)
			end

			-- increase the current position in the string
			pos = last + 1

		else -- this was the last one

			-- clean the word
			local word = string.trim(string.sub(inString, pos))

			-- do we have a valid word?
			if IsValidString(word) or includeEmptyLines then

				-- add the string to the table
				table.insert(list, word)
			end

			break
		end
	end
  
	return list
end

function wstring.split(inString, delimiter, includeEmptyLines)

    -- initialize the strings list
	local list = {}

	-- starting position
	local pos = 1
  
    -- If delimiter is empty, use space as a default...
	if (delimiter == nil or delimiter == L"") then 
		delimiter = L" "
	end

	-- loop until we're done
	while 1 do

		-- search for the delimiter from the current position in the string
		local first, last = wstring.find(towstring(inString), towstring(delimiter), pos, true)
    
		-- found?
		if first then

			-- clean the word
			local word = wstring.trim(wstring.sub(towstring(inString), pos, first - 1))

			-- do we have a valid word?
			if IsValidWString(word) or includeEmptyLines then

				-- add the string to the table
				table.insert(list, word)
			end

			-- increase the current position in the string
			pos = last + 1

		else  -- this was the last one

			-- clean the word
			local word = wstring.trim(wstring.sub(towstring(inString), pos))

			-- do we have a valid word?
			if IsValidWString(word) or includeEmptyLines then

				-- add the string to the table
				table.insert(list, word)
			end

			break
		end
	end
  
	return list
end

function string.trim(str)
	
	-- do we have no string?
	if not str then
		return
	end

	-- is this a wstring instead of a string?
	if type(str) == "wstring" then

		-- convert to string
		str = tostring(str)
	end

	-- search for spaces at the beginning of the string
	s1 = str:find("[^%s]")

	-- if we have null we have no spaces to remove
	if not s1 then 
		return "" 
	end

	-- search for spaces at the end of the string
	s2 = str:find("%s*$") or 0

	-- remove the spaces at the beginning and the end of the string
	return str:sub(s1, s2 - 1)
end

function wstring.trim(str)
	
	-- do we have no string?
	if not str then
		return
	end

	-- is this a string instead of wstring?
	if type(str) == "string" then

		-- convert to wstring
		str = towstring(str)
	end

	-- search for spaces at the beginning of the string
	s1 = str:find(L"[^%s]")

	-- if we have null we have no spaces to remove
	if not s1 then 
		return L"" 
	end

	-- search for spaces at the end of the string
	s2 = str:find(L"%s*$") or 0

	-- remove the spaces at the beginning and the end of the string
	return str:sub(s1, s2 - 1)
end

function string.titleCase(str)
	
	-- do we have no string?
	if not str then
		return
	end

	-- is this a wstring instead of a string?
	if type(str) == "wstring" then

		-- convert to string
		str = tostring(str)
	end

	-- is the client in english? 
	if SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU then
		
		-- decapitalize the string completely
		str = string.lower(str)

		-- capitalize the first letter of every word
		str = str:gsub("(%a)([%w_']*)", function(first, rest) return first:upper() .. rest:lower() end)

		return str

	else -- oriental languages have no need for this...
		return str
	end
end

function wstring.titleCase(str)

	-- do we have no string?
	if not str then
		return
	end

	-- is this a string instead of wstring?
	if type(str) == "string" then

		-- convert to wstring
		str = towstring(str)
	end
	
	-- is the client in english? 
	if SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU then

		-- decapitalize the string completely
		str = string.lower(tostring(str))

		-- capitalize the first letter of every word (for some reason the pattern doesn't work in wstring... client bug?)
		str = str:gsub("(%a)([%w_']*)", function(first, rest) return first:upper() .. rest:lower() end)

		return towstring(str)

	else -- oriental languages have no need for this...
		return str
	end
end

function PercentValueToNumber(str)

	-- do we have a valid wstring or string?
	if not IsValidWString(str) and not IsValidString(str) then
		return str
	end

	-- is this not a string?
	if type(str) ~= "string" then

		-- convert to string
		str = tostring(str)
	end

	-- remove the percent from the string
	str = string.gsub(str, "%%", "")

	-- convert the string to number
	return tonumber(str)
end

function SecondsValueToNumber(str)

	-- do we have a valid wstring or string?
	if not IsValidWString(str) and not IsValidString(str) then
		return str
	end

	-- is this not a string?
	if type(str) ~= "string" then

		-- convert to string
		str = tostring(str)
	end

	-- remove the "s" from the string
	str = string.gsub(str, "s", "")

	-- convert the string to number
	return tonumber(str)
end

function FormatProperly(str, parseroman)

	-- do we have a valid wstring?
	if not IsValidWString(str) then
		return L""
	end

	-- is the client in english? oriental languages have no need for this...
	if SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU then
		return str
	end

	-- by default we parse the roman numerals
	if not parseroman then
		parseroman = true
	end
	
	-- convert the string in title case
	str = wstring.titleCase(str)
	
	-- do we have to parse roman numerals?
	if parseroman == true then
	
		-- split the string by spaces
		local splitted = wstring.split(str, L" ")
	
		-- final string to return
		local final = L""

		-- scan all the words we have splitted
		for i, s in pairsByIndex(splitted) do

			-- flag that indiccat that a word is a roman numeral
			local isRoman = true

			-- scan all the letters of the word
			for i = 1, wstring.len(s) do

				-- get the letter to parse
				local letter = wstring.upper(wstring.sub(s, i, i))

				-- is this letter a roman numeral?
				if 	letter ~= "I" and
					letter ~= "V" and
					letter ~= "X" and
					letter ~= "L" and
					letter ~= "C" and
					letter ~= "D" and
					letter ~= "M" then

					-- flag as not roman
					isRoman = false

					-- we can get out...
					break
				end
			end
			
			-- is the word a roman numeral?
			if isRoman then

				-- make the word all upper case
				s = wstring.upper(s)
			end

			-- append the word to the final string
			final = wstring.appendWithSeparator(final, s, L" ")
		end
		
		-- do we have a valid final sentence?
		if IsValidWString(final) then
			return final
		end
	end
	
	return str
end

function AddLeadingZero(text)
	
	-- convert the text to number
	local num = tonumber(text)

	-- make sure the text is a number
	if not num then
		return text
	end

	-- add a 0 if it's less than 10
	if num < 10 then
		return "0" .. num

	else -- return the number as it is...
		return num
	end
end

function AddLeadingSpaces(text)
	
	-- convert the text to number
	local num = tonumber(text)

	-- make sure the text is a number
	if not num then
		return text
	end

	-- add 2 spaces if it's less than 10
	if num < 10 then
		return L"  " .. num
	
	-- add a space if it's less than 100
	elseif num < 100 then
		return L" " .. num

	else -- return the number as it is...
		return towstring(num)
	end
end

function GetClockString()

	-- since this can be called BEFORE the interface has started, we get the date separately
	local Timestamp, YYYY, MM, DD, h, m, s = GetCurrentDateTime()

	-- compile the clock string
	local clockstring = AddLeadingZero(DD) .. "-" .. AddLeadingZero(MM + 1) .. "-" .. AddLeadingZero(1900 + YYYY) .. " " .. AddLeadingZero(h) .. "-" .. AddLeadingZero(m) .. "-" .. AddLeadingZero(s)

	return clockstring
end

function GetTokensFromString(text, tid)

	-- do we have a valid string, tid and token id?
	if not IsValidWString(text) or not IsValidID(tid) then
		return L""
	end
	
	-- get the tokens count
	local totalTokens = CountTokensOnString(GetStringFromTid(tid))

	-- convert the wstring in string
	local tidString = wstring.lower(ReplaceTokens(GetStringFromTid(tid), {L""}))

	-- creating an array with all the words in the tid
	local tidWords = wstring.split(tidString, L" ")
	
	-- copying the original text
	local cleanText = wstring.lower(text)

	-- creating an array with all the words in the text
	local textWords = wstring.split(cleanText, L" ")

	-- clear the text
	cleanText = L""

	-- parse all the words contained in the text string
	for i, word in pairsByIndex(textWords) do
		
		-- does the TID words array contains this word?
		if table.contains(tidWords, word) then
			continue
		end

		-- append this word
		cleanText = wstring.appendWithSeparator(cleanText, word, L"|")
	end
	
	-- convert what's remaining fromt he original text into string
	cleanText = wstring.trim(cleanText)
	
	-- splitting the remaining text in an array, and all the elements will be the tokens of the TID
	return wstring.split(cleanText, L"|")
end

function CountTokensOnString(text)

	-- do we have a valid text?
	if not IsValidWString(text) then
		return 0
	end

	-- count the ~ instances in the string
	local _, count = wstring.gsub(text, L"~", L"")

	-- since a token is like ~1_name~ the half of the amount of ~ is a token
	count = math.floor(count / 2)
	
	-- final tokens count
	local finalCount = 0

	-- scan all possible tokens
	for i = 1, count do
		
		-- each token has a number that indicate the instance, and since there can be multiple instances of the same tokens, we need to see what's the exact count.
		if wstring.find(text, L"~" .. i, 1, true) then

			-- increase the count
			finalCount = finalCount + 1

		else -- since this one doesn't exist, there are no more
			break
		end
	end

	return finalCount
end

function Knumber(num, places)
	
	-- convert the number to tumber
	num = tonumber(num)

	-- initialize the return value
	local ret = 0

	-- initialize the format string, and if there are no decimals specified, we set to 1 by default
	local placeValue =(L"%%.%df"):format(places or 1)

	-- is the number nil? conversion failed
	if not num then
		ret = 0
    
	elseif num >= 1000000000000 then
		ret = placeValue:format(num / 1000000000000) .. L"T" -- trillion
   
	elseif num >= 1000000000 then
		ret = placeValue:format(num / 1000000000) ..L "B" -- billion
   
	elseif num >= 1000000 then
		ret = placeValue:format(num / 1000000) .. L"M" -- million
    
	elseif num >= 1000 then
		ret = placeValue:format(num / 1000) .. L"K" -- thousand
    
	else -- convert the number to wstring
		ret = towstring(num) -- hundreds
	end

	-- if it's .0 we don't need the decimal
	ret = wstring.gsub(ret, L"%.0", L"")

	-- return the formatted number
	return ret
end

-- Convert bytes to human readable format
function bytesToSize(bytes)

	-- decimal precision
	local precision = 2

	-- calculate the bytes per type of unit
	local kilobyte = 1024
	local megabyte = kilobyte * 1024
	local gigabyte = megabyte * 1024
	local terabyte = gigabyte * 1024

	-- less than a kb? we show bytes
	if ((bytes >= 0) and(bytes < kilobyte)) then
		return bytes .. " Bytes"

	-- less than a MB? we show KB
	elseif ((bytes >= kilobyte) and(bytes < megabyte)) then
		return math.round(bytes / kilobyte, precision) .. ' KB'

	-- less than a GB? we show MB
	elseif ((bytes >= megabyte) and(bytes < gigabyte)) then
		return math.round(bytes / megabyte, precision) .. ' MB'

	-- less than TB? we show GB
	elseif ((bytes >= gigabyte) and(bytes < terabyte)) then
		return math.round(bytes / gigabyte, precision) .. ' GB'

	-- a TB or more? we show TB
	elseif (bytes >= terabyte) then
		return math.round(bytes / terabyte, precision) .. ' TB'

	else -- if we got here, something weird happened...
		return bytes .. ' B'
	end
end

function StripNameTitle(name)
	
	-- do we have a valid name?
	if not IsValidWString(name) then
		return name
	end

	-- determine if the name has a tag
	local taglessName, nameHasTag = RemoveNameTag(name)

	-- do we have a valid name?
	if not IsValidWString(taglessName) then
		return name
	end

	-- clear the spaces from the name
	local fixedName = wstring.trim(wstring.lower(taglessName))

	-- do we have a valid name?
	if not IsValidWString(fixedName) then
		return name
	end

	-- remove bad patterns
	fixedName = wstring.removePatterns(fixedName)
	
	-- find " the ", which indicates the title begins
	local titleStart = wstring.find(fixedName, L" the ", 1, true)

	-- is this an evil mage lord?
	if CreaturesDB.IsEvilMageLord(name) then

		-- the title start after the comma
		titleStart = wstring.find(fixedName, L", ", 1, true)
	end

	-- did we find "the"?
	if titleStart then

		-- get the title from the name
		fixedName = wstring.sub(fixedName, titleStart)

		-- remove the title from the name
		name = wstring.gsub(wstring.lower(taglessName), fixedName, L"")
	end

	return FormatProperly(wstring.trim(name))
end

function RemoveNameTag(name)
	
	-- do we have a valid name?
	if not IsValidWString(name) then
		return name, false
	end

	-- find the square brackets
	if wstring.find(name, L"[", 1, true) then

		-- get the name without the tag
		name = wstring.trim(wstring.sub(name, 1, wstring.find(name, L"[", 1, true) -1))

		return name, true
	end

	return name, false
end

function GetNameTitle(name)
	
	-- do we have a valid name?
	if not IsValidWString(name) then
		return name
	end

	-- determine if the name has a tag
	local taglessName, nameHasTag = RemoveNameTag(name)

	-- do we have a valid name?
	if not IsValidWString(taglessName) then
		return name
	end

	-- clear the spaces from the name
	local fixedName = wstring.trim(wstring.lower(taglessName))

	-- do we have a valid name?
	if not IsValidWString(fixedName) then
		return name
	end

	-- remove bad patterns
	fixedName = wstring.removePatterns(fixedName)
	
	-- find " the ", which indicates the title begins
	local titleStart = wstring.find(fixedName, L" the ", 1, true)

	-- is this an evil mage lord?
	if CreaturesDB.IsEvilMageLord(name) then

		-- the title start after the comma
		titleStart = wstring.find(fixedName, L", ", 1, true)
	end

	local title = L""

	-- did we find "the"?
	if titleStart then

		-- remove the name and we have the title
		title = wstring.sub(fixedName, titleStart)
	end

	return FormatProperly(wstring.trim(title))
end

-- this function (used in buff/debuff) shows only minutes/hours/secons with the >/< symbol
function StringUtils.CountDownSeconds(sSeconds)

	-- count how many minutes we have
	local min = math.floor(sSeconds / 60)

	-- do we have more than 60 minutes?
	if min > 60 then

		-- initialize the prefix
		local prefix = ""

		-- do we have more than 1 hour?
		if ((min / 60) - math.floor(min / 60) > 0) then

			-- add the prefix >
			prefix = ">"
		end

		-- count how many hours we have
		local h = math.floor(min / 60)

		-- show >xh
		timer = towstring(prefix .. string.format("%.0f", h) .. "h")

	-- do we have more than 60s?
	elseif min > 0 then

		-- initialize the prefix
		local prefix = ""

		-- do we have more than 1 minute?
		if (sSeconds -(min * 60) > 0) then

			-- add the prefix >
			prefix = ">"
		end

		-- show >xm
		timer = towstring(prefix .. string.format("%.0f", min) .. "m")

	else -- show the plain amount of seconds
		timer = towstring(string.format("%.0f", sSeconds) .. "s")
	end

	return timer
end

-- this function (used in hotbars) shows the time as: "mm : ss" or just the hours
function StringUtils.SecondsCooldown(sSeconds)

	-- convert the seconds in number (in case they are string)
	local nSeconds = tonumber(sSeconds)

	-- do we have a valid amount of seconds?
	if not IsValidID(sSeconds) then
		return towstring(sSeconds)
	end

	-- calculate the amount of hours
	local nHours = string.format("%02.f", math.floor(nSeconds / 3600))

	-- calculate the amount of minutes
	local nMins = string.format("%02.f", math.floor(nSeconds / 60 -(nHours * 60)))

	-- calculate the amount of seconds (remaining after we took off minutes and hors)
	local nSecs = string.format("%02.f", math.floor(nSeconds - nHours * 3600 - nMins * 60))

	-- do we have hours?
	if math.floor(nSeconds / 3600) > 0 then
		
		-- in this case we only show the amount of hours (or the string will be too long
		return towstring(nHours .. "h")

	-- do we have minutes?
	elseif math.floor(nSeconds / 60 - (nHours * 60)) > 0 then

		-- show mm : ss
		return towstring(nMins .. ":".. nSecs)

	else -- show only the seconds
		return towstring(math.floor(sSeconds) .. "s")
	end
end

-- this function shows the extended clock timer in 2 ways:
-- * hh : mm : ss (not extended)
-- * h hours, m minutes, s seconds. (extended)
function StringUtils.SecondsToClock(sSeconds, extended)

	-- convert the seconds in number (in case they are string)
	local nSeconds = tonumber(sSeconds)

	-- do we have a valid amount of seconds?
	if not IsValidID(sSeconds) then
		
		-- do we have the extended mode?
		if extended then
			return "0 seconds."

		else -- compact mode
			return "00 : 00: 00"
		end
	end

	-- calculate the amount of hours
	local nHours = string.format("%02.f", math.floor(nSeconds / 3600))

	-- calculate the amount of minutes
	local nMins = string.format("%02.f", math.floor(nSeconds / 60 -(nHours * 60)))

	-- calculate the amount of seconds (remaining after we took off minutes and hors)
	local nSecs = string.format("%02.f", math.floor(nSeconds - nHours * 3600 - nMins * 60))

	-- is this the compact mode?
	if not extended then

		-- return the time formatted: hh : mm : ss 
		return nHours .. " : " .. nMins .. " : " .. nSecs

	else -- extended mode

		-- recalculate hours minutes and seconds without rounding
		nHours = math.floor(nSeconds / 3600)
		nMins = math.floor(nSeconds / 60 -(nHours * 60))
		nSecs = math.floor(nSeconds - nHours * 3600 - nMins * 60)
		
		-- initialize the final string
		local final = ""

		-- do we have hours?
		if nHours > 0 then

			-- this variable is for hourS plural
			local Hs = ""

			-- if we have more than 1 hour we add the plural S
			if nHours > 1 then
				Hs = "s"
			end
			
			-- add the hours to the final string
			final = nHours .. " hour" .. Hs

			-- do we have minutes?
			if nMins > 0 then

				-- reset the plural variable
				Hs = ""

				-- if we have more than 1 minutes we add the plural S
				if nMins > 1 then
					Hs = "s"
				end

				-- append the minutes
				final = string.appendWithSeparator(final, nMins .. " minute" .. Hs, ", ")

				-- do we have seconds?
				if nSecs > 0 then

					-- reset the plural variable
					Hs = ""

					-- if we have more than 1 seconds we add the plural S
					if nSecs > 1 then
						Hs = "s"
					end

					-- append the seconds
					final = string.appendWithSeparator(final, nSecs .. " second" .. Hs, ", ")
				end

			-- do we have seconds?
			elseif nSecs > 0 then

				-- reset the plural variable
				Hs = ""

				-- if we have more than 1 seconds we add the plural S
				if nSecs > 1 then
					Hs = "s"
				end

				-- append 0 minutes and the seconds
				final = string.appendWithSeparator(final, "0 minute, " .. nSecs .. " second" .. Hs, ", ")
			end

		-- do we have minutes?
		elseif nMins > 0 then
			
			-- reset the plural variable
			Hs = ""

			-- if we have more than 1 minutes we add the plural S
			if nMins > 1 then
				Hs = "s"
			end

			-- append the minutes
			final = string.appendWithSeparator(final, nMins .. " minute" .. Hs, ", ")

			-- do we have seconds?
			if nSecs > 0 then

				-- reset the plural variable
				Hs = ""

				-- if we have more than 1 seconds we add the plural S
				if nSecs > 1 then
					Hs = "s"
				end

				-- append the seconds
				final = string.appendWithSeparator(final, nSecs .. " second" .. Hs, ", ")
			end
		
		-- do we have seconds?
		elseif nSecs > 0 then

			-- reset the plural variable
			Hs = ""

			-- if we have more than 1 seconds we add the plural S
			if nSecs > 1 then
				Hs = "s"
			end

			-- append the seconds
			final = string.appendWithSeparator(final, nSecs .. " second" .. Hs, ", ")
		end

		return final
	end
end

-- Add commas to a number : i.e. 1000000 becomes 1,000,000
--
-- str needs to be a wstring 
-- returns a wstring
-- 
function StringUtils.AddCommasToNumber(str)
  
	-- convert the number in string
	local formatted = tostring(tonumber(str))

	-- loop until we're done adding commas
	while true do  
		
		-- format the string and count if we still need to go
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')

		-- if the count is 0, we have done
		if k == 0 then
			break
		end
	end

	-- return the formatted string converted to wstring
	return towstring(formatted)
end

----------------------------------------------------------------
-- String Util formating functions
----------------------------------------------------------------

function StringUtils.CountMatchingWords(string1, string2)    

	-- get the words of each string in a table (all in lower case)
	local firstBlock = wstring.split(wstring.lower(string1), L" ")
	local secondBlock = wstring.split(wstring.lower(string2), L" ")

	-- initialize the count
	local matchingWords = 0

	-- scan the words of the first string
	for _, word1 in pairsByIndex(firstBlock) do

		-- scan the words of the second string
		for _, word2 in pairsByIndex(secondBlock) do

			-- do we have 2 words matching?
			if word1 == word2 then

				-- increase the counter
				matchingWords = matchingWords + 1
			end
		end
	end

	return matchingWords
end
