--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
local spawnedWeeds = 0
local weedPlants = {}
local isPickingUp, isProcessing = false, false






Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.CircleZones.WeedField.coords, true) < 50 then
			print('aapje')
--			ESX.TriggerServerCallback('esx_sebasdrugs:GetWeedActiveState', function(isActivato)
--				if isActivato then
					KaasOpEenPlankje()
					
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

		for i=1, #weedPlants, 1 do
			print(GetEntityCoords(weedPlants[i]))
			if GetDistanceBetweenCoords(coords, GetEntityCoords(weedPlants[i]), false) < 1 then
				nearbyObject, nearbyID = weedPlants[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then

			if not isPickingUp then
				ESX.ShowHelpNotification(_U('weed_pickupprompt'))
			end

			if IsControlJustReleased(0, Keys['E']) and not isPickingUp then

--				ESX.TriggerServerCallback('esx_sebasdrugs:GetWeedActiveState', function(isActivato)
--					if isActivato then
						isPickingUp = true

						TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)

						Citizen.Wait(2000)
						ClearPedTasks(playerPed)
						Citizen.Wait(1500)
						
						ESX.Game.DeleteObject(nearbyObject)
						
						table.remove(weedPlants, nearbyID)
						spawnedWeeds = spawnedWeeds - 1
						local securityToken = '25291'
						TriggerServerEvent('esx_retropluk:pickedUpweed', securityToken)

						isPickingUp = false

--					else

--						for k, v in pairs(CocaPlants) do
--							ESX.Game.DeleteObject(v)
--						end
		
--						ESX.ShowNotification('Deze drugs zijn nog niet klaar om verzameld te worden!')
		
		--				TriggerEvent('esx_retropluk:spawncocaplants')
		
--						spawnedCocaLeaf = 0
		
--					end
--				end)
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
			if not IsEntityPlayingAnim(PlayerPedId(), 'world_human_gardener_plant', 0) then
				TaskPlayAnim(PlayerPedId(), 'world_human_gardener_plant', 0, false)
			end
		end
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(weedPlants) do
			ESX.Game.DeleteObject(v)
		end
	end
end)


function KaasOpEenPlankje()
	print('spawnedplants')
	while spawnedWeeds < 15 do
		Citizen.Wait(0)
		local weedCoords = WorstOpEenPlankje()

--		ESX.TriggerServerCallback('esx_sebasdrugs:GetWeedActiveState', function(isActivato)
--			if isActivato then
				ESX.Game.SpawnLocalObject('prop_weed_02', weedCoords, function(obj)
					PlaceObjectOnGroundProperly(obj)
					FreezeEntityPosition(obj, true)

					table.insert(weedPlants, obj)
					spawnedWeeds = spawnedWeeds + 1
				end)
--			end
--		end)
	end
end

function HamOpEenPlankje()
	print('spawnedplants')
	while spawnedWeeds < 15 do
		Citizen.Wait(0)
		local weedCoords = WorstOpEenPlankje()

--		ESX.TriggerServerCallback('esx_sebasdrugs:GetWeedActiveState', function(isActivato)
--			if isActivato then
				ESX.Game.SpawnLocalObject('prop_weed_02', weedCoords, function(obj)
					PlaceObjectOnGroundProperly(obj)
					FreezeEntityPosition(obj, true)

					table.insert(weedPlants, obj)
					spawnedWeeds = spawnedWeeds + 1
				end)
--			end
--		end)
	end
end

function NootjesOpEenPlankje(plantCoord)
	if spawnedWeeds > 0 then
		local validate = true

		for k, v in pairs(weedPlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.WeedField.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function WorstOpEenPlankje()
	while true do
		Citizen.Wait(1)

		local weedCoordX, weedCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-20, 20)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-20, 20)

		weedCoordX = Config.CircleZones.WeedField.coords.x + modX
		weedCoordY = Config.CircleZones.WeedField.coords.y + modY

		local coordZ = BierOpDeTafel(weedCoordX, weedCoordY)
		local coord = vector3(weedCoordX, weedCoordY, coordZ)

		if NootjesOpEenPlankje(coord) then
			return coord
		end
	end
end

function BierOpDeTafel(x, y)
	local groundCheckHeights = { 50, 51.0, 52.0, 53.0, 54.0, 55.0, 56.0, 57.0, 58.0, 59.0, 60.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 53.85
end