--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
------------------------------------------
--	iEnsomatic RealisticVehicleFailure  --
------------------------------------------
--
--	Created by Jens Sandalgaard
--
--	This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
--
--	https://github.com/iEns/RealisticVehicleFailure
--

ESX = nil



TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local function checkWhitelist(id)
	for key, value in pairs(RepairWhitelist) do
		if id == value then
			return true
		end
	end	
	return false
end

RegisterServerEvent("monteur:go")
AddEventHandler("monteur:go", function()
	local src = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()

	local mecano = 0
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'mechanic' then
			mecano = mecano + 1
		end
	end
	if mecano == 0 then
		TriggerClientEvent("monteur:succes", src)
	else
		TriggerClientEvent("pNotify:SendNotification",  src, {
			text = "Er is ANWB in-dienst, je zult dus de wegenwacht moeten bellen!",
			type = "error",
			timeout = 6000,
			layout = "topCenter"
		})
	end
end)

ESX.RegisterServerCallback('failure:canAfford', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= 150 then
		xPlayer.removeMoney(150)
		cb(true)
	else
		cb(false)
	end
end)

--[[AddEventHandler('chatMessage', function(source, _, message)
	local msg = string.lower(message)
	local identifier = GetPlayerIdentifiers(source)[1]
	if msg == "/repair" then
		CancelEvent()
		if RepairEveryoneWhitelisted == true then
			TriggerClientEvent('iens:repair', source)
		else
			if checkWhitelist(identifier) then
				TriggerClientEvent('iens:repair', source)
			else
				TriggerClientEvent('iens:notAllowed', source)
			end
		end
	end
end)]]--

local everyoneAllowed = true
TriggerEvent('es:addCommand', 'repareer', function(source, args, user)
	TriggerClientEvent('iens:repair', source)
end)
