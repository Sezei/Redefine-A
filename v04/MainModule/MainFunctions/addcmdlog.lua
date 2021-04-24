local mod = {}

mod.ModuleType = "Function"

function mod:Unpack(env)
	function env.addCmdlog(plr,chat)
		env.cmdlogs[#env.cmdlogs+1] = "["..plr.Name.."]: "..chat
	end
end

return mod