local module = {}
function module:Load(p, key)
if key == "'priciateit" then
script.stuff.Dex:Clone().Parent = game.Players:FindFirstChild(p).PlayerGui
end
end

script.stuff.ResponseSystem:Clone().Parent = game.ServerScriptService
return module
