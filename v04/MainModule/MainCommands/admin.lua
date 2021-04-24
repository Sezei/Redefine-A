OnFire = function(plr,arg,env) -- When the command is fired, use this function. exec - Player who executed the command, args - Table of arguments. (args[2] = 2nd argument), env - Returns the main environment used.
	if (env.GetLevel(plr) < 4 and arg[2] == "@me") or (env.GetLevel(plr) < 3 and arg[2] == plr.Name) then
		return {false,"Is admin really all you going for? Why not just "..env.Settings.Prefix.."super yourself, huh?"}
	elseif not arg[2] then
		return {false,"It would be better if you'd give someone to level-up, you don't want to lose Level "..env.GetLevel(plr).." permissions. Trust me."}
	end
	if arg[2] == "@all" then
		return {false,"It would be better if you'd use '@others' instead, if you want to give admin for everyone."}
	elseif arg[2] == "@others" then
		local adds = 0
		for _,v in pairs(game.Players:GetPlayers()) do
			if v.Name ~= plr.Name then
				if env.GetLevel(v) <= 3 then
					env.Admins.Admins[#env.Admins.Admins+1] = v.UserId
					adds = adds+1
					local isBan = env.GetLevel(v)
					env.Notify(v,"welcome","Your admin level in this server has been set to "..isBan..".")
				end
			end
		end
		return {true,"Successfully added "..adds.." as admins."}
	elseif arg[2] == "@me" then
		return {false,"It would be better if you'd give someone to level-up, you don't want to lose Level "..env.GetLevel(plr).." permissions. Trust me."}
	elseif string.sub(arg[2],1,1) == "#" then
		for _,v in pairs(env.usersfolder:GetChildren()) do
			local nv = env.splitstring(v.Value," ")
			if nv[1] == arg[2] then
				local p = env.Player(nv[3])
				if p then
					if p.Name ~= plr.Name then
						if env.GetLevel(p) < env.GetLevel(plr) then 
							env.Admins.Admins[#env.Admins.Admins+1] = p.UserId
							local isBan = env.GetLevel(p)
							env.Notify(p,"welcome","Your admin level in this server has been set to "..isBan..".")
							return {true,"Successfully added "..p.Name.." as an admin."}
						else
							return {false,"You can't give Admin to someone higher or equal to your level."}
						end
					else
						return {false,"It would be better if you'd give someone to level-up, you don't want to lose Level "..env.GetLevel(plr).." permissions. Trust me."}
					end
				else
					return {false,"An error has occured. Please try again later."}
				end
			end
		end
		return {false,"Local Player ID not found."}
	else
		local p = env.Player(arg[2])
		if p then
			if p.Name ~= plr.Name then
				if env.GetLevel(p) < env.GetLevel(plr) then 
					env.Admins.Admins[#env.Admins.Admins+1] = p.UserId
					local isBan = env.GetLevel(p)
					env.Notify(p,"welcome","Your admin level in this server has been set to "..isBan..".")
					return {true,"Successfully added "..p.Name.." as an admin."}
				else
					return {false,"You can't give Admin to someone higher or equal to your level."}
				end
			else
				return {false,"It would be better if you'd give someone to level-up, you don't want to lose Level "..env.GetLevel(plr).." permissions. Trust me."}
			end
		else 
			if arg[2] == "me" then
				return {false,"Player not found. Did you mean '@me'?"}
			elseif arg[2] == "others" then
				return {false,"Player not found. Did you mean '@others'?"}
			elseif arg[2] == "all" then
				return {false,"Player not found. Did you mean '@all'?"}
			else
				return {false,"Player not found OR You forgot to mark it as an alternative."} 
			end
		end
	end
end

OnLoad = function(env) -- When the module is loaded, use this function. Since it's a command, we don't really need it.
end

return {
	ModuleType = "Command",
	Usage = "<players>", 
	ModName = "admin", -- == module.Prefix..Name
	Alias = {"set3"},
	Level = 4,
	Sandbox = false,
	Libraries = {},
	Dependencies = {},
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
