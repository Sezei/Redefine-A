local Players = game:GetService("Players")
local player = Players.LocalPlayer
local MarketplaceService = game:GetService("MarketplaceService")
local PlayerOwnsAsset = MarketplaceService.PlayerOwnsAsset

local ASSET_ID = 4633826344
local success, doesPlayerOwnAsset = pcall(PlayerOwnsAsset, MarketplaceService, player, ASSET_ID)
if doesPlayerOwnAsset then
	script.Parent.Text = "You have R:A!"
	script.Parent.TextColor3 = Color3.fromRGB(119, 255, 153)
	script.Parent.AutoButtonColor = false -- Make the button look in-active.
	wait()
	script.Disabled = true
end

script.Parent.MouseButton1Click:Connect(function()
	local player = Players.LocalPlayer
	if not script.Parent.Text == "You have R:A!" then
		MarketplaceService:PromptProductPurchase(player, 4633826344)
	end
end)