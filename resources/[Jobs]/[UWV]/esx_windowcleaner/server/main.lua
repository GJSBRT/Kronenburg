--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
ESX                			 = nil
local PlayersVente			 = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_windowcleaner:GiveItem')
AddEventHandler('esx_windowcleaner:GiveItem', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)


	local Quantity = xPlayer.getInventoryItem(Config.Zones.Vente.ItemRequires).count

	if Quantity >= 20 then
		TriggerClientEvent('esx:showNotification', _source, _U('stop_npc'))
		return
	else
		local amount = Config.Zones.Vente.ItemAdd
		local item = Config.Zones.Vente.ItemDb_name
		xPlayer.addInventoryItem(item, math.random(1,4))
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt het raam schoongemaakt')
	end

end)




local function Vente(source)

	SetTimeout(Config.Zones.Vente.ItemTime, function()

		if PlayersVente[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local Quantity = xPlayer.getInventoryItem(Config.Zones.Vente.ItemRequires).count

			if Quantity < Config.Zones.Vente.ItemRemove then
				TriggerClientEvent('esx:showNotification', _source, '~r~Je hebt geen facturen meer.')
				PlayersVente[_source] = false
			else
				local amount = Config.Zones.Vente.ItemRemove
				local item = Config.Zones.Vente.ItemRequires
				xPlayer.removeInventoryItem(item, amount)
				xPlayer.addMoney(Config.Zones.Vente.ItemPrice)
				TriggerClientEvent('esx:showNotification', _source, 'je hebt ~g~€' .. Config.Zones.Vente.ItemPrice .. ' ontvangen')
				Vente(_source)
			end

		end
	end)
end

RegisterServerEvent('esx_windowcleaner:startVente')
AddEventHandler('esx_windowcleaner:startVente', function()

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)


	if PlayersVente[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, '~r~Exit and return to the area !')
		PlayersVente[_source] = false
	else
		PlayersVente[_source] = true
		TriggerClientEvent('esx:showNotification', _source, '~g~Aan het ~w~verkopen...')
		Vente(_source)
	end
end)




RegisterServerEvent('esx_windowcleaner:stopVente')
AddEventHandler('esx_windowcleaner:stopVente', function()

	local _source = source

	if PlayersVente[_source] == true then
		PlayersVente[_source] = false
	else
		PlayersVente[_source] = true
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