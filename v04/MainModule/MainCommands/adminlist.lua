OnFire = function(plr,arg,env) -- When the command is fired, use this function. exec - Player who executed the command, args - Table of arguments. (args[2] = 2nd argument), env - Returns the main environment used.
	env.Notify(plr,"onlineadmins",{})
	return {true,"Showing online staff."}
end

OnLoad = function(env) -- When the module is loaded, use this function. Since it's a command, we don't really need it.
end

return {
	ModuleType = "Command",
	Usage = "", 
	ModName = "admins", -- == module.Prefix..Name
	Alias = {"staff","adminlist","onlinestaff"},
	Level = 0,
	Sandbox = true,
	Libraries = {},
	Dependencies = {},
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
