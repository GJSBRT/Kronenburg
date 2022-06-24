-------------------------------------
------- Created by T1GER#9080 -------
------------------------------------- 

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Banks = Config.Banks
Safes = Config.Safes
		

function logMessage(title, message, color, source)
	color = color or '16711680'
	message = message or ''
	_source = source or false
	message = message .. '\n\nIdentifiers:\n'
	if _source then
	  local Identifiers = GetPlayerIdentifiers(source)
	  if Identifiers ~= nil then
		for i, k in ipairs(Identifiers) do
		  if string.find(k, 'ip:') then goto continue end
	  if string.find(k, 'discord:') then k = "discord: <@"..k:gsub("discord:", "")..">" end
		  message = message .. k .. '\n'
		  ::continue::
		end 
	  end
	end
	PerformHttpRequest("https://discord.com/api/webhooks/968289297281220619/7AqI3Kx3EJqZOjbFJ6WeMmK9_htOi8FseVxjME6gCKQy4CVOt4jpjDHL92ufgoVhLvA6", function(err, text, headers) end, 'POST', json.encode({embeds={{title = title, description = message, footer = { text = " © Midway City - Cannabclaus#1969 "}, color=color}}}),  { ['Content-Type'] = 'application/json' })
  end
  


RegisterServerEvent('t1ger_bankrobbery:SafeDataSV')
AddEventHandler('t1ger_bankrobbery:SafeDataSV', function(type, id, state)
	local xPlayer = ESX.GetPlayerFromId(source)
	if type == "robbed" then
		Safes[id].robbed = state
	elseif type == "failed" then
		Safes[id].failed = state
	end
	Wait(100)
	TriggerClientEvent('t1ger_bankrobbery:SafeDataCL', -1, type, id, state)
end)

RegisterServerEvent('t1ger_bankrobbery:ResetCurrentBankSV')
AddEventHandler('t1ger_bankrobbery:ResetCurrentBankSV', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	
	-- Banks:
    for i = 1, #Banks do
		Banks[i].inUse = false
		Banks[i].keypads[1].hacked = false
		Banks[i].keypads[2].hacked = false
		Banks[i].deskDoor.lockpicked = false
		for k,v in pairs(Banks[i].deskCash) do
			v.robbed = false
		end
		Banks[i].powerBox.disabled = false
		if i == 8 then
			Banks[i].safe.cracked = false
		end
	end
	
	alertTime = nil

	-- Safes:
	for i = 1, #Safes do
		Safes[i].robbed = false
		Safes[i].failed = false
    end
	TriggerClientEvent('t1ger_bankrobbery:ResetCurrentBankCL', -1)

	-- Secure News:
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' or xPlayer.job.name == 'ambulance' or xPlayer.job.name == 'journalist' then
			TriggerClientEvent('chatMessage', xPlayers[i], "^2News: | ^7", { 128, 128, 128 }, string.sub('The bank has been secured. All banks are now open again!',0))
		end
	end
end) 

-- Drill:
ESX.RegisterServerCallback('t1ger_bankrobbery:drillItem',function(source,cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local gotItem = xPlayer.getInventoryItem(Config.DrillItem).count >= 1
	if gotItem then
		xPlayer.removeInventoryItem(Config.DrillItem, 1)
		cb(true)
	else
		cb(false)
	end
end)

-- Hacker Device:
ESX.RegisterServerCallback('t1ger_bankrobbery:hackerDevice',function(source,cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local gotItem = xPlayer.getInventoryItem(Config.HackItem ).count >= 1
	if gotItem then
		xPlayer.removeInventoryItem(Config.HackItem ,1)
		cb(true)
	else
		cb(false)
	end
end)

-- Lockpick:
ESX.RegisterServerCallback('t1ger_bankrobbery:lockpickItem',function(source,cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local gotItem = xPlayer.getInventoryItem(Config.LockPick).count >= 1
	if gotItem then
		xPlayer.removeInventoryItem(Config.LockPick ,1)
		cb(true)
	else
		cb(false)
	end
end)

-- Hammer & WireCutter:
ESX.RegisterServerCallback('t1ger_bankrobbery:hammerWireCutterItem',function(source,cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local gotItem = xPlayer.getInventoryItem(Config.HammerWireCutter).count >= 1
	if gotItem then
		xPlayer.removeInventoryItem(Config.HammerWireCutter,1)
		cb(true)
	else
		cb(false)
	end
end)

-- Access Card:
ESX.RegisterServerCallback('t1ger_bankrobbery:accessCard',function(source,cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local gotItem = xPlayer.getInventoryItem(Config.AccessCard).count >= 1
	if gotItem then
		cb(true)
	else
		cb(false)
	end
end)

-- Callback to remove item:
ESX.RegisterServerCallback('t1ger_bankrobbery:removeItem',function(source,cb,item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local gotItem = xPlayer.getInventoryItem(item).count >= 1
	if gotItem then
		xPlayer.removeInventoryItem(item,1)
	end
end)

-- Safe Reward:
RegisterServerEvent('t1ger_bankrobbery:safeReward')
AddEventHandler('t1ger_bankrobbery:safeReward', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	
	-- Chance to keep drill:
	math.randomseed(GetGameTimer())
	if math.random(0,100) <= Config.ChanceToKeepDrill then 
		xPlayer.addInventoryItem(Config.DrillItem,1)
	end

	-- Money:
	for k,v in pairs(Config.SafeMoneyReward) do
		local amount = (math.random(v.minAmount, v.maxAmount) * 1000)
		logMessage("Bank overval", "Er werd €"..amount..",- aan geld gestolen uit een kluis.", 0, source)
		if v.dirtyCash then
			xPlayer.addAccountMoney('black_money', amount)
		else
			xPlayer.addMoney(amount)
		end
	end

	-- Item Reward:
	for k,v in pairs(Config.SafeItemRewards) do
		if math.random(0,100) <= v.chance then
			local itemAmount = math.random(v.min,v.max)
			local itemName = ''
			if Config.HasItemLabel then
				itemName = ESX.GetItemLabel(v.item)
			else
				itemName = tostring(v.item)
			end

			
			logMessage("Bank overval", "Er werd "..itemAmount.."x "..v.item.." gestolen uit een kluis.", 0, source)
			xPlayer.addInventoryItem(v.item,itemAmount)
			TriggerClientEvent('t1ger_bankrobbery:ShowNotifyESX', xPlayer.source, (Lang['drill_item_not_usable']:format(itemName,itemAmount)))
		end
	end
end)

RegisterServerEvent('t1ger_bankrobbery:giveItem')
AddEventHandler('t1ger_bankrobbery:giveItem', function(item, token)
	local xPlayer = ESX.GetPlayerFromId(source)
	if not exports['salty_tokenizer']:secureServerEvent(GetCurrentResourceName(), _source, token) then
		logMessage("Bank overval", xPlayer.getName().." probeerde t1ger_bankrobbery:giveItem te exploiten. Item: ".. item, 0, source)
		return false
	end

	xPlayer.addInventoryItem(item,1)
end)

-- Event for police alerts
RegisterServerEvent('t1ger_bankrobbery:PoliceNotifySV')
AddEventHandler('t1ger_bankrobbery:PoliceNotifySV', function(targetCoords, streetName, name)
	TriggerClientEvent('t1ger_bankrobbery:PoliceNotifyCL', -1, (Lang['police_notify']):format(name,streetName))
	TriggerClientEvent('t1ger_bankrobbery:PoliceNotifyBlip', -1, targetCoords)
	TriggerEvent('esx_outlawalert:bankoverval', targetCoords, streetName, 0)
end)

-- Event for police silent alarm
RegisterServerEvent('t1ger_bankrobbery:SilentAlarmSV')
AddEventHandler('t1ger_bankrobbery:SilentAlarmSV', function(name)
	TriggerClientEvent('t1ger_bankrobbery:PoliceNotifyCL', -1, (Lang['silent_alarm']):format(name))
end)

-- get police online:
function getPoliceCount()
	local xPlayers = ESX.GetPlayers()
	PoliceOnline = 0
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			PoliceOnline = PoliceOnline + 1
		end
	end
	TriggerClientEvent('t1ger_bankrobbery:getPoliceCount', -1, PoliceOnline)
	SetTimeout(30 * 1000, getPoliceCount)
end

-- Cash Grab:
RegisterServerEvent('t1ger_bankrobbery:deskCashSV')
AddEventHandler('t1ger_bankrobbery:deskCashSV', function(id, num, state)
    local xPlayer = ESX.GetPlayerFromId(source)
	Banks[id].deskCash[num].robbed = state
	TriggerClientEvent('t1ger_bankrobbery:deskCashCL', -1, id, num, state)
	-- money reward:
	local amount = math.random(Banks[id].deskCash[num].reward.min,Banks[id].deskCash[num].reward.max)
	if Banks[id].deskCash[num].reward.dirty then
		xPlayer.addMoney(amount)
	else
		xPlayer.addAccountMoney('black_money', amount)
	end 
	--TriggerClientEvent('t1ger_bankrobbery:ShowNotifyESX', xPlayer.source, (Lang['drill_item_not_usable']:format(itemName,itemAmount)))
	TriggerClientEvent('t1ger_bankrobbery:ShowNotifyESX', xPlayer.source, "~g~"..amount.."$~s~ in cash taken from the desk")
end)

-- ## POWER BOX ## --

alertTime = nil
RegisterServerEvent('t1ger_bankrobbery:powerBoxSV')
AddEventHandler('t1ger_bankrobbery:powerBoxSV', function(id, state, timer)
    local xPlayer = ESX.GetPlayerFromId(source)
	Banks[id].powerBox.disabled = state
	alertTime = timer
	TriggerClientEvent('t1ger_bankrobbery:powerBoxCL', -1, id, state, alertTime)
end)

RegisterServerEvent('t1ger_bankrobbery:addRobTimeSV')
AddEventHandler('t1ger_bankrobbery:addRobTimeSV', function(timer)
    local xPlayer = ESX.GetPlayerFromId(source)
	alertTime = timer
	TriggerClientEvent('t1ger_bankrobbery:addRobTimeCL', -1, alertTime)
end)

