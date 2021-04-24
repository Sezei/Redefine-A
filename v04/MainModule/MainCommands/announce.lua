OnFire = function(plr,arg,env)
	local buildreason = "{ Message was not included }"
	
	if not arg[2] then
		return {false,"A variable is required."}
	end
	
	if arg[2] then
		buildreason = ""
		for _,v in pairs(arg) do
			if v ~= arg[1] then
				buildreason = buildreason.." "..v
			end
		end
	end

	env.MsgService:PublishAsync("RedefineA",{"Announce",buildreason})
	
	return{true,"Announcement successful. (Give it a second)"}
end

OnLoad = function(env)
end

return {
	ModuleType = "Command",
	Usage = "<message>", 
	ModName = "announce",
	Alias = {},
	Level = 5,
	Sandbox = true,
	Libraries = {},
	Dependencies = {}, -- To be used soon.
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
