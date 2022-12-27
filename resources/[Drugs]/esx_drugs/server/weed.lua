--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
local playersProcessingweed = {}
local maxperdag = 5000
local pickedtoday = 0


local maxperrun = math.random(50,200)
local pickedrun = 0



isActive = false



--[[


Citizen.CreateThread(function()
    local _source = source
    local xPlayers = ESX.GetPlayers() 


	while true do

		Citizen.Wait(10)

--        Citizen.Wait(math.random(200000,4000000))
        Citizen.Wait(math.random(200000,400000))
        isActive = true


        Citizen.Wait(20000)
	end
end)



ESX.RegisterServerCallback('esx_sebasdrugs:GetWeedActiveState', function(source, cb)

	local xPlayer = ESX.GetPlayerFromId(source)

	if isActive then
		cb(true)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_sebasdrugs:GetWeed2ActiveState', function(source, cb)

	local xPlayer = ESX.GetPlayerFromId(source)

	if isActive then
		cb(true)
	else
		cb(false)
	end
end)

]]

RegisterServerEvent('esx_retropluk:pickedUpweed')
AddEventHandler('esx_retropluk:pickedUpweed', function(token)
	local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers() 
	local xItem = xPlayer.getInventoryItem('weed')
	local _source = source
	local random = math.random(1,4)

	local jebollezusje = math.floor(token * 2)

	if jebollezusje == 50582 then


        if xPlayer.getInventoryItem('weed').count <= 60 then
 --           if pickedrun < maxperrun then
                if pickedtoday < maxperdag then
                    xPlayer.addInventoryItem("weed", random)
                    pickedtoday = pickedtoday + random
                    pickedrun = pickedrun + random
                else
                    TriggerClientEvent('esx:showNotification', _source, ('Deze drugs zijn nog niet klaar om verzameld te worden!'))
                    spawned = false
                end
--            else
--                Citizen.Wait(10)
--                pickedrun = 0
--
--                TriggerClientEvent('esx:showNotification', _source, ('Deze drugs zijn nog niet klaar om verzameld te worden!'))
--                isActive = false
 --               spawned = false
 --           end
        else
            TriggerClientEvent('esx:showNotification', source, '~r~Je kan niet meer dragen')
        end
--    else
 --       TriggerClientEvent('esx:showNotification', _source, ('Deze drugs zijn nog niet klaar om verzameld te worden!'))
 --   end

    else
        sendtoDiscord(webhook, "Trigger uitvoeren", "User: ".. xPlayer.name .."\nIdentifier: ".. xPlayer.identifier .."\nID:".. _source .."\nTrigger: esx_drugs:startTransformCoke", 15158332, false)
        TriggerClientEvent('chat:addMessage', -1, {
            template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 157, 0, 0.6); border-radius: 3px;"><i class="fab fa-shield"></i> @{0}:<br> {1}</div>',
            args = { xPlayer.name, 'is helaas gepakt door de anticheat (Triggers Uitvoeren)' }
        })
        TriggerEvent("el_bwh:ban", ESX.GetPlayerFromId(_source), ESX.GetPlayerFromId(_source), 'Helaas... Vandaag effe niet topper!', '6969/04/20 12:00', offline)
        DropPlayer(_source, "BWH Kick")
    end

end)




function CancelProcessing(playerID)
	if playersProcessingweed[playerID] then
		ESX.ClearTimeout(playersProcessingweed[playerID])
		playersProcessingweed[playerID] = nil
	end
end

RegisterServerEvent('esx_retropluk:cancelProcessing')
AddEventHandler('esx_retropluk:cancelProcessing', function()
	CancelProcessing(source)
end)

AddEventHandler('esx:playerDropped', function(playerID, reason)
	CancelProcessing(playerID)
end)

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	CancelProcessing(source)
end)



function sendtoDiscordd(webhook, titel, bericht, kleur, mention)
    local WebHook = 'https://discord.com/api/webhooks/970812619667693598/utMpwX9CQzUsxsMLgbWyIq3cJVM8cB_xlnzjHeA8cairMDANqhD_94COfUgl4-C8DP5e'

    
    local discordInfo = {
        ["color"] = kleur,
        ["title"] = titel,
        ["description"] = bericht,
        ["timestamp"] = os.date('%Y-%m-%d %H:%M', os.time() - 3600),
        ["footer"] = {
        ["text"] = "© The Whoo 📆"
        }
    }
    if mention then
        PerformHttpRequest(WebHook, function(err, text, headers) end, 'POST', json.encode({ username = 'The Whoo logs',avatar_url = "https://i.imgur.com/QHbhzWT.png", content = "@here" }), { ['Content-Type'] = 'application/json' })
        PerformHttpRequest(WebHook, function(err, text, headers) end, 'POST', json.encode({ username = 'The Whoo logs', avatar_url = "https://i.imgur.com/QHbhzWT.png", embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
    else
        PerformHttpRequest(WebHook, function(err, text, headers) end, 'POST', json.encode({ username = 'The Whoo logs',avatar_url = "https://i.imgur.com/QHbhzWT.png", embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
    end
end



function sendToDiscord (name,message,color)
    local DiscordWebHook = "https://discord.com/api/webhooks/854369473679196170/lIqcuViYyogaHJvjtIYOVDtiImUyAWg_Zd2HFEfzvqhYXjry1PTGil2TX7OXbxilJ_Pq"
  
          local embeds = {
        {
            ["title"]=message,
            ["type"]="rich",
            ["color"] =color,
            ["footer"]=  {
            ["text"]= "logs",
            },
        }
    }
  
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function sendToDiscord2 (name,message,color)
    local DiscordWebHook = "https://discord.com/api/webhooks/854369405969498152/JGgMvCYI3ZnTF6-xLmPUiHlBbm36iNSTOyoFaaCjn0z7mD8rRIEwivHXNrsYJopfVkwK"
  
          local embeds = {
        {
            ["title"]=message,
            ["type"]="rich",
            ["color"] =color,
            ["footer"]=  {
            ["text"]= "logs",
            },
        }
    }
  
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end


