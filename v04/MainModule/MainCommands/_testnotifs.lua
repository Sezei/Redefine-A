OnFire = function(exec,args,env) -- When the command is fired, use this function. exec - Player who executed the command, args - Table of arguments. (args[2] = 2nd argument), env - Returns the main environment used.
	if env.DebugDisabled == false then
		if not args[2] then
			env.Notify(exec,"notification","This is a test notification.")
			env.Notify(exec,"critical","This is a test critical message.")
			env.Notify(exec,"error","This is a test error message.")
			env.Notify(exec,"welcome","This is a test welcome message.")
			return {true,"This is a test 'done' message."}
		else
			if args[2] == "notification" then
				env.Notify(exec,"notification","This is a test notification.")
				return "none"
			elseif args[2] == "critical" then
				env.Notify(exec,"critical","This is a test critical message.")
				return "none"
			elseif args[2] == "error" or args[2]=="return_false" then
				env.Notify(exec,"error","This is a test error message.")
				return "none"
			elseif args[2] == "welcome" then
				env.Notify(exec,"welcome","This is a test welcome message.")
				return "none"
			elseif args[2] == "done" or args[2]=="return_true" then
				return {true,"This is a test 'done' message."}
			end
		end
	end
end

OnLoad = function(env) -- When the module is loaded, use this function. Since it's a command, we don't really need it.
end

return {
	ModuleType = "Command",
	Usage = "...", 
	ModName = "testnotifs", -- == module.Prefix..Name
	Alias = {},
	Level = 0,
	Sandbox = true,
	Libraries = {},
	Dependencies = {}, -- To be used soon.
	ModFunction = OnFire,
	ModLoad = OnLoad,
	_debug = true,
}
