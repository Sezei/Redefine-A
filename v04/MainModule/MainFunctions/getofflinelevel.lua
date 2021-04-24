local mod = {}

mod.ModuleType = "Function"

function mod:Unpack(env)
	function env.GetOfflineLevel(userid)
		if env.Admins == nil or not env.Admins then env.Admins = env.Admins end
		local group = env.Settings.GroupAdmin
		if game.CreatorType == Enum.CreatorType.User then
			if userid == game.CreatorId then
				return 5
			end
		elseif game.CreatorType == Enum.CreatorType.Group then
			local group = game:GetService("GroupService"):GetGroupInfoAsync(game.CreatorId)
			if userid == group.Owner.Id then
				return 5
			end
		end
		for _,b in pairs(env.Admins.RootAdmins) do
			if userid == b then
				return 5
			end
		end
		for _,b in pairs(env.Admins.SuperAdmins) do
			if userid == b then
				return 4
			end
		end
		for _,b in pairs(env.Admins.Admins) do
			if userid == b then
				return 3
			end
		end
		for _,b in pairs(env.Admins.Moderators) do
			if userid == b then
				return 2
			end
		end
		for _,b in pairs(env.Admins.VIP) do
			if userid == b then
				return 1
			end
		end
		for _,b in pairs(env.Admins.Bans) do -- People with admin disabled.
			if userid == b then
				return -1
			end
		end
		for _,b in pairs(env.Admins.BanLand) do
			if userid == b[1] then
				return -99
			end
		end		
		return 0
	end
end

return mod