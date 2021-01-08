OnFire = function(plr,arg,env)
	if not arg[2] then
		return {false,"A player hasn't been mentioned."}
	end
	if not arg[3] then
		return {false,"A jumppower value hasn't been mentioned."}
	end

	local jp = tonumber(arg[3])

	local targets = env.HandlePlayers(plr.Name,arg[2],2,false)
	if targets[1] == nil then
		return {false, env.CurrentLanguage.CommandExec.NoFound}
	elseif targets[1] == false then
		return {false, targets[2]}
	end
	local done = {0,""}
	for _,v in pairs(targets) do
		v.Character.Humanoid.JumpPower = jp
		if done[2] ~= "" then
			done[2] = done[2]..", "..v.Name
			done[1] = done[1]+1
		else
			done[2] = v.Name
			done[1] = 1
		end
	end
	if done[1] >= 5 then
		return {true,"Successfully edited "..done[1].." people."}
	else
		return {true,"Successfully edited "..done[2].."."}
	end
end

OnLoad = function(env)
end

return {
	ModuleType = "Command",
	Usage = "<players> <power>", 
	ModName = "jumppower",
	Alias = {"jp"},
	Level = 2,
	Sandbox = true,
	Libraries = {},
	Dependencies = {}, -- To be used soon.
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
