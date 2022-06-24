ValidPlates = {}
ESX = nil

--[[ Functions ]]
function Log(type, message)
    if (type == "info") then
        print("[^2\x1b[1mINFO\x1b[0m^7] \x1b[45m\x1b[30m|Pepperspray|\x1b[0m\x1b[1m ^7"..message.."\x1b[0m^0")
    elseif (type == "error") then
        print("[^1\x1b[1mERROR\x1b[0m^7] \x1b[45m\x1b[30m|Pepperspray|\x1b[0m\x1b[1m ^7"..message.."\x1b[0m^0")
    elseif (type == "ban") then
        print("[^4\x1b[1mBANNED\x1b[0m^7] \x1b[45m\x1b[30m|Pepperspray|\x1b[0m\x1b[1m ^7"..message.."\x1b[0m^0")
    end
end

function trim(s)
    return (string.gsub(s, '%s+', ''))
end

function Ban(source, reason)
    Log("ban", reason)
    exports['KB_Logger']:DiscordLog("https://discord.com/api/webhooks/943664248196829255/wiuGeprRlUCKDhAixoJpslu2x5oK8f94KIrrMXzRPY0o-_eZ2WVGskzNj97UkeNvWCK-", "Speler verbannen", "Player: "..GetPlayerName(source).. " "  ..GetPlayerIdentifiers(source)[1].."\n".. "\nReden: "..reason , false, source)
    --DropPlayer(source, reason)
end

--[[ Events ]]
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("pepperspray:playerconnect")
AddEventHandler("pepperspray:playerconnect", function ()
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll("SELECT plate FROM owned_vehicles WHERE owner = ?", { xPlayer.identifier }, function (results)
        if (results ~= nil) then
            for i, x in pairs(results) do
                if (ValidPlates[trim(x.plate)] == nil) then
                    ValidPlates[trim(x.plate)] = true
                end
            end
        end
    end)
end)

RegisterServerEvent("pepperspray:addVehiclePlate")
AddEventHandler("pepperspray:addVehiclePlate", function (plate)
    if (plate ~= nil) then
        if (ValidPlates[trim(plate)] == nil) then
            ValidPlates[trim(plate)] = true
            Log("info", "Added "..plate.." to valid plates")
        end
    end
end)

RegisterServerEvent("pepperspray:removeVehiclePlate")
AddEventHandler("pepperspray:removeVehiclePlate", function (plate)
    if (plate ~= nil) then
        ValidPlates[trim(plate)] = nil
        Log("info", "Removed "..plate.." to valid plates")
    end
end)

RegisterServerEvent("pepperspray:isInVeh")
AddEventHandler("pepperspray:isInVeh", function (plate)
    if (plate ~= nil) then
        if (ValidPlates[trim(plate)] == nil) then
            Ban(source, "Voertuig inspawnen")
        end
    end
end)

--[[ Commands ]]
--[[ RegisterCommand("getplates", function ()
    print(ESX.DumpTable(ValidPlates))
end, false)


RegisterCommand("syncveh", function (source)
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner = ?", { xPlayer.identifier }, function (results)
        if (results ~= nil) then
            for i, x in pairs(results) do
                ValidPlates[trim(x.plate)] = true
                Log("info", "Added "..x.plate.." to valid plates")
            end
        end
    end)
end, false) ]]

