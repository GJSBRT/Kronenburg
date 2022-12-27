--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
-- Resource Metadata
fx_version 'cerulean'
games { 'gta5' }

author 'blub#0331'
description 'Random Resources Combined'
version '1.0.0'

ui_page('html/index.html')

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@oxmysql/lib/MySQL.lua',
	'server/*.lua',
}

client_scripts {
	'client/*.lua',
}

files {
    'html/listener.js',
    'html/style.css',
    'html/reset.css',
    'html/index.html',
    'html/yeet.ogg'
}
