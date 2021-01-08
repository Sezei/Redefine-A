--[[																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																									--]]local module = {};--[[ stop looking at places you're not supposed to be in :(																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																																				Hello!
   _____ _             _ _         ______             _ 
  / ____| |           | (_)       |  ____|           (_)
 | (___ | |_ _   _  __| |_  ___   | |__   _ __   __ _ _ 
  \___ \| __| | | |/ _` | |/ _ \  |  __| | '_ \ / _` | |
  ____) | |_| |_| | (_| | | (_) | | |____| | | | (_| | |
 |_____/ \__|\__,_|\__,_|_|\___/  |______|_| |_|\__, |_|
	            	                    	     __/ |  
       	         								|___/   

---------------------------------------------------------------
-----------			Full Release of V.04			-----------
---------------------------------------------------------------

Copyright Protected © Studio Engi, EngiAdurite and the Lead Contributors, 2020.
Refer to the Internal Use Info & License for more info.

Thank you for using a fine product made by Studio Engi.
All of the products made by Studio Engi are and always will be Open Source.
To provide the best experience using your product, please follow the included instructions.

Warning: Redefine:A Plugins WILL NOT be applicable for Copyright unless they are open source and without any require()'s!

--------------------------------------------------------------

Setting up;

Please scroll down and make sure to fill those sections;
	RootAdmins
	SuperAdmins
	Admins
	Moderators
	VIP
	Bans
	BanLand
	Prefix
	Autosave

Note; Failure to do so BEFORE the first admin initialisation will end up needing a datastorage reset.

-------------------------------------------------------------

Resetting datastorage in-case the previous step hasn't been followed;

Use !resetadmins (SecretKey) twice.
You can get the SecretKey by opening the developer console (F9) and looking for the initialisation message.

and SHUT DOWN.

--------------------------------------------------------------

Usage guide, as almost no one knows how to use the admin for some reason without an explaination;
We will use the !kill command for the examples;

!kill #Number == Kills the player with the stated LPID. You can check the LPIDs in !lpid. Currently the only admin which has this system.
!kill name == Kills the player with the stated name. Doesn't have to be capitalised since V.01.
!kill @me == Kills you.
!kill @others == Kills everyone but you.
!kill @all == Kills everyone.
!kill @admins == Kills anyone who is a Moderator or higher.
!kill @root == Kills all Root(s) or higher.
!kill == Target yourself. Same as !kill @me.

Note; Please explain this system to all of your admins, as this is the only public admin which uses this.

If you want to copy the LPID system over to your own admin, please credit me for it.

--------------------------------------------------------------

External Materials used in this system;	

F3X Building Tools by GigsD4X (3.0.2)					| The Provided Building Tools.
[!] Make sure httpService is enabled for full use of the Building Tools!
	
Studio Engi AGB Global Banlist by EngiAdurite 			| Optional External Banlist.

Roundify by Stelrex										| Better UI Build.

Easy DataStorage Manager by VolcanoINC					| Easier Datastorage Access.

Zeus Admin by TheKitDev									| This is literally the very Deluxe version of Zeus Admin.
[!] No, the source isn't made by TheKitDev, but rather the whole idea is constructed by him.

--------------------------------------------------------------

Credits;

Lead(s):
	@EngiAdurite			| Head of Project, Head Scripter
	@Yes_Cone				| Head UI Designer
	@Cytronyx				| R:A Staff Member, Contributions for the code
	@ShhhhhhhhhhhBro		| R:A Staff Member
	@AshenRed				| R:A Staff Member

Contributor(s): 
	Most contributors will get access to the private loader upon release.
	-------------------------------------------------------
	@decipheringcode		| Pre-Alpha Tester
	@thebluepenguin1		| Pre-Alpha Tester
	@Pristh 				| Alpha Contribution
	@WolfieTheDino			| Alpha Contribution
	@Bad_BunnyBabyXD		| Post-Alpha Contribution
	@Meqpi					| Post-Alpha Contribution
	@TheKitDev				| Personal Thanks for the idea of Zeus Admin Deluxe
	Steamin' Beans 			| Alpha Testing Ground
	@alfivq					| Alpha Testing Ground
	@limesouls				| Alpha & Post-Alpha Tester
	@HonestlyEllie			| Alpha Tester
	@fmprej192				| Alpha Tester
	@Dev_Adurite			| Alpha Tester
	@DiscombobulatedJack	| Alpha Tester
	@Lsarowar20000			| Alpha Tester
	@JesseyJSyndicate 		| Alpha Tester
	
	You helped Alpha Test and I didn't add you to the list?
	DM me on Discord in order to be added: 		 Sezei#3061
	

External Materials Owner(s):
	F3X / @GigsD4X			| F3X Building Tools
	-
	Raspberry				| Dex
	-
	@VolcanoINC				| Easy DataStorage Manager
	-
	@einsteinK				| Loadstring Module
	@Stravant				|
	Yueliang				|
	-
	@Quenty					| SignalService
	-
	@Mayk728				| Pre-V.03.1 Audio
	@Jakkyou				|
	@DevHasan				|
	@Stelrex				|

--------------------------------------------------------------

This is the prototype loader of Redefine:A v04.
This prototype is not to be confused with R:A v03, as it'll be completely different.

!!! MAKE SURE THE LOADER IS IN SERVERSCRIPTSERVICE !!!
]]

starttick = tick();
AutoUpdate = {false,5900263444} -- Whether or not should it auto update. If yes, what ID? Default: {true,5900263444}
env = getfenv() -- :)

module = {} -- Make everything a table, so it'll be easier to load.

module.Prefix = "!" -- The prefix.
module.SilentEnabled = false -- Currently unused. Allows "/e (prefix)(command)" usage.

module.Admins = { --Keep in mind, this is working for only ONE TIME. If you will want to reset it, change the name of the db. (db = dbs:GetDataStore("NAMEHERE"))
	RootAdmins = {253925749,-1}, --Admins with level 5 permissions. No restrictions apply.
	SuperAdmins = {}, --Admins with level 4 permissions. They are able to use most of the commands with some restrictions.
	Admins = {}, --Admins with level 3 permissions. They are able to use most commands without alternatives (@all, @others, etc.) restricted on abusive commands such as kick or ban.
	Moderators = {}, --Admins with level 2 permissions. They are able to use most commands, but can't use alternatives such as @others or @all. They CAN use @me.
	VIP = {}, --Admins with level 1 permissions. (Usually given for a gamepass.)
	Bans = {}, --Not banned from the game, but rather banned from using the admin, giving them a level -1 admin.
	BanLand = {{-2,"Bad Kid."},{},{}}, --Banned from the game. Template: {{ID,"REASON"},{ID2,"REASON"}}
}

module.GroupAdmin = {
	Enabled = false, -- Enable group admin? (true = yes, false = no)
	GroupId = 0, -- What is the group id? (NOT THE URL, JUST THE LINK.)
	SuperAdminRank = 255, -- Give level 4 permissions to anyone ABOVE this rank.
	AdminRank = 255, -- Give level 3 permissions to anyone ABOVE this rank.
	ModeratorRank = 255, -- Give level 2 permissions to anyone ABOVE this rank.
	VIPRank = 255, -- Give level 1 permissions to anyone ABOVE this rank. (Non-abusive commands, just fire and sparkles.)
	BanLandRank = 255, -- The "Suspended" rank. Automatically bans them as long as they are suspended. Keep at '255' if you want to disable this. (Since priorities. xd)
}

module.VIPAdmin = {
	Enabled = false,
	GamepassId = 0, -- What is the gamepass id?
	GiveLevel = 1, -- What level should it give? (Default is 1)
}


module.Separator = "|" -- Allows you to separate a single message into multiple commands as long as they all start with the prefix.
module.AllowVIP = true -- Allow those who donated a not-so-small amout to Studio Engi enjoy a free VIP (Level 1) admin in your game.
module.Theme = "Source" -- You can pick your custom theme here!
module.BanMessage = "[R:A] You're banned from this game;"
module.DefaultBanReason = "No reason has been stated."
module.EnableGlobalBanList = false -- Enable AGB Banlist, which automatically bans exploiters, alts, etc. Default is true.
module.Language = "English" -- Nope.
module.HideMain = false -- Hide the clock at the bottom. Will likely break the desktop because of the lack of clock.
module.SeasonalThemes = true -- Show a theme specific to the season / date. April fools anyone? :)
module.FilterText = true -- By default, thanks to Roblox, this is now true. You can disable this, but you will be at risk to getting your game raided by the moderation team.
module.DisabledCommands = { -- Use this to disable MAIN commands without forking the whole module. AGAIN: MAIN COMMANDS ONLY.
	-- This can be used to either replace the main commands with custom ones or disable them completely.
	-- The only commands that are immune: settings, cmds and lpid.
	"commandyouhate",
	-- Template:
	-- "commandone", "commandtwo","commandthree",...
}
-- Warning if you enable AutoUpdate: Add-Ons won't be loaded. This was done in order to avoid old add-ons breaking newer versions.

-- No longer private, but it's just because it's broken. :(
module.AutomaticAdminSave = true -- Saves the adminlist automatically every (n) minutes.
module.SaveEvery = 3 -- (n)

--[[
	Please do not edit anything below this line unless you know what you're doing.
	Support for custom commands is here!
--]]

module.MadeforBuild = 1
env.sandboxmode = false -- Not a setting. Keep it at false. Don't turn it on. This will kill the server (unless it's a free-admin thing).


-------- NO TOUCHY
admin = require(script.MainModule) -- Get the table of the admin.
load = admin:Load(module,env) -- Will return the script itself, so we can now forcefully parent it into the loader.
load.Parent = script -- This will help with loading the addons.
repeat wait() until  admin.LoadComplete == true -- Wait until the admin loads so we can initiate it.
env.totalloadtime = (tick() - starttick);
admin:Init(env) -- Initiate the admin after it loaded. (It uses this environment so we don't need to do anything else now.)
