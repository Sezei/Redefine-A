OnFire = function(plr,arg,env)
	env.serverlock = {false,0}
	return {true,"The server has been unlocked."}
end

OnLoad = function(env)
end

return {
	ModuleType = "Command",
	Usage = "", 
	ModName = "unslock",
	Alias = {"sloff"},
	Level = 4,
	Sandbox = false,
	Libraries = {},
	Dependencies = {}, -- To be used soon.
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
