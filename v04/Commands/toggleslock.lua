OnFire = function(plr,arg,env)
	if env.serverlock[1] == true then
		env.serverlock = {false,0}
		return {true,"The server has been unlocked."}
	elseif env.serverlock[1] == false then
		if not arg[2] then
			arg[2] = "2"
		end
		if tonumber(arg[2]) <= env.GetLevel(plr) then
			env.serverlock = {true,arg[2]}
		else
			return {false,"You cannot lock a server to a level higher than yours."}
		end
		return {true,"The server has been locked to level "..arg[2].." and higher."}
	end
end

OnLoad = function(env)
end

return {
	ModuleType = "Command",
	Usage = "", 
	ModName = "toggleslock",
	Alias = {"sl"},
	Level = 4,
	Sandbox = false,
	Libraries = {},
	Dependencies = {}, -- To be used soon.
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
