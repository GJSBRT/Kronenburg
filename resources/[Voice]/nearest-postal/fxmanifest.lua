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

