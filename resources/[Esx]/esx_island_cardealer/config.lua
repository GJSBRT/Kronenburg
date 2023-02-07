Config = {}
Config.Locale = 'en'

Config.DrawDistance = 100.0
Config.MarkerColor  = { r = 120, g = 120, b = 240 }

Config.EnableOwnedVehicles = true -- If true then it will set the Vehicle Owner to the Player who bought it.
Config.ResellPercentage    = 75 -- Sets the Resell Percentage | Example: $100 Car will resell for $75
Config.LicenseEnable       = false -- Require people to own a Boating License when buying Vehicles? Requires esx_license
Config.LicensePrice        = 1000 -- Sets the License Price if Config.LicenseEnable is true

-- looks like this: 'LLL NNN'
-- The maximum plate length is 8 chars (including spaces & symbols), don't go past it!
Config.PlateLetters  = 3
Config.PlateNumbers  = 3
Config.PlateUseSpace = true

Config.Zones = {
	ShopEntering = { -- Marker for Accessing Shop
		Pos   = { x = 5124.35, y = -5141.72, z = 1.2 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Type  = 1
	},
	ShopInside = { -- Marker for Viewing Vehicles
		Pos     = { x = 5166.83, y = -5136.08, z = 1.62 },
		Size    = { x = 1.5, y = 1.5, z = 1.0 },
		Heading = 349.89,
		Type    = -1
	},
	ShopOutside = { -- Marker for Purchasing Vehicles
		Pos     = { x = 5165.51, y = -5141.59, z = 1.62 },
		Size    = { x = 1.5, y = 1.5, z = 1.0 },
		Heading = 349.89,
		Type    = -1
	},
	ResellVehicle = { -- Marker for Selling Vehicles
		Pos   = { x = 5183.87, y = -5132.93, z = 2.33 },
		Size  = { x = 3.0, y = 3.0, z = 1.0 },
		Type  = 1
	}
}
