--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
fx_version 'cerulean'
game 'gta5'
author 'Ali Exacute#2588'
description 'ESX Admin commands'
version '1.1.0'

shared_scripts {
    '@es_extended/locale.lua',
    'locales/en.lua',
    'locales/es.lua',
    'locales/fa.lua',
    'config.lua'
}
client_script 'client.lua'
server_script 'server.lua'

dependency "es_extended"
