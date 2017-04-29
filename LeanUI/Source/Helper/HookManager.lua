
HookManager = {}

HookManager.POSITION_PRE = 0
HookManager.POSITION_POST = 1

HookManager.Hooks = {
	HookManager.POSITION_PRE  = {},
	HookManager.POSITION_POST = {}
}

HookManager.BaseHooks = {}
HookManager.BaseFunctions = {}

function HookManager.Initialize()

end

function HookManager.AddHookFunction(functionName, hookFunction, position)
	-- Register the hook function
	if HookManager.Hooks[position][functionName] ~= nil then
		HookManager.Hooks[position][functionName] = {}
	end

	table.insert(HookManager.Hooks[position][functionName], hookFunction)
	
	-- If functionName is not yet hooked, add a new base hook to it
	if HookManager.BaseHooks[functionName] == nil then
		HookManager.BaseFunctions[functionName] = functionName
	end
end 

---------------------
-- private 
---------------------

local function HookManager.BaseHookFunction(...)

end