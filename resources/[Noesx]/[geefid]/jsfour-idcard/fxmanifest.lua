fx_version 'adamant'
game 'gta5'

ui_page 'html/index.html'

client_script {
	'@esx_boilerplate/natives.lua',
	'@es_extended/locale.lua',
	'client.lua'
}

server_script {
	'@esx_boilerplate/natives_server.lua',
	'@anticheat/event_s.lua',
	'@mysql-async/lib/MySQL.lua',
	'server.lua'
}

files {
	'html/index.html',
	'html/assets/css/style.css',
	'html/assets/js/jquery.js',
	'html/assets/js/init.js',
	'html/assets/fonts/roboto/Roboto-Bold.woff',
	'html/assets/fonts/roboto/Roboto-Bold.woff2',
	'html/assets/fonts/roboto/Roboto-Light.woff',
	'html/assets/fonts/roboto/Roboto-Light.woff2',
	'html/assets/fonts/roboto/Roboto-Medium.woff',
	'html/assets/fonts/roboto/Roboto-Medium.woff2',
	'html/assets/fonts/roboto/Roboto-Regular.woff',
	'html/assets/fonts/roboto/Roboto-Regular.woff2',
	'html/assets/fonts/roboto/Roboto-Thin.woff',
	'html/assets/fonts/roboto/Roboto-Thin.woff2',
	'html/assets/fonts/justsignature/JustSignature.woff',
	'html/assets/css/materialize.min.css',
	'html/assets/js/materialize.js',
	'html/assets/images/ambupas.png',
	'html/assets/images/anwbpas.png',
	'html/assets/images/ehbopas.png',
	'html/assets/images/idcard.png',
	'html/assets/images/kmarpas.png',
	'html/assets/images/lawyer.png',
	'html/assets/images/politiepas.png',
	'html/assets/images/press.png',
	'html/assets/images/rijbewijs.png',
	'html/assets/images/staffpas.png',
	'html/assets/images/taxipas.png',
	'html/assets/images/vliegbrevet.png',
	'html/assets/images/zorgverzekeringspas.png',
	'html/assets/images/tolpas.png',
	'html/assets/images/casinoVIP.png',
}