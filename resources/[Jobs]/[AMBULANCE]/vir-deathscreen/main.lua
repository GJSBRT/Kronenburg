--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
local isPlayerDead = false


Citizen.CreateThread(function()
    while true do
        if IsPlayerDead(PlayerId()) then
            if isPlayerDead == false then 
                isPlayerDead = true
                SendNUIMessage({
					setDisplay = true
				})
				DisableControlAction(1, 244, true)
            end
        else 
            if isPlayerDead == true then
                isPlayerDead = false
                SendNUIMessage({
					setDisplay = false
				})
				DisableControlAction(1, 244, false)
            end
        end
        Citizen.Wait(100)
    end
end)

Citizen.CreateThread(function()
    while true do
        if IsPlayerDead(PlayerId()) then
            TriggerEvent('LIFE_CL:Sound:PlayOnOne', 'death', 1.0)
        end
        Citizen.Wait(10000)
    end
end)