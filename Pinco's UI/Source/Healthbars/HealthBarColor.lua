----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

HealthBarColor = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

HealthBarColor.HealthVisualState = { Default = 1, Poison = 2, Cursed = 3, Disabled = 4, Stamina = 10, Mana = 11, NoData = 12 }
HealthBarColor.BarColor = {}
HealthBarColor.BarColor[HealthBarColor.HealthVisualState.Default] = { r = 255 , g = 0, b = 0} -- Red
HealthBarColor.BarColor[HealthBarColor.HealthVisualState.Poison] = { r = 0, g = 255, b = 0}	-- Green
HealthBarColor.BarColor[HealthBarColor.HealthVisualState.Cursed] = { r = 255, g = 255, b = 0 }	-- Yellow
HealthBarColor.BarColor[HealthBarColor.HealthVisualState.Disabled] = { r = 125, g = 125, b = 125 }	-- Gray

HealthBarColor.BarColor[HealthBarColor.HealthVisualState.Stamina] = { r = 255, g = 242, b = 0 }	-- Yellow
HealthBarColor.BarColor[HealthBarColor.HealthVisualState.Mana] = { r = 0, g = 80, b = 232 }	-- Blue
HealthBarColor.BarColor[HealthBarColor.HealthVisualState.NoData] = { r = 255, g = 0, b = 255 } -- fucsia
----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function HealthBarColor.UpdateHealthBarColor(windowTintName, visualStateId)
	
	-- does the bar exist?
	if not DoesWindowExist(windowTintName) then
		return
	end

	-- do we have a state ID?
	if not visualStateId then

		-- use the default one
		visualStateId = 0
	end

	-- get the hue data
	local hue = HealthBarColor.BarColor[visualStateId + 1]

	-- color the bar
	StatusBarSetForegroundTint(windowTintName, hue.r, hue.g, hue.b)
end

function HealthBarColor.UpdateVerticalHealthBarColor(windowTintName, visualStateId)
	
	-- does the bar exist?
	if not DoesWindowExist(windowTintName) then
		return
	end

	-- do we have a state ID?
	if not visualStateId then

		-- use the default one
		visualStateId = 0
	end

	-- get the hue data
	local hue = HealthBarColor.BarColor[visualStateId + 1]

	-- color the bar
	WindowSetTintColor(windowTintName, hue.r, hue.g, hue.b)
end