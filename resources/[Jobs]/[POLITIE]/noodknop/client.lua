--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
ESX                           = nil
local PlayerData              = {}
Citizen.CreateThread(function()

	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
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

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
PlayerData.job = job
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustReleased(0, 56) and GetLastInputMethod( 0 ) and PlayerData.job ~= nil and (PlayerData.job.name == 'police' or PlayerData.job.name == 'kmar') then -- Ingesteld op F9
			local posx,posy,posz = table.unpack(GetEntityCoords(PlayerPedId(),false))
			TriggerServerEvent('Noodknop', posx,posy,posz)
			local message = "Noodsignaal Verstuurd!"
			TriggerEvent('esx:showNotification', message)
			TriggerServerEvent('noodknop:log')
		end
	end
	LastPressed = KeyId
end) 

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustReleased(0, 207) and GetLastInputMethod( 0 ) and PlayerData.job ~= nil and (PlayerData.job.name == 'police' or PlayerData.job.name == 'kmar') then -- Ingesteld op de PAGEDOWN toets
			local posx,posy,posz = table.unpack(GetEntityCoords(PlayerPedId(),false))
			TriggerServerEvent('NoodknopWeg', posx,posy,posz)
			local message = "Noodsignaal geaunnuleerd!"
			TriggerEvent('esx:showNotification', message)
			RemoveBlip(NoodknopBlip)
		end
	end
	LastPressed = KeyId
end) 

NoodknopBlip = nil
RegisterNetEvent('NoodknopC')
AddEventHandler('NoodknopC', function(x,y,z, name)
	if (PlayerData.job ~= nil and (PlayerData.job.name == 'police' or PlayerData.job.name == 'kmar') ) then
		if NoodknopBlip ~= nil then
			RemoveBlip(NoodknopBlip)
		end
		NoodknopBlip = AddBlipForCoord(x, y, z)
		SetBlipSprite(NoodknopBlip , 161)
		SetBlipScale(NoodknopBlip , 3.0)
		SetBlipColour(NoodknopBlip, 49)
		SetBlipRoute(NoodknopBlip, true)
		SetBlipRouteColour(NoodknopBlip, 49)
		SetBlipHighDetail(NoodknopBlip, true)
		TriggerServerEvent('InteractSound_SV:PlayOnOne', GetPlayerServerId(PlayerId()), "noodknop", 0.5)
		local streetName, crossing = GetStreetNameAtCoord(x, y, z)
		streetName = GetStreetNameFromHashKey(streetName)
		local message = ""
		if crossing ~= nil and crossing ~= "" then
			crossing = GetStreetNameFromHashKey(crossing)
			message = "~r~Noodsignaal op ~o~" .. streetName .. "~s~, met spoed eenheden ter plaatse!"
		else
			message = "~r~Noodsignaal op ~o~" .. streetName .. "~s~, met spoed eenheden ter plaatse!"
		end
		TriggerEvent('esx:showNotification', message)
		Citizen.CreateThread(function() 
			Citizen.Wait(160000*1)
			if NoodknopBlip ~= nil then
				RemoveBlip(NoodknopBlip)
			end
		end)
	end
end)

RegisterNetEvent('NoodknopWeg')
AddEventHandler('NoodknopWeg', function(x,y,z, name)
	if (PlayerData.job ~= nil and (PlayerData.job.name == 'police' or PlayerData.job.name == 'kmar') ) then
		local streetName, crossing = GetStreetNameAtCoord(x, y, z)
		streetName = GetStreetNameFromHashKey(streetName)
		local message = ""
		if crossing ~= nil and crossing ~= "" then
			crossing = GetStreetNameFromHashKey(crossing)
			message = "~g~Noodknop geaunnuleerd! Alle eenheden mogen afkoppelen"
		else
			message = "~g~Noodknop geaunnuleerd! Alle eenheden mogen afkoppelen"
		end
		TriggerEvent('esx:showNotification', message)
		RemoveBlip(NoodknopBlip)


	end
end)



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustReleased(0, 10) and GetLastInputMethod( 0 ) and PlayerData.job ~= nil and (PlayerData.job.name == 'police' or PlayerData.job.name == 'kmar') then -- Ingesteld op PageUp
			local posx,posy,posz = table.unpack(GetEntityCoords(PlayerPedId(),false))
			TriggerServerEvent('PolLocatie', posx,posy,posz)
			local message = "~b~Locatie Verstuurd!"
			TriggerEvent('esx:showNotification', message)
		end
	end
end) 


PolLocatieBlip = nil
RegisterNetEvent('PolLocatieC')
AddEventHandler('PolLocatieC', function(x,y,z, name)
	if (PlayerData.job ~= nil and (PlayerData.job.name == 'police' or PlayerData.job.name == 'kmar') ) then
		if PolLocatieBlip ~= nil then
			RemoveBlip(PolLocatieBlip)
		end
		PolLocatieBlip = AddBlipForCoord(x, y, z)

		SetBlipSprite(PolLocatieBlip , 148)
		SetBlipScale(PolLocatieBlip , 0.9)
		SetBlipColour(PolLocatieBlip, 3)
		--SetBlipRoute(PolLocatieBlip, true)
		--SetBlipRouteColour(PolLocatieBlip, 3)

		SetNewWaypoint(x, y)

		SetBlipHighDetail(PolLocatieBlip, true)



		local streetName, crossing = GetStreetNameAtCoord(x, y, z)
		streetName = GetStreetNameFromHashKey(streetName)
		local message = ""
		if crossing ~= nil and crossing ~= "" then
			crossing = GetStreetNameFromHashKey(crossing)
			message = "Locatie Verstuurd op ~b~" .. streetName .. ""
		else
			message = "Locatie verstuurt op ~b~" .. streetName .. ""
		end
		TriggerEvent('esx:showNotification', message)
		Citizen.CreateThread(function() 
			Citizen.Wait(30000*1)
			if PolLocatieBlip ~= nil then
				RemoveBlip(PolLocatieBlip)
			end
		end)
	end
end)

