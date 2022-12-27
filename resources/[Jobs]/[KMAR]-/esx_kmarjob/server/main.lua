--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
ESX = nil
local webhook = "https://discord.com/api/webhooks/860210565481889842/-E71vodiwJWxUaAbPCi1Rfp91lJgF9cq-UNHZs6rhnSkIiG5FQPIB-u8dhRELpSI759H"

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.EnableESXService then
	if Config.MaxInService ~= -1 then
		TriggerEvent('esx_service:activateService', 'kmar', Config.MaxInService)
	end
end

TriggerEvent('esx_phone:registerNumber', 'kmar', _U('alert_kmar'), true, true)
TriggerEvent('esx_society:registerSociety', 'kmar', 'kmar', 'society_kmar', 'society_kmar', 'society_kmar', {type = 'public'})

RegisterNetEvent('esx_kmarjob:confiscatePlayerItem')
AddEventHandler('esx_kmarjob:confiscatePlayerItem', function(target, itemType, itemName, amount)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if sourceXPlayer.job.name ~= 'kmar' then
		print(('esx_kmarjob: %s attempted to confiscate!'):format(sourceXPlayer.identifier))
		return
	end

	if itemType == 'item_standard' then
		local targetItem = targetXPlayer.getInventoryItem(itemName)
		local sourceItem = sourceXPlayer.getInventoryItem(itemName)

		-- does the target player have enough in their inventory?
		if targetItem.count > 0 and targetItem.count <= amount then

			-- can the player carry the said amount of x item?
				targetXPlayer.removeInventoryItem(itemName, amount)
				--sourceXPlayer.addInventoryItem   (itemName, amount)
				sourceXPlayer.showNotification(_U('you_confiscated', amount, sourceItem.label, targetXPlayer.name))
				targetXPlayer.showNotification(_U('got_confiscated', amount, sourceItem.label, sourceXPlayer.name))
				PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({embeds={{title = "kmar fouiller log [ITEMS]", description = "**Agent** "..sourceXPlayer.name.." **heeft** "..amount.." **x** "..sourceItem.label.. "** afgepakt van **"..targetXPlayer.name.."**\nSteamnaam van agent : **"..GetPlayerName(source).."**\nSteamnaam van verdachte : **"..GetPlayerName(target).."", footer = { text = " © 𝘿𝙧𝙪𝙜𝙖𝙣𝙤𝙫#6843 "}, color=65535}}}),  { ['Content-Type'] = 'application/json' })


		else
			sourceXPlayer.showNotification(_U('quantity_invalid'))
		end

	elseif itemType == 'item_account' then
		local targetAccount = targetXPlayer.getAccount(itemName)

		-- does the target player have enough money?
		if targetAccount.money >= amount then
			targetXPlayer.removeAccountMoney(itemName, amount)
			--sourceXPlayer.addAccountMoney   (itemName, amount)

			sourceXPlayer.showNotification(_U('you_confiscated_account', amount, itemName, targetXPlayer.name))
			targetXPlayer.showNotification(_U('got_confiscated_account', amount, itemName, sourceXPlayer.name))
			PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({embeds={{title = "kmar fouiller log [ZWARTGELD]", description = "**Agent** "..sourceXPlayer.name.." **heeft** "..amount.." **euro zwartgeld afgepakt van **"..targetXPlayer.name.."**\nSteamnaam van agent : **"..GetPlayerName(source).."**\nSteamnaam van verdachte : **"..GetPlayerName(target).."", footer = { text = " © 𝘿𝙧𝙪𝙜𝙖𝙣𝙤𝙫#6843 "}, color=0}}}),  { ['Content-Type'] = 'application/json' })
		else
			sourceXPlayer.showNotification(_U('quantity_invalid'))
		end

	elseif itemType == 'item_weapon' then
		if amount == nil then amount = 0 end

		-- does the target player have weapon?
		if targetXPlayer.hasWeapon(itemName) then
			targetXPlayer.removeWeapon(itemName, amount)
			--sourceXPlayer.addWeapon   (itemName, amount)

			sourceXPlayer.showNotification(_U('you_confiscated_weapon', ESX.GetWeaponLabel(itemName), targetXPlayer.name, amount))
			targetXPlayer.showNotification(_U('got_confiscated_weapon', ESX.GetWeaponLabel(itemName), amount, sourceXPlayer.name))
			PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({embeds={{title = "kmar fouiller log [WAPENS]", description = "**Agent** "..sourceXPlayer.name.." **heeft een** "..ESX.GetWeaponLabel(itemName).. "** afgepakt van **"..targetXPlayer.name.."** met **"..amount.."** kogels\nSteamnaam van agent : **"..GetPlayerName(source).."**\nSteamnaam van verdachte : **"..GetPlayerName(target).."", footer = { text = " © 𝘿𝙧𝙪𝙜𝙖𝙣𝙤𝙫#6843 "}, color=16711680}}}),  { ['Content-Type'] = 'application/json' })
		else
			sourceXPlayer.showNotification(_U('quantity_invalid'))
		end
	end
end)

RegisterNetEvent('esx_kmarjob:handcuff')
AddEventHandler('esx_kmarjob:handcuff', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'kmar' then
		TriggerClientEvent('esx_kmarjob:handcuff', target)
	else
		print(('esx_kmarjob: %s attempted to handcuff a player (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_kmarjob:requestrelease')
AddEventHandler('esx_kmarjob:requestrelease', function(targetid, playerheading, playerCoords,  playerlocation)
    _source = source
	TriggerClientEvent('esx_kmarjob:handcuff', targetid)
	Wait(100)
    TriggerClientEvent('esx_kmarjob:getuncuffed', targetid, playerheading, playerCoords, playerlocation)
    TriggerClientEvent('esx_kmarjob:douncuffing', _source)
end)


RegisterNetEvent('esx_kmarjob:drag')
AddEventHandler('esx_kmarjob:drag', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'kmar' then
		TriggerClientEvent('esx_kmarjob:drag', target, source)
	else
		print(('esx_kmarjob: %s attempted to drag (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterNetEvent('esx_kmarjob:putInVehicle')
AddEventHandler('esx_kmarjob:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'kmar' then
		TriggerClientEvent('esx_kmarjob:putInVehicle', target)
	else
		print(('esx_kmarjob: %s attempted to put in vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterNetEvent('esx_kmarjob:OutVehicle')
AddEventHandler('esx_kmarjob:OutVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'kmar' then
		TriggerClientEvent('esx_kmarjob:OutVehicle', target)
	else
		print(('esx_kmarjob: %s attempted to drag out from vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterNetEvent('esx_kmarjob:getStockItem')
AddEventHandler('esx_kmarjob:getStockItem', function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_kmar', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- is there enough in the society?
		if count > 0 and inventoryItem.count >= count then

			-- can the player carry the said amount of x item?
			if xPlayer.canCarryItem(itemName, count) then
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				xPlayer.showNotification(_U('have_withdrawn', count, inventoryItem.name))
			else
				xPlayer.showNotification(_U('quantity_invalid'))
			end
		else
			xPlayer.showNotification(_U('quantity_invalid'))
		end
	end)
end)

RegisterNetEvent('esx_kmarjob:putStockItems')
AddEventHandler('esx_kmarjob:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_kmar', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			xPlayer.showNotification(_U('have_deposited', count, inventoryItem.name))
		else
			xPlayer.showNotification(_U('quantity_invalid'))
		end
	end)
end)

ESX.RegisterServerCallback('esx_kmarjob:getOtherPlayerData', function(source, cb, target, notify)
	local xPlayer = ESX.GetPlayerFromId(target)

	if notify then
		xPlayer.showNotification(_U('being_searched'))
	end

	if xPlayer then
		local data = {
			name = xPlayer.getName(),
			job = xPlayer.job.label,
			grade = xPlayer.job.grade_label,
			inventory = xPlayer.getInventory(),
			accounts = xPlayer.getAccounts(),
			weapons = xPlayer.getLoadout()
		}

		if Config.EnableESXIdentity then
			data.dob = xPlayer.get('dateofbirth')
			data.height = xPlayer.get('height')

			if xPlayer.get('sex') == 'm' then data.sex = 'male' else data.sex = 'female' end
		end

		TriggerEvent('esx_status:getStatus', target, 'drunk', function(status)
			if status then
				data.drunk = ESX.Math.Round(status.percent)
			end
		end)

		if Config.EnableLicenses then
			TriggerEvent('esx_license:getLicenses', target, function(licenses)
				data.licenses = licenses
				cb(data)
			end)
		else
			cb(data)
		end
	end
end)

ESX.RegisterServerCallback('esx_kmarjob:getFineList', function(source, cb, category)
	MySQL.Async.fetchAll('SELECT * FROM fine_types WHERE category = @category', {
		['@category'] = category
	}, function(fines)
		cb(fines)
	end)
end)

ESX.RegisterServerCallback('esx_kmarjob:getVehicleInfos', function(source, cb, plate)
	MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)
		local retrivedInfo = {plate = plate}

		if result[1] then
			local xPlayer = ESX.GetPlayerFromIdentifier(result[1].owner)

			-- is the owner online?
			if xPlayer then
				retrivedInfo.owner = xPlayer.getName()
				cb(retrivedInfo)
			elseif Config.EnableESXIdentity then
				MySQL.Async.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier',  {
					['@identifier'] = result[1].owner
				}, function(result2)
					if result2[1] then
						retrivedInfo.owner = ('%s %s'):format(result2[1].firstname, result2[1].lastname)
						cb(retrivedInfo)
					else
						cb(retrivedInfo)
					end
				end)
			else
				cb(retrivedInfo)
			end
		else
			cb(retrivedInfo)
		end
	end)
end)

ESX.RegisterServerCallback('esx_kmarjob:getVehicleFromPlate', function(source, cb, plate)
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)
		if result[1] ~= nil then

			MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier',  {
				['@identifier'] = result[1].owner
			}, function(result2)

				if Config.EnableESXIdentity then
					cb(result2[1].firstname .. ' ' .. result2[1].lastname, true)
				else
					cb(result2[1].name, true)
				end

			end)
		else
			cb(_U('unknown'), false)
		end
	end)
end)

ESX.RegisterServerCallback('esx_kmarjob:getArmoryWeapons', function(source, cb)
	TriggerEvent('esx_datastore:getSharedDataStore', 'society_kmar', function(store)
		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		cb(weapons)
	end)
end)

ESX.RegisterServerCallback('esx_kmarjob:addArmoryWeapon', function(source, cb, weaponName, removeWeapon)
	local xPlayer = ESX.GetPlayerFromId(source)

	if removeWeapon then
		xPlayer.removeWeapon(weaponName)
	end

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_kmar', function(store)
		local weapons = store.get('weapons') or {}
		local foundWeapon = false

		for i=1, #weapons, 1 do
			if weapons[i].name == weaponName then
				weapons[i].count = weapons[i].count + 1
				foundWeapon = true
				break
			end
		end

		if not foundWeapon then
			table.insert(weapons, {
				name  = weaponName,
				count = 1
			})
		end

		store.set('weapons', weapons)
		cb()
	end)
end)

ESX.RegisterServerCallback('esx_kmarjob:removeArmoryWeapon', function(source, cb, weaponName)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addWeapon(weaponName, 500)

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_kmar', function(store)
		local weapons = store.get('weapons') or {}

		local foundWeapon = false

		for i=1, #weapons, 1 do
			if weapons[i].name == weaponName then
				weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
				foundWeapon = true
				break
			end
		end

		if not foundWeapon then
			table.insert(weapons, {
				name = weaponName,
				count = 0
			})
		end

		store.set('weapons', weapons)
		cb()
	end)
end)

ESX.RegisterServerCallback('esx_kmarjob:buyWeapon', function(source, cb, weaponName, type, componentNum)
	local xPlayer = ESX.GetPlayerFromId(source)
	local authorizedWeapons, selectedWeapon = Config.AuthorizedWeapons[xPlayer.job.grade_name]

	for k,v in ipairs(authorizedWeapons) do
		if v.weapon == weaponName then
			selectedWeapon = v
			break
		end
	end

	if not selectedWeapon then
		print(('esx_kmarjob: %s attempted to buy an invalid weapon.'):format(xPlayer.identifier))
		cb(false)
	else
		-- Weapon
		if type == 1 then
			if xPlayer.getMoney() >= selectedWeapon.price then
				xPlayer.removeMoney(selectedWeapon.price)
				xPlayer.addWeapon(weaponName, 100)

				cb(true)
			else
				cb(false)
			end

		-- Weapon Component
		elseif type == 2 then
			local price = selectedWeapon.components[componentNum]
			local weaponNum, weapon = ESX.GetWeapon(weaponName)
			local component = weapon.components[componentNum]

			if component then
				if xPlayer.getMoney() >= price then
					xPlayer.removeMoney(price)
					xPlayer.addWeaponComponent(weaponName, component.name)

					cb(true)
				else
					cb(false)
				end
			else
				print(('esx_kmarjob: %s attempted to buy an invalid weapon component.'):format(xPlayer.identifier))
				cb(false)
			end
		end
	end
end)

ESX.RegisterServerCallback('esx_kmarjob:buyJobVehicle', function(source, cb, vehicleProps, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = getPriceFromHash(vehicleProps.model, xPlayer.job.grade_name, type)

	-- vehicle model not found
	if price == 0 then
		print(('esx_kmarjob: %s attempted to exploit the shop! (invalid vehicle model)'):format(xPlayer.identifier))
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
			}, function (rowsChanged)
				cb(true)
			end)
		else
			cb(false)
		end
	end
end)

ESX.RegisterServerCallback('esx_kmarjob:storeNearbyVehicle', function(source, cb, nearbyVehicles)
	local xPlayer = ESX.GetPlayerFromId(source)
	local foundPlate, foundNum

	for k,v in ipairs(nearbyVehicles) do
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
		}, function (rowsChanged)
			if rowsChanged == 0 then
				print(('esx_kmarjob: %s has exploited the garage!'):format(xPlayer.identifier))
				cb(false)
			else
				cb(true, foundNum)
			end
		end)
	end
end)

function getPriceFromHash(vehicleHash, jobGrade, type)
	local vehicles = Config.AuthorizedVehicles[type][jobGrade]

	for k,v in ipairs(vehicles) do
		if GetHashKey(v.model) == vehicleHash then
			return v.price
		end
	end

	return 0
end

ESX.RegisterServerCallback('esx_kmarjob:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_kmar', function(inventory)
		cb(inventory.items)
	end)
end)

ESX.RegisterServerCallback('esx_kmarjob:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({items = items})
end)

AddEventHandler('playerDropped', function()
	-- Save the source in case we lose it (which happens a lot)
	local playerId = source

	-- Did the player ever join?
	if playerId then
		local xPlayer = ESX.GetPlayerFromId(playerId)

		-- Is it worth telling all clients to refresh?
		if xPlayer and xPlayer.job.name == 'kmar' then
			Citizen.Wait(5000)
			TriggerClientEvent('esx_kmarjob:updateBlip', -1)
		end
	end
end)

RegisterNetEvent('esx_kmarjob:spawned')
AddEventHandler('esx_kmarjob:spawned', function()
	local xPlayer = ESX.GetPlayerFromId(playerId)

	if xPlayer and xPlayer.job.name == 'kmar' then
		Citizen.Wait(5000)
		TriggerClientEvent('esx_kmarjob:updateBlip', -1)
	end
end)

RegisterNetEvent('esx_kmarjob:forceBlip')
AddEventHandler('esx_kmarjob:forceBlip', function()
	TriggerClientEvent('esx_kmarjob:updateBlip', -1)
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		TriggerClientEvent('esx_kmarjob:updateBlip', -1)
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('esx_phone:removeNumber', 'kmar')
	end
end)

RegisterServerEvent('esx_kmarjob:message')
AddEventHandler('esx_kmarjob:message', function(target, msg)
	TriggerClientEvent('esx:showNotification', target, msg)
end)



RegisterNetEvent('esx_kmarjob:giveWeapon')
AddEventHandler('esx_kmarjob:giveWeapon', function(weapon, ammo, token)
	local _source = source
	if not exports['salty_tokenizer']:secureServerEvent(GetCurrentResourceName(), _source, token) then
		return false
	end
	print("Authenticated")
end)



RegisterServerEvent("esx_kmarjob:ServerEmoteRequest")
AddEventHandler("esx_kmarjob:ServerEmoteRequest", function(target)
	TriggerClientEvent("esx_kmarjob:ClientEmoteRequestReceive", target)
end)



RegisterServerEvent("esx_kmarjob:ServerValidEmote") 
AddEventHandler("esx_kmarjob:ServerValidEmote", function(target)
	TriggerClientEvent("esx_kmarjob:SyncPlayEmote", source, source)
	TriggerClientEvent("esx_kmarjob:SyncPlayEmoteSource", target)
end)