OnFire = function(exec,args,env) -- When the command is fired, use this function. exec - Player who executed the command, args - Table of arguments. (args[2] = 2nd argument), env - Returns the main environment used.
	env.Notify(exec,"lpids",{})
	return {true,"Showing the Local Player IDs for all of the players."}
end

OnLoad = function(env) -- When the module is loaded, use this function. Since it's a command, we don't really need it.
end

return {
	ModuleType = "Command",
	Usage = "", 
	ModName = "lpid", -- == module.Prefix..Name
	Alias = {"lpids"},
	Level = 0,
	Sandbox = true,
	Libraries = {},
	Dependencies = {}, -- To be used soon.
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
