resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'En person meny gjord av xBlueSI'

client_scripts {
	'@salty_tokenizer/init.lua',  
	'client.lua',
	'@es_extended/locale.lua',
	'locales/sv.lua',
	'locales/en.lua',
	'config.lua'
}

server_scripts {
	'@salty_tokenizer/init.lua',  
	'@es_extended/locale.lua',
	'locales/sv.lua',
	'locales/en.lua',
	'config.lua'
}


 