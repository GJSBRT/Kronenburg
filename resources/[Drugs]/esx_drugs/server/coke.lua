--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local playersProcessingCocaLeaf = {}
local maxperdag = 4000
local pickedtoday = 0

local maxperrun = math.random(30,100)
local pickedrun = 0



local isActive = false
local spawned = false


--[[

Citizen.CreateThread(function()
    local _source = source
    local xPlayers = ESX.GetPlayers() 


	while true do


        Citizen.Wait(math.random(2000000,4000000))
        if isActive then
--            print("was al actief dus hoeft neit actief te zetten")
        else
            isActive = true
            print("Coke Set Active")
        end

        Citizen.Wait(2000)
	end
end)]]



--[[

Citizen.CreateThread(function()
    local _source = source
    local xPlayers = ESX.GetPlayers() 


	while true do


        Citizen.Wait(20000)

        if isActive then
            if not spawned then
                if pickedrun < maxperrun then
                    spawned = true
                else
                    isActive = false
 --                   print("maximaal aantaal geplukt maar nog wel actief hihi")
                end
            end
        end

        Citizen.Wait(20000)
	end
end)]]


ESX.RegisterServerCallback('esx_sebasdrugs:GetActiveState', function(source, cb)

	local xPlayer = ESX.GetPlayerFromId(source)

	if isActive then
		cb(true)
	else
		cb(false)
	end
end)



RegisterServerEvent('esx_retropluk:pickedUpCocaLeaf')
AddEventHandler('esx_retropluk:pickedUpCocaLeaf', function(token)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers() 
	local xItem = xPlayer.getInventoryItem('coke')
	local _source = source
	local random = math.random(1,4)

	local jebollezusje = math.floor(token * 2)

	if jebollezusje == 50582 then


		if xPlayer.getInventoryItem('coke').count <= 60 then

				if pickedtoday < maxperdag then
					xPlayer.addInventoryItem("coke", random)
					pickedtoday = pickedtoday + random
                    pickedrun = pickedrun + random
				else
					TriggerClientEvent('esx:showNotification', _source, ('Deze drugs zijn nog niet klaar om verzameld te worden!'))

                    spawned = false
				end

		else
			TriggerClientEvent('esx:showNotification', source, '~r~Je kan niet meer dragen')

		end
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

function sendtoDiscord(webhook, titel, bericht, kleur, mention)
    local WebHook = 'https://discord.com/api/webhooks/924101070853115946/ojy0nUcckANjycm0iOME368jNzU2Lw_jyth5u-AuShqndWHQdPHoUvo596yBLjVGE9LV'

    
    local discordInfo = {
        ["color"] = kleur,
        ["title"] = titel,
        ["description"] = bericht,
        ["timestamp"] = os.date('%Y-%m-%d %H:%M', os.time() - 3600),
        ["footer"] = {
        ["text"] = "© The Whoo roleplay 📆"
        }
    }
    if mention then
        PerformHttpRequest(WebHook, function(err, text, headers) end, 'POST', json.encode({ username = 'The Whoo logs',avatar_url = "https://i.imgur.com/QHbhzWT.png", content = "@here" }), { ['Content-Type'] = 'application/json' })
        PerformHttpRequest(WebHook, function(err, text, headers) end, 'POST', json.encode({ username = 'The Whoo logs', avatar_url = "https://i.imgur.com/QHbhzWT.png", embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
    else
        PerformHttpRequest(WebHook, function(err, text, headers) end, 'POST', json.encode({ username = 'The Whoo logs',avatar_url = "https://i.imgur.com/QHbhzWT.png", embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
    end
end

function sendToKanus(name,message,color)
    local DiscordWebHook = "https://discord.com/api/webhooks/970813104290164806/3JJh_Ma00MeoyFPiqcZ9RG5pV5fvH3S_pCij8W4RJ7ji6APPxAkuw_M8BNIydLVc5dnN"
  
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