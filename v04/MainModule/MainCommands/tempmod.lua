OnFire = function(plr,arg,env) -- When the command is fired, use this function. exec - Player who executed the command, args - Table of arguments. (args[2] = 2nd argument), env - Returns the main environment used.
	if not arg[2] then
		return {false,"A target is required."}
	end
	if arg[2] == "@all" then
		return {false,"This level is very dangerous to give to all players. Please avoid using this command with alternatives."}
	elseif arg[2] == "@others" then
		return {false,"This level is very dangerous to give to others. Please avoid using this command with alternatives."}
	elseif arg[2] == "@me" then
		return {true,"👌"}
	elseif string.sub(arg[2],1,1) == "#" then
		for _,v in pairs(env.usersfolder:GetChildren()) do
			local nv = env.splitstring(v.Value," ")
			if nv[1] == arg[2] then
				local p = env.Player(nv[3])
				if p then
					if p.Name ~= plr.Name then
						if env.GetLevel(p) < env.GetLevel(plr) then 
							env.templevels.mod[#env.templevels.mod+1] = p.UserId
							local isBan = env.GetLevel(p)
							env.Notify(p,"welcome","Your admin level has temporarily been set to "..isBan..".")
							return {true,"Successfully added "..p.Name.." as an temporary "..env.CurrentLanguage.Levels.Mod.."."}
						else
							return {false,"You can't give Moderator to someone higher or equal to your level."}
						end
					else
						return {false,"👌"}
					end
				else
					return {false,"An unknown error has occured. Please try again later."}
				end
			end
		end
		return {false,"Local Player ID not found."}
	else
		local p = env.Player(arg[2])
		if p then
			if p.Name ~= plr.Name then
				if env.GetLevel(p) < env.GetLevel(plr) then 
					env.templevels.mod[#env.templevels.mod+1] = p.UserId
					local isBan = env.GetLevel(p)
					env.Notify(p,"welcome","Your admin level has temporarily been set to "..isBan..".")
					return {true,"Successfully added "..p.Name.." as an temporary "..env.CurrentLanguage.Levels.Mod.."."}
				else
					return {false,"You can't give Moderator to someone higher or equal to your level."}
				end
			else
				return {false,"👌"}
			end
		else 
			return {false,"Player not found OR You forgot to mark it as an alternative."} 
		end
	end
end

OnLoad = function(env) -- When the module is loaded, use this function. Since it's a command, we don't really need it.
end

return {
	ModuleType = "Command",
	Usage = "<player>", 
	ModName = "tempmod", -- == module.Prefix..Name
	Alias = {"tempmoderator","temp2"},
	Level = 3,
	Sandbox = false,
	Libraries = {},
	Dependencies = {},
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
