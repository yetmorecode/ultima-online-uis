----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

TipoftheDayWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

TipoftheDayWindow.tipIndex = 0
TipoftheDayWindow.saveOnClose = false

TipoftheDayWindow.TID = { TipoftheDay = 1094689, Show = 303, Next = 1043353, Close = 1052061 }

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function TipoftheDayWindow.Initialize()

	-- set the window to be destroyed on close
	Interface.DestroyWindowOnClose["TipoftheDayWindow"] = true
		
	-- set window title
	WindowUtils.SetWindowTitle("TipoftheDayWindow", GetStringFromTid(TipoftheDayWindow.TID.TipoftheDay) )
	
	-- set the checkbox label text
	LabelSetText( "TipoftheDayLabel", GetStringFromTid(TipoftheDayWindow.TID.Show) )
	
	-- set the next button text
	ButtonSetText("TipoftheDayWindowNext", GetStringFromTid(TipoftheDayWindow.TID.Next) )

	-- set the close button text
	ButtonSetText("TipoftheDayWindowClose", GetStringFromTid(TipoftheDayWindow.TID.Close) )
	
	-- update the checkbox value
	ButtonSetPressedFlag( "TipoftheDayButton", SystemData.Settings.Interface.showTipoftheDay )

	-- Load up the Tip of the Day data
	UOBuildTableFromCSV("Data/GameData/tipoftheday.csv", "TipoftheDayCSV")

	-- show the tip
	TipoftheDayWindow.GetRandomTip()

	-- restore the window position
	WindowUtils.RestoreWindowPosition("TipoftheDayWindow")
end

function TipoftheDayWindow.Shutdown()
	
	-- unload the tips of the day CSV
	UOUnloadCSVTable("TipoftheDayCSV")
	
	-- save the window position
	WindowUtils.SaveWindowPosition("TipoftheDayWindow")
end

function TipoftheDayWindow.GetRandomTip()

	-- get a random tip ID
	TipoftheDayWindow.tipIndex = GetRandomNumber( #WindowData.TipoftheDayCSV ) + 1

	-- show the tip text
	LabelSetText("TipoftheDayWindowText", GetStringFromTid(WindowData.TipoftheDayCSV[TipoftheDayWindow.tipIndex].TipTID) )
end

function TipoftheDayWindow.ButtonUpNext()

	-- get the next tip ID
	TipoftheDayWindow.tipIndex = TipoftheDayWindow.tipIndex + 1
	
	-- is the tooltip ID higher than the max?
	if TipoftheDayWindow.tipIndex > #WindowData.TipoftheDayCSV then

		-- restart the ID from 1
		TipoftheDayWindow.tipIndex = 1
	end
	
	-- show the tip text
	LabelSetText("TipoftheDayWindowText", GetStringFromTid(WindowData.TipoftheDayCSV[TipoftheDayWindow.tipIndex].TipTID) )
end

function TipoftheDayWindow.ButtonUpClose()

	-- destroy the tips window
	DestroyWindow("TipoftheDayWindow")
end