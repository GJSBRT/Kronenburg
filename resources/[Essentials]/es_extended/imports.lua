--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
ESX = exports['es_extended']:getSharedObject()

if not IsDuplicityVersion() then -- Only register this event for the client
	AddEventHandler('esx:setPlayerData', function(key, val, last)
		if GetInvokingResource() == 'es_extended' then
			ESX.PlayerData[key] = val
			if OnPlayerData ~= nil then OnPlayerData(key, val, last) end
		end
	end)
end