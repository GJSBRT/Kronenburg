--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
-----[ CODE, DON'T TOUCH THIS ]-------------------------------------------
RegisterServerEvent('va:getPlayerIdentifiers')
AddEventHandler('va:getPlayerIdentifiers', function()
    if GetPlayerIdentifiers(source) ~= nil then
        TriggerClientEvent('va:setPlayerIdentifiers', source, GetPlayerIdentifiers(source))
    end
end)
--------------------------------------------------------------------------