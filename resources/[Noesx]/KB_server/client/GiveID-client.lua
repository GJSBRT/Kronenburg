ESX = nil

Citizen.CreateThread(function()
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	while ESX == nil do
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx_giveid:GiveIdResponse')
AddEventHandler('esx_giveid:GiveIdResponse', function(response)
	if response then 
		ESX.ShowNotification("You have given your ID to ~y~" .. response)
	else
		ESX.ShowNotification("~r~Error no ID found")
	end
end)

RegisterNetEvent('esx_giveid:DisplayPlayerId')
AddEventHandler('esx_giveid:DisplayPlayerId', function(playerInfoString, playerId)
	if playerInfoString and playerId then 
		showIdNotification(playerInfoString, playerId)
	else
		ESX.ShowNotification("~r~Error no ID found")
	end
end)

function showIdNotification(msg, playerServerId)
	local mugshot, mugshotStr = ESX.Game.GetPedMugshot(GetPlayerPed(GetPlayerFromServerId(playerServerId)))
	-- ESX.ShowAdvancedNotification('Driver', 'Identification', msg, mugshotStr, 1)
	DrawCTRPNotification('Driver', 'Identification', msg, mugshotStr, 1)
	UnregisterPedheadshot(mugshot)
end

function playAnim(animDict, animName, duration)
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do Citizen.Wait(0) end
	TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
	RemoveAnimDict(animDict)
end

function GetClosestPedNotInVehicle(coords)
	local ignoreList = ignoreList or {}
	local peds = ESX.Game.GetPeds(ignoreList)
	local closestDistance = -1
	local closestPed= -1

	for i=1, #peds, 1 do
		local pedCoords = GetEntityCoords(peds[i])
		local distance  = GetDistanceBetweenCoords(pedCoords.x, pedCoords.y, pedCoords.z, coords.x, coords.y, coords.z, true)
		
		if GetPlayerServerId(NetworkGetPlayerIndexFromPed(peds[i])) ~= 0 then
			if not IsPedInAnyVehicle(peds[i], true) then
				if peds[i] ~= GetPlayerPed(-1) then
					if closestDistance == -1 or closestDistance > distance then
						closestPed = peds[i]
						closestDistance = distance
					end
				end
			end
		end
	end
	return closestPed, closestDistance
end

Citizen.CreateThread(function()
	TriggerEvent('chat:addSuggestion', '/giveid', "Gives your ID to the closest player." )
end)

RegisterCommand("giveid", function(source,args)
	local playerCoords = GetEntityCoords(GetPlayerPed(-1))
	local closestPed, closestDistance = GetClosestPedNotInVehicle(playerCoords)
	local targetCoords = GetEntityCoords(closestPed)
	if GetDistanceBetweenCoords(playerCoords, targetCoords, true) < 2.0 then
		local targetPlayerId = GetPlayerServerId(NetworkGetPlayerIndexFromPed(closestPed))
		if IsPedInAnyVehicle(GetPlayerPed(-1), true) then
			playAnim('veh@busted_std', 'issue_ticket_crim', 7500)
			Citizen.Wait(7500)
			TriggerServerEvent("esx_giveid:GiveIdToPlayer", targetPlayerId)
		else
			playAnim('mp_common', 'givetake1_a', 2500)
			Citizen.Wait(2500)
			TriggerServerEvent("esx_giveid:GiveIdToPlayer", targetPlayerId)
		end
	else
		ESX.ShowNotification("No player found nearby")
	end
end, false)

function DrawCTRPNotification(title, subject, msg, icon, iconType)
	SetNotificationBackgroundColor(130)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(msg)
	SetNotificationMessage(icon, icon, false, iconType, title, subject)
	DrawNotification(false, false)
end

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('chat:removeSuggestion', '/giveid')
	end
end)