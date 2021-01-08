OnFire = function(plr,arg,env)
	if not arg[2] then
		if env.GetLevel(plr) < 2 then
			return {false,"You do not have permission to view the warnings list."}
		end
		local info = {}
		for k,v in pairs(warns) do
			if info[v["Target"]] then
				info[v["Target"]] = info[v["Target"]]+1
			else
				info[v["Target"]] = 1
			end
		end
		env.Notify(plr,"customlist",{"All Warnings",info})
	elseif env.Player(arg[2]) or arg[2] == "@me" then
		if env.GetLevel(plr) < 2 then
			return {false,"You do not have permission to view warnings."}
		end
		if arg[2] == "@me" then
			arg[2] = plr.Name
		end
		local info = {}
		for k,v in pairs(warns) do
			if v["Target"] == env.Player(arg[2]).Name then
				info[k] = v["Reason"]
			end
		end
		env.Notify(plr,"customlist",{env.Player(arg[2]).Name.."'s Warns",info})
	elseif warns[tonumber(arg[2])] then
		if env.GetLevel(plr) < 2 then
			return {false,"You do not have permission to view warnings."}
		end
		local info = warns[tonumber(arg[2])]
		env.Notify(plr,"customlist",{"Warning "..arg[2],info})
	end
end

function OnLoad(env)
	warns = env.cmdstorage.warns;
end

return {
	ModuleType = "Command",
	Usage = "<args>", 
	ModName = "warns",
	Alias = {"warnlist"},
	Level = 2,
	Sandbox = true,
	Libraries = {},
	Dependencies = {}, -- To be used soon.
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
