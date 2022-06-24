Config 					= {}

Config.Locale 			= 'en'
Config.DrawDistance 	= 10


local second = 1000
local minute = 60 * second
local hour = 60 * minute

--[[ 
	Below are the zones for laundering. You can set multiple zones just follow the format below. 
	Failure to do so will result in the script breaking.
	Set the job to 'any' if you want anybody to use the location. Otherwise set the required job you want to use for the location
	Any job not allowed to use the location WILL NOT see a marker or get a popup to use it.

	
	EXAMPLE LOCATION!!! JUST COPY THIS AND PASTE TO ADD MORE LOCATIONS!
		
	{
		Pos = {
			{x = -128.4290, -1647.9226, 36.5142}
		},
		
		Jobs = {
			--'any', -- SET THE 'any' TAG TO ALLOW ALL JOBS INCLUDING POLICE TO USE THE LOCATION
			--'miner',
			--'cardealer'
		},
		TaxRate = 0.50, -- set taxrate per spot. Default is 0.5 or 50% of the dirty you will get back in clean
		enableTimer = false, -- Enable ONLY IF you want a timer on the money washing. Keep in mind the Player does not have to stay at the wash for it to actually wash the money.
		timer = 5 * second -- Actual Timer for the spot. The * amount will determine if its hours, second, or minutes. which are found above. DEFAULT: 5 * second
	},
	
]]

Config.Zones = {
	
	['LaundryMat'] = {	
		Pos = { 
			{x = -270.8712 , y = -704.9434 , z = 38.2769},
		},
		
		Jobs = {
			'any', -- set to 'any' to allow the location for any player regardless of job
		},
		TaxRate = 0.85, -- set taxrate per spot. Default is 0.5 or 50% of the dirty you will get back in clean
		enableTimer = false, -- Enable ONLY IF you want a timer on the money washing. Keep in mind the Player does not have to stay at the wash for it to actually wash the money.
		timer = 5 * second, -- Actual Timer for the spot. The * amount will determine if its hours, second, or minutes. which are found above. DEFAULT: 5 * second
		Size = {x = 1.5, y = 1.5, z = 1.5},
		Color = {r = 215, g = 161, b = 13},
		Type = 27,
    },

	['Bratva'] = {	
		Pos = { 
			{x = -1830.59 , y = -381.07 , z = 48.40},
		},
		
		Jobs = {
			'bratva'
		},
		TaxRate = 0.95, 
		enableTimer = false,
		timer = 10 * second,
		Size = {x = 2.0, y = 2.0, z = 2.0},
		Color = {r = 255, g = 20, b = 0},
		Type = 25,
	
	}
	
}
