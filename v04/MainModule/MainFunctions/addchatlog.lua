local mod = {}

mod.ModuleType = "Function"

function mod:Unpack(env)
	function env.addChatlog(plr,chat)
		env.chatlogs[#env.chatlogs+1] = "["..plr.Name.."]: "..chat
	end
end

return mod