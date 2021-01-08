local app = {}

app.Name = "appstore"
app.Display = "R:A Store" -- Leave empty for the case of no desktop shortcut.
app.Category = "Core" -- Category for the app.
app.Icon = script.Icon.Texture -- App icon for when the time comes. Can be either external or gotten from inside the module.
app.Echo = false -- Should the bind show what it's doing? (Default: true)
app.Strict = true -- Will the commands stop after the app load? (Default: true)
app.RequireTerminal = false -- If true, will launch a terminal to deal with the app. (Otherwise it ignores all commands and just loads.)

function app:load() -- What will happen on app load?
	local gamething = script.Frame:Clone() 
	gamething.Parent = script.Parent.Parent.Enviroment.Desktop
	gamething.Visible = true
	gamething.Sound:Play()
	return {Color3.fromRGB(255,255,255),"Please close the terminal. You've already done enough damage you fool."}
end

app.CommandsOnRun = { -- Make sure the first parts are always lower cases.
	"print This should not be ran using the terminal. Please close the terminal in order to avoid issues.",
	"await 0xFFFF",
	"load",
}

return app
