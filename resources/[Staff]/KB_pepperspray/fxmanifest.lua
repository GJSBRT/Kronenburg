fx_version 'cerulean'
games { 'gta5' }

author 'claus en bloeb'
description 'pepperspray anticheat ding'
version '1.0.0'

client_scripts { 'client/*.lua' }
server_scripts { 
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua'
}