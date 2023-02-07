ESX						= nil


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent('esx_worek:closest')
AddEventHandler('esx_worek:closest', function()
    local name = GetPlayerName(najblizszy)
    TriggerClientEvent('esx_worek:nalozNa', najblizszy)
end)

RegisterServerEvent('esx_worek:sendclosest')
AddEventHandler('esx_worek:sendclosest', function(closestPlayer)
    najblizszy = closestPlayer
end)

RegisterServerEvent('esx_worek:zdejmij')
AddEventHandler('esx_worek:zdejmij', function()
    TriggerClientEvent('esx_worek:zdejmijc', najblizszy)
end)

RegisterServerEvent('esx_handcuff:jute')
AddEventHandler('esx_handcuff:jute', function(target, type)

        local xPlayer = ESX.GetPlayerFromId(source)

                    xPlayer.removeInventoryItem("headbag", 1)
                    TriggerClientEvent('esx_handcuff:jute', source)
end)

RegisterServerEvent('esx_handcuff:jute2')
AddEventHandler('esx_handcuff:jute2', function(target, type)

        local xPlayer = ESX.GetPlayerFromId(source)

                    xPlayer.addInventoryItem("headbag", 1)
                    TriggerClientEvent('esx_handcuff:jute2', source)
end)

-- License
print("^5KOOS IS GAY")
print("^5KOOS IS GAY")
print("^5KOOS IS GAY")
print("^5KOOS IS GAY")
print("^5KOOS IS GAY")
print("^5KOOS IS GAY")
print("^5KOOS IS GAY")
print("^5KOOS IS GAY")
print("^5KOOS IS GAY")
print("^5KOOS IS GAY")
print("^5KOOS IS GAY")
print("^5KOOS IS GAY")




ESX.RegisterUsableItem('headbag', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('esx_worek:naloz', _source)
    TriggerClientEvent('esx_handcuff:jute', source)
    TriggerEvent('esx_worek:debugger', source)
end)