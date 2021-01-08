OnFire = function(plr,arg,env)
	if not arg[2] then
		if plr.Character:FindFirstChild("fly") then
			plr.Character.fly:Destroy()
			return {true,"You forgot how to fly now."} 
		else
			return {false,"You didn't know how to fly in the first place."}
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
		if plr.Character:FindFirstChild("fly") then
			plr.Character.fly:Destroy()
		else end
	end
	if done[1] >= 5 then
		return {true,"Took away the ability to fly from "..done[1].." people."}
	else
		return {true, done[2].." has forgotten how to fly."}
	end
end

OnLoad = function(env)
end

return {
	ModuleType = "Command",
	Usage = "<players>", 
	ModName = "unfly",
	Alias = {},
	Level = 3,
	Sandbox = true,
	Libraries = {},
	Dependencies = {}, -- To be used soon.
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
