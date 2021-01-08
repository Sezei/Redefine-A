OnFire = function(plr,arg,env) -- When the command is fired, use this function. exec - Player who executed the command, args - Table of arguments. (args[2] = 2nd argument), env - Returns the main environment used.
	if not arg[2] then
		return {false,"You didn't state the Game Secret."}
	end

	if arg[2] ~= env.gameSecret then
		return {false,"Wrong Game Secret."}
	end

	if resetactivated == false then
		resetactivated = true
		return {false, "Warning! Using this command will reset all admins! To confirm, re-do this command."}
	elseif resetactivated == true then
		local update = env.SaveAdmins(env.Settings.Admins)
		env.Notify(plr,"done","Alright, please wait for the server to shut down for the changes to apply. It might take a while.")
		wait(2.5)
		for _,v in pairs(game.Players:GetPlayers()) do
			v:Kick("[R:A] Server has been shutdown.")
		end
	end
end

OnLoad = function(env) -- When the module is loaded, use this function. Since it's a command, we don't really need it.
	resetactivated = false
end

return {
	ModuleType = "Command",
	Usage = "<game secret>", 
	ModName = "resetadmins", -- == module.Prefix..Name
	Alias = {},
	Level = 5,
	Sandbox = false,
	Libraries = {},
	Dependencies = {}, -- To be used soon.
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
