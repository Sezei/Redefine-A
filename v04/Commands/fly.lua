OnFire = function(plr,arg,env)
	if not arg[2] then
		if not plr.Character:FindFirstChild("fly") then
			local fly = script.fly:Clone()
			fly.Parent = plr.Character
			fly.Disabled = false
			return {true,"You made yourself fly in the sky!"} 
		else
			return {false,"You already have the necessary skill to fly! (Perhaps press X to fly again.)"}
		end
	end
	
	local targets = env.HandlePlayers(plr.Name,arg[2],2,false)
	if targets[1] == nil then
		return {false, env.CurrentLanguage.CommandExec.NoFound}
	elseif targets[1] == false then
		return {false, targets[2]}
	end
	local done = {0,""}
	for _,v in pairs(targets) do
		if not plr.Character:FindFirstChild("fly") then
			local fly = script.fly:Clone()
			fly.Parent = v.Character
			fly.Disabled = false
			if done[2] ~= "" then
				done[2] = done[2]..", "..v.Name
				done[1] = done[1]+1
			else
				done[2] = v.Name
				done[1] = 1
			end
		else end
	end
	if done[1] >= 5 then
		return {true,"Successfully made "..done[1].." people fly."}
	else
		return {true,"Successfully made "..done[2].." fly."}
	end
end

OnLoad = function(env)
end

return {
	ModuleType = "Command",
	Usage = "<players>", 
	ModName = "fly",
	Alias = {},
	Level = 3,
	Sandbox = true,
	Libraries = {},
	Dependencies = {}, -- To be used soon.
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
