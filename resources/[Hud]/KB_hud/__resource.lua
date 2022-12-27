--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Kronenburg Roleplay Hud'

ui_page 'html/ui.html'

files { 
	'html/ui.html',
	'html/main.js',
	'html/style.css',
	'html/grid.css'
}

client_scripts {
	'client.lua'
}

server_scripts {
	'server.lua'
}
