OnFire = function(plr,arg,env)
	local freason = {}
	local reason = "Please rejoin afterwards"

	if arg[2] then
		reason = ""
		for k,v in pairs(arg) do
			if k ~= 1 then
				freason[k-1] = v
			end
		end

		local nr = table.concat(freason, " ")
		reason = nr
	end

	for _,v in pairs(game.Players:GetPlayers()) do
		v:Kick("[R:A] The server is shutting down: "..reason)
	end
end

OnLoad = function(env)
end

return {
	ModuleType = "Command",
	Usage = "[reason]", 
	ModName = "shutdown",
	Alias = {},
	Level = 4,
	Sandbox = true,
	Libraries = {},
	Dependencies = {}, -- To be used soon.
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
