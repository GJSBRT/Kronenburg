--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
--Skrypt By Ruski, Contact Information @Ruski#0001 on Discord, Made For PlanetaRP 

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

ESX               				= nil
local PlayerData                = {}
local PracaPolice 				= 'police'	-- Job needed to arrest

local Aresztuje					= false		-- Zostaw na False innaczej bedzie aresztowac na start Skryptu
local Aresztowany				= false		-- Zostaw na False innaczej bedziesz Arresztowany na start Skryptu
 
local SekcjaAnimacji			= 'mp_arrest_paired'	-- Sekcja Katalogu Animcji
local AnimAresztuje 			= 'cop_p2_back_left'	-- Animacja Aresztujacego
local AnimAresztowany			= 'crook_p2_back_left'	-- Animacja Aresztowanego
local AnimatieLoad			    = 'mp_arresting'	-- Animacja Aresztowanego
local Animatie2			        = 'a_uncuff'	-- Animacja Aresztowanego
local Animatie3			        = 'b_uncuff'	-- Animacja Aresztowanego
local OstatnioAresztowany		= 0						-- Mozna sie domyslec ;)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(7)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
	PlayerData.job2 = job2
end)

RegisterNetEvent('esx_ruski_areszt:aresztowany')
AddEventHandler('esx_ruski_areszt:aresztowany', function(target)
	Aresztowany = true

	local playerPed = GetPlayerPed(-1)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
	ped = GetPlayerPed(-1)

	RequestAnimDict(SekcjaAnimacji)

	while not HasAnimDictLoaded(SekcjaAnimacji) do
		Citizen.Wait(7)
	end

	AttachEntityToEntity(GetPlayerPed(-1), targetPed, 11816, -0.1, 0.45, 0.0, 0.0, 0.0, 20.0, false, false, false, false, 20, false)
	TaskPlayAnim(playerPed, SekcjaAnimacji, AnimAresztowany, 8.0, -8.0, 5500, 33, 0, false, false, false)
	
	if GetEntityModel(ped) == femaleHash then
            prevFemaleVariation = GetPedDrawableVariation(ped, 7)
            SetPedComponentVariation(ped, 7, 25, 0, 0)
        elseif GetEntityModel(ped) == maleHash then
            prevMaleVariation = GetPedDrawableVariation(ped, 7)
            SetPedComponentVariation(ped, 7, 41, 0, 0)

	Citizen.Wait(950)
	DetachEntity(GetPlayerPed(-1), true, false)

	Aresztowany = false
  end
end)

RegisterNetEvent('esx_ruski_areszt:aresztuj')
AddEventHandler('esx_ruski_areszt:aresztuj', function()
	local playerPed = GetPlayerPed(-1)

	RequestAnimDict(SekcjaAnimacji)

	while not HasAnimDictLoaded(SekcjaAnimacji) do
		Citizen.Wait(7)
	end

    isBusy = true

	TaskPlayAnim(playerPed, SekcjaAnimacji, AnimAresztuje, 8.0, -8.0, 5500, 33, 0, false, false, false)

	Citizen.Wait(3000)
	
	isBusy = false

	Aresztuje = false

end)

RegisterNetEvent('esx_ruski_areszt:stoparrest1')
AddEventHandler('esx_ruski_areszt:stoparrest1', function()
	local playerPed = GetPlayerPed(-1)

	RequestAnimDict(AnimatieLoad)

	while not HasAnimDictLoaded(AnimatieLoad) do
		Citizen.Wait(7)
	end

    isBusy = true

	TaskPlayAnim(playerPed, AnimatieLoad, Animatie2, 8.0, -8.0, 5500, 33, 0, false, false, false)

	Citizen.Wait(3000)
	
	isBusy = false

	Aresztuje = false

end)

RegisterNetEvent('esx_ruski_areszt:stoparrest2')
AddEventHandler('esx_ruski_areszt:stoparrest2', function(target, playerheading, playercoords, playerlocation)
	Aresztowany = true

	local playerPed = GetPlayerPed(-1)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
	ped = GetPlayerPed(-1)
	local target, distance = ESX.Game.GetClosestPlayer()
	playerheading = GetEntityHeading(GetPlayerPed(-1))
	playerlocation = GetEntityForwardVector(PlayerPedId())
	playercoords = GetEntityCoords(GetPlayerPed(-1))

	RequestAnimDict(AnimatieLoad)

	while not HasAnimDictLoaded(AnimatieLoad) do
		Citizen.Wait(7)
	end			
			
    local x, y, z   = table.unpack(playercoords + playerlocation * 1.0)
	SetEntityCoords(GetPlayerPed(-1), x, y, z)
	AttachEntityToEntity(GetPlayerPed(-1), targetPed, 11816, -0.1, 1.0, 0.0, 1.0, 0.0, 20.0, false, false, false, false, 20, false)
	DetachEntity(GetPlayerPed(-1), true, false)
	SetEntityHeading(GetPlayerPed(-1), playerheading)
	TaskPlayAnim(playerPed, AnimatieLoad, Animatie3, 8.0, -8.0, 5500, 33, 0, false, false, false)

	Citizen.Wait(950)

	Aresztowany = false
  end)