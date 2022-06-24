ESX = nil

local car, h
local _wheel, _base, _lights1, _lights2, _arrow1, _arrow2 = nil, nil, nil, nil, nil, nil

local m1a = GetHashKey('vw_prop_vw_luckylight_off')
local m1b = GetHashKey('vw_prop_vw_luckylight_on')
local m2a = GetHashKey('vw_prop_vw_jackpot_off')
local m2b = GetHashKey('vw_prop_vw_jackpot_on')
	
local _wheelPos = Config.WheelPos
local _isRolling = false



Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent(Config.ESX, function(obj) ESX = obj end)
		Citizen.Wait(500)
	end
	ESX.TriggerServerCallback('vns_cs_wheel:server:getVerifyToken', function(token, eventname)
		JeroenNietDoenHAHAHHA = token
		RegisterNetEvent(eventname)
		AddEventHandler(eventname, function(token)
			JeroenNietDoenHAHAHHA = token
		end)
	end)

	RequestScriptAudioBank("DLC_VINEWOOD\\CASINO_GENERAL", false)
	
	ESX.TriggerServerCallback('vns_cs_wheel:getcar', function(_car)
		car = _car
	end)

	local model1 = GetHashKey('vw_prop_vw_luckywheel_02a')
	local model2 = GetHashKey('vw_prop_vw_luckywheel_01a')
	
	if Config.SpawnWheel == false then
		local o = GetClosestObjectOfType(Config.WheelPos.x, Config.WheelPos.y, Config.WheelPos.z, 2.5, GetHashKey('vw_prop_vw_luckywheel_01a'), 0 ,0 , 0)
		local o1 = GetClosestObjectOfType(Config.WheelPos.x, Config.WheelPos.y, Config.WheelPos.z, 4.5, GetHashKey('vw_prop_vw_jackpot_on'), 0 ,0 , 0)
		local o2 = GetClosestObjectOfType(Config.WheelPos.x, Config.WheelPos.y, Config.WheelPos.z, 4.5, GetHashKey('vw_prop_vw_luckylight_on'), 0 ,0 , 0)
		if DoesEntityExist(o) then
			Config.WheelPos.x = GetEntityCoords(o).x
			Config.WheelPos.y = GetEntityCoords(o).y-1.0
			Config.WheelPos.z = GetEntityCoords(o).z+0.2593
			Config.WheelPos.h = GetEntityHeading(o)
			SetModelAsNoLongerNeeded(o, true, true)
			SetEntityCollision(o, false, false)
			SetEntityVisible(o, false)
			
			SetModelAsNoLongerNeeded(o1, true, true)
			SetEntityCollision(o1, false, false)
			SetEntityVisible(o1, false)
			
			SetModelAsNoLongerNeeded(o2, true, true)
			SetEntityCollision(o2, false, false)
			SetEntityVisible(o2, false)
		end
	end
	
	
	Citizen.CreateThread(function()
		RequestModel(model1) while not HasModelLoaded(model1) do Citizen.Wait(0) end
		RequestModel(model2) while not HasModelLoaded(model2) do Citizen.Wait(0) end
		
		RequestModel(m1a) while not HasModelLoaded(m1a) do Citizen.Wait(0) end
		RequestModel(m1b) while not HasModelLoaded(m1b) do Citizen.Wait(0) end
		RequestModel(m2a) while not HasModelLoaded(m2a) do Citizen.Wait(0) end
		RequestModel(m2b) while not HasModelLoaded(m2b) do Citizen.Wait(0) end
		
		ClearArea(Config.WheelPos.x, Config.WheelPos.y, Config.WheelPos.z, 5.0, true, false, false, false)
		
		_wheel = CreateObject(model1, Config.WheelPos.x, Config.WheelPos.y, Config.WheelPos.z, false, false, true)
		SetEntityHeading(_wheel, Config.WheelPos.h)
		SetModelAsNoLongerNeeded(model1)

		local p1 = GetClosestObjectOfType(Config.WheelPos.x, Config.WheelPos.y, Config.WheelPos.z, 4.5, GetHashKey('vw_prop_vw_jackpot_on'), 0 ,0 , 0)
		local p2 = GetClosestObjectOfType(Config.WheelPos.x, Config.WheelPos.y, Config.WheelPos.z, 4.5, GetHashKey('vw_prop_vw_luckylight_on'), 0 ,0 , 0)
		
		_lights1 = CreateObject(m1a, Config.WheelPos.x, Config.WheelPos.y, Config.WheelPos.z+0.35, false, false, true)
		_lights2 = p1
		SetEntityVisible(_lights2, false, 0)
		SetEntityHeading(_lights2, Config.WheelPos.h)
		SetModelAsNoLongerNeeded(_lights2)

		_arrow1 = CreateObject(m2a, Config.WheelPos.x, Config.WheelPos.y, Config.WheelPos.z+0.35, false, false, true)
		_arrow2 = p2
		SetEntityVisible(_arrow2, false, 0)
		SetEntityHeading(_arrow2, Config.WheelPos.h)
		SetModelAsNoLongerNeeded(_arrow2)
		
		h = GetEntityRotation(_wheel)
	end)
end)



local heading = Config.VehiclePos.h
local fixed = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(50)
		
		if Config.SpawnWheel == false then
			local o = GetClosestObjectOfType(Config.WheelPos.x, Config.WheelPos.y, Config.WheelPos.z, 5.5, GetHashKey('vw_prop_vw_luckywheel_01a'), 0 ,0 , 0)
			if DoesEntityExist(o) and GetEntityCoords(o) ~= GetEntityCoords(_wheel) and fixed == false then
				Config.WheelPos.x = GetEntityCoords(o).x
				Config.WheelPos.y = GetEntityCoords(o).y
				Config.WheelPos.z = GetEntityCoords(o).z+0.2593
				Config.WheelPos.h = GetEntityHeading(o)
				SetEntityCoords(_wheel, Config.WheelPos.x, Config.WheelPos.y, Config.WheelPos.z)
				SetEntityCoords(_base, Config.WheelPos.x, Config.WheelPos.y, Config.WheelPos.z)
				
				SetEntityCoords(_lights1, Config.WheelPos.x, Config.WheelPos.y, Config.WheelPos.z)
				SetEntityCoords(_lights2, Config.WheelPos.x, Config.WheelPos.y, Config.WheelPos.z)
				SetEntityCoords(_arrow1, Config.WheelPos.x, Config.WheelPos.y, Config.WheelPos.z)
				SetEntityCoords(_arrow2, Config.WheelPos.x, Config.WheelPos.y, Config.WheelPos.z)
				
				SetEntityHeading(_lights1, Config.WheelPos.h)
				SetEntityHeading(_lights2, Config.WheelPos.h)
				SetEntityHeading(_arrow1, Config.WheelPos.h)
				SetEntityHeading(_arrow2, Config.WheelPos.h)
				SetEntityHeading(_wheel, Config.WheelPos.h)
				SetEntityHeading(_base, Config.WheelPos.h)
				fixed = true
				-- print('aaa')
			end
		end
	
-- 		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Config.VehiclePos.x, Config.VehiclePos.y, Config.VehiclePos.z, true) < 40 then
-- 			if DoesEntityExist(vehicle) == false then
-- 				if car then
-- 					RequestModel(GetHashKey(car))
-- 					while not HasModelLoaded(GetHashKey(car)) do
-- 						Wait(1)
-- 					end
-- 					vehicle = CreateVehicle(GetHashKey(car), Config.VehiclePos.x, Config.VehiclePos.y, Config.VehiclePos.z, heading, false, false)
-- 					FreezeEntityPosition(vehicle, true)
-- 					SetEntityInvincible(vehicle, true)
-- 					SetVehicleColours(vehicle, 62, 159)
-- 					SetEntityCoords(vehicle, Config.VehiclePos.x, Config.VehiclePos.y, Config.VehiclePos.z, false, false, false, true)
-- 					local props = ESX.Game.GetVehicleProperties(vehicle)
-- 					props['wheelColor'] = 147
-- 					props['plate'] = "DIAMONDS"
-- 					ESX.Game.SetVehicleProperties(vehicle, props)
-- 					SetVehicleDirtLevel(vehicle, 0.0)
-- 				end
-- 			else
-- 				SetVehicleDoorsLocked(vehicle, 2)
-- 				if Config.VehicleRot == true then
-- 					SetEntityHeading(vehicle, heading)
-- 					heading = heading+0.05
-- 				end
-- 			end
-- 		else
-- 			Citizen.Wait(1000)
-- 		end
	end
end)

RegisterNetEvent("vns_cs_wheel:syncanim")
AddEventHandler("vns_cs_wheel:syncanim", function()
	doRoll(0)
end)

RegisterNetEvent("vns_cs_wheel:startroll")
AddEventHandler("vns_cs_wheel:startroll", function(s, index, p)
	Citizen.Wait(550)
	SetEntityVisible(_lights1, false, 0)
	SetEntityVisible(_lights2, true, 0)
	win = (index - 1) * 18 + 0.0
	local j = 360
	
	if s == GetPlayerServerId(PlayerId()) then
		PlaySoundFromEntity(-1, "Spin_Start", _wheel, 'dlc_vw_casino_lucky_wheel_sounds', 1, 1)
	end
	
	for i=1,1100,1 do
		
		SetEntityRotation(_wheel, h.x, j+0.0, h.z, 0, false)
		if i < 50 then
			j = j - 1.5
		elseif i < 100 then
			j = j - 2.0
		elseif i < 150 then
			j = j - 2.5
			
			
		elseif i > 1060 then
			j = j - 0.3
		elseif i > 1030 then
			j = j - 0.6
		elseif i > 1000 then
			j = j - 0.9
		elseif i > 970 then
			j = j - 1.2
		elseif i > 940 then
			j = j - 1.5
		elseif i > 910 then
			j = j - 1.8
		elseif i > 880 then
			j = j - 2.1
		elseif i > 850 then
			j = j - 2.4
		elseif i > 820 then
			j = j - 2.7
		else
			j = j - 3.0
		end
		if i == 850 then j = math.random(win-4, win+10) + 0.0 end
		if j > 360 then j = j + 0 end
		if j < 0 then j = j + 360 end
		if i == 900 then
		end
		Citizen.Wait(0)
	end
	Citizen.Wait(300)
	SetEntityVisible(_arrow1, false, 0)
	SetEntityVisible(_arrow2, true, 0)
	local t = true
	
	if s == GetPlayerServerId(PlayerId()) then
		if p.sound == 'car' then
			PlaySoundFromEntity(-1, "Win_Car", _wheel, 'dlc_vw_casino_lucky_wheel_sounds', 1, 1)
		elseif p.sound == 'cash' then
			PlaySoundFromEntity(-1, "Win_Cash", _wheel, 'dlc_vw_casino_lucky_wheel_sounds', 1, 1)
		elseif p.sound == 'chips' then
			PlaySoundFromEntity(-1, "Win_Chips", _wheel, 'dlc_vw_casino_lucky_wheel_sounds', 1, 1)
		elseif p.sound == 'clothes' then
			PlaySoundFromEntity(-1, "Win_Clothes", _wheel, 'dlc_vw_casino_lucky_wheel_sounds', 1, 1)
		elseif p.sound == 'mystery' then
			PlaySoundFromEntity(-1, "Win_Mystery", _wheel, 'dlc_vw_casino_lucky_wheel_sounds', 1, 1)
		else
			PlaySoundFromEntity(-1, "Win", _wheel, 'dlc_vw_casino_lucky_wheel_sounds', 1, 1)
		end
	end
	
	for i=1,15,1 do
		Citizen.Wait(200)
		SetEntityVisible(_lights1, t, 0)
		SetEntityVisible(_arrow2, t, 0)
		t = not t
		SetEntityVisible(_lights2, t, 0)
		SetEntityVisible(_arrow1, t, 0)
		if i == 5 then
			if s == GetPlayerServerId(PlayerId()) then
				TriggerServerEvent('vns_cs_wheel:give', s, p, JeroenNietDoenHAHAHHA)
			end
		end
	end
	Citizen.Wait(1000)
	SetEntityVisible(_lights1, true, 0)
	SetEntityVisible(_lights2, false, 0)
	SetEntityVisible(_arrow1, true, 0)
	SetEntityVisible(_arrow2, false, 0)
	TriggerServerEvent('vns_cs_wheel:stoproll')
end)

RegisterNetEvent("vns_cs_wheel:rollFinished")
AddEventHandler("vns_cs_wheel:rollFinished", function() 
    _isRolling = false
end)

function doRoll(index)
    if not _isRolling then
        _isRolling = true
        local playerPed = PlayerPedId()
        local _lib = 'anim_casino_a@amb@casino@games@lucky7wheel@female'
        if IsPedMale(playerPed) then
            _lib = 'anim_casino_a@amb@casino@games@lucky7wheel@male'
        end
        local lib, anim = _lib, 'enter_right_to_baseidle'
        ESX.Streaming.RequestAnimDict(lib, function()
			local _movePos = GetObjectOffsetFromCoords(GetEntityCoords(_wheel), GetEntityHeading(_wheel),-0.9, -0.8, -1.0)
            TaskGoStraightToCoord(playerPed,  _movePos.x,  _movePos.y,  _movePos.z,  1.0,  3000,  GetEntityHeading(_base),  0.0)
            local _isMoved = false
            while not _isMoved do
                local coords = GetEntityCoords(PlayerPedId())
                if coords.x >= (_movePos.x - 0.01) and coords.x <= (_movePos.x + 0.01) and coords.y >= (_movePos.y - 0.01) and coords.y <= (_movePos.y + 0.01) then
                    _isMoved = true
                end
                Citizen.Wait(0)
            end
			SetEntityHeading(playerPed, GetEntityHeading(_base))
            TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
            while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
				Citizen.Wait(0)
				DisableAllControlActions(0)
            end
            TaskPlayAnim(playerPed, lib, 'enter_to_armraisedidle', 8.0, -8.0, -1, 0, 0, false, false, false)
            while IsEntityPlayingAnim(playerPed, lib, 'enter_to_armraisedidle', 3) do
                Citizen.Wait(0)
                DisableAllControlActions(0)
            end
            TaskPlayAnim(playerPed, lib, 'armraisedidle_to_spinningidle_high', 8.0, -8.0, -1, 0, 0, false, false, false)
        end)
    end
end

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(5)
        local coords = GetEntityCoords(PlayerPedId())
		local Distance = GetDistanceBetweenCoords(coords, _wheelPos.x, _wheelPos.y, _wheelPos.z, true)
        if(Distance < 1.6) and not _isRolling then
            ESX.ShowHelpNotification(_U('spin_wheel'))
            if IsControlJustReleased(0, 38) then
				TriggerServerEvent("vns_cs_wheel:getwheel", JeroenNietDoenHAHAHHA)
            end
		elseif Distance > 60 then
			Citizen.Wait(7500)
        end		
	end
end)