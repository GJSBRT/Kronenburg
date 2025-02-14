﻿--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
ESX = {}
ESX.Players = {}
ESX.UsableItemsCallbacks = {}
ESX.Items = {}
ESX.ServerCallbacks = {}
ESX.TimeoutCount = -1
ESX.CancelledTimeouts = {}
ESX.Pickups = {}
ESX.PickupId = 0
ESX.Jobs = {}
ESX.RegisteredCommands = {}

AddEventHandler('esx:getSharedObject', function(cb)
	cb(ESX)
end)

function getSharedObject()
	return ESX
end

local function StartDBSync()
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(10 * 60 * 1000)
			ESX.SavePlayers()
		end
	end)
end

MySQL.ready(function()
	MySQL.Async.fetchAll('SELECT * FROM items', {}, function(result)
		for k,v in ipairs(result) do
			ESX.Items[v.name] = {
				label = v.label,
				weight = v.weight,
				rare = v.rare,
				canRemove = v.can_remove
			}
		end
	end)

	local Jobs = {}
	MySQL.Async.fetchAll('SELECT * FROM jobs', {}, function(jobs)
		for k,v in ipairs(jobs) do
			Jobs[v.name] = v
			Jobs[v.name].grades = {}
		end

		MySQL.Async.fetchAll('SELECT * FROM job_grades', {}, function(jobGrades)
			for k,v in ipairs(jobGrades) do
				if Jobs[v.job_name] then
					Jobs[v.job_name].grades[tostring(v.grade)] = v
				end
			end

			for k2,v2 in pairs(Jobs) do
				if ESX.Table.SizeOf(v2.grades) == 0 then
					Jobs[v2.name] = nil
				end
			end
			ESX.Jobs = Jobs
			print(" ")
			print("^3            #                                                                                                           ")
			print("^3           ###               @@   @@@                                                @@                                 ")
			print("^3 %%%#     #####/     ###     @@ @@@                                                  @@                                 ")
			print("^3  %%%%%%.######, ######*     @@@@.     @@@@@@ %@@@@@@   @@@@@@@   @@@@@@@  @@@@@@@,  @@@@@@@@  @@@   @@  @@@@@@ %@@@@@@@")
			print("^3   %%%. #### (#########      @@@@@,    @@.    @@    @@  @@   @@  @@@@@@@@. @@   .@@  @@    @@@ @@@   @@  @@&    @@    @@")
			print("^3    % ##. ############       @@  #@@&  @@.    @@@@@@@#  @@   @@  ,@@# %@@  @@   .@@  @@@@#@@@  #@@@@@@@  @@     @@@@&@@@")
			print("^3      ##############                                                                                             .    @@")
			print("^3                                                                                                                 @@@@@@ ")
			print(" ")
			StartDBSync()
			StartPayCheck()
		end)
	end)
end)

RegisterServerEvent('esx:clientLog')
AddEventHandler('esx:clientLog', function(msg)
	if Config.EnableDebug then
		print(('[^2TRACE^7] %s^7'):format(msg))
	end
end)

RegisterServerEvent('esx:triggerServerCallback')
AddEventHandler('esx:triggerServerCallback', function(name, requestId, ...)
	local playerId = source

	ESX.TriggerServerCallback(name, requestId, playerId, function(...)
		TriggerClientEvent('esx:serverCallback', playerId, requestId, ...)
	end, ...)
end)
