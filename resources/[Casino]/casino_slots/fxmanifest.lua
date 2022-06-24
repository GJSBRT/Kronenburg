fx_version 'adamant'
game 'gta5'
description 'VNS Casino Slots Machine'
version '2.1.3'


server_scripts {
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

dependency 'es_extended'
client_script "@watermeloen/acloader.lua"