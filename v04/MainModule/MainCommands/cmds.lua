OnFire = function(exec,args,env) -- When the command is fired, use this function. exec - Player who executed the command, args - Table of arguments. (args[2] = 2nd argument), env - Returns the main environment used.
	if not args[2] then
		env.Notify(exec,"cmds",env.Commands)
	elseif string.lower(args[2]) == "-all" then
		env.Notify(exec,"allcmds",env.Commands)
	end
	return {true,"Showing the loaded "..(#env.Commands).." commands."}
end

OnLoad = function(env) -- When the module is loaded, use this function. Since it's a command, we don't really need it.
end

return {
	ModuleType = "Command",
	Usage = "(You are viewing them right now)", 
	ModName = "cmds", -- == module.Prefix..Name
	Alias = {"help"},
	Level = 0,
	Sandbox = true,
	Libraries = {},
	Dependencies = {}, -- To be used soon.
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
