button = script.Parent
timer = script.Parent.Parent.Header.Timer
ui = script.Parent.Parent
count = 15
mousein = false
pressed = false

function Close()
	ui:TweenPosition(UDim2.new(-0.5,0,0.5,0),Enum.EasingDirection.Out,Enum.EasingStyle.Quint,0.5,true,function()
		ui:Destroy()
		timer.Text = "Closing.."
	end)
end

button.MouseEnter:Connect(function()
	if pressed == false then
		timer.Text = "== Click to Close =="
		mousein = true
	end
end)

button.MouseLeave:Connect(function()
	if pressed == false then
		timer.Text = count.." - Click to close now."
		mousein = false
	end
end)

button.MouseButton1Click:Connect(function()
	Close()
	pressed = true
end)

while wait(1) do
	count = count - 1
	if count == -1 then
		Close()
	end
	if mousein == false and pressed == false then
		timer.Text = count.." - Click to close now."
	end
end