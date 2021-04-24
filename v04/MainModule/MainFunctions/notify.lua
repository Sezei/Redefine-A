local mod = {}

mod.ModuleType = "Function"

function mod:Unpack(env)
	function env.Notify(player,ntype,nmessage,ntime)
		if player.Name == "Server" then -- If the fakeuser is targeted then why even bother?
			return
		end
		if not player.PlayerGui:FindFirstChild("MainUI") then -- Player probably didn't load correctly. :think:
			return
		end
		local currenttheme = {}
		local themefound = false
		local folder = env.notificationsfolder
		
		--- Deprecated. It's here in case an error occurs. (Which, btw, will.)
		if env.Themes then
			for _,v in pairs(env.Themes) do
				if v.pName == env.ActiveTheme then
					currenttheme = v
					themefound = true
					break
				end
			end
		else
			themefound = false
		end

		if themefound == false then
			currenttheme = {
				Theme = {
				["BackgroundColor"] = Color3.new(0,0,0),
				["TextColor"] = Color3.new(1,1,1),
				["Highlight"] = {Color3.fromRGB(0,255,170),env.RC3S:GetColor("white")},
				["Logo"] = env.RC3S:GetColor("white"),
				["SideColor"] = env.RC3S:GetColor("black"),
				done = {
					["Color"] = env.RC3S:GetColor("black"),
					["Image"] = {4146192662,env.RC3S:GetColor("litegreen")}
				},
				err = {
					["Color"] = env.RC3S:GetColor("black"),
					["Image"] = {4146192101,env.RC3S:GetColor("litered")}
				},
				notif = {
					["Color"] = env.RC3S:GetColor("black"),
					["Exclamation"] = env.RC3S:GetColor("orange")
				},
				welcome = {
					["Color"] = env.RC3S:GetColor("royalturq"),
					["Icon"] = env.RC3S:GetColor("black")
				},
				cmd = {
					["Color"] = env.RC3S:GetColor("black"),
					["Icon"] = env.RC3S:GetColor("green")
				}
			}}
		end

		if currenttheme.Version then
			env.UI.CommandBar.FullFrame.Side["Studio Engi Icon"].TextColor3 = currenttheme.Theme.cmd["Icon"]
			env.UI.CommandBar.FullFrame.Side.ImageColor3 = currenttheme.Theme.cmd["Color"]
		else
			env.UI.CommandBar.FullFrame.Side["Studio Engi Icon"].TextColor3 = currenttheme.Theme.welcome["Icon"]
			env.UI.CommandBar.FullFrame.Side.ImageColor3 = currenttheme.Theme.welcome["Color"]
		end
		env.UI.CommandBar.FullFrame.Prefix.Text = env.Settings.Prefix
		env.UI.CommandBar.FullFrame.Prefix.TextColor3 = currenttheme.Theme["TextColor"]
		env.UI.CommandBar.FullFrame.ImageColor3 = currenttheme.Theme["BackgroundColor"]
		env.UI.CommandBar.FullFrame.Command.TextColor3 = currenttheme.Theme["TextColor"]
		--- Oh and btw, don't touch this part at all.
		
		if player then
			if ntype == "pwelcome" then
				local msg = env.nfunc:InvokeClient(player,"Notify",{"pwelcome",nmessage})
				return msg
			elseif ntype == "pdone" then
				local msg = env.nfunc:InvokeClient(player,"Notify",{"pdone",nmessage})
				return msg
			elseif ntype == "perror" then
				local msg = env.nfunc:InvokeClient(player,"Notify",{"perror",nmessage})
				return msg
			elseif ntype == "pcritical" then
				local msg = env.nfunc:InvokeClient(player,"Notify",{"pcritical",nmessage})
				return msg
			elseif ntype == "pnotification" then
				local msg = env.nfunc:InvokeClient(player,"Notify",{"pnotification",nmessage})
				return msg
			elseif ntype == "welcome" then
				local msg = env.nfunc:InvokeClient(player,"Notify",{"welcome",nmessage,ntime})
				return msg
			elseif ntype == "done" then
				local msg = env.nfunc:InvokeClient(player,"Notify",{"done",nmessage,ntime})
				return msg
			elseif ntype == "error" then
				local msg = env.nfunc:InvokeClient(player,"Notify",{"error",nmessage,ntime})
				return msg
			elseif ntype == "settings" then
				local msg = env.nfunc:InvokeClient(player,"OpenSettings")
				return msg
			elseif ntype == "critical" then
				local msg = env.nfunc:InvokeClient(player,"Notify",{"critical",nmessage,ntime})
				return msg
			elseif ntype == "notification" then
				local msg = env.nfunc:InvokeClient(player,"Notify",{"notification",nmessage,ntime})
				return msg
			elseif ntype == "ViewPlayer" then
				local msg = env.nfunc:InvokeClient(player,"ViewPlayer",nmessage)
				return msg
			elseif ntype == "Mute" then
				local msg = env.nfunc:InvokeClient(player,"Mute")
				return msg
			elseif ntype == "Unmute" then
				local msg = env.nfunc:InvokeClient(player,"Unmute")
				return msg
			elseif ntype == "servermsg" then
				local msg = require(script.notadirtyhack):New(ntime)
				msg.Parent = player.PlayerGui
				env.nfunc:InvokeClient(player,"Notify",{"custom",nmessage,(ntime or 60),msg})
				return msg
			elseif ntype == "ping" then
				env.nfunc:InvokeClient(player,"Notify",{"ping",nmessage})
			elseif ntype == "newmsg" then
				local msg = env.nfunc:InvokeClient(player,"broadcast",{nmessage[2],nmessage[1]})
			elseif ntype == "message" then
				local active = player.PlayerGui:FindFirstChild("FullScreenNotification")
				if active then
					active:Destroy()
				end
				local new = env.UI.FullScreenNotification:Clone()
				new.Frame.BackgroundColor3 = currenttheme.Theme["BackgroundColor"]
				new.LocalScript.Disabled = false
				new.Frame.Message.Text = nmessage[2]
				new.Frame.Message.TextColor3 = currenttheme.Theme["TextColor"]
				new.Frame.Title.Text = nmessage[1]
				new.Frame.Title.TextColor3 = currenttheme.Theme["TextColor"]
				new.Parent = player.PlayerGui
				return new
			elseif ntype == "cmds" then
				local clone = player.PlayerGui.MainUI.ListUI:Clone()
				local pos = -1
				clone.ScrollingFrame.command.Visible = false
				local commands = {}
				for i,v in pairs(nmessage) do -- Table sorter by Cytronyx.
					if not v._debug then -- If _debug is an actual variable, it's likely it's not supposed to be visible in the list in the first place.
						table.insert(commands, (tostring(v.Level).. " | " .. env.Settings.Prefix .. v.ModName .. " " .. v.Usage))
						table.sort(commands, function(a,b) local levela = string.match(a, "%d+") local levelb = string.match(b, "%d+") return tonumber(levela) < tonumber(levelb) end)
					end	
				end
				clone.Parent = player.PlayerGui.MainUI
				clone.Title.Text = "Commands List"
				clone.Visible = true
				-- Load the commands after displaying the clone.
				-- This is a bit better performance-vice, as it (the command thing) will already be visible and the commands
				-- will look as if they are loading inside, when in reality, they are already loaded, like in Basic.
				local visibles = -1
				for i,v in pairs(commands) do
					pos = pos+1
					local bar = clone.ScrollingFrame.command:Clone()
					bar.Parent = clone.ScrollingFrame
					if tonumber(string.match(v, "%d+")) == 6 and env.isOwner(player) or tonumber(string.match(v, "%d+")) <= env.GetLevel(player) then
						bar.Label.TextColor3 = Color3.fromRGB(255,255,255)
						bar.Visible = true
					else
						bar.Label.TextColor3 = Color3.fromRGB(155,155,155)
						bar.Visible = false
					end
					if tonumber(string.match(v, "%d+")) == 6 then
						v = "#" .. env.CharReplace(1, v, "") -- pretty nifty huh
					end
					bar.Label.Text = v
					if bar.Visible == true then
						visibles = visibles+1
						local newpos = visibles*28
						clone.ScrollingFrame.CanvasSize = UDim2.new(UDim.new(0,0),UDim.new(0,newpos+28))
					else
						bar:Destroy()
					end
				end
			elseif ntype == "allcmds" then
				local clone = player.PlayerGui.MainUI.ListUI:Clone()
				local pos = -1
				clone.ScrollingFrame.command.Visible = false
				local commands = {}
				for i,v in pairs(nmessage) do -- Table sorter by Cytronyx.
					if not v._debug then -- If _debug is an actual variable, it's likely it's not supposed to be visible in the list in the first place.
						table.insert(commands, (tostring(v.Level).. " | " .. env.Settings.Prefix .. v.ModName .. " " .. v.Usage))
						table.sort(commands, function(a,b) local levela = string.match(a, "%d+") local levelb = string.match(b, "%d+") return tonumber(levela) < tonumber(levelb) end)
					end	
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
					if tonumber(string.match(v, "%d+")) == 6 and env.isOwner(player) or tonumber(string.match(v, "%d+")) <= env.GetLevel(player) then
						bar.Label.TextColor3 = Color3.fromRGB(255,255,255)
					else
						bar.Label.TextColor3 = Color3.fromRGB(155,155,155)
					end
					if tonumber(string.match(v, "%d+")) == 6 then
						v = "#" .. env.CharReplace(1, v, "") -- pretty nifty huh
					end
					bar.Visible = true
					bar.Label.Text = v
					local newpos = pos*28
					clone.ScrollingFrame.CanvasSize = UDim2.new(UDim.new(0,0),UDim.new(0,newpos+28))
				end
			elseif ntype == "debuglogs" then
				local clone = player.PlayerGui.MainUI.ListUI:Clone()
				local pos = 0
				clone.ScrollingFrame.command.Visible = false
				local gameSecretVisible = false
				if env.isOwner(player) then
					gameSecretVisible = true
				else
					gameSecretVisible = false
				end
				local stuff = {
					["Time to load"] = env.totalloadtime,
					["Total players handled"] = tostring(#env.usersfolder:GetChildren()),
					["Build ID"] = env.BuildId,
					["Build Version"] = env.BuildVer,
					["Loader Version"] = env.MadeforBuild,
					["Internal Build ID"] = env.internalbuildid,
					["Current Admin Datastore"] = env.db.Name,
					["Preferred Execution Method"] = env.Settings.PreferredMethod,
				}
				if gameSecretVisible == true then
					stuff["Game Secret"] = env.gameSecret
				end
				for k,v in pairs(stuff) do
					pos = pos+1
					local bar = clone.ScrollingFrame.command:Clone()
					bar.Parent = clone.ScrollingFrame
					bar.Visible = true
					bar.Label.Text = k..": "..v
					bar.Label.TextColor3 = Color3.fromRGB(255,255,255)
					local newpos = pos*28
					clone.ScrollingFrame.CanvasSize = UDim2.new(UDim.new(0,0),UDim.new(0,newpos))
				end
				clone.Parent = player.PlayerGui.MainUI
				clone.Title.Text = "INTERNAL USE ONLY"
				clone.Visible = true
			elseif ntype == "errorlogs" then
				local clone = player.PlayerGui.MainUI.ListUI:Clone()
				local pos = 0
				clone.ScrollingFrame.command.Visible = false
				if type(env.errorslogged) == nil then
					env.nfunc:InvokeClient(player,"Notify",{"error","For some reason, the table for ErrorsLogged doesn't exist? Creating one, then...",10})
					env.errorslogged = {}
					clone:Destroy()
					return
				end
				if type(env.errorslogged) == "table" then
					if not next(env.errorslogged) then
						env.nfunc:InvokeClient(player,"Notify",{"notification","There are no errors to show.",10})
						clone:Destroy()
						return
					end
				end
				for _,v in pairs(env.errorslogged) do
					pos = pos+1
					local bar = clone.ScrollingFrame.command:Clone()
					bar.Parent = clone.ScrollingFrame
					bar.Visible = true
					bar.Label.Text = v
					bar.Label.TextColor3 = Color3.fromRGB(255,255,255)
					local newpos = pos*28
					clone.ScrollingFrame.CanvasSize = UDim2.new(UDim.new(0,0),UDim.new(0,newpos))
				end
				clone.Parent = player.PlayerGui.MainUI
				clone.Title.Text = "Error Logs"
				clone.Visible = true
			elseif ntype == "customlist" then
				local clone = player.PlayerGui.MainUI.ListUI:Clone()
				local pos = 0
				clone.ScrollingFrame.command.Visible = false
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
					bar.Label.Text = k..": "..v
					bar.Label.TextColor3 = Color3.fromRGB(255,255,255)
					bar.Visible = true
					local newpos = pos*28
					clone.ScrollingFrame.CanvasSize = UDim2.new(UDim.new(0,0),UDim.new(0,newpos))
				end
			elseif ntype == "chatlogs" then
				local clone = player.PlayerGui.MainUI.ListUI:Clone()
				local pos = 0
				clone.ScrollingFrame.command.Visible = false
				local newt={}
				for i = 1, math.floor(#env.chatlogs/2) do
					local j = #env.chatlogs - i + 1
					newt[i], newt[j] = env.chatlogs[j], env.chatlogs[i]
				end
				clone.Parent = player.PlayerGui.MainUI
				clone.Title.Text = "Chatlogs"
				clone.Visible = true
				for i,v in pairs(newt) do
					pos = pos+1
					local bar = clone.ScrollingFrame.command:Clone()
					bar.Parent = clone.ScrollingFrame
					bar.Label.Text = v
					bar.BackgroundTransparency = 1
					bar.Visible = true
					clone.ScrollingFrame.CanvasSize = UDim2.new(0,0,0,(pos-1)*28)
				end
			elseif ntype == "cmdlogs" then
				local clone = player.PlayerGui.MainUI.ListUI:Clone()
				local pos = 0
				clone.ScrollingFrame.command.Visible = false
				local newt={}
				for i = 1, math.floor(#env.cmdlogs/2) do
					local j = #env.cmdlogs - i + 1
					newt[i], newt[j] = env.cmdlogs[j], env.cmdlogs[i]
				end
				clone.Parent = player.PlayerGui.MainUI
				clone.Title.Text = "Command Logs"
				clone.Visible = true
				for i,v in pairs(newt) do
					pos = pos+1
					local bar = clone.ScrollingFrame.command:Clone()
					bar.Parent = clone.ScrollingFrame
					bar.Label.Text = v
					bar.BackgroundTransparency = 1
					bar.Visible = true
					clone.ScrollingFrame.CanvasSize = UDim2.new(0,0,0,(pos-1)*28)
				end
			elseif ntype == "exploitlogs" then
				local clone = player.PlayerGui.MainUI.ListUI:Clone()
				local pos = 0
				clone.ScrollingFrame.command.Visible = false
				local newt={}
				for i = 1, math.floor(#env.exploitlogs/2) do
					local j = #env.exploitlogs - i + 1
					newt[i], newt[j] = env.exploitlogs[j], env.exploitlogs[i]
				end
				clone.Parent = player.PlayerGui.MainUI
				clone.Title.Text = "Exploits Logged"
				clone.Visible = true
				for i,v in pairs(newt) do
					pos = pos+1
					local bar = clone.ScrollingFrame.command:Clone()
					bar.Parent = clone.ScrollingFrame
					bar.Label.Text = v
					bar.BackgroundTransparency = 1
					bar.Visible = true
					clone.ScrollingFrame.CanvasSize = UDim2.new(0,0,0,(pos-1)*28)
				end
			elseif ntype == "lpids" then
				local clone = player.PlayerGui.MainUI.ListUI:Clone()
				local pos = 0
				clone.ScrollingFrame.command.Visible = false
				clone.Parent = player.PlayerGui.MainUI
				clone.Title.Text = "Local User IDs"
				clone.Visible = true
				for i,v in pairs(env.usersfolder:GetChildren()) do
					pos = pos+1
					local bar = clone.ScrollingFrame.command:Clone()
					bar.Parent = clone.ScrollingFrame
					bar.Label.Text = v.Value
					bar.Visible = true
					if game.Players:FindFirstChild(v.Name) then
						if env.GetPlayer(v.Name):GetRankInGroup(3984407) >= 4 then
							bar.Label.TextColor3 = Color3.fromRGB(255, 255, 255)
							bar.Label.TextStrokeColor3 = Color3.fromRGB(255,255,127)
							bar.Label.TextStrokeTransparency = 0.7
						end
						if v.Name == player.Name then
							bar.Label.TextColor3 = Color3.fromRGB(85,255,127)
						end
					else
						bar.Label.TextColor3 = Color3.fromRGB(155, 155, 155)
					end
					local newpos = pos*28
					clone.ScrollingFrame.CanvasSize = UDim2.new(UDim.new(0,0),UDim.new(0,newpos))
				end
			elseif ntype == "bans" then
				local clone = player.PlayerGui.MainUI.ListUI:Clone()
				local pos = 0
				clone.ScrollingFrame.command.Visible = false
				clone.Parent = player.PlayerGui.MainUI
				clone.Title.Text = "Bans List"
				clone.Visible = true
				if next(env.Admins.BanLand) or next(env.serverbans) then -- Check if the table isn't empty. If it is, don't progress any further, as it WILL error.
					for i,v in pairs(env.Admins.BanLand) do -- TODO: Rewrite the bans table to be k = UserId, v = Reason.
						if type(v) == "table" then
							if v[1] and v[2] then
								pos = pos+1
								local bar = clone.ScrollingFrame.command:Clone()
								bar.Parent = clone.ScrollingFrame
								local name
								pcall(function()
									name = game:GetService("Players"):GetNameFromUserIdAsync(v[1])
								end)
								bar.Label.Text = "PBAN | "..v[1].. " | ".. (name or "NIL") ..": "..v[2]
								bar.Visible = true
								bar.Label.TextColor3 = Color3.fromRGB(255, 255, 255)
								local newpos = pos*28
								clone.ScrollingFrame.CanvasSize = UDim2.new(UDim.new(0,0),UDim.new(0,newpos))
							elseif v[1] and not v[2] then
								pos = pos+1
								local bar = clone.ScrollingFrame.command:Clone()
								bar.Parent = clone.ScrollingFrame
								local name
								pcall(function()
									name = game:GetService("Players"):GetNameFromUserIdAsync(v[1])
								end)
								v[2] = "A reason was not stated for this ban, or the ban was made before R:A Version 4."
								bar.Label.Text = "PBAN | "..v[1].. " | ".. (name or "NIL") ..": "..v[2]
								bar.Visible = true
								bar.Label.TextColor3 = Color3.fromRGB(255, 255, 255)
								local newpos = pos*28
								clone.ScrollingFrame.CanvasSize = UDim2.new(UDim.new(0,0),UDim.new(0,newpos))
							elseif not v[1] then
							end
						end
					end
					for i,v in pairs(env.serverbans) do
						if type(v) == "table" then
							if v[1] and v[2] then
								pos = pos+1
								local bar = clone.ScrollingFrame.command:Clone()
								bar.Parent = clone.ScrollingFrame
								local name
								pcall(function()
									name = game:GetService("Players"):GetNameFromUserIdAsync(v[1])
								end)
								bar.Label.Text = "SERVER | "..v[1].. " | ".. (name or "NIL") ..": "..v[2]
								bar.Visible = true
								bar.Label.TextColor3 = Color3.fromRGB(255, 255, 255)
								local newpos = pos*28
								clone.ScrollingFrame.CanvasSize = UDim2.new(UDim.new(0,0),UDim.new(0,newpos))
							elseif v[1] and not v[2] then
								pos = pos+1
								local bar = clone.ScrollingFrame.command:Clone()
								bar.Parent = clone.ScrollingFrame
								local name
								pcall(function()
									name = game:GetService("Players"):GetNameFromUserIdAsync(v[1])
								end)
								v[2] = "A reason was not stated for this ban, or the ban was made before R:A Version 4."
								bar.Label.Text = "SERVER | "..v[1].. " | ".. (name or "NIL") ..": "..v[2]
								bar.Visible = true
								bar.Label.TextColor3 = Color3.fromRGB(255, 255, 255)
								local newpos = pos*28
								clone.ScrollingFrame.CanvasSize = UDim2.new(UDim.new(0,0),UDim.new(0,newpos))
							elseif not v[1] then
							end
						end
					end
					return true
				else -- There's nothing in the table.
					clone:Destroy()
					return false
				end
			elseif ntype == "onlineadmins" then
				local clone = player.PlayerGui.MainUI.ListUI:Clone()
				local pos = 0
				clone.ScrollingFrame.command.Visible = false
				clone.Parent = player.PlayerGui.MainUI
				clone.Title.Text = "Staff Online"
				clone.Visible = true
				for i,v in pairs(game.Players:GetPlayers()) do
					if env.GetLevel(v) >= 2 then
						pos = pos+1
						local bar = clone.ScrollingFrame.command:Clone()
						bar.Parent = clone.ScrollingFrame
						if env.GetLevel(v) == 2 then
							bar.Label.Text = env.CurrentLanguage.Levels.Moderator.. " | "..v.Name
						elseif env.GetLevel(v) == 3 then
							bar.Label.Text = env.CurrentLanguage.Levels.Admin.. " | "..v.Name
						elseif env.GetLevel(v) == 4 then
							bar.Label.Text = env.CurrentLanguage.Levels.Super.. " | "..v.Name
						elseif env.GetLevel(v) == 5 then
							bar.Label.Text = env.CurrentLanguage.Levels.Root.. " | "..v.Name
						end
						bar.Visible = true
						bar.Label.TextColor3 = Color3.fromRGB(255, 255, 255)
						local newpos = pos*28
						clone.ScrollingFrame.CanvasSize = UDim2.new(UDim.new(0,0),UDim.new(0,newpos))
					end
				end
			end
		end
	end
end

return mod