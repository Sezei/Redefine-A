OnFire = function(plr,arg,env)
	if not arg[2] then
		return {false,"You must provide atleast 1 target."}
	end

	local buildreason = ""
	if arg[3] then
		for _,v in pairs(arg) do
			if v ~= arg[1] and v ~= arg[2] then
				buildreason = buildreason.." "..v
			end
		end
	else
		buildreason = "No reason stated."
	end
	
	local targets = env.HandlePlayers(plr.Name,arg[2],2,false)
	if targets[1] == nil then
		return {false, env.CurrentLanguage.CommandExec.NoFound}
	elseif targets[1] == false then
		return {false, targets[2]}
	end
	local done = {0,""}
	for _,v in pairs(targets) do
		warns[#warns+1] = {
			["ID"] = #warns+1,
			["Target"] = v.Name,
			["Moderator"] = plr.Name,
			["Reason"] = buildreason,
			["Time"] = os.date("%c",os.time()),
		}
		env.Notify(v,"perror","You have been warned! (Warn ID "..(#warns)..")")
		if done[2] ~= "" then
			done[2] = done[2]..", "..v.Name
			done[1] = done[1]+1
		else
			done[2] = v.Name
			done[1] = 1
		end
	end
	if done[1] >= 5 then
		return {true,"Successfully warned "..done[1].." people."}
	else
		return {true,"Successfully warned "..done[2].."."}
	end
end

function OnLoad(env)
	warns = env.cmdstorage.warns;
end

return {
	ModuleType = "Command",
	Usage = "<player> [reason]", 
	ModName = "warn",
	Alias = {},
	Level = 2,
	Sandbox = true,
	Libraries = {},
	Dependencies = {}, -- To be used soon.
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
