resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

files {
    'data/**/handling.meta',
	'data/**/vehicles.meta',
	'data/**/carvariations.meta',
	'data/**/carcols.meta',
	'data/**/carvariations.meta',
	'data/**/vehiclelayouts.meta',
	'kmaramarok.xml',
	'kmarbklasse.xml',
	'kmargklasse.xml',
    'kmarmotor3.xml',
    'kmarmotor.xml',
	'kmaramarok.xml',
	'kmaropel.xml',
	'kmarranger.xml',
	'KmarT6.xml',
	'kmarvito.xml',
    'kmaraudi.xml',
	'kmarb.xml',
	'kmaroffroad.xml',
	'kmart5.xml',
	'kmartouran.xml',


}

data_file 'HANDLING_FILE' 'data/**/handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'data/**/vehicles.meta'
data_file 'CARCOLS_FILE' 'data/**/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/**/carvariations.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'data/**/vehiclelayouts.meta'

is_els 'true'

