OnFire = function(plr,arg,env)
	local targets = env.HandlePlayers(plr.Name,arg[2],2,false)
	if targets[1] == nil then
		return {false, env.CurrentLanguage.CommandExec.NoFound}
	elseif targets[1] == false then
		return {false, targets[2]}
	end
	local done = {0,""}
	for _,v in pairs(targets) do
		local Character = v.Character
		for _, cp in pairs(Character:GetChildren()) do
			if cp:IsA("BasePart") then
				cp.Anchored = false
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
	if done[1] >= 5 then
		return {true,"Successfully froze "..done[1].." people."}
	else
		return {true,done[2].." hast've been frozen."}
	end
end

OnLoad = function(env)
end

return {
	ModuleType = "Command",
	Usage = "<players>", 
	ModName = "thaw",
	Alias = {"unfreeze"},
	Level = 2,
	Sandbox = true,
	Libraries = {},
	Dependencies = {}, -- To be used soon.
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
