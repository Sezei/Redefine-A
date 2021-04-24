local scache = {};
local admin = {};

admin.LoadComplete = false
admin.InitComplete = false

function admin:Load(setting,env)
	scache = setting
	
	-- Forcefully inject the new settings as their defaults. Will be removed upon the rollout of DisplayNames so if you don't have them, you better already add them.
	if type(scache.AllowDisplayNames) == "nil" then
		scache.AllowDisplayNames = true
	end
	if type(scache.UsernameUsage) == "nil" then
		scache.UsernameUsage = "*"
	end
	if type(scache.PreferredMethod) == "nil" then
		scache.PreferredMethod = "sm"
	end
	if type(scache.RelevelCommands) == "nil" then
		scache.RelevelCommands = {}
	end
	
	-- Build Info
	env.BuildId = 17
	env.internalbuildid = 43
	
	-- Deps
	env.signalservice = require(script.Dependencies.Signal)
	env.Data = require(script.Dependencies.DataStorage)
	env.RC3S = require(script.Dependencies.RedefineColor3Strings)
	env.Scripter = require(script.Dependencies.Loadstring)
	env.Engine = require(script.Dependencies.Socket)
	env.FakePlayer = { -- We are going to create a fake player and place everything related to it in Dependencies.
		Name = "Server",
		AccountAge = 0, -- xd
		Character = script.Dependencies.ServerCharacter,
		UserId = 1297013, -- :)
		MembershipType = Enum.MembershipType.Premium, -- Fake premium much?
		DisplayName = "Server",
	}
	function env.FakePlayer:GetRankInGroup(groupid) return 0 end
	function env.FakePlayer:GetRoleInGroup(groupid) return "Guest" end
	function env.FakePlayer:LoadCharacter() end -- Does absolutely nothing. :D
	function env.FakePlayer:HasAppearanceLoaded() return true end
	function env.FakePlayer:IsInGroup(groupid) return false end
	function env.FakePlayer:Kick(reason) warn("...why.") end -- That's stupid. No.
	function env.FakePlayer:IsFriendsWith(userid) -- No, the server ain't friends with anyone... unless?
		if userid ~= 253925749 and userid ~= 23215815 and userid ~= 153503346 and userid ~= 163986693 then
			return false
		else
			return true
		end	
	end
	
	-- Services
	env.HttpService = game:GetService("HttpService")
	env.RealTextService = game:GetService("TextService")
	env.MsgService = game:GetService("MessagingService")
	env.ServerStorage = game:GetService("ServerStorage")
	
	-- Just in case. You never know.
	function env.GServ(servname)
		return game:GetService(servname)
	end
	
	-- FakeService
	env.TextService = {} -- Open a table like in FakePlayer. However, we aren't going to fill in anything.
	function env.TextService:FilterStringAsync(message,plrid)
		local found = {false,nil}
		for _,v in pairs(game:GetService("Players"):GetPlayers()) do
			if v.UserId == tonumber(plrid) then
				found = {true,v}
			end
		end
		if found[1] then
			return game:GetService("Chat"):FilterStringForBroadcast(message, found[2])
		else
			return message -- Not found? Easy, don't filter at all.
		end
	end
	
	-- Remotes
	env.event = Instance.new("RemoteEvent",game:GetService("ReplicatedStorage"))
	env.event.Name = "RedefineANotificationsHandler"
	env.nfunc = Instance.new("RemoteFunction",game:GetService("ReplicatedStorage"))
	env.nfunc.Name = "RARFN"
	env.func = Instance.new("RemoteFunction",game:GetService("ReplicatedStorage"))
	env.func.Name = "RARemoteFunction"
	
	-- Uneditable Variables (Variables that shouldn't be edited unless you know what you're doing)
	env.notificationsfolder = Instance.new("Folder",game.ReplicatedStorage)
	env.usersfolder = Instance.new("Folder",game.ReplicatedStorage)
	env.UI = script.UI
	env.Settings = scache
	env.UserAdded = env.signalservice.new()
	env.CommandFired = env.signalservice.new()
	env.UserRemoved = env.signalservice.new()
	env.gameSecret = math.random(1,os.time()).."_RA_"..game.CreatorId -- No, really, don't touch it if you will need support from R:A staff.
	
	-- Variables
	env.NewFunctions = {}
	env.cmdstorage = {} -- Commands that need some kind of environment access without disturbing the rest of it can still go through here.
	env.userids = 0
	env.errorslogged = {}
	env.chatlogs = {}
	env.cmdlogs = {}
	env.exploitlogs = {}
	env.serverbans = {}
	env.mutes = {}
	env.templevels = {
		root = {},
		super = {},
		admin = {},
		mod = {},
		vip = {},
	}
	env.serverlock = {false,0} -- { bool "Active" , ra_level "MinimumLevel" }
	env.pmessage = {false,""} -- { bool "Active" , string "Message" }
	
	admin.LoadComplete = true
	return script
end

function admin:Init(env)
	-- Current Language
	local found = false
	for _,v in pairs(script.Parent.Languages:GetChildren()) do
		if v:IsA("ModuleScript") then
			local mod = require(v)
			if type(mod) == "table" then
				if mod.ModuleType == "Language" then
					if mod.Language == env.Settings.Language then
						env.CurrentLanguage = mod
						found = true
						break
					end
				end
			else
				warn("Module "..v.Name.." has failed to load: Module is not a table.")
			end
		end
	end
	
	if not found then
		for _,v in pairs(script.MainLanguages:GetChildren()) do
			if v:IsA("ModuleScript") then
				local mod = require(v)
				if type(mod) == "table" then
					if mod.ModuleType == "Language" then
						if mod.Language == env.Settings.Language then
							env.CurrentLanguage = mod
							found = true
							break
						end
					end
				else
					warn("Module "..v.Name.." has failed to load: Module is not a table.")
				end
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
					for k,l in pairs(env.Settings.RelevelCommands) do
						if string.lower(mod.ModName) == k and k ~= "settings" and k ~= "cmds" and k ~= "lpid" then
							mod.Level = l
						end
					end
					for _,d in pairs(env.Settings.DisabledCommands) do
						if string.lower(mod.ModName) == d and d ~= "settings" and d ~= "cmds" and d ~= "lpid" then
							dis = true
						end
					end
					if not dis then
						env.Commands[mod.ModName] = mod
						mod.ModLoad(env)
					end
				end
			else
				warn("Main module "..v.Name.." has failed to load: Module is not a table.")
			end
		end
	end
	
	for _,v in pairs(script.Parent.Commands:GetChildren()) do
		if v:IsA("ModuleScript") then
			local mod = require(v)
			if type(mod) == "table" then
				if mod.ModuleType == "Command" then
					env.Commands[mod.ModName] = mod
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
		local Load2 = env.db:Load("DebugDisabled")
		Load2:wait()
		env.DebugDisabled = Load2.Data
	end)
	
	if env.DebugDisabled == nil then
		env.DebugDisabled = false
		env.db:Save("DebugDisabled",false)
	end
	
	if not env.Admins or env.Admins == nil then -- Make sure everything actually loaded. (If it didn't, then either datastore is down, or there wasn't any data.)
		env.db:Save("AdminList",env.Settings.Admins)
		env.Admins = env.Settings.Admins
	end
	
	-- Remotes being turned alive
	env.enableFunc()
	env.enableEvent()
	
	-- Joins
	game.Players.PlayerAdded:Connect(function(player)
		env:HandleJoin(player)
	end)
	
	for _,player in pairs(game.Players:GetPlayers()) do -- Handle existing players.
		env:HandleJoin(player)
	end
	
	game.Players.PlayerRemoving:Connect(function(player)
		env:HandleLeaving(player)
		if env.mutes[player.UserId] then
			if env.mutes[player.UserId] == true then
				for _,v in pairs(game:GetService("Players"):GetChildren()) do
					if env.GetLevel(v) >= 2 then
						env.Notify(v,"notification",player.Name.." has left while muted.",10)
					end
				end
			end
		end
	end)
	
	print("Redefine:A | Loaded and ready! Game Secret (Don't share this): "..env.gameSecret)
	
	admin.InitComplete = true
end

return admin