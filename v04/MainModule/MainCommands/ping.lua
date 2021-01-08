OnFire = function(plr,arg,env)
	local startPing = tick()
	env.func:InvokeClient(plr,{"GetPing",startPing,os.time()})
	return "none"
end

OnLoad = function(env)
end

return {
	ModuleType = "Command",
	Usage = "", 
	ModName = "ping",
	Alias = {},
	Level = 0,
	Sandbox = true,
	Libraries = {},
	Dependencies = {}, -- To be used soon.
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
