ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(7)
	end
end)

RegisterNetEvent("esx_scoreboard:updatePlayerCount")
AddEventHandler("esx_scoreboard:updatePlayerCount", function(PlayerCount)
	SendNUIMessage({
		action = 'updatePlayerCount',
		playercount   = PlayerCount
	})
	SetRichPresence(("%s Speler%s | IP: kbrp.nl"):format(PlayerCount["players"], PlayerCount["players"] > 1 and "s" or ""))
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(7)

		if IsControlJustReleased(0, 178) and IsInputDisabled(0) then
			ToggleScoreBoard()
			Citizen.Wait(200)

		-- D-pad up on controllers works, too!
		elseif IsControlJustReleased(0, 172) and not IsInputDisabled(0) then
			ToggleScoreBoard()
			Citizen.Wait(200)
		end
	end
end)

-- Close scoreboard when game is paused
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(300)

		if IsPauseMenuActive() and not IsPaused then
			IsPaused = true
			SendNUIMessage({
				action  = 'close'
			})
		elseif not IsPauseMenuActive() and IsPaused then
			IsPaused = false
		end
	end
end)

function ToggleScoreBoard()
	SendNUIMessage({
		action = 'toggle'
	})
end


Citizen.CreateThread(function()
	while true do
		SetDiscordAppId(856659505667768371)
		SetDiscordRichPresenceAsset('logo')
		SetDiscordRichPresenceAssetSmall('fivem')
		SetDiscordRichPresenceAssetSmallText('https://discord.gg/NQ5aVhD3Qw')
		SetDiscordRichPresenceAssetText('Kronenburg Roleplay')
		SetDiscordRichPresenceAction(0, "Discord", "https://kronenburgrp.nl/discord")  
		SetDiscordRichPresenceAction(1, "Meespelen", "fivem://connect/kbrp.nl:30120")	
		Citizen.Wait(60000)
	end
end)