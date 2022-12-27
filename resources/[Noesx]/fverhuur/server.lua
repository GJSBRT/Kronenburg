--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterServerCallback('esx:bike:lowmoney', function(source, cb)
    local _source = source	
	local xPlayer = ESX.GetPlayerFromId(_source)
	local canAfford = false
    local money = 100


	if xPlayer.getMoney() >= money then
        canAfford = true
        xPlayer.removeMoney(money)
        TriggerClientEvent('esx:showNotification', _source, 'Je betaalde €' .. money .. ',-')
        cb(true)
    elseif xPlayer.getAccount('bank').money >= money then
        canAfford = true
        xPlayer.removeAccountMoney('bank', money)
        TriggerClientEvent('esx:showNotification', _source, 'Je betaalde €' .. money .. ',-')
        cb(true)
    end

    if not canAfford then
        cb(false)
        TriggerClientEvent('esx:showNotification', _source, 'Je kan dit niet betalen')
    end

end)