ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_outlawalert:carJackInProgress')
AddEventHandler('esx_outlawalert:carJackInProgress', function(targetCoords, streetName, vehicleLabel, playerGender)
    mytype = 'police'
    data = {["code"] = '10-16', ["name"] = 'Theft Of A '..vehicleLabel..'.', ["loc"] = streetName}
    length = 3500
    TriggerClientEvent('esx_outlawalert:outlawNotify', -1, mytype, data, length)
    TriggerClientEvent('esx_outlawalert:combatInProgress', -1, targetCoords)
    TriggerClientEvent('esx_outlawalert:carJackInProgress', -1, targetCoords)
end, false)

RegisterServerEvent('esx_outlawalert:fireinthehole')
AddEventHandler('esx_outlawalert:fireinthehole', function(targetCoords, streetName, playerGender)
	mytype = 'police'
    data = {["code"] = '54', ["name"] = 'Er is brand!', ["loc"] = streetName}
    length = 18500
    TriggerClientEvent('esx_outlawalert:notifyBrand', -1, mytype, data, length)
    TriggerClientEvent('esx_outlawalert:brandInProgress', -1, targetCoords)
end, false)

RegisterServerEvent('esx_outlawalert:combatInProgress')
AddEventHandler('esx_outlawalert:combatInProgress', function(targetCoords, streetName, playerGender)
	mytype = 'police'
    data = {["code"] = '10-10', ["name"] = 'fight in progress', ["loc"] = streetName}
    length = 3500
    TriggerClientEvent('esx_outlawalert:outlawNotify', -1, mytype, data, length)
    TriggerClientEvent('esx_outlawalert:combatInProgress', -1, targetCoords)
end, false)

RegisterServerEvent('esx_outlawalert:gunshotInProgress')
AddEventHandler('esx_outlawalert:gunshotInProgress', function(targetCoords, streetName, playerGender)
	mytype = 'police'
    data = {["code"] = '10-11', ["name"] = 'gunshot in progress', ["loc"] = streetName}
    length = 3500
    TriggerClientEvent('esx_outlawalert:outlawNotify', -1, mytype, data, length)
    TriggerClientEvent('esx_outlawalert:gunshotInProgress', -1, targetCoords)
end, false)

RegisterServerEvent('esx_outlawalert:woninginbraak')
AddEventHandler('esx_outlawalert:woninginbraak', function(targetCoords, streetName, playerGender)
	mytype = 'inbraak'
    data = {["code"] = 'PRIO1', ["name"] = ' Woninginbraak!', ["loc"] = streetName}
    length = 3500
    TriggerClientEvent('esx_outlawalert:outlawNotify', -1, mytype, data, length)
    TriggerClientEvent('esx_outlawalert:woninginbraak', -1, targetCoords)
end, false)


RegisterServerEvent('esx_outlawalert:atmRobbery')
AddEventHandler('esx_outlawalert:atmRobbery', function(targetCoords, streetName, playerGender)
	mytype = 'police'
    data = {["code"] = '207', ["name"] = ' Pinautomaat wordt nu gekraakt!', ["loc"] = streetName}
    length = 8500
    TriggerClientEvent('esx_outlawalert:outlawNotify', -1, mytype, data, length)
    TriggerClientEvent('esx_outlawalert:atmrob', -1, targetCoords)
end, false)
RegisterServerEvent('esx_outlawalert:atmRobbery2')
AddEventHandler('esx_outlawalert:atmRobbery2', function(targetCoords, streetName, playerGender)
	mytype = 'police'
    data = {["code"] = '207', ["name"] = ' Pinautomaat is nu gekraakt!', ["loc"] = streetName}
    length = 8500
    TriggerClientEvent('esx_outlawalert:outlawNotify', -1, mytype, data, length)
    TriggerClientEvent('esx_outlawalert:atmrob', -1, targetCoords)
end, false)
RegisterServerEvent('esx_outlawalert:bankoverval')
AddEventHandler('esx_outlawalert:bankoverval', function(targetCoords, streetName, playerGender)
	mytype = 'bankoverval'
    data = {["code"] = 'PRIO1', ["name"] = ' Bankoverval!', ["loc"] = streetName}
    length = 3500
    TriggerClientEvent('esx_outlawalert:outlawNotify', -1, mytype, data, length)
    TriggerClientEvent('esx_outlawalert:grotebankoverval', -1, targetCoords)
end, false)

ESX.RegisterServerCallback('esx_outlawalert:isVehicleOwner', function(source, cb, plate)
	local identifier = GetPlayerIdentifier(source, 0)

	MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE owner = @owner AND plate = @plate', {
		['@owner'] = identifier,
		['@plate'] = plate
	}, function(result)
		if result[1] then
			cb(result[1].owner == identifier)
		else
			cb(false)
		end
	end)
end)
