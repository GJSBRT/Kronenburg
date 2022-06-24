resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

files {
	'audioconfig/toysupmk4_game.dat151.rel',
	'audioconfig/toysupmk4_sounds.dat54.rel',
	'sfx/dlc_toysupmk4/toysupmk4.awc',
	'sfx/dlc_toysupmk4/toysupmk4_npc.awc'
}

data_file 'AUDIO_GAMEDATA' 'audioconfig/toysupmk4_game.dat'
data_file 'AUDIO_SOUNDDATA' 'audioconfig/toysupmk4_sounds.dat'
data_file 'AUDIO_WAVEPACK' 'sfx/dlc_toysupmk4'

client_script {
    'vehicle_names.lua'
}