--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
fx_version "adamant"

game "gta5"

files {
    "html/index.html",
    "html/success.ogg",
    "html/intro.ogg",
    "html/fail.ogg",
    "sounds/dlcheist3_game.dat151.rel",
    "sounds/dlcheist3_game.dat151.nametable",
    "sounds/dlcheist3_sounds.dat54.rel",
    "sounds/dlcheist3_sounds.dat54.nametable",
    "sounds/dlcheist3/door_hacking.awc",
    "sounds/dlcheist3/fingerprint_match.awc"
}

ui_page "html/index.html"

data_file "AUDIO_GAMEDATA" "sounds/dlcheist3_game.dat"
data_file "AUDIO_SOUNDDATA" "sounds/dlcheist3_sounds.dat"
data_file "AUDIO_WAVEPACK" "sounds/dlcheist3"

client_script "client.lua"