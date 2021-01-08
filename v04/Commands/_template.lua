OnFire = function(exec,args,env) -- When the command is fired, use this function. exec - Player who executed the command, args - Table of arguments. (args[2] = 2nd argument), env - Returns the main environment used.
	return {true,"Hello!"} -- This will return "Hello!" with green text (== env.Notify(plr,"done","Hello!"))
end

OnLoad = function(env) -- When the module is loaded, use this function. Since it's a command, we don't really need it.
	-- You can set your own 
	env.TestCommandFired = 0
end

return {
	ModuleType = "Command",
	Usage = "", -- In the !cmds command: Level | [Prefix]ModName Usage. Keep as "" if there are no args.
	ModName = "test", -- == module.Prefix..Name
	Alias = {"helloworld"},
	Level = 0,
	Sandbox = true,
	Libraries = {},
	Dependencies = {}, -- To be used soon.
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
