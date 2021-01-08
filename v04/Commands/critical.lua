OnFire = function(plr,arg,env)
	local buildreason = "{ Message was not included }"

	if not arg[2] then
		return {false,"You didn't include anyone to notify"}
	end

	if arg[3] then
		buildreason = ""
		for _,v in pairs(arg) do
			if v ~= arg[1] and v ~= arg[2] then
				buildreason = buildreason.." "..v
			end
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
		if env.Settings.FilterText == true then
			local buildreason = env.TextService:FilterStringAsync(buildreason or "?",v.UserId)
		end
		env.Notify(v,"critical",buildreason or "?")
		if done[2] ~= "" then
			done[2] = done[2]..", "..v.Name
			done[1] = done[1]+1
		else
			done[2] = v.Name
			done[1] = 1
		end
	end
	if done[1] >= 5 then
		return {true,"Successfully notified "..done[1].." people."}
	else
		return {true,"Successfully notified "..done[2].."."}
	end
end

OnLoad = function(env)
end

return {
	ModuleType = "Command",
	Usage = "<players> [message]", 
	ModName = "critical",
	Alias = {},
	Level = 2,
	Sandbox = true,
	Libraries = {},
	Dependencies = {}, -- To be used soon.
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
