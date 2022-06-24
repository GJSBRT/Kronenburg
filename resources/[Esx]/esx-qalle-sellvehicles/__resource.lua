resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

client_scripts {
    "config.lua",
    "client/main.lua",
	'@es_extended/locale.lua',
    'locales/de.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/fr.lua',
	'locales/es.lua',
	'locales/sv.lua'
}

server_scripts {
    "@mysql-async/lib/MySQL.lua",
	'@es_extended/locale.lua',
    "config.lua",
    'locales/de.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/fr.lua',
	'locales/es.lua',
	'locales/sv.lua',
    "server/main.lua"
}