-- Terminal Loader
sfunc = game:GetService("ReplicatedStorage"):FindFirstChild("RA_DesktopEvent")

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

function handleCommand(cmd)
	pushPrint(Color3.fromRGB(255,255,127),"> "..cmd)
	local args = splitstring(cmd," ")
	
	if args[1] == "help" then
		pushPrint(Color3.fromRGB(255,255,255),"The current list of commands: help, set, syserror, print")
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
		end
	else
		pushPrint(Color3.fromRGB(255,88,88),"Unknown command! Try typing 'help' for the list.")
	end
end

script.Parent.FocusLost:Connect(function(enterpressed)
	if enterpressed then
		handleCommand(script.Parent.Text)
		script.Parent.Text = ""
	end
end)

-- Terminal User
script.Parent.Text = '<font color= "rgb(85,170,127)">$ </font><font color= "rgb(85,85,255)">'..game.Players.LocalPlayer.Name..'</font><font color= "rgb(85,170,127)">\\</font><font color= "rgb(85,85,255)">Desktop</font>'
