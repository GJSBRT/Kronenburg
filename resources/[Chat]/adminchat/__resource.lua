--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ADMIN Chat - ESX NEED'

version '1.0.0'

client_script {

  'client/main.lua'

}

server_scripts {

  '@mysql-async/lib/MySQL.lua',
  'server/main.lua'

}
