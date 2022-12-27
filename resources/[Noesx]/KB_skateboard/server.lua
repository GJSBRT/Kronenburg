--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
AllowedPlayers = {}
ESX = nil

RegisterServerEvent("shareImOnSkate")
AddEventHandler("shareImOnSkate", function() 
    local _source = source
    TriggerClientEvent("shareHeIsOnSkate", -1, _source)
end)

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("longboard:playerconnect")
AddEventHandler("longboard:playerconnect", function ()
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.query("SELECT skateboard FROM user_perks WHERE license = ?", { xPlayer.identifier }, function (results)
        if (results[1] ~= nil) then
            if (results[1]['skateboard'] == true) then
                AllowedPlayers[xPlayer.identifier] = true
            end
        end
    end)
end)


RegisterCommand("skateboard", function(source, args, rawCommand)
    if (source > 0) then
        local xPlayer = ESX.GetPlayerFromId(source)
        if (AllowedPlayers[xPlayer.identifier] ~= nil or IsPlayerAceAllowed(source, "skateboard")) then
            TriggerClientEvent("longboard:start", source)
        else
            TriggerClientEvent('chat:addMessage', source, {
                template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.8); border-radius: 3px;"><b>^*Systeem^r:</b> Om /skateboard te gebruiken moet je gedoneert hebben^r</div>'
            })
        end
    else
        print("This command was executed by the server console, RCON client, or a resource.")
    end
end, false)