Config = {}

-- # Locale to be used. You can create your own by simple copying the 'en' and translating the values.
Config.Locale       				= 'en' -- Traduções disponives en / br

-- # By how many services a player's community service gets extended if he tries to escape
Config.ServiceExtensionOnEscape		= 5

-- # Don't change this unless you know what you are doing.
Config.ServiceLocation 				= {x =  1092.45, y = 3587.7, z = 35.69}

-- # Don't change this unless you know what you are doing.
Config.ReleaseLocation				= {x = -1092.1256, y = -798.8120, z = 18.9600}

-- # Don't change this unless you know what you are doing.
Config.ServiceLocations = {
	{ type = "cleaning", coords = vector3(1088.2911, 3581.3188, 33.8700) },
	{ type = "cleaning", coords = vector3(1104.1832, 3582.5117, 31.9971) },
	{ type = "cleaning", coords = vector3(1107.8439, 3597.9983, 31.7236) },
	{ type = "cleaning", coords = vector3(1103.1758, 3611.4954, 33.1771) },
	{ type = "cleaning", coords = vector3(1083.6467, 3608.6707, 33.1878) },
	{ type = "cleaning", coords = vector3(1074.6056, 3595.3914, 31.7632) },
	{ type = "cleaning", coords = vector3(1069.6873, 3582.3765, 31.9728) },
	{ type = "cleaning", coords = vector3(1064.4438, 3574.7686, 33.441) },
	{ type = "gardening", coords = vector3(1074.1552, 3572.4309, 34.0250) },
	{ type = "gardening", coords = vector3(1086.2766, 3589.3984, 33.4360) },
	{ type = "gardening", coords = vector3(1118.4517, 3581.3247, 31.9752) },
	{ type = "gardening", coords = vector3(1130.9764, 3588.4109, 31.6801) },
	{ type = "gardening", coords = vector3(1135.7751, 3604.4104, 33.2148) }
}



Config.Uniforms = {
	prison_wear = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1']  = 56, ['torso_2']  = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms']     = 19,
			['pants_1']  = 42,  ['pants_2']  = 0,
			['shoes_1']  = 1,  ['shoes_2']  = 0,
			['chain_1']  = 0,
			['mask_1']  = 0,   ['mask_2']  = 0, 
			['chain_2']  = 0
		},
		female = {
			['tshirt_1'] = 3,   ['tshirt_2'] = 0,
			['torso_1']  = 38,  ['torso_2']  = 3,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms']     = 120,  ['pants_1'] = 3,
			['pants_2']  = 15,  ['shoes_1']  = 66,
			['shoes_2']  = 5,   ['chain_1']  = 0,
			['chain_2']  = 0
		}
	}
}
