----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

UO_DefaultWindow = {}

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

UO_DefaultWindow.WindowDestroyQueue = {}

----------------------------------------------------------------
-- MainMenuWindow Functions
----------------------------------------------------------------


-- OnInitialize Handler
function UO_DefaultWindow.Initialize()
	WindowSetAlpha(SystemData.ActiveWindow.name.."_UO_DefaultWindowBackground", 0.8);
end

function UO_DefaultWindow.CloseDialog()
	local activeDialog = WindowUtils.GetActiveDialog()
	
	if ContainerWindow then
		local id = WindowGetId(activeDialog)	
		if id and id == ContainerWindow.PlayerBackpack then
			Interface.BackpackOpen = false
			Interface.SaveSetting( "BackpackOpen", Interface.BackpackOpen )
		end
	end
	
	--If the On Close Callback is not nil that means the window has a call back function they want to run before
	--the window closes
	if (Interface.OnCloseCallBack[activeDialog] ~= nil) then
		Interface.OnCloseCallBack[activeDialog]()
	end
	
	if DoesWindowExist( activeDialog) then
		if (Interface.DestroyWindowOnClose[activeDialog] ~= nil) then
			DestroyWindow(activeDialog)
		else
			WindowSetShowing(activeDialog, false)
		end
		if DoesWindowExist( activeDialog.."Chrome_UO_WindowCloseButton") then 
			ButtonSetPressedFlag(activeDialog.."Chrome_UO_WindowCloseButton", false)
		end
	end
end

function UO_DefaultWindow.CloseTooltip()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1052061))
end

function UO_DefaultWindow.CloseParent()
    WindowSetShowing(WindowGetParent(SystemData.ActiveWindow.name), false)
end
