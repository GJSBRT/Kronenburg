Citizen.CreateThread(function()
	Citizen.Wait(5000)
	PlayerData = ESX.GetPlayerData()
end)

-- RegisterNetEvent('esx:setJob')
-- AddEventHandler('esx:setJob', function(job)
-- 	ESX.PlayerData.job = job

-- 	Citizen.Wait(5000)
-- 	PlayerData = ESX.GetPlayerData()
-- end)
RegisterCommand('brandweer', function(source, args)
	if PlayerData.job.name == 'brandweer' then
		TriggerServerEvent('brandweerbericht', args)

	else
	end
end, false)

RegisterCommand('politie', function(source, args)
	if PlayerData.job.name == 'police' then
		TriggerServerEvent('politiebericht', args)

	else
	end
end, false)

RegisterCommand('anwb', function(source, args)
	if PlayerData.job.name == 'mechanic' then
		TriggerServerEvent('anwbbericht', args)

	else
	end
end, false)

RegisterCommand('taxi', function(source, args)
	if PlayerData.job.name == 'taxi' then
		TriggerServerEvent('taxibericht', args)

	else
	end
end, false)

RegisterCommand('ambulance', function(source, args)
	if PlayerData.job.name == 'ambulance' then
		TriggerServerEvent('ambubericht', args)

	else
	end
end, false)

RegisterCommand('kmar', function(source, args)
	if PlayerData.job.name == 'kmar' then
		TriggerServerEvent('kmarbericht', args)

	else
	end
end, false)


--- Define exports
function PrintFancyMessage(name, message, formatting)
	formatting = formatting or {}
	formatting.r = formatting.r or 41
	formatting.g = formatting.g or 41
	formatting.b = formatting.b or 41
	formatting.a = formatting.a or 0.6

	local template = ('<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(%s, %s, %s, %s); border-radius: 8px;"><b>{0}:</b> {1}</div>'):format(formatting.r, formatting.g, formatting.b, formatting.a)

	TriggerEvent('chat:addMessage', {
		template = template,
		args = { name, message }
	})
end

exports('printToChat', PrintFancyMessage)
exports('PrintToChat', PrintFancyMessage)

RegisterCommand('notifytest', function()
	exports['mythic_notify']:DoVeryLongHudText('success', ('Test'))

	
	
	end, false)


