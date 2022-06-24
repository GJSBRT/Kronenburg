ESX = nil
EnableGTA = false

RegisterNetEvent('ui:gtatoggle')
AddEventHandler('ui:gtatoggle', function(status)
	if (EnableGTA) then
		EnableGTA = false
		SetMultiplayerBankCash()
		SetMultiplayerWalletCash()
	else
		EnableGTA = true
		RemoveMultiplayerWalletCash()
		RemoveMultiplayerBankCash()
	end
end)


Citizen.CreateThread(function()
	while true do
		Wait(10)
		if IsPauseMenuActive() and not wasmenuopen then
			SendNUIMessage({ action = "toggle", show = false })
			wasmenuopen = true
		end

		if not IsPauseMenuActive() and wasmenuopen then
			Wait(430)
			wasmenuopen = false
			SendNUIMessage({ action = "toggle", show = true })
		end
	end
end)

Citizen.CreateThread(function()
	RequestAnimDict('facials@gen_male@variations@normal')
	RequestAnimDict('mp_facial')

	local talkingPlayers = {}

	while true do
		Citizen.Wait(100)
		local myId = PlayerId()

		for _, player in ipairs(GetActivePlayers()) do
			local boolTalking = NetworkIsPlayerTalking(player)

			if player ~= myId then
				if boolTalking and not talkingPlayers[player] then
					PlayFacialAnim(GetPlayerPed(player), 'mic_chatter', 'mp_facial')
					talkingPlayers[player] = true
				elseif not boolTalking and talkingPlayers[player] then
					PlayFacialAnim(GetPlayerPed(player), 'mood_normal_1', 'facials@gen_male@variations@normal')
					talkingPlayers[player] = nil
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	-- Updates the UI on start
	NetworkSetTalkerProximity(10.0)

	while true do
		if IsControlJustPressed(1, 19) then
			SendNUIMessage({ action = "hud2", enabled = true })
		end
		if IsControlJustReleased(1, 19) then
			SendNUIMessage({ action = "hud2", enabled = false })
		end

        Wait(10)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	local data = xPlayer
	local accounts = data.accounts
	for k, v in pairs(accounts) do
		local account = v
		if account.name == "bank" then
			SendNUIMessage({ action = "setValue", key = "bankmoney", value = "€ " .. ESX.Math.GroupDigits(account.money) })
		elseif account.name == "black_money" then
			SendNUIMessage({ action = "setValue", key = "dirtymoney", value = "€ " .. ESX.Math.GroupDigits(account.money) })
		elseif account.name == "money" then
			SendNUIMessage({ action = "setValue", key = "money", value = "€ " .. ESX.Math.GroupDigits(account.money) })

		end
	end

	-- Job
	local job = data.job
	local job2 = data.job2
	if job.grade_label == "Kronenburg" then
		job.grade_label = "Uitkering"
	end
	SendNUIMessage({ action = "setValue", key = "job", value = job.grade_label, icon = job.name })
	SendNUIMessage({ action = "setValue", key = "job2", value = job2.grade_label, icon = job2.name })

	-- Money
	SendNUIMessage({ action = "setValue", key = "money", value = "€ " .. ESX.Math.GroupDigits(data.money) })
end)

RegisterNetEvent('ui:toggle')
AddEventHandler('ui:toggle', function(show)
	SendNUIMessage({ action = "toggle", show = show })
	DisplayHud(show)
end)

RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
	if account.name == "bank" then
		SendNUIMessage({ action = "setValue", key = "bankmoney", value = "€ " .. ESX.Math.GroupDigits(account.money) })
		if (EnableGTA) then
			StatSetInt("BANK_BALANCE", ESX.Math.GroupDigits(account.money), true)
			Citizen.InvokeNative(0x170F541E1CADD1DE, true)
			Citizen.InvokeNative(0x0772DF77852C2E30, math.floor(account.money), 0)
		end
	elseif account.name == "black_money" then
		SendNUIMessage({ action = "setValue", key = "dirtymoney", value = "€ " .. ESX.Math.GroupDigits(account.money) })
	elseif account.name == "money" then
		SendNUIMessage({ action = "setValue", key = "money", value = "€ " .. ESX.Math.GroupDigits(account.money) })
		if (EnableGTA) then
			StatSetInt("MP0_WALLET_BALANCE", ESX.Math.GroupDigits(account.money), true)
			Citizen.InvokeNative(0x170F541E1CADD1DE, true)
			Citizen.InvokeNative(0x0772DF77852C2E30, math.floor(account.money), 0)
		end
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	if job.grade_label == "Kronenburg" then
		job.grade_label = "Uitkering"
	end
	SendNUIMessage({ action = "setValue", key = "job", value = job.grade_label, icon = job.name })
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
	SendNUIMessage({ action = "setValue", key = "job2", value = job2.grade_label, icon = job2.name })
end)

RegisterNetEvent('es:activateMoney')
AddEventHandler('es:activateMoney', function(e)
	SendNUIMessage({ action = "setValue", key = "money", value = "€ " .. e })
end)

RegisterNetEvent('esx_customui:updateStatus')
AddEventHandler('esx_customui:updateStatus', function(status)
	SendNUIMessage({ action = "updateStatus", status = status })
end)

RegisterNetEvent('esx_customui:updateWeight')
AddEventHandler('esx_customui:updateWeight', function(weight)
	weightprc = (weight / 8000) * 100
	SendNUIMessage({ action = "updateWeight", weight = weightprc })
end)




Citizen.CreateThread(function()
	while true do

		Citizen.Wait(500)

		SendNUIMessage({
			show = IsPauseMenuActive(),
			health = (GetEntityHealth(GetPlayerPed(-1)) - 100),
			stamina = 100 - GetPlayerSprintStaminaRemaining(PlayerId()),
			st = status,
		})
	end
end)
------------
-- E N D ---
------------

RegisterNetEvent('emilia-customui:updateStatus')
AddEventHandler('emilia-customui:updateStatus', function(Status)
	status = Status
	SendNUIMessage({
		action = "updateStatus",
		st = Status,
	})
end)
------------
-- E N D ---
------------

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		local ped = GetPlayerPed(-1)
		local health = GetEntityHealth(ped)
		local armor = GetPedArmour(ped)
		SendNUIMessage({
			heal = health,
			armor = armor
		});
	end
end)
------------
-- E N D ---
------------

TriggerEvent('chat:addSuggestion', '/hud', 'aan/uit', 'Zet je hud aan of uit')
TriggerEvent('chat:addSuggestion', '/gtahud', '', 'Zet de gta hud aan of uit')
