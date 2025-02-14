﻿--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

Citizen.CreateThread(function()
	-- Pagani Zonda Polizia
	AddTextEntry('0x1C71E76F', 'Ferrari')
	AddTextEntry('0x45AF48CC', 'New York Plate')
	AddTextEntry('0x56C26178', 'Carbon Storage Cover')
	AddTextEntry('0x86CAF59A', '458 Spider Liberty Walk')
	AddTextEntry('0x93F2E552', 'LW Custom Plate')
	AddTextEntry('0x199CF5DC', 'Stock Front Bumper')
	AddTextEntry('0x302DF313', 'Liberty Walk GT Spoiler')
	AddTextEntry('0x623D01E7', 'Japanese Plate')
	AddTextEntry('0x776E2C49', 'New York Plate')
	AddTextEntry('0x3929B5D2', 'Titanium Exhaust')
	AddTextEntry('0x6718E0E8', 'Carbon GT Spoiler')
	AddTextEntry('0x228857C8', 'Carbon Ducktail')
	AddTextEntry('0xA668A578', '458 Standard Seat')
	AddTextEntry('0xBF9FED2A', 'Roof')
	AddTextEntry('0xD4A2172A', 'Carbon Roof')
	AddTextEntry('0xDC80766C', 'California Plate')
end)