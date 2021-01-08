OnFire = function(plr,arg,env)
	if not arg[2] then
		return {false,"A script must be provided."}
	end

	if arg[2] then
		buildreason = ""
		for _,v in pairs(arg) do
			if v ~= arg[1] then
				buildreason = buildreason.." "..v
			end
		end
	end

	local res = env.LoadScript(plr,buildreason)

	if tostring(res) == "true" then
		return{true,"Evaluation: Successful."}
	else
		return{false,"Evaluation: Compilation error: "..tostring(res)}
	end
end

OnLoad = function(env)
end

return {
	ModuleType = "Command",
	Usage = "<script>", 
	ModName = "evaluate",
	Alias = {"eval","execute","load","script","ls"},
	Level = 5,
	Sandbox = false,
	Libraries = {},
	Dependencies = {}, -- To be used soon.
	ModFunction = OnFire,
	ModLoad = OnLoad,
}
