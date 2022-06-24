fx_version 'adamant'

game 'gta5'

author 'SOPA.dev (Skaffa)'
description 'ESX GiveCarKeys for ZwanenburgRP 2.0'
version '1.0.0'

shared_script '@es_extended/imports.lua'

server_script {
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'config.lua',
	'client/main.lua'
}

dependencies {
	'es_extended'
}
