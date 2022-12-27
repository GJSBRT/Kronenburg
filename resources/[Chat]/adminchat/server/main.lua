--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
--[[

  Made with love by Cheleber, you can join my RP Server here: www.grandtheftlusitan.com
  You can add this lines do your esx_rpchat.

--]]

ESX 						   = nil
local Group 

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_chatforadmin:GetGroup', function(source, cb)
    local player = ESX.GetPlayerFromId(source)

    if player ~= nil then
        Group = player.getGroup()
        if Group ~= nil then 
            cb(Group)
        else
            cb("user")
        end
    else
        cb("user")
    end
end)

RegisterCommand('a', function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)
	Group = xPlayer.getGroup()
	if Group ~= 'user' then
		TriggerClientEvent("sendMessageAdmin", -1, source,  xPlayer.getName(), table.concat(args, " "))
	end	
end, false)
  