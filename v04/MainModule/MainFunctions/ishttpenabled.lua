local mod = {}
local cache = false

mod.ModuleType = "Function"

function mod:Unpack(env)
	function env.isHttpEnabled()
		if cache then -- If it was already tested and it was true, then no need to send a request again. However, if it failed, then probably it was down. Let's try again in that case.
			return cache
		end
		local s = pcall(function()
			game:GetService('HttpService'):GetAsync('http://www.google.com/')
		end)
		if s then cache=true end
		return s
	end
end

return mod