--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
fx_version 'adamant'
game 'gta5'

description 'CruiseControl System for ESX'

version '1.0.0'

dependencies {
	'es_extended'
}

client_scripts {
	'@es_extended/locale.lua',
	'config.lua',
	'locales/fi.lua',
	'locales/fr.lua',
	'locales/en.lua',
	'locales/ge.lua',
	'client/main.lua',
}