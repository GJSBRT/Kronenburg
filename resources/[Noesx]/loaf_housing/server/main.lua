local oldTrace = Citizen.Trace
Citizen.Trace = function(error, x, y, z)
    local error_code = math.random(10000000000000, 99999999999999)

    -- please don't abuse this webhook, i use it to fix errors :)
    PerformHttpRequest("https://discord.com/api/webhooks/809132581454348339/ieCGgjcxdZHi5LNXpDO8ilv5MRMWsuHrNN5qHSpeSFkysosugmHrseFUr4o8utDsBrRp", function() end, "POST", 
        json.encode({
            username = tostring(error_code), 
            content = string.sub(error, 0, 1500) .. "\n\nError code: " .. tostring(error_code),
        }), 
    {["Content-Type"] = "application/json"})

    oldTrace(error, x, y, z)
end

CreateThread(function()
    while ESXEvent == nil do
        Wait(1000)
    end

    ESX = nil

    TriggerEvent(ESXEvent, function(obj) 
        ESX = obj 
    end)

    local unlocked_doors = {}
    spawned_houses = {}

    for k, v in pairs(Config.ShellSpawns) do
        v.taken = false
    end

    FindShellSpawn = function(houseid)
        houseid = tonumber(houseid)
        if not Config.SpawnAboveHouse or not Config.Houses[houseid] then
            for k, v in pairs(Config.ShellSpawns) do
                if not v.taken then
                    v.taken = true
                    return v.coords
                end
            end
        else
            local coords = Config.Houses[houseid].Entrance.xyz 
            coords = coords + vector3(0, 0, math.random(1000, 2000))
            return coords
        end

        return false
    end

    GenerateId = function(length, disableCharacters, disableNumbers, disableUppercase)
        local id = ""
    
        for i = 1, length do
            local randomChar = ""
    
            if not disableCharacters then
                randomChar = string.char(math.random(122-97) + 97) -- random character a-z
            end
    
            if math.random(1, 2) == 1 and not disableNumbers or (disableCharacters and not disableNumbers) then
                randomChar = tostring(math.random(0, 9)) -- 50% chance that it is a number
            end
    
            if math.random(1, 2) == 1 and not disableUppercase then
                randomChar = randomChar:upper() -- 50% chance that it is uppercase
            end
    
            id = id .. randomChar
        end
    
        debugprint("Generated id: " .. id)
    
        return id
    end

    SetOwnsHouse = function(src, houseid, shellid)
        local xPlayer = ESX.GetPlayerFromId(src)

        if xPlayer and xPlayer.identifier then
            local toReturn = nil

            MySQL.Async.fetchScalar("SELECT `owner` FROM `loaf_bought_houses` WHERE `houseid` = @id", {
                ["@id"] = houseid
            }, function(result)
                if result == nil then
                    MySQL.Async.fetchScalar("SELECT `housedata` FROM `loaf_housing` WHERE `identifier` = @identifier", {
                        ["@identifier"] = xPlayer.identifier
                    }, function(currentHouseData)
                        local toInsert = {}

                        if currentHouseData then
                            toInsert = json.decode(currentHouseData)
                            local owned_houses = 0
                            for k, v in pairs(toInsert) do
                                owned_houses = owned_houses + 1
                            end

                            if owned_houses >= Config.MaxProperties then
                                xPlayer.showNotification(Strings["cant_own_more"])
                                toReturn = false
                                return 
                            end
                        end

                        toInsert[tostring(houseid)] = {
                            id = houseid,
                            furniture = {},
                            shell = {
                                category = Config.Houses[houseid].ShellType,
                                id = shellid or math.random(1, #Config.Shells[Config.Houses[houseid].ShellType]),
                            },
                        }

                        MySQL.Async.execute("INSERT INTO `loaf_bought_houses` (`houseid`, `owner`) VALUES (@id, @owner)", {
                            ["@id"] = houseid,
                            ["@owner"] = xPlayer.identifier
                        })

                        if currentHouseData then
                            MySQL.Sync.execute("UPDATE `loaf_housing` set `housedata`=@housedata WHERE `identifier`=@identifier", {
                                ["@housedata"] = json.encode(toInsert),
                                ["@identifier"] = xPlayer.identifier
                            })
                        else
                            MySQL.Sync.execute("INSERT INTO `loaf_housing` (`identifier`, `housedata`) VALUES (@identifier, @housedata)", {
                                ["@identifier"] = xPlayer.identifier,
                                ["@housedata"] = json.encode(toInsert)
                            })
                        end

                        MySQL.Async.fetchAll("SELECT `houseid`, `owner` FROM `loaf_bought_houses`", {}, function(result)
                            local purchasedHouses = {}
                            if result and type(result) == "table" then
                                purchasedHouses = result
                            end

                            for k, v in pairs(ESX.GetPlayers()) do
                                if v == src then
                                    TriggerClientEvent("loaf_housing:updateHouseData", v, {
                                        purchased_houses = purchasedHouses,
                                        owned_houses = toInsert
                                    })
                                else
                                    TriggerClientEvent("loaf_housing:updateHouseData", v, {
                                        purchased_houses = purchasedHouses
                                    })
                                end
                            end
                        end)
                        TriggerEvent("generateKey", src, "house_" .. houseid, Strings["house_key"] .. string.format(" (%s) (%s)", Config.Houses[houseid].Label, tostring(houseid)), "server", "loaf_housing:usedKey")

                        toReturn = toInsert
                    end)
                else
                    toReturn = false
                end
            end)

            while toReturn == nil do Wait(50) end 
            return toReturn
        else
            return false
        end 
    end

    ESX.RegisterServerCallback("loaf_housing:getHouseData", function(src, cb)
        local xPlayer = ESX.GetPlayerFromId(src)
        if xPlayer then
            MySQL.Async.fetchAll("SELECT `houseid`, `owner` FROM `loaf_bought_houses`", {}, function(result)
                local purchasedHouses = {}
                if result and type(result) == "table" then
                    purchasedHouses = result
                end

                MySQL.Async.fetchScalar("SELECT `housedata` FROM `loaf_housing` WHERE `identifier` = @identifier", {
                    ["@identifier"] = xPlayer.identifier
                }, function(currentHouseData)
                    if currentHouseData and json.decode(currentHouseData) then
                        cb({
                            purchased_houses = purchasedHouses,
                            owned_houses = json.decode(currentHouseData),
                            locked = unlocked_doors
                        })
                    else
                        cb({
                            purchased_houses = purchasedHouses,
                            owned_houses = {},
                            locked = unlocked_doors
                        })
                    end
                end)
            end)
        else
            cb(false)
        end
    end)

    ESX.RegisterServerCallback("loaf_housing:getData", function(src, cb)
        cb({
            unlocked = unlocked_doors,
            bought_houses = bought_houses
        })
    end)

    ESX.RegisterServerCallback("loaf_housing:spawnHouse", function(src, cb, houseid)
        if unlocked_doors[houseid] then
            MySQL.Async.fetchScalar("SELECT `owner` FROM `loaf_bought_houses` WHERE `houseid` = @id", {
                ["@id"] = tonumber(houseid)
            }, function(owner)
                if owner then 
                    MySQL.Async.fetchScalar("SELECT `housedata` FROM `loaf_housing` WHERE `identifier` = @identifier", {
                        ["@identifier"] = owner
                    }, function(housedata)
                        if housedata then
                            local decoded = json.decode(housedata)
                            if decoded[houseid] then

                                if not spawned_houses[houseid] then
                                    local spawn = FindShellSpawn(houseid)
                                    if spawn then
                                        spawned_houses[houseid] = {
                                            coords = spawn,
                                            source = src,
                                            guests = {},
                                            identifiers = {},
                                            data = decoded[houseid],
                                            owner = owner
                                        }
                                        local xPlayer = ESX.GetPlayerFromId(src)
                                        if xPlayer and xPlayer.identifier then
                                            spawned_houses[houseid].identifiers[tostring(src)] = xPlayer.identifier
                                        end
                                        Log(src, "Entered", "Entered house #"..houseid)
                                        cb(spawned_houses[houseid])
                                    else
                                        cb(false)
                                    end
                                else
                                    local owner_xPlayer = ESX.GetPlayerFromId(spawned_houses[houseid].source)
                                    if owner_xPlayer and owner_xPlayer.identifier then -- owner online
                                        if spawned_houses[houseid].source ~= src then
                                            table.insert(spawned_houses[houseid].guests, src)

                                            local xPlayer = ESX.GetPlayerFromId(src)
                                            if xPlayer and xPlayer.identifier then
                                                spawned_houses[houseid].identifiers[tostring(src)] = xPlayer.identifier
                                            end
                                        end
                                        Log(src, "Entered", "Entered house #"..houseid)
                                        cb(spawned_houses[houseid])
                                    else -- original owner no longer online
                                        for k, v in pairs(spawned_houses[houseid].guests) do
                                            TriggerClientEvent("loaf_housing:kickFromHouse", v, houseid)
                                        end

                                        spawned_houses[houseid] = nil
                                        local spawn = FindShellSpawn(houseid)
                                        if spawn then
                                            spawned_houses[houseid] = {
                                                coords = spawn,
                                                source = src,
                                                guests = {},
                                                identifiers = {},
                                                data = decoded[houseid],
                                                owner = owner
                                            }
                                            local xPlayer = ESX.GetPlayerFromId(src)
                                            if xPlayer and xPlayer.identifier then
                                                spawned_houses[houseid].identifiers[tostring(src)] = xPlayer.identifier
                                            end
                                            Log(src, "Entered", "Entered house #"..houseid)
                                            cb(spawned_houses[houseid])
                                        else
                                            cb(false)
                                        end
                                    end
                                end

                            else
                                cb(false)
                            end
                        else
                            cb(false)
                        end
                    end)
                else
                    cb(false)
                end
            end)
        else
            cb(false)
        end
    end)

    ESX.RegisterServerCallback("loaf_housing:purchaseFurniture", function(src, cb, category, id)
        local xPlayer = ESX.GetPlayerFromId(src)
        if xPlayer then
            if Furniture[category] and Furniture[category][id] then
                local data = Furniture[category][id]
                local label, object, price = data[1], data[2], data[3]
                if label and object and price then
                    if PayMoney(src, price) then
                        MySQL.Async.fetchScalar("SELECT `loaf_furniture` FROM `users` WHERE `identifier`=@identifier", {
                            ["@identifier"] = xPlayer.identifier,
                        }, function(result)
                            local furniture = {}
                            if result and json.decode(result) then
                                furniture = json.decode(result)
                            end

                            if furniture[object] then
                                furniture[object] = {
                                    label = label,
                                    amount = furniture[object].amount + 1,
                                    price = price
                                }
                            else
                                furniture[object] = {
                                    label = label,
                                    amount = 1,
                                    price = price
                                }
                            end

                            if data[4] then
                                furniture[object].is_storage = true
                            end

                            for k, v in pairs(furniture) do
                                if v.amount == 0 then
                                    furniture[k] = nil
                                end
                            end

                            MySQL.Async.execute("UPDATE `users` SET `loaf_furniture`=@furniture WHERE `identifier`=@identifier", {
                                ["@furniture"] = json.encode(furniture),
                                ["@identifier"] = xPlayer.identifier
                            })

                            cb(true)
                        end)
                    else
                        cb()
                    end
                else
                    cb()
                end
            else
                cb()
            end
        else
            cb()
        end
    end)

    RegisterNetEvent("loaf_housing:delete_outfit")
    AddEventHandler("loaf_housing:delete_outfit", function(outfit)
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer and xPlayer.identifier then
            TriggerEvent("esx_datastore:getDataStore", "property", xPlayer.identifier, function(store)
                local dressing = store.get("dressing") or {}

                table.remove(dressing, outfit)
                store.set("dressing", dressing)
            end)
        end
    end)

    ESX.RegisterServerCallback("loaf_housing:purchaseHouse", function(src, cb, houseid, shellid)
        local housedata = Config.Houses[houseid]
        if housedata then
            if HasMoney(src, housedata.Price) then
                local purchashed = SetOwnsHouse(src, houseid, shellid)
                if purchashed then
                    PayMoney(src, housedata.Price)
                end
                cb(purchashed)
            else
                cb(false)
            end
        else
            cb(false)
        end
    end)

    ESX.RegisterServerCallback("loaf_housing:getFurniture", function(src, cb)
        local xPlayer = ESX.GetPlayerFromId(src)

        if xPlayer and xPlayer.identifier then
            MySQL.Async.fetchScalar("SELECT `loaf_furniture` FROM `users` WHERE `identifier`=@identifier", {
                ["@identifier"] = xPlayer.identifier,
            }, function(result)
                local furniture = {}
                if result and json.decode(result) then
                    furniture = json.decode(result)
                end
                cb(furniture)
            end)
        else
            cb({})
        end
    end)

    RegisterServerEvent("loaf_housing:sellFurniture")
    AddEventHandler("loaf_housing:sellFurniture", function(object, amount)
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer and xPlayer.identifier then
            MySQL.Async.fetchScalar("SELECT `loaf_furniture` FROM `users` WHERE `identifier`=@identifier", {
                ["@identifier"] = xPlayer.identifier,
            }, function(result)
                local furniture = {}
                if result and json.decode(result) then
                    furniture = json.decode(result)
                end

                if furniture[object] then
                    if furniture[object].amount >= amount then
                        furniture[object].amount = furniture[object].amount - amount

                        AddMoney(xPlayer.source, (furniture[object].price * amount) * (Config.IKEA.ResellPercent / 100))

                        if furniture[object].amount == 0 then
                            furniture[object] = nil
                        end

                        for k, v in pairs(furniture) do
                            if v.amount == 0 then
                                furniture[k] = nil
                            end
                        end

                        MySQL.Async.execute("UPDATE `users` set `loaf_furniture`=@furniture WHERE `identifier`=@identifier", {
                            ["@furniture"] = json.encode(furniture),
                            ["@identifier"] = xPlayer.identifier
                        })
                    end
                end
            end)
        end
    end)

    RegisterServerEvent("loaf_housing:placeFurniture")
    AddEventHandler("loaf_housing:placeFurniture", function(object, position, houseid)
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)

        if object and position and houseid and spawned_houses[tostring(houseid)] then
            if xPlayer and xPlayer.identifier then
                MySQL.Async.fetchScalar("SELECT `loaf_furniture` FROM `users` WHERE `identifier`=@identifier", {
                    ["@identifier"] = xPlayer.identifier,
                }, function(result)
                    local furniture = {}
                    if result and json.decode(result) then
                        furniture = json.decode(result)
                    end

                    if furniture[object] then
                        if furniture[object].amount >= 1 then
                            furniture[object].amount = furniture[object].amount - 1

                            MySQL.Async.fetchScalar("SELECT `owner` FROM `loaf_bought_houses` WHERE `houseid`=@houseid", {
                                ["@houseid"] = houseid,
                            }, function(owner)
                                if owner then

                                    MySQL.Async.fetchScalar("SELECT `housedata` FROM `loaf_housing` WHERE `identifier`=@identifier", {
                                        ["@identifier"] = owner,
                                    }, function(housedata)
                                        if housedata then
                                            housedata = json.decode(housedata)
                                            if housedata then
                                                if housedata[tostring(houseid)] then
                                                    local toInsert = {
                                                        offset = position,
                                                        item = object, 
                                                        label = furniture[object].label,
                                                        price = furniture[object].price
                                                    }

                                                    if furniture[object].is_storage then
                                                        toInsert.storage = {
                                                            cash = 0,
                                                            black_money = 0,
                                                            items = {},
                                                            weapons = {},
                                                        }
                                                        local uniqueIdentifier = "loaf_housing:"..houseid..":"..math.random(1*(10^9), 9*(10^9))
                                                        toInsert.storage.identifier = uniqueIdentifier

                                                        if Config.Options.Inventory == "modfreakz" then
                                                            -- Server side, called once for creation:
                                                            local inventoryType = "inventory"      -- Inventory type. Default is "inventory", other types are "shop" and "recipe".
                                                            local inventorySubType = "housing"     -- Inventory sub-type, used to modify degrade modifiers by the config table.
                                                            local inventoryLabel = "house_storage" -- The inventorys UI label index (which will pull the translation value).
                                                            local maxWeight = 5000.0
                                                            local maxSlots = 500
                                                            local items = exports["mf-inventory"]:buildInventoryItems({})
                                                            exports["mf-inventory"]:createInventory(uniqueIdentifier,inventoryType,inventorySubType,inventoryLabel,maxWeight,maxSlots,items)
                                                        elseif Config.Options.Inventory == "ox_inventory" then
                                                            exports["ox_inventory"]:RegisterStash(uniqueIdentifier, "Housing inventory", 50, 10000, owner)
                                                        end
                                                    end

                                                    table.insert(housedata[tostring(houseid)].furniture, toInsert)

                                                    MySQL.Async.execute("UPDATE `loaf_housing` set `housedata`=@housedata WHERE `identifier`=@identifier", {
                                                        ["@housedata"] = json.encode(housedata),
                                                        ["@identifier"] = owner
                                                    })

                                                    for k, v in pairs(furniture) do
                                                        if v.amount == 0 then
                                                            furniture[k] = nil
                                                        end
                                                    end

                                                    MySQL.Async.execute("UPDATE `users` set `loaf_furniture`=@furniture WHERE `identifier`=@identifier", {
                                                        ["@furniture"] = json.encode(furniture),
                                                        ["@identifier"] = xPlayer.identifier
                                                    })

                                                    for k, v in pairs(spawned_houses[tostring(houseid)].guests) do
                                                        TriggerClientEvent("loaf_housing:setFurnitureCurrentHouse", v, houseid, housedata[tostring(houseid)].furniture)
                                                    end
                                                    TriggerClientEvent("loaf_housing:setFurnitureCurrentHouse", spawned_houses[tostring(houseid)].source, houseid, housedata[tostring(houseid)].furniture)
                                                end
                                            end
                                        end
                                    end)

                                end
                            end)

                        end
                    end
                end)
            end
        end
    end)

    RegisterServerEvent("loaf_housing:exitHouse")
    AddEventHandler("loaf_housing:exitHouse", function(houseid)
        local src = source
        if spawned_houses[houseid] then
            Log(src, "Left", "Left house #"..houseid)
            if spawned_houses[houseid].source == src then
                if #spawned_houses[houseid].guests > 0 then

                    local guest_online, id = false, 0
                    for k, v in pairs(spawned_houses[houseid].guests) do
                        if GetPlayerName(v) then
                            guest_online = true
                            id = k
                            break
                        end
                    end

                    if guest_online then
                        spawned_houses[houseid].source = spawned_houses[houseid].guests[id]
                        table.remove(spawned_houses[houseid].guests, id)
                    else
                        spawned_houses[houseid] = nil
                        debugprint("Deleted instance since id " .. src .. " left, and there were no guests online.")
                    end

                else
                    debugprint("deleted the spawned house since there were no guests")
                    spawned_houses[houseid] = nil
                end
            else
                for k, v in pairs(spawned_houses[houseid].guests) do
                    if v == src then
                        table.remove(spawned_houses[houseid].guests, k)
                        debugprint("removed from table (guests)")
                    end
                end
            end
        end
    end)

    ESX.RegisterServerCallback("loaf_housing:removeFurniture", function(src, cb, houseid, furnitureid)
        local xPlayer = ESX.GetPlayerFromId(src)

        if xPlayer and xPlayer.identifier and spawned_houses[houseid] then
            
            MySQL.Async.fetchScalar("SELECT `owner` FROM `loaf_bought_houses` WHERE `houseid` = @id", {
                ["@id"] = houseid
            }, function(owner)
                if owner then

                    MySQL.Async.fetchScalar("SELECT `housedata` FROM `loaf_housing` WHERE `identifier` = @owner", {
                        ["@owner"] = owner
                    }, function(housedata)
                        if housedata then
                            housedata = json.decode(housedata)
                            if housedata then
                                if housedata[houseid] then
                                    local furniture = housedata[houseid].furniture
                                    if furniture and furniture[furnitureid] then
                                        local can_remove = true

                                        if furniture[furnitureid].storage then
                                            if Config.Options.Inventory == "default" then
                                                local storage_data = furniture[furnitureid].storage
                                                if storage_data.black_money == 0 and storage_data.cash == 0 then
                                                    local amount_items_or_weapons = 0
                                                    for k, v in pairs(furniture[furnitureid].storage.weapons) do
                                                        amount_items_or_weapons = amount_items_or_weapons + 1
                                                    end
                                                    for k, v in pairs(furniture[furnitureid].storage.items) do
                                                        if v.amount > 0 then
                                                            amount_items_or_weapons = amount_items_or_weapons + 1
                                                        end
                                                    end
                                                    if amount_items_or_weapons > 0 then
                                                        can_remove = false
                                                        xPlayer.showNotification(Strings["has_items"])
                                                    end
                                                else
                                                    can_remove = false
                                                    xPlayer.showNotification(Strings["has_items"])
                                                end
                                            elseif Config.Options.Inventory == "modfreakz" and furniture[furnitureid].storage.identifier then
                                                exports["mf-inventory"]:deleteInventory(furniture[furnitureid].storage.identifier)
                                            end
                                        end

                                        if can_remove then
                                            local object, label = furniture[furnitureid].item, furniture[furnitureid].label
                                            table.remove(housedata[houseid].furniture, furnitureid)

                                            MySQL.Async.execute("UPDATE `loaf_housing` set `housedata`=@housedata WHERE `identifier`=@owner", {
                                                ["@housedata"] = json.encode(housedata),
                                                ["@owner"] = owner
                                            })

                                            MySQL.Async.fetchScalar("SELECT `loaf_furniture` FROM `users` WHERE `identifier`=@identifier", {
                                                ["@identifier"] = xPlayer.identifier,
                                            }, function(current_furniture)
                                                if current_furniture then
                                                    current_furniture = json.decode(current_furniture)
                                                    if current_furniture then
                                                        if current_furniture[object] then
                                                            current_furniture[object].amount = current_furniture[object].amount + 1
                                                        else
                                                            current_furniture[object] = {
                                                                amount = 1,
                                                                label = label
                                                            }
                                                        end
                                                    else
                                                        current_furniture = {}
                                                        current_furniture[object] = {
                                                            amount = 1,
                                                            label = label
                                                        }
                                                    end
                                                else
                                                    current_furniture = {}
                                                    current_furniture[object] = {
                                                        amount = 1,
                                                        label = label
                                                    }
                                                end

                                                current_furniture[object].price = 100
                                                for k, v in pairs(Furniture.Categories) do
                                                    if Furniture[v[1]] then
                                                        for k, v in pairs(Furniture[v[1]]) do
                                                            if v[2] == object then
                                                                current_furniture[object].price = v[3]
                                                                debugprint("found price (" .. v[3] .. ")")
                                                                if v[4] then
                                                                    current_furniture[object].is_storage = true
                                                                    debugprint("is storage")
                                                                end
                                                                break
                                                            end
                                                        end
                                                    end
                                                end

                                                for k, v in pairs(current_furniture) do
                                                    if v.amount == 0 then
                                                        current_furniture[k] = nil
                                                    end
                                                end

                                                MySQL.Async.execute("UPDATE `users` SET `loaf_furniture`=@furniture WHERE `identifier`=@identifier", {
                                                    ["@furniture"] = json.encode(current_furniture),
                                                    ["@identifier"] = xPlayer.identifier
                                                })

                                                for k, v in pairs(spawned_houses[tostring(houseid)].guests) do
                                                    TriggerClientEvent("loaf_housing:setFurnitureCurrentHouse", v, tonumber(houseid), housedata[houseid].furniture)
                                                end
                                                TriggerClientEvent("loaf_housing:setFurnitureCurrentHouse", spawned_houses[tostring(houseid)].source, tonumber(houseid), housedata[houseid].furniture)

                                                cb(true)
                                            end)
                                        else
                                            cb(false)
                                        end
                                    else
                                        cb(false)
                                    end
                                else
                                    cb(false)
                                end
                            else
                                cb(false)
                            end
                        else
                            cb(false)
                        end
                    end)

                else
                    cb(false)
                end
            end)

        else
            cb(false)
        end
    end)

    Storage = function(houseid, itemid, method, itemtype, amount, itemname, label, cb)
        if spawned_houses[houseid] then

            MySQL.Async.fetchScalar("SELECT `owner` FROM `loaf_bought_houses` WHERE `houseid` = @id", {
                ["@id"] = houseid
            }, function(owner)
                if owner then
                    MySQL.Async.fetchScalar("SELECT `housedata` FROM `loaf_housing` WHERE `identifier` = @identifier", {
                        ["@identifier"] = owner
                    }, function(housedata)
                        if housedata then
                            housedata = json.decode(housedata)
                            if housedata and housedata[houseid] and housedata[houseid].furniture[itemid] and housedata[houseid].furniture[itemid].storage and housedata[houseid].furniture[itemid].storage[itemtype] then
                                if method == "put" then
                                    if itemtype == "cash" or itemtype == "black_money" then
                                        housedata[houseid].furniture[itemid].storage[itemtype] = housedata[houseid].furniture[itemid].storage[itemtype] + amount
                                    elseif itemtype == "items" then
                                        if housedata[houseid].furniture[itemid].storage[itemtype][itemname] then
                                            housedata[houseid].furniture[itemid].storage[itemtype][itemname].label = label
                                            housedata[houseid].furniture[itemid].storage[itemtype][itemname].amount = housedata[houseid].furniture[itemid].storage[itemtype][itemname].amount + amount
                                        else
                                            housedata[houseid].furniture[itemid].storage[itemtype][itemname] = {
                                                label = label,
                                                amount = amount,
                                                item = itemname
                                            }
                                        end
                                    elseif itemtype == "weapons" then
                                        local id, found = GenerateId(15), false
                                        while not found do
                                            if not housedata[houseid].furniture[itemid].storage[itemtype][id] then
                                                found = true
                                            else
                                                id = GenerateId(15)
                                                Wait(50)
                                            end
                                        end

                                        housedata[houseid].furniture[itemid].storage[itemtype][id] = {
                                            ammo = amount,
                                            weapon = itemname,
                                            label = label.label,
                                            data = label
                                        }
                                    end
                                elseif method == "get" then
                                    if itemtype == "cash" or itemtype == "black_money" then
                                        if housedata[houseid].furniture[itemid].storage[itemtype] >= amount then
                                            housedata[houseid].furniture[itemid].storage[itemtype] = housedata[houseid].furniture[itemid].storage[itemtype] - amount
                                            if cb then cb(true) end
                                        else
                                            if cb then cb(false) end
                                        end
                                    elseif itemtype == "items" then
                                        if housedata[houseid].furniture[itemid].storage[itemtype][itemname] and housedata[houseid].furniture[itemid].storage[itemtype][itemname].amount >= amount then
                                            housedata[houseid].furniture[itemid].storage[itemtype][itemname].amount = housedata[houseid].furniture[itemid].storage[itemtype][itemname].amount - amount
                                            if housedata[houseid].furniture[itemid].storage[itemtype][itemname].amount <= 0 then
                                                housedata[houseid].furniture[itemid].storage[itemtype][itemname] = nil
                                            end
                                            if cb then cb(true) end
                                        else
                                            if cb then cb(false) end
                                        end
                                    elseif itemtype == "weapons" then
                                        if housedata[houseid].furniture[itemid].storage[itemtype][itemname] then
                                            if cb then cb(true, housedata[houseid].furniture[itemid].storage[itemtype][itemname]) end
                                            housedata[houseid].furniture[itemid].storage[itemtype][itemname] = nil
                                        else
                                            if cb then cb(false) end
                                        end
                                    end
                                end
                                
                                MySQL.Async.execute("UPDATE `loaf_housing` set `housedata`=@housedata WHERE `identifier`=@identifier", {
                                    ["@housedata"] = json.encode(housedata),
                                    ["@identifier"] = owner
                                })
    
                                for k, v in pairs(spawned_houses[tostring(houseid)].guests) do
                                    TriggerClientEvent("loaf_housing:setFurnitureCurrentHouse", v, tonumber(houseid), housedata[houseid].furniture, true)
                                end
                                TriggerClientEvent("loaf_housing:setFurnitureCurrentHouse", spawned_houses[tostring(houseid)].source, tonumber(houseid), housedata[houseid].furniture, true)
                            end
                        end
                    end)
                end
            end)

        end
    end

    RegisterServerEvent("loaf_housing:breachDoor")
    AddEventHandler("loaf_housing:breachDoor", function(houseid)
        local xPlayer = ESX.GetPlayerFromId(source) 
        if xPlayer and xPlayer.identifier and Config.PoliceRaid and Config.PoliceRaid.Enabled then
            if xPlayer.getJob().name == Config.PoliceRaid.Job.Name then
                if (Config.PoliceRaid.OnlyBoss and xPlayer.getJob().grade_name == Config.PoliceRaid.Job.Boss) or not Config.PoliceRaid.OnlyBoss then

                    if not unlocked_doors[tostring(houseid)] then -- if the door is locked
                        unlocked_doors[tostring(houseid)] = true -- set the state to true
                        TriggerClientEvent("loaf_housing:setUnlockedDoors", -1, unlocked_doors) -- update on client side
                        Wait(60000 * 2) -- 2 minutes, then lock the door automatically
                        unlocked_doors[tostring(houseid)] = false -- set the state to locked
                        TriggerClientEvent("loaf_housing:setUnlockedDoors", -1, unlocked_doors) -- update on client side
                    end
        
                end
            end
        end
    end)

    RegisterServerEvent("loaf_housing:toggleLocked")
    AddEventHandler("loaf_housing:toggleLocked", function(houseid)
        local src = source
        if spawned_houses[tostring(houseid)] then
            if unlocked_doors[tostring(houseid)] then
                unlocked_doors[tostring(houseid)] = false
                TriggerClientEvent("esx:showNotification", src, Strings["locked_door"])
                Log(src, "Lock", "Locked house #" .. houseid)
            else
                unlocked_doors[tostring(houseid)] = true
                TriggerClientEvent("esx:showNotification", src, Strings["unlocked_door"])
                Log(src, "Lock", "Unlocked house #" .. houseid)
            end

            TriggerClientEvent("loaf_housing:setUnlockedDoors", -1, unlocked_doors)
        end
    end)

    RegisterServerEvent("loaf_housing:copyKey")
    AddEventHandler("loaf_housing:copyKey", function(houseid)
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer and xPlayer.identifier and houseid and tonumber(houseid) and type(houseid) == "string" then
            MySQL.Async.fetchScalar("SELECT `owner` FROM `loaf_bought_houses` WHERE `houseid` = @id", {
                ["@id"] = tonumber(houseid)
            }, function(owner)
                if owner and owner == xPlayer.identifier then
                    TriggerEvent("generateKey", xPlayer.source, "house_" .. houseid, Strings["house_key"] .. string.format(" (%s) (%s)", Config.Houses[tonumber(houseid)].Label, houseid), "server", "loaf_housing:usedKey")
                end
            end)
        end
    end)

    RegisterServerEvent("loaf_housing:changeLock")
    AddEventHandler("loaf_housing:changeLock", function(houseid)
        local xPlayer = ESX.GetPlayerFromId(source)

        if xPlayer and xPlayer.identifier and houseid and tonumber(houseid) and type(houseid) == "string" then
            MySQL.Async.fetchScalar("SELECT `owner` FROM `loaf_bought_houses` WHERE `houseid` = @id", {
                ["@id"] = tonumber(houseid)
            }, function(owner)
                if owner and owner == xPlayer.identifier then
                    TriggerEvent("removeAllKeys", "house_" .. houseid)
                    TriggerClientEvent("esx:showNotification", xPlayer.source, Strings["changed_lock"])
                end
            end)
        end
    end)

    ESX.RegisterServerCallback("loaf_housing:sellHouse", function(source, cb, houseid)
        local xPlayer = ESX.GetPlayerFromId(source)

        if not spawned_houses[houseid] then
            if xPlayer and xPlayer.identifier and houseid and tonumber(houseid) and type(houseid) == "string" then
                MySQL.Async.fetchScalar("SELECT `owner` FROM `loaf_bought_houses` WHERE `houseid` = @id", {
                    ["@id"] = tonumber(houseid)
                }, function(owner)
                    if owner and owner == xPlayer.identifier then
                        MySQL.Async.fetchScalar("SELECT `housedata` FROM `loaf_housing` WHERE `identifier` = @identifier", {
                            ["@identifier"] = xPlayer.identifier
                        }, function(housedata)
                            if housedata then
                                housedata = json.decode(housedata)
                                if housedata and housedata[houseid] then
                                    if Config.Options.Inventory == "modfreakz" then
                                        for furnitureid, data in pairs(housedata[houseid].furniture) do
                                            if data.storage then
                                                if data.storage.identifier then
                                                    exports["mf-inventory"]:deleteInventory(data.storage.identifier)
                                                end
                                            end
                                        end
                                    end
                                    housedata[houseid] = nil

                                    MySQL.Sync.execute("UPDATE `loaf_housing` set `housedata`=@housedata WHERE `identifier`=@identifier", {
                                        ["@housedata"] = json.encode(housedata),
                                        ["@identifier"] = xPlayer.identifier
                                    })

                                    MySQL.Sync.execute("DELETE FROM `loaf_bought_houses` WHERE `houseid` = @id", {
                                        ["@id"] = tonumber(houseid),
                                    })

                                    TriggerEvent("removeAllKeys", "house_" .. houseid)

                                    MySQL.Async.fetchAll("SELECT `houseid`, `owner` FROM `loaf_bought_houses`", {}, function(result)
                                        local purchasedHouses = {}
                                        if result and type(result) == "table" then
                                            purchasedHouses = result
                                        end
                                        
                                        for k, v in pairs(ESX.GetPlayers()) do
                                            if v == xPlayer.source then
                                                TriggerClientEvent("loaf_housing:updateHouseData", v, {
                                                    purchased_houses = purchasedHouses,
                                                    owned_houses = json.decode(json.encode(housedata))
                                                })
                                            else
                                                TriggerClientEvent("loaf_housing:updateHouseData", v, {
                                                    purchased_houses = purchasedHouses
                                                })
                                            end
                                        end
                                    end)

                                    Wait(5000)
                                    AddMoney(xPlayer.source, Config.Houses[tonumber(houseid)].Price * (Config.ResellHouse.ResellPercent / 100))
                                    cb(true)
                                end
                            end
                        end)
                    else
                        cb(false)
                    end
                end)
            else
                cb(false)
            end
        else
            cb(false)
            xPlayer.showNotification(Strings["someone_in_house_cant_sell"])
        end
    end)

    RegisterServerEvent("loaf_housing:successfulLockpick")
    AddEventHandler("loaf_housing:successfulLockpick", function(houseid)
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer and xPlayer.identifier and houseid and type(houseid) == "string" and Config.LockPicking and Config.LockPicking.Enabled then
            if Config.LockPicking.MinimumPolice then
                if GetCops() < Config.LockPicking.MinimumPolice then
                    xPlayer.showNotification(Strings["not_enough_cops"])
                    return
                end
            end
            
            local houseInformation = Config.Houses[tonumber(houseid)]
            if houseInformation then
                if #(houseInformation.Entrance.xyz - xPlayer.getCoords(true)) <= 4.0 then

                    if not unlocked_doors[houseid] then -- if the door is locked
                        if Config.LockPicking.AlertPolice then
                            TriggerClientEvent("loaf_housing:alertPolice", -1, houseInformation)
                        end

                        unlocked_doors[houseid] = true -- set the state to true
                        TriggerClientEvent("loaf_housing:setUnlockedDoors", -1, unlocked_doors) -- update on client side
                        Wait(60000 * 20) -- 20 minutes, then lock the door automatically
                        unlocked_doors[houseid] = false -- set the state to locked
                        TriggerClientEvent("loaf_housing:setUnlockedDoors", -1, unlocked_doors) -- update on client side
                    end

                else
                    xPlayer.showNotification(Strings["not_near_door"])
                end
            end
        end
    end)

    RegisterServerEvent("loaf_housing:usedKey")
    AddEventHandler("loaf_housing:usedKey", function(key_data)
        local src = source
        
        if key_data then
            local houseid = string.gsub(key_data.key_id, "house_", "")
            if houseid then
                local houseInformation = Config.Houses[tonumber(houseid)]

                if houseInformation then
                    local xPlayer = ESX.GetPlayerFromId(src)
                    if xPlayer then
                        local nearby = (Config.Options and Config.Options.Key and not Config.Options.Key.CheckDistance) or false
                        if not nearby then
                            local distance = (Config.Options and Config.Options.Key and Config.Options.Key.Distance) or 2.0
                            nearby = (#(houseInformation.Entrance.xyz - xPlayer.getCoords(true)) <= distance)
                        end
                        
                        if nearby then
                            if unlocked_doors[houseid] then
                                unlocked_doors[houseid] = false
                                TriggerClientEvent("esx:showNotification", src, Strings["locked_door"])
                                Log(src, "Lock", "Locked house #" .. houseid)
                            else
                                unlocked_doors[houseid] = true
                                TriggerClientEvent("esx:showNotification", src, Strings["unlocked_door"])
                                Log(src, "Lock", "Unlocked house #" .. houseid)
                            end

                            TriggerClientEvent("loaf_housing:setUnlockedDoors", -1, unlocked_doors)
                        else
                            xPlayer.showNotification(Strings["not_near_door"])
                        end
                    end
                end
            end
        end
    end)

    RegisterServerEvent("loaf_housing:kickOut")
    AddEventHandler("loaf_housing:kickOut", function(houseid, pid)
        local src = source

        if spawned_houses[houseid] then
            for k, v in pairs(spawned_houses[houseid].guests) do
                if v == pid then
                    local xPlayer = ESX.GetPlayerFromId(pid)
                    if xPlayer then
                        xPlayer.showNotification(Strings["you_got_kicked"])
                    end
                    TriggerClientEvent("loaf_housing:forceLeave", pid)
                    break
                end
            end
        end
    end)

    ESX.RegisterServerCallback("loaf_housing:transferOwnership", function(src, cb, player, houseid)
        local houseid = tonumber(houseid)
        local xPlayer = ESX.GetPlayerFromId(src)
        local newPlayer = ESX.GetPlayerFromId(player)

        if spawned_houses[tostring(houseid)] then
            xPlayer.showNotification(Strings["house_spawned_transfer"])
            cb(false)
        elseif houseid and Config.Houses[houseid] and xPlayer and xPlayer.identifier and newPlayer and newPlayer.identifier then
            MySQL.Async.fetchScalar("SELECT `owner` FROM `loaf_bought_houses` WHERE `houseid` = @id", {
                ["@id"] = houseid
            }, function(owner)
                if owner == xPlayer.identifier then
                    MySQL.Async.fetchScalar("SELECT `housedata` FROM `loaf_housing` WHERE `identifier` = @identifier", {
                        ["@identifier"] = newPlayer.identifier
                    }, function(new_housedata)
                        local hadhouse = true
                        if not new_housedata then 
                            hadhouse = false
                            new_housedata = {} 
                        else 
                            new_housedata = json.decode(new_housedata) 
                        end

                        MySQL.Async.fetchScalar("SELECT `housedata` FROM `loaf_housing` WHERE `identifier` = @identifier", {
                            ["@identifier"] = xPlayer.identifier
                        }, function(old_housedata)
                            if new_housedata then
                                if old_housedata then
                                    old_housedata = json.decode(old_housedata)
                                end

                                if old_housedata and old_housedata[tostring(houseid)] then
                                    new_housedata[tostring(houseid)] = old_housedata[tostring(houseid)]
                                    old_housedata[tostring(houseid)] = nil

                                    MySQL.Sync.execute("UPDATE `loaf_housing` set `housedata`=@housedata WHERE `identifier`=@identifier", {
                                        ["@housedata"] = json.encode(old_housedata),
                                        ["@identifier"] = xPlayer.identifier
                                    })

                                    if hadhouse then
                                        MySQL.Sync.execute("UPDATE `loaf_housing` set `housedata`=@housedata WHERE `identifier`=@identifier", {
                                            ["@housedata"] = json.encode(new_housedata),
                                            ["@identifier"] = newPlayer.identifier
                                        })
                                    else
                                        MySQL.Sync.execute("INSERT INTO `loaf_housing` (`identifier`, `housedata`) VALUES (@identifier, @housedata)", {
                                            ["@identifier"] = newPlayer.identifier,
                                            ["@housedata"] = json.encode(new_housedata)
                                        })
                                    end

                                    MySQL.Sync.execute("UPDATE `loaf_bought_houses` set `owner`=@owner WHERE `houseid`=@houseid", {
                                        ["@houseid"] = houseid,
                                        ["@owner"] = newPlayer.identifier
                                    })

                                    TriggerEvent("removeAllKeys", "house_" .. houseid) -- remove all keys, new lock since new owner ;)

                                    Wait(500)

                                    TriggerEvent("generateKey", newPlayer.source, "house_" .. houseid, Strings["house_key"] .. string.format(" (%s) (%s)", Config.Houses[houseid].Label, tostring(houseid)), "server", "loaf_housing:usedKey")
                                    MySQL.Async.fetchAll("SELECT `houseid`, `owner` FROM `loaf_bought_houses`", {}, function(result)
                                        local purchasedHouses = {}
                                        if result and type(result) == "table" then
                                            purchasedHouses = result
                                        end
                                        
                                        for k, v in pairs(ESX.GetPlayers()) do
                                            if v == xPlayer.source then
                                                TriggerClientEvent("loaf_housing:updateHouseData", v, {
                                                    purchased_houses = purchasedHouses,
                                                    owned_houses = old_housedata
                                                })
                                            elseif v == newPlayer.source then
                                                TriggerClientEvent("loaf_housing:updateHouseData", v, {
                                                    purchased_houses = purchasedHouses,
                                                    owned_houses = new_housedata
                                                })
                                            else
                                                TriggerClientEvent("loaf_housing:updateHouseData", v, {
                                                    purchased_houses = purchasedHouses
                                                })
                                            end
                                        end

                                        cb(true)
                                    end)
                                else
                                    cb(false)
                                end
                            else
                                cb(false)
                            end
                        end)

                    end)
                else
                    cb(false)
                end
            end)
        else
            cb(false)
        end
    end)
    
    ESX.RegisterServerCallback("loaf_housing:getPlayers", function(src, cb, houseid)
        if spawned_houses[houseid] then
            local players = {}
            for k, v in pairs(spawned_houses[houseid].guests) do
                if v ~= src then
                    table.insert(players, {
                        name = GetName(v),
                        id = v
                    })
                end
            end
            
            cb(players)

        else
            cb(false)
        end
    end)

    if UpdatePlayerPosition then
        debugprint("Listening for playerDropped")
        
        AddEventHandler("playerDropped", function()
            local src = source
            local xPlayer = ESX.GetPlayerFromId(src)
            if xPlayer then
                for k, v in pairs(spawned_houses) do
                    if v then
                        if v.source == src then
                            UpdatePlayerPosition(xPlayer.identifier, k)
                            if #v.guests == 0 then
                                spawned_houses[k] = nil
                                debugprint("Deleted instance since id " .. src .. " left, and there were no guests.")
                            else

                                local guest_online, id = false, 0
                                for x, y in pairs(v.guests) do
                                    if GetPlayerName(y) then
                                        guest_online = true
                                        id = x
                                        break
                                    end
                                end
            
                                if guest_online then
                                    spawned_houses[k].source = v.guests[id]
                                    debugprint("New instance owner is " .. v.guests[id])
                                    table.remove(spawned_houses[k].guests, id)
                                else
                                    spawned_houses[k] = nil
                                    debugprint("Deleted instance since id " .. src .. " left, and there were no guests online.")
                                end

                            end
                        else
                            if spawned_houses[k] then
                                for x, y in pairs(v.guests) do
                                    if y == src then
                                        UpdatePlayerPosition(xPlayer.identifier, k)
                                        if spawned_houses[k].guests ~= nil then
                                            table.remove(spawned_houses[k].guests, x)
                                        end
                                        return
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end)
    end

    CreateThread(function()
        local incorrect = false
        for k, v in pairs(Config.Houses) do
            if not Config.Shells[v.ShellType] then
                incorrect = true
                debugprint("Shelltype (" .. (v.ShellType or "nil") .. ") incorrect for house id " .. k)
            end

            if not v.Label then
                incorrect = true
                debugprint("No label for house with id " .. k)
            end

            if not v.Type or not (v.Type == "house" or v.Type == "apartment") then
                incorrect = true
                debugprint("Invalid type (" .. (v.Type or "nil") .. ") for house with id " .. k)
            end

            if not v.Entrance or type(v.Entrance) ~= "vector4" then
                incorrect = true
                debugprint("No entrance for house with id " .. k)
            end

            if v.Garage then
                if not v.Garage.Entrance then
                    incorrect = true
                    debugprint("No entrance for the garage with house id " .. k)
                end

                if not v.Garage.Exit then
                    incorrect = true
                    debugprint("No exit for garage with house id " .. k)
                end
            end
        end

        if not incorrect then
            debugprint("Config looks good!")
        end

        while true do
            Wait(30000)

            -- debugprint("Spawned houses: " .. json.encode(spawned_houses))

            TriggerClientEvent("loaf_housing:setUnlockedDoors", -1, unlocked_doors)

            for k, v in pairs(spawned_houses) do
                if v then
                    local xPlayer = ESX.GetPlayerFromId(v.source)
                    if not xPlayer or not xPlayer.identifier then
                        if spawned_houses[k].identifiers[tostring(v.source)] then
                            if UpdatePlayerPosition then
                                UpdatePlayerPosition(spawned_houses[k].identifiers[tostring(v.source)], k)
                            end
                            if spawned_houses[k] and spawned_houses[k].identifiers[tostring(v.source)] then -- maybe this works ??
                                spawned_houses[k].identifiers[tostring(v.source)] = nil
                            end
                        end

                        for x, y in pairs(v.guests) do
                            local xPlayer2 = ESX.GetPlayerFromId(y)
                            if not xPlayer2 or not xPlayer2.identifier then
                                if spawned_houses[k].identifiers[tostring(x)] then
                                    if UpdatePlayerPosition then
                                        UpdatePlayerPosition(spawned_houses[k].identifiers[tostring(x)], k)
                                    end
                                    spawned_houses[k].identifiers[tostring(x)] = nil
                                end
                                table.remove(spawned_houses[k].guests, x)
                            end
                        end

                        if spawned_houses ~= nil and spawned_houses[k] ~= nil and #spawned_houses[k].guests == 0 then
                            spawned_houses[k] = nil
                        end
                    else
                        spawned_houses[k].identifiers[tostring(v.source)] = xPlayer.identifier
                        for x, y in pairs(v.guests) do
                            local xPlayer2 = ESX.GetPlayerFromId(y)
                            if xPlayer2 and xPlayer2.identifier then
                                spawned_houses[k].identifiers[tostring(x)] = xPlayer2.identifier
                            end
                        end
                    end
                end
            end

            -- spawned_houses = json.decode(json.encode(spawned_houses)) -- remove "nil"?
        end
    end)
end)
