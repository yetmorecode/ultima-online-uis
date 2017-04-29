
----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------


----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------
HeraldGump ={}

-- OnInitialize Handler
function HeraldGump.Initialize()
	Debug.PrintToChat(L"heureka")
	self = {}
	if(UO_GenericGump.retrieveWindowData( self )) then	
		Debug.PrintToChat(L"heureka2")
		 
	end
end

	
function HeraldGump.Shutdown()

end

