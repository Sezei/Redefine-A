OnFire = function(plr,arg,env) -- When the command is fired, use this function. exec - Player who executed the command, args - Table of arguments. (args[2] = 2nd argument), env - Returns the main environment used.
	if arg[2] == "@me" or arg[2] == "@p" or arg[2] == "@s" or arg[2] == "me" or arg[2] == plr.Name or arg[2] == plr.UserId then
		return {false,"👏👏👏 Congratulations. The command worked. 👏👏👏"}
	end
	if not arg[2] then
		return {false,"A variable is required."}
	end
	if not tonumber(arg[2]) then
		return {false,"The variable must be a UserId."}
	end
	local found = false
	for k,v in pairs(env.Admins.BanLand) do
		if v[1] == tonumber(arg[2]) then
			env.Admins.BanLand[k] = nil
			found = true
			break
		end
	end
	if not found then
		for k,v in pairs(env.serverbans) do
			if v[1] == tonumber(arg[2]) then
				env.serverbans[k] = nil
				found = true
				break
			end
		end
	end
	local name = "[Failed to fetch name]"
	pcall(function()
		name = game:GetService("Players"):GetNameFromUserIdAsync(tonumber(arg[2]))
	end)
	if found == true then
		return {true,name.." has been unbanned. (Remember to do "..env.Settings.Prefix.."saveadmins !)"}
	else
		return {false,arg[2].. " (" .. name ..") wasn't found in the banlist. [Did you search by UserId?]"}
	end
end

OnLoad = function(env) -- When the module is loaded, use this function. Since it's a command, we don't really need it.
end

return {
	ModuleType = "Command",
	Usage = "<userid>", 
	ModName = "unban", -- == module.Prefix..Name
	Alias = {},
	Level = 4,
	Sandbox = false,
	Libraries = {},
	Dependencies = {}, -- To be used soon.
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
