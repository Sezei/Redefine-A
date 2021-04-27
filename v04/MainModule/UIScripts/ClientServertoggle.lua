wait(1) -- Wait a second after activation just in-case.
local servacc = script.Parent.Parent.IsServerAccessible
local toggle = false -- true: server, false: client

if servacc.Value then
	script.Parent.MouseButton1Click:Connect(function()
		if toggle == false then
			toggle = true
			script.Parent.Text = "Server"
			script.Parent.BackgroundColor3 = Color3.fromRGB(0,170,0)
			script.Parent.Parent.Client.Visible = false
			script.Parent.Parent.Server.Visible = true
		elseif toggle == true then
			toggle = false
			script.Parent.Text = "Client"
			script.Parent.BackgroundColor3 = Color3.fromRGB(0,170,255)
			script.Parent.Parent.Client.Visible = true
			script.Parent.Parent.Server.Visible = false
		end
	end)
else
	script.Parent.Parent.Server:Destroy()
	script.Parent.Parent.Client.Visible = true
	script.Parent.Parent.Client.BorderColor3 = Color3.fromRGB(66,66,66)
	script.Parent:Destroy()
end