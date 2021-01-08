-- NOTE: THIS MODULE IS USING IT'S OWN DATASTORE!
-- Port made by EngiAdurite from Redefine:A v.03 by EngiAdurite to Redefine:A v.04 by EngiAdurite.
-- Credits to EngiAdurite for the porting.

--Credits;
--	Pixabay
--		DarkmoonArt_de - Forest River
--		garageband - Abstract Paintings
--	Roblox Images
--		gabep08 - 1020120443

OnFire = function(plr,arg,env)
	local terminalcoms = script.TerminalCommands:Clone()
	local apps = script.Apps:Clone()
	local ops = script.RAos:Clone()
	apps.Parent = ops
	terminalcoms.Parent = ops
	ops.Enviroment.Prefix.Value = env.Settings.Prefix
	ops.Parent = plr.PlayerGui
	print("Loading FirstTimeDisplayed")
	local load = pdb:Load(plr.UserId.."s_desktop_FirstTimeDisplayed")
	load:wait()
	if load.Data then
		print("Data Exists: "..tostring(load.Data))
		if load.Data == true then
			ops.Enviroment.Login.Visible = true
			ops.Enviroment.FirstLogin.Visible = false
			ops.Enviroment.ImageLabel.Visible = true
			ops.Enviroment.Login.ImageLabel.LocalScript.Disabled = false
		else
			ops.Enviroment.FirstLogin.mainanimation.Disabled = false
		end
	else
		print("Data is nil.")
		ops.Enviroment.FirstLogin.mainanimation.Disabled = false
	end
	return {true,"Loading, please wait."}
end

OnLoad = function(env)
	dbs = env.Data
	pdb = dbs:GetCategory("RedefineA_Desktop")
	http = env.HttpService
	
	sfunc = Instance.new("RemoteFunction")
	sfunc.Parent = game:GetService("ReplicatedStorage")
	sfunc.Name = "RA_DesktopEvent"
	sfunc.OnServerInvoke = (function(plr,invoketype,args)
		if invoketype == "Save" then
			local save = pdb:Save(plr.UserId.."s_desktop_"..args[1],args[2])
			save:wait()
			return true
		elseif invoketype == "Load" then
			local load = pdb:Load(plr.UserId.."s_desktop_"..args[1])
			load:wait()
			if load.Completed == false then
				return "Cancel_TooLong"
			else
				return load.Data
			end
		elseif invoketype == "StoreLoad" then
			if env.isHttpEnabled() == true then
				if not storecache then
					local data = http:GetAsync("https://raw.githubusercontent.com/greasemonkey123/Redefine-A/master/LatestVersion.json",true)
					storecache = http:JSONDecode(data)
				end
				return {true,storecache}
			else
				return {false,"http_disabled"}
			end
		end
	end)
end

return {
	ModuleType = "Command",
	Usage = "/ Notice: This is unstable, and can get your admin system fried.", 
	ModName = "desktop",
	Alias = {},
	Level = 0,
	Sandbox = true,
	Libraries = {},
	Dependencies = {},
	ModFunction = OnFire,
	ModLoad = OnLoad,
}