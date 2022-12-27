--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
fx_version 'cerulean'
game 'common'

name 'oxmysql'
description 'Database wrapper for FiveM utilising node-mysql2 offering improved performance and security.'
version '1.9.2'
url 'https://github.com/overextended/oxmysql'
author 'overextended'

dependencies {
	'/server:5104',
}

server_scripts {
	'dist/server/build.js',
}

provide 'mysql-async'
