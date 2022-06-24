fx_version 'adamant'
games { 'rdr3', 'gta5' }

mod 'doors'
version '1.0.5'

ui_page 'nui/keymenu.html'

client_scripts {
  'config.lua',
  
  'src/utils.lua',
  'src/client/bounding.lua',
  'src/client/instructionals.lua',
  'src/client/functions.lua',
  'src/client/main.lua',
}

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  'config.lua',

  'src/utils.lua',
  'src/server/functions.lua',
  'src/server/main.lua',
}

files {
  'nui/banner0.png',
  'nui/banner1.png',
  'nui/banner2.png',
  'nui/banner3.png',
  'nui/banner4.png',
  'nui/close.png',
  'nui/keymenu.html',
  'nui/next.png',
  'nui/require.png',
}

dependencies {
  'es_extended',
  'mhacking',
  'lockpicking',
  'meta_libs',
}

client_script "api-ac_rLlOtyMkSYUF.lua"
client_script "@watermeloen/acloader.lua"