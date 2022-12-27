--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
local ESX = nil
-- ESX
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback("idcard:isCasinoVIP", function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(target)
		
	MySQL.Async.fetchAll(
		'SELECT COUNT(*) as count FROM user_licenses WHERE type = @type AND owner = @owner',
		{
			['@type']  = 'casinovip',
			['@owner'] = xPlayer.identifier
		},
		function(result)
			if result ~= nil then
				if tonumber(result[1].count) > 0 then
					cb(true)
				else
					cb(false)
				end
			else
				cb(false)
			end

		end
	)
end)

-- Open ID card
RegisterServerEvent('jsfour-idcard:open')
AddEventHandler('jsfour-idcard:open', function(ID, targetID, type)
	local xPlayer = ESX.GetPlayerFromId(ID)
	local identifier = xPlayer.identifier
	local _source 	 = ESX.GetPlayerFromId(targetID).source
	local show       = false
	
	if type == 'casinoVIP' then
		if xPlayer then
			local VIPItem = xPlayer.getInventoryItem('casinovip')
			if VIPItem ~= nil and VIPItem ~= false and VIPItem.count > 0 then
				show = true
			end
		end
	end



	MySQL.Async.fetchAll('SELECT firstname, lastname, dateofbirth, sex, height FROM users WHERE identifier = @identifier', {['@identifier'] = identifier},
	function (user)
		if (user[1] ~= nil) then
			MySQL.Async.fetchAll('SELECT type FROM user_licenses WHERE owner = @identifier', {['@identifier'] = identifier},
			function (licenses)
				if type ~= nil then
					for i=1, #licenses, 1 do
						if type == licenses[i].type then 
							show = true 
							if type == 'drive' then type = 'driver' end
							break
						-- elseif  then
						-- 	show = true
						-- 	type = 'driver' 
						-- 	break
						end
					end
				else
					show = true
				end

				if show then
					local array = {
						user = user,
						licenses = licenses
					}
					TriggerClientEvent('jsfour-idcard:open', _source, ID, array, type)
				else
					TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'Je hebt deze licentie niet.', length = 5000, style = { ['background-color'] = '#ff0000', ['color'] = '#ffffff' } })

				end
			end)
		end
	end)
end)
