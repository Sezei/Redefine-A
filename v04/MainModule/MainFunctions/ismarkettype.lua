local mod = {}

mod.ModuleType = "Function"

function mod:Unpack(env)
	function env.MarketType(id,typ)
		if tonumber(id) then
			local Asset
			local success,message = pcall(function()
				Asset = game:GetService("MarketplaceService"):GetProductInfo(id)
			end)
			if success then
				print(Asset.AssetTypeId)
				if Asset.AssetTypeId == typ then
					return true
				end
			else
				warn("REDEFINE:A | MarketType error: "..message)
				return false
			end
		end
		return false
	end
end

return mod