local mod = {}

mod.ModuleType = "Function"

function mod:Unpack(env)
	function env:HandleLeaving(player)
		env.UserRemoved:Fire(player)
		local notif = env.notificationsfolder:FindFirstChild(player.Name)
		if notif then notif:Destroy() end
		local user = env.usersfolder:FindFirstChild(player.Name)
		user.Name = "[Left] "..player.Name
		
		if env.mutes[player.UserId] then
			if env.mutes[player.UserId] == true then
				for _,users in pairs(game:GetService("Players"):GetPlayers()) do
					if env.GetLevel(users) >= 2 then
						env.Notify(users,"notification",player.Name.." has left the game while muted.")
					end
				end
			end
		end
	end
end

return mod