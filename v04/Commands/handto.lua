OnFire = function(plr,arg,env)
	if env.cmdstorage.HandTo.Active then
		if plr:GetRankInGroup(env.cmdstorage.HandTo.Settings.Group) >= env.cmdstorage.HandTo.Settings.MinimumRank then
			local target = env.GetPlayer(arg[2])
			if target then
				local Tool = plr.Character:FindFirstChildOfClass("Tool") or plr.Character:FindFirstChildOfClass("HopperBin")
				if Tool then
					plr.Humanoid:UnequipTools()
					wait()
					Tool.Parent = target.Backpack
					env.cmdsstorage.HandTo.PlayerScore[plr.Name] = env.cmdsstorage.HandTo.PlayerScore[plr.Name]+1
					return {true,"Successfully gave "..Tool.Name.." to "..target.Name}
				else
					return {false,"You aren't holding anything that can be given."}
				end
			else
				return {false,env.CurrentLanguage.CommandExec.NoFound}
			end
		else
			return {false,env.CurrentLanguage.CommandExec.NoPerm}
		end
	else
		return {false,"The command has been marked as inactive, and is unfunctional."}
	end
end

OnLoad = function(env)
	-- Please edit those settings accordingly.
	env.cmdstorage.HandTo = { -- If any command / function will want to use this for the environment, make sure to notify that command is in fact a thing.
		Active = true,
		Settings = {
			Group = 0,
			MinimumRank = 0,
		},
		PlayerScore = {},
	};
	if env.cmdstorage.HandTo.Active == false then
		warn("If you want to disable a command, please either delete it or drag it to the __Disabled folder.")
	end
end

return {
	ModuleType = "Command",
	Usage = "<target>", 
	ModName = "handto",
	Alias = {},
	Level = 0,
	Sandbox = false,
	Libraries = {},
	Dependencies = {},
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
