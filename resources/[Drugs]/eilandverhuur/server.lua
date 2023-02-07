ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterServerCallback('esx:bike:lowmoney', function(source, cb)
    local _source = source	
	local xPlayer = ESX.GetPlayerFromId(_source)
	local canAfford = false
    local money = 1000


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