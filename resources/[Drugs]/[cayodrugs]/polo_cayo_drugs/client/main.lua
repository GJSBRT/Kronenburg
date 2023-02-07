-- polo � License | Discord : https://discord.gg/czW6Jqj
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

local PlayerData                = {}
local GUI                       = {}
local HasAlreadyEnteredMarker   = false
local LastZone                  = nil
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}
ESX                             = nil
GUI.Time                        = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)



AddEventHandler('polo_cayo_drugs:hasEnteredMarker', function(zone)
	if zone == 'Cannabis' then
		CurrentAction     = 'Cannabis_recolte'
		CurrentActionMsg  = 'Hasj ~g~oogsten'
		CurrentActionData = {zone= zone}
	end

	if zone == 'Cannabis' then
		CurrentAction     = 'Cannabis_recolte'
		CurrentActionMsg  = 'Hasj ~g~oogsten'
		CurrentActionData = {zone= zone}
	end

	if zone == 'Cannabis2'  then
		CurrentAction     = 'Cannabis_recolte'
		CurrentActionMsg  = 'Hasj ~g~oogsten'
		CurrentActionData = {zone= zone}
	end

	if zone == 'Cannabis3'  then
		CurrentAction     = 'Cannabis_recolte'
		CurrentActionMsg  = 'Hasj ~g~oogsten'
		CurrentActionData = {zone= zone}
	end

	if zone == 'Cannabis4'  then
		CurrentAction     = 'Cannabis_recolte'
		CurrentActionMsg  = 'Hasj ~g~oogsten'
		CurrentActionData = {zone= zone}
	end

	if zone == 'Cannabis5'  then
		CurrentAction     = 'Cannabis_recolte'
		CurrentActionMsg  = 'Hasj ~g~oogsten'
		CurrentActionData = {zone= zone}
	end

	if zone == 'Cannabis6'  then
		CurrentAction     = 'Cannabis_recolte'
		CurrentActionMsg  = 'Hasj ~g~oogsten'
		CurrentActionData = {zone= zone}
	end

	if zone == 'Cannabis7'  then
		CurrentAction     = 'Cannabis_recolte'
		CurrentActionMsg  = 'Hasj ~g~oogsten'
		CurrentActionData = {zone= zone}
	end

	if zone == 'Cannabis8'  then
		CurrentAction     = 'Cannabis_recolte'
		CurrentActionMsg  = 'Hasj ~b~oogsten'
		CurrentActionData = {zone= zone}
	end

	if zone == 'Cannabis9'  then
		CurrentAction     = 'Cannabis_recolte'
		CurrentActionMsg  = 'Hasj ~b~oogsten'
		CurrentActionData = {zone= zone}
	end

	if zone == 'Cannabis10'  then
		CurrentAction     = 'Cannabis_traitement'
		CurrentActionMsg  = 'Verwerken ~b~Hasj'
		CurrentActionData = {zone= zone}
	end

	if zone == 'Cannabis11'  then
		CurrentAction     = 'Cannabis_traitement'
		CurrentActionMsg  = 'Verwerken ~b~Hasj'
		CurrentActionData = {zone= zone}
	end

	if zone == 'Cannabis12'  then
		CurrentAction     = 'Cannabis_traitement'
		CurrentActionMsg  = 'Verwerken ~b~Hasj'
		CurrentActionData = {zone= zone}
	end

	if zone == 'Solvants'  then
		CurrentAction     = 'Solvants_recolte'
		CurrentActionMsg  = 'MDMA ~b~verzamelen'
		CurrentActionData = {zone= zone}
	end

	if zone == 'Solvants2'  then
		CurrentAction     = 'Solvants_recolte'
		CurrentActionMsg  = 'MDMA ~b~verzamelen'
		CurrentActionData = {zone= zone}
	end

	if zone == 'Solvants3'  then
		CurrentAction     = 'Solvants_recolte'
		CurrentActionMsg  = 'MDMA ~b~verzamelen'
		CurrentActionData = {zone= zone}
	end

	if zone == 'Solvants4'  then
		CurrentAction     = 'Solvants_traitement'
		CurrentActionMsg  = 'Verwerken ~b~MDMA'
		CurrentActionData = {zone= zone}
	end

	if zone == 'Solvants5'  then
		CurrentAction     = 'Solvants_traitement'
		CurrentActionMsg  = 'Verwerken ~b~MDMA'
		CurrentActionData = {zone= zone}
	end

	if zone == 'Cocaine'  then
		CurrentAction     = 'Cocaine_recolte'
		CurrentActionMsg  = 'Verzamel ~r~Opium'
		CurrentActionData = {zone= zone}
	end

	if zone == 'Cocaine2'  then
		CurrentAction     = 'Cocaine_recolte'
		CurrentActionMsg  = 'Verzamel ~r~Opium'
		CurrentActionData = {zone= zone}
	end

	if zone == 'Cocaine3'  then
		CurrentAction     = 'Cocaine_traitement'
		CurrentActionMsg  = 'Verwerk ~r~Opium'
		CurrentActionData = {zone= zone}
	end
	
end)

AddEventHandler('polo_cayo_drugs:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do

		Wait(0)

			local coords      = GetEntityCoords(GetPlayerPed(-1))
			local coords2      = GetEntityCoords(GetPlayerPed(-1))
			local coords3      = GetEntityCoords(GetPlayerPed(-1))
			local isInMarker  = false
			local currentZone = nil

			for k,v in pairs(Config.Cannabis) do
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
					isInMarker  = true
					currentZone = k
				end
			end

			for k,v in pairs(Config.Solvants) do
				if(GetDistanceBetweenCoords(coords2, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
					isInMarker  = true
					currentZone = k
				end
			end

			for k,v in pairs(Config.Cocaine) do
				if(GetDistanceBetweenCoords(coords3, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
					isInMarker  = true
					currentZone = k
				end
			end

			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker = true
				LastZone                = currentZone
				TriggerEvent('polo_cayo_drugs:hasEnteredMarker', currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('polo_cayo_drugs:hasExitedMarker', LastZone)
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(0)

		if CurrentAction ~= nil then

			SetTextComponentFormat('STRING')
			AddTextComponentString(CurrentActionMsg)
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)

			if IsControlPressed(0,  Keys['E']) and (GetGameTimer() - GUI.Time) > 300 then
				if CurrentAction == 'Cannabis_recolte' then
					TriggerServerEvent('drugs1:animation' , source) -- Play animation
					TriggerServerEvent('polo_cayo_drugs:startHarvest30', CurrentActionData.zone) -- Cannabis
					Citizen.Wait(15000)
				end
				if CurrentAction == 'Cannabis_traitement' then
					TriggerServerEvent('drugs2:animation2' , source) -- Play animation 
					TriggerServerEvent('polo_cayo_drugs:startHarvest31', CurrentActionData.zone) -- Cannabis
					Citizen.Wait(15000)
				end

				if CurrentAction == 'Solvants_recolte' then
					TriggerServerEvent('drugs1:animation' , source) -- Play animation
					TriggerServerEvent('polo_cayo_drugs:startHarvest32', CurrentActionData.zone) -- Cannabis
					Citizen.Wait(15000)
				end
				if CurrentAction == 'Solvants_traitement' then
					TriggerServerEvent('drugs2:animation2' , source) -- Play animation 
					TriggerServerEvent('polo_cayo_drugs:startHarvest33', CurrentActionData.zone) -- Cannabis
					Citizen.Wait(15000)
				end

				if CurrentAction == 'Cocaine_recolte' then
					TriggerServerEvent('drugs1:animation' , source) -- Play animation
					TriggerServerEvent('polo_cayo_drugs:startHarvest34', CurrentActionData.zone) -- Cannabis
					Citizen.Wait(15000)
				end
				if CurrentAction == 'Cocaine_traitement' then
					TriggerServerEvent('drugs2:animation2' , source) -- Play animation 
					TriggerServerEvent('polo_cayo_drugs:startHarvest35', CurrentActionData.zone) -- Cannabis
					Citizen.Wait(15000)
				end
end
end
end
end)

RegisterNetEvent('drug1:animation')
AddEventHandler('drug1:animation', function()
	TaskStartScenarioInPlace(PlayerPedId(), "world_human_gardener_plant", 0, true) -- Animaton 
	Citizen.Wait(10000) -- Time progress , in ms, 1 second = 1000 ms , the value is 10000 so , its 10 seconds
	ClearPedTasksImmediately(PlayerPedId()) -- Function to stop the animation
end)

RegisterNetEvent('drugs2:animation2')
AddEventHandler('drugs2:animation2', function()
	TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true) -- Animaton 
	Citizen.Wait(10000) -- Time progress , in ms, 1 second = 1000 ms , the value is 10000 so , its 10 seconds
	ClearPedTasksImmediately(PlayerPedId()) -- Function to stop the animation
end)

RegisterNetEvent('opium3:animation3')
AddEventHandler('opium3:animation3', function()
	TaskStartScenarioInPlace(PlayerPedId(), "CODE_HUMAN_MEDIC_TEND_TO_DEAD", 0, true) -- Animaton 
	Citizen.Wait(10000) -- Time progress , in ms, 1 second = 1000 ms , the value is 10000 so , its 10 seconds
	ClearPedTasksImmediately(PlayerPedId()) -- Function to stop the animation
end)

RegisterNetEvent('meth4:animation4')
AddEventHandler('meth4:animation4', function()
	TaskStartScenarioInPlace(PlayerPedId(), "world_human_stand_fire", 0, true) -- Animaton 
	Citizen.Wait(10000) -- Time progress , in ms, 1 second = 1000 ms , the value is 10000 so , its 10 seconds
	ClearPedTasksImmediately(PlayerPedId()) -- Function to stop the animation
end)

RegisterNetEvent('none:none')
AddEventHandler('none:none', function()
	TaskStartScenarioInPlace(PlayerPedId(), "none", 0, true) -- Animaton 
	Citizen.Wait(10000) -- Time progress , in ms, 1 second = 1000 ms , the value is 10000 so , its 10 seconds
	ClearPedTasksImmediately(PlayerPedId()) -- Function to stop the animation
end)