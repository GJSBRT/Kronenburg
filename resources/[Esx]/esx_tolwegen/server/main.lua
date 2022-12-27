--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

-- BILLS WITHOUT ESX_BILLING (START)
RegisterServerEvent('esx_speedcamera:BetaalTol')
AddEventHandler('esx_speedcamera:BetaalTol', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeAccountMoney('bank', 150)

	TriggerClientEvent('esx:showNotification', source, 'je betaalde ~r~€150,-~w~ Betaald aan tol')
	TriggerEvent("bank:addtransaction", source, 150, "Grens tol", 1)

end)



RegisterServerEvent('esx_speedcamera:ControleerVoertuig')
AddEventHandler('esx_speedcamera:ControleerVoertuig', function(kenteken, grenspost)
	if grenspost == 'west' then
		tekst = 'Een voertuig met kenteken : ~r~' .. kenteken .. '~w~ is gezien bij de ~g~westelijke grenspost'
	else
		tekst = 'Een voertuig met kenteken : ~r~' .. kenteken .. '~w~ is gezien bij de ~g~oostelijke grenspost'
	end
	
	MySQL.Async.fetchAll('SELECT * FROM veh_gezocht WHERE kenteken = @kenteken', {
		['@kenteken'] = kenteken
	}, function(result)
		if result[1] then
			local xPlayers = ESX.GetPlayers()
			for i=1, #xPlayers, 1 do
				local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
				if xPlayer.job.name == 'police' then
					TriggerClientEvent('esx_speedcamera:setcopnotification', xPlayers[i], tekst)
				end
			end
		end
	end)
end)



RegisterServerEvent('esx_speedcamera:addkentekenserver')
AddEventHandler('esx_speedcamera:addkentekenserver', function(kenteken)

	MySQL.Async.execute('INSERT INTO veh_gezocht (kenteken, datum) VALUES (@kenteken, @datum)', {
		['@kenteken'] = kenteken,
		['@datum'] = 'huts'
	})

end)

RegisterServerEvent('esx_speedcamera:Removekentekenserver')
AddEventHandler('esx_speedcamera:Removekentekenserver', function(kenteken)
	MySQL.Async.execute('DELETE from veh_gezocht WHERE kenteken = @kenteken', {
		['@kenteken'] = kenteken
	})
end)

ESX.RegisterServerCallback('esx_speedcamera:GetKenteken', function(source, cb, kenteken)
	MySQL.Async.fetchAll('SELECT kenteken FROM veh_gezocht WHERE kenteken = @kenteken', {
		['@kenteken'] = kenteken
	}, function(result)
		if result[1] then
			cb(false)
		else
			cb(true)
		end
	end)
end)

