--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
SpawnedCars = {}
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function spawnAnVehicle(model, pos)
	vehicleModel = model
	RequestModel(vehicleModel)
	while not HasModelLoaded(vehicleModel) do
		Citizen.Wait(10)
	end
	local vehicle = CreateVehicle(vehicleModel, pos.x, pos.y, pos.z - 1, pos.h, true, true)
	table.insert(SpawnedCars, vehicle)
	local nid = NetworkGetNetworkIdFromEntity(vehicle)
	SetVehicleNumberPlateText(vehicle, 'DEALER')
	SetEntityAsMissionEntity(vehicle, true)
	SetVehicleOnGroundProperly(vehicle)
	SetVehicleHasBeenOwnedByPlayer(vehicle, true)
	SetNetworkIdExistsOnAllMachines(nid, true)
	SetNetworkIdCanMigrate(nid, true)
	SetVehRadioStation(vehicle, "OFF")
	SetVehicleDirtLevel(vehicle, 0.0)
	FreezeEntityPosition(vehicle, true)
end
inrangeof = false
spawned = false

firstSpawn = true
AddEventHandler("playerSpawned", function(spawnInfo)
	if firstSpawn and GetNumberOfPlayers() == 1 then
		for x, veh in ipairs(Config.Cars) do
			spawnAnVehicle(veh.model, veh)
		end
	  	firstSpawn = false
	end
  end)

  

AddEventHandler('onResourceStop', function(resourceName)
	for x, veh in ipairs(SpawnedCars) do
		if veh ~= nil and IsEntityAVehicle(veh) then
			DeleteVehicle(veh)
		end
	end
end)
Citizen.CreateThread(function()
	Citizen.Wait(8000)
	while true do
		inrangeof = false
		for x, veh in ipairs(Config.Cars) do
			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(-1)), veh.x, veh.y,	veh.z, false) < 2 then
				inrangeof = x
			end
		end
		Citizen.Wait(500)
	end
end)
Citizen.CreateThread(function()
	while true do
		if inrangeof == false then Citizen.Wait(1000) end
		if inrangeof ~= false then 
			ESX.ShowNotification(Config.Cars[inrangeof].label..' - € '.. Config.Cars[inrangeof].price)
		end
		Citizen.Wait(80)
	end
end)