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
					if p.UserId == exec.UserId then
						return {false,"Did you really just try to remove temporary roles from yourself?"}
					end
					if env.GetLevel(p) < env.GetLevel(exec) and not env.isOwner(exec) then 
						return {false,"You cannot remove temporary roles from someone higher than you in rank."}
					end
					local id = p.UserId
					local found = false
					if env.isOwner(exec) then
						if table.find(env.templevels.root,id) then
							table.remove(env.templevels.root,table.find(env.templevels.root,id))
							found = true
						end
					end
					if env.GetLevel(exec) >= 5 then
						if table.find(env.templevels.super,id) then
							table.remove(env.templevels.super,table.find(env.templevels.super,id))
							found = true
						end
					end
					if env.GetLevel(exec) >= 4 then
						if table.find(env.templevels.admin,id) then
							table.remove(env.templevels.admin,table.find(env.templevels.admin,id))
							found = true
						end
					end
					if env.GetLevel(exec) >= 3 then
						if table.find(env.templevels.mod,id) then
							table.remove(env.templevels.mod,table.find(env.templevels.mod,id))
							found = true
						end
					end
					if env.GetLevel(exec) >= 2 then
						if table.find(env.templevels.vip,id) then
							table.remove(env.templevels.vip,table.find(env.templevels.vip,id))
							found = true
						end
					end
					if found then
						return {true,"Removed temporary roles from "..p.Name.."."}
					else
						return {false,p.Name.." does not have temporary roles."}
					end
				else
					return {false,"An unknown error has occured. Please try again later."}
				end
			end
		end
		return {false,"Local Player ID not found."}
	else
		local p = env.Player(args[2])
		if p then
			if p.Name ~= exec.Name then
				if env.GetLevel(p) < env.GetLevel(exec) then 
					local id = p.UserId
					local found = false
					if env.isOwner(exec) then
						if table.find(env.templevels.root,id) then
							table.remove(env.templevels.root,table.find(env.templevels.root,id))
							found = true
						end
					end
					if env.GetLevel(exec) >= 5 then
						if table.find(env.templevels.super,id) then
							table.remove(env.templevels.super,table.find(env.templevels.super,id))
							found = true
						end
					end
					if env.GetLevel(exec) >= 4 then
						if table.find(env.templevels.admin,id) then
							table.remove(env.templevels.admin,table.find(env.templevels.admin,id))
							found = true
						end
					end
					if env.GetLevel(exec) >= 3 then
						if table.find(env.templevels.mod,id) then
							table.remove(env.templevels.mod,table.find(env.templevels.mod,id))
							found = true
						end
					end
					if env.GetLevel(exec) >= 2 then
						if table.find(env.templevels.vip,id) then
							table.remove(env.templevels.vip,table.find(env.templevels.vip,id))
							found = true
						end
					end
					if found then
						return {true,"Removed temporary roles from "..p.Name.."."}
					else
						return {false,p.Name.." does not have temporary roles."}
					end
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
	ModName = "untemp", -- == module.Prefix..Name
	Alias = {"temp0","removetemp"},
	Level = 2,
	Sandbox = false,
	Libraries = {},
	Dependencies = {},
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
