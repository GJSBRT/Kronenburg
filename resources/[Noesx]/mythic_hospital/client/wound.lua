﻿--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
local isBleeding = 0
local bleedTickTimer, advanceBleedTimer = 0, 0
local fadeOutTimer, blackoutTimer = 0, 0

local onPainKiller = 0
local wasOnPainKillers = false

local onDrugs = 0
local wasOnDrugs = false

local legCount = 0
local armcount = 0
local headCount = 0

local playerHealth = nil
local playerArmour = nil

local limbNotifId = 'MHOS_LIMBS'
local bleedNotifId = 'MHOS_BLEED'
local bleedMoveNotifId = 'MHOS_BLEEDMOVE'

local BodyParts = {
    ['HEAD'] = { label = '~r~hoofd~s~', causeLimp = false, isDamaged = false, severity = 0 },
    ['NECK'] = { label = '~r~nek~s~', causeLimp = false, isDamaged = false, severity = 0 },
    ['SPINE'] = { label = '~r~rug~s~', causeLimp = true, isDamaged = false, severity = 0 },
    ['UPPER_BODY'] = { label = '~r~bovenlichaam~s~', causeLimp = false, isDamaged = false, severity = 0 },
    ['LOWER_BODY'] = { label = '~r~onderlichaam~s~', causeLimp = true, isDamaged = false, severity = 0 },
    ['LARM'] = { label = '~r~linkerarm~s~', causeLimp = false, isDamaged = false, severity = 0 },
    ['LHAND'] = { label = '~r~linkerhand~s~', causeLimp = false, isDamaged = false, severity = 0 },
    ['LFINGER'] = { label = '~r~linker vingers~s~', causeLimp = false, isDamaged = false, severity = 0 },
    ['LLEG'] = { label = '~r~linkerbeen~s~', causeLimp = true, isDamaged = false, severity = 0 },
    ['LFOOT'] = { label = '~r~linkervoet~s~', causeLimp = true, isDamaged = false, severity = 0 },
    ['RARM'] = { label = '~r~rechterarm~s~', causeLimp = false, isDamaged = false, severity = 0 },
    ['RHAND'] = { label = '~r~rechterhand~s~', causeLimp = false, isDamaged = false, severity = 0 },
    ['RFINGER'] = { label = '~r~rechter vingers~s~', causeLimp = false, isDamaged = false, severity = 0 },
    ['RLEG'] = { label = '~r~rechterbeen~s~', causeLimp = true, isDamaged = false, severity = 0 },
    ['RFOOT'] = { label = '~r~rechtervoet~s~', causeLimp = true, isDamaged = false, severity = 0 },
}

local injured = {}

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function IsInjuryCausingLimp()
    for k, v in pairs(BodyParts) do
        if v.causeLimp and v.isDamaged then
            return true
        end
    end

    return false
end

function IsInjuredOrBleeding()
    if isBleeding > 0 then
        return true
    else
        for k, v in pairs(BodyParts) do
            if v.isDamaged then
                return true
            end
        end
    end

    return false
end

function GetDamagingWeapon(ped)
    for k, v in pairs(Config.Weapons) do
        if HasPedBeenDamagedByWeapon(ped, k, 0) then
            ClearEntityLastDamageEntity(ped)
            return v
        end
    end

    return nil
end

function ProcessRunStuff(ped)
    if IsInjuryCausingLimp() and not (onPainKiller > 0)  then
        RequestAnimSet("move_m@injured")
        while not HasAnimSetLoaded("move_m@injured") do
            Citizen.Wait(0)
        end
        SetPedMovementClipset(ped, "move_m@injured", 1 )
        SetPlayerSprint(PlayerId(), false)

        local level = 0
        for k, v in pairs(injured) do
            if v.severity > level then
                level = v.severity
            end
        end

        SetPedMoveRateOverride(ped, Config.MovementRate[level])

        if wasOnPainKillers then
            SetPedToRagdoll(ped, 1500, 2000, 3, true, true, false)
            wasOnPainKillers = false
            ESX.ShowNotification('You\'ve Realized Doing Drugs Does Not Fix All Your Problems')
            --exports['mythic_notify']:DoCustomHudText('inform', 'You\'ve Realized Doing Drugs Does Not Fix All Your Problems', 5000)
        end
    else
        SetPedMoveRateOverride(ped, 1.0)
        ResetPedMovementClipset(ped, 1.0)

        if not wasOnPainKillers and (onPainKiller > 0) then wasOnPainKillers = true end

        if onPainKiller > 0 then
            onPainKiller = onPainKiller - 1
        end
    end
end

function ProcessDamage(ped)
    if not IsEntityDead(ped) or not (onDrugs > 0) then
        -- print('process')
        for k, v in pairs(injured) do
            if (v.part == 'LLEG' and v.severity > 1) or (v.part == 'RLEG' and v.severity > 1) or (v.part == 'LFOOT' and v.severity > 2) or (v.part == 'RFOOT' and v.severity > 2) then
                if legCount >= Config.LegInjuryTimer then
                    if not IsPedRagdoll(ped) and IsPedOnFoot(ped) then
                        local chance = math.random(100)
                        if (IsPedRunning(ped) or IsPedSprinting(ped)) then
                            if chance <= Config.LegInjuryChance.Running then
                                ESX.ShowNotification('Rennen lukt bijna niet door de pijn')
                                --exports['mythic_notify']:DoCustomHudText('inform', 'You\'re Having A Hard Time Running', 5000)
                                ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08) -- change this float to increase/decrease camera shake
                                SetPedToRagdollWithFall(ped, 1500, 2000, 1, GetEntityForwardVector(ped), 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
                            end
                        else
                            if chance <= Config.LegInjuryChance.Walking then
                                ESX.ShowNotification('Door de pijn wordt lopen moeilijker')
                                --exports['mythic_notify']:DoCustomHudText('inform', 'You\'re Having A Hard Using Your Legs', 5000)
                                ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08) -- change this float to increase/decrease camera shake
                                SetPedToRagdollWithFall(ped, 1500, 2000, 1, GetEntityForwardVector(ped), 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
                            end
                        end
                    end
                    legCount = 0
                else
                    legCount = legCount + 1
                end
            elseif (v.part == 'LARM' and v.severity > 1) or (v.part == 'LHAND' and v.severity > 1) or (v.part == 'LFINGER' and v.severity > 2) or (v.part == 'RARM' and v.severity > 1) or (v.part == 'RHAND' and v.severity > 1) or (v.part == 'RFINGER' and v.severity > 2) then
                if armcount >= Config.ArmInjuryTimer then
                    local chance = math.random(100)

                    if (v.part == 'LARM' and v.severity > 1) or (v.part == 'LHAND' and v.severity > 1) or (v.part == 'LFINGER' and v.severity > 2) then
                        local isDisabled = 15
                        Citizen.CreateThread(function()
                            while isDisabled > 0 do
                                if IsPedInAnyVehicle(ped, true) then
                                    DisableControlAction(0, 63, true) -- veh turn left
                                end

                                if IsPlayerFreeAiming(PlayerId()) then
                                    DisablePlayerFiring(PlayerId(), true) -- Disable weapon firing
                                end

                                isDisabled = isDisabled - 1
                                Citizen.Wait(1)
                            end
                        end)
                    else
                        local isDisabled = 15
                        Citizen.CreateThread(function()
                            while isDisabled > 0 do
                                if IsPedInAnyVehicle(ped, true) then
                                    DisableControlAction(0, 63, true) -- veh turn left
                                end

                                if IsPlayerFreeAiming(PlayerId()) then
                                    DisableControlAction(0, 25, true) -- Disable weapon firing
                                end

                                isDisabled = isDisabled - 1
                                Citizen.Wait(1)
                            end
                        end)
                    end

                    armcount = 0
                else
                    armcount = armcount + 1
                end
            elseif (v.part == 'HEAD' and v.severity > 2) then
                if headCount >= Config.HeadInjuryTimer then
                    local chance = math.random(100)

                    if chance <= Config.HeadInjuryChance then
                        ESX.ShowNotification('Het werd ineens zwart voor je ogen')
                        --exports['mythic_notify']:DoCustomHudText('inform', 'You Suddenly Black Out', 5000)
                        SetFlash(0, 0, 100, 10000, 100)
                        
                        DoScreenFadeOut(100)
                        while not IsScreenFadedOut() do
                            Citizen.Wait(0)
                        end

                        if not IsPedRagdoll(ped) and IsPedOnFoot(ped) and not IsPedSwimming(ped) then
                            ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08) -- change this float to increase/decrease camera shake
                            SetPedToRagdoll(ped, 5000, 1, 2)
                        end

                        Citizen.Wait(5000)
                        DoScreenFadeIn(250)
                    end
                    headCount = 0
                else
                    headCount = headCount + 1
                end
            end
        end

        if wasOnDrugs then
            SetPedToRagdoll(ped, 1500, 2000, 3, true, true, false)
            wasOnDrugs = false
            ESX.ShowNotification('You\'ve Realized Doing Drugs Does Not Fix All Your Problems')
            --exports['mythic_notify']:DoCustomHudText('inform', 'You\'ve Realized Doing Drugs Does Not Fix All Your Problems', 5000)
        end
    else
        onDrugs = onDrugs - 1

        if not wasOnDrugs then
            wasOnDrugs = true
        end
    end
end

function CheckDamage(ped, bone, weapon)
    if weapon == nil then return end

    if Config.Bones[bone] ~= nil then
        if not BodyParts[Config.Bones[bone]].isDamaged then
            BodyParts[Config.Bones[bone]].isDamaged = true
            BodyParts[Config.Bones[bone]].severity = 1
            --exports['mythic_notify']:DoHudText('inform', 'Your ' .. BodyParts[Config.Bones[bone]].label .. ' feels ' .. Config.WoundStates[BodyParts[Config.Bones[bone]].severity])
            if weapon == Config.WeaponClasses['SMALL_CALIBER'] or weapon == Config.WeaponClasses['MEDIUM_CALIBER'] or weapon == Config.WeaponClasses['CUTTING'] or weapon == Config.WeaponClasses['WILDLIFE'] or weapon == Config.WeaponClasses['OTHER'] or weapon == Config.WeaponClasses['LIGHT_IMPACT'] then
                if (Config.Bones[bone] == 'UPPER_BODY' or Config.Bones[bone] == 'LOWER_BODY' or Config.Bones[bone] == 'SPINE') and (weapon == Config.WeaponClasses['SMALL_CALIBER'] or weapon == Config.WeaponClasses['MEDIUM_CALIBER']) then
                    if GetPedArmour(ped) > 0 then
                        local chance = math.random(100)
                        if chance <= math.ceil(Config.BodyArmorStaggerChance / 2) then
                            SetPedToRagdoll(ped, 1500, 2000, 2, true, true, false)
                        end
                    else
                        if Config.Bones[bone] == 'SPINE' then
                            SetPedToRagdoll(ped, 1500, 2000, 2, true, true, false)
                        end
    
                        ApplyBleed(1)
                    end
                else
                    ApplyBleed(1)
                end
            elseif weapon == Config.WeaponClasses['HIGH_CALIBER'] or weapon == Config.WeaponClasses['HEAVY_IMPACT'] or weapon == Config.WeaponClasses['SHOTGUN'] or weapon == Config.WeaponClasses['EXPLOSIVE'] then
                if (Config.Bones[bone] == 'UPPER_BODY' or Config.Bones[bone] == 'LOWER_BODY' or Config.Bones[bone] == 'SPINE') and (weapon == Config.WeaponClasses['HIGH_CALIBER'] or weapon == Config.WeaponClasses['SHOTGUN']) then
                    if GetPedArmour(ped) > 0 then
                        local chance = math.random(100)
                        if chance <= math.ceil(Config.BodyArmorStaggerChance) then
                            SetPedToRagdoll(ped, 1500, 2000, 3, true, true, false)
                        end

                        if isBleeding < 1 then
                            local chance = math.random(100)
                            if chance <= math.ceil(Config.AmorHighCalBleedChance) then
                                ApplyBleed(1)
                            end
                        end
                    else
                        if Config.Bones[bone] == 'SPINE' then
                            SetPedToRagdoll(ped, 1500, 2000, 3, true, true, false)
                        end
                        ApplyBleed(2)
                    end
                else
                    ApplyBleed(2)
                end
            end

            table.insert(injured, {
                part = Config.Bones[bone],
                label = BodyParts[Config.Bones[bone]].label,
                severity = BodyParts[Config.Bones[bone]].severity
            })

            TriggerServerEvent('mythic_hospital:server:SyncInjuries', {
                limbs = BodyParts,
                isBleeding = tonumber(isBleeding)
            })

            ProcessRunStuff(ped)
            
            DoBleedAlert()
        else
            if weapon == Config.WeaponClasses['SMALL_CALIBER'] or weapon == Config.WeaponClasses['MEDIUM_CALIBER'] or weapon == Config.WeaponClasses['CUTTING'] or weapon == Config.WeaponClasses['WILDLIFE'] or weapon == Config.WeaponClasses['OTHER'] or weapon == Config.WeaponClasses['LIGHT_IMPACT'] then
                if (Config.Bones[bone] == 'UPPER_BODY' or Config.Bones[bone] == 'LOWER_BODY' or Config.Bones[bone] == 'SPINE') and (weapon == Config.WeaponClasses['SMALL_CALIBER'] or weapon == Config.WeaponClasses['MEDIUM_CALIBER']) then
                    if GetPedArmour(ped) > 0 then
                        local chance = math.random(100)
                        if chance <= math.ceil(Config.BodyArmorStaggerChance / 2) then
                            SetPedToRagdoll(ped, 1500, 2000, 2, true, true, false)
                        end
                    else
                        if Config.Bones[bone] == 'SPINE' then
                            SetPedToRagdoll(ped, 1500, 2000, 2, true, true, false)
                        end
    
                        ApplyBleed(1)
                    end
                else
                    ApplyBleed(1)
                end
            elseif weapon == Config.WeaponClasses['HIGH_CALIBER'] or weapon == Config.WeaponClasses['HEAVY_IMPACT'] or weapon == Config.WeaponClasses['SHOTGUN'] or weapon == Config.WeaponClasses['EXPLOSIVE'] then
                if (Config.Bones[bone] == 'UPPER_BODY' or Config.Bones[bone] == 'LOWER_BODY' or Config.Bones[bone] == 'SPINE') and (weapon == Config.WeaponClasses['HIGH_CALIBER'] or weapon == Config.WeaponClasses['SHOTGUN']) then
                    if GetPedArmour(ped) > 0 then
                        local chance = math.random(100)
                        if chance <= math.ceil(Config.BodyArmorStaggerChance) then
                            SetPedToRagdoll(PlayerPedId(), 1500, 2000, 3, true, true, false)
                        end

                        if isBleeding < 1 then
                            local chance = math.random(100)
                            if chance <= math.ceil(Config.AmorHighCalBleedChance) then
                                ApplyBleed(1)
                            end
                        end
                    else
                        if Config.Bones[bone] == 'SPINE' then
                            SetPedToRagdoll(PlayerPedId(), 1500, 2000, 3, true, true, false)
                        end
    
                        ApplyBleed(2)
                    end
                else
                    ApplyBleed(2)
                end
            end

            if BodyParts[Config.Bones[bone]].severity < 4 then
                BodyParts[Config.Bones[bone]].severity = BodyParts[Config.Bones[bone]].severity + 1
                TriggerServerEvent('mythic_hospital:server:SyncInjuries', {
                    limbs = BodyParts,
                    isBleeding = tonumber(isBleeding)
                })

                for k, v in pairs(injured) do
                    if v.part == Config.Bones[bone] then
                        v.severity = BodyParts[Config.Bones[bone]].severity
                    end
                end
            end

            ProcessRunStuff(ped)
            
            DoBleedAlert()
        end
    else
        print('Bone Not In Index - Report This! - ' .. bone)
    end
end

function ApplyBleed(level)
    if isBleeding ~= 4 then
        if isBleeding + level > 4 then
            isBleeding = 4
        else
            isBleeding = isBleeding + level
        end
    end
end

RegisterNetEvent('mythic_hospital:client:SyncBleed')
AddEventHandler('mythic_hospital:client:SyncBleed', function(bleedStatus)
    isBleeding = tonumber(bleedStatus)
    DoBleedAlert()
end)

RegisterNetEvent('mythic_hospital:client:FieldTreatLimbs')
AddEventHandler('mythic_hospital:client:FieldTreatLimbs', function()
    for k, v in pairs(BodyParts) do
        v.isDamaged = false
        v.severity = 1
    end

    for k, v in pairs(injured) do
        if v.part == Config.Bones[bone] then
            v.severity = BodyParts[Config.Bones[bone]].severity
        end
    end
    
    TriggerServerEvent('mythic_hospital:server:SyncInjuries', {
        limbs = BodyParts,
        isBleeding = tonumber(isBleeding)
    })

    ProcessRunStuff(PlayerPedId())
    
end)
RegisterNetEvent('mythic_hospital:client:FieldTreatBleed')
AddEventHandler('mythic_hospital:client:FieldTreatBleed', function()
    if isBleeding > 1 then
        isBleeding = tonumber(isBleeding) - 1
    
        TriggerServerEvent('mythic_hospital:server:SyncInjuries', {
            limbs = BodyParts,
            isBleeding = tonumber(isBleeding)
        })

        ProcessRunStuff(PlayerPedId())
        DoBleedAlert()
    end
end)

RegisterNetEvent('mythic_hospital:client:ReduceBleed')
AddEventHandler('mythic_hospital:client:ReduceBleed', function()
    if isBleeding > 0 then
        isBleeding = tonumber(isBleeding) - 1
    
        TriggerServerEvent('mythic_hospital:server:SyncInjuries', {
            limbs = BodyParts,
            isBleeding = tonumber(isBleeding)
        })

        ProcessRunStuff(PlayerPedId())
        DoBleedAlert()
    end
end)


RegisterNetEvent('mythic_hospital:client:ResetLimbs')
AddEventHandler('mythic_hospital:client:ResetLimbs', function()
    for k, v in pairs(BodyParts) do
        v.isDamaged = false
        v.severity = 0
    end
    injured = {}
    
    TriggerServerEvent('mythic_hospital:server:SyncInjuries', {
        limbs = BodyParts,
        isBleeding = tonumber(isBleeding)
    })

    ProcessRunStuff(PlayerPedId())
    
end)

RegisterNetEvent('mythic_hospital:client:RemoveBleed')
AddEventHandler('mythic_hospital:client:RemoveBleed', function()
    isBleeding = 0
    
    TriggerServerEvent('mythic_hospital:server:SyncInjuries', {
        limbs = BodyParts,
        isBleeding = tonumber(isBleeding)
    })

    ProcessRunStuff(PlayerPedId())
    -- DoBleedAlert()
end)

RegisterNetEvent('mythic_hospital:client:UsePainKiller')
AddEventHandler('mythic_hospital:client:UsePainKiller', function(tier)
    if tier < 4 then
        onPainKiller = 90 * tier
    end

    exports['mythic_notify']:DoCustomHudText('inform', 'You feel the pain subside temporarily', 5000)
    ProcessRunStuff(PlayerPedId())
end)

RegisterNetEvent('mythic_hospital:client:UseAdrenaline')
AddEventHandler('mythic_hospital:client:UseAdrenaline', function(tier)
    if tier < 4 then
        onDrugs = 180 * tier
    end

    exports['mythic_notify']:DoCustomHudText('inform', 'You\'re Able To Ignore Your Body Failing', 5000)
    ProcessRunStuff(PlayerPedId())
end)  

local prevPos = nil
Citizen.CreateThread(function()
    prevPos = GetEntityCoords(PlayerPedId(), true)
    while true do
        local player = PlayerPedId()
        if bleedTickTimer >= Config.BleedTickRate then
            if not IsEntityDead(player) then
                if isBleeding > 0 then
                    if isBleeding == 1 then
                        SetFlash(0, 0, 100, 100, 100)
                    elseif isBleeding == 2 then
                        SetFlash(0, 0, 100, 250, 100)
                    elseif isBleeding == 3 then
                        SetFlash(0, 0, 100, 500, 100)
                        --Function.Call(Hash.SET_FLASH, 0, 0, 100, 500, 100);
                    elseif isBleeding == 4 then
                        SetFlash(0, 0, 100, 500, 100)
                        --Function.Call(Hash.SET_FLASH, 0, 0, 100, 500, 100);
                    end
                    
                    if fadeOutTimer % Config.FadeOutTimer == 0 then
                        if blackoutTimer >= Config.BlackoutTimer then
                            ESX.ShowNotification('Je krijgt last van je hoofd')
                            --exports['mythic_notify']:DoCustomHudText('inform', 'Je krijgt last van je hoofd', 5000)
                            SetFlash(0, 0, 100, 7000, 100)
                                
                            DoScreenFadeOut(500)
                            while not IsScreenFadedOut() do
                                Citizen.Wait(0)
                            end
                    
                            if not IsPedRagdoll(player) and IsPedOnFoot(player) and not IsPedSwimming(player) then
                                ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08) -- change this float to increase/decrease camera shake
                                SetPedToRagdollWithFall(PlayerPedId(), 7500, 9000, 1, GetEntityForwardVector(player), 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
                            end
                    
                            Citizen.Wait(1500)
                            DoScreenFadeIn(1000)
                            blackoutTimer = 0
                        else
                            DoScreenFadeOut(2000)
                            while not IsScreenFadedOut() do
                                Citizen.Wait(0)
                            end
                            DoScreenFadeIn(2000)
                            if isBleeding > 3 then
                                blackoutTimer = blackoutTimer + 2
                            else
                                blackoutTimer = blackoutTimer + 1
                            end
                            fadeOutTimer = 0
                        end
                    else
                        fadeOutTimer = fadeOutTimer + 1
                    end

                    --exports['mythic_notify']:DoCustomHudText('inform', 'You Have ' .. Config.BleedingStates[isBleeding], 25000)
                    local bleedDamage = tonumber(isBleeding) * Config.BleedTickDamage
                    ApplyDamageToPed(player, bleedDamage, false)
                    playerHealth = playerHealth - bleedDamage

                    if advanceBleedTimer >= Config.AdvanceBleedTimer then
                        ApplyBleed(1)
                        DoBleedAlert()
                        advanceBleedTimer = 0
                    end

                end
            end
            bleedTickTimer = 0
        else
            if math.floor(bleedTickTimer % (Config.BleedTickRate / 10)) == 0 then
                local currPos = GetEntityCoords(player, true)
                local moving = #(vector2(prevPos.x, prevPos.y) - vector2(currPos.x, currPos.y))
                if (moving > 1 and not IsPedInAnyVehicle(player)) and isBleeding > 2 then
                    ESX.ShowNotification('Pas op, je wonden bloeden heviger als je gaat bewegen')
                    --exports['mythic_notify']:PersistentHudText('start', bleedMoveNotifId, 'inform', 'You notice blood oozing from your wounds faster when you\'re moving', { ['background-color'] = '#4d0e96' })
                    advanceBleedTimer = advanceBleedTimer + Config.BleedMovementAdvance
                    bleedTickTimer = bleedTickTimer + Config.BleedMovementTick
                    prevPos = currPos
                else
                    --exports['mythic_notify']:PersistentHudText('end', bleedMoveNotifId)
                    advanceBleedTimer = advanceBleedTimer + 1
                    bleedTickTimer = bleedTickTimer + 1
                end

            else

            end
            bleedTickTimer = bleedTickTimer + 1
        end

		Citizen.Wait(1000)
	end
end)

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local health = GetEntityHealth(ped)
        local armor = GetPedArmour(ped)

        if not playerHealth then
            playerHealth = health
        end

        if not playerArmor then
            playerArmor = armor
        end

        local armorDamaged = (playerArmor ~= armor and armor < (playerArmor - Config.ArmorDamage) and armor > 0) -- Players armor was damaged
        local healthDamaged = (playerHealth ~= health and health < (playerHealth - Config.HealthDamage)) -- Players health was damaged
        
        if armorDamaged or healthDamaged then
            local hit, bone = GetPedLastDamageBone(ped)
            local bodypart = Config.Bones[bone]

            if hit and bodypart ~= 'NONE' then
                local checkDamage = true
                local weapon = GetDamagingWeapon(ped)
                if weapon ~= nil then
                    if armorDamaged and (bodypart == 'SPINE' or bodypart == 'LOWER_BODY') and weapon <= Config.WeaponClasses['LIGHT_IMPACT'] and weapon ~= Config.WeaponClasses['NOTHING'] then
                        checkDamage = false -- Don't check damage if the it was a body shot and the weapon class isn't that strong
                    end

                    if checkDamage then
                        TriggerEvent('DNATracker:DamageC')
                        CheckDamage(ped, bone, weapon)
                    end
                end
            end
        end

        playerHealth = health
        playerArmor = armor
        Citizen.Wait(500)

		ProcessDamage(ped)
		Citizen.Wait(500)
	end
end)

--[[ Player Died Events ]]--


RegisterNetEvent('baseevents:onPlayerKilled')
AddEventHandler('baseevents:onPlayerKilled', function(killedBy, data)
    TriggerEvent('mythic_hospital:client:ResetLimbs')
    TriggerEvent('mythic_hospital:client:RemoveBleed')
end)

RegisterNetEvent('baseevents:onPlayerDied')
AddEventHandler('baseevents:onPlayerDied', function(killedBy, pos)
    TriggerEvent('mythic_hospital:client:ResetLimbs')
    TriggerEvent('mythic_hospital:client:RemoveBleed')
end)