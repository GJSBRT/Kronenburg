--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
local ped = GetPlayerPed(PlayerId())
local isInVeh = false
ESX = nil

Citizen.CreateThread(function ()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function ()
    while true do
        Wait(3000)
        local veh = GetVehiclePedIsIn(ped)

        if (veh ~= 0 and isInVeh ~= veh) then
            if (not ESX.UI.Menu.IsOpen('default', 'esx_vehicleshop', 'vehicle_shop') and 
                not ESX.UI.Menu.IsOpen('default', 'esx_testrit', 'vehicle_shop')
                ) then
                TriggerServerEvent("pepperspray:isInVeh", GetVehicleNumberPlateText(veh))
            end
        end 

        if (veh ~= 0) then
            isInVeh = veh
        else
            isInVeh = false
        end
    end
end)

firstSpawn = true
AddEventHandler('playerSpawned', function()
    if firstSpawn then
        TriggerServerEvent("pepperspray:playerconnect")
        firstSpawn = false
    end
end)
