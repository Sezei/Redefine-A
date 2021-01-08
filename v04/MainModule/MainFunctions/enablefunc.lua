local mod = {}

mod.ModuleType = "Function"

function mod:Unpack(env)
	function env.enableFunc()
		env.func.OnServerInvoke = (function(plr,invoketype)
			if type(invoketype) == "string" then
				if invoketype == "IsOwner" then
					if game.CreatorType == Enum.CreatorType.User then
						if plr.UserId == game.CreatorId then
							return true
						else
							return false
						end
					elseif game.CreatorType == Enum.CreatorType.Group then
						local group = game:GetService("GroupService"):GetGroupInfoAsync(game.CreatorId)
						if plr.UserId == group.Owner.Id then
							return true
						else
							return false
						end
					end
				elseif invoketype == "GetLevel" then
					return env.GetLevel(plr)
				elseif invoketype == "AdminsGet" then
					env.func:InvokeClient(plr,{"AdminsList",env.Admins})
					return true
				end
			elseif type(invoketype) == "table" then
				if invoketype[1] == "ClientPing" then
					local stc = invoketype[2]
					local cts = tick() - invoketype[3]
					local diff = invoketype[4]
					stc = math.abs( stc - (3600*diff) )
					cts = math.abs( cts + (3600*diff) )
					env.Notify(plr,"notification","Server to Client: "..tostring(math.ceil(stc*1000)).."ms | Client to Server: "..tostring(math.ceil(cts*1000)).."ms")
				elseif invoketype[1] == "AdminAdd" then
					if env.GetLevel(plr) == 5 then
						if invoketype[2] == 5 then
							if game.CreatorType == Enum.CreatorType.User then
								if plr.UserId == game.CreatorId then
									env.Admins.RootAdmins[#env.Admins.RootAdmins+1] = invoketype[3]
									local await = env.SaveAdmins(env.Admins)
									if await then print("Saved.") end
									return true
								else
									return false
								end
							elseif game.CreatorType == Enum.CreatorType.Group then
								local group = game:GetService("GroupService"):GetGroupInfoAsync(game.CreatorId)
								if plr.UserId == group.Owner.Id then
									env.Admins.RootAdmins[#env.Admins.RootAdmins+1] = invoketype[3]
									local await = env.SaveAdmins(env.Admins)
									if await then print("Saved.") end
									return true
								else
									return false
								end
							end
						elseif invoketype[2] == 4 then
							env.Admins.SuperAdmins[#env.Admins.SuperAdmins+1] = invoketype[3]
							local await = env.SaveAdmins(env.Admins)
							if await then print("Saved.") end
							return true
						elseif invoketype[2] == 3 then
							env.Admins.Admins[#env.Admins.Admins+1] = invoketype[3]
							local await = env.SaveAdmins(env.Admins)
							if await then print("Saved.") end
							return true
						elseif invoketype[2] == 2 then
							env.Admins.Moderators[#env.Admins.Moderators+1] = invoketype[3]
							local await = env.SaveAdmins(env.Admins)
							if await then print("Saved.") end
							return true
						end
					else
						plr:Kick("An internal server error has occured while attempting to add "..plr.Name.." to the Admins list.")
						for _,v in pairs(game:GetService("Players"):GetPlayers()) do
							if env.GetLevel(v) >= 2 then
								env.Notify(v,"critical",plr.Name.." has been kicked for triggering a remote trap.")
								env.exploitlogs[#env.exploitlogs+1] = (plr.Name.." | Info: Triggered remote trap | Action: Automatic Kick")
							end
						end
					end
				elseif invoketype[1] == "AdminDel" then
					if env.GetLevel(plr) == 5 then
						if invoketype[2] == 5 then
							if game.CreatorType == Enum.CreatorType.User then
								if plr.UserId == game.CreatorId then
									for k,v in pairs(env.Admins.RootAdmins) do
										if v == tonumber(invoketype[3]) then
											env.Admins.RootAdmins[k] = nil
											local await =env. SaveAdmins(env.Admins)
											if await then print("Saved.") end
											return true
										end
									end
								else
									return false
								end
							elseif game.CreatorType == Enum.CreatorType.Group then
								local group = game:GetService("GroupService"):GetGroupInfoAsync(game.CreatorId)
								if plr.UserId == group.Owner.Id then
									for k,v in pairs(env.Admins.RootAdmins) do
										if v == tonumber(invoketype[3]) then
											env.Admins.RootAdmins[k] = nil
											local await = env.SaveAdmins(env.Admins)
											if await then print("Saved.") end
											return true
										end
									end
								else
									return false
								end
							end
						elseif invoketype[2] == 4 then
							for k,v in pairs(env.Admins.SuperAdmins) do
								if v == tonumber(invoketype[3]) then
									env.Admins.SuperAdmins[k] = nil
									local await = env.SaveAdmins(env.Admins)
									if await then print("Saved.") end
									return true
								end
							end
						elseif invoketype[2] == 3 then
							for k,v in pairs(env.Admins.Admins) do
								if v == tonumber(invoketype[3]) then
									env.Admins.Admins[k] = nil
									local await = env.SaveAdmins(env.Admins)
									if await then print("Saved.") end
									return true
								end
							end
						elseif invoketype[2] == 2 then
							for k,v in pairs(env.Admins.Moderators) do
								if v == tonumber(invoketype[3]) then
									env.Admins.Moderators[k] = nil
									local await = env.SaveAdmins(env.Admins)
									if await then print("Saved.") end
									return true
								end
							end
						end
					else
						plr:Kick("An internal server error has occured while attempting to remove "..invoketype[3].." from the Admins list.")
						for _,v in pairs(game:GetService("Players"):GetPlayers()) do
							if env.GetLevel(v) >= 2 then
								env.Notify(v,"critical",plr.Name.." has been kicked for triggering a remote trap.")
								env.exploitlogs[#env.exploitlogs+1] = (plr.Name.." | Info: Triggered remote trap | Action: Automatic Kick")
							end
						end
					end
				end
			end
		end)
	end
end

return mod