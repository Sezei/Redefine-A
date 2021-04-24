local mod = {}

mod.ModuleType = "Function"

function mod:Unpack(env)
	function env.GetLevel(player)
		if env.Admins == nil or not env.Admins then env.Admins = env.Admins end
		local group = env.Settings.GroupAdmin
		if player.Name == "Server" then
			return 5 -- The player is sudoing, so we need to give 'LIFTED PERMISSIONS'.
		end
		if game.CreatorType == Enum.CreatorType.User then
			if player.UserId == game.CreatorId then
				return 5
			end
		elseif game.CreatorType == Enum.CreatorType.Group then
			local group = game:GetService("GroupService"):GetGroupInfoAsync(game.CreatorId)
			if player.UserId == group.Owner.Id then
				return 5
			end
		end
		for _,b in pairs(env.Admins.RootAdmins) do
			if player.UserId == b then
				return 5
			end
		end
		for _,b in pairs(env.templevels.root) do
			if player.UserId == b then
				return 5
			end
		end
		for _,b in pairs(env.Admins.SuperAdmins) do
			if player.UserId == b then
				return 4
			end
		end
		for _,b in pairs(env.templevels.super) do
			if player.UserId == b then
				return 4
			end
		end
		for _,b in pairs(env.Admins.Admins) do
			if player.UserId == b then
				return 3
			end
		end
		for _,b in pairs(env.templevels.admin) do
			if player.UserId == b then
				return 3
			end
		end
		for _,b in pairs(env.Admins.Moderators) do
			if player.UserId == b then
				return 2
			end
		end
		for _,b in pairs(env.templevels.mod) do
			if player.UserId == b then
				return 2
			end
		end
		for _,b in pairs(env.Admins.VIP) do
			if player.UserId == b then
				return 1
			end
		end
		for _,b in pairs(env.templevels.vip) do
			if player.UserId == b then
				return 1
			end
		end
		for _,b in pairs(env.Admins.Bans) do -- People with admin disabled. Avoids the bans unless server banned (using !ban).
			if player.UserId == b then
				return -1
			end
		end
		for _,b in pairs(env.Admins.BanLand) do
			if player.UserId == b[1] then
				return -99
			end
		end
		if env.Settings.VIPAdmin.Enabled == true then
			if game:GetService("MarketplaceService"):UserOwnsGamePassAsync(player.UserId,env.Settings.VIPAdmin.GamepassId) == true then
				return env.Settings.VIPAdmin.GiveLevel
			end
		end
		
		if group.Enabled == true then -- Hopefully fixed the group admin thing.
			if player:GetRankInGroup(group.GroupId) >= group.SuperAdminRank then
				return 4
			end

			if player:GetRankInGroup(group.GroupId) >= group.AdminRank then
				return 3
			end

			if player:GetRankInGroup(group.GroupId) >= group.ModeratorRank then
				return 2
			end

			if player:GetRankInGroup(group.GroupId) >= group.VIPRank then
				return 1
			end

			if player:GetRankInGroup(group.GroupId) == group.BanLandRank then
				return -99
			end
		end

		if env.Settings.VIPAllowed == true or env.Settings.VIPAdmin.Enabled == true then -- Don't care. If you enable VIPAdmin, VIPAllowed should be on as well.
			if game:GetService("MarketplaceService"):UserOwnsGamePassAsync(player.UserId,8197340) == true then
				return 1
			end
		end

		return 0
	end
end

return mod