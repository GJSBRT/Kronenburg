--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
RegisterCommand("cam", function(source, args, raw)
    local src = source
    TriggerClientEvent("Cam:ToggleCam", src)
end)

RegisterCommand("bmic", function(source, args, raw)
    local src = source
    TriggerClientEvent("Mic:ToggleBMic", src)
end)

RegisterCommand("mic", function(source, args, raw)
    local src = source
    TriggerClientEvent("Mic:ToggleMic", src)
end)
