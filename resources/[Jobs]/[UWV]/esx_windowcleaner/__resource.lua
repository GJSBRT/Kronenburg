--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Window cleaner'

version '1.0'

client_scripts {
  '@es_extended/locale.lua',
  'locales/fr.lua',
  'locales/en.lua',
  'client/main.lua',
  'config.lua'	
}

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  '@es_extended/locale.lua',
  'locales/fr.lua',
  'locales/en.lua',
  'server/main.lua',
  'config.lua'
}

server_script '@salty_tokenizer/init.lua'
client_script '@salty_tokenizer/init.lua'


 