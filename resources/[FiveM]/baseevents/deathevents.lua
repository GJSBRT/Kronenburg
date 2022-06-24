local lastPed = PlayerPedId()
Citizen.CreateThread(function()
    local isDead = false
    local hasBeenDead = false
    local diedAt
    local firstMisMatch = 0
    while true do
        Citizen.Wait(0)

        local player = PlayerId()

        local ped = Citizen.InvokeNative(0xD80958FC74E988A6, Citizen.ReturnResultAnyway(), Citizen.ResultAsInteger())
        if ped ~= PlayerPedId() then
            if firstMisMatch == 0 then
                firstMisMatch = GetGameTimer()
            elseif GetGameTimer() - firstMisMatch > 500 then
                firstMisMatch = 0
                ReportError("PlayerPedId cache mismatch!", { PlayerPedId = PlayerPedId(), ped = ped, lastPed = lastPed, GameTimer = GetGameTimer() })
            end
        end
        if lastPed ~= ped or PlayerPedId() ~= ped then
            TriggerEvent('baseevents:pedChanged', ped, lastPed)
            lastPed = ped
        end
        if NetworkIsPlayerActive(player) then
            if IsPedFatallyInjured(ped) and not isDead then
                isDead = true
                if not diedAt then
                	diedAt = GetGameTimer()
                end

                local killer, killerweapon = NetworkGetEntityKillerOfPlayer(player)
				local killerentitytype = GetEntityType(killer)
				local killertype = -1
				local killerinvehicle = false
				local killervehiclename = ''
                local killervehicleseat = 0
				if killerentitytype == 1 then
					killertype = GetPedType(killer)
					if IsPedInAnyVehicle(killer, false) == 1 then
						killerinvehicle = true
						killervehiclename = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(killer)))
                        killervehicleseat = GetPedVehicleSeat(killer)
					else killerinvehicle = false
					end
				end

				local killerid = GetPlayerByEntityID(killer)
				if killer ~= ped and killerid ~= nil and NetworkIsPlayerActive(killerid) then killerid = GetPlayerServerId(killerid)
				else killerid = -1
				end

                if killer == ped or killer == -1 then
                    TriggerEvent('baseevents:onPlayerDied', killertype, { table.unpack(GetEntityCoords(ped)) })
                    TriggerServerEvent('baseevents:onPlayerDied', killertype, { table.unpack(GetEntityCoords(ped)) })
                    hasBeenDead = true
                else
                    TriggerEvent('baseevents:onPlayerKilled', killerid, {killertype=killertype, weaponhash = killerweapon, killerinveh=killerinvehicle, killervehseat=killervehicleseat, killervehname=killervehiclename, killerpos={table.unpack(GetEntityCoords(ped))}})
                    TriggerServerEvent('baseevents:onPlayerKilled', killerid, {killertype=killertype, weaponhash = killerweapon, killerinveh=killerinvehicle, killervehseat=killervehicleseat, killervehname=killervehiclename, killerpos={table.unpack(GetEntityCoords(ped))}})
                    hasBeenDead = true
                end
            elseif not IsPedFatallyInjured(ped) then
                isDead = false
                diedAt = nil
            end

            -- check if the player has to respawn in order to trigger an event
            if not hasBeenDead and diedAt ~= nil and diedAt > 0 then
                TriggerEvent('baseevents:onPlayerWasted', { table.unpack(GetEntityCoords(ped)) })
                TriggerServerEvent('baseevents:onPlayerWasted', { table.unpack(GetEntityCoords(ped)) })

                hasBeenDead = true
            elseif hasBeenDead and diedAt ~= nil and diedAt <= 0 then
                hasBeenDead = false
            end
        end
    end
end)

AddEventHandler("modelChanged", function()
    local ped = PlayerPedId()
    if lastPed ~= ped then
        print("Ped Id Changed by modelChanged!")
        TriggerEvent('baseevents:pedChanged', ped, lastPed)
        lastPed = ped
    else
        print("Ped Id still same")
    end
end)

function GetPlayerByEntityID(id)
    local players = GetActivePlayers()
    for i=1, #players do
        if(NetworkIsPlayerActive(i) and GetPlayerPed(i) == id) then return players[i] end
    end
	return nil
end
