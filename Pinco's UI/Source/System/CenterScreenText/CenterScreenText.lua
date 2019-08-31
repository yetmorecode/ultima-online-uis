----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

CenterScreenText = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------
CenterScreenText.LOWHPMEStarted = false
CenterScreenText.LOWHPPetStarted = false

----------------------------------------------------------------
-- CenterScreenText Functions
----------------------------------------------------------------

function CenterScreenText.SendCenterScreenTexture(message)
	
	local gender = GetMobileGender(GetPlayerID())
	
	if (message == "serverdown") then
		DynamicImageSetTexture( "CenterScreenTextImage", "CST_ServerDown", 0, 0 )
		DynamicImageSetTextureDimensions( "CenterScreenTextImage", 480, 60 )
		WindowSetDimensions("CenterScreenTextImage", 480, 60 )
		WindowStopAlphaAnimation("CenterScreenTextImage")
		WindowSetAlpha("CenterScreenTextImage", 0)
		WindowStartAlphaAnimation("CenterScreenTextImage", Window.AnimationType.LOOP, 0.5, 1, 1, false, 0, 3)
		local sid = 1065
		if (gender == 1) then
			sid = 793
		end
		PlaySound(1, sid, WindowData.PlayerLocation.x,WindowData.PlayerLocation.y,WindowData.PlayerLocation.z)
		CenterScreenText.LOWHPMEStarted = false
		CenterScreenText.LOWHPPetStarted = false
	end
	
	if (message == "gmarrived") then
		DynamicImageSetTexture( "CenterScreenTextImage", "CST_GMArrived", 0, 0 )
		DynamicImageSetTextureDimensions( "CenterScreenTextImage", 384, 60 )
		WindowSetDimensions("CenterScreenTextImage", 384, 60 )
		WindowStopAlphaAnimation("CenterScreenTextImage")
		WindowSetAlpha("CenterScreenTextImage", 0)
		WindowStartAlphaAnimation("CenterScreenTextImage", Window.AnimationType.LOOP, 0.5, 1, 1, false, 0, 3)
		local sid = 1055
		if (gender == 1) then
			sid = 784
		end
		PlaySound(1, sid, WindowData.PlayerLocation.x,WindowData.PlayerLocation.y,WindowData.PlayerLocation.z)
		CenterScreenText.LOWHPMEStarted = false
		CenterScreenText.LOWHPPetStarted = false
	end
	
	if (message == "artifact") then
		DynamicImageSetTexture( "CenterScreenTextImage", "CST_Artifact", 0, 0 )
		DynamicImageSetTextureDimensions( "CenterScreenTextImage", 220, 80 )
		WindowSetDimensions("CenterScreenTextImage", 220, 80 )
		WindowStopAlphaAnimation("CenterScreenTextImage")
		WindowSetAlpha("CenterScreenTextImage", 0)
		WindowStartAlphaAnimation("CenterScreenTextImage", Window.AnimationType.LOOP, 0.5, 1, 1, false, 0, 3)
		local sid = 1097
		if (gender == 1) then
			sid = 823
		end
		PlaySound(1, sid, WindowData.PlayerLocation.x,WindowData.PlayerLocation.y,WindowData.PlayerLocation.z)
		
		CenterScreenText.LOWHPMEStarted = false
		CenterScreenText.LOWHPPetStarted = false
	end
	
	if (message == "gorgon") then
		DynamicImageSetTexture( "CenterScreenTextImage", "CST_GorgonLensesAreGone", 0, 0 )
		DynamicImageSetTextureDimensions( "CenterScreenTextImage", 576, 72 )
		WindowSetDimensions("CenterScreenTextImage", 576, 72 )
		WindowStopAlphaAnimation("CenterScreenTextImage")
		WindowSetAlpha("CenterScreenTextImage", 0)
		WindowStartAlphaAnimation("CenterScreenTextImage", Window.AnimationType.LOOP, 0.5, 1, 1, false, 0, 3)
		local sid = 62
		PlaySound(1, sid, WindowData.PlayerLocation.x,WindowData.PlayerLocation.y,WindowData.PlayerLocation.z)
		
		CenterScreenText.LOWHPMEStarted = false
		CenterScreenText.LOWHPPetStarted = false
	end
	
	if (message == "machete") then
		DynamicImageSetTexture( "CenterScreenTextImage", "CST_BoneMacheteIsGone", 0, 0 )
		DynamicImageSetTextureDimensions( "CenterScreenTextImage", 576, 60 )
		WindowSetDimensions("CenterScreenTextImage", 576, 60 )
		WindowStopAlphaAnimation("CenterScreenTextImage")
		WindowSetAlpha("CenterScreenTextImage", 0)
		WindowStartAlphaAnimation("CenterScreenTextImage", Window.AnimationType.LOOP, 0.5, 1, 1, false, 0, 3)

		local sid = 567
		PlaySound(1, sid, WindowData.PlayerLocation.x,WindowData.PlayerLocation.y,WindowData.PlayerLocation.z)
		
		CenterScreenText.LOWHPMEStarted = false
		CenterScreenText.LOWHPPetStarted = false
	end
	
	if (message == "battlebegin") then
		DynamicImageSetTexture( "CenterScreenTextImage", "CST_BattleBegins", 0, 0 )
		DynamicImageSetTextureDimensions( "CenterScreenTextImage", 360, 60 )
		WindowSetDimensions("CenterScreenTextImage", 360, 60 )
		WindowStopAlphaAnimation("CenterScreenTextImage")
		WindowSetAlpha("CenterScreenTextImage", 0)
		WindowStartAlphaAnimation("CenterScreenTextImage", Window.AnimationType.LOOP, 0.5, 1, 1, false, 0, 3)
		local sid = 1098
		if (gender == 1) then
			sid = 824
		end
		PlaySound(1, sid, WindowData.PlayerLocation.x,WindowData.PlayerLocation.y,WindowData.PlayerLocation.z)
		
		CenterScreenText.LOWHPMEStarted = false
		CenterScreenText.LOWHPPetStarted = false
	end
	
	if (message == "battlelost") then
		DynamicImageSetTexture( "CenterScreenTextImage", "CST_BattleLost", 0, 0 )
		DynamicImageSetTextureDimensions( "CenterScreenTextImage", 360, 60 )
		WindowSetDimensions("CenterScreenTextImage", 360, 60 )
		WindowStopAlphaAnimation("CenterScreenTextImage")
		WindowSetAlpha("CenterScreenTextImage", 0)
		WindowStartAlphaAnimation("CenterScreenTextImage", Window.AnimationType.LOOP, 0.5, 1, 1, false, 0, 3)
		local sid = 1058
		if (gender == 1) then
			sid = 787
		end
		PlaySound(1, sid, WindowData.PlayerLocation.x,WindowData.PlayerLocation.y,WindowData.PlayerLocation.z)
		CenterScreenText.LOWHPMEStarted = false
		CenterScreenText.LOWHPPetStarted = false
	end
	
	
	if (message == "slowed") then
		DynamicImageSetTexture( "CenterScreenTextImage", "CST_SlowedDown", 0, 0 )
		DynamicImageSetTextureDimensions( "CenterScreenTextImage", 340, 80 )
		WindowSetDimensions("CenterScreenTextImage", 340, 80 )
		WindowStopAlphaAnimation("CenterScreenTextImage")
		WindowSetAlpha("CenterScreenTextImage", 0)
		WindowStartAlphaAnimation("CenterScreenTextImage", Window.AnimationType.LOOP, 0.5, 1, 1, false, 0, 3)
		CenterScreenText.LOWHPMEStarted = false
		CenterScreenText.LOWHPPetStarted = false
	end
	if (message == "stoned") then
		DynamicImageSetTexture( "CenterScreenTextImage", "CST_Stoned", 0, 0 )
		DynamicImageSetTextureDimensions( "CenterScreenTextImage", 200, 60 )
		WindowSetDimensions("CenterScreenTextImage", 200, 60 )
		WindowStopAlphaAnimation("CenterScreenTextImage")
		WindowSetAlpha("CenterScreenTextImage", 0)
		WindowStartAlphaAnimation("CenterScreenTextImage", Window.AnimationType.LOOP, 0.5, 1, 1, false, 0, 3)
		
		CenterScreenText.LOWHPMEStarted = false
		CenterScreenText.LOWHPPetStarted = false
	end
	if (message == "free") then
		DynamicImageSetTexture( "CenterScreenTextImage", "CST_YouAreFree", 0, 0 )
		DynamicImageSetTextureDimensions( "CenterScreenTextImage", 400, 80 )
		WindowSetDimensions("CenterScreenTextImage", 400, 80 )
		WindowStopAlphaAnimation("CenterScreenTextImage")
		WindowSetAlpha("CenterScreenTextImage", 0)
		WindowStartAlphaAnimation("CenterScreenTextImage", Window.AnimationType.LOOP, 0.5, 1, 1, false, 0, 3)
		
		CenterScreenText.LOWHPMEStarted = false
		CenterScreenText.LOWHPPetStarted = false
	end
	
	
	if (message == "backpackfull") then
		DynamicImageSetTexture( "CenterScreenTextImage", "CST_BackpackFull", 0, 0 )
		DynamicImageSetTextureDimensions( "CenterScreenTextImage", 380, 80 )
		WindowSetDimensions("CenterScreenTextImage", 380, 80 )
		WindowStopAlphaAnimation("CenterScreenTextImage")
		WindowSetAlpha("CenterScreenTextImage", 0)
		WindowStartAlphaAnimation("CenterScreenTextImage", Window.AnimationType.LOOP, 0.5, 1, 1, false, 0, 3)
		
		CenterScreenText.LOWHPMEStarted = false
		CenterScreenText.LOWHPPetStarted = false
	end
	
	if (message == "disarmed") then
		DynamicImageSetTexture( "CenterScreenTextImage", "CST_Disarmed", 0, 0 )
		DynamicImageSetTextureDimensions( "CenterScreenTextImage", 360, 60 )
		WindowSetDimensions("CenterScreenTextImage", 360, 60 )
		WindowStopAlphaAnimation("CenterScreenTextImage")
		WindowSetAlpha("CenterScreenTextImage", 0)
		WindowStartAlphaAnimation("CenterScreenTextImage", Window.AnimationType.LOOP, 0.5, 1, 1, false, 0, 3)
		
		CenterScreenText.LOWHPMEStarted = false
		CenterScreenText.LOWHPPetStarted = false
	end
	
	if (message == "beacon") then
		DynamicImageSetTexture( "CenterScreenTextImage", "CST_Beacon", 0, 0 )
		DynamicImageSetTextureDimensions( "CenterScreenTextImage", 360, 120 )
		WindowSetDimensions("CenterScreenTextImage", 360, 120 )
		WindowStopAlphaAnimation("CenterScreenTextImage")
		WindowSetAlpha("CenterScreenTextImage", 0)
		WindowStartAlphaAnimation("CenterScreenTextImage", Window.AnimationType.LOOP, 0.5, 1, 1, false, 0, 3)
		
		local sid = 323
		PlaySound(1, sid, WindowData.PlayerLocation.x,WindowData.PlayerLocation.y,WindowData.PlayerLocation.z)
		CenterScreenText.LOWHPMEStarted = false
		CenterScreenText.LOWHPPetStarted = false
	end
	
	if (message == "webbed") then
		DynamicImageSetTexture( "CenterScreenTextImage", "CST_Webbed", 0, 0 )
		DynamicImageSetTextureDimensions( "CenterScreenTextImage", 320, 80 )
		WindowSetDimensions("CenterScreenTextImage", 320, 80 )
		
		WindowStopAlphaAnimation("CenterScreenTextImage")
		WindowSetAlpha("CenterScreenTextImage", 0)
		WindowStartAlphaAnimation("CenterScreenTextImage", Window.AnimationType.LOOP, 0.5, 1, 1, false, 0, 3)
		
		local sid = 327
		PlaySound(1, sid, WindowData.PlayerLocation.x,WindowData.PlayerLocation.y,WindowData.PlayerLocation.z)
		CenterScreenText.LOWHPMEStarted = false
		CenterScreenText.LOWHPPetStarted = false
	end
	
	if (message == "panic") then
		DynamicImageSetTexture( "CenterScreenTextImage", "CST_Panic", 0, 0 )
		DynamicImageSetTextureDimensions( "CenterScreenTextImage", 240, 92 )
		WindowSetDimensions("CenterScreenTextImage", 240, 92 )
		WindowStopAlphaAnimation("CenterScreenTextImage")
		WindowSetAlpha("CenterScreenTextImage", 0)
		WindowStartAlphaAnimation("CenterScreenTextImage", Window.AnimationType.LOOP, 0.5, 1, 1, false, 0, 3)
		
		local sid = 1088
		if (gender == 1) then
			sid = 814
		end
		PlaySound(1, sid, WindowData.PlayerLocation.x,WindowData.PlayerLocation.y,WindowData.PlayerLocation.z)
		CenterScreenText.LOWHPMEStarted = false
		CenterScreenText.LOWHPPetStarted = false
	end
	
	if (message == "lowhp" ) and not Interface.Settings.CST_LowHPPercDisabled then
		DynamicImageSetTexture( "CenterScreenTextImage", "CST_LowLife", 0, 0 )
		DynamicImageSetTextureDimensions( "CenterScreenTextImage", 340, 72 )
		WindowSetDimensions("CenterScreenTextImage", 340, 72 )
		WindowStopAlphaAnimation("CenterScreenTextImage")
		WindowSetAlpha("CenterScreenTextImage", 0)
		WindowStartAlphaAnimation("CenterScreenTextImage", Window.AnimationType.LOOP, 0.5, 1, 0.6, false, 0, 0)
		CenterScreenText.LOWHPMEStarted = true
		CenterScreenText.LOWHPPetStarted = false
	end
	
	if (message == "lowhppet" and not CenterScreenText.LOWHPMEStarted) and not Interface.Settings.CST_LowPETHPPercDisabled then
		DynamicImageSetTexture( "CenterScreenTextImage", "CST_LowPetLife", 0, 0 )
		DynamicImageSetTextureDimensions( "CenterScreenTextImage", 340, 72 )
		WindowSetDimensions("CenterScreenTextImage", 340, 72 )
		WindowStopAlphaAnimation("CenterScreenTextImage")
		WindowSetAlpha("CenterScreenTextImage", 0)
		WindowStartAlphaAnimation("CenterScreenTextImage", Window.AnimationType.LOOP, 0.5, 1, 0.8, false, 0, 0)
		CenterScreenText.LOWHPPetStarted = true
	end
	
	if (message == "honorwearoff") then
		DynamicImageSetTexture( "CenterScreenTextImage", "CST_HonorWearsOff", 0, 0 )
		DynamicImageSetTextureDimensions( "CenterScreenTextImage", 420, 72 )
		WindowSetDimensions("CenterScreenTextImage", 420, 72 )
		WindowStopAlphaAnimation("CenterScreenTextImage")
		WindowSetAlpha("CenterScreenTextImage", 0)
		WindowStartAlphaAnimation("CenterScreenTextImage", Window.AnimationType.LOOP, 0.5, 1, 1, false, 0, 3)
		
		local sid = 1383
		PlaySound(1, sid, WindowData.PlayerLocation.x,WindowData.PlayerLocation.y,WindowData.PlayerLocation.z)
		CenterScreenText.LOWHPMEStarted = false
		CenterScreenText.LOWHPPetStarted = false
	end
	
	if (message == "bloodoath") then
		DynamicImageSetTexture( "CenterScreenTextImage", "CST_BloodOath", 0, 0 )
		DynamicImageSetTextureDimensions( "CenterScreenTextImage", 360, 88 )
		WindowSetDimensions("CenterScreenTextImage", 360, 88 )
		WindowStopAlphaAnimation("CenterScreenTextImage")
		WindowSetAlpha("CenterScreenTextImage", 0)
		WindowStartAlphaAnimation("CenterScreenTextImage", Window.AnimationType.LOOP, 0.5, 1, 1, false, 0, 3)
		
		CenterScreenText.LOWHPMEStarted = false
		CenterScreenText.LOWHPPetStarted = false
	end
	
	if (message == "treat") then
		DynamicImageSetTexture( "CenterScreenTextImage", "CST_Treat", 0, 0 )
		DynamicImageSetTextureDimensions( "CenterScreenTextImage", 188, 74 )
		WindowSetDimensions("CenterScreenTextImage", 188, 74 )
		WindowStopAlphaAnimation("CenterScreenTextImage")
		WindowSetAlpha("CenterScreenTextImage", 0)
		WindowStartAlphaAnimation("CenterScreenTextImage", Window.AnimationType.LOOP, 0.5, 1, 1, false, 0, 3)
		local sid = 1097
		if (gender == 1) then
			sid = 823
		end
		PlaySound(1, sid, WindowData.PlayerLocation.x,WindowData.PlayerLocation.y,WindowData.PlayerLocation.z)
		
		CenterScreenText.LOWHPMEStarted = false
		CenterScreenText.LOWHPPetStarted = false
	end
  
  if (message == "lavarock") then
		DynamicImageSetTexture( "CenterScreenTextImage", "CST_LavaRock", 0, 0 )
		DynamicImageSetTextureDimensions( "CenterScreenTextImage", 380, 80 )
		WindowSetDimensions("CenterScreenTextImage", 380, 80 )
		WindowStopAlphaAnimation("CenterScreenTextImage")
		WindowSetAlpha("CenterScreenTextImage", 0)
		WindowStartAlphaAnimation("CenterScreenTextImage", Window.AnimationType.LOOP, 0.5, 1, 1, false, 0, 3)
		
		CenterScreenText.LOWHPMEStarted = false
		CenterScreenText.LOWHPPetStarted = false
	end
  
  if (message == "eruption") then
		DynamicImageSetTexture( "CenterScreenTextImage", "CST_Eruption", 0, 0 )
		DynamicImageSetTextureDimensions( "CenterScreenTextImage", 380, 80 )
		WindowSetDimensions("CenterScreenTextImage", 380, 80 )
		WindowStopAlphaAnimation("CenterScreenTextImage")
		WindowSetAlpha("CenterScreenTextImage", 0)
		WindowStartAlphaAnimation("CenterScreenTextImage", Window.AnimationType.LOOP, 0.5, 1, 1, false, 0, 3)
		
		CenterScreenText.LOWHPMEStarted = false
		CenterScreenText.LOWHPPetStarted = false
	end

	if (message == "calmed") then
		DynamicImageSetTexture( "CenterScreenTextImage", "CST_Calmed", 0, 0 )
		DynamicImageSetTextureDimensions( "CenterScreenTextImage", 341, 133 )
		WindowSetDimensions("CenterScreenTextImage", 341, 133 )
		WindowStopAlphaAnimation("CenterScreenTextImage")
		WindowSetAlpha("CenterScreenTextImage", 0)
		WindowStartAlphaAnimation("CenterScreenTextImage", Window.AnimationType.LOOP, 0.5, 1, 1, false, 0, 3)
		
		CenterScreenText.LOWHPMEStarted = false
		CenterScreenText.LOWHPPetStarted = false
	end

	if (message == "luckrunout") then
		DynamicImageSetTexture( "CenterScreenTextImage", "CST_LuckRunOut", 0, 0 )
		DynamicImageSetTextureDimensions( "CenterScreenTextImage", 581, 109 )
		WindowSetDimensions("CenterScreenTextImage", 581, 109 )
		WindowStopAlphaAnimation("CenterScreenTextImage")
		WindowSetAlpha("CenterScreenTextImage", 0)
		WindowStartAlphaAnimation("CenterScreenTextImage", Window.AnimationType.LOOP, 0.5, 1, 1, false, 0, 3)
		
		CenterScreenText.LOWHPMEStarted = false
		CenterScreenText.LOWHPPetStarted = false
	end

	if (message == "petalsworeoff") then
		DynamicImageSetTexture( "CenterScreenTextImage", "CST_PetalsWoreOff", 0, 0 )
		DynamicImageSetTextureDimensions( "CenterScreenTextImage", 498, 87 )
		WindowSetDimensions("CenterScreenTextImage", 498, 87 )
		WindowStopAlphaAnimation("CenterScreenTextImage")
		WindowSetAlpha("CenterScreenTextImage", 0)
		WindowStartAlphaAnimation("CenterScreenTextImage", Window.AnimationType.LOOP, 0.5, 1, 1, false, 0, 3)
		
		CenterScreenText.LOWHPMEStarted = false
		CenterScreenText.LOWHPPetStarted = false
	end

	if (message == "stripped") then
		DynamicImageSetTexture( "CenterScreenTextImage", "CST_Stripped", 0, 0 )
		DynamicImageSetTextureDimensions( "CenterScreenTextImage", 506, 96 )
		WindowSetDimensions("CenterScreenTextImage", 506, 96 )
		WindowStopAlphaAnimation("CenterScreenTextImage")
		WindowSetAlpha("CenterScreenTextImage", 0)
		WindowStartAlphaAnimation("CenterScreenTextImage", Window.AnimationType.LOOP, 0.5, 1, 1, false, 0, 3)
		
		CenterScreenText.LOWHPMEStarted = false
		CenterScreenText.LOWHPPetStarted = false
	end

	if (message == "hiddencache") then
		DynamicImageSetTexture( "CenterScreenTextImage", "CST_HiddenCache", 0, 0 )
		DynamicImageSetTextureDimensions( "CenterScreenTextImage", 534, 84 )
		WindowSetDimensions("CenterScreenTextImage", 534, 84 )
		WindowStopAlphaAnimation("CenterScreenTextImage")
		WindowSetAlpha("CenterScreenTextImage", 0)
		WindowStartAlphaAnimation("CenterScreenTextImage", Window.AnimationType.LOOP, 0.5, 1, 1, false, 0, 3)
		
		CenterScreenText.LOWHPMEStarted = false
		CenterScreenText.LOWHPPetStarted = false
	end

	if (message == "revealed") then
		DynamicImageSetTexture( "CenterScreenTextImage", "CST_Revealed", 0, 0 )
		DynamicImageSetTextureDimensions( "CenterScreenTextImage", 460, 68 )
		WindowSetDimensions("CenterScreenTextImage", 460, 68 )
		WindowStopAlphaAnimation("CenterScreenTextImage")
		WindowSetAlpha("CenterScreenTextImage", 0)
		WindowStartAlphaAnimation("CenterScreenTextImage", Window.AnimationType.LOOP, 0.5, 1, 1, false, 0, 3)
		
		CenterScreenText.LOWHPMEStarted = false
		CenterScreenText.LOWHPPetStarted = false
	end

	if (message == "ambush") then
		DynamicImageSetTexture( "CenterScreenTextImage", "CST_Ambush", 0, 0 )
		DynamicImageSetTextureDimensions( "CenterScreenTextImage", 294, 93 )
		WindowSetDimensions("CenterScreenTextImage", 294, 93 )
		WindowStopAlphaAnimation("CenterScreenTextImage")
		WindowSetAlpha("CenterScreenTextImage", 0)
		WindowStartAlphaAnimation("CenterScreenTextImage", Window.AnimationType.LOOP, 0.5, 1, 1, false, 0, 3)
		
		CenterScreenText.LOWHPMEStarted = false
		CenterScreenText.LOWHPPetStarted = false
	end

	if (message == "krampus") then
		DynamicImageSetTexture( "CenterScreenTextImage", "CST_Krampus", 0, 0 )
		DynamicImageSetTextureDimensions( "CenterScreenTextImage", 468, 125 )
		WindowSetDimensions("CenterScreenTextImage", 468, 125 )
		WindowStopAlphaAnimation("CenterScreenTextImage")
		WindowSetAlpha("CenterScreenTextImage", 0)
		WindowStartAlphaAnimation("CenterScreenTextImage", Window.AnimationType.LOOP, 0.5, 1, 1, false, 0, 3)
		
		CenterScreenText.LOWHPMEStarted = false
		CenterScreenText.LOWHPPetStarted = false
	end

	if (message == "cargocrate") then
		DynamicImageSetTexture( "CenterScreenTextImage", "CST_CargoCrate", 0, 0 )
		DynamicImageSetTextureDimensions( "CenterScreenTextImage", 615, 68 )
		WindowSetDimensions("CenterScreenTextImage", 615, 68 )
		WindowStopAlphaAnimation("CenterScreenTextImage")
		WindowSetAlpha("CenterScreenTextImage", 0)
		WindowStartAlphaAnimation("CenterScreenTextImage", Window.AnimationType.LOOP, 0.5, 1, 1, false, 0, 3)
		
		CenterScreenText.LOWHPMEStarted = false
		CenterScreenText.LOWHPPetStarted = false
	end
end

function CenterScreenText.OnUpdate(timePassed)
	
	-- count pets with low life
	local lowlifeCount = 0

	-- is the low pet hp warning enabled?
	if not Interface.LowHPPETPercDisabled then

		-- scan all the mobiles on screen
		for mobileId, mobileStatus in pairs(Interface.ActiveMobilesOnScreen) do

			-- is the low pet warning enabled?
			local show = not Interface.LowHPPETPercDisabled

			-- is this a pet?
			if IsObjectIdPet(mobileId) then

				-- do we have the mobile health status?
				if not mobileStatus.perc then
					
					-- get mobile's health status
					mobileStatus.curHealth, mobileStatus.maxHealth, mobileStatus.dead, mobileStatus.perc = GetMobileHealth(mobileId, true)
				end

				-- is this a summon and we should ignore them?
				show = mobileStatus.isSummon and Interface.Settings.CST_EnableIgnoreSummons
			
				-- is the mobile alive?
				if mobileStatus and tonumber(mobileStatus.perc) and mobileStatus.perc >= 0 and not mobileStatus.dead and show then

					-- are we in the warning percent range?
					if mobileStatus.perc <= Interface.Settings.CST_LowPETHPPerc then

						-- increase the low life pets count
						lowlifeCount = lowlifeCount + 1
					end
				end
			end
		end
	end

	-- do we have any low life pet and the animation is not started?
	if lowlifeCount > 0 and not CenterScreenText.LOWHPPetStarted then

		-- start the animation
		CenterScreenText.SendCenterScreenTexture("lowhppet")

		-- flag the animation is started
		CenterScreenText.LOWHPPetStarted = true

	-- is the animation started and we don't have any low life pet?
	elseif CenterScreenText.LOWHPPetStarted and lowlifeCount <= 0 then

		-- flag the animation as stopped
		CenterScreenText.LOWHPPetStarted = false

		-- stop the animation
		WindowStopAlphaAnimation("CenterScreenTextImage")

		-- hide the image
		WindowSetAlpha("CenterScreenTextImage", 0)
	end
end