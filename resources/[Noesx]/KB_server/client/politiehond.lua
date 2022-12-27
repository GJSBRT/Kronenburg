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
		Citizen.Wait(7)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

-- Command
RegisterCommand("politiehond", function(source,args,rawCommand)
    local xPlayer  = ESX.GetPlayerData()
    if xPlayer.job.name == "police" then
    spawnped("a_c_shepherd")
    giveWeapon("weapon_bite")
    SetPedComponentVariation(GetPlayerPed(-1), 0, 0, 0, 1)
    DisplayNotification("Je bent een politie hond.")
    else
        DisplayNotification("Je hebt niet de juiste baan!")
    end
end, false)

-- Spawn Model
function spawnped(pedhash)
    local ped = PlayerId()
    local model = GetHashKey(pedhash)
    RequestModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(0)
    end
    SetPlayerModel(ped, model)
    SetModelAsNoLongerNeeded(model)
end

-- Geef Wapen Code
function giveWeapon(gunhash)
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey(gunhash), 999, false)
    SetPedArmour(GetPlayerPed(-1), 100)
end

function DisplayNotification( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end