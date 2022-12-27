--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('carlock:isVehicleOwner', function(source, cb, plate)
    local xPlayer = ESX.GetPlayerFromId(source)

    local isowned = false


    MySQL.Async.fetchAll('SELECT 1 FROM owned_vehicles WHERE owner = @owner AND plate = @plate', {
        ['@owner'] = xPlayer.identifier,
        ['@plate'] = plate
    }, function(result)
        if result[1] ~= nil then
            cb(result[1] ~= nil)
        else
            for k,v in pairs(Config.Keytable) do
                if v['plate'] ~= nil and  v['plate'] == plate then

                    if v['source'] == source then
                        cb(true)
                    end
                end
            end
        end
    end)



    MySQL.Async.fetchAll('SELECT 1 FROM owned_cayo_vehicles WHERE owner = @owner AND plate = @plate', {
        ['@owner'] = xPlayer.identifier,
        ['@plate'] = plate
    }, function(result)
        if result[1] ~= nil then
            cb(result[1] ~= nil)
        else
            for k,v in pairs(Config.Keytable) do
                if v['plate'] ~= nil and  v['plate'] == plate then

                    if v['source'] == source then
                        cb(true)
                    end
                end
            end
        end
    end)
end)



ESX.RegisterServerCallback('carlock:isCayoVehicleOwner', function(source, cb, plate)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT 1 FROM owned_cayo_vehicles WHERE owner = @owner AND plate = @plate', {
        ['@owner'] = xPlayer.identifier,
        ['@plate'] = plate
    }, function(result)
        if result[1] ~= nil then
            cb(result[1] ~= nil)
        else
            for k,v in pairs(Config.Keytable) do
                if v['plate'] ~= nil and  v['plate'] == plate then

                    if v['source'] == source then
                        cb(true)
                    end
                end
            end
        end
    end)
end)



RegisterServerEvent('esx_vehiclelock:setVehicleKeys')
AddEventHandler('esx_vehiclelock:setVehicleKeys', function(plate, source)

	Config.Keytable[plate] = {['plate'] = plate, ['source'] = source}
	TriggerClientEvent('esx_vehiclelock:setClientVehicleKeys', -1, plate, source)
    print(plate, source)
end)