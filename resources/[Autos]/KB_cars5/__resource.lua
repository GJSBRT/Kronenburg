--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 

fx_version 'cerulean'
games { 'gta5' }
files {
	'data/**/vehicles.meta',
	'data/**/carvariations.meta',
	'data/**/carcols.meta',
	'data/**/handling.meta',
	'data/**/dlctext.meta',
	'data/**/vehiclelayouts.meta',
	'data/**/shop_vehicle.meta',
	'data/**/carcontentunlocks.meta',
}
data_file 'HANDLING_FILE' 'data/**/handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'data/**/vehicles.meta'
data_file 'CARCOLS_FILE' 'data/**/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/**/carvariations.meta'
data_file 'DLCTEXT_FILE' 'data/**/dlctext.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'data/**/vehiclelayouts.meta'
data_file 'VEHICLE_SHOP_FILE' 'data/**/shop_vehicle.meta'
data_file 'CARCONTENTUNLOCKS_FILE' 'data/**/carcontentunlocks.meta'

client_script 'vehicle_names.lua'