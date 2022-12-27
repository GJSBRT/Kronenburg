--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
fx_version 'cerulean'
games { 'gta5' }

author 'claus en bloeb'
description 'pepperspray anticheat ding'
version '1.0.0'

client_scripts { 'client/*.lua' }
server_scripts { 
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua'
}