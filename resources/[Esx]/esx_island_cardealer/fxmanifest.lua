fx_version 'adamant'

game 'gta5'

description 'ESX Eiland Cardealer'

version '1.1.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/utils.lua',
	'client/main.lua'
}

dependency 'es_extended'

export 'GeneratePlate'

