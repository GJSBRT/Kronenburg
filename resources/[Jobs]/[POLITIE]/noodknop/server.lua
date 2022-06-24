ESX                = nil


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local webhook = "https://discord.com/api/webhooks/848700161428815873/xg2LTIjD9DqwtGXYLD4_doDpDqVnhwT8Cds0MnHvY8gn9ADHANTJ6diKeVIYtHKDbzeT"

RegisterServerEvent('sendChatMessage')
AddEventHandler('sendChatMessage', function(message)
    TriggerClientEvent('chatMessage', -1, '', {255,255,255}, message)
end)
RegisterServerEvent('Noodknop')
AddEventHandler('Noodknop', function(x,y,z)
    TriggerClientEvent('NoodknopC', -1, x,y,z, GetPlayerName(source))
end)

RegisterServerEvent('NoodknopWeg')
AddEventHandler('NoodknopWeg', function(x,y,z)
    TriggerClientEvent('NoodknopWeg', -1, x,y,z, GetPlayerName(source))
end)

RegisterServerEvent('noodknop:log')
AddEventHandler('noodknop:log', function()
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({embeds={{title = "🚨Noodknop ingedrukt🚨", description = "**Agent** "..GetPlayerName(source).." **Heeft zijn noodknop ingedrukt**", color=16711680}}}),  { ['Content-Type'] = 'application/json' })

end)


RegisterServerEvent('PolLocatie')
AddEventHandler('PolLocatie', function(x,y,z)
    TriggerClientEvent('PolLocatieC', -1, x,y,z, GetPlayerName(source))
end)

