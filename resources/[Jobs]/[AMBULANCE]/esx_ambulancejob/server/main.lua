--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
ESX = nil
local playersHealing, deadPlayers = {}, {}
local webhook = "https://canary.discord.com/api/webhooks/948744111534534709/NHuwKUf4ZxSpgJ_cDSYx4ATliiJ8joTAGTIkmUpC5QLRKxUkx5sEQi8dUngwYm3wO9cB"
local ambuwebhook = "https://discord.com/api/webhooks/860215563221205002/wkbwnNtLzFQ2HUAtsiGIY0p9zE15CGUXbezEUfZ4_K2Gzz0_vyhyAx75nX5cJs9SOQsr"
--local kmarwebhook = "https://discord.com/api/webhooks/836656444585017434/bbw-ciTzs422Xo3Hz7re13GYkkLyuf-v0-cC6ZZAW3NzP--Wqy39cMNVnhBsrzJ9Bfr6"
local combatlogwebhook = "https://discord.com/api/webhooks/942473434363994174/Rfu-KMGqJDsWO2X_-sgv15kNtA2BnKIDN9XEFLL_bUiVz0jIJ3xNbdMo6mG3YRsybSIa"
local itemsdood = "https://discord.com/api/webhooks/942473102854594560/EnA70At-4K9hxad8V_TOJ7NisLoh6DktZM28mVta9k1_Y7_dO9jTq4V2CFM_LP7hK7BU"
local itemsrespawn = "https://discord.com/api/webhooks/942473237315596288/8UQj1h8Y2okJ2lltwLOoYd8bQL6KB5wrM1rrG6iXJ0uNMkpn40yheyehbbUs_l6Mp4l9"

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('esx_phone:registerNumber', 'ambulance', _U('alert_ambulance'), true, true)
TriggerEvent('esx_society:registerSociety', 'ambulance', 'Ambulance', 'society_ambulance', 'society_ambulance', 'society_ambulance', { type = 'public' })




RegisterNetEvent('esx_ambulancejob:revive')
AddEventHandler('esx_ambulancejob:revive', function(playerId, token)
	local _source = source

	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer and xPlayer.job.name == 'ambulance' then
		local xTarget = ESX.GetPlayerFromId(playerId)

		if xTarget then
			if deadPlayers[playerId] then
				if Config.ReviveReward > 0 then
					xPlayer.showNotification(_U('revive_complete_award', xTarget.name, Config.ReviveReward))
					xPlayer.addMoney(Config.ReviveReward)
					xTarget.triggerEvent('esx_ambulancejob:revive')
					--PerformHttpRequest(ambuwebhook, function(err, text, headers) end, 'POST', json.encode({embeds={{title = "Ambulance revive log", description = "**Ambulancier** "..xPlayer.getName().." **heeft** "..xTarget.getName().." **gereanimeerd\nSteamnaam van ambulancier : **"..GetPlayerName(source).."\n**Rang van ambulancier : **"..xPlayer.job.grade_label.."", footer = { text = " © 𝘿𝙧𝙪𝙜𝙖𝙣𝙤𝙫#6843 📅 "..os.date("%d/%m/%Y - %X")}, color=15056385}}}),  { ['Content-Type'] = 'application/json' })
					exports['KB_Logger']:DiscordLog("https://canary.discord.com/api/webhooks/948697521495105538/QZXLRayUlZu_Lyscqrye6mTEUkdNMop5SqYVf2P-fHVkjjFrWMwNjwtNiHoPkQAFt8jy", "Ambulance Revice", "**Ambulancier** " .. xPlayer.getName() .. " **heeft** " .. xTarget.getName() .. " **gereanimeerd\nSteamnaam van ambulancier : **" .. GetPlayerName(_source) .. "\n**Rang van ambulancier : **" .. xPlayer.job.grade_label, false, _source)
				else
					xPlayer.showNotification(_U('revive_complete', xTarget.name))
					xTarget.triggerEvent('esx_ambulancejob:revive')
				end
			else
				xPlayer.showNotification(_U('player_not_unconscious'))
			end
		else
			xPlayer.showNotification(_U('revive_fail_offline'))
		end
	end
end)

RegisterNetEvent('esx_policejob:revive')
AddEventHandler('esx_policejob:revive', function(playerId, token)
	local _source = source
	if not exports['salty_tokenizer']:secureServerEvent(GetCurrentResourceName(), _source, token) then
		return false
	end
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer and xPlayer.job.name == "police" or xPlayer.job.name == "ambulance" or xPlayer.job.name == "kmar" then
		local xTarget = ESX.GetPlayerFromId(playerId)

		if xTarget then
			if deadPlayers[playerId] then
				if Config.ReviveReward > 0 then
					--xPlayer.showNotification(_U('revive_complete_award', xTarget.name, Config.ReviveReward))
					--xPlayer.addMoney(Config.ReviveReward)
					xTarget.triggerEvent('esx_ambulancejob:revive')
					--PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({embeds={{title = "Politie revive log", description = "**Agent** "..xPlayer.getName().." **heeft** "..xTarget.getName().." **gereanimeerd\nSteamnaam van agent : **"..GetPlayerName(source).."\n**Rang van agent : **"..xPlayer.job.grade_label.."", footer = { text = " © 𝘿𝙧𝙪𝙜𝙖𝙣𝙤𝙫#6843 📅 "..os.date("%d/%m/%Y - %X")}, color=1644912}}}),  { ['Content-Type'] = 'application/json' })
					exports['KB_Logger']:DiscordLog("https://canary.discord.com/api/webhooks/948744111534534709/NHuwKUf4ZxSpgJ_cDSYx4ATliiJ8joTAGTIkmUpC5QLRKxUkx5sEQi8dUngwYm3wO9cB", "Politie Revive", "**Agent** " .. xPlayer.getName() .. " **heeft** " .. xTarget.getName() .. " **gereanimeerd\nSteamnaam van agent : **" .. GetPlayerName(source) .. "\n**Rang van agent : **" .. xPlayer.job.grade_label, false, source)
				else
					xPlayer.showNotification(_U('revive_complete', xTarget.name))
					xTarget.triggerEvent('esx_ambulancejob:revive')
				end
			else
				xPlayer.showNotification(_U('player_not_unconscious'))
			end
		else
			xPlayer.showNotification(_U('revive_fail_offline'))
		end
	end
end)

--[[RegisterNetEvent('esx_kmarjob:revive')
AddEventHandler('esx_kmarjob:revive', function(playerId)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer and xPlayer.job.name == "police" or xPlayer.job.name == "ambulance" or xPlayer.job.name == "kmar" then
		local xTarget = ESX.GetPlayerFromId(playerId)

		if xTarget then
			if deadPlayers[playerId] then
				if Config.ReviveReward > 0 then
					--xPlayer.showNotification(_U('revive_complete_award', xTarget.name, Config.ReviveReward))
					--xPlayer.addMoney(Config.ReviveReward)
					xTarget.triggerEvent('esx_ambulancejob:revive')
PerformHttpRequest(kmarwebhook, function(err, text, headers) end, 'POST', json.encode({embeds={{title = "KMar revive log", description = "**Marrechaussee** "..xPlayer.getName().." **heeft** "..xTarget.getName().." **gereanimeerd\nSteamnaam van agent : **"..GetPlayerName(source).."\n**Rang van agent : **"..xPlayer.job.grade_label.."", footer = { text = " © 𝘿𝙧𝙪𝙜𝙖𝙣𝙤𝙫#6843 📅 "..os.date("%d/%m/%Y - %X")}, color=3066993}}}),  { ['Content-Type'] = 'application/json' })

				else
					xPlayer.showNotification(_U('revive_complete', xTarget.name))
					xTarget.triggerEvent('esx_ambulancejob:revive')
				end
			else
				xPlayer.showNotification(_U('player_not_unconscious'))
			end
		else
			xPlayer.showNotification(_U('revive_fail_offline'))
		end
	end
end)
]]


RegisterNetEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	deadPlayers[source] = 'dead'
	TriggerClientEvent('esx_ambulancejob:setDeadPlayers', -1, deadPlayers)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local inventory = xPlayer.getInventory()
	local cash = xPlayer.getMoney()
	local zwartgeld = xPlayer.getAccount('black_money').money
	local wapens = xPlayer.getLoadout()
	local output = ""
	for i, item in ipairs(inventory) do
		if item.count > 0 then
			output = output .. string.format("%s x %d, ", item.label, item.count)
		end
	end
	--sendToDiscord('Dooditems', "[Death-log]\n".. GetPlayerName(source) .." is doodgegaan met de volgende items opzak: **"..output.. cash.." cash geld en "..zwartgeld.." euro zwartgeld.\n\n Wapens (loadout): **" ..json.encode(wapens).."", 11750815)
	PerformHttpRequest(itemsdood, function(err, text, headers) end, 'POST', json.encode({ embeds = { { title = "Dood items", description = "**Speler **" .. GetPlayerName(source) .. "** is doodgegaan met de volgende items opzak **" .. output .. "** €**" .. cash .. " **cash en €**" .. zwartgeld .. "** zwartgeld\n\nWapen loadout **" .. json.encode(wapens) .. "", footer = { text = " © 𝘿𝙧𝙪𝙜𝙖𝙣𝙤𝙫#6843 📅 " .. os.date("%d/%m/%Y - %X") }, color = 3066993 } } }), { ['Content-Type'] = 'application/json' })

end)

RegisterServerEvent('esx_ambulancejob:svsearch')
AddEventHandler('esx_ambulancejob:svsearch', function()
	TriggerClientEvent('esx_ambulancejob:clsearch', -1, source)
end)

RegisterNetEvent('esx_ambulancejob:onPlayerDistress')
AddEventHandler('esx_ambulancejob:onPlayerDistress', function()
	if deadPlayers[source] then
		deadPlayers[source] = 'distress'
		TriggerClientEvent('esx_ambulancejob:setDeadPlayers', -1, deadPlayers)
	end
end)

RegisterNetEvent('esx:onPlayerSpawn')
AddEventHandler('esx:onPlayerSpawn', function()
	if deadPlayers[source] then
		deadPlayers[source] = nil
		TriggerClientEvent('esx_ambulancejob:setDeadPlayers', -1, deadPlayers)
	end
end)

AddEventHandler('esx:playerDropped', function(playerId, reason)
	if deadPlayers[playerId] then
		deadPlayers[playerId] = nil
		TriggerClientEvent('esx_ambulancejob:setDeadPlayers', -1, deadPlayers)
	end
end)

RegisterNetEvent('esx_ambulancejob:heal')
AddEventHandler('esx_ambulancejob:heal', function(target, type)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('esx_ambulancejob:heal', target, type)
	end
end)

RegisterNetEvent('esx_ambulancejob:putInVehicle')
AddEventHandler('esx_ambulancejob:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('esx_ambulancejob:putInVehicle', target)
	end
end)

ESX.RegisterServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local inventory = xPlayer.getInventory()
	local cash = xPlayer.getMoney()
	local zwartgeld = xPlayer.getAccount('black_money').money
	local wapens = xPlayer.getLoadout()
	local output = ""
	for i, item in ipairs(inventory) do
		if item.count > 0 then
			output = output .. string.format("%s x %d, ", item.label, item.count)
		end
	end
	PerformHttpRequest(itemsrespawn, function(err, text, headers) end, 'POST', json.encode({ embeds = { { title = "Respawn", description = "**Speler **" .. GetPlayerName(source) .. "** is gerespawned en is de volgende items kwijt: **" .. output .. "** €**" .. cash .. " **cash en €**" .. zwartgeld .. "** zwartgeld\n\nWapen loadout **" .. json.encode(wapens) .. "", footer = { text = " © 𝘿𝙧𝙪𝙜𝙖𝙣𝙤𝙫#6843 📅 " .. os.date("%d/%m/%Y - %X") }, color = 16711680 } } }), { ['Content-Type'] = 'application/json' })

	if Config.RemoveCashAfterRPDeath then
		if xPlayer.getMoney() > 0 then
			xPlayer.removeMoney(xPlayer.getMoney())
		end

		if xPlayer.getAccount('black_money').money > 0 then
			xPlayer.setAccountMoney('black_money', 0)
		end
	end

	if Config.RemoveItemsAfterRPDeath then
		for i = 1, #xPlayer.inventory, 1 do
			if xPlayer.inventory[i].count > 0 then
				xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)
			end
		end
	end

	local playerLoadout = {}
	if Config.RemoveWeaponsAfterRPDeath then
		for i = 1, #xPlayer.loadout, 1 do
			xPlayer.removeWeapon(xPlayer.loadout[i].name)
		end
	else -- save weapons & restore em' since spawnmanager removes them
		for i = 1, #xPlayer.loadout, 1 do
			table.insert(playerLoadout, xPlayer.loadout[i])
		end

		-- give back wepaons after a couple of seconds
		Citizen.CreateThread(function()
			Citizen.Wait(5000)
			for i = 1, #playerLoadout, 1 do
				if playerLoadout[i].label ~= nil then
					xPlayer.addWeapon(playerLoadout[i].name, playerLoadout[i].ammo)
				end
			end
		end)
	end

	cb()
end)

if Config.EarlyRespawnFine then
	ESX.RegisterServerCallback('esx_ambulancejob:checkBalance', function(source, cb)
		local xPlayer = ESX.GetPlayerFromId(source)
		local bankBalance = xPlayer.getAccount('bank').money

		cb(bankBalance >= Config.EarlyRespawnFineAmount)
	end)

	RegisterNetEvent('esx_ambulancejob:payFine')
	AddEventHandler('esx_ambulancejob:payFine', function()
		local xPlayer = ESX.GetPlayerFromId(source)
		local fineAmount = Config.EarlyRespawnFineAmount
		xPlayer.showNotification(_U('respawn_bleedout_fine_msg', ESX.Math.GroupDigits(fineAmount)))
		xPlayer.removeAccountMoney('bank', fineAmount)
	end)
end

ESX.RegisterServerCallback('esx_ambulancejob:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local quantity = xPlayer.getInventoryItem(item).count

	cb(quantity)
end)

ESX.RegisterServerCallback('esx_ambulancejob:buyJobVehicle', function(source, cb, vehicleProps, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = getPriceFromHash(vehicleProps.model, xPlayer.job.grade_name, type)

	-- vehicle model not found
	if price == 0 then
		cb(false)
	else
		if xPlayer.getMoney() >= price then
			xPlayer.removeMoney(price)

			MySQL.Async.execute('INSERT INTO owned_vehicles (owner, vehicle, plate, type, job, `stored`) VALUES (@owner, @vehicle, @plate, @type, @job, @stored)', {
				['@owner'] = xPlayer.identifier,
				['@vehicle'] = json.encode(vehicleProps),
				['@plate'] = vehicleProps.plate,
				['@type'] = type,
				['@job'] = xPlayer.job.name,
				['@stored'] = true
			}, function(rowsChanged)
				cb(true)
			end)
		else
			cb(false)
		end
	end
end)

ESX.RegisterServerCallback('esx_ambulancejob:storeNearbyVehicle', function(source, cb, nearbyVehicles)
	local xPlayer = ESX.GetPlayerFromId(source)
	local foundPlate, foundNum

	for k, v in ipairs(nearbyVehicles) do
		local result = MySQL.Sync.fetchAll('SELECT plate FROM owned_vehicles WHERE owner = @owner AND plate = @plate AND job = @job', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = v.plate,
			['@job'] = xPlayer.job.name
		})

		if result[1] then
			foundPlate, foundNum = result[1].plate, k
			break
		end
	end

	if not foundPlate then
		cb(false)
	else
		MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = true WHERE owner = @owner AND plate = @plate AND job = @job', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = foundPlate,
			['@job'] = xPlayer.job.name
		}, function(rowsChanged)
			if rowsChanged == 0 then
				cb(false)
			else
				cb(true, foundNum)
			end
		end)
	end
end)

function getPriceFromHash(vehicleHash, jobGrade, type)
	local vehicles = Config.AuthorizedVehicles[type][jobGrade]

	for k, v in ipairs(vehicles) do
		if GetHashKey(v.model) == vehicleHash then
			return v.price
		end
	end

	return 0
end

RegisterNetEvent('esx_ambulancejob:removeItem')
AddEventHandler('esx_ambulancejob:removeItem', function(item)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem(item, 1)

	if item == 'bandage' then
		xPlayer.showNotification(_U('used_bandage'))
	elseif item == 'medikit' then
		xPlayer.showNotification(_U('used_medikit'))
	end
end)

RegisterNetEvent('esx_ambulancejob:giveItem')
AddEventHandler('esx_ambulancejob:giveItem', function(itemName, amount)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'ambulance' then
		print(('[esx_ambulancejob] [^2INFO^7] "%s" attempted to spawn in an item!'):format(xPlayer.identifier))
		return
	elseif (itemName ~= 'medikit' and itemName ~= 'bandage') then
		print(('[esx_ambulancejob] [^2INFO^7] "%s" attempted to spawn in an item!'):format(xPlayer.identifier))
		return
	end

	if xPlayer.canCarryItem(itemName, amount) then
		xPlayer.addInventoryItem(itemName, amount)
	else
		xPlayer.showNotification(_U('max_item'))
	end
end)



ESX.RegisterCommand('revive', 'staff_mod', function(source, xPlayer, args, showError)
	--args.playerId.triggerEvent('esx_ambulancejob:revive')
	TriggerEvent('esx_ambulancejob:revive', args.playerId)
	--PerformHttpRequest(combatlogwebhook, function(err, text, headers) end, 'POST', json.encode({ embeds = { { title = "revtest", description = "Speler **" .. GetPlayerName(source) .. "** heeft **", footer = { text = " © 𝘿𝙧𝙪𝙜𝙖𝙣𝙤𝙫#6843 " }, color = 16711680 } } }), { ['Content-Type'] = 'application/json' })
	exports['KB_Logger']:DiscordLog("https://canary.discord.com/api/webhooks/948697521495105538/QZXLRayUlZu_Lyscqrye6mTEUkdNMop5SqYVf2P-fHVkjjFrWMwNjwtNiHoPkQAFt8jy", "Admin Revice", "Speler **" .. GetPlayerName(source) .. "** heeft **", false)
end, true, { help = _U('revive_help'), validate = true, arguments = {
	{ name = 'playerId', help = 'The player id', type = 'player' }
} })


ESX.RegisterCommand('rev', 'staff_mod', function(xPlayer, args, showError)
	args.playerId.triggerEvent('esx_ambulancejob:revive')
	exports['KB_Logger']:DiscordLog("https://canary.discord.com/api/webhooks/948697521495105538/QZXLRayUlZu_Lyscqrye6mTEUkdNMop5SqYVf2P-fHVkjjFrWMwNjwtNiHoPkQAFt8jy", "Admin Revice", "Speler **" .. GetPlayerName(source) .. "** heeft **", false)
end, true, { help = _U('revive_help'), validate = true, arguments = {
	{ name = 'playerId', help = 'The player id', type = 'player' }
} })




ESX.RegisterUsableItem('medikit', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('medikit', 1)

		playersHealing[source] = true
		TriggerClientEvent('esx_ambulancejob:useItem', source, 'medikit')

		Citizen.Wait(10000)
		playersHealing[source] = nil
	end
end)

ESX.RegisterUsableItem('bandage', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('bandage', 1)

		playersHealing[source] = true
		TriggerClientEvent('esx_ambulancejob:useItem', source, 'bandage')

		Citizen.Wait(10000)
		playersHealing[source] = nil
	end
end)

ESX.RegisterServerCallback('esx_ambulancejob:getDeathStatus', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchScalar('SELECT is_dead FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(isDead)

		if isDead then
			print(('[esx_ambulancejob] [^2INFO^7] "%s" attempted combat logging'):format(xPlayer.identifier))
			PerformHttpRequest(combatlogwebhook, function(err, text, headers) end, 'POST', json.encode({ embeds = { { title = "Combatlog", description = "Speler **" .. GetPlayerName(source) .. "** heeft geprobeert te combatloggen\nSpeler ID: **" .. source .. "**\nSteamHex: **" .. GetPlayerIdentifier(source) .. "**", footer = { text = " © 𝘿𝙧𝙪𝙜𝙖𝙣𝙤𝙫#6843 " }, color = 16711680 } } }), { ['Content-Type'] = 'application/json' })
		end

		cb(isDead)
	end)
end)

RegisterNetEvent('esx_ambulancejob:setDeathStatus')
AddEventHandler('esx_ambulancejob:setDeathStatus', function(isDead)
	local xPlayer = ESX.GetPlayerFromId(source)

	if type(isDead) == 'boolean' then
		MySQL.Sync.execute('UPDATE users SET is_dead = @isDead WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier,
			['@isDead'] = isDead
		})
	end
end)

function clientbetaalzorgpas(d, h, m)
	if d == 1 then
		TriggerClientEvent('esx_ambulancejob:client:betaalzorgpas', -1)
	end
end

RegisterServerEvent('esx_ambulancejob:server:betaalzorgpas')
AddEventHandler('esx_ambulancejob:server:betaalzorgpas', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	--Speler online
	if xPlayer then
		xPlayer.removeAccountMoney('bank', 250)
		TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = 'Je hebt de zorgverzekering betaald.' })
		TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ambulance', function(account)
			account.addMoney(250)
		end)
		--Speler niet online
	else

	end
end)
TriggerEvent('cron:runAt', 12, 00, clientbetaalzorgpas)
