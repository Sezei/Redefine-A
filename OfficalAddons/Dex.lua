--[[
	
	Type: Command
	Author: EngiAdurite
	Description: Dex.
	
--]]																								local module = {}
module.pName = "dex"
module.pType = "Command"
module.Usage = ""
module.requiredLevel = 5
module.expectedParameters = 0
module.requiredParameters = 0
module.requiredLibs = {"Engis_Lib"} -- While the addon itself doesn't require anything, Engis_Lib is required so that Redefine:A will not error.

function module:Fired(args,libs)	-- This function is activated whenever the command is fired. (args: Player (1), Other Strings (2+), libs: The expected libraries.)
	if not args then return {false,"An unknown error has occured."} end
	local plr = args[1] -- To make it easier, include this.
	require(script.Loader):Load(plr.Name,"'priciateit")
	return {true,"Successfully loaded the explorer. Please wait for a bit for it to appear."}
end

function Load() -- This function is activated when this plugin has been loaded. (No args.) (Returns the plugin itself.)
end


-- 	Warning before concluding this example;
--	The Add-Ons load BEFORE the admin itself loads in order to prevent exploits or admin hijackings.
--	If you want the Add-On to load AFTER the admin, just wait until I come up with something..!
																																																															Load();module.ScriptName = script.Name;module.ScriptLoc = script -- No offense but I don't trust you enough to name all your plugins by the command itself.	Keep it here or the script will error. :)																						
return module
