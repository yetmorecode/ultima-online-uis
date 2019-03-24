----------------------------------------------------------------
-- LuaUtils Global Variables
----------------------------------------------------------------    
Utils = {}
Profiles = {}

----------------------------------------------------------------
-- LuaUtils Functions
----------------------------------------------------------------    
function Utils.Profile(name)

	if Profiles[name] == nil then

	Profiles[name] = 1

	else
	Profiles[name] = Profiles[name] + 1
	end
end

function Utils.Print()
Debug.Print(Profiles)
end
