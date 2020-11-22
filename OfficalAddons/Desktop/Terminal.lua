local sfunc = game:GetService("ReplicatedStorage"):FindFirstChild("RA_DesktopEvent")
local event = game:GetService("ReplicatedStorage"):FindFirstChild("RedefineANotificationsHandler")
local newComs = {}

function color3FromHex(n) -- good stuff :)
	n = math.floor(n)
	if (n < 0 or n > 16777215) then return Color3.new(0,0,0) end
	local b = n % 256
	local g = ((n-b)/256)%256
	local r = (n-b-g*256)/65536
	return Color3.fromRGB(r,g,b)
end

function pushPrint(pcolor,pstring)
	for i = 1, 8, 1 do
		if script.Parent.Parent["Log"..i].Text == "" then
			script.Parent.Parent["Log"..i].Text = pstring
			script.Parent.Parent["Log"..i].TextColor3 = pcolor
			return true
		end
	end
	for i = 1, 7, 1 do
		script.Parent.Parent["Log"..i].Text = script.Parent.Parent["Log"..i+1].Text
		script.Parent.Parent["Log"..i].TextColor3 = script.Parent.Parent["Log"..i+1].TextColor3
	end
	script.Parent.Parent.Log8.Text = pstring
	script.Parent.Parent.Log8.TextColor3 = pcolor
	return true
end

function splitstring(s, sep)
	local fields = {}

	local sep = sep or " "
	local pattern = string.format("([^%s]+)", sep)
	string.gsub(s, pattern, function(c) fields[#fields + 1] = c end)

	return fields
end

function join(s, sep)
	return table.concat(s, sep)
end

function getApp(name)
	local folder = script.Parent.Parent.Parent.Parent.Parent.Parent.Apps
	for _,v in pairs(folder:GetChildren()) do
		local app = require(v)
		if app.Name == name then
			return app
		end
	end
end

function getCommand(name)
	local folder = script.Parent.Parent.Parent.Parent.Parent.Parent.TerminalCommands
	for _,v in pairs(folder:GetChildren()) do
		local com = require(v)
		if com.Name == name then
			return com
		end
	end
end

function search(args) -- to be used later. no use yet.
end

function loadApp(func)
	return func:load()
end

function getArgsCommand(func)
	return func.NeededArgs
end

function loadCommand(func,args)
	return func:load(args)
end

function handleCommand(cmd,show)
	if show == true then
		pushPrint(Color3.fromRGB(255,255,127),"> "..cmd)
	end
	local args = splitstring(cmd," ")
	
	if args[1] == "help" then
		pushPrint(Color3.fromRGB(255,255,255),"Commands List: help,syserror,print,run,com,playsound,exit,resetenv,trm and set. Custom commands are not included.")
	elseif args[1] == "syserror" then
		if not args[2] then
			pushPrint(Color3.fromRGB(255, 88, 88),"At least one word is required. Please?")
			return
		end
		local err = script.Parent.Parent.Parent.Parent.Error:Clone()
		err.Top.TextLabel.Text = "Error"
		err.Ubuntu_Notification:Play()
		local txt = {}
		for i,v in pairs(args) do
			if i ~= 1 then
				table.insert(txt,i-1,v)
			end
		end
		err.TextLabel.Text = join(txt," ")
		err.Parent = script.Parent.Parent.Parent.Parent
		err.Visible = true
		pushPrint(Color3.fromRGB(0,255,0),"An error has appeared.")
	elseif args[1] == "sysnotify" then
		if not args[2] then
			pushPrint(Color3.fromRGB(255, 88, 88),"At least one word is required. Please?")
			return
		end
		local err = script.Parent.Parent.Parent.Parent.Notification:Clone()
		err.Top.TextLabel.Text = "Notification"
		err.Notification:Play()
		local txt = {}
		for i,v in pairs(args) do
			if i ~= 1 then
				table.insert(txt,i-1,v)
			end
		end
		err.TextLabel.Text = join(txt," ")
		err.Parent = script.Parent.Parent.Parent.Parent
		err.Visible = true
		pushPrint(Color3.fromRGB(0,255,0),"A notification has appeared.")
	elseif args[1] == "print" then
		if not args[2] then
			pushPrint(Color3.fromRGB(255, 88, 88),"At least one word is required. Please?")
			return
		end
		local txt = {}
		for i,v in pairs(args) do
			if i ~= 1 then
				table.insert(txt,i-1,v)
			end
		end
		pushPrint(Color3.fromRGB(255,255,255),join(txt," "))
	elseif args[1] == "obj" or args[1] == "object" then -- turns rBash into an OOP :lenny:
		if not args[2] then
			pushPrint(Color3.fromRGB(255, 88, 88),"Parameter 1 is missing.")
			return
		end
		if args[2] == "new" or args[2] == "add" or args[2] == "create" then
			if not args[3] then
				pushPrint(Color3.fromRGB(255, 88, 88),"Type is missing.")
				return
			end
			if not args[4] then
				pushPrint(Color3.fromRGB(255, 88, 88),"Name is missing.")
				return
			end
			if not args[5] then
				pushPrint(Color3.fromRGB(255, 88, 88),"Parent is missing.")
				return
			end
			if args[3] == "window" then
				local w = script.Parent.Parent.Parent.Parent.Parent.Parent.bin.BaseUIs.Window:Clone()
				w.Name = args[4]
				w.Top.TextLabel.Text = args[4]
				local stuff = splitstring(args[5],"/")
				if stuff[1] == "desktop" or stuff[1] == "desk" then
					w.Parent = script.Parent.Parent.Parent.Parent
					w.Visible = true
				elseif stuff[1] == "environment" then
					pushPrint(Color3.fromRGB(255, 88, 88),"Element 'root/environment' is currently locked.")
					return
				else
					pushPrint(Color3.fromRGB(255, 88, 88),"Invalid element path "..args[5]..".")
					return
				end
			elseif args[3] == "button" or args[3] == "textbutton" then
				local w = script.Parent.Parent.Parent.Parent.Parent.Parent.bin.BaseUIs.TextButton:Clone()
				w.Name = args[4]
				w.Text = args[4]
				local stuff = splitstring(args[5],"/")
				if stuff[1] == "desktop" or stuff[1] == "desk" then
					if not stuff[2] then
						pushPrint(Color3.fromRGB(255, 88, 88),"Desktop does not allow element type "..args[3]..".")
						return
					end
					local p = script.Parent.Parent.Parent.Parent:FindFirstChild(stuff[2])
					if p then
						w.Parent = p.Content
						w.Visible = true
					else
						pushPrint(Color3.fromRGB(255, 88, 88),"Invalid element path "..args[5]..".")
						return
					end
				elseif stuff[1] == "environment" then
					pushPrint(Color3.fromRGB(255, 88, 88),"Element '$/environment' is currently locked.")
					return
				else
					pushPrint(Color3.fromRGB(255, 88, 88),"Invalid element path "..args[5]..".")
					return
				end
			elseif args[3] == "text" or args[3] == "textlabel" then
				local w = script.Parent.Parent.Parent.Parent.Parent.Parent.bin.BaseUIs.TextLabel:Clone()
				w.Name = args[4]
				w.Text = args[4]
				local stuff = splitstring(args[5],"/")
				if stuff[1] == "desktop" or stuff[1] == "desk" then
					if not stuff[2] then
						pushPrint(Color3.fromRGB(255, 88, 88),"Desktop does not allow element type "..args[3]..".")
						return
					end
					local p = script.Parent.Parent.Parent.Parent:FindFirstChild(stuff[2])
					if p then
						w.Parent = p.Content
						w.Visible = true
					else
						pushPrint(Color3.fromRGB(255, 88, 88),"Invalid element path "..args[5]..".")
						return
					end
				elseif stuff[1] == "environment" then
					pushPrint(Color3.fromRGB(255, 88, 88),"Element '$/environment' is currently locked.")
					return
				else
					pushPrint(Color3.fromRGB(255, 88, 88),"Invalid element path "..args[5]..".")
					return
				end
			elseif args[3] == "ibutton" or args[3] == "imagebutton" then
				local w = script.Parent.Parent.Parent.Parent.Parent.Parent.bin.BaseUIs.ImageButton:Clone()
				w.Name = args[4]
				local stuff = splitstring(args[5],"/")
				if stuff[1] == "desktop" or stuff[1] == "desk" then
					if not stuff[2] then
						pushPrint(Color3.fromRGB(255, 88, 88),"Desktop does not allow element type "..args[3]..".")
						return
					end
					local p = script.Parent.Parent.Parent.Parent:FindFirstChild(stuff[2])
					if p then
						w.Parent = p.Content
						w.Visible = true
					else
						pushPrint(Color3.fromRGB(255, 88, 88),"Invalid element path "..args[5]..".")
						return
					end
				elseif stuff[1] == "environment" then
					pushPrint(Color3.fromRGB(255, 88, 88),"Element '$/environment' is currently locked.")
					return
				else
					pushPrint(Color3.fromRGB(255, 88, 88),"Invalid element path "..args[5]..".")
					return
				end
			elseif args[3] == "image" or args[3] == "imagelabel" then
				local w = script.Parent.Parent.Parent.Parent.Parent.Parent.bin.BaseUIs.TextLabel:Clone()
				w.Name = args[4]
				local stuff = splitstring(args[5],"/")
				if stuff[1] == "desktop" or stuff[1] == "desk" then
					if not stuff[2] then
						pushPrint(Color3.fromRGB(255, 88, 88),"Desktop does not allow element type "..args[3]..".")
						return
					end
					local p = script.Parent.Parent.Parent.Parent:FindFirstChild(stuff[2])
					if p then
						w.Parent = p.Content
						w.Visible = true
					else
						pushPrint(Color3.fromRGB(255, 88, 88),"Invalid element path "..args[5]..".")
						return
					end
				elseif stuff[1] == "environment" then
					pushPrint(Color3.fromRGB(255, 88, 88),"Element '$/environment' is currently locked.")
					return
				else
					pushPrint(Color3.fromRGB(255, 88, 88),"Invalid element path "..args[5]..".")
					return
				end
			elseif args[3] == "box" or args[3] == "textbox" then
				local w = script.Parent.Parent.Parent.Parent.Parent.Parent.bin.BaseUIs.TextLabel:Clone()
				w.Name = args[4]
				w.PlaceholderText = args[4]
				local stuff = splitstring(args[5],"/")
				if stuff[1] == "desktop" or stuff[1] == "desk" then
					if not stuff[2] then
						pushPrint(Color3.fromRGB(255, 88, 88),"Desktop does not allow element type "..args[3]..".")
						return
					end
					local p = script.Parent.Parent.Parent.Parent:FindFirstChild(stuff[2])
					if p then
						w.Parent = p.Content
						w.Visible = true
					else
						pushPrint(Color3.fromRGB(255, 88, 88),"Invalid element path "..args[5]..".")
						return
					end
				elseif stuff[1] == "environment" then
					pushPrint(Color3.fromRGB(255, 88, 88),"Element '$/environment' is currently locked.")
					return
				else
					pushPrint(Color3.fromRGB(255, 88, 88),"Invalid element path "..args[5]..".")
					return
				end
			elseif args[3] == "function" then
				pushPrint(Color3.fromRGB(255, 170, 0),"Element 'function' is currently locked.")
				return
			else
				pushPrint(Color3.fromRGB(255, 88, 88),"Invalid element "..args[5]..".")
				return
			end
		elseif args[2] == "edit" then
			if not args[3] then
				pushPrint(Color3.fromRGB(255, 88, 88),"Element path is missing.")
				return
			end
			if not args[4] then
				pushPrint(Color3.fromRGB(255, 88, 88),"Property is missing.")
				return
			end
			if not args[5] then
				pushPrint(Color3.fromRGB(255, 88, 88),"Replacement is missing.")
				return
			end
			local stuff = splitstring(args[3],"/")
			if stuff[1] == "desk" or stuff[1] == "desktop" then
				if not stuff[2] then
					pushPrint(Color3.fromRGB(255, 88, 88),"You cannot edit the properties of Desktop.")
					return
				end
				local p = script.Parent.Parent.Parent.Parent:FindFirstChild(stuff[2])
				if p then
					if stuff[3] then
						local p1 = p.Content:FindFirstChild(stuff[3])
						if not p1 then
							pushPrint(Color3.fromRGB(255, 88, 88),"You cannot edit the properties of Desktop.")
							return
						end
						if args[4] == "name" then
							p1.Name = args[5]
						elseif args[4] == "text" then
							if p1.ClassName == "TextButton" or p1.ClassName == "TextBox" or p1.ClassName == "TextLabel" then
								local txt = {}
								for i,v in pairs(args) do
									if i <= 5 then
										table.insert(txt,i-5,v)
									end
								end
								p1.Text = join(txt," ")
							else
								pushPrint(Color3.fromRGB(255, 88, 88),"Class cannot be used for non-text based objects.")
								return
							end
						elseif args[4] == "math" or args[4] == "n+" or args[4] == "n++" then
							if p1.ClassName == "TextButton" or p1.ClassName == "TextBox" or p1.ClassName == "TextLabel" then
								local maththing = tonumber(p1.Text) + (tonumber(args[5]) or 1)
								p1.Text = tostring(maththing)
							else
								pushPrint(Color3.fromRGB(255, 88, 88),"Class cannot be used for non-text based objects.")
								return
							end
						elseif args[4] == "pos" or args[4] == "position" then
							if args[5] == "udim2" then
								if not args[8] then
									pushPrint(Color3.fromRGB(255, 88, 88),"Malformed position. Must be: ..UDim2 [Scale X] [Offset X] [Scale Y] [Offset Y]")
									return
								else
									p1.Position = UDim2.new(tonumber(args[6]),tonumber(args[7]),tonumber(args[8]),tonumber(args[8]))
								end
							else
								pushPrint(Color3.fromRGB(255, 88, 88),"Position must be a UDim2 value.")
								return
							end
						elseif args[4] == "size" then
							if args[5] == "udim2" then
								if not args[8] then
									pushPrint(Color3.fromRGB(255, 88, 88),"Malformed size. Must be: ..UDim2 [Scale X] [Offset X] [Scale Y] [Offset Y]")
									return
								else
									p1.Size = UDim2.new(tonumber(args[6]),tonumber(args[7]),tonumber(args[8]),tonumber(args[8]))
								end
							else
								pushPrint(Color3.fromRGB(255, 88, 88),"Size must be a UDim2 value.")
								return
							end
						elseif args[4] == "bcolor" or args[4] == "bcolour" or args[4] == "backcolor" or args[4] == "backcolour" then
							if args[5] == "color3" then
								if not args[9] then
									pushPrint(Color3.fromRGB(255, 88, 88),"Missing parameters. Must be color3 [Type] [R] [G] [B].")
									return
								end
								if args[6] == "fromrgb" then
									p1.BackgroundColor3 = Color3.fromRGB(tonumber(args[7]),tonumber(args[8]),tonumber(args[9]))
								elseif args[6] == "new" then
									p1.BackgroundColor3 = Color3.new(tonumber(args[7]),tonumber(args[8]),tonumber(args[9]))
								elseif args[6] == "fromhsv" then
									p1.BackgroundColor3 = Color3.fromHSV(tonumber(args[7]),tonumber(args[8]),tonumber(args[9]))
								end
							elseif args[5] == "hex" or args[5] == "##" then
								p1.BackgroundColor3 = color3FromHex(tonumber("0x"..args[6]))
							else
								pushPrint(Color3.fromRGB(255, 88, 88),"Color type must be either Hex (## [hex]) or Color3 (color3 [Type (fromrgb/fromhsv/new)] [R] [G] [B]).")
								return
							end
						elseif args[4] == "tcolor" or args[4] == "tcolour" or args[4] == "textcolor" or args[4] == "textcolour" then
							if args[5] == "color3" then
								if not args[9] then
									pushPrint(Color3.fromRGB(255, 88, 88),"Missing parameters. Must be color3 [Type] [R] [G] [B].")
									return
								end
								if p1.ClassName == "TextButton" or p1.ClassName == "TextBox" or p1.ClassName == "TextLabel" then
									if args[6] == "fromrgb" then
										p1.TextColor3 = Color3.fromRGB(tonumber(args[7]),tonumber(args[8]),tonumber(args[9]))
									elseif args[6] == "new" then
										p1.TextColor3 = Color3.new(tonumber(args[7]),tonumber(args[8]),tonumber(args[9]))
									elseif args[6] == "fromhsv" then
										p1.TextColor3 = Color3.fromHSV(tonumber(args[7]),tonumber(args[8]),tonumber(args[9]))
									end
								else
									pushPrint(Color3.fromRGB(255, 88, 88),"Class cannot be used for non-text based objects.")
									return
								end
							elseif args[5] == "hex" or args[5] == "##" then
								if p1.ClassName == "TextButton" or p1.ClassName == "TextBox" or p1.ClassName == "TextLabel" then
									p1.TextColor3 = color3FromHex(tonumber("0x"..args[6]))
								else
									pushPrint(Color3.fromRGB(255, 88, 88),"Class cannot be used for non-text based objects.")
									return
								end
							else
								pushPrint(Color3.fromRGB(255, 88, 88),"Color type must be either Hex (## [hex]) or Color3 (color3 [Type (fromrgb/fromhsv/new)] [R] [G] [B]).")
								return
							end
						elseif args[4] == "zindex" then
							p.ZIndex = tonumber(args[5])
						end
					else
						if args[4] == "name" then
							p.Name = args[5]
						elseif args[4] == "title" then
							local txt = {}
							for i,v in pairs(args) do
								if i <= 5 then
									table.insert(txt,i-5,v)
								end
							end
							p.Top.TextLabel.Text = join(txt," ")
						elseif args[4] == "position" then
							pushPrint(Color3.fromRGB(255,170,0),"...Why not.. just... drag the damn window? Is it that hard?")
							return
						elseif args[4] == "size" then
							if args[5] == "udim2" then
								if not args[9] then
									pushPrint(Color3.fromRGB(255, 88, 88),"Malformed size. Must be: ..UDim2 [Scale X] [Offset X] [Scale Y] [Offset Y]")
									return
								else
									p.Size = UDim2.new(tonumber(args[6]),tonumber(args[7]),tonumber(args[8]),tonumber(args[9]))
								end
							else
								pushPrint(Color3.fromRGB(255, 88, 88),"Size must be a UDim2 value.")
								return
							end
						elseif args[4] == "bcolor" or args[4] == "bcolour" or args[4] == "backcolor" or args[4] == "backcolour" or args[4] == "tcolor" or args[4] == "tcolour" or args[4] == "textcolor" or args[4] == "textcolour" then
							pushPrint(Color3.fromRGB(255, 88, 88),"You cannot use colours on window type elements.")
							return
						elseif args[4] == "zindex" then
							p.ZIndex = tonumber(args[5])
						end
					end
				else
					pushPrint(Color3.fromRGB(255, 88, 88),"Invalid element path "..args[3]..".")
					return
				end
			end
		elseif args[2] == "del" or args[2] == "delete" or args[2] == "remove" then
			if not args[3] then
				pushPrint(Color3.fromRGB(255, 88, 88),"Element path is missing.")
				return
			end
			
			local stuff = splitstring(args[3],"/")
			if stuff[1] == "desk" or stuff[1] == "desktop" then
				if not stuff[2] then
					pushPrint(Color3.fromRGB(255, 88, 88),"You cannot edit the properties of Desktop.")
					return
				end
				local p = script.Parent.Parent.Parent.Parent:FindFirstChild(stuff[2])
				if not p then
					pushPrint(Color3.fromRGB(255, 88, 88),"Invalid element path "..args[3]..".")
					return
				else
					if stuff[3] then
						local p1 = p:FindFirstChild(stuff[3])
						if p1 then
							p1:Destroy()
						else
							pushPrint(Color3.fromRGB(255, 88, 88),"Invalid element path "..args[3]..".")
							return
						end
					else
						p:Destroy()
					end
				end
			end
		elseif args[2] == "addfunc" or args[2] == "addfunction" or args[2] == "addbuttonfunction" then
			pushPrint(Color3.fromRGB(255, 88, 88),"Obj function 'addfunc' is currently unavailable for use.")
			
			local stuff = splitstring(args[4],"/")
			if args[3] == "clicked" or args[3] == "buttonclicked" then
				if stuff[1] == "desk" or stuff[1] == "desktop" then
					if not stuff[2] then
						pushPrint(Color3.fromRGB(255, 88, 88),"You cannot edit the properties of Desktop.")
						return
					end
					local p = script.Parent.Parent.Parent.Parent:FindFirstChild(stuff[2])
					if not p then
						pushPrint(Color3.fromRGB(255, 88, 88),"Invalid element path "..args[3]..".")
						return
					else
						if stuff[3] then
							local p1 = p:FindFirstChild(stuff[3])
							if p1 then
								if p1.ClassName == "TextButton" or p1.ClassName == "ImageButton" then
									local txt = {}
									for i,v in pairs(args) do
										if i <= 5 then
											table.insert(txt,i-5,v)
										end
									end
									p1.MouseButton1Click:Connect(function()
										handleCommand(join(txt," "),true) -- it is recommended to keep it as true.
									end)
								else
									pushPrint(Color3.fromRGB(255, 88, 88),"You cannot add function 'clicked' to a non-button class.")
									return
								end
							else
								pushPrint(Color3.fromRGB(255, 88, 88),"Invalid element path "..args[4]..".")
								return
							end
						else
							if p.ClassName == "TextButton" or p.ClassName == "ImageButton" then
								local txt = {}
								for i,v in pairs(args) do
									if i <= 5 then
										table.insert(txt,i-5,v)
									end
								end
								p.MouseButton1Click:Connect(function()
									handleCommand(join(txt," "),true) -- it is recommended to keep it as true.
								end)
							else
								pushPrint(Color3.fromRGB(255, 88, 88),"You cannot add function 'clicked' to a non-button class.")
								return
							end
						end
					end
				end
			end
		end
	elseif args[1] == "run" then -- run custom commands with no issues.
		if not args[2] then
			pushPrint(Color3.fromRGB(255, 88, 88),"You need to provide a bind or app to run.")
			return
		end
		if args[2] == "settings" or args[2] == "error" or args[2] == "terminal" or args[2] == "templatewindow" or args[2] == "notepad" or args[2] == "calculator" then
			pushPrint(Color3.fromRGB(255, 88, 88),"This application is restricted from running using terminal.")
			return
		elseif getApp(args[2]) then
			local func = getApp(args[2])
			if func.Echo == false and func.Strict == false then
				pushPrint(Color3.fromRGB(128,128,255),"This app has safety off. Be wary of this app.")
			elseif func.Echo == false then
				pushPrint(Color3.fromRGB(128,128,255),"This app has disabled echo. The commands it will run won't be shown.")
			elseif func.Strict == false then
				pushPrint(Color3.fromRGB(128,128,255),"This app has strict mode disabled. The app might still run after load.")
			end
			if not table.find(func.CommandsOnRun,"load") then
				pushPrint(Color3.fromRGB(255,88,88),"App Malfunction: No load command.")
				return
			end
			for _,v in pairs(func.CommandsOnRun) do
				local f = splitstring(v," ")
				if f[1] == "await" then
					if func.Echo == true then
						pushPrint(Color3.fromRGB(255,255,127),"> "..v)
					end
					if not f[2] then
						wait()
					elseif f[2] then
						wait(tonumber(f[2]))
					end
				elseif f[1] == "load" then
					if func.Echo == true then
						pushPrint(Color3.fromRGB(127,255,127),"> load")
					end
					local returning = loadApp(func)
					pushPrint(returning[1],returning[2])
					if func.Strict == true then
						return -- Will stop commands that come afterwards if strict mode is enabled.
					end
				else
					handleCommand(v,func.Echo)
				end
			end
		end
	elseif args[1] == "com" or args[1] == "command" or args[1] == "ra" or args[1] == "r:a" or args[1] == "redefine:a" then
		if not args[2] then
			pushPrint(Color3.fromRGB(255, 88, 88),"The command itself required.")
			return
		end
		local txt = {}
		for i,v in pairs(args) do
			if i ~= 1 then
				table.insert(txt,i-1,v)
			end
		end
		event:FireServer("command", script.Parent.Parent.Parent.Parent.Parent.Prefix.Value..join(txt," "))
		pushPrint(Color3.fromRGB(255,255,255),"Command has been sent.")
	elseif args[1] == "playsound" then
		if not args[2] then
			pushPrint(Color3.fromRGB(255, 88, 88),"Please provide a SoundId.")
			return
		end
		script.Sound:Stop()
		script.Sound.SoundId = "rbxassetid://"..args[2]
		script.Sound:Play()
		pushPrint(Color3.fromRGB(127,255,127),"Playing sound "..args[2])
	elseif args[1] == "exit" or args[1] == "logout" then
		pushPrint(Color3.fromRGB(127,255,127),"Logging out in 5 seconds.")
		pushPrint(Color3.fromRGB(255,255,127),"Closing the terminal will cancel this.")
		wait(5)
		pushPrint(Color3.fromRGB(127,255,127),"Logging out..")
		script.Parent.Parent.Parent.Parent.Parent.Parent:Destroy()
	elseif args[1] == "resetenv" then
		pushPrint(Color3.fromRGB(255,88,88),"Warning: This will reset the whole environment, and you'll need to redo the OOBE. Everything will be erased.")
		pushPrint(Color3.fromRGB(255,255,127),"The reset will proceed in 15 seconds unless you close the terminal.")
		wait(15)
		pushPrint(Color3.fromRGB(255,255,255),"Resetting..")
		local save = sfunc:InvokeServer("Save" , {"OOBESet",false})
		wait(3)
		pushPrint(Color3.fromRGB(255,255,255),"Logging out..")
		script.Parent.Parent.Parent.Parent.Parent.Parent:Destroy()
	elseif args[1] == "trm" then
		if not args[2] then
			pushPrint(Color3.fromRGB(255, 88, 88),"Variable 1 is required. No, this is not a toy.")
			return
		end
		if args[2] == "kill" or args[2] == "safemode" or args[2] == "sm" then
			pushPrint(Color3.fromRGB(255,255,255),"Awaiting confirmation..")
			wait(0.15)
			script.Parent.Parent.Parent.Parent.Visible = false
			script.Parent.Parent.Parent.Parent.Parent.death.Visible = true
			-- Unoptimized code time lol
			script.Parent.Parent.Parent.Parent.Parent.Save.ImageLabel.ImageColor3 = Color3.fromRGB(255,255,255)
			script.Parent.Parent.Parent.Parent.Parent.Save.Visible = true
			script.Parent.Parent.Parent.Parent.Parent.Save.TextLabel.Text = "Uploading in progress. Closing the desktop might corrupt the data."
			script.Parent.Parent.Parent.Parent.Parent.Save.ImageLabel.LocalScript.Disabled = false
			script.Parent.Parent.Parent.Parent.Parent.death.Frame.Label.Text = "0% Complete.\n\nIf this error persists, please refer to\nGithub/greasemonkey123/Redefine-A/wiki/Stop-Codes\n\nError Code:\nTERMINAL_SELFTERMINATE"
			wait(math.random() * 3)
			script.Parent.Parent.Parent.Parent.Parent.death.Frame.Label.Text = "15% Complete.\n\nIf this error persists, please refer to\nGithub/greasemonkey123/Redefine-A/wiki/Stop-Codes\n\nError Code:\nTERMINAL_SELFTERMINATE"
			wait(math.random() * 3)
			script.Parent.Parent.Parent.Parent.Parent.death.Frame.Label.Text = "30% Complete.\n\nIf this error persists, please refer to\nGithub/greasemonkey123/Redefine-A/wiki/Stop-Codes\n\nError Code:\nTERMINAL_SELFTERMINATE"
			wait(math.random() * 3)
			script.Parent.Parent.Parent.Parent.Parent.death.Frame.Label.Text = "45% Complete.\n\nIf this error persists, please refer to\nGithub/greasemonkey123/Redefine-A/wiki/Stop-Codes\n\nError Code:\nTERMINAL_SELFTERMINATE"
			wait(math.random() * 3)
			script.Parent.Parent.Parent.Parent.Parent.death.Frame.Label.Text = "60% Complete.\n\nIf this error persists, please refer to\nGithub/greasemonkey123/Redefine-A/wiki/Stop-Codes\n\nError Code:\nTERMINAL_SELFTERMINATE"
			wait(math.random() * 3)
			script.Parent.Parent.Parent.Parent.Parent.death.Frame.Label.Text = "75% Complete.\n\nIf this error persists, please refer to\nGithub/greasemonkey123/Redefine-A/wiki/Stop-Codes\n\nError Code:\nTERMINAL_SELFTERMINATE"
			wait(math.random() * 3)
			script.Parent.Parent.Parent.Parent.Parent.death.Frame.Label.Text = "90% Complete.\n\nIf this error persists, please refer to\nGithub/greasemonkey123/Redefine-A/wiki/Stop-Codes\n\nError Code:\nTERMINAL_SELFTERMINATE"
			wait(math.random() * 3)
			script.Parent.Parent.Parent.Parent.Parent.Save.Visible = false
			script.Parent.Parent.Parent.Parent.Parent.Save.ImageLabel.ImageColor3 = Color3.fromRGB(0,255,0)
			script.Parent.Parent.Parent.Parent.Parent.Save.TextLabel.Text = "Saving in progress. Closing the desktop might corrupt the data."
			script.Parent.Parent.Parent.Parent.Parent.Save.ImageLabel.LocalScript.Disabled = true
			script.Parent.Parent.Parent.Parent.Parent.death.Frame.Label.Text = "100% Complete.\n\nIf this error persists, please refer to\nGithub/greasemonkey123/Redefine-A/wiki/Stop-Codes\n\nError Code:\nTERMINAL_SELFTERMINATE"
			-- Unoptimized code time end :(
			script.Parent.Parent.Parent.Parent.Parent.ImageTransparency = 1
			script.Parent.Parent.Parent.Parent.Parent.BackgroundColor3 = Color3.fromRGB(48,48,48)
			script.Parent.Parent.Parent.Parent.Parent.ImageLabel.TextLabel.Text = "Desktop | Safe Mode"
			wait(math.random() * 5)
			script.Parent.Parent.Parent.Parent.Parent.death.Frame.Label.Text = "101% Complete.\n\nIf this error persists, please refer to\nGithub/greasemonkey123/Redefine-A/wiki/Stop-Codes\n\nError Code:\nTERMINAL_SELFTERMINATE"
			wait(0.1)
			script.Parent.Parent.Parent.Parent.Parent.death.Visible = false
			wait(math.random() * 2)
			script.Parent.Parent.Parent.Parent.Parent.SafeDesk.Visible = true
			local notificat = script.Parent.Parent.Parent.Parent.Parent.SafeDesk.Notification:Clone()
			notificat.Parent = script.Parent.Parent.Parent.Parent.Parent.SafeDesk
			notificat.Visible = true
			notificat.Notification:Play()
		elseif args[2] == "customdeath" then
			if not args[3] then
				pushPrint(Color3.fromRGB(255,88,88),"A stop code must be provided.")
				return
			end
			local safemodemessage = "Due to an error with the main enviroment, you were redirected to Safe mode. Beware, the functionality will be limited."
			if not args[4] then
				pushPrint(Color3.fromRGB(255, 255, 127),"Safe mode error wasn't specified. Using default.")
			else
				local txt = {}
				for i,v in pairs(args) do
					if i >= 4 then
						table.insert(txt,i-3,v)
					end
				end
				safemodemessage = join(txt," ")
			end
			wait(0.15)
			script.Parent.Parent.Parent.Parent.Visible = false
			script.Parent.Parent.Parent.Parent.Parent.death.Visible = true
			-- Unoptimized code time lol
			script.Parent.Parent.Parent.Parent.Parent.Save.ImageLabel.ImageColor3 = Color3.fromRGB(255,255,255)
			script.Parent.Parent.Parent.Parent.Parent.Save.Visible = true
			script.Parent.Parent.Parent.Parent.Parent.Save.TextLabel.Text = "Uploading in progress. Closing the desktop might corrupt the data."
			script.Parent.Parent.Parent.Parent.Parent.Save.ImageLabel.LocalScript.Disabled = false
			script.Parent.Parent.Parent.Parent.Parent.death.Frame.Label.Text = "0% Complete.\n\nIf this error persists, please refer to\nGithub/greasemonkey123/Redefine-A/wiki/Stop-Codes\n\nError Code:\n"..args[3]
			wait(math.random() * 3)
			script.Parent.Parent.Parent.Parent.Parent.death.Frame.Label.Text = "15% Complete.\n\nIf this error persists, please refer to\nGithub/greasemonkey123/Redefine-A/wiki/Stop-Codes\n\nError Code:\n"..args[3]
			wait(math.random() * 3)
			script.Parent.Parent.Parent.Parent.Parent.death.Frame.Label.Text = "30% Complete.\n\nIf this error persists, please refer to\nGithub/greasemonkey123/Redefine-A/wiki/Stop-Codes\n\nError Code:\n"..args[3]
			wait(math.random() * 3)
			script.Parent.Parent.Parent.Parent.Parent.death.Frame.Label.Text = "45% Complete.\n\nIf this error persists, please refer to\nGithub/greasemonkey123/Redefine-A/wiki/Stop-Codes\n\nError Code:\n"..args[3]
			wait(math.random() * 3)
			script.Parent.Parent.Parent.Parent.Parent.death.Frame.Label.Text = "60% Complete.\n\nIf this error persists, please refer to\nGithub/greasemonkey123/Redefine-A/wiki/Stop-Codes\n\nError Code:\n"..args[3]
			wait(math.random() * 3)
			script.Parent.Parent.Parent.Parent.Parent.death.Frame.Label.Text = "75% Complete.\n\nIf this error persists, please refer to\nGithub/greasemonkey123/Redefine-A/wiki/Stop-Codes\n\nError Code:\n"..args[3]
			wait(math.random() * 3)
			script.Parent.Parent.Parent.Parent.Parent.death.Frame.Label.Text = "90% Complete.\n\nIf this error persists, please refer to\nGithub/greasemonkey123/Redefine-A/wiki/Stop-Codes\n\nError Code:\n"..args[3]
			wait(math.random() * 3)
			script.Parent.Parent.Parent.Parent.Parent.Save.Visible = false
			script.Parent.Parent.Parent.Parent.Parent.Save.ImageLabel.ImageColor3 = Color3.fromRGB(0,255,0)
			script.Parent.Parent.Parent.Parent.Parent.Save.TextLabel.Text = "Saving in progress. Closing the desktop might corrupt the data."
			script.Parent.Parent.Parent.Parent.Parent.Save.ImageLabel.LocalScript.Disabled = true
			script.Parent.Parent.Parent.Parent.Parent.death.Frame.Label.Text = "100% Complete.\n\nIf this error persists, please refer to\nGithub/greasemonkey123/Redefine-A/wiki/Stop-Codes\n\nError Code:\n"..args[3]
			-- Unoptimized code time end :(
			script.Parent.Parent.Parent.Parent.Parent.ImageTransparency = 1
			script.Parent.Parent.Parent.Parent.Parent.BackgroundColor3 = Color3.fromRGB(48,48,48)
			script.Parent.Parent.Parent.Parent.Parent.ImageLabel.TextLabel.Text = "Desktop | Safe Mode"
			wait(math.random() * 5)
			script.Parent.Parent.Parent.Parent.Parent.death.Frame.Label.Text = "101% Complete.\n\nIf this error persists, please refer to\nGithub/greasemonkey123/Redefine-A/wiki/Stop-Codes\n\nError Code:\n"..args[3]
			wait(0.1)
			script.Parent.Parent.Parent.Parent.Parent.death.Visible = false
			wait(math.random() * 2)
			script.Parent.Parent.Parent.Parent.Parent.SafeDesk.Visible = true
			local notificat = script.Parent.Parent.Parent.Parent.Parent.SafeDesk.Notification:Clone()
			notificat.TextLabel.Text = safemodemessage
			notificat.Parent = script.Parent.Parent.Parent.Parent.Parent.SafeDesk
			notificat.Visible = true
			notificat.Notification:Play()
		else
			pushPrint(Color3.fromRGB(255, 88, 88),"Variable 1 is invalid.")
		end
	elseif args[1] == "set" then
		if not args[2] then
			pushPrint(Color3.fromRGB(255, 88, 88),"Variable 1 is required. [startsound/bgimage]")
			return
		elseif not args[3] then
			pushPrint(Color3.fromRGB(255, 88, 88),"Variable 2 is required. [assetid]")
			return
		elseif args[2] == "startsound" or args[2] == "ss" then
			pushPrint(Color3.fromRGB(255,255,255),"Setting the start up sound to "..args[3])
			script.Parent.Parent.Parent.Parent.Parent.Save.Visible = true
			script.Parent.Parent.Parent.Parent.Parent.Save.ImageLabel.LocalScript.Disabled = false
			local save = sfunc:InvokeServer("Save" , {"StartupSound","rbxassetid://"..args[3]})
			script.Parent.Parent.Parent.Parent.Parent.Save.ImageLabel.LocalScript.Disabled = true
			script.Parent.Parent.Parent.Parent.Parent.Save.Visible = false
			pushPrint(Color3.fromRGB(0,255,0),"Done.")
		elseif args[2] == "backimage" or args[2] == "bgimage" or args[2] == "image" then
			pushPrint(Color3.fromRGB(255,255,255),"Setting the background image to "..args[3])
			script.Parent.Parent.Parent.Parent.Parent.Image = "rbxassetid://"..args[3]
			script.Parent.Parent.Parent.Parent.Parent.Save.Visible = true
			script.Parent.Parent.Parent.Parent.Parent.Save.ImageLabel.LocalScript.Disabled = false
			local save = sfunc:InvokeServer("Save" , {"Image","rbxassetid://"..args[3]})
			script.Parent.Parent.Parent.Parent.Parent.Save.ImageLabel.LocalScript.Disabled = true
			script.Parent.Parent.Parent.Parent.Parent.Save.Visible = false
			pushPrint(Color3.fromRGB(0,255,0),"Done.")
		else
			pushPrint(Color3.fromRGB(255, 88, 88),"Variable 1 is invalid.")
		end
	elseif getCommand(args[1]) then
		local func = getCommand(args[1])
		
		local Sargs = {}
		for k,v in pairs(args) do
			if k ~= 1 then
				Sargs[k-1] = v
			end
		end
		
		local returns = loadCommand(func,Sargs)
		pushPrint(returns[1],returns[2])
	else
		pushPrint(Color3.fromRGB(255,88,88),"Unknown command! Try typing 'help' for the list.")
	end
end

script.Parent:GetPropertyChangedSignal("Text"):Connect(function()
	local args = splitstring(script.Parent.Text," ")
	if args[1] == "help" then
		script.Parent.TextColor3 = Color3.fromRGB(127,255,127)
	elseif args[1] == "print" or args[1] == "syserror" then
		if args[2] then
			script.Parent.TextColor3 = Color3.fromRGB(127,255,127)
		else
			script.Parent.TextColor3 = Color3.fromRGB(255,255,127)
		end
	elseif args[1] == "com" or args[1] == "command" or args[1] == "ra" or args[1] == "r:a" or args[1] == "redefine:a" then
		if args[2] then
			script.Parent.TextColor3 = Color3.fromRGB(127,255,127)
		else
			script.Parent.TextColor3 = Color3.fromRGB(255,255,127)
		end
	elseif args[1] == "trm" then
		if args[2] then
			if args[2] == "sm" or args[2] == "safemode" or args[2] == "kill" then
				script.Parent.TextColor3 = Color3.fromRGB(127,255,127)
			else
				script.Parent.TextColor3 = Color3.fromRGB(255,88,88)
			end
		else
			script.Parent.TextColor3 = Color3.fromRGB(255,255,127)
		end
	elseif args[1] == "set" then
		if args[2] then
			if args[2] == "startsound" or args[2] == "ss" or args[2] == "backimage" or args[2] == "bgimage" or args[2] == "image" then
				if args[3] then
					script.Parent.TextColor3 = Color3.fromRGB(127,255,127)
				else
					script.Parent.TextColor3 = Color3.fromRGB(255,255,127)
				end
			else
				script.Parent.TextColor3 = Color3.fromRGB(255,88,88)
			end
		else
			script.Parent.TextColor3 = Color3.fromRGB(255,255,127)
		end
	elseif args[1] == "run" then
		if not args[2] then
			script.Parent.TextColor3 = Color3.fromRGB(255,255,127)
		elseif getApp(args[2]) then
			script.Parent.TextColor3 = Color3.fromRGB(127,255,127)
		else
			script.Parent.TextColor3 = Color3.fromRGB(255,88,88)
		end
	elseif args[1] ~= nil and args[1] ~= "" and getCommand(args[1]) then
		local neededargs = getArgsCommand(getCommand(args[1]))
		if neededargs == 0 then
			script.Parent.TextColor3 = Color3.fromRGB(127,255,127)
		else
			if ((#args)-1) == neededargs then
				script.Parent.TextColor3 = Color3.fromRGB(127,255,127)
			end
			script.Parent.TextColor3 = Color3.fromRGB(255,255,127)
		end
	else
		script.Parent.TextColor3 = Color3.fromRGB(255,255,255)
	end
end)

script.Parent.FocusLost:Connect(function(enterpressed)
	if enterpressed then
		handleCommand(script.Parent.Text,true)
		script.Parent.Text = ""
	end
end)
