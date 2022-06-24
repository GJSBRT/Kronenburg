Config = {}
Config.Locale = 'en'

Config.Marker = {
	r = 237, g = 41, b = 57, a = 100,  -- red color
	x = 0.5, y = 0.75, z = 0.25,       -- tiny, cylinder formed circle
	DrawDistance = 15.0, Type = 20    -- default circle type, low draw distance due to indoors area
}

Config.PoliceNumberRequired = 1
Config.TimerBeforeNewRob    = 5000 -- The cooldown timer on a store after robbery was completed / canceled, in seconds

Config.MaxDistance    = 20   -- max distance from the robbary, going any longer away from it will to cancel the robbary
Config.GiveBlackMoney = true -- give black money? If disabled it will give cash instead

Stores = {
--	["paleto_twentyfourseven"] = {
--		position = { x = 1736.32, y = 6419.47, z = 35.03 },
--		reward = math.random(5000, 35000),
--		nameOfStore = "24/7. (Paleto Bay)",
--		secondsRemaining = 350, -- seconds
--		lastRobbed = 0
--	},
	["sandyshores_twentyfoursever"] = {
		position = { x = 1961.24, y = 3749.46, z = 32.34 },
		reward = math.random(30000, 50000),
		nameOfStore = "24/7 | Sandy Shores",
		secondsRemaining = 450, -- seconds
		lastRobbed = 0
	},
	["littleseoul_twentyfourseven"] = {
		position = { x = -709.17, y = -904.21, z = 19.21 },
		reward = math.random(30000, 50000),
		nameOfStore = "24/7 | Little Seoul",
		secondsRemaining = 450, -- seconds
		lastRobbed = 0
	},
	["bar_one"] = {
		position = { x = 1990.57, y = 3044.95, z = 47.21 },
		reward = math.random(30000, 50000),
		nameOfStore = "Yellow Jack | Sandy Shores",
		secondsRemaining = 450, -- seconds
		lastRobbed = 0
	},
	["ocean_liquor"] = {
		position = { x = -2959.33, y = 388.21, z = 14.00 },
		reward = math.random(30000, 50000),
		nameOfStore = "Robs Liquor | Great Ocean Highway",
		secondsRemaining = 450, -- seconds
		lastRobbed = 0
	},
	["rancho_liquor"] = {
		position = { x = 1126.80, y = -980.40, z = 45.41 },
		reward = math.random(30000, 50000),
		nameOfStore = "Robs Liquor | El Rancho Blvd",
		secondsRemaining = 450, -- seconds
		lastRobbed = 0
	},
	["sanandreas_liquor"] = {
		position = { x = -1219.85, y = -916.27, z = 11.32 },
		reward = math.random(30000, 50000),
		nameOfStore = "Robs Liquor | San Andreas Avenue",
		secondsRemaining = 450, -- seconds
		lastRobbed = 0
	},
	["grove_ltd"] = {
		position = { x = -43.40, y = -1749.20, z = 29.42 },
		reward = math.random(30000, 50000),
		nameOfStore = "LTD Gasoline | Grove Street",
		secondsRemaining = 450, -- seconds
		lastRobbed = 0
	},
	["mirror_ltd"] = {
		position = { x = 1160.67, y = -314.40, z = 69.20 },
		reward = math.random(30000, 50000),
		nameOfStore = "LTD Gasoline | Mirror Park Boulevard",
		secondsRemaining = 450, -- seconds
		lastRobbed = 0
	},
	["ABN AMRO Blokkenpark"] = {
		position = { x = 146.58, y = -1045.01, z = 29.38 },
		reward = math.random(120000, 140000),
		nameOfStore = "ABN AMRO | Blokkenpark",
		secondsRemaining = 720, -- seconds
		lastRobbed = 0
	},
	["ABN AMRO Ocean"] = {
		position = { x = -2957.54, y = 480.99, z = 15.71 },
		reward = math.random(120000, 140000),
		nameOfStore = "ABN AMRO | Great Ocean Highway",
		secondsRemaining = 720, -- seconds
		lastRobbed = 0
	},
	["ABN AMRO Paleto"] = {
		position = { x = -103.47, y = 6477.89, z = 31.63 },
		reward = math.random(120000, 140000),
		nameOfStore = "ABN AMRO | Paleto",
		secondsRemaining = 720, -- seconds
		lastRobbed = 0
	}
}
