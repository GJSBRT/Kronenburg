Config = {}
Config.Locale = 'en'

Config.DrawDistance = 100
Config.MarkerColor  = {r = 120, g = 120, b = 240}

Config.ResellPercentage = 75
Config.LicenseEnable    = true
Config.LicensePrice     = 150000

-- looks like this: 'LLL NNN'
-- The maximum plate length is 8 chars (including spaces & symbols), don't go past it!
Config.PlateLetters  = 3
Config.PlateNumbers  = 3
Config.PlateUseSpace = true

Config.Zones = {
	ShopEntering = { -- Marker for Accessing Shop
		Pos   = vector3(-1395.90, -3267.44, 13.94),
		Size  = {x = 0.5, y = 0.5, z = 0.35},
		Type  = 20
	},
	ShopInside = { -- Marker for Viewing Vehicles
	Pos     = vector3(-1382.83, -3247.12, 14.6),
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Heading = 329.28,
		Type    = -1
	},
	ShopOutside = { -- Marker for Purchasing Vehicles
		Pos     = vector3(-1382.83, -3247.12, 14.6),
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Heading = 329.28,
		Type    = -1
	},
	ResellVehicle = { -- Marker for Selling Vehicles
		Pos   = vector3(-1375.47, -3274.74, 12.95),
		Size  = {x = 4.0, y = 4.0, z = 1.0},
		Type  = 1
	}
}
