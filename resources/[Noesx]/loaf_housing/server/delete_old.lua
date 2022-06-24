CreateThread(function()
    if Config.DeleteHouse then
        ESX = nil

        while ESXEvent == nil do
            Wait(1000)
        end

        TriggerEvent(ESXEvent, function(obj) 
            ESX = obj 
        end)

        local updatedPlayers = {}

        local second = 1000
        local minute = 60 * second
        local hour = 60 * minute

        RegisterServerEvent("loaf_housing:updateJoined")
        AddEventHandler("loaf_housing:updateJoined", function()
            local xPlayer = ESX.GetPlayerFromId(source)
            if xPlayer and xPlayer.identifier then
                if not updatedPlayers[tostring(xPlayer.source)] then
                    updatedPlayers[tostring(xPlayer.source)] = true
                    MySQL.Async.fetchScalar("SELECT `identifier` FROM `loaf_last_login` WHERE `identifier`=@identifier", {
                        ["@identifier"] = xPlayer.identifier,
                    }, function(identifier)
                        if identifier then
                            MySQL.Async.execute("UPDATE `loaf_last_login` SET `login_time` = @login WHERE `identifier`=@identifier", {
                                ["@identifier"] = xPlayer.identifier,
                                ["@login"] = os.time()
                            })
                        else
                            MySQL.Async.execute("INSERT INTO `loaf_last_login` (`identifier`, `login_time`) VALUES (@identifier, @login)", {
                                ["@identifier"] = xPlayer.identifier,
                                ["@login"] = os.time()
                            })
                        end
                    end)
                end
            end
        end)

        while true do            
            local inactive = os.time() - Config.DeleteHouse

            MySQL.Async.fetchAll("SELECT `identifier` FROM `loaf_last_login` WHERE `login_time` <= @delete", {
                ["@delete"] = inactive
            }, function(data)
                for k, v in pairs(data) do
                    local identifier = v.identifier
                    local colonOccurance = string.find(identifier, ":")
                    if not colonOccurance then 
                        colonOccurance = -1 
                    end
                    identifier = string.sub(identifier, colonOccurance + 1, #identifier)

                    MySQL.Async.fetchAll("SELECT `housedata` FROM `loaf_housing` WHERE `identifier` LIKE @identifier", {
                        ["@identifier"] = "%" .. identifier .. "%",
                    }, function(houses)
                        if houses then
                            for k, v in pairs(houses) do
                                for k, v in pairs(v) do
                                    local decoded = json.decode(v)
                                    if decoded then
                                        for k, v in pairs(decoded) do
                                            TriggerEvent("removeAllKeys", "house_" .. k)
                                        end
                                    end
                                end
                            end
                        end

                        MySQL.Async.execute("DELETE FROM `loaf_housing` WHERE `identifier` LIKE @identifier", {
                            ["@identifier"] = "%" .. identifier .. "%",
                        })
    
                        MySQL.Async.execute("DELETE FROM `loaf_bought_houses` WHERE `owner` LIKE @identifier", {
                            ["@identifier"] = "%" .. identifier .. "%",
                        })
    
                        MySQL.Async.execute("DELETE FROM `loaf_last_login` WHERE `identifier`=@identifier", {
                            ["@identifier"] = v.identifier,
                        })
                    end)
                end
            end)

            Wait(8 * hour) -- check for inactive users every 8 hours
        end
    end
end)