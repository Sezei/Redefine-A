OnFire = function(plr,arg,env)
	local Players = game:GetService("Players")

	if env.ServerStorage:FindFirstChild("ra_wsbackup") then
		for i,v in pairs(workspace:GetChildren()) do
			if Players:FindFirstChild(v.Name) == nil then
				pcall(function()
					v:Destroy()
					wait()
				end)
			end
		end
		for i, part in ipairs(env.ServerStorage.ra_wsbackup:GetChildren()) do
			pcall(function()
				local cloned = part:Clone()
				cloned.Parent = workspace
				wait()
			end)
		end	
		return{true,"Workspace loaded."}
	else
		return{false,"No backup has been created sadly. Nothing to restore from."}
	end
end

OnLoad = function(env)
end

return {
	ModuleType = "Command",
	Usage = "", 
	ModName = "loadws",
	Alias = {},
	Level = 4,
	Sandbox = false,
	Libraries = {},
	Dependencies = {}, -- To be used soon.
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
