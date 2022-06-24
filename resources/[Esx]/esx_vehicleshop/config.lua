Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerColor                = { r = 255, g = 175, b = 0 } 
Config.EnablePlayerManagement     = false -- enables the actual car dealer job. You'll need esx_addonaccount, esx_billing and esx_society
Config.EnableOwnedVehicles        = true
Config.EnableSocietyOwnedVehicles = false -- use with EnablePlayerManagement disabled, or else it wont have any effects
Config.ResellPercentage           = 70

Config.Locale                     = 'en'

Config.LicenseEnable = true -- require people to own drivers license when buying vehicles? Only applies if EnablePlayerManagement is disabled. Requires esx_license

-- looks like this: 'LLL NNN'
-- The maximum plate length is 8 chars (including spaces & symbols), don't go past it!
Config.PlateLetters  = 3
Config.PlateNumbers  = 3
Config.PlateUseSpace = true
Config.Testdrive = true


Config.Zones = {

	ShopEntering = {
		Pos   = vector3(-33.1203, -1102.1538, 26.4223),
		Size  = {x = 0.5, y = 0.75, z = 0.25},
		Type  = 20
	},

	ShopInside = {
		Pos     = vector3(-46.3468, -1096.7700, 26.4223),
		Size    = {x = 0.5, y = 0.75, z = 0.25},
		Heading = 200,
		Type    = -1
	},

	ShopOutside = {
		Pos     = vector3(-30.2994, -1088.6802, 26.4221),
		Size    = {x = 0.5, y = 0.75, z = 0.25},
		Heading = 204,
		Type    = -1
	},

	BossActions = {
		Pos   = vector3(-32.0, -1114.2, 25.4),
		Size  = {x = 0.5, y = 0.75, z = 0.25},
		Type  = -1
	},

	GiveBackVehicle = {
		Pos   = vector3(-1118.2, -1078.5, -25.6),
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Type  = (Config.EnablePlayerManagement and 1 or -1)
	},

	ResellVehicle = {
		Pos   = vector3(683.68, -5128.23, -1214.52),
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Type  = 1
	},

	Testdrive = {
		Pos   = vector3(-133.21, -1532.48, 34.25),
		Size    = {x = 2.5, y = 2.5, z = 2.0},
		Heading = 228.75,
		Type    = -1
	}

}
