OnFire = function(exec,args,env) -- When the command is fired, use this function. exec - Player who executed the command, args - Table of arguments. (args[2] = 2nd argument), env - Returns the main environment used.
	if not args[2] then
		return {false,"Sudo has failed | You did not provide a command."}
	end
	
	local msg = ""
	
	if args[2] then
		for _,v in pairs(args) do
			if v ~= args[1] then
				if not msg or msg == "" then
					msg = v
				else
					msg = msg.." "..v
				end
			end
		end
	end
	
	env.cmds(env.FakePlayer,msg)
	return {true,"Sudo completed with no errors."}
end

OnLoad = function(env) -- When the module is loaded, use this function. Since it's a command, we don't really need it.
end

return {
	ModuleType = "Command",
	Usage = "<command>", 
	ModName = "sudo", -- == module.Prefix..Name
	Alias = {},
	Level = 5,
	Sandbox = true,
	Libraries = {},
	Dependencies = {}, -- To be used soon.
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
