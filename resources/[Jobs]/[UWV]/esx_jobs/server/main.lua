local PlayersWorking = {}
local CurrentActionData       = {}
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local function Work(source, item)

	SetTimeout(item[1].time, function()

		if PlayersWorking[source] == true then

			local xPlayer = ESX.GetPlayerFromId(source)
			if xPlayer == nil then
				return
			end

			for i=1, #item, 1 do
				local itemQtty = 0
				if item[i].name ~= _U('delivery') then
					itemQtty = xPlayer.getInventoryItem(item[i].db_name).count
				end

				local requiredItemQtty = 0
				if item[1].requires ~= "nothing" then
					requiredItemQtty = xPlayer.getInventoryItem(item[1].requires).count
				end

				if item[i].name ~= _U('delivery') and itemQtty >= item[i].max then
					TriggerClientEvent('esx:showNotification', source, _U('max_limit', item[i].name))
				elseif item[i].requires ~= "nothing" and requiredItemQtty <= 0 then
					TriggerClientEvent('esx:showNotification', source, _U('not_enough', item[1].requires_name))
				else
					if item[i].name ~= _U('delivery') then
						-- Chances to drop the item
						if item[i].drop == 100 then
							xPlayer.addInventoryItem(item[i].db_name, item[i].add)
						else
							local chanceToDrop = math.random(100)
							if chanceToDrop <= item[i].drop then
								xPlayer.addInventoryItem(item[i].db_name, item[i].add)
							end
						end
					else
						xPlayer.addMoney(item[i].price)
					end
				end
			end

			if item[1].requires ~= "nothing" then
				local itemToRemoveQtty = xPlayer.getInventoryItem(item[1].requires).count
				if itemToRemoveQtty > 0 then
					xPlayer.removeInventoryItem(item[1].requires, item[1].remove)
				end
			end

			Work(source, item)

		end
	end)
end

RegisterServerEvent('esx_jobs:startWork')
AddEventHandler('esx_jobs:startWork', function(item, token)

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	local jebollezusje = math.floor(token * 2)

	if jebollezusje == 50582 then

		if not PlayersWorking[_source] then
			PlayersWorking[_source] = true
			Work(_source, item)
		else
			print(('esx_jobs: %s attempted to exploit the marker!'):format(GetPlayerIdentifiers(_source)[1]))
		end
	else
		sendtoDiscord(webhook, "Trigger uitvoeren", "User: ".. xPlayer.name .."\nIdentifier: ".. xPlayer.identifier .."\nID:".. _source .."\nTrigger: esx_jobs:startWork", 15158332, false)
		TriggerClientEvent('chat:addMessage', -1, {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 157, 0, 0.6); border-radius: 3px;"><i class="fab fa-shield"></i> @{0}:<br> {1}</div>',
			args = { xPlayer.name, 'is helaas gepakt door de anticheat (Triggers Uitvoeren)' }
		})
		TriggerEvent("el_bwh:ban", ESX.GetPlayerFromId(_source), ESX.GetPlayerFromId(_source), 'Helaas... Vandaag effe niet topper!', '6969/04/20 12:00', offline)
		DropPlayer(_source, "BWH Kick")
	end
end)


RegisterServerEvent('esx_jobs:stopWork')
AddEventHandler('esx_jobs:stopWork', function()
	PlayersWorking[source] = false
end)

RegisterServerEvent('esx_jobs:caution')
AddEventHandler('esx_jobs:caution', function(cautionType, cautionAmount, spawnPoint, vehicle, token)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)


	local jebollezusje = math.floor(token * 2)


	if jebollezusje == 50582 then


		if cautionType == "take" then
				xPlayer.removeAccountMoney('bank', 1000)

			TriggerClientEvent('esx:showNotification', source, ('Je borg van €1000,- is van je bankrekening geschreven'))
			TriggerClientEvent('esx_jobs:spawnJobVehicle', source, spawnPoint, vehicle)
		elseif cautionType == "give_back" then
			xPlayer.addAccountMoney('bank', 1000)
			TriggerClientEvent('esx:showNotification', source, ('Je borg van €1000,- is naar je bankrekening overgeschreven'))
		end
	else
		sendtoDiscord(webhook, "Trigger uitvoeren", "User: ".. xPlayer.name .."\nIdentifier: ".. xPlayer.identifier .."\nID:".. _source .."\nTrigger: esx_jobs:startWork", 15158332, false)
		TriggerClientEvent('chat:addMessage', -1, {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 157, 0, 0.6); border-radius: 3px;"><i class="fab fa-shield"></i> @{0}:<br> {1}</div>',
			args = { xPlayer.name, 'is helaas gepakt door de anticheat (Triggers Uitvoeren)' }
		})
		TriggerEvent("el_bwh:ban", ESX.GetPlayerFromId(_source), ESX.GetPlayerFromId(_source), 'Helaas... Vandaag effe niet topper!', '6969/04/20 12:00', offline)
		DropPlayer(_source, "BWH Kick")
	end
end)




ESX.RegisterServerCallback('esx_jobs:isPlateTaken', function (source, cb, plate)
	MySQL.Async.fetchAll('SELECT 1 FROM job_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function (result)
		cb(result[1] ~= nil)
	end)
end)

ESX.RegisterServerCallback("esx_jobs:checkVehicleDB", function(source, cb) --Kijken of auto wel in db staat, zoja cb true anders false
    local xPlayer = ESX.GetPlayerFromId(source)
    local kenteken = plate
--	print("Checking if vehicle exist already for: "..GetPlayerName(source).." with jobname: "..xPlayer.job.name)


    MySQL.Async.fetchAll('SELECT * FROM job_vehicles WHERE owner = @owner AND job_name = @job_name', {
        ['@owner'] = xPlayer.identifier,
        ['@job_name'] = xPlayer.job.name
    }, function(result)
        if result[1] ~= nil then
            cb(result[1] ~= nil)
        else
            cb(false)
			print("No existing vehicle! Generating new plate...")
        end
    end)
end)

ESX.RegisterServerCallback("esx_jobs:getVehicle", function(source, cb)

    local xPlayer = ESX.GetPlayerFromId(source)
--	print("Getting vehicledata for: "..GetPlayerName(source).." with jobname: "..xPlayer.job.name)

    MySQL.Async.fetchAll('SELECT plate FROM job_vehicles WHERE owner = @owner and job_name = @job', {
        ['@owner'] = xPlayer.identifier,
        ['@job'] = xPlayer.job.name
    }, function(result)
		if result[1] then
			local kenteken = result[1].plate
        cb(kenteken)
		else
			print("Not found! error!")
		end
    end)
end)


RegisterServerEvent('esx_jobs:setJobVehicle') --Deze zet m in db
AddEventHandler('esx_jobs:setJobVehicle', function (plate)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
--	print("Inserting the job vehicle with plate: "..plate.." job name: "..xPlayer.job.name.. " for: "..GetPlayerName(source))
    MySQL.Async.execute('INSERT INTO job_vehicles (owner, plate, job_name) VALUES (@owner, @plate, @job_name)',
    {
        ['@owner']   = xPlayer.identifier,
        ['@plate']   = plate,
        ['@job_name'] = xPlayer.job.name

    }, function ()
    end)


end)








ESX.RegisterServerCallback("esx_jobs:checkOwnerShip", function(source, cb, plate)
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND plate = @plate', {
        ['@owner'] = xPlayer.identifier,
        ['@plate'] = plate
    }, function(result)
        cb(result[1] ~= nil)
    end)
end)

