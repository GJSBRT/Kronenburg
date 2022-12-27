--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
fx_version 'cerulean'
games {'gta5'}

author 'Modif by LTZ KORP'
description 'HUD Speedometer'
version '1.0.0'

ui_page "ui/index.html"
files {
	"ui/index.html",
	"ui/assets/clignotant-droite.svg",
	"ui/assets/clignotant-gauche.svg",
	"ui/assets/feu-position.svg",
	"ui/assets/feu-route.svg",
	"ui/assets/fuel.svg",
	"ui/fonts/fonts/Roboto-Bold.ttf",
	"ui/fonts/fonts/Roboto-Regular.ttf",
	"ui/script.js",
	"ui/style.css",
	"ui/debounce.min.js"
}

client_scripts {
	"client.lua",
}
