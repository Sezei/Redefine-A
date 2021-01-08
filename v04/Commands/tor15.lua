OnFire = function(plr,arg,env)
	local targets = env.HandlePlayers(plr.Name,arg[2],2,false)
	if targets[1] == nil then
		return {false, env.CurrentLanguage.CommandExec.NoFound}
	elseif targets[1] == false then
		return {false, targets[2]}
	end
	local done = {0,""}
	for _,v in pairs(targets) do
		if v.Character.Humanoid then
			toR15(v)
		end
		if done[2] ~= "" then
			done[2] = done[2]..", "..v.Name
			done[1] = done[1]+1
		else
			done[2] = v.Name
			done[1] = 1
		end
	end
	if done[1] >= 2 then
		return {true,"Successfully turned "..done[1].." people into R15 characters."}
	else
		return {true,"Successfully turned "..done[2].." into an R15 character."}
	end
end

OnLoad = function(env)
	function toR15(plr)
		local newRig = script.PlayerModels.r15:Clone()
		local newHumanoid = newRig.Humanoid
		local originalCFrame = plr.Character.Head.CFrame
		newRig.Name = plr.Name
		for a,b in pairs(plr.Character:GetChildren()) do
			if b:IsA("Accessory") or b:IsA("Pants") or b:IsA("Shirt") or b:IsA("ShirtGraphic") or b:IsA("BodyColors") then
				b.Parent = newRig
			elseif b.Name == "Head" and b:FindFirstChild("face") then
				newRig.Head.face.Texture = b.face.Texture
			end
		end
		plr.Character = newRig
		newRig.Parent = workspace
		newRig.Head.CFrame = originalCFrame
	end
end

return {
	ModuleType = "Command",
	Usage = "<players>", 
	ModName = "tor15",
	Alias = {"r15"},
	Level = 3,
	Sandbox = true,
	Libraries = {},
	Dependencies = {}, -- To be used soon.
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
