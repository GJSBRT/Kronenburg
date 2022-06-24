local vehicle, seat, model, class, netId

local lastVehicle

local leftVehicleHandlers, enteredVehicleHandlers, changedSeatHandlers

local lib = {}
CurrentVehicle = lib
Vehicle = lib

AddEventHandler('enteredVehicle', function(data)
    vehicle = data.vehicle
    seat = data.seat
    model = data.model
    class = data.class
    netId = data.netId

    if enteredVehicleHandlers then
        for i=1, #enteredVehicleHandlers do
            enteredVehicleHandlers[i]()
        end
    end
end)

AddEventHandler('leftVehicle', function(data)
    lastVehicle = data.vehicle
    vehicle = nil
    seat = nil
    model = nil
    class = nil
    netId = nil

    if leftVehicleHandlers then
        for i=1, #leftVehicleHandlers do
            leftVehicleHandlers[i]()
        end
    end
end)

AddEventHandler('changedSeat', function(data)
    -- { vehicle = currentVehicle, seat = currentSeat, netId = netId, model = model, oldSeat = oldSeat, class = class }
    vehicle = data.vehicle
    seat = data.seat
    netId = data.netId
    model = data.model
    class = data.class

    if changedSeatHandlers then
        for i=1, #changedSeatHandlers do
            changedSeatHandlers[i]()
        end
    end
end)

function lib.GetCurrent()
    return vehicle
end
lib.Get = lib.GetCurrent

function lib.GetCurrentOrLast()
    return vehicle or lastVehicle
end

function lib.GetLast()
    return lastVehicle
end

function lib.GetSeat()
    return seat
end

lib.GetCurrentSeat = lib.GetSeat

function lib.GetModel()
    return model
end

function lib.GetClass()
    return class
end

function lib.GetNetId()
    return netId
end

function lib.AddLeftHandler(cb)
    if not leftVehicleHandlers then
        leftVehicleHandlers = {}
    end

    table.insert(leftVehicleHandlers, cb)
end

function lib.AddEnteredHandler(cb)
    if not enteredVehicleHandlers then
        enteredVehicleHandlers = {}
    end

    table.insert(enteredVehicleHandlers, cb)
end

function lib.AddChangedSeatHandler(cb)
    if not changedSeatHandlers then
        changedSeatHandlers = {}
    end

    table.insert(changedSeatHandlers, cb)
end


local function getPedVehicleSeat(ped, vehicle)
	if not vehicle or not DoesEntityExist(vehicle) then
		vehicle = GetVehiclePedIsIn(ped, false)
	end
    for i=-2, GetVehicleMaxNumberOfPassengers(vehicle) do
        if(GetPedInVehicleSeat(vehicle, i) == ped) then return i end
    end
    return -2
end

-- Restart compatibility
Citizen.CreateThread(function()
    local currVehicle = GetVehiclePedIsIn(PlayerPedId())
    if currVehicle ~= 0 and DoesEntityExist(currVehicle) then
        vehicle = currVehicle
        seat = getPedVehicleSeat(PlayerPedId(), vehicle)
        model = GetEntityModel(vehicle)
        class = GetVehicleClass(vehicle)
        netId = NetworkGetNetworkIdFromEntity(vehicle)

        if enteredVehicleHandlers then
            for i=1, #enteredVehicleHandlers do
                enteredVehicleHandlers[i]()
            end
        end
    end
end)