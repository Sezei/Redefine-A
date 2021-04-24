local mod = {}

mod.ModuleType = "Function"

function mod:Unpack(env)
	local method = env.Settings.PreferredMethod
	function env.HandlePlayers(executor, plrs, level, ismessg)
		
		local newplrs = env.splitstring(plrs,",")
		local players = {}
		local ismsg = ismessg or false
		
		if plrs == "" or plrs == " " or plrs == nil then
			players[#players+1] = env.GetPlayer(executor)
			return players
		end
		
		if env.GetLevel(env.GetPlayer(executor)) == 5 then
			level = 0 -- If the executor is Root, then ignore level.
		end

		if level == -1 then
			ismsg = true
			level = 0
		end

		for _,v in pairs(newplrs) do
			if (((string.lower(method) == "sm" or string.lower(method) == "sourcemod") and v == "@me") or ((string.lower(method) == "mc" or string.lower(method) == "minecraft") and (v == "@s" or v == "@p")) or ((string.lower(method) == "s" or string.lower(method) == "simple") and (v == "me"))) then
				players[#players+1] = env.GetPlayer(executor)
			elseif (((string.lower(method) == "sm" or string.lower(method) == "sourcemod") and (v == "@others" or v == "@!me")) or ((string.lower(method) == "mc" or string.lower(method) == "minecraft") and v == "@o") or ((string.lower(method) == "s" or string.lower(method) == "simple") and (v == "others"))) and level < 2 then
				for _,k in pairs(game.Players:GetPlayers()) do
					if k.Name ~= executor then
						if env.GetLevel(env.GetPlayer(executor)) >= env.GetLevel(k) or ismsg then
							players[#players+1] = k	
						end
					end
				end
			elseif (((string.lower(method) == "sm" or string.lower(method) == "sourcemod") and (v == "@all")) or ((string.lower(method) == "mc" or string.lower(method) == "minecraft") and v == "@a") or ((string.lower(method) == "s" or string.lower(method) == "simple") and (v == "all"))) and level < 1 then
				for _,k in pairs(game.Players:GetPlayers()) do
					if env.GetLevel(env.GetPlayer(executor)) >= env.GetLevel(k) or ismsg then
						players[#players+1] = k	
					end
				end
			elseif string.sub(v,1,1) == "#" then
				for _,k in pairs(env.usersfolder:GetChildren()) do
					local nv = env.splitstring(k.Value," ")
					if nv[1] == v then
						local a = env.GetPlayer(nv[3])
						if env.GetLevel(env.GetPlayer(executor)) >= env.GetLevel(a) or ismsg then
							if a then
								players[#players+1] = a
							end
						end
					end
				end
			elseif v == "@@" or v == "@server" or v == "#0" then -- Added with build 2 of Version 4. Untouched as of Build 14/15 because I was too lazy for this part lmao.
				if env.GetLevel(env.GetPlayer(executor)) < 5 then
					return {false,"You cannot target this user. (@server)"}
				end
				players[#players+1] = env.FakePlayer
			elseif (v == "@rastaff" or v == "@r:a" or v == "@redefine:a") and level < 3 then -- Untouched as of Build 14/15.
				if env.GetLevel(env.GetPlayer(executor)) < 3 then
					return {false,"You cannot target this group. (@redefine:a staff)"}
				end
				for _,k in pairs(game.Players:GetPlayers()) do
					if k:GetRankInGroup(3984407) >= 4 then
						players[#players+1] = k	
					end
				end
			elseif (v == "@root" or  ((string.lower(method) == "s" or string.lower(method) == "simple") and (v == "roots"))) and level < 3 then --// New alternatives start
				if env.GetLevel(env.GetPlayer(executor)) ~= 5 then
					return {false,"You cannot target this group. (@root)"}
				end
				for _,k in pairs(game.Players:GetPlayers()) do
					if env.GetLevel(k) == 5 then
						players[#players+1] = k	
					end
				end
			elseif (v == "@super" or  ((string.lower(method) == "s" or string.lower(method) == "simple") and (v == "supers"))) and level < 3 then
				if env.GetLevel(env.GetPlayer(executor)) ~= 5 then
					return {false,"You cannot target this group. (@super)"}
				end
				for _,k in pairs(game.Players:GetPlayers()) do
					if env.GetLevel(k) >= 4 then
						players[#players+1] = k	
					end
				end
			elseif (v == "@admin" or  ((string.lower(method) == "s" or string.lower(method) == "simple") and (v == "administrators"))) and level < 3 then
				if env.GetLevel(env.GetPlayer(executor)) < 4 then
					return {false,"You cannot target this group. (@admin)"}
				end
				for _,k in pairs(game.Players:GetPlayers()) do
					if env.GetLevel(k) >= 3 then
						players[#players+1] = k	
					end
				end
			elseif (v == "@mod" or v == "@admins" or  ((string.lower(method) == "s" or string.lower(method) == "simple") and (v == "mods" or v == "admins"))) and level < 3 then
				if env.GetLevel(env.GetPlayer(executor)) < 3 then
					return {false,"You cannot target this group. (@mod)"}
				end
				for _,k in pairs(game.Players:GetPlayers()) do
					if env.GetLevel(k) >= 2 then
						players[#players+1] = k	
					end
				end
			elseif (v == "@vip" or  ((string.lower(method) == "s" or string.lower(method) == "simple") and (v == "vips"))) and level < 3 then
				if env.GetLevel(env.GetPlayer(executor)) < 2 then
					return {false,"You cannot target this group. (@vip)"}
				end
				for _,k in pairs(game.Players:GetPlayers()) do
					if env.GetLevel(k) >= 1 then
						players[#players+1] = k	
					end
				end
			elseif (v == "@noadmin" or  ((string.lower(method) == "s" or string.lower(method) == "simple") and (v == "nonadmins"))) and level < 3 then
				if env.GetLevel(env.GetPlayer(executor)) < 2 then
					return {false,"You cannot target this group. (@noadmin)"}
				end
				for _,k in pairs(game.Players:GetPlayers()) do
					if env.GetLevel(k) <= 0 then
						players[#players+1] = k	
					end
				end
			elseif v == "@n/a" then -- it's a joke bruh
				return {false,"No."}
			elseif (((string.lower(method) == "sm" or string.lower(method) == "sourcemod") and (v == "@alive" or v == "@!dead")) or ((string.lower(method) == "mc" or string.lower(method) == "minecraft") and v == "@e") or ((string.lower(method) == "s" or string.lower(method) == "simple") and (v == "alive"))) and level < 3 then -- Minecraft handles @e as ALIVE entities in the area. That's why I've chosen to use @e for that.
				for _,k in pairs(game.Players:GetPlayers()) do
					if env.GetLevel(k) <= env.GetLevel(env.GetPlayer(executor)) or ismsg then
						if k.Character.Humanoid then
							if k.Character.Humanoid.Health > 0 then
								players[#players+1] = k
							end	
						end	
					end
				end
			elseif (((string.lower(method) == "sm" or string.lower(method) == "sourcemod") and (v == "@!alive" or v == "@dead")) or ((string.lower(method) == "mc" or string.lower(method) == "minecraft") and v == "@!e") or ((string.lower(method) == "s" or string.lower(method) == "simple") and (v == "dead"))) and level < 3 then
				for _,k in pairs(game.Players:GetPlayers()) do
					if env.GetLevel(k) <= env.GetLevel(env.GetPlayer(executor)) or ismsg then
						if k.Character.Humanoid then
							if k.Character.Humanoid.Health <= 0 then
								players[#players+1] = k
							end	
						end	
					end
				end
			elseif (v == "@non" or  ((string.lower(method) == "s" or string.lower(method) == "simple") and (v == "non"))) and level < 3 then -- Again, administrative.
				for _,k in pairs(game.Players:GetPlayers()) do
					if env.GetLevel(k) <= env.GetLevel(env.GetPlayer(executor)) or ismsg then
						if env.GetLevel(env.GetPlayer(executor)) < 2 then
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
				local k = env.GetPlayer(v)
				if k then
					if env.GetLevel(k) <= env.GetLevel(env.GetPlayer(executor)) or ismsg then
						players[#players+1] = k
					end
				end
			end
		end

		return players
	end
end

return mod