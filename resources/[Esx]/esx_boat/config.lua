Config               = {}

Config.Locale        = 'en'

Config.LicenseEnable = true -- enable boat license? Requires esx_license
Config.LicensePrice  = 15000

Config.MarkerType    = 20
Config.DrawDistance  = 100.0

Config.Marker = {
	r = 255, g = 175, b = 0, -- blue-ish color
	x = 0.7, y = 0.7, z = 0.35 -- standard size circle
}

Config.StoreMarker = {
	r = 237, g = 41, b = 57,     -- red color
	x = 5.0, y = 5.0, z = 1.0  -- big circle for storing boat
}

Config.Zones = {

	Garages = {
		{ -- Shank St, nearby campaign boat garage
			GaragePos  = vector3(-772.4, -1430.9, 1.5),
			SpawnPoint = vector4(-785.39, -1426.3, 0.0, 146.0),
			StorePos   = vector3(-798.4, -1456.0, 0.0),
			StoreTP    = vector4(-791.4, -1452.5, 1.5, 318.9)
		},

		{ -- Catfish View
			GaragePos  = vector3(3864.9, 4463.9, 2.6),
			SpawnPoint = vector4(3854.4, 4477.2, 0.0, 273.0),
			StorePos   = vector3(3857.0, 4446.9, 0.0),
			StoreTP    = vector4(3854.7, 4458.6, 1.8, 355.3)
		},

		{ -- Great Ocean Highway
			GaragePos  = vector3(-1614.0, 5260.1, 3.8),
			SpawnPoint = vector4(-1622.5, 5247.1, 0.0, 21.0),
			StorePos   = vector3(-1600.3, 5261.9, 0.0),
			StoreTP    = vector4(-1605.7, 5259.0, 2.0, 25.0)
		},

		{ -- North Calafia Way
			GaragePos  = vector3(712.6, 4093.3, 34.7),
			SpawnPoint = vector4(712.8, 4080.2, 29.3, 181.0),
			StorePos   = vector3(705.1, 4110.1, 30.2),
			StoreTP    = vector4(711.9, 4110.5, 31.3, 180.0)
		},

		{ -- Elysian Fields, nearby the airport
			GaragePos  = vector3(23.8, -2806.8, 5.8),
			SpawnPoint = vector4(23.3, -2828.6, 0.8, 181.0),
			StorePos   = vector3(-1.0, -2799.2, 0.5),
			StoreTP    = vector4(12.6, -2793.8, 2.5, 355.2)
		},

--[[		{ -- Cayo kleine haven
		GaragePos  = vector3(4897.8, -5169.8, 2.6),
		SpawnPoint = vector4(4902.3, -5171, 0.8, 333.0),
		StorePos   = vector3(4894.6, -5165.78, 0.9),
		StoreTP    = vector4(4897.8, -5169.8, 1.6, 333.0)
		},

		{ -- Cayo grote haven achter
		GaragePos  = vector3(5124.4482, -4640.1504, 1.4056),
		SpawnPoint = vector4(5128.5229, -4642.4219, -0.3154, 156.6453),
		StorePos   = vector3(5120.7593, -4637.1230, -0.2044),
		StoreTP    = vector4(5124.4482, -4640.1504, 1.4056, 333.0)
		},]]

		{ -- Barbareno Rd
			GaragePos  = vector3(-3427.3, 956.9, 8.3),
			SpawnPoint = vector4(-3448.9, 953.8, 0.0, 75.0),
			StorePos   = vector3(-3436.5, 946.6, 0.3),
			StoreTP    = vector4(-3427.0, 952.6, 8.3, 0.0)
		}
	},

	BoatShops = {
		{ -- Shank St, nearby campaign boat garage
			Outside = vector3(-773.7, -1495.2, 2.6),
			Inside = vector4(-798.5, -1503.1, -0.4, 120.0)
		}
	}

}

Config.Vehicles = {
	{model = 'seashark', label = 'Seashark (Random Color)', price = 7500},
	{model = 'seashark3', label = 'Seashark (Dark Blue)', price = 7500},
	{model = 'suntrap', label = 'Suntrap', price = 45000},
	{model = 'jetmax', label = 'Jetmax', price = 145000},
	{model = 'tropic2', label = 'Tropic', price = 55000},
	{model = 'speeder', label = 'Speeder', price = 185000},
	{model = 'squalo', label = 'Squalo (Random Color)', price = 71000},
	{model = 'toro', label = 'Toro', price = 200000},
	{model = 'longfin', label = 'Longfin', price = 300000},
	{model = 'avisa', label = 'Avisa', price = 2000000}
}