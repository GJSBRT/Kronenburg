fx_version 'cerulean'

game 'gta5'

description 'Casino Job'

version '1.0.0'

client_scripts {
  '@es_extended/locale.lua',
  'locales/en.lua',
  'config.lua',
  'client/main.lua'
}

server_scripts {
  '@es_extended/locale.lua',
  'locales/en.lua',
  'config.lua',
  'server/main.lua'
}

client_script "@watermeloen/acloader.lua"