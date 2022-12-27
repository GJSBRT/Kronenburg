--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
RegisterNetEvent("utk_hack:playSound")
AddEventHandler("utk_hack:playSound", function(name)
    local t = {transactionType = name}

    SendNuiMessage(json.encode(t))
end)