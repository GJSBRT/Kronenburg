--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
fx_version 'adamant'

game 'gta5'

description 'ESX Data Store'

version 'legacy'

server_scripts {
	'@es_extended/imports.lua',
	'@mysql-async/lib/MySQL.lua',
	'server/classes/datastore.lua',
	'server/main.lua'
}
