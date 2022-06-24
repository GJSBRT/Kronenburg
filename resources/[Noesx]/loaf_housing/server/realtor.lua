local fetched_houses = false

RegisterNetEvent("loaf_housing:request_houses")
AddEventHandler("loaf_housing:request_houses", function()
    local src = source
    if Config.REA then
        while not fetched_houses do
            Wait(500)
        end

        if GetPlayerName(src) then
            TriggerClientEvent("loaf_housing:set_houses", src, Config.Houses)
        end
    end
end)

local FetchHouses = function()
    fetched_houses = false

    MySQL.Async.fetchAll("SELECT * FROM `loaf_houses`", {}, function(result)
        Config.Houses = {}

        for k, v in pairs(result) do
            local entrance = json.decode(v.entrance)
            entrance = vector4(entrance.x, entrance.y, entrance.z, entrance.h)

            Config.Houses[v.id] = {
                Label = v.label, 
                Price = v.price,
                Entrance = entrance,
                Type = v.property_type,
                ShellType = v.shell_type
            }

            local garage_entrance, garage_exit = json.decode(v.garage_entrance), json.decode(v.garage_exit)
            if garage_entrance and garage_exit and garage_entrance.x and garage_exit.h then
                garage_entrance = vector3(garage_entrance.x, garage_entrance.y, garage_entrance.z)
                garage_exit = vector4(garage_exit.x, garage_exit.y, garage_exit.z, garage_exit.h)
                Config.Houses[v.id].Garage = {
                    Entrance = garage_entrance, 
                    Exit = garage_exit
                }
            end

            if v.shell_id then
                Config.Houses[v.id].ShellId = v.shell_id
            end
        end

        fetched_houses = true
    end)
end

AddEventHandler("loaf_housing:assignHouse", function(player, house, shell, cb)
    local src = source
    if Config.REA and src == "" and Config.Houses[house] then
        if not SetOwnsHouse(player, house, shell) and cb then
            cb(false)
        end
    end
end)

AddEventHandler("loaf_housing:update_houses", function()
    local src = source
    if Config.REA and src == "" then
        FetchHouses()
        while not fetched_houses do
            Wait(500)
        end

        TriggerClientEvent("loaf_housing:set_houses", -1, Config.Houses)
    end
end)

MySQL.ready(function()
    if Config.REA then
        FetchHouses()
    end
end)

RegisterNetEvent("loaf_housing:fetch_housecfg")
AddEventHandler("loaf_housing:fetch_housecfg", function(cb)
    if cb then 
        cb(Config.Houses) 
    end
end)