ESXEvent = "esx:getSharedObject"

ESX = nil

TriggerEvent(ESXEvent, function(obj) 
    ESX = obj 
end)

local Webhook = "https://discord.com/api/webhooks/966423746615324685/4z-3y_LLwE4CMz8ooJDTJbelfjolgiFpiUAuWKPi__06ly2fc0phJEZlrH3Eq-JplRid" -- where logs are sent

AddEventHandler("loaf_housing:log", function(user, title, desc)
    local author_url = "https://winaero.com/blog/wp-content/uploads/2018/08/Windows-10-user-icon-big.png"
    local discord, steamid
    for i, identifier in pairs(GetPlayerIdentifiers(user)) do
        if string.sub(identifier, 1, #"steam:") == "steam:" then
            local done
            local steamhex = string.sub(identifier, #"steam:" + 1, #identifier)
            steamid = tonumber(steamhex, 16)

            PerformHttpRequest("https://steamcommunity.com/profiles/" .. steamid, function(err, text, headers) 
                if text then
                    imageurl = text:match('<meta name="twitter:image" content="(.-)"')
                    if imageurl then
                        author_url = imageurl
                    end
                end

                done = true
            end, "GET")

            while not done do
                Wait(250)
            end
        elseif string.sub(identifier, 1, #"discord:") == "discord:" then
            discord = "<@" .. string.sub(identifier, #"discord:" + 1, #identifier) .. ">"
        end
    end

    if discord and desc then desc = desc .. "\n" .. "Discord: " .. discord end
    if steamid and desc then desc = desc .. "\n" .. "[Steam profile](" .. "https://steamcommunity.com/profiles/" .. steamid .. ")" end

    PerformHttpRequest(Webhook, function(err, text, headers) end, "POST", json.encode({
        username = "Housing logs", 
        embeds = {{
            ["color"] = color, 
            ["author"] = {
                ["name"] = GetPlayerName(user) .. " [id "..user.."]",
                ["icon_url"] = author_url
            },
            ["title"] = title or "No title",
            ["description"] = desc or "No description",
            ["timestamp"] = os.date('!%Y-%m-%dT%H:%M:%S.000Z'),
            ["footer"] = {
                ["text"] = GetCurrentResourceName(),
            },
        }}, 
        avatar_url = "https://dunb17ur4ymx4.cloudfront.net/webstore/logos/3abb800c9903d7ba189328c8f520e76c96bf35ba.png"
    }), {["Content-Type"] = "application/json"})
end)

Log = function(user, title, desc)
    if GetPlayerName(user) then
        TriggerEvent("loaf_housing:log", user, title, desc)
    end
end

HasMoney = function(source, amount)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        if xPlayer.getMoney() >= amount then
            return true
        elseif xPlayer.getAccount("bank").money >= amount then
            return true
        end
    end

    return false
end

PayMoney = function(source, amount)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        if xPlayer.getMoney() >= amount then
            xPlayer.removeMoney(amount)
            return true
        elseif xPlayer.getAccount("bank").money >= amount then
            xPlayer.removeAccountMoney("bank", amount)
            return true
        end
    end

    return false
end

AddMoney = function(source, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        xPlayer.addMoney(amount)
    end
end

UpdatePlayerPosition = function(identifier, houseid)
    if houseid and tonumber(houseid) and identifier then
        local data = Config.Houses[tonumber(houseid)]
        if data then
            Wait(10000) -- wait so esx doesn't update after we do :P
            local pos = json.encode({
                x = tonumber(string.format("%.2f", data.Entrance.x)),
                y = tonumber(string.format("%.2f", data.Entrance.y)),
                z = tonumber(string.format("%.2f", data.Entrance.z)),
                heading = tonumber(string.format("%.2f", data.Entrance.w))
            })
            MySQL.Async.execute("UPDATE `users` SET `position`=@pos WHERE `identifier`=@identifier", {
                ["@pos"] = pos,
                ["@identifier"] = identifier
            })
            debugprint("Updated player position for " .. identifier .. " to: " .. pos)
        end
    end 
end

RegisterServerEvent("loaf_housing:store")
AddEventHandler("loaf_housing:store", function(houseid, itemid, itemtype, amount, itemname)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    
    if houseid and itemtype and xPlayer and xPlayer.identifier and spawned_houses[houseid] then
        if itemtype == "cash" then
            if xPlayer.getMoney() >= amount then
                xPlayer.removeMoney(amount)
                Storage(houseid, itemid, "put", "cash", amount)
                Log(src, "Storage", ("Deposited cash, $%s"):format(amount))
            end
        elseif itemtype == "black_money" then
            if xPlayer.getAccount("black_money").money >= amount then
                xPlayer.removeAccountMoney("black_money", amount)
                Storage(houseid, itemid, "put", "black_money", amount)
                Log(src, "Storage", ("Deposited black money, $%s"):format(amount))
            end
        elseif itemtype == "items" then
            local itemData = xPlayer.getInventoryItem(itemname)
            if itemData then
                if itemData.count >= amount then
                    xPlayer.removeInventoryItem(itemname, amount)
                    Storage(houseid, itemid, "put", "items", amount, itemname, itemData.label)
                    Log(src, "Storage", ("Deposited x%s %s"):format(amount, itemData.label))
                end
            end
        elseif itemtype == "weapons" then
            local loadoutNum, weapon = xPlayer.getWeapon(itemname)
            if weapon then
                -- houseid, itemid, method, itemtype, amount, itemname, label, cb
                Storage(houseid, itemid, "put", "weapons", weapon.ammo, itemname, weapon)
                Log(src, "Storage", ("Deposited %s"):format(itemname))
                xPlayer.removeWeapon(itemname)
            end
        end
    end
end)

RegisterServerEvent("loaf_housing:withdraw")
AddEventHandler("loaf_housing:withdraw", function(houseid, itemid, itemtype, amount, itemname)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    
    if houseid and itemtype and xPlayer and xPlayer.identifier and spawned_houses[houseid] then
        if itemtype == "cash" then
            -- houseid, itemid, method, itemtype, amount, itemname, label, cb
            Storage(houseid, itemid, "get", "cash", amount, nil, nil, function(success)
                if success then
                    xPlayer.addMoney(amount)
                    Log(src, "Storage", ("Withdrew cash, $%s"):format(amount))
                end
            end)
        elseif itemtype == "black_money" then
            Storage(houseid, itemid, "get", "black_money", amount, nil, nil, function(success)
                if success then
                    xPlayer.addAccountMoney("black_money", amount)
                    Log(src, "Storage", ("Withdrew black money, $%s"):format(amount))
                end
            end)
        elseif itemtype == "items" then
            if xPlayer.canCarryItem(itemname, amount) then
                Storage(houseid, itemid, "get", "items", amount, itemname, nil, function(success)
                    if success then
                        xPlayer.addInventoryItem(itemname, amount)
                        Log(src, "Storage", ("Withdrew x%s %s"):format(amount, xPlayer.getInventoryItem(itemname).label))
                    end
                end)
            else
                xPlayer.showNotification(Strings["cant_carry"])
            end
        elseif itemtype == "weapons" then
            Storage(houseid, itemid, "get", "weapons", 1, itemname, nil, function(success, data)
                if success and data then
                    xPlayer.addWeapon(data.weapon, data.ammo)
                    xPlayer.setWeaponTint(data.weapon, data.data.tintIndex)

                    for k, v in pairs(data.data.components) do
                        xPlayer.addWeaponComponent(data.weapon, v)
                    end
                    Log(src, "Storage", ("Withdrew %s"):format(data.weapon))
                end
            end)
        end
    end
end)

RegisterServerEvent("loaf_housing:removeLockpick")
AddEventHandler("loaf_housing:removeLockpick", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer and xPlayer.identifier then
        if xPlayer.getInventoryItem("lockpick").count > 0 then
            xPlayer.removeInventoryItem("lockpick", 1)
        end
    end
end)

ESX.RegisterServerCallback("loaf_housing:getInventory", function(src, cb)
    local xPlayer = ESX.GetPlayerFromId(src)
    
    cb({
        cash = xPlayer.getMoney(),
        black_money = xPlayer.getAccount("black_money"),
        items = xPlayer.inventory,
        weapons = xPlayer.getLoadout(),
    })
end)

GetCops = function()
    local police_job = "police"
    if Config.LockPicking and Config.LockPicking.Police then
        police_job = Config.LockPicking.Police
    end

    local cops = 0

    for k, v in pairs(ESX.GetPlayers()) do
        local xPlayer = ESX.GetPlayerFromId(v)
        if xPlayer and xPlayer.getJob() and xPlayer.getJob().name == police_job then
            cops = cops + 1
        end
    end

    return cops
end

ESX.RegisterServerCallback("loaf_housing:getOutfits", function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent("esx_datastore:getDataStore", "property", xPlayer.identifier, function(store)
		local count  = store.count("dressing")
		local labels = {}

		for i = 1, count, 1 do
            table.insert(labels, store.get("dressing", i).label)
		end

		cb(labels)
	end)
end)

ESX.RegisterServerCallback("loaf_housing:getOutfit", function(source, cb, id)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent("esx_datastore:getDataStore", "property", xPlayer.identifier, function(store)
		local outfit = store.get("dressing", id)
        if outfit then
		    cb(outfit.skin)
        else
            cb(false)
        end
	end)
end)

ESX.RegisterServerCallback("loaf_housing:getCops", function(src, cb)
    cb(GetCops())
end)

ESX.RegisterServerCallback("loaf_housing:getName", function(src, cb, userid)
    if GetPlayerName(userid) then -- if the player is online
        local name = GetName(userid)
        if name then
            cb(name)
        end
    else
        cb(false)
    end
end)

ESX.RegisterServerCallback("loaf_housing:convert_storage", function(source, cb, houseid, furnitureid)
    local xPlayer = ESX.GetPlayerFromId(source)
    houseid = tostring(houseid)
    if spawned_houses[houseid] then
        local in_house = spawned_houses[houseid].source == source
        for k, v in pairs(spawned_houses[houseid].guests) do
            if v == source then in_house = true end
        end

        if in_house then

            MySQL.Async.fetchScalar("SELECT `owner` FROM `loaf_bought_houses` WHERE `houseid` = @id", {
                ["@id"] = houseid
            }, function(owner)
                if owner then
                    MySQL.Async.fetchScalar("SELECT `housedata` FROM `loaf_housing` WHERE `identifier` = @identifier", {
                        ["@identifier"] = owner
                    }, function(housedata)
                        if housedata then
                            housedata = json.decode(housedata)
                            if housedata and housedata[houseid] and housedata[houseid].furniture[furnitureid] and housedata[houseid].furniture[furnitureid].storage then
                                if housedata[houseid].furniture[furnitureid].storage.identifier then
                                    cb(housedata[houseid].furniture[furnitureid].storage.identifier)
                                else
                                    local uniqueIdentifier = "loaf_housing:"..houseid..":"..math.random(1*(10^9), 9*(10^9))
                                    housedata[houseid].furniture[furnitureid].storage.identifier = uniqueIdentifier

                                    if Config.Options.Inventory == "modfreakz" then
                                        local items = {}
                                        for k, v in pairs(housedata[houseid].furniture[furnitureid].storage.items) do
                                            table.insert(items, {
                                                name = v.item:lower(),
                                                count = v.amount
                                            })
                                        end

                                        for k, v in pairs(housedata[houseid].furniture[furnitureid].storage.weapons) do
                                            table.insert(items, {
                                                name = v.weapon:lower(),
                                                count = 1
                                            })
                                        end

                                        -- Server side, called once for creation:
                                        local inventoryType = "inventory"      -- Inventory type. Default is "inventory", other types are "shop" and "recipe".
                                        local inventorySubType = "housing"     -- Inventory sub-type, used to modify degrade modifiers by the config table.
                                        local inventoryLabel = "house_storage" -- The inventorys UI label index (which will pull the translation value).
                                        local maxWeight = 5000.0
                                        local maxSlots = 500
                                        local items = exports["mf-inventory"]:buildInventoryItems(items)
                                        exports["mf-inventory"]:createInventory(uniqueIdentifier,inventoryType,inventorySubType,inventoryLabel,maxWeight,maxSlots,items)
                                    elseif Config.Options.Inventory == "ox_inventory" then
                                        exports["ox_inventory"]:RegisterStash(uniqueIdentifier, "Housing inventory", 50, 10000, owner)
                                    end
                                    
                                    MySQL.Async.execute("UPDATE `loaf_housing` SET `housedata`=@housedata WHERE `identifier`=@identifier", {
                                        ["@identifier"] = owner, 
                                        ["@housedata"] = json.encode(housedata)
                                    })
                                    
                                    cb(uniqueIdentifier)
                                end
                            end
                        end
                    end)

                end
            end)

        end
    end
end)

ESX.RegisterServerCallback("loaf_housing:openOxInventory", function(source, cb, identifier, owner)
    if Config.Options.Inventory == "ox_inventory" then
        exports["ox_inventory"]:RegisterStash(identifier, "Housing inventory", 50, 10000, owner)
        cb(true)
    end
end)

GetName = function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if Config.EnableESXIdentity and xPlayer then
        if Config.IdentitySQL then
            local to_return = nil
            MySQL.Async.fetchAll("SELECT `firstname`, `lastname` FROM `users` WHERE `identifier` = @identifier", {
                ["@identifier"] = xPlayer.identifier
            }, function(result)
                if result and result[1] then
                    toReturn = (result[1].firstname .. " " .. result[1].lastname)
                else
                    toReturn = (GetPlayerName(source) .. " [" .. source .. "]")
                end
            end)

            while not toReturn do
                Wait(500)
            end

            return toReturn
        else
            return(xPlayer.get("firstName") .. " " .. xPlayer.get("lastName"))
        end
    else
        return(GetPlayerName(source) .. " [" .. source .. "]")
    end
end

debugprint = function(msg)
    -- print("loaf_housing: " .. msg)
end