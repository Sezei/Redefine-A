-- Warning: This is a function that shouldn't be used in commands other than Main ones or made by EngiAdurite. If you came across this function because of a command that is not in MainCommands, please report that immediately to EngiAdurite. Let us fight malicious modules together.

local mod = {}

mod.ModuleType = "Function"

function mod:Unpack(env)
	function env.SaveAdmins(list)
		local update = env.db:Save("AdminList",list)
		update:wait()
		return update.Attempts -- Return the # of attempts it took to save admins.
	end
end

return mod