local giveweaponwebhook = 'https://discord.com/api/webhooks/947234213592170677/gQQfKF-NAz9W7LLJOf8HTJlUQNUpHJjR8mlqjPWl5af0PKMz6gXDNDyhrY65LiF53NtR'
local giveitemlog = 'https://discord.com/api/webhooks/935306265985445969/oQqf2cVQTl7utXjcjm1uLwztJ0GoL3UHhbsVAGfNoOu9r8WYI_2t58rOVmZUMSa6ioYX'
local givemoneylog = 'https://discord.com/api/webhooks/947234395738222642/nXYx4PM2cOZ_XJrNqwlpTfCK18A4VftaKaeA8Rvd6Iuf8EWIoDhFOTe2Phno6JIhpYS2'
local dropitemlog = 'https://discord.com/api/webhooks/935306384453533726/tjNPjkQU7MqetltH6Sg7WrFClm8X8YJDxVQPX6CXosdZOn4L8DRqNGKxgrt6e1Tuhxfh'
local dropmoneylog = 'https://discord.com/api/webhooks/947234713553223781/a2LMJtm0BggXVYOUT9GMKtL3nCEsV6dYi6TyloMqoQDibxfHcxTDddSliSCHXvfGonMQ'
local dropweaponlog = 'https://discord.com/api/webhooks/947234796185190451/Az59uUSiub8Ic45bfbYldFpsdtKGm61kHN3wTzRl_p0cu1wUlHAATYyqBoiIve0d3t5c'

local anwbOnline = 0





local NewPlayer, LoadPlayer = -1, -1
Citizen.CreateThread(function()
	SetMapName('Kronenburg')
	SetGameType('Roleplay')
	
	local query = '`accounts`, `job`, `job_grade`, `job2`, `job2_grade`, `group`, `position`, `inventory`, `skin`, `loadout`' -- Select these fields from the database
	if Config.Multichar or Config.Identity then	-- append these fields to the select query
		query = query..', `firstname`, `lastname`, `dateofbirth`, `sex`, `height`'
	end

	if Config.Multichar then -- insert identity data with creation
		MySQL.Async.store("INSERT INTO `users` SET `accounts` = ?, `identifier` = ?, `group` = ?, `firstname` = ?, `lastname` = ?, `dateofbirth` = ?, `sex` = ?, `height` = ?", function(storeId)
			NewPlayer = storeId
		end)
	else
		MySQL.Async.store("INSERT INTO `users` SET `accounts` = ?, `identifier` = ?, `group` = ?", function(storeId)
			NewPlayer = storeId
		end)
	end

	MySQL.Async.store("SELECT "..query.." FROM `users` WHERE identifier = ?", function(storeId)
		LoadPlayer = storeId
	end)
end)

if Config.Multichar then
	AddEventHandler('esx:onPlayerJoined', function(src, char, data)
		if not ESX.Players[src] then
			local identifier = char..':'..ESX.GetIdentifier(src)
			if data then
				createESXPlayer(identifier, src, data)
			else
				loadESXPlayer(identifier, src, false)
			end
		end
	end)
else
	RegisterNetEvent('esx:onPlayerJoined')
	AddEventHandler('esx:onPlayerJoined', function()
		if not ESX.Players[source] then
			onPlayerJoined(source)
		end
	end)
end

function onPlayerJoined(playerId)
	local identifier = ESX.GetIdentifier(playerId)
	if identifier then
		if ESX.GetPlayerFromIdentifier(identifier) then
			DropPlayer(playerId, ('there was an error loading your character!\nError code: identifier-active-ingame\n\nThis error is caused by a player on this server who has the same identifier as you have. Make sure you are not playing on the same Rockstar account.\n\nYour Rockstar identifier: %s'):format(identifier))
		else
			MySQL.Async.fetchScalar('SELECT 1 FROM users WHERE identifier = @identifier', {
				['@identifier'] = identifier
			}, function(result)
				if result then
					loadESXPlayer(identifier, playerId, false)
				else createESXPlayer(identifier, playerId) end
			end)
		end
	else
		DropPlayer(playerId, 'there was an error loading your character!\nError code: identifier-missing-ingame\n\nThe cause of this error is not known, your identifier could not be found. Please come back later or report this problem to the server administration team.')
	end
end

function createESXPlayer(identifier, playerId, data)
	local accounts = {}

	for account,money in pairs(Config.StartingAccountMoney) do
		accounts[account] = money
	end

	if IsPlayerAceAllowed(playerId, "command") then
		defaultGroup = "admin"
	else
		defaultGroup = "user"
	end

	if not Config.Multichar then
		MySQL.Async.execute(NewPlayer, {
				json.encode(accounts),
				identifier,
				defaultGroup,
		}, function(rowsChanged)
			loadESXPlayer(identifier, playerId, true)
		end)
	else
		MySQL.Async.execute(NewPlayer, {
				json.encode(accounts),
				identifier,
				defaultGroup,
				data.firstname,
				data.lastname,
				data.dateofbirth,
				data.sex,
				data.height,
		}, function(rowsChanged)
			loadESXPlayer(identifier, playerId, true)
		end)
	end
end

AddEventHandler('playerConnecting', function(name, setCallback, deferrals)
	deferrals.defer()
	local playerId = source
	local identifier = ESX.GetIdentifier(playerId)
	Citizen.Wait(100)

--[[ 	for k, v in ipairs(GetPlayerIdentifiers(source)) do
		if string.match(v, "steam:") then
			local steam = v
			if steam = "" then
				DropPlayer(source, "Je hebt geen Steam open staan of niet verbonden met FiveM.")
			end
			break
		end
	end

	for k, v in ipairs(GetPlayerIdentifiers(source)) do
		if string.match(v, "discord:") then
			local discord = v
			if discord = "" then
				DropPlayer(source, "Je hebt geen Discord open staan of niet verbonden met FiveM.")
			end
			break
		end
	end ]]

	if identifier then
		if ESX.GetPlayerFromIdentifier(identifier) then
			deferrals.done(('There was an error loading your character!\nError code: identifier-active\n\nThis error is caused by a player on this server who has the same identifier as you have. Make sure you are not playing on the same account.\n\nYour identifier: %s'):format(identifier))
		else
			deferrals.done()
		end
	else
		deferrals.done('There was an error loading your character!\nError code: identifier-missing\n\nThe cause of this error is not known, your identifier could not be found. Please come back later or report this problem to the server administration team.')
	end
end)

function loadESXPlayer(identifier, playerId, isNew)
	local tasks = {}

	local userData = {
		accounts = {},
		inventory = {},
		job = {},
		job2 = {},
		loadout = {},
		playerName = GetPlayerName(playerId),
		weight = 0
	}

	table.insert(tasks, function(cb)
		MySQL.Async.fetchAll(LoadPlayer, { identifier
		}, function(result)
			local job, grade, jobObject, gradeObject = result[1].job, tostring(result[1].job_grade)
			local job2, grade2 = result[1].job2, tostring(result[1].job2_grade)
			local job2Object, gradeObject2 = ESX.Jobs[job2], ESX.Jobs[job2].grades[grade]
			local foundAccounts, foundItems = {}, {}

			-- Accounts
			if result[1].accounts and result[1].accounts ~= '' then
				local accounts = json.decode(result[1].accounts)

				for account,money in pairs(accounts) do
					foundAccounts[account] = money
				end
			end

			for account,label in pairs(Config.Accounts) do
				table.insert(userData.accounts, {
					name = account,
					money = foundAccounts[account] or Config.StartingAccountMoney[account] or 0,
					label = label
				})
			end

			-- Job
			if ESX.DoesJobExist(job, grade) then
				jobObject, gradeObject = ESX.Jobs[job], ESX.Jobs[job].grades[grade]
			else
				job, grade = 'unemployed', '0'
				jobObject, gradeObject = ESX.Jobs[job], ESX.Jobs[job].grades[grade]
			end

			userData.job.id = jobObject.id
			userData.job.name = jobObject.name
			userData.job.label = jobObject.label

			userData.job.grade = tonumber(grade)
			userData.job.grade_name = gradeObject.name
			userData.job.grade_label = gradeObject.label
			userData.job.grade_salary = gradeObject.salary

			userData.job.skin_male = {}
			userData.job.skin_female = {}

			--[[ Job 2 ]]
			if ESX.DoesJobExist(job2, grade2) then
				jobObject2, gradeObject2 = ESX.Jobs[job2], ESX.Jobs[job2].grades[grade2]
			else
				job2, grade2 = 'unemployed2', '0'
				job2Object, gradeObject2 = ESX.Jobs[job2], ESX.Jobs[job2].grades[grade2]
			end

			userData.job2.id = job2Object.id
			userData.job2.name = job2Object.name
			userData.job2.label = job2Object.label

			userData.job2.grade = tonumber(grade2)
			userData.job2.grade_name = gradeObject2.name
			userData.job2.grade_label = gradeObject2.label
			userData.job2.grade_salary = gradeObject2.salary

			userData.job2.skin_male = {}
			userData.job2.skin_female = {}

			if gradeObject.skin_male then userData.job.skin_male = json.decode(gradeObject.skin_male) end
			if gradeObject.skin_female then userData.job.skin_female = json.decode(gradeObject.skin_female) end

			-- Inventory
			if result[1].inventory and result[1].inventory ~= '' then
				local inventory = json.decode(result[1].inventory)

				for name,count in pairs(inventory) do
					local item = ESX.Items[name]

					if item then
						foundItems[name] = count
					end
				end
			end

			for name,item in pairs(ESX.Items) do
				local count = foundItems[name] or 0
				if count > 0 then userData.weight = userData.weight + (item.weight * count) end

				table.insert(userData.inventory, {
					name = name,
					count = count,
					label = item.label,
					weight = item.weight,
					usable = ESX.UsableItemsCallbacks[name] ~= nil,
					rare = item.rare,
					canRemove = item.canRemove
				})
			end

			table.sort(userData.inventory, function(a, b)
				return a.label < b.label
			end)

			-- Group
			if result[1].group then
				if result[1].group == "admin" then
					userData.group = "admin"
				else
					userData.group = result[1].group
				end
			else
				userData.group = 'user'
			end

			-- Loadout
			if result[1].loadout and result[1].loadout ~= '' then
				local loadout = json.decode(result[1].loadout)

				for name,weapon in pairs(loadout) do
					local label = ESX.GetWeaponLabel(name)

					if label then
						if not weapon.components then weapon.components = {} end
						if not weapon.tintIndex then weapon.tintIndex = 0 end

						table.insert(userData.loadout, {
							name = name,
							ammo = weapon.ammo,
							label = label,
							components = weapon.components,
							tintIndex = weapon.tintIndex
						})
					end
				end
			end

			-- Position
			if result[1].position and result[1].position ~= '' then
				userData.coords = json.decode(result[1].position)
			else
				userData.coords = {x = -269.4, y = -955.3, z = 31.2, heading = 205.8}
			end

			-- Skin
			if result[1].skin and result[1].skin ~= '' then
				userData.skin = json.decode(result[1].skin)
			else
				if userData.sex == 'f' then userData.skin = {sex=1} else userData.skin = {sex=0} end
			end

			-- Identity
			if result[1].firstname and result[1].firstname ~= '' then
				userData.firstname = result[1].firstname
				userData.lastname = result[1].lastname
				userData.playerName = userData.firstname..' '..userData.lastname
				if result[1].dateofbirth then userData.dateofbirth = result[1].dateofbirth end
				if result[1].sex then userData.sex = result[1].sex end
				if result[1].height then userData.height = result[1].height end
			end

			cb()
		end)
	end)

	Async.parallel(tasks, function(results)
		local xPlayer = CreateExtendedPlayer(playerId, identifier, userData.group, userData.accounts, userData.inventory, userData.weight, userData.job, userData.job2, userData.loadout, userData.playerName, userData.coords)
		ESX.Players[playerId] = xPlayer

		if userData.firstname then 
			xPlayer.set('firstName', userData.firstname)
			xPlayer.set('lastName', userData.lastname)
			if userData.dateofbirth then xPlayer.set('dateofbirth', userData.dateofbirth) end
			if userData.sex then xPlayer.set('sex', userData.sex) end
			if userData.height then xPlayer.set('height', userData.height) end
		end

		TriggerEvent('esx:playerLoaded', playerId, xPlayer, isNew)

		xPlayer.triggerEvent('esx:playerLoaded', {
			accounts = xPlayer.getAccounts(),
			coords = xPlayer.getCoords(),
			identifier = xPlayer.getIdentifier(),
			inventory = xPlayer.getInventory(),
			job = xPlayer.getJob(),
			job2 = xPlayer.getJob2(),
			loadout = xPlayer.getLoadout(),
			maxWeight = xPlayer.getMaxWeight(),
			money = xPlayer.getMoney(),
			dead = false
		}, isNew, userData.skin)

		xPlayer.triggerEvent('esx:createMissingPickups', ESX.Pickups)
		xPlayer.triggerEvent('esx:registerSuggestions', ESX.RegisteredCommands)
	end)
end

AddEventHandler('chatMessage', function(playerId, author, message)
	if message:sub(1, 1) == '/' and playerId > 0 then
		CancelEvent()
		local commandName = message:sub(1):gmatch("%w+")()
		TriggerClientEvent('chat:addMessage', playerId, {args = {'^1SYSTEM', _U('commanderror_invalidcommand', commandName)}})
	end
end)

AddEventHandler('playerDropped', function(reason)
	local playerId = source
	local xPlayer = ESX.GetPlayerFromId(playerId)

	if xPlayer then
		TriggerEvent('esx:playerDropped', playerId, reason)

		ESX.SavePlayer(xPlayer, function()
			ESX.Players[playerId] = nil
		end)
	end
end)

if Config.Multichar then
	AddEventHandler('esx:playerLogout', function(playerId)
		local xPlayer = ESX.GetPlayerFromId(playerId)
		if xPlayer then
			TriggerEvent('esx:playerDropped', playerId, reason)

			ESX.SavePlayer(xPlayer, function()
				ESX.Players[playerId] = nil
			end)
		end
		TriggerClientEvent("esx:onPlayerLogout", playerId)
	end)
end

RegisterNetEvent('esx:updateCoords')
AddEventHandler('esx:updateCoords', function(coords)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer then
		xPlayer.updateCoords(coords)
	end
end)

RegisterNetEvent('esx:updateWeaponAmmo')
AddEventHandler('esx:updateWeaponAmmo', function(weaponName, ammoCount)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer then
		xPlayer.updateWeaponAmmo(weaponName, ammoCount)
	end
end)

RegisterNetEvent('esx:giveInventoryItem')
AddEventHandler('esx:giveInventoryItem', function(target, type, itemName, itemCount)
	local playerId = source
	local sourceXPlayer = ESX.GetPlayerFromId(playerId)
	local targetXPlayer = ESX.GetPlayerFromId(target)


	if type == 'item_standard' then
		local sourceItem = sourceXPlayer.getInventoryItem(itemName)

		if itemCount > 0 and sourceItem.count >= itemCount then
			if targetXPlayer.canCarryItem(itemName, itemCount) then
				sourceXPlayer.removeInventoryItem(itemName, itemCount)
				targetXPlayer.addInventoryItem   (itemName, itemCount)

				sourceXPlayer.showNotification(_U('gave_item', itemCount, sourceItem.label, targetXPlayer.source))
				targetXPlayer.showNotification(_U('received_item', itemCount, sourceItem.label, sourceXPlayer.source))
				
				exports['KB_Logger']:DiscordLog(giveitemlog, "Geef log", "Item:** "..itemCount.." x "..sourceItem.label.."**\nGever naam:** "..GetPlayerName(playerId).."**\nGever ID:** "..playerId.."**\nGever Steamhex:** ".. GetPlayerIdentifier(playerId) .."**\n\nOntvanger naam:** "..GetPlayerName(target).."\n**Ontvanger ID:** "..target.."\n**Ontvanger Steamhex:** ".. GetPlayerIdentifier(target) .."**", false)

			
			else
				sourceXPlayer.showNotification(_U('ex_inv_lim', targetXPlayer.source))
			end
		else
			sourceXPlayer.showNotification(_U('imp_invalid_quantity'))
		end
	elseif type == 'item_account' then
		if itemCount > 0 and sourceXPlayer.getAccount(itemName).money >= itemCount then
			sourceXPlayer.removeAccountMoney(itemName, itemCount)
			targetXPlayer.addAccountMoney   (itemName, itemCount)

			sourceXPlayer.showNotification(_U('gave_account_money', ESX.Math.GroupDigits(itemCount), Config.Accounts[itemName], targetXPlayer.source))
			targetXPlayer.showNotification(_U('received_account_money', ESX.Math.GroupDigits(itemCount), Config.Accounts[itemName], sourceXPlayer.source))
		
			exports['KB_Logger']:DiscordLog(givemoneylog, "Geef log", "Geld:** "..ESX.Math.GroupDigits(itemCount).." "..itemName.."**\nGever naam:** "..GetPlayerName(playerId).."**\nGever ID:** "..playerId.."**\nGever Steamhex:** ".. GetPlayerIdentifier(playerId) .."**\n\nOntvanger naam:** "..GetPlayerName(target).."\n**Ontvanger ID:** "..target.."\n**Ontvanger Steamhex:** ".. GetPlayerIdentifier(target) .."**", false)

		else
			sourceXPlayer.showNotification(_U('imp_invalid_amount'))
		end
	elseif type == 'item_weapon' then
		if sourceXPlayer.hasWeapon(itemName) then
			local weaponLabel = ESX.GetWeaponLabel(itemName)

			if not targetXPlayer.hasWeapon(itemName) then
				local _, weapon = sourceXPlayer.getWeapon(itemName)
				local _, weaponObject = ESX.GetWeapon(itemName)
				itemCount = weapon.ammo

				sourceXPlayer.removeWeapon(itemName)
				targetXPlayer.addWeapon(itemName, itemCount)

				if weaponObject.ammo and itemCount > 0 then
					local ammoLabel = weaponObject.ammo.label
					sourceXPlayer.showNotification(_U('gave_weapon_withammo', weaponLabel, itemCount, ammoLabel, targetXPlayer.source))
					targetXPlayer.showNotification(_U('received_weapon_withammo', weaponLabel, itemCount, ammoLabel, sourceXPlayer.source))
					exports['KB_Logger']:DiscordLog(giveweaponwebhook, "Wapen geef log", "Wapen:** "..weaponLabel.." ["..itemCount.."]**\nGever naam:** "..GetPlayerName(playerId).."**\nGever ID:** "..playerId.."**\nGever Steamhex:** ".. GetPlayerIdentifier(playerId) .."**\n\nOntvanger naam:** "..GetPlayerName(target).."\n**Ontvanger ID:** "..target.."\n**Ontvanger Steamhex:** ".. GetPlayerIdentifier(target) .."**", false)

				else
					sourceXPlayer.showNotification(_U('gave_weapon', weaponLabel, targetXPlayer.source))
					targetXPlayer.showNotification(_U('received_weapon', weaponLabel, sourceXPlayer.source))
					exports['KB_Logger']:DiscordLog(giveweaponwebhook, "Wapen geef log", "Wapen:** "..weaponLabel.." [Zonder Minutie]**\nGever naam:** "..GetPlayerName(playerId).."**\nGever ID:** "..playerId.."**\nGever Steamhex:** ".. GetPlayerIdentifier(playerId) .."**\n\nOntvanger naam:** "..GetPlayerName(target).."\n**Ontvanger ID:** "..target.."\n**Ontvanger Steamhex:** ".. GetPlayerIdentifier(target) .."**", false)

				end
			else
				sourceXPlayer.showNotification(_U('gave_weapon_hasalready', targetXPlayer.source, weaponLabel))
				targetXPlayer.showNotification(_U('received_weapon_hasalready', sourceXPlayer.source, weaponLabel))
			end
		end
	elseif type == 'item_ammo' then
		if sourceXPlayer.hasWeapon(itemName) then
			local weaponNum, weapon = sourceXPlayer.getWeapon(itemName)

			if targetXPlayer.hasWeapon(itemName) then
				local _, weaponObject = ESX.GetWeapon(itemName)

				if weaponObject.ammo then
					local ammoLabel = weaponObject.ammo.label

					if weapon.ammo >= itemCount then
						sourceXPlayer.removeWeaponAmmo(itemName, itemCount)
						targetXPlayer.addWeaponAmmo(itemName, itemCount)

						sourceXPlayer.showNotification(_U('gave_weapon_ammo', itemCount, ammoLabel, weapon.label, targetXPlayer.source))
						targetXPlayer.showNotification(_U('received_weapon_ammo', itemCount, ammoLabel, weapon.label, sourceXPlayer.source))
					end
				end
			else
				sourceXPlayer.showNotification(_U('gave_weapon_noweapon', targetXPlayer.source))
				targetXPlayer.showNotification(_U('received_weapon_noweapon', sourceXPlayer.source, weapon.label))
			end
		end
	end
	ESX.SavePlayer(sourceXPlayer, function() end);
	ESX.SavePlayer(targetXPlayer, function() end);
end)

RegisterNetEvent('esx:removeInventoryItem')
AddEventHandler('esx:removeInventoryItem', function(type, itemName, itemCount)
	local playerId = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if type == 'item_standard' then
		if itemCount == nil or itemCount < 1 then
			xPlayer.showNotification(_U('imp_invalid_quantity'))
		else
			local xItem = xPlayer.getInventoryItem(itemName)

			if (itemCount > xItem.count or xItem.count < 1) then
				xPlayer.showNotification(_U('imp_invalid_quantity'))
			else
				xPlayer.removeInventoryItem(itemName, itemCount)
				-- local pickupLabel = ('~y~%s~s~ [~b~%s~s~]'):format(xItem.label, itemCount)
				-- ESX.CreatePickup('item_standard', itemName, itemCount, pickupLabel, playerId)
				xPlayer.showNotification(_U('threw_standard', itemCount, xItem.label))
				local text = "Gooit " .. itemCount .. "  " ..xItem.label.. " weg"
				TriggerClientEvent('3dme:shareDisplay', -1, text, source)
				exports['KB_Logger']:DiscordLog(dropitemlog, "Weggooi logs", "Item:** "..itemCount.."  x "..xItem.label.."**\nSpeler naam:** "..GetPlayerName(playerId).."**\nSpeler ID:** "..playerId.."**\nSpeler Steamhex:** ".. GetPlayerIdentifier(playerId) .."**", false)

			end
		end
	elseif type == 'item_account' then
		if itemCount == nil or itemCount < 1 then
			xPlayer.showNotification(_U('imp_invalid_amount'))
		else
			local account = xPlayer.getAccount(itemName)

			if (itemCount > account.money or account.money < 1) then
				xPlayer.showNotification(_U('imp_invalid_amount'))
			else
				xPlayer.removeAccountMoney(itemName, itemCount)
				-- local pickupLabel = ('~y~%s~s~ [~g~%s~s~]'):format(account.label, _U('locale_currency', ESX.Math.GroupDigits(itemCount)))
				-- ESX.CreatePickup('item_account', itemName, itemCount, pickupLabel, playerId)
				xPlayer.showNotification(_U('threw_account', ESX.Math.GroupDigits(itemCount), string.lower(account.label)))
				exports['KB_Logger']:DiscordLog(dropmoneylog, "Weggooi logs", "Geld:** "..ESX.Math.GroupDigits(itemCount).." "..itemName.."**\nSpeler naam:** "..GetPlayerName(playerId).."**\nSpeler ID:** "..playerId.."**\nSpeler Steamhex:** ".. GetPlayerIdentifier(playerId) .."**", false)

			end
		end
	elseif type == 'item_weapon' then
		itemName = string.upper(itemName)

		if xPlayer.hasWeapon(itemName) then
			local _, weapon = xPlayer.getWeapon(itemName)
			local _, weaponObject = ESX.GetWeapon(itemName)
			local components, pickupLabel = ESX.Table.Clone(weapon.components)
			xPlayer.removeWeapon(itemName)

			if weaponObject.ammo and weapon.ammo > 0 then
				local ammoLabel = weaponObject.ammo.label
				-- pickupLabel = ('~y~%s~s~ [~g~%s~s~ %s]'):format(weapon.label, weapon.ammo, ammoLabel)
				xPlayer.showNotification(_U('threw_weapon_ammo', weapon.label, weapon.ammo, ammoLabel))
				exports['KB_Logger']:DiscordLog(dropweaponlog, "Weggooi logs", "Wapen:** "..weapon.label.." ["..weapon.ammo.."]**\nSpeler naam:** "..GetPlayerName(source).."**\nSpeler ID:** "..source.."**\nSpeler Steamhex:** ".. GetPlayerIdentifier(source) .."**", false)

			else
				-- pickupLabel = ('~y~%s~s~'):format(weapon.label)
				xPlayer.showNotification(_U('threw_weapon', weapon.label))
				exports['KB_Logger']:DiscordLog(dropweaponlog, "Weggooi logs", "Wapen:** "..weapon.label.." [Zonder minutie]**\nSpeler naam:** "..GetPlayerName(source).."**\nSpeler ID:** "..source.."**\nSpeler Steamhex:** ".. GetPlayerIdentifier(source) .."**", false)
			end
		end
	end
end)

Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(10000)

		local xPlayers = ESX.GetExtendedPlayers("job", "anwb")
		for _, xPlayer in pairs(xPlayers) do
			anwbOnline = anwbOnline + 1
		end
	end
end)

RegisterNetEvent('esx:useItem')
AddEventHandler('esx:useItem', function(itemName)
	local xPlayer = ESX.GetPlayerFromId(source)
	local count = xPlayer.getInventoryItem(itemName).count

	exports['KB_Logger']:DiscordLog("https://discord.com/api/webhooks/942066975620870164/_IJvWzTg406CxBTN0vm2LROcffrKRQkIXJOgvERrNWvzLVwCtbKO_lgEWrzH53z8nSgv", "Speler naam:** "..GetPlayerName(source).."**\nSpeler ID:** "..source.."**\nSpeler Steamhex:** ".. GetPlayerIdentifier(source) .."**\n**Item:** "..itemName, false)
	if count > 0 then
		if (itemName == "repairkit") then
			if (anwbOnline >= 2) then
				if (xPlayer.job.name == "police") then
					xPlayer.showNotification("~r~Je kan geen repairkit gebruiken met meer dan 2 ANWB online.")
				else
					ESX.UseItem(source, itemName)
				end
			else
				ESX.UseItem(source, itemName)
			end
		else
			ESX.UseItem(source, itemName)
		end
	else
		xPlayer.showNotification(_U('act_imp'))
	end
end)

RegisterNetEvent('esx:onPickup')
AddEventHandler('esx:onPickup', function(pickupId)
	local pickup, xPlayer, success = ESX.Pickups[pickupId], ESX.GetPlayerFromId(source)

	exports['KB_Logger']:DiscordLog("https://discord.com/api/webhooks/942067478882816061/aVj0OGLbINDmvPhxzh6eqqlprIQ3uaRzGXnAfdfwDmyjjgPpooOw4dSMp9LU0n80asQh", "Speler naam:** "..GetPlayerName(playerId).."**\nSpeler ID:** "..playerId.."**\nSpeler Steamhex:** ".. GetPlayerIdentifier(playerId) .."**\n**Item:** "..pickup, false)

	if pickup then
		if pickup.type == 'item_standard' then
			if xPlayer.canCarryItem(pickup.name, pickup.count) then
				xPlayer.addInventoryItem(pickup.name, pickup.count)
				success = true
			else
				xPlayer.showNotification(_U('threw_cannot_pickup'))
			end
		elseif pickup.type == 'item_account' then
			success = true
			xPlayer.addAccountMoney(pickup.name, pickup.count)
		elseif pickup.type == 'item_weapon' then
			if xPlayer.hasWeapon(pickup.name) then
				xPlayer.showNotification(_U('threw_weapon_already'))
			else
				success = true
				xPlayer.addWeapon(pickup.name, pickup.count)
				xPlayer.setWeaponTint(pickup.name, pickup.tintIndex)

				for k,v in ipairs(pickup.components) do
					xPlayer.addWeaponComponent(pickup.name, v)
				end
			end
		end

		if success then
			ESX.Pickups[pickupId] = nil
			TriggerClientEvent('esx:removePickup', -1, pickupId)
		end
	end
end)

ESX.RegisterServerCallback('esx:getPlayerData', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	cb({
		identifier   = xPlayer.identifier,
		accounts     = xPlayer.getAccounts(),
		inventory    = xPlayer.getInventory(),
		job          = xPlayer.getJob(),
		job2         = xPlayer.getJob2(),
		loadout      = xPlayer.getLoadout(),
		money        = xPlayer.getMoney()
	})
end)

ESX.RegisterServerCallback('esx:getOtherPlayerData', function(source, cb, target)
	local xPlayer = ESX.GetPlayerFromId(target)

	cb({
		identifier   = xPlayer.identifier,
		accounts     = xPlayer.getAccounts(),
		inventory    = xPlayer.getInventory(),
		job          = xPlayer.getJob(),
		job2         = xPlayer.getJob2(),
		loadout      = xPlayer.getLoadout(),
		money        = xPlayer.getMoney()
	})
end)

ESX.RegisterServerCallback('esx:getPlayerNames', function(source, cb, players)
	players[source] = nil

	for playerId,v in pairs(players) do
		local xPlayer = ESX.GetPlayerFromId(playerId)

		if xPlayer then
			players[playerId] = xPlayer.getName()
		else
			players[playerId] = nil
		end
	end

	cb(players)
end)

AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
	if eventData.secondsRemaining == 60 then
		Citizen.CreateThread(function()
			Citizen.Wait(59000)
			ESX.SavePlayers()
		end)
	end
end)
