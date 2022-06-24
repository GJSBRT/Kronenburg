ESX                           = nil

DecorRegister('_VEHICLE_LOCKED', 2)



Citizen.CreateThread(function()

	while ESX == nil do

		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

		Citizen.Wait(7)

	end

end)

AddEventHandler('unlockvehicle', function(vehicle)
	DecorRemove(vehicle, "_VEHICLE_LOCKED")
	SetVehicleDoorsLocked(vehicle, 1)
end)

AddEventHandler('lockvehicle', function(vehicle)
	DecorSetInt(vehicle, "_VEHICLE_LOCKED", 1)
	SetVehicleDoorsLocked(vehicle, 2)
end)

exports('isVehicleLocked', function(vehicle)
	local lockStatus = GetVehicleDoorLockStatus(vehicle)
	return lockStatus == 2 or lockStatus == 4 or lockStatus == 10 or DecorGetInt(vehicle, "_VEHICLE_LOCKED")
end)

function ToggleVehicleLock()

	local dict = "anim@mp_player_intmenu@key_fob@"

	RequestAnimDict(dict)

	while not HasAnimDictLoaded(dict) do

		Citizen.Wait(7)

	end

	local playerPed = PlayerPedId()

	local coords = GetEntityCoords(playerPed)

	local hasAlreadyLocked = false

	vehicle = GetVehiclePedIsIn(playerPed, true)

	if IsPedInAnyVehicle(playerPed, false) then

		vehicle = GetVehiclePedIsIn(playerPed, false)

	else

		local distance = 0

		vehicle, distance = ESX.Game.GetClosestVehicle(coords)

		if distance > 15.0 then

			vehicle = 0

		end

	end	

	DecorSetInt(vehicle, "_LAST_LEFT", GetCloudTimeAsInt())

	if vehicle == 0 then

		exports['mythic_notify']:DoHudText('error', 'Geen voertuigen in de buurt.')

	else

		local plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))

		local decorOwned = exports['KB_server']:isOwnedVehicle(vehicle, true)

		if decorOwned and hasAlreadyLocked ~= true then
			-- print("whuzz")

			local vehicleLabel = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))

			vehicleLabel = GetLabelText(vehicleLabel)

			if vehicleLabel == "NULL" then

				vehicleLabel = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))

			end

			local lock = GetVehicleDoorLockStatus(vehicle)

			if lock == 1 or lock == 0 then

				SetVehicleDoorShut(vehicle, 0, false)

				SetVehicleDoorShut(vehicle, 1, false)

				SetVehicleDoorShut(vehicle, 2, false)

				SetVehicleDoorShut(vehicle, 3, false)

				SetVehicleDoorsLocked(vehicle, 2)

				PlayVehicleDoorCloseSound(vehicle, 1)

				ESX.ShowNotification('Je hebt je voertuig ~r~vergrendeld~s~.')

				--exports['mythic_notify']:DoHudText('error', 'Je hebt je voertuig op slot gedaan.')

				if not IsPedInAnyVehicle(PlayerPedId(), true) then

					TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)

				end

				
				StartVehicleHorn(vehicle, 150, 0--[[GetHashKey("HELDDOWN")]], false)
				SetVehicleLights(vehicle, 2)
				Citizen.Wait(150)
				SetVehicleLights(vehicle, 0)
				Citizen.Wait(200)
				StartVehicleHorn(vehicle, 150, 0--[[GetHashKey("HELDDOWN")]], false)
				SetVehicleLights(vehicle, 2)
				Citizen.Wait(150)
				SetVehicleLights(vehicle, 0)

				DecorSetBool(vehicle, "_VEHICLE_LOCKED", true)
				TriggerEvent("esx_vehiclelock:lockChanged", true)

				hasAlreadyLocked = true

			elseif lock == 2 then

				SetVehicleDoorsLocked(vehicle, 1)

				PlayVehicleDoorOpenSound(vehicle, 0)


				ESX.ShowNotification('Je hebt je voertuig ~g~ontgrendeld~s~.')

				--exports['mythic_notify']:DoHudText('success', 'Je hebt je voertuig van het slot gedaan.')

				if not IsPedInAnyVehicle(PlayerPedId(), true) then

					TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)

				end

				StartVehicleHorn(vehicle, 150, 0--[[GetHashKey("HELDDOWN")]], false)
				SetVehicleLights(vehicle, 2)
				Citizen.Wait(150)
				SetVehicleLights(vehicle, 0)
				Citizen.Wait(300)
				StartVehicleHorn(vehicle, 150, 0--[[GetHashKey("HELDDOWN")]], false)
				SetVehicleLights(vehicle, 2)
				Citizen.Wait(150)
				SetVehicleLights(vehicle, 0)
				Citizen.Wait(300)
				StartVehicleHorn(vehicle, 150, 0--[[GetHashKey("HELDDOWN")]], false)
				SetVehicleLights(vehicle, 2)
				Citizen.Wait(150)
				SetVehicleLights(vehicle, 0)

				DecorSetBool(vehicle, "_VEHICLE_LOCKED", false)
				TriggerEvent("esx_vehiclelock:lockChanged", false)


				hasAlreadyLocked = true

			end

		end	

	end

end



function lights(vehicle)

	if NetworkHasControlOfEntity(vehicle) then

	SetVehicleLights(vehicle, 2)

	Citizen.Wait(150)

	SetVehicleLights(vehicle, 0)

	Citizen.Wait(150)

	SetVehicleLights(vehicle, 2)

	Citizen.Wait(150)

	SetVehicleLights(vehicle, 0)

	end

end



RegisterCommand('voertuigslot', function()

	LockVehicleCommand()

end)



LastLock = 0

function LockVehicleCommand()

	if not IsControlEnabled(0, 303) then

		print("Control not enabled...")

		return

	end



	if GetGameTimer() - LastLock < 1000 then

		print("Too soon")

		return

	end



	LastLock = GetGameTimer()

	ToggleVehicleLock()

end



RegisterKeyMapping('voertuigslot', 'Voertuig Slot', 'keyboard', 'L')