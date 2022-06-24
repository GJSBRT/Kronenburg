fx_version 'adamant'

game 'gta5'

description 'ESX JB Eden Garage'

dependencies {
	'es_extended',
	'ft_libs'
}

server_scripts {
	'@salty_tokenizer/init.lua',  
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/fi.lua',	
	'locales/fr.lua',
	'locales/es.lua',
	'config.lua',
	'server/main.lua',
	'version.lua',
}

client_scripts {
	'@salty_tokenizer/init.lua',  
	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/fi.lua',	
	'locales/fr.lua',
	'locales/es.lua',
	'config.lua',
	'client/main.lua',
}

