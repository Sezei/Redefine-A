OnFire = function(plr,arg,env)
	local tick1 = tick()
	local actualwait = wait();
	local tick2 = tick()
	local wait1 = math.abs(tick1-tick2)
	local tpsvalue = ("Server TPS: ".. env.round(1/wait1,2) .. " ["..env.round(wait1,3).."] ")
	if env.round(1/wait1,2) >= 32 then -- 32 - 33.33
		tpsvalue = tpsvalue.."(Perfect)"
	elseif env.round(1/wait1,2) >= 30 then -- 30 - 31.99
		tpsvalue = tpsvalue.."(Optimal)"
	elseif env.round(1/wait1,2) >= 27 then -- 27 - 29.99
		tpsvalue = tpsvalue.."(Good)"
	elseif env.round(1/wait1,2) >= 23 then -- 23 - 26.99
		tpsvalue = tpsvalue.."(Fine)"
	elseif env.round(1/wait1,2) >= 23 then -- 20 - 22.99
		tpsvalue = tpsvalue.."(Likely Laggy)"
	else -- 19.99 or below
		tpsvalue = tpsvalue.."(Laggy)"
	end
	
	local accuracy = "wait() Accuracy: " .. env.round((math.abs(actualwait - math.abs(tick1-tick2))*100),5) .." "
	if env.round((math.abs(actualwait - math.abs(tick1-tick2))*100),5) <= 0.0005 then
		accuracy = accuracy.."(Perfect)"
	elseif env.round((math.abs(actualwait - math.abs(tick1-tick2))*100),5) <= 0.001 then
		accuracy = accuracy.."(Very Accurate)"
	elseif env.round((math.abs(actualwait - math.abs(tick1-tick2))*100),5) <= 0.002 then
		accuracy = accuracy.."(Accurate)"
	elseif env.round((math.abs(actualwait - math.abs(tick1-tick2))*100),5) <= 0.005 then
		accuracy = accuracy.."(Likely Accurate)"
	elseif env.round((math.abs(actualwait - math.abs(tick1-tick2))*100),5) <= 0.01 then
		accuracy = accuracy.."(Likely Inaccurate)"
	elseif env.round((math.abs(actualwait - math.abs(tick1-tick2))*100),5) <= 0.02 then
		accuracy = accuracy.."(Inaccurate)"
	else
		accuracy = accuracy.."(Very Inaccurate)"
	end
	env.Notify(plr,"pnotification", tpsvalue.."\n"..accuracy)
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
