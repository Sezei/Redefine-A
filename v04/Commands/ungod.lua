OnFire = function(plr,arg,env)
	local targets = env.HandlePlayers(plr.Name,arg[2],2,false)
	if targets[1] == nil then
		return {false, env.CurrentLanguage.CommandExec.NoFound}
	elseif targets[1] == false then
		return {false, targets[2]}
	end
	local done = {0,""}
	for _,v in pairs(targets) do
		v.Character.Humanoid.MaxHealth = 100
		v.Character.Humanoid.Health = v.Character.Humanoid.MaxHealth
		if done[2] ~= "" then
			done[2] = done[2]..", "..v.Name
			done[1] = done[1]+1
		else
			done[2] = v.Name
			done[1] = 1
		end
	end
	if done[1] >= 2 then
		return {true,"Successfully turned "..done[1].." people into mortals."}
	else
		return {true,"Successfully turned "..done[2].." into a mortal."}
	end
end

OnLoad = function(env)
end

return {
	ModuleType = "Command",
	Usage = "<players>", 
	ModName = "ungod",
	Alias = {},
	Level = 3,
	Sandbox = true,
	Libraries = {},
	Dependencies = {}, -- To be used soon.
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
