--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Jobs'

version '1.1.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/fi.lua',
	'locales/fr.lua',
	'locales/sv.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/br.lua',
	'locales/fi.lua',
	'locales/en.lua',
	'locales/fr.lua',
	'locales/sv.lua',
	'config.lua',
	'client/jobs/fisherman.lua',
	'client/jobs/fueler.lua',
	-- 'client/jobs/lumberjack.lua',
	'client/jobs/miner.lua',
	'client/jobs/reporter.lua',
	'client/jobs/slaughterer.lua',
	'client/jobs/tailor.lua',
	'client/main.lua'
}

dependencies {
	'es_extended',
	'esx_addonaccount',
	'skinchanger',
	'esx_skin'
}

 