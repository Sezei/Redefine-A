OnFire = function(exec,args,env) -- When the command is fired, use this function. exec - Player who executed the command, args - Table of arguments. (args[2] = 2nd argument), env - Returns the main environment used.
	if not args[2] then
		return {false,"A variable is required."}
	end
	
	if string.sub(args[2],1,1) == "#" then
		for _,v in pairs(env.usersfolder:GetChildren()) do
			local nv = env.splitstring(v.Value," ")
			if nv[1] == args[2] then
				local p = env.Player(nv[3])
				if p then
					if p.Name ~= exec.Name then
						if env.GetLevel(p) < env.GetLevel(exec) then 
							if env.GetLevel(p) <= 1 then
								return {false,p.Name.." isn't an admin."}
							end
							for k,v in pairs(env.Admins.SuperAdmins) do
								if v == p.UserId then
									env.Admins.SuperAdmins[k] = nil
								end
							end
							for k,v in pairs(env.Admins.Admins) do
								if v == p.UserId then
									env.Admins.Admins[k] = nil
								end
							end
							for k,v in pairs(env.Admins.Moderators) do
								if v == p.UserId then
									env.Admins.Moderators[k] = nil
								end
							end
							return {true,p.Name.." has been unadmined."}
						elseif env.GetLevel(p) == 5 and env.GetLevel(exec) == 5 then
							return {false,"Your linux terminal has crashed while attempting to remove sudo access from "..p.Name}
						else
							return {false,"You can't unadmin someone higher or equal to your level."}
						end
					else
						return {false,"Nice try... Not."}
					end
				else
					return {false,"An error has occured. Please try again later."}
				end
			end
		end
		return {false,"Local Player ID not found."}
	else
		local p = env.Player(args[2])
		if p then
			if p.Name ~= exec.Name then
				if env.GetLevel(p) < env.GetLevel(exec) then 
					if env.GetLevel(p) <= 1 then
						return {false,p.Name.." isn't an admin."}
					end
					for k,v in pairs(env.Admins.SuperAdmins) do
						if v == p.UserId then
							env.Admins.SuperAdmins[k] = nil
						end
					end
					for k,v in pairs(env.Admins.Admins) do
						if v == p.UserId then
							env.Admins.Admins[k] = nil
						end
					end
					for k,v in pairs(env.Admins.Moderators) do
						if v == p.UserId then
							env.Admins.Moderators[k] = nil
						end
					end
					return {true,p.Name.." has been unadmined."}
				else
					return {false,"You can't unadmin someone higher or equal to your level."}
				end
			else
				return {false,"..... Welp, you tried."}
			end
		else 
			if args[2] == "me" then
				return {false,"Alternatives are disabled for this command."}
			elseif args[2] == "others" then
				return {false,"Alternatives are disabled for this command."}
			elseif args[2] == "all" then
				return {false,"Alternatives are disabled for this command."}
			else
				return {false,"Player was not found."} 
			end
		end
	end
end

OnLoad = function(env) -- When the module is loaded, use this function. Since it's a command, we don't really need it.
end

return {
	ModuleType = "Command",
	Usage = "<player>", 
	ModName = "unadmin", -- == module.Prefix..Name
	Alias = {},
	Level = 4,
	Sandbox = false,
	Libraries = {},
	Dependencies = {},
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
