--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
local playerInjury = {}

function GetCharsInjuries(source)
    return playerInjury[source]
end

RegisterServerEvent('mythic_hospital:server:SyncInjuries')
AddEventHandler('mythic_hospital:server:SyncInjuries', function(data)
    playerInjury[source] = data
end)