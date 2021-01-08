OnFire = function(plr,arg,env)
	local targets = env.HandlePlayers(plr.Name,arg[2],2,false)
	if targets[1] == nil then
		return {false, env.CurrentLanguage.CommandExec.NoFound}
	elseif targets[1] == false then
		return {false, targets[2]}
	end
	local done = {0,""}
	for _,v in pairs(targets) do
		v.Character.Humanoid.Health = 0
		if done[2] ~= "" then
			done[2] = done[2]..", "..v.Name
			done[1] = done[1]+1
		else
			done[2] = v.Name
			done[1] = 1
		end
	end
	local done = {0,""}
	for _,v in pairs(targets) do
		v.Character.Humanoid.Health = 0
		local new = script.smite_local:Clone()
		local part = Instance.new("Part")
		local light = Instance.new("PointLight",v.Character.HumanoidRootPart)
		part.Parent = v.Character.HumanoidRootPart
		part.Size = Vector3.new(3,500,3)
		part.Position = Vector3.new(v.Character.HumanoidRootPart.Position.X,(v.Character.HumanoidRootPart.Position.Y+245),v.Character.HumanoidRootPart.Position.Z)
		part.BrickColor = BrickColor.White()
		part.Orientation = Vector3.new(0,math.random(0,90),0)
		light.Brightness = 5
		light.Color = Color3.new(255,255,255)
		part.Transparency = 0.5
		new.Parent = v.PlayerGui
		new.Disabled = false
		wait(0.2)
		part:Destroy()
		light:Destroy()
		if done[2] ~= "" then
			done[2] = done[2]..", "..v.Name
			done[1] = done[1]+1
		else
			done[2] = v.Name
			done[1] = 1
		end
	end
	if done[1] >= 5 then -- Stop contacting me abot the grammar. It's correct. >:L
		return {true,"Successfully smote "..done[1].." people."}
	else
		return {true,"Successfully smitten "..done[2].."."}
	end
end

OnLoad = function(env)
end

return {
	ModuleType = "Command",
	Usage = "<players>", 
	ModName = "smite",
	Alias = {"zeus"},
	Level = 2,
	Sandbox = true,
	Libraries = {},
	Dependencies = {}, -- To be used soon.
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
