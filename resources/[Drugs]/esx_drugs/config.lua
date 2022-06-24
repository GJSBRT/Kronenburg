Config = {}

Config.Locale = 'en'

Config.Delays = {
	WeedProcessing = 100 * 5,
	MethProcessing = 200 * 20,
	CokeProcessing = 150 * 15,
	lsdProcessing = 10 * 10,
	HeroinProcessing = 120 * 10,
	thionylchlorideProcessing = 110 * 10,
}

Config.DrugDealerItems = {
	heroin = 546,
	weed_pooch = 784,
	meth = 1635,
	coke = 1027,
	lsd = 2178,
}

Config.ChemicalsConvertionItems = {
	hydrochloric_acid = 0,
	sodium_hydroxide = 0,
	sulfuric_acid = 0,
	lsa = 0,
}



Config.TimeToFarm    = 1.3 * 1000
Config.TimeToProcess = 3   * 1000
Config.TimeToSell    = 5 * 1000
-- default TimeToSell	= 1.3 * 1000

Config.RequiredCopsCoke  = 0
Config.RequiredCopsMeth  = 0
Config.RequiredCopsWeed  = 0
Config.RequiredCopsOpium = 0


Config.MarkerType   = 1
Config.DrawDistance = 7.0
Config.ZoneSize     = {x = 2.7, y = 2.7, z = 1.5}
Config.MarkerColor  = {r = 250, g = 0, b = 0}
Config.ShowBlips    = false  --markers visible on the map? (false to hide the markers on the map)

Config.Zones1 = {
	--WeedField =			{x = 1060.47, 	y = -3203.2, 	z = -40.16,	name = _U('weed_field'),		},
	--WeedProcessing =	{x = 1035.91, 	y = -3206.08, 	z = -39.00,	name = _U('weed_processing'),	sprite = 496,	color = 52},
	--WeedDealer =		{x = -25.43, 	y = -1426.65,    z = 29.80,	name = _U('weed_dealer'),		},
}

Config.ChemicalsLicenseEnabled = false --Will Enable or Disable the need for a Chemicals License.
Config.MoneyWashLicenseEnabled = false --Will Enable or Disable the need for a MoneyWash License.

Config.LicensePrices = {
	weed_processing = {label = _U('license_weed'), price = 15000}
}

Config.Licenses = {
	moneywash = 75000,
	chemicalslisence = 100000,
}


Config.UseItem = true

Config.GiveBlack = true -- give black money? if disabled it'll give regular cash.

Config.CircleZones = {

	-- pluk locaties
	--Weed
	WeedField = {coords = vector3(756.3222, 3016.5935, 47.5398), name = _U('blip_WeedFarm'), color = 25, sprite = 403, radius = 100.0},
--	WeedProcessing = {coords = vector3(-589.57, -1626.18, -33.01), name = _U('blip_weedprocessing'), color = 25, sprite = 403, radius = 100.0},
--	HydrochloricAcidFarm = {coords = vector3(2724.12, 1583.03, 24.5), name = _U('blip_HydrochloricAcidFarm'), color = 3, sprite = 403, radius = 7.0},
--	SulfuricAcidFarm = {coords = vector3(3333.34, 5160.22, 18.31), name = _U('blip_SulfuricAcidFarm'), color = 24, sprite = 403, radius = 5.0},
--	SodiumHydroxideFarm = {coords = vector3(2380.06, 3074.39, 48.16), name = _U('blip_SodiumHydroxideFarm'), color = 24, sprite = 403, radius = 7.0},
--	MoneyWash = {coords = vector3(2380.06, 3074.39, -4888.16), name = _U('blip_SodiumHydroxideFarm'), color = 24, sprite = 403, radius = 7.0},
	--Coke Field #1
	CokeField = {coords = vector3(1540.3903, -2646.7947, 41.2319), name = _U('blip_CokeFarm'), color = 4, sprite = 403, radius = 20.0},
--	HeroinField = {coords = vector3(5283.0293, -5751.5010, 18.7084), name = _U('blip_heroinfield'), color = 5, sprite = 403, radius = 50},
}

Config.Zones = {
	-- verpak / verkoop locaties
		cokeverpak =		{x = -617.0815,     y = -1623.3694,     z = 33.0106,	name = _U('coke_processing'),	       },
		CokeVerkoop =		{x = 29.8044,  y = -1832.6670,     z = 24.6007,	name = _U('coke_dealer'),	},
		MethProcessing =	{x = 936.2559,  y = -1517.1823,    z = 29.9978,	name = _U('meth_processing'),	},
		MethDealer =		{x = -2222.5828,    y = -366.2887,   z = 12.3212,	name = _U('meth_dealer'),	},
		WeedProcessing =	{x = 2221.41, 	y = 5614.16, 	z = 53.85,	name = _U('weed_processing'),  },
		WeedDealer =		{x = -1195.2449, 	y = -505.3494,    z = 34.5661,	name = _U('weed_dealer'),	},
}