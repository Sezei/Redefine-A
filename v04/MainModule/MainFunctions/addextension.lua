local mod = {}

mod.ModuleType = "Function"

function mod:Unpack(env)
	function env.AddExtension(name)
		if env.NewFunctions[name] then
			warn("Redefine:A | Conflicting extension found. ("..name..")")
		else		
			env.NewFunctions[name] = true
		end
	end
end

return mod