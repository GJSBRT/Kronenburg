﻿--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
ESX = nil
Citizen.CreateThread(function()
	while true do
		Wait(5)
		if ESX ~= nil then
		
		else
			ESX = nil
			TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		end
	end

	ESX.TriggerServerCallback('fishing:server:getVerifyToken', function(token, eventname)
		verifyToken = token
		RegisterNetEvent(eventname)
		AddEventHandler(eventname, function(token)
			verifyToken = token
		end)
	end)
end)

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

local fishing = false
local lastInput = 0
local pause = false
local pausetimer = 0
local correct = 0

local bait = "none"

local blip = AddBlipForCoord(Config.SellFish.x, Config.SellFish.y, Config.SellFish.z)

			SetBlipSprite (blip, 356)
			SetBlipDisplay(blip, 4)
			SetBlipScale  (blip, 1.1)
			SetBlipColour (blip, 17)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Vis Verkoop")
			EndTextCommandSetBlipName(blip)
			
local blip2 = AddBlipForCoord(Config.SellTurtle.x, Config.SellTurtle.y, Config.SellTurtle.z)

			SetBlipSprite (blip2, 68)
			SetBlipDisplay(blip2, 4)
			SetBlipScale  (blip2, 0.9)
			SetBlipColour (blip2, 49)
			SetBlipAsShortRange(blip2, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Schildpad Dealer")
			EndTextCommandSetBlipName(blip2)
			
local blip3 = AddBlipForCoord(Config.SellShark.x, Config.SellShark.y, Config.SellShark.z)

			SetBlipSprite (blip3, 68)
			SetBlipDisplay(blip3, 4)
			SetBlipScale  (blip3, 0.9)
			SetBlipColour (blip3, 49)
			SetBlipAsShortRange(blip3, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Haaien vlees dealer")
			EndTextCommandSetBlipName(blip3)
			
for _, info in pairs(Config.MarkerZones) do
		info.blip = AddBlipForCoord(info.x, info.y, info.z)
		SetBlipSprite(info.blip, 455)
		SetBlipDisplay(info.blip, 4)
		SetBlipScale(info.blip, 1.0)
		SetBlipColour(info.blip, 20)
		SetBlipAsShortRange(info.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Boot Verhuur")
		EndTextCommandSetBlipName(info.blip)
	end
	
--Citizen.CreateThread(function()
--    while true do
--        Citizen.Wait(0)
--        for k in pairs(Config.MarkerZones) do
		
--            DrawMarker(1, Config.MarkerZones[k].x, Config.MarkerZones[k].y, Config.MarkerZones[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.0, 3.0, 1.0, 0, 150, 150, 100, 0, 0, 0, 0)	
--		end
 --   end
--end)
			
function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
Citizen.CreateThread(function()
while true do
	Wait(600)
		if pause and fishing then
			pausetimer = pausetimer + 1
		end
end
end)
Citizen.CreateThread(function()
	while true do
		Wait(5)
		if fishing then
			if IsControlJustReleased(0, Keys['1']) then
				 input = 1
			end
			if IsControlJustReleased(0, Keys['2']) then
				input = 2
			end
			if IsControlJustReleased(0, Keys['3']) then
				input = 3
			end
			if IsControlJustReleased(0, Keys['4']) then
				input = 4
			end
			if IsControlJustReleased(0, Keys['5']) then
				input = 5
			end
			if IsControlJustReleased(0, Keys['6']) then
				input = 6
			end
			if IsControlJustReleased(0, Keys['7']) then
				input = 7
			end

			
			
			if IsControlJustReleased(0, Keys['X']) then
				fishing = false
				ESX.ShowNotification("~r~Stopt met vissen")
			end
			if fishing then
			
				playerPed = GetPlayerPed(-1)
				local pos = GetEntityCoords(GetPlayerPed(-1))
				if pos.y >= 7700 or pos.y <= -4000 or pos.x <= -3700 or pos.x >= 4300 or IsPedInAnyVehicle(GetPlayerPed(-1)) then
					
				else
					fishing = false
					ESX.ShowNotification("~r~Stopt met vissen")
				end
				if IsEntityDead(playerPed) or IsEntityInWater(playerPed) then
					ESX.ShowNotification("~r~Stopt met vissen")
				end
			end
			
			
			
			if pausetimer > 3 then
				input = 99
			end
			
			if pause and input ~= 0 then
				pause = false
				if input == correct then
					TriggerServerEvent('fishing:catch', bait)
				else
					ESX.ShowNotification("~r~Vis is vrijgekomen")
				end
			end
		end

		
		
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Config.SellFish.x, Config.SellFish.y, Config.SellFish.z, true) <= 3 then
			TriggerServerEvent('fishing:startSelling', "fish")
			Citizen.Wait(4000)
		end
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Config.SellShark.x, Config.SellShark.y, Config.SellShark.z, true) <= 3 then
			TriggerServerEvent('fishing:startSelling', "shark")
			Citizen.Wait(4000)
		end
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Config.SellTurtle.x, Config.SellTurtle.y, Config.SellTurtle.z, true) <= 3 then
			TriggerServerEvent('fishing:startSelling', "turtle")
			Citizen.Wait(4000)
		end
		
	end
end)


				
Citizen.CreateThread(function()
	while true do
		Wait(1)
		
		DrawMarker(1, Config.SellFish.x, Config.SellFish.y, Config.SellFish.z , 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0, 2.0, 0, 70, 250, 30, false, true, 2, false, false, false, false)
		DrawMarker(1, Config.SellTurtle.x, Config.SellTurtle.y, Config.SellTurtle.z , 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0, 2.0, 0, 70, 250, 30, false, true, 2, false, false, false, false)
		DrawMarker(1, Config.SellShark.x, Config.SellShark.y, Config.SellShark.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0, 2.0, 0, 70, 250, 30, false, true, 2, false, false, false, false)
	end
end)

Citizen.CreateThread(function()
	while true do
		local wait = math.random(Config.FishTime.a , Config.FishTime.b)
		Wait(wait)
			if fishing then
				pause = true
				correct = math.random(5,7)
				ESX.ShowNotification("~g~Vis pakt het aas \n ~h~Druk " .. correct .. " om te vangen.")
				input = 0
				pausetimer = 0
			end
			
	end
end)

RegisterNetEvent('fishing:message')
AddEventHandler('fishing:message', function(message)
	ESX.ShowNotification(message)
end)
RegisterNetEvent('fishing:break')
AddEventHandler('fishing:break', function()
	fishing = false
	ClearPedTasks(GetPlayerPed(-1))
end)

RegisterNetEvent('fishing:spawnPed')
AddEventHandler('fishing:spawnPed', function()
	
	RequestModel( GetHashKey( "A_C_SharkTiger" ) )
		while ( not HasModelLoaded( GetHashKey( "A_C_SharkTiger" ) ) ) do
			Citizen.Wait( 1 )
		end
	local pos = GetEntityCoords(GetPlayerPed(-1))
	
	local ped = CreatePed(29, 0x06C3F072, pos.x, pos.y, pos.z, 90.0, true, false)
	SetEntityHealth(ped, 0)
end)

RegisterNetEvent('fishing:setbait')
AddEventHandler('fishing:setbait', function(bool)
	bait = bool
	print(bait)
end)

RegisterNetEvent('fishing:fishstart')
AddEventHandler('fishing:fishstart', function()
	
	
	
	playerPed = GetPlayerPed(-1)
	local pos = GetEntityCoords(GetPlayerPed(-1))
	print('started fishing' .. pos)
	if IsPedInAnyVehicle(playerPed) then
		ESX.ShowNotification("~y~Je kan geen vis vangen vanuit het voertuig")
	else
		if pos.y >= 7700 or pos.y <= -4000 or pos.x <= -3700 or pos.x >= 4300 then
			ESX.ShowNotification("~g~Fishing started")
			TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_STAND_FISHING", 0, true)
			fishing = true
		else
			ESX.ShowNotification("~y~Je moet verder van de kust.")
		end
	end
	
end, false)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
	
        for k in pairs(Config.MarkerZones) do
        	local ped = PlayerPedId()
            local pedcoords = GetEntityCoords(ped, false)
            local distance = Vdist(pedcoords.x, pedcoords.y, pedcoords.z, Config.MarkerZones[k].x, Config.MarkerZones[k].y, Config.MarkerZones[k].z)
            if distance <= 1.40 then

					DisplayHelpText('Druk op E om een boot te')
					
					if IsControlJustPressed(0, Keys['E']) and IsPedOnFoot(ped) then
						OpenBoatsMenu(Config.MarkerZones[k].xs, Config.MarkerZones[k].ys, Config.MarkerZones[k].zs)
					end 
			elseif distance < 1.45 then
				ESX.UI.Menu.CloseAll()
            end
        end
    end
end)

function OpenBoatsMenu(x, y , z)
	local ped = PlayerPedId()
	PlayerData = ESX.GetPlayerData()
	local elements = {}
	
	
		table.insert(elements, {label = '<span style="color:white;">Dinghy</span> <span style="color:yellow;">€2500</span>', value = 'boat'})
		table.insert(elements, {label = '<span style="color:white;">Suntrap</span> <span style="color:yellow;">€3500</span>', value = 'boat6'}) 
		table.insert(elements, {label = '<span style="color:white;">Jetmax</span> <span style="color:yellow;">€4500</span>', value = 'boat5'}) 	
		table.insert(elements, {label = '<span style="color:white;">Toro</span> <span style="color:yellow;">€5500</span>', value = 'boat2'}) 
		table.insert(elements, {label = '<span style="color:white;">Marquis</span> <span style="color:yellow;">€6000</span>', value = 'boat3'}) 
		table.insert(elements, {label = '<span style="color:white;">Tug boat</span> <span style="color:yellow;">€7500</span>', value = 'boat4'})
		
	--If user has police job they will be able to get free Police Predator boat
	if PlayerData.job.name == "police" then
		table.insert(elements, {label = '<span style="color:white;">Police Predator</span>', value = 'police'})
	end
	
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'client',
    {
		title    = 'Rent a boat',
		align    = 'bottom-right',
		elements = elements,
    },
	
	
	function(data, menu)

	if data.current.value == 'boat' then
		ESX.UI.Menu.CloseAll()

		TriggerServerEvent("fishing:lowmoney", 2500) 
		TriggerEvent("chatMessage", 'Je hebt een boot gehuurd voor', {255,0,255}, '€' .. 2500)
		SetPedCoordsKeepVehicle(ped, x, y , z)
		TriggerEvent('esx:spawnVehicle', "dinghy4")
	end
	
	if data.current.value == 'boat2' then
		ESX.UI.Menu.CloseAll()

		TriggerServerEvent("fishing:lowmoney", 5500) 
		TriggerEvent("chatMessage", 'Je hebt een boot gehuurd voor', {255,0,255}, '€' .. 5500)
		SetPedCoordsKeepVehicle(ped, x, y , z)
		TriggerEvent('esx:spawnVehicle', "TORO")
	end
	
	if data.current.value == 'boat3' then
		ESX.UI.Menu.CloseAll()

		TriggerServerEvent("fishing:lowmoney", 6000) 
		TriggerEvent("chatMessage", 'Je hebt een boot gehuurd voor', {255,0,255}, '€' .. 6000)
		SetPedCoordsKeepVehicle(ped, x, y , z)
		TriggerEvent('esx:spawnVehicle', "MARQUIS")
	end

	if data.current.value == 'boat4' then
		ESX.UI.Menu.CloseAll()

		TriggerServerEvent("fishing:lowmoney", 7500) 
		TriggerEvent("chatMessage", 'Je hebt een boot gehuurd voor', {255,0,255}, '€' .. 7500)
		SetPedCoordsKeepVehicle(ped, x, y , z)
		TriggerEvent('esx:spawnVehicle', "tug")
	end
	
	if data.current.value == 'boat5' then
		ESX.UI.Menu.CloseAll()

		TriggerServerEvent("fishing:lowmoney", 4500) 
		TriggerEvent("chatMessage", 'Je hebt een boot gehuurd voor', {255,0,255}, '€' .. 4500)
		SetPedCoordsKeepVehicle(ped, x, y , z)
		TriggerEvent('esx:spawnVehicle', "jetmax")
	end
	
	if data.current.value == 'boat6' then
		ESX.UI.Menu.CloseAll()

		TriggerServerEvent("fishing:lowmoney", 3500) 
		TriggerEvent("chatMessage", 'Je hebt een boot gehuurd voor', {255,0,255}, '€' .. 3500)
		SetPedCoordsKeepVehicle(ped, x, y , z)
		TriggerEvent('esx:spawnVehicle', "suntrap")
	end
	
	
	if data.current.value == 'police' then
		ESX.UI.Menu.CloseAll()

		TriggerEvent("chatMessage", 'Je hebt de boot eruit gehaald.')
		SetPedCoordsKeepVehicle(ped, x, y , z)
		TriggerEvent('esx:spawnVehicle', "predator")
	end
	ESX.UI.Menu.CloseAll()
	

    end,
	function(data, menu)
		menu.close()
		end
	)
end
