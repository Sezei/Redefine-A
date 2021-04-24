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
	local load = env.mdb:Load("DESKTOP_"..plr.UserId.."_FirstTimeDisplayed")
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
	http = env.HttpService

	sfunc = Instance.new("RemoteFunction")
	sfunc.Parent = game:GetService("ReplicatedStorage")
	sfunc.Name = "RA_DesktopEvent"
	sfunc.OnServerInvoke = (function(plr,invoketype,args)
		if invoketype == "Save" then
			local sav = env.mdb:Save("DESKTOP_"..plr.UserId.."_"..args[1],args[2]) -- We need to save it in the MDB because it's players' choice, and shouldn't be interfered by admin resets & changes.
			sav:wait()
			if sav.Complete then
				return true
			else
				return false
			end
		elseif invoketype == "Load" then
			local lod = env.mdb:Load("DESKTOP_"..plr.UserId.."_"..args[1]) -- We need to save it in the MDB because it's players' choice, and shouldn't be interfered by admin resets & changes.
			lod:wait()
			if lod.Data then
				return lod.Data
			else
				return nil
			end
		end
	end)
end

return {
	ModuleType = "Command",
	Usage = "", 
	ModName = "desktop",
	Alias = {},
	Level = 0,
	Sandbox = true,
	Libraries = {},
	Dependencies = {},
	ModFunction = OnFire,
	ModLoad = OnLoad,
}