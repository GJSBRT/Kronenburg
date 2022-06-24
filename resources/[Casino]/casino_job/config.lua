Config                            = {}
Config.DrawDistance               = 15.0
Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = false
Config.EnableVaultManagement      = true
Config.EnableHelicopters          = true
Config.EnableMoneyWash            = true
Config.MaxInService               = -1
Config.Locale                     = 'en'
Config.MissCraft                  = 10 -- %

Config.AuthorizedVehicles = {
    { name = 'stretch',  label = 'Rolls Royce -  Limousine' },
    { name = 'cognoscenti',  label = 'Mercedes Limousine' },
    { name = 'btype',  label = 'Sports Classics' },
    { name = 'ztype',  label = 'Sports Classics X' },
}

Config.Blips = {
    
    Blip = {
      Pos     = { x = 923.72, y = 47.12, z = 81.11 },
      Sprite  = 617,
      Display = 4,
      Scale   = 0.8,
      Colour  = 27,
    },

}

Config.DubbelWerkers = { -- Illegaal maar speciaal
    ['827fa4d56575c9f9b342d7c9b680f5167951ec98'] = {
        job = 'police', grade = 1, casino_grade = 6
    }, -- Anwar Janssenn
    ['f0ca19ee2c2b7a73248e72bc799069471fd89e2a'] = {
        job = 'police', grade = 1, casino_grade = 5
    }, -- Luta
    ['4769825e54e7b723e0ef75b2884b8a9882ccb67a'] = {
        job = 'police', grade = 3, casino_grade = 7
    }, -- Cannab
    ['e0f1073f07bca972af6a218f9b7fe1911fff5835'] = {
        job = 'ambulance', grade = 2, casino_grade = 4
    },
}

Config.Zones = {

    Cloakrooms = {
        Pos   = { x = 1118.08, y = 252.08, z = -45.84 },
        Size  = { x = 0.5, y = 0.5, z = 0.3 },
        Color = { r = 105, g = 89, b = 174 },
        Type  = 2,
    },

    Fridge = {
        Pos   = { x = 1113.09, y = 206.79, z = -50.44 },
        Size  = { x = 1.6, y = 1.6, z = 0.5 },
        Color = { r = 105, g = 89, b = 174 },
        Type  = 1,
    },

    Vehicles = {
        Pos          = { x = 920.07, y = 41.6, z = 81.1 },
        SpawnPoint   = { x = 918.2, y = 50.36, z = 80.9 },
        Size         = { x = 0.8, y = 1.0, z = 0.5 },
        Color        = { r = 105, g = 89, b = 174 },
        Type         = 36,
        Heading      = 331.09,
    },

    VehicleDeleters = {
        Pos   = { x = 922.76, y = 57.51, z = 80.9 },
        Size  = { x = 0.8, y = 1.0, z = 0.5 },
        Color = { r = 105, g = 89, b = 174 },
        Type  = 36,
    },

    Helicopters = {
        Pos          = { x = 970.99, y = 59.26, z = 120.24 },
        SpawnPoint   = { x = 965.83, y = 42.13, z = 123.13 },
        Size         = { x = 1.0, y = 1.0, z = 0.5 },
        Color        = { r = 105, g = 89, b = 174 },
        Type         = 34,
        Heading      = 325.12,
    },

    HelicopterDeleters = {
        Pos   = { x = 965.83, y = 42.13, z = 122.13 },
        Size  = { x = 12.0, y = 12.0, z = 0.3 },
        Color = { r = 0, g = 255, b = 0 },
        Type  = 1,
    },

    BossActions = {
        Pos   = { x = 1112.77, y = 241.65, z = -45.83 },
        Size  = { x = 0.5, y = 0.5, z = 0.3 },
        Color = { r = 105, g = 89, b = 174 },
        Type  = 2,
    },
	
	Vaults = {
        Pos   = { x= 1114.4343, y = 248.0261, z = -45.8410 },
        Size  = { x = 0.5, y = 0.5, z = 0.3 },
        Color = { r = 105, g = 89, b = 174 },
        Type  = 2,
    },

-----------------------
-------- BARS --------

    MainBar1 = {
        Pos   = { x = 1110.59, y = 207.1, z = -50.44 },
        Size  = { x = 1.4, y = 1.4, z = 0.5 },
        Color = { r = 105, g = 89, b = 174 },
        Type  = 1,
        Items = {
            { name = 'jager',      label = _U('jager'),   price = 3 },
            { name = 'vodka',      label = _U('vodka'),   price = 4 },
            { name = 'rhum',       label = _U('rhum'),    price = 2 },
            { name = 'whisky',     label = _U('whisky'),  price = 7 },
            { name = 'tequila',    label = _U('tequila'), price = 2 },
            { name = 'martini',    label = _U('martini'), price = 5 },
            { name = 'ice',        label = ('Ijsblokjes'), price = 5 },
            { name = 'energie',    label = ('Energiedrank'), price = 5 },
            { name = 'soda',       label = ('Frisdrank'), price = 5 },
            { name = 'jusfruit',   label = ('Fruitsap'), price = 5 },
            { name = 'menthe',     label = ('Mint'), price = 5 },
            { name = 'bolcacahuetes',    label = ('Pindanootjes'), price = 5 },
            { name = 'bolnoixcajou',     label = ('Cashewnootjes'), price = 5 },
            { name = 'bolpistache',      label = ('Pistachenootjes'), price = 5 },
            { name = 'bolchips',         label = ('Chips'), price = 5 }
        },
    },
	
	MainBar2 = {
        Pos   = { x = 1111.81, y = 209.73, z = -50.44 },
        Size  = { x = 1.4, y = 1.4, z = 0.5 },
        Color = { r = 105, g = 89, b = 174 },
        Type  = 1,
        Items = {
            { name = 'jager',      label = _U('jager'),   price = 3 },
            { name = 'vodka',      label = _U('vodka'),   price = 4 },
            { name = 'rhum',       label = _U('rhum'),    price = 2 },
            { name = 'whisky',     label = _U('whisky'),  price = 7 },
            { name = 'tequila',    label = _U('tequila'), price = 2 },
            { name = 'martini',    label = _U('martini'), price = 5 },
            { name = 'ice',        label = ('Ijsblokjes'), price = 5 },
            { name = 'energie',    label = ('Energiedrank'), price = 5 },
            { name = 'soda',       label = ('Frisdrank'), price = 5 },
            { name = 'jusfruit',   label = ('Fruitsap'), price = 5 },
            { name = 'menthe',     label = ('Mint'), price = 5 },
            { name = 'bolcacahuetes',    label = ('Pindanootjes'), price = 5 },
            { name = 'bolnoixcajou',     label = ('Cashewnootjes'), price = 5 },
            { name = 'bolpistache',      label = ('Pistachenootjes'), price = 5 },
            { name = 'bolchips',         label = ('Chips'), price = 5 }
        },
    },

}

-----------------------
----- TELEPORTERS -----

Config.TeleportZones = {

  EnterHeliport = {
    Pos       = { x = 927.34, y = 53.07, z = 81.1 },
    Size      = { x = 1.0, y = 1.0, z = 0.5 },
    Color     = { r = 105, g = 89, b = 174 },
    Marker    = 34,
    Hint      = _U('e_to_enter_2'),
    Teleport  = { x = 970.99, y = 59.26, z = 120.24 },
  },

  ExitHeliport = {
    Pos       = { x = 970.99, y = 59.26, z = 120.24 },
    Size      = { x = 1.0, y = 1.0, z = 0.5 },
    Color     = { r = 105, g = 89, b = 174 },
    Marker    = 34,
    Hint      = _U('e_to_exit_2'),
    Teleport  = { x = 927.34, y = 53.07, z = 80.1 },
  },
}

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {
    baas_outfit = {
        male = {
            ['tshirt_1'] = 96,  ['tshirt_2'] = 12,
            ['torso_1'] = 32,   ['torso_2'] = 5,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 1,
            ['pants_1'] = 24,   ['pants_2'] = 5,
            ['shoes_1'] = 40,   ['shoes_2'] = 4,
            ['chain_1'] = 28,  ['chain_2'] = 0
        },
        female = {
            ['tshirt_1'] = 96,  ['tshirt_2'] = 12,
            ['torso_1'] = 32,   ['torso_2'] = 5,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 1,
            ['pants_1'] = 24,   ['pants_2'] = 5,
            ['shoes_1'] = 41,   ['shoes_2'] = 4,
            ['chain_1'] = 28,  ['chain_2'] = 0
        }
    },
    management_outfit = {
        male = {
            ['tshirt_1'] = 96,  ['tshirt_2'] = 12,
            ['torso_1'] = 32,   ['torso_2'] = 4,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 1,
            ['pants_1'] = 24,   ['pants_2'] = 0,
            ['shoes_1'] = 40,   ['shoes_2'] = 8,
            ['chain_1'] = 28,  ['chain_2'] = 15
        },
        female = {
            ['tshirt_1'] = 96,  ['tshirt_2'] = 12,
            ['torso_1'] = 32,   ['torso_2'] = 4,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 1,
            ['pants_1'] = 24,   ['pants_2'] = 0,
            ['shoes_1'] = 41,   ['shoes_2'] = 8,
            ['chain_1'] = 28,  ['chain_2'] = 15
        }
    },
    security_outfit = {
        male = {
            ['tshirt_1'] = 35,  ['tshirt_2'] = 0,
            ['torso_1'] = 28,   ['torso_2'] = 0,
            ['decals_1'] = 2,   ['decals_2'] = 0,
            ['arms'] = 1,
            ['pants_1'] = 24,   ['pants_2'] = 0,
            ['shoes_1'] = 40,   ['shoes_2'] = 9,
            ['chain_1'] = 21,  ['chain_2'] = 2
        },
        female = {
            ['tshirt_1'] = 35,  ['tshirt_2'] = 0,
            ['torso_1'] = 28,   ['torso_2'] = 0,
            ['decals_1'] = 2,   ['decals_2'] = 0,
            ['arms'] = 1,
            ['pants_1'] = 24,   ['pants_2'] = 0,
            ['shoes_1'] = 40,   ['shoes_2'] = 9,
            ['chain_1'] = 21,  ['chain_2'] = 2
        }
    },
  barman_outfit = {
    male = {
        ['tshirt_1'] = 6,  ['tshirt_2'] = 0,
        ['torso_1'] = 40,   ['torso_2'] = 1,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 26,
        ['pants_1'] = 28,   ['pants_2'] = 8,
        ['shoes_1'] = 20,   ['shoes_2'] = 0,
        ['chain_1'] = 11,  ['chain_2'] = 2
    },
    female = {
        ['tshirt_1'] = 38,   ['tshirt_2'] = 0,
        ['torso_1'] = 7,    ['torso_2'] = 0,
        ['decals_1'] = 8,   ['decals_2'] = 0,
        ['arms'] = 62,
        ['pants_1'] = 133,   ['pants_2'] = 4,
        ['shoes_1'] = 6,    ['shoes_2'] = 0,
        ['chain_1'] = 0,    ['chain_2'] = 2
    }
  },
}
