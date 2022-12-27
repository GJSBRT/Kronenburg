--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(500)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	ESX.PlayerData = ESX.GetPlayerData()
    PlayerData = ESX.GetPlayerData()
end)

local sleep = 0 
DecorRegister("_LAST_LEFT", 3)
DecorRegister("_DESPAWN_TIMER", 3)
DecorRegister('Owned_Vehicle', 3)



AddEventHandler('baseevents:enteredVehicle', function(currentVehicle, currentSeat, _, _, model)
    DecorSetInt(currentVehicle, "_LAST_LEFT", GetTime())
end)

AddEventHandler('baseevents:leftVehicle', function(currentVehicle, currentSeat)
    if not DoesEntityExist(currentVehicle) then
        return
    end
    DecorSetInt(currentVehicle, "_LAST_LEFT", GetTime())
end)

AddEventHandler('baseevents:changedSeat', function(currentVehicle, currentSeat, _, _, model)
    DecorSetInt(currentVehicle, "_LAST_LEFT", GetTime())
end)

Citizen.CreateThread(function()
    Citizen.Wait(20000)
    while true do
        Citizen.Wait(15000)
            local time = GetTime()
            local vehicles = GetGamePool("CVehicle")
            for i=1, #vehicles do
                local vehicle = vehicles[i]
                Citizen.Wait(0)
                if DecorExistOn(vehicle, "_LAST_LEFT") then
                    local vehicleCoords = GetEntityCoords(vehicle)
                    local pedCoords = GetEntityCoords(PlayerPedId())
                    local lastLeft = DecorGetInt(vehicle, "_LAST_LEFT")
                    local decorDespawnTimer = DecorExistOn(vehicle, "_DESPAWN_TIMER") and DecorGetInt(vehicle, "_DESPAWN_TIMER") or nil
                    if decorDespawnTimer and decorDespawnTimer < 60 then
                        decorDespawnTimer = nil
                    end
                    local despawnTimer = decorDespawnTimer or 3600
                    if lastLeft > 10 and time - lastLeft > despawnTimer and not DoesEntityExist(GetPedInVehicleSeat(vehicle, -1)) then                            
                            if GetEntitySpeed(vehicle) < 2.5 then
                                Citizen.Wait(1000)
                                if DoesEntityExist(vehicle) then
                                    ESX.Game.DeleteVehicle(vehicle)
                                end
                            else
                                DecorSetInt(vehicle, "_LAST_LEFT", GetTime())
                            end
                    end
                end
            end
    end
end)

local time = nil
function GetTime()
	-- 1590254141 is 23/05/2020, datetime should be higher than that
	if time and time < 1590254141 then
		return GetCloudTimeAsInt()
	end
	return time or GetCloudTimeAsInt()
end





exports('isOwnedVehicle', function(vehicle, nonPersonal)
	local identifierHash = GetHashKey(PlayerData.identifier)
	local plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
	if plate == tostring(identifierHash % 99999999) then
        -- print(plate.." "..tostring(identifierHash % 99999999))
		return true
	end

	if not DecorExistOn(vehicle, 'Owned_Vehicle') then
		return false
	end

	local decor = DecorGetInt(vehicle, 'Owned_Vehicle')
	if nonPersonal then
		return decor == 1 or decor == identifierHash or decor == GetHashKey(GetPlayerName(PlayerId()))
	else
		return decor == identifierHash or decor == GetHashKey(GetPlayerName(PlayerId()))
	end
end)



RegisterNetEvent('spawnedPersonalVehicle')
AddEventHandler('spawnedPersonalVehicle', function(vehicle)
	if DoesEntityExist(vehicle) then
        -- print(vehicle.." "..GetHashKey(PlayerData.identifier))
		DecorSetInt(vehicle, 'Owned_Vehicle', GetHashKey(PlayerData.identifier))
	else
		print("[esx_outlawalert] Failed to register decor: Entity doesn't exist")
	end
end)



exports('spawnedPersonalVehicle', function(vehicle)
	if DoesEntityExist(vehicle) then
        -- print(vehicle.." "..GetHashKey(PlayerData.identifier))
		DecorSetInt(vehicle, 'Owned_Vehicle', GetHashKey(PlayerData.identifier))
	else
		print("[esx_outlawalert] Failed to register decor: Entity doesn't exist")
	end
end)


