local mod = {}

mod.ModuleType = "Function"

function mod:Unpack(env)
	function env.ExtensionExists(name)
		if env.NewFunctions[name] then
			return true
		else
			return false
		end
	end
end

return mod