--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
Config                            = {}

Config.DrawDistance               = 100.0
Config.MarkerColor                = { r = 102, g = 0, b = 102 }
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 1.0 }
Config.ReviveReward               = 150  -- revive reward, set to 0 if you don't want it enabled
Config.AntiCombatLog              = true -- enable anti-combat logging?
Config.LoadIpl                    = true -- disable if you're using fivem-ipl or other IPL loaders


Config.Locale                     = 'en'

local second = 1000
local minute = 60 * second

Config.EarlyRespawnTimer          = 10 * minute  -- Time til respawn is available
Config.BleedoutTimer              = 10 * minute -- Time til the player bleeds out

Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = false

Config.RemoveWeaponsAfterRPDeath  = true
Config.RemoveCashAfterRPDeath     = true
Config.RemoveItemsAfterRPDeath    = true

-- Let the player pay for respawning early, if he can afford it.
Config.EarlyRespawnFine           = false
Config.EarlyRespawnFineAmount     = 1000

Config.Blip = {
	Pos     = { x = -446.46, y = -339.14, z = 34.5 },
	Sprite  = 61,
	Display = 4,
	Scale   = 0.9,
	Colour  = 2
}

Config.Blip2 = {
	Pos     = { x = -446.46, y = -339.14, z = 34.5 },
	Sprite  = 61,
	Display = 4,
	Scale   = 0.9,
	Colour  = 2
}

Config.HelicopterSpawner = {
	SpawnPoint = { x = -456.89, y = -290.28, z = 77.17 },
	Heading    = 202.15
}

-- https://wiki.rage.mp/index.php?title=Vehicles
Config.AuthorizedVehicles = {
	{
		model = 'ambubmw',
		label = 'Ambulance BMW'
		},
		{
		model = 'ambusprinter',
		label = 'Ambulance Sprinter'
		},
		{
			model = 'ambumout',
			label = 'Ambulance Mitchellbitsi'
		},
		{
			model = 'volvommt',
			label = 'Ambulance Volvo'
		},
		{
			model = 'ambuovdg',
			label = 'Ambulance Skoda'
		},
		{
			model = 'amb1',
			label = 'Ambulance Volvo'
		},
		{
			model = 'amb2',
			label = 'Ambulance Mercedes'
		},
		{
			model = 'ambuamarok',
			label = 'Ambulance Amarok'
		},
		{
			model = 'ambum',
			label = 'Ambulance Sprinter'
		},
		{
			model = 'audiq8ambu',
			label = 'Ambulance Audi'
		},
		{
			model = 'ambumotor',
			label = 'Ambulance Motor'
		},
		{
			model = 'ambumicu',
			label = 'Ambulance Vrachtwagen'
		},
		{
			model = 'amodelx',
			label = 'Ambulance Tesla'
		},
}

Config.Zones = {

	HospitalInteriorInside1 = { --Respawn
		Pos	= { x = -448.87, y = -340.73, z = 34.5 },
		Type = -1
	},

	HospitalInteriorEntering3 = { -- Teleportatie naar beneden auto spawner
		Pos	= { x = -436.13, y = -359.6, z = 33.95 },
		Type = 1
	},

	HospitalInteriorEntering2 = { -- Linker lift omhoog naar dak
		Pos	= { x = -442.17, y = -343.24, z = 34.01 },
		Type = 1
	},

	HospitalInteriorInside2 = { -- Uitkomst locatie dak na linker lift gebruik
		Pos	= { x = -443.44,	y = -329.45, z = 77.17 },
		Type = -1
	},

	HospitalInteriorOutside2 = { -- Rechter lift als je terug komt van het dak
		Pos	= { x = -435.76,	y = -356.76, z = 34.91 },
		Type = -1
	},

	HospitalInteriorExit3 = { -- Uitkomst teleportatie beneden auto spawner
		Pos	= { x = -419.06,	y = -344.81, z = 23.23 },
		Type = 1
	},

	HospitalInteriorMannetjeMan = { -- Uitkomst van beneden plaats
	Pos	= { x = -421.95,	y = -345.84, z = 23.23 },
	Type = -1
},

	HospitalInteriorExit2 = { -- Cirkel op dak terug naar rechter lift
		Pos	= { x = -443.93,	y = -331.99, z = 77.17 },
		Type = 1
	},

	AmbulanceActions = { -- Cloakroom
		Pos	= { x = -437.91, y = -308.20, z = 34.91 },
		Type = 30
	},

	VehicleSpawner = {
		Pos	= { x = -485.2451, y = -332.2365, z = 34.3616 },
		Type = 36
	},

	VehicleSpawnPoint = {
		Pos	= { x = -487.5806, y = -342.8831, z = 34.3633 },
		Heading    = 253.9380,
		Type = -1
	},

	VehicleDeleter = {
		Pos	= { x = -478.9197, y = -339.3140, z = 34.3878 },
		Type = 1
	},

	Pharmacy = {
		Pos	= { x = -435.64, y = -320.36, z = 33.91 },
		Type = 1
	},

}




Config.Uniforms = {
	ambulance_oud_lang = {
		male = {
			['tshirt_1'] = 20,  ['tshirt_2'] = 0,
			['torso_1'] = 118,   ['torso_2'] = 2,
			['decals_1'] = 2,   ['decals_2'] = 0,
			['arms'] = 86,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['pants_1'] = 49,   ['pants_2'] = 0,
			['shoes_1'] = 82,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['bproof_1'] = 0,    ['bproof_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 14,  ['tshirt_2'] = 0,
			['torso_1'] = 265,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 99,       ['mask_1'] = 0,
			['pants_1'] = 30,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0
		}
	},
	ambulance_nieuw_lang = {
		male = {
			['tshirt_1'] = 20,  ['tshirt_2'] = 0,
			['torso_1'] = 118,   ['torso_2'] = 7,
			['decals_1'] = 2,   ['decals_2'] = 0,
			['arms'] = 86,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['pants_1'] = 49,   ['pants_2'] = 0,
			['shoes_1'] = 82,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['bproof_1'] = 0,    ['bproof_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		},--[[
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}]]
	},
	ambulance_nieuw_kort = {
		male = {
			['tshirt_1'] = 20,  ['tshirt_2'] = 0,
			['torso_1'] = 73,   ['torso_2'] = 0,
			['decals_1'] = 1,   ['decals_2'] = 0,
			['arms'] = 85,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['pants_1'] = 49,   ['pants_2'] = 0,
			['shoes_1'] = 82,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['bproof_1'] = 0,    ['bproof_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		},--[[
		female = {
			['tshirt_1'] = 55,  ['tshirt_2'] = 0,
			['torso_1'] = 3,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 85,
			['mask_1'] = 1,   ['mask_2'] = 0,
			['pants_1'] = 36,   ['pants_2'] = 0,
			['shoes_1'] = 26,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['bproof_1'] = 14,    ['bproof_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		}]]
	},
	ambulance_mmt = {
		male = {
			['tshirt_1'] = 20,  ['tshirt_2'] = 0,
			['torso_1'] = 51,   ['torso_2'] = 0,
			['decals_1'] = 1,   ['decals_2'] = 0,
			['arms'] = 85,
			['mask_1'] = 0,   ['mask_2'] = 0,
			['pants_1'] = 49,   ['pants_2'] = 0,
			['shoes_1'] = 82,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['bproof_1'] = 25,    ['bproof_2'] = 4,
			['ears_1'] = 0,     ['ears_2'] = 0
		},--[[
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 3,
			['arms'] = 44,
			['pants_1'] = 35,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}]]
	},
	ambulance_ovdg = {
		male = {
			['tshirt_1'] = 55,  ['tshirt_2'] = 0,
			['torso_1'] = 3,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 85,
			['mask_1'] = 1,   ['mask_2'] = 0,
			['pants_1'] = 36,   ['pants_2'] = 0,
			['shoes_1'] = 82,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['bproof_1'] = 14,    ['bproof_2'] = 0,
			['decals_1'] = 0,	['decals_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0
		},--[[
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 3,
			['arms'] = 44,
			['pants_1'] = 35,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}]]
	}
}