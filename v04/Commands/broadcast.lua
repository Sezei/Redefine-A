OnFire = function(plr,arg,env)
	local buildreason = "{ Message was not included }"
	
	if arg[2] then
		buildreason = ""
		for _,v in pairs(arg) do
			if v ~= arg[1] then
				buildreason = buildreason.." "..v
			end
		end
	end

	for _,v in pairs(game.Players:GetPlayers()) do
		if env.Settings.FilterText == true then
			local buildreason = env.TextService:FilterStringAsync(buildreason or "?",v.UserId)
		end
		env.Notify(v,"newmsg",{"Message by "..plr.Name,buildreason or "?"})
	end

	return{true,"Broadcast successful"}
end

OnLoad = function(env)
end

return {
	ModuleType = "Command",
	Usage = "<players> [message]", 
	ModName = "broadcast",
	Alias = {"b"},
	Level = 2,
	Sandbox = true,
	Libraries = {},
	Dependencies = {}, -- To be used soon.
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
