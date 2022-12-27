--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
RegisterNetEvent("gcPhone:tchat_receive")
AddEventHandler("gcPhone:tchat_receive", function(message)
  SendNUIMessage({event = 'tchat_receive', message = message})
end)

RegisterNetEvent("gcPhone:tchat_channel")
AddEventHandler("gcPhone:tchat_channel", function(channel, messages)
  SendNUIMessage({event = 'tchat_channel', messages = messages})
end)

RegisterNUICallback('tchat_addMessage', function(data, cb)
  TriggerServerEvent('gcPhone:tchat_addMessage', data.channel, data.message)
end)

RegisterNUICallback('tchat_getChannel', function(data, cb)
  TriggerServerEvent('gcPhone:tchat_channel', data.channel)
end)
