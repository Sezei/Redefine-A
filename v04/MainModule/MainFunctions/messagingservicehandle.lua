local mod = {}

mod.ModuleType = "Function"

function mod:Unpack(env)
	if env.Settings.DisableMsgService then
		return
	end
	local success,err = pcall(function()
		return env.MsgService:SubscribeAsync("RedefineA", function(message)
			if type(message.Data) == "table" then
				if message.Data[1] == "Announce" then
					for _,v in pairs(game:GetService("Players"):GetPlayers()) do
						env.Notify(v,"newmsg",{"Announcement by Server",message.Data[2]})
					end
				elseif message.Data[1] == "Remote" then
					env.cmds(env.FakePlayer,message.Data[2])
				end
			else
				warn("R:A | A MessageService event has been received but it was invalid.")
			end
		end)
	end)
end

return mod