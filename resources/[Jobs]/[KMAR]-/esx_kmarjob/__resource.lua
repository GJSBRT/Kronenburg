resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'


version '1.2.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/br.lua',
	'locales/de.lua',
	'locales/en.lua',
	'locales/pl.lua',
	'locales/fr.lua',
	'locales/fi.lua',
	'locales/es.lua',
	'locales/sv.lua',
	'config.lua',
	'server/main.lua',
	'server/inBeslagname.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/br.lua',
	'locales/de.lua',
	'locales/en.lua',
	'locales/pl.lua',
	'locales/fr.lua',
	'locales/fi.lua',
	'locales/es.lua', 
	'locales/sv.lua',
	'config.lua',
	'client/main.lua',
	'client/inBeslagname.lua'
}

server_script '@salty_tokenizer/init.lua'
client_script '@salty_tokenizer/init.lua'

dependency 'progressBars'
