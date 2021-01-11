-- This function is for older modules that were transferred to V.04 lazily. Don't use it.

local mod = {}

mod.ModuleType = "Function"

function mod:Unpack(env)
	function env.Player(Name)
		for i,v in next,game:GetService("Players"):GetPlayers() do
			local s1 = string.lower(v.Name)
			if s1 == string.lower("Server") then
				return env.FakePlayer
			end
			if s1:sub(1, #Name) == string.lower(Name) then
				return v
			end
		end
	end
end

return mod