--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
local isInRagdoll = false

Citizen.CreateThread(function()
 while true do
    Citizen.Wait(10)
    if isInRagdoll then
      SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0)
    end
  end
end)

Citizen.CreateThread(function()
    while true do
    Citizen.Wait(0)
    if IsControlJustPressed(2, Config.RagdollKeybind) and GetLastInputMethod(2) and Config.RagdollEnabled and IsPedOnFoot(PlayerPedId()) then
        if isInRagdoll then
            isInRagdoll = false
        else
            isInRagdoll = true
            Wait(500)
        end
    end
  end
end)

-- STAAT UIT!!!!!!!!

