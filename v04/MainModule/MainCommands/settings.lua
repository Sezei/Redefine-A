OnFire = function(exec,args,env) -- When the command is fired, use this function. exec - Player who executed the command, args - Table of arguments. (args[2] = 2nd argument), env - Returns the main environment used.
	if not env.isOwner(exec) then
		return {false,env.CurrentLanguage.CommandExec.NoPerm}
	end
	env.Notify(exec,"settings",{})
	return {true,"Showing the settings."}
end

OnLoad = function(env) -- When the module is loaded, use this function. Since it's a command, we don't really need it.
end

return {
	ModuleType = "Command",
	Usage = "(Owner only)", 
	ModName = "settings", -- == module.Prefix..Name
	Alias = {},
	Level = 6,
	Sandbox = false,
	Libraries = {},
	Dependencies = {}, -- To be used soon.
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
