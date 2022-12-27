--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
--================================================================================================--
--==                                VARIABLES - DO NOT EDIT                                     ==--
--================================================================================================--
ESX            = nil
inMenu         = true
local atbank   = false
local bankMenu = true
local BreakingATM = false
local keys = {
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

function playAnim(animDict, animName, duration)
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do Citizen.Wait(0) end
	TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
	RemoveAnimDict(animDict)
end

--================================================================================================
--==                                THREADING - DO NOT EDIT                                     ==
--================================================================================================

--===============================================
--==           Base ESX Threading              ==
--===============================================
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	-- ESX.TriggerServerCallback('new_banking:server:getVerifyToken', function(token, eventname)
	-- 	verifyToken = token
	-- 	RegisterNetEvent(eventname)
	-- 	AddEventHandler(eventname, function(token)
	-- 		verifyToken = token
	-- 	end)
	-- end) Beveiliging komt eraan
end)


--===============================================
--==             Core Threading                ==
--===============================================
local TryToBreak = false
local UsedLockpick = false
local CanceledBreakingATM = false
if bankMenu then
	Citizen.CreateThread(function()
		while ESX == nil do Citizen.Wait(50) end
		while true do
			Citizen.Wait(5)
			if nearATM ~= false or nearBank ~= false then
				DisplayHelpText("Druk ~INPUT_PICKUP~ om uw bankrekening te bekijken ~b~")
				if BreakingATM == false and nearATM ~= false and nearBank == false then
					if TryToBreak == false and BreakingATM == false and (UsedLockpick == true or IsControlJustPressed(1, 182)) then
						TryToBreak = true
						ESX.TriggerServerCallback("new_banking::canPicklock", function(can) 
							if can ~= false then
								BreakingATM = true
								Citizen.CreateThread(function() 
									Citizen.Wait(30000)
									BreakingATM = false
								end)

								local player = PlayerPedId(-1)
								local playerPos = GetEntityCoords(player)
								local Timing = math.random(17,55) * 1000
								local LongTime = math.random(1,4)
								if LongTime == 2 then Timing = math.random(55, 95) * 1000 end

								local playerCoords = GetEntityCoords(PlayerPedId())
								streetName,_ = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
								streetName = GetStreetNameFromHashKey(streetName)
								TriggerServerEvent('new_banking::pickLockATM', nearATM, Timing, GetEntityCoords(player), streetName, verifyToken)
								FreezeEntityPosition(PlayerPedId(), true)
								DisableControlAction(1, 323, true)
								DisableControlAction(0, 73, true)
								TriggerEvent('dpemotes::toggleX', false)
								-- animation 1:
								local animDict = "random@atmrobberygen@male"
								local animName = "idle_a"
								
								RequestAnimDict(animDict)
								while not HasAnimDictLoaded(animDict) do
									Citizen.Wait(0)
								end
								
								TaskStartScenarioInPlace(player, 'WORLD_HUMAN_WELDING', 0, true)
								FreezeEntityPosition(PlayerPedId(), true)
								exports['progressBars']:startUI(Timing, "Pinautomaat openbreken")
								CurrentTiming = 0
								while (Timing > CurrentTiming) and CanceledBreakingATM == false do
									FreezeEntityPosition(PlayerPedId(), true)
									CurrentTiming = CurrentTiming + 100
									Citizen.Wait(100)
								end

								if CanceledBreakingATM == false then
									TriggerServerEvent('new_banking::pickLockATMStage2', nearATM, Timing, GetEntityCoords(player), streetName, verifyToken)
								
									TaskPlayAnim(player,animDict,animName,3.0,0.5,-1,31,1.0,0,0)
									Citizen.Wait(6400)
								end	
								FreezeEntityPosition(player, false)
								ClearPedTasks(player)
								ClearPedSecondaryTask(player)
								DisableControlAction(0, 73, false)
								DisableControlAction(1, 323, false)
								TriggerEvent('dpemotes::toggleX', true)
									
							else
								ESX.ShowNotification('Je kunt dit niet doen')
								Citizen.Wait(4000)
							end

							TryToBreak = false
						end, nearATM)
					end
				end
				if IsControlJustPressed(1, 38) and BreakingATM == false then
					inMenu = true
					openUI()
					TriggerServerEvent("bank:gettransactions", PlayerId())
					TriggerServerEvent("bank:gettransactions_zakelijk")
					TriggerServerEvent('bank:balance')
					local ped = GetPlayerPed(-1)
				end
			end
					
			if IsControlJustPressed(1, 322) then
				inMenu = false
				SetNuiFocus(false, false)
				SendNUIMessage({type = 'close'})
			end
		end
	end)
end

RegisterNetEvent("new_banking:usedLockpick")
AddEventHandler("new_banking:usedLockpick", function()
	UsedLockpick = true
	Citizen.CreateThread(function()
		Citizen.Wait(2000)
		UsedLockpick = false 
	end)
end)
--===============================================
--==             Map Blips	                   ==
--===============================================

--BANK
Citizen.CreateThread(function()
	if Config.ShowBlips then
		for k, v in ipairs(Config.Bank) do
			local blip = AddBlipForCoord(v.x, v.y, v.z)
			SetBlipSprite(blip, v.id)
			SetBlipDisplay(blip, 4)
			SetBlipScale(blip, 0.9)
			SetBlipColour(blip, 2)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(_U("bank_blip"))
			EndTextCommandSetBlipName(blip)
		end
	end
end)

--ATM
Citizen.CreateThread(function()
	if Config.ShowBlips and Config.OnlyBank == false then
		for k, v in ipairs(Config.ATM) do
			local blip = AddBlipForCoord(v.x, v.y, v.z)
			SetBlipSprite(blip, v.id)
			SetBlipDisplay(blip, 4)
			SetBlipScale(blip, 0.9)
			SetBlipColour(blip, 2)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(_U("atm_blip"))
			EndTextCommandSetBlipName(blip)
		end
	end
end)

--[[ Transactions ]]
RegisterNetEvent('bank:showtransactions')
AddEventHandler('bank:showtransactions', function(transactions)
	SendNUIMessage({
		type = "transactions",
		transactions = transactions
	})
end)

--[[ Transactions ]]
RegisterNetEvent('bank:showtransactions_zakelijk')
AddEventHandler('bank:showtransactions_zakelijk', function(transactions)
	SendNUIMessage({
		type = "transactions_zakelijk",
		transactions_zakelijk = transactions
	})
end)
--===============================================
--==           Deposit Event                   ==
--===============================================
RegisterNetEvent('currentbalance1')
AddEventHandler('currentbalance1', function(balance, isZakelijk, zakelijkBalance)
	local id = PlayerId()
	local playerName = GetPlayerName(id)

	SendNUIMessage({
		type = "balanceHUD",
		balance = balance,
		player = playerName,
		isZakelijk = isZakelijk, 
		zakelijkBalance = zakelijkBalance
	})
end)
--===============================================
--==           Deposit Event                   ==
--===============================================
RegisterNUICallback('deposit', function(data)
	TriggerServerEvent('bank:deposit', tonumber(data.amount))
	TriggerServerEvent('bank:balance')
end)

--===============================================
--==          Withdraw Event                   ==
--===============================================
RegisterNUICallback('withdrawl', function(data)
	TriggerServerEvent('bank:withdraw', tonumber(data.amountw))
	TriggerServerEvent('bank:balance')
end)

--===============================================
--==         Balance Event                     ==
--===============================================
RegisterNUICallback('balance', function()
	TriggerServerEvent('bank:balance')
end)

RegisterNetEvent('balance:back')
AddEventHandler('balance:back', function(balance, isZakelijk)
	SendNUIMessage({ 
		type = 'balanceReturn', 
		bal = balance
	})
end)


--===============================================
--==         Transfer Event                    ==
--===============================================
RegisterNUICallback('transfer', function(data)
	TriggerServerEvent('bank:transfer', data.to, data.amountt)
	TriggerServerEvent('bank:balance')
end)

--===============================================
--==         Result   Event                    ==
--===============================================
RegisterNetEvent('bank:result')
AddEventHandler('bank:result', function(type, message)
	SendNUIMessage({ type = 'result', m = message, t = type })
end)


--===============================================
--==         ESX Invest Event                  ==
--===============================================
RegisterNUICallback('esx_invest', function()
	if (inMenu) then
		inMenu = false
		SetNuiFocus(false, false)
		SendNUIMessage({ type = 'closeAll' })
		exports.esx_invest:openUI()
	end
end)

--===============================================
--==               NUIFocusoff                 ==
--===============================================
RegisterNUICallback('NUIFocusOff', function()
	closeUI()
end)

AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
		return
	end
	closeUI()
end)

AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
		return
	end
	closeUI()
end)


--===============================================
--==            Capture Bank Distance          ==
--===============================================
function nearBankFunc()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)

	local id = 1
	for _, search in pairs(Config.Bank) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)

		if distance <= 1.3 then
			return id
		end
		id = id  + 1
	end

	return false
end

function nearATMFunc()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)

	local id = 1
	for _, search in pairs(Config.ATM) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)

		if distance <= 1.3 then
			return id
		end
		id = id  + 1
	end

	return false
end
Citizen.CreateThread(function()
	while true do
		if BreakingATM == true and IsControlJustPressed(0, 252) then
			CanceledBreakingATM = true
			exports['progressBars']:startUI(1250, "Annuleren")
			Citien.Wait(2000)
			CanceledBreakingATM = false
		end
		if BreakingATM == false then Citizen.Wait(1250) end
		Citizen.Wait(5)
	end
end)
Citizen.CreateThread(function()
	while true do
		nearBank = nearBankFunc()
		nearATM = nearATMFunc()
		Citizen.Wait(600)
	end
end)

function closeUI()
	inMenu = false
	SetNuiFocus(false, false)
	if Config.Animation.Active then
		playAnim('mp_common', 'givetake1_a', Config.Animation.Time)
		Citizen.Wait(Config.Animation.Time)
	end
	SendNUIMessage({ type = 'closeAll' })
end

function openUI()
	if Config.Animation.Active then
		playAnim('mp_common', 'givetake1_a', Config.Animation.Time)
		Citizen.Wait(Config.Animation.Time)
	end
	inMenu = true
	SetNuiFocus(true, true)
	SendNUIMessage({ type = 'openGeneral' })
	TriggerServerEvent('bank:balance')
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
