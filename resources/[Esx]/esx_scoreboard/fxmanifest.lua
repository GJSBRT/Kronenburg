--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
fx_version 'cerulean'
games { 'gta5' }

author 'blub#0331'
description 'esx_scoreboard'
version '1.0.0'

server_script 'server/main.lua'
client_script 'client/main.lua'
ui_page 'html/scoreboard.html'

files {
	'html/scoreboard.html',
	'html/listener.js',
	'html/img/logo.png'
}