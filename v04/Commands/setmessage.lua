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
		local new = script.FullScreenNotification:Clone()
		if env.Settings.FilterText == true then
			local buildreason = env.TextService:FilterStringAsync(buildreason or "?",v.UserId)
		end
		env.Notify(v,"pnotification",buildreason or "?")
	end
	
	env.pmessage = {true,buildreason}
	
	return{true,"The message was set."}
end

OnLoad = function(env)
end

return {
	ModuleType = "Command",
	Usage = "<players> [message]", 
	ModName = "setmessage",
	Alias = {"pmessage"},
	Level = 3,
	Sandbox = true,
	Libraries = {},
	Dependencies = {}, -- To be used soon.
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
