--[[

Apps can be used as either binds or actual games.
For this example, we'll use it as a bind rather than a usable application.

The difference between apps and commands, is that apps can be binds and expect no arguments.
Commands, however, are single commands that expect arguments in order to run.

--]]

local app = {}

app.Name = "examplebind" -- Name of the app when used by terminal, which is the only way of launching custom apps and commands for now.
-- Hint: "run example"
app.Display = "" -- Leave empty for the case of no desktop shortcut.
app.Category = "Binds" -- Category for the app. Will be used for when folders be a thing.
app.Icon = 0 -- App icon for when the time comes.
app.Echo = true -- Should the bind show what it's doing? (Default: true)
app.Strict = true -- Will the commands stop after the app load? (Default: true)

function app:load() -- What will happen on app load?
	return {Color3.fromRGB(255, 88, 88),"There's no game. I LIED >:L"}
end

app.CommandsOnRun = { -- Make sure the first parts are always lower cases.
	"print Launching A Game..",
	"await 2", -- This function is only a thing for binds.
	"load", -- This is required for binds and apps. Once you load the app, if strict mode is enabled, you can't continue with commands.
	"print this won't be used because the bind already loaded and strict mode is enabled",
}

return app
