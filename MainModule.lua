--[[																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																									--]]local Module = {};local module = {};--[[	OH NO																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																					Hello!
   _____ _             _ _         ______             _ 
  / ____| |           | (_)       |  ____|           (_)
 | (___ | |_ _   _  __| |_  ___   | |__   _ __   __ _ _ 
  \___ \| __| | | |/ _` | |/ _ \  |  __| | '_ \ / _` | |
  ____) | |_| |_| | (_| | | (_) | | |____| | | | (_| | |
 |_____/ \__|\__,_|\__,_|_|\___/  |______|_| |_|\__, |_|
	            	                        __/ |  
       						|___/   

--------------------------------------------------------------

Copyright Protected © Studio Engi, EngiAdurite and the Lead Contributors, 2020.
Refer to the Internal Use Info & License for more info.

Please note, using any of this material without permission might result in a DMCA takedown!

Warning: Redefine:A Plugins WILL NOT be applicable for Copyright, and must be open source!

--------------------------------------------------------------

All credits are in the loader.
This is the first private build available for testing, and everyone receives a coded copy.
Leak, and you will never receive those copies again. :)

Copy for: EngiAdurite

--------------------------------------------------------------

DISCLAIMER
----------
If the creator of the model is not "Studio Engi" or "EngiAdurite", then the model is FAKE!

Make sure you only get the admin from the official site (studioengi.me) or from EngiAdurite to avoid backdoors!

If you got the model, but the model wasn't published by EngiAdurite or Studio Engi,
Please report the incident to EngiAdurite on Roblox or Discord (Sezei#3061).


Note for Developers
-------------------
If you're planning to create custom plugins, make sure to use the PLUGINSTORAGE
part of R:A to save plugin data. You can use the manageData function to do so.

--------------------------------------------------------------
--]]

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

function Module:Load(Prefix,SilentEnabled,Admins,GroupAdmin,VIPAdmin,Theme,BanMessage,DefaultBanReason,EnableGlobalBanList,AutomaticAdminSave,SaveEvery,VIPAllowed,LegacyUI,AutoUpdate)
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
	gameSecret = "RedefineA_"..game.CreatorId
	
	if module.EnableGlobalBanList == true then
		require(2498483497)
	end
	
	if not Admins or Admins == nil then
		local Save = db:Save("AdminList",module.Admins)
		Save:wait()
		Admins = module.Admins
	end
	
	module.BuildVer = "v03-build4"
	module.BuildId = 58
	
	print("Redefine:A has been loaded! | Prefix; "..module.Prefix.." | Game Secret; "..gameSecret.." (Do not share it!) | R:A Version; "..module.BuildVer)
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

gameSecret = "Private_"..game.CreatorId

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
	local s = pcall(function() --Pcall will return two results from a function. Boolean if the function executed successfully, and the error if applicable.
		game:GetService('HttpService'):GetAsync('http://www.google.com/') --GetAsync will return an error if HttpEnabled is disabled, or by the off chance google actually goes offline.
	end)
	return s --This will be true or false depending if the GetAsync yeild function ran successfully or not.
end


function GetLevel(player)
	if Admins == nil or not Admins then Admins = module.Admins end
	local group = module.GroupAdmin
	for _,a in pairs(Admins) do
		for _,b in pairs(Admins.RootAdmins) do
			local owner = false
			if Enum.CreatorType == Enum.CreatorType.User then
				if player.UserId == game.CreatorId then
					return 5
				end
			elseif Enum.CreatorType == Enum.CreatorType.Group then
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
end

function module:GetLevel(player)
	if Admins == nil or not Admins then Admins = module.Admins end
	for _,a in pairs(Admins) do
		for _,b in pairs(Admins.RootAdmins) do
			local owner = false
			if Enum.CreatorType == Enum.CreatorType.User then
				if player.UserId == game.CreatorId then
					return 5
				end
			elseif Enum.CreatorType == Enum.CreatorType.Group then
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
		new.Parent = player.PlayerGui.MainUI.Main
		new.Text = nmessage
		new.TextColor3 = Color3.new(0,0.666667,1)
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
		new.Visible = true
		new.Sound:Play()
		new.MouseButton1Click:Connect(function()
			new.Click:Play()
			new.Visible = false
			wait(1)
			new:Destroy()
		end)
	elseif ntype == "done" then
		local new = player.PlayerGui.MainUI.Main.NotificationButton:Clone()
		new.Parent = player.PlayerGui.MainUI.Main
		new.Text = nmessage
		new.TextColor3 = Color3.new(0.666667, 1, 0.498039)
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
		new.Visible = true
		new.Sound:Play()
		new.MouseButton1Click:Connect(function()
			new.Click:Play()
			new.Visible = false
			wait(1)
			new:Destroy()
		end)
	elseif ntype == "error" then
		local new = player.PlayerGui.MainUI.Main.NotificationButton:Clone()
		new.Parent = player.PlayerGui.MainUI.Main
		new.Text = nmessage
		new.TextColor3 = Color3.new(1,0.666667,0)
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
		new.Visible = true
		new.Error:Play()
		new.MouseButton1Click:Connect(function()
			new.Click:Play()
			new.Visible = false
			wait(1)
			new:Destroy()
		end)
	elseif ntype == "critical" then -- Added in 03. Made for errors in the custom commands.
		local new = player.PlayerGui.MainUI.Main.NotificationButton:Clone()
		new.Parent = player.PlayerGui.MainUI.Main
		new.Text = nmessage
		new.TextColor3 = Color3.new(1, 1, 1)
		new.BackgroundColor3 = Color3.new(1,0.345098,0.345098)
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
		new.Visible = true
		new.Error.PlaybackSpeed = 0.7
		new.Error:Play()
		new.MouseButton1Click:Connect(function()
			new.Click:Play()
			new.Visible = false
			wait(1)
			new:Destroy()
		end)
	elseif ntype == "notification" then
		local new = player.PlayerGui.MainUI.Main.NotificationButton:Clone()
		new.Parent = player.PlayerGui.MainUI.Main
		new.Text = nmessage
		new.TextColor3 = Color3.new(1, 1, 1)
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
		new.Visible = true
		new.Notification:Play()
		new.MouseButton1Click:Connect(function()
			new.Click:Play()
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
		for i,v in pairs(nmessage) do
			pos = pos+1
			local bar = clone.ScrollingFrame.command:Clone()
			bar.Parent = clone.ScrollingFrame
			bar.Text = v[1].." | "..v[2]
			if tonumber(v[1]) <= GetLevel(player) then
				bar.TextColor3 = Color3.fromRGB(255, 255, 255)
			else
				bar.TextColor3 = Color3.fromRGB(155, 155, 155)
			end
			local newpos = pos*28
			bar.Position = UDim2.new(UDim.new(0.03,0),UDim.new(0,newpos))
			clone.ScrollingFrame.CanvasSize = UDim2.new(UDim.new(0,0),UDim.new(0,newpos))
		end
		clone.Parent = player.PlayerGui.MainUI
		clone.Title.Text = "Commands List"
		clone.Visible = true
	elseif ntype == "chatlogs" then
		local clone = player.PlayerGui.MainUI.ListUI:Clone()
		local pos = 0
		clone.ScrollingFrame.command.Visible = false
		local newt={}
		for i = 1, math.floor(#chatlogs/2) do
			local j = #chatlogs - i + 1
			newt[i], newt[j] = chatlogs[j], chatlogs[i]
		end
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
		clone.Parent = player.PlayerGui.MainUI
		clone.Title.Text = "Chatlogs"
		clone.Visible = true
	elseif ntype == "lpids" then
		local clone = player.PlayerGui.MainUI.ListUI:Clone()
		local pos = -1
		clone.ScrollingFrame.command.Visible = false
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
		clone.Parent = player.PlayerGui.MainUI
		clone.Title.Text = "Local User IDs"
		clone.Visible = true
	elseif ntype == "onlineadmins" then
		local clone = player.PlayerGui.MainUI.ListUI:Clone()
		local pos = -1
		clone.ScrollingFrame.command.Visible = false
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
		clone.Parent = player.PlayerGui.MainUI
		clone.Title.Text = "Staff Online"
		clone.Visible = true
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

function module:HandlePlayers(p, plrs, level)
	if plrs == "" or plrs == " " then
		return Player(p)
	end
	
	local newplrs = splitstring(plrs,",")
	local players = {}
	local executor = p
	local ismsg = false
	
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
		
		local targets = module:HandlePlayers(plr.Name,arg[2],2)
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
		
	commands[#commands+1] = {2,module.Prefix.."smite [Players]"}
	if arg[1] == module.Prefix.."smite" then
		if GetLevel(plr) < 2 then
			return {false,"You do not have permission to execute this command."}
		end
		
		local targets = module:HandlePlayers(plr.Name,arg[2],2)
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
	
	commands[#commands+1] = {3,module.Prefix.."kick <Players> [Reason]"}
	if arg[1] == module.Prefix.."kick" then
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
		
		local targets = module:HandlePlayers(plr.Name,arg[2],2)
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
		
		local targets = module:HandlePlayers(plr.Name,arg[2],2)
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
		
	commands[#commands+1] = {4,module.Prefix.."f3x / btools [Player]"}
	if arg[1] == module.Prefix.."f3x" or arg[1] == module.Prefix.."btools" then
		if GetLevel(plr) < 4 then
			return {false,"You do not have permission to execute this command."}
		end
		
		local targets = module:HandlePlayers(plr.Name,arg[2],2)
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
	
	commands[#commands+1] = {3,module.Prefix.."vip <Player>"} -- Not to be handled by the new handler.
	if arg[1] == module.Prefix.."vip" then
		if GetLevel(plr) < 3 then
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
	
	commands[#commands+1] = {4,module.Prefix.."mod <Player>"}
	if arg[1] == module.Prefix.."mod" then
		if GetLevel(plr) < 4 then
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
		if GetLevel(plr) < 4 then
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
		if GetLevel(plr) < 5 then
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
	
	commands[#commands+1] = {5,module.Prefix.."ban <Player> [Reason]"}
	if arg[1] == module.Prefix.."ban" then
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
		local targets = module:HandlePlayers(plr.Name,arg[2],2)
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
		
		local targets = module:HandlePlayers(plr.Name,arg[2],2)
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

		local targets = module:HandlePlayers(plr.Name,arg[2],2)
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
		
		local targets = module:HandlePlayers(plr.Name,arg[2],-1)
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
			
	commands[#commands+1] = {3,module.Prefix.."b / broadcast <Value>"} -- no handle
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
		
		local targets = module:HandlePlayers(plr.Name,arg[2],2)
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
			return {true,"Successfully notified "..done[1].." people."}
		else
			return {true,"Successfully notified "..done[2].."."}
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
	
	commands[#commands+1] = {1,module.Prefix.."hat <HatId>"} -- VIP command
	if arg[1] == module.Prefix.."hat" then
		if GetLevel(plr) < 1 then
			return {false,"You do not have permission to execute this command."}
		end
		
		if not arg[2] then
			return {false,"You must include an ID for this command."}
		end
		
		local LoadAsset = pcall(game.InsertService:LoadAsset(tonumber(arg[2])))
		local hat = LoadAsset:GetChildren()
		if #hat < 1 then
			return {false,"Failed to get hat. Please try again later or check for mis-copy."}
		end
		hat = hat[1]
		if not hat:IsA("Hat") and not hat:IsA("Accoutrement") and not hat:IsA("Accessory") then
			return {false, "This is not a hat! >:c"}
		end
		if hat:IsA("Accessory") then
			plr.Character.Humanoid:AddAccessory(hat:Clone());
			return {true,"Done!"}
		else
			hat:Clone().Parent = plr.Character
			return {true,"Done!"}
		end
	end
	
	commands[#commands+1] = {5,module.Prefix.."saveadmins"}
	if arg[1] == module.Prefix.."saveadmins" then
		if GetLevel(plr) < 5 then
			return {false,"You do not have permission to execute this command."}
		end
		local update = SaveAdmins(Admins)
		if update then
			return {true, "Successfully saved current Admin List."}
		end
	end
	
	commands[#commands+1] = {5,module.Prefix.."resetadmins <GameSecret>"} -- WARNING | USING THIS COMMAND WILL REMOVE ALL SAVED ADMINS AND WILL USE THE ADMINS STATED IN THE MODULE! 
	if arg[1] == module.Prefix.."resetadmins" then
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
	
	commands[#commands+1] = {2,module.Prefix.."chatlogs"}
	if arg[1] == module.Prefix.."chatlogs" then
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
		local cmd = cmds(player,msg)
		if cmd == "none" then else
			if cmd[1] == false then
				Notify(player,"error",cmd[2])
			elseif cmd[1] == true then
				Notify(player,"done",cmd[2])
			else end
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
			Notify(player,"welcome","Welcome! This game is using Redefine:A. Your Admin level is "..isBan..".")
			newUI.Main.CmdBar.ImageButton.LocalScript.Disabled = false
			newUI.Main.CmdBar.Prefix.Value = module.Prefix
		end
		if isBan == 5 then
			if module.UpdateEnabled == true then
				print("Module AutoUpdater is enabled! Checking if latest build is equal...")
				if isHttpEnabled() == true then
					print("HTTP is enabled.")
					local data = HttpService:GetAsync("https://raw.githubusercontent.com/greasemonkey123/Redefine-A/master/LatestVersion.json",true)
					local checkNew = HttpService:JSONDecode(data)
					if checkNew.LatestVersion == module.BuildVer then
					else
						if tonumber(checkNew.LatestCriticalBuild) > module.BuildId then
							Notify(player,"critical","A Critical update is awaiting! Please update the Redefine:A loader script!")
						else
							Notify(player,checkNew.UpdateType,"Notice: Redefine:A is outdated! The new version is "..checkNew.."!")
						end
					end
				else
					print("HTTP is disabled.")
					Notify(player,"error","HTTP Service is disabled, therefore we can't check if the version is up-to-date. The admin will still function properly, however.")
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
			print("R:A | Automatically saved admins after "..save.." attempts.")
		end
	end
end)

func.OnServerInvoke = (function(plr,invoketype)
	if invoketype == "GetLevel" then
		return GetLevel(plr)
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
		local result = cmds(player,hmmm)
		if result == "none" then else
			if result[1] == false then
				Notify(player,"error",result[2])
			elseif result[1] == true then
				Notify(player,"done",result[2])
			else end
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
