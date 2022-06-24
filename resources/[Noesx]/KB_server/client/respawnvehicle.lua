ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj)
		ESX = obj
		end)
	end
end)
local isInMenu = false
local vehicleTimer = 0

RegisterNetEvent('respawnvehicle:respawnvehicle')
AddEventHandler('respawnvehicle:respawnvehicle', function()
	if vehicleTimer < 1 then
		--local allCars = ESX.Game.GetVehicles()
		local playerPed = PlayerPedId()
		local lastVehicle = GetVehiclePedIsIn(playerPed, true)
		if lastVehicle > 0 then
			local checkVehiclePlate = GetVehicleNumberPlateText(lastVehicle)
			local thisVehicle = lastVehicle
			local vehicleHash = GetEntityModel(thisVehicle)
			local vehicleHeading = GetEntityHeading(thisVehicle)
			--print (lastVehicle)
			--print (thisVehicle)
			--print 'Heading'
			--print (vehicleHeading)
			local pos = GetEntityCoords(lastVehicle, false)
			SetNewWaypoint(pos)
			local playerPed = PlayerPedId()
			local coords = GetEntityCoords(playerPed)
			newVehicle = ESX.Game.GetVehicleProperties(lastVehicle)
			--print 'test'
			--print (json.encode(newVehicle))
			--print 'test'
			--local goodVehicle = json.decode(newVehicle)
			--print (json.decode(newVehicle))
			TriggerEvent('chat:addMessage', {
				color = { 255, 0, 0},
				multiline = true,
				args = {"GARAGE ", "U voertuig zal respawnen in 5!"}
			})
			Citizen.Wait(1000)
			TriggerEvent('chat:addMessage', {
				color = { 255, 0, 0},
				multiline = true,
				args = {"GARAGE ", "U voertuig zal respawnen in 4!"}
			})
			Citizen.Wait(1000)
			TriggerEvent('chat:addMessage', {
				color = { 255, 0, 0},
				multiline = true,
				args = {"GARAGE ", "U voertuig zal respawnen in 3!"}
			})
			Citizen.Wait(1000)
			TriggerEvent('chat:addMessage', {
				color = { 255, 0, 0},
				multiline = true,
				args = {"GARAGE ", "U voertuig zal respawnen in 2!"}
			})
			Citizen.Wait(1000)
			TriggerEvent('chat:addMessage', {
				color = { 255, 0, 0},
				multiline = true,
				args = {"GARAGE ", "U voertuig zal respawnen in 1!"}
			})
			Citizen.Wait(1000)
			DeleteVehicle(thisVehicle)
			Citizen.Wait(5000)
			ESX.Game.SpawnVehicle(newVehicle.model, pos, vehicleHeading, function(callback_vehicle)
				local thisnewvehicle = callback_vehicle
				ESX.Game.SetVehicleProperties(thisnewvehicle, newVehicle)
				local plate = checkVehiclePlate
				SetVehicleNumberPlateText(callback_vehicle, plate)
				local thisvehiclemodel = GetEntityModel(callback_vehicle)
				vehicleTimer = 600
			end)
		else
			TriggerEvent('chat:addMessage', {
				template = '<div style="padding: 0.6vw; margin: 0.6vw; background-color: rgba(162, 34, 37, 0.8); border-radius: 3px;">Geen data gevonden van je laatste voertuig.</div>',
				args = { name, message }
			})
		end
	else
		TriggerEvent('chat:addMessage', {
			template = '<div style="padding: 0.6vw; margin: 0.6vw; background-color: rgba(162, 34, 37, 0.8); border-radius: 3px;">Je kan dit commmando maar 1x per 10 minuten gebruiken.</div>',
			args = { name, message }
		})
	end
end)

RegisterCommand("respawnvehicle", function()
	TriggerEvent("respawnvehicle:respawnvehicle")
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if vehicleTimer > 0 then
			vehicleTimer = vehicleTimer - 1
		end
	end
end)

function SetVehicleProperties(vehicle, vehicleProps)
    ESX.Game.SetVehicleProperties(vehicle, vehicleProps)

    if vehicleProps["windows"] then
        for windowId = 1, 9, 1 do
            if vehicleProps["windows"][windowId] == false then
                SmashVehicleWindow(vehicle, windowId)
            end
        end
    end

    if vehicleProps["tyres"] then
        for tyreId = 1, 7, 1 do
            if vehicleProps["tyres"][tyreId] ~= false then
                SetVehicleTyreBurst(vehicle, tyreId, true, 1000)
            end
        end
    end

    if vehicleProps["doors"] then
        for doorId = 0, 5, 1 do
            if vehicleProps["doors"][doorId] ~= false then
                SetVehicleDoorBroken(vehicle, doorId - 1, true)
            end
        end
    end
	if vehicleProps.vehicleHeadLight then SetVehicleHeadlightsColour(vehicle, vehicleProps.vehicleHeadLight) end
	
end

function GetVehicleProperties(vehicle)
    if DoesEntityExist(vehicle) then
        local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)

        vehicleProps["tyres"] = {}
        vehicleProps["windows"] = {}
        vehicleProps["doors"] = {}

        for id = 1, 7 do
            local tyreId = IsVehicleTyreBurst(vehicle, id, false)
        
            if tyreId then
                vehicleProps["tyres"][#vehicleProps["tyres"] + 1] = tyreId
        
                if tyreId == false then
                    tyreId = IsVehicleTyreBurst(vehicle, id, true)
                    vehicleProps["tyres"][ #vehicleProps["tyres"]] = tyreId
                end
            else
                vehicleProps["tyres"][#vehicleProps["tyres"] + 1] = false
            end
        end

        for id = 1, 9 do
            local windowId = IsVehicleWindowIntact(vehicle, id)

            if windowId ~= nil then
                vehicleProps["windows"][#vehicleProps["windows"] + 1] = windowId
            else
                vehicleProps["windows"][#vehicleProps["windows"] + 1] = true
            end
        end
        
        for id = 0, 5 do
            local doorId = IsVehicleDoorDamaged(vehicle, id)
        
            if doorId then
                vehicleProps["doors"][#vehicleProps["doors"] + 1] = doorId
            else
                vehicleProps["doors"][#vehicleProps["doors"] + 1] = false
            end
        end
		vehicleProps["vehicleHeadLight"]  = GetVehicleHeadlightsColour(vehicle)

        return vehicleProps
	else
		return nil
    end
end