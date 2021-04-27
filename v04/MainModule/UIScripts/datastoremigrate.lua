local event = game:GetService("ReplicatedStorage"):FindFirstChild("RedefineANotificationsHandler")
local active = false

script.Parent.Migrate.MouseButton1Click:Connect(function()
	if script.Parent.Input.Text ~= "" then
		event:FireServer("dbedit",{"mg",script.Parent.Input.Text})
	else
		script.Parent.Input.PlaceholderText = "This section is required."
		wait(2)
		script.Parent.Input.PlaceholderText = "R:A Datastore Key"
	end
end)

script.Parent.NoMigrate.MouseButton1Click:Connect(function()
	if script.Parent.Input.Text ~= "" then
		event:FireServer("dbedit",{"nmg",script.Parent.Input.Text})
	else
		script.Parent.Input.PlaceholderText = "This section is required."
		wait(2)
		script.Parent.Input.PlaceholderText = "R:A Datastore Key"
	end
end)

--event:FireServer("dbedit",{})