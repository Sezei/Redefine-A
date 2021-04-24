local mod = {}

mod.ModuleType = "Function"

function mod:Unpack(env)
	function env.GetLPID(plr,full)
		for _,k in pairs(env.usersfolder:GetChildren()) do
			if k.Name == plr.Name then
				if full == true then
					return k.Value
				else
					local nv = env.splitstring(k.Value," ")
					return nv[1]
				end
			end
		end
		return "#? | "..plr.Name.."(?)"
	end
end

return mod