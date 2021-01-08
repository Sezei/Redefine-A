OnFire = function(plr,arg,env)	
	env.pmessage = {false,""}
	return{true,"The message was cleared."}
end

OnLoad = function(env)
end

return {
	ModuleType = "Command",
	Usage = "", 
	ModName = "clearmessage",
	Alias = {"clrpm"},
	Level = 3,
	Sandbox = true,
	Libraries = {},
	Dependencies = {}, -- To be used soon.
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
