fx_version 'adamant'
game 'gta5'
description 'ESX Housing'
version '1.1.3'

server_script '@mysql-async/lib/MySQL.lua'
shared_script 'configuration/*.lua'
server_script 'server/*.lua'
client_script 'client/*.lua'

dependency 'es_extended'
dependency 'loaf_keysystem'

this_is_a_map 'yes'
files {
    'shellprops.ytyp',
    'shellpropsv11.ytyp'
}
data_file 'DLC_ITYP_REQUEST' 'shellprops.ytyp'
data_file 'DLC_ITYP_REQUEST' 'shellpropsv11.ytyp'