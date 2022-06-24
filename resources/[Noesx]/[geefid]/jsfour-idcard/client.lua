local open = false
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
			TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
			Citizen.Wait(0)
	end
end)

local x,y
local mugshotStr, mugshotHandle
-- Open ID card
RegisterNetEvent('jsfour-idcard:open')
AddEventHandler('jsfour-idcard:open', function(ID, data, type)
	print(ID)
	local ped = GetPlayerPed(GetPlayerFromServerId(ID))

	if DoesEntityExist(ped) then
		mugshotHandle = RegisterPedheadshot(ped)

		while not IsPedheadshotReady(mugshotHandle) or not IsPedheadshotValid(mugshotHandle) do
			Citizen.Wait(500)
		end

		mugshotStr = GetPedheadshotTxdString(mugshotHandle)
	end
	
	x = 0.80
	y = 0.49

	open = true
	SendNUIMessage({
		action = "open",
		array  = data,
		type   = type
	})
	StartCloseThread()
end)


local running = false
function StartCloseThread()
	if running then
		return
	end
	running = true
	Citizen.CreateThread(function()
		while open do
			Citizen.Wait(0)
			DrawSprite(mugshotStr, mugshotStr, x, y, 0.08, 0.16, 0.0, 255, 255, 255, 1000)
			if IsControlJustReleased(0, 322) or IsControlJustReleased(0, 177) then
				SendNUIMessage({
					action = "close"
				})
				open = false
			end
		end
		Citizen.Wait(0)
		UnregisterPedheadshot(mugshotHandle)
		running = false
	end)
end
