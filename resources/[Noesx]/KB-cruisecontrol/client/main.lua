--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
local Player          = PlayerPedId()
local CruisedSpeed    = 0
local CruisedSpeedKm  = 0
local SpeedMultiplier = Config.SpeedMultiplier
local SpeedLimit      = nil
local VehicleTopSpeed = nil
local Vehicle         = nil
local VehicleModel    = nil
local LastCruiseSpeed = 0
local Mode = "speedlimit"



ESX = nil

Citizen.CreateThread(function ()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(500)
    end

    local ped = PlayerPedId()
    local currentVehicle = GetVehiclePedIsIn(ped, false)
    local currentSeat = GetPedVehicleSeat(ped, currentVehicle)
    local model = GetEntityModel(currentVehicle)
    if DoesEntityExist(currentVehicle) and currentSeat == -1 and Config.SpeedLimit[model] ~= nil then
        SetMaxSpeed(currentVehicle, model)
        Citizen.Wait(500)
        SetMaxSpeed(currentVehicle, model)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(500)
    end

    TriggerEvent("esx_cruisecontrol:switchedMode", Mode)
end)

function GetPedVehicleSeat(ped, vehicle)
    if not vehicle or  not DoesEntityExist(vehicle) then
        vehicle = GetVehiclePedIsIn(ped, false)
    end
    for i=-2, GetVehicleMaxNumberOfPassengers(vehicle) do
        if(GetPedInVehicleSeat(vehicle, i) == ped) then return i end
    end
    return -2
end


-- Citizen.CreateThread(function ()
--     while true do
--         Player = PlayerPedId()
--         Citizen.Wait(0)
--         if IsDriverCache then
--             local vehicle = GetVehiclePedIsIn(Player, false)
--             if (GetEntitySpeed(vehicle) > 5.0 or SpeedLimit) then
--                 if IsControlJustPressed(1, 246) then -- 246 Y
--                     if IsControlPressed(1, 21) then -- 21 LSHIFT
--                         local class = GetVehicleClass(vehicle)
--                         if class < 14 or class > 16 then
--                             TriggerCruiseControl()
--                         end
--                     else
--                         TriggerSpeedLimiter()
--                     end
--                 end
--             else
--                 Citizen.Wait(1000)
--             end
--         else
--             Citizen.Wait(1000)
--         end
--     end
-- end)

RegisterCommand('reactivatecruise', function(source, args, raw)
    if CruisedSpeed == 0 and LastCruiseSpeed ~= 0 then
        while IsControlPressed(1, 96) do
            Citizen.Wait(0)
        end
        DisableControlAction(1, 96, true)
        TriggerCruiseControl(LastCruiseSpeed)
    end
end)

RegisterCommand('triggercruise', function(source, args, raw)
    if not IsControlEnabled(1, 246) then
        return
    end

    Player = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(Player, false)
    if GetPedInVehicleSeat(vehicle, -1) == Player then
        if IsControlPressed(1, 21) then -- 21 LSHIFT
            SwitchMode()
        else
            if (GetEntitySpeed(vehicle) > 5.0 or SpeedLimit) then
                if Mode == "speedlimit" then
                    TriggerSpeedLimiter()
                else
                    TriggerCruiseControl()
                end
            else
                Citizen.Wait(1000)
            end
        end
    end
end)

RegisterKeyMapping('triggercruise', "Snelheidlimiet/Cruise Control", "keyboard", "y")
RegisterKeyMapping('reactivatecruise', "Cruise control hervatten", "keyboard", "add")

AddEventHandler('enteredVehicle', function(data)
    if data.seat == -1 and Config.SpeedLimit[data.model] ~= nil then
        SetMaxSpeed(data.vehicle, data.model)
        Citizen.Wait(500)
        while not IsVehicleModLoadDone(data.vehicle) do
            Citizen.Wait(100)
        end
        Citizen.Wait(500)
        SetMaxSpeed(data.vehicle, data.model)
        Vehicle = data.vehicle
    end
end)

AddEventHandler('leftVehicle', function(data)
    if SpeedLimit then
        DisableSpeedLimit()
    end
    VehicleModel = nil
    VehicleTopSpeed = nil
    Vehicle = nil
    CurrentSeat = nil
end)

AddEventHandler('changedSeat', function(data)
    if data.seat == -1 and Config.SpeedLimit[data.model] ~= nil then
        SetMaxSpeed(data.vehicle, data.model)
    end
    Vehicle = data.vehicle
    CurrentSeat = data.seat
end)

function SwitchMode()
    if Mode == "speedlimit" then
        if SpeedLimit then
            DisableSpeedLimit()
        end
        Mode = "cruisecontrol"
    else
        if CruisedSpeed ~= 0 then
            SetCruiseControlSpeed(0)
        end
        Mode = "speedlimit"
    end
    local options = {
        text = _U("changed_mode", Mode == "speedlimit" and "yellow" or "green", _U(Mode)),
        layout = "centerLeft",
        timeout = 1000,
    }
    ESX.ShowNotification('Modes Overgeschakeld naar ~g~' .. Mode .. '.')
   -- exports['pNotify']:SendNotification(options)
    SetResourceKvp("Mode", Mode)
    TriggerEvent("esx_cruisecontrol:switchedMode", Mode)
end

local vout = 0
local err = 0
local speed = 0
-- Gain values
local kp = 0.07
local ki = 0.015
local kd = 0.2

local targetSpeed = 20.0
-- outs
local maxout = 1.0
local minout = 0.0
local lastin = 0
local lastinTime = 0
local intterm = 0
local difterm = 0
function TriggerCruiseControl (cruisedSpeed)
    if CruisedSpeed == 0 and IsDriving() then
        if (GetVehiculeSpeed() > 0 and GetVehicleCurrentGear(GetVehicle()) > 0) or cruisedSpeed  then
            SetCruiseControlSpeed(cruisedSpeed or GetVehiculeSpeed())
            intterm = 0
            lastin = 0
            difterm = 0
            LastCruiseSpeed = CruisedSpeed

            local options = {
                text = _U('cruisecontrol_activated'),
                layout = "centerLeft",
                timeout = 1000,
            }
            ESX.ShowNotification('CruiseControl ~g~Ingeschakeld.')

            while CruisedSpeed > 0 and IsInVehicle() == Player do
                local vehicle = GetVehicle()
                Citizen.Wait(0)
                if not GetIsVehicleEngineRunning(vehicle) then
                    local options = {
                        text = _U('cruisecontrol_deactivated'),
                        layout = "centerLeft",
                        timeout = 1000,
                    }
                    ESX.ShowNotification('CruiseControl ~r~uitgeschakeld.')
                    UpdateCruiseUi(CruisedSpeed, false)
                    Wait(2000)
                    break
                end

                speed = GetEntitySpeed(vehicle)
                if GetGameTimer() - lastinTime >= 100 then
                    err = CruisedSpeed - speed
                    if err < -2.0 then
                        intterm = 0
                    end
                    
                    intterm = intterm + ki * err
                    -- Limit the integral term
                    if intterm > maxout then
                        intterm = maxout
                    elseif intterm < minout then
                        intterm = minout
                    end
                    difterm = speed - lastin
        
                    vout = kp * err + intterm - kd * difterm
                    lastin = speed
                    lastinTime = GetGameTimer()
                end

                if IsControlPressed(1, 97) then
                    SetCruiseControlSpeed(speed - (1/4.0))
                    vout = minout
                end
                
                if IsControlPressed(1, 96) then
                    SetCruiseControlSpeed(speed + (1/4.0))
                    vout = math.max(maxout, vout)
                end
    
                if IsVehicleOnAllWheels(vehicle) then
                    SetControlNormal(0, 71, math.clamp(vout, 0.0, maxout))
                    SetControlNormal(1, 71, math.clamp(vout, 0.0, maxout))
                    SetControlNormal(2, 71, math.clamp(vout, 0.0, maxout))
                end

                --if not turning and IsVehicleOnAllWheels(vehicle) and speed < CruisedSpeed then
                --    SetVehicleForwardSpeed(vehicle, CruisedSpeed)
                --end
                
                if IsControlJustPressed(2, 72) then
                    local options = {
                        text = _U('cruisecontrol_deactivated'),
                        layout = "centerLeft",
                        timeout = 1000,
                    }
                    --exports['pNotify']:SendNotification(options)
                    ESX.ShowNotification('CruiseControl ~r~uitgeschakeld.')
                    UpdateCruiseUi(CruisedSpeed, false)
                    Wait(2000)
                    break
                end
            end
            LastCruiseSpeed = CruisedSpeed
            CruisedSpeed = 0
            SetControlNormal(0, 71, 0.0)
            SetControlNormal(1, 71, 0.0)
            SetControlNormal(2, 71, 0.0)
        end
    else
        SetCruiseControlSpeed(0)
    end
end

RegisterCommand('changepid', function(source, args, raw)
    if not tonumber(args[2]) then
        return
    end

    if args[1] == 'i' then
        ki = tonumber(args[2])
    elseif args[1] == 'd' then
        kd = tonumber(args[2])
    elseif args[1] == 'p' then
        kp = tonumber(args[2])
    end
end)

function SetCruiseControlSpeed(speed)
    CruisedSpeed = speed
    CruisedSpeedKm = TransformToKm(CruisedSpeed)
    if speed == 0 then
        UpdateCruiseUi(LastCruiseSpeed, false)
    else
        UpdateCruiseUi(CruisedSpeed, true)
    end
end


--- Sends a update for the cruise control to the speedometer UI
--- @param speed number The current speed of the cruisecontrol
--- @param enabled boolean the cruisecontrol is currently enabled or disabled
function UpdateCruiseUi(speed, enabled)
    TriggerEvent("speedometer:setCruiseControl", TransformToKm(speed), enabled)
end

--- Sends a update for the speedlimit to the speedometer UI
--- @param speed number The current speed of the speed limit, zero if disabled
function UpdateSpeedLimitUi(speed)
    TriggerEvent("speedometer:setSpeedLimit", speed)
end
-------------------------------------------------------------------------------
-- Title: Speed limiter.
-- Author: Serpico -- twitch.tv/SerpicoTV
-- Description: This script will restict the speed of the vehicle when
--              INPUT_MP_TEXT_CHAT_TEAM is pressed. To disable, press
--              INPUT_VEH_SUB_ASCEND + INPUT_MP_TEXT_CHAT_TEAM
-------------------------------------------------------------------------------
local useMph = false -- if false, it will display speed in kph

function TriggerSpeedLimiter()
    if SpeedLimit then
        DisableSpeedLimit()
        UpdateSpeedLimitUi(0)
    else
        EnableSpeedLimit()
    end
end

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        if SpeedLimit == true then
            DisableSpeedLimit()
            UpdateCruiseUi(0, false)
            UpdateSpeedLimitUi(0)
        end
    end
end)

local cruise
function EnableSpeedLimit(speed, hideNotify)
    SpeedLimit = true
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed,false)
    local maxSpeed = VehicleTopSpeed or GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel")
    local currentSpeed = GetEntitySpeed(vehicle)
    cruise = currentSpeed
    if speed ~= nil and speed > 0 then
        cruise = speed / 4.0
    end
    if cruise < 1 then
        SetEntityMaxSpeed(vehicle, math.max(currentSpeed, maxSpeed))
        return
    end

    cruise = math.min(maxSpeed, cruise)

    SetEntityMaxSpeed(vehicle, math.max(currentSpeed, cruise))
    if useMph then
        cruise = math.floor(cruise * 1.8 + 0.5)
        if not hideNotify then
            ESX.ShowNotification(("Snelheidslimiet ingesteld op %s mph."):format(cruise))
        end
        UpdateSpeedLimitUi(cruise)
    else
        cruise = math.floor(cruise * 3.6 + 0.5)
        if not hideNotify then
            ESX.ShowNotification(("Snelheidslimiet ingesteld op %s km/h."):format(cruise))
        end
        UpdateSpeedLimitUi(cruise)
    end
end

function DisableSpeedLimit()
    SpeedLimit = false
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(Player,false)
    VehicleModel = GetEntityModel(vehicle)
    if Config.SpeedLimit[VehicleModel] == nil then
        local maxSpeed = GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel")
        SetEntityMaxSpeed(vehicle, math.max(GetEntitySpeed(vehicle), maxSpeed * 20.0))
    else
        SetMaxSpeed(vehicle, VehicleModel)
    end
    UpdateSpeedLimitUi(nil)
    ESX.ShowNotification("Snelheidslimiet is uitgeschakeld!")
end

function SetMaxSpeed(vehicle, displayName)
    if displayName == nil then
        displayName = GetEntityModel(vehicle)
    end

    local vehicleData = Config.SpeedLimit[displayName]

    if vehicleData == nil then
        return
    end

    local multiplier = 1.0
    local mod = (GetVehicleMod(vehicle, 11) or -1) + 1
    if vehicleData.engine ~= nil then
        multiplier = multiplier + (vehicleData.engine * mod)
    else
        multiplier = multiplier + (Config.EngineMultiplier * mod)
    end

    local mod = (GetVehicleMod(vehicle, 13) or -1) + 1
    if vehicleData.transmission ~= nil then
        multiplier = multiplier + (vehicleData.transmission * mod)
    else
        multiplier = multiplier + (Config.TransmissionMultiplier * mod)
    end

    local mod = IsToggleModOn(vehicle, 18) and 1 or 0
    if vehicleData.turbo ~= nil then
        multiplier = multiplier + (vehicleData.turbo * mod)
    else
        multiplier = multiplier + (Config.TurboMultiplier * mod)
    end

    local mod = (GetVehicleMod(vehicle, 16) or -1) + 1
    if vehicleData.armor ~= nil then
        multiplier = multiplier + (vehicleData.armor * mod)
    else
        multiplier = multiplier + (Config.ArmorMultiplier * mod)
    end

    local speed = (vehicleData.speed / SpeedMultiplier) * multiplier

--    print(("CruiseControl Voertuig gelimiteerd naar: %.1f m/s - %.1f km/h - %.2f x"):format(speed, speed*SpeedMultiplier, multiplier))

    VehicleTopSpeed = speed
    VehicleModel = displayName

    SetEntityMaxSpeed(vehicle, speed)
end

AddEventHandler('iens:repaired', function(vehicle)
    local model = GetEntityModel(vehicle)
    SetMaxSpeed(vehicle, model)
end)

exports('resetLimit', function(vehicle)
    if SpeedLimit then
        EnableSpeedLimit(cruise, true)
    else
        local model = GetEntityModel(vehicle)
        if Config.SpeedLimit[model] == nil then
            local maxSpeed = GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel")
            SetEntityMaxSpeed(vehicle, maxSpeed * 20.0)
        else
            SetMaxSpeed(vehicle, model)
        end
    end
end)

exports('setLimit', function(vehicle, speed)
    SetEntityMaxSpeed(vehicle, speed / 4.0)
end)

exports('setLimiter', function(vehicle)
    SetMaxSpeed(vehicle, GetEntityModel(vehicle))
end)

AddEventHandler('CruiseControl:SetLimiter', function(vehicle)
    SetMaxSpeed(vehicle, GetEntityModel(vehicle))
end)

function showHelpNotification(msg)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(0, 0, 1, -1)
end

function IsTurningOrHandBraking ()
    return IsControlPressed(2, 76) or IsControlPressed(2, 63) or IsControlPressed(2, 64)
end

function IsDriving ()
    return IsPedInAnyVehicle(Player, false)
end

function GetVehicle ()
    return GetVehiclePedIsIn(Player, false)
end

function IsInVehicle ()
    return GetPedInVehicleSeat(GetVehicle(), -1)
end

function IsDriver (vehicle)
    if vehicle ~= 0 then
        return GetPedInVehicleSeat(vehicle, -1) == Player
    else
        return false
    end
end

function GetVehiculeSpeed (vehicle)
    if vehicle == nil then
        return GetEntitySpeed(GetVehicle())
    else
        return GetEntitySpeed(vehicle)
    end
end

local trailer = nil

local function MaxSpeedCheck()
    Citizen.SetTimeout(10000, MaxSpeedCheck)
    if Vehicle ~= nil and trailer == nil then
        local _hasTrailer, _trailer = GetVehicleTrailerVehicle(Vehicle, trailer)
        if _hasTrailer then
            trailer = _trailer
            SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(trailer), true)
            SetEntityAsMissionEntity(trailer, true, true)
            SetVehicleHasBeenOwnedByPlayer(trailer, true)
            SetVehicleNeedsToBeHotwired(trailer, false)
        end
    elseif Vehicle == nil then
        trailer = nil
    end

    if VehicleTopSpeed and not SpeedLimit then
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
        if DoesEntityExist(vehicle) then
            DecorSetInt(vehicle, "_LAST_LEFT", GetTime())
        end
        if vehicle ~= Vehicle or not DoesEntityExist(Vehicle) then
            Vehicle = vehicle
        end
        SetEntityMaxSpeed(Vehicle, VehicleTopSpeed)
    end
end

Citizen.SetTimeout(10000, MaxSpeedCheck)

function TransformToKm (speed)
    return math.floor(speed * SpeedMultiplier + 0.5)
end

function TransformToMs(speed)
    return math.floor(speed / SpeedMultiplier)
end

RegisterCommand('speedlimit', function(source, args, raw)
    local speed = tonumber(args[1])
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    local currentSpeed = GetEntitySpeed(vehicle)
    if currentSpeed * 4.0 < speed and speed and speed > 0.5 then
        EnableSpeedLimit(speed)
    end
end)

AddEventHandler('updateTime', function(_time)
    UpdateTime(_time)
end)

local time = nil
function GetTime()
    -- 1590254141 is 23/05/2020, datetime should be higher than that
    if time and time < 1590254141 then
        return GetCloudTimeAsInt()
    end
    return time or GetCloudTimeAsInt()
end

function UpdateTime(_time)
    time = _time
end