ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



RegisterServerEvent('esx_retropluk:removehandschoen')
AddEventHandler('esx_retropluk:removehandschoen', function()
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('washandschoen', 1)
end)

ESX.RegisterServerCallback('esx_retropluk:buyLicense', function(source, cb, licenseName)
	local xPlayer = ESX.GetPlayerFromId(source)
	local license = Config.LicensePrices[licenseName]

	if license == nil then
		print(('esx_retropluk: %s attempted to buy an invalid license!'):format(xPlayer.identifier))
		cb(false)
	end

	if xPlayer.getMoney() >= license.price then
		xPlayer.removeMoney(license.price)

		TriggerEvent('esx_license:addLicense', source, licenseName, function()
			cb(true)
		end)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_retropluk:canPickUp', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(item)

	if xItem.limit ~= -1 and xItem.count >= xItem.limit then
		cb(false)
	else
		cb(true)
	end
end)

ESX.RegisterUsableItem('weed', function(source)
	local _source = source
  	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('weed', 1)

	TriggerClientEvent('esx_drugs:onPot', _source)
--	xPlayer.showNotification(_U('used_one_weed'))

--	TriggerClientEvent('esx:showNotification', source, _U('used_one_weed', amount, xItem.label, ESX.Math.GroupDigits(price)))
end)

ESX.RegisterUsableItem('meth', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('meth', 1)

	TriggerClientEvent('esx_drugs:onMeth', _source)
--	xPlayer.showNotification(_U('used_one_meth'))

--	TriggerClientEvent('esx:showNotification', source, _U('used_one_meth', amount, xItem.label, ESX.Math.GroupDigits(price)))

end)

ESX.RegisterUsableItem('heroin', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('heroin', 1)

	TriggerClientEvent('esx_drugs:onOpium', _source)
--	xPlayer.showNotification(_U('used_one_opium'))

--	TriggerClientEvent('esx:showNotification', source, _U('used_one_opium', amount, xItem.label, ESX.Math.GroupDigits(price)))
end)

ESX.RegisterUsableItem('coke', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xItem = 'coke'

	xPlayer.removeInventoryItem('coke', 1)

	TriggerClientEvent('esx_drugs:onCoke', _source)
--	xPlayer.showNotification(_U('used_one_coke'))

--	TriggerClientEvent('esx:showNotification', source, _U('used_one_coke', amount, xItem.label, ESX.Math.GroupDigits(price)))
--	exports['mythic_notify']:DoHudText('succes', 'Je hebt 1 coke gebruikt', { ['background-color'] = '#4844E3', ['color'] = '#000000' })

end)


ESX.RegisterUsableItem('bier', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('bier', 1)

	TriggerClientEvent('esx_drugs:onBier', _source)
--	xPlayer.showNotification(_U('used_one_coke'))


end)

ESX.RegisterUsableItem('washandschoen', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

--	xPlayer.removeInventoryItem('washandschoen', 1)

	TriggerClientEvent('esx_drugs:Washandschoen', _source)
--	xPlayer.showNotification(_U('used_one_coke'))


end)







-- Verpakken Weed, Coke, Meth


local CopsConnected       	   = 0
local PlayersHarvestingCoke    = {}
local PlayersTransformingCoke  = {}
local PlayersSellingCoke       = {}
local PlayersHarvestingMeth    = {}
local PlayersTransformingMeth  = {}
local PlayersSellingMeth       = {}
local PlayersHarvestingWeed    = {}
local PlayersTransformingWeed  = {}
local PlayersSellingWeed       = {}
local PlayersHarvestingOpium   = {}
local PlayersTransformingOpium = {}
local PlayersSellingOpium      = {}

function CountCops()

	local xPlayers = ESX.GetPlayers()

	CopsConnected = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			CopsConnected = CopsConnected + 1
		end
	end

	SetTimeout(120 * 1000, CountCops)
end

CountCops()


local function TransformCoke(source)

	local maxcokeverpak = 200
	local cokeverpakt = 0


	local cokeverpak = math.random(1,4)


	if CopsConnected < Config.RequiredCopsCoke then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsCoke))
		return
	end


	SetTimeout(Config.TimeToProcess, function()

		if cokeverpakt < maxcokeverpak then

			if PlayersTransformingCoke[source] == true then

				local _source = source
				local xPlayer = ESX.GetPlayerFromId(_source)

				local cokeQuantity = xPlayer.getInventoryItem('coke').count
				local poochQuantity = xPlayer.getInventoryItem('coke_pooch').count

				if poochQuantity > 30 then
					TriggerClientEvent('esx:showNotification', source, _U('too_many_pouches'))
				elseif cokeQuantity < 5 then
					TriggerClientEvent('esx:showNotification', source, _U('not_enough_coke'))
				else
					Wait(500)
					xPlayer.removeInventoryItem('coke', 5)
					xPlayer.addInventoryItem('coke_pooch', 1)
				
					cokeverpakt = 1


					TransformCoke(source)



				end

			end
		else
			TriggerClientEvent('esx:showNotification', source, 'De ontvanger kan niet meer bij zich houden, wacht een tijdje en kom dan terug!')

			Citizen.Wait(100000)

		end

	end)
end

RegisterServerEvent('esx_drugs:startTransformCoke')
AddEventHandler('esx_drugs:startTransformCoke', function(token)

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)



--[[
    if not exports['salty_tokenizer']:secureServerEvent(GetCurrentResourceName(), _source, token) then
		sendtoDiscord(webhook, "Trigger uitvoeren", "User: ".. xPlayer.name .."\nIdentifier: ".. xPlayer.identifier .."\nID:".. _source .."\nTrigger: esx_drugs:startTransformCoke", 15158332, false)
		TriggerClientEvent('chat:addMessage', -1, {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 157, 0, 0.6); border-radius: 3px;"><i class="fab fa-shield"></i> @{0}:<br> {1}</div>',
			args = { xPlayer.name, 'is helaas gepakt door de anticheat (Triggers Uitvoeren)' }
		  })
        return false
    end]]

	local jebollezusje = math.floor(token * 2)


	if jebollezusje == 50582 then

		TriggerClientEvent('esx:showNotification', _source, _U('packing_in_prog'))

		PlayersTransformingCoke[_source] = true

		TransformCoke(_source)

	else
		sendtoDiscord(webhook, "Trigger uitvoeren", "User: ".. xPlayer.name .."\nIdentifier: ".. xPlayer.identifier .."\nID:".. _source .."\nTrigger: esx_drugs:startTransformCoke", 15158332, false)
		TriggerClientEvent('chat:addMessage', -1, {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 157, 0, 0.6); border-radius: 3px;"><i class="fab fa-shield"></i> @{0}:<br> {1}</div>',
			args = { xPlayer.name, 'is helaas gepakt door de anticheat (Triggers Uitvoeren)' }
		})
	end

end)



RegisterServerEvent('esx_drugs:stopTransformCoke')
AddEventHandler('esx_drugs:stopTransformCoke', function()

	local _source = source

	PlayersTransformingCoke[_source] = false

end)

local function SellCoke(source)

	if CopsConnected < Config.RequiredCopsCoke then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsCoke))
		return
	end

	SetTimeout(Config.TimeToSell, function()

		if PlayersSellingCoke[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local poochQuantity = xPlayer.getInventoryItem('coke_pooch').count

			if poochQuantity == 0 then
				TriggerClientEvent('esx:showNotification', source, _U('no_pouches_sale'))
			else
				xPlayer.removeInventoryItem('coke_pooch', 1)
				if CopsConnected == 0 then
					xPlayer.addAccountMoney('black_money', 1000)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_coke'))
				elseif CopsConnected == 1 then
					xPlayer.addAccountMoney('black_money', 1000)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_coke'))
				elseif CopsConnected == 2 then
					xPlayer.addAccountMoney('black_money', 1000)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_coke'))
				elseif CopsConnected == 3 then
					xPlayer.addAccountMoney('black_money', 1000)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_coke'))
				elseif CopsConnected == 4 then
					xPlayer.addAccountMoney('black_money', 1000)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_coke'))
				elseif CopsConnected >= 5 then
					xPlayer.addAccountMoney('black_money', 1000)
					TriggerClientEvent('esx:showNotification', source, _U('sold_one_coke'))
				else
					TriggerEvent("el_bwh:ban", ESX.GetPlayerFromId(_source), ESX.GetPlayerFromId(_source), 'Trigger Uitvoeren.', '6969/12/30 12:00', offline)
				end
				
				SellCoke(source)
			end

		end
	end)
end

RegisterServerEvent('esx_drugs:startSellCoke')
AddEventHandler('esx_drugs:startSellCoke', function(token)

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	--[[
    if not exports['salty_tokenizer']:secureServerEvent(GetCurrentResourceName(), _source, token) then
		sendtoDiscord(webhook, "Trigger uitvoeren", "User: ".. xPlayer.name .."\nIdentifier: ".. xPlayer.identifier .."\nID:".. _source .."\nTrigger: esx_drugs:startSellCoke", 15158332, false)
		TriggerClientEvent('chat:addMessage', -1, {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 157, 0, 0.6); border-radius: 3px;"><i class="fab fa-shield"></i> @{0}:<br> {1}</div>',
			args = { xPlayer.name, 'is helaas gepakt door de anticheat (Triggers Uitvoeren)' }
		  })
        return false
    end]]

	local jebollezusje = math.floor(token * 2)


	if jebollezusje == 50582 then

		PlayersSellingCoke[_source] = true

		TriggerClientEvent('esx:showNotification', _source, _U('sale_in_prog'))

		SellCoke(_source)
	else
		sendtoDiscord(webhook, "Trigger uitvoeren", "User: ".. xPlayer.name .."\nIdentifier: ".. xPlayer.identifier .."\nID:".. _source .."\nTrigger: esx_drugs:startTransformCoke", 15158332, false)
		TriggerClientEvent('chat:addMessage', -1, {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 157, 0, 0.6); border-radius: 3px;"><i class="fab fa-shield"></i> @{0}:<br> {1}</div>',
			args = { xPlayer.name, 'is helaas gepakt door de anticheat (Triggers Uitvoeren)' }
		})
	end

end)

RegisterServerEvent('esx_drugs:stopSellCoke')
AddEventHandler('esx_drugs:stopSellCoke', function()

	local _source = source

	PlayersSellingCoke[_source] = false

end)


--[[meth
local function HarvestMeth(source)

	if CopsConnected < Config.RequiredCopsMeth then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsMeth))
		return
	end
	
	SetTimeout(Config.TimeToFarm, function()

		if PlayersHarvestingMeth[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local meth = xPlayer.getInventoryItem('meth')

			if meth.limit ~= -1 and meth.count >= meth.limit then
				TriggerClientEvent('esx:showNotification', source, _U('inv_full_meth'))
			else
				xPlayer.addInventoryItem('meth', 1)
				HarvestMeth(source)
			end

		end
	end)
end

]]

local function TransformMeth(source)

	if CopsConnected < Config.RequiredCopsMeth then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsMeth))
		return
	end

	SetTimeout(Config.TimeToProcess, function()

		if PlayersTransformingMeth[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local methQuantity = xPlayer.getInventoryItem('meth').count
			local poochQuantity = xPlayer.getInventoryItem('meth_pooch').count

			if poochQuantity >30 then
				TriggerClientEvent('esx:showNotification', source, _U('too_many_pouches'))
			elseif methQuantity < 5 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_meth'))
			else
				xPlayer.removeInventoryItem('meth', 3)
				xPlayer.addInventoryItem('meth_pooch', 1)
				
				TransformMeth(source)
			end

		end
	end)
end

RegisterServerEvent('esx_drugs:startTransformMeth')
AddEventHandler('esx_drugs:startTransformMeth', function(token)

	local _source = source
	local jebollezusje = math.floor(token * 2)


	if jebollezusje == 50582 then
		PlayersTransformingMeth[_source] = true

		TriggerClientEvent('esx:showNotification', _source, _U('packing_in_prog'))

		TransformMeth(_source)
	else
		sendtoDiscord(webhook, "Trigger uitvoeren", "User: ".. xPlayer.name .."\nIdentifier: ".. xPlayer.identifier .."\nID:".. _source .."\nTrigger: esx_drugs:startTransformCoke", 15158332, false)
		TriggerClientEvent('chat:addMessage', -1, {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 157, 0, 0.6); border-radius: 3px;"><i class="fab fa-shield"></i> @{0}:<br> {1}</div>',
			args = { xPlayer.name, 'is helaas gepakt door de anticheat (Triggers Uitvoeren)' }
		})
	end
end)



RegisterServerEvent('esx_drugs:stopTransformMeth')
AddEventHandler('esx_drugs:stopTransformMeth', function()

	local _source = source

	PlayersTransformingMeth[_source] = false

end)

local function SellMeth(source)

	if CopsConnected < Config.RequiredCopsMeth then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsMeth))
		return
	end

	SetTimeout(Config.TimeToSell, function()

		if PlayersSellingMeth[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local poochQuantity = xPlayer.getInventoryItem('meth_pooch').count

			if poochQuantity == 0 then
				TriggerClientEvent('esx:showNotification', _source, _U('no_pouches_sale'))
			else
				xPlayer.removeInventoryItem('meth_pooch', 1)
				xPlayer.addAccountMoney('black_money', 2400)
				TriggerClientEvent('esx:showNotification', source, _U('sold_one_meth'))

				
				SellMeth(source)
			end

		end
	end)
end

RegisterServerEvent('esx_drugs:startSellMeth')
AddEventHandler('esx_drugs:startSellMeth', function(token)

	local _source = source

	local jebollezusje = math.floor(token * 2)


	if jebollezusje == 50582 then
		PlayersSellingMeth[_source] = true

		TriggerClientEvent('esx:showNotification', _source, _U('sale_in_prog'))

		SellMeth(_source)
	else
		sendtoDiscord(webhook, "Trigger uitvoeren", "User: ".. xPlayer.name .."\nIdentifier: ".. xPlayer.identifier .."\nID:".. _source .."\nTrigger: esx_drugs:startTransformCoke", 15158332, false)
		TriggerClientEvent('chat:addMessage', -1, {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 157, 0, 0.6); border-radius: 3px;"><i class="fab fa-shield"></i> @{0}:<br> {1}</div>',
			args = { xPlayer.name, 'is helaas gepakt door de anticheat (Triggers Uitvoeren)' }
		})
	end
end)



RegisterServerEvent('esx_drugs:stopSellMeth')
AddEventHandler('esx_drugs:stopSellMeth', function()

	local _source = source

	PlayersSellingMeth[_source] = false

end)

--weed


local function TransformWeed(source)

	if CopsConnected < Config.RequiredCopsWeed then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsWeed))
		return
	end

	SetTimeout(Config.TimeToProcess, function()

		if PlayersTransformingWeed[source] == true then

			local _source = source
  			local xPlayer = ESX.GetPlayerFromId(_source)
			local weedQuantity = xPlayer.getInventoryItem('weed').count
			local poochQuantity = xPlayer.getInventoryItem('weed_pooch').count

			if poochQuantity > 30 then
				TriggerClientEvent('esx:showNotification', source, _U('too_many_pouches'))
			elseif weedQuantity < 5 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_weed'))
			else
				xPlayer.removeInventoryItem('weed', 5)
				xPlayer.addInventoryItem('weed_pooch', 1)
				
				TransformWeed(source)
			end

		end
	end)
end

RegisterServerEvent('esx_drugs:startTransformWeed')
AddEventHandler('esx_drugs:startTransformWeed', function(token)

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

--[[   if not exports['salty_tokenizer']:secureServerEvent(GetCurrentResourceName(), _source, token) then
		sendtoDiscord(webhook, "Trigger uitvoeren", "User: ".. xPlayer.name .."\nIdentifier: ".. xPlayer.identifier .."\nID:".. _source .."\nTrigger: sx_retrodrugs:startTransformWeed", 15158332, false)
		TriggerClientEvent('chat:addMessage', -1, {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 157, 0, 0.6); border-radius: 3px;"><i class="fab fa-shield"></i> @{0}:<br> {1}</div>',
			args = { xPlayer.name, 'is helaas gepakt door de anticheat (Triggers Uitvoeren)' }
		  })
        return false
    end]]

	local jebollezusje = math.floor(token * 2)

	if jebollezusje == 50582 then

		PlayersTransformingWeed[_source] = true

		TriggerClientEvent('esx:showNotification', _source, _U('packing_in_prog'))

		TransformWeed(_source)
	else
		sendtoDiscord(webhook, "Trigger uitvoeren", "User: ".. xPlayer.name .."\nIdentifier: ".. xPlayer.identifier .."\nID:".. _source .."\nTrigger: esx_drugs:startTransformCoke", 15158332, false)
		TriggerClientEvent('chat:addMessage', -1, {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 157, 0, 0.6); border-radius: 3px;"><i class="fab fa-shield"></i> @{0}:<br> {1}</div>',
			args = { xPlayer.name, 'is helaas gepakt door de anticheat (Triggers Uitvoeren)' }
		})
	end

end)


RegisterServerEvent('esx_drugs:stopTransformWeed')
AddEventHandler('esx_drugs:stopTransformWeed', function()

	local _source = source

	PlayersTransformingWeed[_source] = false

end)



local function SellWeed(source)

	if CopsConnected < Config.RequiredCopsMeth then
		TriggerClientEvent('esx:showNotification', source, _U('act_imp_police', CopsConnected, Config.RequiredCopsMeth))
		return
	end

	SetTimeout(Config.TimeToSell, function()

		if PlayersSellingWeed[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local poochQuantity = xPlayer.getInventoryItem('weed_pooch').count

			if poochQuantity == 0 then
				TriggerClientEvent('esx:showNotification', _source, _U('no_pouches_sale'))
			else
				xPlayer.removeInventoryItem('weed_pooch', 1)
				xPlayer.addAccountMoney('black_money', 250)
				TriggerClientEvent('esx:showNotification', source, _U('sold_one_weed'))
				
				SellWeed(source)
			end

		end
	end)
end

RegisterServerEvent('esx_drugs:startSellWiet')
AddEventHandler('esx_drugs:startSellWiet', function(token)

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

    --[[if not exports['salty_tokenizer']:secureServerEvent(GetCurrentResourceName(), _source, token) then
		sendtoDiscord(webhook, "Trigger uitvoeren", "User: ".. xPlayer.name .."\nIdentifier: ".. xPlayer.identifier .."\nID:".. _source .."\nTrigger: esx_drugs:startSellWiet", 15158332, false)
		TriggerClientEvent('chat:addMessage', -1, {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 157, 0, 0.6); border-radius: 3px;"><i class="fab fa-shield"></i> @{0}:<br> {1}</div>',
			args = { xPlayer.name, 'is helaas gepakt door de anticheat (Triggers Uitvoeren)' }
		  })
        return false
    end]]

	local jebollezusje = math.floor(token * 2)

	if jebollezusje == 50582 then


		PlayersSellingWeed[_source] = true

		TriggerClientEvent('esx:showNotification', _source, _U('sale_in_prog'))

		SellWeed(_source)
	else
		sendtoDiscord(webhook, "Trigger uitvoeren", "User: ".. xPlayer.name .."\nIdentifier: ".. xPlayer.identifier .."\nID:".. _source .."\nTrigger: esx_drugs:startTransformCoke", 15158332, false)
		TriggerClientEvent('chat:addMessage', -1, {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 157, 0, 0.6); border-radius: 3px;"><i class="fab fa-shield"></i> @{0}:<br> {1}</div>',
			args = { xPlayer.name, 'is helaas gepakt door de anticheat (Triggers Uitvoeren)' }
		})
	end
end)



RegisterServerEvent('esx_drugs:stopSellWeed')
AddEventHandler('esx_drugs:stopSellWeed', function()

	local _source = source

	PlayersSellingWeed[_source] = false

end)


--opium




RegisterServerEvent('esx_drugs:GetUserInventory')
AddEventHandler('esx_drugs:GetUserInventory', function(currentZone)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	TriggerClientEvent('esx_drugs:ReturnInventory', 
		_source, 
		xPlayer.getInventoryItem('coke').count, 
		xPlayer.getInventoryItem('coke_pooch').count,
		xPlayer.getInventoryItem('meth').count, 
		xPlayer.getInventoryItem('meth_pooch').count, 
		xPlayer.getInventoryItem('weed').count, 
		xPlayer.getInventoryItem('weed_pooch').count, 
		xPlayer.getInventoryItem('coke').count, 
		xPlayer.getInventoryItem('coke_pooch').count,
		xPlayer.job.name, 
		currentZone
	)
end)


function sendtoDiscord(webhook, titel, bericht, kleur, mention)
    local WebHook = 'https://discord.com/api/webhooks/970813309198696539/IitcWddbFavdjVf66AfhMea5lcFymVdOA-SgFEAXuupUSNsR40pPbjc84bKrxssX0bqw'

    
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