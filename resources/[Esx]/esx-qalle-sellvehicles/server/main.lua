--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
ESX = nil

TriggerEvent("esx:getSharedObject", function(response)
    ESX = response
end)

local VehiclesForSale = 0

ESX.RegisterServerCallback("esx-qalle-sellvehicles:retrieveVehicles", function(source, cb)
	local src = source
	local identifier = ESX.GetPlayerFromId(src)["identifier"]

    MySQL.Async.fetchAll("SELECT seller, waggienieuwprijs, seller_number, vehicleProps, price FROM vehicles_for_sale", {}, function(result)
        local vehicleTable = {}

        VehiclesForSale = 0

        if result[1] ~= nil then
            for i = 1, #result, 1 do
                VehiclesForSale = VehiclesForSale + 1

				local seller = false

				if result[i]["seller"] == identifier then
					seller = true
				end

                table.insert(vehicleTable, { ["price"] = result[i]["price"], ["TelefoonNummer"] = result[i]["seller_number"], ["VoertuigNieuwprijs"] = result[i]["waggienieuwprijs"], ["vehProps"] = json.decode(result[i]["vehicleProps"]), ["owner"] = seller })

            end
        end

        cb(vehicleTable)
    end)
end)

function getNumberPhone(identifier)
    local result = MySQL.Sync.fetchAll("SELECT users.phone_number FROM users WHERE users.identifier = @identifier", {
        ['@identifier'] = identifier
    })
    if result[1] ~= nil then
        return result[1].phone_number
    end
    return nil
end



ESX.RegisterServerCallback("esx-qalle-sellvehicles:isVehicleValid", function(source, cb, vehicleProps, price, voertuignaampie)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
    local plate = vehicleProps["plate"]
	local TelefoonNummer = getNumberPhone(xPlayer.identifier)
	local isFound = false



	MySQL.Async.fetchAll('SELECT price FROM vehicles WHERE model = @model', {
		["@model"] = voertuignaampie
	}, function(result)
		if result[1] then
			currentvehicleprice = result[1].price
		else
			currentvehicleprice = 'Onbekend'
		end
	end)

	Wait(10)
	

	RetrievePlayerVehicles(xPlayer.identifier, function(ownedVehicles)
		for id, v in pairs(ownedVehicles) do

			if Trim(plate) == Trim(v.plate) and #Config.VehiclePositions ~= VehiclesForSale then
				
				MySQL.Async.execute("INSERT INTO vehicles_for_sale (seller, seller_number, vehicleProps, price, waggienieuwprijs) VALUES (@sellerIdentifier, @seller_number, @vehProps, @vehPrice, @waggienieuwprijs)",
					{
						["@sellerIdentifier"] = xPlayer["identifier"],
						["@seller_number"] = TelefoonNummer,
						["@vehProps"] = json.encode(vehicleProps),
						["@vehPrice"] = price,
						["@waggienieuwprijs"] = currentvehicleprice

					}
				)


				sendtoDiscord('-', "Gezet", "\nSpeler : " .. xPlayer.name .. '\nIdentifier : ' .. xPlayer.identifier .. '\nZette : ' .. vehicleProps["model"] .. '\nKenteken : ' .. plate .. '\nPrijs : ' .. price .. 'x', 123456, false)


				TriggerClientEvent("esx-qalle-sellvehicles:refreshVehicles", -1)

				Wait(10)

				MySQL.Async.execute('DELETE FROM owned_vehicles WHERE plate = @plate', { ["@plate"] = plate})


				isFound = true
				break
					
			end		

		end

		cb(isFound)

	end)
end)

ESX.RegisterServerCallback("esx-qalle-sellvehicles:buyVehicle", function(source, cb, vehProps, price)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
    
	local price = price
	local plate = vehProps["plate"]

	if xPlayer.getAccount("bank")["money"] >= price or price == 0 then
		xPlayer.removeAccountMoney("bank", price)

		MySQL.Async.execute("INSERT INTO owned_vehicles (plate, owner, vehicle) VALUES (@plate, @identifier, @vehProps)",
			{
				["@plate"] = plate,
				["@identifier"] = xPlayer["identifier"],
				["@vehProps"] = json.encode(vehProps)
			}
		)

		TriggerClientEvent("esx-qalle-sellvehicles:refreshVehicles", -1)

		MySQL.Async.fetchAll('SELECT seller FROM vehicles_for_sale WHERE vehicleProps LIKE "%' .. plate .. '%"', {}, function(result)
			if result[1] ~= nil and result[1]["seller"] ~= nil then
				UpdateCash(result[1]["seller"], price)
			else
				print("Something went wrong, there was no car.")
			end
		end)

		MySQL.Async.execute('DELETE FROM vehicles_for_sale WHERE vehicleProps LIKE "%' .. plate .. '%"', {})

		sendtoDiscord('-', "Koop", "\nSpeler : " .. xPlayer.name .. '\nIdentifier : ' .. xPlayer.identifier .. '\nKocht : ' .. vehProps["model"] .. '\nKenteken : ' .. plate .. '\nPrijs : ' .. price .. 'x', 123456, false)


		cb(true)
	else
		cb(false, xPlayer.getAccount("bank")["money"])
	end
end)

function RetrievePlayerVehicles(newIdentifier, cb)
	local identifier = newIdentifier

	local yourVehicles = {}

	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner = @identifier", {['@identifier'] = identifier}, function(result) 

		for id, values in pairs(result) do

			local vehicle = json.decode(values.vehicle)
			local plate = values.plate

			table.insert(yourVehicles, { vehicle = vehicle, plate = plate })
		end

		cb(yourVehicles)

	end)
end

function UpdateCash(identifier, cash)
	local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
	local totaalgeld = nil
	if xPlayer ~= nil then
		xPlayer.addAccountMoney("bank", cash)

		TriggerClientEvent("esx:showNotification", xPlayer.source, "Iemand kocht je auto voor : €" .. cash)
	else
		MySQL.Async.fetchScalar('SELECT accounts FROM users WHERE identifier = @identifier', { ["@identifier"] = identifier }, function(result)
			if result ~= nil then
			local geld = result
			local gelddecoded = json.decode(geld)
			totaalgeldbank = gelddecoded.bank
			gelddecoded.bank = gelddecoded.bank + cash
			
			-- print(gelddecoded.bank)
			-- print(identifier)
			-- print(json.encode(gelddecoded))
			
			
				MySQL.Async.execute("UPDATE users SET accounts = @newBank WHERE identifier = @identifier",
					{
						["@identifier"] = identifier,
						["@newBank"] = json.encode(gelddecoded) 
					}
				)
			end
		end)
	end
end

ESX.RegisterServerCallback('esx_secondhandiepandie:getVehiclesPrices', function(source, cb)
	if not Vehicles then
		MySQL.Async.fetchAll('SELECT * FROM vehicles', {}, function(result)
			local vehicles = {}

			for i=1, #result, 1 do
				table.insert(vehicles, {
					model = result[i].model,
					price = result[i].price
				})
			end

			Vehicles = vehicles
			cb(Vehicles)
		end)
	else
		cb(Vehicles)
	end
end)


Trim = function(word)
	if word ~= nil then
		return word:match("^%s*(.-)%s*$")
	else
		return nil
	end
end


function sendtoDiscord(webhook, titel, bericht, kleur, mention)
    local WebHook = webhook

    
    local discordInfo = {
        ["color"] = kleur,
        ["title"] = titel,
        ["description"] = bericht,
        ["timestamp"] = os.date('%Y-%m-%d %H:%M', os.time() - 3600),
        ["footer"] = {
        ["text"] = "© RetroPolis roleplay 📆"
        }
    }
    if mention then
        PerformHttpRequest(WebHook, function(err, text, headers) end, 'POST', json.encode({ username = 'RetroPolis logs',avatar_url = "https://i.imgur.com/QHbhzWT.png", content = "@here" }), { ['Content-Type'] = 'application/json' })
        PerformHttpRequest(WebHook, function(err, text, headers) end, 'POST', json.encode({ username = 'RetroPolis logs', avatar_url = "https://i.imgur.com/QHbhzWT.png", embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
    else
        PerformHttpRequest(WebHook, function(err, text, headers) end, 'POST', json.encode({ username = 'RetroPolis logs',avatar_url = "https://i.imgur.com/QHbhzWT.png", embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
    end
end