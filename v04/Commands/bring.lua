OnFire = function(plr,arg,env)
	if not arg[2] then
		return {false,"You must include someone you want to bring."}
	end
	
	local targets = env.HandlePlayers(plr.Name,arg[2],2,false)
	if targets[1] == nil then
		return {false, env.CurrentLanguage.CommandExec.NoFound}
	elseif targets[1] == false then
		return {false, targets[2]}
	end
	local done = {0,""}
	for _,v in pairs(targets) do
		if (v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character.HumanoidRootPart:IsA("BasePart")) then
			v.Character.HumanoidRootPart.Velocity = Vector3.new()
			v.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(Vector3.new(math.random()-0.5,0,math.random()-0.5)*10)
		end
		if done[2] ~= "" then
			done[2] = done[2]..", "..v.Name
			done[1] = done[1]+1
		else
			done[2] = v.Name
			done[1] = 1
		end
	end
	if done[1] >= 5 then
		return {true,"Successfully brought "..done[1].." people."}
	else
		return {true,"Successfully brought "..done[2].."."}
	end
end

OnLoad = function(env)
end

return {
	ModuleType = "Command",
	Usage = "<players>", 
	ModName = "bring",
	Alias = {"tphere"},
	Level = 2,
	Sandbox = true,
	Libraries = {},
	Dependencies = {}, -- To be used soon.
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
