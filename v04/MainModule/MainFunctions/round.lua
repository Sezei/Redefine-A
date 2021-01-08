local mod = {}

mod.ModuleType = "Function"

function mod:Unpack(env)
	function env.round(num1, num2)
		local mult = 10^(num2 or 0)
		return math.floor(num1 * mult + 0.5) / mult
	end
end

return mod