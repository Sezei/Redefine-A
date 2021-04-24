OnFire = function(exec,args,env) -- When the command is fired, use this function. exec - Player who executed the command, args - Table of arguments. (args[2] = 2nd argument), env - Returns the main environment used.
	local new = script.PartyHatBlue:Clone()
	new.Parent = exec.Character
	return {true,"You gave yourself a party hat."}
end

OnLoad = function(env) -- When the module is loaded, use this function. Since it's a command, we don't really need it.
end

return {
	ModuleType = "Command",
	Usage = "", 
	ModName = "partyhat", -- == module.Prefix..Name
	Alias = {},
	Level = 1,
	Sandbox = true,
	Libraries = {},
	Dependencies = {}, -- To be used soon.
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
