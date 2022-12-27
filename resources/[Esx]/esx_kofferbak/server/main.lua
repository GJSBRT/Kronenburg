--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
ESX = nil
local arrayWeight = Config.localWeight
local VehicleList = {}

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

RegisterServerEvent('esx_truck_inventory:getOwnedVehicule')
AddEventHandler('esx_truck_inventory:getOwnedVehicule', function()
    local vehicules = {}
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    MySQL.Async.fetchAll(
        'SELECT * FROM owned_vehicles WHERE owner = @owner',
        {
            ['@owner'] = xPlayer.identifier
        },
        function(result)
            if result ~= nil and #result > 0 then
                for _, v in pairs(result) do
                    local vehicle = json.decode(v.vehicle)
                    table.insert(vehicules, { plate = vehicle.plate })
                end
            end
            TriggerClientEvent('esx_truck_inventory:setOwnedVehicule', _source, vehicules)
        end)
end)

RegisterServerEvent('esx_truck_inventory:getInventory')
AddEventHandler('esx_truck_inventory:getInventory', function(plate)
    local inventory_ = {}
    local _source = source
    MySQL.Async.fetchAll(
        'SELECT * FROM `truck_inventory` WHERE `plate` = @plate',
        {
            ['@plate'] = plate
        },
        function(inventory)
            if inventory ~= nil and #inventory > 0 then
                for i = 1, #inventory, 1 do
                    if inventory[i].count > 0 then
                        table.insert(inventory_, {
                            label = inventory[i].name,
                            name = inventory[i].item,
                            count = inventory[i].count,
                            type = inventory[i].itemt
                        })
                    end
                end
            end
            local weight = (getInventoryWeight(inventory_))
            local xPlayer = ESX.GetPlayerFromId(_source)
            TriggerClientEvent('esx_truck_inventory:getInventoryLoaded', xPlayer.source, inventory_, weight)
        end)
end)

function round(num, numDecimalPlaces)
    local mult = 10 ^ (numDecimalPlaces or 0)
    return math.floor(num * mult + 0.05) / mult
end

RegisterServerEvent('esx_truck_inventory:removeInventoryItem')
AddEventHandler('esx_truck_inventory:removeInventoryItem', function(plate, item, itemType, count)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if plate ~= " " or plate ~= nil or plate ~= "" then
        MySQL.Async.fetchScalar('SELECT `count` FROM truck_inventory WHERE `plate` = @plate AND `item`= @item AND `itemt`= @itemt',
            {
                ['@plate'] = plate,
                ['@item'] = item,
                ['@itemt'] = itemType
            }, function(countincar)
            if countincar >= count then
                MySQL.Async.execute('UPDATE `truck_inventory` SET `count`= `count` - @qty WHERE `plate` = @plate AND `item`= @item AND `itemt`= @itemt',
                    {
                        ['@plate'] = plate,
                        ['@qty'] = count,
                        ['@item'] = item,
                        ['@itemt'] = itemType
                    })
                if xPlayer ~= nil then
                    if itemType == 'item_standard' then
                        xPlayer.addInventoryItem(item, count)
                        sendToItemPak('Item Gepakt', "[Gepakt]\nUser: " .. xPlayer.name .. "\nWeapon:" .. item .. "\nHoeveelheid:" .. count .. "\nKenteken:" .. plate .. "\nType:" .. itemType, 15158332)
                    end

                    if itemType == 'item_account' then
                        xPlayer.addAccountMoney(item, count)
                        sendToMoneyPak('Item Gepakt', "[Gepakt]\nUser: " .. xPlayer.name .. "\nWeapon:" .. item .. "\nHoeveelheid" .. count .. "\nKenteken:" .. plate .. "\nType" .. itemType, 15158332)
                    end

                    if itemType == 'item_weapon' then

                        MySQL.Async.fetchScalar('SELECT `ammo` FROM truck_inventory WHERE `plate` = @plate AND `item`= @item AND `itemt`= @itemt',
                            {
                                ['@plate'] = plate,
                                ['@item'] = item,
                                ['@itemt'] = itemType
                            }, function(ammo)
                            while ammo == nil do Wait(0) end
                            ammo = tonumber(ammo)
                            if ammo ~= -1 and ammo ~= 0 and ammo > 0 then
                                ammo = ammo
                            else
                                ammo = 0
                            end

                            xPlayer.addWeapon(item, ammo)
                            MySQL.Async.execute("DELETE FROM truck_inventory WHERE plate = @plate AND item = @item",
                                {
                                    ["@plate"] = plate,
                                    ["@item"] = item
                                })
                            sendToWeaponPak('Wapen Gepakt', "[Gepakt]\nUser: " .. xPlayer.name .. "\nWeapon: " .. item .. "\nAmmo: " .. ammo .. "\nKenteken: " .. plate .. "\nType: " .. itemType, 15158332)
                        end)
                    end
                end
            end
        end)
    end
end)

RegisterServerEvent('esx_truck_inventory:addInventoryItem')
AddEventHandler('esx_truck_inventory:addInventoryItem', function(type, model, plate, item, qtty, name, itemType, ownedV, ammo)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if plate ~= " " or plate ~= nil or plate ~= "" then
        if xPlayer ~= nil then
            if itemType == 'item_standard' then
                local playerItemCount = xPlayer.getInventoryItem(item).count
                if playerItemCount >= qtty then
                    xPlayer.removeInventoryItem(item, qtty)
                    putInTrunk(plate, qtty, item, name, itemType, ownedV)

                    sendToItemLeg('Item Gelegd', "[Gelegd]\nUser: " .. xPlayer.name .. "\nID:" .. source .. "\nItem" .. item .. "\nhoeveelheid:" .. qtty .. "\nKenteken:" .. plate .. "\nNaam:" .. name .. "\nType" .. itemType, 15158332)
                else
                    TriggerClientEvent('esx:showNotification', _source, 'quantité invalide')
                end
            end

            if itemType == 'item_account' then
                local playerAccountMoney = xPlayer.getAccount(item).money
                if playerAccountMoney >= qtty then
                    xPlayer.removeAccountMoney(item, qtty)
                    putInTrunk(plate, qtty, item, name, itemType, ownedV)
                    sendToMoneyLeg('Geld Gelegd', "[Gelegd]\nUser: " .. xPlayer.name .. "\nID:" .. _source .. "\nitem" .. item .. "\nHoeveelheid" .. qtty .. "\nKenteken" .. plate .. "\nNaam:" .. name .. "\nItem:" .. itemType, 15158332)
                end
            end

            if itemType == 'item_weapon' then
                currentLoadout = xPlayer.getLoadout()
                for i = 1, #currentLoadout, 1 do
                    if currentLoadout[i].name == item then
                        qtty = tonumber(qtty)
                        ammo = tonumber(ammo)

                        xPlayer.removeWeapon(item, qtty)
                        putInTrunk(plate, qtty, item, name, itemType, ownedV, ammo)

                        sendToWeaponLeg('Wapen Gelegd', "[Gelegd]\n@here \nUser: " .. xPlayer.name .. "\nID:" .. _source .. "\nWeapon" .. item .. "\nHoeveelheid (ammo) " .. ammo .. "\nKenteken:" .. plate .. "\nNaam:" .. name .. "\nItem:" .. itemType, 15158332)
                    end
                end
            end
        end
    end
end)

ESX.RegisterServerCallback('esx_truck:checkvehicle', function(source, cb, vehicleplate)
    local isFound = false
    local _source = source
    local plate = vehicleplate
    if plate ~= " " or plate ~= nil or plate ~= "" then
        for _, v in pairs(VehicleList) do
            if (plate == v.vehicleplate) then
                isFound = true
                break

            end
        end
    else
        isFound = true
    end
    cb(isFound)
end)

RegisterServerEvent('esx_truck_inventory:AddVehicleList')
AddEventHandler('esx_truck_inventory:AddVehicleList', function(plate)
    local plateisfound = false
    if plate ~= " " or plate ~= nil or plate ~= "" then
        for _, v in pairs(VehicleList) do
            if (plate == v.vehicleplate) then
                plateisfound = true
                break
            end
        end
        if not plateisfound then
            table.insert(VehicleList, { vehicleplate = plate })
        end
    end
end)

RegisterServerEvent('esx_truck_inventory:RemoveVehicleList')
AddEventHandler('esx_truck_inventory:RemoveVehicleList', function(plate)
    for i = 1, #VehicleList, 1 do
        if VehicleList[i].vehicleplate == plate then
            if VehicleList[i].vehicleplate ~= " " or plate ~= " " or VehicleList[i].vehicleplate ~= nil or plate ~= nil or VehicleList[i].vehicleplate ~= "" or plate ~= "" then
                table.remove(VehicleList, i)
                break
            end
        end
    end
end)

AddEventHandler('onMySQLReady', function()
    MySQL.Async.execute('DELETE FROM `truck_inventory` WHERE `count` = 0', {})
end)

function getInventoryWeight(inventory)
    local weight = 0
    local itemWeight = 0

    if inventory ~= nil then
        for i = 1, #inventory, 1 do
            if inventory[i] ~= nil then
                itemWeight = Config.DefaultWeight
                if arrayWeight[inventory[i].name] ~= nil then
                    itemWeight = arrayWeight[inventory[i].name]
                end
                weight = weight + (itemWeight * inventory[i].count)
            end
        end
    end
    return weight
end

function putInTrunk(plate, qtty, item, name, itemType, ownedV, ammo)
    MySQL.Async.execute('INSERT INTO truck_inventory (item,count,plate,name,itemt,owned,ammo) VALUES (@item,@qty,@plate,@name,@itemt,@owned,@ammo) ON DUPLICATE KEY UPDATE count=count+ @qty',
        {
            ['@plate'] = plate,
            ['@qty'] = qtty,
            ['@item'] = item,
            ['@name'] = name,
            ['@itemt'] = itemType,
            ['@owned'] = ownedV,
            ['@ammo'] = ammo,
        })
end

function dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k, v in pairs(o) do
            if type(k) ~= 'number' then k = '"' .. k .. '"' end
            s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end

function sendToItemPak(name, message, color)
    local DiscordWebHook = "https://discord.com/api/webhooks/938916478219075624/VVfsL2TFuc-X1ERCgGF2Sp4aptFwN6FIQMqUQsj8FtFcBbr4pmB8uEnP2ymytXJroHWy"

    local embeds = {
        {
            ["title"] = message,
            ["type"] = "rich",
            ["color"] = color,
            ["footer"] = {
                ["text"] = "logs",
            },
        }
    }

    if message == nil or message == '' then return false end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name, embeds = embeds }), { ['Content-Type'] = 'application/json' })
end

function sendToItemLeg(name, message, color)
    local DiscordWebHook = "https://discord.com/api/webhooks/938916478219075624/VVfsL2TFuc-X1ERCgGF2Sp4aptFwN6FIQMqUQsj8FtFcBbr4pmB8uEnP2ymytXJroHWy"

    local embeds = {
        {
            ["title"] = message,
            ["type"] = "rich",
            ["color"] = color,
            ["footer"] = {
                ["text"] = "logs",
            },
        }
    }

    if message == nil or message == '' then return false end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name, embeds = embeds }), { ['Content-Type'] = 'application/json' })
end

function sendToMoneyLeg(name, message, color)
    local DiscordWebHook = "https://discord.com/api/webhooks/938916478219075624/VVfsL2TFuc-X1ERCgGF2Sp4aptFwN6FIQMqUQsj8FtFcBbr4pmB8uEnP2ymytXJroHWy"

    local embeds = {
        {
            ["title"] = message,
            ["type"] = "rich",
            ["color"] = color,
            ["footer"] = {
                ["text"] = "logs",
            },
        }
    }

    if message == nil or message == '' then return false end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name, embeds = embeds }), { ['Content-Type'] = 'application/json' })
end

function sendToMoneyPak(name, message, color)
    local DiscordWebHook = "https://discord.com/api/webhooks/938916478219075624/VVfsL2TFuc-X1ERCgGF2Sp4aptFwN6FIQMqUQsj8FtFcBbr4pmB8uEnP2ymytXJroHWy"

    local embeds = {
        {
            ["title"] = message,
            ["type"] = "rich",
            ["color"] = color,
            ["footer"] = {
                ["text"] = "logs",
            },
        }
    }

    if message == nil or message == '' then return false end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name, embeds = embeds }), { ['Content-Type'] = 'application/json' })
end

function sendToWeaponLeg(name, message, color)
    local DiscordWebHook = "https://discord.com/api/webhooks/938916478219075624/VVfsL2TFuc-X1ERCgGF2Sp4aptFwN6FIQMqUQsj8FtFcBbr4pmB8uEnP2ymytXJroHWy"

    local embeds = {
        {
            ["title"] = message,
            ["type"] = "rich",
            ["color"] = color,
            ["footer"] = {
                ["text"] = "logs",
            },
        }
    }

    if message == nil or message == '' then return false end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name, embeds = embeds }), { ['Content-Type'] = 'application/json' })
end

function sendToWeaponPak(name, message, color)
    local DiscordWebHook = "https://discord.com/api/webhooks/938916478219075624/VVfsL2TFuc-X1ERCgGF2Sp4aptFwN6FIQMqUQsj8FtFcBbr4pmB8uEnP2ymytXJroHWy"

    local embeds = {
        {
            ["title"] = message,
            ["type"] = "rich",
            ["color"] = color,
            ["footer"] = {
                ["text"] = "logs",
            },
        }
    }

    if message == nil or message == '' then return false end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name, embeds = embeds }), { ['Content-Type'] = 'application/json' })
end
