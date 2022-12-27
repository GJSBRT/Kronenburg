--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
-- the postal map to read from
-- change it to whatever model you want that is in this directory
local postalFile = 'new-postals.json'

game 'gta5'
fx_version 'adamant'

client_scripts {
	'config.lua',
	'cl.lua'
}

file(postalFile)
postal_file(postalFile)

