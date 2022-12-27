--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
-- Client

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent("esx_givecarkeys:keys")
AddEventHandler("esx_givecarkeys:keys", function()

	giveCarKeys()

end)

function giveCarKeys()
	local playerPed = GetPlayerPed(-1)
	local coords    = GetEntityCoords(playerPed)

	if IsPedInAnyVehicle(playerPed, false) then
		vehicle = GetVehiclePedIsIn(playerPed, false)
	else
		vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 7.0, 0, 70)
	end

	local plate = GetVehicleNumberPlateText(vehicle)
	local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)


	ESX.TriggerServerCallback('esx_givecarkeys:requestPlayerCars', function(isOwnedVehicle)
		if not isOwnedVehicle then
			ESX.ShowNotification('Je bezit geen voertuig die dichtbij is.')
		elseif isOwnedVehicle then
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

			if closestPlayer == -1 or closestDistance > 3.0 then
				ESX.ShowNotification('Geen spelers dichtbij!')
			else
				ESX.ShowNotification('Je hebt de sleutels gegeven van het voertuig ~g~' .. vehicleProps.plate .. '!')
				TriggerServerEvent('esx_givecarkeys:setVehicleOwnedPlayerId', GetPlayerServerId(closestPlayer), vehicleProps)
			end

		end
	end, GetVehicleNumberPlateText(vehicle))
end
