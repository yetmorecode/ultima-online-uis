----------------------------------------------------------------
-- LuaUtils Global Variables
----------------------------------------------------------------    
LuaUtils = {}

----------------------------------------------------------------
-- LuaUtils Functions
----------------------------------------------------------------    

function multipleInitialize(value)

	-- initialize 30 variables with the same value
	return value, value, value, value, value, value, value, value, value, value, value, value, value, value, value, value, value, value, value, value, value, value, value, value, value, value, value, value, value, value
end

function inlineIf(cond, T, F)

	-- return one value of the other based on the given condition
	if cond then return T else return F end
end

function math.round(num, idp)

	-- round a number to a certain precision
	return tonumber(string.format("%." ..(idp or 0) .. "f", num))
end

function math.isINF(value)
	
	-- determine if the number is infinite
	return value == math.huge or value == -math.huge
end

function math.isNAN(value)

	-- determine if the number is "Not A Number"
	return value ~= value
end

function table.reverse(t)
	
	-- do we have a valid table?
	if not t then
		return
	end

	-- initialize a new table
	local newT = {}

	-- scan the old table
	for i = #t, 1, -1 do

		-- add to the bottom of the new table
		table.insert(newT, t[i])
	end

	return newT
end

function table.copy(t)

	-- do we have a valid table?
	if not t then
		return
	end
	
	-- initialize the output table
	local t2 = {}

	-- parse the original table
	for k, v in pairs(t) do

		-- copy the value to the output table
		t2[k] = v
	end

	return t2
end

function table.append(t1,t2)

	-- do we have a valid table?
	if not t1 then
		return
	end

	-- do we have a valid table to append?
	if not t2 then
		return t1
	end

	-- parse the second table
    for i, v in pairsByIndex(t2) do

		-- append the value at the bottom of the first table
		table.insert(t1, v)
    end

    return t1
end

function table.countElements(T, typeToCount)

	-- do we have a valid table?
	if not T then
		return 0
	end

	-- initialize the counter
	local count = 0

	-- scan the table
	for k, v in pairs(T) do 
		
		-- do we have a specific type to count and this elemenent is not of that type?
		if typeToCount and type(typeToCount) ~= type(k) then
			continue
		end

		-- increase the count of elements
		count = count + 1 
	end

	return count
end

function table.contains(T, value)

	-- do we have a valid table?
	if not T then
		return 0
	end

	-- scan the table
	for i, v in pairsByKeys(T) do

		-- is the value the same requested?
		if v == value then

			-- return that the element exist and the index of the element
			return true, i
		end
	end

	return false
end

function table.indexOf(T, value)

	-- do we have a valid table?
	if not T then
		return -1
	end

	-- scan the table
	for i, v in pairsByKeys(T) do

		-- is the value the same requested?
		if v == value then

			-- return the value index
			return i
		end
	end

	return -1
end

function table.removeDuplicates(T)

	-- do we have a valid table?
	if not T then
		return
	end

	-- initialize a temporary table to put the values in
	local tempTable = {}

	-- initialize the output table
	local finalTable = {}

	-- scan the table
	for i, v in pairsByIndex(T) do

		-- do we have this value in the temp table already?
		if not tempTable[v] then

			-- add the value to the temp table
			tempTable[v] = true

			-- add the value to the output table
			table.insert(finalTable, v)
		end
	end

	return finalTable
end

-- Convert a lua table into a lua syntactically correct string
function table.toString(tbl, useRoundBrackets)

	-- define the open and close brackets
	local openBrack = "{ "
	local closeBrack = " }"

	-- do we have to use round brackets?
	if useRoundBrackets then
		openBrack = "( "
		closeBrack = " )"
	end

	-- do we have a valid table?
	if not tbl then
		return openBrack .. closeBrack
	end

	-- is the table a table?
	if type(tbl) ~= "table" then
		return openBrack .. tostring(tbl) .. closeBrack
	end

	-- initialize the final string
    local result = openBrack

	-- scan the table values
	-- Check the key type (ignore any numerical keys - assume its an array)
    for k, v in pairs(tbl) do

        -- is the key a string?
        if type(k) == "string" then
            result = result.."[\""..k.."\"]".."="
        end

        -- if is a table, do a recursion until you reach the bottom of the table
        if type(v) == "table" then
            result = result..table_to_string(v)

		-- is the value a boolean?
        elseif type(v) == "boolean" then
            result = result..tostring(v)

		-- is the value a string?
		elseif type(v) == "string" then
			result = result .. "\"" .. v .. "\""

		-- is the value a wstring?
		elseif type(v) == "wstring" then
			result = result .. "L\"" .. tostring(v) .. "\""

        else -- any other values
            result = result .. v
        end

		-- put a comma to separate the values
        result = result .. ", "
    end

    -- Remove leading commas from the result
    if result ~= "" then
        result = result:sub(1, result:len()-2)
    end

    return result..closeBrack
end

-- create a table from a CSV file (the integrated client function doesn't work with custom files)
function table.fromCSV(fileName)
	
	-- do we have a valid file name?
	if not IsValidString(fileName) then
		return
	end

	-- read the file (MAKE SURE THE FILE IS ANSI)
	local text = LoadTextFile(fileName)

	-- does the file exist?
	if not text then
		return
	end

	-- initialize the final table
	local finalTable = {}

	-- remove the magic characters from the string
	text = string.removePatterns(tostring(text))

	-- split the file into line
	local records = string.split(text, "\r\n")
	
	-- get the headers for the table
	local headers = string.split(records[1], ",")
	
	-- scan all the records
	for i, line in pairsByIndex(records) do

		-- skip the first one (the headers)
		if i == 1 then
			continue
		end

		-- initialize the current data record for the table
		local record = {}

		-- get the record
		local lineData = string.split(string.gsub(line, "%%", ""), ",", true)
		
		-- does the line has less fields than we require?
		if #lineData < #headers then
			continue
		end

		-- scan all the headers to fill the fields
		for j, header in pairsByIndex(headers) do
			
			-- add the data to the record
			record[header] = lineData[j]
		end
		
		-- insert the record into the table
		table.insert(finalTable, record)
	end

	return finalTable
end

-- pairs the table by the index (the index MUST be progressive, otherwise use pairsByKeys).
function pairsByIndex(t)

	-- make sure we have a table
	if not t or type(t) ~= "table" then
		return
	end

	-- iterator variable
	local i = 0 

	-- if the table has the index 0, we start from there, otherwise it starts from 1
	if t[0] then
		i = -1
	end
	
	-- iterator function
    local iter = function ()   

		-- increase the index
		i = i + 1

		-- get the table record
		local v = t[i]

		-- do we have the record?
		if v then 
			return i, v 
		end
	end

	return iter
end

-- pairs the table by the index (assuming the index is always of the same type, if the index is of mixed types, just use pairs).
function pairsByKeys(t, f)
	
	-- make sure we have a table
	if not t then
		return
	end

	-- create a temporary table for the sorting
    local a = {}

	-- flag that indicates the table has mixed keys
    local mixedValues = false

	-- last type name
    local lastType = ""

	-- parse the table
    for n in pairs(t) do

		-- add the key into the temporary table
        table.insert(a, n)

		-- is the type of this key different from the last one?
        if type(n) ~= lastType and lastType ~= "" then

			-- flag that we have mixed values
			mixedValues = true
		end

		-- save the type of the current key
		lastType = type(n)
    end

	-- do we have all the keys of the same type?
    if not mixedValues then

		-- sort the table
		table.sort(a, f)
	end

	-- iterator variable
    local i = 0      

	-- iterator function
    local iter = function ()   

		-- increase the index
        i = i + 1

		-- is the current element of the temp table nil?
        if a[i] == nil then

			-- we reached the bottom of the table
            return nil

        else -- return key and value
            return a[i], t[a[i]]
        end
    end

    return iter
end

function table.getTableName(tbl)

	-- scan the main _G table
	for k, v in pairs(_G) do

		-- is this value a table?
		if type(v) == "table" then

			-- scan the sub-table (we use another function to avoid recursion that could loop forever)
			local found = getTableNameSub(v, tbl)

			-- did we found the name on a sub-table?
			if found then

				-- is the current table the main table?
				if k == "_G" then

					-- return only the table name (_G is always intrinsic)
					return found

				else -- return the root "." rest of the sub-structure
					return k .. "." .. found
				end
			end

		-- is this the table we're looking for?
		elseif v == tbl then

			-- return only the table name (_G is always intrinsic)
			return k
		end
	end

	-- not found
	return nil
end

function getTableNameSub(tbl, name)

	-- parse the sub table (NOT SUB-LEVELS)
	for k, v in pairs(tbl) do

		-- is the value the table we're looking for?
		if v == name then

			-- return the table name
			return k

		-- is the key the table we're looking for?
		elseif k == tbl then

			-- return the table name
			return k
		end
	end

	return nil
end

function generateAllFunctionsTable()

	-- scan the main _G table
	for k, v in pairs(_G) do

		-- is this a table?
		if type(v) == "table" then

			-- non-recursively scan the sub-table
			local found, stack = generateAllFunctionsTableSub(v)

			-- have we found something?
			if found then

				-- is the current table the main table?
				if k == "_G" then

					-- we can return only the function name
					Interface.AllFunctions[tostring(stack)] = found

				else -- return the function table . sub-structure
					Interface.AllFunctions[tostring(stack)] = k .. "." .. found
				end
			end

		-- is the key a function
		elseif type(k) == "function" then

			-- add the function to the table
			Interface.AllFunctions[tostring(v)] = k

		-- is the value a function?
		elseif type(v) == "function" then

			-- add the function to the table
			Interface.AllFunctions[tostring(v)] = k
		end
	end
end

function generateAllFunctionsTableSub(tbl)

	-- scan the sub table
	for k, v in pairs(tbl) do

		-- is the value a function?
		if type(v) == "function" then
			return k, v

		-- is the key a function?
		elseif type(k) == "function" then
			return k, v
		end
	end

	return nil
end

function getFunctionName(tbl)

	-- scan the main _G table
	for k, v in pairs(_G) do

		-- is the value a table?
		if type(v) == "table" then

			-- non-recursively scan the sub-table
			local found = getFunctionNameSub(v, tbl)

			-- did we found something?
			if found then

				-- is the current table the main table?
				if k == "_G" then

					-- return only the function name
					return found

				else -- build the function name with what we've found
					return k .. "." .. found
				end
			end

		-- is the key the function we're looking for?
		elseif k == tbl then
			return k

		-- is the value the function we're looking for?
		elseif v == tbl then
			return k
		end
	end

	return nil
end

function getFunctionNameSub(tbl, name)

	-- scan the sub table
	for k, v in pairs(tbl) do

		-- is the value what we're looking for?
		if v == name then
			return k

		-- is the key what we're looking for?
		elseif k == tbl then
			return k
		end
	end

	return nil
end

function colorCompare(color1, color2)

	-- do we have 2 table as parameters?
	if not type(color1) == "table" or not type(color2) == "table" then
		return false
	end

	-- does the rgb value of the 2 table match?
	if color1.r == color2.r and color1.g == color2.g and color1.b == color2.b then
		return true
	end

	return false
end

function GetDynamicVariableValue(variable)

	-- do we have a valid variable name?
	if not IsValidString(variable) then
		return
	end

	-- split the variable name to obtain all the structure
	local dotSplit = string.split(variable, ".")

	-- final variable pointer
	local value

	-- parse all the structure
	for i, name in pairsByIndex(dotSplit) do

		-- is this the first element?
		if i == 1 then

			-- build up the pointer from _G
			value = _G[name]

		-- is the current variable a value not nil and the current structure name is a number?
		elseif tonumber(name) and value[tonumber(name)] ~= nil then

			-- convert the structure name to number
			name = tonumber(name)

			-- let's go deep into the table with the number index
			value = value[tonumber(name)]

		else -- let's go deep into the table with this NON numeric index
			value = value[name]
		end
	end

	-- return the final structure
	return value
end

function SetDynamicVariableValue(variable, newValue)

	-- do we have a valid variable name?
	if not IsValidString(variable) then
		return
	end

	-- split the variable name to obtain all the structure
	local dotSplit = string.split(variable, ".")
	
	-- final variable pointer
	local value

	-- parse all the structure
	for i, name in pairsByIndex(dotSplit) do
		
		-- is the current structure level a number and the current pointer is not nil?
		if tonumber(name) and value[tonumber(name)] ~= nil then

			-- convert the structure name to number
			name = tonumber(name)
		end
		
		-- is this the first element?
		if i == 1 then

			-- build up the pointer from _G
			value = _G[name]
			
			-- is this the second last part of the structure?
			if i == #dotSplit - 1 then

				-- get the last part of the structure
				local lastName = dotSplit[#dotSplit]

				-- is the last part of the structure a number and the current pointer is not nil?
				if tonumber(lastName) and value[tonumber(lastName)] ~= nil then

					-- convert the structure name to number
					lastName = tonumber(lastName)
				end
				
				-- set the new value at the pointed variable
				value[lastName] = newValue

				-- we can get out
				return
			end

		-- is this the second last part of the structure?
		elseif i == #dotSplit - 1 then

			-- get the last part of the structure
			local lastName = dotSplit[#dotSplit]

			-- is the last part of the structure a number and the current pointer is not nil?
			if tonumber(lastName) and value[name][tonumber(lastName)] ~= nil then

				-- convert the structure name to number
				lastName = tonumber(lastName)
			end
			
			-- set the new value at the pointed variable
			value[name][lastName] = newValue

			-- we can get out
			return

		else -- let's go deep into the structure...
			value = value[name]
		end
	end
end