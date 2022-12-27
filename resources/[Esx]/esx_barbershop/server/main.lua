--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_barbershop:pay')
AddEventHandler('esx_barbershop:pay', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeMoney(Config.Price)
	TriggerClientEvent('esx:showNotification', source, _U('you_paid', ESX.Math.GroupDigits(Config.Price)))
end)

ESX.RegisterServerCallback('esx_barbershop:checkMoney', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	cb(xPlayer.getMoney() >= Config.Price)
end)
