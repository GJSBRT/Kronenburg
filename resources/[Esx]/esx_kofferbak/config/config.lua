--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
--Truck
Config	=	{}

 -- Limit, unit can be whatever you want. Originally grams (as average people can hold 25kg)
Config.Limit = 20000

-- Default weight for an item:
	-- weight == 0 : The item do not affect character inventory weight
	-- weight > 0 : The item cost place on inventory
	-- weight < 0 : The item add place on inventory. Smart people will love it.
Config.DefaultWeight = 1000



-- If true, ignore rest of file
Config.WeightSqlBased = false

-- I Prefer to edit weight on the config.lua and I have switched Config.WeightSqlBased to false:

Config.localWeight = {
    alive_chicken           = 500,
    slaughtered_chicken     = 500,
    packaged_chicken        = 500,
    fish                    = 500,
    stone                   = 500,
    washed_stone            = 500,
    copper                  = 500,
    iron                    = 500,
    gold                    = 500,
    diamond                 = 500,
    wood                    = 500,
    cutted_wood             = 500,
    packaged_plank          = 500,
    petrol                  = 500,
    petrol_raffin           = 500,
    essence                 = 500,
    wool                    = 500,
    fabric                  = 500,
    clothe                  = 500,

    water                   = 500,
    bread                   = 500,
    contrat                 = 1000,
    cutting_pliers          = 500,
    handcuff                = 500,
    bandage                 = 500,
    medikit                 = 1000,
    radio                   = 1000,
    phone                   = 1000,
    weed                    = 1000,
    weed_pooch              = 1000,
    coke                    = 1000,
    coke_pooch              = 1000,
    meth                    = 1000,
    meth_pooch              = 1000,
    opium                   = 1000,
    opium_pooch             = 1000,
    meat                    = 500,
    leather                 = 500,
    firstaidkit             = 1500,
    defibrillateur          = 5000,
    gazbottle               = 500,
    fixtool                 = 8000,
    carotool                = 8000,
    blowpipe                = 1000,
    fixkit                  = 1000,
    carokit                 = 1000,
    fishbait                = 1000,
    fishingrod              = 500,
    shark                   = 1000,
    turtle                  = 1000,
    turtlebait              = 1000,
    clip                    = 5000,
    pizza                   = 500,
    scratchoff              = 10,
    scratchoff_used         = 10,
    jewels                  = 2000,
    WEAPON_NIGHTSTICK       = 100000000,
    WEAPON_PISTOL50         = 1000,
    WEAPON_ASSAULTRIFLE     = 10000,
    WEAPON_MICROSMG         = 5000,
    WEAPON_SMG              = 100000000,
    WEAPON_STUNGUN          = 100000000,
    WEAPON_FLASHLIGHT       = 100000000,
    WEAPON_FLAREGUN         = 100000000,
    WEAPON_FLARE            = 100000000,
    WEAPON_COMBATPISTOL     = 100000000,
    WEAPON_HEAVYPISTOL      = 100000000,
    WEAPON_ASSAULTSMG       = 100000000,
    WEAPON_COMBATPDW        = 100000000,
    WEAPON_BULLPUPRIFLE     = 100000000,
    WEAPON_PUMPSHOTGUN      = 100000000,
    WEAPON_COMPACTRIFLE     = 10000,
    WEAPON_BULLPUPSHOTGUN   = 100000000,
    WEAPON_CARBINERIFLE     = 100000000,
    WEAPON_ADVANCEDRIFLE    = 100000000,
    WEAPON_MARKSMANRRIFLE   = 100000000,
    WEAPON_SNIPERRIFLE      = 100000000,
    WEAPON_FIREEXTINGUISHER = 100000000, 
    GADGET_PARACHUTE        = 1000,
    WEAPON_BAT              = 1000,
    WEAPON_PISTOL           = 1000,
    WEAPON_PISTOL_MK2          = 1000,
    money                   = 10,
	black_money             = 10,
    repairkit               = 50000,
}

Config.VehicleLimit = {
    [0] = 30000, --Compact
    [1] = 40000, --Sedan
    [2] = 50000, --SUV
    [3] = 40000, --Coupes
    [4] = 40000, --Muscle
    [5] = 30000, --Sports Classics
    [6] = 10000, --Sports
    [7] = 10000, --Super
    [8] = 500, --Motorcycles
    [9] = 60000, --Off-road
    [10] = 200000, --Industrial
    [11] = 75000, --Utility
    [12] = 75000, --Vans
    [13] = 0, --Cycles
    [14] = 75000, --Boats
    [15] = 75000, --Helicopters
    [16] = 250000, --Planes
    [17] = 75000, --Service
    [18] = 10000, --Emergency
    [19] = 0, --Military
    [20] = 200000, --Commercial
    [21] = 0, --Trains
}


Config.PoliceWeapons = {
    [`WEAPON_PISTOL_MK2`] = true,
    [`WEAPON_SMG`] = true,
    [`WEAPON_NIGHTSTICK`] = true,
    [`WEAPON_COMBATPISTOL`] = true,
    [`WEAPON_PISTOL`] = true,
    [`WEAPON_PISTOL50`] = true,
    [`WEAPON_CARBINERIFLE`] = true,
    [`WEAPON_SAWNOFFSHOTGUN`] = true,
    [`WEAPON_COMPACTRIFLE`] = true,
    [`WEAPON_SNIPERRIFLE`] = true,
    [`WEAPON_STUNGUN`] = true,
    [`WEAPON_ASSAULTRIFLE`] = true,
    [`WEAPON_KNUCKLEDUSTER`] = true,
    [`WEAPON_MINISMG`] = true,
    [`WEAPON_MICROSMG`] = true,
    [`WEAPON_BAT`] = false,
    [`WEAPON_SWITCHBLADE`] = false,

}


Config.ModelLimit = {
    [`NSPEEDO`] = 750000,
    [`YOUGA3`] = 200000,
    [`SQUALO`] = 10000,
    [`SPEEDER`] = 10000,
    [`TORO`] = 180000,
    [`LONGFIN`] = 300000,
    [`speedo2`] = 750000,
    [`MARQUIS`] = 130000,
    [`predator108`] = 1500000,
    [`havok`] = 50000,
    [`frogger`] = 150000,
    [`maverick`] = 130000,
    [`volatus`] = 180000,
    [`cuban800`] = 200000,
    [`mammatus`] = 220000,
    [`velum`] = 230000,
    [`dodo`] = 240000,
    [`shamal`] = 380000,
    [`mule`] = 400000,
    [`yosemite3`] = 100000,
    [`rmode63s`] = 30000,
    [`rs620`] = 30000,
    [`16charger`] = 30000,
    [`16m5`] = 30000,
    [`18performante`] = 20000,
    [`18Velar`] = 30000,
    [`440i`] = 30000,
    [`720s`] = 30000,
    [`750li`] = 30000,
    [`911tbs`] = 30000,
    [`alpinab7`] = 30000,
    [`amgbs`] = 30000,
    [`AUDIRS6TK`] = 30000,
    [`audis8om`] = 30000,
    [`divo`] = 30000,
    [`ben17`] = 30000,
    [`bentaygast`] = 30000,
    [`blazer4`] = 10000,
    [`BMCI`] = 30000,
    [`bmm`] = 30000,
    [`bmwm8`] = 30000,
    [`bmws`] = 30000,
    [`brabus500`] = 10000,
    [`c8`] = 10000,
    [`chiron5`] = 10000,
    [`cliffhanger`] = 10000,
    [`demon`] = 10000,
    [`demonhawkk`] = 10000,
    [`e63sf`] = 10000,
    [`f40`] = 10000,
    [`faggio2`] = 10000,
    [`flhxs_streetglide_special18`] = 10000,
    [`golfgti7`] = 10000,
    [`gsxr`] = 10000,
    [`gt17`] = 10000,
    [`gtmustang`] = 10000,
    [`gtr`] = 10000,
    [`gxg63`] = 10000,
    [`HDIron883`] = 10000,
    [`hevo`] = 10000,
    [`I8`] = 10000,
    [`jaguarcx75`] = 10000,
    [`jaguarfpace`] = 10000,
    [`kuruma`] = 30000,
    [`lamboavj`] = 30000,
    [`lwcla45`] = 30000,
    [`m3e30`] = 30000,
    [`m4LB`] = 30000,
    [`manchez`] = 10000,
    [`mesa2`] = 10000,
    [`mig`] = 10000,
    [`ninjah2`] = 10000,
    [`p7`] = 10000,
    [`pcs18`] = 10000,
    [`phantom8`] = 30000,
    [`phantom`] = 300000,
    [`pista`] = 30000,
    [`polo2018`] = 30000,
    [`por718gt4`] = 30000,
    [`pturismo`] = 30000,
    [`Q7`] = 30000,
    [`r1`] = 10000,
    [`r820`] = 30000,
    [`rhapsody`] = 30000,
    [`rmodbentley1`] = 30000,
    [`rmodbentleygt`] = 30000,
    [`rmodgt63`] = 30000,
    [`rmodgtr50`] = 30000,
    [`rmodlp770`] = 30000,
    [`rmodmk7`] = 30000,
    [`RS3`] = 40000,
    [`rs6c8`] = 30000,
    [`schafter2`] = 30000,
    [`seven70`] = 10000,
    [`skyline`] = 30000,
    [`supra2`] = 30000,
    [`tmax`] = 10000,
    [`urus`] = 30000,
    [`vantage`] = 30000,
    [`veneno`] = 30000,
    [`x6m`] = 50000,
    [`yz450f`] = 10000,
    [`z1000`] = 10000,
    [`zl12017`] = 10000,
    [`manchez2`] = 10000,
    [`yosemite3`] = 80000,
    [`youga3`] = 110000,
    [`brutus`] = 10000,
    [`vetir`] = 200000,
    [`verus`] = 20000,
    [`bfinjection`] = 40000,
    [`kamacho`] = 90000,
    [`mesa3`] = 60000,
    [`outlaw`] = 40000,
    [`seashark`] = 40000,
    [`seashark2`] = 40000,
    [`seashark3`] = 40000,
    [`zx10r`] = 10000,
    [`zx10`] = 10000,
    [`sanchez`] = 10000,
    [`africat`] = 10000, 
    [`suntrap`] = 70000, 
    [`raptor2017`] = 90000, 
    [`DUBSTA3`] = 150000,
    [`nissantitan17`] = 90000, 
    [`supervolito`] = 125000,
    [`SUPERVOLITO2`] = 125000,
    [`wraithb`] = 100000,


}

--[[
Config.ModelLimit = {
    -- Ik zet in plugin de DisplayName volledig om naar hoofdletters, om dus misverstanden te voorkomen
    --- Helikopters
    [`HAVOK`] = { classModifier = 0.2, model = "HAVOK" },
    [`MICROLIGHT`] = { classModifier = 0.1, model = "MICROLIGHT" },
    [`SEASPARROW`] = { classModifier = 0.7, model = "SEASPARROW" },
    [`MAVERICK`] = { classModifier = 1.2, model = "MAVERICK" },
    [`FROGGER`] = { classModifier = 1.6, model = "FROGGER" },
    [`SUPERVOLITO`] = { classModifier = 2.0, model = "SUPERVOLITO" },
    [`SUPERVOLITO2`] = { classModifier = 2.2, model = "SUPERVOLITO2" },
    [`SWIFT`] = { classModifier = 3.75, model = "SWIFT" },
    [`VOLATUS`] = { classModifier = 4.5, model = "VOLATUS" },
    [`SWIFT2`] = { classModifier = 5.0, model = "SWIFT2" },
    --- Boten
    [`seashark`] =      { classModifier = 0.2, model = "SEASHARK" },
    [`suntrap`] =       { classModifier = 0.8, model = "SUNTRAP" },
    [`dinghy2`] =       { classModifier = 0.4, model = "DINGHY2" },
    [`dinghy3`] =       { classModifier = 0.4, model = "DINGHY3" },
    [`jetmax`] =        { classModifier = 1.4, model = "JETMAX" },
    [`squalo`] =        { classModifier = 1.6, model = "SQUALO" },
    [`tropic2`] =       { classModifier = 1.4, model = "TROPIC2" },
    [`speeder`] =       { classModifier = 2.3, model = "SPEEDER" },
    [`toro`] =          { classModifier = 3.4, model = "TORO" },
    [`longfin`] =       { classModifier = 6.0, model = "LONGFIN" },
    [`submersible`] =   { classModifier = 2.5, model = "SUBMERSIBLE" },
    [`avisa`] =         { classModifier = 3.0, model = "AVISA" },
    --- Vliegtuigen
    [`DODO`] = { classModifier = 0.5, model = "DODO" },
    [`DUSTER`] = { weight = 50000, model = "DUSTER" },
    [`STUNT`] = { weight = 25000, model = "STUNT" },
    [`VELUM`] = { classModifier = 0.5, model = "VELUM" },
    [`MAMMATUS`] = { classModifier = 0.6, model = "MAMMATUS" },
    [`CUBAN800`] = { classModifier = 0.75, model = "CUBAN800" },
    --- Trailers
    [`TRAILERSMALL`] = { weight = 60000, model = "TRAILERSMALL" },
    [`BOATTRAILER`] = { weight = 60000, model = "BOATTRAILER" },
    --- Circuit auto's
    [`RMODM8GTE`] = { weight = 20000, model = "RMODM8GTE" },
    [`911GT3R`] = { weight = 20000, model = "911GT3R" },
    [`R8LMS`] = { weight = 20000, model = "R8LMS" },
    [`LHGT3`] = { weight = 20000, model = "LHGT3" },
    [`RMP4`] = { weight = 20000, model = "RMP4" },
    [`FGT3`] = { weight = 20000, model = "FGT3" },
    [`C7R`] = { weight = 20000, model = "C7R" },
    --- Voertuigen
    [`RUMPO`] = { weight = 130000, model = "RUMPO" },
    [`RUMPO2`] = { weight = 130000, model = "RUMPO2" },
    [`RUMPO3`] = { weight = 130000, model = "RUMPO3" },
    [`NISSANTITAN17`] = { weight = 130000, model = "NISSANTITAN17" },
    [`RAPTOR2017`] = { weight = 130000, model = "RAPTOR2017" },
    [`DUBSTA3`] = { weight = 150000, model = "DUBSTA3" },
    [`LADA2107`] = { weight = 60000, model = "LADA2107" },
    [`DUBSTA`] = { weight = 80000, model = "DUBSTA" },
    [`GUARDIAN`] = { weight = 140000, model = "GUARDIAN" },
    [`SEASHARK`] = { weight = 10000, model = "SEASHARK" },
    [`A45`] = { weight = 60000, model = "A45" },
    [`BAC2`] = { weight = 5000, model = "BAC2" },
    [`BALLER`] = { weight = 40000, model = "BALLER" },
    [`BARRACKS`] = { weight = 100000, model = "BARRACKS" },
    [`BLAZER`] = { weight = 30000, model = "BLAZER" },
    [`BLAZER2`] = { weight = 30000, model = "BLAZER2" },
    [`BLAZER3`] = { weight = 30000, model = "BLAZER3" },
    [`BLAZER4`] = { weight = 30000, model = "BLAZER4" },
    [`DUNE`] = { weight = 40000, model = "DUNE" },
    [`RAM2500LIFTED`] = { weight = 130000, model = "RAM2500LIFTED" },
    [`PHANTOM`] = { weight = 175000, model = "PHANTOM" },
    [`TESLAX`] = { weight = 40000, model = "TESLAX" },
    [`TAXI`] = { weight = 0, model = "TAXI" },
    [`TAXI2`] = { weight = 0, model = "TAXI2" },
    [`NSPEEDO`] = { weight = 5000, model = "NSPEEDO" },
    [`BIFTA`] = { weight = 40000, model = "bifta" },
    [`G65AMG`] = { weight = 100000, model = "G65AMG" },
    [`W463A1`] = { weight = 100000, model = "W463A1" },
    [`FLATBEDP`] = { weight = 1000000, model = "FLATBEDP" },
    [`POLMAV`] = { weight = 1000000, model = "POLMAV" },
    [`VERUS`] = { weight = 30000, model = "VERUS" },
    [`WINKY`] = { weight = 60000, model = "WINKY" },
    [`YOUGA3`] = { weight = 130000, model = "YOUGA3" },
    [`YOUSEMITE3`] = { weight = 75000, model = "yousemite3" },
    [`SEMINOLE2`] = { weight = 50000, model = "SEMINOLE2" },
    [`VETIR`] = { weight = 150000, model = "VETIR" },
    [`REBEL`] = { weight = 75000, model = "REBEL" },
    [`SQUADDIE`] = { weight = 75000, model = "SQUADDIE" },
    [`KAMACHO`] = { weight = 115000, model = "KAMACHO" },
    [`DUNELOADER`] = { weight = 90000, model = "DUNELOADER" },
    [`OUTLAW`] = { weight = 40000, model = "OUTLAW" },
    [`POLICE2`] = { weight = 200000, model = "POLICE2" },
    --- Cayo Perico - Narcopolis update
    [`RMODP1GTR2020`] = { weight = 20000, model = "RMODP1GTR2020" },
    [`RMODQUADRA`] = { weight = 20000, model = "RMODQUADRA" },
    [`RMODBOLIDE`] = { weight = 20000, model = "RMODBOLIDE" },
    [`RMODF40`] = { weight = 20000, model = "RMODF40" },
    [`RMODSIANR`] = { weight = 20000, model = "RMODSIANR" },
    [`mercxclass`] = { weight = 130000, model = "mercxclass" },
    [`bfinjection`] = { weight = 30000, model = "bfinjection" },
}]]