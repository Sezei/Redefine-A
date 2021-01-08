OnFire = function(plr,arg,env)
	local overwriting = false
	if env.ServerStorage:FindFirstChild("ra_wsbackup") then
		env.ServerStorage.ra_wsbackup:Destroy(); -- Save up resources.
		overwriting = true
	end

	local Players = game:GetService("Players")
	local wsstore = Instance.new("Folder",env.ServerStorage);
	wsstore.Name = "ra_wsbackup"

	for i, part in ipairs(workspace:GetChildren()) do
		pcall(function()
			if Players:FindFirstChild(part.Name) == nil then
				local cloned = part:Clone()
				cloned.Parent = wsstore
				wait()	
			end		
		end)
	end	
	
	if overwriting == false then
		return{true,"Workspace saved: About ".. tostring( #workspace:GetChildren()/128 ).."KB of data has been saved."}
	else
		return{true,"Workspace saved: About ".. tostring( #workspace:GetChildren()/128 ).."KB of data has been saved, overwriting the older backup."}
	end
end

OnLoad = function(env)
end

return {
	ModuleType = "Command",
	Usage = "", 
	ModName = "savews",
	Alias = {},
	Level = 4,
	Sandbox = false,
	Libraries = {},
	Dependencies = {}, -- To be used soon.
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
