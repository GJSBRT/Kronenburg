--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
MyricaS = {}

MyricaS.ConfigVersion = "Myrica1S"

MyricaS.GeneralDiscordWebhookLink = "https://discord.com/api/webhooks/939934654495092777/W-OLfFLl37bvcyV_s34C_pWb-E0D1vJWOG57pP7AXbscVdpBYal4fpGF3uCUHI2hr0Na" -- General logging system (Here you will find ALL logs) -- Required.

MyricaS.EntitiesDiscordWebhookLink = "https://discord.com/api/webhooks/939934654495092777/W-OLfFLl37bvcyV_s34C_pWb-E0D1vJWOG57pP7AXbscVdpBYal4fpGF3uCUHI2hr0Na"  -- Optional , Logging Entities only webhook
MyricaS.WeaponsDiscordWebhookLink = "https://discord.com/api/webhooks/939934654495092777/W-OLfFLl37bvcyV_s34C_pWb-E0D1vJWOG57pP7AXbscVdpBYal4fpGF3uCUHI2hr0Na"  -- Optional , Logging Weapons detection only webhook
MyricaS.BlacklistedEventsWebhookLink = "https://discord.com/api/webhooks/939934654495092777/W-OLfFLl37bvcyV_s34C_pWb-E0D1vJWOG57pP7AXbscVdpBYal4fpGF3uCUHI2hr0Na" -- Optional , Logging Blacklisted Events detection only webhook
MyricaS.ExplosionsDiscordWebhookLink = "https://discord.com/api/webhooks/939934654495092777/W-OLfFLl37bvcyV_s34C_pWb-E0D1vJWOG57pP7AXbscVdpBYal4fpGF3uCUHI2hr0Na" -- Optional , Logging Explosions only webhook
MyricaS.SeclyDiscordWebhookLink = "https://discord.com/api/webhooks/939934654495092777/W-OLfFLl37bvcyV_s34C_pWb-E0D1vJWOG57pP7AXbscVdpBYal4fpGF3uCUHI2hr0Na" -- Optional , Logging Secly only webhook (Modmenu Injections,Lua manipulation)

--//Log System//--
MyricaS.ConsoleLog = true -- This will log on console warnings/kicks/bans/infos
MyricaS.DiscordLog = true -- This will log on discord webhook warnings/kicks/bans/infos
MyricaS.ChatLog = true -- This will log on ingame chat warnings/kicks/bans

--//Chat Control Stuff//--
MyricaS.BlacklistedWordsDetection = false -- Detects and log the player that tried to say something blacklisted (configs/blacklistedwords.lua)
MyricaS.BlacklistedWordsKick = false -- Kick the player that tried to say a blacklisted word (require BlacklistedWordsDetection = true)
MyricaS.BlacklistedWordsBan = false -- Ban the player that tried to say a blacklisted word (require BlacklistedWordsDetection = true)

--//Default Stuff//--
MyricaS.TriggerDetection = true -- Kick the player that tried to execute or call a blacklisted trigger (remember to edit or obfuscate your original triggers), this will find all newbie cheaters/skids


--//You can force identifiers, cheaters will always keep their identifiers hidden, with that you can prevent people without identifiers from joining your server...
MyricaS.IdentifiersChecker = true
    MyricaS.ForceSteam = true  -- Recommended
        MyricaS.ForceSteamMSG = "Je hebt je steam niet open staan!"

    MyricaS.ForceDiscord = false  -- Recommended
        MyricaS.ForceDiscordMSG = "Je hebt je discord niet gelinked met je FiveM" 

    MyricaS.ForceRockstarLicense = false  -- Recommended
        MyricaS.ForceRockstarLicenseMSG = "Rockstar License is required to join that server"

    MyricaS.ForceXboxLicense = false -- Optional
        MyricaS.ForceXboxLicenseMSG = "Xbox License is required to join that server"

    MyricaS.ForceLiveLicense = false -- Optional
        MyricaS.ForceLiveLicenseMSG = "Live License is required to join that server"

    MyricaS.ForceFiveMLicense = false -- Recommended
        MyricaS.ForceFiveMLicenseMSG = "FiveM Account is required to join that server"
--------------------------------------------------------------------------------------------------------------------
    
MyricaS.BlacklistedName = false
    MyricaS.UnauthorizedNameKickMessage = "Jouw naam is niet toegestaan op onze server."
    MyricaS.unauthNames = {
    "administrator", "admin", "[AFR] Meto", "[AFR]", "adm1n", "adm!n", "admln", "moderator", "owner", "nigger", "n1gger", "moderator", "eulencheats", "lynxmenu", "atgmenu", "hacker", "bastard", "hamhaxia", "333gang", "ukrp", "eguk", "n1gger", "n1ga", "nigga", "n1gga", "nigg3r",
    "nig3r", "shagged", "4dm1n", "4dmin", "m0d3r4t0r", "n199er", "n1993r", "rustchance.com", "rustchance", "hellcase.com", "hellcase", "youtube.com", "youtu.be", "youtube", "twitch.tv", "twitch", "anticheat.gg", "anticheat", "fucking", "ψ", "@", "&", "{", "}", ";", "ϟ", "♕", "Æ", "Œ", "‰", "™", "š", "œ", "Ÿ", "µ", "ß",
    "±", "¦", "»", "«", "¼", "½", "¾", "¬", "¿", "Ñ", "®", "©", "²", "·", "•", "°", "þ", "ベ", "ル", "ろ", "ぬ", "ふ", "う", "え", "お", "や", "ゆ", "よ", "わ", "ほ", "へ", "た", "て", "い", "す", "か", "ん", "な", "に", "ら", "ぜ", "む",
    "ち", "と", "し", "は", "き", "く", "ま", "の", "り", "れ", "け", "む", "つ", "さ", "そ", "ひ", "こ", "み", "も", "ね", "る", "め", "ロ", "ヌ", "フ", "ア", "ウ", "エ", "オ", "ヤ", "ユ", "ヨ", "ワ", "ホ", "ヘ", "タ", "テ", "イ", "ス", "カ", "ン",
    "ナ", "ニ", "ラ", "セ", "ム", "チ", "ト", "シ", "ハ", "キ", "ク", "マ", "ノ", "リ", "レ", "ケ", "ム", "ツ", "サ", "ソ", "ヒ", "コ", "ミ", "モ", "ネ", "ル", "メ", "✪", "Ä", "ƒ", "Ã", "¢", "?", "†", "€", "웃", "и", "】", "【", "j4p.pl", "ֆ", "ȶ",
    "你", "好", "爱", "幸", "福", "猫", "狗", "微", "笑", "中", "安", "東", "尼", "杰", "诶", "西", "开", "陈", "瑞", "华", "馬", "塞", "洛", "ダ", "仇", "觉", "感", "衣", "德", "曼", "L͙", "a͙", "l͙", "ľ̶̚͝", "Ḩ̷̤͚̤͑͂̎̎͆", "a̸̢͉̠͎͒͌͐̑̇", "♚", "я", "Ʒ", "Ӂ̴", "Ƹ̴", "≋",
    "chocohax", "civilgamers.com", "civilgamers", "csgoempire.com", "csgoempire", "g4skins.com", "g4skins", "gameodds.gg", "duckfuck.com", "crysishosting.com", "crysishosting", "key-drop.com", "key-drop.pl", "skinhub.com", "skinhub", "`", "¤", "¡",
    "casedrop.eu", "casedrop", "cs.money", "rustypot.com", "ÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã¢â‚¬Â", "✈", "⛧", "☭", "☣", "✠", "dkb.xss.ht", "( . )( . )", "⚆", "╮", "╭", "rampage.lt", "?", "xcasecsgo.com", "xcasecsgo", "csgocases.com",
    "csgocases", "K9GrillzUK.co.uk", "moat.gg", "princevidz.com", "princevidz", "pvpro.com", "Pvpro", "ez.krimes.ro", "loot.farm", "arma3fisherslife.net", "arma3fisherslife", "egamers.io", "ifn.gg", "key-drop", "sups.gg", "tradeit.gg",
    "§", "csgotraders.net", "csgotraders", "Σ", "Ξ", "hurtfun.com", "hurtfun", "gamekit.com", "¥", "t.tv", "yandex.ru", "yandex", "csgofly.com", "csgofly", "pornhub.com", "pornhub", "一", "", "Ｊ", "◢", "◤", "⋡", "℟", "ᴮ", "ᴼ", "ᴛᴇᴀᴍ",
    "cs.deals","twat", "STRESS.PW",
    }

MyricaS.BanSystem = true -- This on false will disable the ChocoHax's Ban System
    MyricaS.KickMessage = "Je bent verbannen voor hacken. Oneens? Maak hier een ticket https://kronenburgrp.nl/discord" -- You can edit this UwU

--//Anti Blacklisted System (tables are in tables folder)//--
MyricaS.DetectExplosions = true -- Automatically detect blacklisted explosions from (tables/blacklistedexplosions.lua)
MyricaS.AntiExplosionNuke = true -- Automatically detects if there is an explosion nuke incoming on the server
    MyricaS.AntiExplosionNukeWarning = 1 -- Default is 7 (After how many explosions the player will be warned)
    MyricaS.AntiExplosionNukeBan = 7 -- Defualt is 15 (After how many explosions the player will be kicked out and banned)

--//Clear Ped Tasks Immediately Detection//-- 
MyricaS.ClearPedTasksImmediatelyDetection = true -- Automatically detect ClearPedTasksImmediately (detect cheaters that are kicking out of vehicles other players)
MyricaS.ClearPedTasksImmediatelyKick = true
MyricaS.ClearPedTasksImmediatelyBan = false

--//BlacklistedEntity Detection//-- 
MyricaS.BlacklistedEntityDetection = true -- MasterSwitch for Entity/Peds/Vehicles detection
    MyricaS.AntiNuke = true -- Automatically detects if there is an vehicles nuke incoming on the server
    MyricaS.NONPC = true -- Enable this only if you're running a NO-NPC server
    MyricaS.BlacklistedPedDetection = true -- Detects and Delete any blacklisted PED
    MyricaS.BlacklistedVehicleDetection = true -- Detects and Delete any blacklisted Vehicle
    MyricaS.BlacklistedObjectDetection = true -- MasterSwitch for Blacklisted/Whitelisted Objects
        MyricaS.ObjectDetection = 1 -- "1" Blacklisted Entity Detection , "2" Whitelisted Entity Detection

        -- Blacklisted Entity Detection will detect only blacklisted objects that tried to spawn on your server
        -- Whitelisted Entity Detection will detect ANY OBJECT except for the whitelisted ones (If you understand how that works, is the perfect weapon against cheaters)


--//BlacklistedWeapons Detection//-- 
MyricaS.BlacklistedWeaponGiveDetection = true -- Automatically detects cheaters trying to give blacklisted weapons to other players
MyricaS.BlacklistedWeaponUseDetection = true -- Automatically detects players trying to use blacklisted weapons
MyricaS.BlacklistedWeaponRemoveDetection = true -- Automatically detects cheaters trying to remove weapons from other players
MyricaS.MaxWeaponAmmo = 250 -- Automatically detect if someone tries to give themself/someone else more than 100 ammos

--//WebPanel//--
MyricaS.WebPanelEnabled = false -- Disable or enable panel


--//Permission System//-- DO NOT TOUCH IF YOU DON'T KNOW WHAT ARE U DOING 
MyricaS.Bypass = {"chocohaxadministrator","chocohaxmoderator"} -- This will allow the user with these perms to bypass Violation detections such as mod menus/weapons/godmode, etc.
MyricaS.AdminMenu = {"chocohaxadministrator"} -- This will allow the user with these perms to load the ChocoMenu.
MyricaS.Spectate = {"chocohaxadministrator","chocohaxmoderator"} -- This will allow the user with these perms to spectate other users.
MyricaS.Blips = {"chocohaxadministrator","chocohaxmoderator","chocohaxjobs"} -- This will allow the user with these perms to use Player Blips.
