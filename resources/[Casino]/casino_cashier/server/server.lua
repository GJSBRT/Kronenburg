ESX = nil
local DiscordWebhook = "https://discord.com/api/webhooks/969992057471008868/z7AyQvw8OKEEM95xV89X_Ww2XkRHLDOnr8M46z0b_7SB3Kh_p-aWkm3cI-DYxTfECdzK"
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('esx_society:registerSociety', 'casino', 'casino', 'society_casino', 'society_casino', 'society_casino', {type = 'private'})
-- sell chips
RegisterServerEvent('casino:deposit')
AddEventHandler('casino:deposit', function(amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local item = xPlayer.getInventoryItem('casino_chips').count
	if amount == nil or amount <= 0 or amount > item then
        -- error notification
		TriggerClientEvent('t-notify:client:Custom', _source, {
			style = 'success',
			message = 'Casino: Je hebt niet genoeg chips!',
			duration = 5500,
			sound = true
		})
	else
		
		if xPlayer ~= nil then
			xPlayer.removeInventoryItem('casino_chips', amount)
			xPlayer.addAccountMoney(Config.dollar, tonumber(amount))
			
			local name = xPlayer.getName()
			local Desc = name.." **heeft** " .. amount .. " ** chips verkocht.\n\n  License:** "..xPlayer.identifier
			logMessage("Uitbetaling", Desc, 0, xPlayer.source)
			-- success notification
			TriggerClientEvent('t-notify:client:Custom', _source, {
				style = 'success',
				message = 'Casino: je verkocht '..amount..' chips',
				duration = 5500,
				sound = true
			})
		end
	end
end)

-- buy chips
RegisterServerEvent('casino:withdraw')
AddEventHandler('casino:withdraw', function(amount, price)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local base = 0
	amount = tonumber(amount)
	base = xPlayer.getAccount(Config.dollar).money
	if amount == nil or amount <= 0 or amount > base then
        -- error notification
		TriggerClientEvent('t-notify:client:Custom', _source, {
			style = 'error',
			message = 'Casino: Je hebt niet genoeg geld!',
			duration = 5500,
			sound = true
		})
	else
		amount = math.floor(amount)
		amountToCasino = math.floor(amount / 100 * 10)
		xPlayer.addInventoryItem('casino_chips', amount)
		xPlayer.removeAccountMoney(Config.dollar, amount)
		
		TriggerEvent('esx_addonaccount:getSharedAccount', 'society_casino', function(account)
			account.addMoney(amountToCasino)
			TriggerEvent('casino_job:notifyEmployee', '+ € '.. amountToCasino..',- voor Casino. [Chips]', 7, '#06a94d')
		end)
		-- TriggerServerEvent('esx_society:withdrawMoney', society, cutForBalance)
        -- success notification

		local name = xPlayer.getName()
		local Desc = name.." **heeft** " .. amount .. " ** chips ingekocht.\n\n  License:** "..xPlayer.identifier
		logMessage("Inkoop", Desc, 0, xPlayer.source)
		TriggerClientEvent('t-notify:client:Custom', _source, {
			style = 'success',
			message = 'Casino: je kocht '..amount..' chips"',
			duration = 5500,
			sound = true
		})
	end
end)
local canBuyTicket = true
-- buy ticket
RegisterServerEvent('casino:ticket')
AddEventHandler('casino:ticket', function(amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if canBuyTicket == false then
		xPlayer.showNotification('Je kunt dit na de restart doen')
	else
		local funds = 0
		tickets = tonumber(amount)
		ticket_cost = (tickets * Config.ticket)
		funds = xPlayer.getAccount(Config.dollar).money
		if funds == nil or funds <= 0 or ticket_cost > funds then
			-- error notification
			TriggerClientEvent('t-notify:client:Custom', _source, {
				style = 'error',
				message = 'Casino: Je hebt niet genoeg geld!',
				duration = 5500,
				sound = true
			})
		else
			xPlayer.addInventoryItem('luckywheel',amount)
			xPlayer.removeAccountMoney(Config.dollar, ticket_cost)
			local amountToCasino = math.floor(ticket_cost / 100 * 10)
			TriggerEvent('esx_addonaccount:getSharedAccount', 'society_casino', function(account)
				account.addMoney(amountToCasino)
				TriggerEvent('casino_job:notifyEmployee', '+ € '.. amountToCasino..',- voor casino. [Luckywheel tickets]', 7, '#06a94d')
			end)
			-- success notification
			TriggerClientEvent('t-notify:client:Custom', _source, {
				style = 'success',
				message = 'Casino: je kocht '..amount..' Lucky Wheel Tickets voor €'..ticket_cost,
				duration = 5500,
				sound = true 
			})
		end
	end
end)

RegisterServerEvent('casino:balance')
AddEventHandler('casino:balance', function()

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	balance = xPlayer.getInventoryItem('casino_chips').count
	TriggerClientEvent('chips_currentbalance1', _source, balance)
	
end)


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
