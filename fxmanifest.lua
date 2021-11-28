fx_version 'cerulean'
game 'gta5'

author 'Akkariin'
description 'A hologram speedometer script for FiveM'
url 'https://www.zerodream.net/'
version '1.0.3'

files {
	'data/handling.meta',
	'data/vehicles.meta',
	'data/carvariations.meta',
	'ui/**/*.*',
	'ui/*.*'
}

client_script 'client.lua'
server_script 'server.lua'

data_file 'HANDLING_FILE' 'data/handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'data/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/carvariations.meta'

export 'ToggleDisplay'
