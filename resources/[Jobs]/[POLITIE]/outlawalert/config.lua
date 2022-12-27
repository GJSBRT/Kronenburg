--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
Config = {}

Config.Locale = 'en'

-- Set the time (in minutes) during the player is outlaw
Config.Timer = 1

-- Set if show alert when player use gun
Config.GunshotAlert = true

-- Set if show when player do carjacking
Config.CarJackingAlert = false

-- Set if show when player fight in melee
Config.MeleeAlert = false

-- In seconds
Config.BlipGunTime = 5

-- Blip radius, in float value!
Config.BlipGunRadius = 50.0

-- In seconds
Config.BlipMeleeTime = 7

-- Blip radius, in float value!
Config.BlipMeleeRadius = 50.0

-- In seconds
Config.BlipJackingTime = 15

-- Blip radius, in float value!
Config.BlipJackingRadius = 50.0

-- Show notification when cops steal too?
Config.ShowCopsMisbehave = false

-- Jobs in this table are considered as cops
Config.WhitelistedCops = {
	'police' , 'kmar'
}
Config.WhitelistedFirefighters = {
	'brandweer'
}