--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent('js-policenpc:server:pak')
AddEventHandler('js-policenpc:server:pak', function(item)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local itemcount = xPlayer.getInventoryItem(item).count

    if JS.ItemTable[item].max > itemcount then
        xPlayer.addInventoryItem(item, 1)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Je hebt al teveel van dit item!', style = { ['background-color'] = 'FF0000', ['color'] = '#FFFFFF' } })
    end
end)
