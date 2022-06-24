Version = "1.1.1"

Config = {}

local second = 1
local minute = 60 * second
local hour = 60 * minute
local day = 24 * hour
local week = 7 * day
local month = 4 * week

-- if a player doesn't log in for this time period, the house will be deleted due to inactivity. 
-- if it shouldn't automatically be deleted, just set this to false.
Config.DeleteHouse = month --[[
    you can use math here, for example:
        month + 2 * week = 1 month + 2 weeks
        52 * week = 52 weeks
        365 * day = 365 days
]]

Config.REA = false -- require real estate agents to sell houses? this requires my real estate agent job.
Config.AllowCircle = false -- allow to buy from circle, even though Config.REA is true.

Config.Options = {
    MenuAlign = "bottom-right", -- where the menus are aligned (esx_menu_default)
    MainAction = 51, -- where all keys are "E" by default, remember to change the control in language.lua so it corresponds with this
    SecondaryAction = 47, -- where all the keys are "G" by default, remember to change the control in language.lua so it corresponds with this
    Inventory = "default", -- what inventory you use, valid options: 
    --[[
        default (menu based)
        modfreakz (MF inventory: https://modit.store/products/mf-inventory?variant=39985142268087) PAID
        linden (linden_inventory: https://github.com/thelindat/linden_inventory) FREE, I RECOMMEND THIS
    --]]

    Stripper = {
        Enabled = true, -- allow people to pole dance & lap dance?
        PoleDancing = true, -- allow people to pole dance?
        LapDance = true, -- allow people to lapdance?
    },

    RequireKeyFurnish = true, -- require a key to furnish/remove furniture?

    Key = {
        CheckDistance = true, -- if you must be nearby to unlock / lock
        Distance = 3.0, -- how nearby the player must be to the door to be able to use a key
        Garage = true, -- allow people with a key to access the garage (they will only see their own vehicles)
    },
}

Config.RandomInterior = false -- true: you get assigned a random interior when purchasing | false: you can choose what interior to get when you purchase
Config.MaxProperties = 3 -- the max amount of houses a player can own
Config.EnableGarage = false -- requires my (loaf) garage
Config.Use3DText = true
Config.EnableESXIdentity = true
Config.IdentitySQL = false -- use mysql for fetching username / lastname, you should only enable this if the other method doesn't work
Config.SpawnAboveHouse = true -- if this is true, the shell will spawn in the air above the house (invisible to to other players)
Config.PreviewHouse = {
    Enabled = true, -- allow people to preview?
    Position = vector3(-4000.0, -8250.0, 1250.0), -- the position where shells are spawned when previewing.
}
Config.LockPicking = { --- TOTDAT HET GOED IS AFGESTELD --
    Enabled = false,
    AlertPolice = true, -- this will alert the police that a house is being robbed
    Police = "police", -- the name of the job
    MinimumPolice = 0, -- minimum amount of police required to lockpick
    RequiredPicks = { -- the amount of successful lockpicks required for each house. I recommend that more expensive houses has higher number = harder to rob, and less expensive houses has lower number = easier to rob
        ["HighEndApartment"] = 20,
        ["HighEndHouse"] = 20,
        ["MidTierApartment"] = 18,
        ["MidTierHouse"] = 18,
        ["LowTierHouse"] = 15,
        ["ShitTier"] = 12,
        ["Trailer"] = 12,
    }
}

Config.PoliceRaid = {
    Enabled = false,
    OnlyBoss = false, -- if this is enabled, only the boss can breach the door
    Job = {
        Name = "police",
        Boss = "boss",
    }
}

Config.Blips = {
    Owned = true, -- every house that you personally own
    Access = true, -- every house that you have a key to
    Others = false, -- every house that is owned by someone other than yourself
    Buyable = false, -- every house that is for sale
    IKEA = true, -- where you buy furniture
    Scale = 0.7, -- then blip scale
    IKEAScale = 0.5, -- the IKEA blip scale
    Categorize = true, -- add blips to "PROPERTY" category?
}

Config.IKEA = {
    EnterIKEA = vector4(2747.54, 3472.87, 55.67, 250.0),
    ShellPosition = vector3(45.34, -1771.77, 29.4),
    CameraPosition = vector3(45.11, -1764.03, 34.0),
    Heading = 180.0,
    ResellPercent = 40, -- the % you get back of the original price when selling furniture
}

Config.ResellHouse = {
    ResellPercent = 50, -- the percent of money they get back from the original price
}

Config.ShellToUse = "k4mb1" -- k4mb1 or mythic

-- from https://github.com/JustAnotherModder/mythic_interiors/blob/master/client/shells.lua
Config.DefaultFurniture = {
    ["playerhouse_tier3"] = {
        {
            object = "v_16_high_lng_over_shadow",
            offset = vector3(10.16043000, -4.83294600, 4.99192700),
        }
    },
    ["playerhouse_hotel"] = {
        {
            object = "V_49_MotelMP_Curtains",
            offset = vector3(1.55156, -3.831001, 2.34575),
        },
        {
            object = "V_49_MotelMP_Curtains",
            offset = vector3(1.4319, -3.923151, 2.293296),
        },
    },
}

-- HighEndApartment, HighEndHouse, MidTierApartment, MidTierHouse, LowTierHouse, ShitTier, Trailer

Shells = {
    ["k4mb1"] = {
        ['HighEndApartment'] = {
            {
                object = "shell_apartment2",
            },
            {
                object = "shell_apartment1",
            },
            {
                object = "shell_highendv2",
            },
        },
        ['HighEndHouse'] = {
            {
                object = "shell_highend",
            },
            {
                object = "shell_apartment3",
            },
            {
                object = "shell_michael",
            },
            {
                object = "shell_westons",
            },
            {
                object = "shell_westons2",
            },
            {
                object = "shell_banham",
            },
        },
    
        ['MidTierApartment'] = {
            {
                object = "shell_medium2",
            },
            {
                object = "shell_v16low",
            },
            {
                object = "shell_trevor",
            },
        },
        ['MidTierHouse'] = {
            -- {
            --     object = "shell_v16mid",
            -- },
            {
                object = "classichouse_shell",
            },
            {
                object = "classichouse2_shell",
            },
            {
                object = "classichouse3_shell",
            },
        },
    
        ['LowTierHouse'] = {
            -- {
            --     object = "shell_lester", 
            -- },
            {
                object = "shell_frankaunt",
            }
        },
    
        ['ShitTier'] = {
            {
                object = "shell_medium3",
            },
        },
    
        ['Trailer'] = {
            {
                object = "shell_trailer",
            },
        },
    },
    ["mythic"] = {
        ['HighEndApartment'] = {
            {
                object = "playerhouse_tier3"
            }
        },
        ['HighEndHouse'] = {
            {
                object = "playerhouse_tier3"
            }
        },

        ['MidTierApartment'] = {
            {
                object = "playerhouse_tier1"
            }
        },
        ['MidTierHouse'] = {
            {
                object = "playerhouse_tier1"
            }
        },

        ['LowTierHouse'] = {
            {
                object = "playerhouse_hotel"
            }
        },
        ['ShitTier'] = {
            {
                object = "playerhouse_hotel"
            }
        },
        ['Trailer'] = {
            {
                object = "playerhouse_hotel"
            }
        },
    },
}

Config.Shells = Shells[Config.ShellToUse]

Config.ShellOffsets = {

    ["classichouse_shell"] = vector3(4.687622, -1.957092, -4.374329),
    ["classichouse2_shell"] = vector3(4.035767, -2.174805, -4.374817),
    ["classichouse3_shell"] = vector3(4.427612, -2.438293, -4.374390),
    ["shell_apartment2"] = vector3(-2.2558898925781, 8.9857788085938, 2.2122497558594),
    ["shell_apartment1"] = vector3(-2.2137756347656, 8.95556640625, 2.2123107910156),
    ["shell_highendv2"] = vector3(-10.472412109375, 0.82540893554688, 0.9453125),
    ["shell_highend"] = vector3(-22.357116699219, -0.3636474609375, 6.2174072265625),
    ["shell_apartment3"] = vector3(11.430450439453, 4.4891662597656, 1.01904296875),
    ["shell_michael"] = vector3(-9.3757629394531, 5.6485290527344, -5.05322265625),
    ["shell_medium2"] = vector3(6.0094604492188, 0.28695678710938, -1.6507873535156),
    ["shell_v16low"] = vector3(4.635009765625, -6.5882263183594, -2.6448974609375),
    ["shell_trevor"] = vector3(0.18386840820313, -3.8077392578125, -1.3983764648438),
    ["shell_v16mid"] = vector3(1.3710327148438, -14.351745605469, -1.4822082519531),
    ["shell_lester"] = vector3(-1.6512145996094, -6.0126342773438, -1.35986328125),
    ["shell_frankaunt"] = vector3(-0.33334350585938, -5.9446105957031, -1.5599365234375),
    ["shell_medium3"] = vector3(-2.5239868164063, 7.7714233398438, 0.19931030273438),
    ["shell_trailer"] = vector3(-1.3285827636719, -2.0115661621094, -1.4691772460938),
    ["shell_westons"] = vector3(4.3998336791992, 10.373115539551, 0.35943603515625),
    ["shell_banham"] = vector3(-3.3586883544922, -1.5261611938477, 0.24725341796875),
    ["shell_westons2"] = vector3(-1.8435668945313, 10.505462646484, 0.3590087890625),

    ["playerhouse_hotel"] = vector3(-0.88674545288086, -3.5486145019531, 0.010009765625),
    ["playerhouse_tier1"] = vector3(3.6389088630676, -15.743461608887, -0.185791015625),
    ["playerhouse_tier3"] = vector3(-18.440452575684, -1.98046875, 6.217041015625)
}

for k, v in pairs(Config.Shells) do
    for k, v in pairs(v) do
        if Config.ShellOffsets[v.object] then
            v.entrance = Config.ShellOffsets[v.object]
        else
            print("^1LOAF_HOUSING: ERROR!!! ^0SHELL HAS NO ENTRANCE: " .. v.object)
        end
    end
end

Config.Houses = {
    -- {
    --     Label = "Eclipse towers 1",
    --     Price = 550000,
    --     Garage = {
    --         Exit = vector4(-800.55, 332.31, 85.28, 180.0), -- where the car will spawn when you take it out from your garage
    --         Entrance = vector3(-790.32098388672, 307.93585205078, 85.702102661133), -- where you enter the garage
    --     },
    --     Entrance = vector4(-777.29, 312.91, 85.7, 175.0),
    --     Type = "apartment", -- apartment or house
    --     ShellType = "HighEndApartment",
    -- },
    -- {
    --     Label = "Eclipse towers 2",
    --     Price = 550000,
    --     Garage = {
    --         Exit = vector4(-800.55, 332.31, 85.28, 180.0),
    --         Entrance = vector3(-790.32098388672, 307.93585205078, 85.702102661133),
    --     },
    --     Entrance = vector4(-775.07, 312.91, 85.7, 175.0),
    --     Type = "apartment",
    --     ShellType = "HighEndApartment"
    -- },
    -- {
    --     Label = "Eclipse towers 3",
    --     Price = 550000,
    --     Garage = {
    --         Exit = vector4(-800.55, 332.31, 85.28, 180.0),
    --         Entrance = vector3(-790.32098388672, 307.93585205078, 85.702102661133),
    --     },
    --     Entrance = vector4(-772.75, 312.91, 85.7, 175.0),
    --     Type = "apartment",
    --     ShellType = "HighEndApartment"
    -- },
    -- {
    --     Label = "Eclipse towers 4",
    --     Price = 550000,
    --     Garage = {
    --         Exit = vector4(-800.55, 332.31, 85.28, 180.0),
    --         Entrance = vector3(-790.32098388672, 307.93585205078, 85.702102661133),
    --     },
    --     Entrance = vector4(-770.47, 312.91, 85.7, 175.0),
    --     Type = "apartment",
    --     ShellType = "HighEndApartment"
    -- },
    ------------------------- VANAF HIER ZIJN CUSTOM LOCATIES -----------------------------------------
    {
        Label = "Rockford Hills 2835",
        Price = 1750000,
        Entrance = vector4(-824.69122314453, 422.11721801758, 92.124183654785, 4.6266412734985),
        Type = "house",
        ShellType = "HighEndHouse",
        Garage = {
            Exit = vector4(-805.76806640625, 424.80856323242, 91.164764404297, 358.12051391602),
            Entrance = vector3(-812.20129394531, 421.8330078125, 91.55997467041),
        },
    },
    {
        Label = "Rockford Hills",
        Price = 845000,
        Entrance = vector4(-762.09802246094, 430.98797607422, 100.19689178467, 20.41704750061),
        Type = "house",
        ShellType = "MidTierHouse",
        Garage = {
            Exit = vector4(-756.37158203125, 439.49935913086, 99.332260131836, 32.027355194092),
            Entrance = vector3(-759.27, 435.5, 99.87)
        },
    },
    {
        Label = "Vinewood Hills",
        Price = 1825000,
        Entrance = vector4(-784.31121826172, 459.03790283203, 100.17911529541, 214.1674041748),
        Type = "house",
        ShellType = "HighEndHouse",
        Garage = {
            Exit = vector4(-766.138671875, 465.86376953125, 100.04393768311, 221.47233581543),
            Entrance = vector3(-771.6, 467.69, 100.18),
        },
    },
    {
        Label = "Vinewood Hills",
        Price = 2000000,
        Entrance = vector4(-717.91760253906, 449.08349609375, 106.90912628174, 33.661552429199),
        Type = "house",
        ShellType = "HighEndHouse",
        Garage = {
            Exit = vector4(-737.60144042969, 443.07455444336, 106.45419311523, 22.544794082642),
            Entrance = vector3(-734.44, 441.09, 106.9),
        },
    },
    {
        Label = "Vinewood Hills",
        Price = 1950000,
        Entrance = vector4(-721.67749023438, 490.09130859375, 109.3854598999, 207.96739196777),
        Type = "house",
        ShellType = "HighEndHouse",
        Garage = {
            Exit = vector4(-714.39373779297, 498.74905395508, 108.78099822998, 205.49346923828),
            Entrance = vector3(717.81, 501.24, 109.28),
        },
    },
    {
        Label = "Vinewood Hills",
        Price = 1875000,
        Entrance = vector4(-678.90905761719, 511.69137573242, 113.52600860596, 195.72416687012),
        Type = "house",
        ShellType = "HighEndHouse",
        Garage = {
            Exit = vector4(-688.29125976563, 503.49453735352, 109.88667297363, 22.495265960693),
            Entrance = vector3(-684.63, 507.05, 110.29),
        },
    },
    {
        Label = "Vinewood Hills",
        Price = 1925000,
        Entrance = vector4(-667.16119384766, 471.87008666992, 114.13648986816, 12.573315620422),
        Type = "house",
        ShellType = "MidTierHouse",
    },
    {
        Label = "Vinewood Hills",
        Price = 1775000,
        Entrance = vector4(-640.84423828125, 519.70147705078, 109.68778991699, 191.83695983887),
        Type = "house",
        ShellType = "HighEndHouse",
        Garage = {
            Exit = vector4(-632.14758300781, 518.72601318359, 109.23080444336, 190.06854248047),
            Entrance = vector3(-630.42, 523.1, 109.69)
        }
    },
    {
        Label = "Vinewood Hills",
        Price = 1250000,
        Entrance = vector4(-622.80877685547, 489.19741821289, 108.85733795166, 10.021870613098),
        Type = "house",
        ShellType = "MidTierHouse",
        Garage = {
            Entrance = vector3(-618.02, 490.178, 108.78),
            Exit = vector4(-615.18334960938, 493.49322509766, 107.72460174561, 9.0182447433472),   
        }
    },
    {
        Label = "Vinewood Hills",
        Price = 1860000,
        Entrance = vector4(-595.43835449219, 530.15588378906, 107.7551574707, 189.64042663574),
        Type = "house",
        ShellType = "HighEndHouse",
        Garage = {
            Entrance = vector3(-593.26, 530.51, 108.2),
            Exit = vector4(-586.51824951172, 529.07232666016, 107.43088531494, 227.30792236328),
        }
    },
    {
        Label = "Vinewood Hills",
        Price = 1755000,
        Entrance = vector4(-580.45324707031, 491.8498840332, 108.90293884277, 15.849659919739),
        Type = "house",
        ShellType = "HighEndHouse",
        Garage = {
            Exit = vector4(-575.24328613281, 496.98516845703, 106.05406188965, 9.680495262146),
            Entrance = vector3(-577.74, 429.54, 106.96),
        }
    },
    {
        Label = "Vinewood Hills",
        Price = 875000,
        Entrance = vector4(-526.97869873047, 517.45843505859, 112.9415512085, 43.375503540039),
        Type = "house",
        ShellType = "MidTierHouse",
        Garage = {
            Exit = vector4(-527.32049560547, 526.83068847656, 111.6321182251, 45.063865661621),
            Entrance = vector3(-526.37, 522.91, 112.44),
        }
    },
    {
        Label = "Vinewood Hills",
        Price = 875000,
        Entrance = vector4(-554.58203125, 540.92437744141, 110.70709228516, 152.44755554199),
        Type = "house",
        ShellType = "MidTierHouse",
        Garage = {
            Exit = vector4(-543.84783935547, 544.21716308594, 109.98294067383, 279.5569152832),
            Entrance = vector3(-545.64, 548.96, 110.58)
        }
    },
    {
        Label = "Vinewood Hills",
        Price = 1935000,
        Entrance = vector4(-537.00787353516, 477.494140625, 103.1936416626, 59.317764282227),
        Type = "house",
        ShellType = "HighEndHouse",
        Garage = {
            Exit = vector4(-537.27593994141, 484.15759277344, 102.57349395752, 49.000453948975),
            Entrance = vector3(-536.89, 479.9, 103.15)
        }
    },
    {
        Label = "West Vinewood",
        Price = 1145000,
        Entrance = vector4(-560.99572753906, 402.84576416016, 101.80531311035, 32.415344238281),
        Type = "house",
        ShellType = "MidTierHouse",
        Garage = {
            Entrance = vector3(-571.18, 397.87, 100.66),
            Exit = vector4(-576.31896972656, 400.20474243164, 100.24240112305, 23.082620620728),
        }
    },
    {
        Label = "West Vinewood",
        Price = 765000,
        Entrance = vector4(-595.61077880859, 393.36410522461, 101.88246917725, 7.7197713851929),
        Type = "house",
        ShellType = "MidTierHouse",
        Garage = {
            Entrance = vector3(-600.22, 394.76, 101.89),
            Exit = vector4(-604.39678955078, 398.99713134766, 101.18163299561, 6.40079164505),
        }
    },
    {
        Label = "West Vinewood",
        Price = 823000,
        Entrance = vector4(-615.31884765625, 398.57174682617, 101.62678527832, 0.24803513288498),
        Type = "house",
        ShellType = "MidTierHouse",
        Garage = {
            Entrance = vector3(-625.06, 399.2, 101.23),
            Exit = vector4(-628.71331787109, 401.89248657227, 100.6873550415, 324.10357666016),
        }
    },
    {
        Label = "West Vinewood 3565",
        Price = 1975000,
        Entrance = vector4(-516.93151855469, 433.25784301758, 97.807723999023, 131.06452941895),
        Type = "house",
        ShellType = "HighEndHouse",
        Garage = {
            Entrance = vector3(-514.98, 430.94, 97.71),
            Exit = vector4(-513.65460205078, 426.10430908203, 96.766609191895, 194.28480529785),
        }
    },
    {
        Label = "West Vinewood 3567",
        Price = 1050000,
        Entrance = vector4(-476.54663085938, 412.83578491211, 103.12187957764, 202.74456787109),
        Type = "house",
        ShellType = "MidTierHouse",
        Garage = {
            Entrance = vector3(-485.93, 409.69, 99.24),
            Exit = vector4(-491.90609741211, 408.59970092773, 98.586860656738, 206.40489196777),
        }
    },
    {
        Label = "West Vinewood 3550",
        Price = 1750000,
        Entrance = vector4(-469.41839599609, 329.24765014648, 104.74719238281, 246.64164733887),
        Type = "house",
        ShellType = "HighEndHouse",
        Garage = {
            Entrance = vector3(-471.0, 350.34, 104.15),
            Exit = vector4(-473.52893066406, 354.33959960938, 103.42559814453, 338.01373291016),
        }
    },
    {
        Label = "West Vinewood 3552",
        Price = 1850000,
        Entrance = vector4(-444.28289794922, 343.67352294922, 105.43827819824, 0.29297676682472),
        Type = "house",
        ShellType = "HighEndHouse",
        Garage = {
            Entrance = vector3(-436.88, 342.68, 105.84),
            Exit = vector4(-432.97174072266, 344.41961669922, 105.48830413818, 317.72177124023),
        }
    },
    {
        Label = "West Vinewood 3554",
        Price = 1907500,
        Entrance = vector4(-409.49594116211, 341.3977355957, 108.90744018555, 275.26788330078),
        Type = "house",
        ShellType = "HighEndHouse",
        Garage = {
            Entrance = vector3(-396.07, 339.99, 108.72),
            Exit = vector4(-398.63461303711, 338.23764038086, 108.29840087891, 358.75268554688),
        }
    },
    {
        Label = "West Vinewood 3556",
        Price = 875000,
        Entrance = vector4(-371.80136108398, 343.74401855469, 109.94267272949, 4.4671940803528),
        Type = "house",
        ShellType = "MidTierHouse",
        Garage = {
            Entrance = vector3(-37821, 344.27, 109.3),
            Exit = vector4(-381.02182006836, 347.09997558594, 108.76036071777, 9.5613164901733),
        }
    },
    {
        Label = "West Vinewood 3558",
        Price = 825000,
        Entrance = vector4(-328.26010131836, 370.12210083008, 110.01712799072, 20.458276748657),
        Type = "house",
        ShellType = "MidTierHouse",
        Garage = {
            Entrance = vector3(-342.79, 368.01, 110.02),
            Exit = vector4(-347.96893310547, 368.4814453125, 109.58145904541, 28.666667938232),
        }
    },
    {
        Label = "West Vinewood 3560",
        Price = 1925000,
        Type = "house",
        ShellType = "HighEndHouse",
        Entrance = vector4(-297.73477172852, 379.9143371582, 112.09540557861, 18.664684295654),
        Garage = {
            Entrance = vector3(-300.57, 377.22, 110.34),
            Exit = vector4(-305.09637451172, 379.08322143555, 109.91675567627, 15.116127967834),
        }
    },
    {
        Label = "West Vinewood 3562",
        Price = 2000000,
        Entrance = vector4(-239.54553222656, 381.63482666016, 112.42778778076, 94.41919708252),
        Type = "house",
        ShellType = "HighEndHouse",
        Garage = {
            Entrance = vector3(-255.42, 394.85, 110.02),
            Exit = vector4(-259.77178955078, 397.27127075195, 109.5580368042, 338.38943481445),
        }
    },
    {
        Label = "West Vinewood 3564",
        Entrance = vector4(-214.26976013184, 400.5246887207, 111.10847473145, 10.063199996948),
        Price = 1795000,
        Type = "house",
        ShellType = "HighEndHouse",
        Garage = {
            Entrance = vector3(-198.06, 406.53, 110.91),
            Exit = vector4(-201.89199829102, 410.77056884766, 109.94179534912, 348.62805175781),
        }
    },
    {
        Label = "West Vinewood",
        Entrance = vector4(-305.26879882813, 431.85690307617, 110.3088684082, 12.994167327881),
        Price = 1850000,
        Type = "house",
        ShellType = "HighEndHouse",
        Garage = {
            Entrance = vector3(-315.95, 429.77, 109.87),
            Exit = vector4(-319.59017944336, 433.44323730469, 109.08302307129, 26.075353622437),
        }
    },
    {
        Label = "West Vinewood 3569",
        Entrance = vector4(-400.62506103516, 427.32376098633, 112.34143829346, 245.42820739746),
        Price = 1750000,
        Type = "house",
        ShellType = "HighEndHouse",
        Garage = {
            Exit = vector4(-393.6448059082, 433.80383300781, 111.91892242432, 213.03001403809),
            Entrance = vector3(-397.36, 430.15, 112.34)
        }
    },
    {
        Label = "Vinewood Hills 2848",
        Entrance = vector4(-519.87609863281, 594.42431640625, 120.83665466309, 284.29296875),
        Price = 1890000,
        Type = "house",
        ShellType = "MidTierHouse",
        Garage = {
            Entrance = vector3(-516.89, 578.35, 120.82),
            Exit = vector4(-519.04888916016, 575.55133056641, 120.52325439453, 281.44644165039),
        }
    },
    {
        Label = "Vinewood Hills",
        Entrance = vector4(-474.7575378418, 585.91119384766, 128.68338012695, 81.077239990234),
        Price = 1000000,
        Type = "house",
        ShellType = "MidTierHouse",
        Garage = {
            Entrance = vector3(-475.16, 596.45, 127.78),
            Exit = vector4(-479.48559570313, 599.29034423828, 126.97510528564, 102.73505401611),
        }
    },
    {
        Label = "Vinewood Hills",
        Entrance = vector4(-500.62335205078, 552.42810058594, 120.59142303467, 341.62118530273),
        Price = 775000,
        Type = "house",
        ShellType = "MidTierHouse",
        Garage = {
            Entrance = vector3(-484.71, 547.32, 120.3),
            Exit = vector4(-481.25039672852, 548.53009033203, 119.4768447876, 306.43395996094),
        }
    },
    {
        Label = "Vinewood Hills 3587",
        Entrance = vector4(-459.15042114258, 537.38952636719, 121.45775604248, 4.8317823410034),
        Price = 1950000,
        Type = "house",
        ShellType = "HighEndHouse",
        Garage = {
            Entrance = vector3(-467.59, 538.4, 121.46),
            Exit = vector4(-469.80749511719, 542.80102539063, 120.31508636475, 357.97579956055),
        }
    },
    {
        Label = "Vinewood Hills",
        Entrance = vector4(-418.29666137695, 568.705078125, 125.06004333496, 154.67123413086),
        Price = 785000,
        Type = "house",
        ShellType = "MidTierHouse",
        Garage = {
            Entrance = vector3(-407.06, 567.01, 124.6),
            Exit = vector4(-406.1848449707, 562.63092041016, 124.15399932861, 153.4224395752),
        }
    },
    {
        Label = "Vinewood Hills",
        Entrance = vector4(-386.79510498047, 504.3610534668, 120.41268157959, 333.27734375),
        Price = 945000,
        Type = "house",
        ShellType = "MidTierHouse",
        Garage = {
            Entrance = vector3(-397.83, 513.12, 120.2),
            Exit = vector4(-399.20944213867, 516.95202636719, 119.84329986572, 357.83779907227),
        }
    },
    {
        Label = "Vinewood Hills",
        Entrance = vector4(-378.03527832031, 548.30480957031, 123.85079956055, 230.34490966797),
        Price = 1955000,
        Type = "house",
        ShellType = "HighEndHouse",
        Garage = {
            Entrance = vector3(-380.58, 527.33, 121.42),
            Exit = vector4(-380.21035766602, 524.50732421875, 120.81716918945, 161.07466125488),
        }
    },
    {
        Label = "Vinewood Hills",
        Entrance = vector4(-230.33207702637, 488.267578125, 128.76805114746, 8.7457227706909),
        Price = 765000,
        Type = "house",
        ShellType = "MidTierHouse",
        Garage = {
            Entrance = vector3(-241.39, 492.7, 126.43),
            Exit = vector4(-245.86657714844, 494.65069580078, 125.15540313721, 42.186599731445),
        }
    },
    {
        Label = "Vinewood Hills 3655",
        Entrance = vector4(-174.62835693359, 502.70068359375, 137.4206237793, 85.592208862305),
        Price = 875000,
        Type = "house",
        ShellType = "MidTierHouse",
        Garage = {
            Entrance = vector3(-185.66, 501.4, 134.78),
            Exit = vector4(-189.65336608887, 501.5920715332, 133.98564147949, 73.003684997559),
        }
    },
    {
        Label = "Vinewood Hills",
        Entrance = vector4(-109.87773132324, 502.08441162109, 143.47877502441, 343.81683349609),
        Price = 1888000,
        Type = "house",
        ShellType = "HighEndHouse", 
        Garage = {
            Entrance = vector3(-120.68, 506.74, 143.35),
            Exit = vector4(-124.64455413818, 509.24603271484, 142.53125, 45.144462585449),
        }
    },
    {
        Label = "Vinewood Hills 3659",
        Entrance = vector4(-66.468292236328, 490.51861572266, 144.69032287598, 337.17428588867),
        Price = 880000,
        Type = "house",
        ShellType = "MidTierHouse",
        Garage = {
            Entrance = vector3(-72.1, 491.82, 144.64),
            Exit = vector4(-74.340370178223, 494.85906982422, 144.0916595459, 341.16314697266),
        }
    },
    {
        Label = "Vinewood Hills 3661",
        Entrance = vector4(-7.8035187721252, 468.20797729492, 145.86323547363, 331.39074707031),
        Price = 950000,
        Type = "house",
        ShellType = "MidTierHouse",
        Garage = {
            Entrance = vector3(-2.23, 468.29, 145.44),
            Exit = vector4(1.1285119056702, 468.31802368164, 145.43551635742, 40.598968505859),
        }
    },
    {
        Label = "Vinewood Hills",
        Entrance = vector4(43.063583374023, 468.72747802734, 148.09593200684, 166.7481842041),
        Price = 1755000,
        Type = "house",
        ShellType = "HighEndHouse",
        Garage = {
            Entrance = vector3(52.85, 469.43, 146.93),
            Exit = vector4(55.953010559082, 467.83819580078, 146.37373352051, 240.33261108398),
        }
    },
    {
        Label = "Vinewood Hills",
        Entrance = vector4(57.831237792969, 450.00955200195, 147.0313873291, 343.5178527832),
        Price = 900000,
        Type = "house",
        ShellType = "MidTierHouse",
        Garage = {
            Entrance = vector3(63.46, 453.03, 146.8),
            Exit = vector4(64.664451599121, 456.62533569336, 146.38531494141, 343.72415161133),
        }
    },
    {
        Label = "Vinewood Hills 3666",
        Entrance = vector4(79.868835449219, 486.19003295898, 148.20166015625, 207.60554504395),
        Price = 2000000,
        Type = "house",
        ShellType = "HighEndHouse",
        Garage = {
            Exit = vector4(91.221305847168, 488.82623291016, 147.80085754395, 111.21385192871),
            Entrance = vector3(85.74, 488.62, 147.95)
        }
    },
    {
        Label = "Vinewood Hills",
        Entrance = vector4(-126.40572357178, 588.98956298828, 204.51690673828, 10.408408164978),
        Price = 1900000,
        Type = "house",
        ShellType = "HighEndHouse",
        Garage = {
            Entrance = vector3(-139.56, 593.52, 203.9),
            Exit = vector4(-145.4083404541, 596.63458251953, 203.26391601563, 39.445697784424),
        }
    },
    {
        Label = "Vinewood Hills",
        Entrance = vector4(-188.95718383789, 591.55603027344, 197.82307434082, 265.43151855469),
        Price = 790000,
        Type = "house",
        ShellType = "MidTierHouse",
        Garage = {
            Entrance = vector3(-174.9, 590.13, 197.63),
            Exit = vector4(-178.28617858887, 591.07727050781, 197.2067565918, 0.53850299119949),
        }
    },
    {
        Label = "Vinewood Hills",
        Entrance = vector4(-189.44508361816, 618.17535400391, 199.66120910645, 178.87049865723),
        Price = 1900000,
        Type = "house",
        ShellType = "HighEndHouse",
        Garage = {
            Entrance = vector3(-193.75, 620.88, 197.91),
            Exit = vector4(-199.50428771973, 612.29559326172, 195.64733886719, 174.92555236816),
        }
    },
    {
        Label = "Vinewood Hills",
        Entrance = vector4(-232.59939575195, 588.41748046875, 190.53631591797, 357.8913269043),
        Price = 775000,
        Type = "house",
        ShellType = "MidTierHouse",
        Garage = {
            Entrance = vector3(-228.22, 589.44, 190.02),
            Exit = vector4(-223.78366088867, 592.82635498047, 189.89282226563, 307.96908569336),
        }
    },
    {
        Label = "Vinewood Hills",
        Entrance = vector4(-293.48471069336, 600.95581054688, 181.57562255859, 359.65014648438),
        Price = 850000,
        Type = "house",
        ShellType = "MidTierHouse",
        Garage = {
            Entrance = vector3(-277.09, 600.36, 181.68),
            Exit = vector4(-274.25820922852, 602.587890625, 181.35711669922, 10.281613349915),
        }
    },
    {
        Label = "Vinewood Hills",
        Entrance = vector4(-307.89459228516, 643.33703613281, 176.13121032715, 127.80802154541),
        Price = 1950000,
        Type = "house",
        ShellType = "HighEndHouse",
        Garage = {
            Entrance = vector3(-299.58, 635.48, 175.69),
            Exit = vector4(-303.38995361328, 630.11071777344, 175.27194213867, 111.33813476563),
        }
    },
    {
        Label = "Vinewood Hills",
        Entrance = vector4(-339.89178466797, 668.701171875, 172.78422546387, 260.93835449219),
        Price = 1800000,
        Type = "house",
        ShellType = "HighEndHouse",
        Garage = {
            Entrance = vector3(-342.44, 665.05, 169.26),
            Exit = vector4(-345.16564941406, 663.54827880859, 169.0304107666, 169.10304260254),
        }
    },
    {
        Label = "Vinewood Hills",
        Entrance = vector4(-400.08349609375, 665.03662109375, 163.83026123047, 0.64100456237793),
        Price = 1850000,
        Type = "house",
        ShellType = "HighEndHouse",
        Garage = {
            Entrance = vector3(-398.08, 668.39, 163.08),
            Exit = vector4(-393.69247436523, 673.33471679688, 162.66993713379, 298.32263183594),
        }
    },
    {
        Label = "Vinewood Hills 3661",
        Entrance = vector4(107.11430358887, 467.76760864258, 147.37379455566, 5.3469276428223),
        Price = 1925000,
        Type = "house",
        ShellType = "HighEndHouse",
    },
    {
        Label = "Vinewood Hills",
        Entrance = vector4(232.04405212402, 672.49676513672, 189.9457244873, 45.369850158691),
        Price = 900000,
        Type = "house",
        ShellType = "MidTierHouse",
        Garage = {
            Exit = vector4(227.99737548828, 680.77209472656, 189.05770874023, 111.8012008667),
            Entrance = vector3(231.71, 679.42, 189.72)
        }
    },
    {
        Label = "Vinewood Hills",
        Entrance = vector4(215.84848022461, 620.57562255859, 187.625, 77.482887268066),
        Price = 1000000,
        Type = "house",
        ShellType = "MidTierHouse",
        Garage = {
            Entrance = vector3(213.39, 611.72, 187.47),
            Exit = vector4(210.49569702148, 608.7314453125, 186.38720703125, 144.77088928223),
        }
    },
    {
        Label = "Vinewood Hills",
        Entrance = vector4(128.20178222656, 566.20971679688, 183.95948791504, 352.80078125),
        Price = 975000,
        Type = "house",
        ShellType = "MidTierHouse",
        Garage = {
            Entrance = vector3(130.11, 565.37, 183.9),
            Exit = vector4(131.18869018555, 567.72387695313, 183.02798461914, 48.937213897705),
        }
    },
    {
        Label = "Vinewood Hills 3651",
        Entrance = vector4(-312.0432434082, 474.92568969727, 111.82411193848, 116.88999176025),
        Price = 175500,
        Type = "house",
        ShellType = "HighEndHouse",
        Garage = {
            Entrance = vector3(-311.81, 480.15, 113.45),
            Exit = vector4(-315.57424926758, 478.1653137207, 112.18459320068, 130.95359802246),
        }
    },
    {
        Label = "Vinewood Hills 3581",
        Entrance = vector4(-355.5041809082, 458.22741699219, 116.64736938477, 311.6555480957),
        Price = 1880000,
        Type = "house",
        ShellType = "HighEndHouse",
        Garage = {
            Entrance = vector3(-355.17, 469.72, 112.49),
            Exit = vector4(-351.92391967773, 475.57476806641, 112.29483032227, 327.83416748047),
        }
    },
    {
        Label = "Vinewood Hills",
        Entrance = vector4(-522.92852783203, 628.15771484375, 137.97384643555, 284.88940429688),
        Price = 867000,
        Type = "house",
        ShellType = "MidTierHouse",
        Garage = {
            Exit = vector4(-524.97814941406, 645.74572753906, 137.61405944824, 316.85552978516),
            Entrance = vector3(-526.29, 642.21, 137.74),
        }
    },
    {
        Label = "Vinewood Hills",
        Entrance = vector4(-476.82263183594, 648.02581787109, 144.38664245605, 15.679227828979),
        Price = 1800000,
        Type = "house",
        ShellType = "HighEndHouse",
        Garage = {
            Entrance = vector3(-460.51, 637.04, 144.19),
            Exit = vector4(-463.60168457031, 642.84527587891, 143.68574523926, 45.294219970703),
        }
    },
    {
        Label = "Vinewood Hills 4585",
        Entrance = vector4(-533.34912109375, 709.02020263672, 153.0496673584, 190.62185668945),
        Price = 856000,
        Type = "house",
        ShellType = "MidTierHouse",
        Garage = {
            Entrance = vector3(-526.0, 712.08, 153.33),
            Exit = vector4(-521.85113525391, 710.89910888672, 151.85729980469, 143.94137573242),
        }
    },
    {
        Label = "Vinewood Hills",
        Entrance = vector4(-495.56777954102, 738.60186767578, 163.0309753418, 339.35559082031),
        Price = 850000,
        Type = "house",
        ShellType = "MidTierHouse",
        Garage = {
            Entrance = vector3(-491.37, 751.37, 162.83),
            Exit = vector4(-493.01446533203, 749.96173095703, 162.328125, 242.28256225586),
        }
    },
    {
        Label = "Vinewood Hills 4587",
        Entrance = vector4(-494.19680786133, 796.00524902344, 184.34225463867, 59.773128509521),
        Price = 965000,
        Type = "house",
        ShellType = "MidTierHouse",
        Garage = {
            Entrance = vector3(-489.18, 796.1, 180.54),
            Exit = vector4(-483.50335693359, 798.44635009766, 180.32723999023, 300.61206054688),
        }
    },
    {
        Label = "Vinewood Hills 4589",
        Entrance = vector4(-597.09478759766, 851.62347412109, 211.45388793945, 42.68436050415),
        Price = 750000,
        Type = "house",
        ShellType = "MidTierHouse",
        Garage = {
            Entrance = vector3(-606.73, 861.67, 213.12),
            Exit = vector4(-609.30108642578, 866.66302490234, 213.04370117188, 341.79220581055),
        }
    },
    {
        Label = "Vinewood Hills",
        Entrance = vector4(-658.53601074219, 886.77404785156, 229.2491607666, 5.1279001235962),
        Price = 1935000,
        Type = "house",
        ShellType = "HighEndHouse",
        Garage = {
            Entrance = vector3(-668.83, 905.66, 230.25),
            Exit = vector4(-669.76580810547, 909.10736083984, 229.64390563965, 313.67752075195),
        }
    },
    {
        Label = "Vinewood Hills",
        Entrance = vector4(-747.19244384766, 808.30432128906, 215.03025817871, 294.67913818359),
        Price = 1856000,
        Type = "house",
        ShellType = "HighEndHouse",
        Garage = {
            Entrance = vector3(-750.95, 821.4, 213.45),
            Exit = vector4(-748.56469726563, 818.82946777344, 212.8697052002, 223.34007263184),
        }
    },
    {
        Label = "Vinewood Hills",
        Entrance = vector4(-655.21606445313, 803.29498291016, 198.99119567871, 3.6131298542023),
        Price = 2000000,
        Type = "house",
        ShellType = "HighEndHouse",
        Garage = {
            Entrance = vector3(-658.72, 803.17, 198.99),
            Exit = vector4(-659.63812255859, 811.97943115234, 198.9322052002, 302.66131591797),
        }
    },
    {
        Label = "Vinewood Hills",
        Entrance = vector4(-599.85827636719, 807.63122558594, 191.5249786377, 189.29174804688),
        Price = 888000,
        Type = "house",
        ShellType = "MidTierHouse",
        Garage = {
            Entrance = vector3(-591.14, 808.72, 190.79),
            Exit = vector4(-595.62969970703, 806.51635742188, 190.35572814941, 153.92762756348),
        }
    },
    {
        Label = "Vinewood Hills",
        Entrance = vector4(-595.65277099609, 780.72540283203, 189.11053466797, 299.18685913086),
        Price = 99900,
        Type = "house",
        ShellType = "MidTierHouse",
        Garage = {
            Entrance = vector3(-595.19, 784.23, 188.57),
            Exit = vector4(-589.67236328125, 782.4580078125, 187.89387512207, 302.23815917969),
        }
    },
    {
        Label = "Vinewood Hills",
        Entrance = vector4(-708.91430664063, 712.65209960938, 162.20971679688, 290.37036132813),
        Price = 1780000,
        Type = "house",
        ShellType = "HighEndHouse",
        Garage = {
            Entrance = vector3(-699.47, 706.59, 158.0),
            Exit = vector4(-696.41058349609, 706.00054931641, 156.89506530762, 263.2815246582),
        }
    },
    {
        Label = "Vinewood Hills",
        Entrance = vector4(-700.71856689453, 647.64184570313, 155.17523193359, 4.356752872467),
        Price = 1975000,
        Type = "house",
        ShellType = "HighEndHouse",
        Garage = {
            Entrance = vector3(-706.67, 647.99, 155.18),
            Exit = vector4(-712.04461669922, 656.32257080078, 154.67512512207, 336.53765869141),
        }
    },
    {
        Label = "Vinewood Hills",
        Entrance = vector4(-686.18560791016, 596.47528076172, 143.64202880859, 42.25830078125),
        Price = 780000,
        Type = "house",
        ShellType = "MidTierHouse",
        Garage = {
            Entrance = vector3(-684.95, 599.53, 143.69),
            Exit = vector4(-683.822265625, 603.60339355469, 143.10363769531, 102.03397369385),
        }
    },
    {
        Label = "Vinewood Hills 2864",
        Entrance = vector4(-704.18157958984, 589.01867675781, 141.93048095703, 359.5744934082),
        Price = 845000,
        Type = "house",
        ShellType = "MidTierHouse",
        Garage = {
            Entrance = vector3(-719.52, 589.82, 141.88),
            Exit = vector4(-722.33306884766, 592.22613525391, 141.32775878906, 60.946395874023),
        }
    },
    {
        Label = "Vinewood Hills",
        Entrance = vector4(-732.75390625, 594.02667236328, 142.16055297852, 327.04193115234),
        Price = 956000,
        Type = "house",
        ShellType = "MidTierHouse",
        Garage = {
            Exit = vector4(-742.3720703125, 602.94342041016, 141.46174621582, 10.099612236023),
            Entrance = vector3(-746.5, 602.06, 142.43)
        }
    },
    {
        Label = "Vinewood Hills",
        Entrance = vector4(-753.45153808594, 620.28497314453, 142.85003662109, 287.72653198242),
        Price = 945000,
        Type = "house",
        ShellType = "MidTierHouse",
        Garage = {
            Entrance = -754.09, 623.31, 142.77,
            Exit = vector4(-753.09948730469, 627.61340332031, 142.03411865234, 352.54064941406),
        }
    },
    {
        Label = "Vinewood Hills 2870",
        Entrance = vector4(-765.75372314453, 650.4619140625, 145.69744873047, 296.11175537109),
        Price = 934000,
        Type = "house",
        ShellType = "MidTierHouse",
        Garage = {
            Entrance = vector3(-768.44, 661.37, 145.5),
            Exit = vector4(-762.75109863281, 667.45599365234, 143.3289642334, 257.50601196289),
        }
    },
    {
        Label = "Vinewood Hills",
        Entrance = vector4(-819.42022705078, 696.68280029297, 148.1096496582, 23.005861282349),
        Price = 835000,
        Type = "house",
        ShellType = "MidTierHouse",
        Garage = {
            Entrance = vector3(-809.76, 699.86, 147.2),
            Exit = vector4(-806.83673095703, 704.56530761719, 146.52905273438, 20.013008117676),
        }
    },
    {
        Label = "Vinewood Hills 2874",
        Entrance = vector4(-852.98913574219, 695.69464111328, 148.78749084473, 2.599112033844),
        Price = 964000, 
        Type = "house",
        ShellType = "MidTierHouse",
        Garage = {
            Entrance = vector3(-861.69, 695.69, 148.99),
            Exit = vector4(-863.67736816406, 699.31195068359, 148.53500366211, 308.93832397461),
        }
    },
    {
        Label = "Vinewood Hills", 
        Entrance = vector4(-884.84423828125, 699.45794677734, 151.27102661133, 91.476524353027),
        Price = 789000,
        Type = "house",
        ShellType = "MidTierHouse",
    },
    {
        Label = "Vinewood Hills 2878",
        Entrance = vector4(-908.70678710938, 693.78021240234, 151.43550109863, 356.53451538086),
        Price = 923000,
        Type = "house",
        ShellType = "MidTierHouse",
        Garage = {
            Entrance = vector3(-911.89, 694.09, 151.43),
            Exit = vector4(-913.87414550781, 696.39196777344, 150.93824768066, 299.00274658203),
        }
    },
    {
        Label = "Vinewood Hills",
        Entrance = vector4(-931.54608154297, 691.26794433594, 153.46669006348, 357.61636352539),
        Price = 855000,
        Type = "house",
        ShellType = "MidTierHouse",
        Garage = {
            Entrance = vector3(-951.28, 682.95, 153.58),
            Exit = vector4(-951.98364257813, 688.74676513672, 153.07537841797, 2.7096381187439),
        }
    },
    {
        Label = "Vinewood Hills 2888",
        Entrance = vector4(-1056.0607910156, 761.46343994141, 167.31649780273, 274.78131103516),
        Price = 846000,
        Type = "house",
        ShellType = "MidTierHouse",
        Garage = {
            Entrance = vector3(-1055.89, 764.71, 167.75),
            Exit = vector4(-1052.7225341797, 771.43371582031, 167.08511352539, 281.05621337891),
        }
    },
    {
        Label = "Vinewood Hills",
        Entrance = vector4(-999.32830810547, 816.69140625, 173.04983520508, 223.0433807373),
        Price = 1900000,
        Type = "house",
        ShellType = "HighEndHouse",
        Garage = {
            Entrance = vector3(-1018.88, 817.71, 172.37),
            Exit = vector4(-1022.7098999023, 810.52111816406, 171.46125793457, 193.72018432617),
        }
    },
    {
        Label = "Vinewood Hills",
        Entrance = vector4(-1100.6512451172, 797.65509033203, 167.25628662109, 188.42929077148),
        Price = 1867000,
        Type = "house",
        ShellType = "HighEndHouse",
        Garage = {
            Entrance = vector3(-1104.95, 799.43, 165.5),
            Exit = vector4(-1107.3244628906, 794.07678222656, 164.56657409668, 182.58825683594),
        }
    },
    {
        Label = "Vinewood Hills",
        Entrance = vector4(-1165.6059570313, 726.79931640625, 155.60675048828, 320.07489013672),
        Price = 946000,
        Type = "house",
        ShellType = "MidTierHouse",
        Garage = {
            Entrance = vector3(-1159.88, 735.73, 155.5),
            Exit = vector4(-1158.7442626953, 742.89581298828, 154.9006652832, 351.77526855469),
        }
    },
    {
        Label = "Vinewood Hills",
        Entrance = vector4(-1197.0078125, 693.4228515625, 147.4234161377, 60.651638031006),
        Price = 1000000,
        Type = "house",
        ShellType = "MidTierHouse",
        Garage = {
            Entrance = vector3(-1199.37, 688.81, 147.35),
            Exit = vector4(-1202.1872558594, 688.63531494141, 146.35568237305, 117.24707794189),
        }
    },
    {
        Label = "Vinewood Hills",
        Entrance = vector4(-1218.7385253906, 665.42706298828, 144.53399658203, 43.774505615234),
        Price = 1000000,
        Type = "house",
        ShellType = "MidTierHouse",
        Garage = {
            Entrance = vector3(-1220.58, 663.52, 144.38),
            Exit = vector4(-1223.5916748047, 663.25964355469, 143.35403442383, 85.944046020508),
        }
    },
    {
        Label = "Vinewood Hills",
        Entrance = vector4(-1241.4114990234, 674.19403076172, 142.81259155273, 177.20718383789),
        Price = 734000,
        Type = "house",
        ShellType = "MidTierHouse",
        Garage = {
            Entrance = vector3(-1254.95, 666.84, 142.82),
            Exit = vector4(-1249.0236816406, 664.32397460938, 142.18000793457, 225.07797241211),
        }
    },
    {
        Label = "Vinewood Hills",
        Entrance = vector4(-1291.7937011719, 650.05181884766, 141.50140380859, 195.08702087402),
        Price = 2000000,
        Type = "house",
        ShellType = "HighEndHouse",
        Garage = {
            Entrance = vector3(-1286.07, 653.13, 139.95),
            Exit = vector4(-1285.8291015625, 648.72833251953, 139.27308654785, 200.05378723145),
        }
    },
    {
        Label = "Vinewood Hills",
        Entrance = vector4(-1277.5520019531, 630.01019287109, 143.1870880127, 121.27878570557),
        Price = 1000000,
        Type = "house",
        ShellType = "MidTierHouse",
        Garage = {
            Entrance = vector3(-1282.8, 625.45, 139.23),
            Exit = vector4(-1287.716796875, 626.30505371094, 138.29515075684, 41.560997009277),
        }
    },
    {
        Label = "Vinewood Hills 2117",
        Entrance = vector4(-866.59454345703, 457.07461547852, 88.28108215332, 191.5210723877),
        Price = 2000000,
        Type = "house",
        ShellType = "HighEndHouse",
        Garage = {
            Entrance = vector3(-863.7, 459.8, 88.2),
            Exit = vector4(-861.17913818359, 463.58352661133, 87.311058044434, 276.91204833984),
        }
    },
    {
        Label = "Vinewood Hills",
        Entrance = vector4(-842.86499023438, 466.81594848633, 87.596870422363, 95.962509155273),
        Price = 1845000,
        Type = "house",
        ShellType = "HighEndHouse",
        Garage = {
            Entrance = vector3(-842.93, 463.02, 88.03),
            Exit = vector4(-846.10906982422, 459.91287231445, 87.191101074219, 95.076019287109),
        },
    },
    {
        Label = "Vinewood Hills",
        Type = "house",
        Entrance = vector4(-848.54333496094, 508.69268798828, 90.817039489746, 12.87237739563),
        Price = 874000,
        ShellType = "MidTierHouse",
        Garage = {
            Entrance = vector3(-850.59, 521.9, 90.62),
            Exit = vector4(-845.51055908203, 520.79388427734, 90.199012756348, 104.18309020996),
        }
    },
    {
        Label = "Vinewood Hills",
        Type = "house",
        Entrance = vector4(-884.28546142578, 518.04876708984, 92.442840576172, 287.30416870117),
        Price = 888000,
        ShellType = "MidTierHouse",
        Garage = {
            Entrance = vector3(-877.32, 501.2, 91.01),
            Exit = vector4(-871.14947509766, 500.01690673828, 89.469444274902, 277.29846191406),
        }
    },
    {
        Label = "Vinewood Hills",
        Type = "house",
        Entrance = vector4(-873.50671386719, 562.65411376953, 96.619453430176, 128.35154724121),
        Price = 1945000,
        ShellType = "HighEndHouse",
        Garage = {
            Entrance = vector3(-873.75, 544.64, 92.56),
            Exit = vector4(-873.75970458984, 540.75695800781, 91.655914306641, 80.588226318359),
        }
    },
    {
        Label = "Vinewood Hills",
        Type = "house",
        Entrance = vector4(-907.27264404297, 545.36297607422, 100.20511627197, 311.90512084961),
        Price = 1750000, 
        ShellType = "HighEndHouse",
        Garage = {
            Entrance = vector3(-910.0, 550.26, 95.66),
            Exit = vector4(-909.60980224609, 554.1357421875, 95.836402893066, 312.60552978516),
        }
    },
    {
        Label = "Vinewood Hills",
        Type = "house",
        Entrance = vector4(-904.609375, 588.09790039063, 101.19079589844, 156.50373840332),
        Price = 1850000,
        ShellType = "HighEndHouse",
        Garage = {
            Entrance = vector3(-907.71, 589.25, 101.0),
            Exit = vector4(-912.59930419922, 587.49890136719, 100.50022125244, 148.36747741699),
        }
    },
    {
        Label = "Vinewood Hills",
        Type = "house",
        Entrance = vector4(-924.47808837891, 561.90643310547, 99.905563354492, 330.04592895508),
        Price = 845000,
        ShellType = "MidTierHouse",
        Garage = {
            Entrance = vector3(-932.2, 566.77, 100.15),
            Exit = vector4(-933.01977539063, 569.91955566406, 99.465682983398, 288.82382202148),
        }
    },
    {
        Label = "Vinewood Hills 2140",
        Type = "house",
        Entrance = vector4(-958.25115966797, 607.05072021484, 106.29905700684, 157.53971862793),
        Price = 2000000,
        ShellType = "HighEndHouse",
        Garage = {
            Entrance = vector3(-942.81, 597.4, 101.0),
            Exit = vector4(-941.36120605469, 593.90802001953, 100.58325195313, 164.04443359375),
        }
    },
    {
        Label = "Vinewood Hills 2141",
        Type = "house",
        Entrance = vector4(-947.71911621094, 567.92803955078, 101.49585723877, 294.48858642578),
        Price = 865000,
        ShellType = "MidTierHouse",
        Garage = {
            Entrance = vector3(-954.85, 575.96, 101.24),
            Exit = vector4(-954.81921386719, 579.94799804688, 100.56985473633, 277.48190307617),
        }
    },
    {
        Label = "Vinewood Hills 2139",
        Type = "house",
        Entrance = vector4(-974.40148925781, 581.82312011719, 103.14936065674, 349.68646240234),
        Price = 863000,
        ShellType = "MidTierHouse",
        Garage = {
            Entrance = vector3(-983.92, 583.87, 102.43),
            Exit = vector4(-986.55383300781, 586.50891113281, 101.89521026611, 346.22259521484),
        }
    },
    {
        Label = "Vinewood Hills",
        Type = "house",
        Entrance = vector4(-1022.6172485352, 586.90972900391, 103.42910766602, 0.67520618438721),
        Price = 900000,
        ShellType = "MidTierHouse",
        Garage = {
            Entrance = vector3(-1033.78, 588.49, 103.41),
            Exit = vector4(-1036.6024169922, 590.34954833984, 102.8179473877, 4.8596863746643),
        }
    },
    {
        Label = "Vinewood Hills",
        Type = "house",
        Entrance = vector4(-1107.6539306641, 594.17120361328, 104.45465087891, 209.42413330078),
        Price = 834000,
        ShellType = "HighEndHouse",
        Garage = {
            Entrance = vector3(-1099.15, 601.04, 103.06),
            Exit = vector4(-1095.6473388672, 598.81103515625, 102.64278411865, 208.39305114746),
        }
    },
    {
        Label = "Vinewood Hills",
        Type = "house",
        ShellType = "MidTierHouse",
        Entrance = vector4(-1090.220703125, 548.36853027344, 103.6333770752, 117.03562927246),
        Price = 945000,
        Garage = {
            Entrance = vector3(-1102.45, 549.69, 102.68),
            Exit = vector4(-1105.9572753906, 550.46563720703, 102.19348907471, 28.838905334473),
        }
    },
    {
        Label = "Vinewood Hills",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 845000,
        Entrance = vector4(-1125.3962402344, 548.50762939453, 102.57243347168, 15.688163757324),
        Garage = {
            Entrance = vector3(-1130.84, 548.86, 102.5),
            Exit = vector4(-1134.4610595703, 550.55389404297, 101.63323974609, 15.823389053345),
        }
    },
    {
        Label = "Vinewood Hills 2130",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 900000,
        Entrance = vector4(-1193.0806884766, 563.88256835938, 100.33943939209, 186.03015136719),
        Garage = {
            Entrance = vector3(-1207.02, 560.83, 100.06),
            Exit = vector4(-1208.7305908203, 557.52716064453, 98.955375671387, 187.83422851563),
        }
    },
    {
        Label = "Vinewood Hills",
        Type = "house",
        ShellType = "HighEndHouse",
        Price = 1845000,
        Entrance = vector4(-1217.8099365234, 506.65133666992, 95.857849121094, 176.28294372559),
        Garage = {
            Entrance = vector3(-1233.68, 492.83, 93.26),
            Exit = vector4(-1239.8802490234, 484.1591796875, 92.624244689941, 170.18218994141),
        }
    },
    {
        Label = "Vinewood Hills",
        Type = "house",
        ShellType = "HighEndHouse",
        Price = 1875000,
        Entrance = vector4(-1896.2788085938, 642.67492675781, 130.20903015137, 136.03713989258),
        Garage = {
            Entrance = vector3(-1887.42, 631.09, 130.0),
            Exit = vector4(-1887.4068603516, 624.33557128906, 129.57968139648, 138.72448730469),
        }
    },
    {
        Label = "Vinewood Hills",
        Type = "house",
        ShellType = "HighEndHouse",
        Price = 1775000,
        Entrance = vector4(-1974.2854003906, 630.78961181641, 122.53632354736, 246.62167358398),
        Garage = {
            Entrance = vector3(-1976.23, 627.43, 122.54),
            Exit = vector4(-1967.7639160156, 620.19866943359, 121.14989471436, 209.86547851563),
        }
    },
    {
        Label = "Vinewood Hills",
        Type = "house",
        ShellType = "HighEndHouse",
        Price = 1875000,
        Entrance = vector4(-1929.16015625, 595.41986083984, 122.28488922119, 71.682762145996),
        Garage = {
            Entrance = vector3(-1935.3758544922, 583.08123779297, 119.60961151123),
            Exit = vector4(-1946.369140625, 584.38220214844, 118.18846893311, 78.724143981934),
        }
    },
    {
        Label = "Vinewood Hills",
        Type = "house",
        ShellType = "HighEndHouse",
        Price = 1960000,
        Entrance = vector4(-1995.4644775391, 591.08557128906, 117.90339660645, 265.65591430664),
        Garage = {
            Entrance = vector3(-1992.86, 602.38, 117.9),
            Exit = vector4(-1988.4603271484, 606.21673583984, 117.5119934082, 259.29388427734),
        }
    },
    {
        Label = "Vinewood Hills",
        Type = "house",
        ShellType = "HighEndHouse",
        Price = 1785000,
        Entrance = vector4(-1937.841796875, 551.24279785156, 114.82850646973, 70.323516845703),
        Garage = {
            Entrance = vector3(-1938.56, 555.06, 114.83),
            Exit = vector4(-1940.1877441406, 560.86614990234, 114.74412536621, 55.95174407959),
        }
    },
    {
        Label = "Banham Canyon",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 850000,
        Entrance = vector4(-2014.6271972656, 499.6259765625, 107.17178344727, 255.70758056641),
        Garage = {
            Entrance = vector3(-2014.94, 489.95, 107.17),
            Exit = vector4(-2012.2801513672, 482.13143920898, 106.54067993164, 263.64508056641),
        }
    },
    {
        Label = "Pacific Bluffs",
        Type = "house",
        ShellType = "HighEndHouse",
        Price = 1860000,
        Entrance = vector4(-2011.0640869141, 445.06207275391, 103.0159072876, 287.10949707031),
        Garage = {
            Entrance = vector3(-2011.84, 451.35, 102.68),
            Exit = vector4(-2009.8459472656, 454.48348999023, 102.23957824707, 279.68099975586),
        }
    },
    {
        Label = "Vinewood Hills",
        Type = "house",
        ShellType = "HighEndHouse",
        Price = 1900000,
        Entrance = vector4(-1942.9561767578, 449.48245239258, 102.92810058594, 100.98101043701),
        Garage = {
            Entrance = vector3(-1937.51, 459.99, 102.43),
            Exit = vector4(-1942.6452636719, 461.93612670898, 101.74552154541, 97.400329589844),
        }
    },
    {
        Label = "Richman",
        Type = "house",
        ShellType = "HighEndHouse",
        Price = 1950000,
        Entrance = vector4(-1940.7066650391, 387.46115112305, 96.507835388184, 188.98190307617),
        Garage = {
            Entrance = vector3(-1938.61, 385.02, 96.51),
            Exit = vector4(-1941.4698486328, 385.505859375, 96.085731506348, 100.61340332031),
        }
    },
    {
        Label = "Pacific Bluffs",
        Type = "house",
        ShellType = "HighEndHouse",
        Price = 1935000,
        Entrance = vector4(-2008.9393310547, 367.40765380859, 94.814430236816, 266.26239013672),
        Garage = {
            Entrance = vector3(-2003.95, 382.06, 94.48),
            Exit = vector4(-2001.0267333984, 378.13198852539, 94.062255859375, 182.42645263672),
        }
    },
    {
        Label = "Richman",
        Type = "house",
        ShellType = "HighEndHouse",
        Price = 1915000,
        Entrance = vector4(-1861.1430664063, 310.50671386719, 89.114707946777, 106.83516693115),
        Garage = {
            Entrance = vector3(-1859.92, 321.99, 88.72),
            Exit = vector4(-1857.9412841797, 325.70669555664, 88.26782989502, 14.064755439758),
        }
    },
    {
        Label = "Richman",
        Type = "house",
        ShellType = "HighEndHouse",
        Price = 1825000,
        Entrance = vector4(-1807.9136962891, 333.18218994141, 89.567260742188, 25.943840026855),
        Garage = {
            Entrance = vector3(-1791.17, 343.17, 88.55),
            Exit = vector4(-1792.5447998047, 347.07019042969, 88.133743286133, 65.241065979004),
        }
    },
    {
        Label = "Richman",
        Type = "house",
        ShellType = "HighEndHouse",
        Price = 1800000,
        Entrance = vector4(-1733.1791992188, 379.27798461914, 89.725166320801, 34.122295379639),
        Garage = {
            Entrance = vector3(-1746.89, 369.447, 89.73),
            Exit = vector4(-1749.2238769531, 366.56408691406, 89.299491882324, 118.86130523682),
        }
    },
    {
        Label = "Richman",
        Type = "house",
        ShellType = "HighEndHouse",
        Price = 1975000,
        Entrance = vector4(-1672.9997558594, 385.89031982422, 89.348297119141, 352.44857788086),
        Garage = {
            Entrance = vector3(-1662.66, 385.48, 89.44),
            Exit = vector4(-1665.0407714844, 388.75375366211, 88.873756408691, 7.4059343338013),
        }
    },
    {
        Label = "Richman",
        Type = "house",
        ShellType = "HighEndHouse",
        Price = 2000000,
        Entrance = vector4(-1995.4373779297, 300.68603515625, 91.964653015137, 201.77185058594),
        Garage = {
            Entrance = vector3(-1998.21, 291.55, 91.76),
            Exit = vector4(-1996.4631347656, 295.03057861328, 91.343360900879, 240.16607666016),
        }
    },
    {
        Label = "Richman",
        Type = "house",
        ShellType = "HighEndHouse",
        Price = 1790000,
        Entrance = vector4(-1922.6508789063, 298.33374023438, 89.287216186523, 100.2723236084),
        Garage = {
            Entrance = vector3(-1920.43, 287.89, 89.07),
            Exit = vector4(-1921.0272216797, 283.71160888672, 88.651550292969, 150.92372131348),
        }
    },
    {
        Label = "Richman",
        Type = "house",
        ShellType = "HighEndHouse",
        Price = 1960000,
        Entrance = vector4(-1970.3382568359, 246.12942504883, 87.812126159668, 309.91494750977),
        Garage = {
            Entrance = vector3(-1980.43, 255.9, 87.22),
            Exit = vector4(-1980.2670898438, 259.43218994141, 86.792747497559, 289.79187011719),
        }
    },
    {
        Label = "Richman",
        Type = "house",
        ShellType = "HighEndHouse",
        Price = 1980000,
        Entrance = vector4(-1961.0964355469, 211.8539276123, 86.802871704102, 299.1628112793),
        Garage = {
            Entrance = vector3(-1953.05, 202.92, 86.42),
            Exit = vector4(-1949.1351318359, 201.52388000488, 85.678985595703, 287.76531982422),
        }
    },
    {
        Label = "Richman",
        Type = "house",
        ShellType = "HighEndHouse",
        Price = 2000000,
        Entrance = vector4(-1905.7241210938, 252.85443115234, 86.45288848877, 125.58631134033),
        Garage = {
            Entrance = vector3(-1900.59, 242.69, 86.25),
            Exit = vector4(-1899.9774169922, 237.58529663086, 85.82991027832, 114.90129089355),
        }
    },
    {
        Label = "Richman",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 890000,
        Entrance = vector4(-1931.7377929688, 162.71925354004, 84.652740478516, 287.41625976563),
        Garage = {
            Entrance = vector3(-1937.6, 176.36, 84.65),
            Exit = vector4(-1937.4283447266, 181.67877197266, 84.211044311523, 310.09420776367),
        }
    },



    {
        Label = "El Burro Heights",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 400000,
        Entrance = vector4(1286.61328125, -1604.4053955078, 54.824890136719, 19.914331436157),
    },
    {
        Label = "El Burro Heights",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 425000,
        Entrance = vector4(1230.5983886719, -1591.0621337891, 53.766098022461, 216.49458312988),
        Garage = {
            Entrance = vector3(1226.94, -1600.66, 52.11),
            Exit = vector4(1226.9145507813, -1604.4183349609, 51.37370300293, 209.66549682617),
        }
    },
    {
        Label = "El Burro Heights",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 423000,
        Entrance = vector4(1245.3991699219, -1626.7275390625, 53.282306671143, 28.428913116455),
        Garage = {
            Entrance = vector3(1236.25, -1632.06, 51.99),
            Exit = vector4(1235.7453613281, -1629.2457275391, 51.402263641357, 31.850444793701),
        }
    },
    {
        Label = "El Burro Heights",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 475000,
        Entrance = vector4(1210.3342285156, -1606.671875, 50.736511230469, 208.81425476074),
    },
    {
        Label = "El Burro Heights",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 495000,
        Entrance = vector4(1214.4057617188, -1644.2056884766, 48.64599609375, 33.131099700928),
    },
    {
        Label = "El Burro Heights",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 500000,
        Entrance = vector4(1193.4368896484, -1622.3159179688, 45.221446990967, 125.28066253662),
    },
    {
        Label = "El Burro Heights",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 475000,
        Entrance = vector4(1193.5463867188, -1656.4188232422, 43.026405334473, 30.483993530273),
    },
    {
        Label = "El Burro Heights",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 485000,
        Entrance = vector4(1354.8349609375, -1690.6450195313, 60.491184234619, 264.22903442383),
    },
    {
        Label = "El Burro Heights",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 495000,
        Entrance = vector4(1365.4884033203, -1721.4167480469, 65.634101867676, 13.310842514038),
    },
    {
        Label = "El Burro Heights",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 468000,
        Entrance = vector4(1316.9342041016, -1698.8471679688, 58.225273132324, 188.52821350098),
    },
    {
        Label = "El Burro Heights",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 445600,
        Entrance = vector4(1314.5100097656, -1733.0632324219, 54.700035095215, 294.36093139648),
    },
    {
        Label = "El Burro Heights",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 785000,
        Entrance = vector4(1289.2761230469, -1710.7877197266, 55.474918365479, 203.06790161133),
        Garage = {
            Entrance = vector3(1301.79, -1699.46, 55.13),
            Exit = vector4(1301.5202636719, -1704.8107910156, 54.698348999023, 199.02020263672),
        }
    },
    {
        Label = "El Burro Heights",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 466000,
        Entrance = vector4(1294.9986572266, -1739.7996826172, 54.271789550781, 295.31008911133),
    },
    {
        Label = "El Burro Heights",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 415000,
        Entrance = vector4(1259.1362304688, -1761.6442871094, 49.658267974854, 22.434186935425),
    },
    {
        Label = "El Burro Heights",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 425000,
        Entrance = vector4(1250.7862548828, -1734.3605957031, 52.031967163086, 208.40205383301),
    },
    {
        Label = "El Burro Heights",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 433000,
        Entrance = vector4(1315.7683105469, -1526.5808105469, 51.807609558105, 193.80841064453),
    },
    {
        Label = "El Burro Heights",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 435000,
        Entrance = vector4(1327.4493408203, -1553.0438232422, 54.051540374756, 49.852310180664),
        Garage = {
            Entrance = vector3(1337.64, -1551.59, 53.31),
            Exit = vector4(1336.0856933594, -1548.3718261719, 52.301979064941, 43.254741668701),
        }
    },
    {
        Label = "El Burro Heights",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 473000,
        Entrance = vector4(1338.2021484375, -1524.2496337891, 54.581565856934, 160.32200622559),
    },
    {
        Label = "El Burro Heights",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 489000,
        Entrance = vector4(1360.6536865234, -1556.2014160156, 56.342628479004, 11.80193901062),
    },
    {
        Label = "El Burro Heights",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 476000,
        Entrance = vector4(1379.0386962891, -1514.8627929688, 58.43571472168, 210.75796508789),
    },
    {
        Label = "Grove St",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 400000,
        Entrance = vector4(-34.035636901855, -1847.2677001953, 26.193517684937, 215.66487121582),
        Garage = {
            Entrance = vector3(-31.86, -1853.51, 25.93),
            Exit = vector4(-29.786842346191, -1853.7829589844, 25.311340332031, 321.48364257813),
        }
    },
    {
        Label = "Grove St",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 460000,
        Entrance = vector4(-20.66693687439, -1858.7166748047, 25.408672332764, 35.482913970947),
        Garage = {
            Entrance = vector3(-26.43, -1853.87, 25.01),
            Exit = vector4(-22.402267456055, -1852.4320068359, 24.65997505188, 319.65832519531),
        }
    },
    {
        Label = "Grove St",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 500000,
        Entrance = vector4(21.013378143311, -1844.4187011719, 24.601734161377, 51.06908416748),
        Garage = {
            Entrance = vector3(10.04, -1842.29, 24.52),
            Exit = vector4(10.213895797729, -1845.7950439453, 23.916402816772, 139.3244934082),
        }
    },
    {
        Label = "Grove St",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 464000,
        Entrance = vector4(-4.8931722640991, -1872.109375, 24.151016235352, 42.959381103516),
        Garage = {
            Entrance = vector3(-5.53, -1879.14, 23.83),
            Exit = vector4(-3.1761975288391, -1882.1008300781, 23.223760604858, 317.36676025391),
        }
    },
    {
        Label = "Grove St",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 478000,
        Entrance = vector4(5.0542683601379, -1884.2237548828, 23.697267532349, 47.081920623779),
        Garage = {
            Entrance = vector3(12.75, -1885.32, 23.22),
            Exit = vector4(14.806547164917, -1883.2550048828, 22.730392456055, 321.80651855469),
        }
    },
    {
        Label = "Grove St",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 496000,
        Entrance = vector4(45.982795715332, -1864.2603759766, 23.278301239014, 134.1800994873),
        Garage = {
            Entrance = vector3(46.21, -1851.18, 22.83),
            Exit = vector4(43.170295715332, -1851.7877197266, 22.41028213501, 135.27975463867),
        }
    },
    {
        Label = "Grove St",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 445000,
        Entrance = vector4(23.289144515991, -1896.6623535156, 22.965877532959, 317.37341308594),
        Garage = {
            Entrance = vector3(31.61, -1894.88, 22.28),
            Exit = vector4(34.00611114502, -1893.064453125, 21.779186248779, 324.83532714844),
        }
    },
    {
        Label = "Grove St",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 400000,
        Entrance = vector4(39.174945831299, -1911.7375488281, 21.953496932983, 230.44303894043),
        Garage = {
            Entrance = vector3(36.45, -1924.72, 21.79),
            Exit = vector4(39.660694122314, -1923.6262207031, 21.262651443481, 321.05770874023),
        }
    },
    {
        Label = "Grove St",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 414000,
        Entrance = vector4(56.710884094238, -1922.6340332031, 21.911066055298, 325.21520996094),
        Garage = {
            Entrance = vector3(64.66, -1921.87, 21.47),
            Exit = vector4(68.458366394043, -1921.1730957031, 20.873205184937, 318.90893554688),
        }
    },
    {
        Label = "Grove St",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 426000,
        Entrance = vector4(72.294219970703, -1938.9985351563, 21.369119644165, 311.2370300293),
    },
    {
        Label = "Grove St",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 451000,
        Entrance = vector4(76.244407653809, -1948.2615966797, 21.174133300781, 226.14768981934),
    },
    {
        Label = "Grove St",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 415000,
        Entrance = vector4(85.894096374512, -1959.4940185547, 21.121673583984, 45.807479858398),
    },
    {
        Label = "Grove St",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 403000,
        Entrance = vector4(114.35620880127, -1961.0100097656, 21.334175109863, 26.430368423462),
    },
    {
        Label = "Grove St",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 409500,
        Entrance = vector4(126.81433105469, -1929.8228759766, 21.382415771484, 25.877565383911),
    },
    {
        Label = "Grove St",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 406000,
        Entrance = vector4(118.23268127441, -1920.9901123047, 21.323425292969, 44.940574645996),
    },
    {
        Label = "Grove St",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 433000,
        Entrance = vector4(100.98261260986, -1912.2362060547, 21.407423019409, 152.20318603516),
    },

    {
        Label = "Covenant Ave",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 468000,
        Entrance = vector4(103.94599151611, -1885.3551025391, 24.318777084351, 326.98065185547),
    },
    {
        Label = "Covenant Ave",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 418000,
        Entrance = vector4(115.36309814453, -1887.8868408203, 23.928226470947, 57.113746643066),
    },
    {
        Label = "Covenant Ave",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 465000,
        Entrance = vector4(127.86907958984, -1896.9144287109, 23.674194335938, 70.014419555664),
    },
    {
        Label = "Covenant Ave",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 486000,
        Entrance = vector4(148.86836242676, -1904.412109375, 23.531663894653, 332.80786132813),
    },
    {
        Label = "Covenant Ave",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 500000,
        Entrance = vector4(130.43334960938, -1853.3743896484, 25.234785079956, 150.67715454102),
    },
    {
        Label = "Covenant Ave",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 468000,
        Entrance = vector4(150.00303649902, -1864.7358398438, 24.591331481934, 159.65516662598),
    },
    {
        Label = "Covenant Ave",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 404600,
        Entrance = vector4(171.49269104004, -1871.4272460938, 24.400224685669, 66.137390136719),
    },
    {
        Label = "Covenant Ave",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 471000,
        Entrance = vector4(192.24940490723, -1883.2145996094, 25.056755065918, 150.63162231445),
    },

    {
        Label = "Brouge Ave",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 460000,
        Entrance = vector4(252.84599304199, -1670.8842773438, 29.663164138794, 145.3473815918),
    },
    {
        Label = "Brouge Ave",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 449000,
        Entrance = vector4(240.71138000488, -1687.8841552734, 29.699613571167, 232.43984985352),
    },
    {
        Label = "Brouge Ave",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 454000,
        Entrance = vector4(222.80082702637, -1702.8446044922, 29.694808959961, 216.34411621094),
    },
    {
        Label = "Brouge Ave",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 468000,
        Entrance = vector4(216.67367553711, -1717.6793212891, 29.677778244019, 309.49844360352),
    },
    {
        Label = "Brouge Ave",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 447000,
        Entrance = vector4(197.8286895752, -1725.7751464844, 29.663640975952, 313.64288330078),
    },
    {
        Label = "Brouge Ave",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 468000,
        Entrance = vector4(250.25276184082, -1730.6229248047, 29.668798446655, 53.453002929688),
    },
    {
        Label = "Brouge Ave",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 479000,
        Entrance = vector4(257.5016784668, -1722.7014160156, 29.654127120972, 143.30477905273),
    },
    {
        Label = "Brouge Ave",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 480000,
        Entrance = vector4(269.65386962891, -1712.7335205078, 29.668798446655, 125.54312896729),
    },
    {
        Label = "Brouge Ave",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 474000,
        Entrance = vector4(282.07641601563, -1694.8441162109, 29.647911071777, 47.613609313965),
    },

    {
        Label = "Roy Lowenstein Blvd",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 468000,
        Entrance = vector4(332.98727416992, -1740.9340820313, 29.73052406311, 136.69189453125),
    },
    {
        Label = "Roy Lowenstein Blvd",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 424000,
        Entrance = vector4(320.59902954102, -1759.8359375, 29.637903213501, 237.25158691406),
    },
    {
        Label = "Roy Lowenstein Blvd",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 426500,
        Entrance = vector4(304.5207824707, -1775.6004638672, 29.101078033447, 218.95593261719),
    },
    {
        Label = "Roy Lowenstein Blvd",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 421000,
        Entrance = vector4(300.15203857422, -1783.7691650391, 28.43865776062, 139.6058807373),
    },
    {
        Label = "Roy Lowenstein Blvd",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 467000,
        Entrance = vector4(288.73348999023, -1792.5743408203, 28.089059829712, 310.15405273438),
    },
    {
        Label = "Roy Lowenstein Blvd",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 420000,
        Entrance = vector4(320.30282592773, -1853.9154052734, 27.510938644409, 49.172145843506),
    },
    {
        Label = "Roy Lowenstein Blvd",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 486000,
        Entrance = vector4(329.17208862305, -1845.7034912109, 27.748098373413, 31.938045501709),
    },
    {
        Label = "Roy Lowenstein Blvd",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 494000,
        Entrance = vector4(348.82360839844, -1820.9500732422, 28.894094467163, 318.58615112305),
    },
    {
        Label = "Roy Lowenstein Blvd",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 438000,
        Entrance = vector4(405.73928833008, -1751.3210449219, 29.710329055786, 137.33497619629),
    },
    {
        Label = "Roy Lowenstein Blvd",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 464000,
        Entrance = vector4(419.09197998047, -1735.5234375, 29.607698440552, 138.65339660645),
    },
    {
        Label = "Roy Lowenstein Blvd",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 410500,
        Entrance = vector4(431.12603759766, -1725.4888916016, 29.60146522522, 130.66041564941),
    },
    {
        Label = "Roy Lowenstein Blvd",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 400000,
        Entrance = vector4(443.39678955078, -1707.4189453125, 29.709320068359, 51.672836303711),
    },

    {
        Label = "Jamestown St",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 414000,
        Entrance = vector4(500.54440307617, -1697.3052978516, 29.78924369812, 146.02418518066),
    },
    {
        Label = "Jamestown St",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 415000,
        Entrance = vector4(489.75039672852, -1714.1022949219, 29.706886291504, 279.58682250977),
    },
    {
        Label = "Jamestown St",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 465000,
        Entrance = vector4(479.51379394531, -1735.6950683594, 29.151025772095, 156.91020202637),
    },
    {
        Label = "Jamestown St",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 486000,
        Entrance = vector4(474.53100585938, -1757.6560058594, 29.092626571655, 257.82635498047),
    },
    {
        Label = "Jamestown St",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 440000,
        Entrance = vector4(472.044921875, -1775.3715820313, 29.070844650269, 264.83950805664),
    },
    {
        Label = "Jamestown St",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 463000,
        Entrance = vector4(514.16613769531, -1780.7666015625, 28.913972854614, 87.402534484863),
    },
    {
        Label = "Jamestown St",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 469000,
        Entrance = vector4(512.45538330078, -1790.6047363281, 28.919464111328, 91.374404907227),
    },
    {
        Label = "Jamestown St",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 467000,
        Entrance = vector4(495.35040283203, -1823.2305908203, 28.869703292847, 318.53002929688),
    },

    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 790000,
        Entrance = vector4(1386.1041259766, -593.35308837891, 74.485458374023, 42.138191223145),
        Garage = {
            Entrance = vector3(1383.23, -597.99, 74.34),
            Exit = vector4(1384.095703125, -600.94555664063, 73.916427612305, 52.655994415283),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 796000,
        Entrance = vector4(1388.6883544922, -569.67761230469, 74.496513366699, 116.33405303955),
        Garage = {
            Entrance = vector3(1391.77, -574.2, 74.34),
            Exit = vector4(1393.2435302734, -575.51251220703, 73.917121887207, 115.33541870117),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 900000,
        Entrance = vector4(1373.2341308594, -555.63232421875, 74.685653686523, 68.267044067383),
        Garage = {
            Entrance = vector3(1365.92, -553.42, 74.34),
            Exit = vector4(1364.4161376953, -551.44213867188, 73.916076660156, 159.35493469238),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 965000,
        Entrance = vector4(1348.2521972656, -546.82513427734, 73.891639709473, 153.74267578125),
        Garage = {
            Entrance = vector3(1353.53, -548.55, 73.81),
            Exit = vector4(1355.7448730469, -548.02142333984, 73.360824584961, 156.09707641602),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 1000000,
        Entrance = vector4(1328.6737060547, -535.97027587891, 72.440818786621, 73.831573486328),
        Garage = {
            Entrance = vector3(1320.88, -532.5, 72.12),
            Exit = vector4(1319.3978271484, -531.65905761719, 71.695625305176, 159.94421386719),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 869000,
        Entrance = vector4(1303.1140136719, -527.48052978516, 71.460647583008, 160.47244262695),
        Garage = {
            Entrance = vector3(1308.78, -528.75, 71.31),
            Exit = vector4(1310.51171875, -528.64752197266, 70.891227722168, 161.67344665527),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 832000,
        Entrance = vector4(1251.0286865234, -515.52630615234, 69.349044799805, 260.00616455078),
        Garage = {
            Entrance = vector3(1248.73, -519.67, 68.99),
            Exit = vector4(1249.3428955078, -521.91528320313, 68.558227539063, 256.73248291016),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 925000,
        Entrance = vector4(1251.5303955078, -494.2336730957, 69.906867980957, 255.82321166992),
        Garage = {
            Entrance = vector3(1252.15, -489.88, 69.48),
            Exit = vector4(1255.0111083984, -491.27819824219, 69.026336669922, 256.01379394531),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 968000,
        Entrance = vector4(1259.6701660156, -480.10055541992, 70.188781738281, 296.09234619141),
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 932000,
        Entrance = vector4(1265.8002929688, -458.11877441406, 70.517082214355, 256.72717285156),
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 845000,
        Entrance = vector4(1262.4405517578, -429.91275024414, 70.014747619629, 294.05395507813),
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 387000,
        Entrance = vector4(1114.4361572266, -391.28491210938, 68.948249816895, 63.459892272949),
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 793000,
        Entrance = vector4(1060.6108398438, -378.39904785156, 68.231269836426, 226.62094116211),
        Garage = {
            Entrance = vector3(1058.56, -385.63, 67.95),
            Exit = vector4(1056.2574462891, -386.33493041992, 67.422286987305, 222.51823425293),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 869000,
        Entrance = vector4(1029.4360351563, -409.19476318359, 65.949279785156, 223.01438903809),
        Garage = {
            Entrance = vector3(1021.65, -415.35, 65.95),
            Exit = vector4(1020.9817504883, -416.67892456055, 65.515563964844, 218.78985595703),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 942000,
        Entrance = vector4(1010.5688476563, -423.36883544922, 65.349426269531, 303.60101318359),
        Garage = {
            Entrance = vector3(1010.87, -419.38, 64.95),
            Exit = vector4(1010.87109375, -417.19155883789, 64.525115966797, 217.74475097656),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 962000,
        Entrance = vector4(987.81072998047, -433.39453125, 63.890689849854, 217.45947265625),
        Garage = {
            Entrance = vector3(989.0, -439.69, 63.75),
            Exit = vector4(990.14135742188, -436.39709472656, 63.332057952881, 302.52703857422),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 972000,
        Entrance = vector4(967.12054443359, -451.77319335938, 62.789554595947, 216.89183044434),
        Garage = {
            Entrance = vector3(974.45, -448.71, 62.4),
            Exit = vector4(974.94006347656, -452.21493530273, 62.030826568604, 214.53494262695),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 932000,
        Entrance = vector4(944.46960449219, -463.09042358398, 61.554176330566, 130.42681884766),
        Garage = {
            Entrance = vector3(937.37, -464.82, 61.25),
            Exit = vector4(941.30999755859, -467.38116455078, 60.827445983887, 212.8302154541),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 872000,
        Entrance = vector4(921.88220214844, -477.75509643555, 61.083717346191, 200.72264099121),
        Garage = {
            Entrance = vector3(928.93, -476.34, 60.7),
            Exit = vector4(932.36059570313, -478.69488525391, 60.314968109131, 205.08000183105),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 760000,
        Entrance = vector4(906.32189941406, -489.37191772461, 59.436210632324, 202.36848449707),
        Garage = {
            Entrance = vector3(911.5, -487.26, 59.03),
            Exit = vector4(912.52111816406, -484.82244873047, 58.614841461182, 202.33706665039),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 1000000,
        Entrance = vector4(878.34265136719, -498.01712036133, 58.090614318848, 229.70051574707),
        Garage = {
            Entrance = vector3(874.74, -504.95, 57.5),
            Exit = vector4(874.74401855469, -506.98379516602, 57.062366485596, 228.62280273438),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 945000,
        Entrance = vector4(862.02008056641, -509.44064331055, 57.329608917236, 228.65156555176),
        Garage = {
            Entrance = vector3(857.21, -518.36, 57.33),
            Exit = vector4(856.86846923828, -520.00885009766, 56.90425491333, 228.12895202637),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 936000,
        Entrance = vector4(850.43182373047, -532.59869384766, 57.925514221191, 264.14221191406),
        Garage = {
            Entrance = vector3(847.98, -540.38, 57.33),
            Exit = vector4(848.98950195313, -541.8486328125, 56.90425491333, 266.74728393555),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 836000,
        Entrance = vector4(844.1064453125, -563.16796875, 57.833869934082, 191.45668029785),
        Garage = {
            Entrance = vector3(842.77, -569.8, 57.71),
            Exit = vector4(845.32348632813, -567.00823974609, 57.286701202393, 279.87799072266),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 945000,
        Entrance = vector4(861.71295166016, -583.28570556641, 58.156482696533, 0.18454177677631),
        Garage = {
            Entrance = vector3(866.99, -591.41, 58.27),
            Exit = vector4(870.53076171875, -591.32122802734, 57.762687683105, 315.32775878906),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 835000,
        Entrance = vector4(886.86676025391, -608.29736328125, 58.445079803467, 314.61752319336),
        Garage = {
            Entrance = vector3(872.46, -603.3, 58.22),
            Exit = vector4(872.55096435547, -600.15368652344, 57.78927230835, 315.95843505859),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 794000,
        Entrance = vector4(902.91149902344, -615.51788330078, 58.453338623047, 232.04138183594),
        Garage = {
            Entrance = vector3(910.4, -630.06, 58.05),
            Exit = vector4(914.41424560547, -628.71911621094, 57.62858581543, 317.91467285156),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 982000,
        Entrance = vector4(928.83813476563, -639.59460449219, 58.242500305176, 319.83908081055),
        Garage = {
            Entrance = vector3(915.11, -645.13, 57.86),
            Exit = vector4(915.88293457031, -641.53839111328, 57.44149017334, 321.42086791992),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 865000,
        Entrance = vector4(943.89190673828, -653.91674804688, 58.428665161133, 214.19473266602),
        Garage = {
            Entrance = vector3(947.37, -658.6, 58.01),
            Exit = vector4(948.74304199219, -655.14215087891, 57.588802337646, 308.11892700195),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 840000,
        Entrance = vector4(960.18450927734, -669.82757568359, 58.449817657471, 297.10980224609),
        Garage = {
            Entrance = vector3(957.6, -664.73, 58.01),
            Exit = vector4(954.45355224609, -664.29791259766, 57.590057373047, 296.82763671875),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 853000,
        Entrance = vector4(970.77661132813, -701.15234375, 58.481964111328, 354.53643798828),
        Garage = {
            Entrance = vector3(971.26, -689.67, 57.94),
            Exit = vector4(972.62060546875, -686.10388183594, 57.294498443604, 308.74618530273),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 875000,
        Entrance = vector4(979.23016357422, -716.38079833984, 58.220668792725, 312.40472412109),
        Garage = {
            Entrance = vector3(975.82, -712.86, 57.84),
            Exit = vector4(979.07171630859, -711.05798339844, 57.298141479492, 314.74212646484),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 945000,
        Entrance = vector4(996.94262695313, -729.52697753906, 57.815734863281, 309.34625244141),
        Garage = {
            Entrance = vector3(1003.35, -732.75, 57.46),
            Exit = vector4(1006.0002441406, -732.55261230469, 57.148178100586, 312.83990478516),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 763000,
        Entrance = vector4(1229.0061035156, -725.38372802734, 60.797962188721, 95.428619384766),
        Garage = {
            Entrance = vector3(1222.8, -723.43, 60.63),
            Exit = vector4(1224.9617919922, -726.59484863281, 60.121337890625, 174.73281860352),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 430000,
        Entrance = vector4(1222.6524658203, -696.93121337891, 60.806884765625, 96.455596923828),
        Garage = {
            Entrance = vector3(1228.25, -705.29, 60.67),
            Exit = vector4(1225.0422363281, -704.06951904297, 60.27123260498, 97.429496765137),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 465000,
        Entrance = vector4(1221.3962402344, -668.79565429688, 63.493137359619, 8.5403490066528),
        Garage = {
            Entrance = vector3(1220.26, -662.94, 63.12),
            Exit = vector4(1217.7581787109, -665.05474853516, 62.502216339111, 104.04373168945),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 434000,
        Entrance = vector4(1207.1829833984, -620.28167724609, 66.438621520996, 88.805953979492),
        Garage = {
            Entrance = vector3(1206.14, -610.32, 66.09),
            Exit = vector4(1199.5344238281, -612.76336669922, 64.445343017578, 94.678535461426),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 835500,
        Entrance = vector4(1203.5891113281, -598.52691650391, 68.063552856445, 177.13340759277),
        Garage = {
            Entrance = vector3(1192.13, -597.85, 64.0),
            Exit = vector4(1189.0231933594, -595.36291503906, 63.56413269043, 49.069026947021),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 968000,
        Entrance = vector4(1200.9609375, -575.66497802734, 69.139091491699, 130.75257873535),
        Garage = {
            Entrance = vector3(1189.54, -575.12, 64.3),
            Exit = vector4(1186.6994628906, -571.78179931641, 63.884838104248, 46.250427246094),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 491000,
        Entrance = vector4(1204.8908691406, -557.72204589844, 69.615165710449, 90.438461303711),
        Garage = {
            Entrance = vector3(1190.82, -555.96, 64.64),
            Exit = vector4(1188.6219482422, -552.68109130859, 64.149459838867, 83.222732543945),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 468000,
        Entrance = vector4(1241.6707763672, -566.20782470703, 69.65739440918, 317.24536132813),
        Garage = {
            Entrance = vector3(1238.99, -576.07, 69.49),
            Exit = vector4(1243.6872558594, -578.13812255859, 68.935180664063, 267.40142822266),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 465000,
        Entrance = vector4(1240.6134033203, -601.70123291016, 69.782676696777, 268.60272216797),
        Garage = {
            Entrance = vector3(1237.97, -588.02, 69.29),
            Exit = vector4(1238.1793212891, -585.55474853516, 68.894218444824, 269.54742431641),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 845000,
        Entrance = vector4(1265.5328369141, -648.16088867188, 67.921417236328, 25.549848556519),
        Garage = {
            Entrance = vector3(1267.37, -658.16, 67.78),
            Exit = vector4(1269.05078125, -659.67517089844, 67.328155517578, 292.13806152344),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 465000,
        Entrance = vector4(1240.6134033203, -601.70123291016, 69.782676696777, 268.60272216797),
        Garage = {
            Entrance = vector3(1237.97, -588.02, 69.29),
            Exit = vector4(1238.1793212891, -585.55474853516, 68.894218444824, 269.54742431641),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 410000,
        Entrance = vector4(1271.0595703125, -683.50604248047, 66.031608581543, 357.71975708008),
        Garage = {
            Entrance = vector3(1268.34, -675.47, 65.76),
            Exit = vector4(1271.0969238281, -672.873046875, 65.39582824707, 276.82217407227),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 425000,
        Entrance = vector4(1264.744140625, -702.82086181641, 64.909042358398, 239.03588867188),
        Garage = {
            Entrance = vector3(1260.9, -712.15, 64.51),
            Exit = vector4(1258.8684082031, -712.49145507813, 64.085815429688, 240.06326293945),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 847000,
        Entrance = vector4(1301.087890625, -574.02264404297, 71.732231140137, 342.80358886719),
        Garage = {
            Entrance = vector3(1295.41, -573.13, 71.63),
            Exit = vector4(1293.7185058594, -574.26306152344, 71.20775604248, 345.11572265625),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 995000,
        Entrance = vector4(1323.4853515625, -582.97967529297, 73.24634552002, 336.77545166016),
        Garage = {
            Entrance = vector3(1318.13, -581.31, 73.17),
            Exit = vector4(1315.9188232422, -582.35479736328, 72.651710510254, 333.56594848633),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 785000,
        Entrance = vector4(1341.4786376953, -597.43182373047, 74.700805664063, 201.78684997559),
        Garage = {
            Entrance = vector3(1343.4, -608.24, 74.35),
            Exit = vector4(1347.8944091797, -605.36279296875, 73.937294006348, 325.78057861328),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 875000,
        Entrance = vector4(1367.3645019531, -606.34594726563, 74.711013793945, 355.75231933594),
        Garage = {
            Entrance = vector3(1361.63, -607.17, 74.34),
            Exit = vector4(1359.9639892578, -609.04272460938, 73.916877746582, 357.27816772461),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 869000,
        Entrance = vector4(1100.8525390625, -411.24548339844, 67.555137634277, 87.450393676758),
        Garage = {
            Entrance = vector3(1100.93, -417.14, 67.16),
            Exit = vector4(1102.1422119141, -418.69226074219, 66.731781005859, 83.565872192383),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 445600,
        Entrance = vector4(1099.5297851563, -438.72967529297, 67.790557861328, 353.86572265625),
        Garage = {
            Entrance = vector3(1102.64, -427.89, 67.39),
            Exit = vector4(1099.3629150391, -429.33737182617, 66.945350646973, 77.594505310059),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 464000,
        Entrance = vector4(1098.4854736328, -464.66046142578, 67.319389343262, 163.62138366699),
        Garage = {
            Entrance = vector3(1097.87, -471.71, 66.94),
            Exit = vector4(1097.1604003906, -472.84994506836, 66.51252746582, 76.237434387207),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 375000,
        Entrance = vector4(1090.2791748047, -484.30456542969, 65.660385131836, 77.924690246582),
        Garage = {
            Entrance = vector3(1089.28, -493.44, 65.04),
            Exit = vector4(1086.0550537109, -494.51324462891, 64.089706420898, 77.306159973145),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 1000000,
        Entrance = vector4(1056.287109375, -448.77719116211, 66.257484436035, 348.541015625),
        Garage = {
            Entrance = vector3(1052.97, -444.95, 65.97),
            Exit = vector4(1055.8521728516, -444.1549987793, 65.545021057129, 259.3957824707),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 1900000,
        Entrance = vector4(1052.15234375, -470.67791748047, 63.898921966553, 256.70455932617),
        Garage = {
            Entrance = vector3(1048.84, -480.08, 64.17),
            Exit = vector4(1051.4011230469, -482.10205078125, 63.501800537109, 256.95938110352),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 1950000,
        Entrance = vector4(1046.4406738281, -497.80615234375, 64.079650878906, 1.8144191503525),
        Garage = {
            Entrance = vector3(1044.69, -488.85, 63.92),
            Exit = vector4(1047.93359375, -486.64013671875, 63.503219604492, 257.93511962891),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 1875000,
        Entrance = vector4(1006.0881958008, -511.34002685547, 60.833950042725, 122.4289932251),
        Garage = {
            Entrance = vector3(999.24, -511.86, 60.69),
            Exit = vector4(1002.7731933594, -513.59796142578, 60.27356338501, 203.95738220215),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 1900000,
        Entrance = vector4(988.07086181641, -526.01342773438, 60.690605163574, 209.68170166016),
        Garage = {
            Entrance = vector3(981.42, -529.25, 60.11),
            Exit = vector4(981.904296875, -533.19854736328, 59.675548553467, 212.49481201172),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 1952000,
        Entrance = vector4(965.17938232422, -541.85925292969, 59.72737121582, 212.73765563965),
        Garage = {
            Entrance = vector3(956.87, -547.34, 59.36),
            Exit = vector4(956.86285400391, -550.35882568359, 58.933570861816, 214.49168395996),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 1795000,
        Entrance = vector4(919.87042236328, -569.95770263672, 58.366363525391, 207.48721313477),
        Garage = {
            Entrance = vector3(924.42, -566.81, 57.96),
            Exit = vector4(925.43841552734, -565.09930419922, 57.54704284668, 206.09259033203),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 834000,
        Entrance = vector4(893.19555664063, -540.60931396484, 58.506656646729, 112.7360534668),
        Garage = {
            Entrance = vector3(894.99, -547.49, 58.14),
            Exit = vector4(891.41986083984, -551.02233886719, 57.684860229492, 115.19793701172),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 434000,
        Entrance = vector4(924.36669921875, -526.05517578125, 59.78902053833, 25.093212127686),
        Garage = {
            Entrance = vector3(918.69, -526.42, 59.22),
            Exit = vector4(915.73504638672, -522.75238037109, 58.313716888428, 25.834739685059),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 934000,
        Entrance = vector4(946.12731933594, -518.83770751953, 60.625526428223, 304.44915771484),
        Garage = {
            Entrance = vector3(951.96, -515.77, 60.24),
            Exit = vector4(947.86468505859, -511.7509765625, 59.801250457764, 29.660329818726),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 1000000,
        Entrance = vector4(970.27655029297, -502.28436279297, 62.140892028809, 76.635589599609),
        Garage = {
            Entrance = vector3(964.89, -506.09, 61.73),
            Exit = vector4(960.74334716797, -501.61123657227, 61.003730773926, 36.094551086426),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 500000,
        Entrance = vector4(1014.6639404297, -469.15936279297, 64.502983093262, 33.66580581665),
        Garage = {
            Entrance = vector3(1019.64, -463.85, 63.9),
            Exit = vector4(1020.2657470703, -461.78204345703, 63.50415802002, 39.284774780273),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 845000,
        Entrance = vector4(1009.9872436523, -572.57159423828, 60.594478607178, 248.32418823242),
        Garage = {
            Entrance = vector3(1009.72, -564.92, 60.2),
            Exit = vector4(1007.2276611328, -562.70153808594, 59.777835845947, 263.78518676758),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 435000,
        Entrance = vector4(999.54547119141, -594.05615234375, 59.638595581055, 264.05526733398),
        Garage = {
            Entrance = vector3(1004.31, -586.89, 59.13),
            Exit = vector4(1007.3701171875, -588.962890625, 58.676658630371, 260.34466552734),
        }
    },
    {
        Label = "Mirror Park",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 900000,
        Entrance = vector4(980.18988037109, -627.52838134766, 59.235858917236, 36.988765716553),
        Garage = {
            Entrance = vector3(978.92, -619.93, 58.88),
            Exit = vector4(975.84106445313, -618.16394042969, 58.421325683594, 127.93251037598),
        }
    },

    -- {
    --     Label = "Vespucci Canals",
    --     Type = "apartment",
    --     ShellType = "MidTierApartment",
    --     Price = 150000,
    --     Entrance = vector4(-1111.3977050781, -902.09094238281, 3.9866712093353, 123.71960449219),
    --     Garage = {
    --         Entrance = vector3(-1093.95, -894.19, 3.74),
    --         Exit = vector4(-1091.7443847656, -890.95916748047, 3.1628701686859, 303.58111572266),
    --     }
    -- },
    -- {
    --     Label = "Vespucci Canals",
    --     Type = "apartment",
    --     ShellType = "MidTierApartment",
    --     Price = 150000,
    --     Entrance = vector4(-1116.1359863281, -895.59014892578, 7.7968664169312, 122.674659729),
    --     Garage = {
    --         Entrance = vector3(-1093.95, -894.19, 3.74),
    --         Exit = vector4(-1091.7443847656, -890.95916748047, 3.1628701686859, 303.58111572266),
    --     }
    -- },
    -- {
    --     Label = "Vespucci Canals",
    --     Type = "apartment",
    --     ShellType = "MidTierApartment",
    --     Price = 150000,
    --     Entrance = vector4(-1111.5574951172, -902.13745117188, 7.7962112426758, 120.36539459229),
    --     Garage = {
    --         Entrance = vector3(-1093.95, -894.19, 3.74),
    --         Exit = vector4(-1091.7443847656, -890.95916748047, 3.1628701686859, 303.58111572266),
    --     }
    -- },
    -- {
    --     Label = "Vespucci Canals",
    --     Type = "apartment",
    --     ShellType = "MidTierApartment",
    --     Price = 150000,
    --     Entrance = vector4(-1116.1439208984, -895.56848144531, 11.796731948853, 122.90914916992),
    --     Garage = {
    --         Entrance = vector3(-1093.95, -894.19, 3.74),
    --         Exit = vector4(-1091.7443847656, -890.95916748047, 3.1628701686859, 303.58111572266),
    --     }
    -- },
    -- {
    --     Label = "Vespucci Canals",
    --     Type = "apartment",
    --     ShellType = "MidTierApartment",
    --     Price = 150000,
    --     Entrance = vector4(-1111.5649414063, -902.12438964844, 11.796731948853, 136.65661621094),
    --     Garage = {
    --         Entrance = vector3(-1093.95, -894.19, 3.74),
    --         Exit = vector4(-1091.7443847656, -890.95916748047, 3.1628701686859, 303.58111572266),
    --     }
    -- },

    {
        Label = "Banham Canyon",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 923300,
        Entrance = vector4(-3089.26953125, 221.15420532227, 14.118489265442, 325.74877929688),
        Garage = {
            Entrance = vector3(-3083.83, 217.34, 14.08),
            Exit = vector4(-3082.9577636719, 221.54261779785, 13.582268714905, 319.4140625),
        }
    },
    {
        Label = "Banham Canyon",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 845500,
        Entrance = vector4(-3111.7673339844, 315.27291870117, 8.3810396194458, 344.34976196289),
        Garage = {
            Entrance = vector3(-3100.84, 309.52, 8.38),
            Exit = vector4(-3096.5151367188, 306.50094604492, 7.8867654800415, 251.16775512695),
        }
    },
    {
        Label = "Banham Canyon",
        Type = "house",
        ShellType = "HighEndHouse",
        Price = 1950000,
        Entrance = vector4(-3093.6320800781, 349.25036621094, 7.5417971611023, 266.58477783203),
        Garage = {
            Entrance = vector3(-3094.1, 339.45, 7.47),
            Exit = vector4(-3090.0427246094, 341.17993164063, 7.0036106109619, 257.99157714844),
        }
    },

    {
        Label = "Paleto Bay",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 410000,
        Entrance = vector4(-374.5080871582, 6190.9975585938, 31.729545593262, 226.27130126953),
        Garage = {
            Entrance = vector3(-378.45, 6186.57, 31.49),
            Exit = vector4(-382.2209777832, 6187.9770507813, 31.068490982056, 224.43292236328),
        }
    },
    {
        Label = "Paleto Bay",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 435000,
        Entrance = vector4(-356.92840576172, 6207.431640625, 31.842277526855, 222.25115966797),
        Garage = {
            Entrance = vector3(-364.25, 6201.46, 31.58),
            Exit = vector4(-368.22463989258, 6200.9741210938, 31.071468353271, 224.27354431152),
        }
    },
    {
        Label = "Paleto Bay",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 445000,
        Entrance = vector4(-347.43676757813, 6225.3125, 31.884073257446, 221.16821289063),
        Garage = {
            Entrance = vector3(-360.07, 6225.82, 31.49),
            Exit = vector4(-355.12512207031, 6222.8549804688, 31.067260742188, 224.22999572754),
        }
    },
    {
        Label = "Paleto Bay",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 463000,
        Entrance = vector4(-360.19277954102, 6260.61328125, 31.900014877319, 315.63381958008),
        Garage = {
            Entrance = vector3(-353.99, 6269.75, 31.29),
            Exit = vector4(-358.64260864258, 6272.6376953125, 30.514547348022, 42.112678527832),
        }
    },
    {
        Label = "Paleto Bay",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 480000,
        Entrance = vector4(-407.33206176758, 6314.1220703125, 28.941242218018, 219.01210021973),
        Garage = {
            Entrance = vector3(-398.18, 6315.46, 28.72),
            Exit = vector4(-395.78555297852, 6311.4443359375, 28.563999176025, 219.82550048828),
        }
    },
    {
        Label = "Paleto Bay",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 494000,
        Entrance = vector4(-437.74911499023, 6272.2143554688, 30.068290710449, 334.44403076172),
        Garage = {
            Entrance = vector3(-435.0, 6268.46, 30.08),
            Exit = vector4(-432.33404541016, 6266.0610351563, 29.838171005249, 253.76879882813),
        }
    },
    {
        Label = "Paleto Bay",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 483000,
        Entrance = vector4(-448.12445068359, 6260.1640625, 30.047903060913, 159.21751403809),
        Garage = {
            Entrance = vector3(-438.0, 6259.32, 30.08),
            Exit = vector4(-433.95373535156, 6260.9873046875, 29.537002563477, 250.55282592773),
        }
    },
    {
        Label = "Paleto Bay",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 945000,
        Entrance = vector4(-454.89263916016, 6197.341796875, 29.552839279175, 269.96014404297),
        Garage = {
            Entrance = vector3(-442.95, 6205.65, 29.55),
            Exit = vector4(-440.39123535156, 6204.4619140625, 29.135217666626, 272.43374633789),
        }
    },
    {
        Label = "Paleto Bay",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 465000,
        Entrance = vector4(-379.94833374023, 6252.7387695313, 31.851190567017, 316.84979248047),
        Garage = {
            Entrance = vector3(-379.43, 6259.9, 31.48),
            Exit = vector4(-381.15512084961, 6265.0209960938, 30.670038223267, 18.547756195068),
        }
    },
    {
        Label = "Paleto Bay",
        Type = "house",
        ShellType = "ShitTier",
        Price = 190000,
        Entrance = vector4(-480.86428833008, 6266.2568359375, 13.634694099426, 154.3126373291),
        Garage = {
            Entrance = vector3(-480.41, 6258.05, 13.11),
            Exit = vector4(-482.89318847656, 6260.3916015625, 12.560727119446, 68.060897827148),
        }
    },
    {
        Label = "Paleto Bay",
        Type = "house",
        ShellType = "ShitTier",
        Price = 195000,
        Entrance = vector4(-453.25579833984, 6336.9765625, 13.109372138977, 35.600902557373),
        Garage = {
            Entrance = vector3(-441.41, 6337.34, 12.71),
            Exit = vector4(-441.72366333008, 6341.859375, 12.297927856445, 37.42391204834),
        }
    },
    {
        Label = "Paleto Bay",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 423000,
        Entrance = vector4(31.171766281128, 6596.6240234375, 32.822265625, 225.91596984863),
        Garage = {
            Entrance = vector3(40.93, 6602.18, 32.42),
            Exit = vector4(45.794639587402, 6602.2641601563, 31.58900642395, 227.34924316406),
        }
    },
    {
        Label = "Paleto Bay",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 444000,
        Entrance = vector4(11.44983959198, 6578.3872070313, 33.07080078125, 226.00604248047),
        Garage = {
            Entrance = vector3(12.62, 6590.73, 32.47),
            Exit = vector4(13.52583694458, 6586.0219726563, 32.048503875732, 225.16415405273),
        }
    },
    {
        Label = "Paleto Bay",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 845000,
        Entrance = vector4(-15.190487861633, 6557.3188476563, 33.240379333496, 313.79205322266),
        Garage = {
            Entrance = vector3(-13.73, 6567.37, 31.91),
            Exit = vector4(-11.446401596069, 6563.7260742188, 31.5361328125, 223.44731140137),
        }
    },
    {
        Label = "Paleto Bay",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 447000,
        Entrance = vector4(-44.378582000732, 6582.2607421875, 32.175518035889, 55.327323913574),
        Garage = {
            Entrance = vector3(-35.24, 6583.54, 31.16),
            Exit = vector4(-38.796657562256, 6590.615234375, 30.251884460449, 37.060569763184),
        }
    },
    {
        Label = "Paleto Bay",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 485000,
        Entrance = vector4(-26.504920959473, 6597.2661132813, 31.86078453064, 40.249176025391),
        Garage = {
            Entrance = vector3(-7.85, 6593.94, 31.47),
            Exit = vector4(-9.203688621521, 6598.919921875, 30.774534225464, 36.844203948975),
        }
    },
    {
        Label = "Paleto Bay",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 400000,
        Entrance = vector4(1.6505974531174, 6612.6704101563, 32.079624176025, 20.891548156738),
        Garage = {
            Entrance = vector3(-6.32, 6616.68, 31.47),
            Exit = vector4(-7.1580681800842, 6619.8178710938, 30.632242202759, 64.189521789551),
        }
    },
    {
        Label = "Paleto Bay",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 484000,
        Entrance = vector4(-41.706336975098, 6637.3842773438, 31.087535858154, 218.96961975098),
        Garage = {
            Entrance = vector3(-50.71, 6629.2, 30.04),
            Exit = vector4(-51.10778427124, 6620.8740234375, 29.244174957275, 177.26512145996),
        }
    },
    {
        Label = "Paleto Bay",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 415000,
        Entrance = vector4(-9.6278409957886, 6654.2104492188, 31.698720932007, 203.81793212891),
        Garage = {
            Entrance = vector3(-16.12, 6650.93, 31.15),
            Exit = vector4(-16.683511734009, 6645.8774414063, 30.697549819946, 207.81268310547),
        }
    },
    {
        Label = "Paleto Bay",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 447000,
        Entrance = vector4(35.261173248291, 6662.8920898438, 32.190391540527, 162.78071594238),
        Garage = {
            Entrance = vector3(23.82, 6666.81, 31.62),
            Exit = vector4(21.946628570557, 6661.1333007813, 30.828565597534, 181.18104553223),
        }
    },
    {
        Label = "Paleto Bay",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 945000,
        Entrance = vector4(-302.39248657227, 6327.01953125, 32.887233734131, 43.718784332275),
        Garage = {
            Entrance = vector3(-293.79, 6333.97, 32.51),
            Exit = vector4(-293.63687133789, 6338.5454101563, 31.907741546631, 48.710788726807),
        }
    },
    {
        Label = "Paleto Bay",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 465000,
        Entrance = vector4(-280.48883056641, 6350.7602539063, 32.600780487061, 42.257221221924),
        Garage = {
            Entrance = vector3(-271.49, 6355.6, 32.49),
            Exit = vector4(-272.25601196289, 6358.6201171875, 31.694803237915, 48.604610443115),
        }
    },
    {
        Label = "Paleto Bay",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 433000,
        Entrance = vector4(-247.61161804199, 6370.1215820313, 31.845541000366, 50.870235443115),
        Garage = {
            Entrance = vector3(-249.51, 6356.88, 31.49),
            Exit = vector4(-254.59434509277, 6359.8090820313, 31.055171966553, 44.734962463379),
        }
    },
    {
        Label = "Paleto Bay",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 465000,
        Entrance = vector4(-227.28067016602, 6377.671875, 31.759241104126, 43.244358062744),
        Garage = {
            Entrance = vector3(-221.1, 6380.75, 31.54),
            Exit = vector4(-220.2287902832, 6382.9560546875, 30.898498535156, 39.912166595459),
        }
    },
    {
        Label = "Paleto Bay",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 485000,
        Entrance = vector4(-213.61749267578, 6396.1870117188, 33.085083007813, 46.538276672363),
        Garage = {
            Entrance = vector3(-206.43, 6403.06, 31.86),
            Exit = vector4(-205.28016662598, 6405.1733398438, 31.43106842041, 43.310707092285),
        }
    },
    {
        Label = "Paleto Bay",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 434000,
        Entrance = vector4(-188.81634521484, 6409.6196289063, 32.296756744385, 41.733150482178),
        Garage = {
            Entrance = vector3(-184.96, 6412.66, 31.91),
            Exit = vector4(-187.43034362793, 6417.6274414063, 31.444631576538, 44.994358062744),
        }
    },
    {
        Label = "Paleto Bay",
        Type = "house",
        ShellType = "MidTierHouse",
        Price = 875000,
        Entrance = vector4(-229.61968994141, 6445.5615234375, 31.197429656982, 146.52374267578),
        Garage = {
            Entrance = vector3(-218.9, 6434.55, 31.2),
            Exit = vector4(-222.21365356445, 6434.2690429688, 30.778427124023, 228.62675476074),
        }
    },
    {
        Label = "Paleto Bay",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 455000,
        Entrance = vector4(-245.95329284668, 6414.4375, 31.460597991943, 132.5899810791),
        Garage = {
            Entrance = vector3(-254.29, 6408.66, 31.15),
            Exit = vector4(-249.87738037109, 6408.2163085938, 30.73729133606, 220.49345397949),
        }
    },
    {
        Label = "Paleto Bay",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 458000,
        Entrance = vector4(-272.5166015625, 6400.8471679688, 31.504953384399, 205.12957763672),
        Garage = {
            Entrance = vector3(-267.21, 6405.02, 30.89),
            Exit = vector4(-263.17767333984, 6402.92578125, 30.517518997192, 228.0154876709),
        }
    },

    {
        Label = "Grapeseed",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 423000,
        Entrance = vector4(1662.2340087891, 4776.2275390625, 42.007568359375, 276.61358642578),
        Garage = {
            Entrance = vector3(1658.82, 4769.16, 42.01),
            Exit = vector4(1661.3848876953, 4767.5034179688, 41.584281921387, 278.44049072266),
        }
    },
    {
        Label = "Grapeseed",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 415000,
        Entrance = vector4(1664.1120605469, 4739.6049804688, 42.008605957031, 290.5732421875),
        Garage = {
            Entrance = vector3(1666.73, 4750.49, 41.88),
            Exit = vector4(1669.3619384766, 4751.1181640625, 41.457389831543, 288.62084960938),
        }
    },
    {
        Label = "Grapeseed",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 465000,
        Entrance = vector4(1682.7689208984, 4689.4223632813, 43.065502166748, 265.93930053711),
        Garage = {
            Entrance = vector3(1679.14, 4682.89, 43.06),
            Exit = vector4(1682.8314208984, 4681.5629882813, 42.628776550293, 268.35357666016),
        }
    },
    {
        Label = "Grapeseed",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 489000,
        Entrance = vector4(1673.9361572266, 4658.26953125, 43.371562957764, 273.2532043457),
        Garage = {
            Entrance = vector3(1679.21, 4663.37, 43.37),
            Exit = vector4(1683.6885986328, 4662.8876953125, 42.939613342285, 281.79721069336),
        }
    },
    {
        Label = "Grapeseed",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 473000,
        Entrance = vector4(1719.0665283203, 4677.2880859375, 43.655788421631, 89.80249786377),
        Garage = {
            Entrance = vector3(1723.18, 4668.82, 43.33),
            Exit = vector4(1718.4938964844, 4668.560546875, 42.491695404053, 89.779029846191),
        }
    },
    {
        Label = "Grapeseed",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 459000,
        Entrance = vector4(1725.2503662109, 4642.4272460938, 43.875507354736, 117.9847869873),
        Garage = {
            Entrance = vector3(1729.35, 4633.87, 43.31),
            Exit = vector4(1727.1059570313, 4631.541015625, 42.878829956055, 115.97707366943),
        }
    },

    {
        Label = "Sandy Shores",
        Type = "house",
        ShellType = "Trailer",
        Price = 50000,
        Entrance = vector4(1932.7434082031, 3804.9089355469, 32.909896850586, 119.75730895996),
        Garage = {
            Entrance = vector3(1924.7, 3795.28, 32.4),
            Exit = vector4(1917.7199707031, 3801.2463378906, 31.786199569702, 51.723781585693),
        }
    },
    {
        Label = "Sandy Shores",
        Type = "house",
        ShellType = "ShitTier",
        Price = 190000,
        Entrance = vector4(1925.0974121094, 3824.5666503906, 32.439979553223, 209.89363098145),
        Garage = {
            Entrance = vector3(1921.36, 3817.83, 32.25),
            Exit = vector4(1921.2239990234, 3813.4318847656, 31.640661239624, 136.32733154297),
        }
    },
    {
        Label = "Sandy Shores",
        Type = "house",
        ShellType = "LowTierHouse",
        Price = 467000,
        Entrance = vector4(1880.7177734375, 3810.51953125, 32.778827667236, 301.85073852539),
        Garage = {
            Entrance = vector3(1891.6, 3809.13, 32.78),
            Exit = vector4(1896.9320068359, 3806.3034667969, 31.908288955688, 232.00399780273),
        }
    },
    {
        Label = "Sandy Shores",
        Type = "house",
        ShellType = "ShitTier",
        Price = 190000,
        Entrance = vector4(1899.8715820313, 3773.3076171875, 32.877891540527, 209.33392333984),
        Garage = {
            Entrance = vector3(1901.23, 3765.27, 32.58),
            Exit = vector4(1900.1539306641, 3762.1643066406, 32.015319824219, 145.45246887207),
        }
    },
    {
        Label = "Sandy Shores",
        Type = "house",
        ShellType = "ShitTier",
        Price = 195000,
        Entrance = vector4(1843.5111083984, 3778.0300292969, 33.585388183594, 122.58019256592),
        Garage = {
            Entrance = vector3(1851.99, 3773.14, 33.03),
            Exit = vector4(1848.5562744141, 3766.5610351563, 32.587394714355, 115.96964263916),
        }
    },
    {
        Label = "Sandy Shores",
        Type = "house",
        ShellType = "Trailer",
        Price = 50000,
        Entrance = vector4(1813.3977050781, 3854.248046875, 34.354457855225, 27.407646179199),
        Garage = {
            Entrance = vector3(1809.84, 3862.77, 33.89),
            Exit = vector4(1815.2778320313, 3870.5209960938, 33.192886352539, 329.76022338867),
        }
    },
    {
        Label = "Sandy Shores",
        Type = "house",
        ShellType = "Trailer",
        Price = 60000,
        Entrance = vector4(1832.6356201172, 3868.5358886719, 34.297473907471, 113.53884887695),
        Garage = {
            Entrance = vector3(1832.28, 3858.21, 33.57),
            Exit = vector4(1829.1721191406, 3860.2543945313, 32.959579467773, 23.491868972778),
        }
    },
    {
        Label = "Sandy Shores",
        Type = "house",
        ShellType = "Trailer",
        Price = 60000,
        Entrance = vector4(1777.4838867188, 3799.9641113281, 34.523124694824, 118.31066894531),
        Garage = {
            Entrance = vector3(1769.78, 3793.66, 33.88),
            Exit = vector4(1768.1968994141, 3787.6372070313, 33.138401031494, 203.60539245605),
        }
    },
    {
        Label = "Sandy Shores",
        Type = "house",
        ShellType = "ShitTier",
        Price = 190000,
        Entrance = vector4(1748.7967529297, 3783.5751953125, 34.83491897583, 122.90608978271),
        Garage = {
            Entrance = vector3(1739.9, 3779.12, 34.09),
            Exit = vector4(1735.5803222656, 3783.1176757813, 33.568439483643, 62.90425491333),
        }
    },
    {
        Label = "Sandy Shores",
        Type = "house",
        ShellType = "ShitTier",
        Price = 190000,
        Entrance = vector4(1733.6320800781, 3808.7185058594, 35.11812210083, 35.899345397949),
        Garage = {
            Entrance = vector3(1739.69, 3813.29, 34.74),
            Exit = vector4(1738.1480712891, 3814.9702148438, 33.922668457031, 113.43453216553),
        }
    },
    {
        Label = "Sandy Shores",
        Type = "house",
        ShellType = "Trailer",
        Price = 50000,
        Entrance = vector4(1700.1043701172, 3866.9614257813, 34.901550292969, 313.55102539063),
        Garage = {
            Entrance = vector3(1704.3010253906, 3877.1691894531, 34.912643432617),
            Exit = vector4(1702.8675537109, 3880.5791015625, 34.445571899414, 97.050369262695),
        }
    },
            ------------------------- VANAF HIER ZIJN CUSTOM LOCATIES / HIERVAN KLOPPEN DE GARAGE COORDS NIET-----------------------------------------
        --- LUXE HUIZEN ---
        {
            Label = "Rockford Hills 2836",
            Price = 2000000,
            Entrance = vector4(-579.7167, 733.3015, 184.2119, 5.8604),
            Type = "house",
            ShellType = "HighEndHouse",
            Garage = {
                Exit = vector4(-577.7557, 742.9626, 182.8555, 65.5921),
                Entrance = vector3(-577.4538, 738.8577, 183.8796),
            },
        },
        {
            Label = "Rockford Hills 2837",
            Price = 2500000,
            Entrance = vector4(-1025.7617, 360.3009, 71.3614, 251.4779),
            Type = "house",
            ShellType = "HighEndHouse",
            Garage = {
                Exit = vector4(-1044.8145, 387.0002, 68.4866, 9.6020),
                Entrance = vector3(-1044.7291, 382.2267, 69.6711),
            },
        },
        {
            Label = "Mansion van Daya",
            Price = 5000000,
            Entrance = vector4(-949.3950, 196.1242, 67.3906, 168.3917),
            Type = "house",
            ShellType = "HighEndHouse",
            Garage = {
                Exit = vector4(-930.7109, 209.8580, 66.4647, 124.5700),
                Entrance = vector3(-926.1320, 212.7830, 67.4645),
            },
        },
        {
            Label = "Playboy Mansion",
            Price = 5000000,
            Entrance = vector4(-1537.4137, 130.2984, 57.3713, 134.1666),
            Type = "house",
            ShellType = "HighEndHouse",
            Garage = {
                Exit = vector4(-1526.5984, 85.3031, 55.5713, 264.5102),
                Entrance = vector3(-1528.5203, 79.6363, 56.7187),
            },
        },
        {
            Label = "Richman Mansion 2",
            Price = 3500000,
            Entrance = vector4(-1549.1499, -90.6802, 54.9292, 338.8094),
            Type = "house",
            ShellType = "HighEndHouse",
            Garage = {
                Exit = vector4(-1574.6387, -82.1995, 53.1345, 286.1081),
                Entrance = vector3(-1581.1702, -86.2933, 54.1358),
            },
        },
        {
            Label = "Richman Mansion 3",
            Price = 2500000,
            Entrance = vector4(-1116.9680, 303.5049, 66.5213, 166.1115),
            Type = "house",
            ShellType = "HighEndHouse",
            Garage = {
                Exit = vector4(-1132.7925, 300.0341, 65.3166, 104.0389),
                Entrance = vector3(-1129.5658, 310.3703, 66.1776),
            },
        },
        {
            Label = "Richman Mansion 4",
            Price = 2500000,
            Entrance = vector4(-1189.4839, 291.1630, 69.6725, 211.7110),
            Type = "house",
            ShellType = "HighEndHouse",
            Garage = {
                Exit = vector4(-1204.2832, 268.4872, 68.5468, 276.1353),
                Entrance = vector3(-1210.3430, 271.1569, 69.5381),
            },
        },
        {
            Label = "Richman Mansion 5",
            Price = 2400000,
            Entrance = vector4(-876.4841, 305.9753, 84.1493, 242.3077),
            Type = "house",
            ShellType = "HighEndHouse",
            Garage = {
                Exit = vector4(-868.6036, 315.9968, 82.9773, 184.3701),
                Entrance = vector3(-869.0961, 322.1178, 83.9778),
            },
        },
        {
            Label = "Richman Mansion 4",
            Price = 2500000,
            Entrance = vector4(-881.7346, 364.1003, 85.3627, 51.1852),
            Type = "house",
            ShellType = "HighEndHouse",
            Garage = {
                Exit = vector4(-887.9166, 367.6884, 84.0332, 357.4968),
                Entrance = vector3(-888.2170, 361.7200, 85.0314),
            },
        },
        {
            Label = "Richman Mansion ",
            Price = 2500000,
            Entrance = vector4(-831.9200, 114.9661, 55.4203, 99.7259),
            Type = "house",
            ShellType = "HighEndHouse",
            Garage = {
                Exit = vector4(-837.9943, 113.4026, 54.2948, 190.2544),
                Entrance = vector3(-839.8657, 118.2559, 55.4313),
            },
        },
        {
            Label = "Huis van Jezus",
            Price = 5000000,
            Entrance = vector4(-766.3760, -24.2666, 41.0794, 212.3823),
            Type = "house",
            ShellType = "HighEndHouse",
            Garage = {
                Exit = vector4(-761.3052, -38.3245, 36.6850, 115.9116),
                Entrance = vector3(-762.6386, -22.9484, 41.0783),
            },
        },
        {
            Label = "Richman Mansion 6",
            Price = 2500000,
            Entrance = vector4(-841.5480, -25.1062, 40.3984, 268.9067),
            Type = "house",
            ShellType = "HighEndHouse",
            Garage = {
                Exit = vector4(-870.9195, -52.2630, 37.3839, 273.5899),
                Entrance = vector3(-875.8823, -56.7589, 38.0798),
            },
        },
        {
            Label = "Richman Mansion 7",
            Price = 2200000,
            Entrance = vector4(-888.2512, 42.5771, 49.1470, 228.2292),
            Type = "house",
            ShellType = "HighEndHouse",
            Garage = {
                Exit = vector4(-875.0548, 45.1240, 47.7593, 204.8054),
                Entrance = vector3(-876.0154, 49.9343, 48.7687),
            },
        },
        {
            Label = "Richman Mansion 8",
            Price = 2200000,
            Entrance = vector4(-913.8819, 108.2991, 55.5147, 82.8570),
            Type = "house",
            ShellType = "HighEndHouse",
            Garage = {
                Exit = vector4(-921.1522, 108.7964, 54.3236, 47.8244),
                Entrance = vector3(-917.7106, 114.2754, 55.3147),
            },
        },
        {
            Label = "Richman Mansion 9",
            Price = 2200000,
            Entrance = vector4(-1515.2595, 24.7863, 56.8207, 352.9246),
            Type = "house",
            ShellType = "HighEndHouse",
            Garage = {
                Exit = vector4(-1504.6053, 25.8874, 55.1030, 2.9494),
                Entrance = vector3(-1504.2706, 19.7392, 56.4060),
            },
        },
        {
            Label = "Richman Mansion 10",
            Price = 2200000,
            Entrance = vector4(-1570.6062, 22.7831, 59.5539, 345.5946),
            Type = "house",
            ShellType = "HighEndHouse",
            Garage = {
                Exit = vector4(-1555.2748, 23.3681, 57.5977, 332.5992),
                Entrance = vector3(-1558.0486, 17.8717, 58.8332),
            },
        },
        --- VINEWOOD HILLS ---
        {
            Label = "Vinewood Hill Mansion",
            Price = 2000000,
            Entrance = vector4(-85.8093, 834.6959, 235.9201, 99.7799),
            Type = "house",
            ShellType = "HighEndHouse",
            Garage = {
                Exit = vector4(-106.8329, 833.6848, 234.7222, 358.7070),
                Entrance = vector3(-101.7436, 824.3657, 235.7250),
            },
        },
        {
            Label = "Vinewood Hill Mansion 2",
            Price = 2000000,
            Entrance = vector4(-168.4478, 916.5857, 235.6556, 231.8576),
            Type = "house",
            ShellType = "HighEndHouse",
            Garage = {
                Exit = vector4(-132.7378, 902.3766, 234.7904, 256.6142),
                Entrance = vector3(-138.7640, 900.9394, 235.6572),
            },
        },
        {
            Label = "Vinewood Hill Mansion 3",
            Price = 2000000,
            Entrance = vector4(-184.1430, 967.8430, 232.1339, 173.7931),
            Type = "house",
            ShellType = "HighEndHouse",
            Garage = {
                Exit = vector4(-167.9964, 971.5638, 235.6769, 320.3634),
                Entrance = vector3(-171.9513, 966.7847, 237.4094),
            },
        },
    
        --- STRAND HUIZEN ---
        {
            Label = "Del Perro1",
            Price = 815000,
            Entrance = vector4(-1753.3328, -724.3630, 10.3885, 130.5546),
            Type = "house",
            ShellType = "MidTierHouse",
            Garage = {
                Exit = vector4(-1740.9507, -725.5176, 9.4406, 228.9146),
                Entrance = vector3(-1755.9080, -722.4684, 10.3420)
            },
        },
        {
            Label = "Del Perro2",
            Price = 825000,
            Entrance = vector4(-1777.3512, -701.8206, 10.4969, 320.6701),
            Type = "house",
            ShellType = "MidTierHouse",
            Garage = {
                Exit = vector4(-1776.7325, -706.6183, 9.2615, 225.3507),
                Entrance = vector3(-1780.0513, -701.5945, 10.3550)
            },
        },
        {
            Label = "Del Perro3",
            Price = 795000,
            Entrance = vector4(-1791.3174, -683.1846, 10.6413, 140.2376),
            Type = "house",
            ShellType = "MidTierHouse",
            Garage = {
                Exit = vector4(-1797.3219, -689.4068, 9.3269, 227.9833),
                Entrance = vector3(-1796.6306, -681.1977, 10.5727)
            },
        },
        {
            Label = "Del Perro4",
            Price = 860000,
            Entrance = vector4(-1800.4354, -667.0570, 10.5586, 40.7242),
            Type = "house",
            ShellType = "MidTierHouse",
            Garage = {
                Exit = vector4(-1807.9321, -680.0755, 9.3195, 225.3252),
                Entrance = vector3(-1808.0059, -672.3524, 10.6076)
            },
        },
        {
            Label = "Del Perro5",
            Price = 895000,
            Entrance = vector4(-1803.4790, -662.1924, 10.7241, 80.1328),
            Type = "house",
            ShellType = "MidTierHouse",
            Garage = {
                Exit = vector4(-1795.1155, -644.8840, 9.8817, 225.0995),
                Entrance = vector3(-1793.7395, -651.1429, 10.8203)
            },
        },
        {
            Label = "Del Perro6",
            Price = 935000,
            Entrance = vector4(-1828.3760, -653.5461, 10.7780, 329.7837),
            Type = "house",
            ShellType = "MidTierHouse",
            Garage = {
                Exit = vector4(-1831.0347, -660.4741, 9.3916, 224.4140),
                Entrance = vector3(-1830.6725, -653.9145, 10.6983)
            },
        },
        {
            Label = "Del Perro7",
            Price = 955000,
            Entrance = vector4(-1846.5374, -634.5806, 11.1610, 312.3169),
            Type = "house",
            ShellType = "MidTierHouse",
            Garage = {
                Exit = vector4(-1854.9550, -639.9236, 9.8631, 227.5098),
                Entrance = vector3(-1847.6176, -638.9826, 11.0283)
            },
        },
        {
            Label = "Del Perro8",
            Price = 797000,
            Entrance = vector4(-1836.9742, -631.5569, 10.7465, 322.2866),
            Type = "house",
            ShellType = "MidTierHouse",
            Garage = {
                Exit = vector4(-1825.6345, -623.7092, 10.1087, 320.2793),
                Entrance = vector3(-1829.5917, -624.9907, 10.9830)
            },
        },
        {
            Label = "Inseno Road",
            Price = 797000,
            Entrance = vector4(-3105.7434, 286.9488, 8.9721, 255.8336),
            Type = "house",
            ShellType = "MidTierHouse",
            Garage = {
                Exit = vector4(-3100.5920, 288.7603, 7.9773, 256.0722),
                Entrance = vector3(-3104.2778, 290.1029, 8.9721)
            },
        },
        {
            Label = "Inseno Road 2",
            Price = 797000,
            Entrance = vector4(-3105.2280, 246.8427, 12.4960, 262.2705),
            Type = "house",
            ShellType = "MidTierHouse",
            Garage = {
                Exit = vector4(-3102.2500, 250.8820, 11.0748, 277.4228),
                Entrance = vector3(-3106.1584, 250.8381, 12.4778)
            },
        },
        {
            Label = "Inseno Road 3",
            Price = 797000,
            Entrance = vector4(-3088.2825, 392.0968, 11.4501, 68.1423),
            Type = "house",
            ShellType = "MidTierHouse",
            Garage = {
                Exit = vector4(-3073.8713, 394.1117, 5.9685, 255.6784),
                Entrance = vector3(-3078.0854, 391.1810, 6.9685)
            },
        },
        {
            Label = "Continental",
            Price = 2000000,
            Entrance = vector4(-1464.8813, -34.2518, 55.0505, 304.1553),
            Type = "house",
            ShellType = "HighEndHouse",
            Garage = {
                Exit = vector4(-1459.9982, -29.2323, 53.6460, 242.6587),
                Entrance = vector3(-1467.1752, -29.7343, 54.6987)
            },
        },
        {
            Label = "420",
            Price = 1000000,
            Entrance = vector4(-1804.9562, 437.1554, 128.7076, 11.2793),
            Type = "house",
            ShellType = "HighEndHouse",
            Garage = {
                Exit = vector4(-1794.6216, 457.7789, 128.3082, 89.4317),
                Entrance = vector3(-1785.8333, 456.0836, 128.3082)
            },
        },
                ------------------------- VANAF HIER EINDIGEN DE CUSTOM LOCATIES -----------------------------------------
}
-- HighEndApartment, HighEndHouse, MidTierApartment, MidTierHouse, LowTierHouse, ShitTier, Trailer

Config.ShellSpawns = { -- every possible position for a shell to be spawned. default is 66 different spawns, meaning 66 people can be inside their house at the same time! You shouldn't mess around with this tbh.
    {coords = vector3(1020.0, 2000.0, -100.0)}, -- spawn #1
    {coords = vector3(1080.0, 2000.0, -100.0)}, -- spawn #2
    {coords = vector3(1140.0, 2000.0, -100.0)}, -- spawn #3
    {coords = vector3(1200.0, 2000.0, -100.0)}, -- spawn #4
    {coords = vector3(1260.0, 2000.0, -100.0)}, -- spawn #5
    {coords = vector3(1320.0, 2000.0, -100.0)}, -- spawn #6
    {coords = vector3(1380.0, 2000.0, -100.0)}, -- spawn #7
    {coords = vector3(1440.0, 2000.0, -100.0)}, -- spawn #8
    {coords = vector3(1500.0, 2000.0, -100.0)}, -- spawn #9
    {coords = vector3(1560.0, 2000.0, -100.0)}, -- spawn #10
    {coords = vector3(1620.0, 2000.0, -100.0)}, -- spawn #11
    {coords = vector3(1680.0, 2000.0, -100.0)}, -- spawn #12
    {coords = vector3(1740.0, 2000.0, -100.0)}, -- spawn #13
    {coords = vector3(1800.0, 2000.0, -100.0)}, -- spawn #14
    {coords = vector3(1860.0, 2000.0, -100.0)}, -- spawn #15
    {coords = vector3(1920.0, 2000.0, -100.0)}, -- spawn #16
    {coords = vector3(1980.0, 2000.0, -100.0)}, -- spawn #17
    {coords = vector3(2040.0, 2000.0, -100.0)}, -- spawn #18
    {coords = vector3(2100.0, 2000.0, -100.0)}, -- spawn #19
    {coords = vector3(2160.0, 2000.0, -100.0)}, -- spawn #20
    {coords = vector3(2220.0, 2000.0, -100.0)}, -- spawn #21
    {coords = vector3(2280.0, 2000.0, -100.0)}, -- spawn #22
    {coords = vector3(2340.0, 2000.0, -100.0)}, -- spawn #23
    {coords = vector3(2400.0, 2000.0, -100.0)}, -- spawn #24
    {coords = vector3(2460.0, 2000.0, -100.0)}, -- spawn #25
    {coords = vector3(2520.0, 2000.0, -100.0)}, -- spawn #26
    {coords = vector3(2580.0, 2000.0, -100.0)}, -- spawn #27
    {coords = vector3(2640.0, 2000.0, -100.0)}, -- spawn #28
    {coords = vector3(2700.0, 2000.0, -100.0)}, -- spawn #29
    {coords = vector3(2760.0, 2000.0, -100.0)}, -- spawn #30
    {coords = vector3(2820.0, 2000.0, -100.0)}, -- spawn #31
    {coords = vector3(2880.0, 2000.0, -100.0)}, -- spawn #32
    {coords = vector3(2940.0, 2000.0, -100.0)}, -- spawn #33

    {coords = vector3(1020.0, 2100.0, -100.0)}, -- spawn #34
    {coords = vector3(1080.0, 2100.0, -100.0)}, -- spawn #35
    {coords = vector3(1140.0, 2100.0, -100.0)}, -- spawn #36
    {coords = vector3(1200.0, 2100.0, -100.0)}, -- spawn #37
    {coords = vector3(1260.0, 2100.0, -100.0)}, -- spawn #38
    {coords = vector3(1320.0, 2100.0, -100.0)}, -- spawn #39
    {coords = vector3(1380.0, 2100.0, -100.0)}, -- spawn #40
    {coords = vector3(1440.0, 2100.0, -100.0)}, -- spawn #41
    {coords = vector3(1500.0, 2100.0, -100.0)}, -- spawn #42
    {coords = vector3(1560.0, 2100.0, -100.0)}, -- spawn #43
    {coords = vector3(1620.0, 2100.0, -100.0)}, -- spawn #44
    {coords = vector3(1680.0, 2100.0, -100.0)}, -- spawn #45
    {coords = vector3(1740.0, 2100.0, -100.0)}, -- spawn #46
    {coords = vector3(1800.0, 2100.0, -100.0)}, -- spawn #47
    {coords = vector3(1860.0, 2100.0, -100.0)}, -- spawn #48
    {coords = vector3(1920.0, 2100.0, -100.0)}, -- spawn #49
    {coords = vector3(1980.0, 2100.0, -100.0)}, -- spawn #50
    {coords = vector3(2040.0, 2100.0, -100.0)}, -- spawn #51
    {coords = vector3(2100.0, 2100.0, -100.0)}, -- spawn #52
    {coords = vector3(2160.0, 2100.0, -100.0)}, -- spawn #53
    {coords = vector3(2220.0, 2100.0, -100.0)}, -- spawn #54
    {coords = vector3(2280.0, 2100.0, -100.0)}, -- spawn #55
    {coords = vector3(2340.0, 2100.0, -100.0)}, -- spawn #56
    {coords = vector3(2400.0, 2100.0, -100.0)}, -- spawn #57
    {coords = vector3(2460.0, 2100.0, -100.0)}, -- spawn #58
    {coords = vector3(2520.0, 2100.0, -100.0)}, -- spawn #59
    {coords = vector3(2580.0, 2100.0, -100.0)}, -- spawn #60
    {coords = vector3(2640.0, 2100.0, -100.0)}, -- spawn #61
    {coords = vector3(2700.0, 2100.0, -100.0)}, -- spawn #62
    {coords = vector3(2760.0, 2100.0, -100.0)}, -- spawn #63
    {coords = vector3(2820.0, 2100.0, -100.0)}, -- spawn #64
    {coords = vector3(2880.0, 2100.0, -100.0)}, -- spawn #65
    {coords = vector3(2940.0, 2100.0, -100.0)}, -- spawn #66
}

if Config.REA then
    Config.Houses = {}
end