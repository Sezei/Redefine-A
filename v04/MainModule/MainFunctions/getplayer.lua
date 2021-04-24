local mod = {}

mod.ModuleType = "Function"

function mod:Unpack(env)
	function env.GetPlayer(Name)
		for i,v in next,game:GetService("Players"):GetPlayers() do
			if env.Settings.AllowDisplayNames == true then
				local s1 = string.lower(v.DisplayName)
				if s1:sub(1, #Name) == string.lower(Name) then
					return v
				end
			end
			-- Secondary Check: It probably was a username, not a displayname.
			if string.lower(Name) == string.lower("Server") then -- This already doesn't allow *displayNames* of 'Server'.
				return env.FakePlayer
			end
			local s1 = string.lower(v.Name)
			if s1:sub(1, #Name) == string.lower(Name) then
				return v
			end
		end
	end
end

return mod