local mod = {}

mod.ModuleType = "Function"

function mod:Unpack(env)
	function env.CharReplace(pos,str,r)
		return table.concat{str:sub(1,pos-1), r, str:sub(pos+1)}
	end
end

return mod