--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
-- Client

ESX               = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function IsOnCayoPerico(coords)
    coords = coords or GetEntityCoords(PlayerPedId())
    if type(coords) ~= "vector3" then
        coords = vector3(coords.x, coords.y, coords.z)
    end
    local distance = #(vector2(4754, -5166) - coords.xy)
    if distance <= 1100 then
        return true
    end

    return false
end

RegisterNetEvent("esx_givecarkeys:keys")
AddEventHandler("esx_givecarkeys:keys", function()

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
	local vehModel = GetEntityModel(vehicle)

    for i=1, #Config.blackList do
        if vehModel == Config.blackList[i] then
            ESX.ShowNotification("Dit voertuig kan je niet geven!")
            return
        end
    end

	if IsOnCayoPerico(coords) then
		ESX.TriggerServerCallback('esx_givecarkeys:requestPlayerCarsCayo', function(isOwnedVehicle)
			if not isOwnedVehicle then
				ESX.ShowNotification('Je bezit geen voertuig die dichtbij is.')
			elseif isOwnedVehicle then
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	
				if closestPlayer == -1 or closestDistance > 3.0 then
					ESX.ShowNotification('Geen spelers dichtbij!')
				else
				ESX.ShowNotification('Je hebt de sleutels gegeven van het voertuig ~g~'..vehicleProps.plate..'! De persoon moet het voertuig in en uit zijn garage halen om het slot te laten werken')
				TriggerServerEvent('esx_givecarkeys:setVehicleOwnedPlayerId', GetPlayerServerId(closestPlayer), vehicleProps)
				end
	
			end
		end, GetVehicleNumberPlateText(vehicle))
	else

		ESX.TriggerServerCallback('esx_givecarkeys:requestPlayerCars', function(isOwnedVehicle)
			if not isOwnedVehicle then
				ESX.ShowNotification('Je bezit geen voertuig die dichtbij is.')
			elseif isOwnedVehicle then
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

				if closestPlayer == -1 or closestDistance > 3.0 then
					ESX.ShowNotification('Geen spelers dichtbij!')
				else
				ESX.ShowNotification('Je hebt de sleutels gegeven van het voertuig ~g~'..vehicleProps.plate..'! De persoon moet het voertuig in en uit zijn garage halen om het slot te laten werken')
				TriggerServerEvent('esx_givecarkeys:setVehicleOwnedPlayerId', GetPlayerServerId(closestPlayer), vehicleProps)
				end

			end
		end, GetVehicleNumberPlateText(vehicle))
	end
end

TriggerEvent('chat:addSuggestion', '/geefsleutel', 'Geef sleutel van auto aan andere speler', {
})


--TriggerEvent('chat:addSuggestion', '/geefreservesleutel', 'Geef reserve sleutel van auto aan andere speler', {
--})

--[[
RegisterCommand('geefsleutel', function(source, args)
	local playerPed = GetPlayerPed(-1)
	local coords    = GetEntityCoords(playerPed)

	if IsPedInAnyVehicle(playerPed,  false) then
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
			local ID = GetPlayerServerId()

				if closestPlayer == -1 or closestDistance > 3.0 then
					ESX.ShowNotification('Geen spelers dichtbij!')
				else
					ESX.ShowNotification('Je hebt de sleutels gegeven van het voertuig ~g~'..vehicleProps.plate..' aan ID : ' .. ID .. " !")
					TriggerServerEvent('esx_givecarkeys:setVehicleOwnedPlayerId', GetPlayerServerId(closestPlayer), vehicleProps)
				end

		end
	end, GetVehicleNumberPlateText(vehicle))
end)]]

--[[
RegisterCommand('geefreservesleutel', function(source)

	local playerPed = GetPlayerPed(-1)
	local playersNearby = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 3.0)
	local coords    = GetEntityCoords(playerPed)

	if IsPedInAnyVehicle(playerPed,  false) then
		vehicle = GetVehiclePedIsIn(playerPed, false)			
	else
		vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 7.0, 0, 70)
	end

	local plate = GetVehicleNumberPlateText(vehicle)
	local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
	local vehModel = GetEntityModel(vehicle)

	for i=1, #Config.blackList do
		if vehModel == Config.blackList[i] then
			ESX.ShowNotification("Dit voertuig kan je niet geven!")
			return
		end
	end

				if #playersNearby > 0 then
					local players = {}
					elements = {}

					for k,playerNearby in ipairs(playersNearby) do
						players[GetPlayerServerId(playerNearby)] = true
					end

					ESX.TriggerServerCallback('esx:getPlayerNames', function(returnedPlayers)
						for playerId,playerName in pairs(returnedPlayers) do
							table.insert(elements, {
								label = playerId,
								playerId = playerId
							})
						end

						ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'give_item_to', {
							title    = ('Geef sleutels aan..'),
							align    = 'bottom-right',
							elements = elements
						}, function(data2, menu2)
							local selectedPlayer, selectedPlayerId = GetPlayerFromServerId(data2.current.playerId), data2.current.playerId
							playersNearby = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 3.0)
							playersNearby = ESX.Table.Set(playersNearby)

							if playersNearby[selectedPlayer] then
								local selectedPlayerPed = GetPlayerPed(selectedPlayer)


								ESX.TriggerServerCallback('esx_givecarkeys:requestPlayerCars', function(isOwnedVehicle)
									if not isOwnedVehicle then
										ESX.ShowNotification('Je bezit geen voertuig die dichtbij is.')
									elseif isOwnedVehicle then
										local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
										local ID = GetPlayerServerId()

										if closestPlayer == -1 or closestDistance > 3.0 then
											ESX.ShowNotification('Geen spelers dichtbij!')
										else
--											ESX.ShowNotification('Je hebt de sleutels gegeven van het voertuig ~g~'..vehicleProps.plate..' aan ID : ' .. GetPlayerServerId(selectedPlayer) .. " !")
--											TriggerServerEvent('esx_givecarkeys:setVehicleOwnedPlayerId', GetPlayerServerId(selectedPlayer), vehicleProps)
											local plate = GetVehicleNumberPlateText(vehicle)
											local player = GetPlayerServerId(NetworkGetEntityOwner(selectedPlayer))
											exports['esx_vehiclelock']:giveVehicleKeys(plate, player)

										end

									end
								end, GetVehicleNumberPlateText(vehicle))
								menu2.close()
							else
								ESX.ShowNotification('Geen spelers dichtbij!')
								menu2.close()
							end
						end, function(data2, menu2)
							menu2.close()
						end)
					end, players)
				else
					ESX.ShowNotification('Geen spelers dichtbij!')
				end
end)]]

RegisterCommand('geefsleutel', function(source)

	local playerPed = GetPlayerPed(-1)
	local playersNearby = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 3.0)
	local coords    = GetEntityCoords(playerPed)

	if IsPedInAnyVehicle(playerPed,  false) then
		vehicle = GetVehiclePedIsIn(playerPed, false)			
	else
		vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 7.0, 0, 70)
	end

	local plate = GetVehicleNumberPlateText(vehicle)
	local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
	local vehModel = GetEntityModel(vehicle)

	for i=1, #Config.blackList do
		if vehModel == Config.blackList[i] then
			ESX.ShowNotification("Dit voertuig kan je niet geven!")
			return
		end
	end

				if #playersNearby > 0 then
					local players = {}
					elements = {}

					for k,playerNearby in ipairs(playersNearby) do
						players[GetPlayerServerId(playerNearby)] = true
					end

					ESX.TriggerServerCallback('esx:getPlayerNames', function(returnedPlayers)
						for playerId,playerName in pairs(returnedPlayers) do
							table.insert(elements, {
								label = playerId,
								playerId = playerId
							})
						end

						ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'give_item_to', {
							title    = ('Geef sleutels aan..'),
							align    = 'bottom-right',
							elements = elements
						}, function(data2, menu2)
							local selectedPlayer, selectedPlayerId = GetPlayerFromServerId(data2.current.playerId), data2.current.playerId
							playersNearby = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 3.0)
							playersNearby = ESX.Table.Set(playersNearby)

							if playersNearby[selectedPlayer] then
								local selectedPlayerPed = GetPlayerPed(selectedPlayer)


								ESX.TriggerServerCallback('esx_givecarkeys:requestPlayerCars', function(isOwnedVehicle)
									if not isOwnedVehicle then
										ESX.ShowNotification('Je bezit geen voertuig die dichtbij is.')
									elseif isOwnedVehicle then
										local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
										local ID = GetPlayerServerId()

										if closestPlayer == -1 or closestDistance > 3.0 then
											ESX.ShowNotification('Geen spelers dichtbij!')
										else
											ESX.ShowNotification('Je hebt de sleutels gegeven van het voertuig ~g~'..vehicleProps.plate..' aan ID : ' .. GetPlayerServerId(selectedPlayer) .. " !")
											TriggerServerEvent('esx_givecarkeys:setVehicleOwnedPlayerId', GetPlayerServerId(selectedPlayer), vehicleProps)
										end

									end
								end, GetVehicleNumberPlateText(vehicle))
								menu2.close()
							else
								ESX.ShowNotification('Geen spelers dichtbij!')
								menu2.close()
							end
						end, function(data2, menu2)
							menu2.close()
						end)
					end, players)
				else
					ESX.ShowNotification('Geen spelers dichtbij!')
				end
end)







