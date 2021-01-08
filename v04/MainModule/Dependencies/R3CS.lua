local module = {}

function module:GetColor(str)
	if not str then
		return nil
	end
	
	if str then
		name = string.lower(str)
	end
	
	if name == "white" then
		return (Color3.fromRGB(255,255,255))
	elseif name == "black" then
		return (Color3.fromRGB(0,0,0))
	elseif name == "green" then
		return (Color3.fromRGB(0,170,0))
	elseif name == "blue" then
		return (Color3.fromRGB(0,0,170))
	elseif name == "red" then
		return (Color3.fromRGB(170,0,0))
	elseif name == "yellow" then
		return (Color3.fromRGB(170,170,0))
	elseif name == "fullyellow" then
		return (Color3.fromRGB(255,255,0))
	elseif name == "fullgreen" then
		return (Color3.fromRGB(0,255,0))
	elseif name == "fullblue" then
		return (Color3.fromRGB(0,0,255))
	elseif name == "fullred" then
		return (Color3.fromRGB(255,0,0))
	elseif name == "turquoise" or name == "turqoise" or name == "turquise" then
		return (Color3.fromRGB(0,206,209))
	elseif name == "liteblue" then -- Also the signature blue of Studio Engi.
		return (Color3.fromRGB(0,128,255))
	elseif name == "litegreen" then
		return (Color3.fromRGB(102,255,102))
	elseif name == "liteyellow" then
		return (Color3.fromRGB(255,255,102))
	elseif name == "litered" then
		return (Color3.fromRGB(255,51,51))
	elseif name == "pastelblue" then
		return (Color3.fromRGB(201,215,234))
	elseif name == "pastelgreen" then
		return (Color3.fromRGB(173,247,182))
	elseif name == "pastelyellow" then
		return (Color3.fromRGB(255,253,209))
	elseif name == "pastelred" then
		return (Color3.fromRGB(255,105,97))
	elseif name == "orange" then
		return (Color3.fromRGB(255,128,0))
	elseif name == "purple" then
		return (Color3.fromRGB(204,0,204))
	elseif name == "pink" then
		return (Color3.fromRGB(255,153,153))
	elseif name == "fucsia" then
		return (Color3.fromRGB(255, 0, 255))
	elseif name == "grey" then
		return (Color3.fromRGB(128,128,128))
	elseif name == "royalturq" then
		return (Color3.fromRGB(102,255,178))
	elseif name == "brown" then
		return (Color3.fromRGB(102,51,0))
	elseif name == "navy" then
		return (Color3.fromRGB(44,58,82))
	elseif name == "mint" then
		return (Color3.fromRGB(35,249,163))
	elseif name == "khaki" then
		return (Color3.fromRGB(171,181,128))
	elseif name == "dark" then
		return (Color3.fromRGB(33,33,33))
	elseif name == "light" then
		return (Color3.fromRGB(228,228,228))
	elseif name == "deathblack" then
		return (Color3.fromRGB(26,26,26))
		
	-- Keywords
	elseif name == "randomlight" then
		return (Color3.fromRGB(math.random(127,255),math.random(127,255),math.random(127,255)))
	elseif name == "randomdark" then
		return (Color3.fromRGB(math.random(0,127),math.random(0,80),math.random(0,127)))
	elseif name == "disco" then
		return (Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255)))
	
	else
		return nil
	end
end

return module
