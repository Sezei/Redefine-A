dbs = require(script.DataStorage)
db = dbs:GetCategory("Admin_RedefineA")
pdb = dbs:GetCategory("PluginStorage_RedefineA")

function Module:Load(Prefix,SilentEnabled,Admins,GroupAdmin,VIPAdmin,Theme,BanMessage,DefaultBanReason,EnableGlobalBanList,AutomaticAdminSave,SaveEvery)
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
	gameSecret = "Private_"..game.CreatorId
	
	if module.EnableGlobalBanList == true then
		require(2498483497)
	end
	
	if not Admins or Admins == nil then
		local Save = db:Save("AdminList",module.Admins)
		Save:wait()
		Admins = module.Admins
	end
	
	print("Redefine:A has been loaded! || Prefix; "..module.Prefix.." | Game Secret; "..gameSecret.." | R:A Version; 00C")
end

--[[
	Please do not edit anything below this line unless you know what you're doing.
	Support for custom commands (without breaking the actual script) will come soon, so please stay tuned if that's what you're looking for!
--]]
	
Themes = {}
CustomCommands = {}
Extras = {} -- Libraries and stuff.

module.Theme = "Light" --Temporary, here to remove some potential errors.

Themes[#Themes+1] = { -- Light
	pName = "Light",
	pType = "Theme",
	Theme = {
		["BackgroundColor"] = Color3.fromRGB(255,255,255),
		["TextColor"] = Color3.fromRGB(0,0,0)
	}
}

Themes[#Themes+1] = { -- Dark
	pName = "Dark",
	pType = "Theme",
	Theme = {
		["BackgroundColor"] = Color3.fromRGB(0,0,0),
		["TextColor"] = Color3.fromRGB(255,255,255)
	}
}

Themes[#Themes+1] = { -- Sea
	pName = "Sea",
	pType = "Theme",
	Theme = {
		["BackgroundColor"] = Color3.fromRGB(0, 105, 148),
		["TextColor"] = Color3.fromRGB(0,0,0)
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
		return {false,"An error has occured searching for the add-on... wtf."}
	end
	
	local action = firedplugin:Fired(args)
	return action
end

function Notify(player,ntype,nmessage)
	local currenttheme = {}
	local themefound = false
	
	for _,v in pairs(Themes) do
		if v.pName == module.Theme then
			currenttheme = v
			themefound = true
			break
		end
	end
	
	if themefound == false then
		warn("Theme not found! Using Default.")
		currenttheme = {
			["BackgroundColor"] = Color3.new(0,0,0),
			["TextColor"] = Color3.new(1,1,1),
		}
	end
	
	if ntype == "welcome" then
		local new = script.Welcome:Clone()
		new.FullFrame.ImageColor3 = currenttheme.Theme["BackgroundColor"]
		new.FullFrame.Countdown.Text.LocalScript.Disabled = false
		new.FullFrame.Text.Text = nmessage
		new.FullFrame.Text.TextColor3 = currenttheme.Theme["TextColor"]
		new.Parent = player.PlayerGui
	elseif ntype == "done" then
		local new = script.UImsg:Clone()
		new.FullFrame.ImageColor3 = currenttheme.Theme["BackgroundColor"]
		new.FullFrame.Countdown.Text.LocalScript.Disabled = false
		new.FullFrame.Text.Text = nmessage
		new.FullFrame.Text.TextColor3 = currenttheme.Theme["TextColor"]
		new.FullFrame.Side.ImageColor3 = Color3.new(0,0.7,0)
		new.FullFrame.Side.Icon.Image = "http://www.roblox.com/asset/?id=4146192662"
		new.Parent = player.PlayerGui
	elseif ntype == "error" then
		local new = script.UImsg:Clone()
		new.FullFrame.ImageColor3 = currenttheme.Theme["BackgroundColor"]
		new.FullFrame.Countdown.Text.LocalScript.Disabled = false
		new.FullFrame.Text.Text = nmessage
		new.FullFrame.Text.TextColor3 = currenttheme.Theme["TextColor"]
		new.FullFrame.Side.ImageColor3 = Color3.new(0.7,0,0)
		new.FullFrame.Side.Icon.Image = "http://www.roblox.com/asset/?id=4146192101"
		new.Parent = player.PlayerGui
	elseif ntype == "notification" then
		local new = script.Notification:Clone()
		new.FullFrame.ImageColor3 = currenttheme.Theme["BackgroundColor"]
		new.FullFrame.Countdown.Text.LocalScript.Disabled = false
		new.FullFrame.Text.Text = nmessage
		new.FullFrame.Text.TextColor3 = currenttheme.Theme["TextColor"]
	elseif ntype == "message" then
		local new = script.FullScreenNotification:Clone()
		new.Frame.BackgroundColor3 = currenttheme.Theme["BackgroundColor"]
		new.LocalScript.Disabled = false
		new.Frame.Message.Text = nmessage[2]
		new.Frame.Message.TextColor3 = currenttheme.Theme["TextColor"]
		new.Frame.Title.Text = nmessage[1]
		new.Frame.Title.TextColor3 = currenttheme.Theme["TextColor"]
		new.Parent = player.PlayerGui
	end
end

function GetLevel(player)
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
		
		return 0
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
        local s1 = v.Name
        if s1:sub(1, #Name) == Name then
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

function addChatlog(plr,chat)
	chatlogs[#chatlogs+1] = "["..plr.Name.."]: "..chat
end

function cmds(plr,command)
	local arg = splitstring(command," ")
	local commands = {}
	
	commands[#commands+1] = {2,module.Prefix.."kill [Player]"}
	if arg[1] == module.Prefix.."kill" then
		if GetLevel(plr) < 2 then
			return {false,"You do not have permission to execute this command."}
		end
		if not arg[2] then
			plr.Character.Humanoid.Health = 0
			return {true,"Successfully killed "..plr.Name.."."}
		end
		if arg[2] == "@all" then
			if GetLevel(plr) >= 3 then
				local num = 0
				for _,v in pairs(game.Players:GetPlayers()) do
					v.Character.Humanoid.Health = 0
					num = num+1
				end
				return {true,"Successfully killed "..num.." player(s)."}
			else return {false,"You do not have permission to execute an alternative."}
			end
		elseif arg[2] == "@others" then
			if GetLevel(plr) >= 3 then
				local num = 0
				for _,v in pairs(game.Players:GetPlayers()) do
					if v.Name ~= plr.Name then
						v.Character.Humanoid.Health = 0
						num = num+1
					end
				end
				if num ~= 0 then
					return {true,"Successfully killed "..num.." player(s)."}
				else
					return {true,"Successfully killed no one. No seriously, get some help."}
				end
			else return {false,"You do not have permission to execute an alternative."}
			end	
		elseif arg[2] == "@me" then
			plr.Character.Humanoid.Health = 0
			return {true,"Successfully killed "..plr.Name.."."}
		else
			local p = Player(arg[2])
			if p then
				p.Character.Humanoid.Health = 0
				return {true,"Successfully killed "..p.Name.."."}
			else
			return {false,"Player not found OR You forgot to mark it as an alternative."}
			end
		end
	end
			
	commands[#commands+1] = {2,module.Prefix.."smite [Player]"}
	if arg[1] == module.Prefix.."smite" then
		if GetLevel(plr) < 2 then
			return {false,"You do not have permission to execute this command."}
		end
		if not arg[2] then
			plr.Character.Humanoid.Health = 0
			local new = script.smite_local:Clone()
			local part = Instance.new("Part")
			local light = Instance.new("PointLight",plr.Character.HumanoidRootPart)
			part.Parent = plr.Character.HumanoidRootPart
			part.Size = Vector3.new(3,500,3)
			part.Position = Vector3.new(plr.Character.HumanoidRootPart.Position.X,(plr.Character.HumanoidRootPart.Position.Y+245),plr.Character.HumanoidRootPart.Position.Z)
			part.BrickColor = BrickColor.White()
			part.Orientation = Vector3.new(0,math.random(0,90),0)
			light.Brightness = 5
			light.Color = Color3.new(255,255,255)
			part.Transparency = 0.5
			new.Parent = plr.PlayerGui
			new.Disabled = false
			wait(0.2)
			part:Destroy()
			light:Destroy()
			return {true,"Summoned the power of zeus and smited yourself."}
		end
		if arg[2] == "@all" then
			if GetLevel(plr) >= 3 then
				local num = 0
				for _,v in pairs(game.Players:GetPlayers()) do
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
					wait()
					part:Destroy()
					light:Destroy()
					num = num+1
				end
				return {true,"Summoned zeus and smited "..num.." player(s)."}
			else return {false,"You do not have permission to execute an alternative."}
			end
		elseif arg[2] == "@others" then
			if GetLevel(plr) >= 3 then
				local num = 0
				for _,v in pairs(game.Players:GetPlayers()) do
					if v.Name ~= plr.Name then
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
						wait()
						part:Destroy()
						light:Destroy()
						num = num+1
					end
				end
				if num ~= 0 then
					return {true,"Summoned zeus and smited "..num.." player(s)."}
				else
					return {true,"Summoned the power of zeus but... no one got smited."}
				end
			else return {false,"You do not have permission to execute an alternative."}
			end	
		elseif arg[2] == "@me" then
			plr.Character.Humanoid.Health = 0
			local new = script.smite_local:Clone()
			local part = Instance.new("Part")
			local light = Instance.new("PointLight",plr.Character.HumanoidRootPart)
			part.Parent = plr.Character.HumanoidRootPart
			part.Size = Vector3.new(3,500,3)
			part.Position = Vector3.new(plr.Character.HumanoidRootPart.Position.X,(plr.Character.HumanoidRootPart.Position.Y+245),plr.Character.HumanoidRootPart.Position.Z)
			part.BrickColor = BrickColor.White()
			part.Orientation = Vector3.new(0,math.random(0,90),0)
			light.Brightness = 5
			light.Color = Color3.new(255,255,255)
			part.Transparency = 0.5
			new.Parent = plr.PlayerGui
			new.Disabled = false
			wait(0.2)
			part:Destroy()
			light:Destroy()
			return {true,"Summoned the power of zeus and smited yourself."}
		else
			local p = Player(arg[2])
			if p then
				p.Character.Humanoid.Health = 0
				local new = script.smite_local:Clone()
				local part = Instance.new("Part")
				local light = Instance.new("PointLight",p.Character.HumanoidRootPart)
				part.Parent = p.Character.HumanoidRootPart
				part.Size = Vector3.new(3,500,3)
				part.Position = Vector3.new(p.Character.HumanoidRootPart.Position.X,(p.Character.HumanoidRootPart.Position.Y+245),p.Character.HumanoidRootPart.Position.Z)
				part.BrickColor = BrickColor.White()
				part.Orientation = Vector3.new(0,math.random(0,90),0)
				light.Brightness = 5
				light.Color = Color3.new(255,255,255)
				part.Transparency = 0.5
				new.Parent = p.PlayerGui
				new.Disabled = false
				wait(0.2)
				part:Destroy()
				light:Destroy()
				return {true,"Successfully smited "..p.Name.."."}
			else
			return {false,"Player not found OR You forgot to mark it as an alternative."}
			end
		end
	end
	
	commands[#commands+1] = {3,module.Prefix.."kick <Player> [Reason]"}
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
		
		if arg[2] == "@all" then
			if GetLevel(plr) >= 4 then
				local num = 0
				for _,v in pairs(game.Players:GetPlayers()) do
					if GetLevel(v) < GetLevel(plr) then
						v:Kick(buildreason or "No reason has been stated. (Mass Abuse?)")
						num = num+1
					end
				end
				if num >= 5 then
					return {true,"Successfully kicked "..num.." users. You monster."}
				elseif num < 5 then
					return {true,"Successfully kicked "..num.." users."}
				elseif num == 0 then
					return {true,"No one got kicked! What a rel- I mean... what a shame."}
				end
			else return {false,"You do not have permission to execute an alternative."}
			end
		elseif arg[2] == "@others" then
			if GetLevel(plr) >= 4 then
				local num = 0
				for _,v in pairs(game.Players:GetPlayers()) do
					if v.Name ~= plr.Name then
						if GetLevel(v) < GetLevel(plr) then
							v:Kick(buildreason or "No reason has been stated. (Mass Abuse?)")
							num = num+1
						end
					end
				end
				if num >= 5 then
					return {true,"Successfully kicked "..num.." users. You monster."}
				elseif num < 5 then
					return {true,"Successfully kicked "..num.." users."}
				elseif num == 0 then
					return {true,"Successfully defended your fort against no one..."}
				end
			else return {false,"You do not have permission to execute an alternative."}
			end	
		elseif arg[2] == "@me" then
			plr:Kick(buildreason or "Why did you kick yourself, man?")
		else
			local p = Player(arg[2])
			if p then
				p:Kick(buildreason or "No reason has been stated.")
				return {true,"Successfully kicked "..p.Name.."."}
			else return {false,"Player not found OR You forgot to mark it as an alternative."}
			end
		end end
	
	commands[#commands+1] = {2,module.Prefix.."speed <Player> <Value>"}
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
		
		if arg[2] == "@all" then
			local adds = 0
			for _,v in pairs(game.Players:GetPlayers()) do
				v.Character.Humanoid.WalkSpeed = speed
				adds = adds+1
			end
			return {true,"Changed speed for "..adds.." players to "..speed.."."}
		elseif arg[2] == "@others" then
			local adds = 0
			for _,v in pairs(game.Players:GetPlayers()) do
				if v.Name ~= plr.Name then
					v.Character.Humanoid.WalkSpeed = speed
					adds = adds+1
				end
			end
			return {true,"Changed speed for "..adds.." players to "..speed.."."}
		elseif arg[2] == "@me" then
			plr.Character.Humanoid.WalkSpeed = speed
			return{true,"Changed speed for "..plr.Name.." to "..speed.."."}
		else
			local p = Player(arg[2])
			if p then
				p.Character.Humanoid.WalkSpeed = speed
				return{true,"Changed speed for "..p.Name.." to "..speed.."."}
			else return {false,"Player not found OR You forgot to mark it as an alternative."} end
		end
	end
		
	commands[#commands+1] = {4,module.Prefix.."f3x / btools [Player]"}
	if arg[1] == module.Prefix.."f3x" or arg[1] == module.Prefix.."btools" then
		if GetLevel(plr) < 4 then
			return {false,"You do not have permission to execute this command."}
		end
		if not arg[2] then
			local new = script["Building Tools"]:Clone()
			new.Parent = plr.Backpack
			return{true,"Gave "..plr.Name.." F3X Building Tools."}
		end
		
		if arg[2] == "@all" then
			local adds = 0
			for _,v in pairs(game.Players:GetPlayers()) do
				local new = script["Building Tools"]:Clone()
				new.Parent = v.Backpack
				adds = adds+1
			end
			return {true,"Successfully gave "..adds.." F3X Building Tools."}
		elseif arg[2] == "@others" then
			local adds = 0
			for _,v in pairs(game.Players:GetPlayers()) do
				if v.Name ~= plr.Name then
					local new = script["Building Tools"]:Clone()
					new.Parent = v.Backpack
					adds = adds+1
				end
			end
			return {true,"Successfully gave "..adds.." F3X Building Tools."}
		elseif arg[2] == "@me" then
			local new = script["Building Tools"]:Clone()
			new.Parent = plr.Backpack
			return{true,"Gave "..plr.Name.." F3X Building Tools."}
		else
			local p = Player(arg[2])
			if p then
				local new = script["Building Tools"]:Clone()
				new.Parent = p.Backpack
			else return {false,"Player not found OR You forgot to mark it as an alternative."} end
		end
	end
	
	commands[#commands+1] = {3,module.Prefix.."vip <Player>"}
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
			else return {false,"Player not found OR You forgot to mark it as an alternative."} end
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
			else return {false,"Player not found OR You forgot to mark it as an alternative."} end
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
			else return {false,"Player not found OR You forgot to mark it as an alternative."} end
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
			else return {false,"Player not found OR You forgot to mark it as an alternative."} end
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
			else return {false,"Player not found."} end
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
		
		if arg[2] == "@all" then
			local adds = 0
			for _,v in pairs(game.Players:GetPlayers()) do
				if not v.Character:FindFirstChild("fly") then
					adds = adds+1
					local fly = script.fly:Clone()
					fly.Parent = v.Character
					fly.Disabled = false 
				end
			end
			return {true,"Made "..adds.." players fly in the sky!"}
		elseif arg[2] == "@others" then
			local adds = 0
			for _,v in pairs(game.Players:GetPlayers()) do
				if v.Name ~= plr.Name then
					if not v.Character:FindFirstChild("fly") then
						adds = adds+1
						local fly = script.fly:Clone()
						fly.Parent = v.Character
						fly.Disabled = false 
					end
				end
			end
			return {true,"Made "..adds.." players fly in the sky!"}
		elseif arg[2] == "@me" then
			if not plr.Character:FindFirstChild("fly") then
				local fly = script.fly:Clone()
				fly.Parent = plr.Character
				fly.Disabled = false
				return {true,"You made yourself fly in the sky!"} 
			else
				return {false,"You already have the necessary skill to fly! (Perhaps press X to fly again.)"}
			end
		else
			local p = Player(arg[2])
			if p then
				if not plr.Character:FindFirstChild("fly") then
					local fly = script.fly:Clone()
					fly.Parent = plr.Character
					fly.Disabled = false
					return {true,"You made "..p.Name.." fly in the sky!"} 
				else
					return {false,p.Name.." already has the necessary skill to fly! (Perhaps tell him to press X to fly again.)"}
				end
			else
			return {false,"Player not found OR You forgot to mark it as an alternative."}
			end 
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
		
		if arg[2] == "@all" then
			if GetLevel(plr) >= 3 then
				local num = 0
				for _,v in pairs(game.Players:GetPlayers()) do
					local new = script.Notification:Clone()
					if module.Theme == "Light" then
						new.FullFrame.ImageColor3 = Color3.new(1,1,1)
						new.FullFrame.Countdown.Text.LocalScript.Disabled = false
						new.FullFrame.Text.Text = buildreason or "?"
						new.FullFrame.Text.TextColor3 = Color3.new(0,0,0)
					elseif module.Theme == "Dark" then
						new.FullFrame.ImageColor3 = Color3.new(0,0,0)
						new.FullFrame.Countdown.Text.LocalScript.Disabled = false
						new.FullFrame.Text.Text = buildreason or "?"
						new.FullFrame.Text.TextColor3 = Color3.new(1,1,1)
					elseif module.Theme == "Sea" then
						new.FullFrame.ImageColor3 = Color3.new(0.25,0.5,1)
						new.FullFrame.Countdown.Text.LocalScript.Disabled = false
						new.FullFrame.Text.Text = buildreason or "?"
						new.FullFrame.Text.TextColor3 = Color3.new(0,0,0)
					else
						new.FullFrame.Countdown.Text.LocalScript.Disabled = false
						new.FullFrame.Text.Text = buildreason or "?"
					end
					new.Parent = v.PlayerGui
				end
				if num >= 2 then
					return {true,"Successfully notified "..num.." users."}
				elseif num < 2 then
					return {true,"Successfully notified one user."}
				elseif num == 0 then
					return {true,"No one got notified. Maybe next time get ACTUAL PLAYERS in-game?"}
				end
			else return {false,"You do not have permission to execute an alternative."}
			end
		elseif arg[2] == "@others" then
			if GetLevel(plr) >= 3 then
				local num = 0
				for _,v in pairs(game.Players:GetPlayers()) do
					if v.Name ~= plr.Name then
						local new = script.Notification:Clone()
						if module.Theme == "Light" then
							new.FullFrame.ImageColor3 = Color3.new(1,1,1)
							new.FullFrame.Countdown.Text.LocalScript.Disabled = false
							new.FullFrame.Text.Text = buildreason or "?"
							new.FullFrame.Text.TextColor3 = Color3.new(0,0,0)
						elseif module.Theme == "Dark" then
							new.FullFrame.ImageColor3 = Color3.new(0,0,0)
							new.FullFrame.Countdown.Text.LocalScript.Disabled = false
							new.FullFrame.Text.Text = buildreason or "?"
							new.FullFrame.Text.TextColor3 = Color3.new(1,1,1)
						elseif module.Theme == "Sea" then
							new.FullFrame.ImageColor3 = Color3.new(0.25,0.5,1)
							new.FullFrame.Countdown.Text.LocalScript.Disabled = false
							new.FullFrame.Text.Text = buildreason or "?"
							new.FullFrame.Text.TextColor3 = Color3.new(0,0,0)
						else
							new.FullFrame.Countdown.Text.LocalScript.Disabled = false
							new.FullFrame.Text.Text = buildreason or "?"
						end
						new.Parent = v.PlayerGui
					end
				end
				if num >= 5 then
					return {true,"Successfully notified "..num.." users."}
				elseif num < 5 then
					return {true,"Successfully notified "..num.." user(s)."}
				elseif num == 0 then
					return {true,"Successfully broadcasted your great news... to no one."}
				end
			else return {false,"You do not have permission to execute an alternative."}
			end	
		elseif arg[2] == "@me" then
			local new = script.Notification:Clone()
			if module.Theme == "Light" then
				new.FullFrame.ImageColor3 = Color3.new(1,1,1)
				new.FullFrame.Countdown.Text.LocalScript.Disabled = false
				new.FullFrame.Text.Text = buildreason or "?"
				new.FullFrame.Text.TextColor3 = Color3.new(0,0,0)
			elseif module.Theme == "Dark" then
				new.FullFrame.ImageColor3 = Color3.new(0,0,0)
				new.FullFrame.Countdown.Text.LocalScript.Disabled = false
				new.FullFrame.Text.Text = buildreason or "?"
				new.FullFrame.Text.TextColor3 = Color3.new(1,1,1)
			elseif module.Theme == "Sea" then
				new.FullFrame.ImageColor3 = Color3.new(0.25,0.5,1)
				new.FullFrame.Countdown.Text.LocalScript.Disabled = false
				new.FullFrame.Text.Text = buildreason or "?"
				new.FullFrame.Text.TextColor3 = Color3.new(0,0,0)
			else
				new.FullFrame.Countdown.Text.LocalScript.Disabled = false
				new.FullFrame.Text.Text = buildreason or "?"
			end
			new.Parent = plr.PlayerGui
			return{true,"Hi there."}
		else
			local p = Player(arg[2])
			if p then
				Notify(p,"notification",buildreason or "?")
				return {true,"Successfully notified "..p.Name.."."}
			else return {false,"Player not found OR You forgot to mark it as an alternative."}
			end
			end end
		
	commands[#commands+1] = {3,module.Prefix.."m / message <Player> <Value>"}	
	if arg[1] == module.Prefix.."m" or arg[1] == module.Prefix.."message" then
		local buildreason = "yes hi"
		
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
		
		if arg[2] == "@all" then
			if GetLevel(plr) >= 4 then
				local num = 0
				for _,v in pairs(game.Players:GetPlayers()) do
					Notify(v,"message",{"Message by "..plr.Name,(buildreason or "?")})
				end
				if num >= 2 then
					return {true,"Successfully notified "..num.." users."}
				elseif num < 2 then
					return {true,"Successfully notified one user."}
				elseif num == 0 then
					return {true,"No one got notified. Maybe next time get ACTUAL PLAYERS in-game?"}
				end
			else return {false,"You do not have permission to execute an alternative."}
			end
		elseif arg[2] == "@others" then
			if GetLevel(plr) >= 4 then
				local num = 0
				for _,v in pairs(game.Players:GetPlayers()) do
					if v.Name ~= plr.Name then
						Notify(v,"message",{"Message by "..plr.Name,(buildreason or "?")})
					end
				end
				if num >= 5 then
					return {true,"Successfully notified "..num.." users."}
				elseif num < 5 then
					return {true,"Successfully notified "..num.." user(s)."}
				elseif num == 0 then
					return {true,"Successfully broadcasted your great news... to no one."}
				end
			else return {false,"You do not have permission to execute an alternative."}
			end	
		elseif arg[2] == "@me" then
			Notify(plr,"message",{"Message by "..plr.Name,buildreason or "?"})
			return{true,"Hi there."}
		else
			local p = Player(arg[2])
			if p then
				Notify(p,"message",{"Message by "..plr.Name,buildreason or "?"})
				return {true,"Successfully notified "..p.Name.."."}
			else return {false,"Player not found OR You forgot to mark it as an alternative."}
			end
			end end
			
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
			Notify(v,"message",{"Message by "..plr.Name,buildreason or "?"})
			return{true,"Success."}
		end
	end
	
	commands[#commands+1] = {1,module.Prefix.."fire / burn [Player]"}
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
			else return {false,"Player not found OR You forgot to mark it as an alternative."} end
		end
	end
	
	commands[#commands+1] = {1,module.Prefix.."unfire / extinguish [Player]"}
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
			else return {false,"Player not found OR You forgot to mark it as an alternative."} end
		end
	end
			
	commands[#commands+1] = {1,module.Prefix.."sparkle [Player]"}
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
			else return {false,"Player not found OR You forgot to mark it as an alternative."} end
		end
	end
	
	commands[#commands+1] = {1,module.Prefix.."unsparkle [Player]"}
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
			else return {false,"Player not found OR You forgot to mark it as an alternative."} end
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
		
		if arg[2] == "@all" then
			local adds = 0
			for _,v in pairs(game.Players:GetPlayers()) do
				if (v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character.HumanoidRootPart:IsA("BasePart")) then
					v.Character.HumanoidRootPart.Velocity = Vector3.new()
					v.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(Vector3.new(math.random()-0.5,0,math.random()-0.5)*10)
					adds = adds+1
				end
			end
			return {true,"Successfully brought "..adds.." players to you."}
		elseif arg[2] == "@others" then
			local adds = 0
			for _,v in pairs(game.Players:GetPlayers()) do
				if v.Name ~= plr.Name then
					if (v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character.HumanoidRootPart:IsA("BasePart")) then
						v.Character.HumanoidRootPart.Velocity = Vector3.new()
						v.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(Vector3.new(math.random()-0.5,0,math.random()-0.5)*10)
						adds = adds+1
					end
				end
			end
			return {true,"Successfully brought "..adds.." players to you."}
		elseif arg[2] == "@me" then
			return {false,"You must include someone ELSE you want to bring."}
		else	
			local p = Player(arg[2])
			if p then
				if (p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character.HumanoidRootPart:IsA("BasePart")) then
					p.Character.HumanoidRootPart.Velocity = Vector3.new()
					p.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(Vector3.new(math.random()-0.5,0,math.random()-0.5)*10)
					return {true,"You teleported "..p.Name.." to yourself."}
				end
			else return {false,"Player not found OR You forgot to mark it as an alternative."} end
		end
	end
	
	commands[#commands+1] = {2,module.Prefix.."to <Player/@random>"}
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
			return {false,"You must include someone ELSE you want to teleport to. (Also, Alternatives are disabled for this admin either way.)"}
		elseif arg[2] == "@random" then -- This is the ONLY command with '@random' in the entire admin!
			if (#game.Players:GetPlayers() < 2) then
				return {false,"You need at least 2 players in-game order to use this alternative."}
			end
			local random = ""
			while random ~= "" do
				for _,v in pairs(game.Players:GetPlayers()) do
					if v.Name ~= plr.Name then
						if math.random(1,100) == 100 then
							random = v.Name
						end
					end
				end
				wait()
			end
			
			local r = Player(random)
			if (plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character.HumanoidRootPart:IsA("BasePart")) then
				plr.Character.HumanoidRootPart.Velocity = Vector3.new()
				plr.Character.HumanoidRootPart.CFrame = r.Character.HumanoidRootPart.CFrame * CFrame.new(Vector3.new(math.random()-0.5,0,math.random()-0.5)*10)
				return {true,"You teleported yourself to "..r.Name.."."}
			else
				return {false,"An error has occured."}
			end
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
			else return {false,"Player not found OR You forgot to mark it as an alternative."} end
		end
	end
	
	commands[#commands+1] = {1,module.Prefix.."hat <HatId>"}
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
				return {false,"There are missing libraries for this command! Check SERVER console for the missing libs."}
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
		local new = script.Cmds:Clone()
		if module.Theme == "Light" then
			new.FullFrame.ScrollingFrame.command.TextColor3 = Color3.new(0,0,0)
			new.FullFrame.ImageColor3 = Color3.new(1,1,1)
			new.FullFrame.ScrollingFrame.command.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
		elseif module.Theme == "Dark" then
			new.FullFrame.ScrollingFrame.command.TextColor3 = Color3.new(1,1,1)
			new.FullFrame.ImageColor3 = Color3.new(0,0,0)
			new.FullFrame.ScrollingFrame.command.BackgroundColor3 = Color3.fromRGB(0, 255, 170)
		elseif module.Theme == "Sea" then
			new.FullFrame.ScrollingFrame.command.TextColor3 = Color3.new(0,0,0)
			new.FullFrame.ImageColor3 = Color3.new(0.25,0.5,1)
			new.FullFrame.ScrollingFrame.command.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
		end
		new.FullFrame.ScrollingFrame.command.Text = "Chatlogs on this server;"
		new.FullFrame.ScrollingFrame.command.BackgroundTransparency = 1
		local pos = 0
		local newt={}
		for i = 1, math.floor(#chatlogs/2) do
		   local j = #chatlogs - i + 1
		    newt[i], newt[j] = chatlogs[j], chatlogs[i]
		end
		for i,v in pairs(newt) do
			pos = pos+1
			local bar = new.FullFrame.ScrollingFrame.command:Clone()
			bar.Parent = new.FullFrame.ScrollingFrame
			bar.Text = v
			bar.BackgroundTransparency = 1
			local newpos = pos*28
			bar.Position = UDim2.new(UDim.new(0.03,0),UDim.new(0,newpos))
			new.FullFrame.ScrollingFrame.CanvasSize = UDim2.new(UDim.new(0,0),UDim.new(0,newpos))
		end
		new.Parent = plr.PlayerGui
		return {true,"Showing the loaded "..(pos+1).." chatlogs."}
	end
	
	commands[#commands+1] = {-1,module.Prefix.."about"}
	if arg[1] == module.Prefix.."about" then
		local new = script.About:Clone()
		new.FullFrame.Text.Text = "Your server level is currently "..GetLevel(plr).."."
		new.Parent = plr.PlayerGui
		return "none"
	end
		
	commands[#commands+1] = {-1,module.Prefix.."verify"}
	if arg[1] == module.Prefix.."verify" then
		if plr:GetRankInGroup(3984407) >= 4  then
			local new = script["AGB Badge"]:Clone()
			new.Parent = plr.Character
			return {true,"Successfully verified yourself as a Studio Engi admin."}
		end
		if GetLevel(plr) >= 4 then
			return {false, "This command is only for Studio Engi Administration Team. All it does is bring out a special tag. Nothing else."}
		else
			return {false, "This command is only for Studio Engi Administration Team."}
		end
	end
	
	-- If you're making custom commands, leave this part LAST!
	
	if arg[1] == module.Prefix.."cmds" then
		local new = script.Cmds:Clone()
		if module.Theme == "Light" then
			new.FullFrame.ScrollingFrame.command.TextColor3 = Color3.new(0,0,0)
			new.FullFrame.ImageColor3 = Color3.new(1,1,1)
			new.FullFrame.ScrollingFrame.command.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
		elseif module.Theme == "Dark" then
			new.FullFrame.ScrollingFrame.command.TextColor3 = Color3.new(1,1,1)
			new.FullFrame.ImageColor3 = Color3.new(0,0,0)
			new.FullFrame.ScrollingFrame.command.BackgroundColor3 = Color3.fromRGB(0, 255, 170)
		elseif module.Theme == "Sea" then
			new.FullFrame.ScrollingFrame.command.TextColor3 = Color3.new(0,0,0)
			new.FullFrame.ImageColor3 = Color3.new(0.25,0.5,1)
			new.FullFrame.ScrollingFrame.command.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
		end
		new.FullFrame.ScrollingFrame.command.Text = "-1 | "..module.Prefix.."cmds"
		new.FullFrame.ScrollingFrame.command.BackgroundTransparency = 0.7
		local pos = 0
		for i,v in pairs(commands) do
			pos = pos+1
			local bar = new.FullFrame.ScrollingFrame.command:Clone()
			bar.Parent = new.FullFrame.ScrollingFrame
			bar.Text = v[1].." | "..v[2]
			if tonumber(v[1]) <= GetLevel(plr) then
				if module.Theme == "Sea" then
					bar.TextColor = Color3.new(1,1,1)
				end
				bar.BackgroundTransparency = 0.7
			else
				if module.Theme == "Sea" then
					bar.TextColor = Color3.new(0,0,0)
				end
				bar.BackgroundTransparency = 1
			end
			local newpos = pos*28
			bar.Position = UDim2.new(UDim.new(0.03,0),UDim.new(0,newpos))
			new.FullFrame.ScrollingFrame.CanvasSize = UDim2.new(UDim.new(0,0),UDim.new(0,newpos))
		end
		new.Parent = plr.PlayerGui
		return {true,"Showing the loaded "..(pos+1).." commands."}
	end
	
	return "none"
end

game.Players.PlayerAdded:Connect(function(player)
	print("Player "..player.Name.." connected.")
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
		if isBan >= 1 then
			Notify(player,"welcome","Welcome! This game is using Redefine:A. Your Admin level is "..isBan..".")
		end
	end
end)

for _,v in pairs(script["Add-Ons"]:GetChildren()) do
	loadPlugin(v.Name)
end

spawn(function()
	if module.AutomaticAdminSave == true and (module.Private or module.Beta) then
		while wait(module.SaveEvery*60) do
			local save = SaveAdmins(Admins)
			print("Automatically saved admins after "..save.." attempts.")
		end
	end
end)

return Module
