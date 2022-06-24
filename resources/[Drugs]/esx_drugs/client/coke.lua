local spawnedCocaLeaf = 0
local CocaPlants = {}
local isPickingUp, isProcessing = false, false






Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.CircleZones.CokeField.coords, true) < 50 then
			print('aap')
--			ESX.TriggerServerCallback('esx_sebasdrugs:GetActiveState', function(isActivato)
--				if isActivato then
					SpawnCocaPlants()
					Citizen.Wait(500)
--				end
--			end)
		else
			Citizen.Wait(500)
		end
	end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID

		for i=1, #CocaPlants, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(CocaPlants[i]), false) < 1 then
				nearbyObject, nearbyID = CocaPlants[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then

			if not isPickingUp then
				ESX.ShowHelpNotification(_U('coke_pickupprompt'))
			end

			if IsControlJustReleased(0, Keys['E']) and not isPickingUp then


--				ESX.TriggerServerCallback('esx_sebasdrugs:GetActiveState', function(isActivato)
--					if isActivato then

									isPickingUp = true

									TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)

									Citizen.Wait(2000)
									ClearPedTasks(playerPed)
									Citizen.Wait(1500)
						
									ESX.Game.DeleteObject(nearbyObject)
						
									table.remove(CocaPlants, nearbyID)
									spawnedCocaLeaf = spawnedCocaLeaf - 1
									local securityToken = '25291'
									TriggerServerEvent('esx_retropluk:pickedUpCocaLeaf', securityToken)
									isPickingUp = false
--
--									isPickingUp = false

--								end, 'coke')

--[[					else

						for k, v in pairs(CocaPlants) do
							ESX.Game.DeleteObject(v)
						end

						ESX.ShowNotification('Deze drugs zijn nog niet klaar om verzameld te worden!')


						spawnedCocaLeaf = 0

					end

				end)]]



			end

		else
			Citizen.Wait(500)
		end

	end

end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)

		if isPickingUp then
			DisableControlAction(0, 73, true) 
			if not IsEntityPlayingAnim(PlayerPedId(), "world_human_gardener_plant", 0) then
				TaskPlayAnim(PlayerPedId(), 'world_human_gardener_plant', 0, false)
			end
		end
	end
end)


AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(CocaPlants) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

function SpawnCocaPlants()
	while spawnedCocaLeaf < 15 do
		Citizen.Wait(0)
		local weedCoords = GenerateCocaLeafCoords()

--		ESX.TriggerServerCallback('esx_sebasdrugs:GetActiveState', function(isActivato)
--			if isActivato then
				ESX.Game.SpawnLocalObject('prop_plant_01a', weedCoords, function(obj)
					PlaceObjectOnGroundProperly(obj)
					FreezeEntityPosition(obj, true)

					table.insert(CocaPlants, obj)
					spawnedCocaLeaf = spawnedCocaLeaf + 1
				end)
--			end
--		end)
	end
end

function ValidateCocaLeafCoord(plantCoord)
	if spawnedCocaLeaf > 0 then
		local validate = true

		for k, v in pairs(CocaPlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.CokeField.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateCocaLeafCoords()
	while true do
		Citizen.Wait(1)

		local weedCoordX, weedCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-20, 20)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-20, 20)

		weedCoordX = Config.CircleZones.CokeField.coords.x + modX
		weedCoordY = Config.CircleZones.CokeField.coords.y + modY

		local coordZ = GetCoordZCoke(weedCoordX, weedCoordY)
		local coord = vector3(weedCoordX, weedCoordY, coordZ)

		if ValidateCocaLeafCoord(coord) then
			return coord
		end
	end
end

function GetCoordZCoke(x, y)
	local groundCheckHeights = { 70.0, 71.0, 72.0, 73.0, 74.0, 75.0, 76.0, 77.0, 78.0, 79.0, 80.0}

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 77
end

