--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
local HasAlreadyEnteredMarker, LastZone                                                  = false, nil
local CurrentAction, CurrentActionMsg, CurrentActionData                                 = nil, '', {}
local CurrentlyTowedVehicle, Blips, NPCOnJob, NPCTargetTowable, NPCTargetTowableZone     = nil, {}, false, nil, nil
local NPCHasSpawnedTowable, NPCLastCancel, NPCHasBeenNextToTowable, NPCTargetDeleterZone = false, GetGameTimer() - 5 * 60000, false, false
local isDead, isBusy                                                                     = false, false
local sleep                                                                              = 0
local PlayerData                                                                         = {}

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(7)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

function SelectRandomTowable()
	local index = GetRandomIntInRange(1, #Config.Towables)

	for k, v in pairs(Config.Zones) do
		if v.Pos.x == Config.Towables[index].x and v.Pos.y == Config.Towables[index].y and v.Pos.z == Config.Towables[index].z then
			return k
		end
	end
end

function StartNPCJob()
	NPCOnJob = true

	NPCTargetTowableZone = SelectRandomTowable()
	local zone           = Config.Zones[NPCTargetTowableZone]

	Blips['NPCTargetTowableZone'] = AddBlipForCoord(zone.Pos.x, zone.Pos.y, zone.Pos.z)
	SetBlipRoute(Blips['NPCTargetTowableZone'], true)

	ESX.ShowNotification(_U('drive_to_indicated'))
end

function StopNPCJob(cancel)
	if Blips['NPCTargetTowableZone'] then
		RemoveBlip(Blips['NPCTargetTowableZone'])
		Blips['NPCTargetTowableZone'] = nil
	end

	if Blips['NPCDelivery'] then
		RemoveBlip(Blips['NPCDelivery'])
		Blips['NPCDelivery'] = nil
	end

	Config.Zones.VehicleDelivery.Type = -1

	NPCOnJob                = false
	NPCTargetTowable        = nil
	NPCTargetTowableZone    = nil
	NPCHasSpawnedTowable    = false
	NPCHasBeenNextToTowable = false

	if cancel then
		ESX.ShowNotification(_U('mission_canceled'))
	else
		--TriggerServerEvent('esx_mechanicjob:onNPCJobCompleted')
	end
end

function OpenMechanicActionsMenu()
	local elements = {
		{ label = _U('vehicle_list'), value = 'vehicle_list' },
		{ label = _U('work_wear'), value = 'cloakroom' },
		{ label = "Pak Benodigheden", value = 'get_items' },
		{ label = "Deponeer Benodigheden", value = 'remove_items' },
		--		{label = _U('deposit_stock'),  value = 'put_stock'},
		--		{label = _U('withdraw_stock'), value = 'get_stock'}
	}

	if Config.EnablePlayerManagement and PlayerData.job and PlayerData.job.grade_name == 'boss' then
		table.insert(elements, { label = _U('boss_actions'), value = 'boss_actions' })
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mechanic_actions', {
		title    = _U('mechanic'),
		align    = 'top-right',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'vehicle_list' then
			if Config.EnableSocietyOwnedVehicles then

				local elements = {}

				ESX.TriggerServerCallback('esx_society:getVehiclesInGarage', function(vehicles)
					for i = 1, #vehicles, 1 do
						table.insert(elements, {
							label = GetDisplayNameFromVehicleModel(vehicles[i].model) .. ' [' .. vehicles[i].plate .. ']',
							value = vehicles[i]
						})
					end

					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner', {
						title    = _U('service_vehicle'),
						align    = 'top-right',
						elements = elements
					}, function(data, menu)
						menu.close()
						local vehicleProps = data.current.value

						ESX.Game.SpawnVehicle(vehicleProps.model, Config.Zones.VehicleSpawnPoint.Pos, 71.21, function(vehicle)
							ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
							TriggerServerEvent("pepperspray:addVehiclePlate", GetVehicleNumberPlateText(vehicle))
							Wait(200)
							local playerPed = PlayerPedId()
							exports['KB_server']:spawnedPersonalVehicle(vehicle)
							TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
							exports['KB_server']:spawnedPersonalVehicle(vehicle)
						end)

						TriggerServerEvent('esx_society:removeVehicleFromGarage', 'mechanic', vehicleProps)
					end, function(data, menu)
						menu.close()
					end)
				end, 'mechanic')

			else

				local elements = {
					{ label = 'Mercedes Vito', value = 'anwbvito' },
					{ label = 'Volkswagen T5', value = 'anwbt5' },
					{ label = 'Volkswagen T6', value = 'anwbt6' },
					{ label = 'Volkswagen touran', value = 'anwbtouran' },
					{ label = 'Volkswagen Caddy', value = 'anwbcaddy' },
					{ label = 'Hyundai', value = 'anwbhyundai' },
					{ label = 'Ford Raptor', value = 'anwbraptor' },
					{ label = 'Volkswagen Amarok', value = 'anwbamarok' },
					{ label = 'Flatbed slide', value = 'flatbed3' },
				}



				ESX.UI.Menu.CloseAll()

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_vehicle', {
					title    = _U('service_vehicle'),
					align    = 'top-right',
					elements = elements
				}, function(data, menu)
					if Config.MaxInService == -1 then
						ESX.Game.SpawnVehicle(data.current.value, Config.Zones.VehicleSpawnPoint.Pos, 71.21, function(vehicle)
							local playerPed = PlayerPedId()
							TriggerServerEvent("pepperspray:addVehiclePlate", GetVehicleNumberPlateText(vehicle))
							Wait(200)
							TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
							SetVehicleNumberPlateText(vehicle, "ANWB")
							SetVehicleCustomPrimaryColour(vehicle, 255, 255, 255)
							exports['KB_server']:spawnedPersonalVehicle(vehicle)
						end)
					else
						ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)
							if canTakeService then
								ESX.Game.SpawnVehicle(data.current.value, Config.Zones.VehicleSpawnPoint.Pos, 71.21, function(vehicle)
									TriggerServerEvent("pepperspray:addVehiclePlate", GetVehicleNumberPlateText(vehicle))
									Wait(200)
									SetVehicleCustomPrimaryColour(vehicle, 255, 255, 255)
									local playerPed = PlayerPedId()
									TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
									exports['KB_server']:spawnedPersonalVehicle(vehicle)
								end)
							else
								ESX.ShowNotification(_U('service_full') .. inServiceCount .. '/' .. maxInService)
							end
						end, 'mechanic')
					end

					menu.close()
				end, function(data, menu)
					menu.close()
					OpenMechanicActionsMenu()
				end)

			end
		elseif data.current.value == 'cloakroom' then
			OpenCloakroomMenu()
		elseif data.current.value == 'cloakroom2' then
			menu.close()
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
		elseif data.current.value == 'get_items' then
			TriggerServerEvent('esx_mechanicjob:pakspullen')
		elseif data.current.value == 'remove_items' then
			TriggerServerEvent('esx_mechanicjob:removespullen')
		elseif data.current.value == 'get_stock' then
			OpenGetStocksMenu()
		elseif data.current.value == 'boss_actions' then
			TriggerEvent('esx_society:openBossMenu', 'mechanic', function(data, menu)
				menu.close()
			end)
		end
	end, function(data, menu)
		menu.close()

		CurrentAction     = 'mechanic_actions_menu'
		CurrentActionMsg  = _U('open_actions')
		CurrentActionData = {}
	end)
end

function setUniform(job, playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)

		if skin.sex == 0 then
			if Config.Uniforms[job].male ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].male)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end
		else
			if Config.Uniforms[job].female ~= nil then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].female)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end
		end

	end)
end

function cleanPlayer(playerPed)
	SetPedArmour(playerPed, 0)
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
	ResetPedMovementClipset(playerPed, 0)
end

function OpenCloakroomMenu()

	local playerPed = PlayerPedId()

	local elements = {
		{ label = 'Burger kleding', value = 'citizen_wear' },
		--  { label = 'ANWB Wegenwacht Kort [1]', value = 'anwb_kleding_1' },
		--  { label = 'ANWB Wegenwacht Kort [2]', value = 'anwb_kleding_2' },
		{ label = 'ANWB Wegenwacht Lang [1]', value = 'anwb_kleding_3' },
		{ label = 'ANWB Wegenwacht Lang [2]', value = 'anwb_kleding_4' },
		{ label = 'ANWB pet', value = 'anwb_pet' },
		--  { label = 'Rijkswaterstaat kleding', value = 'rijkswaterstaat_kleding' },
		--  { label = 'Motor kleding', value = 'motor_wear' }
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'cloakroom',
		{
			title    = _U('cloakroom'),
			align    = 'top-right',
			elements = elements,
		},
		function(data, menu)

			cleanPlayer(playerPed)

			if data.current.value == 'citizen_wear' then
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
					TriggerEvent('skinchanger:loadSkin', skin)
					RemoveAllPedWeapons(playerPed, true)
					exports["rp-radio"]:SetRadio(false)
					exports["rp-radio"]:RemovePlayerAccessToFrequencies(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
				end)
			end

			if data.current.value == 'motor_wear'
			then
				setUniform(data.current.value, playerPed)
				exports["rp-radio"]:SetRadio(true)
				exports["rp-radio"]:GivePlayerAccessToFrequencies(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
				TriggerServerEvent("esx_mechanicjob:mechanicblips")
			end

			if data.current.value == 'anwb_kleding_1'
			then
				setUniform(data.current.value, playerPed)
				exports["rp-radio"]:SetRadio(true)
				exports["rp-radio"]:GivePlayerAccessToFrequencies(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
			end

			if data.current.value == 'anwb_kleding_2'
			then
				setUniform(data.current.value, playerPed)
				exports["rp-radio"]:SetRadio(true)
				exports["rp-radio"]:GivePlayerAccessToFrequencies(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
			end

			if data.current.value == 'anwb_kleding_3'
			then
				setUniform(data.current.value, playerPed)
				exports["rp-radio"]:SetRadio(true)
				exports["rp-radio"]:GivePlayerAccessToFrequencies(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
			end

			if data.current.value == 'anwb_kleding_4'
			then
				setUniform(data.current.value, playerPed)
				exports["rp-radio"]:SetRadio(true)
				exports["rp-radio"]:GivePlayerAccessToFrequencies(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
			end

			if data.current.value == 'anwb_pet'
			then
				setUniform(data.current.value, playerPed)
				exports["rp-radio"]:SetRadio(true)
				exports["rp-radio"]:GivePlayerAccessToFrequencies(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
			end

			if data.current.value == 'rijkswaterstaat_kleding'
			then
				setUniform(data.current.value, playerPed)
				exports["rp-radio"]:SetRadio(true)
				exports["rp-radio"]:GivePlayerAccessToFrequencies(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
			end

			if data.current.value == 'sheriff_wear_freemode' or
				data.current.value == 'lieutenant_wear_freemode' or
				data.current.value == 'commandant_wear_freemode'
			then
				local model = nil
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
					if skin.sex == 0 then
						model = GetHashKey(data.current.maleModel)
					else
						model = GetHashKey(data.current.femaleModel)
					end
				end)

				RequestModel(model)
				while not HasModelLoaded(model) do
					RequestModel(model)
					Citizen.Wait(7)
				end

				SetPlayerModel(PlayerId(), model)
				SetModelAsNoLongerNeeded(model)
			end

			CurrentAction     = 'ambulance_actions_menu'
			CurrentActionMsg  = _U('open_actions')
			CurrentActionData = {}
		end, function(data, menu)
		menu.close()
	end)
end

function OpenMechanicHarvestMenu()
	if Config.EnablePlayerManagement and PlayerData.job and PlayerData.job.grade_name ~= 'recrue' then
		local elements = {
			{ label = _U('gas_can'), value = 'gaz_bottle' },
			{ label = _U('repair_tools'), value = 'fix_tool' },
			{ label = _U('body_work_tools'), value = 'caro_tool' }
		}

		ESX.UI.Menu.CloseAll()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mechanic_harvest', {
			title    = _U('harvest'),
			align    = 'top-right',
			elements = elements
		}, function(data, menu)
			menu.close()

			if data.current.value == 'gaz_bottle' then
				TriggerServerEvent('esx_mechanicjob:startHarvest')
			elseif data.current.value == 'fix_tool' then
				TriggerServerEvent('esx_mechanicjob:startHarvest2')
			elseif data.current.value == 'caro_tool' then
				TriggerServerEvent('esx_mechanicjob:startHarvest3')
			end
		end, function(data, menu)
			menu.close()
			CurrentAction     = 'mechanic_harvest_menu'
			CurrentActionMsg  = _U('harvest_menu')
			CurrentActionData = {}
		end)
	else
		ESX.ShowNotification(_U('not_experienced_enough'))
	end
end

function OpenMechanicCraftMenu()
	if Config.EnablePlayerManagement and PlayerData.job and PlayerData.job.grade_name ~= 'recrue' then
		local elements = {
			{ label = _U('blowtorch'), value = 'blow_pipe' },
			{ label = _U('repair_kit'), value = 'fix_kit' },
			{ label = _U('body_kit'), value = 'caro_kit' }
		}

		ESX.UI.Menu.CloseAll()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mechanic_craft', {
			title    = _U('craft'),
			align    = 'top-right',
			elements = elements
		}, function(data, menu)
			menu.close()

			if data.current.value == 'blow_pipe' then
				TriggerServerEvent('esx_mechanicjob:startCraft')
			elseif data.current.value == 'fix_kit' then
				TriggerServerEvent('esx_mechanicjob:startCraft2')
			elseif data.current.value == 'caro_kit' then
				TriggerServerEvent('esx_mechanicjob:startCraft3')
			end
		end, function(data, menu)
			menu.close()

			CurrentAction     = 'mechanic_craft_menu'
			CurrentActionMsg  = _U('craft_menu')
			CurrentActionData = {}
		end)
	else
		ESX.ShowNotification(_U('not_experienced_enough'))
	end
end

function OpenMobileMechanicActionsMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mobile_mechanic_actions', {
		title    = _U('mechanic'),
		align    = 'top-right',
		elements = {
			{ label = _U('billing'), value = 'billing' },
			--{label = 'Factuur Tunen',       value = 'billingvrij'},
			{ label = _U('hijack'), value = 'hijack_vehicle' },
			{ label = _U('repair'), value = 'fix_vehicle' },
			{ label = _U('clean'), value = 'clean_vehicle' },
			{ label = 'Apk keuren', value = 'apk_vehicle' },
			{ label = 'Abonnementen', value = 'abonnement' },
			{ label = _U('imp_veh'), value = 'del_vehicle' },
			{ label = 'Flatbed ', value = 'dep_vehicle' },
			{ label = 'Objecten Plaatsen', value = 'object_spawner' }
		} }, function(data, menu)
		if isBusy then return end

		if data.current.value == 'billing' then
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			if closestPlayer ~= -1 and closestDistance <= 3.0 then
				OpenFineMenu(closestPlayer)
			else
				ESX.ShowNotification("Geen spelers in de buurt")
			end
		elseif data.current.value == 'billingvrij' then

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {
				title = _U('invoice_amount')
			}, function(data, menu)

				local amount = tonumber(data.value)
				if amount == nil then
					ESX.ShowNotification(_U('amount_invalid'))
				else
					menu.close()
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
					if closestPlayer == -1 or closestDistance > 3.0 then
						ESX.ShowNotification(_U('no_players_near'))
					else
						TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_mechanic', 'ANWB', amount)
						ESX.ShowNotification(_U('billing_sent'))
					end

				end

			end, function(data, menu)
				menu.close()
			end)
		elseif data.current.value == 'hijack_vehicle' then
			local playerPed = PlayerPedId()
			local vehicle   = ESX.Game.GetVehicleInDirection()
			local coords    = GetEntityCoords(playerPed)

			if IsPedSittingInAnyVehicle(playerPed) then
				ESX.ShowNotification(_U('inside_vehicle'))
				return
			end

			if DoesEntityExist(vehicle) then
				isBusy = true
				TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)
				Citizen.CreateThread(function()
					Citizen.Wait(10000)

					SetVehicleDoorsLocked(vehicle, 1)
					SetVehicleDoorsLockedForAllPlayers(vehicle, false)
					ClearPedTasksImmediately(playerPed)

					ESX.ShowNotification(_U('vehicle_unlocked'))
					isBusy = false
				end)
			else
				ESX.ShowNotification(_U('no_vehicle_nearby'))
			end
		elseif data.current.value == 'apk_vehicle' then
			local playerPed = PlayerPedId()
			local vehicle   = ESX.Game.GetVehicleInDirection()
			local plate     = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))

			if IsPedSittingInAnyVehicle(playerPed) then
				ESX.ShowNotification(_U('inside_vehicle'))
				return
			end

			if DoesEntityExist(vehicle) then
				isBusy = true
				TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_CLIPBOARD', 0, true)
				Citizen.CreateThread(function()
					Citizen.Wait(20000)

					TriggerServerEvent('zv_apk:vernieuw', plate)
					ClearPedTasksImmediately(playerPed)

					ESX.ShowNotification('Voertuig is succesvol APK gekeurd')
					isBusy = false
				end)
			else
				ESX.ShowNotification(_U('no_vehicle_nearby'))
			end
		elseif data.current.value == 'abonnement' then
			OpenHealthCareActionsMenu()
		elseif data.current.value == 'fix_vehicle' then
			local playerPed         = PlayerPedId()
			local coords            = GetEntityCoords(playerPed)
			local vehicle, distance = ESX.Game.GetClosestVehicle(coords)

			if distance > 5.0 then
				vehicle = 0
			end

			if IsPedSittingInAnyVehicle(playerPed) then
				ESX.ShowNotification(_U('inside_vehicle'))
				return
			end

			if DoesEntityExist(vehicle) then
				isBusy = true
				TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
				Citizen.CreateThread(function()
					Citizen.Wait(20000)

					SetVehicleFixed(vehicle)
					SetVehicleDeformationFixed(vehicle)
					SetVehicleUndriveable(vehicle, false)
					SetVehicleEngineOn(vehicle, true, true)
					SetVehicleOnGroundProperly(vehicle)
					ClearPedTasksImmediately(playerPed)

					ESX.ShowNotification(_U('vehicle_repaired'))
					isBusy = false
				end)
			else
				ESX.ShowNotification(_U('no_vehicle_nearby'))
			end
		elseif data.current.value == 'clean_vehicle' then
			local playerPed         = PlayerPedId()
			local coords            = GetEntityCoords(playerPed)
			local vehicle, distance = ESX.Game.GetClosestVehicle(coords)

			if distance > 5.0 then
				vehicle = 0
			end

			if IsPedSittingInAnyVehicle(playerPed) then
				ESX.ShowNotification(_U('inside_vehicle'))
				return
			end

			if DoesEntityExist(vehicle) then
				isBusy = true
				TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_MAID_CLEAN', 0, true)
				Citizen.CreateThread(function()
					Citizen.Wait(10000)

					SetVehicleDirtLevel(vehicle, 0)
					ClearPedTasksImmediately(playerPed)

					ESX.ShowNotification(_U('vehicle_cleaned'))
					isBusy = false
				end)
			else
				ESX.ShowNotification(_U('no_vehicle_nearby'))
			end
		elseif data.current.value == 'del_vehicle' then
			local playerPed = PlayerPedId()

			if IsPedSittingInAnyVehicle(playerPed) then
				local vehicle = GetVehiclePedIsIn(playerPed, false)

				if GetPedInVehicleSeat(vehicle, -1) == playerPed then
					ESX.ShowNotification(_U('vehicle_impounded'))
					ESX.Game.DeleteVehicle(vehicle)
				else
					ESX.ShowNotification(_U('must_seat_driver'))
				end
			else
				local vehicle = ESX.Game.GetVehicleInDirection()

				if DoesEntityExist(vehicle) then
					ESX.ShowNotification(_U('vehicle_impounded'))
					ESX.Game.DeleteVehicle(vehicle)
				else
					ESX.ShowNotification(_U('must_near'))
				end
			end
		elseif data.current.value == 'dep_vehicle' then
			local playerPed = PlayerPedId()
			local vehicle = GetVehiclePedIsIn(playerPed, true)

			local towmodel = GetHashKey('flatbed3')
			local isVehicleTow = IsVehicleModel(vehicle, towmodel)
			print('Claus is bezig #2')
			if isVehicleTow then
				local targetVehicle = ESX.Game.GetVehicleInDirection()
				print(ESX.DumpTable(targetVehicle))
				if CurrentlyTowedVehicle == nil then
					if targetVehicle ~= 0 and targetVehicle ~= nil then
						if not IsPedInAnyVehicle(playerPed, true) then
							if vehicle ~= targetVehicle then
								AttachEntityToEntity(targetVehicle, vehicle, 20, 0, -4, 0.6, 20.0, 10.0, 0.0, false, false, false, false, 18, true)
								Wait(1050)
								AttachEntityToEntity(targetVehicle, vehicle, 20, 0, -4, 0.6, 20.0, 10.0, 0.0, false, false, false, false, 18, true)
								Wait(1850)
								AttachEntityToEntity(targetVehicle, vehicle, 20, 0, -4, 0.7, 20.0, 10.0, 0.0, false, false, false, false, 18, true)
								Wait(1850)
								AttachEntityToEntity(targetVehicle, vehicle, 20, 0, -4, 0.8, 20.0, 10.0, 0.0, false, false, false, false, 18, true)
								Wait(1850)
								AttachEntityToEntity(targetVehicle, vehicle, 20, 0, -4, 0.9, 20.0, 10.0, 0.0, false, false, false, false, 18, true)
								Wait(1850)
								AttachEntityToEntity(targetVehicle, vehicle, 20, 0, -4, 1.0, 20.0, 10.0, 0.0, false, false, false, false, 18, true)
								Wait(850)
								AttachEntityToEntity(targetVehicle, vehicle, 20, 0, -4, 1.1, 20.0, 10.0, 0.0, false, false, false, false, 18, true)
								Wait(250)
								AttachEntityToEntity(targetVehicle, vehicle, 20, 0, -3.8, 1.15, 20.0, 10.0, 0.0, false, false, false, false, 18, true)
								Wait(250)
								AttachEntityToEntity(targetVehicle, vehicle, 20, 0, -3.3, 1.19, 20.0, 10.0, 0.0, false, false, false, false, 18, true)
								Wait(250)
								AttachEntityToEntity(targetVehicle, vehicle, 20, 0, -3.1, 1.25, 20.0, 10.0, 0.0, false, false, false, false, 18, true)
								Wait(250)
								AttachEntityToEntity(targetVehicle, vehicle, 20, 0, -2.5, 1.3, 20.0, 10.0, 0.0, false, false, false, false, 18, true)
								Wait(250)
								AttachEntityToEntity(targetVehicle, vehicle, 20, 0, -1.5, 1.35, 20.0, 10.0, 0.0, false, false, false, false, 18, true)
								Wait(250)
								AttachEntityToEntity(targetVehicle, vehicle, 20, 0, -1.5, 1.35, 20.0, 10.0, 0.0, false, false, false, false, 18, true)

								Wait(250)
								AttachEntityToEntity(targetVehicle, vehicle, 20, 0, -0.5, 1.35, 20.0, 10.0, 0.0, false, false, false, false, 18, true)

								Wait(250)
								AttachEntityToEntity(targetVehicle, vehicle, 20, 0, 1.5, 1.3, 20.0, 10.0, 0.0, false, false, false, false, 18, true)

								Wait(250)
								AttachEntityToEntity(targetVehicle, vehicle, 20, 0, 2.5, 1.3, 20.0, 10.0, 0.0, false, false, false, false, 18, true)
								Wait(250)
								AttachEntityToEntity(targetVehicle, vehicle, 20, 0, 3.5, 1.3, 20.0, 10.0, 0.0, false, false, false, false, 18, true)
								Wait(250)
								AttachEntityToEntity(targetVehicle, vehicle, 20, 0, 4.0, 1.3, 20.0, 10.0, 0.0, false, false, false, false, 18, true)
								-- AttachEntityToEntity(targetVehicle, vehicle, 20, 0, -6.0, 0.6, 20.0, 10.0, 0.0, false, false, false, false, 18, true)


								CurrentlyTowedVehicle = targetVehicle
								ESX.ShowNotification(_U('vehicle_success_attached'))

								if NPCOnJob then
									if NPCTargetTowable == targetVehicle then
										ESX.ShowNotification(_U('please_drop_off'))
										Config.Zones.VehicleDelivery.Type = 1

										if Blips['NPCTargetTowableZone'] then
											RemoveBlip(Blips['NPCTargetTowableZone'])
											Blips['NPCTargetTowableZone'] = nil
										end

										Blips['NPCDelivery'] = AddBlipForCoord(Config.Zones.VehicleDelivery.Pos.x, Config.Zones.VehicleDelivery.Pos.y, Config.Zones.VehicleDelivery.Pos.z)
										SetBlipRoute(Blips['NPCDelivery'], true)
									end
								end
							else
								ESX.ShowNotification(_U('cant_attach_own_tt'))
							end
						end
					else
						ESX.ShowNotification(_U('no_veh_att'))
					end
				else
					AttachEntityToEntity(CurrentlyTowedVehicle, vehicle, 20, -0.5, -12.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
					DetachEntity(CurrentlyTowedVehicle, true, true)

					if NPCOnJob then
						if NPCTargetDeleterZone then

							if CurrentlyTowedVehicle == NPCTargetTowable then
								ESX.Game.DeleteVehicle(NPCTargetTowable)
								TriggerServerEvent('esx_mechanicjob:onNPCJobMissionCompleted')
								StopNPCJob()
								NPCTargetDeleterZone = false
							else
								ESX.ShowNotification(_U('not_right_veh'))
							end

						else
							ESX.ShowNotification(_U('not_right_place'))
						end
					end

					CurrentlyTowedVehicle = nil
					ESX.ShowNotification(_U('veh_det_succ'))
				end
			else
				ESX.ShowNotification(_U('imp_flatbed'))
			end
		elseif data.current.value == 'object_spawner' then
			ESX.UI.Menu.Open(
				'default', GetCurrentResourceName(), 'citizen_interaction',
				{
					title = _U('traffic_interaction'),
					align = 'top-right',
					elements = {
						{ label = _U('cone'), value = 'prop_roadcone02a' },
						{ label = _U('barrier'), value = 'prop_barrier_work06a' },
						{ label = _U('gereedschap'), value = 'prop_toolchest_01' },
						{ label = 'Reservewiel', value = 'prop_rub_tyre_01' },
						{ label = 'Jerrycan', value = 'prop_jerrycan_01a' }

					}
				}, function(data2, menu2)
					local model = data2.current.value
					local playerPed = GetPlayerPed(-1)
					local coords = GetEntityCoords(playerPed)
					local forward = GetEntityForwardVector(playerPed)
					local x, y, z = table.unpack(coords + forward * 1.0)

					-- if model == 'prop_roadcone02a' then
					-- 	z = z - 2.0
					-- end
					ESX.Game.SpawnObject(model, {
						x = x,
						y = y,
						z = z
					}, function(obj)
						SetEntityHeading(obj, GetEntityHeading(playerPed))
						PlaceObjectOnGroundProperly(obj)
						FreezeEntityPosition(obj, true)
					end)

				end, function(data2, menu2)
				menu2.close()
			end)
		end
	end, function(data, menu)
		menu.close()
	end)
end

RegisterNetEvent('esx_mechanicjob:client:betaalzorgpas')
AddEventHandler('esx_mechanicjob:client:betaalzorgpas', function()
	ESX.TriggerServerCallback('esx_license:checkLicense', function(hasDriversLicense)
		if hasDriversLicense then
			TriggerServerEvent('esx_mechanicjob:server:betaalzorgpas')
		end
	end, GetPlayerServerId(PlayerId()), 'anwb')
end)

function OpenHealthCareActionsMenu()
	local elements = {
		{ label = 'Bekijk abonnement', value = 'check_healthcare' },
		{ label = 'Activeer abonnement', value = 'activate_healthcare' },
		{ label = 'Deactiveer abonnement', value = 'deactivate_healthcare' }
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'healthcare_actions', {
		title    = 'ANWB',
		align    = 'top-right',
		elements = elements
	}, function(data, menu)
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		if closestPlayer == -1 or closestDistance > 1.0 then
			ESX.ShowNotification(_U('no_players'))
		else
			if data.current.value == 'check_healthcare' then
				ESX.TriggerServerCallback('esx_license:checkLicense', function(hasDriversLicense)
					if hasDriversLicense then
						--ESX.ShowNotification(('%s heeft een abonnement'):format(GetPlayerName(closestPlayer)))
						exports['mythic_notify']:DoHudText('success', ('%s heeft een abonnement'):format(GetPlayerName(closestPlayer)))
					else
						--ESX.ShowNotification(('%s heeft geen abonnement'):format(GetPlayerName(closestPlayer)))
						exports['mythic_notify']:DoHudText('error', ('%s heeft geen abonnement'):format(GetPlayerName(closestPlayer)))
					end
				end, GetPlayerServerId(closestPlayer), 'anwb')
			elseif data.current.value == 'deactivate_healthcare' then
				--ESX.ShowNotification(('Je hebt het abonnement van %s gedeactiveerd'):format(GetPlayerName(closestPlayer)))
				exports['mythic_notify']:DoHudText('error', ('Je hebt het abonnement van %s gedeactiveerd'):format(GetPlayerName(closestPlayer)))
				TriggerServerEvent('esx_license:removeLicense', GetPlayerServerId(closestPlayer), 'anwb')

			elseif data.current.value == 'activate_healthcare' then
				--ESX.ShowNotification(('Je hebt het abonnement van %s geactiveerd'):format(GetPlayerName(closestPlayer)))
				exports['mythic_notify']:DoHudText('success', ('Je hebt het abonnement van %s geactiveerd'):format(GetPlayerName(closestPlayer)))
				TriggerServerEvent('esx_license:addLicense', GetPlayerServerId(closestPlayer), 'anwb')
			end
		end
	end, function(data, menu)
		menu.close()
	end)
end

function OpenFineMenu(player)

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'fine',
		{
			title    = _U('fine'),
			align    = 'top-right',
			elements = {
				{ label = "In de stad", value = 0 },
				{ label = "Buiten de stad", value = 1 },
				{ label = "Reparatie op kantoor", value = 2 }
			},
		},
		function(data, menu)

			OpenFineCategoryMenu(player, data.current.value)

		end,
		function(data, menu)
		menu.close()
	end
	)

end

function OpenFineCategoryMenu(player, category)

	ESX.TriggerServerCallback('esx_mechanicjob:getFineList', function(fines)

		local elements = {}

		for i = 1, #fines, 1 do
			table.insert(elements, {
				label     = fines[i].label .. ' <span style="color: green;">€' .. fines[i].amount .. '</span>',
				value     = fines[i].id,
				amount    = fines[i].amount,
				fineLabel = fines[i].label
			})
		end

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'fine_category',
			{
				title    = _U('fine'),
				align    = 'top-right',
				elements = elements,
			},
			function(data, menu)

				local label  = data.current.fineLabel
				local amount = data.current.amount
				
				menu.close()
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				print ('Closest player: '.. GetPlayerServerId(closestPlayer) .. ' ' .. closestPlayer)
				print(GetPlayerServerId(closestPlayer), 'society_mechanic', label, amount)

				TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_mechanic', label, amount)
				

				ESX.SetTimeout(300, function()
					OpenFineCategoryMenu(player, category)
				end)

			end,
			function(data, menu)
			menu.close()
		end
		)

	end, category)

end

function OpenIdentityCardMenu(player)

	ESX.TriggerServerCallback('esx_mechanicjob:getOtherPlayerData', function(data)

		local jobLabel    = nil
		local sexLabel    = nil
		local sex         = nil
		local dobLabel    = nil
		local heightLabel = nil
		local idLabel     = nil

		if data.job.grade_label ~= nil and data.job.grade_label ~= '' then
			jobLabel = 'Job: ' .. data.job.label .. ' - ' .. data.job.grade_label
		else
			jobLabel = 'Job: ' .. data.job.label
		end

		if data.sex ~= nil then
			if (data.sex == 'm') or (data.sex == 'M') then
				sex = 'Male'
			else
				sex = 'Female'
			end
			sexLabel = 'Sex: ' .. sex
		else
			sexLabel = 'Sex: Unknown'
		end

		if data.dob ~= nil then
			dobLabel = 'DOB: ' .. data.dob
		else
			dobLabel = 'DOB: Unknown'
		end

		if data.height ~= nil then
			heightLabel = 'Height: ' .. data.height
		else
			heightLabel = 'Height: Unknown'
		end

		if data.name ~= nil then
			idLabel = 'ID: ' .. data.name
		else
			idLabel = 'ID: Unknown'
		end

		local elements = {
			{ label = _U('name', data.firstname .. ' ' .. data.lastname), value = nil },
			{ label = sexLabel, value = nil },
			{ label = dobLabel, value = nil },
			{ label = heightLabel, value = nil },
			{ label = jobLabel, value = nil },
			{ label = idLabel, value = nil },
		}

		if data.drunk ~= nil then
			table.insert(elements, { label = _U('bac', data.drunk), value = nil })
		end

		if data.licenses ~= nil then

			table.insert(elements, { label = '--- Licenses ---', value = nil })

			for i = 1, #data.licenses, 1 do
				table.insert(elements, { label = data.licenses[i].label, value = nil })
			end

		end

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'citizen_interaction',
			{
				title    = _U('citizen_interaction'),
				align    = 'top-right',
				elements = elements,
			},
			function(data, menu)

			end,
			function(data, menu)
			menu.close()
		end
		)

	end, GetPlayerServerId(player))

end

function OpenGetStocksMenu()
	ESX.TriggerServerCallback('esx_mechanicjob:getStockItems', function(items)
		local elements = {}

		for i = 1, #items, 1 do
			table.insert(elements, {
				label = 'x' .. items[i].count .. ' ' .. items[i].label,
				value = items[i].name
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			title    = _U('mechanic_stock'),
			align    = 'top-right',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
				title = _U('quantity')
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification(_U('invalid_quantity'))
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('esx_mechanicjob:getStockItem', itemName, count)

					Citizen.Wait(1000)
					OpenGetStocksMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end

RegisterNetEvent('esx_mechanicjob:onHijack')
AddEventHandler('esx_mechanicjob:onHijack', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		local chance = math.random(100)
		local alarm  = math.random(100)

		if DoesEntityExist(vehicle) then
			if alarm <= 33 then
				SetVehicleAlarm(vehicle, true)
				StartVehicleAlarm(vehicle)
			end

			TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)

			Citizen.CreateThread(function()
				Citizen.Wait(10000)
				if chance <= 66 then
					SetVehicleDoorsLocked(vehicle, 1)
					SetVehicleDoorsLockedForAllPlayers(vehicle, false)
					ClearPedTasksImmediately(playerPed)
					ESX.ShowNotification(_U('veh_unlocked'))
				else
					ESX.ShowNotification(_U('hijack_failed'))
					ClearPedTasksImmediately(playerPed)
				end
			end)
		end
	end
end)

RegisterNetEvent('esx_mechanicjob:onCarokit')
AddEventHandler('esx_mechanicjob:onCarokit', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		if DoesEntityExist(vehicle) then
			TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_HAMMERING', 0, true)
			Citizen.CreateThread(function()
				Citizen.Wait(10000)
				SetVehicleFixed(vehicle)
				SetVehicleDeformationFixed(vehicle)
				ClearPedTasksImmediately(playerPed)
				ESX.ShowNotification(_U('body_repaired'))
			end)
		end
	end
end)

RegisterNetEvent('esx_mechanicjob:onFixkit')
AddEventHandler('esx_mechanicjob:onFixkit', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		if DoesEntityExist(vehicle) then
			TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
			Citizen.CreateThread(function()
				Citizen.Wait(20000)
				SetVehicleFixed(vehicle)
				SetVehicleDeformationFixed(vehicle)
				SetVehicleUndriveable(vehicle, false)
				ClearPedTasksImmediately(playerPed)
				ESX.ShowNotification(_U('veh_repaired'))
			end)
		end
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

AddEventHandler('esx_mechanicjob:hasEnteredMarker', function(zone)
	if zone == 'VehicleDelivery' then
		NPCTargetDeleterZone = true
	elseif zone == 'MechanicActions' then
		CurrentAction     = 'mechanic_actions_menu'
		CurrentActionMsg  = _U('open_actions')
		CurrentActionData = {}
	elseif zone == 'Garage' then
		CurrentAction     = 'mechanic_harvest_menu'
		CurrentActionMsg  = _U('harvest_menu')
		CurrentActionData = {}
	elseif zone == 'Craft' then
		CurrentAction     = 'mechanic_craft_menu'
		CurrentActionMsg  = _U('craft_menu')
		CurrentActionData = {}
	elseif zone == 'VehicleDeleter' then
		local playerPed = PlayerPedId()

		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle = GetVehiclePedIsIn(playerPed, false)

			CurrentAction     = 'delete_vehicle'
			CurrentActionMsg  = _U('veh_stored')
			CurrentActionData = { vehicle = vehicle }
		end
	end
end)

AddEventHandler('esx_mechanicjob:hasExitedMarker', function(zone)
	if zone == 'VehicleDelivery' then
		NPCTargetDeleterZone = false
	elseif zone == 'Craft' then
		TriggerServerEvent('esx_mechanicjob:stopCraft')
		TriggerServerEvent('esx_mechanicjob:stopCraft2')
		TriggerServerEvent('esx_mechanicjob:stopCraft3')
	elseif zone == 'Garage' then
		TriggerServerEvent('esx_mechanicjob:stopHarvest')
		TriggerServerEvent('esx_mechanicjob:stopHarvest2')
		TriggerServerEvent('esx_mechanicjob:stopHarvest3')
	end

	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

AddEventHandler('esx_mechanicjob:hasEnteredEntityZone', function(entity)
	local playerPed = PlayerPedId()

	if PlayerData.job and PlayerData.job.name == 'mechanic' and not IsPedInAnyVehicle(playerPed, false) then
		CurrentAction     = 'remove_entity'
		CurrentActionMsg  = _U('press_remove_obj')
		CurrentActionData = { entity = entity }
	end
end)

AddEventHandler('esx_mechanicjob:hasExitedEntityZone', function(entity)
	if CurrentAction == 'remove_entity' then
		CurrentAction = nil
	end
end)

RegisterNetEvent('esx_phone:loaded')
AddEventHandler('esx_phone:loaded', function(phoneNumber, contacts)
	local specialContact = {
		name       = _U('mechanic'),
		number     = 'mechanic',
		base64Icon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAALEwAACxMBAJqcGAAAA4BJREFUWIXtll9oU3cUx7/nJA02aSSlFouWMnXVB0ejU3wcRteHjv1puoc9rA978cUi2IqgRYWIZkMwrahUGfgkFMEZUdg6C+u21z1o3fbgqigVi7NzUtNcmsac40Npltz7S3rvUHzxQODec87vfD+/e0/O/QFv7Q0beV3QeXqmgV74/7H7fZJvuLwv8q/Xeux1gUrNBpN/nmtavdaqDqBK8VT2RDyV2VHmF1lvLERSBtCVynzYmcp+A9WqT9kcVKX4gHUehF0CEVY+1jYTTIwvt7YSIQnCTvsSUYz6gX5uDt7MP7KOKuQAgxmqQ+neUA+I1B1AiXi5X6ZAvKrabirmVYFwAMRT2RMg7F9SyKspvk73hfrtbkMPyIhA5FVqi0iBiEZMMQdAui/8E4GPv0oAJkpc6Q3+6goAAGpWBxNQmTLFmgL3jSJNgQdGv4pMts2EKm7ICJB/aG0xNdz74VEk13UYCx1/twPR8JjDT8wttyLZtkoAxSb8ZDCz0gdfKxWkFURf2v9qTYH7SK7rQIDn0P3nA0ehixvfwZwE0X9vBE/mW8piohhl1WH18UQBhYnre8N/L8b8xQvlx4ACbB4NnzaeRYDnKm0EALCMLXy84hwuTCXL/ExoB1E7qcK/8NCLIq5HcTT0i6u8TYbXUM1cAyyveVq8Xls7XhYrvY/4n3gC8C+dsmAzL1YUiyfWxvHzsy/w/dNd+KjhW2yvv/RfXr7x9QDcmo1he2RBiCCI1Q8jVj9szPNixVfgz+UiIGyDSrcoRu2J16d3I6e1VYvNSQjXpnucAcEPUOkGYZs/l4uUhowt/3kqu1UIv9n90fAY9jT3YBlbRvFTD4fw++wHjhiTRL/bG75t0jI2ITcHb5om4Xgmhv57xpGOg3d/NIqryOR7z+r+MC6qBJB/ZB2t9Om1D5lFm843G/3E3HI7Yh1xDRAfzLQr5EClBf/HBHK462TG2J0OABXeyWDPZ8VqxmBWYscpyghwtTd4EKpDTjCZdCNmzFM9k+4LHXIFACJN94Z6FiFEpKDQw9HndWsEuhnADVMhAUaYJBp9XrcGQKJ4qFE9k+6r2+MG3k5N8VQ22TVglbX2ZwOzX2VvNKr91zmY6S7N6zqZicVT2WNLyVSehESaBhxnOALfMeYX+K/S2yv7wmMAlvwyuR7FxQUyf0fgc/jztfkJr7XeGgC8BJJgWNV8ImT+AAAAAElFTkSuQmCC'
	}

	TriggerEvent('esx_phone:addSpecialContact', specialContact.name, specialContact.number, specialContact.base64Icon)
end)

-- Pop NPC mission vehicle when inside area
Citizen.CreateThread(function()
	while true do
		sleep = 1500

		if NPCTargetTowableZone and not NPCHasSpawnedTowable then
			sleep        = 5
			local coords = GetEntityCoords(PlayerPedId())
			local zone   = Config.Zones[NPCTargetTowableZone]

			if GetDistanceBetweenCoords(coords, zone.Pos.x, zone.Pos.y, zone.Pos.z, true) < Config.NPCSpawnDistance then
				local model = Config.Vehicles[GetRandomIntInRange(1, #Config.Vehicles)]

				ESX.Game.SpawnVehicle(model, zone.Pos, 0, function(vehicle)
					NPCTargetTowable = vehicle
					TriggerServerEvent("pepperspray:addVehiclePlate", GetVehicleNumberPlateText(vehicle))
					Wait(200)
				end)

				NPCHasSpawnedTowable = true
			end
		end

		if NPCTargetTowableZone and NPCHasSpawnedTowable and not NPCHasBeenNextToTowable then
			sleep        = 5
			local coords = GetEntityCoords(PlayerPedId())
			local zone   = Config.Zones[NPCTargetTowableZone]

			if GetDistanceBetweenCoords(coords, zone.Pos.x, zone.Pos.y, zone.Pos.z, true) < Config.NPCNextToDistance then
				ESX.ShowNotification(_U('please_tow'))
				NPCHasBeenNextToTowable = true
			end
		end
		Citizen.Wait(sleep)
	end
end)

-- Create Blips
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(-369.78, -118.3, 38.67)

	SetBlipSprite(blip, 446)
	SetBlipDisplay(blip, 4)
	SetBlipScale(blip, 1.0)
	SetBlipColour(blip, 0)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName(_U('mechanic'))
	EndTextCommandSetBlipName(blip)
end)

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(true)
	AddTextComponentString(text)
	SetDrawOrigin(x, y, z, 0)
	DrawText(0.0, 0.0)
	local factor = (string.len(text)) / 370
	DrawRect(0.0, 0.0 + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
	ClearDrawOrigin()
end

-- Display markers
Citizen.CreateThread(function()
	while true do
		sleep = 1500

		if PlayerData.job and PlayerData.job.name == 'mechanic' or PlayerData.job and PlayerData.job.name == 'offmechanic' then
			local coords, letSleep = GetEntityCoords(PlayerPedId()), true

			for k, v in pairs(Config.Zones) do
				if v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance then
					sleep = 2
					DrawMarker(20, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, nil, nil, false)
				end
			end

		else
			Citizen.Wait(3000)
		end

		Citizen.Wait(sleep)
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		sleep = 750

		if PlayerData.job and PlayerData.job.name == 'mechanic' then

			local coords      = GetEntityCoords(PlayerPedId())
			local isInMarker  = false
			local currentZone = nil

			for k, v in pairs(Config.Zones) do
				if (GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 1.5) then
					sleep       = 0
					isInMarker  = true
					currentZone = k
				end
			end

			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker = true
				LastZone                = currentZone
				TriggerEvent('esx_mechanicjob:hasEnteredMarker', currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_mechanicjob:hasExitedMarker', LastZone)
			end

		end
		Citizen.Wait(sleep)
	end
end)

Citizen.CreateThread(function()
	local trackedEntities = {
		'prop_roadcone02a',
		'prop_toolchest_01',
		'prop_barrier_work06a',
		'prop_rub_tyre_01',
		'prop_jerrycan_01a'
	}

	while true do
		sleep = 1500

		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		local closestDistance = -1
		local closestEntity   = nil

		for i = 1, #trackedEntities, 1 do
			local object = GetClosestObjectOfType(coords, 3.0, GetHashKey(trackedEntities[i]), false, false, false)

			if DoesEntityExist(object) then
				sleep           = 5
				local objCoords = GetEntityCoords(object)
				local distance  = GetDistanceBetweenCoords(coords, objCoords, true)

				if closestDistance == -1 or closestDistance > distance then
					closestDistance = distance
					closestEntity   = object
				end
			end
		end

		if closestDistance ~= -1 and closestDistance <= 3.0 then
			if LastEntity ~= closestEntity then
				TriggerEvent('esx_mechanicjob:hasEnteredEntityZone', closestEntity)
				LastEntity = closestEntity
			end
		else
			if LastEntity then
				TriggerEvent('esx_mechanicjob:hasExitedEntityZone', LastEntity)
				LastEntity = nil
			end
		end
		Citizen.Wait(sleep)
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(7)
		if PlayerData.job and PlayerData.job.name == 'mechanic' then
			if CurrentAction then
				ESX.ShowHelpNotification(CurrentActionMsg)

				if IsControlJustReleased(0, 38) then

					if CurrentAction == 'mechanic_actions_menu' then
						OpenMechanicActionsMenu()
					elseif CurrentAction == 'mechanic_harvest_menu' then
						OpenMechanicHarvestMenu()
					elseif CurrentAction == 'mechanic_craft_menu' then
						OpenMechanicCraftMenu()
					elseif CurrentAction == 'delete_vehicle' then

						if Config.EnableSocietyOwnedVehicles then

							local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
							TriggerServerEvent('esx_society:putVehicleInGarage', 'mechanic', vehicleProps)

						else

							if GetEntityModel(vehicle) == GetHashKey('ANWB1')
							then
								TriggerServerEvent('esx_service:disableService', 'mechanic')
							end

						end

						ESX.Game.DeleteVehicle(CurrentActionData.vehicle)

					elseif CurrentAction == 'remove_entity' then
						DeleteEntity(CurrentActionData.entity)
					end

					CurrentAction = nil
				end
			end

			if IsControlJustReleased(0, 167) and not isDead and PlayerData.job and PlayerData.job.name == 'mechanic' then
				OpenMobileMechanicActionsMenu()
			end

		else
			Citizen.Wait(3000)
		end
	end
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
	isDead = false
end)
