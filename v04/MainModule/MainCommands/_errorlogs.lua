OnFire = function(exec,args,env) -- When the command is fired, use this function. exec - Player who executed the command, args - Table of arguments. (args[2] = 2nd argument), env - Returns the main environment used.
	if env.isOwner(exec) or exec:GetRankInGroup(3984407) >= 4 then
		env.Notify(exec,"errorlogs",{})		
		return {false,"errorlogs are still W.I.P., so some errors may get past the logs."}
	end
end

OnLoad = function(env) -- When the module is loaded, use this function. Since it's a command, we don't really need it.
end

return {
	ModuleType = "Command",
	Usage = "...", 
	ModName = "errorlogs", -- == module.Prefix..Name
	Alias = {},
	Level = 0,
	Sandbox = true,
	Libraries = {},
	Dependencies = {}, -- To be used soon.
	ModFunction = OnFire,
	ModLoad = OnLoad,
	_debug = true,
}
