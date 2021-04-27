func = game:GetService("ReplicatedStorage"):FindFirstChild("RARemoteFunction")
lplr = game.Players.LocalPlayer

local trash = {}
function getUsernameFromUserId(uid)
	if trash[uid] then return trash[uid] end
	local player = game:GetService("Players"):GetPlayerByUserId(uid)
	if player then
		trash[uid] = player.Name
		return player.Name
	end 
	local name
	pcall(function ()
		name = game:GetService("Players"):GetNameFromUserIdAsync(uid)
	end)
	trash[uid] = name
	return name
end

func.OnClientInvoke = function(isAdmins)
	if type(isAdmins) == "table" then
		if isAdmins[1] == "GetPing" then
			local diff = os.difftime(tick(),os.time())/3600
			local timething = tick() - isAdmins[2]
			func:InvokeServer({"ClientPing",timething,tick(),diff})
		elseif isAdmins[1] == "AdminsList" then
			local list = isAdmins[2]
			-- Cleanup
			for _,v in pairs(script.Parent.rootadmins.ScrollingFrame:GetChildren()) do
				if v.Name ~= "Cloning" then
					v:Destroy()
				end
			end
			for _,v in pairs(script.Parent.superadmins.ScrollingFrame:GetChildren()) do
				if v.Name ~= "Cloning" then
					v:Destroy()
				end
			end
			for _,v in pairs(script.Parent.normaladmins.ScrollingFrame:GetChildren()) do
				if v.Name ~= "Cloning" then
					v:Destroy()
				end
			end
			for _,v in pairs(script.Parent.moderators.ScrollingFrame:GetChildren()) do
				if v.Name ~= "Cloning" then
					v:Destroy()
				end
			end
			-- Building
			local currentlist = {}
			for k,v in pairs(list.RootAdmins) do -- Remove false notes (nil / unadmined)
				if v ~= nil then
					currentlist[#currentlist+1] = v
				end
			end
			for k,v in pairs(currentlist) do
				local clon = script.Parent.rootadmins.ScrollingFrame.Cloning:Clone()
				clon.Parent = script.Parent.rootadmins.ScrollingFrame
				clon.Text = tostring(getUsernameFromUserId(v))
				clon.id.Text = v
				clon.Position = UDim2.new(0,0,0,((k-1)*25))
				clon.Name = "notCloning"
				script.Parent.rootadmins.ScrollingFrame.CanvasSize = UDim2.new(0,0,0,((k-1)*25))
				if game.CreatorType == Enum.CreatorType.User then
					if v == game.CreatorId then
						clon.close.TextColor3 = Color3.fromRGB(130,130,130)
						clon.close.Text = "O"
					elseif v == lplr.UserId then
						clon.close.TextColor3 = Color3.fromRGB(130,130,130)
						clon.close.Text = "Y"
					else
						clon.close.TextColor3 = Color3.fromRGB(255,88,88)
						if func:InvokeServer("IsOwner") then
							clon.close.MouseButton1Click:Connect(function()
								func:InvokeServer({"AdminDel",5,v})
								local attemptBuild = func:InvokeServer("AdminsGet")
							end)
						end
					end
				elseif game.CreatorType == Enum.CreatorType.Group then
					local group = game:GetService("GroupService"):GetGroupInfoAsync(game.CreatorId)
					if v == group.Owner.Id then
						clon.close.TextColor3 = Color3.fromRGB(130,130,130)
						clon.close.Text = "O"
					elseif v == lplr.UserId then
						clon.close.TextColor3 = Color3.fromRGB(130,130,130)
						clon.close.Text = "Y"
					else
						clon.close.TextColor3 = Color3.fromRGB(255,88,88)
						if func:InvokeServer("IsOwner") then
							clon.close.MouseButton1Click:Connect(function()
								func:InvokeServer({"AdminDel",5,v})
								local attemptBuild = func:InvokeServer("AdminsGet")
							end)
						end
					end
				end
				clon.Visible = true
			end
			local currentlist = {}
			for _,v in pairs(list.SuperAdmins) do
				if v ~= nil then
					currentlist[#currentlist+1] = v
				end
			end
			for k,v in pairs(currentlist) do
				local clon = script.Parent.superadmins.ScrollingFrame.Cloning:Clone()
				clon.Parent = script.Parent.superadmins.ScrollingFrame
				clon.Text = tostring(getUsernameFromUserId(v))
				clon.id.Text = v
				clon.Name = "notCloning"
				clon.Position = UDim2.new(0,0,0,((k-1)*25))
				clon.close.TextColor3 = Color3.fromRGB(255,88,88)
				script.Parent.superadmins.ScrollingFrame.CanvasSize = UDim2.new(0,0,0,((k-1)*25))
				clon.close.MouseButton1Click:Connect(function()
					func:InvokeServer({"AdminDel",4,v})
					local attemptBuild = func:InvokeServer("AdminsGet")
				end)
				clon.Visible = true
			end
			local currentlist = {}
			for _,v in pairs(list.Admins) do
				if v ~= nil then
					currentlist[#currentlist+1] = v
				end
			end
			for k,v in pairs(currentlist) do
				local clon = script.Parent.normaladmins.ScrollingFrame.Cloning:Clone()
				clon.Parent = script.Parent.normaladmins.ScrollingFrame
				clon.Text = tostring(getUsernameFromUserId(v))
				clon.id.Text = v
				clon.Name = "notCloning"
				clon.Position = UDim2.new(0,0,0,((k-1)*25))
				clon.close.TextColor3 = Color3.fromRGB(255,88,88)
				script.Parent.normaladmins.ScrollingFrame.CanvasSize = UDim2.new(0,0,0,((k-1)*25))
				clon.close.MouseButton1Click:Connect(function()
					func:InvokeServer({"AdminDel",3,v})
					local attemptBuild = func:InvokeServer("AdminsGet")
				end)
				clon.Visible = true
			end
			local currentlist = {}
			for _,v in pairs(list.Moderators) do
				if v ~= nil then
					currentlist[#currentlist+1] = v
				end
			end
			for k,v in pairs(currentlist) do
				local clon = script.Parent.moderators.ScrollingFrame.Cloning:Clone()
				clon.Parent = script.Parent.moderators.ScrollingFrame
				clon.Text = tostring(getUsernameFromUserId(v))
				clon.id.Text = v
				clon.Name = "notCloning"
				clon.Position = UDim2.new(0,0,0,((k-1)*25))
				clon.close.TextColor3 = Color3.fromRGB(255,88,88)
				script.Parent.moderators.ScrollingFrame.CanvasSize = UDim2.new(0,0,0,((k-1)*25))
				clon.close.MouseButton1Click:Connect(function()
					func:InvokeServer({"AdminDel",2,v})
					local attemptBuild = func:InvokeServer("AdminsGet")
				end)
				clon.Visible = true
			end
		end
	elseif type(isAdmins) == "string" then
		if isAdmins == "HideMain" then
			script.Parent.Parent.Parent.Parent.Main.Visible = false
		elseif isAdmins == "ShowMain" then
			script.Parent.Parent.Parent.Parent.Main.Visible = true
		end
	end
end

local lol = func:InvokeServer("AdminsGet")