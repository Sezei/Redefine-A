local mod = {}

mod.ModuleType = "Function"

function mod:Unpack(env)
	function env:HandleJoin(player)
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
		if env.Settings.HideMain == true then
			env.func:InvokeClient(player,"HideMain")
		end
		player.Chatted:Connect(function(msg,receiver)
			env.addChatlog(player,msg)
			if receiver then return end
			local succ,cmd = pcall(env.cmds,player,msg)
			if not succ then
				env.Notify(player,"critical","An error has occured: "..cmd)
			end
		end)
		local isBan = env.GetLevel(player)
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
				newUI.Main.CmdBar.ImageButton.LocalScript.Disabled = false
				newUI.Main.CmdBar.Prefix.Value = env.Settings.Prefix
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
			if isBan == 5 and env.sandboxmode == false then
				--Notify(player,"perror","Warning: Internal builds are extremely unstable and can rip your eyes out of the sockets.")
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
									env.Notify(player,checkNew.GA_Type,checkNew.GlobalAnnouncment)
								end
							end
						elseif tonumber(checkNew.LatestCriticalBuild) > env.Settings.MadeforBuild then
							env.Notify(player,"critical",env.CurrentLanguage.Update.Critical)
						end
					end
				end
			end
		end
		if env.Settings.HideMain == true then -- that's really all it does i swear. it also patches some weird bug where it would never ask the function to invoke the client "hidemain".
			player.PlayerGui.MainUI.Main.Visible = false
		else
			player.PlayerGui.MainUI.Main.Visible = true
		end
	end
end

return mod