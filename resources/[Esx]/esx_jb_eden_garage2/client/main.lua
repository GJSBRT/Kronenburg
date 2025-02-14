﻿--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
-- Local
local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local carInstance = {}

local Voertuigen = {}

local LastTime = 0

-- Fin Local

-- Init ESX
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj)
		ESX = obj
		end)
	end
end)



function GetAvailableVehicleSpawnPoint(garage, vehicle)
    local spawnPoints = garage.SpawnPoints
    if spawnPoints == nil then
        if ESX.Game.IsSpawnPointClear(garage.SpawnPoint.Pos, 4.0, true) then
            local pos = vector3(garage.SpawnPoint.Pos.x, garage.SpawnPoint.Pos.y, garage.SpawnPoint.Pos.z)
            return true, { coords = pos, radius = 4.0, heading = garage.SpawnPoint.Heading }
        else
            ESX.ShowNotification('~r~Gebied is niet vrij!~s~')
            return false
        end
    else
        local found, numFound = false, 0
        local availableSpawnPoints = {}
        
        for i=1, #spawnPoints, 1 do
            local coords = spawnPoints[i].coords
            if spawnPoints[i].space then
                coords = SpawnCoords(coords, spawnPoints[i].heading, vehicle.model, spawnPoints[i].space)
            end
            if ESX.Game.IsSpawnPointClear(spawnPoints[i].coords, spawnPoints[i].radius) then
                table.insert(availableSpawnPoints, spawnPoints[i])
                found = true
                numFound = numFound + 1
            end
        end
        
        if found then
            return true, availableSpawnPoints[math.random(1, numFound)]
        else
            ESX.ShowNotification('~r~Gebied is niet vrij!~s~')
            return false
        end
    end
end

--Fonction Menu

function OpenMenuGarage(garage, KindOfVehicle, garage_name, vehicle_type)


	if GetGameTimer() - LastTime < 5000 then
		exports['mythic_notify']:DoHudText('error', 'Probeer het over een aantal seconden opnieuw!')
        return
    end
	LastTime = GetGameTimer()
	ESX.UI.Menu.CloseAll()

	local elements = {
		{label = _U('return_vehicle') .. "("..Config.Price.."€)", value = 'return_vehicle'},
	}


	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'garage_menu',
		{
			title    = 'Garage',
			align    = 'top-right',
			elements = elements,
		},
		function(data, menu)

			menu.close()
			if(data.current.value == 'return_vehicle') then
				ReturnVehicleMenu(garage, KindOfVehicle, garage_name, vehicle_type)
			end
		end,
		function(data, menu)
			menu.close()
		end
	)
end
-- Afficher les listes des vehicules
function ListVehiclesMenu(garage, KindOfVehicle, garage_name, vehicle_type)


	if GetGameTimer() - LastTime < 5000 then
		exports['mythic_notify']:DoHudText('error', 'Probeer het over een aantal seconden opnieuw!')
        return
    end
	LastTime = GetGameTimer()
	local elements, vehiclePropsList = {}, {}
	ESX.TriggerServerCallback('eden_garage:getVehicles', function(vehicles)
		if not table.empty(vehicles) then
			for _,v in pairs(vehicles) do
				local vehicleProps = json.decode(v.vehicle)
				vehiclePropsList[vehicleProps.plate] = vehicleProps
				local vehicleHash = vehicleProps.model
				local vehicleName, vehicleLabel
								
				if v.vehiclename then
					vehicleName = v.vehiclename					
				else
					vehicleName = GetDisplayNameFromVehicleModel(vehicleHash)
				end

				if v.fourrieremecano then
					vehicleLabel = vehicleName..': ' .. _U('pound_name')
				elseif v.stored then
					vehicleLabel = vehicleName..': ' .. _U('returns') .." ("..v.garage_name..")"
				else
					vehicleLabel = vehicleName..': ' .. _U('exits') .. " ("..v.garage_name..")"
				end
				table.insert(elements, {
					label = vehicleLabel,
					vehicleName = vehicleName,
					stored = v.stored,
					plate = vehicleProps.plate,
					fourrieremecano = v.fourrieremecano,
					garage_name = v.garage_name
				})
				
			end
		else
			table.insert(elements, {label = _U('no_cars_stored'), value = "nocar"})
		end
		ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'spawn_vehicle',
		{
			title    = 'Garage',
			align    = 'top-right',
			elements = elements,
		},
		function(data, menu)
			if data.current.value ~= "nocar" then
				local CarProps = vehiclePropsList[data.current.plate]
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_menu', {
					title    =  data.current.vehicleName,
					align    = 'top-right',
					elements = {
						{label = _U('take_out_car') , value = 'get_vehicle_out'},
						{label = _U('rename_the_car') , value = 'rename_vehicle'}
				}}, function(data2, menu2)
						if data2.current.value == "get_vehicle_out" then
							local doesVehicleExist = false
							for k,v in pairs (carInstance) do
								if ESX.Math.Trim(v.plate) == ESX.Math.Trim(data.current.plate) then
									if DoesEntityExist(v.vehicleentity) then
										doesVehicleExist = true
									else
										table.remove(carInstance, k)
										doesVehicleExist = false
									end
								end
							end
							if (doesVehicleExist) or DoesAPlayerDrivesCar(data.current.plate) then
								ESX.ShowNotification(_U('cannot_take_out'))
							elseif (data.current.fourrieremecano) then
								ESX.ShowNotification(_U('see_police_mechanic'))
							elseif garage_name ~= data.current.garage_name then
								local elem = {}
								table.insert(elem, {label = _U('yes').." $"..tostring(Config.SwitchGaragePrice) , value = 'transfer_yes'})
								table.insert(elem, {label =_U('no') , value = 'transfer_no'})
								ESX.UI.Menu.Open(
									'default', GetCurrentResourceName(), 'transfer_menu',
									{
										title    =  _U('want_to_transfer')..": "..data.current.vehicleName.._U('to_your_garage'),
										align    = 'top-right',
										elements = elem,
									},
									function(data3, menu3)
										if data3.current.value == "transfer_yes" then 
											ESX.TriggerServerCallback('eden_garage:checkMoney', function(hasEnoughMoney)
												if hasEnoughMoney then

													TriggerServerEvent("esx_eden_garage:MoveGarage",data.current.plate, garage_name)
													SpawnVehicle(CarProps, garage, KindOfVehicle)



													ESX.UI.Menu.CloseAll()

												else
													ESX.ShowNotification(_U('not_enough_money'))
												end
											end, Config.SwitchGaragePrice)
										else
											menu2.close()
											menu3.close()
										end
									end,
									function(data3, menu3)
										menu3.close()
									end
								)
							elseif (data.current.stored) then

								SpawnVehicle(CarProps, garage, KindOfVehicle)
								ESX.UI.Menu.CloseAll()

							else
								ESX.ShowNotification(_U('vehicle_already_out'))
							end
						elseif data2.current.value == "rename_vehicle" then
							ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'rename_vehicle', {
								title = _U('desired_name')
							}, function(data3, menu3)
								if string.len(data3.value) >= 1 then
									TriggerServerEvent('eden_garage:renamevehicle', data.current.plate, data3.value)
									ESX.UI.Menu.CloseAll()
									ListVehiclesMenu(garage, KindOfVehicle, garage_name, vehicle_type)
								else
									ESX.ShowNotification(_U('cannot_be_empty'))
									menu3.close()
								end

							end, function(data3, menu3)
								menu3.close()
							end)
						end
					end,
					function(data2, menu2)
						menu2.close()
					end
				)
			end
		end,
		function(data, menu)
			menu.close()
		end
	)
	end, KindOfVehicle, garage_name, vehicle_type)
end
-- Fin Afficher les listes des vehicules

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer

end)

function Watisvoertuigprijs(voertuigje)



	ESX.TriggerServerCallback('eden_garage:getVehiclesPrices',function(prijsje)

		vehicleprice = prijsje

	end,voertuigje)

	while vehicleprice == nil do Wait(0) end

	return vehicleprice
end


-- Afficher les listes des vehicules de fourriere
function ListVehiclesFourriereMenu(garage)
	local elements, vehiclePropsList = {}, {}

	ESX.TriggerServerCallback('eden_garage:getVehiclesMecano', function(vehicles)

		for k,v in ipairs(vehicles) do
			local vehicleProps = json.decode(v.vehicle)
			vehiclePropsList[vehicleProps.plate] = vehicleProps
			local vehicleHash = vehicleProps.model
			local vehicleName = GetDisplayNameFromVehicleModel(vehicleHash)
			--Watisvoertuigprijs(vehicleName)


			--ESX.TriggerServerCallback('eden_garage:getVehiclesPrices',function(prijsje)

			--	vehicleprice = prijsje
		
			--end,vehicleName)
		
			--while vehicleprice == nil do Wait(0) end



			if string.match(v.owner, 'steam:') then
				table.insert(elements, {
					label = ('%s | %s | %s | %s %s '):format(vehicleName, vehicleProps.plate, Watisvoertuigprijs(vehicleName), v.firstname, v.lastname),
					plate = vehicleProps.plate
				})
			else
				table.insert(elements, {
					label = ('%s | %s | %s | %s %s '):format(vehicleName, vehicleProps.plate, Watisvoertuigprijs(vehicleName), v.firstname, v.lastname),
					plate = vehicleProps.plate
				})
			end

		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_vehicle_mecano', {
			title    = 'Garage',
			align    = 'top-right',
			elements = elements,
		}, function(data, menu)
			local vehicleProps = vehiclePropsList[data.current.plate]
			menu.close()
			SpawnVehicleMecano(vehicleProps, garage)
			TriggerServerEvent('eden_garage:ChangeStateFrompound', vehicleProps, false)
		end, function(data, menu)
			menu.close()
		end)
	end)
end
-- Fin Afficher les listes des vehicules de fourriere


-- Fonction qui permet de rentrer un vehicule
function StockVehicleMenu(KindOfVehicle, garage_name, vehicle_type)
	local playerPed  = PlayerPedId()
	if IsPedInAnyVehicle(playerPed,  false) then
		local vehicle =GetVehiclePedIsIn(playerPed,false)
		if GetPedInVehicleSeat(vehicle, -1) == playerPed then
			local GotTrailer, TrailerHandle = GetVehicleTrailerVehicle(vehicle)
			if GotTrailer then
				local trailerProps  = GetVehicleProperties(TrailerHandle)
				if trailerProps ~= nil then
					ESX.TriggerServerCallback('eden_garage:stockv',function(valid)
						if(valid) then
							for k,v in pairs (carInstance) do
								if ESX.Math.Trim(v.plate) == ESX.Math.Trim(trailerProps.plate) then
									table.remove(carInstance, k)
								end
							end
							DeleteEntity(TrailerHandle)
							TriggerServerEvent('eden_garage:modifystate', trailerProps.plate, true)
							TriggerServerEvent("esx_eden_garage:MoveGarage", trailerProps.plate, garage_name)
							ESX.ShowNotification(_U('trailer_in_garage'))
						else
							ESX.ShowNotification(_U('cannot_store_vehicle'))
						end
					end,trailerProps, KindOfVehicle, garage_name, vehicle_type)
				else
					ESX.ShowNotification(_U('vehicle_error'))
				end
			else
				local vehicleProps  = GetVehicleProperties(vehicle)
				if vehicleProps ~= nil then
					ESX.TriggerServerCallback('eden_garage:stockv',function(valid)
						if(valid) then
							for k,v in pairs (carInstance) do
								if ESX.Math.Trim(v.plate) == ESX.Math.Trim(vehicleProps.plate) then
									table.remove(carInstance, k)
								end
							end
							DeleteEntity(vehicle)
							TriggerServerEvent('eden_garage:modifystate', vehicleProps.plate, true)
							TriggerServerEvent("esx_eden_garage:MoveGarage", vehicleProps.plate, garage_name)
							ESX.ShowNotification(_U('vehicle_in_garage'))
						else
							ESX.ShowNotification(_U('cannot_store_vehicle'))
						end
					end,vehicleProps, KindOfVehicle, garage_name, vehicle_type)
				else
					ESX.ShowNotification(_U('vehicle_error'))
				end
			end
		else
			ESX.ShowNotification(_U('not_driver'))
		end
	else
		ESX.ShowNotification(_U('no_vehicle_to_enter'))
	end
end
-- Fin fonction qui permet de rentrer un vehicule 



RegisterCommand('getacceleration', function(source, args, raw)
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    print(GetVehicleModelAcceleration(GetEntityModel(vehicle)), GetVehicleAcceleration(vehicle))
end)



RegisterCommand('zeroto', function(source, args, raw)
    local speed = tonumber(args[1])
    if not tonumber(args[1]) then
        speed = 100.0
    end
--    exports['esx_rpchat']:printToChat("[Snelheid]", ("0 - %.0f test gestard"):format(speed))
	ESX.ShowNotification('Test 0 - '.. speed .. ' gestart')
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    :: start ::
    while GetEntitySpeed(vehicle) < 0.5 do
        Citizen.Wait(0)
    end
    local start = GetGameTimer()
--    exports['esx_rpchat']:printToChat("[Snelheid]", ("Start!"):format(speed))
	ESX.ShowNotification('Start!')


    local max = GetEntitySpeed(vehicle)
    while GetEntitySpeed(vehicle) * 4.0 < speed do
        max = GetEntitySpeed(vehicle)
        if GetEntitySpeed(vehicle) < 0.25 then
--            exports['esx_rpchat']:printToChat("[Snelheid]", ("Test geherstart"):format(speed))
			ESX.ShowNotification('Test herstart')
            goto start
        end
        Citizen.Wait(0)
    end

  --  exports['esx_rpchat']:printToChat("[Snelheid]", ("0 - %.0f test geëindigd. Je voertuig deed er %.4f seconden over."):format(speed, (GetGameTimer() - start) / 1000))
	local huts = (GetGameTimer() - start) / 1000
	ESX.ShowNotification('0 - '.. speed .. ' test geëindigd. Je voertuig deed er ' .. huts .. ' seconden over.')
end)


RegisterCommand('dvfine', function()
    if not exports['EasyAdmin']:isAdmin() then
        return
    end
    
    DeleteVehicleFine()
end)

function DeleteVehicleFine()
    local playerPed = PlayerPedId()
    local vehicle, distance
    
    if IsPedInAnyVehicle(playerPed, true) then
        vehicle = GetVehiclePedIsIn(playerPed, false)
    else
        vehicle, distance = ESX.Game.GetClosestVehicle()
    end
    
    local plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
    TriggerServerCallback('esx_policejob:getVehicleInfos', function(info)
        if info.id then
            TriggerServerEvent('esx_billing:sendBill', info.id, 'society_militar', 'Boete: Fout parkeren', 1000, `esx_billing:sendBill`)
        elseif info.identifier then
            TriggerServerEvent('esx_billing:sendBillIdentifier', info.identifier, 'society_militar', "Boete: Fout parkeren", 1000, `esx_billing:sendBillIdentifier`)
        end
    end, plate)
    
    local data = {
        shouldUpdate = true,
        returnToGarage = true,
        calligSource = 'DeleteVehicleFine:336',
        delete = true,
        netId = NetworkGetNetworkIdFromEntity(vehicle)
    }
    TriggerServerEvent('eden_garage:removeFromList', ESX.Math.Trim(GetVehicleNumberPlateText(vehicle)), data)
    Citizen.Wait(1000)
    if not DoesEntityExist(vehicle) then
        return
    end
    
    NetworkRequestControlOfEntity(vehicle)
    local attempt = 0
    while not NetworkHasControlOfEntity(vehicle) and attempt < 20 and DoesEntityExist(vehicle) do
        Citizen.Wait(100)
        NetworkRequestControlOfEntity(vehicle)
        attempt = attempt + 1
    end
    
    SetEntityAsMissionEntity(vehicle, true, true)
    
    local timeout = 2000
    while timeout > 0 and not IsEntityAMissionEntity(vehicle) do
        Wait(100)
        timeout = timeout - 100
    end
    
    if DoesEntityExist(vehicle) then
        ESX.Game.DeleteVehicle(vehicle)
    end
    
    if not DoesEntityExist(vehicle) then
        return
    end
    
    local entity = vehicle
    
    NetworkRequestControlOfEntity(entity)
    
    local timeout = 2000
    while timeout > 0 and not NetworkHasControlOfEntity(entity) do
        Wait(100)
        timeout = timeout - 100
    end

    SetEntityAsMissionEntity(entity, true, true)

    local timeout = 2000
    while timeout > 0 and not IsEntityAMissionEntity(entity) do
        Wait(100)
        timeout = timeout - 100
    end

    DeleteVehicle(entity)

    if (DoesEntityExist(entity)) then
        DeleteEntity(entity)
    end
end


-- Fonction qui permet de rentrer un vehicule dans fourriere
function StockVehicleFourriereMenu()
	local playerPed  = PlayerPedId()
	if IsPedInAnyVehicle(playerPed,  false) then
		local vehicle =GetVehiclePedIsIn(playerPed,false)
		if GetPedInVehicleSeat(vehicle, -1) == playerPed then
			local GotTrailer, TrailerHandle = GetVehicleTrailerVehicle(vehicle)
			if GotTrailer then
				local trailerProps  = GetVehicleProperties(TrailerHandle)
				if trailerProps ~= nil then
					ESX.TriggerServerCallback('eden_garage:stockvmecano',function(valid)
						if(valid) then
							DeleteVehicle(TrailerHandle)
							TriggerServerEvent('eden_garage:ChangeStateFrompound', trailerProps, true)
							ESX.ShowNotification(_U('trailer_in_pound'))
						else
							ESX.ShowNotification(_U('cannot_store_pound'))
						end
					end,trailerProps)
				else
					ESX.ShowNotification(_U('vehicle_error'))
				end
			else
				local vehicleProps  = GetVehicleProperties(vehicle)
				if vehicleProps ~= nil then
					ESX.TriggerServerCallback('eden_garage:stockvmecano',function(valid)
						if(valid) then
							DeleteVehicle(vehicle)

							SetEntityAsNoLongerNeeded(vehicle)

							TriggerServerEvent('eden_garage:ChangeStateFrompound', vehicleProps, true)
							ESX.ShowNotification('Het voertuig is inbeslag genomen!')
						else
							ESX.ShowNotification(_U('cannot_store_pound'))
						end
					end,vehicleProps)
				else
					ESX.ShowNotification(_U('vehicle_error'))
				end
			end
		else
			ESX.ShowNotification(_U('not_driver'))
		end
	else
		ESX.ShowNotification(_U('no_vehicle_to_enter'))
	end
end
-- Fin fonction qui permet de rentrer un vehicule dans fourriere
--Fin fonction Menu


--Fonction pour spawn vehicule
--[[function SpawnVehicle(vehicleProps, garage, KindOfVehicle)
	ESX.Game.SpawnVehicle(vehicleProps.model, {
		x = garage.SpawnPoint.Pos.x,
		y = garage.SpawnPoint.Pos.y,
		z = garage.SpawnPoint.Pos.z + 1											
		},garage.SpawnPoint.Heading, function(callback_vehicle)
			SetVehicleProperties(callback_vehicle, vehicleProps)
			TaskWarpPedIntoVehicle(PlayerPedId(), callback_vehicle, -1)
			local carplate = GetVehicleNumberPlateText(callback_vehicle)
			table.insert(carInstance, {vehicleentity = callback_vehicle, plate = carplate})
			if KindOfVehicle == 'brewer' or KindOfVehicle == 'biker' or KindOfVehicle == 'jewelry' or KindOfVehicle == 'farmer' or KindOfVehicle == 'fisherman' or KindOfVehicle == 'fuel' or KindOfVehicle == 'johnson' or KindOfVehicle == 'miner' or KindOfVehicle == 'reporter' or KindOfVehicle == 'winemakers' or KindOfVehicle == 'tobacco' then
				TriggerEvent('esx_jobs1:addplate', carplate)
				TriggerEvent('esx_jobs2:addplate', carplate)
			end	
		end)
	TriggerServerEvent('eden_garage:modifystate', vehicleProps.plate, false)
end]]
--Fin fonction pour spawn vehicule


function SpawnVehicle(vehicleProps, garage, KindOfVehicle)
	if garage.RandomSpawns ~= nil then
		local spawned = false
		for i=1, #garage.RandomSpawns do
			--if IsPositionOccupied(garage.RandomSpawns.x, garage.RandomSpawns.y, garage.RandomSpawns.z, 3, false, true, false, false, false, 0, false) == false then
			if GetRandomVehicleInSphere(garage.RandomSpawns.x, garage.RandomSpawns.y, garage.RandomSpawns.z, 3, 0, 0) == nil then
				spawned = true
				ESX.Game.SpawnVehicle(vehicleProps.model, {
					x = garage.RandomSpawns[i].x,
					y = garage.RandomSpawns[i].y,
					z = garage.RandomSpawns[i].z + 1											
					},garage.RandomSpawns[i].h, function(callback_vehicle)
						SetVehicleProperties(callback_vehicle, vehicleProps)
						TaskWarpPedIntoVehicle(PlayerPedId(), callback_vehicle, -1)
						local carplate = GetVehicleNumberPlateText(callback_vehicle)
						table.insert(carInstance, {vehicleentity = callback_vehicle, plate = carplate})
						exports['KB_server']:spawnedPersonalVehicle(callback_vehicle)
						if KindOfVehicle == 'brewer' or KindOfVehicle == 'biker' or KindOfVehicle == 'jewelry' or KindOfVehicle == 'farmer' or KindOfVehicle == 'fisherman' or KindOfVehicle == 'fuel' or KindOfVehicle == 'johnson' or KindOfVehicle == 'miner' or KindOfVehicle == 'reporter' or KindOfVehicle == 'winemakers' or KindOfVehicle == 'tobacco' then
							TriggerEvent('esx_jobs1:addplate', carplate)
							TriggerEvent('esx_jobs2:addplate', carplate)
						end	

						SetEntityAsMissionEntity(callback_vehicle, true, true)
						
				end)
				break
			end
		end

		if spawned == false then
			math.randomseed(GetGameTimer())
			local i = math.random(1, #garage.RandomSpawns)
			ESX.Game.SpawnVehicle(vehicleProps.model, {
				x = garage.RandomSpawns[i].x,
				y = garage.RandomSpawns[i].y,
				z = garage.RandomSpawns[i].z + 1											
				},garage.RandomSpawns[i].h, function(callback_vehicle)
					SetVehicleProperties(callback_vehicle, vehicleProps)
					TaskWarpPedIntoVehicle(PlayerPedId(), callback_vehicle, -1)
					local carplate = GetVehicleNumberPlateText(callback_vehicle)
					table.insert(carInstance, {vehicleentity = callback_vehicle, plate = carplate})
					exports['KB_server']:spawnedPersonalVehicle(callback_vehicle)

					if KindOfVehicle == 'brewer' or KindOfVehicle == 'biker' or KindOfVehicle == 'jewelry' or KindOfVehicle == 'farmer' or KindOfVehicle == 'fisherman' or KindOfVehicle == 'fuel' or KindOfVehicle == 'johnson' or KindOfVehicle == 'miner' or KindOfVehicle == 'reporter' or KindOfVehicle == 'winemakers' or KindOfVehicle == 'tobacco' then
						TriggerEvent('esx_jobs1:addplate', carplate)
						TriggerEvent('esx_jobs2:addplate', carplate)
					end	

					SetEntityAsMissionEntity(callback_vehicle, true, true)

			end)
		end
	else
		ESX.Game.SpawnVehicle(vehicleProps.model, {
			x = garage.SpawnPoint.Pos.x,
			y = garage.SpawnPoint.Pos.y,
			z = garage.SpawnPoint.Pos.z + 1											
			},garage.SpawnPoint.Heading, function(callback_vehicle)
				SetVehicleProperties(callback_vehicle, vehicleProps)
				TaskWarpPedIntoVehicle(PlayerPedId(), callback_vehicle, -1)
				local carplate = GetVehicleNumberPlateText(callback_vehicle)
				table.insert(carInstance, {vehicleentity = callback_vehicle, plate = carplate})
				exports['KB_server']:spawnedPersonalVehicle(callback_vehicle)
				if KindOfVehicle == 'brewer' or KindOfVehicle == 'biker' or KindOfVehicle == 'jewelry' or KindOfVehicle == 'farmer' or KindOfVehicle == 'fisherman' or KindOfVehicle == 'fuel' or KindOfVehicle == 'johnson' or KindOfVehicle == 'miner' or KindOfVehicle == 'reporter' or KindOfVehicle == 'winemakers' or KindOfVehicle == 'tobacco' then
					TriggerEvent('esx_jobs1:addplate', carplate)
					TriggerEvent('esx_jobs2:addplate', carplate)
				end	

				SetEntityAsMissionEntity(callback_vehicle, true, true)

		end)
	end
	
	TriggerServerEvent('eden_garage:modifystate', vehicleProps.plate, false)
end



function CheckZones()
    if not PlayerData or not PlayerData.job then
        return
    end
    
    for k,v in pairs(Config.GaragesMecano) do
        if v.Job == PlayerData.job.name or (v.Jobs and v.Jobs[PlayerData.job.name]) then
            if v.DeletePoint then
                exports.ft_libs:EnableArea("esx_eden_garage_area_"..k.."_mecanodeletepoint")
            end
            if v.SpawnPoint then
                exports.ft_libs:EnableArea("esx_eden_garage_area_"..k.."_mecanospawnpoint")
            end
        else
            if v.DeletePoint then
                exports.ft_libs:DisableArea("esx_eden_garage_area_"..k.."_mecanodeletepoint")
            end
            if v.SpawnPoint then
                exports.ft_libs:DisableArea("esx_eden_garage_area_"..k.."_mecanospawnpoint")
            end
        end
    end
end



--Fonction pour spawn vehicule fourriere mecano
function SpawnVehicleMecano(vehicleProps, garage)
	ESX.Game.SpawnVehicle(vehicleProps.model, {
		x = garage.SpawnPoint.Pos.x,
		y = garage.SpawnPoint.Pos.y,
		z = garage.SpawnPoint.Pos.z + 1											
		},garage.SpawnPoint.Heading, function(callback_vehicle)
			SetVehicleProperties(callback_vehicle, vehicleProps)
			TaskWarpPedIntoVehicle(PlayerPedId(), callback_vehicle, -1)
			SetEntityAsMissionEntity(callback_vehicle, true, true)
		end)
	TriggerServerEvent('eden_garage:ChangeStateFrompound', vehicleProps, false)



end
--Fin fonction pour spawn vehicule fourriere mecano

function ReturnVehicleMenu(garage, KindOfVehicle, garage_name, vehicle_type)

	ESX.TriggerServerCallback('eden_garage:getOutVehicles', function(vehicles)
		local elements, vehiclePropsList = {}, {}
		if not table.empty(vehicles) then
			for _,v in pairs(vehicles) do
				local vehicleProps = json.decode(v.vehicle)
				vehiclePropsList[vehicleProps.plate] = vehicleProps
				local vehicleHash = vehicleProps.model
				local vehicleName, vehicleLabel

				if v.vehiclename then
					vehicleName = v.vehiclename					
				else
					vehicleName = GetDisplayNameFromVehicleModel(vehicleHash)
				end

				if v.fourrieremecano then
					vehicleLabel = vehicleName..': '.._U('pound_name')
					table.insert(elements, {label = vehicleLabel, action = 'fourrieremecano'})
				else
					vehicleLabel = vehicleName..': '.._U('exits')
					table.insert(elements, {
						label = vehicleLabel,
						plate = vehicleProps.plate,
						action = 'store'
					})
				end
			end
		else
			table.insert(elements, {label = _U('no_vehicle_out'), action = 'nothing'})
		end

		ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'return_vehicle',
		{
			title    = 'Garage',
			align    = 'top-right',
			elements = elements,
		},
		function(data, menu)
			local vehicleProps = vehiclePropsList[data.current.plate]
			if data.current.action == 'fourrieremecano' then
				ESX.ShowNotification(_U('see_police_mechanic'))
			elseif data.current.action ~= nil then
				local doesVehicleExist = false
				for k,v in pairs (carInstance) do
					if ESX.Math.Trim(v.plate) == ESX.Math.Trim(data.current.plate) then
						if DoesEntityExist(v.vehicleentity) then
							doesVehicleExist = true
						else
							table.remove(carInstance, k)
							doesVehicleExist = false
						end
					end
				end
				if not doesVehicleExist and not DoesAPlayerDrivesCar(data.current.plate) then
					ESX.TriggerServerCallback('eden_garage:checkMoney', function(hasEnoughMoney)
						if hasEnoughMoney then

							menu.close()
							SpawnVehicle(vehicleProps, garage, KindOfVehicle)

						else
							ESX.ShowNotification(_U('not_enough_money'))						
						end
					end, Config.Price)
				else
					ESX.ShowNotification(_U('cannot_take_out'))
				end				
			end
		end,
		function(data, menu)
			menu.close()
		end
		)
	end, KindOfVehicle, garage_name, vehicle_type)
end

function exitmarker()
	ESX.UI.Menu.CloseAll()
end

function DoesAPlayerDrivesCar(plate)
	local isVehicleTaken = false
	local players  = ESX.Game.GetPlayers()
	for i=1, #players, 1 do
		local target = GetPlayerPed(players[i])
		if target ~= PlayerPedId() then
			local plate1 = GetVehicleNumberPlateText(GetVehiclePedIsIn(target, true))
			local plate2 = GetVehicleNumberPlateText(GetVehiclePedIsIn(target, false))
			if plate == plate1 or plate == plate2 then
				isVehicleTaken = true
				break
			end
		end
	end
	return isVehicleTaken
end

function SetVehicleProperties(vehicle, vehicleProps)
    ESX.Game.SetVehicleProperties(vehicle, vehicleProps)

    if vehicleProps["windows"] then
        for windowId = 1, 9, 1 do
            if vehicleProps["windows"][windowId] == false then
                SmashVehicleWindow(vehicle, windowId)
            end
        end
    end

    if vehicleProps["tyres"] then
        for tyreId = 1, 7, 1 do
            if vehicleProps["tyres"][tyreId] ~= false then
                SetVehicleTyreBurst(vehicle, tyreId, true, 1000)
            end
        end
    end

    if vehicleProps["doors"] then
        for doorId = 0, 5, 1 do
            if vehicleProps["doors"][doorId] ~= false then
                SetVehicleDoorBroken(vehicle, doorId - 1, true)
            end
        end
    end
	if vehicleProps.vehicleHeadLight then SetVehicleHeadlightsColour(vehicle, vehicleProps.vehicleHeadLight) end
	
end

function GetVehicleProperties(vehicle)
    if DoesEntityExist(vehicle) then
        local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)

        vehicleProps["tyres"] = {}
        vehicleProps["windows"] = {}
        vehicleProps["doors"] = {}

        for id = 1, 7 do
            local tyreId = IsVehicleTyreBurst(vehicle, id, false)
        
            if tyreId then
                vehicleProps["tyres"][#vehicleProps["tyres"] + 1] = tyreId
        
                if tyreId == false then
                    tyreId = IsVehicleTyreBurst(vehicle, id, true)
                    vehicleProps["tyres"][ #vehicleProps["tyres"]] = tyreId
                end
            else
                vehicleProps["tyres"][#vehicleProps["tyres"] + 1] = false
            end
        end

        for id = 1, 9 do
            local windowId = IsVehicleWindowIntact(vehicle, id)

            if windowId ~= nil then
                vehicleProps["windows"][#vehicleProps["windows"] + 1] = windowId
            else
                vehicleProps["windows"][#vehicleProps["windows"] + 1] = true
            end
        end
        
        for id = 0, 5 do
            local doorId = IsVehicleDoorDamaged(vehicle, id)
        
            if doorId then
                vehicleProps["doors"][#vehicleProps["doors"] + 1] = doorId
            else
                vehicleProps["doors"][#vehicleProps["doors"] + 1] = false
            end
        end
		vehicleProps["vehicleHeadLight"]  = GetVehicleHeadlightsColour(vehicle)

        return vehicleProps
	else
		return nil
    end
end

RegisterNetEvent("ft_libs:OnClientReady")
AddEventHandler('ft_libs:OnClientReady', function()
	for k,v in pairs (Config.Garages) do
		exports.ft_libs:AddArea("esx_eden_garage_area_"..k.."_garage", {
			marker = {
				weight = v.Marker.w,
				height = v.Marker.h,
				red = v.Marker.r,
				green = v.Marker.g,
				blue = v.Marker.b,
				type = 1,
			},
			trigger = {
				weight = v.Marker.w,
				active = {
					callback = function()
						exports.ft_libs:HelpPromt(v.HelpPrompt)
						if IsControlJustReleased(0, 38) and IsInputDisabled(0) and GetLastInputMethod(2) and not IsPedInAnyVehicle(PlayerPedId()) then
							OpenMenuGarage(v, "personal", k, "car")
						end
					end,
				},
				exit = {
					callback = exitmarker
				},
			},
			blip = ((not v.DisableBlip) and {
				text = v.Name,
				colorId = Config.Blip.color,
				imageId = Config.Blip.sprite,
			} or nil),
			locations = {
				v.Pos				
			},
		})
		exports.ft_libs:AddArea("esx_eden_garage_area_"..k.."_spawnpoint", {
			marker = {
				weight = v.SpawnPoint.Marker.w,
				height = v.SpawnPoint.Marker.h,
				red = v.SpawnPoint.Marker.r,
				green = v.SpawnPoint.Marker.g,
				blue = v.SpawnPoint.Marker.b,
				type = 1,
			},
			trigger = {
				weight = v.SpawnPoint.Marker.w,
				active = {
					callback = function()
						exports.ft_libs:HelpPromt(v.SpawnPoint.HelpPrompt)
						if IsControlJustReleased(0, 38) and IsInputDisabled(0) and GetLastInputMethod(2) and not IsPedInAnyVehicle(PlayerPedId()) then
							ListVehiclesMenu(v, "personal", k, "car")
						end
					end,
				},
				exit = {
					callback = exitmarker
				},
			},
			locations = {
				{
					x = v.SpawnPoint.Pos.x,
					y = v.SpawnPoint.Pos.y,
					z = v.SpawnPoint.Pos.z,
				},
			},
		})
		exports.ft_libs:AddArea("esx_eden_garage_area_"..k.."_deletepoint", {
			marker = {
				weight = v.DeletePoint.Marker.w,
				height = v.DeletePoint.Marker.h,
				red = v.DeletePoint.Marker.r,
				green = v.DeletePoint.Marker.g,
				blue = v.DeletePoint.Marker.b,
				type = 1,
			},
			trigger = {
				weight = v.DeletePoint.Marker.w,
				active = {
					callback = function()
						exports.ft_libs:HelpPromt(v.DeletePoint.HelpPrompt)
						if IsControlJustReleased(0, 38) and IsInputDisabled(0) and GetLastInputMethod(2) then
							StockVehicleMenu("personal", k, "car")
						end
					end,
				},
				exit = {
					callback = exitmarker
				},
			},
			locations = {
				{
					x = v.DeletePoint.Pos.x,
					y = v.DeletePoint.Pos.y,
					z = v.DeletePoint.Pos.z,
				},
			},
		})
	end
	
	for k,v in pairs (Config.GaragesMecano) do
		exports.ft_libs:AddArea("esx_eden_garage_area_"..k.."_mecanospawnpoint", {
			enable = false,
			marker = {
				weight = v.SpawnPoint.Marker.w,
				height = v.SpawnPoint.Marker.h,
				red = v.SpawnPoint.Marker.r,
				green = v.SpawnPoint.Marker.g,
				blue = v.SpawnPoint.Marker.b,
				type = 1,
			},
			trigger = {
				weight = v.SpawnPoint.Marker.w,
				active = {
					callback = function()
						exports.ft_libs:HelpPromt(v.SpawnPoint.HelpPrompt)
						if IsControlJustReleased(0, 38) and IsInputDisabled(0) and GetLastInputMethod(2) and not IsPedInAnyVehicle(PlayerPedId()) then
							ListVehiclesFourriereMenu(v)
						end
					end,
				},
				exit = {
					callback = exitmarker
				},
			},
			blip = {
				text = v.Name,
				colorId = Config.MecanoBlip.color,
				imageId = Config.MecanoBlip.sprite,
			},
			locations = {
				{
					x = v.SpawnPoint.Pos.x,
					y = v.SpawnPoint.Pos.y,
					z = v.SpawnPoint.Pos.z,
				},
			},
		})
		exports.ft_libs:AddArea("esx_eden_garage_area_"..k.."_mecanodeletepoint", {
			enable = false,
			marker = {
				weight = v.DeletePoint.Marker.w,
				height = v.DeletePoint.Marker.h,
				red = v.DeletePoint.Marker.r,
				green = v.DeletePoint.Marker.g,
				blue = v.DeletePoint.Marker.b,
				type = 1,
			},
			trigger = {
				weight = v.DeletePoint.Marker.w,
				active = {
					callback = function()
						exports.ft_libs:HelpPromt(v.DeletePoint.HelpPrompt)
						if IsControlJustReleased(0, 38) and IsInputDisabled(0) and GetLastInputMethod(2) then
							StockVehicleFourriereMenu()
						end
					end,
				},
				exit = {
					callback = exitmarker
				},
			},
			locations = {
				{
					x = v.DeletePoint.Pos.x,
					y = v.DeletePoint.Pos.y,
					z = v.DeletePoint.Pos.z,
				},
			},
		})
	end
	
	for k,v in pairs (Config.BoatGarages) do
		exports.ft_libs:AddArea("esx_eden_garage_area_"..k.."_garage_BoatGarages", {
			marker = {
				weight = v.Marker.w,
				height = v.Marker.h,
				red = v.Marker.r,
				green = v.Marker.g,
				blue = v.Marker.b,
				type = 1,
			},
			trigger = {
				weight = v.Marker.w,
				active = {
					callback = function()
						exports.ft_libs:HelpPromt(v.HelpPrompt)
						if IsControlJustReleased(0, 38) and IsInputDisabled(0) and GetLastInputMethod(2) and not IsPedInAnyVehicle(PlayerPedId()) then
							OpenMenuGarage(v, "personal", k, "boat")
						end
					end,
				},
				exit = {
					callback = exitmarker
				},
			},
			blip = {
				text = v.Name,
				colorId = Config.BoatBlip.color,
				imageId = Config.BoatBlip.sprite,
			},
			locations = {
				v.Pos				
			},
		})
		exports.ft_libs:AddArea("esx_eden_garage_area_"..k.."_spawnpoint_BoatGarages", {
			marker = {
				weight = v.SpawnPoint.Marker.w,
				height = v.SpawnPoint.Marker.h,
				red = v.SpawnPoint.Marker.r,
				green = v.SpawnPoint.Marker.g,
				blue = v.SpawnPoint.Marker.b,
				type = 1,
			},
			trigger = {
				weight = v.SpawnPoint.Marker.w,
				active = {
					callback = function()
						exports.ft_libs:HelpPromt(v.SpawnPoint.HelpPrompt)
						if IsControlJustReleased(0, 38) and IsInputDisabled(0) and GetLastInputMethod(2) and not IsPedInAnyVehicle(PlayerPedId()) then
							ListVehiclesMenu(v, "personal", k, "boat")
						end
					end,
				},
				exit = {
					callback = exitmarker
				},
			},
			locations = {
				{
					x = v.SpawnPoint.MarkerPos.x,
					y = v.SpawnPoint.MarkerPos.y,
					z = v.SpawnPoint.MarkerPos.z,
				},
			},
		})
		exports.ft_libs:AddArea("esx_eden_garage_area_"..k.."_deletepoint_BoatGarages", {
			marker = {
				weight = v.DeletePoint.Marker.w,
				height = v.DeletePoint.Marker.h,
				red = v.DeletePoint.Marker.r,
				green = v.DeletePoint.Marker.g,
				blue = v.DeletePoint.Marker.b,
				type = 1,
			},
			trigger = {
				weight = v.DeletePoint.Marker.w,
				active = {
					callback = function()
						exports.ft_libs:HelpPromt(v.DeletePoint.HelpPrompt)
						if IsControlJustReleased(0, 38) and IsInputDisabled(0) and GetLastInputMethod(2) then
							StockVehicleMenu("personal", k, "boat")
						end
					end,
				},
				exit = {
					callback = exitmarker
				},
			},
			locations = {
				{
					x = v.DeletePoint.Pos.x,
					y = v.DeletePoint.Pos.y,
					z = v.DeletePoint.Pos.z,
				},
			},
		})
	end
	
	
	for k,v in pairs (Config.AirplaneGarages) do
		exports.ft_libs:AddArea("esx_eden_garage_area_"..k.."_garage_AirplaneGarages", {
			marker = {
				weight = v.Marker.w,
				height = v.Marker.h,
				red = v.Marker.r,
				green = v.Marker.g,
				blue = v.Marker.b,
				type = 1,
			},
			trigger = {
				weight = v.Marker.w,
				active = {
					callback = function()
						exports.ft_libs:HelpPromt(v.HelpPrompt)
						if IsControlJustReleased(0, 38) and IsInputDisabled(0) and GetLastInputMethod(2) and not IsPedInAnyVehicle(PlayerPedId()) then
							OpenMenuGarage(v, "personal", k, "airplane")
						end
					end,
				},
				exit = {
					callback = exitmarker
				},
			},
			blip = {
				text = v.Name,
				colorId = Config.AirplaneBlip.color,
				imageId = Config.AirplaneBlip.sprite,
			},
			locations = {
				v.Pos				
			},
		})
		exports.ft_libs:AddArea("esx_eden_garage_area_"..k.."_spawnpoint_AirplaneGarages", {
			marker = {
				weight = v.SpawnPoint.Marker.w,
				height = v.SpawnPoint.Marker.h,
				red = v.SpawnPoint.Marker.r,
				green = v.SpawnPoint.Marker.g,
				blue = v.SpawnPoint.Marker.b,
				type = 1,
			},
			trigger = {
				weight = v.SpawnPoint.Marker.w,
				active = {
					callback = function()
						exports.ft_libs:HelpPromt(v.SpawnPoint.HelpPrompt)
						if IsControlJustReleased(0, 38) and IsInputDisabled(0) and GetLastInputMethod(2) and not IsPedInAnyVehicle(PlayerPedId()) then
							ListVehiclesMenu(v, "personal", k, "airplane")
						end
					end,
				},
				exit = {
					callback = exitmarker
				},
			},
			locations = {
				{
					x = v.SpawnPoint.Pos.x,
					y = v.SpawnPoint.Pos.y,
					z = v.SpawnPoint.Pos.z,
				},
			},
		})
		exports.ft_libs:AddArea("esx_eden_garage_area_"..k.."_deletepoint_AirplaneGarages", {
			marker = {
				weight = v.DeletePoint.Marker.w,
				height = v.DeletePoint.Marker.h,
				red = v.DeletePoint.Marker.r,
				green = v.DeletePoint.Marker.g,
				blue = v.DeletePoint.Marker.b,
				type = 1,
			},
			trigger = {
				weight = v.DeletePoint.Marker.w,
				active = {
					callback = function()
						exports.ft_libs:HelpPromt(v.DeletePoint.HelpPrompt)
						if IsControlJustReleased(0, 38) and IsInputDisabled(0) and GetLastInputMethod(2) then
							StockVehicleMenu("personal", k, "airplane")
						end
					end,
				},
				exit = {
					callback = exitmarker
				},
			},
			locations = {
				{
					x = v.DeletePoint.Pos.x,
					y = v.DeletePoint.Pos.y,
					z = v.DeletePoint.Pos.z,
				},
			},
		})
	end
	for k,v in pairs (Config.SocietyGarages) do
		for key, value in pairs (v) do
			exports.ft_libs:AddArea("esx_eden_garage_area_"..k.."_garage_society_"..key, {
				enable = false,
				marker = {
					weight = value.Marker.w,
					height = value.Marker.h,
					red = value.Marker.r,
					green = value.Marker.g,
					blue = value.Marker.b,
					type = 1,
				},
				trigger = {
					weight = value.Marker.w,
					active = {
						callback = function()
							exports.ft_libs:HelpPromt(value.HelpPrompt)
							if IsControlJustReleased(0, 38) and IsInputDisabled(0) and GetLastInputMethod(2) and not IsPedInAnyVehicle(PlayerPedId()) then
								OpenMenuGarage(value, k, k, "car")
							end
						end,
					},
					exit = {
						callback = exitmarker
					},
				},
				blip = {
					text = value.Name,
					colorId = Config.AirplaneBlip.color,
					imageId = Config.AirplaneBlip.sprite,
				},
				locations = {
					value.Pos				
				},
			})
			exports.ft_libs:AddArea("esx_eden_garage_area_"..k.."_spawnpoint_society_"..key, {
				enable = false,
				marker = {
					weight = value.SpawnPoint.Marker.w,
					height = value.SpawnPoint.Marker.h,
					red = value.SpawnPoint.Marker.r,
					green = value.SpawnPoint.Marker.g,
					blue = value.SpawnPoint.Marker.b,
					type = 1,
				},
				trigger = {
					weight = value.SpawnPoint.Marker.w,
					active = {
						callback = function()
							exports.ft_libs:HelpPromt(value.SpawnPoint.HelpPrompt)
							if IsControlJustReleased(0, 38) and IsInputDisabled(0) and GetLastInputMethod(2) and not IsPedInAnyVehicle(PlayerPedId()) then
								ListVehiclesMenu(value, k, k, "car")
							end
						end,
					},
					exit = {
						callback = exitmarker
					},
				},
				locations = {
					{
						x = value.SpawnPoint.Pos.x,
						y = value.SpawnPoint.Pos.y,
						z = value.SpawnPoint.Pos.z,
					},
				},
			})
			exports.ft_libs:AddArea("esx_eden_garage_area_"..k.."_deletepoint_society_"..key, {
				enable = false,
				marker = {
					weight = value.DeletePoint.Marker.w,
					height = value.DeletePoint.Marker.h,
					red = value.DeletePoint.Marker.r,
					green = value.DeletePoint.Marker.g,
					blue = value.DeletePoint.Marker.b,
					type = 1,
				},
				trigger = {
					weight = value.DeletePoint.Marker.w,
					active = {
						callback = function()
							exports.ft_libs:HelpPromt(value.DeletePoint.HelpPrompt)
							if IsControlJustReleased(0, 38) and IsInputDisabled(0) and GetLastInputMethod(2) then
								StockVehicleMenu(k, k, "car")
							end
						end,
					},
					exit = {
						callback = exitmarker
					},
				},
				locations = {
					{
						x = value.DeletePoint.Pos.x,
						y = value.DeletePoint.Pos.y,
						z = value.DeletePoint.Pos.z,
					},
				},
			})
		end
	end
end)

-- Fin controle touche

function table.empty (self)
    for _, _ in pairs(self) do
        return false
    end
    return true
end

--- garage societe

RegisterNetEvent('esx_eden_garage:ListVehiclesMenu')
AddEventHandler('esx_eden_garage:ListVehiclesMenu', function(garage, society, societygarage)
	if not IsPedInAnyVehicle(PlayerPedId()) then
		ListVehiclesMenu(garage, society, societygarage, "car")
	end
end)

RegisterNetEvent('esx_eden_garage:OpenMenuGarage')
AddEventHandler('esx_eden_garage:OpenMenuGarage', function(garage, society, societygarage)
	if not IsPedInAnyVehicle(PlayerPedId()) then
		OpenMenuGarage(garage, society, societygarage, "car")
	end
end)

RegisterNetEvent('esx_eden_garage:StockVehicleMenu')
AddEventHandler('esx_eden_garage:StockVehicleMenu', function(society, societygarage)
	StockVehicleMenu(society, societygarage, "car")
end)


RegisterNetEvent('esx_eden_garage:EnableSocietyGarage')
AddEventHandler('esx_eden_garage:EnableSocietyGarage', function(society, bool)
	if bool then
		for k,v in pairs (Config.SocietyGarages) do
			for key, value in pairs (v) do
				if k == society then
					exports.ft_libs:EnableArea("esx_eden_garage_area_"..k.."_deletepoint_society_"..key)
					exports.ft_libs:EnableArea("esx_eden_garage_area_"..k.."_spawnpoint_society_"..key)
					exports.ft_libs:EnableArea("esx_eden_garage_area_"..k.."_garage_society_"..key)
				end
			end
		end
	else
		for k,v in pairs (Config.SocietyGarages) do
			for key, value in pairs (v) do
				if k == society then
					exports.ft_libs:DisableArea("esx_eden_garage_area_"..k.."_deletepoint_society_"..key)
					exports.ft_libs:DisableArea("esx_eden_garage_area_"..k.."_spawnpoint_society_"..key)
					exports.ft_libs:DisableArea("esx_eden_garage_area_"..k.."_garage_society_"..key)
				end
			end
		end
	end
end)
