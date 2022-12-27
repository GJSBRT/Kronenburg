--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
local playersProcessingChemicalsToHydrochloricAcid = {}

RegisterServerEvent('esx_retropluk:pickedUpChemicals')
AddEventHandler('esx_retropluk:pickedUpChemicals', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('chemicals')

	--[[
	if xItem.limit ~= -1 and (xItem.count + 1) > xItem.limit then
		TriggerClientEvent('esx:showNotification', _source, _U('Chemicals_inventoryfull'))
	else
		xPlayer.addInventoryItem(xItem.name, 1)
	end]]
	print('ehm' .. xPlayer .. 'probeerde chemicals in te spawnen')

end)

RegisterServerEvent('esx_retropluk:ChemicalsConvertionMenu')
AddEventHandler('esx_retropluk:ChemicalsConvertionMenu', function(itemName, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(itemName)
	local xChemicals = xPlayer.getInventoryItem('chemicals')
--[[
	if xChemicals.count < amount then
		TriggerClientEvent('esx:showNotification', source, _U('Chemicals_notenough', xItem.label))
		return
	end
	
	Citizen.Wait(5000)

	xPlayer.addInventoryItem(xItem.name, amount)

	xPlayer.removeInventoryItem('chemicals', amount)

	TriggerClientEvent('esx:showNotification', source, _U('Chemicals_made', xItem.label))]]

	print('ehm' .. xPlayer .. 'probeerde chemicals in te spawnen')

end)



ESX.RegisterServerCallback('esx_retropluk:CheckLisense', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xChemicalsLisence = xPlayer.getInventoryItem('chemicalslisence')

	if xChemicalsLisence.count == 1 then
		cb(true)
	else
		cb(false)
	end
end)