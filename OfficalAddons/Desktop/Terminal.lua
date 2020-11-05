local sfunc = game:GetService("ReplicatedStorage"):FindFirstChild("RA_DesktopEvent")
local event = game:GetService("ReplicatedStorage"):FindFirstChild("RedefineANotificationsHandler")
local newComs = {} -- :)

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

function getCommand(name)
	local folder = script.Parent.Parent.Parent.Parent.Parent.Parent.TerminalCommands
	for _,v in pairs(folder:GetChildren()) do
		local com = require(v)
		if com.Name == name then
			return com
		end
	end
end

function getArgsCommand(func)
	return func.NeededArgs
end

function loadCommand(func,args)
	return func:load(args)
end

function handleCommand(cmd)
	pushPrint(Color3.fromRGB(255,255,127),"> "..cmd)
	local args = splitstring(cmd," ")
	
	if args[1] == "help" then
		pushPrint(Color3.fromRGB(255,255,255),"The current list of commands: help,set,syserror,print,com")
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
			script.Parent.Parent.Parent.Parent.Parent.SafeDesk.Notification.Visible = true
			script.Parent.Parent.Parent.Parent.Parent.SafeDesk.Notification.Notification:Play()
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
		handleCommand(script.Parent.Text)
		script.Parent.Text = ""
	end
end)
