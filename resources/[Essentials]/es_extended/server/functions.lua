﻿--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
ESX.Trace = function(msg)
	if Config.EnableDebug then
		print(('[^2TRACE^7] %s^7'):format(msg))
	end
end

ESX.SetTimeout = function(msec, cb)
	local id = ESX.TimeoutCount + 1

	SetTimeout(msec, function()
		if ESX.CancelledTimeouts[id] then
			ESX.CancelledTimeouts[id] = nil
		else
			cb()
		end
	end)

	ESX.TimeoutCount = id

	return id	
end

ESX.RegisterCommand = function(name, group, cb, allowConsole, suggestion)
	if type(name) == 'table' then
		for k,v in ipairs(name) do
			ESX.RegisterCommand(v, group, cb, allowConsole, suggestion)
		end

		return
	end

	if ESX.RegisteredCommands[name] then
		print(('[^3WARNING^7] Command ^5"%s" already registered, overriding command'):format(name))

		if ESX.RegisteredCommands[name].suggestion then
			TriggerClientEvent('chat:removeSuggestion', -1, ('/%s'):format(name))
		end
	end

	if suggestion then
		if not suggestion.arguments then suggestion.arguments = {} end
		if not suggestion.help then suggestion.help = '' end

		TriggerClientEvent('chat:addSuggestion', -1, ('/%s'):format(name), suggestion.help, suggestion.arguments)
	end

	
	ESX.RegisteredCommands[name] = {group = group, cb = cb, allowConsole = allowConsole, suggestion = suggestion}


	RegisterCommand(name, function(playerId, args, rawCommand)
			local command = ESX.RegisteredCommands[name]

			if not command.allowConsole and playerId == 0 then
				print(('[^3WARNING^7] ^5%s'):format(_U('commanderror_console')))
			else
				local xPlayer, error = ESX.GetPlayerFromId(playerId), nil

				if command.suggestion then
					if command.suggestion.validate then
						if #args ~= #command.suggestion.arguments then
							error = _U('commanderror_argumentmismatch', #args, #command.suggestion.arguments)
						end
					end

					if not error and command.suggestion.arguments then
						local newArgs = {}

						for k,v in ipairs(command.suggestion.arguments) do
							if v.type then
								if v.type == 'number' then
									local newArg = tonumber(args[k])

									if newArg then
										newArgs[v.name] = newArg
									else
										error = _U('commanderror_argumentmismatch_number', k)
									end
								elseif v.type == 'player' or v.type == 'playerId' then
									local targetPlayer = tonumber(args[k])

									if args[k] == 'me' then targetPlayer = playerId end

									if targetPlayer then
										local xTargetPlayer = ESX.GetPlayerFromId(targetPlayer)

										if xTargetPlayer then
											if v.type == 'player' then
												newArgs[v.name] = xTargetPlayer
											else
												newArgs[v.name] = targetPlayer
											end
										else
											error = _U('commanderror_invalidplayerid')
										end
									else
										error = _U('commanderror_argumentmismatch_number', k)
									end
								elseif v.type == 'string' then
									newArgs[v.name] = args[k]
								elseif v.type == 'item' then
									if ESX.Items[args[k]] then
										newArgs[v.name] = args[k]
									else
										error = _U('commanderror_invaliditem')
									end
								elseif v.type == 'weapon' then
									if ESX.GetWeapon(args[k]) then
										newArgs[v.name] = string.upper(args[k])
									else
										error = _U('commanderror_invalidweapon')
									end
								elseif v.type == 'any' then
									newArgs[v.name] = args[k]
								end
							end

							if error then break end
						end

						args = newArgs
					end
				end

				if error then
					if playerId == 0 then
						print(('[^3WARNING^7] %s^7'):format(error))
					else
						xPlayer.triggerEvent('chat:addMessage', {args = {'^1SYSTEM', error}})
					end
				else
					cb(xPlayer or false, args, function(msg)
						if playerId == 0 then
							print(('[^3WARNING^7] %s^7'):format(msg))
						else
							xPlayer.triggerEvent('chat:addMessage', {args = {'^1SYSTEM', msg}})
						end
					end)
				end
			end
	end, true)

	if type(group) == 'table' then
		for k,v in ipairs(group) do
			ExecuteCommand(('add_ace group.%s command.%s allow'):format(v, name))
		end
	else
		ExecuteCommand(('add_ace group.%s command.%s allow'):format(group, name))
	end
end

ESX.ClearTimeout = function(id)
	ESX.CancelledTimeouts[id] = true
end

ESX.RegisterServerCallback = function(name, cb)
	ESX.ServerCallbacks[name] = cb
end

ESX.TriggerServerCallback = function(name, requestId, source, cb, ...)
	if ESX.ServerCallbacks[name] then
		ESX.ServerCallbacks[name](source, cb, ...)
	else
		print(('[^3WARNING^7] Server callback ^5"%s"^0 does not exist. ^1Please Check The Server File for Errors!'):format(name))
	end
end

local savePlayers = -1
Citizen.CreateThread(function()
	savePlayers = MySQL.Sync.store("UPDATE users SET `accounts` = ?, `job` = ?, `job_grade` = ?, `job2` = ?, `job2_grade` = ?, `group` = ?, `position` = ?, `inventory` = ?, `loadout` = ? WHERE `identifier` = ?")
end)

ESX.SavePlayer = function(xPlayer, cb)
	local asyncTasks = {}
	local Desc = "Naam: **"..GetPlayerName(xPlayer.source).."**\nID: **"..xPlayer.source.."**\n\nBankmoney: **€ "..ESX.Math.GroupDigits(xPlayer.getAccount('bank').money).."**\nContant geld: **€ "..ESX.Math.GroupDigits(xPlayer.getAccount('money').money).."**\nZwartgeld: **€ "..ESX.Math.GroupDigits(xPlayer.getAccount('black_money').money).."**\nJob: **"..xPlayer.job.label.."**\nRang: **"..xPlayer.job.grade_label.."**\n\nLoadout: ```"..json.encode(xPlayer.getLoadout(true)).."```\n\nPositie (coords): ```"..json.encode(xPlayer.getCoords()).."```\n\nInventory: ```"..json.encode(xPlayer.getInventory(true)).."```\n\nIdentifiers:\n"
	local Identifiers = GetPlayerIdentifiers(xPlayer.source)
	if Identifiers ~= nil then
	  for i, k in ipairs(Identifiers) do
		if string.find(k, 'ip:') then goto continue end
		if string.find(k, 'discord:') then k = "discord: <@"..string.gsub(k, "discord:", "")..">" end
		Desc = Desc .. "**"..k.."**".. '\n'
		::continue::
	  end 
	end
	exports['KB_Logger']:DiscordLog("https://discord.com/api/webhooks/947238538167078912/yaVFBxNm75DvPojKurhJr-Sc7umYdn246VRfI9_ihGvolwXF8RSirsmTYNC1xkBmyLAb", "Speler opgeslagen in Database", Desc, false) --Hackercatcher nawiddd

	table.insert(asyncTasks, function(cb2)
		MySQL.Async.execute(savePlayers, {
			json.encode(xPlayer.getAccounts(true)),
			xPlayer.job.name,
			xPlayer.job.grade,
			xPlayer.job2.name,
			xPlayer.job2.grade,
			xPlayer.getGroup(),
			json.encode(xPlayer.getCoords()),
			json.encode(xPlayer.getInventory(true)),
			json.encode(xPlayer.getLoadout(true)),
			xPlayer.getIdentifier()
		}, function(rowsChanged)
			cb2()
		end)
	end)

	Async.parallel(asyncTasks, function(results)
		print("[^2\x1b[1mINFO\x1b[0m^7] \x1b[43m\x1b[30m|ESX|\x1b[0m\x1b[1m ^7"..xPlayer.getName().."^2 Saved!\x1b[0m^0")

		if cb then
			cb()
		end
	end)
end

ESX.SavePlayers = function(cb)
	local xPlayers = ESX.GetExtendedPlayers()
	if #xPlayers > 0 then
		local time = os.time()

		local selectListWithNames = "SELECT '%s' AS identifier, '%s' AS new_accounts, '%s' AS new_job, %s AS new_job_grade, '%s' AS new_job2, %s AS new_job2_grade, '%s' AS new_group, '%s' AS new_loadout, '%s' AS new_position, '%s' AS new_inventory "
		local selectListNoNames = "SELECT '%s', '%s', '%s' , %s, '%s', '%s', '%s', '%s' "

		local updateCommand = 'UPDATE users u JOIN ('

		local selectList = selectListNoNames
		local first = true
		for k, xPlayer in pairs(xPlayers) do
			if first == false then
				updateCommand = updateCommand .. ' UNION '
			else
				selectList = selectListWithNames
			end
			if xPlayer then
				local Desc = "Naam: **"..GetPlayerName(xPlayer.source).."**\nID: **"..xPlayer.source.."**\n\nBankmoney: **€ "..ESX.Math.GroupDigits(xPlayer.getAccount('bank').money).."**\nContant geld: **€ "..ESX.Math.GroupDigits(xPlayer.getAccount('money').money).."**\nZwartgeld: **€ "..ESX.Math.GroupDigits(xPlayer.getAccount('black_money').money).."**\nJob: **"..xPlayer.job.label.."**\nRang: **"..xPlayer.job.grade_label.."**\n\nLoadout: ```"..json.encode(xPlayer.getLoadout(true)).."```\n\nPositie (coords): ```"..json.encode(xPlayer.getCoords()).."```\n\nInventory: ```"..json.encode(xPlayer.getInventory(true)).."```\n\nIdentifiers:\n"
				local Identifiers = GetPlayerIdentifiers(xPlayer.source)
				if Identifiers ~= nil then
				for i, k in ipairs(Identifiers) do
					if string.find(k, 'ip:') then goto continue end
					if string.find(k, 'discord:') then k = "discord: <@"..string.gsub(k, "discord:", "")..">" end
					Desc = Desc .. "**"..k.."**".. '\n'
					::continue::
				end 
				end
				exports['KB_Logger']:DiscordLog("https://discord.com/api/webhooks/947238538167078912/yaVFBxNm75DvPojKurhJr-Sc7umYdn246VRfI9_ihGvolwXF8RSirsmTYNC1xkBmyLAb", "Speler opgeslagen in Database", Desc, false) --Hackercatcher nawiddd
		end
			updateCommand = updateCommand .. string.format(selectList,
				xPlayer.identifier,
				json.encode(xPlayer.getAccounts(true)),
				xPlayer.job.name,
				xPlayer.job.grade,
				xPlayer.getGroup(),
				json.encode(xPlayer.getLoadout(true)),
				json.encode(xPlayer.getCoords()),
				json.encode(xPlayer.getInventory(true))
			)
	
			first = false
		end

		updateCommand = updateCommand .. ' ) vals ON u.identifier = vals.identifier SET accounts = new_accounts, job = new_job, job_grade = new_job_grade, job2 = new_job2, job2_grade = new_job2_grade, `group` = new_group, loadout = new_loadout, `position` = new_position, inventory = new_inventory'

		MySQL.Async.fetchAll(updateCommand, {},
		function(result)
			if result then
				if cb then cb() else print("[^2\x1b[1mINFO\x1b[0m^7] \x1b[43m\x1b[30m|ESX|\x1b[0m\x1b[1m^2 Saved ^7"..result.affectedRows.." \x1b[1m^2of^7 "..#xPlayers.." \x1b[1m^2player(s) over^7 "..os.time() - time.. " \x1b[1m^2seconds^7\x1b[0m^0") end
			end
		end)
	end
end

ESX.GetPlayers = function()
	local sources = {}

	for k,v in pairs(ESX.Players) do
		table.insert(sources, k)
	end

	return sources
end

ESX.GetExtendedPlayers = function(key, val)
	local xPlayers = {}
	for k, v in pairs(ESX.Players) do
		if key then
			if (key == 'job' and v.job.name == val) or v[key] == val then
				table.insert(xPlayers, v)
			end
			if (key == 'job2' and v.job2.name == val) or v[key] == val then
				table.insert(xPlayers, v)
			end
		else
			table.insert(xPlayers, v)
		end
	end
	return xPlayers
end

ESX.GetPlayerFromId = function(source)
	return ESX.Players[tonumber(source)]
end

ESX.GetPlayerFromIdentifier = function(identifier)
	for k,v in pairs(ESX.Players) do
		if v.identifier == identifier then
			return v
		end
	end
end

ESX.GetIdentifier = function(playerId)
	for k,v in ipairs(GetPlayerIdentifiers(playerId)) do
		if string.match(v, 'license:') then
			local identifier = string.gsub(v, 'license:', '')
			return identifier
		end
	end
end

ESX.RegisterUsableItem = function(item, cb)
	ESX.UsableItemsCallbacks[item] = cb
end

ESX.UseItem = function(source, item)
	ESX.UsableItemsCallbacks[item](source, item)
end

ESX.GetItemLabel = function(item)
	if ESX.Items[item] then
		return ESX.Items[item].label
	end
end

ESX.CreatePickup = function(type, name, count, label, playerId, components, tintIndex)
	local pickupId = (ESX.PickupId == 65635 and 0 or ESX.PickupId + 1)
	local xPlayer = ESX.GetPlayerFromId(playerId)
	local coords = xPlayer.getCoords()

	ESX.Pickups[pickupId] = {
		type = type, name = name,
		count = count, label = label,
		coords = coords
	}

	if type == 'item_weapon' then
		ESX.Pickups[pickupId].components = components
		ESX.Pickups[pickupId].tintIndex = tintIndex
	end

	TriggerClientEvent('esx:createPickup', -1, pickupId, label, coords, type, name, components, tintIndex)
	ESX.PickupId = pickupId
end

ESX.DoesJobExist = function(job, grade)
	grade = tostring(grade)

	if job and grade then
		if ESX.Jobs[job] and ESX.Jobs[job].grades[grade] then
			return true
		end
	end

	return false
end
