--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
fx_version 'cerulean'

game 'gta5'
author 'blub#0331'
description 'ES Extended voor Kronenburg Roleplay'

version 'kronenburg'

shared_scripts {
	'locale.lua',
	'locales/en.lua',

	'config.lua',
	'config.weapons.lua',
}

server_scripts {
	'@async/async.lua',
	'@mysql-async/lib/MySQL.lua',

	'server/common.lua',
	'server/classes/player.lua',
	'server/functions.lua',
	'server/paycheck.lua',
	'server/main.lua',
	'server/commands.lua',

	'common/modules/math.lua',
	'common/modules/table.lua',
	'common/functions.lua'
}

client_scripts {
	'client/common.lua',
	'client/entityiter.lua',
	'client/functions.lua',
	'client/wrapper.lua',
	'client/main.lua',

	'client/modules/death.lua',
	'client/modules/scaleform.lua',
	'client/modules/streaming.lua',

	'common/modules/math.lua',
	'common/modules/table.lua',
	'common/functions.lua'
}

files {
	'imports.lua',
	'locale.js'
}

exports {
	'getSharedObject'
}

server_exports {
	'getSharedObject'
}

dependencies {
	'mysql-async',
	'async',
	'spawnmanager',
}
