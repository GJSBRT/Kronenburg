--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
ESX = nil

local timing, isPlayerWhitelisted = math.ceil(Config.Timer * 60000), false
local isPlayerFirefighter = false
local streetName, playerGender
local pixelMark=false
local pcoords=vector3(0,0,0)
pixelTimer = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()

	TriggerEvent('skinchanger:getSkin', function(skin)
		playerGender = skin.sex
	end)

	isPlayerWhitelisted = refreshPlayerWhitelisted()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job

	isPlayerWhitelisted = refreshPlayerWhitelisted()
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)

		if NetworkIsSessionStarted() then
			DecorRegister('isOutlaw', 3)
			DecorSetInt(PlayerPedId(), 'isOutlaw', 1)

			return
		end
	end
end)

-- Gets the player's current street.
-- Aaalso get the current player gender
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(3000)

		local playerCoords = GetEntityCoords(PlayerPedId())
		streetName,_ = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
		streetName = GetStreetNameFromHashKey(streetName)
	end
end)

AddEventHandler('skinchanger:loadSkin', function(character)
	playerGender = character.sex
end)

function refreshPlayerWhitelisted()
	if not ESX.PlayerData then
		return false
	end

	if not ESX.PlayerData.job then
		return false
	end
	
	local found = false
	for k,v in ipairs(Config.WhitelistedFirefighters) do
		if v == ESX.PlayerData.job.name then
			found = true
			isPlayerFirefighter = true
			break
		end
	end

	if not found then
		isPlayerFirefighter = false
	end


	for k,v in ipairs(Config.WhitelistedCops) do
		if v == ESX.PlayerData.job.name then
			return true
		end
	end

	return false
end
RegisterNetEvent('esx_outlawalert:notifyBrand')
AddEventHandler('esx_outlawalert:notifyBrand', function(type, data, length)
	if isPlayerFirefighter or isPlayerWhitelisted then
		SendNUIMessage({action = 'display', style = 'brandweer', info = data, length = length})
    	PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
	end
end)

RegisterNetEvent('esx_outlawalert:outlawNotify')
AddEventHandler('esx_outlawalert:outlawNotify', function(type, data, length)
	if isPlayerWhitelisted then
		SendNUIMessage({action = 'display', style = type, info = data, length = length})
    	PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", 0, 0, 1)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2000)

		if DecorGetInt(PlayerPedId(), 'isOutlaw') == 2 then
			Citizen.Wait(timing)
			DecorSetInt(PlayerPedId(), 'isOutlaw', 1)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(playerPed)

		-- is jackin'
		if (IsPedTryingToEnterALockedVehicle(playerPed) or IsPedJacking(playerPed)) and Config.CarJackingAlert then

			Citizen.Wait(3000)
			local vehicle = GetVehiclePedIsIn(playerPed, true)

			if vehicle and ((isPlayerWhitelisted and Config.ShowCopsMisbehave) or not isPlayerWhitelisted) then
				local plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))

				ESX.TriggerServerCallback('esx_outlawalert:isVehicleOwner', function(owner)
					if not owner then

						local vehicleLabel = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
						vehicleLabel = GetLabelText(vehicleLabel)

						DecorSetInt(playerPed, 'isOutlaw', 2)

						TriggerServerEvent('esx_outlawalert:carJackInProgress', {
							x = ESX.Math.Round(playerCoords.x, 1),
							y = ESX.Math.Round(playerCoords.y, 1),
							z = ESX.Math.Round(playerCoords.z, 1)
						}, streetName, vehicleLabel, playerGender)
					end
				end, plate)
			end
			-- is in combat
		elseif IsPedInMeleeCombat(playerPed) and Config.MeleeAlert then

			Citizen.Wait(3000)

			if (isPlayerWhitelisted and Config.ShowCopsMisbehave) or not isPlayerWhitelisted then
				DecorSetInt(playerPed, 'isOutlaw', 2)

				TriggerServerEvent('esx_outlawalert:combatInProgress', {
					x = ESX.Math.Round(playerCoords.x, 1),
					y = ESX.Math.Round(playerCoords.y, 1),
					z = ESX.Math.Round(playerCoords.z, 1)
				}, streetName, playerGender)
			end
			-- is shootin'
		elseif IsPedShooting(playerPed) and not IsPedCurrentWeaponSilenced(playerPed) and Config.GunshotAlert then
			local weaponHash = GetSelectedPedWeapon(PlayerPedId(-1))
			if weaponHash ~= 101631238 then -- Geen brandblusser
				Citizen.Wait(3000)
				if (isPlayerWhitelisted and Config.ShowCopsMisbehave) or not isPlayerWhitelisted then
					DecorSetInt(playerPed, 'isOutlaw', 2)

					TriggerServerEvent('esx_outlawalert:gunshotInProgress', {
						x = ESX.Math.Round(playerCoords.x, 1),
						y = ESX.Math.Round(playerCoords.y, 1),
						z = ESX.Math.Round(playerCoords.z, 1)
					}, streetName, playerGender)
				end
			end
		end
	end
end)




RegisterNetEvent('esx_outlawalert:carJackInProgress')
AddEventHandler('esx_outlawalert:carJackInProgress', function(targetCoords)
	if isPlayerWhitelisted then
		if Config.CarJackingAlert then
			local alpha = 250
			local thiefBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, Config.BlipJackingRadius)
			pixelMark=true
			SetBlipHighDetail(thiefBlip, true)
			SetBlipColour(thiefBlip, 1)
			SetBlipAlpha(thiefBlip, alpha)
			SetBlipAsShortRange(thiefBlip, true)

			while alpha ~= 0 do
				Citizen.Wait(Config.BlipJackingTime * 4)
				alpha = alpha - 1
				SetBlipAlpha(thiefBlip, alpha)

				if alpha == 0 then
					RemoveBlip(thiefBlip)
					return
				end
			end

		end
	end
end)
RegisterNetEvent('esx_outlawalert:brandInProgress')
AddEventHandler('esx_outlawalert:brandInProgress', function(targetCoords)
	if (isPlayerWhitelisted or isPlayerFirefighter) and Config.GunshotAlert then
		local alpha = 250
		local gunshotBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, Config.BlipGunRadius)
			pixelMark=true
			pcoords=targetCoords
		SetBlipHighDetail(gunshotBlip, true)
		SetBlipColour(gunshotBlip, 1)
		SetBlipAlpha(gunshotBlip, alpha)
		SetBlipAsShortRange(gunshotBlip, true)

		while alpha ~= 0 do
			Citizen.Wait(Config.BlipGunTime * 4)
			alpha = alpha - 1
			SetBlipAlpha(gunshotBlip, alpha)

			if alpha == 0 then
				RemoveBlip(gunshotBlip)
				return
			end
		end
	end
end)

RegisterNetEvent('esx_outlawalert:gunshotInProgress')
AddEventHandler('esx_outlawalert:gunshotInProgress', function(targetCoords)
	if isPlayerWhitelisted and Config.GunshotAlert then
		local alpha = 250
		local gunshotBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, Config.BlipGunRadius)
			pixelMark=true
			pcoords=targetCoords
		SetBlipHighDetail(gunshotBlip, true)
		SetBlipColour(gunshotBlip, 1)
		SetBlipAlpha(gunshotBlip, alpha)
		SetBlipAsShortRange(gunshotBlip, true)

		while alpha ~= 0 do
			Citizen.Wait(Config.BlipGunTime * 4)
			alpha = alpha - 1
			SetBlipAlpha(gunshotBlip, alpha)

			if alpha == 0 then
				RemoveBlip(gunshotBlip)
				return
			end
		end
	end
end)
RegisterNetEvent('esx_outlawalert:atmrob')
AddEventHandler('esx_outlawalert:atmrob', function(targetCoords)
	if isPlayerWhitelisted then
		local alpha = 250
		local bankBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, Config.BlipWinkelRadius)
		pixelTimer = 5000
		pcoords = targetCoords 
		pixelMark = true
		SetBlipHighDetail(bankBlip, true)
		SetBlipColour(bankBlip, 1)
		SetBlipAlpha(bankBlip, alpha)
		SetBlipAsShortRange(bankBlip, true)

		while alpha ~= 0 do
			Citizen.Wait(Config.BlipWinkelTime * 4)
			alpha = alpha - 1
			SetBlipAlpha(bankBlip, alpha)

			if alpha == 0 then
				RemoveBlip(bankBlip)
				return
			end
		end
	end
end)
RegisterNetEvent('esx_outlawalert:atmrob2')
AddEventHandler('esx_outlawalert:atmrob2', function(targetCoords)
	if isPlayerWhitelisted then
		local alpha = 250
		local bankBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, Config.BlipWinkelRadius)
		pixelTimer = 5000
		pcoords = targetCoords 
		pixelMark = true
		SetBlipHighDetail(bankBlip, true)
		SetBlipColour(bankBlip, 1)
		SetBlipAlpha(bankBlip, alpha)
		SetBlipAsShortRange(bankBlip, true)

		while alpha ~= 0 do
			Citizen.Wait(Config.BlipWinkelTime * 4)
			alpha = alpha - 1
			SetBlipAlpha(bankBlip, alpha)

			if alpha == 0 then
				RemoveBlip(bankBlip)
				return
			end
		end
	end
end)
RegisterNetEvent('esx_outlawalert:combatInProgress')
AddEventHandler('esx_outlawalert:combatInProgress', function(targetCoords)
	if isPlayerWhitelisted and Config.MeleeAlert then
		local alpha = 250
		local meleeBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, Config.BlipMeleeRadius)
		pixelTimer = 5000
		pcoords = targetCoords 
		pixelMark = true

		SetBlipHighDetail(meleeBlip, true)
		SetBlipColour(meleeBlip, 17)
		SetBlipAlpha(meleeBlip, alpha)
		SetBlipAsShortRange(meleeBlip, true)

		while alpha ~= 0 do
			Citizen.Wait(Config.BlipMeleeTime * 4)
			alpha = alpha - 1
			SetBlipAlpha(meleeBlip, alpha)

			if alpha == 0 then
				RemoveBlip(meleeBlip)
				return
			end
		end
	end
end)

RegisterNetEvent('esx_outlawalert:stopAlertRoute')
AddEventHandler('esx_outlawalert:stopAlertRoute', function()
	ClearGpsMultiRoute()
	locationRoute = false
end)

Citizen.CreateThread(function()
	while true do
		if pixelMark ~= false then
			pixelTimer = pixelTimer - 5
			if IsControlJustPressed(0, 244) then
				print('Pressed')
				StartGpsMultiRoute(6, true, true)
				AddPointToGpsMultiRoute(pcoords.x, pcoords.y, pcoords.z)
				SetGpsMultiRouteRender(true)
				PlaySound(-1, "Menu_Accept", "Phone_SoundSet_Default", 0, 0, 1)
				locationRoute = true
				TriggerEvent('esx_outlawalert:checkDistance', locationRoute)
				pixelMark = false
				pixelTimer = 0
			end
			if(pixelTimer == 0) then 
				pixelMark = false
			end
		end
		Citizen.Wait(5)
	end
end)

RegisterNetEvent('esx_outlawalert:checkDistance')
AddEventHandler('esx_outlawalert:checkDistance', function(locationRoute)
	Citizen.CreateThread(function()
		while locationRoute do
			Citizen.Wait(1000)
			local playerCoords = GetEntityCoords(PlayerPedId())
			local distance = GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, pcoords.x, pcoords.y, pcoords.z, false)
			if distance < 60 then
				ClearGpsMultiRoute()
				locationRoute = false
				ESX.ShowNotification('Je hebt de ~g~bestemming~s~ bereikt')
			end
		end
	end)
end)

RegisterNetEvent('esx_outlawalert:winkeloverval')
AddEventHandler('esx_outlawalert:winkeloverval', function(targetCoords)
	if isPlayerWhitelisted then
		if Config.WinkelOvervalAlert then
			local alpha = 250
			local winkelBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, Config.BlipWinkelRadius)
			pixelTimer = 500 pcoords = targetCoords pixelMark = true
			SetBlipHighDetail(winkelBlip, true)
			SetBlipColour(winkelBlip, 1)
			SetBlipAlpha(winkelBlip, alpha)
			SetBlipAsShortRange(winkelBlip, true)

			while alpha ~= 0 do
				Citizen.Wait(Config.BlipWinkelTime * 4)
				alpha = alpha - 1
				SetBlipAlpha(winkelBlip, alpha)

				if alpha == 0 then
					RemoveBlip(winkelBlip)
					return
				end
			end

		end
	end
end)


RegisterNetEvent('esx_outlawalert:grotebankoverval')
AddEventHandler('esx_outlawalert:grotebankoverval', function(targetCoords)
	if isPlayerWhitelisted then
		if Config.WinkelOvervalAlert then
			local alpha = 250
			local bankBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, Config.BlipWinkelRadius)
			pixelTimer = 5000
			pcoords = targetCoords 
			pixelMark = true
			SetBlipHighDetail(bankBlip, true)
			SetBlipColour(bankBlip, 1)
			SetBlipAlpha(bankBlip, alpha)
			SetBlipAsShortRange(bankBlip, true)

			while alpha ~= 0 do
				Citizen.Wait(Config.BlipWinkelTime * 4)
				alpha = alpha - 1
				SetBlipAlpha(bankBlip, alpha)

				if alpha == 0 then
					RemoveBlip(bankBlip)
					return
				end
			end

		end
	end
end)


RegisterNetEvent('esx_outlawalert:noodknop')
AddEventHandler('esx_outlawalert:noodknop', function(targetCoords)
	if isPlayerWhitelisted then
		if Config.WinkelNoodknopAlert then
			local alpha = 250
			local winkelBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, Config.BlipNoodknopRadius)
			pixelTimer = 500 pcoords = targetCoords pixelMark = true
			SetBlipHighDetail(NoodknopBlip, true)
			SetBlipColour(NoodknopBlip, 1)
			SetBlipAlpha(NoodknopBlip, alpha)
			SetBlipAsShortRange(NoodknopBlip, true)

			while alpha ~= 0 do
				Citizen.Wait(Config.BlipNoodknopTime * 4)
				alpha = alpha - 1
				SetBlipAlpha(NoodknopBlip, alpha)

				if alpha == 0 then
					RemoveBlip(NoodknopBlip)
					return
				end
			end

		end
	end
end)

RegisterNetEvent('esx_outlawalert:woninginbraak')
AddEventHandler('esx_outlawalert:woninginbraak', function(targetCoords)
	if isPlayerWhitelisted then
		if Config.WoningInbraakAlert then
			local alpha = 250
			local woningBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, Config.BlipWoningRadius)
			pixelTimer = 500 pcoords = targetCoords pixelMark = true
			SetBlipHighDetail(woningBlip, true)
			SetBlipColour(woningBlip, 1)
			SetBlipAlpha(woningBlip, alpha)
			SetBlipAsShortRange(woningBlip, true)

			while alpha ~= 0 do
				Citizen.Wait(Config.BlipWoningTime * 4)
				alpha = alpha - 1
				SetBlipAlpha(woningBlip, alpha)

				if alpha == 0 then
					RemoveBlip(woningBlip)
					return
				end
			end

		end
	end
end)


RegisterCommand('removeblips', function(source, args, raw)
	RemoveBlip(woningBlip)
	RemoveBlip(NoodknopBlip)
	RemoveBlip(winkelBlip)
	StartGpsMultiRoute(6, false, false)
	SetGpsMultiRouteRender(false)
	RemoveBlip(meleeBlip)
	RemoveBlip(gunshotBlip)
	RemoveBlip(thiefBlip)
	
	RemoveBlip(bankBlip)
end, false)