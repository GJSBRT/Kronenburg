local ind            = { l = false, r = false }
local oldfeuRoute    = nil
local oldfeuPosition = nil
local data           = {
	handbrake = nil,
	engingeHeath = nil
}
ESX                  = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(7)
	end
end)

local Distance = 0
AddEventHandler("vehiclefailure:odometer", function(vehicle, odometer)
	if Currentvehicle == vehicle then
		Distance = odometer
	end
end)

Citizen.CreateThread(function()
	local showhud = true
	while true do
		local Ped = GetPlayerPed(-1)
		if (IsPedInAnyVehicle(Ped)) then
			local PedCar = GetVehiclePedIsIn(Ped, false)
			if PedCar and GetPedInVehicleSeat(PedCar, -1) or GetPedInVehicleSeat(PedCar, 0) == Ped then

				-- Speed
				carSpeed = math.ceil(GetEntitySpeed(PedCar) * 3.6)
				SendNUIMessage({
					showhud = true,
					speed = carSpeed
				})
				showhud = true

			else
				if showhud == true then
					showhud = false
					SendNUIMessage({
						showhud = false
					})
				end
				Wait(2000)
			end
		else
			if showhud == true then
				showhud = false
				SendNUIMessage({
					showhud = false
				})
			end
			Wait(2000)
		end

		Citizen.Wait(150)
	end
end)

Citizen.CreateThread(function()
	local showhud = true
	while true do
		local Ped = GetPlayerPed(-1)
		if (IsPedInAnyVehicle(Ped)) then
			local PedCar = GetVehiclePedIsIn(Ped, false)
			if PedCar and GetPedInVehicleSeat(PedCar, -1) == Ped then
				maxSpeed = GetVehicleHandlingInt(PedCar, "CHandlingData", 'fInitialDriveMaxFlatVel')

				SendNUIMessage({
					type='cardealerCarData',
					maxSpeed = maxSpeed
				})
				-- Lights
				_, feuPosition, feuRoute = GetVehicleLightsState(PedCar)
				-- print('test')
				if (oldfeuRoute ~= feuRoute) or (oldfeuPosition ~= feuPosition) then
					-- print('veranderen')
					if (feuPosition == 1) then
						SendNUIMessage({
							feuRoute = true
						})
					else
						SendNUIMessage({
							feuRoute = false
						})
					end
					if (feuPosition == 1 and feuRoute == 1) then
						SendNUIMessage({
							feuPosition = true
						})
					else
						SendNUIMessage({
							feuPosition = false
						})
					end
				end

				oldfeuRoute = feuRoute
				oldfeuPosition = feuPosition
				data.handbrake = GetVehicleHandbrake(PedCar)
				data.engineHealth = GetVehicleEngineHealth(PedCar)
				data.odometer = Distance
				SendNUIMessage(data)
			else
				if showhud == true then
					showhud = false
					SendNUIMessage({
						showhud = false
					})
				end
			end
		else
			if showhud == true then
				showhud = false
				SendNUIMessage({
					showhud = false
				})
			end
			Wait(2000)
		end

		Citizen.Wait(100)
	end
end)

-- Consume fuel factor
Citizen.CreateThread(function()
	while true do
		local Ped = GetPlayerPed(-1)
		if (IsPedInAnyVehicle(Ped)) then
			local CurrentVeh = ESX.Game.GetClosestVehicle()
			local VehClass = GetVehicleClass(CurrentVeh)
			local PedCar = GetVehiclePedIsIn(Ped, false)
			if PedCar and GetPedInVehicleSeat(PedCar, -1) == Ped and (VehClass ~= 13) then
				fuel = GetVehicleFuelLevel(PedCar)
				SendNUIMessage({
					showfuel = true,
					fuel = fuel
				})
			elseif PedCar and GetPedInVehicleSeat(PedCar, -1) == Ped and (VehClass == 13) then
				SendNUIMessage({
					showfuel = true,
					fuel = 100
				})
			end
		end
		Citizen.Wait(2000)
	end
end)
