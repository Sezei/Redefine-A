local mod = {}

mod.ModuleType = "Function"

function mod:Unpack(env)
	function env.isOwner(plr)
		if game.CreatorType == Enum.CreatorType.User then
			if plr.UserId == game.CreatorId or env.GetLevel(plr) == 6 then
				return true
			else
				return false
			end
		elseif game.CreatorType == Enum.CreatorType.Group then
			local group = game:GetService("GroupService"):GetGroupInfoAsync(game.CreatorId)
			if plr.UserId == group.Owner.Id or env.GetLevel(plr) == 6 then
				return true
			else
				return false
			end
		end
	end
end

return mod