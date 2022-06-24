-- Version 0.1
-- Devloped by Everett aka Mr. Yellow aka Munky aka De_verett
local carSpawned = false
local newVeh = nil
local inLightbarMenu = false
local lightBool = false
local sirenBool = false
local oldSirenBool = false
local controlsDisabled = false
local xCoord = 0
local yCoord = 0
local zCoord = 0
local xrot = 0.0
local yrot = 0.0
local zrot = 0.0
local snd_pwrcall = {}
local airHornSirenID = nil
local sirenTone = "VEHICLES_HORNS_SIREN_1"
--local audioRef = "DLC_WMSIRENS_SOUNDSET"
local vehPlateBoolSavedData = nil
local isPlateCar = false
local isAirhornKeyPressed = false
local deleteVehicleLightbars = {}
local lightBarData = {}
local lightBarsAllowed = false
DecorRegister("_HAS_POLICE_LIGHTS", 2)
DecorRegister("_POLICE_LIGHTS_ACTIVE", 2)

local _menuPool, mainMenu = nil, nil

ESX = nil

local PlayerData              = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(500)
	end

	while not ESX.IsPlayerLoaded() do
		Citizen.Wait(500)
	end

	PlayerData = ESX.GetPlayerData()
	
	Citizen.Wait(1000)
	CheckJob()
end)

function CheckJob()
	if PlayerData.job.name == 'police' or PlayerData.job.name == 'kmar' then
		lightBarsAllowed = true
		StartThread()
	end
end

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(newData)
	Citizen.Wait(0)
	CheckJob()
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)

	PlayerData.job = job

	CheckJob()
	
end)

RegisterCommand("lightbars_canuse", function()
	local vehicle = ESX.Game.GetClosestVehicle()
	print(("_HAS_POLICE_LIGHTS: %s; lightBarsAllowed: %s"):format(DecorGetBool(vehicle, "_HAS_POLICE_LIGHTS"), lightBarsAllowed))
end)

function StartThread()
	if Running or not lightBarsAllowed then
		return
	end
	Running = true
	Citizen.CreateThread(function()
		while lightBarsAllowed do
			Citizen.Wait(0)
			if inLightbarMenu then
				printControlsText()
			end
			local vehicle = GetVehiclePedIsUsing(PlayerPedId())
			if DoesEntityExist(vehicle) then
				if DecorGetBool(vehicle, "_HAS_POLICE_LIGHTS") then

					DisableControlAction(1, 85, true)
					if (IsControlJustReleased(1, 44)) then -- Q to turn on lights
						toggleLights()
					end
	
					--DisableControlAction(1, 19, true)
					if (IsControlJustReleased(1, 19)) then -- G to turn on siren
						sirenTone = "VEHICLES_HORNS_SIREN_1"
						toggleSiren()
					end
	
					DisableControlAction(1, 45, true)
					if (IsDisabledControlJustReleased(1, 45)) then -- Left control to change siren tone
						changeSirenTone()
					end
	
					DisableControlAction(1, 86, true)
					if IsDisabledControlJustPressed(1, 86) and not isAirhornKeyPressed then
						playAirHorn(true)
						isAirhornKeyPressed = true
						if sirenBool then
							oldSirenBool = sirenBool
							toggleSiren()
						end
					end
	
					if IsDisabledControlJustReleased(1, 86) then
						playAirHorn(false)
						isAirhornKeyPressed = false
						if oldSirenBool then
							toggleSiren()
							oldSirenBool = false
						end
					end
	
					if isPlateCar then
						DisableControlAction(1, 86, true)
					end -- Disables Veh horn
				elseif not inLightbarMenu then
					Citizen.Wait(1000)
				end
			else
				Citizen.Wait(2000)
			end
		end
		Running = false
	end)
end

function printControlsText()
	SetTextFont(0)
	SetTextProportional(1)
	SetTextScale(0.0, 0.4)
	SetTextColour(128, 128, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString("Use your ↑ ↓ → ← Arrow Keys for Lateral Movements, Pg Up and Pg Down for Altitude Change")
	DrawText(0.25, 0.9)
	--
	SetTextFont(0)
	SetTextProportional(1)
	SetTextScale(0.0, 0.4)
	SetTextColour(128, 128, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString("and Insert and Delete for rotation. SPACE to save, DELETE to cancel")
	DrawText(0.25, 0.93)
end



function toggleLights()
	local playerPed = PlayerPedId()
	TriggerServerEvent("aapje:toggleLights2", GetVehicleNumberPlateText(GetVehiclePedIsIn(playerPed, false)))
	if sirenBool == true then
		TriggerServerEvent("aapje:ToggleSound1Server", GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), false)))
	end
end

function changeSirenTone()
	local currPlate = GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), false))
	if not(vehPlateBoolSavedData == currPlate) then
		TriggerServerEvent("aapje:returnLightBarVehiclePlates")
		while true do
			if(vehPlateBoolSavedData == GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), false))) then
				break
			end
			if not(currPlate == GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), false))) then
				return
			end
			Citizen.Wait(10)
		end
	end
	if isPlateCar then
		if sirenTone == "SIREN_ALPHA" then
			sirenTone = "SIREN_BRAVO"
			toggleSiren()
		elseif sirenTone == "SIREN_BRAVO" then
			sirenTone = "SIREN_ALPHA"
			toggleSiren()
		else
			sirenTone = "SIREN_ALPHA"
			toggleSiren()
		end
	end
end

RegisterNetEvent('openLightbarMenu')
AddEventHandler('openLightbarMenu', function(lightbarModel)
	lightMenu(lightbarModel)
end)

RegisterNetEvent('clientToggleLights')
AddEventHandler('clientToggleLights', function(lightsArray, lightsStatus, hostVehiclePointer)
	Citizen.CreateThread(function()
		for k,v in pairs(lightsArray) do
			if NetworkDoesNetworkIdExist(v) then
				NetworkRequestControlOfNetworkId(v)
				local timeout = 0
				while not NetworkHasControlOfNetworkId(v) and timeout < 5000 do
					Citizen.Wait(100)
					timeout = timeout + 100
				end
				local test1 = NetToVeh(v)
				lightBool = lightsStatus
				local state = not lightsStatus
				SetVehicleSiren(test1, state)
				if state then
					DecorSetBool(GetVehiclePedIsIn(PlayerPedId(), false), "_POLICE_LIGHTS_ACTIVE", state)
				else
					DecorRemove(GetVehiclePedIsIn(PlayerPedId(), false), "_POLICE_LIGHTS_ACTIVE")
				end
			end
		end
	end)
end)

function toggleSiren()


	if lightBool == false then
		TriggerServerEvent("aapje:ToggleSound1Server", GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), false)))
	end
end

function spawnLightbar(lightbarModel)
	local player = PlayerPedId()
	local vehiclehash1 = GetHashKey(lightbarModel)

	RequestModel(vehiclehash1)
	while not HasModelLoaded(vehiclehash1) do
		Citizen.Wait(100)
	end

	local coords = GetEntityCoords(player)
	newVeh = CreateVehicle(vehiclehash1, coords.x, coords.y, coords.z, GetEntityHeading(PlayerPedId()), true, 0)
	DecorSetInt(newVeh, "_LAST_LEFT", GetTime() + 3600)
	SetEntityCollision(newVeh, false, false)
	SetVehicleDoorsLocked(newVeh, 2)
	SetEntityAsMissionEntity(newVeh, true, true)
	local netId = NetworkGetNetworkIdFromEntity(newVeh)
	TriggerServerEvent("mbl:sc", 125.0, netId)
end

function lightMenu(lightbarModel)
	if not inLightbarMenu then
		inLightbarMenu = true
		local playerPed = PlayerPedId()
		spawnLightbar(lightbarModel)
		controlsDisabled = true
		disableControls()
		AttachEntityToEntity(newVeh, GetVehiclePedIsIn(playerPed, false), 0, 0, 0, 0, 0.0, 0.0, 0.0, true, true, true, true, 0, true)
		while true do
			Citizen.Wait(0)
			--resetOffSets()
			moveObj(newVeh)
			if (IsControlJustReleased(1, 22)) then -- attatch obj and close
				DecorSetBool(GetVehiclePedIsIn(playerPed, false), "_HAS_POLICE_LIGHTS", true)
				TriggerServerEvent("aapje:addLightbar", GetVehicleNumberPlateText(GetVehiclePedIsIn(playerPed, false)), VehToNet(newVeh), GetVehiclePedIsIn(playerPed, false))
				DecorSetInt(newVeh, "_LAST_LEFT", GetTime() + 3600)
				table.insert(lightBarData, {
					model = lightbarModel,
					x = xCoord,
					y = yCoord,
					z = zCoord,
					xrot = xrot,
					yrot = yrot,
					zrot = zrot
				})
				inLightbarMenu = false
				newVeh=nil
				controlsDisabled = false
				if(vehPlateBoolSavedData == GetVehicleNumberPlateText(GetVehiclePedIsIn(playerPed, false))) then
					isPlateCar = true
				end
				break
			end

			if (IsControlJustReleased(1, 177)) then -- close menu
				inLightbarMenu = false
				DeleteVehicle(newVeh)
				newVeh = nil
				controlsDisabled = false
				break
			end
		end
	end
end

function moveObj(veh)
	local player = PlayerPedId()
	local MOVEMENT_CONSTANT = 0.01
	local vehOffset = GetOffsetFromEntityInWorldCoords(newVeh, 0.0, 1.3, 0.0)

	if (IsControlJustReleased(1, 121 --[[INSERT]])) then -- rotate 180 upside down
		yrot = yrot + 90.0
		DetachEntity(newVeh, 0, 0)
		AttachEntityToEntity(newVeh, GetVehiclePedIsIn(player, false), 0, xCoord, yCoord, zCoord, xrot, yrot, zrot, true, true, true, true, 0, true)
	end
	if (IsControlJustReleased(1, 178 --[[DELETE]])) then -- rotate 180
		zrot = zrot + 90.0
		DetachEntity(newVeh, 0, 0)
		AttachEntityToEntity(newVeh, GetVehiclePedIsIn(player, false), 0, xCoord, yCoord, zCoord, xrot, yrot, zrot, true, true, true, true, 0, true)
	end
	DisableControlAction(1, 190)
	if (IsDisabledControlPressed(1, 190 --[[ARROW RIGHT]])) then -- move forward
		xCoord = xCoord + MOVEMENT_CONSTANT
		DetachEntity(newVeh, 0, 0)
		AttachEntityToEntity(newVeh, GetVehiclePedIsIn(player, false), 0, xCoord, yCoord, zCoord, xrot, yrot, zrot, true, true, true, true, 0, true)
	end
	DisableControlAction(1, 189)
	if (IsDisabledControlPressed(1, 189 --[[ARROW LEFT]])) then -- move backwards
		xCoord = xCoord - MOVEMENT_CONSTANT
		DetachEntity(newVeh, 0, 0)
		AttachEntityToEntity(newVeh, GetVehiclePedIsIn(player, false), 0, xCoord, yCoord, zCoord, xrot, yrot, zrot, true, true, true, true, 0, true)
	end
	DisableControlAction(1, 27)
	if (IsDisabledControlPressed(1, 27 --[[ARROW UP]])) then -- move right
		yCoord = yCoord + MOVEMENT_CONSTANT
		DetachEntity(newVeh, 0, 0)
		AttachEntityToEntity(newVeh, GetVehiclePedIsIn(player, false), 0, xCoord, yCoord, zCoord, xrot, yrot, zrot, true, true, true, true, 0, true)
	end
	DisableControlAction(1, 187)
	if (IsDisabledControlPressed(1, 187)) then -- move left
		yCoord = yCoord - MOVEMENT_CONSTANT
		DetachEntity(newVeh, 0, 0)
		AttachEntityToEntity(newVeh, GetVehiclePedIsIn(player, false), 0, xCoord, yCoord, zCoord, xrot, yrot, zrot, true, true, true, true, 0, true)
	end
	DisableControlAction(1, 96, true)
	DisableControlAction(1, 208, true)
	if (IsDisabledControlPressed(1, 96) or IsDisabledControlPressed(1, 208 --[[PAGE UP]])) then -- move up
		zCoord = zCoord + MOVEMENT_CONSTANT
		DetachEntity(newVeh, 0, 0)
		AttachEntityToEntity(newVeh, GetVehiclePedIsIn(player, false), 0, xCoord, yCoord, zCoord, xrot, yrot, zrot, true, true, true, true, 0, true)
	end
	DisableControlAction(1, 97, true)
	DisableControlAction(1, 207, true)
	if (IsDisabledControlPressed(1, 97) or IsDisabledControlPressed(1, 207 --[[PAGE DOWN]])) then -- move down
		zCoord = zCoord - MOVEMENT_CONSTANT
		DetachEntity(newVeh, 0, 0)
		AttachEntityToEntity(newVeh, GetVehiclePedIsIn(player, false), 0, xCoord, yCoord, zCoord, xrot, yrot, zrot, true, true, true, true, 0, true)
	end
end

function resetOffSets()
	xCoord = 0
	yCoord = 0
	zCoord = 0
	xrot = 0
	yrot = 0
	zrot = 0
end

function disableControls()
	Citizen.CreateThread(function()
		while controlsDisabled do
			Citizen.Wait(0)
			DisableControlAction(0,21,true) -- disable sprint
			DisableControlAction(0,24,true) -- disable attack
			DisableControlAction(0,25,true) -- disable aim
			DisableControlAction(0,47,true) -- disable weapon
			DisableControlAction(0,58,true) -- disable weapon
			DisableControlAction(0,263,true) -- disable melee
			DisableControlAction(0,264,true) -- disable melee
			DisableControlAction(0,257,true) -- disable melee
			DisableControlAction(0,140,true) -- disable melee
			DisableControlAction(0,141,true) -- disable melee
			DisableControlAction(0,142,true) -- disable melee
			DisableControlAction(0,143,true) -- disable melee
			DisableControlAction(0,75,true) -- disable exit vehicle
			DisableControlAction(27,75,true) -- disable exit vehicle
			DisableControlAction(0,32,true) -- move (w)
			DisableControlAction(0,34,true) -- move (a)
			DisableControlAction(0,33,true) -- move (s)
			DisableControlAction(0,35,true) -- move (d)
			DisableControlAction(0,71,true) -- move (d)
			DisableControlAction(0,72,true) -- move (d)
		end
	end)
end


RegisterNetEvent("sound1Client")
AddEventHandler("sound1Client", function(sender, toggle)
	local player_s = GetPlayerFromServerId(sender)
	if player_s ~= -1 then
		local ped_s = GetPlayerPed(player_s)
		if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
			if IsPedInAnyVehicle(ped_s, false) then
				local veh = GetVehiclePedIsUsing(ped_s)
				TogPowercallStateForVeh(veh, toggle)
			end
		end
	end
end)

function TogPowercallStateForVeh(veh, toggle)
	if DoesEntityExist(veh) and not IsEntityDead(veh) then
		if toggle == true then
			if snd_pwrcall[veh] == nil then
				snd_pwrcall[veh] = GetSoundId()
				PlaySoundFromEntity(snd_pwrcall[veh], sirenTone, veh, 0, 0, 0)
				sirenBool = true
			end
		else
			if snd_pwrcall[veh] ~= nil then
				StopSound(snd_pwrcall[veh])
				ReleaseSoundId(snd_pwrcall[veh])
				snd_pwrcall[veh] = nil
				sirenBool = false
			end
		end
	end
end


function playAirHorn(bool)
	local tempVeh = GetVehiclePedIsIn(PlayerPedId(), false)
	local currPlate = GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), false))
	if not(vehPlateBoolSavedData == currPlate) then
		TriggerServerEvent("aapje:returnLightBarVehiclePlates")
		while true do
			if(vehPlateBoolSavedData == GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), false))) then
				break
			end
			if not(currPlate == GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), false))) then
				return
			end
			Citizen.Wait(10)
		end
	end
	if not(tempVeh == nil) and isPlateCar and vehPlateBoolSavedData == currPlate then
		if bool then
			airHornSirenID = GetSoundId()
			PlaySoundFromEntity(airHornSirenID, "SIREN_BRAVO", tempVeh, "DLC_WMSIRENS_SOUNDSET", 0, 0)
		end
		if not bool then
			StopSound(airHornSirenID)
			ReleaseSoundId(airHornSirenIDs)
			airHornSirenID = nil
		end
	end
end


RegisterNetEvent("sendLightBarVehiclePlates")
AddEventHandler("sendLightBarVehiclePlates", function(platesArr)
	local player = PlayerPedId()
	local currPlate = GetVehicleNumberPlateText(GetVehiclePedIsIn(player, false))
	for k,v in pairs(platesArr) do
		if currPlate == v then
			vehPlateBoolSavedData = currPlate
			isPlateCar = true
			return
		end
	end
	vehPlateBoolSavedData = currPlate
	isPlateCar = false
end)

function deleteArray()
	for k,v in pairs(deleteVehicleLightbars) do
		TriggerServerEvent("es:dl", v)
		DeleteVehicle(NetToVeh(v))
	end
end

RegisterNetEvent("deleteLightbarVehicle")
AddEventHandler("deleteLightbarVehicle", function(mainVehPlate)
	TriggerServerEvent("aapje:returnLightbarsForMainVeh", mainVehPlate)
end)

RegisterNetEvent("updateLightbarArray")
AddEventHandler("updateLightbarArray", function(plates)
	deleteVehicleLightbars = plates
	if sirenBool then
		toggleLights()
	end
	deleteArray()
	isPlateCar = false
	lightBool = false
	sirenBool = false
end)

RegisterNetEvent("centerLightbarMenu")
AddEventHandler("centerLightbarMenu", function()
	xCoord = 0
	yCoord = 0
	zCoord = 0
	xrot = 0
	yrot = 0
	zrot = 0
end)


-------------------MENU-------------------------

_menuPool = MenuPool.New()
mainMenu = NativeUI.CreateMenu("Lightbar Menu", "")
_menuPool:Add(mainMenu)
_menuPool:RefreshIndex()

local lightBarModels = {
	[`lightbarTwoSticks`] = true,
	[`longLightbar`] = true,
	[`longLightbarRed`] = true,
	[`fbiold`] = true
}

exports("GetLightbarModels", function()
	return lightBarModels
end)

function lightbarMenu(menu)
	lightbarIndex = 1

	local item1 = NativeUI.CreateItem("Small Stick Light ", "")
	mainMenu:AddItem(item1)
	local item2 = NativeUI.CreateItem("Blue Stick Light ", "")
	mainMenu:AddItem(item2)
	local item3 = NativeUI.CreateItem("Red Stick Light ", "")
	mainMenu:AddItem(item3)
	local item4 = NativeUI.CreateItem("Blue Dome Light ", "")
	mainMenu:AddItem(item4)
	local item5 = NativeUI.CreateItem("Remove All Lights ", "")
	mainMenu:AddItem(item5)
	local item6 = NativeUI.CreateItem("Center Lightbar ", "")
	mainMenu:AddItem(item6)

	mainMenu.OnIndexChange= function(menu, newindex)
		lightbarIndex = newindex
	end

	mainMenu.OnItemSelect = function (sender, item, index)
		if lightbarIndex == 1 then
			TriggerEvent("openLightbarMenu", "lightbarTwoSticks")
		elseif lightbarIndex == 2 then
			TriggerEvent("openLightbarMenu", "longLightbar")
		elseif lightbarIndex == 3 then
			TriggerEvent("openLightbarMenu", "longLightbarRed")
		elseif lightbarIndex == 4 then
			TriggerEvent("openLightbarMenu", "fbiold")
		elseif lightbarIndex == 5 then
			TriggerEvent("deleteLightbarVehicle", GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), false)))
		elseif lightbarIndex == 6 then
			TriggerEvent("centerLightbarMenu")
		end
	end
end
lightbarMenu(mainMenu)

RegisterCommand('savelightbar', function(source, args, raw)
	if lightBarsAllowed then
		local vehicle = GetVehiclePedIsIn(PlayerPedId())
		local model = GetEntityModel(vehicle)
		SetResourceKvp(tostring(model), json.encode(lightBarData))
	end
end)

RegisterCommand('getdata', function(source, args, raw)
	if lightBarsAllowed then
		local model = nil
		if args[1] then
			model = tostring(GetHashKey(args[1]))
		else
			model = GetEntityModel(GetVehiclePedIsIn(PlayerPedId()))
		end

		print(GetResourceKvpString(tostring(model)))
	end
end)

function LoadLights(data)
	local vehicle = GetVehiclePedIsIn(PlayerPedId())
	local model = GetEntityModel(vehicle)

	local timeout = 0
	NetworkRequestControlOfEntity(vehicle)
	while not NetworkHasControlOfEntity(vehicle) and timeout < 5000 do
		Citizen.Wait(100)
		NetworkRequestControlOfEntity(vehicle)
		timeout = timeout + 100
	end
	exports['esx_rpchat']:printToChat("lightbars", "Hou AUB rekening met de hoeveelheid bandwidth die lampen gebruiken! Als er dus veel spelers online zijn het liefst geen lightbars gebruiken binnen 500 meter van blokkenpark!")
	exports['esx_rpchat']:printToChat("lightbars", "Hiernaast ook maximaal 4 lampen aub!")
	DecorSetBool(vehicle, "_HAS_POLICE_LIGHTS", true)
	if #data > 4 then
		TriggerServerEvent("lightbar:lightsFlag", #data)
		exports['esx_rpchat']:printToChat("lightsflag", "Je auto bevat meer dan 4 lampen, fix dit aub zo snel mogelijk.")
	end
	for i=1, #data do
		local v = data[i]

		local vehiclehash1 = GetHashKey(v.model)
		RequestModel(vehiclehash1)
		while not HasModelLoaded(vehiclehash1) do
			Citizen.Wait(100)
		end
		local coords = GetEntityCoords(PlayerPedId())
		newVeh = CreateVehicle(vehiclehash1, coords.x, coords.y, coords.z, GetEntityHeading(PlayerPedId()), true, 0)
		SetEntityCollision(newVeh, false, false)
		SetVehicleDoorsLocked(newVeh, 2)
		SetEntityAsMissionEntity(newVeh, true, true)
		AttachEntityToEntity(newVeh, GetVehiclePedIsIn(PlayerPedId(), false), 0, v.x, v.y, v.z, v.xrot, v.yrot, v.zrot, true, true, true, true, 0, true)
		TriggerServerEvent("aapje:addLightbar", GetVehicleNumberPlateText(vehicle), VehToNet(newVeh), vehicle)
		DecorSetInt(newVeh, "_LAST_LEFT", GetTime() + 3600)
		newVeh=nil
		if(vehPlateBoolSavedData == GetVehicleNumberPlateText(vehicle)) then
			isPlateCar = true
		end
	end
end

function GetTime()
    return TryGetTime() or GetCloudTimeAsInt()
end

function TryGetTime()
    -- 1590254141 is 23/05/2020, datetime should be higher than that
    if time and time < 1590254141 then
        return nil
    end
    return time
end


function LoadData()
	local vehicle = GetVehiclePedIsIn(PlayerPedId())
	local model = GetEntityModel(vehicle)
	local data = GetResourceKvpString(tostring(model))
	if not data then
		print("No data found...")
		return
	end

	data = json.decode(data)
	return data
end

RegisterCommand('loadlightbar', function(source, args, raw)
	if lightBarsAllowed then
		LoadLights(LoadData())
	end
end)

function ToggleMenu()
	mainMenu:Clear()
	lightbarMenu(mainMenu)
	_menuPool:RefreshIndex()
	mainMenu:Visible(not mainMenu:Visible())

	if mainMenu:Visible() then
		Citizen.CreateThread(function()
			while mainMenu:Visible() do
				if not controlsDisabled and _menuPool and mainMenu:Visible() then
					_menuPool:ProcessMenus()
				end
				Citizen.Wait(0)
			end
		end)
	end
end

RegisterCommand('updatelightbar', function(source, args, raw)
	if lightBarsAllowed then
		lightBarData = LoadData()
		LoadLights(lightBarData)
		if lightBarData == nil then
			lightBarData = {}
		end
		ToggleMenu()
	end
end)

RegisterCommand('lightbar', function (source, args, raw)

	if lightBarsAllowed and UpdateOnscreenKeyboard() ~= 0 then
		lightBarData = {}
		ToggleMenu()
	end
end)

RegisterKeyMapping('lightbar', 'Lightbar settings for unmarked vehicles', 'keyboard', '')