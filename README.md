Found an issue? Please report it either indirectly in Issues, or contact me directly in Discord for critical glitches or bugs.

Issues template;
Issue Type: [Desktop / Admin (Redefine:A)]
Expected Behavior:
What Actually Happens:
Module Build [If Admin (Redefine:A)]:
What Admin system are you using? [If Desktop]:

---------------------------------------------------------------

   _____ _             _ _         ______             _ 
  / ____| |           | (_)       |  ____|           (_)
 | (___ | |_ _   _  __| |_  ___   | |__   _ __   __ _ _ 
  \___ \| __| | | |/ _` | |/ _ \  |  __| | '_ \ / _` | |
  ____) | |_| |_| | (_| | | (_) | | |____| | | | (_| | |
 |_____/ \__|\__,_|\__,_|_|\___/  |______|_| |_|\__, |_|
	            	                        __/ |  
       				       	        |___/   

---------------------------------------------------------------
-----------	    Full Release of V.03	    -----------
---------------------------------------------------------------

Copyright Protected © Studio Engi, EngiAdurite and the Lead Contributors, 2020.
Refer to the Internal Use Info & License for more info.

Thank you for using a fine product made by Studio Engi.
All of the products made by Studio Engi are and always will be Open Source.
To provide the best experience using your product, please follow the included instructions.

Warning: Redefine:A Plugins WILL NOT be applicable for Copyright unless they are open source and without any require()'s!

--------------------------------------------------------------

Setting up;

Please make sure to fill those sections;
	RootAdmins
	SuperAdmins
	Admins
	Moderators
	VIP
	Bans
	BanLand
	Prefix
	Autosave

Note; Failure to do so BEFORE the first admin initialisation will end up needing a datastore reset.

-------------------------------------------------------------

Resetting datastore in-case the previous step hasn't been followed;

As Game Owner; 

Use !resetadmins (SecretKey) twice.
You can get the SecretKey by opening the developer console (F9) and looking for the initialisation message.

---

As Developer with access, which for some reason doesn't follow the requirements;

Go to this script's children and open MainModule.

Inside MainModule, edit this part;
db = dbs:GetCategory("Admin_RedefineA")

to;
db = dbs:GetCategory("Admins_RedefineA")

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

F3X Building Tools by GigsD4X (3.0.2)				| The Provided Building Tools.
[!] Make sure httpService is enabled for full use of the Building Tools!
	
Studio Engi AGB Global Banlist by EngiAdurite 			| Optional External Banlist.

Roundify by Stelrex						| Better UI Build.

Easy DataStorage Manager by VolcanoINC				| Easier Datastorage Access.

Zeus Admin by TheKitDev						| This is literally the Deluxe version of Zeus Admin.
[!] No, the source isn't made by TheKitDev, but rather the whole idea is constructed by him.

--------------------------------------------------------------

Credits;

Lead(s):
	@EngiAdurite		| Head of Project, Head Scripter
	@Yes_Cone		| Head UI Designer

Contributor(s): 
	Most contributors will get access to the private loader upon release.
	-------------------------------------------------------
	@decipheringcode		| Pre-Alpha Tester
	@thebluepenguin1		| Pre-Alpha Tester
	@Pristh 			| Alpha Contribution
	@WolfieTheDino			| Alpha Contribution
	@Bad_BunnyBabyXD		| Post-Alpha Contribution
	@Meqpi				| Post-Alpha Contribution
	@TheKitDev			| Personal Thanks for the idea of Zeus Admin Deluxe
	Steamin' Beans 			| Alpha Testing Ground
	@alfivq				| Alpha Testing Ground
	@limesouls			| Alpha & Post-Alpha Tester
	@HonestlyEllie			| Alpha Tester
	@fmprej192			| Alpha Tester
	@Dev_Adurite			| Alpha Tester
	@DiscombobulatedJack		| Alpha Tester
	@Lsarowar20000			| Alpha Tester
	@JesseyJSyndicate 		| Alpha Tester
	
	You helped Alpha Test and I didn't add you to the list?
	DM me on Discord in order to be added: 		 Sezei#3061
	

External Materials Owner(s):
	F3X / @GigsD4X			| F3X Building Tools
	Raspberry			| Dex
	@VolcanoINC			| Easy DataStorage Manager
	@Mayk728			| 2 audios used in the admin
	@Jakkyou			| An audio used in the admin
	@DevHasan			| An audio used in the admin
	@Stelrex			| Previously used Roundify. Still available in the legacy UI.
