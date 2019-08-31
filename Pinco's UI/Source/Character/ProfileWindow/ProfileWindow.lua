----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

ProfileWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

ProfileWindow.WindowName = "ProfileWindow"
ProfileWindow.ProfileLoaded = false
ProfileWindow.ProfileId = 0

ProfileWindow.delta = 0
ProfileWindow.Retries = 0

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function ProfileWindow.Initialize()

	-- resize the profile window
	WindowSetDimensions(ProfileWindow.WindowName, 400, 500)

	-- resize the top part of the profile window
	WindowSetDimensions(ProfileWindow.WindowName .. "Top", 415, 43)

	-- resize the bottom part of the profile window
	WindowSetDimensions(ProfileWindow.WindowName .. "Bottom", 405, 18)

	-- hide the profile window
	WindowSetShowing(ProfileWindow.WindowName, false)

	-- restore the window position
	WindowUtils.RestoreWindowPosition(ProfileWindow.WindowName)

	-- mark the profile as NOT loaded
	ProfileWindow.ProfileLoaded = false

	-- current profile ID
	ProfileWindow.ProfileId = 0

	-- update the profile
	ProfileWindow.UpdateProfile()
end

function ProfileWindow.Shutdown()
	
	-- save the window position
    WindowUtils.SaveWindowPosition(ProfileWindow.WindowName)
end

function ProfileWindow.Update(timepass)

	-- profile delta time
	ProfileWindow.delta = ProfileWindow.delta + timepass

	-- is passed half seconds?
	if (ProfileWindow.delta > 0.5) then

		-- reset the delta
		ProfileWindow.delta = 0
		
		-- do we have a profile ID and the profile is NOT loaded?
		if IsValidID(ProfileWindow.ProfileId) and ProfileWindow.ProfileLoaded == false then

			-- is the current profile ID the one that is opened?
			if ProfileWindow.ProfileId == WindowData.CharProfile.Id then

				-- update the profile
				PaperdollWindow.UpdateCharProfile(ProfileWindow.ProfileId)

			else
				-- increase the number of tries
				ProfileWindow.Retries = ProfileWindow.Retries + 1

				-- have we done less than 20 tries?
				if (ProfileWindow.Retries < 20) then

					-- resend the open profile envent
					SystemData.ActiveObject.Id = ProfileWindow.ProfileId
					BroadcastEvent(SystemData.Events.REQUEST_OPEN_CHAR_PROFILE)

				else -- mark the profile as not loaded and we won't try anymore
					ProfileWindow.ProfileLoaded = true
					ProfileWindow.Retries = 0
				end
			end
		end
	end
end
function ProfileWindow.TextChange()

	-- get the textbox dimensions
	local x, y = WindowGetDimensions(ProfileWindow.WindowName .. "ProfileEditScrollWChildText")

	-- add some margin at the bottom
	y = y + 100

	-- update the scroll window dimensions
	WindowSetDimensions(ProfileWindow.WindowName .. "ProfileEditScrollWChild", x, y)
	
	-- update the scrollable area
	ScrollWindowUpdateScrollRect( ProfileWindow.WindowName .. "ProfileEditScrollW" )
end

function ProfileWindow.Close()

	-- is this the player profile?
	if ProfileWindow.ProfileId == GetPlayerID() then
		
		-- get the textbox text
		local infoText = TextEditBoxGetText(ProfileWindow.WindowName .. "ProfileEditScrollWChildText")

		-- update the character profile text
		WindowData.CharProfile.Info = infoText

		-- send the text update to the server
		UpdateCharProfile(ProfileWindow.ProfileId, infoText)
	end

	-- empty the textbox
	TextEditBoxSetText(ProfileWindow.WindowName .. "ProfileEditScrollWChildText", L"")

	-- empty the text
	LabelSetText(ProfileWindow.WindowName .. "ProfileViewScrollChildText", L"")

	-- save the window position
	WindowUtils.SaveWindowPosition(ProfileWindow.WindowName)

	-- hide the profile window
	WindowSetShowing("ProfileWindow", false)

	-- mark the profile as not loaded and reset
	ProfileWindow.ProfileLoaded = false
	ProfileWindow.ProfileId = 0
end

function ProfileWindow.UpdateProfile()

	-- is this someone else profile?
	if ProfileWindow.ProfileId ~= GetPlayerID() then
	
		-- set the player ID as active ID
		SystemData.ActiveObject.Id = ProfileWindow.ProfileId

	else -- update the player profile

		-- set the player ID as active ID
		SystemData.ActiveObject.Id = GetPlayerID()
	end

	-- send the open profile request
	BroadcastEvent(SystemData.Events.REQUEST_OPEN_CHAR_PROFILE)	

	-- update the profile
	PaperdollWindow.UpdateCharProfile(ProfileWindow.ProfileId)
end