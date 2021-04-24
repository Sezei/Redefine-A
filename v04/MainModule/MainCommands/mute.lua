OnFire = function(plr,arg,env) -- When the command is fired, use this function. exec - Player who executed the command, args - Table of arguments. (args[2] = 2nd argument), env - Returns the main environment used.
	if not arg[2] then
		return {false,"You didn't include anyone to mute."}
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
		return {false, "Failed to find anyone of the mentioned players."}
	elseif targets[1] == false then
		return {false, targets[2]}
	end
	local done = {0,""}
	for _,v in pairs(targets) do
		env.Notify(v,"Mute")
		env.mutes[v.UserId] = true
		if done[2] ~= "" then
			done[2] = done[2]..", "..v.Name
			done[1] = done[1]+1
		else
			done[2] = v.Name
			done[1] = 1
		end
	end
	if done[1] >= 5 then
		return {true,"Successfully muted "..done[1].." people."}
	else
		return {true,"Successfully muted "..done[2].."."}
	end
end

OnLoad = function(env)
end

return {
	ModuleType = "Command",
	Usage = "<players>", 
	ModName = "mute", -- == module.Prefix..Name
	Alias = {},
	Level = 2,
	Sandbox = false,
	Libraries = {},
	Dependencies = {}, -- To be used soon.
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
