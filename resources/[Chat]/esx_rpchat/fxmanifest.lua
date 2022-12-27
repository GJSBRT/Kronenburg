--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
fx_version 'cerulean'
game 'gta5'

--[[

  ESX RP Chat

--]]


author 'ZwanenburgRP'
description 'ESX RP Chat modified for ZwanenburgRP'
version '1.0.0'

shared_script '@es_extended/imports.lua'

client_scripts {
  'client/main.lua'
}

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  'server/main.lua'
}

dependencies {
  'es_extended'
}
