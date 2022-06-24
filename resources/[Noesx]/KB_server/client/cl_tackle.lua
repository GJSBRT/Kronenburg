local TackleKey = 243 -- Change to a number which can be found here: https://wiki.fivem.net/wiki/Controls
local TackleTime = 1500 -- In milliseconds

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedJumping(PlayerPedId()) and IsControlJustReleased(0, TackleKey) then
			if inVehicle then
				TriggerEvent('chatMessage', 'Tackle', {255, 255, 255}, 'U kan niet iemand onderscheppen in een voertuig')
			else
				local ForwardVector = GetEntityForwardVector(PlayerPedId())
				local Tackled = {}

				SetPedToRagdollWithFall(PlayerPedId(), 1500, 2000, 0, ForwardVector, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)

				while IsPedRagdoll(PlayerPedId()) do
					Citizen.Wait(0)
					for Key, Value in ipairs(GetTouchedPlayers()) do
						if not Tackled[Value] then
							Tackled[Value] = true
							TriggerServerEvent('Tackle:Server:TacklePlayer', GetPlayerServerId(Value), ForwardVector.x, ForwardVector.y, ForwardVector.z, GetPlayerName(PlayerId()))
						end
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
    while(true) do
        inVehicle = IsPedInAnyVehicle(PlayerPedId(), true)
        Citizen.Wait(500)
    end
end)



RegisterNetEvent('Tackle:Client:TacklePlayer')
AddEventHandler('Tackle:Client:TacklePlayer', function(ForwardVectorX, ForwardVectorY, ForwardVectorZ, Tackler)
	TriggerEvent('chatMessage', 'Tackle', {255, 0, 0}, Tackler .. ' heeft u getackled!')
	SetPedToRagdollWithFall(PlayerPedId(), TackleTime, TackleTime, 0, ForwardVectorX, ForwardVectorY, ForwardVectorZ, 10.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
end)

function GetPlayers()

    for player in ipairs(GetActivePlayers()) do
		local ped = GetPlayerPed(player)
		-- do stuff
	end


end

function GetTouchedPlayers()
    local TouchedPlayer = {}
    for Key, Value in ipairs(GetPlayers()) do
		if IsEntityTouchingEntity(PlayerPedId(), GetPlayerPed(Value)) then
			table.insert(TouchedPlayer, Value)
		end
    end
    return TouchedPlayer
end
