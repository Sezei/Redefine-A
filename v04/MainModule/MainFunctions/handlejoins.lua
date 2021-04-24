local mod = {}

mod.ModuleType = "Function"

function mod:Unpack(env)
	function env:HandleJoin(player)
		local suc, err = pcall(function()
			if not env.usersfolder:FindFirstChild(player.Name) then
				local newinstance = Instance.new("NumberValue",env.notificationsfolder)
				newinstance.Name = player.Name
				Instance.new("Folder",player).Name = "Notifications"
			end

			env.userids = env.userids+1
			local pid = Instance.new("StringValue",env.usersfolder)
			pid.Name = player.Name
			pid.Value = "#"..env.userids.." | "..player.Name.." ("..env.GetLevel(player)..")"
			local newUI = env.UI.MainUI:Clone()
			newUI.Parent = player.PlayerGui
			newUI.Settings.LocalSettings.Disabled = false
			newUI.Settings.Toggler.LocalScript.Disabled = false
			newUI.Main.TextButton.CLIENTHANDLER.Disabled = false
			if env.Settings.HideMain == true then
				local suc,err = pcall(function()env.func:InvokeClient(player,"HideMain")end)
				if not suc then
					env.errorslogged[#env.errorslogged+1] = ("MainFunction HandleJoins: "..player.Name..": An error has occured while being handled. PCall error from Line 23. Full Error: "..err)
					if not env.Settings.SuppressErrors then warn("R:A | "..player.Name..": An error has occured while being handled. Line 23. Full Error:\n"..err) end
				end
			end

			player.Chatted:Connect(function(msg,receiver)
				env.addChatlog(player,msg)
				if receiver then return end
				local succ,cmd = pcall(env.cmds,player,msg)
				if not succ then
					env.errorslogged[#env.errorslogged+1] = ("An error has occured in a command: "..cmd)
					env.Notify(player,"critical","An error has occured: "..cmd)
				end
			end)
			local isBan = 0; -- 0 until got level.
			local succ,err = pcall(function() isBan = env.GetLevel(player) end)
			if not succ then
				env.errorslogged[#env.errorslogged+1] = ("MainFunction HandleJoins: "..player.Name..": Failed to get admin level. PCall error from Line 41. Full Error: "..err)
				if not env.Settings.SuppressErrors then warn("R:A | "..player.Name..": Failed to get admin level. Line 50. Full Error:\n"..err) end
			end
			
			if env.mutes[player.UserId] then
				if env.mutes[player.UserId] == true then
					local suc,err = pcall(function()
						local ans = env.Notify(player,"Mute") -- should return true. if no response, then count as an error.
						if not ans then
							env.errorslogged[#env.errorslogged+1] = ("MainFunction HandleJoins: "..player.Name..": Failed to apply mute. PCall error from Line 50. The error is unknown.")
							if not env.Settings.SuppressErrors then warn("R:A | "..player.Name..": Failed to apply mute. Line 50. The error is unknown.") end
						end
					end)
					if not suc then
						env.errorslogged[#env.errorslogged+1] = ("MainFunction HandleJoins: "..player.Name..": Failed to apply mute. PCall error from Line 50. Full Error: "..err)
						if not env.Settings.SuppressErrors then warn("R:A | "..player.Name..": Failed to apply mute. Line 50. Full Error:\n"..err) end
					end
				end
			end
			
			for _,v in pairs(env.serverbans) do
				if v[1] == player.UserId then
					local reason
					if v[2] then
						reason = v[2]
					else
						reason = env.Settings.DefaultBanReason
					end
					player:Kick(env.Settings.BanMessage.." "..reason)
				end
			end
			if isBan == -99 then
				for _,v in pairs(env.Admins.BanLand) do
					if v[1] == player.UserId then
						if v[2] then
							reason = v[2]
						else
							reason = env.Settings.DefaultBanReason
						end
					end
				end
				player:Kick(env.Settings.BanMessage.." "..reason)
			else
				newUI.Main.AboutFrame.Label.Text = [[This game is powered by the Redefine:A Administration System, created by Studio Engi.

Your administration flag is ]]..isBan..[[.]]
				env.UserAdded:Fire(player)
				if env.pmessage[1] == true then
					env.Notify(player,"pnotification",env.pmessage[2])
				end
				if isBan >= 1 then
					if env.sandboxmode == false then
						if isBan == 1 then
							env.Notify(player,"welcome",env.CurrentLanguage.Welcome.VIP)
						elseif isBan == 2 then
							env.Notify(player,"welcome",env.CurrentLanguage.Welcome.Moderator)
						elseif isBan == 3 then
							env.Notify(player,"welcome",env.CurrentLanguage.Welcome.Admin)
						elseif isBan == 4 then
							env.Notify(player,"welcome",env.CurrentLanguage.Welcome.Super)
						elseif isBan == 5 then
							env.Notify(player,"welcome",env.CurrentLanguage.Welcome.Root)
						end
					elseif env.sandboxmode == true then
						env.Notify(player,"welcome",env.CurrentLanguage.Welcome.Sandbox)
					end
					newUI.Main.additionals.Console_Toggle.LocalScript.Disabled = false
					newUI.CmdBar.Prefix.Value = env.Settings.Prefix
					if env.isOwner(player) then
						newUI.Settings.IsServerAccessible.Value = true
					else
						newUI.Settings.IsServerAccessible.Value = false
					end
				end
				if env.serverlock[1] == true and tonumber(isBan) <= tonumber(env.serverlock[2]) then
					player:Kick("[R:A] "..env.CurrentLanguage.ServerLock.NoJoin)
					for _,v in pairs(game.Players:GetPlayers()) do
						if env.GetLevel(v) >= 2 then
							env.Notify(v,"error",player.Name.." "..env.CurrentLanguage.ServerLock.AdminNotice)
						end
					end
				elseif env.serverlock[1] == true and isBan >= env.serverlock[2] then
					env.Notify(player,"notification",env.CurrentLanguage.ServerLock.AdminJoin)
				end

				if env.serverlock[1] == false or (env.serverlock[1] == true and isBan >= env.serverlock[2]) then
					local friends = {}
					for _,v in pairs(game:GetService("Players"):GetPlayers()) do
						if v:IsFriendsWith(player.UserId) then
							friends[#friends+1] = v.Name
							env.Notify(v,"done","Your friend, "..player.Name..", has joined your server.",10)
						end
					end

					if #friends == 1 or #friends == 2 then -- Had to split this between 3 lines because this is hard to manipulate a string like that ;-;
						local msg = "Your friend"
						if friends[2] then
							msg = msg.."s, "..friends[1].." and "..friends[2].." are online."
						else
							msg = msg..", "..friends[1].." is online."
						end
						env.Notify(player,"done",msg,10)
					elseif #friends >= 3 then
						env.Notify(player,"done","You have "..tostring(#friends).." friends online on this server!",10)
					end
				end

				if isBan == 5 and env.sandboxmode == false then
					--Notify(player,"perror","Warning: Internal builds are extremely unstable and can rip your eyes out of the sockets.")
					if type(env.Settings.UpdateEnabled) == nil then
						return
					end
					if env.Settings.UpdateEnabled == true then
						if env.isHttpEnabled() == true then
							local data = env.HttpService:GetAsync("https://raw.githubusercontent.com/greasemonkey123/Redefine-A/master/LatestVersion.json",true)
							local checkNew = env.HttpService:JSONDecode(data)
							if tonumber(checkNew.BuildId) == env.BuildId then
								if checkNew.GA_Type ~= "none" then
									if env.GetLevel(player) >= tonumber(checkNew.GA_Level) then
										env.Notify(player,checkNew.GA_Type,checkNew.GlobalAnnouncment)
									end
								end
							else
								if tonumber(checkNew.LatestCriticalBuild) > env.Settings.MadeforBuild then
									env.Notify(player,"critical",env.CurrentLanguage.Update.Critical)
								else
									env.Notify(player,checkNew.UpdateType,env.CurrentLanguage.Update.Normal)
								end
							end
						else
							env.Notify(player,"error",env.CurrentLanguage.Update.NoHTTP)
						end
					elseif env.Settings.UpdateEnabled == false then
						if env.isHttpEnabled() == true then
							local data = env.HttpService:GetAsync("https://raw.githubusercontent.com/greasemonkey123/Redefine-A/master/LatestVersion.json",true)
							local checkNew = env.HttpService:JSONDecode(data)
							if tonumber(checkNew.BuildId) == env.BuildId then
								if checkNew.GA_Type ~= "none" then
									if env.GetLevel(player) >= tonumber(checkNew.GA_Level) then
										pcall(function()
											env.Notify(player,checkNew.GA_Type,checkNew.GlobalAnnouncment)
										end)
									end
								end
							elseif tonumber(checkNew.LatestCriticalBuild) > env.Settings.MadeforBuild then
								pcall(function()
									env.Notify(player,"critical",env.CurrentLanguage.Update.Critical)
								end)
							end
						end
					end
				end
			end
			return true
		end)
		
		if not suc then
			env.errorslogged[#env.errorslogged+1] = ("MainFunction HandleJoins: "..player.Name..": "..err)
			if not env.Settings.SuppressErrors then warn("R:A | HandleJoins | "..player.Name..": A critical error has occured while being handled. You can find more details in "..env.Settings.Prefix.."errorlogs.") end
		end
	end
end

return mod