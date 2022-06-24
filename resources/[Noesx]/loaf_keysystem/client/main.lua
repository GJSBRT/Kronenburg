OpenKeyMenu = function()
    print("ESX not loaded")
end

local CachedKeys = {}
local key_usages = {}

CreateThread(function()
    while not NetworkIsSessionStarted() do -- wait for the client to load the game
        Wait(250)
    end

    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(esx) -- get esx object
            ESX = esx 
        end)
        Wait(50)
    end
    
    while ESX.GetPlayerData().job == nil do -- wait until the character has a job (kashacters support)
        Wait(50)
    end

    TriggerServerEvent("loaf_keysystem:joined")

    OpenKeyMenu = function()
        ESX.UI.Menu.CloseAll()

        local keys = json.decode(json.encode(CachedKeys))   
        local elements = {}
        if #keys > 0 then
            for k, v in pairs(keys) do
                v.key_data = json.decode(v.key_data)
                table.insert(elements, {label = v.key_data.name, id = v.key_id, unique_id = v.unique_id, data = v.key_data})
            end
        else
            table.insert(elements, {label = Strings["no_keys"]})
        end

        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "keymenu", {
            title = Strings["main_menu"],
            align = "bottom-right",
            elements = elements
        }, function(data, menu)
            local currentKey, currentUnique = data.current.id, data.current.unique_id

            if currentKey then
                ESX.UI.Menu.Open("default", GetCurrentResourceName(), "individualkeymenu", {
                    title = data.current.label,
                    align = "bottom-right",
                    elements = {
                        {label = Strings["transfer_nearby"], value = "transfer"},
                        {label = Strings["use"], value = "use"},
                        {label = Strings["remove"], value = "remove"}
                    }
                }, function(data2, menu2)
                    local currentValue = data2.current.value
    
                    if currentValue == "transfer" then
                        elements = {}

                        for k, v in pairs(GetActivePlayers()) do
                            if v ~= PlayerId() then
                                local ped = GetPlayerPed(v)
                                if #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(ped)) <= 3.0 then
                                    local foundName, startedSearch, name = false, GetGameTimer(), GetPlayerName(v) .. " | " .. GetPlayerServerId(v)
                                    
                                    ESX.TriggerServerCallback("loaf_keysystem:getRpName", function(n)
                                        if n then
                                            name = n
                                        end
                                        foundName = true
                                    end, GetPlayerServerId(v))

                                    while not foundName do
                                        if GetGameTimer() - startedSearch > 3000 then
                                            break
                                        end

                                        Wait(50)
                                    end

                                    table.insert(elements, {
                                        label = name,
                                        value = v,
                                    })
                                end
                            end
                        end

                        if #elements == 0 then
                            table.insert(elements, {label = Strings["none_nearby"], value = "none"})
                        end

                        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "transferkeymenu", {
                            title = Strings["transfer"] .. " - " .. data.current.label,
                            align = "bottom-right",
                            elements = elements
                        }, function(data3, menu3)
                            local currentPlayer = data3.current.value
                            if currentPlayer ~= "none" then
                                local ped = GetPlayerPed(currentPlayer)
                                if #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(ped)) <= 4.0 then
                                    ESX.TriggerServerCallback("loaf_keysystem:transferKey", function(success)
                                        if success then
                                            ESX.UI.Menu.CloseAll()
                                            ESX.ShowNotification(string.format(Strings["gave_key"], data3.current.label))
                                            OpenKeyMenu()
                                        else
                                            ESX.ShowNotification(Strings["couldnt_give"])
                                        end
                                    end, GetPlayerServerId(currentPlayer), currentUnique)
                                else
                                    ESX.ShowNotification(Strings["no_longer_nearby"])
                                end
                            end
                        end, function(data3, menu3)
                            menu3.close()
                        end)
                    elseif currentValue == "use" then
                        if key_usages[currentKey] then
                            key_usages[currentKey](currentKey)
                        end

                        if data.current.data and data.current.data.eventtype then
                            if data.current.data.eventtype == "server" and data.current.data.eventname then
                                TriggerServerEvent(data.current.data.eventname, data.current.data)
                            elseif data.current.data.eventtype == "client" and data.current.data.eventname then
                                TriggerEvent(data.current.data.eventname, data.current.data)
                            end
                        end
                    elseif currentValue == "remove" then
                        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "confirm_remove", {
                            title = Strings["confirm_remove"],
                            align = "bottom-right",
                            elements = {
                                {label = Strings["yes"], value = "yes"},
                                {label = Strings["no"], value = "no"},
                            }
                        }, function(data3, menu3)
                            if data3.current.value == "yes" then
                                ESX.TriggerServerCallback("loaf_keysystem:removeKey", function()
                                    ESX.UI.Menu.CloseAll()
                                    Wait(250)
                                    OpenKeyMenu()
                                end, data.current.unique_id)
                            else
                                menu3.close()
                            end
                        end, function(data3, menu3)
                            menu3.close()
                        end)
                    end
    
                end, function(data2, menu2)
                    menu2.close()
                end)
            end

        end, function(data, menu)
            menu.close()
        end)
    end
end)

RegisterNetEvent("loaf_keysystem:setUsage")
AddEventHandler("loaf_keysystem:setUsage", function(key_id, cb)
    if key_id and type(key_id) == "string" and cb then
        key_usages[key_id] = cb
        print(cb)
    end
end)

RegisterNetEvent("loaf_keysystem:openMenu")
AddEventHandler("loaf_keysystem:openMenu", function()
    OpenKeyMenu()
end)

RegisterNetEvent("loaf_keysystem:setKeys")
AddEventHandler("loaf_keysystem:setKeys", function(keys)
    CachedKeys = keys
end)

if Config.Command then
    RegisterCommand(Config.Command, function()
        OpenKeyMenu()
    end)
end

exports("HasKey", function(key_id)
    for k, v in pairs(CachedKeys) do
        if v.key_id == key_id then
            return true
        end
    end
    return false
end)

exports("GetKeys", function()
    return CachedKeys
end)