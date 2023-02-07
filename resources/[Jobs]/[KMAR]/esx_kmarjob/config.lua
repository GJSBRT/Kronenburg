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

Config.EnableHandcuffTimer        = false -- enable handcuff timer? will unrestrain player after the time ends
Config.HandcuffTimer              = 10 * 60000 -- 10 mins

Config.MaxInService               = -1
Config.Locale                     = 'en'

Config.kmarStations = {

	LSPD = {

		Blip = {
			Coords  = vector3(1852.16, 3688.29, 33.27),
			
			Sprite  = 60,
			Display = 4,
			Scale   = 0.9,
			Colour  = 29
		},


		Cloakrooms = {
			vector3(1849.89, 3695.38, 34.26),
            vector3(-864.95, -2408.79, 13.80),
            vector3(-439.91, 5991.98, 31.72),
		},

		Cloakroomsdsi = {
			vector3(2474.04, -332.5, 92.99),
		},

		Armories = {
			vector3(1842.58, 3691.55, 34.26),
			vector3(-896.25, -2390.76, 13.87),
			vector3(-437.62, 5988.94, 31.72),
		},

		Vehicles = {
			--Sandy
			{
				Spawner = vector3(1861.96, 3685.91, 34.27),
				SpawnPoint = { x = 1869.1, y = 3693.31, z = 33.16 },
				Heading    = 211.59,
			},
			{
				Spawner = vector3(-886.66, -2371.63, 14.02),
				SpawnPoint = { x = -888.38, y = -2374.76, z = 13.94 },
				Heading    = 152.46,
			},
			{
				Spawner = vector3(-447.29, 6026.5, 31.49),
				SpawnPoint = { x = -445.44, y = 6032.54, z = 32.34 },
				Heading    = 313.02,
			},            
			--Helicopter spawner
			{
				Spawner = vector3(-1091.47, -841.62, 37.70),
				SpawnPoint = { x = -1096.33, y = -832.40, z = 37.97 },
				Heading    = 309.04,
			},
						{
				Spawner = vector3(-454.04, 5988.01, 31.25),
				SpawnPoint = { x = -475.24, y = 5988.51, z = 31.34 },
				Heading    = 313.88,
			},

			--Boten spawner
			{
				Spawner = vector3(-800.76, -1513.11, 1.60),
				SpawnPoint = { x = -802.2, y = -1521.97, z = 0.66 },
				Heading    = 120.0,
			},
		},

		VehicleDeleters = {
		{ x = 1863.84, y = 3701.21, z = 32.55 },
		{ x = 2501.92, y = -319.55, z = 91.67 },
		{ x = 1076.1, y = -847.86, z = 3.59 },
		{ x = -890.03, y = -2365.93, z = 12.94 },
		{ x = -441.28, y = 6025.93, z = 30.34 },
		{ x = -475.24, y = 5988.51, z = 30.34 },
				},

		BossActions = {
			vector3(1862.5, 3689.84, 34.26)
		},

	},

}


Config.AuthorizedWeapons = {
	kmar1 = {
		{ weapon = 'WEAPON_FIREEXTINGUISHER', price = 0},
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
	},

	kmar2 = {
		{ weapon = 'WEAPON_FIREEXTINGUISHER', price = 0},
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },	},

	kmar3 = {
		{ weapon = 'WEAPON_FIREEXTINGUISHER', price = 0},
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_COMBATPISTOL', price = 0 },
	},

	kmar4 = {
		{ weapon = 'WEAPON_FIREEXTINGUISHER', price = 0},
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_COMBATPISTOL', price = 0 },
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_SMG', components = { 0, 0, 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = {  0, 0, 0, 0, 0, 0 }, price = 0 },
	},

	kmar5 = {
		{ weapon = 'WEAPON_FIREEXTINGUISHER', price = 0},
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_COMBATPISTOL', price = 0 },
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_SMG', components = { 0, 0, 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 0, 0, 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_CARBINERIFLE_MK2', components = { 0, 0, 0, 0, 0, 0, 0, 0 }, price = 0 },
	},

	kmar6 = {
		{ weapon = 'WEAPON_FIREEXTINGUISHER', price = 0},
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_COMBATPISTOL', price = 0 },
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_SMG', components = { 0, 0, 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 0, 0, 0, 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_CARBINERIFLE_MK2', components = { 0, 0, 0, 0, 0, 0, 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_SNIPERRIFLE', components = { 0, 0 }, price = 0 },
	},

	kmar7 = {
		{ weapon = 'WEAPON_FIREEXTINGUISHER', price = 0},
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_COMBATPISTOL', price = 0 },
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_SMG', components = { 0, 0, 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 0, 0, 0, 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_CARBINERIFLE_MK2', components = { 0, 0, 0, 0, 0, 0, 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_SNIPERRIFLE', components = { 0, 0 }, price = 0 },
                { weapon = 'WEAPON_SNIPERRIFLE', components = { 0, 0 }, price = 0 },
	},

	kmar8 = {
		{ weapon = 'WEAPON_FIREEXTINGUISHER', price = 0},
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_COMBATPISTOL', price = 0 },
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_SMG', components = { 0, 0, 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 0, 0, 0, 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_CARBINERIFLE_MK2', components = { 0, 0, 0, 0, 0, 0, 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_SNIPERRIFLE', components = { 0, 0 }, price = 0 },
	},

	kmar9 = {
		{ weapon = 'WEAPON_FIREEXTINGUISHER', price = 0},
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_COMBATPISTOL', price = 0 },
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_SMG', components = { 0, 0, 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 0, 0, 0, 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_CARBINERIFLE_MK2', components = { 0, 0, 0, 0, 0, 0, 0, 0 }, price = 0 },
                { weapon = 'WEAPON_SNIPERRIFLE', components = { 0, 0 }, price = 0 },
	},

	kmar10 = {
		{ weapon = 'WEAPON_FIREEXTINGUISHER', price = 0},
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_COMBATPISTOL', price = 0 },
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_SMG', components = { 0, 0, 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 0, 0, 0, 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_CARBINERIFLE_MK2', components = { 0, 0, 0, 0, 0, 0, 0, 0 }, price = 0 },
                { weapon = 'WEAPON_SNIPERRIFLE', components = { 0, 0 }, price = 0 },
	},
    
    kmar11 = {
		{ weapon = 'WEAPON_FIREEXTINGUISHER', price = 0},
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_COMBATPISTOL', price = 0 },
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_SMG', components = { 0, 0, 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 0, 0, 0, 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_CARBINERIFLE_MK2', components = { 0, 0, 0, 0, 0, 0, 0, 0 }, price = 0 },
                { weapon = 'WEAPON_SNIPERRIFLE', components = { 0, 0 }, price = 0 },
	},
    
    kmar12 = {
		{ weapon = 'WEAPON_FIREEXTINGUISHER', price = 0},
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_COMBATPISTOL', price = 0 },
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_SMG', components = { 0, 0, 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 0, 0, 0, 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_CARBINERIFLE_MK2', components = { 0, 0, 0, 0, 0, 0, 0, 0 }, price = 0 },
                { weapon = 'WEAPON_SNIPERRIFLE', components = { 0, 0 }, price = 0 },
	},
    
    kmar13 = {
		{ weapon = 'WEAPON_FIREEXTINGUISHER', price = 0},
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_COMBATPISTOL', price = 0 },
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_SMG', components = { 0, 0, 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 0, 0, 0, 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_CARBINERIFLE_MK2', components = { 0, 0, 0, 0, 0, 0, 0, 0 }, price = 0 },
                { weapon = 'WEAPON_SNIPERRIFLE', components = { 0, 0 }, price = 0 },
	},
    
    kmar14 = {
		{ weapon = 'WEAPON_FIREEXTINGUISHER', price = 0},
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_COMBATPISTOL', price = 0 },
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_SMG', components = { 0, 0, 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 0, 0, 0, 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_CARBINERIFLE_MK2', components = { 0, 0, 0, 0, 0, 0, 0, 0 }, price = 0 },
                { weapon = 'WEAPON_SNIPERRIFLE', components = { 0, 0 }, price = 0 },
	},
   
    kmar15 = {
		{ weapon = 'WEAPON_FIREEXTINGUISHER', price = 0},
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_COMBATPISTOL', price = 0 },
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_SMG', components = { 0, 0, 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 0, 0, 0, 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_CARBINERIFLE_MK2', components = { 0, 0, 0, 0, 0, 0, 0, 0 }, price = 0 },
                { weapon = 'WEAPON_SNIPERRIFLE', components = { 0, 0 }, price = 0 },
	},
    
    kmar16 = {
		{ weapon = 'WEAPON_FIREEXTINGUISHER', price = 0},
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_COMBATPISTOL', price = 0 },
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_SMG', components = { 0, 0, 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 0, 0, 0, 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_CARBINERIFLE_MK2', components = { 0, 0, 0, 0, 0, 0, 0, 0 }, price = 0 },
                { weapon = 'WEAPON_SNIPERRIFLE', components = { 0, 0 }, price = 0 },
	},
    
    kmar17 = {
		{ weapon = 'WEAPON_FIREEXTINGUISHER', price = 0},
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_COMBATPISTOL', price = 0 },
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_SMG', components = { 0, 0, 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 0, 0, 0, 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_CARBINERIFLE_MK2', components = { 0, 0, 0, 0, 0, 0, 0, 0 }, price = 0 },
                { weapon = 'WEAPON_SNIPERRIFLE', components = { 0, 0 }, price = 0 },
	},
   
    boss = {
		{ weapon = 'WEAPON_FIREEXTINGUISHER', price = 0},
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_COMBATPISTOL', price = 0 },
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_SMG', components = { 0, 0, 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 0, 0, 0, 0, 0 }, price = 0 },
		{ weapon = 'WEAPON_CARBINERIFLE_MK2', components = { 0, 0, 0, 0, 0, 0, 0, 0 }, price = 0 },
                { weapon = 'WEAPON_SNIPERRIFLE', components = { 0, 0 }, price = 0 },
	},
}

Config.AuthorizedVehicles = {
	Shared = {
		{
			model = 'kmaramarok',
			label = 'Volkswagen amarok'
		},
        {
			model = 'kmart5',
			label = 'Volkswagen T5'
		},
		{
			model = 'kmarranger',
			label = 'Ranger'
		},
		{
			model = 'kmaraudi',
			label = 'Audi A6'
		},
     	{
			model = 'kmarb',
			label = 'Bmw Motor (Zwaar)'
		},
        {
			model = 'kmarmotor3',
			label = 'Bmw Motor (licht)'
		},
        {
			model = 'kmargklasse',
			label = 'Mercedes G Klasse'
		},
        {
			model = 'kmar3',
			label = 'Opel Astra'
		},

--        {
--			model = 'polbmwx5v2',
--			label = 'Bmw X5'
--		},
--        {
--			model = 'kmarvito',
--			label = 'Vito'
--		},    
--        {
--			model = 'polskoda',
--			label = 'Undercover Skoda'
--		},
        {
			model = 'Dinghy4',
			label = 'Kmar boot (Alleen in het water spawnen)'
		},
        {
			model = 'swift2',
			label = 'Kmar Heli (Alleen In Paleto Spawnen)'
		},
	},
	kmar2 = {
		{
			model = 'polgolf7oov',
			label = 'Volkswagen Golf 7'
		},
		{
			model = 'polmotor',
			label = 'Zware Motor'
		},
		{
			model = 'pamarok',
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
	},
	kmar3 = {
		{
			model = 'polgolf7oov',
			label = 'Volkswagen Golf 7'
		},
		{
			model = 'polmotor',
			label = 'Zware Motor'
		},
		{
			model = 'pamarok',
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
	},
	kmar4 = {
		{
			model = 'polgolf7oov',
			label = 'Volkswagen Golf 7'
		},
		{
			model = 'polmotor',
			label = 'Zware Motor'
		},
		{
			model = 'pamarok',
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
	},
	kmar5 = {
		{
			model = 'polgolf7oov',
			label = 'Volkswagen Golf 7'
		},
		{
			model = 'polmotor',
			label = 'Zware Motor'
		},
		{
			model = 'pamarok',
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
	},
	kmar6 = {
		{
			model = 'polgolf7oov',
			label = 'Volkswagen Golf 7'
		},
		{
			model = 'polmotor',
			label = 'Zware Motor'
		},
		{
			model = 'pamarok',
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
	},
	kmar7 = {
		{
			model = 'polgolf7oov',
			label = 'Volkswagen Golf 7'
		},
		{
			model = 'polmotor',
			label = 'Zware Motor'
		},
		{
			model = 'pamarok',
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
	},
	kmar8 = {
		{
			model = 'polgolf7oov',
			label = 'Volkswagen Golf 7'
		},
		{
			model = 'polmotor',
			label = 'Zware Motor'
		},
		{
			model = 'pamarok',
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
	},
	kmar9 = {
		{
			model = 'polgolf7oov',
			label = 'Volkswagen Golf 7'
		},
		{
			model = 'polmotor',
			label = 'Zware Motor'
		},
		{
			model = 'pamarok',
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
	},
	kmar10 = {
		{
			model = 'polgolf7oov',
			label = 'Volkswagen Golf 7'
		},
		{
			model = 'polmotor',
			label = 'Zware Motor'
		},
		{
			model = 'pamarok',
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
	},
	kmar11 = {
		{
			model = 'polgolf7oov',
			label = 'Volkswagen Golf 7'
		},
		{
			model = 'polmotor',
			label = 'Zware Motor'
		},
		{
			model = 'pamarok',
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
	},
	kmar12 = {
		{
			model = 'polgolf7oov',
			label = 'Volkswagen Golf 7'
		},
		{
			model = 'polmotor',
			label = 'Zware Motor'
		},
		{
			model = 'pamarok',
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
	},
	kmar13 = {
		{
			model = 'polgolf7oov',
			label = 'Volkswagen Golf 7'
		},
		{
			model = 'polmotor',
			label = 'Zware Motor'
		},
		{
			model = 'pamarok',
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
	},
	kmar14 = {
		{
			model = 'polgolf7oov',
			label = 'Volkswagen Golf 7'
		},
		{
			model = 'polmotor',
			label = 'Zware Motor'
		},
		{
			model = 'pamarok',
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
	},
	kmar15 = {
		{
			model = 'polgolf7oov',
			label = 'Volkswagen Golf 7'
		},
		{
			model = 'polmotor',
			label = 'Zware Motor'
		},
		{
			model = 'pamarok',
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
	},
	kmar16 = {
		{
			model = 'polgolf7oov',
			label = 'Volkswagen Golf 7'
		},
		{
			model = 'polmotor',
			label = 'Zware Motor'
		},
		{
			model = 'pamarok',
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
	},
	kmar17 = {
		{
			model = 'polgolf7oov',
			label = 'Volkswagen Golf 7'
		},
		{
			model = 'polmotor',
			label = 'Zware Motor'
		},
		{
			model = 'pamarok',
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
	},
	kmar18 = {
		{
			model = 'polgolf7oov',
			label = 'Volkswagen Golf 7'
		},
		{
			model = 'polmotor',
			label = 'Zware Motor'
		},
		{
			model = 'pamarok',
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
	}
}


-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {
	kmar_wear = {
		male = {
	                ['tshirt_1'] = 48, ['tshirt_2'] = 1,
	                ['torso_1'] = 2, ['torso_2'] = 1,
	                ['decals_1'] = 0, ['decals_2'] = 0,
	                ['arms'] = 0,
                        ['arms_2'] = 0,
	                ['pants_1'] = 1, ['pants_2'] = 1,
	                ['shoes_1'] = 24, ['shoes_2'] = 0,
	                ['mask_1'] = 0, ['mask_2'] = 0,
	                ['bproof_1'] = 0, ['bproof_2'] = 0,
	                ['bags_1'] = -0, ['bags_2'] = 0,
	                ['helmet_1'] = -1, ['helmet_2'] = 0,
	                ['chain_1'] = 6, ['chain_2'] = 0,
	                ['ears_1'] = -1, ['ears_2'] = 0},
		
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
	kmarlang_wear = {
		male = {
                        ['tshirt_1'] = 48, ['tshirt_2'] = 1,
	                ['torso_1'] = 61, ['torso_2'] = 1,
	                ['decals_1'] = 0, ['decals_2'] = 0,
	                ['arms'] = 4,
	                ['pants_1'] = 1, ['pants_2'] = 0,
	                ['shoes_1'] = 24, ['shoes_2'] = 0,
	                ['mask_1'] = 0, ['mask_2'] = 0,
	                ['bproof_1'] = 0, ['bproof_2'] = 0,
	                ['bags_1'] = -0, ['bags_2'] = 0,
	                ['helmet_1'] = -1, ['helmet_2'] = 0,
	                ['chain_1'] = 6, ['chain_2'] = 0,
	                ['ears_1'] = -1, ['ears_2'] = 0}, 		
               
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
	kmarmotor_wear = {
		male = {
			 ['tshirt_1'] = 48, ['tshirt_2'] = 1,
	                 ['torso_1'] = 9, ['torso_2'] = 1,
	                 ['decals_1'] = 0, ['decals_2'] = 0,
	                 ['arms'] = 4,
	                 ['pants_1'] = 32, ['pants_2'] = 1,
	                 ['shoes_1'] = 24, ['shoes_2'] = 0,
	                 ['mask_1'] = 0, ['mask_2'] = 0,
	                 ['bproof_1'] = 0, ['bproof_2'] = 0,
	                 ['bags_1'] = -0, ['bags_2'] = 0,
	                 ['helmet_1'] = 17, ['helmet_2'] = 1,
	                 ['chain_1'] = 6, ['chain_2'] = 0,
	                 ['ears_1'] = -1, ['ears_2'] = 0, 		
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
	kmarhondengeleider_wear = {
		male = {
			['tshirt_1'] = 48, ['tshirt_2'] = 1,
	                ['torso_1'] = 2, ['torso_2'] = 11,
	                ['decals_1'] = 0, ['decals_2'] = 0,
	                ['arms'] = 0,
	                ['pants_1'] = 1, ['pants_2'] = 1,
	                ['shoes_1'] = 24, ['shoes_2'] = 0,
	                ['mask_1'] = 0, ['mask_2'] = 0,
	                ['bproof_1'] = 0, ['bproof_2'] = 0,
	                ['bags_1'] = -0, ['bags_2'] = 0,
	                ['helmet_1'] = -1, ['helmet_2'] = 0,
	                ['chain_1'] = 10, ['chain_2'] = 0,
	                ['ears_1'] = -1, ['ears_2'] = 0, 		
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
	hrbnormaal_wear = { -- currently the same as intendent_wear
                male = {

	                 ['tshirt_1'] = 61, ['tshirt_2'] = 2,
	                 ['torso_1'] = 213, ['torso_2'] = 0,
	                 ['decals_1'] = 0, ['decals_2'] = 0,
	                 ['arms'] = 49,
	                 ['pants_1'] = 31, ['pants_2'] = 0,
	                 ['shoes_1'] = 25, ['shoes_2'] = 0,
	                 ['mask_1'] = 169, ['mask_2'] = 0,
	                 ['bproof_1'] = 5, ['bproof_2'] = 1,
	                 ['bags_1'] = -0, ['bags_2'] = 0,
	                 ['helmet_1'] = 28, ['helmet_2'] = 0,
	                 ['chain_1'] = 1, ['chain_2'] = 0,
	                 ['ears_1'] = -1, ['ears_2'] = 0, 	
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
	hrbae_wear = {
		male = {
			['tshirt_1'] = 48, ['tshirt_2'] = 1,
	                ['torso_1'] = 111, ['torso_2'] = 3,
	                ['decals_1'] = 0, ['decals_2'] = 0,
	                ['arms'] = 4,
	                ['pants_1'] = 33, ['pants_2'] = 0,
	                ['shoes_1'] = 24, ['shoes_2'] = 0,
	                ['mask_1'] = 0, ['mask_2'] = 0,
	                ['bproof_1'] = 21, ['bproof_2'] = 1,
	                ['bags_1'] = -0, ['bags_2'] = 0,
	                ['helmet_1'] = 18, ['helmet_2'] = 1,    
	                ['chain_1'] = 10, ['chain_2'] = 0,
	                ['ears_1'] = -1, ['ears_2'] = 0,
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
	armor = {
		male = {
			['decals_1'] = 0,
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

         douaneat_wear = {
		male = {
			 ['tshirt_1'] = 57, ['tshirt_2'] = 0,
	                 ['torso_1'] = 139, ['torso_2'] = 3,
	                 ['decals_1'] = 0, ['decals_2'] = 0,
	                 ['arms'] = 4,
	                 ['pants_1'] = 33, ['pants_2'] = 0,
	                 ['shoes_1'] = 24, ['shoes_2'] = 0,
	                 ['mask_1'] = 0, ['mask_2'] = 0,
	                 ['bproof_1'] = 21, ['bproof_2'] = 4,
	                 ['bags_1'] = -0, ['bags_2'] = 0,
	                 ['helmet_1'] = 18, ['helmet_2'] = 4,
	                 ['chain_1'] = 10, ['chain_2'] = 0,
	                 ['ears_1'] = -1, ['ears_2'] = 0, 	
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

           bsb_wear = {
		male = {
  	                ['tshirt_1'] = 61, ['tshirt_2'] = 2,
	                ['torso_1'] = 88, ['torso_2'] = 1,
	                ['decals_1'] = 15, ['decals_2'] = 0,
	                ['arms'] = 47,
	                ['pants_1'] = 26, ['pants_2'] = 6,
	                ['shoes_1'] = 17, ['shoes_2'] = 0,
	                ['mask_1'] = 52, ['mask_2'] = 0,
	                ['bproof_1'] = 13, ['bproof_2'] = 0,
	                ['bags_1'] = -0, ['bags_2'] = 0,
	                ['helmet_1'] = 119, ['helmet_2'] = 0,
	                ['chain_1'] = 1, ['chain_2'] = 0,
	                ['ears_1'] = -1, ['ears_2'] = 0,	
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
         bsb2_wear = {
		male = {
			['tshirt_1'] = 61, ['tshirt_2'] = 2,
			['torso_1'] = 88, ['torso_2'] = 1,
			['decals_1'] = 15, ['decals_2'] = 0,
			['arms'] = 47,
			['pants_1'] = 26, ['pants_2'] = 6,
			['shoes_1'] = 17, ['shoes_2'] = 0,
			['mask_1'] = 52, ['mask_2'] = 0,
			['bproof_1'] = 9, ['bproof_2'] = 2,
			['bags_1'] = -0, ['bags_2'] = 0,
			['helmet_1'] = 2, ['helmet_2'] = 1,
			['chain_1'] = 1, ['chain_2'] = 0,
			['ears_1'] = -1, ['ears_2'] = 0,
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
     kmartci_wear = {
		male = {
			  ['tshirt_1'] = 60, ['tshirt_2'] = 0,
	          ['torso_1'] = 70, ['torso_2'] = 0,
	          ['decals_1'] = 0, ['decals_2'] = 0,
	          ['arms'] = 4,
	          ['pants_1'] = 26, ['pants_2'] = 6,
	          ['shoes_1'] = 8, ['shoes_2'] = 1,
	          ['mask_1'] = 0, ['mask_2'] = 0,
	          ['bproof_1'] = 20, ['bproof_2'] = 1,
	          ['bags_1'] = -0, ['bags_2'] = 0,
	          ['helmet_1'] = -1, ['helmet_2'] = 0,
	          ['chain_1'] = 6, ['chain_2'] = 0,
	          ['ears_1'] = -1, ['ears_2'] = 0, 	
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
    kmaribt_wear = {
		male = {
	          ['tshirt_1'] = 48, ['tshirt_2'] = 1,
	          ['torso_1'] = 51, ['torso_2'] = 1,
	          ['decals_1'] = 0, ['decals_2'] = 0,
	          ['arms'] = 0,
	          ['pants_1'] = 1, ['pants_2'] = 0,
	          ['shoes_1'] = 24, ['shoes_2'] = 0,
	          ['mask_1'] = 0, ['mask_2'] = 0,
	          ['bproof_1'] = 20, ['bproof_2'] = 1,
	          ['bags_1'] = -0, ['bags_2'] = 0,
	          ['helmet_1'] = 0, ['helmet_2'] = 5,
	          ['chain_1'] = 10, ['chain_2'] = 0,
	          ['ears_1'] = -1, ['ears_2'] = 0,  	
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
    	barret_wear = {
		male = {
			['helmet_1'] = 28, ['helmet_2'] = 0,
		},
		female = {
			 ['helmet_1'] = 2, ['helmet_2'] = 0,
		},
	},
        steekvest_wear = {
		male = {
			['bproof_1'] = 17, ['bproof_2'] = 2,
		},
		female = {
			 ['bproof_1'] = 17, ['bproof_2'] = 2, 
		},
	},
        steekvest2_wear = {
		male = {
			['bproof_1'] = 25, ['bproof_2'] = 2,
		},
		female = {
			 ['bproof_1'] = 17, ['bproof_2'] = 2,   
		},
	},
        holster_wear = {
		male = {
			['chain_1'] = 12, ['chain_2'] = 2,
		},
		female = {
			 ['chain_1'] = 12, ['chain_2'] = 2, 
		},
	},

    vphesje_wear = {
		male = {
			['decals_1'] = 8, ['decals_2'] = 0,
		},
		female = {
			 ['decals_1'] = 8, ['decals_2'] = 0,   
		},
	},
    tazer_wear = {
		male = {
			['bags_1'] = 2 , ['bags_2'] = 0,
		},
		female = { 
			 ['bags_1'] = 2 , ['bags_2'] = 0,    
		},
	},
    badge_wear = {
		male = {
			['bproof_1'] = 20, ['bproof_2'] = 1,
		},
		female = { 
			 ['bproof_1'] = 20, ['bproof_2'] = 1,
		},
	},
    vest_wear = {
		male = {
			 ['decals_1'] = 3, ['decals_2'] = 0,
		},
		female = { 
			 ['decals_1'] = 3, ['decals_2'] = 0,
		},                                            
	},
	pistoltazer_wear = {
		male = {
			 ['decals_1'] = 1, ['decals_2'] = 0,
		},
		female = { 
			 ['decals_1'] = 3, ['decals_2'] = 0,
		},                                            
	},
    porto_wear = {
		male = {
			 ['decals_1'] = 1, ['decals_2'] = 0,
		},
		female = { 
			 ['decals_1'] = 1, ['decals_2'] = 0,
		},                                            
	},

     lava_wear = {
		male = {
			 ['mask_1'] = 52, ['mask_2'] = 0,
		},
		female = { 
			 ['mask_1'] = 52, ['mask_2'] = 0,
		},                                            
	},
}