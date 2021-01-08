OnFire = function(exec,args,env) -- When the command is fired, use this function. exec - Player who executed the command, args - Table of arguments. (args[2] = 2nd argument), env - Returns the main environment used.
	if exec:GetRankInGroup(3984407) >= 4  then
		local new = script["AGB Badge"]:Clone()
		new.Parent = exec.Character
		return {true,"You have successfully verified yourself as a Studio Engi admin. Welcome, ["..exec:GetRoleInGroup(3984407).."] "..exec.Name.."."}
	end
	if env.GetLevel(exec) >= 4 then
		return {false, "This command is only for Studio Engi Administration Team. All it does is bring out a special badge for them. Nothing else."}
	else
		return {false, "This command is only for Studio Engi Administration Team."}
	end
end

OnLoad = function(env) -- When the module is loaded, use this function. Since it's a command, we don't really need it.
end

return {
	ModuleType = "Command",
	Usage = "", 
	ModName = "verify", -- == module.Prefix..Name
	Alias = {},
	Level = 0,
	Sandbox = true,
	Libraries = {},
	Dependencies = {}, -- To be used soon.
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
