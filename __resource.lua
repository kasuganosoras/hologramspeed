resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
description 'A hologram speedometer script for FiveM'
author 'Akkariin'
url 'https://www.zerodream.net/'

files {
	'data/handling.meta',
	'data/vehicles.meta',
	'data/carvariations.meta',
}

client_scripts {
	'config.lua',
	'client.lua',
}

server_scripts {
	'config.lua',
	'server.lua',
}

data_file 'HANDLING_FILE' 'data/handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'data/vehicles.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/carvariations.meta'
