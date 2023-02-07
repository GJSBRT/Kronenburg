ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("esx:sanchez:lowmoney")
AddEventHandler("esx:sanchez:lowmoney", function(money)
    local _source = source	
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeMoney(money)
end)

-- License
print("^5KOOS HEEFT KANKER)

Citizen.CreateThread(function()
	Citizen.Wait(5000)
	local ver = "5.0"
	print("ESX Bike Rental started v"..ver)
end)
