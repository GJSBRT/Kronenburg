
--- SERVER

ESX               = nil
local cars 		  = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_givecarkeys:requestPlayerCars', function(source, cb, plate)

	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll(
		'SELECT * FROM owned_vehicles WHERE owner = @identifier',
		{
			['@identifier'] = xPlayer.identifier
		},
		function(result)

			local found = false

			for i=1, #result, 1 do

				local vehicleProps = json.decode(result[i].vehicle)

				if trim(vehicleProps.plate) == trim(plate) then
					found = true
					break
				end

			end

			if found then
				cb(true)
			else
				cb(false)
			end

		end
	)
end)

RegisterServerEvent('esx_givecarkeys:frommenu')
AddEventHandler('esx_givecarkeys:frommenu', function ()
	TriggerClientEvent('esx_givecarkeys:keys', source)
end)

local webhook = "https://discord.com/api/webhooks/803467330507505704/tZVlj1CBp15pp0NSv3XiJ-DHgGu4NdWAT7EBWbkvwm24WLWixqhKqCwybnPnnFdvXMLJ"

RegisterServerEvent('esx_givecarkeys:setVehicleOwnedPlayerId')
AddEventHandler('esx_givecarkeys:setVehicleOwnedPlayerId', function (playerId, vehicleProps)
	local xPlayer = ESX.GetPlayerFromId(playerId)

	MySQL.Async.execute('UPDATE owned_vehicles SET owner=@owner WHERE plate=@plate',
	{
		['@owner']   = xPlayer.identifier,
		['@plate']   = vehicleProps.plate
	},

	function (rowsChanged)
		TriggerClientEvent('esx:showNotification', playerId, 'Je hebt een nieuw voertuig in bezit met het kenteken ~g~' ..vehicleProps.plate..'!', vehicleProps.plate)
	end)
	PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({embeds={{title = "Geefsleutel log", description = "**Speler** "..GetPlayerName(source).." **Heeft zijn autosleutels gegeven aan** "..GetPlayerName(playerId).."\n**Kenteken:** "..vehicleProps.plate.."", footer = { text = " © 𝘿𝙧𝙪𝙜𝙖𝙣𝙤𝙫#6843 "}, color=3066993}}}),  { ['Content-Type'] = 'application/json' })
end)

function trim(s)
    if s ~= nil then
		return s:match("^%s*(.-)%s*$")
	else
		return nil
    end
end



TriggerEvent('es:addCommand', 'geefsleutel', function(source, args, user)
TriggerClientEvent('esx_givecarkeys:keys', source)
end)