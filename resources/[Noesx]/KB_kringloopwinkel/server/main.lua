
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local dwebhook = "https://discord.com/api/webhooks/826239194136707112/aIhl6OYgR-fhQzFXFVDIyqTJSBNiszw-8zB5qbJPb6cCr-5NIFjx27NyhWEPxJpbWb8e"

    RegisterServerEvent('MrNewbspawnshop:sell')
    AddEventHandler('MrNewbspawnshop:sell', function(itemName, amount, storenumber)
        local price = 0
        local xPlayer = ESX.GetPlayerFromId(source)
        for i, v in pairs(Config.Items) do
            if v.name == itemName and v.storenumber == storenumber then
                price = v.price
                break
            end
        end
        local xItem = xPlayer.getInventoryItem(itemName)


        if xItem.count < amount then
            TriggerClientEvent('esx:showNotification', source, _U('not_enough'))
            return
        end

        price = ESX.Math.Round(price * amount)

        if Config.GiveBlack then
            xPlayer.addAccountMoney('black_money', price)
        else
            xPlayer.addMoney(price)
        end

        xPlayer.removeInventoryItem(xItem.name, amount)

        TriggerClientEvent('esx:showNotification', source, _U('sold', amount, xItem.label, ESX.Math.GroupDigits(price)))
		
PerformHttpRequest(dwebhook, function(err, text, headers) end, 'POST', json.encode({embeds={{title = "Kringloop log", description = "**Speler** "..GetPlayerName(source).." **Heeft** "..amount.." **x** "..itemName.."** verkocht voor** "..price.." **euro \nSpeler ID :** "..source.."**\nSteamHex : **"..GetPlayerIdentifier(source).."", footer = { text = " © KronenburgRP "}, color=12708126}}}),  { ['Content-Type'] = 'application/json' })

    end)
