--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
Config = {}

-- Script locale (only .Lua)
Config.Locale = 'en'

Config.AutoFindFixePhones = false -- Automatically add pay phones as they are found by their models.

Config.FixePhone = {
  -- Mission Row
  ['911'] = { 
    name =  _U('mission_row'), 
    coords = { x = 441.2, y = -979.7, z = 30.58 } 
  },
  
--  ['372-9663'] = {
--    name = _U('phone_booth'),
--    coords = { x = 372.305, y = -966.373, z = 28.413 } 
--  },
}

Config.KeyOpenClose = 288 -- F1
Config.KeyTakeCall  = 38  -- E

Config.UseMumbleVoIP = true -- GEBRUIK JE MUMBLE
Config.UseTokoVoIP   = false -- GEBRUIK JE TOKOVOIP

Config.ShowNumberNotification = true -- SLAAT NUMMER ZIEN BIJ BERICHT