http = game:GetService("HttpService") -- for json ig
setsfolder = script.Parent.Parent.LocalSettings
func = game:GetService("ReplicatedStorage"):FindFirstChild("RARemoteFunction")

function loadSettings() -- Loads settings.
	-- full: 24h,buttoncolour,buttontext,dndsettings (array, look below),datetype,maintint,spinnertint,textcolour
	-- dndsettings: donotshow,excludecritical,ignorepings,soundmute
	
	local load = func:InvokeServer({"uiload"})
	if not load[1] then
		load[1] = '[true,[0,0.6667,1],"R:A",false,true,false,true,false,1,[0,0,0],[0,0,0],"Borealis",false]'
	end
	
	load[1] = http:JSONDecode(load[1])
	
	setsfolder["24h"].Value = load[1][1]
	setsfolder.ButtonColour.Value = Color3.new(load[1][2][1],load[1][2][2],load[1][2][3])
	setsfolder.ButtonText.Value = load[1][3]
	setsfolder.DND.DoNotShow.Value = load[1][4]
	setsfolder.DND.ExcludeCritical.Value = load[1][5]
	setsfolder.DND.IgnorePings.Value = load[1][6]
	setsfolder.DND.SoundMute.Value = load[1][7]
	setsfolder.DateType.Value = load[1][8]
	setsfolder.MainTint.Value = load[1][9]
	setsfolder.SpinnerTint.Value = Color3.new(load[1][10][1],load[1][10][2],load[1][10][3])
	setsfolder.TextColour.Value = Color3.new(load[1][11][1],load[1][11][2],load[1][11][3])
	setsfolder.LightMode.Value = load[1][13] or false
	
	if not load[1][12] then load[1][12] = "Borealis" end
	script.Parent.Client.Sounds.ActiveSet.Value = load[1][12]
	local soundfold = script.Parent.Client.Sounds.ScrollingFrame:FindFirstChild(load[1][12])
	if soundfold then
		for _,v in pairs(soundfold:GetChildren()) do
			if v:IsA("Sound") then
				for _,a in pairs(script.Parent.Parent.Notifications:GetChildren()) do
					a:FindFirstChild(v.Name):Destroy()
					local s = v:Clone()
					s.Parent = a
				end
			end
		end
	else
		for _,v in pairs(script.Parent.Client.Sounds.ScrollingFrame.Borealis:GetChildren()) do
			if v:IsA("Sound") then
				for _,a in pairs(script.Parent.Parent.Notifications:GetChildren()) do
					a:FindFirstChild(v.Name):Destroy()
					local s = v:Clone()
					s.Parent = a
				end
			end
		end
	end
	
	if load[2] == true then
		script.Parent.Parent.Main.Visible = false
	end
end

function saveSettings(array) -- Saves settings.
	local save = func:InvokeServer({"uisave",array})
	if save then
		print("Settings saved successfully.")
	else
		warn("An error has occured while saving.")
	end
end

loadSettings() -- Upon player loaded, make sure this is activated. This will load all of the settings.

script.Parent.Client.MenuButton.Save.MouseButton1Click:Connect(function()
	-- full: 24h,buttoncolour,buttontext,dndsettings (array, look below),datetype,maintint,spinnertint,textcolour
	-- dndsettings: donotshow,excludecritical,ignorepings,soundmute
	local settingslol = {
		setsfolder:FindFirstChild("24h").Value,
		{setsfolder.ButtonColour.Value.R,setsfolder.ButtonColour.Value.G,setsfolder.ButtonColour.Value.B},
		setsfolder.ButtonText.Value,
		-- dnd settings
		setsfolder.DND.DoNotShow.Value,
		setsfolder.DND.ExcludeCritical.Value,
		setsfolder.DND.IgnorePings.Value,
		setsfolder.DND.SoundMute.Value,
		setsfolder.DateType.Value,
		setsfolder.MainTint.Value,
		{setsfolder.SpinnerTint.Value.R,setsfolder.SpinnerTint.Value.G,setsfolder.SpinnerTint.Value.B},
		{setsfolder.TextColour.Value.R,setsfolder.TextColour.Value.G,setsfolder.TextColour.Value.B},
		script.Parent.Client.Sounds.ActiveSet.Value,
		setsfolder.LightMode.Value,
	}
	settingslol = http:JSONEncode(settingslol)
	saveSettings(settingslol)
end)

script.Parent.Client.Sounds.Save.MouseButton1Click:Connect(function()
	-- full: 24h,buttoncolour,buttontext,dndsettings (array, look below),datetype,maintint,spinnertint,textcolour
	-- dndsettings: donotshow,excludecritical,ignorepings,soundmute
	local settingslol = {
		setsfolder:FindFirstChild("24h").Value,
		{setsfolder.ButtonColour.Value.R,setsfolder.ButtonColour.Value.G,setsfolder.ButtonColour.Value.B},
		setsfolder.ButtonText.Value,
		-- dnd settings
		setsfolder.DND.DoNotShow.Value,
		setsfolder.DND.ExcludeCritical.Value,
		setsfolder.DND.IgnorePings.Value,
		setsfolder.DND.SoundMute.Value,
		setsfolder.DateType.Value,
		setsfolder.MainTint.Value,
		{setsfolder.SpinnerTint.Value.R,setsfolder.SpinnerTint.Value.G,setsfolder.SpinnerTint.Value.B},
		{setsfolder.TextColour.Value.R,setsfolder.TextColour.Value.G,setsfolder.TextColour.Value.B},
		script.Parent.Client.Sounds.ActiveSet.Value,
		setsfolder.LightMode.Value,
	}
	settingslol = http:JSONEncode(settingslol)
	saveSettings(settingslol)
end)