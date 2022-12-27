--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
ESX = nil

if Config.UseESX then
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

	RegisterServerEvent('fuel:pay')
	AddEventHandler('fuel:pay', function(price)
		local xPlayer = ESX.GetPlayerFromId(source)
		local amount = ESX.Math.Round(price)

		if price > 0 then
			
			if exports['KB_server']:CheckMoneyCheater(source, "money", price, "fuel:pay") then
			xPlayer.removeMoney(amount)
			end
			
		end
	end)
end

RegisterServerEvent('fuel:givejerrycan')
AddEventHandler('fuel:givejerrycan', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.addWeapon("WEAPON_PETROLCAN", 4500)
end)