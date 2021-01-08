local lang = {}

-- Settings
lang.ModuleType = "Language"
lang.Language = "English"

-- Translations
lang.CommandExec = {
	NoPerm = "You do not have permission to execute this command.",
	NoFound = "Failed to find anyone of the mentioned players.",
	VIPNoOther = "You do not have permission to execute this command on others.",
}

lang.ServerLock = {
	NoJoin = "The server is currently locked. Please try again later or join a new server.",
	AdminNotice = "has attempted to join but the server is locked.",
	AdminJoin = "The server is currently locked, but your admin level has bypassed the lock.",
}

lang.Welcome = {
	Root = "Welcome! This game is using Redefine:A. Your role is Root.",
	Super = "Welcome! This game is using Redefine:A. Your role is Super Admin.",
	Admin = "Welcome! This game is using Redefine:A. Your role is Administrator.",
	Moderator = "Welcome! This game is using Redefine:A. Your role is Moderator.",
	VIP = "Welcome! You have VIP permissions in this game.", -- :P
	Sandbox = "Welcome! Sandbox mode is enabled, so you got Root Admin!",
}

lang.Levels = {
	Root = "Root",
	Super = "Super Admin",
	Admin = "Administrator",
	Moderator = "Moderator",
	VIP = "VIP",
}

lang.Update = {
	Critical = "A Critical update is awaiting! Please update the Redefine:A loader script!",
	NoHTTP = "HTTP Service is disabled, therefore we can't check if the version is up-to-date. The admin will still function properly and as expected, however.",
	Normal = "Notice: Redefine:A is outdated! Since AutoUpdate is enabled, all that is needed to do is simply shutdown the server."
}

return lang
