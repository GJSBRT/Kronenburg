--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
local HasAlreadyEnteredMarker, LastZone, CurrentAction, CurrentActionMsg, CurrentActionData = nil, nil, nil, '', {}

function OpenAmbulanceActionsMenu()
	local elements = {
		{label = _U('cloakroom'), value = 'cloakroom'}
	}

	if Config.EnablePlayerManagement and ESX.PlayerData.job.grade_name == 'boss' then
		table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ambulance_actions',
	{
		title		= _U('ambulance'),
		align		= 'top-right',
		elements	= elements
	}, function(data, menu)
		if data.current.value == 'cloakroom' then
			OpenCloakroomMenu()
		elseif data.current.value == 'boss_actions' then
			TriggerEvent('esx_society:openBossMenu', 'ambulance', function(data, menu)
				menu.close()
			end, {wash = false})
		end
	end, function(data, menu)
		menu.close()

		CurrentAction		= 'ambulance_actions_menu'
		CurrentActionMsg	= _U('open_menu')
		CurrentActionData	= {}
	end)
end

function OpenMobileAmbulanceActionsMenu()

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mobile_ambulance_actions',
	{
		title		= _U('ambulance'),
		align		= 'top-right',
		elements	= {
			{label = _U('ems_menu'), value = 'citizen_interaction'}
		}
	},
		function(data, menu)
		if data.current.value == 'citizen_interaction' then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction',
			{
				title		= _U('ems_menu_title'),
				align		= 'top-right',
				elements	= {
					{label = _U('ems_menu_revive'), value = 'revive'},
					{label = _U('ems_menu_small'), value = 'small'},
					{label = _U('ems_menu_big'), value = 'big'},
					--{label = "Controleer Pols", value = 'check'},
					{label = "Brancard Pakken", value = 'getbrancard'},
					{label = "Brancard Verwijderen", value = 'removebrancard'},
					{label = "Zorgverzekering", value = 'healthcare'}

				}
			}, function(data, menu)

				if IsBusy then return end

				if data.current.value == 'getbrancard' then
					ExecuteCommand("brancard")
				elseif data.current.value == 'removebrancard' then
					ExecuteCommand("delbrancard")
				end

				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

				if closestPlayer == -1 or closestDistance > 3.0 then
					
				else

					if data.current.value == 'revive' then

						ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
							if quantity > 0 then
								local closestPlayerPed = GetPlayerPed(closestPlayer)

								if IsPedDeadOrDying(closestPlayerPed, 1) then
									local playerPed = PlayerPedId()

									IsBusy = true
                                                                                ESX.ShowNotification(_U('revive_inprogress'))
										local lib, anim = 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest'

										for i=1, 15, 1 do
											Citizen.Wait(900)

											ESX.Streaming.RequestAnimDict(lib, function()
												TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
												RemoveAnimDict(lib)
											end)
										end

									TriggerServerEvent('esx_ambulancejob:removeItem', 'medikit')
									TriggerServerEvent('esx_ambulancejob:revive', GetPlayerServerId(closestPlayer), securityToken)
									IsBusy = false

									-- Show revive award?
									if Config.ReviveReward > 0 then
										ESX.ShowNotification(_U('revive_complete_award', GetPlayerName(closestPlayer), Config.ReviveReward))
									else
										ESX.ShowNotification(_U('revive_complete', GetPlayerName(closestPlayer)))
									end
								else
									ESX.ShowNotification(_U('player_not_unconscious'))
								end
							else
								ESX.ShowNotification(_U('not_enough_medikit'))
							end
						end, 'medikit')

					elseif data.current.value == 'billing' then
						if closestPlayer == -1 or closestDistance > 3.0 then
							ESX.ShowNotification(_U('no_players_nearby'))
						else
							OpenFineMenu(closestPlayer)
						end
					
					

					elseif data.current.value == 'small' then

						ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
							if quantity > 0 then
								local closestPlayerPed = GetPlayerPed(closestPlayer)
								local health = GetEntityHealth(closestPlayerPed)

								if health > 0 then
									local playerPed = PlayerPedId()

									IsBusy = true
									ESX.ShowNotification(_U('heal_inprogress'))
									TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
									Citizen.Wait(10000)
									ClearPedTasks(playerPed)

									TriggerServerEvent('esx_ambulancejob:removeItem', 'bandage')
									TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'small')
									ESX.ShowNotification(_U('heal_complete', GetPlayerName(closestPlayer)))
									IsBusy = false
								else
									ESX.ShowNotification(_U('player_not_conscious'))
								end
							else
								ESX.ShowNotification(_U('not_enough_bandage'))
							end
						end, 'bandage')

					elseif data.current.value == 'big' then

						ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
							if quantity > 0 then
								local closestPlayerPed = GetPlayerPed(closestPlayer)
								local health = GetEntityHealth(closestPlayerPed)

								if health > 0 then
									local playerPed = PlayerPedId()

									IsBusy = true
									ESX.ShowNotification(_U('heal_inprogress'))
									TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
									Citizen.Wait(10000)
									ClearPedTasks(playerPed)

									TriggerServerEvent('esx_ambulancejob:removeItem', 'medikit')
									TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'big')
									ESX.ShowNotification(_U('heal_complete', GetPlayerName(closestPlayer)))
									IsBusy = false
								else
									ESX.ShowNotification(_U('player_not_conscious'))
								end
							else
								ESX.ShowNotification(_U('not_enough_medikit'))
							end
						end, 'medikit')

					elseif data.current.value == 'put_in_vehicle' then
						TriggerServerEvent('esx_ambulancejob:putInVehicle', GetPlayerServerId(closestPlayer))
					elseif data.current.value == 'take_pulse' then
						if closestDistance < 10.0 then
							TriggerServerEvent('medSystem:request', GetPlayerServerId(closestPlayer))
						end
					elseif data.current.value == 'check' then
						target = GetPlayerServerId(closestPlayer)
						TriggerServerEvent('medSystem:check', target)
					elseif data.current.value == 'healthcare' then
						OpenHealthCareActionsMenu()
					end
					
					
				end
			end, function(data, menu)
				menu.close()
			end)
		end

	end, function(data, menu)
		menu.close()
	end)
end

--------- ZORGPAS

RegisterNetEvent('esx_ambulancejob:client:betaalzorgpas')
AddEventHandler('esx_ambulancejob:client:betaalzorgpas', function()
    ESX.TriggerServerCallback('esx_license:checkLicense', function(hasDriversLicense)
        if hasDriversLicense then
            TriggerServerEvent('esx_ambulancejob:server:betaalzorgpas')
        end
    end, GetPlayerServerId(PlayerId()), 'healthcare')
end)

function OpenHealthCareActionsMenu()
    local elements = {
        {label = 'Bekijk zorgpas', value = 'check_healthcare'},
        {label = 'Activeer zorgverzekering', value = 'activate_healthcare'},
        {label = 'Deactiveer zorgverzekering', value = 'deactivate_healthcare'}
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'healthcare_actions', {
        title    = _U('ambulance'),
        align    = 'top-right',
        elements = elements
    }, function(data, menu)
        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer == -1 or closestDistance > 1.0 then
                    ESX.ShowNotification(_U('no_players'))
                else
                    if data.current.value == 'check_healthcare' then
                        ESX.TriggerServerCallback('esx_license:checkLicense', function(hasDriversLicense)
                            if hasDriversLicense then
                                --ESX.ShowNotification(('%s heeft een zorgverzekering'):format(GetPlayerName(closestPlayer)))
                                exports['mythic_notify']:DoHudText('success', ('%s heeft een zorgverzekering'):format(GetPlayerName(closestPlayer)))
                            else
                                --ESX.ShowNotification(('%s heeft geen zorgverzekering'):format(GetPlayerName(closestPlayer)))
                                exports['mythic_notify']:DoHudText('error', ('%s heeft geen zorgverzekering'):format(GetPlayerName(closestPlayer)))
                            end
                        end, GetPlayerServerId(closestPlayer), 'healthcare')
                    elseif data.current.value == 'deactivate_healthcare' then
                        --ESX.ShowNotification(('Je hebt de zorgverzekering van %s gedeactiveerd'):format(GetPlayerName(closestPlayer)))
                        exports['mythic_notify']:DoHudText('error', ('Je hebt de zorgverzekering van %s gedeactiveerd'):format(GetPlayerName(closestPlayer)))
                        TriggerServerEvent('esx_license:removeLicense', GetPlayerServerId(closestPlayer), 'healthcare')

                    elseif data.current.value == 'activate_healthcare' then
                        --ESX.ShowNotification(('Je hebt de zorgverzekering van %s geactiveerd'):format(GetPlayerName(closestPlayer)))
                        exports['mythic_notify']:DoHudText('success', ('Je hebt de zorgverzekering van %s geactiveerd'):format(GetPlayerName(closestPlayer)))
                        TriggerServerEvent('esx_license:addLicense', GetPlayerServerId(closestPlayer), 'healthcare')
                    end
                end
    end, function(data, menu)
        menu.close()
    end)
end

--------- ZORGPAS


RegisterCommand('spawnstr', function() 
	if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' then	
	local str = Citizen.InvokeNative(0x509D5878EB39E842,GetHashKey('prop_ld_binbag_01'), GetEntityCoords(PlayerPedId()), true)
	end
end, false)

--Brancard
-- Coded by Xerxes468893#0001 (Peter Greek) For BCDOJRP, released to the public

strNames = { 'v_med_bed1', 'v_med_bed2','prop_ld_binbag_01'} -- Add more model strings here if you'd like
strHashes = {}
animDict = 'missfbi5ig_0'
animName = 'lyinginpain_loop_steve'
isOnstr = false
local strTable = {}
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

Citizen.CreateThread(function()
    for k,v in ipairs(strNames) do
        table.insert( strHashes, GetHashKey(v))
    end
end) 

function VehicleInFront()
  local player = PlayerPedId()
    local pos = GetEntityCoords(player)
    local entityWorld = GetOffsetFromEntityInWorldCoords(player, 0.0, 2.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 30, player, 0)
    local _, _, _, _, result = GetRaycastResult(rayHandle)
    return result
end

local open = false
RegisterNetEvent("ARPF-EMS:opendoors")
AddEventHandler("ARPF-EMS:opendoors", function()
veh = VehicleInFront()
if open == false then
    open = true
    SetVehicleDoorOpen(veh, 2, false, false)
    Citizen.Wait(1000)
    SetVehicleDoorOpen(veh, 3, false, false)
elseif open == true then
    open = false
    SetVehicleDoorShut(veh, 2, false)
    SetVehicleDoorShut(veh, 3, false)
end
end)

local incar = false
RegisterNetEvent("ARPF-EMS:togglestrincar")
AddEventHandler("ARPF-EMS:togglestrincar", function()
	
	local veh = VehicleInFront()
    local ped = GetPlayerPed(-1)
    local pedid = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
    local closestObject = GetClosestObjectOfType(pedCoords, 3.0, GetHashKey("prop_ld_binbag_01"), false)
    if IsEntityAttachedToAnyVehicle(closestObject) then
        incar = true
    elseif IsEntityAttachedToEntity(closestObject, veh) then 
    	incar = true
    end
    if incar == false then 
        StreachertoCar()
        Citizen.Wait(100)
        ClearPedTasksImmediately(pedid)
        incar = true
    elseif incar == true then
        incar = false
        StretcheroutCar()
        Citizen.Wait(100)
        ClearPedTasksImmediately(pedid)
    end
end)



function StreachertoCar()
    local veh = VehicleInFront()
    local ped = GetPlayerPed(-1)
    local pedCoords = GetEntityCoords(ped)
    local closestObject = GetClosestObjectOfType(pedCoords, 3.0, GetHashKey("prop_ld_binbag_01"), false)
    if DoesEntityExist(closestObject) then
        if GetVehiclePedIsIn(ped, false) == 0 and DoesEntityExist(veh) and IsEntityAVehicle(veh) then
            AttachEntityToEntity(closestObject, veh, 0.0, -0.2, -1.7, -0.7, 0.0, 0.0, 180.0, false, false, true, false, 2, true)
            FreezeEntityPosition(closestObject, true)
        else
            print("car dose not exist ")
        end
    else
        print("nothing around here dumb ass")
    end
end

function StretcheroutCar()
    local veh = VehicleInFront()
    local ped = GetPlayerPed(-1)
    local pedCoords = GetEntityCoords(ped)
    local closestObject = GetClosestObjectOfType(pedCoords, 3.0, GetHashKey("prop_ld_binbag_01"), false)
    if DoesEntityExist(closestObject) then
        if GetVehiclePedIsIn(playerPed, false) == 0 and DoesEntityExist(veh) and IsEntityAVehicle(veh) then
            DetachEntity(closestObject, true, true)
            FreezeEntityPosition(closestObject, false)
            local coords = GetEntityCoords(closestObject, false)
        SetEntityCoords(closestObject, coords.x-3,coords.y,coords.z)
        PlaceObjectOnGroundProperly(closestObject)
        else
            print("dosenot exist car")
        end
    else
        print("nothing around here dumb ass")
    end
end
-----------------------------------------------------------------------------------------------------------------------


RegisterCommand('delmaca', function()
	local wheelchair = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 10.0, GetHashKey('prop_ld_binbag_01'))
	if DoesEntityExist(wheelchair) then
		DeleteEntity(wheelchair)
	end
end, false)


RegisterNetEvent("ARPF-EMS:stretcherSync")
AddEventHandler("ARPF-EMS:stretcherSync", function(tableUpdate)
	strTable = tableUpdate
end)

local changed = false
Citizen.CreateThreadNow(function()
	while true do 
		Citizen.Wait(100)
		TableID = 0 
		local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        local closestObject = GetClosestObjectOfType(pedCoords, 10.0, GetHashKey("prop_ld_binbag_01"), false)
        if DoesEntityExist(closestObject) then
            local strCoords = GetEntityCoords(closestObject)
            for i,v in ipairs(strTable) do
			 	local strobj = v['obj']
				if strobj == closestObject then
					TableID = i 
				elseif strobj ~= closestObject and TableID <= 0 then 
					TableID = -1 -- this means that the new stretcher is not in the table and after checking all of the stretches it will then add the new one to the table and then send it to the server to then update all the clients on the server
					print("not the right stretcher")
				end  
			end
			if TableID == -1 then -- add to server table 
				local attachedToWhat = GetEntityAttachedTo(closestObject) and not nil or "none" 
				local state = 2
				local tableNum = -1
				local what = attachedToWhat
				local sync = false
				TriggerServerEvent("ARPF-EMS:server:stretcherSync",state,tableNum,what,sync)
			elseif TableID > 0 then -- check if the stretcher has a changed state
			end 

			for k,u in pairs(strTable) do
        		local strobj = strTable[k]['obj']
        		--local strobj = u['obj'] -- one of these are faster 
        		if DoesEntityExist(strobj) then
        		 	local pedCoords = GetEntityCoords(ped)
					local strCoords = GetEntityCoords(closestObject)
					local distances = GetDistanceBetweenCoords(pedCoords.x, pedCoords.y, pedCoords.z, strCoords.x, strCoords.y, strCoords.z, true)
        			local attachedToWhat = GetEntityAttachedTo(strobj) and not nil or "none"
			        if 	distances < 5 then 
			        	if IsEntityAttachedToAnyPed(strobj) or IsEntityAttachedToAnyVehicle(strobj) or IsEntityAttachedToAnyObject(strobj) then 
							if attachedToWhat ~= v['to'] then -- even if somehow v['to'] == nil then it will change to "none"
								v['to'] = attachedToWhat
								local changed = true
							end
						else
							if attachedToWhat == v['to'] then 
								local change = false
							else 
								print(attachedToWhat)
								print("this fucked up if it gets here and nothing is shown")
							end
						end
					end
	        	else
	        	-- insert deleting into the deleting command TriggerServerEvent("ARPF-EMS:server:stretcherSync",state,tableNum,what,sync)	
	        	end
        	end  
        end
	end
end)

RegisterNetEvent("ARPF-EMS:pushstreacherss")
AddEventHandler("ARPF-EMS:pushstreacherss", function()
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        local closestObject = GetClosestObjectOfType(pedCoords, 3.0, GetHashKey("prop_ld_binbag_01"), false)
        if DoesEntityExist(closestObject) then
            local strCoords = GetEntityCoords(closestObject)
            local strVecForward = GetEntityForwardVector(closestObject)
            local sitCoords = (strCoords + strVecForward * - 0.5)
            local pickupCoords = (strCoords + strVecForward * 0.3)
            if GetDistanceBetweenCoords(pedCoords, pickupCoords, true) <= 2.0 then
                PickUp(closestObject)
            end
        end 
end)


RegisterNetEvent("ARPF-EMS:getintostretcher")
AddEventHandler("ARPF-EMS:getintostretcher", function()
 local pP = GetPlayerPed(-1)
 local ped = PlayerPedId()
 local pedCoords = GetEntityCoords(ped)
 local closestObject = GetClosestObjectOfType(pedCoords, 3.0, GetHashKey("prop_ld_binbag_01"), false)
    if DoesEntityExist(closestObject) then
     local strCoords = GetEntityCoords(closestObject)
     local strVecForward = GetEntityForwardVector(closestObject)
     local sitCoords = (strCoords + strVecForward * - 0.5)
     local pickupCoords = (strCoords + strVecForward * 0.3)
        if GetDistanceBetweenCoords(pedCoords, sitCoords, true) <= 2.0 then
            TriggerEvent('sit', closestObject) 
        end
    end
end)


function revivePed(ped)
  local playerPos = GetEntityCoords(ped, true)

  NetworkResurrectLocalPlayer(playerPos, true, true, false)
  SetPlayerInvincible(ped, false)
  ClearPedBloodDamage(ped)
end

-- Anim Taken from bed script from FFourms
local inBedDicts = "anim@gangops@morgue@table@"
local inBedAnims = "ko_front"
RegisterNetEvent('sit')
AddEventHandler('sit', function(strObject)
    local closestPlayer, closestPlayerDist = GetClosestPlayer()
    local playPed = GetPlayerPed(-1)
    if closestPlayer ~= nil and closestPlayerDist <= 1.5 then
        if IsEntityPlayingAnim(GetPlayerPed(closestPlayer), inBedDicts, inBedAnims, 3) then
            ShowNotification("Somebody is already using the Stretcher!")
            return
        end
    end

    LoadAnim(inBedDicts)
  if IsPedDeadOrDying(playPed) then
    revivePed(playPed)
    AttachEntityToEntity(PlayerPedId(), strObject, 0, 0, 0.0, 1.6, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
    local heading = GetEntityHeading(strObject)
    wasdead = true
    while IsEntityAttachedToEntity(PlayerPedId(), strObject) do
        Citizen.Wait(5)

        if IsPedDeadOrDying(PlayerPedId()) then
            DetachEntity(PlayerPedId(), true, true)
        end

        if not IsEntityPlayingAnim(PlayerPedId(), inBedDicts, inBedAnims, 3) then
            TaskPlayAnim(PlayerPedId(), inBedDicts, inBedAnims, 8.0, 8.0, -1, 69, 1, false, false, false)
        end

        if IsControlPressed(0, 32) then
            PlaceObjectOnGroundProperly(strObject)
        end
        if IsControlJustPressed(0, 73) then
            TriggerEvent("unsit", strObject)
        end
    end 
  elseif not IsPedDeadOrDying(playPed) then
    AttachEntityToEntity(PlayerPedId(), strObject, 0, 0, 0.0, 1.6, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
    local heading = GetEntityHeading(strObject)
    wasdead = false
    while IsEntityAttachedToEntity(PlayerPedId(), strObject) do
        Citizen.Wait(5)

        if IsPedDeadOrDying(PlayerPedId()) then
            DetachEntity(PlayerPedId(), true, true)
        end

        if not IsEntityPlayingAnim(PlayerPedId(), inBedDicts, inBedAnims, 3) then
            TaskPlayAnim(PlayerPedId(), inBedDicts, inBedAnims, 8.0, 8.0, -1, 69, 1, false, false, false)
        end

        if IsControlPressed(0, 32) then
            PlaceObjectOnGroundProperly(strObject)
        elseif IsControlJustPressed(0, 73) then
          TriggerEvent("unsit", strObject)
        end
    end 
  end      
end)


RegisterNetEvent('unsit')
AddEventHandler('unsit', function(strObject)   
    if wasdead == true then
        pedss = GetPlayerPed(-1)
        DetachEntity(PlayerPedId(), true, true)
        local x, y, z = table.unpack(GetEntityCoords(strObject) + GetEntityForwardVector(strObject) * - 0.7)
        SetEntityCoords(PlayerPedId(), x,y,z)
        hels = GetEntityHealth(pedss)
        SetEntityHealth(pedss, hels -200)
        wasdead = false
    elseif wasdead == false then
        DetachEntity(PlayerPedId(), true, true)
        local x, y, z = table.unpack(GetEntityCoords(strObject) + GetEntityForwardVector(strObject) * - 0.7)
        SetEntityCoords(PlayerPedId(), x,y,z)
    end
end)

-------------------------------- FUNCTIONS ----------------------------------------------------------------------------

function PickUp(strObject)
    local closestPlayer, closestPlayerDist = GetClosestPlayer()

    if closestPlayer ~= nil and closestPlayerDist <= 1.5 then
        if IsEntityPlayingAnim(GetPlayerPed(closestPlayer), 'anim@heists@box_carry@', 'idle', 3) then
            ShowNotification("Somebody is already pushing the Stretcher!")
            return
        end
    end

    NetworkRequestControlOfEntity(strObject)


    LoadAnim("anim@heists@box_carry@")
    local pedid = PlayerPedId()
    AttachEntityToEntity(strObject, pedid, GetPedBoneIndex(PlayerPedId(),  28422), 0.0, -1.0, -1.03, 195.0, 180.0, 180.0, 0.0, false, false, true, false, 2, true)
    while IsEntityAttachedToEntity(strObject, pedid) do
        Citizen.Wait(5)

        if not IsEntityPlayingAnim(pedid, 'anim@heists@box_carry@', 'idle', 3) then
            TaskPlayAnim(pedid, 'anim@heists@box_carry@', 'idle', 8.0, 8.0, -1, 50, 0, false, false, false)
        end

        if IsPedDeadOrDying(pedid) or IsControlJustPressed(0, 73) then
            DetachEntity(strObject, true, true)
            ClearPedTasksImmediately(pedid)
        end
    end
end

function DrawText3Ds(coords, text, scale)
    local x,y,z = coords.x, coords.y, coords.z
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

    SetTextScale(scale, scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(1)
    SetTextColour(255, 255, 255, 215)

    AddTextComponentString(text)
    DrawText(_x, _y)

    local factor = (string.len(text)) / 370

    DrawRect(_x, _y + 0.0150, 0.030 + factor, 0.025, 41, 11, 41, 100)
end

function GetPlayers()
    local players = {}

    for i = 0, 256 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end

function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)
    
    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = Vdist(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"])
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
    
    return closestPlayer, closestDistance
end

function LoadAnim(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        
        Citizen.Wait(7)
    end
end

function LoadModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        
        Citizen.Wait(7)
    end
end

function ShowNotification(msg)
    SetNotificationTextEntry('STRING')
    AddTextComponentSubstringWebsite(msg)
    DrawNotification(false, true)
end

AddEventHandler('esx_ambulancejob:hasEnteredMarker', function(zone)
	if zone == 'HospitalInteriorEntering1' then
		TeleportFadeEffect(PlayerPedId(), Config.Zones.HospitalInteriorInside1.Pos)
	elseif zone == 'HospitalInteriorExit1' then
		TeleportFadeEffect(PlayerPedId(), Config.Zones.HospitalInteriorOutside1.Pos)
	elseif zone == 'HospitalInteriorEntering3' then
		TeleportFadeEffect(PlayerPedId(), Config.Zones.HospitalInteriorMannetjeMan.Pos)
	elseif zone == 'HospitalInteriorExit3' then
		TeleportFadeEffect(PlayerPedId(), Config.Zones.HospitalInteriorOutside2.Pos)
	elseif zone == 'HospitalInteriorEntering2' then
		local heli = Config.HelicopterSpawner

		if not IsAnyVehicleNearPoint(heli.SpawnPoint.x, heli.SpawnPoint.y, heli.SpawnPoint.z, 3.0) and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' then
			ESX.Game.SpawnVehicle('trauma', {
				x = heli.SpawnPoint.x,
				y = heli.SpawnPoint.y,
				z = heli.SpawnPoint.z
			}, heli.Heading, function(vehicle)
				TriggerServerEvent("pepperspray:addVehiclePlate", GetVehicleNumberPlateText(vehicle))
				Wait(200)
				SetVehicleModKit(vehicle, 0)
				SetVehicleLivery(vehicle, 1)
			end)
		end
		TeleportFadeEffect(PlayerPedId(), Config.Zones.HospitalInteriorInside2.Pos)
	elseif zone == 'HospitalInteriorExit2' then
		TeleportFadeEffect(PlayerPedId(), Config.Zones.HospitalInteriorOutside2.Pos)
	elseif zone == 'ParkingDoorGoOutInside' then
		TeleportFadeEffect(PlayerPedId(), Config.Zones.ParkingDoorGoOutOutside.Pos)
	elseif zone == 'ParkingDoorGoInOutside' then
		TeleportFadeEffect(PlayerPedId(), Config.Zones.ParkingDoorGoInInside.Pos)
	elseif zone == 'StairsGoTopBottom' then
		CurrentAction		= 'fast_travel_goto_top'
		CurrentActionMsg	= _U('fast_travel')
		CurrentActionData	= {pos = Config.Zones.StairsGoTopTop.Pos}
	elseif zone == 'StairsGoBottomTop' then
		CurrentAction		= 'fast_travel_goto_bottom'
		CurrentActionMsg	= _U('fast_travel')
		CurrentActionData	= {pos = Config.Zones.StairsGoBottomBottom.Pos}
	elseif zone == 'AmbulanceActions' or zone == 'AmbulanceActions2' then
		CurrentAction		= 'ambulance_actions_menu'
		CurrentActionMsg	= _U('open_menu')
		CurrentActionData	= {}
	elseif zone == 'VehicleSpawner' then
		CurrentAction		= 'vehicle_spawner_menu'
		CurrentActionMsg	= _U('veh_spawn')
		CurrentActionData	= {}
	elseif zone == 'VehicleSpawner2' then
		CurrentAction		= 'vehicle_spawner_menu2'
		CurrentActionMsg	= _U('veh_spawn')
		CurrentActionData	= {}
	elseif zone == 'Pharmacy' or zone == 'Pharmacy2' then
		CurrentAction		= 'pharmacy'
		CurrentActionMsg	= _U('open_pharmacy')
		CurrentActionData	= {}
	elseif zone == 'VehicleDeleter' or zone == 'VehicleDeleter2' then
		local playerPed = PlayerPedId()
		local coords	= GetEntityCoords(playerPed)

		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle, distance = ESX.Game.GetClosestVehicle({
				x = coords.x,
				y = coords.y,
				z = coords.z
			})

			if distance ~= -1 and distance <= 1.0 then
				CurrentAction		= 'delete_vehicle'
				CurrentActionMsg	= _U('store_veh')
				CurrentActionData	= {vehicle = vehicle}
			end
		end
	end
end)

function FastTravel(pos)
	TeleportFadeEffect(PlayerPedId(), pos)
end

AddEventHandler('esx_ambulancejob:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

-- Create blips2
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.Blip2.Pos.x, Config.Blip2.Pos.y, Config.Blip2.Pos.z)

	SetBlipSprite(blip, Config.Blip2.Sprite)
	SetBlipDisplay(blip, Config.Blip2.Display)
	SetBlipScale(blip, Config.Blip2.Scale)
	SetBlipColour(blip, Config.Blip2.Colour)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(_U('hospital'))
	EndTextCommandSetBlipName(blip)
end)

-- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(7)

		local coords = GetEntityCoords(PlayerPedId())
		for k,v in pairs(Config.Zones) do
			if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
				if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' then
					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
				end
			end
		end
	end
end)

-- Activate menu when player is inside marker
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(7)

		local coords		= GetEntityCoords(PlayerPedId())
		local isInMarker	= false
		local currentZone	= nil

		for k,v in pairs(Config.Zones) do
			if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' then
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.MarkerSize.x) then
					isInMarker	= true
					currentZone = k
				end
			end
		end

		if isInMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
			lastZone				= currentZone
			TriggerEvent('esx_ambulancejob:hasEnteredMarker', currentZone)
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('esx_ambulancejob:hasExitedMarker', lastZone)
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(7)

		if CurrentAction ~= nil then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, Keys['E']) and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' then

				if CurrentAction == 'ambulance_actions_menu' then
					OpenAmbulanceActionsMenu()
				elseif CurrentAction == 'vehicle_spawner_menu' then
					OpenVehicleSpawnerMenu()
				elseif CurrentAction == 'vehicle_spawner_menu2' then
					OpenVehicleSpawnerMenu2()
				elseif CurrentAction == 'pharmacy' then
					OpenPharmacyMenu()
				elseif CurrentAction == 'fast_travel_goto_top' or CurrentAction == 'fast_travel_goto_bottom' then
					FastTravel(CurrentActionData.pos)
				elseif CurrentAction == 'delete_vehicle' then
					if Config.EnableSocietyOwnedVehicles then
						local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
						TriggerServerEvent('esx_society:putVehicleInGarage', 'ambulance', vehicleProps)
					end
					ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
				end

				CurrentAction = nil

			end

		end

		if IsControlJustReleased(0, Keys['F6']) and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' and not IsDead then
			OpenMobileAmbulanceActionsMenu()
		end
	end
end)

RegisterNetEvent('esx_ambulancejob:putInVehicle')
AddEventHandler('esx_ambulancejob:putInVehicle', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)

		if DoesEntityExist(vehicle) then
			local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
			local freeSeat = nil

			for i=maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end

			if freeSeat ~= nil then
				TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
			end
		end
	end
end)

function setUniform(job, playerPed)
  TriggerEvent('skinchanger:getSkin', function(skin)

    if skin.sex == 0 then
      if Config.Uniforms[job].male ~= nil then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].male)
      else
        ESX.ShowNotification(_U('no_outfit'))
      end
    else
      if Config.Uniforms[job].female ~= nil then
        TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].female)
      else
        ESX.ShowNotification(_U('no_outfit'))
      end
    end

  end)
end

function cleanPlayer(playerPed)
	SetPedArmour(playerPed, 0)
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
	ResetPedMovementClipset(playerPed, 0)
end


function OpenCloakroomMenu()

  local playerPed = PlayerPedId()

  local elements = {
	{ label = 'Burger kleding', value = 'citizen_wear' },
	--{ label = 'Ambulance Oud Kort', value = 'ambulance_oud_kort' },
	{ label = 'Ambulance Oud Lang', value = 'ambulance_oud_lang' },
	{ label = 'Ambulance Nieuw Kort', value = 'ambulance_nieuw_kort' },
	{ label = 'Ambulance Nieuw Lang', value = 'ambulance_nieuw_lang' },
	{ label = 'Ambulance MMT', value = 'ambulance_mmt' },
	--{ label = 'Ambulance OVDG', value = 'ambulance_ovdg' },
	--{ label = 'Ambulance Tas', value = 'ambulance_tas' }
   }

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'cloakroom',
    {
      title    = _U('cloakroom'),
      align    = 'top-right',
      elements = elements,
    },
    function(data, menu)

      cleanPlayer(playerPed)

      if data.current.value == 'citizen_wear' then
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
          TriggerEvent('skinchanger:loadSkin', skin)
		  RemoveAllPedWeapons(playerPed, true)
		  exports["rp-radio"]:RemovePlayerAccessToFrequencies(1, 2, 3, 5)
		  exports["rp-radio"]:SetRadio(false)
        end)
      end

      if
	  data.current.value == 'ambulance_oud_kort' or
	  data.current.value == 'ambulance_oud_lang' or
	  data.current.value == 'ambulance_nieuw_kort' or
	  data.current.value == 'ambulance_nieuw_lang' or
	  data.current.value == 'ambulance_mmt' or
	  data.current.value == 'ambulance_ovdg'
      then
		setUniform(data.current.value, playerPed)
		exports["rp-radio"]:GivePlayerAccessToFrequencies(5)
		exports["rp-radio"]:SetRadio(true)
      end

      if
        data.current.value == 'sheriff_wear_freemode' or
        data.current.value == 'lieutenant_wear_freemode' or
        data.current.value == 'commandant_wear_freemode'
      then
        local model = nil
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
          if skin.sex == 0 then
            model = GetHashKey(data.current.maleModel)
          else
            model = GetHashKey(data.current.femaleModel)
          end
        end)
      
        RequestModel(model)
        while not HasModelLoaded(model) do
          RequestModel(model)
          Citizen.Wait(7)
        end
      
        SetPlayerModel(PlayerId(), model)
        SetModelAsNoLongerNeeded(model)
      end

		CurrentAction		= 'ambulance_actions_menu'
		CurrentActionMsg	= _U('open_menu')
		CurrentActionData	= {}
	end, function(data, menu)
		menu.close()
	end)
end

function OpenVehicleSpawnerMenu()

	ESX.UI.Menu.CloseAll()

	if Config.EnableSocietyOwnedVehicles then

		local elements = {}

		ESX.TriggerServerCallback('esx_society:getVehiclesInGarage', function(vehicles)
			for i=1, #vehicles, 1 do
				table.insert(elements, {
					label = GetDisplayNameFromVehicleModel(vehicles[i].model) .. ' [' .. vehicles[i].plate .. ']',
					value = vehicles[i]
				})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner',
			{
				title		= _U('veh_menu'),
				align		= 'top-right',
				elements = elements
			}, function(data, menu)
				menu.close()

				local vehicleProps = data.current.value
				ESX.Game.SpawnVehicle(vehicleProps.model, Config.Zones.VehicleSpawnPoint.Pos, 340.02, function(vehicle)
					TriggerServerEvent("pepperspray:addVehiclePlate", GetVehicleNumberPlateText(vehicle))
					Wait(200)
					ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
					local playerPed = PlayerPedId()
					TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
					SetVehicleCustomPrimaryColour(vehicle, 255, 255, 255)
					SetVehicleNumberPlateText(vehicle, "AMBU")
				end)
				TriggerServerEvent('esx_society:removeVehicleFromGarage', 'ambulance', vehicleProps)
			end, function(data, menu)
				menu.close()
				CurrentAction		= 'vehicle_spawner_menu'
				CurrentActionMsg	= _U('veh_spawn')
				CurrentActionData	= {}
			end)
		end, 'ambulance')

	else -- not society vehicles

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner',
		{
			title		= _U('veh_menu'),
			align		= 'top-right',
			elements	= Config.AuthorizedVehicles
		}, function(data, menu)
			menu.close()

			ESX.Game.SpawnVehicle(data.current.model, Config.Zones.VehicleSpawnPoint.Pos, 340.02, function(vehicle)
				TriggerServerEvent("pepperspray:addVehiclePlate", "AMBU")
				Wait(200)
				local playerPed = PlayerPedId()
				TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
				SetVehicleCustomPrimaryColour(vehicle, 255, 255, 255)
				SetVehicleNumberPlateText(vehicle, "AMBU")
			end)
		end, function(data, menu)
			menu.close()
			CurrentAction		= 'vehicle_spawner_menu'
			CurrentActionMsg	= _U('veh_spawn')
			CurrentActionData	= {}
		end)

	end
end

function OpenVehicleSpawnerMenu2()

	ESX.UI.Menu.CloseAll()

	if Config.EnableSocietyOwnedVehicles then

		local elements = {}

		ESX.TriggerServerCallback('esx_society:getVehiclesInGarage', function(vehicles)
			for i=1, #vehicles, 1 do
				table.insert(elements, {
					label = GetDisplayNameFromVehicleModel(vehicles[i].model) .. ' [' .. vehicles[i].plate .. ']',
					value = vehicles[i]
				})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner',
			{
				title		= _U('veh_menu'),
				align		= 'top-right',
				elements = elements
			}, function(data, menu)
				menu.close()

				local vehicleProps = data.current.value
				ESX.Game.SpawnVehicle(vehicleProps.model, Config.Zones.VehicleSpawnPoint2.Pos, 340.02, function(vehicle)
					TriggerServerEvent("pepperspray:addVehiclePlate", "AMBU")
					Wait(200)
					ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
					local playerPed = PlayerPedId()
					TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
					SetVehicleCustomPrimaryColour(vehicle, 255, 255, 255)
					SetVehicleNumberPlateText(vehicle, "AMBU")
				end)
				TriggerServerEvent('esx_society:removeVehicleFromGarage', 'ambulance', vehicleProps)
			end, function(data, menu)
				menu.close()
				CurrentAction		= 'vehicle_spawner_menu'
				CurrentActionMsg	= _U('veh_spawn')
				CurrentActionData	= {}
			end)
		end, 'ambulance')

	else -- not society vehicles

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner',
		{
			title		= _U('veh_menu'),
			align		= 'top-right',
			elements	= Config.AuthorizedVehicles
		}, function(data, menu)
			menu.close()

			ESX.Game.SpawnVehicle(data.current.model, Config.Zones.VehicleSpawnPoint2.Pos, 340.02, function(vehicle)
				local playerPed = PlayerPedId()
				TriggerServerEvent("pepperspray:addVehiclePlate", GetVehicleNumberPlateText(vehicle))
				Wait(200)
				TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			end)
		end, function(data, menu)
			menu.close()
			CurrentAction		= 'vehicle_spawner_menu'
			CurrentActionMsg	= _U('veh_spawn')
			CurrentActionData	= {}
		end)

	end
end

function OpenPharmacyMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'pharmacy', {
		title    = _U('pharmacy_menu_title'),
		align    = 'top-left',
		elements = {
			{label = _U('medikit'), item = 'medikit', type = 'slider', value = 1, min = 1, max = 25},
			{label = _U('bandage'), item = 'bandage', type = 'slider', value = 1, min = 1, max = 50}
	}}, function(data, menu)
		TriggerServerEvent('esx_ambulancejob:giveItem', data.current.item, data.current.value)
	end, function(data, menu)
		menu.close()
	end)
end

function WarpPedInClosestVehicle(ped)
	local coords = GetEntityCoords(ped)

	local vehicle, distance = ESX.Game.GetClosestVehicle({
		x = coords.x,
		y = coords.y,
		z = coords.z
	})

	if distance ~= -1 and distance <= 5.0 then
		local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
		local freeSeat = nil

		for i=maxSeats - 1, 0, -1 do
			if IsVehicleSeatFree(vehicle, i) then
				freeSeat = i
				break
			end
		end

		if freeSeat ~= nil then
			TaskWarpPedIntoVehicle(ped, vehicle, freeSeat)
		end
	else
		ESX.ShowNotification(_U('no_vehicles'))
	end
end

RegisterNetEvent('esx_ambulancejob:heal')
AddEventHandler('esx_ambulancejob:heal', function(healType)
	local playerPed = PlayerPedId()
	local maxHealth = GetEntityMaxHealth(playerPed)

	if healType == 'small' then
		local health = GetEntityHealth(playerPed)
		local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 8))
		SetEntityHealth(playerPed, newHealth)
	elseif healType == 'big' then
		SetEntityHealth(playerPed, maxHealth)
	end

	ESX.ShowNotification(_U('healed'))
end)