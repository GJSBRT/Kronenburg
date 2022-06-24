ESX          = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(7)
    end

    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
  
	PlayerData = ESX.GetPlayerData()
end)

local DECOR = {
    FLOAT = 1,
    BOOL = 2,
    INT = 3,
    UNK = 4,
    TIME = 5,
}

local DECORATORS = {
    ["flatbed3_bed"] = DECOR.INT, -- The bed entity
    ["flatbed3_car"] = DECOR.INT, -- The car entity
    ["flatbed3_attached"] = DECOR.BOOL, -- Is a car attached?
    ["flatbed3_lowered"] = DECOR.BOOL, -- Is the bed lowered?
    ["flatbed3_state"] = DECOR.INT, -- Multi-state for the bed
}


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

for k,v in next, DECORATORS do
    DecorRegister(k, v)
end

function lerp(a, b, t)
	return a + (b - a) * t
end

-- Value controlling all movement
local LERP_VALUE = 0.0

local lastFlatbed = nil
local lastBed = nil

--local raisedOffset = vector3(0.0, -3.8, 0.25)
local backOffset = {vector3(0.0, -4.0, 0.0), vector3(0.0, 0.0, 0.0)}
local loweredOffset = {vector3(0.0, -0.4, -1.0), vector3(12.0, 0.0, 0.0)}
local raisedOffset = {vector3(0.0, -3.7, 0.40), vector3(0.0, 0.0, 0.0)}

local attachmentOffset = {vector3(0.0, 1.5, 0.3), vector3(0.0, 0.0, 0.0)}

local bedController = {vector3(-2.5, -3.8, -1.0), vector3(0.0, 0.0, 0.0)}

local controllerMessageLoweredCar = "OMNI_FB3_INST_LC"
local controllerMessageLoweredNoCar = "OMNI_FB3_INST_LN"
local controllerMessageRaised = "OMNI_FB3_INST_R"
AddTextEntry(controllerMessageLoweredCar, "Druk op ~INPUT_CONTEXT~ om het platform te ~y~te verhogen.~n~ ~w~Druk op Z om het voertuig ~r~los ~r~te maken.")
AddTextEntry(controllerMessageLoweredNoCar, "Druk op ~INPUT_CONTEXT~ om het platform te ~y~te verhogen.~n~ ~w~Druk op ~INPUT_DETONATE~ om het voertuig ~g~vast ~w~te maken.")
AddTextEntry(controllerMessageRaised, "Druk op ~INPUT_CONTEXT~ om het platform te ~y~verlagen.")

local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end

		enum.destructor = nil
		enum.handle = nil
	end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, entityEnumerator)

		local next = true
		repeat
		coroutine.yield(id)
		next, id = moveFunc(iter)
		until not next

		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function EnumerateObjects()
	return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function EnumeratePeds()
	return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function EnumeratePickups()
	return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end

function GetAllVehicles() 
	local vehicles = {}

	for vehicle in EnumerateVehicles() do
		table.insert(vehicles, vehicle)
	end

	return vehicles
end

function GetAllObjects() 
	local objs = {}

	for obj in EnumerateObjects() do
		table.insert(objs, obj)
	end

	return objs
end

function BigDelete(entity) 
    local playerPed = PlayerPedId()
    carModel = GetEntityModel(entity)
    carName = GetDisplayNameFromVehicleModel(carModel)
    if (NetworkGetNetworkIdFromEntity(entity) ~= nil and NetworkGetNetworkIdFromEntity(entity) > 0) then
        NetworkRequestControlOfEntity(entity)

        local timeout = 2000
        while timeout > 0 and not NetworkHasControlOfEntity(entity) do
            Wait(100)
            timeout = timeout - 100
        end

        SetEntityAsMissionEntity(entity, true, true)

        local timeout = 2000
        while timeout > 0 and not IsEntityAMissionEntity(entity) do
            Wait(100)
            timeout = timeout - 100
        end

        Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )

        if (DoesEntityExist(entity)) then 
            DeleteEntity(entity)
        end 
    end
end

function BedCheck()
    local objects = GetAllObjects()
    for i=1, #objects do 
        local obj = objects[i]
        if (GetHashKey("inm_flatbed_base") == GetEntityModel(obj)) then 
            local tow = false
            local vehicles = GetAllVehicles()
            for i=1, #vehicles do 
                local car = vehicles[i]
                if (GetHashKey("flatbed3") == GetEntityModel(car)) then 
                    local car_coords = GetEntityCoords(car, false)
                    local bed_coords = GetEntityCoords(obj, false)
                    local dist = GetDistanceBetweenCoords(car_coords.x, car_coords.y, car_coords.z, bed_coords.x, bed_coords.y, bed_coords.z, true)
                    if (dist < 10.0) then
                        tow = true
                        break
                    end
                end
            end
            if (not tow) then
                BigDelete(obj)
            end
        end
    end
end

function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function drawMarker(pos)
    local plyPos = GetEntityCoords(PlayerPedId(), true)
    if IsPedInAnyVehicle(PlayerPedId(), true) then
        return false
    end
    local dist = #(pos - plyPos)
    if dist < 25.0 then
        DrawMarker(2, pos.x, pos.y, pos.z + 0.6, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 204, 104, 0, 222, false, false, false, true, false, false, false)
        if dist < 2.5 then
            DrawText3D(pos.x, pos.y, pos.z + 1, "~o~E ~w~- Platform bedienen") 
            if dist < 1.5 then
                return true
            end
        end
    end
    return false
end

function showHelpText(text)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringTextLabel(text)
    EndTextCommandDisplayHelp(0, 0, 1, -1)
end

function getVehicleInDirection(coordFrom, coordTo)
    local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y,
            coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10,
            PlayerPedId())
    local a, b, c, d, vehicle = GetRaycastResult(rayHandle)
    return vehicle
end
local CanPlaceVehicle = false
local PlacedVehicle = false
-- function log(text)
--     print("[omni_flatbed/client] " .. text)
-- end

Citizen.CreateThread(function()
    -- log("Flatbed Loading")
    RequestModel("inm_flatbed_base")
    -- while not HasModelLoaded("inm_flatbed_base") do
    --     Wait(0)
    --     print('laden')
    -- end
    -- log("Flatbed Loading Complete")
    while true do
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped, true)
        if veh and GetEntityModel(veh) ~= GetHashKey("flatbed3") then
            veh = lastFlatbed
        end
        if lastFlatbed then
            if not DoesEntityExist(lastFlatbed) then
                -- log("FLATBED DELETED?")
                if lastBed then
                    if DoesEntityExist(lastBed) then
                        -- log("BED STILL EXISTS!")
                        BigDelete(lastBed)
                        lastBed = nil
                    end
                end
                lastFlatbed = nil
            end
        end
        if veh and DoesEntityExist(veh) and GetEntityModel(veh) == GetHashKey("flatbed3") and NetworkHasControlOfEntity(veh) then
            lastFlatbed = veh
            local rightDir, fwdDir, upDir, pos = GetEntityMatrix(veh)

            if not DecorExistOn(veh, "flatbed3_bed") or DecorGetInt(veh, "flatbed3_bed") == 0 then
                DecorSetInt(veh, "flatbed3_bed", 0)
                local bed = CreateObjectNoOffset("inm_flatbed_base", pos, true, 0, 1)
                -- log("GENERATING BED")
                if DoesEntityExist(bed) then
                    local bedNet = ObjToNet(bed)
                    DecorSetInt(veh, "flatbed3_bed", bedNet)
                    -- log("DONE GENERATING BED")
                end
            end
            local bedNet = DecorGetInt(veh, "flatbed3_bed")
            local bed = nil
            if bedNet ~= 0 then
				
                bed = NetToObj(bedNet)
                lastBed = bed
				
				local bedPos = GetEntityCoords(bed, false)
                if not DecorExistOn(veh, "flatbed3_attached") then
                    DecorSetBool(veh, "flatbed3_attached", false)
                end
                local attached = DecorGetBool(veh, "flatbed3_attached")

                if not DecorExistOn(veh, "flatbed3_lowered") then
                    DecorSetBool(veh, "flatbed3_lowered", true)
                end
                local lowered = DecorGetBool(veh, "flatbed3_lowered")

                if not DecorExistOn(veh, "flatbed3_state") then
                    DecorSetInt(veh, "flatbed3_state", 0)
                end
                local state = DecorGetInt(veh, "flatbed3_state")

                if not DecorExistOn(veh, "flatbed3_car") then
                    DecorSetInt(veh, "flatbed3_car", 0)
                end
                local carNet = DecorGetInt(veh, "flatbed3_car")
                local car = nil
                if carNet ~= 0 then
                    car = NetToVeh(carNet)
                end

                local data = bedController
                local x = pos.x + (fwdDir.x * data[1].x) + (rightDir.x * data[1].y) + (upDir.x * data[1].z)
                local y = pos.y + (fwdDir.y * data[1].x) + (rightDir.y * data[1].y) + (upDir.y * data[1].z)
                local z = pos.z + (fwdDir.z * data[1].x) + (rightDir.z * data[1].y) + (upDir.z * data[1].z)
                local controllerPos = vector3(x, y, z)

                if state == 0 then
                    -- Raised
                    SetVehicleHandbrake(veh, false)
                    if lowered then
                        DetachEntity(bed, 0, 0)
                        AttachEntityToEntity(bed, veh, GetEntityBoneIndexByName(veh, "chassis"), raisedOffset[1], raisedOffset[2], 0, 0, 1, 0, 0, 1)

                        DecorSetBool(veh, "flatbed3_lowered", false)
                        lowered = false
                    end

                    if drawMarker(controllerPos) then
                        showHelpText(controllerMessageRaised)
                        if IsControlJustPressed(0, 38) then
                            if PlayerData.job.name == 'mechanic' then
                                state = 1
                                DecorSetInt(veh, "flatbed3_state", state)
                            else
                                ESX.ShowNotification('Alleen werknemers van de ~o~ANWB~s~ kunnen de flatbed bedienen')
                            end
                        end
                    end
                elseif state == 1 then
                    -- Moving back
                    SetVehicleHandbrake(veh, true)
                    local offsetPos = raisedOffset[1]
                    local offsetRot = raisedOffset[2]

                    offsetPos = offsetPos + vector3(lerp(0.0, backOffset[1].x, LERP_VALUE), lerp(0.0, backOffset[1].y, LERP_VALUE), lerp(0.0, backOffset[1].z, LERP_VALUE))
                    offsetRot = offsetRot + vector3(lerp(0.0, backOffset[2].x, LERP_VALUE), lerp(0.0, backOffset[2].y, LERP_VALUE), lerp(0.0, backOffset[2].z, LERP_VALUE))

                    DetachEntity(bed, 0, 0)
                    AttachEntityToEntity(bed, veh, GetEntityBoneIndexByName(veh, "chassis"), offsetPos, offsetRot, 0, 0, 1, 0, 0, 1)

                    LERP_VALUE = LERP_VALUE + (1.0 * Timestep()) / 5.0

                    if LERP_VALUE >= 1.0 then
                        state = state + 1
                        DecorSetInt(veh, "flatbed3_state", state)
                        LERP_VALUE = 0.0
                    end
                elseif state == 2 then
                    -- Lowering
                    SetVehicleHandbrake(veh, true)
                    local offsetPos = raisedOffset[1] + backOffset[1]
                    local offsetRot = raisedOffset[2] + backOffset[2]

                    offsetPos = offsetPos + vector3(lerp(0.0, loweredOffset[1].x, LERP_VALUE), lerp(0.0, loweredOffset[1].y, LERP_VALUE), lerp(0.0, loweredOffset[1].z, LERP_VALUE))
                    offsetRot = offsetRot + vector3(lerp(0.0, loweredOffset[2].x, LERP_VALUE), lerp(0.0, loweredOffset[2].y, LERP_VALUE), lerp(0.0, loweredOffset[2].z, LERP_VALUE))

                    DetachEntity(bed, 0, 0)
                    AttachEntityToEntity(bed, veh, GetEntityBoneIndexByName(veh, "chassis"), offsetPos, offsetRot, 0, 0, 1, 0, 0, 1)

                    LERP_VALUE = LERP_VALUE + (1.0 * Timestep()) / 5.0

                    if LERP_VALUE >= 1.0 then
                        state = state + 1
                        DecorSetInt(veh, "flatbed3_state", state)
                        LERP_VALUE = 0.0
                    end
                elseif state == 3 then
                    -- Lowered
                    SetVehicleHandbrake(veh, true)
                    if not lowered then
                        local offsetPos = raisedOffset[1] + backOffset[1] + loweredOffset[1]
                        local offsetRot = raisedOffset[2] + backOffset[2] + loweredOffset[2]
                        DetachEntity(bed, 0, 0)
                        AttachEntityToEntity(bed, veh, GetEntityBoneIndexByName(veh, "chassis"), offsetPos, offsetRot, 0, 0, 1, 0, 0, 1)
                        DecorSetBool(veh, "flatbed3_lowered", true)
                        lowered = true
                    end
                    
                    if IsControlJustPressed(0, 47) then
                        print('Pressed G')
                        if not attached then
                            if not IsPedInAnyVehicle(ped, true) then
                                -- Try to get the car on the flatbed
                                local bedPos = GetEntityCoords(bed, false)
                                local newCar = getVehicleInDirection(bedPos + vector3(0.0, 0.0, 0.25), bedPos + vector3(0.0, 0.0, 2.25))
                                print('newcar : '.. newCar)
                                if newCar ~= 0 then
                                    if GetVehicleClass(newCar) ~= 10 or GetVehicleClass(newCar) ~= 11 or GetVehicleClass(newCar) ~= 17 or GetVehicleClass(newCar) ~= 20 then
                                        CanPlaceVehicle = false
                                        
                                        local vehiclePos = GetEntityCoords(newCar, false)
                                        NetworkRequestControlOfEntity(newCar)
                                        while not NetworkHasControlOfEntity(newCar) do Wait(0) end
                                        
                                        AttachEntityToEntity(newCar, bed, 0, attachmentOffset[1] + vector3(0.0, 0.0, vehiclePos.z - bedPos.z - 0.45), attachmentOffset[2], 0, 0, false, 0, 0, 1)
                                        car = newCar
                                        DecorSetInt(veh, "flatbed3_car", VehToNet(newCar))
                                        attached = true
                                        DecorSetBool(veh, "flatbed3_attached", attached)
                                    else
                                        ESX.ShowNotification('Je kan geen groot voertuig op de flatbed zetten!')
                                    end
                                else
                                    ESX.ShowNotification('Er staat geen voertuig op de flatbed!')
                                end
                            else
                                if CanPlaceVehicle then
                                    VehModel = GetVehiclePedIsIn(ped, true)
                                    print('Vehicle ',VehModel)
                                    local bedPos = GetEntityCoords(bed, false)    
                                    
                                    if GetVehicleClass(VehModel) ~= 10 or GetVehicleClass(VehModel) ~= 11 or GetVehicleClass(VehModel) ~= 17 or GetVehicleClass(VehModel) ~= 20 then
                                        if VehModel ~= 0 then
                                            CanPlaceVehicle = false
                                            local vehiclePos = GetEntityCoords(VehModel, false)
                                            NetworkRequestControlOfEntity(VehModel)
                                            while not NetworkHasControlOfEntity(VehModel) do Wait(0) end
                                            print('maak vast')
                                            AttachEntityToEntity(VehModel, bed, 0, attachmentOffset[1] + vector3(0.0, 0.0, vehiclePos.z - vehiclePos.z - 0.45), attachmentOffset[2], 0, 0, false, 0, 0, 1)
                                            car = VehModel
                                            DecorSetInt(veh, "flatbed3_car", VehToNet(VehModel))
                                            attached = true
                                            DecorSetBool(veh, "flatbed3_attached", attached)
                                        else
                                            ESX.ShowNotification('Er staat geen voertuig op de flatbed!')
                                        end
                                    else
                                        ESX.ShowNotification('Je kan geen groot voertuig op de flatbed zetten!')
                                    end
                                end
                            end
                        end
                    end
                    if drawMarker(controllerPos) then
                        if attached then
                            showHelpText(controllerMessageLoweredCar)
                        else
							
                            showHelpText(controllerMessageLoweredNoCar)
                        end
                        if IsControlJustPressed(0, 38) then
                            if PlayerData.job.name == 'mechanic' then
                                state = 4
                                DecorSetInt(veh, "flatbed3_state", state)
                            else
                                ESX.ShowNotification('Alleen werknemers van de ~o~ANWB~s~ kunnen de flatbed bedienen')
                            end
                        end
                        if IsControlJustPressed(0,20) then
                            if PlayerData.job.name == 'mechanic' and attached then
                                    DetachEntity(car, 0, 1)
                                    car = nil
                                    DecorSetInt(veh, "flatbed3_car", 0)
                                    attached = false
                                    DecorSetBool(veh, "flatbed3_attached", attached)
                             end
                        end 
                        if IsControlJustPressed(0, 47) then
                            if PlayerData.job.name == 'mechanic' then
                                if  not attached then
                                    CanPlaceVehicle = true
                                    Citizen.CreateThread(function() 
                                        Citizen.Wait(35000)
                                        CanPlaceVehicle = false
                                    end)
                                    ESX.ShowNotification("Loop naar een voertuig en druk op [G]")
                                end
                            else
                                ESX.ShowNotification('Alleen werknemers van de ~o~ANWB~s~ kunnen de flatbed bedienen')
                            end
                        end
                    end
                elseif state == 4 then
                    -- Raising
                    local offsetPos = raisedOffset[1] + backOffset[1]
                    local offsetRot = raisedOffset[2] + backOffset[2]

                    offsetPos = offsetPos + vector3(lerp(loweredOffset[1].x, 0.0, LERP_VALUE), lerp(loweredOffset[1].y, 0.0, LERP_VALUE), lerp(loweredOffset[1].z, 0.0, LERP_VALUE))
                    offsetRot = offsetRot + vector3(lerp(loweredOffset[2].x, 0.0, LERP_VALUE), lerp(loweredOffset[2].y, 0.0, LERP_VALUE), lerp(loweredOffset[2].z, 0.0, LERP_VALUE))

                    DetachEntity(bed, 0, 0)
                    AttachEntityToEntity(bed, veh, GetEntityBoneIndexByName(veh, "chassis"), offsetPos, offsetRot, 0, 0, 1, 0, 0, 1)

                    LERP_VALUE = LERP_VALUE + (1.0 * Timestep()) / 8.0

                    if LERP_VALUE >= 1.0 then
                        state = state + 1
                        DecorSetInt(veh, "flatbed3_state", state)
                        LERP_VALUE = 0.0
                    end
                elseif state == 5 then
                    -- Moving forward
                    local offsetPos = raisedOffset[1]
                    local offsetRot = raisedOffset[2]

                    offsetPos = offsetPos + vector3(lerp(backOffset[1].x, 0.0, LERP_VALUE), lerp(backOffset[1].y, 0.0, LERP_VALUE), lerp(backOffset[1].z, 0.0, LERP_VALUE))
                    offsetRot = offsetRot + vector3(lerp(backOffset[2].x, 0.0, LERP_VALUE), lerp(backOffset[2].y, 0.0, LERP_VALUE), lerp(backOffset[2].z, 0.0, LERP_VALUE))

                    DetachEntity(bed, 0, 0)
                    AttachEntityToEntity(bed, veh, GetEntityBoneIndexByName(veh, "chassis"), offsetPos, offsetRot, 0, 0, 1, 0, 0, 1)

                    LERP_VALUE = LERP_VALUE + (1.0 * Timestep()) / 16.0

                    if LERP_VALUE >= 1.0 then
                        state = 0
                        DecorSetInt(veh, "flatbed3_state", state)
                        LERP_VALUE = 0.0
                    end
                else
                    state = 0
                    DecorSetInt(veh, "flatbed3_state", state)
                end

                if not IsPedInVehicle(ped, veh, true) then

                end
            end
        end
        Wait(0)
    end
end)

-- Checken of het flatbedgedeelte er nog is
Citizen.CreateThread(function() 
    while true do 
        Citizen.Wait(5000) 
        BedCheck()
    end
end)