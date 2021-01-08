OnFire = function(plr,arg,env)
	if not arg[2] then
		return {false,"You must provide a target."}
	end
	if not arg[3] then
		return {false,"You must provide a scale."}
	end
	
	local targets = env.HandlePlayers(plr.Name,arg[2],2,false)
	if targets[1] == nil then
		return {false, env.CurrentLanguage.CommandExec.NoFound}
	elseif targets[1] == false then
		return {false, targets[2]}
	end
	local done = {0,""}
	for _,v in pairs(targets) do
		if v.Character.Humanoid then
			if v.Character.Humanoid.RigType == Enum.HumanoidRigType.R15 then
				Scale(v.Character.Humanoid,tonumber(arg[3]))
			elseif v.Character.Humanoid.RigType == Enum.HumanoidRigType.R6 then
				return {false,"This command does not support R6 yet."}
			end
		end
		if done[2] ~= "" then
			done[2] = done[2]..", "..v.Name
			done[1] = done[1]+1
		else
			done[2] = v.Name
			done[1] = 1
		end
	end
	if done[1] >= 3 then
		return {true,"Successfully resized "..done[1].." people."}
	else
		return {true,"Successfully resized "..done[2].."."}
	end
end

OnLoad = function(env)
	function Scale(humanoid,sizemultiplier)
		if humanoid then
			humanoid.BodyDepthScale.Value = humanoid.BodyDepthScale.Value * sizemultiplier
			humanoid.BodyHeightScale.Value = humanoid.BodyHeightScale.Value * sizemultiplier
			humanoid.BodyWidthScale.Value = humanoid.BodyWidthScale.Value * sizemultiplier
			humanoid.HeadScale.Value = humanoid.HeadScale.Value * sizemultiplier
		else
			return
		end
	end
end

return {
	ModuleType = "Command",
	Usage = "<players> <scale multiplier>", 
	ModName = "resize",
	Alias = {},
	Level = 3,
	Sandbox = true,
	Libraries = {},
	Dependencies = {}, -- To be used soon.
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
