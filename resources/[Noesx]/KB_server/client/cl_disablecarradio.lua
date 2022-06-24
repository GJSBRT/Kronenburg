cars_enabled = {
    "POLFIETS",
    'POLTOURAN2016',
    'POLMERC',
    'MERCEDESB',
    'POLVITO2016',
    'POLTRANSPORTER6',
    'POLTRANSPORTER5',
    'POLITIEATBUS',
    'POLGOLF7OOV',
    'POLMOTOR',
    'BABSAMAROK',
    'POLMOTOR3',
    'POLAUDI',
    'POLAUDI2',
    'POLITIETOURANK9',
    'POLRS6',
    'BASAMAROK',
    'UPOLITIEA4',
    'POLBMWX5V2',
    'DSIVITO',
    'OV3',
    'DSIQ5',
    'POLMOTORUN',
    'DSIMERC',
    'POLBUS3',
    'VWTOUAREG',
    'DINGHY4',
    'POLMAV',
    'BABSAMAROK',
    'POLITIEXC90',
    'POLJEEP',
}

local function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

RegisterNetEvent("carradio:enteredveh")
AddEventHandler("carradio:enteredveh", function(targetVehicle, vehicleSeat, vehicleDisplayName)
    Wait(2000)
    if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
        local playerPed = GetPlayerPed(-1)
        local veh = GetVehiclePedIsIn(playerPed)
        local vehName = GetDisplayNameFromVehicleModel(GetEntityModel(veh))

        if (has_value(cars_enabled, vehName:upper())) then
            SetUserRadioControlEnabled(false)
            if GetPlayerRadioStationName() ~= nil then
                SetVehRadioStation(GetVehiclePedIsIn(PlayerPedId()), "OFF")
            end
        end
    end
end)


RegisterNetEvent("carradio:enable")
AddEventHandler("carradio:enable", function()
    SetUserRadioControlEnabled(true)
end)

RegisterNetEvent("carradio:disable")
AddEventHandler("carradio:disable", function()
    SetUserRadioControlEnabled(false)
    if GetPlayerRadioStationName() ~= nil then
        SetVehRadioStation(GetVehiclePedIsIn(PlayerPedId()), "OFF")
    end
end)

RegisterNetEvent("carradio:addVehicle")
AddEventHandler("carradio:addVehicle", function(vehName)
    table.insert(cars_enabled, vehName)
end)