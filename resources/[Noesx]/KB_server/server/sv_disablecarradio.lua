--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
TriggerEvent('chat:addSuggestion', '/autoradio', 'Zet je voertuig radio aan of uit', {
    { name="aan", help="Zet je radio aan" },
    { name="uit", help="Zet je radio uit" }
})

RegisterCommand("autoradio", function(source, args, rawCommand)
    if (source > 0) then
        if args[1] == "aan" then
            TriggerClientEvent("carradio:enable", source)
            TriggerClientEvent('chat:addMessage', source, {
                template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.8); border-radius: 3px;"><i class="fas fa-cogs"></i> <b>^*Systeem^r:</b> Je voertuig\'s radio is <b>aangezet</b>!</div>'
            })
        else
            TriggerClientEvent("carradio:disable", source)
            TriggerClientEvent('chat:addMessage', source, {
                template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.8); border-radius: 3px;"><i class="fas fa-cogs"></i> <b>^*Systeem^r:</b> Je voertuig\'s radio is <b>uitgezet</b>!</div>'
            })
        end
    else
        print("This command was executed by the server console, RCON client, or a resource.")
    end
end, false)

RegisterServerEvent("baseevents:enteringVehicle")   
AddEventHandler("baseevents:enteringVehicle", function(targetVehicle, vehicleSeat, vehicleDisplayName)
    TriggerClientEvent("carradio:enteredveh", source, targetVehicle, vehicleSeat, vehicleDisplayName)
end)