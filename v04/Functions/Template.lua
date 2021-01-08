local mod = {}

mod.ModuleType = "Function"

function mod:Unpack(env)
	print("R:A | Template Function has been ran. Make sure to either disable it or edit it as you wish.")
	-- The code here will be ran when the admin loads.
	-- You can use it to set new functions, new variables, hell, maybe even create entirely new signals using SignalService.
	-- You can also edit the UI, but for that, please read the "How to edit the UI" transcript.
end

return mod
