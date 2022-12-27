--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 

--[[
local spawnedPoppys = 0
local PoppyPlants = {}
local isPickingUp, isProcessing = false, false


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.CircleZones.HeroinField.coords, true) < 50 then
			SpawnWeedPlants()
			Citizen.Wait(500)
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

		if GetDistanceBetweenCoords(coords, Config.CircleZones.HeroinProcessing.coords, true) < 5 then
			if not isProcessing then
				ESX.ShowHelpNotification(_U('heroin_processprompt'))
			end

			if IsControlJustReleased(0, Keys['E']) and not isProcessing then

				if Config.LicenseEnable then
					ESX.TriggerServerCallback('esx_license:checkLicense', function(hasProcessingLicense)
						if hasProcessingLicense then
							ProcessHeroin()
						else
							OpenBuyLicenseMenu('heroin_processing')
						end
					end, GetPlayerServerId(PlayerId()), 'heroin_processing')
				else
					ProcessHeroin()
				end

			end
		else
			Citizen.Wait(500)
		end
	end
end)

function ProcessHeroin()
	isProcessing = true

	ESX.ShowNotification(_U('heroin_processingstarted'))
--	TriggerServerEvent('esx_retropluk:processPoppyResin')
	local timeLeft = Config.Delays.HeroinProcessing / 1000
	local playerPed = PlayerPedId()

	while timeLeft > 0 do
		Citizen.Wait(1000)
		timeLeft = timeLeft - 1

		if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.CircleZones.HeroinProcessing.coords, false) > 5 then
			ESX.ShowNotification(_U('heroin_processingtoofar'))
--			TriggerServerEvent('esx_retropluk:cancelProcessing')
			break
		end
	end

	isProcessing = false
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID

		for i=1, #PoppyPlants, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(PoppyPlants[i]), false) < 1 then
				nearbyObject, nearbyID = PoppyPlants[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then

			if not isPickingUp then
				ESX.ShowHelpNotification(_U('heroin_pickupprompt'))
			end

			if IsControlJustReleased(0, Keys['E']) and not isPickingUp then
				isPickingUp = true

				ESX.TriggerServerCallback('esx_retropluk:canPickUp', function(canPickUp)

					if canPickUp then
						TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)

						Citizen.Wait(2000)
						ClearPedTasks(playerPed)
						Citizen.Wait(1500)
		
						ESX.Game.DeleteObject(nearbyObject)
		
						table.remove(PoppyPlants, nearbyID)
						spawnedPoppys = spawnedPoppys - 1
		
--						TriggerServerEvent('esx_retropluk:pickedUpPoppy')
					else
						ESX.ShowNotification(_U('poppy_inventoryfull'))
					end

					isPickingUp = false

				end, 'weed')
			end

		else
			Citizen.Wait(500)
		end

	end

end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(PoppyPlants) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

function SpawnPoppyPlants()
	while spawnedPoppys < 15 do
		Citizen.Wait(0)
		local heroinCoords = GenerateHeroinCoords()

		ESX.Game.SpawnLocalObject('prop_ld_jerrycan_01', heroinCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(PoppyPlants, obj)
			spawnedPoppys = spawnedPoppys + 1
		end)
	end
end

--[[unction SpawnWeedPlants()
	while spawnedWeeds < 15 do
		Citizen.Wait(0)
		local weedCoords = GenerateWeedCoords()

		ESX.Game.SpawnLocalObject('prop_weed_02', weedCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(weedPlants, obj)
			spawnedWeeds = spawnedWeeds + 1
		end)
	end
end]]

--[[
function ValidateHeroinCoord(plantCoord)
	if spawnedPoppys > 0 then
		local validate = true

		for k, v in pairs(PoppyPlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.HeroinField.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateHeroinCoords()
	while true do
		Citizen.Wait(1)

		local heroinCoordX, heroinCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-20, 20)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-20, 20)

		heroinCoordX = Config.CircleZones.HeroinField.coords.x + modX
		heroinCoordY = Config.CircleZones.HeroinField.coords.y + modY

		local coordZ = GetCoordZHeroin(heroinCoordX, heroinCoordY)
		local coord = vector3(heroinCoordX, heroinCoordY, coordZ)

		if ValidateHeroinCoord(coord) then
			return coord
		end
	end
end

function GetCoordZHeroin(x, y)
	local groundCheckHeights = { 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0, 17.0, 18.0, 19.0, 20.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 12.64
end

]]


local spawnedMethLeaf = 0
local MethPlants = {}
local isPickingUp, isProcessing = false, false
local isActive = false





RegisterNetEvent('esx_retropluk:spawnMethplants')
AddEventHandler('esx_retropluk:spawnMethplants', function()

	Citizen.Wait(math.random(1,20000000))

	spawnedMethLeaf = 0

	SpawnMethPlants()

end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if Config.UseItem then
			Citizen.Wait(math.random(1,20000000))
--			Citizen.Wait(math.random(1,20000))

			isActive = true

			Citizen.Wait(math.random(1,20000000))
--			Citizen.Wait(math.random(1,20000))

			isActive = false

		end
	end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.CircleZones.HeroinField.coords, true) < 50 then
			if isActive then
				SpawnMethPlants()
				Citizen.Wait(500)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

--[[
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, Config.CircleZones.CokeProcessing.coords, true) < 5 then
			if not isProcessing then
				ESX.ShowHelpNotification(_U('coke_processprompt'))
			end

			if IsControlJustReleased(0, Keys['E']) and not isProcessing then

				if Config.LicenseEnable then
					ESX.TriggerServerCallback('esx_license:checkLicense', function(hasProcessingLicense)
						if hasProcessingLicense then
							ProcessWeed()
						else
							OpenBuyLicenseMenu('coke_processing')
						end
					end, GetPlayerServerId(PlayerId()), 'coke_processing')
				else
					ProcessCoke()
				end

			end
		else
			Citizen.Wait(500)
		end
	end
end)



function ProcessCoke()
	isProcessing = true

	ESX.ShowNotification(_U('coke_processingstarted'))
--	TriggerServerEvent('esx_retropluk:processCocaLeaf', securityToken)
	local timeLeft = Config.Delays.CokeProcessing / 1000
	local playerPed = PlayerPedId()

	while timeLeft > 0 do
		Citizen.Wait(1000)
		timeLeft = timeLeft - 1

		if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.CircleZones.CokeProcessing.coords, false) > 5 then
			ESX.ShowNotification(_U('coke_processingtoofar'))
--			TriggerServerEvent('esx_retropluk:cancelProcessing', securityToken)
			break
		end
	end

	isProcessing = false
end]]

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID

		for i=1, #MethPlants, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(MethPlants[i]), false) < 1 then
				nearbyObject, nearbyID = MethPlants[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then

			if not isPickingUp then
				ESX.ShowHelpNotification('Druk op ~INPUT_CONTEXT~ om meth te oogsten')
			end

			if IsControlJustReleased(0, Keys['E']) and not isPickingUp then


					if isActive then

						isPickingUp = true


								ESX.TriggerServerCallback('esx_retropluk:canPickUp', function(canPickUp)


									if canPickUp then
										TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, false)

										Citizen.Wait(2000)
										ClearPedTasks(playerPed)
										Citizen.Wait(1500)
						
										ESX.Game.DeleteObject(nearbyObject)
						
										table.remove(MethPlants, nearbyID)
										spawnedMethLeaf = spawnedMethLeaf - 1
						
										TriggerServerEvent('esx_retropluk:pickedUpPoppy', securityToken)
									else
										ESX.ShowNotification('Je hebt al teveel meth bij je!')
									end

									isPickingUp = false

								end, 'meth')

					else

						for k, v in pairs(MethPlants) do
							ESX.Game.DeleteObject(v)
						end

						ESX.ShowNotification('Deze drugs zijn nog niet klaar om verzameld te worden!')

--						TriggerEvent('esx_retropluk:spawncocaplants')

						spawnedMethLeaf = 0

					end





			end

		else
			Citizen.Wait(500)
		end

	end

end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(MethPlants) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

function SpawnMethPlants()
	while spawnedMethLeaf < 15 do
		Citizen.Wait(0)
		local methCoords = GenerateMethLeafCoords()

		if isActive then
			ESX.Game.SpawnLocalObject('prop_ld_jerrycan_01', methCoords, function(obj)
				PlaceObjectOnGroundProperly(obj)
				FreezeEntityPosition(obj, true)

				table.insert(MethPlants, obj)
				spawnedMethLeaf = spawnedMethLeaf + 1
			end)
		end
	end
end

function ValidateMethLeafCoord(plantCoord)
	if spawnedMethLeaf > 0 then
		local validate = true

		for k, v in pairs(MethPlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.HeroinField.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateMethLeafCoords()
	while true do
		Citizen.Wait(1)

		local methCoordX, methCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-20, 20)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-20, 20)

		methCoordX = Config.CircleZones.HeroinField.coords.x + modX
		methCoordY = Config.CircleZones.HeroinField.coords.y + modY

		local coordZ = GetCoordZMeth(methCoordX, methCoordY)
		local coord = vector3(methCoordX, methCoordY, coordZ)

		if ValidateMethLeafCoord(coord) then
			return coord
		end
	end
end

function GetCoordZMeth(x, y)
	local groundCheckHeights = { 70.0, 71.0, 72.0, 73.0, 74.0, 75.0, 76.0, 77.0, 78.0, 79.0, 80.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 77
end


