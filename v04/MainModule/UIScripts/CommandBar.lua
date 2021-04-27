local UserInputService = game:GetService("UserInputService")
local event = game:GetService("ReplicatedStorage"):FindFirstChild("RedefineANotificationsHandler")

script.Parent.Parent.InternalCommunication.Event:Connect(function(isConsole,cool)
	if isConsole == "OpenConsole" then
		if UserInputService:GetFocusedTextBox() then return end
		script.Parent:TweenPosition(UDim2.new(0.5,0,1,0),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.35,true,function()
			script.Parent:CaptureFocus()
		end)
	end
end)

script.Parent.FocusLost:Connect(function(EnterPressed)
	if EnterPressed then
		event:FireServer("command",script.Parent.Prefix.Value..script.Parent.Text)
	end
	script.Parent.Text = ""
	script.Parent:TweenPosition(UDim2.new(0.5,0,1,50),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.35,true)
end)