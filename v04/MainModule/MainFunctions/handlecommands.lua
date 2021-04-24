local mod = {}

mod.ModuleType = "Function"

function mod:Unpack(env)
	function env.cmds(plr,msg)
		local cmdex = env.splitstring(msg,env.Settings.Separator)
		local responses = {}
		for _,c in pairs(cmdex) do
			local arg = env.splitstring(c," ")		
			if arg[1] == "/e" and env.Settings.SilentEnabled == true then
				for k,v in pairs(arg) do
					arg[k-1] = v
					arg[k] = nil
				end
			end
			
			for _,v in pairs(env.Commands) do
				local alias = false
				for _,a in pairs(v.Alias) do
					if arg[1] == env.Settings.Prefix .. a then
						alias = true
						break
					end
				end
					
				if string.lower(arg[1]) == env.Settings.Prefix .. string.lower(v.ModName) or alias == true then
					if ((string.lower(arg[1]) == env.Settings.Prefix .. "announce") and (plr.Name == "Server")) then -- Avoid an infinite loop.
						return
					end
					if (env.sandboxmode == true and v.Sandbox == true) or env.sandboxmode == false then
						if (env.GetLevel(plr) < v.Level) and not (v.Level == 6 and env.isOwner(plr)) then
							responses[#responses+1] = {false,env.CurrentLanguage.CommandExec.NoPerm}
						else
							if not v._debug then -- Debug commands are not supposed to return anything to the players around them, which is why they are suppressed.
								env.CommandFired:Fire(plr,msg) -- For webhook stuff idk
								env.addCmdlog(plr,msg)
							end
							responses[#responses+1] = v.ModFunction(plr,arg,env)
						end
					end
					break -- I mean, the name / alias was found. We no longer need to search anymore. Why waste resources on searching something that was found?
				end
			end
			
			responses[#responses+1] = "none"
		end
		for _,cmd in pairs(responses) do
			if tostring(cmd) == "none" then 
			elseif cmd[1] == false then
				env.Notify(plr,"error",cmd[2])
			elseif cmd[1] == true then
				env.Notify(plr,"done",cmd[2])
			end
		end
		return true
	end
end

return mod