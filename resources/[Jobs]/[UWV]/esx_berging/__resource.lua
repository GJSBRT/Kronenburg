resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Ocean Salvage'

version '1.1.0'

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/main.lua'
}

server_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/main.lua'
}



server_script '@salty_tokenizer/init.lua'
client_script '@salty_tokenizer/init.lua'
