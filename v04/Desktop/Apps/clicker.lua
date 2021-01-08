--[[

Welcome to... clicker?

The difference between apps and commands, is that apps can be binds and expect no arguments.
Commands, however, are single commands that expect arguments in order to run... mostly.

--]]

local app = {}

app.Name = "clicker"
app.Display = "Clicker" -- Leave empty for the case of no desktop shortcut.
app.Category = "Desktop Games" -- Category for the app.
app.Icon = script.Icon.Texture -- App icon for when the time comes. Can be either external or gotten from inside the module.
app.Echo = false -- Should the bind show what it's doing? (Default: true)
app.Strict = true -- Will the commands stop after the app load? (Default: true)
app.RequireTerminal = false -- If true, will launch a terminal to deal with the app. (Otherwise it ignores all commands and just loads.)

function app:load() -- What will happen on app load?
	local gamething = script.Clicker:Clone() 
	gamething.Parent = script.Parent.Parent.Enviroment.Desktop
	gamething.Visible = true
	return {Color3.fromRGB(255,255,255),"Clicker has been launched."}
end

app.CommandsOnRun = { -- Make sure the first parts are always lower cases.
	"print Launching A Game..",
	"await 1",
	"load",
}

return app
