--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
local animDict = 'savecouch@'
local animName = 't_sleep_loop_couch'
local IsHoldingStretcher = false
local Stretcher = nil
local job = nil

ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(500)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(500)
    end

    job = ESX.GetPlayerData().job.name
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(_job)
    job = _job.name
end)

RegisterCommand('brancard', function()
    if job ~= 'ambulance' then
        return
    end

    LoadModel('prop_ld_binbag_01')
    local playerPed = PlayerPedId()
    local playerPos = GetEntityCoords(playerPed, true)
    local bedHash = `prop_ld_binbag_01`
    local object = Citizen.InvokeNative(0x509D5878EB39E842, bedHash, playerPos.x, playerPos.y + 1.4, playerPos.z - 1, true, true, true)
end, false)

RegisterCommand('delbrancard', function()
    local civiere = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 10.0, `prop_ld_binbag_01`)

    if DoesEntityExist(civiere) then
        SetEntityAsMissionEntity(civiere)
        DeleteEntity(civiere)
    end
    Stretcher = nil
end, false)

local vehicleOffsets = {
    [`ambusprinter`] = { -0.2, -1.7, -0.7},
    [`ambut6`] = { -0.15, -1.6, -0.4 },
    [`blokkenambu`] = { -0.05, -1.9, -0.6 },
    [`ambusprinteroud`] = { -0.2, -1.6, -0.7 },
}
local bedOffsets = {
    [`prop_ld_binbag_01`] = {
        canPickup = true,
        sitOffset = vector3(0.0, 0.2, 0.62),
        pickupOffset = vector3(0.0, 0.0, 0.6),
        sitForward = 0.5,
        pickupForward = -1.2
    },
    [2117668672] = {
        canPickup = false,
        sitOffset = vector3(0.0, 0.0, 0.9),
        pickupOffset = vector3(0.0, 0.0, 0.6),
        sitForward = 0.5,
        pickupForward = -1.2
    },
    [1631638868] = {
        canPickup = true,
        sitOffset = vector3(0.0, 0.0, 0.9),
        pickupOffset = vector3(0.0, 0.0, 0.6),
        sitForward = 0.5,
        pickupForward = -1.2
    },
    [-1519439119] = {
        canPickup = false,
        sitOffset = vector3(0.0, 0.0, 1.5),
        pickupOffset = vector3(0.0, 0.0, 0.6),
        sitForward = 0.5,
        pickupForward = -1.2
    },
    [-289946279] = {
        canPickup = false,
        sitOffset = vector3(0.0, 0.0, 1.5),
        pickupOffset = vector3(0.0, 0.0, 0.6),
        sitForward = 0.5,
        pickupForward = -1.2
    }
}
Citizen.CreateThread(function()
    local closestObject = nil
    while true do
        local sleep = 1500

        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)

        for k,v in pairs(bedOffsets) do
            closestObject = GetClosestObjectOfType(pedCoords, 3.0, k, false)
            if DoesEntityExist(closestObject) then
                break
            end
        end

        if not IsPedInAnyVehicle(ped) and DoesEntityExist(closestObject) then
            sleep = 5
            local bedModel = GetEntityModel(closestObject)
            local bedData = bedOffsets[bedModel]
            local civiereCoords = GetEntityCoords(closestObject)
            local civiereForward = GetEntityForwardVector(closestObject)

            local sitCoords = (civiereCoords + civiereForward * bedData.sitForward) + bedData.sitOffset
            local pickupCoords = (civiereCoords + civiereForward * bedData.pickupForward) + bedData.pickupOffset

            if bedData.canPickup and not IsHoldingStretcher and #(pedCoords - pickupCoords) <= 1.2 and job == 'ambulance' then
                DrawText3Ds(pickupCoords, "[E] Duwen", 0.4)

                if IsControlJustPressed(0, 38) then
                    PickUp(closestObject)
                end

            elseif not IsHoldingStretcher and #(pedCoords - sitCoords) <= 1.5 then
                DrawText3Ds(sitCoords, "[E] Liggen", 0.4)

                if IsControlJustPressed(0, 38) then
                    Sit(closestObject, bedData)
                end
            end

            if IsHoldingStretcher then
                local vehicle
                for k,v in pairs(vehicleOffsets) do
                    vehicle = GetClosestVehicle(pedCoords, 10.0, k, 70)
                    if DoesEntityExist(vehicle) then
                        break
                    end
                end
                if vehicle ~= 0 then
                    local rightVector, _, _, position = GetEntityMatrix(vehicle)
                    local coords = (rightVector * -2.0) + position
                    local distance = #(coords - pedCoords)
                    local model = GetEntityModel(vehicle)
                    if distance < 2.0 and vehicleOffsets[model] ~= nil then
                        local coords = (rightVector * -3.0) + position
                        if IsControlJustPressed(0, 38) then
                            StreachertoCar(vehicle, vehicleOffsets[model])
                        end

                        local text = ('[E] In de ambulance plaatsen')
                        DrawText3Ds(coords, text, 0.4)
                    end
                end
            end
        end

        Citizen.Wait(sleep)
    end
end)

function StreachertoCar(vehicle, offset)
    local ped = PlayerPedId()
    local closestObject = Stretcher

    if DoesEntityExist(closestObject) then
        if GetVehiclePedIsIn(ped, false) == 0 and DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) then
            local isopen = (GetVehicleDoorAngleRatio(vehicle,2) > 0.0) or (GetVehicleDoorAngleRatio(vehicle,3) > 0.0)
            if not isopen then
                NetworkRequestControlOfEntity(vehicle)
                Citizen.Wait(300)
                SetVehicleDoorOpen(vehicle,2,0,0)
                SetVehicleDoorOpen(vehicle,3,0,0)
                SetVehicleDoorOpen(vehicle,5,0,0)
                Citizen.Wait(1000)
            end

            AttachEntityToEntity (closestObject, vehicle, 0.0, offset[1], offset[2], offset[3], 0.0, 0.0, 0.0, false, false, true, false, 2, true)
            FreezeEntityPosition(closestObject, true)

            local rightVector, _, _, position = GetEntityMatrix(vehicle)
            local coords = (rightVector * -2.0) + position
            local distance = #(coords - GetEntityCoords(ped))
            local isopen = (GetVehicleDoorAngleRatio(vehicle,2) > 0.0) or (GetVehicleDoorAngleRatio(vehicle,3) > 0.0)

            while not IsPedInAnyVehicle(ped) and distance < 3.0 and isopen do
                rightVector, _, _, position = GetEntityMatrix(vehicle)
                coords = (rightVector * -2.0) + position
                distance = #(coords - GetEntityCoords(ped))
                isopen = (GetVehicleDoorAngleRatio(vehicle,2) > 0.0) or (GetVehicleDoorAngleRatio(vehicle,3) > 0.0)

                Citizen.Wait(0)
                DisableControlAction(0, 23, true)
                local text = ('[H] Ambulance deuren sluiten')
                DrawText3Ds(coords, text, 0.4)
                if IsDisabledControlJustPressed(0, 74) then
                    NetworkRequestControlOfEntity(vehicle)
                    Citizen.Wait(100)
                    SetVehicleDoorShut(vehicle,2,0,0)
                    SetVehicleDoorShut(vehicle,3,0,0)
                    SetVehicleDoorShut(vehicle,5,0,0)
                    break
                end
            end
        else
            print("car does not exist ")
        end
    else
        print("nothing around here dumb ass")
    end
end

function StretcheroutCar()
    local veh = VehicleInFront()
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
    local closestObject = GetClosestObjectOfType(pedCoords, 3.0, `prop_ld_binbag_01`, false)
    if DoesEntityExist(closestObject) then
        if GetVehiclePedIsIn(ped, false) == 0 and DoesEntityExist(veh) and IsEntityAVehicle(veh) then
            DetachEntity(closestObject, true, true)
            FreezeEntityPosition(closestObject, false)
            coords = GetEntityCoords(closestObject, false)
            SetEntityCoords(closestObject, coords.x-3,coords.y,coords.z)
            PlaceObjectOnGroundProperly(closestObject)
        else
            print("dosenot exist car")
        end
    else
        print("nothing around here dumb ass")
    end
end

Sit = function(civiereObject, bedData)
    local closestPlayer, closestPlayerDist = GetClosestPlayer()

    if closestPlayer ~= nil and closestPlayerDist <= 1.5 then
        if IsEntityPlayingAnim(GetPlayerPed(closestPlayer), 'savecouch@', 't_sleep_loop_couch', 3) then
            ShowNotification("iemand gebruikt al de brancard")
            return
        end
    end

    LoadAnim("savecouch@")

    AttachEntityToEntity(PlayerPedId(), civiereObject, 0, 0, bedData.sitOffset.y-0.2, bedData.sitOffset.z+0.5, 12.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
    FreezeEntityPosition(PlayerPedId(), true)

    local heading = GetEntityHeading(civiereObject)
    local playerPed = PlayerPedId()
    while IsEntityAttachedToEntity(playerPed, civiereObject) do
        Citizen.Wait(5)
        playerPed = PlayerPedId()

        if IsPedDeadOrDying(playerPed) then
            FreezeEntityPosition(playerPed, false)
            DetachEntity(playerPed, true, true)
        end

        if not IsEntityPlayingAnim(playerPed, 'savecouch@', 't_sleep_loop_couch', 1) then
            TaskPlayAnim(playerPed, 'savecouch@', 't_sleep_loop_couch', 1.0, 2.0, -1, 45, 1.0, 0, 0, 0)
        end

        if IsControlPressed(0, 32) then
            local x, y, z  = table.unpack(GetEntityCoords(civiereObject) + GetEntityForwardVector(civiereObject) * -0.02)
            SetEntityCoords(civiereObject, x,y,z)
            PlaceObjectOnGroundProperly(civiereObject)

            TaskPlayAnim(playerPed,'savecouch@', 't_sleep_loop_couch', 8.0, 1.0, 1, 45, 1.0, 0, 0, 0)
            --SetEntityCoords(playerPed, bedCoords.x , bedCoords.y, bedCoords.z, 1, 1, 0, 0)
            --SetEntityHeading(playerPed, GetEntityHeading(bed) + 180.0)
            --TaskPlayAnim(playerPed,animDict, animName, 8.0, 1.0, -1, 45, 1.0, 0, 0, 0)
        end

        if IsControlPressed(1,  34) then
            heading = heading + 0.4

            if heading > 360 then
                heading = 0
            end

            --SetEntityHeading(civiereObject,  heading)
            SetEntityHeading(playerPed, GetEntityHeading(civiereObject) + 180.0)
        end

        if IsControlPressed(1,  9) then
            heading = heading - 0.4

            if heading < 0 then
                heading = 360
            end

            SetEntityHeading(civiereObject,  heading)
        end

        if IsControlJustPressed(0, 73) then
            FreezeEntityPosition(playerPed, false)
            DetachEntity(playerPed, true, true)

            local _, forwardVector, _ = GetEntityMatrix(civiereObject)
            local x, y, z = table.unpack(GetEntityCoords(civiereObject) + forwardVector * - 1.2)
            print(("[esx_brancard] x: %.2f; y: %.2f; z: %.2f"):format(x, y, z))
            SetEntityCoords(playerPed, x,y,z)
        end
    end
    FreezeEntityPosition(PlayerPedId(), false)

    RemoveAnimDict("savecouch@")
end

PickUp = function(civiereObject)
    local closestPlayer, closestPlayerDist = GetClosestPlayer()

    if closestPlayer ~= nil and closestPlayerDist <= 1.5 then
        if IsEntityPlayingAnim(GetPlayerPed(closestPlayer), 'anim@heists@prison_heistig1_p1_guard_checks_bus', 'loop', 3) then
            ShowNotification("Somebody is already driving the civiere!")
            return
        end
    end

    NetworkRequestControlOfEntity(civiereObject)

    LoadAnim("anim@heists@prison_heistig1_p1_guard_checks_bus")

    AttachEntityToEntity(civiereObject, PlayerPedId(), PlayerPedId(), 0.0, 1.1, -0.52 , 180.0, 180.0, 180.0, 0.0, false, false, true, false, 2, true)

    Citizen.CreateThread(function()
        Stretcher = civiereObject
        local ped = PlayerPedId()
        while IsEntityAttachedToEntity(civiereObject, ped) do
            IsHoldingStretcher = true
            Citizen.Wait(5)

            if not IsEntityPlayingAnim(ped, 'anim@heists@prison_heistig1_p1_guard_checks_bus', 'loop', 3) then
                TaskPlayAnim(ped, 'anim@heists@prison_heistig1_p1_guard_checks_bus', 'loop', 8.0, 8.0, -1, 50, 0, false, false, false)
            end

            if IsPedDeadOrDying(ped) then
                DetachEntity(civiereObject, true, true)
            end

            if IsControlJustPressed(0, 73) then
                DetachEntity(civiereObject, true, true)
            end
        end
        ClearPedTasks(ped)
        IsHoldingStretcher = false
        Stretcher = nil
    end)
end

DrawText3Ds = function(coords, text, scale)
    local x,y,z = coords.x, coords.y, coords.z
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)

    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextEntry("STRING")
        SetTextCentre(1)
        SetTextColour(255, 255, 255, 255)

        AddTextComponentString(text)
        DrawText(_x, _y)

        local factor = (string.len(text)) / 370

        DrawRect(_x, _y + 0.0150, 0.030 + factor, 0.025, 31, 31, 31, 170)
    end
end

GetClosestPlayer = function()
    local players = GetActivePlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, 0)

    for i=0, #players do
        local target = GetPlayerPed(players[i])
        if(target ~= ply) and DoesEntityExist(target) then
            local targetCoords = GetEntityCoords(target, 0)
            local distance = #(targetCoords - plyCoords)
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = players[i]
                closestDistance = distance
            end
        end
    end

    return closestPlayer, closestDistance
end

LoadAnim = function(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)

        Citizen.Wait(1)
    end
end

LoadModel = function(model)
    while not HasModelLoaded(model) do
        RequestModel(model)

        Citizen.Wait(1)
    end
end

ShowNotification = function(msg)
    SetNotificationTextEntry('STRING')
    AddTextComponentSubstringWebsite(msg)
    DrawNotification(false, true)
end