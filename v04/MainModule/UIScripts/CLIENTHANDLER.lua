local ts = game:GetService("TweenService")
local event = game:GetService("ReplicatedStorage"):FindFirstChild("RedefineANotificationsHandler")
local func = game:GetService("ReplicatedStorage"):FindFirstChild("RARFN")
local UserInputService = game:GetService("UserInputService")

local active = false
local debounceactive = false
local mousein = false
local settingsfile = script.Parent.Parent.Parent.LocalSettings
local buttonbright = false
local buttoncolour = Color3.fromRGB(0,170,255)
local notifier = require(script.NotifyLocal)

local savednotifications = {} -- Due to the settings, we need to keep this in mind.

function MenuOpen(Source)
	if not debounceactive then
		if UserInputService:GetFocusedTextBox() then return end
		active = true
		script.Parent.Kopete_status:Play()
		script.Parent.TextColor3 = Color3.fromRGB(255,255,255)
		if not mousein then
			ts:Create(script.Parent,TweenInfo.new(0.25,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
				TextColor3 = buttoncolour
			}):Play()
		else
			local goal = buttoncolour
			if buttonbright then
				goal = Color3.new(buttoncolour.R-0.3,buttoncolour.G-0.3,buttoncolour.B-0.3)
			else
				goal = Color3.new(buttoncolour.R+0.3,buttoncolour.G+0.3,buttoncolour.B+0.3)
			end
			ts:Create(script.Parent,TweenInfo.new(0.25,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
				TextColor3 = goal
			}):Play()
		end
		debounceactive = true
		if Source == "Keybind" then
			script.Parent.Parent.Info.Position = UDim2.new(-4.2,-100,0,0)
			ts:Create(script.Parent.Parent.spin,TweenInfo.new(0.25,Enum.EasingStyle.Bounce,Enum.EasingDirection.Out),{
				Rotation = 90
			}):Play()
			wait(0.25)
			script.Parent.Parent.spin:TweenPosition(UDim2.new(0,-100,0,0),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.25,true)
			wait(0.25)
			ts:Create(script.Parent.Parent.info_time,TweenInfo.new(0.25,Enum.EasingStyle.Bounce,Enum.EasingDirection.Out),{
				BackgroundTransparency = 0
			}):Play()
			ts:Create(script.Parent.Parent.info_time.time,TweenInfo.new(0.25,Enum.EasingStyle.Bounce,Enum.EasingDirection.Out),{
				TextTransparency = 0
			}):Play()
			ts:Create(script.Parent.Parent.info_time.date,TweenInfo.new(0.25,Enum.EasingStyle.Bounce,Enum.EasingDirection.Out),{
				TextTransparency = 0
			}):Play()
			ts:Create(script.Parent.Parent,TweenInfo.new(0.25,Enum.EasingStyle.Bounce,Enum.EasingDirection.Out),{
				BackgroundTransparency = 0
			}):Play()
			debounceactive = false
			wait(1)
			if active then -- If still active, let's guess the user wants the sidebuttons.
				script.Parent.Parent.additionals:TweenPosition(UDim2.new(0,0,0,-180),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.25,true)
			end
		else
			script.Parent.Parent.Info.Position = UDim2.new(-4.2,-100,0,0)
			ts:Create(script.Parent.Parent.spin,TweenInfo.new(0.25,Enum.EasingStyle.Bounce,Enum.EasingDirection.Out),{
				Rotation = 90
			}):Play()
			wait(0.25)
			script.Parent.Parent.spin:TweenPosition(UDim2.new(0,-100,0,0),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.25,true)
			wait(0.25)
			script.Parent.Parent.additionals:TweenPosition(UDim2.new(0,0,0,-180),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.25,true)
			ts:Create(script.Parent.Parent.info_time,TweenInfo.new(0.25,Enum.EasingStyle.Bounce,Enum.EasingDirection.Out),{
				BackgroundTransparency = 0
			}):Play()
			ts:Create(script.Parent.Parent.info_time.time,TweenInfo.new(0.25,Enum.EasingStyle.Bounce,Enum.EasingDirection.Out),{
				TextTransparency = 0
			}):Play()
			ts:Create(script.Parent.Parent.info_time.date,TweenInfo.new(0.25,Enum.EasingStyle.Bounce,Enum.EasingDirection.Out),{
				TextTransparency = 0
			}):Play()
			ts:Create(script.Parent.Parent,TweenInfo.new(0.25,Enum.EasingStyle.Bounce,Enum.EasingDirection.Out),{
				BackgroundTransparency = 0
			}):Play()
			debounceactive = false
		end
	else return false
	end
end

function OpenSettings(Frame,Page)
	local settingsUI = script.Parent.Parent.Parent.Settings
	if Frame == "Client" then
		if settingsUI:FindFirstChild("Toggler") then
			settingsUI.Toggler.Text = "Client"
			settingsUI.Toggler.BackgroundColor3 = Color3.fromRGB(0,170,255)
			settingsUI.Server.Visible = false
		end
		settingsUI.Client.Visible = true
		settingsUI.Client.DND.Visible = false
		settingsUI.Client.MenuButton.Visible = false
		settingsUI.Client[Page].Visible = true
		if Page == "DND" then
			settingsUI.Client.settings_frame.mover.Position = UDim2.new(0,0,1,0)
		elseif Page == "MenuButton" then
			settingsUI.Client.settings_frame.mover.Position = UDim2.new(0,150,1,0)
		end
	elseif Frame == "Server" and settingsUI.IsServerAccessible.Value == true then
		settingsUI.Toggler.Text = "Server"
		settingsUI.Toggler.BackgroundColor3 = Color3.fromRGB(0,170,0)
		settingsUI.Server.Visible = true
		settingsUI.Client.Visible = false
		settingsUI.Server.Admins.Visible = false
		settingsUI.Server.Datastore.Visible = false
		settingsUI.Server.General.Visible = false
		settingsUI.Server[Page].Visible = true
	end
	if settingsUI.Visible == false then
		settingsUI.Position = UDim2.new(0.5,0,0.5,0)
	end
	settingsUI.Visible = true
end

function MenuClose(Source)
	if not debounceactive then
		if UserInputService:GetFocusedTextBox() then return end
		active = false
		script.Parent.Parent.AboutFrame.Visible = false
		script.Parent.Kopete_status:Play()
		script.Parent.TextColor3 = Color3.fromRGB(255,255,255)
		if not mousein then
			ts:Create(script.Parent,TweenInfo.new(0.25,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
				TextColor3 = buttoncolour
			}):Play()
		else
			local goal = buttoncolour
			if buttonbright then
				goal = Color3.new(buttoncolour.R-0.3,buttoncolour.G-0.3,buttoncolour.B-0.3)
			else
				goal = Color3.new(buttoncolour.R+0.3,buttoncolour.G+0.3,buttoncolour.B+0.3)
			end
			ts:Create(script.Parent,TweenInfo.new(0.25,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
				TextColor3 = goal
			}):Play()
		end
		debounceactive = true
		script.Parent.Parent.Info.Position = UDim2.new(-4.2,0,0,0)
		ts:Create(script.Parent.Parent.info_time,TweenInfo.new(0.1,Enum.EasingStyle.Bounce,Enum.EasingDirection.Out),{
			BackgroundTransparency = 1
		}):Play()
		ts:Create(script.Parent.Parent.info_time.time,TweenInfo.new(0.25,Enum.EasingStyle.Bounce,Enum.EasingDirection.Out),{
			TextTransparency = 1
		}):Play()
		ts:Create(script.Parent.Parent.info_time.date,TweenInfo.new(0.25,Enum.EasingStyle.Bounce,Enum.EasingDirection.Out),{
			TextTransparency = 1
		}):Play()
		ts:Create(script.Parent.Parent,TweenInfo.new(0.1,Enum.EasingStyle.Bounce,Enum.EasingDirection.Out),{
			BackgroundTransparency = 0.6
		}):Play()
		script.Parent.Parent.additionals:TweenPosition(UDim2.new(0,80,0,-180),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.25,true)
		wait(0.1)
		script.Parent.Parent.spin:TweenPosition(UDim2.new(0,0,0,0),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.25,true)
		wait(0.25)
		ts:Create(script.Parent.Parent.spin,TweenInfo.new(0.25,Enum.EasingStyle.Bounce,Enum.EasingDirection.Out),{
			Rotation = 0
		}):Play()
		debounceactive = false
		return true
	else
		return false
	end
end

script.Parent.MouseEnter:Connect(function()
	mousein = true
	if not active and not debounceactive then
		ts:Create(script.Parent.Parent.spin,TweenInfo.new(0.25,Enum.EasingStyle.Bounce,Enum.EasingDirection.Out),{
			Rotation = 30
		}):Play()
	end
	local goal = buttoncolour
	if buttonbright then
		goal = Color3.new(buttoncolour.R-0.3,buttoncolour.G-0.3,buttoncolour.B-0.3)
	else
		goal = Color3.new(buttoncolour.R+0.3,buttoncolour.G+0.3,buttoncolour.B+0.3)
	end
	ts:Create(script.Parent,TweenInfo.new(0.25,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
		TextColor3 = goal
	}):Play()
end)

script.Parent.MouseLeave:Connect(function()
	mousein = false
	if not active and not debounceactive then
		ts:Create(script.Parent.Parent.spin,TweenInfo.new(0.25,Enum.EasingStyle.Bounce,Enum.EasingDirection.Out),{
			Rotation = 0
		}):Play()
	end
	ts:Create(script.Parent,TweenInfo.new(0.25,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
		TextColor3 = buttoncolour
	}):Play()
end)

script.Parent.Parent.Parent.InternalCommunication.Event:Connect(function(firetype,info) -- Temporary.
	if firetype == "Ping" then
		if not (script.Parent.Parent.Parent.LocalSettings.DND.IgnorePings.Value == true and script.Parent.Parent.Parent.LocalSettings.DND.Value == true) then
			script.Parent.TextColor3 = Color3.fromRGB(255,255,255)
			if not (script.Parent.Parent.Parent.LocalSettings.DND.Value == true and script.Parent.Parent.Parent.LocalSettings.DND.SoundMute.Value == true)then
				script["Audio/dialog-information"]:Play()
			end
			if not mousein then
				ts:Create(script.Parent,TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
					TextColor3 = buttoncolour
				}):Play()
				if not active then
					script.Parent.Parent.spin.Rotation = script.Parent.Parent.spin.Rotation+359
					ts:Create(script.Parent.Parent.spin,TweenInfo.new(0.5,Enum.EasingStyle.Bounce,Enum.EasingDirection.Out),{
						Rotation = 0
					}):Play()
				end
			else
				local goal = buttoncolour
				if buttonbright then
					goal = Color3.new(buttoncolour.R-0.3,buttoncolour.G-0.3,buttoncolour.B-0.3)
				else
					goal = Color3.new(buttoncolour.R+0.3,buttoncolour.G+0.3,buttoncolour.B+0.3)
				end
				ts:Create(script.Parent,TweenInfo.new(0.25,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
					TextColor3 = goal
				}):Play()
				if not active then
					script.Parent.Parent.spin.Rotation = script.Parent.Parent.spin.Rotation+359
					ts:Create(script.Parent.Parent.spin,TweenInfo.new(0.5,Enum.EasingStyle.Bounce,Enum.EasingDirection.Out),{
						Rotation = 30
					}):Play()
				end
			end
			script.Parent.Parent.Info.Text = "Ping Received!"
			script.Parent.Parent.Info.TextTransparency = 0
			script.Parent.Parent.Info.TextStrokeTransparency = 0.7
			ts:Create(script.Parent.Parent.Info,TweenInfo.new(3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
				TextTransparency = 1,
				TextStrokeTransparency = 1
			}):Play()
		end
	elseif firetype == "ViewPlayer" then
		if info == nil then
			game.Workspace.CurrentCamera.CameraType = 'Custom'
			game.Workspace.CurrentCamera.FieldOfView = 70
			game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
		elseif info then
			game.Workspace.CurrentCamera.CameraSubject = info.Character.Humanoid
		end
		return
	elseif firetype == "Notify" then
		script.Parent.TextColor3 = Color3.fromRGB(255,255,255)
		if not mousein then
			ts:Create(script.Parent,TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
				TextColor3 = buttoncolour
			}):Play()
			if not active then
				script.Parent.Parent.spin.Rotation = script.Parent.Parent.spin.Rotation+359
				ts:Create(script.Parent.Parent.spin,TweenInfo.new(0.5,Enum.EasingStyle.Bounce,Enum.EasingDirection.Out),{
					Rotation = 0
				}):Play()
			end
		else
			local goal = buttoncolour
			if buttonbright then
				goal = Color3.new(buttoncolour.R-0.3,buttoncolour.G-0.3,buttoncolour.B-0.3)
			else
				goal = Color3.new(buttoncolour.R+0.3,buttoncolour.G+0.3,buttoncolour.B+0.3)
			end
			ts:Create(script.Parent,TweenInfo.new(0.25,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
				TextColor3 = goal
			}):Play()
			if not active then
				script.Parent.Parent.spin.Rotation = script.Parent.Parent.spin.Rotation+359
				ts:Create(script.Parent.Parent.spin,TweenInfo.new(0.5,Enum.EasingStyle.Bounce,Enum.EasingDirection.Out),{
					Rotation = 30
				}):Play()
			end
		end
		if settingsfile.DND.DoNotShow.Value == true and settingsfile.DND.Value == true then
			if info[1] == "critical" and settingsfile.DND.ExcludeCritical.Value == true then
				notifier.New("critical",info[2])
			else
				savednotifications[#savednotifications+1] = {info[1],info[2]} -- This will be free'd up when the time comes.
			end
		else
			notifier.New(info[1],info[2])
		end
	elseif firetype == "OpenSettings" then
		OpenSettings("Client",info) -- If it's coming from the InternalCommunication, it's VERY likely from the client. No need to even check.
	elseif firetype == "MenuClose" then
		MenuClose(info)
	elseif firetype == "MenuOpen" then
		MenuOpen(info)
	end
end)

local function NotificationGet(firetype,info)
	if firetype == "Ping" then
		if not (script.Parent.Parent.Parent.LocalSettings.DND.IgnorePings.Value == true and script.Parent.Parent.Parent.LocalSettings.DND.Value == true) then
			script.Parent.TextColor3 = Color3.fromRGB(255,255,255)
			if not (script.Parent.Parent.Parent.LocalSettings.DND.Value == true and script.Parent.Parent.Parent.LocalSettings.DND.SoundMute.Value == true)then
				script["Audio/dialog-information"]:Play()
			end
			if not mousein then
				ts:Create(script.Parent,TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
					TextColor3 = buttoncolour
				}):Play()
				if not active then
					script.Parent.Parent.spin.Rotation = script.Parent.Parent.spin.Rotation+359
					ts:Create(script.Parent.Parent.spin,TweenInfo.new(0.5,Enum.EasingStyle.Bounce,Enum.EasingDirection.Out),{
						Rotation = 0
					}):Play()
				end
			else
				local goal = buttoncolour
				if buttonbright then
					goal = Color3.new(buttoncolour.R-0.3,buttoncolour.G-0.3,buttoncolour.B-0.3)
				else
					goal = Color3.new(buttoncolour.R+0.3,buttoncolour.G+0.3,buttoncolour.B+0.3)
				end
				ts:Create(script.Parent,TweenInfo.new(0.25,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
					TextColor3 = goal
				}):Play()
				if not active then
					script.Parent.Parent.spin.Rotation = script.Parent.Parent.spin.Rotation+359
					ts:Create(script.Parent.Parent.spin,TweenInfo.new(0.5,Enum.EasingStyle.Bounce,Enum.EasingDirection.Out),{
						Rotation = 30
					}):Play()
				end
			end
			script.Parent.Parent.Info.Text = "Ping Received!"
			script.Parent.Parent.Info.TextTransparency = 0
			script.Parent.Parent.Info.TextStrokeTransparency = 0.7
			ts:Create(script.Parent.Parent.Info,TweenInfo.new(3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
				TextTransparency = 1,
				TextStrokeTransparency = 1
			}):Play()
		end
	elseif firetype == "ViewPlayer" then
		if info == nil then
			game.Workspace.CurrentCamera.CameraType = 'Custom'
			game.Workspace.CurrentCamera.FieldOfView = 70
			game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
		elseif info then
			game.Workspace.CurrentCamera.CameraSubject = info.Character.Humanoid
		end
		return
	elseif firetype == "Mute" then
		game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
		return true
	elseif firetype == "Unmute" then
		game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
		return true
	elseif firetype == "Notify" then
		script.Parent.TextColor3 = Color3.fromRGB(255,255,255)
		if not mousein then
			ts:Create(script.Parent,TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
				TextColor3 = buttoncolour
			}):Play()
			if not active then
				script.Parent.Parent.spin.Rotation = script.Parent.Parent.spin.Rotation+359
				ts:Create(script.Parent.Parent.spin,TweenInfo.new(0.5,Enum.EasingStyle.Bounce,Enum.EasingDirection.Out),{
					Rotation = 0
				}):Play()
			end
		else
			local goal = buttoncolour
			if buttonbright then
				goal = Color3.new(buttoncolour.R-0.3,buttoncolour.G-0.3,buttoncolour.B-0.3)
			else
				goal = Color3.new(buttoncolour.R+0.3,buttoncolour.G+0.3,buttoncolour.B+0.3)
			end
			ts:Create(script.Parent,TweenInfo.new(0.25,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
				TextColor3 = goal
			}):Play()
			if not active then
				script.Parent.Parent.spin.Rotation = script.Parent.Parent.spin.Rotation+359
				ts:Create(script.Parent.Parent.spin,TweenInfo.new(0.5,Enum.EasingStyle.Bounce,Enum.EasingDirection.Out),{
					Rotation = 30
				}):Play()
			end
		end
		if settingsfile.DND.DoNotShow.Value == true and settingsfile.DND.Value == true then
			if info[1] == "critical" and settingsfile.DND.ExcludeCritical.Value == true then
				local msg = notifier.New("critical",info[2],info[3])
			else
				savednotifications[#savednotifications+1] = {info[1],info[2],info[3],info[4]} -- This will be free'd up when the time comes.
			end
		else
			local msg = notifier.New(info[1],info[2],info[3],info[4])
		end
	elseif firetype == "broadcast" then
		if script.Parent.Parent.Parent:FindFirstChild("CurrentBroadcast") then
			script.Parent.Parent.Parent:FindFirstChild("CurrentBroadcast"):Destroy()
		end
		local b = script.Parent.Parent.Parent.Broadcast:Clone()
		if settingsfile.LightMode.Value == true then
			b.BackgroundColor3 = Color3.fromRGB(209,209,209)
			b.Message.TextColor3 = Color3.new(0,0,0)
		end
		b.Message.Text = info[1]
		b.Header.Text = info[2]
		b.Parent = script.Parent.Parent.Parent
		b.Name = "CurrentBroadcast"
		b:TweenPosition(UDim2.new(0.5,0,0.5,0),Enum.EasingDirection.InOut,Enum.EasingStyle.Quint,0.5,true)
		b.Close.LocalScript.Disabled = false
		b.Notification:Play()
	elseif firetype == "OpenSettings" then
		OpenSettings("Client","DND")
	elseif firetype == "MenuClose" then
		MenuClose(info)
	elseif firetype == "MenuOpen" then
		MenuOpen(info)
	end
end

func.OnClientInvoke = NotificationGet

game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed) -- i hate this.
	if input.KeyCode == Enum.KeyCode.Equals then
		if not settingsfile.Console.Value == true then
			if not debounceactive then
				if not active then
					MenuOpen("Keybind")
				elseif active then
					MenuClose("Keybind")
				end
			end
		elseif settingsfile.Console.Value == true then
			script.Parent.Parent.Parent.InternalCommunication:Fire("OpenConsole","hi")
		end
	end
end)

script.Parent.MouseButton1Click:Connect(function()
	if not debounceactive then
		if not active then
			MenuOpen("Clicked")
		elseif active then
			MenuClose("Clicked")
		end
	end
end)

-- Detect all edits and change them accordingly.
settingsfile.ButtonText.Changed:Connect(function(new) -- ButtonText
	script.Parent.Text = new
end)

settingsfile.MainTint.Changed:Connect(function(new) -- Clock Tint
	if new == 1 then
		ts:Create(script.Parent.Parent.info_time,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
			BackgroundColor3 = Color3.fromRGB(175,175,175)
		}):Play()
		ts:Create(script.Parent.Parent,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
			BackgroundColor3 = Color3.fromRGB(175,175,175)
		}):Play()
		script.Parent.Parent.Parent.CmdBar.BackgroundColor3 = Color3.fromRGB(175,175,175)
		script.Parent.Parent.Parent.CmdBar.Side1.BackgroundColor3 = Color3.fromRGB(175,175,175)
		script.Parent.Parent.Parent.CmdBar.Side2.BackgroundColor3 = Color3.fromRGB(175,175,175)
	elseif new == 2 then
		ts:Create(script.Parent.Parent.info_time,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
			BackgroundColor3 = Color3.fromRGB(45, 45, 45)
		}):Play()
		ts:Create(script.Parent.Parent,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
			BackgroundColor3 = Color3.fromRGB(45, 45, 45)
		}):Play()
		script.Parent.Parent.Parent.CmdBar.BackgroundColor3 = Color3.fromRGB(45,45,45)
		script.Parent.Parent.Parent.CmdBar.Side1.BackgroundColor3 = Color3.fromRGB(45,45,45)
		script.Parent.Parent.Parent.CmdBar.Side2.BackgroundColor3 = Color3.fromRGB(45,45,45)
	elseif new == 3 then
		ts:Create(script.Parent.Parent.info_time,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
			BackgroundColor3 = Color3.fromRGB(147,190,255)
		}):Play()
		ts:Create(script.Parent.Parent,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
			BackgroundColor3 = Color3.fromRGB(147,190,255)
		}):Play()
		script.Parent.Parent.Parent.CmdBar.BackgroundColor3 = Color3.fromRGB(147,190,255)
		script.Parent.Parent.Parent.CmdBar.Side1.BackgroundColor3 = Color3.fromRGB(147,190,255)
		script.Parent.Parent.Parent.CmdBar.Side2.BackgroundColor3 = Color3.fromRGB(147,190,255)
	elseif new == 4 then
		ts:Create(script.Parent.Parent.info_time,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
			BackgroundColor3 = Color3.fromRGB(130,255,134)
		}):Play()
		ts:Create(script.Parent.Parent,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
			BackgroundColor3 = Color3.fromRGB(130,255,134)
		}):Play()
		script.Parent.Parent.Parent.CmdBar.BackgroundColor3 = Color3.fromRGB(130,255,134)
		script.Parent.Parent.Parent.CmdBar.Side1.BackgroundColor3 = Color3.fromRGB(130,255,134)
		script.Parent.Parent.Parent.CmdBar.Side2.BackgroundColor3 = Color3.fromRGB(130,255,134)
	elseif new == 5 then
		ts:Create(script.Parent.Parent.info_time,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
			BackgroundColor3 = Color3.fromRGB(255,167,167)
		}):Play()
		ts:Create(script.Parent.Parent,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
			BackgroundColor3 = Color3.fromRGB(255,167,167)
		}):Play()
		script.Parent.Parent.Parent.CmdBar.BackgroundColor3 = Color3.fromRGB(255,167,167)
		script.Parent.Parent.Parent.CmdBar.Side1.BackgroundColor3 = Color3.fromRGB(255,167,167)
		script.Parent.Parent.Parent.CmdBar.Side2.BackgroundColor3 = Color3.fromRGB(255,167,167)
	elseif new == 6 then
		ts:Create(script.Parent.Parent.info_time,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
			BackgroundColor3 = Color3.fromRGB(255,255,127)
		}):Play()
		ts:Create(script.Parent.Parent,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
			BackgroundColor3 = Color3.fromRGB(255,255,127)
		}):Play()
		script.Parent.Parent.Parent.CmdBar.BackgroundColor3 = Color3.fromRGB(255,255,127)
		script.Parent.Parent.Parent.CmdBar.Side1.BackgroundColor3 = Color3.fromRGB(255,255,127)
		script.Parent.Parent.Parent.CmdBar.Side2.BackgroundColor3 = Color3.fromRGB(255,255,127)
	elseif new == 7 then
		ts:Create(script.Parent.Parent.info_time,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
			BackgroundColor3 = Color3.fromRGB(113,47,154)
		}):Play()
		ts:Create(script.Parent.Parent,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
			BackgroundColor3 = Color3.fromRGB(113,47,154)
		}):Play()
		script.Parent.Parent.Parent.CmdBar.BackgroundColor3 = Color3.fromRGB(113,47,154)
		script.Parent.Parent.Parent.CmdBar.Side1.BackgroundColor3 = Color3.fromRGB(113,47,154)
		script.Parent.Parent.Parent.CmdBar.Side2.BackgroundColor3 = Color3.fromRGB(113,47,154)
	elseif new == 8 then
		ts:Create(script.Parent.Parent.info_time,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
			BackgroundColor3 = Color3.fromRGB(100,197,140)
		}):Play()
		ts:Create(script.Parent.Parent,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
			BackgroundColor3 = Color3.fromRGB(100,197,140)
		}):Play()
		script.Parent.Parent.Parent.CmdBar.BackgroundColor3 = Color3.fromRGB(100,197,140)
		script.Parent.Parent.Parent.CmdBar.Side1.BackgroundColor3 = Color3.fromRGB(100,197,140)
		script.Parent.Parent.Parent.CmdBar.Side2.BackgroundColor3 = Color3.fromRGB(100,197,140)
	elseif new == 9 then
		ts:Create(script.Parent.Parent.info_time,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
			BackgroundColor3 = Color3.fromRGB(255,170,0)
		}):Play()
		ts:Create(script.Parent.Parent,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
			BackgroundColor3 = Color3.fromRGB(255,170,0)
		}):Play()
		script.Parent.Parent.Parent.CmdBar.BackgroundColor3 = Color3.fromRGB(255,170,0)
		script.Parent.Parent.Parent.CmdBar.Side1.BackgroundColor3 = Color3.fromRGB(255,170,0)
		script.Parent.Parent.Parent.CmdBar.Side2.BackgroundColor3 = Color3.fromRGB(255,170,0)
	elseif new == 10 then
		ts:Create(script.Parent.Parent.info_time,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
			BackgroundColor3 = Color3.fromRGB(117,58,0)
		}):Play()
		ts:Create(script.Parent.Parent,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
			BackgroundColor3 = Color3.fromRGB(117,58,0)
		}):Play()
		script.Parent.Parent.Parent.CmdBar.BackgroundColor3 = Color3.fromRGB(117,58,0)
		script.Parent.Parent.Parent.CmdBar.Side1.BackgroundColor3 = Color3.fromRGB(117,58,0)
		script.Parent.Parent.Parent.CmdBar.Side2.BackgroundColor3 = Color3.fromRGB(117,58,0)
	end
end)

settingsfile.ButtonColour.Changed:Connect(function(new) -- Button Tint | Hardest of all lol only because of the brightness detector
	local brightness = 0
	brightness = ((new.R * 0.5)+ (new.G * 0.8) + (new.B * 0.6))
	if brightness >= 1.4 then
		buttonbright = true
	else
		buttonbright = false
	end
	buttoncolour = new
	if not mousein then
		ts:Create(script.Parent,TweenInfo.new(0.25,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
			TextColor3 = buttoncolour
		}):Play()
	else
		local goal = buttoncolour
		if buttonbright then
			goal = Color3.new(buttoncolour.R-0.3,buttoncolour.G-0.3,buttoncolour.B-0.3)
		else
			goal = Color3.new(buttoncolour.R+0.3,buttoncolour.G+0.3,buttoncolour.B+0.3)
		end
		ts:Create(script.Parent,TweenInfo.new(0.25,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
			TextColor3 = goal
		}):Play()
	end
end)

settingsfile.SpinnerTint.Changed:Connect(function(new) -- Spinner Tint
	script.Parent.Parent.spin.ImageColor3 = new
end)

settingsfile.TextColour.Changed:Connect(function(new) -- Clock Text Colour
	ts:Create(script.Parent.Parent.info_time.date,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
		TextColor3 = new
	}):Play()
	ts:Create(script.Parent.Parent.info_time.time,TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
		TextColor3 = new
	}):Play()
	script.Parent.Parent.Parent.CmdBar.TextColor3 = new
end)

while wait() do
	if settingsfile.DND.Value == true then
		if #savednotifications >= 1 then
			script.Parent.Parent.NotificationsCount.Visible = true
			if #savednotifications > 9 then
				script.Parent.Parent.NotificationsCount.Text = "9+"
			else
				script.Parent.Parent.NotificationsCount.Text = tostring(#savednotifications)
			end
		end
	else
		if #savednotifications >= 1 then
			for k,v in pairs(savednotifications) do
				notifier.New(v[1],v[2])
				savednotifications[k] = nil
			end
		end
		script.Parent.Parent.NotificationsCount.Visible = false
	end
end