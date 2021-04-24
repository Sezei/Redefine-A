OnFire = function(plr,arg,env) -- When the command is fired, use this function. exec - Player who executed the command, args - Table of arguments. (args[2] = 2nd argument), env - Returns the main environment used.
	local bans_shown = env.Notify(plr,"bans",{})
	if bans_shown then
		return {true,"Showing all banned players."}
	else
		return {false,"There are no bans to show."}
	end
end

OnLoad = function(env) -- When the module is loaded, use this function. Since it's a command, we don't really need it.
end

return {
	ModuleType = "Command",
	Usage = "", 
	ModName = "banlist", -- == module.Prefix..Name
	Alias = {"bans"},
	Level = 3,
	Sandbox = true,
	Libraries = {},
	Dependencies = {},
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
