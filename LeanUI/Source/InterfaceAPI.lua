-------------------------------------------------------------------------------

-- LOAD/SAVE

-------------------------------------------------------------------------------
-- Interface.SaveBoolean
-- Description:
--     Saves a boolean value for a setting
-- Parameters:
--     settingName - the name of the setting to be saved
--     settingValue - the value to be saved
-- Returns:
--     True if the setting was saved, false if it failed
-------------------------------------------------------------------------------
function Interface.SaveBoolean( settingName, settingValue )
	-- Check the types of the arguments
	if type( settingName ) ~= type( "" ) then
		Debug.Print( "Interface.SaveBoolean: settingName must be a string" )
		return false
	end
	if type( settingValue ) ~= type( true ) then
		Debug.Print( "Interface.SaveBoolean: settingValue must be a boolean" )
		return false
	end
	
	local nBools = #SystemData.Settings.Interface.UIVariables.BoolNames
	if nBools <= 0 then
		table.insert(SystemData.Settings.Interface.UIVariables.BoolNames, settingName)
		table.insert(SystemData.Settings.Interface.UIVariables.BoolValues, settingValue)
	else
		local found = false
		for i = 1, nBools do
			if SystemData.Settings.Interface.UIVariables.BoolNames[i] == settingName then
				SystemData.Settings.Interface.UIVariables.BoolValues[i] = settingValue
				found = true
				break
			end
		end
		if not found then
			table.insert(SystemData.Settings.Interface.UIVariables.BoolNames, settingName)
			table.insert(SystemData.Settings.Interface.UIVariables.BoolValues, settingValue)
		end
	end
	BroadcastEvent( SystemData.Events.USER_SETTINGS_UPDATED )
end

-------------------------------------------------------------------------------
-- Interface.SaveNumber
-- Description:
--     Saves a numeric value for a setting
-- Parameters:
--     settingName - the name of the setting to be saved
--     settingValue - the value to be saved
-------------------------------------------------------------------------------
function Interface.SaveNumber( settingName, settingValue )
	-- Check the types of the arguments
	if type( settingName ) ~= type( "" ) then
		Debug.Print( "Interface.SaveNumber: settingName must be a string" )
		return false
	end
	if type( settingValue ) ~= type( 0 ) then
		Debug.Print( "Interface.SaveNumber: \"" .. settingName .. "\" settingValue must be a number" )
		return false
	end
	
	local nNumbers = #SystemData.Settings.Interface.UIVariables.NumberNames
	if nNumbers <= 0 then
		table.insert(SystemData.Settings.Interface.UIVariables.NumberNames, settingName)
		table.insert(SystemData.Settings.Interface.UIVariables.NumberValues, settingValue)
	else
		local found = false
		for i = 1, nNumbers do
			if SystemData.Settings.Interface.UIVariables.NumberNames[i] == settingName then
				SystemData.Settings.Interface.UIVariables.NumberValues[i] = settingValue
				found = true
				break
			end
		end
		if not found then
			table.insert(SystemData.Settings.Interface.UIVariables.NumberNames, settingName)
			table.insert(SystemData.Settings.Interface.UIVariables.NumberValues, settingValue)
		end
	end
	
end

-------------------------------------------------------------------------------
-- Interface.SaveColor
-- Description:
--     Saves a color value for a setting
-- Parameters:
--     settingName - the name of the setting to be saved
--     settingValue - the value to be saved 
--                    (table {r=(0-255),g=(0-255),b=(0-255)[,a=(0-255)]})
-------------------------------------------------------------------------------
function Interface.SaveColor( settingName, settingValue )
	-- Check the types of the arguments
	if type( settingName ) ~= type( "" ) then
		Debug.Print( "Interface.SaveColor: settingName must be a string" )
		return false
	end
	--Debug.Print("Checking Color: " .. settingName)
	if not Interface.CheckColor( settingValue, "Interface.SaveColor" ) then
		-- Debug printing in CheckColor function
		return false
	end
	
	local r = settingValue.r
	local g = settingValue.g
	local b = settingValue.b
	local a = settingValue.a

	local nColors = #SystemData.Settings.Interface.UIVariables.ColorNames
	if nColors <= 0 then
		table.insert(SystemData.Settings.Interface.UIVariables.ColorNames, settingName)
		table.insert(SystemData.Settings.Interface.UIVariables.ColorRedValues, r)
		table.insert(SystemData.Settings.Interface.UIVariables.ColorGreenValues, g)
		table.insert(SystemData.Settings.Interface.UIVariables.ColorBlueValues, b)
		table.insert(SystemData.Settings.Interface.UIVariables.ColorAlphaValues, a)
	else
		local found = false
		for i = 1, nColors do
			if SystemData.Settings.Interface.UIVariables.ColorNames[i] == settingName then
				SystemData.Settings.Interface.UIVariables.ColorRedValues[i] = r
				SystemData.Settings.Interface.UIVariables.ColorGreenValues[i] = g
				SystemData.Settings.Interface.UIVariables.ColorBlueValues[i] = b
				SystemData.Settings.Interface.UIVariables.ColorAlphaValues[i] = a
				found = true
				break
			end
		end
		if not found then
			table.insert(SystemData.Settings.Interface.UIVariables.ColorNames, settingName)
			table.insert(SystemData.Settings.Interface.UIVariables.ColorRedValues, r)
			table.insert(SystemData.Settings.Interface.UIVariables.ColorGreenValues, g)
			table.insert(SystemData.Settings.Interface.UIVariables.ColorBlueValues, b)
			table.insert(SystemData.Settings.Interface.UIVariables.ColorAlphaValues, a)
		end
	end
end


-------------------------------------------------------------------------------
-- Interface.SaveString
-- Description:
--     Saves a string value for a setting
-- Parameters:
--     settingName - the name of the setting to be saved
--     settingValue - the value to be saved
-------------------------------------------------------------------------------
function Interface.SaveString( settingName, settingValue )
	-- Check the types of the arguments
	if type( settingName ) ~= type( "" ) then
		Debug.Print( "Interface.SaveString: settingName must be a string" )
		return false
	end
	if type( settingValue ) ~= type( "" ) then
		Debug.Print( "Interface.SaveString: settingValue must be a string" )
		return false
	end
	
	local nStrings = #SystemData.Settings.Interface.UIVariables.StringNames
	if nStrings <= 0 then
		table.insert(SystemData.Settings.Interface.UIVariables.StringNames, settingName)
		table.insert(SystemData.Settings.Interface.UIVariables.StringValues, settingValue)
	else
		local found = false
		for i = 1, nStrings do
			if SystemData.Settings.Interface.UIVariables.StringNames[i] == settingName then
				SystemData.Settings.Interface.UIVariables.StringValues[i] = settingValue
				found = true
				break
			end
		end
		if not found then
			table.insert(SystemData.Settings.Interface.UIVariables.StringNames, settingName)
			table.insert(SystemData.Settings.Interface.UIVariables.StringValues, settingValue)
		end
	end
end

-------------------------------------------------------------------------------
-- Interface.SaveWString
-- Description:
--     Saves a wstring value for a setting
-- Parameters:
--     settingName - the name of the setting to be saved
--     settingValue - the value to be saved
-------------------------------------------------------------------------------
function Interface.SaveWString( settingName, settingValue )
	-- Check the types of the arguments
	if type( settingName ) ~= type( "" ) then
		Debug.Print( "Interface.SaveString: settingName must be a string" )
		return false
	end
	if type( settingValue ) ~= type( L"" ) then
		Debug.Print( "Interface.SaveString: settingValue must be a wstring" )
		return false
	end
	
	local nWStrings = #SystemData.Settings.Interface.UIVariables.WStringNames
	if nWStrings <= 0 then
		table.insert(SystemData.Settings.Interface.UIVariables.WStringNames, settingName)
		table.insert(SystemData.Settings.Interface.UIVariables.WStringValues, settingValue)
	else
		local found = false
		for i = 1, nWStrings do
			if SystemData.Settings.Interface.UIVariables.WStringNames[i] == settingName then
				SystemData.Settings.Interface.UIVariables.WStringValues[i] = settingValue
				found = true
				break
			end
		end
		if not found then
			table.insert(SystemData.Settings.Interface.UIVariables.WStringNames, settingName)
			table.insert(SystemData.Settings.Interface.UIVariables.WStringValues, settingValue)
		end
	end
end


-------------------------------------------------------------------------------
-- Interface.DeleteSetting
-- Description:
--     Delete an existing setting
-- Parameters:
--     settingName - the name of the setting (with the prefix)
-------------------------------------------------------------------------------

function Interface.DeleteSetting( settingName )
	local nBools = #SystemData.Settings.Interface.UIVariables.BoolNames
	for i = 1, nBools do
		if SystemData.Settings.Interface.UIVariables.BoolNames[i] == settingName then
			table.remove( SystemData.Settings.Interface.UIVariables.BoolNames, i)
			table.remove( SystemData.Settings.Interface.UIVariables.BoolValues, i)
			return
		end
	end
	
	local nNumbers = #SystemData.Settings.Interface.UIVariables.NumberNames
	for i = 1, nNumbers do
		if SystemData.Settings.Interface.UIVariables.NumberNames[i] == settingName then
			table.remove( SystemData.Settings.Interface.UIVariables.NumberNames, i)
			table.remove( SystemData.Settings.Interface.UIVariables.NumberValues, i)
			return
		end
	end
	
	local nColors = #SystemData.Settings.Interface.UIVariables.ColorNames
	for i = 1, nColors do
		if SystemData.Settings.Interface.UIVariables.ColorNames[i] == settingName then
			table.remove( SystemData.Settings.Interface.UIVariables.ColorNames, i)
			table.remove( SystemData.Settings.Interface.UIVariables.ColorRedValues, i)
			table.remove( SystemData.Settings.Interface.UIVariables.ColorGreenValues, i)
			table.remove( SystemData.Settings.Interface.UIVariables.ColorBlueValues, i)
			table.remove( SystemData.Settings.Interface.UIVariables.ColorAlphaValues, i)
			return
		end
	end
	
	local nStrings = #SystemData.Settings.Interface.UIVariables.StringNames
	for i = 1, nStrings do
		if SystemData.Settings.Interface.UIVariables.StringNames[i] == settingName then
			table.remove( SystemData.Settings.Interface.UIVariables.StringNames, i)
			table.remove( SystemData.Settings.Interface.UIVariables.StringValues, i)
			return
		end
	end
	
	local nWStrings = #SystemData.Settings.Interface.UIVariables.WStringNames
	for i = 1, nWStrings do
		if SystemData.Settings.Interface.UIVariables.WStringNames[i] == settingName then
			table.remove( SystemData.Settings.Interface.UIVariables.WStringNames, i)
			table.remove( SystemData.Settings.Interface.UIVariables.WStringValues, i)
			return
		end
	end
end

-------------------------------------------------------------------------------
-- Interface.CheckColor
-- Description:
--     Checks to see if an argument is a valid color table
-- Parameters:
--     color - the argument to check
--     rootFunction - the name of the function to use in the debug messages
--                    no logging is done if this is nil
-- Returns:
--     True if it is a valid color, false otherwise
-------------------------------------------------------------------------------
function Interface.CheckColor( color, rootFunction )
	local good = true
	if type( color ) ~= type( {} ) then
		good = false
	elseif type( color.r ) ~= type( 0 ) or color.r < 0 or color.r > 255 then
		good = false
	elseif type( color.g ) ~= type( 0 ) or color.g < 0 or color.g > 255 then
		good = false
	elseif type( color.b ) ~= type( 0 ) or color.b < 0 or color.b > 255 then
		good = false
	elseif color.a ~= nil and type( color.a ) ~= type( 0 ) then
		if (color.a < 0 or color.a > 255 ) then
			good = false
		end
	end
	if not good and rootFunction ~= nil then
		Debug.Print( rootFunction .. ": color must be a table with r, g, and b values between 0 and 255 (with an option a value between 0 and 255)" )
	end
	return good
end

-------------------------------------------------------------------------------
-- Interface.LoadBoolean
-- Description:
--     Gets the boolean value of a setting 
-- Parameters:
--     settingName - the name of the setting
--     defaultValue - a value to use as a default if it wasn't saved properly
-- Returns:
--     The value of the setting if it was saved properly, the default value if
--     it wasn't saved properly, or nil if it wasn't saved properly and no
--     default value was provided
-------------------------------------------------------------------------------
function Interface.LoadBoolean( settingName, defaultValue )
	-- Check the types of the arguments
	if type( settingName ) ~= type( "" ) then
		Debug.Print( "Interface.LoadNumber: settingName must be a string" )
		return defaultValue
	end
	
	if not SystemData.Settings.Interface.UIVariables.BoolNames then
		return defaultValue
	end
	
	local nBools = #SystemData.Settings.Interface.UIVariables.BoolNames
	for i = 1, nBools do
		
		if SystemData.Settings.Interface.UIVariables.BoolNames[i] == settingName then
		--[[
			Debug.Print(settingName)
			Debug.Print(SystemData.Settings.Interface.UIVariables.BoolValues[i])
			Debug.Print("-------")
		--]]
			return SystemData.Settings.Interface.UIVariables.BoolValues[i]
		end
	end
	return defaultValue
end

-------------------------------------------------------------------------------
-- Interface.LoadNumber
-- Description:
--     Gets the numeric value of a setting 
-- Parameters:
--     settingName - the name of the setting
--     defaultValue - a value to use as a default if it wasn't saved properly
-- Returns:
--     The value of the setting if it was saved properly, the default value if
--     it wasn't saved properly, or nil if it wasn't saved properly and no
--     default value was provided
-------------------------------------------------------------------------------
function Interface.LoadNumber( settingName, defaultValue )
	-- Check the types of the arguments
	if type( settingName ) ~= type( "" ) then
		Debug.Print( "Interface.LoadNumber: settingName must be a string" )
		return defaultValue
	end
	
	if not SystemData.Settings.Interface.UIVariables.NumberNames then
		return defaultValue
	end

	local nNumbers = #SystemData.Settings.Interface.UIVariables.NumberNames
	for i = 1, nNumbers do
		if SystemData.Settings.Interface.UIVariables.NumberNames[i] == settingName then
			return SystemData.Settings.Interface.UIVariables.NumberValues[i]
		end
	end
	return defaultValue
end

-------------------------------------------------------------------------------
-- Interface.LoadColor
-- Description:
--     Gets the color value of a setting 
-- Parameters:
--     settingName - the name of the setting
--     defaultValue - a value to use as a default if it wasn't saved properly
-- Returns:
--     The value of the setting if it was saved properly, the default value if
--     it wasn't saved properly, or nil if it wasn't saved properly and no
--     default value was provided
-------------------------------------------------------------------------------
function Interface.LoadColor( settingName, defaultValue )
	-- Check the types of the arguments
	if type( settingName ) ~= type( "" ) then
		Debug.Print( "Interface.LoadColor: settingName must be a string" )
		return false
	end
	
	if not SystemData.Settings.Interface.UIVariables.ColorNames then
		return defaultValue
	end

	local nStrings = #SystemData.Settings.Interface.UIVariables.ColorNames
	for i = 1, nStrings do
		if SystemData.Settings.Interface.UIVariables.ColorNames[i] == settingName then	
			local color = {
						r=SystemData.Settings.Interface.UIVariables.ColorRedValues[i],
						g=SystemData.Settings.Interface.UIVariables.ColorGreenValues[i],
						b=SystemData.Settings.Interface.UIVariables.ColorBlueValues[i],
						a=SystemData.Settings.Interface.UIVariables.ColorAlphaValues[i]
					   } 
			return color
		end
	end
	return defaultValue
end

-------------------------------------------------------------------------------
-- Interface.LoadStringValue
-- Parameters:
--     settingName - the name of the setting
--     defaultValue - a value to use as a default if it wasn't saved properly
-------------------------------------------------------------------------------
function Interface.LoadString( settingName, defaultValue )
    -- Check the types of the arguments
	if type( settingName ) ~= type( "" ) then
		Debug.Print( "Interface.LoadNumber: settingName must be a string" )
		return defaultValue
	end
	
	if not SystemData.Settings.Interface.UIVariables.StringNames then
		return defaultValue
	end
	
	local nStrings = #SystemData.Settings.Interface.UIVariables.StringNames
	for i = 1, nStrings do
		if SystemData.Settings.Interface.UIVariables.StringNames[i] == settingName then
			return SystemData.Settings.Interface.UIVariables.StringValues[i]
		end
	end
	return defaultValue
end


-------------------------------------------------------------------------------
-- Interface.LoadWStringValue
-- Parameters:
--     settingName - the name of the setting
--     defaultValue - a value to use as a default if it wasn't saved properly
-------------------------------------------------------------------------------

function Interface.LoadWString( settingName, defaultValue )
	-- Check the types of the arguments
	if type( settingName ) ~= type( "" ) then
		Debug.Print( "Interface.LoadNumber: settingName must be a string" )
		return defaultValue
	end
	
	if not SystemData.Settings.Interface.UIVariables.WStringNames then
		return defaultValue
	end

    local nWStrings = #SystemData.Settings.Interface.UIVariables.WStringNames
	for i = 1, nWStrings do
		if SystemData.Settings.Interface.UIVariables.WStringNames[i] == settingName then
			return SystemData.Settings.Interface.UIVariables.WStringValues[i]
		end
	end

	return defaultValue
end


function Interface.ErrorTracker(success, error)
	if (not success and error ~= nil and (type(error) == "string" or type(error) == "wstring")) then
		Debug.Print(error)
	end
end