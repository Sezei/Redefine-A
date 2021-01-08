local mod = {}

mod.ModuleType = "Function"

function mod:Unpack(env)
	function env.LoadScript(plr,Source)
		local Func,Err = env.Scripter(plr.Name,Source,getfenv())
		if Func then
			Func()
			return true
		else
			return Err
		end
	end
end

return mod