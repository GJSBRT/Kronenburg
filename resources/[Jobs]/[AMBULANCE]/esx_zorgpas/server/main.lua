﻿--[[ 
	Kronenburg Roleplay
	Copyright © GJSBRT <g@gijs.eu>

	This project is licensed under the terms of the Apache License 2.0 license.
	https://choosealicense.com/licenses/apache-2.0/
]]
 
 
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)



RegisterServerEvent('esx_abbonomenten:ambulance:afgesloten')
AddEventHandler('esx_abbonomenten:ambulance:afgesloten', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeAccountMoney('bank', 750)
    TriggerEvent('esx_license:addLicense', source, 'healthcare', function()
    end)
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ambulance', function(account)
        account.addMoney(750)
    end)

end)




RegisterServerEvent('esx_abbonomenten:anwb:afgesloten')
AddEventHandler('esx_abbonomenten:anwb:afgesloten', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeAccountMoney('bank', 750)
    TriggerEvent('esx_license:addLicense', source, 'healthcare', function()
    end)
    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_mechanic', function(account)
        account.addMoney(750)
    end)
    
end)

