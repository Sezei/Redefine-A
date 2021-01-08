OnFire = function(plr,arg,env) -- When the command is fired, use this function. exec - Player who executed the command, args - Table of arguments. (args[2] = 2nd argument), env - Returns the main environment used.
	local update = env.SaveAdmins(env.Admins)
	if update then
		return {true, "Successfully saved current Admin List."}
	end
end

OnLoad = function(env) -- When the module is loaded, use this function. Since it's a command, we don't really need it.
end

return {
	ModuleType = "Command",
	Usage = "", 
	ModName = "saveadmins", -- == module.Prefix..Name
	Alias = {},
	Level = 4,
	Sandbox = false,
	Libraries = {},
	Dependencies = {}, -- To be used soon.
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
