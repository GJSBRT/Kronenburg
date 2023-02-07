--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
--[[ DUMPED USING FIVEX
Config = {}
Config.Blip			= {sprite= 524, color = 30}
Config.BoatBlip		= {sprite= 410, color = 30}
Config.AirplaneBlip	= {sprite= 473, color = 188}
Config.MecanoBlip	= {sprite= 524, color = 26}
Config.Price		= 500 -- pound price to get vehicle back
Config.SwitchGaragePrice		= 500 -- price to pay to switch vehicles in garage
Config.StoreOnServerStart = true -- Store all vehicles in garage on server start?
Config.Locale = 'en'

Config.Garages = {
	Garage_Centre = {
		Pos = {x=215.800, y=-810.057, z=30.727},
		Marker = { w= 1.2, h= 0.3,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x=229.700, y= -800.1149, z= 30.57},
			Heading = 160.0,
			Marker = { w= 1.2, h= 0.3,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x=215.124, y=-791.377, z=30.83},
			Marker = { w= 1.5, h= 0.3,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
		SpawnPoints = {
			-- Rij 1 vanaf weg
			{ coords = vector3(203.52, -799.98, 29.78), heading = 249.50, radius = 4.0, space = 0.0 },
			{ coords = vector3(204.51, -797.57, 29.78), heading = 249.50, radius = 4.0, space = 0.0 },
			{ coords = vector3(205.49, -795.16, 29.78), heading = 249.50, radius = 4.0, space = 0.0 },
			{ coords = vector3(206.50, -792.73, 29.78), heading = 249.50, radius = 4.0, space = 0.0 },
			{ coords = vector3(207.30, -790.10, 29.78), heading = 249.50, radius = 4.0, space = 0.0 },
			{ coords = vector3(208.34, -787.64, 29.78), heading = 249.50, radius = 4.0, space = 0.0 },
			{ coords = vector3(209.19, -785.19, 29.78), heading = 249.50, radius = 4.0, space = 0.0 },
			{ coords = vector3(210.18, -782.68, 29.78), heading = 249.50, radius = 4.0, space = 0.0 },
			{ coords = vector3(211.09, -780.14, 29.78), heading = 249.50, radius = 4.0, space = 0.0 },
			{ coords = vector3(212.05, -777.68, 29.78), heading = 249.50, radius = 4.0, space = 0.0 },
			{ coords = vector3(212.91, -775.04, 29.78), heading = 249.50, radius = 4.0, space = 0.0 },
			{ coords = vector3(213.92, -772.61, 29.78), heading = 249.50, radius = 4.0, space = 0.0 },
			{ coords = vector3(214.77, -770.07, 29.78), heading = 249.50, radius = 4.0, space = 0.0 },
			{ coords = vector3(215.71, -767.55, 29.78), heading = 249.50, radius = 4.0, space = 0.0 },
			{ coords = vector3(216.71, -765.18, 29.78), heading = 249.50, radius = 4.0, space = 0.0 },
			-- Rij 2 vanaf weg
			{ coords = vector3(230.41, -769.72, 29.78), heading =  69.50, radius = 4.0, space = 0.0 },
			{ coords = vector3(229.46, -772.27, 29.77), heading =  69.50, radius = 4.0, space = 0.0 },
			{ coords = vector3(228.55, -774.82, 29.77), heading =  69.50, radius = 4.0, space = 0.0 },
			{ coords = vector3(227.58, -777.38, 29.75), heading =  69.50, radius = 4.0, space = 0.0 },
			{ coords = vector3(226.60, -779.85, 29.74), heading =  69.50, radius = 4.0, space = 0.0 },
			{ coords = vector3(225.70, -782.30, 29.74), heading =  69.50, radius = 4.0, space = 0.0 },
			{ coords = vector3(224.60, -784.88, 29.74), heading =  69.50, radius = 4.0, space = 0.0 },
			{ coords = vector3(223.83, -787.53, 29.74), heading =  69.50, radius = 4.0, space = 0.0 },
			{ coords = vector3(222.80, -789.82, 29.74), heading =  69.50, radius = 4.0, space = 0.0 },
			{ coords = vector3(221.91, -792.42, 29.74), heading =  69.50, radius = 4.0, space = 0.0 },
			{ coords = vector3(220.93, -795.00, 29.72), heading =  69.50, radius = 4.0, space = 0.0 },
			{ coords = vector3(219.91, -797.42, 29.72), heading =  69.50, radius = 4.0, space = 0.0 },
			{ coords = vector3(218.96, -799.92, 29.72), heading =  69.50, radius = 4.0, space = 0.0 },
			{ coords = vector3(218.02, -802.49, 29.72), heading =  69.50, radius = 4.0, space = 0.0 },
			{ coords = vector3(216.96, -804.83, 29.78), heading =  69.50, radius = 4.0, space = 0.0 },
			-- Rij 3 vanaf weg
			{ coords = vector3(218.84, -805.80, 29.73), heading = 249.50, radius = 4.0, space = 0.0 },
			{ coords = vector3(221.02, -800.97, 29.70), heading = 249.50, radius = 4.0, space = 0.0 },
			{ coords = vector3(219.91, -803.29, 29.72), heading = 249.50, radius = 4.0, space = 0.0 },
			{ coords = vector3(220.86, -800.88, 29.71), heading = 249.50, radius = 4.0, space = 0.0 },
			{ coords = vector3(221.82, -798.37, 29.69), heading = 249.50, radius = 4.0, space = 0.0 },
			{ coords = vector3(222.65, -795.90, 29.70), heading = 249.50, radius = 4.0, space = 0.0 },
			{ coords = vector3(223.68, -793.37, 29.70), heading = 249.50, radius = 4.0, space = 0.0 },
			{ coords = vector3(224.64, -790.81, 29.71), heading = 249.50, radius = 4.0, space = 0.0 },
			{ coords = vector3(225.64, -788.34, 29.71), heading = 249.50, radius = 4.0, space = 0.0 },
			{ coords = vector3(226.70, -785.80, 29.72), heading = 249.50, radius = 4.0, space = 0.0 },
			{ coords = vector3(227.43, -783.34, 29.72), heading = 249.50, radius = 4.0, space = 0.0 },
			{ coords = vector3(228.42, -780.78, 29.72), heading = 249.50, radius = 4.0, space = 0.0 },
			{ coords = vector3(229.38, -778.26, 29.73), heading = 249.50, radius = 4.0, space = 0.0 },
			{ coords = vector3(230.19, -775.75, 29.74), heading = 249.50, radius = 4.0, space = 0.0 },
			{ coords = vector3(231.23, -773.15, 29.75), heading = 249.50, radius = 4.0, space = 0.0 },
			{ coords = vector3(232.06, -770.61, 29.77), heading = 249.50, radius = 4.0, space = 0.0 },
		},
	},
	Garage_Bpbank = {
		Pos = {x=99.72, y=-1076.96, z=29.22},
		Marker = { w= 1.2, h= 0.3,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x=119.29, y= -1075.82, z= 29.20},
			Heading = 91.69,
			Marker = { w= 1.2, h= 0.3,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x=113.81, y=-1064.56, z=29.19},
			Marker = { w= 1.5, h= 0.3,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
	},
	Garage_Rood = {
		Pos = {x=-326.78, y=-773.47, z=33.96},
		Marker = { w= 1.2, h= 0.3,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x=-333.52, y= -779.76, z= 33.95},
			Heading = 91.69,
			Marker = { w= 1.2, h= 0.3,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x=-341.99, y=-767.43, z=33.97},
			Marker = { w= 1.5, h= 0.3,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
	},
	Garage_Haven = {
		Pos = {x=-700.76, y=-1401.13, z=5.5},
		Marker = { w= 1.2, h= 0.3,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x=-693.25, y= -1408.76, z= 5.1},
			Heading = 91.69,
			Marker = { w= 1.2, h= 0.3,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x=-1416.31, y=-1416.31, z=5.0},
			Marker = { w= 1.5, h= 0.3,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
	},
	Garage_Pier = {
		Pos ={x = -1519.61,y = -982.49,z = 13.02 },
		Marker = { w= 1.2, h= 0.3,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = -1547.42,y = -970.84,z = 13.02 },
			Heading = 138.25,
			Marker = { w= 1.2, h= 0.3,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = -1529.86,y = -985.53,z = 13.02 },
			Marker = { w= 1.5, h= 0.3,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
	},
	Garage_NightClub = {
		Pos ={x = 664.54406738281,y = 629.0244140625,z = 128.91111755371 },
		Marker = { w= 1.2, h= 0.3,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = 657.646,y = 630.719,z = 128.91 },
			Heading = 340.0,
			Marker = { w= 1.2, h= 0.3,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = 650.57611083984,y = 625.05859375,z = 128.9111328125 },
			Marker = { w= 1.5, h= 0.3,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
	},
	Garage_Centre2 = {
		Pos = {x = -1523.191,y = -451.017,z = 35.596},
		Marker = { w= 1.2, h= 0.3,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = -1519.22,y = -434.582,z = 35.44},
			Heading = 160.0,
			Marker = { w= 1.2, h= 0.3,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = -1528.022,y = -443.280,z = 35.442},
			Marker = { w= 1.5, h= 0.3,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
	},
	Garage_Paleto = {
		Pos = {x=105.359, y=6613.586, z=32.3973},
		Marker = { w= 1.2, h= 0.3,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x=128.7822, y= 6622.9965, z= 31.79},
			Heading = 160.0,
			Marker = { w= 1.2, h= 0.3,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x=126.3572, y=6608.4150, z=31.8565},
			Marker = { w= 1.5, h= 0.3,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
	},
	Garage_SandyShore = {
		Pos = {x=1694.571, y=3610.924, z=35.319},
		Marker = { w= 1.2, h= 0.3,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x=1713.492, y= 3598.938, z= 35.24},
			Heading = 160.0,
			Marker = { w= 1.2, h= 0.3,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = 1695.156,y = 3601.061,z = 35.530},
			Marker = { w= 1.5, h= 0.3,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
	},
	Garage_Hangar = {
		Pos = {x=-1283.71, y=-3330.61, z=13.95},
		Marker = { w= 1.2, h= 0.3,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x=-1282.45, y=-3319.82, z= 13.95},
			Heading = 330.66,
			Marker = { w= 1.2, h= 0.3,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = -1281.13,y = -3326.29,z = 13.95},
			Marker = { w= 1.5, h= 0.3,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
	},
	Garage_Ocean1 = {
		Pos = {x = -3140.323,y = 1124.463,z = 20.706},
		Marker = { w= 1.2, h= 0.3,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = -3132.638,y = 1126.662,z = 20.66},
			Heading = 160.0,
			Marker = { w= 1.2, h= 0.3,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = -3136.902,y = 1102.685,z = 20.654},
			Marker = { w= 1.5, h= 0.3,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
	},
	Garage_Ocean2 = {
		Pos = {x = -2982.561,y = 327.506,z = 14.935},
		Marker = { w= 1.2, h= 0.3,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = -2977.238,y = 337.777,z = 14.77},
			Heading = 160.0,
			Marker = { w= 1.2, h= 0.3,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = -2971.814,y = 355.331,z = 14.771},
			Marker = { w= 1.5, h= 0.3,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
	},
	Garage_Sud = {
		Pos = {x = 443.6696,y = -1969.4372,z = 24.401},
		Marker = { w= 1.2, h= 0.3,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = 437.8140,y = -1958.572,z = 23.04},
			Heading = 182.0,
			Marker = { w= 1.2, h= 0.3,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = 457.91,y = -1971.343,z = 22.98},
			Marker = { w= 1.5, h= 0.3,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
	},
	Garage_Lake = {
		Pos = {x = -73.165504455566,y = 908.08734130859,z = 235.62712097168 },
		Marker = { w= 1.2, h= 0.3,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = -72.099822998047,y = 902.85479736328,z = 235.63 },
			Heading = 134.409,
			Marker = { w= 1.2, h= 0.3,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = -66.987632751465,y = 891.65881347656,z = 235.55270385742 },
			Marker = { w= 1.0, h= 0.3,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
	},
	Garage_Occaz = {
		Pos = {x = 1136.3771972656,y = 2666.6303710938,z = 38.013275146484 },
		Marker = { w= 1.2, h= 0.3,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = 1120.9813232422,y = 2668.8684082031,z = 38.05 },
			Heading = 179.84,
			Marker = { w= 1.2, h= 0.3,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = 1121.9963378906,y = 2660.1179199219,z = 37.996875762939 },
			Marker = { w= 1.5, h= 0.3,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
	},
	Garage_Groove = {
		Pos = {x = -69.514305114746,y = -1822.9477539063,z = 26.941974639893 },
		Marker = { w= 1.2, h= 0.3,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = -67.72095489502,y = -1835.7784423828,z = 26.89 },
			Heading = 225.887,
			Marker = { w= 1.2, h= 0.3,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = -60.4020652771,y = -1829.5288085938,z = 26.836933135986 },
			Marker = { w= 1.5, h= 0.3,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
	},
	Garage_venise = {
		Pos = {x = -1081.974609375,y = -1254.1881103516,z = 5.4244246482849 },
		Marker = { w= 1.2, h= 0.3,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = -1077.2590332031,y = -1239.3200683594,z = 5.16 },
			Heading = 144.887,
			Marker = { w= 1.2, h= 0.3,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = -1097.2971191406,y = -1253.8725585938,z = 5.2441983222961 },
			Marker = { w= 1.5, h= 0.3,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
	},
	Garage_tequila = {
		Pos = {x = -575.66357421875,y = 318.41366577148,z = 84.614906311035 },
		Marker = { w= 1.2, h= 0.3,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = -569.47564697266,y = 323.53549194336,z = 84.48 },
			Heading = 22.52,
			Marker = { w= 1.2, h= 0.3,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = -560.84375,y = 322.41586303711,z = 84.402587890625 },
			Marker = { w= 1.5, h= 0.3,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
	},
	Garage_banque = {
		Pos = {x = 363.48370361328,y = 296.83682250977,z = 103.50011444092 },
		Marker = { w= 1.2, h= 0.3,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = 378.00622558594,y = 288.13024902344,z = 103.17 },
			Heading = 62.22,
			Marker = { w= 1.2, h= 0.3,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = 364.76132202148,y = 285.18911743164,z = 103.37410736084 },
			Marker = { w= 1.5, h= 0.3,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
	},
	Garage_mirrorpark = {
		Pos = {x = 1033.9229736328,y = -767.10662841797,z = 58.003326416016 },
		Marker = { w= 1.2, h= 0.3,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = 1040.6834716797,y = -778.18170166016,z = 58.02 },
			Heading = 359.92,
			Marker = { w= 1.2, h= 0.3,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = 1022.7816772461,y = -763.78955078125,z = 57.961227416992 },
			Marker = { w= 1.5, h= 0.3,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
	},
	-- Garage_Tournoi = {
		-- Pos = {x = 3171.8381347656,y = -1667.3009033203,z = 6.4746117591858 },
		-- Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
		-- Name = _U('garage_name'),
		-- HelpPrompt = _U('open_car_garage'),
		-- Functionmenu = OpenMenuGarage,
		-- SpawnPoint = {
			-- Pos = {x = 3164.1762695313,y = -1667.0953369141,z = 6.4746117591858 },
			-- Heading = 264.63,
			-- Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
			-- HelpPrompt = _U('spawn_car'),
			-- Functionmenu = ListVehiclesMenu,
		-- },
		-- DeletePoint = {
			-- Pos = {x = 3158.0983886719,y = -1661.5126953125,z = 7.0836601257324 },
			-- Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
			-- HelpPrompt = _U('store_car'),
			-- Functionmenu = StockVehicleMenu,
		-- }, 	
	-- },
	-- Garage_YouTool = {
		-- Pos = {x = 2709.8679199219,y = 3455.1743164063,z = 56.317573547363 },
		-- Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
		-- Name = _U('garage_name'),
		-- HelpPrompt = _U('open_car_garage'),
		-- Functionmenu = OpenMenuGarage,
		-- SpawnPoint = {
			-- Pos = {x = 2691.1271972656,y = 3454.1496582031,z = 55.785736083984 },
			-- Heading = 239.90,
			-- Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
			-- HelpPrompt = _U('spawn_car'),
			-- Functionmenu = ListVehiclesMenu,
		-- },
		-- DeletePoint = {
			-- Pos = {x = 2702.1945800781,y = 3454.7746582031,z = 55.667736053467 },
			-- Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
			-- HelpPrompt = _U('store_car'),
			-- Functionmenu = StockVehicleMenu,
		-- }, 	
	-- },
	Garage_YellowJack = {
		Pos = {x = 2008.0589599609,y = 3051.5148925781,z = 47.156224822998 },
		Marker = { w= 1.2, h= 0.3,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = 2009.0740966797,y = 3061.3701171875,z = 47.05 },
			Heading = 330.90,
			Marker = { w= 1.2, h= 0.3,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = 1984.5550537109,y = 3067.1560058594,z = 47.023329772949 },
			Marker = { w= 1.5, h= 0.3,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
	},
	Garage_Gevangenis = {
		Pos = {x = 1855.5,y = 2582.47,z = 45.67 },
		Marker = { w= 1.2, h= 0.3,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = 1855.5,y = 2578.62,z = 45.67 },
			Heading = 264.63,
			Marker = { w= 1.2, h= 0.3,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = 1855.5,y = 2575.02,z = 45.67 },
			Marker = { w= 1.5, h= 0.3,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
	},
}

Config.GaragesMecano = {
	Bennys = {
		Name = _U('bennys_pound'),
		SpawnPoint = {
			Pos = {x = 477.729,y = -1888.856,z = 26.094},
			Heading = 303.0,
			Marker = { w= 1.2, h= 0.5,r=0,g=255,b=0},
			HelpPrompt = _U('take_from_pound')
		},
		DeletePoint = {
			Pos = {x = 459.733,y = -1890.335,z = 25.776},
			Marker = { w= 1.2, h= 0.5,r=255,g=0,b=0},
			HelpPrompt = _U('store_in_pound')
		}, 	
	},
	police = {
		Name = _U('police_pound'),
		SpawnPoint = {
			Pos = {x = 449.253,y = -1024.322,z = 28.57},
			Heading = 100.0,
			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
			HelpPrompt = _U('take_from_pound')
		},
		DeletePoint = {
			Pos = {x = 452.305,y = -996.752,z = 25.776},
			Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = _U('store_in_pound')
		}, 	
	},
	police2 = {
		Name = _U('police_pound'),
		SpawnPoint = {
			Pos = {x = 1868.325,y = 3694.566,z = 33.61},
			Heading = 100.0,
			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
			HelpPrompt = _U('take_from_pound')
		},
		DeletePoint = {
			Pos = {x = 1860.925,y = 3706.958,z = 33.36},
			Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = _U('store_in_pound')
		}, 	
	},
	police3 = {
		Name = _U('police_pound'),
		SpawnPoint = {
			Pos = {x = -474.000,y = 6029.71,z = 30.94},
			Heading = 226.0,
			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
			HelpPrompt = _U('take_from_pound')
		},
		DeletePoint = {
			Pos = {x = -462.932,y = 60.41,z = 31.34},
			Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = _U('store_in_pound')
		}, 	
	},
	-- Bennys2 = {
		-- Marker = 1,
		-- SpawnPoint = {
			-- Pos = {x=-190.455, y= -1290.654, z= 30.295},
			-- Color = {r=0,g=255,b=0},
			-- Size  = {x = 3.0, y = 3.0, z = 1.0},
			-- Marker = 1
		-- },
		-- DeletePoint = {
			-- Pos = {x=-190.379, y=-1284.667, z=30.233},
			-- Color = {r=255,g=0,b=0},
			-- Size  = {x = 3.0, y = 3.0, z = 1.0},
			-- Marker = 1
		-- }, 	
	-- },
}

Config.BoatGarages = {
--	BoatGarage_Centre = {
--		Pos = {x = -741.12,y = -1332.40,z = 1.59 },
--		Marker = { w= 0.5, h= 1.0,r = 204, g = 204, b = 0},
--		Name = _U('boat_garage_name'),
--		HelpPrompt = _U('open_boat_garage'),
--		SpawnPoint = {
--			Pos = {x = -736.47064208984,y = -1342.4702148438,z = 1.0 },
--			MarkerPos = {x = -733.58,y = -1338.62,z = 1.5 },
--			Heading = 230.0,
--			Marker = { w= 0.5, h= 1.0,r=0,g=255,b=0},
--			HelpPrompt = _U('spawn_boat')
--		},
--		DeletePoint = {
--			Pos = {x = -748.04,y = -1356.04,z = 0.50 },
--			Marker = { w= 2.5, h= 1.0,r=255,g=0,b=0},
--			HelpPrompt = _U('store_boat')
--		}, 	
--	},
}

Config.AirplaneGarages = {
	AirplaneGarage_Centre = {
		Pos = {x = -1280.1153564453,y = -3378.1647949219,z = 13.95 },
		Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
		Name = _U('plane_garage_name'),
		HelpPrompt = _U('open_plane_garage'),
		SpawnPoint = {
			Pos = {x = -1285.1153564453,y = -3382.1647949219,z = 13.95 },
			Heading = 160.0,
			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_plane')
		},
		DeletePoint = {
			Pos = {x = -1287.5788574219,y = -3390.4025878906,z = 13.95 },
			Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = _U('store_plane')
		}, 	
	},

	AirplaneGarage_Haven = {
		Pos = {x = -735.1153564453,y = -1457.1647949219,z = 4.50 },
		Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
		Name = _U('plane_garage_name'),
		HelpPrompt = _U('open_plane_garage'),
		SpawnPoint = {
			Pos = {x = -745.1153564453,y = -1468.1647949219,z = 4.50 },
			Heading = 320.0,
			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_plane')
		},
		DeletePoint = {
			Pos = {x = -724.8788574219,y = -1444.4025878906,z = 5.95 },
			Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = _U('store_plane')
		}, 	
	},

	AirplaneGarage_Cayo = {
		Pos = {x = 4502.1153564453,y = -4474.1647949219,z = 3.35 },
		Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
		Name = _U('plane_garage_name'),
		HelpPrompt = _U('open_plane_garage'),
		SpawnPoint = {
			Pos = {x = -4477.1153564453,y = -4472.1647949219,z = 3.35 },
			Heading = 160.0,
			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_plane')
		},
		DeletePoint = {
			Pos = {x = -4486.5788574219,y = -4454.4025878906,z = 3.35 },
			Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = _U('store_plane')
		}, 	
	},
	AirplaneGarage_CayoBoven = {
		Pos = {x = 4900.1153564453,y = -5740.1647949219,z = 25.45 },
		Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
		Name = _U('plane_garage_name'),
		HelpPrompt = _U('open_plane_garage'),
		SpawnPoint = {
			Pos = {x = 4893.1153564453,y = -5726.1647949219,z = 25.45 },
			Heading = 160.0,
			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_plane')
		},
		DeletePoint = {
			Pos = {x = -4887.1153564453,y = -5744.1647949219,z = 25.45 },
			Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = _U('store_plane')
		}, 	
	},
}


Config.SocietyGarages = {
	police =  { -- database job name
		{
			Pos = {x = 446.39,y = -984.844,z = 30.696 },
			Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
			Name = _U('police_garage_name'),
			HelpPrompt = _U('open_police_garage'),
			SpawnPoint = {
				Pos = {x = -1285.1153564453,y = -3382.1647949219,z = 13.940155029297 },
				Heading = 160.0,
				Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
				HelpPrompt = _U('spawn_police_garage')
			},
			DeletePoint = {
				Pos = {x = -1287.5788574219,y = -3390.4025878906,z = 13.940155029297 },
				Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
				HelpPrompt = _U('store_police_garage')
			}, 	
		},
		{
			Pos = {x = 448.1153564453,y = -976.86,z = 30.696 },
			Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
			Name = _U('police_garage_name'),
			HelpPrompt = _U('open_police_garage'),
			SpawnPoint = {
				Pos = {x = -1285.1153564453,y = -3382.1647949219,z = 13.940155029297 },
				Heading = 160.0,
				Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
				HelpPrompt = _U('spawn_police_garage')
			},
			DeletePoint = {
				Pos = {x = -1287.5788574219,y = -3390.4025878906,z = 13.940155029297 },
				Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
				HelpPrompt = _U('store_police_garage')
			}, 	
		},
	},
	brinks =  {
		{
			Pos = {x = 443.1153564453,y = -993.86,z = 30.696 },
			Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
			Name = _U('brinks_garage_name'),
			HelpPrompt = _U('open_brinks_garage'),
			SpawnPoint = {
				Pos = {x = -1285.1153564453,y = -3382.1647949219,z = 13.940155029297 },
				Heading = 160.0,
				Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
				HelpPrompt = _U('spawn_brinks_garage')
			},
			DeletePoint = {
				Pos = {x = -1287.5788574219,y = -3390.4025878906,z = 13.940155029297 },
				Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
				HelpPrompt = _U('store_brinks_garage')
			}, 	
		},
    },
	ambulance =  {
		{
			Pos = {x = 443.1153564453,y = -993.86,z = 30.696 },
			Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
			Name = _U('ambulance_garage_name'),
			HelpPrompt = _U('open_ambulance_garage'),
			SpawnPoint = {
				Pos = {x = -1285.1153564453,y = -3382.1647949219,z = 13.940155029297 },
				Heading = 160.0,
				Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
				HelpPrompt = _U('spawn_ambulance_garage')
			},
			DeletePoint = {
				Pos = {x = -1287.5788574219,y = -3390.4025878906,z = 13.940155029297 },
				Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
				HelpPrompt = _U('store_ambulance_garage')
			}, 	
		},
	},
	taxi =  {
		{
			Pos = {x = 443.1153564453,y = -993.86,z = 30.696 },
			Marker = { w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
			Name = _U('taxi_garage_name'),
			HelpPrompt = _U('open_taxi_garage'),
			SpawnPoint = {
				Pos = {x = -1285.1153564453,y = -3382.1647949219,z = 13.940155029297 },
				Heading = 160.0,
				Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
				HelpPrompt = _U('spawn_taxi_garage')
			},
			DeletePoint = {
				Pos = {x = -1287.5788574219,y = -3390.4025878906,z = 13.940155029297 },
				Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
				HelpPrompt = _U('store_taxi_garage')
			}, 	
		},
    },
}

DUMPED USING FIVEX ]]--


Config = {}
Config.Blip			= {sprite= 524, color = 30}
Config.BoatBlip		= {sprite= 410, color = 30}
Config.AirplaneBlip	= {sprite= 423, color = 30}
Config.MecanoBlip	= {sprite= 357, color = 26}
Config.Price		= 500 -- pound price to get vehicle back
Config.SwitchGaragePrice		= 100 -- price to pay to switch vehicles in garage
Config.StoreOnServerStart = false -- Store all vehicles in garage on server start?
Config.Locale = 'en'

Config.Garages = {
	Garage_Centre = {
		Pos = {x=215.51, y=-810.58, z=30.34},
		Marker = { w= 1.0, h= 0.75,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x=217.85, y= -811.44, z= 30.34},
			Heading = 160.0,
			Marker = { w= 1.0, h= 0.75,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x=214.93, y=-791.53, z=30.34},
			Marker = { w= 1.5, h= 0.75,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		},
		RandomSpawns = {
			{x=220.07, y=-809.08, z=30.32, h=248.69}, -- Rij 1
			{x=221.24, y=-806.74, z=30.32, h=248.69},
			{x=221.93, y=-804.10, z=30.32, h=248.69},
			{x=223.10, y=-801.74, z=30.32, h=248.69},
			{x=223.92, y=-799.18, z=30.32, h=248.69},
			{x=225.15, y=-796.69, z=30.32, h=248.69},
			{x=225.89, y=-794.20, z=30.32, h=248.69},
			{x=226.49, y=-791.59, z=30.32, h=248.69},
			{x=227.49, y=-789.05, z=30.32, h=248.69},
			{x=228.65, y=-786.61, z=30.32, h=248.69},
			{x=229.41, y=-784.01, z=30.32, h=248.69},
			{x=230.53, y=-781.55, z=30.32, h=248.69},
			{x=231.42, y=-779.02, z=30.32, h=248.69},
			{x=232.21, y=-776.47, z=30.32, h=248.69},
			{x=233.27, y=-773.88, z=30.32, h=248.69},
			{x=234.24, y=-771.35, z=30.32, h=248.69},

			{x=230.72, y=-810.24, z=30.09, h=69.12}, -- Rij 2
			{x=231.68, y=-807.75, z=30.09, h=69.12},
			{x=233.14, y=-805.33, z=30.09, h=69.12},
			{x=223.61, y=-802.67, z=30.09, h=69.12},
			{x=234.91, y=-800.32, z=30.09, h=69.12},
			{x=235.75, y=-797.65, z=30.09, h=69.12},
			{x=236.20, y=-794.98, z=30.09, h=69.12},
			{x=237.59, y=-792.63, z=30.09, h=69.12},
			{x=238.21, y=-789.95, z=30.09, h=69.12},
			{x=239.71, y=-787.62, z=30.09, h=69.12},
			{x=240.33, y=-785.01, z=30.09, h=69.12},
			{x=241.08, y=-782.39, z=30.09, h=69.12},
			{x=242.28, y=-779.99, z=30.09, h=69.12},
			{x=243.10, y=-777.43, z=30.09, h=69.12},
			{x=244.07, y=-774.88, z=30.09, h=69.12},
			{x=245.10, y=-772.40, z=30.09, h=69.12},
		}
	},
	Garage_Casino = {
		Pos = {x = 886.3240,y = -0.9671,z = 78.7650 },
		Marker = { w= 1.0, h= 0.75,r = 204, g = 204, b = 0},
		DisableBlip = true,
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = 871.2555, y = -8.4880,z = 78.7641 },
			Heading = 230.1878,
			Marker = { w= 1.0, h= 0.75,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = 882.5663,y = -5.2884,z = 78.7641 },
			Marker = { w= 1.5, h= 0.75,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
		RandomSpawns = {
			{x=877.8641, y=-25.0830, z=78.7641, h=52.8193},
			{x=875.9446, y=-27.9070, z=78.7641, h=60.7586},
			{x=874.0345, y=-30.7829, z=78.7641, h=57.6554},
			{x=872.1204, y=-33.7516, z=78.7641, h=57.0670},
		}
	},
	Garage_Bpbank = {
		Pos = {x=97.55, y=-1077.39, z=28.75},
		Marker = { w= 1.0, h= 0.75,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x=113.61, y= -1086.55, z= 28.70},
			Heading = 91.69,
			Marker = { w= 1.0, h= 0.75,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x=133.80, y=-1063.01, z=28.70},
			Marker = { w= 1.5, h= 0.75,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		},
		RandomSpawns = {
			{x=117.48, y=-1082.02, z=28.83, h=0.43}, -- Rij 1
			{x=121.26, y=-1081.86, z=28.83, h=0.43},
			{x=124.92, y=-1081.92, z=28.83, h=0.43},
			{x=128.59, y=-1082.03, z=28.83, h=0.43},
			{x=132.35, y=-1082.04, z=28.83, h=0.43},
			{x=136.02, y=-1082.04, z=28.83, h=0.43},
			{x=139.76, y=-1081.95, z=28.83, h=0.43},
			{x=143.52, y=-1082.05, z=28.83, h=0.43},
			{x=147.11, y=-1082.03, z=28.83, h=0.43},
			{x=150.89, y=-1081.98, z=28.83, h=0.43},
			{x=154.66, y=-1082.05, z=28.83, h=0.43},
			{x=158.28, y=-1081.95, z=28.83, h=0.43},
			{x=162.17, y=-1082.05, z=28.83, h=0.43},

			{x=105.76, y=-1062.99, z=28.86, h=246.36}, -- Rij 2
			{x=107.20, y=-1059.54, z=28.86, h=246.36},
			{x=108.67, y=-1056.17, z=28.86, h=246.36},
			{x=110.21, y=-1052.76, z=28.86, h=246.36},
			{x=111.74, y=-1049.43, z=28.86, h=246.36},
		}
	},
	Garage_Rood = {
		Pos = {x=-327.25, y=-778.11, z=33.48},
		Marker = { w= 1.0, h= 0.75,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x=-332.12, y= -781.37, z= 33.48},
			Heading = 91.69,
			Marker = { w= 1.0, h= 0.75,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x=-341.99, y=-767.43, z=33.46},
			Marker = { w= 1.5, h= 0.75,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
		RandomSpawns = {
			{x=-357.13, y=-775.97, z=33.48, h=270.75},
			{x=-356.87, y=-770.89, z=33.48, h=270.75},
			{x=-356.99, y=-767.64, z=33.48, h=270.75},
			{x=-356.95, y=-764.42, z=33.48, h=270.75},
		}
	},
	Garage_Taakstraf = {
		Pos = {x=958.55, y=3616.09, z=32.24},
		Marker = { w= 1.0, h= 0.75,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x=958.63, y= 3619.22, z= 32.15},
			Heading = 91.69,
			Marker = { w= 1.0, h= 0.75,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x=956.72 , y=3611.33, z=32.28},
			Marker = { w= 1.5, h= 0.75,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
		RandomSpawns = {
			{x=951.53, y=3615.47, z=32.13, h=90.40},
			{x=951.01, y=3619.05, z=32.07, h=90.40},
			{x=951.06, y=3622.57, z=31.95, h=90.40},
		}
	},
	Garage_BlokkenParkOnderGarage = {
		Pos = {x=217.82, y=-916.65, z=17.82},
		Marker = { w= 1.0, h= 0.75,r = 204, g = 204, b = 0},
		DisableBlip = true,
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x=216.27, y= -909.37, z= 17.82},
			Heading = 91.69,
			Marker = { w= 1.0, h= 0.75,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x=218.26, y=-905.36, z=17.83},
			Marker = { w= 1.5, h= 0.75,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
		RandomSpawns = {
			{x=214.63, y=-890.21, z=17.83, h=236.00}, -- 33
			{x=216.41, y=-887.62, z=17.83, h=236.00}, -- 34
			{x=218.17, y=-885.08, z=17.83, h=236.00}, -- 35

			{x=220.55, y=-881.78, z=17.83, h=236.00}, -- 36
			{x=222.27, y=-879.19, z=17.83, h=236.00}, -- 37
			{x=224.13, y=-876.58, z=17.83, h=236.00}, -- 38

			{x=218.77, y=-872.91, z=17.83, h=55.00}, -- 39
			{x=216.92, y=-875.38, z=17.83, h=55.00}, -- 40
			{x=215.08, y=-878.01, z=17.83, h=55.00}, -- 41

			{x=212.80, y=-881.36, z=17.83, h=55.00}, -- 42
			{x=211.06, y=-883.88, z=17.83, h=55.00}, -- 43
			{x=209.18, y=-886.37, z=17.83, h=55.00}, -- 44
		}
	},
	Garage_VespucciBureau = {
		Pos = {x=-1081.13, y=-864.54, z=4.55},
		Marker = { w= 1.0, h= 0.75,r = 204, g = 204, b = 0},
		DisableBlip = true,
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x=-1083.53, y= -866.38, z= 4.55},
			Heading = 91.69,
			Marker = { w= 1.0, h= 0.75,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x=-1079.43, y=-884.35, z=4.10},
			Marker = { w= 1.5, h= 0.75,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
		RandomSpawns = {
			{x=-1039.50, y=-855.73, z=4.45, h=59.95}, -- Rij 1
			{x=-1041.87, y=-858.59, z=4.45, h=58.90},
			{x=-1045.12, y=-861.45, z=4.49, h=58.90},
			{x=-1048.46, y=-864.49, z=4.58, h=58.90},

			{x=-1051.47, y=-867.33, z=4.70, h=58.90}, -- Rij 2
			{x=-1069.24, y=-878.85, z=4.43, h=30.00},
			{x=-1072.83, y=-880.33, z=4.34, h=30.00},
			{x=-1076.14, y=-882.49, z=4.25, h=30.00},
			{x=-1079.59, y=-884.20, z=4.17, h=30.00},

			{x=-1047.95, y=-846.10, z=4.44, h=217.00}, -- Rij 3
			{x=-1052.46, y=-846.47, z=4.44, h=217.00},
			{x=-1055.60, y=-848.73, z=4.44, h=217.00},
			{x=-1058.66, y=-851.21, z=4.44, h=217.00},
			{x=-1061.86, y=-853.49, z=4.44, h=217.00},
		}
	},
	Garage_Haven = {
		Pos = {x=-696.61, y=-1400.95, z=5.66},
		Marker = { w= 1.0, h= 0.75,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x=-696.39, y= -1407.38, z= 4.51},
			Heading = 91.69,
			Marker = { w= 1.0, h= 0.75,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x=-682.80, y=-1633.39, z=4.51},
			Marker = { w= 1.5, h= 0.75,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
		RandomSpawns = {
			{x=-680.47, y=-1399.94, z=4.51, h=86.87},
			{x=-680.77, y=-1403.89, z=4.51, h=86.87},
			{x=-680.94, y=-1407.98, z=4.51, h=86.87},
			{x=-681.34, y=-1412.12, z=4.51, h=86.87},
			{x=-681.45, y=-1416.17, z=4.51, h=86.87},
		}
	},
	Garage_Pier = {
		Pos ={x = -1544.78,y = -964.11,z = 12.53 },
		Marker = { w= 1.0, h= 0.75,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = -1541.20,y = -967.26,z = 12.53 },
			Heading = 138.25,
			Marker = { w= 1.0, h= 0.75,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = -1526.82,y = -989.46,z = 12.53 },
			Marker = { w= 1.5, h= 0.75,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
		RandomSpawns = {
			{x=-1541.88, y=-973.33, z=12.53, h=140.0},
			{x=-1539.42, y=-875.62, z=12.53, h=140.0},
			{x=-1536.68, y=-977.85, z=12.53, h=140.0},
			{x=-1533.96, y=-980.01, z=12.53, h=140.0},
			{x=-1531.50, y=-982.20, z=12.53, h=140.0},
		}
	},
	Garage_NightClub = {
		Pos ={x = 659.63,y = 605.50,z = 128.56 },
		Marker = { w= 1.0, h= 0.75,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = 660.42,y = 607.53,z = 128.56 },
			Heading = 340.0,
			Marker = { w= 1.0, h= 0.75,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = 648.33,y = 632.42,z = 128.42 },
			Marker = { w= 1.5, h= 0.75,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
		RandomSpawns = {
			{x=661.77, y=626.69, z=128.38, h=70.00},
			{x=660.48, y=623.48, z=128.38, h=70.00},
			{x=659.35, y=620.16, z=128.38, h=70.00},
			{x=658.07, y=616.91, z=128.38, h=70.00},
			{x=656.72, y=613.64, z=128.38, h=70.00},
		}
	},
	Garage_Centre2 = {
		Pos = {x=-1527.90, y=-451.45, z=35.10},
		Marker = { w= 1.0, h= 0.75,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x=-1522.21, y= -452.13, z= 35.10},
			Heading = 160.0,
			Marker = { w= 1.0, h= 0.75,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = -1536.96,y = -438.63,z = 34.95},
			Marker = { w= 1.5, h= 0.75,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
		RandomSpawns = {
			{x=-1509.99, y=-435.19, z=34.95, h=84.00},
			{x=-1509.80, y=-431.70, z=34.95, h=85.15},
			{x=-1509.87, y=-428.23, z=34.95, h=85.50},
		}
	},
	Garage_Paleto = {
		Pos = {x=125.12, y=6629.16, z=31.42},
		Marker = { w= 1.0, h= 0.75,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x=121.86, y= 6625.74, z= 31.42},
			Heading = 160.0,
			Marker = { w= 1.0, h= 0.75,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x=108.89, y=6606.77, z=31.35},
			Marker = { w= 1.5, h= 0.75,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
		RandomSpawns = {
			{x=116.18, y=6599.54, z=31.64, h=271.43},
			{x=120.97, y=6594.76, z=31.67, h=271.43},
			{x=125.48, y=6589.82, z=31.61, h=271.43},
			{x=131.15, y=6585.27, z=31.60, h=271.43},
			{x=140.82, y=6575.28, z=31.61, h=271.43},
		}
	},
	Garage_SandyShore = {
		Pos = {x=1706.93, y=3779.14, z=34.27},
		Marker = { w= 1.0, h=0.75,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x=1704.56, y= 3777.53, z= 34.27},
			Heading = 160.0,
			Marker = { w= 1.0, h= 0.75,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = 1700.32,y = 3768.92,z = 33.99},
			Marker = { w= 1.5, h= 0.75,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
		RandomSpawns = {
			{x=1707.14, y=3762.41, z=33.78, h=316.40},
			{x=1704.34, y=3765.00, z=33.88, h=316.40},
			{x=1712.40, y=3776.99, z=34.0, h=214.70},
			{x=1708.77, y=3774.79, z=34.01, h=214.70},
		}
	},
	Garage_ANWB = {
		Pos = {x = -376.1,y = -86.48,z = 45.66 },
		Marker = { w= 1.0, h= 0.75,r = 204, g = 204, b = 0},
		DisableBlip = true,
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = -373.66,y = -87.19,z = 45.66 },
			Heading = 264.63,
			Marker = { w= 1.0, h= 0.75,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = -372.24,y = -80.4,z = 45.66 },
			Marker = { w= 1.5, h= 0.75,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
		RandomSpawns = { 
			{x=-371.11, y=-93.55, z=44.66, h=340.67},
		}
	},
	Garage_Medellin = {
		Pos = {x = -63.1,y = 885.48,z = 253.8 },
		Marker = { w= 1.0, h= 0.75,r = 204, g = 204, b = 0},
		DisableBlip = true,
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = -66.22,y = 884.05,z = 253.8 },
			Heading = 264.63,
			Marker = { w= 1.0, h= 0.75,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = -71.47,y = 902.68,z = 235.61 },
			Marker = { w= 1.5, h= 0.75,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
		RandomSpawns = { 
			{x= -67.78, y= -894.84, z=253.66, h=108.67},
		}
	},
	Garage_Hangar = {
		Pos = {x=-1279.96, y=-3333.20, z=13.45},
		Marker = { w= 1.0, h= 0.75,r = 204, g = 204, b = 0},
		DisableBlip = true,
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x=-1282.45, y=-3319.82, z= 13.45},
			Heading = 330.66,
			Marker = { w= 1.0, h= 0.75,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x=-1289.76, y=-3339.54, z=13.45},
			Marker = { w= 1.5, h= 0.75,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
	},
	Garage_Ocean1 = {
		Pos = {x = -3132.93,y = 1131.66,z = 20.19},
		Marker = { w= 1.0, h= 0.75,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = -3136.21,y = 1133.12,z = 20.19},
			Heading = 160.0,
			Marker = { w= 1.0, h= 0.75,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = -3136.05,y = 1102.59,z = 20.15},
			Marker = { w= 1.5, h= 0.75,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
		RandomSpawns= {
			{x=-3141.59, y=1117.22, z=20.21, h=280.52},
			{x=-3143.13, y=1113.63, z=20.21, h=280.55},
			{x=-3144.57, y=1110.19, z=20.21, h=280.61},
			{x=-3146.24, y=1106.67, z=20.21, h=280.54},
			{x=-3147.27, y=1103.26, z=20.21, h=280.64},
		}
	},
	Garage_Sud = {
		Pos = {x = 429.12,y = -1962.18,z = 22.90},
		Marker = { w= 1.0, h= 0.75,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = 432.32,y = -1965.74,z = 22.90},
			Heading = 182.0,
			Marker = { w= 1.0, h= 0.75,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = 436.75,y = -1956.36,z = 22.58},
			Marker = { w= 1.5, h= 0.75,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
		RandomSpawns = {
			{x=449.50, y=-1961.21, z=22.48, h=180.28},
			{x=453.84, y=-1966.14, z=22.48, h=180.28},
			{x=458.29, y=-1970.50, z=22.50, h=180.37},
		}
	},
	Garage_Occaz = {
		Pos = {x = 1123.31,y = 2642.63,z = 37.65 },
		Marker = { w= 1.0, h= 0.75,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = 1134.51,y = 2642.65,z = 37.65 },
			Heading = 179.84,
			Marker = { w= 1.0, h= 0.75,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = 1131.47,y = 2664.18,z = 37.52 },
			Marker = { w= 1.5, h= 0.75,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
		RandomSpawns = {
			{x=1131.40, y=2647.67, z=37.51, h=0.43},
			{x=1127.61, y=2647.67, z=37.51, h=0.43},
			{x=1124.07, y=2647.68, z=37.50, h=0.43},
			{x=1120.53, y=2647.66, z=37.51, h=0.43},
			{x=1116.74, y=2646.62, z=37.51, h=0.00},
		}
	},
	ambu_garage = {
		Pos = {x = -496.2500,y = -329.0737,z = 34.5016 },
		Marker = { w= 1.0, h= 0.25,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = -495.9592,y = -334.4669,z = 34.5016 },
			MarkerPos = {x = -496.2500,y = 329.0737,z = 34.5016 },
			Heading = 77.40,
			Marker = { w= 1.0, h= 0.25,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = -489.8675,y = -331.3701,z = 34.3611},
			Marker = { w= 2.5, h= 0.50,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
		RandomSpawns = {
			{x=-492.4825, y=-342.4494, z=34.3670, h=262.5089},
			{x=-487.3770, y=-342.8478, z=34.3628, h=263.9766},
			{x=-485.2695, y=-331.8831, z=34.3633, h=280.8458},
		}
	},
	Garage_DSI = {
		Pos = {x = 2518.24,y = -385.18,z = 92.65 },
		Marker = { w= 1.0, h= 0.75,r = 204, g = 204, b = 0},
		DisableBlip = true,
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = 2518.20,y = -382.84,z = 92.65 },
			Heading = 179.84,
			Marker = { w= 1.0, h= 0.75,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = 2537.20,y = -390.63,z = 92.50 },
			Marker = { w= 1.5, h= 0.75,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
		RandomSpawns = {
			{x=2540.88, y=-390.50, z=92.50, h=13.09},
			{x=2544.28, y=-389.78, z=92.50, h=13.09},
			{x=2548.05, y=-389.95, z=92.50, h=13.09},
			{x=2551.90, y=-390.41, z=92.50, h=13.09},
			{x=2555.53, y=-390.46, z=92.50, h=13.09},
		}
	},
	Garage_Grove = {
		Pos = {x = -75.15,y = -1828.78,z = 26.95 },
		Marker = { w= 1.0, h= 0.75,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = -70.69,y = -1823.49,z = 26.95 },
			Heading = 225.887,
			Marker = { w= 1.0, h= 0.75,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = -71.49,y = -1833.29,z = 26.95 },
			Marker = { w= 1.5, h= 0.75,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
		RandomSpawns = {
			{x=-62.63, y=-1840.50, z=26.19, h=320.09},
			{x=-59.93, y=-1842.75, z=26.09, h=320.09},
			{x=-57.30, y=-1844.92, z=25.99, h=320.09},
			{x=-54.71, y=-1847.13, z=25.88, h=320.09},
			{x=-52.09, y=-1849.43, z=25.78, h=320.09},
			{x=-44.68, y=-1840.60, z=25.72, h=139.56},
		}
	},
	Garage_Tequila = {
		Pos = {x = -562.79,y = 308.87,z = 84.44 },
		Marker = { w= 1.0, h= 0.75,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = -570.28,y = 313.51,z = 84.49 },
			Heading = 22.52,
			Marker = { w= 1.0, h= 0.75,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = -561.42,y = 321.91,z = 84.41 },
			Marker = { w= 1.5, h= 0.75,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
		RandomSpawns = {
			{x=-562.53, y=318.50, z=83.91, h=85.30},
			{x=-562.82, y=315.14, z=83.92, h=85.30},
			{x=-563.14, y=311.93, z=83.93, h=85.30},
		}
	},
	Garage_banque = {
		Pos = {x = 354.43,y = 279.02,z = 103.24 },
		Marker = { w= 1.0, h= 0.75,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = 355.95,y = 273.66,z = 103.22 },
			Heading = 62.22,
			Marker = { w= 1.0, h= 0.75,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = 370.92,y = 284.52,z = 103.27 },
			Marker = { w= 1.5, h= 0.75,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
		RandomSpawns = {
			{x=357.21, y=282.68, z=102.92, h=249.44},
			{x=358.60, y=286.25, z=102.99, h=249.44},
			{x=359.98, y=290.05, z=103.01, h=249.44},
			{x=361.35, y=293.65, z=103.01, h=249.44},
		}
	},
	Garage_mirrorpark = {
		Pos = {x = 1033.79,y = -776.63,z = 58.01 },
		Marker = { w= 1.0, h= 0.75,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = 1046.68,y = -770.52,z = 58.01 },
			Heading = 359.92,
			Marker = { w= 1.0, h= 0.75,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = 1046.47,y = -790.81,z = 58.01 },
			Marker = { w= 1.5, h= 0.75,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
		RandomSpawns = {
			{x=1046.61, y=-774.58, z=58.01, h=90.65},
			{x=1046.65, y=-778.25, z=58.01, h=90.65},
			{x=1046.68, y=-781.79, z=58.01, h=90.65},
			{x=1046.65, y=-785.61, z=58.01, h=90.65},
			{x=1041.94, y=-791.58, z=58.01, h=1.25},
			{x=1038.15, y=-791.65, z=58.01, h=1.25},
		}
	},
--[[	Garage_cayoperico = {
		Pos = {x = 4520.79,y = -4513.82,z = 4.5 },
		Marker = { w= 1.0, h= 0.75,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = 4519.37,y = -4514.41,z = 4.51 },
			Heading = 359.92,
			Marker = { w= 1.0, h= 0.75,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = 4518.92,y = -4499.18,z = 4.18 },
			Marker = { w= 1.5, h= 0.75,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
		RandomSpawns = {
			{x=4528.54, y=-4496.1, z=4.16, h=25.3},
			{x=4533.4, y=-4494.31, z=4.03, h=25.3},
			{x=4537.5, y=-4492.3, z=4.0, h=25.3},
		}
	},]]
	Garage_Gevangenis = {
		Pos = {x = 1855.09,y = 2575.11,z = 45.18 },
		Marker = { w= 1.0, h= 0.75,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = 1855.16,y = 2578.87,z = 45.18 },
			Heading = 264.63,
			Marker = { w= 1.0, h= 0.75,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = 1855.07,y = 2571.43,z = 45.18 },
			Marker = { w= 1.5, h= 0.75,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
		RandomSpawns = {
			{x=1854.69, y=2567.81, z=45.18, h=270.00},
			{x=1854.57, y=2564.05, z=45.18, h=270.00},
			{x=1854.49, y=2560.35, z=45.18, h=270.00},
			{x=1854.46, y=2556.64, z=45.18, h=270.00},
			{x=1854.41, y=2552.89, z=45.18, h=270.00},
			{x=1854.45, y=2549.15, z=45.18, h=270.00},
			{x=1854.39, y=2545.54, z=45.18, h=270.00},
			{x=1854.31, y=2541.84, z=45.18, h=270.00},
		}
	},
	Garage_Ziekenhuisonder = {
		Pos = {x = -473.93,y = -381.90,z = 23.74 },
		Marker = { w= 1.0, h= 0.75,r = 204, g = 204, b = 0},
		DisableBlip = true,
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = -474.94,y = -379.41,z = 23.74 },
			Heading = 264.63,
			Marker = { w= 1.0, h= 0.75,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = -469.54,y = -379.47,z = 23.74 },
			Marker = { w= 1.5, h= 0.75,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
		RandomSpawns = {
			{x=-465.67, y=-378.43, z=23.74, h=18.08},
			{x=-461.64, y=-376.99, z=23.74, h=18.08},
			{x=-457.66, y=-375.61, z=23.74, h=18.08},
		}
	},
	Garage_PolitiePaleto = {
		Pos = {x = -467.51,y = 6044.39,z = 30.83 },
		Marker = { w= 1.0, h= 0.75,r = 204, g = 204, b = 0},
		DisableBlip = true,
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = -464.95,y = 6046.98,z = 30.83 },
			Heading = 264.63,
			Marker = { w= 1.0, h= 0.75,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = -460.79,y = 6047.44,z = 30.85 },
			Marker = { w= 1.5, h= 0.75,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
		RandomSpawns = {
			{x=-457.57, y=6044.22, z=30.85, h=135.00},
			{x=-454.58, y=6041.02, z=30.85, h=135.00},
		}
	},
	Garage_SandyVliegveld = {
		Pos = {x = 1723.35,y = 3305.57,z = 40.73 },
		Marker = { w= 1.0, h= 0.75,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = 1724.11,y = 3301.97,z = 40.73 },
			Heading = 264.63,
			Marker = { w= 1.0, h= 0.75,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = 1737.34,y = 3316.40,z = 40.73 },
			Marker = { w= 1.5, h= 0.75,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
		RandomSpawns = { 
			{x=1727.80, y=3316.97, z=40.86, h=194.89},
			{x=1731.15, y=3317.87, z=40.86, h=194.89},
		}
	},

	Garage_Mayans = {
		Pos = {x = 146.33,y = 322.45,z = 112.12 },
		Marker = { w= 1.0, h= 0.75,r = 204, g = 204, b = 0},
		DisableBlip = true,
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = 148.22,y = 319.06,z = 112.14 },
			Heading = 264.63,
			Marker = { w= 1.0, h= 0.75,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = 149.31,y = 304.28,z = 112.14 },
			Marker = { w= 1.5, h= 0.75,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
		RandomSpawns = { 
			{x=139.98, y=317.09, z=112.14, h=222.67},
		}
	},
	Garage_Peaky = {
		Pos = {x = -1896.53,y = 2060.23,z = 140.95 },
		Marker = { w= 1.0, h= 0.75,r = 204, g = 204, b = 0},
		DisableBlip = true,
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = -1898.16,y = 2061.92,z = 140.92 },
			Heading = 264.63,
			Marker = { w= 1.0, h= 0.75,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = -1919.19,y = 2056.99,z = 140.24 },
			Marker = { w= 1.5, h= 0.75,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
		RandomSpawns = { 
			{x=-1920.24, y=2052.87, z=140.24, h=257.46},
			{x=-1920.29, y=2048.63, z=140.24, h=257.46},
			{x=-1921.18, y=2044.60, z=140.24, h=257.46},
			{x=-1922.29, y=2040.50, z=140.24, h=257.46},
			{x=-1923.11, y=2036.27, z=140.24, h=257.46},
		}
	},
	Garage_Wapendealer = {
		Pos = {x = 4971.07,y = -5738.16,z = 19.88 },
		Marker = { w= 1.0, h= 0.05,r = 204, g = 204, b = 0},
		DisableBlip = true,
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = 4974.16,y = -5741.41,z = 19.88 },
			Heading = 318.15,
			Marker = { w= 1.0, h= 0.05,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = 4968.85,y = -5747.86,z = 18.88 },
			Marker = { w= 1.5, h= 0.05,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
		RandomSpawns = { 
			{x=4978.83, y=-5735.47, z=18.88, h=324.24},
		}
	},

	Garage_Whyos = {
		Pos = {x = -98.31,y = 833.33,z = 235.23 },
		Marker = { w= 1.0, h= 0.75,r = 204, g = 204, b = 0},
		DisableBlip = true,
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = -100.55,y = 832.94,z = 235.23 },
			Heading = 264.63,
			Marker = { w= 1.0, h= 0.75,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = -111.68,y = 836.22,z = 235.18 },
			Marker = { w= 1.5, h= 0.75,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
		RandomSpawns = { 
			{x=-103.68, y=834.34, z=235.22, h=9.43},
		}
	},

	Garage_GrapeseedVliegveld = {
		Pos = {x = 1797.32,y = 4591.72,z = 37.19 },
		Marker = { w= 1.0, h= 0.75,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = 1792.63,y = 4591.29,z = 37.19 },
			Heading = 264.63,
			Marker = { w= 1.0, h= 0.75,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = 1776.14,y = 4591.75,z = 37.24 },
			Marker = { w= 1.5, h= 0.75,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
		RandomSpawns = { 
			{x=1785.09, y=4584.69, z=37.01, h=185.08},
			{x=1789.41, y=4585.21, z=36.90, h=184.66},
			{x=1793.62, y=4585.63, z=36.74, h=185.09},
			{x=1797.52, y=4585.92, z=36.64, h=185.26},
			{x=1801.23, y=4586.33, z=36.53, h=185.77},
		}
	},

--[[	Garage_Cayo_Haven = {
		Pos = {x = 4932.95,y = -5200.24,z = 2.45 },
		Marker = { w= 1.0, h= 0.75,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = 4931.64,y = -5202.54,z = 2.47 },
			Heading = 264.63,
			Marker = { w= 1.0, h= 0.75,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = 4936.74,y = -5214.87,z = 2.52 },
			Marker = { w= 1.5, h= 0.75,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
		RandomSpawns = { 
			{x=4912.26, y=-5220.13, z=2.52, h=306.43},
		}
	},]]
	Garage_BasicFat = {
		Pos = {x = 324.8,y = -230.61,z = 54.22 },
		Marker = { w= 1.0, h= 0.75,r = 204, g = 204, b = 0},
		DisableBlip = false,
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = 323.76,y = -232.82,z = 54.22 },
			Heading = 264.63,
			Marker = { w= 1.0, h= 0.75,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = 327.5,y = -205.5,z = 54.09 },
			Marker = { w= 1.5, h= 0.75,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
		RandomSpawns = { 
			{x=316.5, y=-205.99, z=54.09, h=245.46},
		}
	},
	Garage_Kartbaan = {
		Pos = {x = -2309.44,y = 284.41,z = 169.06 },
		Marker = { w= 1.0, h= 0.75,r = 204, g = 204, b = 0},
		DisableBlip = true,
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = -2310.53,y = 280.87,z = 169.03 },
			Heading = 264.63,
			Marker = { w= 1.0, h= 0.75,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = -2317.34,y = 280.19,z = 169.07 },
			Marker = { w= 1.5, h= 0.75,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
		RandomSpawns = { 
			{x=-2325.39, y=289.19, z=169.48, h=296.94},
		}
	},
	Garage_tweedehands = {
		Pos = {x = -68.95,y = -2004.68,z = 18.02 },
		Marker = { w= 1.0, h= 0.75,r = 204, g = 204, b = 0},
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = -73.35,y = -2004.47,z = 18.28 },
			Heading = 264.63,
			Marker = { w= 1.0, h= 0.75,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = -80.05,y = -2004.69,z = 18.02 },
			Marker = { w= 1.5, h= 0.75,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
		RandomSpawns = { 
			{x=-80.95, y=-2027.4, z=18.02, h=356.32},
			{x=-60.94, y=-2024.34, z=18.02, h=18.5},
			{x=-49.6, y=-2004.47, z=18.02, h=110.42},
			{x=-75.18, y=-1988.79, z=18.02, h=169.05},
		}
	},
	Garage_MinerJob = {
		Pos = {x = 843.49,y = -2178.78,z = 30.16 },
		Marker = { w= 1.0, h= 0.75,r = 204, g = 204, b = 0},
		DisableBlip = true,
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = 843.48,y = -2181.37,z = 30.16 },
			Heading = 264.63,
			Marker = { w= 1.0, h= 0.75,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = 845.24,y = -2188.99,z = 30.16 },
			Marker = { w= 1.5, h= 0.75,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
		RandomSpawns = { 
			{x=833.19, y=-2173.37, z=30.28, h=357.79},
		}
	},
	Garage_FiHouthakkerJob = {
		Pos = {x = 1213.74,y = -1280.8,z = 35.26 },
		Marker = { w= 1.0, h= 0.75,r = 204, g = 204, b = 0},
		DisableBlip = true,
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = 1211.19,y = -1280.87,z = 35.23 },
			Heading = 264.63,
			Marker = { w= 1.0, h= 0.75,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = 1213.1,y = -1274.63,z = 35.28 },
			Marker = { w= 1.5, h= 0.75,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
		RandomSpawns = { 
			{x=1206.39, y=-1270.37, z=34.28, h=176.79},
		}
	},
	Garage_Poolcleaner = {
		Pos = {x = -1295.64,y = -1298.01,z = 4.48 },
		Marker = { w= 1.0, h= 0.75,r = 204, g = 204, b = 0},
		DisableBlip = true,
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = -1294.65,y = -1300.67,z = 4.48 },
			Heading = 264.63,
			Marker = { w= 1.0, h= 0.75,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = -1298.6,y = -1300.44,z = 4.61 },
			Marker = { w= 1.5, h= 0.75,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
		RandomSpawns = { 
			{x=-1305.39, y=-1303.64, z=4.79, h=202.79},
		}
	},
	Garage_Windowcleaner = {
		Pos = {x = -183.24,y = -1384.25,z = 31.27 },
		Marker = { w= 1.0, h= 0.75,r = 204, g = 204, b = 0},
		DisableBlip = true,
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = -184.41,y = -1381.79,z = 31.28 },
			Heading = 264.63,
			Marker = { w= 1.0, h= 0.75,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = -179.5,y = -1380.44,z = 31.26 },
			Marker = { w= 1.5, h= 0.75,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
		RandomSpawns = { 
			{x=-181.33, y=-1371.22, z=31.26, h=120.79},
		}
	},
	Garage_TaxiJob = {
		Pos = {x = 894.35,y = -186.85,z = 73.73 },
		Marker = { w= 1.0, h= 0.75,r = 204, g = 204, b = 0},
		DisableBlip = true,
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = 896.26,y = -188.59,z = 73.78 },
			Heading = 264.63,
			Marker = { w= 1.0, h= 0.75,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = 898.32,y = -183.12,z = 73.8 },
			Marker = { w= 1.5, h= 0.75,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
		RandomSpawns = { 
			{x= 906.33, y=-186.32, z=74.26, h=56.79},
		}
	},
	Garage_Gopostal = {
		Pos = {x = 71.22,y = 82.09,z = 78.417 },
		Marker = { w= 1.0, h= 0.75,r = 204, g = 204, b = 0},
		DisableBlip = true,
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = 68.52,y = 83.16,z = 78.48 },
			Heading = 264.63,
			Marker = { w= 1.0, h= 0.75,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = 66.02,y = 73.71,z = 76.78 },
			Marker = { w= 1.5, h= 0.75,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
		RandomSpawns = { 
			{x= 92.25, y= 67.87, z=73.46, h=73.79},
		}
	},
	Garage_Slachter = {
		Pos = {x = -1100.83,y = -2029.31,z = 13.21 },
		Marker = { w= 1.0, h= 0.75,r = 204, g = 204, b = 0},
		DisableBlip = true,
		Name = _U('garage_name'),
		HelpPrompt = _U('open_car_garage'),
		SpawnPoint = {
			Pos = {x = -1103.25,y = -2031.99,z = 13.24 },
			Heading = 264.63,
			Marker = { w= 1.0, h= 0.75,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_car')
		},
		DeletePoint = {
			Pos = {x = -1101.02,y = -2038.98,z = 13.28 },
			Marker = { w= 1.5, h= 0.75,r=255,g=0,b=0},
			HelpPrompt = _U('store_car')
		}, 	
		RandomSpawns = { 
			{x= -1094.16, y= -2053.65, z=13.29, h=318.6},
		}
	},
}


Config.GaragesMecano = {

	police = {
		Name = ('Vespucci Inbeslagname'),
		SpawnPoint = {
			Pos = {x = -1042.253,y = -858.14,z = 4.45},
			Heading = 100.0,
			Marker = { w= 1.5, h= 1.0,r=0,g=255,b=0},
			HelpPrompt = ('Druk op ~INPUT_PICKUP~ om het voertuig uit de opslag te halen')
		},
		DeletePoint = {
			Pos = {x = -1043.42,y = -849.43,z = 4.45},
			Marker = { w= 1.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = ('Druk op ~INPUT_PICKUP~ om het voertuig inbeslag te nemen')
		}, 	
	},
}

Config.BoatGarages = {
--[[	BoatGarage_Sandy = {
		Pos = {x = 1301.39,y = 4217.65,z = 33.91 },
		Marker = { w= 1.0, h= 0.25,r = 204, g = 204, b = 0},
		Name = _U('boat_garage_name'),
		HelpPrompt = _U('open_boat_garage'),
		SpawnPoint = {
			Pos = {x = 1297.54,y = 4211.39,z = 30.53 },
			MarkerPos = {x = 1298.09,y = 4218.35,z = 33.91 },
			Heading = 77.40,
			Marker = { w= 1.0, h= 0.25,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_boat')
		},
		DeletePoint = {
			Pos = {x = 1333.95,y = 4265.20,z = 31.10},
			Marker = { w= 2.5, h= 0.50,r=255,g=0,b=0},
			HelpPrompt = _U('store_boat')
		}
	},
	BoatGarage_Cat = {
		Pos = {x = 3857.95,y = 4459.47,z = 1.82 },
		Marker = { w= 1.0, h= 0.25,r = 204, g = 204, b = 0},
		Name = _U('boat_garage_name'),
		HelpPrompt = _U('open_boat_garage'),
		SpawnPoint = {
			Pos = {x = 3854.89,y = 4454.87,z = 0.05 },
			MarkerPos = {x = 3855.88,y = 4459.41,z = 1.82 },
			Heading = 267.0,
			Marker = { w= 1.0, h= 0.25,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_boat')
		},
		DeletePoint = {
			Pos = {x = 3856.43,y = 4434.11,z = 0.30 },
			Marker = { w= 2.5, h= 0.50,r=255,g=0,b=0},
			HelpPrompt = _U('store_boat')
		}
	},
	BoatGarage_Elys = {
		Pos = {x = 23.76,y = -2807.54,z = 5.7 },
		Marker = { w= 1.0, h= 0.25,r = 204, g = 204, b = 0},
		Name = _U('boat_garage_name'),
		HelpPrompt = _U('open_boat_garage'),
		SpawnPoint = {
			Pos = {x = 27.91,y = -2807.92,z = 0.75 },
			MarkerPos = {x = 23.81,y = -2804.75,z = 5.7 },
			Heading = 185.0,
			Marker = { w= 1.0, h= 0.25,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_boat')
		},
		DeletePoint = {
			Pos = {x = 14.45,y = -2806.60,z = 0.70 },
			Marker = { w= 2.5, h= 0.50,r=255,g=0,b=0},
			HelpPrompt = _U('store_boat')
		}
	},
	BoatGarage_Centre = {
		Pos = {x = -884.84,y = -1470.96,z = 1.6 },
		Marker = { w= 1.0, h= 0.25,r = 204, g = 204, b = 0},
		Name = _U('boat_garage_name'),
		HelpPrompt = _U('open_boat_garage'),
		SpawnPoint = {
			Pos = {x = -884.82,y = -1458.15,z = 0.20 },
			MarkerPos = {x = -888.22,y = -1461.60,z = 1.6 },
			Heading = 22.0,
			Marker = { w= 1.0, h= 0.25,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_boat')
		},
		DeletePoint = {
			Pos = {x = -891.72,y = -1465.07,z = 0.50 },
			Marker = { w= 2.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = _U('store_boat')
		}, 	
	},]]
	BoatGarage_Cayo = {
		Pos = {x = 4935.96,y = -5182.79,z = 2.45 },
		Marker = { w= 1.0, h= 0.25,r = 204, g = 204, b = 0},
		Name = _U('boat_garage_name'),
		HelpPrompt = _U('open_boat_garage'),
		SpawnPoint = {
			Pos = {x = 4929.51,y = -5168.05,z = 0.88 },
			MarkerPos = {x = 4936.81,y = -5180.33,z = 2.45 },
			Heading = 64.0,
			Marker = { w= 1.0, h= 0.25,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_boat')
		},
		DeletePoint = {
			Pos = {x = 4924.46,y = -5176.32,z = 0.86 },
			Marker = { w= 2.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = _U('store_boat')
		}, 	
	},
}

Config.AirplaneGarages = {
	HeliGarage = {
		Pos = {x=-715.2792, y=-1441.4900, z=5.0005 },
		Marker = { w= 1.0, h= 0.75,r = 204, g = 204, b = 0},
		Name = _U('plane_garage_name'),
		HelpPrompt = _U('open_plane_garage'),
		SpawnPoint = {
			Pos = {x=-724.7850, y=-1443.9972, z= 5.0005},
			Heading = 147.0,
			Marker = { w= 1.0, h= 0.75,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_plane')
		},
		DeletePoint = {
			Pos = { x=-716.3805, y=-1451.0349, z= 5.0005 },
			Marker = { w= 3.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = _U('store_plane')
		}, 	
		RandomSpawns = {
			{x=-716.3805, y=-1451.0349, z=5.0005, h=58.4989},
		}
	},
	AirplaneGarage_Centre = {
		Pos = {x = -1278.31,y = -3366.35,z = 13.45 },
		Marker = { w= 1.0, h= 0.75,r = 204, g = 204, b = 0},
		Name = _U('plane_garage_name'),
		HelpPrompt = _U('open_plane_garage'),
		SpawnPoint = {
			Pos = {x = -1280.19,y = -3369.74,z = 13.45 },
			Heading = 160.0,
			Marker = { w= 1.0, h= 0.75,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_plane')
		},
		DeletePoint = {
			Pos = {x = -1287.73,y = -3389.52,z = 13.45 },
			Marker = { w= 3.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = _U('store_plane')
		}, 	
		RandomSpawns = {
			{x=-1267.49, y=-3373.73, z=14.05, h=330.11},
		}
	},
	AirplaneGarage_Sandy = {
		Pos = {x = 1762.51,y = 3248.33,z = 41.25 },
		Marker = { w= 1.0, h= 0.75,r = 204, g = 204, b = 0},
		Name = _U('plane_garage_name'),
		HelpPrompt = _U('open_plane_garage'),
		SpawnPoint = {
			Pos = {x = 1758.97,y = 3242.26,z = 41.41 },
			Heading = 160.0,
			Marker = { w= 1.0, h= 0.75,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_plane')
		},
		DeletePoint = {
			Pos = {x = 1770.12,y = 3239.82,z = 41.22 },
			Marker = { w= 3.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = _U('store_plane')
		}, 	
		RandomSpawns = {
			{x=1769.81, y=3239.72, z=41.64, h=103.40},
		}
	},
	AirplaneGarage_Grapeseed = {
		Pos = {x = 2141.00,y = 4786.56,z = 40.48 },
		Marker = { w= 1.0, h= 0.75,r = 204, g = 204, b = 0},
		Name = _U('plane_garage_name'),
		HelpPrompt = _U('open_plane_garage'),
		SpawnPoint = {
			Pos = {x = 2139.80,y = 4789.08,z = 40.48 },
			Heading = 160.0,
			Marker = { w= 1.0, h= 0.75,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_plane')
		},
		DeletePoint = {
			Pos = {x = 2141.82,y = 4819.74,z = 40.76 },
			Marker = { w= 3.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = _U('store_plane')
		}, 	
		RandomSpawns = {
			{x=2137.98, y=4811.98, z=41.29, h=114.64},
		}
	},
	AirplaneGarage_Cayo = {
		Pos = {x = 4441.5962,y = -4487.8057,z = 4.2310 },
		Marker = { w= 1.0, h= 0.75,r = 204, g = 204, b = 0},
		Name = _U('plane_garage_name'),
		HelpPrompt = _U('open_plane_garage'),
		SpawnPoint = {
			Pos = {x = 4441.5962,y = -4487.8057,z = 4.2310 },
			Heading = 160.0,
			Marker = { w= 1.0, h= 0.75,r=0,g=255,b=0},
			HelpPrompt = _U('spawn_plane')
		},
		DeletePoint = {
			Pos = {x = 4452.2051,y = -4489.3823,z = 4.2114 },
			Marker = { w= 3.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = _U('store_plane')
		}, 	
		RandomSpawns = {
			{x=4458.8018, y=-4491.4868, z=4.2025, h=110.57},
		}
	},
}


Config.SocietyGarages = {
}