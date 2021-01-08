OnFire = function(plr,arg,env)
	if not arg[2] then
		return {false,"Sorry, I have no idea what a BLANK TIME is. Maybe try adding a variable or something idk."}
	end

	if arg[2] == "day" or arg[2] == "midday" or arg[2] == "daytime" or arg[2] == "noon" or arg[2] == "nightn't" then
		game:GetService("Lighting").TimeOfDay = "12:00:00"
		return {true,"Set the time to 12:00:00"}
	elseif arg[2] == "afternoon" then
		game:GetService("Lighting").TimeOfDay = "15:00:00"
		return {true,"Set the time to 15:00:00"}
	elseif arg[2] == "sunrise" or arg[2] == "morning" or arg[2] == "dawn" then
		game:GetService("Lighting").TimeOfDay = "6:15:00"
		return {true,"Set the time to 6:15:00"}
	elseif arg[2] == "evening" or arg[2] == "dusk" then
		game:GetService("Lighting").TimeOfDay = "18:00:00"
		return {true,"Set the time to 18:00:00"}
	elseif arg[2] == "midnight" or arg[2] == "night" or arg[2] == "nighttime" or arg[2] == "dayn't" then
		game:GetService("Lighting").TimeOfDay = "23:00:00"
		return {true,"Set the time to 23:00:00"}
	else
		game:GetService("Lighting").TimeOfDay = arg[2]
		return {true,"Set the time to "..arg[2]}
	end
end

OnLoad = function(env)
end

return {
	ModuleType = "Command",
	Usage = "<time / xx:xx:xx>", 
	ModName = "time",
	Alias = {},
	Level = 3,
	Sandbox = true,
	Libraries = {},
	Dependencies = {}, -- To be used soon.
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
