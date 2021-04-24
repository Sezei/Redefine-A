local mod = {}

mod.ModuleType = "Function"

function mod:Unpack(env)
	env.StringManipulation = {}
	function env.StringManipulation.Replace(source,replacewhat,replacewith)
		if type(source) == "string" then
			return string.gsub(source,replacewhat,replacewith)
		else
			return source -- Just return the incoming.
		end
	end
	function env.StringManipulation.New() -- Create a new string entirely. Idk why you would want it.
		local newstring = {
			Text = "",
			TimesAdded = 0,
			Adds = {},
		}
		
		function newstring:AddText(text)
			newstring.TimesAdded = newstring.TimesAdded+1
			newstring.Adds[newstring.TimesAdded] = {newstring.Text,newstring.Text..text}
			newstring.Text = newstring.Text..text
		end
		
		function newstring:Undo()
			if newstring.TimesAdded ~= 0 then
				newstring.Text = newstring.Adds[newstring.TimesAdded][1]
				newstring.Adds[newstring.TimesAdded] = nil
				newstring.TimesAdded = newstring.TimesAdded-1
			else
				print("There's nothing to undo...")
			end
		end
		
		function newstring:Replace(text,replacement)
			newstring.TimesAdded = newstring.TimesAdded+1
			newstring.Adds[newstring.TimesAdded] = {newstring.Text,string.gsub(newstring.Text,text,replacement)}
			newstring.Text = string.gsub(newstring.Text,text,replacement)
		end
		
		function newstring:Delete()
			newstring = nil
		end
		
		return newstring
	end
	function env.StringManipulation.ToPlayer(incoming,player)
		if type(incoming) == "string" and player then
			return string.gsub(incoming,"[[PlayerName]]",player.Name)
		else
			return incoming -- Just return the incoming.
		end
	end
	function env.StringManipulation.BanMessage(incoming,player,reason)
		if type(incoming) == "string" and player and reason then
			local a = string.gsub(incoming,"[[PlayerName]]",player.Name)
			return string.gsub(a,"[[Reason]]",reason)
		else
			return incoming -- Just return the incoming.
		end
	end
end

return mod