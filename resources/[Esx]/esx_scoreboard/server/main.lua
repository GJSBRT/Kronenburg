ESX = nil
PlayerCount = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		PlayerCount = {}

		for _, playerId in ipairs(GetPlayers()) do
			local xPlayer = ESX.GetPlayerFromId(playerId)

			if (xPlayer ~= nil) then 
				local JobName = xPlayer.getJob().name

				if (JobName ~= nil) then
					if (PlayerCount[JobName] == nil) then
						PlayerCount[JobName] = 1
					else
						PlayerCount[JobName] = PlayerCount[JobName] + 1
					end
				end

				if (PlayerCount["players"] == nil) then
					PlayerCount["players"] = 1
				else
					PlayerCount["players"] = PlayerCount["players"] + 1
				end
			end 
		end

		TriggerClientEvent("esx_scoreboard:updatePlayerCount", -1, PlayerCount)
	end
end)