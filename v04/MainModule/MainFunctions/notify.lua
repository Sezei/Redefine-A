-- oh god

local mod = {}

mod.ModuleType = "Function"

function mod:Unpack(env)
	function env.Notify(player,ntype,nmessage)
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

		if ntype == "pwelcome" then
			local new = player.PlayerGui.MainUI.Main.NotificationButton:Clone()
			if env.Settings.HideMain == false then
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
			elseif env.Settings.HideMain == true then
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
			if env.Settings.SeasonalThemes == true then
				new.decoration.Visible = true
			else
				new.decoration.Visible = false
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
			new.Timer.Visible = false
			return new
		elseif ntype == "pdone" then
			local new = player.PlayerGui.MainUI.Main.NotificationButton:Clone()
			if env.Settings.HideMain == false then
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
			elseif env.Settings.HideMain == true then
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
			if env.Settings.SeasonalThemes == true then
				new.decoration.Visible = true
			else
				new.decoration.Visible = false
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
			new.Timer.Visible = false
			return new
		elseif ntype == "perror" then
			local new = player.PlayerGui.MainUI.Main.NotificationButton:Clone()
			if env.Settings.HideMain == false then
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
			elseif env.Settings.HideMain == true then
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
			if env.Settings.SeasonalThemes == true then
				new.decoration.Visible = true
			else
				new.decoration.Visible = false
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
			new.Timer.Visible = false
			return new
		elseif ntype == "pcritical" then
			local new = player.PlayerGui.MainUI.Main.NotificationButton:Clone()
			if env.Settings.HideMain == false then
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
			elseif env.Settings.HideMain == true then
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
			new.Timer.Visible = false
			return new
		elseif ntype == "pnotification" then
			local new = player.PlayerGui.MainUI.Main.NotificationButton:Clone()
			if env.Settings.HideMain == false then
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
			elseif env.Settings.HideMain == true then
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
			if env.Settings.SeasonalThemes == true then
				new.decoration.Visible = true
			else
				new.decoration.Visible = false
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
			new.Timer.Visible = false
			return new
		elseif ntype == "welcome" then
			local new = player.PlayerGui.MainUI.Main.NotificationButton:Clone()
			if env.Settings.HideMain == false then
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
			elseif env.Settings.HideMain == true then
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
			if env.Settings.SeasonalThemes == true then
				new.decoration.Visible = true
			else
				new.decoration.Visible = false
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
			return new
		elseif ntype == "done" then
			local new = player.PlayerGui.MainUI.Main.NotificationButton:Clone()
			if env.Settings.HideMain == false then
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
			elseif env.Settings.HideMain == true then
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
			if env.Settings.SeasonalThemes == true then
				new.decoration.Visible = true
			else
				new.decoration.Visible = false
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
			return new
		elseif ntype == "error" then
			local new = player.PlayerGui.MainUI.Main.NotificationButton:Clone()
			if env.Settings.HideMain == false then
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
			elseif env.Settings.HideMain == true then
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
			if env.Settings.SeasonalThemes == true then
				new.decoration.Visible = true
			else
				new.decoration.Visible = false
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
			return new
		elseif ntype == "critical" then -- Added in 03. Made for errors in the custom commands.
			local new = player.PlayerGui.MainUI.Main.NotificationButton:Clone()
			if env.Settings.HideMain == false then
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
			elseif env.Settings.HideMain == true then
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
			-- critical is not to be used for seasonal themes.
			-- the reason is that all of the text needs to be visible unlike others.
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
			return new
		elseif ntype == "notification" then
			local new = player.PlayerGui.MainUI.Main.NotificationButton:Clone()
			if env.Settings.HideMain == false then
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
			elseif env.Settings.HideMain == true then
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
			if env.Settings.SeasonalThemes == true then
				new.decoration.Visible = true
			else
				new.decoration.Visible = false
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
			return new
		elseif ntype == "newmsg" then
			local new = env.UI.NewMessage:Clone()
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
			return new
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
			local pos = -1
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
				["Default Admin Datastore"] = "Admin_RedefineA",
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
		elseif ntype == "customlist" then
			local clone = player.PlayerGui.MainUI.ListUI:Clone()
			local pos = -1
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
			local pos = -1
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
					bar.Label.TextColor3 = Color3.fromRGB(255, 255, 255)
				else
					bar.Label.TextColor3 = Color3.fromRGB(155, 155, 155)
				end
				local newpos = pos*28
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

return mod