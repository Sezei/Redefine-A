--[[																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																									--]]local Module = {};local module = {};local internalbuildid = 148--[[ requir- HA! U GOT FOOLED! no, there are no backdoors here.																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																			Hello!
   _____ _             _ _         ______             _ 
  / ____| |           | (_)       |  ____|           (_)
 | (___ | |_ _   _  __| |_  ___   | |__   _ __   __ _ _ 
  \___ \| __| | | |/ _` | |/ _ \  |  __| | '_ \ / _` | |
  ____) | |_| |_| | (_| | | (_) | | |____| | | | (_| | |
 |_____/ \__|\__,_|\__,_|_|\___/  |______|_| |_|\__, |_|
	            	                             __/ |  
       										    |___/   

--------------------------------------------------------------

You can help too by making pull requests in the official Github;
greasemonkey123/Redefine-A

--------------------------------------------------------------

Copyright Protected © Studio Engi, EngiAdurite and the Lead Contributors, 2020.
Refer to the Internal Use Info & License for more info.

Please note, using any of this material without permission for malicious intents might result in a DMCA takedown!

Warning: Redefine:A Plugins WILL NOT be applicable for Copyright, and must be open source!

--------------------------------------------------------------

All credits are in the loader.
This is the first public beta build available for testing.

--------------------------------------------------------------

DISCLAIMER
----------
If the creator of the model is not "Studio Engi" or "EngiAdurite", then the model is FAKE!

Make sure you only get the admin only from EngiAdurite or Studio Engi (Group) to avoid backdoors!

If you got the model, but the model wasn't published by EngiAdurite or Studio Engi,
Please report the incident to EngiAdurite on Roblox Devforum or Discord (Sezei#3061).


Note for Developers
-------------------
If you're planning to create custom plugins, make sure to use the PLUGINSTORAGE
part of R:A to save plugin data. You can use the manageData function to do so.

--------------------------------------------------------------
--]]

-- If you really want to have a sandbox mode, turn this on. This will disable most abusive commands but give everyone root admin.
sandboxmode = false

loadtime = tick()
totalloadtime = 0

dbs = require(script.DataStorage)
db = dbs:GetCategory("Admin_RedefineA")
pdb = dbs:GetCategory("PluginStorage_RedefineA")
notificationsfolder = Instance.new("Folder",game.ReplicatedStorage)
usersfolder = Instance.new("Folder",game.ReplicatedStorage)
userids = 0
event = Instance.new("RemoteEvent",game:GetService("ReplicatedStorage"))
event.Name = "RedefineANotificationsHandler"
func = Instance.new("RemoteFunction",game:GetService("ReplicatedStorage"))
func.Name = "RARemoteFunction"
HttpService = game:GetService("HttpService")
loader = require(script.Loadstring)
gameSecret = math.random(1,os.time()).."_RA_"..game.CreatorId
serverlock = {false,0}

module.HideMain = false
module.MadeforBuild = 70
Loaded = false
module.SeasonalThemes = true

function round(num1, num2)
	local mult = 10^(num2 or 0)
	return math.floor(num1 * mult + 0.5) / mult
end

module.BuildVer = "v03.2Pre3A"
module.BuildId = 73

function Module:Load(Prefix,SilentEnabled,Admins,GroupAdmin,VIPAdmin,Theme,BanMessage,DefaultBanReason,EnableGlobalBanList,AutomaticAdminSave,SaveEvery,VIPAllowed,LegacyUI,AutoUpdate,MadeforBuild,HideMain,SeasonsEnabled)
	module.Prefix = Prefix
	module.SilentEnabled = SilentEnabled
	module.Admins = Admins
	module.GroupAdmin = GroupAdmin
	module.VIPAdmin = VIPAdmin
	module.Theme = Theme
	module.BanMessage = BanMessage
	module.DefaultBanReason = DefaultBanReason
	module.EnableGlobalBanList = EnableGlobalBanList
	module.AutomaticAdminSave = AutomaticAdminSave
	module.SaveEvery = SaveEvery
	module.VIPAllowed = VIPAllowed or true
	module.LegacyEnabled = LegacyUI or false
	module.UpdateEnabled = AutoUpdate or false
	module.MadeforBuild = MadeforBuild or 68 -- haha no.
	module.HideMain = HideMain or false
	module.SeasonalThemes = SeasonsEnabled or true

	if module.EnableGlobalBanList == true then
		require(2498483497)
	end

	if not Admins or Admins == nil then
		local Save = db:Save("AdminList",module.Admins)
		Save:wait()
		Admins = module.Admins
	end

	-- Build 68: Relocated build info

	script.prefix.Value = module.Prefix

	print("Redefine:A has been loaded in "..round(tick()-loadtime,2).." seconds! | Prefix; "..module.Prefix.." | Game Secret; "..gameSecret.." (Do not share it!) | R:A Version; "..module.BuildVer)
	totalloadtime = round(tick()-loadtime,2)

	print("Redefine:A | Checking for players that already exist.")

	for _,player in pairs(game.Players:GetPlayers()) do
		print("R:A Debug | Checking if "..player.Name.." was already handled.")
		if not usersfolder:FindFirstChild(player.Name) then
			print("R:A Debug | Player "..player.Name.." wasn't handled. Handling player...")
			local newinstance = Instance.new("NumberValue",notificationsfolder)
			newinstance.Name = player.Name
			Instance.new("Folder",player).Name = "Notifications"

			userids = userids+1
			local pid = Instance.new("StringValue",usersfolder)
			pid.Name = player.Name
			pid.Value = "#"..userids.." | "..player.Name.." ("..GetLevel(player)..")"

			local newUI = script.MainUI:Clone()
			newUI.Parent = player.PlayerGui

			if module.HideMain == true then
				func:InvokeClient(player,"HideMain")
			end

			player.Chatted:Connect(function(msg,receiver)
				addChatlog(player,msg)
				if receiver then return end
				local succ,cmd = pcall(cmds,player,msg)
				if succ then
					if cmd == "none" then else
						if cmd[1] == false then
							Notify(player,"error",cmd[2])
						elseif cmd[1] == true then
							Notify(player,"done",cmd[2])
						else end
					end
				else
					Notify(player,"critical","An error has occured: "..cmd)
				end
			end)
			local isBan = GetLevel(player)
			if isBan == -99 then
				for _,v in pairs(Admins.BanLand) do
					if v[1] == player.UserId then
						if v[2] then
							reason = v[2]
						else
							reason = module.DefaultBanReason
						end
					end
				end
				player:Kick(module.BanMessage.." "..reason)
			else
				print(player.Name.." | "..isBan)
				local new = script.Welcome:Clone()
				newUI.Main.AboutFrame.Label.Text = [[This game is powered by the Redefine:A Administration System, created by Studio Engi.

Your administration flag is ]]..isBan..[[.]]
				if isBan >= 1 then
					if sandboxmode == false then
						Notify(player,"welcome","Welcome! This game is using Redefine:A. Your Admin level is "..isBan..".")
					elseif sandboxmode == true then
						Notify(player,"welcome","Welcome! Sandbox mode is enabled, so you got Root Admin!")
					end
					newUI.Main.CmdBar.ImageButton.LocalScript.Disabled = false
					newUI.Main.CmdBar.Prefix.Value = module.Prefix
				end
				if serverlock[1] == true and isBan <= serverlock[2] then
					player:Kick("[R:A] The server is currently locked. Please try again later or join a new server.")
					for _,v in pairs(game.Players:GetPlayers()) do
						if GetLevel(v) >= 2 then
							Notify(v,"error",player.Name.." has attempted to join but the server is locked.")
						end
					end
				elseif serverlock[1] == true and isBan >= serverlock[2] then
					Notify(player,"notification","The server is currently locked, but your admin level has bypassed the lock.")
				end
				if isBan == 5 and sandboxmode == false then
					if module.UpdateEnabled == true then
						if isHttpEnabled() == true then
							local data = HttpService:GetAsync("https://raw.githubusercontent.com/greasemonkey123/Redefine-A/master/LatestVersion.json",true)
							local checkNew = HttpService:JSONDecode(data)
							if checkNew.LatestVersion == module.BuildVer then
							else
								if tonumber(checkNew.LatestCriticalBuild) > module.MadeforBuild then
									Notify(player,"critical","A Critical update is awaiting! Please update the Redefine:A loader script!")
								else
									Notify(player,checkNew.UpdateType,"Notice: Redefine:A is outdated! The new version is "..checkNew.LatestVersion.."! Since AutoUpdate is enabled, all you need to do is shutdown the server.")
								end
							end
						else
							Notify(player,"error","HTTP Service is disabled, therefore we can't check if the version is up-to-date. The admin will still function properly, however.")
						end
					elseif module.UpdateEnabled == false then
						if isHttpEnabled() == true then
							local data = HttpService:GetAsync("https://raw.githubusercontent.com/greasemonkey123/Redefine-A/master/LatestVersion.json",true)
							local checkNew = HttpService:JSONDecode(data)
							if checkNew.LatestVersion == module.BuildVer then
							elseif tonumber(checkNew.LatestCriticalBuild) > module.MadeforBuild then
								Notify(player,"critical","A Critical update is awaiting! Please update the Redefine:A loader script!")
							end
						end
					end
				end
			end
		else
			print("R:A Debug | "..player.Name.." was already handled. Skipping.")
			if module.HideMain == true then
				func:InvokeClient(player,"HideMain")
			end
		end
		Loaded = true
	end
end

--[[
	Please do not edit anything below this line unless you know what you're doing.
	Support for custom commands is already here! (module > Add-Ons)
--]]

Themes = {}
CustomCommands = {}
Extras = {} -- Libraries and undefined stuff.
extracolors = require(script.RedefineColor3Strings)

module.Theme = "Light" --Default theme in case of a.... well, failed theme selection.


Themes[#Themes+1] = { -- Light
	pName = "Light",
	pType = "Theme",
	version = "V.02",
	Theme = {
		["BackgroundColor"] = Color3.fromRGB(255,255,255),
		["TextColor"] = Color3.fromRGB(0,0,0),
		["Highlight"] = {Color3.fromRGB(0,170,255),Color3.fromRGB(0,0,0)},
		["Logo"] = Color3.fromRGB(255,255,255),
		["SideColor"] = extracolors:GetColor("liteblue"),
		done = {
			["Color"] = extracolors:GetColor("green"),
			["Image"] = {4146192662,extracolors:GetColor("white")} -- Image, ImageColor3
		},
		err = {
			["Color"] = extracolors:GetColor("red"),
			["Image"] = {4146192101,extracolors:GetColor("white")} -- Image, ImageColor3
		},
		notif = {
			["Color"] = extracolors:GetColor("orange"),
			["Exclamation"] = extracolors:GetColor("white") -- Color for the exclamation mark.
		},
		welcome = {
			["Color"] = extracolors:GetColor("liteblue"),
			["Icon"] = extracolors:GetColor("white") -- Color for the exclamation mark.
		},
		cmd = {
			["Color"] = extracolors:GetColor("liteblue"),
			["Icon"] = extracolors:GetColor("white")
		}
	}
}

Themes[#Themes+1] = { -- Dark
	pName = "Dark",
	pType = "Theme",
	version = "V.02",
	Theme = {
		["BackgroundColor"] = extracolors:GetColor("black"),
		["TextColor"] = extracolors:GetColor("white"),
		["Highlight"] = {Color3.fromRGB(0,255,170),extracolors:GetColor("white")},
		["Logo"] = extracolors:GetColor("white"),
		["SideColor"] = extracolors:GetColor("black"),
		done = {
			["Color"] = extracolors:GetColor("black"),
			["Image"] = {4146192662,extracolors:GetColor("litegreen")} -- Image, ImageColor3
		},
		err = {
			["Color"] = extracolors:GetColor("black"),
			["Image"] = {4146192101,extracolors:GetColor("litered")} -- Image, ImageColor3
		},
		notif = {
			["Color"] = extracolors:GetColor("black"),
			["Exclamation"] = extracolors:GetColor("orange") -- Color for the exclamation mark.
		},
		welcome = {
			["Color"] = extracolors:GetColor("royalturq"),
			["Icon"] = extracolors:GetColor("black") -- Color for the exclamation mark.
		},
		cmd = {
			["Color"] = extracolors:GetColor("royalturq"),
			["Icon"] = extracolors:GetColor("white")
		}
	}
}

Themes[#Themes+1] = { -- Sea
	pName = "Sea",
	pType = "Theme",
	version = "V.02",
	Theme = {
		["BackgroundColor"] = extracolors:GetColor("blue"),
		["TextColor"] = extracolors:GetColor("white"),
		["Highlight"] = {extracolors:GetColor("royalturq"),extracolors:GetColor("black")},
		["Logo"] = extracolors:GetColor("white"),
		["SideColor"] = extracolors:GetColor("turquoise"),
		done = {
			["Color"] = extracolors:GetColor("black"),
			["Image"] = {4146192662,extracolors:GetColor("litegreen")} -- Image, ImageColor3
		},
		err = {
			["Color"] = extracolors:GetColor("black"),
			["Image"] = {4146192101,extracolors:GetColor("litered")} -- Image, ImageColor3
		},
		notif = {
			["Color"] = extracolors:GetColor("black"),
			["Exclamation"] = extracolors:GetColor("orange") -- Color for the exclamation mark.
		},
		welcome = {
			["Color"] = extracolors:GetColor("black"),
			["Icon"] = extracolors:GetColor("royalturq") -- Color for the exclamation mark.
		},
		cmd = {
			["Color"] = extracolors:GetColor("black"),
			["Icon"] = extracolors:GetColor("royalturq")
		}
	}
}

resetactivated = false -- Please keep it at false. This is a very important fail-safe!

pcall(function()
	print("Loading Admins!")
	local Load = db:Load("AdminList")
	Load:wait()
	Admins = Load.Data
end)

function manageData(action,key,value)
	local data = pdb:Load(key)
	data:wait()
	if action == "get" then
		return data
	elseif action == "post" then
		local waitforactiontocomplete = data:Save(key,value)
		waitforactiontocomplete:wait()
		return waitforactiontocomplete.Complete
	end
end

function loadPlugin(name)
	local loadedplug = require(script["Add-Ons"][name])
	if loadedplug.pType == "Theme" then
		Themes[#Themes+1] = loadedplug
	elseif loadedplug.pType == "Command" then
		CustomCommands[#CustomCommands+1] = loadedplug
	elseif loadedplug.pType == "Addon" then
		Extras[#Extras+1] = loadedplug
	end
end

function toR6(plr)
	local newRig = script.PlayerModels.r6:Clone()
	local newHumanoid = newRig.Humanoid
	local originalCFrame = plr.Character.Head.CFrame
	newRig.Name = plr.Name
	for a,b in pairs(plr.Character:GetChildren()) do
		if b:IsA("Accessory") or b:IsA("Pants") or b:IsA("Shirt") or b:IsA("ShirtGraphic") or b:IsA("BodyColors") then
			b.Parent = newRig
		elseif b.Name == "Head" and b:FindFirstChild("face") then
			newRig.Head.face.Texture = b.face.Texture
		end
	end
	plr.Character = newRig
	newRig.Parent = workspace
	newRig.Head.CFrame = originalCFrame
end

function toR15(plr)
	local newRig = script.PlayerModels.r15:Clone()
	local newHumanoid = newRig.Humanoid
	local originalCFrame = plr.Character.Head.CFrame
	newRig.Name = plr.Name
	for a,b in pairs(plr.Character:GetChildren()) do
		if b:IsA("Accessory") or b:IsA("Pants") or b:IsA("Shirt") or b:IsA("ShirtGraphic") or b:IsA("BodyColors") then
			b.Parent = newRig
		elseif b.Name == "Head" and b:FindFirstChild("face") then
			newRig.Head.face.Texture = b.face.Texture
		end
	end
	plr.Character = newRig
	newRig.Parent = workspace
	newRig.Head.CFrame = originalCFrame
end

function Scale(humanoid,sizemultiplier) -- Make sure to check if the player is R15 BEFORE executing this function.
	if humanoid then
		humanoid.BodyDepthScale.Value = humanoid.BodyDepthScale.Value * sizemultiplier
		humanoid.BodyHeightScale.Value = humanoid.BodyHeightScale.Value * sizemultiplier
		humanoid.BodyWidthScale.Value = humanoid.BodyWidthScale.Value * sizemultiplier
		humanoid.HeadScale.Value = humanoid.HeadScale.Value * sizemultiplier
	else
		return
	end
end

function CheckforLibs(requiredlibs)
	local found = false
	local libs = {}
	local missinglibs = {}
	for _,a in pairs(requiredlibs) do
		found = false
		for _,v in pairs(Extras) do
			if v["pName"] == a then 
				found = true 
				libs[v["pName"]] = v.ScriptLoc
			end
		end
		if found == false then
			missinglibs[a] = a
		end
	end

	if found then return libs
	else return {false,missinglibs}
	end
end

function isOwner(plr)
	if game.CreatorType == Enum.CreatorType.User then
		if plr.UserId == game.CreatorId then
			return true
		else
			return false
		end
	elseif game.CreatorType == Enum.CreatorType.Group then
		local group = game:GetService("GroupService"):GetGroupInfoAsync(game.CreatorId)
		if plr.UserId == group.Owner.Id then
			return true
		else
			return false
		end
	end
end

function firePlugin(name,args)
	local firedplugin = {}
	local found = false
	for _,v in pairs(CustomCommands) do
		if v.pName == name then
			firedplugin = require(script["Add-Ons"][v.ScriptName])
			found = true
			break
		end
	end

	if found == false then
		return {false,"An error has occured searching for the add-on.."}
	end

	local action = firedplugin:Fired(args)
	return action
end

function isHttpEnabled()
	local s = pcall(function()
		game:GetService('HttpService'):GetAsync('http://www.google.com/')
	end)
	return s
end


function GetLevel(player)
	if Admins == nil or not Admins then Admins = module.Admins end
	local group = module.GroupAdmin
	if game.CreatorType == Enum.CreatorType.User then
		if player.UserId == game.CreatorId then
			return 5
		end
	elseif game.CreatorType == Enum.CreatorType.Group then
		local group = game:GetService("GroupService"):GetGroupInfoAsync(game.CreatorId)
		if player.UserId == group.Owner.Id then
			return 5
		end
	end
	for _,b in pairs(Admins.RootAdmins) do
		if player.UserId == b then
			return 5
		end
	end
	for _,b in pairs(Admins.SuperAdmins) do
		if group.Enabled == true then
			if player:GetRankInGroup(group.GroupId) >= group.SuperAdminRank then
				return 4
			end
		end
		if player.UserId == b then
			return 4
		end
	end
	for _,b in pairs(Admins.Admins) do
		if group.Enabled == true then
			if player:GetRankInGroup(group.GroupId) >= group.AdminRank then
				return 3
			end
		end
		if player.UserId == b then
			return 3
		end
	end
	for _,b in pairs(Admins.Moderators) do
		if group.Enabled == true then
			if player:GetRankInGroup(group.GroupId) >= group.ModeratorRank then
				return 2
			end
		end
		if player.UserId == b then
			return 2
		end
	end
	for _,b in pairs(Admins.VIP) do
		if group.Enabled == true then
			if player:GetRankInGroup(group.GroupId) >= group.VIPRank then
				return 1
			end
		end
		if player.UserId == b then
			return 1
		end
	end
	for _,b in pairs(Admins.Bans) do
		if player.UserId == b then
			return -1
		end
	end
	for _,b in pairs(Admins.BanLand) do
		if group.Enabled == true then
			if player:GetRankInGroup(group.GroupId) == group.BanLandRank then
				return -99
			end
		end
		if player.UserId == b[1] then
			return -99
		end
	end
	if module.VIPAdmin.Enabled == true then
		if game:GetService("MarketplaceService"):UserOwnsGamePassAsync(player.UserId,module.VIPAdmin.GamepassId) == true then
			return module.VIPAdmin.GiveLevel
		end
	end

	if module.VIPAllowed == true then
		if game:GetService("MarketplaceService"):UserOwnsGamePassAsync(player.UserId,8197340) == true then
			return 1
		end
	end

	return 0
end

function module:GetLevel(player)
	if Admins == nil or not Admins then Admins = module.Admins end
	if sandboxmode == true then
		return 5
	end
	for _,a in pairs(Admins) do
		for _,b in pairs(Admins.RootAdmins) do
			local owner = false
			if game.CreatorType == Enum.CreatorType.User then
				if player.UserId == game.CreatorId then
					return 5
				end
			elseif game.CreatorType == Enum.CreatorType.Group then
				local group = game:GetService("GroupService"):GetGroupInfoAsync(game.CreatorId)
				if player.UserId == group.Owner.Id then
					return 5
				end
			end
			if player.UserId == b or owner then
				return 5
			end
		end
		for _,b in pairs(Admins.SuperAdmins) do
			if module.GroupAdmin.Enabled == true then
				if player:GetRankInGroup(module.GroupAdmin.GroupId) >= module.GroupAdmin.SuperAdminRank then
					return 4
				end
			end
			if player.UserId == b then
				return 4
			end
		end
		for _,b in pairs(Admins.Admins) do
			if module.GroupAdmin.Enabled == true then
				if player:GetRankInGroup(module.GroupAdmin.GroupId) >= module.GroupAdmin.AdminRank then
					return 3
				end
			end
			if player.UserId == b then
				return 3
			end
		end
		for _,b in pairs(Admins.Moderators) do
			if module.GroupAdmin.Enabled == true then
				if player:GetRankInGroup(module.GroupAdmin.GroupId) >= module.GroupAdmin.ModeratorRank then
					return 2
				end
			end
			if player.UserId == b then
				return 2
			end
		end
		for _,b in pairs(Admins.VIP) do
			if module.GroupAdmin.Enabled == true then
				if player:GetRankInGroup(module.GroupAdmin.GroupId) >= module.GroupAdmin.VIPRank then
					return 1
				end
			end
			if player.UserId == b then
				return 1
			end
		end
		for _,b in pairs(Admins.Bans) do
			if player.UserId == b then
				return -1
			end
		end
		for _,b in pairs(Admins.BanLand) do
			if module.GroupAdmin.Enabled == true then
				if player:GetRankInGroup(module.GroupAdmin.GroupId) == module.GroupAdmin.BanLandRank then
					return -99
				end
			end
			if player.UserId == b[1] then
				return -99
			end
		end

		if module.VIPAdmin.Enabled == true then
			if game:GetService("MarketplaceService"):UserOwnsGamePassAsync(player.UserId,module.VIPAdmin.GamepassId) == true then
				return module.VIPAdmin.GiveLevel
			end
		end

		if module.VIPAllowed == true then
			if game:GetService("MarketplaceService"):UserOwnsGamePassAsync(player.UserId,8197340) == true then
				return 1
			end
		end

		return 0
	end
end

local function LoadScript(plr,Source)
	local Func,Err = loader(plr.Name,Source,getfenv())
	if Func then
		Func()
		return true
	else
		return Err
	end
end

local function isType(Id,Type)
	if tonumber(Id) then
		local set
		local succ,err = pcall(function()
			set = game:GetService("MarketplaceService"):GetProductInfo(tonumber(Id))
		end)
		if succ then
			if set.AssetTypeId == Type then
				return true
			end
		else
			warn("Error getting asset: "..err)
			return false
		end
	end
	return false
end

function Notify(player,ntype,nmessage)
	local currenttheme = {}
	local themefound = false
	local folder = notificationsfolder

	for _,v in pairs(Themes) do
		if v.pName == module.Theme then
			currenttheme = v
			themefound = true
			break
		end
	end

	if themefound == false then
		warn("[R:A] Theme not found! Using Default (Dark).")
		currenttheme = {
			["BackgroundColor"] = Color3.new(0,0,0),
			["TextColor"] = Color3.new(1,1,1),
			["Highlight"] = {Color3.fromRGB(0,255,170),extracolors:GetColor("white")},
			["Logo"] = extracolors:GetColor("white"),
			["SideColor"] = extracolors:GetColor("black"),
			done = {
				["Color"] = extracolors:GetColor("black"),
				["Image"] = {4146192662,extracolors:GetColor("litegreen")}
			},
			err = {
				["Color"] = extracolors:GetColor("black"),
				["Image"] = {4146192101,extracolors:GetColor("litered")}
			},
			notif = {
				["Color"] = extracolors:GetColor("black"),
				["Exclamation"] = extracolors:GetColor("orange")
			},
			welcome = {
				["Color"] = extracolors:GetColor("royalturq"),
				["Icon"] = extracolors:GetColor("black")
			},
			cmd = {
				["Color"] = extracolors:GetColor("black"),
				["Icon"] = extracolors:GetColor("green")
			}
		}
	end

	if currenttheme.Version then
		script.CommandBar.FullFrame.Side["Studio Engi Icon"].TextColor3 = currenttheme.Theme.cmd["Icon"]
		script.CommandBar.FullFrame.Side.ImageColor3 = currenttheme.Theme.cmd["Color"]
	else
		script.CommandBar.FullFrame.Side["Studio Engi Icon"].TextColor3 = currenttheme.Theme.welcome["Icon"]
		script.CommandBar.FullFrame.Side.ImageColor3 = currenttheme.Theme.welcome["Color"]
	end
	script.CommandBar.FullFrame.Prefix.Text = module.Prefix
	script.CommandBar.FullFrame.Prefix.TextColor3 = currenttheme.Theme["TextColor"]
	script.CommandBar.FullFrame.ImageColor3 = currenttheme.Theme["BackgroundColor"]
	script.CommandBar.FullFrame.Command.TextColor3 = currenttheme.Theme["TextColor"]

	if ntype == "welcome" then
		local new = player.PlayerGui.MainUI.Main.NotificationButton:Clone()
		if module.HideMain == false then
			new.Parent = player.PlayerGui.MainUI.Main
			local pos = 1
			local foundpos = false
			local whichposfound = 0
			repeat 
				for _,v in pairs(player.PlayerGui.MainUI.Main:GetChildren()) do
					if v.Name == "NotificationButton" and v.posnum.Value ~= 0 then
						if v.posnum.Value == pos then
							foundpos = true
						end
					end
				end
				if foundpos == true then
					pos = pos+1
					foundpos = false
				elseif foundpos == false then
					whichposfound = pos
				end
			until foundpos == false and whichposfound ~= 0
			new.posnum.Value = pos
			new.Position = UDim2.new(0, -111,0, (-54 - 45 * (pos-1)))
		elseif module.HideMain == true then
			new.Parent = player.PlayerGui.MainUI
			new.AnchorPoint = Vector2.new(1,1)
			local pos = 1
			local foundpos = false
			local whichposfound = 0
			repeat 
				for _,v in pairs(player.PlayerGui.MainUI:GetChildren()) do
					if v.Name == "NotificationButton" and v.posnum.Value ~= 0 then
						if v.posnum.Value == pos then
							foundpos = true
						end
					end
				end
				if foundpos == true then
					pos = pos+1
					foundpos = false
				elseif foundpos == false then
					whichposfound = pos
				end
			until foundpos == false and whichposfound ~= 0
			new.posnum.Value = pos
			new.Position = UDim2.new(1, -10, 1, (-15 - (45 * (pos-1))))
		end
		new.Text = nmessage
		new.TextColor3 = Color3.new(0,0.666667,1)
		new.Visible = true
		new.Sound:Play()
		new.MouseButton1Click:Connect(function()
			new.Click:Play()
			new.Visible = false
			wait(0.3)
			new:Destroy()
		end)
		new.Timer:TweenSize(UDim2.new(0,0,0,2),Enum.EasingDirection.InOut,Enum.EasingStyle.Linear,math.max(10,(#nmessage/75)),true,function()
			new.Visible = false
			new:Destroy()
		end)
	elseif ntype == "done" then
		local new = player.PlayerGui.MainUI.Main.NotificationButton:Clone()
		if module.HideMain == false then
			new.Parent = player.PlayerGui.MainUI.Main
			local pos = 1
			local foundpos = false
			local whichposfound = 0
			repeat 
				for _,v in pairs(player.PlayerGui.MainUI.Main:GetChildren()) do
					if v.Name == "NotificationButton" and v.posnum.Value ~= 0 then
						if v.posnum.Value == pos then
							foundpos = true
						end
					end
				end
				if foundpos == true then
					pos = pos+1
					foundpos = false
				elseif foundpos == false then
					whichposfound = pos
				end
			until foundpos == false and whichposfound ~= 0
			new.posnum.Value = pos
			new.Position = UDim2.new(0, -111,0, (-54 - 45 * (pos-1)))
		elseif module.HideMain == true then
			new.Parent = player.PlayerGui.MainUI
			new.AnchorPoint = Vector2.new(1,1)
			local pos = 1
			local foundpos = false
			local whichposfound = 0
			repeat 
				for _,v in pairs(player.PlayerGui.MainUI:GetChildren()) do
					if v.Name == "NotificationButton" and v.posnum.Value ~= 0 then
						if v.posnum.Value == pos then
							foundpos = true
						end
					end
				end
				if foundpos == true then
					pos = pos+1
					foundpos = false
				elseif foundpos == false then
					whichposfound = pos
				end
			until foundpos == false and whichposfound ~= 0
			new.posnum.Value = pos
			new.Position = UDim2.new(1, -10, 1, (-15 - (45 * (pos-1))))
		end
		new.Text = nmessage
		new.TextColor3 = Color3.new(0.666667, 1, 0.498039)
		new.Visible = true
		new.Sound:Play()
		new.MouseButton1Click:Connect(function()
			new.Click:Play()
			new.Visible = false
			wait(0.3)
			new:Destroy()
		end)
		new.Timer:TweenSize(UDim2.new(0,0,0,2),Enum.EasingDirection.InOut,Enum.EasingStyle.Linear,math.max(3,(#nmessage/70)),true,function()
			new.Visible = false
			new:Destroy()
		end)
	elseif ntype == "error" then
		local new = player.PlayerGui.MainUI.Main.NotificationButton:Clone()
		if module.HideMain == false then
			new.Parent = player.PlayerGui.MainUI.Main
			local pos = 1
			local foundpos = false
			local whichposfound = 0
			repeat 
				for _,v in pairs(player.PlayerGui.MainUI.Main:GetChildren()) do
					if v.Name == "NotificationButton" and v.posnum.Value ~= 0 then
						if v.posnum.Value == pos then
							foundpos = true
						end
					end
				end
				if foundpos == true then
					pos = pos+1
					foundpos = false
				elseif foundpos == false then
					whichposfound = pos
				end
			until foundpos == false and whichposfound ~= 0
			new.posnum.Value = pos
			new.Position = UDim2.new(0, -111,0, (-54 - 45 * (pos-1)))
		elseif module.HideMain == true then
			new.Parent = player.PlayerGui.MainUI
			new.AnchorPoint = Vector2.new(1,1)
			local pos = 1
			local foundpos = false
			local whichposfound = 0
			repeat 
				for _,v in pairs(player.PlayerGui.MainUI:GetChildren()) do
					if v.Name == "NotificationButton" and v.posnum.Value ~= 0 then
						if v.posnum.Value == pos then
							foundpos = true
						end
					end
				end
				if foundpos == true then
					pos = pos+1
					foundpos = false
				elseif foundpos == false then
					whichposfound = pos
				end
			until foundpos == false and whichposfound ~= 0
			new.posnum.Value = pos
			new.Position = UDim2.new(1, -10, 1, (-15 - (45 * (pos-1))))
		end
		new.Text = nmessage
		new.TextColor3 = Color3.new(1,0.666667,0)
		new.Visible = true
		new.Error:Play()
		new.MouseButton1Click:Connect(function()
			new.Click:Play()
			new.Visible = false
			wait(0.3)
			new:Destroy()
		end)
		new.Timer:TweenSize(UDim2.new(0,0,0,2),Enum.EasingDirection.InOut,Enum.EasingStyle.Linear,math.max(5,(#nmessage/75)),true,function()
			new.Visible = false
			new:Destroy()
		end)
	elseif ntype == "critical" then -- Added in 03. Made for errors in the custom commands.
		local new = player.PlayerGui.MainUI.Main.NotificationButton:Clone()
		if module.HideMain == false then
			new.Parent = player.PlayerGui.MainUI.Main
			local pos = 1
			local foundpos = false
			local whichposfound = 0
			repeat 
				for _,v in pairs(player.PlayerGui.MainUI.Main:GetChildren()) do
					if v.Name == "NotificationButton" and v.posnum.Value ~= 0 then
						if v.posnum.Value == pos then
							foundpos = true
						end
					end
				end
				if foundpos == true then
					pos = pos+1
					foundpos = false
				elseif foundpos == false then
					whichposfound = pos
				end
			until foundpos == false and whichposfound ~= 0
			new.posnum.Value = pos
			new.Position = UDim2.new(0, -111,0, (-54 - 45 * (pos-1)))
		elseif module.HideMain == true then
			new.Parent = player.PlayerGui.MainUI
			new.AnchorPoint = Vector2.new(1,1)
			local pos = 1
			local foundpos = false
			local whichposfound = 0
			repeat 
				for _,v in pairs(player.PlayerGui.MainUI:GetChildren()) do
					if v.Name == "NotificationButton" and v.posnum.Value ~= 0 then
						if v.posnum.Value == pos then
							foundpos = true
						end
					end
				end
				if foundpos == true then
					pos = pos+1
					foundpos = false
				elseif foundpos == false then
					whichposfound = pos
				end
			until foundpos == false and whichposfound ~= 0
			new.posnum.Value = pos
			new.Position = UDim2.new(1, -10, 1, (-15 - (45 * (pos-1))))
		end
		new.Text = nmessage
		new.TextColor3 = Color3.new(1, 1, 1)
		new.BackgroundColor3 = Color3.new(1,0.345098,0.345098)
		new.Visible = true
		new.Critical:Play()
		new.MouseButton1Click:Connect(function()
			new.Click:Play()
			new.Visible = false
			wait(0.3)
			new:Destroy()
		end)
		new.Timer:TweenSize(UDim2.new(0,0,0,2),Enum.EasingDirection.InOut,Enum.EasingStyle.Linear,math.max(60,(#nmessage/30)),true,function()
			new.Visible = false
			new:Destroy()
		end)
	elseif ntype == "notification" then
		local new = player.PlayerGui.MainUI.Main.NotificationButton:Clone()
		if module.HideMain == false then
			new.Parent = player.PlayerGui.MainUI.Main
			local pos = 1
			local foundpos = false
			local whichposfound = 0
			repeat 
				for _,v in pairs(player.PlayerGui.MainUI.Main:GetChildren()) do
					if v.Name == "NotificationButton" and v.posnum.Value ~= 0 then
						if v.posnum.Value == pos then
							foundpos = true
						end
					end
				end
				if foundpos == true then
					pos = pos+1
					foundpos = false
				elseif foundpos == false then
					whichposfound = pos
				end
			until foundpos == false and whichposfound ~= 0
			new.posnum.Value = pos
			new.Position = UDim2.new(0, -111,0, (-54 - 45 * (pos-1)))
		elseif module.HideMain == true then
			new.Parent = player.PlayerGui.MainUI
			new.AnchorPoint = Vector2.new(1,1)
			local pos = 1
			local foundpos = false
			local whichposfound = 0
			repeat 
				for _,v in pairs(player.PlayerGui.MainUI:GetChildren()) do
					if v.Name == "NotificationButton" and v.posnum.Value ~= 0 then
						if v.posnum.Value == pos then
							foundpos = true
						end
					end
				end
				if foundpos == true then
					pos = pos+1
					foundpos = false
				elseif foundpos == false then
					whichposfound = pos
				end
			until foundpos == false and whichposfound ~= 0
			new.posnum.Value = pos
			new.Position = UDim2.new(1, -10, 1, (-15 - (45 * (pos-1))))
		end
		new.Text = nmessage
		new.TextColor3 = Color3.new(1, 1, 1)
		new.Visible = true
		new.Notification:Play()
		new.MouseButton1Click:Connect(function()
			new.Click:Play()
			new.Visible = false
			wait(1)
			new:Destroy()
		end)
		new.Timer:TweenSize(UDim2.new(0,0,0,2),Enum.EasingDirection.InOut,Enum.EasingStyle.Linear,math.max(10,(#nmessage/30)),true,function()
			new.Visible = false
			wait(1)
			new:Destroy()
		end)
	elseif ntype == "newmsg" then
		local new = script.NewMessage:Clone()
		new.MainFrame.BackgroundColor3 = currenttheme.Theme["BackgroundColor"]
		new.MainFrame.Message.Text = nmessage[2]
		new.MainFrame.Header.Text = nmessage[1]
		new.MainFrame.Message.TextColor3 = currenttheme.Theme["TextColor"]
		new.MainFrame.Header.TextColor3 = currenttheme.Theme["Logo"]
		new.MainFrame.Header.Timer.TextColor3 = currenttheme.Theme["Logo"]
		new.MainFrame.Header.BackgroundColor3 = currenttheme.Theme["SideColor"]
		if player.PlayerGui:FindFirstChild("NewMessage") then
			player.PlayerGui:FindFirstChild("NewMessage"):Destroy()
		end
		new.Parent = player.PlayerGui
		new.MainFrame:TweenPosition(UDim2.new(0.5,0,0.5,0),Enum.EasingDirection.InOut,Enum.EasingStyle.Quint,0.5,true)
		new.MainFrame.Close.LocalScript.Disabled = false
		new.Notification:Play()
	elseif ntype == "message" then
		local active = player.PlayerGui:FindFirstChild("FullScreenNotification")
		if active then
			active:Destroy()
		end
		local new = script.FullScreenNotification:Clone()
		new.Frame.BackgroundColor3 = currenttheme.Theme["BackgroundColor"]
		new.LocalScript.Disabled = false
		new.Frame.Message.Text = nmessage[2]
		new.Frame.Message.TextColor3 = currenttheme.Theme["TextColor"]
		new.Frame.Title.Text = nmessage[1]
		new.Frame.Title.TextColor3 = currenttheme.Theme["TextColor"]
		new.Parent = player.PlayerGui
	elseif ntype == "cmds" then
		local clone = player.PlayerGui.MainUI.ListUI:Clone()
		local pos = 0
		local commands = {}
		for i,v in pairs(nmessage) do -- Table sorter by Cytronyx.
			table.insert(commands, v)
			table.sort(commands, function(a,b) return a[1] < b[1] end)
		end
		clone.Parent = player.PlayerGui.MainUI
		clone.Title.Text = "Commands List"
		clone.Visible = true
		-- Load the commands after displaying the clone.
		-- This is a bit better performance-vice, as it (the command thing) will already be visible and the commands
		-- will look as if they are loading inside, when in reality, they are already loaded, like in Basic.
		for i,v in pairs(commands) do
			pos = pos+1
			local bar = clone.ScrollingFrame.command:Clone()
			bar.Parent = clone.ScrollingFrame
			bar.Text = v[1].." | "..v[2]
			if tonumber(v[1]) <= GetLevel(player) then
				bar.TextColor3 = Color3.fromRGB(255,255,255)
			else
				bar.TextColor3 = Color3.fromRGB(155,155,155)
			end
			local newpos = pos*28
			bar.Position = UDim2.new(UDim.new(0.03,0),UDim.new(0,newpos))
			clone.ScrollingFrame.CanvasSize = UDim2.new(UDim.new(0,0),UDim.new(0,newpos))
		end
	elseif ntype == "debuglogs" then
		local clone = player.PlayerGui.MainUI.ListUI:Clone()
		local pos = 0
		local gameSecretVisible = false
		if isOwner(player) then
			gameSecretVisible = true
		else
			gameSecretVisible = false
		end
		local stuff = {
			["Time to load"] = totalloadtime,
			["Total players handled"] = tostring(#usersfolder:GetChildren()),
			["Build ID"] = module.BuildId,
			["Build Version"] = module.BuildVer,
			["Loader Version"] = module.MadeforBuild,
			["Internal Build ID"] = internalbuildid,
		}
		if gameSecretVisible == true then
			stuff["Game Secret (Do not share it!)"] = gameSecret
		end
		for k,v in pairs(stuff) do
			pos = pos+1
			local bar = clone.ScrollingFrame.command:Clone()
			bar.Parent = clone.ScrollingFrame
			bar.Text = k..": "..v
			bar.TextColor3 = Color3.fromRGB(255,255,255)
			local newpos = pos*28
			bar.Position = UDim2.new(UDim.new(0.03,0),UDim.new(0,newpos))
			clone.ScrollingFrame.CanvasSize = UDim2.new(UDim.new(0,0),UDim.new(0,newpos))
		end
		clone.Parent = player.PlayerGui.MainUI
		clone.Title.Text = "INTERNAL USE ONLY"
		clone.Visible = true
	elseif ntype == "customlist" then
		local clone = player.PlayerGui.MainUI.ListUI:Clone()
		local pos = 0
		local stuff = {}
		for k,v in pairs(nmessage[2]) do
			stuff[k] = v
		end
		clone.Parent = player.PlayerGui.MainUI
		clone.Title.Text = nmessage[1]
		clone.Visible = true
		for k,v in pairs(stuff) do
			pos = pos+1
			local bar = clone.ScrollingFrame.command:Clone()
			bar.Parent = clone.ScrollingFrame
			bar.Text = k..": "..v
			bar.TextColor3 = Color3.fromRGB(255,255,255)
			local newpos = pos*28
			bar.Position = UDim2.new(UDim.new(0.03,0),UDim.new(0,newpos))
			clone.ScrollingFrame.CanvasSize = UDim2.new(UDim.new(0,0),UDim.new(0,newpos))
		end
	elseif ntype == "chatlogs" then
		local clone = player.PlayerGui.MainUI.ListUI:Clone()
		local pos = 0
		clone.ScrollingFrame.command.Visible = false
		local newt={}
		for i = 1, math.floor(#chatlogs/2) do
			local j = #chatlogs - i + 1
			newt[i], newt[j] = chatlogs[j], chatlogs[i]
		end
		clone.Parent = player.PlayerGui.MainUI
		clone.Title.Text = "Chatlogs"
		clone.Visible = true
		for i,v in pairs(newt) do
			pos = pos+1
			local bar = clone.ScrollingFrame.command:Clone()
			bar.Parent = clone.ScrollingFrame
			bar.Text = v
			bar.BackgroundTransparency = 1
			bar.Visible = true
			bar.Position = UDim2.new(0.03,0,0,(pos-1)*28)
			clone.ScrollingFrame.CanvasSize = UDim2.new(0,0,0,(pos-1)*28)
		end
	elseif ntype == "lpids" then
		local clone = player.PlayerGui.MainUI.ListUI:Clone()
		local pos = -1
		clone.ScrollingFrame.command.Visible = false
		clone.Parent = player.PlayerGui.MainUI
		clone.Title.Text = "Local User IDs"
		clone.Visible = true
		for i,v in pairs(usersfolder:GetChildren()) do
			pos = pos+1
			local bar = clone.ScrollingFrame.command:Clone()
			bar.Parent = clone.ScrollingFrame
			bar.Text = v.Value
			bar.Visible = true
			if game.Players:FindFirstChild(v.Name) then
				bar.TextColor3 = Color3.fromRGB(255, 255, 255)
			else
				bar.TextColor3 = Color3.fromRGB(155, 155, 155)
			end
			local newpos = pos*28
			bar.Position = UDim2.new(UDim.new(0.03,0),UDim.new(0,newpos))
			clone.ScrollingFrame.CanvasSize = UDim2.new(UDim.new(0,0),UDim.new(0,newpos))
		end
	elseif ntype == "settings" then
		local clone = player.PlayerGui.MainUI.Settings:Clone()
		clone.Parent = player.PlayerGui.MainUI
		clone.Visible = true
	elseif ntype == "onlineadmins" then
		local clone = player.PlayerGui.MainUI.ListUI:Clone()
		local pos = -1
		clone.ScrollingFrame.command.Visible = false
		clone.Parent = player.PlayerGui.MainUI
		clone.Title.Text = "Staff Online"
		clone.Visible = true
		for i,v in pairs(game.Players:GetPlayers()) do
			if GetLevel(v) >= 2 then
				pos = pos+1
				local bar = clone.ScrollingFrame.command:Clone()
				bar.Parent = clone.ScrollingFrame
				if GetLevel(v) == 2 then
					bar.Text = "Moderator | "..v.Name
				elseif GetLevel(v) == 3 then
					bar.Text = "Admin | "..v.Name
				elseif GetLevel(v) == 4 then
					bar.Text = "Super Admin | "..v.Name
				elseif GetLevel(v) == 5 then
					bar.Text = "Root | "..v.Name
				end
				bar.Visible = true
				bar.TextColor3 = Color3.fromRGB(255, 255, 255)
				local newpos = pos*28
				bar.Position = UDim2.new(UDim.new(0.03,0),UDim.new(0,newpos))
				clone.ScrollingFrame.CanvasSize = UDim2.new(UDim.new(0,0),UDim.new(0,newpos))
			end
		end
	end
end

function SaveAdmins(list)
	local update = db:Save("AdminList",list)
	update:wait()
	return update.Attempts
end

chatlogs = {}

function Player(Name)
	for i,v in next,game:GetService("Players"):GetPlayers() do
		local s1 = string.lower(v.Name)
		if s1:sub(1, #Name) == string.lower(Name) then
			return v
		end
	end
end

function splitstring(s, sep)
	local fields = {}

	local sep = sep or " "
	local pattern = string.format("([^%s]+)", sep)
	string.gsub(s, pattern, function(c) fields[#fields + 1] = c end)

	return fields
end

function joinstring(s, sep)
	return table.concat(s, sep)
end

function module:GetPrefix()
	return module.Prefix
end

function module:HandlePlayers(p, plrs, level, ismessg)
	if plrs == "" or plrs == " " or plrs == nil then
		return Player(p)
	end

	local newplrs = splitstring(plrs,",")
	local players = {}
	local executor = p
	local ismsg = ismessg or false

	if GetLevel(Player(executor)) == 5 then
		level = 0 -- If the executor is Root, then ignore level.
	end

	if level == -1 then
		ismsg = true
		level = 0
	end

	for _,v in pairs(newplrs) do
		if v == "@me" then
			players[#players+1] = Player(executor)
		--[[elseif v == "@server" or v=="@@" or v=="#0" then
			if GetLevel(executor) ~= 5 then
				return {false,"You cannot target the server. ("..v..")"}
			end
			if not ismsg then
				return {false,"You cannot target the server for non-sudo purposes. ("..v..")"}
			elseif ismsg == true then
				
			end]]
		elseif v == "@others" and level < 2 then
			for _,k in pairs(game.Players:GetPlayers()) do
				if k.Name ~= executor then
					if GetLevel(Player(executor)) >= GetLevel(k) or ismsg then
						players[#players+1] = k	
					end
				end
			end
		elseif v == "@all" and level < 1 then
			for _,k in pairs(game.Players:GetPlayers()) do
				if GetLevel(Player(executor)) >= GetLevel(k) or ismsg then
					players[#players+1] = k	
				end
			end
		elseif string.sub(v,1,1) == "#" then
			for _,k in pairs(usersfolder:GetChildren()) do
				local nv = splitstring(k.Value," ")
				if nv[1] == v then
					local a = Player(nv[3])
					if GetLevel(Player(executor)) >= GetLevel(a) or ismsg then
						if a then
							players[#players+1] = a
						end
					end
				end
			end
		elseif v == "@root" and level < 3 then --// New alternatives start
			if GetLevel(Player(executor)) ~= 5 then
				return {false,"You cannot target this group. (@root)"}
			end
			for _,k in pairs(game.Players:GetPlayers()) do
				if GetLevel(k) == 5 then
					players[#players+1] = k	
				end
			end
		elseif v == "@super" and level < 3 then
			if GetLevel(Player(executor)) ~= 5 then
				return {false,"You cannot target this group. (@super)"}
			end
			for _,k in pairs(game.Players:GetPlayers()) do
				if GetLevel(k) >= 4 then
					players[#players+1] = k	
				end
			end
		elseif v == "@admin" and level < 3 then
			if GetLevel(Player(executor)) < 4 then
				return {false,"You cannot target this group. (@admin)"}
			end
			for _,k in pairs(game.Players:GetPlayers()) do
				if GetLevel(k) >= 3 then
					players[#players+1] = k	
				end
			end
		elseif v == "@mod" or v == "@admins" and level < 3 then
			if GetLevel(Player(executor)) < 3 then
				return {false,"You cannot target this group. (@mod)"}
			end
			for _,k in pairs(game.Players:GetPlayers()) do
				if GetLevel(k) >= 2 then
					players[#players+1] = k	
				end
			end
		elseif v == "@vip" and level < 3 then
			if GetLevel(Player(executor)) < 2 then
				return {false,"You cannot target this group. (@vip)"}
			end
			for _,k in pairs(game.Players:GetPlayers()) do
				if GetLevel(k) >= 1 then
					players[#players+1] = k	
				end
			end
		elseif v == "@noadmin" and level < 3 then
			if GetLevel(Player(executor)) < 2 then
				return {false,"You cannot target this group. (@noadmin)"}
			end
			for _,k in pairs(game.Players:GetPlayers()) do
				if GetLevel(k) <= 0 then
					players[#players+1] = k	
				end
			end
		elseif v == "@n/a" then
			return {false,"No."}
		elseif v == "@alive" and level < 3 then
			for _,k in pairs(game.Players:GetPlayers()) do
				if GetLevel(k) <= GetLevel(Player(executor)) or ismsg then
					if k.Character.Humanoid then
						if k.Character.Humanoid.Health > 0 then
							players[#players+1] = k
						end	
					end	
				end
			end
		elseif v == "@dead" and level < 3 then
			for _,k in pairs(game.Players:GetPlayers()) do
				if GetLevel(k) <= GetLevel(Player(executor)) or ismsg then
					if k.Character.Humanoid then
						if k.Character.Humanoid.Health <= 0 then
							players[#players+1] = k
						end	
					end	
				end
			end
		elseif v == "@non" and level < 3 then
			for _,k in pairs(game.Players:GetPlayers()) do
				if GetLevel(k) <= GetLevel(Player(executor)) or ismsg then
					if GetLevel(Player(executor)) < 2 then
						return {false,"You cannot target this group. (@non)"}
					end
					for _,k in pairs(game.Players:GetPlayers()) do
						if GetLevel(k) <= 1 then
							players[#players+1] = k	
						end
					end
				end
			end
		else
			local k = Player(v)
			if k then
				if GetLevel(k) <= GetLevel(Player(executor)) or ismsg then
					players[#players+1] = k
				end
			end
		end
	end

	return players
end

function addChatlog(plr,chat)
	chatlogs[#chatlogs+1] = "["..plr.Name.."]: "..chat
end

function cmds(plr,command)
	local arg = splitstring(command," ")
	local commands = {}
	local buildreason = nil -- Resets the reason every execution of command. (00E)

	commands[#commands+1] = {2,module.Prefix.."kill [Players]"}
	if arg[1] == module.Prefix.."kill" then
		if GetLevel(plr) < 2 then
			return {false,"You do not have permission to execute this command."}
		end

		local targets = module:HandlePlayers(plr.Name,arg[2],2,false)
		if targets[1] == nil then
			return {false, "Failed to find anyone of the mentioned players."}
		elseif targets[1] == false then
			return {false, targets[2]}
		end
		local done = {0,""}
		for _,v in pairs(targets) do
			v.Character.Humanoid.Health = 0
			if done[2] ~= "" then
				done[2] = done[2]..", "..v.Name
				done[1] = done[1]+1
			else
				done[2] = v.Name
				done[1] = 1
			end
		end
		if done[1] >= 5 then
			return {true,"Successfully killed "..done[1].." people."}
		else
			return {true,"Successfully killed "..done[2].."."}
		end
	end

	commands[#commands+1] = {2,module.Prefix.."respawn [Players]"}
	if arg[1] == module.Prefix.."respawn" then
		if GetLevel(plr) < 2 then
			return {false,"You do not have permission to execute this command."}
		end

		local targets = module:HandlePlayers(plr.Name,arg[2],2,false)
		if targets[1] == nil then
			return {false, "Failed to find anyone of the mentioned players."}
		elseif targets[1] == false then
			return {false, targets[2]}
		end
		local done = {0,""}
		for _,v in pairs(targets) do
			v:LoadCharacter()
			if done[2] ~= "" then
				done[2] = done[2]..", "..v.Name
				done[1] = done[1]+1
			else
				done[2] = v.Name
				done[1] = 1
			end
		end
		if done[1] >= 5 then
			return {true,"Successfully respawned "..done[1].." people."}
		else
			return {true,"Successfully respawned "..done[2].."."}
		end
	end

	commands[#commands+1] = {3,module.Prefix.."explode [Players]"}
	if arg[1] == module.Prefix.."explode" then
		if GetLevel(plr) < 3 then
			return {false,"You do not have permission to execute this command."}
		end

		local targets = module:HandlePlayers(plr.Name,arg[2],2,false)
		if targets[1] == nil then
			return {false, "Failed to find anyone of the mentioned players."}
		elseif targets[1] == false then
			return {false, targets[2]}
		end
		local done = {0,""}
		for _,v in pairs(targets) do
			local exp = Instance.new('Explosion')
			exp.Parent = v.Character:FindFirstChild("Head")
			exp.Visible = true
			if done[2] ~= "" then
				done[2] = done[2]..", "..v.Name
				done[1] = done[1]+1
			else
				done[2] = v.Name
				done[1] = 1
			end
		end
		if done[1] >= 5 then
			return {true,"Successfully exploded "..done[1].." people."}
		else
			return {true,"Successfully exploded "..done[2].."."}
		end
	end

	commands[#commands+1] = {3,module.Prefix.."resize [Players] [Scale]"}
	if arg[1] == module.Prefix.."resize" or arg[1] == module.Prefix.."scale" then
		if GetLevel(plr) < 3 then
			return {false,"You do not have permission to execute this command."}
		end
		if not arg[2] then
			return {false,"You must provide a target."}
		end
		if not arg[3] then
			return {false,"You must provide a scale."}
		end

		local targets = module:HandlePlayers(plr.Name,arg[2],2,false)
		if targets[1] == nil then
			return {false, "Failed to find anyone of the mentioned players."}
		elseif targets[1] == false then
			return {false, targets[2]}
		end
		local done = {0,""}
		for _,v in pairs(targets) do
			if v.Character.Humanoid then
				if v.Character.Humanoid.RigType == Enum.HumanoidRigType.R15 then
					Scale(v.Character.Humanoid,tonumber(arg[3]))
				elseif v.Character.Humanoid.RigType == Enum.HumanoidRigType.R6 then
					return {false,"This command does not support R6 yet."}
				end
			end
			if done[2] ~= "" then
				done[2] = done[2]..", "..v.Name
				done[1] = done[1]+1
			else
				done[2] = v.Name
				done[1] = 1
			end
		end
		if done[1] >= 5 then
			return {true,"Successfully resized "..done[1].." people."}
		else
			return {true,"Successfully resized "..done[2].."."}
		end
	end

	commands[#commands+1] = {3,module.Prefix.."tor6 [Players]"} -- Alias: !R6
	if arg[1] == module.Prefix.."tor6" or arg[1] == module.Prefix.."r6" then
		if GetLevel(plr) < 3 then
			return {false,"You do not have permission to execute this command."}
		end

		local targets = module:HandlePlayers(plr.Name,arg[2],2,false)
		if targets[1] == nil then
			return {false, "Failed to find anyone of the mentioned players."}
		elseif targets[1] == false then
			return {false, targets[2]}
		end
		local done = {0,""}
		for _,v in pairs(targets) do
			if v.Character.Humanoid then
				toR6(v)
			end
			if done[2] ~= "" then
				done[2] = done[2]..", "..v.Name
				done[1] = done[1]+1
			else
				done[2] = v.Name
				done[1] = 1
			end
		end
		if done[1] >= 5 then
			return {true,"Successfully turned "..done[1].." people into R6."}
		else
			return {true,"Successfully turned "..done[2].." into R6."}
		end
	end

	commands[#commands+1] = {3,module.Prefix.."tor15 [Players]"} -- Alias: !R15
	if arg[1] == module.Prefix.."tor15" or arg[1] == module.Prefix.."r15" then
		if GetLevel(plr) < 3 then
			return {false,"You do not have permission to execute this command."}
		end

		local targets = module:HandlePlayers(plr.Name,arg[2],2,false)
		if targets[1] == nil then
			return {false, "Failed to find anyone of the mentioned players."}
		elseif targets[1] == false then
			return {false, targets[2]}
		end
		local done = {0,""}
		for _,v in pairs(targets) do
			if v.Character.Humanoid then
				toR15(v)
			end
			if done[2] ~= "" then
				done[2] = done[2]..", "..v.Name
				done[1] = done[1]+1
			else
				done[2] = v.Name
				done[1] = 1
			end
		end
		if done[1] >= 5 then
			return {true,"Successfully turned "..done[1].." people into R15."}
		else
			return {true,"Successfully turned "..done[2].." into R15."}
		end
	end

	commands[#commands+1] = {2,module.Prefix.."jump [Players]"}
	if arg[1] == module.Prefix.."jump" then
		if GetLevel(plr) < 2 then
			return {false,"You do not have permission to execute this command."}
		end

		local targets = module:HandlePlayers(plr.Name,arg[2],2,false)
		if targets[1] == nil then
			return {false, "Failed to find anyone of the mentioned players."}
		elseif targets[1] == false then
			return {false, targets[2]}
		end
		local done = {0,""}
		for _,v in pairs(targets) do
			if v.Character.Humanoid then
				v.Character.Humanoid.Jump = true
			end
			if done[2] ~= "" then
				done[2] = done[2]..", "..v.Name
				done[1] = done[1]+1
			else
				done[2] = v.Name
				done[1] = 1
			end
		end
		if done[1] >= 5 then
			return {true,"Successfully made "..done[1].." people jump."}
		else
			return {true,"Successfully jumped "..done[2].."."}
		end
	end

	commands[#commands+1] = {2,module.Prefix.."sit [Players]"}
	if arg[1] == module.Prefix.."sit" then
		if GetLevel(plr) < 2 then
			return {false,"You do not have permission to execute this command."}
		end

		local targets = module:HandlePlayers(plr.Name,arg[2],2,false)
		if targets[1] == nil then
			return {false, "Failed to find anyone of the mentioned players."}
		elseif targets[1] == false then
			return {false, targets[2]}
		end
		local done = {0,""}
		for _,v in pairs(targets) do
			if v.Character.Humanoid then
				v.Character.Humanoid.Sit = true
			end
			if done[2] ~= "" then
				done[2] = done[2]..", "..v.Name
				done[1] = done[1]+1
			else
				done[2] = v.Name
				done[1] = 1
			end
		end
		if done[1] >= 5 then
			return {true,"Successfully made "..done[1].." people jump."}
		else
			return {true,"Successfully jumped "..done[2].."."}
		end
	end

	commands[#commands+1] = {0,module.Prefix.."ping"}
	if arg[1] == module.Prefix.."ping" then
		local startPing = tick()
		func:InvokeClient(plr,{"GetPing",startPing,os.time()})
		return "none"
	end

	commands[#commands+1] = {3,module.Prefix.."time <time / xx:xx:xx>"}
	if arg[1] == module.Prefix.."time" then
		if GetLevel(plr) < 3 then
			return {false,"You do not have permission to execute this command."}
		end

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

	commands[#commands+1] = {2,module.Prefix.."heal [Players]"}
	if arg[1] == module.Prefix.."heal" then
		if GetLevel(plr) < 2 then
			return {false,"You do not have permission to execute this command."}
		end

		local targets = module:HandlePlayers(plr.Name,arg[2],2,false)
		if targets[1] == nil then
			return {false, "Failed to find anyone of the mentioned players."}
		elseif targets[1] == false then
			return {false, targets[2]}
		end
		local done = {0,""}
		for _,v in pairs(targets) do
			v.Character.Humanoid.Health = v.Character.Humanoid.MaxHealth
			if done[2] ~= "" then
				done[2] = done[2]..", "..v.Name
				done[1] = done[1]+1
			else
				done[2] = v.Name
				done[1] = 1
			end
		end
		if done[1] >= 5 then
			return {true,"Successfully healed "..done[1].." people."}
		else
			return {true,"Successfully healed "..done[2].."."}
		end
	end

	commands[#commands+1] = {2,module.Prefix.."god [Players]"}
	if arg[1] == module.Prefix.."god" or arg[1] == module.Prefix.."godmode" then
		if GetLevel(plr) < 2 then
			return {false,"You do not have permission to execute this command."}
		end

		local targets = module:HandlePlayers(plr.Name,arg[2],2,false)
		if targets[1] == nil then
			return {false, "Failed to find anyone of the mentioned players."}
		elseif targets[1] == false then
			return {false, targets[2]}
		end
		local done = {0,""}
		for _,v in pairs(targets) do
			v.Character.Humanoid.MaxHealth = math.huge
			v.Character.Humanoid.Health = v.Character.Humanoid.MaxHealth
			if done[2] ~= "" then
				done[2] = done[2]..", "..v.Name
				done[1] = done[1]+1
			else
				done[2] = v.Name
				done[1] = 1
			end
		end
		if done[1] >= 5 then
			return {true,"Successfully made "..done[1].." people gods."}
		else
			return {true,"Successfully made "..done[2].." a god."}
		end
	end

	commands[#commands+1] = {2,module.Prefix.."ungod [Players]"}
	if arg[1] == module.Prefix.."ungod" or arg[1] == module.Prefix.."ungodmode" then
		if GetLevel(plr) < 2 then
			return {false,"You do not have permission to execute this command."}
		end

		local targets = module:HandlePlayers(plr.Name,arg[2],2,false)
		if targets[1] == nil then
			return {false, "Failed to find anyone of the mentioned players."}
		elseif targets[1] == false then
			return {false, targets[2]}
		end
		local done = {0,""}
		for _,v in pairs(targets) do
			v.Character.Humanoid.MaxHealth = 100
			v.Character.Humanoid.Health = v.Character.Humanoid.MaxHealth
			if done[2] ~= "" then
				done[2] = done[2]..", "..v.Name
				done[1] = done[1]+1
			else
				done[2] = v.Name
				done[1] = 1
			end
		end
		if done[1] >= 5 then
			return {true,"Successfully made "..done[1].." people mortals."}
		else
			return {true,"Successfully made "..done[2].." a mortal."}
		end
	end

	commands[#commands+1] = {2,module.Prefix.."ff [Players]"}
	if arg[1] == module.Prefix.."ff" or arg[1] == module.Prefix.."forcefield" then
		if GetLevel(plr) < 2 then
			return {false,"You do not have permission to execute this command."}
		end

		local targets = module:HandlePlayers(plr.Name,arg[2],1,false)
		if targets[1] == nil then
			return {false, "Failed to find anyone of the mentioned players."}
		elseif targets[1] == false then
			return {false, targets[2]}
		end
		local done = {0,""}
		for _,v in pairs(targets) do
			local ff = Instance.new("ForceField")
			ff.Parent = v.Character
			ff.Visible = true
			if done[2] ~= "" then
				done[2] = done[2]..", "..v.Name
				done[1] = done[1]+1
			else
				done[2] = v.Name
				done[1] = 1
			end
		end
		if done[1] >= 5 then
			return {true,"Successfully added a forcefield to "..done[1].." people."}
		else
			return {true,"Successfully added "..done[2].." a forcefield."}
		end
	end

	commands[#commands+1] = {2,module.Prefix.."unff [Players]"}
	if arg[1] == module.Prefix.."unff" or arg[1] == module.Prefix.."unforcefield" then
		if GetLevel(plr) < 2 then
			return {false,"You do not have permission to execute this command."}
		end

		local targets = module:HandlePlayers(plr.Name,arg[2],1,false)
		if targets[1] == nil then
			return {false, "Failed to find anyone of the mentioned players."}
		elseif targets[1] == false then
			return {false, targets[2]}
		end
		local done = {0,""}
		for _,v in pairs(targets) do
			local ff = v.Character:FindFirstChildOfClass("ForceField")
			if ff then
				ff:Destroy()
			end
			if done[2] ~= "" then
				done[2] = done[2]..", "..v.Name
				done[1] = done[1]+1
			else
				done[2] = v.Name
				done[1] = 1
			end
		end
		if done[1] >= 5 then
			return {true,"Successfully added a forcefield to "..done[1].." people."}
		else
			return {true,"Successfully added "..done[2].." a forcefield."}
		end
	end

	commands[#commands+1] = {2,module.Prefix.."health [Players] [Amount]"}
	if arg[1] == module.Prefix.."ungod" or arg[1] == module.Prefix.."ungodmode" then
		if GetLevel(plr) < 2 then
			return {false,"You do not have permission to execute this command."}
		end

		local targets = module:HandlePlayers(plr.Name,arg[2],2,false)
		if targets[1] == nil then
			return {false, "Failed to find anyone of the mentioned players."}
		elseif targets[1] == false then
			return {false, targets[2]}
		end
		local done = {0,""}
		for _,v in pairs(targets) do
			v.Character.Humanoid.MaxHealth = tonumber(arg[3] or 100)
			v.Character.Humanoid.Health = v.Character.Humanoid.MaxHealth
			if done[2] ~= "" then
				done[2] = done[2]..", "..v.Name
				done[1] = done[1]+1
			else
				done[2] = v.Name
				done[1] = 1
			end
		end
		if done[1] >= 5 then
			return {true,"Successfully edited "..done[1].." people."}
		else
			return {true,"Successfully edited "..done[2].."."}
		end
	end

	commands[#commands+1] = {2,module.Prefix.."directdamage <Players> [Damage]"}
	if arg[1] == module.Prefix.."directdamage" then
		if GetLevel(plr) < 2 then
			return {false,"You do not have permission to execute this command."}
		end

		if not arg[2] then
			return {false,"You must mention the targets."}
		end

		local targets = module:HandlePlayers(plr.Name,arg[2],2,false)
		if targets[1] == nil then
			return {false, "Failed to find anyone of the mentioned players."}
		elseif targets[1] == false then
			return {false, targets[2]}
		end
		local done = {0,""}
		for _,v in pairs(targets) do
			v.Character.Humanoid.Health = v.Character.Humanoid.Health-(tonumber(arg[3]) or 75)
			if done[2] ~= "" then
				done[2] = done[2]..", "..v.Name
				done[1] = done[1]+1
			else
				done[2] = v.Name
				done[1] = 1
			end
		end
		if done[1] >= 5 then
			return {true,"Successfully damaged "..done[1].." people directly."}
		else
			return {true,"Successfully damaged "..done[2].."directly."}
		end
	end

	commands[#commands+1] = {2,module.Prefix.."damage <Players> [Damage]"}
	if arg[1] == module.Prefix.."directdamage" then
		if GetLevel(plr) < 2 then
			return {false,"You do not have permission to execute this command."}
		end

		if not arg[2] then
			return {false,"You must mention the targets."}
		end

		local targets = module:HandlePlayers(plr.Name,arg[2],2,false)
		if targets[1] == nil then
			return {false, "Failed to find anyone of the mentioned players."}
		elseif targets[1] == false then
			return {false, targets[2]}
		end
		local done = {0,""}
		for _,v in pairs(targets) do
			v.Character.Humanoid:TakeDamage(tonumber(arg[3]) or 75)
			if done[2] ~= "" then
				done[2] = done[2]..", "..v.Name
				done[1] = done[1]+1
			else
				done[2] = v.Name
				done[1] = 1
			end
		end
		if done[1] >= 5 then
			return {true,"Successfully damaged "..done[1].." people."}
		else
			return {true,"Successfully damaged "..done[2].."."}
		end
	end

	commands[#commands+1] = {2,module.Prefix.."smite [Players]"}
	if arg[1] == module.Prefix.."smite" then
		if GetLevel(plr) < 2 then
			return {false,"You do not have permission to execute this command."}
		end

		local targets = module:HandlePlayers(plr.Name,arg[2],2,false)
		if targets[1] == nil then
			return {false, "Failed to find anyone of the mentioned players."}
		elseif targets[1] == false then
			return {false, targets[2]}
		end
		local done = {0,""}
		for _,v in pairs(targets) do
			v.Character.Humanoid.Health = 0
			local new = script.smite_local:Clone()
			local part = Instance.new("Part")
			local light = Instance.new("PointLight",v.Character.HumanoidRootPart)
			part.Parent = v.Character.HumanoidRootPart
			part.Size = Vector3.new(3,500,3)
			part.Position = Vector3.new(v.Character.HumanoidRootPart.Position.X,(v.Character.HumanoidRootPart.Position.Y+245),v.Character.HumanoidRootPart.Position.Z)
			part.BrickColor = BrickColor.White()
			part.Orientation = Vector3.new(0,math.random(0,90),0)
			light.Brightness = 5
			light.Color = Color3.new(255,255,255)
			part.Transparency = 0.5
			new.Parent = v.PlayerGui
			new.Disabled = false
			wait(0.2)
			part:Destroy()
			light:Destroy()
			if done[2] ~= "" then
				done[2] = done[2]..", "..v.Name
				done[1] = done[1]+1
			else
				done[2] = v.Name
				done[1] = 1
			end
		end
		if done[1] >= 5 then
			return {true,"Successfully smote "..done[1].." people."}
		else
			return {true,"Successfully smitted "..done[2].."."}
		end
	end

	if sandboxmode == false then
		commands[#commands+1] = {3,module.Prefix.."kick <Players> [Reason]"}
	end
	if arg[1] == module.Prefix.."kick" and sandboxmode == false then
		if GetLevel(plr) < 3 then
			return {false,"You do not have permission to execute this command."}
		end
		if not arg[2] then
			return {false,"You didn't include anyone to kick."}
		end

		if arg[3] then
			buildreason = ""
			for _,v in pairs(arg) do
				if v ~= arg[1] and v ~= arg[2] then
					buildreason = buildreason.." "..v
				end
			end
		end

		local targets = module:HandlePlayers(plr.Name,arg[2],2,false)
		if targets[1] == nil then
			return {false, "Failed to find anyone of the mentioned players."}
		elseif targets[1] == false then
			return {false, targets[2]}
		end
		local done = {0,""}
		for _,v in pairs(targets) do
			v:Kick("You have been kicked; "..(buildreason or "No reason added."))
			if done[2] ~= "" then
				done[2] = done[2]..", "..v.Name
				done[1] = done[1]+1
			else
				done[2] = v.Name
				done[1] = 1
			end
		end
		if done[1] >= 5 then
			return {true,"Successfully kicked "..done[1].." people. You monster."}
		else
			return {true,"Successfully kicked "..done[2].."."}
		end
	end

	commands[#commands+1] = {2,module.Prefix.."speed <Players> <Value>"}
	if arg[1] == module.Prefix.."speed" then
		if GetLevel(plr) < 2 then
			return {false,"You do not have permission to execute this command."}
		end
		if not arg[2] then
			return {false,"A player hasn't been mentioned."}
		end
		if not arg[3] then
			return {false,"A speed value hasn't been mentioned. (Default Speed is 16)"}
		end

		local speed = tonumber(arg[3])

		local targets = module:HandlePlayers(plr.Name,arg[2],2,false)
		if targets[1] == nil then
			return {false, "Failed to find anyone of the mentioned players."}
		elseif targets[1] == false then
			return {false, targets[2]}
		end
		local done = {0,""}
		for _,v in pairs(targets) do
			v.Character.Humanoid.WalkSpeed = speed
			if done[2] ~= "" then
				done[2] = done[2]..", "..v.Name
				done[1] = done[1]+1
			else
				done[2] = v.Name
				done[1] = 1
			end
		end
		if done[1] >= 5 then
			return {true,"Successfully sped up "..done[1].." people."}
		else
			return {true,"Successfully sped up "..done[2].."."}
		end
	end

	commands[#commands+1] = {2,module.Prefix.."jumppower <Players> <Value>"}
	if arg[1] == module.Prefix.."jumppower" or arg[1] == module.Prefix.."jp" then
		if GetLevel(plr) < 2 then
			return {false,"You do not have permission to execute this command."}
		end
		if not arg[2] then
			return {false,"A player hasn't been mentioned."}
		end
		if not arg[3] then
			return {false,"A jumppower value hasn't been mentioned."}
		end

		local jp = tonumber(arg[3])

		local targets = module:HandlePlayers(plr.Name,arg[2],2,false)
		if targets[1] == nil then
			return {false, "Failed to find anyone of the mentioned players."}
		elseif targets[1] == false then
			return {false, targets[2]}
		end
		local done = {0,""}
		for _,v in pairs(targets) do
			v.Character.Humanoid.JumpPower = jp
			if done[2] ~= "" then
				done[2] = done[2]..", "..v.Name
				done[1] = done[1]+1
			else
				done[2] = v.Name
				done[1] = 1
			end
		end
		if done[1] >= 5 then
			return {true,"Successfully edited "..done[1].." people."}
		else
			return {true,"Successfully edited "..done[2].."."}
		end
	end

	commands[#commands+1] = {4,module.Prefix.."f3x / btools [Player]"}
	if arg[1] == module.Prefix.."f3x" or arg[1] == module.Prefix.."btools" then
		if GetLevel(plr) < 4 then
			return {false,"You do not have permission to execute this command."}
		end

		local targets = module:HandlePlayers(plr.Name,arg[2],2,false)
		if targets[1] == nil then
			return {false, "Failed to find anyone of the mentioned players."}
		elseif targets[1] == false then
			return {false, targets[2]}
		end
		local done = {0,""}
		for _,v in pairs(targets) do
			-- code here
			local btools = script["Building Tools"]:Clone()
			btools.Parent = v.Backpack
			-- code end
			if done[2] ~= "" then
				done[2] = done[2]..", "..v.Name
				done[1] = done[1]+1
			else
				done[2] = v.Name
				done[1] = 1
			end
		end
		if done[1] >= 5 then
			return {true,"Successfully gave F3X to "..done[1].." people."}
		else
			return {true,"Successfully gave "..done[2].." F3X."}
		end
	end

	commands[#commands+1] = {3,module.Prefix.."sword [Player]"}
	if arg[1] == module.Prefix.."sword" then
		if GetLevel(plr) < 3 then
			return {false,"You do not have permission to execute this command."}
		end

		local targets = module:HandlePlayers(plr.Name,arg[2],2,false)
		if targets[1] == nil then
			return {false, "Failed to find anyone of the mentioned players."}
		elseif targets[1] == false then
			return {false, targets[2]}
		end
		local done = {0,""}
		for _,v in pairs(targets) do
			-- code here
			local btools = script.ClassicSword:Clone()
			btools.Parent = v.Backpack
			-- code end
			if done[2] ~= "" then
				done[2] = done[2]..", "..v.Name
				done[1] = done[1]+1
			else
				done[2] = v.Name
				done[1] = 1
			end
		end
		if done[1] >= 5 then
			return {true,"Successfully gave a sword to "..done[1].." people."}
		else
			return {true,"Successfully gave "..done[2].." a sword."}
		end
	end

	commands[#commands+1] = {3,module.Prefix.."vip <Player>"} -- Not to be handled by the new handler.
	if arg[1] == module.Prefix.."vip" then
		if (GetLevel(plr) < 3 and arg[2] == "@me") or (GetLevel(plr) < 3 and arg[2] == plr.Name) then
			return {false,"SUCCESS, U GAVE URSELF VIP.... NOT."}
		elseif GetLevel(plr) < 3 then
			return {false,"You do not have permission to execute this command."}
		end
		if not arg[2] then
			return {false,"It would be better if you'd give someone to VIP, you don't want to lose Level "..GetLevel(plr).." permissions. Trust me."}
		end
		if arg[2] == "@all" then
			return {false,"It would be better if you'd use '@others' instead, if you want to give VIP for everyone."}
		elseif arg[2] == "@others" then
			local adds = 0
			for _,v in pairs(game.Players:GetPlayers()) do
				if v.Name ~= plr.Name then
					if GetLevel(v) <= 1 then
						Admins.VIP[#Admins.VIP+1] = v.UserId
						adds = adds+1
						local isBan = GetLevel(v)
						Notify(v,"welcome","Your admin level in this server has been set to "..isBan..".")
					end
				end
			end
			return {true,"Successfully added "..adds.." as VIP."}
		elseif arg[2] == "@me" then
			return {false,"It would be better if you'd give someone to VIP, you don't want to lose Level "..GetLevel(plr).." permissions. Trust me."}
		elseif string.sub(arg[2],1,1) == "#" then
			for _,v in pairs(usersfolder:GetChildren()) do
				local nv = splitstring(v.Value," ")
				if nv[1] == arg[2] then
					local p = Player(nv[3])
					if p then
						if p.Name ~= plr.Name then
							if GetLevel(p) < GetLevel(plr) then
								Admins.VIP[#Admins.VIP+1] = p.UserId
								local isBan = GetLevel(p)
								Notify(p,"welcome","Your admin level in this server has been set to "..isBan..".")
								return {true,"Successfully added "..p.Name.." as VIP."}
							else
								return {false,"You can't give VIP to someone higher or equal to your level."}
							end
						else
							return {false,"It would be better if you'd give someone ELSE to VIP, you don't want to lose Level "..GetLevel(plr).." permissions. Trust me."}
						end
					else
						return {false,"An error has occured. Please try again later."}
					end
				end
			end
			return {false,"Local Player ID not found."}
		else
			local p = Player(arg[2])
			if p then
				if p.Name ~= plr.Name then
					if GetLevel(p) < GetLevel(plr) then
						Admins.VIP[#Admins.VIP+1] = p.UserId
						local isBan = GetLevel(p)
						Notify(p,"welcome","Your admin level in this server has been set to "..isBan..".")
						return {true,"Successfully added "..p.Name.." as VIP."}
					else
						return {false,"You can't give VIP to someone higher or equal to your level."}
					end
				else
					return {false,"It would be better if you'd give someone to VIP, you don't want to lose Level "..GetLevel(plr).." permissions. Trust me."}
				end
			else 
				if arg[2] == "me" then
					return {false,"Player not found. Did you mean '@me'?"}
				elseif arg[2] == "others" then
					return {false,"Player not found. Did you mean '@others'?"}
				elseif arg[2] == "all" then
					return {false,"Player not found. Did you mean '@all'?"}
				else
					return {false,"Player not found OR You forgot to mark it as an alternative."} 
				end
			end
		end
	end

	if sandboxmode == false then
		commands[#commands+1] = {4,module.Prefix.."slock [MinimumLevel]"}
		commands[#commands+1] = {4,module.Prefix.."unslock"}
		commands[#commands+1] = {4,module.Prefix.."toggleslock"}
	end
	if ((arg[1] == module.Prefix.."slock") or (arg[1] == module.Prefix.."toggleslock" and serverlock[1] == false)) and sandboxmode == false then
		if GetLevel(plr) < 4 then
			return {false,"You do not have permission to lock the server."}
		end
		if not arg[2] then
			arg[2] = "2"
		end
		if tonumber(arg[2]) <= GetLevel(plr) then
			serverlock = {true,arg[2]}
		else
			return {false,"You cannot lock a server to a level higher than yours."}
		end
		return {true,"The server has been locked to level "..arg[2].." and higher."}
	end
	if ((arg[1] == module.Prefix.."unslock") or (arg[1] == module.Prefix.."toggleslock" and serverlock[1] == true)) and sandboxmode == false then
		if GetLevel(plr) < 4 then
			return {false,"You do not have permission to lock the server."}
		end
		serverlock = {false,0}
		return {true,"The server has been unlocked."}
	end

	commands[#commands+1] = {4,module.Prefix.."mod <Player>"}
	if arg[1] == module.Prefix.."mod" then
		if (GetLevel(plr) < 4 and arg[2] == "@me") or (GetLevel(plr) < 4 and arg[2] == plr.Name) then
			return {false,"Moderation is currently disabled for this player."}
		elseif GetLevel(plr) < 4 then
			return {false,"You do not have permission to execute this command."}
		end
		if not arg[2] then
			return {false,"It would be better if you'd give someone to level-up, you don't want to lose Level "..GetLevel(plr).." permissions. Trust me."}
		end
		if arg[2] == "@all" then
			return {false,"It would be better if you'd use '@others' instead, if you want to give moderator for everyone."}
		elseif arg[2] == "@others" then
			local adds = 0
			for _,v in pairs(game.Players:GetPlayers()) do
				if v.Name ~= plr.Name then
					if GetLevel(v) <= 2 then
						Admins.Moderators[#Admins.Moderators+1] = v.UserId
						adds = adds+1
						local isBan = GetLevel(v)
						Notify(v,"welcome","Your admin level in this server has been set to "..isBan..".")
					end
				end
			end
			return {true,"Successfully added "..adds.." as moderators."}
		elseif arg[2] == "@me" then
			return {false,"It would be better if you'd give someone to level-up, you don't want to lose Level "..GetLevel(plr).." permissions. Trust me."}
		elseif string.sub(arg[2],1,1) == "#" then
			for _,v in pairs(usersfolder:GetChildren()) do
				local nv = splitstring(v.Value," ")
				if nv[1] == arg[2] then
					local p = Player(nv[3])
					if p then
						if p.Name ~= plr.Name then
							if GetLevel(p) < GetLevel(plr) then 
								Admins.Moderators[#Admins.Moderators+1] = p.UserId
								local isBan = GetLevel(p)
								Notify(p,"welcome","Your admin level in this server has been set to "..isBan..".")
								return {true,"Successfully added "..p.Name.." as a moderator."}
							else
								return {false,"You can't give Moderator to someone higher or equal to your level."}
							end
						else
							return {false,"It would be better if you'd give someone ELSE to level-up, you don't want to lose Level "..GetLevel(plr).." permissions. Trust me."}
						end
					else
						return {false,"An error has occured. Please try again later."}
					end
				end
			end
			return {false,"Local Player ID not found."}
		else
			local p = Player(arg[2])
			if p then
				if p.Name ~= plr.Name then
					if GetLevel(p) < GetLevel(plr) then 
						Admins.Moderators[#Admins.Moderators+1] = p.UserId
						local isBan = GetLevel(p)
						Notify(p,"welcome","Your admin level in this server has been set to "..isBan..".")
						return {true,"Successfully added "..p.Name.." as a moderator."}
					else
						return {false,"You can't give Moderator to someone higher or equal to your level."}
					end
				else
					return {false,"It would be better if you'd give someone to level-up, you don't want to lose Level "..GetLevel(plr).." permissions. Trust me."}
				end
			else if arg[2] == "me" then
					return {false,"Player not found. Did you mean '@me'?"}
				elseif arg[2] == "others" then
					return {false,"Player not found. Did you mean '@others'?"}
				elseif arg[2] == "all" then
					return {false,"Player not found. Did you mean '@all'?"}
				else
					return {false,"Player not found OR You forgot to mark it as an alternative."} 
				end
			end
		end
	end

	commands[#commands+1] = {4,module.Prefix.."admin <Player>"}
	if arg[1] == module.Prefix.."admin" then
		if (GetLevel(plr) < 4 and arg[2] == "@me") or (GetLevel(plr) < 3 and arg[2] == plr.Name) then
			return {false,"Is admin really all you going for? Why not just "..module.Prefix.."super yourself, huh?"}
		elseif GetLevel(plr) < 4 then
			return {false,"You do not have permission to execute this command."}
		end
		if not arg[2] then
			return {false,"It would be better if you'd give someone to level-up, you don't want to lose Level "..GetLevel(plr).." permissions. Trust me."}
		end
		if arg[2] == "@all" then
			return {false,"It would be better if you'd use '@others' instead, if you want to give admin for everyone."}
		elseif arg[2] == "@others" then
			local adds = 0
			for _,v in pairs(game.Players:GetPlayers()) do
				if v.Name ~= plr.Name then
					if GetLevel(v) <= 3 then
						Admins.Admins[#Admins.Admins+1] = v.UserId
						adds = adds+1
						local isBan = GetLevel(v)
						Notify(v,"welcome","Your admin level in this server has been set to "..isBan..".")
					end
				end
			end
			return {true,"Successfully added "..adds.." as admins."}
		elseif arg[2] == "@me" then
			return {false,"It would be better if you'd give someone to level-up, you don't want to lose Level "..GetLevel(plr).." permissions. Trust me."}
		elseif string.sub(arg[2],1,1) == "#" then
			for _,v in pairs(usersfolder:GetChildren()) do
				local nv = splitstring(v.Value," ")
				if nv[1] == arg[2] then
					local p = Player(nv[3])
					if p then
						if p.Name ~= plr.Name then
							if GetLevel(p) < GetLevel(plr) then 
								Admins.Admins[#Admins.Admins+1] = p.UserId
								local isBan = GetLevel(p)
								Notify(p,"welcome","Your admin level in this server has been set to "..isBan..".")
								return {true,"Successfully added "..p.Name.." as an admin."}
							else
								return {false,"You can't give Admin to someone higher or equal to your level."}
							end
						else
							return {false,"It would be better if you'd give someone to level-up, you don't want to lose Level "..GetLevel(plr).." permissions. Trust me."}
						end
					else
						return {false,"An error has occured. Please try again later."}
					end
				end
			end
			return {false,"Local Player ID not found."}
		else
			local p = Player(arg[2])
			if p then
				if p.Name ~= plr.Name then
					if GetLevel(p) < GetLevel(plr) then 
						Admins.Admins[#Admins.Admins+1] = p.UserId
						local isBan = GetLevel(p)
						Notify(p,"welcome","Your admin level in this server has been set to "..isBan..".")
						return {true,"Successfully added "..p.Name.." as an admin."}
					else
						return {false,"You can't give Admin to someone higher or equal to your level."}
					end
				else
					return {false,"It would be better if you'd give someone to level-up, you don't want to lose Level "..GetLevel(plr).." permissions. Trust me."}
				end
			else 
				if arg[2] == "me" then
					return {false,"Player not found. Did you mean '@me'?"}
				elseif arg[2] == "others" then
					return {false,"Player not found. Did you mean '@others'?"}
				elseif arg[2] == "all" then
					return {false,"Player not found. Did you mean '@all'?"}
				else
					return {false,"Player not found OR You forgot to mark it as an alternative."} 
				end
			end
		end
	end

	commands[#commands+1] = {5,module.Prefix.."super / superadmin <Player>"}
	if arg[1] == module.Prefix.."super" or arg[1] == module.Prefix.."superadmin" then
		if (GetLevel(plr) < 5 and arg[2] == "@me") or (GetLevel(plr) < 5 and arg[2] == plr.Name) then
			return {false,"Credit for the attempt."}
		elseif GetLevel(plr) < 5 then
			return {false,"You do not have permission to execute this command."}
		end
		if not arg[2] then
			return {false,"It would be better if you'd give someone to level-up, you don't want to lose Level "..GetLevel(plr).." permissions. Trust me."}
		end
		if arg[2] == "@all" then
			return {false,"It would be better if you'd use '@others' instead, if you want to give super admin for everyone."}
		elseif arg[2] == "@others" then
			local adds = 0
			for _,v in pairs(game.Players:GetPlayers()) do
				if v.Name ~= plr.Name then
					if GetLevel(v) <= 4 then
						Admins.Admins[#Admins.Admins+1] = v.UserId
						adds = adds+1
						local isBan = GetLevel(v)
						Notify(v,"welcome","Your admin level in this server has been set to "..isBan..".")
					end
				end
			end
			return {true,"Successfully added "..adds.." as super admins."}
		elseif arg[2] == "@me" then
			return {false,"It would be better if you'd give someone to level-up, you don't want to lose Level "..GetLevel(plr).." permissions. Trust me."}
		elseif string.sub(arg[2],1,1) == "#" then
			for _,v in pairs(usersfolder:GetChildren()) do
				local nv = splitstring(v.Value," ")
				if nv[1] == arg[2] then
					local p = Player(nv[3])
					if p then
						if p.Name ~= plr.Name then
							if GetLevel(p) < GetLevel(plr) then 
								Admins.SuperAdmins[#Admins.SuperAdmins+1] = p.UserId
								local isBan = GetLevel(p)
								Notify(p,"welcome","Your admin level in this server has been set to "..isBan..".")
								return {true,"Successfully added "..p.Name.." as a super admin."}
							else
								return {false,"You can't give Super Admin to someone higher or equal to your level."}
							end
						else
							return {false,"It would be better if you'd give someone to level-up, you don't want to lose Level "..GetLevel(plr).." permissions. Trust me."}
						end
					else
						return {false,"An error has occured. Please try again later."}
					end
				end
			end
			return {false,"Local Player ID not found."}
		else
			local p = Player(arg[2])
			if p then
				if p.Name ~= plr.Name then
					if GetLevel(p) < GetLevel(plr) then 
						Admins.SuperAdmins[#Admins.SuperAdmins+1] = p.UserId
						local isBan = GetLevel(p)
						Notify(p,"welcome","Your admin level in this server has been set to "..isBan..".")
						return {true,"Successfully added "..p.Name.." as a super admin."}
					else
						return {false,"You can't give Super Admin to someone higher or equal to your level."}
					end
				else
					return {false,"It would be better if you'd give someone to level-up, you don't want to lose Level "..GetLevel(plr).." permissions. Trust me."}
				end
			else if arg[2] == "me" then
					return {false,"Player not found. Did you mean '@me'?"}
				elseif arg[2] == "others" then
					return {false,"Player not found. Did you mean '@others'?"}
				elseif arg[2] == "all" then
					return {false,"Player not found. Did you mean '@all'?"}
				else
					return {false,"Player not found OR You forgot to mark it as an alternative."} 
				end end
		end
	end

	if sandboxmode == false then
		commands[#commands+1] = {5,module.Prefix.."sudo <Player|@@> <Command>"}
	end
	if arg[1] == module.Prefix.."sudo" then
		return {false,"This command is not yet available. Wait for.. another time."}
	end

	if sandboxmode == false then
		commands[#commands+1] = {4,module.Prefix.."unadmin <Player>"}
	end
	if arg[1] == module.Prefix.."unadmin" and sandboxmode == false then
		if (GetLevel(plr) < 2 and arg[2] == "@me") or (GetLevel(plr) < 2 and arg[2] == plr.Name) then
			return {false,"Success, you have unadmined yourself... until you found you weren't an admin in the first place."}
		elseif GetLevel(plr) < 5 then
			return {false,"You do not have permission to execute this command."}
		end
		if not arg[2] then
			return {false,"A variable is required."}
		end
		if string.sub(arg[2],1,1) == "#" then
			for _,v in pairs(usersfolder:GetChildren()) do
				local nv = splitstring(v.Value," ")
				if nv[1] == arg[2] then
					local p = Player(nv[3])
					if p then
						if p.Name ~= plr.Name then
							if GetLevel(p) < GetLevel(plr) then 
								if GetLevel(p) <= 1 then
									return {false,p.Name.." isn't an admin."}
								end
								for k,v in pairs(Admins.SuperAdmins) do
									if v == p.UserId then
										Admins.SuperAdmins[k] = nil
									end
								end
								for k,v in pairs(Admins.Admins) do
									if v == p.UserId then
										Admins.Admins[k] = nil
									end
								end
								for k,v in pairs(Admins.Moderators) do
									if v == p.UserId then
										Admins.Moderators[k] = nil
									end
								end
								return {true,p.Name.." has been unadmined."}
							elseif GetLevel(p) == 5 and GetLevel(plr) == 5 then
								return {false,"Your linux terminal has crashed while attempting to remove sudo access from "..p.Name}
							else
								return {false,"You can't unadmin someone higher or equal to your level."}
							end
						else
							return {false,"Nice try... Not."}
						end
					else
						return {false,"An error has occured. Please try again later."}
					end
				end
			end
			return {false,"Local Player ID not found."}
		else
			local p = Player(arg[2])
			if p then
				if p.Name ~= plr.Name then
					if GetLevel(p) < GetLevel(plr) then 
						if GetLevel(p) <= 1 then
							return {false,p.Name.." isn't an admin."}
						end
						for k,v in pairs(Admins.SuperAdmins) do
							if v == p.UserId then
								Admins.SuperAdmins[k] = nil
							end
						end
						for k,v in pairs(Admins.Admins) do
							if v == p.UserId then
								Admins.Admins[k] = nil
							end
						end
						for k,v in pairs(Admins.Moderators) do
							if v == p.UserId then
								Admins.Moderators[k] = nil
							end
						end
						return {true,p.Name.." has been unadmined."}
					else
						return {false,"You can't unadmin someone higher or equal to your level."}
					end
				else
					return {false,"..... Welp, you tried."}
				end
			else 
				if arg[2] == "me" then
					return {false,"Alternatives are disabled for this command."}
				elseif arg[2] == "others" then
					return {false,"Alternatives are disabled for this command."}
				elseif arg[2] == "all" then
					return {false,"Alternatives are disabled for this command."}
				else
					return {false,"Player was not found."} 
				end
			end
		end
	end

	if sandboxmode == false or isOwner(plr) then
		commands[#commands+1] = {4,module.Prefix.."unban <UserId>"}
	end
	if arg[1] == module.Prefix.."unban" and sandboxmode == false then
		if arg[2] == "@me" or arg[2] == plr.Name or arg[2] == plr.UserId then
			return {false,"👏👏👏 Congratulations. The command worked. 👏👏👏"}
		elseif GetLevel(plr) < 4 then
			return {false,"You do not have permission to execute this command."}
		end
		if not arg[2] then
			return {false,"A variable is required."}
		end
		local found = false
		for k,v in pairs(Admins.BanLand) do
			if v[1] == arg[2] then
				Admins.BanLand[k] = nil
				found = true
			end
		end
		if found == true then
			return {true,arg[2].." has been unbanned. (Remember to do "..module.Prefix.."saveadmins !)"}
		else
			return {true,arg[2].." wasn't found in the banlist. [Did you search by UserId?]"}
		end
	end

	if sandboxmode == false or isOwner(plr) then
		commands[#commands+1] = {5,module.Prefix.."ban <Player> [Reason]"}
	end
	if arg[1] == module.Prefix.."ban" and sandboxmode == false then
		local banreason = ""
		if GetLevel(plr) < 5 then
			return {false,"You do not have permission to execute this command."}
		end
		if not arg[2] then
			return {false,"You didn't mention anyone to ban."}
		end

		if not arg[3] then
			banreason = module.DefaultBanReason
		else
			for _,v in pairs(arg) do
				if v ~= arg[1] and v ~= arg[2] then
					banreason = banreason.." "..v
				end
			end
		end

		if arg[2] == "@all" then
			return {false,"Alternatives that include multiple people are disabled for this command."}
		elseif arg[2] == "@others" then
			return {false,"Alternatives that include multiple people are disabled for this command."}
		elseif arg[2] == "@me" then
			return {false,"Y-YOU WANT TO BAN YOURSELF?! ARE YOU OUT OF YOUR MIND?!"}
		elseif string.sub(arg[2],1,1) == "#" then
			for _,v in pairs(usersfolder:GetChildren()) do
				local nv = splitstring(v.Value," ")
				if nv[1] == arg[2] then
					local p = Player(nv[3])
					if p then
						if p.Name ~= plr.Name then
							if GetLevel(p) < GetLevel(plr) then
								Admins.BanLand[#Admins.BanLand+1] = {p.UserId,banreason}
								p:Kick(module.BanMessage.." "..banreason)
								return {true,"Successfully banned "..p.Name.." for '"..banreason.."'."}
							else
								return {false,"You can't ban someone who's higher or equal to your level."}
							end
						else
							return {false,"Y-YOU WANT TO BAN YOURSELF?! ARE YOU OUT OF YOUR MIND?!"}
						end
					else
						return {false,"An error has occured. Please try again later."}
					end
				end
			end
			return {false,"Local Player ID not found."}
		else
			local p = Player(arg[2])
			if p then
				if p.Name ~= plr.Name then
					if GetLevel(p) < GetLevel(plr) then
						Admins.BanLand[#Admins.BanLand+1] = {p.UserId,banreason}
						p:Kick(module.BanMessage.." "..banreason)
						return {true,"Successfully banned "..p.Name.." for '"..banreason.."'."}
					else
						return {false,"You can't ban someone who's higher or equal to your level."}
					end
				else
					return {false,"Y-YOU WANT TO BAN YOURSELF?! ARE YOU OUT OF YOUR MIND?!"}
				end
			else return {false,"Player not found. Also, no alternatives are allowed here."} end
		end
	end

	commands[#commands+1] = {3,module.Prefix.."fly [Player]"}
	if arg[1] == module.Prefix.."fly" then
		if GetLevel(plr) < 3 then
			return {false,"You do not have permission to execute this command."}
		end

		if not arg[2] then
			if not plr.Character:FindFirstChild("fly") then
				local fly = script.fly:Clone()
				fly.Parent = plr.Character
				fly.Disabled = false
				return {true,"You made yourself fly in the sky!"} 
			else
				return {false,"You already have the necessary skill to fly! (Perhaps press X to fly again.)"}
			end
		end
		local targets = module:HandlePlayers(plr.Name,arg[2],2,false)
		if targets[1] == nil then
			return {false, "Failed to find anyone of the mentioned players."}
		elseif targets[1] == false then
			return {false, targets[2]}
		end
		local done = {0,""}
		for _,v in pairs(targets) do
			if not plr.Character:FindFirstChild("fly") then
				local fly = script.fly:Clone()
				fly.Parent = v.Character
				fly.Disabled = false
				if done[2] ~= "" then
					done[2] = done[2]..", "..v.Name
					done[1] = done[1]+1
				else
					done[2] = v.Name
					done[1] = 1
				end
			else end
		end
		if done[1] >= 5 then
			return {true,"Successfully made "..done[1].." people fly.."}
		else
			return {true,"Successfully made "..done[2].." fly."}
		end
	end

	commands[#commands+1] = {2,module.Prefix.."n / notify <Player> <Value>"}
	if arg[1] == module.Prefix.."n" or arg[1] == module.Prefix.."notify" or arg[1] == module.Prefix.."notification" then
		local buildreason = "yes hi"

		if GetLevel(plr) < 2 then
			return {false,"You do not have permission to execute this command."}
		end
		if not arg[2] then
			return {false,"You didn't include anyone to notify"}
		end

		if arg[3] then
			buildreason = ""
			for _,v in pairs(arg) do
				if v ~= arg[1] and v ~= arg[2] then
					buildreason = buildreason.." "..v
				end
			end
		end

		local targets = module:HandlePlayers(plr.Name,arg[2],-1,true)
		if targets[1] == nil then
			return {false, "Failed to find anyone of the mentioned players."}
		elseif targets[1] == false then
			return {false, targets[2]}
		end
		local done = {0,""}
		for _,v in pairs(targets) do
			Notify(v,"notification",buildreason or "?")
			if done[2] ~= "" then
				done[2] = done[2]..", "..v.Name
				done[1] = done[1]+1
			else
				done[2] = v.Name
				done[1] = 1
			end
		end
		if done[1] >= 5 then
			return {true,"Successfully notified "..done[1].." people."}
		else
			return {true,"Successfully notified "..done[2].."."}
		end
	end

	commands[#commands+1] = {2,module.Prefix.."critical <Player> <Value>"}
	if arg[1] == module.Prefix.."critical" then
		local buildreason = "yes hi"

		if GetLevel(plr) < 3 then
			return {false,"You do not have permission to execute this command."}
		end
		if not arg[2] then
			return {false,"You didn't include anyone to notify"}
		end

		if arg[3] then
			buildreason = ""
			for _,v in pairs(arg) do
				if v ~= arg[1] and v ~= arg[2] then
					buildreason = buildreason.." "..v
				end
			end
		end

		local targets = module:HandlePlayers(plr.Name,arg[2],-1,true)
		if targets[1] == nil then
			return {false, "Failed to find anyone of the mentioned players."}
		elseif targets[1] == false then
			return {false, targets[2]}
		end
		local done = {0,""}
		for _,v in pairs(targets) do
			Notify(v,"critical",buildreason or "?")
			if done[2] ~= "" then
				done[2] = done[2]..", "..v.Name
				done[1] = done[1]+1
			else
				done[2] = v.Name
				done[1] = 1
			end
		end
		if done[1] >= 5 then
			return {true,"Successfully notified "..done[1].." people."}
		else
			return {true,"Successfully notified "..done[2].."."}
		end
	end

	commands[#commands+1] = {3,module.Prefix.."m / message <Player> <Value>"}	
	if arg[1] == module.Prefix.."m" or arg[1] == module.Prefix.."message" then
		local buildreason = ""

		if GetLevel(plr) < 3 then
			return {false,"You do not have permission to execute this command."}
		end
		if not arg[2] then
			return {false,"You didn't include anyone to message. If you want to message everyone, use "..module.Prefix.."broadcast."}
		end

		if arg[3] then
			buildreason = ""
			for _,v in pairs(arg) do
				if v ~= arg[1] and v ~= arg[2] then
					buildreason = buildreason.." "..v
				end
			end
		end

		local targets = module:HandlePlayers(plr.Name,arg[2],-1,true)
		if targets[1] == nil then
			return {false, "Failed to find anyone of the mentioned players."}
		elseif targets[1] == false then
			return {false, targets[2]}
		end
		local done = {0,""}
		for _,v in pairs(targets) do
			Notify(v,"newmsg",{"Message by "..plr.Name,buildreason or "?"})
			if done[2] ~= "" then
				done[2] = done[2]..", "..v.Name
				done[1] = done[1]+1
			else
				done[2] = v.Name
				done[1] = 1
			end
		end
		if done[1] >= 5 then
			return {true,"Successfully notified "..done[1].." people."}
		else
			return {true,"Successfully notified "..done[2].."."}
		end
	end

	commands[#commands+1] = {3,module.Prefix.."sm <Player> <Value>"}	
	if arg[1] == module.Prefix.."sm" or arg[1] == module.Prefix.."servermessage" or arg[1] == module.Prefix.."am" or arg[1] == module.Prefix.."anonymousmessage" then
		local buildreason = ""

		if GetLevel(plr) < 3 then
			return {false,"You do not have permission to execute this command."}
		end
		if not arg[2] then
			return {false,"You didn't include anyone to message. If you want to message everyone, use "..module.Prefix.."broadcast."}
		end

		if arg[3] then
			buildreason = ""
			for _,v in pairs(arg) do
				if v ~= arg[1] and v ~= arg[2] then
					buildreason = buildreason.." "..v
				end
			end
		end

		local targets = module:HandlePlayers(plr.Name,arg[2],-1,true)
		if targets[1] == nil then
			return {false, "Failed to find anyone of the mentioned players."}
		elseif targets[1] == false then
			return {false, targets[2]}
		end
		local done = {0,""}
		for _,v in pairs(targets) do
			Notify(v,"newmsg",{"Message by Server",buildreason or "?"})
			if done[2] ~= "" then
				done[2] = done[2]..", "..v.Name
				done[1] = done[1]+1
			else
				done[2] = v.Name
				done[1] = 1
			end
		end
		if done[1] >= 5 then
			return {true,"Successfully notified "..done[1].." people."}
		else
			return {true,"Successfully notified "..done[2].."."}
		end
	end

	commands[#commands+1] = {3,module.Prefix.."b / broadcast <Value>"}
	if arg[1] == module.Prefix.."b" or arg[1] == module.Prefix.."broadcast" then
		if GetLevel(plr) < 3 then
			return {false,"You do not have permission to execute this command."}
		end

		if arg[2] then
			buildreason = ""
			for _,v in pairs(arg) do
				if v ~= arg[1] then
					buildreason = buildreason.." "..v
				end
			end
		end

		for _,v in pairs(game.Players:GetPlayers()) do
			local new = script.FullScreenNotification:Clone()
			Notify(v,"newmsg",{"Message by "..plr.Name,buildreason or "?"})
		end

		return{true,"Success."}
	end

	commands[#commands+1] = {4,module.Prefix.."sb <Value>"}
	if arg[1] == module.Prefix.."sb" or arg[1] == module.Prefix.."serverbroadcast" or arg[1] == module.Prefix.."ab" or arg[1] == module.Prefix.."anonymousbroadcast" then
		if GetLevel(plr) < 4 then
			return {false,"You do not have permission to execute this command."}
		end

		if arg[2] then
			buildreason = ""
			for _,v in pairs(arg) do
				if v ~= arg[1] then
					buildreason = buildreason.." "..v
				end
			end
		end

		for _,v in pairs(game.Players:GetPlayers()) do
			local new = script.FullScreenNotification:Clone()
			Notify(v,"newmsg",{"Server Message",buildreason or "?"})
		end

		return{true,"Success."}
	end

	commands[#commands+1] = {1,module.Prefix.."fire / burn [Player]"} -- VIP command
	if arg[1] == module.Prefix.."fire" or arg[1] == module.Prefix.."burn" then
		if GetLevel(plr) < 1 then
			return {false,"You do not have permission to execute this command."}
		end
		if not arg[2] then
			if not plr.Character.HumanoidRootPart:FindFirstChild("Fire") then
				local fly = Instance.new("Fire")
				fly.Parent = plr.Character:FindFirstChild("HumanoidRootPart")
				return {true,"You've made yourself burn."} 
			else
				return {false,"You're already burning!"}
			end
		end

		if arg[2] == "@all" then
			if GetLevel(plr) < 3 then
				return {false,"You do not have permission to execute this command on others."}
			end
			local adds = 0
			for _,v in pairs(game.Players:GetPlayers()) do
				if not v.Character.HumanoidRootPart:FindFirstChild("Fire") then
					local fire = Instance.new("Fire")
					fire.Parent = v.Character:FindFirstChild("HumanoidRootPart")
					adds = adds+1
				end
			end
			return {true,"Successfully made "..adds.." players burn in flames!"}
		elseif arg[2] == "@others" then
			if GetLevel(plr) < 3 then
				return {false,"You do not have permission to execute this command on others."}
			end	
			local adds = 0
			for _,v in pairs(game.Players:GetPlayers()) do
				if v.Name ~= plr.Name then
					if not v.Character.HumanoidRootPart:FindFirstChild("Fire") then
						local fire = Instance.new("Fire")
						fire.Parent = v.Character:FindFirstChild("HumanoidRootPart")
						adds = adds+1
					end
				end
			end
			return {true,"Successfully made "..adds.." players burn in flames!"}
		elseif arg[2] == "@me" then
			if not plr.Character.HumanoidRootPart:FindFirstChild("Fire") then
				local fly = Instance.new("Fire")
				fly.Parent = plr.Character:FindFirstChild("HumanoidRootPart")
				return {true,"You've made yourself burn."} 
			else
				return {false,"You're already burning!"}
			end
		elseif string.sub(arg[2],1,1) == "#" then
			if GetLevel(plr) < 3 then
				return {false,"You do not have permission to execute this command on others."}
			end	

			for _,v in pairs(usersfolder:GetChildren()) do
				local nv = splitstring(v.Value," ")
				if nv[1] == arg[2] then
					local p = Player(nv[3])
					if p then
						if not p.Character.HumanoidRootPart:FindFirstChild("Fire") then
							local fly = Instance.new("Fire")
							fly.Parent = p.Character:FindFirstChild("HumanoidRootPart")
							return {true,p.Name.." is now burning in flames!"} 
						else
							return {false,p.Name.." is already burning!"}
						end
					else
						return {false,"An error has occured. Please try again later."}
					end
				end
			end
			return {false,"Local Player ID not found."}
		else
			if GetLevel(plr) < 3 then
				return {false,"You do not have permission to execute this command on others."}
			end	
			local p = Player(arg[2])
			if p then
				if not p.Character.HumanoidRootPart:FindFirstChild("Fire") then
					local fly = Instance.new("Fire")
					fly.Parent = p.Character:FindFirstChild("HumanoidRootPart")
					return {true,p.Name.." is now burning in flames!"} 
				else
					return {false,p.Name.." is already burning!"}
				end
			else 
				if arg[2] == "me" then
					return {false,"Player not found. Did you mean '@me'?"}
				elseif arg[2] == "others" then
					return {false,"Player not found. Did you mean '@others'?"}
				elseif arg[2] == "all" then
					return {false,"Player not found. Did you mean '@all'?"}
				else
					return {false,"Player not found OR You forgot to mark it as an alternative."} 
				end
			end
		end
	end

	commands[#commands+1] = {1,module.Prefix.."unfire / extinguish [Player]"} -- VIP command
	if arg[1] == module.Prefix.."unfire" or arg[1] == module.Prefix.."extinguish" then
		if GetLevel(plr) < 1 then
			return {false,"You do not have permission to execute this command."}
		end
		if not arg[2] then
			if plr.Character.HumanoidRootPart:FindFirstChild("Fire") then
				plr.Character.HumanoidRootPart.Fire:Destroy()
				return {true,"You've extinguished yourself."} 
			else
				return {false,"You're not on flames."}
			end
		end

		if arg[2] == "@all" then
			if GetLevel(plr) < 3 then
				return {false,"You do not have permission to execute this command on others."}
			end
			local adds = 0
			for _,v in pairs(game.Players:GetPlayers()) do
				if v.Character.HumanoidRootPart:FindFirstChild("Fire") then
					v.Character.HumanoidRootPart.Fire:Destroy()
					adds = adds+1
				end
			end
			return {true,"Successfully extinguished "..adds.." players."}
		elseif arg[2] == "@others" then
			if GetLevel(plr) < 3 then
				return {false,"You do not have permission to execute this command on others."}
			end	
			local adds = 0
			for _,v in pairs(game.Players:GetPlayers()) do
				if v.Name ~= plr.Name then
					if v.Character.HumanoidRootPart:FindFirstChild("Fire") then
						v.Character.HumanoidRootPart.Fire:Destroy()
						adds = adds+1
					end
				end
			end
			return {true,"Successfully extinguished "..adds.." players."}
		elseif arg[2] == "@me" then
			if plr.Character.HumanoidRootPart:FindFirstChild("Fire") then
				plr.Character.HumanoidRootPart.Fire:Destroy()
				return {true,"You've extinguished yourself."} 
			else
				return {false,"You're not on flames."}
			end
		elseif string.sub(arg[2],1,1) == "#" then
			for _,v in pairs(usersfolder:GetChildren()) do
				local nv = splitstring(v.Value," ")
				if nv[1] == arg[2] then
					local p = Player(nv[3])
					if p then
						if p.Character.HumanoidRootPart:FindFirstChild("Fire") then
							p.Character.HumanoidRootPart.Fire:Destroy()
							return {true,p.Name.." has been extinguished."} 
						else
							return {false,p.Name.." is not burning though..."}
						end
					else
						return {false,"An error has occured. Please try again later."}
					end
				end
			end
			return {false,"Local Player ID not found."}
		else
			if GetLevel(plr) < 3 then
				return {false,"You do not have permission to execute this command on others."}
			end	
			local p = Player(arg[2])
			if p then
				if p.Character.HumanoidRootPart:FindFirstChild("Fire") then
					p.Character.HumanoidRootPart.Fire:Destroy()
					return {true,p.Name.." has been extinguished."} 
				else
					return {false,p.Name.." is not burning though..."}
				end
			else 
				if arg[2] == "me" then
					return {false,"Player not found. Did you mean '@me'?"}
				elseif arg[2] == "others" then
					return {false,"Player not found. Did you mean '@others'?"}
				elseif arg[2] == "all" then
					return {false,"Player not found. Did you mean '@all'?"}
				else
					return {false,"Player not found OR You forgot to mark it as an alternative."} 
				end
			end
		end
	end

	commands[#commands+1] = {1,module.Prefix.."sparkle [Player]"} -- VIP command
	if arg[1] == module.Prefix.."sparkle" then
		if GetLevel(plr) < 1 then
			return {false,"You do not have permission to execute this command."}
		end
		if not arg[2] then
			if not plr.Character.HumanoidRootPart:FindFirstChild("Sparkles") then
				local sparkles = Instance.new("Sparkles")
				sparkles.Parent = plr.Character:FindFirstChild("HumanoidRootPart")
				return {true,"You've made yourself sparkle!"} 
			else
				return {false,"You're already sparkling!"}
			end
		end

		if arg[2] == "@all" then
			if GetLevel(plr) < 3 then
				return {false,"You do not have permission to execute this command on others."}
			end
			local adds = 0
			for _,v in pairs(game.Players:GetPlayers()) do
				if not v.Character.HumanoidRootPart:FindFirstChild("Sparkles") then
					local sparkles = Instance.new("Sparkles")
					sparkles.Parent = plr.Character:FindFirstChild("HumanoidRootPart")
					adds=adds+1
				end
			end
			return {true,"Successfully made "..adds.." players sparkle!"}
		elseif arg[2] == "@others" then
			if GetLevel(plr) < 3 then
				return {false,"You do not have permission to execute this command on others."}
			end	
			local adds = 0
			for _,v in pairs(game.Players:GetPlayers()) do
				if v.Name ~= plr.Name then
					if not v.Character.HumanoidRootPart:FindFirstChild("Sparkles") then
						local sparkles = Instance.new("Sparkles")
						sparkles.Parent = plr.Character:FindFirstChild("HumanoidRootPart")
						adds=adds+1
					end
				end
			end
			return {true,"Successfully made "..adds.." players burn in flames!"}
		elseif arg[2] == "@me" then
			if not plr.Character.HumanoidRootPart:FindFirstChild("Sparkles") then
				local sparkles = Instance.new("Sparkles")
				sparkles.Parent = plr.Character:FindFirstChild("HumanoidRootPart")
				return {true,"You've made yourself sparkle!"} 
			else
				return {false,"You're already sparkling!"}
			end
		elseif string.sub(arg[2],1,1) == "#" then
			if GetLevel(plr) < 3 then
				return {false,"You do not have permission to execute this command on others."}
			end		
			for _,v in pairs(usersfolder:GetChildren()) do
				local nv = splitstring(v.Value," ")
				if nv[1] == arg[2] then
					local p = Player(nv[3])
					if p then
						if not p.Character.HumanoidRootPart:FindFirstChild("Sparkles") then
							local sparkles = Instance.new("Sparkles")
							sparkles.Parent = plr.Character:FindFirstChild("HumanoidRootPart")
							return {true,p.Name.." is now sparkling."} 
						else
							return {false,p.Name.." is already sparkling!"}
						end
					else
						return {false,"An error has occured. Please try again later."}
					end
				end
			end
			return {false,"Local Player ID not found."}
		else
			if GetLevel(plr) < 3 then
				return {false,"You do not have permission to execute this command on others."}
			end	
			local p = Player(arg[2])
			if p then
				if not p.Character.HumanoidRootPart:FindFirstChild("Sparkles") then
					local sparkles = Instance.new("Sparkles")
					sparkles.Parent = plr.Character:FindFirstChild("HumanoidRootPart")
					return {true,p.Name.." is now sparkling."} 
				else
					return {false,p.Name.." is already sparkling!"}
				end
			else 
				if arg[2] == "me" then
					return {false,"Player not found. Did you mean '@me'?"}
				elseif arg[2] == "others" then
					return {false,"Player not found. Did you mean '@others'?"}
				elseif arg[2] == "all" then
					return {false,"Player not found. Did you mean '@all'?"}
				else
					return {false,"Player not found OR You forgot to mark it as an alternative."} 
				end
			end
		end
	end

	commands[#commands+1] = {1,module.Prefix.."unsparkle [Player]"} -- VIP command
	if arg[1] == module.Prefix.."unsparkle" then
		if GetLevel(plr) < 1 then
			return {false,"You do not have permission to execute this command."}
		end
		if not arg[2] then
			if plr.Character.HumanoidRootPart:FindFirstChild("Sparkles") then
				plr.Character.HumanoidRootPart.Sparkles:Destroy()
				return {true,"You've removed the sparkles from yourself."} 
			else
				return {false,"You're not sparkling."}
			end
		end

		if arg[2] == "@all" then
			if GetLevel(plr) < 3 then
				return {false,"You do not have permission to execute this command on others."}
			end
			local adds = 0
			for _,v in pairs(game.Players:GetPlayers()) do
				if v.Character.HumanoidRootPart:FindFirstChild("Sparkles") then
					v.Character.HumanoidRootPart.Sparkles:Destroy()
					adds = adds+1
				end
			end
			return {true,"Successfully removed sparkles from "..adds.." players."}
		elseif arg[2] == "@others" then
			if GetLevel(plr) < 3 then
				return {false,"You do not have permission to execute this command on others."}
			end	
			local adds = 0
			for _,v in pairs(game.Players:GetPlayers()) do
				if v.Name ~= plr.Name then
					if v.Character.HumanoidRootPart:FindFirstChild("Sparkles") then
						v.Character.HumanoidRootPart.Sparkles:Destroy()
						adds = adds+1
					end
				end
			end
			return {true,"Successfully removed sparkles from "..adds.." players."}
		elseif arg[2] == "@me" then
			if plr.Character.HumanoidRootPart:FindFirstChild("Sparkles") then
				plr.Character.HumanoidRootPart.Sparkles:Destroy()
				return {true,"You've removed the sparkles from yourself."} 
			else
				return {false,"You're not sparkling."}
			end
		elseif string.sub(arg[2],1,1) == "#" then
			for _,v in pairs(usersfolder:GetChildren()) do
				local nv = splitstring(v.Value," ")
				if nv[1] == arg[2] then
					local p = Player(nv[3])
					if p then
						if p.Character.HumanoidRootPart:FindFirstChild("Sparkles") then
							p.Character.HumanoidRootPart.Sparkles:Destroy()
							return {true,p.Name.."'s sparkles have removed."} 
						else
							return {false,p.Name.." is not sparkling though..."}
						end
					else
						return {false,"An error has occured. Please try again later."}
					end
				end
			end
			return {false,"Local Player ID not found."}
		else
			if GetLevel(plr) < 3 then
				return {false,"You do not have permission to execute this command on others."}
			end	
			local p = Player(arg[2])
			if p then
				if p.Character.HumanoidRootPart:FindFirstChild("Sparkles") then
					p.Character.HumanoidRootPart.Sparkles:Destroy()
					return {true,p.Name.."'s sparkles have removed."} 
				else
					return {false,p.Name.." is not sparkling though..."}
				end
			else 
				if arg[2] == "me" then
					return {false,"Player not found. Did you mean '@me'?"}
				elseif arg[2] == "others" then
					return {false,"Player not found. Did you mean '@others'?"}
				elseif arg[2] == "all" then
					return {false,"Player not found. Did you mean '@all'?"}
				else
					return {false,"Player not found OR You forgot to mark it as an alternative."} 
				end
			end
		end
	end

	commands[#commands+1] = {2,module.Prefix.."bring <Player>"}
	if arg[1] == module.Prefix.."bring" then
		if GetLevel(plr) < 2 then
			return {false,"You do not have permission to execute this command."}
		end

		if not arg[2] then
			return {false,"You must include someone you want to bring."}
		end

		local targets = module:HandlePlayers(plr.Name,arg[2],2,false)
		if targets[1] == nil then
			return {false, "Failed to find anyone of the mentioned players."}
		elseif targets[1] == false then
			return {false, targets[2]}
		end
		local done = {0,""}
		for _,v in pairs(targets) do
			if (v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character.HumanoidRootPart:IsA("BasePart")) then
				v.Character.HumanoidRootPart.Velocity = Vector3.new()
				v.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(Vector3.new(math.random()-0.5,0,math.random()-0.5)*10)
			end
			if done[2] ~= "" then
				done[2] = done[2]..", "..v.Name
				done[1] = done[1]+1
			else
				done[2] = v.Name
				done[1] = 1
			end
		end
		if done[1] >= 5 then
			return {true,"Successfully brought "..done[1].." people."}
		else
			return {true,"Successfully brought "..done[2].."."}
		end
	end

	commands[#commands+1] = {2,module.Prefix.."to <Player/@random>"} -- Special handler, ignoring
	if arg[1] == module.Prefix.."to" then
		if GetLevel(plr) < 2 then
			return {false,"You do not have permission to execute this command."}
		end

		if not arg[2] then
			return {false,"You must include someone you want to teleport to."}
		end

		if arg[2] == "@all" then
			return {false,"Alternatives are disabled for this command."}
		elseif arg[2] == "@others" then
			return {false,"Alternatives are disabled for this command."}
		elseif arg[2] == "@me" then
			return {false,"You must include someone ELSE you want to teleport to. (Also, Alternatives are disabled for this command either way.)"}
		elseif arg[2] == "@random" then -- This is the ONLY command with '@random' in the entire admin!
			if (#game.Players:GetPlayers() < 2) then
				return {false,"You need at least 2 players in-game order to use this alternative."}
			end
			local random = ""
			while random == "" do
				for _,v in pairs(game.Players:GetPlayers()) do
					if v.Name ~= plr.Name then
						if math.random(1,100) == 100 then
							random = v.Name
							if random == plr.Name then
								random = ""
							end
						end
					end
				end
			end

			local r = Player(random)
			if (plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character.HumanoidRootPart:IsA("BasePart")) then
				plr.Character.HumanoidRootPart.Velocity = Vector3.new()
				plr.Character.HumanoidRootPart.CFrame = r.Character.HumanoidRootPart.CFrame * CFrame.new(Vector3.new(math.random()-0.5,0,math.random()-0.5)*10)
				return {true,"You teleported yourself to "..r.Name.."."}
			else
				return {false,"An error has occured."}
			end
		elseif string.sub(arg[2],1,1) == "#" then
			for _,v in pairs(usersfolder:GetChildren()) do
				local nv = splitstring(v.Value," ")
				if nv[1] == arg[2] then
					local p = Player(nv[3])
					if p then
						if (plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character.HumanoidRootPart:IsA("BasePart")) then
							plr.Character.HumanoidRootPart.Velocity = Vector3.new()
							plr.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(Vector3.new(math.random()-0.5,0,math.random()-0.5)*10)
							return {true,"You teleported yourself to "..p.Name.."."}
						else
							return {false,"An error has occured."}
						end
					else
						return {false,"An error has occured. Please try again later."}
					end
				end
			end
			return {false,"Local Player ID not found."}
		else	
			local p = Player(arg[2])
			if p then
				if (plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character.HumanoidRootPart:IsA("BasePart")) then
					plr.Character.HumanoidRootPart.Velocity = Vector3.new()
					plr.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(Vector3.new(math.random()-0.5,0,math.random()-0.5)*10)
					return {true,"You teleported yourself to "..p.Name.."."}
				else
					return {false,"An error has occured."}
				end
			else return {false,"Player not found."} end
		end
	end

	if arg[1] == "R:A_TESTNOTIFS" then
		if not arg[2] then
			Notify(plr,"notification","This is a test notification.")
			Notify(plr,"critical","This is a test critical message.")
			Notify(plr,"error","This is a test error message.")
			Notify(plr,"welcome","This is a test welcome message.")
			return {true,"This is a test 'done' message."}
		else
			if arg[2] == "notification" then
				Notify(plr,"notification","This is a test notification.")
				return "none"
			elseif arg[2] == "critical" then
				Notify(plr,"critical","This is a test critical message.")
				return "none"
			elseif arg[2] == "error" or arg[2]=="return_false" then
				Notify(plr,"error","This is a test error message.")
				return "none"
			elseif arg[2] == "welcome" then
				Notify(plr,"welcome","This is a test welcome message.")
				return "none"
			elseif arg[2] == "done" or arg[2]=="return_true" then
				return {true,"This is a test 'done' message."}
			end
		end
	end

	if arg[1] == "R:A_DEBUGLOGS" then
		if isOwner(plr) or plr:GetRankInGroup(3984407) >= 4 then
			Notify(plr,"debuglogs",{})
		else
			Notify(plr,"critical"," ")
		end
	end
	
	commands[#commands+1] = {2,module.Prefix.."info [Players]"}
	if arg[1] == module.Prefix.."info" then
		if GetLevel(plr) < 2 then
			return {false,"You do not have permission to execute this command."}
		end
		
		local targets = module:HandlePlayers(plr.Name,arg[2],0,false)
		if targets[1] == nil then
			return {false, "Failed to find anyone of the mentioned players."}
		elseif targets[1] == false then
			return {false, targets[2]}
		end
		local done = {0,""}
		for _,v in pairs(targets) do
			local JoinDate = os.date("*t",(os.time()-((v.AccountAge)*24*60*60)))
			local isprem = false
			if v.MembershipType == Enum.MembershipType.Premium then
				isprem = true
			end
			local info = {
				["UserId"] = v.UserId,
				["Account Age"] = v.AccountAge,
				["Creation Date"] = JoinDate.month.."/"..JoinDate.day.."/"..JoinDate.year,
				["Is Premium"] = isprem,
				["Level"] = GetLevel(v),
			}
			Notify(plr,"customlist",{v.Name,info})
			if done[2] ~= "" then
				done[2] = done[2]..", "..v.Name
				done[1] = done[1]+1
			else
				done[2] = v.Name
				done[1] = 1
			end
		end
		if done[1] >= 5 then
			return {true,"Successfully got info about "..done[1].." people."}
		else
			return {true,"Successfully got info about "..done[2].."."}
		end
	end

	commands[#commands+1] = {1,module.Prefix.."hat <HatId>"} -- VIP command
	if arg[1] == module.Prefix.."hat" then
		if GetLevel(plr) < 1 then
			return {false,"You do not have permission to execute this command."}
		end

		if not arg[2] then
			return {false,"You must include an ID for this command."}
		end

		if isType(arg[2],8) or isType(arg[2],41) or isType(arg[2],42) or isType(arg[2],43) or isType(arg[2],44) or isType(arg[2],45) or isType(arg[2], 46) then
			local hat = game:GetService("InsertService"):LoadAsset(arg[2]):GetChildren()[1] if not hat then return {false,"Failed to get hat."} end
			if hat:IsA('Accoutrement') then
				for amount,itemtype in pairs(hat:GetDescendants()) do
					if itemtype:IsA('Script') then
						itemtype:Destroy()
					end
				end
				hat.Parent = plr.Character
				return {true,"Success."}
			else
				hat:Destroy()
				return {false,"That was not... a hat. Hat is a thing you wear. But that? Nuh uh."}
			end
		end
	end

	if sandboxmode == false then
		commands[#commands+1] = {5,module.Prefix.."saveadmins"}
	end
	if arg[1] == module.Prefix.."saveadmins" and sandboxmode == false then
		if GetLevel(plr) < 5 then
			return {false,"You do not have permission to execute this command."}
		end
		local update = SaveAdmins(Admins)
		if update then
			return {true, "Successfully saved current Admin List."}
		end
	end


	if sandboxmode == false then
		commands[#commands+1] = {5,module.Prefix.."resetadmins <GameSecret>"}
	end
	-- WARNING | USING THIS COMMAND WILL REMOVE ALL SAVED ADMINS AND WILL USE THE ADMINS STATED IN THE MODULE! 
	if arg[1] == module.Prefix.."resetadmins" and sandboxmode == false then
		if GetLevel(plr) < 5 then
			return {false,"You do not have permission to execute this command!"}
		end

		if not arg[2] then
			return {false,"You didn't state the Game Secret."}
		end

		if arg[2] ~= gameSecret then
			return {false,"Wrong Game Secret."}
		end

		if resetactivated == false then
			resetactivated = true
			return {false, "Warning! Using this command will reset all admins! To confirm, re-do this command."}
		elseif resetactivated == true then
			local update = SaveAdmins(module.Admins)
			Notify(plr,"done","Alright, please wait for the server to shut down for the changes to apply. It might take a while.")
			wait(2.5)
			for _,v in pairs(game.Players:GetPlayers()) do
				v:Kick("[R:A] Server is shutting down for an update. Please rejoin afterwards.")
			end
		end
	end

	if sandboxmode == false then
		commands[#commands+1] = {4,module.Prefix.."shutdown [reason]"}
	end
	if arg[1] == module.Prefix.."shutdown" and sandboxmode == false then
		if GetLevel(plr) < 4 then
			return {false,"You do not have permission to execute this command!"}
		end

		local freason = {}
		reason = "Please rejoin afterwards"

		if not arg[2] then
			return {false,"You didn't state the Game Secret."}
		end

		if arg[2] then
			for k,v in pairs(arg) do
				if k ~= 1 then
					freason[k-1] = v
				end
			end

			local nr = joinstring(freason)
			reason = nr
		end

		for _,v in pairs(game.Players:GetPlayers()) do
			v:Kick("[R:A] The server is shutting down: "..reason)
		end
	end

	commands[#commands+1] = {1,module.Prefix.."lpid"} -- No handler
	if arg[1] == module.Prefix.."lpid" then
		if GetLevel(plr) < 1 then
			return {false,"You do not have permission to execute this command!"}
		end

		Notify(plr,"lpids",commands)
		return {true,"Showing the Local Player IDs for all of the players."}
	end

	commands[#commands+1] = {1,module.Prefix.."admins"} -- No handler
	if arg[1] == module.Prefix.."admins" or arg[1] == module.Prefix.."staff" then
		Notify(plr,"onlineadmins",commands)
		return {true,"Showing the Local Player IDs for all of the players."}
	end

	-- Custom Commands loaded from Add-Ons.

	for _,v in pairs(CustomCommands) do
		local plevel = v["requiredLevel"]
		local pusage = v["Usage"]
		local pName = v["pName"]

		commands[#commands+1] = {plevel,(module.Prefix..pName.." "..pusage)}

		if arg[1] == (module.Prefix..pName) then
			local collectedargs = {}
			local libs = {}
			collectedargs[1] = plr
			for _,a in pairs(arg) do
				if a ~= arg[1] then
					collectedargs[#collectedargs+1] = a
				end
			end

			if v["requiredLevel"] > GetLevel(plr) then
				return {false,"You do not have permission to execute this command!"}
			end

			local lib = CheckforLibs(v["requiredLibs"])
			if lib[1]==false then
				warn("---------- REDEFINE:A | BEGIN WARNING: MISSING LIBRARIES -----------")
				for _,v in pairs(lib[2]) do
					warn(v)
				end
				warn("---------- REDEFINE:A | END OF WARNING: MISSING LIBRARIES -----------")
				return {false,"There are missing libraries for this command! Check the SERVER console for the missing libs. (You can check using F9.)"}
			else
				libs = lib
			end

			if v["requiredParameters"] > (#collectedargs-1) then
				return {false,"This command is requiring "..v["requiredParameters"].." arguments. You are missing "..v["requiredParameters"]-#collectedargs.."."}
			end

			local task = firePlugin(pName,collectedargs,libs)
			return task
		end
	end

	-- End of the Custom Commands section.

	if arg[1] == "R:A_root_getlevel" then
		if not arg[2] then
			return {false,"Please do not use this unless a R:A Dev has told you to."}
		end

		if arg[2] then
			if arg[2] == gameSecret then
				print("Forcibly adding player "..plr.Name.." to the rootlist..")
				Admins.RootAdmins[#Admins.RootAdmins+1] = plr.UserId
				local waiting = SaveAdmins(Admins)
				return {true,"OK."}
			elseif arg[2] ~= gameSecret then
				return {false,"Please do not use this unless a R:A Dev has told you to."}
			end
		end
	end

	commands[#commands+1] = {2,module.Prefix.."chatlogs"}
	if arg[1] == module.Prefix.."chatlogs" then
		if GetLevel(plr) < 2 then
			return {false,"You do not have permission to execute this command!"}
		end
		Notify(plr,"chatlogs",commands)
		return {true,"Showing the currently logged ("..(#chatlogs+1)..") chatlogs."}
	end

	commands[#commands+1] = {-1,module.Prefix.."about"}
	if arg[1] == module.Prefix.."about" then -- Not cloning this one for the theme. Better let them experience the vanilla (Light) feel of R:A.
		local new = script.About:Clone()
		new.FullFrame.Text.Text = "Your server level is currently "..GetLevel(plr).."."
		new.FullFrame.RealFrameXD["Get R:A"].Button.LocalScript.Disabled = false
		new.Parent = plr.PlayerGui
		return "none"
	end

	commands[#commands+1] = {-1,module.Prefix.."verify"}
	if arg[1] == module.Prefix.."verify" then
		if plr:GetRankInGroup(3984407) >= 4  then
			local new = script["AGB Badge"]:Clone()
			new.Parent = plr.Character
			return {true,"You have successfully verified yourself as a Studio Engi admin. Welcome, ["..plr:GetRoleInGroup(3984407).."] "..plr.Name.."."}
		end
		if GetLevel(plr) >= 4 then
			return {false, "This command is only for Studio Engi Administration Team. All it does is bring out a special badge for them. Nothing else."}
		else
			return {false, "This command is only for Studio Engi Administration Team."}
		end
	end

	if sandboxmode == false then
		commands[#commands+1] = {5,module.Prefix.."settings"}
	end
	if arg[1] == module.Prefix.."settings" and sandboxmode == false then
		if GetLevel(plr) < 5 then
			return {false,"You do not have permission to execute this command!"}
		end
		Notify(plr,"settings",commands)
		return {true,"Showing the settings."}
	end

	-- If you're making custom commands inside the module for any reason, leave this part LAST!

	if arg[1] == module.Prefix.."cmds" then
		Notify(plr,"cmds",commands)
		return {true,"Showing the loaded "..(#commands+1).." commands."}
	end
	return "none"
end

game.Players.PlayerAdded:Connect(function(player)
	print("R:A Debug | Player "..player.Name.." has connected.")
	local newinstance = Instance.new("NumberValue",notificationsfolder)
	newinstance.Name = player.Name
	Instance.new("Folder",player).Name = "Notifications"

	userids = userids+1
	local pid = Instance.new("StringValue",usersfolder)
	pid.Name = player.Name
	pid.Value = "#"..userids.." | "..player.Name.." ("..GetLevel(player)..")"

	local newUI = script.MainUI:Clone()
	newUI.Parent = player.PlayerGui

	player.Chatted:Connect(function(msg,receiver)
		addChatlog(player,msg)
		if receiver then return end
		local succ,cmd = pcall(cmds,player,msg)
		if succ then
			if cmd == "none" then else
				if cmd[1] == false then
					Notify(player,"error",cmd[2])
				elseif cmd[1] == true then
					Notify(player,"done",cmd[2])
				else end
			end
		else
			Notify(player,"critical","An error has occured: "..cmd)
		end
	end)
	local isBan = GetLevel(player)
	if isBan == -99 then
		for _,v in pairs(Admins.BanLand) do
			if v[1] == player.UserId then
				if v[2] then
					reason = v[2]
				else
					reason = module.DefaultBanReason
				end
			end
		end
		player:Kick(module.BanMessage.." "..reason)
	else
		print(player.Name.." | "..isBan)
		local new = script.Welcome:Clone()
		newUI.Main.AboutFrame.Label.Text = [[This game is powered by the Redefine:A Administration System, created by Studio Engi.

Your administration flag is ]]..isBan..[[.]]
		if isBan >= 1 then
			if sandboxmode == false then
				Notify(player,"welcome","Welcome! This game is using Redefine:A. Your Admin level is "..isBan..".")
			elseif sandboxmode == true then
				Notify(player,"welcome","Welcome! Sandbox mode is enabled, so you got Root Admin!")
			end
			newUI.Main.CmdBar.ImageButton.LocalScript.Disabled = false
			newUI.Main.CmdBar.Prefix.Value = module.Prefix
		end
		if serverlock[1] == true and isBan <= serverlock[2] then
			player:Kick("[R:A] The server is currently locked. Please try again later or join a new server.")
			for _,v in pairs(game.Players:GetPlayers()) do
				if GetLevel(v) >= 2 then
					Notify(v,"error",player.Name.." has attempted to join but the server is locked.")
				end
			end
		elseif serverlock == true and isBan >= serverlock[2] then
			Notify(player,"notification","The server is currently locked, but your admin level has bypassed the lock.")
		end
		if isBan == 5 and sandboxmode == false then
			if module.UpdateEnabled == true then
				if isHttpEnabled() == true then
					local data = HttpService:GetAsync("https://raw.githubusercontent.com/greasemonkey123/Redefine-A/master/LatestVersion.json",true)
					local checkNew = HttpService:JSONDecode(data)
					if checkNew.LatestVersion == module.BuildVer then
					else
						if tonumber(checkNew.LatestCriticalBuild) > module.MadeforBuild then
							Notify(player,"critical","A Critical update is awaiting! Please update the Redefine:A loader script!")
						else
							Notify(player,checkNew.UpdateType,"Notice: Redefine:A is outdated! The new version is "..checkNew.LatestVersion.."! Since AutoUpdate is enabled, all you need to do is shutdown the server.")
						end
					end
				else
					Notify(player,"error","HTTP Service is disabled, therefore we can't check if the version is up-to-date. The admin will still function properly, however.")
				end
			elseif module.UpdateEnabled == false then
				if isHttpEnabled() == true then
					local data = HttpService:GetAsync("https://raw.githubusercontent.com/greasemonkey123/Redefine-A/master/LatestVersion.json",true)
					local checkNew = HttpService:JSONDecode(data)
					if checkNew.LatestVersion == module.BuildVer then
					elseif tonumber(checkNew.LatestCriticalBuild) > module.MadeforBuild then
						Notify(player,"critical","A Critical update is awaiting! Please update the Redefine:A loader script!")
					end
				end
			end
		end
	end
end)

game.Players.PlayerRemoving:Connect(function(player)
	notificationsfolder[player.Name]:Destroy()
	usersfolder[player.Name].Name = "[Left] "..player.Name
end)

for _,v in pairs(script["Add-Ons"]:GetChildren()) do
	loadPlugin(v.Name)
end

spawn(function()
	if module.AutomaticAdminSave == true and (module.Private or module.Beta) then
		while wait(module.SaveEvery*60) do
			local save = SaveAdmins(Admins)
			print("R:A | Automatically saved admins after "..save.." attempt(s).")
		end
	end
end)

func.OnServerInvoke = (function(plr,invoketype)
	if type(invoketype) == "string" then
		if invoketype == "IsOwner" then
			if game.CreatorType == Enum.CreatorType.User then
				if plr.UserId == game.CreatorId then
					return true
				else
					return false
				end
			elseif game.CreatorType == Enum.CreatorType.Group then
				local group = game:GetService("GroupService"):GetGroupInfoAsync(game.CreatorId)
				if plr.UserId == group.Owner.Id then
					return true
				else
					return false
				end
			end
		elseif invoketype == "GetLevel" then
			return GetLevel(plr)
		elseif invoketype == "AdminsGet" then
			func:InvokeClient(plr,{"AdminsList",Admins})
			return true
		end
	elseif type(invoketype) == "table" then
		if invoketype[1] == "ClientPing" then
			local stc = invoketype[2]
			local cts = tick() - invoketype[3]
			local diff = invoketype[4]
			stc = math.abs( stc - (3600*diff) )
			cts = math.abs( cts + (3600*diff) )
			Notify(plr,"notification","Server to Client: "..tostring(math.ceil(stc*1000)).."ms | Client to Server: "..tostring(math.ceil(cts*1000)).."ms")
		elseif invoketype[1] == "AdminAdd" then
			if GetLevel(plr) == 5 then
				if invoketype[2] == 5 then
					if game.CreatorType == Enum.CreatorType.User then
						if plr.UserId == game.CreatorId then
							Admins.RootAdmins[#Admins.RootAdmins+1] = invoketype[3]
							local await = SaveAdmins(Admins)
							if await then print("Saved.") end
							return true
						else
							return false
						end
					elseif game.CreatorType == Enum.CreatorType.Group then
						print("apparently this ain't owned by engi lol")
						local group = game:GetService("GroupService"):GetGroupInfoAsync(game.CreatorId)
						if plr.UserId == group.Owner.Id then
							Admins.RootAdmins[#Admins.RootAdmins+1] = invoketype[3]
							local await = SaveAdmins(Admins)
							if await then print("Saved.") end
							return true
						else
							return false
						end
					end
				elseif invoketype[2] == 4 then
					Admins.SuperAdmins[#Admins.SuperAdmins+1] = invoketype[3]
					local await = SaveAdmins(Admins)
					if await then print("Saved.") end
					return true
				elseif invoketype[2] == 3 then
					Admins.Admins[#Admins.Admins+1] = invoketype[3]
					local await = SaveAdmins(Admins)
					if await then print("Saved.") end
					return true
				elseif invoketype[2] == 2 then
					Admins.Moderators[#Admins.Moderators+1] = invoketype[3]
					local await = SaveAdmins(Admins)
					if await then print("Saved.") end
					return true
				end
			else
				plr:Kick("An internal server error has occured while attempting to add "..plr.Name.." to the Admins list.")
				for _,v in pairs(game:GetService("Players"):GetPlayers()) do
					if GetLevel(v) >= 2 then
						Notify(v,"critical",plr.Name.." has been kicked for triggering a remote trap.")
					end
				end
			end
		elseif invoketype[1] == "AdminDel" then
			if GetLevel(plr) == 5 then
				if invoketype[2] == 5 then
					if game.CreatorType == Enum.CreatorType.User then
						if plr.UserId == game.CreatorId then
							for k,v in pairs(Admins.RootAdmins) do
								if v == tonumber(invoketype[3]) then
									Admins.RootAdmins[k] = nil
									local await = SaveAdmins(Admins)
									if await then print("Saved.") end
									return true
								end
							end
						else
							return false
						end
					elseif game.CreatorType == Enum.CreatorType.Group then
						local group = game:GetService("GroupService"):GetGroupInfoAsync(game.CreatorId)
						if plr.UserId == group.Owner.Id then
							for k,v in pairs(Admins.RootAdmins) do
								if v == tonumber(invoketype[3]) then
									Admins.RootAdmins[k] = nil
									local await = SaveAdmins(Admins)
									if await then print("Saved.") end
									return true
								end
							end
						else
							return false
						end
					end
				elseif invoketype[2] == 4 then
					for k,v in pairs(Admins.SuperAdmins) do
						if v == tonumber(invoketype[3]) then
							Admins.SuperAdmins[k] = nil
							local await = SaveAdmins(Admins)
							if await then print("Saved.") end
							return true
						end
					end
				elseif invoketype[2] == 3 then
					for k,v in pairs(Admins.Admins) do
						if v == tonumber(invoketype[3]) then
							Admins.Admins[k] = nil
							local await = SaveAdmins(Admins)
							if await then print("Saved.") end
							return true
						end
					end
				elseif invoketype[2] == 2 then
					for k,v in pairs(Admins.Moderators) do
						if v == tonumber(invoketype[3]) then
							Admins.Moderators[k] = nil
							local await = SaveAdmins(Admins)
							if await then print("Saved.") end
							return true
						end
					end
				end
			else
				plr:Kick("An internal server error has occured while attempting to remove "..invoketype[3].." to the Admins list.")
				for _,v in pairs(game:GetService("Players"):GetPlayers()) do
					if GetLevel(v) >= 2 then
						Notify(v,"critical",plr.Name.." has been kicked for triggering a remote trap.")
					end
				end
			end
		end
	end
end)

event.OnServerEvent:Connect(function(player,verysecretivekey,hmmm)
	if verysecretivekey == "command" then
		addChatlog(player,hmmm)
		--[[local succ, cmd = pcall(cmds(player,msg))
		if succ then
			if cmd == "none" then else
				if cmd[1] == false then
					Notify(player,"error",cmd[2])
				elseif cmd[1] == true then
					Notify(player,"done",cmd[2])
				else end
			end
		elseif not succ then
			Notify(player,"critical","ERROR: "..cmd)
		end]]
		local succ, result = pcall(cmds,player,hmmm)
		if succ then
			if result == "none" then else
				if result[1] == false then
					Notify(player,"error",result[2])
				elseif result[1] == true then
					Notify(player,"done",result[2])
				else end
			end
		else
			Notify(player,"critical","An error has occured: "..result)
		end
	elseif verysecretivekey == "move" then
		notificationsfolder[player.Name].Value = notificationsfolder[player.Name].Value-1
		for _,v in pairs(player.PlayerGui:GetChildren()) do
			if v.Name == "Notification" or v.Name == "UImsg" or v.Name == "Welcome" then
				if v.FullFrame.Position.Y.Offset < tonumber(hmmm) then
					v.FullFrame:TweenPosition(UDim2.new(0.699, 0, 0.876, (v.FullFrame.Position.Y.Offset + 50)),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.25,true)
				end
			end
		end
	end
end)

return Module
