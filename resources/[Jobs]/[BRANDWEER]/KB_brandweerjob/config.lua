--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerType = 20
Config.MarkerSize = {x = 0.5, y = 0.75, z = 0.25}
Config.MarkerColor = {r = 255, g = 175, b = 0}
Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = false
Config.EnableESXIdentity          = true -- only turn this on if you are using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableSocietyOwnedVehicles = false
Config.EnableLicenses             = true
Config.MaxInService               = -1
Config.Locale                     = 'en'
Config.BrandweerActieKleding = {
    decals_2=0,
    pants_1=120,
    mask_2=0,
    torso_1=315,
    watches_1=-1,
    helmet_2=0,
    bproof_2=0,
    pants_2=1,
    hair_1=59,
    hair_color_2=9,
    tshirt_1=15,
    chest_2=0,
    glasses_1=8,
    bags_2=0,
    torso_2=1,
    arms_2=0,
    shoes_1=56,
    glasses_2=2,
    decals_1=1,
    helmet_1=5,
    hair_2=0,
    hair_color_1=44,
    bodyb_1=0,
    chain_1=0,
    chain_2=0,
    mask_1=175,
    bracelets_1=-1,
    bproof_1=0,
    chest_1=0,
    tshirt_2=0,
    bags_1=0,
    shoes_2=1,
    bodyb_2=0,
    chest_3=0,
    arms=38
}

Config.FireStations = {

  LSFD = {
    Blip = {
      Pos = { x=301.8200, y=-672.9193, z=34.3183 },
      Sprite  = 436,
      Display = 4,
      Scale   = 1.2,
      Colour  = 1,
    },

    AuthorizedWeapons = {
      {name = 'WEAPON_FIREEXTINGUISHER', price = 1500},
	    {name = 'WEAPON_FLARE',            price = 3000 },
    },

    AuthorizedVehicles = {
      { name = 'brandmotor', label = 'MOTOR (🏍)' },	
      --{ name = 'brandweer5', label = 'Brandweer T8 (🚐)' },	
      { name = 'brandweer', label = 'Brandweertruck (🚒)' },
      { name = 'br1', label = 'Brandweertruck (HIJSKRAAN I)' },	
      { name = 'br10', label = 'Brandweertruck (HIJSKRAAN II)' }, 
      { name = 'brandweer2', label = 'Brandweertruck (lelijk)' },
      { name = 'panther', label = 'Schiphol Brandweertruck' },	   
    },

    Cloakrooms = {
      { x=300.6964, y=-670.5477, z=34.3183 },
      { x=302.1618, y=-666.4610, z=34.3183}
    },

    Armories = {
      { x=294.058, y=-668.430, z=34.318 },
    },

    Vehicles = {
      {
        Spawner    = { x=303.9285, y=-667.4080, z= 29.3688 },
        SpawnPoint = { x=311.1096, y=-673.6060, z=28.7139 },
        Heading    = 249.4006
      }
    },

    Helicopters = {
      {
        Spawner    = {x = 466.477, y = -982.819, z = 42.691},
        SpawnPoint = {x = 450.04, y = -981.14, z = 42.691},
        Heading    = 0.0
      }
    },

    VehicleDeleters = {
      { x=302.9470, y=-675.9134, z=29.3688 },
    },

    BossActions = {
      { x = 1209.46, y = -1480.73, z = 33.859 },
    }
  }
}