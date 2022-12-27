--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
fx_version 'adamant'

game 'gta5'

description 'ESX Pool Cleaner'

version '1.1'

client_scripts {
	'@es_extended/locale.lua',
	'locales/tr.lua',
	'locales/en.lua',
	'locales/fr.lua',
	'client/main.lua',
	'config.lua',
}



server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/tr.lua',
	'locales/en.lua',
	'locales/fr.lua',
	'server/main.lua',
	'config.lua',
}


 