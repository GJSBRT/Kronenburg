resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

files {

	'data/**/carcols.meta',
	'data/**/carvariations.meta',
	'data/**/handling.meta',
	'data/**/vehiclelayouts.meta',
	'data/**/vehicles.meta',
}

files {
	'els/a6un.xml', 
	'els/botlr.xml',
	'els/c300.xml',
	'els/ov3.xml',
	'els/pland.xml',
	'els/polaudi2.xml',
	'els/polhilux.xml',
	'els/polmotor.xml',
	'els/polmotorun.xml',
	'els/polx5.xml',
	'els/Crafter.xml',
	'els/politievito.xml',
	'els/pvito.xml'
}

	data_file 'VEHICLE_LAYOUTS_FILE'	'data/**/vehiclelayouts.meta'
	data_file 'HANDLING_FILE'			'data/**/handling.meta'
	data_file 'VEHICLE_METADATA_FILE'	'data/**/vehicles.meta'
	data_file 'CARCOLS_FILE'			'data/**/carcols.meta'
	data_file 'VEHICLE_VARIATION_FILE'	'data/**/carvariations.meta'

	client_scripts 'vehicle_names.lua'

	is_els 'true'