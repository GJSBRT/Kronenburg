fx_version 'adamant'
game 'gta5'
resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

files {
	'handling.meta',
	'vehicles.meta',
	'carvariations.meta',
	'pamarok.xml'
	--'carcontentunlocks.meta'
}

data_file 'HANDLING_FILE' 'handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'carvariations.meta'
--data_file 'CARCONTENTUNLOCKS_FILE' 'carcontentunlocks.meta' --Apparantly doesn't exist at all

--client_scripts 'vehicle_names.lua'

is_els 'true'