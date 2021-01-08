local scache = {};
local admin = {};

admin.LoadComplete = false
admin.InitComplete = false

function admin:Load(setting,env)
	scache = setting
	-- Deps
	env.signalservice = require(script.Dependencies.Signal)
	env.Data = require(script.Dependencies.DataStorage)
	env.RC3S = require(script.Dependencies.RedefineColor3Strings)
	env.Scripter = require(script.Dependencies.Loadstring)
	
	-- Services
	env.HttpService = game:GetService("HttpService")
	env.TextService = game:GetService("TextService")
	env.ServerStorage = game:GetService("ServerStorage")
	
	-- Remotes
	env.event = Instance.new("RemoteEvent",game:GetService("ReplicatedStorage"))
	env.event.Name = "RedefineANotificationsHandler"
	env.func = Instance.new("RemoteFunction",game:GetService("ReplicatedStorage"))
	env.func.Name = "RARemoteFunction"
	
	-- Uneditable Variables (Variables that shouldn't be edited)
	env.notificationsfolder = Instance.new("Folder",game.ReplicatedStorage)
	env.usersfolder = Instance.new("Folder",game.ReplicatedStorage)
	env.UI = script.UI
	env.Settings = scache
	env.UserAdded = env.signalservice.new()
	env.CommandFired = env.signalservice.new()
	env.gameSecret = math.random(1,os.time()).."_RA_"..game.CreatorId -- No, really, don't touch it if you will need support from R:A staff.
	
	-- Variables
	env.cmdstorage = {} -- Commands that need some kind of environment access without disturbing the rest of it can still go through here.
	env.userids = 0
	env.chatlogs = {}
	env.exploitlogs = {}
	env.serverlock = {false,0} -- { bool "Active" , ra_level "MinimumLevel" }
	env.pmessage = {false,""} -- { bool "Active" , string "Message" }
	
	admin.LoadComplete = true
	return script
end

function admin:Init(env)
	-- Current Language
	local found = false
	for _,v in pairs(script.MainLanguages:GetChildren()) do
		if v:IsA("ModuleScript") then
			local mod = require(v)
			if type(mod) == "table" then
				if mod.ModuleType == "Language" then
					if mod.Language == env.Settings.Language then
						env.CurrentLanguage = mod
						found = true
					end
				end
			else
				warn("Module "..v.Name.." has failed to load: Module is not a table.")
			end
		end
	end
	
	if not found then
		warn("Stated language wasn't found. Reverting to English.")
		env.CurrentLanguage = require(script.MainLanguages.English)
	end
	
	-- Functions
	for _,v in pairs(script.MainFunctions:GetChildren()) do
		if v:IsA("ModuleScript") then
			local mod = require(v)
			if type(mod) == "table" then
				if mod.ModuleType == "Function" then
					mod:Unpack(env)
				end
			else
				warn("Module "..v.Name.." has failed to load: Module is not a table.")
			end
		end
	end

	for _,v in pairs(script.Parent.Functions:GetChildren()) do
		if v:IsA("ModuleScript") then
			local mod = require(v)
			if type(mod) == "table" then
				if mod.ModuleType == "Function" then
					mod:Unpack(env)
				end
			else
				warn("Module "..v.Name.." has failed to load: Module is not a table.")
			end
		end
	end
	
	-- Desktop setup
	if script.Parent.Desktop then
		for _,v in pairs(script.MainCommands.Desktop:GetChildren()) do
			if v.ClassName == "Folder" then
				v:Destroy()
			end
		end
		for _,v in pairs(script.Parent.Desktop:GetChildren()) do
			v.Parent = script.MainCommands.Desktop
		end
	else
		
	end
	
	-- Commands
	env.Commands = {}; -- Reset commands.
	for _,v in pairs(script.MainCommands:GetChildren()) do -- Main Commands
		local dis = false
		if v:IsA("ModuleScript") then
			local mod = require(v)
			if type(mod) == "table" then
				if mod.ModuleType == "Command" then
					for _,d in pairs(env.Settings.DisabledCommands) do
						if mod.ModName == d and d ~= "settings" and d ~= "cmds" and d ~= "lpid" then
							dis = true
						end
					end
					if not dis then
						env.Commands[#env.Commands+1] = mod
						mod.ModLoad(env)
					end
				end
			else
				error("Main module "..v.Name.." has failed to load: Module is not a table.")
			end
		end
	end
	
	for _,v in pairs(script.Parent.Commands:GetChildren()) do
		if v:IsA("ModuleScript") then
			local mod = require(v)
			if type(mod) == "table" then
				if mod.ModuleType == "Command" then
					env.Commands[#env.Commands+1] = mod
					mod.ModLoad(env)
				end
			else
				warn("Module "..v.Name.." has failed to load: Module is not a table.")
			end
		end
	end
	
	-- Load Datastores
	env.mdb = env.Data:GetCategory("Main_RedefineA")
	local dbcat = env.mdb:Load("admincat")
	dbcat:wait()
	if dbcat.Data then
		env.db = env.Data:GetCategory(dbcat.Data)
	else
		env.db = env.Data:GetCategory("V04_RedefineA")
	end
	
	pcall(function() -- Load the admins.
		local Load = env.db:Load("AdminList")
		Load:wait()
		env.Admins = Load.Data
	end)
	
	if not env.Admins or env.Admins == nil then -- Make sure everything actually loaded. (If it didn't, then either datastore is down, or there wasn't any data.)
		env.db:Save("AdminList",env.Settings.Admins)
		env.Admins = env.Settings.Admins
	end
	
	-- Remotes being turned alive
	env.enableFunc()
	env.enableEvent()
	
	-- Joins
	for _,player in pairs(game.Players:GetPlayers()) do -- Handle existing players.
		env:HandleJoin(player)
	end
	
	game.Players.PlayerAdded:Connect(function(player)
		env:HandleJoin(player)
	end)
	
	print("Redefine:A | Loaded and ready! Game Secret (Don't share this): "..env.gameSecret)
	
	admin.InitComplete = true
end

return admin
