local playersProcessingPoppyResin = {}
local maxperdag = 5000
local pickedtoday = 0

RegisterServerEvent('esx_retropluk:pickedUpPoppy')
AddEventHandler('esx_retropluk:pickedUpPoppy', function(token)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem('meth')
	local _source = source
	local random = math.random(1,4)

    if not exports['salty_tokenizer']:secureServerEvent(GetCurrentResourceName(), _source, token) then
		sendtoDiscord(webhook, "Trigger uitvoeren", "User: ".. xPlayer.name .."\nIdentifier: ".. xPlayer.identifier .."\nID:".. _source .."\nTrigger: esx_retropluk:pickedUpPoppy", 15158332, false)
		TriggerClientEvent('chat:addMessage', -1, {
			template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 157, 0, 0.6); border-radius: 3px;"><i class="fab fa-shield"></i> @{0}:<br> {1}</div>',
			args = { xPlayer.name, 'is helaas gepakt door de anticheat (Triggers Uitvoeren)' }
		  })
        return false
    end

	if xPlayer.getInventoryItem('meth').count <= 60 then
			if pickedtoday < maxperdag then
				xPlayer.addInventoryItem("meth", random)
				pickedtoday = pickedtoday + random
			else
				TriggerClientEvent('esx:showNotification', _source, ('Deze drugs zijn nog niet klaar om verzameld te worden!'))
			end
	else
		TriggerClientEvent('esx:showNotification', source, '~r~Je kan niet meer dragen')

	end
end)



function CancelProcessing(playerID)
	if playersProcessingPoppyResin[playerID] then
		ESX.ClearTimeout(playersProcessingPoppyResin[playerID])
		playersProcessingPoppyResin[playerID] = nil
	end
end

RegisterServerEvent('esx_retropluk:cancelProcessing')
AddEventHandler('esx_retropluk:cancelProcessing', function()
	CancelProcessing(source)
end)

AddEventHandler('esx:playerDropped', function(playerID, reason)
	CancelProcessing(playerID)
end)

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	CancelProcessing(source)
end)
