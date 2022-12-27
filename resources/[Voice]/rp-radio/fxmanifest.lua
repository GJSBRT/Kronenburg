--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
fx_version "adamant"
game "gta5"

name "rp-radio"
description "An in-game radio which makes use of the mumble-voip radio API for FiveM"
author "Frazzle (frazzle9999@gmail.com)"
version "2.2.1"

ui_page "index.html"

dependencies {
	"mumble-voip",
}

files {
	"index.html",
	"on.ogg",
	"off.ogg",
}

client_scripts {
	"config.lua",
	"client.lua",
}

server_scripts {
	"server.lua",
}
