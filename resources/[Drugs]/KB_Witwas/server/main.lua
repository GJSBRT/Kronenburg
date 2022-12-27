--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local webhook = "https://discord.com/api/webhooks/938918133895430254/wgOPzOYDOUJLUtdCBGAjCd6PrsM7YFY_W_NSp6lLm3QK0ymFzxS59K-c8fzqNghyz0U0"


function secondsToClock(seconds)
  local seconds = tonumber(seconds)

  if seconds <= 0 then
    return "00:00:00";
  else
    hours = string.format("%02.f", math.floor(seconds/3600));
    mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)));
    secs = string.format("%02.f", math.floor(seconds - hours*3600 - mins *60));
    return hours..":"..mins..":"..secs
  end
end

AddEventHandler('esx_moneywash:playerDropped', function (reason)
	-- print('Player ' .. GetPlayerName(source) .. ' dropped' 'Reden: meer dan 1 miljoen willen witwassen')

  end)  

RegisterServerEvent('esx_moneywash:washMoney')
AddEventHandler('esx_moneywash:washMoney', function(amount, zone)
	local xPlayer = ESX.GetPlayerFromId(source)
	local tax
	local timer
	local amount = tonumber(amount)
	local _source = source
	local enableTimer = false
	--print(zone)
	for k, spot in pairs (Config.Zones) do
		if zone == k then
			tax = spot.TaxRate
			enableTimer = spot.enableTimer
			timer = spot.timer
		end
	end
	--print(tax)
	amount = ESX.Math.Round(tonumber(amount))
	washedCash = amount * tax
	washedTotal = ESX.Math.Round(tonumber(washedCash))

	--print(tax.. ' ' .. timer)
	
	if enableTimer == true then
		--local timer = Config.timer
		local timeClock = ESX.Math.Round(timer / 1000)

	
		if amount > 0 and xPlayer.getAccount('black_money').money >= amount then
			xPlayer.removeAccountMoney('black_money', amount)
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_have_washed_waiting') ..  secondsToClock(timeClock))
			Citizen.Wait(timer)
			
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_have_received') .. ESX.Math.GroupDigits(washedTotal) .. _U('clean_money'))
			xPlayer.addMoney(washedTotal)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_amount'))
		end
	else
			if amount > 999999 and xPlayer.getAccount('black_money').money >= amount then
				local cashgeld = xPlayer.getMoney()
				local bankgeld = xPlayer.getAccount('bank').money
			    local zwartgeld = xPlayer.getAccount('black_money').money
				PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({embeds={{title = "Witwaslog [CHEATER DETECTED]", description = "**Speler** "..GetPlayerName(source).." **heeft € ** "..amount.." **proberen wit te wassen en is daarvoor gebanned\nZwartgeld op zak: € **"..zwartgeld.."\n**Cash geld op zak: € **"..cashgeld.."\n**Geld op bank: € **"..bankgeld.."\n**SteamHex: **"..GetPlayerIdentifier(source).."", footer = { text = " © Fivem2go.nl (FiveM Scripters) "}, color=9109504}}}),  { ['Content-Type'] = 'application/json' })
				Citizen.Wait(500)
				TriggerEvent('bankhackswitwas')
			else
		if amount > 0 and xPlayer.getAccount('black_money').money >= amount then
			xPlayer.removeAccountMoney('black_money', amount)
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_have_washed') .. ESX.Math.GroupDigits(amount) .. _U('dirty_money') .. _U('you_have_received') .. ESX.Math.GroupDigits(washedTotal) .. _U('clean_money'))
			xPlayer.addMoney(washedTotal)
			local cashgeld = xPlayer.getMoney()
			local bankgeld = xPlayer.getAccount('bank').money
		  local zwartgeld = xPlayer.getAccount('black_money').money
						PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({embeds={{title = "Witwaslog", description = "**Speler** "..GetPlayerName(source).." **heeft € ** "..amount.." **witgewassen \nZwartgeld op zak: € **"..zwartgeld.."\n**Cash geld op zak: € **"..cashgeld.."\n**Geld op bank: € **"..bankgeld.."\n**SteamHex: **"..GetPlayerIdentifier(source).."", footer = { text = " © Fivem2go.nl (FiveM Scripters) "}, color=0}}}),  { ['Content-Type'] = 'application/json' })
					else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_amount'))
			end
		end
	end
end)
