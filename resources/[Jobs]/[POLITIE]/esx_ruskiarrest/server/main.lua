--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
-- Skrypt od strony Serwera

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_ruski_areszt:startAreszt')
AddEventHandler('esx_ruski_areszt:startAreszt', function(target)
	local targetPlayer = ESX.GetPlayerFromId(target)

	TriggerClientEvent('esx_ruski_areszt:aresztowany', targetPlayer.source, source)
	TriggerClientEvent('esx_ruski_areszt:aresztuj', source)
end)