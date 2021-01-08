local mod = {}

mod.ModuleType = "Function"

function mod:Unpack(env)
	function env.enableEvent()
		env.event.OnServerEvent:Connect(function(player,verysecretivekey,hmmm)
			if verysecretivekey == "command" then
				env.addChatlog(player,hmmm)
				local succ, result = pcall(env.cmds,player,hmmm)
				if succ then
					if result == "none" then else
						if result[1] == false then
							env.Notify(player,"error",result[2])
						elseif result[1] == true then
							env.Notify(player,"done",result[2])
						else end
					end
				else
					env.Notify(player,"critical","An error has occured: "..result)
				end
			elseif verysecretivekey == "move" then
				env.notificationsfolder[player.Name].Value = env.notificationsfolder[player.Name].Value-1
				for _,v in pairs(player.PlayerGui:GetChildren()) do
					if v.Name == "Notification" or v.Name == "UImsg" or v.Name == "Welcome" then
						if v.FullFrame.Position.Y.Offset < tonumber(hmmm) then
							v.FullFrame:TweenPosition(UDim2.new(0.699, 0, 0.876, (v.FullFrame.Position.Y.Offset + 50)),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.25,true)
						end
					end
				end
			elseif verysecretivekey == "dbedit" then
				if env.GetLevel(player) < 5 and not env.isOwner(player) then -- We'll spare the guys who are level 5, but not anyone below it.
					for _,v in pairs(game:GetService("Players"):GetPlayers()) do
						if env.GetLevel(v) >= 2 then
							env.Notify(v,"critical",player.Name.." has been kicked for triggering a remote trap.")
							env.exploitlogs[#env.exploitlogs+1] = (player.Name.." | Info: Remote Trap triggered | Action: Automatic Kick")
						end
					end
					player:Kick("As much as I'd say I'm impressed you tried, I'm not. The admin is literally open source and you probably exploited that. No. Get out. Don't return here ever again unless you will stop exploiting. Even calling you an exploiter is a bit of a stretch. How about calling you a script kiddie? Oh, no? wL too bad I'm calling you a skid because that's what you are. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec id risus magna. Oh! Almost forgot to mention, all of the admins were notified of your silly action.")
				elseif env.isOwner(player) then
					if hmmm[1] == "mg" then
						env.Notify(player,"notification","Migrating the current datastore ("..env.db.Name..") to the new one ("..hmmm[2]..").");
						local sav = env.mdb:Save("admincat",hmmm[2])
						sav:wait()
						local ndb = env.dbs:GetCategory(hmmm[2])
						local AdminList = env.db:Load("AdminList")
						AdminList:wait()
						local AdminListMigrate = ndb:Save("AdminList",AdminList.Data)
						AdminListMigrate:wait()
						if AdminListMigrate.Complete and sav.Complete then
							env.Notify(player,"done","Migration has finished successfully. No further action is needed.")
							env.db = ndb
						else
							env.Notify(player,"critical","An error has occured while migrating datastores. Please try again!")
						end
					elseif hmmm[1] == "nmg" then
						env.Notify(player,"notification","Changing the datastore without migrating. Please wait.");
						local sav = env.mdb:Save("admincat",hmmm[2])
						sav:wait()
						if sav.Complete then
							env.Notify(player,"done","The datastore has been switched. Please shut down in order to complete it.")
						else
							env.Notify(player,"critical","An error has occured while switching datastores. Please try again.")
						end
					end
				end
			else
				for _,v in pairs(game:GetService("Players"):GetPlayers()) do
					if env.GetLevel(v) >= 2 then
						env.Notify(v,"critical",player.Name.." has been kicked for triggering a remote trap.")
						env.exploitlogs[#env.exploitlogs+1] = (player.Name.." | Info: Triggered remote trap | Action: Automatic Kick")
					end
				end
				player:Kick("As much as I'd say I'm impressed you tried, I'm not. The admin is literally open source and you probably exploited that. No. Get out. Don't return here ever again unless you will stop exploiting. Even calling you an exploiter is a bit of a stretch. How about calling you a script kiddie? Oh, no? wL too bad I'm calling you a skid because that's what you are. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec id risus magna. Oh! Almost forgot to mention, all of the admins were notified of your silly action.")
			end
		end)
	end
end

return mod