local isInVehicle = false
local isEnteringVehicle = false
local currentVehicle = 0
local currentSeat = 0
local leavingVehicle = false
local data = {}

local includeDisplayName = false
local function getDisplayName(model)
	if includeDisplayName then
		return GetDisplayNameFromVehicleModel(model)
	else
		return ""
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local ped = PlayerPedId()
		local vehicle = GetVehiclePedIsUsing(ped)
		if not isInVehicle and not IsPlayerDead(PlayerId()) then
			local enteringVehicle = GetVehiclePedIsTryingToEnter(ped)
			if DoesEntityExist(enteringVehicle) and NetworkGetEntityIsNetworked(enteringVehicle) and not isEnteringVehicle then
				-- trying to enter a vehicle!
				local seat = GetSeatPedIsTryingToEnter(ped)
				local netId = VehToNet(enteringVehicle)
				isEnteringVehicle = true
				local model = GetEntityModel(enteringVehicle)
				local displayName = getDisplayName(model)
				TriggerEvent('baseevents:enteringVehicle', enteringVehicle, seat, displayName, netId, model)
				TriggerServerEvent('baseevents:enteringVehicle', enteringVehicle, seat, displayName, netId, model)
				local data = { vehicle = enteringVehicle, seat = seat, netId = netId, model = model }
				TriggerEvent('enteringVehicle', data)
				data.vehicle = nil
				TriggerServerEvent('enteringVehicle', data)
			elseif not DoesEntityExist(GetVehiclePedIsTryingToEnter(ped)) and not IsPedInAnyVehicle(ped, true) and isEnteringVehicle then
				-- vehicle entering aborted
				TriggerEvent('baseevents:enteringAborted')
				TriggerServerEvent('baseevents:enteringAborted')
				isEnteringVehicle = false
			elseif IsPedInAnyVehicle(ped, false) and DoesEntityExist(vehicle) and NetworkGetEntityIsNetworked(vehicle) then
				-- suddenly appeared in a vehicle, possible teleport
				isEnteringVehicle = false
				isInVehicle = true
				currentVehicle = GetVehiclePedIsUsing(ped)
				currentSeat = GetPedVehicleSeat(ped, currentVehicle)
				local model = GetEntityModel(currentVehicle)
				local netId = VehToNet(currentVehicle)
				local displayName = getDisplayName(data.model)
				local class = GetVehicleClass(currentVehicle)
				TriggerEvent('baseevents:enteredVehicle', currentVehicle, currentSeat, displayName, netId, model, class)
				TriggerServerEvent('baseevents:enteredVehicle', currentVehicle, currentSeat, displayName, netId, model, class)
				local data = { vehicle = currentVehicle, seat = currentSeat, netId = netId, model = model, class = class }
				TriggerEvent('enteredVehicle', data)
				data.vehicle = nil
				TriggerServerEvent('enteredVehicle', data)
			end
		elseif isInVehicle then
			if not IsPedInAnyVehicle(ped, false) or currentVehicle ~= GetVehiclePedIsIn(ped) or IsPlayerDead(PlayerId()) then
				-- bye, vehicle
				local model = GetEntityModel(currentVehicle)
				local netId = VehToNet(currentVehicle)
				local displayName = getDisplayName(data.model)
				local class = GetVehicleClass(currentVehicle)
				TriggerEvent('baseevents:leftVehicle', currentVehicle, currentSeat, displayName, netId, model, class)
				TriggerServerEvent('baseevents:leftVehicle', currentVehicle, currentSeat, displayName, netId, model, class)
				local data = { vehicle = currentVehicle, seat = currentSeat, netId = netId, model = model, class = class }
				TriggerEvent('leftVehicle', data)
				data.vehicle = nil
				TriggerServerEvent('leftVehicle', data)
				leavingVehicle = false
				isInVehicle = false
				currentVehicle = 0
				currentSeat = 0
			elseif GetPedInVehicleSeat(currentVehicle, currentSeat) ~= ped and DoesEntityExist(currentVehicle) and NetworkGetEntityIsNetworked(currentVehicle) then
				local oldSeat = currentSeat
				currentSeat = GetPedVehicleSeat(ped, currentVehicle)
				local model = GetEntityModel(currentVehicle)
				local netId = VehToNet(currentVehicle)
				local displayName = getDisplayName(model)
				local class = GetVehicleClass(currentVehicle)
				TriggerEvent('baseevents:changedSeat', currentVehicle, currentSeat, displayName, netId, model, oldSeat, class)
				TriggerServerEvent('baseevents:changedSeat', currentVehicle, currentSeat, netId, model, oldSeat, class)
				local data = { vehicle = currentVehicle, seat = currentSeat, netId = netId, model = model, oldSeat = oldSeat, class = class }
				TriggerEvent('changedSeat', data)
				data.vehicle = nil
				TriggerServerEvent('changedSeat', data)
			elseif not leavingVehicle and GetIsTaskActive(ped, 167) then
				leavingVehicle = true
				TriggerEvent('baseevents:leavingVehicle', currentVehicle, currentSeat)
				TriggerServerEvent('baseevents:leavingVehicle', currentVehicle, currentSeat)
				local data = { vehicle = currentVehicle, currentSeat = currentSeat }
				TriggerEvent('leavingVehicle', data)
				data.vehicle = nil
				TriggerServerEvent('leavingVehicle', data)
			end
		end
		Citizen.Wait(50)
	end
end)

function GetPedVehicleSeat(ped, vehicle)
	if not vehicle or not DoesEntityExist(vehicle) then
		vehicle = GetVehiclePedIsIn(ped, false)
	end
    for i=-2,GetVehicleMaxNumberOfPassengers(vehicle) do
        if(GetPedInVehicleSeat(vehicle, i) == ped) then return i end
    end
    return -2
end
