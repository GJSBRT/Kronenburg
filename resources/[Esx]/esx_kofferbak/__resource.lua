resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Kronenburger Kofferbak- V2'

version '1.0.0'

server_scripts {
  '@salty_tokenizer/init.lua',  
  '@async/async.lua',
  '@mysql-async/lib/MySQL.lua',
  'config/config.lua',
  'server/main.lua'
}

client_scripts {
  '@salty_tokenizer/init.lua',  
  'config/config.lua',
  'client/main.lua'
}


 