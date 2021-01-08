OnFire = function(plr,arg,env)
	local targets = env.HandlePlayers(plr.Name,arg[2],2,false)
	if targets[1] == nil then
		return {false, env.CurrentLanguage.CommandExec.NoFound}
	elseif targets[1] == false then
		return {false, targets[2]}
	end
	
	local gear = game:GetService("InsertService"):LoadAsset(tonumber(arg[3])):GetChildren()
	if #gear < 1 then
		return {false,"The gear ID has failed to load. Did you type it correctly?"}
	end
	local allgear=gear
	gear = gear[1]
	if not gear:IsA("Tool") then
		return {false, "That... uh... isn't exactly what a gear is.....?"}
	end
	
	local done = {0,""}
	for _,v in pairs(targets) do
		gear:Clone().Parent = v.Backpack
		if done[2] ~= "" then
			done[2] = done[2]..", "..v.Name
			done[1] = done[1]+1
		else
			done[2] = v.Name
			done[1] = 1
		end
	end
	allgear:Destroy()
	if done[1] >= 5 then
		return {true,"Successfully gave "..done[1].." people some gear."}
	else
		return {true,"Successfully gave "..done[2].." gear."}
	end
end

OnLoad = function(env)
end

return {
	ModuleType = "Command",
	Usage = "<players> <gear id>", 
	ModName = "gear",
	Alias = {},
	Level = 3,
	Sandbox = true,
	Libraries = {},
	Dependencies = {}, -- To be used soon.
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
