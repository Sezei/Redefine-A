OnFire = function(plr,arg,env)
	local targets = env.HandlePlayers(plr.Name,arg[2],0,false)
	if targets[1] == nil then
		return {false, env.CurrentLanguage.CommandExec.NoFound}
	elseif targets[1] == false then
		return {false, targets[2]}
	end
	local done = {0,""}
	for _,v in pairs(targets) do
		local JoinDate = os.date("*t",(os.time()-((v.AccountAge)*24*60*60)))
		local isprem = false
		if v.MembershipType == Enum.MembershipType.Premium then
			isprem = true
		end
		local safechat = true -- True until proven false.
		local scres = env.TextService:FilterStringAsync("C7RN", v.UserId)
		if scres == "####" then
			safechat = true
		elseif scres == "C7RN" then
			safechat = false
		else
			safechat = false
		end
		local info = {
			["UserId"] = tostring(v.UserId),
			["Account Age"] = tostring(v.AccountAge),
			["Creation Date"] = tostring(JoinDate.day).."/"..tostring(JoinDate.month).."/"..tostring(JoinDate.year),
			["Is Premium"] = tostring(isprem),
			["Level"] = tostring(env.GetLevel(v)),
			["SafeChat"] = tostring(safechat),
		}
		if env.warns then -- This is a great example of commands extending each other. Warns -> Info
			local warns = 0
			for k,v in pairs(env.warns) do
				if v["Target"] == v.Name then
					warns = warns+1
				end
			end
			info["Amount of Warnings"] = warns
		end
		env.Notify(plr,"customlist",{v.Name,info})
		if done[2] ~= "" then
			done[2] = done[2]..", "..v.Name
			done[1] = done[1]+1
		else
			done[2] = v.Name
			done[1] = 1
		end
	end
	if done[1] >= 5 then
		return {true,"Successfully got info about "..done[1].." people."}
	else
		return {true,"Successfully got info about "..done[2].."."}
	end
end

OnLoad = function(env)
end

return {
	ModuleType = "Command",
	Usage = "<players>", 
	ModName = "info",
	Alias = {},
	Level = 2,
	Sandbox = true,
	Libraries = {},
	Dependencies = {}, -- To be used soon.
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
