--[[VolcanoINC's DataStore Module (for easy usage) || Edited to fit Redefine:A by EngiAdurite.
	API spec:
	
	DataCategory = Module:GetCategory(name)
		Returns a DataCategory to save data to and retrieve data from. The name can be any string (such as 
		"Leaderboard" or "Player Data")
	
	Task = DataCategory:Save(key,data)
		Asks the module to save the given data under the given key. It will return a 'Task' which contains 
		information and methods for the monitoring and control of the data saving process. Sending a new
		request while the old one is in progress will simply result in the old request being overridden.
	
	Task = DataCategory:Update(key,updateFunc)
		Asks the module to update the data under the given key according to the given function. This comes with
		a failsafe to prevent the overriding of previously saved data.
	
	Task = DataCategory:Load(key)
		Asks the module to retrieve the data stored under the given key. It will return a 'Task' which contains
		information and methods for the monitoring and control of the data retrieval process.
	
	Task:wait()
		Waits until the task completes or is cancelled.
	
	Task:Cancel()
		Cancels the task.
	
	Task.Complete
		Says whether or not the task has been completed.
	
	Task.Attempts
		The amount of previous, failed attempts to complete the task.
	
	Task.NextTry
		Time in seconds before the next attempt
	
	Task.Type
		"Load" if the task is to retrieve data, "Save" if the task is to save data.
	
	Task.Data
		The data to be saved, or the data that was retrieved depending on the type of task.
	
	Task.Key
		The key the task is supposed to read/write.
--]]

--Get important instances
local dataStoreSvc 	= game:GetService("DataStoreService")

--Information storage
local categories 	= {}
local tasks 		= {}
local taskQueue 	= {}

--Module
local Module = {}
function Module:GetCategory(name)
	--Check if we've already done all the hard work, and if yes, just give them what we already have
	if (categories[name]) then return categories[name] end
	
	--Oh no, it looks like we haven't dealt with this yet
	local DataCategory = {}
	DataCategory.Store = dataStoreSvc:GetDataStore(name)
	DataCategory.Name = name
	function DataCategory:Save(key,data)
		--Overwrite old data so we don't waste precious requests
		if (tasks[key]) then tasks[key].Data = data return tasks[key] end
		
		local Task = {}
		Task.Complete = false
		Task.InProgress = false
		Task.Attempts = 0
		Task.NextTry = 0
		Task.Type = "Save"
		Task.Data = data
		Task.Key = key
		Task.Category = self
		
		function Task:wait() repeat wait() until self.Complete end
		function Task:Cancel() self.Complete = true end
		
		tasks[key] = Task --Store it so we don't do overlap work
		table.insert(taskQueue,Task) --Store it under a numerical value as well
		return Task
	end
		
	function DataCategory:Update(key,updateFunc)
		--Overwrite old data so we don't waste precious requests
		if (tasks[key]) then 
			if (tasks[key].Data == nil) then
				tasks[key].Data = {}
			end
			table.insert(tasks[key].Data,updateFunc)
			return tasks[key] 
		end
		
		local Task = {}
		Task.Complete = false
		Task.InProgress = false
		Task.Attempts = 0
		Task.NextTry = 0
		Task.Type = "Update"
		Task.Data = {updateFunc}
		Task.Key = key
		Task.Category = self
		
		function Task:wait() repeat wait() until self.Complete end
		function Task:Cancel() self.Complete = true end
		
		tasks[key] = Task --Store it so we don't do overlap work
		table.insert(taskQueue,Task) --Store it under a numerical value as well
		return Task
	end
	
	function DataCategory:Load(key)
		if (tasks[key]) then return tasks[key] end
		
		local Task = {}
		Task.Complete = false
		Task.InProgress = false
		Task.Attempts = 0
		Task.NextTry = 0
		Task.Type = "Load"
		Task.Data = nil
		Task.Key = key
		Task.Category = self
		
		function Task:wait() repeat wait() until self.Complete end
		function Task:Cancel() self.Complete = true end
		
		tasks[key] = Task --Store it so we don't do overlap work
		table.insert(taskQueue,Task) --Store it under a numerical value as well
		return Task
	end
	
	categories[name] = DataCategory --Make sure we don't have to do all that again
	return DataCategory --Tell them that we're done and give them the result
end

--Creating new threads is usually bad practice, but in our case we want the module to continuously read
--the information we give it and attempt to do what we want it to.
spawn(function()
	while true do
		wait(0.1)
		if (#taskQueue > 0) then
			local Task = taskQueue[1]
			
			if (not Task.Complete and not Task.InProgress) then
				--Wait until we're supposed to execute the task (and yes, this blocks all following tasks too)
				--No point in making more requests when one is failing.
				--[[print("Now handling task of type " 
					.. Task.Type .. " on key " 
					.. Task.Key .. "; Next try in " 
					.. Task.NextTry .. " seconds.")]]
				
				repeat
					wait(0.1)
					Task.NextTry = Task.NextTry - 0.1
				until Task.NextTry < 0
				
				--print("Wait time complete, attempting to execute task...")
				
				--Saving, updating and loading unfortunately yields, so we're creating another thread here.
				spawn(function()
					--Store the information elsewhere so we can tell if there have been more requests to save to
					--the same key
					local data = Task.Data
					Task.Data = nil
					
					--Make sure we don't do overlap work (debounce)
					Task.InProgress = true
					
					--Attempt to save/load the information and see if it was successful
					local ok,err = pcall(function()
						if (Task.Type == "Save") then
							Task.Category.Store:SetAsync(Task.Key,data)
						elseif (Task.Type == "Update") then
							--Rather than making tons of requests to the datastore, we cumulate the modifier functions here
							--and only request with the result
							local function func(variant)
								for _,f in pairs(data) do variant = f(variant) end
								return variant
							end
							Task.Category.Store:UpdateAsync(Task.Key,func)
						else
							Task.Data = Task.Category.Store:GetAsync(Task.Key)
						end
					end)
					
					if (ok) then
						--If it was a success, we can call it done and remove it from the queue.
						Task.Complete = true
						table.remove(taskQueue,1)
						tasks[Task.Key] = nil
						
						--Oh, but wait! If we tried pushing more data while the datastore was busy, we may want to
						--redo this so we have the latest info.
						if (Task.Type ~= "Load") then
							if (Task.Data ~= nil) then
								--Yeah, can't quite exit yet, sorry. But we'll give you an update so you don't feel left alone!
								Task.Complete = false
								--print("Saving to key '" .. Task.Key .. "' succeeded but will be repeated")
								
								--Not quite done yet, but add it to the end of the queue
								table.insert(taskQueue,Task)
								tasks[Task.Key] = Task
							else
								--We want this to be the original value 
								Task.Data = data
							end
						end
						--[[print("Task of type " 
							.. Task.Type .. " on key " 
							.. Task.Key .. " succeeded.")]]
					else
						--Check if we're running on Studio and attempting to update/save; if so, warn user that this may be the reason we failed
						if (Task.Type ~= "Load" and game:GetService("RunService"):IsStudio()) then
							warn("DataStore save/update failed in a Studio session. Is API access to DataStores enabled?")
						end
						
						--Looks like it failed. We'll take a note of that and retry again later.
						Task.Attempts = Task.Attempts + 1
						Task.NextTry = math.min(math.pow(2,Task.Attempts-1),10)
						
						--Also, we'll tell you so you know what's happening.
						--print("Saving to key '" .. Task.Key .. "' failed with error: \"" .. err .. "\", retrying in " .. Task.NextTry .. " seconds")
						Task.Data = data
					end
					
					--Debounce again
					Task.InProgress = false
				end)
			else
				--If the task was cancelled, get rid of it.
				table.remove(taskQueue,1)
				tasks[Task.Key] = nil
			end
		end
	end
end)

return Module
