-------------------------------------
------- Created by T1GER#9080 -------
------------------------------------- 
ESX 		= nil
PlayerData 	= {}

-- Police Notify:
isCop = false
local streetName
local _

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
	isCop = IsPlayerJobCop()
	Wait(500)
	spawnPacificSafe()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	isCop = IsPlayerJobCop()
end)

-- [[ ESX SHOW ADVANCED NOTIFICATION ]] --
RegisterNetEvent('t1ger_bankrobbery:ShowAdvancedNotifyESX')
AddEventHandler('t1ger_bankrobbery:ShowAdvancedNotifyESX', function(title, subject, msg, icon, iconType)
	ESX.ShowAdvancedNotification(title, subject, msg, icon, iconType)
	-- If you want to switch ESX.ShowNotification with something else:
	-- 1) Comment out the function
	-- 2) add your own
	
end)

-- [[ ESX SHOW NOTIFICATION ]] --
RegisterNetEvent('t1ger_bankrobbery:ShowNotifyESX')
AddEventHandler('t1ger_bankrobbery:ShowNotifyESX', function(msg)
	ShowNotifyESX(msg)
end)

function ShowNotifyESX(msg)
	ESX.ShowNotification(msg)
	-- If you want to switch ESX.ShowNotification with something else:
	-- 1) Comment out the function
	-- 2) add your own
end

function NotifyPoliceFunction(name)
	TriggerServerEvent('t1ger_bankrobbery:PoliceNotifySV',GetEntityCoords(GetPlayerPed(-1)),streetName,name)
	-- If you want to use your own alert:
	-- 1) Comment out the 'TriggerServerEvent('t1ger_carthief:OutlawNotifySV',GetEntityCoords(PlayerPedId()),streetName)'
	-- 2) replace whatever even you use to trigger your alert.
	
end

function SilentAlarmTrigger(name)
	TriggerServerEvent('t1ger_bankrobbery:SilentAlarmSV',name)
end

RegisterNetEvent('t1ger_bankrobbery:PoliceNotifyCL')
AddEventHandler('t1ger_bankrobbery:PoliceNotifyCL', function(alert)
	print(alert)
	if isCop then
		TriggerEvent('chat:addMessage', { args = {(Lang['dispatch_name']).. alert}})
	end
end)

-- Thread for Police Notify
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(3000)
		local pos = GetEntityCoords(GetPlayerPed(-1), false)
		streetName,_ = GetStreetNameAtCoord(pos.x, pos.y, pos.z)
		streetName = GetStreetNameFromHashKey(streetName)
	end
end)

RegisterNetEvent('t1ger_bankrobbery:PoliceNotifyBlip')
AddEventHandler('t1ger_bankrobbery:PoliceNotifyBlip', function(targetCoords)
	if isCop and Config.AlertBlipShow then 
		local alpha = Config.AlertBlipAlpha
		local alertBlip = AddBlipForRadius(targetCoords.x, targetCoords.y, targetCoords.z, Config.AlertBlipRadius)

		SetBlipHighDetail(alertBlip, true)
		SetBlipColour(alertBlip, Config.AlertBlipColor)
		SetBlipAlpha(alertBlip, alpha)
		SetBlipAsShortRange(alertBlip, true)

		while alpha ~= 0 do
			Citizen.Wait(Config.AlertBlipTime * 4)
			alpha = alpha - 1
			SetBlipAlpha(alertBlip, alpha)

			if alpha == 0 then
				RemoveBlip(alertBlip)
				return
			end
		end
	end
end)

-- Bank Blips:
Citizen.CreateThread(function()
	for k,v in pairs(Config.Banks) do
		CreateMapBlip(k,v)
	end
end)

function CreateMapBlip(k,v)
	local mk = v.blip
	if mk.enable then
		local blip = AddBlipForCoord(v.keypads[1].pos[1], v.keypads[1].pos[2], v.keypads[1].pos[3])
		SetBlipSprite (blip, mk.sprite)
		SetBlipDisplay(blip, mk.display)
		SetBlipScale  (blip, mk.scale)
		SetBlipColour (blip, mk.color)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(mk.bName)
		EndTextCommandSetBlipName(blip)
	end
end

-- Is Player A cop?
function IsPlayerJobCop()	
	if not PlayerData then return false end
	if not PlayerData.job then return false end
	for k,v in pairs(Config.PoliceJobs) do
		if PlayerData.job.name == v then return true end
	end
	return false
end

-- Function for 3D text:
function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.32, 0.32)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 500
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 80)
end

-- Round Fnction:
function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end


-- Instructional Buttons:
function ButtonMessage(text)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end

-- Button:
function Button(ControlButton)
    N_0xe83a3e3557a56640(ControlButton)
end