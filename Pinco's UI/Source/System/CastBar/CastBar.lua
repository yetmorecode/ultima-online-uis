----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

CastBarWindow = {}

CastBarWindow.LagFactor = 0.2

CastBarWindow.CurrPerc = 100
CastBarWindow.CurrentTime = 0
CastBarWindow.UnlagTime = 0
CastBarWindow.Blinking = false
CastBarWindow.BlinkCooldown = 0
----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function CastBarWindow.Initialize()

	-- initialize the cast status at full
	StatusBarSetCurrentValue("CastBarWindowFill", 100)	
	StatusBarSetMaximumValue("CastBarWindowFill", 100)
end

function CastBarWindow.Update(TimePassed)

	-- is the cast bar enabled?
	if not Interface.Settings.CastBar then
		return
	end

	-- get the current spell speed
	local SpellSpeed = Interface.CurrentSpell
	
	-- do we have a cast speed and the timer is started?
	if SpellSpeed and CastBarWindow.CurrentTime > 0 then

		-- is the castbar invisible?
		if not WindowGetShowing("CastBarWindow") or WindowGetAlpha("CastBarWindow") < 1 then

			-- show the castbar
			WindowSetShowing("CastBarWindow", true)

			-- color the castbar based on the spell type
			WindowSetTintColor("CastBarWindowFill", Interface.CurrentSpell.Color.r, Interface.CurrentSpell.Color.g, Interface.CurrentSpell.Color.b)

			-- stop the blinking animation
			WindowStopAlphaAnimation("CastBarWindow")
		end
		
		-- increase the time
		CastBarWindow.CurrentTime = CastBarWindow.CurrentTime - TimePassed

		-- calculate the casting percentage
		local currPerc = 100 - (CastBarWindow.CurrentTime/(CastBarWindow.UnlagTime + (CastBarWindow.UnlagTime * CastBarWindow.LagFactor)) ) * 100 -- 10% of lag time

		-- do we have a valid percentage?
		if math.isINF(currPerc) or math.isNAN(currPerc) or currPerc < 0 or currPerc > 100 then

			-- set the percentage to 0 if is invalid
			currPerc = 0
		end

		-- set the cast bar as not blinking
		CastBarWindow.Blinking = false

		-- set the current progress to the bar
		StatusBarSetCurrentValue("CastBarWindowFill", currPerc)

		-- move the castbar under the mouse cursor
		WindowUtils.FollowMouseCursor("CastBarWindow", 118, 26, -30, 20, false, false, false)

	-- is the castbar time over and is not blinking?
	elseif CastBarWindow.CurrentTime <= 0 and not CastBarWindow.Blinking then

		-- flag the castbar as blinking
		CastBarWindow.Blinking = true

		-- start the blinking animation
		WindowStartAlphaAnimation("CastBarWindow", Window.AnimationType.LOOP, 1, 0.2, 0.2, false, 0, 0)

		-- set the blink timer to 2s
		CastBarWindow.BlinkCooldown = 2

		-- move the castbar under the mouse cursor
		WindowUtils.FollowMouseCursor("CastBarWindow", 118, 26, -30, 20, false, false, false)

	-- is the castbar blinking timer running?
	elseif CastBarWindow.BlinkCooldown > 0 then

		-- move the castbar under the mouse cursor
		WindowUtils.FollowMouseCursor("CastBarWindow", 118, 26, -30, 20, false, false, false)

		-- update the blink timer
		CastBarWindow.BlinkCooldown = CastBarWindow.BlinkCooldown - TimePassed

		-- is the time over?
		if CastBarWindow.BlinkCooldown <= 0 then

			-- reset the blink timer
			CastBarWindow.BlinkCooldown = 0

			-- stop the blink animation
			WindowStopAlphaAnimation("CastBarWindow")

			-- hide the cast bar
			WindowSetShowing("CastBarWindow", false)
		end
	end
end

function CastBarWindow.Shutdown()
end
