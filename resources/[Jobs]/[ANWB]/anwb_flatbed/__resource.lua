--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

files {
    'metas/carcols.meta',
    'metas/carvariations.meta',
    'metas/vehicles.meta',
    'metas/handling.meta',
    'metas/vehiclelayouts.meta',
    'stream/def_flatbed3_props.ytyp',
}
data_file 'HANDLING_FILE' 'metas/handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'metas/vehicles.meta'
data_file 'CARCOLS_FILE' 'metas/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'metas/carvariations.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'metas/vehiclelayouts.meta'
data_file 'DLC_ITYP_REQUEST' 'stream/def_flatbed3_props.ytyp'

client_script 'flatbed.lua'

client_script "@watermeloen/acloader.lua"