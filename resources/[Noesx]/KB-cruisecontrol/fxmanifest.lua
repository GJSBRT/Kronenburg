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