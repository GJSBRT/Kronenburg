Config                            = {}

Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 1.0 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }

Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- enable if you're using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableLicenses             = true -- enable if you're using esx_license
Config.EnableSocietyOwnedVehicles = false

Config.EnableHandcuffTimer        = true -- enable handcuff timer? will unrestrain player after the time ends
Config.HandcuffTimer              = 10 * 60000 -- 10 mins

Config.MaxInService               = -1
Config.Locale                     = 'en'

Config.PoliceStations = {

	LSPD = {

		Blip = {
			Coords  = vector3(-1088.77, -832.19, 43.69),
			
			Sprite  = 60,
			Display = 4,
			Scale   = 0.9,
			Colour  = 29
		},

		Blip2 = {
			Coords  = vector3(1849.16, 3688.29, 33.27),
			
			Sprite  = 60,
			Display = 4,
			Scale   = 0.9,
			Colour  = 29
		},

		blip1 = {
			Coords  = vector3(-446.26, 6008.95, 31.72),
			
			Sprite  = 60,
			Display = 4,
			Scale   = 0.9,
			Colour  = 29
		},

		Cloakrooms = {
			vector3(-1097.78, -832.04, 14.28),
			vector3(1849.89, 3695.38, 34.26),
			vector3(-446.72, 6009.04, 31.72),
		},

		Cloakroomsdsi = {
			vector3(2474.04, -332.5, 92.99),
		},

		Armories = {
			vector3(-1106.35, -823.09, 14.28),
			vector3(2506.14, -324.41, 93.12),
			vector3(1842.58, 3691.55, 34.26),
			vector3(-437.96, 5988.62, 31.72),
		},

		Vehicles = {
			{
				Spawner = vector3(-1107.05, -838.58, 13.34),
				SpawnPoint = { x = -1113.89, y = -834.13, z = 13.34 },
				Heading    = 125.64,
			},

			{
				Spawner = vector3(-1086.04, -849.61, 4.88),
				SpawnPoint = { x = -1075.56, y = -847.62, z = 4.88 },
				Heading    = 219.08,
			},
			--Sandy
			{
				Spawner = vector3(1861.96, 3685.91, 34.27),
				SpawnPoint = { x = 1869.1, y = 3693.31, z = 33.16 },
				Heading    = 211.59,
			},
			--Paleto
			{
				Spawner = vector3(-458.65, 6017.09, 31.49),
				SpawnPoint = { x = -460.79, y = 6021.24, z = 31.34 },
				Heading    = 315.00,
			},
			--Dsi
			{
				Spawner = vector3(2500.44, -339.48, 93.21),
				SpawnPoint = { x = 2497.15, y = -336.39, z = 91.63 },
				Heading    = 359.81,
			},
			--Helicopter spawner
			{
				Spawner = vector3(-1091.47, -841.62, 37.70),
				SpawnPoint = { x = -1096.33, y = -832.40, z = 37.97 },
				Heading    = 309.04,
			},
			--Boten spawner
			{
				Spawner = vector3(-800.76, -1513.11, 1.60),
				SpawnPoint = { x = -802.2, y = -1521.97, z = 0.66 },
				Heading    = 120.0,
			},
		},

		VehicleDeleters = {
			{ x = -1113.03, y = -829.77, z = 12.34 },
			{ x = -1080.09, y = -844.28, z = 3.88 },
			{ x = 2501.92, y = -319.55, z = 91.67 },
			{ x = -781.02, y = -1511.50, z = -0.30 },
			{ x = -1096.33, y = -832.40, z = 36.70 }

		},

		BossActions = {
			vector3(-1113.3, -833.02, 34.36)
		},

	},

}

Config.AuthorizedWeapons = {
	aspirant = {
		{ weapon = 'WEAPON_FIREEXTINGUISHER', price = 0},
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
	},

	surveillant = {
		{ weapon = 'WEAPON_FIREEXTINGUISHER', price = 0},
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_PISTOL', price = 0 },
	},

	agent = {
		{ weapon = 'WEAPON_FIREEXTINGUISHER', price = 0},
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_PISTOL', price = 0 },
	},

	hoofdagent = {
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_COMBATPISTOL', price = 0 },
		{ weapon = 'WEAPON_PISTOL', price = 0 },
		{ weapon = 'WEAPON_SMG', price = 0, 0, 0 },
		{ weapon = 'WEAPON_SMG_MK2', components = { 0, 0, 0, 0, 0, 0, 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = {  0, 0, 0, 0, 0, 0 }, price = 0 },
                { weapon = 'WEAPON_CARBINERIFLE_MK2', components = { 0, 0, 0, 0, 0, 0, 0, 0 }, price = 0 },
	},

	brigadier = {
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_COMBATPISTOL', price = 0 },
		{ weapon = 'WEAPON_PISTOL', price = 0 },
		{ weapon = 'WEAPON_SMG', price = 0, 0, 0 },
		{ weapon = 'WEAPON_SMG_MK2', components = { 0, 0, 0, 0, 0, 0, 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = {  0, 0, 0, 0, 0, 0 }, price = 0 },
                { weapon = 'WEAPON_CARBINERIFLE_MK2', components = { 0, 0, 0, 0, 0, 0, 0, 0 }, price = 0 },
	},

	inspecteur = {
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_COMBATPISTOL', price = 0 },
		{ weapon = 'WEAPON_PISTOL', price = 0 },
		{ weapon = 'WEAPON_SMG', price = 0, 0, 0 },
		{ weapon = 'WEAPON_SMG_MK2', components = { 0, 0, 0, 0, 0, 0, 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = {  0, 0, 0, 0, 0, 0 }, price = 0 },
                { weapon = 'WEAPON_CARBINERIFLE_MK2', components = { 0, 0, 0, 0, 0, 0, 0, 0 }, price = 0 },
	},

	hoofdinspecteur = {
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_COMBATPISTOL', price = 0 },
		{ weapon = 'WEAPON_PISTOL', price = 0 },
		{ weapon = 'WEAPON_SMG', price = 0, 0, 0 },
		{ weapon = 'WEAPON_SMG_MK2', components = { 0, 0, 0, 0, 0, 0, 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = {  0, 0, 0, 0, 0, 0 }, price = 0 },
                { weapon = 'WEAPON_CARBINERIFLE_MK2', components = { 0, 0, 0, 0, 0, 0, 0, 0 }, price = 0 },
                { weapon = 'WEAPON_SNIPERRIFLE', components = { 0, 0, 0 }, price = 0 },

	},

	boss = {
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_COMBATPISTOL', price = 0 },
		{ weapon = 'WEAPON_PISTOL', price = 0 },
		{ weapon = 'WEAPON_SMG', price = 0, 0, 0 },
		{ weapon = 'WEAPON_SMG_MK2', components = { 0, 0, 0, 0, 0, 0, 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = {  0, 0, 0, 0, 0, 0 }, price = 0 },
                { weapon = 'WEAPON_CARBINERIFLE_MK2', components = { 0, 0, 0, 0, 0, 0, 0, 0 }, price = 0 },
                { weapon = 'WEAPON_SNIPERRIFLE', components = { 0, 0, 0 }, price = 0 },



	},

	kmarwerknemer = {
		{ weapon = 'WEAPON_FIREEXTINGUISHER', price = 0},
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_COMBATPISTOL', price = 0 },
		{ weapon = 'WEAPON_SMG', price = 0 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 0, 0, 0, 0, 0 }, price = 0 },
	},

	kmarbaas = {
		{ weapon = 'WEAPON_FIREEXTINGUISHER', price = 0},
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_COMBATPISTOL', price = 0 },
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_SMG', price = 0 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 0, 0, 0, 0, 0 }, price = 0 },
	},
}



-- https://wiki.fivem.net/wiki/Vehicles
Config.AuthorizedVehicles = {
	Shared = {
		{
			model = 'polfiets',
			label = 'Politie Fiets'
		},
		{
			model = 'poltouran2016',
			label = 'Volkswagen Touran'
		},
		{
			model = 'polmerc',
			label = 'Mercedes B-Klasse 2016'
		},
		{
			model = 'mercedesb',
			label = 'Mercedes B-Klasse 2019'
		},
		{
			model = 'polvito2016',
			label = 'Mercedes Vito'
		},
		{
			model = 'poltransporter6',
			label = 'Volkswagen T6'
		},
		{
			model = 'poltransporter5',
			label = 'Volkswagen T5'
		},
  	        {
			model = 'PolitieAtBus',
			label = 'Arrestanten vervoer'
		},
	},

	aspirant = {
		
	},

	surveillant = {
		
	},

	agent = {
		{
			model = 'polgolf7oov',
			label = 'Volkswagen Golf 7'
		},
		{
			model = 'polmotor',
			label = 'Zware Motor'
		},
		{
			model = 'babsamarok',
			label = 'Volkswagen Amarok'
		},
  	        {
			model = 'polbus3',
			label = 'ME bus'
		},
		{
			model = 'polmotor3',
			label = 'Lichte Motor'
		},
		{
			model = 'polaudi',
			label = 'Audi A6 2017'
		},
		{
			model = 'polaudi2',
			label = 'Audi A6 2022'
		},
	},

	hoofdagent = {
		{
			model = 'PolitieTouranK9',
			label = 'Volkswagen Touran K9'
		},
		{
			model = 'polgolf7oov',
			label = 'Volkswagen Golf 7'
		},
		{
			model = 'polaudi',
			label = 'Audi A6 2017'
		},
		{
			model = 'polaudi2',
			label = 'Audi A6 2022'
		},
		{
			model = 'polmotor',
			label = 'Zware Motor'
		},
		{
			model = 'polmotor3',
			label = 'Lichte Motor'
		},
		{
			model = 'basamarok',
			label = 'Volkswagen Amarok'
		},
		{
			model = 'polrs6',
			label = 'Audi Rs6 (Unmarked)'
		},
  	        {
			model = 'upolitiea4',
			label = 'Audi A4 (Unmarked/DSI)'
		}, 
		{
			model = 'polbmwx5v2',
			label = 'BMW X5 (DSI)'
		},
  	        {
			model = 'dsivito',
			label = 'Mercedes Vito Unmarked (DSI)'
		},
		{
			model = 'ov3',
			label = 'Audi Q7 (DSI)'
		},
                {
			model = 'dsiq5',
			label = 'Audi Q5 (DSI)'
		},
		{
			model = 'polmotorun',
			label = 'Unmarked motor'
		},
		{
			model = 'dsimerc',
			label = 'Politie E-klasse (DSI)'
		},
   	        {
			model = 'polbus3',
			label = 'ME bus'
		},
		{
			model = 'vwtouareg',
			label = 'Volkswagen Touareg (BE)'
		},
		{
			model = 'dinghy4',
			label = 'DSI Dinghy (Alleen spawnen bij water)'
		},
		{
			model = 'polmav',
			label = 'Zulu (Alleen spawnen op het dak)'
		},



	},

	brigadier = {
		{
			model = 'PolitieTouranK9',
			label = 'Volkswagen Touran K9'
		},
		{
			model = 'polgolf7oov',
			label = 'Volkswagen Golf 7'
		},
		{
			model = 'polaudi',
			label = 'Audi A6 2017'
		},
		{
			model = 'polaudi2',
			label = 'Audi A6 2022'
		},
		{
			model = 'babsamarok',
			label = 'Volkswagen Amarok'
		},
		{
			model = 'polmotor',
			label = 'Zware Motor'
		},
		{
			model = 'polmotor3',
			label = 'Lichte Motor'
		},
		{
			model = 'polrs6',
			label = 'Audi Rs6 (Unmarked)'
		},
  	        {
			model = 'upolitiea4',
			label = 'Audi A4 (Unmarked/DSI)'
		}, 
		{
			model = 'polbmwx5v2',
			label = 'BMW X5 (DSI)'
		},
  	        {
			model = 'dsivito',
			label = 'Mercedes Vito Unmarked (DSI)'
		},
		{
			model = 'ov3',
			label = 'Audi Q7 (DSI)'
		},
                {
			model = 'dsiq5',
			label = 'Audi Q5 (DSI)'
		},
		{
			model = 'polt6un',
			label = 'Volkswagen Multivan (DSI)'
		},
		{
			model = 'polmotorun',
			label = 'Unmarked motor'
		},
		{
			model = 'dsimerc',
			label = 'Politie E-klasse (DSI)'
		},
  	        {
			model = 'polbus3',
			label = 'ME bus'
		},
		{
			model = 'vwtouareg',
			label = 'Volkswagen Touareg (BE)'
		},
		{
			model = 'politiexc90',
			label = 'Volvo XC90'
		},
		{
			model = 'dinghy4',
			label = 'DSI Dinghy (Alleen spawnen bij water)'
		},
		{
			model = 'polmav',
			label = 'Zulu (Alleen spawnen op het dak)'
		},

	},

	inspecteur = {
		{
			model = 'PolitieTouranK9',
			label = 'Volkswagen Touran K9'
		},
		{
			model = 'polgolf7oov',
			label = 'Volkswagen Golf 7'
		},
		{
			model = 'polaudi',
			label = 'Audi A6 2017'
		},
		{
			model = 'polaudi2',
			label = 'Audi A6 2022'
		},
		{
			model = 'babsamarok',
			label = 'Volkswagen Amarok'
		},
		{
			model = 'polmotor',
			label = 'Zware Motor'
		},
		{
			model = 'polmotor3',
			label = 'Lichte Motor'
		},
		{
			model = 'polrs6',
			label = 'Audi Rs6 (Unmarked)'
		},
  	        {
			model = 'upolitiea4',
			label = 'Audi A4 (Unmarked/DSI)'
		}, 
		{
			model = 'polbmwx5v2',
			label = 'BMW X5 (DSI)'
		},
                {
			model = 'dsiq5',
			label = 'Audi Q5 (DSI)'
		},
  	        {
			model = 'dsivito',
			label = 'Mercedes Vito Unmarked (DSI)'
		},
		{
			model = 'ov3',
			label = 'Audi Q7 (DSI)'
		},
		{
			model = 'polt6un',
			label = 'Volkswagen Multivan (DSI)'
		},
		{
			model = 'polmotorun',
			label = 'Unmarked motor'
		},
		{
			model = 'dsimerc',
			label = 'Politie E-klasse (DSI)'
		},
  	        {
			model = 'polbus3',
			label = 'ME bus'
		},
		{
			model = 'vwtouareg',
			label = 'Volkswagen Touareg (BE)'
		},
		{
			model = 'politiexc90',
			label = 'Volvo XC90'
		},
		{
			model = 'dinghy4',
			label = 'DSI Dinghy (Alleen spawnen bij water)'
		},
		{
			model = 'polmav',
			label = 'Zulu (Alleen spawnen op het dak)'
		},

	},

	hoofdinspecteur = {
		{
			model = 'PolitieTouranK9',
			label = 'Volkswagen Touran K9'
		},
		{
			model = 'polgolf7oov',
			label = 'Volkswagen Golf 7'
		},
		{
			model = 'polaudi',
			label = 'Audi A6 2017'
		},
		{
			model = 'polaudi2',
			label = 'Audi A6 2022'
		},
		{
			model = 'babsamarok',
			label = 'Volkswagen Amarok'
		},
		{
			model = 'polmotor',
			label = 'Zware Motor'
		},
		{
			model = 'polmotor3',
			label = 'Lichte Motor'
		},
		{
			model = 'polrs6',
			label = 'Audi Rs6 (Unmarked)'
		},
                {
			model = 'dsiq5',
			label = 'Audi Q5 (DSI)'
		},
		{
			model = 'polbmwx5v2',
			label = 'BMW X5 (DSI)'
		},
  	{
			model = 'dsivito',
			label = 'Mercedes Vito Unmarked (DSI)'
		},
		{
			model = 'ov3',
			label = 'Audi Q7 (DSI)'
		},
		{
			model = 'polmotorun',
			label = 'Unmarked motor'
		},
		{
			model = 'polt6un',
			label = 'Volkswagen Multivan (DSI)'
		},
   	{
			model = 'polbus3',
			label = 'ME bus'
		},
		{
			model = 'dsimerc',
			label = 'Politie E-klasse (DSI)'
		},
  	{
			model = 'upolitiea4',
			label = 'Audi A4 (Unmarked/DSI)'
		}, 
		{
			model = 'vwtouareg',
			label = 'Volkswagen Touareg (BE)'
		},
		{
			model = 'politiexc90',
			label = 'Volvo XC90'
		},
		{
			model = 'dinghy4',
			label = 'DSI Dinghy (Alleen spawnen bij water)'
		},
		{
			model = 'polmav',
			label = 'Zulu (Alleen spawnen op het dak)'
		},

	},

	boss = {
		{
			model = 'politie29',
			label = 'Volkswagen Touran Hondengeleider'
		},
		{
			model = 'polgolf7oov',
			label = 'Volkswagen Golf 7'
		},
		{
			model = 'polaudi',
			label = 'Audi A6 2017'
		},
		{
			model = 'polaudi2',
			label = 'Audi A6 2022'
		},
		{
			model = 'babsamarok',
			label = 'Volkswagen Amarok'
		},
		{
			model = 'polmotor',
			label = 'Zware Motor'
		},
  	        {
			model = 'upolitiea4',
			label = 'Audi A4 (Unmarked/DSI)'
		},    
		{
			model = 'polmotor3',
			label = 'Lichte Motor'
		},			
		{
			model = 'polx5',
			label = 'BMW X5 (DSI)'
		},
                {
			model = 'dsiq5',
			label = 'Audi Q5 (DSI)'
		},
		{
			model = 'polmotorun',
			label = 'Unmarked motor'
		},
		{
			model = 'ov3',
			label = 'Audi Q7 (DSI)'
		},
		{
			model = 'polt6un',
			label = 'Volkswagen Multivan (DSI)'
		},
		{
			model = 'dsimerc',
			label = 'Politie E-klasse (DSI)'
		},
  	        {
			model = 'dsivito',
			label = 'Mercedes Vito Unmarked (DSI)'
		},
  	        {
			model = 'polbus3',
			label = 'ME bus'
		},
		{
			model = 'vwtouareg',
			label = 'Volkswagen Touareg (BE)'
		},
		{
			model = 'politiexc90',
			label = 'Volvo XC90'
		},
		{
			model = 'dinghy4',
			label = 'DSI Dinghy (Alleen spawnen bij water)'
		},
		{
			model = 'polmav',
			label = 'Zulu (Alleen spawnen op het dak)'
		},

	},
	kmarwerknemer = {
		{
			model = 'PolitieTouranK9',
			label = 'Volkswagen Touran K9'
		},
		{
			model = 'polgolf7oov',
			label = 'Volkswagen Golf 7'
		},
		{
			model = 'polaudi',
			label = 'Audi A6'
		},
		{
			model = 'polmotor',
			label = 'Zware Motor'
		},
		{
			model = 'polmotor3',
			label = 'Lichte Motor'
		},
		{
			model = 'polrs6',
			label = 'Audi Rs6 (Unmarked)'
		},
		{
			model = 'polbmwx5v2',
			label = 'BMW X5 (DSI)'
		},
		{
			model = 'ov3',
			label = 'Audi Q7 (DSI)'
		},
		{
			model = 'polt6un',
			label = 'Volkswagen Multivan (DSI)'
		},
		{
			model = 'dsimerc',
			label = 'Politie E-klasse (DSI)'
		},
		{
			model = 'dinghy4',
			label = 'DSI Dinghy (Alleen spawnen bij water)'
		},
		{
			model = 'poljeep',
			label = 'Jeep Grand Cherokee Trackhawk (Speciaal voor Lars)'
		},
		{
			model = 'polmav',
			label = 'Zulu (Alleen spawnen op het dak)'
		},

	},

	kmarbaas = {
		{
			model = 'PolitieTouranK9',
			label = 'Volkswagen Touran K9'
		},
		{
			model = 'polgolf7oov',
			label = 'Volkswagen Golf 7'
		},
		{
			model = 'polaudi',
			label = 'Audi A6'
		},
		{
			model = 'polmotor',
			label = 'Zware Motor'
		},
		{
			model = 'polmotor3',
			label = 'Lichte Motor'
		},
		{
			model = 'polrs6',
			label = 'Audi Rs6 (Unmarked)'
		},
		{
			model = 'polbmwx5v2',
			label = 'BMW X5 (DSI)'
		},
		{
			model = 'ov3',
			label = 'Audi Q7 (DSI)'
		},
		{
			model = 'polt6un',
			label = 'Volkswagen Multivan (DSI)'
		},
		{
			model = 'dsimerc',
			label = 'Politie E-klasse (DSI)'
		},
		{
			model = 'dinghy4',
			label = 'DSI Dinghy (Alleen spawnen bij water)'
		},
		{
			model = 'poljeep',
			label = 'Jeep Grand Cherokee Trackhawk (Speciaal voor Lars)'
		},
		{
			model = 'polmav',
			label = 'Zulu (Alleen spawnen op het dak)'
		},

	}
}


-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {
	aspnhkort_wear = {  
		male = {
			['tshirt_1'] = 48,  ['tshirt_2'] = 0,
			['torso_1'] = 1,   ['torso_2'] = 0,
			['decals_1'] = 1,   ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 59,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['mask_1'] = 11,    ['mask_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['bags_1'] = -1,  ['bags_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
		},
		female = {
			['tshirt_1'] = 2,  ['tshirt_2'] = 0,
			['torso_1'] = 85,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 33,
			['pants_1'] = 32,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['mask_1'] = 11,    ['mask_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['bags_1'] = -1,  ['bags_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
		},
	},
	casino_wear = {  
		male = {
			['tshirt_1'] = 48,  ['tshirt_2'] = 0,
			['torso_1'] = 150,   ['torso_2'] = 0,
			['decals_1'] = 2,   ['decals_2'] = 0,
			['arms'] = 42,
			['pants_1'] = 59,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['mask_1'] = 0,    ['mask_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['bags_1'] = -1,  ['bags_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 1,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
		},
		female = {
			['tshirt_1'] = 2,  ['tshirt_2'] = 0,
			['torso_1'] = 85,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 33,
			['pants_1'] = 32,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['mask_1'] = 11,    ['mask_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['bags_1'] = -1,  ['bags_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
		},
	},
    aspnhlang_wear = {
		male = {    
			['tshirt_1'] = 48,  ['tshirt_2'] = 0,
			['torso_1'] = 200,   ['torso_2'] = 0,
			['decals_1'] = 1,   ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 59,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['mask_1'] = 11,    ['mask_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['bags_1'] = -1,  ['bags_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
		},
		female = {
			['tshirt_1'] = 2,  ['tshirt_2'] = 0,
			['torso_1'] = 85,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 33,
			['pants_1'] = 32,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['mask_1'] = 11,    ['mask_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['bags_1'] = -1,  ['bags_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
		},
	},
	nhkort_wear = { 
		male = {
			['tshirt_1'] = 48,  ['tshirt_2'] = 0,
			['torso_1'] = 1,   ['torso_2'] = 0,
			['decals_1'] = 1,   ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 59,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['mask_1'] = 11,    ['mask_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['bags_1'] = -1,  ['bags_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
		},
		female = {
			['tshirt_1'] = 2,  ['tshirt_2'] = 0,
			['torso_1'] = 85,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 33,
			['pants_1'] = 32,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['mask_1'] = 11,    ['mask_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['bags_1'] = -1,  ['bags_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
		},
	},
	nhlang_wear = {  
		male = {
			['tshirt_1'] = 48,  ['tshirt_2'] = 0,
			['torso_1'] = 200,   ['torso_2'] = 0,
			['decals_1'] = 1,   ['decals_2'] = 0,
			['arms'] = 42,
			['pants_1'] = 59,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['mask_1'] = 11,    ['mask_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['bags_1'] = -1,  ['bags_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
		},
		female = {
			['tshirt_1'] = 2,  ['tshirt_2'] = 0,
			['torso_1'] = 85,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 33,
			['pants_1'] = 32,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['mask_1'] = 11,    ['mask_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['bags_1'] = -1,  ['bags_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
		},
	},
    
	intendent_wear = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 94,   ['torso_2'] = 0,
			['decals_1'] = 1,   ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 46,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['mask_1'] = 11,    ['mask_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['bags_1'] = -1,  ['bags_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
		},
		female = {
			['tshirt_1'] = 2,  ['tshirt_2'] = 0,
			['torso_1'] = 85,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 33,
			['pants_1'] = 32,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['mask_1'] = 11,    ['mask_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['bags_1'] = -1,  ['bags_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
		},
	},
	lieutenant_wear = { -- currently the same as intendent_wear
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 94,   ['torso_2'] = 0,
			['decals_1'] = 1,   ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 46,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['mask_1'] = 11,    ['mask_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['bags_1'] = -1,  ['bags_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
		},
		female = {
			['tshirt_1'] = 2,  ['tshirt_2'] = 0,
			['torso_1'] = 85,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 33,
			['pants_1'] = 32,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['mask_1'] = 11,    ['mask_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['bags_1'] = -1,  ['bags_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
		},
	},
	chef_wear = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 94,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 47,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['mask_1'] = 11,    ['mask_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['bags_1'] = -1,  ['bags_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
		},
		female = {
			['tshirt_1'] = 2,  ['tshirt_2'] = 0,
			['torso_1'] = 85,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 33,
			['pants_1'] = 32,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['mask_1'] = 11,    ['mask_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['bags_1'] = -1,  ['bags_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
		},
	},
	undercover_wear = { -- currently the same as chef_wear
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 156,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 47,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['mask_1'] = 11,     ['mask_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['bags_1'] = -1,  ['bags_2'] = 0,
		},
		--[[
		female = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 156,   ['torso_2'] = 0,
			['decals_1'] = 1,   ['decals_2'] = 0,
			['arms'] = 4,
			['pants_1'] = 33,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 5,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['mask_1'] = 121,     ['mask_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['bags_1'] = -1,  ['bags_2'] = 0,
		}]]
	},
	aot_wear = { -- AOT
	male = {
		['tshirt_1'] = 61,  ['tshirt_2'] = 2,
		['torso_1'] = 88,   ['torso_2'] = 2,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['arms'] = 47,
		['arms_2'] = 0,
		['pants_1'] = 26,   ['pants_2'] = 6,
	        ['shoes_1'] = 17,   ['shoes_2'] = 0,
		['helmet_1'] = 2,  ['helmet_2'] = 1,
		['chain_1'] = 1,    ['chain_2'] = 0,
		['ears_1'] = -1,     ['ears_2'] = 0,
		['mask_1'] = 52,     ['mask_2'] = 0,
		['bproof_1'] = 5,  ['bproof_2'] = 0,
		['bags_1'] = -1,  ['bags_2'] = 0,
	},
	--[[
	female = {
		['tshirt_1'] = 58,  ['tshirt_2'] = 0,
		['torso_1'] = 156,   ['torso_2'] = 0,
		['decals_1'] = 1,   ['decals_2'] = 0,
		['arms'] = 4,
		['pants_1'] = 33,   ['pants_2'] = 0,
		['shoes_1'] = 25,   ['shoes_2'] = 0,
		['helmet_1'] = -1,  ['helmet_2'] = 0,
		['chain_1'] = 5,    ['chain_2'] = 0,
		['ears_1'] = -1,     ['ears_2'] = 0,
		['mask_1'] = 121,     ['mask_2'] = 0,
		['bproof_1'] = 0,  ['bproof_2'] = 0,
		['bags_1'] = -1,  ['bags_2'] = 0,
	}]]
	},
	dsizwaar_wear = { -- DSI Zwaar
	male = {
		['tshirt_1'] = 61,  ['tshirt_2'] = 0,
		['torso_1'] = 155,   ['torso_2'] = 3,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['arms'] = 42,
		['pants_1'] = 26,   ['pants_2'] = 4,
	        ['shoes_1'] = 59,   ['shoes_2'] = 14,
		['helmet_1'] = 13,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 0,
		['ears_1'] = -1,     ['ears_2'] = 0,
		['mask_1'] = 52,     ['mask_2'] = 1,
		['bproof_1'] = 16,  ['bproof_2'] = 0,
		['bags_1'] = -1,  ['bags_2'] = 0,
	},
	--[[
	female = {
		['tshirt_1'] = 58,  ['tshirt_2'] = 0,
		['torso_1'] = 156,   ['torso_2'] = 0,
		['decals_1'] = 1,   ['decals_2'] = 0,
		['arms'] = 4,
		['pants_1'] = 33,   ['pants_2'] = 0,
		['shoes_1'] = 25,   ['shoes_2'] = 0,
		['helmet_1'] = -1,  ['helmet_2'] = 0,
		['chain_1'] = 5,    ['chain_2'] = 0,
		['ears_1'] = -1,     ['ears_2'] = 0,
		['mask_1'] = 121,     ['mask_2'] = 0,
		['bproof_1'] = 0,  ['bproof_2'] = 0,
		['bags_1'] = -1,  ['bags_2'] = 0,
	}]]
},
justitie_wear = { -- DSI Zwaar
male = {
	['tshirt_1'] = 61, ['tshirt_2'] = 2,
	['torso_1'] = 111, ['torso_2'] = 3,
	['decals_1'] = 0, ['decals_2'] = 0,
	['arms'] = 42,
	['pants_1'] = 26, ['pants_2'] = 4,
	['shoes_1'] = 102, ['shoes_2'] = 5,
	['mask_1'] = 52, ['mask_2'] = 0,
	['chain_1'] = 1, ['chain_2'] = 0,
	['helmet_1'] = 18, ['helmet_2'] = 0,
	['bproof_1'] = 21, ['bproof_2'] = 5,
	['bags_1'] = 0, ['bags_2'] = 0,
},
--[[
female = {
	['tshirt_1'] = 58,  ['tshirt_2'] = 0,
	['torso_1'] = 156,   ['torso_2'] = 0,
	['decals_1'] = 1,   ['decals_2'] = 0,
	['arms'] = 4,
	['pants_1'] = 33,   ['pants_2'] = 0,
	['shoes_1'] = 25,   ['shoes_2'] = 0,
	['helmet_1'] = -1,  ['helmet_2'] = 0,
	['chain_1'] = 5,    ['chain_2'] = 0,
	['ears_1'] = -1,     ['ears_2'] = 0,
	['mask_1'] = 121,     ['mask_2'] = 0,
	['bproof_1'] = 0,  ['bproof_2'] = 0,
	['bags_1'] = -1,  ['bags_2'] = 0,
}]]
},
undercover_wear = { -- DSI Zwaar
male = {
	['tshirt_1'] = 48, ['tshirt_2'] = 0,
	['torso_1'] = 111, ['torso_2'] = 1,
	['decals_1'] = 2, ['decals_2'] = 0,
	['arms'] = 46,
	['pants_1'] = 1, ['pants_2'] = 0,
	['shoes_1'] = 25, ['shoes_2'] = 0,
	['mask_1'] = 0, ['mask_2'] = 0,
	['helmet_1'] = -1, ['helmet_2'] = 0,
	['chain_1'] = 1, ['chain_2'] = 0,
	['bproof_1'] = 15, ['bproof_2'] = 1,
	['bags_1'] = 0, ['bags_2'] = 0,
},
--[[
female = {
	['tshirt_1'] = 58,  ['tshirt_2'] = 0,
	['torso_1'] = 156,   ['torso_2'] = 0,
	['decals_1'] = 1,   ['decals_2'] = 0,
	['arms'] = 4,
	['pants_1'] = 33,   ['pants_2'] = 0,
	['shoes_1'] = 25,   ['shoes_2'] = 0,
	['helmet_1'] = -1,  ['helmet_2'] = 0,
	['chain_1'] = 5,    ['chain_2'] = 0,
	['ears_1'] = -1,     ['ears_2'] = 0,
	['mask_1'] = 121,     ['mask_2'] = 0,
	['bproof_1'] = 0,  ['bproof_2'] = 0,
	['bags_1'] = -1,  ['bags_2'] = 0,
}]]
},
dsimiddel_wear = { -- DSI Middel
male = {
	['tshirt_1'] = 61,  ['tshirt_2'] = 0,
	['torso_1'] = 213,   ['torso_2'] = 2,
	['decals_1'] = 0,   ['decals_2'] = 0,
	['arms'] = 46,
	['arms_2'] = 1,
	['pants_1'] = 26,   ['pants_2'] = 6,
	['shoes_1'] = 17,   ['shoes_2'] = 0,
	['helmet_1'] = 13,  ['helmet_2'] = 0,
	['chain_1'] = 1,    ['chain_2'] = 0,
	['ears_1'] = -1,     ['ears_2'] = 0,
	['mask_1'] = 52,     ['mask_2'] = 1,
	['bproof_1'] = 19,  ['bproof_2'] = 0,
	['bags_1'] = -1,  ['bags_2'] = 0,
},
--[[
female = {
	['tshirt_1'] = 58,  ['tshirt_2'] = 0,
	['torso_1'] = 156,   ['torso_2'] = 0,
	['decals_1'] = 1,   ['decals_2'] = 0,
	['arms'] = 4,
	['pants_1'] = 33,   ['pants_2'] = 0,
	['shoes_1'] = 25,   ['shoes_2'] = 0,
	['helmet_1'] = -1,  ['helmet_2'] = 0,
	['chain_1'] = 5,    ['chain_2'] = 0,
	['ears_1'] = -1,     ['ears_2'] = 0,
	['mask_1'] = 121,     ['mask_2'] = 0,
	['bproof_1'] = 0,  ['bproof_2'] = 0,
	['bags_1'] = -1,  ['bags_2'] = 0,
}]]
},
dsilicht_wear = { -- DSI Licht
male = {
	['tshirt_1'] = 61,  ['tshirt_2'] = 0,
	['torso_1'] = 88,   ['torso_2'] = 0,
	['decals_1'] = 0,   ['decals_2'] = 0,
	['arms'] = 47,
	['arms_2'] = 1,
	['pants_1'] = 26,   ['pants_2'] = 6,
	['shoes_1'] = 17,   ['shoes_2'] = 0,
	['helmet_1'] = 119,  ['helmet_2'] = 1,
	['chain_1'] = 1,    ['chain_2'] = 0,
	['ears_1'] = -1,     ['ears_2'] = 0,
	['mask_1'] = 52,     ['mask_2'] = 1,
	['bproof_1'] = 25,  ['bproof_2'] = 1,
	['bags_1'] = -1,  ['bags_2'] = 0,
},
--[[
female = {
	['tshirt_1'] = 58,  ['tshirt_2'] = 0,
	['torso_1'] = 156,   ['torso_2'] = 0,
	['decals_1'] = 1,   ['decals_2'] = 0,
	['arms'] = 4,
	['pants_1'] = 33,   ['pants_2'] = 0,
	['shoes_1'] = 25,   ['shoes_2'] = 0,
	['helmet_1'] = -1,  ['helmet_2'] = 0,
	['chain_1'] = 5,    ['chain_2'] = 0,
	['ears_1'] = -1,     ['ears_2'] = 0,
	['mask_1'] = 121,     ['mask_2'] = 0,
	['bproof_1'] = 0,  ['bproof_2'] = 0,
	['bags_1'] = -1,  ['bags_2'] = 0,
}]]
},
	undercoverkort_wear = { -- currently the same as chef_wear
	male = {
		['tshirt_1'] = 58,  ['tshirt_2'] = 0,
		['torso_1'] = 93,   ['torso_2'] = 1,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['arms'] = 41,
		['pants_1'] = 47,   ['pants_2'] = 0,
		['shoes_1'] = 25,   ['shoes_2'] = 0,
		['helmet_1'] = -1,  ['helmet_2'] = 0,
		['chain_1'] = 8,    ['chain_2'] = 0,
		['ears_1'] = -1,     ['ears_2'] = 0,
		['mask_1'] = 11,     ['mask_2'] = 0,
		['bproof_1'] = 0,  ['bproof_2'] = 0,
		['bags_1'] = -1,  ['bags_2'] = 0,
	},
	--[[
	female = {
		['tshirt_1'] = 58,  ['tshirt_2'] = 0,
		['torso_1'] = 156,   ['torso_2'] = 0,
		['decals_1'] = 1,   ['decals_2'] = 0,
		['arms'] = 4,
		['pants_1'] = 33,   ['pants_2'] = 0,
		['shoes_1'] = 25,   ['shoes_2'] = 0,
		['helmet_1'] = -1,  ['helmet_2'] = 0,
		['chain_1'] = 5,    ['chain_2'] = 0,
		['ears_1'] = -1,     ['ears_2'] = 0,
		['mask_1'] = 121,     ['mask_2'] = 0,
		['bproof_1'] = 0,  ['bproof_2'] = 0,
		['bags_1'] = -1,  ['bags_2'] = 0,
	}]]
},
bewakingseenheid_wear = { -- BE
male = {
	['tshirt_1'] = 67,  ['tshirt_2'] = 0,
	['torso_1'] = 156,   ['torso_2'] = 1,
	['decals_1'] = 3,   ['decals_2'] = 0,
	['arms'] = 44,
	['pants_1'] = 47,   ['pants_2'] = 0,
	['shoes_1'] = 25,   ['shoes_2'] = 0,
	['helmet_1'] = 91,  ['helmet_2'] = 10,
	['chain_1'] = 43,    ['chain_2'] = 0,
	['ears_1'] = -1,     ['ears_2'] = 0,
	['mask_1'] = 52,     ['mask_2'] = 0,
	['bproof_1'] = 12,  ['bproof_2'] = 2,
	['bags_1'] = -1,  ['bags_2'] = 0,
},
--[[
female = {
	['tshirt_1'] = 58,  ['tshirt_2'] = 0,
	['torso_1'] = 156,   ['torso_2'] = 0,
	['decals_1'] = 1,   ['decals_2'] = 0,
	['arms'] = 4,
	['pants_1'] = 33,   ['pants_2'] = 0,
	['shoes_1'] = 25,   ['shoes_2'] = 0,
	['helmet_1'] = -1,  ['helmet_2'] = 0,
	['chain_1'] = 5,    ['chain_2'] = 0,
	['ears_1'] = -1,     ['ears_2'] = 0,
	['mask_1'] = 121,     ['mask_2'] = 0,
	['bproof_1'] = 0,  ['bproof_2'] = 0,
	['bags_1'] = -1,  ['bags_2'] = 0,
}]]
},
	hond_wear1 = { -- Hond geleider 1
	male = {
		['tshirt_1'] = 58,  ['tshirt_2'] = 0,
		['torso_1'] = 94,   ['torso_2'] = 0,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['arms'] = 41,
		['pants_1'] = 47,   ['pants_2'] = 0,
		['shoes_1'] = 25,   ['shoes_2'] = 0,
		['helmet_1'] = -1,  ['helmet_2'] = 0,
		['chain_1'] = 8,    ['chain_2'] = 0,
		['ears_1'] = -1,     ['ears_2'] = 0,
		['mask_1'] = 11,     ['mask_2'] = 0,
		['bproof_1'] = 0,  ['bproof_2'] = 0,
		['bags_1'] = -1,  ['bags_2'] = 0,
	},
	--[[
	female = {
		['tshirt_1'] = 58,  ['tshirt_2'] = 0,
		['torso_1'] = 156,   ['torso_2'] = 0,
		['decals_1'] = 1,   ['decals_2'] = 0,
		['arms'] = 4,
		['pants_1'] = 33,   ['pants_2'] = 0,
		['shoes_1'] = 25,   ['shoes_2'] = 0,
		['helmet_1'] = -1,  ['helmet_2'] = 0,
		['chain_1'] = 5,    ['chain_2'] = 0,
		['ears_1'] = -1,     ['ears_2'] = 0,
		['mask_1'] = 121,     ['mask_2'] = 0,
		['bproof_1'] = 0,  ['bproof_2'] = 0,
		['bags_1'] = -1,  ['bags_2'] = 0,
	}]]
},
hond_wear2 = { -- Hond geleider 2
male = {
	['tshirt_1'] = 58,  ['tshirt_2'] = 0,
	['torso_1'] = 31,   ['torso_2'] = 3,
	['decals_1'] = 0,   ['decals_2'] = 0,
	['arms'] = 41,
	['pants_1'] = 47,   ['pants_2'] = 0,
	['shoes_1'] = 25,   ['shoes_2'] = 0,
	['helmet_1'] = -1,  ['helmet_2'] = 0,
	['chain_1'] = 8,    ['chain_2'] = 0,
	['ears_1'] = -1,     ['ears_2'] = 0,
	['mask_1'] = 11,     ['mask_2'] = 0,
	['bproof_1'] = 0,  ['bproof_2'] = 0,
	['bags_1'] = -1,  ['bags_2'] = 0,
},
--[[
female = {
	['tshirt_1'] = 58,  ['tshirt_2'] = 0,
	['torso_1'] = 156,   ['torso_2'] = 0,
	['decals_1'] = 1,   ['decals_2'] = 0,
	['arms'] = 4,
	['pants_1'] = 33,   ['pants_2'] = 0,
	['shoes_1'] = 25,   ['shoes_2'] = 0,
	['helmet_1'] = -1,  ['helmet_2'] = 0,
	['chain_1'] = 5,    ['chain_2'] = 0,
	['ears_1'] = -1,     ['ears_2'] = 0,
	['mask_1'] = 121,     ['mask_2'] = 0,
	['bproof_1'] = 0,  ['bproof_2'] = 0,
	['bags_1'] = -1,  ['bags_2'] = 0,
}]]
},
	lang_wear = { -- currently the same as chef_wear
		male = {
			['tshirt_1'] = 48,  ['tshirt_2'] = 0,
			['torso_1'] = 200,   ['torso_2'] = 0,
			['decals_1'] = 1,   ['decals_2'] = 0,
			['arms'] = 42,
			['pants_1'] = 59,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['mask_1'] = 11,    ['mask_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['bags_1'] = -1,  ['bags_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
		},
		--[[
		female = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 156,   ['torso_2'] = 0,
			['decals_1'] = 1,   ['decals_2'] = 0,
			['arms'] = 4,
			['pants_1'] = 33,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 5,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['mask_1'] = 121,     ['mask_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['bags_1'] = -1,  ['bags_2'] = 0,
		}
		]]
	},
	bullet_wear = {
		male = {
			['decals_1'] = 5,  ['decals_2'] = 0,	
		},
		female = {
			['decals_1'] = 5,  ['decals_2'] = 0,
		}
	},
    holster_tas = {
		male = {
			['chain_1'] = 10,  ['chain_2'] = 0,
		},
		female = {
			['chain_1'] = 10,  ['chain_2'] = 0,
		}
	},
    taser = {
		male = {
			['bags_1'] = 2,  ['bags_2'] = 0,
		},
		female = {
			['bags_1'] = 2,  ['bags_2'] = 0,
		}
	},
    dsitas = {
		male = {
			['bags_1'] = 52,  ['bags_2'] = 0,
		},
		female = {
			['bags_1'] = 52,  ['bags_2'] = 0,
		}
	},

	kogelwerendweg_wear = {
		male = {
			['decals_1'] = 1,  ['decals_2'] = 0,
		},
		female = {
			['decals_1'] = 1,  ['decals_2'] = 0,
		}
	},
	gilet_wear = {
		male = {
            ['decals_1'] = 8,  ['decals_2'] = 3,	
		},
		female = {
			['decals_1'] = 8,  ['decals_2'] = 3,	
		}
	},
	pet_wear = {
		male = {
			['helmet_1'] = 10,  ['helmet_2'] = 0,
		},
		--[[
		female = {
			['helmet_1'] = 10,  ['helmet_2'] = 0,

		}]]
	},
	politievest_wear = {
		male = {
			['bproof_1'] = 7,  ['bproof_2'] = 0,
		},
		female = {
			['bproof_1'] = 6,  ['bproof_2'] = 2,
		}
	},
    vpvest_wear = {
		male = {
			['bproof_1'] = 1,  ['bproof_2'] = 2,
		},
		female = {
			['bproof_1'] = 1,  ['bproof_2'] = 2,
		}
	},
	undercovervest_wear = {
		male = {
			['bproof_1'] = 17,  ['bproof_2'] = 1,
		},
		--[[
		female = {
			['bproof_1'] = 6,  ['bproof_2'] = 2,
		}]]
	},
	wijkagentvest_wear = {
		male = {
			['bproof_1'] = 17,  ['bproof_2'] = 2,
		},
		--[[
		female = {
			['bproof_1'] = 6,  ['bproof_2'] = 2,
		}]]
	},
	hondengeleidervest_wear = {
		male = {
			['bproof_1'] = 1,  ['bproof_2'] = 3,
		},
		--[[
		female = {
			['bproof_1'] = 6,  ['bproof_2'] = 2,
		}]]
	},
	veiligheidshesje_wear = {
		male = {
			['decals_1'] = 8,  ['decals_2'] = 2,
		},
		--[[
		female = {
			['bproof_1'] = 6,  ['bproof_2'] = 2,
		}]]
	},
	atvest_wear = {
		male = {
			['bproof_1'] = 7,  ['bproof_2'] = 0,
		},
		female = {
			['bproof_1'] = 7,  ['bproof_2'] = 0,
		}
	},
	traffic_wear = {
		male = {
			['bproof_1'] = 1,  ['bproof_2'] = 0,
		},
		female = {
			['bproof_1'] = 1,  ['bproof_2'] = 0,
		}
	},
	at_wear = {
		male = {
			['tshirt_1'] = 44,  ['tshirt_2'] = 0,
			['torso_1'] = 186,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 17,   ['arms_1'] = 2,
			['pants_1'] = 4,   ['pants_2'] = 2,
			['helmet_1'] = 13,  ['helmet_2'] = 0,
			['chain_1'] = 43,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['mask_1'] = 52,     ['mask_2'] = 1,
			['bags_1'] = -1,     ['bags_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
		},
		--[[
		female = {
			['tshirt_1'] = 122,  ['tshirt_2'] = 0,
			['torso_1'] = 53,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 17,
			['pants_1'] = 4,   ['pants_2'] = 4,
			['shoes_1'] = 7,   ['shoes_2'] = 0,
			['helmet_1'] = 126,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['mask_1'] = 56,     ['mask_2'] = 1,
			['bags_1'] = -1,     ['bags_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
		}]]
	},
	motor_wear = {
		male = {
			['tshirt_1'] = 48,  ['tshirt_2'] = 0,
			['torso_1'] = 219,   ['torso_2'] = 4,
			['decals_1'] = 1,   ['decals_2'] = 0,
			['arms'] = 17,
			['pants_1'] = 32,   ['pants_2'] = 1,
			['shoes_1'] = 13,   ['shoes_2'] = 0,
			['mask_1'] = 11,    ['mask_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['bags_1'] = -1,  ['bags_2'] = 0,
			['helmet_1'] = 17,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
		},
		--[[
		female = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 156,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 32,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 17,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['mask_1'] = 121,     ['mask_2'] = 0,
			['bags_1'] = -1,  ['bags_2'] = 0,
		}]]
	},
	be_wear = {
		male = {
            ['tshirt_1'] = 38,  ['tshirt_2'] = 0,
            ['torso_1'] = 200,   ['torso_2'] = 0,
	    ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 17,
            ['pants_1'] = 46,  ['pants_2'] = 0,
            ['shoes_1'] = 24,   ['shoes_2'] = 0,
            ['mask_1'] = 52,    ['mask_2'] = 0,
            ['bproof_1'] = 21,  ['bproof_2'] = 2,
            ['bags_1'] = -0,  ['bags_2'] = 0,
            ['helmet_1'] = 18,  ['helmet_2'] = 0,
            ['chain_1'] = 1,    ['chain_2'] = 0,
            ['ears_1'] = 0,     ['ears_2'] = 0,
		},
		--[[
		female = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 156,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 32,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 17,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['mask_1'] = 121,     ['mask_2'] = 0,
			['bags_1'] = -1,  ['bags_2'] = 0,
		}]]
	},
	motorunmarked_wear = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 139,   ['torso_2'] = 3,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 33,
			['pants_1'] = 32,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 17,  ['helmet_2'] = 2,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['mask_1'] = 121,     ['mask_2'] = 0,
			['bags_1'] = -1,  ['bags_2'] = 0,
		},
		--[[
		female = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 156,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 32,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 17,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['mask_1'] = 121,     ['mask_2'] = 0,
			['bags_1'] = -1,  ['bags_2'] = 0,
		}]]
	},
	ibt_wear = {
		male = {
			['tshirt_1'] = 48,  ['tshirt_2'] = 0,
			['torso_1'] = 51,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 59,   ['pants_2'] = 0,
			['shoes_1'] = 24,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 8,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0,
			['mask_1'] = 11,     ['mask_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['bags_1'] = -1,  ['bags_2'] = 0,
		},
		--[[
		female = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 156,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 32,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 17,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 0,     ['ears_2'] = 0,
			['mask_1'] = 121,     ['mask_2'] = 0,
			['bags_1'] = -1,  ['bags_2'] = 0,
		}]]
	},
}