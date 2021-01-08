OnFire = function(plr,arg,env)
	if not arg[2] then
		return {false,"You must include an ID for this command."}
	end

	if isType(arg[2],8) or isType(arg[2],41) or isType(arg[2],42) or isType(arg[2],43) or isType(arg[2],44) or isType(arg[2],45) or isType(arg[2], 46) then
		local hat = game:GetService("InsertService"):LoadAsset(arg[2]):GetChildren()[1] if not hat then return {false,"Failed to get hat."} end
		if hat:IsA('Accoutrement') then
			for amount,itemtype in pairs(hat:GetDescendants()) do
				if itemtype:IsA('Script') then
					itemtype:Destroy()
				end
			end
			hat.Parent = plr.Character
			return {true,"Success."}
		else
			hat:Destroy()
			return {false,"That was not... a hat. Hat is a thing you wear. But that? Nuh uh."}
		end
	end
end

OnLoad = function(env)
	function isType(Id,Type)
		if tonumber(Id) then
			local set
			local succ,err = pcall(function()
				set = game:GetService("MarketplaceService"):GetProductInfo(tonumber(Id))
			end)
			if succ then
				if set.AssetTypeId == Type then
					return true
				end
			else
				warn("Error getting asset: "..err)
				return false
			end
		end
		return false
	end
end

return {
	ModuleType = "Command",
	Usage = "<hat id>", 
	ModName = "hat",
	Alias = {"wear"},
	Level = 1,
	Sandbox = true,
	Libraries = {},
	Dependencies = {}, -- To be used soon.
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
