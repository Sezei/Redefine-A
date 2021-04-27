script.Parent:GetPropertyChangedSignal("Text"):Connect(function()
	local size = math.max(300,(script.Parent.TextBounds.X + 15))
	script.Parent.Size = UDim2.new(0,size,0,40)
end)