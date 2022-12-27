--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX					= nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(500)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()

	-- Update the door list
	ESX.TriggerServerCallback('esx_doorlock:getDoorInfo', function(doorInfo, count)
		for localID = 1, count, 1 do
			if doorInfo[localID] ~= nil then
				Config.DoorList[doorInfo[localID].doorID].locked = doorInfo[localID].state
			end
		end
	end)
end)

RegisterNetEvent('esx:setjob')
AddEventHandler('esx:setjob', function(job)
	ESX.PlayerData.job = job
end)
local playerCoords = nil

Citizen.CreateThread(function()
	while true do 
		Wait(100)
		playerCoords = GetEntityCoords(GetPlayerPed(-1))
	end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if playerCoords ~= nil then
			local anywhereNear = false
			for i=1, #Config.DoorList do
				local doorID   = Config.DoorList[i]
				local distance = GetDistanceBetweenCoords(playerCoords, doorID.textCoords.x, doorID.textCoords.y, doorID.textCoords.z, true)

				local maxDistance = 1.25
				if doorID.distance then
					maxDistance = doorID.distance
				end
				if distance < 10 then
					anywhereNear = true
				end

				if distance < maxDistance then
					ApplyDoorState(doorID)

					local size = 1
					if doorID.size then
						size = doorID.size
					end
					local isAuthorized = IsAuthorized(doorID)
					--local isPers = IsAuthorizedRole(doorID)
					-- Sloten voor overheid/de goede role
					if isAuthorized then
						if doorID.locked then
							displayText = _U('press_button', displayText)
							if distance <= 1.5 then
								ESX.ShowHelpNotification('Druk op ~INPUT_CONTEXT~ om de deur te ~g~openen')
							end
						else 
							displayText = _U('press_buttonunl', displayText)
							if distance <= 1.5 then
								ESX.ShowHelpNotification('Druk op ~INPUT_CONTEXT~ om de deur op ~r~slot~s~ te zetten')
							end
						end
					-- Sloten voor Burgers/Uit dienst
					else
						if doorID.locked then
							displayText = _U('locked')
						else 
							displayText = _U('unlocked')
						end
					end
						
					ESX.Game.Utils.DrawText3D(doorID.textCoords, displayText, size)
					if IsControlJustReleased(0, Keys['E']) then
						if isAuthorized then
							ExecuteCommand('e keyfob')
							doorID.locked = not doorID.locked
							ApplyDoorState(doorID)
							TriggerServerEvent('esx_doorlock:updateState', i, doorID.locked)

						else 
							ESX.ShowNotification('Je hebt geen sleutels van deze deur')

							-- TriggerServerEvent('esx_doorlock:updateState', i, doorID.locked) -- Broadcast new state of the door to everyone
						end
					end
				end
			end
			if not anywhereNear then
				Wait(400)
			end
		end
	end
end)

function ApplyDoorState(doorID)
	local closeDoor = GetClosestObjectOfType(doorID.objCoords.x, doorID.objCoords.y, doorID.objCoords.z, 1.0, GetHashKey(doorID.objName), false, false, false)
	FreezeEntityPosition(closeDoor, doorID.locked)
end

function IsAuthorized(doorID)
	if ESX.PlayerData.job == nil then
		return false
	end

	for i=1, #doorID.authorizedJobs, 1 do
		if doorID.authorizedJobs[i] == ESX.PlayerData.job.name then
			return true
		end
	end

	return false
end

-- Set state for a door
RegisterNetEvent('esx_doorlock:setState')
AddEventHandler('esx_doorlock:setState', function(doorID, state)
	Config.DoorList[doorID].locked = state
end)

-- RegisterNetEvent('esx_doorlock:HasRole')
-- AddEventHandler('esx_doorlock:HasRole', function(heeftrol)
-- 	if heeftrol then
-- 		print('ja heeft rol')
-- 		JaHeeftPersRole = true
-- 	else
-- 		print('heeft geen rol')
-- 		JaHeeftPersRole = false
-- 	end
-- end)