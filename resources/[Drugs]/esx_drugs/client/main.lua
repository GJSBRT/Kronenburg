--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
Keys = {
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

ESX = nil
local menuOpen = false
local wasOpen = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

--[[Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, Config.CircleZones.DrugDealer.coords, true) < 1.50 then
			if not menuOpen then
				ESX.ShowHelpNotification(_U('dealer_prompt'))

				if IsControlJustReleased(0, Keys['E']) then
					wasOpen = true
					OpenDrugShop()
				end
			else
				Citizen.Wait(0)
			end
			else
			if wasOpen then
				wasOpen = false
				ESX.UI.Menu.CloseAll()
			end
			Citizen.Wait(0)
		end
	end
end)]]

function OpenDrugShop()
	ESX.UI.Menu.CloseAll()
	local elements = {}
	menuOpen = true

	for k, v in pairs(ESX.GetPlayerData().inventory) do
		local price = Config.DrugDealerItems[v.name]

		if price and v.count > 0 then
			table.insert(elements, {
				label = ('%s - <span style="color:green;">%s</span>'):format(v.label, _U('dealer_item', ESX.Math.GroupDigits(price))),
				name = v.name,
				price = price,

				-- menu properties
				type = 'slider',
				value = v.count,
				min = 1,
				max = v.count
			})
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'drug_shop', {
		title    = _U('dealer_title'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		TriggerServerEvent('esx_illegal:sellDrug', data.current.name, data.current.value)
	end, function(data, menu)
		menu.close()
		menuOpen = false
	end)
end

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		if menuOpen then
			ESX.UI.Menu.CloseAll()
		end
	end
end)

function OpenBuyLicenseMenu(licenseName)
	menuOpen = true
	local license = Config.LicensePrices[licenseName]

	local elements = {
		{
			label = _U('license_no'),
			value = 'no'
		},

		{
			label = ('%s - <span style="color:green;">%s</span>'):format(license.label, _U('dealer_item', ESX.Math.GroupDigits(license.price))),
			value = licenseName,
			price = license.price,
			licenseName = license.label
		}
	}

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'license_shop', {
		title    = _U('license_title'),
		align    = 'top-left',
		elements = elements
	}, function(data, menu)

		if data.current.value ~= 'no' then
			ESX.TriggerServerCallback('esx_illegal:buyLicense', function(boughtLicense)
				if boughtLicense then
					ESX.ShowNotification(_U('license_bought', data.current.licenseName, ESX.Math.GroupDigits(data.current.price)))
				else
					ESX.ShowNotification(_U('license_bought_fail', data.current.licenseName))
				end
			end, data.current.value)
		else
			menu.close()
		end

	end, function(data, menu)
		menu.close()
		menuOpen = false
	end)
end



-- Weed Effect
RegisterNetEvent('esx_retrodrugs:onPot')
AddEventHandler('esx_retrodrugs:onPot', function()
	RequestAnimSet("MOVE_M@DRUNK@SLIGHTLYDRUNK")
	while not HasAnimSetLoaded("MOVE_M@DRUNK@SLIGHTLYDRUNK") do
		Citizen.Wait(0)
	end
	TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_SMOKING_POT", 0, true)
	Citizen.Wait(10000)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	ClearPedTasksImmediately(GetPlayerPed(-1))
	SetTimecycleModifier("spectator5")
	SetPedMotionBlur(GetPlayerPed(-1), true)
	SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
	SetPedIsDrunk(GetPlayerPed(-1), true)
	DoScreenFadeIn(1000)
	exports['mythic_notify']:SendAlert('error', 'Je hebt voor 30 seconden een stoned effect....', 5000, { ['background-color'] = '#ff0000', ['color'] = '#ffffff' })
	Citizen.Wait(30000)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	DoScreenFadeIn(1000)
	exports['mythic_notify']:SendAlert('succes', 'Je voelt je weer een stuk beter!', 5000, { ['background-color'] = '#00ff00', ['color'] = '#ffffff' })
	ClearTimecycleModifier()
	ResetScenarioTypesEnabled()
	ResetPedMovementClipset(GetPlayerPed(-1), 0)
	SetPedIsDrunk(GetPlayerPed(-1), false)
	SetPedMotionBlur(GetPlayerPed(-1), false)
end)

-- Opium Effect
RegisterNetEvent('esx_retrodrugs:onOpium')
AddEventHandler('esx_retrodrugs:onOpium', function()
	RequestAnimSet("MOVE_M@DRUNK@SLIGHTLYDRUNK")
	while not HasAnimSetLoaded("MOVE_M@DRUNK@SLIGHTLYDRUNK") do
		Citizen.Wait(0)
	end
	TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_SMOKING_POT", 0, true)
	Citizen.Wait(10000)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	ClearPedTasksImmediately(GetPlayerPed(-1))
	SetTimecycleModifier("spectator5")
	SetPedMotionBlur(GetPlayerPed(-1), true)
	SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
	SetPedIsDrunk(GetPlayerPed(-1), true)
	DoScreenFadeIn(1000)
	exports['mythic_notify']:SendAlert('error', 'Je hebt voor 60 seconden een heroine effect....', 5000, { ['background-color'] = '#ff0000', ['color'] = '#ffffff' })
	Citizen.Wait(450000)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	DoScreenFadeIn(1000)
	exports['mythic_notify']:SendAlert('succes', 'Je voelt je weer een stuk beter!', 5000, { ['background-color'] = '#00ff00', ['color'] = '#ffffff' })
	ClearTimecycleModifier()
	ResetScenarioTypesEnabled()
	ResetPedMovementClipset(GetPlayerPed(-1), 0)
	SetPedIsDrunk(GetPlayerPed(-1), false)
	SetPedMotionBlur(GetPlayerPed(-1), false)
end)

-- Meth Effect
RegisterNetEvent('esx_retrodrugs:onMeth')
AddEventHandler('esx_retrodrugs:onMeth', function()
	RequestAnimSet("MOVE_M@DRUNK@SLIGHTLYDRUNK")
	while not HasAnimSetLoaded("MOVE_M@DRUNK@SLIGHTLYDRUNK") do
		Citizen.Wait(0)
	end
	TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_SMOKING_POT", 0, true)
	Citizen.Wait(10000)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	ClearPedTasksImmediately(GetPlayerPed(-1))
	SetTimecycleModifier("spectator5")
	SetPedMotionBlur(GetPlayerPed(-1), true)
	SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
	SetPedIsDrunk(GetPlayerPed(-1), true)
	DoScreenFadeIn(1000)
	exports['mythic_notify']:SendAlert('error', 'Je hebt voor 60 seconden een meth effect....', 5000, { ['background-color'] = '#ff0000', ['color'] = '#ffffff' })
	Citizen.Wait(60000)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	DoScreenFadeIn(1000)
	exports['mythic_notify']:SendAlert('succes', 'Je voelt je weer een stuk beter!', 5000, { ['background-color'] = '#00ff00', ['color'] = '#ffffff' })
	ClearTimecycleModifier()
	ResetScenarioTypesEnabled()
	ResetPedMovementClipset(GetPlayerPed(-1), 0)
	SetPedIsDrunk(GetPlayerPed(-1), false)
	SetPedMotionBlur(GetPlayerPed(-1), false)
end)

-- Coke Effect
RegisterNetEvent('esx_retrodrugs:onCoke')
AddEventHandler('esx_retrodrugs:onCoke', function()
	RequestAnimSet("MOVE_M@DRUNK@SLIGHTLYDRUNK")
	while not HasAnimSetLoaded("MOVE_M@DRUNK@SLIGHTLYDRUNK") do
		Citizen.Wait(0)
	end
	TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_SMOKING_POT", 0, true)
	Citizen.Wait(10000)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	ClearPedTasksImmediately(GetPlayerPed(-1))
	SetTimecycleModifier("spectator5")
	SetPedMotionBlur(GetPlayerPed(-1), true)
	SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
	SetPedIsDrunk(GetPlayerPed(-1), true)
	DoScreenFadeIn(1000)
	exports['mythic_notify']:SendAlert('error', 'Je hebt voor 45 seconden een cocaine effect....', 5000, { ['background-color'] = '#ff0000', ['color'] = '#ffffff' })
	Citizen.Wait(45000)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	DoScreenFadeIn(1000)
	exports['mythic_notify']:SendAlert('succes', 'Je voelt je weer een stuk beter!', 5000, { ['background-color'] = '#00ff00', ['color'] = '#ffffff' })
	ClearTimecycleModifier()
	ResetScenarioTypesEnabled()
	ResetPedMovementClipset(GetPlayerPed(-1), 0)
	SetPedIsDrunk(GetPlayerPed(-1), false)
	SetPedMotionBlur(GetPlayerPed(-1), false)
end)



RegisterNetEvent('esx_retrodrugs:onBier')
AddEventHandler('esx_retrodrugs:onBier', function(prop_name)
		prop_name = prop_name or 'prop_ld_flow_bottle'

		local playerPed = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(playerPed))
		local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
		local boneIndex = GetPedBoneIndex(playerPed, 18905)
		AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)

		ESX.Streaming.RequestAnimDict('mp_player_intdrink', function()
			TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, 2000, 0, 1, true, true, true)

			Citizen.Wait(3000)
			IsAnimated = false
			ClearPedSecondaryTask(playerPed)
			DeleteObject(prop)
		end)
		DoScreenFadeOut(1000)
		Citizen.Wait(1000)
		ClearPedTasksImmediately(GetPlayerPed(-1))
		SetTimecycleModifier("spectator5")
		SetPedMotionBlur(GetPlayerPed(-1), true)
		SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
		SetPedIsDrunk(GetPlayerPed(-1), true)
		DoScreenFadeIn(1000)
		exports['mythic_notify']:SendAlert('error', 'Je hebt voor 45 seconden een dronken effect....', 5000, { ['background-color'] = '#ff0000', ['color'] = '#ffffff' })
		Citizen.Wait(45000)
		DoScreenFadeOut(1000)
		Citizen.Wait(1000)
		DoScreenFadeIn(1000)
		exports['mythic_notify']:SendAlert('succes', 'Je voelt je weer een stuk beter!', 5000, { ['background-color'] = '#00ff00', ['color'] = '#ffffff' })
		ClearTimecycleModifier()
		ResetScenarioTypesEnabled()
		ResetPedMovementClipset(GetPlayerPed(-1), 0)
		SetPedIsDrunk(GetPlayerPed(-1), false)
		SetPedMotionBlur(GetPlayerPed(-1), false)
end)




RegisterNetEvent('esx_retrodrugs:Washandschoen')
AddEventHandler('esx_retrodrugs:Washandschoen', function(prop_name)
	local playerPed = PlayerPedId()
	local vehicle   = ESX.Game.GetVehicleInDirection()
	local coords    = GetEntityCoords(playerPed)

	if IsPedSittingInAnyVehicle(playerPed) then
		exports['mythic_notify']:DoHudText('succes', 'Je kan je auto niet schoonmaken als je erin zit', { ['background-color'] = '#4844E3', ['color'] = '#000000' })
		return
	end

	if DoesEntityExist(vehicle) then
		isBusy = true
		TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_MAID_CLEAN', 0, true)
		Citizen.CreateThread(function()
			Citizen.Wait(10000)
			TriggerServerEvent('esx_illegal:removehandschoen')
			SetVehicleDirtLevel(vehicle, 0)
			ClearPedTasksImmediately(playerPed)

			exports['mythic_notify']:DoHudText('succes', 'Je voertuig is schoon gemaakt', { ['background-color'] = '#4844E3', ['color'] = '#000000' })
			isBusy = false
		end)
	else
		exports['mythic_notify']:DoHudText('succes', 'Er is geen auto in de buurt', { ['background-color'] = '#4844E3', ['color'] = '#000000' })
	end
end)


local cokeQTE       			= 0
local coke_poochQTE 			= 0
local weedQTE					= 0
local weed_poochQTE 			= 0
local methQTE					= 0
local meth_poochQTE 			= 0
local opiumQTE					= 0
local opium_poochQTE 			= 0
local myJob 					= nil
local HasAlreadyEnteredMarker   = false
local LastZone                  = nil
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}

AddEventHandler('esx_drugs:hasEnteredMarker', function(zone)
	if myJob == 'police' or myJob == 'offpolice' or myJob == 'taxi' or myJob == 'ambulance' or myJob == 'mechanic' then
		return
	end

	ESX.UI.Menu.CloseAll()
	
	if zone == 'cokeverpak' then
		CurrentAction     = zone
		CurrentActionMsg  = _U('press_process_coke')
		CurrentActionData = {}
	elseif zone == 'cokeverpak' then
		if cokeQTE >= 2 then
			CurrentAction     = zone
			CurrentActionMsg  = _U('press_process_coke')
			CurrentActionData = {}
		end
	elseif zone == 'CokeVerkoop' then
		if coke_poochQTE >= 1 then
			CurrentAction     = zone
			CurrentActionMsg  = _U('press_sell_coke')
			CurrentActionData = {}
		end
	elseif zone == 'MethField' then
		CurrentAction     = zone
		CurrentActionMsg  = _U('press_collect_meth')
		CurrentActionData = {}
	elseif zone == 'MethProcessing' then
		if methQTE >= 2 then
			CurrentAction     = zone
			CurrentActionMsg  = _U('press_process_meth')
			CurrentActionData = {}
		end
	elseif zone == 'MethDealer' then
		if meth_poochQTE >= 1 then
			CurrentAction     = zone
			CurrentActionMsg  = _U('press_sell_meth')
			CurrentActionData = {}
		end
	elseif zone == 'WeedField' then
		CurrentAction     = zone
		CurrentActionMsg  = _U('press_collect_weed')
		CurrentActionData = {}
	elseif zone == 'WeedProcessing' then
		if weedQTE >= 2 then
			CurrentAction     = zone
			CurrentActionMsg  = _U('press_process_weed')
			CurrentActionData = {}
		end
	elseif zone == 'WeedDealer' then
		if weed_poochQTE >= 1 then
			CurrentAction     = zone
			CurrentActionMsg  = _U('press_sell_weed')
			CurrentActionData = {}
		end
	elseif zone == 'OpiumField' then
		CurrentAction     = zone
		CurrentActionMsg  = _U('press_collect_opium')
		CurrentActionData = {}
	elseif zone == 'OpiumProcessing' then
		if opiumQTE >= 2 then
			CurrentAction     = zone
			CurrentActionMsg  = _U('press_process_opium')
			CurrentActionData = {}
		end
	elseif zone == 'OpiumDealer' then
		if opium_poochQTE >= 1 then
			CurrentAction     = zone
			CurrentActionMsg  = _U('press_sell_opium')
			CurrentActionData = {}
		end
	end
end)

AddEventHandler('esx_drugs:hasExitedMarker', function(zone)
	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
	local securityToken = '25291'
	if zone == 'cokefarm' then
--		TriggerServerEvent('esx_drugs:stopHarvestCoke', securityToken)
	elseif zone == 'cokeverpak' then
	TriggerServerEvent('esx_drugs:stopTransformCoke', securityToken)
	elseif zone == 'CokeVerkoop' then
		TriggerServerEvent('esx_drugs:stopSellCoke', securityToken)
	elseif zone == 'MethField' then
--		TriggerServerEvent('esx_drugs:stopHarvestMeth', securityToken)
	elseif zone == 'MethProcessing' then
		TriggerServerEvent('esx_drugs:stopTransformMeth', securityToken)
	elseif zone == 'MethDealer' then
		TriggerServerEvent('esx_drugs:stopSellMeth', securityToken)
	elseif zone == 'WeedField' then
--		TriggerServerEvent('esx_drugs:stopHarvestWeed', securityToken)
	elseif zone == 'WeedProcessing' then
		TriggerServerEvent('esx_drugs:stopTransformWeed', securityToken)
	elseif zone == 'WeedDealer' then
		TriggerServerEvent('esx_drugs:stopSellWeed', securityToken)
	elseif zone == 'OpiumField' then
--		TriggerServerEvent('esx_drugs:stopHarvestOpium', securityToken)
	elseif zone == 'OpiumProcessing' then
		TriggerServerEvent('esx_drugs:stopTransformOpium', securityToken)
	elseif zone == 'OpiumDealer' then
		TriggerServerEvent('esx_drugs:stopSellOpium', securityToken)
	end
end)

-- Weed Effect
RegisterNetEvent('esx_drugs:onPot')
AddEventHandler('esx_drugs:onPot', function()
	RequestAnimSet("MOVE_M@DRUNK@SLIGHTLYDRUNK")
	while not HasAnimSetLoaded("MOVE_M@DRUNK@SLIGHTLYDRUNK") do
		Citizen.Wait(0)
	end
	TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_SMOKING_POT", 0, true)
	Citizen.Wait(5000)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	ClearPedTasksImmediately(GetPlayerPed(-1))
	SetTimecycleModifier("spectator5")
	SetPedMotionBlur(GetPlayerPed(-1), true)
	SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
	SetPedIsDrunk(GetPlayerPed(-1), true)
	DoScreenFadeIn(1000)
	Citizen.Wait(600000)
	DoScreenFadeOut(1000)
	Citizen.Wait(1000)
	DoScreenFadeIn(1000)
	ClearTimecycleModifier()
	ResetScenarioTypesEnabled()
	ResetPedMovementClipset(GetPlayerPed(-1), 0)
	SetPedIsDrunk(GetPlayerPed(-1), false)
	SetPedMotionBlur(GetPlayerPed(-1), false)
end)

-- Render markers
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(0)

		local coords = GetEntityCoords(GetPlayerPed(-1))

		for k,v in pairs(Config.Zones) do
			if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < Config.DrawDistance then
				DrawMarker(Config.MarkerType, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.ZoneSize.x, Config.ZoneSize.y, Config.ZoneSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
			end
		end

		for k,v in pairs(Config.Zones1) do
			if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < Config.DrawDistance then
				DrawMarker(Config.MarkerType, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.ZoneSize.x, Config.ZoneSize.y, Config.ZoneSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
			end
		end

	end
end)




if Config.ShowBlips then
	-- Create blips
	Citizen.CreateThread(function()
		for k,v in pairs(Config.Zones1) do
			local blip = AddBlipForCoord(v.x, v.y, v.z)

			SetBlipSprite (blip, v.sprite)
			SetBlipDisplay(blip, 4)
			SetBlipScale  (blip, 0.9)
			SetBlipColour (blip, v.color)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(v.name)
			EndTextCommandSetBlipName(blip)
		end
	end)
end


-- RETURN NUMBER OF ITEMS FROM SERVER
RegisterNetEvent('esx_drugs:ReturnInventory')
AddEventHandler('esx_drugs:ReturnInventory', function(cokeNbr, cokepNbr, methNbr, methpNbr, weedNbr, weedpNbr, opiumNbr, opiumpNbr, jobName, currentZone)
	cokeQTE			= coke
	coke_poochQTE	= cokepNbr
	methQTE			= methNbr
	meth_poochQTE	= methpNbr
	weedQTE			= weedNbr
	weed_poochQTE	= weedpNbr
	opiumQTE		= opiumNbr
	opium_poochQTE	= opiumpNbr
	myJob			= jobName
	TriggerEvent('esx_drugs:hasEnteredMarker', currentZone)
end)

-- Activate menu when player is inside marker
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(0)

		local coords      = GetEntityCoords(GetPlayerPed(-1))
		local isInMarker  = false
		local currentZone = nil

		for k,v in pairs(Config.Zones) do
			if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < Config.ZoneSize.x / 2) then
				isInMarker  = true
				currentZone = k
			end
		end

		for k,v in pairs(Config.Zones1) do
			if(GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < Config.ZoneSize.x / 2) then
				isInMarker  = true
				currentZone = k
			end
		end

		if isInMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
			lastZone				= currentZone
			TriggerServerEvent('esx_drugs:GetUserInventory', currentZone)
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('esx_drugs:hasExitedMarker', lastZone)
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if CurrentAction ~= nil then
			ESX.ShowHelpNotification(CurrentActionMsg)

			local securityToken = '25291'


			if IsControlJustReleased(0, Keys['E']) and IsPedOnFoot(PlayerPedId()) then
				if CurrentAction == 'cokefarm' then
--					TriggerServerEvent('esx_drugs:startHarvestCoke', securityToken)
				elseif CurrentAction == 'cokeverpak' then
					Wait(250)
					TriggerServerEvent('esx_drugs:startTransformCoke', securityToken, `esx_drugs:startSellItem`)
					Wait(250)
				elseif CurrentAction == 'CokeVerkoop' then
					TriggerServerEvent('esx_drugs:startSellCoke', securityToken, `esx_drugs:startSellItem`)
				elseif CurrentAction == 'MethField' then
--					TriggerServerEvent('esx_drugs:startHarvestMeth', securityToken)
				elseif CurrentAction == 'MethProcessing' then
					TriggerServerEvent('esx_drugs:startTransformMeth', securityToken, `esx_drugs:startSellItem`)
				elseif CurrentAction == 'MethDealer' then
					TriggerServerEvent('esx_drugs:startSellMeth', securityToken, `esx_drugs:startSellItem`)
				elseif CurrentAction == 'WeedField' then
--					TriggerServerEvent('esx_drugs:startHarvestWeed', `esx_drugs:startSellItem`, securityToken)
				elseif CurrentAction == 'WeedProcessing' then
					TriggerServerEvent('esx_drugs:startTransformWeed', securityToken, `esx_drugs:startSellItem`)
				elseif CurrentAction == 'WeedDealer' then
					TriggerServerEvent('esx_drugs:startSellWiet', securityToken, `esx_drugs:startSellItem`)
				elseif CurrentAction == 'OpiumField' then
--					TriggerServerEvent('esx_drugs:startHarvestOpium', securityToken)
				elseif CurrentAction == 'OpiumProcessing' then
					TriggerServerEvent('esx_drugs:startTransformOpium', securityToken)
				elseif CurrentAction == 'OpiumDealer' then
					TriggerServerEvent('esx_drugs:startSellOpium', securityToken)
				end
				
				CurrentAction = nil
			end
		end
	end
end)