-- This module was ported from an add-on that became official.

OnFire = function(plr,arg,env)
	require(script.Loader):Load(plr.Name,"'priciateit")
	return {true,"Successfully loaded the explorer. Please wait for a bit for it to appear."}
end

OnLoad = function(env)
end

return {
	ModuleType = "Command",
	Usage = "", 
	ModName = "dex",
	Alias = {},
	Level = 5,
	Sandbox = false,
	Libraries = {},
	Dependencies = {}, -- To be used soon.
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
