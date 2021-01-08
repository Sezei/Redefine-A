OnFire = function(plr,arg,env)
	if not arg[2] then
		return {false,"A player hasn't been mentioned."}
	end
	if not arg[3] then
		return {false,"A speed value hasn't been mentioned. (Default Speed is 16)"}
	end

	local speed = tonumber(arg[3])
	local targets = env.HandlePlayers(plr.Name,arg[2],2,false)
	if targets[1] == nil then
		return {false, env.CurrentLanguage.CommandExec.NoFound}
	elseif targets[1] == false then
		return {false, targets[2]}
	end
	local done = {0,""}
	for _,v in pairs(targets) do
		v.Character.Humanoid.WalkSpeed = speed
		if done[2] ~= "" then
			done[2] = done[2]..", "..v.Name
			done[1] = done[1]+1
		else
			done[2] = v.Name
			done[1] = 1
		end
	end
	if done[1] >= 5 then
		return {true,"Successfully sped up "..done[1].." people."}
	else
		return {true,"Successfully sped up "..done[2].."."}
	end
end

OnLoad = function(env)
end

return {
	ModuleType = "Command",
	Usage = "<players> <speed>", 
	ModName = "speed",
	Alias = {},
	Level = 2,
	Sandbox = true,
	Libraries = {},
	Dependencies = {}, -- To be used soon.
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
