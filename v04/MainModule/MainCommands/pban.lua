OnFire = function(plr,arg,env) -- When the command is fired, use this function. exec - Player who executed the command, args - Table of arguments. (args[2] = 2nd argument), env - Returns the main environment used.
	local banreason = ""
	if not arg[2] then
		return {false,"You didn't mention anyone to ban."}
	end

	if not arg[3] then
		banreason = env.Settings.DefaultBanReason
	else
		for _,v in pairs(arg) do
			if v ~= arg[1] and v ~= arg[2] then
				banreason = banreason.." "..v
			end
		end
	end

	if arg[2] == "@all" then
		return {false,"Alternatives that include multiple people are disabled for this command."}
	elseif arg[2] == "@others" then
		return {false,"Alternatives that include multiple people are disabled for this command."}
	elseif arg[2] == "@me" then
		return {false,"Y-YOU WANT TO BAN YOURSELF?! ARE YOU OUT OF YOUR MIND?!"}
	elseif string.sub(arg[2],1,1) == "#" then
		for _,v in pairs(env.usersfolder:GetChildren()) do
			local nv = env.splitstring(v.Value," ")
			if nv[1] == arg[2] then
				local p = env.Player(nv[3])
				if p then
					if p.Name ~= plr.Name then
						if env.GetLevel(p) < env.GetLevel(plr) then
							env.Admins.BanLand[#env.Admins.BanLand+1] = {p.UserId,banreason}
							p:Kick(env.Settings.BanMessage.." "..banreason)
							local update = env.SaveAdmins(env.Admins)
							return {true,"Successfully pbanned "..p.Name.." for '"..banreason.."'."}
						else
							return {false,"You can't ban someone who's higher or equal to your level."}
						end
					else
						return {false,"Y-YOU WANT TO BAN YOURSELF?! ARE YOU OUT OF YOUR MIND?!"}
					end
				else
					return {false,"An error has occured. Please try again later."}
				end
			end
		end
		return {false,"Local Player ID not found."}
	else
		local p = env.Player(arg[2])
		if p then
			if p.Name ~= plr.Name then
				if env.GetLevel(p) < env.GetLevel(plr) then
					env.Admins.BanLand[#env.Admins.BanLand+1] = {p.UserId,banreason}
					p:Kick(env.Settings.BanMessage.." "..banreason)
					local update = env.SaveAdmins(env.Admins)
					return {true,"Successfully pbanned "..p.Name.." for '"..banreason.."'."}
				else
					return {false,"You can't ban someone who's higher or equal to your level."}
				end
			else
				return {false,"Y-YOU WANT TO BAN YOURSELF?! ARE YOU OUT OF YOUR MIND?!"}
			end
		else return {false,"Player not found. Also, no alternatives are allowed here."} end
	end
end

OnLoad = function(env) -- When the module is loaded, use this function. Since it's a command, we don't really need it.
end

return {
	ModuleType = "Command",
	Usage = "<player> [reason]", 
	ModName = "pban", -- == module.Prefix..Name
	Alias = {},
	Level = 5,
	Sandbox = false,
	Libraries = {},
	Dependencies = {}, -- To be used soon.
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
