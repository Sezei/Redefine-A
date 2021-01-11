local mod = {}

mod.ModuleType = "Function"

function mod:Unpack(env)
	function env.HandlePlayers(p, plrs, level, ismessg)
		if plrs == "" or plrs == " " or plrs == nil then
			return env.Player(p)
		end

		local newplrs = env.splitstring(plrs,",")
		local players = {}
		local executor = p
		local ismsg = ismessg or false

		if env.GetLevel(env.Player(executor)) == 5 then
			level = 0 -- If the executor is Root, then ignore level.
		end

		if level == -1 then
			ismsg = true
			level = 0
		end

		for _,v in pairs(newplrs) do
			if v == "@me" then
				players[#players+1] = env.Player(executor)
		--[[elseif v == "@server" or v=="@@" or v=="#0" then
			if GetLevel(executor) ~= 5 then
				return {false,"You cannot target the server. ("..v..")"}
			end
			if not ismsg then
				return {false,"You cannot target the server for non-sudo purposes. ("..v..")"}
			elseif ismsg == true then
				
			end]]
			elseif v == "@others" and level < 2 then
				for _,k in pairs(game.Players:GetPlayers()) do
					if k.Name ~= executor then
						if env.GetLevel(env.Player(executor)) >= env.GetLevel(k) or ismsg then
							players[#players+1] = k	
						end
					end
				end
			elseif v == "@all" and level < 1 then
				for _,k in pairs(game.Players:GetPlayers()) do
					if env.GetLevel(env.Player(executor)) >= env.GetLevel(k) or ismsg then
						players[#players+1] = k	
					end
				end
			elseif string.sub(v,1,1) == "#" then
				for _,k in pairs(env.usersfolder:GetChildren()) do
					local nv = env.splitstring(k.Value," ")
					if nv[1] == v then
						local a = env.Player(nv[3])
						if env.GetLevel(env.Player(executor)) >= env.GetLevel(a) or ismsg then
							if a then
								players[#players+1] = a
							end
						end
					end
				end
			elseif v == "@@" or v == "@server" or v == "#0" then -- Added with build 2 of Version 4.
				if env.GetLevel(env.Player(executor)) < 5 then
					return {false,"You cannot target this user. (@server)"}
				end
				players[#players+1] = env.FakePlayer
			elseif v == "@root" and level < 3 then --// New alternatives start
				if env.GetLevel(env.Player(executor)) ~= 5 then
					return {false,"You cannot target this group. (@root)"}
				end
				for _,k in pairs(game.Players:GetPlayers()) do
					if env.GetLevel(k) == 5 then
						players[#players+1] = k	
					end
				end
			elseif v == "@super" and level < 3 then
				if env.GetLevel(env.Player(executor)) ~= 5 then
					return {false,"You cannot target this group. (@super)"}
				end
				for _,k in pairs(game.Players:GetPlayers()) do
					if env.GetLevel(k) >= 4 then
						players[#players+1] = k	
					end
				end
			elseif v == "@admin" and level < 3 then
				if env.GetLevel(env.Player(executor)) < 4 then
					return {false,"You cannot target this group. (@admin)"}
				end
				for _,k in pairs(game.Players:GetPlayers()) do
					if env.GetLevel(k) >= 3 then
						players[#players+1] = k	
					end
				end
			elseif v == "@mod" or v == "@admins" and level < 3 then
				if env.GetLevel(env.Player(executor)) < 3 then
					return {false,"You cannot target this group. (@mod)"}
				end
				for _,k in pairs(game.Players:GetPlayers()) do
					if env.GetLevel(k) >= 2 then
						players[#players+1] = k	
					end
				end
			elseif v == "@vip" and level < 3 then
				if env.GetLevel(env.Player(executor)) < 2 then
					return {false,"You cannot target this group. (@vip)"}
				end
				for _,k in pairs(game.Players:GetPlayers()) do
					if env.GetLevel(k) >= 1 then
						players[#players+1] = k	
					end
				end
			elseif v == "@noadmin" and level < 3 then
				if env.GetLevel(env.Player(executor)) < 2 then
					return {false,"You cannot target this group. (@noadmin)"}
				end
				for _,k in pairs(game.Players:GetPlayers()) do
					if env.GetLevel(k) <= 0 then
						players[#players+1] = k	
					end
				end
			elseif v == "@n/a" then
				return {false,"No."}
			elseif v == "@alive" and level < 3 then
				for _,k in pairs(game.Players:GetPlayers()) do
					if env.GetLevel(k) <= env.GetLevel(env.Player(executor)) or ismsg then
						if k.Character.Humanoid then
							if k.Character.Humanoid.Health > 0 then
								players[#players+1] = k
							end	
						end	
					end
				end
			elseif v == "@dead" and level < 3 then
				for _,k in pairs(game.Players:GetPlayers()) do
					if env.GetLevel(k) <= env.GetLevel(env.Player(executor)) or ismsg then
						if k.Character.Humanoid then
							if k.Character.Humanoid.Health <= 0 then
								players[#players+1] = k
							end	
						end	
					end
				end
			elseif v == "@non" and level < 3 then
				for _,k in pairs(game.Players:GetPlayers()) do
					if env.GetLevel(k) <= env.GetLevel(env.Player(executor)) or ismsg then
						if env.GetLevel(env.Player(executor)) < 2 then
							return {false,"You cannot target this group. (@non)"}
						end
						for _,k in pairs(game.Players:GetPlayers()) do
							if env.GetLevel(k) <= 1 then
								players[#players+1] = k	
							end
						end
					end
				end
			else
				local k = env.Player(v)
				if k then
					if env.GetLevel(k) <= env.GetLevel(env.Player(executor)) or ismsg then
						players[#players+1] = k
					end
				end
			end
		end

		return players
	end
end

return mod