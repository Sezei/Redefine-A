OnFire = function(plr,arg,env)
	local tick1 = tick()
	wait();
	local tick2 = tick()
	local wait1 = math.abs(tick1-tick2)
	wait()
	env.Notify(plr,"pnotification","Server TPS: " .. env.round(1/wait1,2) .. " (Optimal: >30)\nwait() Time: " .. env.round(math.abs(tick1-tick2),5) .." (Optimal: <0.05)")
	return "none"
end

OnLoad = function(env)
end

return {
	ModuleType = "Command",
	Usage = "", 
	ModName = "tick",
	Alias = {"tickrate","lag","ping"},
	Level = 0,
	Sandbox = true,
	Libraries = {},
	Dependencies = {}, -- To be used soon.
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
