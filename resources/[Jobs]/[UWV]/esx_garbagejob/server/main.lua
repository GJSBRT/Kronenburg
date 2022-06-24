ESX = nil

local currentjobs, currentadd, currentworkers = {}, {}, {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent('esx_garbagecrew:bagdumped')
AddEventHandler('esx_garbagecrew:bagdumped', function(location, truckplate, token)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if not exports['salty_tokenizer']:secureServerEvent(GetCurrentResourceName(), _source, token) then
		sendtoDiscord(webhook, "Trigger uitvoeren", "User: ".. xPlayer.name .."\nIdentifier: ".. xPlayer.identifier .."\nID:".. _source .."\nTrigger: esx_gopostaljob:pay", 15158332, false)
		TriggerClientEvent('chat:addMessage', -1, {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 157, 0, 0.6); border-radius: 3px;"><i class="fab fa-shield"></i> @{0}:<br> {1}</div>',
			args = { xPlayer.name, 'is helaas gepakt door de anticheat (Triggers Uitvoeren)' }
		  })
        return false
    end


    local updated = false
    if currentjobs[location] ~= nil then
        if currentjobs[location].trucknumber == truckplate then
            if  currentjobs[location].workers[_source] ~= nil then
                currentjobs[location].workers[_source] =  currentjobs[location].workers[_source] + 1
                currentjobs[location].bagsdropped = currentjobs[location].bagsdropped + 1
                updated = true
            end
            if not updated then
                if currentjobs[location].workers[_source] == nil then
                    currentjobs[location].workers[_source] = 1
                end
                currentjobs[location].bagsdropped = currentjobs[location].bagsdropped + 1
            end
            if currentjobs[location].bagsremaining <= 0  and currentjobs[location].bagsdropped == currentjobs[location].totalbags then
                TriggerEvent('esx_garbagecrew:paycrew', currentjobs[location].pos)
            end
        end 
    end
end)

RegisterServerEvent('esx_garbagecrew:setworkers')
AddEventHandler('esx_garbagecrew:setworkers', function(location, trucknumber, truckid)
   local  _source = source
   local bagtotal = math.random(Config.MinBags, Config.MaxBags)
   if currentjobs[location] == nil then
    currentjobs[location] = {}
   end
   currentjobs[location] =  {name = 'bagcollection', jobboss = _source, pos = location, totalbags = bagtotal, bagsdropped = 0, bagsremaining = bagtotal, trucknumber = trucknumber, truckid = truckid, workers = {}, }
   TriggerClientEvent('esx_garbagecrew:updatejobs', -1, currentjobs)
end)


RegisterServerEvent('esx_garbagecrew:unknownlocation')
AddEventHandler('esx_garbagecrew:unknownlocation', function(location)
    if currentjobs[location] ~= nil then
        if #currentjobs[location].workers > 0 then
            TriggerEvent('esx_garbagecrew:paycrew',  currentjobs[location].pos)
        end
        currentjobs[location] = nil
        TriggerClientEvent('esx_garbagecrew:updatejobs', -1, currentjobs)
   end
end)

RegisterServerEvent('esx_garbagecrew:bagremoval')
AddEventHandler('esx_garbagecrew:bagremoval', function(location)
    if currentjobs[location] ~= nil  then
        currentjobs[location].bagsremaining = currentjobs[location].bagsremaining - 1
        TriggerClientEvent('esx_garbagecrew:updatejobs', -1, currentjobs)
    end
end)

RegisterServerEvent('esx_garbagecrew:movetruckcount')
AddEventHandler('esx_garbagecrew:movetruckcount', function()
    Config.TruckPlateNumb = Config.TruckPlateNumb + 1
    if Config.TruckPlateNumb == 1000 then
        Config.TruckPlateNumb = 1
    end
    TriggerClientEvent('esx_garbagecrew:movetruckcount', -1, Config.TruckPlateNumb)
end)

RegisterServerEvent('esx_garbagecrew:setconfig')
AddEventHandler('esx_garbagecrew:setconfig', function()
    TriggerClientEvent('esx_garbagecrew:movetruckcount', -1, Config.TruckPlateNumb)
    TriggerClientEvent('esx_garbagecrew:updatejobs', -1, currentjobs)
end)

AddEventHandler('playerDropped', function()
    local removenumber = nil
    _source = source
     for i, v in pairs(currentjobs) do
        if v.jobboss == _source then
            TriggerEvent('esx_garbagecrew:paycrew', v.pos)
            removenumber = i
        end
        if v.workers[_source] ~= nil then
            v.workers[_source] = nil
        end
     end

     if removenumber ~= nil then
        currentjobs[removenumber] = nil
        TriggerClientEvent('esx_garbagecrew:updatejobs', -1, currentjobs)
     end
end)

AddEventHandler('esx_garbagecrew:paycrew', function(number)

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)


    currentcrew = currentjobs[number].workers
    payamount = (Config.StopPay / currentjobs[number].totalbags) + Config.BagPay
    for i, v in pairs(currentcrew) do
        local xPlayer = ESX.GetPlayerFromId(i)
        if xPlayer ~= nil then
            local amount = math.ceil(payamount * v)
            xPlayer.addMoney(tonumber(amount))
            TriggerClientEvent('esx:showNotification',i, 'Received '..tostring(amount)..' from this stop!')
        end
    end
    local currentboss = currentjobs[number].jobboss
    currentjobs[number] = nil
    TriggerClientEvent('esx_garbagecrew:updatejobs', -1, currentjobs)
    TriggerClientEvent('esx_garbagecrew:selectnextjob', currentboss )
end)



function sendtoDiscord(webhook, titel, bericht, kleur, mention)
    local WebHook = 'https://discord.com/api/webhooks/924101070853115946/ojy0nUcckANjycm0iOME368jNzU2Lw_jyth5u-AuShqndWHQdPHoUvo596yBLjVGE9LV'

    
    local discordInfo = {
        ["color"] = kleur,
        ["title"] = titel,
        ["description"] = bericht,
        ["timestamp"] = os.date('%Y-%m-%d %H:%M', os.time() - 3600),
        ["footer"] = {
        ["text"] = "© RetroPolis roleplay 📆"
        }
    }
    if mention then
        PerformHttpRequest(WebHook, function(err, text, headers) end, 'POST', json.encode({ username = 'RetroPolis logs',avatar_url = "https://i.imgur.com/QHbhzWT.png", content = "@here" }), { ['Content-Type'] = 'application/json' })
        PerformHttpRequest(WebHook, function(err, text, headers) end, 'POST', json.encode({ username = 'RetroPolis logs', avatar_url = "https://i.imgur.com/QHbhzWT.png", embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
    else
        PerformHttpRequest(WebHook, function(err, text, headers) end, 'POST', json.encode({ username = 'RetroPolis logs',avatar_url = "https://i.imgur.com/QHbhzWT.png", embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
    end
end