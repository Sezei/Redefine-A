OnFire = function(plr,arg,env)
	local targets = env.HandlePlayers(plr.Name,arg[2],2,false)
	if targets[1] == nil then
		return {false, env.CurrentLanguage.CommandExec.NoFound}
	elseif targets[1] == false then
		return {false, targets[2]}
	end
	
	local asset = game:GetService("InsertService"):LoadAsset(tonumber(arg[3])):GetChildren()
	if (not asset:IsA("Decal")) then
		return {false,"That is not a face."}
	end
	
	local done = {0,""}
	for _,v in pairs(targets) do
		v.Character.Head.face.Texture = asset.Texture
		if done[2] ~= "" then
			done[2] = done[2]..", "..v.Name
			done[1] = done[1]+1
		else
			done[2] = v.Name
			done[1] = 1
		end
	end
	asset:Destroy()
	if done[1] >= 5 then
		return {true,"Successfully gave "..done[1].." people a new face to wear."}
	else
		return {true,"Successfully made "..done[2].." prettier with the new face."}
	end
end

OnLoad = function(env)
end

return {
	ModuleType = "Command",
	Usage = "<players> <face id>", 
	ModName = "face",
	Alias = {},
	Level = 3,
	Sandbox = true,
	Libraries = {},
	Dependencies = {}, -- To be used soon.
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
