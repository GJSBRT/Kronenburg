ESX = nil

Citizen.CreateThread(function()
    --[[ ESX ]]
    while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

    --[[ The loop ]]
    while true do
        Citizen.Wait(0)
        local ped = GetPlayerPed(-1)

        --[[ Pause menu ]]
        --[[ Pause menu ]]
        function AddTextEntry(key, value)
            Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
        end
        AddTextEntry('PM_SCR_MAP', "Kronenburg")
        AddTextEntry('PM_SCR_GAM', "Verlaat de Stad")
        AddTextEntry('PM_SCR_SET', "Instellingen")

        --[[ Boat Anchor ]]
        if IsPedInAnyBoat(ped) then
            boat = GetVehiclePedIsIn(ped, true)
        end
        if IsControlJustPressed(1, 81) and not IsPedInAnyVehicle(ped) and boat ~= nil then
            if not anchored then
                SetBoatAnchor(boat, true)
                TaskStartScenarioInPlace(ped, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
                Citizen.Wait(10000)
                TriggerEvent("pNotify:SendNotification", {
                    text = "Boat geankerd!",
                    type = "success",
                    timeout = (3000),
                    layout = "bottomCenter",
                    queue = "global",
                    animation = { open = "gta_effects_fade_in", close = "gta_effects_fade_out" },
                    killer = true,
                    sounds = {
                        sources = { "Anchordown.ogg" }, -- For sounds to work, you place your sound in the html folder and then add it to the files array in the __resource.lua file.
                        volume = 0.1,
                        conditions = { "docVisible" }
                    }
                })
                ClearPedTasks(ped)
            else
                TaskStartScenarioInPlace(ped, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
                Citizen.Wait(10000)
                SetBoatAnchor(boat, false)
                TriggerEvent("pNotify:SendNotification", {
                    text = "Boot van anker afgehaald",
                    type = "success",
                    timeout = (3000),
                    layout = "bottomCenter",
                    queue = "global",
                    animation = { open = "gta_effects_fade_in", close = "gta_effects_fade_out" },
                    killer = true,
                    sounds = {
                        sources = { "Anchorup.ogg" }, -- For sounds to work, you place your sound in the html folder and then add it to the files array in the __resource.lua file.
                        volume = 0.1,
                        conditions = { "docVisible" }
                    }
                })
                ClearPedTasks(ped)
            end
            anchored = not anchored
        end
        if IsVehicleEngineOn(boat) then
            anchored = false
        end


        --[[ Dispatch Client ]]
        for i = 1, 15 do
            EnableDispatchService(i, false)
        end
        local playerLocalisation = GetEntityCoords(ped)
        ClearAreaOfCops(playerLocalisation.x, playerLocalisation.y, playerLocalisation.z, 400.0)


        --[[ Pause Menu ]]
        N_0xb9449845f73f5e9c("SHIFT_CORONA_DESC")
        PushScaleformMovieFunctionParameterBool(true)
        PopScaleformMovieFunction()
        N_0xb9449845f73f5e9c("SET_HEADER_TITLE")
        PushScaleformMovieFunctionParameterString("~y~Kronenburg Roleplay")
        PushScaleformMovieFunctionParameterBool(true)
        PushScaleformMovieFunctionParameterString("kronenburgrp.nl/discord")
        PushScaleformMovieFunctionParameterBool(true)
        PopScaleformMovieFunctionVoid()

        --[[ Remove Cops ]]
        local playerLocalisation = GetEntityCoords(GetPlayerPed(-1))
        ClearAreaOfCops(playerLocalisation.x, playerLocalisation.y, playerLocalisation.z, 400.0)


        --[[ Niet meer op je kop slaan :) aka gun whipping ]]
        if IsPedArmed(ped, 4) then
			DisableControlAction(0, 140, true) 
			DisableControlAction(0, 141, true) 
			DisableControlAction(0, 142, true) 
		end
    end
end)

--[[ Extra Threads ]]
--[[ No NPC ]]
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2) -- Prevent crashing.
		SetCreateRandomCops(false)
		SetCreateRandomCopsNotOnScenarios(false)
		SetCreateRandomCopsOnScenarios(false)
        SetVehicleDensityMultiplierThisFrame(0.0)
        SetPedDensityMultiplierThisFrame(0.0)
		SetRandomVehicleDensityMultiplierThisFrame(0.0)
		SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)
		SetParkedVehicleDensityMultiplierThisFrame(0.0)
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))
		ClearAreaOfVehicles(x, y, z, 1000, false, false, false, false, false)
		RemoveVehiclesFromGeneratorsInArea(x - 500.0, y - 500.0, z - 500.0, x + 500.0, y + 500.0, z + 500.0);
    end
end)

--[[ Handsup ]]
Citizen.CreateThread(function()
    local dicthandsup = "missminuteman_1ig_2"
    
	RequestAnimDict(dicthandsup)
	while not HasAnimDictLoaded(dicthandsup) do
		Citizen.Wait(100)
	end
    local handsup = false
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(1, 323) then
            if not handsup then
                TaskPlayAnim(GetPlayerPed(-1), dicthandsup, "handsup_enter", 8.0, 8.0, -1, 50, 0, false, false, false)
                handsup = true
            else
                handsup = false
                ClearPedTasks(GetPlayerPed(-1))
            end
        end
    end
end)


--[[ Events ]]
RegisterNetEvent("jumpscare:toggleNUI")
AddEventHandler("jumpscare:toggleNUI", function(display)
    SendNUIMessage({
        action = "nono"
    })
end)

RegisterNetEvent('esx_service:notifyAllInService')
AddEventHandler('esx_service:notifyAllInService', function(notification, target)
	target = GetPlayerFromServerId(target)
	if target == PlayerId() then return end

	local targetPed = GetPlayerPed(target)
	local mugshot, mugshotStr = ESX.Game.GetPedMugshot(targetPed)

	ESX.ShowAdvancedNotification(notification.title, notification.subject, notification.msg, mugshotStr, notification.iconType)
	UnregisterPedheadshot(mugshot)
end)


--[[ Crouch ]]
Citizen.CreateThread( function()
	while true do 
		Citizen.Wait(1)
		local ped = GetPlayerPed( -1 )
		if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then  
			DisableControlAction( 0, 36, true ) 
			if ( not IsPauseMenuActive() ) then 
				if ( IsDisabledControlJustPressed( 0, 36 )) then 
					RequestAnimSet( "move_ped_crouched" )
					RequestAnimSet("MOVE_M@TOUGH_GUY@")		
					while ( not HasAnimSetLoaded( "move_ped_crouched" ) ) do 
						Citizen.Wait( 100 )
					end 
					while ( not HasAnimSetLoaded( "MOVE_M@TOUGH_GUY@" ) ) do 
						Citizen.Wait( 100 )
					end 		
					if (crouched) then 
						ResetPedMovementClipset( ped )
						ResetPedStrafeClipset(ped)
						SetPedMovementClipset( ped,"MOVE_M@TOUGH_GUY@", 0.5)
						crouched = false 
					elseif (not crouched) then
						SetPedMovementClipset( ped, "move_ped_crouched", 0.55 )
						SetPedStrafeClipset(ped, "move_ped_crouched_strafing")
						crouched = true 
					end 
				end
			end
		else
			crouched = false
		end
	end
end)
