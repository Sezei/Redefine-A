OnFire = function(plr,arg,env)
	if not arg[2] then
		if plr.Character.HumanoidRootPart:FindFirstChild("Sparkles") then
			plr.Character.HumanoidRootPart.Sparkles:Destroy()
			return {true,"You've removed the sparkles from yourself."} 
		else
			return {false,"You're not sparkling."}
		end
	end

	if arg[2] == "@all" then
		if env.GetLevel(plr) < 3 then
			return {false,env.CurrentLanguage.CommandExec.VIPNoOther}
		end
		local adds = 0
		for _,v in pairs(game.Players:GetPlayers()) do
			if v.Character.HumanoidRootPart:FindFirstChild("Sparkles") then
				v.Character.HumanoidRootPart.Sparkles:Destroy()
				adds = adds+1
			end
		end
		return {true,"Successfully removed sparkles from "..adds.." players."}
	elseif arg[2] == "@others" then
		if env.GetLevel(plr) < 2 then
			return {false,env.CurrentLanguage.CommandExec.VIPNoOther}
		end	
		local adds = 0
		for _,v in pairs(game.Players:GetPlayers()) do
			if v.Name ~= plr.Name then
				if v.Character.HumanoidRootPart:FindFirstChild("Sparkles") then
					v.Character.HumanoidRootPart.Sparkles:Destroy()
					adds = adds+1
				end
			end
		end
		return {true,"Successfully removed sparkles from "..adds.." players."}
	elseif arg[2] == "@me" then
		if plr.Character.HumanoidRootPart:FindFirstChild("Sparkles") then
			plr.Character.HumanoidRootPart.Sparkles:Destroy()
			return {true,"You've removed the sparkles from yourself."} 
		else
			return {false,"You're not sparkling."}
		end
	elseif string.sub(arg[2],1,1) == "#" then
		if env.GetLevel(plr) < 2 then
			return {false,env.CurrentLanguage.CommandExec.VIPNoOther}
		end	
		for _,v in pairs(env.usersfolder:GetChildren()) do
			local nv = env.splitstring(v.Value," ")
			if nv[1] == arg[2] then
				local p = env.Player(nv[3])
				if p then
					if p.Character.HumanoidRootPart:FindFirstChild("Sparkles") then
						p.Character.HumanoidRootPart.Sparkles:Destroy()
						return {true,p.Name.."'s sparkles have removed."} 
					else
						return {false,p.Name.." is not sparkling though..."}
					end
				else
					return {false,"An error has occured. Please try again later."}
				end
			end
		end
		return {false,"Local Player ID not found."}
	else
		if env.GetLevel(plr) < 2 then
			return {false,env.CurrentLanguage.CommandExec.VIPNoOther}
		end	
		local p = env.Player(arg[2])
		if p then
			if p.Character.HumanoidRootPart:FindFirstChild("Sparkles") then
				p.Character.HumanoidRootPart.Sparkles:Destroy()
				return {true,p.Name.."'s sparkles have removed."} 
			else
				return {false,p.Name.." is not sparkling though..."}
			end
		else  
			if arg[2] == "me" then
				return {false,"Player not found. Did you mean '@me'?"}
			elseif arg[2] == "others" then
				return {false,"Player not found. Did you mean '@others'?"}
			elseif arg[2] == "all" then
				return {false,"Player not found. Did you mean '@all'?"}
			else
				return {false,env.CurrentLanguage.CommandExec.NoFound} 
			end
		end
	end
end

OnLoad = function(env)
end

return {
	ModuleType = "Command",
	Usage = "[2+: players]", 
	ModName = "unsparkle",
	Alias = {"unspark"},
	Level = 1,
	Sandbox = true,
	Libraries = {},
	Dependencies = {}, -- To be used soon.
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
