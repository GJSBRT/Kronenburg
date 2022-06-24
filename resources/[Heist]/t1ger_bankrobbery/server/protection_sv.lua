AddEventHandler('esx:playerLoaded', function(source)

			TriggerClientEvent('t1ger_bankrobbery:loadDataCL', source, Banks, Safes)

		end)

		

		RegisterServerEvent('t1ger_bankrobbery:loadDataSV')

		AddEventHandler('t1ger_bankrobbery:loadDataSV', function()

			TriggerClientEvent('t1ger_bankrobbery:loadDataCL', -1, Banks, Safes)

		end)

		

		-- inUse state:

		RegisterServerEvent('t1ger_bankrobbery:inUseSV')

		AddEventHandler('t1ger_bankrobbery:inUseSV', function(state)

			for i = 1, #Banks do

				Banks[i].InProgress = state

			end

			TriggerClientEvent('t1ger_bankrobbery:inUseCL', -1, state)

		end)

		

		RegisterServerEvent('t1ger_bankrobbery:KeypadStateSV')

		AddEventHandler('t1ger_bankrobbery:KeypadStateSV', function(type, id, state)

			local xPlayer = ESX.GetPlayerFromId(source)

			if type == "first" then

				Banks[id].keypads[1].hacked = state

			elseif type == "second" then

				Banks[id].keypads[2].hacked = state

			end	

			TriggerClientEvent('t1ger_bankrobbery:KeypadStateCL', -1, id, state, type)

		end)



		RegisterServerEvent('t1ger_bankrobbery:OpenVaultDoorSV')

		AddEventHandler('t1ger_bankrobbery:OpenVaultDoorSV', function(k,v,heading,amount)

			local xPlayer = ESX.GetPlayerFromId(source)

			TriggerClientEvent('t1ger_bankrobbery:OpenVaultDoorCL', -1, k,v,heading,amount)

		end)



		RegisterServerEvent('t1ger_bankrobbery:CloseVaultDoorSV')

		AddEventHandler('t1ger_bankrobbery:CloseVaultDoorSV', function(k,v,heading,amount)

			local xPlayer = ESX.GetPlayerFromId(source)

			TriggerClientEvent('t1ger_bankrobbery:CloseVaultDoorCL', -1, k,v,heading,amount)

		end)



		

		-- ## PACIFIC SAFE ## --

		RegisterServerEvent('t1ger_bankrobbery:pacificSafeSV')

		AddEventHandler('t1ger_bankrobbery:pacificSafeSV', function(id, state)

			local xPlayer = ESX.GetPlayerFromId(source)

			Banks[id].safe.cracked = state

			TriggerClientEvent('t1ger_bankrobbery:pacificSafeCL', -1, id, state)

		end)



		-- DeskDoor::

		RegisterServerEvent('t1ger_bankrobbery:deskDoorSV')

		AddEventHandler('t1ger_bankrobbery:deskDoorSV', function(id, state)

			local xPlayer = ESX.GetPlayerFromId(source)

			Banks[id].deskDoor.lockpicked = state

			TriggerClientEvent('t1ger_bankrobbery:deskDoorCL', -1, id, state)

		end)

		-- Open Door:

		RegisterServerEvent('t1ger_bankrobbery:OpenDeskDoorSV')

		AddEventHandler('t1ger_bankrobbery:OpenDeskDoorSV', function(k,v,heading,amount)

			local xPlayer = ESX.GetPlayerFromId(source)

			TriggerClientEvent('t1ger_bankrobbery:OpenDeskDoorCL', -1, k,v,heading,amount)

		end)

		-- Close Door:

		RegisterServerEvent('t1ger_bankrobbery:CloseDeskDoorSV')

		AddEventHandler('t1ger_bankrobbery:CloseDeskDoorSV', function(k,v,heading,amount)

			local xPlayer = ESX.GetPlayerFromId(source)

			TriggerClientEvent('t1ger_bankrobbery:CloseDeskDoorCL', -1, k,v,heading,amount)

		end)
		-- trigger function policeCount:

		getPoliceCount()