Config                            = {}
Config.Locale                     = 'nl'

Config.DrawDistance               = 50.0
Config.MaxInService               = -1
Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = false

Config.NPCSpawnDistance           = 500.0
Config.NPCNextToDistance          = 25.0
Config.NPCJobEarnings             = { min = 15, max = 40 }

Config.Vehicles = {
	'flatbed3',
	'anwb4',
	'anwb6'
}  

Config.Zones = {

	MechanicActions = {
		Pos   = { x = -341.46, y = -162.14, z = 44.59 },
		Size  = {x = 0.5, y = 0.75, z = 0.25},
		Color = {r = 255, g = 175, b = 0},
		Type  = 1
	},

	Garage = {
		Pos   = { x = -328.5184, y = -147.2952, z = 39.0151 },
		Size  = {x = 0.5, y = 0.75, z = 0.25},
		Color = {r = 255, g = 175, b = 0},
		Type  = 1
	},

	Craft = {
		Pos   = { x = -323.140, y = -129.882, z = -26.999 },
		Size  = {x = 0.5, y = 0.75, z = 0.25},
		Color = {r = 255, g = 175, b = 0},
		Type  = 1
	},

	VehicleSpawnPoint = {
		Pos   = { x = -355.75, y = -79.82, z = 45.26},
		Size  = {x = 0.5, y = 0.75, z = 0.25},
		Type  = -1
	},

	VehicleDeleter = {
		Pos   = { x = -360.41, y = -76.01, z = 45.67 },
		Size  = {x = 0.5, y = 0.75, z = 0.25},
		Color = {r = 255, g = 175, b = 0},
		Type  = 1
	},

	VehicleDelivery = {
		Pos   = { x = -353.75, y = -115.92, z = -37.7 },
		Size  = {x = 0.5, y = 0.75, z = 0.25},
		Color = {r = 255, g = 175, b = 0},
		Type  = -1
	}
}

Config.Uniforms = {
	-- anwb_kleding_1 = {
	-- 	male = {
	-- 		['tshirt_1'] = 15,  ['tshirt_2'] = 0,
	-- 		['torso_1'] = 328,   ['torso_2'] = 0,
	-- 		['decals_1'] = 0,   ['decals_2'] = 0,
	-- 		['arms'] = 63,
	-- 		['pants_1'] = 120,   ['pants_2'] = 0,
	-- 		['shoes_1'] = 25,   ['shoes_2'] = 0,
	-- 		['helmet_1'] = -1,  ['helmet_2'] = 0,
	-- 		['chain_1'] = 0,    ['chain_2'] = 0,
	-- 		['bproof_1'] = 0,     ['bproof_2'] = 0,
	-- 		['mask_1'] = 121,  ['mask_2'] = 0
	-- 	},
	-- 	female = {
	-- 		['tshirt_1'] = 15,  ['tshirt_2'] = 0,
	-- 		['torso_1'] = 110,   ['torso_2'] = 1,
	-- 		['decals_1'] = 0,   ['decals_2'] = 0,
	-- 		['arms'] = 49,
	-- 		['pants_1'] = 49,   ['pants_2'] = 0,
	-- 		['shoes_1'] = 25,   ['shoes_2'] = 0,
	-- 		['helmet_1'] = -1,  ['helmet_2'] = 0,
	-- 		['mask_1'] = 0,  ['mask_2'] = 0,
	-- 		['chain_1'] = 0,    ['chain_2'] = 0,
	-- 		['ears_1'] = 0,     ['ears_2'] = 0,
	-- 		['glasses_1'] = -1,     ['glasses'] = 0,
	-- 		['bproof_1'] = 0,     ['bproof_2'] = 0
	-- 	},
	-- },

	-- anwb_kleding_2 = {
	-- 	male = {
	-- 		['tshirt_1'] = 15,  ['tshirt_2'] = 0,
	-- 		['torso_1'] = 328,   ['torso_2'] = 0,
	-- 		['decals_1'] = 0,   ['decals_2'] = 0,
	-- 		['arms'] = 63,
	-- 		['pants_1'] = 120,   ['pants_2'] = 1,
	-- 		['shoes_1'] = 25,   ['shoes_2'] = 0,
	-- 		['helmet_1'] = -1,  ['helmet_2'] = 0,
	-- 		['chain_1'] = 0,    ['chain_2'] = 0,
	-- 		['bproof_1'] = 0,     ['bproof_2'] = 0,
	-- 		['mask_1'] = 121,  ['mask_2'] = 0
	-- 	},
	-- 	female = {
	-- 	},
	-- },

	anwb_kleding_3= {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 118,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 64,
			['pants_1'] = 33,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['bproof_1'] = 0,     ['bproof_2'] = 0,
			['mask_1'] = 121,  ['mask_2'] = 0
		},
		female = {
		},
	},

	-- anwb_kleding_4= {
	-- 	male = {
	-- 		['tshirt_1'] = 15,  ['tshirt_2'] = 0,
	-- 		['torso_1'] = 118,   ['torso_2'] = 0,
	-- 		['decals_1'] = 0,   ['decals_2'] = 0,
	-- 		['arms'] = 63,
	-- 		['pants_1'] = 31,   ['pants_2'] = 0,
	-- 		['shoes_1'] = 81,   ['shoes_2'] = 0,
	-- 		['helmet_1'] = -1,  ['helmet_2'] = 0,
	-- 		['chain_1'] = 0,    ['chain_2'] = 0,
	-- 		['bproof_1'] = 0,     ['bproof_2'] = 0,
	-- 		['mask_1'] = 121,  ['mask_2'] = 0
	-- 	},
	-- 	female = {
	-- 	},
	-- },
	
	anwb_pet = {
		male = {
			['helmet_1'] = 10,  ['helmet_2'] = 1

		},
		female = {
			['helmet_1'] = 58,  ['helmet_2'] = 0

		},
	},

	-- rijkswaterstaat_kleding = {
	-- 	male = {
	-- 		['tshirt_1'] = 15,  ['tshirt_2'] = 0,
	-- 		['torso_1'] = 118,   ['torso_2'] = 1,
	-- 		['decals_1'] = 0,   ['decals_2'] = 0,
	-- 		['arms'] = 64,
	-- 		['pants_1'] = 120,   ['pants_2'] = 1,
	-- 		['shoes_1'] = 25,   ['shoes_2'] = 0,
	-- 		['helmet_1'] = -1,  ['helmet_2'] = 0,
	-- 		['chain_1'] = 0,    ['chain_2'] = 0,
	-- 		['bproof_1'] = 13,     ['bproof_2'] = 0,
	-- 		['mask_1'] = 121,  ['mask_2'] = 0
	-- 	},
	-- 	female = {
	-- 		['tshirt_1'] = 15,  ['tshirt_2'] = 0,
	-- 		['torso_1'] = 110,   ['torso_2'] = 0,
	-- 		['decals_1'] = 0,   ['decals_2'] = 0,
	-- 		['arms'] = 49,
	-- 		['pants_1'] = 49,   ['pants_2'] = 1,
	-- 		['shoes_1'] = 25,   ['shoes_2'] = 0,
	-- 		['helmet_1'] = -1,  ['helmet_2'] = 0,
	-- 		['mask_1'] = 0,  ['mask_2'] = 0,
	-- 		['chain_1'] = 0,    ['chain_2'] = 0,
	-- 		['ears_1'] = 0,     ['ears_2'] = 0,
	-- 		['glasses_1'] = -1,     ['glasses'] = 0,
	-- 		['bproof_1'] = 0,     ['bproof_2'] = 0
	-- 	},
	-- },
	motor_wear = { 
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 156,   ['torso_2'] = 3,
			['decals_1'] = 1,   ['decals_2'] = 0,
			['arms'] = 96,
			['pants_1'] = 49,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['mask_1'] = 121,    ['mask_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['bags_1'] = -1,  ['bags_2'] = 0,
			['helmet_1'] = 17,  ['helmet_2'] = 2,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
		}
	}
}

Config.Towables = {
	vector3(-2480.9, -212.0, 17.4),
	vector3(-2723.4, 13.2, 15.1),
	vector3(-3169.6, 976.2, 15.0),
	vector3(-3139.8, 1078.7, 20.2),
	vector3(-1656.9, -246.2, 54.5),
	vector3(-1586.7, -647.6, 29.4),
	vector3(-1036.1, -491.1, 36.2),
	vector3(-1029.2, -475.5, 36.4),
	vector3(75.2, 164.9, 104.7),
	vector3(-534.6, -756.7, 31.6),
	vector3(487.2, -30.8, 88.9),
	vector3(-772.2, -1281.8, 4.6),
	vector3(-663.8, -1207.0, 10.2),
	vector3(719.1, -767.8, 24.9),
	vector3(-971.0, -2410.4, 13.3),
	vector3(-1067.5, -2571.4, 13.2),
	vector3(-619.2, -2207.3, 5.6),
	vector3(1192.1, -1336.9, 35.1),
	vector3(-432.8, -2166.1, 9.9),
	vector3(-451.8, -2269.3, 7.2),
	vector3(939.3, -2197.5, 30.5),
	vector3(-556.1, -1794.7, 22.0),
	vector3(591.7, -2628.2, 5.6),
	vector3(1654.5, -2535.8, 74.5),
	vector3(1642.6, -2413.3, 93.1),
	vector3(1371.3, -2549.5, 47.6),
	vector3(383.8, -1652.9, 37.3),
	vector3(27.2, -1030.9, 29.4),
	vector3(229.3, -365.9, 43.8),
	vector3(-85.8, -51.7, 61.1),
	vector3(-4.6, -670.3, 31.9),
	vector3(-111.9, 92.0, 71.1),
	vector3(-314.3, -698.2, 32.5),
	vector3(-366.9, 115.5, 65.6),
	vector3(-592.1, 138.2, 60.1),
	vector3(-1613.9, 18.8, 61.8),
	vector3(-1709.8, 55.1, 65.7),
	vector3(-521.9, -266.8, 34.9),
	vector3(-451.1, -333.5, 34.0),
	vector3(322.4, -1900.5, 25.8)
}

for k,v in ipairs(Config.Towables) do
	Config.Zones['Towable' .. k] = {
		Pos   = v,
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = -1
	}
end