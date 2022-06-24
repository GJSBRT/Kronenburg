math.randomseed(os.time())
ESX = nil
isRoll = false
local car = Config.Cars[math.random(#Config.Cars)]

TriggerEvent(Config.ESX, function(obj) ESX = obj end)
ESX.RegisterServerCallback('vns_cs_wheel:server:getVerifyToken', function(source, cb)
	local src = source
	local token, resourcename = exports['DRGNV_tokenizer']:generateToken(GetCurrentResourceName(), src)
	while token == nil do
		Wait(500)
	end
	cb(token, resourcename)
end)

DiscordWebhook = "https://discord.com/api/webhooks/971710083048300575/S0f_yIW4zdvsG_GayCD5zjanSf7hP0iGGM30Ak26msZwrTzSf-bILA_Tk92Tc2RnPSxn"

function logMessage(title, message, color, src)
	color = color or '16711680'
	message = message or ''
	_source = src or false
	message = message .. '\n\nIdentifiers:\n'
	if _source then
	  local Identifiers = GetPlayerIdentifiers(_source)
	  if Identifiers ~= nil then
		for i, k in ipairs(Identifiers) do
		  if string.find(k, 'ip:') then goto continue end
	  if string.find(k, 'discord:') then k = "discord: <@"..k:gsub("discord:", "")..">" end
		  message = message .. k .. '\n'
		  ::continue::
		end 
	  end
	end
	PerformHttpRequest(DiscordWebhook, function(err, text, headers) end, 'POST', json.encode({embeds={{title = title, description = message, footer = { text = " Kronenburgertje RP "}, color=color}}}),  { ['Content-Type'] = 'application/json' })

end

if Config.DailySpin then
	Citizen.CreateThread(function()
		while true do
		Citizen.Wait(1000*60)
			if os.date('%H:%M') == Config.ResetSpin then
				MySQL.Sync.execute('UPDATE users SET wheel = 0')
			end
		end
	end)
end

ESX.RegisterServerCallback('vns_cs_wheel:getcar', function(source, cb)
	cb(car)
end)

RegisterServerEvent('vns_cs_wheel:getwheel')
AddEventHandler('vns_cs_wheel:getwheel', function(JeroenNietDoenHAHAHHA)
    local _source = source
	if not exports['DRGNV_tokenizer']:verifyToken(GetCurrentResourceName(), _source, JeroenNietDoenHAHAHHA, "vns_cs_wheel:getwheel") then
		return
    end

	local xPlayer = ESX.GetPlayerFromId(_source)
    if not isRoll then
		if Config.DailySpin == true then
			local rol = false
			local item = xPlayer.getInventoryItem('luckywheel')
			if item ~= nil and item ~= false then
				if item.count > 0 then
					xPlayer.removeInventoryItem('luckywheel', 1)
					TriggerEvent("vns_cs_wheel:startwheel", xPlayer, _source)
					message = xPlayer.getName() .." [ID: "..  _source .. "] heeft zojuist aan het wiel gedraaid. [Daily spin]"
					logMessage("Draai aan het wieletje!", message, 5963658, _source)
					return true
				end
			end

			MySQL.Async.fetchScalar('SELECT wheel FROM users WHERE identifier = @identifier', {
				['@identifier'] = xPlayer.identifier
			}, function(dwheel)
				dwheel= tonumber(dwheel)
				if dwheel == 0 then
					TriggerEvent("vns_cs_wheel:startwheel", xPlayer, _source)
					message = xPlayer.getName() .." [ID: "..  _source .. "] heeft zojuist aan het wiel gedraaid. [Daily spin]"
					logMessage("Draai aan het wieletje!", message, 5963658, _source)
					return false
				else
					TriggerClientEvent('esx:showNotification', _source, _U('already_spin'))
				end
			end)

		elseif Config.DailySpin == false then
			if xPlayer.getMoney() >= Config.SpinMoney then
				TriggerEvent("vns_cs_wheel:startwheel", xPlayer, _source)
				xPlayer.removeMoney(Config.SpinMoney)
				message = xPlayer.getName() .." [ID: ".. _source .. "] heeft zojuist aan het wiel gedraaid. [Kosten: ".. Config.SpinMoney .. "]"
				logMessage("Draai aan het wieletje!", message, 5963658, _source)
			else
				TriggerClientEvent('esx:showNotification', _source, _U('not_money'))
			end
		end
	end
end)	
	
	

RegisterServerEvent('vns_cs_wheel:startwheel')
AddEventHandler('vns_cs_wheel:startwheel', function(xPlayer, source)
    local _source = source
    if not isRoll then
        if xPlayer ~= nil then
			MySQL.Sync.execute('UPDATE users SET wheel = @wheel WHERE identifier = @identifier', {
				['@identifier'] = xPlayer.identifier,
				['@wheel'] = '1'
			})
			isRoll = true
			local rnd = math.random(1, 1000)
			local price = 0
			local priceIndex = 0
			for k,v in pairs(Config.Prices) do
				if (rnd > v.probability.a) and (rnd <= v.probability.b) then
					price = v
					priceIndex = k
					break
				end
			end
			TriggerClientEvent("vns_cs_wheel:syncanim", _source, priceIndex)
			TriggerClientEvent("vns_cs_wheel:startroll", -1, _source, priceIndex, price)
		end
	end
end)

RegisterServerEvent('vns_cs_wheel:give')
AddEventHandler('vns_cs_wheel:give', function(s, price, JeroenNietDoenHAHAHHA)
    local _s = s
	-- if not exports['DRGNV_tokenizer']:verifyToken(GetCurrentResourceName(), _s, JeroenNietDoenHAHAHHA, "vns_cs_wheel:give") then
	-- 	return
    -- end
	local xPlayer = ESX.GetPlayerFromId(_s)
	isRoll = false
	
	message = xPlayer.getName() .. " [ID: " .. xPlayer.source .. "] heeft zojuist "

	if price.type == 'car' then
		TriggerClientEvent("vns_cs_wheel:winCar", _s, car)
		TriggerClientEvent('esx:showNotification', _s, _U('you_won_car'))
		message = message .. "een voertuig gewonnen. Voertuigmodel: ".. car
	elseif price.type == 'item' then
		xPlayer.addInventoryItem(price.name, price.count)
		TriggerClientEvent('esx:showNotification', _s, _U('you_won_item', price.count, ESX.GetItemLabel(price.name)))
		message = message .. "een voorwerp gewonnen. Voorwerp: ".. ESX.GetItemLabel(price.name) .. ". Aantal: ".. price.count
	elseif price.type == 'money' then
		xPlayer.addAccountMoney('bank', price.count)
		TriggerClientEvent('esx:showNotification', _s, _U('you_won_money', price.count))
		message= message .. "bankgeld gewonnen. Hoeveelheid: € ".. price.count
	elseif price.type == 'weapon' then
		xPlayer.addWeapon(price.name, 0)
		TriggerClientEvent('esx:showNotification', _s, _U('you_won_weapon', ESX.GetWeaponLabel(price.name)))
		message = message .. "een wapen gewonnen. Wapennaam/hash: ".. ESX.GetWeaponLabel(price.name)
	end
	
	TriggerEvent('casino_job:notifyEmployee', message, 7, '#06a94d')
	logMessage("Gewonnen!", message, 16736347, _s)
	TriggerClientEvent("vns_cs_wheel:rollFinished", -1)
end)

RegisterServerEvent('vns_cs_wheel:stoproll')
AddEventHandler('vns_cs_wheel:stoproll', function()
	isRoll = false
end)