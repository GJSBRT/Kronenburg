--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
Config                            = {}
Config.DrawDistance               = 50.0
Config.MarkerType                 = 20
Config.MarkerSize                 = { x = 1.0, y = 1.0, z = 0.80 }
Config.MarkerColor                = { r = 105, g = 89, b = 174 }
Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- only turn this on if you are using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableSocietyOwnedVehicles = false
Config.EnableLicenses             = true
Config.MaxInService               = -1
Config.Locale                     = 'en'

Config.bratvaStations = {

  bratva = {

    Blip = {
      --Pos     = { x = -3207.65, y = 832.53, z = 8.91 },
      Sprite  = 60,
      Display = 4,
      Scale   = 1.2,
      Colour  = 29,
    },


	  AuthorizedVehicles = {
		  { name = 'bg700w',  label = 'Brabus G klasse' },
		  { name = 'brabus800', label = 'Rocket 800' },
	  },

    Cloakrooms = {
      { x = -3219.1, y = 783.8, z = 14.0 },
    },


    Vehicles = {
      {
        Spawner    = { x = -3198.51, y = 836.2, z = 8.90 },
        SpawnPoint = { x = -3206.34, y = 822.66, z = 8.90 },
        Heading    = 210.82,
      }
    },
	
    VehicleDeleters = {
      { x = -3206.34, y = 822.66, z = 8.0 },
    },

    BossActions = {
      { x = -3233.63, y = 813.55, z = 14.0 }
    },

  },

}
