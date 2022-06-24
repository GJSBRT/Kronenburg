RegisterNetEvent("sopadev_givecarkeys:keys")
AddEventHandler("sopadev_givecarkeys:keys", function()
	giveCarKeys()
end)

function giveCarKeys()
	local playerPed = GetPlayerPed(-1)
	local coords    = GetEntityCoords(playerPed)

	if IsPedInAnyVehicle(playerPed,  false) then
        vehicle = GetVehiclePedIsIn(playerPed, false)			
    else
        vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 7.0, 0, 70)
    end

	local plate = GetVehicleNumberPlateText(vehicle)
	local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)


	ESX.TriggerServerCallback('sopadev_givecarkeys:requestPlayerCars', function(isOwnedVehicle)
		if not isOwnedVehicle then
			ESX.ShowNotification('Je bezit geen voertuig die dichtbij is.')
		elseif isOwnedVehicle then
		    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

if closestPlayer == -1 or closestDistance > 3.0 then
	ESX.ShowNotification('Geen spelers dichtbij!')
else
  ESX.ShowNotification('Je hebt de sleutels gegeven van het voertuig ~g~'..vehicleProps.plate..'!')
  TriggerServerEvent('sopadev_givecarkeys:setVehicleOwnedPlayerId', GetPlayerServerId(closestPlayer), vehicleProps)
end

		end
	end, GetVehicleNumberPlateText(vehicle))
end
