OnFire = function(plr,arg,env)
	if not arg[2] then
		return {false,"You must include someone you want to teleport to."}
	end

	if arg[2] == "@all" then
		return {false,"Alternatives are disabled for this command."}
	elseif arg[2] == "@others" then
		return {false,"Alternatives are disabled for this command."}
	elseif arg[2] == "@me" then
		return {false,"You must include someone ELSE you want to teleport to. (Also, Alternatives are disabled for this command either way.)"}
	elseif arg[2] == "@random" then -- FUN FACT! This is the ONLY command with '@random' in the entire admin!
		if (#game.Players:GetPlayers() < 2) then
			return {false,"You need at least 2 players in-game order to use this alternative."}
		end
		local random = ""
		while random == "" do
			for _,v in pairs(game.Players:GetPlayers()) do
				if v.Name ~= plr.Name then
					if math.random(1,100) == 100 then
						random = v.Name
						if random == plr.Name then
							random = ""
						end
					end
				end
			end
		end

		local r = env.Player(random)
		if (plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character.HumanoidRootPart:IsA("BasePart")) then
			plr.Character.HumanoidRootPart.Velocity = Vector3.new()
			plr.Character.HumanoidRootPart.CFrame = r.Character.HumanoidRootPart.CFrame * CFrame.new(Vector3.new(math.random()-0.5,0,math.random()-0.5)*10)
			return {true,"You teleported yourself to "..r.Name.."."}
		else
			return {false,"An error has occured."}
		end
	elseif string.sub(arg[2],1,1) == "#" then
		for _,v in pairs(env.usersfolder:GetChildren()) do
			local nv = env.splitstring(v.Value," ")
			if nv[1] == arg[2] then
				local p = env.Player(nv[3])
				if p then
					if (plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character.HumanoidRootPart:IsA("BasePart")) then
						plr.Character.HumanoidRootPart.Velocity = Vector3.new()
						plr.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(Vector3.new(math.random()-0.5,0,math.random()-0.5)*10)
						return {true,"You teleported yourself to "..p.Name.."."}
					else
						return {false,"An error has occured."}
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
			if (plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character.HumanoidRootPart:IsA("BasePart")) then
				plr.Character.HumanoidRootPart.Velocity = Vector3.new()
				plr.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(Vector3.new(math.random()-0.5,0,math.random()-0.5)*10)
				return {true,"You teleported yourself to "..p.Name.."."}
			else
				return {false,"An error has occured."}
			end
		else return {false,"Player not found."} end
	end
end

OnLoad = function(env)
end

return {
	ModuleType = "Command",
	Usage = "<players>", 
	ModName = "to",
	Alias = {"tp"},
	Level = 2,
	Sandbox = true,
	Libraries = {},
	Dependencies = {}, -- To be used soon.
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
