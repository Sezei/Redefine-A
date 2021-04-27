local module = {}
local settings = script.Parent.Parent.Parent.Parent.LocalSettings

function module.HandleEnd(posnum) -- experimental
	for _,v in pairs(script.Parent.Parent.Parent.Parent.Notifications:GetChildren()) do
		if posnum < v.posnum.Value then
			v.posnum.Value = v.posnum.Value-1
			v:TweenPosition(UDim2.new(0, 15,1, (-10 - 45 * (v.posnum.Value-1))),Enum.EasingDirection.Out,Enum.EasingStyle.Quart,0.2,true)
		end
	end
end

function module.Old(ntype,nmessage,ntime,inst)
	local player = game:GetService("Players").LocalPlayer
	local env = { -- Temporary lmfao
		Settings = {
			HideMain = false
		}
	}
	if ntype == "pwelcome" then
		local new = script.Parent.Parent.Parent.Parent.Notifications.NotificationButton:Clone()
		new.AnchorPoint = Vector2.new(0,1)
		if env.Settings.HideMain == false then
			new.Parent = script.Parent.Parent.Parent.Parent.Notifications
			local pos = 1
			local foundpos = false
			local whichposfound = 0
			repeat 
				for _,v in pairs(script.Parent.Parent.Parent.Parent.Notifications:GetChildren()) do
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
			new.Position = UDim2.new(0, 15,1, (-10 - 45 * (pos-1)))
		end
		if env.Settings.SeasonalThemes == true then
			new.decoration.Visible = true
		else
			new.decoration.Visible = false
		end
		new.Text = nmessage
		new.TextColor3 = Color3.new(0,0.666667,1)
		if settings.LightMode.Value == true then
			new.TextColor3 = Color3.new(0, 0.333333, 1)
			new.BackgroundColor3 = Color3.new(0.866667, 0.866667, 0.866667)
		end
		new.Visible = true
		new:FindFirstChild("Sound"..math.random(1,4)):Play()
		new.MouseButton1Click:Connect(function()
			new.Click:Play()
			new.Visible = false
			wait(0.3)
			new:Destroy()
		end)
		new.Timer.Visible = false
		return new
	elseif ntype == "pdone" then
		local new = script.Parent.Parent.Parent.Parent.Notifications.NotificationButton:Clone()
		if env.Settings.HideMain == false then
			new.Parent = script.Parent.Parent.Parent.Parent.Notifications
			local pos = 1
			local foundpos = false
			local whichposfound = 0
			repeat 
				for _,v in pairs(script.Parent.Parent.Parent.Parent.Notifications:GetChildren()) do
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
			new.Position = UDim2.new(0, 15,1, (-10 - 45 * (pos-1)))
		end
		if env.Settings.SeasonalThemes == true then
			new.decoration.Visible = true
		else
			new.decoration.Visible = false
		end
		new.Text = nmessage
		new.TextColor3 = Color3.new(0.666667, 1, 0.498039)
		if settings.LightMode.Value == true then
			new.TextColor3 = Color3.new(0.333333, 0.666667, 0)
			new.BackgroundColor3 = Color3.new(0.866667, 0.866667, 0.866667)
		end
		new.Visible = true
		new:FindFirstChild("Sound"..math.random(1,4)):Play()
		new.MouseButton1Click:Connect(function()
			new.Click:Play()
			new.Visible = false
			wait(0.3)
			new:Destroy()
		end)
		new.Timer.Visible = false
		return new
	elseif ntype == "perror" then
		local new = script.Parent.Parent.Parent.Parent.Notifications.NotificationButton:Clone()
		if env.Settings.HideMain == false then
			new.Parent = script.Parent.Parent.Parent.Parent.Notifications
			local pos = 1
			local foundpos = false
			local whichposfound = 0
			repeat 
				for _,v in pairs(script.Parent.Parent.Parent.Parent.Notifications:GetChildren()) do
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
			new.Position =  UDim2.new(0, 15,1, (-10 - 45 * (pos-1)))
		end
		if env.Settings.SeasonalThemes == true then
			new.decoration.Visible = true
		else
			new.decoration.Visible = false
		end
		new.Text = nmessage
		new.TextColor3 = Color3.new(1,0.666667,0)
		if settings.LightMode.Value == true then
			new.TextColor3 = Color3.new(1, 0.333333, 0)
			new.BackgroundColor3 = Color3.new(0.866667, 0.866667, 0.866667)
		end
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
		local new = script.Parent.Parent.Parent.Parent.Notifications.NotificationButton:Clone()
		if env.Settings.HideMain == false then
			new.Parent = script.Parent.Parent.Parent.Parent.Notifications
			local pos = 1
			local foundpos = false
			local whichposfound = 0
			repeat 
				for _,v in pairs(script.Parent.Parent.Parent.Parent.Notifications:GetChildren()) do
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
			new.Position =  UDim2.new(0, 15,1, (-10 - 45 * (pos-1)))
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
		local new = script.Parent.Parent.Parent.Parent.Notifications.NotificationButton:Clone()
		if env.Settings.HideMain == false then
			new.Parent = script.Parent.Parent.Parent.Parent.Notifications
			local pos = 1
			local foundpos = false
			local whichposfound = 0
			repeat 
				for _,v in pairs(script.Parent.Parent.Parent.Parent.Notifications:GetChildren()) do
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
			new.Position =  UDim2.new(0, 15,1, (-10 - 45 * (pos-1)))
		end
		if env.Settings.SeasonalThemes == true then
			new.decoration.Visible = true
		else
			new.decoration.Visible = false
		end
		new.Text = nmessage
		new.TextColor3 = Color3.new(1, 1, 1)
		if settings.LightMode.Value == true then
			new.TextColor3 = Color3.new(0.117647, 0.117647, 0.117647)
			new.BackgroundColor3 = Color3.new(0.866667, 0.866667, 0.866667)
		end
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
		local new = script.Parent.Parent.Parent.Parent.Notifications.NotificationButton:Clone()
		if env.Settings.HideMain == false then
			new.Parent = script.Parent.Parent.Parent.Parent.Notifications
			local pos = 1
			local foundpos = false
			local whichposfound = 0
			repeat 
				for _,v in pairs(script.Parent.Parent.Parent.Parent.Notifications:GetChildren()) do
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
			new.Position =  UDim2.new(0, 15,1, (-10 - 45 * (pos-1)))
		end
		if env.Settings.SeasonalThemes == true then
			new.decoration.Visible = true
		else
			new.decoration.Visible = false
		end
		new.Text = nmessage
		new.TextColor3 = Color3.new(0,0.666667,1)
		if settings.LightMode.Value == true then
			new.TextColor3 = Color3.new(0, 0.333333, 1)
			new.BackgroundColor3 = Color3.new(0.866667, 0.866667, 0.866667)
			new.Timer.BackgroundColor3 = Color3.new(0,0,0)
		end
		new.Visible = true
		new:FindFirstChild("Sound"..math.random(1,4)):Play()
		new.MouseButton1Click:Connect(function()
			new.Click:Play()
			new.Visible = false
			wait(0.3)
			new:Destroy()
		end)
		new.Timer:TweenSize(UDim2.new(0,0,0,2),Enum.EasingDirection.InOut,Enum.EasingStyle.Linear,(ntime or math.max(10,(#nmessage/75))),true,function()
			new.Visible = false
			new:Destroy()
		end)
		return new
	elseif ntype == "done" then
		local new = script.Parent.Parent.Parent.Parent.Notifications.NotificationButton:Clone()
		if env.Settings.HideMain == false then
			new.Parent = script.Parent.Parent.Parent.Parent.Notifications
			local pos = 1
			local foundpos = false
			local whichposfound = 0
			repeat 
				for _,v in pairs(script.Parent.Parent.Parent.Parent.Notifications:GetChildren()) do
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
			new.Position = UDim2.new(0, 15,1, (-10 - 45 * (pos-1)))
		end
		if env.Settings.SeasonalThemes == true then
			new.decoration.Visible = true
		else
			new.decoration.Visible = false
		end
		new.Text = nmessage
		new.TextColor3 = Color3.new(0.666667, 1, 0.498039)
		if settings.LightMode.Value == true then
			new.TextColor3 = Color3.new(0.333333, 0.666667, 0)
			new.BackgroundColor3 = Color3.new(0.866667, 0.866667, 0.866667)
			new.Timer.BackgroundColor3 = Color3.new(0,0,0)
		end
		new.Visible = true
		new:FindFirstChild("Sound"..math.random(1,4)):Play()
		new.MouseButton1Click:Connect(function()
			new.Click:Play()
			new.Visible = false
			wait(0.3)
			new:Destroy()
		end)
		new.Timer:TweenSize(UDim2.new(0,0,0,2),Enum.EasingDirection.InOut,Enum.EasingStyle.Linear,(ntime or math.max(3,(#nmessage/70))),true,function()
			new.Visible = false
			new:Destroy()
		end)
		return new
	elseif ntype == "error" then
		local new = script.Parent.Parent.Parent.Parent.Notifications.NotificationButton:Clone()
		if env.Settings.HideMain == false then
			new.Parent = script.Parent.Parent.Parent.Parent.Notifications
			local pos = 1
			local foundpos = false
			local whichposfound = 0
			repeat 
				for _,v in pairs(script.Parent.Parent.Parent.Parent.Notifications:GetChildren()) do
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
			new.Position =  UDim2.new(0, 15,1, (-10 - 45 * (pos-1)))
		end
		if env.Settings.SeasonalThemes == true then
			new.decoration.Visible = true
		else
			new.decoration.Visible = false
		end
		new.Text = nmessage
		new.TextColor3 = Color3.new(1,0.666667,0)
		if settings.LightMode.Value == true then
			new.TextColor3 = Color3.new(1, 0.333333, 0)
			new.BackgroundColor3 = Color3.new(0.866667, 0.866667, 0.866667)
			new.Timer.BackgroundColor3 = Color3.new(0,0,0)
		end
		new.Visible = true
		new.Error:Play()
		new.MouseButton1Click:Connect(function()
			new.Click:Play()
			new.Visible = false
			wait(0.3)
			new:Destroy()
		end)
		new.Timer:TweenSize(UDim2.new(0,0,0,2),Enum.EasingDirection.InOut,Enum.EasingStyle.Linear,(ntime or math.max(5,(#nmessage/75))),true,function()
			new.Visible = false
			new:Destroy()
		end)
		return new
	elseif ntype == "critical" then
		local new = script.Parent.Parent.Parent.Parent.Notifications.NotificationButton:Clone()
		if env.Settings.HideMain == false then
			new.Parent = script.Parent.Parent.Parent.Parent.Notifications
			local pos = 1
			local foundpos = false
			local whichposfound = 0
			repeat 
				for _,v in pairs(script.Parent.Parent.Parent.Parent.Notifications:GetChildren()) do
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
			new.Position = UDim2.new(0, 15,1, (-10 - 45 * (pos-1)))
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
		new.Timer:TweenSize(UDim2.new(0,0,0,2),Enum.EasingDirection.InOut,Enum.EasingStyle.Linear,(ntime or math.max(60,(#nmessage/30))),true,function()
			new.Visible = false
			new:Destroy()
		end)
		return new
	elseif ntype == "custom" then -- This is ran by the server and shall not be handled by the client. Added in V.04 build 27A.
		local new = inst
		if env.Settings.HideMain == false then
			new.Parent = script.Parent.Parent.Parent.Parent.Notifications
			local pos = 1
			local foundpos = false
			local whichposfound = 0
			repeat 
				for _,v in pairs(script.Parent.Parent.Parent.Parent.Notifications:GetChildren()) do
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
			new.Position = UDim2.new(0, 15,1, (-10 - 45 * (pos-1)))
		end
		new.Visible = true
		return new
	elseif ntype == "notification" then
		local new = script.Parent.Parent.Parent.Parent.Notifications.NotificationButton:Clone()
		if env.Settings.HideMain == false then
			new.Parent = script.Parent.Parent.Parent.Parent.Notifications
			local pos = 1
			local foundpos = false
			local whichposfound = 0
			repeat 
				for _,v in pairs(script.Parent.Parent.Parent.Parent.Notifications:GetChildren()) do
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
			new.Position = UDim2.new(0, 15,1, (-10 - 45 * (pos-1)))
		end
		new.Text = nmessage
		new.TextColor3 = Color3.new(1, 1, 1)
		if settings.LightMode.Value == true then
			new.TextColor3 = Color3.new(0, 0, 0)
			new.BackgroundColor3 = Color3.new(0.866667, 0.866667, 0.866667)
			new.Timer.BackgroundColor3 = Color3.new(0,0,0)
		end
		new.Visible = true
		new.Notification:Play()
		new.MouseButton1Click:Connect(function()
			new.Click:Play()
			new.Visible = false
			wait(1)
			new:Destroy()
		end)
		new.Timer:TweenSize(UDim2.new(0,0,0,2),Enum.EasingDirection.InOut,Enum.EasingStyle.Linear,(ntime or math.max(10,(#nmessage/30))),true,function()
			new.Visible = false
			wait(1)
			new:Destroy()
		end)
		return new
	end
end

function module.New(ntype,nmessage,ntime,inst)
	local player = game:GetService("Players").LocalPlayer
	local env = { -- Temporary lmfao
		Settings = {
			HideMain = false
		}
	}
	if ntype == "pwelcome" then
		local new = script.Parent.Parent.Parent.Parent.Notifications.NotificationButton:Clone()
		new.AnchorPoint = Vector2.new(0,1)
		if env.Settings.HideMain == false then
			new.Parent = script.Parent.Parent.Parent.Parent.Notifications
			local pos = 1
			local foundpos = false
			local whichposfound = 0
			repeat 
				for _,v in pairs(script.Parent.Parent.Parent.Parent.Notifications:GetChildren()) do
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
			new.Position = UDim2.new(0, 15,1, 0)
			new:TweenPosition(UDim2.new(0, 15,1, (-10 - 45 * (pos-1))),Enum.EasingDirection.Out,Enum.EasingStyle.Quart,0.5,true)
		end
		if env.Settings.SeasonalThemes == true then
			new.decoration.Visible = true
		else
			new.decoration.Visible = false
		end
		new.Text = nmessage
		new.TextColor3 = Color3.new(0,0.666667,1)
		if settings.LightMode.Value == true then
			new.TextColor3 = Color3.new(0, 0.333333, 1)
			new.BackgroundColor3 = Color3.new(0.866667, 0.866667, 0.866667)
		end
		new.Visible = true
		new:FindFirstChild("Sound"..math.random(1,4)):Play()
		new.MouseButton1Click:Connect(function()
			new.Click:Play()
			new.Visible = false
			module.HandleEnd(new.posnum.Value)
			wait(0.3)
			new:Destroy()
		end)
		new.Timer.Visible = false
		return new
	elseif ntype == "pdone" then
		local new = script.Parent.Parent.Parent.Parent.Notifications.NotificationButton:Clone()
		if env.Settings.HideMain == false then
			new.Parent = script.Parent.Parent.Parent.Parent.Notifications
			local pos = 1
			local foundpos = false
			local whichposfound = 0
			repeat 
				for _,v in pairs(script.Parent.Parent.Parent.Parent.Notifications:GetChildren()) do
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
			new.Position = UDim2.new(0, 15,1, 0)
			new:TweenPosition(UDim2.new(0, 15,1, (-10 - 45 * (pos-1))),Enum.EasingDirection.Out,Enum.EasingStyle.Quart,0.5,true)
		end
		if env.Settings.SeasonalThemes == true then
			new.decoration.Visible = true
		else
			new.decoration.Visible = false
		end
		new.Text = nmessage
		new.TextColor3 = Color3.new(0.666667, 1, 0.498039)
		if settings.LightMode.Value == true then
			new.TextColor3 = Color3.new(0.333333, 0.666667, 0)
			new.BackgroundColor3 = Color3.new(0.866667, 0.866667, 0.866667)
		end
		new.Visible = true
		new:FindFirstChild("Sound"..math.random(1,4)):Play()
		new.MouseButton1Click:Connect(function()
			new.Click:Play()
			new.Visible = false
			module.HandleEnd(new.posnum.Value)
			wait(0.3)
			new:Destroy()
		end)
		new.Timer.Visible = false
		return new
	elseif ntype == "perror" then
		local new = script.Parent.Parent.Parent.Parent.Notifications.NotificationButton:Clone()
		if env.Settings.HideMain == false then
			new.Parent = script.Parent.Parent.Parent.Parent.Notifications
			local pos = 1
			local foundpos = false
			local whichposfound = 0
			repeat 
				for _,v in pairs(script.Parent.Parent.Parent.Parent.Notifications:GetChildren()) do
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
			new.Position =  UDim2.new(0, 15,1, (-10 - 45 * (pos-1)))
		end
		if env.Settings.SeasonalThemes == true then
			new.decoration.Visible = true
		else
			new.decoration.Visible = false
		end
		new.Text = nmessage
		new.TextColor3 = Color3.new(1,0.666667,0)
		if settings.LightMode.Value == true then
			new.TextColor3 = Color3.new(1, 0.333333, 0)
			new.BackgroundColor3 = Color3.new(0.866667, 0.866667, 0.866667)
		end
		new.Visible = true
		new.Error:Play()
		new.MouseButton1Click:Connect(function()
			new.Click:Play()
			new.Visible = false
			module.HandleEnd(new.posnum.Value)
			wait(0.3)
			new:Destroy()
		end)
		new.Timer.Visible = false
		return new
	elseif ntype == "pcritical" then
		local new = script.Parent.Parent.Parent.Parent.Notifications.NotificationButton:Clone()
		if env.Settings.HideMain == false then
			new.Parent = script.Parent.Parent.Parent.Parent.Notifications
			local pos = 1
			local foundpos = false
			local whichposfound = 0
			repeat 
				for _,v in pairs(script.Parent.Parent.Parent.Parent.Notifications:GetChildren()) do
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
			new.Position =  UDim2.new(0, 15,1, (-10 - 45 * (pos-1)))
		end
		new.Text = nmessage
		new.TextColor3 = Color3.new(1, 1, 1)
		new.BackgroundColor3 = Color3.new(1,0.345098,0.345098)
		new.Visible = true
		new.Critical:Play()
		new.MouseButton1Click:Connect(function()
			new.Click:Play()
			new.Visible = false
			module.HandleEnd(new.posnum.Value)
			wait(0.3)
			new:Destroy()
		end)
		new.Timer.Visible = false
		return new
	elseif ntype == "pnotification" then
		local new = script.Parent.Parent.Parent.Parent.Notifications.NotificationButton:Clone()
		if env.Settings.HideMain == false then
			new.Parent = script.Parent.Parent.Parent.Parent.Notifications
			local pos = 1
			local foundpos = false
			local whichposfound = 0
			repeat 
				for _,v in pairs(script.Parent.Parent.Parent.Parent.Notifications:GetChildren()) do
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
			new.Position =  UDim2.new(0, 15,1, (-10 - 45 * (pos-1)))
		end
		if env.Settings.SeasonalThemes == true then
			new.decoration.Visible = true
		else
			new.decoration.Visible = false
		end
		new.Text = nmessage
		new.TextColor3 = Color3.new(1, 1, 1)
		if settings.LightMode.Value == true then
			new.TextColor3 = Color3.new(0.117647, 0.117647, 0.117647)
			new.BackgroundColor3 = Color3.new(0.866667, 0.866667, 0.866667)
		end
		new.Visible = true
		new.Notification:Play()
		new.MouseButton1Click:Connect(function()
			new.Click:Play()
			new.Visible = false
			module.HandleEnd(new.posnum.Value)
			wait(1)
			new:Destroy()
		end)
		new.Timer.Visible = false
		return new
	elseif ntype == "welcome" then
		local new = script.Parent.Parent.Parent.Parent.Notifications.NotificationButton:Clone()
		if env.Settings.HideMain == false then
			new.Parent = script.Parent.Parent.Parent.Parent.Notifications
			local pos = 1
			local foundpos = false
			local whichposfound = 0
			repeat 
				for _,v in pairs(script.Parent.Parent.Parent.Parent.Notifications:GetChildren()) do
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
			new.Position =  UDim2.new(0, 15,1, (-10 - 45 * (pos-1)))
		end
		if env.Settings.SeasonalThemes == true then
			new.decoration.Visible = true
		else
			new.decoration.Visible = false
		end
		new.Text = nmessage
		new.TextColor3 = Color3.new(0,0.666667,1)
		if settings.LightMode.Value == true then
			new.TextColor3 = Color3.new(0, 0.333333, 1)
			new.BackgroundColor3 = Color3.new(0.866667, 0.866667, 0.866667)
			new.Timer.BackgroundColor3 = Color3.new(0,0,0)
		end
		new.Visible = true
		new:FindFirstChild("Sound"..math.random(1,4)):Play()
		new.MouseButton1Click:Connect(function()
			new.Click:Play()
			new.Visible = false
			module.HandleEnd(new.posnum.Value)
			wait(0.3)
			new:Destroy()
		end)
		new.Timer:TweenSize(UDim2.new(0,0,0,2),Enum.EasingDirection.InOut,Enum.EasingStyle.Linear,(ntime or math.max(10,(#nmessage/75))),true,function()
			new.Visible = false
			module.HandleEnd(new.posnum.Value)
			new:Destroy()
		end)
		return new
	elseif ntype == "done" then
		local new = script.Parent.Parent.Parent.Parent.Notifications.NotificationButton:Clone()
		if env.Settings.HideMain == false then
			new.Parent = script.Parent.Parent.Parent.Parent.Notifications
			local pos = 1
			local foundpos = false
			local whichposfound = 0
			repeat 
				for _,v in pairs(script.Parent.Parent.Parent.Parent.Notifications:GetChildren()) do
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
			new.Position = UDim2.new(0, 15,1, 0)
			new:TweenPosition(UDim2.new(0, 15,1, (-10 - 45 * (pos-1))),Enum.EasingDirection.Out,Enum.EasingStyle.Quart,0.5,true)
		end
		if env.Settings.SeasonalThemes == true then
			new.decoration.Visible = true
		else
			new.decoration.Visible = false
		end
		new.Text = nmessage
		new.TextColor3 = Color3.new(0.666667, 1, 0.498039)
		if settings.LightMode.Value == true then
			new.TextColor3 = Color3.new(0.333333, 0.666667, 0)
			new.BackgroundColor3 = Color3.new(0.866667, 0.866667, 0.866667)
			new.Timer.BackgroundColor3 = Color3.new(0,0,0)
		end
		new.Visible = true
		new:FindFirstChild("Sound"..math.random(1,4)):Play()
		new.MouseButton1Click:Connect(function()
			new.Click:Play()
			new.Visible = false
			module.HandleEnd(new.posnum.Value)
			wait(0.3)
			new:Destroy()
		end)
		new.Timer:TweenSize(UDim2.new(0,0,0,2),Enum.EasingDirection.InOut,Enum.EasingStyle.Linear,(ntime or math.max(3,(#nmessage/70))),true,function()
			new.Visible = false
			module.HandleEnd(new.posnum.Value)
			new:Destroy()
		end)
		return new
	elseif ntype == "error" then
		local new = script.Parent.Parent.Parent.Parent.Notifications.NotificationButton:Clone()
		if env.Settings.HideMain == false then
			new.Parent = script.Parent.Parent.Parent.Parent.Notifications
			local pos = 1
			local foundpos = false
			local whichposfound = 0
			repeat 
				for _,v in pairs(script.Parent.Parent.Parent.Parent.Notifications:GetChildren()) do
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
			new.Position =  UDim2.new(0, 15,1, (-10 - 45 * (pos-1)))
		end
		if env.Settings.SeasonalThemes == true then
			new.decoration.Visible = true
		else
			new.decoration.Visible = false
		end
		new.Text = nmessage
		new.TextColor3 = Color3.new(1,0.666667,0)
		if settings.LightMode.Value == true then
			new.TextColor3 = Color3.new(1, 0.333333, 0)
			new.BackgroundColor3 = Color3.new(0.866667, 0.866667, 0.866667)
			new.Timer.BackgroundColor3 = Color3.new(0,0,0)
		end
		new.Visible = true
		new.Error:Play()
		new.MouseButton1Click:Connect(function()
			new.Click:Play()
			new.Visible = false
			module.HandleEnd(new.posnum.Value)
			wait(0.3)
			new:Destroy()
		end)
		new.Timer:TweenSize(UDim2.new(0,0,0,2),Enum.EasingDirection.InOut,Enum.EasingStyle.Linear,(ntime or math.max(5,(#nmessage/75))),true,function()
			new.Visible = false
			module.HandleEnd(new.posnum.Value)
			new:Destroy()
		end)
		return new
	elseif ntype == "critical" then
		local new = script.Parent.Parent.Parent.Parent.Notifications.NotificationButton:Clone()
		if env.Settings.HideMain == false then
			new.Parent = script.Parent.Parent.Parent.Parent.Notifications
			local pos = 1
			local foundpos = false
			local whichposfound = 0
			repeat 
				for _,v in pairs(script.Parent.Parent.Parent.Parent.Notifications:GetChildren()) do
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
			new.Position = UDim2.new(0, 15,1, 0)
			new:TweenPosition(UDim2.new(0, 15,1, (-10 - 45 * (pos-1))),Enum.EasingDirection.Out,Enum.EasingStyle.Quart,0.5,true)
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
			module.HandleEnd(new.posnum.Value)
			wait(0.3)
			new:Destroy()
		end)
		new.Timer:TweenSize(UDim2.new(0,0,0,2),Enum.EasingDirection.InOut,Enum.EasingStyle.Linear,(ntime or math.max(60,(#nmessage/30))),true,function()
			new.Visible = false
			module.HandleEnd(new.posnum.Value)
			new:Destroy()
		end)
		return new
	elseif ntype == "custom" then -- This is ran by the server and shall not be handled by the client. Added in V.04 build 27A.
		local new = inst
		if env.Settings.HideMain == false then
			new.Parent = script.Parent.Parent.Parent.Parent.Notifications
			local pos = 1
			local foundpos = false
			local whichposfound = 0
			repeat 
				for _,v in pairs(script.Parent.Parent.Parent.Parent.Notifications:GetChildren()) do
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
			new.Position = UDim2.new(0, 15,1, 0)
			new:TweenPosition(UDim2.new(0, 15,1, (-10 - 45 * (pos-1))),Enum.EasingDirection.Out,Enum.EasingStyle.Quart,0.5,true)
		end
		new.Visible = true
		return new
	elseif ntype == "notification" then
		local new = script.Parent.Parent.Parent.Parent.Notifications.NotificationButton:Clone()
		if env.Settings.HideMain == false then
			new.Parent = script.Parent.Parent.Parent.Parent.Notifications
			local pos = 1
			local foundpos = false
			local whichposfound = 0
			repeat 
				for _,v in pairs(script.Parent.Parent.Parent.Parent.Notifications:GetChildren()) do
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
			new.Position = UDim2.new(0, 15,1, 0)
			new:TweenPosition(UDim2.new(0, 15,1, (-10 - 45 * (pos-1))),Enum.EasingDirection.Out,Enum.EasingStyle.Quart,0.5,true)
		end
		new.Text = nmessage
		new.TextColor3 = Color3.new(1, 1, 1)
		if settings.LightMode.Value == true then
			new.TextColor3 = Color3.new(0, 0, 0)
			new.BackgroundColor3 = Color3.new(0.866667, 0.866667, 0.866667)
			new.Timer.BackgroundColor3 = Color3.new(0,0,0)
		end
		new.Visible = true
		new.Notification:Play()
		new.MouseButton1Click:Connect(function()
			new.Click:Play()
			new.Visible = false
			module.HandleEnd(new.posnum.Value)
			wait(1)
			new:Destroy()
		end)
		new.Timer:TweenSize(UDim2.new(0,0,0,2),Enum.EasingDirection.InOut,Enum.EasingStyle.Linear,(ntime or math.max(10,(#nmessage/30))),true,function()
			new.Visible = false
			module.HandleEnd(new.posnum.Value)
			new:Destroy()
		end)
		return new
	end
end

return module
