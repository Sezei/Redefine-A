local mod = {}

mod.ModuleType = "Function"

function mod:Unpack(env)
	function env.GetPlayer(Name)
		for i,v in next,game:GetService("Players"):GetPlayers() do
			local s1 = string.lower(v.Name)
			if s1:sub(1, #Name) == string.lower(Name) then
				return v
			end
		end
	end
end

return mod