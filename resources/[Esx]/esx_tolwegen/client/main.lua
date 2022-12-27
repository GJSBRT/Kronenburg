--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
-- BELOVE IS YOUR SETTINGS, CHANGE THEM TO WHATEVER YOU'D LIKE & MORE SETTINGS WILL COME IN THE FUTURE! --

local useBilling = true -- OPTIONS: (true/false)
local useCameraSound = false -- OPTIONS: (true/false)
local useFlashingScreen = false -- OPTIONS: (true/false)
local useBlips = false -- OPTIONS: (true/false)
local alertPolice = false -- OPTIONS: (true/false)
local alertSpeed = 150 -- OPTIONS: (1-5000 KMH)
local speedCameras = {}
local westpost = vector3(2079.7407, 2635.7231, 52.2172)
local oostpost = vector3(-2673.5552, 2530.2639, 19.4452)


-- ABOVE IS YOUR SETTINGS, CHANGE THEM TO WHATEVER YOU'D LIKE & MORE SETTINGS WILL COME IN THE FUTURE!  --

ESX = nil
local PlayerData = {}

local hasBeenCaught = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	PlayerData = ESX.GetPlayerData()
	refreshBlips()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job

	refreshBlips()
end)



function hintToDisplay(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

-- BLIP FOR SPEEDCAMERA (START)

local messages = {

}

local name = "Flitspaal"

local blips = {
	{ colour=1, id=1, pos= vector3(2079.7407, 2635.7231, 52.2172), h= 210.0, speed = 80 },
	{ colour=1, id=1, pos= vector3(-2673.5552, 2530.2639, 19.4452), h= 210.0, speed = 80 },
}

AddTextEntry('_SPEED_CAMERA', name)
function refreshBlips()
	for _, info in pairs(blips) do
		if info.blip ~= nil then
			RemoveBlip(info.blip)
			info.blip = nil
		end

		if PlayerData.job.name == 'police' or useBlips then
			info.blip = AddBlipForCoord(info.pos.x, info.pos.y, info.pos.z)
			SetBlipSprite(info.blip, info.id)
			SetBlipDisplay(info.blip, 4)
			SetBlipScale(info.blip, 0.5)
			SetBlipColour(info.blip, info.colour)
			SetBlipAsShortRange(info.blip, true)
			BeginTextCommandSetBlipName("_SPEED_CAMERA")
			--AddTextComponentString(name)
			EndTextCommandSetBlipName(info.blip)
		end
	end
end


-- BLIP FOR SPEEDCAMERA (END)

-- ALL ZONES (START)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local minDistance = 10000
		local playerPed = PlayerPedId()
		local plyCoords = GetEntityCoords(playerPed, false)

		for i=1, #blips do
			local v = blips[i]
			local dist = #(plyCoords - v.pos)
			if dist < minDistance then
				minDistance = dist
			end

			if dist <= (v.radius or 20.0) then
				local vehicle = GetVehiclePedIsIn(playerPed)
				local SpeedKM = (GetEntitySpeed(playerPed)*4.0) - 4
				local maxSpeed = v.speed



				if DoesEntityExist(vehicle) then
					if (GetPedInVehicleSeat(vehicle, -1) == playerPed) then
						if hasBeenCaught == false then
							local coords = GetEntityCoords(PlayerPedId())
							if #(coords - oostpost) > 150 then
								place = 'oost'
							end
							if #(coords - westpost) > 150 then
								place = 'west'
							end

							local plate = GetVehicleNumberPlateText(vehicle)
							local price = ((SpeedKM - maxSpeed) ^ 1.40) * 0.2
							TriggerServerEvent('esx_speedcamera:BetaalTol')
							TriggerServerEvent('esx_speedcamera:ControleerVoertuig', plate, place)
							hasBeenCaught = true
							Citizen.Wait(120000)
						end
					end
				end
				hasBeenCaught = false
			end
		end
		if minDistance > 150 then
			local multiplier = 10 - (GetEntitySpeed(PlayerPedId())^0.5)

			Citizen.Wait(math.floor(math.clamp(multiplier * minDistance, 50, 2000)))
		end
	end
end)


local function RemoveSpeedCameras()
	for i=1, #blips do
		if blips[i].object then
			DeleteObject(blips[i].object)
		end
	end
end

AddEventHandler('onResourceStop', function(resourceName)
	if resourceName == GetCurrentResourceName() then
		RemoveSpeedCameras()
	end
end)


RegisterNetEvent('esx_speedcamera:addkenteken')
AddEventHandler('esx_speedcamera:addkenteken', function()
	OpenAddKentekenMenu()
end)

function OpenAddKentekenMenu()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Kenteken', {
		title = ('Gezocht Kenteken')
	}, function(data, menu)
		local kenteken = data.value

		if kenteken ~= nil then
			ESX.TriggerServerCallback('esx_speedcamera:GetKenteken', function(kentiegevonden)
				if kentiegevonden then
					menu.close()
					TriggerServerEvent('esx_speedcamera:addkentekenserver', kenteken)
					ESX.ShowNotification('Kenteken ~b~'..kenteken..'~w~ word nu gezocht.')
				else
					ESX.ShowNotification('Dit kenteken word al gezocht.')
				end
			end, kenteken)
		else
			ESX.ShowNotification('Kenteken is ongeldig')
		end
	end, function(data, menu)
		menu.close()
	end)
end


RegisterNetEvent('esx_speedcamera:Removekenteken')
AddEventHandler('esx_speedcamera:Removekenteken', function()
	OpenRemoveKentekenMenu()
end)

function OpenRemoveKentekenMenu()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Kenteken', {
		title = ('Kenteken Verwijderen')
	}, function(data, menu)
		local kenteken = data.value

		if kenteken == nil then
			ESX.ShowNotification('Kenteken is ongeldig.')
		else
			ESX.TriggerServerCallback('esx_speedcamera:GetKenteken', function(kentiegevonden)
				if not kentiegevonden then
					menu.close()
					TriggerServerEvent('esx_speedcamera:Removekentekenserver', kenteken)
					ESX.ShowNotification('Kenteken ~b~'..kenteken..'~w~ word nu ~r~niet~w~ meer gezocht.')
				else
					ESX.ShowNotification('Dit kenteken word niet gezocht.')
				end
			end, kenteken)
		end
	end, function(data, menu)
		menu.close()
	end)
end

RegisterNetEvent('esx_speedcamera:setcopnotification')
AddEventHandler('esx_speedcamera:setcopnotification', function(tekst)
	ESX.ShowNotification(tekst)
end)
