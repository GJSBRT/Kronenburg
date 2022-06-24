local hospitalCheckin = { x = -438.07, y = -325.98, z = 34.91, h = 334.76 }
local hospitalCheckin2 = { x = -264.23, y = 6313.43, z = 32.44, h = 328.65 }
local hospitalCheckin3 = { x = 1833.06, y = 3682.85, z = 34.27, h = 293.0}


local bedOccupying = nil
local bedObject = nil
local bedOccupyingData = nil

local cam = nil

local inBedDict = "anim@gangops@morgue@table@"
local inBedAnim = "ko_front"
local getOutDict = 'switch@franklin@bed'
local getOutAnim = 'sleep_getup_rubeyes'

local halfDood = false

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function PrintHelpText(message)
    SetTextComponentFormat("STRING")
    AddTextComponentString(message)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function LeaveBed()
    RequestAnimDict(getOutDict)
    while not HasAnimDictLoaded(getOutDict) do
        Citizen.Wait(0)
    end

    RenderScriptCams(0, true, 200, true, true)
    DestroyCam(cam, false)

    SetEntityInvincible(PlayerPedId(), false)

    SetEntityHeading(PlayerPedId(), bedOccupyingData.h - 90)
    TaskPlayAnim(PlayerPedId(), getOutDict , getOutAnim ,8.0, -8.0, -1, 0, 0, false, false, false )
    Citizen.Wait(5000)
    ClearPedTasks(PlayerPedId())
    FreezeEntityPosition(PlayerPedId(), false)
    TriggerServerEvent('mythic_hospital:server:LeaveBed', bedOccupying)

    FreezeEntityPosition(bedObject, false)
    
    bedOccupying = nil
    bedObject = nil
    bedOccupyingData = nil
    halfDood = false
end

RegisterNetEvent('mythic_hospital:client:RPCheckPos')
AddEventHandler('mythic_hospital:client:RPCheckPos', function()
    TriggerServerEvent('mythic_hospital:server:RPRequestBed', GetEntityCoords(PlayerPedId()))
end)

RegisterNetEvent('mythic_hospital:client:RPSendToBed')
AddEventHandler('mythic_hospital:client:RPSendToBed', function(id, data)
    bedOccupying = id
    bedOccupyingData = data

    bedObject = GetClosestObjectOfType(data.x, data.y, data.z, 1.0, data.model, false, false, false)
    FreezeEntityPosition(bedObject, true)

    SetEntityCoords(PlayerPedId(), data.x, data.y, data.z)
    
    RequestAnimDict(inBedDict)
    while not HasAnimDictLoaded(inBedDict) do
        Citizen.Wait(0)
    end

    TaskPlayAnim(PlayerPedId(), inBedDict , inBedAnim ,8.0, -8.0, -1, 1, 0, false, false, false )
    SetEntityHeading(PlayerPedId(), data.h + 180)

    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 1, true, true)
    AttachCamToPedBone(cam, PlayerPedId(), 31085, 0, 0, 1.0 , true)
    SetCamFov(cam, 90.0)
    SetCamRot(cam, -90.0, 0.0, GetEntityHeading(PlayerPedId()) + 180, true)

    SetEntityInvincible(PlayerPedId(), true)
            

    Citizen.CreateThread(function()
        while bedOccupyingData ~= nil do
            Citizen.Wait(1)
            PrintHelpText('Druk op ~INPUT_VEH_DUCK~ om op te staan')
            if IsControlJustReleased(0, 73) then
                LeaveBed()
            end
        end
    end)
end)

RegisterNetEvent('mythic_hospital:client:SendToBed')
AddEventHandler('mythic_hospital:client:SendToBed', function(id, data)
    bedOccupying = id
    bedOccupyingData = data

    bedObject = GetClosestObjectOfType(data.x, data.y, data.z, 1.0, data.model, false, false, false)
    FreezeEntityPosition(bedObject, true)

    SetEntityCoords(PlayerPedId(), data.x, data.y, data.z)
    RequestAnimDict(inBedDict)
    while not HasAnimDictLoaded(inBedDict) do
        Citizen.Wait(0)
    end
    TaskPlayAnim(PlayerPedId(), inBedDict , inBedAnim ,8.0, -8.0, -1, 1, 0, false, false, false )
    SetEntityHeading(PlayerPedId(), data.h + 180)
    SetEntityInvincible(PlayerPedId(), true)

    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 1, true, true)
    AttachCamToPedBone(cam, PlayerPedId(), 31085, 0, 0, 1.0 , true)
    SetCamFov(cam, 90.0)
    SetCamRot(cam, -90.0, 0.0, GetEntityHeading(PlayerPedId()) + 180, true)

    Citizen.CreateThread(function ()
        Citizen.Wait(5)
        local player = PlayerPedId()
        ESX.ShowNotification('De doctoren zijn je aan het helpen')
        --exports['mythic_notify']:DoHudText('inform', 'Doctors Are Treating You')
        Citizen.Wait(5000)
        TriggerServerEvent('mythic_hospital:server:EnteredBed')
        Citizen.Wait(15000)
        xPlayer.removeAccountMoney('bank', 500)
        TriggerEvent('mythic_hospital:client:FinishServices')
    end)
end)

RegisterNetEvent('mythic_hospital:client:FinishServices')
AddEventHandler('mythic_hospital:client:FinishServices', function()
	SetEntityHealth(PlayerPedId(), GetEntityMaxHealth(PlayerPedId()))
    TriggerEvent('mythic_hospital:client:RemoveBleed')
    TriggerEvent('mythic_hospital:client:ResetLimbs')
    ESX.ShowNotification('Je bent geholpen door een arts')
    LeaveBed()
end)

RegisterNetEvent('mythic_hospital:client:ForceLeaveBed')
AddEventHandler('mythic_hospital:client:ForceLeaveBed', function()
    LeaveBed()
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local playerped = PlayerPedId()
        local plyCoords = GetEntityCoords(playerped, 0)
        local distance = #(vector3(hospitalCheckin.x, hospitalCheckin.y, hospitalCheckin.z) - plyCoords)
        local distance2 = #(vector3(hospitalCheckin2.x, hospitalCheckin2.y, hospitalCheckin2.z) - plyCoords)
        local distance3 = #(vector3(hospitalCheckin3.x, hospitalCheckin3.y, hospitalCheckin3.z) - plyCoords)

        DrawMarker(28, -438.07, -325.98, 36.91 - 0.99, 0, 0, 0, 0, 0, 0, 0.07, 0.07, 0.07, 115, 27, 247, 1000, true, true, 2, false, false, false, false)
        if distance < 15 then

            if not IsPedInAnyVehicle(playerped, true) then
                if distance < 2 then
                    PrintHelpText('Druk op ~INPUT_CONTEXT~ ~s~om in te checken')
					--ESX.Game.Utils.DrawText3D(vector3(hospitalCheckin.x, hospitalCheckin.y, hospitalCheckin.z + 0.5), '[E] Check in', 0.4)
                    if IsControlJustReleased(0, 54) then
                        if (GetEntityHealth(playerped) < 200) or (IsInjuredOrBleeding()) then
                            SetEntityCoords(playerped, -438.07, -325.98, 34.91, false, false, false, false)
                            SetEntityHeading(playerped, 337.76)
                            TriggerEvent("mythic_progbar:client:progress", {
                                name = "hospital_action",
                                duration = 10500,
                                label = "Je gegevens aan het noteren",
                                useWhileDead = true,
                                canCancel = true,
                                controlDisables = {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                },
                                animation = {
                                    animDict = "missheistdockssetup1clipboard@base",
                                    anim = "base",
                                    flags = 49,
                                },
                                prop = {
                                    model = "p_amb_clipboard_01",
                                    bone = 18905,
                                    coords = { x = 0.10, y = 0.02, z = 0.08 },
                                    rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                },
                                propTwo = {
                                    model = "prop_pencil_01",
                                    bone = 58866,
                                    coords = { x = 0.12, y = 0.0, z = 0.001 },
                                    rotation = { x = -150.0, y = 0.0, z = 0.0 },
                                },
                            }, function(status)
                                if not status then
                                    TriggerServerEvent('mythic_hospital:server:RequestBed')
                                end
                            end)
                        else
                            ESX.ShowNotification('Je bent in orde, je hebt geen medische assistentie nodig')
                            --exports['mythic_notify']:DoHudText('error', 'You do not need medical attention')
                        end
                    end
                end
            end
        elseif distance2 < 15 then
            DrawMarker(28, -264.23, 6313.43, 33.48, - 0.99, 0, 0, 0, 0, 0, 0.05, 0.05, 0.05, 1, 150, 1555, 1000, true, true, 2, false, false, false, false)
            if not IsPedInAnyVehicle(playerped, true) then
                if distance2 < 3 then
                    PrintHelpText('Druk op ~INPUT_CONTEXT~ ~s~om in te checken')
					--ESX.Game.Utils.DrawText3D(vector3(hospitalCheckin.x, hospitalCheckin.y, hospitalCheckin.z + 0.5), '[E] Check in', 0.4)
                    if IsControlJustReleased(0, 54) then
                        if (GetEntityHealth(playerped) < 200) or (IsInjuredOrBleeding()) then
                            SetEntityCoords(playerped, -263.08, 6314.61, 32.44, false, false, false, false)
                            SetEntityHeading(playerped, 139.15)
                            TriggerEvent("mythic_progbar:client:progress", {
                                name = "hospital_action",
                                duration = 10500,
                                label = "Je gegevens aan het noteren",
                                useWhileDead = true,
                                canCancel = true,
                                controlDisables = {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                },
                                animation = {
                                    animDict = "missheistdockssetup1clipboard@base",
                                    anim = "base",
                                    flags = 49,
                                },
                                prop = {
                                    model = "p_amb_clipboard_01",
                                    bone = 18905,
                                    coords = { x = 0.10, y = 0.02, z = 0.08 },
                                    rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                },
                                propTwo = {
                                    model = "prop_pencil_01",
                                    bone = 58866,
                                    coords = { x = 0.12, y = 0.0, z = 0.001 },
                                    rotation = { x = -150.0, y = 0.0, z = 0.0 },
                                },
                            }, function(status)
                                if not status then
                                    TriggerServerEvent('mythic_hospital:server:RequestBedPaleto')
                                end
                            end)
                        else
                            ESX.ShowNotification('Je bent in orde, je hebt geen medische assistentie nodig')
                            --exports['mythic_notify']:DoHudText('error', 'You do not need medical attention')
                        end
                    end
                end
            end
        elseif distance3 < 15 then
            DrawMarker(28, 1835.19, 3683.97, 35.47, - 0.99, 0, 0, 0, 0, 0, 0.05, 0.05, 0.05, 1, 150, 1555, 1000, true, true, 2, false, false, false, false)
            if not IsPedInAnyVehicle(playerped, true) then
                if distance3 < 3 then
                    PrintHelpText('Druk op ~INPUT_CONTEXT~ ~s~om in te checken')
					--ESX.Game.Utils.DrawText3D(vector3(hospitalCheckin.x, hospitalCheckin.y, hospitalCheckin.z + 0.5), '[E] Check in', 0.4)
                    if IsControlJustReleased(0, 54) then
                        if (GetEntityHealth(playerped) < 200) or (IsInjuredOrBleeding()) then
                            SetEntityCoords(playerped, 1833.21, 3682.59, 34.27, false, false, false, false)
                            SetEntityHeading(playerped, 303.57)
                            TriggerEvent("mythic_progbar:client:progress", {
                                name = "hospital_action",
                                duration = 10500,
                                label = "Je gegevens aan het noteren",
                                useWhileDead = true,
                                canCancel = true,
                                controlDisables = {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                },
                                animation = {
                                    animDict = "missheistdockssetup1clipboard@base",
                                    anim = "base",
                                    flags = 49,
                                },
                                prop = {
                                    model = "p_amb_clipboard_01",
                                    bone = 18905,
                                    coords = { x = 0.10, y = 0.02, z = 0.08 },
                                    rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                },
                                propTwo = {
                                    model = "prop_pencil_01",
                                    bone = 58866,
                                    coords = { x = 0.12, y = 0.0, z = 0.001 },
                                    rotation = { x = -150.0, y = 0.0, z = 0.0 },
                                },
                            }, function(status)
                                if not status then
                                    TriggerServerEvent('mythic_hospital:server:RequestBedSandy')
                                end
                            end)
                        else
                            ESX.ShowNotification('Je bent in orde, je hebt geen medische assistentie nodig')
                            --exports['mythic_notify']:DoHudText('error', 'You do not need medical attention')
                        end
                    end
                end
            end
        else
            Citizen.Wait(1000)
        end
    end
end)

local PlayerData              = {}

Citizen.CreateThread(function ()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(1)
    end

    while ESX.GetPlayerData() == nil do
        Citizen.Wait(10)
    end

    PlayerData = ESX.GetPlayerData()
end) 

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setjob')
AddEventHandler('esx:setjob', function(job)
    PlayerData.job = job
end)

function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end