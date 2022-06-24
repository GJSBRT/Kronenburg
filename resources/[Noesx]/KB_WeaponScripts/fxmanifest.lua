fx_version 'adamant'

game 'gta5'

use_fxv2_oal 'true'

server_scripts {
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'config.lua',
	'client/main.lua',
	'client/weapons.lua',
    'client/bones.lua'
}

dependencies {
    'es_extended'
}