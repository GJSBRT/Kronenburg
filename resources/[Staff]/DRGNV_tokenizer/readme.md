-- Server
ESX.RegisterServerCallback('esx_vehicleshop:server:getVerifyToken', function(source, cb)
	local src = source
	local token, resourcename = exports['DRGNV_tokenizer']:generateToken(GetCurrentResourceName(), src)
	while token == nil do
		Wait(500)
	end
	cb(token, resourcename)
end)

RegisterServerEvent('esx_vehicleshop:setVehicleOwned')
AddEventHandler('esx_vehicleshop:setVehicleOwned', function (vehicleProps, token)
	local _source = source
	if not exports['DRGNV_tokenizer']:verifyToken(GetCurrentResourceName(), _source, token, "esx_vehicleshop:setVehicleOwned") then
		return
    end
end)

--------------------------------------------------------------
-- Client
ESX.TriggerServerCallback('esx_vehicleshop:server:getVerifyToken', function(token, eventname)
	verifyToken = token
	RegisterNetEvent(eventname)
	AddEventHandler(eventname, function(token)
		verifyToken = token
	end)
end)
	