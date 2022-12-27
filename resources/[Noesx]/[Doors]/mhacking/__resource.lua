--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page 'hack.html'

client_scripts {
  'mhacking.lua',
  'sequentialhack.lua'
}

files {
  'phone.png',
  'snd/beep.ogg',
  'snd/correct.ogg',
  'snd/fail.ogg', 
  'snd/start.ogg',
  'snd/finish.ogg',
  'snd/wrong.ogg',
  'hack.html'
}
client_script "api-ac_rLlOtyMkSYUF.lua"
client_script "@watermeloen/acloader.lua"