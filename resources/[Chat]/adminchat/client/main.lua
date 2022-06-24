--[[

  Made with love by Cheleber, you can join my RP Server here: www.grandtheftlusitan.com
  You can add this lines do your esx_rpchat.

--]]

local UserGroup

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('sendMessageAdmin')
AddEventHandler('sendMessageAdmin', function(id, name, message)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(id)
	ESX.TriggerServerCallback('esx_chatforadmin:GetGroup', function(Group)
		UserGroup = Group
		if pid == myId then
			TriggerEvent('chatMessage', "", {255, 0, 0}, " [STAFF] | " .. name .."  "..":^0  " .. message)
		elseif UserGroup ~= 'user' and pid ~= myId then
			TriggerEvent('chatMessage', "", {255, 0, 0}, " [STAFF] | " .. name .."  "..":^0  " .. message)
		end
  end)
end)


