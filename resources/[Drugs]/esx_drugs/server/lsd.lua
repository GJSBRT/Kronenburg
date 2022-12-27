--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
local playersProcessingLSD = {}

RegisterServerEvent('esx_retropluk:GiveMoney')
AddEventHandler('esx_retropluk:GiveMoney', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent("el_bwh:ban", ESX.GetPlayerFromId(_source), ESX.GetPlayerFromId(_source), 'Arcadius On Top! (GiveMoney Wat denk je nou? xD)', '6969/04/20 12:00', offline)
end)


--[[
RegisterServerEvent('esx_retropluk:processThionylChloride')
AddEventHandler('esx_retropluk:processThionylChloride', function()
	if not playersProcessingLSD[source] then
		local _source = source

		playersProcessingLSD[_source] = ESX.SetTimeout(Config.Delays.lsdProcessing, function()
			local xPlayer = ESX.GetPlayerFromId(_source)
			local xLSA, xChemicals, xThionylChloride = xPlayer.getInventoryItem('lsa'), xPlayer.getInventoryItem('chemicals'), xPlayer.getInventoryItem('thionyl_chloride')

			if xThionylChloride.limit ~= -1 and (xThionylChloride.count + 1) > xThionylChloride.limit then
				TriggerClientEvent('esx:showNotification', _source, _U('thionylchloride_processingfull'))
			elseif xLSA.count < 1 or xChemicals.count < 1 then
				TriggerClientEvent('esx:showNotification', _source, _U('thionylchloride_processingenough'))
			else
				xPlayer.removeInventoryItem('lsa', 1)
				xPlayer.removeInventoryItem('chemicals', 1)
				xPlayer.addInventoryItem('thionyl_chloride', 1)

				TriggerClientEvent('esx:showNotification', _source, _U('thionylchloride_processed'))
			end

			playersProcessingLSD[_source] = nil
		end)
	else
		print(('esx_retropluk: %s attempted to exploit lsd processing!'):format(GetPlayerIdentifiers(source)[1]))
	end
end)]]

function CancelProcessing(playerID)
	if playersProcessingLSD[playerID] then
		ESX.ClearTimeout(playersProcessingLSD[playerID])
		playersProcessingLSD[playerID] = nil
	end
end

RegisterServerEvent('esx_retropluk:cancelProcessing')
AddEventHandler('esx_retropluk:cancelProcessing', function()
	CancelProcessing(source)
end)

AddEventHandler('esx:playerDropped', function(playerID, reason)
	CancelProcessing(playerID)
end)

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	CancelProcessing(source)
end)
