OnFire = function(plr,arg,env)
	if not arg[2] then
		if not plr.Character.HumanoidRootPart:FindFirstChild("Fire") then
			local fly = Instance.new("Fire")
			fly.Parent = plr.Character:FindFirstChild("HumanoidRootPart")
			return {true,"You've made yourself burn."} 
		else
			return {false,"You're already burning!"}
		end
	end

	if arg[2] == "@all" then
		if env.GetLevel(plr) < 2 then
			return {false,env.CurrentLanguage.CommandExec.VIPNoOther}
		end
		local adds = 0
		for _,v in pairs(game.Players:GetPlayers()) do
			if not v.Character.HumanoidRootPart:FindFirstChild("Fire") then
				local fire = Instance.new("Fire")
				fire.Parent = v.Character:FindFirstChild("HumanoidRootPart")
				adds = adds+1
			end
		end
		return {true,"Successfully made "..adds.." players burn in flames!"}
	elseif arg[2] == "@others" then
		if env.GetLevel(plr) < 2 then
			return {false,env.CurrentLanguage.CommandExec.VIPNoOther}
		end	
		local adds = 0
		for _,v in pairs(game.Players:GetPlayers()) do
			if v.Name ~= plr.Name then
				if not v.Character.HumanoidRootPart:FindFirstChild("Fire") then
					local fire = Instance.new("Fire")
					fire.Parent = v.Character:FindFirstChild("HumanoidRootPart")
					adds = adds+1
				end
			end
		end
		return {true,"Successfully made "..adds.." players burn in flames!"}
	elseif arg[2] == "@me" then
		if not plr.Character.HumanoidRootPart:FindFirstChild("Fire") then
			local fly = Instance.new("Fire")
			fly.Parent = plr.Character:FindFirstChild("HumanoidRootPart")
			return {true,"You've made yourself burn."} 
		else
			return {false,"You're already burning!"}
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
					if not p.Character.HumanoidRootPart:FindFirstChild("Fire") then
						local fly = Instance.new("Fire")
						fly.Parent = p.Character:FindFirstChild("HumanoidRootPart")
						return {true,p.Name.." is now burning in flames!"} 
					else
						return {false,p.Name.." is already burning!"}
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
			if not p.Character.HumanoidRootPart:FindFirstChild("Fire") then
				local fly = Instance.new("Fire")
				fly.Parent = p.Character:FindFirstChild("HumanoidRootPart")
				return {true,p.Name.." is now burning in flames!"} 
			else
				return {false,p.Name.." is already burning!"}
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
	ModName = "fire",
	Alias = {"burn"},
	Level = 1,
	Sandbox = true,
	Libraries = {},
	Dependencies = {}, -- To be used soon.
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
