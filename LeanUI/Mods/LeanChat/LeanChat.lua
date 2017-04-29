LoadResources( "./UserInterface/"..SystemData.Settings.Interface.customUiName.."/Mods/LeanChat", "LeanChatWindow.xml", "LeanChatWindow.xml" )

LeanChat = {}

function LeanChat.Initialize()
	LeanWindowManager.CreateWindow("LeanChatWindow", true, {
	   description = L"Chat Window in style of LeanUI"
	})
end

function LeanChat.Shutdown()
	LeanWindowManager.DestroyWindow("LeanChatWindow")
end
