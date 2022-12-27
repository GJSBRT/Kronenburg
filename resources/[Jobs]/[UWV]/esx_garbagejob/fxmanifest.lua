--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
fx_version 'adamant'

game 'gta5'

server_scripts {
	'@es_extended/locale.lua',
	'locales/cs.lua',
	'locales/en.lua',
	'locales/es.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/cs.lua',
	'locales/en.lua',
	'locales/es.lua',
	'config.lua',
	'client/main.lua'
}

server_script '@salty_tokenizer/init.lua'
client_script '@salty_tokenizer/init.lua'
