--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
RegisterNetEvent("delallveh")
AddEventHandler("delallveh", function ()
    TriggerEvent('chat:addMessage',{
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 0, 0, 0.6); border-radius: 3px;"><i class="fas fa-exclamation-triangle"></i> CAR-CLEANUP <i class="fas fa-exclamation-triangle"></i><br>Alle voertuigen worden over 2 minuten verwijderd. Als je in je voertuig zit despawned die NIET. Dus zorg ervoor dat je in je voertuig gaat zitten!</div>',
    })
    Citizen.Wait(60000)                                                                         --- Time before the cleanup is done 30 000 = 30 seconds
    TriggerEvent('chat:addMessage',{
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 0, 0, 0.6); border-radius: 3px;"><i class="fas fa-exclamation-triangle"></i> CAR-CLEANUP <i class="fas fa-exclamation-triangle"></i><br>1 minuut tot car cleanup!</div>',
    })
    Citizen.Wait(30000) 
    TriggerEvent('chat:addMessage',{
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 0, 0, 0.6); border-radius: 3px;"><i class="fas fa-exclamation-triangle"></i> CAR-CLEANUP <i class="fas fa-exclamation-triangle"></i><br>30 seconden tot car cleanup!</div>',
    })
    Citizen.Wait(20000) 
    TriggerEvent('chat:addMessage',{
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 0, 0, 0.6); border-radius: 3px;"><i class="fas fa-exclamation-triangle"></i> CAR-CLEANUP <i class="fas fa-exclamation-triangle"></i><br>10 seconden tot car cleanup!</div>',
    })
    Citizen.Wait(10000) 
    for vehicle in EnumerateVehicles() do
        if (not IsPedAPlayer(GetPedInVehicleSeat(vehicle, -1))) then 
            SetVehicleHasBeenOwnedByPlayer(vehicle, false) 
            SetEntityAsMissionEntity(vehicle, false, false) 
            DeleteVehicle(vehicle)
            if (DoesEntityExist(vehicle)) then 
                DeleteVehicle(vehicle) 
            end
        end
    end
    TriggerEvent('chat:addMessage',{
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(55, 166, 88, 0.6); border-radius: 3px;"><i class="fas fa-exclamation-triangle"></i> CAR-CLEANUP <i class="fas fa-exclamation-triangle"></i><br>Car cleanup succesvol!</div>',
    })
end)